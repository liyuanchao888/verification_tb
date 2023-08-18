
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

// =============================================================================
/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_ahb_master_configuration handle as an argument, which is used for shaping
 * the coverage.
 */

class svt_ahb_master_monitor_def_cov_callback extends svt_ahb_master_monitor_def_cov_data_callback;

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
    * - ahb_hburst_num_wait_cycles: Crosses cover points  xact_type, burst_type and 
    *   num_wait_cycles_per_beat
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
    * Covergroup: trans_ahb_idle_to_nseq_hready_low
    *
    * This covergroup will cover the transistion from IDLE to NSEQ when value of hready is low
    *
    * Coverpoints: 
    *
    * - cov_htrans_transistion: Captures only NSEQ after IDLE transaction
    * .
    *
    */  
    `SVT_AHB_COMMON_MONITOR_DEF_CG_UTIL_IDLE_TO_NSEQ_HREADY_LOW(cov_htrans_idle_to_nseq_hready_low)


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
  extern function new(svt_ahb_master_configuration cfg);
`else
  extern function new(svt_ahb_master_configuration cfg = null, string name = "svt_ahb_master_monitor_def_cov_callback");
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
f07BLuRrmB9rSR9983aPmBKYYtTBgNgRnRkNOekaxncw6unQ+U7ZwoIfAMroX6t0
lkY71QEOlutjrItByRgkL/qdE20XlUr+Gj0fmvdo6t3DpD0Iliu1efvAQbc4epR1
DUOxWAzHo0q+FFu0EX3N2tH5dVMOvXgpqCj25TKCnzk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13323     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eWK/8TytGivkBzi1W1Zo6CYgU0RgGBWHS5iR5YtFBp2NGmqUmp/eJh8GOu2tYmuE
v+HLMSXqokvTPa83WfSwKMzQWEITEk/e+aZw2RlWoAgxD+7gBZ/SgVtkUE/KJONc
UgOiFA8D4ta7Qd2QO6DF3CpAVuhX0Z7M6N6thyVSllk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13406     )
fmThNnYtpUOhTwdGqKHFv6doWVlwAPAQXeDX8L9QvDQQIyyVXthMU/gNHT/2josZ
oVFpUGWGslDRbuT64khad3cH/30FGBWTrs+/zUZXC7pl8oj4WWRg69fxViNct2Ga
`pragma protect end_protected
