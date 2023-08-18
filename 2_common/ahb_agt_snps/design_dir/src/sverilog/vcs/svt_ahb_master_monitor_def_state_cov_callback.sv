
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the master 
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_ahb_master_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_ahb_master_if.svt_ahb_monitor_modport) extends svt_ahb_master_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_ahb_master_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP ahb_monitor_mp;

  /**
    * State covergroups for protocol signals of AHB
    */

   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hrdata, cfg.data_width, hrdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (haddr, cfg.addr_width, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hwdata, cfg.data_width, hwdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RESP_CG (hresp, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_BURST_CG (hburst, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_SIZE_CG (hsize, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_TRANS_CG (htrans, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_PROT_CG (hprot, xact_ended_event)
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_state_cov_callback");
`else
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

`protected
-W;g^M9:6HTJf>EM.,.f,ZS\KWd/()fGeIXKU.J@U-8J_V3&Z_73,)Sb-BWgY?HQ
=0KJ^CM)I&G+@UB8:P);96g:>J>:413QY<Ia3ZS5,a?]Q;[7DH.S[1C,0]6/;4?=
?8,TNcC<F=8?Z>J>N><^3I-_DJH1EIWTD@-(?BS[KHQJe>>V:51_3G0Nf9KddQ7[
(9c,Ag;f(0FR_:XN832&Sd==TFI0^O>C.2ZG4K9G:eAXdV#F_[VQW=SC=\Wbf?X:
dV2MW#WW-XASE6g[<=D&;)&D;,JEaYFZQ@=He_]QH7FURUEa?&M@J.ZHO,5>PBB6
G?a5KN^LD8]C<FOA6(aLUYfV2\3A?UW?F5W/VJ;N/V^]81Egf2FS?4F/#eY&&R-0
4eK:OUY-WK10Y1@Z8H-@JdH#d9C=(7#8Ob_,M\:./\[&S.;=R[K(N21Q5.Kg6b.4
WV0D?5_X;IZb3KKb\d&b[RN+GL/H0fM1_()<0G@L3?(f\>:GS/Z<Y^3B?T3^8/@;
e-I>_BTSE]GI-?Qc[M+&X2JE]-T\6Jd4M3g,K+CC0>\[LOT9SeeMgd(76N5b2C88
).C+1U:4+F4VG(V&+RSUI-e<+]70Q\^F(86OeR-EUDJ3WEVMYP&+[90L3)YH#G,4
S2c4#f5PN^Lc.H6^QV(BT[N:@L4J,HC#/Z)=>43_Z<7dJ;A:dCE5ZdM3G_Y03a4f
OQZDe3#)6HDA0d><O1OgZIA7)Ce37TVdJ>KT_TUePcQT7QM<Z?=.Xg++DIQ\De,C
3(A>NN:NDJcLPDaILX,J41N:L8D\=4=I\/B5gJ)\gQM+WP>TDVK[YQE9,ZAI:J]U
f\a=MPb@ZXF[fe_^R)B65R17Mc74E3=eI@RQ2XX2X&G6YH_E0S^9YYOPV.94CNE&
CPeMKT^fEZV;AFGABY>Md/:[6dZ5O9NKG7+LDS/FIII_P?dB?#6cD4)X:)3GBKWI
S;&,]8=A;I+\V.U<\fO8B-V?:LcR/W5\GHHC&85I[aS@O4H<S6>=[)\X:Z@X&ZfH
MRGZaLO3:A&OcC@V=ZPAcWb>a&D7-4W+VW[A60TBWA=6IG^:8=,RC[ULDFL2,]IY
Y^=9dCHWKT5ZUO@](dR8b._<eP519>_::2>R-ceZZbJI\Z8_W+\@\a+T1=^UeV=S
)?SJ9&U;1656GTR3(;eE:K@I9ecg@:V6=M6d[TF4+4L0ZZb10MV)c@Q8eAXF1f&.
W?2dN6/UVCX4VQ8#1Ib+._QVF04-AJ=g8R-7d5S@O>H+^QJ9.e.Y_C4\\1\Ub=)J
f4]BQ2?_H92#LEfRSfI8(Oe4]PLU9SAPg>E#57gHD_+3-<5B;?;5R6_fW)8QIV6F
ZcV26^Qf7F1IaSSKN8TD(9G2@[;9\C)H>0&2@L[cTK=<B5H35-fN:;_GEC5UK,W0
A59\]AF3XO1_9HSac.0F^S+>IOD&M1,T;B9@^NcAc)BD;XW<\d\BD03,/b@Q;OJE
9:312Vf4@]U6AV?HY?gKW@?)2ZD0Q^B[_&W\_G:MgT6WYBSJ0+@XJCfTL85CQWI_
-cJ^e/(O)A0c^(fC+MNFE]a=7YdYU8:[_^fZX4Q7D@dc]CR#b>\]PR0Y#&I[SZ&[
MHVI90VY;.f_IPGf)U.#Z4Ng.?Q8B0EV]9=F?<?Fc[VKZ@E1S(XPTUBe,I0I?4c\
])W(4G]C,OIILeJ0eYBK2A9ATaHF=^FJd:\S@)e<Mc[ML+ZP.KV/Wg<NKH.^>&_3
A-H7>AK?;H5T8?.&1-=BM;3:f)<18PfU_aX?7=IR0Wd>Nd1)Y:6MW16X2&OA^]ed
YJM?1Ug>1I.3f5J4QIdaa4f1FK#DNE8d<$
`endprotected


`endif

