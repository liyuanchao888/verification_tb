
`ifndef GUARD_SVT_AXI_INTERCONNECT_SV
`define GUARD_SVT_AXI_INTERCONNECT_SV

typedef class svt_axi_interconnect_callback;
typedef uvm_callbacks#(svt_axi_interconnect,svt_axi_interconnect_callback) svt_axi_interconnect_callback_pool;
// =============================================================================
/**
 * This class is UVM Driver that implements an AXI interconnect component.
 */
class svt_axi_interconnect extends svt_driver#(svt_axi_ic_slave_transaction);

  `uvm_register_cb(svt_axi_interconnect, svt_axi_interconnect_callback)
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /**
   * Request port provided to allow slave ports (ie, ports connected to masters
   * in the system) to provide the transaction to the interconnect for routing. 
   */
  uvm_blocking_get_port #(svt_axi_ic_slave_transaction) get_port;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI interconnect components */
  protected svt_axi_interconnect_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_interconnect_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_interconnect_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** The process that runs consume_from_seq_item_port */ 
  local process consume_from_seq_item_port_process;  

  /** The process that runs consume_from_req_port */ 
  local process consume_from_req_port_process;  

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `uvm_component_utils(svt_axi_interconnect)

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
  extern function new (string name, uvm_component parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
  extern virtual function void build_phase (uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
  extern virtual task run_phase(uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * end_of_elaboration_phase
   * overiding the supper classe to suppress the uvm_warning("DRVCONNECT"....
   */
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  
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

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_seq_item_port(uvm_phase phase);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_axi_interconnect_common common);
  extern function void add_snoop_port(svt_axi_ic_snoop_input_port_type snoop_port, int i);

  extern function void add_slave_port(svt_axi_master_input_port_type slave_port, int i);


   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** 
   * Callback issued after receiving a coherent transaction. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void post_input_port_get(svt_axi_ic_slave_transaction xact);

  /** 
   * Callback issued after the interconnect receives all responses from snooped ports 
   * and before driving coherent response to corresponding port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_output_port_put(svt_axi_ic_slave_transaction xact);

//----------------------------------------------------------------------------
  /**
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest.
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
  extern  virtual protected  function void post_master_to_slave_xact_mapping(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);

  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void post_slave_xact_gen(svt_axi_master_transaction xact);

  /** 
   * Callback issued just after receiving a coherent transaction. 
   * 
   * This method issues the <i>post_input_port_get</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_input_port_get_cb_exec(svt_axi_ic_slave_transaction xact);

  /** 
   * Callback issued after the interconnect receives all responses from snooped ports 
   * and before driving coherent response to corresponding port.
   * 
   * This method issues the <i>pre_output_port_put</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_output_port_put_cb_exec(svt_axi_ic_slave_transaction xact);

  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * 
   * This method issues the <i>post_slave_xact_gen</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_slave_xact_gen_cb_exec(svt_axi_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave   *
   * This method issues the <i>post_master_to_slave_xact_mapping<i> callback.
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
   extern   virtual task post_master_to_slave_xact_mapping_cb_exec(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);

/** @endcond */

endclass

`protected
+1WC_R8X>R9SC/a-gaN(L8[Pb:94<=YPROUHH1V]DS3C;2_EO8JW0)(<EE#b3E0U
QD5M,8d/2/<e)<:\6Gfe3g@SW:^.E@1NbDD?KXV9A,b._?Y\9fXb9I\Cf+VCeJAL
,-WFDF1DTWV+XaeH0c;S_V;.Bgc1&^1J5&F4[MSR5d&c-Q0U//2gJ:J<4IHSX;&N
TFJRb-bCR6=F@MT\OdCP\=J<]@CT=QdK_NLgG[[U8B3R1gU;>D]9->/:1+?U-f^Z
2Z\17PV0Q8ObP/]2HgPJ?]F88bf/5^9:WD2>WF_M0>BC0N,PQM:=QOS)2G-<TM0P
^EdeX+X:X+9\25gNfJc3N10d3.B)21AcB61BY-(E7?>a_gKOVQ+LLF5(H@H><CT>
f),0e9),2Y?0AK3CfFRGOBG\e6dg-]W(<$
`endprotected


//vcs_lic_vip_protect
  `protected
4B\#1EI56>;D7@F1e30KMf5WR/aO>I9NB]UF<W1OFDCW>JFd+93V5(TJ(U#SU8]#
?TA[C=AdG?Ma?DZ@dPT=QE<17aRX-=IE0dC&P[OO3aPUH./KffFP[beI-J-]>-8L
)ZUNc.1?g6#TZKNM50(/,YZg).a+,HgfWXTH0SE#Ea+PJ#82[F8DXbV#SU,ZAU_Z
dZ3>QCHQIeT:g;5(C0P5.LT[HV-aZH,QFQeIIB5^#:f1S=)I)<fZ(@;BHT)b;.0G
RA\I,]1UA\0W4cU6^@3A\<1[XAIM;=V/X3CL>Q#aZ9FL2)1B2>:0#b(<D6<\XbE#
Y6]4L,)9,)b4H7>??4CQ4F5PdcMXB=:N5-G-CXb3HA<[5ZJJ@(bCXLM0bG+_+SfG
1OU#:V:A5MTgDa;#fJ^^M@eB.dNb><.L+@eX5RG6./1K?_BHV\)N?C#Y)Q7<J<8T
I9b>)EQ.,;>FS20C\NJ)N19RIK:1gU8)E6-3?=Q8S10d-+WD8VDF=8CXD[N4fE1(
Z#EQS5RM##3:a1&,b7[KYfBVRG8=ZA(XYPWf]#DZcMf)gKJcafSC.&d?S)++M0>@
YXdATIP.CdO/[)1&;?9D#C]KP?&10<R;4EbQ_HeY_&SZ?\ES\4&,NLBPK.)6/A+D
.W\0-Nf9J9U:2K(>=[b/ec9CL6CRG/a;9::TI;9UTAJW9UMJ_<^Y<<1Q6BBYKL6_
WeSa0.[F,M43<?Wg5CJF<PNRP_0UM4_\?LN9Y^2UAe;eT/7,94R4H8,<(RA.5/Df
.&D(9ZH^b_\;;f489gU:Gg5P_[gN)#ARRdCTg8SBDJ3HL.g/.[:</0\.,87KM=0L
[YYYF3N]KAFBQeD9ZV1=MNKHdR,SASc71?)e_)8XY@/c[X=/.R5.E4J<-+c,ff\&
P1#H;(U]a+Y<I8<ab\W/^XX7J(W)\QeTYc62DWU^,ANOUBY7+^/^e36+1\E#)g8)
KIf+[4eIDYYYTL(MQC3BWW_#2RV5(T_?bg@-.PB4=#a1aP&6>E3NH9RfP&7M/1f.
RLDP=#FU9^X/CbM^Ya#=eU1RPcf_3XV1>c=e+K:)(G9Geg9@PKL4F8B_UJbQ=d_R
0Nf;_50L^E-+@NWD-5TH9cCQd[0<3JVT>#\+F#dOC:fM?5GVK(d:]R_E]&J[_G_B
QD<dU_<[5Q#QF-81&1(4W#Y-7B8.c:9C+&9&,b8(RD3F_2RZa<9#.78/MEWYIe(D
9&?REJ,YI9[Y6=N,gSC2HAFK0ad+^7_faX++4[&?7X1.M7:c3AbNb8d;U<I-&J&_
D5;3eMB(Z,8SfM/4VAXXOA;29<WbX8b4AR.XZY4R^7b^Q.?e.KX=eN&]Y^BS/4/c
SMAHTT_L7F/81CL\[@SK/EC/Ce\\3QcMB<1=2T3QD@ZaZH2ba])+(ZEX=@SgU\,T
P[JY<ZOf)9:&<15f:IPL5GcNY#]JLVPfEY3IIRC+-^X96J]]PPX&.#PcP?IF&EgI
IAHJM7\INfbd<d0]Za<Ue88<4c^_EB0#7g@\-\BWF?;U\6#MY,a,TXRO)MG3]G9^
5_7L]b[?0S2d?VI\,H9?8a;DKK,92#1T]OPW9P,(OQ+gDKXaO9J_9O5>FJG6^Jd]
K3KVNYW?>bL)[d9.RZ4,OBQJONI?3Q/?H/.^We?]_-8<VL.<,4bVS8?6.(P7ZVLB
PB6\1S&70LMWU.@([B:?8>cG(GacOG#IfgG[J;D#/5dH?#_TX&AX,V=+T7;WGA:g
J<T#2C6Z98cd)YRDIC6IPcF@5PI,Kg.,aI7e]cB#7(NLf=JP=dS6&<@2L(J2FM1E
AKaR\QG8>d5Rf^>dXA40e291e(MN[,b=#7\]0X#6b1T>3dAD-KcZ)Y.79RZG.3X[
N>YD5UZY^T+G2c#\_TO>e2K92BH5FFIOgMY4_5+9CTJ#QFH1I3:@Q1_A]GZ,NX9:
=:;#DPBabM3<YYG0]QVZSJADP-8\W4IG:\E>9Q-^+QA#H$
`endprotected
  
`protected
3/Y+H7W<4OJV]Q)_H7D,78]I&fe^:+JKMM6B]7F8Z/:#Hf,2AZJ_0)\b7E+=7I:2
VSg?Xf(#(2,V/$
`endprotected

//vcs_lic_vip_protect
  `protected
51_@H[aK?M0^O[/;&,6WB7.V]_gaZYMTOS&V/)J)<2G6Y86(\;8E+(QJY+TWgYb]
I1V4,aEK>CVaa=D>]bYCZ5+_V44O0_3^bDCa:^@_VZ#Q(?c<b=fE(5Z[VV(J9<WL
N=Udg/7?>1Y^9Z>EUE3B\VL.[eXbSS=B6K>@KW?X6JWRRL4\C+_O8?:b6F\Ffc/a
:ca8<HGSgA48QM^b)f(d)=)PN+X>VT6BdW.PE?BHEUADELG>:\U/JVI(W,S+PO-Z
GGN35KV)5UcRO)YC_)84&d^b58gP/_C:3ZBFY<Eg_YKbQA9QJ.1J+@I+]d<]TXK8
^DB9S1SN,TFTKY.\WD<aFJ7WT5)+e3a.NJ9.bG9CYWN;TH[PSXK2g8GG5@T?&VYG
B]?,<[a_RK@A(5&(+B&UG1Jf@+X_QT6cEeb:I^.2gJSR(VY2;K^B3H\>OJYP9UHE
0#/,N,A;XbdKTM(d=<A29Sg86cR@-+#33[<KEOa>g#@48S3AQ-;<Af#F^:g0FVO]
0KFUG[C&aa&T?XM&\MfZH(CA.0F@B;VFF;OXg2M==XfHHSH1.@(=,OQQJ<+_&5CU
,_V)#\ACW?@8WG5APB5g2,_WQ9BJIEb77&F@VdZV2gP2,O,Ib>)IQRe]SC8O/D+Q
H)=)SR<45dJ>@#W@@Z[.4Le\60205)4Cb4]>R?e31f75:M^Kb74F](LZGe#7TKRN
Ne+g7.T7P7J;:#L9HQJZ<6,47Z3\R_&JgCP,=D6d1AcUM9@Z0.Rd3c\^bK\_,GTU
=#1Bfc@fCQF8=?\+f66M^;eX\@+\</-E=FU3P[Y/b.e9:<PR2LS?>(UU.55UO^P3
.>DACKT2^0D?d/MaHRcECI=f#12Q7]=(L7e8;,@?=+I-4LgISE1QYNQ5LXWF3O5e
^@>XGNM,0d@_1cfca)KQ9I,F/)JNF\.dJ=7+-dP(3Jd&c]CZ5;CN<[-#/6Mc?=T5
U_6->a+D3SMaL1SC5N5;7]?M:#DV;WWIfL9Z[,]PP4[ec=bfW(b_VZUTca?:+-7T
a7DEA/#)W^?7>GD0edY5?8f)#Q92HaV(5L.##a9F@_H&_.@gO:PW/YEdW(D->T5L
fAI+8a>X/b;8<Qc(PcKX[HSb3cg;5gf^:N.RaB\GZ2dM&RU,PWIRaFE^VZT7;Y:N
gD3F<:RH6GGe3c.^-8c>GR1..AK9RCIM81+YE?UXP1+H57=&)PBa6&e<03UEVS1,
1R3S->2VedbUgJ#5-7FU^I6Z^&bLU&QX_e)dg_/bQ77UKC#KPJBKJ&B&<;:J;(4/
O:JHV5gHE+Mf4XcM(N]9=@>I[L8ba+U2^Hg_\A5P>26c/B4\X,TBT=e4gP=;a,UJ
TN9QE>?FG;+&9eR7_fLPfI5>gDZW4aa]81dAGE-)Za9Q&7RJ>O0H4d__eWbPPQVZ
]O)(\fWCC1SY>\\>Dcb1gd8Ad-/F96&4-/6bJTR9MPU]QN_3c)=SY7dD(T<@<TU?
dHN2HOW@N3RM4?[e=P]P9X#DD8^+39?ZX87RB3)/cOJ#^AcFK>SL7&,8,Md+)?gR
7E]_U-d36,_Ae.U1^:DRK..Ec;A><;\^0M7#ZPA-CgWS/\DS;3Sc(Hb4XE9:Ee,b
-.3?&6Y[/-Gg6G#\UN#<45bO]E,PSf;&2(N>f?:##IA;A7?V-C_dX13?6GZJ<SdQ
OCTXSE7KaI.D[d&G&H6)S/&FSTFgM\WCB.2:(f7B&+3?C?/C5__gW@-If)W6c3(g
57//PU-?A>A/P,aUTLG=L<&e\BbE&\.5#HF>O81W3^[--d&Z0ZV:>2Xa=31,6^Z+
:K?&MQ1O9,YI;M>W0YJD=OH2=8?:e@=#dER&3:)L()D:=VJ=/8K.FW\;B_TD+N?)
G.&E,V,N8bd@B\PW8[2Z<CEdK>)G&\_aY4Of@KL\C/_Y[WK)0dYWJ]+(AL:)L:eK
fJVdT-_,NSUJGX2cF29<O-a@:@OL,.76LV:UM;ZA#;b:=UbFCBafMg&c,<H<b5@[
4CaO_.-0QOX6?7eSMZGQ<\+Q>HO>X+#0Rf_I8O/dXENP5@dZ9Bb7Rg5ZNgK57QB=
D7F0=>F\0)DD-/,&O=9^K68.H_c&:WDXg2L=c&IEKK0457RV3F<)[82Sc<K8;8)(
75EIIeZcOZ?eF=B](VWdBe:b6MHQYV+;)Yc1e2P=Z<SNXe2<XHdMZ8bD:)[\]:2e
A->)gcQVfb63A4/I8JaIW[4SN7ecJ&1a;K-5&&B.::J5,)Z)T&2La=ELNeW><DZ.
1g/e7g_:a.46Q0WVMba?>c--_4D)?N[eEH+SgVQF)dPJ8gVIg>\>):W9T#NgR.0K
:V4TFETOJ\a4dO=2aEGL\5JA@bXNHCa8e8W@f=P,KaP=^N9Ea=CK2L9UCCA2]HIW
_eM\3gA<@KYe)6OM(4RfWYdDePP+/3.+8]WVb8@>aNLb&PVV81/-#Hf0NIO@K.5;
,b[[+S@URGZE2NJ&J^f-LDYRc#K]+CGMZ&/,&JB>FSCH?;(J9e;11(;>+,ZcCU5Y
8O?>c@fGg6#GbVJ6O;6UG@<#,d,\@))e#EAb1Z9/((@&RB)0=UX<1;]H94WGa;1f
eM;M.3bKX>O\OP[8?UL>06D4S^0J/WI@Ac]S\8(D5MZ0FH5&/Vde5\>Y@3&LXe.f
>[9B-b5b[0P76O[7(bJI0V1/gEg;5(OOC^,,6#9VDMbT6-7U=2QP<7TQ#W&_<eE6
&KgNRLHHEG.62:J2VAH[H30EW0D>\3=J5C@L#,SH3=XCWX+1aBBT&#O\GZgBc?3c
a(\Y&\5@E(+/I1/gUBC<_@2[=(Q+8:6]]^M,_]U;#fQF6:<?<Y-,>c<aVR3AT3EZ
a+])^UJW&<2?GLG[2@/3UA3WEOEbQ,@;a\aVD+\;,U+\PU2g,@;J6O/H+EG3JZ<M
[_F(aDa3./T2V#&3<Cg7^6O]9SIX5#1]W/<Z5[1LB/.V:X::Z0dFH?b#7P]Y6c/,
DS)XO@,-\:#?UW]X)/W9X7^H1AFMDW6XV=(0;Ge4<QPL59/^6YbJ_D03?FF0Yg2Q
.\@Rde(N:;WaE:aDK)SF<=THE>OT^AO+S8:/0g6HTDT)M](V??T.8+Z,FQK:W4[)
TPT&QW\TRL8.QO(BJ2cBKCJ&V]<D2/AQg[^/WeHL<Jb9Q6I_XF^,=KPL;51Db.ZR
2S8DYd(I9.]GR)GBF:VOee633KgPI>X>L5\aVY@H0@65\P2[b)BW::HD.IN)e=9C
aDQLCC=[?)0+e3eW4a7H/CFeTOL3#JbM@ZV/YcG@Y3BX?F^a23/0X]H0^&PPa(dd
ZVG=O<6XWdGL.9ADU16/.J]V=0YaT_,:D3[I4_.T7A,b0#<[:R35?N=\SgGbe(C+
9#<_I]fZ-_WJ5eTSWc[JM1.3N2I[RT2]J2[c__&+1XQ5@7;b]b(=5#3f+b-\g^2a
?YE04,RG+dJ3L,FSNG:If=eWgZfN1O[&Y#SgCTSW1f/>WHJ)g7_?GLU;1(Yc.gb[
D8X3DBO_(8>IF[D)ggcR_4Z@,)[Zc,Mb/7Q0GR&(T).@^4RHPC,QJ=3WcR7(_J]-
MX988;TNLAZF=/Za(7LX9&a#W@B\8P9bA=<#=TKH+/E&L=Se.10DN?_3YH&-OWc;
M,]/c_B@[3)7ZRQ,S167W8Bg#7--21]9\CUEVdI-D[F@66YV^1\e8Y5fg:E+GHf<
HGPZ9WVDfO;,;FI2T#6FK3_V9,H2J[Y73PK(/#7=Q;MeD48/NFa4;d7V:[aQ=L3\
DdT:Ra.ecbN((:fDYfE5IM9LcBeSXM(Vg3UMUS^fAdG6TZMb]Ib=K6aRSeQYUWAK
0JH-ZOL4>1[XJfCdQY];WI6-PX>B^P\Ta.gD\1Vg8G=f)NZ]2dE;-;)2]51RBE6K
2d2S60<,6UO/J_FXc&N6N3R\?@CQK\YJZ17X;O6[0dS5L=Y+MM<U:8(YRP;c3RbY
T(+ZaY:U[9564cX,-5RCBZ>6fd4M_@7Ef5?0DBTWFH],+fBFJ[Y+>D_>H8Z7_\RG
:1AU3:fZ]:99^N0JTaF=Y7SX[9_<^1e&TZ:8O.O_??;<&[JF49H8>O-J]O_L56C<
07W_I)3/]W]P7/Y:<2_E^R\A74F3/U<@])X_Q_CR9#Fa8/B,@_B1E0>F&=QDH-Jf
M=>N]Y5KZC?0Ug9BM;PHHNAVL-E#6gcRIPWA.SB5,:A6.Z+<P>J]:E<gaL9T,WN#
O9LF7UMF&<f]WM0J3bge.=8-7@bL.0?a\/2&XG=U]a9H)=<GKCbU+QM73BP:;.4Y
7=H>2c;gK(B^?,,R&A+]1@fIU>),K,]M?7R:HA/BPPSa[#+[KM>W>g[4b9V(B=;8
E,)-JV.&a/d<F[2A<Td<Z\4UP0J#eXOC6;JINJ>RX_-I_B(g0/RWH=-SdK2f8d@.
557bF<=BSMN:;c6J:;8@d22g(62Z[AT01#OdXO9R35=(dP+df:@,IgF_S+M-0Y=W
He/9P-?R932;:+60.:_d.O<Nb>8I6^H^O4)KY8A\X5^MX_?A/eW@[&]H9d94@3f=
/BN,2gQ/<RgUK0g[&PK6c+5WeL,)KMF&-MI0P?28e3<)77E466DNW-&Acd7)d+T3
6V54LS046KVTTZ(fJN+H]7/<043g3WVA<SUXWXA[W#5)N9O@M[ZZQW?aUL_\J(;T
TODE[/+>[XMYW.#gXW--8R^4#PODa@QE)4d1M#TC6Y9+RTNN>?1&=_I^]G>gP?[O
d>@XJ#c>f&UHB_C\D+AbR(?O/6QJ28P^RfE[<U[M8DOV4\LVf@[Uf=ULe]L/=A3M
c.=:&M3.HR1OWNXN;QQLdEY0P_FB(/@JN9DLW9]:C81[W1(Qfe7&GaM+VU(8C_H?
C0K1-#UUH]LBP13\)=MNUV[].HdVOW?(_#J+YS\cT)W7YaAKZaT=XG7-,S735:2A
@IAU;/+g(7L;F^7?/\3#5He>QW/3YTOab9=&;QZW3.-=Z:>,aRU(_]UIY?D?2UWH
Gb?H[(6>4J2R)MFcP(3QK,@?6;=\5/S:cRcX(,B&1cAH1C_[L[MHeP7:E=\KDHU@
_F&[>1X81<R^[)=G8_2]Y(#B;<KaE9.VUP[@#RQTL(#d5eIVE=)5HH<SBaR85DE-
&W-P1@5+;e8)Se?dMGW2,#F&LPUPL2g6?&5_/HDCeOVMd22/_YP4?f&_ZT4F@?Ja
fT2#CE(/f^(285LN2\c/=Ee9]2RN4V-DI3^2b/Z3L]@c,a(Vb/(?2NI@Ea>DUQ,e
YXJU45;<_Yb.aW>5PVdQ1XV,E34;EH)7-[#)N<b2NTK9N2MH9:\UT.bd194&dEXW
:^g.#9]<c&-,:VH10J4CAeAT1UDSM<.]^f0QU5C[K;ZU_Cc)6b6I4b]HA[6N\HF^
IY6NX1@MfEZ>DPfNJ_T:(F;WWeC?<[;VK[[L?Ea8>?8,ZWb:3D67dO[D^6.YM]WP
&N3P;6WAHXEa8,-:P>WM&F<I[eVDa;#87T=<(:);f5TM:X?IN;>6U5@0cccO02Q[
H(-Vb<KB^;W4G@@EdGPAB<04_WR&4KENUgbERR/bc3SXc,\P_3gX/WMfN:X3O?ff
2VK&8SY:d__1Me,d?[(9>e9_M.BGBY(5O7&=IR7a;,JGNX:@Ma6,=DC#&-<,ec&;
D>-[V#@eB0=(9<H5e8&eMA:5?I6:#K]\M8Kb)>UC(g_LU4,[2Oe#W:VN>C1/73(U
FIGVf2\9?Ke38d#<:3/JB:VWHTH97f.3O-Ia#_6gCY3c^D^a2.(?P^DZW5?2Y#<Z
>H?F:B:G[MA/IABY<FZ,@ZAW)bLEEW_eOSNa+e\V9=<e4d)3R/Q=,2fE91(&</8<
.&].\./b&?J)ES@VW7Q9D1<_NY8LAZX//99Pe&O8(^V.^1aN#[RY,OBZ[G_QUd6)
-#Bc7f>Qg0(a;0]cRX/O)C>OcCQ0@V6SCW4Ca(^-L5d457B2IH<c^-+L<019:[TL
=2:S\YK)_<3<eR2^BQ&XM^XKfE]#cD5R_2:(e(g=OL7XaDYN\B9Z^\S,c1WSIPg#
aKOPF-B6D?RMgRA;\FRHJO9?][PG]=6.:HF_SXCU@6-M:^H&/UHDTc<[af7DX;_&
AC]+BbZEa2DP_C=GC9JgO3M:Y,E[(73^P-ag_:98,X3eJ-g99_S?NBY0e1L(+0eG
;f+Ua;II]LE;5Z(H/@YR:8P1BKK@PL8F(?Q:1Z/GQIe)gG4M?95)^(GI)6acZFP>
LWV;](=A&8?<Og1&[NCcS_f0#EIZD\-TTH&23+GCL,&1?B(-VI^)GFZ.Lfb:O.CQ
b7OD>;YgM+-[4+/YL\3Sf,5AQ=aeZN,)=F2B:LPI9GLS#4Y5ZFR&YYaW]@Z)+XgW
=SZZPI^EU\<.INeZcd46fO+3W-C)?MA0N^5?@4&5JS.,+UE1e^<_,Y+I9X^?M=DP
&;BAJN(#:J+RbCYYPEPU\+3\J8R=YPC0<(6]eRdB=b1[)PRY79cgbC=)2TdRf[3Q
O-O\f1;=3^7[=0KU>E]d[-#TK)36B];D#T4&F/BMITeW#C4:L]#]_ZRa@6#Eca+)
-;G,N0,^JEA(KGK:)6ST.D4,LA9E=?\.JD8GFBK:X:)Q0Vg@]QLP(#V7>WQ/#W1O
4FEA(&=+AII1Y7-,c1^3-E9N4=0M1;QK\:e#+>:caUN22.JII:@gO0[Xcd8BHW;:
9cYMGN1>ESX5gBY8@5+IC_IE8VRY#H9ab2<H#FFMf(U7H#MR8[;X-_VP;B62LW[S
73=E<W+XYY[be,)LRG(QPKb]5\7ObY4R:3bK)Od26[MPRTMcGN8T1/2edWQV,gGD
8g:ZE.KDF0SM4Zba(^g[=1KbMOcRX#>@B[\C7eKf_4N-Q\DH>-YfQ+D)KSe8I/?A
Sb].//97\#O+=a-QVF^gZGXLgDQ^UL<&,RW(2=XSRPcb)+YJ0[U^H^1O@40Q_:#-
;X?N5[ZfA^F=bW+df__C=AL5Fc2+RQ/Va;KbK<ZS>:Od]M9-0c-D-eJ5FLg0&3aL
=T.VdR\RX06e-L^D=BVF@PK\:&P.96)_G>dW>gaM[-E-gS+;71(g]JX5&#4Y:bPc
>?6DgPgCGMJJ/gOcJOd\^5=YS+A9YeSe17-_Ud0bCFL+_X&3+4I99_=RW,3)WPY#
\6,@;/-,;^2/Q<6?EP-cHC,VNK;2Re0W^0d73/I/_0CPI[egfcdK[)PH/aOaSXbE
L/f&\J-V,CQ8&F/U#>&;PYKXQ713:>QX.2//R@BVCFCDN49(M9ML8;@&]-73XAH7
Z7ND&#fBJV\QJbVL#4VV^2db=[NDDUHZ>c.(&IgJXU1I(5PLF_T\]MbKRebNZL?V
ReE\c[)\fUY^7GLQZ@M.B]DBFAdWAU:ecDLb9Y]Mc6HD)<#XM:1PLeXPM+(50W#?
-b8c2Jd[?ae[0F@E+(^G[_[HL)T4Y^gS5/V^>Y[6?;KeTg@f5;4Kb@aK0KW8[5#>
F>BYR1&YW&WCG?==QV4]GU2V?B,J?-LbaVec#DR6:+5>&#00D4f;AUPQU^C0cYD@
Sda2WJC25L(RV#5-B75BBB)Q.+NU5G..beBBEO6)[&BKMCQK57,O//U+B\K8<a:C
@EU\9f8BXD5)-U;aMF:]feCaWC^^2e8&Zf6B=F2PW(5V2J\C/.R^d:B]9V9(4MWQ
RR3_K4VX35^1+d,<M1-/_D>6WLQP_CU0C5#We2MU(:7R/+(g<GTO8AGSI)CS^6?K
_>V96JP9b/7PbX+5X)0ZOdb0f)6d0MPJA]X];g@TRJ?8SHRGa.K6+O/T1.4AB-b7
FUdR&&9A14(\KI([3.X&^J+RI#gKRC3aLRU2W2_-DZF5SD-<QUG@&:XNWXP5g_M.
Z.2Xf0b(C_3JL5RWFF8?(>A8K^@WT-R&E).55d(\a;OL9-5YEIHW(X+6#d^Y2X^F
76dEJ-gYa-AWVCNINI<YK@Q2V8B)8gH#9a?AG4RQA8UbVbO)#Z,K)S0He@ZASb;T
Je>TVV[D9#F&.X^#PU(GX4ZJ+c47)LWJ^(]g9(S9I[Zd69+=[_Y#XWT[g4/I#OMB
<4VaN@&ab#,/[UO:,;gC71VgALTQL\^,bUZDFN@9816=7JOOa#919[G>dR?;>)/L
cd9(NJ,)fO0)-<365J8XH(:RWg.XfeI=<]CT5GW(PE1SM1ECVQ,(#.XBO\=9]M,2
[@L=PK]RR;V-C-UN+QPWcI8?)<5X?T<+\01gM@W])+^R9bE/COHJ-]33B;V[0YbU
BJ8g-Q:;-L@01;U+EbMT8S@]/:;_MVG\>4]3d(T<I8,.9S3[b(587X^<J;W#.Q)?
=&e<6O1L1G#E6UNd<^\=GC?5J[3/NZeN?NTTL]a0XdIGeD&=XP^N)3Y2&NO+KO[a
2<)S[&^Va>#T>(0MQRPS>U>GO]4R^;FVdC2R+]W8aS8IWe5]->+:<.5e^RcJRHE)
G>1?YW>#(,5[7gB\Z]7\OE67D>BTG3V4TE>(CJ)8D5P?(LB,TE@8=]A;E8H74d)G
P4.;=P0#W+\=N&@e/WN^LgHA<RDUOK;Z0FCTYK<,P6/Mbb;SN8B7C>=NZ#1X<,V3S$
`endprotected


`endif // GUARD_SVT_AXI_INTERCONNECT_SV


