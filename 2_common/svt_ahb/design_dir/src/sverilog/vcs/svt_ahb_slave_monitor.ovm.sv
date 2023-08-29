
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV

typedef class svt_ahb_slave_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`endif

// =============================================================================
/** 
 * This class implements AHB Slave monitor component.
 */
class svt_ahb_slave_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave_monitor, svt_ahb_slave_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes response requests available to
   * the slave response sequencer
   */
  `SVT_XVM(blocking_peek_imp)#(svt_ahb_slave_transaction, svt_ahb_slave_monitor) response_request_imp;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
    `protected
0?,dY&&Vd]^^[/ZO]9&-PIL8_<fY6S9LL=KG0e(^CJ7Bd]6.O(3Z.(@_CDQa4I2E
-T6KS.EU@XgO^//MN5[HS.b\2-HJPV?c)8=75;Jcf]T^VeNM.=P3C275.8TV7aEF
]Ga^5ZIg+==?=Y0dc4R<\KL]\@fLX[\9[4-?P/fT#A)9L+:I09:ePRBf^#8RbTXQ
SB2eR)IZ_DU_1<FOD\1(O,^N6d+R-N)@:_O+\BD7#]V>Q->MF+1C?MAf+C?(-S/8
K^GV?Q_[@Z01C>PUYD7Q?Ng4+G53eV+/]:6NeUJS\&R@,)Y66gBEcO]Y>2_@BV#&
3A06E+.a+\CL9,@JgG:dF0N]Zc@K#H:Eg-;Na_OE)\bf2/TaGJY.\TOIB+?.F;+H
/+T1]94#>(PKT1R&A]5Y2IHb@0:P(+6G5Ea;8]OQR_YA@;#O0.AbS8H\\S#(3eRN
KM#0K5>bcVX3V2]Yd9K-OO0SFLfWF>&9@$
`endprotected

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  /** @cond PRIVATE */
  /**
   * Local variable holds the pointer to the slave implementation common to monitor
   * and driver.
   */
  protected svt_ahb_slave_common  common;

  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_ahb_slave_monitor", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`else
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase (uvm_phase phase);
`else
  extern virtual task run();
`endif

   /**
    * Extract phase
    * Stops performance monitoring
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`else
  extern virtual function void extract();
`endif
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

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

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_common common);

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called to sample hready_in.
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  //---------------------------------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when hready_in need to be sampled . 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
   extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_ahb_slave_transaction output object containing request information
   */
  extern task peek(output svt_ahb_slave_transaction xact);
/** @endcond */

//vcs_lic_vip_protect
  `protected
7FNca,#@1IA7cJB6,AdKP<SQFTRa^ZG90Rcb,KC-HfUD<2gV(\Lg/(;I?ISEN,g0
TGPbXgBM+;WMZJ4S&KZEM[Qg==G2OYTHH/c8MEDg5F9NX42DTb06RBOcaISPPUaS
)IV-\_D7G:WG<(F7CU>,4W7gJLUV;-+\[/Y]=AY0fe;-b+72@eGZ-0Ud;#HJS/>c
WHK\^4A#&GJebRX17(_f^8bJ?MIT-ZW8>e0^aOERed1Y;#L#VO[&&>JJ+B&ZB5X0
2eW4(V<0(O19e_;+cJV/YL5VaGgUV(@.QXW=_J]DaDgYD$
`endprotected


endclass

`protected
HDc@432(4cd5)WPO7[MY:=fD(g+4I.<G]O]1_,#/_3H/[4.V)]K-()RcN)EH;ZYF
S2KT;Q3_Y]M7D,_dK;S:])dX2HQ2LgS-PUcTTQO\N,dbMR8[E_//^0S/=Y(P&)8,
XR(<8-O2/C\CMV&f&7ADO#c#I9H([=dE.a>]gSHOTGfc)@:U;.0C^LRYd<^<b61K
2P?bD=B#EGE-3aP:.[I84B^I)?QN5--OCW;HJeKP.aMM<>^^@\;NN()d?5cB4JdB
acZ5XdbF9F4;3]FX8A)5ALBTRM4g.<ON@Y,/J9^7_eTC-GNVYKSdKK?(H(B=(J#a
/?V?aA[<gU(ONW7,18a[CbPb@^,^9DI@__&f,98=P-\4<E)Y/+Re@5^;L4WS#[GX
gX2,b2U&_4+beQR03PQ>V3OU]f>_Jg8-)R50+1C&T=#4B$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
=>;LU(89/LCPc(GG,0S+PaO1b/],fB7V.>82L^)cI<XXP&P&A^5.((H?0VN)NWGP
[2fgG4B(_PN0>OBQYC7Xfg6<KCIXFZVZTCC8^#5C<>&33H(0>34P\7]-C5Zdg34\
A5d86]cCEOX.4c+41IbG^=QgQ2Q@B,/Q\dQ-D5PQE^Z(Bg6N@U;f_LLHd2V5YcV2
)FO/1,K17)MHO3a]8e8<ZBS6-XXg;J<:^M)BSRP#2I@=4.?aHg-E43Z5fZYJ=OUW
66FS]#TX;=U3.^(XfMWOL.TPXW<e2B&Y#@:Vfc>,R.f+2XW:/C;C^A7N66<,A>FC
adE_b9]_:0^OJ>[^K+8B,>aN#O_,K@H=F;4BOWL-cOKId_<@C=D/F>#c-_F-a&ZQ
053&1fVTN2X\;;N2R6T?dAd5dY3Be?N2E60K4P[Of?A:,Y1NDPgbL?.:DVdC.3IW
Q1;EZX8J+>CBg=<.gJE=f)R[4BD/^>4^4U)f>3RE:.>?N&bS<N3WW[<+,?=8SF:C
;MF<57[<THY>ALVJ@ZXfgO0<X4Bf4NG>2_#.K?a-@XMA3,+^:Za(W?3>N#Q37P1c
EYY7>9M:aJ4/g1R3&ZZUG5Z65Dd^/)L:D(?^T,.U1]T9YF-6,BZ@<\<<#g))>1@N
;eaW<G7b.f2b[#9)9SN0?.WCNeJP7##[gV9>RafG00,,R-Ze[C#^R1f7-8K)[=R)
\#e9K38IBI5LU[0T>fTTUV9gO&^eH40VV]@#OV,_.DF)&&IBfUVVQQ(70.Sd^R,5
W_=6gL-^)eB3\a[MULRe\]_V2g1&?IE<],Q22_M-O.RB?gI^^>E[6XA-SLUC;^6d
Y,?2Mc9PCa12#JJ95A.)]^VSfbZO+9=:HVJ6EH.8X1W?+)/Xf,U7^=G13gcb86@T
V7&NeF,Q>O9:bMTQbWZ#]Q.&^<\0Gb6HOZEH,T9/?AdN-NKK/3&9\RQ08#1&WYf@
^)BE=&aUSP8gXE]=I8VKL>8M:H+D=T8W1V/3a.2X,B#N)I+;^/>,R8g]<[?C5VFg
D=H](bDL3(dc_V4@+ZK<D1<?KUJ6BX&e>Wc2MZI(NU.BU8DgBS_=WK,5Zc1X&11&
8L_XBI366UP_O0a&2R#1VS1)C0^S;IZVc3SX6/7gd[Yd+_egN;8U8-ge:6?V,0I=
M7d96U<gB7991QW,0BB[/DP9MVb\G[7U2Od2M#7CCTWE+(;13NDMDSD^-\8<6&>5
V?BXg7L[WV_CcR5[+cMB-5[1;5S9BIB:<()gVAa_O--/B2#gZ=Tc6J[S<N1O\EE[
#X?d5;?d67[8<:?d]69&YE&#)V0SZ8,7(@(DDVFRM=\_VL9BU:2D8<dPDFFB<-GZ
RSL:#LQDQ9@.=8Ag0@b1-8)F9(8E<>[P#]8H_A+dG/Q]H<(B7OB??D5\KGed9S(:
H90g4T2UO;(QT,:\,_>0P[g0O-eNERWBJ6\.-3dMRU,]>I&&W/=b2([C]Q/>DSV;
))9d1#I0(QZF81c83K<Ld&AS1GF^&XD^\5:9.#+6_O(3?LR^-eb7C3PV+&S3773S
SEYF2OTc&GC(D-L\;C5&+XJ>-[S[-M6S1LM>MF6O7^\G,/gDCM&=M:/K,4-&\)QA
+.I4SN)NIVcaS/0FR=-:0]7_e3^E,,YFHRT^/3<dBYQ/OVdFSa-ga-\DD5BQEgfS
c>1/,KcLCH_THOYfgY<99#4L:OD98JY[DA3)Od[;D.AaV2U-g2)3eSBbSL.35U0?
XL2?I6K]CY7a77^R4+H^YL11Yb]YN(YOc+<3.1QD#AIOX1O@9_\dE35HUE9&5U5J
LaVL8P=.K&W,[G7<>BZNgfFCE3BD+4FG^?Vbf,Q<fD__9NZ_f:=\]-5K.0#DAaec
g2_b]C5A]2+adeL5OSdOB+_0B6(9),f0)K3)61@5PXI9dcd?)2dN7@K#9C<,]RUD
Oc?&I8eS,.NAPI]R/^ff8<\6<+>((ZD466MW41:7-cQ@S0/YKRDS3)cFYU+c=;0Y
>@f_CC:<._658TF/=ENc9?1>G[egg2R&@A[T>@1UFa--EPR.PB3?A+KUUD=b-[C<
#^@b^^3#;&^;a;aOce1f3?FTO0+EXd,9@=b+,Qg@K8AUSE)RfDD>TQJ=[DN&<K>1
aee+I_b74gMI1g>c53K/S<<NRfdY;VX<=R&+KJIX00RNfS:?-][ZQ,(<^(.^<R<8
K@c7Vf#VcZHDd95DS7,C<c_;(_R12bfd@R5I;@2Qb6(,9Q8KR[>Yb)9X;APB:W#8
5cNOV^]bGEg/A4W(;UI;:;6G^^](?a4D64Z]JQGE.212F#,G)3](2MZ>.(LM+^B)
7<7RSWO8eHQf\cW+2C)PVdPED_&XKF(LS\.Y]]S=3Z@Zf.9aD8Ie3)b?\XFIURZ=
/ZfYLOdH\=a)N_gDgA<,JFe8=HgS<AW.<<G05Z0WWD>LX?_<#LU]aS&/acU:2[LB
aE[ZX@e(2T-PR/4H(L;-S0.[==75XS(f>_Ae^5-WXP:;@:N)a]JV,=Z[=@BZ4c?M
Sd.E+gMbK5Q56V287GJ7U1L+0AC_O5LP>T_b?F.UN[ESR@0[HcGJbXJ#D530QE3#
TE\Z3Q&_2,Q[2K[Q64Z]AJ#TXR/&dGd@A&#LM5Tc]SPSD_HL/c70;\]a;&]2UL42
P_UF;aWBAg:1QUfZXEUA.BGT:c0IMDIO,1V1@(;T94_:+8f_W[K_<&L+\7PQ/AXa
9NgU,.6R<BeI29c@Z/\CDV8F8V[6X[8VFM@O-&V8CTSF+P:8J24>b=&c,,cGZ)6c
f/agXL#Q.7,S?&b<-O/eDT,HA3?,WD22@,@A?09E3b[82J/VJ#3ZgPKaA7+@MC].
Y[=MWW;F9FLRge8.82M(Ub5-deT3@-U_A8)X+1P#&(cCcTVHY8(>H6V4dWPfdf9_
;-=SQf6A?[L))b86=G::MH/9(^^TB&C\eT?F/LcR=Q1>V,?<PFP[Y3SV0e@L9CTc
6):(eY+_b>CFH3BZ0@U+gV/<.E:?#>Yc,)Ng0-bRV+3XfIGZ=C+D=@06;E5NL<7>
RD?VfD,\XHM1>,^X_]YfTV^NJ0,=?U[=,US^gKAXa7Gg=U)5+\O/0-fMSc1@L/6@
QL+1[[eZSP>T[9X2BO4K^:/B4_0@L[B]4T008&YUQVcBHP-INb=H6d)&Ka&XU.C8
-DIgW7N9J=dD@RZ@9T=YNbLBbQ0WQO^@6Bb:TDX#bBYg0Yf87[GQfQ6D[He6>(]X
=S9P=b733I1FA\^5?V1X8Md0ga_.:1X-QRD3S)?;6bU7][cd,V:P]TO196;__8EM
QLB,@2\=G5@)-?C?.PB)-OENT2D2dbO:TYT8J]OD>Sa/>TW:-X^GV+2N2J0DEaLO
,XJ=,-,+OZ161RS/;MDW2U#7O=XCSb9:a&CK3.+-Y=(=G97QcP=A[E[dZc7HY9NS
X0(:SbUJ3fO<]9X25DU/>&[6gf(A+g8#ZH]Ff-bU].(O7R:/db1d_I]d4\7C?LL,
_6QW#H^cfbY12E=^SI/.bLDLM5Kd.^)AE9UPA(93VMB6_>_=EC@,_?0SK@2EI@KD
SF=.ONc)TfK67<dc2]R().e]#M:@_G_Gg<=d+W]&B0DUK)XRJ8<XD@^0U<-S1/1b
BaU[ea:>HK:/1\+8M=\MVKa[bUD;MMIISJQ.E\@B8E-OCg8.GYd50ROBKA\]I6YF
1&gcV8bJ)S\Y9L^>Q_L[+03=)ES./EHNW_AC9Ec2&UZ\:U5(-O-WK]F29)H/RbW<
\N^KMe<9T;@WS/Ue(d-:S98UTc>(+,b5O8E1aGQ)ZUgA+KHI<U?91gI(Q[&3HM;W
OMB?KL<2<]dF/V9#Y-V;G=39[=Q:(0/;ANJ;DfQU?.6;^0-SG3eN6?8=I_gg[3>L
IE^N;M8M0@_6&@/LWdQ&65>c0+6XN)WaO(Db/8)APUb5P.+48:_3Y7)EbWHVA;4K
/Cg@_Z;JW8Q+)IO=cf&C,4_QZLAF^VW?7;=Q38,_)Je?3VU(FL\.Y@D](8VWfZ<C
K:8U9RV8(1RN=f+>M6>]G7M5RP:NTAaK@L5F@S(?-Q&<g^Q:[Z^US@CHW0W?>MH0
dN0_1_AJIBb\TV.>A7gZJ[/]YX,)WJ90V:,S0AK_QD-0W7Z4WB?<RM:^=NIP]=WB
#QFM^M&bJ3I07A(-;]aQYRH+#:\:(K(^)C\,EY_II.N9YHTKG\5_2WfQ+SN[_E?P
O<(]UAQHB8-=#ZM+]3I-?g_@Kcd>#K8WMW)G]:AY;G.XS\EP,7I:ELe+TQ.RGYMO
D>Ab?BL<6#DF;e8ATJ[Lg<FS)=9fS7V+GG3^1EHS?Bac7XTVO2BacH,G03fe#0W:
\f-;+6KeU6O)4SM25,KM6B-<L8J:Q=0-f6RbD7#IQa)]Q;;R9#RD_\b4\cD\.CL@
_9<K26O.PH>.J,9Z?J_>g=dZ2L^cOP:73D[12)4E[LDLTKN994&FUS8Y2NB0NO=J
fE#V)52(2?-^,LdJR7L[IdW[.Z_aQagKD3g[HU-cYc5\#H>/#XI5gWgW(O&;;/0Y
FfQ<RZC5&Z[+08G,9@]@.#(]>AF8D?F2L50EBZUJe\/E24[ga8O9N=@2:EX2/N?J
L<U=_/=[7N-IK2&]gA:V<.F<dgB7c=&K5J?gCOO^CW2A52N43\e]QaD[7=](f+6D
5O;(6LFXD<WIW1<Bd&>>2H]M44-[<K,MY1I@]SB\K(3f?PVW3H=7L/TbdJ=AH-B6
QUAY46?ZP@JJ>GKb:L9G[EXFb/R@W=JV<-?,4McZ/5.bP:ANe-UBSdIWFN#WN?3+
&=-&@cF/CWAXA7dbPBSB;/CH&Q+#a>4Y9]Z2@P.M#7@WMT.X@0dKdUe/gILFGN?Z
9L+E5TWb5@^X6<g/>ZC0)f=)#B.__Z1SJ8JQ0-EWcf?C=,^1O>@A1I8\>Z^6bM&3
Hg--16NQSN4?F@<=GQ+9)9NLUZ(0F\[0dSFJ&(3MS1&6HVZ?OH(K2g98J.g-/3U(
OPS-ZE.=[;c7\C6J9NO&ef4&b+H+.=6DYWIAIY6g:P9(9BD+?EA][=.VPD);?JDS
)3_ffOXe.EKb=4QIE.dH89STAY8N[\CUHGM),2[c(/f4#?H)A1.1A(I.:S//=:XK
7a.+(M_;[]LJH4@EGd5QA;TQM^S&[D>8SO#]#ZIAN,7Eb8beK]5V(.]8?]@A&\>,
V3-^=gLU5XL&W?=_Q)H.TIe94JMV5;QEgI(=MPNefX:X/W8P\)BT^;(AVQM]\-UG
NQU&)P]XbRSgJ67=4>OZUGDQR#=Wd47&PNe71K.BcG:O5/D([1+F9]:;5g=Bg1gb
cRZc<cHb\[\&F.2R\MFQ>)H2Q\O/3Bc9&5\8e\W1QRaP5gLU\)ag1?J(F#7KR=DF
EaePg46VDK=Q6I]8Bef:S2^W;INQ\>>b1)TD6,7C.T7gB56a/P7[SE[7:30L4c6U
-X3[7>C7J#G<22X;::_3)K6J(+#<)[7;K8<R,RMYP/[6.DFP,Nba\?#2<.X[3=bR
b(=^RF4JP2P^ZK=6F4U<HS3d((8cAR/c#R@25&-,<L8eZ]RL]F5Z/[HTdY]36aOD
CS:]f1f;7=d_#UU=X0#/FgC^O7.)9Cb6PO5H9^J,E_f82+VFS#7eC;+&6R=L&DKK
OEM<f^H2+_.7Ja^?W=)1/\2]A^?<KILGZLB:\MR?8?--c^[]8=UXgPIRNMS.DOBc
T2aM=Xg>@=+N-,DaSD?01VRYIYKHb@Ce(0@f(R)+eG,@&Q_)<;/F6C8BBMK0BZ9b
XTO,F^b]&F,?5cNNPHI&-U_ES84^JR8ZX,F.>#<=eU9/bU1O;MTXf):9b#;57):C
C3M3cU\K7/fUWDZYE9&Gf112P@\X4&[F8T\WYD,:V5_-[GDU)QQDbL_fBG:</5>J
:FK2UJd0OF>MHIZF_f;>Jd>^dHO5@AX#RaNDEQ&XCNEUCD1[afR)&KK&L5X.34/&
cM?MeV-Oc-KV5Y2Y\?/-&)?_PTMEJJZ=[eWUXe1#dPW>&a3aQORbH]/AdH2]B=bM
RJdgH]3f0)#D3FT4N#;H1[aZV^_MZg(ZX<?WV11g??:1_:)<_fE_/bIY/U9=YJ;7
[fMTE&:85=4,^^/=6Qf2LJ1_8g>AD7d(F0O_V01+GX&A(\<)LK9gF[3e]3Rb@KHC
YPQE8BOLA&E8]7f1Z7NIW;6CTBPHJ+QQW=NG:dXfQ_bQ#4FK+DO?D.W/ZWY9Y(1#
SLG:>.N08>FV-7Q0=c6M+bH_>g(Tc5HdF;#W.H5-f67&3?[;#WfM?^..:IQg4.Q\
33c[3e50P7)X\V3I):1E:g9P.T^9_SHO.6gc_JY.dgN8])TFPY/d/C1AE]:b>6VF
2UfH=2Y+CV\)QC(;&/6S.+1L+]?DGF66YgY9,LKOZCU&V\d#GQUWD7O1]=.>G,gS
Ng:8cg#?7-TedQ)I:W:70-6YEgPgBGb+S5Y>J#Nd,a+^ESg&:N4[K4/L^IH4HBgM
BT>AeBCd+RZ2&<3<+]&]^SfW=1,Y^S]=0<bAB4dF\H4T>.FZ^L;Z68Lb.?aA\EU,
)@\1Jfa?3UcX9f0^KE8BLZQRZ9Gb.U^3;I#ebU]Vb3^Ea]bMZU+I5_+Z),T&&6,1
4R1_W_+<_);KOM=1US(3(56;A2YGDUHNA+OFgBD+<8GSRaN)BZF.3f4,Y)Od\W@3
D)[e[:6.@7M^,_SIb.O:]#]NVOWP7gDbeGW7X500dTI6f2JRYfCO5)gX/\?C)/NY
0HfER9].e^0F/DR-HH=TMA@O\8)>9R>#W^H4@H^7/HRPdYU9414bURT8\?ZDeQ[U
g<b=d:Y=^DIRD;=5FTdLg@:+,<47?;9J(UU:>,[B4=4fL5+H.K4NS-FD:g0OT>35
-^;R30P<9QFA>PW6VaM8cD:\dKV+:MYOF+)K7F+bYTe=KZ5?f=FUT/2035Y5/BS2
&0g/g7MQUd?AC<8;GcV72M^IebJCGFW\ZZ-(YgI&TRONQM0:d@I3\F\5Pe^Ld[IB
NL8XRY7BeT2OMOSZ]M=.MKGe^EA)Q,I5>K&gPdF3CL/_Y.].2K>D<GV@B7;?4R9B
^>J#=a[D.MD>MVP1_TS6//J/_Q(>A8L=0PefcCC_+(g=I1+@ASd(WPTIL&23,NeI
)O5&MOR<fd_X\XPTRg5E&Y]BTfXWf1[8#\P+-IJ(a7MD.1O<MVMIG7Y.6;S96L+]
_?2Wce[R0=U#eM-G+C-U-CST3K)TdZDdE.7;OI#X.;g2S@HG7;CbWP=.ZdTPP/XV
/I_/dCW&(=#5Z+U_4HD.EgU5,]g7B&[H(BB>b4ZA.Y&)0ZBB8JEdfV:\8J2#<@-U
V-b1M(Ef?/K#1[G1;FDHBKaF_IH17Bd4H:7D2[;<MQ6/0@d@72K+EOC)4UM?3,37
S=>5GY4&9(^P?_PILJ)TV?KTJ^-,&P&S5\?80&^2C1:GWC<afSe=][L^:K&6G9a6
3\JV35[c5,&edgPWNI(GY1VQC1aL-Z@P_Q_JD&TL@IAT,M)S(MZ#Na(+^P]a/3;E
cSU\g(?BZ[--3g8Y:F+_gBEPYI)&aCYPYGg_0)#/B8dO4H@2,5d0^F[.[\I(aA.,
)B2_CXe]=/0@([QT+9cP3/1)LS@a@e^-BDOag3aCIBC=d#7USV?cAYQKM&ES1DB9
@HX.IgU/2RM==.#8X^_W]IMb\?HEF(I<@G[[/R&SW]#>D8[Bf7W92ggHc/e]IF88
W_a0E=-;K1d5=1WDPT[5:4E\DbIb=_]7A#B[>?.gNb7A/@8<P]DWUUSeFPdWE20H
04I3.@#2I0g5Z6C^#M7HQY/b4Nf<1c]Q#)T]+#^3/A\)fG+G:@MA2Qc:^<]Z,E_a
I@dF14RN,N,0\VVC(F9P#U.<DSW^8eIC=4PCa)(:Y&MHN5,+_NO;U]3ee4OIN5Z@
0T_;AA:@LS3bVKa98V9(NH[?[<Q9K=8cW-\BBX&S..dLGeY0bTF)RGCD9R75R#A9
:=N_XdG]X<9(2-@[8(^&I)^IT0[@UG2+((@9K3YQ56+MGe0CgIMT;QX.7eDWJ2R@
&SGQEL2?#_BP9#8f&GA<L_Y/bf7_&C]BWB+B256H#FB9\,_1W:)E?3<,_/47cAW0
4gce\aA.b+.>UO>2?g67:e3aE@H)_NXe_9TZ0/9E0aZ[UQ)WSH8[OZ3dbBcgB>)K
Fe,<XH]/N_bb>\S[7_G2BIC4gS-Z:W,74[Ld^/[b1-N-[SDW/G[FLP,/Zb+Uc\N#
[9d.31g>PB:AgYQcPO-+,,7a+>XA5C9<DRVB8O)1;@(IW.&?@RU[d\@NHK-WLPc3
UV7(.&ZZ0[>QTG-K8FCSQD\/SMW>&J1J(5bZ1<C:=@a)A.\D<BeAU(@MGN:>4OP>
VSfLM80M&.#0.P<)&4L7,R9LS;0]W..(TPKPP9EZb4MGcXT0EZ)/9adYJ)cAMa+H
Q+A40V&d,@UF]D019b\HSBf12;a@AfWA?fMfaAT<IbD=VR_/bBaUP@5B=@LT8@g_
d@GRAXU[a/A]fgJ]:a..>(QOc/;>.5A[8TP;XXY:4J6K<Nf1AgKF0)XeVI5F7fWe
QeE(A(W7(d+W=NF3e=@:Mg<E/A^?fad(?:eD>9Y+L58bF6[QR@cA.I8A5JDF@NY(
=]O[XARRE/f+ERbVJ?QY3:/NWNeZEBUI<>TDdMCLXEA79Zf(g-:bG:f3BWUa-J=U
P2(2WM^A8Q;^cd:CV/OMH@dX]Ac4P0+P94C:Y:0ZQX#UMRMHIA==;Mb1BO1F0IfI
V\](VYOe)KC.\b9:VE>SJ1J]N:KMP\AZRW=4a/+V&0;N2]1Ye5-^Kc9E31ON+KT=
F=>aPfA-EbZYNGd__8c1#7Gf4C-2NTF?;\d@CG(IOIcA01d(WV+2T;_\[-K))(X3
#YgLT2V\CFT?GU8(YQ0RG8D2,3NAXORSB,TFTQK[D/R0_2gEbO:(?FO0/>b&S,IQ
+^&/;0<_INb294<<ADM31:L-#I:<+A6X3)b-+W]S)/Y-2KbUgV??ZS8(Qa+[^Y0>
Q3P^/^?W-^-&0:])K_d,QW<fg,:?UQ(&F\()L](,Z:>N=dU=Y8gAEL;Y\UA8=8cd
0,9.UK\I(RQ8:,@=b/0?FIWaI\QbREM(C,e=^&?SETW#AKF2K7+g_I(f.J@OM1J)
](J#7.)?+,(4O_&QPX\aIPN(Z<_:<BD=I0(NZ@_6.<8ITfaE,K;F.Wa4gE_Q/E5C
Ee;Jd27[T]S3G18,6,+0=P+<+2U&^AJOe8SLJH]b&PM;9fPL,Nfb@,Pgd9)=;ED7
I;F3KKLTN2/F[+8IJ2+;A<3E=R?b[e-0EL=]2V]9+C9W(W5I,\]B8Tb4-^14cPTR
BL@\?)]I9YaK&M9K/gHD^@aM_IQF8.dNV,-,]UN./@?[\QYPDF#H@0F;T1QW1QWU
=6D6S&bF6KVLaF&b&)[P0KFWPB@SH>\7<UYHF+cRAJ+A8&PONRC=>b@WZNVJ]I9,
YD=9#=]]&^0WZ>Y8S2C-TZ6@Mc7J73E6CD+f&TQ#7@8g1K=9\U)=2Y92>/bZGJLU
XI-[e^C=_Kdd4>^65IB4<,II[@4BK8Y.J5/I8GI.ZH5gAf1&_[MS1==5Fcc+L/[4
=Cc1H:Fg0Y54TI)KPeP>:c)^OKV@9A]6A?APD,X;&)cVBg^=26PXTHV_.M7<0D8\
LANgV<8STfJ\dTb?[)f/2_:_PHHQI,WdBfR[4#;5f9dS1]-INWU_EKW4UFI&<YDc
UTK@dFTg<OJ3CS>bL8Tgb.C7^(Z6?2:>BD3bQZ/B:4(/N@^LeE#?>K)G]a\Rc-[W
UNT.^_O)fU+]1P?Y-=VFQA1TMY91IM0(8DHLEU;GFJY;a6N-E5=;Ke&18@NV+NNG
U;JYc)N2W8@Bc?;W9DC@WebI2J[^/PMdP[FK2C1\e1XZD66I[DeOf>.):a]>N8>:
L#0UD-9[Z=e>6Ib3EA,F>#6.b?;65_K5A>9&bN2]ScV0bPf4/D(,ZgW)4AIU2ga0
>ZG=CV7N>S3Cg1I^KMW&S#KSV>GEVQ&,2W(K2cI1\Q1,(edUfH>;T:-0OR@7UEA2
HV>/[(J/H5Df&LVPc2_>BD2Y1+ac?G95-1L\K2)IU0=bZT:FK;YdR92Lc&TObaD@
.GMJ4OT>6L\]e6S7B>W+:6E^1O<f4aTE5&5[bE]J^@Z_T]AIIX)]V//H[2<\Va82
7F^I\IX3V9C69;:?APRV1DedH[T)#bOZC.S2]:B969<P6<#18,,T1<_1IA1&Bdd?
2Z5<,7BBDPW5^WT4]U&A;P#T<_X]Gf9b?<):c.<0PU(_gcCS,JCZR(J9U()J2eQ&
+1XZRS0OEDF=(c3H&J7KMER8JP2XMRbC?];,f=P]c\I-4CE0DMg<N/\.P0SAIGV-
3efL;,LV^4T#K60?2FJPP\5d[b-=@3<?AR4;HZ<:1/TV?)XJb@caZP#eM-KRE5,I
-KGa-Oc>6P#4^dKEN14QOb/1La)94IHVTN0D)?0,)Ee2@-6Y57#ebQ@bVVKRERA[
I#&_O(I=&W0U;C0_JA[#Y)O#S7AI;C32AUAQ#7+H53]_P&8,dBINOA6)]JMfRQ8&
Gg3[?._WF9\0PDA1UUCNaZBJ]WObbXJgPTR>&CJ^&(cYed_-(/17BKXfE&S_&>#W
WI:gMQ]\a/GWcV\aa);#gQ1gbPJ6Z\BL,#14QN>TGJaA2(4ZB&)SE#Qb;<H5?@-0
A9WN(<N0]HFE@6ML05WUf[f;708(6bNB_>DLPH;^eKR0bWM64<EP2::;a7fI#g.6
6K+TW-NZ6;F,_.=/4a^HZ)]O+K[FCOC+/;ObEb&bB7G:AW^NL:b(5C&a&;M54R3K
7W/XBJ][>7[-g5YV91T7&4MbXU91PYbX1B64>GS9]S@GZ#>,.?Z_EEZID9A[KD]P
c,=RE++;(NR+@[B+WX?K#ga;G.3?I1\bGSgJZ#GB;:[-12#fb^Ig^<Oe(4VKPS2.
F/^U.7+V6)&S=XO+@FC+fYI20Kf&7aT;WO32:9YK4BI4N/0MQ+_/-)aM7g/E<9Dd
)HGP:]c2W9=:6S[:<L3M+J.IU+NW#FC5Ra9U.;)Ed-8#;0XP0(FH.HA(PN\Ve7<L
]G-AW:/[<79[5Q/[cPJd/-@O+NMLM/BHON9+)Aa4W/_I[09T;NeBaSQ4ccO\b1U1
[Z=31g4KGAW)0/Z-0)OXT_L6cZ&#Z/W)ed?0H&Vg??[B/2#SS#VeX]H5g9bXA?IS
HW0N2@/F7aLLad7FKC342/fTH>>1VfCI3Y[a[Of:gVFP^P)Ld^e#bG7AF==6-#XK
R5dW6:57PAHaf(cDE<,Pg(S-fN:>HKaJ.\D;^6:>]Z#S;WCO34FC2=V)gCc\E:3\
EC4LbZc&(CGAL_2@<DJ:AcVG(<12dJeE7IEZ^?OFP&^0dR[?.c.0bC(?eH-?FX>d
W#_80&-SZKZ#@I[E(1F/ec(?V]<GgaUaKP,]]UD+aJgC\-RdOD#H@6RM\3.2_)>8
gVRcTJXe^/d2?RE\#7LUbb.Oda^[ZK8a^JVWfc/8&Tb;VRd,Z[(b]JY>e(V>)64=
\7L9Xe]cKM8D\Pd\5d6HIc6M-,GX&V.J=.B\O0F@7<bb4[2C++]NBIX(SD7HR0I_
(=<=Y#=7M-Cf/6BEM@\Z+fVU1-1-Q0->WXJ9(6;]P[>#)MWJ3R+f<W4IbfSb^eJa
a>:2BNEX=g@^/1U2&^U]^)^3@_Q);6Y]9#XNdUKS7g;KX_F:^[C(a5c<@7d&fR9E
2?76;1cZ,O2J9@2AC004F(d<6LX7Kc51&QeK_>Og@Fe+X=7/W1APOY]9JXSXd57S
6TX--U:ObGZ9&FQ=2W(C52TY4=W@K#QF692Y[#;E:&\&Q\77X[gG46@\S;+(?a/=
/.Ue+/6Ee3?Q6-6=[T=>LBMJZe&J5FRDO8</ZdE]L579PDX&-XVEKGga\=aRPG-Z
/(5F-TYMQ(7KW[&L-.>^egPHFOGD#/ACb11I(L0:M-S2W,VJZF-4,cec=>dA_-V,
#Ea83+:K&bd&[fNDG;(3P8].2]ATN;ZDE&NBP4^ADg++f-?(4cU@&MR?RM?H,/J9
cT7M]XA/Z_W1:\\ccJ\a8?T&_E<gcJG6Gg@;cV-\=5(I_,d_ZG9=9SK4_>FR90,F
Z0U[8;9?#D_bE39CL4^QCM29d//5LIRP.:UFc&_T\=.gHL>E+KE[GFV_@V+AJ4LU
NQ&YgK?4V#974+CcIeRPbZ,I27=7=6Z;#:+Ob]65?,O_H<GYN>&?9N+4[]2cN_;(
>ZJ[Ufc7cQPHLE)6A:=11TPbcY7e54YT#).Z#/[/2SYER6XbG5)Z=-8ZY9W1A-B^
dYbZE>-,A@FI[;E,T#^[5T^;[.>@T?AN&3f7GJCI\LC4;9AS#X@d6QMHSaX#3@/A
O,F7P=U3S.=0JU6>5Af>J@+F+[gS]@5AgHAI>OfTLe<KAE-2ZX>Ia>A&[(T:5(ZH
caK4U+6F73E/5Y;5</d:]f@Kc(6\GT#N=d6+d5RdK=?NYQKT?8K<B[9(Z[f6gAMR
cV#59?C2L,2\(8=2<dPfQ6fCGbZJN_M_VN[58FHKJ;//2cYN\3:dK_HJMCK#^U?a
<7^T1[#0]>Z(WIeS>c],)SL:8:E)1Q^UN,Y8I_)PTBAS]-Fg5U@O_KF)SO(3gS[1
8HN\LS#ISd:V(Me4=#VY5b=W5>X#<&7KcMN95->W\ab-GFC2U[ATaPY0T+g_AgH(
fLH9e#6Q[L]/J94:C.#ZJ(\.@YEZfV4N_4fggT[afF#AS\RYJd=.(Aa>TeC/T[TN
-d24X]BWNcT)9/YZXLA+L@a4OI51[1Z0>Z0#@^&C,KgGaD/1Sd9\G#WPU.KS3F#M
.HCOPZ_-:T6N46LXW\aS_gg_S.UMI>1B0YGK#;^EJ^,#__C5]9WXFBE<#H^8U.1P
6X=<V,VS5<4Q4S;TT[FN_Ec>)dO882M7E-+EGIJa)=,R>CeVB<CAfV_8,Z\=]c,I
^ZKU#2/CI^e=TZg=/NCFXQ&49>.V/=N-G?HM8LgW[KM3&g+VBYD7UES@/H#)?&]e
bU>gVMD:12=HL(9,NOSc8WN+034,?2DK_\J#B?U_F-TK3=Z0?4#eZR);Y94>;IH&
V9:a)NEYUBISaP4[V#LQ>??b#Fc3QcP79UDX@DXJ+I=I@d)R([,NedXEB]a,L@O@
N_[GR\8,6dJMTQBGd[3MgbQ)#d2^4Qd1594\H-9WL5VCF;JKa(A:\P8_#&S5BR37
=\@:@]BS]f=?dHcH/1cBF@0\H&2PRAaWQF,>cMg/H,0M,>HUAFX5-fRH_.[^I;5/
Ng]G=T/)V6:JL0]P(#/#].aLO?C/KKAg)R6\?CN(d@10>WRS_>-NP8ECaY5V3_A3
USXI_C6J_.=QOaUH1(7<-G#M22.U&Qcf@S;DL7OF/,C10,dIH#A:.af(cV;&S2+)
fg:(:T#WN(PWS+9+/?V,a:[S@1[\0:<d;-Z:/\FKTBe6I7E_41=HBA(X\\5PUZK#
deg6L2E9<J7AX:f1ee)B2:H)[UZ;+_-)OQ3E?DI)8+f7>L=GgWF?CXbCYg=fNgU;
J^S]BKC)FeGf]Da.gdE:5GTO><N8TU8Ief;G+77U5Sa^(cg>[J_9\KI5Mbb<Ac-]
I4S3BaQQU;K;66[U^Mc,V/d>;(.407G0(\UG7M&>R##Tb]G64B8TM)Q0BMUb;H7a
8V)9eYEbV^d9Qe?gY)+C?0A\YN_V3J/+eYUEZ)&+5=X,>8[IBOG-N/S?SB+86PQ[
(]B?@.QQNAC5RNBd0#26:HVQV6d<A+9&?7RA2/ROf/JD_P-6&YTO?G[YFN)@J>MH
.#dOEB_MD,,]7R+6M9C/SZdaObY1eR>RS#E.#O5@g7f^(NPIcK/+W\aPCQ-=,5J>
/K6a,UWcK^)+ZR,E9&,]=MZ0HRD=\W+7g.3a[)Q.a\M-DQ>bUd)SXPL&b/)CY]\B
_7]_CBNO+7+_ZMA.D3WS[d@1OB#Q+36e,9WX-a,S\:C[(5);G,]bRUbS)gQSQUQ=
VDF8TW[G:4K>64V)->9T\8dS9WR<_D:0&N>8LDZ\G<7(JE/XP:N87P#5[F_K+#Z-
,J?C.MR9eBP[&cIg,.TWKa;;67Z.#1&EKEePFHbg]U>-\<+fJdAQBb1;5Lf18bKE
41UFXI-U39E[b2WO+],?1ECSMc4I?9IWQOE[0P]4=.NA;^1BT:5/KE9TJ-;fOEX:
3C4ML>)TZF2dT>H>:,@eeE1^7\JeK8A#QTD6YMDeVI_E;?GLQYc5Z&\0ReaE93L<
^@>O,be7U,_(G^d.5V[5W-@aK,I&FXA8d(4fA5=LZB;Y,BK8ceH=08Y#WT4D>cGC
Q<S/McW:A,A+\Y6gB[7V_[?3aSfTFSEQc5Se6J>9B4Y,([FU9Af:O;MV7F/^X@72
K3LgPb[;G#>S&Wa<4de72:):J5c((CH>T_/?e6,N?6CO3>P-X01IN4g4>PN;Z^77
5-]^B.9I5=<?Z);XB5,#B@HOO\&D\6>[\fZABVX,g\^5cZFS&B]\?51RZ-&MF+G,
N]UdFgNg[DbWR7N=,&UB7:g[e#N_&L/dU?,UDcDEcSIaeEHL5MU0d-/P?;NF\).V
^7C;Pe<UB&</P>)ZOJ<VH+Q30[b51IF14U>/[S</_75EPf5G>-<\I#6OLGICN@A:
E1G+Lbdg7La,;d(5[+><#;EGI[YKDdcO1[^cJGbE0652R+H_WDWA=8+KJL2JJ[6K
+27,SaCORPE>b899,E0<b\UG=C+Z>[ZRN8JVWR87b^.J>BK1HASQ>0.FWH&_TZTT
6_<C[DIQ=b,XJ,Ig9MNP\,0FH]XTG)d#4[75F8&?+8E\K9S,7++RW7,K#W.+@MPZ
FL+IVTXS,HP]cQU45.>5eL>6JR=A]7J1bLe3R1d02Q3>Z\.9IS<DU?YGe7>b_#ab
Q8F2XY]^G0TfOLZ9HXEX+53VDVE=U,@O_NJ4bZF4g?:fY@SU\D,]f/4-]d,U;5XI
K]##XP.#T/L58HVaA).1.V[^-HA8eNI\)5I&[33)4&^WX@U4Y\9\a1+83f<_X4bJ
Db,XK\\D=cFC)F&2P6)XW(/#9Zec0)W079THX<cUa>/K]d_QCJ)PD>ZW(S].PG1g
<X,]WPQZAg>5R+M4S_Jc=].MW8;c=/-/^7YZZ[gV.T=<1_G1P8E(cCB:d/GJN1R/
Hbc;EcVJ?&U,<g,<&,8#),V?E-\Q/3#DBdF[d6Z.>G>6WD[Lc;d0874c9Bg;dPT&
WfR3+3B(D5U]#TT,>UI7:?1PU8d7-AWebI1,66YWS6;&68T05S9G:,[;66,QI4cA
Z5OSRaR0deA&1NB+_<QTg[AEV;Nd;0#bEVJBe[6^Y^,gf3OZ?SVUPSS,\WT?21P3
DgMf6,H/C,N=M?b4=-LJ9AQ\.E5+AS<<R_-afbWb5#<>Cfb&ZJQa;-_;<&6[M@2&
bJAVLYd1=b,[,2J=VR9L@Pf>JD3-&G?]/0^?PAD74PUb@ARGA(W[O-S&T(@gW\Wg
Y#8S9YJ2aN>Ja\&^KRgB_[SWP?Qa&U[5^g)I;d;?XAf)\=K)eV^IE6ZCIG84FLe3
FJ2[[;+S[MdZ+[1Sd(6T@G60.)^HUD6Oa.<,]/?LAO1YS&]+J&5bNM,T4.D<(eaE
9c+af^V1Q8V1(=b^Z9>/9L;6IgZYKYa4WF\JaGBKUc,)+#g?<d-TRdYX#;Gb3IB-
F[ePQUBG^2ZE?[.LEF)eP9?dC<1)6</(22;F7&UMI/+#UIKBUC0)3-#[)Ya]7-\S
O-ULOIg=A]R=RD.Fg(6_XC&U1Ga.#Gg-PK<Pc@X8RSSO@[=2-Z.Rg^(cdX:,5U0f
F8C2:&]F]W5(+AMQ3HHI4CW)BT71Q5IEg5:VWIYJ.624,,#DL;5TdY=A67GVW<5V
[]K<I3I<UZS9f\Z;1gR[_c1EN6bZ9A1AK_(_6W<W;8>+/DZ_T@IV^K6QX_ZZQF_6
We.7UJT28g3?)HdUOTXa#>Ue\I+IN.0=aQC.D6</1G#EP;/<0J.N.5ScO=@:XZ?T
.P;(F6_R9f2,CMDK-CC1@.XX1Uf)X&XH,E4/B1]1;HCY:3FS=\Mb;4;cfIE55PP<
9&9A\_C+1U]W?<0RaPSd+OH7,.I#AP,E4#XK8<L<G]9Kd?A2ZIX-Z:U-\W)->.E+
0GG4=W1;_4-]7K.XWY;?/23:5TF:Y^J^?gIZSY7Ed)TH<IOH0Y^e6P-HONe[/b8g
:W&\QR:VBb/;0g]e?EJI5\MCQ2-5K;:=A6]Eb0g:g\ND)+RBY5S4M6])-fC)fG<5
AVN7(M(/B+V1N),WL4_#[^&f1^1_8G1S5F,V+3Y;RXS=6E4Wg&KTBHM[0#6a+F-:
3gJ7#>HL.-<Z]?\@HZdS9K9fD<UOG@O>(B@C/5+6\T(AVC.#^?K?W\_(e4;3C>.T
<HA[LU<1G(]6@AcY<_7DMM#AKM&J+/RBS(ZFW_9FDQGZ3M0+H?OY^8O5R+HZUAV4
6[?H5;)gD923YA.>NOLR<+</@0_)7=?A?b0AS;3N.,V#WN^P=SBM_7B&>99^gR9.
(:.:[I=525JM-5d:46fKLg</8$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


