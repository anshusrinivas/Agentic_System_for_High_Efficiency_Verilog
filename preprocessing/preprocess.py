# """
# preprocess.py
# -------------
# LLM-powered multi-stage preprocessing for Verilog design datasets.

# Stages:
# 1. Functional Extraction  – parse module, ports, key operations
# 2. Style Analysis         – identify behavioral / structural / dataflow / hybrid style
# 3. Efficiency Evaluation  – analyze .rep reports and connect metrics to design characteristics
# 4. Merge Results          – store all info in JSON for later optimization

# Output: design_analysis_dataset.json
# """

# import os
# import json
# from openai import OpenAI
# from dotenv import load_dotenv
# # ========== CONFIG ==========
# load_dotenv()  # Load environment variables from .env file


# client = OpenAI(api_key=os.getenv('OPENROUTER_API_KEY'),
#                 base_url=os.getenv('OPENROUTER_BASE_URL'))  # <-- insert your key

# model=os.getenv('OPENROUTER_MODEL')


# BASE_DIR = os.path.dirname(__file__)
# VERILOG_DIR = os.path.join(BASE_DIR, "25_alus")
# POWER_DIR = os.path.join(BASE_DIR, "power")
# AREA_DIR = os.path.join(BASE_DIR, "area")
# GATE_DIR = os.path.join(BASE_DIR, "gate_count")
# OUTPUT_JSON = os.path.join(BASE_DIR, "design_analysis_dataset.json")
# # ============================


# def read_file(path: str) -> str:
#     try:
#         with open(path, "r", encoding="utf-8") as f:
#             return f.read()
#     except FileNotFoundError:
#         return ""


# # ---------------- STAGE 1 ----------------
# def call_functional_analysis(verilog_code: str) -> dict:
#     prompt = f"""
#     You are a Verilog expert. Analyze the module below and return a JSON with:
#     - module_name
#     - description
#     - inputs: list of {{name, width, type(if any)}}
#     - outputs: list of {{name, width, type(if any)}}
#     - key_operations: list of arithmetic / logic / control operations

#     Verilog code:{verilog_code}
#     Return only valid JSON.
#     """
#     r = client.chat.completions.create(
#         model=model,
#         temperature=0.1,
#         messages=[
#             {"role": "system", "content": "You are an expert Verilog analysis assistant."},
#             {"role": "user", "content": prompt}
#         ],
#     )
#     try:
#         return json.loads(r.choices[0].message.content)
#     except json.JSONDecodeError:
#         return {"raw_output": r.choices[0].message.content}


# # ---------------- STAGE 2 ----------------
# def call_style_analysis(verilog_code: str) -> dict:
#     prompt = f"""
#     Classify the following Verilog code's design style.

#     Return JSON with:
#     - design_style: one of ["behavioral", "dataflow", "structural", "hybrid"]
#     - style_characteristics: why you classified it that way
#     - optimizations_present: list of any efficiency or modularity features (parameterization, pipelining, clock gating, etc.)

#     Verilog code:{verilog_code}
#     Return only valid JSON.
#     """
#     r = client.chat.completions.create(
#         model=model,
#         temperature=0,
#        messages=[
#             {"role": "system", "content": "You are an expert Verilog design analysis assistant."},
#             {"role": "user", "content": prompt}
#         ],
#     )
#     try:
#         return json.loads(r.choices[0].message.content)
#     except json.JSONDecodeError:
#         return {"raw_output": r.choices[0].message.content}


# # ---------------- STAGE 2 ----------------
# def call_style_analysis(verilog_code: str) -> dict:
#     prompt = f"""
#     Classify the following Verilog code's design style.

#     Return JSON with:
#     - design_style: one of ["behavioral", "dataflow", "structural", "hybrid"]
#     - style_characteristics: why you classified it that way
#     - optimizations_present: list of any efficiency or modularity features (parameterization, pipelining, clock gating, etc.)

#     Verilog code:{verilog_code}
#     Return only valid JSON.
#     """
#     r = client.chat.completions.create(
#         model=model,
#         temperature=0,
#         messages=[
#             {"role": "system", "content": "You are an expert Verilog and VLSI analysis assistant."},
#             {"role": "user", "content": prompt}
#         ],
#     )
#     try:
#         return json.loads(r.choices[0].message.content)
#     except json.JSONDecodeError:
#         return {"raw_output": r.choices[0].message.content}


# # ---------------- STAGE 3 ----------------
# def call_efficiency_analysis(reports: dict, func_data: dict, style_data: dict) -> dict:
#     prompt = f"""
#     Analyze the following synthesis reports together with the functional and style information.

#     Return JSON with:
#     - efficiency_analysis: {{
#       "area": interpret area metrics,
#       "power": interpret power metrics,
#       "gate_count": interpret gate count,
#       "overall_efficiency": qualitative summary like "highly optimized" / "average" / "inefficient"
#     }}
#     - correlations: describe how the design style and structure might have influenced these metrics
#     - potential_improvements: list of 2–4 ideas to improve efficiency

#     Functional info:
#     {json.dumps(func_data, indent=2)}

#     Style info:
#     {json.dumps(style_data, indent=2)}

#     Reports:
#     {json.dumps(reports, indent=2)}

#     Return only valid JSON.
#     """
#     r = client.chat.completions.create(
#         model=model,
#         temperature=0,
#         messages=[
#             {"role": "system", "content": "You are an expert report analysis agent. You have to extract the required vales from the rports"},
#             {"role": "user", "content": prompt}
#         ],
#     )
#     try:
#         return json.loads(r.choices[0].message.content)
#     except json.JSONDecodeError:
#         return {"raw_output": r.choices[0].message.content}


# # ---------------- HELPERS ----------------
# # def parse_report(folder: str, name: str) -> dict:
# #     """Read .rep file for given design if present."""
# #     fpath = os.path.join(folder, f"{name}.rep")
# #     data = {}
# #     if os.path.exists(fpath):
# #         with open(fpath, "r", encoding="utf-8") as f:
# #             for line in f:
# #                 if ":" in line:
# #                     k, v = line.split(":", 1)
# #                     data[k.strip()] = v.strip()
# #     return data


# # ---------------- MAIN ----------------
# def main():
#     print("🚀 Multi-call Verilog preprocessing started...")
#     results = {}

#     for fname in os.listdir(VERILOG_DIR):
#         if not fname.endswith(".v"):
#             continue
#         name = fname.replace(".v", "")
#         print(f"🔍 Processing {name} ...")

#         verilog_code = read_file(os.path.join(VERILOG_DIR, fname))
#         area_file= os.path.join(AREA_DIR, f"{name}_area.rep")
#         power_file = os.path.join(POWER_DIR, f"{name}_power.rep")
#         gate_file = os.path.join(GATE_DIR, f"{name}_gate.rep")

#         area_report = read_file(area_file)
#         power_report = read_file(power_file)
#         gate_report = read_file(gate_file)
#         reports = {
#             "area_report": area_report,
#             "power_report": power_report,
#             "gate_count_report": gate_report,
#         }


#         # Stage 1
#         func_data = call_functional_analysis(verilog_code)
#         # Stage 2
#         style_data = call_style_analysis(verilog_code)
#         # Stage 3
#         eff_data = call_efficiency_analysis(reports, func_data, style_data)

#         results[name] = {
#             "functional_analysis": func_data,
#             "style_analysis": style_data,
#             "efficiency_analysis": eff_data,
#             "raw_reports": reports,
#         }

#     with open(OUTPUT_JSON, "w", encoding="utf-8") as f:
#         json.dump(results, f, indent=4)

#     print(f"✅ All analyses complete. JSON saved to {OUTPUT_JSON}")


# if __name__ == "__main__":
#     main()

"""
preprocess_merged.py
--------------------
LLM-powered single-call preprocessing for Verilog design datasets.

Stages combined into ONE LLM call per Verilog module:
1. Functional Extraction
2. Style Analysis
3. Efficiency Evaluation (using .rep reports)

Output: design_analysis_dataset.json
"""

import os
import json
from openai import OpenAI
from dotenv import load_dotenv

# ================= CONFIG =================
load_dotenv()

client = OpenAI(
    api_key=os.getenv('OPENROUTER_API_KEY'),
    base_url=os.getenv('OPENROUTER_BASE_URL')
)
model = os.getenv('OPENROUTER_MODEL')

BASE_DIR = os.path.dirname(__file__)
VERILOG_DIR = os.path.join(BASE_DIR, "25_alus")
POWER_DIR = os.path.join(BASE_DIR, "power")
AREA_DIR = os.path.join(BASE_DIR, "area")
GATE_DIR = os.path.join(BASE_DIR, "gate_count")
OUTPUT_JSON = os.path.join(BASE_DIR, "design_analysis_dataset.json")
# ===========================================


def read_file(path: str) -> str:
    try:
        with open(path, "r", encoding="utf-8") as f:
            return f.read()
    except FileNotFoundError:
        return ""


def call_full_analysis(verilog_code: str, reports: dict) -> dict:
    """
    Perform all three analyses (functional, style, efficiency) in one LLM call.
    """
    prompt = f"""
    You are an expert in Verilog HDL and VLSI design.

    Analyze the following Verilog module and its synthesis reports.
    Return **one combined JSON** object with the following structure:

    {{
      "functional_analysis": {{
        "module_name": "...",
        "description": "...",
        "inputs": [{{"name": "...", "width": "...", "type": "..."}}],
        "outputs": [{{"name": "...", "width": "...", "type": "..."}}],
        "key_operations": ["add", "shift", "mux", ...]
      }},
      "style_analysis": {{
        "design_style": "behavioral | dataflow | structural | hybrid",
        "style_characteristics": "...",
        "optimizations_present": ["parameterization", "clock gating", ...]
      }},
      "efficiency_analysis": {{
        "area": "...",
        "power": "...",
        "gate_count": "...",
        "overall_efficiency": "highly optimized | average | inefficient",
        "correlations": "...",
        "potential_improvements": ["...", "..."]
      }}
    }}

    Make sure it's valid JSON only — no explanations outside the JSON.

    -------------------------------
    Verilog Code:
    {verilog_code}
    -------------------------------
    Reports:
    {json.dumps(reports, indent=2)}
    """

    r = client.chat.completions.create(
        model=model,
        temperature=0,
        messages=[
            {"role": "system", "content": "You are a professional VLSI and Verilog analysis assistant."},
            {"role": "user", "content": prompt}
        ],
    )

    try:
        return json.loads(r.choices[0].message.content)
    except json.JSONDecodeError:
        # In case of partial JSON or formatting issues
        return {"raw_output": r.choices[0].message.content}


def main():
    print("🚀 Starting optimized preprocessing (single LLM call per design)...")
    results = {}

    for fname in os.listdir(VERILOG_DIR):
        if not fname.endswith(".v"):
            continue
        name = fname.replace(".v", "")
        print(f"🔍 Processing {name}...")

        verilog_code = read_file(os.path.join(VERILOG_DIR, fname))
        area_report = read_file(os.path.join(AREA_DIR, f"{name}_area.rep"))
        power_report = read_file(os.path.join(POWER_DIR, f"{name}_power.rep"))
        gate_report = read_file(os.path.join(GATE_DIR, f"{name}_gate.rep"))

        reports = {
            "area_report": area_report,
            "power_report": power_report,
            "gate_count_report": gate_report,
        }

        result = call_full_analysis(verilog_code, reports)
        results[name] = result

    with open(OUTPUT_JSON, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=4)

    print(f"✅ All analyses complete. JSON saved to {OUTPUT_JSON}")


if __name__ == "__main__":
    main()
