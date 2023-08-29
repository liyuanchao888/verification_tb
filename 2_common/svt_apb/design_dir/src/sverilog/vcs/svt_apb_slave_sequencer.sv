
`ifndef GUARD_APB_SLAVE_SEQUENCER_SV
`define GUARD_APB_SLAVE_SEQUENCER_SV 

typedef class svt_apb_slave_agent;
// =============================================================================
/**
 * This class is UVM/OVM Sequencer that provides stimulus for the
 * #svt_apb_slave driver class. The #svt_apb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_apb_slave_sequencer extends svt_sequencer#(svt_apb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Tlm port for peeking the observed response requests. */
`ifndef SVT_VMM_TECHNOLOGY
  `SVT_XVM(blocking_peek_port)#(svt_apb_slave_transaction) response_request_port;
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;
/** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_apb_slave_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name = "svt_apb_slave_sequencer", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_apb_slave_sequencer

`protected
(P16[Q,-Z<aeEZ=X(4gUCO\TV6W(_WYC)M[M6:\Hfe((CKM#WcOL))bQdJ,PI6SD
a]E[S#gAe_#g6BIa[G<033R+<):59C/VZG;X595=ZG,A1OMJ73&P0(<&dN,GC01W
?W&L,/S9>.=._M:.PM([D\E:g@RHc&&08SM)S)QC>\^(NF57Jc@&aED75YGW\K_d
O43L=8bAN8.eAggfcA-ag#]]-DT3&6?W+aN+SL66VdZT.?ef<\6g4\:)b\DdJeKW
NU;C]D_f,556ZU?KGC8fS4IcLXdJ?7WgLg^IU-PO+#eLIHKRZQ?GKS7I@:P[-J9Z
Z&RQ5X(0NMH1+Y7c,&F?Ee?Uc<K/+_/._R6:8]OEb]cb[AE>DSHLUN5T:6.K2D]P
aDLTU,_MD]@M0JEKJ:):2Ef3AEa,_1c@]A+V8^XV^^RbG$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
[YILcJ0&5^:VWbDIgBAZNDC5)B:=HU-6/?N:5g\eOBWWG9O)ED2&.(b-GX;FdIVa
_g<)ZF;_DI41&,X/LPI^P&2^0XRa)c&ef;e/A1.4De\_7>9d)[4:BZ,aTAGb94^G
f>-PO7?U]EF2SG7Z]DABbH_A/EeO;MT(B5A-ANRU^JbOaH1:,G#,PO=Ed:CL3S\/
)g)Z@^XH)U5.29SgVH>;3De(LI#S+@6R(c&R=,04PcQ_3GH]U^D5/<JI^,10Pa1,
Y[^V469\Ib:RJ1QUJ[]QFg\#<@)eAL2E8ObU5:J4gX+FMJgF;V_;Fe1O@_7&6.YA
^UUHc5dDdU<35:/[\#H,GN[SZBOTIAf:Q>VCSOB@?&b_7I?dQZd)WAYfRRC@Uf<U
]:.[LQD4\A+FgJ<#4N.P?bDXgSGB\V7YB6[=gNFLF0R.)\:G_&IR;S[A8-/IV#Y3
7f.N.DU#J,1fQVU54e[9Rf[>ORPdd<X?[WC+4MY/V3HD/1bT0;a=3dHcbZLLY_PP
_Pf1b2\E&)U/ee]>c7VY_IM<4HSR_LeQZ/T)Y<G.(M&AAZE#JdCeO\A3g<6+KG^)
@L4B+[>W@H,D-4AK3LYX[YAER?_2XZ1WF8.KJ^>Oa&B-TOcP^:C/^;Pg.X8AFK(^
Z^?R(:D8cA;DPL(Q/EU>5?&^^fN+EcB]H<WGTHa9/PQWB3T^::@)HbMZ,g#WTO9=
WB#.LVbN31<eb108AM9f^/]?MgHK^A;9DEPEJ4OE4f;1/.dA(=<[YLFREYFP,5\I
VXW[#+).P9ag@I68\E_d[=,e<6YcR:=F_F),#66Pb(].C-X-<fYd^7L&ZZfdTd>C
Z@<-HMDQT],U),E4&d+HH:KWXS#UCGB+/c0g]P1BVN,VFKeKRV]9+=T(,S#g81EU
ZPHH+PV-.0-_8+<a[/93cMKI6/L49[YcQfM@(;1-D<97+_?RaG@P7=_&GeNIgCT4
e:4[C458+G/6T/767\G94TZ?PP?&bSL&==<YJK7/)fY9=d.E<QO&LEOJSM@b(Q[@
Y6e7)_[B-ZG<cOa\&?)>gHUXMAG4>H6;6K&M95,MC4bYVg]65(099[@-E@@85H4U
\=eO??0(1TQ@^7)=ENH=0\FYOK:6+0-:b&NC&\NTdY9a06_E9QH_)4>eg1BFZ9NN
;HcG2,9U[&g)4U)RAWe\8cT;><C8U:_TcX5Q][88-3AHQZ@5#1Ad[0+Y=)Gb&30-
Oece>?fSaN:_1[dG6d7/[XMR9YFXM7-Q<G#HDb3IW23MQ/0e6E^TD/X:S4+(>>_&
Z+[D;bReY[RZdJSXQc:@X3b)JF<^_8D:&VVF=Of=?((X?3.=..;2S,S@+eM_ER#S
]/\8(+X>O_..O?K-BfDCPT3,:G4R4#(V+fbK]14[?D2+\KG(cER-O9\WT3]\3e50
O_FH)&-_4NYW7.15K?S]@5R+B78N?gR_S=(4<G6?EO)E(7U[f6<aPg_V^(MAR=2=
F6IB3:7a/A.Ka;JK2+3=;JBO/8a-;G&(:+<3#3=/T_\EP>&GC?\D^[NVcQY<D);2
U7>J>MF;KZ#;DQL^SR-Xe9.-HP,#1R]0fVGN+KS56M@[)>U47/>4K=)RJ.3@/X5\
P=7Jd+16=W5TdW&W39R-4b:R,.&99e,9/S+/JQBXZYCW[);K-^+De0G61c>-<=+[
g&[5Z4I_OW(8H/IcCZPc(7TLW7#L#9E;-8eR]/8dQ<g@<e04@-N;<HL^6-eU>Ofa
L@bGg:eG=X#HH;/^/(PODG38>:RH#.X7fBB\,J)ZGbV&\ZNKbNg@9U01b.KA3V@g
>QCE@Kg4@e5-V^^NcEC-3YIN]b>-E30[W)H(J(VESaS[JT5e);IIV)d:VI;-01cU
79,7Hfe(-\@gERHe&HUeb]O&)D7:f\_D7L;TF5_/bT(/F&_\2]FORc<Xbc,3c6X,
KG7_cHeG-AGE6B.>#.MR1@]JDb&2;4U7\TG:TM3\C;50[.FL>DOJU\+0c1GSQE\K
,S]Z93H(9?1;<Ae^\;Z[8L9f[(Ga-;4A-RdN<2[LI<<=5f3[@&J][XTJGK4X7_JU
=W,gTPde3TVYVYVXK;AX+\>D[YV_K+DYZ4;IdQ].V[\.c;;@4:-HSD@BZ\fDM5Ke
gaL^9-c\bg1(L38JHD<)JKJOH6)1aA?&:$
`endprotected


`endif // GUARD_APB_SLAVE_SEQUENCER_SV

