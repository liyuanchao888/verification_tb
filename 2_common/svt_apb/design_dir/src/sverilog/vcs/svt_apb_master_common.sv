
`ifndef GUARD_SVT_APB_MASTER_COMMON_SV
`define GUARD_SVT_APB_MASTER_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_master_monitor;
`ifdef SVT_VMM_TECHNOLOGY
typedef class svt_apb_master_group;
`else
typedef class svt_apb_master_agent;
`endif

class svt_apb_master_common#(type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
                             type DEBUG_MP = virtual svt_apb_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_master_monitor master_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Monitor VIP modport */
  protected MONITOR_MP monitor_mp;

  /** Debug VIP modport */
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_system_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_master_transaction active_xact;
/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when master has driven the valid signal on the port interface.
   * The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when master has completed transaction i.e. for WRITE 
   * transaction this events triggers once master receives the write response and 
   * for READ transaction  this event triggers when master has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

/** @endcond */

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_apb_system_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
 
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /**
   * Creates the transaction inactivity timer
   */
  extern virtual function svt_timer create_xact_inactivity_timer();
 
 
  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);


  /** Tracks pready timeout */
   extern virtual task  track_pready_timeout(svt_apb_master_transaction active_xact);

  /** Executes signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot,
                                                  int                                      slave_id  
                                                );
  
  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
MV\:gdegMTd,7IcagWD?K;1]b2D2;F9_WD(.7f8^SIE8+5c5,?6^/)M]7B<9=XOB
P+HF;4>1ZMVHJ/b>34-_37fR>7?aaCDE)BFO6#I.Fd.EQ>@N\5Yfa0fWSO)W\a^B
_27K^D_9TD^CFBI1F_2::RNM]>-G,0V:LKRO-N#dg<c)SKa;fcd2ZUU1d?+\)\((
?fCg9.8/L.\RA=4-A?@A_#./&1-DY)Rb+EF^2?WKJ&=7-L037ERB?(L;6]Dda8>7
^1TAAN^>AF_PcDQ];O;JD7a_5.8J@53.Q^SO@_[(YEL8[WGNVVTFHf<MfgNIfR^^
KL=HBL8KCcaZBDU[N<?]B,L\RYKU\7B6]ZE:Z:2T()&-/]7EHE6:E30&=4=d?KQW
2-a)>S.I([1[Q&,N#8&X>1cX,Y?[#c;@V6I.<gC.Tc?6)OU@I,:Fgc^ZMDJ_11?3
I;(A>#RZ_4AQ3WK&4b)BF0?\O\NS)0a=gag9+C/@C)_]g6Za:/48R-FN:<+C[bY,
P1?aD9,_(_-JIK-5OXH]c^/ARGNMYE]T?CX_-IcUb(&#aU=W3-7.@Xb.IfWDK22W
+:H5POTZC8J)0K:M2L^Df96L(17]:+^?fe+8^2-TM_6\;IJGf3.7\(-?@MR2b>YK
1/_+Vc0]gHCM?D<M^YGU[eW.OgG=f>4<NL6U-JZ\7555:DQX-J7@V.:39218Ddc>
f.#1#M83EZ/EQaeXZFGa0P2<;8N0^:.RZ#1L[a&&fW<3E[L3D&BYXRa-P?+V&^66
K>C6M[^T;ON?[SKM9X3QVfLBeD@\W]Oa5=(RM?OGdge7;UU,If(c#P=eDZ?)3ZcU
2IadBU3P[8=?-$
`endprotected


//vcs_lic_vip_protect
  `protected
e]+eM>SQK+J.4VO>QL1?Rd:47AV80;6^(0O3;A?YRZ=bD69/OUFc3()&31L3]FIE
Y/XeC.c-c6bc:,3G88QMJC?BT^F,BdZ1f26D)4ad+@d^<45:Q_7M24X);1cG4(9N
-C^FR))fW@MF1gZ39Z0/?2,g#[=KXDVd8DZ1_f:Wd&[/.Ib>7,gA-Q#@QcCX:TMF
(MF<H2B-]gZ_-dG?6Z7>QaPd/H72AU,f[^^7L;P8V@@UZ7-QAc;UBEg5@^@AHDAN
WAMH/_MI/F9&>BIV7>>d/ePFHWX/5NGB0)PO]PLe;c<#G22c:]2HZ7f#@HRK.]Ug
Ob2ZeI=LP_@GgGUT+]eU2&RQ\&bDEcCC+E5;3\,>KJ<:KG+a=c&8BF:067g2;&7N
#416FVOLJ>N>27dRJ-g[cPP.K8VE:7Igd+@5\B[_]B,Yc445H_dd+aF\3aRWAgYV
../,6?K91aQc0B@:>O</3OP<9&D=D@9.,O#b=G2#1U16UZ1Y.AA/WbX2LHg;cGKY
+abMQ8#\P,FV;.)F<NMa:8MKAg.g,6#_X0YaS>JbdD6?B=&#U5SX3dPfPRK6]44,
4O&>0:bCA3+=B;-)&9<1S9:<UE]SOUD78=c>?ZK68.E,?fA4K:K_86G?\Y<QNP)R
VVgE39G.59JH2PYWLIMePPK@6dJ9D?1R-(UJ8KRL>L0^3e)3TEgF[/PS[Q.CQ7:b
.A[78\(]a+&^>-C\gO?a83FGQW:6@gPR<^YfEQ?@Y^6^8OC<ICXgC#H5Rd7<_bd^
Cfe(bHW=Z/O-WaKY<IEM7O_f_248.g8JNH]Y0P1dQWF90;LOQDbA,Y&NM0<XX;Yg
<cPdCRA3X#IGOR^g[3E5,M15.^5L5Y3-::d?7OT3:R5WC&QW:)\X9/bLF(ZAPbAW
^MP#8?3;Jc7?67c2JHZ\3QbHMH#:4473W<3@bgcgT]a@73(:Q:4X=:_Y-1>fD,=]
I@<&d>C)G?TLEYKDI&ScJL64gSDTJYHL;)T(-Y((P6CbEVVaUdDCQ:=&4Wa1bQ>9
FfB3THeQUXaN4=#O[.,1Y4eCC,c=M+_0,a[S3]-#P6YZKL6,2.QUZ.+/YS0#==:e
:B^RB&4W>H3UE_-Q4JFG2H\B;FbUO^9F#&(YfZI,+R>.;>R#_<f1)#?^ef0);b9a
6SC0@=3eR,?#Be<OG#O_7^R2(M4.J)eg/,Aa9LFdXH]G\V/[:2(=R\2MHb4MWXEO
67Z85/81G=He\2W1VJ;F9,/:<a4QfR<>MQJ676ZOCBIUQ-P(bfE[;>DH^5VL5AJT
g9K:N#d7e-#VZ8L\1c9@cO0CEDeQ9^WUAG3If1\B1OdMUYRJ&e;6H4Q<>MO31J7K
53]4Z]+,d;HH;\EAfJR77dUMeUT^PXL2XJd,bS]#5A85RcaPKBP+aV2\IV4g-gZ,
Y[4I.a7H7<6-YN&+@+cZ_SI/T6;cO06FHN#3f,R:HZ:?)g+,.;.6_<(#WO6VQ/g_
84[?3?D.BfI5OQZ23LG(<33CX\F)ggRI9WS04EY#68f#fFH(F-6^&THbK-e0eBF;
e_Zbdf,E_@53.DEBWDMg2:H;-K?8#?8^0-@YQBG-21U[-ZfCd:;T11T1)458f(g?
dGCN:@VdH\G0fPaL20Ef2RH;8$
`endprotected

`protected
E.]<RDZ^KN]g\cS>#TE;W6,eUfX9W@J9]BR^MM0>L)0=(0_f<=cA-)A?Wa,[d3:_
EX99+WGJ-7LJ9/-T(47bGI,e7$
`endprotected

//vcs_lic_vip_protect
  `protected
c+>7:0.8Y^VZ@INb1^OTM,[A:F>_B2a87IY<P;dN?2V#T6[LK7JA.(Q-PMGUP8KG
,#C0.0ZaTE^f-LV:=IITT,AGXgZ:YU?U+-cLT)C8.QaH^7)9NB&A&[JdIHRSPZV^
Cb1#&5V0>bP=@EHLS)(GSJR#S21^1;c]Ta<g\NUMIE?Z1fX[6<3(#F)c[4)3.C<,
bH_]G=7/^E+(#bA,].MWNMeO?><WQCZ/QJG;Da-ZC)NM6YZESUdL4K:1PCcAK:\H
;7X.BGddJNF5IIBNY7USG&H_f?bQJYEPP:2=JATgcTa_=,bG(B(T-aeaYPUWG:Tb
)+ccJ4XAZW?;\/7EdX:0gb6FAM2gX@+&VQ8I5,W4((J/Q:gWQQHKKMPA^R<@)#O9
Pd>Te1YC04,Y\)Y_0H7?YRD&9PR9;))MfVOCP,^d5WWY;B2IPe;2NgO?29Y?/g)D
,8(D_4E39D&Z@abA<JGK&T)Z^DAL)C@P4/.2<+L6\PM7LL&g:6#:YfV]&ZGR1O],
KMT01I#9R2BcMG5I]<,@1=3&K7K2,M_(TNceR/eDH1B-FEGGBPD;[+(@d#:#2A;=
JG]8B1#7AMB^bJ1fS]LHa7MW#(:0aBd_&9c1FO<gPf&7ID(-K7aCAB6EES?IdCW:
Q#b<SU_VdbVWbMZXD9_?4S5TGCZL]0G?a[G8VgC_I7\e>U8UL5N:RT,5)eOaEeG#
d3#H:;,5<SW=75J.bKGFaAICA8R:\=+1&7S9dPXHS9.W;SaP6/+W8@A#^:8[MaTM
Q^1A+-&?8-A^>MG?UZ)^d&2;(Z,[-F<X1ZZcTgO\WSSW5Xf)fF8R5#K)QMS9_CI>
W#\OI<Mb/5E=egA6.OFd-U4?bb7G_[gHg@6WEX6c@-[fA2Y9g<P_[?1:aLK#9Q-B
LdIe-7F=cU2d2;g5AeRN>KALKQd,\\bWMV:4<B1SY=JTQ1V>,&f\YU&d6X+a);QR
I;-Z8FZ8e(#7A8?-5](<VCLK?26L-G0X9:>bDfNX1+TBb9ddMSI[V@)PU=M>6Ec^
A^Y#[2285/FDA]b3c&GYTUX-,L#(IA10[XaH-;>M;;U>,I[X=4Fe?I4&3Fa>f:c9
YV=7Y72(,_A,C(VBO[,V?Kg56[)8eZQB9O0]G-eMf?P?7g3Q&8LG@FM9O3D3\M;Y
&:^HQ0KD,GOXSR#Bf+K/M\&aLb=_M8]#E:_.9IaNNLF_SB3A90F):)<(U+N^2#9R
DMB-^@>-E7V2_aR0D<8e//?)Q-f&_HeF2Q3c?feZ-#-H0.bDLOVEfHg?SY63AecG
-cJ5D^YGP^-))\\Sg,Y@C6W+Eed,I+RC4fK-.E\=7N>#bM/Z?X>g[X]#?^eFd5:,
:JFZ?U],U[]7gDN+CZK\f;6cIegU;BO2Z97>EfG^X70Bc#D840<SX<^42(eJ+_KQ
?TY98##^a,>6<>[AGBPNVIX+.S6>g2DH>=7\/K9fWATI1SEQZM--@e);[PEGKA[a
N1ON3B)-O7#>YNC\#PDVG^NBLG[dO>I0ACW.:9FU3#24LUPM>>G\VN,f.R:<OU&:
.4-6M=dJP94bEB-.G-CL6f;Y?VCA<8T-GJdV3HcUba/<:KI-6b=fd=<OI[\U-_U/
;Z8U[aPd:?<XCV(1WT7Z4]CZU9+PMSX+(3M/=(<2eX[JO]RLc?A<aJ7.X]FdfGXW
SN8=7-O7e8a4^\R=GLU8SYZ:=H9Kb)bZOON:=RS5:@^K83;):IQOB-?\:2JC(VC#
V[Y(D?I9E+6TU8e--c_-VVdOFDMfS.&ea?+2FU8F&K>CT8K:P&<+)W;X^.UYYPQV
b6J-)3\JS_)ZdGS5U_cAT9W,Pg\W=#U.I4(I&0d7Q<:f41U4+)_#+J</a,6CPG9Y
CQbWY87fI)-.<^#@FL4N,ZQ.R7SG6I^G84X242N&a7_-YfOb=F>1JfdM-Fa6JI-/
4dJ69[X=\DZI7Z6_-5UPNeZ1+WVN<P#,6Ic91DQ=g4L[4W6P2]L)BV+/b6=5QDD,
P6?__;&5e371cc3DU7:]&@P2?M-;7):S-RP6dQ84DB+]39QL35-OJZK/8VWT02Ae
[.cFQLd>UASCTNH5fT_MbKTdRWL2B4/WI/,a@256TT8\WGAPVP[92HeU[HD9=:)E
3bYfB0:7]a0gP&4LRD4DV:;#8@&,;ZH1=MA922?D-_OFAUI=7_A:OPde>U#cH0H7
1MVH[+4aAVD:F#d8V+EC4&ZKUH>>Y?MU,WK.8>E\gP&X?eT9@-+.5>We2[=VYW:M
HHUbcC]_NHAHdH]9NQ?Fb?2Ca?SVFb<<Ig::3]G6_b+7_=7+H?VZc(WO(.>;c?D:
fW#MPDg/\C9;50Q+=#[+6I.K/G3(eG.>G12XIN;Lb=NP;.VO:_fT0(5c6IY.T50?
0aJ8F0[:SWOL>U=PARKW4G;^WcR>7&]OF7PD5/4T79fC/eGT3gC];6\.JPG-M]5D
3[@?=Z1f4X\)cc/2deX/6;I#(RSf7B]Ta,Q.DGG#&<\H,5\^0aDQfbAO)1aECQNJ
(0[\<Rdd@#J\Q.B;=e^4^cXW8ZEg]->196KV03f,XK>d[=;GCT4adP1,7:[bQ/T<
UR6X7W,=>JEKK]A#<P/&I)WM2b9#/MbfDX3IFH2193gIN6_@[3C^d/PDX:7>:UGQ
6:+;M+\<3bJ-QE10A9-9[g8ZH?YR&SNfKaV_NP(1^PBSH;9FO,RE<)\]ZN#O[_EW
-))1+;_9VF[CQ7a2^4cS5LBD-0SRb<a_:1BBVUY0_2(R.-Y4]Gd:E#Be^)-8HMKB
bO.XK)A:84cf^,W-2G6cK9TWce#Aa,FU&COZec-]9_AD=]bPJE&8^=bc(:XWE8@9
bN#:VQD8;GLE7T>)Ya@Ic7VL:G5J(FbH.a4gf/fc&O<>c7S.83]S4b?Mg;++Xc#d
UU,ga=N(=XZ^)HYBAcK51D[K0M_:V3O)cK43W\@)U7VXa>LO[OL.YML(#Y,M3S/d
86X1[#V;8b.VD<+0PCg@40b32S=98ZJ06R+,X1,b5g#c1fJ<WX+a+DD#PZF?GAU=
dWXPCBGfeN_++RUJE[YFf?Pf2N=Kd#ZSV?g.).<ZLA1=UN@ZOPN<YBPQU80gG[g-
RbQOI5G9)agODU(A9RCJJN(4I2g)^(<6/Dg2eR;]@I?_H9S^B<9B@C1EGF-;1b,d
487;]::JeW8F=AB9E52&ZIF5<(2J7MT(>Z((bb>7E)VFX<?(5=R-:/D/-[e3WgP^
ff&Z)d;;1[@:1]SAbF6AHDCRB8YOJd]-+:(N86ee21?Xd/LOJJ+V8Q2ab^_14dV2
4X=PcINg/^]b\=?5=YC\YbI;E?>9Dd>>QHF(6:.>YR2MQE9W6YW#.H@H.9e0_7<R
f@&IB68RH8),^HSOB+3YG6A5X@CMcMWIEGQQ5B.U-0bd5J_Mg#6ZWAc-3K&R-:^(
0.b\VW]HFQ5eP+-G81Od-<QW\KA+\@;0I:MXf-RT7&UBU+Q-36<12Q-7IQYK_8b2
Q,aXa)B25<WK&,;OG)^-)#D+)?).HK@(W5+>D8#T@ZQbKF<1SO@=YG41I.1S04Df
]R+639H9\9##-.G^AMBHSR(cA69CZIJE:(ZN8_-Y(PU+TG_:cVK]aC?TRUV^R:J.
gIAG.8,^eOZN-:\AJAW\:7dO@K]T0fLC^>Q_T=/ST.UJZZ0b#OKIS.I.O&ZI=cg4
geSe_5XC=@;S]B_B\E5C1f;;dV_M+b\XRC84L&MV+I/^FabPg8\g>SQ8<<>gL9W@
E+eg_&TJ2RUY-FLK>/8@[I<^WN0[XMX=/d/DV8:;O4ZfEWD=G6RPN\\7;HY.K3,K
-SDaF4EVOaeJ2V&8YPgO\(=L2g\=/CNb2:0\&0ECg55YO<?P>L]7)@fd49S#ZbQ&
WB>Y)>/Ca.>D&/3<EHPE9f8D6B+SVX]HNJAKL@Y+aJO&+=@U,DgQS+5K>VcAL2,3
ZGF/?H0>810BD9\eg65HR<LU(5R3X3EQ]>.+>>M&TUI)Z?:=N?fZgaM^-gCX;d^M
Q6e.AH[eZ1IBI8U8bWSCGT;\AKFe>U0NUQ<(>;C7QR;I>6/L7LUKEO4T1LPXHG72
DcTdZXLJ,_#GSL2X#]CJ([R&gFNafUAgcV?D7?J&/4J:f-K;aXO#OWfWd32bTKX0
24Pdc0MF&>V=+4.K^BLMTX.54P3W7JS73IB2KP:3OJd5BXH24EDX&F6gGUNXc6[D
+.a7BQ6592XQZ)9_3+a(M9=cM.)/:?(DRN20A6\3M^+XAQ[B7U>M1HHb6#J2UW0d
@)\9H(SH?_>IRKIf6IR6e/?#Zd2WJ5HW_aHb<4bDV;^B-A;?X@Bbg=;&dZ-3;V70
Ve7.U77g(;<A_AIP((#;-S@^/I:Sc06^PG&1:;N,]c+cE;.MfFa16KKWZZ0-IS(@
54Z2@P9Z7I3>1/Ebe>66XT.+GF9I_d7]\3eDeCNNB[J1Ub6g?JHE<\SL[__:c9>?
)]3_)2)G<=gbF7ELG)21TLgdfHR^S,_IUAg.?bY2][.+,5<(],d9BK\M^:BUP2SY
WS]/<^LP1&A,_A3eWIJV5>06)=7]1BT-:-<@?7g8cFZ,^XH\,50VCPXNBH>V?\<V
P_.M9?G)I[0&W_fY9/?,-9RJPR+f4C&]Z.6.AH,:[+g@P@+YLRSCF-P1=@RaC#^7
AF+8N8,EVCc)c@9.B<U3P7]LNH/UU]MPBQf^0,4XeId3P2GY58Y<bC]V/dBE:S0b
;1RRX95=/Z\\XQV_+]IT.0AI@ERL7d5#?1g-#c/7([8\L^Z:VOQ/N:^;Kc33)<0+
YaPD2BO@JCOXAF6RTS54(2df<2H&G:AL]/#JXgZOZ?e_7g^Z8LS_:^T.EfS@-&Hd
:8Gc90@bQO)]3=O45VKNa(98Xc,,b#SM]<eCV5dA3P9\]@D\5.W[N6F_.GR[QR2>
H[F_4YgQ.bD4/-Y2J&2]\/&\[Jg4SE4L\b<b5aM=d;S,RaA&_>OH&a-)I(WMN_/P
Z_=U(8\1g#_;?8O(FCF+#.CE<La3[LDfS++O,J?#?R6\IVI[,gCBd7],3S-+=&9a
SP>-NadbGb?PR?acUFDWDGdC&=>G0XWP3E,,X9d)=H6VG80_;e#O.5ef2b@S-eb:
@d[^NXfgFSFd]]D[5GO)?9JI.&E9R.\f+LKU1M3EVFL,.J8R6.4<W9&dD?=,&fIQ
N0,^ZZK0D8L060(TX,8YfEOO>^)O<)@V#S.ML]IP6+:Q4O0DgQWS2>7DC2dCY3Wf
g#1AfXP=4Q<1KZJSf8?D7))Fe^+UW(SB],Y?NY;D9NFd=\H9G]WE/+WVO#^Jfa+(
0ac1LaUADQWE2+Z:2AI_XQI_(N&W0YeEYMC;1EDGT\K?.#9>-&M(<P>adXaNX&3<
GJ]:NaY9B;4gYOMG39]G>#-S=V2=.OQ6c9()2XK[HFGZd+=^[BZ79VB#98-MXJC,
e&79b[?0WC4]5FWdAKQ349D:-6f#\e@\XG-<.>=JGHc;MHRY(W2P?KfH-,3@UF0_
6CRT8Cd2\7)eN]W,:AWa.R9SC2La>E.g.0WGRTa,>,(eFCXQ=MO[:M8B[&W6-5]/
;P<1/WNg4:bRD&^>dOD3#+KQ6W8_.;]/E3Kc@ec,gY?&.c)IY:d=PdEEX1,d>M^H
T]Ab6OeN/&6Ne?)WZ&MD)S5aOG_WKRW/b,6&JNVF8>,aBKZ+gb>GB>4cP&PPCZ[>
GE/FN-S5ad5g>:YZ>78RPB\cJ.S?1G5,/IFNGW/bELYGTcCJSJK@Y(57\ZBbYX>R
-LE@MWKXg?gQ5.L#CQ_,(M&VT;F:5Zc4b-LJPb?Z)M6D/B5C4@YN1bL,#Q<[J\g(
OJQRaHS&5SF0,0c[::=@?6c+A(AK(7>\:Nf\P_X6TbOSI1^[+RHZ#41)?55/;99W
FXE]K>X@@d-GQ_MMXCRHFU2RKaeUfD92_Z+c_caV/VQEMU898^+;<BNGcW_K0[K_
O2CgM-gIaSGTD4+OQRAaHSV>G0cTQ[S&dR([FB)[3K()\U:7\5:_.&<ZO+S2EUPI
7\/,[V(@R[-d;QXJ(f&d#5^4OfNaNMXP=-E/Rf]7G5CgAP:@G[.2-K>X\KgC0<Ob
5];9X8,2A2MK@HIIQ4@a&R5J3N=+7<QP<eJg2Sf<?cOGA-WU8f(/V^4B/?POPO(=
NSgPO:/]UM@9(JT(;.=64E\VLdC.:1NeLLQ1A&dc-F(G#Laa1+@a4Y]11d\#3b:6
#E,NW8IW66KP[:/d>[b8D9K?OCdUA43U)<4gNJ3NAf7#\/&A#DL\UPP&SbW-N=PH
P#<QP?CML\3gfd[^A<UcS=c]+Vc;]1^fIT[_2M#7N=6I078dHc8JaS#6+1R0GNPJ
6Q-]69cYS/J_0&>O1GA@1d=^>dNRN8Ff4GZJH-PTHH1b/T-c]:MX9aT+(3Y;7<G[
)AL7\C\)99.F(#3.LZL_Nc)/S,0R:9^LJS/E<MD<5)\X[TWJfEc6R;N./?,Q8^@0
[W(,_eZMVT;^WJ(A?g3DAYE7-@0-U6/02]Fff=R1CD)YP@8)Q44X2;5D0JDI_<0U
Q)/0gbJ9D(;Y)<]/(bPb-//DZ#eA_AI[\.Og_LV8BU]V[\e+0:B_8UT.S3M;<ZO_
#^^cXGe[M#J3OXMF;GSNINA0DaQ(S-YSVELO]G4\7)P]M&.@_6=NYbcIbHcI>RYO
a+a#HZ)AO.7Y9306+5HO0-aZGL(+<-4I/1:2gNX/Gfd,-QU;M<&=5=C8=DZ/PR[a
L40NW9d[(.@<GH+]X3^LHZf^B)IEE_=c97D+[QN<dXUN-,/R.^HDD,4X9RY3M#H0
DC1ed&=>TC[[OgMT6+X+YBB<;SMJeXRTBFdJJHHfXS&0UE6V-(]@/&:5/32#6g?>
(1M^LOST?F[HUeS-@K,QMTS;6VU-F(YY+?>fICb>QUTJXT,H_)cD#AB-SdWWO8^D
5/,H0c79ZMMNb+[_S>,<9_eKYCR@..,)6F5JR(VA2Hc<eJ6+3c8X6BbcQ:[KJD?B
OK_07SE_49OJ_<_550^^B8PE+Q@.5+#9b7)bC0@OgJ#d-U6I@EW-RIR&&H^4J^9M
\QI=/MK]YWEUBH^UDUS8V.2,F6SGZ_=W=b,45KXeP@F5IR[BRc<g-U&QR&.eb8HG
)8B/JBVHCcF.R?7XG^,@:2:/O+\]:cfFMQ2&<+^0F4(D]?G,_=;_4C\9R;1cXGT-
1J<8<gX)38^b4E0B,9\7H8eH=P[I&a-_Tf3\_::#.S].?[:O>;E)ZKT#5;AM>PXK
;R@>5-ST(6BHXKQ,Z&C<,,<,3;b[DO8R>[XJNBZfZCV0P0W5,2Z^:=@X&eJ6UaaF
?XR#SO1P-+GgdX685LZT0GM@.Cf)V6J3@g^+e?;-g4\@3S1@1c8fZfWLfE(a&UH0
c1L;cX+JD=[Q(B@GaF[cH^_UaKH^3Q>5ZGgU86b8+-J(=NQ]Z:GUXHOTY<eN5_Ha
SVN1=2g(,UA+WC.;HY7C61N#0#9H@>M7N^^^IV<CeM+HCH)W]?W]M+MNE1B_YT[C
H:@M:S)eO\E&]H@BS+.F=;>[B,XM/H,>PCRB:6QU(_H)GY?+VO&RRX+T,([3E421
-(T64K>X7g2?CM/:=)_Q\B.RQ7>6TJ6JLd^MBQISWbF9]&S9+=g,G9gg9W:a^CET
CfMAZ_Z2>TXWgCA(eDCIEe5aX0PFQ^-VCD>(\4M&f#;:\=XBO1/=gJYKBOg]VC.:
,:O:@7NX?+YH6^03I32ULK&XJZEDO308O+e\3cXe1B3fHZHT<S+>FE=79.f<C9C@
8K79>G6EVc)@9VL^_:-&Uc:SVRaK:/GZ58;BD1Zc_+4dW,RacPb52?JI09bMa-L7
3G=1eD(\b(P?OD;3#@g+Gc+F?+.9VY>DQX>YB@;Z^7529?JTUF3Kg#DMN_521Ubg
+_bbSME6<XLQ4TgfG.>Wa^FZG2L<CD[ccWc\&K7EQ=O:,\L_?2ZZ#e#&>9-_VB>)
fK5805,:cbB(3=5Q@_R06B+T[_,:g)@12;)6^QGI]e._LP.C8AZ^fI6.^9<CR=C6
EZ739TD^4T@Y(_4g+Q@F(_V4Mb\LF+Y]X8B(U)+]B[UO9D[_;fF-4K9-]Y]S@=d-
EP+(6QW>@3RceA0_3G@<UZ3+bR]B+&ILb^7NCb0-OFN67-2(\SV\)+8@.Eb0Q:@L
PY:+2(OK9,7@<W^R,(3:W<(1(3R5?UN1dTfCLa&Y/7G[L1dN[98C;HJ#Id=GfbbP
a=P=]K@A.;b^HPS@U)E(+VV08XaP[G3S1T4cYU&AVDVf1W9;MN9?gG_-2CN/<OHO
(W),A8<,HP\HZ::E#]W@VS)2=f4T^^N_Q0L(O2)gE-cJSA#(7R4XcMd5Cb]S^fK#
LS5JHUEF\JS9dJafJ0E1)7SL(T?]aW;,A@:.?E&7(#10/6R#U^+^6e/O8eXR/J7K
P@FSHDT?;[R>GAENZ\/(Q-,KHKOCLJ.0/a,MCB6L(+e3L9K8B[bd,+deFUX?;#6]
=7IF.IMDdP)S[O91FRa[;cWZPUV+93CJ,3;d,>HEXKeIb9@BNG6^Bc+IZ7NN71S9
1CQ@aD+MX0KO^/Ef0fc0\+[edgY6cWcA[UG,g78@8D1<FLYY]/^/_(9]gE]g6JA>
,.1?5&E:.O2@9[83eA_EM1fG(aTZgJfX)8U8>X4KOUTe+M&N_c7^>4,]8MA2,9L1
;e(/=g-]N[eaYLgUH8IVSFV@ICH\?21gQA,XI0U+>BP1SHFHD8/SLfB,/b,O4^N^
TfXAd]eYdZRIHFCJU4JDKKD].Yc2aV@.Bd<DQ@[BK5\VUc/KGSD5@@OKca:7S-&A
_X-938Bd1Zf^gYNX/b71YQBb&XUM1VD2U1;g\8=/d=)4#ZW>GV0)O[@U_M.-ee^=
09KQST6[;-BP2Mc^DB?#[P0DY4<c;3,(WV9-=CP:^V6R:X^9bC)N5I(M##M-1.54
>dEE??DLX5\R:IBXd<+ORNA,13.e]DBY:++)DGgceFQ+(SG\-Wgc]HD5QD9/OHb4
(EYFe\gcYENC;fWe:aY]6WO?5K:)aT_5RP37;)]8NaX[AgG[X4DI?UYM8#KbP0&M
[8TP,SD\1?B?20bX\P7KUT4=]e]WQC2I4e_X6F0(-OPI4bgJC=RJBM_JYEN,MKR@
YbSG<#f;L6W)3S(;6U&8?7aAP/?b3\\C<;Z:)3W#Lde,@6f6_B-2UTf[cNJ/]&d+
[Z7eJX?0fN.VW^;DBD[&<d(Qb)3YTdJ,+&^,VY^g9OFL]=TJPAb,3S>6PbPGCS/E
CIg[HR6GLTcM=13gJ3@8Z>6@CWT59YATT4&ZM+.WQ5?DH;daPP&-O^^U?1V0PdKQ
N6TQ&5N1R9M9D[#TM(F7KSN8WCBaQIWSeF=+PN4>(7JV_9f?G8)0UM2-KI>EBG=]
)V>?^UBM/]#0Ng^#?NNY=SYXd&8UH6/_5b?3#H2&O@^W#@/]H)X[@^?=ZSWO(\_4
R&Z7WRfN18[@1K.5<),YE?M&DN,4@X[Q^Z/./K^WZd>D\)a^)I-Uef_\&FC0@PF^
9E-@(HE5:S;+;]C6E-e@4ANe\&R4S?[6=BV6P))>WSJ71LKU=WR)6NHQaUIM])f#
T?3?BF=Oe+gFTW,)JI\K0HaNB137OLfdDV><:7d,&[8./N;KM_W2dSV6\T#OQ:95
M3G/Y(#b:DBDQ;EP)I2QfXCJg/CEOJ1JWJ@#7SFSe^OaNE;95GA@T+_\:@CR,6SX
e(S<#B8a1.CUIcG:JN5W;AdBIMb<1J.:,6,=L&>8)CF4Id.^,K+1X@#N47+.3MAV
<&L)Z>HXbTV]_AN+:DBBW<FT8MB6Sa-0A+gE;K_60LRNXOO.J4-S]0J]a1_fa+UN
J&bJ1b#6JZWW7:(E15V9^])WaPL3[S[=MWOX=Gd9BHPAcR&N-I+,eYcAaXdZW<6T
dgSZ8HT7?0I3LX494M=2=<W<,&F1K1\>Yc,Pa,SEc3,L@VHd:a;c4E:(NXT6>@F>
T\Le5VYK6fgbSF3<bgY,P--P>eRSGI7]>;U7#Q(\<MH<^8)[5+cd5HF.WBDNfJ7R
MI+^4FUJ;_S6HB,;K\fE;cHb^QL;,e6WQ?,\]B\O+b;06;M^BVfXgW#5-:WECP^5
NP7(1SGQQb6F7NTX+LMNdRSNb,1.HdH-5@EOGG]5YAU0gMIX]7e-XX#6YKdb]3&7
#YBH)Db]6NCS2cLSW9c\=<T[J1]9dYE5,\?+b]b)H1&L;^eO)MfK@RY^V800AFO.
e-2=2MNWOYLALaQQP@06<<L=<^NSc.SF5V^RSVg1\aGYQcUf5.4QBA7IPW0f>8]G
PEY)V2N:^DH3QCe];L]T569:0baE.\&\>e59@44R_@(F-b5W_+(Aa73<05B[F>X:
a15C):@P/8XLWU9;?>A>,>I0OX&<gISGJ&60f9Q35\QBX3efb\5F8<6XKE_]J7e5
D,U\9&[gEH@LUN5<KCXNHc77\BXfET#F5J.C2a[AQ7&1.;Z:^,;IR=^9\-X9;,(I
EYfN:M9_,PdI(6-.bU0;UX<]F@&fJ5A^4.W6[?=4X.@3U+,JEW.)-AfV,a,fIXNA
e[8Z57)/)A/=,B3I?SS]E_bI[BWCUWeAac;O_9O^?JS,KJ9RB?+?W:.23b97-ARN
[I1dG1JC#B/KR]09bFY:MR0\SEO&&XLB_,fg@B/S8XIF:J5MA=.0a\]E-L,5@Wa4
L?OH@c7HV@&RfE7+>P[9F7^)N3Kba^d&4AX[ZZZ3H@)()bG=-Vb5;dcS[9dF,ZP[
JG8@&f6K+5&1F+S)g/(;Z7;=U:WRJ/\M2J\&H:77CWA;AM)@21/WbTO_,W>eG&Qb
[cTK:?6e8:D50c]BTD.,Z;I,gVQ-g(F0=8:H8ccQ<d7QH3?YTX+SOO^6P\,-TAVO
)FM(PB+dd4\8=G0G0J&#9+O^=G7[4BX;SAd5>K;V=e(4YV==<;^WPX0#:MQg[4=4
+X2_VSdD04AX2Q&ZM>J1CB2O1MCZ+IM/@#^ZE)2WO\<8OdB\A/Ybe>Ab^6XY_F?X
Q7J8N6>:]#I,=.@V#W\0W_X/59PN@,,SAe[Y7Nd:)-cgdbfF54OdJKBY=UdXA?\L
8+EgeJQ/8+KNcA;I;P8.GO[;WFRZ4@?eP;88I3-D3,W]EU(Z&-RC:A?M/g70\@a8
Y0RYfFX_ABY2e[P5U,D2GL=1(5S89+7EZYWGYegR\8G--8FX\SJVeP-N&f=;\K1Q
ER566#^/g2Ye=SA9V[KQfPU#cdY)5X+02+cX]FZ=@B_AddTI1=_&Y)):ffKfN&I7
XeYNQWJL-0a:C/F7eC>>=S\<W+b7N1O]B2FIAOH]<>&]d9I5a;aE9HT@Xg1[cJ-#
ZPJd(=1R-a7gUeGg65/=B<#3cV]6WT6>@0cDD[+>GO2f+U<I.>Y&:=XfK?7FBCID
PDRA&\aA8-__P;M2&3Sf43N+(K?NVDcIXN[:_W(8+[&J#,\BA5-A(S&X#D4=I;eS
IFdCAI.d0<??+7gFXD-YQHCU(/aNP]/N-\;e#@c5<63a@U4R]:/??JgfT/Te\dSN
V^Zf8XQ_5?6S-][]2gFb;JYY>L:K)[[<&;C2^4KS#Y9gS6X<I0_:GeaYcM6]ee_4
ENLY2#KTf<][Ef_@dSX]2/cT_6:VU[PGZbX/@H^M)WFI=FMbJ#F@:6A&gZaY0UQ;
OE>GGbW]\Pe>^/0?EQQA<dL,C<I:I4(QgQR<.ZWXTTCPK&d[1[.X#UX08O498#?J
@K53DWf?@#NEPP,?bF60(N0b^;@N./]\Y)WV/g,Z&JIJ0)E456GY]gWTd^7K@;;f
8Off>6eDg;DX+K^/gX_==Z@IW[YLZ&H^IB.^J(#_gfG+=PTUHG?9816FQCMbN=&@
(P@,>W4U^<>1+0DHg=JUL6V_4&?S265T)D7S4@,.1WD6A(eTcRK2G.O46JM.cJRT
E1IT;;=B[N^G:\=-G\SMT.6_S]:ZPE4X(RUdXT?D+A@5eZ6@2@/F8G90HR<6^9WJ
/[12TF4DfaAX)HO@&;P9F2H1O593:4Q85#DJ4dQI3+>-NM-8840M3HKI-BH,QMP:
3I[:DHK(;0EWC)N1WBeHQa?[eQL;bD#;f:00RER[@07U[I#Y5:/abCdO,E0>81e@
;6T4&1(E:_?X?[ER+3J43Fe).77C:_RI_5A<:76fJB8f@P(EDbDd#\YcQK6<.]A&
,;)FVF)a89be>KN?6OZ?LK0>7@@HGfcJA]E>KS5T6NX+RUHGK,cY#Jf4_W54@@6]
0B/_1\I08_MPWdEEJ48F&0SXP)/B5bQ[(HHL=H6ZI#TSYT&L@\H,)T,8;^Y&PKWD
Zf,O]>)HeQc\+WEW0V-fXDZON^C,0).ePZNPL[ZW(^aSB(<&PDZ2G@6c@U.94@SG
<A[@cgT=e\?>\:HK4M/b[T]+P@-]>Ua1\(H4QP]f:D;cc/Ke(O:<J333Xg.[aC>S
0GJg?]\EBXI/U23b@MQ2fUb&?>^?-\XZP__41@WPLfPX<I/55=3=6SDWL9H(+dY+
,WIW=GXe(;\@Hd595e,0cC8Dc15.+RcG4c1d^^3S@X/[@4KOS+P^Z,>91de7NEE.
^,G^bSQO\;/aJdGLc>:FGHSOOLM(EJC=SQWA8=+>7B]/d>La/9:K?D7BSY@,)TUK
\_R@USfX9MVd;P-:(,1V<+d[E;(U^Q0NIRTQgFZ?UdaEVLW#Y_>N,YT97<1Rf+VH
9/9+(S]7GM.f-[AUM+V\VVC=QSRK_(X7Ze0:VT)-K-g0VDFHfCLdDQ9aF?1bKNfO
3+?&\GS50O33E.+S+ZX+D-Ge\EP92;8,9HEI.<BAdYUEBf<9]9U2N+Z&5Bc&U#4f
JaP]3+bQ3D3?_.fa_[Qa-7;VP&6.:f_F^C)+7,AZ9Z)>KQMOEHD0FJ70Y8]7PK+-
1+R:#3>d5J:A)<?]VabG#_8-W-b:?[Y#_g]^8?24K4U_:I5Q4J0(N?K1?<,g[4^,
dfR60W;13f@))<:43&<.^TG86W5B6Q3IWKZC#+aZMAWf)VP5A]?b;E.34>,&BdK8
fCQBHT(^fY1TMQRB//[[XF/<dG]Qb<.,<LO:V)7Z&-B.[>LU>9<\)]H]05]R()gG
IU\/<5]]g1F+F<&[S9@^GE02gHWeHf33>S=@Y,3[VU;d]16_-))+[]b;IJY/&.L>
3<F(M#a@95)45g)d.1Dd/LUc/.EU#,?e==Z_-IcSVLRN]LQIf:g63<5PKb((<MdI
6\;-JB?XW&_4=66\?LcMQ:ZX8#3OKD[CDU>W>#9\O;C67.Fb&S,C)@bTTM4/-#Bf
PYU,QDL[-](OU2QbHY,GRcWWXA]IWOP[@;8bS0B74c?&bAQDNf/gLZ;^4FffcT]&
ETI5^.+6#FZ5>1AH_+WV?fOKbdUB@9M=f2]K:NVaZJ#8FY)afc0[J#3TYH86IP49
8DCD#D\b99)@DdK(RN+,>SeAb)cA\X4LGI;Ve7f2#GM^-Sd0#:8/ECT[MLJ\f<->
0Sb_KKNPcM8KdU.A;AeJ6#c31NWOWIJP:WK3;/fJH7#WVF=&b\1NAgN[P#4LV?KA
13(#3I[KK\_<GLfSY.=]T3457)FE&LaB2LL3K20X0WJN\(\K\-6[Wf8[(M6:E3DY
+DD&5WXD/-BVZ/+.dOUC0AbfXNZ,I(-9:A?IKVQ?A8e7<1W0@C:,C=We4cRT#X\@
#U]LGW-<V9S&G9fY5a-?:E6FZMJA8FgP5\9?Y/:R2.fB1+Y-/Yg:E1T7N\9D@[Te
H[a^cf;Z@g#fa)BT(.LM\UCEZe_7G(AA1&3b]&#d6a(0@9RcJ#ABY?6FYNaIL[f#
FZ4\I2+CMe0c^V(9XABYNQ5K0J@fY[#2Kf?,.BfUeHa?(F68H72W7]99ZKQC]XBL
XUD:[[[,(XM)#eJ.4I_fGf-Pd-;abdd/b[,9+Tc80K40;d];\?JbZS[F=PB+#R^;
9Z(RGEEK:\C[OXG^^L0:BLJ>#HUOg.H:a\^M0DC/9C6HRd&JHCDBN&AP7IC90a7.
?X7_A[dW,76+DaV58V^T.>a93&C=:e.PeKO)2O\B10(,C45b:+-)Z.?;BUQ@7PTf
1Q\7H66Re2J/4O[L9?dJT&0bMS-d?^XaRaI?7;V8=KFFWeMJU>4N)R2SJN@4(2SL
>f:6-Y9GIfb#D1(+)F+1G@:5gbFMM.Fe_\K1>08]S:#ec5_7OQK[G:)S/N9Q)PZP
d,<ZB6bJ@^;_d#YC.H?1N@)>fJX4JOMGd;KX-=4R^d#.T>7UHPf2(/ON\6Y(7OQ]
?>K>6+T2#LP2H(gDFLDg2AD/\EP88ZO=,a#7IV7MGfN)?[L^Y]XCVdN\73ZFgFZ-
6&;LRPD-,;L4D+?PA7#T6M_@56VE=aLg4>D;M)-a)>;K)1WFK066<0RJ#9=ZN/[>
QANEYZ.g1]_MF\MLCZe0>EASV>=,aP(0gMKdR=bec(7WPMN.ZQ3JTLbQ:659,:K(
I=c;K?Lc2&f&7G7ICBX:e^Sae0J\7JOXf[\f5?+Ua@=U,Y4Z1&R)2/X>2AgP3];B
:ER51RG0bJT6>C,0U#+4(JEUSCAW6)17OIIO.bFD?:@aTVR=#ZGgHS6(UT3&HA:A
.@2<7Oag5P[.=\UcI^Se(@#[CN9W.=Vg?e/b_d/76+8Ad[ZCIbL;d;-E<)MCgE>3
1B+23gYeMU@DL+_ED.A)#\N7?/J>I\A<49cS.&b4=QcgQ(MUQ\+4K6?FVd/QSWP(
Q\?0-P<O^DUT:RB9O6<\Ve39M/IEWFI;FQ481/(OcH^AN4\HS>Kf0UJSg\af./[9
[SbX(W9-YY2Y6&PT@9RV-OPcJ:SE96@&#=P#YOZD+)F(b39/e&Y02LB[8cF=>])G
Bg;g&N2&XaE8M@I<4B0;U@0LXFE0K#Y6UZ)UL7fU6ZQ+_,Ac3\V;</@C\#U4=2S]
XA?4;TUG:RR:NNOBFS67;/[X,5g#-Y5b8K0Wc)/5CB,MT,6\1\aR&,3Y<I3BA?e,
(IYY@9,&0K9+\bPFB>[#QNED/W-38^5V1b&A,_(Z5E&V&c_PZ]0S6FN4.:D..MX&
9P1H=]>9AI]XV21XP+OVZ0gJ1A\GHXRGK@Va&eA6C>H)\9V[F.0LEg2].OTe+FK3
^O7B69H]ZS+W8I9a3U.QH&aCO2#PSAW[^F2[-8VbdT?GCO()SAZ8Rb-4FM<?a:Mg
?8B6dG(JK<We/LQ4&69:>/0GMKZF\]Q\eW^MLe0?7Yc16T-M]fNdbPE/O.?#CMUK
VgG&LV1C4X.eXHDgW>#)1E9&W_/(0;OUXQI_9P^UF/3B:T-D@_H<5RF0;&7O\4RF
7B:BI_SG2XFC#C+I]59WT21#=P(Ua>219]H&I_K\RM9/1L2<&R.,D6YaL<HX;(0@
b&TRJ;(_]0_S96N2\GF8bdc0M=@Z]\+:R=Gc+\F5-;PY3T6U2DVMFAcM&,]I\^/+
6N,TMe_+Q0S@B7U+KTWX,D.9(SP+HH\KbJ9A>?[KF-KA7fMORHRDRdD7PW.Z;8CX
a]9F??OdO\S4cQc(Ue_A;CdX^7\<2<M>91+4F@8D8^Kf&PfI76fB#>G0ZM(DDN_C
6g)E;-77E9L.RD]+Y,?CRX.;<31>:Xe@LK7-9X]Rc;)VJ05L7Q4M&_GP/?B8._eA
VSMP(?SQG<b[Z0QH&2Ze+dQN4?6;3D>-K,#/<PDM]:dVT4XP(]O[SC65K)+fH:dB
,[?)aI#f^?L1Lb<S>,N=FWa<X0?Q[_GAU=J<a.R5e=gNT3ed>7VW-T3=e/?]#QHK
XU,&(JbN9=8#7.<?J8=\Y#:[gdTCg9?&]C-;2U=-)d.2Y92_=9V7dHXJ/A);Z,Ee
ST2f7T)cOb_a:5(6R3F5.T1<C+XZ))P<Ned(QdL3ce/X]dBO=,:a6>[.D.:,,\Cd
D)a?JcOZ11C<<b]M1g4R^O510IU1RDH=aEV[<14@.][gLK^bC==;gAVK[ZN2V_]B
]S&02UOR;A)_<?Dc:<Ye(CVQCQ86,A.)=G?J16?5cXCO.e;Ha(NP.C:_<+/HP\:E
=C=;_JT:@Rd\L2DZ43JCId),QC8)6F<d>]VGg:X<:U5XKMG(/S7>:8>KB].OL3<:
I24:BA],X)U,JV,c-YF]aX-XNSLaHTeG0O7I0L08Qa\<JdK?D^4.Fd&JQ/CYa6=S
IIZUB:6P_CV0MO1FgbOB@+)@)HF5ad??,NH3dB(Yd0aJ23(F.)OVS=F;ESf&VW?(
72J37Xd8?VRWM[Y+I8W?FMMC1G<H=T\H=DNQRWgOJfFA80,0W?,T4TEX5?7ONBZb
7aG?SM1.VHf1P+E)-NC/&XGVFg78[BFU_-FCMc_J]PC7;ATf#K^^1KH4JOO+FH(2
V9HBLD0(b1U[#b&5dEK10;>LIF?C).;NTcIfB,?IV^\M;JXGfE\eGMGfWD?,#/X,
d:3,+P[)/9g]Ca8Ec&=5.8JP_c_@ISW;AeT2O<BEZY=F?CIR-Hfafg3G^\D-_;BV
fQ(4&=19(?H5KY=^)=8TF1P4//:P0Kae)IZY[cLCT@XEMSSRGOgB\IJf/0SG>S83
P=C,O&Ob>^dV)@I]URF3B54A00#1KR/DOE=g&3V.[Z8?c/@C?QY@^bCHS7CN<f_Z
EGBHE4S^EbR4YPMG9SO5da@/_<MPgQYgJ[PIKgf(R+W(RW>>4gPJD>[KaPHVLg)Q
[fKKPNO:;8O7Q>@>5OX7W/<-3V//O1;7F8N&-&.QXU_]S^1;DVFO<]#2Ze,)WJfJ
6P>NE:dCVeP.Y7UXA9_B-[LIaKWH]f;6F2/Z0=TMD2N#NZA<K/+d67/H\(E88F;a
9R0WMR1;Q=4VdE6f8Y(HIT:(_MdA)(&N7H4E>_(V^BQ6;f]UE:/G+JM>FfeDe>2N
ECU0VA6e^gCbe9,J<E4)OeW=G70#HWYKaA6&]0Y:>J(/IJ;>059QgSN6F8[C#LWQ
?69+;4N@P_2Ob]/G<c6WBQ2\+P_]N>64.=5U&g@O/+LM>GT,ND<d.NUg:CJCB#\8
[]NVC2TbV^-Ba5IC,X1);BC=Z)<gDfEI-H;g;GHU(6P_X<;Y1&4EU[7.C8:NgM&8
I#;FGS2cX<IX^#=[8?..b&H];2DFdfGNYf.DJ?IKb1dIFCf(L90Ec#]D&]--JJ?c
RF>@O)43=0E+4F=E4)f5_aDV/[aTUR=[M9P77V.V,Lc^J(>/5E^gSL0gdb56BM9Y
.X@_ZAKZ-0J?5#eX[ReT<\E92WA,0:Te[(IGDX0dbMMTb02P/3C(g=7Q30]N:W[/
^LCb?Ze=ED?.1Y.U5O=gecgKF=VKf8SfPB9MDHYEe)J5BZ=58HXMDB]^G=5>Z7@8
WGTg/^II2cP92ER7K+eX>gH5.1\&B),ba>EF#8b=E]3bAYM=\[:Wd6LeM-f0?09H
)CL25]LSHP5Fc8[;,d\F1>6DVU8+CIH,0PP&6a\:R-RdJ(F>QH18M3O5A\P<>QKf
bU0c]/)Q,6gU_c//VK:afL1B,/O:P)dU#X\HR,:Zc5Y1dV(W->V.:&.V9-ag&J6A
NL]JYU-8.Q.]>Y>3+K^N=V#(/H40XT(X6/^V/K243LK/9B7c);>IP,YFd0-)^9LX
b.;D:W=14ZCD2FAU@&-#2C>VI@L+((S7_,403AD_fO8<fR5M.LPa6WW[aU=5B#/=
7fe\BKecLZe(K-O#X5=:7IR05geQ&VZ-/BA&V02705c_fH=\9dfZ[L6(K=J.(+CG
TT\_2,<:L1GM(\8@&@0(^IA&SQ28./ZAW:):J8]DEU;@cd>4a7TfM0\;_cWB>.S/
4#5631GK0UPE)(O6(NdWb#TcYKHDR,AJA78:=+IP56JNX->.TKSPBa3fFe&1)GXc
b&GO8f4\X::)TbH[E2NAMf+9SM(=W)YPa@3D6d=K::3WZ]81]<\>f(E,b]JdEI8_
G@?I<KS.AK6^Se#9S+V>Ebf\_-,IJL=f6XDV?cfN1e<9dYgM--1L8,Y5>(U@U+=J
+G&c_VAHEBCHeDe@0gQDF7E9R2B4;J[1dUNa:;=dNO0?fd64:74a/9JJSJNe9[.;
ID10dA<VEg)(SDR=P-AU4f;IV<@GK7-Z&9+GD7V[d.M:NNcE#Q39)JH+Z&F#N#FS
_c2A.^AJCg:f+5[6DY(,DU_?+d&<bB?QTeU#>39F;;L=YSIfe&,+ETQA.M=K;X&O
bC,MIDXM)G,>7bEDWTc\&gO.4(OJ>N2,XJ.WPc^_ZT3dfXF?K,=Y1e&JWL0_1LU@
]1P^P8C[BS;IP/[d[YG_@\?/Q[C&MD78YX=dVC(UV3/cA#\J_<[EMfb,5[(<dBA-
]L,_DHaZfd7@1;QE3b+0/X5?Tg0\HT>gA08EA6K#c/V#3KC/aBQa>//^2f_Z#FY^
[a?5f)4J\U_]=PDRJ<&eB3O8PIK9=O=SdZDbX&4e+/fWA:QV,KSCG)D,460/,JO^
(KbV8&fSN^a&/\\<B]^<4P]2@8g2?\))Y@&K\LK]?H=>g+W[OP)<E+DVD,#cVTe@
-P0,)dSRPQOWcI)PN1O<3I902bR1,;,;\_NK?Eg\X1\600I=#<EDTII+]ARfQBXO
4JU3DCXR=KT1aX,WU]-BF^fK17[ffAL=7]LF8Z_<>]\K2[6KMCH&,NEVbK4ZN43T
8A/L8XT(SbWXg1W-T(S3B1?_=UM,FN0.4L1gC8PdJ<>gVPM<7-^7^S@LOdbL;?=\
BCMb.@XE2ZQ7;+>CaV>ZY2PYAMODTVG4S^E[JJYH[[5<RCY5SO4#\bX3cTD_985a
9>\W^d,U2f+SBNB)OVN+\M^K:2Z2a(&5D>E.UVG@S3&A]5F]Q@,QBA[@MH=U:=9a
bYe0?6)I5VHg.^4NULQMSE8BL-bG+R8GK&990T>-H/2BW^2@4[_@CAN>]@.-T?.b
TPSe/AVSeF-&<E,#SAWFCF0S\XJ^@Fg/MO:UN/f^2Q1Oca.cO7\8]+?B)-eLF(PZ
69JI,X7a<[>aO,^\<0OT8A0Y<bg]Q5aA.JHQ?<7OLB4VOb_@KTaL>I0cD,#;<]eR
Ud,Ie#XC;.7UXZMHFW0ODUfKKGgVCP@RY0E=R@&bf-APXHQ-Vc/OQL8<+Y0OTG3=
RR7+O;,O/Iab5R:9R/b<BcI;b-+;:7Gd+1U7^V:B2fRZZ)b.GG;)bX\+E-44PSc.
1Y-8e9b((P=3R]<UEYZ<&?)JV]9bb9.Tg=QIgZF201).4-+)6PBW0S+>&_e;HgS1
7f68_,3U,>@KAR03V:-)_J&TfAF<abQOL5>NH3M+)IBCA)]fKe&d=:@Q^c6D>O4T
@/@e0HAJ<T@M(c#^e.QJ3IT^\7g?F4]B^&(4&eI(gb\0=M=T4HdCJ=QWI7b\)S.K
#6^QK&cU@TIX]f5WV#QbDW:S(9EI\MQD@O0P4e2Eg(;TX/2/0Tb7Z6IU()0-:=Z\
W0\L1@bJUZRRONd;SGgAE554]YI=D4dZcM>VdU?SgF1=2V7G5;FS@(6-cTEGMXL@
gd(GWWRW3V?>_.7;a+\EC_>fR2[0H8PG0H)KLbb^\,VT\;0,V6#1_Z<^;ddH\COf
=,IF?Y9R_F?56WOQfaJEa;CIXaW?8DQ+D44O;DPX#I3Z<;RK4^CX]P^aSF[UXL^U
)9Z&A=bSU04O(65-5S2f=;:C/=7-de,/2KVO(gQ?V=Jg&Q+HX)8W;.0Vd1IDG.Bd
<,9F>97R];4CT;(C)fWe=D>+SXcB<fV]++\973FR>\N)A^g9,LfT6+UL^K.1d8&O
,\]a79P[aa=8Y4\<.IJC\KTZNDNR971^?OFBAb[T&f5^gFR)2JG0>#7I1041PcfF
=FdF[7-.OagVGD+:CfMe?Ea7,6AC2MZEEb0X=1=#\^\NG0D,bT/K43BK?KQ18OQH
YcGX=JaN(aW<d>A6</BT,adDa8@MP5F#/C>;R,FWIP]a>-I0N&1gLcWA:dBCLCQM
.C&I9;@9DK2>0JDC^cAb6^L,C/()TM06W(V0_,;.Eb+U]7IaLH48>Z]MH88;DKEO
AKI?6dHSSDA?9)&TJN_[gd@OJ+_eXZ[b4EBbfL2NPXbI#TM^-[2@Q3SH5O9cPZb7
U?W.B<?4GS>0Tf?S46@Df(#)DaG-eHO.GQf<1e7/#]-9fB_dH70)3K<5?IJMRS.P
K@A4N^0g6JgMaB(YKTP5DG<;IF&2#A;&J#N0,:/BX_Jbe-d6^G0G]&]>]Kg01]]<
EI2WbD4Vca7V0dNNTbT0>E-GL76_CTR5.M_3Z^D&)ae50C\E_c^6=Wa^L]-\aBb(
([9B&4]F)D5>RN;cOMaC?O),;SS9/M<#5U;:f(Vae-LR+XPGL#8e;7TgXJ==IHIN
gc&D,Y(,/?BZ:>F^bfS?Z2:WAN#^D3/EHbDHPdYP2d&d/QC#gF(RI7TBV&MKaD.g
3-VNYgS0EeT8eF_+O15^fD_[.Z,^CJ>.FKMRb<dG9A?U?,;WB5:J?2H+IgL,>_g5
b7>/0N##1VC#4&Y-P]W,^\WQe;)HN>]:9\&dTTT;F+=W?XC_O)B>&B3&,02A)DNU
=1Vf<GDHBPd-M<_DA,A2MDQgJ7d[Kb\[^;^YU/X>(XgOZbVc,d^3dXEe,F<f=^d\
5=_;P4dDB)F\cKGU;1XP6:KU,/3eBW1KcK]K0>4+@52THQQBX=/Y(SK2JMRF>X::
7F>MUTH=+H\aZC3[abO@5=/b&5TNgBG4V>).=@BV3Ub.OF7:aP;NaNK^)(H0,2@O
DI>T]M6.e76Xf&7(_MV-P>]8Ve/3#9)3>SAXC8[=93a>V4AXR(=UL)V??O#=Y_6O
g#XLK+]E6C<-U6_=S.@X=C@VZFD46DOcc1&/dQaNI4B[1NBb)3J2]JSE:UOe-?]6
_I)+U[+e8^/++GL/+_dP@JTH/,G>57.>[>&5dMf&A4(]#<PF[?/S_.e2(0.M5.?V
OLPd^2X7]PQVI7TYU9=[-HH.79g:gY#K@,+BS@b#0Q?<+aK(8&_>KSU4Y^7UU2;b
)PJUI((]fC1,?+H@BB/^[E>&4+;4>AA/dOgNc(?G(\A[R#CASH^9BcYD_7@7fL-F
)[e@:dJHRK7a:YX0,P&eW(4]K9,7?:dTac[1ZRP,+V[A(bZWE.8C5gRdGLO&WH7W
c//M87eeF(&IO[@<6CPX,K70[EJd:CM\J67_gFW<+#5c_fK14f/LMNfYM&7SLdg9
MKT^CY7dD4,HA6DY\N/;NZ#D\601:]@PAVb9QaNaP#;MFP5V<0cOM6Fc[5RKPaZ\
1O+RSGRd&4]:CXaa_Ma,QH6T^5L]c4;A?U96-KZ@=(D_._VJQG@H<IME<a:=0+ET
eK79J-5PG\1?:;/?fX6<)_Z+fAQ3d&2H5TCbY8F_HKc)8g/;fD/cZR_^FXR>=I9E
_0FUIJCFDA;\#Tg_GY49Vc&5+a1F-<.XU2(\X3T(QdML.13_,91+f\B#@;\=JZI5
dN\>DQ<<2UO:)Dg&5[I&A)YB.HJe_,dX:M1M=H0c)GZ1EQM55KCeMP\0<:Fg6RT+
EdA4.TVR\8>:<gEDK]1+?eAS4-\Z27,?(,HGQ2aX&75aKSMCJB?a^\\J65OTQ(,N
MYHL=f6)bf36W>DV\B_X8FTHH5Mg8,+,I@b,VN\bgJ4fM5=]O.:1O)1ES/PGDa?E
8M3K=YS:BB#ECM^WW1O?,D,JVLW2d2]XFM:dg/FTI)]SGGZb1[9:_7O<)0O)b)_G
WHIESJa]UH&Y7Q=Y1#00OD#S=:d2RWD-^R<6TfE&@2(;^5\=MFME6cARH#QH24SS
_,(d7]M?PQ?8&@UO]FAd6/L#J@cMP4-\PU3c[339/O/#a/Veg#IRJ9Xf2PR_dbgI
HOS1HFgLHU.#CCYZF8AG2SY@Y,5aK.dJ)5e[3;SNV/TaP5,>7:N47cSJ1+>B;TL.
\AO5=[,Je>,SH]83a:18f@Z8dCPcWKEL\bE4I<CdGIe<^\-^CbaC\,4QZGX=bB:^
D5O@OQN_-RPQ=XC+M#>&2)\O@<f\-=fW&C.2I8TWgNO3[1FO<3I+&?g=X>eD0Kb6
V1F/V>+NCg0:M/MSe5:2TH:<)-=(dFQQB7fAC<CXaHOg9SF4=@@ESY?E4WcK.X=d
<C]F3?JRCE8.5BQE^TCN-f3NCOG/,V)Y/I)-EKEabD]6/gNMEJ]FaE[(_1[gN3DT
&4)A?>:(\]65f.0FFY)#cK1L&_P]4c0:=Y9d,:MPM<d\]OBf/_0>8CQ1UUVE_d0f
B\RTgCS5(G2J^,EG7J:+]5+:1DJa)Q,ZVGb9a1dY)c[,FQYW7ZZHe3b-Cg\-GNC<
b<DM5[\7P=[\,-EU8;36dG8gN70_2\B=VGKW?-C&RR?V[97/PRQU0aH^[J4)9?-)
>I#3,+DYA-)J>3PIS^d;T&gM_.+2^D5IbA-&O\61>W9XGSC[KPI0@16c#.>5O)/)
T(_2(1@SYK05W\L\0ML=<fG4/WYH<U+@^83fa3?C>>dd&EIVH[NB/M?+_b:(&V.O
W7PVO=X_8,:c:7\&;TUB+?T8g()M8G4dUHf-6=(5W+Q.RK15<?C-.(1?/g_FKGbM
^C);_BFCQ>(WT,&#\5P):^M_:OLdAObY??VJgd[I3,_)\XaZF842=2DG=M.0?-#.
_9R:@10N\2O8<7EUOZ4^G(Y)&7@),g+VCT2(S2UOWg[P9fbNa81dbFUI>^PaQ\/\
2Z7eHRJ<FLa\dc)2?06NAc72,-EPWeYEVdE4,XPT<_eFQ;L,gVc.MV0Yce)NX0[/
ON,NR(,240X3:dUPM;I-8e?0B3-eZVA=+C-8-_JR7aM3G>EHEUdOR<1[K/\1GYI#
_3A2g9?e4D@72^L4d4L6D@M+2;N(ANFB#9Wg\VD7R>54XMB0>d3]D#g3FPKBB:N0
;FO30Ed(dT&GF]<KSd>10R:,a:KC>#<44D/1MQN6UF0/#A]CA7V4==_gT)(g5Q8=
Ha]/b?;9-_baX)4WRV#WRe;TOSfdR;N/AN)M-V,D#BV[PA;9NdTL<CX?X,^>cAa[
Z:bAR\3XP2VMUdS#\VLS;/CQ8B<bP&=\C#d9:eAHa0S>@OUT-D,NF6/=dXTHg8<5
C(2g@b+3EQV0-dd2-RMb>71a6=H+6XW\/JfH#BOPM_,MQEO_GH4/_(Y1NJTDg0,7
8KP7bbOA^H0R)#TK^(JAdgR-PGS+.W?M#-_+P8@K5Q1aDBN>gARP38M-Nc?;d#U<
0E?2(,4cGQSaME=,PgJ@V,YZ_PR#L\a5C/dL7U]V;_JW)[&-U8F\ZR23OKWX@O=]
:>X?He<^TT67J/F#2DB\RFGD5R13+/1_Z?;LRfDK6TLBP3>N42Q(Fe?AL\HO8efM
53FLYXRM@8L0T/A>CMd@N2P6ZG:E.\MG3N#4>;+(_3PTVa_@a::/T<Cd+NX.8O<H
Mf).7Vg]Z:HG34]-.&_QW2,P>cMbOAFN-+V<.+_<M-ETAOa=bKMM(R,Z3F[a_#X:
-W8B7cBfXR\_SE&5aY;Y==)cXVX@gHfe;@N#J,6RbKWHcN)7-_<8+.D&3<5UGYQY
/0)337J><c2@e(.fI]3OaPVbV/)BADLaS95]I+(YCEgX,ZcV=^Ia/V4d;8U#5-QZ
gPEg)J5R]UT7DYX,Q(\21c8XNX#-;H)P>/2PQ>J,g=7R-g^R9aaNJUN#<S3^;KVE
LBB_M&VGMV7@O^AH<dBaIOK(GUfb+9-:6XN]GQ_VYaP+ESdPG6V(-<ZfB9(Z_.&F
A_,OTJLG>2\\7C8>9V<]FZ9CN0Z6(PA]#\(M)=_YLFH?a&Mg;[N;+-P0YeE^SY=B
E?4W9/2XP[0/_9RC:S?IagIY#S7J63_OTG<=M4&eB0(B[P)6W?:U8XX<_[MM4R&4
+gI2f(?bO9L4JIR^a;[/dJ2EMdF<QYU@X?/B[LK6SY)2<-A-_6P(I-H.7J&[49S>
\L?_VbBT6(:8gSfZb-+4Zcbb2R4I:J,c+@Z2\&9W2>;;X-IG91U37E@FI4YGC(RL
W1#H9eBF[BXLWVA-QI+Z<?Fb0#8IF-\X6a\FTW.f[c_fH#()>ffTH3@>2]];,-=H
M\7&fGeG7(R0_X[,NSC:3e/+S5<\CdJNdcC6,VO@>ReWd?[MPE5a6AVM^\F]Y<Y^
>8dRH9Z^cGNM\g)1#QBe)PDfbf1a],P@gW)[A4>ca&ZKOT-c>:9Q:]ZMS_f&)H:[
C]5f&93L-#P.<b?:^?2&T#L]HFHN-8dQ@9aU+(V^M:#]XWI6B4)DMCP2[^&&Q1.)
I+b@VDVaNHA4&9;=[#XfOFbNFNE5N>K.\6NNBg)O>V;c7G\8/?GMa(Rg#@Wd=IJf
W[R<YA\]@7-Y1O(NF7Og-6KS_Q?@=?HMX:P#\9b3Q39P1a,FfGOC0a:fJGUBTIRJ
Q[^G8S]3<Ed5/T]\0Nd?9_-ZISG>UC(/E??(8-4B>6V)1?[A42FNUZ0/L?JaM.Q2
/0X]?c4NX2^fc:e;[b6EN5WQb>Nd\Le<TEON;XU,GL1,,M@\1-E[O1;^c+62>6)V
&(ET:<D;>>X6[#&,GacP(JVcD4&9VAUYQ;eH[a<+Ea(2c]AC>-MLeW>O&,Bc#MU9
6)P;E#\5FDS4)7K_GT:1[)#VTVg5a+02,[SHOO15b9bdgC&]1Q4&YF-bN<f>TW&f
?e/5507W;4J2;_bB_-;aJZQTVUAeWe?:O:2,GOAD=3F0K[OZJ>GUa.XeR&J>Y2QF
G<L\,JaMF_3@EgFW\X55BeRVS-VEf4Z5A\:/8NFPYgD(3_@,?TBL0/ON9PKAF4T4
O\0_V2UZ;6S6OGUFd;25_M6QI8WSEAASGN>cGc1g7,b1D7]]5>H<Ve[2<d/UKB02
<)+eXXg+RQ6_U27.HW-S:UCV<a1Se<68;H>_&S^,&SdOO/G@Z.23MWD/1g<-+#]=
#7@b\>2IQJ;Ecf7Z2ZF1c4YZ0VBM8R2M32K#@^:Pe0/QG:F<4-Bcb3NcIZKc]=Oa
,S1Sb&H5e)H.GF92F]eR?eC:M,g5V-\E+HBT0>@4Fa=S,B(_@1[_+/LX991cOFXf
7I=3VF\C[:7+>[\HLTK^=&5R]ZXHJJ_/XOd0#Q;YMbOd@e;(,/a[F(M]cA,51.EG
TFC0Q>3bA3WF@L(>Mg\09I\O4DT53326GC.Z^,.JI@C#YF5\@B)g&T9,J8@ZQaG3
gf;E8.6IFbHeeA#O)dCG>SM>UFWGPD4b>.,T@P1551ZKc7?#Ybe,aJ<@L@A>/IDN
F^N).Lf9DEF.D=#56a.bS4fT6=3[A7+E5=7agTM66]HEQK_SL,BB@]NcCcT:G_X@
E10@B+XS?g17g&?C=3\Y,=^>g5UB)-4f0S+9.JQ=>?(+Bdg;FKMXW^:g.221>VJ7
<BE=d+V(IUP1I#f=@Rea[3WaU6Yc-@V8U,PBcN]d@G0?-WQ_JdC]X2]SELDZIERX
+YXO5QR/690-J+,DRWW#V?ANfZTVRHf?L3eM]=-GYT#Z<e&A82V48ZMDUQQffP5e
J74HPT+MQFd70ODB10PYM)9RACeMN1Xff3>g)UP8,)fJ46bH]g&/Md2V:VUZ&;7@
<0Td=>IYSCE6fPe,J,aM<1c>-M0)6c.b0+Y;?7b4IGLA:=3(#+bgR=d,Gc80OBPE
GeD7bHSbKXOGE]4PLJe(]ca;<X#dD,RU^J;R_Y5&>e9I&U_B:ZD7-M#.H4E#1O/C
WK[U6ZI-DK2?FVgPf,T3?6D1O]-/TbOdc2T:O;1fOU(QbN8HCcf?9:4cdd^@M/a_
9A6R77NILRbWLL/,-\F[NBaZ+(,@edHTd]7EXYKHbJ3<=6];>7/P.P]J5-a>\VS[
eX/WQT9?GDcGL>BPLLfKX]2bIEB9/&X9XHL,[LaQEVWMBfD/1RDD;W-WM1?RZO.L
:Xg:Gf)2+&HUa1d&5dTZW#./H?Y76WNW6d9]@V/>f-K;5\QgWFH(a/>bfDO<9LVd
(G4g\OF^a:T[(=--9JfcQ\WN\-RQ3R_XWP&7VY_;N/]V-;_-3_J0gG4K4^?6e\2;
6.Wa8e^5WV6L39CA3G@-LI>Z0A(_P)@c6YCb_&FHeA0ME.93<g2:c^R77J\A<(]\
4K2ZQ1fc_9QI^3=G5]:,5Q=P02Z8D4e>O\CN.LJDKdd=2&PJF/]N/Jf4>GXD7GQU
W2T8aO>E4XYWSMK=QT#O?U7V-Y8)TM/RSPAcg<T#QC^+PCbBAT,O-GMS\.-?V07\
N&HMcN8T<+g&,KFHR0M]Z;ROEbOQW,ZCR,P+WX00I9&)1(QI>LYO.f9&8/fe^U+\
bBM9WP:Q7R_aRc74#\.#IHDXTb9OLV<Xd<g,W]XWH6]UZ<CBQU]Y26,]S=F#4I+2
/I2SXWF-9;bg)1I7\RV;c@9;aX?LVfV9MKHT646A9LA?=ST,[7cM0U<U&OXZNECI
3=S/BUQF;U2GEJPAgC4_5YQ_8ZOT#+YPBFZO[4,Hb^_[&M0P3LEfR.a35OQ;WU()
S4V&;/MP(J9Pc-feG4BM6&f]O(7KDV+eXFPa5T6g@4U(3,g3]5c?+&f.IK2)G9-H
W,R4-#&2M<SX.4DZ??-W&5)1&&e^DG#95@bfQB#:7BG5@&Gcc4]6<ZIe#cN7=gbd
]79T\g_/3Hdd=]I2P#,AbLLVb]f[b:QP)6dTg[;J9BL=FL_PDX]e>LG\@QL-Y:8J
aO,;+ca3BGL/,+Z>K5VX\2.9M[SY]RQ]:3#EYV6T0\g2W-5L.8O;=g.3VZJc0Q9b
PZP\McbB,G&T,aZb)N\I/6cXWcK^>XOAJNI2#QgDXfF>FJM\c^g>T)W0A:3&)38L
[a(:=/=[FCQ-0[:7=_F1+V3_WC+GTN417+Zd(J>-4<+;DLeIP::)0CVO9[]8/6Z&
N\E+]T[966UXfI0#T5g-D^7^e-_33Q[^UK]:T)R>+/ETPL6<R7V,&,^2@9Q^#9[R
J:4YG;a-:J;L&U3\3\4N+Ad[PeGS2]W5HNZ8/(,/UYFSNNAIPS5HdfDOBF8bR8-A
,1+;Z/-7]#>(YF]J0/R?RMXd/]<QV\GN19&[4CUL]NF2,#WAZ862([VM<c]0e-NI
&[BN6Hc8DfZ=\_60Q^BLJU-O>S(eWP#TNJAdUc\A[f[13C7<cP]5e<;4D-V,e;,F
aJ3VT,EDF8+78g;66VN]aSAR<M0I3]f6O]@gcE#+5[UTaKbUF,I-8:-87aQK59\)
VFIbAVB-68N76[3,8d5T^89Z.JD)M.P_U4UTPf&b@>@.J_2:DC0MYL:M6W>6A1;&
\8:/WB4-EQJb.\00KYb@DN8)(BQ7GJ?K+g>/32)<UI>-7<P^/;N#-KQ1]M2T;9>c
,[28<#0MFNc1N)#OTMI-JGM2T/=)L1^<Q[e:J#-H)#^A7(:7I6b]^KM.H6d85K;Q
C?^(FD?2>Tf.OJga\FJEVG/7MZP=f+1:^+).#8,P1,U1[3=9>2A:<Tce^Z.W1d;J
fKO7#:]_PWfacZR+QY1>73DPGH0<cEJ^A.ZbCL4ScO@1aLJ7YJA9XDYa;AMXY_7Q
BJ[N+Y4T4U=2bG15U-4/.?X7Td,-bfe.[&Fc#\</CJ/a?>R9LEIb#=_U=eN6YTS;
)6c8?6N\FB)M9ZFS2MR(,7@FL#?(AEK2HeG:4b:KZc\T/49F@afBM^.OF&SCNDY1
#AP01)dICdZP3d8O0AO7d[K4,6\LM,XRAMf(3=PSDRF6#L0DMegSg#f9=6>c#C<5
E:FVQCIdKWgM9HW;c7>bAI(I.dK,JU&&WQSTg=/T<gDUVbH2@&0MD5YJ,P8&fM@4
^=.6&J7.>,+R?gT+bOB):<O;b3\Y_1(4<K5@)e=5JfTa3b8A35:O=_68T:.N>4A[
c#PXIW#_N4ZX(@CSb8eR]cXYHQ\aFaD7=3+NYF[7J9>c8\79I/I]&+23NXe3@^<L
McX6Oc-X7TISbNI>5K:E7@Y3IUMTK.RK;GDY=g^H)E+WUM4.P+Y[3(1JXTA:3C@+
]YD9N+,+\g)g5(_S(Q;Nb=@Adf<,74V/-+SaB0/A;<F?g<6K1UX(WO^g:_/?L-OL
I.g5N;0FIT&P+Acc;;L5eC;VT6TX<:1aVE6.R(J@,SWb12@bNQQJ8=_#D1\1HcL3
(X5/N)?F#-O)@^c9Sf4GYZGR_..]C@03Z_#X+;I>LDEY[TH3K2H)RdIU8IV2b/]D
T7R,,ATIae[NE@_0aD+.@T+8H3]f;Wd?HAaY;,Y>E=J4BNd>]([BR7\Y:\C@OMZ.
>V8U:;0-14=M?bT32BVAFB8IMD;B+g,Y&?eG,U13@]E;/GPP2-HTXF4ad&;1[K>U
3/RW?H,aQ:<X>7A8T,Z#g?&c?Yf\W@:U3([J.=9PHUd)&07&?/1b1I_-7E<Y<3,e
0B.EeS5MDHRDFg<EM:a(Q;RJV5O)DP-c42VPY5Tc.8TM40WSJK&ARW_\8U=DAfg1
DP+XUC/1e>G&9\DUUGG<(891QZ&AUFW6O#7_-I-WAQTEY4(_Y=b#Q(0P&\IO69=8
WWSZ3Q&^9^)1XXZ4N]>R8aJ2b/d3N?.)/fM@+LH2d=T&DVG3C_ObgTB_8XE1<9>c
YGPRUC?fc(RZR<X=)Rfg:ac?;R[M+gK]^fMY-+3b1e<Q:?9ALSf1;EJ/BNYJ@6;W
B>:OQc(^UFGgeA1I]X\Q=\68TC[]CSJ?C6#6]e7SVeW\D-GY4?6/Oe6XOI)=Za4^
>\OU#ff50T=@0@MV9P1dI/C1+W0AcIg-V6/32SK6K/:41cH\YMBV#-[e1[2FE(<5
8=9]SLE_8??>-3T8Hg?\c+I2JYHFOK@M+JIX_U^U77J+Ef-Ug]=B=1LF/fe>-+#5
T4I\H33Ye2ge(>PG4WG[[9)CKMN2+FE/2XA?FEQJaML\74/5P74g4GN2I[./e@e:
-1eBJ72Kf[TDJT^?-2Jf-J(.;e3Q.U;OV,g)KfX2O;@Dag-D]L558@<6bCP/<>##
9L24a>gWITO=I4\/OR0.O>2:)F)b/d7eY,C_LBGePP_+N.9;VIRP-(@=<>adV<>/
[1.,?#UO(XQ;-/2Vb\6&;HOcZaHR;FDXd:5ZW4>>WL1/JM;;Z-V-6GW/AE-HE-;7
4S=\DA#^3K0Sf6;910_719.T^H4^R-Jd\KCFK8@>M,dB/VN5J8SO9VNd61\T7QDK
//&ZR9#_8QGL^/?K=;MG.R8fP\;1[H>U<;@OLS.bDD&)[<dGf[.Z9McOFL7@U>B[
3NKHTO-V7[H[+Y8\aabeZ0La=1C^Z7D+TL<BN]190-dG2X42_S\,OJ)][d@6SA]1
F].2NTN&DE4OK#&Ab40E<--YUM&OA)RUMG6dLG,R^fFgeN+gG;,L9Y77/&V^XRYU
\YQDKNcD9M8&ePDD?S9PUY=BVN0ZK[f-DWXB\C/^O754(/RR[M-W,9G[//G<R&-X
4A.&a+:fC.?4eJ5P3E9>XW+IN#f4.8(5Z#^3Kf?T/VV8.M4K;+88[NP_[e6Rfb:b
JME1FBY&Bd<4#RWM1<URBU?H..fF)BJ@(;YN@34;2YCD6[?2/KI)DcZ#QfO6_dGW
O9QTKP?c\,29Q4GQfF^0<@.B9S39aVN5bOJG?+JZC^-LB;+ROa+\C7?1JK<O4<.?
TU/;,ZScbKJXGKc\d;dM.N+Ya1abXS=OcT38gBPdNX?_SFKL-V_5GHVf[W+a.?Xa
c,_^_Q7C,F>O/LJW?09fLLgRZgc&A(NU-I]7Rg^KY91KW-P@_APX2Ue73g0TGD8R
@R/[C3(1-(:>.eeM>T@Ef<]dL9]9JdI[7O<J_Q^gVfIIY;XHV#XZ;1HK>FWE[S3I
UaQ#O[X7\_Z_7HU)?^GV2Y&IDXEbbM^270O&^]bOIY/M>Q^3V<>A]A0[-:Rc1,5(
[=9MI3V+OaE52[-D8TSZbR?;\0JE;TDf+1HBR[>[PEYO+0bZ3aNe]5Q>GIDK=@aC
3FD2#e[NFT-d2=+g9;-07,.>()6(MW_@cVCV)Q>_Z<Fe5)35B,VaGb>F(?AF\HJU
Fa_W\MCUIJAfV)[1DB[9/<N(<#?\C<2OI#0?#e5_;,;ZO&[LM8]f-a(T\RC51[+d
NLKTLMdPR==.TO>].;ZOK]fP5R+@8^)N>fQW/QAeD9cXV&6\-GL.FISS#[I&5T4D
PKE8gTGI#-^HfM&CZc+Y3#cNGWg_/VAZ=U7d3XF6O0<K:_0Z>XfURY5CVB-\IJC#
;bg./UTM/bM4_X7a:#JgI_UdbTJQM>),UZ7@/6ZdF^CSg4]^_ZUEDMJTOF4fK;X2
@3baY[I5..I<DSEO^[3Me&/)VT-eNL+\L7-VgH\eM]0\1e@2(0T5MN7F18c>Kd>-
Ib\#L/W\T3F)??&eLUWALQM#f#(,BWcN5g-0K.0>-ZA>Aa3C##&XSNKSKf.=&P.4
QX5JO+6I2PO^=[:LY4)LE1-T5>Za38L-<eIJ;(0=Pe.PEV_eea@NVeWQL+RI9a+Y
+X=X>ff=.4N61;S^9a=JF@b56ZB-\YE\4A2@W&,ZeUE8[I4QS923#Y_]3[M529JG
?<MEV\EH6f.&HIfHOWEPUcH+:J5)@NMLaWZ:#afW=J5S0GTI2L/1\\29]&F&5WLV
E9KRC(K,@[cVLDILX1R46AG,V7>T;I4ff&ARQ+<<^FW:PE[]?g,0L7=4=OfPbA2#
M5+7.dUfIMV/Cb3#/bgc5=9d0VM:4H+cgcRJIB6@J=<37b._&(#((^K:S9b,5].1
B5#>TT>U<X@2D]PT#WX]RN[Kd(A53M;O1PH@01_AI=M5gHFg\\5Ma7]TAAL+d]&f
\fc1W09)bA>A1J[YCPd[I,8Z?[W_dG\):NG7cK?Q[[ZeaL][OAJg:?fVTA:JZC/c
?@+c)WA&04a1VAZ+ObN:NcgA3>?7Z^D<2I;5G&T:1N,VJHfE=)8O;Z0S=N6_9V^.
;LF5E->H,AcgN:F=L+HUAD+8(-NH_?Z,/[_0F.:>#,N&eD&UO0M13ODC:)0Q9+_9
Y2(6D9^e7a05PUPAN7)N=0H>d#G8^ZN</Yg(&JIb0eEega#T&8TQ0(D>1SBYReBC
4bIA/@OH1=d<=WZ_;bR:P7A<a1PgV^^H0G;9\\P7]>BX;8ERO)N8OMbc+U4f]ONG
OK#Wd1KRR@PI2_&2>76S^A?b.JT36#3U-Z(SS//HGF<[baJLE(JgcC&7G7_,(,L_
Ec([E0YT2fMd4fcg5X_.?2BHZ2&Td5REDW;UJ&:O7VP&QLHJN1g95/#a2ZF1FVOO
@SXF<0//8VRV2e0agb+>F:Tfc8DGN@7[fX4c?2A/JE4)2^LG9fZTV,f-J2UM62X;
8//PQYP<RaDXc7LB&6)KBbW+Na7YW\A,5OJ=Q/AA2)g+a?g_D+c:MN/J5SGJNaD=
E;7(Y2-]J@[UR-RP)=>JdE[/FY4fE.\b5eXJ/F3a<KY[87.f\T&&/D<:EW.=bdXY
C@-BT;WSLUY>gFI6E^@1_PNTPb\2EYgC=P.8?838Y5#WGQb-&TG[YgO31_&BA@2W
\aDVB+[/:ZSG=?<@[e1YO@gN==>_9ZcSW6ZHBKVUML8YJPb0[[Neg2(6(;T&F68C
W0GE3&c>6M0.[[R0K1?;e#@CB^][NZB\bIG+6P2YRM/e+6O/f,ILaL<T(K148;[b
;QQ]CX\dH:<74a3AKecc>I+9cCI&2L306N32;OSbJP9ZY;CJW9^Bfd@G(420];c6
5WE<P8N)X&Y3:CKS7<09^DD;^6CIZ)4^QdUKG#60KGW>._N^LB)EVXZ=D,A7a3S;
bOT&bKC2=ObNJDRRb4C3#?Z3YAKR)H.#),5+,)1;0fFHDW:Z]7UU58U>(JgSX.>f
=B4fH)_dgeTIR?RH(0)fCADZ<:?=SU0eQ0P[U.>Qe@X,VK:&;6dWgR([.+D&L>(I
a@W=[;R_@=DH@)dK0)A/:O&a7^\_EGT=C2WQUAY1Sc]g6^4[):.a5#CPbUX6[JD8
=3bT2E:e7>4Xd#)Ka#DZ9]L#+J>?DGOMQ,NWc3P=,MKU(SQfDG8e[DHV@<W>E>[Q
&.?Q-.2UZNA2d>8>W@<I9^CS.5^Q)8Cc:-CfJHM+VUM2feGa^8e35,/SW5^-?:?B
^:MAYE>B?>A&Y^J/f293]La&9)=AQbHW9&8^/eZN.]&aQ1>0S3,.^]=C(S8D5eVW
c9a0B;;#RXWf?[\QOH@4.1MG++<#4:@\CBH7B=)QMB^^58]TL,@(@\LIN:]^DRWO
E6Ng+NMS[)=e9R5VLN-)ga#B^D;Sf?FIQ\DBV1JI24e;]4U33-W@SUX;c??1UTD\
HS0:d,Y[OC=gLEaE.23H=C+CLC_3/4EJ)fX+5dORKDSg:A&A.VG9d17Q\E3BbT;3
:21bQ/ad3Xg+Z<QR5gR@)^RD;3b:VG=gFZ)B&+3].[=e8d]b<4KfcH\bE:YL]>([
;,\9PVL\DJbTDdNNE-@AU[04PZbM0aJ53#gc8IJE,N5f[/(+@,7bfJIUX,)YK:5P
8&ZI\]WT^?TII8.#Z,S3f@+.KKMK^8_VcT9COJB[?&S[#Ld>DFX0,ORL.)P7-BH2
#>BS1b6VV__U6B2@3LF,GAA^DR,cB;OgNH,ga?RUHG++RgDdGTZ5:>aG?:D02W^S
_Ye[;85dCG=.:,N1)gT89AAa+(+5>FJSEGd^0FHWE9V<cc?84JMeG.^1C:Ra3HR0
^c[FY98df0e6-&#Xc>J/dFBO+IW\AO(#/?3W4HgK1,L9A.#USLZ=7\K:RCVaV-IS
&F<_b&L4/_]-+3W^R\5FZJP,ICX_2eAY0J((LAT0><F@_+PKV>^=R^TH+f=8?C:Y
SC]H&1JeWR-3]Y51=7C,<;BSWAU(J<b;J8Wd#.dI2SM_DIIG8L1M9cLY4<^_VNY)S$
`endprotected


`endif

