import os
import glob

# Path to the Verilog files
verilog_dir = "generated_Alu"
script_dir = "tcl_scripts"

# Create directory for TCL scripts if it doesn't exist
os.makedirs(script_dir, exist_ok=True)

# Read the template TCL script
with open("Script_file.tcl", "r") as f:
    template = f.read()

# Get all Verilog files
verilog_files = glob.glob(os.path.join(verilog_dir, "*.v"))

# Generate TCL script for each Verilog file
for verilog_file in verilog_files:
    base_name = os.path.splitext(os.path.basename(verilog_file))[0]
    
    # Create modified TCL script
    script_content = template.replace("alu25.v", f"{base_name}.v")
    # script_content = script_content.replace("alu25_dft.v", f"{base_name}_dft.v")
    # script_content = script_content.replace("alu25_dft.sdc", f"{base_name}_dft.sdc")
    script_content = script_content.replace("alu25_GateCount.rep", f"{base_name}_GateCount.rep")
    script_content = script_content.replace("alu25_power.rep", f"{base_name}_power.rep")
    script_content = script_content.replace("alu25_area.rep", f"{base_name}_area.rep")
    
    # Write the TCL script
    script_path = os.path.join(script_dir, f"{base_name}.tcl")
    with open(script_path, "w") as f:
        f.write(script_content)

print("Generated TCL scripts for all Verilog files")
