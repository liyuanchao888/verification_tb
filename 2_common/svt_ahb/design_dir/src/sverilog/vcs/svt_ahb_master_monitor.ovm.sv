
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

typedef class svt_ahb_master_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`endif

// =============================================================================
class svt_ahb_master_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_master_monitor, svt_ahb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
    `protected
DJcddeF.O^^c1]DZJ0V7]1]F#7R&0LF<QO,<P-?X>N>BZ?V/R:S5)(E.YbL\W2UP
XE&HO0Q(?ge+VX(1_+7)VD]_;M&7(:P]N_#R#)XfB,_cJO=KYb&/)a61ZSD8&Pde
bFB#Z&\3cb7Q<#DP[HOdG4?HS&1O_\VKf<0<6-U/>IW3B>9NTWXfPQRUL4N]d9B6
F+FUFN>/5UOUUDX;4F<aUc.NRLSYGP>TW)9:dL@].:Jf8)1F,cCFc/GAZG:]0^@W
>R^5=[DbP9;FGgZ^]2cS+62,KMPQL4gNO9I+N>Te7BX>EHK3[H6TO\-1-WA>eQ_;
5C)]+d-:A+^0SK+(&18GPd+aAM9/^YW4M\>7NRKR(d+#^P[ad3NfB];/#U)@3SB(
48TKY(;N6ZF>ZOD3@Z0VXYSd<VfM[D6-=$
`endprotected

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Analysis port publishing observed transactions as PV-annotated
   * TLM 2.0 generic payload transactions.
   **/
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_observed_port;
`endif
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Monitor Configuration snapshot */
  protected svt_ahb_master_configuration cfg_snapshot = null;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Monitor Configuration */
  local svt_ahb_master_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_master_monitor)
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
  extern function new(string name = "svt_ahb_master_monitor", `SVT_XVM(component) parent = null);

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


   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Called before putting a PV-annotated TLM GP transaction to the analysis port 
   *
   * @param xact A reference to the TLM GP descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_tlm_generic_payload_observed_port_put(uvm_tlm_generic_payload xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a PV-annotated TLM GP transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void tlm_generic_payload_observed_port_cov(uvm_tlm_generic_payload xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low
   * 
   * This method issues the <i>htrans_changed_with_hready_low</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task htrans_changed_with_hready_low_cb_exec(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans is changed with hready is driven low by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void htrans_changed_with_hready_low(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

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
  extern virtual task observed_port_cov_cb_exec(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_tlm_generic_payload_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_tlm_generic_payload_observed_port_put_cb_exec(uvm_tlm_generic_payload xact,
                                                                        ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>tlm_generic_payload_observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task tlm_generic_payload_observed_port_cov_cb_exec(uvm_tlm_generic_payload xact);

`endif

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
  extern virtual task transaction_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task transaction_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task beat_ended_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_master_transaction xact);

  /** Method to set common */
  extern virtual function void set_common(svt_ahb_master_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();


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

//vcs_lic_vip_protect
  `protected
EGfcD=HFJ2F\Y743dgXe_d54VQB]];K95AD]74NIA\YN#JL#cV>,0(&7)^&gGZe3
+b<8+-@Dcdb-TTT9G&)La9_;6#[/[(aB-H:W;UY><KNW2P5LL<?PO=--:YJ1dCb7
eB;,f>/X)]KJHCaV.TB&S@,S:12c9&C,JTV+G?O=_fW&0+O)We2G;#b1:/+/27RW
dU3]L^G_3J/:;g0XY8HH>FaO]PVf&76HG(AIJNYYA/.[@c&[PE>N?CHW#?5QC:T;
(c+f)<K8E4Z(PQ<LfDcFPHfW+K>eI6H1Bdd<EFG.-bV[F$
`endprotected


endclass

`protected
\cgAXX-:ge6L+bE2RB9@Q#?6O]5gH#_&</U+^-F(T9][Mef+Y6Xg3)45YUOF/-F\
R6156GS#YJ9,)RH6X7d?e[PFBG;T1E4(<H;X&_YPcQ9Y&17X>L8,8@S43^-?JF?C
^gEJIR)B0/_O=QB7;;SGM+)ZT1aC.eJ\W,Q+Y<Q,E2dV6=J3_W,b=2gdJRKcHM,N
V[<.\(&[F?@#+3AAOecBcaMS\Q=,K2DR2^Yb:-RdW2.5D\EF=O<E@.,:2S+3X4E<
1fAC8?O>eBBD(&e6WLP=:VYRgXG&)SY\,C(AfQc.KN[ZU^QPfHQ=B^Xf(V\_EOD;
fA;E8R8F^LXA),DOfQfUMCLgSIK8b=B&=[aKJeI+BP?CB>gO>U<M<YIW-L@Kb&-P
K&G2cSg,@0ZfG64U(?.AL(.V\Z)^+1g]DS3J==EcZ4\@X[TH@JePU9&64WNTJ[T/
U?IMb9Zd32QH2>HeF8PA:7GYHOX7aV&?6@dY^Q=^VA]B=,2O(@N/e_&6M$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
+LI>aQB2Q)JMg>>+e=OG9dFV/CD)]3f5W@S[G]W8>RJYb2ZWAB;&((c?Y18e&P4C
2TAT,0R#gPcBB8E5#T\:U>FEDH\JbQ_GVA7:S;7bVfD@AfdE3bId]bUgc,;MeJZ)
MM]dcYH,PNN9Cf&>STTEU;afJ[g,QeJ,2#B6)>/&PP(YS@(0F[^:?KS-+59O76ZM
3)Q]WD#0g]?P@T+PF#)L+938[@-dd+L7/@eeL6QS7HLY/H,W1f#bVR1bg,]<4)Cc
Y9VG=bA1Td_UZ#)b[Qg<C1_W<7_M()AaYZ[bf=+T.VG^8J1R\\])bA0BVO39/gA4
IQ6&E/&LY>9B+-]dA[,X[-4+&JI).0fM\-&&U4>Z/WRX@+^87[WLVDV1)Vd8N_-.
V)#1IaLe[?>cFIYGAC#4<a8&6[<,g[>-R2I=U2]S&C;c,VI0/@>L>ccMU#RV;]KK
bC^OPQH5W++9H^98F&a0cg4]VD8?,51:??6?_GM^TH#T3=-0fKZ0#.#YFSIcUWR>
@Ac8U]FA4H8SCD/^9W;,+J(-;MB3b,=6_RaSGf55HZ_<8FR_P][>R4e2,f([UgY1
J^>,SD[bPXRN)-9@30@ZA,gdG58AD4^eg)54#c<e1g4CW5RU7@IbRNRT7e6F6RR5
)3Vf^U>[;XO^ZVCK8OUX#3A>WJ_b29=4eZeDU502VS,d[XMAGL=#LSN#WIOT5c;b
T]A_Fe?]UK\ZJ?0=9f-L#GY:>Q1NBeLY7f<\I^>61X\]_>1f+7A3)bcJ@^=.V.\-
I;R?99O8EMg^a)E(HR0TIIRG)6PXT=2_>[aBYSMAC+(>a>=\^S&E90BVP_P^I65K
LSA3M?X1eH1976f6Bd(<]0Bcb;54O<MRdYA@X/bOc1#4>>O4^>5@NFX#P\RL1G=b
GeR]AK(M0@TWM=BP__2?(.VXL3[0=CB2EaY3TdEHe6US(I:]ELJ51.B+0,AKg:&W
#_?^X_DB.P5N6a56/W,N#+UaWf,Q)1PR5a4bFMBVR#=6:2D/26N9_X#8aeQ^?c2g
TI,:0&K58UQ@g17[I--fM<1VU/,3QMfdM9VN]YN)Ia6?)OMT2B@UO;4A5,19G03c
9f&J6X3T#&]ZS#RPC(X>D=HT]X,S2/O=J_Ud08+Z>#(3INFY3>-Q:?gW#1ECV2.(
?e\UTE4JH7a9V,<&ZOF^_OD500158W,Q&5;0ZGZ>R9dKM64U4W+Z-3C;3O23K1VF
26Pg2I];SHS2H\Ye^W4fa@:0DNK>4E650#J21(KA+5KO&\fQ@L]Af-cKe/M6bLP#
1_Kb-^GPH?DcVIS=fgO]ZD06PYWZ9N8D9Y;AKaYL+\OEVCHQOg)I)[CZ3:-EN8bC
a=7?dUX(6-/<7\Q.EF#WFD-40GU+DQS87BgDZQ45QS#ZA:C\aK.Y<O6-)@Y(?XLQ
#2C-f\e4ZMXH(0[^g(8J&VP^gFEQ:E0KK^L3bOY[YKO6dJcT5\69d.eFKNa6IU3_
B?3,0?Fa(NDROd/.]RQT5aWaJ;X#@D<BcO3J.T7?I<5>8>gU5)1>E5Ob(aMZ6O>G
-9AC13^K2P=KXUU=E/)D]]g4B,NH&-&1^O#(KT[RHeB=[c.+,.3J>29Wga.86dF+
B81EI[IMX<0KV:F_(H9<C6GV>512#+A1aDeS2b_BS_.+D,F@=T7MGVd2=XO?eET.
YMHdT,D[R8Y,SBYB@>@HW(KgG\/+3f]L10\.NaL+,b-FV?acRQ1fC^V,dT>W=g)-
/&/&5e1>F#_g(]KcLZ3Ba#CObEHNc/?6UBRQ8+f\?[A0+GZN^@+PW0GfTN5<72=C
?1KBG:]EAIL=FECY\)BGaG4<84e&>L6-F5I])^c,fGOXC>(]HRC/3#f?TQ5Jc^7Q
aB&X@F?^4YO(#=-FVYPC\dKHM#7UcH(:F4CX]-CI-\Q(]a;?12AJR:6H0[77H<PC
bFRB?cY1b[\d&11]JT2e(.;]:e4>7<<&5,8W-^;Kd_+J7K-=Rf9JdA:EIGJYSX3U
D1NM6C-4]48YI,0T.<DXU7+&DdM?.D_.a^80;@R/YSZ>?#@8P7M^?Ta17f2:[eYO
Oc4/.WAPJ6Z,-VQMRZ^0,ZS-7?V<e2)QQVQJTZOA12R#L5@S#(-L\d@,dJ[/#>9Z
BR]TbM6;2)I5\[87KNVH@-.Q\eC6Q4XSJ26)A,V@\(;>U.-6?]1.7/Q)OP>.[93(
eMe67_KCaS]HQ@6D=\a<(T.,HO2KXOR\Z0^2@NY>]FSg-05I=UY/)=C;bK9LU-M=
1AZ9<b8B\e/=-65^5,/4AR->)BfUT?SZQ1=#E,M?AU]gQ3EJV<9/A8D&aIEKDWVL
YI8N;bKMG:2e>=XVP^L@M:&dG[4\HK8V)W?^A,ZSFLgN)6LZ&FQ2R_,;;U<@HdD5
f4aGd6)3@JfS/gCb1f>1)<,B8KW36adH<X0=MdL]=:^=5>5\M_2YZ>#+I>[<1_af
()@g@/VWS:KRJ&cZ+WC7=1(SP_D:e4d#BA9M?6(15@6>:>]b5EPP.;OU0HS(O9W?
3TGSJ><+VD?3_>7:IOLYXce[4DKL\VG3U0M?OabJ3=L5GG@MR<_,YagB]bXb\eBc
2XM3I,DN,K)Q]-RE\/A^_O9HIJ]A5S/HTAUHWdD&B[ZcN(FD6+ad4Ie^,S.J/?YH
Z;+S1<+_Vc@/d=1]YGODWEUNEUVM8G6V>A4Vf]3(>,QD6YTLCOPI7ASFOZ2U0>J0
UV.?g;0>;Cc3f99QU+4LPGbK(e-U=<Sb.9?M238K]I=I\GG<>4W)J&0R_N8K2=R_
?QG7C^[Re9Y16R\LbE6HCE/?.b-+XgRKSM80;WX.((c031P0JLcP^6?Zffa;b-K7
<EAeT854G)MJ=DOIf8Q?=BLg;R(&71/b^EHPWT.\ZA2F#+_A:45_J\JS.d3Y1?0e
1..09ga+X>.a9OYf(V,?=fKL/T^baV<d6@._.-gMe35L/G+gRRf;S3SYF,3SAWf/
,;[.U:P2N@_+)/2e&_L9CTXOFN71,F2S<W;RaG32[8g9XSA6cGWJ0[IN[6@(_\)2
ZI-BB<,]FU,CR_?;Y=0EP1>ZcTW]T.bHc8+NUV(3:664<K#O\=>,65^QF8)PW0g:
0:L(3#MF^U4CaFP=#;PI+D(YIF[-&WLZ@CNfB):)#PT?V_K3[U^JH<_3/[)9ILV=
&1[_8J)Fa3b?Y_Lc<#aACF:WY/9PUcMK4E4_gNa&_N;?ZG)^8^KPH[0DLbT0g^b?
g.Je3+OLCZ&W=WF:.Jf&Wb9[;6:=\F\4O_HK5Q)/&,g:#)6@B=P4g=gS1(/VE>7@
MD?A/&+RFFXeZY8R<>KWd7dbbQ&d6A&2W/:07/_8gdKQ/KAWg>WYg2e;ZE>RCP3J
7#=6L]IAAfNU3;6[YX/:C&+)CBAfd;I/^KG.SJ0H1QDeP(7\+Q4d@c@J2HG=)N>[
+LS[?+[18JDPF;a:MSZFSaRM@<<d-3)>&AL/GcSTR;?\1P99B>./B[UBL+M5[O+?
.f,g0f.33DUX)@4:+E8b@^)GeO_@GW@8S9FP.-TJd>WUK7RTB>GRLEK16=Rf)J9O
;=]&fC2JQD/[](W5<0-26GMg25Y8,D0fd/?ZYI6>+;XC5I]e-F4D4I55KZ+#f,Vf
1YQ:f<-TcNIdS9E\\6fKB>.IKE-cO]PKGQ8&SIP)_?ZG]6;5(+=V8(H#N<R&6;1=
D,7L6/#H4d?=@aY?ZC\fa(A1=C0PV\&KP;,^6fEFQE-cPfX,]SNHG\@0#L/9D:gK
M_=2+B\SJ0+K8<_f?>7+GA_L]Da5V6;8bIdH-7,CJ0?#=M.7)@[=/;4]-g1;EXHR
U9AC^OYBaY29E\e_E7bLI;3S5TAC#^4#R+_57->&,YS,XfBG)#W@\FaPbeBTdd\0
?P5GMEYC4Q5NPGWFY^E4?Y)^W6C&WFJ_+^(Y.,M95??R.KT[A_VB20d:;6-VEafF
&++N_4-ZNBPFTE..\A>O_MTRCF<SU1aS;Hc/MTVAc#)7P1FMe9#^<OSRE#0<;:eg
GJ&=/1cRA+2ZO=F3ZSN(O62H#?G)P#3)E=edRX/H;9Z(F8ODRIQ4a#N\@A6=4AB5
D>>cY8:6OHGP=7PVN</MgEEc]+U6\^QK\IO3;D9./]DT0dEDOE,:KN#(Y;:H5J^P
g/53@XEL/J65&<GQ<XDG3N&aZ.MXH_(PT-@R+(&d#890X+2)A=(],+LI9N4-N:83
+a>^P[b.@bW&5=?.,&^R<Wc1bW5d^<SWEX]9SLd13NZ6LB_A3LObUB,.T&e.\S?#
?J^/66/7@G505K==OIa8#B93cE+XC<3J0E#/P@XfVa8;-?A49eQU]Z#]+.dY0R5>
Qc#:35&&54YR<?(RbHW3VdbKVIdM(:(+UNcB@H6N(487A1X@bQE2\V=:MY?<>;A[
+=-X\L4b[Z-2UHNNd/e3,5a#M72cF_K_Ra\231f#_91Jd6G<(Id1aDR2B6Yf1Y4?
5FGfZN)=GQZ<We#UY-C1BHfRF5Q>[>G)X42TZE&f#VP.JIGZN6000.2HeM>9L]L[
f0:(IF#B[<K1B7Q[J3H(8;=PFE7LScC-.#23?7IQd7Ud__9M6GR>UUE(N3X[4Q>I
>8OXGY&N\,>L\&S6D63a&SN4_V^^f\1(]T7VMZ0KLCXXFA2@UO:KO9)I_-9D.6KI
g.@AHX(<9QE58KW==-QU,S8d#W^S-f1^,T.96TDHA-)f#=K#-\+DX(PJ1Y6WMO;W
cE&)WTgW#ZU0\\HRDff<dL(^M9_O<M(1eI?])W.(-&O=/^+9b[Cb7S^6]PYBPP3-
&bf:aVg;(.dW?<fS7AR80.]C3HU;JY:#G/@+6#O>P4=<VWR_#NdZ.5J?)LB>5=[X
(d)10N<>P>&]5/,dcMI^Z4&V33S]2+/]-?_=1F@g,R8I<():Vg7PCQM\1A-0S[S(
Z^&LI5VE=_?T6<OFQE[@(5TC\B9\CM[O3^V\O6,3Y/36O>cc4LY1,cDHN]\=-b>D
XOKP-H<R.a+eMOVY[Z3gEB/RHcJP:BXfbDb0P=<-DKMSBCQE_T71Z6:[GggLCKd<
&8)MV-&MF19ES-L70f-eU]4/1,(A-@^-,9DZYDH1_\67:4b[Nbd[IIIf^5#>OaW8
aa\0>GR6HJ+7T2fRe9__:I=fCaaCf;VJ1=gJP6B7IBMI,HJ<]/KNA0]L9db>EZ=[
Na9W)^LSV^Dfe&>4J#eA])@&/^e?2eg&^0NF6b8LR0L\ZC;X6:gbbLKTU6ALL,,\
=cJ/[GKVFB5dKO#1:WXDY>U(0#3Da_QCF_K92^O,ZUgG9.e1S0WZLVAHJ4;FJ-c4
a9XeZg-#Qf;a+cT<ZKN5R=2;.\d).gM.-\NbcEb^[F>fc.3CO/TFC5+_ES5&F(@S
.-]JZ_.-;aYcSSfbg.ZY27/32?7_@.?-FgOaL3JX<_NJW@O8N#4U:#e)_[B0QX12
-dH?Hg)g::B+).-Xg?=F_->@TX^._,M+(b40@6M]AV-YabO_PP,4-G9AJaf4K9b4
R3b,4UW_KMU=,(4)K](6W-MQ#:+X]^?G,E#L/3^Kd]^KX:L_:85ad=IBI#eZLa7H
[A83d[QDLg4g.QOADW+E7FWAGOWDS^DR[8dF40aJG\:-f/MUNMeH[M-<)/,8I4CE
)[NWeYYL0(IaQ^Dg_<FP-Y)G0\.2MdT9fBE<1V5V(K&#)Y4g@-Q50ZeBD##\dcK,
313>bV1@d-]WgZQIGO@PRX.Zb8X<D8bNFXU1:bX51Ac6gE9039X(_PSK0bSUg&+=
V;g0^MOJ9:6O19.Q8-KFI]5H9cJb+<AJ26\P4/GLEO,NbXbD+_7R^fSPDbOBNH&3
KEg8KK^L+_,IgT7^Abd&-cSS:0Ab+SWU)1W+<CX6<UOAcb^&9Q:46dUG7DR1I?-e
Pg#Q?JaeAI5A&FSF@<1CSfHWY4FW:MAGAd^/_gIGP[A92=8IAO9&Zc@P],](<SL3
@AR-6KVNE>MX9acU8Q/f[L5.E6FYBO[AFGRY_X6g/UeKT]ZPPCF>J0TJ#01S1eK/
N?Tc@(6((Pd05>^Za^_G)G+2,-MW,J-.)&A3b)[8@0U]fgZcf5dT)D4ae)B,8<e=
;V0GX,(gC@RP&M3^M:OE,FA<;&N;Q>1[4+FMA11UFe\+)ae_QOMLM?-7ZOB>G[H5
HAgGNF8^ea_&&\4b/H[=;aXVWGT2J/aU2a)WA,+.RU\[ad1RE(4XNc&IJO6Z19]L
KgY00IfKGd&>:X-,)0UNc2HI^=+9-\f2f\fT.,CFZbGOVOCId3/FH(K[Rg.)2R5/
WD93R1J]bg;_X29U]7SQMOSB@f:AIF@]5,0FQGdeE3H0?MU\MQL6LH>@BWIC?8Z@
ec1K/AgOP9#)ES8JEH&D#f-53\[JN5=,2H]ZX0YUD1;2-9&._gX2#R#?3Eb<ZG>J
BA1Ag+3EW4K<;CGc\;)L_R(DJe[6TCVA4[0#H:&=)>;3[KP#T>@)cHb+?CRaX7Ug
830J5<7MV[)TK@3)AB22_A>[)Fa96:8X=T=LR<7&g3J[Tb6ScC18UgD0F/48Vg9O
H#/<I^+Y]>2750W^4,-7S&-/2&EX=M4I/G\R;7OLHef@F-8]=XfA0c1<T2cNYJ3+
H(H?9TD10LfOB9AQWECcV:_Pc<;1JOVY-H[Xa@AEMbT)-O_Y=QK=9gU/6Y#P\d1M
=MGf.UHELd.<EKTLM]M(2]2R72M?;?-7]4\E-CQ:>TXPDD:d[9VJ207?SH[_[IVV
4T)QL?e\&>OS=4T,&;>+60L+)\V1Fe^;S;2ReSJ9aWYMY=DE2.FM,5U]YVXBHG7M
>@?=6K@T+4MdUUd]aOaK#-=&8.abU:SH(([^+S6Z)d&TAfGM^RG\YX@E?2H[44\T
W2X?bBP[ZS;_P;Q2:KC?U#341B,\UF>g._XECN^0a]S08^M2^56,43gY)[U1(gBC
=&(KGg+TS85K(Qe@RT>ZB#?N,<_;J]2/23W1fWgO=_)8Y)B4#/Oe54e7&EBX,_?_
]/#bT6BG[WG>;TWbA6JC].QNe07+SR:;N:N]K_+1/NS9<SC0LD[0d8<G^AS?&Gc.
_AN=M;C;)<LTHMPIQ21bV1?/d/T4T^E2.aZ8)\AF+,WagNK7IT1#2eJ(4,3()3g+
@IM.J=aNIJYe)]@b:8];^IEa@KFZP9d+JUbADMI]D+ZLafAK1^X-TP@Rb?:9424\
1T3+]X^/3<7KcS0T>IZ[MI1H8M3e,aY/-.BV^K>,QDN+AN+)X#IAW;f)d#J@L=<1
LT,B)5A.B(.JZ=?O4<U\\.>K)^\9BD##GQBPS;AI9YMfd,8XC6^;DRf@E2ER7WHP
F=f?@]e)SW^MOGQ4[)\A6Gdf6ET@AIac:2=[]&T_bOL>d&Od<[NAC8S1=X6,I2;H
LA)R3f.C,T5-fD4R_Y\[)=eH0d+#gZ@4gDbaKYB\KaIX3+^/D<_W<LBV:UFY/B8J
,R@6d0+]V3\@WVUAD=J8#a,YBKQ^;J0c9Q=d4W(H1fcL;3gPS4d5(4SFP7_2e)&X
5X\UKD<S//XRX_)>(Q8>Q/.+;2^Zf,K7^(c;OI>I/(@T1gV9Ge2?0=cL6GSI_fO2
FI[X[@,LUM)Ja]?c)LB>;;\<;_Xfc3V7d.f+M+,&TM=\;45)M\MBJO3VW]\B<MHN
#YAANg#KWRA/4-012&_J8I>Cd>5.G7eJ-50CU@eD#2b1)J@BY+B#GFZEe7#90La.
2UcDN,-/R+?/aU]J-ERSM2>81J38HgV>U?6+bM^FL=:]<6D;K,B?2G)6Vg&BIVS?
@gV)c<-I2WGC_X?M1JEB69eQG&#[AL\Pc[+7eXPe[dM^7<.HAfUHDKb;3XOT@]Qb
?8P8F)U4fS<N9/&+T9R7TJCbT/b][->GWM=BI9NFaO_/V0GHM/#?aNec9)7bM8?)
RBO9bTdO?X#H=ORBC=b0I:2YX:6#.A+R4W^O@)BRNNf?&/^-42gBR/_Y\<S?e[Ba
X.aY8UHHP]&X+32?FUPDe+OK&N9ES&=.M&#W[Qa@J6HP<UI7(-:U)D,D+TQY&J0I
=KDFF_JKP2)[NaCBW^RGKONJc@J/;b6ATFA+5]-U\WeVOd_9d32FM>8&:g+]^GM0
=NX,<?-M<8Ab?2/7e[[G#^gF5]=U5/(SMN?,JN4&#I5+21_)3GU9,,g/fK7]D:>B
fS>e)YB#EUg5)=<MX0,V&Dd^72^5LY_gRA&OGS\^9<MN/D(dMZ[U23+<b_E<eb9A
T[RISdM(-#W#g2H+YY&,_&^GZ=96d?6)SXC]PACMC[3VaL@S8IG1E?\Fd[b4]1@U
0RD15:2XH)1TGe]e2:K3HXX]PM70<[OC&K)BETa]9M)A@5U_-:+MKV@gY0McIG:I
WM&=@4-XS@L7WDOYAg+GBNgE=IdFPcQ<@QWAR+4aA9ePV^2,@9GBfF,c/S#RFF]V
2X)Zd>&Q6DCKA.RF=HD_d64PSZ,7/]5F>7GL4DPWNHN(2a2:.[Pb&P5[477@@.R-
=,\2JScC,D95^L28--:+:-^RCAJ,;+>?Q#M-Af0+_SRb3T\)FFABM:5UXIeAYD95
Z_f40KZc:W(@N^AZEe85fDb0[FbcGbf)gDCQ[3eY1&NK@.2:g2,+egaNcI:8GMM>
9&&<I@(9(<&\,WYXIGT6?]aL/E9\GJ]B]8>\W0U(\23\\Y\45-([89G3ED?MKR5)
ZT3TA>f-5@(D89<PO21cdNY(cOD5ffbKdIOTEDgJ#J=PMR5S\X.)1STCRWCS4cKC
2b(efXKO5-D<KN6Ae=UAPJRS44>_RKJ9K9:NT5R+_J2PM3aIT4(-WRcQYRL;P[b?
L[SJVG^8-cK8=-&b-[#7>DN=2[:5P[:T.GTg+ZZ\W,L[T]2[UfNM1\7e)F?B&AO+
Cg/R9J=FKRVRddBQX)]-^gegU^QOe>?4&+5C6f9D;-I,bb>L:&f,+cFCLa&gGE3O
.RJ+94E5&#7Oe[9DU_#S@;NFCK[=;/@^@>L3DRM@>JZ)>(c.H]ZMF+45bI<@]DMB
MP:L(^dGeO(5J\B&VR?#HX9f#aOHK1K:/f>+CY.19DH4eaYC;gCLeB@]IUR5]+3]
>OK;QOS,WD5-M77Td;c,<X,9FK?8S&9KLJ<I4LK1]AR69\O/&[K?J)Q,AJ2W,13B
?BC>H>J;/[1(7IXbK.)]NXT(:__eQ04MMF?@_d6g-&@LJ4CAP:X=7VO>#&GR4=eT
>IIO@IHA4fO]S;f=,GgVA.]DGV.+#5d;a4VdY+7Z\,6)[C=K3>P8]^D_=#S/aS_?
F\IfU#23WC63=b9B05CHA)+K83/IJ0KId3(>3;SW3#_>VU,AeO)14VU.>IaQ;f[:
PJTZ;]1+J+)Ac-NGfd\MAc_SdFXf\VgIQ@ZIE1/ISSC>SL]2O_&+X<W]\?=Ma(IZ
Pf_8+/KLF)a-f=O1E#F..92BY0WH?A;3Id+Xf&g3H,_XC2BVR8@-2g-_HA\5f;c;
O@SI,MQ<]:16M/#M^/g,<L^OD@I,^B4#C/?YA(9Xc-KgcG1&/SZTeK@0=Zg\XdY5
WT)H<\BZ4S6_2a&G__))UMFPag]X@B>5\/(,F88Y>2HNQL3QeTMORCE&L&aTQ3[9
98UeKK-Q5G)1HACTF&#HJ1Wa5(KHZ:)JOO(0Jb75.1,9163[)JI9bZUI+LT_8HAS
2HC??[YCRTSQM96<62GG9P6@XeXV1aPbMfK)UO;KcPYF;fH\fO;<=8cCL,DScHCT
M[b7X]_5NTI=06;\<WY(>)8BbY\BVRbLSDZ>9,g#UMQ?4C2;#FbYZO&[,Y:,9f0B
G?5PL0?X&H6b^0^^cE^Mg.C&#0]][LEOU@PdI3U]:Q@A#3aee.eRfg\C)e9Ug[Ed
24^Lg9LIKac.J,@I(W()#deBP75I7^2#JCLcA.V9\T1M7@B,c9(,d^+Rb&gbC5AD
C\&[bf>RGUDDC_7FQ9NSPd)Ga&8e^26WS[J8NOca:MeRP]UQ=HV5(5?ReJ?6;V.4
IO)bTIV(#TK:QZ^U36<F[-UTadG?cSV[f00&b:A+US(8LeKD:8:f/R7/<-T)]5Y5
1#908X[DP(=?9.<:-\Q6B:CgDedS\)ZGIT+U:3C.</GN1c134E),3?/20B27<K7\
,4Y75#[M<agP(;42=&J>E5WW_KS>a1-)A4M#?=fI8/Q&0YUA2-:Zf9b)+?V[/JVE
\-.<Wb4B).C+QdEcV80]9>#Y9\KLXV6XY8cAY8CD_2M)NC2DPU0?;#5ML-5>]cEI
<@DKVFE@YE^I]E8Z;S;,+SI<=>F:N5Qg1\<HCgY7KZF,T]QM:g9QC4(dG@9VH@TR
<?U3K7IGV[D;NWb:K.BH<CWeY(>PU@ZWAG5;,TXZMeNN-P(gDY?5ZR7978ZFV1SE
C6X7Eg./eHc(=U0DV8VV3:12=T04A7M4@D>UJ&:>8CN^1PC7a:D>7JF/3g@Q(<B0
=[c+GAMaCE.#9ETB9S]FO/:<^-3C^/86SZOJNA\YL_]eJBRKHd#]+ff-b]\9Z5cD
)]8>BBf;CgC,2WgH[R2+E,-\4U+:;6DQ2ML6OHU@FSce1Y2[I)6c&\:4\U,Fb<,G
g45aEDZH=;E03]e.C)dQI?a?<DET4c5G(5F>;M#g+^)4eZS:ZGTB:523,5MUTZ)#
>>2Yg<gP2<+JGWBNKK)cRb4Q&Y);O,(HS=+M&O.(Me>_V0eGcbgPIF,F[7<Ka1IA
9)>+:JP-,SAEIU6-a-:9;+>0aUeJF35B9BOe<MZK8)(9C@N1YTbVBHP^=A[A<[XI
<9-gKePS(:,7D?W,:g.TY=VI^[HZ64JdV&51&c0BH#gID_aX46JYNO<BLe[L]DIJ
R^W>/HdbA2Odb;[/C_VcdJQD5](dCK1-g,VOb=KY;Ua=VWSYH_d.AU?O:F,AMF(6
G951VW>\:B:IY(,_+.^4c\EYVWNg,/+ON8X9/[)VgcGda&;0;D6/:4]:2)U9_ZM+
DCSc97_U\g)&TN1MV\1&^g-_@[Q=N[[J)?+Y;UM/44E=8Q_IQBcag0,4O8AZL1Q-
1<>[=7V3J?RCOb2ZML>1,RK^V1R0__4d&AMcc,.I6a,^E#SK(9d:3V&#W9XRJ99(
C#7]<?H08b@DKXWd]QJHYHA4&#E(QZ\YGHNFNX1CB>P.g9,VD;#YDgfFBQ2H[RRZ
J+L#&DaYQ).-Q7c4P.#EQa:#/C#KW/ed3/UB4D1?4(7->0OEKF6A\5Tc]eU7-P@&
UX)JAU4b37IfP6F(\7XcJ=/d^/M)b(_3ZOOP(6VC;D3ABIPbcQN>(=,bb5gXf:gE
&0]W543H#HGLT:KL7=5?8(JZ=?O<@)A3?WJUE-g1+J[_7[)KXf+KP[(-8#c1cA4Y
6?NY^_0-Z>>]C_N<4?dH&70=0KMGcOY;@\@.Y.UA;&Ve_AMBY7R<eUPF=a-RaF[+
daO]EO/c>L3MJQU6S.>@6VG<7DU\1(J;/A[>B4MQP#2&D#_OCGf0e#]]X)#>W>T[
C+MYI79dA>Re=Y-LI_Z_T&^1D>,1_@RQMM3e9,+<>PgM68cR=6Mab.Q>S9VJ]R#Q
U-H&H1S#JRa/]MLa2+8,YTELd>,E+a/6ELP;B,P632365EA<-/5T7CID8d6Y>DF4
K:Q8S>N99^AJFGEK<^bXZ+eZb+a.(B/=a.1)HNf<)>R3d\AG)F9O8F6,IISVHZ[6
297PW(SeUTObB^?a8XBe2C#E7,f4.<Z_eUc,La3g-YeBU]00=>;KCH_5KRX0=_QW
3FIZ)a=/=1c.<43_X/G1K;(YNO8g_eU4eQQ0U?[8P(),A;H@(5MSL_cVXY^N-_aX
cH6E5PY#?I^=dCLFO?:eL1a.?[9JL^M=7?b[P4RE_Q:_Z4)eRQBU:Aa.U&@YR5eN
YN1P-=71.8D=B<RXSBJVAO&[IKX9<Df7)5aBFR;F.a+7L/3HQ+:A1DGaCQ5WS(1N
]12dcOdfUeSQ1+Q;G4LRR+daGU.7RWER:&:bCSM]C[@IgZWT5:Y@+)aS/_RUI-D3
F:_#ebD?SbCU[cba45fMee[Z1FcQJUG(D=;P15Z>\13Ng2Q/LeUDM^#f(9>U0R9A
gJ>88+6@g]S)WdJOa+=gHfD3J5NC;5;Z+60,TMDSML=G[Q60]MM5;F=(5L#/AVgA
Z[_PFKZC<8;IA,ab>)>2]#K-XN6Q&TQ\[GaQR8-PF@eL>+WH8deF419Q[DKT,G;\
8[XZYA=O+Ob5KQUO^Bf@I<^FZK3H#HG:N<A<PZ(1:(V3GMdd6P.S\=[7PbZ^WC,b
.O]>-Y9R8G:#F5a#^7JB88,=V8_aE)RYNTK+-K)C6F)JNa<.RJ]Q?c;dBg()fIC<
+dOUHP1YD<[0W(AKcMYQVYB/X[C^/cK40a\TH8-5FIaV>/bRZ5#Z>-#a08L45ZfX
ENPI^G9TQ(V3^fEgH\;E+aUT=ZK8-:WV4O^VVV?YHL4gHX=C=\=E3IF2GT_dbA#?
fe+N1ZLPP,GN=;Z&:T1V]UYDV<?JEa[/>Y.DZMTVL;V@//c+,&(EX^5c3=#W.T)6
B6V=;0gaNP?9DHUIe@X4aU(&NG\]Ne_=QC1W4<<B./9&28.I_<AAGGM+;.<0,3TM
aLN_Q199/bM<L1Z3^eST1+Q,OS.2.JV9)=.g+dS+0+NSA-RID(6D)05_Hbd[e:Z2
15eWdNW(VVFBVHB=\&-<;MaQFG1_Qb-?KZHA;D]0E.#UC1EFb>SXRLeRK4=&96V0
;(&L..]ND<-#I?))>[TM7Hg^QW[09f+L@_2<U6GBU\-^^+,-VM5EafA_e@)W&TV@
[/TSQ^I:c4e:?eX6e2QT)NNdGU,[V,NeO;9\7^K5+2E<OPE.X6C-Mf(/]H:0d9b1
9,c9@ZV[Od^CQ1(Q6^RaA(2UT1b5@[GQA62-/SP(203^Q_LQ1E>XMV4F_c[ZH=eZ
a/Z[H+](g3QWaa@0c6(49EB^3/4@aA1#]&HT&>RSKD70WZQeBU^4R>PPX<)(/+J]
-Y8Ggb=T\aQW(E)^d\UD\VNO0#c8UZOdQM+#/&;UGZ^_f2B\H,P_YaXV>ZDP4_U2
a7>P<4A/O[NPJXDf9eM0C-PV&R7S_C4X@?P>]_0/[#9AL@7dX0a2L6CeD-B<UWRQ
?3HX=<L@]KUeKNHBBMSDAbZ2&EFMZ[6&fI[4_T4:TbS&3E<)@Jd9XB2M\]0=<#a2
_CEMG+/^#.RM3R2JB&P9-6_g]/WM\L9E?@T&e#R@g;E#0W?cfXV#F]_@=.@)]-I:
g#PAeMggG,+=M5_9d]I@.#>AA0c\bg/db9.b0V.<+V225JMLaZC[_g?/:SMQ?[LZ
A7(L9JZ>_<8K.N(d(-[C\@QA6(MFS<BD+H8/[G07G&EZO&^C#G-L-(:\[J=LO=_1
OaaAeTWBW85<[b/>78&Y<V=PbfQ[T8N\&S;ffd5BB<5,Z-KV^8/;?[E#_08GYEL0
42].fX(^&dAdMd+,/77T]I,K0CUQT0CgF)Oa(-GKd2T:,8IA8@@O&Gf]837#8@:Z
\AaLA\(EdM\D)D<^TIMF5_?,CRNE0VI244RFUSdb6fXT]#^b9;Lg\E>S3]WbC089
>CTfa,:V<-\QbaDfJW/[UU1E0G>@6FSL<G^[GA76&d6E9VNM,Mb3E5dG(_/Afa(>
GV7HMUdcZX..2Y@#[WOf1BUN4N\8Se3Z,V7?FU6J\)Y.5eV?bZVN],GE8I._27@6
AP=g8-6[b0.F[gH6WQ0:b,K5?0WB&ET;A8VbPA?G_IGaKVBC@S,F;0@KDPMO&S7T
a5:JQEfGRFEQXA5)DUFZJ1EK91.>aX9D:B.9Y9;M0LDbUA_QZES9)f)KQ:7X_#=@
fMcL->;7)CK)ZWZH#3c6M3&<ZLJVLW;gMCX9O^<bF(7NI>d[EG01OBf&0A&Kec-L
HV>T\RZJ,5M1RE1ffgVfR[FXT9F7UW300IE:c?Q+M4,&TGTG3N/,CA:R\OV-#R(M
DMTTg#QLG5&#O7/IYUcfbBKga525(b?UA#QX>7@c.dN)-VS9WO0e-#5C[O(Bb076
,\N:J(<6cJ9&WJYQ8F;S>/dHG=7gdG6e^g1b(A@]G?8GQ)SAE.5VX\219b^=TeIK
I,=;@L28)#Q=E49?45K7VUg/./:Oe=IJdRc#<Q1&XgYbQBJ0.&8G<O=#GJ#6+;>-
1)WOeeSNC2ZR^Q5X6&C-_KF09VbgH6+VaT+a8#[D^]6:P,_2B)0RYBcF5Dg3)fgT
6R+>\<XbgT(@&+=XMBf+R5JC^K66393&S,7G,);HMcg_9&)c?XL_KSPQf<=DZ0=M
YdWP#^^,HWBEIIAAY1HC[[\b6&IF.6#SR^8,+T@/B=/]@>@c>,4e_7CPaC79]Ee)
3Y4+45cFC#:8S^21)W@?3g)d3V?#8IZD-]QHIS3CVFIfX)U_&/XOb,U_MgDPb^1&
e3K32JLCH-XB0R\dN9XAR2BEB_9<W20ggX7I^.;5_037?H6c?UI1W?bd)g(LAYW+
A,4]SEP]e6>NHU3;QW-EHO8I_aE6N(0C_,N/f12=SLYLR&YAG+/H1Z3RE/L2GaWe
dFLGSJ96[C.^.eQGAU#f)#+aVf_U5Q&Ob)DQ6#J5)F&@IgE;>c;3PY]2X/:5I[BL
IM4_8=F5Q4=@-[f54ML+eY>]>-b]g-PA&RE]5,GbB5+37=BS&]L^X:G(B9YZcBRH
HC8TI)&AQ=GS&;S(-e>VdF[d<E/B7-J^c7]R[I&g4HK2P#5<7S2>Q#0XYR2D:UeE
ZLY[dXWcg3U:g-fHeJa2d\Vd0HLV8F/9YB8C)@Ga&cY2N08_\8U:]13H\\BR6UK[
_a>I]ZEc6B,)()6/^6_YCFW4_QTL05IIF6#R/)G=1JN.XN-0@bDdEPZ>MdeE&I4)
POP6Ibf=9.OdZUa.@d?XI-13+g6ff28B&7T8WGC>V=9WP>67Cg6AIX+QPVeHa&IK
JJLXgAG?4+Y9;JAZ8>&O&57O@G)fGTd_,)H0#T)R[2P<ZOXW9;)7@))Q[K;2>_>V
U<Bc.#P)<K9Z>1dfbPE+OJ^@VgB4[;2EWBS6aIX^#g/K-a;IGG?0.g4IMg^g5agL
)6T-?E<LZ[g8c<bNbd,^d=F)ONJRdf1P_WZ#U0K)MBLf\VbdK.VdFS<2:P3f<C17
^UeY97WLZ.@E;?+_\(>BUfNW\c]+O[1f)-QZ:>)-2If^MPM1?JW<edH&aFd3e00e
N#9=KFAPf(4,Db(\dP=14?V0+Z^bMX@SFa2fg@V4>06#SYaJIR@X:J\GPUBA7RbO
aQFD1#>EUK8gW0.?S:BEO&),YSZEKa4]W+dON2M00@E,f19Q6-;g<PQV)WLT;RWB
.,EV:@W?D4DE,O7G\fET/\]CBI_BODI#4c\1WWATPRN<FN>X[e]S(D,?VIf=AQ1;
GVac-6CS#XL^1^ZHdQYPe;(G^E+0+fH?K&gaWI-C?f7g.TO\LA(2LSJTa5CXU<&>
S)(cY&.B\^U=R[QW.SUd0c>:JF;:g(]8G[2Z7-.#[FMaN+MD/13WM=2B2SaEa9@8
&?(-C:=PN1e/EbbeY[[7Z1:b,)5CUMUI-Y3/<8)LMXR1YOC5ALa_ZPbSNbO9OM0^
VaQHC=(G^+LNZ\,H8g9@ZITfUF##IL(.YBWT(Qf/MGb83WC<1BAf;P]Ac,#aLVg1
Bc.8ccW@WPTI&3?+XeW@X=N\(ZgAY/bPfG[?/HEe)1]ccHE/Z)F6)GUWc?e8W0-J
C_77I1\I#&WK4I7Z0?B@A0ANMOW^=+a@T7S&Q02,ZJ6PFDKdTf7-SXLUV<V_N:Gf
B-M9_#F&WK#Z(-X+V22;.[E+CGH#4Yd:(8>:DN_6;-_4M4^017U:FKe3I@Z<?T9(
?eET(\/\3@@TA7HaTH.d4V;T/e1]?^aBOWgY16,;@W20SP/&Q]aZ=UP0F9K+6d5c
EC7JGY#?-N?DeVOL3-T.=/C=b?T30;;[)>+80Yb=);7BGE0c.C3WWaGOc_:#1\=U
8/Cfd4Pad_50UO9e2G5eOJTZ7#+bY3I^X1UA0\&Y,?L\B[4I0OSP4?#VacG>M@0;
D7,@e8_d@g_80E6(DYUZDRW,B82C2F4U<5Rd=8RB^22G34^M[3HS8OV[<QcK5DF?
TQT4X\G^CPPO-4EAP/>PIQEKOMF[MdU[+Y]_N+Q.+c)XPL:5KK58Zg-:[0P=M-H[
C.-X9RWS_8W3Z-<WQNF=bL.UWDT7LD:/2&d.8]B#E[H0P@S6_MLKJcD7dG_N]Q1^
,&LO>g>fCTVFT@-\)+DbXR[3.P@7[2XR8=/)UBWZ;]HP<J?4aL5W[S5^Z._B8/D-
9<2NM>8SXS#E-O#P]:-/XO[33$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

