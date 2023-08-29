
`ifndef GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV
`define GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV

`include "svt_apb_defines.svi"

/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_apb_slave_addr_range extends `SVT_DATA_TYPE; 

  /**
   * Starting address of address range.
   *
   */
  bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] start_addr;

  /**
   * Ending address of address range.
   */
  bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] end_addr;

  /**
   * The slave to which this address is associated.
   * <b>min val:</b> 1
   * <b>max val:</b> \`SVT_APB_MAX_NUM_SLAVES
   */
  int slave_id;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_apb_slave_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_slave_addr_range");
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted. Only
   * supported kind value is svt_data::COMPLETE, which results in comparisons of
   * the non-static configuration members. All other kind values result in a return
   * value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
   * Returns the size (in bytes) required by the byte_pack operation based on
   * the requested byte_size kind.
   *
   * @param kind This int indicates the type of byte_size being requested.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. based on the
   * requested byte_pack kind
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at
   * offset, based on the requested byte_unpack kind.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public configuration members of 
   * this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public configuration members of
   * this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive configuration fields in the object. The 
   * svt_pattern_data::name is set to the corresponding field name, the 
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the 
   * configuration fields.
   */
  extern virtual function svt_pattern allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_apb_slave_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(slave_id ,   `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_apb_slave_addr_range)

endclass

// -----------------------------------------------------------------------------

`protected
Ab<9[NU]9295bHD@VGN0OEFT>M9Hd;dPMAMU[G;AL4fCf7eQI=Fg3)SX]W2?^_N\
YR66B[YW)7YB&HJ/_,3WAVZCK-#eQ6]Ae?6<@)DULMcacJ(P[V8^W3W&AA2Qg8\B
;OXKMJR?Wg0;1HN8?,GU/NA6/]WD9Na]?++VF[4JfVdD+M_dNF>7TaJ^Q+dEGM=7
85:L<]X#eE506AH+L74=RLc(a_:f80K9F@>7XDT0:fOH:M@I5T3RZ-GD5\+DOAXQ
@0+^\.<:I?P#JR-_=X]0L?7W<b8;;K/V2]0MQ1O47(e_]4LQ8E4##eMQZcS,gWP5
b-QEC3-Le=aBHBT4NUNbb,M^PLUB3dbRN[V:3I&\6YQEdg(ab)+0EUYKZ7?@8Z?E
KW\S2RL<N[?C>(O&g?KMf8,c;[10f,g]GO,We_UQTA]AS];Wc^>.P:KUYgcAb,CE
)f9T.2I-?,M06K4>/JdAc+HX2_dYK&cP6G.)@Y-\II#4PS_g6&6[#E?IF(?Q9=19Q$
`endprotected


//vcs_vip_protect
`protected
8AFb-9G3]C>MI@=_#XIJVRJN/FUY>Z,EaJZO3bR59U)W9Ug)53b+7(=g<5.IFWW&
WKJMWDP91C=<Gaeg]RGDE,7D12?X9a6#(BPA3RMZ4e7Y]Y+R]5N]8XN2O\[K/g2O
[XfERbUaRRE&d=<b/6aZAM14#KcX[FZ7Y62>eMaN_5@#:#^=)F+>#/=HJ,0Ae0.e
_3UGXPfXO#&2aK)F6[,[U)8VMDWW(a;><eSa2da@0:a+Q]HH6#8UEJ81(9M?geN^
dH8_G;T\6+ZLN41^A2V];7KV-dB<VJ[V?U-B:_[B;d+[+3V\,NTUH--Y513XBC?c
N3b1@5(-\6X3JKUJag,9C>WTdUY@M)@4&+Z]HH<Vb,H<a?.@gNFT5Kf6OT;0Dd0R
RG+Y@QK?g=VafA/4,Y6,3L<D@N/6L498:<H<S+T3YdaUQL\Y^GE^E@g/0#:_;W;>
23XCMba/e0Vge:C<A);1cd40G:+36P2X2T]gS769UW:V8)IY=@SV]/_d(=A<3PQK
SZT+[<g>Ya2\#aZ9.4B@JHR.eeeD2Y/T]A?PY]JHH^@b/KFT=#EEL6GcaS[-8Z-Z
E]>.SD&\T[6X)7d>:,a/d@VUUUb]>6&C>ReRg.8NWcb^>6UCQUWSFd?c(cVI]OG;
YV.a7O4e_H//0Y97bWS335fH#3]-T/G&:=.\)TM<84RBU(;R#3c\V@&gg48Q:fN/
(a1]DQX-[dP?INMa7DbJ.a>#(>#NS)K+I:X38]E4Q03e\9@U3[I1-2bEc\f3@B6E
?c:b#:49+gaSRP<L1VTD0S^&:L_5D1)TH;_f8<WX)P35=9N]G&V?FDTK(][bJFAJ
@AQL?dgf[Ua[OdOU\QY03.N)f@6ac(XVS/3,3EHGAc?/B3>/aAG5W;Ig#2E,ca4+
F+dC>0(>d-?aFDdfaBO5;f/82MAR,T_[74SZSHfN/59A8DJHa#C[Ee\L,MK7>dJ<
Ie2GJZL?NO>LI>>,^16fBU^YH/JWO#].Hd=3K^(G;Jd8^36+,:BXde[/Z&B0+7Sc
8O[>W#b4bK(3_@??=T45#BMe7O=^:LV-TJOOD<NE))=2OIUb(.)??[:?Q97?PV>B
Yc<Ab[80>J2aB)ANC\C_gP^M5Q39e31=]Yf96OG7Oe@KH6?;)(A[Q2JWT&XCXed>
)=db2(^2+V(\O3,[.WOX]c_48A[\^=6eXW,-6=b[31cXc^U[e7.3BLWUgK\=/5g_
=4N)W-0G.S?.79A?c#c/+XG-AQB4ENM.PUT^/FK\J>g^@-Kc]<VU9bGcKfe(d+[4
E#]LN./+cQ(KZ&[I<JLf=aV?W6bUJa.K=\<.67WP1]ZRLP_bU?^PUC8eJ6/K>FK3
-VOVg/U^.F/]bOIR=OC;@0&?FWN)4faFdRR0-J.-NcRD0fB7(J=QA=^EUcDNE&7<
Dd772-LaN9(e89=P^8eH[U\6\CI&SaW^eX6@UM,>K#B&075\,Sg9FL5[(2/:/]<,
_\GO)Z+0+cOO8C&Jf#MNTR-X57EfD-C/)7H_0<DeCAJSTc-5SY9R9;G-ONO6fV3F
J;]-<g^6=SSJVg&.IVIBacB8\O&d35B=+Q4I?/556CA2])X<acH;f(+&1PFLg:eW
WNS(dY:d]M\)eZI6:XYfIUJOR)QCW<:IQSBbL.1WQMPTAQ#c<WL>@R=0/W=LJZRK
3_Y\UL/P35VT59f1XNQVDL:>+.W<Q;8QaMX_YbaGY,:N50gI@_0TfI+6]<dUWde=
-ZRWLC?,2,+=cLDLa7;^B5,-N#2HZfCIRZ9)7Qc9&XQIBNM:\gT&P4fRH)X].XL)
YTeQ1N784Y>;?TJYTBS8?-f_U];S<C=f?a\@5,g:2[89K4&RIe6\K@c&P[HWD.@Q
c(-W:(Q/B]I\?I=NA+:Z-/JEC,&Ccg>FER-UL[b=LfJT][g,#6[9&aD\CTa(AWfa
g.81;M3]8I10N5B0b(M40>^/R[R6)N9(Xc/\I,^HMRWB)UY(NQ7Y8@]QJOHP,>@1
D&cgCg^D#VQEKJW33fP6Z9+#6W=ebY_e]-fI2?J(U64TeEN3cQC>GCC-e)02>]BL
(&DHdC?_1UJQSJVdLTa0f]f5=3=(#e(,ETTTVE[6J/GW6c>_dI8fFD(Z@8Jc5bK]
feR[DX(EaTFfZY(<XG7eX6LM#-&&3W4NZCe94<DFSD1CXNR<U^[c^^E+80#Ye[K>
(E\#EFP,]#EO9=I8/bd/&QQ3T/A-TNc7b/;ceK=#/?-1DeE[(6-A_edg;YHZRKdT
]NF]XM8L_?N&7X_8=V&P(^fF?<]-OMPVBBegDH]a0#<0WF949LGc;Pg7ER83NODT
(/dcIX4H8If]#6ZSN)O(CJQL]MZEWGdb(&3W@K?fFY?8LMGbG=\G]N_/?YA;,;Aa
0Td4HD<L/D0I4GQ^T1\;[^CcTT&0)ObE7f\P//(OX-&9b(=WPe4\ZB;WY@3O@D>]
N^P#-54-:\UNDdTB]POc2QE:<Xe-95QcWP]9SGS)JN)e]F6M@I+GZbZMYL4dZXSa
-N@BfdN[#Y)TV[4]Q4fPKU\A5cCgYAVJ[54O.BL8ZE+</8d#-Lg1)3Pg4GTQ5-Z7
S]H4T0TAS6@UU]F;R8ZW+V0[U_RdG,[8FYU0dGK#M[f/?)D,Vd<[[QbPI5FF45T7
aF)4QG1<NK)/[/65D2L</dT6@Y37G[f>Y1Y@5GO#g;<(C\0[+d<84g<3ade/9eG[
UfD?@#+B]9f9T?0JcP@Hb)aPH)?d8K8^O+GY^TdMU_<Y6GMUV0Dc\ZbSb-fCG_Re
<Y<B=S^:=^CU;?/b+C<?QV/=F<+X^^[Y+EXd\)H.Lf2D4HZ)aSC86.:eCf#BMFf.
]cK00e.\W^H9;RG-Z@-7?0M1/eSJ,WOV];&Jfe/E7EQL.32U.[Ag<D]bVZLD&D=T
&&;86dCV0W^-OZN9ddP5U>_P[(7R7.G2R0M.GO<Iad\TcgNA24c]d8[fbC)-IJWa
CMXDT4K.^PVOHEUAbJ]\+?,[#VCb@:4)D,^A&dI8_2:<gCOI^?W\ec4JZcAdL/TO
J=d6MfNgZ3SbW5+L+PABT2]XNb(T0Eg(<H\+0-I2;#BD1LMBe2/2cJ&?01IBDR+R
Ra&&9:7BW+P-aLFc8B.b&Q6XJbXUG4f58d5_P-+C94;>@eKILLEL998?0^KM[eD-
W78a:QO))QMXc@Tf&)Sf@KbSY/[:LT-2gI^[F91_JaeA3A&6EP0>^<TfFP]dL2W7
YPAL\BX?\[XW>H+W?,e:>.GW+FfA\CLJY^E;=SJF]@\9dgKVFPQV.5]_ZfFL6ZY1
WEWe)MB\Sb0;XJDO>b,adBMH<KKL.D.EMGR8?-0BP5-3XE,2BI>G-?_UZ6Va&)O2
]B;ObQg)&2JP0G1(1KC\QRH4#QPNCR8BU^D.1fgL9+E_M;ZC0-<]bSb.ASU[T1Md
AAJE=L4gfU>)VB-DZY5gQc.>J51<62F.<a;_23RJ+T6>L4@>:K@cTIQ@-OcZ4)]V
Q+Y,2[8<b.6e?5W+f[O1N0#cPJCNKK#NLb##VR7R8URgPACZ3M/_8;>GD2][SC?L
6&&VDEa#gJ.ORR^H4.=LDM8IDfK+@HWD94fG5)@(I>M-QP2@c19>L(]O?.KM2&(,
Ed#bFc;HKW)#SM=D^@Q.#\_NS\HULSEH1TCbcYXRE?>08[F8;#YRb\e40,R1QPc[
2\M^:L_._P[cbWCcYc[B[B-4N[ZYf<T<TE?8GeM<DbFS?ZQZ^/JN[&eZODd7AFg\
_4VVdYRDcFc^<K@dSf;M_V=6gH[g;C7VgWM0A>]9TAQ)3P,g1,5UgAe:Ua_U>VAa
O,S\U<A[g/1=8H,R<)_UfeD7QP?EQT]g_OO5E90/dS@2L=e+=7d8aZ@O=]Y)3#+O
PBeC2GC5M2T1^:VTO6,@..?3[^eg,OV<Ce@&b787c==LfC)gD&,@V9VD)2/M^&/?
Ja8HBbc2G&^MZ7eA-+,<bFVCgBf/1g-H]T9WeO,R5+5O_#fW:K(<H\R41:\XY85.
^P.AQ,IDUI90\]IRXKG3),6.N6\6Y@A4R=S5/N=.4g0XGbg?Y0XbF#AJ<e5cC/A9
feX7#B0@<(#dQINGIU#M2(?dIO-OBc0g7=fZa33eBZ0T)N?Cf#?LH]8>#=3E9_&g
03[Z[1;NIO)f;&C0#Z7Q74c+6d8.MQQXbMS]#23X\g<[8?U9#b0\NQB29G24\2I:
Ma(7gA4?J85<J3XfX1,G#^[C[>#]-ZN?5)>+<:E2f>R:BBQQCZ0W_fbQL=F>/4gf
I&9aW,I\,]E>,^L238<(QS/7JS-6]:3gUXcK4+8NXcV_M-\D85;Z.1Vc1JNe1U=2
O3>cbH3-@:0dg>dA>W.__fD(eVQUQ2]^,595ZSLdK,AY_[3U.TYgaJCHGX:[,<.V
8K3KYA@[8F?3<d-4Nc/R/3K<F5:cY>0A\G3[9-]##5L+cGb/be[,H-)8S#X[GUNf
]1SK\^U^U&CVeN-1QNc95?YD<?Y39P+_Kf4>TH4gG\ZXO6?LX/TFa57\3/]>7TKf
[&:a^H0Vb(;eV.H>PJ\UWIXK<IX<TcM_)g5A00YQT+VJDdV@K85d-[CL]CWLLafg
#a=d.FY+J3+C5]gU;TP28:HdB^#XZ(VI_@b6M^S48+,L]?2&+RP4[<3(9<65VRJ3
KQSR4I94_H9Pc5:::#Be(@H6;\Uf58Z@:2-Q(eKb-gSB.5\&Fd5#PG;_-:XfYfCT
UIa@)@PYJ&+T,Q0[\GC>,<H/23fF.RQN>D/WQ8g.YL>WD+A;P@d;13ECH0ea&CWE
;K5\[S94ZcfY6a#[O_Cdd/[)=C9a01deTge;YWF=B-^,cXZY5egW.^JGf;SJbJ6c
.V#OS2/]H1_GW?Bd&<BadY]Ue-e9_DU<IDE#HVU_QgX//Y7[>.WL/S.IWFYG&QAA
87aCfUVN,2M2gWAMIQ:GdZ:WD#4J.a-^QTEEHHObaX86M.6-RL<dPYYd@<@GA.0+
I8g1\S\LTCA;5&WK:DEX@VO&,O;2#;R0BRZP?+a;.4<g?^6/E=2UQ.Qb:@C2@2@K
X2GHF:Aa8g&A7L5,O5L]Y8S)M#4672/66E/:\Dc.DdKLABVMG)^1,GGCNfL2ZI^4
IR0I3ALe?3eRP7[2a=FgH8KFBO10@;&^8WO]L8@a-b39VAbD>/HCB\)?1ZQFf?6>
5?^POc+#X5U&#5,76cHEUG8T,I0^]>>&ad+WJ&8YFO#^(OZCecKMUZf8PTe:/cN_
H;KVYHQKLNc,]Lb3I8>9G6\<eL2BO_C.dPD&?8bbWH_dA883c^;B\b-g2Y/./Xc.
?13#f]FL\_.G0.[YVa-=A8>38/>CDJc-0_5T7GR_\)bL<HbJ<>HFb,<T1=RLGHHU
T2I-b\4LAe3_[>OePRcbfeY5&4Y8-,)H\&^d0fd/4/cK/4Pe9LF928GXAbS9d<Ic
=,#S4>=K;O]#A(3+/&@VT./?U-5EP=YD9.S<.,Y.II5(]Oe)1CZ7:H(?^e7COcL2
D^3-#F6ff1(I.)Z-+KP\EW[7dSH.OA3ZAe01J?,a-1_R[>cHN?FGMBWP:Fc3DY@d
ENbP1C=bW)bdYD/>[:fV<GB]La[M-\TOZX8^6b,CF:MS<Ac(efQ.IHGdBLKQV(4b
e+Z4gcNIG9-V8/^D>_(Sd,&Z4(82Z;&GKKa]e^A(STG>BI^_(80gE[aN#\.-DGf8
;8Jd)68QdWbX/gCLKBf<O1g3F\U4dPXXT3XL](_KXFX?eaH-5c)7Q]W0Q0X&-&ID
,(S14bUWIK1Ie1PDZSA1b@W9CLRNe>^IB9X6Z+f_(TL5@GgM]XGD)_4&M.)#-LKW
TVNDU:M^0,/921X10eC]-\7[3TP1:CU^FCPU]\2:^0P22VGW#:#g>^V9E]BVM4K8
]Tg[\^UE7<B:=?&&]GDFH)/YBQ76^KE7,PgOTDc:VX2Qd:TRA,?gCW/@MS4I@39c
:&,TZY1EM,c9\<L1>0eFF,]J@<XN(NK2/dV_YcX;@3&.f8-)1H6<62&cAaF-3.N<
RP:eJYcYa;84U:R/0IV7=0/+B.<DU0@QK))MUNR,I0-KH]FBU-HK,EeZFMDG&1?=
a7R,?b2Y>V7(<Uce4-(,28-fMO@+b<#_YY/D\P:?(2TI&U>^+:OKNT-#McK6/9VN
,F3(X7SOFJ>P\AZQ,d2C;SH?c^ZT7<TZV<B+-WbH+6[;U0S(CZA\OANKFH(,aI9;
/JARD,9M8]d)IEZ02,bH/7[MZ1)2g_=MNE^GM^>^\90fgT&eWV7YV&0E#?d_\cA,
1#Z<a5<K[<6RbcE[dJ=RUUAEVa2c\.(5(T0/RVB[W)AM5U4ZYHM-#SJ=Fa0fb9];
<W+H6^;)fNe;[Q[//.GX@#[:(UHb3H?3Ld9-f_#Y^W>JbbbFL.PWO2>fCUQ.M<=(
D>Tc8)5(M13ME3)GRCJSOgf_GS<F-Sb+,ddP&5D<cTU0QILX_K#KK0W8F(^g[OOF
XW0>Ma/-7AK_+V_7LZE[)CA.AX0S][(Zb06<U]Gb>=SJI0c9a>.4,(IHK5MCY6S.
8]_HK1bPR;Da(XE4[W3F_3>2ZbMe/-d:6Bg]2O:&NMgRSdPa\5b8^P[>9D_5CM[P
Ma<c<.>g>>2[7&B(bE?K:eC@><.WVbT8YV^UO1eIe0L:(Da/EDD4P@RIGR(VG(g:
aHS[^HH]F2B0dTc<_0;7Y&:74ZZa.I&(21@^NMS(F9aFN0;-.#<8-b?E7SF64eLT
N#6.HQZ/OMAVD/UMSKVLT1UV96B-[ICbH.]G<J-:V/Y,_Nf-4-HS<>[Z=U+FQYBH
Y,+\_3R;0ccOT^)QgIAT/V8N>#OU2Q4T(d#&2NKY4JCU-dc\(MU([[UaU5+Ec9\[
:J.#FK9TZe(NFfI,A^.DTcHac&2E&GEZ#UCIW?_B>[d/bCb9MYP/.E5OJO\B);46
;Z^,Q,dRUL?=\GHUOFa#TM_.@(YC&#a<FV9eHDN1Wd/X/CZ5(KZBER\Q4I>>)F>a
6B32YS(OfC=We=b?@.d18FVG<,]E,][8]+aQPK0.R)c]OJ2JI0a4&60K5R=7H<fW
>Jb/RE3cL)_9bOd=DO<J36:Z?<+-SP_^=&7TK5@X<5AS:^CJ]51ceD,dcSPd>BD<
\7c;e9a[Qf=f&^0EbSg6707eZIS>KI7+Xa8XdWc8,MOGdd&:]eYSR-@8C4Y1.=V?
6)F?^A);W-_9O7Vg0@.3RD;_II?7)-P-a03^-=9IWO-=2BU4a(,Y-ZVcc]7]1;S^
c[9ZHafPUKT-O[)G]^GH\6Dc<TT,&HK&KU)3-;O8XS9g9K.D0I+UGZPC(]4:;:?Q
bg(9.STS4#CW&>g-JF9;]^QYf?HN));\adDL[0.5&,b:^GLIK-1)5dQU>W<=R]4+
#\DeOHK=\@YFUDRB:@=(Z-Z-2V9?1Rg&=>BMJ5_V;LHCMC+M2T=Lf.U>d[9SaP-X
A9KZZD-[+^5gJXZFc:YWP>8C+1?S8F-:eME^4I)G)Gc4#gY;RG<,;Z&JDU)[?,.A
1Y?VD-A;9R.&bTY)^V8]/ULJ5aQ>Z;8Fgbb.AbT(]75aV:X2T0.9P)c>[K7YZ]fA
GQ6(L0YJPDOBEB4ca(.HU^?DVSeQH_H3V74^Y.8:Vg#P:a=-4N#AWNC[9JY]#90U
][5W:W+5=J02\LN32a,9&_N8U8[7X:LX_N>;#1T;;2+0(@)]9Y]OI45L#aGU)AMZ
.4&G6688W.MbYb[F:KFUACK30->b->-1\4(&RY?[55]R9?I6TFEISELg;D&G1T?#
>?81T-\Y&W,R/Z5.Uc+A(1D0D&1_[>&@0#\d)I/ER720>[c3bT:23?e884#K)G#W
)]<)R9[3MILJ>0TQLOUg=&Ab01PMdAQ7=H(WY>,&QR6.:KV@G(63>WFUfgeHXaa?
W&#e\XIH=LN/5B<H,]M_NX2b+7TZE3A5^Q<7TGUX?Z-07FgYN9TcM50GYE6>KLG=
YO9SAS/=]1Q\4^N#,OKg0T1ZV[01_)<P9]@W1CJZ?F=0D$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV
