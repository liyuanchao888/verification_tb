
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MxqPelZInudPIrrMGw24WSBjDAu5Mj78OWFAnoTm5KL5QfjVNiv0xP/RIebpY89n
DD1M9ypfnDqbPK9aYMH8zHMtuOf+Ms/QbrSVTt9evE0x/48WQDaQYNoq5PG6Iy25
/IkH3xYzRjiDQ4Vu8f7CoGDF8rYrYrV5wwKsc5a0k85+1ov/KqnEPw==
//pragma protect end_key_block
//pragma protect digest_block
fyBsFw1sSrZdeHzn4mmO8kf/AUU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
iWDqPH6s8tNkU0j5OXTj45dynMg=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

