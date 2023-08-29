
`ifndef GUARD_SVT_APB_MASTER_VMM_SV
`define GUARD_SVT_APB_MASTER_VMM_SV

typedef class svt_apb_master_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an APB Master component.
 */
class svt_apb_master extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** VMM channel instance for transactions to transmit */
  svt_apb_master_transaction_channel xact_chan;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Master components */
  protected svt_apb_master_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_system_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_system_configuration cfg;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance
   * @param cfg required argument used to set (copy data info) cfg.
   */
  extern function new(svt_apb_system_configuration cfg,
                      svt_apb_master_transaction_channel xact_chan = null,
                      vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages input_channe.
   */
  extern protected task consume_from_input_channel();

/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_master_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual protected function void post_input_port_get(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the input channel which is connected
   * to the generator.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_apb_transaction xact);

/** @endcond */

endclass

`protected
.ZGc[dCIYTJMQ.g\0J3X5FU:cH]bUdL-?65d,X53#?6@Sd4ZAb)+,).+^GP6+8.b
_+&0VTJA+INCCUAKV9.;)VJ=6)^WD=&Ge4WOcWd>bV6F89cDX<K\QcNTG:C7)@31
4_1]&(7Gb;JR0L-O.b#Z^&4A=A#(G#FY[bc\9dg1\<<TP0^dA2^]ZTMI@W9(\I[P
N8@1J.IM1704P.4I3dKZ(FKXb5Ad6WQR-8YKJ86aHC(:P:0USH5(8,T@]fL_3-5Q
#:<N-?4e-24UO570SE1cIQg)NTVXT.&ebFRc]/J=_U9-R8:+^KQN^DVd7+;A87=Q
f35\UUHYQT0ROE5c#JRG4[cWQI/:Z0_[.(Q0\#C&A7U@CP.d16^15,/O=\XgN#8K
RRI,_a+&fD./)J00T/]R[,7G\Ec=VUORJC&\4HfRNGINQW1/=5ZeZ/B8FTK^QBO]
W<][?J:dH>GaI-96QG#d08T=Pg;N/a3NbUBHDG(c=1ZfdRK5?A4EK>6f/N:CcA22
1_V:+e1X/0]V,OVVMQODfA7@>>@J#aM]#[-Q?E8&a;#,_f6dZMVgC4UcH+:#.+DL
0T78794UQ5J[(2U02FL.?@3C(#T[FXR82&]fDZKHLL0DF@?,b+H5]VDUO\S15XMf
A9-Lg>9)#_)<Q03YTd?8CP?_SZQ.@&aJ(J51d]2VP9(?RdS]?7=X[<DEHGY\#-2]
CQJC83,&9gfLNed5:G7,LH0G.Qd]+WZF0BS15C29Za#W4]45<0IKWE^M+&c460)F
ZH<ee,Q2JX\L16C4f+Tg?YP5??-PU/Gf-;?c<(fYRKb&4Q3+]Z,#d9cZW<:eKA:/
<S6Z1-]=T@JJ)(BX92G#(I5b-C4aCTX-+)+BAGOR?^\DZO?PQZOTS[@g3].DeVRY
,-gW65.L;7SgR=H\V=DWVI3V)Q.#WP2c5b2>cU7,H>9Q-M<SFcMbK-/GR@WBb&_f
]S^9PQI,)fHD;/+,DOA1OQ<;gI(C;GK9M@(4M3M)E:2C1+aTVLIFXUJa_g6_NOdY
eBAc3@0<G<I2Z39eP9U,6aQ@MU)P9]Z)+8MPe_V^6A-A<V=BRYK0>0NU;9@RT&,.
e.8^KA6=T:PX:.a(=MOB^c&d=YS>,19G(FeJT2FbPW4D8.&BBA?<NYK>_[-TWd_7
X:(V?daOcZ5NRP[0,F_Ba21LQP(IL1P93TbeOP7g#=.\4_&XXM?(.)F7]-\L0.J5
SR8M6CG=+d]#6>JT6IcL@)RS\I_CRgO#4Z_7AKYFXGc31\&#L5[Q4c+bGD])5Qac
O3Z/P^9&3,FW3^f-?BUN^=DPW3NVfeLCe\<MEbF>,EfLZ)-c\2IJ]Y)dTHa(WcKE
YU@DIRLNBHD#6>:IPY(C:NYZa-(<RT^NR;(#VE)DP+PVWgF]&e6@@H.1VL)(a-\=
M:;TJ35S5GdA<M=P\Z]]BHc]BN,(YN>Z#98HXg#;[&QG:bK_e(V/Z[MM>]c+;,\Q
[cV<T&DX2:99,Dg^Q)>MF&.LeM-O)SM\^->+9gD\MS1[-2^/>.N)L8J-dG2Z4U<-W$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
IgR[D6[)?d5GHCFU/M\EBEL+K&S+B->1E0]Y9=-^@72,f<1,7>-f.(a/3EEb^abF
Z7Pg>T\4T(g+HNOY24Db[65P,a,e-6^5AR=RL:+Ed+1]8FKC5HP&X.<YXO)0/KN\
Faa=<e__@H:7F(&T>-1>V7_BOCC?T:C60:&JeaMdN:NL[W(04J36V3Fd=:PQ[1GY
[-U<EU^Z</X?>#S.1F__YI)dDfZ3d#1O\-Kg&-L_T8@_L_)#C?(O?E?d^7:EU(BO
ZDG6f\M&7&,_6Hf-Da<XEaLZRT),-Gf_OZ5O8D@:-)b:]<(8XSQ/K7T1La1+,^?3
B3TGK;_b43F\Z=/c?X+BF]5F,R&F_9IE3Q:YKUGKEA\^PHY2DR&1PXP9Eg]&M4E?
/I\@bb2V<>_1]M\MMU45\BWPH#F39[]>ICTdBC^--S>eWLWI3_>9NFX?X;46UfS\
/GOd39L(=EE302RH<Q&f6V0SK]AY4d6OSZ)Y.gY=K\XaOF_41&5bPD9c4ML1X5Wb
6e>g/66IZeJFF5TA_C)J&#SU4aI]UW85V;0O17G#:e/<==0-=<K1SOFI-/&5d?FZ
b&_T)M.,1X9EN/TcSYGA(JdcWdX/1+,K<N/e1N9E>[M3R#UWPPH0>A-@bc5eY#,^
^]A\AN\=f(>SSF6@P)bgG&?a]:JP9WI7>)&VZVKc+X)6F1^W73SFIB,,ec[DeFVQ
1c254)Ke>^/TP8OW]eV&I:aKU>IXDO&9f43^?88#M:?MESKN]V(3d\;1GZIZFb_O
#&WJKM2&8+<]L,<:,C.=50G1(933+W8\TC&;cMQXXdOT/\131QHTZU6L(/GFBQL9
0+[BH+0[VB)D/a@3P]f:3#W9>-ASX(O2^B)a<8&KPWF)X?_2XcgD_+5-8.[;LZ6_
X,aJS=H@B:F2HL3W8+O>6MEI7=H>X<I1J,FYYFbV#(a,\I@SG\;U56QB72Pbe4eT
N)H3Hd4,IePaeYLG\0-85[G3<DN.d\.>YM+_^JbHg>:5,-@^0RLBE+RgYN]D8+1B
d-XH6bG?XF^71aSDS^<-E<--Ie9LV&-9;Z/<Pce,:(g7?I@[RFO:-NBABccH@bMP
Z48Y=M:(bU)fe]bRE^5=J:>3JE_e367efD5(;1-3QUN..R#;IfFfcKGYS[Q1)+E9
#(59L(P:.V1\NF0N2918WLYI#@Q--G:7THAI-45M9RX<c/BU9>@+Y0S2VIEEZUOA
G,TF43Xd9(<-#G@c-LPM>L;1H>_<]0?PX,3>QS29(V,PO]:60/(&(2Jd42G80>:U
<9ee)4L6R@IC(dPYTg#J(eQIKWNC]TdJ62.^-d_J#5IXPEc<L(]Gaf1@YH^U75<;
S?RGb]ZBI)S&GK6V4,PJ@=\HG,X17\RDMOa11LMJ44=0fFIV=_&>5A7e]e);&5Eb
f.B:4U>f5\cLNa#@=DAU_HG)]XQd_b-JJI]W<F&/M[:R3Vc4HP==\JA)9(9.\^Yf
+JKPC/M<>AeY#:3Q[4g3:+a-J]O6R:e/cZ?AN)89=WQU^72Qf7=018gUQ]YE3;_6
?_CYD3>2BFORbM,XVI&G,&3a->SV[M,HNZ7/@K[<W<?-VVD]]J@_^03_&>N(\,Jg
W7NR&NVe(aSNKZ9LXHS3LX;^&6_@H34YbT,dI,-:;66g6.B>E3FBETB_[3NHR#6Q
S#NJ-?83?EgI=:HYTc.T1,<>_a+NBeSWZC16TO5#;PW>5)^VYgc-K;e2A&S3&>@F
00+<MAd:A^T4d28KI1;?S;bME(Af/0cBJLQ8/<HKPNb6HK66,1e;a=Q=KL2b5a0K
&@0M?WN00gT;W0JG4AA6=aB<01#0QXNBAIUL.RA?Ued;KW]^g^ccT8XW00:3971A
5H.]CI-H)7(&(/>T<:[A-ZZ17a.G>=)H9>&fbR=X;f+2c(>2Ic9V&TCDRVeY0/LR
M0,/3;W&-Yde_d73IS-b@/OgOQJ/+/H(b6+>..LT(CYa+b?,?T@d/Y#I_L9(H8K.
94)WO],H&5(\D_HfJ]/AU9LQ)+4-0N-?@/5,aLD^50#(1LQ.=AE8A3#A,gKe.>7E
+2VZD/AcK:J.#NR[c4+<e^?4?NY_I0aUVQ9,CQ2(V.JM3GS]Q:)X/W6ETYXZR3(a
\,b[#HPIQH_f6D>X^@R4aW(If<eV;==)XPb4XE>Z&;7APKd11JB6V:Q&e(O9OX]f
55f;-=9)>(5YN7=MHB7[0LWgAb(aQcd#ZOSRd4?dLKR96E3Pc[6,XUFF>^:FAVT&
;G36a..ea<61fQ4d(6F+gFCVO=I62.b6^fYA:P#I;b\4IZH^3I-XGBc4:6ULeKQJ
ae=DHWd4BH&;N;I4/,gQ?^bJC:NVH9bPD[O)>baWIO<DfNGIQ6;2GCC4K.17fE_,
0(-KcE?OAGO:fU&IK>5LDW,9-QFAEV94[Yb@QQD679II19N0BJ)Y@,f4Wg=@#]>_
ANUS)4_9CP,T:#P[#7J(5(&32KfH3-U&FQVQ^<F&>5=R<2L8.)][BA2;&6]AQOaC
8LadKK[B;eL)2a\5D6G\Y9g#::0VF33fGb-K?cX9+?-=1#HGS^O/XYaRO31UU?RY
KX=/T7;8<SaXANCaR10BQ;L\BE3Q3X3KYUKDCR1OeL/9.E^I(SZ3[Z<C1#5J4)N\
S5V5^b/FBQ:L.gE+:NY&I77VRb6@G>GfR:)Bf\)f=0(;_Nd+J/B#b?I1bUXL_5f5
8:a2?K4D:/3fI:N[NKZO&IJ.d,c8[\:]W8R^SL\WIf<?-P/<b:?DR=MW.=_CP4SD
W98@2_R7P1@_;PM81CcHeb4aa:e64XMV7#Ld#Q,<P5\):<^=HL8dUN75&5Lb84_/
M+#=]U]JH]B?.T?:Z2.@GZ>W]#fF:V3G17QSc:YR^(DVVe:3e]NXCULLVUH-G8G/
Y5/@I6/0b7Aa)M.@>.Sg-HD#-+#b;)B0J=cP.70H&3Y[D-#=g8/b92bBP_,-FK[d
=XNQBTJ5:G@MOBEDNNQ8aa+FeGg\#Z?6(1AU9a\+\A[C<EN&40+:Y0[\(badF-1g
QK-P1H@(P>a0R[-<_)>ZB7<8_P:J?X6?3<P\Y)L<2G00/54>B(]b(4<aIZedCEJE
\5=B)XQ0_f,(_fUSH&E]K]+CR+Tf@PH+8LSA93I>9,O^&T1fFO,ZYQVYX;:/-aLG
f4&:G(+g7:AJ[XTSGe4F@FU^eGHaFV_<<6J\;KE1B1J.[]O1\>:DSfFUE0Z8;TBD
@e[&1ZK#B-1QT1-f^^RdHAWN-Ve@V_A<,95g2H.,MWN:;,Sc;^ZMU4UN2T7A2F4F
R-O4:H&0<CRIY/TK#F-IK,PWbA908JcAU1=c-Yg531L@-IT\-2)WM=\L[eHTDKLg
X_YVO09fUTPP9EX6a)cPW-1;84cgNJ<TIV?dcBTZ[M8M^CF6\70a@c43+ON@e8;Z
>/N<<#\W7L-Sg(\0H8[a4agdA>^e:H]2dW;BXS6XXUEOWbY;_DQO:5+W8+,.^LZW
=BDQ4HVCeDCa.\(]9<,6UD?/EPA&93d_]7fW/DbAS@DH&EN@fW?L4Af.I#CJWM^@
d0^R9HUeZ=O.g]M=;#>K9XSL2]g..D/R^_a2X5O@&G5>4\?f&g.J[eM5PAXY<.1b
,Z_Wa7Q^VN?H9Y\cOfEE@?26/[>XWHFK3a@GfJAM;cDHZ>4C5c<T-<GC:+d[^a^J
J]9c8U2Zb>X_5;NPcJ.EB^(W:Y[7AbH=f]CN)9IDEV.GWd+?PePf,HSN=)A:L&/&
_J]BIMX99QC88+Fe0:cEHVWQBL3.cO3WL_<a5\]M.-_g(a(&OEM6B82\FI[\c862
_0G1d48a\9(\e+\D4LG6eEKa:LX3\2#eIZI.NP-T9<ST.af>(:H3B#CV7UE;?NBV
O6&g83I/6JJ_J1BF+CQFI9XYY<[)>fASR.D>CC?],BVOS5E4Z\96I<YS77FCQ(Cc
K3\f>eEX26?MQBP8[YF096#b<KeVNXH(@0:9e0_fP&SA^:Y9Y/#:_B-,:Uc>cbVI
(N&)d8eWK/PE]DfH/b=45d7/K)W\PeT?7J5G&E8I4_N_IKIUSI:LW@JC87?57#d&
?9@dD3(YU-1SM?#>Gb&\^OI#=M/TP;&;BRbb[Cb)\LPSTfce/]A=QJ18HVa_@0c9
S@S^aSXD-;a;JYLJ9,><@1.D@ZNW9TYgg5O4_WL;NZCdW-J8STR,H5+=)##>VG=B
]+^J2YS1F:)PAF4]BD-,)//?P:_1g3::ONLb,>6;b1C00(.I>^;eOd0BC5+4X_5\
d/2_(#&FE<V8UZA5Z1cc[1P4WU-1C67+=^XJ0&]6K3Z[)ZSe#D/g_2/,49cL\BGa
)R^M9b@E4XK)C\L-J+AWP/Zc4dM)8,8&;HVQf4Xc[_UH)70aZ-L&>O8(M?d9C=ZP
gd+4)cYXT12X#?AE][X;4ScQ-6[7a:@L58+P1,d1a--/(4aH/J.d>8-IfZ.Gf(A0
&<,#(0WR5-ZA_\OddCH_Sb0/7T/G4V7R)VTWR>:Wg;89eBf)V&9&-cD[0<8.@M[W
W-JLVgE#<IT@[F2X37Pe7);Q(HNXHa=9-gca^KLc\7R]R#UaM#aR@KBfAg(6./-L
/P9(;92cg@L<UGA1)Z2)ZWf^VUX6gZ2,(U9Zb)_(I4K=1eXIW>N(H.UJ_)2?.;2=
O:5//PPA]W>>5bB?32CQ>Jc;4dR91Eb^00&#^\.^S644(@2K)SJ#g4SM4-RI5EN#
)H-^A<<4E4#((1[MfZ6X>0B,8F9@:6LRZ=;L3XMTNHg#AZG+:V7,X:B0;(A(2N6@
-JNXZK\=?T?Q9cHRg>b2cOVDL[J;<<VIHB,T6.RGG[2/IFQB\LdeXcU6R7:g5aCB
_9##g-/&R-4DM/gP?RG8>6J2IP8(.=gAaMc9K=4<3WYMgAg9S.)&C(NQ?TA;;MQ-
B26FE1430_g\f:(A+I\]fNF^CD9AX)SB1?OXc#KURMYZS_L#KAV><-cc1W)K#37H
1Vg^._(fPW+2772Z@8>0LE+(\.V4/6O=aZE?3dAY0WY]\B;V:A(fBMRSIAXWU6@I
9B>/X#+5R(b7#S9.:>.<\3WaPEd,L6LVff[ZR-.:9SNcUDB(TdV8OJe:W.R3UG:5
=g05SPD<26Xe5]cQ4]a#E^MGBg;+R6-9E]P]Z)@O4S__L;S<Gf\D+ILHC7+f4c4&
O:dVR-\N\dag.fX+fM^CYF4c_d]e^7\H]-55WX(E<f@&QX^#UcB5GK@VZBX9>1^0
ZWD;aAGU(LT1WR9J-KE2=YKf^8D.Igb;@KdLeDMVM[K<9&>H3ZgZO->W(CJ):,4\
Y8XNUG9&2S;2RTZV]B,aVD1\Qa.OITDdR9>-/>XdIVBG^aJPJ0\;AW<8(K/bTS^Q
#WU5YRPY_bEYI.5eP[\SdT?O#E1e)]&FAX(@O2T[(e381g)(Zd+g<NC8_U[P<Ea4
8EX.2g74X-P6\AB<0bG/EbJC036,IV7T]3V^+G]Nd8.9=)a1G0XdLV>RHP-b?f\M
WO8S.UQQ^HVWU.d&\F),SLWSf@a=L,g<0-GKb;QB&R<\8RU=[XKCZ>WWg^PeeK\A
YT249[Q;29B+9&?)R.6>\])c\Q6<Y8UY]abFK_9YCE/bV@OL-Z<JVgg1ADWQPT#f
Dg>797QL:?;,aMJ^5/\MC^\YDDDc7&8B=,YIG=.-S\.J#,G\K.?G\Z(Q-\WDJ;9@
26AMK0dO^69>1(SLCV=V:RNL0debBI#0@8O=#T7,I6;aF+Ze;eD]TB\P]6EJX(H]
/MYNgSMI_MAMXSL\Fc/0ccVCM1UJGFDXH7\/^P=AV+E8O^1J0SYRFB+-]0Bb51YJ
#N.U#PZFd\7\(-dA>f9ReFJ+Id,<W7[QH^\/IEYb8NQ?f=Zg6=&4R4)E+-@IKcU+
eJI=#81OG3H5:JeR@7>BJWV/:f8[4\H_/W?<VHb<+^HP;0#H-Y^4d@YOQ]W@f=2&
LaOVL],+R:;^\L&7^f^#[Q\?#S^KE1f)5CNK_eX4]#RWP(Fe49ac\K)735Z9-8RX
4Ege;IMGNK8ZR-J>.5@b?CT9c&YEYAE9f#V9(+FEQ,6;1W=V1AKN5T-AFQPdgLLe
M3DH?JX8QHMFNGK=+K?O09+)fW<NEW?)fH7)J4N)KWfaJF];?SdAUFPBY4&0XA/D
B@4L4EQY1)Kd##X^c84&CX_>d&N@VS0b>(CQL<_AS?ab3Y=0CDV:L\<\OX;/@ZM-
(c,f@&K;QJX2LC6Ug87IZ+E\&-[O;+X-::9.bBV+3Q)&O1X^]b=1\fKD=QU-VBF:
=JK0)KBXZ((-PKEQa7OUL1^[JD>?EE/>9C><W.^.;6g_EOY\f=P^L?V,U,4I;J=H
B98e&DT&YD:GCI079dSI=?/^+T+OD0c>+80-&#PS>]33Ad:,#8LL]?P2b6Q?[5K2
61Q?c#CC-CXVD0K\A+XeK3V3c2Qf5g+Z(CPJd<X.T3^egYEAA+RY#VLL12\C_8#D
TQfXPFdO\A.O486dcP.c.e6AHWAZ3SRbS_<&0>Q([.dZZ1CSM)Za5IC7a17I_RFL
RV[3:[Pc_RKQL6D?;)CT9@CG;#W,37,XPE5Q?ZfR31DXQXcZ+OU,JcDX4\,J[1H-
).VQ7=CZB=P)WUM&R1b90^IOY9gZ7YE.:;1ROgM8BYT9/a\R(,faU6f43W#E8U3e
&XPf0[^NVgef./Tb^\.c1N.WVKg#.4K:J_KITa6V:cKWL.ePI,0//JPI5g#(>f8:
-g:+)A]JGABbN6G[(6?HG#P@b7I178H;(#W9M;:Tddf/H:C]Je@/#aKP(WK9/5@)
:Y(BT-/YBg//XD0[9?A.8\K25XQYdX17M;:F&<@EgVN)]?cAEK&PUAQBVfVX:L7D
MX90fWLQPCKV#IcWN8L16a^#YM;Q?K^VAceaI5YfQe-bQQ4^@TF(N_eV8b36B?L>
He0;F;c.N(;&0NR@4PG4&TgXT]eE/U9TQL)AE.)Y+b6NO/d06O_UKU+[(,U[#1ZK
;HAR/RME1&P;e:<:X42a1/:HK8DOIFJV;dJH^7&+?#-\9bSe3-)VK_/1b7L@-;#d
C;gcgW54C[IId/gYQ_dTGCOf8YXD\EQQ5e4TG#f9JG&J):)6O\V[^4R8&PPP0Q66
7S@?I_Jf^I.LUK+8b-@(8g@^fPP?EA5NZR\\_M1aP78->N_0RQI4O54T53KE==)0
4I]D=Za]c218TIJI1G8J[-/AT/fQcEX4KO1>9WXE.,LJLL:#M9,:O=fA0a2U-;?7
/:S9]<4-9#b(+T<@GcG55Z:\-L\81^6S]b=NRgb.B^(JH$
`endprotected


`endif // GUARD_SVT_APB_MASTER_VMM_SV



