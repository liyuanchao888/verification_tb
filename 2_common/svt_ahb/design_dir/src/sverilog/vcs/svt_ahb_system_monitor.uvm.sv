
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV

typedef class svt_ahb_system_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY  
typedef uvm_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`endif
  
// =============================================================================
/**
 * This class is System Monitor that implements an AHB system_checker
 * component.  The system monitor observes transactions across the ports of a
 * AHB bus and performs checks between the transactions of these ports. It does
 * not perform port level checks which are done by the checkers of each
 * master/slave agent connected to a port.  
 */

class svt_ahb_system_monitor extends svt_monitor;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_system_monitor, svt_ahb_system_monitor_callback)
`endif
  
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /**
   * Port through which checker gets transactions initiated from master to bus
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_master_transaction) mstr_to_bus_get_port;

  /**
   * Port through which checker gets transactions initiated from bus to slave 
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_transaction) bus_to_slave_get_port;
  /** @endcond */


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of AHB system_checker components */
  protected svt_ahb_system_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_system_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_system_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** Flag for reporting master transactions*/
  local bit received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit received_slave_xacts  = 1'b0;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_system_monitor)
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
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_system_monitor", `SVT_XVM(component) parent = null);
  
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
`else
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads that get transactions from
   * ports and monitors them. 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
    * Report phase
    * Reports cache vs memory consistency
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase(uvm_phase phase);
`else
  extern virtual function void report();
`endif                               

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Method that manages transactions initiated by AHB master.
   */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_master_to_bus(uvm_phase phase);
`else
  extern protected task consume_xact_from_master_to_bus();
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to AHB slave.
   */
`ifdef SVT_UVM_TECHNOLOGY   
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_bus_to_slave(uvm_phase phase);
`else
  extern protected task consume_xact_from_bus_to_slave();
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

/** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** 
    * Called when a new transaction initiated by an AHB master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
    * Called when a new transaction initiated by an AHB bus to an AHB slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);
  
  /**
    * Called after a transaction initiated by an AHB master to AHB bus is received by
    * the system monitor 
    * This method issues the <i>new_master_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
    * Called after a transaction initiated by an AHB bus to an AHB slave is received by
    * the system monitor 
    * This method issues the <i>new_slave_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_slave_transaction_received_cb_exec(svt_ahb_slave_transaction xact);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * @param master_id Master port id which got grant.
    */
  extern virtual function void master_got_hgrant(int master_id);

  /** 
    * Called when atleast one of the masters request for bus access.
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual function void master_asserted_hbusreq(int master_id);

  /** 
    * Called when atleast one of the slaves gets selected.
    * @param slave_id Slave port id which got selected.
    */
  extern virtual function void slave_got_selected(int slave_id);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * This method issues the <i>master_got_hgrant</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id);  

  /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param slave_id Slave port id which got selected.
    */
  extern virtual task slave_got_selected_cb_exec(int slave_id);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual protected function void pre_check_execute(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * This method issues the <i>pre_check_execute</i> callback using the
    * `uvm_do_callbacks macro.
    * 
    * Overriding implementations in extended classes must ensure that the callbacks
    * get executed correctly.
    *
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual task pre_check_execute_cb_exec(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** @endcond */


endclass

`protected
KH<J]Q.QT3#QDP6aT,_^5^Q9)JA?W<:c?8)_fQ+2OM#=/Q@//0L7))b#1[fX_P\@
Ie;;E\\G8.ZQHB&fOBW9VB7W>CcJ6dEE\X0gI7fG(1>9XUWEG1)4REXeSK,D1[:I
Q+=TRgM/Q@(#^+GO[M1TPJ5H@^<,-VB9UV)GB#47=W^NES&RPPd2a;N)QOg2Y5H/
.1]Q3J:O++f&=ME5C3BJ3\5O.W@H#3cT;5f##-,MEZ>(.\UQ2(HX0;cT7.+#cK(E
_5^a:0,[TNb=&R>cI=U&RURR(4_:c8SS-1UfFaL7B1-ON#@7<(G#d?@L[f-2aMM/
]?.ddY4<P4YQ81I>baWM@?0TH0f>,RgOBHFZUW(C,]NBFe(19F-JG&YJQPMd(Qf#T$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
VN[BH^[&:@U,5&I/)4.YFPbM775#N#/Z5YaX-HILe_UPM_f3(E@a+(\b__(gYPOb
8+XRQ>WMO>3<MZdc][C+1SQ;43EL/ZPJ6SAQKJ8I(P\5,U\d(IKYZQXDOcKT@(+W
\E87D8RU;V)7B+=1FFCMdX8[PfDUaEY=(@3-af1[6=/;9_Sa.aH207IM5W3bYOd@
T879:+Y&2]40gBLREO9+1]_O18>H:cNZ^/\d>/20PVJT_/E3K5:I#-:E>YAX:cBG
-X3a_ILDc[ZOZ>.UQX7E7H,D/@A&I=\,?O3PLdg1W-gVe&IH1e)G)(0If=[QD4#g
=FfLb<50@;I5b]U1#S0P2L)4CL7;QcBB5X3/ZZFA,^SXV\?:3V&@\5^YJ(EI+67?
0DII==(67TIXG.91RY<La#BJ7@Y,IR/_&3/+Z>VU]CIS12F)<RcO0RCfcU[#Td&D
AID7/@e\U=F0N-MZSZW^6+a,9V,-Pa+.c.<N.,UAg.GO)cb;M?>JA;IF&GLcb1[?
-bPH&O9Gf_+JA);B_3;&&9/Yg5K8fAUC3SI1_/L+:D?gf7d3(AAKF6D90AOg4/(C
@SBQd0)F9EUE1F@0R&1?K>@@a)[PB(+BZ+R77I9B7I8-f9)PX1]=bP.&HN:)7]TQ
:/,A<N6De<<#(:3\<FU+dT<[0=.UO<UP_fP58a;6@+Z9+HCVX,++0Q@)SZ&QO3&2
\0+b/6KOWW,Z_,YIJ<C<A)dES(b<UG1c:K.15eCXcLCPG<f+YBQ\P4IT.9&J,1e+
XLFSMM)=f2UWP#F0YX2;D>]A7Z<>-b0Z)G(6KB6WH]fV\(JN@)S8_)PWS<X[\8^_
<1,0VQP7,De[M#2/+U2?DZbW.S@\&Z16[_@cI>WZ,#=P)B7+#2^A+QN#4,X4@VA+
Y=4I,PLGIe5_;dfJ^T0:YBWJa<;AQF94IU8S5(7Q>+Qf\RH#CT\/,KL&J5AbS8b@
]E4L,JT.&H.?3@<Y1:,?C44]SJbc1Q9DS9>cY.29#@DV>&]6V<@3cX1>#=2Q?L2G
FZ6JX>1,:;JA;L_[&>.Q2[V<?HbC]6=999W:)d+bSb),P:N-(#B:8E8R?b?<3(Xe
]R@2O5><QcOVS?CfFU&VBOO<DM6^#b>7QUJ9Ng3J6)[f10eaXgOMK9KB-_3c>O0T
.+KMg#A7WBb3TUN43?(c2QXf5eV=GCWC4RNM);KU2)EM(SPRHK2_CHRFJ@\YCB)A
LD,@>3ZgO,86JS1bQEW=(7C((a7<eI9(5=GJT0/@R(1L5[LM&?S^D:T>>2,+OZY#
)J(#P[\8FJIZ:IXG,4f:cMFGb1#=O>1^[-.Zc9b@ZPNBHe<3X1C4bJe.Kb5\0gd)
g7KA(=b6]IGLJ)BART<@W0UAU/NMTXV/-HN/-1<J/:R(6D3I[1.WL^NUb:ZH0gTU
:(70f9RKI/:8FbB4\30MebEU/UEJ)OHdK/gN9EK6MON;QcN(;4[LO#Q=<ZSgb>Nb
dL;,U797PYG0>)2-INWAYC,U)[7g[#,b<G[S2K)#I2++E)Vge#0/T:37Q2,J-LH#
aM<61Eg4#DN,WcMcLACB#O>2N#,UEeUIWE?Vd4g=cCLO(>X.OF@HL8N0O9:--BJ<
WXE8_,AM&5Bd_<Ad6,?6g?[La#CYMA91EML4AX:]bedUc@^-X([2D>#([3JK?]-N
.<[d7)2TR?I4JH9J).QFA5]Gc7f6X[I:6;RG/M\IGH7gbEZ3DJ0H4QV,I>18&Od7
H2T1SPX4aP.DLDf.,&g27H,@[Z:H=+N4].^E-\6XeM.SC\dO(BS(Pd.ID&MAc<^V
a#&0B8C/3,(_#8e-/Q8&41FgJ[<ENKD&f:RZ.P@SSNf5Z1;@GW+7S,D(WFA6c&HK
\J8(-V&:CJE@4+d(^LH+dSEBc@HKO1f&?79MX6]064LHEJ4NZEgH_SXG5KV7_:_)
#<[DdRQ9N)S)&Kf_1FBGg7R)gVYR/Od=.[[Xe6IdPQIS7YPQ.]A3Mg]PI^[SUKD&
O,CHBRfO1)T;ICOQ\,5-g)4?Y4@<_]JI2[UMYG<G=Z\]31bGV&CYcP_WA^L38RSS
b9W-.<c/f;9P:B]UD#3A;)Zf6^8KVT=N\YgG2ZF?5R-C;ZAKG1Y)7<.-7/^Y;c/U
R2)e6>0?U.;eG:,L_?_W>(@=R^YaD^c\Z31))>MWKcMI&[_GZ_4OU<R2S;I/VA(a
[AUD/X6KG4NEG?4:,ZP5TD5UDRc4JUQG8FZU;&1ID85E;6VSU+(fH/;&Le1=;+?Y
Q_35U5]--(2-;G-WM(QCC=K_[+#0b87\Ga6;CW^BSD(<W/]P)7DUfVJBD\E,]4^:
JcJ1K_K+..LU0=<YP\MS2^G>@ATQ/Y0DW#\R[&HC875,+92J->0P6S)PgXS?9)4D
V]8<NJ?+C?/66,RL<B>UK@E+&XdRfB2:[OA]/UR,dB.S04VdB:@Z2M)RBF(:f><+
/IXdaEFB-_\BB\Q2F52UOB\NNbK-_E9^(WK[;;@6LGF8&;Y8gU)7B-=ac>TbNJ]B
UX9MB,OXf-1.(2@.9@a\\YGRE&;?L]IEF,X.JU7J.SQ3;-UFOg8\W)(HX>H4970(
5--c]N4KUUW49[LMJ#W:;N1)2P5/=FfP<IYA/_ZNJ[FGB6OOZ@EU#3G_H[T<fPL?
,M)E:bS.,9-&@6DS>-7:c@JIOMKMCXB:C3aU(/5g5bLKX(</923D5IH4AHF<X.b+
OJ?\.4;LLcJI@cIf3^]M?JWEg&\?^\)03>-@2+<FF#Mf\:2,.&.Y=.L(2J[A_(H-
VH06>+>/2IIc8@f8T.Q2a^;TUH(89e7I+1)B.eB3+=?/.K:DL?Xa>5]N9fdIF>M2
<_&[c:b[EWCSQ7/Q@gb:CH1PWPB^X[0MUJBB7;cRNS.<S9g3\@Cc\]FC[K;X7V3]
NZRZO_?1OHECG@d0(YL4g(M_b>MZ-A=O_\bLEZO6G5^JWWfH^bcId^730CD)/fOW
BJI\P,b\>Sb@g#SAH_/4W4-HVa-4:]f&NLUaWgP>E#9-@HK?YBQBL7]71<0UAbA>
fXaTJZGMQ50HH6M<@TJC5.#]9.B0>,f5b+g3UVXDZ0XBKbH0CE/ET?6;9&04J(cO
<WGI)1^K43/B9-b@F,BEc6@1dN8F0U^G0>;V3T;LB^V5_Ec?geCN-SEA3TA?dcB2
-;.Z.7IgG/?U)#bF6F=bQ\P]JXUAdePDGN#-):)FJZ/T70+&S(\N77a;G@H0P8WJ
=SdB.U&J+2?MB&\)-@+9#AEgHgZR^KHM7<O?;UH7[1;Rcc=AIXHeWNAWVL?:.@Zf
>E>dg+?+6e).1aGJ,4;N6;-UX[A-VD_52:0U8IOZ(=/]9@P^<[MHE.Z&YZ>3[29Z
Ka7AHJTK^[:8;B?3bA3]aG[6R).^gbFP+5/NH9X&P#g5ZZ6/PeFF3M,GZ>1?.;6M
1R-NgS+ZB7>Of6C;)fggH2YWIX+P_Ae^2&Ca;7G/1VS[;STcMa7Z8f9GL:_C;LN?
/27-#5?,N;P16bGF;,?OU6@WX&.JKNd74-.6d&73Hc1X?3>0&g-RL(R5DD9=?85V
#>6[[(O#1Q#\Yb11B?<IBTT<D4AD1/(NfG1#7]Pa5(Q6/0,:R?>;N8,GcZXVba,X
63^cedSZ+/eVB^#CMdCLEW36&bCE/;,QGI1&]8_?Fb&\>H>P339C^,bR456<[K,8
+c0J=4C\4fGTSAO>0E\Z&>C?(2LAA50>.Z3IZ\Z-,eY3]OSU@P60\\<0H^7.W;:)
0Q<)VLd?e5&9.>FP-IV-4c;N^7b@UQ@3;aS6(MK>NUK,M:6ec.0E/U9<D<[3@]IS
]Y7d@a#Add>;Rcb:))_.:C>9M#D4<L>3^+Z(]R\e?<2f_=<6.J=)RYWI\f1[=?A4
eCIIgUKb78d8#OL=:&XU5eMb5.:ID/T7X@#+4HgGLEM-U?A6VQ=&UV10Oc#+R4?=
&:XGZ&:PBIN+W<QR7^g^@VFA\@8YI4>_&;Fa+O=P@)-ZDU\QUUQES^6?82<Z(3Kd
<L?:/Z#@EZGX3^I9&;RbIUDJeH>JHE4#:OG/O\,/W4WEf)MYL<QD2Z_/UG=3PQ5Y
JaK]\9_UB>\M.Q_-6IRMaX-6eWHW4CO<+YZcN^<\,e;VE6^2/]-[.87MH;,,BGD3
YF<bXd6>APabM^<1.&HC<RV4:c;_3Q>0SJ3QI7/<49LT;Qa8KP<?OHOSPcRBYL1M
U9+6?a2<5J^HN-]fS#(=2SH&[T2A\OgK@(]R<^_5aU=UDU)26ZH)UR+&?0(/T@L2
ST=&,;Z2f>G)Nf]N--KN2=7:KVbScAZC^#<1TDI3D2OG(D7T:G^_TMVV)/Ab>L,O
]ERf8X=EN3-dHV;@@QE0-0XLg+:R6_:b]f-[34f.R\TT=NI0,BSSC.A,.OCZ9^^R
8]&_8Y5TaFYU^:[@BU.2+O?7RY)WUC2I4/&35\e.A@?J]-&_Gc&8([-B=d?VZRB;
X-SYLIC4ZcY^#?ZZ10EGEb4?>/H0U-]TCCaMJO^SV:=EcM&LIe02]-13TW:d5Z/B
+G?,4/]\WP+<=4<)]>IVX9d).IeYdZBGRYbDT3XJ475CKHU&#,_\)PTTA?UA4XHD
NZ#Da6N-2T4MD^G-eA&.J595+A\N@>QbGd:b=M7Q-^?Wgf+M?=F_>@/IWag7[dM2
X]TEc;+_@@DJ/da=.RS]e;H1+7FN-PZQ>HX8C5Q_a>AO5\=\8T0\?XT^g(,fX?Kf
<6L1>42QRUO,:&dT:B[(-T[^IEe;W#CMX]:.;8^,5>?LKVcGWfg]KFSc;H00O]/V
A5W@E.@@97bF-Wd[8YaCfA5]1)P;R9^GQI-Z?T4AANLU^3g#R#B6cdODB:M_Ue\_
Sd1#:5dJcQ02_WB=^[EH/fT/N7(@#5(>><Z1\1Xg?+)1I<5@VfL;#?#UEAd7]N\;
U4\6H0@LdJ_?&,BdB##&2@GP<2^TELM#]B[<^,Qa,(0J9f4)GTC6dX+5f2UB11&P
QC_#I(Q;7S>aK3PGO/L9;dS#gS:ZbCL5,dQ:/cSF-Q4@:TK7JM2,1+&9R[K+KB7P
/;T]N.J=#XH=_K>=:7;48U?e]XS/Q_d&D>fb&C6DV#Z].1=G\><+\;@,;W[SRV>2
Dg^P:QQM?P+PUO1^(IJ12U4Nb6d^@:28#^(#DId5S:a:8H70#@F.?-a11[T@BM3e
CDW?c,[DGgFT;54<F02N(3B;F#gTfAHXZ+J4Ud&U?R/\[g5b,eNBeHE:(;NSWBAf
K2-MbB3)3Y>68>0dBQdg@IBd_T-,g=ZA@Q^NG=A_2NP@102]C[?V:\C)K[0cc>@Y
Y\Ke)d7.Sc8Y/eX_Sge)Ace>;:Z=Z+EKHB56Q8M8SR8c8:\a\b=MRFFP#:,JcRZ+
EX<2[K@<Fgc]9f)2/S8)[QNLQa7[_,;f:R6G?P.J\5-_OgB=?g-M<AdCB=KLQ-TL
/aS;PdVO^G2?&?0D#c()W#/J4,HALQ;-7V_@R&>g;cdT<M/Q4NU?L^B/GOZF+4F+
c1_@RNH\SCa]E3g:IYXP<1Pe9-LUI-;IRIb9d(#H.G-E.&UQTXZb<-I;H7\AGaMN
4YUK+2H#MR^H^:eZSS_4OAE8MGL8KJ0aYU-R5^O0<H]_WS726B<,RH@H3=.77[7[
(WQW@Ddb?:8bNPRN0B&I5K>,)3^Wc11#JYT^TBPO5d6DS4O((L5APM@@@LVR&8)X
JUZTA+>26=3a:11-\4JYSCgb]:WY_30-&aO/QCRF_aF(1=aVT7];BRRHZ(KPTTCA
\TDVD:UFRRDc7Y/eYa,3MBL;>OaMe:2MdQYAZBP-)Y&K0dC4/aI(SX13SWd@TOJG
N4^ZQ1GPM\C?C8C2IN0S//:CC(8K]3^DIRE.WeN?Nb;ZZ_C#IDG@8K<-OE-(VB:3
YbAK(+;[,VI?<^__gWNV5Q19JY.1X<8)99]5VL,7NfTfCg(Gd]P5C(2Y(dAG0U=f
)dbQ8H7>\O\HJ5FXY9.W1dZKMcM-,f.@MaeHg:LfO3&(cS,LgD78H/7I3TEM/F?g
PdDNRE,&57@UT1+g>_XM3Z_]+=a)FNJ?)f.5-H?4#N(4?#_Z&;\XOFA=If=[#K]a
e;]91PI9#J9JR-2V#RUG;#4(:E2PPS[d92b<Y1R7I1ER^bfP<Z)5F6c^b&.;<:S)
2IC.[ff/#0;<WA(F-3;&N3HC.<N6LE-Q<61AfI9E>9-[eacRS\43X)db;a#FcfI.
e@TXBIX&>c0U=9PCPXF8MY9UT/C:ZX7=KV]H@E-G?=YM[LJAQ7@UTa)O^,]?F_/G
9b?1g]-R+8?_G>^9_gZED&4d,IXf>AE94&&7P:WdOQc6[KA+Y6[(WNdXP;=]0ba@
7YO.9d<8;4BN&/22JP2+=P483QZ(VYFdZTL,SJH(Se>V:E(/T^R-()=E&A-R+@UJ
<-S1eUPI@@S[+M1AK^@(V7U-K/[H=O1gN@,J9eA[T,VQ]OfEgWc7QL+W@][KV?36
<:&4(ZZH7W?1TdGQJc9<6\:V[5/<JPMZA17f)WJD\gUK9;Qe7#H#H3@:Z./B/9_S
[&_@NPe5GgZbQ48C[Q&@d-cFIQZ@[VR(^),G3V^84DF6<<^2Z8^?,_HANMI.J8=]
G<0[ON@H]>?BMO(HGNFL<J1de=9aJ.+>.]V]d9DgANC<=gL2T.f5Cg&^gA#JT@@I
+SPJ9G#KGU2?=IMOV-^=e_JH]]R/)PW8.NTVAYS]O1^(,MP3Z-QfQNA?]T]IA;SE
Fg28Uf>R2@==C(1gZAEE6eVWEY]]QO.U#/E07eLcb&:A7E)5&IBbbIbU+1P^BZVL
SO,P093#U-S=Z-74T1QH+fW?=D&45+P69>:BCF_YZ^,[/T_A,HTH=?fTCMO>4@O\
(Ef[DV^:5;I+IR:)0<1>U^^g.<]7/::ZMY:gL)U@ac;N:fLd2#)7R.5?2RbDHgdJ
2]WFG4JQIA5#N[6ZX>YWT0]SB+KT_f2QE1FeQHL5+,,MEQFgY.F[aP<&C-a9KN2M
=0G8_.SG6NFTY#L2#(b3CQg&:SH:E6XX34+0QNH=JVJZG>8853N_TS41=O:HTA>L
RHH>c4Kd&9a+IQ58_K)4L-)cR90f.I[Q>,7@=(58(8_?CN@J6A_C2d_&C#XBFe;8
,HZ,LJb,L(Y#YQ0QL0b#,H_2>M_S<ZEf&HJgb]/Z_.9HS(;MUP&92R/\=86De2E#
1&fNB[,&6R.AHQ=E]VFED_XgM>L_D5dP_UF<E:]bb0^b^NF.8Lf3AXM;?J8T_AHV
?Kf;A<40A3MfF+g3?c.+fC6>=KfHA8BaSG:WX)>cgJK7d2+GYRg1E+:;&39]#_BE
T2a=\-#@AIUc\Z8NFL_gAD.d6_Oc2=_-?>8YXL:[b4b1K^YZ]0JGcU3_59E;L+WR
LPYK@#LSS:g.U8a9SH(+8@U=2;Q1B34_/W^=UTT2&POZ_M1E&MfGLcD-.+JTGENH
LES.-C.@7[3_J/NWKcU79g<feAS-HQY.cF?7P7YA.caAad[N&eJXa4e+f_7?f\,6
T<=OSK7#J.#Y(4?E\AaCTLW]U0RLDPb\;.=N)N0YH+b2cS-\)/9KB,PG&:Gd/6Ua
B9=28[R[SR3^6_(+X2>A)9.IEY7b\=#G>#JG26>g@_PA]ABGAZKLbZ,3WQW@TU2E
UgV0/AbZ4JRJM3Cg5D_e\\C^3.&3fYNY2E:&WCD^5VEIWN,,bMUbf1[[0,+,_M^M
P1eMM-SE^7QVaVGCeUB;BQf:L6/8e979QbZ3AU;)g6AAVXg(\OXZUAe?13Rc/.)#
PA)OK2df)H6PYS_A+?I)RcSL8?eQ5#?=dVY<CJ+O<8/TK2AV3&8f88HY4N)HUbRP
/L_TQLR/e29K@,ec;dU>],<=U&>-cZbZbNZUY+R[H_C>-e?0,2HM2;.TD?(8FL&S
BbT0T]=ALEQHZ^+BTUF?=XaR#XJN@=#eXcSC_J\cd)QI);g6\EVMb]USUD,6aacN
>e)741YF;#:KgADU0aP^H,^Z>Ze>4?^N[:)9:BUU\4.,=(6N?.OOA^(]3Z(F/W]S
c5g18D,BB=,-a\_2Q&[8DE-cY)//BAaLU#)[I][)-)K-FMbSY_;a[;?-(OUO-/(V
(H/JBgXJNU76=A^75O,YNcMFSS#OQcM1&B_6,cK<2JT)^2P&cd2LbR,cKXG<,M=2
AL6J\;DPPK]+87?SFXJ>UBe<@0OP5dE4)#P-:3BO0NOaD&9d1MD]LGEF6#LQH,:=
JCEMO,]H4&LP/I.JY^ec>D>XT[P_5=,7E^eFe\WL,-Z59T_E&)ZZTIG<3,#38K;#
HE?YbdIG&=f?WA)XB9:#WW9eg,^HKWd16/g;D:NK=&+?)&QBO1>Tc:)231TPV;08
(W/6UN8KA[4S<H4P2?gY3TG\=5(RTW:EU6aF[d8V/JEJ#g[->3XS=:AAP=]]04(a
>EFF?)#L(c1FU08bDSHA81XPOSGb&)__/&:&1[T#7ASW\IM2S+7e>?BJ1?_:);-;
<]5P8e@KLHYYb>&36T99ZZQ(fF?F9:.CM?H+-=4@3H.<+W6M5-:GA5-9AX;+9c6P
]AO+fc6QHVQY-93bJL<O/Y-Z]1&SD#7#264F&A9HIZaF3;B7S5Se&)4,@WE#<NG9
S>=.6IWQA12MG#LS:4=P[IEV[Q<e9[?2f8?0Ud<,[+d<-e6<1Z#^gQ1XEPAQ2?W0
,6]7-dRMU:7WJW\@\2Q#7<(gE4_50f\2A9TX;UY-WZOFVQHDLV@=TRZ>+3;G?O4]
IRX55S@Qc:g5IeRNX6M[)cXH>PLE?\UCQSc+XJGZ:CMU>7OX&(<)d/AfC<9C[AW7
c1b\JW1/cF:#/64/FVJMX;#<.AOTCK.&9+8XCT,Y+OWK_JY?gV5Xf:2^=2[N?e8P
VZ0PZD11&0;F;/K(XbJLHA)RP3W-(+NBA?c:#@FD..ZT^#Y7AMVZ90EQFP3O8GH=
Ua(Rd[9;E6;=.ef5L[8I(?4K>&B#e,+=IX[VcaILQ(@B]b?#77ABa/R.SZd6--;d
BJ7@GHJPU;1&OYW-4?V5[HaR@A[8[,V5-bCR(1(L=aV,d0a0A:@Q6[5MSVHPYN.e
7^XKPQ8.[]a/0B\K-?X)F.-M0L0e)#6,Bcd@L0fMM74>IA^gRPD,3\40^<2S)&Z.
[@7\P/I#1^8VO-47(W)Y?ULg?I7+=5^5HSfSeI+Lf?A.?SUd1?7KEb4#FMBK0Cc;
_9T:0eP/)NI&RFd-,T7dLVFc?1CGTVK&Df3@#UZ-(e+O(GUU^Y;A1HJBIHaC^Bc?
](C^ZP+CT1&Ib)0,05ERN2bR34JB[=[aBa<;NTX<A2OQGTPe^>46eE5=@XVRc)LU
-I7-J7=^P5=:cJLaW0;_A(=HYeceCC+U.NOg8BES+bC_>3SO:P5_>2DD#X<K=PJG
dF/b9cNQ:9\RX;RN,]GL5>d=gIX^?;<R(ce0(8TO\>/K-2EaeA>[=)88S&H46-]g
OYXZ&(-28K^g[eDdVH&WP+N+.ca@P^N><>1SgXc8.(D^D,/^f)#2J6YU#P[O<_ZR
P4@Jc5.7GcQB8190AMA#-UB]?;>)#8DQc>7\R.Q.F8@QG?K0=CH,>8XG;+EU]5LB
g0Ra^1g&Z=+FeJEbG.&:IT+CP5.)Z8ZAOM6^A.2Z[E<g=23CJc]3]]L5H0;\2dNJ
SfI(fY(6IM@E5g)@Ud3N=f0LH_S[KK)I[(R<CGMB4Nd52dEca6C7ae0ND&5D16[c
8RK<;IHE_<)7GC(OE1?bQ]BGF(<7Y2WbMGSER\9baB+/J2^;Q>Ge<O<?#PP9g>VM
WZ\.O#O2=HdEOTCO8Y:Z,PPRATeSDaT_UIfTAbZ[8X8#I/WB7WBS/J1)XE2GQU]I
<g&SUa,ER#IM/C\WX;ZCgf(]YJ^CC]ASB7J=L,<A<c9\?/9R\e&A/XNeA#2T+T8?
W^N0V3aYU(MAg3U2Y/GID74ZVO+A[11Q&VW8faN::[-?C)(+d[:(,I&RTD8a=T&E
PG:6[&1(OPEg.RAZZG7V/@MK\-g2Fa4&aAb>8+6+;&K@2@HJ]Q_Tb0@AU27\R.eI
;bA\7@eWU(BMbPPe[L?-,MKB?J0(d:)]QeLWKG].)<TO=V8^H8C=V_-REKRU=-F6
fb=_V:bUHC231M9gG#+aEZ46_A<g?I/T<<8b8:dDVc?4IGaLG@<29dZgKXgA_g4#
PXR79=](0C[eJSFb)W2</M,LdScT0:AI=D:/RGFGPEc3.0b\bBDC?;(Q-2.S@2>b
b+4(6e<OV72&G9W)IPG.V]L<_4ZJV?;Be)A6FIb90QFXD#XXcOb]L(M^MHV=a,3-
f+J-TUHTc@CH6YE[<Rb&?/,e:BR59aX79c-Ue314^?V^3UPdM,P99+eDJbEL&36f
+O:cW1&<G4=V^#=gc_dbDVHA4MRD:</0;PaS6RWNL_)&gU,T;:?P4=;K>V#6E?J4
YaK058UFOZT0]Vf^]?Z<^<^Y#LQ_F8V83ASJ?b4(IEZ;SQ7LU7Z1Fe9TL0RbIJ-&
;f_Qa4[++@]dMM]U()6\E;M&)5>GEaf-;a/\]XG00V5E)dN9;H#;3eDaRe>/\;ST
U1><5,Tf&Fd4[Ta6J\>0<)IB\V_[CE;AN_(T00F>=LOEY5.GC)\4L@Na+#<F8FG_
MfEbFaJ83)=[)4<dR&,5D83DePb,/fLJ/<TRH2,]#3bD8AQ;Ca&D>XRT[E)^\V82
5He8[f#9Q@D[ZO1ecQ0J[+X@EU]G&XJ8B405D02g^#S1.V2WC5;#10@4H;S;5^RI
?<A5dK&U&N;Xb1d&<d_E4O]3CM^RJb?=?FS#V?L.?bdG]6^e-V2ZM6G@BW[;KO&D
L2HI(La>+#XaW64e>;)6gK8Fa:Pb[UJ\\-_)T3dZ-ac5I/D8&2>2O\&NVF:2\9Z9
IeFDCVGg^ZY(^b)][K^IN]0DeC1MJ33Y?C2#[7\V\P#/IL@<T32_]M]HMRG-Y=c0
QSfc\_4.XWa8#Ud;T+GJ;))=YROf.,DV\U(>dPc\T3[J44V/K8\KFIT[3AOGP92<
cNceP3N.^_I&NdgZ]M\R<H,+@52b++YA)6SQ:c3J0==NY&MY7bG2#1Q[gV6O^T4B
83f58U,&Y5P.F)TIECKLbe8>&B,OMFX>.0T)&CLHG5)UIc.0/Aab?_WI]C>W)#>X
T(&WM7U#Sa:Z3V@X_9..gIbReJ#Mb;cb-5L70(efUN/?P+X\;C3IX,\E+RIY\080
a81<G=H.U0IN&;2Z3K/P?2K.<KOX6#_5=+T?Fg/4:ZNU^Fc:5KZUJNLPF9H\(1,7
Vg=&@X7NTM#3C.5dK_83=>9()3bE(e,OZD2F[[;da&#ILA8_^VVM_F_f3_O8c;PM
S>e?1CT[]NcPRGC>3SSWgWKZ7AW23A1]^aS:8I<9=d#4#O:a7UU\;aJdc^,P]Q:,
G:+C2@#b75[gO,CMdU-JcWU/:&^<?F<8c?\164K/7YE@^2::g2NBfQ5C>DN>2;IH
)+VGc0d91RcLc^,.>W/E5^@&_94b8N3UA9O2AU6\X4TV0=E=LWH_5O/ad[164Y1#
,e1Gd)13U^6XU2a^0aZWb\^.^FO>.(1F43e7Xb34X?PfY<U1f@^KE9Ce:VEe+/6(
=6c^edTCVVcG=0E=JKZ/XO3dL4/gEZg1Gc-@Y2[&[a+@43=b0J,6b.61L53>1fF.
ZWgC/R5YTTF:^c]FB;UST>XU=].U9EY8&R0bGSHF#(f>0CJ7_@Sa&:06g<-eUQQ<
2)]4Q=e-;W1I2aL12>>ATU/#^>IMd99RS+V>MI2VF5.J9(D.CTLFSG7g#R-d&@3P
O5J\TfQV2.U6TW(#E_\(,PYgI^Z5J4S4d0CN(Z0(B8bcMegZ>R.59CPND2_Mg(S;
@,09SX=8[J;\cQ&PBJ\7_?eS)TF8RM+?]c;[P)@,/A+=(a/d9E7cK_.E[IeS_)/W
.6)_ALTYO;U0_bP3O\Lc^FM.2STZD0JK4a4QCO#&bIPDUX;Z16L(_P<H4.,bW-O.
?U>)U:0R>6(1Cb8<.FFEC#M/#V8]bY>HDBHKLMW0@\FgD>/MA5)PY/AH4W?d3f<N
(KOfS;ASBVR01a#B,U.IVLTV+U_XC;[W:aO9aF+5cI,LSOHHgbHBR&8b_:W]A[CZ
<X3.8ZF=G<Vf2,;XJJHQR2M7_:S,#\XD6N??]MK3cI4MB&]+dfB+S]6&F-f@=.Q]
[5/c47b5(^G8_;g<+[ad>\1^U5AD-K:fUOZ8Z.6D_e4[cd]M/>/5EM\\d_Y?IcBZ
gOE<TP;bP#)OZ-?T^3cQeSd3\=>P4ODaf:\)<+CL/=/g3aJSW6<B\9<.^^RQHd+1
?#H<<G9L@JD,7W8.C:Q<Y[#)d[Tce=M6RfRgV3[J^1F6=;4T;1B_>LTaU^T98a(R
TL-2.^g[F2g,Y.Q>Z_SV[1L]=40>6VCBUD=Mg<N2,8[E,147I&Y11J7FgQNcf7C0
RFbW\51WEG9Kd@\g.^2>HD(bdK)gRYHLc(A]UCcTH5OSf?/K+6V=I;ZG4&?O_\UP
-(&/bL&&6gA6[,a^;<-2e1VDP[ZS?<]f/4bg_4D))BU&P^<_^57T+HPE\5:CbI\)
&SJ3<(IGb/dF>f@@DSKf:3453S=P7&HY3[d@CZa+XG]CRI[@X60d]YU[);D[N.O:
.:ZE]6W:+?D80QdFaF5PY+9I4bffY?\Xg)S=5?0e\.W_+_+;<CfUAW[^F32Q_;d@
KOG?#1>[8@dTCRM1@)BG.cVAQI7JDVg[=48U]<9@CE=3O36K6+4#C-81Jc;a:@3-
OWE5B7GNS>JcG,+0PGY^CR&;(.BH.UeGBFF:198<_]5YSM[bJa5:&XdB+21[3c_b
1&YbAgX<F5]OI(_GG&N/Q/0e9g7<CH+Q?AR7_V(L7M/J;UU3cf-48_K=&?QRN2=N
&W[Sc\@VBd97XO2;.&1(2N9(]9FfgL-_GOSIB<+Ha)02We,VT#R&9<M&76#dfSC0
\/KDa5?G^b1V9^A#QcCTdH9_E5VTK_Q2/<<]1NKQQBN1I\Z,&:@?>28+S&S&gK_[
R@34WaQO9F-UbF_cR2O21D02dI,F\[,5H^>AEa?WX][g:&H&U5c9a?T6fKSHee34
=fY#=&LA_K#+L.6IG\-CfE8YO39]E@fO\I;6:+H.b&BR+?FPa)d<SJWC.YA-;Y4N
.V\_S&N7-<RYfL2DZ&//[U2S4_U:GZA4)KDf@&2RX(,TKU2SK7:H1?UXZNWXLgF\
ZcW.<N[?HU^=W)_Z><b1A[S:^676J8NFKWI;I\f8FdP;LcL+J/564O?Sf\_<-+K+
#Vg-SQd91EA#a=dY8NLI52AgKcI8+&<15@F9c0LIAVFRM[.PO8#FcVJ^H&62H5(C
S8T@_JUZg)[V/1@9+VK+-3MT(YM0@/3LI>XYa^Y2-Z,#CM2H2P3@;\B2)LNP5a0P
g,bRY<Db&Q39@@V9Ug+IN.Y(]]RKabFY0P7eaX\Xc5#S&[_#IaICBb<U0KXc96+;
AR;SGe]bVc-g^\\JO1O^7_QZ00A=,SUT)D_^>S^2JHMLW[GBR6FcVU:LI.Vf&=R6
OSZ.QH?ef+HF3NV7U,=bTA?29C@[[Z)(TZT37dfd-MEDWGbOd&^?R9J<2VAF,4#S
dVAJ@L&=M4_#+\E,VD6OaY0)IcFM143d]:]A&.aA7+=X_B(b+?NHb9TO\G)QW;>3
3dLC1-B08IW.<aeIRX>ga575=?F(J._F8)53K9\(IP)-6VQf;+J+NAATNP24a3J(
b>VFVX5A_1X=#QEX,K)]:/cB-IB?Q-IGHC>HSZ0K?R:E?CL7F&R-SB_4JL6R8--E
W][/UdA?dO7&WMO7K>.HgD5C_VKB=;W]?e+]9&G+M@F6#0>FI0&[GNOH&.+SE,QZ
X1F6G03=[4DRcV+He2Y)fXg4,\,W=LE0J4_]5_W_S\Q[,B1T-PQ\AS9ZVX+_IE.F
-5cP4ZQ>0dD/\2f6bF8LM^eTP<c0MQOCa#^QLYN(g]O1\S+Q6Y+P:-S^KPE>#\\0
SE[\Y+\I&KS.EcFDeP7/?b2GI5fQVPQY+#BJf>XF?(+VLg4+YbcG8ZJ0^U<87CTe
VNX60H;+019\TBFJ691AOM2G8$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


