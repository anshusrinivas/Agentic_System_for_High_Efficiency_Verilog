import os
import subprocess
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENROUTER_API_KEY"),
                 base_url=os.getenv("OPENROUTER_BASE_URL", "https://openrouter.ai/api/v1"))

model=os.getenv("OPENROUTER_MODEL")

class SynthesisAgent:
    """
    Runs Genus synthesis individually for each ALU Verilog file.
    Uses LLM to parse synthesis reports (area, power, gate count).
    """

    def __init__(self, base_script_path="scripts/run_genus.tcl"):
        self.base_script_path = base_script_path

    def run_genus(self, alu_file):
        alu_name = os.path.splitext(os.path.basename(alu_file))[0]
        print(f"🧪 Running individual Genus synthesis for {alu_name}")

        # 1️⃣ Create a temporary TCL script for this ALU
        custom_tcl = f"scripts/tmp_{alu_name}.tcl"
        with open(self.base_script_path) as base:
            tcl_content = base.read()

        # replace target file name dynamically
        tcl_content = tcl_content.replace("alu25.v", alu_file)
        tcl_content = tcl_content.replace("alu25", alu_name)

        with open(custom_tcl, "w") as f:
            f.write(tcl_content)

        # 2️⃣ Run Genus individually (no batch mode)
        log_file = f"results/logs/{alu_name}_genus.log"
        os.makedirs("results/logs", exist_ok=True)

        cmd = ["genus", "-files", custom_tcl]
        with open(log_file, "w") as log:
            subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT)

        # 3️⃣ Use LLM to interpret report files
        report_paths = {
            "area": f"{alu_name}_area.rep",
            "power": f"{alu_name}_power.rep",
            "gate_count": f"{alu_name}_GateCount.rep"
        }

        # Combine all reports into a single context string
        reports_content = ""
        for name, path in report_paths.items():
            if os.path.exists(path):
                with open(path) as f:
                    content = f.read()
                    reports_content += f"\n\n=== {name.upper()} REPORT ===\n{content}"
            else:
                reports_content += f"\n\n=== {name.upper()} REPORT ===\n(Missing file)"

        # 4️⃣ Ask GPT-5 to interpret report metrics
        prompt = f"""
You are an expert in EDA synthesis reports.
Given the following Cadence Genus synthesis outputs, extract *only numeric values*
for these metrics (in JSON format):

- area (µm²)
- power (W)
- gate_count (integer)

If a value cannot be found, use null. 
Output strictly JSON.

Reports:
{reports_content}
"""

        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0.1
        )

        try:
            report_json = response.choices[0].message.content.strip()
            import json
            metrics = json.loads(report_json)
        except Exception:
            print("⚠️ Could not parse LLM response properly. Returning empty dict.")
            metrics = {}

        print(f"📈 Extracted metrics for {alu_name}: {metrics}")
        return metrics
