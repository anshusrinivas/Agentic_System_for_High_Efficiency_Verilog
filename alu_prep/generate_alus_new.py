import os
import random
import hashlib
from datetime import datetime

# Configuration
OUTPUT_DIR = "generated_ALUs"
NUM_ALUS = 2000
START_INDEX = 1

# Create output directory
os.makedirs(OUTPUT_DIR, exist_ok=True)

# ALU operation groups
OPERATION_GROUPS = {
    'ARITHMETIC': {
        'ADD':    {'code': '0000', 'desc': 'Addition'},
        'SUB':    {'code': '0001', 'desc': 'Subtraction'},
        'MUL':    {'code': '0010', 'desc': 'Multiplication'},
        'DIV':    {'code': '0011', 'desc': 'Division'},
        'MIN':    {'code': '0100', 'desc': 'Minimum'},
        'MAX':    {'code': '0101', 'desc': 'Maximum'},
        'PASSB':  {'code': '0110', 'desc': 'Pass Through B'},
    },
    'LOGICAL': {
        'AND':    {'code': '0000', 'desc': 'Bitwise AND'},
        'OR':     {'code': '0001', 'desc': 'Bitwise OR'},
        'XOR':    {'code': '0010', 'desc': 'Bitwise XOR'},
        'NAND':   {'code': '0011', 'desc': 'Bitwise NAND'},
        'NOR':    {'code': '0100', 'desc': 'Bitwise NOR'},
        'XNOR':   {'code': '0101', 'desc': 'Bitwise XNOR'},
    },
    'SHIFTS': {
        'SLL':    {'code': '0000', 'desc': 'Shift Left Logical'},
        'SRL':    {'code': '0001', 'desc': 'Shift Right Logical'},
        'SRA':    {'code': '0010', 'desc': 'Shift Right Arithmetic'},
        'ROL':    {'code': '0011', 'desc': 'Rotate Left'},
        'ROR':    {'code': '0100', 'desc': 'Rotate Right'},
    },
    'COMPARISON': {
        'SLT':    {'code': '0000', 'desc': 'Set Less Than Signed'},
        'SLTU':   {'code': '0001', 'desc': 'Set Less Than Unsigned'},
        'SEQ':    {'code': '0010', 'desc': 'Set Equal'},
        'SNE':    {'code': '0011', 'desc': 'Set Not Equal'},
        'SGE':    {'code': '0100', 'desc': 'Set Greater Equal'},
        'SGT':    {'code': '0101', 'desc': 'Set Greater Than'},
    }
}

# Combine all operations into a single dictionary for easier access
ALL_OPERATIONS = {}
for group in OPERATION_GROUPS.values():
    ALL_OPERATIONS.update(group)

# Supported bit widths
BIT_WIDTHS = [8, 16, 32, 64, 128]

# Flag combinations
FLAG_COMBINATIONS = [
    {'carry': True, 'zero': True, 'overflow': True, 'sign': True},
    {'carry': True, 'zero': True, 'overflow': False, 'sign': True},
    {'carry': True, 'zero': True, 'overflow': True, 'sign': False},
    {'carry': True, 'zero': False, 'overflow': False, 'sign': False},
]

# ALU implementation styles
ALU_STYLES = [
    'STANDARD',      # Standard combinational ALU
    'PIPELINED',    # Pipelined with registers
    'FUNCTION',     # Using Verilog functions for complex operations
    'MODULAR',      # Split into separate modules for each operation type
    'OPTIMIZED'     # Pre-computed results and optimized paths
]

def generate_unique_id(bits, ops, flags, style):
    """Generate a unique ID based on ALU characteristics"""
    content = f"{bits}_{sorted([op for op in ops])}_{sorted([k for k,v in flags.items() if v])}_{style}"
    return hashlib.md5(content.encode()).hexdigest()[:8]

def get_random_ops_count():
    """Get a random number of operations to include"""
    weights = [0.2, 0.3, 0.3, 0.2]  # More likely to get mid-range values
    base_count = random.choices([4, 6, 8, 10], weights=weights)[0]
    return base_count + random.randint(0, 2)  # Add some variation

def get_style_specific_ops(style, all_ops):
    """Get a subset of operations based on ALU style"""
    all_ops_list = list(all_ops.keys())
    op_count = get_random_ops_count()
    
    if style == 'STANDARD':
        # Basic operations common to most ALUs
        standard_base = ['ADD', 'SUB', 'AND', 'OR']
    elif style == 'PIPELINED':
        # Focus on operations that benefit from pipelining
        standard_base = ['ADD', 'SUB', 'MUL']
    elif style == 'FUNCTION':
        # Complex operations that benefit from function definitions
        standard_base = ['ROL', 'ROR', 'MAX', 'MIN']
    elif style == 'MODULAR':
        # Balanced mix of different operation types
        return random.sample(all_ops_list, min(op_count + 2, len(all_ops_list)))
    else:  # OPTIMIZED
        # Focus on frequently used operations with optimized implementations
        standard_base = ['ADD', 'SUB', 'AND', 'OR', 'SLL']
    
    # For all styles except MODULAR, add additional operations
    remaining = [op for op in all_ops_list if op not in standard_base]
    additional_count = max(0, min(op_count - len(standard_base), len(remaining)))
    additional = random.sample(remaining, additional_count) if additional_count > 0 else []
    return standard_base + additional

def generate_standard_operations(bit_width, selected_ops, flags):
    """Generate standard combinational operation implementations"""
    ops = []
    for op in selected_ops:
        if op == 'ADD':
            ops.extend([
                f"            ADD: begin",
                f"                result = input1 + input2;",
                f"                {f'overflow = (input1[{bit_width-1}] == input2[{bit_width-1}]) && (result[{bit_width-1}] != input1[{bit_width-1}]);' if flags['overflow'] else ''}",
                f"            end"
            ])
        elif op == 'SUB':
            ops.extend([
                f"            SUB: begin",
                f"                result = input1 - input2;",
                f"                {f'overflow = (input1[{bit_width-1}] != input2[{bit_width-1}]) && (result[{bit_width-1}] != input1[{bit_width-1}]);' if flags['overflow'] else ''}",
                f"            end"
            ])
        # ... Add other operations similarly
    return ops

def generate_alu(index, bit_width, selected_ops, flags, style):
    """Generate a single ALU module"""
    op_width = max(4, (len(selected_ops) - 1).bit_length())
    unique_id = generate_unique_id(bit_width, selected_ops, flags, style)
    module_name = f"ALU_{index:04d}W{bit_width}_{unique_id}"

    # Module header
    code = [
        f"`timescale 1ns / 1ps",
        f"",
        f"// Generated ALU Module",
        f"// Style: {style}",
        f"// Bit width: {bit_width}",
        f"// Operations: {', '.join(selected_ops)}",
        f"// Flags: {', '.join(k for k,v in flags.items() if v)}",
        f"",
        f"module {module_name}("
    ]

    # Module ports based on style
    if style == 'PIPELINED':
        code.extend([
            f"    input  wire             clk,",
            f"    input  wire             rst,",
        ])

    code.extend([
        f"    input  wire [{op_width-1}:0]  opcode,",
        f"    input  wire [{bit_width-1}:0] input1,",
        f"    input  wire [{bit_width-1}:0] input2,",
        f"    input  wire [4:0]       shiftValue,"
    ])

    # Add flag ports based on style and flags
    if style in ['STANDARD', 'FUNCTION']:
        code.append(f"    output wire [{bit_width-1}:0] result")
        if flags['carry']:
            code.append(f"    ,output wire carryFlag")
        if flags['zero']:
            code.append(f"    ,output wire zeroFlag")
        if flags['overflow']:
            code.append(f"    ,output wire overFlowFlag")
        if flags['sign']:
            code.append(f"    ,output wire signFlag")
    else:
        code.append(f"    output reg  [{bit_width-1}:0] result")
        if flags['carry']:
            code.append(f"    ,output reg  carryFlag")
        if flags['zero']:
            code.append(f"    ,output reg  zeroFlag")
        if flags['overflow']:
            code.append(f"    ,output reg  overFlowFlag")
        if flags['sign']:
            code.append(f"    ,output reg  signFlag")

    code.append(");")
    code.append("")

    # Add function definitions for FUNCTION style
    if style == 'FUNCTION':
        if 'ROL' in selected_ops:
            code.extend([
                f"    function [{bit_width-1}:0] rol;",
                f"        input [{bit_width-1}:0] a;",
                f"        input [4:0] sh;",
                f"        begin",
                f"            rol = (a << sh) | (a >> ({bit_width}-sh));",
                f"        end",
                f"    endfunction",
                ""
            ])
        if 'ROR' in selected_ops:
            code.extend([
                f"    function [{bit_width-1}:0] ror;",
                f"        input [{bit_width-1}:0] a;",
                f"        input [4:0] sh;",
                f"        begin",
                f"            ror = (a >> sh) | (a << ({bit_width}-sh));",
                f"        end",
                f"    endfunction",
                ""
            ])

    # Add operation parameters
    code.append("    // Operation codes")
    for i, op in enumerate(selected_ops):
        code.append(f"    localparam {op} = {op_width}'d{i};")
    code.append("")

    # Add wire declarations and assignments based on style
    if style in ['STANDARD', 'FUNCTION', 'OPTIMIZED']:
        if any(op in ['ADD', 'SUB'] for op in selected_ops):
            code.extend([
                f"    // Internal signals",
                f"    wire [{bit_width}:0] sum = (opcode == SUB) ? ",
                f"                             {{1'b0, input1}} - {{1'b0, input2}} : ",
                f"                             {{1'b0, input1}} + {{1'b0, input2}};",
                ""
            ])

    # Generate the main logic based on style
    if style == 'PIPELINED':
        # Add pipeline registers
        code.extend([
            f"    // Pipeline registers",
            f"    reg [{bit_width-1}:0] input1_r, input2_r;",
            f"    reg [{op_width-1}:0] opcode_r;",
            f"    reg [4:0] shiftValue_r;",
            f"",
            f"    always @(posedge clk or posedge rst) begin",
            f"        if (rst) begin",
            f"            input1_r <= {bit_width}'b0;",
            f"            input2_r <= {bit_width}'b0;",
            f"            opcode_r <= {op_width}'b0;",
            f"            shiftValue_r <= 5'b0;",
            f"            result <= {bit_width}'b0;",
        ])
        if flags['carry']:
            code.append(f"            carryFlag <= 1'b0;")
        if flags['zero']:
            code.append(f"            zeroFlag <= 1'b0;")
        if flags['overflow']:
            code.append(f"            overFlowFlag <= 1'b0;")
        if flags['sign']:
            code.append(f"            signFlag <= 1'b0;")
        code.extend([
            f"        end else begin",
            f"            input1_r <= input1;",
            f"            input2_r <= input2;",
            f"            opcode_r <= opcode;",
            f"            shiftValue_r <= shiftValue;",
            f"",
            f"            case (opcode_r)"
        ])
        # Generate pipelined operations
        for op in selected_ops:
            code.append(f"                {op}: begin")
            if op == 'ADD':
                code.extend([
                    f"                    {{carryFlag, result}} <= {{1'b0, input1_r}} + {{1'b0, input2_r}};",
                    f"                    {f'overFlowFlag <= (input1_r[{bit_width-1}] == input2_r[{bit_width-1}]) && (result[{bit_width-1}] != input1_r[{bit_width-1}]);' if flags['overflow'] else ''}"
                ])
            elif op == 'SUB':
                code.extend([
                    f"                    {{carryFlag, result}} <= {{1'b0, input1_r}} - {{1'b0, input2_r}};",
                    f"                    {f'overFlowFlag <= (input1_r[{bit_width-1}] != input2_r[{bit_width-1}]) && (result[{bit_width-1}] != input1_r[{bit_width-1}]);' if flags['overflow'] else ''}"
                ])
            elif op == 'AND':
                code.append(f"                    result <= input1_r & input2_r;")
            elif op == 'OR':
                code.append(f"                    result <= input1_r | input2_r;")
            elif op == 'XOR':
                code.append(f"                    result <= input1_r ^ input2_r;")
            elif op == 'XNOR':
                code.append(f"                    result <= ~(input1_r ^ input2_r);")
            elif op == 'NOR':
                code.append(f"                    result <= ~(input1_r | input2_r);")
            elif op == 'NAND':
                code.append(f"                    result <= ~(input1_r & input2_r);")
            elif op == 'SLL':
                code.append(f"                    result <= input1_r << shiftValue_r;")
            elif op == 'SRL':
                code.append(f"                    result <= input1_r >> shiftValue_r;")
            elif op == 'SRA':
                code.append(f"                    result <= $signed(input1_r) >>> shiftValue_r;")
            elif op == 'ROL':
                code.append(f"                    result <= rol(input1_r, shiftValue_r);")
            elif op == 'ROR':
                code.append(f"                    result <= ror(input1_r, shiftValue_r);")
            elif op == 'MAX':
                code.append(f"                    result <= (input1_r > input2_r) ? input1_r : input2_r;")
            elif op == 'MIN':
                code.append(f"                    result <= (input1_r < input2_r) ? input1_r : input2_r;")
            elif op == 'MUL':
                code.append(f"                    result <= input1_r * input2_r;")
            elif op == 'DIV':
                code.append(f"                    result <= (input2_r != 0) ? input1_r / input2_r : {bit_width}'b0;")
            elif op == 'PASSB':
                code.append(f"                    result <= input2_r;")
            code.append(f"                end")

    else:  # Non-pipelined styles
        code.extend([
            f"    // Combinational logic",
            f"    always @(*) begin",
            f"        case (opcode)"
        ])
        # Generate combinational operations
        for op in selected_ops:
            code.append(f"            {op}: begin")
            if op == 'ADD':
                code.extend([
                    f"                result = input1 + input2;",
                    f"                {f'overflow = (input1[{bit_width-1}] == input2[{bit_width-1}]) && (result[{bit_width-1}] != input1[{bit_width-1}]);' if flags['overflow'] else ''}"
                ])
            elif op == 'SUB':
                code.extend([
                    f"                result = input1 - input2;",
                    f"                {f'overflow = (input1[{bit_width-1}] != input2[{bit_width-1}]) && (result[{bit_width-1}] != input1[{bit_width-1}]);' if flags['overflow'] else ''}"
                ])
            elif op == 'AND':
                code.append(f"                result = input1 & input2;")
            elif op == 'OR':
                code.append(f"                result = input1 | input2;")
            elif op == 'XOR':
                code.append(f"                result = input1 ^ input2;")
            elif op == 'XNOR':
                code.append(f"                result = ~(input1 ^ input2);")
            elif op == 'NOR':
                code.append(f"                result = ~(input1 | input2);")
            elif op == 'NAND':
                code.append(f"                result = ~(input1 & input2);")
            elif op == 'SLL':
                code.append(f"                result = input1 << shiftValue;")
            elif op == 'SRL':
                code.append(f"                result = input1 >> shiftValue;")
            elif op == 'SRA':
                code.append(f"                result = $signed(input1) >>> shiftValue;")
            elif op == 'ROL':
                code.append(f"                result = rol(input1, shiftValue);")
            elif op == 'ROR':
                code.append(f"                result = ror(input1, shiftValue);")
            elif op == 'MAX':
                code.append(f"                result = (input1 > input2) ? input1 : input2;")
            elif op == 'MIN':
                code.append(f"                result = (input1 < input2) ? input1 : input2;")
            elif op == 'MUL':
                code.append(f"                result = input1 * input2;")
            elif op == 'DIV':
                code.append(f"                result = (input2 != 0) ? input1 / input2 : {bit_width}'b0;")
            elif op == 'PASSB':
                code.append(f"                result = input2;")
            code.append(f"            end")

    # Close the case statement and always block
    code.append("            default: result {} {}'b0;".format('<=' if style == 'PIPELINED' else '=', bit_width))
    code.append("        endcase")
    
    # Add flag assignments if needed
    if flags['zero'] and style != 'PIPELINED':
        code.append("        zeroFlag = (result == {}'b0);".format(bit_width))
    if flags['sign'] and style != 'PIPELINED':
        code.append("        signFlag = result[{}];".format(bit_width-1))
    
    # Close the always block and module
    code.append("    end")
    code.append("")
    code.append("endmodule")
 

    return "\n".join(code)

def main():
    """Generate multiple unique ALU designs"""
    print(f"Starting ALU generation at {datetime.now()}")
    print(f"Target: {NUM_ALUS} unique ALUs")
    
    generated_count = 0
    generated_designs = set()
    style_counts = {style: 0 for style in ALU_STYLES}
    
    # Calculate target counts for each style
    styles_per_type = NUM_ALUS // len(ALU_STYLES)
    style_targets = {style: styles_per_type for style in ALU_STYLES}
    # Add the remainder to random styles
    remainder = NUM_ALUS % len(ALU_STYLES)
    for style in random.sample(ALU_STYLES, remainder):
        style_targets[style] += 1
    
    while generated_count < NUM_ALUS:
        # Select style based on remaining targets
        available_styles = [s for s in ALU_STYLES if style_counts[s] < style_targets[s]]
        if not available_styles:
            break
        
        style = random.choice(available_styles)
        bit_width = random.choice(BIT_WIDTHS)
        selected_ops = get_style_specific_ops(style, ALL_OPERATIONS)
        flags = random.choice(FLAG_COMBINATIONS)
        
        # Generate unique ID for this combination
        design_id = generate_unique_id(bit_width, selected_ops, flags, style)
        
        # Skip if we've already generated this exact combination
        if design_id in generated_designs:
            continue
        
        generated_designs.add(design_id)
        generated_count += 1
        
        # Generate and save the ALU
        alu_code = generate_alu(generated_count, bit_width, selected_ops, flags, style)
        style_counts[style] += 1
        filename = os.path.join(OUTPUT_DIR, f"ALU_{generated_count:04d}W{bit_width}_{design_id}.v")
        
        with open(filename, 'w') as f:
            f.write(alu_code)
        
        if generated_count % 100 == 0:
            print(f"Generated {generated_count} ALUs...")
    
    print(f"\nCompleted ALU generation at {datetime.now()}")
    print(f"Generated {generated_count} unique ALUs in {OUTPUT_DIR}/")
    print("\nGeneration Statistics:")
    print(f"- Total ALUs: {generated_count}")
    print(f"- Unique combinations: {len(generated_designs)}")
    print("\nALU Styles Distribution:")
    for style, count in style_counts.items():
        percentage = (count / generated_count) * 100
        print(f"- {style}: {count} ({percentage:.1f}%)")

if __name__ == "__main__":
    main()