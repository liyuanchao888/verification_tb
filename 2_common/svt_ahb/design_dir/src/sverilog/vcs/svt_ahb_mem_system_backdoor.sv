
`ifndef GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_ahb_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_mem_system_backdoor)
  `svt_data_member_end(svt_ahb_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek and poke) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();

endclass: svt_ahb_mem_system_backdoor
/** @endcond */

`protected
+FYSNad-g2M9(?/CAdV([<a5bMZUf5_&4QOKRNEYe5ZP6E<Z[-d6+)H9)+Cgd)W_
(1#?QQQ[?3^eSeQ.^<=-G72L1Y1Z(/>9bXIORLY9M.0Lg.RYE^/W/.PGU(=SA]AS
X?6]Y:4OO,F;+[05G6^XW^/#9<[[GVN2g<=LP493?DV(7_(1A41F;6&DCg74&-f(
;\/(56EEO[Q3c5YR@^K26O+QX)X#/e^fCU[K>EYH([Bf[cd>>]3V^FfL:+,[)?4[
:JeeQMg5]G=;J<#-Pa&@0J=I[F\#=/X<1X9K6NLWFIac3(N1-IAK32D1c/#2:>D^
B3VULRc]T>HG[6UQP@(>^&>/V/Vb;95Q9(\(9[@FS:TS3/NQ<Zg,)L52WML2e@7N
+#dcC?.;Z1;[T5QQd_CVbUR8IGN:adQ+P0?==X+37D@G<@Vd^LB(SJ#X8Z[DB#(-
&GEA+=/BP^G/T?2#J-U2&\-I_P?JK;4F,4UPE/A&^ZXNO8SN),=4.7)8\MTbUJF@
>&14Z#Y#g9KWb<WP0NUECN&eLV]F3DP:9N?,T<V8/KMKdZK_L_(;1G>]PCNV&@W:
_/I2,2OL;H()6ZOX:H4>TD\+X^/5VR+V_-QL&>VAN\.f&MX->,G1Y5XOY=3E3?0Z
Y@-NF:?U1=B.\gVb_#^LR1P;#MGQ-8>JV9+OK8GFT?:RDJS9IF::N&YfJ)^,_9B;
F(QIZ/#52L=:;QC=6X>)#ZXcLYdAOQ0WHS1-\9ZeZ7T^5,\0H2=+6Ka<5+K5b+bE
NL6e[O9,Y:^[)&\86S5-KOC.DZ(&:-dZFL15C,CI]DPK>WZ.IaTePcB@FJ62++VA
T3)Jf6gI/@VA7]V9N1<IaaRT<,@+G(7>[Xf+HeS/,61GD7JM5P_2Q4f&:64GF])d
($
`endprotected


//------------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
g0&ZbHgaYLc0gFXLR7eYfd,e/[C.]e&Me6+gC6-VT,)D(-C#aI[1,(PF=b_B,S[F
Wg7R3K)GGGOf/VD/]:<&)D4_&O9D)bT]OX,f1Nf-7IHGNBB;.8:YNc<[2WdFTAJ3
LQP0cDORaKBT-3]KCJ-:]bCOc<IT1dVg(>N0#Qe3Ma-S)ZNI\NZ<aHLN_L>c&034
+PgOb4H;4W9_b<9Hd0.696,?UIZ#7)De(IG7Z5A-ePMO1QU&?A\;G9(-F@ZB(aHe
eDY#cTOdUV]@NaCA1^PRV5IV]=7^;KgM1&b9g8^,QT?Ne8;\5^;@[GYAG0=WTD08
Bb_77Q09(@6bLWG2,=0S-57LE></0c[9-2&;TIICE)FT3GV6J3Mf7CgLK&](LUc^
12?(5GH^b<6E)e,5MK.#fJfIU>=dUX4P>eW<5d@16RYKRgM?e:7_4f.X#(_\87L@
b;]9W@0X[_Sf[6TGK+JBM-7^_e;>]DK4_]JP:WZP>]NGXZ]1K&A-JN;19fBW:Mc]
fPN<[P&?O0Xg@Y/Y<D+3GWJS+aa.EN_C=M75aSd<=HWVE=_ANOZL03cWU]\F\bN6
;d?:bUg8/KVUTU1U7.=YR1Xa^bX\8;?<PNBV).F29=99a8FF^\OA<UQF>7:3gW[)
2#QU^8)f/C2]MO/<b8NgZ+/..dEXag.YcPdB\Mga^BK-c<4?RYdV4IB#K^H]3B&)
1g(FJ^K.\QYeF7db:XQ?/EA^BWX9VWR,c/5Ed.#9RN>6g+V\@YMM7=VW0].3NMf.
ZfdVH#@]fXHS,gRR,#Z?4PJ0EaR^>RZ;2\8H.&K;XU04C#EPf3=6TegT(M5ZEV[T
UJ-aXbP+P]F#<eNEeUa)gXLSUZ>Sb#(+gU;cA^[BgJTFEKKI;dJ59ORbe6OaL0b5
2dC]BN4M4<Cf^F-B<d^+PfeEE4^a\+RNLUO<SP[O[]:a;AB,/gJBZf6^RDVJc/5>
A;<AOYY?8gQH?Eg^7ZZL8+DZMc)/fgJ]GEEF\7N1>HA=,&f1/5-E\,1gM3NA5_77
[\,XV@((,c=\dRga0,0+^?[f;&U4;0a9E6<WV>V;9;.gHE2VV.f,-^d.d7\T1d[^
;EE(7]X?f^PJe5MB][Zf5BF(VeGI.W>UbJ?EH>;;=Ja)^a<&#BUX]9_=.aVCZ^&9
TE/aDVLAVY/),^3]c0-D?ce=^D]0VMI.3A]JUb&F\FOV9S_JdEY^@O[T44^da5UH
8WgF/fO9aFNbK@ILM@gHe&@@RbKAHK?1/Q;._PLYg5a2=4Hf=N+/BR=XV4a7]7b9
]OB/).9<,WRTdUOX,PV45B>7H948>:\b(?TL](E8UdI+RC/)XT>10a>F(1I/^\NV
eP3VU/,YM<B+_8<W;7-NDRd0/d.DGBC/_K,beDR?]+a;R6bbeeWQLd#dQRM&DD>L
J-K.ee1d,ZCU.]PF;@B<@VaeP2US0FC[Gg(FC0.W,T=f>4Z=0C9fc,AS,A1[]Y51
@?GeP;[/cT@H:<IHB<0Wa<AZ;Cf-+bKAW[#7[[:gR6K]g@K]FPPSA9f3J9+FW=Y3
X;QW19Z2\^V@A:1;bL7YP]1S^3dL?NP]aID\BK7:]^PD@(6.+?>:EP[A&G0>>I)Q
cWf?cA>gP0.KB8G?8c>PYE#LC[cGE:SY?VO1_HEU;b)Oa,Sg+3M_0Z+DP.H;bO?K
6LBQXV;eVQQNfE21A>M961#U,52]Yd:=BY#W<PO8A9C,gUSHA885b7)3.HNe^_VB
_dEH<6bgIH:TBJOJ-f,Z1(c2Ece1GO1/IL8\7_c;QQbSCF7BS&JW7+KOM-:N&ZD1
5SWTPP8.g#5dERJ^-15AKVJYCaK\cc^a&.CL6;DT64=T@?]X+0AE?M</_R6GRUWO
U7STRV\9IUY-OMG7a>?N\H&bHeeKf57b#I[H<;BP2>#I4SL>8B^@Mf\+8,V=MANS
]\M^<G&YF8cY^GD&_3?P>V1<L)Pe&DF[_4&2[AJc9F-)&9>cH\3XOfbMf\@D9\6P
^Tb5LK.\ZgPeD8B9cJ/>;S4II3=&WHVLV4d\(BJCBPK<VDT;>.(@[FZ\8<ccAI:S
V<VIcDaBd5=U+<5DZ?I,B<gb(fF5[,fS7bD,A^ST-eSV(PbC.)BKa@:Z+gWQ+R0=
ONc;ZD+<1W/cGL.A302L^1CG0>)UY5X3IP2@/.:RW>71=UZ.-8U-=HH(_H:20J,_
G_0.=?TZ&<K;GF:Xb8N=Dg>2JgH\DZ4B8B=cWX4^R_[gTb4R5gN0//1]?.J/KEX4
Yae.75)J(Z-J)2T=X#2TFV7Ha?LgAS/(#1OH_a(N_:V,+e@0Xg&0)18GFCQG.MZ2
CZW0.,X#;0&e=(N>),K>XWLY-[1X=(BG(+WLU=&9#IJVW7#DL;>@[30</@H]IYF5
WgU8V.ZRHT)1.9c.NKXQbG@^NZ#8f/@\Y)_.Z7^6W6EQc[QGL:ccc5.VYfe:I_:2
a=#Y@TJH?\TV/9K-&?TLP=W_#+B45PVGHTRG<\^L2f,_.GY1<LMfTQ0XJg?;aaUY
FENC:XF+HPYOEV=FdS;I=+AX+?&34JHR-MbfROYYX,:L;#^dZF3=Gf;N,\_Zb3[g
GGAG>UWE<IB1LM/A[gL9a;8fK#\H4^YFPV@:CS]1aZ04:T@B8;?)H\;;8H^<JB?W
=X<]FM3C:KRR<S;+(N=GaaVH@GX=:>d]<[/a4HH]gNT<NWK^-I4cT-@E(4I-[cQ.
5aL->YF7I-Z[HS>:[F[-:.?,QLP85ACg/Z-_.JE)/-VE?-e4@MW4c_QO(LZ@EDeX
X8@C1W7KP2=1YRc66F;e]+1BOF&+E,AbBRMRWfOTZC1GVG(M&0_[)N(8<.1R3_00
KGf[&.-W;IB,BcW<>2VMUTMH6G@(_]OU]FRX;TEL+\\^;IQIg4e#X--R?:SaJ+:V
g4aSaN+ZeTB=QZN&fM)0e/ACLgPOU7>R_XI:UFFAWB?-?>5,E>-_LPE[)f5Q)@Vf
)8,TYdT.Hb_<g13/GAR9UD8_>(6/N3=);ZW9E80WQ2Fc<VE6Z?dS3[Y4WEU1d@@I
7Y(]:#@BFGDO)W.d^^J+[]6c_V#58)Z?/@K084a<M343c>Rb4PfObN9KG_?U]Y7d
</Ze+G+OPH?SCPdTQf2G9?,35D1&6&,PA&_Fg?c#0</VDA0EN.c>Rf,RG?0bed(]
_?E_eA-?a^#D:B3;@,)1ZLRZAR0ITdGS#_6EAaZ&d&WOcE_2B<CBBWVO-9Z/a.5D
I8JUf\9V2F2/3-TbL<ICM(bc_YeH;(c-41T@\9#OOQ[M4bXP9;#?C)WA1@V+JLbg
9Hd<W88Qec5Ag@NeMc5K8(HS4A8>T:aIRSHfc)eZ+VC11&@\Q)3,0TMJgSKRI:3e
XTcHA@)W(<LbIK:VfF66c&AA-fF&?EL>Je1B@+&MBM6SW4OBDGA(N@8BH;[LVaJL
9HM7&bBITPHJWQ0QJ/3<<&2EaQa_;cD9KBUK,;]f-5LTBD-2BZI#ND8F1N6STMDW
XAN=/_(C[VIY[Nc>HF71b9ZYa;HVdM)?&S9(IdS__GIH9c7O)eX.g;c2\R/AVaEU
8aH.[S2759^VC7a>B08&A/7&&NWHEUJ,_T<Y#-7d_dcdOJDM,QMF@C5OG/KFVC:9
UaS(ee9BOaC)c2M-a_bDXAI]9QbN.]1FWY[Jc7gH.TUVKfP0WP?^7,)E:?P\g/[X
BcDY17^/aGA)A4eA+WX9-Z\FE#GeU)Uc=b3G;[P5HA+)W5;1H;1XXB9ITYQG2F@/
P_3+]a2/MTHY,#_)A42GI/SL4@J#_N3KRMfYeLAXfaB74,8Df#(&2]TAK[F2&@T>
#-=Y<I7(1(&O]X1cC]6\UWJ1G]XG>1YX[4D?_S#<MVPaP2:9B[=(cB(5FL&UgLY4
+=aH9L]MDJ91I.Q.N/Sd+TF(#-G/#^_7SAfSFWL=_75f#?-6CX<9D4M</EcD;OD=
?(gSH8Af_U+2D3BF/0\aFO^ea&T<RU5\R\O]]gIEX-:/AF+@1aW8&>.C+XK<KU,-
:LG8L/Bg_SS/G7\S7a4BZE]4dPV<_)ZA]OXBCT&<Z=b:S58?feAT6QN1ce&,]XS)
@JC8g;A=#K(L:SE(XFFWL4<]L>E8:N:,PUSdZ&M0D3L<c8(P@ATc^QYVC=;I1[6S
A0B[)CZLDBW+>)52N.fJ+N-bX1EUa=e9-DOdL?fWKP>eKbF;O,_\+e032H=NNffU
JbG3NPe^#N6-F,A2bY:E^&IOTf(<@D1P?K8IJDJN-XYRQgJ8:0HJ07U>O@0BbR+[
_5[\Hg3.DSQc(9.0,)SJ[<1YZC2];7(0RTVG-0JCBGIZ7&eX;^?67GP0&1Eg(8AB
&e/0(-IM[:a4S\7-#7=W\2)46_;PD)>NM7:=?9LEcU60PH.T[eKYL#=QQ<A09]1b
JNBeW5EF@[?9(?XM=FVR660e>(,(:cS35g7E._5?P;+d;74CE8RGI=bUU+D^g#2:
=5;A7U>Q90LDI&Qaa[<HIeK,4#4Z[)8a9_T)?3ES#\<Y+#O@8gJ^#,?9.aH8Y7UF
:Z+FZB>J&YZHS2Y5ZLUc(QdaH4bg(8H-O:&5\]2^E&+M5,.Z,H7K0BHVM<Ug9f,N
H:T7]>[50L+PDH_FBDO6>+G[\-\)^-4^[,-eJa#X#W1I\PgNB+M&g4L=&f[KX_;Y
8-;DB96OB]DW?-2@Sg]&C9@1+7e<gEN&I#8;\gR,J);MIK8;M_Ag>Xb0\[<=#\41
bCf.)6C=]@.HLM3g6JHH6]C_)KNU)M2O_(?(,Fb;FHS#NOFXA4[]4d]CSeEVJ>9M
KP>Y+NNXH>c)@bc,?K8J=S?=]ZV6<5UY<AGPT6NV-A9geb_/XGV##/KMY)O;gc>E
W>3=7Dfd=Y:N<S=ULW_FTYHbT19&&M#=[B\W(TDZ<Z@ceMAgAEFC/8ES[84V2-==
U-+[aeM[dXKIG8[>L?\0(0N0Rf_@N,EfKK^a+VR-_:)&MG<@VFKWJ4&U@NBR5P0=
ZDOK29>L9S<.[CK[[O#4<-KBbRIDHM0]A==;QDHg-OCO:OJWQ>KM.L7S.?I.,5^G
<::-+A/G2\D3M9(]d:FX0RBQ&]]ENKGc,bPZ>;YK8/XP\E-LH0gOY5g\Vc,PJ-OY
3W(7H@SMHRS<X_V\:4.Hg4-HZ]Z<XcJGK>>YEIf0W?cZ\DF&1La<TEYU<,d87]07
:8)?+XD,H_&L9UGPc-3e/5V/VK?[QZ:8TbJA-E:@[=Eb?<\#UG+CKSL)25>.HP8=
2\79c?[cW;HLAONHDa,8])D+/SI8R<-_5:12>6Z-IV:f.T;V>1QZWX&]ZGIH=/bb
?&LE6eSHYA;NCg\cFOB^](Q=3/fc;/B4aUF.J3ZI8]f^^cL,Y\;Lb0+..U^92W3d
OQa?CH[-XL87HSNd8gG+#JZZFPLA&09eO\^g9Q\X\=Y[W)>>R[Y7BeP+5M8f,W/\
5]LD+38E&F+PEHM]Ya)1>ED#fTQK4VE800)E/:SFf=PDE/XZ#6ZdDG0MQOZG-W95
;>D38#DE.A:^&9[a0dO]P_^bYcbT-/>fST\D23#T8]&1J)\H6AYK<d\fYS#B,Y\#
1G#SXa^X8:?1d9);7;c@Vb4S5@CV-H;GX1_0Y/)_#CBFCLUb8KDV=/[W?4N@G341
R#]N;eA/KAaU:;N(QP0L5HaQebW[XeFOd39W=\7X(/Y;HeF25/S7WEJCCI<b/DZI
<e/,ONK+RZMgHR\f#M/\#F^XTg_E)M25G8@/UM\0;J)^A&PFBM[f?d\W.L5C[CCQ
9C=-0-=MK@;.:e;#76IX<PK&f&L>-4UERW5\/egOH6KZQOF\^H0D+?Z\2aLKP^+5
F;40dJNHT0A?]?:(gAPEZ/Ec3U\bg5,CcR/De2+#;_fT/5&/gAO#dA8L8L5HNg1Y
XZ?2X2GKNa#WJeL29&[B?.Z&<I83_VP&d&Rd)^f_GBG(&6g&ET;8b\O=g<.)S>=a
aFAF3AJf5,+dG1Y8@EJEd0.)K6?>QK]OE4P/-]gY34GN45R&bL1aVa7].]DBH;5#
UKGfW0@UQT]PJ]Q=;_ZMV>6HQY<7e_7fH+SV9(]2;[+5CQLLJScF/e4?8d;C^A8/
gW&Ye7TcWN?0):L</12@>9)J=Q1aZAFW59RO3GG->e)3O@:#;G+D9MNX)bed<&]/
;@[Jg;9_&^MX^U,&A&+WeSc7\NMaK&?&-R/g@]BSU+4_)[KY/3+JdZ6L=NaR^G)Q
Oa77;bSEOg=cR6cM?.8a/NT(BZaM1A)H(;+:^f<+Q2FeX0NAD<)X);X-<W@Sb#1T
Y[0\[fRSB.GfH@TN4K^<Q9:#:E^QCddOeM?[JO4>8HODI.\5aEH.YJ_#<2)PJ/4X
;I5>g=JN2D@SfPU:=<<H1_\Bea^1TL+B8(,(E1M3Vb)[<dAKDc[?9>5/71=V3L>8
]aI2#:6QI.&Rb>]UbMQBAe&-cC&cKAUM5Q;X()H5V6@eU?OU5;N4CO]>WUc:e=HC
b&HA3DZ>K&,KKg@Q=]e5E.EH]@efJ6E8Z/a.RE&K-5?CZ_@O@g(gQ4a91?62f#;b
SJ1_R^K6AHYHT_a2:X&>36X0\,_><V=Q0:5X;gHO2_X.H?aWgAf-/30ATgKRIM3L
1]e.UD>VJf,2>)FG4WEf]B1D-G__C]([?8/KQBB[VGb^V1)3R3[KA1]088YY,Y-H
#c/CcAAO<Wc-S^LZY.f=,UP?;_:,JC)/UM:]BKR<=#?Lc,gRI)62b0)#>JME=bCK
&Z[db03DD3dK4:eG5ac^d+@4;-YQ.9)E28agX0S0d71P3gJ,2FacL(5H/1C;^ABF
V)eE<+QTVaJ/NY(.d6]gR^D>bW9)KZUI2QUXD.WQN:0_+T[XXeIG-WYW?@<2=#c5
JFF7LW5Y/\VY=WH)#7>1I+IdT=UgUAgHE,g41cQ1NbOW8,^cC,P_=gU;cL]J#^++
RQJb1;V/I-OJQU0a6?YIB+Yb:5aTP>K1W.(HSH1(EeDFa=MF&4gK(5O<R\14\CQY
T?YT#ZL852IVE/P7R+e]aGYVM)Za93?_EN)(JU&@La1,>e@;9c0AJ#=L1\Og<C5C
4.N^aNc2^H<KKW6SL52M,;[XVCQf&Kd81g9;M<4\EPRfP<+WE^6<A)dEEaH/CUQb
AVgW8SL=#[2GY3+=bZ](8II;Q_-3FCWX=M.ffX&V+ZS>^[aDHdBXNBOILGJ5:91M
U)[2D<T&AT1QJT]^:0_LK[WAPES8[PTOD1K+.[(.K\,.X0J4<Z[K^eG9KX.U]O=N
=O>W9?@]MG)Ua1?6FEM9-f?FNM7f4B]K(T)/+(,LR_A[2a1]_d)^B5[B:5M=dTbg
[9aEe?^/_C0S-CW.S7XTf+DIT,8Q6DI(8TCM./-RFCS>PACNC6YY&,UB214;)(KZ
YFH2OV_1,#)/,A>OdC9Y6KDI7$
`endprotected


`endif // GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV
