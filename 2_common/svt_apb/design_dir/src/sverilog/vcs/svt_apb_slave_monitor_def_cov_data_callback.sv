
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_apb_defines.svi"

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_apb_slave_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_apb_slave_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_apb_slave_monitor_def_cov_data_callback extends svt_apb_slave_monitor_callback;

`ifndef __SVDOC__
  /** Virtual interface to use */
  typedef virtual svt_apb_slave_if.svt_apb_monitor_modport APB_IF_MON_MP;

  /** Virtual interface to use */
  protected APB_IF_MON_MP apb_if_mon_mp;
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_apb_slave_configuration cfg;

  /** Event used to trigger the write transaction covergroups for sampling. */
  event cov_write_sample_event;

  /** Event used to trigger covergroups trans_cross_write_pprot and trans_cross_write_pstrb when apb4_enable = 1 */
  event cov_write_sample_apb4_signals_event;

  /** Event used to trigger covergroup trans_cross_read_pprot when apb4_enable = 1 */
  event cov_read_sample_apb4_signals_event;

  /** Event used to trigger the read transaction covergroups for sampling. */
  event cov_read_sample_event;

  /** Event used to trigger PSLVERR covergroups for sampling. */
  event cov_pslverr_sample_event;  
  
  /** Event used to trigger Four WRITEs/READs. */
  event four_state_rd_wr_event;

  /** Event used to trigger PSLVERR of four transactions. */
  event four_state_err_resp_event;
  
  /** Event used to trigger the covergroup trans_read_x_on_prdata_when_pslverr*/
  event cov_read_x_on_prdata_when_pslverr_sample_event;

  /** Event used to trigger covergroup trans_apb_state_check_after_reset_deasserted*/
  event cov_reset_deasserted_sample_event;

  /** Event used to trigger covergroup trans_apb_states_covered*/
  event cov_state_sample_event;

  /** Event used to trigger Aligned/Unaligned transfer */
  event cov_apb4_align_unalign_addr_event;
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through pre_output_port_put callback method. */
  protected svt_apb_slave_transaction cov_xact;

  /** Coverpoint variable used to hold sampled values of PSLVERR when PENABLE
   * and PREADY are high */
  protected logic cov_xact_pslverr = 1'bx;

  /** Coverpoint variable used to hold Four State Write/Read xacts. */
  protected int four_state_rd_wr_sequence=-1;

  /** Coverpoint variable used to hold Four State PSLVERR response coverage. */
  protected int four_state_err_resp_sequence=-1;

  /* variable used to hold completed RD/WR xacts. */
  protected bit four_state_rd_wr_queue[$];

  /* variable used to hold four State PSLVERR response . */
  protected bit four_state_err_resp_queue[$];

  /* variable used to hold aligned/unaligned address when pdata_width is 16 bit . */
  protected bit [1:0] addr_aligned_unaligned16_coverpoint;

  /* variable used to hold aligned/unaligned address when pdata_width is 32 bit . */
  protected bit [1:0] addr_aligned_unaligned32_coverpoint;

  /* variable used to hold aligned/unaligned address when pdata_width is 64 bit . */
  protected bit [1:0] addr_aligned_unaligned64_coverpoint;
  
  /** Coverpoint variable used to update if x on prdata when pslverr
    * Applicable for APB3/APB4 for read transaction
    * Called in pre_output_port_put callback method. */
  protected bit cov_read_x_on_prdata;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new svt_apb_slave_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AXI Port Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_slave_configuration cfg);
`else
  extern function new(svt_apb_slave_configuration cfg, string name = "svt_apb_slave_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------  
  /**
   * Callback issued when a Port Activity Transaction is ready at the monitor.
   * The coverage needs to extend this method as we want to get the details of
   * the transaction, at the end of the transaction.
   */
  extern virtual function void pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Called when four_state_rd_wr_queue is filled with four READ/WRITE transactions,to trigger
   * corresponding covergrop events
   */
  extern virtual function void trigger_four_state_rd_wr_event();
  //----------------------------------------------------------------------------
  /**
   * Called when four_state_err_resp_queue is filled with four ERR/OK responses,to trigger
   * corresponding covergrop events
   */
  extern virtual function void trigger_four_state_err_resp_event();
  
  /** @endcond */
  //----------------------------------------------------------------------------  
  /**
   * Callback issued when a resert is deasserted.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void post_reset(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

   /**
   * Callback issued when a resert is deasserted.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void sample_apb_states (svt_apb_slave_monitor monitor, svt_apb_transaction xact);
endclass

`protected
=c3G^Z4HceIfGd;SV0#>dFHPR5?0#+#X&cB.Oa?M]9[3AaTY@P,g7);CGCC<#Xa\
HEb1X?VJ0U6[].,/D<M\0TeO]1#&TTN^2W^a+JfL..e0&X2IW5AeZ4IbJZ6B58&)
,L;,6e6^e<[d]DFgcY:-f4d+Z>>2DbYeB;D36[Z@bCI:4RTN;1CNOM,3HVZ13/8R
cJRb9G5ZFM0Q_ZVI;Ib+.,;N#fXMND4:QdN5_B\10407Q,03:M>5&&1K6X1J77PT
5+S@QY75.#b3+;O=.&7H>WVCe>Db6,e189LV=IHPWDOM<M>,I9]])eD&>H@[X^S+
5C3c<9B<LDSX+[M8A,?S\Z]<2R=<X_WZa-3I1,1#<9=TS_HU(+f-,CDN?20&P7gX
cQ@JYdeXR^^TIg30L.@.Q(?E1AV</OM+c::e;2TbfG9-V#CV_&c7L7Q_YM=AJAMI
KFVEZ/3Be7&]2]b[DL4P&>I0C:NP7VLfN08I#ME\U413-F^RFfO_/2Y+eUd<=8IL
@II_bPgLUI54\fR/g\c-Ke)g9)#SAE[G3Z]+=<;f.S6E?WHD8)cIHgBUfH#XW[J/
S,2gW.GVX\&>cScdMBKC+3)g6$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_cov_data_callback::pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);

  $cast(this.cov_xact, xact);

  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    ->cov_write_sample_event;
    if(cfg.sys_cfg.apb4_enable)
      ->cov_write_sample_apb4_signals_event;
  end
  else begin
    ->cov_read_sample_event;
    if(cfg.sys_cfg.apb4_enable)
      ->cov_read_sample_apb4_signals_event;
  end

  // Only applicable when svt_apb_system_configuration::apb3_enable or
  // svt_apb_system_configuration::apb4_enable is set
  if (cfg.sys_cfg.apb3_enable || cfg.sys_cfg.apb4_enable) begin
    if (this.apb_if_mon_mp.apb_monitor_cb.pready && this.apb_if_mon_mp.apb_monitor_cb.penable) begin
      cov_xact_pslverr = this.apb_if_mon_mp.apb_monitor_cb.pslverr;
      -> cov_pslverr_sample_event;
    end
  end 
   if(cfg.trans_four_state_rd_wr_sequence_cov_enable)
    begin
      if(xact.xact_type == svt_apb_transaction::READ)
        four_state_rd_wr_queue.push_back(svt_apb_transaction::READ);
      else if(xact.xact_type == svt_apb_transaction::WRITE)
        four_state_rd_wr_queue.push_back(svt_apb_transaction::WRITE);
      if(four_state_rd_wr_queue.size() >=4)
        trigger_four_state_rd_wr_event();
    end
  if(cfg.trans_four_state_err_resp_sequence_cov_enable)
     begin
       if(xact.pslverr_enable == 1'b0)
        four_state_err_resp_queue.push_back(1'b0);
      else if(xact.pslverr_enable == 1'b1) 
        four_state_err_resp_queue.push_back(1'b1);
      if(four_state_err_resp_queue.size() >=4)
        trigger_four_state_err_resp_event();
    end

  if(cfg.sys_cfg.apb4_enable) begin  
   if(cfg.sys_cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_16 ) begin
     if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin
       if(cov_xact.address[0] != 0 || cov_xact.pstrb[0] == 0  )
         addr_aligned_unaligned16_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED16 ;
       else 
         addr_aligned_unaligned16_coverpoint = `SVT_APB_WR_ADDR_ALIGNED16;
       end 
     if(cov_xact.xact_type == svt_apb_transaction::READ) begin
       if(cov_xact.address[0] != 0)
         addr_aligned_unaligned16_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED16 ;
       else 
         addr_aligned_unaligned16_coverpoint = `SVT_APB_RD_ADDR_ALIGNED16;
       end 
     ->cov_apb4_align_unalign_addr_event;
   end
   else if(cfg.sys_cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_32) begin
     if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin  
       if(cov_xact.address[1:0] != 0 || cov_xact.pstrb[0] == 0)
         addr_aligned_unaligned32_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED32;
       else 
         addr_aligned_unaligned32_coverpoint = `SVT_APB_WR_ADDR_ALIGNED32;
     end
     if(cov_xact.xact_type == svt_apb_transaction::READ) begin  
       if(cov_xact.address[1:0] != 0)
         addr_aligned_unaligned32_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED32;
       else 
         addr_aligned_unaligned32_coverpoint = `SVT_APB_RD_ADDR_ALIGNED32;
     end
     ->cov_apb4_align_unalign_addr_event;
   end  
  else if(cfg.sys_cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_64) begin
    if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin
     if(cov_xact.address[2:0] != 0 || cov_xact.pstrb[0] == 0 )
       addr_aligned_unaligned64_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED64;
     else 
       addr_aligned_unaligned64_coverpoint = `SVT_APB_WR_ADDR_ALIGNED64;
   end
   if(cov_xact.xact_type == svt_apb_transaction::READ) begin
     if(cov_xact.address[2:0] != 0)
       addr_aligned_unaligned64_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED64;
     else 
       addr_aligned_unaligned64_coverpoint = `SVT_APB_RD_ADDR_ALIGNED64;
   end
   ->cov_apb4_align_unalign_addr_event;
  end 
 end 
  // Implementation for trans_read_x_on_prdata_when_pslverr cg
  if (xact.xact_type == svt_apb_transaction::READ && (cfg.sys_cfg.apb3_enable == 1'b1 || cfg.sys_cfg.apb4_enable == 1'b1)) begin
     if (apb_if_mon_mp.apb_monitor_cb.pslverr == 1'b1 && apb_if_mon_mp.apb_monitor_cb.pready == 1'b1 && apb_if_mon_mp.apb_monitor_cb.penable == 1'b1) begin
       // check if prdata has x
       if ($isunknown(apb_if_mon_mp.apb_monitor_cb.prdata)) begin
          cov_read_x_on_prdata = 1;
          -> cov_read_x_on_prdata_when_pslverr_sample_event;
       end
     end  
  end
endfunction

//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_cov_data_callback::post_reset(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  // trigger the event to update the trans_apb_state_after_reset_deasserted cg
  -> cov_reset_deasserted_sample_event;
endfunction

//----------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_cov_data_callback::sample_apb_states(svt_apb_slave_monitor monitor, svt_apb_transaction xact);
  
  // trigger the event to update the trans_apb_states_covered covergroup
  -> cov_state_sample_event;
endfunction

//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_cov_data_callback::trigger_four_state_rd_wr_event();
  bit [3:0] four_state_rd_wr_var;
  for(int i = 0 ;i < 4; i++)
  four_state_rd_wr_var[i] = four_state_rd_wr_queue[i]; 
  case(four_state_rd_wr_var[3:0])
      `SVT_APB_RD_RD_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_WR_RD_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end 
       `SVT_APB_WR_WR_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_WR_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_WR_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_WR_RD_SEQ;
         ->four_state_rd_wr_event;
         end  
       `SVT_APB_WR_WR_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_WR_WR_SEQ;
         ->four_state_rd_wr_event;
         end  
  endcase
         void'(four_state_rd_wr_queue.pop_front());
endfunction //trigger_four_state_rd_wr_event
//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_cov_data_callback::trigger_four_state_err_resp_event();
  bit [3:0] four_state_err_resp_var;
  for(int i = 0 ;i < 4; i++)
  four_state_err_resp_var[i] = four_state_err_resp_queue[i]; 
  case(four_state_err_resp_var[3:0])
      `SVT_APB_OK_OK_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_OK_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_OK_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_ERR_ERR_SEQ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence =  `SVT_APB_OK_ERR_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence =  `SVT_APB_ERR_OK_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end  
      `SVT_APB_ERR_ERR_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end  
  endcase
         void'(four_state_err_resp_queue.pop_front());
endfunction //trigger_four_state_err_resp_event

`endif // GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV
