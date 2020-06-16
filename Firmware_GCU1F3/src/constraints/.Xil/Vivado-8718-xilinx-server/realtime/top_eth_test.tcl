# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "./.Xil/Vivado-8718-xilinx-server/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7k325tffg900-2
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    # Skipping read_* RTL commands because this is post-elab optimize flow
    set rt::useElabCache true
    if {$rt::useElabCache == false} {
      rt::read_vhdl -lib xil_defaultlib {
      /home/antonio/projects/gcu_eth_test_raw/src/user/clock_man.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/clock_manager.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/components.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/kcpsm6.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/rom.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/top.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/top_eth_test.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/uart_rx6.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/user/uart_tx6.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_address_swap.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_axi_mux.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_axi_pat_check.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_axi_pat_gen.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_axi_pipe.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_clk_wiz.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_bram_tdp.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_config_vector_sm.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_example_design_clocks.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_example_design_resets.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_example_design.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_fifo_block.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_reset_sync.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_rx_client_fifo.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_support_clocking.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_support_resets.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_support.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_sync_block.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_ten_100_1g_eth_fifo.vhd
      /home/antonio/projects/gcu_eth_test_raw/src/eth_ip/tri_mode_ethernet_mac_0_tx_client_fifo.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification true
    set rt::SDCFileList ./.Xil/Vivado-8718-xilinx-server/realtime/top_eth_test_synth.xdc
    rt::sdcChecksum
    set rt::top top_eth_test
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter elaborateRtlOnlyFlow false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
# MODE: 
    rt::set_parameter webTalkPath {/home/antonio/projects/gcu_eth_test_raw/my_proj/my_proj.cache/wt}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-8718-xilinx-server/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_synthesis -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    rt::HARTNDb_stopSystemStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
