import os
import subprocess
import sys
import importlib.util
from agents.coordinator import CoordinatorAgent

# =========================================================
# 1️⃣ AUTO-INSTALL FUNCTION
# =========================================================
def install_if_missing(packages):
    """
    Checks for required packages and installs if not found.
    """
    for pkg in packages:
        if importlib.util.find_spec(pkg) is None:
            print(f"📦 Installing missing package: {pkg}")
            subprocess.check_call([sys.executable, "-m", "pip", "install", pkg])
        else:
            print(f"✅ Package already installed: {pkg}")

# =========================================================
# 2️⃣ REQUIRED PYTHON DEPENDENCIES
# =========================================================
required_packages = [
    "openai",
    "jsonschema",
    "python-dotenv",
    
]
install_if_missing(required_packages)

# =========================================================
# 3️⃣ CHECK FOR CADENCE GENUS INSTALLATION
# =========================================================
def check_genus():
    try:
        result = subprocess.run(["which", "genus"], capture_output=True, text=True)
        if result.returncode != 0:
            print("❌ Cadence Genus not found in PATH.")
            print("👉 Please ensure Genus is installed and 'genus' command is accessible.")
            sys.exit(1)
        else:
            print(f"🧩 Found Genus at: {result.stdout.strip()}")
    except Exception as e:
        print(f"⚠️ Error checking Genus installation: {e}")
        sys.exit(1)

check_genus()

# =========================================================
# 4️⃣ ENVIRONMENT SETUP
# =========================================================
folders = [
    "results/logs",
    "results/reports",
    "results/verilog_versions"
]
for folder in folders:
    os.makedirs(folder, exist_ok=True)
    print(f"📁 Ensured directory exists: {folder}")

# =========================================================
# 5️⃣ VERIFY OPENAI API KEY
# =========================================================
# if not os.getenv("OPENAI_API_KEY"):
#     print("❌ Missing OPENAI_API_KEY environment variable.")
#     print("Please set it using:\n  export OPENAI_API_KEY='your-key-here'")
#     sys.exit(1)
# else:
#     print("🔑 OpenAI API key detected.")

# =========================================================
# 6️⃣ RUN THE MULTI-AGENT SYSTEM
# =========================================================
if __name__ == "__main__":
    thresholds = {
        "area": 4000,
        "power": 2e-4,
        "gate_count": 900
    }

    coordinator = CoordinatorAgent(
        dataset_path="preprocessing/design_analysis_dataset.json",
        alu_folder="preprocessing/25_alus",
        thresholds=thresholds,
        max_iterations=10
    )

    print("\n🚀 Starting AI-driven ALU Optimization System...\n")
    coordinator.run()
    print("\n✅ Optimization complete. Check results folder for logs, reports, and updated Verilog files.")
