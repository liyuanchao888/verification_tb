
`ifndef GUARD_SVT_AXI_IC_MASTER_COMMON_SV
`define GUARD_SVT_AXI_IC_MASTER_COMMON_SV

`define SVT_AXI_IC_SLAVE_CHAN_DISABLE_CONDITION(interface_category) \
  ((cfg.axi_interface_type != svt_axi_port_configuration::AXI4) || \
      ((cfg.axi_interface_category != svt_axi_port_configuration::``interface_category) && \
      (cfg.axi_interface_type == svt_axi_port_configuration::AXI4)))
/** @cond PRIVATE */
`ifndef SVT_AXI_DISABLE_DEBUG_PORTS
class svt_axi_ic_master_common extends
svt_axi_base_master_common#(virtual `SVT_AXI_SLAVE_IF.`SVT_AXI_IC_MASTER_MODPORT,
                       virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport,
                       virtual `SVT_AXI_SLAVE_IF.svt_axi_debug_modport);
`else
class svt_axi_ic_master_common extends
svt_axi_base_master_common#(virtual `SVT_AXI_SLAVE_IF.`SVT_AXI_IC_MASTER_MODPORT,
                       virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport
                       );
`endif
  //typedef virtual svt_axi_slave_if.svt_axi_slave_async_modport AXI_SLAVE_IF_ASYNC_MP;
  typedef virtual svt_axi_slave_if.svt_axi_master_modport AXI_SLAVE_IF_ASYNC_MP;
  protected AXI_SLAVE_IF_ASYNC_MP axi_slave_async_mp;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common class
   * 
   * @param reporter UVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param driver Class container for the signal interface
   */
  extern function new (svt_axi_port_configuration cfg, uvm_report_object reporter, svt_axi_master driver);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common class
   * 
   * @param reporter OVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param driver Class container for the signal interface
   */
  extern function new (svt_axi_port_configuration cfg, ovm_report_object reporter, svt_axi_master driver);
`else
  /**
   * CONSTRUCTOR: Create a new common class
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_axi_port_configuration cfg, svt_axi_master xactor);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

 `protected
(;XS2=O5:X\4[Q<=S3>XVV9UVb=UC;BXD+:T47g<(0#QLT)7P<@77)1:_;=O:,,a
0;B0;Ig)f?54-$
`endprotected


  extern virtual task async_init_signals();

  /** Drive default values for slave signals during asynchronous reset **/
  extern virtual task default_signal_values_async_reset();

endclass
/** @endcond */

`protected
RU+XPZ&_]DWbM#Ibg4OZ68BG]L5g-K31B]EEDDIH/>HbaMT661M-0)]FPf&.)Y9G
V1KV)g0QQ0O&47@NOfc=6K65fXX8>+EeP51L<CJ0e&c0\04Ad>2TYYB>L-gG<<V0
^)7TC9g#\@TLZe++[57TA:T..&\7D\gW)CX:1EaIbZEcfC:H+aPTQF7;([7B,^TL
HH+F>;WOc#.UXf9BbV(4da=#5XP_V;,c-G8O8#/7-1W#<_NISQ7)N#]L.PUMNeUB
cSAV<Z,,+GcS\:-I,Q5G(1IXg?EMX)<E61Fbf]2#+-PAAI9e&24Y88/3OdT<;L(V
,fM#I4&[+I6\PFgP9E0a]Z^,XDR+8OVfeRA/73T)AW5OddM.X28HLFHfB>P(J#87
EGO:5)Pg]]D4F&-</LQ41R9dA/2M)]f6#X+^Fag;gfY1C;V#->>&6a7EN&e<WXT#
&P<_V&C>LIgDUO-ba6f(#@9S_UfKP_<8?Z24Z<5=EL+QNCd1]BcR4dS5-A]QFV=2
>EFI8>a_ScYBf[d?]H2e4RF1f@cb&X+>6c74:>G+&@84-25_;)ZKT,3C3(YKYLK@
N>&;>X[)S(H)/eGf,R].A;<+L@]&CMWFeKc4D;&@H;=\&5>eI1FZ/fFF@MJYb_JJ
;c2X,CMTa]6/[7bT<X(3]6LVG:Z&)XaPUgGLK-;LN(3ASCOLF//HOCg7DXF9Oe9)
4Y92LI6K-DAMe\Rb8&@0?\&cHa0&N8G,YSLa_V77QBFYXO&RfSYBg&7_TfM>T/:_
bII1@[b5,1ZQC9/B^?]e^<bK:I@-^4J)Rc,PPX[HHDI8A-(9fc8XK=X>9R>]Dc&e
c1g)W^.b4Na1H(.Q_I8[.O.g&XKFF&IK[dcJcA4QM96OD#^^\-PaK?>SG<^\:W^W
W9BN?-DS9GFH^g&+=WHKCSH\1Qd.=^G(9<_?YY<?H4a@gOOL(AA711J<L;aS[(^G
ND\X-]8)<U31Y+AeFe(9#JeaJ[&+/geO:Eg9:12IPKDb83YP?B7Y:54#O?0Q+]Kb
HD4OPgP\1d51f@7=0<6)_3,R+UF78M3)+A:8YA:d-F/YHU,,]8\(3L?72+b-D)T9
>5,#3206b)cea+9:0Y?6&bTA?,2PF20)NcU=C2Ad::V79=<^Ac3b,C]LKBOTX1\>
F67[>6K[gKB[VW2a99NKJ/KQ2II2MF28X_E0<28->Vg7D$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
^5;Hc<>\f]D<U\O]G;e/&XI^6DR[9BXQ=#VRcdFbDD(.]^R>ME4V1(.#O/A\@61=
.(]@.B^[H[I&UM=<.,#0NK.W76eC1ADcISe:3QME\Oeb.QY\,]BL)#f?JaMDK2JW
JW82=cR[#:K4UPKH]+^SKRQVBA,(6B,ea0)@,He?Tfd;[dgWM2#Nc_Rgf:bbKP^B
-gK/BGMANd1a@MA3YGAaROWX(ZOJdK5g4@GHZTT1bC.I=7[b9&.dRHa^G;f=9X\N
5-(O#O+&1eFc-5]4M=YgdHGADF;E66^PW\S8/WDM4(IZ([,8:5cZVQA/6e\6GaTV
UHJ]A/IQBHJeU7(<9a-D34M]R,]M<G/LZ1.>OQGbXM<V^8G+7@dUef?9NLPA68:^
Og<e_8U[U8GTD+DJWb^_O4=W\:;bb)OG;,I=RZ:fE5Y<<BEP@d]1SKUcOJ5[7.Rd
:ILATT6&4<;H<_/\X50AMR=U)7Z+5bcU<T21CTfZbY,BIb:F#F/E#L8]0FC-S]B(
;ZOaX2H+2NX@YeI,+Ge9_CQ<I-##U-WgYE=YXS\O0&KFIQKJ??)5_LP9bZ7f@/Bb
5-UNPH,dU(YY((<a84WM.2e3f+L-7:b]0LE1JWQR#EGe0DCE^U]KMbZ:1(>TMMdP
BX_V@UX:8fg_>#,W2WR3\Y,FR<3&<E];a)Z/+:V-;#\N.4J9S#O1WXEgV#0XKH;W
FFZI\[b&=a/EQ+T+L7c)9[BPO6Z+6H_;QQ.g,XeRK-67I51]<bB0c1a5f[f9X8cD
7S3(fA811A;211JAc_N]4g.,T_9#O3#06FSV:4Y-&bJ:U<7\HNa4PQML./]GM7Eb
SQCL-&YXDVD#SP/)Rf]U)C;X,&OC-=[d4S#QJ;7NREAgEI+]JJGCZ1DGEWC7f8IN
5=9BV?F3_/ZeTU7]Z0a\E#^GK]6+H>JG_E-aJd3fRAdPFC5J;89\_UZdC[OLU/MO
eW3YgPS@@gGLd^4J21dOWERGa/58O[bJCYNVgW05=?=O(:aX(fLSY;B.N)LFe=@Q
DaPW0DR6AYATZ[^7-gIeS6bbgY;.[Z^<.PY\-6A0L[c_eeb.6&+SJ;/&JF((W+=>
4ZgSO3D2D&?Yd-VZ)#@de(F;)aYMf)g??EJ]3@[[QeV(aT;CB:P<LJ7Ocg5W/KYG
#3+[0\4Re8[:gRRd6dRN(C7^FU4d^:-;4_:U\:ZZ[XO@Bdb498cfdKADM8W57X_W
KP2<T)G?,(>HES9A/e-#[<V5f9@6bQIM@g=4>4&6ed]Q>eD5>A>0gLSPBEfKZYGC
W@VZ@NPVA0Q81?30fM=d(ZcFVMKbUDXSaJe\,Z_8Se1C>/<FQ?0Wee65ce&1EfCK
0cS42XeLA?T3(.#;A4g3R/Y^7#-5R+79-Q2@#PMT/):LEHg,b\];8U15A,R\OeUX
FdU7[T;2f,&aR74fIFX^:0eRPS2ea.:H>3eR;BF4YbFPP3T[4?\RE=LQXP32E.2G
PE:;:FfPXZ/2M:Lgd1KU56Z1(QeI@5^bW;O]X\:(31U^MZCc&L^OPD/d1W/2H>,L
PKT25ee-VGaDc_G.?aT_D,+W19==bH:@UJRH#=fcSb^RV22YG-NM(C;a4cOE09cE
]/[Z4V5+b[>L7--Gc6M1/fb+ETOP6S[25\/f4?5^,8AK>d^?2Q0=_d-TMDUKQYMd
BMLVKHd0WBH8#D\^3/(Z?GZ=0A,/9H4L@.Fa\(gVPX^5Q4,&(Y?dG>DP<8_^dHBV
:]aZ>CIR4+KCcYRQeWe^U&eKG.M/\@/^57eBQgX7#1:Ba,0ES#+>\UX)=YbMIJUa
[KY<aG=E.-IK0[3KWCbH7H>e;+M@MGWZU4^+D,\e=0[(KA+aYE@<VaQS/e0.NCQ(
>,K),2=^1g/<\b(=T,[a^HUI-T1/0dcSOT<-O+[X&5W<4[.V6O;T3C2>ODYT_#]d
GHA4(WeF0,T=@L6,a,@\(<3eX:R^.cTCHc7BFQD3EC^Ccb1N?-GILTYfe=9F_c^(
?;UU^A(482X,?QN#7LTf5W^?e3eIC_0U)Q-Z[H9M.=<)\K(3XQ&ZCPC&.(]c0O]2
;O7G6.-EX9YHd0JE\E6S)C7EgW^?]V?^,UJDBB)^YWPcV]Z39-U?b76(F?54,YN<
Ya0U195K(M[VdBEE]OVHJM<@O]/>9>AG,@EGZ7<8EUY);I-\/3)/Kb01XK6ADR_e
0:g.bQCD</[W_KK1]>6AR9CSXY\E#()CB0-#N?L48W6#BS@f.<^2WI5JP0:K/N#P
/:Zfc2==MdXF.A8_K0;YG=:gVbaGP?8bV,=29.1:XGef1aUF3WgaPN^X?\eN;H@8
?<aZ?N\H=G>YMR5bE#>->IeU9>WIY0F#J3g>7YAe:AYc@)U_CXRF0CP(<-,Oc;W.
6;DQ1O?9>+OQBP[/Y<]<7X+CSEA/W3.#Y7O-8,B-^=>E9SZfIgM>+<L=7;REX;GG
MK;cVIH>e)]Md[_T.e<7K/0;fB-(+U?,8-73,[P[>YA,@<d[g0#O8,8VV8G_^>:&
c@^8>]WGGX86<182._K.[W.FaRU;F4f;9=geU/\A=AVO8T,&:dZS-O2dQ@Ya7B[.
AW;XA-/&72-[Vf9JIc[:F155:/\Dg-454U(/Tf3FAD?._AcYJ^]YN8-AX/3#.OW,
UD1JcGP9Pf+^D.8I]+4B/O6SDYV\]ccDHG5&.F<)fDV0YE&][WTQDG0<V&=H<LVT
SDX\J8a\SN#I8^g+AC:L-(-YM55J;.YNJRIRdF,_IF<gEg78]Z@44D[D6,JF1.CK
\2&GJXR(QROIG@8Z/=98J#KKUP6W#C11fX3T5B5WX@8E>Oef?BQ3gH2UKG2R[KF?
XDVDc=VJe_;BW<Q8[H:VK#b7Y<PGV,_0@3YCZ.3<_>Bg;D/&BDf[=0J.7MOPE)4<
f#4532bC>G(9g;3JKKF:BPSDA2EbOHV5gaf&2EF[Q)79UX=Q;T)&5?d^1MIVO<b1
eMbE29DZAf(NAL<&-0#CJDeHNU]M#,g>eP/g<3-XCXgE_C>2b[-<Q0#fP+;eWO5N
=NK6Xd_\U8FBTO&e2092ZWGA1P@;2@41+eb3gMUTLOA<XDZ_OZ)/gQI#)<X[5LWM
^e89\d23)/D0PX__1Y;^Nb)V>-((BI5V-J[VULZBJ1F,VUaAY@:cN8)>8:L8UZ3K
L7/#MP=ZDV5fX_2/+db#\D_XM/</fIe][f2)=+fW,Fbf0UCIG0H+b#1fF610UY-R
QUOI[D&[<(cf-6H>;,gXD0E.5I^EG^[fNNT/B2NdBB+9=>0HG)./]HcB+<)Q-9<2
&&BB2\;HXa[)e-aPQ-&V_1WP9DFP)E)1a1cHW1IIOg?+SQIIXH^dB>:TE_O9A\Oe
4VQCCH:.QbdJI?XN9Fg_CL5Y&X/;&WFNUPMQKHXO\B;fTV<C(O3<e60Oa-3W;01]
+_/\9(&^M+N:JI^P(PU;9fMJ?G+SZc;3&CM&fI:[EU4OOB&D+)Gc+OKd1f2Y2c?4
H4S&cGfFGP/3K]d_=fH7_E-/LY]<VNd6\F\_G(HV(<)-.>BX0\?[?,EgP6/PGS:R
X.Q4b2K3P5)9fQ94RUa+_Lfe=8S[3];EEg7([MH8>bP=E(,4a<#9)3VGfYDKHZ=+
;Hea[<c-DMJZPX+(ZMg/)\\4f3N#98B77?b@\,#c&92bLc4WQC:T34GRAfB+=a+\
R22GPECV&8Y2&&-F8JQ(G6+S\A=T;AT?TYE-Sbe^C.#cS/VL6.F.]?]UJQcb1/3g
_)(WZNVe5aZB/#CTF^RGA5P]\Q,.7DPDJLU[>10f5=;I69UGIIR7SCdUcG&#VIJ1
:H)<:=Od1B.VBDgWV&Tf(Fc,UWS>N&WXf^TD4POCde)cV<D?8[HT2?IOeEPbL:8T
_]C(S#Y.GSI=V=+I/0=[M60__H6SUSe:CKA)J.J3B9LGIaEKW48F69P?U\bOQQ;A
A889252WQ[Df))#M.W(OJ=-gCEcBL4+Y;#BA]<=25.eaMNF?W;(+71>LYCGYa<:a
g[<E\FFXA7;9aJ06U-SQ8#T3N,EFH+.EYD,R7WVZ(XbE^]57CQ/B0B2Z(dT<W7Vc
b9/+ZYUEGN)I][2B4GPKXG0//A72XXJFF/a9G_Ee#8E7;-^70W^T[X<C<bc2UF?X
BB9aO5=Q4(,TARb43\MT;9<EbYfec8>&\?XOeEI><UCf=+4-Y=ge?beIRbga?VX+
?7Y6b,R^(Df@454^S&3&TTA24;P31-4.&U]#QR0\C9<Dc>3^QMe)T\)<8K_8_5g/
U@IQX>1NEO+/3[C43e(ZbXL.&XeU71/eVE;0X1(,OAb<6\J/L-[]b95N]feB,T9X
YJ8)B4Z)QG_MJd/5W2WW/E)^2@E:ICN_,E>/J.U,UXL.@TI)RT4\\#Z8<DNa.Dd<
P?NO#O^,&e4Ue).WR4aCJgFXN(#8Ufg_CSa>JYW#e=.M=;be-,F?2Z;J3UbP=+#1
f&R8,4gKGgG>C_d)\(UH_.788;O+VcZ=,60\,f&9(GG0gaLJ;Y5dA6YGRBT#c<.4Q$
`endprotected


`endif
