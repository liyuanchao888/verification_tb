//--------------------------------------------------------------------------
// COPYRIGHT (C) 2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV
`define GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV

typedef class svt_chi_link_sysco_interface_fsm;

// =============================================================================
/**
 * Class implementing the COHERENCY_DISABLED state.
 */

class svt_chi_link_sysco_coherency_disabled_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Disabled");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_disabled_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_disconnect_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_disconnect_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_DISABLED_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_disabled_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_CONNECT state.
 */

class svt_chi_link_sysco_coherency_connect_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Connect");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_connect_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_disabled_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_disabled_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_CONNECT_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_connect_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_ENABLED state.
 */

class svt_chi_link_sysco_coherency_enabled_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Enabled");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_enabled_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_connect_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_connect_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_ENABLED_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_enabled_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the COHERENCY_DISCONNECT state.
 */

class svt_chi_link_sysco_coherency_disconnect_state extends svt_fsm_state#(svt_chi_link_sysco_interface_fsm, "Disconnect");
  `svt_fsm_state_utils(svt_chi_link_sysco_coherency_disconnect_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.coherency_enabled_state})
  
  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.coherency_enabled_state)
      begin
        p_fsm.common.sysco_interface_state_transition(p_fsm.fsm_state_to_sysco_interface_state(from_state), 
                                                      svt_chi_status::COHERENCY_DISCONNECT_STATE, ok);
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
  
    p_fsm.set_sysco_interface_state(this);
    -> p_fsm.state_changed;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_sysco_coherency_disconnect_state";
  endfunction

endclass


// =============================================================================
/**
 * Class implementing the SYSCO Interface state machine.
 */

class svt_chi_link_sysco_interface_fsm extends svt_fsm;
   
  `svt_fsm_utils(svt_chi_link_sysco_interface_fsm)

  /** The state base class implementing the COHERENCY_DISABLED state. */
  svt_fsm_state_base coherency_disabled_state;

  /** The state base class implementing the COHERENCY_CONNECT state. */
  svt_fsm_state_base coherency_connect_state;

  /** The state base class implementing the COHERENCY_ENABLED state. */
  svt_fsm_state_base coherency_enabled_state;

  /** The state base class implementing the COHERENCY_DISCONNECT state. */
  svt_fsm_state_base coherency_disconnect_state;

  /** Used to track the previous state. */
  svt_fsm_state_base prev_state = null;
   
  /** An event that gets triggered which the state changes. */
  event state_changed;
 
  /** Shared status object which is used to convey the current state to the outside world. */
  svt_chi_status shared_status;

  /** Link common handle */
  svt_chi_link_common common;

  //----------------------------------------------------------------------------
  /**
   * Constructor
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_chi_link_sysco_interface_fsm");
`else
  extern function new(string name = "svt_chi_link_sysco_interface_fsm", `SVT_XVM(report_object) reporter = null);
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
  extern virtual function void set_sysco_interface_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding SYSCO Interface state.
   */
  extern virtual function svt_chi_status::sysco_interface_state_enum fsm_state_to_sysco_interface_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the SYSCO Interface state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base sysco_interface_state_to_fsm_state(svt_chi_status::sysco_interface_state_enum sysco_interface_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_sysco_interface_state(svt_chi_status::sysco_interface_state_enum test_next);

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
;Ac8]\/T@-RK;H:8g^T\]O#2c,W?SU&O?BcZAIdd)PC98F&H@8J]-)c:\3YfLgA]
[a=bRM8+>07&_E[XLGE0LT1;f<9OWY+73b+40+\:IPIQ,LM]JdUOQ(Lg8;#IW2KH
4U.IJ[=^#f_Z+0Eg<V@,R@3]1-BAeC>0=I1/S_AZW[MB_6?0V:GFeUEYW1.)=G_b
T/0]3;\a-#CTXZQ;5JK4=]bG6f=E/(;&XQ.U/,aJ48e0<d\8SQdYV/3<bNbeWegG
]NbGCH>D4UKCA=YZG&],f8B^b@0AMAC00AZ-aBD=9W(@bdf>,C6,9b_+=8(eDLeB
QQ2?]V-A?&KDBC/DfOAVM?OFAO,0fRR8./T(FCTeBSX=^CWJF/BK)(]Te0MEa24a
-/B2?A4.K9D(Y?.Bg,4PfdVX,LA\;22.3@[dSF<cg<fL&]+:I>Hd2X7;FHaO&^XS
/]N0Ld\7@G(Q-Y\2P62b[?CO<S>ER_;bZEG]WB^#T=eQPJ1b0XROCC#ATR60..\b
c_F#[MfZ#_eQ+$
`endprotected


//vcs_lic_vip_protect
  `protected
aP_@d_N<-RCIJb-E2^S<A2OBC?(\-@cXER-I0P-aCD-.[+#McJXF7(W.QKLY,#V@
1M5_e>1RY9H[]1OI6VE^X)caHPN?D;6\#M0/BU[Y;PfURB5aC)X7R8N_]e/f&)c5
;[E-T3??)6\_Qa<CD@[UO6J=1>DFg_LWJRbBFf+Wc(Rbf@AR021CM./DUTa/QfM<
LXOK.gU#J8\95GT_>LJROeKMJHKP.eK(6U-]KY87,I^(W#Zcba4R8dT78FKCbF[W
@KAZRg<D)&G4,L]BA:NgF14)BBZ^aV@G?>]_&-;)dLBWZNM6K,)bB4-6H8b9,56S
gXcX&SN>TMK(E<RK8D+6[aK/+@fGE+.NfJ1P:<8YgLZH-:<.eR6R]-&O6Q,LU):Q
Pgbg;(SL8GJ^A[+Wae0VFU:@_GKSGY0ggRTV=-YG^>A6UOaIQ<PJDUZfEC4A/afb
7\SG:)5P6:5S-fJ\d4]8-)4.Q^^1W[g2A)EbP7HDJ[/;WRAQc/PJSLA9W.1:#:b,
)aHZ>;?.?)NQ[NPT:(/;RU2_.,4F>PbZ^gJ3=dFUW_W?0a+?HeALIK2XPS&;T:)&
O98+g^82I^>AND;G<2^>e3N@8^1#(7L0TU74US@RO=0b;<16fUG#2C/LNBCAPHNG
M.?\FK]EXWH0KVJ;I#<JZPT(8(,B=[C-4X,Kc&U-Y;KL#&7cMVcQB5K5W].S1O<:
:^21J.PA7^Da>Y+dST82eD6[aVY=M<Jc.DdAPZV,DWQ[CEa?(:24KdfWCEO[GFc6
T-cO.JQWTOgBP7V1[L\Y-9D?:981g/B.+d74VB/=,QB.CEZ2d,K\EdZY60;C-\]\
&)Qg;B2Z&JB-,E-dH54VL:(HVY6O1_?LPL59ENI-UIA]G:SRGdW@B0=:OM//V2M>
WOA)+H4AFJR^L;>VYe,+DCe/IKNW@1TIRIY;82]SH0aG&5U:5CP]I_U:?\;d0&Z.
e=]VWd8+=AR#&?7.D_W(./WR-<VfULN1Rf-QM+OZ1#H/Zc/G2-Z^Z54]I-U)g<4a
ZTTC+,bD@:K[4(XH2A_(_+Y]7)X(:EZ@0.[_ARgedNCe?,:<TgIH&G&7W_)[@[F/
g+00aWY5_R/NB=E)7g\V=-(,7BFUgDOaIT=Z)PV6AgfD&G?DR.fR,G#Z?^:ADHd@
eVAUV1[:<193dc[<O1[:0ORM+^QEH-UW:Hc[\WO,WcV;+<e/1SFUBR:f@c9F]#c&
FA3FGAH<a/.B&NIJ;GN[b@CZ><IGHK4FMH#Yd9VP1<-WCf+@M(S7]DfR:g9+,>/C
\\a)+JZ2-]ac&XMg1N&9E6I6<G;6.=/bfIS9gbAE[SX\L0RQ._@=Z3/C4?:ZR:2W
M7]>H(M5b5^U]3VYG7L.2CS@-MM>[O>&AN@^+XLP&SHV71IY-C)ETBb1]+MD^S-0
NEZEfS^1?(X[+7/AHCXd0NFD;9<F6P7YZe(b4AM4Q)8).#YU03,7:I3I87&2b8P2
d6eE,IZ9\\He9;LB,3HZQC96+Y-<S[/S81E27KdgKc,NBPT]4BAF?GZN85HQ_HI)
&5_)Ifd_(P83g8PQ;BA>L(>Te+<&NI^0LX?(;W\aVD_K&2&YY=ZI@+3KGb>+Q.(\
JM>^G9a49bTaBbFgW6ON:0X,59DG7FVbM5TW-G8.TX_[[bW(I.RcS2fG7DSIeXTA
A_3WAdB=-U(I:,Z#@IV&R#1)_<>)U>\a3Y20=-D_(3>13Zb<2HRE@\@9:4;[c?31
_LB=g[I][Y46>57bVGBCOZK7GaXdH8Db22e@YO_60b,/AZ0&R+6VA17<Sd2A&M=a
JeGVI19#K1X0c4&BP>4;=:B.<N8PYC:fGK7cfR].gZKX:(FfDD;[UE)WV](Ef38I
[]08W?6fRG[G08V?S4=]AbM4-U4?&MTWO?)X])C6QALG&MO;UdE/Vd8HK#4ga8_I
94d(2_D@T]dXC)DQ8=cgU/#Q>K]#Fb=QABI1F^eLeb11d^7=8>eObJTRH\-M<;dL
+^(d\bDRd;XZWF8W&\N7)E=?L-5F^X#R-BYb#21K[#J\HU;0\;:/K(-(NOb21(YH
Ee6,AH5D).<L0BRJNPU9E)?2I5D\R9?<]OF?.K@a.Y4[PS]S88PYO?2b9ZgM3#d0
6&TGY[(Id&AR8O]O_SY:KVE(>EB)DK?1?CA_=+)-;Rd43d.Wd\gfc5CRHbB:cHR0
-Q48D?HLg]D^HQ_Yg?(-2BMJc-6(-=C00,eF\VZL0XZ-V_MOGL/.b\ddKDR[=0cM
eS>Gf1Vc@Ya21?_/MHY)[[[e4(<-0/KT)FQA0/7fVO9)/+=Ec;AZ20#d.V4MKVeJ
@2N(PE27Z7#feUSQW0@:Y>Q:4/P5PfXgPP<.c1VZH02e(5HDA3N[;512eP3OZBTS
J0,.7O3BfE@/;<JLJb_TFf/5?f^fHXM6@7b9M,:b4:-g6@YCGO<EXYg3.)?TegRJ
GdUP-FeU+PL]1IA?)5=V0==\VDX&,LL34FaeXE+B)))[1/[8I80=^/1\ZN08:L+:
+H-)g&)VZDJ)K#4e[>4[\URH1X1SPacK0(E.B@>Ed20CEE,Od8]cS1I=PG;^V0A<
Z\BS4\EM^YaD60aZ,E1CK?U:+E(;^,O1OH37GMC[<3,V;V#g4gR-X>E,/FKSSd_F
Y,IT&27bGS@]R4]g/).BgfK&gO@D]7C</.X)7Of+U1V9N[#+<M0P,\<&&c,[GS)R
F<]TaL=I]C.VQLN1;YY#DRD=,9b_3B1.;R)HdZFa_3_@<^+2dO4,1HS&\D35QCCS
JLRc.+G(,#K<aHNSY:FD<T+?MG:VQ>=Vd,E5N>D9f9d#\4]C[IO75>2V576&E8cg
EVgN)YWQR;?eZeCGNe2I92N##6=+;,>;&)62Nee1B;+G#F>cS#-?:1Y9-4-G+L:M
OC8g0A0^)DDU-a3e1_8>fMdI=>+WQgM0eA&9WDK6R1R=WF=29-0P^W^-IFMbHL7F
;aKTYK@GP[UMM7AZO.b,G5;9D4J&cD;RbZ1[\>]d45@QOa7H4)g@:AEW=EHY?bP,
QBYe/V0;^5GA2@E.=4CA9D+-;?=00]a,]bZ49?=>_L54OgYe\4b7L6E,P69d^-1\
ZP&=4ae_5NaEb>#K0DM5G5W/BTD5/IaRJ?K@KJHY_RO/]SZ0TIU^7@QPU0P2QWHd
)75+>ab6<A=/EA9C;R\;DI0PIb^N[Y8_F0APN4UI[G:7SUDS-2eXg:f-Ge:R4:4&
1P:^-YPO0.8BP6QXN;/U=@OgVQZ[L&I0\M0^]bJbgZMJHb1H41Uf=Q@K43ZZ_D=K
a-O(<4REH1G\LdeP5_17a1]DUV@+(V3VL38]XJNBD-<7PFXWLRE=_AF1R(;8?Q&U
+fAO7R&AHD(S-W+>>Ic=X&DKb?[UPV<S=HO,K9c+O@RHTVT?U6?UL1f)TX>ZWgdA
7GK>9V\(,Ed]#Z8)@Gb5[L+P()(0[#3\(Dg]ZIB4ZJ<d5Ff&6\?:VS2g9f7eaSXY
DLR/I.KMMBYDY3W\LM-RCGF.aW)Na4Wg#7L,OcCO/,?7e+&T[,Y=S/^X,^,3SGRR
)S@/3;:E?V7CQY&0K1QZ0+7B(K80e80-Qe5fA8T8WZ+N2111/=TV#F_PK^cVe@MB
-7Z69@XKIE5^?6T^g]\FF:,,]OUSI+_S\XS4>1Q.<GMOJbB<V-HJV?L&DWY_5.&;
4TXZ8V5cFCC)Cb24^];VHe6g-G/N;#G?]:@GC_4KPe_b8d#]GdED)JI\eR4:XeK#
IA9c:,T7H=:Vb4_G;5]>D@FCLL;CP5fQ0I]-+3?\f2,R28U+54^D9=NTfS_R+PXG
eWXbZU0fJT]M)0T>O?MEaM;:M5YCIN-=6/BIUJ(LgE](]X&gT8LdF2a\A+D?fV3N
4HfO\[DA)KIC1&+a>DGDeT,GEVXT;_M;941988@3ZD\0A)W&.gFC^PVTD\@(SI04
0aXeI<be\TgRVD1T/H,POD#6MM4ebeOO7N2_KT-)YS[>#^UCT2;F]0eI4Y/eB[>#
LQ9^c#2Gg&,U9=bTRENTOe2T>4-1Pd>16X>X[OM,7V+1QK/VObA?:O[cIVZbN6H-
2Z;2\QJBGEM_abC@)MHS\^ED8fa/UH(OP@NCRODY(77?^b-ZZ=a[A#68:75O1:EO
@3^(0He=fBW3Q3HL?>HN=XIfPd)e(#G#T]6AbNS]@[Y:=aUPTFBaE#QPaaW_:UOf
\g?I8>d;^#[Z@86XOM.g/+.RSdH@1c[1//:9&7A):@-@]O4ZXA:VcINRV:K+T4@.
ED_)MDF#G,Yg+g7.13VP>)>J9J/9-(gY#R4\1>>Wf,>Q,AE0S@bJ\7DT@>e.d9?@
4DG2]#H4&0_:4Of+<<MBC>]g[H&HORFde3=?&_A.gg/AG_4.,O-,1RBJZKLK41#F
gW)=6XPM_F-1386BSeEYV+5V5>S\N[EKOX,5=\NcaE/9cY@IH.B>S=U]KfDN;UHa
OF.&<?A.(G[4(7ReZP;FZ7,O>Q?J@g\D&aEF<dDOX^6N.K<-&#BaZ^.,e5Qe44-J
WZ_:M#McAHa3VQ6:BF\#EVD3&.;eFUUcPR45B2]AeV1e;N4UGVK+SB]&ZF(\>^.=
c2D5/\#>RM9acE,1;dRcKf1^3R11(T#/0[=K/0HK^C6R^3Z+QBX3:I7&eP,>^QXZ
8\W-+=#6,5J#\:<G3E4aV_bDS_e3_NJ7Lb,TScR>+9(c);;b5M=H:JN7/NI(^dAJ
#e9OREDbR[C\A,Gf#)D+M1fR2DU4S8d26dd;O:Y<TYJg2OM&3P87H,gFRDgGLG-H
1d;dFf(-D]?KG(PHVPQgX@-2XBEFcb/c-J)]7KAN7QO;0CIV@LcBL9Sc]1([LK1]
N:?C<(_a_9KG\[4dMP2bA[KZ?7(d&7X)g/QKbC3VY?].[+g4ZfB60SFG[Q63T,\<
U>T3=IP_W)7B>M-CW=28JH^-68FQ8gU;C2IJP/<+5=8=4\\Q3>A;OR+&7;P]d-F-
>J4:9_G@/4I6eC09Q9MU+,JaU=RbMVON6?M-3=S99XFa]dP-S(7OYb?;H#^P<Je#
@DCT/JIKFV1PCE4a;#E,EO]/MV-b6Y75:JU)80[?L-Ba4=][EZ3AMD1=@QSPL-V6
#3B6>bM/6[d^U[VTT0@V+?L<#U1#[7JO-88L-YNS4@baG$
`endprotected


`endif // GUARD_SVT_CHI_LINK_SYSCO_INTERFACE_FSM_SV
