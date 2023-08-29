//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_NODE_PMU_SV
  `define GUARD_SVT_CHI_NODE_PMU_SV

typedef class svt_chi_protocol_common;
  
// =============================================================================
/**
 * Base class for all common files for the AMBA CHI VIP.
 */
class svt_chi_node_pmu;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;
`else       
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;
`endif
 

   /** Semaphore that controls access of perf_rec_queue during read and write
  * operation. */
 protected semaphore perf_rec_queue_sema;


  /**
    * The configuration that will be used for the current time interval
    */
  svt_chi_node_configuration curr_perf_config;

  /**
    * New configuration submitted by user which may have updated performance
    * constraints and which need to be used at the next time interval
    */
  svt_chi_node_configuration new_perf_config;
  
  /** Timer used for performance intervals */
  svt_timer perf_interval_timer;

  /** Timer to track periods of inactivity for READ on the interface */
  svt_timer perf_read_inactivity_timer;

  /** Timer to track periods of inactivity for WRITE on the interface */
  svt_timer perf_write_inactivity_timer;

  bit                is_running = 0;
  
  bit stop_perf_timers = 0;

  svt_chi_node_perf_status perf_status;
  
  svt_chi_status shared_status;

  svt_chi_protocol_common common;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param log VMM log object associated with this component
   */
  extern function new(vmm_log log, svt_chi_node_configuration cfg);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param reporter UVM Report Object associated with this compnent
   */
  extern function new(`SVT_XVM(report_object) reporter, svt_chi_node_configuration cfg);
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  
  extern function void set_cfg(svt_configuration cfg, bit set_curr_perf_config = 1, bit set_new_perf_config = 1);

  extern function void set_common(svt_chi_protocol_common common);
  extern function void reconfigure(svt_configuration cfg);  
  //-------------------------------------------------------------------
  //                       PERFORMANCE ANALYSIS
  //------------------------------------------------------------------
  /** Main task that tracks performance parameters */
  extern task track_performance_parameters();

  /** updates the READ inactivity time performance parameters */
  extern task track_inactivity_time_for_reads(int perf_rec_index);

  /** updates the WRITE inactivity time performance parameters */
  extern task  track_inactivity_time_for_writes(int perf_rec_index);
  
  /** Collects performance statistics when an interval ends */
  extern function void collect_perf_stats();

  /** setup performance monitoring */
  extern function void set_performance_monitoring(bit enable_monitoring);

  /** Stops all performance monitoring and kills the thread that is tracking performance */
  extern function void stop_performance_monitoring();

  /** Updates performance parameters when a transaction ends */
  extern function void update_xact_performance_parameters(svt_chi_transaction xact);

  /** check perf metrics */
  extern function void check_perf_metric(svt_chi_node_configuration cfg, svt_chi_node_perf_status::chi_node_perf_metric_enum perf_metric, real lhs_obs_value_to_compare, string check_msg_0, string check_msg_1 = "", svt_chi_transaction xact = null);

  /** Get performance report*/
  extern function string get_performance_report();
  
endclass // svt_chi_node_pmu

`protected
]@6&>JRNC@^@cLEaZS0.4d.JW;X7.QFL\\2?KIR\]IIcPV0SLJNP0)(\LISc2PO)
ebA0Q>::Zf:1\-;<&aQ:F0B5bg8G6cQ^7=2]]KUX9RX?b+0XSM[X<AB<CFN3@USJ
-D;Zf<O1C8TOQ&6FI>5A2OCN>a2gC3=ZAT-HDTEMW<5I6EB<OK_aFJH?7S4f#M#[
V&FAa>a^K(9U[RP/@9+=+F,C56.M^d?(OJ?C#K8#U4874(PBU^H@#88P:8WaSD?B
=\fc=KEaN_WYfSVXD(46A1:J8Sd_]B,WbW/ZNP4<=(3e#W5[/23??<.[1KZG1(X<
^_bF2>\M@G3S1VbO>?]MBKU?cHQL:=c0Nc1:27X+EISHR=2)&A/ICHObFfY1NHCH
1YR??<(eJ>ReZ>#:)]GFZR7^Z9O+CUO3?7[.#d4fD<01C0@PU#CVH@VVa60fP_?3
CXN0V/?53dA#MbHWK1E>^S]55d#@CgBXN@DG&>g[dREBW27GTMKINeX0FM/4:^;/
3FU#Z2)=0UcCWV\Ha1LI\CX420&FR5WP=$
`endprotected


//vcs_lic_vip_protect
  `protected
:4M7YTCf@4YAg9_)D-@f).MST5].2KE-;?fX,:M@H:8c@&e+;N+?6(6)IR;BAP?g
^K-U/,NKG_A)95BV[^9KaVbHaNGT^(W>Q[Q9e1NXN)L\@UE9YWJ5F[L//(8D]<[c
7T_WfPCa9SYX-CYS&9R2I0W@E<RgW1SC;/e9cP4UGf)IIXOc&+RZ;(c_[U+W/0C8
:LE^/E7HPI<640@#58CBf^ME9O)Pa49)b>YGCEC::fHdECHdbA;N5M0#7#<-9WE/
IDc96MOJW-\8)e0ISW:NZ5Dbe,GKPg&a\17)c:@a)+,IVQNec0db+ZZg87:[>.LN
CO56YV9<KZP8gJW27X8MURH1@:Q<KZ]+B,@_Y-0DJYF]@e_K]B2M+4^U\T=73(Te
9KfHa30F\a./64C)b.BGdQF^e\Sc0;f6WG:E58c1R55[;55B?ERdLcI7:_6YC^D5
/.Z\P9U9L#PQgbX[Q[8<5],gGL4S/@e[[]eF7Q[S>J-:gAJ/X8<W:UgK18dGaAY4
f1?BLILT,S[7KF&<>G5J06gQdF2b@E<Q\?XC4G\Y+(H8JRf#B?0B7[K_RI+D.]EJ
34M&.?O?Tf?]=ZA#0I;a;?5WUO81@f?22eLR^RJ8FJD;^JAFcXW<DJ>d<\#ORL96
0/=S@EJK)aa.gA30f?IX=eCS,&g(-(GZ<F,]))/Y+#+FV&O5>C;M&Ua[X?;/>\(/
?bQP_[gG)?L2YT/J#1UQ\9FQ0&fG3_YRfM#-Na4TWgKaG+@T=,.Z6MS/K>8L6)>f
<)63@5T4a86f.]3XR^CRdIT+57g=Bcbg8A\,K(7DLG=MQ#,62Q0FQ5X7H#2FF:BW
WgC7U7WF@-JM.W0=4);/E4AG)&PF>/+0Z[UPK0.STJY0Z9@(,#)Wa+GU519JK@e<
&Q-C#QgLRC9X9TTaCU._V:0/?<gRPNeFbcF51DQCXDK7=fB-)3cKGa3.UGT<+9AT
6+bb)_8c>fdP4QMa\[-2[;7>Ba_NVM_L)V,)\YE)PRZE:Eb(UC6TF?@V^Z6-PFA_
GZZ>d7C/8]\CM&>#K21NZ23DFcMEX2adK[D^Z^W,_#G58BVBV1?I4ADI>VK7)ge-
ZT[-aH)5</UP2f=3[LBI]QdbGWeBDW,VI[-:04TAF&;F\G9UNF1.Z&Q2;3?4V;PM
AL?bJ58+;f9G38Y^N?@F:S-L,FcB:ag).g(FXd(Lf8T0Ga\=.aFcB<M9&cTV,\WO
@=9?WGEH@.+XN7U?9+/>MX56eRS5Bf:R1F&+Md?D63GAN-C)_7]#;:0>36E<&dB@
?T(?D&;3)04,IP#9.RPFXAK1@VC^(Eg^RUJ7_0f3AO:IRH:9.?BG04O\;G6d/EaW
\D,K+-A@,U#2g/?Ka=4/_;c?N2RM\J;M?Y\1fB06cB;V#39eA0N^OBJ>cI5D_R-&
W],N4S675\D+?=1Z^Uf;3)GG3:g;T9\^H#2bU2X)PQ&a#)c0O][1J8X^C(GWR(fd
1SL];>Vf]5X<2d24[#2OOfOAHRAEf9>]3O?gCb3\MTT.32GCLM0ddgQcN40d.F0F
72f6R794J]4XWP@0A;,+&X3XL^-L2)e9f7c85gbA0P&]60]HA>a/MY?^3TV7]027
AK37M@_E;H?.aZD#(15C>Vag]4W2J2D>+J9&-2CDZfZ/gT_@ATGa<8-DgQ#U&6\\
+WW:OD3XJ--Z#7^P02Xf@)=g;VI.Y#]-I[E?Mg=@HYM75g2ON<5:&;8X6:=9NUgN
6N0X&0fLIceB69F@:SaB?VY7QO4.SEf;3E-T/_B/M?e;UQ>)[4[T?ac96NPa1e2B
b5^&3HC2F2?0cP6PNdZJ7+gg1LZL_/O=aSc]<:AYQ8Dg8\1<d9NA@W+(>)eNEWJ6
<O0,QP]8Mf8bbc-TeF<0>_EU?AcMENAf]7Z7:5b^UBEE2g3D#QFA\09gb>=@Bgd[
7Mc:+O=,8-,d7HMPW[T_?/(Y<a,C4.+c?:e6cX=gd7PD2)?KF-A8/7;G_#+]3+2b
GU1e2/4Vb3Q&cV4?N8PQ456[=R_.?gLd^<IcN#TGNCB,:4<F<=a_:9Q)\#0IYbbP
EL0Z&2A255C]g+=6M:?GAT7KfZ^/SVW205?W((7Z8::,R4KWW5?eS_@0f&,[=TTG
:7.@fV+,NRX4N[+_BTRQPO7[X#;;faQ1_>MV#PJ9@>+-MCV=J<W9@E<FGCZG4O)E
WbP/KdgbHS(?J>e@7>A1VXV/a[&/ZO0PLBQ2_X_5&LTP/.K<E\-275BeY,(9\DB>
VQX0K9[Y:)bL&YgGOg0U2RbI-&8O2/\0X=QM-W?,:.Ib8++eNIE-6&.<Z>?__FVO
_E0A,L3W.g:+4b#MORR\^J3L:HMV\)5QDE7\Q]2.H6:\0T^8N>?f)]DQOG7)GfC:
BZOP.([GfNM?P8SVJKg+&+TTEU:1XfE1V>WUA,^1A;9fW0C=E675=O0RUMJ6IP<,
3Q_SF&-F=T&9A:1SNbe->OU4Kf8PYT,3IQ?dMcBOMaYD95:)X\Ec88T])#LBL#Q0
#=(;BQ-UK#+eP>&PJO:+>(^I,>-Fg[C5@PN=WM_5U6:R6a@F9/RVcd4PT]48,-[O
::=EIV1KDP#]5@K1&4A\Rb4N(f<;[C=XNO&MVZL_90:b\G=XR-CWT?F#TGM3RH&2
Y4N/-8?Y8\Eb7W(e+e/Wa,8)d915ec(LI[6?1V3e4N9ZL=1gKR6NF,gI^c)fFRUV
F(9)(;-Z5I:ES7<4E/6O+;LST?>EL1a\UQ[CN<ZNcZ[]dH/@K6e#&Ib,ZZ#P><_+
b3QNI>P]=NLc755E2IGGYf.,MNFUBRP0?IIO22d,O83-@fe?7K,?)b3+M^I?bSeT
&&.I8Q/IO?dY^HQPM-.8ZbO(Ge/c3gWE>X5?FB-_:X912@&@\M[?Y[KQ<;O)GFM4
Q=MZ=,>CB5)5_gEa98e+A@Y;\0J-7)Q:R[B<523\OF7ZbX[7YBP>B=J:ZfT=0(cG
(<D/e:G+;?\c47<f9)f7)@4T04F_=VZ&VaCaH&Ac5Q7C(2OKG#\f,RG7V2;.;T#5
&INNL0)GBMRVSb(Td(3\K7KTG)\MVIPX.UV_cWN2@A?K_9GOG1R6Na>HL(.eNRWN
@aEX>fb2@\^Ad;-@C)<M<BD/_J4\5XK=FaDf^\<IJ7UFA#<2]<E4A1I2Fb9c/FgN
bMP1M&Z)LFcMb[g5VG[7;.6c,=TL_07>>f=CEJ(4L]A8QZ<1/;?bJ&(:SGJPVPf9
#HLJCK;VTe^AI43.HSG3:MO99P0F>H2S<eTXO=6_Da@,cMaL#>>H/J0.4?b^d#T,
HJK.Nc7]-++^M;S-<SI?LNcJgfQ:<g4@/bYe]K6#CF6GMecXf/P>KG>1dcbe#C5R
g#7+U<JS1\K^G6S+7YB_.^OIOD\?a6OZMKET#,]<dP9@dB9[?4EEKP>FEIQ3M(X=
aU@89CA0;ECIY+E&SG:b.>5f7?MQD.@eQLH]0YM]/&MgV4@c8?V]b\2AQS5HV0J/
C8X0AK;W4,8g>;D>,_HdSMSb<QGPd7.S,]aN<<S5V]S5/V/;QAd#O(,O,E;<1XR>
^/-@#PKFIY^@gX.2d[2X7UZ6L^I+bYYH067VX;:I@g@L,fT4BKM@6fCFd3KAH]KW
QgRL-fRCF]f7TZH1C\2F.PIg:?XE#94M=]]K2Q--.74;P8QfbVb<)aYP9X/R@6X\
]bc+d31H;HM\1;+JW:2;QIE(#210,:;cA8SAK#\<5TY#XYE#bPUNU:1AWZeRMMYc
Q@8:&T)VC\^a9bYE_A>2T5=SU&U\28O[g4d=-,Da[;8eL=?+-V=[,QLdK:&U8CZL
\;Xd&WBfJg]WT\SP;2QTJ.;04?cSXTId,V-8)F\Y#C><(Qg9cM>DV,>,POH1RJ14
;0E))AScHDH4?0FY,X@Sg1)WRZY_7D.;G3V34476XVS]]\GDe]4A42P#Hc&YA<J9
XHg(YC#3#95H(;7=SJY?d8U.I[(91&BLbd_6aVF&E@NB0<)=f:U#6>&#:\.+H<#I
T[PV76BTRFU,R-@HZe/d8)0(cC-0UM_e<Td0.EEO1HR5KQVM0(9Y08DgUGb+]d3Q
NBaFZ:aeUfMOW.YLEZ@9Ff9UX2C<eH;;#Y/V:LN=5D9PR&U/U@3.@Ib^+.SNHTVZ
I&3M+8Gc^-C.1O/1#(7&Qf7O2,b[6_[-@)87fP-@:<U#VVJEN4eLZEHN,WCd<8J5
>N_P.>7(G49.540]K<J2OFFKUbI.3^A3b/C7B3gcNL?#(bP5X61-VSP#7+g+,=]G
XU+gP:[0b^G1BBBXYX)Z+&4c9^H1C\KH/NMKBF_(KLS][FS0S)TQC^aW/^BMb0A4
;I0F<K#ITc<9]]EdS0+X26(_(;(=Z:g5+5)A6@DUa&[C,,X;OP#020eT)gPFRB9/
;PL>eEC#d@C[_S#V^WV5N8O[\.D<N)1N<c4,g)+_,KP#:+1+-]/D-_<U<EF0CAE3
8.Z.[@dELD,]ZQ#X5\eK&ZX6V07,1(D8Ed#KgTROSe)W@\W7bAeAH;S8aKB(QQ0)
<NAS6]YdZ#aJ?./<GT;V;0&:XG+N\_6Z,,=0..]faG6<XQebJ&2[#g7.KaSQ,CHA
F8Y=7Z7<376#3MJeJ/7(9N(G@<=-SZUBK0D#cE&DfBY2d8DB:#<Y-_(;4&1-;cD>
0-@8:==bRg2gG=R3JB1[GLSR40C:[daLZGS,+F2R6;_S5&7S]\:SILCdA.2:@cFg
)Yc.SCcT2^I(_5[C=3[EdI\>99RU3SaM0bb[Q&bSGA\2DK/ED/79Q>+PdSI4Z0Z?
+A?3MBXXQ?US=2cb;C)OEU&9CI;9f&LgE7E7UCdT#4)EVV449\<baJL2]_>FU3bJ
\M>)2SdO(<PA6KWYOEeX.+B=BEbb]B?/G&NgU_&W&GH]L1bPNVW&TPeZF1X@ca0Q
e,c,]cJ9TJ.^U]KEC.4@CP),IX[-H[U27g?A:Y?dc-f8WD6(4)->&#F)^UIWfLS?
<C>.f=\/)DQNa3U>EV4f7Q<JIMe>._a_Q76CLJ]RK\S0g9\,\,J@++D[7N).0;d2
;=,Ag(//)a87;VGFLXV]:;DM(-?A5/\CG)PfQ.]D0IZ<eXJQL4ONF#Y_[H_RZ/Kg
8fMUOASP]LE3fWG\bO&N72Yb8PS^W4YT3(OS0BASO4T]W+ZB_98>BW<C7,@aSO=(
SYc#N4K:N<Bc>^;A@]YGBES<7=K]JH6KcE1K117Yg^HTS0P.0+I_A2P&]?4+bg@S
.Q_8(+YM3O?QYIA<LBMU16>_3UKUH\+W1e9(f_Yg\AIH9Q&.,WgX+cR2N)=g4^3f
A72b.)5]?H8.XIL2)KUG9BLLZc3C\ZO:.3Q)E7XKe^E;<-JI[bMY]IY#/Z29D<G#
K^QZD@5FI/NO-@W_D-VRNdKbRQ?JV61=G_\9RgFU:DK#4Ib^0W&)<8^+#SFK)GP9
/C5X=9d>WZN&)#=V7?gS9c9H3N7JVb2@17T?:Y#)Z#U:cNbRA4XB\I2>-)d?9OEM
@8gIOK02M\Q5GV=KF3EO6J1f&C/&O.eSD@)e:0AVEgRFdVN?AJJ40U^O\g]aSNE@
D4Z6/5L8W0#LSc;.(2c<C,4=Q98,V\\/K=_YXIT2f2\K@986\\eQV_NKBV76eCAg
[1ZQFO+Q0-E7\5K#3PK@>066+\MB]KPY2]cD?UZ0)TO,J(2HA2SfM^JUH6/453e&
Kb-f\?N;?(66HfOfF=ZT(:2QTWc9+T.=Z1,[bc?MN-L[E#GC2E4T6)aQN1WgN\?&
,_TVJC:a&S5_>F0\T[;\HJ2I::ZXGXD=EXY3;bZ+EWc+0O3/V54P,7g,/PJb&\O,
]619Z8G>DU+U@e+-R/\-V1gd_Q#,S#T\F>6_g;U806(:@ga52=<55c(ZZFO9gRP@
KPV1YLe9>;fA+UKWK;_5H0/O8<ZPM]A(bVQe_[?L(^eQYOM<W;Q8=ND6dE2;9RHC
MN6C19Z1dTU4HYK3Y4&1B?09P6b&,>V[A\KA)Ob1[]gT;K11Q#VOg8eJb=COO4:F
_+PBG1b4)@FcRS9:_U0:Lgef7M;^A7g3NO^W8PS)V39+-.FG?7\0_dcYS,NP]PT&
5>eA=dI8OI_Sa&KO)b@/D1a#2d9AW6c<X^S?V)XT_4#-;ZJ3Q35H=Xe5AT?TV&(1
17.CeMCZZ<cW,Z5R.64CVT1X8\<:I82YI&+Qe+TAOC&F82a_:[9T9_TJ-K#088fd
MWb^RT09@1+)+]T9..=>.&TQP5^K5eS.+)/bZX:0Z0\W/)RHJIc_)F36D=.;S9NS
>/6B3CAQ+E=\_f-UV/BGOTMGW8Fd_-&YdD4[aK]826O8,XOc3:,MU(0#^bBP^E#8
/c6-Y-/[D<>>&>.LI@>I9?OXK1JC1;Q/)0,.D,)RGP7egJ\2324W8,Y7[?K:5ZC:
P\ODg:N]S@<=cG^eI)(.Jf<0:1@T&S]@^?.\E@UY9X.>XM8,RZ+g(9-Q.&d?U.AW
\5\PC:DG\T@T>KPXJBeZI\Z7,6RTR1CE]:-I\;XM5M3_/NeEY;2LbZL)E<c5;eG+
PZD.;@O28MH]2;(L+>VN-HO&6==b7H(_<UG<86STfeI/(CR]2ZG&MJ4:e5CQg4Q_
KgYb7FR(PCcN\&+S#Y4E.)->5R>)K=ED0^V23[<<1E\T<:[,49b2Z.9^#5F-/e#5
V(gV7<e6;+g-QS\)X&Q8DeOC[L/_?G;YY3OO77g/2AcgWS5TPJZ^<][;XNQD]:3?
_[Z.dY)_\M4.;.:Y7e:M33-,\IS^EH8@?\=/1437;B.H-AR3+aF]egDDY>3CW5E1
:8/[8GcCQMM4Uf0WNW9R9Ua16:Q5.BYYCWUY2:XaG+/Qe[fdA^_FMHM8>=I,S)&D
/,NO3858_]&2UegKJLgTH+-c6U83]W12IaX)1VXeF2_c9>SG^5QCS_EB=HSMLJ.8
ZZ76gR5g=_6>K]D&/EOX]WX4#;KDKL]];N]@;@E\SAcZYB\eHH)_(83:1,],Oe^S
M)\VZ8V1>1-/9A4[<+BSb2TTUQ#BJYJPZ24c62V181J#<JS.K>]=?;.QW+1/D,LP
TCCfU.AST=]=[J6+&1>RA=WZDR+ZNGCI,F9;b7<[K:WI3F#YE6EWOR.@bcF-b5ad
Je]-3GB.gJ<<#TGWR;1-U.O][\7)7NL+Y8=PIEg#?]<T;Wf-T2;g@)&;V&NW\].-
\EZ#9M3LC=/:f9RV2S/1B9?,a7Tg\&>dGKF#D>Z(SGbSfW4J:&N>J399Cd-.JEOU
JMP+AO5+G)5@?PO\(-[RB/Od7&\=.]CH_Y+Z]Kd781F>L1ICUdW\YZfe#HKR9VBd
IH&.EGZ3c@LD,0C(+M8E>cI^7UO8c#DZdg_gB\O3]?E,+WPDL<JfMN]aJ9g&I<5[
CLW+O=T+S,f,<bM4EV1^UFgeU01L^8Y7&7-YZ).<TGF25M_\QM_TEK@&UYDH5T,e
N&VJ#6](-.cg;Vc)9/#(Ob,d]MGB?YLePVgL+M[OYa>NSK;X@HO(4JS7&TTBeV<4
(CQ1@[>c(dY#W.J/82#UVeE5-@/OWY4JEZDJ-b=b9ge=]3O4[2g9Z4&De,/D-5=A
E,>K2a^<Z3RgM<acZT55eeLaO7]ZGg@Uf?WGMC/;A<c<TUaT==WTDH(-Rd\P+]5c
&8[>K]^]<JLR9dHIY966C:F\10KYfWO34X^c;J+WFaC-1ERIAcg@2W9;.9)N.=;>
J@?C[H1a3KU:3[Cd/Q\QW-]7V4PKcdd=IeV1/K.I++L60.ER(,(L<\P:LcA;QF7d
ICM7L/L]&^CR0S7ePD-;E=6QGbO=7PK_P8g,B6<7]J/Yg+]^Y)JESa90;=HB7Q;B
1CHB=Z?RTXX/V]#K+c?TY]/K\#+OP&\@V(5Z=e8Q\UFB)84a=,eCE9f,._7,GP0M
,d^(EDDO+/?O7XGg0RIVN\,\QW(>c6CWQ0d9VEN6Ngd<f=1.)AP11ggV4?U+g]cb
Jb53&#J]HM+=7G4U-Ne,L+f>PbLfV9a6.1P@D5JXPO?0YP&Z1,/OG-.Q.B7ZSd.D
O_@<<^1L>MI15BPF)VKS;PEZ0G,KeI]+(@V-->O&BRD9V6C[aEfY26IPE:FRZH/,
MX374Q1X5.(@F7]f9cg14A>Q_@,S]Q3AA0E<6>PJ99Kg7[AGQX187Z&NWO\a0.f&
8;9(Ff3:bG+YS4,KD+G6#03\d@1+85/PD</O<7fV6aXaZR+?XDLFI821VR=;2c@F
TbGAB<eD<-\cZ#=3@HK-OU(E>9S,<]>HM+WE)7AIC)5AcG?4c9ZZW4E?T\e=7G-W
^-3dBDCE8#?:ZM?I5:[2)8K-4^O5KRc\\dW<8MJ/CGN@#@?eV=54:UXO&R_\#6#W
^c6&LG\7<a0Q.RIUeg(D[W-0^)_T5C@c-ZW^X8gJXc]-QeUb4FNBJ#1Ne,;87V;6
G[\@NLc^U[GJ>GYbaN6FU6;ZTZY\S9DSLDNc)6(.#P;^&L7.=<YPGgA&A?5Xb_P9
#TgB?&=X;F)9,K(S_\a@&Hg/N2P^/-F=Q/ba)aWH.aDHI-[DK33+a#-0QA;#LT]/
CGNFK[a>\P6@b@.RBH<A33SH4.\4&8\8;c>X]RTI;^[gZ6J]XH7FcN)IBDQ0VXYE
]\RK]FABZ_=0HR1I,9gAO)OD2c62^\eI7D/R6P-:2AVC;A@-\DaZ9-YEMdAY8FE)
H?LTZA5D&#E&&,:6B[YEH]MDY+NKfKG-^>9O_V0M7^5gJV]Z,N[1K/b20GcD+R^;
:e>9GL1e3<QOMR+^&241b.OQd(M[4QI\Ie>TJ[G5JX#,.1;<\.&Z/0Se85H<XZWU
2f(3eSKFY-H9D:<,HP[]f29=+^,I&>GMJ2^&,XW]V3DL-F6d]<?&&G9?MV>52;fa
@@?c<FG@9gbbg2OCAH74.T,&e[JQ0DFN@T3=(d@IE+8JLXW]K2ZPc91Y52)fV3c^
>7]b1dJ5;@f5E>K&26eU@</>Q>KE5gVXd?=FO:G&V7+6BGSV[5>BA[=?Kc7JMB:I
NL?]H9G&d;(#61MC6/NJQ\@[LJI5VedSbRB&fc@4T:RS2<;>UIc,6;MN;]:11YZP
ZA/]_M446WdK5ZLcNM/>V^H1A5;#@::1DV6f^g5?b[JXWHZSC5ILFW8e8DD)Q:DJ
W,U>?.5/^Y_)GU#/B^B^f=<..0SU9d[D,(MbJa7be,M)YDJ949KLS1H(GPU+Sdb]
2D1,&G1Y\BZ?e4bXa;\cD1DFS8T-/fMAgQKc>RI_gB@N4D,]^;;U_Z058?/P,]d7
\Cc+Nb1(@#Aa5Hg38S31aMc]0d-AX8RQ6X\M.#+[-T<_5bM[^&b1(:(8)7bV2RYB
:QM/>1TT&00D^@3B0A+=W^/aLG+3FP\[8(PU5[<-e3#:YC_68N6U)LM[D1&J)bfG
@BV_159Z^W8TA&R46=^EKM#]0&2YK[:/FH&G/9VeQ#3SQ.>(G>TW>WDU;\f-_]]#
G>7-[<Z_/MGS]#_[Q#],BDS.@E:&(::\0=^??T930fQ0>PU=,.L0P+c-]18?QL(>
Jc:Tf8WF]MPXCT9N;3E<,FGB/=/1D.AFJ6=fTe-TV^b@.EH@W66QZKCIRFQd34&<
aWGT_3/1J)?SD\_#P^QRN0TV)OH_3eLD;L1U]/?@5[=LLQD4_S2#dF1;S0C__K5I
?\\(P<5_C]G\0EHW83a8G8GY\K0X&^gKI)W0[YV^8V:cHD+K+(GHERV-UTaE/AUO
N>KPJUL5+WTV]O3\SB2R?;(e:Y;G]8].,6]O1e?RUAUaINdEJJ]V<2Z/O:>6W;ZL
5PRaH1H1S<A,_-6=R7?JQ>F+;T#Za\2^M;+1&(@;0d^27E?XYV=FB-Z=(>b7<7FP
;c(YQd9)TaF#Q&5=8M<WJB:bTOG^/>I/17EXM0GgRK6I2.-=IHO\LWJ]R]RA^C6[
)7V[9[EB5D#NG9K:W>04EX.NBQccfH1MABKH;eTZDPRDSSS>6JC@,Y,eRC[-<_bI
aFX356ZE3f-\C-BTF3X:9)37>_<Sd,Qd=LM1U#M2=A.Qc(Q1cV+.8].+=Wb>-7DK
X2dXA(YRf#>?>]Ya3T7d@=QZ-92eO:VLN+)4af_K:1FI_>B\PA]bXZE1^Tcc3ec2
KU&;9J?IZ0,cH8@_A2+)CX0J(fXg@41J\(,:3<QI[aYZ+bHFK;+QGaI2B[3],cIY
)NE<((B1=WFOBHdY8Y+8YFGb4C[Ua.7B>I-0W0-QCPTN,BEMDD><1:OZ/8=FNQZ7
eV;N(L^)<afUBC#3SL6/W2L9FBB;g^[AC>;daCAU+CM)1Y4.P]?MLEF._K-?8,?#
OF>-0_?Q5f[]S:=O#Nd(Ze;O&#]e4f&GJ=]]@aS@a\T-#5ZeTZ[V>PM],U)E4\X5
.J;(>/KZ0&faKfENZ.:7X(7]F,\J_)-K=_2)BTX1BOFEQ=P=)5G_?Hc#A48MWQMD
:S2UUU_HD3=G.8QOJMU2].7]KAd[HQd)cPQBW^Q9\#+]D99NR::P[AQY^X^DZ([B
(9-FYgGO[1,E/ZNZVfXG//BRbIK2;</>T-9X=V=+93>[QE4/3_(;edgUL79\DfAI
2dZUHV;fMeY;9Kc5,/A0D(De]WI0^F.=8bAA8a.4)O<fPJI&SaI^K[JA:gZe[\J1
G@=^c77(E>GPBfD;IJQA)5^6NTC1N01VAM58.D9UFg7SD^bJ&)JJF@Z#>G4OdF;Z
,.-XCO+d^F9GBETVeg97ae&BP).+I=3Z)D:1H9U@L<g40YN1d@Y)=KCW[O4-#Z,I
,C,AIeN?aN5+QY0RfAJ1eFZ[P@T=[3KNc,81K=:)6C^g==7DJQ+fU,-4829=7KbX
280>QNQ7fa1.HZe\MfF?;fF<G46G1bU(5;dN;RP<4g]:fa#W4)]T)R(9M6WKV0a;
44N.^M]#YPag07)0Gd4K_:OLCSG_+O6T^,54ZUg4;Y73E2H]MHSZA-Eg\_Sa)Ke/
9[/?4g_.4V6_Lbf.V?>KO/QNEg7FH7eR6VfOZ8(Efb=R4BI\U>/79CeD4ce]f46?
]F_[MVVE<:c<I\R/dJ#C,2SNE.Hc3LB]4\6=a,?-O^@W@;>45_P2c-TML8K0GXW\
&G>@R&TA5/MLDCeEF+0&>-87?cGBeO(QNb2ZPK,b/;:T,gD\@8/a^).EVIBO-TZY
:K<#Q9\[c7e7WDWJQ@4MK.]TLEc_fdZDKO[g7(I6H-]PCH+F6):bYEB\(X\HRF>]
cW15\9_Y#EJT:L3aIA&?WD#>83>M&T@I6]E40E#[;a[&_B\Q@8]+V+Q]3V#N#Gb?
6]I1KA2>4J\J<:049bZ1RA-N32<NAFg/\22K[d2F;D_Z,QUCA89:H9Y#8@FSS,K2
[7\DBAb+JVI):@L4,SA<WL2</KRca^;2..BgTYf>].\@T]H+SM&XO1HeO\C-I?D_
7=b\\c2A0A@,AT5[RA+H)JX-aJK67O5?=GL_aTb>cJ@@F8:6XUK+A>XY4B[[RKb(
d6cJfNd+(HW6>M\3\C7a,4b2H[,_QH^@#.[gE7BS&(=YgCRB-0;GQR0a0W#??aC]
Y5AH;@M].WK>>f6P:P18bF5TJ9)6Ca=MK1?()9MaPZSHCBc?gEf22IW@H.)bP7Y(
)>@=+B>/5bdS,GcVJ>_1f8QbM<Z2GePQ?Z)(9ZI1OTWPUaYB.[UH7Z3^S>:c5##B
R+<ag61/?QWQ^YP(f[Z@OYeA5Hc>MVPB&KZe_9LgA#1=;OefC?/U[/1=B50:>9gD
M)I5^Ge9:CO.E;4.3fagP6P7c[(H;=e:9d5Yf?AB8ZU[fSXIB=@P-K2gNGZa93>U
>d+W&;V==+7N#(@?O;+#@XPRF(b>X&5KKO=e(1X+\7g9TI</B[+(ec(]e,8RJ]&#
#TRaIBMK-?(541_eUJK@@AeD]1<2g0T)FC]LR]DebDE0=Q1g?dKK>4-?dKMTW-aB
a<Xag];&>[(PJ2V3Bec.:1JYYFg@E9&B8)eVBa3_6LgU-R(#?458IfCNS#CQF53>
FC]^_4c;)=K7fL7-=b7HcO[S:e^&OW;2fb4#14&E(aE#V;QHSgA^&9MRMXga3eGE
Qcb[?e5//WSVbGB>c1ObTcOT-2PQ;YE1YS?4FJW&](KHJf0KX[M-4a)gE)C9PYVF
&B@U;.dc-8;,1):3L(&4B^.@O2ZWW_3EMXeYPP<6:9<S8[d4OV[Q+N[/+ZO8aRS<
GcM;,:S9QEB2S5<6(,&\-^D:.?NIM0O-U3G_06KSR:AFfBd1XgE_(,&Ae2+8ccH0
R.c1A)ANfPX0C,/MI,KGY(L)/\-U2J_8LaUY5H6PYIN96]9A&Ed.,9.M\I)2F+a.
g5RN#.-9I0D^;]<&K6^N;,JT/JaJ?C01X8OJQK/=[V].AF#<5+QH<,.T@M,D9[&+
Z;./L,C+CBU),-ITA[ZAZ[YCLHX4[L.8D9.#NFPc.P=N].;P4:.5-O?NC[Ja:Y[F
8@E_dT.@+X<dE+)?1VbM,[CFD6>(VN:dWP&KVX/L46R+=-CAF4J_Se1d7PF<GVZA
V,_c)0f_Ja?5_e:cIF;AD0(Uc?>H6J:7E)OJ(eHU;/50O-AI24F]&8E;-caC<PYe
KLA6N^c@X@-FY8]YeFWF-[GQUTa5R=P3+;EWF.4HOYaAZ4:AKJd</.LJ7#c;TO0Q
8P4[IHXEPTQcEaBe0I0c01/<+7B>;,d1_3aG&A^cgMf;/LXW#2VVA&)K2Eb&E+/&
)8Mc-SI.,fM&T+#b,/?M6EM;39=Be488]^cb[)c],IOZL5L?:(3VNJd]_]^cFWgg
2c6TA:FZFOZL8C.4S[(YT];#D\1C6GCH9G/(]A9aC_5->=0FL[I0fU\\gb[c5USR
C+(e&bbUF6U97KK9.0B,f.Y2(fUgaOS#3KcfIF7#6Y;IT&U+@L^JW,.fOf/./7P;
5KC6,ZUCU#JE.]V^2BX9)J864X<CW/U0LegeITS_;Gac_4b5O??^=6WQM=5HMA+&
C35P45]?]2U3A-.aeJK)0Na]V@F2]#;SK4T4NUUf01RFL>,1HEdO]@&H.;)UM>^7
a1T(14H86dDC#/M\KBY0/dJQ#5c@AcW_O4Z0(TPaD8LHJ2S&8J;V.\XK-fMfYW_6
8R9F5e#2RI+@:a>TbGgOQG@E9cG=L-BZ+JE3&@Y\F89=6^SPJZU1V;0WOe&f?96d
N-@K-;UbgC@6L=5@FE,;8fQHbf_&\2]TI9RFa8]7S5:S]:a9OXE83_N:^:2^GW^B
]:()6:6fQPTFNWH+\\3+,C[D-H0@1BE#gJJKG2^=\#J<1(dY[DQT90>IL?IG0?\E
7)[H<2B[2<([U#_;K(B13T7LSH1e-(VZ#WY&g&Z?V6TG@]N^D,KSOHDM.GXW(U^3
;cf#TV).49+f-QeGT?3WY+7J(V07>=S@@NGK8#ZQ79@],eHb,LJDW75C[\?B-,+R
TW(=+?TRFd0+B^aQ7Q?Q6P:T_PV\>A>8K[#40-0>DX,D7W,aWF#=dHP+K;Tb_4aNR$
`endprotected

`protected
N)a=?\McGB,6:5V[=L(HV]&LbP<IE[dXb[O&b47AA3&HGRNGfVT77)I6D8-7MWc8
-F.S-@N3<aAXNe1EfH:[B/3;E_35H\Zf;$
`endprotected


//vcs_lic_vip_protect
  `protected
G3MY#cNZ:=I/ZL==EfG^(cFV-gT&XG0L/V?QIc/LO2/>C3cdL/EO3(<bCP9A=F4_
VO[BKJ\a8;M^5ZAV/N)D,9C)F=._6K<&/EA<O4PYA[G90N5=9H4VPfb=S\^f/g+S
a\(6/4REESP_MNE+e&?PafI^[.5X4/Y572bb=O.QfHL]@10NB7Z6PA19H=BfWdXN
P],G(OAH.NHBe9LGS\4T>GV^Z6#2G^OG#DSJ>)98JgYOOYIGKTM[Lfba(8UL0?E^
IeSgAa^aP1-Be-2A?=Sf<L_J3XI;Rg(H=J>DS6Q-_7/)>;g.RfEX&ea8>.2S?KSH
a/>[d#;_cg]X;&A[dfAc85OZe]J0_DS318LX/,UT)ceBVX&@=?8KCFASa#f]@<#g
(?,1:a05W2+\Oa-51Q9&bR#3[8HXbNYCcO7QbfYeWY_K&?8=c7CG;K?OTg7?/]Ha
bcQVcPK\.;C=8AaYH;GMW6<\<d==3,ZL[2W]W&W):G+0AW<+9d4ZKC_.a&@QW+g-
4PQ7<AMG6GRf+4X8\R9H@AaMCY<WKN6)gM.&QJbLUd:E/X).2f0g8.MKd]fHMfIN
,FY)&G_OACcS6]OcK-#HGYc@#&RD9:X4ebV>X=0cX,EY^?C<E+]J.?D/83;XI8XU
ZR;WJNg6c>7VZBD8&TBCScN80GfTO3J10#3:O^)d:[d4[;^ZYVdW,5c./1UdPZD-
Z\.0L6(3_KZQ?ONb^;M(d=:Ld08daDP&WA<D4/fWZ@[c;ZdP[;^0HFcH)X7JEF)=
^?;I6[,eBe7e?X\FDR?SN]N?Y&5C9ID(F0[\14+9:]>S6+Dc<,WL8T@b)BN9]GC\
L7-1JQSFQc6BXOE[Q.)[aHEW[=KK]72V@#;Y[KR4@_P+H:FYAUKfKC(P8>4eIQ[3
3aUTP@[bRT5=U6DabBd,UXR?PQO8^(3GC,?NK1D<-V.Hg<bP?C4FPQ_:9]:7=0)B
P>fR:?<E/_7<cHT&((\>0__CB]f6d&,A>gYb2585C1c+Mf.OU/T1?-<A&gUOV@D.
c>7_B=J,U_NVG2SQ325+ANPAKPVU=E60ec?UX:Ma/S4Q@>LD^1CYUGJ?b,WAI35-
Jd<@-^(XLY-f6YS#cG8CQ_>SY@95/._F;;-;6S+bX(RK(HfYfd27GAab6H>Fa9IH
_IOfgN-QF>@ggH-FSB,&E>Tc8T8N76Zae)dUZOD1DC;4C\8;MD],eZ5QP@b1MHb?
A+6<ScF;Sa+;ID&Nb&KX:bgUFF6]2#4Q_d0\6F1QN^Q2[SD(BbZ5+bF7E+5BD89g
CJ];>O-PaT-_O?86_]c/DZ3;25AET3Zea6FUO9]RM1^.R[#\D/]+Db0/S^?/L.RM
1]MR@F\#<QA,NbKf5^N&HbB&TeI0^T4&X.d9bT=#+@6];60KX,OYGKfQM;g#D?eZ
8?K5<:e\)&P.6HE>(?U-1O0440A+aBNPL3+])=a8+PM+,>;2VQU2@XLG<F&#2PA2
],Q]X7<F=35Y8@fJ2CKWKc(XNO67HI(g-TQYcWDB@3+H;;V@SRgW0_28(\O/Y#Nd
6VX(5g9B2SNB=R=ABfZKQ0G)S[<dQ<[QH>=?]G/UG,5-E\fI;Nd02d<64++XBP_M
N@:[CSg8,X)/ULT\F&K3EMWOG_G>BUC4OFS:[WTU)4Sd,BAE(3@O5([DJ4TE4JX9
M/5a5[9/+Ac0AEgg2(?#a/4&4f<>G#SMa+ZL6,3-4TQK,H@:Od[9Ef]OU^6>.?I<
/.6L0.=G9X:_SJ37Q&]BBAT3>WQ6XWP\NZ:XG\4+&3aS\+))TH2>dPd.,4b.HaC1
WOS^=fFZPFG9C=CIc7VA6PT7Ma0L/:;]ZA)HH>T]-/De0/6a0Vb6NEBDZ)LEA[.1
f69:MTc<QSeI3gTT=dQNR7?gT,TBfbWO;XIRN9\&7G5651ZV?;>a]TZT_f7P<f7K
aJCPAD?,F\5:4LgS8T]<:#:aNH.198e,>@)TXJ/Y&47ED7GW+SDR;+gA[4_1a?MI
T<YIOD1;,8c=I[<Qd/d[CT_bS.WWBW0PL(a:W+J:@5_ce<9=^++KR=L5\2P-22JW
FS2e].<,\9+)7XMd9)\[b9ZW],,YRJ\LG8J8Xd/.GS8K;EZ@-47,71,=X?_(@3&f
g20+X_EZE]82b;fN2_QY73f;=?D^<U<9fB3:S,WW[V7C-.Y;>@KF@+R2@X),6RU<
<;HQY;,b<X1&(O;?S;B]8_O;Aa60YeC84D)B?cJFTb/R9I\0<fU=TON4LOUMd0Xd
[3O>.3bAYHU^:I9659U6XYR8C_[85A9fVF(9>e7>-,a&g+^5QO@F:<gM?Y@3ffTe
7[)HZZE=8NdVfEgC)V4aN0R9QC9L?NdB1ScDT+VB0H/H)X(A8LeI5Q8H,\20H)4T
MGK<;7TPDP)+^X>/e,cE:HCd(#Ae;[/90g3I1&cF[eg;=QaT;&M_E=C2Qe5dKR@Q
VGd7UQHf(OX[<;<HYW\S7f)3dF:4cPYKD8#QeB2B59N3Y\/LBA;X,[d_a;&S#V>X
bbD9F_H#2NePP]-OP=bJ:IQ#6UE,gTP5.\>&EUPW::-X(5E<H39.a_SQ:IRf3]&^
AdKJMf4P:NfI_>4^<LHfR5;eN5d]W^N&7-1SD,:T#9PZ)HA@6[TT#VAKQ0#R_A7X
CYA65GfT[LSW-ZX_U0H(Y5J\FL7LD4]F/PMO>LB0IQ-a;-d7+0:+=[7+6af4bDQ)
B-/9g+aBL>T=bcS\RfJY+Z-6cgNI,FSTbI):)_P:&(N>DLUf5SX.MTDVIAMX-#I;
9]F4e\&F@YPTb>8+TT97_^@)abbTd\/#@K&JdfAWgKQ[gE[cUR<X)<5-R7\_L+W\
_G;#(8VY^4;,_X+09?_4IY?(^;1KNd<085,dSWU>\XH4(YDX)M+=F&2@Q4=EJXU,
ZH32?B6\G?d-HX>&Wd47\KRfOd;3HH87HK;GW4UY3@a5^M=Q_[M?.VaR2c10][R2
&gBZ022TVGG=K36T_Y.@a9bF[Me)BXT_1X[?3L.X7R?=IY\RK.Qe,N]/&^?11)79
;01fEDI<6-6K57e2F:O^6)TW[=@[EFX1@-74)3EE0CL]PS_?/C(0>0Qf.cJL2B+^
df6NMYe=OWIDE?_<S2DHF^VCPN^XF6B8WNX6MO+UW?4KfY/=;Mg0Wf<8F4D4^K(d
dUC68aK])0GU^efT,US6V-4,/:g:R)\37d7d&__ZI^@7FOd0G.aY[ggKX1ga)bAL
L?3ZU[8,A9eM^b8c:3XeRA5#a:RGb>)a7P<1J4OF<,UML\;K&S1@RFd7Y@?F,/52
A=,G\Xd/WJSg=aM(2XPB:[/>?gI]#J&@/QQ39&[1CM;#L,6YA)g8__Z7G[VH++EC
G\)T?4/2C.Q#4-VdQ<R72Q]<3RC<]GY]d9:3BCB2MST53e0aP072[H&;;^PJ;7[Y
ff;&NWU-RT+bS1\A:VPbb0gU_-IJJF>JO<:GD6d1Y/FFXQS-:,N/K/#cX@I[Ib05
(#J,]=c:=J:6D@g#CI5MbXdDc+P_e0gSWY7E=Sa:6S68PA9V;ZHO&fGZ@FYU32D_
S<_^\:aL0:YE_0#2G]+6Rgb+(?cR@&O@RG@d^+EG7YUgOe#EK?CK:5VFI?/F,.J#
&NMCK[2)@PXOJ^D<fL;;?a7I9:6IG+LL@(N<HW=63OPa0^WVAW#O-GD=9^;Ob3<:
?Ka&4E;NS<SN=V=J@&CdGJEYOU).8[RRdUA6Ya/&Tf1ATN)],ABL:E+I\W;VR.##
gX6P39@JWRE\P0_I>V-DCdE?RRf:=62E-(2ObLF,:RTLU-)=A3[U(=^MDEI8>G3D
\6>@GYS4UE\^WHH#6_M;(gD[V<a.GS^+4E<c,e_dJI0-GM=N/>Mc+_N]>?AO10X0
)C]b\]L2VV?H6_d:)Hc<K(S4R+b=5+Y^.6DL&@HD(U+Q;QdN0AK2L;G4+@bU0WV#
WPbaI>=-U^JJ4(W5</WfBgLP=X6[.P_?Q5CW\Q9<cDK)@H>gDC#7E>E+,B)^b@Hb
?VL7Z7.5];QeHI]cP;S;@+>f5XAK8:Tc>5ARJ78M?Q0)N19AeXH&R^EVNA>/<5.N
\5A1FT&4>.HQ>A4N(X\6LG>bD.7D5Z4,e1R,/[I,b+bX3EW.,87C861^Zdb(>I?W
=#c7-<3a#94,A>TS5dN/8:2e8Y\S.FNFAO3L:YR:a[8:<:F5JUY1QLg],IfG2[dd
+g&&[bJW^PQJAZ@(D&DQ\UeAROQE3_X=a1-7)<_XTD;QZ,adQ+VG-?S&AZ&JQ.Z[
C;OJ3[M3.0E[LWT/c6,&dQ;GF-5RJ&17N:X<bd4&,)+9b,\YAZ(37T66I)=aC[D=
OYN.)cX978__#_B=.+IHMHO/9_b1^[BQHD7+[gD=@+2_&33LT.70eEFXD@<5gfc4
P,6EM]@<Y=W[6)9+T/RVDTCW5RGCeZAJ[]3<FAW:0-1/FPDU+b@[;<b+PJOC(8:N
P\^F6a7VR6W?ZL5AP.2#,Z<-,G1-b:1B?.\[X@&U/0]PaaE/4:D\9eXYHI=_^EE@
^:@[@K#_=aE=^AG2TUd6WOKX@e;HbEQQ4-79=BgNK]LH2M#FZa/]-,4K6?I]#?,I
Le@b;/:9/0;5B/Ga8a.L0c3=)RJ)M+></W]HS&3W#=?J&bH\OZ:W)D^G26Xa)SCf
Q_B3#X4;-1P6>IVg&bRec][C6XM3R8LK,EfGFI-28:S\45UA)dJafZ/(J/TF4YKN
aCa2HI9e#aPH4fPB5e<W9Ff7=//BUB^,D=7WQX6+T@^(dN0I2YP)S#aD28V23YPA
8/W954@)\IaR<&TcHL(gbTVW&U+6&-60?2AS=(4MGdKHeO\@fY2aH1Z7cV/_KG&G
TZfGN7[F2V<F(C0A2Mf_65&>I/N)/[#>Xa/7U]O(C4K8D[N5=&&&e9Q[AVAF-?FP
P>H1BE>CL?33<.X7S<D19Sc003KNd.R7IGFQ],4T25UgE(C3[XD5/CaBO-?A>X?/
[O>:M]^6^1&@RXE#\S<X^aB3=TU[R]V^P)..6>Z4g>.dDDe0?H=M.J+Sc)4@W8-\
GM@OOYaQ49]8>fWd]/EL;3@T2-9RCBUSC8(@Y?7B0XJ0Hg==gA0IQFXS6TN:ON2U
#JB5-0+JA;<630U7)K[,K:QEF76AKdRfS@d>>=YUDfaAf&W[ID-B5)6FF51?KAWd
H,H9LW-e-TH7QDU@@d\ZL^WGT1L(&ZeITC2_VXg1S,[AYIAL6DZKWN8,BZ]@C]7\
M3eV@L#XFZ8:NOC]Z^KEY9=+5MYL&24<:C/bHRO79C<gc@RB)+S2AQ9^Peg[;JU)
N&\P1ALRTc;NDN_5T24D>:g<cfd?Q8##\I8\B9Y:QXgIaJbC;+0B]F,U5(:Q.\)J
:NR\PA-?Y<JB1SDcOF)A>a&5Q?16>]PNW_8=XWRGgY:a_+ac[H]R?D^Gc3>/#@-A
WI8))&?#8d6g:OWI+&,TLf9UW/5+U@_6A,/8Jc0Q8ASE4I&[C(4^ES)([D.>H0I?
[X?f2S^d&,/(OH<^P;E#-[a9Z91GEN-^O&NXCNIDC_0BSA6\E>5[U>CU;0P6#IJ:
+I/0OR360@dB]?b/ffS1eS>#]]V=)/B/6L\_M(9:b+.=&BgKUQ92,(H85eY@R)Y5
GXJ56d5T]J+I?]<):.F_+#Q09fUe<^FWI:F5/K@HK-]9DEV<]dJY>_\CVJ(4?=L,
DBJg/+(:CdM-<UE7_LLJMdG3K2;,_A+QIC<0)d^#.AJ3aCXB=Y0T\:BK#F=e3E12
-&/gE#H00ZUDdcY+f8d;=;d7IEK?Ma)DJIDIF_H)3L8cX+0E5Zf##ZKH7G?U82U(
O[0:Q04;>2X_fJ(ag)>UO&]XTT@VJ-c,c.c&+-<,_DB8JR74OW)@X/2(G^eRAIFK
B@c8bOcUTg&+SF8_eD\H(CAL1QYF_Y#V9VTWb-G[G.Q<bW902#R#@HF]H2[_,C7A
?LUL&c;FOKF=B,@e^90eRV_)[eS/BF(HJ-9)I+_/4\60.GKaN@e&GZO[<G6X;E2e
2@MFP6N#d<:_39ecX)9\Q,]dK0Q&DC219:ZT)d#0gSQIC=SQLYf,IBL:Z,)b+KZ5
,._RH#>X7CR-KHFUL\C\/T+SXV.(R3g>J\7\>Q-G(?[0N?3CIJ1=EFP0E[Ha8U\Y
95=BSZX5Y@#g[cNZ75B/aPWPL<0MS+9+ZL?JNN1N]@ME:RR9/Y&(0UTE6_>[VLbM
OPgZ[g]8=G/R;XW)@&?<X\BM8UF&W<[>3NA2gUd)\<G2_-])@OV@QGE,efORQCJU
MKeE6bTTY=[18C+N3R^g@:FgUT,Ted9IBJg9V+G3/7QWa>;[M:[3)X^eQ]1];&Y_
SUe\)#e_#E)_3cC_>BU;O[.)5>0+]1_#:+<1<CR@.4_A/6W2aMcST&GTW.\H)b7R
O[f@4];SOg;KXAT=QQeJED\JM.B<fZ7a0TQCTc)85RG4NPN/G)^?EWd-Q[R:(8QD
5A&L6E7]Y5+[d^VUMJZD3aVF23&>P[_R-QAS/4E@=UF-=K?<>A:C9C1G4C?\_3gY
a,LaIObI2F.U5ZWS2>I]M3HSBKR,YT):7>M\f@Fe6XA:),A],^e=D63[A+2_KWc5
2D(TGTad3V]</_5I=ZccO#=#.PK.((4)2#E<3XeO#/;,PcQ]&3+)#^XR9NIMNff#
J,+feC;fX63)ZeJ&3c+TJT>^5TK&,2YF>XK^KBFTBdOXe_J+I,S3=)2:b8ed6Fg=
;(Eb1+cCPTRbgdRU;4R-H,USNKWVFXH_\K@6>aRYZH.PQ=6E;52W@ge7BLN#dII)
cF1DP/6R6(:8POL:=>,RR&QL:80FNdc_)8WTCb:YH^TS.^(8N[RY.GW67.M:^c=;
[K&<C\A0.GbA]]5FbdI=#?VY+?6A-d82a<DOEKVZDZ/^<WgLA^-TS-A&DZd8bGZE
;\VR#AT^+?K;Def_VWQT5HK0\L>.N__Vb[b5_D96S15FGd]WZ,OJ[Q6SNE@TeHN_
/DM;(=Q][QX42Q[]_09UKLMD@gI_dED#SgATLeEH9I-OHdJb>JW.RTE#VJ(d<DM9
bgS0c90>JFVFH[gSJf-ALG[(A.13W-E,Q<H#MI@>M;CJA-,Z]5fGRK(1QK^WG-FU
#ef>J;V;44ZRCEA\7:/F8HM;c=fE0M&F+?[XP7DDHMPI>C.L8-8#C-_#gH.dVRI6
G6cdWD_C;>f.)V>OR^M=J[G4_DgQ?&N2TPf/#XJBI)&Fd\H2714=((>)_Ob27dK[
R>^I.b1?Wa[5+KR.-SA0[:g/@K@^JW1RJX#NM]Q#TS+LA/<afBHKWPUY677Z[g_T
b0N96XUXP-GJFMeRXWP>V->aFOLQNG2@2>QeROUXNd>D--)g9OJ=@O<I,\K3BBX&
VO96&MaXUZU:F=T@/)2fPe>O4de(FIf&T\V\2G/[15^D9QF,XJVYJSXP_d1R4_UG
F(/.RP^U]<IQg3B9M9/U(EK[6^#Nc[3>Ja=)899^/QJ[ZVd-M-eK-=e?H,UN)^@P
Q27=,c)I=W[TOU33ES+N<8a=+Z[V@B3VD&HAD,-0DZ_\5g]1)>3ETC9M&TH?_d/c
<Fc=<NWLa.d4B7Vc5Ec7.D8LJU\>F7@b5WL?f/[@?^Q-DbWJD4a=,4Cb7P^Y?;4+
bVTgISg+ObAUEDd7gO(XfT#;&_K4+d0;e05b;/[fc,McLS8)]MGKJ_6Ve3#/(BKI
^L^+G5AMVa1;0@5Wc;8Q96Q9BK^T7dSPA&M<(MT@6UcBKAT4EB,</,J@5R@M4:U5
fOdGXS+2@a26T@beS+ALI^3K(NJA6Z?:,M+3)N1dPXf/#RNd8L.(OR8\e1e35LOg
(W+T(=@bVB?@Q)@RTN@_H>-YN:bGJ(HMd@G7TRG6OEV)JJFa840/GHL[_M0/>aV#
#F2U[I>@W<a#)Z\<,81/=3B/fg1R?N(@#.aU6a]GbVDb2S_6(N+8e2d=XbI)F88Y
\@-V7F=J@,^H##.DI/IG3LIcN,5AJ_gC10+)f]VXTN#_Ed[V+KLPB.B+f(\4c3.U
DEf[>B0.)B4<^R[;,A>K7#U:OA(W:93L:,:6?C^5Vb=>?ZV]72<C?]>TR3P/7+CL
\G:Z-?WRD&41-WVdSVH&UN08O.6<++Z3>Y(-:TH&aXcB>3L6gXFC0:D[9c^D:(=0
#S(MdPX5eP7K(>Z^NVHCNW/X0cZ(PX_1:U5;D9QEb[3Z<&aW.GXg4+CV_RVPBL>V
Tf:fOYYGPNR5A^JZNfH_;86P;-XU(2H>9#4a/XPP&VGLJGW/)K>R;?T3E/J(G^);
e6#DM8T^<a@3Ie\.#RF20HW/)QW?Id:E)M;aH\W3/a0TJEf7=C[HFU1@=HWVU(4e
O&.&\TCZSXaP0ZN&<5/P3dM=MFY&AaZZ9c=\6BCM,-5_cc-\1-_gIg#J8,C^29aU
[V::HHB\&,4#;]]ae2J,T@LBe(Qc^]ER0V:>GSR;.6UZQ-Q6.PIP)_SGD]UAXd]4
)E83_HQ]Q,#81bV5M^X=YL?QV_>2_:0ZPV8++QZF(=9#>ge63ffO1418\5_#4_FG
UacKO7BNL(50HSE;bT20MK78b@3^:^c=TGeKU9(gTG8QLQ?Pb92G8]Ie_?7BQF)M
RZ:?9)HVeIdYZR\Z8UP.:0,-?^@;IIb]MIMFd2g.S^/R&:=.]<#b&P[f:/YfVag8
E3OJQ].61IHdFR)R=>b/H#dM3-R_,S=[c<ZTfDX<^+^<N)R6RX/#N1DK1&ZdBSSJ
T;Cg2?f6dC4E9_N--K>L^R?N7^11A4)Y<O1[V\O5HEZU[QL-d-LU0-eAV>ZAf<TS
O6]d)=,TBcJ>LK+Gc[6+FVUE^LK7b^Sf8M5DGAA6@9.D_RO/\#XWbIbObV3.e^4.
,?JMU<0&3_-#X4,cJ1]9D5>H&WIdL&Ze&e#H]G:.-Fe^#;#VO-ALTSZ@_><D.X@H
F<I;<f>dLc5,Gb9D:fZL8LHgCad_0B6R)d1aHEAZ63_b?<N&gSgR:??,c58?eS(S
(F&7O&G6/[P^X_Xg(Ee&1ge8W&+#[VHM1[4UL7Kc4CHa?\WEZ/(@XR/ec\J3)e>P
HY(:^d0:R-R_7EG86\d24NM/Y)<W8LU8QYJa7P:;#(#AB8_G_L(-A.OT^&bM\553
@;[b;?,V<Y0U-2OK4LK9>SIERN4Yc&M_[^PG9<E05GN54W8c-2cWU@OR7SVE:f8E
)H;T9M#Pa9L>IP9AXF?VT(CXd:3_O47^1W6S5aH2,MgMH_F2J41?92:=@-25-0+[
4LQ2E<\ZS#SDAL>0I=LA43UV]d2/@0a4??fRA3PCbRI[fTST_Qb1]I=7@g+0;5,C
(4P\5Q[,8#,T(+,2+5(=f=aC/?Y177:-&<0G=g?G0.dKa;ZB9SaS2._NN+EB_3?U
dCVUQ5U.-_U9Xf0c9G;C,d3eV((EZO437AG[&SDQVAV6FbcaW:<L,#U;,KSL0JcJ
ET,K4#gf;6K=#(B3&QV>T#H88=E9(US1U[W>=-/X9=G_6/7<gW9Oa-5^beWP5A1Z
E).eWV?78IN/e8^20H0fL<f:+,CCd5bQL)9\\Yg331cDZg9&)K3RQ9bN^c8/I#a/
c4L&ZR[2R.G:YX48a?B:HAcM9g-e7OX=JILMR.NP?S7\A81VOd7>0I4W7EC[Sga^
58edIbJR)S5_@@#AI?D[e0Aa<b#7L4S=D3-^LdfMJP+8d4CL_)D],0)&KCJ-9cZ^
>7P-,SdcZES@0D=;R&>02)^bLW]H>c6?Y]QT_JJ\ZG0E>Y8d@.>&c-)@)QC,,062
;d6UOfEafHZG(FeQSg+3PUHbKY5_9>92B#WfYLE2/Uc#e33-#NTXJE#ZE?-K./K+
98FWFK\cI78TXc0<AX\,2^dE>^U]8BDI^A]))g+f)a6PU8XMFEH0?Y1(e3e-+3V4
SG?--G-J>.3_X_X-:g4e.Xf4A(/+ZQF0&\&;=1L<AbJ0UL-/92^a>C>\fCINL.,P
@f#W(+AZEFd.;PMPW0XASX[LT/PD1T9CODFBK+4ALP&J2<=b?c>f^XE9d3/#@-KX
TS\g7CDRV-RF+965J@<<(,72XLdH_EdG0IBO_WcHd[:J:S1AAe5eaK3[9+7WX96O
.)V?5QT0E2LT&9S7C?:F>../=_P.bL?N0.?TVg)PE0=7B,CX#U^.<D-G-5RTT&&U
VXcKcC?RZ?H66UYU&)+VaPEeGbTT8^fIYR2<BK0KP(R)4&c_1M.FGa8b<SDQMIK5
NLafeIG(fTdaI>=[eE=+J.>@8Tg;#b>@PYS770/b]S)1cBeG</,XW1MDB9/0B->)
/DJ>aZNH#E0>HQe+>cQ,>PR-e+7b2D.?C[4Mc9-1(5\12-A)]Z(_[(e^8IOAS<Z^
ZBP1XF:>>aNXZ8eGG8>b.2f&OQ3.Zf=.gRRb7Y.aWMNWEZeMaFO(9=1W)[d<BZ(9
?&I4D=,,g;_=[[K;c6bQI6Uc;@9&c5A^KD4LI@VEN8dEA/3#THVQ,=E8HAUb5GDF
K1GS<bD4_8eLTe&(_04YFP13-3//^d?DT^3C/0.F3]4?(U:AUVLJZ?@bT>C\T&(R
G6FY3W1H:8Ia:TD1])G5Ta]XZF:P]74@Oc3QOE?DEZKDUYa&[c)A[_6T,Hb1E1Y-
b0:\ZH)KQ;aJO<L&/TTF>;M[#8agY7fW5QWY2[[2EZU7NKSEE]bC,8L5GecT1+=g
W5RSEIg^1_</3]6IZ3/+,ZFX7F=L#aAX)YXH;bK-Cf8_g@\_]cUVQ<9K<&2\;X/C
/b2@/):L].b]3gaG9N-&B(::#]b;b=J6.OL3N^&2<<O[@D3Se,D@M)bdD)&I\1=@
Y&0=acY:=01TRdIS7NKY.&]HM1KO-=,,3ZdRXJg<4ddDIFC>H^J2c#BH^I]B\,1_
1G&?HD@B\)(ZB)_(bfB(P.Z?(GF,WKeXda#MG:0A^&(T+W=e0NS&SG@E_7)DAc?.
3)DE0fYd=HTC;0B3\P6b07HG75caE\/N1g72C<TYDNGDTgA<egOGgAP)Q4[1-^H_
bDGWFb3SaGB)&Z.HV&CY=cJeQ&E=OJ-We^UKf[0Gd>g9>L5G<PX<La)CQ)<bQf24
&b[&/T=K<WY8,VT=O7cZc@EF2^^J9EYGA6JD@4<8B6;[N6=_C7Z#A@Keb8&@DgP#
@90,ZZTcK1]AE1Y.A^0ZgHDYQdcWb<=)NdVba@ML#UEbS\4A)W:4K<UO,K18(3MY
bAXMHadd)J.f[>K/A3eD9eWRFEYF:d0WJ-P>D)6/M)]89^U/]&&d>N@c]5-EgSc\
bTVgg>O^::21(e7b)MHX,AZ0SfSS_?XVUH?GgBN6FAgLB=JG;;:,1<&/OTH&\^bI
KTYYZN[cE,>4P6XH8[ZYJ16^PE/W0O-:gML+.,1LZ_3#cJY^D\LYKb&)LG:>/fL4
6&MP.(I(L&.)#I1bJQLA^B3/=[L#@^\RaI]&gX@][CFa0U,DMeDJ^)a2(L0QBX-D
/=\a0g&OA>@JZ36]^J6PL)D;#a_fQJK?GgQ,P0d^Z=6;e-CIIE-eKP=Z?ZU6H@\=
,4b?4_:d?K]J\3C8?A6b;<[LZE3a2VKSXOV<7\AT@HJD5XFK5Z&MY8d3dEPX266,
<@)NVR7PH-5X=-L\5gQZ72M[eSH].;eDS>92>,CJO87.8]34K860[L@]V(BSX6c;
(W)I/Ld=e8#1YcDOc)X72T#W-7K\]FPCe0<G:H=^-:,bFG3,AP6=I:D1G_E=#/BE
RPdb8OM4\@.#)b+Kd/^:YX^:MNP>24>@&\+3#1=XE8fFE[b-QPZ#0:7(ZN?+Xf+4
dN,dYg+,@=-16-R2baC/3R=0TKP^acFa,57T)[<RcI?ef5Hc&6fQ?\CNI@Y7D;X>
VSE<K4Nb<]L5G<T>RY=bI>-SPe.8E/Z#0[AHc]b[Q&#AQSYY0R^[=1Ob+7M^=:-N
7@+1(+D/NUf4K3Q]bO5,VH24]<H.MCLQ9QRbJG=?Ob13ePdH?&VP#2K495aFP[e0
&gY(75.AUI<;UPJ_gQ?_TE\#W;Rg1b+U_BeKV&0^^6-S+R5?&?-B1]F8;R-37R:\
c[OPAY9D\0323<TZ+3V+_V)/2J&V=QJ;)=AL5H?R+R<B.VeO:()RX_bKWS8Q#eA4
?ed2)g-:e&23^3GVTF7O(L@@[#f=TED/L,V_L:H0F5Y+2Vg]\U[>@I2&D4<b9O>Z
[GPVQ?--+V:gKc#;3TD@M2+<>^]5Vc-G-aZ]Nc3P,#PS:JYgP3Q9Ea&4&^B1)/3S
MAIJ4@\-]e<6#cYdg#928]IN00FGQEU+(]-00[bg>KH81FQ:OC1eI(R9b>S_)O2Y
&O6A-&3W-cUULK#\(CVC7M_3-XZ)V_V>F69V+S#fWP-@#21;Z_?N(f[fJLBAKMP&
:J=^M1Z8ffP5P3SKN:/@3?)?LE>LY7eEeH7D8A:>afU,SNFVAL:^_Vg?Q8cD287g
fSEO2FI-U51>-VAZXf+_gSAJ]IAWW,N@EfOQ_<?-(c]3&K3[INB=M@B:(548INR@
^4,.e512S(/9Jff#HYF,,A]^K][+(W3E(&6A\AM>P1Ya4[f5DUggY>fEg7FGH4N?
E?7EbcB>L14b-ZaN5^JN=R1CafFI4RbVRD8MI]].,YLJY7c[@3>83UdPg26O=RP>
@c51d_bNB49_.Ec1c,?LLL)1=Y,L]7-Hf4b2ZX676)Eeb<1=?]6+M0A=>Y5D1NcE
DNCB2,/e([I_W&0,+AR&FK(35Q(&<RMg4d1[DU4?-+GQbA;1GJAQEM+(eBY@dJUQ
1R#5>WeB_BT2&[X,?<Vf2KH[.DfPCQ.:4771K,^cb>@F(PJ?>7F(;KOL-;O[.;7.
F85TG^ZE8J(=2dC\7<9:M-DQ^.I:=<@<:MB4^.R<MTH^W[V3M+6/)Gg+/N<#MOe#
ZYf\eFP@I5D@LZ8H=f_<^:<PD97D?cgObOOB,,AG[LRON>Y4AU,#E<Wf\Q,#dK\a
77W/fX)[b,T.SWeB\cddMKEOH/AXU_DcNB\bQ=CS<S>-;;7K=<6eJ,)6fLR&CI2_
_U4,W50O;L>X0AM(CcITU6^JBMc?^JOG&:O4RJFNaD[SMEe^7c3OSV5_]YJRfgN]
K;-V:10PG/JdLF:AO?E2<U5BTd:dII:EY.2>VX80GJg9Z9N9#);W>W^1I7@UEE\?
+YbC\8SdTd3F(^3W=.Dd<BO4.Y957c+U8K4X0_b<.OM#,aEB?.3Sgf9^LM?:,9C^
WcYZ9bce+8&a=&7S7.fd93B0?N6E?aN]6.:OAL0U-[.R=?b]R?S8L[\RdFE[6JP7
7LXd<^Y_>RNE7YEDS&0&?2>E)_9MO]^eY&d^&gTeX6c&=;TIEL7Vb1eTL(Zg3(U5
6dE)57#0fCL=V;_A-5QaRCdUZ=JJde_S<F8@GA@gf./<AT[3=QI7Lg,NPFWKHT;7
MXX\2I/S+_49PAOCc8]LP._U([P=##W&4a&=K.KU3[?<XU7L20<dND(VJOYCN5c/
4++4d2\BM@6[K:8cH&#UB&C42YeM]/a/be(FX6_#R&f.(=.T=P^-]ZNN.[bN11+\
M.2-.FAaZH@+g?NXEbf>,PH-A?S)?6I/U@#2J035VT-OWZ_SSV(2(BJ:6K1VD&Jg
I<_?NI^ZY:,;\bD.A?9S07\H3^NFaQ2?5UgW8M@6(XO;<S<c)bB+ZV6SS^cIU[/C
)(Y^cD5>>:5Bbe+dQdf[LRJg11=/@cN7[fV@CE,>E:G_XSRS(L-((#GH.,HMC/:K
I](aePPNU]4EL):IBK1-(BW>e+d31?8fL(ANTT<N33PJ,#Y-]N;G74QV79UfP5eV
#EFFP;Cd)c=R2G(9PN-?e70WH31XI3[LY[,[7Z<Z8UId;_Kf7)])0SQb)#A.NO0Y
,A[M9c&K5Y[4(ZPE)]DbU:LNI8TbedD+HJK=)aJ@&VK]F/X;39)/9-6MO3bE+PVS
EcB=H?7877Y]>e/O&Hcg<M)IQ.EH0VX1LH/7:a>P3ALMAXXR5-M<F8Se]0B?&e>R
g?PB[fH8W[2^dR]ZN?3gUb156W-6(2g_(F]?JP:(Tc,8eC^\A#E<-J9N?T=0H@+:
_L_05(.M^3EZF>HWGTR<dYZODY1^&R=e+a.WN.PU\-MceA2@+;f/P^G+-_a9^VbR
U?13CRXM&]?D6()U7ea>=B,G^0c+6JV)VPf2NgX3dB+<<8aLCW0W9bY16\fJR;80
IgT^-5(I)YDXD.b&SfcVaMLGM#>[>]>BLA\&??4@-^BVf/)e:[XGVYgHe_;+@4>)
@<WNIC/:AZ&D+^f6bgIe4SfKMRZ/cWK1/H)3@.6dP9T(eH:@)G+VW6;7HS1O@8)B
4Cc3U7C1UY(0N4]MIcMGd;Mb;gQ@KCS\3^](+,\TIAT,LF-4aW(5.U37Z<N6Cd-?
YTaVLZ8V9Qc7OHODJK:H@>MJBCK,M0<UL5>g8H;QHLP&D(/0Y@=0SeCH?3V_)&X/
VO-SC&;\X=MeMMf[9</)UI@U#HKRXcW#;7XHI_K-B):6^S.)g<eeg2f4<a@50P[(
Md2A/]Xg+.DMAc\)RUMHfA#U0T]F7<_,)>A,cQA50Pg+N]1D7WG?L2JHcUf\@VN[
<#9=2\4&4+Q.-,G?)<D2M<gUX\WUa/N_VC^7X3I=#?:WM/=fY?A/K9.L.b4(UQ^Y
1c:]I0O5a-MXR/CM/0ED@d2ZR;;E>@R@5W):,7@</O2_@/a@5E,<3?_[04;Sa=d.
WH3EI9E>08M...K=&55S2&Vf<RW_Z.?8.b4JBU@(^:ZD(_fdKDb=LgFO.&1T>E;?
<9(H92J[TVeB25VAYKHQY\a^]HT5+b+[:#PW2&R,#0A;KAJ#L09UH:@6@;PdXfY;
;1+/a?HRa[Y-@>-<YJ92MefA/9J,Y4.;S@R0D_?1<bH(8-^U.5S+g@ZaABAc+gFT
)5;3XT[>@L@PG,(dF<TZ1+,R-Lcf5PQFcQF3]E:0ZdJ])>6-[eAD,_.;7)6>T0AC
KR3GW6+++/1+5;gEY)ZR5O,,H]S:KK?39.1\/L+I^YR9gMB=4>FACA1]X9LDagb[
&WW.)IL5M(,.8fK(5)][75N@:[D4S=?=)^c&G52_a?>1A^,Vf?99>9Y3EV,V3aM:
6P?X4TL(A+8(<S(-]b)_-F^.>8W<Ud?\A1]8MS_]+GTSZ1c7a<J\)M,=AXWF)d0Y
BOXbQ=^11=#WTbW\F(M_;[c(2E>3EX&^5OO&O6HOAN.KfNIe9IK6]Y.MNTA?#?;K
&BS-QA-f1JZ>V1W=P,1g71CKJSCg&U[DLJ89c7NNe6X>,5#G4XJ:GgTI+//O&cU_
=_b#O2[4>6<#2H2OaZ--We(CNB&=0g482/MAd2N3YYac+SJF<8&M@=>N41[4.#Id
J]DJee1^LIN&.06=3^af)H5,a>abNJ]a<1cN93<QHZ^AU;PEbQ1-=SALXLF:dO?9
g2CCU@dN#H]BV]I+N?Ta8ND+Sb:=KE,-Cg0/e\=UUDfFfa[+4UMAa=g^2O;&N:2g
;.Ic<FFe\HI,;G7cURE)5VY5;>+V\1NN^3;S,U):M(R_+&(:X^gD&U[LTCRgLMXR
VCb?(_dRP)4)9DM0LQ658c9caMKIOcbfDZLJg#>NZDU@8I962=U@M-:7e4+]7Hc=
?Q)a^NR8QH^8Q6Y]3=1APBYN?5EGbgf6&TcdQV.Da;A)W([a-CCU3@fY\71Ic0,N
dK4bGBHdB-5NLd&Vg;V:;+aF3/BPUgU//^,XD/fbU<#Rb6J</ZUNIBRO[/Of:-S.
]KaOaLA<c);^>.Wf>^95:F#;Ob>B_IX_fP2,ZNXDH]1IQ0;C8R24Q[JI>\^@].5+
1IW^bGc_R-C&4U9S4;]<Ud:dH#2O+e?W#M-N:YO2G-5Zd1Z[ORL_3XG.FNM?U90N
O[\0E#R,VFOI=/Q)Rf^\[3?Y8#FeFN57#AX<Pf\<7I8-9BEJFII_^MfS/_?IKfKW
@bT&8/:M304#W;bEY\_e\[Q=@^2[P:D,bP_#g+]0:8P<]TKgIdSWRN+d=FGd:@HM
McdD.@:Y&<LeW3G:f.3A-d_^a:<??8B0^0N3-Nf1\=?EDdG@PFg:3=>A(O/(N\P1
<8AfEEMS)NL8UDIc7)\+?D[&_G(#_DGI:Zfb^Na[>8;E[F9.FcJ?#..0g1:dM-b_
9&:W5bS0,S5VH#(SI^@5PQO6DVa_4WB90_Jf:PEVRdJ=KOI(7ScTdTN#0YOHXO2]
H>Z3.K/#<N:.H1/^.P=K(Mcd1]Dc,9Q,\ede>KLGCA\O/WDEaU1;SbddC,0HfPL4
;X[(D=\@^41,K0MU3@FDZ8//E]I,,53P=dQ\A62H(I_(K2GI.7QFSCYF,XSI]R87
(f7@d66d6;Q0E3+SO4BBY/EeYI_M:F1OD_)Q2,]J]2CKbObAR3b;OI6:(BO,J\ZW
5cTbcUHBcLHf3D/H?E(1[-531T2K@HU\2SBZI7ZPE)e9TU,(Ag?S=3I-B9733\[c
DPRfGW3\D6#;a.7JW<_(?O,/4N6Ec;KfWV9N2[\=[86>gN))Ea5ee01e:c@2T^9U
3J<A\CLT9@Zd3X_fM\S?XfgQD-1=@fW]GF@P=HS-A:MOc@>W9>6YR-O-=C?XRS?,
9#7MW^ZW?=F4XXd7G,a8+([^F7d6fIFbN#HTOCY+.XIg74FLMd-)R<=^eH,B54GT
\SaE2V5X5e&E?edXS=]H,^aV)O-A?H\,@1@[)Hg&@)/W?:fFdd:(>=UC@B=:NcH_
e4QLEd7f1YV<5ZX.aIU\Ba1MU3@?fD4K?A)VH],+T0_7QTHRHH(?-JR274P(;>;N
7<-#^=CS0-VPf265ZO0W+<;O[+-e4#JF<^>W/^2P)B\0>^8>NQf=Y2-E)8<NLA^+
L_S^Z\I+QGcfMY;ZEL43_Y(4A;?#I\Z)H39+X5PadR#I?K(=1dL+I?ZC60O?HD\^
ffD5_4>Pe<(WU.G\@E,gW<Z=^;T\V)<a\RZ;M@^)9:C+#cbB9]NPK-DUO6Q33IMK
CM_FD.b9ZUQd-X??:KN3EF?\[PBB46@,S6b5c3;5d-[gEW#U[K&YQ>F]>a>,@3LB
dF=[NYA^]_J#NDXKJ-]O,N9f;:+7P60ZJE2e6DO6e;-A<?G3&VPZCe4/0#G=;THV
(g0>Z;94^\@D[3AafN.>CU_\JYLN(F,P_61WV3ES6-E+<VaW7[/GgK6#I+B;_XSL
ADXW6@AK4J06:0:UM((RHMV[[QT_4ZK,YOfCd.bU+K1LZ=A4^0S)CE2:0AH;KZc0
K;?a[.9:ZXB&c>[eC(.I\7Y][+6gNbHJ\2B?_3G/54.C,P8<_VY;PHc_AM]5]Ke,
-)69U0C)a0IHb,#.KNJb+Y;&)YEVHa)f[[,79C^BALU)d[Jc1,(_FSRV636>_AfC
)(\JA759a=LM29#TL;B:M?g_;&Ya6@.A7E>.UYL(,Q,c48F8N.S6=LD(?5<6XI+,
MZB\U8B(.I^dYAE&Fc^YPZK^eC19b@Qe9E[8,-#O<g)GUGefEDQHDI7ZM?f=ZRfg
fR_CNgdH5:>B2G_&74>W:c5<ZEOSJ2)c:c:ZPcTO//K9<)(,]]UY#GbZHE:+6a5f
<[]@G,fZ^e@YDK>0L-9CPNC,0YTL@]SQ:=HC25^[2UGc0;>869VM8#7=A-d)N7cS
QB^&d2I.M#Q(b;GP@45;=f2H:NEN/b=)[9=aN>93Y6<c8<?:2F@_)TYN+(9Z-#(+
a(7fbD0NH3fb>NeGN^O5C^9P/KFC<+H4I4V5,1G/D1K1:;<=ReGYbH]J[@KF?:6L
I8C2?M8GeWfc2bQ+O8aU)BCHRRVD@PY>&fD3J2B?V\+g4Q4EGO&&PG5:WP_J[#bL
RJJc0/S7]4H7F:Hg?657:IdJ\R9Je1(DA;FYJPF8d=X::NXJa8eYG3(US50@90<#
[6d_GJcc1#[H@8)a;+W3N)\MUYM(ZbVQ]Q8bL-+7Z[V0,+QY/C.B7He@I5<9aC_A
&-.R6+]O7YVgBG3,.K0@3#?Wd#K8]VUVWO(07Z>Pc,SG97VL9#dZ3GaEd&]_2&T&
XMY)<B>e)7,L4_c[H>Bb+Df;)2CPg&Wbe5L@QWQ+O#-P,Y<+FPRG,FPYe(IeeL((
^/EK>4a#-.G6=ZGb/KP:1[&GFN6(2_S8RO-LJ;2:49HOJ]6Y1+Q3&bJWIP\?1X00
V/60<5DP515K(RXA\f@]@3MT9)g];8-gGHP\3UdDdA9GE2B63)a4G?gHBPZ(K<Me
BO\GZ_0cS;2&g>\ZV#cCXOe&#2-Z,C=Ke@L/S4=)R8^922R5VO;@Rgc<3[W_WUdb
3eE&3:/P8XW&N]7gcIEAPC(1]Dd3;C>N+)eD^1@;D::OLQ:ePBX\-K^/=@)^/5O_
EPD=-S9Q+:9A+I^_ESU9YcPAJV@OZ=CXU>_dK1Y=7M+8F2OJ2K6JXa)fEb=81#FI
IQ@daA\M,Cb#)(aH02[H.RBEJec/Y^8B_F<e,f3J<FL^b5;M<HcZ\9L[M/V0a&.-
DCYaZ0:W^+KZ/J]&&+.PU_O=2IL>ID;I.U&:E_5cJ17ZD_^1,0+/UQ09dBf1UQ/\
Id>;1B]gQMFRH/NYJTO\_=Q]G)dGKFD?4XIIVRLCL25WT&H8.O.g&-R\6\\=CfA7
),3\>X9B::L?-[:=K5J_/98G1J3=]4IE1g-IT&6eMc:_\5-Yb^G#/;N-@8&-8_?.
2Z6Y736B#cGM(Yg(Fg7LC9O&W@Oc\R;,Od88FJSF<e-;PQ07ACU+[]?aeY4I3R:Z
S.R+,\WbIJ&c5b)5_(@+c@VdO;1DgfH/W>(gU[31BWQ>KPWc6F92B;DV,4#?>;09
L,U(P.R/A8X1M;Q=cKg[]OZ()P\e,8FB\T:<H?fK+b/cO/?2cX]dEb^PSIL=fF9c
)gB]FB-?HA[^dad[,UB+DT=H-[E.W]aP(PTU1Dbf3_10)=\D&SZM;Vgb(cL-P__2
QcgTYJX=<3MBT\M0O&666/:Q6F[@>^Oe&T0ZP[?Z;)]L9Y\FVbML:SWdCON4.dH-
OW2U<O989EUX7>(91;G#5g<D<\=MM5c]::UKVCQQ+9=C@BE/NV2_5\R.dG>+B1(L
c^3X.8ECI7[CK^^B<6_CU1eWQ<WQ6P+4RTPgH5R<HU_U35RPN5T+-LbYcN+WO:P,
:<bZTIWE==1IR+)Ob?B/76]MI+HL[)<48KYP2)E,^e>XRRc@U797/7CPN28Ye\BR
0T1>/gR/+Ze++aK+M,MfYA[FG?;RF/XD2??8b,=C]&6QBIA<dJP<@&>YYXJ3aFg?
XX[18NTW?4U/,UWYRD(&VM5b&,?-e_.S--8f9U_fQdQI@&GcJf0,M]8EaD0#@G/_
#;8Z=g82[(eZAPg7fg[K.?fOg/L5N@Q)bYESHd7NEe)PON33&J;<4>]N27<\dYQ7
A2?0Gg7(@afAF+_W@]<a[#^9MJ.=D->40=NB=8Y)SDC19.I4Jg;NJLN&=#g,[?1Y
#J?\783\5155TLCJ,]=aSER2U8:_bG-[J@G<J27d6CgO36?;dNAZ<456>d[/OW_g
_7]FSH@/=3]#9PQ+UW&DbU_7WBDfY=1MRSA&ZT7CE[,-Z=[eVL^A/O3a3IdO-dGZ
Jff_E0Y_<]5K[DIMQ:aQeO;/cf6V[B:X=.LPf-VI(5/5U#g]X>S+SA#XdAK8^WQ1
TGMC)8a3-@P8:D]GKA8AAHV7KG3UPXW>fdT]7XMb/LR2^__68SgBU2..f,&,f4FH
0R012]W_GP>OUGOXf=:/1MT]0Fa+0YQ0^<\OO6OQb0O6/,5_YP8KD\b8W^b./10R
_9ZFF#LZcL\?O]eEfcX0:\E?3b]#&f-ZCM=HN04SQ7^b4Z<\6&:QAY]b+SJ5/?eD
U&8aG]&-CD\NO5S+CeQPBXL0G0.93VXCYC_E3:1W0e>LgB)0)/c/Y0@6(L)J@.g[
OR?RC=7@&/6?HcX#@25^^@HZEE/#6BeA-+R18W\N>M^:95QCcRC807-L\UK)/QF_
gEa5JRP#QP2-3cP9X0.R-E;@-e+7)WL)/-HC2CC#TPN_Kc4c=ZIK&226L,^5a;L9
Z^1;(SSGRE#3)Y;I47^CU5Uc>ed)U9,a)WX_5XST;+Z3^YeGNIA@BK)4A]2UbIP_
R.DE#Ldd)>SZLfU:^N6)<R=W)&1d-WeCWaQaZS]5-<W)X:.UH,(I#,?+/]3d-Cg<
W3JHYXXHN=QP8^G-ZTT<dc\aKTSVUdPJN>Q@W@M7B?Y>a2V=Q7I+cR1)BAA^^.>-
R9O((<>Bg7H:b\/dgR8(E:C(W;9(1.T;01C261_e8;RB:);L\RM[A#]Sg/\b0BC:
d(]PIVJV/eYQMCUdS3FK/EBC6F@7A=HdE5WPP?3IW,Q,?VW.O;Vc-HNRg2dASL+B
?g@f>/?(Gd]9UQT;O/BI)HSL\HLT.LA;B=/E&VS5&093cP=9]@])460^&<Z+[=_@
).I@Z)IXL,b(YS0aO(--eWZY<a7^3gEb#YH-UXJ[e(;Me0()-LfB5Z8B6[]8F@4.
f]E--+[.UE#5?-(ac/HD(=D&5dH>[A9KODd5+G0KV#^/:]U),MDX=Y+W)#R2#)@Z
/6:4[8HHT(@QOAW_[1bD9cV.ATAIFbZ=XC2\#E(#cJK[G@2XYf+Mc34(94NSN/&S
dUDNX;-,UG7fYLeeaE6.P&fXSXN]9Q]?eI;Z9A^QQ]AcIZ0B5#NB,dODE&&ZB:;8
[N18LYOdPg@,9_;]DQAUTe1Y<F@\+.KBUUW\1-5?[FFZXE1LDc@@gMM3&@(d\c9T
3/>U6,fC73CC?,VLR/Z2YLa>b3.N6;+<Rc-a79\Y+REN8bg[RF<N<^W<fU,VM+,&
Ba0:Y]PA[_9(@FS(KOW[-::OQ_Q1;TW3UW?/^T&Cb;PKM981BSA7;3J_;&cP+FdD
#CKB?[8KEa5;SX0#+?VX1S6C,ANV9EQFPb&9FXW(2CQ<P(F=4bJ2TFMUT\_^WWGc
AO2g\[3X(C7LY)AEd9LfFQZ+4QU4#RT4,HL3I94B4^(Y<.@]^ZO3F3-6YP77gZaK
&/7#1K,XE4]+2:LT?]J::2a39J1dLHDI=P/WN<THF?Z8ZX]VFS>I5Q9/QWaHMXfG
+M>a>aF,^/_\U\EfVBJ(7JKFKH4?>QBXK:JVYLZ;WJAC&Oa9^-T(:L&L8?5TD7\b
L&Y@@fP:^,RPHLZGEG/gMV-2^c.I_Y[d9_R&&MYK7a_=4<LfXd/TA[[SX-K3L_e/
N=)A_5VMaMI=5b4MI.:Df=Se)?APT+a8e/>6eHPJ4.+V_@0/4S\0XgNMQ5442E73
]4W3PE,6KL^?+3-#\>J[I#;I>@E3S<g[74c+PAb57K<cC]B<D(;_;a,:eQ/.YHdH
dc\R9/g^3+#M0\.SKSU-^6f=PUU+/[S6:;EB<1<]f/RYZFg)/MbF]X>[P_e0,SK6
EbT=JE(6TI3FGf1G0,(@F66-MTW\N[J5:-HO5L_ZT:DfaYJ(gcXf,I6BG\:9EC^2
KfH5,0aP_W9[6aSHA3E<_#aCQ@c]Z@4R3-=GE7Z;=_SZDGU0b;dII/?9WN<OD,+c
(>&6[aYK@8.NKXR=/6<?f6Hb<;<D7&5;G/;EI3]RcfB7HNbA#+E.GbI6I>I,8T36
#eN]d;[G>8&\(19[3?<NR50_V4=O0e8Y^:bB3EeEa5+&(QPO;>HK;D5V<I3H[<e[
PJT,5>S4B?g4#X7KXbcEC@3eHX5^3>=e\=T4RA4c/b@O6T0O?#<F>3XEfG13KcNX
eCX.SHTHQJ0:/g0=)WBb<[E1MOHT(d3_S0O+CbZR2[COWPeB:e019+T&ASZ]O++O
9Hfb-Q7>/9R3SW]=/0Y9/EL</KE;6HVDD]aZeDYd-+?&66Ae3YQ+Yc/82&A@VG5M
V\S(V9<D]^:XgCfB5XK4eAZO7IcJY&HZM_AHG9:M<#EG26]dC/:U9F?^W(_LUY)Y
+W5&M5&RU@&)=:9<?=2@MC]PQ8X_VL4TbaWMY40->2+g8U0#F7P/06]aDI3G51J;
(>H<HV93TJ4,/faI+XcgI-2;IQF8PJNAC=b7LWZ2Y>5a0]eb^30[MM:[DH1Wbg39
Y0aT_59g\VdR<1ABXQY@FKf?6.M>>(13c>N>UDAZc,cZ27>=(Pd.dBF&e.&>L/[0
LSL8^c6QOMLLe6[MZ6_#>E7>+A)+Z(R-?eL?#5M#CYF#PdKYBR]ADYG\-DUA:f@Z
VgdZLe,R-<JVb:aRT14EVbd4(VE-ZE3X-AN+97@Z-Fd7Ne1[&I@D2/?bVFaOOVCY
T=:KcDf&WWcW9c.24D5+=5a2?;L6?:KIc&RJ5=-CBTHg>fKNQ-=KQ0/aP]((=KF<
Sc\G1^b.X=V=aCL#\U/JY+\Jca])FA5&/XUHeX;5gD5/MXH\>Ga)NGc(Ag(-EUQN
68?,>(>>7066Q?1J^<C(SD8?_ZFb/Q&DPg22I^-IIg=[F=H+W4fNe(\HQ/F-eYX+
XIC:8-:0](b(EK2gA<IEMCTW6O,I\\+Y[&Y&U)Wb=3XeYa#;5dF>N0,1(DKB8If6
b8UP4Ag+3GT2H#?c?+/(/.FU7<c@D[SHQ3.J2?g_5T4Z#0E/6HQ95=4]6JfF>T2#
CCWKIa8bgV768BT?NJ,1L7[N]V&[g-eC-8ac(VH4NRDJ@_d289C\de_.2]UHGKcK
0daX>90d>CVg0^RfUS=[fcLL>R]>5VC3LXQLCe_,ASg/S&>LE,U_QVUHTN6EC4Q&
Fg?0L(/ZI2EKAg<P3(8##)8Vf-9ISO^0W>FT.-d:f;d2BTA.T+803Cc)NKaHc)UD
F8c2FfTOHge4(2PZcXE6R@:]N3a<?1H(ZHD-Lgfd9Vbf7D=BEI<gTSc933;SG\?S
gW4UV/4:?S[_dZOBZ5\R=DA5feaf8I=Z3d/30P+RgI0-BMN,4cDZg3/4=[d:Gg:5
OdCG\>4>L/(F,R1QVTO0c&E\U^UZ3FS>(I+FbBHA9DK[ZJ-:<a3-[T+1[,E3fP-C
gEN8/P,.O2)fP9)fS()=O62?b;2c1+>;6]ZB,CSe25<&(P,2]#cT+>;fKX\,0LZ\
2J(CYI4fM&.K3(+_0A[51O=J=J5Y98:&Z2^fB4Vc,_-fDR/g8R09&Z,eSTG9]<CG
13?NWC@&QTcFWgeU2gMSdB.#S,+=O98?EZY.gg3e[g+_b5G7<G89cSG(0A.,\)K)
P)G,U49F\(9QOB8/>;,fa_N/PO0AW;C\Z)>&3-ENG>J8\:J-URNX>BCB;9E+HMP4
e=UAMD#g0bMQK5.WP+<Y:)VY#^INA:-bV5U_T+;1DPXM5Q-45#EL[?@Q(8>2e8:@
OY2Q43@)1\2L?<SKII7JeH5#f@WS+BU^)4XgQJ/1d-4Q0RT\1IZA)1gNZGXK09aZ
\2:5a29OF^R@9&+FcU4\^RMYUJ8,<R8VCU<:d8O@S/#e[4[XC?,VM8IX<2HLOE<K
gY>?g3K&c(/?O,_X@[;R(2.9&XZ?J:@<fE^5g[-8EU0FXQ50N?89fG)eHG<<?GQB
e>_<,C8@V,abH19\eF@KOdf_4BPNJO1H8QN5RJR?)4QSB)XBEK3GY&3D]?:OYVg0
NDMW_^LbL9-X^GB^ge&&V\)?8F3P>UB\9F<^eS(bZ^UD6gRR]c^O>Be5Q@BP=YK<
#JBQNUV<[L3)GBY<HN9,-UAMSV)N[DDG_Z0bW=XF=UZ+N/e;+[IS;+[4>g:R9PA7
Z5+DVbGBb+GbIK#I[EaG0S8S8[1AXN@_RKE>2HLY:+c5I+@ObE.SZ;]c6cXL@3_T
PTO,XcUZee,O1Kf>VX@>(C#MFDQWdPafXA3(=Za=R9;5X46KYd>56SE<^V>0;U4_
:=I79(?Q<?AI\c_C6\fO^Q4SN1EX0Md+.,K3>L:4?UHO#/ULJ3YRb^.5=]N5KCFH
?\g@d7=?L01bRO>9Y1Ae^g[3eE5LOOH_XQ]<,?>VH5-d9R;R/gf:\f^/ZRLgeR1.
[aeLb):(VROgHK4<7QHEY/7(HTE&c@494I9_0dJW8e_XC\HH?TR1E-&@,DJK;..?
dA+\#1_48W,1IeAdFR5\(P;&UKIB;BIWf/>@6XYR1ENO,/e,dYY#2EV=0&dE9:]g
K(gW36eK6/RQ#Y(_WJKRZO/B6e;SVPJ4#Q)@c.P_>T9>9H4D4VDYe]7c^IBPDCgR
4YM[YH3N82(f8CMJFWC?>W9YJg8__,=+>3b7M@:Z\25@=/IF2W:fF-0dV6.E(49?
6)<La#)36B@1<)F^4POZ+>>XOcd/#d^X3J=M>\ZXf9]R_S^VSaPHH@@fAK4A_RCE
2#FD/\G<?VZaHRK?2#)GT/<QPO:GLAgF@3#(9K5VIcIKJX[6J0P20I?aE2Q1Ad=(
UC-91IYA]I;fHI]#892E8(]G[3<]1K@gN01=\f:Z1B@+1?Q\7+V#=fKIGIb^_b:5
R>H9LEe[_+LL/H-d:SbU[KX:^,.]OH[@=II)>48R9cTI2@[XZMTC>F+?ZffE_O&:
>VMPLOK^^?57)A8d[TR\U7Z7JW=CJVK)NMF@LeT2A]2V&PBZb)@RL:XCV\FOcIdb
Q7E55Y[BS24f+YT3I-3J-[^\_5;UJ^dB,]>5-VE-Nf7b>aA-[:Q#AE5EA6SVS_A_
=01I?F(b\A0CKR2ba3?SYc]>WJG;8G>V2d9@M(4=91bONV.M7f?5Y[8]&:4/61cT
ZgT-)C^HVE,:=G/.Ua8TJPT.&TMWfA4PL0-ATZ&56,QVbV74Xc33M3\,^=F(AXKc
cPQEE>\[+^Ya0Y/JWf7VDJ.0GP.QG^4BM13[>eAT9\A][U)#Ab0+-#)<H-DdTBD;
/P_bG(U/RZVM@68W>OPR28-50MAZ8SaW(A8YCgbA/2>PB(.,R/R_e:@f.e?#P5\#
?-/2-G+W+G24\,TWBHV5R<6F7I)1Z..DO_.<LVGe89O&eQ\@-e_36HXHH9Q7F1)O
d;5;:C<--_-0W0b4X9,13<dV^-Q]VCcC@5E.^(Qf-P6@@M4Y;V>?>.V@@[[2HLLX
^Xc<4PH#93=WUL\N<aYFYM<=3+_/M>(I1HXTf5_,\K]S)b&@=Jb+&U<Nc&&J4&:J
-S</=cbc:>B[7[dO86V?)]LcBW-]:4T8_JX;K+GF/+B9\0\>5De,BeWP5&(&_&_=
CM/()eV4V3HJ5cK0X]@&)e&#@fNTL9\X5C-MPF,9<K58XL_WO9X7\1\K)HQO._aG
cG;;<dTCS@)4A.Ve;D)4\.F9RA@G&9Y2;8([O<52BVfB)QW#f^LcCL1VCO2BK9_5
][BadV=\>HcLa>V(=:ZEY<T=WJ3Z<b72<3INa<e9/+d<PR&WO.;FB-/[@8dVIKK9
2<75MQ[]#4TQf27N1A-,AFKb^B+<cY_]FE9[K>JM,@P?7bP?5MDK5@62M;>6Xbde
/g>64>_B9IVJc8CJ7I9&;6HA,cLQf?<]#ObKfYZ<E4]\7A-5bQ3:>GTB4gMBGcbN
6^>98W;9\+[9\3@>>YU]_]Ie/(@Afg9A(HOD5&1ZH1:,e+94DcMZGOJO7@gR>G5A
6&Zg:cT];L]-OT_>_f^EGVM.,>[_IXf39gW[BOUGNL2e77.5V0TWQ7D\,9IKXc+C
L#J-;A2a/W>TJ+MV_<6H3HI:0(IYd&>VE,F]\,ZY#LET8/DTN>O)YHK0=:f156Dg
cGRR4:D+9;Se+WGec/Z&Gf?ATQ5GCWMAg7LEW#?GWaONg(B.:7SCJ0@C<U<<1U@]
FQ(ZR)<Z#TQ-Af^]_b[@.^NV\)e]F>M:=[.U-c:GC.DB.OUJ+@57>>S<\[^T:]=5
U[V,9^#]<2#9d;EC?;M3SB]KL\(aLL\[FRWf2:@O@[dJCLgIVgDD8b?cVDFQKJIR
6CEY;EV90ZL/f:bRLBAC<fT\@Y-I]-220INX]6Kb1Z-G-YKV2K.HB;>M9?MY\G)&
9<F+4_a)OVEE=aF0a2FANWC58QUFG8;^>4>XZRJR5a,VZ?6)Xfe-KZVZOQU4=KNC
E+&ZU#fVT2_K0N\D<?/_bVN0S29f&PMI;\c^H90C(OFCDW@CWE.?EVcBP8WB177+
YF>.K2FA<03OQFPeQ\#G8cW8F,^\Z^?I\_@NIE7<ZBIQdAfE#61_RENBOR\SO_KH
cPNIOA_6;a9M@5ePW@HXDMaD7J8W#VQgQ1LM#3V9K)8H57?Zd.B+;A_#T>=G?g0R
B_4H44H=EX&f=E8>/37X=S3(+-<285gK7F8X-HB?F#e^0]6Y0Xc;WP:C+73\WH+<
WG-A1?/34:]CSaZ,.+8/R__/-#-ME;V-Y5&^@E5K[gLTTE>F2C=e_@CBBWQ>&V65
:>fJVXVLDZR6,A.c&E9;FR/4dYI.WW><+cO5(7/49HU]5f&C-T04ISWOgO@C(RMA
O6/3_[?1IPOR#-UMMGa4+[>#&e&,Jb=/&c0\7)R@8?>XQZ<M[;APG_7._/TDI1-<
#M<gE=[,HK@X_#0S^G<\D(e77e#,12fR]:[DQS?J5?JW[+5BTU4?&.]D)V#CN5WF
Z;#\F6,F7HC60J=ZPK636fd5,S4dZ9J]\D2K+W.-3)Y@cA_Z6,MNRV[O3+)X+&T>
SJA-N#5DYHfEe9V=_;d?0Sf@A.g,SdY(]N:5bfXVTJFa--4/)UGT_Z9CMT@0UX63
Ga?_a?VX.K^=2g\.U]/1YN5\=]AY-CQBQWBa_LgR7X@C.&IF4@KcgT:ILYA3NM3a
H-S(]Oabc0N(\HWA,.&P3B4bMg#4M#2^4U[Zb)TJ-aL72R<7U+]2@?,AH\LZRf+.
-b,1>[/+5S_2bD]F)&4_8M(+aQ>N11O4XcRV4fAIB-a]Bef>>R#CgfF9MAR(RDI^
62F6N<R-I7\0GUQ)2I5FSJT0[+]33#MW3_FTK?4I9,c0+a@#,JB16CFKK\Pf8K&,
,F+E8e=?[I-_.CE16:c6A<eZ6VJI>g:9[:235TPFDS62,.;/>@ZAECO@,K4^N.)=
c7aOJ&Vf5D?_eC)]4#YX5X7F1gC(/#1OFUVddK9W?U&2XF;#U3X5Sg@FG)6;2,_;
)?]]1>IS9KFE71TD5UUHA(aR),A.E???4/O9d/731CYEHf.1E4@T30<W9CS/bcX_
6^3W691b/B[^)bA,:-E6?_E9,OY?&NTOXZNMT?G^\7SC?:U+O[2D^6R^\M-D3J.[
B\FS9YeZa?2@/FN,P(NMc-W2H[a\g3=]T>A.0M-\DCB4O_H&8.G]-]U7[1Q,SZa]
>BU@3Kc\U:@8\2#.Y\/P.6M97LdZQgb>Ub?Q2)):7:GVc@B@AH7-KG3YQRW>[4KP
_LT6g0eGQKM8M7@ggDXG;/P?A_e#;F+6Se#2CRBQOSgHK3[2(e)UJPN[6LOPG8G)
S_+DEfLV6a(\;LC&^P]J3XDdL#=cI\8]2-1_=fL>I:P2SN.=&)N@4CW6/]VBH+LS
E91>1E:]F/VXfEJ-BfZ&H3;1&,/MdXZ14\SL4<(fG;RN&J#VHIeUgO]a6)?C2M7K
_@<S)g&bZMN/.).Mfg7=^GYMZAR>FbS?_R8b&^>9P<-T?<>=1[=WMPdOJgX<UFZZ
-Z]_Je\:WEPJ;DV,=aVaW<Z)&L(c.c7#gY-cf4P7PDge.^5<E@]V5](:MTI-I-V<
6@UO4YXTNB+WLWP?JNZ]MRPX7?&DBWDdZ2/aS@[6(6KaPX&H[/XaI:7^4#>UCY),
.K7^cKdOCX/UIKI?=3/VANM7-PR[.VZDHNQMG@+8&=OaFD?Jf>A]4g,Z:H]]<Je0
#:8462ZBeN)QO:SDV3]G8H/gG9>4KMQ8:.Lb5_BJS66I9?1,C6_e+WY\1>F=F1(C
>cLY4#b<0e>Jd,0K8\;L)Tc^QVS1e2>>=PWdDG42Y<DbU#20=KBISf&F[[H>1ZQI
BNC\/DKa?[=F9G2a(VKZH&fbQ^L/GKSf;;5A-\-F@2YYNf,\/2D[69+AG?A]A8>P
Ze1Lg<aO\WJ_0[IU^H(1.+>?g^OI:gEZdO5O,^U=bCD^AM8d]R[]Z8.O:WgB(_(b
CFA=ZFc11L:MNE6+02T#0S2W^Ad?,PTDE?3>[;E0XLa:9Z<?X(=55BBB&-L)MWDE
.X[/0<8]0g,:>MBG_1JB5C/U\g9H0Z\SV;^53V?UG@9<G=<QXDdK1P#6L&GN4HB[
T8J\M/=2>&QZW48@\g-XX:4\#6Z^b3Rd2MfgKU-9,^Ke:DHJ#b3KXE7M&;JeJaXd
^UO(V8US5(1g;APZGDRYd6;.OMg@.eMRL#N=W>-3G58_gI)[-VK@SJ[c^\^YUQ]7
4<&SeTGQ)>MQL-BRWDK>Kf^3J7LF6:e/>XJMQ9^gQ>Reg1-TBSg+8;c6\>f,-SWc
BT&eC5#[G?-ZF11E3@b=b5YF:G2Q6bU7bED0;3,d,SI/JbKQcPJ?XQ;MAd:E>=5f
YV?U7\D/E&c)Jf@b:+8=MD=gW=/e/Ff0__[cEB?<3fa.HPP?#K3)Mdc0<G<g2IUF
cfS14-b9[)WgWU-2GO]J;IF(8Hd#,#Gb@UAM/Mf]H8\QRa43gKJ:=K]S&K217CSM
H=-E6HJ[\aP<L00+U9dWQ<Z4DZ6Z]\D13-cJQQ6#\Fd4M68-[N2?S1?a<]>.fBg7
Q,X5]@8=4L7S0C6S04R9Q+9TZ.aJ<RXdY;=6&Rf<VJP^bLA2ZJI(a5BYK<DQQ<8B
#)<]YOOCSHBL341H+ScZNC+)H;_01@4LSO0PENU\cS/bcTNI4EIJ^7>53\@&dH96
]4E@Ia>Ab)HG#U/QMe6-W[DVEMUMYcY#A&^Q?e\=<&2b@8PM]1g[1MVKW)<U8K>P
e7_:HWZUC<AV)I@DE21&^H\2,f-Y38Z\eK4Z>dWJ>)E_Y4@f)\^G64\(9(U_AgaG
DeJ,Q\3HbfA3?5XPUV,?M+N;YMgdT;4Rd<bE>f.:JN.16WB.8<F_9S:^.1F7CV)#
7&.LA/W1TW\.XA(_SJb)V^O[GdXDaU01_\L,J\>E#<f]f-fSIe:KC:<N9+X.CMWM
#<+WWWCNDPFHLHW:N#/QU6(?(?8H?5=eTZB-.^MI2c8<WA441^=P#.[ZY,egRcLT
]NU3E/@Q=4F+ML4L/#FL9I[]=c92PY[RFgR4J=2/,^gBbgRR=_fc>9+[.E832N-]
#;P2fCCZ(]&GMKR[[9((GZ^YWTJ?BEYY-/A>]YM;AHLEG@_0;M8:@J-JL]&S]g+c
bPbFGIYC6245eBNFNW:JBP77,.M=H+>KD&1CKe+a7I/P=0+O7;4J]fB6,AVTC#)G
NcT.C9]<+&HbcT#fTa0M>&-2U-gP+;K=-3[bF]4_]CD4C\UJOIfNMTWbO3OA(33W
cZUf^U_JdOQ-,Y7_JN)aH7H7aR:FaO\\+DD86MC8>GJa67J)R<A(D4.YObA.Xc:Z
#F(X&_=7-)KGAQ^?W,dC(2d#6EJ3Qb\8@E(6;7NFAgK&0&F4SEYO+JVBP7GaX&c&
;c/HL\^[(8IITM1@?//:7+Y1\Q0\GR9?9:=?5,X,\d2[;T-&1W(P:GOC4La5^E[=
7WaJZ&HcAaW84F+^XcH2WYY15$
`endprotected

  
`endif
