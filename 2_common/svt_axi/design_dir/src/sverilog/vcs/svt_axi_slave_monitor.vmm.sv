
`ifndef GUARD_SVT_AXI_SLAVE_MONITOR_SV
`define GUARD_SVT_AXI_SLAVE_MONITOR_SV

// =============================================================================
/**
 * This class is Slave extention of the port monitor to add a response request
 * port.
 */
class svt_axi_slave_monitor extends svt_axi_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, `SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Common features of AXI Slave components */
  protected svt_axi_common slave_common;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_axi_port_configuration cfg, vmm_object parent = null);


  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);

  /** Sink the read address and send it using the request response port */
  extern protected task sink_read_address(); 
  
  /** Sink Write address and send it using the request response port */
  extern protected task sink_write_address(); 
  
  /** Sink Write data before address and send it using the request response port */
  extern protected task sink_write_data_before_addr(); 

  /**
    * Applicable for AXI4_STREAM interface
    * Sinks a new data stream. 
    */
  extern protected task sink_data_stream ();

endclass

`protected
?9.46+cUKJ0B?:TZ^?KCJ>RP_>J@,ZASXbY&GG&b6=LA4;X>CE=F0)Gd>M_F3)40
#)82TO^7NC820;G_0?C;f5X]3X.L0_8eC6[P=HJ)LSA86d@&0K\2RYdg8&\/8K8O
PHHU+NF-.)W0@8X6Z45@L5M:95E(<bF5Vg[-_U,UZ7\2>XR\_]2J-cUV@T@cMZ1H
G.SK\.-<)6E<fV^N^T?Ib;d5&-TPL=bNUUT1g.L[X95d#W[.RQc1;1IgH:P26M#c
?R;bZ2E1V3P[E846FIF1Za)+PCE+^,a>=dg4N^S<PV&\]c(QZY@C-:d]T#adLCP-
1]=O>_V-W^^UE^F/>P[::<A+Y4H/(/8XAMF3PTH/AVFBDEcd5];b23^eS.[Q>J.Z
<U[>@9a46:)G:JJXPM85RDI@18L;+6SdeKUH18I#@Y1;[D[/P+Y1S)KE#<;=PVU5
P9WHOG;5fUedZY8\#00(CfO<KP\)FM9W5<]bIQZTXR@_8AY+KeN8[?C?L7N;IHCJ
GK#@/(5)ETT+TWS8<Y67HESa=2J_0>C[[cQE6]NDfA\bX/EM>OT)Z+XG^;bRM\B7
CS\OR>JaVBF=X[16RA#P2JWN>3(-K032YT^UN3-(dI\e1]D;L(&+-L.S4-A3N+=8
83+(HV+_[Se1Ba?X]PKf9KGAF.fP,VESB=/(<,>7X>E]^)/M.\]VV1ULMeB32\Kf
6-VQcM9aDNZV)X/-R:g,C.7BJQUDTJH]YY8@0K6;+&:d>ZYH)Y65;NYS:+b(-TYF
FRF=[76C.OJA>L:S:4/R9cQ?5UcVX0b:K?_d0J.8V+Yd7=\TO5d7P+M;1#V-9TGR
:JNL[dAVLJ(IJ?EX^Ef3O285?>LXV23UY?>b?#Y&OYC..XDA#9ER&J]7M-SdJX6M
[AJ\+aT1EH[WSdN^+)<W]HEQ4).=d=7X;,RO:=+fS@/+\0H/+=?UYWgTM:XNbG/]
.3:AXM9/^W2,cX7[C.4G9YGI.\[O>c#bWZLZVZ]5^KXMV3PKf(CP+R&:YT-S9Q<b
:.#JRe>9(#c/:IJ_0):fO9@IfE:Y;B=6-];S_]X@eHc7D<4H;@B_PZ(T37,DP#5Q
&6dDb,g=K\40^_dSg5Dde1^T7/#1S-Wfd?HWZ^DU;&gJ<\29ZR;.9]aB3GUL1-bN
3IF-b1fUB(<M@6;\B7EPDFECeXDKf\:47KT_LJ\3f6C[^H=/6>F:0Fe8]YJ6D8=]
SXJd>SJEP0E1+d:CYKY8bK4SaWO:]C(]-MANY6+_=?YOR7HUd8?Ze@\fg0=cC#VA
05@>\IfYf#;+c9QPf/28-VF&DHDFJd0bM=R3J#D/==RdV4+0a>CRdd,>-ZN3GE.&
1+=4)IT6(dE[0]6<:?#AaM^BL3PbE+[O-GH&Q_4?]#6L)-JTSD-T-U7_1afLWaDf
TKL7aZWY#Q8[G<bGa0<_U>g6Cf<SIf2+:I[-B3HU;P@LHKQ;@B->[7C@X]cNCfd)
.@0T8fPdJZ\S_G179:S89gU.+f8Cd(530TN(-A9b6>IdRT#5?]5B-,;ANg@I>0@U
WX?/\O9MUBS:;_>.c3aQ9H4P;M35c(4X7B4I[X_.VTS@-]RI49+I?H^<5>/d<X7N
)f=G&ef[SX:a+[EOQALO)baEF7TSgg_1bI&O_MC@D&:&PF?8T3XgNX;e5K_,PQB_
&Y>#=;c1_EeAdPe&C7ZLagK,gB56QJ#7<UX:(H=]VL?DdfdYJO6ZYB8@3#\>4>51
E3,f8fKS<Dg(:M(1g:Q>]DWKPX>2;ID05Wb<9g\fKV)U\;L:c2.=9BQ3VMOA+D&,
<0FaK0YWGB@UF4=-=S^WE&CU)eGa#[09B&<0M6Y2Ab[;Cgd-4-dR@YPO4&7FEK+.
5[c6ZCRZ\(F70]G@&-2-[I(/0<J(L9Y&faP[.H&3J2KGHa](72XH(T@&87RNP754
QQ=ccUQ)G+7[4+GC/(V_=1KPPCUDb2(QM6QOZOg1]V3+Q:]9]T&9L^>]gCIAX3ce
L-c^ZEN;L1^SJ?:+&XI4.^TWU\ALbPKX5M<VIPZ#4GLg>BQRPZ#MNI)>a^O=:\,Q
#U#C49>e,UW1,/6&BPI<>/egB@#Bb;MMSP,O&0B@(T[O^XYf3+NGGe-:cYC4ZF?P
<6P:/N+.DUB<B]MSPQ303>?_<aNDU_PX?+Dd07G#ZbGNdBPdH.URBC<C&,Se?A2_
/\9.HHDHRO1/AQ0=Z)W35W?IbIO7f/Y(C4-=^43bKLPI7M0L84+NK>g10OJQd04<
UW>F57b/5_IcE1Ybd,=cTMJR:EHS_LU6@Va:)JH(fE2Y0B^Mb=W&N>+ZKT8J;H.]
9bc)g-Y[CAYEU[Zd<A+RKH:_=URB]<+R.6,ST.-V_P[Z+(9+S1<>ZCC7]Y=):OI[
bcPdV[26674^@+-:@S5WI-?5YG+U.E)C(;@]ffaFZ<OfF.Re7&3G40F.cF0]J-YM
+T-F#3ef;IR,AJUY<_DBUD1K(G]3QTX><R+?N.-,+YH^]PY+/U[dH>C]OX:3XHUJ
X?-:]4S^fBJ+5PNING00DKB>-:4M?ZP>9)>(O,62:Z\cAZ(BG^E_O,,2/^UE1G@1
c9Qe-bPQ34AaV>]>a))IJ_VB#>.\O+.0P3;<8a\M(V<bI_0C8=-<N@XR]bB<a21Y
R1H2TC68)c?>GJc=;3]A^E0#LfHTCdTC&TBSH@QXUMJB.,_RM\JW-V#:2^]M.VC0
M.)ULA)3+T.;6A-1f4^.b@AK7Oe4g2O/NRG-/]gV0daFKVgDa)(K-JMeWL)RaOZ,
I7#1D@G:F\:CAX.RbB7M0FSbSaX)JEMRVDNGa0^Z_VbP6FUVc\-gNW;f2TMT0A)a
5:cKGBQ2YH[)XZP;dcec9TZ_bZAK6Q)II8-cBIF74;(4JfO_CZKXL^NJ2BbGZO\>
/=A(/#BX]2#;8,(;(L/(/3]#0R9CT7YT;J>K)Q0=YOf(CR1HCT)f9Z]&gcVeAYIQ
a-6[fS(B_H,V\(33JSUS4gd&bO)4-B;eYMKfCgIUA#D1cHe6HS.-X\Zf>M>C,69T
X1-]?-?]0OU5A;d],cZVCWG3[,&X8,dH+A<LWa(NcW9;MNC]^CWTP554CP41N7O]
15VWYD5DDb()UORc_,+efdK(U:IPL+3ZLH5+W[Ng6BFP-aNWYA-F09ITb=5RL78E
f_ZS)Gag&H<2)VHRa.>gZ?f>A2+K\A1F?$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_MONITOR_SV
