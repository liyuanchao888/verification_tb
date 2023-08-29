
`ifndef GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV
`define GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV

/**
  *  Slave callback class contains the callback methods called by the slave component.
  */
`ifdef SVT_VMM_TECHNOLOGY
class svt_ahb_slave_callback extends svt_xactor_callbacks;
`else
class svt_ahb_slave_callback extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_ahb_slave_callback");
`endif

  //----------------------------------------------------------------------------
//vcs_vip_protect
`protected
?M&adeES2+K4#L(5>W80IgKJbfVb?,fODB#9DRaF;SAOXb(CLT<R.([&M&I:13H\
UL\c,#V-J:XTBeKAMB4#1&=4=&\G\^>>I5g#I#556>:?N78#V,VJ8DZ1TDUM=DU^
VU:<3W)b-GC6d+d8WY;VS65fCaW)WE\?8IbBA.4AT1N=7eIG6M4.&d9^QZWcSg+3
-:AT2<:(d;]8B)eIL/T[U+[#3.7f,8RUD1_I:Ga=0)N=^U,e7=Pg.R4WD3B?(]M=
eI&6@]X90@/(D@1V5dB[c-_&b77YeL/#FYD76HC).Z@1D)9E2eA];+,_b.ASJS_O
\U67[.T5<bcf]_BUH5)]VKXaXA-9.2gcaYX9bI+(d>(8HUS4<e@F<\Rb?Z_01-7&
QE]cH]9R^ZC,RAQL-Z4_eZ;_b\C?+TH2[[6d:4Jdb84R.[GYKG\&K_I(-0g3aa88
P+A?RIP3S7P652)C+Z8\>IZ71/I(7D8O0E5YR1<)XfS8L)P7/@e.GTfV3CfC.,1b
A8(DE#5fNXH>K4WA<0A7W<^^6DND/UV-RMHKfRO;Re:6&)9&(bP6eKE6[=O@<0F@
NYBJ&A3+H]#Q4JG88Z;??8e4U0XQDgKa,[OdKZ:5bfI7Pd1=&#CfBOSKO^HKG-))
+L6cP8C[)dX1;GQM(D.Q>=>4ZJf3\J,bEQ6KGAP;Wg[cG)/,=d:(W/Y/6(:caH]#
7=b7I6:QNOg@82QJ<HU:Zd]RGf<^VF4/5R1[U2(6)6]@_&9\b(T&K/JLOI;OD<fQ
I=RN98&PYRg/1Hg=5HCW93J70^D5bKD5f6Z9VG2/CAZ6U,/:EWZY9/^g7O,3UbgN
I[cK+BdN=,:V]@O5O=T?]1g:3K_FOb.JF-2ScT<;NB=WO7gBg#e])fFA_.9[M3#5
\TZ/)2H](&>bI90?gKTdW(3:6Q\](6HY;OZ;^5VV,e74>:92/[J_G6FJ6Bfb+3(4
#IG)\eLa^;ZU.-4f,<.)B,O,eIaf4P[^U6)@O@&/&AMU+8b[:G9e6GZR94;8.1NH
4G4JBNBac?f?CIfU87.gWbSMLO&UOVCCTf.LD8ZaaS,+#F:-g<2HK&N,5(U50(ZO
E-;:]9]^C@BaB9,14bg0Q(9_63Z)9-\FYgS]=fVbR<4Y)WO]1^8@T0+d(V>)6<gX
B7:XQE;UE8W?<1>dd(HE:/D^6[9GKMGFYaYe@?_6P4WJ/@]E+A3P1,Q=2#-[dW3&
HWWGO5Q#J3#UN]#S]\B&IUY^eCL&7;^/b[YZ#^B1NL)F0)&.II(6,/g)d;8BIdK0
bg8\Q,X+1^_D3Z-(g1,)0NM]9NAL>7JSYM/)gS(f9>#>Y7J@S&HbQPJVVa-ET9Y;
\/<I@=@SAgN=_#^fW9PV=6DQ4<04B21(2P&G/7UaL?8LcE?Dcd1<MBZ=)96BY,-C
]P/(cOX?9JdG4R?^aaQa7<gC9-PeEGJU]e7gC]J7@b<KfWCKU1NYI40#:JRZcOW/
JfE([PHbScR?0R(J2gZ]L[QgOE=@U?IC6(?DJ8c@3FR[8Vc(KUBcZBMJCL_LeY<N
O[P19#&4a(FW0.635\AK7Ffdg,_a(I@Da538IJ:L^JAQ1.baT-5<\0)cVZIO_11^
a3R_/bX:)JDMT72?dW179;6Y8PIGD0^B>MRBdNOcR>]7V>TK0=YX^X#40IWP.8CA
[f3=.c5JB:GcaWg-9D00@_N@78WQbg,\XE.H64((+&7<Hf\Y.XFa-CEA2:GI&2&W
[ddB><B0TZ-/f0]@a;1Jd;9ADAKT,VRZCVJNYW.G@<V#FM3N[-Yc,J-1?#,UaF1+
68W[(T;6(e_5beTO3=LZ4f?PTV&4_Y2IUVWU;b+3\9=EJOQYBZ[d8.ME;cY&F?_E
K17((@NS93FJ3/T2MY9VEC1W9C:60K?;R?4R@?T-..OI-6^WM9Ag^<.ADDc=A3W\
aGP;T+:9->.G,S;(L_=c[D:LMRbJ=cAXP,ME1gg&W#CN?S;14#65GL+67#T5A0&f
9NK50Z,a8/Oc9V(3KbB0+d3P0g5Z/M&M3b^?0,J7Y3DaT;JK>_PABV/KI(8M=+XR
D.aSASD;./6Z8R17,gT,0EP+T1IT7EaW01a<-B./KX,U?d98&cg-49/THa^AYI-=
LLQ[OYB>3B>,gNU:g5_AbfaXR7UT./O^_YS4/<RIDf^3Va:0RCOdf?/>1<e@3RS4
U<:4>C+4P_/C=_Q<)P[]g-;M,^M4UITS[J@8:SLJ./Sd,>RWK<f?45OX]ZfCeE#9
_5Y9&ZSK8]C:&NI0<3dNP=F>JAGU,1Kc(ZN/<HTTe4M\=PVDYQcC1&c14H=5[,IS
($
`endprotected

endclass

`protected
TCM=F4eM(CV?2EN8)b9&2IWG@+?V8,4H:.6)P??IW3C1Z56O<LH5,)9+ZX3;)[T&
c-6[]F-;2cV>Xe,TF/Rc-+>OYQH^66df+59DBU,#DBf]Ze+g5>(S?LWg6c[@^Nd9
@IUXJ_0QY.^8Fge+g^F?2:-_5O4Q@4M?-W1Fb\?VNeC,aeJ>8T4c;=NfbFXJ4Q++
0\HR60M);6_F<cd6.N=E2D;G]GM6?XE&7MI7M+/DXUH4<FO0X:IB_K]fe_QF)#cW
=P\Z?c@GUb\WRJVQ.gS>@DMX_Pd_7)YTPZPc#,@P0Z+IU.^A/]eJT8(R/-0U=Q93
\@6X/]0VG4OB&CLT&GR+-RaDB@BTJ49M=$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV
