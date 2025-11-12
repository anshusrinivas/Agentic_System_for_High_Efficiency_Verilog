import os
from datetime import datetime
from agents.analysis_agent import AnalysisAgent
from agents.synthesis_agent import SynthesisAgent
from agents.evaluation_agent import EvaluationAgent
from agents.code_agent import CodeAgent

class CoordinatorAgent:
    """
    Orchestrates all agents in a ReAct optimization loop.
    """

    def __init__(self, dataset_path, alu_folder, thresholds, max_iterations=5):
        self.analysis_agent = AnalysisAgent(dataset_path)
        self.synthesis_agent = SynthesisAgent()
        self.evaluation_agent = EvaluationAgent(thresholds)
        self.code_agent = CodeAgent()
        self.alu_folder = alu_folder
        self.max_iterations = max_iterations
        os.makedirs("results/logs", exist_ok=True)
        self.log_path = os.path.join("results/logs", "run.log")

    def run(self):
        with open(self.log_path, "a") as log_file:
            start_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            log_file.write(f"\n=== Run started at {start_time} ===\n")

            alus = self.analysis_agent.get_alu_list()
            for alu in alus:
                alu_path = os.path.join(self.alu_folder, f"{alu}.v")
                if not os.path.exists(alu_path):
                    log_file.write(f"⚠️ {alu}.v not found, skipping.\n")
                    continue

                log_file.write(f"\n🚀 Starting optimization for {alu}\n")
                for iteration in range(1, self.max_iterations + 1):
                    log_file.write(f"\n🔁 Iteration {iteration} for {alu}\n")

                    analysis = self.analysis_agent.analyze(alu)
                    metrics = self.synthesis_agent.run_genus(alu_path, alu, iteration, log_file)
                    evaluation = self.evaluation_agent.evaluate(alu, metrics)

                    log_file.write(f"📈 Evaluation: {evaluation}\n")

                    if evaluation["status"] == "PASS":
                        log_file.write(f"✅ {alu} meets targets at iteration {iteration}\n")
                        break

                    hints = analysis["improvements"] + evaluation["recommendations"]
                    alu_path = self.code_agent.refactor_code(alu, iteration, alu_path, hints, log_file)

                log_file.write(f"🏁 Completed optimization for {alu}\n")
            log_file.write(f"=== Run completed ===\n")
