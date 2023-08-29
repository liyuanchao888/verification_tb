
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_master_monitor_svt,R-2020.12,svt_apb_master_monitor_def_cov_util)

// =============================================================================
/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_apb_master_configuration handle as an argument, which is used for shaping
 * the coverage.
 */

class svt_apb_master_monitor_def_cov_callback extends svt_apb_master_monitor_def_cov_data_callback;

 `ifndef __SVDOC__
// SVDOC doesn't seem to like covergroups with arguments
  
    /**
    * Crosses WRITE transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_8bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 16 bit . This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_16bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 32 bit . This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_32bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_64bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_8bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 16 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_16bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 32 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_32bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_64bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
`endif


  /**
    * Coverage that Master works fine when PSLVERR is low  by  default and only goes
    * high when PREADY and PENABLE are 1. This cover group belongs to MASTER monitor.
    */
  covergroup trans_pslverr_signal_transition @(cov_pslverr_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR_TRANSITION
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pstrb. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pstrb @(cov_write_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSTRB
    apb_write_pstrb : cross write_xact_type, pstrb {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pprot. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pprot @(cov_write_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    apb_write_pprot : cross write_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pprot. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_pprot @(cov_read_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    apb_read_pprot : cross read_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and number of wait states. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_wait @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    apb_write_wait : cross write_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and number of wait states. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_wait @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    apb_read_wait : cross read_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pslverr. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pslverr @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_write_pslverr : cross write_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pslverr. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_pslverr @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_read_pslverr : cross read_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses transaction type and coverpoints. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_master_to_slave_path_access (int upper_bound) @(cov_master_to_slave_access_event); 
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_IDLE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSTRB
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR

    all_slaves : coverpoint path_cov_dest_names {
`ifdef VCS
    bins slvs_b[] = {[path_cov_dest_names.first() : path_cov_dest_names.last()]}with (ignore_slave_func(svt_amba_addr_mapper::path_cov_dest_names_enum'(item))) ;
`endif 
`ifndef VCS
    bins slvs_b[] = { [path_cov_dest_names.first():path_cov_dest_names.last()] };
    ignore_bins ig_bins[]  = ignore_slaves_list;
`endif
            }

    slaves_excluding_register_space : coverpoint path_cov_dest_names {
`ifdef VCS
      bins slvs_excluding_register_space[] = { [path_cov_dest_names.first():path_cov_dest_names.last()]} with (ignore_slave_no_cfg_func(svt_amba_addr_mapper::path_cov_dest_names_enum'(item)));
`endif 
`ifndef VCS
      bins slvs_no_cfg_b[] = { [path_cov_dest_names.first():path_cov_dest_names.last()] };
      ignore_bins ig_bins[]  = ignore_cfg_slaves_list;
`endif 
      }

    address_8 : coverpoint cov_xact.address iff (cfg.pdata_width == 8){ 
    option.weight = 0; 
      bins addr_range_min = {0}; 
      bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
      bins addr_range_max_8 = {(('d2**(upper_bound))-1)} ; 
    }

    address_16 : coverpoint cov_xact.address iff (cfg.pdata_width == 16) { 
    option.weight = 0; 
     bins addr_range_min = {0}; 
     bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
     bins addr_range_max_16 = {(('d2**(upper_bound))-2)}; 
    }

     address_32 : coverpoint cov_xact.address iff (cfg.pdata_width == 32){ 
    option.weight = 0; 
      bins addr_range_min = {0}; 
      bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
      bins addr_range_max_32 = {(('d2**(upper_bound))-4)}; 
    }

    address_64 : coverpoint cov_xact.address iff (cfg.pdata_width == 64){ 
    option.weight = 0; 
     bins addr_range_min = {0}; 
     bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
     bins addr_range_max_64 = {(('d2**(upper_bound))-8)}; 
    }

    four_state_rd_wr_sequence: coverpoint this.four_state_rd_wr_sequence {
      bins bin_RD_RD_RD_RD_SEQ =  {`SVT_APB_RD_RD_RD_RD_SEQ};
      bins bin_RD_RD_RD_WR_SEQ =  {`SVT_APB_RD_RD_RD_WR_SEQ};
      bins bin_RD_RD_WR_RD_SEQ =  {`SVT_APB_RD_RD_WR_RD_SEQ};
      bins bin_RD_RD_WR_WR_SEQ =  {`SVT_APB_RD_RD_WR_WR_SEQ};
      bins bin_RD_WR_RD_RD_SEQ =  {`SVT_APB_RD_WR_RD_RD_SEQ};
      bins bin_RD_WR_RD_WR_SEQ =  {`SVT_APB_RD_WR_RD_WR_SEQ};
      bins bin_RD_WR_WR_RD_SEQ =  {`SVT_APB_RD_WR_WR_RD_SEQ};
      bins bin_RD_WR_WR_WR_SEQ =  {`SVT_APB_RD_WR_WR_WR_SEQ};
      bins bin_WR_RD_RD_RD_SEQ =  {`SVT_APB_WR_RD_RD_RD_SEQ};
      bins bin_WR_RD_RD_WR_SEQ =  {`SVT_APB_WR_RD_RD_WR_SEQ};                            
      bins bin_WR_RD_WR_RD_SEQ =  {`SVT_APB_WR_RD_WR_RD_SEQ};
      bins bin_WR_RD_WR_WR_SEQ =  {`SVT_APB_WR_RD_WR_WR_SEQ};
      bins bin_WR_WR_RD_RD_SEQ =  {`SVT_APB_WR_WR_RD_RD_SEQ};
      bins bin_WR_WR_RD_WR_SEQ =  {`SVT_APB_WR_WR_RD_WR_SEQ};
      bins bin_WR_WR_WR_RD_SEQ =  {`SVT_APB_WR_WR_WR_RD_SEQ};
      bins bin_WR_WR_WR_WR_SEQ =  {`SVT_APB_WR_WR_WR_WR_SEQ};
    }

    four_state_err_resp_sequence: coverpoint this.four_state_err_resp_sequence {
      bins bin_OK_OK_OK_ERR_SEQ =    {`SVT_APB_OK_OK_OK_ERR_SEQ};
      bins bin_OK_OK_ERR_OK_SEQ =    {`SVT_APB_OK_OK_ERR_OK_SEQ};
      bins bin_OK_OK_ERR_ERR_SEQ =   {`SVT_APB_OK_OK_ERR_ERR_SEQ};
      bins bin_OK_ERR_OK_OK_SEQ =    {`SVT_APB_OK_ERR_OK_OK_SEQ};
      bins bin_OK_ERR_OK_ERR_SEQ =   {`SVT_APB_OK_ERR_OK_ERR_SEQ};
      bins bin_OK_ERR_ERR_OK_SEQ =   {`SVT_APB_OK_ERR_ERR_OK_SEQ };
      bins bin_OK_ERR_ERR_ERR_SEQ =  {`SVT_APB_OK_ERR_ERR_ERR_SEQ};
      bins bin_ERR_OK_OK_OK_SEQ =    {`SVT_APB_ERR_OK_OK_OK_SEQ};
      bins bin_ERR_OK_OK_ERR_SEQ =   {`SVT_APB_ERR_OK_OK_ERR_SEQ};
      bins bin_ERR_OK_ERR_OK_SEQ =   {`SVT_APB_ERR_OK_ERR_OK_SEQ};
      bins bin_ERR_OK_ERR_ERR_SEQ =  {`SVT_APB_ERR_OK_ERR_ERR_SEQ};
      bins bin_ERR_ERR_OK_OK_SEQ =   {`SVT_APB_ERR_ERR_OK_OK_SEQ};
      bins bin_ERR_ERR_OK_ERR_SEQ =  {`SVT_APB_ERR_ERR_OK_ERR_SEQ};
      bins bin_ERR_ERR_ERR_OK_SEQ =  {`SVT_APB_ERR_ERR_ERR_OK_SEQ};
      bins bin_ERR_ERR_ERR_ERR_SEQ = {`SVT_APB_ERR_ERR_ERR_ERR_SEQ};
    }

    pstrb_addr_aligned_unaligned16_coverpoint: coverpoint this.addr_aligned_unaligned16_coverpoint {
       bins  wr_addr_unalign16   = {`SVT_APB_WR_ADDR_UNALIGNED16};
       bins  wr_addr_align16     = {`SVT_APB_WR_ADDR_ALIGNED16};
       bins  rd_addr_unalign16   = {`SVT_APB_RD_ADDR_UNALIGNED16};
       bins  rd_addr_align16     = {`SVT_APB_RD_ADDR_ALIGNED16};
    }

    pstrb_addr_aligned_unaligned32_coverpoint: coverpoint this.addr_aligned_unaligned32_coverpoint {
       bins  wr_addr_unalign32   = {`SVT_APB_WR_ADDR_UNALIGNED32};
       bins  wr_addr_align32     = {`SVT_APB_WR_ADDR_ALIGNED32};
       bins  rd_addr_unalign32   = {`SVT_APB_RD_ADDR_UNALIGNED32};
       bins  rd_addr_align32     = {`SVT_APB_RD_ADDR_ALIGNED32};
    }

    pstrb_addr_aligned_unaligned64_coverpoint: coverpoint this.addr_aligned_unaligned64_coverpoint {
       bins  wr_addr_unalign64   = {`SVT_APB_WR_ADDR_UNALIGNED64};
       bins  wr_addr_align64     = {`SVT_APB_WR_ADDR_ALIGNED64};
       bins  rd_addr_unalign64   = {`SVT_APB_RD_ADDR_UNALIGNED64};
       bins  rd_addr_align64     = {`SVT_APB_RD_ADDR_ALIGNED64};
    } 

    cross_apb_to_slave_write_address_8_pslverr: cross all_slaves,write_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_8_pslverr: cross slaves_excluding_register_space,write_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_write_address_16_pslverr: cross all_slaves,write_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_16_pslverr: cross slaves_excluding_register_space,write_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_write_address_32_pslverr: cross all_slaves,write_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_32_pslverr: cross slaves_excluding_register_space,write_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_pslverr: cross slaves_excluding_register_space,write_xact_type,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_64_pslverr: cross slaves_excluding_register_space,write_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_write_pstrb_pprot: cross all_slaves,write_xact_type,pstrb,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_no_cfg_write_pstrb_pprot: cross slaves_excluding_register_space,write_xact_type,pstrb,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_write_pslverr:cross all_slaves,write_xact_type,pslverr {
    } 

    cross_apb_to_slave_write_wait : cross all_slaves,write_xact_type, cov_wait {
    }

    cross_apb_to_slave_no_cfg_write_wait : cross slaves_excluding_register_space,write_xact_type, cov_wait {
    }

    cross_apb_to_slave_read_address_8_pslverr: cross all_slaves,read_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_8_pslverr: cross slaves_excluding_register_space,read_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_read_address_16_pslverr: cross all_slaves,read_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_16_pslverr: cross slaves_excluding_register_space,read_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_read_address_32_pslverr: cross all_slaves,read_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_64_pslverr: cross slaves_excluding_register_space,read_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_read_address_64_pslverr: cross all_slaves,read_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_read_pprot: cross all_slaves,read_xact_type,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_no_cfg_read_pprot: cross slaves_excluding_register_space,read_xact_type,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_read_pslverr:cross all_slaves,read_xact_type,pslverr {
    } 

    cross_apb_to_slave_no_cfg_read_pslverr:cross slaves_excluding_register_space,read_xact_type,pslverr {
    } 

    cross_apb_to_slave_read_wait : cross all_slaves,read_xact_type, cov_wait {
    }

    cross_apb_to_slave_no_cfg_read_wait : cross slaves_excluding_register_space,read_xact_type, cov_wait {
    }


    option.per_instance = 1;
  endgroup

  function bit ignore_slave_func (svt_amba_addr_mapper::path_cov_dest_names_enum myitem) ;
    ignore_slave_func = 1;
    for (int k=0 ; k < ignore_slaves_list.size(); k++) begin
      if (myitem == ignore_slaves_list [k]) begin
        ignore_slave_func = 0;
        break;
      end
    end
  endfunction
   
  function bit ignore_slave_no_cfg_func (svt_amba_addr_mapper::path_cov_dest_names_enum myitem) ;
    ignore_slave_no_cfg_func = 1;
    for (int k=0 ; k < ignore_cfg_slaves_list.size(); k++) begin
      if (myitem == ignore_cfg_slaves_list [k]) begin
        ignore_slave_no_cfg_func = 0;
        break;
      end
    end
  endfunction

  /** 
   * Covergroup:  trans_four_state_rd_wr_sequence
   *
   * This cover group covers specific combinations of read and write
   * transactions, for a sequence of four transactions. For eg.
   * Write-Write-Write-Write or Write-Read-Write-Read, etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_rd_wr_sequence @(four_state_rd_wr_event);
    type_option.comment = "Coverage for Four State READ/WRITE for Ex:WR-WR-RD-RD, RD-WR-RD-WR, RD-RD-RD-WR etc";
    option.per_instance = 1;
     four_state_rd_wr_sequence: coverpoint this.four_state_rd_wr_sequence {
      bins bin_RD_RD_RD_RD_SEQ =  {`SVT_APB_RD_RD_RD_RD_SEQ};
      bins bin_RD_RD_RD_WR_SEQ =  {`SVT_APB_RD_RD_RD_WR_SEQ};
      bins bin_RD_RD_WR_RD_SEQ =  {`SVT_APB_RD_RD_WR_RD_SEQ};
      bins bin_RD_RD_WR_WR_SEQ =  {`SVT_APB_RD_RD_WR_WR_SEQ};
      bins bin_RD_WR_RD_RD_SEQ =  {`SVT_APB_RD_WR_RD_RD_SEQ};
      bins bin_RD_WR_RD_WR_SEQ =  {`SVT_APB_RD_WR_RD_WR_SEQ};
      bins bin_RD_WR_WR_RD_SEQ =  {`SVT_APB_RD_WR_WR_RD_SEQ};
      bins bin_RD_WR_WR_WR_SEQ =  {`SVT_APB_RD_WR_WR_WR_SEQ};
      bins bin_WR_RD_RD_RD_SEQ =  {`SVT_APB_WR_RD_RD_RD_SEQ};
      bins bin_WR_RD_RD_WR_SEQ =  {`SVT_APB_WR_RD_RD_WR_SEQ};                            
      bins bin_WR_RD_WR_RD_SEQ =  {`SVT_APB_WR_RD_WR_RD_SEQ};
      bins bin_WR_RD_WR_WR_SEQ =  {`SVT_APB_WR_RD_WR_WR_SEQ};
      bins bin_WR_WR_RD_RD_SEQ =  {`SVT_APB_WR_WR_RD_RD_SEQ};
      bins bin_WR_WR_RD_WR_SEQ =  {`SVT_APB_WR_WR_RD_WR_SEQ};
      bins bin_WR_WR_WR_RD_SEQ =  {`SVT_APB_WR_WR_WR_RD_SEQ};
      bins bin_WR_WR_WR_WR_SEQ =  {`SVT_APB_WR_WR_WR_WR_SEQ};
    }
  endgroup
  
 /** 
   * Covergroup:  trans_four_state_err_resp_sequence
   *
   * This cover group covers specific combinations of ERROR response
   * for a sequence of four transactions. For eg.
   * ERROR-ERROR-ERROR-ERROR or ERROR-OK-ERROR-OK etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_err_resp_sequence @(four_state_err_resp_event);
    type_option.comment = "Coverage for ERR RESPONSE for a sequence of four transactions";
    option.per_instance = 1;
     four_state_err_resp_sequence: coverpoint this.four_state_err_resp_sequence {
      bins bin_OK_OK_OK_ERR_SEQ =    {`SVT_APB_OK_OK_OK_ERR_SEQ};
      bins bin_OK_OK_ERR_OK_SEQ =    {`SVT_APB_OK_OK_ERR_OK_SEQ};
      bins bin_OK_OK_ERR_ERR_SEQ =   {`SVT_APB_OK_OK_ERR_ERR_SEQ};
      bins bin_OK_ERR_OK_OK_SEQ =    {`SVT_APB_OK_ERR_OK_OK_SEQ};
      bins bin_OK_ERR_OK_ERR_SEQ =   {`SVT_APB_OK_ERR_OK_ERR_SEQ};
      bins bin_OK_ERR_ERR_OK_SEQ =   {`SVT_APB_OK_ERR_ERR_OK_SEQ };
      bins bin_OK_ERR_ERR_ERR_SEQ =  {`SVT_APB_OK_ERR_ERR_ERR_SEQ};
      bins bin_ERR_OK_OK_OK_SEQ =    {`SVT_APB_ERR_OK_OK_OK_SEQ};
      bins bin_ERR_OK_OK_ERR_SEQ =   {`SVT_APB_ERR_OK_OK_ERR_SEQ};
      bins bin_ERR_OK_ERR_OK_SEQ =   {`SVT_APB_ERR_OK_ERR_OK_SEQ};
      bins bin_ERR_OK_ERR_ERR_SEQ =  {`SVT_APB_ERR_OK_ERR_ERR_SEQ};
      bins bin_ERR_ERR_OK_OK_SEQ =   {`SVT_APB_ERR_ERR_OK_OK_SEQ};
      bins bin_ERR_ERR_OK_ERR_SEQ =  {`SVT_APB_ERR_ERR_OK_ERR_SEQ};
      bins bin_ERR_ERR_ERR_OK_SEQ =  {`SVT_APB_ERR_ERR_ERR_OK_SEQ};
      bins bin_ERR_ERR_ERR_ERR_SEQ = {`SVT_APB_ERR_ERR_ERR_ERR_SEQ};
    }
  endgroup

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned16
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 16 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned16 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned16_coverpoint: coverpoint this.addr_aligned_unaligned16_coverpoint {
       bins  wr_addr_unalign16   = {`SVT_APB_WR_ADDR_UNALIGNED16};
       bins  wr_addr_align16     = {`SVT_APB_WR_ADDR_ALIGNED16};
       bins  rd_addr_unalign16   = {`SVT_APB_RD_ADDR_UNALIGNED16};
       bins  rd_addr_align16     = {`SVT_APB_RD_ADDR_ALIGNED16};
    }
  endgroup

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned32
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 32 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned32 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned32_coverpoint: coverpoint this.addr_aligned_unaligned32_coverpoint {
       bins  wr_addr_unalign32   = {`SVT_APB_WR_ADDR_UNALIGNED32};
       bins  wr_addr_align32     = {`SVT_APB_WR_ADDR_ALIGNED32};
       bins  rd_addr_unalign32   = {`SVT_APB_RD_ADDR_UNALIGNED32};
       bins  rd_addr_align32     = {`SVT_APB_RD_ADDR_ALIGNED32};
    }
  endgroup 

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned64
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 64 bits.
   * . 
   */
  covergroup trans_pstrb_addr_aligned_unaligned64 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned64_coverpoint: coverpoint this.addr_aligned_unaligned64_coverpoint {
       bins  wr_addr_unalign64   = {`SVT_APB_WR_ADDR_UNALIGNED64};
       bins  wr_addr_align64     = {`SVT_APB_WR_ADDR_ALIGNED64};
       bins  rd_addr_unalign64   = {`SVT_APB_RD_ADDR_UNALIGNED64};
       bins  rd_addr_align64     = {`SVT_APB_RD_ADDR_ALIGNED64};
    } 
  endgroup
  
   /**
    * Covergroup trans_read_x_on_prdata_when_pslverr to check if x on prdata when pslverrr = 1, pready = 1 and penable = 1 for read xact
    * applicable for apb3/apb4 only.
    */
  covergroup  trans_read_x_on_prdata_when_pslverr @(cov_read_x_on_prdata_when_pslverr_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_X_ON_PRDATA_WHEN_PSLVERR
  endgroup
   /**
    * Covergroup trans_apb_state_after_reset_deasserted to check IDLE and
    * SETUP state during reset deassertion (just after reset is de_asserted)
    */
  covergroup  trans_apb_state_after_reset_deasserted @(cov_reset_deasserted_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_APB_STATE_AFTER_RESET_DEASSERTED
  endgroup

   /**
    * Covergroup trans_apb_states_covered to check IDLE, SETUP and ACESS state
    * during the transaction
    */
  covergroup trans_apb_states_covered @(cov_state_sample_event);
   `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_APB_STATES_COVERED
  endgroup

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTUCTOR: Create a new default coverage class instance
   *
   * @param cfg A refernce to the APB System Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg);
`else
  extern function new(svt_apb_system_configuration cfg, string name = "svt_apb_master_monitor_def_cov_callback");
`endif

endclass

`protected
G=2C7e1BO3)E14SdOKS&1#3aM\)M8aYec.[L@E+B6CFT?9^Uc+R/-)#-2SCW>T:b
?_:1e,OE-MT\NP_:-YRYEU?L6EMKC1N+\=91VfVR]2WKI,=8FgHB6EBS)W@#K+;7
<;TOJ#UZ:SGfHVEb5M<(O-3?IE4>L5EAY3O>#0/0]fNJ99I,)8K6P:/7<^#FJJR+
1\B@SCKW[gT]C?(>O]4e0A_4/bgU6:,7fQ5P])dTR/3b#P8(27<;S(^Q>29F]QU(
)+ffW_+F0TF)VA=,OAMP+@JbYW/N@:(.g>B,^8@]L1UX/RCR&Tg<=7UgXRUb1]L=
gdFOZ:EXfU4YM[:((FDa:<<W2G@OZUd1Z+GG-2I3fOSPF47M2?T-P8A(D/1.NY1F
@XO\SFISXT++I>BYT\DX.#4MXgZ.,>_?+7UZf26>JbG>6ZMJ.,V>H^5^EKa]LQ^A
WXc]W/Q0?6Z(3Le@U6>=L4M_8UXPG<EX=B8;;]_#N0IYGFY.d<\Vb15\1X@@dX5@
,.?9Q>U:Ub<F/XYR-daA?NIF>]\:>Ab&]gba2QDIOd:FbI<(QTMc9W<TH@&2,N)7
\)9)/B@7D)HUBc=+Z#LS]\(:SYUDd+Y>-GSaNLH:&I&MA=F:+(-eg+__)C>e&f.&
TXFQY7#U?NdZ+]<eJ;H,XT>(0AT>cHRF4Ec;/ORWQ\.AFGLQ9D:B.Sf@M(g<e?5Q
2J:JTZgCTC/GJ3FT:fQWN^SPaJ(7TAQ8S;Be=C:Sd1:Zc9N2]e9_(\MRH1UdMGXA
aT/GRH958^(#:/LZ6V#a[#,/,^RIWN&GKd@2bSREF#L\VJQc/J91Q]DNd,;[D8N-
V1U2<,]2dA[L^DU4W;O0NY(Ob2]1:5/4,T#QL?]LLYC>PQ;W^A=cM&K-M@fXGc+T
A8a5332OU-4Z7GF==^NG5\Xa#9Xe\-Y08XM@VC+K]+F\15,B_.YP?.Z=fV#_0;;E
5[F;ffa@PU7??^V:O8>L=2<DQ.5VQZJeK5&=_=eTf463?b(0e_&gZGH/N\AVKPF,
->/YdJ?<If8R09=5eY#Z/B+D4NaIYb8Q<P?@Y7-Nf#QC;#CaZ]_Vae?b#d[?A7@X
?1]3=Ja4Zc\O+R1aDg+Ce/_1A=_,d@9#869;ZO[<W9cK@DB+NA&.CIWAPK\@-PG3
JO9=MY4(;>a++>bbR8e(I9f3[09)KYdDg8F;1>gGd??ZVZ-G,FVcN\S0JRZ>)@D,
S1C.IH#P(2YY&F_MF<A4A9)C<IAfB=2OBcBQNNgB4)CLO1,g3S.b^LQBI)<ZBJRc
11G.I8/\+)(ddH8.Hbg-S9)S:2+[a9P,GS:S,EQ&c61Z@^&8A2[UXZG=4.b#&=UQ
)>4T8JMA8GD49Ze;O4;>?^TbWUE(\H2G+a\eD0952E(0QG,+/01SdA0?I/OQVMBX
<BOd-NfbUe-cIGb#:2gIU<XV7,^dO9f\9MEW-9fF)/O#L:]/L()PR^_Tc3:4).-7
cQ7gA9dAH:I#+N?eS35JZ1&L-[F&HF=E>YcUGfEF2)6A+\<\O9#7<d[G/Z75J093
bLDXTHf0L5E/(^?VBD1D+;^Hd#X0OgG,D=bX9-B@E8TLd_</.:A4g#TI<&R8&0&O
J;_0NXT8Of-7V#4ZM-GEcDV+g+Ib9JbN:L7I\0OL,TZ7[/fIMAY=CLF:6HN<OBL]
R&Yd?a9DQ7=fAP2&#.6U9&eNO3d#e#f:bSQGA<7B(05eR1ZW;&5/.#&@AAU^^)_]
GN5=88Y8V>I+K2GFgU@VKgA_AG#RNDc5Ve&6N,?3X^b+H0RHc]H-,TcY4+E+.IUR
NQI#g,P1O.TC);DK69=Qa<CA)?gF[3]PCT=#.\7:3J3RZW?M#[_FI@U7IA\L\A2F
T5ALU((,F-VE(G#A0<V?><UZ[:>Z0c#Q(a1(dD/))V9K?AW]W.K_1^ZJ;XfQ:Hf+
STO4L@8f^2dS/B[9JP9a>4?/e)QNH[UB4+]KU<HKed<G)F4(OAA7.IN3dWHDG>LX
-U>>1b[b3-CPX?Z9)6IFNbBbNR-7\AfF34YgR#UHTQ)CAA?RO&FZ#3D8E=^11>&\
,5]]7U7_d9URaa9>;b+4be+D&YQY)[SU6;&SaCF]K7,e9;M>SeGLM6295;A8#3/]
ccgF<-?=Z](A;A/4[]W_+eE_I+WM=Z/f2JV3SEYKLa\85/3f5O0cd2\:LMC<:WXJ
C,cV66E10E2E]3<;:65V[@_dT8Hg2@+1HM0K()Q5Q\30)P@SZ:R/@XaZ@>@G^dFR
F9T>/25^&P[;bW+ge91C#RG<,2V7X6.LfTgPR#-^&T/_M-1ca]R8Mg2NGYd;L+=Z
LE#&-5_7MD2K1JF@--/g+C-S?O;dC)E\OU1bbag2f&.Z;2>b.O6=<EQ;ZTb+L(3-
94?T&&7?U_R1EbeDR^_EA;67@9XG>.^QgF>5L/:eHa?<c)2g?ae:B>M63>]8e[)9
J.UD+S^CM^6-W^:.a>B^Y5a?1+8FZJM4<L@//2/&DDOK,&TCO\FCZ\HNQ>F(D_;T
;0MA/#?YN30P6eWR1Y3?MY/#F<C:9\-.f2KbATBIa@cT=[1)<4.P@8cZc28IT\W-
7LE#6@eG.H(Y0(>H&E3[_/D<Yac0/4GO@cB&FMcV+@?#7RR,gI55TcALf2=ST7[N
I-1/9e.KFeYfKH+cC-G\1c+]:UA26\c.#._2]<FAGFSB[K_DCGS15?(J?^Lg6V1(
(<(\6^A_[GLSTBC+Eg9a<e_FaS3:EZ4Z;d?2XK[V56?[b71<,)9CQGA:=C/FKcSN
BY,PR(>Gd2JH)0<M/ZZUOE0M7e,ZGRfRL=EHg813G/H4WPWKSIY/d9cM39CPOgQa
?^gf8/&]64Z:Qea78O@C_P=Z]HS/,4+@;b,(,(YZJIUO(ZN_5a)DSN4+)?,(caR_
[=ef1T\-Wf<3NP?ed\1=8geW2)EbSIHHJ]Q#,4-J62\UH:Ra>]EW/P[Ld\Z5G8ZO
4+3R7aMP49gXCgM?]CVHE#ZB3],=/<9[dX2FPWT94=/HD7/-7R0<&RQO#8+9@gL_
<2E3@PY_)IYM1d)LM][P((cfd#2aLCIL[2=0T58<7=abC99e+=TGe2+^+d&8-_M=
56WGK9&E=I>Y.]@MNTQg=4d06D^<E74fG2Q5fUg/1gP@NCZ;5Nb[Da74UEU]/a9H
7QdEOgVLYWKDKNcQW_,W+cSZ&TO3cKK7[I]g@NQ)/+92CC.bNUA3HM.9DK4Db<cK
S#-dGZe[f_MX\4QbBF?d[PFN0(A&/cPZHZ:)F(O5fWFF2:M&bSV/@.?;^4B0-HMC
@c2J/2B3999K)R0D?+QIKLJT;aPQ0.c0DK8NJ<Z[3PJ>XNTBY2PFQ?7R,7[<d@H6
O=R_a7CI@,G^YE[59EI+U]#[b;MRO4Z5M]>B/4#T/Z]0:G6HL9-VB+<:#Q5Q&ZSA
;Q&))(RdY/+Oa?@]J#SAO]8g?WS+RH?JbCK/Ug)c&P]:7bfL(\?>L88,+H^NfV6E
dO1e1##AMX8[M+:4[c1NcB&,Q&X]5&&@f5/:AgMSfE)Qf=?@DNTe2?C27R\M.A<g
8fd&EY2^>V>9J&:8R+Tf/5dD-8RQDa>\V#:1W#?\&>+ZZ7:Z-DH_GRf]Ta^U5C/0
(:0TgXE9+g>Q)X=R7bfc0HB7=5@Y&HEM<CgU+[F.3H3)]XGP5C4c5I=6/?V7KN+H
BV8<K5V#[JQ05gPRV#@SHb5;?-).Y\0d[12aTJ0P9Z;8,9eMcU@C-SG-g@#&C7MW
[Ge.5>OXEU;Af#1Z^CRdfVfW/BP[B<N<G2CfNO8^78-VBW:XP^9_&D?Kb\4IS+O-
HK2=.:76G/4e],&W05LYXHL)6RaD6\0g(\@4Mc>_H[I_//If>\7[)HV>9M[X9gP=
&_I_K33/3=2EfS3#T8A(PK>T<K)X?e/bf74=J3@^<6?aRHVXfP-FA+aJXRXfA0W2
cVga73QM@]>KR989MY:9&1_E^cM\O-U<2#3;=X@Ad)B5fGG,8^#S[DY;S2^3,]K9
Y/Y44>X/>Tdb,5eO[cJf#d&0Y#624Z&_H1CgJ_\R,R?BD4A0;Z/d=62EFMW^EEUU
6-1&a?e@+5&=]U.eUZT;<.A0.Od+g<2-g5(:)a_]V^d4((L<BVKHL&UI_\L8RUJ\
\0A2(B^_1E1_g8TJ,B7ATI;N/ZKMXSXX9-CSAWP:g4@g:MXHc6gIG1-&LFH@b//H
cJfO/Ed<GY@Ie?0>QI:6J4>Je5A(S5)9I(32[<UF7Nf1T)E2a@DAFO^3<W+3ag=6
\c^&TB-M,dae]^)XZ.f+2<d8Ba7:GMLFIQb#+LZ<FQCV7+Tf&3&;@#\WfDR>Z9]>
L-e=337WgWXL2T#41&IfU62=cMQIL&;3^R&[dNa?MC:[<K]^/YZPUPGU.M3)DVI_
H-gf&@YZ07HVH4A3a>g,Q3X2S97cUcKJLK(&CSM7d[Vb#28Fg&BKCHb:FJJgd_F9
V5C,IaPN3DMWOf^1K+K\@:<L[MP,V;g:.[e&)e._@7G39[#H\_?:]BS3T=88CCbC
a#\;F:eIKO#5)_[)VUE7]&4DCE\e1SA1>O::UTA65Q+V@f4HXACHSLf#Y&M/S+(L
cQP;bR0b7eWeH[JWJ5IO?-@0?X(PPMfG>1F/XX[2S(AgB(/6B(Z>5?#Q/@DDXP3P
cGM<PNP,YGNOMbO8:S0I-NIY/]I/0I=4JAcG(I8R3CK1Z[(Ec9dK>N]R7WI#HEQV
E)O&U^)SCQ]&;D>-/0fgO39)d3:^+c<NE.ZE6cU2eL_e^BWKCdSM)3g1HDP/@VN?
6-YCF0-bfO[J-ASU>>E3QG?./0_fLI6&H]FYT[=R5gMf;Ae\<P6Y4:#HP>&f>8NX
<8/cZP7N#Y)Y](9]0VV0NRaZRH28OEA<fXgI:_1<:]b&<GKfMLGQCFE3614?=6b-
af4;a#@CQK_#<1>?VQ?KV#&4LXdLC_80M#8AdFbgM()a,0+J/]aNK:0<?<-?)E/U
43V>B&@IbJVR2H:K;FZB#2GU@V.+LPIWb&[dP.IaP3_eb[OU:].GeLF@0<ZU6YEJ
X@PX;;La_>P_cgEZJ^RT)ecQe)fT.03V34?Ae4Q]YRgB-:F/R)^VS>B]/);,C7#;
K=0?+eN:A2U/#NU4SK[eDSFHe1-827D669Re(#=GRHId7Z00Ia\[5J8L<LP9_^f?
,PgFESd15:.7.V,=GFB\X_;d+N)\61#;;;H4PEGN9a3L_WT.Q[HQT08[IMc[bT()
g[>^YHRJ#=[bVN?-7BG?[)aW-S6RHY>edCK,NMJG3K=TXG5cHRS633XEc(If&fKe
8;B1bVHCX;W756ObJc601A8J/>22-6c[[<9SAUeV<0E#3^SANX;0I6Y/:>2VS9^<
V9=>cCWVJHE/[9R.+K.>M>ONR_P@:4g\<]UA=GUNA<#N^0+_/;DVC=WN4_>LI\C3
&aTcE+e[Pe?H781+WBbO;23BI/.05:_gJ3cdXEaJ<c7ZF3@3?Y.dH6bHM_E[dKKa
IEI)=UMX/(0PJCICB6Td,7dR4,T]=\.9N@+K#/2&aXS<#]JH)OSP4AV/U+&,YYH=
fI[ZB&Hcd:E3WH-CL^Q]2LPOG45^K,2?DQ\::WOa:F8)78F8bC6PK9R?bRb/H#<Y
BDbUb@7P5T(7&>L9<_HH>g8/0eBV8)Z0Y+16KTJWX77fR_F8\UcVV,5)S[]T_,/2
\BPZD>EEVW\U)-?#Zc?3AeY(PLQFWc0#46^(?#UXE@[OIKSR-#GRBPUC&(DVN]:N
fbe70@-5KYXJBVHTHaXSRg@6[H&cNICSLM8JI6_L;@C9D?4#9Ie)bd5W=e<T&4Pb
1]W641Pe.#g/_)DUVUafBc(:-ME?-WMdN9G:=6608d=A2cFdcWA1,LL.a/GL:AG?
-Y^Dad_fJ.=8[g>RRP><?bOZ452\ZQ:6E7RPGWRAY]9/EG_TV7ZYGOJP[6LdLNW4
S)O@#bYRg+K^M>dNf8MU4&Xb\>.@g56<Q,]Q>:JO+U_+YTI.<3XML^.0H:D15;7;
+<ND+OY7953C\8c<ecfLeVC33Tg\U=KWR]ME+K\R\2Pf592UbGNTEH,OKeX?f:\0
eb.EWL:B2T0Z[)0[A>5&4cIC9UI\J4,=b\G1@_g/)#8:&2@R9dUHX=1Ecfe@RF(4
8e;:Kc_TG3:^G^RF70BJL#;S0B:1./CWV7G^Gc\]#P>[=]:^KT/YP9YOR?3K3HZ3
3H#28\e9<f_A\74,>gXa^a^EJK2&@7Ub&(=E4@3>_&e9:T(HN31>6WDU),8<U[Sb
6&L^F/.e[Ig(KNR;K83PGZ+a(NU>Ub449dV;b->NXQ&6M^9TbT9f32AF@Y,QbX6c
0^I3I_W\&_a/AVRT:Q/Y-a>UB;)=dS\,ccE22Ig0[>f800CWTGVXWR;7UUM#Ab@4
JaO&M4OGD1O&9)>[7(3fFT@?Z23c\<@1EdId]02UX)V:+KU_OfZUFIL/Rd(WO=],
:?&_N3&MD/3BSC(I&H[B+d7GDHMP2SZJg_,N7@fM1Q)B=/JBAG?HdTg7:Y0=]=2H
F9/\JdPGE5Pd/FNU6JPO34C_)U1_<CDcYc.RND5db)M9+E80B>Y[_eIAW=bAHD[/
FY6CIJ,9E;U4C>XX,fUHNJ8Q)@5DC2:2?7H2)52@-<Hg<NFGT,B<?=^UBX;8e)Me
U8+cX/F8g:J:E01,DV<J]?B:(-Sd^W(T#/7/4M;VX@Mg&54MF1C1MA3>M(K8<FIT
J=71DS/2:,2E+[/^@5F66R4Xag;IX(d268#L1G1Xa6RA9/Q(7^Ae@>1M6b9eSI(6
(XWa^.7THPQ.L_[2_L((@;)YI2CJgR5)Ae2,3^TWe>PS,Oe<)-@6;KLK;:W.])WI
<aNB0ETM0Kc3B2143IMb00/Na\88C0XE7]DW(:NBd6JJ4_0CT<RSeBG_&WBcI&TE
4:TJ7L-Yga3)?&K6W\dA#9C981N161O3@6SS..H-E^6\)<1f+NWF1gLX<6f=AWAP
aa1VDGB):e/C:18M\B.9L+QK1-W-V7H#8g^#PR9]E2LN8D&A/EXI#S0X;?9&/K>-
&O#9;150X]6-VWF8D+-V_AP<3)N<X,A(?\UYA],^Q3fL4K#\,GBfI;F^^7I4](,D
W4K2;HD/MWRdB6aH0)+:L3^,0X6<B/S#@XKXXKAP4TA9P2gMDG4]^#S#fBH]H;,R
bXeO#?JN2(K487&V5dULZP^>/WX6gb+DJ5I;5.Ab(f8BW_Dbd(FDNWU.-Q?.cZ\Q
09:G:I62K)X)#e:NdP@M?Z&A/\7aZK-:U^>7V+eY/?P1)(YV8_TOJd/]KH0M8V^\
:/GQ:-3J>)J(V5c]^P.;,L4Ag.]+XR8\-0da,3e?BFQVFAKP?+&gT:07e;R\D8E9
<138f3[AV,IJNB,QgTITG#0AN[_L/KI^dLJ]P\I>Le6TKEAe0aVID^Yfb8a@HMC.
=a\6.<U[S5,/\NFU?,^&UGSM,O8_2/]))X11g)eS8eY=)+&-,=])Ag:\FF:XG2)c
I&2O6#2+(R?U0>[6BRAP8+3fWN+JaeMeY:dG]PP#G6^1VP<XG./3?+DZd2a_[C5M
3d>c+LR]@EL8Y#O#G[^=(W)\.ZA#_D71^gJQ/R(&_.?:3IG[>@[T7W#I@&T:5b@)
/)g3X(P4G)f+:RJEDC=E?cW<aB<>c[H2>3SFfFbAS\a?,K]C?0,&=W#c[1]H-dD]
-,J-M@TJRN>a[HA3VJ^G?Ocfgc_4GB/P04AG#\Me>LJ0>[I0KV8LCgP>e6c,Qe.E
f9+SdfEO[KZSe=L)[U-H&PJS1M.V_<c4&XBU,B;9^IL,XH#7:ZB@@^VI:^MgD?VV
9geE[X?P,HHI0#6_G?BeT\Y&Cg71HBaSD@U0];Ubd.,4YZ)_VB+\+1VdRMA-=[ZH
IG/TD>V]5D?>-2,;M5)YGJ[@]LPEa=0A5=gc010O<b=\_>DN/_3\EA1YC;J2[<.I
X.g<?F/0K2XcM_9:R+^RED+BT/JIdRT/SW),aG<FVO7>HP,=4I;<DPH:3SR9J-G(
L._PEPBTFIQU.@?;IJS3e2UO9@6gIUS4g)T69O<1)b+^<2:N<9)#F6?b0Bg3;[VB
FVC>?bSgYI.4ZG.<?bLEdEPVf3b6f4L?WJ^JCdP/AMKH2aSV\Jc:I3DR.<f7>bDP
Ca7TS/239(9)#3TZGg+2SCRc@LUGeZf^TgYE&[NR5RN(O<GfgdCFU6934:e#K(MV
g+8QJW3+Zg#-aPK/;=ZTT<HNY5FKc[GK7ecS=3K;G5=1OR\1Hd)G.eOR+Q[fSe.S
c3-XHG5E4/>/9V(g^M(<cQ(CB:58a+_6[0+T9:^_S.KT,S:?96<C#&QQLY57eedN
Z8AE&a)Ib:J=BaYEJHdI[_01>R5PdPX8C^d0LZXPag0R9PU>+(gL2Rc?#SC;:LM1
ZZX2H6DPf&7/1G:6988d,U-2aGgJ2&>=XC89a[T]&58416AG(HN.&LU@T8@=C9YP
NB7OEB/D=./0_;QgHdX-IUf)Xb4367-,5Ea9fAV6+R^4CBV[>W<\\^fP2WOT-<W3
@I^5S@0#S;WHWX?>_5ca@:F5CJQ#]R(KV]E;>gc<+af]UCW4WV5YHNIbO<Ea<>B_
C;F.G[QS/XY[^E6V2@7F^\-YY-([_7L9,^b6;X+3+dSZX4fRb4-<BHdVeb8AS&TX
\I71M5/b<8@2RCK@gIT>/QB#B2@A/HC@Ta5IG(IR37U>HL#N62KT>#Z;(#:f#07-
72ANQTEN6S^5bd+8_[dd]=P2W)ADf.0&4@.R3C4+B,&7X32PH&WWe<QBL.L>P?18
8]=^O?WR?DYB.K,bCOdWe8Kb?(>QS1&g3T)//7D.19;94Q(C&H57.0.HRgEEL5Z-
J07?]9+d\-RK5)-HEJYUEH.38;S\SW6F_YAV]GPR284;(9X&#+7HgaFT;,f,)EaZ
\WI+J2RA,.W)>;L;Y\ON_a&gW9XNEDI06(_N]>>7L4;]E1.c0>#F]XMDf&/aJ;Wd
Bg@=&OGQ#HC@d7IWHK.W<O&KDXWB&T5SOM^XUX[J^4HUN?e-9c_G\1S:E9fB-C;b
L5BJ[:(5OXQL\e7G_H@23VB(&<SIZ+e]9616;A7,ZHYe]+JJFR)CX#J_4XC52:17
+M5aaO_X2V>2-3=8Ae:[YAT(JKMP,2X+TKTeH1[3CA+M8SM6-U=:b<CC@5)>15IO
J3PV+<Y:G>HffMCIRg8J8\0HHME5K4:e^d5>/-__O:eMH$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV
