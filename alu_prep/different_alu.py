import os
import random
import hashlib
import platform
import subprocess

# ============================================================
# CONFIGURATION
# ============================================================

out_dir = "generated_Alu"   # Folder where all ALUs will be saved
os.makedirs(out_dir, exist_ok=True)

start_index = 26            # start numbering from ALU_0026
total_modules = 2000        # total number of ALUs
file_prefix = "ALU"         # base name prefix for files

# Base operations
base_ops = [
    "ADD", "SUB", "MUL", "DIV", "MOD", "INC", "DEC", "NEG", "ABS",
    "AND", "OR", "XOR", "XNOR", "NOR", "NAND", "NOT",
    "SHL", "SHR", "SAR", "ROL", "ROR",
    "GT", "LT", "EQ", "NEQ", "GE", "LE", "MAX", "MIN"
]

# Random operation sets
op_sets = []
while len(op_sets) < 300:
    r = random.choice(range(6, len(base_ops) + 1))
    subset = random.sample(base_ops, r)
    if subset not in op_sets:
        op_sets.append(subset)

# Flag options
flag_opts = [
    {"carry": c, "zero": z, "overflow": o}
    for c in [False, True]
    for z in [False, True]
    for o in [False, True]
]

# Pipeline options
pipeline_opts = [False, True]

# Bit widths
widths = [8, 16, 32, 64, 128]

# ============================================================
# HELPER FUNCTION
# ============================================================

def make_module_name(w, ops, flags, pipelined, index):
    """Create a unique ALU module name starting with a letter."""
    ops_tag = hashlib.md5("".join(sorted(ops)).encode()).hexdigest()[:4]
    flags_tag = "".join(k[0] for k, v in flags.items() if v) or "n"
    pipetag = "P" if pipelined else "NP"
    return f"ALU_{index:04d}W{w}{ops_tag}{flags_tag}{pipetag}"

# ============================================================
# GENERATE MODULES (ONE FILE PER MODULE)
# ============================================================

for i in range(start_index, start_index + total_modules):
    w = random.choice(widths)
    ops = random.choice(op_sets)
    flags = random.choice(flag_opts)
    pip = random.choice(pipeline_opts)

    name = make_module_name(w, ops, flags, pip, i)
    opcode_width = max(1, (len(ops) - 1).bit_length())

    file_name = os.path.join(out_dir, f"{name}.v")

    with open(file_name, "w") as f:
        # Header
        f.write(f"// ============================================================\n")
        f.write(f"// Automatically generated ALU module\n")
        f.write(f"// Name: {name}\n")
        f.write(f"// Width: {w}-bit | Pipeline: {pip} | Flags: {flags}\n")
        f.write(f"// ============================================================\n\n")

        # Module definition
        f.write(f"module {name} (\n")
        f.write(f"    input  wire clk,\n")
        f.write(f"    input  wire rst,\n")
        f.write(f"    input  wire [{w-1}:0] a,\n")
        f.write(f"    input  wire [{w-1}:0] b,\n")
        f.write(f"    input  wire [{opcode_width-1}:0] opcode,\n")
        f.write(f"    output reg  [{w-1}:0] result")
        if flags.get("carry"):
            f.write(",\n    output reg carry")
        if flags.get("zero"):
            f.write(",\n    output reg zero")
        if flags.get("overflow"):
            f.write(",\n    output reg overflow")
        f.write("\n);\n\n")

        # Pipeline registers
        if pip:
            f.write(f"    reg [{w-1}:0] a_reg, b_reg;\n")
            f.write(f"    reg [{opcode_width-1}:0] opcode_reg;\n\n")
            f.write(f"    always @(posedge clk or posedge rst) begin\n")
            f.write(f"        if (rst) begin\n")
            f.write(f"            a_reg <= {w}'b0;\n")
            f.write(f"            b_reg <= {w}'b0;\n")
            f.write(f"            opcode_reg <= {opcode_width}'b0;\n")
            if flags.get("carry"):
                f.write(f"            carry <= 1'b0;\n")
            if flags.get("zero"):
                f.write(f"            zero <= 1'b0;\n")
            if flags.get("overflow"):
                f.write(f"            overflow <= 1'b0;\n")
            f.write(f"            result <= {w}'b0;\n")
            f.write("        end else begin\n")
            f.write("            a_reg <= a;\n")
            f.write("            b_reg <= b;\n")
            f.write("            opcode_reg <= opcode;\n")
            f.write("        end\n")
            f.write("    end\n\n")
            a_var, b_var = "a_reg", "b_reg"
            op_var = "opcode_reg"
        else:
            a_var, b_var = "a", "b"
            op_var = "opcode"

        # ALU logic
        if pip:
            f.write("    always @(posedge clk or posedge rst) begin\n")
            f.write("        if (rst) begin\n")
            if flags.get("carry"):
                f.write("            carry <= 1'b0;\n")
            if flags.get("overflow"):
                f.write("            overflow <= 1'b0;\n")
            if flags.get("zero"):
                f.write("            zero <= 1'b0;\n")
            f.write(f"            result <= {w}'b0;\n")
            f.write("        end else begin\n")
        else:
            f.write("    always @(*) begin\n")
            if flags.get("carry"):
                f.write("        carry = 1'b0;\n")
            if flags.get("overflow"):
                f.write("        overflow = 1'b0;\n")
            if flags.get("zero"):
                f.write("        zero = 1'b0;\n")
        f.write(f"        case ({op_var})\n")

        for idx, op in enumerate(ops):
            f.write(f"            {opcode_width}'d{idx}: begin\n")
            # Define assignment operator for all operations
            assign = "<=" if pip else "="
            if op == "ADD":
                f.write(f"                result {assign} {a_var} + {b_var};\n")
                if flags.get("overflow"):
                    f.write(f"                overflow {assign} (~{a_var}[{w-1}] & ~{b_var}[{w-1}] & result[{w-1}]) |\n")
                    f.write(f"                           ({a_var}[{w-1}] & {b_var}[{w-1}] & ~result[{w-1}]);\n")
            elif op == "SUB":
                f.write(f"                result {assign} {a_var} - {b_var};\n")
            elif op == "MUL":
                f.write(f"                result {assign} {a_var} * {b_var};\n")
            elif op == "DIV":
                f.write(f"                result {assign} ({b_var} != 0) ? {a_var} / {b_var} : {{ {w}{{1'b0}} }};\n")
            elif op == "MOD":
                f.write(f"                result {assign} ({b_var} != 0) ? {a_var} % {b_var} : {{ {w}{{1'b0}} }};\n")
            elif op == "INC":
                f.write(f"                result {assign} {a_var} + 1;\n")
            elif op == "DEC":
                f.write(f"                result {assign} {a_var} - 1;\n")
            elif op == "NEG":
                f.write(f"                result {assign} -{a_var};\n")
            elif op == "ABS":
                f.write(f"                result {assign} {a_var}[{w-1}] ? -{a_var} : {a_var};\n")
            elif op == "AND":
                f.write(f"                result {assign} {a_var} & {b_var};\n")
            elif op == "OR":
                f.write(f"                result {assign} {a_var} | {b_var};\n")
            elif op == "XOR":
                f.write(f"                result {assign} {a_var} ^ {b_var};\n")
            elif op == "XNOR":
                f.write(f"                result {assign} ~({a_var} ^ {b_var});\n")
            elif op == "NOR":
                f.write(f"                result {assign} ~({a_var} | {b_var});\n")
            elif op == "NAND":
                f.write(f"                result {assign} ~({a_var} & {b_var});\n")
            elif op == "NOT":
                f.write(f"                result {assign} ~{a_var};\n")
            elif op == "SHL":
                f.write(f"                result {assign} {a_var} << 1;\n")
            elif op == "SHR":
                f.write(f"                result {assign} {a_var} >> 1;\n")
            elif op == "SAR":
                f.write(f"                result {assign} {{ {a_var}[{w-1}], {a_var}[{w-1}:1] }};\n")
            elif op == "ROL":
                f.write(f"                result {assign} {{ {a_var}[{w-2}:0], {a_var}[{w-1}] }};\n")
            elif op == "ROR":
                f.write(f"                result {assign} {{ {a_var}[0], {a_var}[{w-1}:1] }};\n")
            elif op in ["GT","LT","EQ","NEQ","GE","LE"]:
                cond_map = {"GT": ">", "LT": "<", "EQ": "==", "NEQ": "!=", "GE": ">=", "LE": "<="}
                f.write(f"                result {assign} ({a_var} {cond_map[op]} {b_var}) ? {{ {{({w-1}){{1'b0}}}}, 1'b1 }} : {{ {w}{{1'b0}} }};\n")
            elif op == "MAX":
                f.write(f"                result {assign} ({a_var} > {b_var}) ? {a_var} : {b_var};\n")
            elif op == "MIN":
                f.write(f"                result {assign} ({a_var} < {b_var}) ? {a_var} : {b_var};\n")
            else:
                f.write(f"                result {assign} {{ {w}{{1'b0}} }};\n")
            f.write("            end\n")

        f.write(f"            default: result = {{ {w}{{1'b0}} }};\n")
        f.write("        endcase\n")
        if flags.get("zero"):
            f.write("        zero = (result == 0);\n")
            if pip:
                f.write("        end\n")  # Close the else block for pipelined version
            f.write("    end\nendmodule\n\n")
    
    print(f"📝 Generated module {i}/{start_index + total_modules - 1}: {file_name}")

# ============================================================
# OPEN FOLDER IN FILE EXPLORER
# ============================================================

print(f"\n🎉 Successfully generated {total_modules} ALU modules in '{out_dir}' folder.\n")

# Open folder automatically (works on Windows, macOS, Linux)
system_name = platform.system()
try:
    if system_name == "Windows":
        os.startfile(os.path.abspath(out_dir))
    elif system_name == "Darwin":  # macOS
        subprocess.run(["open", os.path.abspath(out_dir)])
    else:  # Linux
        subprocess.run(["xdg-open", os.path.abspath(out_dir)])
except Exception as e:
    print(f"⚠ Could not open folder automatically: {e}")