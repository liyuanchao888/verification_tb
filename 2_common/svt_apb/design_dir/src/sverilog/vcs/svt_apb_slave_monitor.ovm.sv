
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_SV

typedef class svt_apb_slave_monitor_callback;
typedef svt_callbacks#(svt_apb_slave_monitor,svt_apb_slave_monitor_callback) svt_apb_slave_monitor_callback_pool;
// =============================================================================
/**
 * This class is UVM Monitor that implements an APB system monitor component.
 */
class svt_apb_slave_monitor extends svt_monitor#(svt_apb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_slave_monitor, svt_apb_slave_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
`ifndef SVT_VMM_TECHNOLOGY
  `SVT_XVM(blocking_peek_imp)#(svt_apb_slave_transaction, svt_apb_slave_monitor) response_request_imp;
`endif

  /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  /**
   * Event triggers when the monitor has dected that the transaction has been put
   * on the port interface. The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when the monitor detects a completed transaction
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave_monitor components */
  protected svt_apb_slave_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;

  /**
   * A Mailbox to hold the request information
   */
  local mailbox #(svt_apb_slave_transaction) req_resp_mailbox;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_slave_monitor)
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
  extern function new (string name = "svt_apb_slave_monitor", `SVT_XVM(component) parent = null);

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
  extern function void set_common(svt_apb_slave_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_apb_transaction xact);

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
`ifdef SVT_VMM_TECHNOLOGY
`else
  extern virtual protected function void setup_phase(svt_apb_transaction xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifdef SVT_VMM_TECHNOLOGY
`else
  extern virtual protected function void access_phase(svt_apb_transaction xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called after reset signal is deasserted
   * Callback issued to allow the testbench to know the apb state after resert deassertion (IDLE or SETUP)
   * Currently only for the initial reset
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void post_reset(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when transaction is in SETUP, ACCESS aor IDLE phase
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute.
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
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
   * Called when the signal_valid_prdata_check is about to execute
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

  // ---------------------------------------------------------------------------
  /**
   * Sink the request and add it to the request to mailbox
   */
  extern protected task sink_request();

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_apb_transaction output object containing request information
   */
  extern task peek(output svt_apb_slave_transaction xact);
/** @endcond */

endclass

`protected
OKJ\CcG40M8JZ5@6L_-MBK6)@MEQT0eJf7T@EU).9TA:Q3N6#D0b1)U=LHMA\,0N
OY4CT,QTJ^Z0f/(XH;_A>RV5KMT.I)U[9HY8I=aCH>PV=[IECg9bMSM334D?D;X[
aO16Y.[B&Ce-A#+3E_YcL(,OI18/6_X(5L5FJ#D]&Ia8ZG(-D9&cS9e;PH@5bH6Z
6YQG7ZYQ9--&96M/)96WC78/5@U.7AUL<\O-I(N/U5;S78.4;6>UJD78b(^8@PS>
F_O(^JM]G[=bK9GG\Y/(\=>N7F@4eL]3WFO_b#X<#5NSDd&]6L.Ye7HN-C1GBCIV
d9</M&CMB62J8S]g4B#X=QZ(KUYV#:b)MVU;=JIA-@ZN[bK.CF9/Se@ga6WR]]RL
MYE/EONZ1F7TF&c0A;cK6P#L)>+?-V=7]>@W5A>;QWSENKdHT@ZfHUXKS#6/#ZU\
($
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
g5(9CT4Rd<WV5OVV=TBZGWJAN4;ae1MO1F-46_1;gDS?J)UQ#P.f+(UIXbAdbT0E
L1&DO/-f1D25IdPJ275af7KNa>AJ+M;gR_=@>=A81V-FO4SR<Y-D6HQ,E4-/)Vdd
8OE+[_:6P([UXB9JY?R1CKJ(2BcZ#PKF=G58)c9XA@d,-]4L&6cW6M^:P6(X>Z3X
-LIeG:e6YNJAOS^^N>:W@E2TZeJIeB0_;dgDB(X&RL55991=a>bNUEBOO02C7>/&
eX6fgX,H--5d^2e]&FM[/^EH)][a61_848:Id#YYSZ3/(#O]NC8<(^/3?aWBg3/Q
J_(9Y.11O1S)NN(LFOIf/X..ZT&aO-0<c+M)?V=98V7_DWZf4Fc6>7O2:EdW23)I
)[b#EeW8.<XdMe4SGHCWbE1H^]4a;)EK&I+_XgTEFI0QN6H9?Sd)3#9CY2^fEd0W
4-Ng0fQC0-_HFL/1CZ&E>56_CJeAC:YD77GL1Aa>d8(KAXIZBdY9-E((5KO12;,N
+C?J,?g+I/)..E0VS77@_][_X?(L+J-2#TO^W9OAcD,JW_)J#K\@g1b[K2</gV1^
VNVe12]4U/)::10FP;;;9[.#RY(bNEEJ([I_K3=;X;f<#TL#9fNGPF16]NF=Ie61
AV,QeQN=)ReGL##G?LAI)fU?Db5Z8Q:AT@,M0ZJ[[L&YG/B[E2aCb=D555<b_7dH
=@TA(JJ5>K6fH8?TO>=8dL\ELDg1=Rb?3CZH7M22aSHC[QU8c5c,dVTGdf)SII#C
5+T6NU=b/MQ@AHJAWIBWTZ^:3K@-7<S38gDF#BAV^^HdW&4cBd#6fG/IA[WYTS?^
,V:U<2U6ZD)S.P2fbC>/&0EEG=ISd3)AeG.L.f;RQ\>Y\3Z-gVCG-_O].Q08W^[.
X9+Zc<7Wf\Q#I99Ze:]&.#?#+BV)-XPc-3X;gI81^_R:YBZfMENQ^:bMZ&2Q<eDJ
Kg6#&YM>W.=Fb3CKI02GGcI&G4E71#]^.KPH/G?.TN2?7OK2;NcAb<B-0Lc=R]g8
F:]+H-@0]-=AX<cXK9F.Q<JT_4Oe)/8UW@:.Vd.OSRG]Oe.GgSLP&6:Xf]?[=:UA
aV34Z,dCMf;O+#Xc\NGUWKN?N>[\)5]#N4_gECSJfX)R^4YE&>4bKe)BDMC7HTEU
GMONR&Q#C[^WR?#CFP7_(83SRaZ-P\\6?IJgaMW_LNf?+6&L8S8K6L@>F70Z3L<9
LBU,gFSdE\H.72;CJ+fX7GF;MHR?dY#BL;L7PBDc_F)TKQ8L&^S.-P0222A9?ef(
&eZcR;SC][UB5+.-W,&24)]=c//eNAB-)HZ,-CdQReSBKOC+BP;@ALXS[S]c;U=5
+O/eb1=MGH1RMD<Q7#W>U>Y7DOa2GT[PNNb7VDQ[Z51D.^/B^_^DEaZ-R6.QJ_#J
US@c\?5G[9Vg@2TFA7R3XYS>AZ6TN9Z=MM6Ef/)b3KT^I0_b(SXdWZB?N,-FMTgU
Mg[Kdc-]f5IJX\NV3BVfd]D9Q5d.K8f;;V1:2\JG?U,&-D\BM/H\\cA)X(WC@35>
a1LCLSF2F7?^,3KZT9&+SVDFH,.G@3c57)T,,g:@3@\WA&-@J2c[B7YONXe]bNe?
R1e=P)R.7S@)agg\KS3\[g6CN.JUS4QI4L;b:B;=C_4I1?I^GZ(QUX;W-NJK?e-D
=Q.;^0(D?[U/3SbF@/2(29/T2&;XG&8f#DG5^P#<N)347W)2-1eE?H.OSad9g#WX
9-T>C-WEbbE]A\c6Ra7V6M?6],>IMQ4T1#.:OIcARE1@T@=N/XA>eNKZ1(VFY\RL
FQb[1Y6HbF]2d@Z6[JO:2ce.R^UcKJ/=0bTMTb<BgfW+6gCAL^e+)Q&DO<cVN(9b
O>&MbIS6>#ASS9V^[>I^BI_S>&ZfL>UH26#8^L98IPRWLYc_OF].W#-b(17I_(1-
9(O0b+U]6)I1RLUS;PBKXBc3((:T\_Q0P+g94a^-+)&>UF3,Q8g#/6O>O/3[EXf_
IMWH1:7#9[F9[=LMO^ZMK52-LY65;TEDS4)G\.IP=dJbN6A5T?S2J4[3#e4#c)-:
V),1e:3f/Y9X>I?d.Xf6J&,8+NPHb59DH(7_,RM5cKV=,+7](<CRcGfA]RH>K3aF
OPN2I.:>+;5P\Ld)3LAcd+#V=MURWKY/[NT]6+LH:(8e#]f3(0C)I/Ae^PBG5J]M
)LVX.5.R)AHO+JU=4DMH]&]A;HNfZaS49YAQW108D\=_)R;CL4P57X9&@7G=PE;d
g)_T>DbO?cfIKF7P6(MSK7&N[FdeSBV/)(;5K;(AOc<Jc#H[.K;g98\HgdW<FBCW
8SLGb<V4TaJcKJ69=L2.Jcb/LX8Mc5@-BLR81>_N.V@7AX](bWe[F1U>.HNg/bE+
++ZJ@:?F.M-e-\IUXIc=JQAK(E3-@C]b0@QZ<MK];85LcL&2(/K\B5I;-?<-B2(,
A1K0L,:JRZeJ-F,9Ag8G<K8\C<2AXY@<C7]#MWZ3+X;K[4@RJ=aJ81_XOATC,1N?
MI=X0LB4M:@2&KaAe_ZMOKY4B]2/HZJ8gKgXDAV9CS)S8C6^8?E]>QJHI2eX+2Ne
=>c<GUe3?CUQ)f7\bCH6ZYf0J&P^4W?VV]fG-9L5Id;Q)<MFLSZTD<_I;G^<4f-^
H/);dK9[,2E)>IcD0&<G:2_6I5O9]UV=X1YDb0-egGG/Z^B2VBc;Q.0)K8GKACT.
_V?XMLM#14Pe]K\bRV;KIX1RZ,Q.])_]M=)(Ad+BO=;0O>-&N>\E.G)C90A_BV6Y
H/F4?6]##X[VAT:./.,T060S,EBSg]^NQU,M4.7]X/EcWE5FZ>cZ3))aSQ-TKN8E
8?PccZ:L0S9G9<1A(PE38D.G]bW^?E5JK>gS,L)Y\PQf<XN6OZ7<[a^0,P6@J47D
0e+HUOa5-.Tec#RYZ3L4Y]W_QT\J8V>ec9SJb/7+.+;R<>3Q;YRf>MJ+&G_2WUZ4
::RY?\g>dG8U<F2&666g&c/46cG0^;&)QN)>^5e.TU_-)S/&33S,#\T4#Y20MaYH
200Ta#CK9@-^DFLYebD\cMaScWKW6W&UM8CQ.TTD5-B\/aC>]TK0de.I]ARE/(<b
3ELR)#QP49c)M^e+Y#E\)BVALL8AXI.bH-Wa5+#>8g);R/\E_AA82gU\^(5_,)/K
L>\)cEE_GG@+3<[;<+7-c1_1aK<AGaXE>C6]SbV3-?]X+2aBK,H@&XggIJ\<,J#\
YC60Eb@M^U,Z4J3><E6V;0U-cUYVX7[,#7F7Q2S#_bO2-JB:?WaYdXO<5[&8ga]a
DIL\;ML:W<W4d=7aW2/Zf?U]J&T9K1Z\.NG]W\cK;N2:2R[[+OZL#D>Q^8/1DC]H
BQ3b+VbJ@>T76IDeJeO02@M41@24G_^1:KO=-N-b65B-^(C.>5cgJT3#1RCX;5d&
W/^O<X#I[2GX>2823O-C-C2<K,?DX&J?O/bAKa_fg<#;ZP#2_-#BA9abUcVCJRZK
&=]UfI^F2PC-A4FP40+<8T1F^DJ80e6T)\<73MVY@7OS8NdT&#V5VE5IP5@3BcFQ
V8GP1_#?4-VL[FPa)6WcTHW9[+B]gaOgg&Q2C91N0d^(C;K8_QS=BNXCHWdTCAJG
5Y/dcT\aI=b#X8gD9Lc#:##\3LgdVXX.>X\cQR(07UY1e^O#W<B0V1E<N^eP1_[\
F&W8A@B:PO)IR6(--M1e\WaO;MXN?>VM+G[Y7D7]C\EAf[1QgCP41TdV.g#c5#)G
-QOB5=D,\03V[_6S,Ua3dYPA@[3W41]VS/,4ad_0844KRNJ9^)/K8>+gOUaVNdB)
4QIAX_B&;9dJ33P]79XE,:a@bU-R9P(.&9SL-XaJ,b)DSb=TZRNc]<)O]a4\239e
CMU[D;MG436W)2,_=cU+Qa4(6X/;CHYa^He@U0)^MEVBTV9@\<FCKZL?aRAc8(0<
=DF<#1.:ZcfLVIDF1aNV(?g0\IT0(8>_PI43ZOW\DU4a8B;0XgKSZ/K;TZ6KTIK&
VBc<-^X2XZRGC?W3=0SZa2C9;Xd3c,MU?^_U-6OW\G3+>C[dfYY0/gI<6>(NPZ05
^+G8HUDW&BGf?fCJ_BRWWK-Ma6[05:/3/I@a3gKP^<7UU&8R#0,=Q6TC\GZe4/6b
)SS2>EVMSHPQ/<E=5_E4NR,A?<Gb6d_T-C\GG_Y:2_(6CR,0W6P35GBE/N@?+E#O
RP/;G;6LRHLB?7b_#c@/@LBI7.G=fU<+I;CMTbL9+^HMKOGa=9FRQHE;=\:W.f,Q
D/5,0O,Yf(]5)YH6d?:SLB<9&WRgR4D^eYdce6BD_2BT;(W4GfREggF>57:08==>
RJIS2G@JLgd4EO7?_:TP+eMRZRIG,2UKP>]^UY=_IKQ7O.\G1J,bg]\)<;+ED9(-
W+89:M\>,g=NU2bA5N.I-X^/I6d4U,4KcS_56GbY@\MXH1.g]?D(C,4M3-PC]+CZ
S7J/EE:1&H@OYQ>=9\bg0I+?AT7ffLP&C0T&A,(-:N_B1Ye]QdV,[BM/QKMUW@eB
FO8e(gQ628[fCaM2J.(F0cFW9(.8WYf(^4[5N-.[>&G4bH=G\DKT-WP,M.<+3)QH
R(cfTBXV:JI=DDN))29;A]<7#2W>J]_4V10Ee^T#]NSYS+-=11b_6II->;ILA?M]
83#f:A137]/X#S<U.+R;eHQ;1b/>#<FeA4DB1^J:;MNWg0g9YACTc0G83[NF+L/O
aVEH9O9R\@[5/eRR/7Jc2=Dg<;U1N@Y_T0/=3g^c\M4UE6/FMO]ELe[a.?FI2I[G
JXV=:@2BeVQ#E=J-@ee:AQ=g#>M^a92UaM1H,=B4,3B.VC51]Z+6QYMOBN=+c,ES
3JD=BEJ[RU]RODc8]RK)0eWQ]G/=Aea]<I1X9/;N4R00MYWW391>S4L7]I)=9]D4
^]?W9#V9OA-V>?RDWE]?g<?QeJR/?S#85APU(?T/;X_;PFNLG&FUgIJ74;e4N4,Z
(F2;\f+)&@Ac,?a=e5W1eNA0Y<28Ba=.49eF)WY>(N1bc]9N18,6S/dST]S][5))
7eL0^[-JQ(-0N6\\S5E.2S;b^GZ6QadU>XLe/48OPbg#VYf&NIe4\Zb5V(T-(L<K
]Bg#-DV/O_UH>YGY@c>3NRY(8>01AQDb,VgNQ7BJ\RIe=OG1d/:bcC#]dUGb,Z:J
+,T)SA-\gfK9,IZGd(7/R+c>_\L[HU=NK\FVY;\6O)bTG0)NgFSV_E@9PMS4_Z:-
9)aca,;;^)S(_7&:6A+L8PX0I^?)9g/[bc3C\<]d9[FFeT4A(C+GU@^GbVb;X4PH
^;10H]XW<SXf-:cJ)8Dg]AHD@UD30_4G9RG;,RK7:0f_#<+RF73Z)WVAeSR6]/@#
&66Efa>QSARVD<JgN4T.+_GWYL+D&9JPJJ^D(g.HS?L\A:0=8W_+J0ZH<dKCH#[R
HIRVT6BM</2P5VQ)3MMb:18I^Z^6DZ>AC<17&X?E5A^CC=e+B=2)U>0gCG\F3DT<
L-a;aVJA^5]EE[N42(HJK_8)UZ:O3=A>Ag.2bb&?30OJOWAb\)M/6(>eXgGOZ6FC
aOMFFAZ;)9G+60S(X-]T8]?(WL7bBDILTY&#3OIdfZ)eeSgJVX;I#N#FeRVL5U^/
/M[WT4M+^ETfF_52)_AP:P-O,fS0NN/(>K/g]=Y[<@:(eRP9ffF\QG5>1O:aba[d
T_W[1R:Ve5\M03MXa4WTPfV&@_g&H2ZHO2fd(Q2+XH>G\a+Pfa-TR4A:)#\?CEa)
M<)a?4Ab&IFcP0G0]0eaF._KP?PCb/g+ZdV2@&;IM2K[ebBTM-KORa[EH=[@f[b,
7G-/]f;)+=3:Ib?#>2C91H:H-&.>:9gW@bI4+BF6::PJ^/H:?LAQY@41HO3eF+.g
NL0\_#EWDLDdbB=\/2)\O9-fQ]DX44;UGC2=c7^b/TDDTb_b;@H4G38,-CZY^E(S
.I71/Z__.@:UK+\Ie^JI2>E+b;9KI\Z6TGET6f[@ECFE+[W56\P_NN=DTD-\&P[,
>BL/[RT4.T.d8C,11aVO3aTX0WgO1-DgNBJ?eG35<e,J\K6L3S:(?QM@/T5#TRP(
0L2UF#85ca4e/VV>d6Wb:b3^-+B--RA16P^<@YYYXKSTPY/7P&g8T.=WZIe4:A?(
feVeJ\05&-6F:e[&8\P3OD3<HPY6H5_5PJ.\FAN)PSSPN<DeQ,Ca@BP-[<3Z,/V7
=5WGH8.,T[+C[KJ4.aR\,O0U<Rb58f[9UDYT2[HT]Q^eE6a3.?P,8BQZbE^T>ZS?
C_G-:C:X3b9\,WHW@[>)CIaZTc/b(4P?,6BG&6[a0a-#:9g6/Td2eWTd52_,<<T>
(=WaV2PdfgVUJ-J3O.OgG]gG3A<W8^d=NH2Y]C2S58e.+GZ?XCE>TOF4c<UU=c9+
3/=;.a=U5T+(_7_QP&9GX-6fD+_(f_/<SD9<02(dE#QB\f@A0WF/L,;..T_QQ9N4
c((e&)W^&1D:G\cI4)HUbDO<KJ18^\23c=Ua^RU2TE=W]<5:H0&8b3?NfEdEWE;0
J?6.P:R>]#g2(2^1+3dE;6E1ZbAIQ^T<C>LSJ?@)MXKW<SM=V>MQV6/7.EHV8Z7&
]D#ag28d(\]G[TX6V0/D>^@A]e>WIEKc->6Z3g^+]XJbWEL9TXS5f2FLH#A0N[+7
]21@fIXTbY>g\#e^Eg&>T;+,CLY2VD^-##-@R3=:F=[0TH6<B8[T5J&4,JMdRgJS
&IG:;@Vfc)/WA>YeYc7P8D5AG++VRO;G7>\2&dQCf[FcG7La.APVZ&0<+c]/RSI<
::0J)S..B+3<D66?f91)7@8/c3AgU^YQ)/:,S7]<0+5;<NITggBfEJ=+M.3f@1VE
_(afR2dL58ID\##G3P<aF@Zg\R,_,8@F?g,;IX1Gee;,DGM<5JB(/W,9N-S8Ub.4
g.gK[O02?Vcc+_Y+._D<6=&Sea)A5FO3KSIU+a/;2?BgRb/Q31U;@S9O]4[@^X@V
?Y9;cb:eF]-NF7IDYALZ^VJg-U.7,1CJWgg(Y-#>8C?:I<,5\@\TVH86Wf8aG[5G
;Ka;0;Y8+;TM_Ia(&CU&UZ#;NV\<UV/9:eFWH6^6gB]=IcSWJ:dHNNQg4GXJ4+>a
T::5VR_fFc7UQ_^8&YD5_#4X&@6(Z&C4(M1g3eLc[(ZI[18f>1:N-:\_62>GTLeL
.:b,OP5f^,=_ZJ96+7_A=>7/;+R0[530?E:L7<MD]g-^5A<LWSQQ;GB1WQb\5>7I
ZZ+?-&(^3,)):dO=cR8B4-E9?9^Re^+@dVc&V1#[0=3OR@bd;R-bZ=,#7KKM+JII
],O_VINd=6bG7@OM(&F=SR^.A6+abT0?d0EcG]E&0Y90XHcHGe-81T#DK:daRcY>
#DAcTC[HKABaZ/->LDe,1JKaaOS2(c+XIJec^+=Q]HDJ.BM+F6\,++^50d:^F(BH
V]7R7>Z0=&O?^e_VEefCZN^+A6L3Za.BTY>^L8)M;2+fgAFL9L+S,d30SNWR<_/W
GPT/0+@U5M&1c&WR@F)_S7U/@5TJ5a[SF0M-RP-4)3?=D><S6S25T0J62>B:bg1W
HaL>9e5(MXYB2NbQX3QET#WFW=W;(_R;406SNGXPFf/Z2#B;D3b4OK1(OR/c30SW
5,[)6)CQV1L11DW>PD#QB@,(=f\-9FaJW&/0DOdJ4g-:@dEP<aL:]Q9<)<M&<R8W
COL#I\8<a3=9gb,>KLDgS7fFdba733/C.PW0\C.[JG8cJ9Ja84-P2H@f.^AORd?c
@VWGR3(94)9RX+ffM.:=G^aS]-W6\R^Z@+RQ8HY;FDKK#Y.-P:<KY&:K=XU=-F,Z
;;,Z]F0EO+W0_IKFII>JNT,&Na\1]efCJdc;Z4A,CK&L6abP[[+d<3HS_eVZV&C?
1:=T-If:X7MffF/P0:ZIU]e#g1>I0G1=XgWMS[G2UP9aN2<GZ\.7Lb?;?)Ig76(O
\:,g0:+-O:-DaSX9-Y7N/3A9Kf8]LJ>_JDZ.8.UZ0Sf&MBUA+W4U7Lb<W)bW>X87
CF-9W_4^[2_/b.V.R<2Yf?J14/.P[&C2gb\4Y&92)_U\U6X6+XcB-SE8e+O-VJ4V
MCSg4Z=/3CXREX\5<CE2c:/K),,>dgM;D/#G#H^TB17CIV[HPO8[QEEQ;S8]J^7Z
ecI.#BR:V]QDSU^T+Q(;PV3,)P<4SY92=3;YLZ5fI,g?&5U9@<H@RKI>Ib1f;De.
DQBEF06ZQH/4;MH56YXQ.O22\]BagX5QAUBVA+(ZDXaDNgc^S3M4GK3-Z.,RSPaK
TXW,?FJ@?OU4..a(QF^ZX^T\2803]QHTH]4MW>5Fa0-,cCFFUZ?+/&e<cL^=@=@B
8T51W:/e/9@;dR^3[aa,\[;;,HF2fE&2/O>\N27T3L_fQ.:Yg\Z7HJE@HH2XQVNL
V(44F#U3fEcLZHda+B5-D6U4)+<00@4f#0;^RRA302L9)T3.DF&N.[C)9H&B2a^@
^0e(2,TVR(c80_QT[\f-MGaJO<IIAe+D4Hd-2([bBJ4RZa]U\gT1ME#>d1f4]#T\
/F9OI+X+N1dC:L&=U-RH1B@CH]@OZIL?&/(D-XWYBQ9RKS19R+IKe-g0R_Wd&W[R
XECJRd-7d@.<FAfO^-Y[?<I<Xe<K1O0a;Eb3-<J9O+Z=T+I+gaD;3c:^4=JUFd36
8K2c00N+H7-Y=\DdZ6c&]5CK_P.E<dQP)5/7_+fHTRJI\=,YO92aYcFI]?\MBH3,
bB+AFTTDA_B6cQJ9R_G6\cP+a(>3#CGac:RKXcEFL^dZ4Q8XB?SaTGOMGCaC:L]e
)#+V@+CN55YAg69_:,41\E25ffYC)Za;RV?#_EG6V((9:A1B&QM[V)-[F)cQd3,F
AV-6-&A#0_;/=A4),UJZ1T.-O][.1LP:9X5XR<FF<fIOg2CG8239?KM9Y@@cc?Rb
)M&]g>;M+)A)b(=-YOWcOUU7b=,E4N,(+\Y\N>XMJ)T04WYHYQ@CHRbT5BYRXF-=
fJJ.c,IT7^be(Tc/a(e(VZBC_gb,DD>RX#L?AOH<>8=Qg]4O#QC&Q4OSPXa8/X,3
7C=@1PGMUYOKP1CM;+DMZR5UU=QM5T(-AAdI;,e0_3LI9#>)dV3=Qe&]QKc::N5>
LCBAPd.&?T<<]D)d\Q>]NZBeP0KVN><./L&<MVRH=T&0Fe(dYBCXTH(f;2e-<,8C
I7[Q5,;(OTg6dUB;C5ZO<U,a^?<A_1X3=;?G3==@,JUggN.J2PNV]31K(U)P2:]@
LX/4Ne[#=3E-2M?^g>44P/=PcLeaDERPV6?X2\fe;Vb;K#,g,^QSB#U-RS/.V2Ie
<&fg.#Q(9JMeIQ<-P?O\QGF)?X,Gf7;Y:@OMUSe^,QUCF[M6]_L51-0]S6<DH[ZY
)\@+@(Xf9e;?.MdVffQ>6Og]U5gaMBgc[46d1U\8_>KW.J=)TGL3H>/WUB,g<^;c
)XWa-LQOfJ,ebM8ZRH<De9U3<ACP]CNNR1)@UBE-d+(=M7aD[;0EWHgfG>>-R&(d
@1.3Q.AUd&;23]L^SEA<KI=\-N-26<YcZ[O^\HaUQH+PJQQ9T9\/b&(>9Q1P#0^[
ODEM5J)K;5a1@KGQ).O3-e>T].9-P^d>UeC10NACRKgY/1)O;<ZEI:eVBfZ63:X[
NV@0RRI6>-P-@b]V.D64AKGgcE+d9(;deF9^2.b.>2c9<RG^CPd:d&]J_.b/#S1?
eH87#Z:17ZY)=Tg8P=LPJcF<Y>.A:eSU?e@gMd&0;<584N9WOS1\(67Zge/]9WW4
<+413RfVcCT51=?+:5FD6f,8S-g3?CEeVVfRQ2g3Wcc[6.7Cd_-aV2F\-Gf/fDBe
MP38MA/3,V0)8#OS?<&27-@Mf\GI5(\[@IS[<4M]Z>9PMB/dc3(FD=M6)eV)c4BY
Z4V),+L+L<>7W\C_7DJ,KUbGd[0W?3.;:4H?2)O7^IR9G4.=egV8;eE9FP9\>#/X
J3]VU&+Y6>+<McMKgWOgIcFc\S3KM&A,0L<TA[@@&QF8M4e_M7@>9,4PXf+4.DK;
2FeZ:55RYg10-f5^QO0?/6aDAUM(2gPP8Z7,IW7Be[]LF1#_V10D#81YY]IgU_F_
F5feAMQBH5Hf[Y#QC-8M\g#],:K,+T@;76;8b<>>NM0bLO]eSS_23:.I799DcTCR
9]Y=_V?8OWHNAH92IMbLVLTQ#KR6/\JFP8Db80I,bL@5LD6bX@<\OLbAGWZM]fdf
&=#^.:Fcd6;2aPJ)4b]XID71Tf9DC+R4^eY3JZT,D<_.(G(eaF,5fYcM<7_ZH9bX
M::,&/fK+bOccZQbaJYK5_><0_#Fd)-(AWAgd6AOe4G=VG-FRGc1_206\f+MRWD_
P;d=b]^JK.aLS)FIa^Mf,F6)+V+&0(F+N^&H6^1T/2P8J[U[#,.1(WcNPW&;VKEa
TN\UeKg)?,58cMBO0]Y3]45<7Tg=Y<4:3gYD9=R#,XUW>;&/=4:BQ1dP0WZD30Za
;:CB/VBa_P<YM6][bPL^Y-W>CQ577Q2e./b9)eT^#e:D+\b6-1==AQC,W2F8_.4A
gQT[UB><G0KY&4T@Q(]7?WX&3aO#\7Y=:,XbZ)REA=64_4L+<TDA@&]QSXPX#10:
M;Ff6&B=4.=Ke.:(M]:#6M17<3:Ae+fPg-_<Ia06;6KdbS-eTWT_F<fO7cD.<2XP
=e,7[(\>/XJJJGXG/>]Zbd\.PMN28Yb6,__d3.adXN2_fBaX>[1W;?+UGO-^;@[2
DEg=:5fT-CJI=V]-0)e&980fQ5Kge55#1^aL87K(,T^bZ_gSS(FMc66@U=ZM,F7S
9Uc-:@aZ)Sc@G+Z38.[4N)?[8;2If9QTXBK4I+8=SS?Y91C7ZXVY,J1Q/<5CYaNe
\Zb+FfL,6OQD^3MSg(Kc82+UBY4X#7e=].NGE4:(3aJDGJNZ4@E4g5_ARa(?4=N)
MIUd5PM[CM/6,;1JB9:AeN[-<2gP#7bbgNX4PU7-S2ELcFG)H;7OJf2HVPaBW[^+
7&:Jb-EZgDQ?4^>g0.?2;YCGRQ2@c<\70cAKQBV?C-^XZAE8P0J]/9dB_a[G0LI-
gI&N/D<SD&[a+0a47+^C4b&?A?@7=@OD+14gKPfX=;A8XYZ?(XZ6KMUMd\R7LAE+
A;a.,G[=PSfB3YOXZDYF<G7]#;UV1aLT#3)3EITD<\>X=5cC.;D_]MH1,P8BeNa?
c;L=Y]+NVAW95L67U5cGI#;0_L+YN;B5K3=INbPR67#:)#3O&ZBVBND6e.^ZL^+^
)GBgR/6QI9YCQ>/VPYdN.IKgUKUX#(=6=N[YDPGMA_(WS)7#9U\CCO_L6#>c,JCb
VRES)_E?G[fEg?X&dSRVN1<G<GL5V6Z>=2/NV<)W4O[T]U366c49=AE=LJA4U[S-
KZS#BJ\#dMH?NPdXFTHDQeT[RY?N.5TIL#ZF<I+0-3^gN+I-O10K/fHCAd6#I:Z?
_bH\.SXTXa1OCJ55S0Q562WVK8PN0&KM+S5Z:D>-)FGgA$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_SV



