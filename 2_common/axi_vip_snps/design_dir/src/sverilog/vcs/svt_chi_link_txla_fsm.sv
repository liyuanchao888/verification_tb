//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_LINK_TXLA_FSM_SV
`define GUARD_SVT_CHI_LINK_TXLA_FSM_SV

typedef class svt_chi_link_txla_fsm;
// typedef class svt_chi_link_txla_fsm_def_cov_data_callback;

// =============================================================================
/**
 * Class implementing the TXLA state machine TXLA_STOP state.
 */
class svt_chi_link_txla_stop_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Stop");
  `svt_fsm_state_utils(svt_chi_link_txla_stop_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_deactivate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_deactivate_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_STOP_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The TXLA state machine is in the TXLA_STOP state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;

    // In the TXLA_STOP state, the transmitter can neither accept L-credits nor initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 0;
    p_fsm.common.txla_can_xmit_link_flits = 0;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;

    // Reset the following flags upon entering the STOP state, in case they are already not reset due to
    // dynamic reset condition when these are set to 1.
    p_fsm.common.is_first_req_link_flit = 0;
    p_fsm.common.is_first_rsp_link_flit = 0;
    p_fsm.common.is_first_dat_link_flit = 0;
    p_fsm.common.is_first_snp_link_flit = 0;
    
    p_fsm.set_txla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_stop;    
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_stop_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the TXLA state machine TXLA_ACTIVATE state.
 */
class svt_chi_link_txla_activate_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Activate");
  `svt_fsm_state_utils(svt_chi_link_txla_activate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_stop_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_stop_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_ACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The TXLA state machine is in the TXLA_ACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the TXLA_ACTIVATE state, the transmitter must accept L-credits but may not initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 0;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;
  
    p_fsm.set_txla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_activate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_activate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the TXLA state machine TXLA_RUN state.
 */
class svt_chi_link_txla_run_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Run");
  `svt_fsm_state_utils(svt_chi_link_txla_run_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_activate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_activate_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_RUN_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The TXLA state machine is in the TXLA_RUN state.");
 
    // Records the simulation time when the TXLA state machine transitions to TXLA_RUN state.
    p_fsm.common.shared_status.txla_run_state_time = $realtime;
    
    // In the TXLA_RUN state, the transmitter must accept L-credits and is allowed to initiate flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 1;
    p_fsm.common.txla_can_xmit_protocol_flits = 1;
  
    p_fsm.set_txla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_run;    
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_run_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the TXLA state machine TXLA_DEACTIVATE state.
 */
class svt_chi_link_txla_deactivate_state extends svt_fsm_state#(svt_chi_link_txla_fsm, "Deactivate");
  `svt_fsm_state_utils(svt_chi_link_txla_deactivate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.txla_run_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;
    
    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.txla_run_state)
      begin
        p_fsm.common.txla_state_transition(p_fsm.fsm_state_to_txla_state(from_state), 
                                           svt_chi_link_common::TXLA_DEACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The TXLA state machine is in the TXLA_DEACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the TXLA_DEACTIVATE state, the transmitter must accept L-credits but may only initiate link flit transfers.
    p_fsm.common.txla_can_receive_lcrds = 1;
    p_fsm.common.txla_can_xmit_link_flits = 1;
    p_fsm.common.txla_can_xmit_protocol_flits = 0;
  
    p_fsm.set_txla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_deactivate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_deactivate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the TXLA state machine.
 */
 
// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_typedef_cb(svt_chi_link_txla_fsm,svt_chi_link_txla_fsm_def_cov_data_callback,svt_chi_link_txla_fsm_def_cov_data_callback_pool);
// `endif

class svt_chi_link_txla_fsm extends svt_fsm;

  `svt_fsm_utils(svt_chi_link_txla_fsm)

// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_register_cb(svt_chi_link_txla_fsm, svt_chi_link_txla_fsm_def_cov_data_callback)
// `endif

  /** The state base class implementing the TXLA_STOP state. */
  svt_fsm_state_base txla_stop_state;

  /** The state base class implementing the TXLA_ACTIVATE state. */
  svt_fsm_state_base txla_activate_state;

  /** The state base class implementing the TXLA_RUN state. */
  svt_fsm_state_base txla_run_state;

  /** The state base class implementing the TXLA_DEACTIVATE state. */
  svt_fsm_state_base txla_deactivate_state;

  /** Used to track the previous state. */
  svt_fsm_state_base prev_state = null;
  
  /** An event that gets triggered which the state changes. */
  event state_changed;

  /** Events per state to indicate a given state is entered. */
  event entered_stop, entered_deactivate, entered_activate, entered_run;
  
  /** Shared status object which is used to convey the current state to the outside world. */
  svt_chi_status shared_status;

  /** Link common handle */
  svt_chi_link_common common;

  //----------------------------------------------------------------------------
  /**
   * Constructor
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_chi_link_txla_fsm");
`else
  extern function new(string name = "svt_chi_link_txla_fsm", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method creates the FSM states and sets up special states (e.g., start).
   */
  extern virtual function void build();

  //----------------------------------------------------------------------------
  /**
   * Utility method for updating the FSM state in the shared status.
   */
  extern virtual function void set_txla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding TXLA state.
   */
  extern virtual function svt_chi_link_common::txla_state_enum fsm_state_to_txla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the TXLA state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base txla_state_to_fsm_state(svt_chi_link_common::txla_state_enum txla_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_txla_state(svt_chi_link_common::txla_state_enum test_next);

  // ---------------------------------------------------------------------------
  /**
   * Returns the name to be used to represent the state's object channel in the XML
   * output generated for use with PA.
   *
   * @return The channel name to be used for the state in XML output.
   */
  extern virtual function string get_xml_name();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Returns the name to be used to represent the state's object channel
   *
   * @return The channel name to be used for the state.
   */
  extern virtual function string get_name();
`endif

  // ---------------------------------------------------------------------------
  /** Must be implemented if a reset state is defined.
   *  Automatically invoked by the run() task of svt_fsm class.
   *  It must return only once the reset condition has been detected.
   *  The implementation must not call super.wait_for_reset().
   */
  extern protected virtual task wait_for_reset();
endclass

// =============================================================================

`protected
ORMNIR-4IG,@f-;E&P8195][(LSQ[<g(YMY(>BCF8>,:9,Maea\G1))?cOPM<Y]B
MS[9eVWc&D\KFVVAT2(_f2@_1DXd:@3QX94R8+,4J=6c6PK4S8E^TB(b#@?_&0Dc
_#D9HUOT0[Ye+[),1LF><EC#b;Z@Q-)0\TGa;>D<R&J@O2M:R)KHAF#W+gVD01J4
T2-X1J-_MXa)06fP4d7ebV@5/EF.OEF]fP2Fc4+3JA)KcQ=I>84\1+^,-AK,E_)#
&YBZ43]0TD_O)&.&\dA[,egL=,Zb81A^5<Sd@_[HA=V\Z>;We;(3(5F;d;:aAfCJ
VLDfX/S=0Y<0KNd=&\d.<MJ3dNW5(E25);O<SBJTe.0O?@7f9?Ig9#L0L)[b^=8b
L2R5F[+,f#MD07JM3S8\abcI(WT+6VA=L\OaMB#:E0e98^NcOA+B,,bG=>C,dF>A
d6GMb:,MJ@MD/$
`endprotected


//vcs_lic_vip_protect
  `protected
JIL,Z_NV^Ef\(5S71R(+b(>[I42W78<W@Nc@B4T49N5(47=)We-W6(\2:WG24ZFI
+/?P0AbRXa=QW5U5W2U[0QbS)GeN[WMUW)1R+-M#S=RXL#7;PfN+5K=0=RE9ET3T
fVJ-7?SH\Y=\.(<B-3#J;G@fNb82YQ\?8&bCg/KJNQ95A6+AAfLAN-VN<S_9)\DC
e5^BE#/>PJ)WZ-3K64>Z-@6QG<AL.#?aYBC0JFE^2R]K>\ZJ:QOMf2fMd7c)aAB8
GM[#Cb__Q2;bJ&R0_/H7c]J<[88AH<e.<D742[DDg6M7B#cbcMfM0#;-d3Z[See[
<Y6EfB2B5:Z/Y,\]05eZAWf8K79b=,a88=?d[fHLO&@A_SDUXI1^@>IO?Q>#d\>S
57_539.UG/:=U0+#/9)8CH/2:(KKC&8GKLYZ#[\H=J+>LP6HK#K=/fQ=cH1>(9E6
)+#@DC0X_9F:.K?fZ=5^:(,O@8FT:8\/,R_WE>EYgAZD&g?4>(]edgJ132g>5fR,
]B3;.=@PP:4D(GI1O07FL\H2e0d@a_f9g[QRF+c^T)PZ5N4_SKL][^b?&+8?0Z9/
bJKSgdf9UAB:VUFU1+;c8LGe,X_YcILB1Kg5Z&-M7J@=4-G)Z[.Xf:P7@2)3DUNH
cA&34^OO)L9=/5T_&]GBU3XAJDSCB>.@56&MLGXA6W(2DZEI[Y)S7&^4Y8;V2I&.
b@+QML&X7=7&QZNRMTE#+]3Z&,d?Q[Gg_)Fd4&WC.JQ]GT^&<O:=J/0X+0Cg/UP4
bBUYDF3Hb\TdG=9\CGgFP&Q,=EDNGeZ+CTHcQW(##A9BOA>E-))eSBZP[V<#&GJ/
9c7Jc>5=?)bN&=CZ_+917__P0DAR@2Ngg@fQd0\X\#_WYWT@PJAef6Id>W7YW^^X
;#/7AJ,-S]DRe-ASMBeU::c@1E,Q_QB7I100f?.W,a0^MN;&ZI@4PA;J98&b\CL6
[F#ca;,NXOUR6U4FI+Ae8RY56Cg1]T+=16(]:-12]F#\JD_VYE(CE9)AJD6FE24U
eS3H]X#]1>c+6B#A>,RD+&+NO:W_^D,7c]dCKSaKfH,4/)E7N7)EO,S??@eZ@VfN
)<&ff7?fQ2]eAb]UA^X#UOfe]S]@:W/T1:FBCVRb.&c8:Z?YVd4]2_c,Q+@g7;Z@
fMVK5O]NF9d#ZBcc:MT5P#\KAC[0US.fA?+EG>YM#/RFaGg=6VSag][?#>I>+<f/
/?]f?+g^J+#4VXTd;&G^1XU4[<.&9>&+R6R>-I,H,1N,QWKYOERC8?eOLfTYK[F#
9D8NeXJ71C;)D1-F=eF\.^3CMH?c9??W-/<CfV(Z(<,Q13UefAg071/TES3QI(:@
_9N>1VJP<=;T/L6)Z27=5F1VCdD75T2ZH+0>X[[M0fZ;^V0PY@5JKU_UNb&_g1N?
S&d<SG7H/P&?:&c3aZM]\dSG:U6+775FIGUZH)QVX5C\\-09^E[YL,OKGe/C[aNd
^SR#6A)MOFW?0$
`endprotected

`protected
MbW#3Z6PFYQ#CATKAL9[R/c65?P_E^1SH(#273PP(SbE+DaE8#,@+)b@CUEQbGLL
;#O[0/dY]Aa.8E>ZScaZ2@P761P2->2g.P1@)b;BS6IO3C61bQQ5D/XbW&P8J3/O
[gCQ:]E.b\<._FV1P8Q:RI(15.7R?#-+AS[WO.0&O+=OD$
`endprotected


//vcs_lic_vip_protect
  `protected
>T^eXEY78X)5CAa\](L&3;_I;G1&149c^Kf@d5De=Y#fQ)I)[C2:4(<7a:=Z0<PR
9,>Qd/_KA>W._1B5-76:H(&?(.f581?e^T0NeFQgJ<]c\Sg[9XbJ?N;+/G#bN=)a
]a(FDC2,U7&J&NbXGI@C8&5>NWaABIA-(00LSSH+bQ\fI_;/B\cM:E]L/JXFR)/]
\,A#W&cQH)@76AFe4NcBBSTHg^OQ3BVN2[05g#,4QQ-d488C_PcJ<e+d]J-5,Vg:
[WO=S?=]6>Hc1MV=8C[B\Z\gX+1Mf&2(U^-f2O>?4;:1O1TUO+TbO^NX[EC,I9W&
a^BYFfG_WcO-+>S(aW,O&RN+7O<H<W(6b:RY<SG=g()JbBEG?c/RKDSbQWV1JF1I
0_J[P)dCPaRUEd2\^9.ba4\)\dL1cF<^:V255)X7MfQ=>]J,01a=4=Y[NeT-8YJ7
/_2d)HNQL#_P=;(>XBSL=@<OdCPSGg.WH/G6&/SFF-YaD;3KY][AeOYdX9[5C_K:
VI4[5(=ZOMO+:)eX^@T2+CJ1CbVQQX_d1TQd\Z<8<4H+=)+fPOa#)]<;-aX=CUJK
4cH6JSW=Z,d]5.69BXd/6;238bP[9dR35T0BWOKYcU+Ae>Z?;#W=OI+4cSX0LF^c
I_VQC-fPHN1,M]<&,<A\+A>LVeM&L5/<1R[)A:9f#<M59:eX/fNPJcQeC?,(#/>Z
(M]5IT/_>0+(LRZMT#^A1##JOOg8;V9dO<Q>]7Z(cST<#A#.43R_[N_(-6W^3Cg@
HQ4CQg-,W>K8dTH[#cD3=g4GP+ePA04)X1/2N]36);JW?2+66e-C2G9Mc0B>/8Tc
OWO79[V5b]&@Nb4[3O>/]D@+Z;):9?f@IT)M^4]C=f/;EE.M]L/E3^D7(5TNGM(-
4UMF09g0a52OJ+=fJTZ8Tg[3OXCIE@2f7YFLUdf^\_T<bC\=0MOD)KTG^^G9:&d^
HV89?L(JB>@eLW&Y6NK;RF_M7(f.-\Q2;A^2\QSG(eR5+CU:Da:R@R;(D:FKN@.b
DW=[.U([HePSR8W/)?=.4QO+a^E#R6OJA=.S\[V9.<W#M9UFI>\X1C046]:Ugd,[
D.BJa0eD?;^LO0:_LE:2[Y)BOIZK;\(MB<-M/KEN5VTBH3W)a^(2^gMT;EH=IGUI
C8N5851YQ87L1#5a:0KSU0W:3K]+PcCY_G&aG1.GIU5);F&BdOT1Lc6@8Wc3W#Z&
.9Y_IB^6=>a8C0\674_>^Z_U1\U@b_J>9d\fV;VHbXgB>UCQ-MgK[YEF@6RBP(E]
gF0&Q-Z0U^#J1_YcUN_&3P]b4^cd;VL(g\GW+3N??:Ag8b6f^6,U3Q_c)&NN3Ea/
]DWf[<XH5_V.?YT1TKOQKNN;,R&Q<-GUfV]fX8\T+DfK<PLQcW9Pbd(TRL@&_:A:
@aAdRd8MT016Y]ANUS,W#H3]feHRVQEAH?c)\FY[OVN7d7KR0;b<8H1-_PEfE2K6
1,ee_4FU=FQ/^QME_;P4T#gHX5O&N^_R[0(,(IeP\,:TC>62_PNeMY&IMB+L04-J
#9U):]baFMe&^=C@.X9b?Zf+:B[#2MgWGE;4ORMZ[1JDM@7,\N#FYf;=JWJ:O,>6
,3d<?^0S12X]#8?[&7@+.cEDS0,U90^OJV_Tb&UA4/A\6cPV[>]-+>aJe6_P70MQ
eZg,VYU/g?D.:#.\TP6O?>T2O+2bJ#2OTJ_2HJ8(KZ49K4X)36aA#XN))Q3.NOcI
._(B58#TPaVf\^\0ce5A)LeJ6U\H?Ee2)Y)_@gffYF=?U8&/U1)10fNX.]2?>eP(
HT@F+:1EB)Ac,\\.S\=,/J3XeQ,+&)&[]e.MWaMWXW2>J&9NI+@b4,CL9Q(J8<TJ
Y?-0-g4KKGb3b?cC]eWR#_?1(,ebGR(HMO[G,CRc1=+S>3+LW?,C2Z3=eB&,##(e
KY>^e5VH1[KKAVeMI.S[b@.YbBVZ9HU4Y9GME<(,+W.a[Y4I7U5-AePW=2)E88>N
/:8[E-ZaKSOZ@H:HL/df2VZ]=Z\W=KSBXf+IREWOWYSPW6_K9d9]P66bfS(;7C=\
7eJL_1\Da(6-DHB[cbJ[]-bdTJUUL0R2R#IdaB0d(H4=SLU@FH4&(R=@YYdA^AS-
A]AYX1<X0C_J_V.+(TLe/.0FC_:4#S+Q=UbF+aCIYePHBbg3a/)A8K8C2Y#C(_85
6CI7WF5W6W(PfVKU6NWLZFg?[N?=17#5IF.8?I3+M.G??UV_4WP0cITUVMFI^NBQ
-N[9/#fG-&=/D6>OHOc<\JY3OP5fSS#QbE:K;+/Ng<X65<KGS3gSOJSZg72N/?FE
2V6O_IC5J\Ng-Q8IE-:#gA^UKG4HAP=eM4G0D:#e0OD:C,&W[RINF^5LSA,50Vc>
?;dY30#039F2YL8,c@S:D/4\W)/&,:C2=Ib)QHE-VeP^)#SNB+@.OcLISD2(B=X9
3(6H6>2[_fK&g;V=4\\+K\4CYYZ<79TZ&]GZ=09f2GDW\H7(O?>[7FD9@2CD9N#0
HS#F<B-Xcb;W_bYJ3]P/?9fDK<\6B<P>]RHN0.dB.E.d5O>/6)XL1@SeaFc(@A._
XMS<7Ub]E.?\X,J(#PEN\<U?ZI65?;9bNUWJ]8YDPNM4@3.@0O)9bb4Z4OH8UA9D
&OFMX=U35Z4;\?<-+@b&MD@BI0HKS_Q[17<1dPHdKDVV5fC=-8dNMW6SZbEA&Y1T
@5#5I@USQaVQMXP=I1a>TOJ@4EE4YE(f/D1Bca82;/I;HD+NV#3?Ob-ME#:3)[8Z
I[F[J<ZS+10[A95g^55<0^PX=VWW^a_,fPeb@1_;N1cAW<&3S>973HUVA&TW6SE<
/70O_d]J)R[UL<dBVQ4^H&)RASdP]e;V@SbJBY+NL?LHR=\<,]HA+P,Kf>;VbGgX
BYfOgS^NR0<4JIP,O.VaH2Cg4PHHH8T78Z_>59XBX1+R_QB5-;PE(+3UC6<5^VNW
,0OP/Y24eB(F/75M4EF[)e]QD6/+Q@ab<&UcY[Fb1))L<[b,&^.efN<>Me,]=>R/
;<(G<eFHCV_gS4W3X65b[8+X/d1FR:ET]OF^M<T>EXUK#GXC9?S)eN->DG;EJ<_T
T>FeDE@;3Jdb^Bb]C4-#FPa1#G+M+c(J=L]32CT-1.W7<9D/WWRDeR,e>V>3B:Z4
d6aAIa-PR5_6a-]U=R>VIN:5a9+(-EfS=7SB/)81PSdI90Z-Zc=>3Wce9DS?+fWg
,4@OT(aVYbB)bNL^>^E]A-(TaAW8HEaT(-g]F<CLSIK]\B,OGM98GZ2B:&;f,W9N
5U5c[M-eBP4G.UJ,NG3&d^Zg;#g9EeeQ/\R@1XR&QVBXdI^G0Z#F]B?Hb4K:WRG4W$
`endprotected


`endif // GUARD_SVT_CHI_LINK_TXLA_FSM_SV
