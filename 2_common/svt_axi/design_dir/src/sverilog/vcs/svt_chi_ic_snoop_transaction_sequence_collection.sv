//--------------------------------------------------------------------------
// COPYRIGHT (C) 2019 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_IC_SNP_BASE CHI IC SNOOP transaction response base sequence
 * Base sequence for all CHI IC SN transaction response sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_IC_SNP CHI IC Snoop transaction response sequences
 * CHI IC Snoop transaction response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_IC_SNP_BASE
 * svt_chi_ic_snoop_transaction_base_sequence: This is the base class for svt_chi_ic_snoop_transaction
 * sequences. All other svt_chi_ic_snoop_transaction sequences are extended from this sequence.
 * svt_chi_ic_snoop_transaction sequences will be used by CHI ICN VIP component.
 * CHI IC SN Snoop xact sequencer and the Interconnect driver will be using it.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_ic_snoop_transaction_base_sequence extends svt_sequence#(svt_chi_ic_snoop_transaction);
  /** CHI Node Configuration handle set by pre_start(). */
  svt_chi_node_configuration cfg;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_ic_sn_snoop_transaction_sequencer) 

  /** 
   * Constructs a new svt_chi_ic_snoop_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_ic_snoop_transaction_base_sequence");

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();
  
  /**
   * Listen to the sequencer's analysis port for completed transaction
   */
  extern virtual task pre_start();

  /** Empty body method */
  virtual task body();
  endtask

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_ic_snoop_transaction observed);

  endfunction

endclass // svt_chi_ic_snoop_transaction_base_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_snoop_transaction_random_sequence defines a snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_snoop_transaction_random_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_random_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /**
   * Constructs the svt_chi_ic_snoop_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_snoop_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_ic_snoop_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_snoop_transaction_random_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_dvm_snoop_transaction_random_sequence defines a snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a DVM request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_dvm_snoop_transaction_random_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_dvm_snoop_transaction_random_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;

  /** Enum to control the mode of dispatching transactions */
  typedef enum {
      DEFAULT=0,  //random dvm snoop transaction
      DIRECTED_MAX_OUTSTANDING_SNPDVMOP_NON_SYNC=1  //issues only dvm snoop transactions of type non-sync
  }select_mode_enum;

  /** Provides the mode of dispatching snoop dvm transactions */
  select_mode_enum select_mode = DEFAULT;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 256;
  }

  /**
   * Constructs the svt_chi_ic_dvm_snoop_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_dvm_snoop_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_ic_dvm_snoop_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_dvm_snoop_transaction_random_sequence


/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_snoop_transaction_directed_sequence defines a directed snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_snoop_transaction_directed_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_directed_sequence) 

  /** Enumerated type for addressing mode */
  typedef enum bit[1:0] {INCR_MODE, FIXED_MODE, RAND_MODE} snp_addr_mode_enum;

  /** Enumerated type for txn_id pattern */
  typedef enum bit[1:0] {INCR_PATTERN, FIXED_PATTERN, RAND_PATTERN} snp_txn_id_pattern_enum;
  
  /** Snoop address mode */
  rand snp_addr_mode_enum snp_addr_mode = INCR_MODE;

  /** Base address: used as it is for FIXED mode, used as base for INCR mode */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] base_addr = 0;
  
  /** Snoop txn_id pattern */
  rand snp_txn_id_pattern_enum snp_txn_id_pattern = INCR_PATTERN;

  /** Base txn_id: used as it is for FIXED pattern, used as base for INCR pattern */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] base_txn_id = 0;
  
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** Make sure the base address is valid */
  constraint valid_snp_base_addr {
    base_addr[2:0] == 3'b0;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         base_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         base_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         base_txn_id inside {[0:255]};
       }
  }
  `endif
  
  /**
   * Constructs the svt_chi_ic_snoop_transaction_directed_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_snoop_transaction_directed_sequence");
  
  /** 
   * Executes the svt_chi_ic_snoop_transaction_directed_sequence sequence. 
   */
  extern virtual task body();

  /** Pre_randomize method */
  function void pre_randomize();
    super.pre_randomize();
    if (p_sequencer != null && cfg == null) begin
      svt_configuration _cfg;
      p_sequencer.get_cfg(_cfg);
      if (_cfg == null || !$cast(cfg, _cfg)) begin
        `uvm_fatal("pre_randomize", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
  endfunction // pre_randomize

endclass // svt_chi_ic_snoop_transaction_directed_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_stash_snoop_transaction_directed_sequence defines a directed stash snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_stash_snoop_transaction_directed_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_stash_snoop_transaction_directed_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /**
   * Constructs the svt_chi_ic_stash_snoop_transaction_directed_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_stash_snoop_transaction_directed_sequence");
  
  /** 
   * Executes the svt_chi_ic_stash_snoop_transaction_directed_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_stash_snoop_transaction_directed_sequence

`protected
MZN6b@Q:U-,4NMcL.\_@RW=A@Z:6AbX&0f/#S<e1D0/^8@:d;LaW2)S<V@F3(Y5I
HWIQ5E_TaZ6/C;+dSY=BRgCI##;351AaA=RV/#8EPXY0,V-2<MNdM>YT@I\JPHNA
2(-PLcON0=Eg3&_K6\MB>OEbB[9CMCO3.Sg)LUP++<&]<8=_NdSST?;bOJ7?YHSB
e50\b98Vd]f1F59O)HG)/](M,+8GcRQTeSY\)D_MG7NH>-@-^][=],:PD#^d(7YO
[AfM^eKKT1c2,_B51g-8P;dgHgW(^5HA;/>)&U&]R[X)5+7N,<@>M0:PL$
`endprotected

//vcs_vip_protect
`protected
2E>LV8UYS1_PD71NR@8cB2H&6_1/88f[>L>8bW/EL7.MYF^3WPGK2(480XKHGST(
9=<>IP=9aY?C-)4+T>/=6Y.NLWSCZ?-7H1@@)b+)]VLEc;gWV]0YVc9eDE]KcA<@
#La@U(W>FA/[,&7RI42QN/._Y\MD9c+eK5#<7[Me<VD@F=H&4-T34Z)V(-+>G]Ig
CbZ.O7Y1QK\YX[g@(LR)HeD)Y@^A,JV=@&N)2NA^Q>XWZ.BH0J\GR,LYeX1bAe@^
UNLdBKW31gZ=bMH0@;8U[TH_G>S>/_ZPS[d9f2VI-1?Cd(f2S70WDXK@4aP6=;?1
1S4aGD>ZB2S_J(M?L-cA3c]?c5Ve7JgIF^@0A]MG<4dF5N=TEO03JH6GHgA?V<O8
M(N197M4dZ.&66;/YXI#.fG+3Wc[>:\9cXa]_=Z6DS_I/7=;^8&1-df<^ca.R:;R
Z9aU1,&7?2ReJMZ)X(D8&=SK3c4M>-UXEM?4GH8FDg5O(Y:DX-VV.e.gUd[N3f:_
RA]8]dAG,8VSV?@R?5KD>bS[_7A\;>]D]-T?6R80D^.DONX4KP-<\2Y6#NO^M6e#
FG(KT:]ZY\AT>MSL;,6aNXS78F=@dC1:+C);cUT0b&<OTX#bD7d2#1c5^We.R],K
QZLCbTH0fQ&TYA3U7.P;+]0HYQ0-O1X.cC27GJ4.)KR^I.>Z;K);U[]Z7:&D.C.d
SSf^^P,ROG4OTf(d[;aU_-[HfZKNNN/W^E.^F28#)L?S\#H:/\DZ\3DYSA-=8#eD
)GUU]NP#[f:Fa#FbLbEORa;fb+84FFe-8W>NSYINN,Z/DU+^0LSca-Cf6W]=1OeC
K2b/YD2F?U:S7B_QZ14:.C4;1cY/,CP#M10&&c]9XH(a>^9:E?1+D4PFR2a]>ZWY
#LU+e)D?d\CK@K@65bOXOdZ]I==aHR2^.O;W]8;-R&TM9>?BcK463N67OD:1f<\+
/5JCR&JaO2?AYU88NG3U(Y+TaZd\TcE&U[c0+eTE@GKEHK_b+)g2Vb__(D6P;:7C
.WVWPA.B@fefRH-7bDb\;cJ89^[eVBd.aO24S0^0&f;fDXQQ4W&GF6L>7+U]:H[V
.aaC??#CVXUF^XfSC7BAPDE^,\L8@SK<Hc>)JagD6Sd5IF&<6A&(VCDL?_E_.2b0
B?+:Vbd(5;DCYEZ(76\J,@?Ea6W_+agE-b-JI(cGePc[NV<f020M/#(6UP3&(d1F
H7?EVg&081HE<dF1^()21Q+=gW_EKFOV_I_B/J6JNNRM:B_X\0KCTU#6.d#cad/&
4[,IR()R<3_c[K,]FI__?JX/D7V3IPEeeXV0<?.]UPV<VS8gW;bWC3T/b0WQFQ4O
dOdef#&)UV.Z#+/YC1&H,;HWRF65,,)Y(TCPR8/0aQYVC^1LDfa6J@E6<ONLM6>P
b9&bAD?b>-T-&2J&T?Ae_WLdV6O[-ZCA^ZT/GK-TfH.&N;g#V<9@B9CWP[9Zdd.1
>=N92Y1(CNbC?\>+f=7IW?9+&SMJE5^DaV^R9(&_[g0PYU00-,YWcKf_.=?&A[FS
Z=L;6G=C4C</]1d.1AFcBQ<ZE5bAP]MXLVO.d:91f1,&N+33ReP=SOYSOGZLB(&+
[-#JA6&fME@2U/H05Z\KT)Hd16V7_Sf][&Y]F;gSb]GT1-2Ec,:1-_6X5F_:DBfN
@<^0;>A9.UgZFW1O;R24VA#.Y[FH-d#6bKQfa>7GC_4Z[5HWZGORZWSFcPD.NF@,
::1N95+,TV&PXBfb3T4IaXS]egJ,RL1FZH+R99Zga#,c+8FT@AL8Q=f,\DKA75/N
?#Oe^PZ([#<dMA.Qf__b\bF?13\#G9V;JcPafCXF:6aCEU8L6VF/)+9Y/#[7^f?I
,NEM#>X).MecW=6#6XL7Kb0>Q?G0U;<ag1J2VAAF4e6#P07R6@d^>U1S&d9QP]Y?
I#3_3Ke9V;TXN:KeE+&8[D2Sd)6=_bXUgWQaTX[>Q:\OJ);Og\fZGT2XY0=LZW4)
;a#-D7aSICG=H;.5GLdB?RBc/R?)C43MLJZ;2NbRc_b00=<TC2;HVVd1:?17F?9^
;19?NGS&?]T;b+Qb75/-R@DJ/gY=X]TY^P]/2W,\F]bXSgR4KPM?I;))?(0Sf&4B
DMZQ]eB>PU@2>\_)_A1]2I6H>S<]MJZ4,8PfD=8A:cOLOJ]>NW/TYa))K$
`endprotected

//------------------------------------------------------------------------------
function svt_chi_ic_snoop_transaction_random_sequence::new(string name="svt_chi_ic_snoop_transaction_random_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_snoop_transaction_random_sequence::body();
  svt_configuration get_cfg;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_do(req)
    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_dvm_snoop_transaction_random_sequence::new(string name="svt_chi_ic_dvm_snoop_transaction_random_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_dvm_snoop_transaction_random_sequence::body();
  svt_configuration get_cfg;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status,select_mode_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** Get the user select_mode. */
  select_mode_status = svt_config_int_db#(select_mode_enum)::get(null, get_full_name(),"select_mode", select_mode);
  `svt_xvm_debug("body", $sformatf("select_mode is %0s as a result of %0s.", select_mode, select_mode_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin

    if (select_mode == svt_chi_ic_dvm_snoop_transaction_random_sequence::DIRECTED_MAX_OUTSTANDING_SNPDVMOP_NON_SYNC)
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP; txn_id == i; addr[13:11] != 3'b100;})
    else if(enable_non_blocking)
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP;txn_id == i;})
    else
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP;})

    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_snoop_transaction_directed_sequence::new(string name="svt_chi_ic_snoop_transaction_directed_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_snoop_transaction_directed_sequence::body();
  svt_configuration get_cfg;
  bit seq_len_status, enable_non_blocking_status;
  bit addr_mode_status, txn_id_pattern_status;
  bit base_addr_status, base_txn_id_status;

  svt_chi_ic_snoop_transaction req_sent[$];
  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
  addr_mode_status  = uvm_config_db#(svt_chi_ic_snoop_transaction_directed_sequence::snp_addr_mode_enum)::get(m_sequencer, get_type_name(), "snp_addr_mode", snp_addr_mode);
  txn_id_pattern_status  = uvm_config_db#(svt_chi_ic_snoop_transaction_directed_sequence::snp_txn_id_pattern_enum)::get(m_sequencer, get_type_name(), "snp_txn_id_pattern", snp_txn_id_pattern);
  base_addr_status = uvm_config_db#(bit[(`SVT_CHI_MAX_ADDR_WIDTH-1):0])::get(m_sequencer, get_type_name(), "base_addr", base_addr);
  base_txn_id_status = uvm_config_db#(bit[(`SVT_CHI_TXN_ID_WIDTH-1):0])::get(m_sequencer, get_type_name(), "base_txn_id", base_txn_id);
  
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
  addr_mode_status   = m_sequencer.get_config_int({get_type_name(), ".snp_addr_mode"}, snp_addr_mode);  
  txn_id_pattern_status   = m_sequencer.get_config_int({get_type_name(), ".snp_txn_id_pattern"}, snp_txn_id_pattern);  
  base_addr_status   = m_sequencer.get_config_int({get_type_name(), ".base_addr"}, base_addr);  
  base_txn_id_status   = m_sequencer.get_config_int({get_type_name(), ".base_txn_id"}, base_txn_id);  
`endif // !`ifdef SVT_UVM_TECHNOLOGY
  
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));
  `svt_xvm_debug("body", $sformatf("snp_addr_mode is %0s as a result of %0s.", snp_addr_mode.name(), addr_mode_status ? "the config DB" : "randomization"));  
  `svt_xvm_debug("body", $sformatf("base_addr is 'h%0h as a result of %0s.", base_addr, base_addr_status ? "the config DB" : "randomization"));  
  `svt_xvm_debug("body", $sformatf("snp_txn_id_pattern is %0s as a result of %0s.", snp_txn_id_pattern.name(), txn_id_pattern_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("base_txn_id is 'd%0d as a result of %0s.", base_txn_id, base_txn_id_status ? "the config DB" : "randomization"));    


  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_create(req)

    req.cfg = cfg;

    // Set snoop address
    case (snp_txn_id_pattern) 
      svt_chi_ic_snoop_transaction_directed_sequence::INCR_PATTERN: begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_E+1));
        end
        else if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D+1));
        end
        else begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        end
        `elsif SVT_CHI_ISSUE_D_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D+1));
        end
        else begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        end
        `else
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        `endif
      end
      svt_chi_ic_snoop_transaction_directed_sequence::FIXED_PATTERN: begin
        req.txn_id = base_txn_id;
      end
      svt_chi_ic_snoop_transaction_directed_sequence::RAND_PATTERN: begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_E, 0);
        end
        else if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D, 0);
        end
        else begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        end
        `elsif SVT_CHI_ISSUE_D_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D, 0);
        end
        else begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        end
        `else
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        `endif
      end
      
    endcase // case (snp_txn_id_pattern)

    // Set snoop txn_id
    case (snp_addr_mode)
      svt_chi_ic_snoop_transaction_directed_sequence::INCR_MODE: begin
        req.addr = (base_addr+(i*64));
      end
      svt_chi_ic_snoop_transaction_directed_sequence::FIXED_MODE: begin
        req.addr = base_addr;
      end
      svt_chi_ic_snoop_transaction_directed_sequence::RAND_MODE: begin
        int lower_addr_bits, upper_addr_bits;
        lower_addr_bits = $urandom_range(int'({32{1'b1}}), 0);
        upper_addr_bits = $urandom_range(int'({32{1'b1}}), 0);
        req.addr = {upper_addr_bits, lower_addr_bits};
        req.addr[2:0] = 3'b0;
      end

    endcase // case (snp_addr_mode)
    
    // Set snoop req_msg_type
    // Set the default
    req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
`protected
\(Y-8IHK@cXEN^.Ke:=Z8U>@cf#<e-+Hd<[,=\FWJ[5g_Y8B71ON&)CIG)T]4ZA3
I7=NBA5,<:gE.$
`endprotected

    case (i%10) 
      0: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPSHARED;
      end
      1: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEAN;        
      end
      2: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
      end
      3: begin
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPNOTSHAREDDIRTY;
      `endif        
      end
      4: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPUNIQUE;        
      end
      5: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEANSHARED;
      end
      6: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEANINVALID;        
      end
      7: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPMAKEINVALID;
      end
      8: begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.sys_cfg.chi_E_later_node_present_in_system())begin
          req.snp_req_msg_type = svt_chi_snoop_transaction::SNPPREFERUNIQUE;
        end
      `endif        
      end
      9: begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.sys_cfg.chi_E_later_node_present_in_system())begin
          req.snp_req_msg_type = svt_chi_snoop_transaction::SNPQUERY;
        end
      `endif        
      end
      10: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPDVMOP;// Issue is seen with SNPDVMOP transaction hence the sequence is designed to not generate SNPDVMOP transaction        
      end
    endcase // case (i)
    
    
`ifdef SVT_CHI_ISSUE_B_ENABLE    
    req.ret_to_src = 0;
    if ((req.snp_req_msg_type == svt_chi_snoop_transaction::SNPUNIQUE) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPCLEANINVALID) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPCLEANSHARED) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPMAKEINVALID))
      req.do_not_go_to_sd = 1;
    else
      req.do_not_go_to_sd = 0;

`endif //  `ifdef SVT_CHI_ISSUE_B_ENABLE
    
    `svt_xvm_send(req)

    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});    

    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask // body

//------------------------------------------------------------------------------
function svt_chi_ic_stash_snoop_transaction_directed_sequence::new(string name="svt_chi_ic_stash_snoop_transaction_directed_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_stash_snoop_transaction_directed_sequence::body();
  svt_configuration get_cfg;
  bit rand_success;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_create(req)
    
    req.cfg = cfg;
    
    // Set snoop req_msg_type
    // Set the default
    req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
    
    rand_success = req.randomize() with {
         `ifdef SVT_CHI_ISSUE_B_ENABLE
         if(i%4 == 0) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPUNIQUESTASH;
         }
         else if(i%4 == 1) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPMAKEINVALIDSTASH;
         }
         else if(i%4 == 2) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPSTASHUNIQUE;
         }
         else if(i%4 == 3) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPSTASHSHARED;
         }
         `endif
    };
    
    `svt_xvm_send(req)
    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");

endtask // body

`endif // GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV
