//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV

typedef class svt_chi_flit;
typedef class svt_chi_flit_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_FLIT_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_flit_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_flit_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_flit_exception_list instance.
 */
`define SVT_CHI_FLIT_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_flit_exception_list exception list.
 */
class svt_chi_flit_exception_list extends svt_exception_list#(svt_chi_flit_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_flit_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_flit_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_flit_exception_list", svt_chi_flit_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_flit_exception_list)
  `svt_data_member_end(svt_chi_flit_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_flit_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_flit xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_flit new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_flit_exception_list)
  `vmm_class_factory(svt_chi_flit_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
LQ(_M-1C,JA_JO)IDA&<PJ&UB.MN,HcS#;+[B70^1fO?DECPg4)63)_A#T7DZgZF
9Y#KBS<)Mg9#7<.,>/+@+>-<XS93)_>4<\_6Z;TMB.C+C0IRQ7OG1I0&WZ&ONb5;
#3P<<+.P;95/)0L(G^W6E.dU8@\.>V=f63C#5GRO6>ZSU_?)[L\8R[0)J_OV2G)@
\8^0I=Z(;&Kc)H[;ZK#5Xf\XcVMTXNgKNDHCAb+A^_IaXe,90f@[AKW>8PK(/28H
dXIg(KW@[P[=:,MgYNFWFC^IW&JVda4#?6?:>b9/AY@<F]+^8D>BO]N/9JUJ[=;E
g5W,VK&Df5Hbc=&aJGB/D^09R\YCH,f6I=e[GE+.ZWT;04_8EaLH17/\1BZ:XIP+
fW#UC(X<a<>T2]9E,IU/;gcT3ZFF47+J8DfWOYB=&G74B(dgX/5P=(3?V???_[LZ
5_e_9+269IB>X8Gca5gK#d+_MOf59P2S9-85==FDE^eK]X=[O;-L9D)_W&P(R9Ya
;OeH41I?^E?8?O3;b1IW;UaKT[PaO9K=+g,8QI@b0B885RQc\2DXCWIR08T^b<^K
LR?59fI;95:0EMcgPS#--Ja:E11FWCGKW\2?,#?9BVAE]JW:K5C.N6_XWWC&,X^S
;C7:AO^_VYdUXd,TAQRMQQGe>]VK-1BV33>RWZ[[E(cX3>6I??Fa03<V[HEXD4JA
JcbM:Y]4+9;cBSXZU/@G_\)0e-;9-,=IS,[fHa0JK3=Z9DH1f+<afRcWY-TO5,@c
Ea7_dDB:HE/Pg:@KQ1H9aKXSF&dG\a9))Z:-D2][R65f82,W@@9L2\^LEc^>IQ5_
T^)N?S1+ZP+AG^eBg8;[,@V.\1SSWHJ3(6CQ\N@aD-Y5]^ba61,LS,?60PFBO-O-
XV8W0N[?-/cO>>EeWaR=fb>_FSUOR.86E6C?@LJY@)T)&WG?,UW8&BC(eHN\-E]E
8E[^<5e@[VG\#D9)H_[NZ2P0C[QS;XZ;c6U\UA5\(FSOI>Fa+&9CLUN<),aPD\FZ
?L1UF<ce.Ia4H^W;B5?.Z8P06$
`endprotected


//vcs_vip_protect
`protected
g00#H<UV4a3g1V^.GL\GGgb[(U7-4.Ac=G.1Gc,bJ@7D0U7AGKWN.(SMNC6A<b4<
GQ/(BXQLEa^RY<2)]J\f#D5B5RZE9^G)GeQP_5:Vf1e2aHGdb\R1CEUJ9>-/05Ad
OCN0HA;E0T7JJ&7+XPdd^]P>NXO^FW#5H=SH61#?gcf2OS#_6)?GN3KX/[;#UI?U
K_L3Z_]\d9?M,,4C3WWa>b(8,6dBZ.+JfOd5,16^^])bU0_,Y+R?]ZNY3UM6f_bV
X^)]Y#\,]-AZGeaT,Pb&:ce<G(M;U;7+N<Bb+<,9Z&Zf4DZbbV;C]^L._+fO:\AB
05GVQ/SJAd:)G8IS_cH2cdZ@<BQ,X->6@Ra4bX#>:PGS)ZTQA[/5DL9&WcX@Ge#L
]#.[G5c<QJEBY@4&MX<6X\A;>KKZLPP(P#aJ2J+/5O_8HK](][0K?/E[+^H8L+MO
H#+c,HU\f-,M.2]T1Z#e77GCE2NB,-;PafONUB7Y&e(C/?JUd?.Td,8Bb+HQS-^\
/fF_:RLH^a6[-S#4]6U6Y,]+S>4d0>4_PaYeda7MHRIQDFY6X2Zd&e0Q66H4NEYI
62Cd0f6S-.c:Z8IPF,EF,:G<?>&LHgO3Pb4<V)#-(fS<S?#^)2\7J<JK??=.72dE
YXFEBFLJ7Ua_c7]B+3S\IfS/Re/III:G].7ZB^.T83bV(0?\B49>Z\8ZJ728LM^\
JeL^?K]]]]ZUN^eUV]\C=?\Ka6#L_J;WL,&0N#^1\W7S)\&F3/EX\H2KTbOA4,73
a+_g?9fL6C(2(<-JC(LGQ0:,[(U\NUEPU:P-Y-&L8ASC?(0\W)B/[\PKIPD1S[PY
,:edU-N,]X-FA7=T7M_JUU>OS@GaGJMd30,)>dKaFH2G5cbS=#A:3Fd^gE/.HF:@
3#X:/M(WW4_8Z2&2aNE_=.eO:QgF^eEVT9G&aT_@Z.G7?ERgHg4IOE1(_,3DVD05
;=<&BHfU\+&QM9fJ3Ie>[F=^(;IDW6<YVLQBb^,9SSQeE+AfG/U?Q&XXK-PQ;GQU
,1W8&E7[@f@U8E^0,;[O,K>LK/A#&<CE3E:6FUNe8?G>KU&?Q3;C_YD8P=YMdE7)
AMVUB<C]3I=A21Eb:K.E7ZY(&E&+E\0X-5eO&5I9:D00N4F9IQWHD0;]aB[VSB@V
D@>:;@+@@(8gC^).dHAPdB\7,#QOa4/Jc&4=3=-1@4agHMf&#(Fe=2A]<PU]TZA[
Y#I1&^8T:bU7ROFD,Z-M3;SI025]G^DN2Yc;,VU;R^EUAE4eaWe4;:e[1V@&?^@<
N/2T0M)g&3,AIMT(g(A,ZP0JLc3Ub,KX7Q&bbV6(8BEGXXIKQCVUK&eYD>(.\dI2
RB<+8AP\gTOVeIM;->bT\MMLU\THUb6Re>5ZYGGV?UKD,K2_E)U?.d?UV?Y02S0)
15#@:V^0,IVP1Lc2^<JA(7S)/aR_c&&&Q9UNXM&(T5+:a5)LE6DAZTg/(PVWWfRe
VIbES&H3>d4:,ZJKc&XIPO_2ET@H5bWK[@KE,IN\9:<G^N5D5QJ,f:5;K+>Vb\?#
D/>bYe[V?9OKK0M?NDZK#:?,1WMe/<>NX<FJ,gJJCQ7c;1R58^7[\U#2#MFJ1M^G
H2P,IIBe/O]4OZ3]5,3ZJ]>TMTM&#1A4:#@\:LaE_9c5e=TT37E[/EQfSA]8_KHZ
aQ-=D9+9dg1J1;WD^d=]f2^=\G-+G-(eXO]#7+f,#<@Eb0B#?B;NScR>Q;:3&Z5f
?+EcUP=[_?)XE09\8L7+L/b2H[;^)^BQFZMC871W01U3PS2X-R@W9gOOEP4:G)[X
Q2;QLX^@X5gJ;fg7gV0bY<L:HB_F,bOU2HH)RSDBW49gYaB#L>A:\/b33AU]?OGE
Q491K.Oc<C;b^OJf>3:7,IYZ?OI68PG6(ZIa([87b<_7B4-HC-28K^f;A/1]L0Ag
(MM)OS+Y>eD53U]6#&NQ9KY)Sd<S<aLS2aQF9JX#E]=51)2W#AZO/KZ=_ZW<7107
Y3N4&V98#DJ^C30+)(=Pa7=0,P@(T[7\X1bR#T.:HTg>-IUa5LG]<((aOH/?S1[.
#HULDMa_YSYUgbJ;YUB9BK5F0U&1\+bN@C_O>9/OF=GN91e;]+NaJC)7H3]YZSRA
(^=FQQ.KaCX\.#/@M:LG\;BZ?5KZNQU37W1Wdb,#c#OaTQ/JKA[YN@RbEEM41c\c
cEZM@449YdIO?5S+Ua)Re6H1_.BWd]8NZBM1WVF1;;gLBUFCU(9Kb)b.3Q=3L9F_
U#BF[\;EZ3H9cBbQTYNJZ:PbE/I5GA_]XVCFBRY0#4/CM,MG-6f>VQ@IZ(GAK2H(
RSEUI7UDEBL<9IeaNQb]/O,>O9Vd+I(3Z(];:8N/HbfHB/0_Qa>1I#0UA09P.4O8
\6cggIFaNg#A7;6B1DO)SH?Fe>fJX@(P.J+1-,eXCP/5dA+.1ZMWHD\dDGC+HWLY
-?60&<U[]cDdS=6\[:0P@3CY8@\WMb1SK07;C&e1V?:9Ob5+6U0g\B3D;/ZXO0F?
Z?bBWf@37S7/G4&4SS=aaFXCURX^CMdK(9DPXGV0ZJf(c(SHR\c;&,6QJ0(,068b
WU?J/T3c#I33T5FLJ-N09ac@.(]5SbQ&G@[85,dcQb,;2I8\^XKL(+;>V8gM(FTW
G=,NJW;7O5QFUV6):U9XR)P59_9]I5LU&W9cCce6)T1KQ\)EHR\QRE;Q-74/8#L,
b^C;IWS<+GPe--#,>V7RH&9eA/H#(A/.-XT[[/F+e;SOX.Na?[)Dd19GR-5=.7KH
Ob3<0,OS1&\>[efGK]^O6d+?e>=dY=aI=E-K=J3YJ6=\(Rf\HDP@NL?(XRc_R=F?
Fg[]&Y5791Ob-?/](>?Md;Tb=GbaKgFI.(aK1,:ZQ).PRTB>\?G78?Y#e)1_^,4P
gdV+=F?)E[3cH;FdN8CPgJJ@b3Q2[:5TN3PXNP#W)4(W8W,<(AX8HQ5YJJ)dCbc_
B:#X(+C+P.9>-KA,cJg3.g7M_P:AC&We^>/O9cFd5I1HF=5:\Kb0XT/bWV/8c^P0
XK&0:ECJ:g:RCG#E6\H_aI03aFGXXJG=HF<(M;aIG>_deVaB5J9LAeN#?BXKQ,0_
)82CVG,<bFBA?>c;OD_54)@,32PI7.0)V47ICQB5X9B=[GS].;7SLP0OdRTA9^F)
-UR9EOf9Ke/bHeP[=R/_c-F4-a4((6YB8e<d\KYIHcF8@P)Be6R@25#/?ZS,@TT;
0RCcMb2]YA<TVLe5(OHZ8B=3fcAGE0;GO6ZBD3KU&UDGEKH/?G&/3P<AGEQ:D&5V
\8TWJ.BML<D(JC&_QU6ZQ5347+TY<U_1a7\JdgTcHYSRD@e;Q9e4_ZVZa#_VESM[
MA=Q0+c,\72DTe:I3c[KaY#Q2fVA9R<U^;a1I8#1/V_Z\TR+:aBN6ZAMbF]F01LC
(SGMgH/A,U-a\bNU2(<HA/fD+<L[SYM5U93;4PP=e>_ZIW/QJZ;HAC#a_/(fH4]8
=5;+\))D/NQD[@Y&;4BXU-JOLS=(4/\ePVf+[a31SUdAeJT1f1BTG&e6^Hb5,AN4
:0P,deG2L7,/9-G(g\L<TU:FCf>(\0a-B9C#8g@]NKGET)b0H\b[eg)XV2>I5c&a
c.(Y^5]_IBL]Z=5]Z5e8^O\c?B7.LLUMT,9)CU:B-YRK:d&UaR3P^Y1Y[0;^K]f5
dQ+IF_O/bfJ>T&b\LE=5EBcS:+F(cRe).FTU^H1MK6+5^MbRM_bLD98R>VD2\Wa:
U3]_(3547/.LTP;&[a>)f&/8ORN5=eENWPCeNb4C_+098;C-Z/I8c65&]T-+-C>5
U.X5GK=C.Q^WDFg,;1CXPD3:.HV.7>U\GA,8.8TSXVL8=Jb_,\WD<K@2RJ>RGNF<
+A+<EN9ecQLOf8-=<;X3PU3O29VaTDS9\0ZV84e0=FU@bM6IWL1O(6-9\Zb,E+A6
D,EGNKEbeBE3R9#K,IV8SP,39a.B3QU]<?FD[WC:a?\ZW-FMUb2PJTBQ>1S#Y@]#
cb>-1,;8,UKfWT<1e>0O9^,/1]&-I.=K);1\UZB[S-S\\#64M.)>ea)=^-MN96@e
M#_KDg4:X=9gSgc#3R;\M9)3@Z>=e0KCcdH_W/8U<)EDP@C:4U&BA&CA,2U=E<>f
7Nee;T6g&WW:@>LeACVA=X5[:(aJFG&7/DD</YeGF]Obc?d-c8I4QG^HPD3gd?Od
C(.^b4:()=_bJR\MSG_U,Va()IDb@TaISKPG9Od,D13(=&PD77]3\^]8eXHIb&X#
La=TVH+W7,>=M^(&g2c;Y3,/.WO)?_ME>1^YO;dCS-FV6TgOHF[eGM1SMMZfWT=O
USdFV7\b2_]bF+7E.daE^#@L5DX+Y5_Qb5P>K0FgHCbMdaS&70K-/#6,^F9>(JUQ
?2__0.Y(U:(Me=OP]YEK53+0B\OZO5&>D+a5b:YBY0@O=N6XM,-J,eOYQRd;\,.N
R7HXBAQFfG[9[\X9?aR+N@N.4O_^^4K4MMHMb2XW(^=<99b?42+;de,WSdfLdf7T
+#T/6M?O;17F\G4dT\BeLbYHO4QEa@1;JU<L91HMeDC>R+PK\/C_YZg^AT9V#,,Q
f_Oe[)8XOO[Q58:KJ-HSJQZ^@Na4IL:Hc0D&D9/,]T2e?d3?(eEJ()Wc2>/&HL\)
4e.N@1=Hc24SB.Tg:e@T_M[Qb>I+6<+:BL2J+M#IE&Ye)&OZ6>.NA]<O]C+@)W5L
gcgf3Ub#OeE^O3DE-[^DMcC-Ga@;7TaZ#PA8^Pg.e_ZOR>I@DQPaW2CQ-^5d(NM7
VN8C52DeJ-22M-&RU^GD)+FTB2(Wb28YG3-;L7=4>BS2_>85Q/V^(,^&>/+]7ND_
4:_N(R@-<2<g^a&f6gE.:+?O<\bUSSWGc6Z]LZ:W,V.01W+-V(S3D?HVDfGYa\7L
gH,DRJ1N+V8P@eDFC2>JYXdE7UH>Z.OJI)bQ+_;+2_N6+I@R]O[aZO/3Z-#^fcII
fF[D=8L#U?Q0HUMP\5Ra^9a_[\35YAJfbJ0(H.d050@F\\US4(@<PT>XB4VSMT3@
Y(Z&W?c;21TZDKEQZGB](50^L48[\f3Wc8Sd]@5d;(3G(@c6][VQKKJ+D+7OQF\9
Ld_GM&MCB/eF_4U/?=G#ddH7?gZ?#VITGc380#FCeLD)-W=R\<-NX5(G@7Sc0ab-
)U17ACaM&OW=[33CGb.\/cV+T<7KNK21.C7S2[-d49HRbFJ3<W-#>FH=#+O&#0XT
-HYSZ6Hd_L@EbW.,1B.P>RMI#04RO:5D8<1/MFWK;>MI<;>WA^?B53@f9<^MD3EF
7W,&5P0#FC_c?GLWS2eDb47<^G5IE0S[E<aJXEb-6Yfa#bF4+A/Uf_R+<HWTcFfP
Xc(6;c@bDb;=^AH.&F-G^D:[VHQ)UT^\A(<_AV]f?@)eXO+(C6NHYNc(S@[Sf=EK
-(_]AfL@0X2.WJdRe?T(-Sd<K?W4V+ZE[[0?bT.Yb0=(-GVBQ89<S7c7+/[>c^N/
ISJA:(ZOM4]?JeH,ABeUIXD&A>25?eB0b_A:-T)H9>Uc.HYKY,DKKgL_J)Y=e=GO
:0EY;&26848^NJ>K.-\dV3CAe6G0M\#S)3R-Lb]R8O-JWG#@b-TI,b;HgJ9WS?MX
bfFAV;I:TXYaE?H>),3J[5Y+#4[_7#)c/a(#dNYDHW5c1P/CLg,942;71FS0-,V0
+(4A(;Ic,<[RJ0O\?;UK-_6LMb[8Rd1^9BS9LFA)8(a/JJe=V4.SF=ADPQeWG[SP
.\+E8CX.ad<_^4COVE>2_Y&1SK<2AKb53TT1/NETI-9HgaU;6<f^9-K7g/A)0M;P
BBO)E9W1X4c<M_Z9X@;UR34O6335gBNFe?)T8N7=N34X+IXNP.N+:\TE19U,6a&L
dbXU2-C7E.CLY1KJ<[ZTU5NJfD8O/ZeB3TF7A_H/V6F5VYX5BE&(3?I@<,GL1gNY
H><G,=F;79JP)B.+U4e477c@-7_Z,Q4e[DQ.La8)H#gSS7?9W:_Wc52)7g.U]>g)
Qf7]Pa.#50R-WOd/fbUB-UKA&Q.<-K4ZI@/>/8:<BOY38)KYefI\[e)H5Z\&4UB8
)NU9^:Hb9\55QU(C+@Gb)_\H):a.SV0WT9FUcO[[^<I?3S2?gCBSI^#cHOJ5M7EP
YGN^1.a&[fPZga>^KLUcYE])ETDP,I7(RD&M6SOHa?g:>]##)9?5Y7,(WLIY-KGX
_<McS[6TK7\\=b@;Q]I/H+XI)@LaU#6D6?>5:]YU@\W1Y6aVL7R2#E(]f.U+cMKY
UFb(ggf(TE[3:Hg@f2N\13G>e&Q>ZV#b4XP,Ze??dGU<B,V+A;1+EcW[FPb+d.X2
aW<-.<)b:bBc9TM,J;O:QUC@6=-E)3&M]Hd[LI5,=M]07#=X7^\\5S_#,-3MS78,
3E6bA\AF?A6?V/gOFf_]>-Add5A9PgPZ/W802]^fPfBN@=[);d6F\S(2/^PMI(.^
Q-^IEV2G66-#6-MK\D?CT2,C&49RTR4:IV^S&^\KLJ[3009L;.GI<b1<W3;e),#d
4ddDO7U/+9C&VF\C0:E3BWRB()./PR/eJF^d+&]N2W\#XFK>(_H9)?LX+d2N8+E1
PU4#(.?BLMMO1--.X7S.5aWU<CE@KQ2GC@8AES72Z-HU]X&E&]WX-5GJ9cA^E@-P
D4?JYA/,,#O+^0=c8:R;Y<Vbf5#6:[2,G,+3@gJ0\6GGKJV<PV)/[_Y)&O\#<HA(
@[NcUK\<2B6AcDMI9,E0&]<6L83&(_@RNIgd^]6O(@>L_?X-eN[UC4>Y7Y<35d#9
Re4F=@^>#>6]-9OHB96K__B:OE6eA<3E72K16F>39A,VCLKGWD@7>_EgE.4Z6#[5
3R-#@^O?2503P9-_WEYNYcSMd/MQC=BE8c_\M8[-3>&Y;GGRP0Oeb[(U36\(D89C
Y[_M/9DEH8D?E<,a5>_H5&?50GFa:/EN4RPXR@28IPH0g(+93>8,(OZ:22-JF>&G
5ffKU+)8)LL2U\M-ZWD6?JO]aP3></RC[[@T3=][0@;:e>RDeHXaQa:TWT\/AD6W
c:P-W(KJ8-IFV?LcXN<A]FWYX#8D9F@&3])Q,7,M3H04@Tb#CU]g1(=GNX=aTDdd
DJRJC?U</B,7]28)P0J-^/I9HTNS#YDEBTBNN;C;,=,#&0DSU7?WKXKUf<Z7#&<U
IYB7=bWaCYIgePT9[F#AJ46+aR(KOTW1)16.?U2g1RLJX,d_feEKY?7;M63VL[G0
T.JIXJK;-eWYV^ZH+P413aM:+1+S8&Q)<FU7MY=^UG9??W--SDPeGOT1[>,_f0LJ
N-,[,9<@9\H]L5I1D6FbEYA\X4>d.(_-Df>.,Be/-B0^HWcdSe7(7+213<^#]^eX
=Z)8GUVa4.Y\)GGY[WA<0<[.1UM^U71+M@N&<LB=.T-cF8+7gDT+OJf?HT-KY-@=
74.^Ed0_eLdDE=SS[H1BCBIdKZe7DK;I;15]>0ZcMNYW@ADC^e[UNZSO^dTQfG)3
HT7e^OK3^ET3gIb/A(+EH55,V,D^FORV=VHDIU1LaTC#>1S\OZQU8/USZFe/aN2/
7^68-/ZJJ(Z>1Y2U4,:99P<<\GZ9aP7W;,DCD;\Ob);]c9M:;,]M05>\)g8J0;IU
&cT_R^^UL0Xe;(gKQP6G3]7S=)5c,4DS=5#IIe\PLS;HTb+]:?8A>(DB3?/?1PcS
aNVH3eI/f60RXH2LcQ?VKfZ#ZEF=3KVI(Z+);LP^5Fb-J9@?0N2))D\/:b:?WY)G
VaQ,2HAQF:2MHeVO,3R]EY?ENf:8W@>9:MdROK=5LC?CC:1]P6OJ085S:c+146d&
/FT4T86Xa.2/V35KYebD[af<VE_Hbfe8Be:Mec.eT&[)2HFZPSWEKD-PgVFH4a)G
]E1N0_U\1G3/e^:(:-d7YK]W634,fB<BI5,LN4_-7+0KYM3AZ[N-I]P.LXgK8-=J
)YIKC)[I?ZEgRJU)?=S<->.dMecV;V3e)JWJCL\JLI=NRP1B,WVL2:[T2=F]GUbD
5X@CQZCc\Q?-=8FV(^60D>):42M_.E/TIMC67NKML5F@HRgU8bgX>9N9I+\N:<gB
cd=OLPR(,U:XTg\,g?g/CDd[]2NR2;0>Z@7cLg;WRIHN5=\Z7SGS78eXP7:M^I4E
+g:5):W+#(.F=AKANWU<U;93KER.Q]5IJ2=<4^&6Nac3<6fWaP)_OAcK5fd&E=^T
NX6B_Ia5_WYL\BcgVQfeEJ#H5#27@+?ID?^Og+CW9;32N<agVER5?FU/a1B8093.
K&b0fL[PC7Z3[0@E_>Og:[H];_<e]__^;WUKUNZ<?.<BC&K\Y,ddS)g,T:_>+=Ta
a382Z-Z69E+J&\VQZRUGG?8^4D39-,;=)Y92@a=3@510R986W)VEU)?3GD:[0N00
MN(GgT2+](\+GO-OcZ6g];1a;P@-]LIK2I^GJ]G,e\SXKVSO[JJ//ZI?OO4]/dF5
A)dUE_3?6<]^2#@;O71VcC5X@<d-\D77RXWZMCg<R3LT56JUQXaLDTgX[WBXP5I-
M89I/4O,D0g]=)AM_S8dC:^eT_,_e9&/=^@,>YY_M]#(:\,(/P1f)_)3PE7.9UXX
2IHIR-^+0)6@HSKOSIO4e)I^3Ta<G^&>VRZ4@@a=A&:(7TWb^K?c,_f+73Ocb4V[
<MfX\4IT=fKLU0:19S3)&/-<H.ALcU\fTM7-JF-O6O;WSfD5e9Ff(/JZEObVIW^)
4cNOY--9Id,IO:PMgA_Pe6;.?f79^^)VJd]\f7.H\^PdEELH)<XL5?5NJ)Gb>GfM
4W+70SG3(HZIE6@30-?J&IENC(FJaHR68e0^9.bOOebPF]M1U]b]eg2#fSK^#(8f
787U_+X:c-U#U3[gX-Q#AFQ^@ULH_M0Qd&J_2)^+1?NZ9eCJL,XIb]g3<B[V=.,8
(W(].+_]A7;bG9V;K3.+?L@8RQ_a7,7=46ORY9Y8;#dZa^,V)-DW+_#<I+[A(3A/
SRK1e:=MP<(#Pe(3TFYc,URab=GY0UgS#<)&G@;]T5_9I?eX_+ZGR@7eSE]>]ZOS
W1^TD+O1<,FBSVc1FHV7=0L]eVU^_V7Q<c:0V+IIgQRPcFF(Nc&0E5N0A<=VYQ4(
/:Cd7Qf[[]-EHFI<?,g?2Q2IIaHQVA6?^4PP18L6+4V53@C&_-OTSe+E,8AKJ[(-
NOQ_[LQ5SIbfg<Q:M\F9fe(?651&&G(<8G7,^VOM\g?QOWb\9,F(6OFB+:F.6X)U
&R^KG56-0/<765VQ^RfJ4a5gQW.d+^&N8QcF(2E7bM/F4d(=-4^>&aAa@eY8G.TQ
X?d<[@)4[R<6Bc[1K4^_R@35]BPLI:]CAe[c,,Z]C^H(_OJ>:7HIV5GW-O-1J9<?
&VQ[M#F_RAVE4AHP\L,@FK&db1C.H)ff@;XGWbURgV28>(Z[5Sea+_7/7=5HQPK[
.#RIXJCHFbcBX+\9YcOe+L(@#J^MV]BCd4__>93McbBJ^SK>.>Q?PDNaYL2R?E=4
6DW\U^RXfOODFBaEH3]eJ/c@c:9[<Pg^8Y:\D8T@M+R4IHHU+^@8>SRgDH=0c8G)
R]5W/G#d>9JU537EE-9;.Q.IV/D/ZG<M?R^Oec?XB)<.HG#]A@+XHZ_M0#Vf/)Xd
X>AK,@</?&(DW@ObgVV/G>;:?6WX5ec-]5EbUa+6CC6QfK_=D@_>P3Y=Fc8Y3SGH
,NSLCZ^d[;&WD)E+H)O1_U15AOE9,5XY#\W5Uc1a=gE-UGV;<<V\9<dH00##@W.D
Ub_8-8NCfUfUX(932[dGBZLT2aTYVT/Z-E5TQSOS0G=OF7)@0&?]LPQ>T6+O)2C9
O=/QFd2G^JALV;]W(I\5Y.-72NBS&TKH;>&:0ODHZ^NdU.^,V1cQe(JD^:5W#P(>
UC[c>]VL\]bY=H:1B166.^ZT/FceFL]1<:5>&H7AYY3^e_RE29J-#BeWd+?8,54g
,;=O(+b4)LdF/2QJ.(_(-CYL1T,7&_b\(0OS83Y4.#6#AeG6DMUO]B>._@_c;[[C
^Pc@4MWUWBJY9+FP;-.8)7SK.Z,5HdZZ5FPM.9LX>T(AWg>a0GE?C\I?a9b:g0^&
60K+.QGUF]G(@U>C[OZ1;L#H<0EQJT)eY.7LO6faM:AQ-Y8D9VaaKE\<]@fMFfDS
cJX-53C)f4]:8U(#3=_M\Q)SWaQI>X^I2g?8:J_#ZcX>Hed1?D^Q(H^8A1(W/K<]
1b/=?)8=TF#cB7?ZN78CY5/,+[X99D4.-MfTWJPL/@-=#\.RZ+DA)C:-HXO,OQ6#
8N7-Ld#c87Fb\?1d6fCS/]EVY=+M2GdBbD#dTe:>J1g]7MO4,FIR@-;.?<2_8c75
IZc,HdTMOc/UKdQ^<,G4\?X5T9+5PSR6L&DAUP0#>/R]F$
`endprotected


`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV
