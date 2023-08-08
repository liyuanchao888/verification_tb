
`ifndef GUARD_SVT_AXI_SLAVE_CALLBACK_UVM_SV
`define GUARD_SVT_AXI_SLAVE_CALLBACK_UVM_SV

typedef class svt_axi_slave;

/**
  *  Master callback class contains the callback methods called by the master component.
  */

`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_slave_callback extends svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
class svt_axi_slave_callback extends svt_ovm_callback;
`else
class svt_axi_slave_callback extends svt_xactor_callbacks;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(string name = "svt_axi_slave_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(string name = "svt_axi_slave_callback");
`else
  extern function new();
`endif

//vcs_vip_protect
`protected
J/g7NBX(/ddd@PR1DZQU6O^Ob1cP8RG8V9,&G-67:OY;+W,f@gEC3(Q2BPC\4=)S
9Cf\fEQ#B9)4M3e1D20AXD7N<EG/@\[ODb:?U;PFO=F,6cGWDcGJ&D.5_:7EeH2)
R:R+dfYK>bBB_Q0&<W5E\^IgD?S>H9\V(I;(CQA\<5[)(P,Y\ZA,F1KH+<Tg4YUH
UG5VE&@:^\G?6Q-4gTeRDB3@:D8,LT,2@:Ud?N(+^HCPYMSI>69^MMf9-TQ\M2;W
=Kg><=6OG^6LQIM;-_EJ9/;HF\8_H;0R5YGQ(/bfJ?77),QDd_V43;WA6QCBKCFd
F>#.^2[7=:7MeacdB42U[[;N+9N1AJFTD9W/>RA^f#EPfQ-#^@V4@IP;HefM?ID<
AU@K0b5(?(J6TDZ.bR+=_^7=AQ>I#fES<<#f2^LZ,dVPDWQ2U[./af(;,]X7;R,/
XROQ-30GI]\K5-(0+Q<#M-KCN9YTBAPG@,V:(d9&^:J+]K=73:^c4A2&64eBQP^]
gf\0d-G#N&f[Q@2N,L_M)ZKPdFR[C]fL/_3X]]I)1X6:,R+ZVfOK#^JbN)DCZ5eB
3g?MgK]fa@;Tb)171b^gO65_b)N]GJ52OE<MGOXIQ-<eU\fG?29VgTcLX\AXSBb;
NfQ[:Pg+6+GD^0E(T5+g280\(;]-86]ZXK\H9fM5(Qg_)IBH-1/?aRL3Sc)W(@?9
LXBPK9NFUL>AF=HEFcZ@B-V_5[cL,CaGbg2:\9)E#&7/P2(SaXFL<ggXac+O(VUO
c;+dNZ<;Faaa07S@0C9WM9S:]4U4&/Cb,BMRcgC8_UbX=P=[_WN-MQ[g47(&X@_5
[:U_.e:#_FALC(BWS?Fb3_5fde0\[:;]<<a:+-2Z)X9fB(8f69W\N77T_EGIB/=B
gQJO;2DDP.C12gA;UdD/PWZ8GaeU[b7)WH/O.3O<./M?X+#[>BZ8P-1/I^MQ[<_M
A].Z&\>DD/V,Q[XK/,XB&\<5SG;)F^2HOVCH9)+)Ic<X:9;91JY3Ae2,O;L_J2+d
5?ZL([E\=fIC@^6)0SY2&[#RZZCcBa@5DJ8+4DQ(OQD\@Z@94&1@(J,YFP@b5_FN
(Ve/GYMDF;)PUZPBK8TYfd;RcG^[,5GAJTMJP?)BT/_NC;M9bbbN[)3;QE_a?OK_
XU8VfJacSZgf^0O1G\AX@.0Z6YMG=#>Wb[PG08=347<fBSKb<4.YTSID15GbOY_S
,VR<d)=KE_3MJ=a=&NKff(ROcVYE4:(RIDX9DdS7\-_V>T?>B3U4.BIA_gV@ILD>
[YGA,F?3,,4HBc=RBfZ;]=NLQB](1fC+.(]Ae6TX1K,4RFWTQJ:YG[[M=E6(2<E7
\,6FeF&&OG2>E9dRCV=NcMfX9E+SY7OeBW]+6Q^01ADV;VCVfL,37F;//?fZ-)cM
1>GF\)O^0Xa2&:0D^:.@LJe?6\g[JYBF>WBA\WfJV:PcMdI[3=\7dXa=;Y+f+<2N
W#JK,D3JE);8@#CRWcUQTPcC#2(/bE3?Y9[&9(ZNP#g,T)#QAWa0-C/Zf^8Zd/Rc
cLTY2)^-82PfUV9WPSX]4O]D.GH,O+Q&XFWb5#PC+b([e,A6]K2&IY)J4>,+eR2c
)L,G3LZ_aP_=38WTO28--,Cd1N\E.F-D7W@9d@G#N0#SdRZ\/=,\IW[[T/[/Y70:
W=XE=^MCWW,#Z]E+2W^ORVPY3R4b^2E\PRLUYb.5J+NZ5&Z]2BZ\9IZEY/f4_Oge
TVHS)CL:+6D1O0PMPYMXJ?:,H^Q4,]=C-CAHOTGb#6Q5,6L?.K4,Fb>R?=O/Xg&d
:7)+NJ#ZXR13>N-K71=_8-BLW^;<VbG94.F2+=\Jc>fb-7M/,c2;BM&P5f]dBa#M
T/:<]>NZ<]a)_E,3P<PO-IeEPMVOOK=G]TP>GdIYA3e]^2B9S[BC1:W=9,:@IR0U
W/S5)/6^+JbaH&eIFXScNA_WBSQe5NC&QV/KfNKQZ?0VSQI(F?&DZeEZd5:H\P=b
D@Ka+AA&I1;&#9gHQ[5^N:[JU<I<.\^QNTW8;I=U#MFH7ZLb:gA><;D))LJ?YAH0
5H(L95?<1PX)VNK:Q_(c+C8@=a(ZV>O4RV_NJ,,e0Q,:L-/95G_@PVLEP(17AD/#
F=Z4=CY1fDQ]cONaZ=,-R@^dGXO@b1I#_:,b1D;daHF7M91d7FJ@>H)R0Dg,T@MT
JI2c/cRUG^4?DJ;WMT?87g2c@XM.NaQ#A((YYKbR9@^.c;cJ:EL@\7CBDf<K-\UW
-GT.B\6N&(D\6B@Qf&4&cCYYG#0e#\^eI9VX2MAOI)RAHU^X.90&_4Ad8:e6K1ER
6QJ&:]8]57SP;BC^>]]3W=Q[VW^NSP<PZ9OQf0GS\e:D5Y>N_[&HaM\OM-QCUe4X
A:[d+\348Mb,CEP:fgYf7fag>_EVVFa7c<Db?CeSHcUREYM324;@AA<LA4,X4)-Y
47g8CQ.A^F19^<P8#3@FZF8QI88?>O.0]MC9EAN+^c9Ad;0YIBa#?.M0&&ZZ-a8=
3U6B;CU^&66O+&Y0W>KHLf3@9cOC7JY#Q4Ig-05NG5f>5D(-Q_8#ZL#=+)[7LB.J
F1)Nc#A<Q6[U8DdW3PaY(USee=1=-=WDd,#>c&)IG+2,M6H]3^)U1^aCSP4R4>=#
S)=_<D]5K=OVPKIZTY4UQ-DK=HG6U&8d1>XFC?#O=AM=OA4&1b^2-S[FK\Dc<0eB
H_J(e-+0:A<HKc/8\d0L5JL@>J,F?70&6/7\dN;OMBX=efEZ]P[]HZQ+OL6@51)c
S5(b362DSQE\4c@<CHD]YR,g[#]W<;YQ(b#b<:MVFW]S_J#?)W(J=HDHGAWb:b4&
6>;IFT.HL7EBE5,JEcF2Z.W3OEfeAZ8;Kd)55]>L8D4Z4^+;D6+ARC,X@0(KbMc;
)(MXdIKULe;7-A9#VVSUW4M]=40[AMMCO?53BL\WeSQ0-Q/DY0&cgc-\&]dg.0.^
DLdUR1c4))HXA/II48-\AW/bPMMUd?=[CT4B/U>V@4Pa^A_^e#HdS;NMB()MfKBV
E51J=K+6XUQd)ME<=1f\,XL0U;?GTAA&XW<B6TJ9[2TKTYM/_WN/T;RFQ::4LYB&
?agZe)E)5<-cF1+>YO[0R]URO\.aa6?,a_RKf#0-1[GRdRV<7.VNK2S33b[DX05a
aQeDIK.LW@^H#F4G3bFEN;QE+-gM8(PS+<N^IMf&>4\+;=0/)QG/M_R.H5R6IfUC
/J3.JO.=2V7J[aNFYO)D@Q4FZ^;/5PR-M<]G_EIVPa5+#(5W?;,D1-2S1XfK@;00
)@,)eY<6A,N:g\3f0V1ESU6#,M_1Heg#OCGO&JC@H8]aZ0P6#a\E:)WSLe^>Fc)O
fMAB7^9MBA0eYH7\W,b>]\B0?e,<9W3beFPE&NU>S):2_]IbbR+J+S:bMV[aWTD\
DS8(#N7W0d\[fM,US)P#>@]NF_WI_U3F;K<?7F32G[>2D$
`endprotected

endclass

`protected
(7EBg.Eeac00f]2=Y-YZ6.(U9\KWP<+A<GS[5<f\Ve\VY8=_-_)\+)-)U+1Y<]7Y
:\?X\,I1^U]4HHa]#RcJOV&8C)(//<GVVSLSb(f<3dUdB)04e=I6(fM#MIBY8dF/
653Z-:QR<b[-S,S^V;ORE3MYb,A>?/58:+C6QS;@GJT\-8K/I2I#Z,>^<bQAPEJZ
FYWa9=ZaU,08e0Gg[WZ]G)D(:-IVdAbZJ]Z69aZMLAZ=W@Q[R<8:cZ[?B5,::)[&
+8eP](E\WM:J39R;U7d6F;Q3aY[3^^M[,4YdZfDg3a6C,e^Ff[;B1[VRAE)V6bcC
6R@QUH8Xe.T&fGUF)]@R]#+>=PPZ<0I=-(F&Qd^&D5EK.<Zg3Ia@BUA,5LRWP^]V
1OJb#5gJfGW:KfB^Ma(YLDZd]]4=Wfa94U?8-@SOJ_VRE.)/2:eY4JcWa2W41-PR
J@\+IFW=.U6/;VBG-_9fbN-#<K#2.E_:e2a167M];N-+GCZ)NW)P7]_\XI7:T9):
($
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_CALLBACK_UVM_SV
