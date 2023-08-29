
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

`protected
b;B?&M.^AA19M&+09If&dd?eOU,4.CFIWOSY2]=g5X3F_RW91MN&,)W?W/8<<04T
I8,[<RL[OO-PFB[X\J:CfeHRA]d7J,@=^-[;;e,G=2[VKO<4L2+L;H^+]68.Ed?#
+EB+:e=8T#?H4a8)e0^L2MQ@.32_6.1TUa+<H@e=+\QdY]8@VFXPJ/dPY\ZbfQJ#
),WfDS-=XcFCLR([/)U+[@.-)De&L:Kg-UgNY^85-BCGc/aE7M@F:-LV#/aH4]9Z
@+.gH3aL9]g26Ra.>:M]^3]0N&GC]PgEAI1Q?H#EOVHYX/G8T=eZAP61Z98SJ=eG
&)3;LRSP4\C]1Xed1@+#=][[ZYIC6YZHU9]Y?Md8S6/Q+L1.=:L9CICJ>6_FX[8D
?(6ORc5c=CYS0:5g&DM;2QZ>F)(X)154+2QSA8XRbE5U-T6.I=UfO<d@Za4>=JT3
b\QSX;+M8.67Uc6D^1dFZ#b:4A^Ja?W&[b.+Q:L/#e63OQL0]Q^28dIg2TM626_7
G>/.AL3&fVUd]56ZCY93ID@IXMAG=+b_W-LW=HIcK(5d.M@T,e+R4RRG6.:=&]X_
f+B-W_7)]\)AJP8D:HMN)@V?B/E21+=8IYe,N8T#d,RFD+F:27;1T+@IG())>ZU.
Q=e_3:Ibc.7E5RPNHT)#4RP4?69DX)IB8c)-Y#AAe^&C51]][g4+aGG,2-4?>0)_
]GM9=:C2XWX4X6f:A,2Z+].P2G4T1T+//KIcX>Dc.BZc-]adR/_KCF>VH7^DdVC/
:?:L@HQ;S,>(D:[,Q(H(e-Q(EZM[=3A+]IS)Q;UTcO^CD>K2[\GgfR(??cAE5@\P
]=Fd]?g7(G4B8Q7JLKD//NRP8ee2RSI>LJ28Ia94])Z?d(A=E=E\Z@c1IS^08[J)
<UBOK3ZYc5Ng_N?3/V2XY^Z8IAHHU_JGgdYPXIJOYAOA^gHT&MfQ?:;TN=cGYA/\
H(#4=+QYQ5Z89cM)()(-2B4GXV2LN#_EA]dZRK8E@f[aFH(NXHE,-ZP&c30BP^8:
&I4X5.E1&>S]K3gb5_H^GN;IR(gMR8[8J,:AcO6]HeF87QC92&D&)1LN++(=;X3a
]&O371X1-[&2V/_@/4eTCe8T]=5?)=W=\_[M.R4VSLUbdR.V6DC.-D?3L]?Cd04+
aB4/e>9/f-]K##<VQ[?gD\c+@W(ETAP4[;FI4-MDI<[UR+U1,CX8LTCW)aY^.TA#
<?^I8fRc,A4[T3^IV>fe-U65/FT/48]4,dM4^e5D[N4;9V)f[_PG4L#X6VD_X\]#
^TZBWF290G9,8@f]^H4U/6G^.b9<fPL-g?3<[0Z_P60PC+W4&2?ZO-?cPU),1AL2
TaFH8CLfMMb;1>/L^QQ;--[MR8GQDCAI.+2a([KM>VN>,]GJ2N<CfV@=9,gAH=+7
1CXSSD_](2CHC1BUCQ]H??bJ350FOGO[3aHHS74bI[NdCcgc/]Cc3;MRV[:e-<<K
<3HU/EQ3Lf0WUR0cGQL4TG.-/F>N:@8GN=C_(O<<FB(?O;1&^F)C):#TCC)-J&OV
-=;dMEM(IOZ;G_e[FW=C#.PJ0SCNPRS(S,W:+T5YUdG7N+@Y5_/c@S<6a7F)9?0N
WeIf_CI@&RP)XORZ:B5?^Q1-#0@Mf\112IY1_+T;f:NRD0+,RUV44XBRZ[^:T7J.
9caa,N+b\LN:V:ZLJ&?([IG2LG,ZGeS^eHdIF^AeB(6gRLFdL?Ra<E)faXGG5Q+B
IaEX8HSeO-BXHX_S5V0,8D_.AAOV,#)(2a4#b)a_W;0U17JI^>-CAQ/e=QaXC#:f
^+TTPH=C,QfU22&--=N]=.[-77V=B;SCZSN)=BZRV\UMbeW&GY20B//9Mc#YA.AL
ecPV\07g_^&I/1,SP?S.-UH-gFM&;IPFgX=\AA]^.(+]D]Y=aB)AIV7DMPa@4d]V
cVG+51J1P9IJDD9F]H6YTb//EJGH5](L:JMPEQ.FQ3V5c/S7eSDYTRUa_SED-9@O
SP-.CVH+1a=3[C:WRF+MSf(3b:NEM8T=4@aY;@@E/7\XcFfR23aMI.&-:W5N1eP;
VNGQ8A,:/OK5,52;KHeIH4)3P&632K>6N@\UZM9MR1XX?R/]58[Q&6.]O,DCcNWI
>/]YVR.5X[G(#:N2(9CA,6JX+)O1_f[A(YWU1-P]->+W;8/^N(,#)ZN\P=6LPeD)
HUM2UU5U=L)-a_.S=6C,2#[+?3T<S)<8C(>_2,a#gERA_eI\e9L9I8EX791I)7MN
HdC4Z+KZ;<Q4XN:Y?IGc3Ze9JHe0T\Tf:KS.RJM&5eCK^QM;[gYERLH3][FcE(e_
W6T;MG1<)G5IFOf?eA)PBE-T^,T+#<P,P)CDC^4,VM-GL7bgO&@()YcGb<RXE;F;
5\d[AEY):L@<>^P\fWT)92dbUZF?aA23NfWVaASg=]QP_TKAc[I-KXBF&6/R6).F
D2K59/@+b.^f.9^FH9__^aXLeMB&d;2,6A0E?,EOI#?GA:KL?.O0PT?:G,;BA2U+
A>cX0PK-fY0IHZd-7,VWcGdYQY+ZGaJUe^970M.0R&(+/OMC6e4VHf+(OC@XaKfW
4YU4Z_\56P76TV/[30)dUB:DKEXT&&8H0Rb2I+37a2:KZQcEdXA[P8JH9CUVJ:4#
7K78;#H8M^)3H8>\,ZcL#0.f=P7H;9&LE4VWY6(fAN--WB?E;?4P9XQYP,f_REg4
7GXUT]Za16F&2\8PR(,Q<Baa+_U^A4d04;_5(d45H)9#BFJ;,\KMWNb6aD0I<\gZ
R_4]:J)0Q^,ae;:HeKB_@V#J-WIY+RP#6G;2Mb0:aCP,J2G9TLX,^Te&5HOVC>HJ
@GN2,_8\/1S)3QY[39_HW\T/@Z54)TJF<Fc@SJ1V1d>68?HF9TN#Id._XA>X?G3T
3@fV7,0JC,P,)\.9B+e51\(\FP3df-+aW[NYO=cbeQA[85(V55#f>WNPZJ0deS&B
[VWW3be/J1[B/GNLF/Q,/STg;d6,=;SPCf)^X@K4(=5)J(M_5c23IGcXJ2R<9UB#
VN>#:E>1\]2Q8N^ZTC5d(>?R/HXMfN]GFPE0=f7b(,KMI]7B[NBL7VV=f+b[LAN\
@4CP2+Q?.I^g(9D<F::b>ZB1-Q^45.H24[ADUfc#LNS<Hg:G^5=&/\9XZVV+ZL8N
ef>;gNUc@&&3<IaP<ZC=[G:bfS78@YdT3?e8a>bbBNDR^:GFI3O[b(A;)D..C7@@
IgD>X0(90]B)F-\TFLG.WN1Z9J-N<]7](>E3:)?D_8IJ_(-;<gS?0(E(5(PG^C^4
Od:5(8=g7S^D0,f,Ua^cXc6ZE67OW#.c.(<S(HNKI,>F9Vc[=<b=P:gPMK01C?83
5].^\/^EM+aW=5BOAL+#a1eE:@-H].d_SN2&#H=W-0U:^Q@LF1A5)9E@Y=A,?)Qe
;LFeOG&<EFFfWW3:(,2U:XO]N]GPLbU05OQ&cJ=;A.FM@?(dU>^+W43SV9E;H6bM
G^+289S[)-NK.5Lf[SVTYHF6,Y8DNDaZXf/bVBT6GS6M=/fP,1:YVfQRgRe@4H8\
W2-A+b=b\dfP/J0/&X^T(e^R5d-aF@;T2aRQ_SWFQF-KJJ/OTbIEDQag]abGK[X\
3C2D--7OD)BKZ#P]eMJ;/[Ig+Y78gUf&g67eV+ZCMF>V3H9g\E\6(O+]/.#U?1][
<6bX&GO/Y\:/?D/P>[Qc]3Ma77,T/8AJW[DgR(eD^3HcBQ70JHGCZc:Pdde4,6bV
\LB0V(/QP6B85.P?(,U-JFPA4=5_b373#1PZQT^[-)<?15e(3Z<[#B6O+2A5X4:2
K+8K>LIWGL4d-f&7B]d</]=,0_C7._>65ddP&dI9B[(>cK+>NK##.S3V10#5.;&d
[<,BN7V4]1?BV=807MAJH?<<O6U,10YRD6=M&HWAQB-C;a7G>[GQ^3;>Ef<H/W4F
.A?Pg8.OPY7e[Yg/^.b_?>T7YY3c@2BG:dd4F9I_AJ-VN.<37:HA0#eJbeN[J:?/
QG]gaY6TbOB:RIS].=aGO8YY0f->V/2,Ee2PKF<ObH1C+;BTHW-@I)30M4XGd&VW
XfO1aXNAO8O=4dc7/:I@.DYK+CAGXaFa9^/@FXg6T8f?f/.L]d3WU^-2dAO/G#5(
=b/D2C7TX8&?[d6#,L#CZb3G[=(:-FcVJ_V.Q0<BLB=0\H31db=B?dFF5HVT+]I6
@X&4:BDEOcS.L4/^bH/4K,K>[(-AD;^M304,B\#2IG:+O&21C_e2#)g.6C7fG;()
HCXM_[&_Z-V<C)fQCbdJIS)IUX\f(B7f0_@Z+Q;N^/=L9a.b?NT94Z(B[UC_gJPI
MQK:3ZLL-#]5>91(Q.EADe7+B2@D>_^4de=4\UW))PCfWBW/?eNJG;&6_0,J>M<?
27G+<A5)S2<5JI5^,\PH=YN97>\.Q]/Qa=92]4SHMKB]b\2J2ZJ-F)ZHDWD\V:L0
SI0:eO.CWb\B6HUS_U4)QZCZ=6[XG:f,_/KB.f@E8NZYR2&3?eM2AZee=^X5<(Xf
PA/DKLeVNUQc)UbNK(4&;E4\:@X7?9\FBIa13__1AJJG@_:VeN(K&U99^N7_1(P3
=FM&IQRe#[BJ)N0K==KM:YMRQ/QVEP),S8b[;3CdgIQ<@T;C)CA55R>6[.[&K?\\
=)X4.bHP&(A0g6LWJ.cB\:6MK4WKB6bV.Z,dP<?YQ3FG\?<DOL?63>7RH8E#9f]C
(NdRd;.eP@GAOZM035-JW9(aQ2Z85182N5g]+->NLR2Q;dDT,6;M\AgZO_cbB[SD
^4Z6W3N.QX4N930?8A0L@1)EV8aZ7dfYH7FWfO97<-9#fHY+P1eOgMdW;&M@G:g#
MH\\g0+&#?c?3(1PZS4;FNf]47a5ZFYge7T:bP>82[E_,D>LO;9d^eG;JANe17E-
:0A-_9f4NS<O<(Qg/g<W8V/gdc@L5Z&,<?DW,E-dCI;ZM9;F(,O1MW+G]:@A/FE#
0GBH2?TN@;F?_?Z7Z>B_(KX-ZB0X44dQZcfBP+UZ>^5U=cQ2P-XFbR?/IAK(9^-L
?XE:_)5FOETI+T&d[d@Y/]bb5-K)>9D]a8R)g5FMS.QXC+JZDdb?L99<&)XO=@.E
5V>M,BQP-C>SC<4KDE09.-NgbT5SM<^A>Z4HOfMJ==DCTYgHWAZ>)EUg1FLKA6<I
8[C[4d=RLFJ2092bF=BG5eUJd,9T_a=Q3c.#M+O3Jd#ST((HNHbGI,a;&X7;1@G1
J+/;&?1)\N^Wa+8<(XKGOR&E88CT<Hc\/2a<GF.PgKRT5VV8b2;W+B/]ZER&eC#^
?Z+3+PIK9:5;Xe#)[Idec:;gU?3caK)YGSH[VQK>F&OZQ[YFV\P7J)D.b5T#1b6Y
MU1WgUVdFZcg7UTOH6gJZ)I&]\-)7@N-[g)F&9\=d;.-:^M-=49IFE62BT1]--9U
0UWJ7KUF1X5Y1&2(L<XBKL+VR-0/@@P:PbR-NC4T\+A>(XO?7\ec[NBD>T?LeGJ1
8JPJU#<@#=.T)@5g53eY)X=RH6<SPZ)b5dGSI.K5N]Z.XJ;dDBbeZC.\Q?VQ:eI^
R.[H.-3@<\8:g9?U<2).OA&VA-;1YJ=Xb(GM.OaJ>.4dK2/,\I:bI39];WJ]/.,0
<(+7FP\<6a=AF=V5:b-cFS#H(#VQ:4\E9\Q/WR[-/Ka:M^D)=f6K-^e5]V_,e,&N
V7OQ@(fe-=5;7I,.X2&^D:RM?+DOeAEc3a2P\YC.W&>D&N?3-ZQ1>(;8#\A[K(OQ
3Bff12-K<QC.ZKS?IJfa.&eb<K9+>c2SXFMTPHba.ZMK3W(S(6dfD=J=GS1aU]b[
AJRF8DO8H?CgC?K5@PeX_CC-_+;CeGe=C]eU)XCF1[c6]\cJ^.C[^(S@7g45ZX(U
&:W:C4(;-&BEODG21LYeU&e)7)C;Z:d([FBJKUIOIM[90KB9f7#@M[PRgH&IFdP1
TBg\#1dZ_^8)I\L&Qf?;[_.[CDI8/-9D/4)F@>K[M14U:_M;FLc?XCIN16KDCG&6
0@M_6;f:,.fY,>PSQ>G_S777SP-,G+b/+MM5<BWM/CE7GQB4R?_8E(HHLQ+;.W]>
G_=;fWHegZX:)OSZ23](I(/4JK;^-@T7Rg@H0G?/P=YaVb#0>fL_9/9,,_6M[[Y5
0:eEI#d3Id[c93A+aA3V;8.8QHPDYM8QRUT/V]AcaF?XcK\OVC_C:>+)1->&:SIB
Zf;F3?K,\IB8d9\Y,4U(fPaXJU31RPRWZ?e\)P)c/>fY3K>:eXOPbeM9#J/Y]fQ8
12\7ECaMHGJbc0W##\eO)_d@Nf2#9ZK^?UOPJ_.14g,]5:XL5DMB\&[,L:#@@RF^
8f@LMFB>^J;MJV^g/?UVFNSM<979?&WVZfOR/\(>?ZBLA)BXH>C.GWEMbE3)9YY3
<[Z0\I]Qf,1/2255/I^U4E2A5e=D8fHD;N+O(Ka)4(L=W3eH<)UTf#cE=M8AVC9]
ION_GWOTKHTQ\;:Kc/+J;c:L8X-TIK3Z9+2S7HR&[J#C<ZLF=(3_Z1FK?@LLDTQ<
SY;W(gPUL1K#][E>K2aO;/-1T7^;g<4?1^]Q-2-3ND/27>7<T)(ZeQE0:5/;\\E3
cU^T3gFFfe8V:aT8O2_DTZ;U[O9gEbe<5N=?;G7F6=[)<XXUKdB.5[H.V.edZ^7B
:bHceM(F.V<R@B,KgE[^a536H-Ce#/gCCBRc.UL53dJ:<3R9B?QH;[O;#&V9=1cP
B\Ic0[L.Hf8I=F_I)@(EW36SMAfbgK>..+_E7H9\a2/K;FQ43C_^+^ZK6P]=PNGd
b/DLdXE7^O]7:>gFeE/fa;[ZaH7RF[?4\7gG@ACJgLIf,C\gbE;GPV^\cMc^@]8W
/I:_EII>6X(JK.1>5B7#)Ua&IgXfbU#L-XR8C+a/dc_R&Z>W[AD0NT]N<[0._XG8
S?:LODSSfKDY\M3.M7QM\U?Q2e2.P7E>GE2V0PMV:M=d>#;.1;R&aNe@gg;A7C&c
,Z[Ka2_;2,Oa)GA7\:BcD:7NL:\Fb=M],96:fd;+NZ[VV3^>L?7-;1YbIc;;_^<:
LHNGOK=S&G[]5c;V2BLG2<D6#>NgY_<g+#<M<JV.MT;7YD?/J?E4Z+87@5/eYZL]
fRF@YDP\;f+,_+V>@,4^&899J_E3=K+7(Q]gOHQFGebA@f84]YNeK8X<UL/CgR8L
AV4Y3X[B5H_f>a4=4]DM,UW0UZ,@deVCB#2S^CJ6EZS,J5[aP=0.Q9(=YJ4=^RB2
:.@SA.b,Rg&DbFO6W\B+@:Z^_B@R>,#=SA/=:&-Z8?3eaI]c(Y_VEE4CC1Z6:,G=
F&@059<WEgbCTLfE,O<f:;9&JW?Y2XP=c9SYGW+11PVP04NZ0^,2(g+KAUCW<VD6
Y[FgC/N;<I.be1d7BX;e+##44ZN1_,?YYX</eOS5T8c>?bQ[96S+cQ]J^/=>J]3.
J2RE0+);J),)E;BN<^=#LV?bIc?\_2/H?&2Q8MMY9UAc>L\L\ZI:-<ZQZ/edI8Wd
1A@aNT6SA5@96eQOJSJL=-#XaUI+:Eg3682+>=MXWC^FEc[caH\W;U6&Xb_35GKO
eS_?Z8[4ML3D8(A&VMUNQZHdRW1?c-/IU^,P-<QBGOg(&<I=g)JH<:1MDf):_:@2
@1_gMVB_P=#@f@>OeF9D2UG:JeQb[DfQP&U_@T6<=FRSe]-7aVa/^)G1^8DY_=3a
F0I;5gN)_@\MV]cLNU>E>Hg@I77R_a-RCLb),L5T8?EVKHfJ.K)Q_XV?f1GFaCI3
R)&Ne>3A0P/1T=O=4dIeM.OO<5c2:;F.:OQA2-&B0B>/8;INEIK[+Td7S@+;;PcF
RE3E?CKC@]C)R4#BVgP0cFTGMaRRgDWJG4VaeHfWY#c_)X384fX-<J>_6Be.=gIe
:>5=)D@3=-<>6LAFca[AY]HIEY6(1=a5fJc:(gF-<(WW08QEDgDf<;\1W=+33?SH
&\/\5<Q4+9e<@(H]WBc4L52#@V8CPS,LM(^M<:3P9P[]gN6TQSH:RTQO)@[D;)^T
(SPcc.JYTBJ,J)#@:ZUFYH:GU827CIYbaaOWS=N9:YL@2I#d]7K_6/B7Kgf]-X-@
?=TNZY@J17SF&#CKW7L[Y7EUbY(M[\BS2DEHPU1a#O&/ML1PYY>PR>0GR^<^()LH
#Gc#D#-aY5H[@fX#6e695B0S@0P-(4VJIL2^R<Rg//WLSJB8MY8I\(d_]3=Y4GY5
Ne4bC0IdJBBJNTJ:F6Y3b#5eeF.;+Y=R/IH]+#gKAK<@O+5^c@II+OdG0.X#5^GT
=38ZGWNBI63AL2@6_+@QW?ScYM,A=@2F5&IZJGcY?(?D^B9T=>6JCHCLKV#U.[KH
-K2&0=3KOe5J>\B],9/dPfTT-,aT0UELXVg3c&KfS#?4S(O@&][@-/Z^&dG_B^,_
HMKL.KFDWfb2D(6YLf+a.#7@4f.R52O#ce(gOQA_0JOCP-0G8];8S+XR).#5N_QM
16U2&.9&AA-f?TJ[-#(US(GX=OK_3b;(=>&Z:I0cO9M=>2(05NNS?C?Ec.#>??#7
7<9_2ab:f+PUN7M4.]f+Mdgd\R_#8UXF^#?bQd6^LZAM(K5,(GC.91F?]D21<3P@
Z8J+ZSc1HV5IZcRSG1/(LReC)Sa8Y/TgHI1/NH,ac_:g#M1TgM92M&RAIdd#.YTJ
Obfb@PfH@]Ug/^d4&a]dDa/SI+0P?RWKd1F533;6Z9W/&aN.1_eL.&JNZIUZ[cY5
YRg>RIJ0I-4G[/97-__I#c?YS>1g?)e]N0XC,4[MA5d9f?2T(\1XO_(#]O[1OI0R
V1:dc.4K#F&++EQFP2?VLMVMATTecN?_d5gSN</9UQW[:KJg04S(WUSF_&[ODWQC
T8eY6-UC[YQD,S--fd<X&8F7Qa&OIJ8[aOF?OEP<LeC7-T^KM;AI=#G]F..A?127
b-gZTb;K]AbIUA)PCQbOHEOV0K^Md#bVa-D:<B,H7?6]QI<c]9JZ,fIW54bZbb6G
3V<7V0#5fUE?_:R<:,^=Qb5MdR#e[FNW)<X5FK3D1=H(OP4a/T9Q8^,LH:Z8eD)(
c#)X]P,fAd-SIB^18ROaC<-HP\(E@+PMb</(O?R.B.K[V(J]>-QZ>PP\Ja?T.(MP
8N-a.>RcJ>2&/,^dI[9A?9gS)Z25GRZbNd(9P^^(@f.;&(A0Bf:.e6Kc-E^QHS:R
_AF^E.1Xc(/&.K]<&M_U(Z_K)8O4OV2/,e7Ec/XX[EWSABJFIRD0&acMaK<99B\6
DT;377WA/N(;Y@0SAdSbHRAALWXR=E9R81DLE]M&Adc^W(XZV8-)d;AT:TYR/c#K
#M0JU=EHWVOfH9HEMK\5<ZefCFHT&TA0B;M7V[AfE^(?Rd/NV\#3B:S,,@TF\K/e
Sd0]?DOc26eJOV_b-_WcRJ[41_@_MJ@4J37?8O(IKX9gc34\;I:0@T+_NV_e,OKX
6=/<#JO]I6(f#D)@P/=4<A&R,D&(:6>OMfE(Db?JHT6[&g>a_75dZ#W\\504KZ?^
##LfL5Bd8:;6USWWHHdM@];WT^Le2@8gSOFP7=c&aH9&M\D=Q,]Z#<Z#&c(K796I
69+bXd&+^K_]?-9/MN#DI@RI-G^^S0]RQY@S1eX7\JNdS]G@8VaCdXNE[HHH_I_E
BG+VcX@)c[GOW64Le-=PF;M.Y]^<SKTOY5:L.C6fe2L=+^aPSQ^UYHO3H6b6MS/R
@B#)Y4GH-:^fE#M9HGZOBMPa?>BWB6ZC2_QZPX[=EO<0FN;G5#0KYFW?4(EfYW^J
Le_+F;8G8S>RZT=Ua0\[BRMBY,gc-7S=Ae6.GX;6(V2USZHDfd.47,:eI]>?\/+/
a&,B9+@/3D2=A)I_K&83;NP[Y8>\(H(UN>7[2]f[Ub>\4U&MT7d&8N[LH);e_BN#
\0AEgZW]IcaY64+VF[(C6/[\UPDcUO^fA#bMQf4baOHb<R].LU<>.><aO::b?])b
@7aPODfC3L;9&S/;?.9<I;YHZcFV@?HI6K5CX]FGHLQP8S7#SIJAQH@^4T,&;/(N
P,N@:\&CJ<cJLJbYUfDIRS;5.aZd,.3eUaDFHH,@H;:DV8EDE;0dCQXZ8[Z0[&gJ
+04H]L7R:KLCa(-&3HAE@&#27LRSeXI7I?e^03QUQNI<4g3bHB;dYg?Fg1/f(cUX
]6AWVP[8Q=/8[4URL2gR^P#aO;a>JK.1S9=&KX@QDR#AZ>T31TREVMNTf;:_B1P^
)WD8WY#?1T/WH@EMP8QPHE+JCRA#3/MR05Y;BPe68N63N46:e58L\/<A-SGWf+1<
9LG<RRCXZ@F8\a2Z>N=S;gB2Wa_I,CH\NLfP-\_b93I],<fQU;/9>13M8Df#_MZB
&Q#D+/&#6(O8.1,7><(TG:5(\e)Xc-(@]5dPS6^;&-ZC97RNB9R/3@J\VS#NHLdD
?0<&VBO@Q]N=9/@JVSU7[;]4X6GX:[Q8V,3#D\<>Z&Y2aNaQ,7H@N#Xc8+<PH;SV
Y_ZRO<EYVV-\WO6Bc+XVH28dI#Ya7Tc2GYR+0BTBCPc?TM4VX&CR7-]ZcKFCbR=L
A]SeS&bAGVD0?5AMF+0BO:(K?b/@8^=Id@USLI_c9,)>S]dFTV2009J<Q?Z0L4Z7
>4F):;#=UG)?77:]&X;:]P\NW(7,-.K:MLQUfg,H?6T^I5L\fe,8&5EFNP)(\D:.
BHN.NE0d4^IOXNX)FS/&F.29R]a-T8:EaOJ19T2]]9:9V?H;KK7(NM+)J392g(0F
9#e>eNS>\+D9)^eHY>2E/f+aMQ\L^Y<0?3aENE1<UCNZQ81,]^P5(/NeZDI>09WJ
PD[d)<?L9.1G?C?eMJCEO[2d@AWVNZb;4Qdd-d3^,JMYcV:VW2e?Yd>HR@J\,7.D
)2=R)?([@e)VW)EGGc[B(]&=L2OFI-,dCN/_P&JZa(00FRZFc@a2S6/bV5>6;JfN
YN3B9(6[=<32\eG@+,g^W)VE1M&VZV5&G2&R1#>ND]E1VGKD8ZG6O\[AZ8bG(0;<
d]D0^MKI:E4D3eVF1-R>9V-aaaJ.bI]WD<UW/?.]06?0R_X&:EPf[7P\@)94\\e[
c&S/f:\-TT=?YN9]\6FgT:fX-]U[Q6#)X<NDZ;-UG.9U#E:^);>WNZC;fgB-8_<8
#\+UaWMeSaW?H^(LYCf>6Q0MWSAQRWUK5C:4/2fV;g/Z=(;?##Zd-BP3T5L#IOcZ
&)b=>FK7ZAB@HH&N1J#U[>3/BQ#?,>.@Ze?G+7-C><>.=A,Q8<d4McE#<GR]TC3\
3+H_UJA10I(0^^J/eRG9O/H+7U>UFQP5N+0<B0BU5(;bR5A#PHKMgZQZH0Vb,K+d
N>_Z&J+L4Y22fZf@:4:dQAY#D#RU5bbdQ9=dg-B6NB<:=>U]+4.gREMD\^^;2#XV
V_fW-D6>+:S1:/U#<FZA2J^:b7Z<?f\DZ>Da#0Q]2UPQ?L-E+->9<?3@KN4J>#M<
;DJ+FNJ;#<\:b67W_YgE7Z,BST]0C0C]G)Qb4=_02>KSf9N+9e8ACf[[GUKbUJ1J
4.QKV6cTgfFA7B78-cK^dCSEH9g3@=AJ03dgWc3KDcIdc-J?cbaN=R&6Q0f@FSaZ
B&.]dLB:3?^fTK3e#4,+R=YYf?dT590+NJI66;0FHXCEKKY[/F@L1Xa@^B38_[EC
D@IP0cc^\?]&V;@WR&N[>EM)<g6N,VKa;H?da71SDF;;Y31e<P9B:8U/,7YBS.0P
[]E[ORL2(]?U(F-FHM:QMJP&_RI:J669T&d3FgWS4;)#8>X_K.SV@]^1IPdF(^;c
fEC]_DL(V]e99PEX/eZ56^J]25)>8NI.RWW[.MJ]JC9T7AEe4[ZEd:T5FdPK/b4Q
PP&>NZUTED8\92Sg[b<HUTcLX8=VQ-7d<CAOeEA.CeGa5Sf@#1)IS^b50Q2bQHgf
ONWK8c3QZ21W[[FRAeb9?R)Z&^37)&2;<d/F0M+fBXIaLG^TQ@A#GH@[G2)MIb7_
4Sg&/f7<<2P7/(UX.Le:0,ERIEIT<US4+WQJVZ650>JIF&OT^JCIb,I+U6S6KLYF
d3JJQXgc+;@&>3RT?Ved=RaDU\BA=0>P\0e6LAMYQ_(57G_#8;fJf?;YW5C3L6-D
/fKMUZS4<a([@HR>?RO)^.R?UP9K]1(Y2+-C5>NSJ.V3gMX(8aNHgJe]U=Y;;LX6
+]b4<[,\UF:\4Q1\C[@N5T_9?@YPY+5N)4@S3+aUN]VA-^KW4+]Sg^^8<B25[SHK
Z1FBa35eSg?8XJ8R2&/)LdIJ-O/eJfC0<UQODCQ806XS)]QL4705(2.KWVLVK1#<
G&1(#_L0U,<9P9gTIff=:\)@]8bXKJ.3YSCQDQ4)bbb@I&I-W0V;#)H_ZKRRY/N]
(7Y5][b:<f=_UE7ZVP/-?;R]3N&gI5c=@5NX=I/A_&WG&5J#1AP/TGW7)A02#[[8
2#dVM0b@L2VTJ&&@WCC\M(Qe<=&)B@D^VdBR[=&^VF3U>&<YO5RZDI>D2)4d;eTO
BOI@+dEbU34BW?)7gZa<<820JP@,Id@>CF.bRb+D).-gYF=H05&eFP/d=HL0e?J#
&dRYLU1AN7VO.KFf:_U9WU\3V]^a82H0E4>g=LF?BPO2N(?>E4ZGId@8J#1Fg//<
U,d\K=a4fW#B1)5abW5WWS0b2)YHAQT<\=J5OY9e[NfUWE63YH]\&D+4=C[RcG50
8=#=d(4=&8#9I]_[/)a\GP4\]b/40]TM:XWL-_44aH3L=@/./05]D(0,ZGH.&G\U
>#E2b@Q^,f1<9JI(707ALP\);:)#OACW\?GS04;gNJB?fCbLHLR\O^A[:FQ_VTI5
P2)[928a;O_b<N+QP[?S92>3Y^P19CbGSVF=-26?SM4f2>Zd&GE(ENPLXI0Y0c9M
ONP;-P:.#7SFL.8M3H=@=V)=00#-6_RY+^]:@TOQT9V78XF&,4B,I/U/36V2PCQa
&\GXB@V3gIVYWfR46a9+7M(4,S9Id:FN2J/E,#_NQ#JK?P9e0&6I]:O=QKK(=ET@
\5F+d0>,fADS6;:CMO0Ne^+JU?0/1T.Q7SW<CV5a)Xa=R523b8VdA)F;Y<DP5<6e
Yg2MSP@78IfSYROM#8>800T/2MfIAQ4TI#25:G.LD_9EH,SJ]&Sc=DS2LC1OLbW^
C[7<HZBO3Re6RV]Ic_M,3V#PAXQ.01G.73[UI9#eZ:a0\0b?M#Pfg5;^+Ge@D&=0
LO<Y6N59Of-,a.0)5+?,g#LF2HF:#^QY6FNWeH44aX97V,_dPG=SRe/+\9MRdba5
c6DJM[YTWB\g=c6a9b3@d.NY.(e4S17GOKRL75.(fCDb\GU(N^0=CQ1\0a+U)gED
VOZCLg;[c>Z_+BYYM=N.00WZJR>GK\WB[0B@==,&M58bUS;ITEb]EMa(D+8RgeVg
8/[Z7bN[46B6MbO]P3OJ;@<R\ZTO6d^eGT4VDLE6[20S1bIK?&dbbN]Ofg-cegD2
W,^9XfR6L5LX+=L/#TIQS+)5F][+;<A#P=QZ.7@B6DOR,W9NP1Jc0QFF^&4_RNZE
MF4F:aEcd]Jc5F:EK?2g##aff,U@G/RZX,J?_gX-6,:]?:P(#X:4L?KcO)>9MPc/
,DWA/YYQ;QWM(R2,Q.=S1=DdODfg=)GZ^VKb[\]]_;A4>VPMb&]K=2#ZJ9.ab>5#
T:GQUJK3>@2&P;8.LG(+bW,cY9.AJ6O:W=fg,[g7JMT8bVR55GgfZ[feMJR>6Q_;
FLA0YEf[A@5;/Q8P#W7J-#&+.M9:7K85IGFK5(+WH(LIWI\H?]:1&+0FFOK_.KW9
F=F5P[Hg+I>AcM0dZ)8&f-3J_6a2.>FZ61g7T4^D;0afHTdf9FAS?8(GYcXFV-Mg
WaeFD.H&Z#-IMAcN(c/dQ=^afO9OGcD(JMbagd)+BV/KS\_R#R:&5&@<A@=,f.K<
JYY?[]_0+2Q;OVX>&f&@GIA^9VIa05AH)\X:S2^f9Gde]<HLS6+F/VeHbLdJ+2YY
II7V+,3TC?3#:TJ<ZBMDLc.S:gdHJ690RV)NJ^)><?>YD^cbQaWIJa/>2)GEIOL5
HE(84YQUgY<BWG7a\7(M;N2GLCSV+>J\F5KG7BZBWL/f0bSC6BV9[+8TcEFbVGfN
PIC-QX2EQL23g;6-6A^Ge^Q@cP_/<[G)0?=WXI.df]b1EG=c#g<\1[Yf_:2).898
?XVS3<F6FYSHP;8//d3>H4PY[gM@Cb.e&d:J,0;;/6b\<(49P^55CbT(/N^HT2\;
d?_X-\^IU)WbPPBYeQG;Y5NFX]^8&(eB[Q@\]NU^U;MI,-O@#GX2Q44563B?AU<=
IZ31Pb3TAH]Q[E,CF9Q&<W](/N@BPd7?09L:P/RD/ASWP,=-&F@35._PJ1#[_4_V
>7I4OC]SHJA_)C,2V\7UO&AgCV]Q2/\)4T+YFVG.8a>)I;8M@G]f6D3;5^=,;)]0
;=R+;1LF]bZ>TbTSc1aDR@3E?<E4f.I-LbRVKbO0KFCL+Z00KM[f:M?65=IVbgcA
?U-VYYAgH-TR_J[56SRJ^H2VVWC6.JbG(MX5Kb4P:2>b2G=O[WBgM]J14Fc>[GVW
A^CU>,ZW\bK)]P]Xb/GUE#?\]1DGSeA2?2?U7LJ=1=YBB)LZ]6&cW7D)<5M.-5RC
4BVc/_78RIV=HWIJ/&N591U;bgNc,U7P/O<3?LdS0Yd-T8(4^4D.F=)f]-Bf8\<D
F#MacEGM7IU2J)BNQ.@.12aO8aRHN5EgYAegOgOMcW#WaHA:C/2#R;K>\Q(7J<Se
3QAZ38Y-@_bdUC.W.NE+b8H=4cS5e;^7>Y<gaL5g[<<d-cc=C/#2b42UW#:VU,91
@\O=G;g:EN8T1RJD&8gZ=(gPaeBIOS_I7e<M.X4XPga?7YOUMc0?.U#QBFF<5e@G
-7TE#)La?f_,SBJ?BN9-V+#.ZW)(7/3Q0Q.,MQVO<\3bW4-45Q97:+4J&R#MN6NS
[>@f.2R(B?I\b(K&a(fQ0F(#aKRI_O1?SOD+CJ5J@b=b9=,RfF@C@3;CG7/VaNP?
2VHaZ^LMOT0UE.+dbY-YSWK2FX3N?S.VI)@8cg[WRg_4?KV/[NVg&@E.D)MC>;E-
VfUA8?P\?7H8:]H(g&C;MN6a47D=7K8M_7Z7b(A+]+6;;b,_200:Ib<)5\5VQJL5
eFSMgJ5+725b0M?SUeIg<MYSS/M<]9L_AYOg]_Z<[T;dE64;WN)dLaQE(=cW(g0,
757D/\BL/XdW2KK?TE,feE#6Q-SI.BX/e,GVH8S++a:MB3O,<+END]18/3RW\YWg
83ROF>@5g([f]&I#M#W2P-:/G]1><<7f8<c8bgXaVRZ;9d]3ARd[@TTLfLWc,XD\
Gf2SBI[;8JQEO_-V3gXgT04S[+6>&Z8,Z<T.:e-\;9<d5e<A,(J?7>g@IBMLCE-M
&S8H0:ACRB96NJ2LGNFAFPBc9W@C[_S(E__AZ^?5N^=X0=WEN#KSeVA48<&:IW6]
#fF^PdN_d#F>Md;:F^D2ZJK^U\eMWNDT5&2]O]P<AJG_WBWXG-#PXaIWGL6;LN.c
S.V\DO)d#7Wf\D(V,bcWA]RVOW3JNLc18?[](,a2Y&XUUU+</f=\2e#D>]X8b5,X
;#ULTRHSTX#6YYTL])WQ&U9e:f646g=A+eOZB/VQVBE#1@FEL:=d:VaTd_RA4/6M
)gQa+,a8D940QE@4T)M7.@>+0:cR)(\T^^e_dAD]+;Z7?/:d7=+>48ZQRd[b_GUe
XLfUKTS#DdgE5DUAGc<TgE[D^,:K,?H#S4.S3UV?^]-,_E:LOEAb.&4<,V[@8W=R
g#\HK2LE&QRXYU28-E8TJE^fZHdX?&+8=T@f[]f;,e<=YDZJNR/2J#)SVNY3,&KM
Fb^)eeV-C:/Q/V1NX@:P1]d2^XadQ]T_6&@JD34.;ZEX(O;K4DDE^D[PLPO#?c68
T)Wae1)+.DQ_4LCTBLG3F^#UD(>-g6M7>d.0F)XcR_@\<cf?8YWLMZHQ90>N-:?#
-YKWQ6DQg?YMb,\O9JUS\1237#bCC;bONa7b8N2=Q@9AO14c\@0@<g>M7SV[X](:
IE>ba4;4[_^UOEZ-0=YS;\XIXEc5&(I:QCJZBfAGA1SMg(/LS.+VKXeBU6U?TDVV
c+\/efP463;VLJf-;Ng7:L@gAg-W&]MMff-9+&#?19&-=+1OC5FRgS^[Bf34eW8P
?=<5;A[.YR20Z]SP-=[Yc(N1?,>9Y,-K7?aBd[U.EB9E-1Bd^,>JfagSRGH^W38T
=(V.gE6L>KYX,;e+3B>L/P_A7:.AK5PM>>WSePRQ7+X21W=bZY0A&VY^VIJQ0S=(
EDL5?<a-H.3:5KI<2G-&&1?b&Dc?QMI6BKV=;FYcXITI7TPRP69&YR8M,D3;[=,b
a89,XHSH]c?6IKgHW0@FTW<^9SC-[CN385O7F/V<S[U3c4O;FKY,Rb^b.7OfZVF;
FSIXda--@ZED)-be_;?^,fD3f2.(IXUaZe\]FQLUZMMfa>R>FGYbd&N454bZ),:J
A:R96Dd0LG1d;.0]&g,T[IS1[a(,Z+AXF5K/UL\3,.:Y2[^G\4#D#[9Q/I3E8&0K
ZJb&GUIK?TL3P_:B_aJ)TK#A<g6FEBaV4CN1UXF2]9F2D;24/J8X/<6?4TMM-R5Z
7G2644FE?5DeH,(SM=U47M0JL__-C_,H5_1)&ZFBBV<Og/L&=8&gb=>Df3P-6;^e
/C-e4(=bELG;aAZf2Q)(I7T=59+(FV,H&F\,]CWf@4e\3F&HAcQb^e#=_WQJXTT/
2V/=X,0:30UVLN[1;V6Y73E[=Q\C:XG9d^[[49GCV.0Q=3COdYM&V4_EEU7gJgWS
\N?a5YT-9^]/HK.ec;=4\J,Q<ZI\:#8>\(LEN&G31YEA6/9MMId13IbTf^_dbGCc
RERNIHM[T^91fI((X,bcTV_/GOHfLU76JZ6QJ.\(=E6OW3ONYP4&3b=S6?.\EEb(
]4g,K;?35BTZA?N4LJ41O=f5P^A>#c9N<VM@#V5:44HC_P(E&G4\BOa/GD4)gcMT
Sf0bbWN&J@1]7ab/(^W]HTFX98bIOTT1^1g@FKS<^U_<,M0Xd6JXVDB@X4cb8#\3
(Nc_Z;:\S-;?dI[4#8<(:31N(e?Z:d^Ha=OBVI^T/QE./?\.Cg?A#c7dA<aJ+Q:M
eKC3?]35T&86:+NRaW32PGI4L/I\0)T(3^I;HUO&L?(X^:V@H1+\@0Z(.F5(.61)
BB6OB7K7D5XfJ-L.9L9K?4X0@b(b8M.@<372<QVLYIPPXQ7dH+V.fWY=C\Q/H:I&
;_XMCR?Qe\L-/P]?cE?,a5<O3YaS6]F,Ud)81T.;3KYS5K7I&bf=Te&9P7=OJDL(
e#a9L/JIagGR\G].1VC.>KHD].JfM#WZf?W^gN0U.9FK_ZY3(JR;W,,NW.GI@?cT
.W.e>(-gbc8L-PF(HE9HN@/N[5HCD-HEC>3836a;Y8C,^X09.C8OTS2V:@6VES-=
cEb4?]-F;Da8USNgZN6^:_[LO0\@B]eK<fS]7E<?=J+1S0=3XcSg>K?C(FK=WEC^
</_1cbP+B@1^@\3b&M0W]3,>?ffA8e&1dEC?a#F/>Oe6C/Gb:ReS]+]#g#>QWA(:
8e91PGR#LOeaOQdD@d^DY[_#87dQP5T]\Q:4aeeg:BUZeN23T@AN=R.@RA3N5,A2
1J5S[b<8g@[Q=+_C98CMFBQL8D:[?<?,=3d-UQBMSF>>QJKQOR8bfC7C]1QH.e.6
AB.H(3,F?<E,VRI6SEaEYSDE?,cHT\c+RafSAa7K0a.;F+#@cC/6.)<R)SJW0_AS
3]<@I7S-\[8J&YZG=J-O)ODE1$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

