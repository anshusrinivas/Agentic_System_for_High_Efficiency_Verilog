import os
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENROUTER_API_KEY"),
                 base_url=os.getenv("OPENROUTER_BASE_URL", "https://openrouter.ai/api/v1"))

model=os.getenv("OPENROUTER_MODEL")

class CodeAgent:
    """
    Refactors Verilog using GPT, guided by improvement hints.
    """

    def __init__(self, save_dir="results/verilog_versions"):
        self.save_dir = save_dir
        os.makedirs(self.save_dir, exist_ok=True)

    def refactor_code(self, alu_name, iteration, alu_path, improvement_hints, log_file):
        with open(alu_path) as f:
            original = f.read()

        prompt = f"""
You are a senior RTL engineer.
Given this Verilog ALU and the hints, refactor for better area/power efficiency 
without changing logic functionality.

Hints:
{improvement_hints}

Return only the final Verilog code.
"""
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0.3
        )

        new_code = response.choices[0].message.content.strip()

        alu_dir = os.path.join(self.save_dir, alu_name)
        os.makedirs(alu_dir, exist_ok=True)
        new_path = os.path.join(alu_dir, f"{alu_name}_iter_{iteration}.v")
        with open(new_path, "w") as f:
            f.write(new_code)

        log_file.write(f"💾 Saved updated Verilog at {new_path}\n")
        return new_path
