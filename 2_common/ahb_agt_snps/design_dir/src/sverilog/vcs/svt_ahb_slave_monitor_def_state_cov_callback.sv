
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the slave 
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_ahb_slave_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_ahb_slave_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP ahb_monitor_mp;

  /**
    * State covergroups for AHB protocol signals
    */

   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hrdata, cfg.data_width, hrdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (haddr, cfg.addr_width, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hwdata, cfg.data_width, hwdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RESP_CG (hresp, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_BURST_CG (hburst, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_SIZE_CG (hsize, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_TRANS_CG (htrans, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_PROT_CG (hprot, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hmaster, `SVT_AHB_HMASTER_PORT_WIDTH, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hsplit, cfg.sys_cfg.num_masters, xact_ended_event)
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

`protected
\8;89);;\G<3W<f80PFE0_BXWL49\GA&?d.U)g_<8@V:bCC>C4N:&).>HHU]/eL6
_[96c.ZSM:2<TA.dIDJ-+E#,.0ULCJ3F,COB=IX^42+0A114FNb^@#eZV_RCMJ;g
YRK5ZKTL>XP--9UUOa8KX8G8.g^f6:QOW(NfL^0N+fCRZ\bODf5G8b1O?[+H-8=#
08=7@Y5NQ\[MLUSdQ#P7J+R4MEZ7C:d#8/XgFI0<.G0CAC<=#a1+RRLN>))e]K&C
:1;g;\R;+5^J>MQ.EYC^FO-[G&ZOM><O5X;)e+c8bZ-3AN&E_:710DYedT4CQfT+
f[S]4]aJG+f]c2_GM55S51J-/eG4LYR([6)=?W.,#JSV\\##UL>-/4-D/4?):/LX
de]AOT878II:7>,/&WTdfe--Hg:Q8Hd#e.SA&S[I2#0EX.7QPQ]8>f0=YP542Lf4
K0E&\[:E1S/g[,bZ?BZd^/eAJ]E@LF7G3#]9bGY=T@7@f2T[bAg<GUaZGA\M&C4I
1P#P8UJ^_AbCH8cf(D/JME?2^X1BJAG<5FWRAMf4@3X]@9XbJRO4ac2T(@BS_6V(
E\,#8Q)I=?1f2&OI_M4C9?V:,?ZH4?BBg9G6BVM4<++,7.Q=B_L(HLH7AFQIe5>;
D@5XPY.AJ9R.[M@3Ng+^He\<0V)-7YV_g9&OA-F@E7agB-U@f.)2.MYZZTM:E/8+
CY:-NZQ@[3\7@(D&ADOJ<W4FPINV/g5U4M>QfNKcOLGZ&HXcVBOB,;1+c6g<H0.e
O/1ZK:eQ@\KCZ\MP1R\3AYfO4>8@,:Wa?Z+I8_fH?c\a]HU;4AZ=3Ug0]-W3CGW-
L[G-ZHQ>A?a:.7+Pe833aT,FSaT8F@e9.]I)S_g?[(7gdB(5M()5a:-+?V0N^,G.
&K\-#\ROO/(1];(g50-N+/G+YKI0f,4H--[A&(7-K]N,eKO6e.9_,>Q4])7PVbVF
GQX?3PKA(\OBbD(QHTgH7VJ3&4+LRQ[.CcJNfQ7GJFfcMfG.-6IG.A#USM?@[S2e
KVYC4OCH0SSP2,(SX&=;[.g[L3R&aL0[NQD,/7dY)XcPZY6:.Xd@C+@+\L&<6.Y4
Y\aSVL:9>I6-CD.ad2F0DK<XT25^B-Kd>aAd+QBIfXbAg;gV)2PDCN5e=ZfIV.WD
,T>[e<?3./XOWC.IK:_ST(=2R7g./GYP#G.68cD^g[Uc9I6_4=</6DYWL(H1S5/]
G-=JAS&Y8H32<N;&C=W8=ZB,XdX[4HCE,M7,f_a@e4A&[JRO<,C-QJ?C/42-VKf5
R,KE9K5RG9],Vg6O=IW7gCG18W8gOA3d>@1T@c1/-@G&FZ;Ua^=gc+5DM;@X[4CR
f,?PMU0X[Y>P.Md(T(B,L2&/?+-0N6@)Y.dfY;R+.65;b>^^-IM6ef7@A2f=WgMC
JA6NEG[IM7/..(CTNLA0&K2ab1OD58>;BNE\^+Dg0Q[[(5<=@5ZgVb4&?U?,ZeDK
INMd<SO7^Y_fOgHHJMI80FK#gd0](70<eg6SQXI=L1UHf/+[B:[DUc8>B75R^5T;
Y1,K&??,7\KSg;.DNG[NY>e6Q;0^2g2^Q6JGN;/,FI3d&Fd-fM4>g^J,L6G94=2S
T/42;&Y\XJ@TV<L+,NaI/X^N9DfCJV7D9L]92M\#LQ.Eca@VJ&Fd55Uc@+Q3JV,[
<8.[]22NVDe\,ISEL-F/Zf_MfO?T.c]>DgLZH\HZ=Mcb\G+P)BMPB1RK3\4SXRgK
KMK;Q28[(Q+/TQb/P[-Rc<?V=g@cE9U0(X.bG:O,LD3e4a&=I:?M521+G5R;.bRd
]>P.O30Ef<1JeG[/[H(#9MA7>g4_O9M@QQg0R[8J;?cG/Hd^0JI^SWdA[g2HUBHE
)2d5,D7Y?0M,UJJ@+?(,;Q+LG&Y/=#9#e(6>gG:?1QIO[CNNfb:ZO4XG)4O3V+5A
S-,?K1g33V^\]6<KN@F8HG)TgILVNNQ&Cgb)Q5LP^#@VJ10)TTG96PXDWPJ],c//
B,BY2KPeI,JETFY2AK^,)XUDAQ>d1e[.YO<A8e=3E>1U0S\\(dV?bY>?d\1E]bYW
AGC9?RKR;/?[@,>8If?R]E+&^;+_YSe,9$
`endprotected


`endif

