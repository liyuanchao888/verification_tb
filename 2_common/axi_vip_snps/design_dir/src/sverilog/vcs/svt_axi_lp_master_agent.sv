
`ifndef GUARD_SVT_AXI_LP_MASTER_AGENT_SV
`define GUARD_SVT_AXI_LP_MASTER_AGENT_SV

// =============================================================================
/** The master agent encapsulates port monitor. The master agent can be configured 
 * to operate in active mode and passive mode. Currently only supported in passive mode. 
 * The master agent is configured using port configuration
 * #svt_axi_lp_port_configuration, which is available in the system configuration
 * #svt_axi_system_configuration. The port configuration should be provided to
 * the master agent in the build phase of the test. After the AXI low power 
 * handshake is complete on the master, the completed sequence item is provided
 * to the analysis port of port monitor, which can be used by the testbench.
 */
class svt_axi_lp_master_agent extends svt_agent;

  
  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_axi_lp_if svt_axi_lp_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AXI LP Master virtual interface */
  svt_axi_lp_vif vif;

  /** AXI LP Monitor */
  svt_axi_lp_port_monitor monitor; 

  /** @cond PRIVATE */
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
  //protected svt_axi_lp_port_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this transactor. */
  local svt_axi_lp_port_configuration cfg; 

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_lp_master_agent)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
  extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components if configured as an
   * active component.
   * Costructs the #monitor component if configured as active or passive component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer TLM ports if configured as a UVM_ACTIVE
   * component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Extract Phase
   * Close out the XML file if it is enabled
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
`endif

  extern function void reset_is_running();

//vcs_lic_vip_protect
  `protected
T2<#XB9dED;S.C3d/+;TF[;SW047^d4cMZD(DZ0E@41cU/G\-ZO<&(fU-V)g3B\:
O&<QT=cJ20>:UNT)_b+.3W>9PLcQ]fPKA@B4OFcG[Q,(C7/7(IN=R4(dde3E:V^[
HET&H.gB))7-_:@)D5631J5]5O31ZbT_256D6+O_>@8:]O<X-XOcaDP1e]J_W>5X
F0+75D;\EMBO/?7I]L4d/U;N/1_]8@9W.+fRa^&RRK?@Y-9S1D0.(D6DKa;=1@G6
/2X1W2/@[A8gS=?c)K&[F&V0PC0#H&LLbETKV&d28SMFM6S.2aK.(b=37XU6/KP<
:>HM#f=P\B/cAL/,5Bc,IEMQGRFY]2J3fMSXJHRE^:9>a21F#@dER4\DAV@;e.gf
,^J4#eC16K[T06M:YC,)._&//>PK^H(b:W<+FLL/Ta5/CgJ?SCALC,UZb;5WBAD+
]N#J[Wd=997AD6OLR[J1>E&/5$
`endprotected



endclass

`protected
5CCU[\A?e=4-,6D6RRO/b@@;R@F^9c8\JOe]WN>P>#9S6J1D]P]G&)2La9\3Y@4K
\@J2MI?:=MHP=WCU&><c95TE2F3>5OUFJa&QT;FZg/SZScg2K3.T&ALK?N7_@VR&
/(/->dSESb:KB(DVD2X850;A@,2OUg,93ed4^DJ3F[:,08dV_eb0[QO8b,.#MOcH
OZR]d>TPJ<#.#.SDa?\KgXPRCKZDefa]S=-9U4]C(;,#NMMV[3G?;_P>1DN:@O[d
@2DHI.3JH]=T@]LYM+\gVZ7M^B2,^AGV2:T=@__R3E#BP=@XC);+Wd)7/P>Bgd:P
(Y6ADbbH=/)^)J92TUAH\EQ_18f0HaV>1)+GL:NP,;MA3@MW-]]TKDAVCG,M<+S@
S]@<:M76Xef6]SP^-W2dT>15#Q<bK[L4UV=[=H+gJLg+g7/;=H86[GE_[L@7ZCg(
Y1_SX?NGJXB3Eg2=UAOZT]158$
`endprotected


//vcs_lic_vip_protect
  `protected
Y)d]&Na;C)#4>2SJ4[Jeg@_Q/^_M9edV2J5I^SMUc62T83E]O,CI4(8Fb4+(M0C#
Ng##Y@[CFf3.e;7\f75Z=A2D7_OVR/ZdP><XN9PQDgIOT.&UQ0_NM48ORc#\(>Ba
J\gO[:OEecY,_AVOU+I,ACEM:3f(I_7W/\PS>>LP<DAd/G7D;,>HZ,7=]J/)5>;6
.=I^W@XHM&.W.>Xcg7-T_^bId4OWU4e^.2@SdK2Y6c0<,-a(0>[7cVM1e3H-ET;;
SOCPg&_^],aYA_3<2\5_XNC>S^a-@G^BP^/.EN9UZCB:1^H],a\8DB/a2Nf<C?@>
<fO[Vf:<N3IK,[.]fX^H9>U2<L2W]+O4GXf/dY:SAEI+1WY9SN_:[KV5^O-PUaFO
F^bXC)8Nd(W633TbMJEAXe<c#?R:_JBJBOQf;Z3:.QQ;EPDJ;.T_g]/JPBD(4OQ(
UN8QJNabRA#9+=3[:3.W@231-J190WK__S;5ZKU#8LG8gIVJ7,0;)NK+].0cW=D<
=cg:DedX^].HT((RL255fA_VGd.B8AIf\?3X79G[RR9G9)BMSL#_@@bT)4d4)_Q=
RL8\faVYeSRbC2Uac8b@1e\/gRWJXT.dLG]CL_64BQ=/?Ua=9DH#:(c#_.4P/^H&
8:CR(R4&4@F-^L1eR;:K522W@O&a=F3CT.-Kab-9f17XD4B0?@N7?J1MU<#SEgX;
aK]>HgI_C1<?6bb&B-6;@aMG2:g7?O&]#7TGJZY#L7/+2;RTT?6LdQ]gacWJ/cSQ
0:/)UVB?)VG5gA(&e]BH8-1ZYJ==eOVSJAE2dGb0.afK4e9<(WYKJE?V5K#dY@06
-7@@;O1DZbKL,,,Y1@8(@/JU+1>8PDGVDZ\C9/\HeE#C=V\UB&6_L:FbA&CD#6AK
Z<4PP7MY(3Tg\SOZ:,0=@V(&;;0P]a^.NGE=5GXLA9[N\)WOE4YTK.YfT9R3>+KH
0I>Be6[>2,-]&^a;]&JdS,,K_g5]60M@Ca?@]QTO-Se[5P,UZ&8#NCf.[;95KHW=
,VPR5YE_VC.L>[5O8I_<RAUPgTN<NL+c=0D]7e,NC[d5@Gc9DO3)OHOL-e]GeW9W
e>/3K1IO_VP:c;@.,Z]fM-aL-eITQM^J+A.EA+c<agA=UY_@^K0PI<D^GfbO-<UF
KOc^SK)I1W\ba/71\EeJR=Q_b;U^>+0OVP&V_X;8ELBeE<^OU8gFILN/8,eO-)A#
9^+f@5J84(DaPLc_XPcIS9K;J9CfH>]Uc6RTWbWK+=d+/760S#?6^BFE,O6Uf;gV
[D69<&H8^(F&KZWY]0.I;d6\CEQ+f?]&IQS&/X];&K:>SCB^X?SDbf^c\9,JCGC[
&E<@R33\Ga7220=HNFG#)Q<eXX(73GE2R^^b>^#N3N6=IH)K__O]&07<6M=2W(>Y
IXUN=cXOF&HPbBN);>,d]DaU]AbG,0b.1P.9Ba1^++GXcc4==9BRJB]Q]2@CLAWa
;>V^,cVW,@XdNJH66LSS>/IO>@:gAQY>F]N:&)+eIHgEM@XM<?&]/IfLbE+3?[Uf
/(/W1-@I5NcK[8E1N6_e=+NE#+1dDUGWWZKN(QTGWbb-7a_Mf)U75_0]W61&FE@I
)):8fTgM]L^b]\_<YfHSKg<0Z;-I9.-Ic95VII21(<c&IEg\T/3XEL\3SWQL>3d_
TC\J(RP^.c?OP7]]K@76>-/f6VR4C/a:L947F?>MBg;,I?PC_TPcZ2\R\GB1,K/=
=7e:BV?^(a\0YTC6CHKD?Q3E/F9A)/1KB7N34F9]C;Ze1EIPdA@T=VCD2]d&;;,[
:+^\]LP&TPM^gdV>U&P0YOJ,V>900cWT?GXO0ZS3J<&XQ);N/><TCf_Z.ZT&<)4V
(3E7;O-6(Z9Vg5c3EL--=ZR;GL2P4UfX/H2f?#HfO-I7]V5F:B;1?b]IS=JUIPV3
(S1ecRD/IL:aQMMW<UMFAdKX<c_eQ@R@717_#Q#g+P@.PML2XOa1Q&e=MfE<D9<a
@D5H:ERKJIIS.I8UW<J=.6,N:GU90<f<Ic5X&Y\6O)];X<6,0F^+fS[>+3\=YI5W
E>NU\4bUYWP@.\\=\6=fI(+?T(G#FQ,13W\//XeU[/4GCg)@-<M8-AJ4Xd#4SLE.
(:,e61>KW6g5[,[1\BeXBE9;E?g-8X?b#(\;IX@M[#OA#]+1F6@P2ab+U/f@L-#J
#>eb6HI6PJ_<+gGKbLSf7G]CQ(<U/YYB[9Z:S<Z+eG1F-4^;?K#RUNcZ0)8Pd+Sc
1_)6-)1M2e:,1FaT.JB@ND>.eD6&c<6JeS13&(HGM38V3Y7IKa9^,JPBWM-T\IR9
@4B1L?cabb9P(=1_JdaQNCLY,5RIA4b)[#bM.bHcc0H<+>LUH;D&WgV-2a_b9+We
8VMTDFSAXI-@G\-(5@KfWEF=HO89A\E-20[TW:;<BPZBQ#f_)Z9YR),W=?-V;K@T
F:=d,c@CO6<45<D2:J>abTgc2a^\Kg(a^464A4H4\XUCd4@[:L^e&,_-DOT>3)TZ
IXcec-5EAEcc[0X1;5_K?#P=C&W488J]CJ)c>PD)R[M8:&4RTXJ?1gWE#:-.Ub>-
3BAZ8fQXH,>^]_&86P?I2&5MWJRL+81D1+@/[+Xd8MDcdbY/HS,@d>P9U(69gGbP
aEJ7&LM:W;#PYY6Y>0JS1OfG\?80gJ#?Z[-V^+<>_31(0@/2T8We,gCWH:&CJ12D
NYWPcIT63KIXVe>@e)P,),Me]>_bW.,R]LLDQ(Y,aOeec8f1H8-AN[QP(FHFF;aN
GS;V=1XAY\1Tf2DQ7:_#1a))cd<?Ic#XJV4O2fAR5)=:3<5\TRb&;8N<G<G,b(HY
?c1UJ:eA[IG7((<@SBC3>INWP&?\a,_bc-,02429JTMY5)]Lf,T>;<_gIWK>,FgN
18+AG\##d@De?Vaec05H^@NI1-[&-)N2YdL,1YMLNUI;V&,Ja#9Q4fT0bCOMM?PB
,.H^g1e#8C=SM)C7,,63cc)gP.X[&?]CEN:5FFP7TCS6BdLX7c:gefa3b7;N?HeG
)C4L3.MYNYbMQOO)=b0ST[06^SGC28QeD6.\cEFd@C3M5,NLWBY;J8YXCb]((0;&
DHK3dLJPN,^T;.N?/YFSA_]^S(9VVBHA81B5NO\JUT]1bGC+1Z)[7UN(;R&1S@>3
[DWgfC]ff1e#BTTK(K\3Geg^23>8;/c30>RK/?MT@fTU@XKVH-Sg?QHM[@/&R1DE
_^6KE62ef+MOI0XL.RQRZgZCL?]2a1LV;_ePHA#dX??@:eJE?4:DdY37dP8gX84;
AR60(7d;93SG\H:@#QK2dcU5:JbREd)9U/Y?E_e\dN3-<^=N/WB,a/IbS(#bU+Z-
P(5.9.ZLf]8F<e#ZP:]NZa5VGd4V&>:@g;;bgH2@W9KgXgXOT:;Z1#cS,)A=KF;.
92ZW+fSfT?V)J>K<8[P4RZ&Q5>03<CPM(?EXc-;FfDgd0WUPE4fVN4SZYg8;1XF7
\+_U^\AR1P8CW<Y\M9f6;4a4)e4?)b#BE1eY;O4d_ET5AU#/II=CZKO_7bg-[RF(
RTJG?,Db?\YR3>CCA0C/4HX-aC3O+VO?fZ/e3e.ZZeK@,>5>X_C=FLU,AJC.-:-)
WS8JGFD_].9NTD93S-RCV)PEICDLJOf[K\6f>WG=TX(R?e\(\87D#JcH_d80-f/E
8W_&<07H0]47OBAab,FS=8>S>R);[WKXIJ]8)aDdR0-g28MWI,AgWdGQgA(S--GM
J,@V>RU0+fP(0SFgS<@:e;GBVJNK,f&1I\\5D-KPCb=QTgOBeRFa2+^aW(L=,WYb
6XIRKMd&VfRXH)??VSSPeLUP-KL[XHJA+Y0(gVK=;fZ.#Hee/JXX)c6W325]D,)F
<dUMBa.fB99RU_+aK0U7IH]dVc+gWGgGG6+dXeC\<7AX0L?NKXDHFT(RBB=GL#9Z
)gcR#4147S2;JC>-/IN+=SP^<TXZE2Y?EY=9@BLR&U0#_Q)P<DGeI_B6;(c[1E40
,WP;;[]G+)_^@dc58#R7JMA-P6UCR,+O\#7/<./K4g#KI^GNaTfZM&5;@eg1dcM9
bPeJBP.gL__HTKe0[;aBCe34<9=I4)2QR[U=TOYZO@fA\XRJ/>fHKc;;O,f-G6XE
_7MfM\M4?g(bSX)DR/NG?2EYS^QNcDSCL;),(RP_RVR7&^A:Q@J=TD3;F(@[ES,c
1/Y4G;-b-),046BQ5[6g39OWdPb<1b3MYfa-7b/F6WGb(?<^UI,:IG0+<[9Z9N<S
DO1U:5>=^:@4@)XZfb@FY)EN>.M(HYb3913BP]YCc?2A#)eFS]4OOC;R]=aD]a?I
Fdf9+<HC04KR&;ZZJ.1#25EE5+U4L[E1Y@?;2L@5AHWd;eW\/Yc_@dFXY(+#]S>Z
;4>5/2Q28OU+G+0<g9PERda43G?:^FfWX8(F&7cL_e(a[aGb\^]Q[\-70;_-HO?<
/YJBaMXI17)Y,a[G=26K0X]Y99L,2:@(WD(.J,&3AT>M3efM+^VAQP.bTNU^Ua#_
9N[C14TI=[NU1+0@MFJ7G:#X+^]>LA^&caI:8P95Y?bNG43[5X<E?Zd>aWK/K(.Y
?[+/HI3(SBc3,OE_@eH752_90&>TIE2@H==[1FO#7X0d&F&O\+@3<gBDda?)]R#>
BJ1[U-/O:d<#&A[dN7g#[<WQC0Wgc;GVFJ\JK>BZH,]T]@A0_LU9MMC.R&L6?a7X
MAD.;T.-G[]55>&T&@)5;<G>(^5RUGUBg^Y9:6].cfVQDbOUR:09Wf-Z;K3f+c>V
T9>\8X4@JD^&&N.<>XSC@-V\2(G8X.Za.RWJBA>GG=?f&[78\>2ZDKcOHI)fM_J(
&a:=WG/^G#6Nf5XN,<d9_Z;&\cT:L9PDJV#WYZ?RaG=#+=FP3cEQ&3KG,Q6.NE0P
&8+Ga1Sb_7.eT[eZCNc^C?JQD#d7V,)H5-Y:H#R3E5dW8>7H1]B(C.<+/5-^XK2M
GH>0?DWYU9Md(S&UB4^__g#2gH[<6^1_P9_5<G8L=[^bGaQE_00cIRd=017?-YH]
K-YQL,0-)?eNXd5CBFC/VT@4B56S_+JO>9:D[Ne-.4YYZ/aFZUB2_&7>R<S9\H:>
g(cL)];+Eb7\aFg5AceJXL]cccL@D[+(OH/=99_b)_/eF+@.I;;?4&N=WM\<TIU=
9XNNe-LdN06NU.N7FYLR=4HOZ3N(LEc,+6dE[HY@dI#C]@Dd\b=<?f])\8SdTP19
A1:AT.+2H<IC_DN&S_.T5b61[JKcJK0&Z33<e&cS8EKAP1:K,_;<DIA>[Y?/E9@9
TA5J<[GQL5PcZ\dMc7CRA,?+9#4[)b>_5XgKRCc7Y9=aAGd=PRERL/f8KRO.AB4>
NA/#JLBL8P1_\cd\=^PQZQ=IC/6JFM+:/)#I:/CRZ?;VcY/:C&Z,.]4_CTE/&LJ5
^@\X/\TBJ/YMg//Ie<a[JFFO?LEUG\ID/AY)QMFY@X9V0DVaFUW=T[Y1T?1/Y_PW
g27[gE^fASGU2A1@Mc(Ie[(@&Vad.LW/Q:9MB.bOO;GQYN_AaI?5LMCT8VAA6^<9
95L@S#?e3DD/KeXMKa11=Y,@Y.8_-cg5@b.J[#W;Y30X^>fW4VQW_c\VfWW1Q-:B
IER@D,KL?\A3,[=7##ad?dB5W-;VgCBWRdYaM_V-D@)+FZXPDJL>BE_A\0N<3-1F
&+IefF@#F7AJ^8VYf(&f7)&5>T0MUA0[V@g-_9@4?bR-AXaW2#CY-)TEbLL>XFVC
b/e]3J,33F#g9K@82-O9[A-KKAY4b>G]E0+G^/#+IP9=cAeWB-V1.Ha#;+S)dN(g
f(BOF<AE9e-H@>BI1F)JcL=Mg)03(HDM>BROO/gTVgW+SQM6H.K#c7(C3SCL[S4V
Vd]e3J\(3HN/JN8AK_5g3WSNf(=TIY\cIQXdD85/dNL:DX<fg2A254VOc0D5Y4S0
)_>2=)e]XV,I=Q,[(UP&RRI3>W9)FZ-XK)#7_f7GfSW-e^G/?M-JF),\R;:?IgU&
U8@XOHX2,[P)D99J(.Y@e@0^I_9/R<eY3eWdTge_4e1=+b\;-FOSJKgaPL6(?O5F
#=2<4(;.+G>9Y=<5EA7YJQ^/Y,KG#c_-5Ue70&1.3;XSY#;2Yf6Y^GN>-_CeY(GZ
e0PTT:?IBA,gU^K.5_R;+R2S+.;dYXZ.+<^[\ANGaQ@3W0DVgaVO4>]NX/R_VDON
7g?F,:SV,)GQ^0BKb?230Ne_0T3J\YKd#PT../LGRD?09EC&gFNA;cbd8Y^=;ORB
K_<#QW]<CQe8V.@9:G(Ad9RCSJLF#&F;P1K_7-34IU\=KXf)T#gSWd=AU2+B6D,S
TN:30a#X3O/,+D?4WRI4WLU.?@Z<Kb;5UEG6<K(AY+2Rd_0R>@^X[89]MB3^YUD.
;UVG6>CG=f3e;QF:8EN?O4BP#d3NbWMT&;NJF4FS,W=ESN6F4TO,7-&W-2A?^e/#
N[_<7eaAZcF(2)eRUFf/]?D.[0+^dHM^?<9LJ9b3:XM1<YQ=3.,c2.T)JB<N.-?V
b>2bdOUXVH?U@TB;:S\2/H;+]IX^<]&UCBfbMPAVL0L_43UT><5+LU.)Db40=K84
=LJ&FJ:0H(AF>V#VRBEg-,RX6ARNLY0AN<0Y?@_)eJ2_NHE?e[DW;ORQN,:-_,K7
9ESZV-J<#6>B:6BSOG,9D@0BfI]CLPI\2b;KX]O[GDA_3;&R.fTP@-D7T2f-Me?C
>39[f;-PUg/dD41FPJF5E.cX8439GW&(3S52?+\1R^_F?Y<FP7Y;c)CGB]1H^+aE
@cdD>gQU4V;d@dQ22GUJW26U^TIMbP&1[=EN9#N_SReMKg3+OED4]WEFaFYMYGO:
#D+Z=981-beO,2ZYgDcBd1.IU,8)#7dO(aH;ZaMe)DMP)Qb)B_904>7YR=S\<)8[
NGY-IRKMQ>AU^-&2;&?J,ITcG2MUg1H<./XgXa&;\Yd[26KeKV&Y./]R:;G]MJIV
e9\f^bKI.)R6Eb7a21DVd8CRXR)#TD-9_g>HS#D9d2,\:1O^NM<6DC=__;,610^L
Y.]GGJ<N,@E)ZP5FH1\EMCVN;KUf7U\0c><XBX+:F;&],FWe)D22<F3:dD:<O=g:
Q295?eNKP4(QKOCUV9#D9=^^4H##/g;Bc8?BUVN>/Q4_U&Y8V_#d#66K6IATbS5.
VU>M\Ma(K+@H>F#DSNQY7U;@Ub;E[e(T&@1FWCV5Z9cD&fAKOLFfV1R<Y<\g@@Cf
YB_=19b9](Z?Q>C4)NBDCMcfOJ4A>LeI/?L1_S+.OT<MD[BZ(OREA@HXfMZ:0e(C
Ve[-b-?6g4fd=A1U/<P>[2>DdH?Jf_9\]K(K,eZYEQ(<-):cS9EbgIGICg)CESf;
B0ScY#W-\/QSBP>?aS\E\Yb,44+V@(G)1W-?;JGTa5SWCVH3==<G2PK/\@\IKQ^Y
-?VHPB#\(L,Te+771]JUgOd@8W<=X9+WF7Q\PO7XT9XFSBN_[54[?PdHVXJ4WZ:c
MWTd_B=bW=e13TK_SB1[WKX]\U,1\HUC=bgE@EBVE#.a^B\HTJfZOd<=)EeF^<E/
R[V8:BF4XOX2DJQ@J\JbCQXce^V2I9&E?_Qe/?[=T[GI1=a+G>4>c8&?[N&8PDB=
cJdATYSMQ#7;29@PP>F.4-A.@KQg+GdII4R#4gSO]UV&ce-RG(d\81EH;>f?F#(6
(TNPbL;:5C5;S=gaWg-8+MBY\X+WEfH>)#ce4CccH(IVbg#&Fcb:_eeZY77;6V#^
Q;HdAgX-bJ<R,Wb^bYT\:I6gdHS((\_=)<_M,VD)UCdRWEG]0X:QcQ]G_BP_g108
#SX.,0Od[.S[^VIAU<Pef>2KfYT9EN7aUA:F[cD7_GC?Y(\K<Aa>EXd3]P#21T@(
Yac_^?BD.\KQCU&)0O##W(-^ITJ.bVR:>336I7Q2@0c+fZ8UH^RTKGf;=ZUO[L[L
e?F@;<KZ41^LZQdYDfBGG)-aId2J9CVSRXC2G__SEBC.I+\B#N22?a.U+#CY]gZ]
&Md7U5]d6ST;<?>NA7=B[4@L\[JUfRE#-PN^BZ;;PD]eW^CVL5CU#N]b7RB-B+4&
8J:#U41IW#U<6FUac\VQ<[@4D(H6?4a7#Q=Kg>=/bKL(GCVL\F41g3>ZTRX-9IQ@
8g#L?Td+D/3PgUN684L+1Q><BOX]5MTL/\-MU#;VA@A4_ddI7W2#>d=(g&9+E<3a
K[TWGU<]-3I>,(&L-#5,O19dQB=d>P7F?Y+SYA^H\Y,C?M:VS:XZbcSJ1Se+eC5&
IT:-_5CMC//Yd7GRaK[#R0J@&Y238Qg\02,I0.Dg82gZ)7[JI5PV,N6_.?_@Y3@1
<WGV11ER\>WeLb5aX=HY<3U.I^ZU6fKGR[69Z0P,f5NG6)Y;A9O):UA3(RaH8CDV
1VTXV(,7I8ZPa++UBg8G&+[Q,4IWb);,AEaA<B4f5gA9#CH@];F7Y+gC_CU(I3@g
IfE>OIb?ZRG8ZOd)9^W2:a/-,dHGI;#=?82AOG=8GWJ472<SD[\<P.g<\7C]fIdQ
[3(bPZ\Af#YDB2X_U<D=M/6WZDB;3^f\5#RD=E=>;9T=6d1[QX;Xf:X#f-\BI.?5
>W#PG3:\Z/bP?JQ&G7Ma6RAE0I;P;PCLcF6db3aaBB<(C0c#]fZLQcFX]S2C5cS2
K0X>eQRX?:E,AB23FgMBQHTA[-.:Y/G?IfQf.LK_SVeTATa-O(H\5;I&LQ+9XCe5
X\?0N-M428M0gKLT13_5@S<\YKdRA+^,<f[)[,[WY<:0X[b9#P:BDec\A<+C]?_O
)5,-QKM;aJ[aNNJJ=)QQXOeH-P\gbNY#g]DCC.C#@>5(8:PF-Vf-f_e9CYX#U/3=
E,.2XA>+]FbXcg^QL+6EgDGEa^Sa_YK;RXSa\4IY.86IQXDcOCb3<:6gfPZG\Y&0
F_H\0,e(Ud:B2?=/E87E83[eCUcfSD=_b_(I,H^5EG?AL>@;_1>QQUEQG1UG])U>
F8HeU[YV0SgOD1bWZM(>K?EUYdDK:[[3JfC8FaL-.D[/^Q0^#M9K4a.#c0&IQ5KA
KV\3TC.;#T&#9:;g3-C#^8@&=RR?c3J9^V@O@cC,K^NF_7=T3)]MX[1+R?KZO/WA
YeS8ZE#WV2--cP,1K)I0BX;:8A/b)df2F=XLNFe0C2ZLF7-9IcE6U^HO]1fZ&K[K
bR7aX2C+T+2=VJ+YZW4&X26-V2=0NXB)6AU7@5_B]L\GPDGE(gO7<cQ=dc6aNA8W
T(IYZZGG-<6KM5D8eA/((2YEPJ+3,(a37?M:aM,g,6<CRN3e>_CBbX)XO\6+\FIg
fgH;G833d<>C^8IM<CSfeaGX(N&dbI>W<]A8ZM)B3EE2V3&:Y/;S_5;SD2AT<M52
<OC_f>A>Y\(DJ?0I/\Rf19)CE7b-RXW/TXa@@Q32V8GA52N,UNP>aGcOJ6=BUCH9
dEF/>5Le?9?5/I0aC62P=JR480&EeVAN(C-aQ)T&9<UXgWX3a=1a\9&Jc(B+?TVc
\A/Ube1^bNIC^)2A^S?d/?aPVE=XNM7;]NZVQ-]]dU5.^,7HDbD<-(f)N/KKbe#W
L4I\H402eCfI46?4,AOc][[F6PcWVAGXT-T?AWCUD?c?2I,\NT<f86SE\RHPb;L9
0IFFI\IOCIB8ea0O/;R#U6\1T>+>]0RW3[Q8]LfdVQ);@.P)]5<Lf-@;;(+<6CVX
B[+4WE#aAH^HNUSV1g_<eDTUP=</c+P>PAIJXH2W<N;CXS91-Y\b^8_CD[Jc(0BF
E78c3>d-L;HNgPB9VNaYL\N#@CgJAc>54c\eH?F7[UG/aBEQNL_#9X)d?TBEBA_c
>L,.5K5I?#R9<fAB[1]XC\FD(f0gbU]?gH0;a-GNDP63IQ21BQRNN+?NeA=?N#:-
(YIB.HfOL>KSSX+@2:OP?GZB7Ub#6434?\J_<[^Y)E^+eV-Lg3:FT?eA@N]Y=P88
bJ+VYQ>U-<46ULM^E^.A,38]\X:@BaM)O^@7CeN0dQ-0+53;V;)6_YG2.JS)2L@A
RJ6#A,G3,V[eF&]KbTLe>([0O2g?RZEMQ:0LNNe:G>F6I<AT3+19b-NSE<_7OcZ2
;LTa+)9K=d[ZSJ3^M(:KK3c:.6:fJXQ4UF@-YSA&#OV#0e>+-ZC,]bM6LFOO.RGE
OK#NTXd_,^KfCLLO7TN]d3XHUcZ,Ga[VeDJ#c-HDKRBLcT#]/)8M;c;?<c7IR@5b
N.H&/^FV:4N26GaT;8F1U8R3\PD+NfG4-^T:_UdP+bOEa;6XbKVS(de[7EgS0BSd
Vb[3=PZT2#Fa]W31FC33?[NIdf\B#@dWGQ/+W+HKM9KLHI[CUC0dGG]=2L3R]PKQ
T-.Z6e<X(fD;Z,f7JZ\XO,NI8$
`endprotected


`endif // GUARD_SVT_AXI_LP_MASTER_AGENT_SV
