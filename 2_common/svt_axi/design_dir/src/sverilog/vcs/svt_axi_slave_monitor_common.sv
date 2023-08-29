
`ifndef GUARD_SVT_AXI_SLAVE_MONITOR_COMMON_SV
`define GUARD_SVT_AXI_SLAVE_MONITOR_COMMON_SV

typedef class svt_axi_port_monitor_common;
`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_axi_slave_agent;
`elsif SVT_OVM_TECHNOLOGY
typedef class svt_axi_slave_agent;
`else
typedef class svt_axi_slave_group;
`endif

/** @cond PRIVATE */
`ifndef SVT_AXI_DISABLE_DEBUG_PORTS
class svt_axi_slave_monitor_common extends
svt_axi_port_monitor_common#(virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport,
                             virtual `SVT_AXI_SLAVE_IF.svt_axi_debug_modport);
`else
class svt_axi_slave_monitor_common extends
svt_axi_port_monitor_common#(virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport);
`endif
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
   */
  extern function new (svt_axi_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common class
   * 
   * @param reporter OVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   */
  extern function new (svt_axi_port_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new common class
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_axi_port_configuration cfg, svt_xactor xactor);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

   /** Writes data into a shadow memory */
  extern virtual task write_data_to_mem(svt_axi_transaction xact);

    /** Sample ACE read address channel signals */
  extern virtual task sample_ace_read_addr_chan_signals(
                                ref logic [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0] observed_arsnoop,
                                ref logic [`SVT_AXI_ACE_BARRIER_WIDTH-1:0] observed_arbar,
                                ref logic [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0] observed_ardomain
                      );

  /** Sample ACE write address channel signals */
  extern virtual task sample_ace_write_addr_chan_signals(
                                ref logic [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0] observed_awsnoop,
                                ref logic [`SVT_AXI_ACE_BARRIER_WIDTH-1:0] observed_awbar,
                                ref logic [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0] observed_awdomain,
`ifdef SVT_ACE5_ENABLE
                                ref logic[`SVT_AXI_STASH_NID_WIDTH-1:0]observed_stash_nid,
                                ref logic[`SVT_AXI_STASH_LPID_WIDTH-1:0]observed_stash_lpid,
                                ref logic observed_stash_nid_valid,
                                ref logic observed_stash_lpid_valid,
`endif
				ref logic observed_awunique
                      );

`ifdef SVT_AXI_QVN_SLV_ENABLE
  /** Checks that slave component is not granting more outstanding token than its configured, for Write address channel*/ 
  extern virtual task check_slave_wr_addr_max_outstanding_token(logic [3:0] vnet_id);

  /** Checks that slave component is not granting more outstanding token than its configured, for Write data channel*/ 
  extern virtual task check_slave_wr_data_max_outstanding_token(logic [3:0] vnet_id);

  /** Checks that slave component is not granting more outstanding token than its configured, for Read address channel*/ 
  extern virtual task check_slave_rd_addr_max_outstanding_token(logic [3:0] vnet_id);
`endif
   

endclass
/** @endcond */

`protected
f/,@Sg3EWRE.\)aSZNcB@^V63Ad6Na^(E05g=>B;L5a.@=+0eg2V+)H&;+/eDDcT
64P:&4=FfA&CbC(Ua(-g#IC6e)0Z,D>=91[MWeW&]23C^=Ge<g=,H1-\de2(7g7]
a,0a7ZVE5gNZ]-IK(0O(I;TgV&UJDMA<cdW>Sa=U0]P;_Z28#_;P.KFEQLB3CD>b
R;O^B#e2_()LAQ@]G2DLPO4KPVDS\6W?1efI_O<VfdKW7,T](>4B<dBc[,,cH0-Y
b0gQ\D3-[>-_E582>d9_SEFZfG-&OdAB5NQ/17GGU1X#TQG?1)DC1[bJPIG:OON=
AAY6293Q&0G3RLW474YG1QR0J<4WKbT.beC[]BT>&Ha^1.7g6D46M,b(gDPa,6O;
1f<,;I8;GQ1>8<d)?]QNY#\8X@T7Y231C]VcW0(+Q9(aY??&c+2aGNJ^01]W#2.=
N1^>2]5?Y_a;XCDdV)@LA80[^P=VGHHF=c?G##HAAC/7_&gH,6Z\)Ia:^9016@d<
/;faG;#4_@5BM)(O#2]M5U)Af(c@I-63XQ3E)c-):2bW&bUJ+I+YAH856GO,K=7T
aX[^GA)X7Vd+;R:VVX1a8LKYI@@H=[VaYTMIgXb64I(\KcCKX&YbZ=5ZKg<c_RXF
@b_c<[HFD;)OUL#Y,g3=[#]<@9TCM[K&XJW[PUJ_ICHH7(IQM(/>(:8;LFS;:.c(
G/?E8f(VS72/E4bd&\cd_6<V01P0NH.@PXaITf3gK#QEDfbNC0/R=^=]A_SHRQ#e
NYP]3T9VU9TFdgKF)=XHVK>HfI;7[QJ^eHDJI^(\10,2;]XZ.7UY;.^2E-?_QZ79
7;_.ZNH2[7O?:?07TdQE7>>A)L5>P;^a/gENg86,cg?7AbUGGc>@;[^2P$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
.Ja]KZXZ>QgRN]R,T0_M(]?Q\2P0(<)P^>+V:;GQYe_P=Bd74Ob/((S0AX[f4=O=
LI^?a):0dgS+6U^]L<V42][g>,_^X(HP\:J?]d/K2&D88J>e;>:d\7cEBF9>,7e-
;JP2TUPD(4M:W&(_VPFFUK=Z[2SB4^c^a\OW>X5[eAH5Y]Lb=3WS3@c9NHMQX290
WN#gY4.(Z+0[<JC=Od@b1<;^G\@-9TZ1Y>ce57Mf:ccJBT+/=a@;_BV.K&D]A7TY
_V.G=X-M)YbO/FTSC(-6<=76?L6R6A3C-DH6c84[.18d:^Hd7d@S[#]Q\d0SJCaa
4g0)GOOCGIG9_:4R;O-80.]/<&2H_D4AYQ3;)U1>Z&WDFIZ,WH=Y]>W_[dM^aGGL
Y;P)JGaNf];P;aEafg-/+5GW6cQU&\5G83LUE+>=UbMEJK<SgKA\=dE7fCO[aP?Q
Nc).][5D>-g@RgGc645ZQMc#A7H2UK)/+AR@0M,AXY.-LcXFAP&a97cR<0[#LYCf
CY/FSGaC+?CAe4](FG])AQ7V5C.]EX24\/&^5DOHQR,[(e0[U3P=Ec,:)d?HA51e
Q/a3?8=-DF88<1[T5.a74ZBCMd5aYJbLE:7\.(/bIQJC5QSDE>ZU/<R2<_.ZS.:;
,8F3-[HH@cARZ_TY46UPfI3b]Z)L9TgbR@@B&#DXJa4&aV2<+g;L=7,2&3@BeM=d
M06-3J=(0?30QR&\UN6<^\HeVe<ZaVPD=6+QYW643d>IREY\O_VN(=9D202eYAIH
LQK:WI_>DMe)cWe,9bA]e[LUHRfTLJ\&X)+:fdKefPWF/0I>C]L)V4fYVJW,RGa#
,^S4OY4FT^=W>VK#41<9bMJf94L[d(]#gI0SQD4P8/?L;-gK;EV#G:,+5faST+RU
/+<+<TS?21BU44K(D2ZK5]9KN7+J8ca/BfBXV92&N]+.TAGV[^M&.L+QdO?W(?>T
I(;aQIM.7AO>_3&19&9QJ^,Ee=+8)O-Z^Wa-<Hd?B+Q@5G+UG[;JVI6>bBP&?WH)
6M-cI[2GgQ\Vc-NNR[_f+)Oa-#5(eEPO:45cE)d89P6[P^S?25HQ?7+]A6W[d=#8
&\TTg4I6@J7-JX-0:I/0B3T/++N)TOLGZ-0Z@C4?J8/-5MAd?cLY;Q+9MG44;4gJ
V<>=[PT-72B<AVF9L:-=+Q/N8A5d,8YCg3e]])_&7g9J?PLD=DH_gY5,UQQ69-OV
<a/Ef_.@1:WG#Egf[.U]U?IH+<,ZIUQHRUS9X/#/EWRDONS4_DTY=+I>.-OO[e<(
K_FN[K9a-d3-2C6Y#>&AC7R5TgL7S(6EEAa)@75>>[b\TB<Zb.S[4T[2MB1dU4bc
@9f(dUOC)b>=AR>;VPIdJ[.O3#RFK,S/)GD+8Ae])+<O5Z\HC7Y0P^WH@?2HF]CC
e8V]f9U8K,:@2U6[ed4;HfFcWVR;RLOKL9I^I><LS-9)c(K1?a6ZdU+JO9c(5R^D
HAL9^;Te5OSPb(ESS2H@)-E/ME<P?=N_AZQLP7RUFXC;3DW((3M64H=H^TM,d>ET
NAU3UVB<P\Bb(>4FgAKI+&R-d9<1M-b.E@cg:gZVGHO&f7a+c\d-\I)\Y_MY\I(W
R17RH8N7Sd8?QJ7SWagNL9e9=L8B3<54&EQ>SN)O:>6&?-+8D\V>]Xb09/2&8,B5
RJDIW/R\OG6)E2g?BTX\W5YcggL]-6BF;5QC[,;[VZQ;#;dX<@F4g>)&.^:?&1gd
:O;=HOd+@&B)+VVf&.L)SCY/GK7Hg)([T9]S?Z-.9>=?I)9F)b(WUc\^V6/Pc)dL
S[-J-Y0gDfWcbWf\J+HMSSN4^]9+<@RDCEU^GgIX#EEO>2I[.,G<.^/LIeU-^6^B
4+SL[-ALaG#W(20\=D)NG)&e@E.-/^1?ebO1MBJ?B_-3I,B,&6+T5#fBR-#FTe>1
f@Y2cU7N]Kb\cE,+SCXdUH5-ULK,1=P<M#0_T#=[8@N^D,6@-bT1XTB9+Qe1@_;-
-0<?8IO3d-^-0a,RBJea&L5_48#FGQXZ<SKc)Z]c22)MGZPNQEK48d.c#J[YQ1JT
8WRJ<E+X7H[NbHB\61=VWWM);(:Y2[BO@c5F7>B^dd&a80#F,;9FSID.15?9EFD:
,=9QJ^#_K71NM3eJd?5?#M7\6dS;Cd(7RfPfQ;:Q@JR\K5gQ1A8\9TG\a[H<-:YW
=g.@Pb/:bIYfYF?K4S)N+=K<X\6(C1.\;8U0XVV,b0.c\d.R8.AcYf([#&3XAQdS
[.YE+<ZN-4GFeL#[B)a[P+>]-)6(IB@^V2<CABfT@UEXWRa53#8O?_<WYIKXHZ#K
<?0.P5N[g^Q4H3I=JfI6NSgP0c3#_;3/4ZO+K/]:MD#.5Xg&HZg&Y6L;.2@gSS9f
/\Z0I4^#;Fc]+1:YM9CKa/<,E9KN370QU7SQDZS65cF-N#aSLU1_JKb1DE8VC-eL
KXH=RH<L0Y_#FNEAEH;O0@2S[EVc0+_0@cWPf)&2eS0H@Z;G^2P-VJCP,2ZYdTaS
-KXfG52T.bAV2LUPV#@B6(2/HE;f=Dc2a+\-1D5a?QD=#EeTgGbEX_?QPUR[FI.b
[-N9P_W/]GgbKZ7GD9dF=O1Md66Re^1,<2U#XQP4V>c:7Y\HQS4V\CSIPDe2dO.6
_UXB(V@B2<??Z_51TBG0+&1+=OLc;II\KB=0&N[A77C(K+)@[797-@DNeD8?JRIQ
#0?<V#Q5TRKf)Z89G7W;(e&D(&.a_&AW6)1OVSY<6b8:7gF4#NY]UV#,YeNOLd9c
fW/.,)D[?R1JQBYUHYBG[EMB+3fKbX8Y9+,#QJXG#P:,\OOY&HU+27MO]NL@.K_-
>K?#AOWcUA)27VATbN59JLgP>CVYHc[A@KL5,PB;OAHT/+^OI24Of4OS_<MUf5CM
Y6SN_0NcE>XcP/.6[QN/_U[DNc8INa>B@#&K@)2[e]NZ&Q@<4?/0.C[Y8ZZG92@N
JC9:L4c59,?^b2e6^+8.N[Wa+J7\VRT+VXfJH3V7MW;db(BC9Xa@Q4^7>YKM0fQ<
DVa8BHOY8aH9@+_N_JTGMQO=cf6:GL3G(4Jf=&aUK8:cME.YeCe.:7bQHJ2@^12b
g/.;]3cV?+NO2)0NQ(=SfTeg?+^2I^4gPH^?#3W918LSWLR5:6a0Ce>HNF@X_3Fg
5(L/-.^5d.VR\TW()d_NDbG#L#A1(4BV&NMd#^P)(0]e1T3ZK:-dAJ7V@da^E145
0?3_H3<c^VAEaKeS/@4GH3&c3NAb.1<E-T][Z>/G>cH>VW\>2^,^3]IM+G8L(T.+
69(OKYDK4/]-Z3M3/.bC7T7;3PL;U?#)_dW^EgVPPJB6D0e@dgGE->?DQeW?9[HT
7&1eT#&0]F^<_&?^[8,KHC<<16aL5Lg0P8?baB\,KcM=PgGM>Q1f#B\M&[DZ(V3S
a?&e+0E,3,\dK1OA?COE]ZZMD76[D156WX)_MQ,]O9Q#HAB#GQV62EEJ1<Z:_0C&
ed[Cd.+VUIV1eFEdfH>NL<P1_1V47B.e)7L>>->[fM3aP9?HN0I_V@ZYPG+0T\6]
,0^-;YWB)BFfGdK3W?DOBR1?^[WC7ZJIgR+ONT017,J27IcR9Z7BWRN5aaXJ<JJO
77,>E&d;,/1S6[QMKZa]WV<b4WE.[7&U,0N07Mf4G@Rc:MCVR[9HQ;Oef_?Ob5T&
&YHV?-H\>0fFTTRA.0?gA[OCABFK.T.S>cgfA;4L]d<F^ZO8d6a(QX8T=2\79(P^
gLD,QO:&9DW?QbW^H^-N,>OfVPG8SY9-1W2U\^V)]&PUGKZ_Z28TaL.NYNWW@O+)
#gb1TT1,/L\D&>:a/gPN[DU(\/[ZC=)3-VB;U_/,ce1/QeMbE[VY2/MX2>9T8D^U
c(P^gZUOgTK>2N88KAAC[?:B;#fJ3c1(9(Q&c->LcFfJ(E+aKTS0C2IAV(WDZ8E(
H/<ML9;NYPd4e:H;X:^Oc@S6cGR_-?WRKd53b:I&Ye#4AO+G67\LH]#?X&;VG[C0
]\WU<g&3[=9f,4bY9?YGfeYRf63+XdNEK8;?c:\(VL?,=<4=a?QJ,gae]&.ZC.Lg
7](^#EYS.4/4_]a&K^Xd-b;54b+:FIDG#9DJ-S5DM(J8PHYZ3Ca?APc^[8G7[(<[
(/8(;EA(<Q]3]TALKRARWL[Qe^]Cfab8C_.QXLVLL3P)=)c,Y\+:YFOaf:U_Y\1D
:BWO)R@?-1cS3JOV.P-T[R,K3gbB=gP,<-9N]QG\C2dKEA=P[LWId3F9B/BEM<K0
07^/U_bQ@6XYeg5Hfe]fE=66c2e\WE=J15H<gJKg+/Ja7OE=c<VA[WIc2Y+M0bPN
N::IdUJ<MR^0)X(RKeSB-&P#CB2EHDW:WH+?IDddF#9dX67Y?C@PDZ28?M8cdGcb
JP:d&4DG(A.f/S&I7M]H4a4?&FgdPOECYKW[BaD&KAfAA8]&B<#.,,Y&)DeFRWP#
bW)3=I1L0:(+6J_4+A_4<A24\;?B.W&8E[G4?JYe2cK1,A[6DRM>XZ9A]e8K;COO
.c^>2_PHJE[4?;1H[aHC@+/CfWRaAS0@VECf&#D?O5FNT7JLW/PSID&g,WONU_Sf
5G1FB>8:Wc7P>[TDLOG9FX=fgYf]N<P3/Y6[gIa8d26Kd&E^X29P.YI_8L/I@-DF
L?C>0?G8);gf<b8PX3)EMF6KDMR<.U8,B;/?b_2,NXW);13/V=P)@-f:Sc_c5P1I
0ZH4#K9d-M[#?=+1@(D=@bOVKdCaTC8R4D12MA6+c=KfC]^86\S8@.AEMXN;E1DV
9[&HLf78UWYFGRA,]PIH11fVARFf/[TQG:RO5g9@M<Zb]=I<B/#IAPKNV+6N@5_I
.4b@T3aUP[:g2c)B</;?<BOgdec=M@6B>9.CF^4FON9@4GZg2:2^;?Q.Z>]NR/Gf
)bKb0/FGAA?#.]Rb6)NJG#W&g7=AQUQTPS[F.O5>:D;a)Q+OX5(e&]G5dI?.VJX?
;?7>^CT1?L75@&Cdc\24DUAKUgJ5FY6>Y)E</#f,P\T:8gQ(-R?fVZgL3BP#Jbc.
&L.663TU(FK.?2UcLcPMD7(#6WZ86X8\]IEfG5A74R:463VPLJ.Nd&-)Fe:U]QYL
]7=RSP04,WJC(\#aA]U98^F[873Af>.2=(N9fMAdTU90N/I,AI^gFE5dd&#g]a,S
Y1cgEaZ<<EgB;W\Te(#L]QFScPg:BDHcEAR3#8^7/]/)fg5O&[aP]cFMJ^QW;?XK
5XbJbV6a@RS5O8D8+NI.L2d&.7L[\NcMCE^eD7+:5Ug8&VO1K80HD]FQ;117Dg<L
0T=<>[+1g;1A05;FN2gNA95+&VCe-4P&)/:>9c:H]UD4)@/[0ecb@5@f9O^,J?L^
6W<KWaZC\cSDEe7YN9cNUB^?7F;d0,.FBHXa15f/:^J]PWQ[O)3->GL(F9a-Y9KE
EVF\_eeNX)[S(A3R7]Qf8P]V<&RT-2C>E^RE_EI[WM^,/GY-?SN.N7KA,MQ<M7\B
7+^5CNg9/6-H3WHc2gFd(9S49V3P.Z(82[=^d)-VFUeT3]0R]).[Re32(SZ,de.O
E3C+:C4VEO^eZPRJA6P__V,:dY/d@Q5=D,8:J-R2=0=e4.GV>0N>/f,OF;JOU=fQ
-)TRR6PJ=IBK7HWT#Af^_XGO[JOdHJc?^.8]GcHgZ)M30ZA=Hg,-7OA/V-3GfeCT
NLB5e+<d:e(KIL7c]1ffOFX0[):AV4_HJMO/&_5/O\gY4T_(UCZVa9VL8E+>/[&W
2/]?J?+(dOAZ^]5\KIE:]fS0+UeMc,Ff)Z([/>.[L[B=63#Z.-eRg_0eS&+\.U,,
41O^;^@)aPGWPDIAg8HLc<H-O;Wa.J@MUaH+X\3I@X,U6ZfGA;\7L8@VCMa9V/)-
U4)[^Nddg:57YAb?@&g@7[dGDOB0OcS_S07G4[4OGL.J]&:,YGV];41_)a6-PaXV
GL^.>#+S#c=2[PS.H<TXSCEN4W8R5].&4H/B?Qe2H,(H^:L9;&=M?^5[E@gU&.7H
<cUG3bFX;B2fRMDEH[-bbX,E&:DL7c6Hd-&[BbFP57OT+A7&Y>0.^R5dU:f&P(1G
g?>7TLf0aKL.L3P_d>?64]75]@KKP6Mf..\]IG@eG)FK]+9b3[PGL1AbCNdcW/<7
H=C&a[aU,3R^cV=(.SbJ&-^)DL>cD.NBOM>Ed4280IL&9-V?@(?c&@0<GbT0/+&>
a>g_Ng_)>b(QJ11^_E+5Z_bB&YV@JF<GX;VcNON_X>6B=P=cXVCCN)dTgXN\OAB)
,C/W3O=@egOT./BL)5PB:=aM+8H:19(3c/Y6;,EXeAQ;0SYKJRW6b0;O.TI:WA,+
VTac)PF><[V_3T;f+;/#3UL33KVM18-0Y4G-:gNZV^fdeJ[971<7RHgSLVT],W-8
.NbFAfEF72P[C@L(7W&gT@J8>1Se9.I+4^]Ub2a.gMU0+(VJ_:\/C.J7,)ZbbQSE
a^NET/AL@6U?<g2bOW,G4]ge]T_MF6S(#Ic#&.<ARIfQETSF)&WgdEH3N+.B,GWK
c^,+FE<L_SKFWH:W;K7@1E@V337eJ_MN\HG3N580M9\W[UI#[QKc.&L60Z8OF?N=
-6CX3O.5A3]=c61[O3f71b,P5KdL;ZH,VSE85G^XaPARG6g&Uc4:4^M+,\,\A(_@
RMAcT_4>25>Le(\R4/-W._.Y54=f)/b=)g.Z-fP:.<gU#f]:dN[RYOR<1Y-RF8F=
/I+^V,+@J7X\.UR?QAA?TLEI-@NTd4Jc0SCWMFd:8\3fE.:H,.T<\(9TdCfF-BbD
67>TRHX=,7IV^b?0RE1AOC@a0S=I(:_L>=KO;T6+6X9dZ_^I7C:ECE5KV+GM0)QC
JIXT?Z+4H&CNSB=aV;fCK#H5<Dg15FQ[XVUFG.dg2J@.+.<QZGd,ZB_7VBM6_A8W
7>)4_OX1+VVZJMVY511.YSZ^+W>M:\Q[0^;UK9N0DM?#+9SGgg#Zb3GY+1XH2+dM
#,J&KXbS>D\)6Ae2=b;f\QPOVQM[7J_84_?P1L2I:/Ff=JfbR&6[(A,8)]gUOdW&
J4^A0N&7d,1cG>#N@X,P)ERX_eUGM)EZ)PW?I5f>)&78=/8DU@ZCB8Sc0+N(D-2]
EFA-e,d^?GG#c\.X@(^84];^C?TJZY;/X[LR37Tc1b9B+_C#A67?eM9XW\-cNeYA
7BI4Kf?@+dbeE(5\gQ\Q#.,eS^gCWKT>6;Z:Ug24=OARX0_a7(7LAVe<H6CJN;SI
:XJ[Y@bILS4,D?CTTF_e]1)+U:aSJ<I2_-HaIE@)V__H&5<IULde=+/GPP3=FCC>
SS@[]KP@\Y#^c\KZ6aTW>ZS(X_LL<7Tc6f/@5<=,#0>[T_?#?dC]@_F_BBBXT^K>
?b&B([CI,Xa33S=>QIIG^T=fD[O-0^AY4YY7?;:TL^BZIR:2-&)K,A0<QdCHg/86
5])\_?9_e=Z/g(FK<XZMEc\[QIWeCC=UR;:dFESe/Sacc^fFMa?OdWD.MXcO#O0X
Kc<W=Dc&?>@\^]:+VfV@VRZ&@8B/WQaBcT;XH?=.EL48aBQ.MdBbUMO]DB3A188T
V/6W<>((11Q^?_JBBJ/Pgg?aH@QBX3(S6RcN\1ZZCGRV;Ge3FMU4I1J;)a29cQ<E
f(:AGeS^,Z-_3)fC^&8Pb,/Z:dQMMQ>\SAAYaVP,T3>8JRNbS@=DO;4>F5@#39#.
AJFV\M?;6=MMHOB=b0F5)D(Q[b0-f?YOKB<=RL>)I8H(eLeF6a0Zc7<eK>R[83),
a:Zg^P)fCb0^Z>+c#g)2DVbD2=Y&V?/I<@?,S@&Xe^FE3=M>59AOGFW=1c:8_Z6B
/\FDN(R0Z^H:H;f#/\a)=4E\eEQ\MHLETPW=Nf##GY>DZECK_@Ff.HGa/aN0,e7L
YR&:LG0e.Xf9,I=-Y^]/Xf2</THOKELg7?>L^5Sa;IP8BEBW;QK7TCNGRP^LWReE
Z<Vb1>\H5QRGGD;FRbDG27N>LMcPGg5:[1RM06L+:fE]2-/Q28;O9QTE2Qf1SDW;
TQZ=+SgRV1S5F8SMO2-TC:HH+e&X/2.5(TZ<G6?KQ@3WdaO9[,#IE=@^T<dedZPg
R&&ND5B)N-,2ED&<OR2WOR,+,1[LYIS/@:M-T7FEC>K2\VYMg+<,3.a8IZA7NK8\
Q>6]R.edA\/eT4@1\PcN=F2##=2AFbgG8BF<S?B0Id=WFVIQPW;;JUGE;>b)ZY42
15#>BMbB(.)fMTH2a<PJJA,]FQ^Og)Pd:=[=ND+b8NFdEMI>95U&SU4K,CX)Uffg
)Ob]8/YPNcF7N(P7L.V7TF^^@;_0@]BUVEBXRX/Qc:P5EM(I(YEI8(Q=4e1I_^#,
#SR47gSQO40D4e(A?L+H[6<Ra7d?dA.PT30.1&.1XI6d#7Ac)2OC(TART=]]IM/e
c-@6W#.[=[-5@bL6f#<=D\>K[_OB4e>,XNd#?@G3(Q^.g7V,B<e>(cE[94HLecKA
^A.@a3SVR054c\&^&M42a7?VD&7FG<@W,U9V7f>817YEQ_Bb&#H)Y:bUKSTH2S8]
)92(X@_<F6]202VH[2aCVE4PBM)JD)ca9=<V44>+9e)12a[.+DdB]&J7QeRCFCAe
X96)AaFLLW,BGBQDHdO6V.1WbQQUMBfM#Ca=MUZ.bT7OP]P?;(+VN&0A003g;T8>
Faaf[5++Q3YMYAJF=>YNZ2YQTRL?gCHd.99S_0^AK)W:CNK7)TB4]D@\TBO3-@RC
T/Kc.bb2bD95;2d;1BZX^1g-e[0:Wa>b/9Cd)/B]Vg3^MOEF,c0@SHLS1d;WMHW>
2PT37<4KP;]HEH-(-<<9S1/-NTV)N#4cX^+J\[0(DF>TMIDUd1?8dg>/[=V>(8CI
)8aT;@2)FT#f+V<<fY66H-B1MY;Q@=gFgTDAX6^gJa<3J?+062A(gPWVR,CSF+X7
B.ODT2L/DbO)Ie=MB(HY6WE5[S]1=NC#.S560(8[g&I3GWQ399a&:c(42K03FQXL
1>X#3@[4?1ZH2W)&dX:^/J7C^95MSJ0+>E<CEP+EOVfcD14Vc,)Z,Y>#N-V+05,f
H.T2+X(F.eXLRc[PATOD:3HJ]aBH\K:=D1+7Y1Q=+]]75@?V).LXBO;,GKGZ:E/1
D(&RDF=0#\;9fJBO<dY5SGMJW=YN/KB+Lf:#R]Y+Y7?Q+a7Q;cP<P&\Q>AM.^C+(
N[15#W3,XINgC_OPQR1cL516@.UcH[B5,\5K_:;W^FKXF0bA4T0aggSfM_Y87P(;
O3aU,OK/0?QTP/b)#8M,0fAW<CZUc\)_90MG2Z#Y)4<>beI>6,Rf.K_VaG_+5+A.
&Q>M1cf\gF8Uf5WDffE,7fM6P>G=6FXdd:X)dbLFF,.(<=1aY3TE-c]B21\TSOL[
f;<)AZ<@aJN\Q],Q/;aXeSB0DP/VgEP;1[@2X#,.I+/X0O1H;._(S2A?;_)N#C3/
fc5cHD;+4N-LKXRTI3CHUKK=Ta#.]V9-4F\;YPW_:]A^L>A_3G;ae7M>36aUA]Q8
P&gO_^E[8;1T4M==CSb<5Xb/)O@Z3aF&GZU-E<4W=/@(@NQRUO5^g?g+>K2.[HFJ
--6=VGVF=YJeIS+HF;O=Y3_8aA:4_+E3cTUL0?3eOW^3;0aG]=/fX?:[YYTAT,43
F@L:D)Q#@0PQPg>4;a:GgPYU,cT(?a\dR550gHC&H)5KA;O7JLbFQ@V,0@cE,4ZA
K#W5C^1E0Q4[U#KgT^V_00>J82E+R7#L(Ae=0Y0N_<(+-20aC,dJUV=K&L?0aBYK
:;b,)OWV?.&A9V?B).Q3O>ge;FGE?[E+D25<M0^b:L;GPRZSW(+G_-/4=&7MB@(L
E/R&eXUDH]_>FNbG=[G\[ZFVBc+?DIX2_-@),F[=54=QA=9L52_0VVY-bR9YfC&U
NR3\^,Oa9.(<+V;6)A+]XWH55G6)-&=EFdQ5+-H/@?P>M82f9NbcM+afH;9;;6GN
NVM_FVM1#MO,3)8:&;,.VUXfHATHffJgDK(86N7Sfd+]]/53BL<X;NN0V-@<Bb,(
<P07YG44dP5Fc3V0#@AH[M-f;Fc-fY009S\BR[CF:J,@aP7(a;^K45FH?4gHWZc@
cO1=eS#6Yg_a./H)dS<DUC8[\5_?DHW0MJJ?^e@)<J.&.4O1#.,ZZE.L]2P<<([?
d9VE_EIIWCWW2)]Y?KAFG5)^DBc:12V@U:7F;E=SD?PC=SD3SLM&UBDE65ZJ^P&\
W@^d\:^AgQ]9D_;]<01(dKXNDLa0a#]4N,\4)GJS(-]..+EAcAA\RY&_[d6,V/YK
KMTLb0KT5J4YL5gZ3fULH,a=2HS,46Y;70c(cO41?DC47AU\GaN=A5(]P0Z^&;a6
7G@SXY^]dIS=>478b:f2SJ^K.J:,DG&e_9J_J[07W]-D5UB:Q1DL4(5K9b.+I#E>
eaUW>Ff_\:=BB8=))C3QXa8;O&eZNMSA9b0?U+0cZdcJGcC+WH5=X1ONS^gF^cY[
JU/BbUMWd]H+[).DC:I6>Oe1T<0<Q;XE\->=Q]QRG_K1OfH/=->aN/?51P8H.&#E
2efSQ)b5eM7ce1gX)@gLa4<ZI4]a;=/PcN;cM,b6.dd)]U,J:6]XZfTBC6((1(US
AUT)#B-33:2QE;d_gD[<Cg3KU]CR=,+0SeS)N/]<(&LEJ_1EMDXa@B3@b&PDaF]H
RgeeQ(Q\Z_bVEb&UV0bD,H,cfYQ72ffBJEJ8>?U3A@0GM.6HAe2@TOU7W#Lc7.#:
LHWDD/5#RDGX.?B]P:bAJ-T;(6<8D&KLN<A_</KL)TR<<cBEE2g.(C_f3dHWIX21
&?WTP,CW0ZS/SIU#7DdAL^HgPg/:;T.d[T?#0MY9J)8fYa4CZ78fLSabIV]g5Z_+
]_T;(KE>V1<^2@JJYbBG9YD639[BX]LUXKDO#B-6D8.JIIfM#_/J9.OZde0D-=]6
>K&gdS&IVQ@_I[38?V-]NZ9F^1YLGG?PYDdC<L^b<[IbYIEH=.6?[7I;@7W([)9;
AQ>A@^Jeb?-4FJY9<5BBME720-f>TbI)MP.5O>29)F>KY:BU@AU2QPP)f6a)1@d#
.[3V4[-.XXECV0KT/8,,#&.Z\6_6@2\BL9a^A_36UOW-8bNSd.4#Ud:ACLaQ\.Bf
,EY^OOPJ+#RKK&Cb87agV.Ig4TES\3B4-;eP]DH[@(KDGHEQ?YVc,IcGJU]GBCUU
3&R-]6T0Be?F(+_-@d-28WgeaBVb9cWT:acMfC_;.LKH?.VPSH]Tb56/-F4]UKO<
Z,Q[4@:\T&U1ZGgOEdQLaS[.:(SZe3d_&\fA9_:g#/92L#Q[MZ@9WdK<THB\eNH9
6=G9V/Z8G<D8\3=4Xa9LMZ.^U,R,2H<LA(54B#8g#4cd3^UL-?+0UK<H5(IV7(Cf
R;8AdWJ5R8-_QBKeN5KX1,I\VN\(VG@5-;PC7X5?9WcF_X/?TCJ4.gR;,9\c;6;N
.WJK1b7Y[&-_&CaO;H8eOX>M,0.X+9UV7,S9IF7H9,_)?68K@<YB@0S)4M(5eK<b
IKLb@&)8@/d,_6EX><Na>_4KHERZ=Re=(eBV&8-:1cG2&e0]VJ3gX(]VBV#@L;#L
AP+C]]:/9dCK:eDbZV5Y_&F?f83\R.K<1Xd3Z8V^NK[A6+L/J0JE5/_1;H;VE]AJ
5_,@T-F;W;@CCN43K)_5O.g19aH;U?MSL,Kc?BcF?XRN15N_M<)KC1S&&aaM73-]
5g>\?ZJ/:Z(0(QdO:2(QPe\GL&3bWFTH)[0DZcNZ@cOZKf7caMH.>\egQQR&7(Ke
@F,0:XK]#XKMD9[<I/NB8(826fBZ^>;B9+JeH.FaYKd<-bXR/\=d4.)e=,@5g\)+
LgA_cGCN](M(MQW,-4F>C[,BCD06HFO\DYNa7N0P67)+XBcUc,TFOCVa-45=?L(e
,V[J)eQfU?N()$
`endprotected


`endif
