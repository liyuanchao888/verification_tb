
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_master_monitor_svt,R-2020.12,svt_apb_master_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the port
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_apb_master_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_apb_if.svt_apb_monitor_modport) extends svt_apb_master_monitor_def_state_cov_data_callbacks#(MONITOR_MP); 

`ifdef SVT_APB_MAX_NUM_SLAVES_1
  //Maximum no of slaves is one,then ignoring state coverage for Psel signal.
`else 
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_RANGE_CG(psel, cfg.num_slaves, master_sample_event)
`endif
//  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_RANGE_CG(paddr, cfg.paddr_width, master_sample_event)
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_RANGE_CG(pwdata, cfg.pdata_width, master_write_sample_event)
`ifdef SVT_APB_VALID_SLAVE_IDX_0
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 0, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_1
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 1, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_2
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 2, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_3
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 3, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_4
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 4, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_5
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 5, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_6
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 6, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_7
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 7, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_8
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 8, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_9
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 9, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_10
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 10, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_11
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 11, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_12
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 12, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_13
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 13, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_14
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 14, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_15
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 15, slave_read_sample_event)
`endif

`ifdef SVT_APB_VALID_SLAVE_IDX_16
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 16, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_17
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 17, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_18
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 18, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_19
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 19, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_20
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 20, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_21
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 21, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_22
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 22, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_23
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 23, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_24
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 24, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_25
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 25, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_26
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 26, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_27
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 27, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_28
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 28, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_29
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 29, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_30
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 30, slave_read_sample_event)
`endif
`ifdef SVT_APB_VALID_SLAVE_IDX_31
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ARRAY_RANGE_CG(prdata, cfg.pdata_width, 31, slave_read_sample_event)
`endif
  
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_CG(pstrb, master_apb4_sample_event)
    pstrb : coverpoint apb_monitor_mp.apb_monitor_cb.pstrb { 
      option.weight = 0; 
    }
   endgroup
  `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_RANGE_CG(pprot, 3, master_apb4_sample_event)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_apb_master_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_master_monitor_def_state_cov_callback");
`endif
   
endclass

`protected
).Y@T6XeHIcgdH04A<Z2N?[?03(0U58W5ge.SaNP[I@VHc07I\XY7);EXDP7&Nf)
>e:QV1HJ=>FO:BC5JRCB^<e0Bd)FRPb:2GX:c;3FEa_J?YR4+B,:5.3C@7&+aSJa
8QGVR0TS:?#1I3U9=?#R:I=1O-)Wd3)gB4>E5\RfFFfeeCTfQR_SHKDX5,65eW)H
L.1WMCJ;9ATK-^YNaH):V8&B1+M<02/-Q@U]N\XL0N9O6]Wb/=\([?;&/XC\9&#=
A0]3<<U5bOS5_IffUB<NeQYGO>1)-P0Na]-=G3FU4JPZXKR-d;O&6R1POU;:3EcJ
92Y_3(.I<--R9FdH(8))LRA8LD^KBLIId)dJ7g&9C4Q.bYN,OI[(X6(Y_6I)+9e\
W>)W+7@LH2>a2eS&Z9/;Tg-ZUIJ1/VKSC2=TNK-AfY.G2[BVC7CK:LH]V^]9&PQ+
9EXVA;H0-dZ?]=]GeWE;99V#F4&59eXXe#>FUb7RYSBIe2cQ=F=_\daQ3:8AD)d?
e)B6d/M?dVaNR&Q-X0-QNC(/[beV:2YST2b5UH7P<\[4.9^\aa++ES3&)F/HGN>A
IBOQY949<AJ+/Q2&J#SBS=fSdZX@TP.3d671[I8?W77.SG.Q:6f>Q\gBB)V;XfAS
S8JDE=QU=IW90?FF=?L_PWWN\@T.d+cLFGNW?1UUSg6N/7M;-[B:\)UC@WP5E\LL
U+Z(L0J2MUcD^B^X-4G5MIVWT+:<VUL[=K1)_(;X(aa4)O@3#S-+DRV0?3f=3D1(
M=-V-ET9b4.I_7;f0c@<4E/C_WFeNZc3-0G4L[gBFb3#DRFB5HU:7a7gN<A41W1=
KT\G5^X]O@c=\aEcGB;O+9&],2IT2YP>g[4IO6MJHEOf5R1:QSfY-.gI0(3=]g38
LO#?&>Zbe:eVf<S5c3G&^MN=2O2I33VfV]9O\LRP3#1@0)g_>88)M&SV=/X35b[6
-:+D.bgf-\VH8X_50K):&E6g8YJ;Y&8BRQeaTU2#RNBY@CY1EIO-g7f6Mb@DAZ\O
@AOI\>LFZ0/g4^Y1\,K^C.R&:AL<K))Y+N(S<4+)d,L]EDG7C3fE](IMK_TA4eCF
X]TY=J>=K)JgGY/LXI]f1ZPO4(M75YO>gK2?_9>d.F0(a\8-Z(Z3_b_1#4=ONKXF
VO6H[A^-]5R4a:]6^Y:]Zg=))1;AL\>cGMIY84+T<74#EF_:+IBGSL59K/gJJf?N
d8J/XNF0[fG<3R1U//X/5[;EdWI#b\AT(Z(SC=K8f7#?YXZ#V/95>:[/4_aU5\\H
A)XVL(.c<#_Q>f]\;EfX1Se\L(ZI<5&gI]T3E0a\g7H:+3g:MJ>M98OQNB0c+;&M
LRgUe@O?4Z[^+>;-J[D.DU&L;>J21S,9\cGE-;7/(DRed7CaOG5:S^B_;]F5Q,bb
W]M+Ff:2fcJ+T&.G&4-C;.eX:CN?M=d6QCXa?CP]09d6+68X0bQ1[YAB:cM<K:7d
73>cIg]S2AVZ:\\gQfP8@]25;;G,XfZY;[-ABaR1=VG01T(_OL5JD63-4DNS5Zd:
=ce?@fSfQ7G9/_OM;3Y>K-XXKe1)g4)T\GGV9.;?(F-,PCPgeEN[4e@1U6]7[,P^
:N.g0CDc=DZLII(IS[?+N;K()@]YSXE4K5A,6e=MNVT>a#B@Z[I?;g8+K#IS(dX#
a,\&SeNYJBPGE=N<;CE+POQOZB]aWDF8EPcWT6)@K\]R82&gLY(ASIg&17EF+9Xb
UT)7DC7:3BLEA3PMCW(^CJN6eGQ.DO=2,WGC5I)a?SRDKeg\TDRNEY=[LT9c8WVQ
/C?47L6>2.Q\G-.4&\S]C(4@XQ]/X3Lc0.E7g#KH:UCF,#[aa<OD:S.:795<^<PK
e#T4&KH/D95:M=W-[RFbX>@/aBRVP;2H,MYZ?FGF9eGORQ/2=cI_B<K?M5Z16TS-
P]:>c;_+G=@dPO1U;4/LdC[2VAb_VA]5GIN9A[^431<,d,A83&0OG,YQT5#?A5Fg
D?;.=UL&>.+.^TGNS_/LG\F-ZDdK201dOJ.Badgd689b6(M#=.HKNP#2[DY<,eeY
6,eA\a4O@J<EI/NMG-^ADF=e8dC-Eg#HeZX9=S=?cLcW;X/=A?C:[U&#-_2^ccP^
I8\W/g=A:>&@O;OX:;:1(CCEJ]2U33:&M,d63V@Z1H5[O[b2=XJ3>8K6-?OC9A0(
H2W75Oc4>TM<@0XJPJ/eg?2L^74JLb+@^gH8bJ+ENU3GTL4W4d0-e3#g880ADBT^
A[0;74d6#b&10L6gb6F0Z[@GJ_YI<TWd^dcXcC7T5Id@9Y?bQcO>Q6S<4ZGV.=A2
PI&@W;NKC)0>BU9V[X;@WR(NfZ77:Q;TE-=6D.=K+OK2bd2#URBdLR2;AE80(HW4
QKC)ae(gBWTf:B]b/P,gcNa?R65Y0+&OMZIP=4?[?M+.BYA=N62AXfb:-XFWS45U
UUeX/0:MP[[B(O4/=:H.4YNEHe6D@KKY_7<d<ARHFgSR25.7f-DG\ZH9Se8,ZeV1
AS(,RNf/-T^-e7?DA=3W_L@P5cNO&_^I;bVU,)<dS,CT1./6;0_K<#&b-6>J7O>9
7:Q>(,aJC6,YYEEJF_bA9/+4SG;C&8&5(>d-?QOcP<;>#7ScCON2W2fL0e)2^EPc
?c3+Y(HT4&AYT\dEGa6K\F48+f/6(;Df9Q2-fC40Bf-E2aTHFba8=7OZKcWTL/L7
@#5W9G8XVU464BaX>+6W,Cb1\A-H12#SdSXA1\/=1M(g;PW_.\+\-[1ALYg;+>;c
N_7)d(OCVHB8Xc:_?c(\c8W)P-8]Pc&(E9fUB6?=GZCbDfN#5V^L:26\D#;/PeDQ
M4f9V8IU8S;2/:GW#5a(?D_NA=Q+@QALR^DA^/5W^bY\/]V_dK4I))L5JI4fPBPX
D-U-\INDT.O7(\f6.^5#_FZRUQbI[=A-A?[H,R9UGWaX^PPTSE&TDO-g,](>3f>B
]5PcZ=1Mb.-WML_\SgIKXE4.V_f?]<=^GF-a-W11?U1F+;+9_DPG+f\IC&^^I0ED
>ZE7<&(T,WC9?/N^=1ETPa4_aR5#5,9];e30A2U6_;-=<\8Vf\<(VGT;(C@D^:MH
76K<e#<CBf+Q]Z0OY6\]/9g;61b24E;Y3:#1>#M)I=F/U=69.T[<(O0PcePA9ET8
VZdLX21)gQQGbG/+D:Ye+IJ^1:V61d?WKO2H>bF3[;GS)BK&PcTHUaVA5Pf4SAOS
#f(Wa9]SX7891^eT/=XI3&I]5>,\J]4:9P,0#;S80BB/A;3K]ca(C31a4^aEYd],
S=Q,Ib8PA_K;.3d&HgQ3U7XL55ON2J@<WD7XB4b6>&&#3I^0H,;:X>gUQW\@W[^R
Y\<+cd3Q/<B>GBd\68(5NIZFLJS5)Z#Y938+Z[fTYfH-6_EE[>4/WASgPZP3MBd2
VY>VQO7b^).JA7G8aXKYVGF,ZMf1aV_,-Ffe3_cAgbI.ACC+:D&]UZYY?FFFa0\F
cD2aJGAQ,A/bCb28c:-V=6F#;?GX,NE1I9cSM0SL[0;:YKELHF?0MLTCWJJ2O)K4
97J3O5YNQ_PE4fb8dMeW#Y4E7U5_AG93C>O@\KRD/(gF=>2V,5\MMZWVX/0=4Qdf
Y?H=a<58@^AVe<-Q=@R)aL?3a4_gHO3Sc?e=[(0fP/A.,d4N+^15g5(^1::QN4e+R$
`endprotected


`endif

