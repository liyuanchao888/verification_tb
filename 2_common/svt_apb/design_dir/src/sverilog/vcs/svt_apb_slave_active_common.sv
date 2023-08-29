
`ifndef GUARD_SVT_APB_SLAVE_ACTIVE_COMMON_SV
`define GUARD_SVT_APB_SLAVE_ACTIVE_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_slave;

`define SVT_APB_READ_DATA_CHAN_IDLE_VAL(enable_sig_val)\
 driver_mp.apb_slave_cb.prdata  <= {`SVT_APB_MAX_DATA_WIDTH{1'b``enable_sig_val}};

class svt_apb_slave_active_common#(type DRIVER_MP = virtual svt_apb_slave_if.svt_apb_slave_modport,
                                   type MONITOR_MP = virtual svt_apb_slave_if.svt_apb_monitor_modport,
                                   type DEBUG_MP = virtual svt_apb_slave_if.svt_apb_debug_modport)
  extends svt_apb_slave_common#(MONITOR_MP, DEBUG_MP);

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  typedef virtual svt_apb_slave_if.svt_apb_slave_async_modport APB_SLAVE_IF_ASYNC_MP;
  protected APB_SLAVE_IF_ASYNC_MP apb_slave_async_mp;

  /** Driver VIP modport */
  protected DRIVER_MP driver_mp;

/** @cond PRIVATE */
`ifdef SVT_UVM_TECHNOLOGY
 /** Handle to the UVM Slave driver */
`elsif SVT_OVM_TECHNOLOGY
 /** Handle to the OVM Slave driver */
`else
 /** Handle to the VMM Slave transactor */
`endif
  protected svt_apb_slave driver;

/** @endcond */

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
/**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_apb_slave_configuration cfg, svt_apb_slave xactor);  
`else
/**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter UVM/OVM report object used for messaging
   * 
   * 
   */
  extern function new (svt_apb_slave_configuration cfg, `SVT_XVM(report_object) reporter, svt_apb_slave driver);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Initializes slave I/F output signals to 0 at 0 simulation time */
  extern virtual task async_init_signals();
  
  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Update the component when reset is applied. */
  extern virtual task update_on_reset();

  /** Drives the transaction on the interface */
  extern virtual task drive_xact(svt_apb_transaction xact);

  extern virtual task drive_default_data_values(svt_apb_transaction xact);

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
<M\)^8KfS1C/GGcgR^NZ=F/eMPMN[1@f]0;J9dRgAd;7H8,Y.QcD+)XU.ZM<]K+B
7=aefW+UNH#>HaEb(BYHR_d1_;#d7[O.K^e,c?e1Q@YN4Y7X(CB@S)?G;6ZZcUIO
D+;J5<:F.-5L(3<[6#G5CQU@B-4<LBa)/2L--F?VYADT4]\_5L-<LQ)aHEbc^1@O
(VE&PC_924PO>BSR.EeH:5S/0+>eV0GM/c9W5=U?L.:5=.#UHFUIQdCCb]1JJK)R
fH9<-A3U@G\B0@Hf0?TC_;RHJBK[eYHb;Dga4TN+/5M@-11FT=;91S?AB+a//811
PY(63Y:MdRa\d06fd\NC=1,A4-J3IA?<VT)A0\J/R00O?E.TbT56>?Ja=GVGa)\f
]f,I9[7bfC)4WGS57Wc99)16J?bZgJ\&Z;KVLB+O.ZMJ;V:@T-T]GQSL_IHf/g^A
8cf^_DZ#QQ.3J&)8WJAg>D8.-L9Y9ZLGd-2N@4Q=?RKL1P,47D,2fJ<@f/?=_=2_
M5#W;IVH1@d,=2-bN-,[S<JK<8^K;WgA+?)T=[HE.QTRg_3K3XS8g9VG=g&..aEg
&5NY2X.C8:>Q1B\60fIM.ab7\[H9>25a&()E6,]fDE3,>)W&+IQW=R^8+_\<LA0d
)I5S^<6J+T^^f3;gGQOH+LU\T&d)6PE[CH-7)#d]9D@-W/S7MUX=&)7ZG6^XUce?
g;L/fEBNF=,VMbU/+9dOKS),,[;_@gJ8eB^JJ4GE/7_c:c=f11_P9J+&#C+R29>B
#V)TW/Jf4J61B>S+#=A<M0gWEI-Dd5YH)QaB&N)\<,J@2F;WTIHD?Zg^>Q=BO>C9
[8gRE2e^&ZgdF=JJ6_C[O;W\IG.C)<2L;Y0gf;DfeHTW-4T82G2WMg<S[I/30PgI
G)C.]V>1YQeTJC.;(f8GF>_@cLYJ9f-^N\S_WgIZEU\WA$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
F41&f5EZ8D?P7O_87M[BPD6#./a0b#T_>NECGa(Fd:g,:5H&cGeP/(9V?H^IIa:W
IO_.-L@3[S+SIJB6eL\<ON)d3[T2UD0)\Z\EaW(CL1_LH(B8e_7aTLf?B]5/0eI5
5Ha;TPJ27L/TUVbNc_ME^U@=Rg]TVUFH5?+0:SUO]M\PUO)91)+,H8B-:.AVXC@I
]SQ202dOWXFE4P>GL]_dLfdUbXW20_(EbZdD(-QdbacM\F=KZ]LO=(BD2ZbMUYE]
O0O@0d.PFFf-<KaTCHI7b.9f?b2BK+//?8NA(#O-ab,__MDe-C(AJ]B+X)Rb.=Rg
FUPHHc)>=OM50Ug2=9-C&D.(Y=d][JH[@XZ/[^X+:W)_+E;QW+Z:NH8P@>/JERP@
GPJVL_<S<WP6/@F>:Hc@_ZGff@ZbHfd>_gTO,>Z:I3BY-GCSD3Z8[Z>1^Ob[XMQK
DJg+Q_9(&SV<PfL-PU7W^H[_Agc6@5VHM2T@^>UKOK?KPbdSLCg]0(LT^\Ug+#CW
KZY-6#)4U1\2/<YP,NDM_N\U,U+M-f@)]L1_7QR]WLgDHfeOL6HM1UMH_Fd]:eOQ
)PKXYRULY1K)A]B91be=L-QQ65c98))WC(@=G&Db,(+LM.U)-a2/4E:d+QJc\(<M
G,M274Z:/LOAB(G/e;>&U;Ba&;)P1HBJ[TQY0N5Pgf0W/+Bd/.6?_aRWaWOAg\Bc
g+O]_E><?7=_6?13XB<14U<.1D;Hg3)8O:]EbSDgB=JEX:45VdNTa7+1T67/K7]f
?VbR5dL?aTIU_#c.4;=SLf/@IAVVM]R-HHF#D,H98^6bI]\a.OKQJO>S2G1TdfSN
4gIT)>IFJQQ9VFaab,2Q;SPMN\>F)/R44VH[IZW<e0NBBR=Q=?]e7ZZNaaJ8K1#>
IROU4(BROSA>1]?9PDI&-F<<,TR]#/S,U2c;21=&W6A8T4e6YDD4:W[ZbTE+d_01
_B)6;@AeS;,3dS_cgaCc\.2^c:fMDSMC?U-BKcPW8N.,gO(2a^2=JZ;f->W7dSSb
^>\JELXPdG&-:(0A69+/g,fDZ_PA@B6^Zg5[2>,GRQHYGb<PdaT\d^]3X/aM(e\[
HKKg+G39/IDV&AK0(RBLf[_1;F33+,(;O,U5M5B<3dM;V+HJ#RQOf8BDAFZ0#3TY
S[<)DE28E2U2bM85Id,b,L@KO3D9]RXT[/c_gf#_C.1ZT?+a_IMM,=HeG=@=[2S(
N?C^G=JSO[<>c_<#ZN^:[?V;<BYI6_AA(&fI4I8XfIRG<H7dRd4WD2,6aTX;G)bN
:=>77E+FUG.8-]EdW<+M]JeW[bF96KUX4dg&M<-MN8FRMFPMZG0:b=X3(,75P])f
66\OIfU13e3RG<;=@IF^8[G(MWP:[OBXTIPcL>HKJLUGaA>L2V9G5X=MWgIM.8N1
B6E@[VFDCI_]3;K@G=7:3KJOgC(>[1A:eNSZL8R(U;NV<66A,&OE?R52T9EV>_=P
Z8.:Ce8R(G[0QUQ/_/PUcQD&9WQe_g6QH6+Re-G:96A3Wc54eK/E:2]0.P\+982V
T(@@.7gVM#SM9bO-]S/BPR>BC5<e\>_\4[1KfFeGPQdYbFgZBKT5:&F4UW50P48_
^S)Y&OMfc&_bN+S#DJNB2VCVO5:FI/>WA]LRG]NZSYWG>9Y-5ETU.C?H/(X#ae9,
]J-ET[.6^NXJSJRPcgH8?a)/^FK=)cT9Y4\Z(>KH-(ad,\N?U\e)KRINQ_:ZU\2&
O6]N#>)WA?H,ZFa[L-^LbcAc@=E,N8F,&H:C=NG57:L)/:AU>Z5#L.@>bZ@ab]8#
])dX94U1>83XQ[^[2,B[Vf50.?;YB78<>eOLLWBbMDZTCUXgI:6FKEJL:,(K^f4&
-DBFecE]2&f24G7g(E:KM@8#16>4K\T]LTNT?US5/R.6\fK8PeD^K<;9DT8[[B@+
@9Jb\J^0N,#aUY\+(OCf.,O7B7H:c^]DKO)8@M4J8-L]RN<Aae0/3CIE()7P.2:Y
QZ#T[UO?3P(@?&RR9FL=RT33Z2<HAdAA6a_47#bGYa-ZdJUDNW/O-f]6SHed68=Q
eQ+Pc8dNUd)O=_aE@N;dN)RL<^:Q<)ENe2aM)(F;[;cb+OJ^JVJ##78Y+]_TDL?g
7OV^CSQ3cK\e-@<2.S.UD@DXR5)>cbI5GTZ)KVJV0?2.>+Z;A/B#090Z6GCaZPFI
Q/KG5+6X6XH@&+3VDH=J2G=EEWT>>ZJ6:Ce5,G.U(6(@=e:GLebF3Of=_#J2)[&2
.W_W=::88WRZgT=B(?cbF1=1/XUf4FF,YB7S;?JFU62VDQdC[#bQ)/VP5&;RDB<A
:;8#OVeWZLT5-S32#@7U=8JCQ4c76N.-X6I3);&S+0?KCXQ[Ae0TMQJO/IX?eD3_
WGF,-/&C/@]3\?f->NHdN^U]5PKCO#6cB1HXI-#5X?D2^MG<aE;L@/;XV8aV0ZPY
9XVMI]UGYBUUX##5Z_3I@8@J(bfK#EG(0+Mb/H)H=J(e&#9YI@=GdB6<KCOc;AdA
??#MDEa>8^6R>0KZC9CE<H9>d?5BPcOc.&#4gbb>X7IB7T3/>YV0W>7aOVBB5_\V
(Y4dN:c<cH=42O,#\(0_=dO-P_IOb=KS63TACVMT4X;aaadfWEI7d#2dG1\_.cBK
F7^9IL7;a-33?CTB+1#&0f7MM<gd+G(@1EYHY>P@_5.VHKIB.DCe\[>.b&(dZE^2
X^&Q&UR_7BA[R]W4)^+>IOQ&R.Zd<@_c41cY]AGGOUD#IgCO/d8Q1S=dN(^FSLTX
2)ceZ5YR\:QENRN55ZdaFWe&aBcU/LEWAB&a7)WWYG>dXOf\RN8d<VUQ1O41-ADO
G<[]=gCVHMNc8Q]WA8P;V,C^+0FAcC6,2\\.G^]M,AYL?^1X0DSN>O0;0.gR38e(
e\=:771(a<]W6:4AadE@XKB)_0=Oc(#Qd2\V/fTIW/XYNO40A1+6RB1ODacQeVA/
+e9\NggW?)=SC?T3gH(bXf:G69d^K^76[KW:M>d=JH/?F^@F/,gLMgY1K8,R/H0-
2N<ZI<cM9,Z^:aNeBcFEg/#Cb=,\/QWDc+2JG/@LYH?I3EN#&3VZH4b8&6:-F[@?
_4&&+K:Z@AXCTH&bVePD/>eQ;ScM^e8HIg-a<S-FBAQKP[C7edL81H0bRB:4-Va9
]HHLQS>:=XEBOZ&EH]&JIJB8J^\6CR7OT7C?9e-T;,b_SLa29+8XYaY7XC.g]@E\
O#:;,IYNZZ-X8[1,B\J>NP^eDBc]ZRDL4d>(XfcMaL/+<\?T?D-MZKIXFC1^WCS/
@.=HB,-XI[dTV)GS>(B-H]A;-F+M-LLfB5cL(b,6cg55eJ:7^+C(\T97X3=50.(K
5:W_(NOYBTS3-K+VeS7WI+O#D[)LU5Z-?&MRa-c9AP])P?[(5FCEF,_W-::VE:X-
BSf9/^CBVg20QC/85OVdXX:\ZH7P0aZSM-/<+N(BYd\6H;d]Af78/6,++L8.J,73
7@ge5B:_W]GY=YJDJ#[2U9IP;<0c@:[OZ[H-_b0F/1b:1.cUWHAe&T8/@?a(8dXE
[?S54Q\ER(U+F#H9KgA2MN06_BEC^C)f30U8ZJ3\e+\gOM?0R7D,T49/KeK+4VXX
PH34)[P\Ge,\)dcU;SdD<9E1IP&46d/I3DWH:eec,E&JVVG7S[8,K<);I[]O]\Zc
:P;1/gW7LX)V<-+[WaCC.?D\E_RQCUPE:QOUg?U3U>g18]B5#Sd4M;(:,4>IV9(?
=N+Z6IE9A.-Yf2[?aG=B,@\;+_a&b;J;J6IC,FW[:eWG\Z1I4YFDg,(AYc-dSS2X
,6L2;+8W.g?I?f3&2@EP?ZC5WV4Vc1?[;0]QGUL]=B?f\<dDRVE\c-DFfZ=35]EQ
4VgY0H^SRgRM[3E?KaJ@\^P4D4bC4:Q[@9c&-;=(JO2=4d00P0>\UeGT@M65MP9>
b\RL;f9=6#7W:A+XNe._Hcc:H-Cc&VgY,e+()@YT55X#()M651\4&=&FEFP\?J-J
SVe+:8HPQGBK+^5B-?]78&c.0g]XA4?]/\GC9W^Y#I+,VD@OD\.CGUcZ?9b5_@7A
E40.E_6_P)K\/I,-/8bY4SUCP0BedHHY,/D>@1KN(Q(;.3(#8AfT\:HC16U12/;9
cSdG&_V;QZ)1+ZSdVOUO[4[@6_QJ[R)^LaCMQZ3J]@g(;HME-)K9:+@&&E,RF([7
99cDeVHfFJDbC\YJc49GXYCYdMJg<5ISX:.a2d?;E#>04(VbH76)?5,=/C.,f+-Y
KEC9-]eD09_-^];O4IZ6LJAZIe:B2M8eTV?S^S]B+QIKTI&W&Ud4-;f0DfJLO:1:
I#G,2UbS:7D1QcO.Y#fg?<b1e;#J6(I8-1US(Ja,UOG[VLG:L<:]]cd8cCJ0CDc5
(WeQc)-7UZV_8e]RNCK:&Y?)Vg2@bT]6=f)MCV@IQADB--DbX5D#e>#[V^V#&6<.
B(g0QVZA.dd(M2Z_,68K+ab7UGVFgU<P4N,;KR(ILI)>;Gc,UdX<3D1##D>0UX.9
UMEEcK7:e+JHZ7GV]6g[I0HB>I#E3F(XH?U;\YK2a(3+]JcX]7bG[fJU=ZVN^RD\
A.UPEP8\=;)]6(E=U0Ab:DbT&FSDQ9e)P=a47,aPUL69.cgcYf0BbVANdbW[TPD+
7]-VcaK]dHcJ+dJYEN]f.4,e\7#8=e8G#Sgd#TQKV[;WYE79_4J:;bY5FK2D?dWI
g-Z06@-XfXfXL_RQ1<8&5Z>FT?Z.3g1>C#>aI]e0f/#BAfb3_eV;GBI]<2SfO@[N
]1,g?(WMIR;bKF7ZOGG.BAeK[X)E,D/3dV]c7-/=WW^.X_I;N>U[.H?bM&,(Pf#5
D?f/A(bV0LUWKf4d-RVP)4^0SMTK>IL#@d;\RT#+#gO7;M//7L:\-]#_:E/,:(XE
-6aO5F0/4V9&J@ae>NaV04].UFKOIQW@2TQRGV0V97LC1\IFQVLG=gS2bCb)&=^-
\Q#<e#aJNMYCKXGcb7NAe4daBO\FC_.\e^#>K<UBc@KPg,F-RNC.;-T,>dO,J8LX
4Qd4&8=W)MBCf]PG3,YLS;4_AEf7I>[CD/]:O^_KV<ZPG2>)QZGJC95Rbe.A\79X
LVXU@==?)@[#50?R7@YO[R1(YTgV_[ZD\)8><Y.NLRRJZEJ^DY>L=STFMP\.G.5:
\[]b\8.=Y(5^,^_5aB_\CP?N\XPUR\CTT]ASG(]),<.5:I7=1fW?G=--2U8Z.XRT
_J7,H<:X,+S+5e,2f0U96?g/CJEE-QT^L;OPI<X6)MDgN=-^L_;aJc0:(cR6T,)[
>1FFANHb5LCfPHR)(1D05@3)aCaB,RVd@TDVIVLEeXCefTcDe@a1M2JO1b()379G
-@^\/45X41H.N[\0/dgGZR]AX-L23I02dagEC3VBJ01d^Q=M0DGRV+4_R#.<,8/S
0_(T+@ST@7#19]FP^)/P[@FD19g41,PY9cZb&VTeOT<58ZXaG6aSFcg5T9FH2DJ<
_DQ]VbU^3]VVf,,0H9KL^FEYGSBX.C1QBE#5I3D2U\6\4Jd6TKb:.;6)?6U<><@:
GU>Z\[#2&QT5bPKA#)e.7b7ce6^Xb+X,:W;7H5_7PQ89#]@PFOb]BCY]^YXXb^Gd
R)^MbOcYafP9FVXRPFT7@BIB0:.,/IOU;)]>HcgaC-/T\?4L];^U6fV+_4H\=e,7
,0AI]#a(8URK@M+IQ(Qg5Pe??fPbYSg>4,6C9SIEB8bH?+)VW/+99]SE()4F.<Yc
gTA[BRG[\-BZePX);H9<UKcHPZSP(V;J@YTdg;7K)3=-A?2;P.:[5^BT,4;4D4<S
X1fE&(M7QH@4(6L94;N[5?.Q/g<]Z5G27f-XNc#c;NEA=Z0-EM.5F,=-4bH#8?fK
:&a@WQ\MbJgBc<J4;cX#8<d;d]_2cU)A#UK5Mfe/PC+WdI=f#4f7:,/(g-^/eP;_
c(C:BXX7V5AXB.f/a#fLg52I(X0SQ5-.JI5P5\0H3B^PK9c>0T,<XPU(FJWVDSS7
@Q]Y?V:E=;S,?P)T^77YSSIKKf2OFZbb;UZd\)U=M&^8IPQYNHJbM#@Ngce(@c1N
Vf0>7FV,ABP9cJJ/_4;F1TUOH]W6F^S_C^99_.@8,3STaOKe?cQ[^Kd:,[Y4QYNC
?UJ?H.b=Ue8O:M,=X;38gIO0T[J6.B,@01JLKg<3D744]24H)J.ZbKZg#D.&TefK
)\_V\#;\0.=.(KJ)W)]2PF>L3DJ5BM#0VSZ#?=c1](SQ-.g;(K>66XGYQ,P#EBSO
EC41\._S_K./bKN@G/bOJTMJ#L]O&a2a)Z/c5QX(:bI(8O7S=+2Q&dN^OV:REM6>
.DM>/,G>7F[M?YJ^3PB04UTS/+cQJ6&E=7O@d[B)Xbb;TDN49GGc<M0Va>:=UUFH
(@#dF8I^[1G\OZ7<-IEd+3R)<P\H+H22GZ>>f&SI3IQ6_J)JQ6^<7dQaF[()=BM=
/1D-2@RS]A9)MgS:R-bNA1FD.6Xcb9XGQ\IWIg#K;34ZFM.4]8](?b+_/Vb4]@\=
e&3.VWRG]O[931OQ0K^[)\ZA5#aUVe::ZRSL2O(1:3KX7XE4NY=ga@13IQ3NY]K@
#FS7J7):LAd^]&_IPL;X]3<fP+&AJ=;5&GU&<UTda+c(I)YL=,ML<BUH0B\L=9gS
Zb?OR(CXc;QH,,a_b0dN+4++2V\C#:Zf?\BHGaTe-=bKUf.?TCKUVcIJUS)K63+4
#V7PN<<MBA+9]]eM+U7E?RgY8=J[-O9UAc/X+6fI=&PWF.5&@23LO[R5V+6YB,&W
&8K]8aI>f7FgBZ,:_=g0&73&;R?N\,.5]FIT>&<V@T-W/,PY.1Ke09JH52-D-K8Y
P3UN]6geROKgf/e/?0<Pf=Hf11Eb9/SA2+fY;cK0:#(NO)Q6^1\Pa9SVf8?4Qg;N
GWUBgSBK(RD1RLe##RTI1F_eU&+EFUS\g_:ZdD_2eEMc5BV_O6GeKd^1a7EGe-R\
6c]A4bP:E,gGAX)T<NA,7.=P6Z&:<:);FOd;B=>=;._>W;S[\CVcP[+Y/2PDY\Q1
_06>N,>,^)L>Y4b>BV7>H<402aDV#=8L)SS_Me)4S?I.KI:.Fd,a(,)OHS3IP4Qd
]A\ZBT2bY4VBdO]@2,GD4KVCVdOD]E<BNFfLQ15fc&]GcN\]a-&\^<O?8=+K/b=^
1^.L+WAC^S#M)1=NZXCO=(S#F+79]=;.P:0HVRLc-RP8)B@EbZH)SATaXI(8]QZ6
=6O3eb#D[R[X?^;Z/G7NW6ZA[T/TA^R&>U8N:5^L2:)-X/c-VE[YMZ0c=88>EW-g
8>E^IN5a-I_8EC\]a[Y@KX<;9Y-/b2#MS.N0K_>cY_M5I?GVK&WN-b0+DKBHK7\[
31CKAU7(+f3V,^98cL#&UYd(1?C[;O0DI<X+bZ^2:-<#-.[OP@W982(CK&c:#S<\
H/;bZgR,;PY99bAGP7?b+G&<S4/b1eIEOE<:>:f:Na4J/53\L7TC#@=YJ8).Vc<L
bCIICJ)S7CV5^=\<BTX-4e5<(8TN</.G8VR)I#cI1;H<91fH6WFMecM>C;g8^ZT)
aZ8Sa/__R\XHfQ22#KIT8Q]:]#-M,?<^8fDL8C?(c@^_+Ude?<M)dNRF]CU/aO.U
CcEA5V4LK1.6=>QX?(I>,K3bb[ZXB5HY>)E?<Oeb.9@3V@A2H(WF_UD6VNe2b#B>
P@IRW\?OD881DIdC?aF_YS8-W1SH?)YF,.R/8AWF5)>P-BBJPO4VF>:9<MWOP6PX
-/Q8cMS3&=SC2&L:(/D_IS1_D(>ZXI?GO@VK:Q#9BI@.,6F^P07L@7R7-bZPd+7\
O#g,BA##8/J,3WHfYVJPDWa]XW:^aK24IGgUDE..bT.=-EeUIOg,76?G+A<N+))F
CdE]?>a+>K0I3d<:N#OAA8TD]_A_;9GOe9We6X6[3[U79\;J.@:WXN@NC8MRP62Z
E#;5-R4[cP]A>>g)DaB.O.Za\f<O_EW8X]N<\:K<C\>7[a]-P7[WN+He9MB&&)A8
K[2KC#d<XfHda=E?HR6M.,5CD]:gb<aecDOKRGF+C=U\R_\\87fFK]T.F,H_5c^H
G5dQ).c+Xf0&;73E-A\;fET11T=c^G@ON;NWHNA9J[ZET3-.V;B1#D0]<MVdS1F3
8(.FXNESR:cfSO=ID_@IJ8TKTN)Bb205#c;JJOCQ[-e]E7OQ\R_.W3ee:J6316IM
1YGeKSFOAd<5c++b:=9EWER(AA_[Q89V:EHeZ0WXBF/g=f9(WLWQCW8f6[>Xc03-
fFgZX]RKWeLJa911Vf:Y(fL3e4W^F1L<0>8ETF7ab;[^V^)DQ,ZgM)Ie?04LNJ6P
G1KDDC3[?#JAV=EQPQH.@a;W_#=U><)N+_@;F7S6P<Y.AV.YQaI59>AeM=1fJgE,
[ERHQ;5>?_NWaD,C9Fc3THMC]S;643A/=7b/<ZNG/G<\<SKJ>b)5Vg5PC@@)Z=,1
-F=P8BEgb>>0XC4_0A:WSOY^84>>#aP<LBFd9AUVMDe=>H&=?PCTG3ED.U7MF57c
>g3LLBaV\+_-)_+1#)\H&c_b(,Z<g\2I=cBMZDa]3YCDcDR13;AABY8KSg2C(F9H
eJJ4O0@^@U)7]a9e\eR0ZF@QRR4Nb(RM2N]E,f_:=T^YCVG2bb[MRK1d147?3A_>
,6@6\=(d18AD?1U,DOVeW5gAbbc1(9DXg]69LL)R;6(ZN>fUAc8ZIB.F^d+49a4[
YW_RXb986^ZFIYV0]^^&TG0b8:?2K9N4RS.W,ADW271c)>AKLf:54O1E<,;fSd3W
.T--2P=C4/8;:5&._[7:B/Eb)9_BYD.IM-g_85aTc7_0^MOQU2APC6e7Y5ZOPD\R
LG6P9R]Xf)fY#?<)NZ2;6A>AgJNQ#X4DcW1(84gZ#.YEOI01/dME#0.GcLZ1_d8,
/7YX>=A\X,U0E_UBX8<7.DOEL:H&A4:?Kf]WK6H5R7VM\e?Oa0TI\5O9R6BW?9ZX
Y,XC\CcC#\I?7LZe)5SP/]KPaYPS\5#WWIK]g\V:PbF-#OTG9S3JF^f[UC&3f\f^
BO5D#f=dD<?NP<=M924,1(2SQ1TIYZAV>)?RU-02RHVK.F6S--a+,WH2@.gHH>.U
D4.S^c\N/\ZMR4.@1aY<&^IH8b^\\H=OL+0,W>:3\,1+bTM2a,7Vb?/T<YJ&;UeY
UQTJI1>_FPCY^-K)NOcQ7OGKVOJ#\2>3:.(8PI3&A6IFJ)LEW/;UFd@2FI6=12X+
]DfVWV.LU.bB[<NV-;H0dC7&KL:=UV^YGUTO812@FY9<>T<<E;ZB3_<3BXU&[]GM
gN.\O8S/V7;;_=&-6M\7]R3LNIKOYNI6FV4DCd/4.BZE^]@fe_HHP1LS3:]4c(e^
@0ZX^DA5LO+.J/FRAUcAWE[5#5TF/<4/U_RJc;=MT)g+Rc=+f-5-8TG=,K-fVb00
4#9-N,,0a@(V:]<M[aHI0ObJ1#[IE2<</Y897.bM_WX:3-NH#KG+KNURDe<\=)#M
_?3,IYAJPA[)<@[;FGQ5[HZFF:.1^59V6AH>24OK9/&22N\F:a\.]LX4JP20C3<O
2&H+1,)]1X8)M(D[)^9U8J+OFXe7KeK;\M3@>S3Tb@-LeF_FXS9]AR;9eN[OPX7>
YNUbRAb>E2f)+$
`endprotected


`endif
