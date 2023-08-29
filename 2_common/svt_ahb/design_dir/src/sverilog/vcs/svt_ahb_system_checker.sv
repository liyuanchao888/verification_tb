
`ifndef GUARD_SVT_AHB_SYSTEM_CHECKER_SV
`define GUARD_SVT_AHB_SYSTEM_CHECKER_SV

//vcs_lic_vip_protect
  `protected
242f:@/b>06_ScB>M+Z0>Z+>N9+/WP#A0CN9WV=[eD:[+^M[(0PD5(QR/^UD^eGF
bP3<8D\<SF>2C+9XQ>HOQ4KGeJ>3T&?D3_>K#VR.6HUZYAB1cN/69RZG\Bc69#AX
O@F.(b(>6OP\)SP9&<PD/Q8IIZ9Gf?&0S@8+EYHb4PT>)V[RR4L9N&CJ#O.IF](,
c>a+f6/JD>_KO:M+(aHG+-;_7T^TaP+(gBP>91O6_^//a&[@[f_NG,c/b55U=c.Y
L8)KNM)V@Nf/^_,]OIg=Q)b4Y4Ja:NQ0EQ,fV^P<5>\FJ8ZMJ+.TLAB3CZ;.,VG&
WUDP>@AGL\TY.7]/ScKIFZg72J)[F/Q7O9O6V=AI34/&C#860MC#A[]\fAQ8)/C3
]OQdIENV4P1<<C2-_=0g^CIaHAKN.S:.3R#]JM/FfUW+E7IaJUSd98,CWL<Hb[.?
+H)IKPEg0@cAQCMQ[Pd@B9-,U/RcH,.V3Je.gDVcAYQf4P^#GNICDAJe^f18SL5^
P3:PFC@(4)Q@0U-1H)7KHE1/E_L9g6C[ONLV2J/9+N?DDA=^G04e8,BBA)a<::Ye
,1U:WEVH@0C2ORQ&<G\1PL:S9Na9\/:I((f_HPaH1N.6OfR0&c<PNZ=)6d:b@^(/
)[UY7/;BTMPC31Z-8<?aW-TDc^TfI-WGR\UT0?eMGKDM)+#d&X..M>U@8YdTNEV&
+AU+Y4^FLD#Ra_T2.+8DYE\K6)@Jf_1UJ1f]MB[XdZ_g3E5LWF_7>+eS]HO?1dCM
\4JHT<P_fB?fVf[_TeG+dgG-[1W/K-eePe99CNdJ.VT>6<#TOa1AIQASJH0e.Qc?
@g(Q<Ye^RbW..0CG9CZbb<c+c>D(X1@\R0_-7Q_60.e=^Q.6R2PKc9?)3&502.)g
^/cEcG^&HHO.6CY40HM5BaNf>f=O1ION0\Ta,\QU,86e1CN/[RdP#Q@OUYCX#/P8
,:B^>R:6CLOJGY,D(3:1V)XI12OG9A>NC^^BS3H>0W3>LcU3#.?[4D0:;B^\f@FN
CeQ>)S,^03H-f@[,RL^AKM[f@<PGQ0cH4UL8[C,#Z_RYF,?2a0^MFWPK3DA4E-N>
Z6=PIa02.9ga#Zd)aI2bX6.U^BXO)B(=-@:4-U+a4]a9.NR4M]KN7[OYcbHCO<-F
9a>-Xc=U+84[8,g#c-a+b.L[eH_d18<f9:)D#c>BCB<Pdf;WP;?5)T1\a/aVFP-3
.[[MQRL^:f:\DEQNS:8eD.f?]2UfK0),I]Be=-VHbOaSKb)dRf_I)bAc/VA4cQOI
5K5X\)J=0^.0<-=bf[Q@FP^ILR.IWHd&9(XJHXR>BR2RBafTMZ,>L@HH4N>?T5Wd
YLIW]J&C2LV,DcANbC#I4(=R;8\HN5F@==PW@FK>c3DBGSAZ9ZIc:)NH8c:96SVS
A)0XLE>BX:.;GGCFcL\Rd<F:(ed8KOJTXD:^/1QJQH?;37;160US.DKK7DdX1E7F
/f\Ea6Tg,8U:G^(cR5/Z7D@9.YOXH@dU,>/Z.3TZ]H<K9C:A7,IVK58IfSEE#150
Y8f)GN(.Xa29[bBKDC<]IGaQ_]+EJZN+MQ#Tf+7EN?J0TH3Y1A7<Je[7X_E0DOIX
PT:e^ZU7<I<CW,O?8ALWcW3QD4e+WF<ISaLCAg6O.5T0F$
`endprotected

class svt_ahb_system_checker extends svt_err_check;

  local svt_ahb_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
  /**
    * Checks that a transaction is routed correctly to a slave port
    * based on address.
    * - This check is not performed on default_slave if the default slave is set to -1
    *   through svt_ahb_system_configuration::default_slave.
    * - If svt_ahb_system_configuration::default_slave is set to a value
    *   in the range 0 to 15, then this check is performed on the default
    *   slave also.
    * - This check is preformed on all the slaves other than the default slave irrespective of the value
    *   of svt_ahb_system_configuration::default_slave.
    * .
    */
  svt_err_check_stats slave_transaction_routing_check;

  /**
    * Checks that data in transaction is consistent with data in memory when the
    * transaction completes. This checks that a WRITE transaction issued by a
    * master is written to memory correctly. Similarly, it checks that a READ
    * transaction fetches the correct data from memory.  The check assumes that
    * a transaction issued by a master completes only after response is received
    * from the slave to which that transaction was routed. It also assumes that
    * there is no other transaction that accesses an overlapping address during
    * the period that the response is issued by the slave and the transaction
    * completes in the master that issued the transaction.<br>
    * Note that this check is not performed on the transactions that are routed
    * to the default slave.
    */
  svt_err_check_stats data_integrity_check;

  /**
   * Checks that the decoder does not assert more than one HSEL signal
   */
  svt_err_check_stats decoder_asserted_multi_hsel;

  /**
   * Checks that the decoder does assert atleast one HSEL signal
   */
  svt_err_check_stats decoder_not_asserted_any_hsel;

  /**
   * Checks that the arbiter does not assert more than one HGRANT signal
   */
  svt_err_check_stats arbiter_asserted_multi_hgrant;

  /**
   * Checks that the arbiter assert HMASTER to reflect the Granted Master
   */
  svt_err_check_stats arbiter_asserted_hmaster_ne_granted_master;

  /**
   * Checks that the arbiter does not change HMASTER during a waited transfer
   */
  svt_err_check_stats arbiter_changed_hmaster_during_wait;
  
  /**
   * Checks that If all masters has received a SPLIT response then
   *  the default master is granted the bus.  
   */
  svt_err_check_stats grant_to_default_master_during_allmaster_split;
  
  /**
   * Checks that if the Master has got split, grant must be not given to that
   * master until slave asserts hsplitx.  
   */
  svt_err_check_stats mask_hgrant_until_hsplit_assert;

  /**
   * Checks that the arbiter does not change HMASTER during a locked transfer
   */
  svt_err_check_stats arbiter_changed_hmaster_during_lock;

  /**
  * Checks that the arbiter keeps the master granted for an additional
  * transfer after a locked sequence
  */
  svt_err_check_stats arbiter_lock_last_grant;

  /**
   * Checks that the arbiter does not assert HMASTLOCK when the master has
   * not requested
   */
  svt_err_check_stats arbiter_asserted_hmastlock_without_hlock;

  /**
   * Checks that the HMASTLOCK signal remains constant during an INCR burst
   */
  svt_err_check_stats hmastlock_changed_during_incr;

  /**
   * Checks that IDLE transactions are driven when the dummy master is active
   */
  svt_err_check_stats xact_not_idle_when_dummy_master_active;


`ifndef SVT_VMM_TECHNOLOGY
  /** report server passed in through the constructor */
  `SVT_XVM(report_object) reporter;
`else
  /** VMM message service passed in through the constructor*/
  vmm_log  log;
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   *
   * @param reporter UVM report object used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   */
  extern function new (string name, svt_ahb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   *
   * @param log VMM log instance used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.
   */
  extern function new (string name, svt_ahb_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------

`protected
fSOAf-VOAY>g5,G=[^cT@-gXUaOF-2//D\d\<8a:EVRbY59><X=Z0)DQ9c:L\O?K
/N)@gZ-5S@#Z2Q8>e>JAYR64dR>?8G/9fK8cLf6OGK4RX3)O0]a?1M=-O:gMJK&X
afLL&;IVZ_0GR:NM:,((S<0IQRB/LHX>9.1g43:T/^4)D@([B=cB5Xf93>f?2OR<
7NUX?OgHB<M__#(e6Kb^,+&TbJUG0Kfb^HU(c>7<FR+ZR7ESf9_O(Z<RI[)N/HA?
2X/^A28()?ZOdf)N6(-MG+4WN&f+Y(gI2[XX5ZPY>:+^+]JT(GgC2+fda4f<PDe2
>4GKdF8FIf\#HfJX_Q0C3.L0e\HW/g/#KR,d^JAX:QXaLf[^E<NFZ&gT6BYfgW[6
QN_-8<B)E?1#/.2<H09<O]EeK:K0.;+^a\L+aKL.KZ\]^R[WF)H)8g#2AH8?^9G-
K<f&[W.0A[2WZ63D]gD4(N95,&,=<N5UA?SPW+7L@O2K1IGA11X^=5E2?ZGG:M,N
28K[S?_[HH_JG&dG[@7adX@[FOadKB/W--[A/aUVJ&E6cS+OZfYPC:A+bg[\ac[L
53@^PbUd<IUSGR\;7-cFS0&S;_8PZ)AVFMf40[CXT,V/<<0D&#N6K03MdRb\(,(,
^0&96NC?NF?6R:aS&]824#2+;89d,]D^T&UBFB]N#-CV(S(N.P2@GdPRP6NfHM)E
[Z+d@/VdOfUfgX3<_7=?M-DKR[9)NN0;OYfbW>g49K-0.:Z81L+dWXY1XNgCU:,<
KfB67C0K.3D=KC&&\S675c1A7V@0_D^\_)S2G&QLUW<Y@9g9+-g3V_9UVdfXfU>#
Y5^EDX6HJL1-56?],:38JDGgIHXBO@K4@U&;>T)K2gdD,f:96=g:T:C\H^)0AW22
)UgHN2YK;S[;UN5cS5[#,((.]/:B80.e:NM0?(=361b574(=f<U+TGAc,WB/JeRA
&/ZJW=7bD_\P9597M.RY>:ZG+7fb^AY-4WF_=OFH8)<@HAMYVZ8?=#?_H>^d+.dA
HUJ]+2UF#KL0__d/L+g.10,LH2I?45<L:S6/&M,IV??-BID^2M0\4+@>_^VCgV&E
C=24YX:N<9@<7+PA+2\<R?+9#]ZKC=c#-Mc=D:G0,QN>dX@P9M<RT6Zb;VH6:/NK
W@4GV,/YO>4B^-_D_O/,Lb9[RZGfG1KHPXH-218;VK24B#fNcK[A(NS#S(1S--1d
C29K9F<[G9:dJ9g8MHOJN)).[d@a[<Bb^6@@M.X=6gaKU2,:O_C,A^/QV&DIPAH1
GFK_6,NUM-&E0P8HZ#<XOC:c/;W/5I>0B8YZe_eMWefe_.bI.1GZcHD>5gIRZS/3
C+W<eX_gc)O#[gT(QdXHPdQ4[16[+g;/^>dZIRa/9I&=]>HF1?1dA@Of_3;+6U0_
(MJFeF\WcO,GY]AD)]>gG5)5F7-QA:gXN&eMWM)+GN0aPA2O3<_@A53M@^g6_8Y@
Xc1.=8#g[REW@/OP:UA\c_I]dCWNEBL&84JMC:e<AQJcB[?JeZ/^aMJVI8=UF,TE
2H6:>,Ac9_>1P1gIM^+XC&gMaJ2J><,WNB;>0;[N9e>JJ@Jg(<_N^\aSD<Uf/@=?
&4VBM7W4&Kc;LBB+G=[JE[F?8QC5X?-VN#/LGL.V;8gR[^NcYXGc_g#F[N8.N<#3
+0aZB#<?65^G82.<ZI#HRISF8XV)Z?G#@C?1ZA/6@CQ+FE@]1QPcXWcPgbC3d>LC
&@eOY\76_EYAD<EM^e\^fRed#BWL8B+M]d9;bKX]?O?6PZXC@.BTaO)>@R#6T=gX
3bN^G[dcT4CK_BaOF,&=aV+9bB9N09.XR25CM+5WfP@AET9O>:O1\OT,RK5<(KCI
=b(A&H,MQL]aAT??;+:A?f;891T+D;c/b_]WVU?TZW(gG.Ke:/897N#GM]Q+2V12
]Q+L4_bDNL9;G5=9b9B>^.@GF_:<HZ?7NX3CdRfC#a-S+]Z=[]AbC2=L;B=K0+8c
B6O[1SX6#0G4AY0,-c0g8S^Y(5aSe_-CfW+EPfda@+B7\[U4MbQW]O3U&CX[HIAZ
EO@\5aeG#Y4b4<@f?&P>FLe?D5c)F>6C78X)-&df\H&1_5YbT-@Ed<gBfO,Z6_D4
Q&KX)_ZdKA:GCK_BUED3OB-#QKK,U^//UDO,41>4K?aX(,M&=QTL2W1X7g0(3WSB
@51.bQV8aFH70RU)\.e@[.&7^-[fG=KU#7:NQ.UMQ8YVLKB9\2R5FN7&X0,E,(_X
)P&#C,V1R#8+F4)P<XIf61e\1fYAP@ZcP-,+R)+=X=fS_)9C,LO79]L<VC@LX_:E
ScVPeY/IO9@1QJVW7U3P&?gL+>)VI=PWO-D5<f,.LC6#@&.XDOf8fgTc,C;gW&cf
.#MGf2H=O(Y6@0X-8B]Z+gRg/::^.bJF8DBWDaKG.6.g[\_.<Y^f;W7HeN3./g[d
KO//NbeWMR3K521:HL/8)J=66=R0OCAANI&D,+_WeZ:DfQ-J0=Yd&A[EZbHOBOK\
-XH]:YBW2B8;;&Tdc@CZ=81RR21F?Hf>WA?d818H>[WZI0USHD77e8@-=(Ve4cRP
(e)]d^@b6T^?UH0@5OF6@Ag;cS+5-+UBD(86-M.f<\5Ag3c=78DgCYG3:U,FaUac
^BUacUT70A[NV@<.,D(7bE-O@KJbJM@.dB4_;EHN4HT2Qd)>>e65WS#./:OVF4\L
N-bfbE5P_Tdfc&S2X#N=?RW7Wac98Mb,McVA4Bc_FE2511KBa-b:K,O+4<GOWUcG
WC&a,(fcK?NW=(?Y\0IRVIW)0IS=NO?5bN;bDO?A//1b_E,X)K0-6I#U8d/:8ce;
#:?O#+CA8g7&-)<^09ROB&9GXXf_^\_@HbPfM;D&RT_c)9N4-&baI,+eea\T9TJR
E\/bO0R05]aP0-Q,]f]1JcYC>bG3d@.:H?IP-W3\CMYOS^?g35KeaG=-RGeHHCE[
&:13b=2^8e&I&XfLQO0X+E-SEAPRC1SUBME=NLQDGN-66[d4Y(I4Ef(AW3^DdfS^
N:CGQG&6&L1Z4A0;OHH5JB^D#O7aD)^GF4C2M3U1C.I#eMgT]XMfbTJ@Ec(<C?Wb
F4WQf0)W\6R@9E)C]?1BB0f[:+BR+5[B?W<e09.K]O75#&2C@EHdG1)<A+S6d:a_
FCO;cIb&#Af-KL5AaFe,:[T7&b36Bf#;=OZ]<>=-3JT2\+[A.&[f+BVQ-J46PN,T
2NAL2AXOVE:WQ]CgRJ6:LP\B/EU(X7(E@0eSeaD)U_dT:g?5=<I.\9A,/;_U_P(T
^=P70=YELeJa3cAB1C7YJ@LB]DcHC.0TBZ+b/R^[S\LMd=9N,g8d0L-0-PLC.b)0
Q1@_05OHB5.FdPK2/QKD.NP.A9ZAAbN?[KP1[[Z?c0aK7\,^#2GeD_MaK9;+;a5]
6<L2+H@7NM?\+I21.TP0[Y;-&_L)ONU\].]1/fP^C)]1+Og#BGd.V53#aO]XPJ.3
#07a@8UQKKA)DPJPQNBUI2C9.D2G@RF(+XUHYa0g#9+7g]BQ8LW10-BaZV[.X=7F
Kc?A7GE2P.J,)JVRDc0\I+AXR#7\c\JU5>+3-/-+4cJB+H#UNS)K[Z_;[)4>9?9[
31EY,R_>03[Y9/33VC(d90H;+HSV6Y3S/19e^#3CgeNN-W+6H-cX?Bf)#G41bPX7
Q2IG0(N=@+.?J[fZ?WP+..SL.<(PD4RdRT>Z0N:GdAd5K8=,gY&.4c](9CAaRPIY
LF>1ef8MAA3<AaV;)AB;[IC_O>;.]YdZ()bRT>GVG8L6U+(?-DCN\Jf,=]#T18I=
:c&(0<]9G4@DeQ@.9DS^C\,ZZL30U<9)/>Y.[:2O0RB_ZH>_>fbM]d,b;bV5CA/f
:ObZ6&=8cSfcI<R[455WV;\Ig:V;#3T+Ld16b=QO6I^E_Q>:(MK2O0<g#Y:/Z+F^
UH1TJAaP31)0G3MXce<+U<A\J&OB]ga@fVJ#?)f=:BDDWgL8&g>9g)21=W]#J9cg
2J7@L=<C3+14I2Z?6b><>]45+b_<61@+E<)@O,)4Z9NX#1UABc^E^9?SG;[2XH,/
VJJ.\Zdg&e85B8X.[2c>b+BX?\#-23d><RN63b7cI.FB):,/VS=1<4S[7LfVU672
Q)WSd6N?f[E4.R_1-?If:M^)9I=KC@OOM6;9g=H=KMbMA7\S,E+Ad_?^NY_.9HOG
D)MH+HTfQND5\7+W#)#X?;VZQaW]BVM[T1P)C(4\9J5Q34R8L/S/B/AK(K2b>3ca
d)FV?a/#Sc&)WI^[Z0#;ZPQW#(9QKAfe9V:FOP0H2X)&K97beE+)XYD)Nc[)FJ2g
Jg@f@?GgdCD+0N@YS(^[_7gQ7Y)0B.<O)F[K8:FeVS:=&I/H,T7LQ#&P+^B(4_)D
5YcQa-,Q\@e4c;<.9f4T1A]5@31;C+e6SNL2+AKET&1CO>R,-eF55\Y8@I.Z(@Be
L^1))&LA2D3afLTD-H)Y?2Z:MT[g&Q6?d#)PAb&JL>RYdWGdE+O<S#R:M>4R1+J5
ACadBQ6/9S2_TP^-bf&PF3dC8F:8Z@_T;g;Z&@NY^3+H8.GdQ4B<Q05g8d7;A,XP
IQBb@JD49[FU^KA.5DVX),DQ81?B?aX347-350a?#:#D>e8O3G1T[=:Ec-;PX3PH
D>geL1,F:Y0c@aC?2#_1KZeNT1<M-?dfMM+?#7?X-=OW<XK2/cQ)1,JRbO14bVQ,
M-+:BaI,&H[:=Y.-Md[X1;_?JITceUMK>05;\.S6^U.T&EHd3ea0849fB3&XaKAB
,3NY:Y#+P88R67<<._-P5bLDUS?THQPOUWN]F4LJ/9-F8S;RA0TG+WAIH\Nf:VKX
,MQ()R0VcP]_A3ZSa@b=(4-K#>JN=]:HY4Zff2N3(XQTX#]aQ24KaI+)=#gFc?3,
BJ5JNX+.QAa?g9dHH0Y)<VV-c#]OTg+B3b34e4X=69>eKY<YQQ20\gTHRc0K+D;@
.84RAS=^\6g6N1K5DQIK??8^6.bO>\fMaOc1A0GLT=bB:7DJ,N<]8Ce)JXVZR2]Q
)Y=+OKO\FYL7L28L0HNY(7d[+71QS8.2E_6HTUgEM)<bP1-HFTM;L.I>G[Q>/NKG
b5):6fA;OFdI:8)1>E8GHP96)c,N/P+/<KL2MaV#-5_baZQ2a-LKJN:/LG]>d<2?
K:0_=Pae>L8&8UI2bV/3>]?H\>KPaWcYXJb5^IY(,1XbL9_>d7SUO)TY7^7NSRXF
g,ZRSMH>H&K_K=?P<XP^YGU.(2L:gV=PdNU#-cTE8KP^CDeXC63>BVK(RKT5/>.&
J;S^/G1[MR29<HC(,&@2B@gQ&a)6[2Z6TCK8,GGH91[G;RO8<a:E=M.SUPVB\2#T
f81/[/IT@Z+BSag.=IE?2?^IYGO/-,b^ZZaWTgR&HE4T+]8V;g=3\-MH_Y]9L6#^
Kb@fZ82H[AO0:a1C9<#&S^@)0:>7]N(=2,d?dT0GJB:@)X+0E3)f#DT8UMII<RX?
DPAW//R^F62c7dCC-AS1I6ccET?IK36=[2\-7WTe(3C+<(0[3OgOH>CL))3;-J#a
[IXE_TPa?_/@-&XHf;gWPWDT^T(#\KR(G,M;943(#VAXH>RRd591_cY>KV:fZ4X4
=SZX\K>W]G^\GfVXLL88N;ZeV_\8FOTdG^:<cJ[\YSELKa#UG_#R;&UJG0QV-2UQ
aV=3:@bfdAYT1d]+>0>-HJD,B7_^X.IY:[,FY#Cg[&4T_OHN6AUaGXGR3BY)cSSW
QO+]Zbb./3;)Lg<O40ed.-S<:F0ZASN3&S7^6<Z@@E]((fYUQ2e6N0:AHDe_/beA
J)=>Q9W^EX?gCOL7&ETZ;^.gH;)BHIZNR01Fd?TMA81[f\494MT2.RP_]-?O(RCJ
T\b3CZKO<AY@L>L)R-X4@IWG]gc0<95=#_T@YOVD?C;IOcJ/WDT#@AC.AU.R:LL_
3DI>:Z4+AJZOK/Q>O-S6XcODXB_N^d-c>+(&a3fYJOGS+6A;dLAX(L@V44//O/_d
5<c\/_O7746_bJJ\R7KNaBUKMQQf[DEQcBK8dM;&/N\FZ07A?B5F=/;4e:1d&D@L
7feQRCABRJSC263P9FGK^\J<R(H#=7=P@+NFX#1I5Bb_1KO0Y^J@A^e]F#2JEAe2
a&J>6,MES(/OP2VMZL]7@_2_UO(\?5U9KK.5090I^H,^0bJJBKP22;;14N_O;?=\
YcLKc20#RD@VH,4+_:@dL)^>(fC&7SSE(+<PW8(+NUEU2\<0M7JVUfaHX+P=[/7f
/cdX-;D+8?NQ_&<DI\PYEdP&33^1@UP+\#cEYB+X4Z(@V[9V;-+Rb9QGg&eB]<OS
E;-c&WEJ/[=/./1bMO5+]\GEVZB3F;;(V@81)4<FC]@OcE&Kb4U9O^R2bQ^+68LC
/bJ\c[(5gF#=K/OW5@M#@T]E53#8b<RO>\I#Q:=>3YH4.:G=e-3L^A45O/D<L9ZG
I9:B/W-A63+gTJdUD+S:-KP<MX2G&O-cM=bLXHab/G)CU(PXQXdQ./5^&HbM0^_>
913F?T@V^DI;D#C6[@5aF4&d=(]2Y<(2B#T/>/T+2bN+32OQ3Ra9-;Jb)<NFFW,F
OR.I^I4ed,fTgCB1&GG#VLB=+^1d8NG<4]/4G,94c&D@OSBK=.OUJRWcK]]e7RXG
ZE\VbC)X[[f>53W3<K;Q,8E9F,[gV.?KMN8L]7a?8Nd7Z>L>M8VaBNRe@5U>4XJ5
M:-bZ44E>89)I?&)cdb)?&I?B5A50LI9E6JL2)FMF/d&KC;.d/CD.[FaT(K_:WK?
MZZ6#L0:G-U:->7-&F[&f1]3D?GD8>_C/(]XT8&<T#7F5BfeJTNI(XG)((U;W45g
#(6[]>eXOc.3H0d<>a_J^:^BUS9GQ?8BAALN@\eG^d]YQ>DE\9I=;9#Q^Kb72KS5
8_A+23;;/K40QQ5PI1Q4&T=T4fL\+bd^aK+efAC3;+VC[+]@WFbag&07/g8ETJ/\
#<@/Za&77ff05=M^2]4SVD9&BGBZfX=9309M=&9LHWQ[)Pd=ZDV6]IZR??D[7D3b
6.9P-/Ke\V\OH\5B63gA1dVa,9M?#TF]<1:XOSe\Q-EF_W1?ZJU7#D)16N+YN?,e
0ES^dASDTdU(NXALf6[FHPNDa-AUY702PEND(Y\OGRe3<<8\.J]9LPCcBXBSSg7S
VRXL,KQ,_@(N)8WS[JIA_@87Uc5U9S>7\,@>Z[2ccU<++=Q.0HHXRIOd.WJ2=Qg/
(eK/@:KHaS#JgSVB<#ec],PP.LDZ;Y3JTKTBKBa/_P6+C$
`endprotected


`endif

