
`ifndef GUARD_SVT_AXI_SLAVE_MONITOR_SV
`define GUARD_SVT_AXI_SLAVE_MONITOR_SV

/** @cond PRIVATE */
class svt_axi_slave_monitor extends svt_axi_port_monitor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
  uvm_blocking_peek_imp#(`SVT_AXI_SLAVE_TRANSACTION_TYPE, svt_axi_slave_monitor) response_request_imp;

  /** 
   * A Mailbox to hold the observed read address ,write address or write data before 
   * address seen transaction . 
   */
  local mailbox #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) req_resp_mailbox;

  /**
   * Local variable holds the pointer to the slave implementation common to monitor
   * and driver.
   */
  local svt_axi_common  slave_common;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `uvm_component_utils_begin(svt_axi_slave_monitor)
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
  * Sink read address ,adds the request to mailbox when read address is 
  * received.
  */
  extern protected task sink_read_address(); 
  
  /**
  * Sink Write address ,adds the request to mailbox when Write 
  * address is received.
  */
  extern protected task sink_write_address(); 
  
  /**
  * Sink Write data before address ,adds the request to mailbox when Write 
  * data before address is received.
  */
  extern protected task sink_write_data_before_addr(); 

  /**
    * Applicable for AXI4_STREAM interface
    * Sinks a new data stream. 
    */
  extern protected task sink_data_stream ();

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_axi_slave_transaction output object containing address,
   *        control, read or write and data before address information.
   *
   */
  extern task peek(output `SVT_AXI_SLAVE_TRANSACTION_TYPE xact);

endclass
/** @endcond */

`protected
ZNEZK2F?>M;?OG9Efc0JIWg^IGJ:N9XRBW)MV#,d7.99^>faP>7U/)TFTdONAF>L
^\/K7\2Y3(@;NIN0(KO1d4Q\T#(Z0B[4fH<4HH=,P[TKW<VXd3U8U0.aRHLN\]55
],[KYMD4Z08N>3L+4\+O)cX<]IV^<.7a\bBV;#7VKV#:72.Pc,d,<(YEMFa?a/=Q
8(#Y_#?T0b;8FF)0SSY3a5XY#Y6/.@IP=H?1D7eEN+CRY(&1d5[7VPA(F60F/Ma1
3F_4d/bAeg(&bS?QGY&<3.Q.V&1OM3N>#H+0a9eM_T_^[?//W>]?eHeVHT?)W/H(
8.f.Z=SH^FV4d@[=e#.12+N)BcKQGOK[]=KGD#NE0bO3M4fDa_FWB(J#,8NQH?8(
9gP)PIZ<^MBP>E0G9K@K:R;2OV/CJ2[&&M@MA:@T)T@GMG5.+&@Y^<5/>U30VF,0
W]?/F4^Y0+N#8,f72G6f\e)WLX(c^F/J6W:AC1K1?^eUUK>/SO^_RWHRTIF80.W&
-CaWU(-fId])JNA5GGgb-17]S.7_M3GfC@3]E;QVT5PE<?K?d23ZMea25YdF0-6a
E3>0LP1O]R@7VRbO3(E-V_0<9-LW9P.MANe_f^6#)HN0BT,/CS[7fT6BSGTX@5C_
7K0[T>;\&;XD(?M4Y1.d6OAW(6CeTb>:/M.MI#B+U;,]KX_D(eDg(36Qa;G\,=2D
IH^W+61NZ>1FYE6K/@_=-QQ^059:M(Q\#]<0N6R_H++A-67cZ)B<aDA8]fW)YHWQ
VH\#L83?CS)N)VL&Tg7g3@=dD\\.,B203[JJ4f-N[YGR(.9G0_CW;>+]E_CD5U8F
2?a\L23G.+XU=5e4&8:U7V#]Z_eG_)3e\+S>YV75&UD1GaW8]#P20\D[7203ZO#4
B6U:B98a1^BU6D8:4-A.V.PGD)OBKA\a,8<E.#K6.e5aY+L0:e7>B3?^UT\_Y^+c
>=<?NQT9@Y[Sg.e2[#DCX(FVV1SX]GKO+IeC3R-ONaG#]G)_=bE/856Z.VQT0)#A
B60F&^DCSaG;Q&-6EaA+4F)@WZgL)<._\\A4&WX<eEIJ@\H:>bPHJJ,.c8=W:Ge6
>TX&/BOO.F#P(UV;S4Z;WVCY^JD4A#H4@?CO&M=5IcZ._6,X_1>)=SWU9AVcQG80
>V7EA6A3-[gZX#g#Y)(Md:8G?51?2PH_<R724N]BcTL3B0gK2M)\gK?PE\DI@DfO
#EdU+SP_,]e;[V>OM=AB3PY])U?f9AR1I@:#_2N:SHB;4UYG&aDF&:-WDOD.MQ11
F=fBEZ(R@MW4T;=1L=9+,?/WX//KC</DJT1OCgQ:;0cf<g4cg<7.GW)6Nb<&K:.Y
\\6FA;Z??I]A6C6@[Ca1_A8,4;T-<@&0,#.8[S6(KM,TGbXC.()83,0.9,CNOeVf
+U;U>[DNNbRf<N-/:9^/2QN5H;=3#R#B_-)cc]5FVca<6U8XY.&LJ(;:2I)XHP<I
+-O5?VB^+)QaSDJU&K-@:#+7HYH63^IAH0CeJB;8bNVCW_g.Bf-].H2#YL)J18[Z
#>&\(A2c<Y5Z,;b@QN2aT6^>6Q(WOXgD-LMESY/CZO<MU>)=e9DA]e@Le0Z-9?SO
F)-/9Q&64X9&F7f<TRN54dZZAUN),ef=@f(CQM@5SRb0;dCV@gYCd]50@G,E9H3a
Y)BR+(&R7):ca5938#I:c(MNC\-+?VR\=IGQ&;X.]J^N3VM@;a?Q^MJPZ4CdP0,8
+D2WW(AMa>8_^5dG-@YYUV\@e:1TS/KKcG_6c+PN0T(GdJ(bXG<P_.6VP8fZ7.77
3_NTI<0^<>LW3&)\T5-cXd@T,[1UBd6[/fUNT3C)_R^\I@SG:RGc97LTF)gAZLS2
_3LU_KaYFDf#^M,\>_+9:\O26/5T8)LNB>VDAI9S&]JKH^=WF5R2a3bY7g^TV7(f
.7T?1d<Y^HX[C^5>U)J6KdZ)83g]YeB7J_,26YZS8EM]8<fPBCNg;=YDA\CbKVe5
.)/1RSDb03b0P^KE.:6F)PS>PNE:=+1C]UG-@g2:[4e=FNDMK&CgD@1T&2<3VFdB
-:1A#D7FdJ3;#]:GQf7DZ>V5RL+6;+a.R&S.>LC[[@:LF&9_I;;6<0X.CVc]fW,-
cJ6W+?MMT,UWZ,Yg?264VT00:=+b.L0AXQ6Og?&Of4TODS6X1ZFTPBa)Bc,c4=c(
:UD4W0.O+PNY?D/c:)]R-[dJN;H,UCP:K0@&>=3[,4Wa/<)E4@<g0;97<_&;XW_6
+K)Td^GTeAZR=2_E#D9U-7RH#/fC=F090#SOc3N9&Ab(P^IDTU5T2BXU3@A0F&O+
ggZEd/\VM8,W;#OF]g-0(L3GR6Q:/8P[(6W\-XVZ2;3eS\8-LB,6d,N8?a0UMB(9
^2eSAJ?E]>_0ee\H#>@5-RKN1QS,\aUOgI#5I,2I-1V(^@E1I&D^NcE41Cb,^#AJ
JE4N0R)SY^P+SU)e0?IQP3A.C)_VFHDSN_?FKJ-A8EM+JC8Z>A2/d(A,g,OKER4#
32K8(7DOXE/CefNXeS+dU&IdTcE]JTWQD@]<QLg62a;ceO:E\_GY<7S?:QfXaC_8
R+Ng(V&F1\A\CM2&TX>#UePe.DfAA-]6L\DBaaG5Z\(,c+JId,HA-(2M5[18.U+g
DV@UK6DD<8TG/^C##41/C5(M:eZ&3g0N]HS#,G13IMFdHD/QZe[X?/GEZY^,8(b&
b>JJ@O;NY#cTFC>7EZWEQ7dLd\8:ZKX@PB;LCL->fN//B0\e/R661=,MIK>LP@E3
S:?XY-98Z&8I=^S:_ZMI2T8fR>[L[@U&>HML#_8_Q9eB=6-:7e9M\V1/3PIHcB[3
PZgY+bH5>?JdG]JV.cObaR_?73-\b?E8_-ETf@JCS]X2>J0RGPCWUY<bSJVP9G/-
Va^@>6R7db,0fb]E&6T&WSXUYZ@GNZM,+fF#R[1+^[W9W4>HHAD>R(3cZ^^)Lg67
Yc9UU-b9(.8Yb\;-4=C]7Y)#8-)^H:O5=>Tg7a.:LAGaSF/+593?3.K7b^Q4V1E-
=AS:-@J/GQKH^4d/IK_G4WK.J41T3JSE#27WgVA]W\&YPH64-RJHX25a^_;/<JRb
\,]8U3EIfROF#JR[a&/FO)]=\7/)e(-KDWGU;+]+3M3SFb8_)@2JNM<^3=Z^;?OF
_YX,[J\CS)AQ([egRM]^;(^\)G]B@L#7;?d10^YO5T@<0+YY0(I>N(X--C#X3YVa
^#]:T).2,BTI(g]=e)=U#1R8^OFB-QH<=IUI>MAeUL#<H$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_MONITOR_SV
