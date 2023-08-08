
`ifndef GUARD_SVT_AXI_MASTER_MONITOR_UVM_SV
`define GUARD_SVT_AXI_MASTER_MONITOR_UVM_SV

// =============================================================================
/** @cond PRIVATE */
class svt_axi_master_monitor extends svt_axi_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
  uvm_blocking_peek_imp#(svt_axi_master_snoop_transaction, svt_axi_master_monitor) response_request_imp;

  /** 
   * A Mailbox to hold the observed read address ,write address seen transaction . 
   */
  local mailbox #(svt_axi_master_snoop_transaction) req_resp_mailbox;

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_axi_master_common  master_common;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `uvm_component_utils_begin(svt_axi_master_monitor)
  `uvm_component_utils_end

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
  extern function new (string name, uvm_component parent);

  /**
   * Run phase
   * Starts the threads sample and sink tasks
   */
  extern virtual task run_phase(uvm_phase phase);

  /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);

  /**
   * Sink snoop address, writes the request to analysis port when address is 
   * received.
   */
  extern protected task sink_snoop_address(); 

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * master snoop transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_axi_master_snoop_transaction output object containing address,
   *        control, read or write information.
   *
   */
  extern task peek(output svt_axi_master_snoop_transaction xact);

endclass
/** @endcond */

`protected
=-E/I>bXP0.1a@>\36U;91A1&,3UTT0]O=GAf3G;=;b:M,G33H4-()XOI5e<9H.T
ZDDIVe^S909K4S)aEH#I^-4bSHad,+S3ga:?G,/W,4R/Ve9=Lg0M]MU\1MJVeXCJ
CCSWSc;[-3fB>>^&>4Ag+H/gdcL_Wa,SW&1H_E/FI,d9Ne:FO9[d3KR3[L2GBWOc
+W;<ZRY:cFGCAdegc/4Tb6JBW2V;Bc[/H[>O80S+[BEb,@A?0.gO:MOVRd&9JFd/
7c3PI@79\_-e9E80;8Q[=(:TLY]?f/g>Fb-I(4.fU:Ed6)&#]c&X8QZ3KJH_(S[e
[R8S_DCG_S\<PdL_]1M<:C,DOX4.EZ/-MP16-U7YM?1QVW;XTZWS<VZ5,;dFI8B\
RR)C7VcT153)K6;[[@9Q_Z<.54Q+FH7;Z/(8[WXE-[(QE$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
JQ+DUecFFBRE9K=dD]NOa5:#[+J7;<bffb/cc5N(Ma+LN;.]<ZP++(4@0-)g7T59
Y5FfJE&YGdK70LC)[LRIKCG0e3MP_1QS6#W^:-ZJ<aA(I-YcOF_0D.<Y:?V/K2b2
0ed:469Y9&>@5IX.NFAI&cC]D0<?+VeNSG(]<fZI>TI)H^\[75LQ3Qg(ST2_2F?A
[cM[J^H1+7QHYLVO/8,P/V_@AQbL<E6TfUNCb+=#6+ZS=P6WV&]D&cXBA.-7D[0B
7>WJ\6J[E;^P<:5.N4B,Bf5IJ^V-M:[?bK9d[>=PbB#D&LY)1D8^&I?&RYRMT_^3
ZJ694a&B\],2\9M8=K^T.?[U?dTKJbJ@eL6N-DgFWL:CT]U+)+3Y1NQKS4^]&7MK
YfD[,\[>LIT3G.PE77bLQa]]Y<+Z,KfNG^Rfg,<R4Q.;#[]YR&^2BB@16fK6/20F
O0gEHgN9;OKV5J[O)=@fAbQVMD@,4g.@5AKb:g)SeT(O0;7b>fZ(BMN&e&(T>2&e
WA&:eeVb/T;Va.,YTb;N8#RLI>a5T:2VV_SB@28,0gDSTcTd:L+5PE1?W(P&\IBV
3GE7B,&(J,4@WG&_:]:VN8He5I.NWK^]571Z?QID=/]EL0L)#5DeST)aYd6L9@b6
]G]QXfZ&7e;9@K^0g7R;_N&a(2CeI>#ZTO^_.9_f(\XBdJQ879&7Z^0(SQ&ZL\QX
EgEa9(aISU9J&>W@:eXHab+[#\IaA,3V1[M@TB\[94L/PIb84=JcED;e>=JQF5FH
2K1C(]_V+Ue>E:G42]>d9.A>DW).33\Hb0Q8PfbbSd?FL\TCYcfT<)81/H>D^1:2
?:Mca&31b?8[7DO&?^?g#AOWa>^5C))76[a1W93#2g(4:A264N_+V38QT384++14
OfH/?]6D>=]b=2d[dW[WYEHA;A)5GBK,?TB1;,BYL_1QDKM2Y;TJU14\^6UAI+7G
@-)+1\US+cSM68.BI[<cV_.c)gf@A<Y5)<KK=?@S747,_UFBT:UJRQ3BFV:PcO9?
VNbg8(I,J/F7/J\Z#^FcL5^4Q@fW?6?D<51ATUc#3P9FDG5B/VSAIgJf\2a1_RaZ
:.0L\d+5MR>e,d0B6/9@R-g^_H6a4?I95R.RVFP900P6JE.E/34SK^ee2aW0_&g.
0M>Z)6(Qfcd\.gW8Ib8;c&[7P7Q\F^C.FK8UG4e^CN:\4+N;&H,#(NJ9Q0b\PT[K
-7\gWF7A)K/CGK(=1;Qe)4F<4Me5=NA-=PLSP[_2>dJ0Z=;15;3\]4g(CV2O<D]R
9H_X8Fb]9Bf#Ad/ga]fKCZ=0(WKC4>07Y]P8&PHG2;ddJX[b[bNZINeC68IS\)2c
]7Eg:1#1+M5VEQ8VUT(MV5;9JWFAJ4MNP-F>M5X3A5>adPO@3Fd4N<fB_N1/3dTW
6@=HDS)9cB-&-2WRI0LJ\X;H.#:ZJR:#=C>SJeJ#f1)YVTBf:d#GcK<B[O95#+d<
O/AA89U3-22gbKV)=2MfW9aI,IeQ.8QOPNJ\<[Z5aW2.L&VSCP4O[9D^;RXCG=dZ
Tc9\+8WQDM.QWA6(OMM#D>V-[]@LgLKbE8?>KJE)S+4[MV29+?Y[V6UdaJ[F7AJ?
U?deQRVaBZa:>5+>(^7-F0;I[^/CH(?B1LGCTGUCH;feR;ZIA76M[HYZLN=Z<9:D
/[GCYc;VNa::/QR\NV[P/dfR\fO]eZCQY#=a?X2T)K5E=2d:IAEYFJ6C&g@.UfU5
fC1;\])TV:.:O4/g?aK-La\W^1U;\4b)4:4IfHc_.?9#EMdD7_C4@^\[N>_R^V^D
C;<R_/#(6a<eNG(LHTdGCANGaUEeeK\)K3V@AC8E\=_(1PQO8Mg18/7[NGXaYE,+
X@a)B3)W9DZZK^N)DK@c+?c@W3.(X?Zg\N:5>LRC.7C=(1PO+cXC6OXY/^NS-,L.
eV7g>MUL(6]ZS@=,7CSN5^M^E+)5G/218c@;KEOLR19d/@&HV[-;3>WLV)gHY+V3
ZVAY[KILNH[MW&[+4bT3N;e25.;U;#L.-@P_G:D79F=/&/bC5J#J8QRHD)><EeT-
cdT3+D4SeWd0//QO<8dQB#T<F5S:IJX2gf1?2\IV8g#Vb[,\[+=](+8RG);I@4UO
@]dP)4.\H]^WG=3U8?_0EO?X9M[,#2I9Re,>4a[)]3E2[R\T/gdNZ56;@B<RT3Vd
;T5ZL7/(DLE7D[G9/MbNU2KIdXfa@E=\4WE\7REN]4a-_Pd:d&LC@>NX>B,K4^N.
=ZK\7D6G9JE(;YgZQSUEU8=ID&0N&GF##f5&E5:Qd^YP#+8f1E(M1C@A?#G\4N;?
EG1.X9cO&DE=;g]YOSP\^1?Oc4)E@f-1^cGF0SQ4CQ-P9?.5HEIOQ?WVF[D(/d2OS$
`endprotected


`endif //GUARD_SVT_AXI_MASTER_MONITOR_UVM_SV


