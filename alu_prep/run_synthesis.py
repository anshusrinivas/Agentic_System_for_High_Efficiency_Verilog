import os
import glob
import shutil
import subprocess
import time
import signal
import logging
from datetime import datetime

# Set up logging
log_dir = "synthesis_logs"
os.makedirs(log_dir, exist_ok=True)
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
log_file = os.path.join(log_dir, f"synthesis_run_{timestamp}.log")

# Configure logging to both file and console
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file),
        logging.StreamHandler()
    ]
)

# Create output directories
output_dirs = ["power_reports", "area_reports", "gate_count_reports", "failed_synthesis"]
for dir_name in output_dirs:
    os.makedirs(dir_name, exist_ok=True)

# Path to TCL scripts
script_dir = "tcl_scripts"

# Configuration
TIMEOUT_SECONDS = 1800  # 30 minutes timeout for each synthesis
SYNTHESIS_TOOL = "genus"  # Change this to match your synthesis tool

# Get all TCL script files
tcl_files = glob.glob(os.path.join(script_dir, "*.tcl"))
total_scripts = len(tcl_files)
failed_scripts = []

# Statistics tracking
successful_synthesis = []
synthesis_times = {}
synthesis_details = {}

# Process each TCL script
for index, tcl_file in enumerate(tcl_files, 1):
    base_name = os.path.splitext(os.path.basename(tcl_file))[0]
    logging.info(f"\nProcessing {base_name}... ({index}/{total_scripts})")
    
    try:
        # Create a temporary script with exit command at the end
        temp_script = f"{base_name}_temp.tcl"
        with open(tcl_file, 'r') as source, open(temp_script, 'w') as target:
            content = source.read()
            target.write(content)
            if not content.strip().endswith('exit'):
                target.write('\nexit\n')

        start_time = time.time()
        logging.info(f"Starting synthesis at {time.strftime('%H:%M:%S')}")
        
        # Run the synthesis tool with timeout
        try:
            process = subprocess.run(
                [SYNTHESIS_TOOL, "-f", temp_script],
                timeout=TIMEOUT_SECONDS,
                capture_output=True,
                text=True
            )
            success = process.returncode == 0
            
            # Log the output from the synthesis tool
            if process.stdout:
                logging.info("Synthesis Tool Output:")
                for line in process.stdout.splitlines():
                    logging.info(f"  {line}")
            if process.stderr:
                logging.warning("Synthesis Tool Errors:")
                for line in process.stderr.splitlines():
                    logging.warning(f"  {line}")
                    
        except subprocess.TimeoutExpired:
            logging.error(f"⚠️ Synthesis timeout after {TIMEOUT_SECONDS} seconds")
            failed_scripts.append((base_name, "timeout"))
            success = False
        
        end_time = time.time()
        duration = end_time - start_time
        synthesis_times[base_name] = duration
        
        if success:
            successful_synthesis.append(base_name)
            synthesis_details[base_name] = {"status": "success", "duration": duration}
        else:
            synthesis_details[base_name] = {"status": "failed", "duration": duration}
            
        logging.info(f"Synthesis completed in {duration:.1f} seconds")

        # Clean up temporary script
        os.remove(temp_script)

        if success:
            # Move reports to their respective folders if synthesis was successful
            for report_file, target_dir in [
                (f"{base_name}_power.rep", "power_reports"),
                (f"{base_name}_area.rep", "area_reports"),
                (f"{base_name}_GateCount.rep", "gate_count_reports")
            ]:
                if os.path.exists(report_file):
                    shutil.move(report_file, os.path.join(target_dir, report_file))
                else:
                    print(f"⚠️ Warning: {report_file} was not generated")
        else:
            # Move the script to failed_synthesis folder if synthesis failed
            failed_dest = os.path.join("failed_synthesis", os.path.basename(tcl_file))
            shutil.copy2(tcl_file, failed_dest)
            print(f"❌ Synthesis failed for {base_name}")

    except Exception as e:
        print(f"❌ Error processing {base_name}: {str(e)}")
        failed_scripts.append((base_name, str(e)))

# Calculate statistics
total_time = sum(synthesis_times.values())
avg_time = total_time / len(synthesis_times) if synthesis_times else 0
fastest_time = min(synthesis_times.values()) if synthesis_times else 0
slowest_time = max(synthesis_times.values()) if synthesis_times else 0
fastest_design = min(synthesis_times.items(), key=lambda x: x[1])[0] if synthesis_times else "None"
slowest_design = max(synthesis_times.items(), key=lambda x: x[1])[0] if synthesis_times else "None"

# Print and log final summary
summary = f"""
{"="*50}
Synthesis Run Summary
{"="*50}
Total scripts processed: {total_scripts}
Successfully completed: {len(successful_synthesis)}
Failed scripts: {len(failed_scripts)}
Success rate: {(len(successful_synthesis)/total_scripts)*100:.1f}%

Time Statistics:
---------------
Total synthesis time: {total_time/3600:.2f} hours
Average time per design: {avg_time:.1f} seconds
Fastest synthesis: {fastest_design} ({fastest_time:.1f} seconds)
Slowest synthesis: {slowest_design} ({slowest_time:.1f} seconds)

Failed Scripts Details:
---------------------"""

logging.info(summary)

if failed_scripts:
    for script, reason in failed_scripts:
        logging.info(f"- {script}: {reason}")
        if script in synthesis_details:
            details = synthesis_details[script]
            logging.info(f"  Duration: {details['duration']:.1f} seconds")

report_locations = f"""
Report Locations:
---------------
- Power reports: {os.path.abspath('power_reports')}
- Area reports: {os.path.abspath('area_reports')}
- Gate count reports: {os.path.abspath('gate_count_reports')}
- Synthesis log: {os.path.abspath(log_file)}"""

if failed_scripts:
    report_locations += f"\n- Failed synthesis scripts: {os.path.abspath('failed_synthesis')}"

logging.info(report_locations)

# Create a summary file in the log directory
summary_file = os.path.join(log_dir, f"synthesis_summary_{timestamp}.txt")
with open(summary_file, 'w') as f:
    f.write(summary)
    f.write("\n\nDetailed Synthesis Results:\n")
    f.write("-" * 40 + "\n")
    for design, details in sorted(synthesis_details.items()):
        f.write(f"{design}:\n")
        f.write(f"  Status: {details['status']}\n")
        f.write(f"  Duration: {details['duration']:.1f} seconds\n")
    f.write("\n" + report_locations)

logging.info(f"\nDetailed summary has been saved to: {summary_file}")