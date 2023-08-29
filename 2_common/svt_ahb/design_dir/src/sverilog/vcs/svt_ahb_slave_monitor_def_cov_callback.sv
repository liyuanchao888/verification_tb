
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

`protected
aQ0@&:N2IZE:FFC9-2\3D2AeO50a^BJ<U]Vg-KdIR=J)C5eR:40&3)IT)2SId<[c
KACM6gI#6bX?YZIa2O#?96\IK1VGW:bcLeF\>6<9)U7NQC=LGVb]XW39d/IdeFZS
e7OI2OX1XcMH<TVSbc7IeTM/.4;Z)8RT+]0ccb;)f5dLWdZB36+4;GJV.<_,\033
F76N9_4M#b&IIMgL#HI-XM+D.:^5(8PJZ.L_DBVJ0/?N2JWWWE(5AfBg2ES_&9X5
5SWG:V6];V-=gH@dbKIcZMS&PSQ8ND30TC-0IEH6S#6NHeE#FSCO[2A1+NgM55?A
2-?H8H>XN+LVM.XA+O.RICS0:CQA[2^+#W1;CI:.OL^S\X9g_d,=T0LeK)]DRN7S
XD3?XB<?f4g::5\[OMN#&UDSbM<I#]b/DN)0N33OA(QcERI:3K=6[Na64CIRd[UB
_7+MR[dDQH05FU0#4ULV2<4^]RJLQ@/J951TW+;T.IRb;7U-:>B3U<1FMCGcK=XV
]I40+Z72Q[+\XF;?^XAIbMA&10[RPLZE1S:/U\d>@aME#]@K-XY76E0EK=L,OA5M
]aHcb+74ba3:<.,bG>&UHT&c6I&M/Y=(BKRZ<IIb#?eCAPPSZe]BLfJ(#:3K?OE_
#KROIY\9VL2I:d^dAZYD4CGB5A[ZWG=AOKd?ED,6BWD.\\aLNPdF5eGZ\+&UBU4T
-7<)]B;L7/0-TH36-gc+a>PPC/XW<NT06VHRZ5daJ/P2b79_U).55dY^;dgF[Te\
TD<dJPVQA?gXf-=YTNQ1_TD>CYTZ7UdFI(ZP@aT9+H)J2Y,Q09?XIXL&d16+)^M/
2Z+1?LR1OGVD?O=]N5[/SMX2aeedMKGRS[JBaJD;9f4:3#g[U5ZJPTe]^7X&A<>:
F]S3IOM@72.@WN)Cc,g8/PT8^V_OPa&K&,>SAM2U<4.9FA^:TQF0NRFZN-D6Q6O1
59=&V3[8@)=K)KXd\@KM8F]S3O75gbce]&MC)I+.Y@bV6>UCXKJ,UC+)6N-f/](Q
f[cJH-2^42S^Mb.<.e[O2-6@+(^K38KKARO70.;gDEI_C3<KS_Ta9=7E/D^:KPY\
3Y+8-H0/dcB<=&W9\TgCNG<G)Ma]-+3I=-.&TV?5FA8>[U3_b1<K+b]6Q\.QIL6W
/A#cdNTIbK:K&@H&9gA;HGc+:LL_LcNR+5aI#eK241(T9ZI46VJYRf@[MF:ATg3^
R,T;QSE1/4.\_.KdcJPFZ7L8+fYdY].C[?2J&?S_bQ9B>B:1&Q/32WV_;;B<fd<M
-MQeJZ=[fMd3A2eP7LE^e[Zf9G-ZC8Oc@ecfR5BTARa-RI38G?;9?=@/KS/A#&^S
OM9<:T)T-5//Aa;bR(g>Y+)b:DJ\J+bUF#3IA-T8Ga\OKFYM1Tb///d>VBf/20)S
]5;HR1:H,^LQ^5YDT6LAP^KA5_OX).G1J#HS2Cc^+Z&8XFGGK-7Od>V36EU22QFe
6gCVZgOQBVEQPX+baR[/PR)V4Kb[g8#FFZEFVd)fDL]_Y\9MMA#-0c-\RHMNQ7:D
3Nc_<(G9(<VIS3VP/N^99,QA^a[Hg3KLRbZE&A4#8f>M<C;D^NPJg@Vc7@NWL?8@
0-OY5@V&Y6G+O(KGD7?G\JIDT0H3#I65>O7C);<HO-N..M6[gD=,g5M462f1YR;4
PJU=O&D7B--\B#@cY[(ZZ=JfcPL)X&M8+RO)aQ5K+SFXH0E?5SAKZJK_UMb^J<W)
MGHAX^AaEP6FXT37H508OeP3NOC?Je4?V(GQ+/CfbJO5B=aU&,(\>I,Y@1W@P(8H
@#CP(f,R7C>&(H3WJ>MLLS&>V1V;IZT(Ug9J]]25-K,R3dY/IX\EDEBX=;?F#C?G
Tg]1+\5@\d70Ma\#20b2BI=B?_<9M]BT[>bG(//d6W/JAR;:FJ(f,LU1>dTdUdW0
Y/H[2I89(HI1]cR^^JY_)O,b:\B;6?ILLQJFX23-XXG>9=6UI>db/6^bcK;;D5-A
ZBZ?>e73E<[SKD44[NW#P,7PD8@H&;HJES3J0ddQbaFUN<fB^Q\^5[8Z0\[a_C<M
,[VMD[eI4]B]d\M,/B^Q2V&gH<1T@Ie<;AB5LABYP-CR::PG)9e&_c)Q2FUQNL=c
O/8@3F>cQGYa/F6d_92gd=O7.0KRH3TE^/VRYHJX?988^A\d=QK/&MH]?^Dc45<(
8=<.\RZ&\.gNW1;S/22688F6;WM@9D?/C[U\XBEGT]L0_<^-M;K=2I2gDcZ/G]4?
V6ON22SXc^b#D;MP<ZMWP-FNB)+/@T8ZBE#)LGH4^bCB<QP>@GO12G8Q0ZgE;NgY
C2+c6O3ZGeCDTFGKgfXZK4+O#G-OPf>S[PdPe8AHf2I,#d652A8;aAN^H6,)3+5Q
VXU\1<^YF:?)2E#Y^E<=#)c\AC[]S09.N0;T__P\>ff2)<Eb1.)PYFUf[.3FW4P2
ABgF&2ZE50(:/1##P;+=9:O;QX2[13<6GXZHOdWcD--dZSHO.=2c>8@P:-NNO7)?
4g91b?7#C,IE@K5VYXM]R\acM[P[F2K8Pg9-E7eQVaJT[B_O7[+:aZIPG2;Z>IK/
[L>WBX)BRObQCO40/@@)]L8MaKW8GYd81=3,aO?317H:IZ/#F3eL)WcXcK-XLH->
=4<g501g?c>:4+;=dW/6L<Ya?DCUg@UbgZQ-F2&(B<f>c;-BbX7\Sc_AM#H7X2_0
,BRQd(eNddI]F8BLP_\I:e^KC4+VKIE8G>,)Gd?ISQ5/gCI[T(-;D9F^^#.]QFTe
TI(+g<WNZB+:;^680S]IFcOfe./#D:QYZf;<^,LLW3;JS1]Q+UDA-7bWB5H(3#_b
Z8(XM=P6I;b?MfS)^OA8B9E1R4f=^NZI:U5E=d,?YRD(HI=L5(:F=GV);7(&_F3G
M/:3NdZMRQOdEFMMW=^&5ZF/8X[TFJ^KSfcAFa&5D<ZQE6SR?E2:VR3aLgd[F^bc
I,:?Z^X9b:\DLT2b8TDSd:.8).QS-61C8N1Q]N)C32a^8\f5R^/f&8QAZgI?2f=e
H;M,7QY>eeN6DO5N+EQ_W\M45,;cBUV6/.U8L:e2&UQU0eGLE:4:T/@Y54;1>.(9
eM]\gb]_BZ,IEbd5d92SK0bf;+#fJbaG2[P15X66+.(?Aae,]6O^TBRH6STI9UcZ
U(PC=)f6\>/Y_[9V-3b35MY;>3J+7]2:DZWc181XbT&9G2TDV,W1Y:gX/66B<fTI
d9S9IQ7-a8>VPHXKdKTD5C(Y?3a,?0PQ_^-)8_5.E/)_4]Gf)g8AR@SG&3/f^;9f
ERN1#;YOT_2/N[\d[5\VZdbg?06I5Q#L4:YSR]-PU3:1+\#<CPKCCY<Q=3KH>Jf(
UI;2-E#DZ)N(Z,(2b@>S8]->6FNTad]71bG,a-,I+(b.fT067AO62QeGRX)3C0+;
&f?7X751C,:OeD@L]MD\^ZNI@dC=?7RSCL&<P0@B/?[DJ&)>G/OV5W8A_ZX)V;Ec
7aY_ReGXSX:YK,c#)2VVT6,S]?SZ?QO)3ILfW^[KbD/T2:UZX[K)S/YPf.@LTe6^
9YN+b\Q8f7_H=^]]^B_MO_7#LTJ^KIS4:g-YM2(2M7@P#872\d69g,4ET^H(W41d
JW./?+VR<0g#@-c02=YY-)Ie6X#/:O.IDF@>I/gcdfH912^MMI>V00e4BZ]HR2QV
\=f?,G#2VRCeUBVc.]Y[K@Q&_gO:;9Nb7f<SgLJ\S[dK0c&eMUAfDAf(5QM_5NAI
eaKgC]We>4BML1;gLZ-3FW3b:VR66gAg[_HKS6-I;YHE-VbdD-4PAAe,LNc>+f[&
QM^YV;YUH]-)KLCGSV;+fE:F#<S>].M_5\3:2<gB,f:#-AA4G::e_:0BK(ABOV1B
]4N?4RO/54[6QE\aAUW>C7,7EVe--/K/K>/^6:CTdE?W3eIaRacSH:M6^@(Q5d4]
69HZ]N\U;S^GfC93M-[?OOH>fP]6-(I<T8@aP4S&ZR/3,27]4CVV,WICMVBE#UYK
249fd6=>IX^(^DgL)#8+OZU/-&)34N2N22L:_#Q9M:dNWS,(=U9BfH,7?e.c,(-.
]+ZOMF&_d(e6(3=@J4FJa(>Y<.G]R6@ZEZ59dA5W,4,02:A#O?G[<]2MC&M0W\U:
Zc-X\_34]a1RHa_1g&VIRM<T2B.5a50\VY15NQcZQ>F:GK>;Oe@b(\D#S+21<?D_
(@1f^I9QX>Y)fJCX-KEG:aE@GKOHDdbg/LJDR_0+OQ_b\#HKa/Pe8bOH?A?>K_<K
^OL^F>2_25_aI^@HQRfZ9MBYJ^1]20@c8cUEJHX&CPTFQPe<fW2-,LcE[AVWZJ^C
[aODGb;H>3[C[[Q5-O8+fL>R^)W[XG?;FY(U>eYM7CV[WcXa,F?UD6[;<>5@6VX4
20c(7.DJ+?P8V@7]]CBV24DI:=(Wdf<LBL>]0=a[aMO>=G_11Y51]YU&P4AX8FPe
<NW5->P8,T+/C95>Q6@I?&+2af)N2NdfF,EZaa;=5c_ZYG/Tb/D-=4##BgK_6J@J
eAa5Vd5>/ca425KK42&-S,.[b#c5-<4+==]5^NfW&K[)0^>eUZ2;DX#gT0FLGN89
Zbd^(68I=9e7WK)+)[>^GE5dC9?.D+63UaRV6;IFG8;+G3#Y(:a?EUZ8a\eF6[g5
A+EIc?-G]+(dP.OPBT-LH7],^Q)9S5:?].19/1@[AF2-YJDF7ZUEgJ>\?Y61M?OY
R3=/gb9fS=2d?+I-UAHEIYLX<825=4:>e>E?NQ718,#@Y-ZD#/.#6NW?0L7:)[Eb
S=A7,R-N=bO]..gF,@bc7[)AI#XfBO,1,f/1CZVQ7GgA_dIGVe1V_4YZ)TT_06[N
H2d4FOO;9MW8@#@0O]<J,.5FXI;/]Y3VE?);S3B._aA]D.6&b:]KMIT[9PL;\2FD
=+3d,6-Fd.:1-TW:aBSQ&B-W>P[KE)VO0aZ[LH7+Zcb1gIS5IG@XagUB61Ob2&<I
I.:2O0WO?(QH;&]3Qb.<^AXcV@N-O\HAOPGZaJ?I]06=bM@_UFH-ND:,R./EC>JY
T(7Q<Ie<U[K,:I#OeIED.X1ZCJeX+@=7)O8Mgb<GQcDP0eK#76\C;Z\+\4)HVX=0
X:@c4_^<X?G^fDDZ7^J)_PEK/3[]DYG+:gOHFd7#]O<W&3GA(RJTM=\7P9]<MQ=1
ZV[EUDD?\2Y>B;eH8Q+,7D,AZRb#3UJJ3d#_O+6.a0&=.KZ(_TBG1\)7.W20]LK4
74</>GIQV8)/MeJ9WGU>LDV4;M]4]-&N#Y2_=dL4dY]EaaRGR&6gUW1S;Xc\T3g4
RIN,dWZ5V]4(PV^,9YB/EOg<QH>:N;.\+dPbMHY>OLQL,GE51QCZ_VeY3XCVgR(<
KH,e(C\Y[JcaLF><>X-=,X4&g75,SA=2[5=Z?KfYb.B,FNIdbE\c^bVNXOFXCXLX
eRP2MD>K.M&9<N\VXO7cKA\^f\I:7]E\&CJTX+-0@>ESYR@PG<Z&<Z9N\4C@gV5C
LPC^KV,]CVd7+9\F&T9fB;;d8-G,G+R&96e9)_c7ca4;8?(V]?dD4gY(\6ee]LC2
W<,3366YF;-4(70T#\RA.g&>Iad;ObKMc:X0.HF1^[eM<1C0bbAK[&1J)_5&G.\X
]ZDLLb163F_\f0AWFcC^cA9e=Q2.4A@b\L83XeB@geWI5B7R&gDWH;]D);B]Y](I
M@N.Z+GH0>b0B]4(X1F9):ZHFf)5.5HQgP,ERZa+&AV]A^?)X(KeOfZCRXM&BY.6
#I<_eg43YZ42#O1g^CLS[KPg]=J3WL<@F&U1-1_V=FW+E_8:#;S>HMY4?&5fPI+)
<)I:7S(R?1^S(DVE.a?>BVWLUE=,M4-=O>..V/>2XC?B<X&>VeN8:<5W^d3_<5C2
Z<)/TQC@SG,c),Dg4>.IN8(#R7d59/U^<=+G/B_;<(R]VU8PI]Q,[>]Qf,U,?#9J
&I_]EJ@4c_H80RF=S,;XC1F+fM:TQH59_C3CQ&MCV]@a;Z4DY=>=affd6)-#/:DS
eF7.K7=YRO_df7UYE^L7Y8.a=XR4;YecBU3eY[L#.-Q7LUOL0V/8BNFO\a7^6\CZ
7PO4?Z#UPV:C7CaYd=[VIeHOH&1Q;F)&9O+[eA9,Y-\?9/X8BL)\a^Nd66R]QNVC
Xd2CI@L-/1F[,3>.YM^(LD&#.HfJ9Y52?DL,d\cH9-#<H;-V<_+DU/F)=DQBUTN)
a40A[E>dg&9>Q>SIY^PDI5Nc)Kf+B>,\K-3^bLQcQYcA:T&7+b\0#b]932MZ0WDR
OO6-#?YH+=XRZJ3<SZ?KVb_,3?NX&Z>\;V\L7Le=:HN&?1J\2Ta[2)<]I[W&_M6O
:P@=QUN&Z5:e#/5dWU7^:6.K&\@/-.fLO8MIf/aaUdZ4+9PONc[E4TTN#1S]/a]5
>ZcS;A^[KQWRIR,8LNL+R1XFK2fLA/7-/#EPV6;0]TCE_\U]WN(?Kg:Zg<Y9(V(3
A)W<9a#N;YZZX=PEM(4CcZ1V<[&]e5CHB4KV#^B\HJ5+,G0W86HB#+_/KU24#g&:
<Wb@SaL:>J5<BU^ceI8\[DN8N.eFeD7)P(3/XCb>UCAKV/<]CO#&#)=E<N0^aH<0
a@b#BdZ;E=H<3EYf5/7BLeVJdI5MBEgC6e\=PXF8Q<Ff;\A6^ZPN^9_Ma_.MQSb)
P&8S1M\H\(^>R;QUG5PUQPMe<d,T9S@/[R;-^8@4B8Jae:BSM,&^L,<;M:P[3]S6
VUY.B,@&gU?g(#:L^<80FWZ_9_JALeG)Z72.>4U55=KVU([9b6T&bQc0gAUV+9S3
6_SQ;Y4-^45-Z<>Na=89[EfOL^,2I+V+K/\XEP2N>_-9<B,3G@D]1D\>8<:d0Y2?
)=&eZM_Ff?E9_aL:O0I6H<>PBZLP\.W(^MWQdagLaaKK8M5<V>WV.g1H@01[AGGL
+)\GGe4C]b)5B,c\8YF:HVY>I@BgRMEE1.ROW,;=S<IDW,M5:S]K?GgF2[eccF]<
8Z/]9Z_33,X5&UO,Q1b7Q.[BQCO1.@d7YeR-6>Ba@(KN&/3ZLB/UCUEOTO7H=KY2
NX=:]/-G(ES,\>KXB[@<Q._/-=)a2R4)86P7/6_e?R83+UP2]8_68PH&@2_.]M14
I5bAIFda\<BeJOQPdM9C1),IYD+MH)&>[L...GKbBUCB([O\S:WGC:Z2T^98R#Q[
E9GVfcC7a8<O2,PEa^cQ;9URRFd^[Q;9[I,.2W54?.+2LVHE9gXIAE0=)3^X[c3I
ADZO39aHJ=>/9O16>48Lc9\:4JJ#5,JQ)[f6Y3W++;GC-^A3_O>_6c?2aaUJcJ1)
GWUGR-Pa[(/FJ?DQW).O]f4b+DW(NT]eDXVc>1T_<I#2_8.DDc43G3P>Hg+^B1=Q
[H+18Ga3=Fdd=ROfBP9:.,JB9+M,\Z&JDC)<#&GA1=C-7473>&aYdH7>64N2K/M3
60;VSAa&1e0>geWbA-.:ddV&Y40G=dfLVGcdH1VbB?NVgC@#MW;&/C(:8Z:a:_-?
WH0a9:L8N6N_)W(0:^#P[g&KSOL.]Ud]AQ;J>[f[L<0=[&0QRVS+bF9#CN)Z3gD:
E0>Qg[Se]BZHA6.XC3HdcE3]I6,CgL=?Dg/5Vc_)7OX[I^R_cMC4NMH?]M7:[F[V
X^LPAUB<)P]X&;IZ.Z6=AdMY0.MZTE@\=4Z=b;ZKf_]RSWDTC35f0Q9/@TDbA,1L
B)Of=#36M-&(@GN<a#T(f37P9#RF7N2U85RJ>fNJDB_G+#-6c+M]_8MH^1V<fB.A
>g/+1)MY30N\bf9NPKf\C@&\EANI409@?CBSD-F7</.H(VQI[T#OY7S9V;CRgc+<
]./eUZ,(>4U4UV]D+Y#KEI&=RA21-[Z.UbSeeaY1T3a=(KZbWXCY9#,(&N-PFfH6
ZP\X,G.:O0M=6K2fAU6Z:?FY>eOOY31cD:ZCc08WQD9GBT5L\,P/>cLaZE,4UfNC
Fa2U^0+/ZM;70;)+N71S>Q>DdK.EJRI(38EC-RNU00[7e1BSBP8fN]WZ?(NVDN22
1fQH7]R+ALO/94,g#08(U;+U>53X<]3.]a>HWY/WgHJ178Ud7>^BB@6efCgY<UF\
EE7FN0)C5P.X=UF\4.WD9(=)X.g7SZ-J=L?gf62]KCg3J_fNJ8\L>;9=D4J[X/12
JH,?XFeH=f^SW5e2UDHC\I)?3MKYX&Q+^+ZWZG;0dP.;B75N3:G[;LVd30d@gUZ2
O)Ndb70/QdFCYg1V_eEM&[>^MN@ag5V?dZ;8#^Y#G^TbMA^XG-(ED4OA_H>=]+b9
D3C<(<VJI(b@B/+Y5Yc(9&VA@=,8I(#(2V,M(O&)Wg;EHA)2),a_3UI&BU^DC,;d
I;e.&fN7cBOBZ+<DB->H(91&R\;Q5+;4:fT)^,W0NfJ<^UKF@WZE_80-NQ6W>O#4
80N&#4c6bf3/>-3c)A?=+e&Q6Ge2WF/d[g37@B;dDF4M8#BIeH:f#^&_8Y,A_?,P
D+V_-4MP)7,WKYELBg+Qa@1GOfPW^fV[/7G+WUTfTNUP2^M(:U4Y0JaT:X@QV38J
f2XXa?=B7R[]0D:eOe,GO4FHYB+fPdVB7-PKLD[0dd[JG[EAY\(P19QZQbKH1YI^
+&4\<N,d92E#5a/JTCW2CA&&A0+-W,U]QfOE_WT@b#X@QF?7,>D4M>0/3D=XaLeS
>fd&E4+CQ85S.[(:9PX3L7KQ;R_\N2C[MA[I5Y4ZP4[Q6QP3@OYMT:ZJJXUQ_RPe
N</@Rea],KDSFIfQ<C<N==5[G>DS#Je[^C5J&g[e??5AP\8+#<=(:51+Z[2>d(P3
fTRB-6LP7>@dIbS&80e7EeXJXf+4=-GT@c-T)X1CT&&\TadXM2Mc8@7U,DO<1dPR
]35,&Ef0Q/NX0R@T]>(S7@GaNU:AZQa4E8EC+eWdM&A&I&6GLAE4da7GF;eL\:Nb
X+.XG(Sd1RX>]gSCV?M.VPJc(-C^D1>MQ7&7KRe&6dKL0V>e6_A>\NHK2K,SKDOE
AG\<K4bW[Pb:1_&9K#dEJWLCQ#O:E=N]KT+M.?6/)Z0bY3=26fQ+:]a>1<N.^3Ge
@?3O0-.KLB(V]V6/OaId^+4]E<@8b92a/TH9+QVV70OA2>fFJM3T+8RP):EJdO&U
]1PfDB;(F,YaF?:3I9(g;b@WY-6>Ug>0FgM&TY&6,_^=DYAEb[bCTA(M.])H,OT6
2,aaM_N[CX\U8+,E7,;Y?,HXJ1NAcecG_W+@5D#.8FS.>RW6(?Q,P98#4N:ZH2-9
&EIK[00L>5.>D+E0;^5/NKWOZ,KFOR<H#5+abbfBAg15<27B_XWDA\]I->BXb_<_
?8J);2D,1B(_AA?HSGC16=N+352\<DW@OW=4J3YRAA(_/cD?=M?>^#a5/Z@=bEFO
IO00@0GReC^-D-+_a2;2f#E0Kg?c1,IB[]fUEL>KY3aKONL,=)M^ff-D:4J74[5&
2;BJ2,I;LO>,8e:]JP_BOE-I?TW9Cfg7\>g[AWVF=CUU>?]aba^W(L7_Jf9#)5?B
X)]=O\<a9fUWCdP4=D(HG1?L-aB@.?Q/g.X:3#:d[:c7S\7=)fR/UE=aM[#;5Rf(
.1^LdK4(LARAL#1U&.DE\3=eB;=WXJSQ:-P-.NE&RX1E?W/276Qa+_B9eW\;FYcE
_WIPYJAW^ZF66I)#fPUWQ-U9[UW(+O0]gbMcO#52BH)(c#Y^@GL0/_a]NKOZ_FI#
M.aUEX6N3&ZJ)@,<U4ALK1#])c-H4)C[]LZRMMC.R\KE19OVTcDH:6CG8:2)-#6[
e6W+??8A7e6/F96<K]4AbPNV&f8VXbcZ[0TN<->)YWQV+(I@HWG?V>7@WP&A;CF3
J>C1O?DYea9D<XG?B[::Z4M:,JM;,X4FNT75PIV)WbJ5?<>]K^UB3AG7IK2<CXS[
.Kd+:[8,cGE3H]\[U/+3OAJ_g]QR/a1(YM6A<HQcgG.ef;/;U7[a>=B-@g1dg6Ge
/eWI?HNGgFM+H66I6XT55QBIE.75JLX<@3AbRCV0=f^Mc>cJMAff^K+>-T7JJ>\J
e]:Sd=L8D7W)I_@@edeA#C/F/HC]\1JCf7W?9AT5JDAU6HD8bX&+_N0H0-CO?=HX
,6J5eRR/R9]KL^R5&FZ(H,AMBGA26_,SWV[VHFP>3LU).;[;)SCP[e4FLRZXK6c#
JP4/:J=)+?>cLB;ZDC#3V(;I:E0b<_BeLf95L6Q=]7WBWGUCDc+Eg\+F//DAS\87
TcK2T_LGQPcXWZ<Q/4cf=G3RH:3a<gKL7c02=[@S7EK>W8@/IU/HJEYJ(T4BL7O-
DF_7MVb):9eB+\1CaPDIPU;#8>JUT,.X88<Wf7FgPNc^Na^Ib2f@C(0;>@Z5b2^J
bbe9T,V]B/=>(DgV>Q3eR.CZ,4IVIK&D&J[:>9eL)/a3-QLfTZ-^B_-;5VTB+,([
Ua&dX8YSWID&I24KSM0)P@/6J>JeMaQ^J<XUNfQ(E#=DPTX<-;;\Z9=<L]1ZcBcD
7>\8RT\O)Be[WY5)F+]0)G;AYc6@.#OLN4>bM?);V4Y[D,/Z,.b5_bGHa7gZ>Gb9
-2(LL69XV<^RB?W71bb^6Z]<_D[&](WZP:<Nb;R7C3AE5cO=S+LU@7L]##+MY_N.
\UIR;d.2OUFHgGdV+X<-=1Rf,195AY1ZSPR<VA]M6Z4]J2:/[e7b=WG:]&cRHE/Z
TT^.U-.KaZH3D<I(<_?67abaH.CS:>?TC(\L-(Y)^#L;6G&^LCDaBEg.@J+N9Fc;
77Z8+R2>T9_JJOeJR-))@gZH:5&B7X.<5@f7U_7:#<SQQ;5K]OR.X9J]gWCdUE+G
J#)0761eO,?+DfS\;.Z:Rb2CO41Y7=2Pd1QNcF>?ZW9N:(;)(P:0.,Gb3/K3@VBN
Z^b.L0-:4)@R(QVV09[.&)QSEZG+GVaJ2(,O(8--d:/-/Wg3Z\=P)O:#/5PTd?UZ
6,_47_6@aZB[W85N<.:MV:+Y7W6+7HC/G##;=BK?^72,D;cR=@1?cd0K>Z(4._0g
Lc82NY,FDbT0=^[ER.0L^S^HS(O8a#QSY6ggWOeD;B3\PKb(+/,5>N,_\GMOfDQ:
8EDPeYd&M8WN02N,5bKe=;cC19[=g3a]?dDXA4@C<[:ef)/RER^2>]GH:g&+>P>/
1K&<>RT4ac2B#2FaDWO8eDa]_W-0_J>BRS4U\C=##JXJP+F_Z\Mg=bCg&8MeGT50
\HZEJN=:@e2Y1VI9:RNQY\ccCFd_L;4c.?6\Y=U>[NC3AR]3Q;/ZQE5]=6[(\0](
V)Ge?8_Qc]2Y775#K/)MOfY9&IaZ^N77ORNKCN-d6/fQ7.BEQI;\0/]Z=;7F+JJg
NfIZSLd2FcW2:?W4701]c5d;QDV5(OY=bJ<X3VV_5=K;Zb5U]7gLPF<\_TLG+bga
6C/g/M^2ScJU_X@g7S3e@A-T2N=;]65Yc;D0JFT/DP2F[;)SBWeC:B2\3>e64,PC
6d]B+Tg,6#c+-QQ5(/cd8.8Ud@g.fP?DL5D(N9^/;K#BX+AFcNS,AF/;3D8RF-7-
IMfd^O,-NTI&6T8U^Z&;#VTQGD4g/&bgH0F],DMICZe86BI1aG]J\5,-,WK<2ff/
/Wd<Z85W2F>SP?1;]XYV&FMC.@F/a+ADag=N)LKB-0[fKGB)bH#E6R/2TSNA_#@W
UV_ZVAE+Ab2-L1BP\,EYYO?)9eG3]YF9ZFR_54(\M:<VVgbcbX?a<@#SN61^Q-Z[
K0K47)a\0H/>STccIO:IMH[Y(&X6&Z:?]f#WMag=/<QS^TPY\[IZ12eWL\D2F#J#
XBaL@B7C\/9Nc?K,9C#-\>/)FC/TdYZURS4-)d8\.:8TWU/QF\aG82>T>[X1](4J
&F7)R(RZJf=_UMF-R9\0U38J?()d&Q2=MV>WO8>T82BC0KVV4\fJ>+EAA,:74L53
9B8PL=#I\T]K<]624OH@BPRe]afBNU\:_Q=DFgMDEF,e(E&WR;4I;LUZT_/#SYMN
>:SG8&=J,4(Q,9gdM]IDWZaD,D3D)5SU>]7XdR\\TSWY:bLd^8f9SeL4D\>.60eR
G,^?H-\K8=/\=QFYN7\\1#,_U\<FbgK[5=V((./f4+ffdM868ZSQ;26HOgL<GX^<
SM.P,bF>]B,_SYGI)W27U=C,L\19>Z;CLEK5L23WD9KE[5R6R0HA;W\B+,=F5;DV
g=b=_LM9)YX/M#+BR<d[d^bR9\R?8?IVF(#>4Y1:I3YSDFJNeT/5@Xf+RC:S\)Q>
f5QLGHYc8+WKWbRQ@#CHK0(<6__e&?(/:89BcDWf(YFJdDD_#g?(MbH/)B^YM@Ha
gVd8P@BT:7_@B)U,_V=ZL?;f5^7T7@EX0D:#c@].Z@9:]=+E&^TW(?3UJZf&QaL:
(9QYPI?<4K]V_N3]4C1X08E,eA2-@,0Z(3H@T)3J5Kc0d]^g-JAV1V+LE(Je^.TA
gB9VCa^BAc_gAJ=.fN^8_V>,Y\gE>>#c/OAFNX^V7TeLA>E0-c0I97>9W+I?6F^8
_K>FBY_UBGe6_><aWQGI;Kg2<Z-Pa?gUW<=B79K?L.7GH@:^\bZ;W8PIKC.8Y?VI
2-?BX\EggBOQ/-5=6E_-fg_MB_C&7;/PI9O6[IE)-ZK@U3+CN)MT7(0-a0SKPG&E
XXe/T)?8-&=@PRPE)9fBI8QTd+g#59Z#b5IWe8AZWC@]Hf@4C<QK5+L]Xb([(Z_Y
N)^[0J6dGKLAT6OQ&D/YE/.GIe3#PA\:8&fWVK9G4\8U&M\<[15+Q#6-G_f[X>ZE
(S08Y=S:L<?=<I^-9bE/e8@A=&d]9-WTOO^43M\fPS6G[fR)+HBOX:/7\dY_0O5(
[Sb-8G=(^OS1GR+1)2.9^>TU-]SS+0KGEAU:>)?:eWg^[N(?9D>;O2=#=/HB?1\Z
fVNOg\&F&NW-U&I;N1ITV#fI/RV[MEgLfJ[KUPM@b)OA3@=M(Nf<9d627AK7d((J
gZN?FMdZL?BX[I^(Z/^PD7NTV2).U[3<Y\UYY^(#VY3\)^0^DV42cBfJR(8U#ZcN
2>Z-,E0dEDIRIZe.V3LD:d4f7&6R>1&cH9QUK^7]GdTd[#J53.SA=bWUF:97+#\F
eK#70<6RPHYOR:3-\AdeWF#\5Dc2V360\Xe?8)G[aV)7\LM>2Y2+]@WW\QY10QGg
3U9.f+3ZETQUbTcXATC+L@3IRa<MVaW1,Racd00\d87b^]eB\[&QOZ\MD\DX(VOA
P[--e7PJC#;GIHE#A>MgT.VCE&J;;AR+HTQ+PPJE0CgY^D6B)_&)S6&/8CQ/C]Ac
dZEaO8fR6@79):/,]1;^N<]7QO8]VI>ce.QU,cL]PE74cR#SL@O\e,AYBSf/2bc2
F+UUKE^]+gUZ/YKbTNHXN[-P.0>C^8TD72)+69S.AQJ_+Ae&4K2N)LQ3-I\[Rg1X
2#SQ(6RCZfO.PSW0>JARFBA8A)DfD?GI@+)I7U+819&5Z/YZO0T+?>1^S[UDFS+N
[U]:)I.:<__MBcSIc)TCaNH642V^D?NG393DKR:C8[QNH782:/W34?J7,<(B+4N[
C/.Jc]J/GIJ-#9]d&aX?eV_5GB5WV6&c51f1PF)DQBYRTgF+cAdK<H?(4&LQ/.eV
7<3+]&D&a,NIOCO^+\LD8P^4L0JF[G(Jg<E.IFKETSI]6Kf\?b;XO?H5=LN7Od<]
b\7D3H4)9.9O&Y]1NcO_H-_>I0^(4&c2C&+;ROG^8?OLKWOUPY3W4Q._/K;<WgcC
M^1&a.];-BA[H0P/]GE;F,1M@>@:[R0CIcJ415]dTda&O:b5]^UHW7>V1WSASQA2
69G(+UGE=V(UT5e#B1ONgUDK.,V+KIYX)Z#M3GCO9H9a,_4F9Ka.fEcXR(LY[WPC
I\E<W1=Q7(Kf3T0F#PaGIAcI0JI(5M[/fLB]>VHQf_gK=.,H1Bb1dRVe^Jb9MF]Y
P?E?UQ8b118W6(&SQb8N_[/[<@K_,U,68Yc0X[9PA8dMU/S/0]MBKSZ_A17Ie<04
::H4S73&PDWLP=MdDFW=\cIR@T>18J.5-&XDLGH4H#(0:+45.8O.4YdfgL_X<ET(
g#=&6/3KS,4&G>&,/,L;W4U.8Z6BCERcC^;fb6KAB8HM?(--Te2:]+DNP7&@#NO\
#2+@<7Ma=UEX4AVA?N]H#ffXYRg\\U&OD@(UNOD.8I_G&fZQgK,AJP7FTDKYeD(&
Q)cJ91VHb=TRYb<<S..E@5)fJ1/MDJaN&^HB8NU2IgeM5D3)VfE^76McQ@[V;N@V
^(-Z,&3LV0:<[C0#1#?NV\ccB)5Q>+F#43gDg-2>=6.31bUP@]7a8afdVfZBdKAA
BDN-56:JBBf]UBR.CO6T@>)Kd<;#ePTfPTNU[aXWHg]/ASX6)Kg:NYd+20].XEB8
ZTY.72Y#3BH3-2RO6QBF5PV=4dgP#D0gfO-Z;T1,f.0<A\Q8;d/7:Tc)]b<J]W?E
X;CN2)dFab&A4AMfAb,U:\7?(W5EY5)<&_VXDL@X:9-c-XMA\7<QBT9fd(RcXSOU
eHbe6K9[QZZ]W7c<)U1+F+8;M)IN5B<C]>&J]_g:@b>FaL[^b[_Xc@4bcK7,9c(]
[TO(BB(=1U,e\&_6Z@@-/4J:WeA-BIdQ&c<Eaf/DQ#Pd^#:TF@#EHdN)+IM_+[EY
-=.V2IE8):)BeSB>5?5eZ.CA91^?]dMf&]EZ8Y(+(QLJ8Q:0=5>QUSAA1KgQga:P
0Z?V/0?2+MRN?Uf,J=2A@6^1HJa1G<W,M?9/b55gM@=fYS51/M[+8fcOg;\D7g+6
G<Ge:.LGNg[S8^L;F//NCUE(PSZ;??HIT1K;T5S..ZV\BE54aad31OWO1ISXLF-&
0+Ocf\(<?@d(LMR8QLN.G.Ob]aH1T98Tf)+6]6#(SI\09G+>0_XNWI0DH+=+gTR&
g8=69GPE;20E[Ca^V3.B<I&S\YP_Qa^f:P</6[)MUG,434BEZ>aODGfb2DNUWgR1
-SK?[(=^:<0---><Ob4N+f&^AL,FZ0.W+T_A^Cb#LaQG81),cVXEW#U&]O-U#G>,
P7ed\#3@GWHPcO8W3Tb\7D&4#5DbCXD_FLJOc^KgLPXJVa5<NZ).?PFJP1LLR&=+
C[f2;AO&ZN4T#JX=@1[>5/;>P))g2O^9NN&2KLM[(LQI.O3cUC)6?<c&L@D=g6BL
5cT]?ANLaA\,L841IARRZ)X8b3\&>=g4SI[U5U&d]5c6>#e&F?(g6PI\WL?aEFR3
JH9Y1=>@Ud8C8R>aKDB->T_g^#B;JMF[\0\BcQK[8S2-+^/f7@2GaSf[eZ@K^R-d
NQaYGU;[6<,SMC>I2^21bD/6K2U584fT9@CL:_/cEG]RAHfNbGY]16\1.00[,.&Z
T@G1e587G?S/YaR&d=cWdcH=;]SZ:\,?[E\^cfK2^[=W-K)FT6^H6(fDSH8G6GSb
TFf#NMPA_[8M2;<>MF.<_OF6]Aa?LbCB_+NS6Q.^BO7#79RO48Eb;01-g18_0.77
WVX_A@B>>N?gL=DgbYEF(2-AU0A(Y@K;_YR?POJL7eH>LMc1A4cQ:X<>=,S>S@+M
3I@:#^KV7Y_+A<YHW-I>@&C&JET7#-IU2R[F/EZfWJ/&UW0SfF>PBWST/gYJYHGE
CfEP8(;+M\8@[^b^4Ib>(>6D5dYKBZa9D9YXO.Zda2:W<NUG_eHO_LZb_7bc.eTT
aFIGB=VYfG6\=E?Kg0]\K9YcT0R(OS(K?BMP8e6@>9R->J>dDYZDOHV3OFH-4=@Q
@#GJO^,910b[B?I3Z;N)4ZJGX6f4D,0Z7L.&MQ<9MHVd92AQ5]J]HEc9B]UaG^bb
;Y+2=I_BUJB+F_:113<STG#9aL7\]:;,]X[9MM9aHPY3\&R5T@8I,fUW=2N@#9S6
1F2fWZ^3CXXUKDS)5FL[NK@=CFQde[]4)(DMSfO)b;YZA#2\&9P9)Gee-@d)Q\SE
1cP/8,]cMKV_3ZR[U-[;YF,bL2Zb/&Z502H;?.T^V?JZ6QWBI4eX#D2/U;ZfN]cD
6PZa^,7-O988[aR35:^@a(S+?^\&IK@ILWK0[\L_IPZM[K\]=ZgKTG.a:OR5CdR7
A7MN^(T=aC?JVE0YAD?e/M,K:1#b)ZRR...J>2^fK83_7)0O;6K[=a4RJZc+L;L6
I0]dQe5NR:7[6?E6MTg+P6?#EW5e)/gC-A.U12e3)6;&]+TFcJLS[.Q?TaBdX0?Y
F3GFW@R5+UUD0[g5YIf8#:5aO47[-;29&8J:@#GVUJ@O#6D,[Q>NQF.UY?C^YU#3
(/C\bO/7XP7J;AL]PDFeaBK.,9ICCINNeP>RCJ]1QD.4\fDdP-+9N>?MQ9W0Z+ER
@c7DO(F4^T>.G>_NEa0+Z7UF^ZKCXF9G1(#N=(H81VF)(^Y@A^SK.5=D</bUKFN^
HTVcMA8Y]#A>[,L-8]J5dYd7;VHXGCac#W6D(.;V4JK_-7IAB@f5<08[CJ@^=-bR
6@(53Hd;-bO?8&SG)a;53-SPX&\c,YFU>0-T2X_[1b.Z4XJaWX,<g>BPW?M@BFd1
,L#)-3RJPD^W;9-M66&=^Wf_W)cf?Y><4Y<+,geeW2#QR4O//cQS(\QE-cB9TF>W
_<L@S66E)?e.#-L>d=XA90&<:L(LgKZE@L<5<\FbOG77J<V+?ZS[<3CF_3AJWH5+
1V.dGIHH#,L;X.-TT[D-K@C7<BWDad8>+VWF2U)eb([\:]OC=O<F\2[dFBZB61QF
4K8A[>e=>=XFP5I(RPF:[/_?THI0W@9,IV#CfJFQf]BOg8Y7<+&^aG+0X/T>,Zc#
FG[]7dH))f_7F9E(+CcG2\9)119b9KMdZ9;J@_ZCWMaTVAQ:V?HL]J^#76]d2cJ4
6e)Jf_?2aaK8<=.N^X3-C#Ra?/THPP&g(Q293e0#H@bS[P\7I+EWYgf.b\MKQ9]R
G:AdA>1OUfca]8VN80A]eBD_5RQ>->AUG4KaFVL?SOX)W7EXD&SU&DQ)I8R11K#G
e7)OZ-cQbJbS)&bLX6;3bSQ_<V)BUL;DD>2VMX>9c10CI[2II>TZbaYWX1d1.J;X
W-+e62UE^466[/H@98?acY7db8TF(M62.=/7U0Tac76[BZBARS3F#gL0DR,PK_]S
UUC-PgXg7?G.[1V+>Qc2GMNe2B0S<RRHa?]F873MS9S9Q#,=@Ge[0FUHaK+?&#Ug
(0)7DFR<_<P:0BB/;H(QUF=eQG4VadUP1A:R?,TXIb<_+OO>-K7e=0f]M/W(\1J)
N695[\ZZFDG/#4(Ub=0E:IUO]d>eR4L2QB)I51(^TYKF)>XN=MK8Q>cDA8OK9ad0
I]CB_05?Ff,S\X9Y_W:b,X1_KR?_YE5N2R5G#A>fc2ZaK5bALW9UZcb[cd&CXUWW
7[73Y8<:1WZ?+R_U?UVEAN:K(7=-LMW.<S55328.dY<^M?4#5-d?6KdQ3Zc8>J3Y
FYU1N[gZ3IS+fX[>Z(GD,[A:(QgBV\<OY<=LC@H0:_S,Z1M:O7#5B/BgKbaJ0<<(
b#K&K@4D=MBCe4+gZD(_gO:ZN#LK9,ER\a/&e,G69Fa\NMBWQ,,IQ;-BEH@d+@A0
G?gfYPU.LY-EAB._@c;=L=D(\&X+5aG.10]SLDaRPE7VPC7Fb/.0XDS>:H:d:]g:
UN)OcU6O86dWK9+de]&RV(PcG6Z87_+X:J]NI2,S(:]WL\0dYSA6IO1K3THV,+(O
\<IAgX]GN8bF2^UdQ>9-&2S4#IXa;UL#,f-:EWR:E+]Me+]EdQZg0(ee0+JAQ]7-
R+?>#YVW2>.If1e?LV(LGW5,2DAPCedV/U9)9A#QA4()0cNe[)KUYC?@6BAc-WAQ
1,)d&X<W##R;,HO.LO]D,#ZW<Q^?[_4+O9Y#K2KX>W./M?6N2OgVTC[(K2RR5H?A
LN/N?0,?O32Vg=)?:.H^/A&aK92#+EN_b0CK<8VbQ=?^1H\W72aXNQ/Q39>d_\UP
+Rf6X\N6C7IJ)A)]2T,2bMHO#IQH.e:E;Oe&KfZUgTTA<Y+A779K\,R/LS[)YFHM
^E:eW-1+311REg<^VTUN&AZOE.>?RM\Ca8XIU=6\&d@_/(#AK#A;Ua]OL^,#g9U+
ZZFRN6.^&E]]M#@4K)I7A:U6R3O92BQ,aa0&0K5EVS:<DZ3X4f(PT:e1CD?2QGD.
UEB?g(DeRS@fJ74(Vd5YD7PY)cN[<>9I\K\-_eEX)>-EW],/e6U9CDfQ,4&_E(=G
/IEd[YF-@XQD/-,1\/eVBeWR:-V/B9fa62;#O98QM(GQ6;U=Y_e.?BaFGg0U&T;>
X<G,<1MIU/4ZM-ag4OT][#SY5]UZ[D6RD#[(;b\(D(<_2&H3#KA6=[7gH[7d#Z3_
g\]:3<K^8??<8.g]=dT9bcNgI;^@M&d<&V?9R9HF>TQ3[e]2R6H<8:T^Wg@QaKa_
J0f18?c@f?A1B/AFXIQ2W3J57UGW9J2feS0S\+;],^LU[g5G:_77N67IUB.fN+2(
RREFK:VF=4GFM7WbPH2;A0_:[eQaX,YGX,M;CW(;<F8.L;1P:)V8>EVc>9;EG9CH
c(4QFg>Z15f])#@eR5IOK624/T<HF[]Z8_a8EH+I2UCffIU>V[B:COHH/V-20:5U
QPA@bWMU+U<KS?GT>4,/VXCJ#9D-EJ+AX@GT)?I4JFD<^O9IaW;L</\aF?IR:2@4
]f,8H5aBK:->ZU5]XN-)7-8&K:Re<6Cb=X8.Q<\[YcM;c^e5_U4CdJCRdY0dM,DV
\3SPPQF]XUeYb(+.G^GGNZN3\@2OS.S8Z)7YRbII\H3O@EeW)O(94f>bg\P2E)@^
.84XJ:&F@&MAY.W#0V:1=;Of?^\G_7PHLaRH;WSTS<d/_PKeMUg=[>[6CJZB6-TY
E28APe?H&#FTW[Q)#QgA@5C.b+@fUU3#\3>C<)#</.6<726679XG2Od>3_^:8@=g
8XV&P>C+D4OS3TNTE6:4.de;OA;9BSL&f>_P;<=d9A5:HJCHa>[/+,2W.L3+0#FN
1Q,AAaBBgQNI?(+H09.:4;gf\XW1(c0(FDVDXT4>?aS^IIN#_(5ZROPg:bR>)g-S
UQEI>,SgKL(9OT[ge,8ZPWGW#ZX2MfdC5P(?BDK,EaH:L)cOc9[e6&0XYEI#?4;Z
;(=T<9K?60XU.N&9.Sc>@0\C+_C+6=_K_dbHO5F>9_\KYf:-8aP8&L/eE[-:6c>=
68-F,3V/>Xe&J,(F:9_W8[fL0YFT54Fg2US]T>CN=FS.W&;]A[&f^RJ[T7Xb.a5\
.SVPR@>L=T5[YRd@5L2.(X;gd?bQ.V4(4#^^5)IHGL0S_beZ,?.QV)CV3Q85F=4-
>[61>\C:YM^eO\/a((1#QN,18g#a,(NaVBX-[cdD,W)[&.<F:O3P?]2<ac-5U+_/
\Y5KODTJ3/0:UXYdX_/)^UZGTW,>;DA.:;5PR@7P<U[5LTY08H36A2?F(#RTS/41
:f10.DF(15J,cP<2I.bL5b.CR987>[(C9dH;5Q,U&OE:Q+#+)J(4U4dL#-06.9W)
Q6ZJWY,H-;4.Y:D8]F0)LJ535=b,H(F_3c7E2_J;@@=7Kd+HY1Y-2[VO_27,H\#+
[\Y11S==9Z_bWgY;ON::cKcDaNYJ_/SD./_RCQd,K-K<#A.&AXBgN\[4.&A=e,^Y
52G2G:aXLc5A@HbV]<ZTNTPe@?B2a6^03cB<f6/1O(7C,X;[_V?gH90YeY96^fO&
eHfN5F=Qg-d]IHFQP4eeCPG]9I2A_\U1<OX\Q)B2907T0AOEY,BLV5b?U2g.1#_P
U;b&;EXf1OVAR>B9R)f7/JLB(\<b+C[fI5-8UXU@3F>f,U#SbObPKTLJMD1#R\4C
d2Ud)/Y>KEb_?+=#?e]MR=UJ0E/fMU9UO/IGW7W;(JEPM<?&<M4R<=8d>BeG1?]U
<6)-^D,\MBILZTKcW-_TQ5#U@L.\Z>S;-+G>J:+X&5>5b\&Sb.M]+(A-JY8(_D_G
9R<JC0?7_2IX27I<?X2Y]3UYQF8[H\AS#>([41.gRVOQK)E3DTSb,dM@VCIZDS<c
ZBLE1+0eF[)7[=Z_f>#8.4a_>&eM))QV>eGF.e2Z:=?#;=T90_F.Wf,X5J<8BI6(
LS>]4c.O^)G\4bc:>d=5gHM93<M8LO:?<VIG+3-HD+\)3SYdfG6+0ZT)1/LGE>8d
3]2Ga\K,^5-RQFc<NDdXW68Jg>?Jd=;I)EB=3S_J6AEe/;_)KJQOSf(R1:#[:TfL
;T]0X[.5[O4c=5C-[0721(1,VgcV@RW5FNMdg@35Q:TW[D3,G1(5JRBXF=?MaXQZ
D1=aPZgU3O)Rbd40X:,A=UU3O,,9>3S-DAF]1[2&-Rdb\)Mb6;R;-1YKD5S.N;@G
Ec3M1Y>MN2g/J-g,IIN&Y62J.Z2NX1MBgLUd69S?cDZN(H2U=;A:R^UOSGWN]N3e
b5H]A3aXW5K16+fB()XT>59)c?^a_W\^9BBGXaLbfC1gZI7&8DM4J/JIaO/ENW]J
@eVC.900(QPg&gS.DD<-VL;NOVQ==Q6YX9Y]\KG4P^Y82;\/Z@K;d4RVJ0SJOIP#
FPQ..=Z:g:c-\]=eTd=N3AJHO@/EJ)A\EOR#84PLXLJWbH(=\L63fGVY=gT+Q?fV
bg#\d_;)S&@EBQ5><==;3NJH2$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
