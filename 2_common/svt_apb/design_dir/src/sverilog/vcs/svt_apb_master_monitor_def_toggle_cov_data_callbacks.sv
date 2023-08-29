
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_master_monitor_svt,R-2020.12,svt_apb_master_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_apb_master_toggle_bit_cov ;

  bit signal_index;
  event sample_event;

  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_CREATE_CG
 
  /** Constructor */ 
  extern function new();

  /** To get the signal's bit position to be sampled and event to trigger the
    * covergroup
    */
  extern function void bit_cov(bit b_bit);

endclass

class svt_apb_master_transition_low_cov ;
  /** Variable to store values of psel_penable_pready signal values */
  bit [2:0]   psel_penable_pready_low_signal_states;
  
  /** Event to trigger tansition_psel_penable_pready_low covergroup*/
  event cov_psel_penable_pready_low_sample_event;
  
  covergroup transition_psel_penable_pready_low @(cov_psel_penable_pready_low_sample_event); 
    option.per_instance = 1;      
    coverpoint  psel_penable_pready_low_signal_states{ 
      bins   idle_setup = (3'b000 => 3'b100); 
      bins   setup_access_wait = (3'b100 => 3'b110); 
      ignore_bins   setup_access_no_wait = (3'b100 => 3'b111); 
      ignore_bins   access_wait_access_completion = (3'b110 => 3'b111); 
      bins   acess_access = (3'b110 => 3'b110); 
      ignore_bins   access_idle = (3'b111 => 3'b000); 
      ignore_bins   access_setup =(3'b111 => 3'b100); 
      } 
  endgroup
//------------------------------------------------------------------------------
  function new();
    transition_psel_penable_pready_low = new();
  endfunction

endclass

class svt_apb_master_transition_cov ;
  /** Variable to store values of psel_penable_pready signal values */
  bit [2:0]   psel_penable_pready_signal_states;

  /** Event to trigger tansition_psel_penable_pready covergroup*/
  event cov_psel_penable_pready_sample_event;

  covergroup transition_psel_penable_pready @(cov_psel_penable_pready_sample_event); 
    option.per_instance = 1;      
    coverpoint  psel_penable_pready_signal_states{  
      bins   setup_access_wait = (3'b101 => 3'b110);
      bins   setup_access_no_wait = (3'b100 => 3'b111); 
      bins   access_wait_access_completion = (3'b110 => 3'b111); 
      bins   access_idle = (3'b111 => 3'b000); 
      bins   access_setup = (3'b111 => 3'b100); 
      } 
  endgroup
//------------------------------------------------------------------------------
  function new();
    transition_psel_penable_pready = new();
  endfunction

endclass

class svt_apb_master_transition_high_cov;
  /** Variable to store values of psel_penable_pready signal values */
  bit [2:0]   psel_penable_pready_high_signal_states;
  
  /** Event to trigger tansition_psel_penable_pready_high covergroup*/
  event cov_psel_penable_pready_high_sample_event;
  
  covergroup transition_psel_penable_pready_high @(cov_psel_penable_pready_high_sample_event); 
    option.per_instance = 1;      
    coverpoint  psel_penable_pready_high_signal_states{ 
      bins   idle_setup = (3'b001 => 3'b101); 
      ignore_bins   setup_access_wait = (3'b101 => 3'b110); 
      bins   setup_access_no_wait = (3'b101 => 3'b111); 
      ignore_bins   access_wait_access_completion = (3'b110 => 3'b111); 
      ignore_bins   acess_access_wait = (3'b110 => 3'b110); 
      bins   access_idle = (3'b111 => 3'b001);
      bins   access_setup = (3'b111 => 3'b101); 
      } 
  endgroup
//------------------------------------------------------------------------------
  function new();
    transition_psel_penable_pready_high = new();
  endfunction

endclass

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_apb_master_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual svt_apb_if.svt_apb_monitor_modport) extends svt_apb_master_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_apb_system_configuration cfg;

  MONITOR_MP apb_monitor_mp;

  /** Dynamic array declaration of the single bit coverage class for psel signal. */
  svt_apb_master_toggle_bit_cov psel_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for presetn signal. */
  svt_apb_master_toggle_bit_cov presetn_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for penable signal. */
  svt_apb_master_toggle_bit_cov penable_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pwrite signal. */
  svt_apb_master_toggle_bit_cov pwrite_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for paddr signal. */
  svt_apb_master_toggle_bit_cov paddr_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pwdata signal. */
  svt_apb_master_toggle_bit_cov pwdata_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pstrb signal. */
  svt_apb_master_toggle_bit_cov pstrb_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_master_toggle_bit_cov pprot_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_master_toggle_bit_cov prdata_toggle_cov[][];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_master_toggle_bit_cov pready_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for pprot signal. */
  svt_apb_master_toggle_bit_cov pslverr_toggle_cov[];

  svt_apb_master_transition_low_cov transition_psel_penable_pready_low_toggle_cov[];

  svt_apb_master_transition_cov transition_psel_penable_pready_toggle_cov[];

  svt_apb_master_transition_high_cov transition_psel_penable_pready_high_toggle_cov[];

  /** Constructor */ 
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_master_monitor_def_toggle_cov_data_callbacks");
`endif

  /** Called when the setup phase is detected. This is used to sample master signals */
  extern function void setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  
  /** Called when the access phase is detected. This is used to sample master signals */
  extern function void access_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  
  /** Callback issued when the transaction is in SETUP, IDLE or ACCESS state */ 
  extern function void sample_apb_states(svt_apb_master_monitor monitor, svt_apb_transaction xact);

  /** Called when the transaction is completed. This is used to sample slave signals */
  extern function void pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);
//----------------------------------------------------------------------------  
  /**
   * Callback issued when a resert is deasserted.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void post_reset(svt_apb_master_monitor monitor, svt_apb_transaction xact);

endclass

`protected
8;1(MCg;;2(aAD^e/S\g)Af&If2c7[@?;9?c]FI.56^-(TV4c/Zb3)8/PYbc/Y:_
1TJ5H_/QP4-EV-W74<JF\TE=__5V__2?8?M38c:_.JRJ_;6&<?\>0KG)VC#W/NJ,
?3>0ZFH1-+G4KYc-8GUWNT_AR^ffD;)0^[51aL.<Kf7XbO&MLZ._71YD^48XR3gY
C;R>D<._?D12>D(8],>-NU_A7$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_master_toggle_bit_cov::bit_cov(bit b_bit);

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
BS\RKT+\?DaV-gY86,e^\X)aE#dUK1Zd\7J^&2;0R)X6BC-fD8?:/)YDO?]Af5LB
JDX,WES)P@-S-HY=5W1GT?_<A?F:H1+\UWa<;9IV6IAZ/BZ6_9<V4=]^85B(5VXC
0eEJXQ@&&]\JP8=f;,<P9Lc+29R)5+b7#-M(V\;RD>9^&e;9A(?>\2J3.I+:OR\0
Z?&\#OH7<Z8+e<>U,Lb7UI3OP-N8c-0X4G(=,:Ia-=&-5,7cS]7Gff#I)JAF;31Z
1VN)(^/AfZCWA_Pa]?R0+;:#NRNWB4JG<YQ;/-bab8V4e&V_3#NJa2fB[(]SAF(8
f\Sag<,Z[,NCIF^#Y\XN^O22dWfBB4aZIKT\(M;F<?_LS[5.YTC#W:(g(/60WOc=
6K#ZL&L&TI&P6SXeUEa_]6eFf[0E1D&eMBT7O<MEGRO9&6NFcG3eTYVL++<HJG([
?)\A2gGSc5?2F#7@aWP4;Y4#=D&A?G21F50KDCNN;94Z,)8Y7DTD3.IaIa443<QC
XL/FGEZ.(Leg3WKHaFcbCeB.M4OJ2feK;=YY#9d;251FKZI_<GJ#QWH\@>dVY;JX
B24_>UC4(FB-;?L?be+0E\JfUA<aG.APKSF4d2U74A+MEC/=K6L;G2199(6\&8FF
,ZNOfR)V-WM[BOa\@?&^=7PD^.g.[[E@1)2,P/0>\,PMF$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_toggle_cov_data_callbacks::setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(psel)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(pwrite)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(paddr)
  
  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pwdata)
  end

  if (cfg.apb4_enable) begin
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pstrb)
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pprot)
  end
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pready)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pslverr)

  if(cfg.apb3_enable || cfg.apb4_enable) begin
    for(int i=0; i<cfg.num_slaves; i++) begin
      transition_psel_penable_pready_toggle_cov[i].psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
      ->transition_psel_penable_pready_toggle_cov[i].cov_psel_penable_pready_sample_event;
      if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b0) begin
        transition_psel_penable_pready_low_toggle_cov[i].psel_penable_pready_low_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_low_toggle_cov[i].cov_psel_penable_pready_low_sample_event;
      end
      else if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b1) begin
        transition_psel_penable_pready_high_toggle_cov[i].psel_penable_pready_high_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_high_toggle_cov[i].cov_psel_penable_pready_high_sample_event;
      end
    end
  end

endfunction

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_toggle_cov_data_callbacks::access_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  if(cfg.apb3_enable || cfg.apb4_enable) begin
    for(int i=0; i<cfg.num_slaves; i++) begin
      transition_psel_penable_pready_toggle_cov[i].psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
      ->transition_psel_penable_pready_toggle_cov[i].cov_psel_penable_pready_sample_event;
      if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b0) begin
        transition_psel_penable_pready_low_toggle_cov[i].psel_penable_pready_low_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_low_toggle_cov[i].cov_psel_penable_pready_low_sample_event;
      end
      else if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b1) begin
        transition_psel_penable_pready_high_toggle_cov[i].psel_penable_pready_high_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_high_toggle_cov[i].cov_psel_penable_pready_high_sample_event;
      end
    end
  end

endfunction

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_toggle_cov_data_callbacks::sample_apb_states(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(psel)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pready)
  if(cfg.apb3_enable || cfg.apb4_enable) begin
    for(int i=0; i<cfg.num_slaves; i++) begin
      transition_psel_penable_pready_toggle_cov[i].psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
      ->transition_psel_penable_pready_toggle_cov[i].cov_psel_penable_pready_sample_event;
      if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b0) begin
        transition_psel_penable_pready_low_toggle_cov[i].psel_penable_pready_low_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_low_toggle_cov[i].cov_psel_penable_pready_low_sample_event;
      end
      else if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b1) begin
        transition_psel_penable_pready_high_toggle_cov[i].psel_penable_pready_high_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_high_toggle_cov[i].cov_psel_penable_pready_high_sample_event;
      end
    end
  end

endfunction

function void svt_apb_master_monitor_def_toggle_cov_data_callbacks::post_reset(svt_apb_master_monitor monitor, svt_apb_transaction xact);
`SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(presetn)
endfunction

function void svt_apb_master_monitor_def_toggle_cov_data_callbacks::pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(psel)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(penable)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(presetn)

  if (xact.xact_type == svt_apb_transaction::READ) begin
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BITVEC_ARRAY(prdata)
  end
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pready)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(pslverr)

  if(cfg.apb3_enable || cfg.apb4_enable) begin
    for(int i=0; i<cfg.num_slaves; i++) begin
      transition_psel_penable_pready_toggle_cov[i].psel_penable_pready_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
      ->transition_psel_penable_pready_toggle_cov[i].cov_psel_penable_pready_sample_event;
      if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b0) begin
        transition_psel_penable_pready_low_toggle_cov[i].psel_penable_pready_low_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_low_toggle_cov[i].cov_psel_penable_pready_low_sample_event;
      end
      else if (apb_monitor_mp.apb_monitor_cb.pready[i] === 1'b1) begin
        transition_psel_penable_pready_high_toggle_cov[i].psel_penable_pready_high_signal_states={apb_monitor_mp.apb_monitor_cb.psel[i],apb_monitor_mp.apb_monitor_cb.penable, apb_monitor_mp.apb_monitor_cb.pready[i]};
        ->transition_psel_penable_pready_high_toggle_cov[i].cov_psel_penable_pready_high_sample_event;
      end
    end
  end

endfunction

`endif
