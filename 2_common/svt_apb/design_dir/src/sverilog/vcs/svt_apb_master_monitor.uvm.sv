
`ifndef GUARD_SVT_APB_MASTER_MONITOR_SV
`define GUARD_SVT_APB_MASTER_MONITOR_SV

typedef class svt_apb_master_monitor_callback;
typedef svt_callbacks#(svt_apb_master_monitor,svt_apb_master_monitor_callback) svt_apb_master_monitor_callback_pool;
// =============================================================================
/**
 * This class is UVM/OVM Monitor that implements an APB system monitor component.
 */
class svt_apb_master_monitor extends svt_monitor#(svt_apb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_master_monitor, svt_apb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  /**
   * Event triggers when the monitor has dected that the transaction has been put
   * on the port interface. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when the monitor detects a completed transaction.
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Master_monitor components */
  protected svt_apb_master_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_system_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_system_configuration cfg;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_master_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_apb_master_monitor", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
  /** Report phase execution of the UVM component*/
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void report();
`endif

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_master_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_output_port_put(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void output_port_cov(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern virtual protected function void setup_phase(svt_apb_transaction xact);
`endif

 //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern virtual protected function void access_phase(svt_apb_transaction xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called after reset signal is deasserted
   * Callback issued to allow the testbench to know the apb state after resert deassertion (IDLE or SETUP)
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void post_reset(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when transaction is in SETUP, ACCESS aor IDLE phase
   * Callback issued to allow the testbench to know the apb state after resert
   * deassertion (IDLE or SETUP or ACCESS)
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_output_port_put_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>output_port_cov</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task output_port_cov_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the setup phase of a transaction
   * 
   * This method issues the <i>setup_phase</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task setup_phase_cb_exec(svt_apb_transaction xact);


  // ---------------------------------------------------------------------------
  /** 
   * Called when the access phase of a transaction ends
   * 
   * This method issues the <i>access_phase</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task access_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after reset deasserted
   * 
   * This method issues the <i>post_reset</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task post_reset_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called when the transaction is in SETUP, ACCESS or IDLE phase
   * 
   * This method issues the <i>sample_apb_states</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task sample_apb_states_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called when the signal_valid_prdata_check is about to execute.
   * 
   * This method issues the <i>pre_execute_checks/i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task pre_execute_checks_cb_exec(svt_apb_transaction xact);

/** @endcond */

endclass

`protected
,>7\+;\6YIg>e5;S:O)7.P0UQIFf:<#D?d1)LN10I4T]BRfeN7@+2)AP62gPK@PW
_LdD_N4gbAV7DY0(2gEAK,)>0IQ3Z<0=D36?[QS\.BLP][]&QQ@b7:)581F<<MTT
XR>eS]WHQFASG/cIaPZJg2(D__&JgF(_]/PA51@&eX)G0^f)T:W=U5AKKDVG8<GN
CZVc9.O]4d@]N-[>ZcN[YKd\/FJgS[G=bQg6TGGd(9@CRGK_)2b0&F29eKfV078E
g0>E:SS(OKY(=,P_/WTA5(9RN?Ug,6dU2.>A5\b:f-T_F&S4[/,)SUZ9\7X^3:3f
;,&e)SGEdCKL:N&^R\7HUG9R2$
`endprotected


//vcs_lic_vip_protect
  `protected
1](YMa)?((36KGf=VO1HG=POJUZ[U&857RA4?:Z\[)43VVJZU7:3.(#VY]H#7=[H
a(Vd;?R]2;QOI\#<O<53cP\#aF]\KaSB/=6_33:/9DBNfdE.D<gH8EUK/1-eL;2X
X:T1(RRf9IM5d_09\7JCQ:<D7NURYA0YgKMd,0;S#V+O_:14F[^[=a^gGRUTW)2/
97,ZeA)F?^H9e-L9V3ZJ=PD/[>P1Df@_H7O\fLH)BF7H_[Qa9d_aed0(RZ-\&#eE
.42X0^^Y&@TK:;?09@e9OJN1B?0966<-[KHUJf0B,^&F:=#+SA_68J)d)]3;Rd3T
<(O9a70+>JXHX,.@,d_[.7EZK\&1,;ANL7YMD3J@9L5KZ;GbEc9fN<1d]&08R6HO
1A:&@A3KF3US[cHJFL0CAFT^8,G53_39TPG2.f^W#b=:Y9=7ZJ=^24<OBEN+)HS-
H:#@e^gZ+G>#\JY;R.LA=S<,]P_[5RSeR]2DT9N#=^)&IL]<?@A.aSbR8g4=+.8B
##+QO8)Y3a]N#.-[(=f>M#E],0#?P7,YI=6Va;\UD8X=\QTT&EHPcQeFgNE\g2_^
g#<)>D9d8;7)-LHF&6W5aO(?KV.#QeLeLD;Z[=L,RKOL\)QI_LIDZUC6LgMSBGQL
>)YJI8TNZ?A>AM:FB(OAO>B?YPfb[D41D)>D0Gd+GU8HRRFFZFe?IM1\1<S_)<RK
(^EI]Hc\,0=^H4^Y.1](7M[b_EWDO]gO2T)04:-K2Ug(bbA5E>LDDdZ_8?:QREcH
:YK7dF/aVcG0)F;Z@W,.QX/E,Vg=;>AL.?OE=f]ffPL)b9<<4_QVC\[\]Z\T,.f=
?We55-EL\B<F+ZbLR3\+[e/-U+:6#C2gR+12;3;Pf<PJ=4W1P0;,.#X]OW42#4BQ
;>ad0E>Ta=X/RbWKfC@#O<e/V[,BB\PHC]R3KEPWX<baH&FPFfY;H0Q__^bU[eN0
>R@6ZIP-G[_6G,IQ+Q;C^\2HY1JX(@UZRAC:Bc#@;-,FdO1?U75a5@XR]6,:+RA)
;SW_3XLTD+)WPF7c8J)+Q,W/#)AN.L_fHQ:>:;dQHD0Q6(T9(KME^1.=RcU+&#S0
AC6GY,,L+a+QWT3G2[FW,ION^]R[(8c-80fa)V,M<3J)0b&40/dTAU,a<3<U.;&2
fa7dH;L0Z=A1ede1#6/e;V/\GR=VTeSdR(.+-MC+2dd;d9e8@59>Q^##.bKV?.Y7
2SG[e)Y=H8Y],(Y,ScgFO5e&4(91?YJ:ff&d:Z.??>JWHJ_DRROWE]6JCMYb79SO
d_&EZ&K&K+C0OOLGW3GF,f7\ONLT+?-T[0IFCbJb8a2ZRV_?(=dM+I=?W8gE=]Ac
eWXX:4-Y;@?Y]/ZLOW90FBFY5\&43BS)#\b,B?G/.4M\1OZcM<H6fQBS3+1XAW+T
#(6T0d<.-F<AC)54Q_6K+P-T5CP7U:<Sc50c&RE1(Y@21\0TB.;1>/B>\BI2;\>:
Y#=MXA&]^SP6-g,T.8AJ@,),\VQ&&(G&A(E))MZ8OZ8@gEZWO;a22G)XD/1N25?V
2OSb_R?OS>0WV;71gg;&e0>[F1;488@.C=AWcK&>,)/-6A3/\AW251a]/1TH+KG5
SWeA0MeDC[S4#)YB)afN8ea,.(=d:fI.M:1GAJK5^\HD1<HX:YTPR8-Y>K;\D?<?
8.;>[1VbLH8HL=K=I5Kg]TVU9.?/ATKFBYVDT.9I.-=ZL;_S3>O+J&S3&-PU&(-;
=<6#aHbFVaS_46PJN))-CaJ+6K&FQVeY6#aWb+GH3,;738TUb(=K<1^^2>W\>3J.
:M274g2OAOS2UV:8ZK\\<J2IZ?;cC>[_TC+C&e<JZ555Kgb3^U;(^(;H?]PQ[)W?
X-c@)c-gffK\O5Yd\c80E2M2)B+ZEO]KNP4W+CRb#.L7K/8a5+41+7KC[<<LO?c-
_SX]5Y,Pe8U]R]e;a9>3=BEgT,))690AHaAbZM#0@O5cU16^BV62F=DGdH.aS,QC
@HA21d>L?&fK:C.OV>EU.]C>26\2_^W5=#,WGS;S+\)@Vf2P5WL?6d:\+NZXB)QE
1/KRZH^XVHNPf<R+LCEO)D[]<(G>DJ:gQJFdIR1PfHV41(#&c06W,@6:I23_?6U&
[OdG5C10ebV?IMb+dZ+T97LFTR31W-/1MD[d3G64dU@dV.6MgYK&cI[7c/2EOD,R
:6&(3JeQ<?aL1]D.\4Z2XPF6([1N6^^8#fe7JbB3017]48GcTLTbA-[f:ZcLH4T;
KY^=C<2XP+M1R>aBNKYIU75fLH;;]:8/d0/3S1W_YeIdT@#eUM0+)<@P[QWe/1CT
QgM/-T@A\Adc\WA+OB9FD;7,D+AC=>6G;IcTJNTDND)RC7#c+7eU:5QK=#T,Ag_V
/-#.HONV5T:KKS]/Z+Ne:;7a8c41f6@<R=5UgYBU9.<;]aDR52;]^eYD,fLeXd33
041HcM.[^0<KdV0;,N)S\PE7^/K7eG&@Q]&TQ>OTL++AR<Cb3^3W@A7dR&JJ&U<7
4:;d/O8YI@QI#ZPSEXWcU^EIMVH<MZ>3S:D67B4/F\-Og6A<:9I=RW<[Oe@&8R7A
ABYM.382[&16d_>S2+X8T6g3f(C+TJXZ->7FN?b5J]\,;7?(KP>IOgePJ7SR.@>7
\7FC>_(a&&I&#\RWGPPL6S5-5&2>)9[22-.,-PcOeW[Z49<;01[V:3ZX<[8;:RL7
@E;1H^gL93a]XIdP)VISQ(BYK(\V:]-SZeN#YQ8>=ID^W+NMGO6XK..);T8NDX_1
&>+,[;Bc)K,HC1:_IcW7e<[N397fBZ6ag3WMXa3J85N]</VAKd1AWGE9g/+fWK8>
EZ@FTXDR>T>K<Pbde\.#V,N5>EX>WYK[#7.<6BTH/C1,:=KY634(-PO/#6cA;9S=
NRG2[-@E@S;&:^?0.6JS+U@T>R;E^3\T<d0W(WG1K6_J+#>#c#?HDUOHIZc2=FLd
,65U##=<.:/53F[gOdA;H_e8(L@O#4gK<SEa1gRC:WQ9Q)6-::BeSCQE7J_H:@-a
PW;E9:AL;8:d1e/gT8(&5a/9(#<gEL&N6HXF5a8a+-TM6,V,6ZN4HSc=G_;(ZeEM
D]M8K09M=M8/J(70]MJ]Lc,Q8F6E+22Z<#A(c4BM&RDbVWbW4fKMCKAed3G9]f)c
RS\eDJEK1H&^G<OYPcZT-#0)PFOJa(/O_DD9L>I^BRI)59P/5[=^E\JB>J.dYg46
TXW,CY--aRUa=Z2IA7<6e@X/?VZ[9dJJ?eX3[D>V\V3(X=bJ=O^U9U1[\f_4YRNE
D6<8Z9;E2EA-EE=(K,JOL\]#EU@gcaXKfO_aX&bT9HScKgXOPGO)VJ:\KYO#DaOQ
4UV(DeQ;#K^-)HS9ES<_D:gX>^G^(=b?Z=L6T2+T0Wb8DL5ge)e&:K/bbURIY@98
A(S:&4?.,MIKB]\1e3J/[@M-W=&32[MW0;2]Sb3TdMR;YFWc8O:]5d\-dHE&1O&[
G?57\9=Dc0#?:);_Q_)T)D+.(34H5.?0S7B]gBXQ>\b.6aHPB)<^-K;;NUPW)RT6
[5QM3AXe6J;9.Y#>UN45A<a@=M1&[.e.4S75>-OUcRA.HZS(eb.gL.8YX?5&7VP^
U22^g]:FDDTGR.0L(4]e=MKJG9T6G2UfecX4D7G;<JDCOVS&)Q7>cEX(4Ng-K4HD
S8:-5T3SM=DZE&4U-X8J:L.gQg?/(_Z(4F8)[,[R_O8)6&6OZ??eH0PX<KPLNE.C
)E2<CN^.7c8e4/NCg9Z8BBf20RIKfV=bMd-:.2=MMe6eJbf4.,R3:]BS=WBP6aW(
BOU)7:Q7=g\b_37)+EUTLc;[aLY0/:GdY][CbRN,_Y<HR=LCg)Qd?15RR#X9MF>@
a+fg;2]EGD@<(aXFc2\eEWW;Sb+aL4S9,N+bC,Ia)#RJ?;YDOEZ@KJETe##^_O.^
)24MaO/W]&#FNfT.Q@(?CFBeIc9XA(_QD\UBX&c9#gd.Z-F@EM&<PUg:2>CUMdIZ
55XR&_1bYV[\@2PeMI7S\.g?4gHcOIV5V[=VV-J6=P4^G-,,[@@P+b3H2?RT]RG1
741TaDJ?.YbNEeV#,e[GR]bZVT=QR[geX\AUF@d]c-QdY2?MBYe0e:2Q6YUI731_
V^H4c85&=OL=(2fbM6;@N,+TMBBcTZ+R<7VL),6R=ACLGc0Z2FRTF978\<DcN44/
UZUIJY&Z3-KT(.DL\^6I&Pb<Eg)U-aGHaUS+/@@O35f/2bD#P(@e.]MdMTHQPK0#
5OEUGSGL(L]:C(P]?E)?_R#1?:[JE<5)A4BTSQd:287QWNAR@T_7KQM6d<=)4&&^
f;HVYRMJHIEbKLRfS?35Z4X3/)6c-cSIM1Oe6YU^]L/NOE8#Fc2#N7-Q[:SN>4SG
V+4eN_Y1OKW,CZ)^aB]f&>ff.PI.^H_36)6_\&eB\^QV-TUMAR9g],2B.U4W^bf(
7Q8BfF3C;bC;2)KR:>N3WY(CM=cP3T6O8:O_,D4H^__NN]SH8<E5NaQ_Gfe.2=U#
:3+67,T3@7#6<?4JT<E]J/(B)M_T3B&5XWPB.69]P4KYRQXUA=-,bG--U@c:)Mg4
WN4(67M>0dPJ\6NMdO#-dN(9A_IB1-YLWG,^3<::-P>57X2BSI,3cUY;2e>F8EIT
BEe=/G9B&c5^XYCDH\9fN(3L9_9^/\==KDa-E,&][Q_CF7(S&6eCQ<#a7::,BaX(
PG7g([_35RTZDL+/:fa-XgO+cQ&?O_gY:d1g5EC)b:N:_VQVAIAW8#0E0A#ab8]>
#>1GRc3UR6Pc,M6UK&DV=9_DASS-Xgd^0\JgSG&gg5V0U>NMdP1G_I&;G863:H9H
H&4ag6^<PVS8V-,6)1H]@07J\;c)Vg_J-b[;9gRPE.f4:O,;9E.W&@53aOX[+?RK
d4MASO1O>8(,H&L2W0_4e,(g#N+S_MY2+HS;OAE^ZT=7S;\8BO-V?1U\<d7c;5M^
(gK<(\9,a/8PR=.Wa].+>CXb&cc#?f/8a97>:3.OP(Y=,J_=96(UX8dL-0<?K:M-
K768ELVKWOAF^I6&2H-\)TQ28?9]OW\E670<HOgP3P8)I@)PAC_(5GdaMNB5YL;/
&>@OgOQE(>QO2/N]+Sda)GOOG;DeWN0HJL&1^7cg-GEM@C#XU49OZ@6SNH/N;@D&
+M6,H^N1JY1-+JAaa2A9CFfbG)PWS8L(0.1cRAY\aN5KggV?=;IOFZbBd=F,]3eb
GCaNRP&YF?I:G2V5B(CY)V5&6;FI?dTIA1ZS,]VH<K@TIb3K/,]c52EA3WE:OVeg
UY>U8_ec/eN,P#N+bX@<BBbPF21<<K\?4BQ=TLgA<-4Q=]>2PJ:NG0=0]aF7-aIF
&T?W#:c&6&QB-_@S+Z:6-cXd<bDOFRNT,(?A34dZgPb2KgaSd>5(10\YO8(RYda(
#c[^,R&_ZKfEFaRH0JA\1./.Q0fABIHH5H/P)P4EVCgAB&=&B8N8]+1JbQ-de1W9
Q^[4:E[.^U@6gF#KT0XJ.b.,Q=LVZWENV<3ebLRd&:DffJ(SSJDTe2H(BEB6OA@;
a#EU]8),ZFg]dJceTg,#/2_P@;d.IN5:I&AEa@WL&HO&B,&fgJ?P>7Q?TYI#A+Q1
-g>b<8YC2=3)T/HdW91(9JP@>YcILLM3WG8dWaAc\Ad.QGCe5cY7a8:EY=&R.9V]
a&2:ZNVSJ]V9aJVU2&dKHTc29?_M2W+AB/.CI\^SB6S),NF7\.S.+X;<.&WNICWF
Wg1VKKHa6^c,0ONR4[+fZ37O=TE(5:W3cWNVB:gP98V\XDbaODdYf_9?a.UL.4&d
ec[XCI#SE)__I[#NF>.^dG#P8OB]M,MJS^BYZK;SK@T>R14Hg9G8.;NR81D=69Ca
ELJBAdU.fTTWBD/2]M/1?#FWf<E,P?6:6O84_SVNbWLQ5EU8Q#HCCJ=.+fQ+\.ab
832-G>P5=EJN54<bUff3fRD2ZDUc,JRBJc4XU(I:HVM1<OM6)V)T/@5>&V&XJKX&
GgMECfcR6A]HE,\e1HNW63IJ2I2A.<?Je/Y)dAN9(01MO\Y3c,Y]@MFfZYS^#402
JW33eff.U7GQ#_NdV6NQ90AV#G6P_)KdYPO8/GfbT#&/5[e&TC?eH/-BUF8cD?N?
0#&[bb\X+Kc44Y@bN1TY7\.bI[WN/35J6?2?RVUSQ;M;X35a)YO[2.M4-:M27+?T
7](@\fE+@&P-f+0&A#U+F9]M:+bH:YG1O5;SF9N9[UFZ.52<P.#cb?JdD>CPU/H2
DW))(dIF6=Ta<&DaBQ:aVY3C@Bd&FND3d6g+5OSCcTLVaa.9Gb/_/WbIFZN^I6\T
e,]=b-GGG^SR1&8ZdFHE_(2L&.].,R.IPW1:05<#5M2\@_K8-.U\+-Ff\R3.gVd/
N8)#]-/dd4@Sg?;B[HG8c0SG:Q)f^8d;=-4S;Z9L@#H?4[C_3=4a=JC+PVg4)75U
]I?[V=F1BR9T_dbG4R,1SA8Y6#/YE[Gc0AH1gJ)\c<+#9-NgG2<FU&+\=D=-JJ+(
K+74>gHbNcW9gE+_GFMNeCPM&U01R/HH.Rg9.I:SE>WN2G-8HcaX7Ce-L0+LS+FB
:JJf[fXDF)b2Af;U>dBXX5>H\7SgA];CcWY-&Afe_HbEfORVW7LDXag\]18K6]cD
6[c,R^JO/Q/8V-MEEO8[dV[6V5ZUM=eT]bbK>^[^KA7?HTX+a-QMGUN#ES06I/PR
@MgTXg[Y5VU5@HQY\Zc04Bg((JKFbK<UK/fdLKbYK2/>+4bQ6UgGM^4VZ>+7M7V+
^FR[?2]fQX0&HYA]fe.FTS5?(5bJEM->O/@IY]c_+2]g@<]0)&R/@aE7D9eD]_37
A?[UQL[0Mg=<^>>JPUBfIe>7?3J?BbPbKDLA(16,R+.CSUR-^g\b4b=M+b2V+-R?
6M#LgWXfX?1JE@g[B&;g#E6JD#)0UJgZdCK\/&_Z44X](aRfZ6NUgNDUO6&XI+C-
OU+ARVMFP9H)^,.ETEd-RUdO(XOQZ4X?AM]_+fO09EB,gWPRB8;Td0(#e7:6SH:b
B,OVS-OLZg33:?[GS-5;(MMSC0WU7GA;9c?E=8gX9O1bOJH&RH\#>Y_&\ZXK59W-
\(-=_PII1_>b+3ddKd>?>:W2=X/NTe:e/aPD>_AHI63U=e.SaaU.ZSbORUU8[[Ic
a&[V_,S/V/9Ad8-,?C?5ePJ]HVPY>J2?CBZQIM+fLOfX0S33QPN8HRd]g>_fcU&M
A0YBIT?=_U8,5gXKbPL/13[CB\[XB<(SR?;8I<,]G7e^X/(&AIIS3I<A<8>ZMX.X
T:]Va@R7?:6<]4b9&=C+_0f2G,Kb9&3:1Y>M2Gf755IXXDAFMUgT1)WMfZ#fN0c#
2S^]A?3^JO:D2S2?7^8ESJVJ0/U,<0WM7>GZ9UN-(d6=#gb)=9C+A]?0WLI5VAb@
HDD=&YFA=G<H_3,N:4P+MNCe4A;T)Z>:HC8gM#D)g+E3V[4BFX,S\91@[#a6V10]
9#X.XGOJY=e(&[0T_1^d@K.UHG-HQfYLe087CTJ?J?E5G_0MUNEFMVW(]P\+H.]^
+@4#2=.GP\>NdK+[9HZ:Wb.<LaF_@R5/PJ/@c[GaV.XOIVAN]BRN/AecaQ0&HUJY
M^B9J5(<_.H_eSYG9L?_:8QXBU=_M3=1DLPKSKS2Q&Z(F9OY[-R.5SUZ&97df18?
6/V3YV?e:JA)<+TYdS=5Y8U3WbE1P07\I-UEGdZ+DXD@AB1VAYSV3LSD=3VX_aea
0HH4Z(0C]9?g&F?<1>Xf9c[gXKg>^Te+(D1gLI>KNF2RCC:&5W2IYbeE[E2W[]H&
.RVEeX)BZCJO4[N=9=.4AIZ]V-]?O-:E-^:Kc,SBQ[19O2:]QFM(&]_)S/0.#d6/
9\(d=Z/#&XO.RBE:07Rg(UX^@,a6GDUdFPJMCDQR+N(AD@=3,#;d7[B@2I[QBRF2
#^^CT1VB+^3J9XP)\Jg=F&&ED[5;G.@UKX]YR.gAS_HIe7JegeEH4ZO4+R=0I7MA
/cc9I6TB4]JcZ62PPI0(Ed57IEZg)T]T;5XfX/8^&)QTJ+IK29=&IYBIAC2V=HJZ
<#fZ(U2W4;K#8OJM\J)TB[TA<17edgXAWPTNMfId8^51GP\O;)I#SP,Mb=c>I^+d
#.:_ZT1)8PaGDM9##@\IHZZ^R]gZ->eDgedR&@<?CdaO5?TN./OWKXK]F;59VB84
=9<[O4R2\<TdDAFM3W,9.<deDXg<]62_@-]_;gLDcJ[0(cEB#)HAd7E?JLc+UdPN
?1[D1+1L)SPGa@@[@O[>C505EO.fU2F>6\)HU6=ZSVR<RH\QS<P7RYe+f:;>.\C6
^,[:H<JA_;Xbgc=I_:ERP;GU[KAgb.#):NZR^>/(<<cC,68)LIBB-7GHaf1bT/PZ
1&(=<&)O[+b<LPe=aY?EWX+9B12bTFS#4#6=[?S]U.HEBFYY^&-\WS5/IH-1Y[S.
9_=6d1<+;PXP9K7.:+f+#SB6NTRTSTTg&^bUgC,@MQ@E6THI<GD^<R>SS7>[X\dN
CP&>bb#@5#d;?F;ARCEa(/5Ad5+<HBCHbS-7aLQA7V?6KXJX,C2_a[19FSXTKUU#
<D+aCTSBY,eg<]H[a)<B(QBJ-cbEe;[5@CG+7a54;?I&VQ,9,?>@HJ.9<NPF\LK+
JZF+/10N8=QM1OSER#b2(4[XLEE1^0?D,<RGbL^-IL4dLL<cY4Y2.Kf5Hd,dEC=^
524_:QN+8S+N64aIVX)B#9(L=((#^)L0]d;>9WS?(0X_T+c]+]f@WVf?:BY<R03b
U:OBe&=I<Pc2B6SaC55,^YX6\^fe2,J\/N+V:GeGA>XI?2WP+C0[6+&\4[UXLfX?
:]dg2X<.+Va<@A\HZ)Q-A\eI/##1ACR:\PIaTHNOR;RZ:/7-fe-VcZQ8b:6c#/@R
;)-?C;W66P@(7^MQ4c9=?MVd^F7+A-&>O0;Q]5BOFWZBeEGRH/\O@)g2N;;C@f^M
Z7<?Y0^MYV13JFE>T-Qaa>F0S5.Xg6.9ZE[-Gg^:Z6?@V2<I<9@FgeDCg;e_-?#G
X12)D9\(:B0gca.1_G;Z3E\7;\QNK)T7dOT;8DP._6KTJ.6@OE.;>3A3NYN[&A:4
gL5YRRHEM;A5_[M#V21J?R<c=<7<;[\379Z-M^L6S6,KZV\[/FEQ]dZR[La\6N4-
J/)8J8AeW3fId)CPTe0K/H&;-3\GK:>2g&8[02:J:#>KI_J,@0Oe\RX>O^YTLL=^
^+>Qf3JV:.YSN5.=W3I:4JUJ]SA=ReMZ6QJWEDLEP3R(-7+P#Z51#,GOW927:>8W
c,Hf>-?WY2[,5[YC0SbKBZ.0\MTcJU3gZ?P(>g[C)TH],-1WAM;K<8[G:WC<]b/O
,Wg7X2&TG:U)PG/>5;)#gJE<SeX.94+XW/eMXAF(]1__SLgBH;J2E5S:]R5&B=QK
M_NfF32??GSZ;J6^+5K7VcXgYL0.9-0f<1OE.]\a5<,XTdNB=8Q>QY<)(Qa<\CVS
^Z0+P\c#@63V@Q>0&2;^Rb.(60LNVd77FPQZ0(JCJX+1SMZLYDNL(5AE:WP1BSVR
NSb0VVfUXe/Z8X-XMeE30EPZMc/@eXEebYIZcDW;1>Ja0g:Z+NV=8=S>1Z_V00TE
SgGJgX88\Gg^?>\T2(A9>d8_^0<X&3=S/[J(^aI1Q\X;\E-3W#;KCcJ-.8._5NWI
=^Le]ANUFN75T,2;@L#)B6>>Y_0I]B\ZN><85D)L/b&1U3\&K+L@?&d?C4AD5E05
LfCg@Z#W)MWU#.1Y;,eYcd=S&3=@AObZ<U]US?3KcB_CJ)0BO[IH.V(&R5#D;TaU
\OZT),1g0L=2b/YM76FL.^D3c6NRVRS]]VaQA)^83V(P(ECP4NIHO7fS5F&7/T.@
E[eFgMXS<,7W_T[?JZTG^N2HdB8(f0;4bVFE1RFBfLU?^]ON+D+18O;J,g>VMd.:
T6?#a=&XCWDc2a_/[@_[2-70/W4X<HV.JQaggBdTXKS3O_^7C]f+&N8DDS5=#9H,
(badN:0Y;YK\)DCU+.[I0;efH^<W,GZG2S3IAG_VWQI92MF+UVCUd@@.;R9#PX6W
/;&fC,e5g?8\0$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_SV



