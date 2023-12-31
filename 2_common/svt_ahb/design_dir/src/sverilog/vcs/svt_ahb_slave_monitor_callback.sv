
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_CALLBACK_UVM_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_CALLBACK_UVM_SV

/**
 *  Slave monitor callback class contains the callback methods called by the
 *  slave monitor component.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_ahb_slave_monitor_callback extends svt_xactor_callbacks;
`else
class svt_ahb_slave_monitor_callback extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_ahb_slave_monitor_callback");
`endif

  //----------------------------------------------------------------------------
//vcs_vip_protect
`protected
;M5^8>>706Y-?CNUS75>N#P&c7-&cGUY,9/eg726[F^gBX8aIT=E0(]]UZ,&T1cQ
BQ#I8.C>-K@>4IcXedeF(^:Y#3633K38[T:D8MFX5g#^;:LWPT[#-G0_<.3)(,;Z
c<;/70IgG(aYXdKIXYGK=MUR(T[Q/be2CWL[9d>I[88W)@NG:Teb(I[Q?-ZT+B3:
:.\[/3f<V9)V)FgPfG9DcC,D3SM\Y6B_0OQ^Yd_ZdKHd66UDg207O0VC8Ze5J03#
aN/;,>47)BNF=/FHK?B)U1bMX#dHIQb^G<57NM)_V.<0J]7gJ_<R@4DTTbGSgP\&
[?Zc+TRKCV]P@R7_#^2M84EUUEO@Qg;:>=>+_T<N<B5Ufdd5EB/5AVK8a&QCg:85
;@TP#S=4F(]5)ZS]L,SHae#2<BS+5D0&cTAQOGNU)R<[/&T8d=XTeDGD?.LZVW>f
U5bJZ2<0U6,_;H2O-7C-K>_J>M[-IT>T&ECNN_L[1=5<)VaeFGc=MQb4Sa7QH4_S
H#WP+F+A1/J0(MRQW8O,YB9(ET]JZR/EA<@4aV^fYJ(7CWcW#5EdCGD].HKfWU83
G#?FJVT#<BIL_8+T]D@_Q=?ad,Db#2ICG^g&+=7\(XA7B/.J>(?U(+-KN2/PL+1<
#U3VCO3T3c6Gc66AJ9;+9#UE@4TO898V#W=21G1<Sd#JB5[U+(4]M2-6Y>DYNSCf
V6;&g^;>PPDSCOe<<:DcNdT;]Z0]<6bA02@>?Q>:FfRa3:;d=M+SZDLI@YZ4B3X/
:e?-)f8SQg2K<Ld,<g02b(LJZ0#61CK)P,?ZbW#e[SaTB23BHL,_>>^9K)W8CO-L
Q/#&<gEFgD/CWX6),9L/Q1@A)9>=DNf,#6EY(+_AMGaTW/AX#BA>d_F9L&\ZZEg2
)W;bdW>aV/N><,gbV:5D<VW83.V8_IVVT-@0;0^_0BX,b=DY\K>1D=LK).HQ]68V
EI0?H=Cc,[2:07G.1NZETI84b.E.PgDBH4_,gBCYdDR..Tb/R#=0Fc&I4E4_F?:I
7[Ma/;]^)Z7Fg(AWBZc?G/P#6-4dPX1>+#&.KfOPV9+G^TIe4Kgb5S^:1c2D0/CY
)8#Ag5eOfR7a?.aG^NT4.M#X6[2?N7Q4EBU),g9g0ZCV0B\Q^gY)DV4gaf\REJOg
[9C06Vf8]Z79AWbC64+>S-d5G/N0^JW;DZ[/_5C[SfZ+4e+<=fLLdN^aS>=(;=eX
C]@&VbC#PSF;FgF-B@A8ae8LP3.854H.c]>5O=N+Y1G/K+MZJT+.?E>DOP[H2aL-
0UNKAYUUJ#58]I]OW)+R#F#\9.KTc6JKeN@FE?<RG&G_fVbG^@Qc\QT^YG,.a+EL
O4@U254>.:AWf./XeNEI^BaePL[ZQ#3_LGF]FLY(0)Nd0e@N)e&2MAZgTU1#fMQ1
;7YG8c+>+)RR<E9J/[bCe?>GO.QM18W<gf7Hcf8P0Z/Bg[,eV/=MLUca=)2\N,&Z
051]B0V+_6/@:@I0QgH4&\7,gW21K4)P1^9ZU\Ydc]DILeW9XNB<]a:L5\:??\N\
Y>d3a)LQQd.\3]cD=[:;H\T2VKI61^M166O_a?K<_/?K_@&\RaeG/SH].])\RT<&
<S2?WZf.F:?I(a0IKK9@:_b0U7ZA1JFD6(>f8?O=4O_M6^X3dIT^aF-c4ffVL)ON
e=72AK3bYMEgK+cUV=#]?aS(&(W/CC(^gS2JS]4;g:GBV&+?Be]]X)KFR<6>XP0?
[LH,PfI;A)3>LIgTFg\XX(Sd_46OeSc^FT62]2(,QGY?Q80>UXX:YIK<3L@J2+24
?9,[eDC5+06Cc0.OE02N/HR)1eVR]Kc?cQQV9f4E1TOX^)cN-<.DS@g5DVH9YP\V
@-X(YG4]5.bZ(?I@,@@:_]N-=UWg,:^?d0@)XH5NfZHEMKLG#OD^?Y6R11>C/];3
HFQ)AW>?,bQW5,\=83]>\ULOAP;Mc..8d\d;7f>S]#5MYT8=[FTeONA[(HF4_>:d
H,#7&eA,0-)/R<VI+<C3H_H\#BF<c,B_D>/3D_,39Z)K?0&XAD@e_;&TPV..1350
\?OF:AOed60>B6<(_b7=><GTY7eCCfDa2A2>Q59759cL<3OI488ZM94R#>VAK0g^
;Zd9Z?SJY;(]T,Y<BS#EYBdO]XS;>5^\[;]@UHP?A2YN:.fF,ZeIWB3LSB;;;1O;
\;FK=BB(P>e^@]Oa,3MgbV=\UT==5&&OCGeV+9^[WE.4TR6CfPOc-RgX@G>PH&-=
=1&I^C@=a?74#d8)^<U:Y]AJJKTPQU[]8(;@MUGF&[((63Jd=UeMS^<OfSEYX9G8
dSEAgZ7_T@8-aRK\V85\OME91<WM&>W8NU/ZQO_G\-&?FN1>65O8?P)cf<N8MR4D
aeU@F7IMS:bg+7UH9UYYY=cDI\.#aCe8GXaF6dAKK836g^^Z8G3TbWPJd&_:./+6
84g(a<<-b?J_\&Yg57J@5D\Z9&0]0@ag1J0Ba<0ZYU.64-Ze<g5J9gUK_@40CD6E
>c>Y))[;g(R^e5#:IBRK;UB;e>H27RFMM.(4ZC.O+^,U\YDF\[L(G\aXWQI]06FS
8d3<YB:c(\[d,IWbe.P\6TYeHd7Rb:0TFfYDO5WIWHAbSYC2L/d?M_a6e4Pg3:15
^Jgb(eRJ],#IPJLKRWAM<Jb>1Pdad3aG\gDaT6WA=4@Q)WHH74?6+70Ne]YdKeZ/
CeHRS1#?227-Def2>;19Y&H#07<bT-MW4)7414c[EAR45W@>@H/g@;F\:Zg[P>?G
T5K]>]86J^/9;YGN:BR._YBOAT6S:e5N9>]B](_O]Y7DJ;fC+9/a>5NK..^QSA-U
1ZXXc)6)(20fDaf6&aA>B/7C>X:HK]OM<13H35>M(SM-Q\9G:YCZ(IP]5Y<+aHUS
?.55&?ea+b6A_W#(8\I\VKgZ[DP[)&2=c9<b&,SFSfRSM=MgE#YR.b\Y4J^?@Y_S
fJ?B:gW\(?KU<VeF77+He6BX8+XF<N8\3NS\DcB6QINAH_=+E@K<[GN46]?,OMa^
F15DbcM0H6@e,WXFX?(Pca>^C:OaF01C9EF-KH;d(0J^::_6MXc6:RYPF@[_TEgP
A8OgD3240E=EX3C94->c,-(^+aH7.A5XIRPOP77IQN609HW\0U&Ag]WY3T=>DAO9
-J/AD:,Je+2IT.8B\-Ub303Y85,\:/+Z_3Bc60?889A[WM+4Gc^QO?4F4R>M0-UB
F\B^TE?Qg:)JTD3P?.L2E:(@NbCD(KNN_aJ]15SZ)f3-,RLLW<=34>-5[YZc:62,
87MM3A4X6U9Fg2N;cO&-=V/RVK5RO\>?(,G9JfA8S5FGJ8N/CecB_)(8Z.J34RT]
aaDZ5&.@V1.Ua1EJ0>U.eOPMRP.,]>D4a9;OD_#;+^_B7J4:@=4W?[M(/2)U0YK0
HTQM#;gW#\AP5HbZ,c9fd)C+XP868;.5-<eY[fXH5K[E@27&ZM&.&SIdU;34DU)4
WUSD=[?OYd2e5V9-C3+GFTMEc9g-J>#R6@E]\?g(722APDBPQYX+7=]7<OSG;@YN
ZS2Y9CN;e7-@,\\1JA^NgT2/P&UR&I2(QbH4f2AX(FN<&NQG&@f9I0+=08I+_-ES
.c+]HF1=SY,<FNX5/KfG,J23gXWf&/J63H@-g=+\[-Q5>.OJ^+Md25fb8F4RX-,/
WJ]\-8F>K?#<[]5FNUK^eP#+#0b:Ff3#-@STd\Ae,b1<):OSEb-NR(>TfU;Q<AJB
c#:J_COD(.Y/<fOc\::7]F(^=:F.\1b<\H6&(@T\6-bXW92_=O?:IWL_PZ^9H]<C
fV1ZVO;@4<&CVFKV6T3#&]H_P]c[&N42&a=7;@(H](fBd)#W;((I1EES(M[,L(>O
S7TJPXCS+W,.-L@F;Z&A?OQHLR3435agBJ:NY<<-4NK.8I+2L\aXW(6O+7a.L/UV
9QWfDR@3:dM6FUZ,bJJO/2Sf^H#T2WV/@WL^DBF,/aJO?Gb2U1S7;O[84g<NJXS2
)T.F-O+L_9dF:[6;Q#X>F6Y0eeP:#4^[Y37bHV[9[/LETd08H8+W(]]e:cW^WYa7
WODWXeLLGF5Qb5T=&=c#H(:20(4=,=:6=-R?W68DWObF?(0EAc3M]5DC[a5,;<2[
D@I_]Wg.>KON?6M]9LOATGC36+_,gI(73g3a9_AQH^HQ\V9Ee/5S?Y,8[V3?VTJR
62_f2TebIK1FcU3RXG2<U4Td-7eG1F_)?c0cdF==<MDWa+ZW0H_E6WQ[)eF1W9]8
9N?cd]TIb0R>SID#S.VNAe+G2GAK:FTC5#OWWU5BJ(Q[2YeaC#JDFQKQga5\-([<
RXQ&ec3I\Ag2P6&6.<#dX_H.:#PLI+UeQbIO7gbd(JB0\Ug,E5/F@96eTMf]8@S=
BWO;gK0]7G7g5G-FcZK4:I^XGT8XYD\JQ1d5VQX9O?VAdH8=.#0E=,f@I5fYXD.]
Y^cZ>^-G@aD0(2A4FgF(S_3A#W.)2/.K?07>DF,a6:4Bc_X2AE+F^I@--7ZP(b5,
3g(/TW+6EfO7.bX#3c5E3K8<@Zf][B&dN:\;Dg9eGGN,AY2UDcY)E0Y<_)):^c(<
4cUB0D@)[,&<gcaCeR6HU-7PYGgEc-9C&7TN)(+X]90TY-Y(b2(]QO\/S6#)M0-D
;Z&c4_7?KAMF4,;9a-gOVKA-X2Kf85PCUPASeZ8H#M@WR/8&P1AG+b#4_>?J)[gS
.EUF5GPO,)_/+,.23NK&Ld2]XQY81B;af[36>XO0MGNP(,>aSFR0Z3Y_DfTVPT3I
fO7,J+J57F3X6)?H0NPBV=Gb_I<<1B3DM)R^.HYcETZOM2GO9<<&deDB&3K9/(e8
[[G\Qg-eB#VF85XI[PC]WQIefdL=09Y-@fBOK^.JI7D2F4J\EBN1CVC/;>,&8Ve^
O_XK6DIA_FAT\6ad]7g@#:[,-N&3U)XTRI(ND9g\,Q8&>.#8RQ,2&W;U5(d][aHY
H1d@:,;YFB055U)P^YfLHI2bU+??N07MI5MN2^WT?+6B8+1^3X(:U<5:J,gOKZN[
cV5NLg_R_(OVaUUY&,;O8G=))f:?1\D+IM/K)WMJYC)3JbD)L:=S#^+[f29,+Xg.
g()@.5S4b;]B#@JXcL8?1L5=6,>WUI&(J)T9d;6cX@CPe=19(Ha#Z>^#K>cISJbJ
LR]3&Y4:.@&^I^#5G;7:V0J0b@8Y7A^7QgQ<39L7IaKT,^7bKdY-\XZc<K16,:=L
3?VWdP_+:V5XWZ--</96C2X4?IM=.M4S,N?@3eb7aVYa]4Rf28X>\cIO)-a,aLB&
\aY\9G1LM.eXNNP0R1G\fZXa&CUdE[aTVTPZWH=YF,U:HKNbNGCD5g?I6)gc(>\S
7M>f(ab/&C.ZNb6Y(9/b_aa-GR\Pb#/3^N2McJX(QPCcFTW2>BDC0/,^T7#gRI5=
\[;\eN)]RQMe(XNfD2GTF<c9Ege&S^d;;IB-N\\KX+LgF/b>V]CQP4W>SCOJ6+7G
b@dT,<JTd[UT4-CYgc(92;0)3g2-\@\Y4TBd7A@/W[?McV0]c4AUUWLZ)^V?_H(7
;F6P0EeDf5[#0R6#LD0)W>;I.8_d>&?/&5/Q6AVF.cGRL_Z0[@C1Y.P\CaP>Cae2
0[3CBBYMDgP8L^ObLITNI2EYf>7;QW_+FY22QL\ca5?0G5^AIO#?61Ra+A9fLDb]
3ZS5/M3D\^>9=Q[P1Ce<Yce#SX&^>/<V:CNdV(EQ^<HgeV9M+5.M=F@&OT:1g7bQ
P^X=)(3UP.MYC4A](&S@f+.?RPfO:K2(YfXG3U6I_CeS(5EI+a_AVQ]YLF#7JT<N
Hd0Ica@Df_6XI/<&CJR:5JZ#KSZ@QL<e;5&(@9.+53,@HR<8/79R_cEUHZHC&?^0
0J@S6T(KgPG:<IGf2^B];Q,6A51VE9H_cV/YIO:g1-\W#5JMQc)Q4TS.8V\8#:+H
)5[.cFMfgR[H+JJ<W/&FVW>.HZ,,daQd,R\G,2;04=_NH0gA(H\_LM]60&LAHZ<R
c.QZ\7H#IDE(KRA=bS<=NVSAT=T8(JZM,HDDL-<YfKA2DR1M0SKN^PB)TP_D@2X[
\7.d3\5[AeT^K:&V7=S9ET8^.b[d+YdI?X]^.,2A8CWEGHLD=/]3&79?Q(I6@dOC
BXN#-7XKcLFX3:W^S:L_gaPMcW8cM8NaL5=L?\.2]<R9_N3:06&)TU@I0G1Rg-#g
-He7ZFL^b/^4,LF@AD^PI4BG@7.BZcaK^J)4OJdMI-+BH+FKaRGS,aKK.#NYY\T5
H0U9P;S(6L07BFM=WX^d,E+X&-C9bEP8#[>&4SZBSN9]<H6\B\BT9I@I^1#.(PRg
]g1K2aQ5A2Ud&f\Y2&A=O.\\_WBTV@[^(GGHRaTT2J5&^X9=BPb6egAGOeDRfCFg
^^5Fcd]4QWQb@\,]e\Z0[+Eb4,D#^-PLN/c6&2U7[6_8d;P7-9M9W9UPd@W4_168
8C((1ZM@B0<JOf,;6M@^VVbG@._ZgJ>;;RW;fE-#T(/1R7;R.H/+>.:+/>]b=/g1
+cG;UG3,N9]Z0b-Q&<A.B3-<L:(_Pe3J[]&T5#Ca3gd:WDc&=Wd/(R-(<)d;dcA=
=:8=aN#dK_40A63<;X2A<@.AcGccLYfgfY^@FE_C-[X;=TP&_1SF=C-7P8fW:1_,
YIKc1-Med<;40>FOf^&^<6<\e<PBE@]B.843b.F5MRV<V>g@KUY@?C1M]8@#_W6K
2e+42Rfab[,M4_,cc+I]MBM7;+-eUd8>M&AG2],FT,H8LT]DOXRY7=]^.gP-1V)7
QBc6BL&ZVOO([GSa]SPWb2)0?:YA5&g05E<YgP@K56D@.XNIf@X:7VNB-1^+b>-W
]FH>KGeW.Q/&ZUa23U/Na?[-+d8VDX89JM#TDBW2NNIeF5KN[^B]>\..^8T,0FcQ
V52^@E1_]F-gX#dMJMDK:ZUNK3H<6OS\(R)=-@eaINb56J9>I\H<dVc/RHMJ61[F
/A3@\;6I)5EP)8Ve4Ja/,,;H^3+JJ?H<7AT9=]3,M-,QTFCW@G.MYP)[e]MT(/cP
S2c/E3IEPQ/T0C49>]KILX7YaGRgP=HGVA6+PO>@/&@9ga+=7?JED4F6H,>&\fY;
^KV+>25ff++M\A=d5VR\-Of<\>DXAQ5#S1/FF,/8W+YeC;:+E>\&)#A5^8_AK^_f
18/eKCU>BQ.M)JP-EED&.T)0NQUC/bB<)C.\cZScJ4=ZQ][IG8&]Q2_:cU3=D:U(
f.Z_V;ROCLZ1,3[8dBR,4\dF+^@(-.XULW2\BV:BR(]+9/(C,/JNb;MaNeT]/9@3
dFK(F&YLGDAT(J?ECQE:Bf@&53&69-^fIKG2XD85X.5f1\>A#3IN&e8IN0&X+??C
+RQ]D++dAe5/^B0SC[Q/L=58+e22,W]6:X@Ob<_3P=D\G(-E(&2R3TC)-.EWE5Ve
dbAS^RR^IV+SYV_S0;@]&?OcPM=Jg2EdOAZge7.X51cPcT[[@b[+W6)P&=^]7<Bd
39DXP9MLf^NOfA-2b=8Df,=_GF.5;XP>ccAIbCP;,&W#6V&W_1N.R#7g_^DKW/+(
-[_)#7S6^VF1@M(W>-2WPU6@,FBW4@LDRFM\Wg9bV/CKUbH5<P^NbPKfBA./IA_F
FdaN2b;]J+#],0?.N1;RLO7S]=F(b6b+CCadXTPaZ_QK^(M_gK>MCQ2#L/Q0(GA2
I9Q>WP/4:-X9cJ.^),_>0&40C<K^/;RP^]R-7(N_Y2G@&6:gH[A-RCI_N\-)-;If
D1bS9Z7e.aQG[28F4,9[b)A]^OD=IdY/+d_GJ.^846X2B0ZY;4P8OHbN^OJU>\.M
V2<IQ\K86J=YNaXZdM.0[:.Re1__>H>_1<HEL=PTE=-I0J#\Q@UCC-4P/[d^WCVA
14fU#6]UOC)be>_,=#2?fUSZ?29gSG5S\[AUD;a:#=@EgaVdf-6^4;OW#[1\S\g0
D7+=M+_PTM7;c;:f0&J/W52AHK=bd\W@-KDd_HYdU<,S4[,A@7IQ,dJ]bd/cHHbf
5\^Ea5AV3)=BR(_2/fORIBg>efZ764OCIW@GFJcM/>bHDTTW7I56+LS&-NKX5-O_
(AMI(N#GS_P<SRTe#49@d3d>BfU_bL2.JeO]:N#K,HH_=,,VO@dD3_(;#5aMg/^O
;QV0IUE1388;?<U.E2>&/c:COd+2=@-0NR\99-4TYH8#Y@QOXH&&WCFZ<)JUYLV.
-5HXdWR\UO&3LA(f-,VcCZ,GG1I>Se5NO&L38<BU(cD1UKO\RB_cF907N;W[D/92
DPA;<(a?[Q/-<QTe=NRFZCgYBK^[;8,]UVAL_fd<QeU&E_R[]LU2,J_E]H8WZV1.
):7Q8HTQ[E/T>@6V+7M.07:.KI;@2);19Y/RbK+Q\g5;,U@dOT#AAJWMaM9&.f77
8:)XQ3N;G_+O(d)H_<74;8,221@fVe[M.HLQ:&Ug^)2c&T_8>GL^fAZeUO;D\L(+
FGFK6RN<d84&R@1MJP\Y38R@J4;7b/RaaJ_,dB)U1G&Y<S_c8/NVEX=NS3Z\1:4V
2-)^OIfSB0DODK1G_da2Jc#]X&&GX1B4\I0FY_;KYA&-B<c51MAPTKPMJBP/NJ,-
UQ&E2=C<_EG>QAU_;eF.#L64cggLV9W)g;7:OWd^Z]gafE)K9D<3W-gXOVMONV^X
8=U#-85P\L76V/=]1^/E.V03c4#.3NMVVBM>4,Y,gDACGc6Y>:RCJG.WDYbG^Jd=
ZJ6WQ\RE^RU241@0#.>84#OU]C^63NTDNFXI?,bQ,29e8Qb7b><3(LO:AR8KNg64
-YZUPEFa/#4;<Mc=FX],DKG>3XL)CNS8g_dSaLFNUe:])XAX^2LbCH6XVS,2WLWV
,PPXd#VMZQN]HH0>;3=?b8)I<(ZeP=&E:&#7RX^59>MP3]f?\P)&1<1R0ZLJ[d-8
TWHecFO:A\?^IP5.T[I;]F2[/,T^NH)PA2-QMLP_<]D#+]2\Q^3UVB1Z0-KVdK[Y
2?SHX5&^4UdETg[SR_=e2.3;>TDeC2)Cg?C+@cI]@)6&)Pf/CGY4@2DJP6X:70AL
INgNLbcd1fZ]GTVC:[d_.g[,M@_&I9EX[DBT6bC5)a.K:P/2QPO48BfT7=EJ>HN,
_;97VS7X6^V:gbNb)RM]WW@M,SB]SF.[I1(He.^JTZEQH?X4gXAfM4F<5IE>e[.K
=P#&]U-4fUNF^6=DAN&(g.5-M/EIV.V32QXK?\Z48.M8#\#F#,D[EUYR2#ZU^/Db
/e[EA<d<<IdR2A\)BG^>V(g(JB:&.IC3WZ\?e-F-:AOb+b_e0)63D_(3f(X[TaV/
ELG-^_WQTK14F=0-ROTYYTY=g3@8L(ef8WZf=4#S;B/Pf(9aFGW23US=_EAeI[_=
#8C\LQTFFPfHF[:GC7@]?aAO<I7I1Ze1ddEDRe5#XCF?K^XT:a3D[.(->RbUWeC4
F3MGNRRM\A4K)T#<6I5eZ0RW,5J[(RZ7[01cQ>2VSN->]WCB)M,/EI>2DPDcaOfB
;]b[CVX]CAgGKU8@G^IF&1MH]JD]87-dY>9>#c0QL/e]07ES3[B2A.@UUaOP+#(/
da861TV\#Q-8e]LPK5=eJ&0<VdU+0(WP\:13(7D+bISLY0EYF:@/#VVa&X^&VK(E
J]9AM1C8)e0V=K2cb57IP1T3COe;0.a,#d4B->OEJ2PY+a]W=G5I]&X3&7X_>f7S
Y9.1fNUL>V7J#g.ZZb9;]2Ca.GII8;,\d]VQ2Z;3+GXKNC=+Z71,<:6(c584P83P
;Sa?9PC2.a?6T9EP+XA?GgaP:A)I<_(P8&YO/d;ETYW\)/Z>bS@)G+d&2@PKM,&A
<D-65gf]F,9)Ma)+F,e6+;G]&)Y+(8Y-8ZQWI9DPL4Z=_Z_H6Ka_Q9Ee_BL@e-=(
SZW_IF7]I=c@^5.g7OcaO>B4&IP]KZE3B>>SN(g(N[eCI:_6P((UGEZbGgMDIFF3
-F3)YZO/2<]H.WK9L(;KbgR/?S)NH<7(OB+F3P_Y=[1b@d@,dfcMF4BRXJ-=Q(\+
<5U>2=U-PX=:MP;6.-DRPWL_D>ZbNH[<c)MM9JE[U^XY>)c\7MK>4dGRFU]<R+6\
Fg/SaJT-aQRc&a]Fd44+BcDb_DBFNeEXQ<0/e_@bJ:]JV_b(Gc4fKCDGWaDg8Q1Y
2&4[7UDN\9DD7O):aefMHe0@&98?a3_90(@7=>T3H>FK]UaKA/5_R0:5Q)+SMZL0
,1FH(W,M3#QOa]0EW\;P)QeH4Z:U_JER?$
`endprotected

endclass

`protected
1+T/Yc3J>#SI9b2T<0P+G^1R1X2._f7b([&gX[2b3EL_LNDS]Q&P+)?ZUYEC.\<K
(ZcT10gc^Ra8:,+K@/NZ-eHWLc_I+@DW:0aP2()#(&M,PJ=_OYcFDINR9<Jfg1PF
?eVX4].+H.UDW@/a1/.X@6BKAUH\I2(,-O4?bd2_c5GV#^X<_,dXE528?]P8-8G[
\KP8f&,RWL#g0/[7/5\TAJ;bg]HF0B^(b3B=3A1E_4DFI_b9@[,V8f&FZGN_],?D
]I[]D5KW]5A_G5.@C[4?46U4HLMCdW^a.3;54^-^W?K17)W-\U+G_2(+C=_6d8^W
^4@)23:CM,5]GS9KTF?H[KfJ@Ca_##)3R,NA/P\\:(GHV)=T0Q[6K)0b8_KB:?TIU$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_CALLBACK_UVM_SV
