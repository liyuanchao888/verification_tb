
`ifndef GUARD_SVT_AHB_DECODER_COMMON_SV
`define GUARD_SVT_AHB_DECODER_COMMON_SV

`include "svt_ahb_defines.svi"

typedef class svt_ahb_decoder;
typedef class svt_ahb_system_env;

/** @cond PRIVATE */
  
class svt_ahb_decoder_common;

`ifndef __SVDOC__
  typedef virtual svt_ahb_if.svt_ahb_bus_modport AHB_IF_BUS_MP;
  typedef virtual svt_ahb_if.svt_ahb_debug_modport AHB_IF_BUS_DBG_MP;
  typedef virtual svt_ahb_if.svt_ahb_monitor_modport AHB_IF_BUS_MON_MP;
  typedef virtual svt_ahb_master_if.svt_ahb_bus_modport AHB_MASTER_IF_BUS_MP;
  typedef virtual svt_ahb_slave_if.svt_ahb_bus_modport AHB_SLAVE_IF_BUS_MP;
  protected AHB_IF_BUS_MP ahb_if_bus_mp;
  protected AHB_IF_BUS_DBG_MP ahb_if_bus_dbg_mp;
  protected AHB_IF_BUS_MON_MP ahb_if_bus_mon_mp;
  protected AHB_MASTER_IF_BUS_MP master_if_bus_mp[*];
  protected AHB_SLAVE_IF_BUS_MP slave_if_bus_mp[*];
`endif  
  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_decoder decoder;
  

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
//  svt_ahb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Flag which indicats that the address phase is active.
   */
  protected bit address_phase_active = 0;

  /**
   * Flag which indicats that the data phase is active.
   */
  protected bit data_phase_active;

  /** Event that is triggered when the reset event is detected */
  protected event reset_asserted;

  /** Flag that indicates that a reset condition is currently asserted. */
  protected bit reset_active = 1;

  /** Flag that indicates that at least one reset event has been observed. */
  protected bit first_reset_observed = 0;

`protected
NEIBC-U0eG[:LWbITU)9M,1&^0WAQO=ZIY-.3CeHXMT,1MdOP8-34)MMI7:N0G>W
YY/gG9U?)[M:,$
`endprotected
  
  /** Flag that indicates that the dummy master is granted */
  protected bit default_slave_selected = 0;

  protected bit activate_default_slave = 0;
  
`protected
ec(?8-+V4^E_5Y7\):\9,dM;CR&14>XWMbg(+HE=Z5&@BcF+LFg12):d;/KX7?E<
+g+2P3QZ\N5_,$
`endprotected
  
  /** Get the address range index matched in the address range map */
  protected int addr_range_matched = -1;

`protected
bPTB_ZW1Y^)-9H^II]+FGPU:JG3[M3F-;/LN+_c,44L6L=5A:Ab.,)@[:55]6R\J
MgSK2NE:)11-,$
`endprotected
  
  /** Current address range is part of register space or not */
  protected bit register_address_space_selected = 0;
  
  /** Controls response muxing */
  protected bit continue_response_muxing = 0;

  /** Event for slave selection */
  protected event slave_selected;

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************
  /** Configuration */
  local svt_ahb_bus_configuration bus_cfg;
  
  /** BUS info */
  local svt_ahb_bus_status bus_status;
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_ahb_bus_configuration cfg, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter report object used for messaging
   */
  extern function new (svt_ahb_bus_configuration cfg, `SVT_XVM(report_object) reporter, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the reset signal */
  extern virtual task sample_common_phase_signals(); 
  
  /**
   * Method that is called when reset is detected to allow components to clean up
   * internal flags.
   */
  extern virtual task update_on_reset();

  /** Method that implements dummy master functionality */
  extern virtual task select_default_slave();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Drive default values to control signals */
  extern virtual task drive_default_control_values();

  /** Drive default values to data signals */
  extern virtual task drive_default_data_values();

  /** Slave selection logic: address decoding*/
  extern virtual task select_slave();

  /** Check validity of address, control info */
  extern virtual task check_validity_of_addr_ctrl_info();

  /** Identify Response mux select line */
  extern virtual task identify_response_mux_slave_index();
  
  /** Pass on response from selected slave to all masters */
  extern virtual task multiplex_response_info_to_masters();

  /** Pass on read data from selected slave to all masters */
  extern virtual task multiplex_read_data_to_masters();
    
  /** Drive write data to all slaves */
  extern virtual task drive_read_data(logic [1023:0] read_data);  
endclass


//----------------------------------------------------------------------------

`protected
A8U.5YD,>GGUaACO)EO3JP1I27X@Q4DW7gQcY[;W0>_M[LOVVTU.2)3F9FO-WP75
&7OH93Mf3VWQEf1.XY?b]Y;f43117]BM1bBMOL4K/PK=GIJ0+_YOU)669bF:5GY_
QfZQO5IGDN>)E#D@afV?)^:dd#Wa])SKMc5>0-ZcJ+/QgH=19W:]aV^RXF71N]X1
++.5A.0M&&)]09e?f&Jb)2M_Z>DMD:S):KF2Ed8Db4aS=bE)T,APCGEJP8\42(<]
[@QYfNa@_;=Ag4+33@MA5^N/GK2@A-1eLJcd^Ka-HKYX^[X&C0.Xg96<^dU9T[R7
dbJ.39f)0,L628H084;)aM\O+W8+<[M[5A4^JR^/A@,32N]41YK.TOQ?ANAKR.<>
X,67PC9gDe2S2SAFdLaM-:ES=KYJ(IH->LPObKX[DUG1L&gI#T;6JXJ<V^&2f44X
;DI7e4S)\38HARD)eB[#gO^KSCXS_[[/c9_D,;]aP+XXf)4I>:Z+,^J(^N647#d_
89^]:7Zb)ML):/#KCcf+(C[4/V,8G>A3LJ;c+.b8T/0.+f[JOHGGH\KE(5I?+0,;
HE;dUX;^JH^-f;GbTV/cU4VaVD2)T#(22-LI6EJM<ae_C<#+E)DbGg7&FaX#EU#T
XQQ6W@VCZ/=AN6VAL(VJ<=6CS.J.Y&b[(B.U6#:WA/NK@TPHDg(<NdQ)0C)I]W-a
0GA6/?LBPMT./E9833B\Qc]C_ZM4gF+B;$
`endprotected
  

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
5MQeWC3I(NG&:4C<HcXK/eYIZCd:ZF\Dcd9+@&a:57@aYOMHNV]Y0((DQ#b4\C^e
3O9(;#8NU63^CK0U87VA_0&48eb1DJdDd>;<IC5/(cg>D0)E1O1_gQUOO@+?<7+b
g=@GDA2f,9gK2c,ZRF(V#MAbb^O0@0be.#=]T2g)7fP_?6#[5[HSIWCN.7LbFSO6
QPNSM:1A(gFJ?&:bc1TASYJZg@Z[b3X6KZeJ@X(gLT?Ud?Zf+M(>P:0NMYAgC.5[
)0RKED4]7N54S.C#A#8e@8]G0YWXMO=F/K=E.c4QZ5W.X+:K?_0Zb0,QT<b,KAG_
(bgAG<VZ87FM9;1=W5U51WECT[XMK]D0T]S_1.ACX8E-gD]-fH4I[/O7.-&N@g@N
836UHb,g=?5Oc-WJAa\ccPAA4;/FJVP<FO95H=^8T=U^M[^C1e)ZdCR<Sb.a37)0
5>N+DJaKFX>K^]2.SgDA=cPUP_]31PAD0gF(T(MCAQP80O?;T=A/0BF=08e#N\Da
c7^D,K5J)?&U^:T9&>I.XeHRW_3Lb6\/7F[d#4gc=?8HI?T4a5H7,#:Z&_T-KB2?
-W:ZaHFTZ639MT4G;1#[D1:YJ91G:)Kf-9(\F-)10aQ@LP8V9b3R,0YZHX<0&)UD
76SVE-1[QGg>RUMV(_&71^g,&1](2ZE4L+.K[-C.8YV7:;c]TJA>SJW7-A?G4_Mb
7X--3EVRa4PN&_dBH]FI)3_8eEXWWD2,eN)1)Mc;A&Z\8YTT;2LO7+ZB=fYd1;V>
/4T7dc<.F233(A\Z,5V@ED[9>2+4M7UcK-7Md&+HY^UF3)9:9H8&.,=F+VGRZ8<<
c5\QXR)&)LbZ607YAS4Q1)B]SLFgR+]Q(0XMO,dD[cdX0aJ)fA?&U8g^<8UQ&&3X
RR=\)5\5;./\YT#1N.5X@U97A?@I4bbg:_K-XRe]CU6C.71Pe6Hc]H8<T4^]#=:(
HT6E2-4JcL=Ygebb20&=E]YC&6R:EL0C0bNYXW3<C/X#FV8FU)KDFEA0\.9SUQ@,
a<0IJRV=YEVA?_f2;0+@<#H;S@CeI?#M9BT-P1WINO8-PQaRIX,bU(GG=,cAgBP)
W2g:M2b&W9LZA\(a4/fY3>W/O>P6B^=3ZR(>bcVE:^3.E(7[XLD2(BLBEb8\R=)^
26_P98@#(H,^&Q?bSFIFEB:f<?>.HM2Rg7W@YO#N3=R#8H-?\YPbJEH6&JW@,04&
Z2^12JH.<I7>,8,8c1]IQaEUU9A8O-d?<2M,gZ;]<E2Yf7)0(TR2:K?A7OAEPEKX
&XH@\2FP,H:(Pf0@Cb.VVZR86C^^ZPW)_1LcIcebQ8W9\a,-+ZUe2L8/U?66<Ida
:)#/G[K\B5I80A0,)V<8=4<>GZ::4C07><7QA\bf8_@SbI)_JR(?-ae?3@ROD0S4
<2KVcA-.#D89LJ@3\(+3\a7-K8J3A+WVR9bOg=8NK?]K)CfSac9G3Y>TVd3c/PH<
HJJQIYP<HH6J(VM71He:J#dF=0P=OR?VR_L0FBIN1CG87LNILALD;VY?B0A0?BB2
RdF^WTbHB:&)50>H[-;Z^6=fNfOM_.CQcA93,4WIPbQ3LJY-F2BD.?.NNDBGbKYE
O(+[EcS.G=J5)UNfMY1S5[ED:4COMHD9[(^.?fCd.#a3\<QK[S9e4CSTW]8R7<A.
37g/7>(&>@b,ba2?V#^e/RdT3VeV3X.C]+.Y5?KYY0B(1?DBR7I(9cHR\bE:PIgd
Ag.B<3[3N+T)04P<RO^1#:ENgFK]=-/UKbGFAW<6OZ(SPR=.565M@Z@Y3C]]_/gc
8O18/0C_L?-2>A85S-GB]0.YS\I]^S\I3U?ZKDKc=5;e[C:Zf:>L0SW^gf^E3YM1
eORBFC2,I+Q@G<CKZ=[4FS4Ge2^:aYYWC[DB5cf]P_QH=^R^f-efIbND\TU3-,T)
A@]895O7OY21(e/C>Ua-&S8HCP.3VRScCD-#;28,eFCgH[B4#N?)ggJ;X@F/:a30
BcM,?a-]e?NE_E6Q=I1I#Q5#,5QcV9gMgN@?d_4g\Q9\6&K74@/6KR\T#?@)53E,
T66G_7Q2>7DZBbW4](eFWX6GdULA_]_JeYg9D8L:F1ARbA_9E8OeV:D9.+X@TAac
L9:R_J_G]FcDP2F<E.g6gHb]c+86ONgZ&4OfE9]\1ge(VFA85TNB=-U#A[6Z&>Ic
U>4Y+&&(+_MVO]Z1b51,LK@9ef2f0PY[[M_>J?;CZT\=CBadWbEFHb)ZO3J=?b&&
Z9)K\fT;JAVNGf3)HcV4YJ\^.WT0/NP8g&7JH&I?9NAc/eD4W\K4]NA;g6QV_E(]
QH/8H&[Y(BD.A;7aXA4(7]MUO7:^\^HebO?GYCY62ZYfGY<_K(f:RfDe7^O(3[-U
K1eYS&R+3Rg.(ORf?OK.SX\7=SA(#c98\#FL2P.G<BW\A/S<4P[ZUcaFaKUY,B\I
ec4,?T,>L#[eBMd(R]T:?:;F5[a6W40XZN:B##)GcOUDd^9ZW>bRG?bJ\Sa84;[_
^JU-W4R:Qe=0@WG5EZZb[Y>8MLLfg=&H5H8Q8BW\5-8O7J\>#5ZH3&><S;1IEO@,
DSE27S<BYI<Se_Gg?VS)Df4[IAI:+f@/bK-4-S3^9CcK??,A6A@OD9J[3=&fV:;0
3.>8b2#b1>aSEU?QBL_O+VH5^WQbb<:^IeEbHE649(5:P=P4JBSOMDceT(\e.WE3
eO:7]@e;?=N;aA.7f.7/eK9,-F6,g=<>K8/VY1OP;]I0MMZYA/-8.QfS9<3<(JRA
Z[,fRTaTPL<PQG\H8/Zc<&)9B^c)EL(&RbZ7<)7/@_-,=(.9YJf:T=S8IeE8NJGB
e#C5.@=CEEF:6H,;HP(I,XN1DW6URE_>WCbc:9<TUHP6.Y.b)ZDSWGg+8]E7e+]=
(M^Yb,N(U&IYX@CN76+@&5Q8T^Nf_4)BQMA1cAA[@ee:KS>JeC8=[DJ4;g:Q_9@>
Dd[K9N19LRSPe1+e/+X6<c8,f?8SF2D?2HOOMS7Q)>9-:VE(VJ[:LRM[Nb?2]<4?
&\.f#B.Ng)&6V:EPSG)g0#X&2X1DfV/WaS&?Y]Q(F?>@T,N9U6^Paa(AK?<V^/Wc
2?aCOK+5+Q)R;61ZRA3O6WF2TdJ-UC&c)DHXN-9MF,#:@(H?JU--DA;H7eMfSaF-
KD2<=\FL4W5QMRPDBaH0PWII?#+BTQe]eJ?D_^M]GZ,U)Q1/ZaTL13=M6WNFFN7f
Ze]/\@>EKA4Db52dE]<K>:IJ=?1C)(B3USd[=8Lb+K<&=)gQL,P8RMUX6O5DP>?2
_WK4+9KZ,1GP0_f]ECCe]?=C&I<CV_3;J(eSQ5J7S9@+J0&C]fI:Cg=YV/MIRD)2
6KS:Y><4&+3UUNdR.g)>L/W27g6eQE.GPO/64ePd-b=Q=NCD#^?(9gB7<J[V:XOc
K1;Q+g4K+D#a(5+?EA3)6,RT2&.@O?AHY8.b[])cN+/.]QP6JC\DXc.;O5Jc2Ye/
LAQH_D.@0g_I)C?/G.>La74a:1/]5f[[\[+?f^1S\^]X7Y,8(0A;g]cF55/UPV5(
H-KXVVf-\d;@C7Af&@(2EB544X)3[1;T\Y\8XM=W[7MSd-H1JO\KQTfBJDTda/g)
4)G^))Tf+GS<B:G)1</.9b;G;E9+.OC=I[UFGSF6+0I;e+,d6O>V.[BZUO.[[[5B
.4.R:;P79.BIW5=BK1d^[V[XQ<2:B32S28@=_UU?<+CF2G2YaO/V1S],6>>90(Ic
V&+^N&)=&;VZ[bCY[7\HTQfTCL,,[+&Def?XAIB0cVA(SVc,PXH8K55X))CFQAgC
:?)FGQ,XWcGG:)3Qa<V,D2bdW#K3G0e?-N]_dH:+/>dU\K_KPSAZ0U03,UdRQ64e
L?_B@M0A;3/L2RR(:aSbHeOKJI&dF[5SL7]VK[K81,SW]UTX]1Q/9A,.f)#_#eM/
(,(9^H2MNT<?KI(6.cHGR,@8Rd0X@BbO_b?>Qe@FGW6+>bE.4+.UFPTBCEFENYae
-.D]>W0\(.9CV.R2IX<#G<U7H>L0b+deT5;>7I.78\e1dH/A,\bQ40/-N<1GVg#\
M_,4B:2&(:)AUY]P4WZ6\Hc6f;7]X/VZ0N>YN=WZXTdDfN6<I0]K+_S<,CKgWLAO
MB.09+#@d0E8/?RX9,9M:L>W4>4TP#C#J4_IJR/L,AGDDdWO[EEaN+Ab3bXDf0T,
NY:,C+g>eYb_1RedQA<8U><G>AY4=V3ZW@(3GKK1#O;[#ZW152RJGYe0J(bE^DR.
<O?gK79fDZ[V2]bQ,YWJPbNPMJOR?KISAX:;[5B/;bU.dVN\7-+\I#4/@P#/Q9>U
^E09O\_W=W,_U<#)+e;c4.QSAU^ZN@V@7<MI8\JaE]GQ.d&2C+5-V1&G++XIc;/&
K,>b/gX)8TJ3QKYeD/CH\?P+?.J?X+e03>9gg=>]P7>6IGTGJS>:<W/NBKMfObAQ
2>,HL,GV3)E>:][+WSPOH5PO&gIEY1)f7,X4bWLB4;]ID7J8<]X1VMRT.PfY]R)X
LGF82aN/87T7(D#K4C_+g4c@F@7BVB\@[OO]gF#T8QDdG3]3Mb<,&#fdAZV[=)ZI
&\c&.1VP@AdRT];UK4[Z(e(RBE3I8CYVVL5daJ[cMYT&/)fdDGDD<aN_[_WAWA<K
Q:@,@0_a,1PR;3:e)ed47ZP8,-@-a.NY(&\-SSEa/P2PV+P@(Kb\MJOPZ0KdZ+VM
W;OGe]OB_:c@aB.^f<Y7@>g3.)YX/c,&P\C[/(5D:9C]<f/4GI]aPF:GVU=Be7a@
XP=eJVO8H&9L&f7-B+2ggb)AY?3/3+)09X#DJF7[T-K7B-7Qc#E+.D9ME,,-+?5.
H_Z9HJbIX\OaaIa&N;;<WI)A5$
`endprotected
    
`protected
O)L?9gaBHN8d/UT]5ga#)V-D2/P840481L-1fVHg+S]f#I346Wa,/)g=Yfe7=_S<
<PZM(PX^d7Md0$
`endprotected
    
//vcs_lic_vip_protect
  `protected
Y-K_E#+.;;[3Hc3T;b]/T1?Y:/M+JXW&2.UgB<KQ5O6I\9I2<\7(&(-_=FgSIM0+
#:UOOQ-O=0N2eOf3D0>.Wg;JUFBcdKNZgW\SXSGHZ&<.]2FeE(=cNHQg9D<@\C/D
aK<NfE3J-9O0Y;JPPg8^+,[.dNLgW<[HJ8^C1O-]V@bKGPQ_@a5Rf?H/aODV0dJ>
]1T,SQ65\C^Y@@+6fJX(d8IKD>dBOLZ-&>UdcSd)R,H+c;_S@25ECa]?WIZDH0YE
17>aJbDG2B1\&NLZJO>1ZVP[HDPI3I:0_dBEU2H)3BMNLaJC)g[<-?H#ORfFBb1e
&^:-E01J2S=J96SB>a:UI0)ZI/DXO?\H2N/TCR+Wc,d6eOT//0K?\Me49EVR98BZ
V^ZCGAJOV_2+^3JWQG+VG(DP4QUP?cT)\4R>&GgI#b5FWP[:M^.g]:M5bAAK_[HC
)=5ZLLN<e#IO-4=B)OI@_3fKOWEb)Rg@aaUDE8.T5QUe0I\J5E>;V_[>/WZ2HP;W
eA^GA/@L@:5&fA9=Ld[Fb-<8^\Y+#Q#6YUSeRFeEc4a@?L)G1\5fOWfbE:=FQa(<
>F\)U:H10EZg1O]S?83e889^ZW5)ZC\CE[TC=)13d11B#Dd00a2BO_9H>f^Y]PK-
C=[RHG=5MR#15-/1D\R3X[N2YOd8U#&Qe19&=;PD0Lf/g7OR913Pd^RAa3AY0E1\
Ue3>ERQBAaYeE5\:SXPU0-3bf@GUAH-\\(@OO4>&OQ8OJRXPC?/gb4c0L^(HX3P_
2[M3#&@g/Z3@Pac?g?\_2\U1(2f8:@S;0H7d[;X/HG<^-f:\U#Cd)LaTZM?G,/Fg
Q,]?;(D(f)H=9;7UE-;>.>,D;+ZNG?9NF>A1C8&Hf&H4KOJ4S([E#N]Ic3\1=[Y4
S#KLF.a_<@\];=1gM4+EW#,#LVJ<P-ONDgJ(AA06S9+,Y)0>A,-0WT_7E<#:B=Sg
c(Vag7\TPL1B/e[<94BaR9bE:c#S;f#3P[5/8+/g,=c71>SE=DWU7\/e>0@EVYba
K#\]aL,P\F?#34=-RV><\3D]YJ6,2e_3VZ6_R@2IdMGf-[WbV13cd_Z:gd8#V(e?
99fS\8:R:A12JONO_IKc\3V.80Y(F9(#dD7_df&2G6@;ca1>@=3Rc@_9-NcQCMH+
Zg+=c_+^CSdRe[1&BB:5N;@=9g#a&bdQ2N&Y;L#:Z\e@V;FJ6Y9?5f4AP0U/^eN)
&<.b4F]>MG]0cCCb-?V4[NAc(3AN\ZC5A(3=3F)bMK/RRJ=RQ8BG.^QM=3V(e?/U
DW,a7VDP>aYX^R=HV-JQ5(,L6N(1,0O8g8a?=QCf3\gBF5GJIL/ZSC]CaVJP-T\0
3UH<^@4S2_TXR;[S_F:@7NXM[_3I3-J<7=(+8,HPZAX\MLT18[3G2?+5--DLZJb8
T#bBMGC#0,S<Y2-6-ND8\@8/fTOBbQVc#bBMLcLg?+,J17S@>Nb2H(^<7O\1FdQJ
:2X-=>V<J--G[@-F<fAP5Q--3_^JeX0@Z3HT41@\D,b:UL.-Qa6TG;=O1T4AE6R.
gYA;;KT@PaWJY[K?YYe^CT/C17X3B@(,-,3dLc>LVCZT>[Q-f.(7-QYc\),aNG\L
a.CN,^YION+E+g:7VD50+dK+@7_D3:OIf2-(-YWY^5MMMM9:bFI4KeNaM9Y:#NUJ
eF,CPcgX+I60fWPdUKGaf)B8Q94c&gZ]\^9&fN?9:NL^L<]KRcAM5\0Y4+Re[PAU
Mg.S#8;T&\:E:aa7/VP.6c=8aeUE];F::T-3N56(=G[IFZ2\B(MX3GQDL6X(&.RL
Z?d;fQaPcCgV1FVTH9XcO(A^X9RaI-<4(-2(1,APdVd.gcII7(DH37J5UB(TXdH7
6QcZNX?)(OBBDUXRcdP)S3WD,TT+;>27P]Z;3=Xga/0-NIOJ.B6DGPe4f?75gMSW
>Pe.EM.(T=[OX>I8(WBFAJ&0[2H7]:\(+3-H5],PW/AX<T&SNM2()5]g>+)&<]Hd
NC49<O?^@6V728KG&VeA443=DXVHLcac=g,GN#c\DDeG&3KET=,gJe<fXNTQ0)8g
04<:Z6T+Q8OReQEESD.gDHG?A2D/f7Z,5)eV:\7cYZQY+QFR\FF0;1LX]6XC7>7H
07Z)-NU-YDdZ.:B6IOX-19BDPY2&-cN6:([L@8>SLM/NXPH7RC1V2?,>Ib#YBURb
N9>+6b;FS:V.QHXgbLEKKg)<L+Wa>)T^+]QB:f<8]>MFX9Q9SQ?.,Bc@:3Za]C06
]gVR8MfgO1IQN#Rd,c8L&S79HLA@[d.NMJ6S0NL6@#D27#;OZ)&BE:F(>F>ZWH6H
C/c]AVK8_LgV@&e?I/Yg:+MF_HU#:gd+Fa[3^3<a]4[?(e9@G=RQ,dX^VNGU9:+)
W/663NDa1UIZO-L=/Sb]\>TaRK^[;.N0S9?BUaFcd-W1@;T]bQbH&]L<CDWbd>XS
aPM:CE,f#ff_FV-8,1W/H][]]8D4&JKT#FF4+Fa3=Gf,g?Y6#>YO6Ibd6UBZP4FZ
4J&^e5R9/:_T6:D<+DN(?[g4+JHeX?WM4)TGObG&1-MOP@].VC-9=-B4(VbV?&<c
GMgKE1=<fM-54\#P#I\]3WQROZB)(GN0Xfb:29OfF72P_ggTA/3M8,QC\(_OE2\R
P.8.__9J3E)A^AAg)[f;]T(5?R3C14TZfCdP[[SgI=J-7ULK-aK#/UY.c&,YN0XO
(=#Q6WE&NcH)KAPX?+>CgCbJ^4[gG]SPd[^14eB-[G_+E7R^f9@a3?GT=3EI/]4^
Q5YK_>B:1Pf8/acSg:7&)GASSTD-5f0KVE/@>X_M84>GA^L-#+ANWIQbAQgR#:2Y
/d<d0^E/ZKT.@_>e12M0<+7I/N]F<+U(\OMTgc/.=HJBU,I@NTGO&U?X42f82_UP
N]fBIT.)5(G?[#6QT4Y3]4/a=Nd]<-_R\?d\2E?VNd8[\8,YZBABc5,DQC\@ZVHf
8(b_)CLI2gg7MR5BK[Q3H4CO-)D#<Y>HD([(3P(Waf?dA=#RIWA625B^&\FLTgA+
2KAMO2I#J(?2T#<.FC6[6c@TS5Od)3aU&+T;EcTeHUB2PFO-ECHT+fQ0OS9(+K5Y
UV(KZ89IH.UE#_U_9D)VaHT=D?cMRSY\LHN-(A[4QG-/Y;61<Q;/4Z#Z5GG9f(T5
@K;8e(9[X^W6C^?43</GW79=cZ32^^87f>P7c0@+HJL?=L6-9TfWY\.A>EDN-aX+
,fNV+CP_3KX)Sf;5Z\AL.Q8Q5-+_GIAS6NGD>@PMLTE<XL#bB#K3?VZPSNCK9-,4
W7U;)[5#Je;]G]B.U1UJ4GDK:>B/\L3;ZEGUR#:d8-cRf;2^5AIP\ce5?8-b8FAG
[(Sd0fM<b14(7>YL@0JS(@0(HdB(M8B.D@RT@GS:B5PO\LA=9]WWEB99T62SHTZ5
19[9X&Vcd:;:G0D,P>H3>#gLZJYFJ?WdTbBK-(.Fa[L->H0fRCMQ]LS88+6][AI8
ZHR[Z[JOOgcP:XHTFX8U-7KX/PgCW+G)I^V)<Oe=fLKf^#@6ZK<+EdbL9T#bG>()
O4T#TaXQVNC?eSGL0bUS/E3.:V..&#PV^d^bUXWf3M^MW04WF-@9Z(_T;&9?P]1,
:=8g_+5C-9(F=4^#+^,aDa[7+agDL&GOVeSIb@L+e4Lba7/CaPS\O&=6YL:N[cFV
AEaG)S1KEG\CNH3D1EO28^>f3\VI0I)d1:_[N^1(3LWY,@Y7BLQ0O4QMI(G,[U=\
=fI3&#YMe@61V79Y1HH4A)914GRa]Q^B=KW3Gc>)LXfXFDCW>PP9(0VZRDD;aJAI
(G/X]=.H4_I7.@==^3N6E8JF<I:Bg1g8SB4+&0.c+C\8d?;0[]c&S1>LBF\fSdMg
G-NVf7C3WISGH:L+=GTM9UW#O<1X,(,9D+@V+fH##e[=FD7fQ>-K[JF.a4E.4gMb
XR::GNR.Q#f5\#aE3L<9GY+Eg0G8_)[\(Z:4Xe\]1B9;F^XIY=WNg>\.J64(E&W=
2>J.K5T:XM,1YVER1d5MIESIVD)RH/N/P=))(Mc6c?14,(?X^^N6AdV.XQ2O=^LM
g<T-[)(e3Y:eB@RYXGU@II16bY_QMc.6QK/A??A>Cd?=&XD_<ZX+,Q_Y\^O#fAc]
KW[F1U,NQLI]bQJQ?fPB@X)g.g\a)cW1;,e1<^F/>:Rd_d9.C^7MaN27(5U]7^b[
aZSXEOg]R@gC1#_2^]QICU;14Yf(;CT[<GEadM:G=SZ2Q\1-P,3Db(T)?f8Y:&UK
)20BCfK2AM;aIfX9A.fgXSHX#V2eV6TTCU-ZTA6?8CT:E+NRVB2NCQf/=<dQO3[F
+@(L]RB)=JVDa[_2IE_ePSI7XWWY5_5_Z_LgEO<UcW?MgHM/:[87&/B-@#(f3IM@
G4X+.I2BO@HB>MaD##eFPb-ZRc&SKFPQ4KU;1B,LWbIH[Z75/AL>+7/?F6[H\6Qg
ZeNOc-93L&QO#(\65HUZ&-1gK=AKO.L/M>10fJSCa_AB.T(AMU/#91PYV9]HSX3@
^c3VVLFZbd7?XFDYU(W<3\=VHMcV,BM_-]:OM72bc[aG,RRdST)AM=)(>g_.e0IT
F](^FLCK[KE-;OV/PSX8+&^/;+HM[J3:5=@K@dXGe1Q)XUS2U&C(C8;V)3[7A<_g
+;,(?=?^(7<dReCX?XgV6EWL&]\?22,CGFc.EFe>>C./OE75;[X[dD0.P6(?<eL.
<DcL#M,4+ZGHW9d0C6>_(,=)E#d?YWZOUFZ7I&UO5f]adL0aM9g]]aNG(XL.-9KK
WL-_f1gU15gV+GR5Mg3E.14=N;.#ZYX-63W=JRbXcSgg:e.@[&6Kdd?96^?88U8P
NO@LB)M@X&.:077]0QE7^cddCHQcHe;bNGdR+R[.S^S\9AR+d8DTcM_)b0b1-_9:
B52GF\R6C/CS_M/PU,-JIEHL[N;@4R>8]TDF5:9DO,>Z#fg)#VJ2^+(OI;GZ>LJY
3>gA<>[TZ&Y2FQ[9ZNcLB=2=d4V&f,_+\)>#F=b9P=ZbbSJ8^DdKGR=-a7XF0&#D
.V5P8LcFJ,W6\0)C@(GUALQXP9Z2M]\7E##/8YW[)GW3HM5GScXB,@-YK?:[6;bJ
B,_-BW)(0BCNQB<1^6Q#P4RV\K\]9SgM2I25bSDP>>(=-^E39PCVCfDE6(?.30K/
L6YK_d6^,<IVNTd&0#b79(R_1>1-HIN^3>N;JBbW3N0CAT+7]O#??gf^L4g[g6(d
?_9aKV62b>/PEHBH&=S_OA4-#Z?;/B&WEa(f6P8#CF9+>PBd83=;H].Zg8VZc2GJ
8fZfOO=#1;1+3+6aX)VWE=_G=7)9=?(D5:7:>+ab]BW]:)Ab15&+K=VS4TQ&T5gA
[Kf7O=&JERN5JX@Z^V&Y#FEB&a>;(33<Y8+6NG<WN:OTI:ZK1?YVRP_e[2>aF>ZX
CFG7-N^TN-ZLU;LCcKKKWaYK5QbQ5MY@AAaYH_I)1c:^6fHaBZB5g-#MF33F.BM;
@7(C?A]7>M^1CePO\6FLJ;.c2O]f+)?/4;)Q.KGFbUL8JW,J?.TYPbQ6-BW9NV0A
L#4.c)-M/GKf@UW8E58H#MHDKG9M/S\a0L)6JP2J#UE>J2SPd,&5D68H>,4VJE+A
f-+V@F.CTFDC/_c\/LYV6gNa0a@3Z23dTceC#IA2G@>U79<(0Z;2?0.4@CG69R#0
gdd>C/#=MSX\Cb2Q==KEL7(S:d/3eGBI=2gf&>()dEEHLTC1E9+&Q_ed/^HcH&Z,
0TgJH9.)M9]6<CO(407]KDW10L3Y5aGdaDX\K+]:X\cD;.M3C:3&=-EZ)fV?B68N
M?gYZJ:26W^Y<BM/TOVDC[7ZJH3d@)B&^XB>d.KMW](ATU&5S?3Xg6+_HQGE:Ybe
2)MZCG:a/=Y_QIV5/-:LLVegX^7W1g9:)a,XL6MF992Y:WA&?4U](_405?^TdX:_
X:I1+4X9:Ode]g[CAc3N9RMP8YU]8U_McOcKB<dE=La[fHPBPWW.Zd:)bN\8][U=
BKVC;WfedQ]H>We+-,dB3K+HM4Z1egI6)c@KV\Y9OFCf_0,Ue4:B^-)[EdCM1bK.
Q0WO+V73HL8,Y2VJe_g_e6)XZ=BLP<>2cGD6ReOHSBY8;R3R=<<2bZO.@=;5:9UT
8>_:^-K<8W?G,/R@0D.BbfS,2P><PSV@&90<>A#gg_4U#5@+#VYNLYNgc6E5O-Y6
Rd-^85=.JU1)](A-<[O00(6U5[g[);NHHJ,6TQC7S04fHB<XBZUHgMMIQ#d8)YHI
YCS+.^;]<8)I(\GIE8).)B=0)aL_218+XO(]3?PZXI8fEaNdDTf;9DW6S0)_aXAa
)@>eERRKD/D@.SC6LL&Q62Ke:?B@7e=Bd6/@8FB(9XRJ(0S5TRIJ#[HYa1A.,>RF
8CRF>KKefSC<BDGDRRbbVI:1Je0CD9ON,eKZF+)IAcJ6P_44(UT5+Q>HF]K=6=@a
,H<0E@ZUP[LM3;PQ=d-_1C7H_Q:HU=\O&I<^TaNK5T@,QLg;a&cG^X^,BTd3QdN>
Ra4\[d#cVc1a#45=S9KMN-[J^QD1EgV_3eI?05^1\_Z-ZW=:ZQGXFUAK-A@TO[P]
:H]F#75WPWaX7]RD\;e4DYA:9HZCdG-+^YL>Og<FJNWb>G<[NWg&ZD5P7fBB\Z;V
9+<HZ2-RV;d0_V2&7-4e(<=9#?TMC(@LYD<R#TJTM3K55DDMb^W9&C\_U2Y==5OP
N#.@7;D-J29)(/NW&S7]c5]:WMa^gVLbXCdA9SUa.8^#^+08L?)EH26GKe;[SCI(
\c_JX1)a.001.gAILH)OC8,9_PKK^O55KHQBC+R@;T0bD4DJVV#DR\5^OF8F-5OD
37Gce]G)b]&CNg^b)HP7Mf,H+_MQXR#eaBV1?-R[\CIFcPYO5GaM1O(Ca2d8OF@9
0eR#[X,fWb2PXY]N8c>LcN_\(4B<eA7QO3_0]a)H2U1PH4gJG.a7cW4-82Y:AZME
O@N4J]5+^VVd5W)/8?.;D5<;D2H:PYAO;d-@afIKaE=#ZS;+bIa6bZ#UJW:]Ca=A
FR(g<#0_^/<I^^L0MfP(1MMMC7dR;8)1:8gCO1_D4#1HLN>J7:=^cULeUFbYRO[9
6^@g_+O-147B@eK6)).<RY:\-5R\.A9aO-[6\7/]3?[eTXe&YVJe8?.6A?L^Kc[N
Q4TF.\>gEQ7;Sgd=-75IXf;?S+R9a.7A)4Wa2A\+J39O#];@c1(5RTf7-fI3N:PM
=0)e.BM=abfb^,8>NeMLR@aGb89[DY#LF3?D-RAN;gQ,#5MScLDTA=057WE6&KZN
fU8S2+T#6XM@@/B)=#]?X)_Y:V9D28)ZYI/>(T(D:^DC_</A(L)8L>HXRfNV&PZ_
DB\4=9Sd1Y=PWaUdQ7..=]M:c/^.2H;.JI5HBgNL4V?RcB@-0+.21K2_2I^F=f-1
>^adC:b&V#O<0K<R@<WTCOL09\fd5Ye^_]--D\L>&YgOMP5EY6Ia(0KO7S.T@c2+V$
`endprotected
    

`protected
GAZ=G8B?E;9&W@?M?)eBBCG[CT.d0Aa&c8?g&cd.<f1H_MHcQ:+44)AUPHBReb\0
>]fFO.VS,e<<>gYcZU6ZR0G[3$
`endprotected
    
//vcs_lic_vip_protect
  `protected
3HKFQMdDRb8E)P,@+V)P7&M8D<F:SRBRB?a,[g[_C0[B)8REN^>c,(?E09-FBa.&
(D;@@XI5e8B.G@:@^&PH3]b8dOSG+2PXZ\e:>W\A\ZQ1,@_ZA;f39W2XaQ3cC[f-
QZB;Y&=8?OP7L=+W,-g9X>fMQ<M.MLe)3RM5T6V5E:@;fXdA8Z?&GbHB4#K+OC,,
8:\4-fA5@-eUd4L=2-)Z/:-AKa&]\7IA^fg/.E\\O?f[].;P:BILH_OA:a+Q45BB
,?Q>:SEg+YGKOOQFPa.)^#[\C<5--9<EAZXG=a)=d11.g)CL5>D)^a2(.LcYW6MM
VZ8VS?5^NK)&7fQ8:P??PM\\Wd(W@[:4d2R7=I[M,Zc-WONE?a5&W^),N\[eP#^3
1W6]V.Ya,(SQWF3I1g[0R<1TSF0G#eZ#171AD9/5I1<UU52KF72QZeCG>O\+^G)a
.8#I)F/b+4<cd<,W5^7Oc0SeC1)&)7Z0MHE=fVJ.?E,^aIB:MGeBddbcN/1K-]&/
@WG:[2WW7>0I7F2E-.46C#UN[<)]X,M6UFU<AX</P/NIRD)a?YWaJU[3-(YLRX:S
88JYY2N?7CW1S[>MH:P/,YEW08Y7W+UB>24NR6fN(c37QXE.DZY05-1;PTY.TADO
@IM_Q?>S.Jd<6K-76ZeC[7b+XNPf0G:6bdU,SPB_WP)W26(._@_cX=2OBcN5(P^]
D/)bXK?/;eO30aFc\1SE?;Y7La&&^V..HX=R,>C]_5T_NHR-6a?5?g8(_&T<KQ8Y
7<b5,=HfID]&Z\3A092Y=T-C=^=B8Y3O.S]BXQ[YP@5@4JZeg5E,45ILdKD^JF8:
(e:;;#VLa+#C9Wa?FYO(\.Y#M-3+0A\&:EG,fZAA@>:/KGAJ8(P17YEW)YL:H57]
c[dD&/59/8O8)O@KMfbD2,[&.gF&58HFPI@KLba;E]_FD8W7J>f;6NCF/dT(fg>/
;,/f6\C8KX?bC;ME#)#a^?SgQOYa&&S9Q4DD#4=63>eE>-dX<HB[[E]P=5^]QQ:8
\4QYBYbYJ#]HdNaQ;Z@4,W(AbWKO&_,[S&?<I_U+Y9-_N^+W76[<<ef[[adGP02-
;-D1@_5E#+3BMcdZMKIg_f\/5KFHZ)V]?TX[gR#&CI35a0M-&5dACDV2e0?B8c>_
H0ac?L.d6.^1I?R&6_fA8HA;g]ZJKWL(\A=WW..;R(+^fWN@#XFI/dK5-M3gdN/)
+P4RcCc8a8fe9ZO_g](,(E)@D\W-?8Z6V[_U(+MW]^789Z-3D)@3RF+MPY>K[&;#
NO7LGRc0OGXF7M9HD/-AW/DDNFUJH-W398YVS?Z?-V]F<6&\-=<\dT<=<Y2&XGE#
a(4CG.3:E(_#&;7,]L2dLK3=WG9#ZL6Hd+HI&b7HAfAPBDaS?_\3^\QM8KF/TNPH
>Tc+4]NU(=;b.\/G_@1,OSe7L.2WdUWgaNS(XD7;8#Y=Q^S^]875.6#bA71EGSO@
81A[C7F&c9BO;XW1fgd8U7<&&)&KTdeDac-8,ECY[:TbHe52d=KUJT6_,>V]@^[-
:XZWfZ1C\46X/X_6#_bBR68+H_I((L(J;U<7^fB[H,4:(V&-F0\(0,UYdE4ZXC\e
Mga]WQFC#0OAf]9LZT(\1Z73XU2_]V.TG>;D4b82IS.WP,a:G9GYegV?#J\OP9R+
2FL.AVc,D\8SV@-WHPBbU5Kf[9)&b5\7aFOb\>ZA-3W/Tc5N.Y[TO]VLUJF?^D+X
AZY/bBKOSY)1Z=-.+?GMAJ>Bg+b-3\VN+4<6Gd5KW#[fbR-?)LZXRE_R?U7JYXf&
cI/):]OGB()\8F]fTPRd2LZ,,#.:F^3=[]\+3X59+,Q?B&RM4>ACRA(OS:TdR3YY
&1?>KHH76H2UR[(NZ0A/G@(/-RZag(VT;6KW?PO=FBKce0S=8_S[9Q];Ie4\#e,&
IQ1)]fcM1\3<HJ><CMME]NdD9FM_2f^:]:BEQdgK9T;K<T9.fKP-R\eE-0,Q\,Wg
XYFZ=8>&\VW&+P?I&K_=Y)H+6(0/[FCX_g(#I_P=#\d8:/F1ffK&)HV)b^Qf=2WP
+D^BOS4b;Q>HMN34^CEe\T935U/,3ZM&UM0O<bfNR3#BQ-.#XZEbI8YIR(V.AIJb
E3@Ug(e=@J?f^41a^d(^Lg0-gVP4L:T8:;@dGU+)_P^AbMCUM6Z7Oa4DJ7)II:3D
A)+:CQJ]aaIBFV85O.KT\F8L=JgQ:+N+JY?Hf3:5Q>]eI[R74(V8MRc>LR:4[aI[
E@S>dX1L5.B.fW&T+<DBEF-/0B_L=2V[=fVQE@#-b(O5<^GRfS@&#4Vb:R2H\f-B
>L:+aTN\JG?X+NF+F47U]NH<3NgVQ?](:-HP>&;KE7]W?Zg+5P<b-13C\,BMb+65
U2Z@.@(F1a/H7_b5a(bX:^KSS9UbPM-)Y?0\F.5]b;N7?E30:;X9O7^G04fO6KXW
cZ7@AFZEgMd2]^g9dgL@?e@FF(b<dfP7+3(D2^N_0Jb8>F=92d>YJcAdb[gaD,Gf
TVc96C+(EEcV/S_1dgK_);GUO8e;+0@#5a&f)c?e1dV:eF#W<<__Sc40M(#R@/@<
O7?<);VT+E+^;I=625N>O\XK167]WA2MLV]6SG)\Wd[_fX]M-&gDDM^UDXQOM=RI
)QeP).RKW)K\M(>cZLeKOc5+G06ge:P<Qg1?)0Y[UaN]L3bTC@5/84H:>K^D9S_H
caa<CHF,>/,..Z2N)2HH[gY#;6D09MIC+=VI8bO(7HfgWWO)--7[]2>M@)E8]QcG
dG+,Q@P(UEZXd@,F)E-fH7Z>FC=_IY/c^LB?U78XN?@5JDVO(?fOb.&e7M24[Y+S
EbX^123U^X>=ZaTE@KRe9_)B_PcC?gTH584\FGMN?\JOAefT995F\1P&-V9O.OJ:
PcHd1Y:M_e:G-#3BIFcI7YJc6P]g1EBRII5b930,A9L3e>K6[)1eUF2DMB;&C,Ye
S#)^S^:U(?91&U?&-5C[^;dIO10A2J0=]80[7DJ\1KZBQEIQ?Nb?9Y@fc3B.UORJ
cd]?36,I-c#(L3V13Z>.JO:c.@8R7S&Q8\Y?6Pa[OD\a.B^G41+2-c5(&e)0,)0>
<#8PTB?M;EMU]MKgRM4c;7#M0YJdfN1;7-85+\#DMdfNM_PX&Ia9EI9JKgaTR@S8
ggbC?0B.7EGQ;.Uge4#&0OB4gcU8ZCD7De5\KVD0Ug<=S7f9eG,71eJ=Qc/_UUTe
JC=0O;Y2]O+cISd\84f\XF58>74((P2<7XZSHKA/#-?=D19aeB<MIc]A]@F]^)O?
?F@14W-FP8R53497-7?&g-?K^81@3]5?TH&6#IMWUSc[\F(XZ>.EcdL30VO8_W(X
T8Mg#+WWV)P4N8f^4Me\Gc0==V_WPKGK96Z;F4W4DTN&_ZL>Cf(I:1QIcCNE.-?;
IIK8>^):Gg\@4,U>P#F[eK1#;4g;Q\O#[7&\88Og[J&H-4X\b#+F8U58\TPRH2ZV
P38IIRI-0R]U?YMJC^DK(B@2@#VN].B(F0AObd?>,.J0YfP@e#SW1fO_OR&#;?=#
QD?2^N8RAYLXWQ=>fZ=4(QITd(cR#=7AT(JU<7)TJbW4CFG535+>9FJPfGAEAeK4
gcU/b/<e#J5L)J]L5G4dCD?C-VS:Uc9J82F=/2RGfPfY#(WcX41e7_2Q3JgCZ(Ff
A?0KTWUSdM\-NgBA/Z/69V9da=Tb/T>A^R,VX.=M;Kd,WbMgQE_MUHSD+1;-IYfH
f-(59V:6HTa:EGIa&ZM:X35/V_?4_B<(HG0K2HX61dc^XU0TdPC_S5gUaZY)d\DQ
IS>TQ-NX-:C9YQ.YbL5DQT^T1.ZDD;PX&=@ac;LGaU/DJ4eO(BO6@GaW4,MRd\N2
/#0D-=MY:[EJCUJ6LVVR52Z12IQ/^3dZSM?/b?7I4/JE=YPWM\MX8KQeROBUdVJf
)SPD/Q>U3;DMf0=c/DGN4X;a7g>3\5eO@@S=&>ETcbI8N)(^3+ZcbE/Ib.(N\2>L
_SW^Nf2-S<Zb\W9)Wb@4MBQ_fQ?\C8N87b;?0b,B&EVJE<E#_/TUHO#2>e^[R,XT
RQLL--BK+C3UFTX5#IR2cGgE3-&AS_24,P;MN)PXZNgAU=^gS9C,FUAK^9::]1GR
.DO>:SKeDF9NHbVQ@F,HQBW-<@T=]aA?Z5dML5-S\c:I?TJNU?;bOHF99FO1aYH>
)[TYX5Y[fULf4;UX:V7[SACfK8C:9#@I,GION<>&)+L?G_Q^=@0(EKB.J-7=ZR56
?H3<P^&e76IKT8:b)IG6:0d/e)9+3PFKLHQ#]g,<]RVM,\B&1_[.+JMXLN]XBQaP
Cb#AD\&0+O.)JC)3P:eAN;c1I3XaYO7eQd<B6B-3\9FM9f,WMdE\KcN-Ef#:U]/+
IA5]ISS-QN)H/)8?F.fSHO4TW[D^C6[EYCI+G+Mf+K/J<J4-Z@JB(+B@af?50eR>
MAYY)G#-[f]]=]AZ8UWM:P8W)^^E.N>Pac9O[130V<);_GKadWgLc>85eCb4MHd^
:M((1;a49O/V7?WK+bcE,4FTaO1,,W0HUZS0fN=#C^8I;@DT>#TCARZ0[,@_B43f
^DNQ#dMUORg-_(F:]^9Gc\8#U5+HK.I,7fIQ](/@7R.H&GH_b5/^_4.#+@T7Tae9
ZZMLJU;L/-:5&Ae;^(f/f\HTd4J+SYe(Y7X=;;:_R7S)5>&2264bRH^N=H[15MFF
:Hd4,QG7OIbQE&fBD(4FAQ+\Y^8Q+2Z]][QO0,6dC6U:K5_Tf&@H5dWb-g_[8_(L
gP+eBc@.H@51b;A)W==Z&RPIG&8d;VDa?ga=?f/0TAP2ad3JbOBaWL2K7-ce.+2+
A5]B?;>GOQc#74Rg.#ITQ;H:256T#+LaQC@<;A2;8Q.EX]V-(1X)D0OePdAOF_UK
.#VO56AcQ=3@\<@J44EDa(Bd#fPAV50LIEd>LD1E/XaV8L#,1S8B7bNLZN>#P4N9
fZ@I#\UObV147DH]OG<HUUBDXWN-85@CdL@@E(?Z^9fC-]>(JO6.S9#5OM/_?.DJ
F]C#2d5\=\W[?XQ_T\C)YfLQWYS9S)MFZ9>>9UVP7YVb,7]^X8e&ObD?:@EJ(]c9
a/7D3A3RA_.^NZ-6^7&)U-[8;dK@YBVMT,FX1M)SI6/b/?/VaC)M8G/fU7I808fY
B:U#&f;RFDHNdH.E-E0?a_LU7TPaDKZKBHZS=#bM67>[Y62B60c+4LT?4_AY+Nd3
2O4.2;0N[5bgSMK5,<M6<gJ)e=&W)V7Y[QdS-+_>20)eBPKZ^VfXMMf(8LJ+<bcE
VM@JH56>DWSKZ@a7Z=MdC1#TE#[V_g_PCG@K15-WW(3OH13W3e#e^<VP6S0;I6U:
-G;8b-X[7#=QH;G-A@C4)-FH;bSaPU]?WXg74QMJETZ\G>cS:HWA&1d?>VQDVa3P
A/76P6=d:d#CYN<f+&4RR[M/,E[-S:[@g#d65TC;[>;9VYIP)\)L+Qf2bBCD6=Oe
V;WQPd\TBUMN)#7_MgY?/W#-/\F/+=0Xbc_U3eZC^1bL7;bEB0[_0OS?/6)6d&Y4
@7M,Oe01\(K38IU/A_@NX::^G9JdCe2?:YW3#SVI#Jb/\.&JU7JG,eC=G)(gY=IK
#/VF-f+.BXNNCfNMQg@=EUWcS+)1B)EX[_R(]BA\E@EVdcbe?O[\H)OLZ?be&aG?
aYe>?bZJWK(eO4YH/Q81_<Y/>ZR0,,,XKY([?CHT@QCU5JDVf/[A]DIDCPc8\O/0
./9cW1g41Q/C=FQ=@@-eTY<QUG;U4[,fOI?LW@Z>9\8V&OC2bHK9e5;d,4E<[X+H
OX2c&/-Bc\>64E>65dZcS?US13-.#A2.DaO]H?;)G303/+4=23+Z/_.aSXQAcW[L
XLBD.H7,E4&]UaLfG7X,NL[M3:24N4N33]6#7XBPH19WX\<B)PYN2@>fgR4>If2L
T\=J]Pg7b6.Df:#PK5A+>_I-?bAJEQ11?eS[B]#&JaRWQ8Y342d\6<ZI7#^7FN4)
-^F^O/2[gW:=0KQK7Z4KH\&HaK78I3:YH0GA;&=[HN:>9cJD9XDM9fTQR+EEG149
+4Z,W?Of2<=KfY?-d3Q5FW?ZdG][cN,7eTb+bF7\A+9PF8bC/4PBM\DS\GWf<ML:
^T5^+E]9:4S;I:O=cb/+P0,de>^4B#S9R^+Qe5;].I]GG2Lf,<S9ZE)UCDV-J;NU
MFEQ8,Z0;9A:V/A,J&Vd44E==HECXEPeG69.1cZ4,R-?f/KEa]LR,^SB,-KHJe;(
YEQ96972dEY(^[G\RSZ-F-9.4cXaW4>-Oce#N&8cTLU5P7(N)VGC_cT@XN7F=H?d
T)8Jb9#FBIK\I@PEI2dQ>YU2eb/;KZ>O63H6,R];P&BO3f3c1Y)++79/IfN4bS5O
=fTGV/1AOBT5?Z4U9\3[.O3G3B1P]4<OY@>0S-OUNM,44J,=9<R^I&OJA3H)>]R&
+J,dN&RU9L&,]V](>^DO2W^CUdOaN:)L)d_0)QQO.DHg:IL\G]ObQ,IbgNH+\d-R
-(Q&f3@K4D0AW5_KEC1(H^<b,?C3cOB4;>M:Df8e23N_6O1C9MPR3UPS\K1S6fKR
BN&3K#dJ4Y3(4->-#\2=<(O@8ZD4JAPN1WgJ#6GX>U\P]U;5K4[A<PTOIJf]W@;b
@2>]J73-S.f^>H<a#(]eGc8WBIea(^ZZV(#,eBR];E#9d3CQCeI<ZaFM@?GXD)[+
b/&6b4U20YH4N,Z1d(Pf&+7a5@^,YZJM(IB_.B073DFa/@KdM>HM[<T,dQX^/K,[
<ERY),G5BXFU0,<#OLXcQCJ..#LdK++_(Y:;cNE<M&Q?Ld_CK(D)Q/O/7#b25T@T
8Y[fY_-&&?8f\4T\,;LcWE9)&-HP;9gHHHN-3a24RF=XU<CUfU9X87Rf)8KZP./;
=K7dP<>RADCEC;c#X.#>A/5WOR_WP.#U:BDWeUNK949D9Q,JTW3TK;gb>\;_O;L&
UVSgY^>L3Zb&9IH,Fd@AM&&=+:,_V:F>aZKC75-1V@dOAMga)1YM#b.c1/4^<S9:
b@4d,?QT_4CbG-L@9/>0-?eb=/[GH_W5;QdYM^GPJBYUA?6<b,f7bS_IO1]K-.\X
Y>)b>_,/K]>J)[GVU2b,aSOdLS]e@CDcIa2DcC_>PIgO#::S_3>=_@94[]]D(B=+
X6ZYI1>0CS_6CM@G.+B4,BP&A=0^@Y0b)KeJ)J9,-?1I&G=-P7<a+B8CefbZ1ZJ)
O/56MN^I)D/Y0:J6AYSeDc^;(DM@<1Y8EJ_Q;5LB1_BcBRY.IOeg.I8<Y-O,f3V9
^.OHAdKMGab^a^D:I)-]CULf4/>K0;WD[?@eZ-Kg=e2M;S\39>WPK:GC:WKa43Hb
+fR+>9d(5TEZA^NN0Q]S=+aEC?0QLLb2S9IN8-SJKD=LHaCU#KD7eM83_FR@YXHP
H>7,,KI.AM+?J-\G0A8C9NOe96a,DES?RJ9M=0f8Q;N53Ec#(9b9MZ4I&SVL2H#S
\2CSQ):1OW+eH:cfgXY65ZdabZH&3]SfIVIIH(SaMg+/TCCN#4bT[E-/FZ2,OWC3
bPc9M]<2\d&0/#Q1f(aP8//>]6B5:.@[89cb.2QVQFTdTN@bD[3Z2L?fZe[1VXK&
a_c5C_<Og(\cS28G]#06T0=;^QLfGEAKf=4MffI+CbP2Vc,.MT8B1VJ:dU4PC>(L
2.Q4S6Gf\[U]RDB:W6:01&gT^,Ef5HAUO,N(/0>EMO4Be&I2=EG=AU+E+,c;R3fG
Y;.f6W&YL/dEGF_.7f1/2\ZBY^/\J[g0F4C-X)41D&V0(P8\^Z_bKX-+4])+eeAU
1FY)6W;^&6ddeE8[(bFG4,4@P,<?:_b3)fX0H)Kd0,PD[>B##,2C6ca:P8,,9b/N
KXE;Ef7X=V=@R1M/O^P744A.1f5T55K-Sg2NIeZJ6F=OE^=PR4bYX6fB;bRa2D^3
##)VC6Y/+-c^QNC^(,G48LH^,WS9Jf[6;#NI(g^PK>/3\HKeE)[/CA^W]1A]1_V6
9&>]J&./<(9a34d<fbEa;+JMHJ0?g;d;U.O3a+=[GU+G]RafFg61fC/O/NO_&#P0
3@)AIaR/3edg=_b>WYBcTM.A>E9M=;,>^I?FaE^KU:&^A4OFMOXSRYI2\J;3@4UR
[8Mg]X)-Qg;/:CG;>4;RaNPS<#YPO-+\?1@8&SDbg9<_..8)a2c#AAa-+V\a0]=.
4eLTY3F.AD,dBAdR##,Nb>JIGfM2FLD)?EFR97@/+\E6[UUHG35)JZ/K>KgS6adF
_ATH^U7OX7\d,[f=.1;&C3>^Q[\D&.?6b<?R&D>HE,SQ,VJa],R_.W@&,Rg;VbI6
6gFJMUYBLIIeZXDELeWdNaYA(DZa)9S+^<1g0ZXf&[4VfbDZS->0EM_(d-ANCQ]b
X/L[dfXV_3D#[MZ#c)RQS]H4E41T1O[^g]3b1TT)bV83-43702>,#MSAe[e_7&-e
L-Y^FM/BX_&6E#G(0G,LU;T0JY;7?(?+eAZ:eY3UDI;7]X)O\9?Y5+PWK?\dYZTQ
D-I]D^8+-L]@H_\dUJec2^[=M.5[\5e=Dc,^KK?]ba-B\V8#L_5R@#&O>Wg.P^5T
Y(7CZ1aBZHNg>SMUJJ82DN/XE1#EWTg#g;;CY/@g87-IJa&5,Eg6K+FA6eV0^gM@
9K5/@ME9W])1J3O;FSR;f-ZMR8,O+C@+aY?a=AfMcET_I>D]cU\S?XgX=.?M\[EC
6PZB+8[?bc7D4:C(<^Z&WL61@#b/BUWcV?5>XUBYXTV+6ZEX,a@;+:+HRfG#P-]b
RdD0ZePee(9G6_Z:GA/SaVf\aPMU;5K?^T_75d@EFAIA#H@dBaL?XBYVE)O3<5g\
.d@d2-#@1#e]bC^6>=OV[^Y5fJ18C=\;19D#H+A@E7V2Ke[9_gc2#FMBaSJ@eC7g
4,O\7RVH\dbN7:,Tb_++PE:eU8/==Y=7W])dA-ZZ;A]NQQNgUaQ&0J)LRbW23D7?
IEITW1@B^F(b.F,.?;MJ3.<<UVZReeQ?QS[>-L.@+#D_L3R6NH+L3^F7EW_b#=);
1/2+3V3XWHNVe/?^&/0H:UC^d)(RcaD:D=4+V.RAK;eIK<X9Q6FBZ5>:_6I=&bA_
83NfQ,2G.@YRZIY3EMEHAZA2:M+LDgD^1DK<C[77_?=:T_W(T<X30&>TPXNP2:/[
1_aG/?RF-_:\&Sa69GZX4^V;0<WOT8JFD_dCY7g;FPF-dQ/=.d+2ZdcTX;G[=?BJ
b0fa@#)=HJPT7QbVQC?+VcS16,O-O#V=7(=50[Q4>I@RLa,GDUV5L^2G=#73.Z34
8?4DF9S(B6.c,)=^[=9^][I&](0CQCgNR7V(MQ6PbgOf1PZLVN2[[[U=OU+B_^F/
KG7M@DSA)S7YE]0/@-34?AEQc]f7a;AFI?TO).UD]HY&_4NfBD[Va:46UJ&f@b#)
a?@(&d=)fMH><a,08T.:7#EV0If?PSBM@_8@/VNKVLdEY]\J_c&^EE@QC<L3N]P]
JZb)JF&b_)XUPO1<&F,RRUW+ffM>AR5;B5J.P=b/VWEP00NX0<b7(f/RVgU&UW\X
A+I_9LPO2&8Z0.0LZ#6D+g].H+b,ZTZfZ\O#1^[U)a^7E55F8Vf\LY(d^SDKQ(Z/
OKKRa0-K1HW8:K(&<I_R#:e+06TLZJ^4dQd,6O[:9+QW&OfD@J:NfA6Y-QIZ[]5H
<751S[VTf3QV>L=H^WXWJeU1&E0G56ceT>/U6XM-A<U43B4Y\J,<<0,Q06_+f&FW
eM7E+JB;)+QHBYRb_;]8T2#1R_1U=<ac]Y+,+Y31[c>fKacI2YV>dMHX\_X30))W
,9c)AcVFbdEgP-^:\f\[E=7CZ:KSK&I27KcNP@TYK?>NH80P-EOV7P.TCK\+;O\g
gB#WZgQ2X^3(U/bQ#G=-PeF1_a&b[Z/-5ZbJgZb>-2E^6FX)C;5V1Z\GN<)VOZ/Y
/6/A_0b(6a)eGMMW)LOO=Q?Fd0Y]bU](C6XUY\YU>5fQ+_(0gN2_<KF=EPd[CURY
K(<Sc?1W/1LTgHNYW+O\-0[GQRX-?R7S]DZZa[5WGQ=B(M-RAC4T<5#KNfTXTB;E
8)[MU5,JCKf?G9-F[JZ-.Da8T)0/4dMN;HI(JFVb4+>T(8I;[_RV(#VBAR0&d>:D
NUSG4^9HZM1OW9::2A>Ka+e,KC/>8G_Zc>C?LVIf_&ZM#P9@3=+Q@&#U(ePLCUXg
ZF/<+38<V)dQ;BU;04/.=;?B+^8#B/S<cP^X-8Y/bHJMTeXNC]Rf>1E);M^R:(O-
EXP^:C+6VeIZVB/FI8P/Lc=_RO8.[:QgHAEd5^PfOD@<?5JC7B)9>D-@g(XE4<3e
K#FKg@E0HO>B&2N]<B8INFe>ON]d8V;9@?AH9ZaSOQE<\;FM?Xf6DOb-c#R=3f;,
9Z[QR@I&4TR1fK/ZQb(55eTRHXX78TS(H[]2,XDC.U_>X<]((a3:,Y/a;]]X#J5]
JXBLR\&/V9ff?F>LVd]A]H58^,F#__8OSBTa;U4X=,IE+d4Pa-[c(9KSUE8\J^Bb
4E1=KVU)-c__7-6-6=^-#IaV7G\J2CV#.PPUbJ18U7I4gX;[2QIB?WW_<eE\:Z:.
U,#F5Y,-9)\RMa+=/bd#aR7K=e-KBLgTaM(]4W5C6,O\^6b7B,B@X(9UEQd3L3P:
D^07E<3WI/B)cZ]<J.7@#82_V5)DE6aIIY[X@@]eHB/EAFJe\(-,FB-0CE3AJI9+
Dad4HT9]^ZNAe^WL#+8&^J6,Z,AQ/)bMdW9FN&Ag=U2&-+#N;NDe:,CW,a&aRPOT
G3IR-g@.5HOEZX--OJ++SbP;QP9ab[\G:FXC[?V;HLY=?<0W=7SGS\,2-e>F\B2B
.O9-O7Mf11#8eaIRKO15_RN=eM(Q<Re10PRQNBE44O4WbJ.OE8#>7e#NDMQQ51J8
gG8YZ+e#6PF8NODC5<LGd9[64.c.g3c+RY9?U0V)2R7&Na5cL2:)RSXR]dN6JCMH
H2J\^:JDG^Ld;g[cd#JXQ8Mc8:E=4&]]:1:V&E0)JaLO9&A96U?Tc;0dIF_+[61E
#e^=8L)BA10+]18M,eMSGC?/f_1@R2c4,-d(d:-]AgZK(0UD@\(8S?RN+cAZ<E7X
\2[b0^XC1M]9\dR1T#5aNaG-@RRdGX@IMYC2OO+&HMS8>dAKIN2-E[EWILYUR=YK
#3^+[aAWEUT\0Ed5G_F.D1196)c_2EFB<.@ZP_#Y)XWb+/Q+E\^8Q<UQI777<\OP
Y5#QQGAHQ&,<=YU5<X,a&__WXOgQJR6H8,7#Q,?-VEU/G7,+,N.=.f3W.E\OM\EP
4)<Mab3fbGAfUWaB]SI-E^8BL_&@b0?GSFN/N08A-_T=UF=)V8S<M^N;c;LWTXSS
(f-\a]CC:?\3DXP_@)HREO:WUDNH=D+eHM&E?aLYMDWZ+#dVP(La>FRP,X);,W,P
,37.DUY+<>;?92?HOA0]#aeR8X15^++\^P8c@9b]<?9CRB<U1SRR<UD]S@W@VPQJ
DUT<@6RgDZMWIO_?Y2>g&L;eF.F/?15.UXKVbcG_N5H-P<&g0-6dKaT0d<-ef;)2
QCMIR0YGFF)Q:@^US5Y[#Wf\g=B>g24;QA9T=9.Y&)(HU+PX?3L&HMG4S[E;I60)
Vf.1J?N<9.b3cf&e(H6Ye.GB&U2F2NPfQCa2O_.>P?EfPb:SQOf]?Y[[SZc8@Xe;
1P_&7JBGc=>A1P&\6STRE_5NO_bAIOC-D#g:]:9]EM&g:&TK3c-X30(@&@b0_XGV
b4[=9]-=:BXT/,P^eJJ-:2@FNR_?07PPMZ]_[(.5-KdHb@PS7/_V_A3@-BI\#Rd#
B\V=H=/332Q[UYCQeS&^Ce[X[a>C^_L5I?2#JE+;NX(PQ9[AQHGVe,=3X:MPKC[(
4dF:\\2J;K1fc;HVVAH922X7eZ+T7Z[_,^c#J6[bDg6,\GC]QY#\_U3D:V_A?5dN
_8,I.(UX^7H4.1N;;U,?>GBUK/3K)AZN;(,MKSc_Lg081O28(,Q(F-2CFKV@Rbg(
8-20B=acTG_ZF6]ZZB)MZV+dcUC=^:WEN#eC2N[PMR:<L#XNE.I1ge/1c)J8?ZHf
HO:d,>T/eG-AE87cJL_:E;5G1g?bF^V.-Rg=YU\-6(0H2&>7)S4b]2V9[0f.XU2V
E0/JU5^T=O_W)Uf7G-TaRLL;+A5\V<]P7FXQQa.H#O5Iag@df9Ea5Fc>gaUdR5U,
Y5F84bcG:KTg?6/[/R=5WDe)d9^@6KSLgQNQ6HLg0-P8_MIg<-YS..a:a1TIHODd
be:K3[0:01]8_FH=0I&gP6a4&TO<])H=@[P8B[>SR-W4_=(UD/G=&aX</>-0M+UM
Q[::agV[O,H)NJfBFf2=J\b?Kg:cG&2^<K#QD3ZcWABIX=W2_#Q2+;gQ?4c^ZO+L
X3ERM)Y+W#]c:ZWGXC7(0BS1136X??FRd6_0&<UX1KeB&RKN>EVZX(^E,\>#NcXS
PD+,2.9eJ-XTG):SaI3<<_K;_4]L5BJ])\+36<BNRbJ@.Aa7>O;_PU3[F]3NDfEV
+PH?D2fOD;DYc@^?D+&@-+5e1/+Gg:eUHW_.,RAQf-D7aY[Sc5\7GU2ab5.AVV4R
E-8A+@6.:;IB<CC8L:fS375-,N#FMcG5LV4,OU4-9f)M_@S9S?OHR.d270<c2B,O
8>24@=0S2)Rae[KJe8AJE3FCK>K#K=+5Q(][,BMA4gT(T.g&@8AYB2DD,MBd_c;M
25JD(3UHL-IKR7U_aI(a.Z3,E-IB<,I,@8WeA#]aLTfH__J^L;PVPVV&BN-6e<9&
,X6>a^bD=b>8a[CE^9AD.FV8PJQP[>BD^WAa7K1eP9@;@MV?P1V9+R=4J&6YUYg#
=;[1;@8bFJ:.S/VX;@eQ2R#:.0ID,1>\HW/X0B@Q(:f=C=LQQ@gQ-#Cf>WZ3T[8#
?[.9<XEeY[8UJ=L,)XBIGRV2c5=-GF_U;aA(5aS7QP39^M50(EQ3eVG70Z#HGS9R
8XIODR1AHC:fYDE39E,0?[PTXF#_=.^V<W2KK>aOQ;;+RWaR<Q=M<:J@3F+AOZE3
C:c-]Of]LJb-L)VAV;:5P&g)9GE2[_^#+PJ0J3eeG&\&e_P.a>60=U.A^8)[f?]/
;73XgQAgU[PDf58IRX-)QC3U\40[^7&(Q06=g&<,:,7)U0]&+,]@HOBR?g><K#V?
)fP6Y]&eEL4SNI#+]e<[X.dL\b5NZe>>-768Gf0dZ.HXg?Da8[c-<20CfJFFeZg>
YZ,W?>0UfX]9KFdN)24c]8&K^e(a5_V-bIQTMOaV=:/CDKT3<T)]#abYY>bcEK]F
J;9.QL(ZdV3\f.RG2<aS)I9G^KRQc;=UFO]2X]T58\dD\&=ObEK/QXG5b(8:C>.2
S8E)X100<G=LN3=^;<@@-KFSV>>U_]IQ_JS:eAIeDe:L23dFIGVF7XM,R6IE+XPB
TP+TGA94M>c<\[#@M99(ebHHY@LBa3KL7A@IfI#T6Sfd4;=d&&<:THSR^+;Vd4P8
a4C<VdD+)&[1P+_Ja1B(NWOa9A4TR5)d<Ff=A-@E(BIcf@,9]#N@b7ZN27]EB7Z1
Vc&RCb,Q<dQZP4.7V-60?W8Q^WWb.?_D[FAY[))fE82HZg>_V#ANg+&J9Oc7TR(?
,Z+\BT5XF=7OY/Q]d27DUWM66G2M#(O;;;RQ^>F\V7G7PV2(cW[^N^&d&Jg&#YB-
::)?OO@P[Dga)g-5[c]_1e?XgSPP.#BWTF1#\B3YReA+A=Qc.a#68bL_8]M.<:?7
BYHKG6K(PPYMZc]cW>78?.eV[UY^^FZF.c04>,K?4IY.;,/;5MfCQ&X]b+Q^YF@+
R=ZN_X3-\fD@d.e0Sd(9[IZ83g:)Y;]\4M=V4^P8\>O[2ORH<7],V6=_Q=0Gc-D9
EHJZ)?8C97Q0A,g]S)MC2M.JKBG=8@R.::[e)MB:(B[FEa,RQ46fJf\B6&EadI/N
LYS@N9K/a#>K<J/;LL4eXC+)#EC?2B2:9#]P?&V<MIC_B@>R]QM@PN8>Q&,_4[8^
-3(Y/bbWDgQ?[PT#^,f_50[@<D&c,LV(-3EAY9C=6.-Lg]La\d&(#N(4K9[&a7fM
OO&\AcaIQ_J>@a^XZ,C-@::(Q0NBL5S0(7Ke+ed&=2BQY?bEYTgJWDK?(E.Q<9.)
aIKD3?&PWF5,G&70@Y9Rf.U/XTRgU<,+Vga833QdM5V5EAg/4E63bBcFX9(<)/92
;>_DCY;L=6De5FX65K9^0<abd_&<(MMKQ^NCW30<+Wd\&Kc2F,\:MG3a]e^B+fFH
D];6DVCKf5[J[9^C#dM]A\+@@N3+M120GT)3IJ+9UM#EfQ(TQf3.Pg:2P]@JA#/B
UMDe=1;@Lb7+GS0=B0d7_=[-B=>XZIC3>AK(YYL)EZf/ZGVSJB16[/<L#1H8U?^^
\R:F7?O&UBX8#J9G</>5eD86/PMNX#N:bDcJ1Vg-\A#YI,],Tf7@_#XHggJC_BBa
/&>I;<e8?aBOcbYGUCF9:bK9_L9UYZ+X9CFbJWR([Q-IMFdRWLN[9g+2aPJRM(e2
F=e[\(<F(7YfGC?TW\cbCSEf_/9.J-5eIK,Z^[V9VQ:H@C/KfY#e#bUF2U1DXEIY
P,1+CRJHa<g<g>R3HC\IYId9ITE,N/+KY\K^F3EJ;9?/e.>,9WRe&cGOOJ.FG<+I
W7/442)K@M>#P2)&;_c+/.G,Sa16Ce/-[QDQ2C+@3QU9Q7&:E1VbdKFI0@U1UO8]
7SEZJRIc(]eDJ(Z48WXB)-Z]c&fVBcf3O6UTJCc,c74CDD[AJ4@?YULEK^-XV\cA
X#-cLTDFWd1FbIcZ.LEgKc&P##=9A=I><]CBI35E(JG4,]<U0M#:=W)9HQD:+ESG
RAaS[GFP7P0)3O.A9^HTKc/D01c+S]AU)DbeQ:fJ\J+/^4JK)Qb]A08[V5E:Bc=/
W7eAe^P#D.83Q#:S;[_OR[b7<KQ/2-&-:+P8X>]=OQX?eIQ,.-T9@^.O_WPFaRS)
)[dG^2[#b3^<9Ma2,0P70LP@KZA]GJZK-dWbRE(@^UJg<c,7D]f64K=A(6NYGP\Z
66TB^c?(QfCR3DGEL?_gSd\9,3UFa@-858IcET(Z[5-.V=T@0?[3DEbAC;a^,]<^
-)\]LJ#N+N[ZJPKM.SYVJa.dd)aX7R^]TU#.d<P<U+KDW;B\^3ZI_;95&E-XCF>f
(b87>6H4:,2O6>Z,OWF\[_6318AD.WWeR#^WBGQC_f7Gc@LHGLK2Z?5Y2238c?]1
6@)Q(4.G-?7?B\b>&D[T+bF+Ud?K+QS=MGQ65_\,]UJ/T^eP=(<4G8JA/9^,AS.4
JEOQZfL<&3P\OM8V0#A;JC8bC#SZ]86L3F(1N3>1FY6^]?>Y@G++W^5c-.,/;cfE
LFc>N/;fHg706&@Ic4a_F/8D&#HZ?]40##01f=@Dg3;c]a71YJ[Q7eEJCMQ@aZ)Y
D85/6SHNK?T2HFYPbHOT3.QTLAOJ;f+0c;H/&Y\^(?(\FP[XHd6>N+8g2C[):9&-
@23<5g&80.2#<<9_QC1TO^QVWDSQ=9Z#U9_gdGROH^RTNF:]JaV>M\;Ic96BaS>e
12B76J<Gc>S5M)MUe>KO&C_J4<Uf?NG@I3TfB;5Y;GY0KWYDK&37>XUT@^PLJb1(
/BM&:IPX>1/=@XS[?e)aTMZQ#9/(TbYgP+].3^eULK<TCF)QJ[a<g]#:&+95GS@_
3&>VOW90fPKa-IS7E>J.#K,.^e#075(I^IfI-#Y/&F@ae</G1[EVNL^]d<7BR9P[
--LR+[#)K64E4C0d+7)4S.73Ag1,.fX];E_7PfJDRP<V57..QK)-c-e+FHG&fREg
b=5Cd_&U?WcBKZ1dcI2IAN:G[95PQ,D?C_(W?6[RQ(./MRY:;OY<Q_\UAgLHI[A3
d#8XK+1fIeJ[M)C(GFM,[YATN0<\5?f4e=c(DO>U];CYbV^YBLbeI6cSH3b7D3NY
:W5R;0Bb8.?cAL&QW,#7P].Nf=?\[cG(6Q],5d2.RF?)1UNW)XYW74<6B,Z:L<QY
[.-,acI?7[@?Qg\07+\:RSBP_+=K1g#W3OW/c7J4Y)Hc6If0^^fVJN8Bg<@+9+HN
c@7?^#=\CIcUF,(0MORXO?ZGfV:HNWWK30JY(YF?5F5DaC0@ae,H8#ETg49UD6.F
eBbd/cd;WI&2<+<[(P=[T82H8X(0=d&X@@OW&ef00.DWX:FK#/\D<I2O.)&GD#+D
He,WQ46dKN+e1cd#9^=.G3bY9BE:-^JTL-;5\c]E@QAP,.?4(AYRSZJF:AKC7A4I
YD:+@UH\g4]JE=)J1D\,feB:^8a;/?XNK=M/,#/0d&5UX=;I5S9+U._LR-1(SLc]
#DC>1J.ECeD;5a6;bRV7bNWZ@\XE&_G,T)b&QX#3.]SYQd</_?eaaYdcLAMM5_A0
Wc-\Ma=8:^L?_Q7e]7^3G\@;W6)>Wf[7\<Mc@K>1V.W^M=D-6=PT;^XACY-/T-@+
Rd@@cM8-:7aCT.V[-@CW>6<TDJ(>IK.4I@.4@V:G@5\)/J59&,OA#7/B;+Y+7^0)
e?28YY/a;H\b1F#M(F(ZP>-=RLS.c\3,f,<T_NX0-Z>g>0K.==1G6.DKcM0f978C
Q4CM,VLX;9>-@A\cP.A&6=&5/<MP[b=6/Pb<+d/.TK8:)Pg^H/XUDA&LP::Z<5g]
AQ;4?+C,._UB)XbMTZcY5M@W[J=\-K+#c\GBVD@7NRE+?+_eZff^?9Y?/8-ZX94[
)IZZ/GFTW8=eDFGHFN,^^6c;+W=Q,\5\ED>B9K(IbB-+)a5;)N8^73:4\dDSX^0)
E4>?,D)FJ.7KV<AR_]1;^5Z(P52M8e13-KYRg8&VV]H+UT]W<QeHf1O07YM<A1E-
F)=Q7ST>1.^FZG.6=07bRH(_B5Ge)0dMGQ>KJ[^XgTZQ<R@W4G&2>WT^K,C8DECc
9CNT7B)(T(X#Bb.S&@:LSFGT4Y9W0X_YUg\3-9D3)KE[RT:PVZ2NA6?Q2+(d<9NV
LEMEbSNL(Q3e4]FRA]4)6#bFRb]].&Z@3?(17UW7X4Ba/A>FH\D.)>a75+3(5.V>
7=DR]7U+>JTNdEQ/,AJOQZD@d7IPC7?eAUG0NIe,5-:c:/1B.SX]N[f>WV?X2.^1
HaNUO^^DJ)_\<@Cc\9.KaWGa,Nf1P<]2;2WL5#dC+e]ObO>4;5LEL1ecTM[C&3(X
9S#-,J6\@8dO9IB:\O>(78ZeM(b]d#ERd<3VVcJ_NA<)5@XF=:_53AXLQ:C9Le9B
S;3WT]+8UF5-RL/?G;:T^a5)]9PS5,\,dWeTI^M\&)XaAW<G.\Y0)@>Tf&G8WfK<
_dY;BgaNZAH06))Xcdb;)+DRZ([e;Xf)fS[?>:C_g9ZQD>Lfe-9:HETc6b4-g7g(
Q\IbeGeES,47DW0[cFbHN.=(U;\/S8TeQ=dDa6XOS&RFN_G+<SF^QV@=;E#8LKY<
\VB?#L)=D(PLDN#DH<5dG(OF:dST^FJSYR=49YV/ETT4D6-\6L4.L[-N,[L<+WU;
77&-0#F^;?1>+86OT>?=+Zd>@6W_4d@DO?f,NGSH_:MY\=GR9)Y+,;4@c^ULZDWV
1+YK?H8>YIB)J-Ng1P9Y.IOa8URZa/^B-KTdFF?g[eYE59aOgaNOa^S):_NZ-#Z,
Rd6M.OV?aN.TD7e>5):HdgK^=55#;Z#1U_MZa\>ZB[<#;K3O#]fQYfN5-)dKKS//
4E^Re?#@XYTH[R?]&O5HPG]&HL&992Db9+:6)NVfP#B&:\cJLe0(J7b6;2CR;PJX
5VHSYf_+aO9FI(P>\&HWULDRL5XFN\.bPI/[:=9G/B9MVOAb0<&9cYdFbZGaNYTF
KH1]ZAQc#E7=D:L<0S<Gc+NC&A[6H&,2)5?CXUQ5A587a7^PZb47N;1;0\U5fLJX
?NfA.8I;-2TM@-6bQYAb=cd;9LT]U0@[ge7?gN0#FReA6Zf15TZ\4TVegVd+B20U
:VgIMfFI7[=FBf7:\1VDPPS0ce:Aa^cC7c?fbU==H5@A/-J,IO<f\;OF_JRU0,@A
&LS_1&TO0[KO7O?\EX/955B6>^B,34X=-:VZZCM881E<TIPT;N+(6,V:D4E7.R]?
G4M=]d(+>G(DB/GW#Jef^;87-^+CWRX[KA\a7Ze+GGSFIC3e-,f^gNV(>^>gN@bS
]3ac\3KIN0D]]JZdT:-GfWW:(D4.60Ta,31EN1IfK.9FF$
`endprotected

`endif
