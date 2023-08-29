
// =============================================================================
/**
 * Class containing the events for fields in svt_axi_transactions. 
 */
`ifndef GUARD_SVT_AXI_COV_DATA_SV
`define GUARD_SVT_AXI_COV_DATA_SV

class svt_axi_cov_data;

  /** AXI Port Configuration object */
  svt_axi_port_configuration cfg;

  /** Array of pattern sequences that we wish to match against covered transactions*/
  svt_pattern_sequence cov_seq[int];

   /** 
   *AXI transaction fields coverage */
   svt_axi_transaction xact = null;

  /**
   * When a cov_seq_match is triggered as part of a match, this variable contains
   * a list of the objects (i.e., strongly typed) matching the
   * pattern sequence.
   */
 
`ifdef SVT_VMM_TECHNOLOGY
  svt_data_queue_iter cov_seq_iter[int];
`else
  svt_sequence_item_base_queue_iter cov_seq_iter[int];
`endif

  /**Used to track the Address handshake of read and write barrier transactions required for triggering the events */
  real read_barrier_start_time, write_barrier_start_time;
   /** Barrier Pair Transactions */
  int barrier_pair_sequence = -1;
  /** Locked Exclusive Sequence Transactions */
  int lock_followed_by_excl_sequence = -1;
  // ****************************************************************************
  // Sampling Events
  // ****************************************************************************
   event barrier_pair_event;
   event locked_excl_event;
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_axi_cov_data instance.
   * @param cfg AXI Port Configuration handle.
  */
  extern function new(svt_axi_port_configuration cfg);
  
  //----------------------------------------------------------------------------
  /**
   * Method to kick off the dynamic pattern match processes. This forks off one
   * process for each pattern sequence in cov_seq. This function forks off processes
   * which will stay alive until halted by a the component which initiated the call to
   * this method. 
   *
   */
  extern virtual function void activate_dynamic_pattern_match();
  
  extern virtual function void cover_xact(svt_axi_transaction xact);



endclass

// =============================================================================

`protected
NT-PIL7RG;@B3g97HQP^BCcHX7NG/#I@YeRCT).0U5[C16\EP?d]1)+;KITbZ>.]
XGS()c;1b[>^PeR22<<E9K>]P+-bF5#<?3YQc\B>ZP4OD]-a)4#OONNafVJ@F[eB
5a,#.XfQLZfIBB/I-_L8.VCb[@P[0_O>P)cM(Dg))&P1AbW/J-X]_,,0-H,.A\\T
b&F_&Z30&_N.S_.;E@8Bc>0dF(L]Be#]0>?8_F#bZ3Le@+X0g+]W^J1ba_=X_OAU
4ad\b#V.ZQDcZB,;^@F/(Y=NUd<[CHY6T0<D4?4YH77KR=@YNe?;]A+LKJQ<Z[@f
Yf\SOE7B2/HN:dO_H8aJZ99FU]=T(J5Ce&DZ>T5J70OF@^Sd&?)1<d-;XX5YbgF6
Y3N>7W5_4g=N8SCe44)3D92:6E]\DC3Y_B<)RF7g:&@Y^I[b\ZTXI6@J1YI)ZY7L
>Y>>(6G=\P.>G(ML+<C6=18\IRT/?)e3MI/TW90OVC)HRA4PbT>3?D;+@JK]3KV4
]B)bC3<W[d?N@R;)-eC:I,EF#fIZR)gMA^?&LPGV,-a7aTE9E.T5=Ua5NYS.Y[XL
@#9E\ZOWE7@XHH\)@\]9XVE@79L?0Y753<TB6K5A8S8ff\g314J713,I-JZ&&DK(
P[YL4DZS,9H,@^XA.=NGGUY]JPbDJ<bAa.B]U3E19T:M_I?>:W(9?_0(P+A_cFA2
ag587A>OTZ1EIQd<B#W(Ze6@ID?cE.><&[+U2IT<Mg=5W/W5[D\1OCfK;T?,eM9.
4L)):X&c2^@Rc_=+.+?ZS#B,9K8XT[=FFYK(8EJHQA4IT,a5U^]4eV.K,g[KR,J8
#4[2].,><WWd9f-V&]b\D+Ee;)f5V6<W_-I_EF8<HV-G1R^YJV7U#Q(a#ICR=7Y5
LLe^2TfJg:=9W^YGW2)BMd47-/fAILdVS\cG:_/8,YdE)#KaGQN\B,8^O\F5Dc-+
&aWRZ.^5=\/@3,DQQ?e(R4E&=cKOSIT/J&=:Jb=XLeO;Q>;C4J<4D&?>bfeL?.Wc
V:XYUBOFSH:R7Y>)WBb&M8],==GX2G5g\R@b]3Kf23C3ZMPL];aN;2b4?KT6;PW4
3)^G@O7FecbX-Z2g(3L;6G3:<)S]>@YFB/VM4;MC)O9)JP21K1TEH6d4Ib7)b[Z>
G;]D2deBHTL5H-M<?Zg_S2AB_DG:=G^59+#@71aab3OBd;FHW)UBe5R#/a]OK[c[
:,dc,_/<1C>0AVSCT6:DKNBP14c+1U[Tf5^OgOT6d2ON;^>5XY#G;0X-fd:2BAZJ
Y^L?4c<RYG;;HEY\Z\O)9+QP<JU#6YKRa?Q@:DF;TEU.dW\a3Sa6NcJKDa-F[#6<
:Z>c,HU0&J<N->bb<eX?Kb;\3aeB<18@dB+BC>8Y)P&VQg>);_b<XH3FFPXd]G80
WQI4=DX1US&C#4dJg7-^3)BU:gQ-Y](H+EGb7L58KG=D2C\UU:c9g:be/U_2LKYY
UGT1#\g+Pa/^gY(Y6#4G&_(e)dHRWFQ/J=W43(TX+/@YD&\CVW:#(Q>6MO^F<TE)
1RLK9?MI\ED_4GNO\J7Vb5SbDId1H[B?7S4CPV6Wb:c3,69E2g#_-eEFLVK8:.-N
:X?SSfB?7UTBZ-/7O:aHU>KbPJ,g0+.IeE;><SfW#RO9=8D)AcKF(&))e8-5@D))
@[V-1^Z)Ue+;+Q/UI\T/V]8@O:d6#Xc<8J&OH]&\<?>GISHd.\SN=-Mec+eC(3dW
ND2CDf0FTAX#f7?&WNQ\D0\RZ04R)LK+9\4GPN75IG]Wf\#TT2OIT6@c9=7[MUb;
1P2BU]Pfa_JF?=N7fSd:GWQ,C.JeUD[a839-8;^.:FZ:gKeBM7[@T_ZacU]A)Hc(
L4dN>I,URN3TQ1ZJL/AE1#KO^\CW<HS)cd9]e2[d>ZNC47M5I&=RU/QdSaJ:a?#R
&MdUY#a47++Q8I1VJW<G(>/9]F(+d\ZL6WDBB@(A/J+)M([;=26a,P.14A@);NH9
&3Q\aW4RCcS^fV_7]Y4NAR3Ra=E=3aSXYNR&NXE#=];R1QY;8N?MUV>SaCJSH0Y-
e:AH/1<edf0/3NC_T5&NC)^^e(9fQ:M+J^TKYaOFT\^F?+Y6W[O2fL_PM^?D#?#f
[-5,b=IEYI1\-2Oa8B8&@;K;_bX9X_[N2CdMCSa?EIc^0G^7S<?6F8,1Oe[c>Q;L
>TI<AWYE\CZ1IdaR7XBb4LTfZ(98aZ8\9]NJB\gf+DPT-KJQG6B\^D3/5SAAb.3E
f7KKHWZ479RY3Ac1^ZF/;JR@[WKKF1dA&4-2=J?TF?X>^,/@,#c6\#K4;V\eU\,(
&[3d3gb>S]0S1:UZ\103[WR)DHA5d#[Z>a1HANJ,(S1SF1dLM3@O+CE1HLD0)^?R
0R,UFUOdSX_MD0>bF.#?JV<dZ[P:/6VT@\a=4_]WA[9UR=NfVc11fIW/[>,9+g1]
-)-XE_44DdFA]X,QKZ^YeS)][??I;a&52.@XN-XUF^fD60NRC.OZC]Ce6:=HL_Z=
[-,D6Gd4Z&X;,HP:>U4:N6.DCT?53L<6[egO9?bPLR1B@,N/Qba&)cS6Jg29<L+&
1Y-718a7L/QN^O)MC-<UaS/cb1GIZ<<\1HMOF1D+ASW3FD8@-4\D;1Ve.5]IIE7O
]#_>L/3QaCb3_-bZ<>LQ3,(?5^4@4WR.T,H\:X#>QaU(I<&J^NRQ0TS7&/A66Ca/
g98.X6?8bV&=#EL[MM).S75F2,P=8c&PS+6ab0T4?e1G_ZVP^--3BU87^=Mdc2_&
5^XMO6@#<?L>EP95::V.:ZSN><(;MXc/g+EZ>^SLc_d.<8\R5-Q6;gU<;Y@\CGQU
MX4H2A<e5K90(dUCV507+H<6NXe#SHJW]T#Z3SOHSbP3V]dP@I0A2-[KDD+g4KU>
9g=QH[T/9[_Ng+F919J_YOW4A);W;7/0-_S+)P/a)BWb<4B[N_//2:ETP7V+W9Y=
,-+80)fc#WKDcZUbKZ)MB)Y&JW_X/ZeIDJL;A=1-377CLgbd>PM[]Y#/.QBA0@<:
KZ2>OKCTL^X30FFXF8.,OK,-7c.eB0#G3B>dL^/fYP=)=Q7HF-PdfVbd9IWV30L:
E\3DJ?dMV#A\Xd@1\,/8>G:_<F,bKHaDgaV,1^MH&VIdEe<Z&1<OA2LMcOJ&4._7
U&g2[dQ@QMWUY4IO]M8LT5ID?cIPE3c)O#a;0)TN(3YJ>aEd<9[FgC?Ic3/V4D4=
XFe.7CGPQfD>/.<BX@K(PUa8^;_:+#b5MHT+_[Ic[VH6cfAHL>/09&9\?+GGR1V\
9:?S]#>+4W^_eQ_;T@:caPJ47,9[&a2PV:5<.87WL9>4eBRAK1TNP:a;JgHH;WKc
U:YF#NZUAW:ADIdF@Ma#27g(,D_2G6_R[>)ac/40ZH35?XA8V?5_2eLGCHJTV+QA
:2+-MeaU)g^LP,c0V;<9?SM0,3f8YR6SMJ23,VI,DXcgE/M3LdA&-)W\WT/_-OH4
GfNcD[XO)WB=W<LFOOMF4?IIb;_0Vg52N+-7J>1:8e,W,CC0BgA?3S6[2IO7A]4I
>b2&d7aD&8RfAb2_,K1@B6BYc;S/4XHD4D+Y?&Z64SO-6WL2Pa[QXI=J8a;:F\4[
Vc(67NXD&0AcF(c1E8OA+fLAD#aYWV/WZP?c;NRADabMJWI>g2O-TIV?M,U;J9E&
:?[?;V1>ZN@ZZR@[+=+9GeYcQ[;bP,<S3=4Z<<04NPF_7bTB\ZI#YJY[O#60(SZ3
78(g.3VLPI1<78YH<dNb^F@BCP#N7[5@<==bWP>:]Y(,YEdf=+bd[XNPV-4<RCLb
6>6CCP\TU0N5f#-;I1(Q]9^a-ON/HUXV3HORd9N7G&1dB]^UP/.EQ2I@d#<&R2\M
XA&^XDfCDTO+]bUBA-4OAR^O=7\7V2?BG?/W3BY8#/b+3HBI--L[S].++c#9-7L1
d>.B,5ONJS(WabG[)8d[<V3CU2>dM\Q1-R>OHg)VJCb@GSfTV:IDY7fc;W:^\7c^
LKVI5>OO&J3;DH2Sfd,S7I9+Ab3cLd91]H=:bLDVF.P1\W]H?6B2IaY@)1T^cG\D
51cJZP(D;1?N>^16@H\5DK7.8<a_(L]:=3G^Fbf>G;_DC2RaBF?UN#5gd-5O@a=6
C(_b](KYXX<,-A:&<3>-4/#K<NefK5:(4H?C3Y2d@0HXeI:6:5?D8&OObIYeH],c
2EMY&TI2UUJ]=>b6\)cVeJD66fNP9.KDJUC_7&9(@\+08Vb=d-7QWc]:K:JG?JYd
H,0=>4+\:55d,PYHK:4+<C9c?NK;>5/>)e4Be3RJHXE2X44G>fFE>gTKFQJ_a,S#
&&OP1<QfW(E4e(EDfZLF3Q<4Pef@O1;?11b\WN>HULg?HX)<702Y(TL?d>S,e<ZQ
X?[f@O>PJ@+;C6<&a;>d_BQ[.Q-6bA:-IH_c8;<7SFJVV6N,L8DSJ@(&3#TU9CZe
SGC81DabSRU[V[HH0OcEV7g,RYI3,-ARBOb.>@HWBTa]L;Hf@VAF2Q;OYQ?(5=??
3(fM3X[9#6B++X,LAY3./bZKOKc=#bQC>786TVVD_9_7DE:cBME(8PELQ?5AQ)KO
_aLeQDLUG/g/EeZ)d-#JA462I(C3,ZT98,:Pde(/I&7M<9LVT?BZTY,2KYD/N@Z[
W5^Cb3OSJ=d-d@^d?A@XK,AEKN#Za/;f#2>VSEPN.(#F#EU2C(67T0Gf@GQG\]+0
A7X?.0O0RV_U@SZ7JV818M4S2f:OHXU]P331ATJG6.de\6,X7K1IJR^PO-3_9@Z>
DZ#e+L^+aBF?eS&cFYEA/^Yb@RI=6_dXCDLUMI3C91YD3T-f@URV&44T-c4,U_8?
9171>3BC,=\Cge/0;cHZX-/Y)0ZEMY1B5X0CN/G_:WL5G(E&\b#2,Y3QBL8.?[BJ
gHM74bbV#7QKSEdSf0DK.f+__O16<U)g^_Z@(8]>;3I03F3L(]cRCL36[W+8?EYP
[XS(J/a::G@Oc7G4+MD55KEaEf_3c)O=K7F(bNT>8:U+5-^&Ygd^+MHZ/cNd7/MU
DT8#T68>U751LBQO#48#7B.=E.cSTIROcKVM=V<b#\/<WZEK\LIcN3S4\8JJ6(AX
]_1Z:S)Jd^dH4]\=LC0X5@)/-CKYc.+;;QILLZ825?TC_;@PWUATYUL?YL^EU_E?
cCCa4,ZK=<Y-W.OJ^QHQY>=+IFM.[Q,HXJG24O103/faP116+[-WUfJA3</f]3_A
f4RIf@A,fQ[--Q/\)-]L9&=+5$
`endprotected


`endif //GUARD_SVT_AXI_COV_DATA_SV
