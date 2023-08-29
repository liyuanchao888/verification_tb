
`ifndef GUARD_SVT_AXI_INTERCONNECT_SV
`define GUARD_SVT_AXI_INTERCONNECT_SV

typedef class svt_axi_interconnect_callback;
typedef svt_callbacks#(svt_axi_interconnect,svt_axi_interconnect_callback) svt_axi_interconnect_callback_pool;
// =============================================================================
/**
 * This class is OVM Driver that implements an AXI interconnect component.
 */
class svt_axi_interconnect extends svt_driver#(svt_axi_ic_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Request port provided to allow slave ports (ie, ports connected to masters
   * in the system) to provide the transaction to the interconnect for routing. 
   */
  ovm_blocking_get_port #(svt_axi_ic_slave_transaction) get_port;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI interconnect components */
  protected svt_axi_interconnect_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_interconnect_configuration cfg_snapshot;


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

  `ovm_component_utils(svt_axi_interconnect)

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
  extern function new (string name, ovm_component parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
  extern virtual function void build();

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
  extern virtual task run();

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

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_seq_item_port(svt_phase phase);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_axi_interconnect_common common);
  extern function void add_snoop_port(svt_axi_ic_snoop_input_port_type snoop_port, int i);

  extern function void add_slave_port(svt_axi_master_input_port_type slave_port, int i);

/** @endcond */

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

  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * @param xact A reference to the data descriptor object of interest.
   */

/**
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest.
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
  extern  virtual protected  function void post_master_to_slave_xact_mapping(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);


  extern virtual protected function void post_slave_xact_gen(svt_axi_master_transaction xact);

/** @cond PRIVATE */
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
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave   *
   * This method issues the <i>post_master_to_slave_xact_mapping<i> callback.
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
   extern   virtual task post_master_to_slave_xact_mapping_cb_exec(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);
  
  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * 
   * This method issues the <i>post_slave_xact_gen</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_slave_xact_gen_cb_exec(svt_axi_master_transaction xact);
/** @endcond */

endclass

`protected
,SB??^IGe^/]1K>\G\4EQG(:@XA^f<QaK(>AR4-?^#K,9MXVeOE\+)_XPgSdTD2d
8cSbB:XaP_M<<Id^;00UDZ2]A24&^H)]OA9SUA07OGPJ]ND5:ZKICP3;g79&6T50
a&cZOcTTR5-P8PAUg20bP7+96A3),:]E_D(1BDO(V85+-Ob9Tc@?FPFI(UN0PNd@
H9+7^B33]<SgR_-@)O3_0^-<f[E#aE@(?[8&BC6ceCeA1+U<A85O<.HB65:JN0WU
/<R+2P/LU,dda.=458fJB2O5@O[D7J)C0XK=GEI7a66]PH]TTEZ]+OT\HV,E?K^U
+/=9DM0Aa73])UU^9&HC?OX:HP#@#BC4XR?>&SGaZWPA0_F0B2J1I^:6Q[CYQMHB
&=>#.-V0D^ZCXd;<D?V?I(2IN-NC_1[e<$
`endprotected


//vcs_lic_vip_protect
  `protected
F((83Y_/A[@;+]A@a494d,4aYHK5.cV,JRUV=N1#QI9eK(6CdE/97(PKaD]]WO#(
E9AH)7,2^BP;]\@Oc?O(aHXECC@(6JNK(E.OU[61SY9EfL9b90WAE(?JNc^0B;8U
WHC?P[c3U5V)Z#B3^SM5+OVgO-IA;_]U]2<d(0W?,BNEe7P?RgNX;HHcaBDN6DA0
3WdW636:aG6&KKe<4(YJY1:JaC<](N)G\SLUfQcgaY@.a)BPf[W@O=N&.R&-9V<9
<RJSTFM],7T;YG]/,4XK>3==,[;-0[0,Q=(b=&=@1QIc#)dKf=[@Z>8D0L51A;R9
FdNdHN&)@_:Fa2&7PMIQ<8.2RggL8fH^1+TQGGLe98a7/H?e1\>Z6A(0Ae\VWR#N
XbVG^d&-0+,0VK?T8R&,K(RaVaH59_W;[#[VQJX-XYc9H)F]C5a_A>/R1(ZF-L\-
1^aVe+b3<=CH&\K>U6YQ>I-M,IKa4fH]K[W@Sb)W[@0bK2NK=R;6-YfRBMPTa>\a
V2f2W3[bJTeU[CaL9E42<G(@?c3Ed.6Z<cJg?OZ#_<0VO)D)XV?O0+UfO[[59#<&
NLZK/#7WYRA8eS(2V-JG+XKebZ/MP=@JL&T[RT#B&(e/T=9])S]7O+UEVQ)VG,>d
S)<d-3N&WJYTLbb&C:<KL(/C;bRV;CTXSO-Pf<CS.SA.+M1CbNICO[C5f#Z0Z&9d
D_1Y.S9M,I7>8R2:ceCCU6@WN:Ocg_&7_9AUTQ\.7-KQF7Jf<DYbTGQB-BdSA@g6
W7K7>,H46OgV05#O:^.L^)F[;c#:)OC4BC<cTI=>0?bCU&fQTaCQ@Y@36Zg1MfC1
H&..@UYYH:N(>^,NUGQ3:?TA,[=4:>WC6(#1E\RNZK^577]WQ_6F@4B-^E/BDW[b
d3/SN;;a8&)R88<B6^>aZ.0F&>W;SJ@HP/QaM(3(0K?S[DR321f,a>ef,e@FQE6)
A5<<d4R:f1VgVPe,=8?aDK5e@1@4JCTGe=XRS-QW)1D:He;eQW\VLb;E4;-HW@EU
Xb<KWI<=>\A^HVY-8/9W>RKcGTJI:.cMFdO?3VOAN=c#0+??X;aZ<0:-W_B]eO6R
83:JC^9ZO20?\H<7\S#>FXY)d^(OXf:O7SJ8BMeC?E9^Ea]#5BR_BcQM^=P(-X99
fN\_^CD5Y0H@3I=<,Ad1]HOARf:2Rd,()Y<b4,+>[1010U5#MGf)V]6++_YU3ASL
9Tc-N2U5e#a9T=Id7>8;M>WF+7I/B>@[0B-YS?-\gaUSdHc26?K#OHX2-c:0Ja5g
P#WI9RfOe\I@=E943-56Q;L>,7PD@5PE>Tf>4H3I[(MdF,(IY;Y\06afKH9YNS4;
W<I1@HA:S>+-VB._5,Sd3,ZMT/50R\Q:(X,KdW,W]>U_AB@PN/Kd6A[FA0,8g(OL
L#M_ORS>T5^1D]dSFX>NfH=TEgKOC1F426c5;8^G6]QL;1gM=?2-0Vb.OUSYaY3(
GC/Y?=g[gBC6Q.ZQ#AKCPd_D^a=c0^A6-Xg^1=HNgMeYNL3^1UA1)U(#TC8G>b<C
5)2SP5S9,.8>g\:aPa^-3GO=NfJF?D3Ie@VKCFa&\Ta1)f(D##GSJB(-D@Meb@(E
de-EH[<SYN.\]74d&0.2,SBTN\g]<?-H73C.,&\1JVV+E/8F2TE?eKfc=fR?ZMI7
P1NL657@C12@CP>XDT?TOL?(EdX>Z+:NT/Ta33U3Z]VcI---L(JGE(&P3KE_S-O3
XO^_VOBHN1VW#A<]?b_64B:Y@IO4.N?9X6)D5e(YT\Sb/<18^66?9JRS.d\+f?</
KeCI?2gLLHXW65^4DUTG)]0FR5IES6AZd0;J5;Q)_b)D^LJI+3ce5fa7O.W#MVCG
K;UbJ7f0@K_<+0(FM837&RDZBKL,])[VQ\.-ZD\2J<4-f/2&#@V-1W&:bdE-4?^I
L1ARA(_K;\aG+-J.Q]3&VZ?7XaM>#3;.5UdVCBHV5BEJe.Vb[+f/2LMGRb+Rb44,
BF6J[RINC7).-M+0M:>UEEC_>X6K9DZMe,-7+),92YJF^O#eE77Y=CUVA]]cZ7@=
KCJ@HB)\[afU0DFD.HaW&YEga+O@@McP:$
`endprotected
  
`protected
8-<+I@TSQ3Fe[FJ-]>&c+0_:^.Q/M9UX>]1L^QWDLReTa)6F7T]-))1L6GFM-BND
4bg7_Y>>]2Je/$
`endprotected

//vcs_lic_vip_protect
  `protected
]6PId853I:-#3.DNTJ.^4>;Y1DXD9E2M[(Q+dM&Qd(-6e?;E;LaO3(1IR:ROC0ga
B0(_DJX]-9K)Af-7@-C/cAT&f1??fO/#Z,fI3^_+N^9f<UaQf\YX8NVe\VbQ)]P7
3DeCb4SLN0eH6d&056/b[cHBa3HLS><QX_RYGG1]GMFaH-=fE0^e@PYe&OR?6a>2
:7cD+S?@3F#()F1GUBB3;T=cFV+69.?>dD1S84K@=b_2^U8-L]d,dRKQ?@#YP(O\
8QD/94GR<+9I01J?HWN&V#aTCg;@ba>-bXZWA-I>)MZ3[YSMK.7ad(E-X9JO=;JL
YJWO=1KNO_S<)._aMBda\Xd@I;@D,>V58>LA))d=PU^B+P)DMS^V@WWdZgXb5gZ2
9A:R(&1+,6&\f;LMZ\XY.0>.GE9OPE72(fP<08=ZIC>dEZX;GPWa,4B&OE-g?[2a
aI6ZR/,]MX(->AG\0=0:#g[c5LbJ#<\M@a#)1^-]D:^XV,G]7ISH>><\P5\L/:PU
,b(c<M_O>K\^-B4/Td(.XX4)7F#8/LE]YJ[eB1H<[e(^PegTU@M;RB-F.;]MK3eC
AX8.J<.CX223@710DVRD)8bJb;LDFdP@-CX_P6>,JYC=TXgF/dc4V/>2DgL5ZS?#
Wda/Cf.-;MP(g-DeADcMM1P./KWcFOJ,d##S[M,<?ZQ&2#)Z&(e#FaC1,WaNJReO
_\DGSNT+GfcPHb-eNQZ+[K4;_Keb2CM&M,VGW3C63\V1QYfZV4>3;#A/a,;a=A:O
?Y^-,:YJf3bJB;Eg9D1&eVDg-5Qg1;ILON_BdU^?3<R]GM]>bW)PNK]68_MY)^FH
0.a9K^O[c#,V,H?1?]9RS?H,GI-8#JcCQBb)#3CQC;,-EK.7+c;.(7F^P-FS.<>\
V1V^gcJdQdBW5?=aC3VfS?LJ68=>PUJgJ(f,8T0&D/f82^8&=N=<13VL-6G:Y0b7
Hf0GB@&N4)9_51cB@<+H@HaVV;G^/cL-a2BT?6L0G7[]@0Ka2/-KKSJ,0TLTDS_V
JQ]YS]gO0OMNVMTIO8EN3P4F2C5&&#,_]gKZPBGM6bOY+_QK6BcL\4).4=]N6e,6
4ZAKeO)R)BXc=_>I&_IS]=R/I0[e72T2.#;[5CVXB]V:T&;<;0R5BHVg=)RQ8C(P
:/30EA[/Ga.VeeUa:QL0Ie,L.A#?Hfg]BX23YL>E5GLCUcV]@=D0K2<gL<cSHYND
2&>Ka^J#J&+D@8R2&;0ZRP1UC.CcLf-UEDeC&8PAg(I#cfEMgJS5NI8F?#D,c^#(
<[UKHMLP&-7(F85,G,QT5_MW\dHT51dKQgRY,>cdg^If:];IAEgVNXD:c(KdE_7S
4]5SV6#HBSREe[D7T.7?EATUc(VE42+E1T9.#cA3KP=Y:Z.g8/NX8\_cQ:Q]R_[;
Q3,dA6[9&CMcO0I[<>R0+L]-SFPcROCGO?0#W3>M.C9HI6_:RP&<Ea&X8#RGW4MK
5Sa+=,CF1RCGfMF4f+GXNODT#+GW2JYNR[1RW8G5&+:dS7,eE=1(8VZ&Y]2G+7;c
Wg2B?1ZRfQa227KLHO?0GZU/JCd?J6fVWL9MZ(<BYM^R^cMc7=64Tb^[X@(]A1[@
JJJRA7[CO<,[)>IPZgd=,b]3Q0(2K7U#cOQ=>Ue[3XK/H\9]_TV+Qe_UW0:8YGg_
G:\FUa&OIg0SggE#0fA7g9PK<d74EQP_4^U+AeFa2(TAG9e=+dA:WG?J7SRd^(]5
a<2BW16gOE[4QCS)_C;<fb:c#GGeR3.,(a[#]WB.]C#bK72OLV3F7gOTG\^@F,a,
[-L0YbSV;dWY\2<)c==-(;/.d/#EI-2B,UW/^c[4C(9F@ag/=K1c7J^X8c0P\\#2
Xea08PWZ897.,A#Z3+,&.L44f8HME8_#^[0ZFJ^8D#/P.V:U3D[g7_LZ?>a(8b(,
HC80VaDWd]TA<7#E4G+#T>?JX-X_=Ze5(AO7e5Ag]UYgga6eZB^:f3O2;eJ[UbG?
NC^[#TW/Q46f#N9a6ISOTQb8Y7;^c9=B6.)Pbf.P9^FF:a=:VAH2]F<d5NF31b#a
D@5.;EaS_F7cDW^7(F9+D.5_FScNQ82f[CR9W>+RG-(F,U\Tc_;U.##Ka<R0fF5[
:fUZPIGQ/G(V]#CNIeI:51L&ba#V9_XR_3c4.O,YH_4>?:>T6b/M\6D29\(,Y[X5
,9+^e3?N(MF/&,+YGX@>P/Oc29H+I2:cePW5C6T;Df,L\f4R@N]Y57b;LS\2,&?_
0_O<WCaO_BC7A998;X&WE,)VI,TT@42O&ZcGS(ESC]ObB0de\V+MQ;>]RD61)f//
J(432(.]FRGa#^Y6@GI\9TCa<-#64F7gX5[1Mg_,N+<<:K9CZ-bV@RROVUfP::E8
EX+2MEMS=MFLSYZP>(W6.;J+TMAAdNcO6F5OU=3^O3bDC4(GPBT@]JD^(SX<=K@f
\_?F2/==YC(9TBBd&7<a4LcO3P0WD_S-4TSB:CSSW66QT2g>\KM&bfJK73N\Z)bf
8:#@bTRCC1C3K)TVJK,T>\=_Y?-F6R)[gQ0T_d8AUK1EN:;>YJL^2[[H#PW(A3.O
ARg0b1G]KP9M)^\F@IV.UA^Yb/ZCL4L4^bG8XCO(UNU#7#0&PbS\Y/NPJ@N9J/5_
-);0fEbZgR@W20-G=YJ@39(D\g?/@UH8W?FH&/-YXgQW0Hg_G_5QLJcZ8ZNV&KSI
?/+JHaO>\\E6\fQFTV[V1^3YCB:/,a[NXC+>f\MW3Y4ZBf,ZDV7/Z<[)]Q6<Z(RZ
KfUZ\C)4WTSc\2XUb-FX7QQ.YVQ7R\+/\.eM)X8S,[(fK>/X<Q9aE\;OJ6fd#H57
]NQ?TBMIcX/HHF,fC(S,IFSg>N]&FM:N5dL2A/40eA()#QUaR?+^QeWdUK/)bC\8
efQ/Q?92<357EAM)QBPL)6\;a]eQZ3cc(36L^BJ9-#@OLG0&9050W6@UR7)LRZa^
^7_4<a,_I8AR,;QcQ:IOCBBZPSZY>gLEPN>95YU78_fDVB^;FK02#RXN=4C-J)2f
?.\\^/S0SJe?<7GcY]4@=8bH\^;+(,8JI2b)cLPHbIe<I>]6H\@^WcQ>K0GCX#LB
e0gZMIOL61S-2\257J,cB@Q>Dc^cZ@EA&<[<5c70V10FR<4[daU(]1G2gUYN#=f^
;40JRCIJ0_W[6d)=&R:2>AYAbLg0^UQB]Ga-?<G5b813K+;f4Wa2-_>b/d9NMc_=
b28(P;3/13_RLLAXa0PYg:e?/LMY\<0U21BeF:>;0_Q[LIM>F+8;3M7BXZe9?M;_
E5WD@a=Qa6<R+><H>Og4LZ8O9Gg;[1].KQ]O2OH=W8GF/QeA<\6Cb,V^R0#Q0.bF
H?D)dFQ1baC>IU<aMZUCT[&]=F=R.C>gC?S/9&;91X9IgGWCZQ_T77<Q&\;6(59O
4,Ob,O_@+gW-e?:\D[7.eB=Sb]MBf&1]KEKfa?WM]VFCY4B0ZQa>]31HVX2#O=16
QG#&YHX9TT;-CN+S\2-d?SH/81IDT03/?21I15TQWKRCT@NcJC1QY9DFY6:UZUUS
;P40>:F&?0L;DP3#>4Jg=FDUCT?>WS@gQXXJG?9/c^-EVJBOWM<:GcREe.(#^F6J
gfOZ6A)3e6g6PPOWAPe(2^aXM7LWSU.[f6B9D195;(V^H\EAR1?f(M(I24HGVUdN
(_W4>a:XU1CH],=FU7U=3SYX?5O1S-&f@_@AGg)54+0WS-Z<>fXe3ZUG@Ja7fTe\
?JbI63#;KC/&/dS-IN&)Q?=F-.-7<>P^g/78gW_@2(N384cGRQ;,F8AaE>.]>F<7
LS)0C0A5P@D1)8e^1/)[@Y1cQ6ZT4UT^-Y@VcP=_Zb21\[^C=(Xc&IIW1/fWgQgN
>W<]dTdU3?NDV1]T@KM+VZ]0TB,(+d^EVZa<\U@PIL/I^8a47Be\Y,/STYfJ0?[T
beHJU)8RMge7:ddLa=(b-g3T6_BVHGLY[O;R5J;VXOPX9.G?2O\@a-+&9\;DYb?F
HbXDLD2[(KF,]2:E;U6LND9_I&B^KX&:A<T1VW^gQ[@/0XPPNWZ?FC[5,U<?]\^Y
>&[TL<7NLH.]bWgZ)XVA:/U=(O_@aU:ZZ8]QIYOa#^FFR7)SJK:P<Y]cGgD]UIR\
;[fN90ZL)5G#&#SRC/<,:6:4ALDFCP[G7AN/:C_B<(aFdX2R>ER]bWZQ0=QQ_IYd
ZYS=;a:&Z1Z-F+>@&\ZNd4c(f:YK8@O4Y^OYJ:+ZOO\0F<G@=f_2#?PBO\DCDC5-
J1K&a329b>FGQ-+K=:&?3[gcaGID9SY>5<7/.\;Y:8HX\R23M2G#RC^X.\B,dGGA
<dIEAIH66N5Qg9>f/]Qa+?HX4/RS9I=D^JG:S1PVDbJ_Z?7KIg]X#1K_?-J&@XTe
0I?#_T_D58(OffV6]_W/\VR9#(57Z(D?T>FCQQ_I&E(6S(AG3V(S)Y[-QSE.9WHA
)6ZIeN>_E]P>6:ZOW-,\X8K<>#-^VEF[G2/,N^Y=76LZ+H@W>-8^;\E_1\GL)0:9
<0W22S&PQTT0MMDc6W8&Ec]c[3.1GF=Y)_IFCIfFYJN-XR2L:FE;8[@7M/[b680T
<#=P/_.^.7+2UXfJK0,OI)J#6KDR\>#&cZ?C#8XHD;FAD/M7BG.YZBY__\3[X/3F
7;gS>K(g5[0gYSc[0g8fe7P:N<D.SB;Wd]27QA=F=b4P=:+0K<.VF3IA_4CWAD_V
H,?#H3AZLVPGWU[I8,T,a]#U62)4>ORNLXRMgHOMa\^c+1,5TY11+UffQ/X6+gV/
)5#NKcgYWAQ&9>Z<9eN](R);&1Ld6V0-)OY?F.eVb3e@#6]ETdPNbE&;cL_)8E=M
6L7^EPE;3e6W.gA64ARbbV3DecDKJSYG&]A9KeNVd\2_U//I9+TZ7NS_T__UQE()
12>[X+-E+UA>2H;;]GXWafY5MT@I;I\U#:IQ.C8[,@BgYWd66=_Efg_:]2<EV4I2
X[KM=ATfK:U\?^R&.;2E)^=0(K?L#/^TbM>L8=APcGH@D)g\\8RHf]&FbK].aT;&
HS_E2E,-TCa-;CLHB3QFLg3f&1TB-#@_+d038Ve+:=I?U9gC&S?64CD_-E4ScFKL
GaPRSAITN^/1d+b#6MbOC<^Xe.KK.&0+#KM<R\0B(D5)eN9FH:bBDRHbHW[9_RJG
=-Q41/,?6.?YDF#UK/<0)fLG7dMLeAA>GTFQN&f:QX)A\(/S9)^1>5FaPA0c_7_f
4]bSG)cWgXY#b<EeYec__8HQ<?2]Q@Nce#[@KbF:GZM88UA(0<RCcaOd4U+:ERQ;
<@Y0>]XU;VFOY:NMRf_:?dS2W.M]L]c+dC8):<]EG40F8<DZB)g_&Qe[e40#@-@X
OTIYbU_5Y^B=aZLS<B@Y\&Q,-8O4-(UC2XTBRSZf@C385&e[g=FI.?BC?L\DAE==
R.V<B=BbPgZ]WX.eZ<B8+34gdH08G-.NY^,La#B7^IWKQTWC20b.;KC8d,162H-_
Sb0O4=<c\E\.bW:eU12DcM9T8V^QJOWW/1Gc;FeZ;f#IYI:O(:21#UU9.Y9_NQ+d
4:^C)_K:39(8G[<a41ff6YGLM=U22A:ZQ/C&&c3Xg3(dQW,eMU57T+MTMF^fEY\7
6(gX<GGB5bX2gI.B5#C7XcBG7b5V,3VDARAL9S4]4K\MX]-7)V+IC0F<d)8;P10X
dDA48Y?ZV\1/b-5><DefWP9G<eJg0,9K;^R28?74R.8&M/0/DJ0HW;_HQP0N0J<_
^e>?@FVA+dZD#.?@,M7BGa0HaFT,?A\O[#OBeXVK-Z:H\_PA633dI=T)b[IPeA@d
&RAK#;OE-R[VZRLGB4H.ZM@M6VYJFNN8&V1(EY]a]<4eR3(6&??4;&Fa5Ng=@7U:
e+Hc1bN1/LY2#UTIPgOM+7(0)HO1EE6<,0?-B3:=4K:@3A3/1H:[PQVMe=-XPc=0
;5dF^]&QNd(:?e_(I3U5(RQH>QV4\fFB4/^:aOTT-FW.NI,9@IE89I9fG3g(8\I]
C]fUE&gI/g\X12=^dA?a>ZRXa()?b.+CCY&DXL6ET28(LV9D2RVXdagO]5M0:65D
@@OVf\\Q/3gfY?O5W5?046Q6[8g]=L3<7g30D^05?bc&@\C0XdJD,;+[10<P4O4+
e.(4a@4OP+/87&39.<-\EZKJM<\)=)3O3+PfD,f-&E>0N[+H[.>1=[JCBdGa[W9J
<Gg#4BSS@Q;U(D9Rb>(.:c@JJgV1>8ZIALLdPXg];I;-@PP(4bO<Qd<_A+OCG)>e
KJ42,O/TOHH,,Wa7?.-EPJWJFXVA@>C8N.I&(FcF\[JDc[3:0#TeZdG8)2<0W5.]
g19C=_>YX=2/3Cg</&<=1F_VX/[&99MMc[;=<?-^KE8a#?;+M=N<X21W0d)FMG2Y
C@N4&4d6e4XV+9JVJDVV)>AWbP5-=Za[_OTcXT+_KGC-QgI01aA:[,4641g4R(B9
,QVUI8c_S->C\HX^@gFg&+</f-gNV_C_FJQ:EO)I<RBN_?,5N?1Tc\V#S)]VP#B_
/Y7XcIP+ZL<_C<<M\[<\)][OJ8NXKdC#Tg+)1f?#Q0B&e:WJ&c0H=/?OL^=;0N&/
82.Y,S>SNF_2^bQ,C[Z^+LK0@,NCN/?BFcdNCZ-58,U__GH=-Ob7(]R1@Bc.K-\9
Y+<b=V&&5b@22Me1gJ;Y;c.e^^0K.\A&Ha1_TeGH_JH?^GX\ZMS\Y)8Q.=M,cTV&
/LF&aK<>gLg>5\ee9Y59/Q/S?9^9RLF5RSR=]Dd>BDP;gf>e84NO+5828@>B]^]2
]8PLbf/9.UY1cSbF5/S<L1&/(T/9Q_#:g_(,&aL0aJRH3g:W;UB@H1_APbd0D3Fb
)Z+UA#O6.e,S604]O=02&a2ETO\>6?gJ0]\)M5/K&G,0d<;VbggYBRe_&<&JW:W0
<1NfWA>_RX2:[ZG^EL-dEZ,b[@gXL<(I+ZB&HYE<4U_UcXOA\N0AXgb.cbGAf9R]
+g+4/W[OBU27c3/@.&9/B[+cC6PFXGLd#3<O0:++cO2^d+J70<Veb4C=E-ZaJ)-=
VITM6/>02Ad[K<VYQ#PT:M=XcS+Hf#Z=;Yg7YfKD[:EUAT&\XO9JIF13@<8+Nd&_
(I1;KI)<0ZB(<#+RdE@^N1AdPLMf8bZ-e09VESEQfW(,04aVH/Z)M__2.GRd9e[Z
^.-M_O,gMA@Pag4FE:M0F?Pc[#.>EA[X;:>./Y]<(>G[.ae1V@=B?-CCgG?cLA0.
12_#@DbR&.I&D09d[)AC+K-,HH0.KV2fN2)/a0(<CJd.e;46S048ZU3S=BDbTBGY
ZK8@H_8U:-L=I4f@,Bf/gCGBc&N_V9QOfL4?N9fP8?(FKSY6[B>SgFYTD)268aHI
eUV)6eM3N^1^X7?2L^Uf85G,[??-A\<I_8NHX/5;NcOR9Z.Ud3C+Z16AgADbS.4)
,5^0<##_TE<7K.X4fC,fHMH(E#9O)DX7US\=EMK2RQ0?Se1gXA309C8)a)?P[eBK
=+W2>WE#+1_L@dP<If:.;)3WGBgOD6c([(_;J5^>XV[(_6X]E(?5DF[].#SZ306W
)F2[K7bZ?dY5TKZ?6:M8,a3HTHJU-/AR(H@@]:9a(a?I3>[WX\?eeCDc8b_U#TeE
]I([,+8A^^MHI9X11#2+cCd\THQ^]T3:;2+I,I4E(LRW=a.B9=;,>T6)gY+DAA3c
+/d\]XXBJbeYTC=H[ZPN>S@&D_I\=\]-Y(>:Z:]ZE8+N,ddCc4&LV5\(L/f&1FTM
9VgL]f\R?F2g.83U\M9g2;KEQ?<3.]S_0fC^39MB>b,+C=EcC&:<H[4PY8cYMAWI
A=U)&VY4DbQK(M&-MZWPP+]/WQQ#WDR/Peb8H7O4S^L2/\W0((fB.EX8YTe#c@WH
)<;XW@KTG=XP=;6&YZDT6<VgegIB<eMO5COO#:S@cQDY5d>D##QcI\E3Q@1+H\DP
I/X,EeJ4FYM5CU.15PQBb,5+d3XTWK&aNg>U)J/WgaTD<[bLB+=e^9H#DfDZ.D&)
db21L[&LUF6QWPAE@6G],acKK)_UV-CaOS;.:#?5IX6-,&:N:1E+S1SVRL&\b8P1
#ZIe2JJc,];AT\C;)]C?4W_7CK>E4VeTA3/4TCN+F6Q4Z1WcbD+JOE2V=J@ObN]L
BID4>IUK_b?\&7Dgb/ZFdPS,43@<&M9#6N4_I:@EJL04D$
`endprotected


`endif // GUARD_SVT_AXI_INTERCONNECT_SV


