
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_slave_monitor_svt,R-2020.12,svt_apb_slave_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_apb_slave_toggle_bit_cov ;

  bit signal_index;
  event sample_event;

  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_CREATE_CG
 
  /** Constructor */ 
  extern function new();

  /** To get the signal's bit position to be sampled and event to trigger the
    * covergroup
    */
  extern function void bit_cov(bit b_bit);

endclass

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_apb_slave_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual svt_apb_slave_if.svt_apb_monitor_modport) extends svt_apb_slave_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_apb_slave_configuration cfg;

  MONITOR_MP apb_monitor_mp;

  /** Variable to store value of psel_penable_pready_low signals */
   bit [2:0]   psel_penable_pready_signal_states_low;

  /** Variable to store value of psel_penable_pready signals */
   bit [2:0]   psel_penable_pready_signal_states;

  /** Variable to store value of psel_penable_pready_high signals */
   bit [2:0]   psel_penable_pready_signal_states_high;

  /** Event to trigger tansition_psel_penable_pready_signal_low covergroup */
   event cov_psel_penable_pready_sample_event_low ;

  /** Event to trigger tansition_psel_penable_pready_signal covergroup */
   event cov_psel_penable_pready_sample_event ;

  /** Event to trigger tansition_psel_penable_pready_signal_high covergroup */
   event cov_psel_penable_pready_sample_event_high ;

  /** Dynamic array declaration of the single bit coverage class for psel signal. */
  svt_apb_slave_toggle_bit_cov psel_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for presetn signal. */
  svt_apb_slave_toggle_bit_cov presetn_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for penable signal. */
  svt_apb_slave_toggle_bit_cov penable_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pwrite signal. */
  svt_apb_slave_toggle_bit_cov pwrite_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for paddr signal. */
  svt_apb_slave_toggle_bit_cov paddr_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pwdata signal. */
  svt_apb_slave_toggle_bit_cov pwdata_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pstrb signal. */
  svt_apb_slave_toggle_bit_cov pstrb_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_slave_toggle_bit_cov pprot_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_slave_toggle_bit_cov prdata_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_slave_toggle_bit_cov pready_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_slave_toggle_bit_cov pslverr_toggle_cov[];

  /** Constructor */ 
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_slave_monitor_def_toggle_cov_data_callbacks");
`endif


  /** Called when the setup phase is detected.  This is used to sample slave signals */
  extern function void setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  /** Called when the transaction is completed.  This is used to sample slave signals */
  extern function void pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);

 /**
   * Callback issued when a resert is deasserted.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void post_reset(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

 /** Called when the access phase is detected.  This is used to sample slave signals */
  extern function void access_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  /** Callback issued when the transaction is in SETUP, IDLE or ACCESS state. */
  extern function void sample_apb_states(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

endclass

`protected
]EAA80?Za9S:Hc_eODW[A0]=#]7@)5?60KY0MI=(&02gQ_?EKA11,)O0S:&]N-2R
AQ6R3Y[HVVD>dN;-7.J9<18bJOU7F0-4^3LHCU5_4+-+KO]K1#I#&(\ZG1(03]0b
5B5)_GV5JEPCB#Y>PY@LB)X;VJE6bZTfXO0.8WL)aR;4e^gG0]KedE]-G9K0Dg(1
]\UJCW1bc@_b>dP0-)43RHX;6$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_slave_toggle_bit_cov::bit_cov(bit b_bit);

//    signal_index = b_bit;
//    ->sample_event;
/** Rewritten the above code  as following for better performance as per VCS R&D's suggestion */
  if (signal_index != b_bit) begin
    signal_index = b_bit;
    toggle_cov.sample();
  end
endfunction
  
//------------------------------------------------------------------------------
`protected
LWf0@DS,T#c)Y-7>1->OWW=[.LBFb\W,\c)/EY-8-D1>,-6;&YM71):?;b>TGH-&
Q9a(O^PVLQeTeT;JE,G\7g-<>#&HbaQg9-AWWBZJC-HL)5,.8@Yg[&CD@)WYKUQD
0O/SCOMCL\5-CePR>Q1\d+C@)Af<C&T/1@/gNYD>DP>b?I;ZeQPef_L7>gI0b,RM
GdNZC,5<B-Sc&J=K0+AB<[&Q+[.O)N&-?WRE<89^SW8[X\c#L^47&U:R3RSO#J\D
E6#_E_0fFOWQPG/KE=Q[@G_JF.LTJ//=?R]Hf-_&]F:/c3[Y+.^HJUOQW91R:deC
Z_4[:52()b<>SX@05[G<=8(6[c(7]0;3WdQWE8=(SB.cSSdAA^B&IH=+TW6X@)3+
>2J]9cGJXg4R@1#A[6D9,?2[bBF&/B>f\B\E,)E/.;6U5W4ZH7a:\@9X_>CV?D)0
C4M&ce7H7GI]/d2.23E:6PY]6;ATOA:<d]1,5BP2&Sa8;Fe&W3eW/K^HdL:5M^/#
X_+7&C>-;J/1fQATL#bgC@c)^)XJYLOUPb<A_TG7b_abO]g_(S-O;PfYdYN6c/@P
6L[caP#EO]TWfN6ULKSCLWMDFCUKY,71[;,X(?c3I4]DTH7;MDe<7(.Q8H-N0YB^
<P[XMM:B1S_Je>RC+VONJ==3]=84g^#)@$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_toggle_cov_data_callbacks::setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);
  
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(psel)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pwrite)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(paddr)

  if(cfg.sys_cfg.apb3_enable || cfg.sys_cfg.apb4_enable) begin
    psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
    ->cov_psel_penable_pready_sample_event;
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b0) begin
      psel_penable_pready_signal_states_low={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_low;
    end
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b1)begin
      psel_penable_pready_signal_states_high={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_high;
    end
  end

  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pwdata)
  end
  
  if (cfg.sys_cfg.apb4_enable) begin
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pstrb)
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pprot)
  end
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pready)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pslverr)
endfunction

function void svt_apb_slave_monitor_def_toggle_cov_data_callbacks::post_reset(svt_apb_slave_monitor monitor, svt_apb_transaction xact);
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(presetn)
endfunction
//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_toggle_cov_data_callbacks::access_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  if(cfg.sys_cfg.apb3_enable || cfg.sys_cfg.apb4_enable) begin
    psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
    ->cov_psel_penable_pready_sample_event;
     if(apb_monitor_mp.apb_monitor_cb.pready === 1'b0) begin
       psel_penable_pready_signal_states_low={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
       ->cov_psel_penable_pready_sample_event_low;
     end
     if(apb_monitor_mp.apb_monitor_cb.pready === 1'b1) begin
       psel_penable_pready_signal_states_high={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
       ->cov_psel_penable_pready_sample_event_high;
     end
  end

endfunction

//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_toggle_cov_data_callbacks::sample_apb_states(svt_apb_slave_monitor monitor, svt_apb_transaction xact);
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(psel)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pready)
  if(cfg.sys_cfg.apb3_enable || cfg.sys_cfg.apb4_enable) begin
    psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
    ->cov_psel_penable_pready_sample_event;
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b0) begin
      psel_penable_pready_signal_states_low={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_low;
    end
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b1) begin
      psel_penable_pready_signal_states_high={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_high;
    end
  end
endfunction

function void svt_apb_slave_monitor_def_toggle_cov_data_callbacks::pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(psel)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)

  if (xact.xact_type == svt_apb_transaction::READ) begin
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(prdata)
  end
   
  if(cfg.sys_cfg.apb3_enable || cfg.sys_cfg.apb4_enable) begin
    psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
    ->cov_psel_penable_pready_sample_event;
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b0) begin
      psel_penable_pready_signal_states_low={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_low;
    end
   
    if(apb_monitor_mp.apb_monitor_cb.pready === 1'b1) begin
      psel_penable_pready_signal_states_high={apb_monitor_mp.apb_monitor_cb.psel, apb_monitor_mp.apb_monitor_cb.penable , apb_monitor_mp.apb_monitor_cb.pready};
      ->cov_psel_penable_pready_sample_event_high;
    end
  end
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pready)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pslverr)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(presetn)

endfunction
   


`endif
