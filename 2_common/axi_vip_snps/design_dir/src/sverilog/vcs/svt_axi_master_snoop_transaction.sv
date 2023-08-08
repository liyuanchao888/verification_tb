
`ifndef GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_port_configuration;

/**
    The master snoop transaction class extends from the snoop transaction base
    class svt_axi_snoop_transaction. The master snoop transaction class contains
    the constraints for master specific members in the base transaction class.
    At the end of each transaction, the master VIP component provides object of
    type svt_axi_master_snoop_transaction from its analysis ports, in active and
    passive mode.
 */
class svt_axi_master_snoop_transaction extends svt_axi_snoop_transaction; 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_snoop_transaction)
  `endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_snoop_transaction", "class" );
  `endif

 
//vcs_vip_protect 
`protected
RF5c/<22FJ+GN-T;0>L?DH4U9:&OT\\#g(6E,)-IEg[g6^&4<&C.5(13GUFV0,fb
10ge]_BU87KTYZZ\^3QTD:/7b2K=L(gZ>e4-DbTQFef](3DIES?L/&_.aS\Zd,LY
g3OJ3ORPbOTB=->9MQ^NV-I0fJJ&457J4GWeSUb0=NaA-EU,7<fROa>/I#?Ab3FR
ARddACI0@0(fY>)0ga6fX+M9@0F9KH<1;;MVF-ZHgV(Ab.9&C]VX7Q\&GWL0@+Jg
6:bB5[(M,(,)PQ2X+N;O>[#]8A,0)WVLJ\Xf])D3URZ8-J?K0L41UIDDU8ZMf=ML
&M:))=4&J1#U\=Q9H3-1d.GN[e@W8f(\^)\Kd46Y>_,49^1fg>,M;F8^JA\<J#4)
\2,TP:FNa/a>E-<.SA18)?&cfJ],PFfV[(abd6+ZYQfJBCIA#X>YR(CN-e;b\33M
.da&DSSE<3T0RCF.M=Qf+97;:5&@\eK,4)XFfTK,_\PZc2F-3D?U_K(4:f/D]Kc[
LXH\LF./A=8RVV9;Y/X1.JC[R<89EG7UT8Z0I):U+ZRbC\S426YZVI?@I&cM1@O2
L8-H2F+=RCg4]N8#I14HIW(3@HD_)8_9#L?d4X6f@G15f/3<B;Mgbd_;S8;L?R#Z
ZD&?aW<Y#>M<O61RU3[^TH>T\)XVZYHM#Q8P7RI2DAB]5RU50HVT(;./\gJ9\IQT
CMC1].NS7f+E,7+H-[0MGDPOYX_W]LfKa=,>8fQ#0JB4?M[/\RO2ABZE;d+>12Y6
GA7=QRI@5(IM:ebGe?cgP\-KeZBG[;[Ofd=(A\YdE,N4<gW&FeD0]+FT46Q5+Nf/
BS#Z0]78AGDN^]E1+;2W_J6A&;bL/P2X)/,TDRW<[.Q&YL/V&^MGV6UB2,J53D,@
39=5]=-YPLL?WO00KG>=ZGdWe>9XQ,;gF>]DF6+FD._=\AYBJF-gJSKY&4)4FP.M
[3)93<HQAX,G,CZ1F?c=Ma)2g#GFKAX)_(NU=g&DVPF@3K@RHb:?JN49?EgX.JNK
D[e?=V(/J4AORZE0N0_(dZ30D1=D=K&dN6cf?(PSH2a1@,Y^/Za^1M/a_^U_B2e#
-=g95U=&7#)5fIQ6;#=GWY9A39H0@C-2XcCE8.<7-ER=3@MLA+SAR.M/DY-3M,_U
QcQ7XBYKR)/R6:bSH4YBG<?I4U(A,ORd#,(,;0E9E.UfW#QGGg@I,9cD>)+[/JD_
6?XP_Mb__]QfUMHADCF=EC8)f[12-aE4Vd@bMf]\?aN@<7&;M_\KF+-[84_W+CE@
9KO?&))J/_G\]^=UeHCXV+?Z]VT1Re=g\cD;^PN>+_TR]=],.4CTF\EYS_8.@Gd4
1P.aV:a@CIRID5EYJQY2GD,GI_Z2F_(U1U=]6NIVFIc:IEX62IW0EOC<;]d9=3&V
__86S42HKC/T13\1T;\De=Z3];O+IPT]Fb=-#:JHgTcH:<GX571D&AfJa[WQFXTg
7f#W19bOW/?.XSXc4X]/UPV,ZN=M^@@V2?[Igg.>#Q;]_;]2M?#XU?]DHb2Z(M]V
EWa/KVH9^TI-Q6FXX3)1\S=Se^<Q05K?FPW6&eXKVaA^++AT=7<Ve2-,>6c/W@CF
>Y9588W\^=?7gCHA1:?3U&K#KS5Y<__ReA).OS\4]]&8<=B/9+OWW0c(<ASGR,W>
7<de0(+]F^-f)<d_TX9MNV;;-e2-DFW23J0]L8Z28+?H\@MW6g/HC&L(S]VMO7Y9
GXI)].=K-3)eQMFQbB&G30C25/_Y?G)<^P,MZ,a/5^KX5Wc8A07a,SPa,6CeMOfe
9D?b-4-_WCXGcGMFH-M7:LY2fGaQ12;RU[18R[2(:;OPaT;L1S=+VG8<;C(5EZ<;
XZ#4MUd<G_,)X3[G&,_WHTDB80?cK)>b:-J841fR5/IT/@R\-0L0a,CL<_)39S62
;7Dd6JBf38^>UXEgIC@c4=?/X.9JS?,WP]W6<99f+9/gMb2[/JRL,(RBHFaGQZa,
aOOS2,/AG5(IWf6+d2G.AQ56=1IMc36GgIBOY::]a&V]L]W]CL_X1H0-OC0c.?LC
gH<OO&J,]CU#I-aL-d83QVR\CT#LGGa>^OF,>,5&<HScN0.gd_^b;[V15S;@WE:4
c_4&LODeH=P3E5V=J1ZFX-/ZV2H_F7__]I\1M0?3LRXWPFS5+b;<Za(:d;(G&J6M
PBJXQ5W_KX]eZ?Gf)b[&35eA3#+S<TCCREKFY\@;f-MgI\6f]]QNecd\.H_;?;]C
Y:gJN[[SRLN7([C)Cc_Ed?JeM?>T-O@FHO5ADQC8:Y8Y>>IaSJ+Z/[S4AH#[9KaF
c;eML96b[4AH^b&M&e<B7+(J6P-SRBeK4VX/O#<&Tb1C7^[1O/IgFJdKE8Za@P.4
gOGc71(FO2Z/Lc6/PIH^D=OW..f\WgaAGNC?LEY&,;,:+X]FQ;-^L.\gL:df0)1f
6]UN=[S0B#[31F5S.(5BO#ERO7[d___+X8/F^O)bY+JZATcF^.J19LLEV7/Lad#X
L;]I;)gR6gfI?;^1Tb?Z)/6SFZ?LSCP.)BM.M5,U;)>Je<dC(84P8DFe@GG/V?fZ
)MbFTMG>aU1#T<>O9HQC?@-L7dDF,XK09;F#c;OfQPRJ-M?Y-M?T,eB,--^71/-2
5==+;F?Mg]MdVFC1cLSG3FND<I>S-3NV-K<D-I+X###PV&/Q:]G1;)8@T.Z28:8f
32.=,LH(,[^@Z>]RJ)bKQA@BNYR9_S_(.SfO;4N#VL#M&9S:TZ]X7f751.8bWB:N
HX<O2[-V(FZ?GTVdRSMPgWXVP]3IdFHQa::PDP:V)ZMcBc_A]/Hf.2;&3/3LVTNb
6+KW#^X1;G;;a=.YN3UP_-bAQY6Q.R>OE80UZeWN4MgQ>?VG\/E&WNZQ26&I(9QN
LMIK@5DfK5L_LK((8dV059)bV55fY^;M1_@J;P,_N6GUYSK8ACX(<Q8E(:Je6O7b
&<N_=e[C4W[RY2.L<fgDXe\^05X#b:R4XBUVW.P(EIdNWI3R@dWeQ)PJ6f6DZI))
TN5T\MJ507U\-S?F2#6R&fcfD&]CC-3.\FPI1)0KH\^FLL[HSB[CZK?0f4)[GK/2
&I,B9H?:NME_Wb8QT8P&f0>Yca8+f^UI+E4B96@F4G]/:RT6GE/&^&:_F4(83_CU
U7+J\?DX8DBJg>B\E84e_0(76aR7:99@&]D=PZAQ&d9(@LW1e#4Ff5])E)0>A6+M
7(N\?_?.e1]OO]g\E.D.ZH-,C1gAOJ@OUXdON[N=NH24<Kd0(^HUU-3J11[GF[=&
4#:^:SMYDRM8)1HfJ3=ZX=M7OPPO174aJ2I)Kd\TeQ&W:YNMM9R5)?)_LaD+04Z1
A?0W\EO_20g=&X2QXfg3b/^K#F+MOFMD2Lge^X;T>E4ffR+/Of3F<\:&17&DY>[-
Q,;3HP#:e1([Pa)<G\;)FId?@CUDO12OZ(Q6e-7EE/1a>L=f[1R.TEZ/,ZL#9KN)
1PZO+U?[/^bP08aD^dHc3;.gGH.RgP]Y)6FNgcHZ+RKU^^f>X4FJ^0eVSf:61,AD
(T6+Tg4X+DYD)#2A;^.I.<&8g6=d=9A4/B?g[>GUS<D0d?FI:NHA#d-7Bg_@2ZMP
Kf[3W@35Z>--9YPG02G^:JeX@YY&d7OX;Tb;/QN.ZY;9N0^\RSU.7;a(4=a_4L6C
C_PXX+X].XDXIL(2bX?5)T0cGQKg#Uc>GMaTeZAG,)Yb8AdP]UHAO=a_\OEH2.eH
[2KP]]06d8S,<USa;]eFS(N?275d-Y(A=@U]OZ&]5\X#4(B9ROTQ>MLI9G:R<9MF
<U<F<NLQe?@+1ERf7+@OK)KW^bB?NIVe6:40Q_>)L5/K><O8#R?<KbgNB&YDM\V;
?6Q[4[TQ:Q63]>Z2KbD6#,PD-;#;3VKH^_Q5&4FX0495YZdK<\VTT9Rb5C4A8>cI
gJR(V\;-)R6ZRHE9<-3<4J@B7Z_GaDE[:bGG;/7d4]=c;Mc6-K))#QGL+beH.[1F
K14NR1_GD17TK\Y-gI:-:4RL_[Tb)E+E)QXX?:[)P;KA;P[5RX,eXFC#/0;-N=b8
<RYDRCcW7@Z3XeM[a,/cKXMS?RU8E:5+</f^3ae85];D(Mf<^AB]DS)Jg#f#4TO_
a<AJL&@TUc:VVLMBJd+>\&GT=MX(BZ8=U=\?c/E/RfR2g1cMA5[#KIE]]/2AYMR,
LEAE?g--bT)X9YLJJ:<X\_a:K\8XfG/H_263]NY51.)]Zb3d,94NTVM)ABZd[V29
5+-=/US)4DNeNVE>&R1Z.N-[U?OI35-:<9\49HHL85J.=]gf83eJAHILJ.g)02NP
Xf4,)edKgBIDD1-F3<4N0@e2WQ^QMR#]]POGZOH71c:(1fAC_HH;c?cf,Be4X06+
Za-EKAR0AD@8PA1J^RYH&O;L\8XcH-55,OV&WI+d9S?IgT]IAY95M+E)-&\ADO[>
UfD]E65<GN?^AE2,B-fX-@6[3FA27OIfUWa4VL6S</[9Xb)#XK.d.6dgVW0-T:3R
V0)3X,/X=J8XZ6&_602?aVQE;-7V6,2g=,I,&J=RD2#QY>TR^[@^Vd_<W:5Fc:#0
6#[+/e3:Y6O^EI2\]>UZ6K2gN4D.LF&E&][^:5YgXg)D)e2f74^M\1AG\gLN,\<\
9Z^.O@SYM&&I.bY=>/M_=G]+HDe++7K+0^TO#@6J;.=\0+C)f.NDS3c77YMAJ>X9
;f3>dAaY_9WYaNNQbF1_)1<8;ML=2\<:EF=65LHTJU[J3U0/R2=,4V/(@NU2SRCN
>-g;W<Q#=.DAg??Q)/4S:IW??AR\Q=X(/SAHdBTc,Z^/UQ[/2_^AdF\1B7_J6Bd)
4,ed)[EGF06S,4(X<)=<;5O;>><)R;\dB67CQ9#BTM2aB_X/;.7[APOE4/?a)F;+
cCB)ZCZ+O3P8-GeZ&G95\;?ZUFVbXWc@37A,76?PC,gV?d01:9IZ-eaW11]>>4F3
\.a\4UFWSX#->^4G/eU<>E?>^3137M;BAcCS2BSB[U-f8<9NOWcTXgZ2JTE4S?JJ
f)EJ(3I8ON^N8TD);^D?SYLXS[]&JLR0V@TM0&8eBSG;WGHC9Mf\f:\MN/d=JeG/
7gL1SMZUX:NK]42Ie+DH(4HEG:^NA]K5SJ.=OG-TSTOad8RFZ1EBf6E)F(TI:PP:
fA-OA+\D;C-&7:cK>02DS2g2cP@BT8ZZFaJQd+DW/+bg^#0#0TS^aOZX;UYMN20C
6,WE?OPf]1MH;\-]d=HN;][)SC2)[5=E0&]UG+C<31EU?ZT0[7,OcV:8Q21IW^T>
GFCM8/-5._Dc(EgZ&(JCPK(&<J,V&,04]/^M.D9=JSW\S3KL>)F)D7Xe-VS@0Ab4
M#PHC6;[7OJPF)9aMRHXE_-9G>WA2PBA<QTb>f4eg2bCgMJS@L]3#7C>[fI)^3Nf
AO-V7AL=XU5[V(aMNQDDJLWLCf?^\\Z04C4#(Z#U<=d#+e,d;#&JXQZG)([^H_L:
@#&WGQ?)B?gNHgEe,L9fA)&Z2.&QH<a:T-WBg4XRfJ>OLAK5?BJ=TAe,<3Rd1?<_
P2/W:H(>&dKM(CJD#cD5(XU+(BQ<_QA/aP/aY,V/-X4Y83dKId[PM2f#Db\ZW14g
)LA0H1E+&A]LCE,E>\AJ<:VVM&L.I<).WAX=aO5VWA#;3C_JEP\RS<b<[c40V/J\
-@^UAEWQ5dc_8+)aO7[+)194)@KUHX4M\;B])8&\:#>HC4GVMJ@OUUJ[^#e8D]B+
O4TV5cRTV=R^eD@U,9:]dcX4J[._Q_C\/?9c([0OdK=8DLF;OA6QB(#7a.Q69XGL
C06632X-W>HeBY:H8GOKPS&VQF/NL9)W/(;cCbHa]ZH6edIC>GE8)DQY08X+MES)
VIT8Z@_PSW3LISc\K;N_/7aQ\8.KZW&=;PcMO>b@afd(@O?.c)V.IL,2-N+-9>gP
d@I0&g06)XVUO^\MNEK:MX#D:Yc\>P?R=Y03>:5dR[2UL=Z9FB6AVXDSUgd.UL_:
GcRca5?6;3U]\)3ZD;6NX\U3Q>HRAX-5XD?DaJ^BQ,],JMHAE7U,cC#eNG1fI(0&
I&F.bbNN6A)e_(2LB]P#>LQC,/5^.&O=GPCe1532;L=8M7NB39(O@)_Wd2[7cc]F
]LA21c#A[]>G+V&XA1077PWB>a>;\<^U&a6aY/;(/DH80V?/3J7@V]03D;=I7Uc\
24B/WEK9Z)7JP3<E_^W+eL@-,IaaM:U0.@[A[Jfe\Tf=SOKRUZ55L(eDb4&K<1E2
8,WDG)[)9)G(5fSZ,<-_01^42LSWJ@eYE0U./CD-08C9=2,c^8bC?A5<GVb?Ia1b
>Z\.c&,\bC][eHX\YPY)_0IA\Z?dB)_DR=gMg-N7B&/VJ1RBSKK=YZI_D2XZU77C
3/S8@#XE_/^a9=g;ON@-MY?^)2;eMdT2QQ[J#1K>S=.T9]Y8O<>c.Vc)0Q.VJ^_V
+>,?5G6Z6+B?4,J;TMCQ<eZB4d9-7N-]\L<C#9@K,XH&&Ygf<6eBZSPT#030H80H
)8\feK_Aa(V;10#QJ5YG5aZ;4;04ITfDW,Z:c7dPB2eD&Q4F^T2#Q]:JJ4W&?E[6
b1D4]gg(A;9PBUUGTZ+18fZ8RF<b+F?d..2_RT5+E.Ae0^4:6g93W8,&U0-0PWe&
[?OWV63:RdU6#PeG45Yd?3M]E&&8K_b-;7c>EcSE=@g[>+;EKEVTV5A42;dfP6Y/
A:gHNK>36c-GNc\G>2-2@@9<a>4#O8I/ccZ@WJ4SfeW,\\3ZVQYQ2g+cJ]U4@-HC
F)F;a>]cZQZ70SC70V<9V^M7BM@HH)@g[B9=#:+6]2VU=(HbbWW//J5H\DDMZHPC
M\@LUB5GVP?7.1QJ2_^Jg)BOS)9C#?Qe(R9(]P7-I-5&;Mfc^-\TWURSJ[V#,2IX
5&IR:4B)>GE1KA3FI;:DdaOM_@GRK:.ALHcB:=c]f+L=f+\C^/N\c34&eE0:@S.I
Qg:4TZ6YRa_@,1Hf@]NJeTCC(-#bg30#I&Q]F\/HO0N3[2XJJF-gCZ_NM&cTHf&_
g[A9#7&b&EOSF_U9g9Y5&3NHC4;gAJOgJ1#g__;\>+5)]+B>Y::F8],:.FH7,BF1
ZT)<ec6ZGDdC<(TYSgVO&0IR]:2a9/(0TEQOE,28<^LRf:2TB-1XEBB3b4BB&,eJ
d\_V6S]JS=G?U0]Q)<4R0cS=;Z+<(4KfgEBGPHbgbD<YVfTGC2IQ)Je>3b4;U>Bc
Og2Z4-NIfNdP8>XGcCe5]F:#cCZ(4Z2X]6IE+L@Kba(b.79gK1B[]b)fbG9(Y0W^
C9DedB[c9NaNf,>4EcJP1c#(>Zf<N+_e(.9(SZ7Q+&T/8BW#,e+K@CKV0[NHL<Ub
KWEF?.OWU=Hb1bY09?5ZJ.BPB-@NIU0-Z2ISO-ZBH(Q8T3M?)dg^?Rd,UfAcOZD-
J;]^W+LI90]38)cE@KS#<5PM,V(H.33#CSHD]1AV1>=34\A]B1#KaXE5b:5:-,<Z
4+M9B[W\SJ<SK=^Q5agX2;AX=?aT:H@BFZJ.\ccT8g[[JX#_6(#5MA9V/PM)FBa8
2cVAK_d]X>K1,2\/d=a(;fH3f2VfeNCO?)KK7[Ze[dFHAK31E3^H7U.HZ6O)^dbU
MV^++PBE@b4ZX)-a1_2YU>/M,TV&<@<:49CJPeYO/U^1J/;^ef+V&eQ;.fBG4;\&
/fX]3A:(VRgFT,4RLM3__AHeG9/(^GU-67CYYZ(He(PSX=(U/[&5_A)0a61(XGT@
K-3gI1f+7&NGbHBW0a2J_RZ01eMX6P3@R./30YN96@;;F99]K3KPYGHKZIcHJ-A.
Re6CD]1Pa96G.&Y@N-LR38E_.dKJ[A\\gFdNa^Da(,0XBd:7A,[T#])/_Z3.Y,/g
1(JVKS]DPJ(2fg#;V+12VAPd6C.06W\<^2fI1>^;][VSa7JP@I6Se[+gTWa.d9WI
1K_S=:eHF_YE,MeRJXPf9,+ca-=_@SM]]]L.gO?;5,/HG,.)RZ?MHa/AeX)a;0AB
RO8)&HC;M5;WG\H>/cgc^RUV7@\&3^[d6DD(DPXCE&+;7U;:KWZRT>b;Y&9KM.AR
?MFL/ZFOeUJ]&?[21(QMR><<c)W0H??bEd<^8QZWLE,MXbD-4Ia/#=e+Gc_\)9R;
TU4:2Zd#2a\a[?GU39AR3a&e&B@DT##[AL1VIa8CSEdSZ(H,bJc;bCZF&F1N5F:?
:.7b/W/c6\OG>gb4>/ePH9;=XdXQ7SL3OF^=\<HW7DfMZV8eJ09/5YJH0Gb8@80P
MX;KN^MJA2)NESJHEaZ49UQFCWS9;1OGHN)f5XdP>#1#gT#4CA1fF,5P>K&5^Pdc
6Ja1G_?8a[&C:Wb)AMG:&g1c77ZSX7I]ZC?38U)bg9f#ZU3P/V6+c?^b268^\:_?
LXELQJO-P(<Tb6c+FTXaOgC>4D[PBbE)DOO9+,G+2[P-U9VXI@-3Z21?FO27eW?S
dW0C>Y(KS:8?3&X[T/C@@]_abN516O=IKJI]FZ0g\>7.3B23WKbIdT1c1Z_5-\FR
S0R_?Ya-=8TV]:])TEOJfHV.He]:&(d^T@dA>GALXGeJPJ?1S?IeUHe.AC3c4-_M
[M5e4=.P55@[#bafN88NB&EZ:cW-c]WL4C(<8/,UZJ=,X;IAE;UYJ?PQ7(,)d-[d
PH@fO[TF;D>]4IaR@,:U:8OeYN[)&(6U1]UME@51;?,4CX-0P<ZHB9#4:5+.I,1G
#S>15?[#UCOOD)#@]P#-XQSTX\(A17I8.C5eS5KRI5L^,QY9F<;PR>XE<^gNIBA@
bQF(Y=eN3c:I(FEg#YU:CaAJ;_8:<cI>+0bT?YROYVg]K\0C;>[9SQ1g#7#b_X#a
TfG=,W8&O:g?S7a&6DUS>0S(T:]+Wg,3O,16IN+4>0ZW5R,]ZCg,aH59E+.I3K#F
ZH)=JO\Ya@e).f/B6OY]gZP6Y+-EE)YGV^P7<PA0O7G)c.Pg6-,bPW0JYFS>F8f[
Q5V)ZCgNWf07<)_DVJ.B_@NZS(b1CH/-Ic@UFaII<f4H>/CU24N#_T+>LKC\;L=3
)+\[Lb<Hb7>YD)/7<I#VN5gKb=8C)+<UcDb0=g4Tf@?0G_3(NGN1JcY^1gJ#/D?<
-<cCdUA>F.bF/6PM/M]7S(@PJ>EX9JSA6I1R__COZBH31LA7ODP/67Z?NW532MF+
.5S_OTNW.ZX@L:#9\1JWN3LfbEF2ZJbZW=NIO.DL+T).,Z7e3K&BX0_B9;+U&eEA
1<[WWUOba1.S\XV>#E[Q]eQc9EJT576)U+\?..KfNO10,,RCO9:1,<>I2@+;7GEQ
fcGY3[5C-DQ9H.b@cX5A/\4AS[S<JNA=F^Rc#7f-+.2:)9MVI?=.#f:4<+2<V>]T
PWF9F<03<Pa-]O(R@dP8JAREXF2A7PP^Qe4e_94:2?5UN;MJQPI22H=NcU0+.&A+
0OOCWBB)c(bQV3b&\&D=TVe)>S7NU^\a=278?bUS)#RRR(<YJ@?E]3R-XXF.=df/
[_3a:fG^H)4A8P+.+TeJUgM9@E8=/E:?IM<Ge1=]gaR_XJVO-?\R4Dd+SYX,>G_6
)fY2;1;XFZN22:O<dY?GH+TT6R?>XS.S+ge?8H1[(FU0LSc&,1g>=)[Dc9QS^8LU
>AZG8ScIP?_+4HSS)K+B.JXDE<e30DTg-LEB6?\JLR)2DP6W)V?UJL=C(PfZ]<I1
YQ7T7Y+XWWe;[]-b,6,+SICYRa<>R(d\)4_-#+,gg_S6JD6G&;e0Qf^N[BQ:c52f
T?:E3IdEc[ccZ&+H[BCaI6QAE#-HJA2&3c>LUX#(,>Yf:OP4/U+SD4]?ZKGETa/>
W-1GYC8?2<2cDKd4f-X9@<X0UbA5?63&@6F9ACIF/JNYbY5.CDM.5Pd>@H[S94=3
U/<HUC<.GP25J7T^c8VHLgI<)JSYOV/1BJZb7R_;W[d?.2-XX;bT>MI>IL8EZ1DA
WP&GB59Z8VB#B^_G_B>K_[g34:+Jg8a;(LG+5-Q4ETR_,RS?,A39.PfP.Z8M-de3
)0/FB>^e0+11W(IS?(UM?N:[Rd[IG6]a1#T=Zg&FO/3W+,8Zb>g]0[gQ0g,.4\P+
CcX3NS/X&+_K\U\^E^?C=<\XZ5I-X1KVJSJNK83UVeQ8VX6(@&7c2[V0F;aF49,=
YM;2a9]D.&OZ2<>QWg@]He:Qf+=T[@/KEZ_:0)@(LT/UO&5J8DU-[dMO^<_3YZH&
ed;JTd)IBU_,(?WL8UUYU2+\HbEP4,,D[6\D<,8a/USUBX(>^d/d=5N7OFET#^F+
<)e&67)+W46@#)P(,V=>^H,?F^E8_aMaK)^#6WYOg0>6_UA8fO<-T]2]?]<-Ia0(
&ZO:O_&F7Y6QR<@A-b8cEHT<VCH9)@P,4+g]#[-1ec&N&DeD[O7AL2U3H;WHW9K.
A()YSA^aP5E^dPWgLVJDU:H44c\5bDF564H4g.d\,TIXPI8O-[0L&H2N\;O<54bW
a.O5?b?&3#6\]d]87J>DP3\#dV(R96/2a6-,(b4I6+6gE&-8HK09/Af>]\a#g1Sg
0S.4:+Y]2K@Ob#]<8C+QUg07;fZebPDS.dB@cEPeAUeDI&/cH/1HB_/0=B6:@UII
DbCXS552@eO#-VT+C+,B_3#ACeN-Q7PTZU4C1A9G?+]#?6f_\P-T/Q5]#g4NJI76
./OO=WW@NSHZ@R-BKJ?7O&73c0@OL15Q8=>@KdBDA+cB\3YP3c7@C,YV+<__IP]C
C);BX?\8YEgadP#_,RAE@>#caU=PU@JHK[UNS3Saa8[f,+@fQCg#W5eVJSZL]1P9
<a=@Cf&HZW@I^OE).dI-R2?WW@>WV,g]/03_I/G=2b?URc&[AQ0<.gD;cU970Oaf
SUCJ&]-M.M4YTbDJg^PNU?FGKVZS;TC]2a/F28g+4-g1BLT+E?#W3?\EbIVW8D51
-fVDXXM\LSS<SIC;CHE\-?FC9SE5LU=fC7=Pa0<AL&YGY:X90ab2(f2=7NWIXZID
W4aD9TDBA,dT@0:;63GXc9\]egT[UeEW0_@]BOXSAC//\DW+8^BTHId\R#-<4_VC
HP^c<;:;8;B\GG@JAOCJ(e-XQ7\FU9DOY5S12]UE)K<,[2)#Q:(Q7+FFOPC..#IH
TI(,7QV?,B)@A=Q,VHRP\/6N+F3dfGZPWGZ^P>POBJ4RDS27f]5.T-1?H=A^4bR\
S[EVP\KZZ4IEMGNBHOSIJNR//&gbUAMQ4XK@Ncd[-:1FZ3=QaGK+-W+HKg22HD>N
8L@X_5&,GJ5Cb>2J_@M3&BF+K0+T8#[?g65<0X)]FUg6S#b>gdMU5U/2U[XWAF.S
.(L@J@,0[6ZMME3@4X&/^S=K+f+.B>3/<b)c>#dB+aWED:X6/bOg1(HGGW^\Od3>
D]fe;-E]cK,:JXSF+\UBLWS=7BZ6Je80(.UbgL4L&GCWR\L8^0N._7?\+4)@V(Z/
;Pbc=S;cD&=_V==^.\,#S_P,T-T6c51=]10E(]VY<59&V2<D@ePTdY,6+BH</G?B
\a.3@#fH\ZKC<3/4)SF_F.f>Y4c0]SbW:R1SaOD_VM:]UH4.P6HX3RTXF4E;_;#L
0(W]8.OSdBAd=PYT=Q/X7#<SO76>?>aeZJUGFR[aUX05WZZ)T/2BcO03>/dc\<CO
WXK29<Y_)6LD\PSVPaPPc<>XK#AC@KR][602J5]J@L9WH;5GdNX3@WV;PR4=I:P\
T7IA<C^J-#H-L/,2B][,)Q@)-Wge:d?5FVEXdUcGD]6df((.G9N8ZA)QJH5b@d_(
C)<2](gRA1\g[(ga;cZdcYPXKE\cVRTbETR@gfc\[IXaJP;]<#K]V049dL=A./bY
L29HOOfHYEgO,6^g[F[#G6BF>a-;Z77=>]X^OeP-QY/PA9SaM(ROTGYOY1(eaaW9
;PafXDW]+ZaF:\J@W88U26Z>.7F_O.b[^LN]V_53/[HMcVG-/bD;TfK+)ZffF^77
A/R-VC@b53NB:/9a8e;LAJ,=LWN2PccBOXSN:B@Z/5MZQ^2TYeZg3@06aTQLFL&;
6,ZeQfVE:<.Pd+.T>G7H7>L]=@/HdG(^e92=DDZ;4JQ_YL(6&.^H],NB3cXQ?ADK
P2>3;KL0;6=I/D_1Q+X_34^WM>:,<[09Z28eQVa.P[-2KZ;?[7I90,RGe_L^;3+G
:c[>&2]U8=QCf5L:_.1.6S<1d\KIgVgR,1;1D6]&?UY?\+Nb>JMR@D3Lg45g:Fc<
5TC>JPR^3#5NdBJX,5<BE;9ANebK&>XQ85DE8+#1XS/U641T1&G0)?[gd<PeU]O?
=.8S7,=8=-SJfUW(NRIJDI]=VYAb\8KLd>O(<SXT;>=>7UKZ?CMT2DPKdQAL[G20
[XH:&XNcbJc.?Ba4F_QZ.b4<+Jc^@W+6<PAa=+.497L\^RHKR0.&]1)NDN&;&TVc
G&I_?Cd_)DB]V\L3,bW[F-6/#[RQBVK&_caJB4094N9adB^b<Z-<8Rc4CV<>Od:Y
I[Y(8D#7,,.Q8GDN?)F2c3M&PUa(DcaDfc9H?a<429);19b7:3H_LR3]Be+JZ=,<
PS^DE=D/C@V3Kdc<>ICYF2Y-&Q.6(>=7LKYbY[:F&+,+]<RU+P5_#/dM,6gN?M/Z
LHb(eJ?X/QdTG#MT(RA07)?gT#2Te9_,B26TNL&/PT>N:\-3]I]ff1-JH[d<bAL[
(g1L]9+[8,A/KV-E\4AY95UB_8;BYQ]G_&ZX]U86.GN-+()&Zc49E6W8R6a8NALF
WFeNMdIUG;_\X0U=3_IFI1UB7$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_snoop_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_snoop_transaction)
  `svt_data_member_end(svt_axi_master_snoop_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * pre_randomize
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
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
`endif

`ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_master_snoop_transaction.
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
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------

  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();
  
  /** 
   * Does a basic validation of this transaction object 
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`protected
&1A=2K3(5Taf3S,&[2+O8OPTMVJXJ5d#X?Q?;-T<8gL)6E&#@W,:.)OTJRZVI9@=
/>LJ9[ZR-EOf,$
`endprotected

  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_snoop_transaction)      
   `endif   
endclass
     
// =============================================================================
/**
Utility methods definition of svt_axi_master_snoop_transaction class
*/

`protected
BB;L<P9dHOcB?bW-^6VHPYO8A>:5>fa[)RKMC?\dSS>FY:GQXJ[16)bTTY1Be8a)
=8Z\X()N]6^0BFe-[4d@.YBMLa80IT&-5G:NYNSKCLRE&[9^=J4278c0L-F_Qg^S
XN(U1Ze<[cU;FL=^;e:7f#6T2Rb9TRS;QZX2?g/J[^;A#ZU&BSFKVHeU9I(2ZC]P
XJ3b4.d-90SR,dE?c+[8?aZ>D^c1M5JS92^G)d#dbNP[TE,DB?5)R=@K;b2WOKFg
aE85Jg<cYef?B5Q?RIcb->SB^5HT?Fa8+3#b.N01FD>d5a_P(Qbc-f?-d2,D_ba6
DdF0_.2N3[[HW]3?bO1KO.E367gYJMQ_e)@L4&G2dL1-0N9D5)+dBQ5Y2e79@]Ye
9dT^QJCRK2HR\-(LfQbBWWMCV0)4X37L8JD5NL;GK2W#a0#=8XePEG;ZZ4-JU_Cb
F@,Y_.8]K#ca);0LL?SNWM+)PZJ[G@H[<J4Q(RW5<MXX3aSf.bYR(g-a1B6fLUJX
+M_;3Z>G?gcNLea)3Y+11F8PR8@Q2]b2IT,E=JDdLQQM@Q4N\6,Gfe+Y-\\6L,6f
D[-.Ca4;:-.7.A.d^-JE@(M53J/GHL3QUEW[>GgQ-BCJY)gXI:#IaX)f/>U<PLXF
,QVZR9R-caTaT&-^PB]F7X4C659c4gE:@;>f/BbJf.Kecg0@EH<+C-D^S.WL[XPT
A+]aYC&Z9cZY1^7Q?^F1T+YG>R/W/6<G?HEMg#UBS0LfY^bBad?<5PXNDaYHdC7T
Q<@(b;.b-E0@SH;#NE0NPLOCTa>\9b0C7P:;+JJa=OF[XJ4)MEQG?VO@MdUfN=/b
QKB8=+LU#Y80E^-KLf(]3(b.OeG[(,/[aIPd73RO#f[.8\)[8H8W-FSObCR,:X52
AO1)W4Y;VS^E.M=E#(e7R=PC0RLW7eS[BS^GgBUTA=9D=(?(=QYCL^e87:9W:IQJ
0.e8;]NY2C?+2YCLVJfS9U6UJ0Ed(W>HFY3:BSU]RZb49^Eb;4AJ5.4VO8U9^JKR
J0f-Vb+#74L.)YRQcM\O\\;RK)E2DV\geUH\F,-3&@6QEE9Z&I168L#+J/\+e8Ng
MY2CCbWM\\F<K+_TZ:^IPZa6O,R[.C:.&c+XE_\Wb8MdJb\L5Lc71S4[S?ZZ=3DO
:DYW:cRRYIc8FI35N=N5+Z=^.C6ESWN:-I&J)X\P5HPX?ULBJW-?;JSYO,bSC<GM
Xb,U+_.1JC#=J@ASGP=3a]MZYEN8\+R,1X(2#eXJ;e/=D?c8#TD>(E&W2C8AC&PK
2SNP:PPU(JgLU_@&::HN9D;ZA_/P(Uf_O]2SH[[4R;a8_KUe-@FQ=+6U3KXX4MSa
BJ+74_NIDHNCT2/JLF?;-1WW_dFGfHAcA(CgZXSEE]@a]cI1ZIE6a?aX(5g7>^9X
UI)B@d&?61?>=DObfW.@<SPEDKbMFO>1;+f;VF-d_)Ag3#::_Nd6,:AA,eX(=PH]
.\+1/;L>\DUCc[25[AM0Dac.e(V:=Z:>1gC3\L423@B#Cg:9U?Ka?]\JO?MF0.X@
XYC0V1E2B[9&CEc\JOb)J&/WMRY\@\aA-<<VVK:\CT#WK@)-/5(4F&WeP;)VBTC0
.F89MgJ1Y_9TAFY>6A=5ESJ6GI>Kf>a=5P_a6V9b)_LPd3E3-UYNb1Rd_,@RAYV?
cdN#KC0O+8V=DE3,S]a.S43+-;bI2+?=NXX9+XN?T/7#(fKG0FLD]eNK_d+GMY0-
0O2Yf129,Wf3-B6^SELgG]#bc]XV6[ad,B6Sb33^1:SCLFb1BI+SY8VXQI2+-RR)
1baW]JHUVcHJ7K?R=?(F@5<+JE,fXGC7gG33])dC6_Ge<1c<T9.g60LR\A@MdV38
4Z<KKC07=XQGbWH)RI;8;A=-=HL]0E^(dR[G-MbFf5)]fY=]gMP)<#J\DKW=RNK5
_C^1#<Ae4F(W[.g2R#DWESDZAcV)HI@+I=J/@N^?46D?AfS^gHLN+KH[=B</<I^[
b=g+H;e&#^+W-$
`endprotected
    
// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::pre_randomize ();
`protected
?7H8YMb:K0-U>,5JNg#:6&AW&=TXZ:@Sge1[Q>ATe?DJCdJT7J/0-)/3I)/&P;/D
/.a#/-;WFP)B_8D:,[EBN&K\1&=AOS<DXCRC](c51aXR-SV>/.WH]QP?Z@#IR8A<
:\SfRX@^dOH4(/L2OP98)-aB]dJ[QNAUB64A(N[PXN8VbbX\?-W+VR4G_C8-^DOV
1=Pa6V]A#_V-O;7M>H6Y&RZeV?d<>9\U>B\LT]_X5EP7^V68PL;RUNA(WK6,.Y5X
6b&=88g66Q>K##HBNX&?YU[_\GC>K/PU>$
`endprotected

endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::post_randomize ();
`protected
]HFc]U_OR:[PK7)(Fc?a3^(E7eZH4c:O6-;U</O\CJ5_TO1cdf<J.)-O;XgfOQ\e
N7O.,T>?>WBVS3+[:;(^0\]c2W5EZe0-Fd;@.=[1KH2_C$
`endprotected

endfunction: post_randomize

//vcs_vip_protect
`protected
H?6D.-7f(R]=S#\b@T>KPcge?^/ZTD^__+O]a)7R3gNMg>@XFe=F0(eOBgPd/JKc
H?A9E4J3U<X#W+E;DePBbGDM]#ZD/\,4H473EGgO)S<8&SDL#U2Z_efP@:@_[A?b
7^0S9,TWT,6J(R8>_&]LBW5@,^eSFeMQJKac<A\YgB]Y-ZF7G;RW6<I:ICDeTI/&
DN3PY;DA<83-X+D158f45I^>X]2b]Y[P>3Q&@3#6ZHT/UN1V?K1TQ4_dT57Qa;<2
(50)(B_&&AM1,HCG3=:RA-_C(b[B5a/[BCG4C:SW/##V(4fDYZXBBed=8HMV@X-I
B3:FL.d^S-ReBa[42U:b1FD#\f1?&F;ITQW^>?b6eL:=D^?e+504T]8>(?A^ef;+
MO?1_&#Y3P)2O<5@QB@@[Sc(B+&/XgNeQVgf_DU)d)[G#Z+,&bee?=-9,2LM_5.A
[=(,8O.-g.1J?1OK2,YeK+@U/D<#)>O-T4_S,f8bH(&1cf0YTZBebF)=?Y9g,FT6
YfXZYF=5JR6K_72/&F<W6XTYV3GMR[94UY#9ES.2VOFa=>f.#74K/<,AS4=,YA>G
MZYDCQ=PVTL&)3cRI,f&@NYCIB.d:IeZM_>cO-T6D6O/O/FR;:3)+QK8WfQWcRPM
1H48OOD=VME]L1W0HYS#GQGA&DVd4b)_)N@ON)RdF::B6(39KLZLC5W<WWNcLMWK
>_-RL&T0g_SAd^/_O6J^VA]3RA_#fPK91^ZH2=Qg3A3b@_Y12JgV[A1Q99J@>D#F
7fK?N3Q,Hc5aL^^+fd_R;JJB1Z;8]S8PHg[>=9XdH(a.C()II4&8\;f-X<^Qf5#>
_]K6)VZE1R0W1@Gfb2#N0LJd7V^&G+0Qac-\Je:6(Pd+V\A)X3I<BVJ[g[K_:F0W
bRLgMF(b_76)Y9+6B4L\e.I&AY=7gD8/&UUf]?7DIYZTY&1#I]K??&YGWb_QdT?V
WLQKb?V3^0[.dbIZ&JW660d9B.MBAgaTW0)Pc@B&8JV(3A;>JXLIWNdNE=;dMN?6
<D/[5+@X8Cg/eBB=.TXA3)U1T(IDO)FW<:6^7b+2][NecR5N#E>QIJ:F:@OY(:A2
I.>(0:f1N.g0gR#4.3A6855)dMgb^14MBY8G?dR;9?Ff;b.&\-[<>?6H5aS[2F;F
/652,VG2)PE(a31]//WS+=ReH7G/0,RY4<g<#H>#R9XS-1Y?K1[A/(Y3a1Xe<?Y+
?/:bD4G9Ace53P42bEL+bPU:1^A+:G(;>?C.gCYS)Cf2^S&T0U\=/NOSP:INbP3G
(-W:3#TfA/b<U6?g<4aY#,dObCWT0&9)<5@JR/N-P+cA2C^.ZTf/P=TYUZ6,aI86
6g20Nbc_?O:DD+?][M]F)X/[a)d5V)/6VOGfA(\7>BYU]b)E&P]PQ>@MIJcKZB\(
aFS&^;Wd7D.:56Gd<]^B\+fH.K2K)TTR;2K>Q1K_>TH7<K-.>H&RG_8=Q-<1_\98
^bE>M<J)XE28VffFN;<<I@d71)FSEVC.F=X/R]KJJcg2@)6Pc)+LDg/6GZL/aXaK
E#/Gg87PRg2-/;AbBCOTeDNZ/5LU<gcD>QUeTR3Xf.X5K_NRB<S0-CPCX9RdbB_Q
1]B@)B8@7Z9:G3^O@1?f=FB9,1R1CK,CAH2e7Rf,&TDaHYfGGUJ]aC^),&U5-7\V
(Rb(:[./8Je0[g>VdV5?-Cf3<@@7SeX@004A+B1-.DW7L9]=5P<])/+XU9Rfc6P_
/IY/L30AJd?QPe,+C][9\JdRBdM8^f]OIJV?JdSFY[0UM[>3-3=[,)gHeJU-#@9(
2c7Cb>aMV47V/bFW&TbU4G,&R\4U)<gVH=RX<,/d3[;(dZf6XI+UX,[JS?T[(]H+
15f>Ve3NSZIC]Z:Te^)]V17+<45(Y2.K.eg:J46L8E\2-]]e&A8?&N]_Bg3\WP]4
fYVJE:@B(V^.^H]8NI7J5cJeVe/I+PP1MHLBa4M6Ra4aTCOHg37DW@&2A3&<Z[P9
^f,9[C<&\4KT)1:]<8^DJM9EP2c0YD?#e?0VIcYUf^)MLaKNC1WIP])dAU)/3cJ9
;:UG+cUN>I.#AZWZENEN+eVC(^P_36cKS4FVf<BfT+(+_&R,<AT--2/?&;>NSd.1
11Y\N(gA<@ce21?9LWB1^ag?eO+GH;VLfD))M(/A#70P#Y/]<_Bc4JcO/&\3]R6N
a>O0+=&c)g,?YB)4L533G\2OBMUQQRg9-5adGGX]+(9We5ZXYJRB23X5BDEAc]O=
gYE&1DN3-Z##)Ja,F/NgY<OXgKY?V4f7g63B/7#&\6(aC((-/[S-Q=8S.<Pg:OcE
RYP\aX&aO0E,c=6#aXZea<a1T:#1[HK;K;FX.,N-DTUeC3XKGVb;AI^Q:eVT/8(B
?\dd^SRTc0&].c#@>a:H_9Q-VQ+bFG3HI1WC5Y6f+ecY:.@d3IU8#gK_R9[95>RJ
>,(=<]gb4/O53B-c//E=d/42ZXUQ/#-FO_bWUY4Z6+=)NF0O)X<Q,ZVRX-,RCRF4
QZ5(?GA1c<(AIHS34UB(Xa1Q)VET:OOegBa@#]71W5GRUPQ+F)Q2:-^A?QNG<O@R
6\Bc[cJMYG^;&T_\YKZ.E.Ba[Qe<be8YJdY?Y.WN0RcN>R:3YC&A2LIY<EJ)PDb<
&35.S2DG(]B(.^18N3dJ)WN,K\VL_T144H<C/ZcO,<9cRM.dfCF^]?0BR(TRR(=7
MZT3^GJ.U0@IB,PC<P9[W2QgbKM-QZ5H/)&KZDVPeO/1eY8AU[+GZJVGg.3(0U]W
U8^:F_U5g)^,OFd>&=ALY.09)5^-O1G+=cE\0/KV[REQ<ZL@U9f1R7Hg+--feVcV
N&L3)GJ;Lb^]G.^b^c4XMNdCbT.f2;=Q(+a(.[<KY.M:[cIF5=[)UV)]]80,HN);
^4N_T\1)C9/)&/4d7I>>I=2D66EVR[(._<4+@2FH89AYI#AL.e?FJ+Q:d<_&7@/>
d-&^\BI2a1EgceNKeQ#)F#d.WgQP>D5@<K]-H_2g#T\([bS0&W+/;G,<CP_;2>LG
PSMZFP&F_C0T(_g7Bd-F88#8Z\(HFfN292UV@ADNfL8b=01YV1Q^:V=XVJL,N1GW
3;OPQ@V50>\S3E+Lc\(b:]_/L(-ZP4Y.63Q3NR5,7\gKJ\;,@RT&OG^(I]aX0c;f
#V0-XY]YM9JHf?ZGHD\b(]OR<GH6L+3;KO]gF950WW3)4aL]]Na7,9@O+Dc5fTJQ
N13@UE3,b3b0Z)9JA]3#<aAZ9Gd__?a?@+EW/DDbc2#YW51E6=ZOg^464S=G<(TM
7<HfY69T-/gX(G4<0Q2N:25YQ4;Z2A(P3.TK:Q4L[+;(1E&Y9F#Q&OBD=[B=d/]D
;J5\@R;_0Z,P,=a&-+HGPg-OJ@;^0Z<XY[\622TT>DZZ5/QE?aG.MbfW:(LMN?Df
+2YOPg+NKT68I;;TRc70@S(/M5I?TJ.bD.=+-UB;&B5#?KRKF\^-4c,ge(+BS&OW
cbd6\T.NIDRVg68EM>_:)<SOGId@Y/g-N<e3_[fcfIB5&:V<E)4PQ@VNJe.gQ)H/
C\7.c/K);We-Md1c5G(894[?HEAPSK3b]T@&VW+\S,]E[B:_K68f+)Z\W/D>F2LU
cT]a3YV/]cbYOIfZb(L#QcL@O0dX#ZZPJ9_D:)U\5BZ/HCC66f0[DAS/CfVR/gJ/
TdN,c7/[;54>1#?Ag]OGKFdX8W:+_2Q&3FLVPP9IaScdQ;0_/W&gA#=]WAGPU@(#
Oc36#,6FPEdKcKd^+eS\HEVUULfW+-L5LGbKGf86.>f+We^LM@Sg0G3/3=&#]B^7
JU1E#6SH-E8aE#5]<IAWEV=VG+-0g\=,^2:Q/T^3+>NQb<f0e8KN^>a#U1bDdM;8
B>?A/L0(]=e:J-P)?H55>c(JR61QW+H,.024T^&@.B:D-J0E/;I]=1f\??YXP;HQ
@DeFGFD;d7135fOfbdbBI\/M-QVLd3B/CV310(=f8d(PX;&+\Ka#-dT6^WeC(Od6
CUYd]7GES09[9NZe=bWWDJ+BG5(LG9P;-gT6^:(S6U1TR&A+8K?#Q:[A.U-(Z4WS
MX\;fa->LbQVg)4/R5;SBS/JGU>;KQNZ8.\fLEEH9YM3ZKMAgBabJ#G2\Y(\NW\&
OeS\T=&_[@(c7;gJRWd,S#g3>]Ug7D]R4S)FKR-JYG0[#&<ECU[@e>0BG+U/3#I]
^MX]JV^S#1]FNRY:1(X/O19\H&U6K#\c+]5]O5_YNdQ]CGF_,X;-]3NN8#C#2f@g
=Tg9JXOJGcF:Q]9-2CdXQLS-_17NgX&/IT:Rd;M+BCMQXBX7O4-A])?SH:=^Wc)_
G6D1&aIF(0\\B&aW<^U;^5&/gU2Vga+I&-C39_5BEcX<AB@&@O&FH/\GHb/+O,c1
ffWICO.EPbP?UTD1fFU]?X06eL#LUTHE-T5^Jc0Be:3b:S:8_Q:]1<>@Y?g:<P5O
1J]=T6J?fN.d[1+0E^f]=)d#g9><+M:[K2#8ET?/L+[^b1?<8[0T?gY(AJaBe,S,
XM3/bL((ZM,@eOEV4BLaf/Pf=d6Ib3,AGcc(a-aIOb6bN^J&FRA>_6_He#>LT:,D
IeLPS.T/[,S>Xac#=F+)]e7X:fUJS;/71]0LG0L>SB,=c(Md[)6_MZ,9^Z/K2HKG
fYGPD=E+HD^TSP=K1]_4L-Nd<QOfISIYB[XW@,ID;Y_.f^.&V@K;IIJaP]=Tc^Z2
8,dUe[D>Sb.L1HD/2,6@d<#P(?MdGBc<T,1&gL>9G@LSZ@BQWPW#88,-C7;G(<EK
cHH]&9-c7bY3d4Z;B#F9d\FEb]b9>CCNE0P.Q7JJJ\[M5HMK<2D)VO8@Wf9F&\:]
C?W:dA#08YKVgXVHAg_;<Z^U-B\E7.?A0[XT9)f4^5Z1eOIK?_WO7gPVMS2G7Kda
50F&_=Da99M0Cd(1R5/?3I(;U^19)R(12E[:.)-a00K1)##K-Lf97V#OZ.W<bg[:
R)G/5SJT588>>Z<fII)K5FQHPP<&=<\?S4X>CGU/YC9N-KC80M5>^>g\_:M2Z.P@
V25:ZXF@G+361JV^QHY0VO<;a1R-D@O4OU8BVIDKX-;,CH\;B;dRE3N1\80dWb9L
RD_LOed^P-C-+3<Ha=b@?TF/T,&1C?Nf:SXcY:b\J[YXZV]5_S/#E_?OKY&.B0)<
Z>69SP?HGfS^:EW;=B;D&CY-c&MaSW,^?,O2?Q#VR_T1,7@U.PKg_&>>??Bc0>bH
<Z6]>[IE<&\6A++?0Ra)^FT91/#(c)962YW<.CK,.163H_<,-dYU>IJ28>BD]IWe
B,?DYVHNc4bD;)Y.caZL.T0J2[/&\RU+c(e+X<baOU?-.&0SK-b-_6XMfL=]9(5f
XX@_B,72UU8QO62]I9S,#_c@)(?0\_]CIYR(S[V]HD]_&&PJ.:20?D-(5+39FcK[
HE0:\QZaaVa&\+4_4EH1LHcb:LV?ATa4eM@,Y+CTbFV8UfdM>7AV1[gO+B(C=7BY
T@5QZ4?_VDKV:>K>&H2EMCb[YU,X42/[Z)B/?b8b0M@YMR@_DcTGXIW#9<7@PQf\
JR)_5S5NF3-2],KG[\76HI@RO(DO@APJ#^9^.&5OMA_P=U].VMLQI,,?HH&3J#2T
QSdVJ<?0ffW?\-VaHO_S0>E-+&ZD0KWBPZJ1@(#9c7WP68J6<SVO9g3KaEA+D57M
-bQegT#,07e+@;M+?DS_HF@Xg_2;1W;5\R8X]F/)M(Z]-OJIYAYW[KI(QW/eca(T
MAVU(&B6?HUSY4e-5/:2:K5,91aYDbC,REb>8@3ZbHSRZ/)HEDeHU9Y^=WFGR+a[
&)d</.OITS1dB;a&bL;-7,4[#2[b(_UJ<<Bf[R.a^_<QH;PaVeU+@,MJeDFcPd@N
\:[@N@)K;>bN;#9KE\f]<.a0)N3[Cc#OPF4@],4/_3+PO0RO^<\Y_SfOY6Q1YdeM
^L?-(;&2I05LDaFA^D]#7VRZA.?D9JWJUL1gD6Z0BIVa/?I8U[Z3&,C?b_O)B?KY
Uc8R2M58RX&geTVP#gJL)C./f[-I#YI<U?[0=O4):+YJCJ?f&=IRB/@GW>f8:^\:
e8TeI^SO]>6Db]09Q251E32.B4ag^=F+F\(.)Y-0;I&\=+#MO)FEB4X4L^H0^QON
8Of[_0U@L][K<H(AeV\5=)JQQ]4=M\Jcd=&J6K[D:4MPgL>589[K9E6R#^:1^5FM
^?AJS>7PX=GN__,N^40&^-b#7H2X#ZO8@QLK9);b_Y(Q<R_T5A2#M>0AO+TK-2\7
2Ke:2fD+XcY&cTW8,M4+;(eQ#eg]0Aa;ObV3a,eBXTaPeAN/G02BN??/OX60(1^c
>5&-S+0I#O-RAYGb;a4/Y\QQQfD4df._7URWEM&d^.D6WCU_VHcLAO3BKN2:&31U
D0\RU?#PUd@IN-(?HLN?)_;X]@-g4)Q9-AHQOgPZOM-dPAQ3f=GO<eE3L?YXUgLR
>9KSPM^bD;QD7#&DC1OE+W9@Sd:YLU,:.f:/?RYageUUMDfYSV7[a]?=UMHdWadP
FbT)+8+PNg)E\,Q-Z:_H,I3Ig3\ZY+CUBJAbD\E[42?KPI<BIB#4J;[?W62>daN:
K)(?Ke..S4RO#Bd^Q.[dSD3ZY-S&fE^&_\Q0OTKT:H=TCIGf3^43OA9Vc:9,=_.I
9U([00;^YG6?QbB8_X>)6.I-Q<[d&&VY2)]H0IL8>4=YdB3OP;E1JCDS6):H;(_W
;+Y+/=F\0DV=YWc43cFL3&A_&:bR]J,XFB[ZT^U0G)J3JAbXUI><W6=^@&ETX[3C
W2ZI:CWA:@-7@d7ZN(P:/>_V,:_+fDD:J]_I)V.LNTa4,C--VJ>VcZC1?0X@AbY7
\Q2.U:b2[]T4=e(/?:aK@[),c.BcE137TQ^0DDN2bYgQ^RK78/d1c(X?KV,_1gY_
=PJC2]D;LC5b-:DVCbbPX)KUP@346C+/+@]-)K1RE7eSGTaP0a3NgM.7C\4JZDN0
,B07MLXJ:VcT/LQBII5F(6<Z73URCV;,39]Qc_Q7LLJgNg:g92-W^^[:(>3#<0#Z
)H1Ya)XI(?Y&f^=>X1MGJQ4,ES^+45+V1;611\TA0Ed9E@[fJ9X7b1RSCV#W>g[V
6((B6[E0WFSJdC@LG]@Rf(K-HSN9P,F^QKRW0a,[a1WTOS0\9f).X0d1d.NRVKLg
B?Pf);7ES0_^X/LH.5Ba@Yb6R1c/dY>/Y]/28J];f=#[XTU+&DII=?SH0G=4^cb>
.G\XN7CAQ-UGLfVb7?]G&32+=_LQ@CQ?Mf07DLZDaf,\(V4Y2G,,F=B6N^P+7gO/
X:]g#d?]X3GT:)K<R(<Dga;>V;BId?W,[cL7d&AA@D/JW/Lb<O;^78K=c#;cZ7PM
EdC]U)KP4=fR<8Tb:_-d([871fgNGZ]P5Z&+MZXN6Acb[V>4,9JEAO@\W5GN+-\U
?f_101(0XgWdD<TF<1eMJ>0O8Z0=C3#;_K^98Ta@=/YA_ffJ)VcC.1L_Ld[:<d+I
0GE4;IUa94LO^ae/?Gd)a<Wd,BT\2<-VeRPJI8Q,&Ye_-2USW59ANd#@1g]X[>c-
E5<O5?.0045),/4(.e6[\FfMIELd]B.X]1;WV\<)_cbM\3C@,&Q7-HO)Z1HA<2aT
(b,aR=?T2[VZ5GYWA9PMJF,c5XL01N2LKLN/b,SKH+XC_B#+d5^]7659WEV\6?e/
TCE)gM_8YLUNXM/PS222VaCJX^J,_.?F0_6.>/YabaRe@8<]@\VFO4^B)5G+MRIL
]=)]AaL5/ZfKK57DT_0SF@4KQd55=>E_;AFZUc39;,;<D+1OdN9UWJ3c&?ZQME:^
A\RPW7QN;9cM3C?9-7dAQ(RRI.<_J.F\>68-LZ@a-8e4Ld#fMK)3gAfF<cg=.<[9
G1\[-1f#7GbeSA4W&4(E2(^:;?&8F0bB;ALU1.OD)#]>BeJ#a1[7OJI^@GAf/KeK
Q11NT44_4=bPW2=\f0Z@;]ceC_=cQIOUPSS?2&^@)Q;G^\]J.W10N1:@6G,7&1A;
YU^[8e]6WAgF],8,\X(]>G5S[]=6T0V8?5MIGQOFgA+5XNJ0APDMY)\_Yb[M(R6U
ED)VE/;ZDI[MHe4E3H3]#gO#TJJ(:WOL80f>AN;OV5g;E_ga@-=.9CUg(][97cYS
C?5<[])XcKg:N1?U94\1ZRTV>B5;a)VWS<O9b6^-EbQ7D?e]5;#B\^#P&[b)E=K?
:#\F#\)ZKR[FTN/=X;.TV;Y]DMA\YU0YS&PW2:IJ#\8/[;OGD&K8(J1LfB26TdPL
#T]F5RP7M/9,[/T7-]Ta286VKOK]S_VfA^E_FM#<Pe9AWfVAS-#))\KYNd1S[YTT
G,]1VVBI?D\Ke_T+Y7,)MM2@ES^PTC2B1Af(8/,a@D-9,>(E_bM.>Mg[We,R4CDM
5N@EZ]5\Z1CZN,GH;-29RX.<#@6g#1?L<7-],#^L=O(?P5)T_)BPN&a?R&d/VO4N
,Q<Q&JAgcQ^0GgZMb@cCN]R/IBW&/&L#I@:SGDSMJ-4efD35)9SUNSEJ),/?<0Y\
d5g6>eALcL[a;FH20;KHB\7W(RW^;-VT[#-7[YQM4(.E>LNY>@1V2V?PLF24JP:b
ZZ:LcC#00&]e-<I;8D@&#OHOZ1BA3,-YSQSXL.bWT>?1::UN0d8GJ(/aJL1SG/D@
^]e]EgS1S0@d5KS;0KE#OHN-I2><GCcR@>>R)O9R3dGZS)F&NA6T[P+;7=&G<7b4
]A#T2G?0&(].#B)aFaE-(DKX/O[CdgII8&5N-E;?UE<Q72eQYFe_#.6MA+5.#d?2
@;:3bB?ZcFNBEg:C3LCeg(3DVQE)F&5eIEa].OBT);/+7J>e@H+P?=[XD2QBY0,)
]ZPNQgNO9QFCZ]#.0=B?#+<=LRffNMg=Z61.R6aD-?&)(FD0R+)=[]cS)12/(U3K
0^2&)LFY;_W9C#4I00@6[Y-8VYK>Og^C0H=I[1eW:GSM.=MLZ9QF0,8O\PL3baSN
1\3).:DNT<TYK3+f6.P]baD)a:\]H;3LVX+6/T)3D=8e:d(?@5#_1/.d;VH5-Uc6
0Z5C)87)WbF:-c->,I_aN[<_UDK.Y#Q?_OS+.J&_8@#.O/Sg@)AfAeDHR#-T:]/0
/[60DLd62HS5ES/Mc_@Sa6(?<V+;I.g<]BTOF),^?;5ZKMI?3;e@4R]?a@/JQ1UH
M[2[^R84]TcGbW=DCe]3+6>QKMBf0fePNc]L3E)WX4F.V6;C,11(5&]I]94-2W.D
ebI6:0HN9Z;g^VY+/K]OaB,ISP2)\F+02?O2)(Zc^5_:^()c6aY.IC?A]WZWH0^3
F&VA:AT]T;<+F7^7JEd[J8<^bY?4E#SPE;aRUTY@OF&4VM@)_=UNC]Bfe_#bMG-2
<[&5Y>D2FX(66D<_J][6WPa_e^L2_b96]+2gU^7K3Z5]Y3Q5_,Ve[^9Ag1XO\>4J
,V?@,KZA6D?_BbgNWZ@;P[751C@Z]Ma;dBNYW^3cEII#\J91IF(3GJTF]f[J^,)X
LZ&)Q3eA>HW[70E=;g6Y\FG11CD3JZ)K?R:WDHaPMKV)EV3NH+&59+aCIH]X@Y@>
,CKK^Y)#>Se^2X/XG.4KHDY/C,R\AWQDR0gPU9BVN]Td1>If>>/g0E?MV3<T2;]O
0_E/eDHY^I+NC:4QR-B<abN9Z5<20=LFEV.N,fU32/K.:1RV,gATZ9D7RM:,ETLO
(8W]Ta\N+3<4-AP(5\aK_/&3@FMN_P[GMMe-N5IL9.4JWR+]8C#XSL-b/fUH&,[:
CVIfM3?#4EE-?b-2W1MN24=R)eP+aNCI5a3L()8>M6f]2dW,aeU.?\S2=S.6bgZa
e5@V03NL@SF>EHM-3B<OZ[X2d_70YX;6MVF5B4LCRF(;RMeM1M;OHY>eZ9MVbZC/
+Bd:2BI2_)@Ke?KOGZ1.8<,L.#]d#>4Pe/O]+LTF+T6OA#JU(Q530CcaRQR)/LKa
>R#ACc6RdU&2FdCb90L4)H_NT&U0M.TG&HIbO<JS#X7?A6#M.@.J^E9M/(4+CBDP
KS@.9O+8<+_N\9931GK,&6,d=2/9K]V-#6EB[AI.TD5/]<&\\Rf6NF.^HJQNR<.B
;CR24[VC5C+&#)(CDF/+AK=XTLND4;>90SM3W2X_J;&#dMC@Z7[?HMLRX?^O?bMC
BAT4:43-K_\/\bbAU1#eBbU>cIVD&#C_ZT61_B@g)I2;1E/NI>NC.eeP@KXE.2gb
VD^.0]JF7_2V??_=C&YNH3G\HA7SVaTM6-(=3]ZSANC3dM8<U@aA>-Z<//YgE7KQ
F>/?3MFOA_d-Q[3>H.,&8(-OeW@#O@eGLX3U2CH=;[M9\V)>@=.A3:_8I[3.\Sf+
bM?<dSOI<H]81GBD.aT.0+:IM3[U5[gFCKd)_bUL/@05]WAJ1^6,[H:(3FKQ^UFe
(712@^OKCe>=0YVg0][\.fe+871^_Xe_)Q\adGEg1]MOf6aIfT]V?Xd/=^e&QA6M
aM),RSSf)KfZXQ\fNa:R_0H+3T[3.2a2U\^.QY?E6?O^]N70\:gGb046/^KSaE<F
GC5U,1aVHDG&Y=4:.8Y-QcOI50R>;[:MA>9McSS,b?gT4T1ZfL)IH1#)/F,gea(g
gaT-F>SIV0[GJ];QA)NSUU9C^>0[=TT>T\ZY6c9]Xa/B@,?bEF2Z.e+KN/ONQ\ZJ
VFGa=TbdS52?94&;]\,87GDTGRGENGG_Cb^WL,03UbJ^8a)M0](@1.B2T@IM_eZf
A(]11d@Z1^IZ1?D/Q3)\2?\WeA]KLXc&a=a63E\++/TPcH0,cV(X1?6:7+^N#]GR
.-V?9c[M3>9V3#VYQ(aHJZOAWgeeaS-9_4O-NYU#I^(0^94f)],F4I:2M;fTY64G
3=bYX1Y3]B.HA9Z6&SdLK3:<XCfC8L?4+N.N5MRCa0F=M+fY&M+UL98(#WfH#;<X
:MN)^dHED_588XCYQ?fQ(A1>FB0,HaM\X:O-0bDJ)W4)KM?_<:4XRZ,eB[\c:TQ>
:X5+g8^EUPDG@7=E0>411O#9eeJ2FP0AFc5a39L#S+D6S=#&/9;RgM#\V_;&e_Vd
S^0M&]^<EgR7GK@dTZ.??/TUIBGV4@Y020K3:c_)V4-[B27Y8/++L?1O=:N@KP#,
6eda\cP<CeC?aFWV+)cC.;2;V4\TR^de6JB2g#2WfLc\#L2@cNVbG6KISLQ[V+]M
.NS8C+VM5FPSA?+EGG.()C7cC#Q(,IE\fMC3(A(9Q,&]R)6C_-]K?4^9fII96>KQ
T^3S=&)-);1X_6D8cDT99?ZLLU#C\ZKd)-\#eU5:b#]<&#@4C(4WeeRAc4E:T/,c
L#)PNFR,BM0HL@^8BX^\QV:H):(4.;,F:NO22A7H&^R(;SH063FXJ[N6VCd1/P1&
DO&fAGb+LZbQNe=4\bV+?ZLB.MeGg^L6U(_g::;?/0<<XBG8gd]UB^ZRfMZ,eEc7
_MTJEb6(N&aR@^_&64e/A>JZE2C8\M[1<]VR?H1<VV2J-.JaD)e4(I46bV6D/>e0
0a@L37W67DT0I1LYSfd)GNU@G+G^1IS\(0PC8<MJIVLQ:1,LQ/C(6=XZ_SgNUDC7
>W9.0FKfZ;IQd&UU<[Og4\@I9EYF[F6;DD94Fea,B;YUCEX0)[75IZ[J)-0.CgD(
<#O6<Vb.cDO73B:0DMa=6IYGD3C#gQ;V5(;<E7f5OL2_-a6W@F.90S+^<e]=OE#;
XTg;+BEAN,HI=(QfZ13AXBG.TWO>0<:Ub(Q40#R<f10PI;VX?Z1^?IE1+ee4BcGH
8CC#-;(^O[?(&HM4b\NLO?WVb+#V@aK:]9EMR\-6YQ<0P^R(4Z+@>L^)PXTc?XUP
)PT[LKed+;C:B0H)MIHG;0C9Pb9F@Vg<c4b>[/\/A1=)8VB:39Ra,Q8Ha]3&=YH?
,;5,?V#BM3(.+[;T11PZ1F8.5[CQK:QJ8Cd3):c\/^#TB637V:[d5CJgU9C/D+P&
,)5[/,,EH]L-G)F_><<3F0VA9)@Z_01.AT:>RNC(V7DZ(Q[[]XZ:BA(/g]-I:-SW
O?RcAFd55UgNdJ\C=G\8FTZEG&A,A=>NcfR95Y:V[KI+7>cEV<GT/MN5EH+;0Q\5
1H,QZ3DIf9cJ//X9I8(cF+b?\fE9&0b[);QRY&0e1+I:[.^Ba:/VG2UB6V),R,9E
b8#D\QS:1GJOZc#BQF3O.>=V2I:01CDU^AO=/@SVK-3Nd+=+8.Qeg0eIg;XbTS_/
6EC(A^K1I7<CCG&\_J^2;Xf),3JN&OTG_X0]ET#[1c;6d7+9B&Z-<H4ee)H<BDge
<K3;e;a==9>E^.+]Ob>,VW.C\Y1D)==,\gO5;^Ff6L,K\S.KNbC^?FMdA+CJSg;&
P^c0BK]ULOZ<_6C7(cGY:4#[OV4-)<L5Za>We-[>5;Q;U@CJ:bK4DV:bM2H7=:RG
[1gX.E)JZd.R,B/S31^_,.()TEU?DH::?XGdef:T+&LK5O>B<cE<5eI@ATJ+:^\]
g+Y/0edYHPNHUfD,D762<<6@6GabeDeSRTc_K=K4+5G\BcX,KI[FA^TC9Q;eB]ET
AW.[?F<);5#.SD+1cJT4EJK]c3-Q2g:Sa@a10X<H))FDc,L,5YV6/K4(HX+<.[gT
4Pb.IK=&Ja9C^YI==CN#d^0GDM7M[>@O&3@6&^Sa8-DIE-(YVMX>LNCCXNW.V@>f
TW7\0A:aFJQ]S.8:HVK3g1[e-L>Xe(;13R:daG&Q-/c#UL2PN[/SW#PcJKeKYQ#5
Z?MV=N@5\XA4.R?aG\]8+cHfD(UV4K/fHU#C<.^d_KJZEbbUWFGG[:8(P6?<0fS<
+R3:bP?\Q4AEH<B[//0PC7,(UPHB3OdQWS_668N4Ff_F;\[LQL>T4^?EEWa#EV0Z
Pc[fTc8fC2?c1LJ^BRVKE>QQI#<D.6#cdQQ^]B[T:MUZ<CV[#b?Kf()OGUF9UA6D
CfJ\M7a]8#EQd=@f)2TV:5XL=/Y,BO)#H7P4\#7A8+2(J_W/Wc.S&c+4BZdY7M.8
]5J^2M0b.25S.aEWa8A9X+F7bJa\5_U]&]#[7bQR-\I_d0EHJ?>,O_OF5SPMbCZ<
@)S^5JAHZK,2ZNTI?]=5.;9<WgK=D+C4)()K?BB4g&DEKDPIUV(3.Yb^L5e7Q>f9
62DK,#a;B:;7B_;Y/UO+7bK(UbT:^1SXccPW37b<:+9F/RDA=fbA:=R][^Z+-:=>
;R7WCE\JG(>8)A@G2GA<F3\&08JF:)@UJWXVLaG13^1ga<=N,Z,2>1<C;N]GTR<#
^^CL]GZOQ9SSQ8+&,#DL?&LJMSF(FfSC?@#Xf^LKV3d=0B0ULJZ/=;._]@I&^M9U
NSZL_5fUCR_Fc</fa1U?NcQ<9_I-&^5TPag+Eb+/2_Y]CT_(Da>9V,6gMNJ+W-&d
Z-<0QI[BX9)L]6KF4&g&ZCMXJ-N5cJ31PA;^&^>:5RCbcCDS63P.O>RY\_<DSN43
QE87.-VZGYY\XB&9ecR51EO9>S)Xb&;-OJEF<)2,;ebWW]Ia8d\17a4DW)\YS/BW
g+_@aN?G<g5(K3,?^CAE3AZUC+.<M[2(UY/Y]QX[V;\,[N\6?2XKJ=_(Qd+3ZPFH
5b0:?;S,S/Y&/]e]OU,R98A3(NLf4E&/U:f+Y[_4LRCB:IeffcaHYN/[N&485L:O
WcG@5TfV@BNA]96(XU)M;+R6;5G36?g4eX,a55&+PNHKVJ.=@<_Z4Q9a6R7eXb+0
feQ2#+b-L,e)b:>VA)g8UMdB2^IA&2XS&>g]5;CLE=XZc=KVaedO14\eD5SQa9Kg
I.M7A((O..JWSGN685YG=e8@9eB=.&.M,U=1_UK37V6d0B#OSfKMcUfL#M&#_:a,
+D4/Jfa:LFFUaJ/O::;&LN@cX]URKBX0KUNVfPa+5K-C+=e3U_8J[b@QAND3f#:)
O:FcBT>F3b27WP[1[>Ce(U?\#N(@&FVQY66_OWI6<TDOI>SF(=IU)f^eHNccSW(U
H3=1dAKJ_P[K]8Yd)/I@F:T/E1[TX+CRdYf&GS6#aCEfHP3>24Q37]W)2HHC/(Qb
Q2/0.:+Q5XJ^D6RZXM3^S#6gaf3&cBg?+:<.]LB80R9GKa.g2bQf/=fe>ULD5:c=
_K1&0gA9acGLEJ3YW[(A>,;5:b\09\#BWAUKSVV+WJWb3YCHZTbW+#JEH5RRD-VU
=_d<VV/<0M8=feX;R88BR6B00e(8aW(P;BXIUgGVM^S8XD9_O8?30CH@@VB5]I73
UIL/\c0B\BB]A[BZ.a3R.Q(VfO><eVbM[dQN[0K2FQZY0dRFLH,Q0.#3DA(H9VUA
HB>c#RcYM8H+WXEXf.gPJ>f&,@<,I?AOE2Y-YV\>bc,+(@06c^\F>A&0AVa.4[FV
V\#99HPL1L]fIZ&QY2bbA/S^>)??D]#>7/R5U3PGb50YJcZ,^GUV,;&6+F_dP#I3
K.b&/GSC(QNGR)/=??f6-S]NP^Uc@2J3.DPF+Kd68SaMD=a,V-UN4&,</=N6BWd#
c(63(?_2@d25+>T;0Xf+]+AcVHUQCP5Zf7K[?fY++/>cd:9SP1T#[M86ef.2X2cb
]A&ZSVWP2=Y=TI>^?L,d;&]>Q<Q];H&^D.^H<I1;g0_IK/X9a[S^=AI.1Dc:WL)b
N2[U)#I<@YcP0UJa,3;]B5EE5L-1@+QDP+VbY6U@YVXB]UR7P#-^>,G>(R&E_?..
>^[bfe@W]<Q-g\bZ_;e5383VV[^7P_UPbM9Q1)gZeZ(](aV):EK[OEC^?gV#b&e?
E[46OY&eUCD[2fW>/CcLg4(@.2AWR]O0-N0ZNf<K6b5IZG752A-4JGcK]UAeU+#6
#-]]:&(1S@M_HUSI2I?IOA:O]JG_GQ]&LLNfgA>,W1<[>e7^f>;3a&G:..TcS;->
?[BL).M\M3MfV:e#7BV3fX_NTfcC_WN2OHgA4E^8]@+P0D39J@BQ91?QR\:=HeX?
/#HL5==\eP).Y[8M[?HV/Ce?LWX?GF1RB8#2U@)CQ&^PG$
`endprotected
            
`protected
Ob\Ab/OL4YYFdc#U[L#(dfMa6+>e_]CaNDBI<Ad-[;CJ:8WV^a0\2)T&0=9aX=7G
K2O2\gcW.dgX>//)-aA6[e(75/g2dC/c(@6]d^UO8@JWOBb4L[&gS>T@@T53NJ9N
($
`endprotected
            
//vcs_vip_protect
`protected
_MN_;Ec#f>>PDMcLeQ6f\.JPQ@UA0J>-0LS=DDgL>ca8?/>Xbf](/(g@T1OO00U1
&[6X3V0NKJU:/[6E&X(2V\Mb)4B[d^FJaBCa&G=7OCS;[2JE_9G175DU@HF^/ZKb
dLc4I;:F;;94>Cf;?B8(g6/FRa^H#]Q5&_Z:BQ6H1^@7AS:;1O)(EDN.B+Se;LNS
/eM^[RUXZLMJ5b]P5?NJ:4S6<5R2+FBP,b,eXE/eK.>-20Q>2]7RIMU/UMNUf89M
4eB=]e<DW3ZBVIBG/cX0BEO]_^b7(b#:Ue,.4_CH&WXU87D3eXa;dNG^9@R_Pde(
&=1G<C37KW>17\\_<UA^[#91R+N:=BI.E7geQ3HS)gCWN4BB;D7T)bgUT(<.)&IK
XLe7\A)XR(C13R=MJ_Y,NM3g]6BGJ>0=1KPbAa(#=_.J;(^LJZF2Yb;gOcEbKef.
ZI[TSgObS&VQ=:6\BaBB]]TII:RgJOW@VT_U1OePC]@6OVKB2C6E2aM?#Ld-4VOJ
G5@4DQLb99JRfL0ATOa&df-cAYBSEN\HQ(>M5\P98&J6:GIM;U6)e0fB?7P6([c\
\)aS#]M/PZ9(?9_2f6^c[BWAeeEZ9T_(XVX2@QX0K6:&TJ@gIeOSVSXT):ML:T3U
E19:VP)CKdZV=/70XJAKVD#;G3CKcKd8K/ZKEYDU/DdY/OU=Qgc_:JRV):f(VZF0
5F?8KR=f]B[R0G+6/@F+E9^/B5&1?)b=ae#YeLbX;:dc/gb,_60g(8c\6.E(D3c1
?X.Tg\AIU@CNB>X:d<F)(##NfI0P,6R[A)8=JSJ1+a5f?Y,K\dGHg_&ZOWKZ\\Uf
X.]Rf#X>0UC<(A3c81TS3a\1N;UdBaWDB509&LUY_^P3XbYIN&P8<K0]0U8[QbN@
(ICc\WZ)4/-X7>G6bSD;0UfMcG-eYZ:4@:I(5@Q@/;FJ?FFK(T-RV);)E261UA^G
.9Z&6(3:cJBR)fcSP\Q>L1;^S9ZWdba7#;0>?:8aG[DA-X],L>YRWc/./[W]TXY@
aO@AeA_F\VX06PXLI+Y+-+XV=008L\HOS8:9.[\_M^5DDg94TeRS94CaK#dc=Z/:
T)-X:@La-I]9TD6:I/GQ0#@OA\N1GR:#15Ta/87gNBJWW\UY2TAcVESI//c\Vcad
L<Y[LCL&5]1H?)#LJ;TG?(@=01&cM&d<W9WHW)_-87=6+U2ULBK_=(,FX:H4KVPO
E^=a][fb>.a:3L4aNeP3LN&^8+R@d;9ZaY/gfD@I\U@_&BdLY6Q^THA0K;fRHT5V
@JF9-X0d,U?Q+fI?C-HgfA=S-WYW_?V>PRL.2fH^D(#Wbe8aQD@5]_0):>4Z(2\^
0.3)e;)TU6&+UAcgYR@Vg+-O1a_\7R.I=E5I_?0.,K[CNg+f(g23ITW;M<52Q0Yg
_92NMEMHSL#3;\X.:HB6FPR^;[/^E-/A7CH4\2EeLUa_-RIa3OF:ML#-9H[\0JHX
X:0#+913#FeeWXO@:S39_STQ_/<D506>1B,,+c:,E2cKI#V;cIP:WD[5N-eNc8Qc
=dEA4aS,Zb]/LNFQE-/UCG_]CG4C8GV5.]5V&/U-9?>[gT;B48Sd1:1J-CJ;N.cR
\Hd#W[)a[1))f)U4QX5A5<?0]Pb(9[9H12#85;(?W<Y]N6G./+.Q>;AfO_e?(I3=
D[bG+Be#^,28]6U^7Sd:cIFPgcY=<0[gOK+GXXN,I3W;X8>8c+;4L.7fXP2N=,U]
bQZ&2[.-cA/B64DVHE.DTI<M<5&CJYD9cbV.ZK6)Y;b8FUEAEJM0F;Ag/]H5+,(5
#DYaFR:0><PWF3Z>C&^N,E@K<=a:T/9.]61VG?2<@ZK(,S^#g),)[GI8QJeKTVJQ
(Z9++VcV,O-9P6<,8[?U;P,=;K<ERH40a_QZD;SeVM])P?)7#:gQ-6LG@CQ&3XJ>
M?BR32J7;-\U?_cdGB@LLOSW6Q)K2-EX\X)Q)He60XXH_O]JC3#4\VY/cNaRU3G.
_?FgBEB/QOD2YV710C01Y8Y4B[]c;OOGQK/35H>,f(-7]QM_S[K+DI_(&dbVWgQO
0<4V;5WeRcdIK<6MMQ?+P>)&O5b1D4(49=VPBUT=/J\:>DN&J=(@FI/.f[cYg4WS
c49b]]5,6].]EPX4N[gJ=##3#J2d5BM[F<.U:GB4>C:7T8TRIeRLNCXQBNTTH0((
HY+eS?8YF=Mc2TCZPP9W2>AL:4T0a;>aB<dDU483PW3W2c:H5#:5:?^5[@ZcX;\5
(#X&YFZ#ORH<T&5I1N_SQ=U;+077Qb<Qd3)&IJC_+=O73F4W<QU8:aNE6C7c??6;
)FM3]C(SV7Wg<FGYJUdW+BC@@\@;+]O?+_Vb(WY3+:#==aO.YJaIeb>JXVN0,C3+
)>R<TFXMfX;\\EI4Ae5@^db>#U1G?>,cC1Q:QFJ5[4&=M@0\<WI#.H8ZW.-I)]]e
?OJR()C_CS1X32C]dC\FHN8_C5&GeI&Y#VQRCb)RMH:^@XRQ;RH9^V<K2=2/:T,R
VW222XaJOcd(P..0R+BgcOc]TAOg==b]OKV;O_ecd^]L+1JdSRfVJA7YLC-/CI,?
(5F(;2a/AZeIRWGTXVZPY[1&J3MXNU]6L?Q6^H3cDde++A;&JJC1.9QfC0=I03Z,
9F(G<(fgHYR8&/UJ;)+NF?4;5)7#I,E?ZFP3#QFP&75R&^_1gMQ.-EKae;Z23#5E
:<fc7CU8[5.:Iba<UZ?4_UP(BEKe7HN+P=S7;d2(aD./_XDU#I<7));P5[BLa3@J
Y_OC;,=-9+3WNI7AC_.)?N_?bg81E-XJfRacACbTg@G\-fbOHf4,(MEa&U-,JM&&
R9?JL4cI(5_02)2]H7J)SW2g>=MCR.?AD_dU0[H/8e##9BHLJ_H/::^FTW-JZE\#
1X_LQY-VVGR_V[Rc_-46__Q\gMAFT=DTF,O1TCHgYYa^IKX5=-Z&b;bMAIXI<+V@
F?<Ic;9(.[6G7c=3(,=HHC>#28>6NE2X;c/54^,WV=-g)FBCQ]+eJf)JB@71/C)c
#Zg.+0+e-6R<3dIL5HQLK,eSMGXDOEOG6#a1F0\YM.KXBAcFecZ.Qad<WELZQ+FO
CJO_cO9<+PV;<1RC?F:-3XM?@_?W\KCZM)QW4I?0\C6Bd7KDI[8V7c)>=\V=K\<T
Y4c2d?\+.9cZ71S>;SHV<H?GL32F&V2O@ZTc;MNY@Zc;W3=4+-_a+B&cB(CM5E4X
-/gDDf2JQEFIZcTO#8Q).,_2[feSH&M;K7_)\J?F[#>OaC(XE;a<@?.2SARZ&dR7
8(/Z].JaH:3N0S9N7.T:#E_\2?6>@I,#O<^&)1>IG^4.QY6W:@XA.99HGS2#IB?N
(Fg.)R3-N?b)L2-0J,W5-SW.>MA5?<g^?H1cAC>1;0Xc9=2,8/g-J#Z#?CR=QMHg
.X-P]FdNacfJU2=O7&H18#UFS_DJ=WGFeV](FQ5I\_cPQ_H1#/R7,DV^Te[UW2;C
gCJBC@HHHG?,f&eN](dKC4NH?0D&#A)X/;_+:/[0gL1\IZHIAA797?BXETX85b^S
OQ#@bg,4;[X:J@#[-BR/Y0Z..,J;TPX3Zf7GV2.+cg\SV(6V+GQ:1U_BUfb[NI]<
\O3B/\W1G;4CK5+X5&7B4RUDB2e_L]\:[:[#M(J>c;N37MdFF7<8L_aO=8YZ8gHC
BVN-L>QXESF(e6Hef,@\B;M)D(.DXO,,E\b@4UQPXUdT9/0@b3),.GMHW4A,D1X,
\SNQ)EAUUGWdA=fGNGS#+T<OHCU>:T90(D/)eU:1e#L\L-aXWE-2_K:T<69V>H@6
cb0SAfDf2B<a=KE#^+?#IPQ-Z[XA>gMXON0:;E)0LT-3QO,=d+_gICPaR9W3,P2B
,W0PZ<?c;\UY?HfZ)f3cEY8Ib-2a>R7S;T=N2d0f6B1),;\21f3R@N[UOaYI.SO\
YA)D]FfQ&<.4WX;2MR?DX8I95,ZR6@(_Z,28-<b[XCWU_84E)d+E?UCaPSF<N=GA
WM1(46aX&AJ0&\[/b83ND0J(fC&Q0F#40d44C(EX2]CAGeT@].SadRMRKXff920Q
Lb;<?f3fLS[;#;NE&Yf2?SRYCe792[dIVb#_W8QFAYV[P0=&0LP5CD3R43-?,BFJ
Vg9_B@TI=e[C&O@C>DCbKE).+=IJ1&JH:K]20L+,efJM;e4)Odd+PT@5V(:/RU6A
?4d-57fRfR1Ea>L7@L5FWV&>SE8I,TEF_V@ILEA<SbG+e&HT/D?a9TEEg+_WbPUe
:gP?<@JX84@V=f@,G/:+ZMaaA=(DCgICVeZ;?:HKLF@=d[g&)BaYe<AOC8Q=K3OW
3OO<2f1T49:XaPBbb7A&/Ga>eb(H0fPbJWZWKAJ61F:H#J57E)_CB2&?4:XO.Wg9
8e[J_3(+1C+(H>d<?TdT5QM&Y]\d;DTe(HfR[aT>+IWTB.8:_\Y#KGJc&P]/0I&0
[4GcDE^e8.DIILBg,E.dDZ\Ub.CBF,7^^3X18Wd-@Habf=T.A&.W0UfOI8&\EBDU
M3<WN5\@S7]4H6PQaVgY94#+fOZ<(OGRBY5?LPgG_PCgff-;&LV.^Y.eVM@A)=D(
PL=NT?gMZ>I/aT12MU-8UO<#NK/4#@0V=fMbELDa8(>\\aaN,9Q?04F)=BG@PCZ;
gaHcPE3A4/_dZGA<V<QNK8fLVa?e1NYC>YOVEaW[[7)ARWXRO3BLD#RKVM<ZMH,H
5W?R8ab)2IB,4L1g=^@1A>>d1#J.8]+2N0:]aJLf;PH^?,PWaRcF,a9;=SPWRVdg
b:H2WTB]6SKfZ-LX06ZN?&VP9_9(M</VF9b<_IG#050Z#6M.MXKCPJ_TG7?6f<Pe
I)^gcYK#g7[L[b-2OUEX;9HPIB54W0OO:+fF=7gTLRDH,52R/5PJUY&a]-_;3VF,
Q99<Tf?91486^L.?I_[Ia>R[)H42?(]3Y;I(cTgPCE(4bI?Kd5Sg+Y5bB?^X1<>.
2D0E.)eX-cR4M=1P8,5&[V+XWS.:8g9M&=?7-^f<B(<1bbDEN[H][B7NfR:>BcUc
D;be5b\2@RM,[V95:bS^?Tc#2&eH#^6(+fWcCA(\g_J4),ZL<2Ia3G9<<^MOI8WH
ScL,JLJY_&(9\Q1:SNJ>-,\RPRTV#a-ca1T016@O,gXN6&>2B17Re;FI0>-1WE:U
^/^WYDX.(^QT68\0/9b<DaA/Fe5YV+SCBB0(_QI;U#_AJQa_?:+0C7D_Z@@g_eRP
3YM1J=9/,Y(6SPOZe]:a0SGWDe+UcS6JdCH/#IdTeO[3f1:G=4&d&ed/BYVFYVH#
8\VLW^U4<<;J6&8S4V?699JCKcA88g-@K.E&KaHLUTA^-V(/9+[8L_E75@)@,W=(
DQPY6;DFW&\/VA)(L8Y^#(5BaTB:4S#Rb4_>F3X@bNQ[^ZMI+1I-8]/37A1>J[CU
=+;(5,Y4T_?dK<fI)-<HB/YEdC\_KXP3<DB2WOR.e;J=_0-Z37+RB/g0RB719,9;
B))4MgRDVP.eOdMgRG^)\9+,N9MSK1][8Z)RbU.D/8W)V7ENFWQM0_ZV?)R^@RZS
A,Z+f(N?H9R\45c[.ZE6+K75.;-5?]K_8IFB_R6=7F@.DeK)YE^88QNYSf4S.)FQ
0_:#Q,;9RH>@H3;ec(DGVV=7EQ:R5U5HJg\EKb9.NJ^_RLdXg2@KYL0BR8@&4N[P
_f(.Z59@N9+3.0N+P.Ve=97S/43Z=SE2J[D/Ua53D7TQW0Q(VBA._#4g/FKZJV@3
]ARdH?/A1YM#<(@C(5:3B.A)2NZ);SS=S5b8V2)5R(CXJ\I^,,eH>aQE7=4FRgP)
[)1VJOHf:V,gNOZJ/a?R-.ON,.[#T4;]=QeGMG5#O6065fK#225[X2.E:Y0<d5?;
73CP+NKB&]d/B:577<)MQ.1S]Vge?[</C2C1:8Y>?B;ZJI9a>N/AZ^4J6)JIX0/?
I@+/XdOUO7JB38_>Y+-RB]f@dRaTV>S3Y=>EFB)OPQJ3.&MHO8]8M:aTJ:KI\M\V
L-T27/=K:e0]2&Ng1-EQXMX,^9d_F8.8?/YI3>,M3XB@@O8U3-?f.O&R+f.L?X00
F2A7B2>IK(N58AS(H)2412g@aBM&b8Y@)G7a;da08U=5H4)Tf(F\)(?I,24aW[<U
ed0RX._EfHZ:4@e52D3<P_aU9Y\4&=eDI9V_-#N[b0a.af&SCFXS]&H@8B.Le]?_
@OXK)G^QWVVJ#bDUcb_a8&aeZNPAJDN5MN.(7KdY<-4WU7#;I+AAR7S/=3TIZ4(7
?NK0bJCAHd]d;e8UZ).^8F\[7G?),.1D=g4W:L9e1Pc\0CBFA;WX57.JDCGgJ#.E
\_:3).?VB#e(1CX^,e0g];5B9/423U5QWF6+FK).@f1.-f4)HaML^.]R\SSO@aF<
)RaKFb\_]Ee@,3K=?)<eU6IILBcB=11TXR;IOdBf#O9PHY[N,QdLBQGD:/+N5\ge
:4LI=SS<<20L9OPa//O[3^Ga+FP]<DHF.#?/+dB5U=:EE4>[cQXG4H+4.^7@@Y&-
Zg3c.95Y1T)#UY(Zbf?D_594ETUSdfBT26BQIECSg_Q+X9Z\RA/HX8UU/+-<bNc/
_L67KIPb1f/8T45R:Z3?f\;V<Y4OdS?G)D;LOYM\>LH1=eTFLdQI?K8_@^dPgB6D
SSUCEZ-FE7ZIfKS5T>,##a43N<gB.D+VZTcQ9#QYb\KQ8Fc;[+-VcbET>,]IH&I:
D.Web3b:BAN.UJ-d6ZC(Q^8-3HaQ:Y^C//g/\_EgYC64LI^T(]S27e^I4?9)ZLHV
.1DW+Ac0=dC/V#];V78)H3F:JF@S#B-I=?5Rd0eC&\LAMJVA:RC[^#)@,cP&WEaS
/\Z<I+gPe&(e5JFSg0/A6PS//7/(&Qd?[ga<a^],a]Cb.NQ?P-]?SUbL7O[J[GAW
_5B1a<&fX7,O?[O\Sc8@;><Fa/>4VJIZ>1-V(gW;BeOWcL4-HYWT]=:E64,bX^AB
2TTg,P5[\U8aKSUKVcgfcWWIPd>&dL93RI3\g.(3b1Y]2cSTaHEL<dW[G&_=J4dU
84Qg&+CFPa##WT&9cX;F8H3TU+_aGFFcL@BL&=F-PB:W&G82>1OK=UPVYDDHB1VH
dJX_SI07FHQP(WYc)Ec>PV-RN8;D\X9;f[28Gc,-S&[;1D9/J8e[42VL@2IX(eX<
QXIb4&(HJF,H)W#1NN&Y^G06HU@;XYG0?()MGcH[e^4]g\^F+eWeJ8U>Q)TdOKg@
Y^R-3Y(Z><dSSCe3>dXdV\bQIE+ZHW1b&-La1L\^)GXZA#+K4aC5JT-Y53+KR24R
,Eg:^F7HW#;ed;]M&<I&S.4BOA4-72^2cZ>6]3C;6c;:gJOPf#aDbHR\.fE<M;Q/
H<B4_SOUP8#]E(HbTI2[Z[/>B8FEg\82JW9aE5e0ePJd57Y.FVYDM)>eW_#(QI>6
fb7Oe<?KI#.G3cXTT0+&[2BI4(PW#/DL0K+HMcRQO9K=8\HV08T+IJL#GC^)@0:P
TPA9FP87?+D+8H)):&21NaUdDcD97[0U2_^.LWKB=[;+cBF48X\3H79?I#]5_4/D
&D,-#73]B]cT/IP:O@&GN@2A<]&@0.0G=ZE,X\<7F8fbgM4&VKQZ\22](eFPM&N,
=ZR,g8[fN/#PM(a/dJObU:R/<&8eFX5<[^UI<e\49OV:478Ig@#CYYOQ&<,>N_>N
#W>0_K#/EVf<8IFKg-Nc)ZN+f_=O-+300>PfHLSa]DI&R(=C(/:=CJ_&HOJ6M-L+
:1YH=cRY?V+T3b+E]&J?Ae?EDZ6c+@>&g:T]HE8QfSO]c>W[3WIX5)^+WB9C_V63
3@DH8\]c5OC,N.b1(d5>eQ3=7adE:6Z3XO1[-\AQK55MS21OU_=&Ja@]M3DgH2Q3
=Y)AUI]d4Ng?F.2Ad)D:BD@?KAGd(CRUO[K,Q;)gKKcL-#?=HN]UZe)f88Hb<1P@
VS.g\ARD8JR0\g0R]MNBMMS\FD8WCPAZ9H(2\MV00/80_\6G7>eO<GI4TbaV-0+1
7L\L.90[Rg1J80U@(S,28-1P<c^;Z9&<8;FV49DJ(OT\YY_CEfQ0=+IPSFTEV6XM
O+PR7<W=;HRNJ2ad=cGUZ6gX;2/aS#MJa@UdVE0K(J?S79G5VHI6^)0g4NV\[W#V
B+4cJ=HYYg6dU_BIN3)E-8^F6dY:HSN-K//#.SENJMg][NT.E,B8P_N==>Nf-,=)
Me1O7dG.AN.0?24;:73S<P-M(0<6F[B2K_a@3@.+(a@4TXNMYVC67S0QTSZM3?\3
+:ZgO.7XVLfEL\Q).0;[<(cP@63I2\bcWc44U]).Hc3CQ#A1UX(:JD3=<O+6;#:f
JOZ1LK?F9;PP5e2YeNDd&/\L[>AJQ),-@AQ4YJ7/A5^0L+FdXf^V^c>I[cI<T[>B
dJZ/>53_-,:fHUg41@8a_?NU(gN6L+F5+RJTN.[T+;a1Z6dG/bOTY8#EbJfQAFPJ
=LaPbU.>ObH7H;PS^CA)R[XNE057)U<Ib?I,:\5,E4>\;YU.Q&=XJP[&\cX16Q>J
FX^=CLZQ/\;b#]F--7OHCI-]CT^L53g(UZQ]&?OQb.SG?Y-c[6Rb?7KRYF4^]JMJ
=f8AJ<NCUUS:WL^N&Z+G4D\X>K._;EOV2>.bPIFPLZ[]DKRL>=0O7+bB.<&DEbIV
GS7[UCSWPRa.0@C0(P=[\aG=+#^N.UQ+DVPHLXaIQ-fbQWZ_aGB&J]I=#>(\&XIN
\YPP0ZSUQe45;2XR:g=;,WK0W].]-4ZC/C9Ke1=Ib^TUIYF2U\A([c6_DYK&Y>>S
>YXKCO+XWU3(BQaNG^#(=:1dAJ4BF3CU:])WT<B.SB0O/3+KZIWN33W?\[97B,GQ
5Fa84;#;N(7P(XVN/.Y9Wd>58>1MabPX_=E8UF3^aXORdU0PZ_+J#9@0\T-E2^dE
[\1K;1CV-U?YF.>&ABDN45K-BCKa/@c=:-9NF+BT#=eI90V,8F2->,1W=CKZfVL[
QK3>4B2MT55g2Z+A.0BZ:^>]?J6G:N25=\]=-EJ>f3IDLBdf?b&]S6M@d#H2CdP/
&>ZdUD9P]/,\^;<_2\cOPU+H5)[<FH/5YY0FI0(>e4::)#K-Mb\@=e2QCAYQ)&4_
2K?3bcAObNHNJX)+FD:#5FGbH?f\L#:V=C+DM5BC/CQ+R/JS&68(A#][Mc:U_MQ,
1O89FI7/PFM@[VM<T?:Y>b\)EZCZ4e4(dES+)gS+gfU.H^XNMUHcBF/2(P#5,N5]
fJWIPZCKMG:VH?eLD>LO_+Xe@L9Q@e2UI;_g^f,?)ZGG7Ie0c,bQJJ)VB)8GPKLR
I[T81DKE@OSKJ+a8BQIcXZYN=-[]2#]b.;N^aC&T2N?3c:KU0/=U?]:5cV1JO2a[
+J:dcA^LMU+>@VK=Y43U+&.2cg\^a=(WCD4Y<8R)#^?6cOC(;]KK<3ff9PYW:ZE/
E8(83-=G8+0_65/@I24)5Z?gNT]SZE#-(BFfC<]+JMP;c8D^DfB6P8c+G0=XZH#C
1R?;]O#GaIKe/?&e/4HPL^RZ;)WU3N9EERV/P[+R@OMBfe=eIP2UVbd9J#E+MC[g
GS]]I]Kg?M??>NNDVTNI2ecOUXLNONC<)\P+ef195,#9NA5<Ag=NMBN#M;:\F0U4
.)<SGFTRSA>f30d^K+C.@b0:?^;OH&9bbAH;Ja+Le)QNBN5@24OLbL:LZ\S.[;:,
7>ND7T/W5_.<?K8&[O@=K;\V1-.PUcRZ>d3DWAE.g[OAaY]JC2=)3;e@<+F>-X9Y
cV4;+=-E3;PG5DY,O4W\VCAdQ[F7LDOLf1J25AOeNEcQU+#^<VGa^>2Y#0]>TKa@
FQ2>_L-G56bO\g+ZGDY;YRgV-#WY@?S6S]T2^TX@6<8^fPRf41.-<VHY8eYJSe,a
ff-]MB(7eOFB686cBEDeB?A>a6_V(_FZ(K<I64aG9DA@:fTg9,[&>,aUXbP\^L&1
cBLC<5;LB#3FgYf+BR3PeA[H1U;6?T5f8ASN[/6,S0K8Y<WIOZ546KP7/?-(/g;L
QfF;7GER(-Id&?J->ZLH=(dMc--65+AWgBMRBQM(FgdC2XXQ<S7THN4]JT;cD,O/
9+KOCY9?bJQQ_Q<5NI<J.0Z,NFL5.+/Pg#/N)F2d[=/>,LU4gJM,b?#CD/02UC+R
:K1DR38?0PD62DA+6APR,Yc_G0(B(4>5Ef^J6E<g_ZQAd9M^T4Yf=?OfBHCbaB<,
D)F_=KC/a;_\\&@U/IfKL[R),,4K>.,&>f>eS<#5?\S>LG;D8VIaDOT-Z:Qd:O23
C1If41Vb-X#_\9.Ed4.Wd\\^UD9T4d\L3LQU0&PL:R#6O1WR\5),]5O-Le[OSSRQ
5eHK,]P:H)5P5GRDY4-@cVAaYf?6]b)2;H33ZP+RI4f?-c4H7Tf3UYcLECM:OE^g
f;QbBUFPI]dN5@3&?>\IdB_BcQ2,4IZH:d<OX@#1QDX]O;WQ1U#Mc50)JGF_dKWL
J/M#>(T&A1[aKKO4D#W:?_UZ7GG[G7W:0[SdeNa/I52<A77(7[-KJ2Z^)ZM#;ZGP
>>3ZXL2@c55/><DE8Z,(WWa@](8fA.eJL6b)XUf,6g2Y:J<6-MJ6FO#NDf/HbXMU
R(4_[26+<-+._WO06_22IJ7I^L&P6Z#+]bS9<D&[dB,1KfY=e_;UG/CKX_bEOCC@
[1<+YN;6a,_[M_@KUBaW#8A4S#\fL=_PMUR1[KFZ@<SeWDMH>Y7/_<feg;B_Xe5M
5M51TF+TGaDRNY7]RMLL11/bDLNcW,B.V(cdKO&BW@C(?0aL8Xf2X=IO[f0()9CT
A=/+6LPP;3C6N<Z(]F,K)7&-b3Wa16__R]JP?;Og9OX-2^(Tb,;Q796df#JQSG4P
cF;d=>WM5H8V;\K@P31UXN+e7--Q5e7<M9E_,E2I9RN;.\?bDRDMKA-L__bZZ):P
,Q#.IVe&4aBZRg_>.b6KC67Q^.-6]L9PFTb=C@]]BfXRcMDP]&c\3T5#Q,BWI:eZ
>ef]V#;C[9=NTV]K8Q__=@11X4Ne?JWHg6TX&Y1Ng4E=aZTP2N^,1bGYf.8dELF=
BBPPNVC&TA/7bbC)TO4;gH2&cQfgIE:#bY-1.[a<c87^7aQRE;NT0/H83\X@\B2N
+f4B;J+-beaSY_W.<@3Z35Y8:7JQ40^d@SJ_Xg&f)LM:-,9d;JTS^+X-YN_UB0P?
L\OUG#MR&QcB^^75TNQQ/3d127UQA;HA?3@MIP>>S&WTOO)bT6<K?+/Y;]_947;X
XGS5]1_)JH?V(M6;\.NLV,A(XL1N/^+\/BXQaT(6ZOZCGE08N#>K7&YDAI&;6Yf;
>A+&3Nf5V2Cb\g74MBR>W]T#1PC_@81A/ONCK>),TH_a(BKB&W+V\#CXC@Y(=V19
A586L:S4eb5T6dHXVM827]IT^Wb[=[/aW@c\MdZ/76]2PNO7=/SB<@L-=S3=cI-N
KXR[XV9LWT:+#cJc><&W[XHD3e)Z6NF&E13?]IHYE0[/a#-=:&a\N2:BO@]NR\?L
Q.BDX../A)5#a0VR])8S.4TdN53SE,aeMK4B]Q83dQ7)&U_25OLDR/90a_,TG6AD
ZJQ=94Af66_9@Z>E=^UE:GPG<Lg3=^(0TV)]ESFX<5a.+5W52W.+=S^T94OH4[8>
aY>>/TQRXLcc7+D[)\2ZC=0S3AcdW6YWL88#EQe5AOd2>^\?_#J0C?;1:Q9\1A)Q
?0(E@#Kb[>fDF=8K(->/Z=7D,G=O5&\:a@,WJ^W.S/7R_L,&@6Z5X6BN_K=1_RH+
/<,Rb_=b2cc54,(=7=f-JgQ2.XLM6MI=c_E<b6R&Y-_NT^T<>]UK91,Q4=M,K625
UM:Q?8293A-fc>@BP:B>MIH#67->EKR;C20TU\^Z<WEXeSJPS7S>/6Dg8F^TKGY^
J2:94F>g,DAQ#eC<:4SfeB#EaS)E2ET9/-d9:La,8>Y^bXXTKTgYb[7=P739[W9;
:aII=X(MT74_N?L+KN1Y&-&;QSAW6EC<5-fW@2JdGXZ<a=Z@QXC;S3PRfP&]9f0M
U:g@A@22M>4Q@WVgb3E_V.9=2aLV^W=0<:FG=T=T]MXcfG)P.Y@WQHEg/[J/=X6f
G;T0F<Bg=O>T=(7bbJg#DCW-UZ>G@ROIg=RFG)R^R35)9MVT0YJeQ+^QYeZMBb,+
E:P1OeL(^#75OXE#P=2Ad(SZDT/)DcBSa>5FCA<OcEP=&E>-5L9724d@G_L2C,\.
QMB&E(a?XUS(<C2;dSA;+a-S<KJ#Ee;\aH):=]3RL2Vg0]KcgVYB_0<_bY;?U)^A
H0<ZKgA9N(&@2NLW(<1J[H<MARR+3QLG?:.T)-IH)e4?dG-H?_,RB84MH+KG4-@)
IPJBFEXO[[7Ra->?a_[^aZ;WVDPfX;,K8S-S11BP4(L9Ra0BeC9ZbBVRca/H0&Df
<FdSVL_>=dV;^L=DETOJQ0?2T4^C@3]MeC?e&e7ZL)VB]_2L_DS7O[2^BK+P6SQI
D?9@0C#U&T19W8)fY]#7f212:-2bMWP[@U/F(cE?5L(E:=<&d\B>;G3-[D_WM=1Q
UTLX#N?2);Z>YZ\+5V^CBR]L:V4BZT<4=$
`endprotected

     
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_input_port_type;
  `vmm_atomic_gen(svt_axi_master_snoop_transaction, "VMM (Atomic) Generator for svt_axi_master_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_master_snoop_transaction, "VMM (Scenario) Generator for svt_axi_master_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
