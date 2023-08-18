
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7vGcPCH49dLHD1O8avqNVstMnjQQn8LVs8mTwu/l7LRfLgaydvq2DXjiHrtIh5yK
EkT2nEG8C5CGA29WMXz2xSkqltPuTS/lOveHrc0Uc4zOUBS1idKiIR35mWXkjE/N
cDl3Mjf2CnIJmY2Kbu8VsZKogBKKt6KPLJZ9oUS50TNsHhcJUrYPNg==
//pragma protect end_key_block
//pragma protect digest_block
SAnzXl+lsoPu4K21RGXnnXTdK8s=
//pragma protect end_digest_block
//pragma protect data_block
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
vXPTV+G8f+T5AtBMi0bKbg==
//pragma protect end_data_block
//pragma protect digest_block
1ylXTlx3UWkWbNSn9cdYjqLeFi8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
