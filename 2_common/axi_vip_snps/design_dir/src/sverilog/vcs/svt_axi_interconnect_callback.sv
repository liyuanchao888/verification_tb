
`ifndef GUARD_SVT_AXI_INTERCONNECT_CALLBACK_UVM_SV
`define GUARD_SVT_AXI_INTERCONNECT_CALLBACK_UVM_SV

/**
  *  Interconnect callback class contains the callback methods called by the interconnect component.
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_interconnect_callback extends svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
class svt_axi_interconnect_callback extends svt_ovm_callback;
`else
class svt_axi_interconnect_callback extends svt_xactor_callbacks;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(string name = "svt_axi_interconnect_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(string name = "svt_axi_interconnect_callback");
`else
  extern function new();
`endif

//vcs_vip_protect
`protected
)7U?N30RIUYg<[8_F4Ud88G=?]b^N(f8CEGRH]34(8_TN=d^adMB0(e2+11^d-@>
.e)aA;=R4>BM6+M)b6eFJ,#aeYR;AMKa&XZKAH47Y2(YXSKKAT>?\e_>ZXB9LG9M
SU9E(+B29@0gU^2XP#\@5-W^F<@=-.A3)DC>OV/[<^3V;46+P#2<AMgL^ERAcUX\
AEOOQeB+DJHQ@+;P0\O[a8@,Y(5>1I_N<+D>BMS)FT2g?WN^8b4gKZCK9Y;L[C@6
Ea(O>W>:=Q1#CSCNIP1YKQ^e>7KFe7/e>PagZ+^X;-1=+X\^&UXT[,g[+X4gV;KF
YX1bdHKcO0;[TVQIe^cA((.c)QPY[44;f_P<JaIaa8J+#T6MCB)CJ1I(B=#U0L,G
@^e#eL]&QUP\ZH,BK=;87+=8BPM=U;EJE-X8#<C68-V^UJ,]NV-d?,-@&B282J8B
OXY:H>3,MN5^+>F@Z;9S3&C<&BWE4K5Zb_g_#/T^A5@Y2:Ba#7H#,56@NA.]=,8b
:-.f],TbP&F0XAVB9,T\HRTg8AAXf2GD.X(7M3ES[YDBV(B45/c94)D8,RC]H=HL
c-fNId9cb@,HLcL816<]LVJ<:S&>&E:D0a=b\g5PSU4QN95UY2ZFV1MPcL<WfU4^
5BAVS2:Fb+[Va<GNfHJE+4FG_F;7?b=B.Rf1)[7e8EB8AB1N6>8I1B(#3OM/<I#4
X<?#&Ve?AA+g\[N2\KDA-]H6Ib86N]I)9OdC,abS1TXP&ZM&)ME(NQff.9A/_0eH
Bc_-:db3AgOY,6EA@b-50XCN)L<0B(0+Q/<I,cIS36dYTPIO8;eDZNEg3W,[WeLF
W+V(6:8ZG#O)/)=X]8gK+T9W&=S>C23Y9>T[fI-4S3/g:Z;/HH2X9+caSKPTc/(R
37IYN-TSDQ@#Z\9/ER8H)IMQ#SW7/QG0ef5.=VK:EQ#D0-J.fe+IM-gHG=D\F=@b
Y.XG[OXReN&cWE/82(FH+^+B.K#?+4L_+De28cI]eA7BI(c]LB:f\gfJ6P0JcBUb
dU7-6Q552(F)a5NbTC1B85C3+5e=6@1dWc6?L=,_26eS_PbBL+GIL[38&L6V>?M^
BGFRO6&E^<88a:+3/>XgVNT?\/X:D&8#VF2HVS=__Y[D1gJYQ(M+<G>@]3L54^gV
fQ.]4PH91QDIJ>W+.JTLBN[FWeC4\7,?[51TT^Va[>VX&)_)>cfQ,a(d-KBaJEF?
\^JG9EKB^95ITS+Kd:Z<3N^)Pe6@R>]+9<8GZ+0g/Fb5J2VKV_.P5bgAR90(CR]0
&eVBAgfd^]3Ned\<VA(cD+972=^Vf<^S0<VAdYVSG@F9(H@LI\.7f9=#>L3VLKGZ
+S-KH57[Yf.faeV6T0(HJL^#@1,M<-;3gO7LN8c\-F6,T/?N&gDfS(F;[LcSN+7,
d&T<IfRNPLI50S)dC+QVg@E=I[Uf;/#<-&bTC?K.<[4\3Z1,IIY.[G>B8KF)NM:+
L=TCM,Y40T09;I>0?/0S-&JKgL1C3(0JG=TD2WJ+#N5K]+4ecQGFBESDA-,S>2CM
P<T;E/f:I.g7FO&[D^]cfF1Y(TS?XC(92)X4+W\6?8Q1ceW1E.6IZ(NfS?>U78>+
\b?0CT+?[?96V\\6e=;^\T?X^GQ#eQB?d]Y,0]AEJA-KT@:TFcQXSb3F;6PWA>;K
M&:G7L-KA&QQLa0&6XcK8/)>\&64IO+BV@37J_,66>N\8+>O=4#C9SVFT<,KX932
#3PfNLW&LXVeb+#6bP/#18=FW7P.AbY_7)A@TGFg=dMeE.fJRYDZcEQeM/X8bAXC
F>-Dd;=.>W:.fM>(26bLEFf?WVO7f)gPdSBAR<WD44Q1E8:?/4NV;fCF?R#@)TQ1
L8EcZ&U1_KEKA?@(+F1UNc].L3^[F^aK2UX<9DQ:#X\R>V7+W[aTNMd8V&_N^T/G
LH9M<4_</-d&D5;X<G&e;7aW,?a43K-3f+URL]IH\?1g0&NPdH/Q\gd1<>FGT)3B
e(SJC\&\4Y@##0e@4UU1V,C@(a@X?98e.\0F-Q4&]LbA)<+Z&D03>7D^B,/0N&<C
(GLY@.EC:P9W2#DCK&EBX1#6T]&RD[IgG<L3]5_#T^58MA--8_SPZ+F>WK]IfBbL
SUXYOXYCLdR.GT;91RGb56[eaSd=1^D^c?@U+FaRaA=24,f5g<3=J47=@Le\2ASZ
;&aW>(0NKC/_^:5TXWDO-9SJTVb@e^->1Nc1b<Of#:PNQS1KI#[,eHGd9T?<Y3P:
L]c<)3ID<HCU&?Y)N.&OHC-#^]W3ZW/=F4&N?\@_dF33D+fDgfI>YEaO_;H+.7Zg
-^JTRM=SJ3\c88LO+HLG;f52#b.V>c:;BBa1OSeL8R/EWSgAU:<U(J)YG7[<R@/F
/Xf\g_>YZDad(gU_d>=8+L@SVaQ:8Y?gVV2PdQH6c7GM9O9YDV@:;Nc?#9,1-Pb=
d[H_g(@Q\H<Ba]10CJb+M>>NH62WWYCaGWDU\6E4CaM3/bJ21S-:+H_\>eYI/KI_
@9cfIL:H]M9E)O6\C\>^/K1YJS=&1OXd.1?G,YX8;9T9EL#U@+&-B[Dg1[XHg)Pd
CW2K<0M]^Y]YP5?T<fVYA]^8W>LV[>;S[e,9+R+=\:g8BFL4\XGfW]K-IRH2DPg4
+9)Fc,@7-=N2dOdV_2G7Q.-R=P0N46^VE2<:N5HKC9e@H)VJgNYF@D=CYYfY?ABG
-W2ae^+G4>T-dbFB@VdFQ2geg-R,C6BH[HZG[JI>C4C6760eD]ACE&3F=A[<=(SM
Y8EU>K\W@1XVM0UL)PI2YV2Tb_Re2U:]GK<;6\b.K?YaBV(de6&L04ggPGZ&QJM#
#M1W/4NGRVfV))#</NO<F8^<8RVY?@;IUgQ/7[CcCCE7]-PbQ4,WY@7RKK)a&V;-
6e6[]\QW@c)5_9R8K9KL5EUbeN98f<-;cY2QfM3MO]G768Tb[6cM]P2OG,b++1HV
L/b8-8)T.Of9\M?XO,VYd=\1RX(ZCTA-/<F+.E=DU0,D?II5-1)8&@gJM.=]PE3;
S?:?7g?_HEG0(WPR[0&9O)dH(1:[-HGS)5Yd+QISCWN.F:?fcJQ:5]fJQ0CFXDb+
N8./Pg4N8I.9.7YAY^AE.3YIM(b37fZEK59HeK(&KICZ1<WbH4Y2e[fJJ$
`endprotected

endclass

`protected
<0AdJ,AG#dHU>2G^\=V#0P2XgHEb(CV_)M_(NCc@HX#3HV[UB&F.6)5b2WJP\N2Z
W@7efL^c#?N2>TV@ZOF2CR1(/),CKI9f_dQ+d..<I,_f,Gb64f]BZ-b+7]T2T[I<
Pf&F^:KZ9M@cF=1eZ#N73J9/Cd(/D3[V)8F4?a0/7O#>J65XDX4eCG=[:XLF>Q,J
PI)Qb?F(U\#MZ(WTdMM?0bQMJ00eJUPS:N?+e4&4bV1SK-\gT1D#QJ/Acg,:7&6(
He&9I^LZ\Yc>@TE##/(H2G-JZF+XM=BS8\FeK=NA9+H4+K0QH;Ag.(-Y2611C:[#
OW>_SB<9^WT:#:R)-F=TM>9E(0A(d+I^Wg_ULHY;0B?-O=AF56R]<G9Zc.Q)PWZ[
DL=cLgN@(ELc^,2I5&15LF/^.,9[ddHUC5O^S1>MFJD-70cf=F0W#<B8TSSH2Q(d
BT6=OV-8HI<+Y5+=;WN(T?)(_0M8=]:^&GYJV>6c5BQY/gBZSfWe31dLg6;D4[QG
=3ZA?GJ5YXF4BNMM;?7#;98W\bHR@f5FMLJ&-.POHOf^OQ4bLTQIC7dLK$
`endprotected


`endif // GUARD_SVT_AXI_INTERCONNECT_CALLBACK_UVM_SV
