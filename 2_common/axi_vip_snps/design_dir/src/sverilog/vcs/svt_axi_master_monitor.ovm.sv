
`ifndef GUARD_SVT_AXI_MASTER_MONITOR_OVM_SV
`define GUARD_SVT_AXI_MASTER_MONITOR_OVM_SV

// =============================================================================
class svt_axi_master_monitor extends svt_axi_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
  ovm_blocking_peek_imp#(svt_axi_master_snoop_transaction, svt_axi_master_monitor) response_request_imp;

  /** @cond PRIVATE */
  /** 
   * A Mailbox to hold the observed read address ,write address seen transaction . 
   */
  local mailbox #(svt_axi_master_snoop_transaction) req_resp_mailbox;

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_axi_master_common  master_common;
  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `ovm_component_utils_begin(svt_axi_master_monitor)
  `ovm_component_utils_end

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
  extern function new (string name, ovm_component parent);

  /**
   * Run phase
   * Starts the threads sample and sink tasks
   */
  extern virtual task run();

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

`protected
8VQBHJG,DZ@Vf_1JHXdWCR4D>>cKg;TF0dgUE];61#P[CF8&SGOP.)YCYCJ?+23J
W^&#VcA\]c<0PDcCAE3XW0F20M&,&&_P8c)e6XN]a,5-F6cI:MWN<)5>)3df_S64
6T38=]#G=c9U<9R=47A+)UBX0d[>HK?M0e.TBNF>e2\.GG)1dZR0@(>d[;CCHY>M
YURPF,+f>BE+XO[\-gdOGG_ZB75)2eOQ<;/EOZ0f0a85/)0MI-?[>\N/65C_V=V)
5-b,O18]Z]H1B/2eXD);229[A9ZPf4[M7\0AL6>IL:Q>0QQJP6QH?DD5.)G-a^Pg
e^UET27XGMLO7&10CL/147]b@I/#FfDVf]IFPR/Ed9/\2eY;7KB_IT-KEZ?&+a:8
:\@Db-6fM=MF==RNB>>TV?8Ab8[LUT1O30HAB=9_HTQ\E$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
DD<b@//TR.C0M:MDBHD##SHSBLSMT^L>Z9g_7P0&W17eR#:S;X3W((VS+96/g1#O
__^e0])P8INP#=B[-f?aV&1W>NA52B&2A&^b<CYfUO,0-C[IfgL&PUC4\f6(OJ>O
-FEB4<([=HaBJX]_&4J-b9[18Mdd88?],U]8ZPS1Je3_X0NB(;.fO0f1;RW:F@B+
F[6#J7>WOW\#VAD@dCF/)6<O,V)CYg>FWb[-+bd/F0,VfD_gDd0-]1a3FgfbCDd)
fbfKd>=L95eG90_P371_K#ZV;ZF6;<+gCX,WVCEb3QW+V?HGO7::_b#5cJ/#LWaQ
K0aH.e\N2)aO@]cZ6.8)CGDLQ#L@:L-WfA?TFP@MRM/><K4\b2U4e0UFP=.64]3?
DL8U;6]IP3,_>(IaJXHXSfXN_UQW##JGLaPFBaY2&E1O[#RVQ9?E7CCCeQEKL#Y1
JOB-I+b[:J;:=c#X([6gROZKcJHCg8C-<,9\fUf#XMNQ.AVRYP4<?WcV(84>\;97
94D&,WFZ9D2A1U>I7<J-g2<.\-XA0-C38AH.NZg?,[>=eSDN.g(a@AM4Aec_(:eS
TE8<TQO>:,8FJd[1Z2f8_N1)8F_WJO1f7039RX(0=#P#-;c/20EF?U0X_?\g40:e
K;ROMb+T(b4U3C[-S9VKM;DD:7J_2:JD@&b=E.O94a92_(JaEO5)RY]Y4I,dHKO?
3BS4Hc8-(/X.+6<MDfVAJ>T2<(OC_67)Q=)C@]M<3[J.X5Ve;f?N4/6TS1+496N7
B8XEDVFPZ7TLe/5N)6Kab@V]dWMQ9c\b_=<()&2dfd[MIV5@=<V_Lc.84FZL=4]5
H-G9I5)Yc4M4#V.2Sa9A<T^]<[;J[S;,Q651V]fGCeV(DN+):]2C9HUXfF=?/6c&
&a_#U_0-4eZYZgeYQD1G<X.V2-8,SI73=@=aQIHO=3Z;YQ^<3=U.cGbf+#SE4N(>
;DV=J.]K2+-Y^R_=4R^fGQE_M29F7LD<d+:cA4gF.8M_DC5;]d][ZO>9E)][e@6,
;ASFceF1]-Q,K@#SA8E4^AJ>^D08)eXe3WJ,DF3J#1:;\\-\SM)&Ue8JW[?abU&S
_OC,JN6aEY>L3[[SBL\IDKN7+;VY#aJD76>EYWWV-YW57:+5Q1T<3FTbf>W&160+
V5f<R56gILVF)>BQaWPcFCWFeS3+SV?-U&]R>+C]F@F8=J3C=(\KDU__KXF1gLOB
BS-QCSH[C@60XTS()B.:<M/&8)]a;Sb7g(aQ\IFP3419/_I(I[Mc..,?#P]&-aB/
BP&K?NRgf8d9EG/I)3URD2VHT<5U3SA_YR+[f^_;c=[@+5Q(H\<e(2_:79VV3XHQ
0ae?]F\6+TVP3&0G\^U/EJC..PT(U8XVG79C0<7PbfX3^Rf6TKO4)J-^_S2C+V^W
@58c#8HDC0RCb=CQ])7MYN7d8K<Q?O5-K:1@]IJGX&+>O<481\ZAJY4O6F80O&5>
.\]3E/V0DE;@abA/L#U:6MVDNLZQ#418Q>P>SQ1;U5Q]BA++;P1EgFLAFdKS9V:4
K_g\_+HHf\DUJbV2WI<._5(+2dZ<?Ad4U15E;(YME(0&6/LK8+1BJS/^KD]RAN/5
:eNS[;M@QWeeG::V,JK.NTP0W4T:UCE\Y9,)7;WETOdcJ]8#&9<29:U?&R9(X>LQ
(OEQ9J)IGC5A]:bPLf1];6J(,:a;W:(1Y.ffJOJ=H4ZB>.B5Nf>\22gX.2&HT-E-
YN^@#5VM^bR,(D>RZ:S9_@;+#L8?JV6Dg]EYH7I8>8SWRNHNO0R&P/Zb.b\\T4.H
PRTgEe03R^)]7GPc_V1NS+L.QZT9+CY^_UTgMaY6d5bX:FM617^OE7/3:0B2Zc5+
NFa-gIHXb:M8CTI7>2T;H4:,X(bgEO^G;7US->_\<L)N:M8YcGQ&&9P^81(H:H?c
]<Q&D52JQ-Od[_)9F,C94TgVdT9/I>KIHY4UABIYIcQP[V?)dLW?)[g>FK/IL3FH
1HM\;6MFDg1gOX6<0gQE(D8;;@FdUW[M>)9^GPC32]XM42ZeV?_C1G6TNd6f,WA2
(ZgUKZ>SXW\eV^+<99N5818;7$
`endprotected


`endif //GUARD_SVT_AXI_MASTER_MONITOR_OVM_SV


