
`ifndef GUARD_SVT_APB_MASTER_MONITOR_XML_WRITER_CALLBACK_UVM_SV
`define GUARD_SVT_APB_MASTER_MONITOR_XML_WRITER_CALLBACK_UVM_SV

// =============================================================================
/**
 * The svt_apb_master_xml_transaction_timing class collects transaction timing information.
 */

class svt_apb_master_xml_transaction_timing;

  string transaction_uid;

  real   start_time                  = 0;
  real   end_time                    = 0;

  real   transaction_started     = 0;
  real   transaction_ended     = 0;

  // -----------------------------------------------------------------------------

`protected
&RVgK6,A,MC9=E)bG/1<PDIIHP);I[=OWW(X[^?5A#E?=U17,X&G&)gb(9-,ZLHL
gE=(_f75XZE0)\;NO-^^M6GfE7]O^RQ#[J,QMIYa(Te@==1f_ROa;UP#G5R1.J[8
I16J);R.H=<LPIB_5F9]/[(0IB=+(A_LD=Q^A;NL7KNYQ[5R(N>X1a+7@ee_HUO/R$
`endprotected


endclass : svt_apb_master_xml_transaction_timing


// =============================================================================
/**
 * The svt_apb_master_xml_writer class provides functionality for writing an XML file that
 * contains information about the specified objects to be read by the Protocol
 * Analyzer.
 */

class svt_apb_master_xml_writer;

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log = new( "svt_apb_master_xml_writer", "CLASS" );
`else
  static svt_non_abstract_report_object reporter;
`endif

  string inst_name  = "";
  string file_name  = "";
  int    file       = 0;
  int    xact_count = 0;
  
  // -----------------------------------------------------------------------------

`protected
4+\,6&4^)e5b8VI8KcAQ)^fE<V-g?PDeLIU&LM9JA22\0;\g\b(W6)@XQX;0NA1.
XG_2+eLJ60?+&MRH6dc7G7R4Mc.)gJaKB_#.f,^?1-NF#GAg7:PM[]UGgZWeDC#V
\XaORFNfd+(PP?MFD6P:(e>RbYX;V;eP;+8?E;K<EST:_HEE21WBSVf7K.AOR7BQ
Z=3_F^CYQE/Z]_eFG2;)5=e1f8=;<(>/L69\?^RN3SSd0/,VPI@PeM(<=D]H<.2>
F>^D</W@Vb1-Ob5PYdKaSTZ:V#HL<3DR6B&#3Cb?>EI7R#L^QH:0,Tcb7H-S(G\D
=CQ=\bI47-@S?LU95O886e,DdYHb1:PT^DBMR<A7Q)A@+\RXf]KG.JN(30]aHV+3
3_/HC52_]ZMO(bLgA]PY@]9C71;AB/+]&cg]6<E;QG1H,VO/?&_NG2)GQ,K,ILJ,
e7=e1:9/+&_Y#B[NPbS&d+?L/@FS5PN(1^DBSVegGUF1\>/-5P\.<T3&M,U07R1a
>]DeUO8HP3#Wb]//e8N.TQ?L8$
`endprotected


  // -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
R)H&T72XD2E;7[KJ@=TaRfBMNK)85[IPAJ9cSRQ+4XG,edFHHfcW&(^a)<3N=41g
;gF&&_Ne#W:-^B\.7KXef8)R]GT:D8(6FcL(XQDJ0bgQ&]B\V[NKIN#OV=&TPKfD
f8M>GGO.&bZ9F.7+9.SBNW5e=-?7&-1([c#J0D<d^O672Df2b]_VEMH+GdedGOf?
L5INcb(W#L991NgdB3be\Ze_Zda<c;fVTSc#V[d)FZB7NB3H]e&cUcL[>g3)XD<)
Rb]f6f#(&E=&DJb=,A2T2OIQ\;0Jd?GO2?I/].-6?+@gg8_T:NQ]MNMSRgSMMVGE
[SQ^+I#^EBOgVEBMM0:aMJ)OFg(7MJgK;Q(L/4W<<8..U_]#a#Sae/39M<MJ#@@X
B5[8[,;7?e4;3KaCM^C3_-)_7M+H3ZE4UIR57/-WP3CBcK;9BW2;A]HQ3b7BMYXG
N7S[]]DR(=3e]VK8[.D([BS,A)[8<cF_;9-#HO1J?21Z//Cd0EB-]g>IJZ)&e^R[
Y?.8&3709H)Q7H\.M2I.#S>Z/./4agC5g9_G@aSF0Y4TdWUHN,[R<QZZZ32>Z4bD
Y=Z.)\H6c+_-<_/4;GIagT3]-)(/:N_M&YHBA)9&dP&H\\YHJ.WY.NKIVTaG7Q-K
SAX.Rgb3-S::XCDFT5BD3@:P?FTFa/g#^cNbP)VdT,+:XF+VWe\<^HO_/QINOg27
0_W1ML0c0(<B4_/aZM3QU)B[S3.:?QQEf3:BQ;U:W&(#^A)V1H+dOcDE8CDE^J_1
3Q(NA59BYE)b87U33-QIb[Dd)KQ;XM#TZ9BZR6d_9;VB)XaIa]5e6&>7HK7JT6Cg
3cU7#8I5RLW=XB8WKQK].Y&2;^HYcE,d-DZecfTIQ&J:>O/9f<[XM)MWP=eT>>7B
c-N-+-<ge[,63X^:d[5V(1R)L_^a@>&+C;Me\],]F+0/T)7cOOb[+N/@=dEN\G9Q
XRE&THSe#b47F9(E@088ZT5QOW&Nb29V<7)25V]]C8^O1[@]P5,fC^VcN4Zb628]
PaM[ZC75\UA]bR(2M4C/P7>RP;M]5_=aJ.-2YO7GV1Q0#LYC3W_-D@c-_X[?F1ON
I.Y:/&@O@0Rg@a#@+;:#+BT>;#D2WGRG6H.0[,[-WR=?g;A7S41cZTW[]D]DG<11
>(:#/_-c/-\03.@H6XN9.G1S?>P6SdC&N[a7U)ZQ#]?f<E^DEaa+]4[d9AcaLHdN
aXHe<U6Q1Qg&M3=^PWAa15[KcB4B]d9^BEd)_g)21<Ze>[:+,T;1T1HX-g\L1fg@
JX&;25P@;44?BE;^,3Y71\262(\X+49\KYef-e<-<fEe+cTgf(5GL9118,ZeQ1EF
TR_=(9/SgA^e.g\)T5M2[dEB7=/a68=P[MB@7[fJ+92b#MLgbMP/2dPJ/+;U6]OP
,C8\5]XG[LZ&c]/(<DZC979J9B84H;_URAHOadN_1,/EV0J813+4T48\65DH7ZFV
D4K]NAE/b^SLE3NXd4QD.PZ/9NVA9A6NS<O?+^#U]@UY9=<fX>I\bDBROaQf9d?E
6+4OVc;68?8bA6bF1[4Ca)5LL>D:EA;A[62PB2\BDW;a<U[2[-9AMWLJMe[HE2N#
IRT.9_:P0X()L]<[I32eId:99>^90Y9_;MSK=/,^JM&e)^EG22#3S2_OABBc/0SP
HA/RX<6=].#P,G/#^5BT+Fd#3fY9gAX:ZaM1E_G&8ZE2):ONSPXeG)\eDPJU;RX,
]G.,3/)Cb^&0XQPUCZWMMIZfFMU>^U4b,Q<S;YO>XE6PRg-U57Z3UAPZPLac.-/Q
XLBT1+CY:K=dDcMI+4MbY?13Z;fcP#L1da04PF9]4:4,QML+#2]53@&]DA(<_4Ua
SaaHEDHVQ-8T,OcDg7M8g@)g=@8I];3YTP]QP]/K_L8M)aA@4@+4(=aaH4H;?#5C
AQ)d^FO5J+X]U3=N<N>Q8dCK@S)9BS.\LeKQIec<g=5/Y,YP\QS;7T/D_AT,VGg5
30#)7T.@AZZM9Q[H8W?#XC9ZG=g>VbS.AGL?S:7YN7W=,QJ\WO2]e<Lf=^X,.Z:5
@@_cRV1EW78-;:-N6f/H5ZYA8?S^ee(]9/MG3&RZSFaE2W2f3:efd?N&(<:K7aI?
\13OQUHdS<XICZ@=T2_9+-JD/-Q:YR4Bg>I^^H4d_/D\.6A?3Q@2V[FfLH=@0.A-
O,]:U53:G\XFR^^^ObaGQF/2f3LCeeT@?MUM))]6<PcUQ)6/[0:S(Z=a>,fXdP10
LCI^f]17XU:)XJUEf5QdNT)NOee><=L0gO#M_eZ&I8940fba8@;db3^C-VOW+P<S
^d-cN]dgKP^fO8QKS]VEa@f,eLTJ9b-OAOe0[SgB<:W=SJdF6_5dE5a.#[dW]O+,
a.Tc_EO1a7gV[Y&ef-&4/:5;K6;-O;/L0Q,F:[\;^M?UPIF+>fW1P0VfJVYTR,?X
OXEPWHf:+a7J??9a,0Y3[Q+-KZWOJLWHA#A?c=d6,8C7HPIe&P@4SX.dce80<#=<
D9Sd=NK];V.UNc@D0DfA,OZ<5:?DWH#/^2:HdBS]SKV_TM<S2XFTG>_a5/R+g,9,
^WWdeM2T5eJ?L(=MaV4<J8/GG@efXNf.1dQL;C]N97,]31QfdB4IUcL#TL>UUe[R
GMHbEEVcD()JGg4PW@Z_2/b&=B;=VS+=,1+f5R;[)[G?\,?J&>3)dgDZ?J3B]_[=
gWb_fTDcR,>,c+e\M0<B1R:LR(69W87baIM#d^8e>]3Gf)Ld@)]O(W[JRMfd9A5+
W<PJX4MIdPV>8IEe1DRSI(Cf^N<LaK(#902c0C=#GVXKDTGF5Yb#V^5]WV)f\RXL
d7L8Fg#CL-,a>e60H(NN8;.+<ZP<]L\JF\C17\5#@Q6cN/0(L&c@fHc0.5QY[A&+
c94RE\@DX2T,U^QgPGHa[4#&T:.fY@P=VU]D_^7O<X,a42Z0L#L[O]JH:225Le>K
PYdM3P)^<cEO8@/[=]Mg[BN/RVXIf>-TXD:=N)4[Nf/1I^G7J:UVaX6RK=>Xa,>;
5/K3JWEGHA&DA?Fc;)I2B?JJd,IV:Kb,4-f]S=[X[76Wa?.KBDSOAD,;+CQ=::8#
<P:I9+\fDSCeH5Na#D128T@S009)@<dJQ953?gP:]?,K&B]P:IEYQZM(-=U+,QT<
TG?UIEZQPcX24NFg0+EC=56&Y=fJ/,=OEgQ5/+6?RCX0=Hc]aF1+DW8DT3f78T@O
;1L6HEP4@0Y77DI<Rg/@5,-gI_8#FP6-C/+Da9(V293:6^;,7;Z&__.2ZF2U\DN0
da\Df97B_(/561IYSY/J4dMLXZG]&-+D5^7=@T6Q><,SLgc<7QYc.AW9VV;R/_:(
\<-ZKRWY_2MDYJ=UL_?O7FV&Z-2;SZ]OYBEfJ,U\.QJ7NP<PPP@cU749A9a>1LgD
GH(3@AN\K0E]UR/],:7^E_+Q(aDKF+-Id.T[(.3M3>4+a)Ra>21_-S?bNKZYIS;U
(@4M=/?fV3g7@G_]<GHL8A6RLD4Z;@<O<f1)\Q4<Ee&U44G=@\2UQ_ge83,2X6b=
G6H]DgVbFGW+b@5,I\F7;FQ5U(Q_<&+<7&WFRC9,IK?aPE/M/7&)f)g[fE\a#A>)
TK]SPKLKEP4bLS\00B_P/QVN0&.4Lb>QJZZ7:b&VAKVE1@O]]?;V=&E:+fQXI:?+
N33;(OH7]R_WW((_S@PI]XC^YV#47;\dNScV#7H8LYNeXB]BM>YSaBBWI7Q>NJdB
8598AbBBR4Q_Ld5:27PdX/W6BD90g8,^GD]&H7da[)@TYM@EX6#ZM6g+AIIgg+WM
O:/@FW6?LVG<R)e:#-QJ,AY#E16d\>dIB,#+B/dC=.W8</W0CbLf57-3b7;5]38?
(3Lf[]@0X+)E3.510a^R443_D+D\-QR_?:.B/Tc](^L[TRQNL/.JAT)(Cbf.N)b?
WRRK+g#+#CKYfc\f-2K8X(S:S[84>?[S&Z#H.Ma<_TW,[WC2/JB]a]V)\U@-EA5V
SMD;]2g6?EI@N]TEb@\#Y>afR<>FK[GH-W=MLZWUVZ]^Fb<8ED_/;/cZC/KcAJQ^
IcRYKG<ZOW_CP4)KL;MZUT/af?X(#Z]4\1&N,;&_^1bZT#AHS,)e=MJVUCZf9)W[
I2<(/NYE&5ZVa?5E?1=#,(?2C;[HW2^(N@ACJ)VF7,CGU@=]H=U5#a<C^4MAADCR
BVJaD,9(M2ULT=-#\A-HKc6T5\@ZP?72ZaD2\\.bDc]9Y\HQ:;:]0Q3]DQ?M2Jf7
^M6DZ1.3SQD4(W_,K<HTbeH:6:)a_^:.-,-61>)(ZC.9A4J06@,<_B&HJ5M#B6^W
MMMV)/gbO^N7MUBeHg6:^0943UC35[YIHB^cE,TYAKO:OF&f<>#A/MF+C&J_20O#
=PJ?fD[)HN1;?\G_Of@W^-fT6\]#fPCQ2LH<9bf7OIJ@>cX-S5D#\>@dD@d]&P^[
41:B\06S?+&L>>IYJCTHf:165P<6CG,2(OdO],JJ]J_X\9NaF#35HJ/\W9\ZB63P
@fc?;Bb=:K88^PQXSR]H+/3Ic-Of?VYQ_G^b;RM.6U0HBW3e5>TQ0#2ICJC(XBRE
[Z+/:NT5B,8&cTe88DeHe=MTbG#C0,cAL>Q?V@4ZEZ=#H(&&He,XH/+:9TGJ5f76
Mcg..7OcF\QM;521H\7fNddR-^eC4M]SI)BMd2M<E&,QdQcRNQb]A1]_M^bAgB:R
-76.e9AOSPC2O&25(&@bBT-83^\Cf-LO&bY\L;W^=H,IXF.]I2M8CH#f+3)-)LUg
UX^[<\AeNXU)^/M04eRO-#e&@CC6KR:(61fZA(c0ge/^X8M<VgaT-_:RV/LVA-)T
ZacZ_36?4d;+P;d&a8_.=c37WZgE]5&HMW=FeJ[);8A+3-MeW#,R]8caC1BeNYa3
V,,:O?(B\4AaRe#[IgKE-ZNI+2SEG1Na=1#&(<5Z>_LL[K2:SK]T(6O3Edd?L)A2
)6/XM4g&JOUO1G2S97P079EC2gB>PA6U7RJ8OE2-T@=?^NG//NO&2_WPDP<LM_-,
@,cdgSH<M\NJB&:\T---C_IZ0^/X/9U&].?^7A#LVb5:AJL17L=Q(]/HM(bUD#2-
&Sa_M787M8)aGASFFgCSG4D^SE1JO4(/@)QDB@B:M,X]bWILJIILc5,XVW\(U)D4
#MXHC]C9cUga3f?GPW\)bfV#>f@ccUAO15KFg]BU95N5QS88-ZSHd_016L=T3]V=
f:dO8NNS2KRE<.W<[36YEN+C-cPF]ERdV=Q=T5C\/2(TJB)P/5P+g1fA0-e<>aHB
1#R8#f>OGbe(./U;U9ML4#DHFL+H(g4TUd3/7<A(^BP[AKFD?G9#,2Zce-c&;1D_
/KXa:ODYU=LfV^QH30+A_B#gW&2c3GfF6QKU0\#N1Q33+@7EaIaF>]L.-XFRf_O=
[H=@K/A6#)THU<.]_f?@7K[&E:8f>[1KK_a5#<PIZ=ODX\]GbGTCcI>aH4>XgSKQ
J[NE]_1AR[TB(HMTEcONcD-3899EJEVS:=/_7NCHYJ<-8RJa/UcD[eBBJ>+OZ0V,
9(K2[aSVb_<->K)GL8\X93Y+:3c55RD]f^&N7,G>FG9b_QMG)?O)Zd+cg1He>\Z(
e#24=T3^d?:MLWg]I[Y9]3]D+/1I;e?D7TFR7-B.YcIdYeFM7.6BN42C)7R)WJe0
(8>?C,@O9XTE5KMc,K2]_f;MA:F\ERUb\>@T^-S[DbL2_d<7(B(:XfcCe-QddI)e
Ab(e.)(X>:EeOG7<49YaU8BJ:::6Hgg_..3)cDV-E/<D0LZ/+7>L^>O/0D]K06Zc
TIS>O8/XaWDOL-2[e5_6L[G3T2N9@=f)\K1f8RF=UP_X]F#]41JN<I=58\B:YfM6
EfO[X,]+W+Z=PCQ&D,#=0N#C)XNdfV_A=_#<9-EQ@]95MNKe>[Z1=9,.X>KA:b(Z
6E;J4d39:a2-Zc8K9PVH_^c[3)>+FYB+:\<D_@cUQ_.\4NW_/Q)^/;?#EEX[^F#Z
Rd=H)/O(K/#aG:cC3HJ_D\:S#\+HI+L</_T\GVA7IM[N^0:dS3IIHO&;g&fZ#EXR
@7)T3771D,=-^N6/JGDI^3F0dDWZHIEHad8=aFLd)7c\d0L>D;#E+)LOJCOYZ+&#
MLL[[OdF_=VLHB?@(:M(W6VG]3[b@VK].Ic0(,g#d&\]8GX?fF.NAR8^@f_436TA
fY0C0ebV2,LPGSO7(2^)_OCSA2H-FgQb)#57M-JL__/G90OJDJZW/F]bGS13#V(G
&b/7<@g5<A3F\P:f(-&=D?a@b)M.GP&8S[7+7EPQ5=[f^9=+S,S>K0;659R5/efR
;gS,ef1:Q5P+E/9^.T/D2LBMZ#^@(/WXI(Jcd^N68W)K)Bb/0\g[UQ+@bgAT7=9H
BaDKL7I:37g>MXf;c)]7Y-_TCVcTCU?;;1(]DH0@GWbCJTK&P1b(Sb?.M-/-YW<8
CDb,eDC7PS04ZL:SVR8X)T7F_Y&Z-<J3JWGWEbQ\#1[fZ_K6R\HP3RT;\d0dIAdC
87-ZR,N5V06NWXOU+2Wg)a-MdR]E-?1fJ6X2;/UEI-Gd;1+3OZ[/0YVXZ9FR(BX-
YfdBMILIGOfPfB85/JBBbBNQUgHU6XZZ6RZWg\M?Ee,<=>AL57&NKXdPg5G1K\\:
Q[IUcfNZE-41>7Nc\+6P,9MF+^0G@]cVOMW6&.^cF_6L4<74GfIf^@e+FFbBE\WY
F+HcAFC-:aA51##@]U+NQCb\Q2:B29&#^X8<@A##OZEgCg>KEI/Ff5X\D06X@:=?
QDf7J6^+Q+&P&g]S@;@eC<>+dU7P<9,V8ID7EO5/.70]fcSE0d@Z6J@&g9C[<U<N
3=eO5A[<^eV;C&e:AV5-:W(W)C4A:1[dN)7\B+UX+1V,@ga(>>\S#cL&5<,C1(VD
YY^J[#=4G2+ON9U.(fC+WSMK=H1B&7EF)GXHF5T;\UCF)BI[EU8-Ja.QIb5>a=>5
X-^N.4c9-QWXf)P#GgDO>U>Q1<TdY7[/A\=K[&-^dEc5@N6dU2O<ILTBIR)LKW](
=>__ef>8ZS2(X410P=EFHH1++0bWL78,MfG>U.(86JV:L>X_Z=&fERI/:Y]H^e&G
b5SJ>\AaeOe0X?6S<81BG0#^(bf#J#K-PO2]?9<:ZY+7^TGLL&G4;NC@NcIRV@H]
CLVf5[=b9_=fAK-:dGAS4H_<T4VGDKT5e>;fA[O@MWKO9EfNB1B7F(DaV=@=U8LG
>Bc-=AW^8#/>:Wa4(<2Aee6<540;AMFC2>:FJU_B?2?L\407Y<<J>Q&IE97D_(.5
GU7#cEETN@V^de/RYSI&^[#-beIF)<YBN0@c4.C7F?F(F3(5H<JM/4[U>XdX:Sg.
08/:522Q^NQ0SM>\_f1#\<+PIXeP/6HY4fcb4F,1I21ePE83=RXT&@?QBGVO9MR)
]G=4G2Y0^bL=RS:fYa7?)7a9OX^P46gP)V8-TeOJ,=A@T;,@aaZ_U5\6,?Qd>FXA
.T@JD11/NGad>dT,MXBL80>RQ6DH<_3a#F\W>aZ[^6OIc<R2IF(Z-W)RGcSO,\NO
.I+LeZ9:E+IOZ:LeX2dVJ:UI;87AB,6YB?Z&=J^<<:_4YU(MSFce[I(gS&;=V?5N
gH?@;&W7e7,?Z;1S]:+A@^O1SMc[OX>B-E<9E9;^fMLJWQ:3,_Kf.TJJeXZT1#[S
8-W73_^da0JRPF\,>R8PLA3R+VAgI61])9KCd7TWfeS0fVMaV+;.1^Gdf[,QV<7#
<c&;_)_S\K(#/-;UdV4J@X=OcB&5aQV,YB;\Nb_M[W>eQFU74-NU\cb)dUS78#MO
PKd==;2RRK,;J@f6>2O6]>1?e9,RC8>H5T]R\\6Z[OH]L\E-gWHVKUGM7F8-+O(b
Q^U^gXCC1fF+@.N_5bc@E5]fQP5_Z6=Q6YQ.e3-4A9G?0UY8)EWIVb/8@OSO=6&@
I>H6aaVJcYA:DSHRb&>X<4E=d7S2g_ETc6e??LR=@5Q8)9&-?@b;XMY<BV3fP+0P
W,ET/)KD&9R<.#dWeKAL92>B+I4TTZ_HX^)4#_^?R6QQe888W>c?Lc^5^NZLE7.X
+O155a3feP(LX_@E9AF9B6W.\]QY^_=:>D1>E^f[WZS\MA9W15a\</eLR?;IN2))
R4:/,SEdCF;\</XD5D-(X8JS?c[1U6Aa2+c]QTQ)WL2+?T2D8TYY90-2>@0W\@4<
+Ya<c3@.S\^NVZeK;)aVeM?N;Kg+8HD@4P^5<]/HMDR&R_(HNS#8Te1;;(Q7I.eU
SCN):&cU)#5-??D1LGc8V<(HJ25?]R#VZNNH[Q[L1eYY=5AG\.Ne)[DI\+f#[dR5
[0J<aR7@2Oa52X>Z_)V1K0<K4b;PRd/WSa(U;-V#,aad.YGLae23.QRL4OXD=-c;
V1R\a@U5gR339T/>(SW^Z+<3SP)\,T..?[=E-?ceLdG#P&H)#N9aLR55=-D\/9c_
?b,1DS]<;2F\^aP,>IYZ]JeTa&N8&c@7:FC#bRZMQ=@[1&=>^5.M7f0F59:+S7ag
[edf8GK5QTGfG9ET<8-QJ40dbDXE,17Md06IZ\L?>?>W;6U3MeI(d9e.3;eX]V\g
0V7Ffb&aR-=BaST9PJ8_\0\Y5)7BP7X@&4F+X4:b<3GPU+b/,/7d#FZQPE5bX6FY
Jfb<deRObU?W,9caPHcG&Y7>=6X8B_F:D/X154U.PXXNY_.bbD0&Ya)F=Y1G=(#P
0(54PHQ]Yf(?D/XP/\3(bRVX>NP/55^3:eK0#;\=O^W>WKc=.F499=5b=]<fG13d
\OeNZSE\\gR=,c7bP@2AWCNc2P@3OcSa[#E\SdEfM8f)GH/X3b>#OOCM1bb,2F<#
TQ87F>=?M2MX;gf.==EHJ@;/_45_NB=\Bc;X=HEZd)_UUfYVRAB?LSPN=YXGWc]Q
L6bfRa5-R1NUJ>SU0T86[&J3G:N?2V-O^R[6b&f0YKG3DEW;Y&93PP&MLC44JcN5
/H;K<#_cN<\FZ1MZf3EWH<SNFP4)V8HV[_d=:^P5/>d\6NWWLNbT:>1#SQ;&-?EZ
]8fcD1[+(ETX]fMHReN=GCc.&3.GU;AJ:bZ(=569a@3]Z5>M^KeMb7cX9e&9FZD]
XU]YL2V,9@BK[\ST^TA/f2?U1&RACf3@30_V]Z.2dN2\;4E&STdB]UND6\9;a[AD
=G;c4S#2Z_LQH]2-1;aDFFM+dTKK@BYV\e->[P+EYXEaC52B63^DY6P9R&F+9XUQ
Sa?Ob1U2WHEZbY[(W&Ua5]T8E/[7K(I&-LT+K\Ia]EUJ1<_#aC>.W<ZAX-_QQ>^/
B87+)+J#1=P[6dF9EH:<6NP^WMJ;egV<>fM3fbVdCT(<Ug-EYU=9HO>b?Oa?SS8H
M>CdJ6Pb_(T4,BN:\d)b:?.dWIT:]TVagVCV>f[6a9#XX2Q?OAUg7?K=D;^A8NE&
B,ecU,U@@dC1/?&MA29+aRg#c80GR0:+R3MY10#8#2YHO5>[Lb/R&f2fWFLL=.I?
0K.HCO4dA?>E^W]S8)OB:#eX?gT/,TBB(bDT3]0)ecc;1P=Df6O>5Wf-7>9Jf6OV
>;b?PLYe6/24FMcVM&J=c_=-[+A\Ac3S7Zd>OZB@f^5B]D]Oeg^50?.6OgWXTIUG
e<?FLQH+#.+B].=e,E:LFX#UQ1cgVHBWLD10gWE#T?bRIYY8AWU,QdbUCgf@<T_[
e@.98Y6/H3_#0;U2>]7F;Q0Le=,cRUaRIX(0=GU64H)1RVOUN^+gd.f@9U6&O)4&
K.L9eY.<79aaSZMOd_H(UD9VYGa9K)fH+QMX2IW1P8.R@eC=g;AGFMAZ4M#:)Z3g
/0Z=L2bgHE?JHG\[3KR83c0HX_=KZ-)-J.dM97V-f4_>3&QSM]B8OcL1>KO[,#PJ
0<JRJ8HQeTTR&1(?QG/#/VI\L]TX\E)HWGR1S9MI&)Y?4I>c^JIHS/aF\IQH6WU]
A?e)4(.DXdaTOKUb>9_SE>g+QB8E=B_[U+6cbc4)WCX[c7)5DFS[(dc,.GJ)6MB1
bWLO^LOXW5]POP1NfVU@AVO@PPXA/H/V1Icc#/FebEY7ef<K2A2W)gJ(3=R=OAKT
XA4<Daga8LIe_ZFUJXR7eF:W2CJG,1>_.8^\<.]ObMg7WKZfUXXS->3UWRJ#A5NU
:N]7AHB]SGe-DGFI\+C,e(1EZ(a38#BL7S[:T0.IDYF8)4<;VP4R9N8ZEQAG(P[E
).A]\g^H6VK.aDRQ:94Y\(CSS9R394Z@^KA;+4c-f4(dSY[Q(A8=R7[3_2[645&F
Se>g]g9-GFDN#Wc0JO3M)R2[_,K+]B+TS8G<@JE^;K5#)Q2SQ4K5gWe)fQPZIbM-
J(A3=,1OCUP4XL,fWL@T1:5:P:=_YL,JD[f0JLf7>,F.@P/=f&f9O4U&3e1M,YcN
FUSCXHI+5U)D[0H=V5HC5(6FM9[dH-RHYP3\&]GYH^LJ(S3,+L\V;3Fe1HN&aH3@
X34Na>R)/JQI.K\?@=#FX(V6QAXB1bF9X2L?<C7gc)17FP\23Z^;MFBE\.e:OA15
VH3^:@@JC8bYV1TK&,C@-0gSFV0FX^9K4=6gf5/P>d+Y6V?/@W860:ILX\ZB=aYQ
.XE:QH<E@)VC.@>JRR/eJ(eJ0CG0B(]N<?IFXNcXL>ASP#bXa[Jg<^W9HA6SL,Ye
^.F+GOg:(?I6RVXe]gV(fF3-H<R3HgX?&b](Xg&6>)YSfP_C:DIdV#SGNTfNGL-I
,;#1,5@F,J0UCLZ7SM59Bf]R50047CP2?;:QNJ9D_\C6[ZZdb):5.R)N^e:a=#DF
&>a+.[.2GC(R7b;CIc&;_He,N>g@?DAd?a[9V-<bB-K9Z1.=cV\T^#:_M2/2CeU8
X7U>(D4eZV\K0Z)R->XF=TL9=UG75#;WMc&^=6W1a]\&Mg6UWb4V]SYZSb5)Q[.e
KH\D[/YAcS?7]E0R&]ISEfB.P6PO)X_b<L.91^:U+TY-Z4H40gUT2#O3T?b9,3g#
CTK[R8NI8/dQ8BT#>g-K8GC^N_@df9D6HDK+fAM>Yg7FCBZ425K6IT]&IJ9#8)<(
,++_PL1UXc^OaQGTF6<gL0dA;cB4E2]WUf1[XbE\+2Y3fPP:,ab0F/TT2??PO[_N
XgDLaPf0AXfFSV/D>f2Z27ZZHZab5FOHMMb>:0D]f?0eM3E3[SOO-FP(Td]_^_K^
eSdP+Q6,Yf&_Ag,KO=;W-VT#\OP-DHW(OX732.0GG]bS=6>FB774YPd6>9T@]X=3
5(>YOX;@dN_=^NWFe?YCS(Gf4X.La/NFONRSL#G-(&3M5G,W9>0Hf:N?9a55KY20
7_H7@E9_KWfJ<gLT_gI=DN@O.K-Y6&4f9Y11)(R^+2XBVOJSDDf<S:)1;O(SIVZA
^1KK8\U[U+Z&:K-ZSbV:OW92O0a_0F1c)0.F)MY_I./5bAM2&_O^:V=E(AYC1&(b
?Q)I^gZ:_Q92aD/c8^a7FF-XgV50:MRJRV[VSM-PJ/Xa,eV&[/L;Ce.6U8D(.S14
=67#,Sd[0XL2L)c_<M)L<;LRg96Ne4PX7gWN=#/561_eLfMGQ^>ZB/LOAG7)A-I(
73FE&#IOf[X]D+Q=:c^BM+/&ZWe410d:;49d6HNLe<&0(_KJ1JaZ[42:W?&;@RHA
^9dEOGL\f<.+@=gaVUFU8FJ^L(S^(?\HWa,=NcS-<Z.?4c\U,0/8JA?S<NDSgcC6
ES<HG3][3B7V=YCAL&402)#6-MR[Ra-fD6:V8U,0F<ZW_f,D91]6+2Q\=,I,H6>;
N64YRU09;90@/U(VPe1cB#A^GbC(E=3dHc<L8d_BN\42WZRKdMd/FA&CBYfG9B49
IMbd>:YSD,=OT3C50SN#[2U1.Db:#[Te-9;]L]PfUcb:94?bB5<R1UFS._ec+\+A
<CEM&Z^A,F7a6g,P+eLJ#WfVG5.>2J6W7@]:c8^T+C&eTJR[[650&(V)+IV&W.5T
@D_18)6Q4^&J4I8A>.9;d00W34H1Id>L:Og\>:5,1_Z,+V,5=bEaK81>&D-I^G.7
@Z9+Q(G9.]H&\SB_^OR;M.T#/J:g5I/U8B_d->A:TJZKW:-1<UC)]V_?KP\P-a6d
M>044bg&7\R&<fZIX>ODRY]O[L+<d_]X(,[[(]DP&>(89Cb3@0=R([2;0>Y,0E[\
)Q[Ybbe5#JL5(5]INH)2W60>@PO8[aA7?^E+/Da/EE+S0H,f/(<=eDS&YObf?Y]&
)=6OS&=/J7gg\0OR8_B=B;(ge&Bd4-\V18K5:KV5([:<I#X=>L)I^M9C+.+EC/4f
A?a?P2IR..b]cP6g59cg9#:X#3D>9EM^.fS&d;Ub]PVGE@6@-9DJI1;S0(.AMOGG
RaeVeFU_ED[^MAeK3W\+gA3(=BR]KK.E+LUHK8;d03,Y]K()\\aEMGG6?07<ZA,g
WJ1WLGFNcZ?6JS(Q<^8e4eU<U@4F=BUM\O;?O,^5<MZfBLE60g0&6=g/4]:?IR\V
?f:g.Mg+fbZT:A91LZ9WU[<]X,Y8ZFG03=LDdZ0>LW8GgfD6S(M_G(0EgOFeQVW8
gRF?1,aLK#9^ZB&?9Ec5Ha\M57>_T^[@?W]aeAFTc2;ae,5eX#GQ<PV/SV><DUgM
IC-;3/DR-&ZS.)g^d2]=JP@A3I>CM.]-AK(/RZ65De)9GKQ[&3aJ6>KBF3S=c0.?
\e5R+BMLRd?6AQNI.D=JD@0EaDd0@(^>f^N6]]U07)@0H6\[T8f.E9>NaJE]F\@U
ZF\/VdOT(6[T]B9Od)6(9+3V>@cP:dL-gQAePe.F>0I428]7B&YIeS92O^=ZF]TE
[EDP_E5B-8_a.;BY=_S12DIU/;_:;)U8a;+LU>]&W5U^R0bC4^d#:g3>cN/BJP7&
XK:gO70:^,XNS?,6ZGX5\3J_I3O3@-a&B0DX5DH=G)F4NL15Cbd/M<c9RU:UB]^^
]D>#bIa<(AGW>+2dd0<T\H)K=3+b0:WJBd]0ML^bZ7dGf(Ie9+5ULZ4R.F7UY#51
2)RJ[gI5,^CGGT@Z:G=)D[XL^?P&:&@K7b5?<-.27V13?(DQT#SG)U:NA;+e;[5=
VN?YS\G0K1HJ95Oc,bAg.f[I4]FG/(K5];KgT4KcCQCC@V09NI&^FUbg[e,D@1(+
+#KIE5_0(FZ2:AZAa-0LHTgId;=.7^#,@Cf92.Z10]J1A[eK.DbEJeWe0;1RJ865
YMQ>dK[aZ9PW7AG8<(B=\LIc,T9#^e9H/4Ee:VS3NCALX4KaA^4(N=_R//&UFPL^
b]5\ZfCT;NSJS+@28Oc&XLTO5/W@[aa-64K0V,VYa\F_8e6gE9Neg[G>IQW^0JVI
LP?MQc3HCUU2MG\BS>[MgJ?XM^9.M+UT4_P4aF^SUd8B-621Gc4b3PI2:D<>^917
7Y:K^B.1>LQcbJ)Ae8>&1P#PVS,=5LJf]Vg\e7>Ica:.#3g5d&<J@=O3E)S-M(Eg
]Re94bLP7/,6JP#T?gF)95JE.DXYL0?_71B\d>/bVeWPB=3,bEcIIGUf<YRbf5gf
).0?4P9b[_U#_B11HeM-D&(^7HRWfP=BXH&&W9(:aPI0DQ>[H1HS#ZcH=<=fH)[L
S-KA,;-=FP1.cbU=1ENLe.b&(H;3R:PZ-?dgNX>9).(\/,gFD\LfXaJF0aKS;3IT
eMXZY0Z=6:RD3@P-5/]P&2fUa<I[EN2M?D8PbX1g\2(6E<IRX[:L=1[HVHOfJY>#
C#(\7;).#>fJTP>cf@\@@9(:J@7U1gW=:<RQ4f]1>T7\(e=M@A5R)[aNRUMgIgK^
/?cADQ_JZ(?#K#5NX7>V305P_8EW^(QEZbF_7a@PK7\V/;C(_ICL+#.dE&2>ecO:
+7=BfC?LH\C0b;(&b)ZFcQWYB7)d:_83X&><\ca0F9<Q2,5U2TC4)5+)5(c[4AgD
Igc?TVOU5H6eTSU+Y\bL&\MBF=H2<:.^<+6CZ9409bIg,;K]Z;&U&T=N2NN6;YCd
NJ[771=Z\L?2X(@+]D]9=RC1VY_AQ6c&RS_UBFYcLcKG<,<O9GK>c=?YQVJ_7]<J
TT[[D=YGV4&Y?MRE&C[>.:,^87XDEad81L8,EV9W&ZR2\7T+>]9CRcC1D.[0I-:/
69>3aXB5H=2V-&^fRPV@S5M6PNc8FSN5JK]EW<JcQ:V?W\JULE4CcPHMX?1]HQ#>
[VI<b@PO4CgW=>Ta>W/ZESWM>FD#cO(&Bae4BMa7CTV8]dF8.[[01TED]<MeLa@L
V3_,\^a\BW20VXE/<cb30=-5,]2N6P:?&F^ZGW;W+/.SHWMA(c(gb1:;P>Wb,5f\
.;a-D[OCDeG>R>cN:e2H63Of7HVPVc3GJ-\@cY465[8LVaG-MU^ATQM&#IX([_F/
ESA4g/RTPM444VNS>)T;+XE-(d#VH\YV5<e9--SA/c@S?+_e9A3)Z((G&H)9P;c)
_+Y4MS0_NCcM(Fb,+38&A_BTL(3[XLf:[-28X\gf(HV)Y/Y@C;UA_Q+([R0@01A5
[fALK7d0B_T&@J_E4B#(AbBT8$
`endprotected
  


  // -----------------------------------------------------------------------------

endclass : svt_apb_master_xml_writer

// =============================================================================
/**
 * The svt_apb_master_monitor_xml_writer_callback class is extended from the
 * #svt_apb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_apb_master_xml_writer class).
 */

class svt_apb_master_monitor_xml_writer_callback extends svt_apb_master_monitor_callback;

  svt_apb_master_xml_writer pa_writer;
  svt_apb_master_xml_transaction_timing transaction_timing;
  string name;

  // -----------------------------------------------------------------------------

`protected
?4[N\^L2V#dY[JQBUN@#WG:25^X5(3J+:+]5KQ)=&PU>H<0#b[_a&)d-7<IDV4gV
/44<D[YSWE:_?MOG(F//.7^>DgTTTE]T64Y4GIT6>H;dOQM+-gDEccD]1<bHI;>=
GL<P.4NK=VZ-9O8M^;&]-,@Be>[EK9^Cf_Y:M4X/FT^MW(TM&^6BCRJaQ=+3WX^\
-gW9NMQAID[;&@5IXACD<SfeP-3X)J]]Y=H7R).+(T&,/5A^Q0GG2^c8/+]c(IU;
961[-ABDY=JO>BE3Q2gZ1R&)6<[4K(<VHXZG.0^d52<XD/FSQHAM<CMYL,;e^Z^2
f>E9M3[BY,_8R+b72,:?AU&)3$
`endprotected
  

  // -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
fB2eT2QZ;&I[IZS\7/:L9/b>NK&V?gcQ1,62AGB2P55>Y4M-/XM3/(PR^9We)^^^
S+JIf6VCW;)/#.[VFO2J/08c[M8g;aC/3S-LZL=)=N)Z3Db:M^aRDJ=[;_K9#C(c
N3&6ADc7FTW24Ua.;M1PB;OTATd-B>^X<S<G(T[8d#S<QZ)b\Y971fL+_#BVPVL1
8X<+/\Tf?f0UJC=_CFd2T/J9&)_:gDX\8MP5de,U<6gZMP_=-43L._1.ZF4VQV&&
)P&C79(N#>a)#cR>I[b_O3R]\#1?Qc8=c<RED_ec+\B\a[BXN)g(,15#8B/BG@VW
V=g#G.Q]]>G[:_Hd_F<GQ7^,TXDI=SW;4ae2>g/OWRZE..6TdOC];62_8H(=+IT2
1TSXd5#EPV?>c>@>.a0F/D);fQM+3g)a><Tf],J-=I]G[;_XDB,=SHZ9RMf8)V,I
LMb[ac[U_:4J1@O8IPK/ZG>PU_VCAf7H(Y3G?Y6OGUf)+>VI-1@U]eeB7g8FN^24
E[S25WccFR\J/0K7cI9JTNcNDLA;.A@\(70fB1>fe8Qeb5YbF<eH._<^d6FE&P@+
K&EO44YgO9+gFde^L5F:M_Y#D5+KU22A8L;=N(BQH/@=+a2W#]K<36/S2U,LOPJF
&5[52,DcQC_gg1AKEDGA6?<VTb1:;dD#(<a.f-=H(N[N56J1]JMZWP0C@&<_6M_M
^WTJ5I^.Q]@[X/:SW#1<U<UX.[0(W0;0[R]bX5E9G)e5_B5SXD8_;]NCb@98#12[
W60GGMB+BJX&32_d&.=-L_faW<H(&@00NUT3TH#L8&dT)f#8<:^Ee3J1M:bDDDU>
&&b13L_GM4#PGN_MWfA0V8b)GWd\-&TE,==9cTR6BX?fC^[Q2_:#E2\_>R1L80c+
O_<V<T,-1SYP*$
`endprotected

endclass : svt_apb_master_monitor_xml_writer_callback

// =============================================================================

`endif // GUARD_SVT_APB_MASTER_MONITOR_XML_WRITER_CALLBACK_UVM_SV
