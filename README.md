# ⚙️ Agentic System for High-Efficiency Verilog Design Optimization  
> 🧠 **Multi-Agent AI Framework for Automated Verilog Analysis, Synthesis, and Efficiency Enhancement**

![Python](https://img.shields.io/badge/Python-3.10%2B-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![Verilog](https://img.shields.io/badge/Verilog-RTL%20Optimization-orange)

---

## 🧩 Overview  

This repository implements an **Agentic AI system** capable of analyzing, synthesizing, evaluating, and optimizing **Verilog HDL** designs.  
Each agent performs a specialized role — from code analysis to synthesis and optimization — under the control of a central **Coordinator Agent**.

The system uses **OpenRouter-connected LLMs** to generate insights and improve Verilog code efficiency (in power, area, and timing), producing a complete functional and style analysis in structured JSON format.

---

## 🏗️ Repository Structure  

```

AGENTIC_SYSTEM_FOR_HIGH_EFFICIENCY/
├── agents/                     # 🧠 Core multi-agent logic
│   ├── analysis_agent.py       # Parses Verilog, extracts modules, ports, ops
│   ├── code_agent.py           # Generates new optimized Verilog HDL
│   ├── coordinator.py          # Coordinates the agents and manages workflow
│   ├── evaluation_agent.py     # Evaluates generated code vs baseline
│   └── synthesis_agent.py      # Interfaces with synthesis tools for metrics

├── alu_prep/                   # ⚙️ ALU design generation and synthesis
│   ├── generated_ALUs/         # Stores generated ALU variants
│   ├── tcl_scripts/            # Vivado/Quartus TCL scripts for batch synthesis
│   │   ├── different_alu.py
│   │   ├── generate_alus_new.py
│   │   ├── prep_script.py
│   │   ├── run_synthesis.py
│   │   └── Script_file.tcl

├── preprocessing/              # 🔍 Dataset and metric preparation
│   ├── 25_alus/                # ALU dataset for analysis
│   ├── area/                   # Raw area metrics
│   ├── gate_count/             # Gate count per ALU
│   ├── power/                  # Power consumption metrics
│   ├── design_analysis_dataset.json  # Consolidated analysis results
│   └── preprocess.py           # Preprocessing pipeline

├── results/                    # 📊 Output directory (optimized Verilog + reports)
├── scripts/                    # Helper scripts for experiments
├── main.py                     # 🏁 Entry point for the full agentic workflow
├── requirements.txt            # Python dependencies
├── .env.example                # Example environment configuration
└── README.md                   # Documentation (you are here)

````

---

## ⚙️ Environment Setup  

### 1️⃣ Clone the Repository  

```bash
git clone https://github.com/anshusrinivas/agentic-system-for-high-efficiency.git
cd agentic-system-for-high-efficiency
````

### 2️⃣ Configure Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Then edit `.env` with your OpenRouter credentials:

```
OPENROUTER_BASE_URL=https://openrouter.ai/api/v1
OPENROUTER_MODEL=gpt-5
OPENROUTER_API_KEY=your_openrouter_api_key_here
```

### 3️⃣ Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 🚀 Usage

### ▶️ Run the Full Agentic System

```bash
python main.py
```

### 🧠 Run Only the Preprocessing Pipeline

```bash
python preprocessing/preprocess.py
```

### ⚙️ Generate and Synthesize ALUs

```bash
python alu_prep/tcl_scripts/run_synthesis.py
```

Results (optimized Verilog + JSON analysis) will appear in:

```
/results/
```

---

## 📊 Example Analysis Output

Each analyzed design is represented in `design_analysis_dataset.json` like this:

```json
{
  "alu1": {
    "functional_analysis": {
      "module_name": "ALU",
      "description": "32-bit combinational ALU supporting arithmetic, logical, shift, and set-less-than operations. Includes carry, zero, overflow, and sign flags.",
      "inputs": [
        {"name": "opcode", "width": "5", "type": "wire"},
        {"name": "input1", "width": "32", "type": "wire"},
        {"name": "input2", "width": "32", "type": "wire"}
      ],
      "outputs": [
        {"name": "result", "width": "32", "type": "reg"},
        {"name": "carryFlag", "width": "1", "type": "wire"},
        {"name": "zeroFlag", "width": "1", "type": "wire"}
      ],
      "key_operations": [
        "add", "sub", "shift", "mux", "bitwise_and", "bitwise_or"
      ]
    },
    "style_analysis": {
      "design_style": "hybrid",
      "style_characteristics": "Combines behavioral always block with case statement and continuous assignments.",
      "optimizations_present": [
        "parameterization via localparams",
        "combinational design for low latency"
      ]
    },
    "efficiency_analysis": {
      "area": "4858.541 µm²",
      "power": "2.22052e-04 W",
      "gate_count": "957",
      "overall_efficiency": "highly optimized",
      "correlations": "Area and power scale directly with gate count.",
      "potential_improvements": [
        "Remove unused inputs to reduce area",
        "Replace ripple-carry adder with carry-lookahead"
      ]
    }
  }
}
```

---

## 🧩 Agent Roles

| Agent                | Purpose     | Description                                                  |
| -------------------- | ----------- | ------------------------------------------------------------ |
| **CoordinatorAgent** | Controller  | Orchestrates workflow and communication between agents       |
| **AnalysisAgent**    | Analyzer    | Parses Verilog and extracts structure, operations, and style |
| **SynthesisAgent**   | Synthesizer | Runs synthesis via TCL scripts and collects metrics          |
| **EvaluationAgent**  | Evaluator   | Compares generated designs vs baseline thresholds            |
| **CodeAgent**        | Generator   | Generates new, more efficient Verilog designs                |

---

## 🧠 Core Concepts

* **Functional Analysis:** Extracts module structure, inputs, outputs, and key operations
* **Style Analysis:** Identifies HDL design style (behavioral, structural, dataflow, hybrid)
* **Efficiency Analysis:** Quantifies area, power, gate count, and correlations
* **Optimization Loop:** Generates and evaluates new Verilog code variants iteratively

---

## 🛠️ Requirements

Install via:

```bash
pip install -r requirements.txt
```

Key dependencies:

* `python-dotenv`, `openai` (OpenRouter-compatible client)
* `pyverilog` for HDL parsing
* `pandas`, `numpy`, `matplotlib` for data handling
* `rich`, `tqdm` for logs and progress
* `loguru` for structured logging

---

## 🧾 Citation

If you use this project in academic or research work, please cite:

```
@misc{anshu2025agenticverilog,
  title={Agentic System for High-Efficiency Verilog Design Optimization},
  author={Anshu Srinivas},
  year={2025},
  note={Department of ECE, GAT}
}
```

---

## 👨‍💻 Author

**Anshu Srinivas**
Department of Electronics and Communication Engineering
GAT | 2025

---

⭐ If you find this project useful, please **star** the repository and share your feedback!
🚀 Contributions and collaborations are always welcome.



