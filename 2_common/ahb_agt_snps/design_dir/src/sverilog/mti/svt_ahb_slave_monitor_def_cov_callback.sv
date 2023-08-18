
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

// =============================================================================
/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_ahb_slave_configuration handle as an argument, which is used for shaping
 * the coverage.
 */

class svt_ahb_slave_monitor_def_cov_callback extends svt_ahb_slave_monitor_def_cov_data_callback;

  // ****************************************************************************
  // AHB-Lite Covergroups
  // ****************************************************************************

  /**
    * Covergroup: trans_cross_ahb_hburst
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst: Crosses cover points xact_type, burst_type 
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST(cov_sample_event)
    
  /**
    * Covergroup: trans_cross_ahb_hburst_hsize
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - burst_size: Captures transaction burst size
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hsize: Crosses cover points xact_type, burst_type, burst_size
    * .
    *
    */
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE(cov_sample_event)
	`else
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_16(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_32(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_64(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_128(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_256(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_512(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWLT_1024(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HSIZE_DWEQ_1024(cov_sample_event)
	`endif

  /**
    * Covergroup: trans_cross_ahb_hburst_haddr
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - addr: Captures min, mid and max range of transaction address
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_haddr: Crosses cover points xact_type, burst_type, addr
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_hburst_hresp
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - response_type: Captures transaction response
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hresp: Crosses cover points xact_type, burst_type, response_type
    * .
    *
    */
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HRESP(cov_sample_response_event)
	`else
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HRESP_FULL_AHB(cov_sample_response_event)
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HRESP_AHB_LITE(cov_sample_response_event)
	`endif
  /**
    * Covergroup: trans_ahb_hresp_first_beat
    *
    * Coverpoints:
    *
    * - cov_response_type  Captures response for the each beat
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HRESP_FIRST_BEAT(cov_first_beat_sample_response_event)

  /**
    * Covergroup: trans_ahb_hresp_first_beat_ahb_lite
    *
    * Coverpoints:
    *
    * - cov_response_type  Captures response for the each beat
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HRESP_FIRST_BEAT_AHB_LITE(cov_first_beat_sample_response_event)

  /**
    * Covergroup: trans_ahb_beat_hresp_transistion_continue_on_error_ahb_full
    *
    * Coverpoints:
    *
    * - cov_hresp_transistion_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_BEAT_HRESP_TRANSISTION_CONTINUE_ON_ERROR_AHB_FULL(cov_hresp_sample_event)

  /**
    * Covergroup: trans_ahb_beat_hresp_transistion_continue_on_error_ahb_lite
    *
    * Coverpoints:
    *
    * -cov_hresp_transistion_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_BEAT_HRESP_TRANSISTION_CONTINUE_ON_ERROR_AHB_LITE(cov_hresp_sample_event)

  /**
    * Covergroup: trans_ahb_beat_hresp_transistion_abort_on_error_ahb_full
    *
    * Coverpoints:
    *
    * -cov_hresp_transistion_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_BEAT_HRESP_TRANSISTION_ABORT_ON_ERROR_AHB_FULL(cov_hresp_sample_event)

  /**
    * Covergroup: trans_ahb_beat_hresp_transistion_abort_on_error_ahb_lite
    *
    * Coverpoints:
    *
    * -cov_hresp_transistion_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_BEAT_HRESP_TRANSISTION_ABORT_ON_ERROR_AHB_LITE(cov_hresp_sample_event)

  /**
    * Covergroup: trans_ahb_htrans_cov_diff_xact_ahb_full
    *
    * Coverpoints:
    *
    * -cov_hresp_transistion_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HTRANS_COV_DIFF_XACT_AHB_FULL( cov_diff_xact_ahb_full_event)

  /**
    * Covergroup: trans_ahb_hresp_all_beat_ahb_full
    *
    * Coverpoints:
    *
    * -cov_response_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HRESP_ALL_BEAT_AHB_FULL(cov_sample_response_event)

  /**
    * Covergroup: trans_ahb_hresp_first_beat_ahb_lite
    *
    * Coverpoints:
    *
    * -cov_response_type: Captures response transistion between successive beats
    * .
    */
   `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HRESP_ALL_BEAT_AHB_LITE(cov_sample_response_event)

  /**
    * Covergroup: trans_cross_ahb_hburst_haddr_hsize
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - addr: Captures min, mid and max range of transaction address
    * - burst_size: Captures transaction burst size
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_haddr_hsize: Crosses cover points xact_type, burst_type, addr, burst_size
    * .
    *
    */
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE(cov_sample_event)
	`else
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_16(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_32(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_64(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_128(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_256(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_512(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWLT_1024(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HADDR_HSIZE_DWEQ_1024(cov_sample_event)
	`endif
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot0
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot0_type: Captures transaction protection type for hprot[0]
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot0: Crosses cover points xact_type, burst_type, prot0_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT0(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot1
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot1_type: Captures transaction protection type for hprot[1]
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot1: Crosses cover points xact_type, burst_type, prot1_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT1(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot2
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot2_type: Captures transaction protection type for hprot[2]
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot2: Crosses cover points xact_type, burst_type, prot2_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT2(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot3
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot3_type: Captures transaction protection type for hprot[3]
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot3: Crosses cover points xact_type, burst_type, prot3_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT3(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot3_ex
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot3_ex_type: Captures transaction protection type for hprot[3] when extended memory type is enabled
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot3_ex: Crosses cover points xact_type, burst_type, prot3_ex_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT3_EX(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot4_ex
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot4_ex_type: Captures transaction protection type for hprot[4] when extended memory type is enabled
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot4_ex: Crosses cover points xact_type, burst_type, prot4_ex_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT4_EX(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot5_ex
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot5_ex_type: Captures transaction protection type for hprot[5] when extended memory type is enabled
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot5_ex: Crosses cover points xact_type, burst_type, prot5_ex_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT5_EX(cov_sample_event)
  
  /**
    * Covergroup: trans_cross_ahb_hburst_hprot6_ex
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - prot6_ex_type: Captures transaction protection type for hprot[6] when extended memory type is enabled
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hprot6_ex: Crosses cover points xact_type, burst_type, prot6_ex_type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HPROT6_EX(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_hburst_hnonsec
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - nonsec_trans: Captures transaction protection type for hnonsec
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hnonsec: Crosses cover points xact_type, burst_type, nonsec_trans
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HNONSEC(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_page_boundary_aligned_size
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_size: Captures transaction burst type
    * - addr_page_boundary: Captures page boundary
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_page_boundary_size: Crosses cover points xact_type, addr_page_boundary, burst_size 
    * .
    *
    */  
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE(cov_sample_event)
	`else
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_16(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_32(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_64(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_128(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_256(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_512(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWLT_1024(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_PAGE_BOUNDARY_SIZE_DWEQ_1024(cov_sample_event)
	`endif

  /**
    * Covergroup: trans_cross_ahb_size_addr_align
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_size_addr_alignment: Captures address alignment for 8, 16, 32 and 64 bit Hsize 
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_size_addr_align: Crosses cover points xact_type, burst_size_addr_alignment 
    * .
    *
    */  
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_SIZE_ADDR_ALIGN(cov_sample_event)
 
  /**
    * Covergroup: trans_cross_ahb_burst_incr_number_of_beats
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type, Only INCR is included
    * - burst_incr_number_of_beats: Captures transaction of length 1 - 32, 64, 128, 512, 1024 each and 
    *   in the range from 33 - 1024 at different length intervals for INCR burst  
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_burst_incr_number_of_beats: Crosses cover points xact_type, burst_type, burst_incr_number_of_beats 
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_BURST_INCR_NUM_BEATS(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_burst_wrapped_addr_boundary 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_wrapped_addr_boundary: Captures if address is wrapped at byte boundary for different WRAP burst types
    *   covers (End address < Start Address) with Wrap types
    * .
    *
    * Cross coverpoints: 
    *
    * - ahb_burst_wrapped_addr_boundary: Crosses cover points xact_type, burst_wrapped_addr_boundary
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_BURST_WRAPPED_ADDR_BOUNDARY(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_hburst_hlock 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - lock:  Captures transaction lock for hlock
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hlock: Crosses cover points xact_type, burst_type, lock
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK(cov_sample_event)

  /**
    * Covergroup: trans_cross_ahb_num_busy_cycles 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - num_busy_cycles_per_beat:  Captures number of busy cycles per beat
    *                              in a transaction.
    *
    * Cross coverpoints:
    *
    * - ahb_num_busy_cycles: Crosses cover points xact_type, num_busy_cycles_per_beat
    * .
    *
    */
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_BUSY_CYCLES(cov_num_busy_cycles_sample_event)
	`else
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_BUSY_CYCLES_0_OR_1(cov_num_busy_cycles_sample_event) 
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_BUSY_CYCLES_GRT_THAN_1(cov_num_busy_cycles_sample_event)
	`endif 

  /**
    * Covergroup: trans_cross_ahb_num_wait_cycles 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - num_wait_cycles_per_beat:  Captures number of wait cycles per beat
    *                              in a transaction.
    *
    * Cross coverpoints:
    *
    * - ahb_num_wait_cycles: Crosses cover points xact_type, num_wait_cycles_per_beat 
    * .
    *
    */
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_WAIT_CYCLES(cov_num_wait_cycles_sample_event)    
	`else
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_WAIT_CYCLES_0_OR_1(cov_num_wait_cycles_sample_event)    
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_XACT_NUM_WAIT_CYCLES_GRT_THAN_1(cov_num_wait_cycles_sample_event)    
	`endif

  /**
    * Covergroup: trans_cross_ahb_hburst_num_wait_cycles 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - num_wait_cycles_per_beat:  Captures number of wait cycles per beat
    *                              in a transaction.
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_num_wait_cycles: Crosses cover points xact_type, burst_type
    *   and num_wait_cycles_per_beat
    * .
    *
    */
  `ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_NUM_WAIT_CYCLES(cov_num_wait_cycles_sample_event)
	`else
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_NUM_WAIT_CYCLES_0_OR_1(cov_num_wait_cycles_sample_event) 
	`SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_NUM_WAIT_CYCLES_GRT_THAN_1(cov_num_wait_cycles_sample_event)
	`endif

  /**
    * Covergroup: trans_cross_ahb_burst_with_busy 
    * This covergroup covers cross of all burst types(except single) with htrans BUSY.
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - trans_type: Captures transaction trans_type 
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_burst_with_busy: Crosses cover points xact_type, burst_type, trans_type 
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_BURST_WITH_BUSY(cov_sample_response_event)  

  /**
    * Covergroup: trans_cross_ahb_hburst_hlock_hsize 
    *
    * Coverpoints:
    *
    * - xact_type:  Captures transaction type (READ or WRITE)
    * - burst_type: Captures transaction burst type
    * - lock:  Captures transaction lock for hlock
    * - burst_size: Captures transaction burst size
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_hburst_hlock_hsize: Crosses cover points xact_type, burst_type, lock, burst_size 
    * .
    *
    */  
	`ifndef SVT_AHB_MON_CFG_BASED_COV_GRP_DEF
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE(cov_sample_event)
	`else
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_16(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_32(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_64(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_128(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_256(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_512(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWLT_1024(cov_sample_event)
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HBURST_HLOCK_HSIZE_DWEQ_1024(cov_sample_event)
	`endif 

  /**
    * Covergroup: trans_ahb_hmaster
    *
    * This coverpoint covers which master is selected by Arbiter
    * This coverpoint will ensure all the masters are selected to fire transaction on slave.
    *
    * Coverpoints:
    *
    * - hmaster:    Captures current master selected
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HMASTER(cov_sample_event)

  /**
    * Covergroup: trans_ahb_hready_in_when_hsel_high
    *
    *
    * Coverpoints:
    *
    * - cov_hready_in:    Captures value of hready_in of current slave selected
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HREADY_IN_WHEN_HSEL_HIGH(cov_hready_in_sample_event)
         

  /**
    * Covergroup: trans_cross_ahb_htrans_xact
    *
    * This covergroup covers all the transfer types for the AHB transactions.
    *
    * Coverpoints:
    *
    * - trans_type: Captures current transfer type
    * - xact_type:  Captures transaction type (READ or WRITE)
    * .
    *
    * Cross coverpoints:
    *
    * - ahb_trans_xact: Crosses cover points trans_type, xact_type 
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CROSS_CG_UTIL_HTRANS_XACT(cov_cross_htrans_xact_sample_event)

  /**
    * Covergroup: trans_ahb_htrans_transition_write_xact
    *
    * This covergroup covers transition of NONSEQ(Write tfr) -NONSEQ (Write tfr), 
    * NONSEQ(Write tfr)-SEQ(Write tfr) and SEQ(Write tfr)-SEQ(Write tfr).
    *
    * Coverpoints:
    *
    * - cov_htrans_transition_type: Captures current transfer transition type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HTRANS_TRANSITION_WRITE_XACT(cov_htrans_transition_write_xact_sample_event)

  /**
    * Covergroup: trans_ahb_htrans_transition_write_xact_hready
    *
    * This covergroup covers transition of NONSEQ(Write tfr) -NONSEQ (Write tfr), 
    * NONSEQ(Write tfr)-SEQ(Write tfr) and SEQ(Write tfr)-SEQ(Write tfr) when hready is high.
    *
    * Coverpoints:
    *
    * - cov_htrans_transition_type: Captures current transfer transition type when hready is high
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HTRANS_TRANSITION_WRITE_XACT_HREADY(cov_htrans_transition_write_xact_hready_sample_event)

  /**
    * Covergroup: trans_ahb_htrans_transition_read_xact
    *
    * This covergroup covers transition of NONSEQ(Read tfr) -NONSEQ (Read tfr), 
    * NONSEQ(Read tfr)-SEQ(Read tfr) and SEQ(Read tfr)-SEQ(Read tfr).
    *
    * Coverpoints:
    *
    * - cov_htrans_transition_type: Captures current transfer transition type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HTRANS_TRANSITION_READ_XACT(cov_htrans_transition_read_xact_sample_event)

  /**
    * Covergroup: trans_ahb_htrans_transition_read_xact_hready
    *
    * This covergroup covers transition of NONSEQ(Read tfr) -NONSEQ (Read tfr), 
    * NONSEQ(Read tfr)-SEQ(Read tfr) and SEQ(Read tfr)-SEQ(Read tfr) when hready is high.
    *
    * Coverpoints:
    *
    * - cov_htrans_transition_type: Captures current transfer transition type when hready is high
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HTRANS_TRANSITION_READ_XACT_HREADY(cov_htrans_transition_read_xact_hready_sample_event)

  /**
    * Covergroup: trans_ahb_hburst_transition
    *
    * This covergroup covers the transition for each command type followed by other one.
    * It covers all possible sequence of back to back transactions for eg: 
    * SINGLE_WR_SINGLE_WR, SINGLE_WR_SINGLE_RD -----------------to.----------- WRAP16_RD_WRAP16_WR, WRAP16_RD_WRAP16_RD
    *
    * Coverpoints:
    *
    * - cov_hburst_transition_type: Captures current burst transition type
    * .
    *
    */
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_HBURST_TRANSITION(cov_hburst_transition_sample_event)

  // ****************************************************************************
  // Delay Covergroups
  // ****************************************************************************

  // ****************************************************************************
  // Exception Covergroups
  // ****************************************************************************


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTUCTOR: Create a new default coverage class instance
   *
   * @param cfg A refernce to the AHB Port Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg);
`else
  extern function new(svt_ahb_slave_configuration cfg = null, string name = "svt_ahb_slave_monitor_def_cov_callback");
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VTBYwRdI8HH+vQRuRRakfQUMCfHZY9O5vg/XJxSRRAWZkSXblkax6Eou8mP5hjN2
3OMqiA9aFhW3j25r1q1fZkLyVkn69s6mzgHsorNLPpacnamNXjEYMsV6eQYk0rLS
O9SNCRQ9zbUJwYdpQo2M5fToa/NLW3y3vX4byiKuBRc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15388     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RbItvfTD5fwvcXs7HWPlHBPhqcuqA5sgPPG2JZ1UvF/yr4d0LuC1rWytp6TI4ckq
ZqM0GtXsk//bjHftQ0r95+fC8gl1RNrs48mazsvB2jk3L8ZGMzI/Dnl2WqZBabli
mJNKcHLUxgpZIy9gNzSodXmI60DCv4jSCe8s1p8jd7U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15471     )
nQqWgZvziyKDOQFiDTL/D7+nrDxz6gxEnrZPgBXsIscreeI1hOd8O6lKYx5Vv9+C
AbUEln8zVWKLp+wO7bokJrwsD0/wlMWCczC1lkkVgBpLSrqKyLV7YtlNLZqaNkjc
`pragma protect end_protected
