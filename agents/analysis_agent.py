import os
import subprocess
from openai import OpenAI
import json
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENROUTER_API_KEY"),
                 base_url=os.getenv("OPENROUTER_BASE_URL", "https://openrouter.ai/api/v1"))

model=os.getenv("OPENROUTER_MODEL")
class SynthesisAgent:
    """
    Runs Cadence Genus per ALU and uses GPT to extract metrics from reports.
    """

    def __init__(self, base_script="scripts/run_genus.tcl", results_dir="results/reports"):
        self.base_script = base_script
        self.results_dir = results_dir
        os.makedirs(self.results_dir, exist_ok=True)

    def run_genus(self, alu_file, alu_name, iteration, log_file):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        iter_dir = os.path.join(self.results_dir, alu_name, f"iter_{iteration}")
        os.makedirs(iter_dir, exist_ok=True)

        print(f"🧪 [{timestamp}] Running Genus for {alu_name} (iteration {iteration})")
        log_file.write(f"\n🧪 Running Genus for {alu_name}, iteration {iteration}\n")

        # Create dynamic TCL file
        custom_tcl = os.path.join(iter_dir, f"run_{alu_name}_iter{iteration}.tcl")
        with open(self.base_script) as base:
            tcl_content = base.read()
        tcl_content = tcl_content.replace("alu25.v", alu_file)
        tcl_content = tcl_content.replace("alu25", f"{alu_name}_iter{iteration}")
        with open(custom_tcl, "w") as f:
            f.write(tcl_content)

        log_path = os.path.join(iter_dir, f"{alu_name}_genus.log")
        subprocess.run(["genus", "-files", custom_tcl],
                       stdout=open(log_path, "w"),
                       stderr=subprocess.STDOUT)

        # Collect reports
        report_paths = {
            "area": os.path.join(iter_dir, f"{alu_name}_area.rep"),
            "power": os.path.join(iter_dir, f"{alu_name}_power.rep"),
            "gate_count": os.path.join(iter_dir, f"{alu_name}_GateCount.rep"),
        }

        combined = ""
        for name, path in report_paths.items():
            if os.path.exists(path):
                with open(path) as f:
                    combined += f"\n--- {name.upper()} REPORT ---\n{f.read()}"

        if not combined.strip():
            log_file.write(f"⚠️ No Genus reports found for {alu_name} iteration {iteration}\n")
            return {}

        # Use LLM to extract metrics
        prompt = f"""
Extract key synthesis metrics from this Cadence Genus report data.
Return JSON with: area, power, gate_count.

Reports:
{combined}
"""
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0.1
        )

        try:
            metrics = json.loads(response.choices[0].message.content.strip())
        except Exception:
            metrics = {}

        log_file.write(f"📊 Extracted metrics: {json.dumps(metrics, indent=2)}\n")
        return metrics
