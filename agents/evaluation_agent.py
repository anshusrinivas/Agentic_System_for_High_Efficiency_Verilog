from openai import OpenAI
import os
import json
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENROUTER_API_KEY"),
                 base_url=os.getenv("OPENROUTER_BASE_URL", "https://openrouter.ai/api/v1"))

model=os.getenv("OPENROUTER_MODEL")

class EvaluationAgent:
    """
    Evaluates synthesis metrics vs thresholds and generates LLM-based design feedback.
    """

    def __init__(self, thresholds):
        self.thresholds = thresholds

    def evaluate(self, alu_name, metrics):
        print(f"📏 Evaluating {alu_name}...")

        prompt = f"""
You are a digital design optimization assistant.
Given the following synthesis metrics and thresholds, determine pass/fail and improvement suggestions.

Metrics: {json.dumps(metrics, indent=2)}
Thresholds: {json.dumps(self.thresholds, indent=2)}

Output JSON:
{{
  "status": "PASS" or "FAIL",
  "failed_metrics": [],
  "recommendations": []
}}
"""

        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0.1
        )

        try:
            return json.loads(response.choices[0].message.content.strip())
        except Exception:
            return {"status": "FAIL", "failed_metrics": [], "recommendations": []}
