//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV

// =============================================================================
/** @cond PRIVATE */
/** 
 * svt_chi_protocol_service_base_sequence: This is the base class for
 * svt_chi_protocol_service based sequences. All other svt_chi_protocol_service
 * sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or
 * sequence clients set the #manage_objection bit to 1.
 */
class svt_chi_protocol_service_base_sequence extends svt_sequence#(svt_chi_protocol_service);

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_base_sequence) 

  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_protocol_service_sequencer) 

  /** Node configuration obtained from the sequencer */
  svt_chi_node_configuration node_cfg;

  /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /** Sets the failure severity of is_supported functionality of the sequence */
  `SVT_XVM(severity) is_supported_failure_severity = `SVT_XVM_UC(INFO);

  /** Status field for capturing config DB get status for silent */  
  bit silent;

  /** 
   * Constructs a new svt_chi_protocol_service_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_protocol_service_base_sequence");

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_rn_virt_seqr();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Empty body method */
  virtual task body();
    svt_configuration cfg;

    if (p_sequencer == null) begin
      `uvm_fatal("body", "Sequence is not running on a sequencer")
    end

    /** Obtain a handle to the rn node configuration */
    p_sequencer.get_cfg(cfg);
    if (cfg == null || !$cast(node_cfg, cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
    end
  endtask: body

//-------------------------------------------------------------------- 
virtual function void issue_is_supported_failure(string fail_msg);
  case (is_supported_failure_severity) 
    `SVT_XVM_UC(INFO): begin
      if (silent) begin
        `svt_xvm_debug("is_supported", fail_msg);
      end
      else begin
        `svt_xvm_note("is_supported", fail_msg);
      end          
    end
    `SVT_XVM_UC(WARNING): begin
      `svt_xvm_warning("is_supported", fail_msg);
    end
    `SVT_XVM_UC(ERROR): begin
      `svt_xvm_error("is_supported", fail_msg);
    end
    `SVT_XVM_UC(FATAL): begin
      `svt_xvm_fatal("is_supported", fail_msg);
    end
  endcase // case (is_supported_failure_severity)
endfunction // issue_is_supported_failure

endclass

// =============================================================================

`protected
1O/,]>=VcJ]ZC14NP2M:N_^;<7cd,Cd_c=f:OfdGgaS<Vd?QSYV)-)FVFLP:@]G1
XA39I?-QES8NMf>N[3R4Lc>]2;WDC&D<OCXV\XJ&I.2Sg_d(;EV8BI#2Rc+]B[R4
C-UQdUURFaF&[#,8bBeC==4fSJCaTE2X9FS=LaSZ<IU4+EX#/]+&IO;g#TDFQNIC
IXN?XITN28;c1)EWK5827bHTJ1ZZGZBUI/>NX8O,X^0[:J3MCUbUcAO&6M4R(B4,
?/B23g_WRSI33\d4S/N]6aeKTb,IJc16bR5DJ9CV8ef[D$
`endprotected


//vcs_vip_protect
`protected
O?GJB]H,HY^f#4Cb3S<:AK(aPV38181U]eU=M7I\)?-dL.2;6ZP^7(YIK7D]=Jg^
L@bS07.CEd=IP8eVQeMb2]Q3./B&G^1VE.K:RX1.a_C<]Q[b#_.VfL0YcB;eBbS(
;;SA#Za>/(g3Q4SV8F1ad@X0B5cf<1BJf6HX)4>WQg?U^QQZU+)?C.>]9XT?GNgf
VZ6\J0<7C0d;^3I)A9>:VGOXQUGS,._cWS5?;Nc#+L_e9F,?0=GAJ(]\5BfWACOf
(dU=O+H1Dc,P?O_:-b)<#e/H08DUJgBe0<C:#c4=\W#PIFM1.?+].BFEZM3H00.G
FV[a,]/?R7(3/G8DFQ2<Y[@0.EF6-?Wb,@A^JY6YTg:+TZZ)[SX#LU#WBYg>TC4H
RP.eH.QE15E?KH[9P+0c2&\>JSbA)c:;7,4OQO.<3gQRX5:X1\B9EH#?V:\GI4BA
]F_a943._aBSK.+<-/H_8K0IS=]TP2Pf.EH-(dbXXXP^;T+Q&_1Of4<C2;b+fZ5Y
Sa1CR@?JZ#\aE=N0#]b1TV@&<G0O_=:<>5>>b5V8E=4>EL3?7VD3)NHL,^39:C8T
G>P8Y[PH/]cf-WH+0_MgcE7708OZWRD>XWV],7eCdd1G(DWM:511^^]P0<CBI=(&
DJC@>16:d@K7JHQbAVb9Y11HS(##2&M,F#PSRY?B>?C<d&S0gN9^N.[P1,]LNVd=
?&eM<53AdNQ0PMF:#bI<X4L_UBd=H(7.Y[.IE.W:PS=_,0[d.H.=QB5Yd]M]>f(\
SfOEbDW/3L3K8-WDKMg&039b8UF4,:9GR\EPaWA/cWe^&49(>-\WHNX>T<W?9eVQ
Q+;@;2L^P8eON5;Bf[F+^WWaZc4Q;V/M,46F?M<\FcB#D;AaQ&AGZR]S.R>OP8L7
C2fW:D:JYQK@=]99g30QXdH&7T-VETU_7EM3fO6#HLC-d8BZ[Ea:Bgc22dOG4)@6
D(I3U_KYf:W:8:^&Heg\;M4FS:dT5]AQBFM(GH.I;/^(Q7.(-MZ[:P>9[9QIBf(e
180(YVEFZA39f.WYV5935OBSGf-d07Zb0A+cf0#R-:G6Yb/JRU>(8E_&AF5G5FMe
RB(f\ORJQSODSU.6UgG0dQabd>dQ)/cgM,.[R5C^14beFK1XV>f>#1aW.BK6->X=
9=6:W2<^V#7=VUFc]aA^?N=QL##Le-->4L8_eQ+(5^XEd^<&-3aLARC2fBY(#>dS
1OZ(,MJB_-a;W:O)QXQbT1.6^@>UCXEHROI7RR4</^O[&L3?bJ;\54=RCDL=b::1
e^[^NSWd=JT_&XM^&NdRQ;M\)32DN<Se4AaG75?/PBT7eU^)Gf=XXf)JN6^/QL>>
;.C6V?U>:UCU/,<V4LFO(HXY9\Zb2#)TeMQgD^P5X9=UA-]712_O7[G,e+GR7=gT
+[WZ]=6:EK(W6]Af8)aAZ@BH[D&DdO?<_<OVZ#->#FZK:)WJXbVG^/<@5aUQURMf
\2=H8?/M)0<eFLMfA(=@Y\+[B3O3><+D](4<IQ:FK7-R=?W=e=(_ggS(AQb+\M6g
ad;19f\NI]&e)$
`endprotected


// =============================================================================
/** 
 * svt_chi_protocol_service_random_sequence
 *
 * This sequence creates a random svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_random_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_random_sequence) 

  /** Controls the number of random transactions that will be generated */
  rand int unsigned sequence_length = 5;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 500;
  }

  /**
   * Constructs the svt_chi_protocol_service_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_random_sequence");

  /** 
   * Executes the svt_chi_protocol_service_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_random_sequence::new(string name = "svt_chi_protocol_service_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_random_sequence::body();
  int seq_len_status;
  
  super.body();
  
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));

  repeat(sequence_length) begin
    `svt_xvm_do(req);
  end
endtask: body

/** @endcond */

// =============================================================================
/** 
 * svt_chi_protocol_service_coherency_exit_sequence
 * This sequence creates a coherency_exit svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_coherency_exit_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_coherency_exit_sequence) 

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_protocol_service_coherency_exit_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_coherency_exit_sequence");

  /** 
   * Executes the svt_chi_protocol_service_coherency_exit_sequence sequence. 
   */
  extern virtual task body();

/** 
  * Function to check if current system configuration meets requirements of this sequence.
  * This sequence requires following configurations
  *  #- Interface type should be RN-F or RN-D with dvm enabled
  *  #- svt_chi_node_configuration::chi_spec_revision >= svt_chi_node_configuration::ISSUE_B
  *  #- sysco_interface_enable should be set to 1.
  */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_coherency_exit_sequence::new(string name = "svt_chi_protocol_service_coherency_exit_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_coherency_exit_sequence::body();
  
  super.body();

  `ifdef SVT_CHI_ISSUE_B_ENABLE
    /** check if current environment is supported or not */ 
    if(!is_supported(node_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    /** Get the user sequence_length. */
    repeat(sequence_length) begin
      `svt_xvm_do_with(req, { service_type == svt_chi_protocol_service::COHERENCY_EXIT; })
    end
  `endif
endtask: body

//------------------------------------------------------------------------------
function bit svt_chi_protocol_service_coherency_exit_sequence::is_supported(svt_configuration cfg, bit silent = 0);
    string str_is_supported_info_prefix = "This sequence cannot be run based on the current configuration.\n";
    string str_is_supported_info = "";
    string str_is_supported_info_suffix = "Modify the configurations\n";
    is_supported = super.is_supported(cfg, silent);
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      if(is_supported) begin
        if(!( 
              (node_cfg.sysco_interface_enable == 1) &&
              (node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
              (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F || (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_D && node_cfg.dvm_enable == 1))
            ) 
          ) begin
          is_supported = 0;
          str_is_supported_info = $sformatf("sysco_interface_enable %0d, chi_spec_revision %0s, chi_interface_type %0s, dvm_enable %0d", node_cfg.sysco_interface_enable, node_cfg.chi_spec_revision.name(), node_cfg.chi_interface_type.name(), node_cfg.dvm_enable);
        end else begin
          is_supported = 1;
        end  
      end  
    `endif
    if (!is_supported) begin
      string str_complete_is_supported_info = {str_is_supported_info_prefix, str_is_supported_info, str_is_supported_info_suffix};
      issue_is_supported_failure(str_complete_is_supported_info);
    end
endfunction


// =============================================================================
/** 
 * svt_chi_protocol_service_active_sequence
 *
 * This sequence creates a coherency_entry svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_coherency_entry_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_coherency_entry_sequence) 

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_protocol_service_active_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_coherency_entry_sequence");

  /** 
   * Executes the svt_chi_protocol_service_active_sequence sequence. 
   */
  extern virtual task body();

/** 
  * Function to check if current system configuration meets requirements of this sequence.
  * This sequence requires following configurations
  *  #- Interface type should be RN-F or RN-D with dvm enabled
  *  #- svt_chi_node_configuration::chi_spec_revision = svt_chi_node_configuration::ISSUE_B or more
  *  #- configuration should be set to sysco_interface_enable
  */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_coherency_entry_sequence::new(string name = "svt_chi_protocol_service_coherency_entry_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_coherency_entry_sequence::body();
  
  super.body();
  
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    /** check if current environment is supported or not */ 
    if(!is_supported(node_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    repeat(sequence_length) begin
      `svt_xvm_do_with(req, { service_type == svt_chi_protocol_service::COHERENCY_ENTRY; })
    end
  `endif
endtask: body

//------------------------------------------------------------------------------
function bit svt_chi_protocol_service_coherency_entry_sequence::is_supported(svt_configuration cfg, bit silent = 0);
    string str_is_supported_info_prefix = "This sequence cannot be run based on the current configuration.\n";
    string str_is_supported_info = "";
    string str_is_supported_info_suffix = "Modify the configurations \n";
    is_supported = super.is_supported(cfg, silent);
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      if(is_supported) begin
        if(!( 
              (node_cfg.sysco_interface_enable == 1) &&
              (node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
              (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F || (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_D && node_cfg.dvm_enable == 1))
            ) 
          ) begin
          is_supported = 0;
          str_is_supported_info = $sformatf("sysco_interface_enable %0d, chi_spec_revision %0s, chi_interface_type %0s, dvm_enable %0d", node_cfg.sysco_interface_enable, node_cfg.chi_spec_revision.name(), node_cfg.chi_interface_type.name(), node_cfg.dvm_enable);
        end else begin
          is_supported = 1;
        end  
      end 
    `endif
    if (!is_supported) begin
      string str_complete_is_supported_info = {str_is_supported_info_prefix, str_is_supported_info, str_is_supported_info_suffix};
      issue_is_supported_failure(str_complete_is_supported_info);
    end
endfunction

`endif // GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV







  


