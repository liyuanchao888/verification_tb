
`ifndef GUARD_SVT_AHB_MASTER_TRANSACTION_SV
`define GUARD_SVT_AHB_MASTER_TRANSACTION_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_data_util.svi"
`endif

/**
 *  The master transaction class extends from the AHB transaction base class
 *  svt_ahb_transaction. The master transaction class contains the constraints
 *  for master specific members in the base transaction class.  At the end of
 *  each transaction, the master VIP component provides object of type
 *  svt_ahb_master_transaction from its analysis port and callbacks in active as
 *  well as in passive mode.
 */
class svt_ahb_master_transaction extends svt_ahb_transaction ;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Reference to master configuration
   */
  svt_ahb_master_configuration cfg;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
   * Number of Idle cycles to be issued for a IDLE transaction
   */
  rand int num_idle_cycles = 1;
  
  /** @cond PRIVATE */
  /**
   * This variable is applicable to a fixed-length burst. 
   * When the value is 1'b1, every transfer in the fixed-length burst 
   * will assert the request pin. When this value is 0, the request 
   * pin is only asserted for the first beat of the fixed-length burst. For INCR burst, 
   * the request pin is asserted for every transfer regardless of this value.
   */
  rand bit assert_req_on_each_beat = 1'b0;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Non-randomizable variables */
  // ---------------------------------------------------------------------------
 /**
  * Local String variable to store the transaction object type for Protocol Analyzer
  */ 
  local string object_typ;

 /**
  * Local integer variable to store the current beat number which is 
  * used to created unique id required for Protocol Analyzer
  */ 

  local int beat_count_num = -1 ;

 /**
  * Local String variable store transaction uid which is associated to beat transactions,
  * required forfor Protocol Analyzer
  */ 
  local string parent_uid = "";

//vcs_vip_protect
`protected
A)@Q20=H1L]7(S8<:[D>/Vf6/W?N+:Z_-&a3<12\<e1>I,WZZJT76(#J.1SeJG@c
P4];OdA[_(D@.P_2?-X]3)P8gZLEAM\4R8)TV84J]&,SUDI1fd[X_^C9T-cYB?6W
\)M6a4C5+Y>Eg>S5=)UKWV=Q^M><MIa&b@H(\?AJ?8]6]0GCb)1(#SMPa=[^D+M[
:b-/gR0TX.QdL\0d_?WSbd/<-[.>S5)c?D+0X@;<W642]e^#;-6cN@#eQ&4fQ[OT
1He,d(U8[K(d7COgK[Q_QSQ4D\UTHG[<^)G\FOH=?+ZK@4OLWbLb1[C^7YPD,,EN
#J/Z6Q^&8<\d9&<7D36&EF923R.QXB]@@1B=,6P<S/#2UYSFV8aR/:e]ZQ5^MCGK
Q1b3+I9b4-+I_X_.[?J09Y;@[YF8:fIE,UfX,UCLaQfX.RVJH+KGOa+&(g>36ea(
Q^EWH;7FCdc>?2G\_(56(@MA=HG:&_/W+;+QC3ZA2fB8O<SEBg]);69g\EKZeX)L
+,@A^Bb\g4,V2-1b_CJF==<?UW/g&^9F8?0>Z)O2W(+74<)f.D,b]7#>42=WT^1K
NVV.P6)Dc;W7.#C;c/D;5(6)7fHDAPI=V0O6fdCGYgcS.QWaJTQ-1_]YK.c>>3RK
APSOPdI2g,XD(5QS>A.?b.WBSV,=S,XI^+45abN_bQ436SX_(3MT1Oe4fdLH\WWO
=L\DPH&_B[Na;]79)M;<XA>F3,BL3?V3O(G0]LR[]E8,-MCEZ,N<f?53[:YUd>@Q
\5ZE)[YW^eIS:PFZDV3LZN=XLH8S/R,5RO^:Fc#[-?NF.1B_0A@O&OFOYL67A^SU
UKG8?3B#K:F6AF#e-T^L<fJNcFFF90#5Ia79;D61>N@f8MgYMb26IC+eD@<BHO3H
<86R<Y4d0#IPN@BAX\bVfMa/KU_PL8P)=20Qb5O/7,).9Q-Td[&V3:L(Qd_INQ,1
-8YR,]9+=a-;Q1O2Q3FXR9W1Td]XZT)fg:Ag-g>TV;g]QZD2bdf+(X6NccR-)Kc3
4)N95B.-ZbcBWYL4)(HM]^;d>fW[ZSKD6eTI+SRN4JC1=Ie\CG6/B&NY<@URDR+X
Mdg^M-2IA&WY,aE:7YUF@bJ5TN4PDRg#aC<GHcLTMeUR&T>X^#I06)I0X/V;F3A&
,MBP)-)+3AOJZP>KUNP,HB]JQ@@:cZSUBdKeafO@<B79,bdAg6-=,\EX/H<_T3\<
S+aWO89Ig+:R&g8a]ZCJcOQDJI5g-JV60)EN.gP_?\AGM1-I;GL#4@-M6\4E=#6M
-:(2-^0X<-L3Fdc8J^^<V)[?.(-,QF+Fd:L7fS6YST8K\CY&TASc5?19TR?aFHg[
HP0-#A75b[)6Qf:=a6#BX[YUFD9CADbS#/V9TEBE_Dc#)A]KD.ONP_[H8g80?F,\
VUYV\P+?),JPO3D=-b:J;^64:e2g=W?:BS\0-NMZ?.dSbJ?.a=5NC.eJNJM5=<0Q
9gf_TKZC^9]./TT>)?9-7&^)e.(B9S81/E#HaB1K>T]4NG+JPLL3Y.?_bgS;,.#J
B:0O;\aP&LBIJ4c9T6]gBQ?A\^1CH3@_0e\P@;V?-[0SI61(VY2P=+AN<HBC/:0M
08cH;VR+.UNKa>-E..UP.4c9Dg7V1A5c4VZ9J74[R_TK6__,(25EP-(fQdaABf4g
J7Y0XGRIRZXc3OOSGHQR9XL&7;;Oc)6ZGGZY9:Je&RGHb/+N(;?Cd0JaW35b\d.O
d\f_0MD</_Y=NS:I:.(]5)>ee[E&(EZ]_18,XMLQ>_K61I_bRf+3.+_75,C_;g2U
bYJ/KW;EX/?L)GI(RYR)T4;L<b2Q:2,^)UZV><F-K/J>e3):+F?J9&c@8Z?KPF2Z
2F#a8.DMe5,:F0Y&R[CFOKV,(@)4U;U01QJ64#KgU^:<^PfN.-4=?ggF^8HW7B8X
9<-f\):Kg_1[-G3N7XZf#A=>&=])f]R@X]^_VbPV3A\K1&-5S<+1^7)GWY31S#?f
)g1XggV?3;A#OQXPKM@6U4/TLKA=&\7eRX_&gLMPBQU(F&Y_/e6S.>0Z@b+7/?a3
(H.+d(^WNb8b;T2_M[O,(+.;M7eL:G-_/Y<Z;<:>=X/R/Ha+7?-O.MXBeB0D#Oe+
+L.0D:PgN0PWE6^3LA4J(\WScOKD;?HW^-@=-#7.ageNB)LdMXU\-CL7f)U-HQ9Q
Ff1P:3KPGRXJVND=Z)UIW7ZP?cB8dW&AaUHOTgL5DdP,,#b(agcFCgKYDT;FZ>b_
@PgJN?T0-+,f3\6[IJ,QESDf6@0B,GGD07F\6FfV<b786NF-22KAMU#[TN<H7V3[
Y(bOX>NX]3##L,BKf+S,eL]TI3b?+YN08BAD4J\HbU4UYQ.bBF.KY/2O=@S>5+P;
XgVHTN5Z<.dX[Q_6BY[P#QZdR0YeA[M_7#BB;I+=45O79_IaG/0ebSMb\5dXEF@4
CXYg?Ud9D=XQE,a,adgdYWS[:OdYA>2&RLV/X=Q36]FE-LZUBOg?WbAfW,cSYB[V
^=9E]WZ#1O94K:78/N[KDLNR31]<1?-#OFAEFJ-AP2=4MMLfA<+(&Pf>JHI8cV?,
)E&.,MSVDKWL:a2U8KY6.@GUAP&4aZGMT-Q(RN,MaG,YJ@+3I)0;O<J).e<1Aad#
:<a2.8;/W6A@geM<=P0TRMB4Gf7=(FI^.8(dBWK=dd?3K:TK/WDdEZ+L^9:J@])N
<Q<B4AGCFED[)d-FGcS7LdL:V_B\5.70:Z=N.:PTNa^LFG0[-FU7JI[0_fF;+.)Q
/D(5TQ=5\?/-=Z)g^=AY6+GYRe96[V5A8L?g.SP,1C?+dS66)A;89<;HN_0SUcTI
)5F28?[\:\)cY?B,+2>QgR4Ic_Y9GMUC(Gc:Q@IT9.3bS#53E[g:/RVHPbZUL/O/
4dTV,7G4V.EU3>_J_4H3aY5^9KUJEaPd56:MI3S0)dBLb)Z7-7Z8O6U9c#d6?5YV
YQ8G@2V]JE)b<M>9>RWSA2,A8.6@=?R1(_-/Zg1:WbTR0FR>YTNIZ0X@O#+O@HA;
CHDE^4aM2RE?:;],9OI)PgK^KdLA(d_Y0c?^^04HUX1L^0>,&QU?\?&D>_H8K]?1
?.gR76,Qe1/X(^^+_e197.9:FWYJCfcG@Y-REW1BNMI5eX&12L:LZZLd_P)DATS=
(VJ_]86W=M^?WbA&RO_&;(@&C3C?+O.BVCQKE:0&2V8d/>KS0_F(G8<2@M+K8ITR
b=SX?LWBFOGT;O+_bBG.e;J+J>@&H)fQYPf:CW@]S:C^=2;IENG1/77_=EO6+ZB9
#M)YbH6D3XLHM+HS^X+ME\I;@SdR2=b--JT\3BO\O/Lf;8X1[Hf\W3D]fARUg[/[
H\S9:c&,ag&]1#=&I80CZA>8SHJM\,1NSe[YX>E3f)^gDAX-KVFfD@3:3MXOCc=;
K7WbIbP9B>C8FF\#9#AZ6EIDI:)+Ef?g834FKCYP(gJ9cbI@I(4Z.=2UIIVe[)P[
PWV(0;KS_4O-U/2?R9G.#,AF.EG###gV@W,YEf),YQ,[ZNDIB?.FV8D<3(N.S?G(
07Q\cd8TK@O32L:aX6<7b^X)9@P)ae]JYC=O<-C@c7dd0^<KBE&IT0ECHJ0N/I0Y
(YAd7K59R7-?DO10@dagVANW\d6bZ#35US?@_+0NQ;UI@58-DKd#PI6d]Kd@/_BP
)/<&5fW0Fb?K;-W_AEJ.]B?-]O?<F;g]?a8#Zd0+0e)W2YGF74?CHYfHL=PD@W#W
4.CeWeDNd#=aR=8._0GP\-)EC&XQLJW[2-\:J7H)>6^(8A7?<C+]-MQ=0ZC.&Z/)
:ZZ?>.X1>[=WOb71,IQ,=>P9A&K9FZ7a//>:C7#K6gd&bUHQ5LM/AVL&^/S5@f=e
0?N,G/[=FB\.b=PgFFBd_<;ddeFF3\2<(()#3T@J#;VQf)C\NEDV/LRb^@ZTK+..
4<E#.4bTQGRe^^W2T;Jb2D8VaDX\HNXJARBa>YJ9afH/33O(?JF#_I2[:UfG_M?S
[T]gB>X)IY3@X6,/JBR<2\AZ-R+EI5/M](RWO[Lb+8/f43(O^B<=@bY4I>8Q?JOU
0>AS;IgT6THL8+_XSd.E9TR:_07RI+e[e-4:033<6>.fI<^H(3[4M_U4bRbVO\Q/
F.^KJOJAbFYF@2O^<eRfH0XWB06.TIN>I^,=GSb^[6.7A;d+G[\#7C=<0PfDcQa3
RfV_&OK92,W3GA(Q^fNVZ.UcRJ\<)W[g^DNOQR]]3+Ia<MN#)NMYZ[N:-71EYQ)H
2JWW#HK.1E@,03#]4661R?[+G2<T633@]Xf^A_fbbc;:SGYdS>?]]EDOHYgWELT+
X^<G<Y#a4?ELJWJBQKBX5=UN7R?^IKZ#ca,^;>847]#/#P(5++KGO@]ZeHAY+#I8
2<HEZb9Q_g.g.D:F@4GG0>Uc+,7e6g:5Y&((gZ8XXECK>T89_<CbL&gX88I,)M&S
3<KBN&[fLNZ]12CDYSLH^-#6+59(?e:M9b+R(D>BGNU+&&[[gEN._gJ+798T@aMD
BE9_7aba(;fCJ?R7F@M<WcQaf?fG-K(?E:BOMSMQ:;Z.:Jb5Y\XR)QbeY60Vd.G3
DPJZ#:Jd&:L5UU660\eNC]5J[ZZ-QNZ#KWdCLOVb>\F[F=:B>]>AR-#^6F;D]-S:
:[(?G0&[;:C\&aX3YD>QRcSd;363<>O&LVKFXCc\VHTTMUA53.D[WfXY?bKYOY<U
d#60RTEG_+-VA.4@(G<1Zgf62g32,8&>6UECNeG,2E219,AH0KNX8WJW_A^YQC&E
EdJY^OWc60_XRdB>5#D#cU/9?EP0\UOO?XKe)_-;-SD4/I6,1#[XD]7K9VEZ4<BQ
0eGRa_KKB?:cKOfKP?K3FB5W+NW-QGB(@:D,bM4;@?B1[b=?JMCS6.66VSMSJ(/6
]E#T4SPBE;HD7aMg5XK6F[K/7UOW1PfTb^aRb+a(7gF<d#2GL=006Ub5)VY(FaRO
B9.gN2+bE\,g&3DM=4H?C[ZF(+Ka/NT9TBZFC7I@&?b;55Kab_A)0F3(37)=[5W,
KN:8UJb-YfA]:HKCQM\B7)]d650[Y^aGY^HP.SeQ1EFBcZ\.D-W]MHK4/;PfPS<-
9387XC)g6@[[dKQQFY(\?(1+V?F.VG&cb?M)A>9,N(B&/@7VT.?PA,2c-;FO_-a>
?1.bWF@A825eJNWZW_bf4&.RJE=/McX-6/JeQB9JQB+UC=]S.:M\/RaVRObJPX]U
fHLK1]QA95[P:4W2A826TbXC4J/_HX)M.fH9GA>;LR8GR;+1\JXd(CF:,YbV0DcE
8/W@0g?M<?_:3N^#O+J&]H=X<8K=gDCT&?g_?E38M-FPG5]HTSF1ZC5CJC(9][1_
,+.+PgD(<Z59.a&S1VX7P(Z]?4g=\(CI;)IYT+DEWZG<WfG/RZ<N\4DN+QZ#<[YW
BJX]J:.<<=EYA>D1PP)/&5[1ad\PJJ1A=2(4X:,O=\.d7J6fG_;^?5#X([dEX+2>
+L_dO=B@^)^F),Wf17f(_LWPA/X1S6JOBJSe)WH.9G4L52AC=D2_RT0Ma:eALG4Z
fV9feP4f4YI-5,_].a:e8L>@c[=#1Oa=N.QKa+Oa[WP1GX-bLR)gZV6K6@2?/>N:
DJKAc7<K].:RC=a+M7\YbM?4-YXSN;V<.&R/6I,S:3<?O@R;Z(Y9R4DgHCQ8<5FI
7Hc+,;9,fa.@U3GWC>N\[;/B9]1^1^T6G)#R[H1e+./5=7Ue89_&5TgT\.Q+M&e<
_<59-A(S&6LG>0AU+ZZT2/E^)J_>2?BN,3QJ[;@NK]#DGEEL__KK?]B=4I^@W27+
K06AWE9DT>)QGC[M3MPcg,,>08WO1TQ<^ISF:Xa;\Q;]<@2->BU.ea[;IbG5T6XK
(XNNK/1=NcGE.e,eJcOFY)[QE4<b.VV[G)I,e>T<BYU(/(I5UK5^4@7#IbJN]LP>
dDQ=g./8eWIOWT+7Q\DUV\GMCR^eUf>47AcXAKN6)b-&[WM&DN&_CP8S4@J_#].]
4,RS=XedB/3LS6Te1HadLII^F&Z5S1/Z?C.:82#?^T&T\WO7:0@42SRJd4bd]/T7
3.;2H;;dGT.&TV1Z6a5]_e8NZ\75cLU^bL/,MHF,4JA:LB\&]egC2.5dSPK#F\aJ
KSNG(>0eKP+PC(W[\fZ#Q8Z9E;0dE(abAd2<I9D7Q6UHBc,/Ng]-^QPA/a@Z3\Y[
8C^7Y>_V+eC9XHN:Sfe<[FIXMX=?0-gPI/[T?_;1VGNRG\ESZ[GbKZ(1#,?DZ/[:
J[UM.J@GJZ8a6Yf)3e4\^<6Z[_EQ.IZ=JcZQY^])ED&Q@SMgIV.Ne+O6aL9cO;#-
Vf^7U?L.b@7[#c9NRG5GZ5&FT,AW]g0c:JG8MW<NWB#Bg2I\-4UNF&7C#b2P#.1F
>@QdUBY.ZW1L\?I6Af1I908D9QZ-M0[4QEd-QU(S+;P&_P&Y(\>MYCdLZ;EU8S1N
-cU8fMJ?bMb=f4\,PCKCS&cOCRYaWK)#c=5-R6&94&b\HC@I..WA@@GaW8:P-Q46
YP-[-:dYMAOH5JVK&0=JRYEB0^\1NZX?&]=?e/bMgM\3-f6G)O5J=19D[M0AC0.7
If[XMCcE)=4SB+81F^SD+^O-PC,F3H@A(XZ_F64OK_KM6A&4#;9Mf</0(^b&.&<T
SE_[SJ-YB-Z,U3NNXfZa+FGgf6FV4Rcb+KD4@52F5BJ0P1LD#PK3SYbe9G3DD;aA
0M6]^;]LRR<OeOgKfH@5]QaHB,4UEJ.,3X08;EKd81?ZJWPQ12<A5-SKLL#A(-QI
Z:A_LH_VeR(N]R#:gNP[=XOC5UE&[4@[8&6K2C[[YJdE[c0P^,Z33K5)1AfD=-aW
Kc<ZNa0aE:AYVNR\Cc-S(-\:-H5#OUd\]?0&,8.:.C1<H/dKcFQ(Z?[>[,73.8SD
,d&U=^_+I],V9a.BIZ^AE))@TeJ,TYCN)-FZa[GN23.ISP2?=B;>R&KBLVQW>RdF
=M[ZZD:\A?GY+?8P+[aOK@9Q1TLMJWCWIAS22DTVQ49@F4NS<UfV,9WTS5P3LI@O
Y3Va;W(+PJX7\<J^7HX,38L.U(,X]_&SA^bd#dL]fRWT;&K)gF(KWAR5VJ4G-cC1
[=H;N.QgIe+A+TV/KLG-/^Ke.RY#G?(+=d+-<^V96X=_@f)E)I4./G?89HK0^4gN
49B/\&U2a.AZKJ6I70\Q449+M9aK\&aa)^/e7P#(X&\TK?gC.fdHSS[=bYMTL>N@
XW3]g9Y=-SH/(>F\CMK->IdVZ[aBV/8HT_WN^\;e==Y=g.Gc2g/2X5=+>eB=:XIG
F3\UG167/S)^H&CF_WJ<dO.OX@N,M(Fc:2.8-254(>,#9HVa6-Q6-_F);E^@:.PT
XYE#KJ<15BAgFBP3\CW/5b+VbA/gE>P-V2cBS1N;-Q&3ANJC@I32@TPSLT@Q+8I#
Z-7c6Y&Kf1MGa>O97I\=4GV(CVWKBF&76.<5I-OW\5&(M/2M<6H9dM^6c_5Xb3?(
KPaW1cV2^g+?FcJ+c5Z8P=>G3E[K.V0.3QOEB54:cafG:8(RWG/F;FZN17YPM(1H
Q#ECF3L0+F>;f4fBa#6_Tb:@B0E^A^A3Z-U3LT_=WOgL2?\4PU7RO&Q,RHKa50De
K<_7W,9f[[N+E<54U/YS0)V65-8K\C144(11EL40b?FEOgB2Abcf]LNS^N+2B/8I
R-6:WUVG-[[f]\BF&)G]Sd[(Y2_U4E\VW5L<]?:J)R,I49/406fZ3H,DBY:7Td>1
+U;K7FDV4#H1?8/VGe/bT;O+)A_?E=\P6SK2]-@FE(GYU6A.8JN&G-NN8eY+7BCN
Ka9YIcRg7eJL@ZdRUc>5;.^@::RON=Pa[F,4-<?DQ[<VO/@daEV9>I04-LWO]@YD
KJDN]L]8-W\OCe)eT@G\4bG1c,/<ZS,egTR[+(a9O1U6K7-+;EX3@:fR[&=53UI<
Ec->#6,13C#Q)51=ZL5.SR;LM1YPX,8\<bB>_dV3E-H1+?+Pb?fJJKS(U)>I_,(9
V=HOgLfd=H.a\26ZG=Q9+PfP[Z)MAE,9SJLa_=IPOH.>g=g(0N>-eD@/&bfA:&ed
dgH9:L>C;\>1e40CNJS0VId@[EBDCD^d@9c-MaI3D:TN6HP_cMa#IZ>VP[QW9+S9
YDW_N-W86V>RLRH]ROI6@_?U\J.b?-MH+RN:#NI>e]0>1H]G6X\I8BFa,CZJG_Kd
eR.58gI=;F;B[\;Y]2+>HWbU3-B=cR-.5W+<C02-U)ED,M>>G<N..d,_X)eL)&E<
T+@68MSFe7cM_UdX?2ZbdI)^U;5Ca)ed]E:0@Z5/-.F.N,JZbeKZMgK[Ob9(Mc?9
2=MD[T9EWQM5@G[((]_O[<K#1V13,Ha2,DO&W<_B1g5=5KM@7&T\WW4D94IQ/V6&
B<fe9-cd^\d;GTJg^6ZLSS=5R2:3IDZ-^;a1_.L)UaQ=,XCHAAQT66;\^UG;>5=6
CX#:ID9V>6gXPd@C-L=bRW_]M1;@)Z#8acQ]PN/=V2aJWZ,NdD@)(1#E_NPL1T\?
>9OJgR>](f4>]_#_I-LVK)@NPIdC#4bW/^HF2e2V616K5=\N#W8SPeAb)1&IbZ?c
\Vg7-Z@Ye/9-0L+#JB?7g>UPL[J-b57)3e8LO8-8#H7:;PYSg6SG&JOLc5@e7H](
[EF+UMSFUDC7Lff^d8<29OR,+9R>g[;3cXF0K[M&Q1QQHF<^F^b.1<UCV[R5_+b?
8\KHc:G10FL@PMA]?(Z]-XIZYLa#.YNU#\N3-Jc?[4,\BDdM[K<+?U.H-bF=gG0P
0M>=a5R7O^<6aA0/E.DL[aZXOQ]+1,&gQc>L2:@&/.Y?A_?@O_/KE<@UA_OcE.&G
+#a[Ba\UK@aY;H3Q,_J(#R]>VXMA4g:VI\==.-6F4]O:+;HCG)@e6?/2K;N1LHWI
ccBL7dL9/=BU\0A&c?KH>7[/:6UAR>5K]Q4Tg)35UGYPP1O?6L44E4]D:L0AYNdY
Hg9gHfbIB;YbbMU+CZSS7UR()9/PCNK)Fee(_e:=&&F#.ZLgD[V&2)7Wb]AO>U:b
=?eAggN>f>,[1=Z]CAGRcbQ=[U6-V#+P<CgDOE)]/C2fc/:6UQBe?15TBK)8Cc0;
_aYS,6:7I1JK@D;KgPSE9f-<6K7(,UWd;fB<.PTOQF-W(bQ\U^53D=]K)5c080V:
[f0#1GO^LIL=gH.e#UfDKSRe1HcK[\;8a\[48?VD)cNR\QNT[)N+L>FDLF>VP1N.
]5;:8T]F,17\1a5J?-XT>9[bgZIW+<)c.deOd)9QCEN&06<CaS\I2VCT+,CL3:RO
D;g8Ia4Z-__9c8_4SVB,6eK>0XGG.X/MYR73YV.P6G,2_VgHP9W#;FU,&J,,52#c
(R4_D?\SP1DC(gQ2O4TBbE30M,QASKR_KB?U,A+SDO=-<7bG84gJN1)J76N:4b)L
)Z3@)U7FB,GL68MVM;ScBQMI>3Kf(47&X[&\N.Z>eeAa76.@,cTf\(E?[76^.84B
4YLZ;.LgXdCWe;MeEf0.29I#<gfbQ4GQ=5Z(CgPUS5IA@EKM5?3C@B\NeR;OAFGU
SV2JZ@_-DVfM;81K\2Jf#JBIaX5c/:;6?7MU&#;MM[HYI7>4,>d6:0C#OJObZ/+>
VNCIPHSO]GNG]B4_WB=-.@;P^LId>)W]Z-OJ36fIU@eeL^=dgf]J(I.=gaBKY?63
QJd(d8G.c&^+_:=(.RE#I8c8WXFO(G^\M33@:=Kfc0,a#44KdQAQ4AF]FH[.WGV&
MXCB=[00Y-H/f3[?:ecVY^:]8D,8e,^EQ;47+81cEAA^>gaSX;=4_7@ZFMVNJQ<&
g5HUV>?>L;A-MLCC32.8[V5+9;&QOJW=e8..:^D)&KM1KK]8cf5W7SV6Eb@=II-G
-a6D=F+[Q1N6,4HI>5fMB<@JXbJPQ\-XH@1d]2>#)(ZP)V:a<AER<F38TFc=OOT,
_AOEBQa=>2_)^\SZ:MaP4[B+dPUJ_]MGa[.&/^+MXR,:CT7P3MQ6dO<K>gH[]2QI
<0bb.-[LOYBRBI)CgX1H=_7cO8Q9S-8cWU\5U)]4PMF2ff6Ld5#U><#MUZQ5C:MN
]53eWB04)Xd)[8DR&.LeI5W_BN#R.]D\W])QZ20XcfZRV5ZSe^T<.83]WW_eHHe6
1gL]cU;I4J-#IfXB(/f(,IQ436Hg@B9QF\>a&GDXD>(,Y<^A3AMFK-3bIdR[0ZW5
Q41W^Y/[/^__<JX=X1QA4&5J_JSQO.OG.,S_-eaEDOM#66I8)AAL,=H6d.0]TAU.
Q=9>[aD7ZH=V79X@4\bX6FD:&R9UI:&[/#ZW.gPFH0V)IEM6XRR6FYZ1JaG<&,@-
Q30QBV4ME^MP64;R[aDSfc]=5A<PC]LJ.dE8;PA21S1a+AeFCRI==JN?SH30I+G\
.7VUBVC4aW(fEVM@2f#37\-NQ)9_&5bVCgGVY2=SW=/EN/9TTdRUfCf@2SaGJ_L]
OI^b/O@W3;2=Q;A(90DR\bN=/X[T?R<f5)>F)N4G\?5QdE?70dfY#-e<g6Qa6IK+
9<cK_C)EFN^LZ9)/R,F7,9]\&80Ug_SNdUS:^e.U&BT/]b>-Q1#f76@cfSZ\8[HH
G\BUPba[C(7QPI+5B;?EBFYUJ@OL^bg9N:>;(Y3Ad4fC]_7A=A5H6]4+PPR-]_<-
Gb?5OaUX]-CM]#)f#/39Y7/dB63H7=fF\I9<X0X=<F3W02A>19<F1aM-&aC3I/e[
8:S#);]dA7>e?8/G8-#HLD/>Ng3=XA&#aO;^g_C@=6X_T&K=,,KO>gg-8PeQY#X3
&7OGQG[\O;gJRW>78.)L8?gM/fcH3fU\41d)H4PRZYUV9R&e3P7>5fEcNW/ZC>6c
CLgA]_U3#)b/<.##g\7M?>1+86YgMC9+O0.J<,Y_\EdC628FG2]2JL<T787cc5g1
XR,J0ZH6BZ82)O[0J^2<E_&P==3TARO6/88[c31eM(/T58_:;HL4dIbH91,BNF=f
4[)Z)N>5;-b.cX(.#.Xfg4X--NF]\2N+_EdeIUZ5Z8;7:<J.cH);(>4aQ?_\IOc4
LCPPcZg\S1dD(Eb^)]C)Xgc<TKF:ICCW>NZ2/#.743^Q0g9e?2Fe,YE<I]@[]cLb
VK9T,:,)<1TWDV<__eKHA\XV=3L]D2:dV.0308:M/#&^LG_30,_AQV4?9]<cU8?e
H6<AebAWCPdM;>E3_9JWGF2I0&H&NP9_G.e,Wg;WQNT1M#X9Pb7>8BP__SX=XE]T
I.)];bT+b/#DRS67JK)[Fb9B8f1[9P09IGB)4RYF@^LB>/Y1W\Z0OKP7[3?S/cIB
2.,(E8KC8cIF,Jg@0UF,AfcSCUa,10FA-[fA,J7OS5bc/PXT6TG&8N>af)PR446U
BN]TDNO10V^9gRG@#H74@4(O5U90Pdd-<@bBYBf4fCZCA3GHM9EAf&EaP8]=BG<Z
Q=1M:?4(K:MaQA7B#_Kf@#ARJMW9KE[-e<FV(V]E:K^:5;aCLM;X8eSOXPd+Y<V;
-/).K=T)PQ3YLT<7L@I+M86\3X-XYG=(LP[W:LRe;d::U=12:7Ug^;6H#^\MTXA#
)g)TQZJ@H^Z(Vc=W(?92^Z@2g3J5f4LM>$
`endprotected
  


  // ****************************************************************************
  // Methods
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_master_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   */
  extern function new (string name = "svt_ahb_master_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_transaction)
    `svt_field_int(assert_req_on_each_beat, `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int(num_idle_cycles, `SVT_ALL_ON|`SVT_DEC|`SVT_NOCOMPARE)
  `svt_data_member_end(svt_ahb_master_transaction)

 //----------------------------------------------------------------------------
 /**
  * Check the configuration, and if the configuration isn't valid then
  * attempt to obtain it from the sequencer before attempting to randomize the 
  * transaction.
  */
 extern function void pre_randomize ();

 //----------------------------------------------------------------------------
 /**
  * Method to turn reasonable constraints on/off as a block.
  */
 extern virtual function int reasonable_constraint_mode ( bit on_off );

 //----------------------------------------------------------------------------
 /**
  * Returns the class name for the object.
  */
 extern virtual function string get_class_name ();


 //----------------------------------------------------------------------------
 /**
  * Checks to see that the data field values are valid, focusing mainly on
  * checking/enforcing valid_ranges constraint. 
  
  * @param silent If 1, no messages are issued by this method. If 0, error
  * messages are issued by this method.  
  * @param kind Supported kind values are `SVT_DATA_TYPE::RELEVANT and
  * `SVT_TRANSACTION_TYPE::COMPLETE. If kind is set to
  * `SVT_DATA_TYPE::RELEVANT, this method performs validity checks only on
  * relevant fields. Typically, these fields represent the physical attributes
  * of the protocol. If kind is set to `SVT_TRANSACTION_TYPE::COMPLETE, this
  * method performs validity checks on all fields of the class. 
  */
 extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);

 //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_ahb_master_transaction.
   */
  extern virtual function vmm_data do_allocate ();

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size ( int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack ( ref logic [7:0] bytes[],
                                                      input int unsigned offset = 0,
                                                      input int kind = -1 );
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[],
                                                        input int unsigned    offset = 0,
                                                        input int             len    = -1,
                                                        input int             kind   = -1 );
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, 
                                           input int array_ix, ref `SVT_DATA_TYPE data_obj);
  
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();
  // ---------------------------------------------------------------------------

  /**
   * This method is used to drop the transaction if it crosses the slave address boundary
   *
   */
  extern virtual function void is_transaction_valid(bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] min_byte_addr,bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] max_byte_addr, output bit drop_xact);
  // ---------------------------------------------------------------------------
  /**
   * Called when rebuilding of a transaction is required
   * @param start_addr Starting address for the rebuild transaction
   */
  extern virtual function void rebuild_transaction(bit [`SVT_AHB_MAX_ADDR_WIDTH - 1 : 0] start_addr,
                                                   int beat_num,
                                                   bit ebt_due_to_loss_of_grant = 'b0,
                                                   bit rebuild_using_wrap_boundary_as_start_addr = 'b0,
                                                   output bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] wrap_boundary,
                                                   output beat_addr_wrt_wrap_boundary_enum addr_wrt_wrap_boundary,
                                                   input svt_ahb_transaction rebuild_xact);
 // -------------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid="", string typ="", string parent_uid="", string channel="");

 //------------------------------------------------------------------------------------
 /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  extern virtual function string get_uid();

 //------------------------------------------------------------------------------------
 /** This method is used in appending the transaction count at the end of
  * object_type to get the a unique uid for each object that is getting
  * stored through PA 
  */
 extern virtual function void  set_pa_data( int beat_count, bit transaction, string parent_uid);
    
 //------------------------------------------------------------------------------------
 /** This method is used to clear the the object_type set in set_pa_data()
  * method to avoid any overriding of the object_type of bus activity and
  * transaction types
  */
 extern virtual function void clear_pa_data();

 //-----------------------------------------------------------------------------------  
   `ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_master_transaction)
  `vmm_class_factory(svt_ahb_master_transaction)
`endif
  
endclass


`protected
I.(;\,SE&1FbP;I-a/EI_]WgcA>5cS3-R5;XY1[0.-/^Z:Y.+F>:-)6E1@<bc_2P
aJgD95<0d+]HCY]=EI(\Jc.6FGfdU-L/AbcdeMNCVWfTC/A(M/Z[G_\/FdEJ-.??
AG(6_8+MIb/f:O59QJ>SPT8]Qd.Z5WDV5YFM+7T<),9:WF;W=(RE3Q\TIf2>XD26
B<74BI?#Z#I/,T#<A<+B9^P25J8_(\bNRRORP=F0X/Zb<.cIGMDVIHC1Kf2^4FVf
E:4MC=EU=EHUEbK=JT/<FTI7B/[Z@,-1#e(4O/4ADDCQEKHG+7#Yc:RAWFU>E\^B
UbTVWJNRgT=P4=R:U>FAgXW^85O9Be5\\2&[H@IfL[-<98_>aNK/O/7YcNJNb995
K.IMDUF[N2[X_ZU:CSKJ_#6eNTZ.VXGZ0c0OSRZIC3T?\>=4?07UO<b3#]eQ]#/A
1D(2dMN&-(b>,B\)O+K0NR<+DN3=2&f7C(1I&f?(e=<;SLJIRA--9I8ZJ>OF7F/A
;HJ]e:I(>E+W1/Q24<;O;-+a+R,8SK\fZbB7e=M9]\8+g^QYGBaHd.&_;^<Z?+-g
bR<]V=4W90/9[SID\I_6Q;^19)fX:F0R/=VF#M2dJ?fcgA>]_:0RW:-5<5gG6HW<
ae-;T)E3YaE^D/KI&01GCf<P@+^8L;HHQ4/g78&Sd>J]>0&G68W-A1H#@[Q7IHUS
f;(fA\e@RW,S-7SUH?Y[YSNaIMP.\V^FHNQQKE#dJ+d(TfYU4S,ZBPfZZYeP[W;a
<S(Na6Y@Y_S@9-(&I?FSVF=a:=^HUe^]&AE.Y#&1-e,3Pb(Z<A5<]E0P^\/_;W9;
G-gbbM=_==-ORZWIO<5SF_)@_7(A6_.\c-5>f@&6:M&OFY:_2B^784O;:,cCHKF@
?bYOUI:CaS/9WRZ0/c-L,Jb1?7/NU?@E9SBBVaRLG[(8b@c4XDAcdfW.Qb1<WT1X
4@814;QR<&U_I3gUHT:MfT5CCPe2CbJc>4JI8Ub?@;NQAL64cU-IYc=cQ8?<.U1@
3J(a:Qb+/YKaJU\R+JB#W,),+;DLON]#S)]1Z7]^c@8RW<<9gF1[9Z=cI$
`endprotected

function void svt_ahb_master_transaction::pre_randomize();
`protected
)f[SJRC##4OD+#L5[fPT14eE8W>?3TPK+0g_H)^&=RV?D0e=ZHL12)WXcBU@8.a>
RK\TR<]g3A9_JcSMd;F,/f<UN38GBaY/ba/#?@VM7?OB_C/IgA6U,:G\\B^8YR[c
4]:?>_M03g0O\+M_S&N8+>,45fT;dGE9[V,C5:bL[+cA3KCg]L,>fH6Y3Off,fe@
ZX\@UG49]L;CBNYea>W];J6E(</+,EVO/PT^eSXLWP-D)M_J[L?]c\#1?>ff#D>O
(_DDaga14KHV&U)d=GVf0@edA)S8A9)=]JA&S0:13QG(6OfB:03LXW/4U&bQ,[5M
9^d#a_JF?3D+<^1OQ\E-NaId5;A;PZb@JEP9PDf.=/:KKUI[L[BZ2PV\DggUI</]
^8V0ED>9,P-WgX@\5@CeEQV<81c(dS3M-gTaHJ8B;Xd]dHN6]7(-PXOY\GTK47L@
G_OEUP//e^F^^_Q\VB;C:)B)Q?2f5C;PB\_SEAGY?g,:L9UNH86QcT,CeHB&4#cR
3\@e-IG]S]06AIFOe49]8Rc9T3ZN/@GXJ\\C=QMNab)<Y2U1XXFE=dR(7X>192>K
0T[WM4[T:>a<JYNFTe9_EA5XNK(ZTbN,>IL4C&b\<<1=2..LD^<C36WVY?Y#?=@A
A)F[fF7>NN>SeE3e2dUJ?O4&?O0_IPVC>$
`endprotected

endfunction: pre_randomize
//vcs_vip_protect
`protected
ASU\3?<=(9<9W;C.U=-ZaaUISSE?R_Q.:O+[Og1SB<R+c6>SJKCX,(;DUNOIN?I5
XJ(Z3@IPN-5/#<PG=[=ScXG3N/_B6+VRfQ?=IU^\gDQgM5:G-,aR=C:>@A1QE^]+
?:TE(dKXI>4GD\TS;:L-#.H?)AJJM],;TZ>eDT4Y>+-@,)[9LFF85YA4FX,>gO=Y
D4WMZJ5[80.@,fPU/=fH5FC)WH@M^QFBVb)e+eJS1aDL9H1#e<DAD8?UL@HQd5TH
Ca];(>M3fTg)[R^a(7U]R,I710c\Z7cYCeI:2[^>KGLaB:7>aI#>#^eTJSGZ\0>X
KLXc;=+(CgUBHc(X7eNaW(4V+A2@QIY](9bO>@\:41.8]P8#XX0GY(VQ4]IL.D-R
&+(#AJ/&Yf;+Ue]PC[GL.ZK@ELb9]2YQ5Q-?d3--W4X6WH&L20/Ra80M3;,N,@B4
I<XN[;_VM]Tc<(],&HZI=3];HXd,]@D-][RePS6Z9^g9^5K@F^2>&+Nd;&O<;33X
QAH:SE2[b.==#:c^3PW2BZ1HI1;G)24GFI66@T[5YY;HQ4aODIJ_;b<;&+fJSFH6
W];I6+;DL)OLaY5]APJ:c?@^S+I<b>)gT?YO^68&MW3FIA^_9:V>Cd6e@AWHbGVE
9SFIEc)A/7T6T8:WW<&=cM>\X76)L>O02SbX6\f.>I/HURe=Z,-5H-JQK9+,7.bC
&=X>df^)^+HEeZEP#^_N2T#c8UWK:a(:B8=:&Zb(0X_E-\2,f[fU\0=\NV]N<TfO
?]4@DZWK#T5OeWg5Z@HX]DKNQ<-3K\9(>M09Xf=GH3&N2>>7DaDMW;7Z,MEH[Zd^
-#:UE.^A_2=a30XOd9JH.=QGRLK@]0AO_bVX(Z.247c<U(0,7aZB&5>C>Xdg::fd
FJ1J)(ZU89H()UEbWP@DVZZ7^,Jgcc>[U@CKWaV/O@<6RV252G]MV6JI+L5e[V4:
?8.HbWUKI\-^C0N]@]C7.(f19&KcDKIaC.(f,F_BS3[DU/CN28BQQTPQ4>62K+f&
74I#S)UfV:eFI85dMgI?O)Hc8-O&NP;P]9VH(7E^I.E[3dU4eca@5-J_LR;\6@M/
;IfUe8(@@VUE]a.NE:L)gQJ#,1&BW->RUX8B\72/>YUd@\^7&B^&f96>9;TT<8&3
(;KOa<QDfRW^3fd#=6R?ZQ,]G>8&B^,]LMZ.U>I\:-bP)a^?<[IE^d47+AH;Q/c^
D1W[bUTR9DOQ&^>\E+eP0[a?JY&,FA(;I.0&F--W418GMbS)=&5P9DM750_f9S)0
A<H+SVC;N)8<JeP:=7&^\DR<=^JCVDEKb>9S\=;4,\faIOO>HDGQN&6&VNU-bHGE
\X(T-X)X+D?(feRK/VcT5Z.T)9BggMD6=E[^?3^Z][@5U;RAT(1I-Q+K/;<0>EHD
2.\:f56L.#>+W[U#Y_.ABaRd/(WWCN9WYY,QQ/;/2ZD3VUTK1-QR=:WRR1S_>P67
Z9^LdL)_5.#d:5=J4M2YR+f>3FM#KU\d:c:;T1Ff1cVF[FP;_If\bD\d3IYN)\7,
MH7Af^-DNgM1]#Oa2CSW_K^V:_O/gB;d]U:65gUQBK0]+CCQH:GPbQVC@LZbRa<1
1bO#>&40MLS9;?EC1ZS=,6?7CP/3&ec]>P-,-I1IN\A0I.T@LUILS0XZQbY(G.8,
NX^3?dHLcA4H2:_D7ZFdZXF,#J@D5?b5fTc9@+8e61#(PeKU><WgJfRGDLd6EN98
/T)9aB3V/bQRWfXDaI^W2QKVX^D/E-,R=Z:.gab0.PBN3H0\&3Z],MX9cD7YFa&d
/,B+/:a(YU4G=&N7O\Y=b25G-T2,&?+I:LgGS=&XMaDPS;JZCFO,4TT.bN>U0.Q3
O^P+WdR0Xa^&TOLX9fXQ8=[,AgfD5L@H^9eA7CUOHBJReX7b=US,RKE;b.KF2a+A
:M\2dX;<3e_/HNbJII5/V-PM(@cZ=Q8=XEV[SJ6:A4HLYV\S;-#IR)\7SU;>PTUZ
cb[MCCUNQ,4&dI.1-77Se8#-\YcW0[6cY?@KIf\[/Z@g;,C9L4+1#FZZ7O0X68<G
_#cAed8(MeR[[]B+T/NM<g>CU4SF#E2/6ZV@7B;J9<8E3=E@>FUX3L<1KP,5H]G+
?6S(M]ceW9TB^9B4233R1YY:72FP>JH6B4,P=+;Td2]<9eAUMcHH[/OTA]>O/MHS
3\<7E:8JXZZWfb)CE3R8D<P/E&QN+5[N_;A:ZSb64dV:M,2^;=8K=Hb69Z6L,;BS
S^&U#+(L;[A;G<2.eUL[/;.SG3(AF2#/]>NYIHC^I]&gAL<U.O^&]8E4ef+SDaL4
PGa72\.G)KYF\-4C_Y@8ZZ1-eSXDR-U48)+RdF2.^XH16eT:,-Tc?IQRYF[.[_+A
7Dc,Q&eeK7)^SH_XJ?5OG?P0,fb<Y&&4HGe4&\aR,U5Ea;+A1Je;CC4AeZE6-:[a
^U4AKW40VJ64[E.fH&22&&7dKCaH=9;VABY5g1KZ7>;<7>E_f/?-J9)d?_CFI+S:
KL:5E1b==;e?UB.R.6Hd.91dWN:]g=A>6&FYbZcV+M)#\eR4R4I<^d6FVOS#)K)N
g4Y=,3#F6\1.1(=)_Fd+ff>/CLPGARJ[JUAQE<a+^g1169FUHGC,<O:5YdG^KDD?
+TE:=D1XO3_NgXg(((Wb911T+db0^_4OH_&9(_@LB?Z/Y[)VBIf^Wba\2K#.<.<,
O9I:_Tf1?]#GG<7C.:HbTG<+90#@O(?13N]6KMT=c7aKPfQCJ1W^Z+&8Z5KcZB[,
TOA/\R;UP3fB62;b,2^Z?QH.2E>(F_&X3Z_5Y6;d8868,eUb>&:HGNM=O4)H1b[&
>gO[^@C:>0F&6:T62O2H9_\6LP;PP=?e;>+\I8IKHb.B?>]a9QYV2-N7PaSG1G(B
Mc55Y/b\2c(QIEBZ.4_,\^(2+B9&,DZ,G1YSED^?,7ST,<>5;6]A\-\2]E>A#I?@
(VG+V1X#X+;]+?V&./NHX/Z&(G&\=@J7+(&\NQ</1\P^\+,Z4_ZNA7XJS>-<PRDe
I3_+^IcLEBDYe\FT-4VT2#aNbbRDI1B-1O&+ONL@5HJ&eeeZJ,b[3A4K]bC\=/2>
J]6;f0Q4(2Ta7\:D\O4OgW@f#;)/M0gD#XK79^K5ZH9Y;?(ODbY>b<#6E(),]&LF
_O[2daQdF6,#8G(N&FD0E@FWeg:K><[PW?;7HSJ4L9ZK:C+0Y&55>FP744@4\\/>
[D^,#geZ7/9_MUfF4S>-=a\>F&_E[Da-b9&_f?1=MIb)#[5//d&,aZeAWMe)X\]Q
ZI@8+IBR1@MIH;I9@0_f/X.=<&-?&9<WF6b4Q,=WQ=SR6Zg]G/L94dY?O;?J7&<V
GU)OF-99YSB^,_QJLWWDLA0Wa9PY8QU))U^QF77EJ6;(&eS>fSU9#\RG/-LAT3QS
P#)H08D\Q@,4<=>Qc=ELVYF>OX4T#)FEe>LWVXWQFW0dX7X>.551T@/]e9T/R(^\
_IWSA\4.f1N(a:.>-<V.BY@#cS1e=7\UR6IJ9N(AWOaE2XF^07<\;K[P).dE7F-M
De]-B.S=L3NQ(MXK2AMdYO()&K#a)U#8gRA-@NdD6_KXQ,YDL>,I-2,NN5()=EE5
1NF;KP)RB&./S=+P^PWDa)TOV._e#(16AS1=?#1KN5:TX^B2:;8H(0HfWf49=^ZO
(9TE^_Z;42_=TODe[M/+EEaZ@N3&<(GX/YF7=O8TX>S1;B^L(P\-QR/:(/;(@[;O
;24-BW&?b9D;S8-eg3_#C6ARVW8,e>Z9GOOe=a?_&cY]LdPfbE1/UZ&:HKL;cF5^
L->>Dd7AaL@O=-U&LK[+00&bM3JGLJ]K_O_b6(B_dDLdc@Oe@+^7R[[J^,TY@LgQ
Z(YN9@1E1]#N^CTb322+5Z4=c/8HF0=8))Ra4NAEUQ;L1G0,50NVf6Tc7&@XDg&Z
T,>H0S/HBM+]+0BH>8aGfN+,3#M0Ta6e0_3.3HHYbG1ST9:-<^+H(^<H#+Z-?:2b
PE-Y(&U/??BZeDcG/)G05N7,I9aX8;KVSDC=?KLgcI]PcD^-PZ&aIA<[;RYbN6df
Fd+WLda5YD,O-KS@OQJb3ISR@/eP>38)TFJ5AYP>_fg74V-W+[Ra=d>T\8@b[3-+
FdOeC(LU<T14,:bLD;U<UU32_&[B\71GW9GPQQ.fT;50POD7H6]07#9BPTd1:1b#
D4J10\WZM>^>]>_6ZN0\b1\;_+\RIT?&@(ZBfFdKcP3/,56bAf-,46L1QD9ZE,H9
JB>OMX>8;5DHSAXf344LHD[??I(d2OJVaBMRI48AA[\/>cWI/HNbY2DE-GB)#D]&
J2Me\@9L9f]cGgBA\<f83CCEZB_(Vc\?)ASIdSb_A>A\L.MB6<GfG0T=NKO1ZZHW
M8\\-Bdg#:C:R@O<X\&FUDC6?AM9(?YJQMHe.BU-K,NTgUG=/J>f#O5B1XTgV0X4
(d3<D_0RGVA_+;0=9734L=30(;Lbc]V>AeFdYQ;4=HLWUJM;Z)_>dcY96J,?4&U1
\#M[]Y_-0dN+]+fW^]M&X(<DF\BNEa@O.K\c5>F5OSR?QZ::@-NA64O+GM;NZ.;<
3CJ\)>+BA&aM?(6HbLCadBfcR]?D.Q)\2@\ZKOFN]B&0N:>NPM\6#R#8PC=b2[,3
&<fZ74ZL@12QC4eI_d,B>66Q#Z<+GO5-<6<O2?EL),NF\BDXS#;(Q+,X<deZO\&5
<D&d>WU)75YYg=E^_I&5]6+#c@#:#\@2,U2@WNTT\[+B-Sc/&BfaHXc(T,COb=VP
&6X=9,P0B3Hg5PN[fIc0g&FfCSF^c;ITKFW,aW/.BLCHg5ZUUV0\gE3_NYW^)3@g
MI;[G+T8&<HPG641e_EEZbF42IB,)AA&NeTFVUTYDPeRXEOC_X4F\a9DZL=+7/HR
>Z5CU^[]+e&4dETeB1Q9I.F\W(Xa<-Bcb,?_cc;ET#I9Y>M;QM,N(GZWII8-4F2#
\FJ&DQ4C_4((b77KC,b&?W28V=F@FK7?4/g]E./3@LcHLITHbDIO_N]:R?_(Fa71
J<FJ4_Og))S6Ta8\&\-#7)XVW<<.-W0[6@[>4&HbZA<ZBNH?G#1F##4V?C;V>FJQ
LcdC@;/2>PQN[?dDC_0=Bf4)B#&eH#8_-N@3>6gd_5S1AG,VX4GHZA1Db\B:EL#\
O28CMf)a67]PdAPP]54Q6ZMfW:K(g:P=0:Yd.5DG+@BK(CEY>J&FAG>8ZgSAZNYU
fdHEWe=)PE#?Q4e16Y,-UA9Hb+98EX;3N]Gc_H1WH0RbMQ;>e66bF7gSdH)A5#:_
9CF?6H3Yf]g5e>X,#A0S[6/Q7UYdJ<(GX7\AVdAE@9EJc>)8L86F[_.P]Ng3?Hf\
A77W2dIWQH1MK]Z0HH=Y&E#+Tga+W(b7PKS2NI:=O3WZ20(NCQ[\&)_H&55GfJC,
^1J^MgLI&EG4FU^U9<<McFL\-CL6+#9\7XJAB/COCdZ/P1/OB,C(\K^>.[]+&29F
,8>>_5BJb>HEWcVY=QHC)^LII&_Bef^F()cQLXF;?>+=KIXaFcJL)f,_?IWU=YXc
K^cfD9B0QRL=F+8XEQ39Y>\70b/S#5J7Rcc#96ZXY9)9R5ZcCF(b:KM?Pd,)A/#=
E&;,YEa5-6Y]Q&[a1[f-/XgG9Zag:4dD&ZU=XNcUgf==YN,178KE>9]CASLOgQ-7
+BKU6US#Ad6+=&+(PCU)A-C0E=L-\D@(/5@ePQIOWDT811aL_f2[LN6[DLESX^2&
3_:=+SX(;)bVRP<ZLP.(LG>8ET?);;,3cS6<>;#5;@)UXN0[,5(6\2SNY+[@8OFc
>U?SNbWL]P-RLJ/94Ad?L2Z5>\\P6fNc\=@L<H+7:D\31=BPQ4CD1gAAL-8a+@_Q
O\/f2R&WYfb5McNT1(M>4O[TN15BV4Gc:0D+a+dBX.V_]KO[Ma>>B6&TLP9<c]R6
4b7Q_=/]&:M?H;d4&=,5.:N>W4bXU#1:De\&?P6./Q2/R^C@.8)R4YDVbI5E@4;[
WGI\XPIKf?9DAH=,@90NDPL>P3cb<FOK5DZ9LNH/1NF9O^OY,eV\J[3ZVg/HYNKD
-CJe\Zcf\9JFF54J.+Y#6Pe<M]CY?L#\CfN=WNV_L4B>PJ_H+_>X9/G2M2=O/=QQ
3DS4BH_0<eP0HFH3]>eG7Hgg,dNE:N]H.5TPc3:7@U],3FcLZQ([.1d=65LI@S_H
FPg@MQ[:eGAX\[[[?OZPSS=]41((aIVZgcYe6A<Y05d\D?aAfARQ;P6@B7^gMCFd
fUX&AVgZ])A_JYX<4W8be\YC^1N4C2ab@f^AXIV[T-0f2IX5IY;KgG=XN?D8(#XN
U=D64=EYI-X2U4QM@Y&JMN7dM/^>dV8JeGO)D9^R\)TH=I;;>5b)7BM)_=d2?,64
@+^@\<HF-]fL9W9e6B[SC;B+D[=ba_NWEH1\/\1OB/6ACdX?S.;5=3-J_U;fN1#R
.<W1Eg)G6KWE)(g[BQTQI1M5c]/<T?^D+X6?(34<cb41X4W+JDZdAV177ge2V05K
G<Z_OU6UaB.c=NfDY=O41?.(C.8Y((O+(,-=/#N=0[6@@N_Fe9eJ&W;)+#gAC9VK
?.+b6&U@N)6B@Td#WK(/MS_be[X&dcWC3TY.&/\7PY+bd>^e(Db8TME,Y[R6L.R3
/V@7M1WBN6H1_B0\8Uf<-CBO97/;(>Z<aN]e2?D53dA6<-aHDUd0R5Y_:WH#T[eF
c6Vg[24dSPCZ0.-Q&9-/&A1V7(4J^:gg-EA&=M]8RIU-A14@\a.[9GBg@Y^e;:2Z
>S_80P=[.7T77CG?-PHbXXIG-?YeJUTSBG5WEK<Q=AQ2&,-bI//Jaf8c[gMO;e?8
fXC)8eH&4@YH,4&:3D<W.[bW<eHdVcAOd,32,27^DEBVQ\@7D:W2=@H]FQBQ+[YU
cQ3,fSMZd>3afFQU7>8T-WHP(dZ[(5[=X0\,?\YT).P;E?^^.9DPX/dYVN@G#DVA
9>H__@<g@<J_V)EdBK)7VBb(R^<9WTM\MZ_6c./T=V<E)LU[6?BR4;7gcbSCQ^;@
VBD]:U_S4EDCEN?&#9HB4QFKCdG9SHTP\4KHUI#Z3&I_2NP4Z]@G&bYeB5R8,dD@
G.9V@ag3>a3Z(dAR3Z3dGFFcFR>\MW6<)DOe:e_/H;N?+D)IY5&Fbc@HVSOL+#K_
L4WU[-=O#LK>e6OQ;AIIPQ75XT>gdM22FFPgf[VaI):O1gJQ27H+KgAWN2+Z+S<4
B2G3:SI:PeX.?U_BBb[57U6F&TBf8=)c340d<V<bU6B<61aA7)5c=27)(H]cR/Q/
+4P/a\]Q3Bc\d8,9ADQ/f/0[/-S<PGR[f(:VX_D;f)UEEMAI\UQ<>I##[,GDN^J^
?EIOa/(W.B@,8LR@OOg&eEFO\<fP4cb_:#WEYV-Y6fT&.]F^,=W_.RQP)64Yb=8Y
5H>QP@b5dXZF@U[cA?QPLH^4QOWEA^-UgK>NfHgWILaNTH:-fPZCFSeF_QJ&OS(G
.7H5_QSVBOP;DCDL356IAJ=FFN72&FQW>5dU_WeZPLCd>J1IG@/=]L[45WSWSB,5
fBa@RSO6>]F<b,.849eP0ZQ20Na]aOW])>Y/404Y)]\MVa7UA-7X&:M?0K6LTe)J
0(<YgG85GG^5NaT_,ScPADB.BQ_Cg;#P==4W\&NI@7O)51V0;@E)b(#X[.>S8_8:
C95=[4@WfV/CQEUVSTB/.c/BN)b&/cM)U#^/C:#7Z.dZ,BK?^g54.W^P_./<II1V
GRO44;[KcE.-RZfP@8_J2.4+==U;+&<JC=L6f;A4/,5P7REfI,S^QH(5U(PH1JNO
a+0-Q0K;0OS<f[R_-deMRBL)S0K27eF&ZH#HF:5Y@b\:bC\+DO(<]0e@C5g&#\C]
c6/I-TaQD>SHeHCCG<)?&3TE?D4T(cJC78f7cW4d6)aQ_MV.YN114<29VeU^+cSU
/@@gL48VDf:&Ka3?QD^S1H?C(&e<+g=9M1?+.1ZV&dF?F&?9L4Q81H<+g?J<S434
c3>>_:WT?Wb.@DQed-&VYg=)aCXb8MbHaF.P)X(EO06W<E(+1=6\YfTUOYaOF0(Q
I9OgW?KV89:(/2SJ:(-+STQQJQ2.e1-1RWM-4QGW__UP3.IdRWKeLU)3b/DS9NND
&Q7=G19(g[],[-X,))T>>UGQ)K-^N)?ABc@&LC2H\57W6H7<E<H4[P_RM?HbS-9H
XE?Q2.3baV\X4>(.c-GN&.[^Pa+c4,+0)e8,023D+S&3M-gFC)#7aG.N<@Db@&;b
WaO[eedb;^C,S9SJOcScRC?cfT^ad>I8eDW0AVRRNf-5<I_^?LRF8<UOH80;(YZV
GS@<&-P;VG(b8;38Rg(W)C[CU>B3LAQE>cSJP3]CAR,0\/J(DccL^B&4fZ75K,NF
cAbK^G_fY?=?TV6[gL&Y_g2RM0UNUcMKQC_B:6965O.9bI]7Df/efV#89\9KDf#O
-50LL#4C7e^JX9fSeXOd]&1@?g@:_X:NfBeA#bK8W[^Z4dBW&[Lf@A(fcX2E;<>&
S</.@ff>Y>M@BYYY/_9CE[c9U1DfL06C<cM<c?4YgJS^<VO[\VRX7b3f5Z./(U,K
A/T7e9E6W>6Eb@B(T+^SW2&gA\56^^XEGdUMRNGY:>cI\JXU&A(I+dYZV4TF73fX
c,<)9BBN.&\^^6A(TXKRD^31P19SHWeC_<Z)3J=+SX8HdSXJF_8/9P1&]\_T9AJ+
L;=Ta_:I^/ABU(6a^@0Rc,VNG:GaMP&SI((0KQ61-;Y3OO.<E4a(c.@Of:=PAHAJ
4<W.D(BMB.VKH9H&VX^H=KMGaT+HR#.2J8L-5B:GO9S+345f[/^TEM)=I((4b\6E
5MSOIJ&UVVA.@2/P]Yg/CTFW[R9Q#?)KS=/.a]&YN\T<BGSY]eL6=K\#&b35K;c;
c+^4#RdIf[d9-(+X7D-WdLGRFXL4]A4+0;-ZXBJf_A#2b]+Q3OccGKbUA:A#S3<R
S6M.^KZ.1d)YN&B^<ZX^d0UgIMJA3KWX[]Q2gY?\_?J\Q)+Rb)g_U#P9Ye72BQa-
?U=B]#B.E95?dO7[;RS)]-;Jg.@KS6:H/gLGJB4dF3c.ULN>bgELKTF[BRV>=2,F
I9.I3Va3?>O8\HB4A35Gd^5e8/TSEG=A2/O8X&BJ\DMR4-^]7<W;4@;Z,+\@T3-5
c5<#E:5gcJ#FV&7OJaSNOE,ISe7.>?8]Q0gX&MVcIeE#5(SF_gX#b^0ETcZ3Z2I5
,c:[/#:L+dd1V1>4NV9G)J;S(70H-DX7-[<LRUFA)K^0L8DcZK^F?T5)G(MR9OO_
/EUKd?Qd)QGI^SZ5D->fUSIK=8C30>aF)#&\OM_K9OWc):VSW;[cL\Z]Qd&A<?\+
Z>H+ZB,=.UP[WA7QJA;2S)8VA4LP;CADA7J<,W<P+-f5d)LC:bfa0@PU,U:1(3I@
##I[6d1:5]a4K+=DQTXB922A_V-eFJ((=):I#Q@YQf2,;.J^fHIT9)EeIW[/&&<L
=P,KYDB]3+G+N]/UB,-J^I1GMf227L@76<=:aEADG>TFK)e.K4e.7NJ=LNd.OH1O
.8>6?QPW)>gIfUaLSV#Vc/YT\[_CO8cLe)K0>OdV2GA[GR#Y_[H5/]@cg&:<49.C
,WS;E(S@G&=JT)P;&EU[?7(AM<S=\d_;5B0/b]2fV3S>O=YM:R(Be_5c[\6\^(H6
:-N@Z/.]1<d41QdPIB^/L8.O1=?+dgBE2(_SSE/F7/K))EKU/\d\4V0dKI:)V/R)
^UVM10)WE492)#_XME[C_>&7D&ALVKK9c2NACe>Le9H=6?K+g)Df\,T?(Z@RO@BI
ZNU[a.D=R=6&#Kcf]T:[L&[=RKD1HI3g<P_B/e/:G)Y>8WRMgFU5.Za;3SN=#Y.-
\5E7a+aQ89.2[,_+JdR;=/E40TMZO;/&/5I\:;2FNB_/;XEA+)-MB+Fb?GL3geD9
b(RG70JUR,bXCOD^BY[])287:_SN)(B>.+:S,F:3ZKD:;a]U[=O[;5845RFFBF<1
XKDA27c4#=]]HfDW>KWC:90@&G#5RCKH5fT3+IN3PZ6X^-9]?G^KHd3Y<X8;F&<+
g[Y-[T7ZFa_TF^:B\;Ca#A&d62JDO^I5T:gI&f/C4\2@5J-/Y<\fc/EbdICNP(b@
dS;G9e^0#bc;<=\1[U6YR(UfEGV>/\@]#TA2+)[1,-@g5>78NO;EaK06.;M<V+NK
ECE3VT:UG#H8#aON?e5?Q;.K)aGY,PV>F1<;2EAbQ[2(#V/=4YV_03Yg/>NaaF#9
O:COdAE0BV[=KP\(OHP;dM&=FEI5<\39e6<9CW9)+F2+7,:Sd71gY:#;Mg0MU(F1
F8aJ=KO4W)Y:Y_EGV1W,:NIaD:RQNb[W&)KU.ZV=#:><bTSb&=U+W+IZ(\H[gR+A
aDacVA1R(:)&U)5eGQZ&Ae#OC=21g/W:5G9497T@0(J^_H60]5#<;O(P;5F@BE)&
+ELJ/V7&<_H1KJ&P2SedUGFQI=Bg9:abEdQea^^#WE,SZ@JMCN&]_36Y(>?TA.gR
B<V9,./2?/e4VIF)^dC@U=A,U3111?\4fbc&.AI(-=25D63Y>-3;/X,4S\e6Q,Ce
bCX8D.Mf.dY:8XX]+<;5=,\g;eb&fIRJ:e)PA\SQ=XQbYb3b&acGYA-?I@([H;(g
?c=9OFI&c:aP8.?S7K@8_).COQa?OAC\FUG>#X.Q34_[ZND/QePOB\9MA/0+N:Te
Y,G:AEVD.?5I_(F>-\IFMRNL2;AI[gAC()(S0Xb&;[CWF47MV4N@+XE-\VGGEUE5
W@0[C6XN&9@,COf#,3COb/5CCLCK?KGE1XaHT_>S,PTT&5Q=VJf96K(&31Y)2/OY
cDG^P2QCBSOLHOTNBGga[Ob4RBHPHK]LB_+R:A2gKc0JA3)V49&f3aEL;U0+E#BA
WLDT2X;X]3V&2gZ4(.8OG03QIPDC>MS1MN2HOYIMZ5B?A[ZO=D^6>?Q4?H<\[SBY
8V(Z[9-^O=MM>K+DaZOP:aO/OC7&?[D))Pf9a,ZTZ1H=?(1aHA6Q[UC:dc^2KgOT
KYXReB,_&ObCeX/I8LaP+KLX3?((V1N#E]_LG(M=U(8:4e+P+C=gV2GYfLF[05##
AH6e)N;HH8Y7CNGEZN+6c8_]-0PT:N.dJHEOXZ#K0gF].IF8^GSPeY(c/3CHZc;4
Y_\gS\KJ/QJ5;^NfMPHTG,-IU&EDS)T931KT.2fRE0-4)I4P/ZdI<dV.H+HNNYV\
,)f]UVDKeBX28):UH>2]df37[H:Y3>D\e/]C:62WV[]V5LOH7@J]BA4b(F61C4WE
+>/X?LMP.XV3Q#^?HZW8YS,4bXJT4f_1Ogaca\D)CUJPe/?^A+TXHU[GbC=)g][?
NO9=,R@497d0&>PVCgBVQLFeD>4Xb_d.+S]1fQS=Q.\QP8TSbe<KaPd#<FJSBENK
2c#&L_XJL_cFJDIdNBY3b;Cd=<[PE]W\U7eON(=+1KFY0LbNI#eU\f#WI([6.JfQ
^Y=eJ[9K98F-aH^IB7IS-ZEVd2b3B-M][DL6/6SMQ-X#Zg2@K5g+a@.@g/H67DJ>
&2F@G]bH-]KPCGB2ZH\Z1=Ac9_e@eWC8gc/]MNN9Xe)CeQ@\:I/9=cYKa-4\8[,C
,6ePO+1E4Q^c0[Lb6D[XBCdATRGE.@_[bg:;RHW.YVBSaO/4R^SPF3/-(TD1>PI^
UJ?P^4LH<-WMU9I#[T7YM/_BQ0=Y&4+&R@;^.U94U&BHYeBeO<-(<c>X_9Nf_2^.
V;^fKT84][:C#=\#XE<B6(]_,&2-2#eB-#+(6)f<RHdcL&&J1+E#09a^JXHZ:CZ\
TZ#QXL&IXO&L)E)X[7L]P#K,U1cDP/3g3,f_RM,.f/T5G:dV?E8O>]FRKZeNc)MT
e3c)A1e&B;d@J-Y^L2BG+/RS7=M6);.<J[ea+[X1JLSRR4P&DM_[:],#GZ5JYaH9
1=_f@dO9b7;MUJQ>U>NdeM=D4AHC[JP3MXUJ:3_#DFQK,1A;N2:dL7T3?PD3K_I:
D4fRecX_R3c:&F0cBdPO;P;>NQJg(I?J&G,LZ:OGe-U)&(5&W#78F-,YE][c=(CG
\\D1gB)?-JL+8ZI]K5=@1LWK39BJ^SZK]?e?f;V05M.AO&.:D:(MN0Gc?UH+?]g&
1;@WO:(T[Pe,3gFBL\H8@9F0MRQ(;7&=9&,A:V#Ngc&@c1O2Z5&AX-&I7;O.BRY-
)E?2:e_F2#\<;(8cS3,G/g/EBR7Y3E?(XM)HO+UE88TDZ_<G<^)>@\(7LJede(W1
d^8&.-cd2a(eT8B80bV27OP+R:MX+aM>WEWTQ]CgEUKXZ@aFQEe@:3U9V0aULg[6
94NW?N@SGXIaT1e6J-@&\N_;6I^:<\:/:4^J]KMeBPW&DB234ZNE@E<JX[40-f&O
:IKG]^AS3\-caC:KaU-(0<W^g&SN^J8Bd1WHa;ZI?bLZW@QUa;#&0,WWH_.-D09Z
4f6]&(O(IV94,,YNNT<a-U6O2V5F,C2PKW.gBT@([(e]FG^3CS?FO0_9bMI9O,_J
1Re>L]]TZ8bMS/H=6YeA:2UN<QT9bMbN(&OVd7H,TCeK&X-1Q9NM?1MQd;?#W;]E
(IFHRQ;S/:;3K&Z8:CE0M[_H&XQPPg-&AUXH5.>T&<4&;BQ3JBf:TD?\5@.;C??A
])>\YL@5S/I_X\a.L3)X>WW[QD[Ag3>=Q^&<BR8:HVYbSGAF?:L]d@OPLd>AdU2]
BWMU)OB87.+<MG]3](Yf#67eU4ZG?AFDE\?^9-a\ad#a/XOK,B\eREB)Z[C(5+/M
fB+)MaJ3?=FS-KRQa[0gd4FFKgVZ<#AA_#\UO^VO>YH7>2D/6cC<+YG#[\XY(()R
#RE?FD&5a;?(dPV;PW,?b/g7+b4>MQcb@fE>/(P_P)Q^)T_#)\R1>[F7PCP./16W
:g2_]DeT;:F_[<T]1\IF/5MU>@FKH4>_B#U&LRBN\FH)7Z5gUB=7Q??Z7#a(?fF?
S(ee&UbT?g]L2.[GZ6L#MK:AK=,>:A#FR0ZaN[3/aDZ_-gM_ge0#[3(Z:0CY=bLe
=0C-W):&3Kg.eYBC-SQa.D2#d4bS)d=UX#Y;<^AFYPE8HBX?+,+@_[>LM:,0c#_M
dX&(6/\0^?,)4H9I2f_O<7RdE/+?IC8a;eQN+1R.70f@5cF7DD<d)/8S@86Wb@+L
(\eD9-E?[X6=7/>2W_X3-^=4_DK4fX>IgcN+:;Z#0CQJ?f,0GcD^):]&cQVbW;8^
7Y\=L[dFaf;^EI\M1:D_Z#7_.7HA]MQL>7O8^=G;a=\FTQI&QF?,EMVNQ0FYPQ,W
\/(S?XKe=^X.\f#ca\6gLC2Q^>PHUQ\0>g+3V:LU397AQf&g-0FS)Bdf>^\f7>eJ
@F6)f4^&4XPgD@bSVKY^IP4<:VIWG;Qa;7JRZ0M^=EOaA)&GL(#_E;JN)Y6T4PRL
;G((2f_NWY&e:IFW5X,Ng=-B.M>\E\\U<GQ=.a&Q2V<[,7V?ag<-,YK@[gg<QTLZ
\2f\eB/F#KO>FQHN^5I[]>RP<J\P:-/UBDW)56fbVU_c4^eLMSgI,5M9=YW-ERA^
\LN&/8TT6b,YXA.5TZFJS^,[cN?^=T^SB8c@86N]8]&GZ4F+1HY61=T[Y_L9d.1#
@PJ^XEL3bQ?XGE_+M90EE+Kd3E4</BBB#^T^WI=(P(,G3bG7A+(0B&K-\G0CXQJ#
K]NR>XRD=T6e76H#TeM7R+-0,P/C4H1a\<H(ObT5Y3ZRY9CA24K\<53UY1GcWgGX
:^/8,agKB1;/#Nd13a?I6CF,@O>4KMH-EWV1c]eNcS+K-^Y8f21:/H@CD/g>YF9@
D=,.65c6US:BYQ&gY+?_.A]RHREcdT&9G0:9;7M83ZIgScL1bPE1&NH2Be12PUM-
AM@.gECAP,9O+IODG]1P/@55f#0T&-E3T?-PQR.IHL^0:fc[.YE)/0+f#2TdGbP)
:8ONX]9d-+H0M/YWAS,:Q#8edNGOa];K1(cgX=.O2Pf</Y1VAdLA?&2Ub_X&M]BR
BC2)fM,L;G>M&]FcW6f<a1\KFEXfKF]27H7BOWe9(f#.#dS>=W3#<dWFcMPE2DX;
R7RQES=WIJ]BK)<1Z[>\1ZEE-K?;Wg>SG&QUb_XS<+dc@IA#E:_=DUKAT\,6-^fO
=BC&[W6:d/bc50SW;04b>K+:e5>E;.E?S@2[CdAdEC?e1b5de8N=HQ1DBV@eLWSH
^E,FJ0L8U8[GXF\4^7Ee.4d1a<&:,-C\e\Cc89eVU&[e<IO7eA2cb]==N#HNEaL?
>TU4-__^=Va2LIUTXAK\DC>2;J6=&]fMD92E:6ee[OYFL<G5D76YLU&^2)=@LT4X
<#Q:?GYIXGM@Dc_NfV;+]f?T&DRCeJ^#]K]c@HQ7_>\GdAH#:0?AD;aF3eANeP-Q
NJZ,eI0H0OCX98I9_,<C5W+b3A;)B^_8BZ<(CJNH?0AC0)]-CHS-8.9CY;I2WH[W
ZNbPY-dEM@:X2\2d#=U3e:5;e8)<(@_4_c?AbBUO1L0[/J1&fK&OfXf5(SYIDV8S
-J6-6CHDe.d^E((I]RCY0T_QA79^#Q8R4H^5-/X/RNbZcLCR=TH-1_75C(MM]5cB
/G>ScQZR5a1^FR6H4TUY]\KSS;gD]<NMQZ#N8RcL)G2>KNF<;.#U06#e<(V=M9c+
^A:J,IAO[M9Z<XFF9NT@G?-+eZDH74U:E2H/IA9FH2_PJAbKe1AAV@^M:&:W#B4W
)JSA<@CT9J-B\:4[.aL136<D46]9+d+2dcT.&\0K>]^Vf6W2MNZ-eC2^R1/VWD/7
acJY3c)&L^f2@3C[,?5THA=cMPT:dT]0^S&dAXG+[SYYZM]g&g;1f^aST4POcPd,
aKXf(EFeXG:46\:9CY@4DAKL\cRL6fg,_+X^B/TgZE_8F4\E/2-<:6K76^9IC9/C
D1#aDWN<b561RECC7C&-9/Q;(C\&=?^=[U?45=8=P;)GW,.(L)TU.,RH:\d+)\S7
[,(d0W.AX9B&Y<USc-cO1[.&KH5+#X-TEWWgMZ.LN00H4-/g2=WA-72G@)U8@W?M
4L6S-O&F&g,G(L+;_SH?2[41FCg=4=/eef1(;67;4:RK:01?Q.513\Q<G.](N/>?
F@E9[D9M+&OL=GY5MQ,-UFY?/L963O61B2OIK=UC4[6d;8X:TSK4M)N4;LaU2b_g
X@Q-(#&F_^9QXWXNg(G>M9@FL8Q#A\D-851/_=f7]VZ@CWLIReE+>6gC0_QKBV8H
6EUQ92SUd^gK>@&I;1f^JaAA@9DH:\#7S&S#1;AKM=.#YO9=//?O>B85C:]W45NR
N5fO2[I\Y_gbC-Z-\/XCG8GSf]6:ff>-GFU,b\?&Xe-Mg9E6./VMgNac574\[)]#
\=;-W9c:_OCK,CHJ<+4W+8CcW0D9BWb4,SIHH>ACM>N7gdb>3dK>@,8#R:J/-26;
/K@eU_J@SS6#C4R;_;7>:5+339+KO,;[+\4F=)EHE@eC+=8g4(K2.BY\J:fISR8A
17)a^R^=Rbg)Pe>C8Z&e;RA(9]\(+9^/D8U4+U2.HX0@D)2ZA3dZCA,E^;\1IN(D
YgU]Y^?@\=<HN9ga4AA[JH+&\X.LL-:D9#WB.RIbIKFP<Hg+63/2-UN=3YQU^5=(
R3X<3=GY#BPH:,IT1X^5RH7_]McM\/=@H::(<7NgbY.5OKcQL.,/TR([HfS3_CD_
A9I/_=[XW)WRA#EO[;(_24V4CA,&(fcG?O\aI-E1[J:^,R?I?<Y9KgS\&YUOKDV0
Y<^&JMZ=Y<9KbQQLK<1eJM8)9C.ZE=d:O>be:_J,+LM_ROTL_@+IaO,KTd\B\=GL
g+R/UF(6=JH9a5FIN+bWf6K/a-&4@c_:DHFf=Tf[;JS;XKeJZASJY>CA0>K^Z,.[
eYD4[CLZ)C=J-)WBZ+b0?d9@ZXQU1)TW)19YNYcQ<A;;3+9X+])W<ZU9L@(Td&4g
2LIR2:a8RBJb[#6b3g.5J8KRB3aaT]Oee9Z2TaK3KebF1#?b<GY\RIUK2]67[LMb
8R37P(O;Fc7FDAH<E7Q26YO2Q-a?Y4F+/Y2?OP-?885g#/;P<XE_a?;19#NgP4+/
<RQ+a)]@)e4+^2a2gC<@MBW(IgSb&KI\IGEcdfLXK^b44T\4bc:HCa^Z=Z#?@XW7
PV/a7a=b#Y+0fA+Q4+c<Y3b3,aUZ810BSX0L.gXN04JM)A\)-WSdF3L[_UY)>aa>
g@F;Sb7GgeQScAD-4AZ9(6W#KIT+:B#G6d^TDa+.Z^0)g2H;.C>HV9a..-;.:P?K
<N[<S8^1b:=2V4P_@30SPWLZEVVQfE0Je<2F3c.5PYXP:_]7APW1I2F^5HO?]K88
P9VGWR(<e8>J8E/a,@#4:@MJKgCE?+(X)PXZYN7e@WY6B):;OS/PU&WWfFe=-7:D
71+#6[.RQT76]WY52b)Z1c>9Vd]Z4,)e6AV01B)fJ6#TSdOdOXf?X,g3;XG#GF.5
T@DJ4cPFPR?=GA#/)=Q8O=#1_;)4Y5@YS69VbVY@VgN0/M(8A,9;TNNe5g(#N[O0
RGAQQeT3=X[MeLCQQJ68\(8Y=gNYbeVKF)942\NY(.9I[[R1JG&I3&cS^6KcQF(J
G/)@XS,/c@LR;J<R_W[L6G<,=:[D+QY5GB813eEg65[3;&+0SRg/R/EAB@==N.;;
caIecQ?&G6C=N+OVD)Q=._F#EZ@V#F;9;/4IU_6H3NBge,^+H:I-4&L3_MO8\TI4
Z5_bS634Z#)6#SRGYS^[Yd<Ke^^c5F;7&USd3FP2E^5bP)KK/=?&9&=,AbMVM^]H
;)WDYQc\[83>:KGV^P-d[gE5bT;G/eSJfVM_M-.)HQ?Fg?3.g#DL-S8WNOZ(BRQP
9b76@KQYUE#LP[3.ZS/[?VNH>V4S2HT.TWR?\b5R9>Aef.-^+6YXLge@WbM66\e&
BV>gPT-;N4GGF:fUH>N7:5>2b&<F+=5A;P(6c>HJ7H3D5a^LZ>(ZcG7R6Y>KEME_
^_^gPTQG>H4&dYg<;98WgLgfDABVe0+JS;93I9Z)X@U8SLPWZ]W=LJ]@G)fUY_(b
ec:CO(a,PE_T?QE[N:bEO&g59_KS<^ZKC6La=Y/[A:=>]LfbeKgJ6d.H2WRV(&A[
ddIf^5YXcW&MF)+]55^GfP3W,\OM0L6B2ZQ@/;N;?G_AACQ3>./d,^b(P.A<N9]D
BW8AT#Be-LJCaD25:3+gZW4[c@C^RYa1d.c3EU@GF7ECWQg#)T?R@6OYBO-EG&H_
Q1e(>S)->A0F9b,Ne=bg.S4GUQ=X&/.Z,VQ>HH2J;2aP]2RQY:Mf+V0FSH5:AO45
2MJL+J/P67QfOE<?fcDWC3@/;[feYa6]3c4U3ZXK7UZ+<b41(:7c3Lg<UM-^5)7X
bOU[dSFge)8S2R^dP8ND=T^Z[c)7:cRgN&?R7Hg-T9P4&#3U4LZ+T_77H?6G.O5_
cOFS_4I#1d9<=P7G)J5]JHHZ.9^PE;[C].O)a#)41->D\bSPcG7(cTdW6>bg=HD2
&Zd:,/_ZRC#e,I=U0+FNgJXPS5,.;;H,-D/dKNZKd/YFGNL[=0Sd^:RJa?;^=:M^
&(M@4.]da872HVb9TR<DR[I,6S:>YO)_[C,cLVD2WE0NZ9B,2?R072(;7c+dPM_X
gPJYR4Y0B4c6O<LeA(J]3)1FFUGJd0C??5OdU/NMI\-GfPH6<R7K?6.GB>6&,@J,
[gY_SS[^6K/059:)GA8Z5JSE)J1H5Cf=cG#Gf-Q;b6_,4Hf2GVcANDeL=4@#C>L;
>9g.P/ce\Y3:Td=#&6>JQ)84UCYYA\#:c;2YO1L]AAeM]2;CK(CC.#/]N2GHfFgW
8,;W.G3G5f^/S3XI6VCU.?(NcG1#G(\]^g4=[Jg]MTP),g<PC=R^,:IdJ<[?Ec4K
]QQ6,\E]eITJ4?C/6&GO5L;,gE7Z7C3Qe/eV8=UL[VR\Z8F4#-3(/Z#5_0S@JN\>
/]8KA5YNP@MU7I#E9CWHNMTa7a(0Wa>?MKBL@Eg5OC25\X&8T@&.<9^P5NZ>H_4+
VAdR+b4O:/)8H2^.3BN-,R9BRTE<IX1^,WF9cA&b</A>)]bE&,BCQI\P@d43Z<60
-:KX<gRYHeX-8cYXKMcFT.)3=7X;^NES5>?0_KNRK/e+[=4gHY4(GQ[+JA4:[f#B
+H=b;(#?AOXWd9bN8KB\e(dQ/WG=D0@P&aFEJYLE1[6<YJNIC<:b0,dG@N,Q[LA\
K1f+7T8,gF<L3T,A&?]OC[6-2B=-VQJHV;(;2A=\1W2^BfBHM?\GP@4N8e0=Y8)A
/3]4AI<8?g\AD#P/L3/Eg4M45BYT\IFH\VQKZS-g..32PTF,6)-=N5IG4FY9D&8:
TV1@:.8?[D&Y>J:IE?a?PgM6<dS(.(9WQE.KDKK:RD?P+ad70HC^@1P\W3IWRY+:
_cbI5T:P\/=f<9L=6^+[+L;QW=UCDVT9^UW^<eg.^I00_a_8#JC61bQ?N/4IQd0I
1gM5Saa?OP@.&4G0L8.E\QP^=&d@c/\OLU.Wg/8#IJ(c=;3TF#P:#T&P/463::-[
>6W0RCD;1g>\FFdPe#>Q4-R35Q3,(VO[]M0a\@RKJ\STGE0C<+&=7XHHG?(Q2M1>
F_8HP)FN4++NN8cNTdY2O+S\MZYX>KR(_NFKKgAI=f1SGZ>6]H>3gII7HSX21AJ(
Mcg6.FZWSLI^+?D+C?0P+]&JJOM/4^HQ?ARVAQV>]<g1X9V7eNY[5;X:6Vg^d19N
Z]D-_4g541X&RA:bJ3Mdb=e(96<\4bI\Ygb>\U@.T+=Kfg2d:e7D#OD-O5a=<+dX
gfbe7UOTf_2VB^C,=#6;_TWSRg(7aKXZ;U9&32(cLAKfKUc48=G&&Xb0;5b=Iecf
\KNU#ZKg(d)=BBf+?[IUV)?(#^ZbUL:9R5J8^B54AYc@cJ8J-<0,B9<082IV]5)+
J-ALL9NO_PMHF6&H)7TV^C#K:0b\9WQ)TX_NB5G=.]P#?O4J=_5PXW:4Y,0G,dg<
:4+=IPY-Q>4_=PG#UB]9=b^#R>B\06Y[AC^MdUH?-FA^a-+42_GD2Yb&(_XZH8Z2
OX<O\(<g^H>&eF\]&DU&5#UJgO[UgQF+0VLb3M;IcWcQF.UfX\8NO+7]27O33@]a
@C8-\7D1G^PE:A7.CHc50R+UU9>R8FBd+JQ-(4cVCCK5G1^9&gb6C>VR?N:cBB])
];Z>H-(G5.(F(W9ZGWVG1d2P+@bIYVSQTU:44M@U]F1b-,E:F?;Y8XF7NX&BdVQ^
?W_bV>[UIFI,^VU0&L1A//VVNe3f5E6.eZ2@V85(Y#Md,f16MYI8N)>PMF,AX)a#
A7A7/2B7<JUG@U)7R.V\a2f9]daE;>.Z;2147b&:@MZ+dC0H6YUR=\e(eTI5\=5B
:3&)g-+.(N&BC[>=LZQAER=Nc?0;Mf1CUba>W#?4(C=W9(<&OE?IJ(V86@e<I.Mc
@@&c_?c0SE:^TLG<4SDWRf:O1F[F1Y?8&L^T,ZZ3CG;PH)HA.IPM^)b642KYHZ6M
DbG/BPa]W[7Y4XDY,:77:+(YO;P5Uc&>:Y)E:I]4NQ;P#MQY=J4afS2D3Ib?,VF>
DR8T.b&6A/T(CPWSDPN5),8^RZfRJ3+8LY##c3e)DC4[B5?>QTf&_.aU,3-]W:^6
:DF,OQA-)O4d-_c1]FXD9WBLdS4b;HJebMaL>5<WfM/5E?Yf#I+C4&E#M<8@5Q^7
RY_C565gDMB8:U>=IGLHV/?ZGWTa0C>.c5L@;):M#Z<]KVV8E995O;1H^U9TCc;=
IOUSGc.[OYNLE<HXNbF/1:J3[5E;LY7GA1<XK=)3Ia]QZ&RD/&@R#;K2GLI1dZ<R
[8.MC?;NQd=PN/-X#H1Ub+[\8f=E-cf+J^R6F@BN-d=9)M]CbJ1SCS382F4I@3\G
:0XIBg/5IH<GHZFEY;_=U/-F[(]A1LdY1@JB>QU7EU[6E_.I]TX.dB.A&7TOD8AL
U4)1:f;4W1G.cHf1Z#+BA]DNM0H?aVU>cF0Z(,.?EF<7U59<9_6YO#Eg-[HbI8PK
#-O#F2OfB=/a2]LS?@E&7>:2G69Ff]aIc6cSC7KHUT==9L2U>1)W:I4^@47E4f(g
S>&-@^M6a]Oa>;(]NJ2\,I^#F@[3SMKVD8b.d?_7]^,HeH;Q8[C?(gKSNXUB;4Ze
6\R9,J)Ue1&fU&>GAObKOHN>9+SPLa68[VT,#>,<9M6KS-5YXX/eQQFb0V<=8>_?
Ff4I,]J0G;\H>fL+>51[0UM_&Z]1UMF>ILVPF:6A:?W#;^;(F><gTec<TH]4(@SA
gDDeLe[.>YKT2GH5VHE5PL0D^;fX8;g4VWC@:&D+S>UeRb6QEO<X;,:#161/b_F2
W]F[I2Z1G4Z6GMZRW4#,)1CY8H\?e10^+7MOgFS[UWV\aMeB5U[D/>TfWKH+9Ra5
^-@QF[,5EfU_PcTB^-+SZM9?YL((eN;_?1c<Z/W(I/:57=VM&YL@45.WI6Bc5IXd
X-8,\eWO=UILJMN_9[E^]g>aV3D]]Fc>L>T,\(TBdAP<<EJC_//W@\&L2UX._Sd)
Y\UTB/9^@VU<>S4?I_E>TA/?-bU/.=YU19bWf62:D-^AFcL3?278L.\FcKb-:Zcd
(1]dc#?RGc3V64UJ^bK;AFb<eX,Pb33:&7N91CDA_3\NR;(:_V0&>1aB@6_82<J3
eWD#_=Kc+#IVIM0\3@\F,)IG[RMAHX5c3>d\;VBS-K,(MX&Ea=fJ3f6OM^Z6]E-[
N<,D284e?4WB1071d[&R]Q8Z/GJ1,H9OVgK:D^Sf;0fDR[W(@>Dc0Ldca+fQJK9H
Q+YAPZSDA):38OF9I4Hg^VZUJ35BdY252ZT3CCP5dVT<;XU[;5fQL8;(7F<dO.+Q
M2c#W].ScA=bQ9_J/Z#1b1/E.Ba2T6<aWB\a+Ag)USBV1a4E1Q01L\b4+>R[<WJ7
a.B.#5cUQSIP],LF27b^8@CWL2PWS?/AM??@M0ZC#=/5:EXS77G2,V(7@-GKCI;=
J(K&+MZLN<]b;TCGTBcR9bgAX7HVL/:Lf7I9:HB-))C^EAcUgLMdK(d6EeW6?STD
0],RCT;-2230]_J/23TfYVQRaX?a7]^LO(,46[NK+HUASEgND/Y:bXR4]DA5b<dc
=-CN8U?0],I/#df9eT0IF_?N1Z-PMEFYCDFBd^=V#1VUDD/BF4a,:8D>2g;^_c;Y
f^e>G3MHE<7E=5CD)K2#1I;B<c=#J>EO+2^YNU0J6M=IJSQ85f7.ZCa9ZC?X5<d6
N\^(=9PBb+G\AbN,aXL_<+CTM]A8BKdAD\DW(B/L08J^e1>/];2FU2c.(QEP_]+?
ICEGb+M3c:]#\Id;,,3bT+eEJg93,&PEC(]67I@FGg#<]MMDNfEbYNZ.d18cS7+M
=V&)[^Lc/&VN@@_2VT1g(KQ8<&Z&5U_8.U^BSDL__>IfJOXH^)c)B47I3a@WM8F6
.(a?E4H4HBV@,E]Y38+Q(L@]d<VG9Td7\5gGC?dG9aO.@8-1XY#4fWOe^+Q=;NX_
B+(=>\eQBN6E8c0N]AgX5>Y9/XDC1V7eFH8[C2dK5f6:\4\<.245F[>Va->0(YYa
+g+TA+YQ\P12=N>.Y135)HXd#e]L]P#LWTI29.UOR9FN5XZM4/L_+Q;Z/BdV0F8f
W\LSQX0JH?(VJ3d1bSaZ2d(P(JXK/^#T:e(K2<6KNXUS?807.bC85:C2<d=5+&1B
^-C#E8LJfe<c6VF;)dA.^&cTR<>/_bLG4e1JMg+]Y3M+S_^&/(T;7SVe_OK:G?3T
2=AEFe6BVTW77)I8Q;:HU_J(YVSe,a]HaW2V9U#KL^NKS@Q0-&RF:IU(4d0HF=.8
fT3Sfg/Y(/-FYL3-0ZRH?.5N,-+2H+O7V3,:97-a2eL=PbE/f]B97dSIYX&K&&b^
DV@?W+.+c66R[cH3M]^::a8[#T7,PBYGOONXbE:\&0CI[#Me)GGgC):1f0A-9DU/
<c9&)HJ=g]_#TO.&d7YfUD^7aFcE9C9&OUQMGXcB<a+aa+cTb&71bNC3Bcb29S0B
f#W458S5H:K=8d6Y8F^^7d73XVd134Yed/XB7;^]fERJLS1MI,#03ARN0b;ISVCe
>#Ug7=,T[0Q97V1))e)<^aFa<cU]aQJZ_^I/,dF>>WLR,GIG=\K;^b-^e,(5606a
W^78HFP[(K5U8^8JE8e0d(>b979HOH:_F]7Pf3V]<Z9cQ,&C?&GOc@#Z:,9-G&IR
F6/L?VcL^-d]D(WRM@V^UZNG][)^_5[.aIcIRI[c9g-X2\ILdE5D\3&cXR+6BEa,
fRK;T6_;eE0&46/,LVV=If+UOL?1352ARfH)P:-.c[,)e2c,J]A(OJE3-Z?:A2X,
8HG);MBfEc_b<=)2-2e@JN]Q^1E&g#Ne_,;dG/;9[]G_?(\<.3cVS61;8,\fRU>;
>?0U3]]8)d/@>L>9aJa9:Lb9K#X[KS+P<HH)=a>Ef)b5]1G-IXcLYL;D&LBYS8(Y
dF=Nb]:&a567D.3<9JC/:Z:dPEY<?HQ7Db?LNGXdHd2VBSg]b_K8gL8dSZ0HPU,4
cQf/.)8)B&d,>2fS.:(AK#R=g@9^I_S]F)35DQULHb[TK\7a).&AG\>K#0B:J6Jg
3fEW<5D,).LaW0Q>Z-@eD)Q?F7(NVTfe04923)K6L#-7SZ5]aW;S(fOI&Y2XC^DP
[6-c.gR=M(0C5PMI&[]S,9ZQ74b+0W-Y:G]N3b,BU<U]H+A]=V?eQe][#?01[YMP
I?:3bFT-fQd(A+V6ICNaQE1Z_P8/#NB.fR+HC4>dMXB3^TX2+P?I0?).La\CcR+R
<8ffTK69;F6LX#^^#S>QJg8EW5Gc]Y\WQ2+@85K.3^99C.(SLR?1UYY].EJ0YbUS
>TJ&]B+0V&bR_\\KKP-R=^NJaXYN_;>HMdAM]:=Me3GK+MNM0,6V8F7@/35+:,H1
&;H5KJ5-YLVR2e.X>JEU50\<1QD.<>W))?<</JG]\5?^K6B4;NBQVdgSKeN[O,?+
9@)A]Q@LbLC@^[FF0eb&R9b:1NDd\1I.Cea7ASW:9:O(,9>XeJ<0IX[0QeeNg6,a
@GI9FVM(8GcW)^QK_?<ONO319gB]P;GdZKaAN_ZP-.7f4,AaB77\e9RbX2Re:37J
SM#K#@F81?.2K&+H7P<81M_2J[Y_[TbPH)(5>M>7]FQV72/)B8cD_<0^NT82O;:G
1OHOY+E]88S@E#G(Pc6g1B,M2L&RLFDfc5YbLVPd=PdO0J2dU&NO1E:R9[X[fM6-
QIER,2>X3e@VQHeT6+EX]PebOe<:fc:_;&DVJd75C48Gf;;G=0424D#D^D3KS>K]
XR>-C?.618BWW723SeR5P5eHO-#&T0(#DK?M[/+#9TO@FDYKB3KaeHQ_\Q2R-<B4
JF,61H8C@-;(gU7ZdaQ@Gd(3@MSGF7c1NVOcg5F=1C&MKT?\J@XO\B=gMYTg]D6^
aUF6/,S;P6\^C]bSI6WO>=64<05I[NIe.Z;FKQdS(EL6Pc2U9?_e.@G;D-,R:7@@
)SRP0S-GH._5)(W1Rd\E+5e8]+BM\J]/0?P,9APag6[B;<T,D&?/86N^.C90.4,a
A8T]157/9cSGWPI7F>W6b,>8MK+E\F9&d\?NIadg.&&LLCc3W9)b]AeD18#):H/a
8ET\WN;(e7:@R>J(Z,g=W=\E?3B4X-LU&&LN\eK^eEf>5gR6dZ5289XAd1R,&W6L
CeA@#F]b[M5MGYKUZKe=8b4/0WZIMd_O;0M5ZZY=adDST:QeNK6=<JBT;2UXOHS_
NE[a:d+DI_Oe?=ANQ_;3SNJ)bPg,]?cV@US1VYV7g\J]W>PV/D8^IgQ9@K;0.HY_
-@ILe\.X3<K]g#(H@F<2]O\6JJOYX&_LV;B3_)=#M@5C@^2<<Y<12BSSE2I.J9UJ
.OW&GQ/2:YOH8CbS(BT&?=YH[d>7_(L^9A=Z_EcIP(b.W=YMe\IZ1FR.e3>X.QUa
>M.HI;1\W212bO>.b/TRD-CAYTUT[eROeSbOK)=8<P+0bF]XfC.]RFCaDV6I15L;
[I@#8IU[,S;-&,5gEK]d)-E4OB[@C;B(VXXIa0Z8]^F4f)P=5,_d[P_8WB)dYG<^
KLaTS4]aT_J&I:P_aOcg8&SDGgXdd>J5@[U[:Lc0fd:NF=e.dMBcH>P9.\]3:-N9
C44,AQ(_)2ObO=(6IcGT3+._2,3ORdY&Da,2^)A+LNdJINg+\-J^M],c\.I:Md,]
VJ0[8WL?Y5U\RRB<1JDc14-<B@GBV#6GDUZ#G,;[HKDX9Pb_S3I^XH^-HJ:H4LXD
\RceeOK>McaMPZf_E4\Wb\L&L?bTBWdHU&W+J&.X\R<+A),aO^7DY179)_&f8-S)
dd\9_HELZK(Fg8-.Z[+P:6#9TKV^D6bB&6]#egKVF9DTg8Z(?BRcg:GNL-5N,_&&
5\NNN@2?Za<0a0d&Y(f0SHV&LT6W;=CdCJ@:3QR&UG(Z-F8&;+1MaHF#DW0]]Ca6
NEWJ&=0X&S1KP/f8F5J/RCg6?)61NV\7SK:CZ&O@.>[1MENLYI4KR6&V(dX^F,62
AgY,<d>QTWR[41c46-=dd)UHM]M5>+M/bZ854,M.aL<-e&?3CIF\fcd2LEE234b_
LT\(;^X_4#2C-T>_Ld^=,66J19F2=:2:R4(@[H8U4(1##d@9\@P0\_J\P&@3Cc-f
=#^+B-S<_f;SEY9T3C5_R<12Sf^+0OT(RONeIcHa.L&]>QgP.65D^8ONLL<Ge_e[
/aWLX:(/():/YC32bQ]>/gb4#ZRf+.4-CWC)K8[Z[\N.:fJSD0g;:L3:WJd3W[&T
U[>?ES>ND?01WbP4M4J;J_+;-6H2@>9Qb0OMg9TbaA@8QgL0cB._g4#(LF?cWQc#
?+Q\TaU.80O/TV->Hc><8PVYAd\Yb7&P4)>J9.FTYQYEKD<QgGQM&b6e?bf+\@]]
I@.(<1=>BKM@c-MPK.,aB]<g+5YV+2g;8+4BNOd(R5_+;1GFVeH0(PHM+8VaCPL=
c4[BTJ^2DM3=e1^_8?JDS9a6IVbIDb[ebM>EPca-K.(Ae8Ka4MdBKbF]&BO5,7N,
_2,_/8AK8>Q)T/ND[d?Z3[>77WX[<>/_AX)BG0Bd=HbM,CL_9@3W;6#TGPO?-TE_
/..UK):RTQ]_S8A\LQSKaa?Ob0<]f\=[0aB7^]P2I?ea>]f#DZFN2B@,WCffa2W]
a;[_9-VVJQEVVC514;g/O,LWX?G\\fc4_\9K7#SK(V#_Z9X<]=1#[V[;-C;>;@DE
G)^&0+MI9.?,FCAX,V(6.P&5gPXYA<AaU\MG(2#0;&YF,:@,S]=S3&>79LT6#81F
-A_[f_4Z+N?g;RJG/1@6-A&49:3D>7+/agUU+7QU+PSQOAZ.Z5@15[A/YBb8R+LN
(HYB20/>ZcL6+TScWI,KMJ]CO1=2QXac5,CG&ENA2;ab&Z6=AMa-Y(VTC&KNecaM
X6](5e4a3[Y?Jb]90H=,c9eGfK\#K-Q>fUQ3^]NIFKCb/>Q]]7Y/db8:SHYMcV:&
TXVU&A25gK(3+.>4PJ_1:HX4L.Q1I@G_ECeY3Qg]FU@A0e?g[b6fTAD1]9?8G.df
\9_\[+ePJP]D,VA6(Xgd([?Df-,9dKe_#6B+J/#>I\2HMgAgJ)EQP2d(RK(04[D=
RRgKL]P(U(V4a?-90g]Lg&^EI^#J5M<,\+Fa3\8,N#V4\H6M#,^8(<>,U&T[8WNO
U&EK8gN>J)c_K9N@77NAd_Qd^0NR4D9O2(beJbA.5<KeQ@],,6<S:3[D2PTb1a;1
d7.V<PU1=&f<,3gMIVX=6bD2f.X?\E/Kf\]CPD+?0@S3ZB._1N=AK\(aUK\VF>6d
ES\_/#>fZfJQ=<L&L5>XZ8>a55?[.;454.Ta?5<\MP+P#6c5D?@ae9JX?&AHU2I5
B/VZ2RFL,=UHFJdaP[2(&63AP7BQFSMY3U@Y:ZMH=SK>&H;S9BKEOLZDUIgI/;^;
D:]ObJD0f/+MD;#YUIT/e?:QJKAMU3M7d2(P3>9J/VV_>T-<2MMAHAS>bMHR,T#F
S.,)6;Q?&6WGVU3+CCSVcSU5^9cA1e1UJRA=P)0=Y42F/]=4I[6#dGXH5AeR?\(b
T7eM27VeOFUJ^GL(\\U_7F8(K35AOcIb6J.a#B>];/Yc@_03^84Qb?U>5D\e?Z\.
@)Y18S.&e,,DaHKCCT49SE6acgBAV-I;^V8IOE2N94^U2?47>Z]U[.b28KJ[WeT>
(YFT>0X#^:,[fd/JN[Z&@#^TV3J93Q+1cC<dFL]LgCJJcOOTbf?3?b=UI:&=1Y_P
C)FF+2Gg[IAP86dX<:MaKEc\:MD)KJdAN](>69;WO=)QGC+8T51W#cD:1G==Z/W(
+-(KWM]6b2>;D=1-2TM[;Va/=4HVaH90AJ1cK[)C=[1H1XOG]g7,D#CK&03:_gfD
:Y+.AHIFQT4]E68S-KI=Ge3g=bV^.TJ.(,,6=c(RgF[N/^#V1=g^/^2U&Z544VB.
LO.4_8GeX420P/V[[N?HW[UeYTC\C=0V+;Re1JQ3MZ6&-7/SU:0Y,faS-4A++#)O
5D;TEOTJG6J_&^O:.A\(.7DNMHcTWb8?#][EALI/B2FN1,&9KY_B@YQ]YH-;?f?f
]a]:JORcYNEU^>P,?_H?2_/e1=UbFFXR)9[6-2.0]aP?-_bZJS<CRWRWHbY]6^\b
PNLLFX:gO@Tg:FWaBM)b2c3e+)Z>U^L,<RGIN]4&9>?4b=?UZ+FB7,\5b<Led4I5
<_L=R[c90+#Ob:FGKJ()?^=QFa5:>H:Jg&T0b4J^G>4g,bO]FQT#R=JPa.PF;b)L
2&#?@PCgB7-.ZCL]fSQ6?1V)4FWRO=MJEY<Oc[TL,S.0f-E)MJ[Y,F>K,I75eS/7
@P@VISDQB2fD2ZV2XDK758dMCIS(^@ZO/fSZe0DTDg-K=S<+[(f1>32g+OR7GSI2
+^?D.1?bK3K0@7ZW7VUW0>9-U;9cA1R<48/EA7-\S:0T4[Y2CD-=Pd@&&fDJG8E[
^gQfA4bL>Ae074\Q^&6fHQfD1BS)/OM-4TINZ?=0S@3TB[2_Dc+;^1?#F.1.=)4-
6.W8,.91&(XMQf:,K:B3Wg:>3_1QHdVc_)QdJ1<L,eCP7fI2a9EH_=(:RNU(OL9E
//3?DZSe;D(B<a83e9;]6gE^\F)04^DUI/=:C+QX+X-.J0[W2]VL75X[JTWU5d-]
8P0OfHQ\d1E]]6&/MHS;3.E<9BDe#C]KVM/>G?;@2&gU\La3L32ES=GfbG[X][f]
U138N]]2+X26aT)CV8^PA[2P:F6]R_gTCV6]f+bU;cEIX_[_>>ASW^?Y^bPS:EU2
D@?c@QFb<;1YU3X\@#U-CM6XL\&B9#\JgN>cH=gY<V?b;QE/LI93]:RL+&R[IDPH
HJU6P4R]/@WP(,G5DOc9;XOf.FOA783T4U)QUTdP?2RgDaEAQ>V:fNRP#ZfJ(,\7
[f^W+ETY5(W<_^^[Cc?M&?gF32.MT@a67O?GG3@3G-J_WUK4c)4AOg).-fN.-I6f
L^P<a&dN>>R3g?(IRDEUEN59)6K-G3YER;XW7e8#XcHINZ-L^,UMd2EQgM@IEN?J
6_8=#W[]SI_8QL0c@A?98?M3J]eG_ZPbKJ<B0T>WMH7<N3:K71@HJANSV71E8N^5
][,7Za@>7BZLIEJ>]f4)f3NX4>1K.5YB6.e5:b)gPLNa#]^O:N.KY1EPY&8^R9dI
B^OH2c0?T<:SN?@D]e7?f8PW=IWSc,TeaFAb?/A)#>5b0YM6;2QSG,:H16;a(Pcd
f=_?Y^8ESRg#A6^T8d;2A\LD)4,e-.dYQEFLG(8+^K=M:/H-E09U1DQc_7\\N8Y6
RdVV)fRe4?19f.8+&.+VS8=:.,G[.YB^e+UD.Eec-_0A[JcH=(+dBd4Pfe8=^]G7
^3.IDb-RH(.+dd4OT4LE^#&HV6DeJ_:@9)]AB3QTg).]+C36UJ9?W7^?@EM&a3CT
/SEe176fbb6WWRf@342I88Y?QUA9FW8N5<--KgL_I-ES;<\Tf4e8=4\4E(^S]8K]
R3KSBbYQ#L?)6#+GH@P3d0[Q@b8>fUa_03?(I6aGXRWb=FcL-G]g(7Pf;63AL4QV
KND]C]FAUOb//Q94N/AQ0d1J-943?U#K7UM\=WLX<d=C#84M&?G.RY)^:Y\fXCB5
,IQFW.(P^,HEDg?KH=E5HE;Q(L[f@ba]\#(Q/(/;5eLI+O]#0/,#1+[^eC:M\3Le
_+D3C;\dRC[.).=IS;ZY&fNFY-1\BDG],1)d#[LU,F<AA(NHbN]5>CXV45OH]cW9
e\=T9>J:SH4M_2.5]I]_6CFB^4\Ig[>Ug<N83,/2=0.<]0RP-gg4VJA8X53,ZK:=
G5Aa<JT-1db)O4P8c3J_EPg3.g6gM_f=(,;g#;I0KKJbS(_U(gg=^\KfLMOK(/Sg
Z\&3SWBfQ.4dJ+/U_YY^dCK5ITO4UPXgTK-6b:XcFK64PYAgCg:JNT_\,^3.HKLN
)+Z91((+@1GPS4>gJ1e&J5P266UK_DM>X>/LF;CJ8CAdGHEZ50OWZEdaCd2?4RYI
Ud4UEVgKWaf2Gf&+1\Q#GeJIUB,O4?d6>KIaSM/[R3LW&aRR?(+Y@IF@53d5eab,
IZ<,<;;RJG[FGbTE5cgM@G1)bC/7:Y)EJ97H2(g@4e@=H2]:V\bGX1\6S[-802YG
T(<YYK[7\B)?2b?#+=#[L._</R?1-Y3gDRGd\5f4TYJ<8)\7J)g[P0?I#XbJ4b#Z
C+RC6K<:(H_A[/G2Y#V_UJ4:)g=>VD2Xce?T<&F7@7bYO#]OSX)cK69]4_#MGS8[
a7eOFa67E<#ZY/eQ0UH9E4^g:efUW7@4&f?JUYgWS0VUK=<:#gB/3[ZWA\/Z-G(,
+FM#G4F^7YaWaTBB5AG8(WUU:9&WPU^de9QfLW4EWFRP0UWWL0W<L1/[#D)YcKT:
_QJL_d3S9fF@6]9LFD^La.T7VU\[[CIJ7/^>3e068?>LGM[T=IZZ@A5J.EVUe\>R
X2Rb+:A&.;dIa+,557@R8_3QZ@-C)83BZ721LZcP<VFTb^0D:RSKU0SXU/cf_e<9
/A(WX34G[/Pbf?QV4<495=Tbc.afU?gV-KRXS=[5bO@eA]3.?T4@3U_&48bU[_U6
(d@R\Mc+:]VTM6B;ZUIRXfQ68eOP)3<B(--GYE[>,cgb,:_S1LZaW@^Mf-S#_^9L
.#MZ7>[(9:D.b3;NZ>.;7I=QCW>0dC/#JJ/P^T,.KI\/bKD5)JW]QWBPfSM(Mc+d
+:4fdaJ.bb_LST\??JD74eX[#gD,A@:91QYMJ3PeRC7PB)T,/3B-TERgJ[6X/^G/
)9]#BWTH&&68W+0U@42b^ZB3X,-R,KDJO#SU46f9J]EcP<0I+&RE#7^F8AV@g\bM
FPKWKE5QLJ@[F\N@AH&(VWN^8d,NW4F\:AOM0\BQ6a]EYT9@-L?8aQO)LMZ@7YE#
(IPLN(:7_)\RfB?U]^5(2A8-BEC->L:PUOX_WV9]DSP6<d2gWbb1N)R<X7M23Qd2
34?5#^59@&&9.COP:GegN9E^0M:aW_/OBNVU4S>+OV\ILO+=0[d2/;QI>R&UY>Nf
E2E=M4cY#L/1_1#M\Y:(BD,-Fd3ZgBJ?;11CM#)I437eM+M/RN+Y-L^T;a0\:#bL
OSRW(d[5eAF&DCDf96RL_07Q+5e^KJ_fg^D6IV<3]Bc@OSG(<&c4V+,;@.B@I&M1
0/,]R0+V(]#9++X99MP8d6N2b-0RV^N]\RKaS,AIP27W&e#BG.8TIZ4a\+F?MZ@X
JNa+[>1ba1DW6E?@7EHa_GI[>AT?LW3_>UTd+Kf:gA\<\270SZZGVR>fR3[LJQMS
+SAI&Je&?XaX/\[8[V5^TV(Vc[S=EVbU#b77<7CGbBfM-M#S^/PFAJ7/B7fXc^Y)
F)<)P[I1HQ0Y#6.<N2##:Fe,b>c7XGW6:2F7=>,K/CFFdIZTX@b9)NFb&1.bO:XU
\1CO7BdbX4\X>ZBE5\gOML/YJ)]g&<?W623d<=cH(<a9:73I.:8AU4(&)]19:aJN
6d-DJRb[#Y)86aY\^_USZGJE(b7?-O__,;+cWNJ@;7gGQ^W4)ITY.:N4FbHeYN5<
[<C^R)0+_7@6P@&gKBd]b;b>M&#A#9HgA\\7B[3g[D7._LH/2R_3<^RFC.WU=\4R
)--6>O^VDC15[0PZ1R4&A+Ha]W2/R\\LB:JETdL^65DJ;CO6@+adScM9@]O?XKUE
3L_D>cS6bCEYeCP5W?HH1:O5#4<.X2FE\;U^PgX[gEC2Z/VH]Qc.8f>+/VA;L+bE
aR:J8>,\[Q7bcP>=]bgAFDa+^V=6E>gT@V-b;SWd@7MEY6fb<D2L<6S<.X3NL9A6
)?X[]M7a7=04HT/@AI5:\/Q,DeaJC[TF7^:I.;?O(J0:3OC:]4M8aJ.C,H8@5@WR
5bZL2+JTc#QI43;X.LR#Z+4>TJWS-fE,16g+2fUSg#b.g6LK5-X-RZY/AMf[b?&N
>Y[=.[Q(-R)ED1/1EPGFG2\8_QI7?&X=-X<T8;E8I#2]953-6@[aXE_eD\2cW,AJ
IKb:Q#2NE\?9#P_Q[Zc^AcS5c-?TXII>E5,RC_.,Vd/\EX<TJF3Fc.5V)/VG/5^7
I10<\g_GSFC4JV^\b,bOCSg.B,,W6,^:?77WV1_/=VVH_)a]+7e;_R6\@Z-/]I3-
g7]GX_IE0(Ug>#JLRV_Y1.EM>UN>1QJ[caF0Hc,@H2G5^^\SQF:6aGT@5+dA#@[d
)CEFbV<U5O7c:d&)H>bcIRAH7_Rcb?2./UYBH.W86.,P_6^S8.ZDT?e1),[V<2f&
2REfVW1d0_O)4ecc=SIHd3+DT4c1e,#L#JDC\8d>1V^ITbRf^\5^/EQJ:KQ(.I;)
]IR#_#c@bA^:-4L=>VT]A]5ZQJ_e8^<YW@W]<1F_A6/(Z^W2_M24c8-Y,YcD3&fg
cOG1OC[J;3d-K+=BJH&DeB1BX-4E0RbI+TF2VMLZd49d]&Y>YY/+b?I25?0Z(Ga0
VM/#0/^^.F),\dIR[0VK7E3?>I-Q+.QX^,I1/R:N[N5OR(B_UeSa,[>5))3T4-4-
5A-YNIW/X?7::GD=\UY-Ug<8#MUJY)VAHE\&O?aG[VEMR][05W?LKgM1[PA&>>RH
/ZI_C[\6d.Pg]MQ+>ZK0Yg8PM0>>1G\K<X+/A4=IVc)OFWSfQ:eRBe>]]<BeJ3KM
/DY.WR9(#OgZfFdQ^.?.X5gC5RVZ^_fg)LIbQBH(HR-PXRCYR666A_/F=6R_O5\/
,94?I0E92@80M<]DR&6Z55-F#IWgUFCEBC0DRd+(HFMH.BK4C12aa5]GMF[7\K9U
Sff-HP2Z&Z65&@g)0eVCfOC@=^6G1_VQLS+1F=K<Jc,Y@-J4[FTaXI=K&4)f&B-b
H/IYUC>cITTH2.Q,EP<^9:NC-])+7L#^9+.57&U&)6<\RP3&STAH[\/YU3>d9U&Y
U&,?;URG=?]G8F@5cd7&(5:9FP657\;QI8H;C4Jd.16E3]99.++3(N5c)9IH40WY
##f5(-BWM7;6[.RKe#fM;I]_0(2/<QD^48KHOD[_30BF^0;Q:Y,CHg5cM$
`endprotected
    
  
`protected
]eJLJ&9=egP?V/OG8[c2H.aUaT0SNUPf@06NPPL.5^T(,S9S+Q/,7),JHP#FSYf=
,a[W.1]6\9g26XP1RN9#8;aU3$
`endprotected
    
//vcs_vip_protect
`protected
MFP#a7eV)^I;5T.^,Yc:])Cc2<6#17?eXXg\W5WY[JY4TFN(>2&\5(/>?6#9bFaS
8gUO(R)QJ6AMTQ&8bPSa+^gLaL\S0_<)]>3L+79U[&bbL1::;<Og2>,UN._Pf79N
R;T1aPLH#NF[?c2fESVEWS<TcS:_@T<,_0.(F>5_[/SY;6.=\)&<#ZT_Bd\6VUHg
OZKD;8bP)2F@0_J6fa49LV=GI^_-GMNCOPKICRQ/Wd52Fe2D,-\5I&R1Le\Af4T[
Sc;[He4cMH<D@/((=2Jde@\+CSSIG]SR/Z1E,I52C#K>ZI>aCQWG&YM/LVO>849d
IR-S9I]>)AV;OQ@dBbfUURH2R?-<e,a6.D5H+eWR,5.-F?g^3df(P-;L]@LWR&HV
>X>XVV,8_f[F>];g.2MWKabFI+bK^=)Q<>d.3eg-,PScER89SY,MLSbA@+L[Ua#I
0&:b>[B5?Q66]U84gF>\U15+8,+CbF+Df<O9/-gO\M(Y^SYG/:SY47gP<6PZGTKQ
g),208J5G9GfVd-&4(E(A<-SO62S&5A#]W<B8K12<QgL9S0WL^+N[)###AY3MOAK
D9DT8TdTH#3Wc:4\)G\TDFK0@8<J-:^,SO8OU0fT21KON&S.45T?,0Cg3&CPV:ED
W/<<\FC5N>c_Q3XT9.IXfHT65DFSOc,<I_:2Gd>70R<:+P]0_NgeMCD[e3E]_\T:
TMb&W9A;Ed.BWafF-+3Vf=.F\G:LY7NV>1A)I56>gJe[BC9P:+<X[/I60V3-8/D.
K@3E-5TI,)R=H6\LEgAba:VMH]ZF/C7dAO9?[e/ZTRLaQVPT3<[C5-eW],QIc/IM
E<aCVCUG/@Yb[/-HL;+/W7.G=A4aKV;7,Ucc[Je^;3.?_c-OKG[_Z:/44//2/PMf
8,7WVX;8g:O6,&?OSP^QaXK[7^bGS:4_(P@1]I<,L=dVG.VKWR(@4YgD:T=H,;P:
_FIF,XNIB4DIC]-@Jf3KDH_/9O3(,,fb@Fc1LK0WH\I]A8Y\;e_V=^>.^E^3:P9,
IOX@M2B,K^-TfDX2^?Q7^LMF+.cMQE)M6=OP67N.#7>0@SEM^49YS^(A&7?^=8SP
(GVD5Z-egM-8:\YF38/>c(0\&VC9JISJ]/0?e(OYQKZR^5;dMa9J/3RF2Q6=,^A7
JJKWfRG-=L9@B]H.7]Z>R63J?0(>9J=a-@9Icd[fUG@+F\(b-N.[CJ)-C5f8#WM4
+<aQ7YL[^MI3.\K/0]2K[;S1-RET@Z@7)VIX;AKZDVC>e7-_F\SeZMfC:4N/:G7b
(:5a.Fg;4-ZBU#;1X[.Fa4aU[@SF1&=)M_?R7;+&Rd(GgU55885>/FW[b1R];2^Q
045.T[/7-UJZ0:]F;#+0:[[Y7#V[FYC&gM<GB5[Pg,RSQ9GT?/04#dQTQ^YGa^0,
+SBa2BH7MHb23SB_8,^2dO:dG:\S7eX.UYWdUeJETbTOZf\Fg^JHGV6YDK:C3L&5
0>aF06Z/JP-]6F)4#S4=OHXT0]g+:d1=7=>I1IVSF^K];#\Ra^G9ZR>de65P.SL3
D,46g9?ZgRMVF:;UFed?K?T:<B+F8b+GC5X\XFAEDcXaXM^8gMTV8-=cNbQ,8TQD
8IcXO@];37dC\SQBed#c^fQKe59-f91:bKAD?ATMM?4-1X^K@<R#XPg((^Y#=]M,
+;0;8cS)[)2X.BN#DW,f+QJHg_LM7_[>-;0@:Dad6>C9N1#:22>HE-QHNARcF,_>
U\OB-]>X8A&^Z57&GJQEJZT@;gMO59YUF=09<=&3D#,d\^K+;?Jg09?;=:Tf3Y\=
=7d\_N@W<@OdAG/CD33IW,?G?[K=Z4B#IC+;-G[cL,3ROSY/O[,\Rf1S+dKH)-gQ
:agd:3Z&7<<_5[N7[Dc-OJ&D>gGTJH7BC;c9/KTT42\WE7GH;W0e:cX8,TOL/@f[
;cg?_A)SLN#Q7TN#KIDRe^9F@,3M>\9Q\6[1Ma8)-5S)>F\f:;gL.&D?<6;8,5XD
FCZbIF]ECS#(:,5>8;b^@/O-H#,c39SR@\33^L#K/e.Z17+<V]S.LfLb?^3>H>-W
0fN)T&G,/g5X]1&C_gXQWVP8a9(K#1-Y@^KNP9.d(9/V0)eEMD>N,8dXB\BNRO(5
<[H:6WL_8=W&>)TRg;Y1gZ6]4=fL4H85@;(#-2P,NS?<E4[FN23b>aOCS,/LfWbg
Yb)(>afW]9,/W9\V6,UMbR;KV3KdW)EbISObX(V3I:=Y]7b-)PdPc19c2Y)?^QWY
I/UDN&B,a@e^R)T(V<L0>3,&d^bXaD6QTMCOWTD;EK4CPRA\<0MGc8a1g27^]+2E
W.8,^58PT\IC8Y&774DdeCST504:+5DX#B,HE6Q>:&Y0Q^O6aKXE@B4I9#BKaYJD
/EB#g,KHQCXBA;e1K<g4RTdd&)88PTF#_^B4#Q@,##C)HBS>eY&<[1Xa6WAX=39J
K?.aL,>^PLA1091?+V5:^7TA7g7T-D=?;0@):LT;;9eCg[MSY1>a)cFc^-1Z,e6P
YJ_WEA8LBDA5-+AVY(@YY(@+9gPN-:NDID5A-d3&@@dMMB(f437TFN,R)57QOY=V
a-CBBG;E2:6B0A0N,.JM:Td?[1JfELOGd4M+e/NS:7O#2e<Y0MC:)2\EO-55Q7(L
76^&Qd6a:?(3SDW_g9#UYLQ)Q@S:+B^(?ZC@KV1W>FI@[b9F0RfTSLZf:MKWe.?;
R])E.CKIg])7fRBO]0KK3GG_+S0=c4=fY<MJG^=Y]N&BPPR,/^?NL,7AAZC:Cb=5
B4g?03-68WU2_7-@ZCBd@b<6J[W@)Z9MX<&CdL,]A7Xf64QaSF2M2@.SVI6C^)Dg
1,618eH1?A&MX4[G&&TgG^L#:5=-E<.&VBW3G<-:da+-+CX;Y38;:;,R=X6.#XKY
8M9BXRVX[.9H</7WZ7VXd?K)g^&Nc/Q;7QTT?RNBJ,aP3+fI>PgU7&N<#\RIeXT7
;0EOTMH[T=\-4\<]^0X2?FS/-7f1GbWBT0+^Y+KNBgeO<Ig+0ZO4L)F5MPAB#ETQ
YW;CegPOH&G,8Le4T)GFEIX15I@H.[W8g(XecVO8XLU:?1SDgG=5LHAC;:YbVU:+
_6bKLQ5]^X+^5NM6;^=Nc^G-A&3&^=.bbBPY/VPHO/[T)T?^A2GE+4P(@JSSe0fA
=0,fT)d:_JZ@E4&1I&.J)HVDRX^8\\X5T2,]1F<<BWTK>].CI;_8^aSVC/KFI,)[
4FZg29>9I0)D@d4=13SVCTVeY[Q\&8JL,=e\H]bK6HH9<8,HA5=AU0I(GFR;T=@1
[WO@M?NX@\?S)LD]d6,#LgRO<@dTf+<2=GML/aF;6N?9(M2;_KBHH&&I]NT6b)Zb
<5ZZ<8J=eKR+K,K@R\7TD+SC.\=(6;?TNVXdZ6M34^Z#d^6#fd,?ECbQ;gEFHUE/
)=)bMC#eOT7#)E;H?^a+^RNODK2:(USS(H>XHc5SPM-P[IY/=4Lf73[F@FO1L5YI
P^[M3UQ91b[3[RR63]D2a)5:13[H<^2V@M5_GL-.MN@dbf[\W\YLSW[X2J>?R(,A
6E[&0RB;Lde#TX0cR(^91N1HVfa(^W)UJTQ5D,^QAS3PaC#5P6)GLRfK+O=O_3LW
):@6N5E-#9,f:N5;-OWPC-C(+4\+aW9L+6L>JMS4c3NU-)8VIVQ2eTd69]YK+<7K
,IKSB67,::-#(19f1H\9/d)5fM06YV,0NbZ^KDa1UO6aN2+\QFf@8BZAY+8GZE2W
YQY-U\Xc,Re,@UGP6,#OXIR=I3a;XSJYF=,CL@@Y2J]0a@.ZBI^O:ZE,/a241&8e
0OD?FM+_LMBK#FYL)\M[@?4@f@UT(4-([gWO)LN6#AHFC<:XH@5A8-=2OBJK?F+b
85)-Cc:2:04d/bIS4=<-I>Af\VA1\cTPW[Z?bDAH-LS#6,+M8bUC5T)@6P5YQ415
,5dNe?:K:H;<IHC3RWg0^TQY5(:PCKG3^_HAc[,VQ>]#A$
`endprotected
    

`protected
^9ALCU1OJO,6G&@e)\c3G7bH](gd?8>+JNKbY_&[2K\=6V?5TUWO2)dd/]X^I(fY
b;/>Y1DLBUT,NLUP)02L7FbH3$
`endprotected
    
//vcs_vip_protect
`protected
X)WP/8X&QdaPG@SP[36+,2PW2K:Q7/2LE+g<Taf:,R<C\d7U53CY((TfWV_2#X(Z
N0:NSVf1]W1FF9[>bMSBgK@C^Q4BOaVdEG9QP<RJ6-gBXY).9_.+f@QC<9)AZb:1
MS@GX#@KRNM@XA_O\fK<d8U\-g-A3FHZ\LG?Y;=2b(I6MFT:aU2]UHg@_BC^/P]N
^X,b=PP(7A>W8c?>S;-H.4eDO62b4OZP,#9^9&_T1H6Ad0XDdf2#6eDNT-\7:+Kc
QEACZD(BO)DD7DD9W-UOJ\d?)\AM(F4+b7:R&Cc02SWA>QJ;APe3.K3G#I7>HS6Q
fT1E-E=W9S0D0RGI/aIVHK=JO]_)DB(=B@WUMXG.:eS4?YY^,TUR^.DK,;[X2R:0
;I2ZMaMMY^.LfL->83aJ&:_(:R,gEGLcXUe2,(1D\Y_0=2+CBb+2ZO5:151-f=X0
,\A+,1[]3.P<>32LT,/,-77_Jd+J>c..V/DM-LD2RPY^R6R1>7WHSe\0;.g-[@>O
MYWcW]BNK_Q1gMPH=Y+--_2<1cec#P-Z&<@[?/^TN>Rgb\]Y\S#J:c1J3<IVTKSf
:dG<)G7CC.;),&AW>YDbRXPGLgbLFU/F4ZH?7:N);bdL48S]g;LF-,:aXN;5/#9P
RAfYG&B7QAUH=MM]?MS:bRe1]F_);301OH:W,0,U,LO?X97fG?>Pg_Yd&@:J=8L9
B9.I=JH0X_I_R5^gdaSGXJa?Fb26cdT3S0OZ@_b7LI1gaBfV]gb>7W^8VQH>57IH
3eB82Y++UNXN-_YLN7<U@MRC>46eceJXG;2/>[0(^EdYNK:4XN[_4,YCBPXb+77]
K1>H.6FC@E959KbF@+L[<CD1PO\3J^MMf1K[DCA0G8=\4<7dd9d+(;@T2G:0fYKO
ARZ]F&1OT6gQ^WO=ea6H-=4NJF_g2DX44HMO^CNVER^E8g]/G]4VTQE4I[JY8baZ
=L&dW_@M+]/_#Qb>V5^M57g+TC(\+>)GO3#RaX?</D9+T)gf2,C,;+,WW;<D,XWW
[^(?2_M[\E#]=L&,9W9^6^&&:KD&f-J:0#gHWLcf=R&YG)@)M6aFe+WA?)d,-Xe4
XfA4JdTf_-#;IY^XDRDWgLD)9Ne4P)Vb+K=Z;g@HC@O;T/Z0&ZSdF=3Cg#UD+Q=5
Md75-84UO>cNG;QHA6(bBQ(>_;/R&65@4:McF&.L6X,A;^Y+PD^>7G3,b](.K(?G
W.O4[NY/f0gQ,cdK2S=S1Y:B;fAH,BCHA<QZaPR-L+/Ed==:K@-N,.e7.WPaW/)?
I3<3V5)I]E__0g(RPLP-dT=0\6^52BO)5d-]1KTCR0YA^/FZ):7>-#@Ug+_;NbA=
K@J;&#bDCfISKacK>_:;7a)A9bL<M)Y,@=-9;Xc2bV529B?ELQcNBID^I4L2(SK-
GfGSO>U.X6S;f+adWaKLBF(_LO1B:[125360d@QL:K)YER_36#d,F3[SAV0[YGPe
L;2B)KgXM_N^g:(/IP@F]+ASOS^XNM:9R[UbW<eTMO<aIIS.Vgg1)V1cOZ_\W(5?
DC/EOC_c^T6c]KDgIOU5:/+0O;JdPc>g(@;(5]QFFA52HJ?T8&,,I2K\#SfA_=Z-
a:OBA?V2efUf0K0J@^P03<d2[+G.e8/5/M8=0a/3?5b^&,-07#=,M2YJJAE.3EcI
@7(32VeA^4QbNY=L<fG\;>3AK]A&M^SS^04Tf+,@W:,C55/20(=4dMGX>OB7OT0g
e\)C;27LYKUK<GbRXHVF#S;ZfH).->eE>Z/dOa@7cOONa2B0/OQ.-3AQJcJ&-SHB
6^SAJ<Cc66H@g)b70QX@2Y)A1(CVbY?TN[M+L[)QSfK1YUSIZNM-I0N^Oe=747fE
5=#@\Y_.]\>/SH-d>]O2\/68RM<T[(6[#@/_O#PRAZdfT_\NHIM>_0A;M+:8].Ie
L^;Gd@EU[8.BZRP:L9</\,M@_J8cUB=4Taa<SCCKV<^YcY#6[EYa(_L5QV+KTa5>
K1aI4[&&4I+MOaaX.7VI09e08\CWY\S1JeJ>^TX8FMMO1LM,,&?Qc6AdgdKI_VYD
AT:3BDB/<8BK#;8<OM4V&c^/]NPZ=0@K[@T7,fCL^_)KRP@9WT_OMN(<5ae:60((
?]O;/4T::Z-..YM;?8PR^HHG].K-9[SR]fLBMbHdIKL5^6D?E/NR#3U,FDQJ(704
_9.#XY1V<N1J4=Ld\1&8A[S8MS_>/38[]J?&c/Y^.+KTKFHaX-75NfN^a=dB6FG#
LbO(AS_DUQ^g>L&A=(BKH?B>7Ab:8W3^,:d40?_bWB1RP]8@=KPF+CTTZ+e^@PEa
-@@Y.(I[+U1^D9WT:&)acN\/J0J#TOJ+\W8]T1<_-<5,E&\d+S&T:G]PMfI,E+a?
R;OGK)V?_1IaaZT9(+I#gfZC?>2Tf9@b&)g[@.>e&>&Qf)e2^a2.d.DSDaRg#.3E
3VP&+V4^+a0[eWO6D2@13Z1NO]B28R:^1g<Va:;(a54>6CXJ75f@gC9Z,I(Kfb3G
F7[L^b:#W6@D_AAZ(8?-+8]fC+/aBJfO[:B&V,]0c<0,@SaKY9-5J@5P>MHW#A:2
Tf?d.FGDH;HSCQU\V<)8\#SAH0<cg7O=d07_3.gBMYW34.FFVAACRQaQ(ILO&6E(
dLW]XdddG^@&3(.2U9MMbF[4F6[&degBJ_20732VIH>0]T\/JB;E.A;)+LN@&]9I
^1F(W=\P3/[/2HN;aZTSA9JAF#C<JQF6)DH1WO)]P<a,W@(PH5HZ238O>KF0)CM\
W[OCUI[E3SIN;7-HR9&>]UD-4PP>ZYKVEBXeYfDa9B:UM/^P9(QbGZM4#U.V@CKQ
eX0.A2WV#fD7+#Z/I+P-AJS@/W.dD6Z52eFDCG1Y\)3\W/(&[BK-=<4DTYA&D5&B
G/gSW/\eEVPT)8LVS:HG_JAHT>-NM#4@U.MJ.J5>Ff)LeTZ<#9Mf7OP:(@?B(D0W
fRLNI8SF:9EW>MU-/;Y)LUR3f:BY&aOaIY2f(/A.;?51RD:S<ALeU4#>L#,Eba.W
/Ha,BZ-?I\TbeM<SXK)Z.-Y00g<,E<B7EE3)&e\V1&U-<LKG.SOH:5[@\[A_V&5D
W[LMB_C91(2Y6YR\M_bY1]8)07MgRT6,/0YbAILI,X7)\S41?a3&a>Ab=N/>T&IG
FG91cPXX-7aLGHN]#H.b)+(504A=\:V?VHBVP2dL5-SV=bD2I#D,]d_?7]E,d8ff
V;K6Y68JQPN&@P/Yda3bFI[+14NQLBL]dLLA&<=3+Y2N;a2K;.HEd.]eRP.TIM7]
VJ[21)Ee>6<=ZZEM=RC4.1)KE-&Q,M7C:#DAD=8@NH,7&@[,IF6ZBV0K60Fg_)R2
[P=#BMaBaIIM/\Q3gfCSL5D^DL?+8O,-@Q1^<5;TNM>.g)2c^/fO#/5:[Y<f[-bT
L^R5+QTRTg4XK9?4eC7YN<G,+]\K/+#E\U;-^5J&Nd5PC<]]^EW^61/:.-3MaB&Q
^.U?bU>BVJ^H]ZC?NH[C1PDI=6@dS4OQ@Ge6VV3cPM.<Q5Va<6ZR9(EAK>ER6e,^
QVTM+1gS@K7O7V__.3GD:48NE/TT19(#M#)AKR[;2ZWf_+=dR::gH54Z3#.XD9Jb
N)C[Z^1POe5Xd<DW2PW@ObV]E\74+bb8DV)KKQ8S/JfELb:A;9PbaGCJ8Ad)fd)8
F+Q\WN^/4b;&3:F3ITH9&T_U=VH/eWVZBLfDeSNUNMdLK0#GNeR1L)7]+c,c3I=6
fE/]caNe^1B)C^81Ea<]Ta_BB8ISOI)_aM_P8WHeD-QDV>PEA7-Y)R9\WL+=c9Y<
W7@T83ZDYe]Q6V;(DT6gTBY<<g>A,]H-53E8:H/J>d+ORP=.HB?T>dgeXaR&ZaG(
]A9Fa82ICc2Q^<XV[R2G3Q6/KNO;<GB\B24,W)-/B&0dE;6<F[@]bH:3F+\>4Q>R
^D-U]CMOSFJT#1I0XJ)?f9d04M&\JbE1N/>___]WOM.T+6(VVRMc@(M1@I>\11&@
,USHA@]59E<SM-=NSIE4IP]USI^SdURSVb/,e14>K66.#3WV]+I_\[8faaR;2AW@
d,AS;D:,g6?VKGf^]]PGBB11N?T6NV32YDIE36LQ>Q>H9.7K5Yg#GMEOUU6Ba:3?
cO/5[^f\Ued-#>FTLBQ+IAEK;7S.5&bO1cBBUeX+4V^824:H=NU<6Qb1YLOD5PW2
)U,\D3L\Gd-ICEZNW8dWa5fWXTYL[D=ZS0_KM3f=e\GU9C8^1e\6Z/P-,YK.:P89
X:7_/]e>YR4,9LZC00[@U3?\J/Wf_Z6.)K3J<^GHc,86WTIgf?CdVD].W,X,^5gX
9@K[BSRGD)]DaIgEK;WS,G++>89WWP00JY3D[<>0.G29;_<edDA75cD]aW&OW6PS
1UVdAVX4<A,.9W4J[\cZSH;/&F+MO+2<9<22+@VCBP?gZbAWA#G7XQ.XTcZ7ZYPX
:PaB.gd<;.Fa,==2^Df_@b94989CK46>NF9IG[O,[?/Y>]Cc#6_DXVQeJIW17;Q]
G2?RL?YX4>++&N(E.0)BC4@?O#(5V2ECd7E^V=U,.38ZCQA==69OB<Rg7Sb5Fg#g
_L^<9Ha>G3S@fE):XH_)8+5.KAaRMHZCcYgL@&T3PD(3ZL@gN@;&5;3(;S)g>dA:
Dc[)?@4E1g#EJA(9/G+WG\^c03PQ>;b\]:Ja/9-Id^gXA&15(>8==QS]g1O4fK@O
-6,(<QD9QHEQ&,U\#//g)V(2ER5;cRCS+L9A28GN/-57#]2ICeg);L75Me+//,GX
Kc\cd\GSKAVBAFN]Yg:OcHGfe1UD0],/F7e+_RZ5C,LJf5:IEI56#fS9fR4SX7X:
e63=RKC=MYNRfH4:cARRD8I?f;;&FS=31bc9^G5O)IOJ&3#.5<9Z4GFBObE:C8BV
6eA)G(V;(&XO>R<3T]\H7&C8)QO&8#T#_gL#N/[(RDe(MA@cCT9[=S2,a)MUP6ZX
=\=>LAO-_4fc8TU90-H<-WBE-9FMN,X;TFH@5<9<N[<+2A=_YSNc@2\g)5X8-/^L
0Q\G,/J=8-:b?bN)FF8#<G_/BCc-=H1[XLbO/@6O)]OO2Uc8I\1]<A5H\N9?/-RZ
C]2\0.F5J[:J#f2S7]6eP7Gdf?7OYdW_Q+>(B]>2Q5J<]5GMIZc>1^ZFPKAS4>ZY
<a[PR7^V@:ND5062D_W&Rg?5RQ>G.1I2g+KS/KKOdHC]Q:A:UQO9ENTSB8[OaG=6
FWb<NB]=1Be-BaYSgOce+<8=-]_XX39K@ZXa+/WcVd;]]19TeRUW^9[L:30)EUUF
D4&9\JRQW9E^/UX)D>YF(:c6(J;I@;)]AU;Q4XFK3#QWA/\Q,=FbeN_^<TJE;(8a
AR]3?3PeS[FXgI5B8__52O(/\b5^>d&2Q[0G]O1O9^Hg[][a\b>7T-L_-[aD,WV_
#bHgIOgCBG&@9d4e=M7Q_M(dERCfbAQX7,7EPWbK[:,19_,Ab94>W)0G.#WBD>VN
/.;DD84(-M.(3a#=8aWK@72gg2D]II8GB\F4Sg#/bTf3P@00cNHPf[2#=C]UTT)4
+5>_BQ[#8VH4:4C6L=[]_6;O<:Oc+(F0\]L7_dLJZWb3.C4IDK8<)/Ef7V>VdF1J
[2H@;=2OdL&<fTfMfefQ6H<=CYK7I+D04#Sc>/eJAC@c0+0+ROPG7TTBAP9=.6b>
d/L4E2(RB9A/@(JKf@bGADf\GC)IQX65;>S6O;2O=YQU#6eb2;\O=NCfD14U8/Tg
8GAI=8P)XM)J\98AB^Y0>:9DCP\0Wf(G]f,cGJ4e5ObR9IbfaE#QF5=MSe&FQ=gg
;_0[YL#9W>O2a2K(DAE(V,HZgMP+<Yd[98<J3XGWbQ@-J>NLVOZ;/Wg9=\-GT>)J
M(_)I26>3c4[T[NA>9e/FCa0@g+A@3@.Xb?)Y:>AOd9AIGd^/RQGO^R>-ZPYL59)
>IKU\\dL>B].&A+);H:V8O&Z/SL,/6DScJ4_C]4JZ3KMW1.;DTg./_J\b3]GG=[X
ASM^D5@XJA59@AH#3Y-<NL9^GQf8f+N#ML.cX1g_I_(H&TB(D1e)E)Q>N&EaNf>R
9CVK9VGfM&K?)DC9=(P7G6HUKQAHCc6=>MMNUFT?@a0cJ>,(D3B,AW3]aH9gLGI<
Qa]Cc?9G@[+V)6a;Z_7]?c?2[0(K_GeC9=BA2^I2bJ+9=#L8NHP,=387fDVb[<WT
4fTJ#4#M?RC#bQ^a@>.W+FK[c6g(JAFHDEQ<6M>ALB8YHOPcfU-&c+P2=?E2M@?Z
+>F?dGWTC\J?>Q(@,M-43,HBA(Y9LG)O>A<U1fSFa+I:1RW(5W9I-C4/;Nb;SK0<
M9gXR=ZVSYg&7=OMJeZQE545gZ,SdZM/&;/R4P2_6=7HZB#e+8a?^R@Qge/4]H4V
XR.6P\4:KY40]WOOcI05KdROGM.,0aZ_DB>N?>>c&BG)?E/]D=c\f=G(f]NRbUE#
.<NT=RBG6@ZK=CNE=+,X6YUg\4K=2Zb1)_>O2^AA:7<cBF3O/LEHBbf2EPMS159X
_^QUdBY=1Eb,6-YgE@=[+<(:\T3-MdV+W&?W1D^DIfZEX2aE^:7ga6Y7?#[W=_e6
(L#&(V34@]]dIF9-W.1W^Z-4dV,Y\PTDN_]:A41Od_YG/-PL?VJSG&KG4@2^:D?.
\cg80c+2<BB8RG(/P;ZfBUT?Y@?\5XRX1H#]A)6_\Fb/-(aKYZWZfD]E)V96X:9@
JAUM9e&WXVGRT6/5>0Mge,[eJGZ#;2@8]bQ,<4?O/<PX3>78:ZHJ:a5B>KFF,(Rc
_6@;I-TE88MU5(KTV<&+STcIIUMb7cRWC<9[QJB7<g3@5PWWG&0Z7aKZB74fFM??
;U.]HL<<9Nf_?R4\43FX<6=W3ALOL]ZTK\,,8LE4=><\YCF//bbE=G4<R9,aIUO.
7:EHQ-M_7[0G8H4[>gG1c?#R91NSD\;=+<9LU-SgL[S=8^7bcKIg;VdK7_A&AC\+
@H&4Ld3QY/(O.Z=Z7ZFfT\QP3A3/HCTX391;MSGRF<V6_^/(N4HCc/eO;5W,[aCI
3IE6+aF(c0e3g_Wg9[QJF7U>dX(??5OZ-]4DcX:1g0R4E30[HWXX[W3aK3Q>A30H
)/O3WP0HBeJQ/))XdKUdN_UWgLZG(E]>PGC/#@0RE4bBS^b#>7\b)c&OE_Mf<Ob5
[H3BN87d),[>:/gPX]a&IX^>2g0a#>P)W]K4[@:,F(V^Ka/dILWG1VWL4OcFbBV_
^,OAZ7NU9-/<bKa0fH\.VfbJ[W#Q8Ka+N[1N7f-H,<F8-TC[JfB]fW5E+FK2&TG[
GQBYag>VG5?0G-B#3_)AL5272D_b.VYWGTGZOV^J&R0U3K]UI5@B&3UXZ#([;J-3
25;=dS.[LBDL2I=SR.>9U9?BA\-]GO_K47I\a<Hcg]H:E:aT1d;Ec]TMM1/]0ARL
\/B>Q:.M+68c:IE.O#Y-\#gSD&D6XYG0e-]4GACQ(+C_E8##,BV,aP_O7H\AWAX7
-:PVZ2-HFLG<#JBOQ2/@U(),DG\+&GQ]>HQM/0^=7=b0,TCG.1VI)2XXJI3HX2FT
8&H,]C7QX[+/<C<_V;A2EIBdRKfP?/F.C+Ed[?A:YP]EUfA0eX#R@+?G&eVDbE;W
6X_6KJ8L[SD4RZK]Z>,WcK9U#B-77GVZ[(M82I3@6?@3eIF>(d38J499T/KYL=NQ
4beBK0_Tf#f;#XQ9I>-A.T7,)./Sb,C@#3TJUYHe15R6EVPJfD\27#OP)_Q_-UXN
+FYDZ0:(>NH8I>RH1>RPCVQg\Fa(S^M5[;;U.LEVGCMF?Oc2QFK8dJ68?a>R[[;d
UgCA-J=@8AG\=IdddKDQB7fUX2d6<J))Y2[,P2+035aH6V+cD-GdKZ]\E,M_EV2Z
_QMe,:X\=XR@Q:6^@eaK\BZg=^2,,_7OdJJNdE>K5:T0g@\[S8[<WaG#&Yaa:/26
0922V6Z>A\adV^gR+[XQd9Y]NK?ScV6LT_S6A/d__]1@Z5W;Na:4Eg#P&XIZ1b_1
MEIbUCW1VdZBPSGb\8;G:d0(AKHNP[TSH0?YNAR5WbK?2S9XcFMNY-2I92BP>Se<
5K=4CdgH.0\6[W4g0<8:a4GW7MFJ8N+);8^]4LAI9ZS[P.G96(6E;c?AbH/.E69L
H61=LLKeB(_Og8235=FS:B3?RA)1ORC_TI/fP)a7B&;]^W[90^D7/E,WQ/RL-&(B
;=/(N2d3)aR1181U>#.Fb(e9).^?c-+MFY45Q64a9T5\KLd?X<Y?+@G=1a,e99c^
Z^9)9&W?[;N7IS:9f1)JaPY](=[b[.4,bFOFP<0&1QU/X/6X[TQ(PITUI@G9WOa^
6=4I&91^EAR\1S;aG#JW.9KdP_;?E,(/DB9^]5OM<0ZGa)(1\_aCfW?N&#Gb?<e0
[bYf^#fFYRRCO.\E)NbEIU+-8f:E;2#V:c)G;NIAaUdT_XYbg>?K5,Q.H(OUHXaH
5]CF3b;a+Ea+75e1?#V-N.TP_?3E;.=6NI#L6VFZ?.&4[_YMZT0XA2JN&.UEPNaH
R\B<>_c.gZ3O^3A.4b=..OE-6X\8&#+Z6>[=dO)Z)AKK0RV-<EgSa=W[;2><Ib=9
_O<(3WVB?<.d=M4F:CL,^3Q=,JOLFEg^9d=a:((8)U0I1W_g?8ANOV,aI;d0J/ZE
[\.6@)<53RcCK6&R7Q&L@H^)3=dY-:^CIRcG77SagST5<aYXJ^5H0IGbTU+218>.
TVc@ZI_-8W7N)aOI^S#@/\1&DPG03@E_KFCS=#H=-DYP<?)<U>K;+1#^L,)Ng_fe
X4<3,4R:4OHgGEZ@V&BMgZgGR<W.CG9.4EK0@VX&WR@7)1?=_(bNSKg5BS#KN\7U
AUb2AOA>TC:0JUNE\07ROad-8X-KC]W)WA+B);^G;f53?UaDIY?AY.W#?T0=B>/[
UgLd<1?D#AS<Y],25_6QY^^cg4,2581/;^K+C^3))dK7/OQ\28/T@.ON&c#SN@>+
[VTe;2)ca]2B08ff:8T+e7+X,b4-)KH&T]_bf]CgQ>#N)dGCZ[0NZAOIT-Z^IRO>
gAVbM)6F(4U-@<XX6.O?_0H?0F\ZX-J77;dfTW@TCS+[I#,JDTY[&9AZcOFHbO.Z
eY_-(SW:9OgP/b/+Z(K^;gN74OO)7K2_TD:ZG(4GV<bg3LI91T3BK?)C6><fX[J#
.4CS<DLegK<e7Jd2HL7<0\:OU?V.;:]D3f;EMbfB);95&Dc<)N[e21YF<6g=AV8B
X\GP#C)A1NB>\5LHeRg/fS\XfYTH0g9(-@,f/RC.R;@(KR:PbCA@+#dI,(RHC/?N
XNESa[e:WNVSBR[E4=R_8K#40@M\S3,]1UEH]bbE\^2bD#UT&15YFRIXEX\+,?L_
F89;KQb4^gGLP>QV9;F5TC,UA6G&TE;(a_V5eTBXM7b^-9C,.+DM:V.M2(K>&(^7
EG^d.1_4L.1gIa7K_M8PCQV(XDa2(E1#@[ANN7Fd+=@RIca<]4]TH(>=Q#a2fPSQ
X9-W@M/.EOg2<IgP1&D[(887aa\4TCFS\.D1cB/g@1PDgK#GCCIWG+c^VeaMU0JU
V_gTRROI46Ld6F#YW@dEXVRU.=e:Vf0;A6WWRP5TPe4c\M3326(,T(eHB?Z?-UR,
W[KQN38DMP1PS)3T)fQ]#P3[BNb+[gfX;b++:_LUZCEP@D;.dE<GO)PgcTe5XM\F
U@1I77L;1+;a:ADU^0TY6FW,Sb?Y;bDQQI47=?TG5G#.AgfVXV&,,P.W1=XdIF2@
GT9O<N-NOTX<Ef4W6,F0@FF>>bYbZX0Uf3bBAN:#QG3&G?4GF])1+R4:g=\Z3#TJ
4a4+DIO#CO6Q90)DSAI5;&]Y<0.]T;ICG-NGP87+X6GSbKfJOJ]VgC\JS:&a1A=_
a(M3MN1C)8JP27NbE4L&==+GH6CIOC;&J_U90cR(IeEIOO#AgPMbJ94E(&Nf14DB
JC7fW1Df1SJd-+cYU#B#C9]O48SJ2(2O@6;#@ZLU;82ad5QbX\C-Y1?S6#9/+)-9
L+a.-A?HNB<8EcHf9J^5-YJ2B7Ta)3O_P<5[2REQ&FLW8B5R[Jd8N]#9;#RR&AO>
;N4gW4Y=V^TJ3]NGUZ78gT.-=ZR85;[#,PdEIUXaSLRJcUNK>#@S]Eb]S8YD;1\^
E\-cN\Q=77:U5<]Pe^g3>N0ZTWcQLaCF,X25Gb,CDRG8Cd5BWeC^SEPHKY-cb1e4
K^bF)0V8Dd#K#LJU3XBJETJ/fA<>>OG(bGWV78E8_<@:/X@SN^E9:^6a,5>V#Aab
b83YXT[c,gD-FM_&N-ef\;71/O6d6;Q>]FcWO]J?@8I@c5?5+B&d=dU?bIJ3aYL=
84WL5.Z]=fO9H0UPU5<@.W--^@2NP)VIF9TZRN,N/_de;5A:_IW?J@8=8d1P?/V9
O+22SGY3UL]\Q32ETL@U9:BgQ(33NXJXS4+U[(SJI.YO[E[D>M_=9NVc9LWCTg:K
HNW.-H/XO&Q.MMKA5eCgY@0M(9C-Ke\F8LP,<bP>28P6d:U7LeaYdT>gH_YB<g5)
51Jag_=1V1H,.@WB3T0g\8@g@3DKa(dK8()G]]NN)C&4DYB.P6/cWbfGgIV+MgY;
3;1C3c@W:1W]3NGaKXH]We_36,Je=G-K33Td6#EC13IJ]eae@8?L^J;Oa)GILHH>
#T73?BIP_CAgCY,_G9C1,TS&]Q&H84.T./_X(3<.CW>7Ag/(TUg8Y?_OJCQ@_ebb
.e=bEP29NZ)X#]=G6V<21dKS\4?@XEC@\X0/3_,DH6?9AVeeE(T7Qg-;BNa4)0bW
)-1d0Jb^7dN1FH62A7&AW&Ie.SE+B=0-BDfGUSK[BE#<OG@e(><WX_<GWPU=KAA;
\4=fTd@+c>,]=K468bb:1X5YbM/Y#R-1W)S^BMHSdA,:PNETF1EYQ8#6g)C=R9?D
CFP9a)4a\^ENe1M_->K;=cK5)7@43)B_F:#[^B-UWJ3Z(40XHCW,6bC&#Y^=826U
3]_AG8)WeU2O:W9SeNdd5,Oa1UD\;S?RR-2;.2X6eH0.=BURN>I/DUUMD^B6&Q5c
FA=VEcKT_Z0V1W:BHgfGQg1eMBcT,OCHDWc1+OU.DdHOXFH+M?-c.R;F[(a89-3(
^H2FN5-NI1PV1>R/MfdfVR;LEX_ZARUB)dJ/gM.Z.9,Oa.4WHW;GJ^/eZ]G\7TF0
G@d_L9ag,B/];;.?KQ^fXCH,TY5V](DU&@LS@BO+0=CWbAX-c,EMO3Z1MaQAS)P)
@#.Y?P>PTIS3BJNV7^O,8egKLF#TYJDJ,Q/>d3[bK-Q9Y3CRKa+(JYVPPDG3\eMM
RL?g,AW2P)OUEP>DNU<:RUX^3GADXg;d#C(:+<HQM/b5#c.EcHNI>-e;fC\[<QB>
bXVeP0_B-GJ&Q(Z1E4YK(>.a+fYUL+5YH^D=RDZ=fXfRR6K&5=@R-AGMVdUE@7f.
8B_6DB]RF&c:<9Ya7:UM<&)VV8dO2INWAO;F.;2D4DO;,@?T38O_SaF.S<f=&1<T
0-&M7KU,e1U-S:,9E[P>H+]&^Rf2QGag#7Od,^?4_8<eWH8LK=I;>c@agU8>ID1R
SIOPRBN?CeD8eDe/(#\D_A>]H;bLMbB\,f;U(1Gb&W/d(_,?5f^LD48F8_g:/:M?
T)g&EB5EK>-b:#fJc:3GU?(gXIaaV8Z/I3IaH]A28>@0P1&LY7<SebN-//:aEe#/
O_QP0&4/P#2PB/cA<-L=C<#[T^adFW0XFQcf<5gJ18NULa[6N65B\cIJ(e)Gg@#8
ZV3[?IWT0D<6J,[NXKM(dJ851M;/HdffHR=F+92H40=ZU)31DD[;L?J]\]C.=Y#b
O+1)Q7PTY&74d?P/Xb-c_6QeOESbV(ELC0T;9D.SPV@_9,8Ue&d.;LcAB0.UXL6:
0HUYPA4RR/LV=CO,-2&ET<6#T[U1(3bMKIK>4Kf,9QGaf>3aGKTX-R2&:3ACCO#-
9->E&\0_>/T,bdBTc1)SLZ/A6=7R\H>]d.#,33U&gWUSU0U+3XO^gA5D>G=O-Q/B
gg9DdGZFMI;K,Lf@Q/YUA7.G5R,<IA@8DN]ZaM?>_Pe_7c=Z:e=e#M]c-P=HGeMU
A5Dd7>_:(@<[L>JSN1^b_Y\<#eS<W=I[>]I/f<^Fa>90\X/]e+RTa>O]O2;\FHOJ
&WS9.>0>7/f&,a6=YYcU(,[^^1_Y5ND-dF0I,_/^XD9D,U-5?6YS\1YA;?NPST\]
C^;a3#T?.AbJP:CJMI8BWSDX4[]ATJX/e<;3#SCAAMB(7J@R.d;4B9^aLSFc[N;c
_P2FC)V;T.D:#TO)gI74;ASF&[K\.8e@;Jb>NCdR+c/)N0^;SFf5aQVcdb6-cc;3
](\/F1^c=I1#a=4fWH3HGV+4B(I1dN2[]OAK_b\E;cVYe:,>#Z[(K?\2FTX/7)3f
O<;W.^/@b/HZ9AU;J.R;2-8M:<I9UJ;\/<,8\(MY9N)7.dfNZb=9A5_PE?\4VEMZ
7a<cEdC613f7/]e7TWA#9F(64#5)NW66>R.]\F_e<[\&G_-\=J&0RG[NP2gWg49Y
(6;>#H79H:_C;QAXV6BS]#B0K_99)=^a+._<c0&b;09Y_Y]2\N95KFI0K?QONE6c
Rf0+WB/:ZNJ2<1LNJTRUg.(ee=;,D@M[1Aa[FB^6LXe7GUU)SeaM=4X<88f8T9+e
XceMD7e-TT@5f4,CS_)1Ue[M7U9@:Ze+?Qf88FZZTS_RG25:9@3M891@92AE@\;E
;dM-&?P6MXGb5>T?#ZVK89/J=VA-E>e<c5HDH/2.;:X;T,T9&1/YU08+9K^PMg5b
P/<WIQ1HVBOScKA\JP[/IBYa_82,1:(5@Q4WJ>e0.PU^+QRN@28][]/Q9&;M[/YT
fR&,QFVY0baE4>+ML9;]BOY]FHYK=8]BT;7S2>(GD:\bL5-9(L+Y?aC1QCg0MOd,
;:-IPQEYV0+7a]@L=6NFWY(OJC<CW#YE#/+RQcOZ^:WKD/a;X:-<URfa@F9,UE].
:[OSMCED;#K7S&JQF=^a?L95BU=KP+1Z>8^=L0.NY6&@:3M-83H9CMe5dY#;?&Q6
IJ#EMP[A8;)V=aN+cT->)[3cD,F;Ha[Q):>../Of\^[KNe0E?#H-B_J\#OEIO>ed
IQ0FAHQ4PO2A2a^M^Wg@<Nb_#3L)9IS8)-ODN)V95)O5Tf/TE#\X5QTEcR^W.U8R
a>V8b7F6W/]/U]_1);YdEFH9.951@AOOL9<US\V5ZS;5+XT\0+K+?S-?K7IdQDLT
E+[;8?,&.EF-NUg)NN\585BYD@=E,_cJId.[SU50#/FPS-3U3.>,E^)V,2X_H;KV
=8Z.^X1MQ@6J=YIVU84b48DLed0C/a>MZP3G9UecRcH;UQL83UP(PGA\0,#@VeWW
9@egVWOCT@GR)FL>])6RaAd((OHOd9N4eQ,f0SJGC[Va_2XFM-[MbM#+RILFBJIU
L41M2E9N(_G/FO_:5\+Q806[AV.7CMEUI[>Yg61UP<WC#_1NZ+X(<g4U7<8873K/
WA.1\6M:>8>(.57SYHEP/Wde4F^1J<Xd/E^bTM.GW-5JC)WX17&:JA;C-ICd0/FF
d#:RDBEV/RVOF\f8G>,0S-K5N)94M1S6U)W75];S>\#=@0O[[8eFD;^Z]KMHD.C&
Z[PL4Z]]#=]:;S]HC_?VZ3#>A9(If&8Bf3S4^R^Jd\YLW7R)CLE?00/&Ig?gR+=B
4f_E0P?G>Ja<1G4A3]T3HM(13;MM-_PTDZ.X,NX3WAf-6NTQSQ\dXdF[N\QUYfI>
IY(;(SOSX=>0E\Nb?/V49=JdW#-BS>FaN67GOK4];FdU)Mee:]I8U3]>UU#.YbG&
JF[a-Y(g-:?@OGMcE_@@UdC7]/H#XacD=dKV4&3E57)8187GLU-7(MG2fQ)g#[3K
[O]--FG+6M=&bc]g3&FKHc(/e=I-FNJ3-X8S/AR09V>.?ATTdeb)N6ABAfX-GA(A
7^?H3VO@:T\fH6.]VS]LFJ]&7GQ8W_=-143fH/aF^>HERM)d^J=cc_X;g,4aC#G_
(P]B5c:bfL\dGNH-J\PZGg]c#6--f.5/W+@<CS,THfBCL_Zef_Y>H67@&[8BZ1.^
GK,C/cVMY^d(eBW+KW25UFUP]5HBE:XgV?FWI:a@)^(+]0W952YNN_Z2QZG/][8X
JKM(#X5PQX,[A@D8?b5W<+HX<UY2.CfC.GGT;,+LR4AMd:3gL,1VA/cLMTL4U;E=
TA?M;F.</Me2Dd_&YAKCA<XD_CTF42_:ZJW8R]+-6FcP(J&.44EbIOeg9IRcRfL8
D<YA9gPWPJA^I:VSMZ+-J,)<,BF=]5W;LNEGW^MaM8Y:YLFY)-#e36^F9Y.21LRL
:(YTJQXR^_2])=G5+]3^&_c5IW,fcF.Wd:&(Kg6UO6T-&&@_-Qf5FM5&Bd?2#2@:
Qad[a2a7P2HAFMAQ.<:8=IbN:7=MP<PI:;;Ae)agML/X2QR?5FN#A]3:&<9d-IJ5
DE^ZB4VZI3R?N1[5#^Y?O#Gc\#MVa[O=c-=?8,b_F]/7T]^-?GUF_Z4S/QA>)OBH
7?1@2&AK\]WEQ3](?9H]??HDE2;>9>#,<;].K3?E:/_&OM_[LM+)>(Y:c_X1<+4(
gD9abc(Yd^9?PN3U[3KXV&P^?RTf6R1gK=.;G9@eH&fYOdYQDKQ+?^X8[&.7F?L/
3+1OBO.I#\X+Q&,f6K+6dYd#/e>f+(ED45,<A4FK02Q:8S(0#OMfBPH<JT]:_.[G
La\Z(b^6EO79U+SN#]gB+9aBBCE?PTd;e7/A5X<aa/AI2/2#6QNGMf?0e&FJJVVc
Z6aXB90+g8a:bVV(<P9J,.eXT>Z:LKEQ]&J_&;N-]Z[bJ,,8;bC^KGWB/R@VQ3I^
=2XQ9@@L5QJUF=SVgN1[<?=65DgL55-09@==5O3Z-EdES&L^;c)@77MBRUV+e0G:
U,Y^296Xf(P77IFS55N_/<@b3DV(dBI+J(LbZ^)8JeM8M46d6d[Q)&H4WccS&RUe
U+7O&&@)2<\&]Z>@F21Y#-+G,(,8TU\c_.LO)NW1/NG)+)Q?A=Z0d[3WKaD7QRQ&
QI>++YcFV+R>/W6F\GDTN_R;?X;WF.e4214O,RBM3_#<WT_<&RF8#M:6c]d\.U,\
A9LDNYbO]c66UBPR<YU&VdC2I]TcJUM1<TM+<.g>5^0E-&H[b1#(]0A=F26YE8^0
:BA[RSO4>&P,\_1CXGfSB3,dLQS&5WCK1dQeaAPZN?10bc=&>Y9A)?c79Z>F+OUL
D&A?<a6+HVg.&QSg]6&&E<+??=J3J^GQb9@I\FRIba\,0f+6]-32SUD&H?dK5]W9
)/G.31MbX/E&AVS\1@MQQ66c.QNK-<[0.G.8U-6c.,1\(9CO--7<UTaQXB:8D@c>
0XcP0@?f&HgRVL,3O)6]3d[-U2A?.WfKBV7e9cO6?PCA,J#YVbIQM&&[SH.b3a4K
54..@CbEabGgC)-CV6ad^F(J4Mg\>XALMIRP-6:RO-gf;g,:e;gQ60?U9YP^AE0.
GSMRVe]MF//ST6Nf?g06.SW8JB#4c>^P>:;>2Y7=11RT<;0M&Q;f=a9:^U]eG@D[
-26SBS/Q#a<(H<>NT<5KT/bXa_+C_YWJ5BZYU-F;2agD[(Oe#\^Nd+>fZ]WP3R(^
V<<K1fT1K8b25W09eO>EAY<[-c(U8cBf/XVYJWGg<]7c#HMWE7a6VH7/1a<)#V;(
UK#QBT4UFXWJHDZQ>Le,-?HY;[M^c>9S9KCY^0+HC&)FPX?XJSHSIfbY1I\T#7\H
(B>LDc&ZRU]E;e,eP^R)]<3d?V=AT\#?KB]/:O>JQ.]5UCRM.S7Ef5W-;Kb[@N)?
+fM8;_M\P++RYbe&I&G&?O:b/4LeM?KZ]TXY:V,]g<8@O>CK=W(,Qd-E/1bA.S5f
8fe&8T4_,b]f?0?^H-30fT)f.^;HcL8D:TW7_DORV>9U@Z>1W)\GHNDJ6AI<9@-4
>:J>MJXLbHeAU77\ZZN_P1H6a/[/JG39HG0=KZARQ2X.,UaB7b)&2-#)7A[TG#01
A_E/IT172PWQ/F[H6fV,QBN&?2L6Z9>Fg=H.caX6I;\bI^(4<1HP_GK<KH;c+8GS
RYIaH6SE9aKPO=2HBL-QPOgN45#O(UefF-X=LC<7UJW#;;a1QNFUGfY<eE6[+8L5
2WeA8NQ7[\_=LON_Be;Q#-O<fIc;+8a(P+KB5_@ZL,FMC__Y,gBb\<?\&Y1.]Nca
WZ+gN(LOO-X^5e+1cIf_K6eGG7/C3e@f[DI).;[bL==LRV^[<e&.@[<9L]_5^b3>
CSgF;XT._eV,:)cOX7BM>HU&>g[@7E,H3]=/?W&[eJAIf]=CA/HHQNN<TbD:PVP>
WE>[^ZCJ9c0[[(XCM:LO&<f9DE7EXObB)[P)M?)AF1S.X8:[CB_Fa.D#SeSL&FUD
5c.2<19?FIHX9>Q\&YPgNK_5da/+dBV:=>eDaM2_<S#0M5,,\CKD_AWc7Hf&#9@d
GU4X=NL.\M)IUR;QeDF;H4OC&++a>F@.@(U?,6)3WMY-33g=g&5A@YWFFg[<M<@G
R(=@>U2&7[<R,M=P3/10<9I-2_X<2M4-KF9dQM2gU/C0YM5<YW-B==OdKa5QgNU.
?,;e>M:f?5;C(b\-PTdX2cAQCRSKK6@Q<VNSI>H);eb;6&[e?P274[)T:WgV?LH-
M7dY>:<[TBS\(/:FR:8<8cNeO0+[cd<TP7>)9GOUH(bL-W1M4Of<Z;FfFY;]FLfR
MC++>g>c\?R,.>_76C+=DfFX)G^C+L23_KK2aW2[A>1E;0:M:;CJB/#,NQULgXD]
Uf@E]e>eRd8NeM:R^7)@L\;E1_5EWMC)&(U=7+4?>E?f#0DD0RfBVJ+\J&.?c5:T
<^@&VMY3^:7g86?_f417)=).;7R^d=:,,8CQc3IZ6gNRUSa^PMD_J=8O;3TbXPG?
cOO8).gZUMD8XZd.2<Z+S?V+O?C4d-&)I^55_=+dJP070\F.[&XTaV-P9N?T_6)&
4A?MSa?PYY&D+\?Uf_M&9FRPQTVKE@(BTSQF1Y)>B4KU28;fPcYg8ff#AS4[WVda
8S=R\34N4M7[I6g&7K?GS+KgG]&<77da>f[49&9)Cf+(>=?KUXdP#&V0QCFJJ8B;
aW[,R^(fC2GL<eBJ7Bb&M23P,@BH7PCd:ZE^6KA_6,EO^J+.Y;OaQE#Tf[dMRS>-
CWO<)[&4A9+D0AW8+e#.41X3Q,[5B?0M(b=/YD&X,[-VC^)44VfE8+J0747cE+@3
[0\1LVd\_Y<fe<@/JGg\U(07J\;E8BeVR>K\5WB33b#T3+FU1:a<D4RR@7=?eW,#
4:032(<TE>/FQC(@C^]=7fW61e)BK53ETUD<O1;S;HXa3RZV#Dd#\8.e3E30cYX1
)/_D(Te<&M<\LF;#-DePY2;P^H12\V;Vg+f>f@H34Fg5STg>PCH^G(4+M0VW93\>
06=:?H#].2<;5Ag0I=R3d#;.MdY<]AC4\/9N&cf^fPV=/C+AH8EdD2UX#=4D,,O]
T<7/+XHbUZd&>DKYGU#TfV6e(d,Z5@/8OF=bQ9W)H(]Z4:,N:60?d#E#5(]S.2g:
SDGNS-P9L,0:XG/^Sd06Q;EgZ;6g)-[.fL6XPX>(,M\gH/#OgGWJS1:S\DHA)W>0
#<?.3PCfE0AeGYMXI8+#,VX\XOeS4K\K>P6U^Q8TEFN20V&:g^AUbES\]K1U=\>L
5?,:+MJ[^c;?36YB39H@.dF@_A&g.+UX9Ob1#]36Yg8/1M??4eYU)FgL@F+G^?CR
[HMK/34>)Y7;VdD6I;NKDT>M7A,IA?ABd\1<?Z1?9U+]2-D6]9Zb8fGAUT(^#X1I
QIW8gU[RfZXbM]aA&[.&^g;QUC1/?:eO9V\Scb[S]L&&a14bF0(DVYP<c7>Z=>1dV$
`endprotected

    
`ifdef SVT_UVM_TECHNOLOGY
   typedef uvm_tlm_fifo#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
`elsif SVT_OVM_TECHNOLOGY
   typedef tlm_fifo#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
`elsif SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_ahb_master_transaction) svt_ahb_master_transaction_channel;
  typedef vmm_channel_typed#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
  `vmm_atomic_gen(svt_ahb_master_transaction, "VMM (Atomic) Generator for svt_ahb_master_transaction data objects")
  `vmm_scenario_gen(svt_ahb_master_transaction, "VMM (Scenario) Generator for svt_ahb_master_transaction data objects")
`endif 

`endif // GUARD_SVT_AHB_MASTER_TRANSACTION_SV
