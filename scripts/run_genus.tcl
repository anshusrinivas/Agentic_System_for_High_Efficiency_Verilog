# RTL Script to run Basic Synthesis Flow
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib    
#set_attribute lef_library /home/install/FOUNDRY/digital/45nm/LIBS/lef/gsclib045.fixed.lef
set_db init_hdl_search_path /home
set_db library slow.lib
set_db delete_unloaded_insts false
set_db optimize_constant_0_flops false

read_hdl alu25.v
elaborate

read_sdc constraints_sdc.sdc



set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt

write_hdl > alu25_dft.v
write_sdc >  alu25_dft.sdc
#report_timing > alu1_timing.rep
report_gates > alu25_GateCount.rep
report_power > alu25_power.rep
report_area > alu25_area.rep
#report_timing_summary >  alu1_timing_summary.rep
#gui_show
exit