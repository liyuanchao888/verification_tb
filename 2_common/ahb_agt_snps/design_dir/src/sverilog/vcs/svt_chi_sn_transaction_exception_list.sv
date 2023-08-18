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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_sn_transaction;
typedef class svt_chi_sn_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_sn_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_sn_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_sn_transaction_exception_list instance.
 */
`define SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_sn_transaction_exception_list exception list.
 */
class svt_chi_sn_transaction_exception_list extends svt_exception_list#(svt_chi_sn_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_sn_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_sn_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_sn_transaction_exception_list", svt_chi_sn_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_sn_transaction_exception_list)
  `svt_data_member_end(svt_chi_sn_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_sn_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_sn_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_sn_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_sn_transaction_exception_list)
  `vmm_class_factory(svt_chi_sn_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
4?JE_b=bNWO6PMO^\K\AU<@48T5_O<eKV=O:ebT#)@DeJ/[=59VD3)6.,<ZcRT.;
XQ[S9JJ:(ESDHFF</g,QVE@0\e\MMc)YW>a+/1ZfM?6d8:QCKSKXE<S>:F,_:,aG
+Q1VJ/\0.Bf4E8V;[F,J8SdW]LG/9+E&5VV(c)QGL(FdW,=g[31=WFZOUW>X410_
LS)7KW;<:NNH^5/#e<RA\+)9\1Q_)Q1Z6F,)(F6P@P[QdU(Y+:-b0)T#a08S2J)P
2R>Z6^RA#U8U58+#+g9OeF,:e5R:(63P9XXPGS\G&_2cF43J1UD?N7R>0H=1HG+5
,)H3/:5IU#GQ)=L)9WIJ][1LO+)JDMC3_W-RfBUBJ\8LN7Fd,U(KSTQ6JaPLT5U9
=.Veb_3?9g,Y,J=P31&7+U5,=X=/VADMgJY2(B+YLWRJTMbPT0,50]<EB?f3M;M>
5LNQ,OPOP-<_?K1;H@<g;?@(g_C^I13c1g>;/GQ/g_1UR,62GJ[H&9&,>?)=L=6U
X&Uc_Q^9F1L7I^2gO65)WCC[eTDHIQ7@&>F[NTC4B[479XdaR<IVf(-eQe+Ke:32
(TG:7@Cg>Q/W?GG50E-F)7(WVOJI=D?[3F=F=NBIX^)P(?JK@VH@2-gB&XM:ML4?
,b);@K0??];7#]cGO[[FP<Qc/IGGbM#BHYU+3:<]K1)U4Mfa;aG6/&N2f.aAHYNa
8YFXINT)&+RI_>g1UPHF)c,W8g1ZFOS9fPf:O(09/\bO9Tg21^Ff7_[SH.ZT^OX6
CBCe4Od8>GWJ,VI/),?CeF=dE?XDJ^1D7>1RZX<7V7ES9M+c;_MdI[X?[MI@YOCA
-U/J@&FV9gG@b54>L<NYf,0T)4@BF\U\KL>D4c4VM9CC#@:WD(FVgJ8(O@X31_][
1.Z2P)M.N0GCZ1)UW9TI(E8-<dd#T4PPQ6B]Hg7GB[V6YC(XG5+T81BG]S3PfNL_
L<F/?E;72=:1dIbNcf(:A35R7AQG4?MYFbON^O/PG[.5Za]:QcM;)YO,/1dE?OJ)
V+cU:Yf_^RN7EZST:,8_>e3K869AG=dTK+C3?a<.b;?X/PZA&L3:O5^QcO7@RT:(
=PLC+],-H1Ab@&B:.?4#TAKL8L?;,bd2L8e]=(]YXeFMIBOOaS/55bGXMacI2U\JV$
`endprotected


//vcs_vip_protect
`protected
R)eJM_/dZ9#+3I=WSAT1@03LVeC4ZDaBVK44DF_;[X940FCYb)aQ.(2#MDKLaLSV
H:GG&[M(-TF6(BN0K((3+UB&<+Ja]07J&.g_+6=_ZZ=:4(dPcE9+T4/XBO=AefUT
ZX\9-G1Hf/EDIEFU&6ZSMd+?57M1X1+SC1g,R@9dSM0QC:_E2IGYR&OP=>5_gU/K
>3YP>gf:[bcGY<0\D0AfNX=@6-KBH+4M2Q?(3NZEUXN);,/?1/7H[0]\M;=2H0,7
+#dBTdV;\6)c@3g]g]:7NAea1V)d8>8]]KE>.L5::4?D_bb^6357f^E,J5TPMc(@
B8NXC=#CXGN)EGTEHf_[L6[#.\,YMf.cU9;=#Dbe+KH;_d9L[ccdZFS;NP2._<,R
^.F(DaJN2+P#;0eTAg((Zf]_GQC;JI-WPC.FQQ01_^:(S9(:#b:UUR;eH=XPO3_Q
]GRTfLG_<9J7//KHd>&aaOW7ZIeRf]X/NGc_L0PID8e;IUSGgHM963MCRfKZc:(N
MgcV;I;AM/R]5^&DU;UdfSH72)>:^[<G]U33HD8+7gf3e2g0U]74HW_VQaR1<CcV
0^c/3b500Q6R[aH&cF+#L3QfGDO]S)e6II>P9;SIdHDAg_?L8-11RF2XMCWDL/JL
YcO?O2g1Q>:&(Z4,5dN2c>1?:0D#JL,\fLSgWa(NU<VTNLO0_;B[V]Q@-e+CZ7Xc
-CO)L_APW-Uf:agF0Y#>F1BG<KPbJeCS&A4#FW@KgD0MC#&3W/-:>)G3CY\H<>JB
W3I8X[4^eE?&P\?QM:-U+\A-+DP>M]f<<BL&\7]_3BAID][8P7#E=<D]\E/b5[(>
#)NK6Y#5NfR;(-2-HP86>NU,cE5X3cX:-W7F/4TfQA.7P^W0DOM?8b0gVIX;f.[J
@_C8E_B_LK>DAZNI81N_PC:0-8RCR;X-O6]RADK9(5e;,@;C^0&^PAb-VLY4;_:d
])E3<,9aCI60,_a4(,K1LJ5c&Z#)C?EGF<&]HD]WD[)CbdgDK^J9C6(GaVIQ^EC+
DV)2<3VN1R&_d[,HO57XZfA?FKbbOCM;CKJ+@VO>feT/1GK@-Z0>G7UJU0F\3KM3
WMd#^?LeY,9^I.YXK/K]S=Ie;P:K?]+3;2CZC1WNQDW32NbJPdI<e.B_OPcL6>4(
a(a@^+PGg>R]aQ2W_ATJ^A?cM2)#d<&WSQCF\;+)]K@UR>Fg:,8NaQ<<]RTKH<YU
I,5(#.#<FK,VHMYB2A45B+)L_EG69R?aJ:#4MSV+L21^CSCd?>C1?9ZI2W28-;NV
&176:5Cg<_VIRH:A]DI/3GZdO4YGg##ZV3F6J/#N1g-Y2e8VVQg2E1Ad?PBG],>)
Cc=M?2dL#Y:QK^\(6TK.BN-YEe=L\Edc?(:WB)(S0PLgC;0:).L^OK?9E2G4f1Vf
X35WK&FdSVU;1a7V[.Z;^d]+24T.2+;A^gRY.W+7ZJDg1Y/:fS)6QL<9FG&D;CK^
TB-M(8T6S6=eP1Y6J[07<:f)E4/d]#=\Kd)dDXF<7Pg5]JRaBc\X-;MR3[bE.>8?
\f;c#,7H@f72,38X_1ZJGUVKG271B,PG4)^V=#VQ=cX2Z@,_;E=?E.T\b7:N]0YE
C4BPdNNTIf4^6Wffd>-C5K^dF](>:EI-1[.E7KI=G+30N/C2Md7ZDdb;b@T/NZVa
0O,JY:CIbVPf5^a&<)<.B2TJN@XU25AK=1HA:&771]J>dO0DF>1@;S4.GD@^XLIN
PX-[.=We:b.WgN;]ORWY+N8A)cZ8),UaCJ6bRWHRd)-[5gT=SUE=MKV]:/(DG\-U
?@)TM8\TJP45UM##:b;:8R64W>Y->_b._aG7WDKF:FMA=DGdg_23ZbO47,._8@-_
GD&3EA7==KeY)SLUS04bR;G9,-X7I(P-,.ZgFL@)>JTReYM>0a^d4=_g,4@HLVJ]
9@]BP)SefQXSP)>E@[(0L)1g^Z:@](X&H_WW\a(SdO[Q)05X)B8/976,QSLB9/K=
[f=J2VB+IRBfSYMBZBAKT[LT8GU\_E72ZII@Z&&24-Y,CS(6RZb&[NFU];.P,bP1
+ePU#eJ4^9(-MG/:15TO#7+cUQ\0.(HD5&ITc4S5ECF,>+\8\#JafX:^]&)KcSZ(
3>Qg3DPS+RI56(X;N9JaI-ANHP@;J39AK5UFWQBB5:498;e8P#1UcUUgeE)+Y:UP
ULA.HcPP^+D_D1-5L2a\(N=UDPGZOJa1=T6/CCVc1cXGM(EDX\?6;B2EZN?Y<,db
0GJK]M10fX@K=XFQXR0C5,AT)Q@a.UJ=0?BeYD:gVO)V->>=_TK&N8Q9dfc?aC@K
.-Sd.\V>&G71QBE,,52IO<#D.WgA/WdUK+N&EWUB/CX+#W,H6(UbH+.VPO_3L(H^
;M)I<K4DK^QbS[QG9AYU)O(]gaC3>ASYFf31c4S66e)XY:GMaM:Oe7V)[@VIYI54
=3g5K)KN^fcE9W9&X)f@_0.:[:(9#U#eU[6+[)1+gN#_YO-D^7XL.ZPY/P7_Bed2
L,\bU06b=R-1^=2+R>PVFLc74GQ/?AR5OMf=8><R(WIAU.Z)ZHRG5+g2F)ER=eRG
MP2[aW[NQ8D)BXBT>E95Y4<WM+03DX>&EQF@VG0GcV0f/1LT;0\=6X?&2YAb.L]6
1RSB>0b96[I6MH1VA-,WJ+)b2,)V(YL-GO_&_aJ_We3O[b6I@ZVCW)U5e[IZ(b5Z
CP(A1XW/C82K_NC(RYTVR0>&RN#4OIJM2Rf+d7\J_S@9_-82:Eg)24^C)e(R+MR-
=07<()Qg^B\I>Z>3c+a/H41>=W/JL(+J<:U#VH.,@-79a&2A9_5b=OTIG<S-5Hc7
,:/)A0_0M03BQ=+:1<#M)YP[PC93&[_VD42,08/0cgG2S4ANH;e6?QD=<8;F2#0A
K_0V&EX40772D+B-DEK?>g5)_.A;S4g/B,F]IH#H+K(cI+8R0^g8d/<IJ3Z@S)--
\P<>9e\L9ea^R^KE@6;UMFQdf3dD^&Qe=3\c.L5NUc&9eB:AdG4EA\OR#LXbB//e
8+3eaIX(QH>YE]fC:F+Eb(FKJ=>f.?6O?+A?.f^Y/Y\QHFKe^YZI55O#8234[0d@
6d/SUQR8IXA1E+1+.IgBJF(Y1MJAWZIZ/e0Jg)bf_@#8UE7\?1\/4@&,?UTC\UE5
-Yf5LLGf)B3H)Q&G\XG#1V-/a0Zd,&1F.@-6F-;V^#fN,YLZgfcUe3O)HbJ=baN^
5)Gb.9\1b.XPEI]OfL<dT@:[2TX?Z)5)SC\P?)R\d\YbJ:2(XAARdTM:\(A0g,9T
08fT(:8H@;(c0-_bOE?A[4(2=^W/.XaSH+KAdE[]C/AQ.Ea5ARYL?1^1Q;eUI>E;
(30GJX(H3=2GTIN?>\)EFIJd\b9\K_?N36-XB;D5.S+<ZQ4IT0PSYd+,<c,S>@YB
T0_=Wf@K#A/P&NM=)fA5EdG8ae;V1A01\(I+8:&(GJcZZC8eU3&#64DCB\-]e_c@
0d)_/&a/6>1<E^63M(AMUdIfYYR=4TD.R9>QgRd^(>cG6G@gF=.&(3MO,QgG3cYV
2]>6dQ3_;>;]+0O:\YJ93E2>LV4&P[MgO=bgBH41.<R4;W@5@_N,NbC62CU9D?OO
?eJ;>L010NEAK\V7e;^4Ac#aOH,;:>GORFf._70XXB-?6gU7+B01Ed#?S95ZT_e0
=Rb\R/f:;)^&:\X4,J6=:=(bFd>RH6NfT]BT;Y-/Z-).I;ZYX@TVTA>c]EbME1ZK
3K:AL:4A-)aQNDM9VD-EK4>>ZP4WF;9V[,/XcO>\RebH2#ASXMC&U=KX97>[_0BG
WG>F>c&69@.>d-aA:(QeHW+AL(D/?7.:N=KG<X^Ae3B.bDW)e:Q@MN@f:Cf3Nc3F
\8N>,&Y31AcT?@TY7W-Q9/-bYT080+:CKUZE+/]&GAXHc@K-PJ#QdT\[AJd+7a45
Q2OGJ4<K)=)?eEXH?RE#a109V0.464AU=/G9GOB\SX-/BM_YP+:J^)c2LUTV_@9R
E49Ba.\)6:M=bZ,5R(RWBEWI6Nc1gH\_I^1RJg4A.>NE)L3B@BA.I\T/1eM4Ae[M
^H@A@cT?#=C9H(D+,+)TfIVQBg,7O?_Pb\NfIUMI^CK4W=d_F/JMHDKY>+D>Df]P
@)XZE54\bQ.15<K@U.2UL8I.L-?_?9ZF.0BSC#We\I,>d8DcNR(NaN:P:[C3e)B?
^;NB4.=L98\&TIWSTY6VP]4K3,d>MWL)3F:L71ecOHBHGI4(X)9bKI=,Q>-OKNI]
U(/F#[G;0_?N7F[JR3<Y:>=4NVM;S[S[O^E#c2](IfY8b-N@2ZgZD]=]F6.^^ZYX
>YZgTFQ+_0@O?G3+WAbTB3e=\<_DbJ9cM&4RY;M,CRBJ@RIII:G_>+.VGLBZ8(Z6
T&<N6\])1#W+\3cT^C-4#/-.B9VKVc#.F4]VeEGZaN6+cF6g_[9<HLP>F?-a/J\S
,#47ZEW1MUR&5)U-/3We\9aX&PGJ^aEL)U))33H01AF\D9d).GK1@^<e+cFYb-Q3
HX7Da<^Q&PO):S[]Ecd9)VCADH#R5@QJ5)/9Cc^X?P2LcAe/#(WdUA1<TBYL24WU
].FDgN4J[G>T:-LN,RZbY@:E6TCR(Z&(=[R7EUR]HbC?dPQgg#VX@UV>EG-IC2Dc
VKQcQD,PM;DMeY)Q)Y?V?AQL-LT1,\SBA[9/BM+?65+<_.->TKLRPc0YJ6FbSFc9
f:4<@84>H>6a)U5,[SL\RScT)&g<J;5OE)3^d&=aa;TO5E9f?GCES&eB69?G/M0U
VWK]TM]3gQ@e4f\-aP>#<H-6.?,[E3)bf<8=&<8fc(fY(cP5XcgJ0dNgb(.^<99C
HG3S/:f:FK1@&[B-D/8\UW#R\88<7G]-)&;SNL=OKdA>RYI<&a?1R&dUR/0[G==+
S8G5dZO)4(_Na(FJ[ZZ+E[8NU5N@FHRF-\C@1_Q/geWHIBQ8fUH:1+?L1?\+?7TA
Y7Q5g43[;O&bgd:<HIA)E@;NEZ/PAH9deOVAQ8[SW8R?c34<LK9)>aWU?Q/.R7aX
OD.Z8\XDV1)R4NZ9PZ12.[R)A\PBA1]c,KS?\a:0Id?HZYUfOcJ\JGQ^-66Ddc>U
O>8(?6C)AFd6@-73_WMg94OC?dOQ_Q_>^W#SYJRMNII)HI1LC1&2<.8fP0P&5eZF
<NN41M=JGbB>Zc)RM=8TXI8f\&@&e_Ye=e&GAI_FUQG7b/<9gEQeOb794;/K/+N/
2A/d9<G603f-)\2)QE[g^Vd_W=3:Z9VD[QI2E+)#?\V.aPC:-Lc5a9LV+bR\g\I^
]-FEc()eZH+<a4FDB,/Jdb#M708a#dERe6Wg3D=AT^NEaZNBC>9[]\>?[>D@]_1P
R.#@9\5OdY[2A@Rf]JNbD<;U#:(K6NLb>bT^L_9f\W3YBV&->GJeR+,-V,>b[IUg
^dT3NZ&WDAI^(U=d7X3SADQ7/46;/Z3Nc2dL10IbST(A[G_6GJ]062Z#+IbMRIV7
#L4&0;\e,0,+/b4Cb^-3/2611C^?O^B,NACUUJTe1Yd853CVJe@NIC<Jg&BZY2?H
1;.E:QVIY4(2f:MNe&e#<O5W?)SfY+\Mb=?:gB,>::b.5NA<S)FU):QJfHNe#b?1
2P;#IW158BYE^(KCXMCEUeU_7:U>QBfQe^]YVdd)/RW/c9RK4FdY)Z0eg3(bW&F2
0dXV?.P.d<#R8Q=_N&^273^gc1Q)X.2fF:E\M-aa2SP=6\MbOMU38-fW2]X468Pf
8=WUfe++MAD79dA[2E]X[abZR(#g6M_b)PF2AC,G(<2B9<WSKC@CJ?H(KgCBBA13
./b[S>Y]Q-QBYLfPJGO)e?9M+\BZDXb>1Bb=)I@FHT3JYBEg6MZV&-eZ2/:Y7)@B
M3BHY.>&]9_1T=4T-P@+9S1DUcEQ3[6KGJR_QAL.]6e97e#.6[L_(Q,(<L/]RId-
7RM^VCA9&EHdQ-N+G9]U)Z(RZ8/c/P5_Jg&V#7PZU3NLf>;W8Eg]Pc9;Sf;cZ2D2
I81eL&6.LeQ=S-:cYI@;(C6Yg#@Ve@\3:/QU>[.AF@KS51H(A&4CZ.@d9R74&YGZ
>K)0a&#M19V#M-/3&2NZQ+e2=K_\@=[[4EV9ZM+SM_I02O/X)P+2?OPI-&(eHCge
W]OF5PUN5EOZ,9V4bNOTE\\NE@K>a2\US;],&=G13\EBXcbd(BS5Za\Z^;)=EH;<
@G@K8\TeNg4<B[-B5#>5JYZN[;5F-c=aE9=)NV[c3\)WV-BUg1I)c@RVfdaFcW3Y
C_&/[+OOeAIDD:8:e@DMN9O?<@2]FQO1(&b#XO/4MEU.Y3>KZ#9N7e1(^O6>d,AX
T7E,8J9L9ZeXN:P6XRC4G+XQ?JHW8YG[B:0E20/KNeWD_#DfZab]1N9F,\JW[9;f
]7.6L)74fPG664CS;5]WX@XCK\b-]eD=eC7UGeV<_\_,ZL@+NE[eISWEE)Dd_1N_
QJ-1GAJg<_QU+_TF_N9YgNGGHb6VO@F^_J4V/ZRaVK3MLYaPc,AZ[O#6FJ#@MR[X
>.E2eUR.C\2\BKJ1A.,<&TTD2YTDP6=4KG=+B@GBLb=1Q(3=WNABbTa15F/\WQL0
eAfQ,Z57R8AQd6)Jb1P/=N9,g8O1XXF8_QB?6>9gZ:_Ib+<IC,@@GdaLKDJ6ZVUd
W;)+a)^+_YN:MLBf.Q+V/I-8c4HQIA>gb,e/e8YBF-)H#9c/ba]-?2P+G[#e(.HQ
3/RJ_&&MEb6e#]SRE6P,;ZGI6gL2^#6OJ3W2?8R:5F9PA?A2/<D=1-15V5233JNC
+\)cT]X=N@R\PNNEPL2fS4N9_#<V@JaRb)B\OZ9/&56PRP_Z@KR\_0P61-7&)@9@
08KFHdTWZ\fZ+JA?;._3?Aa_A#&cS1fX5VCaD#Z6Q9W6)FP8,3?ZEF:A@D<<68NV
XIbdA\1];1Qb_BB(JP5,E<aTc16VSb@?0IMI0<OCOJD+9c15M.TReg)(F.&XTTBE
QGHD6a#d.fH1J8I-6E/I/7XF-/]bD]SEI3CZ+W-X<(0J,DZUVB8I_V=R/WceBWcX
;>9cU1KP>&PL@.ZV+;N75D<3dTX3,Y)9K]?7ZT:&&bbYB\H0GKYSTCMJ?&;FL<0R
ab./VIWXWYb9@g<],0dN03U9e?C:L_gUQ[V-;6GS4Z3O75(]D<9Z,\OOF50Tc-8&
^>66B>_e97L0.K<KZOXRcW=/W@1YMDa3)eZ_)Ze#\\=@e^BG3N]6]YWZI2CV-BU8
LW\>Q8.+1=R<:=@.7_c\CaVE)3+WCe7PBAPV>?GbV?>ZFK^U5Va_N98YDd+4G0A0
RCCU=J0[BGT_7bCF.-_-P=;.VMe&a?+2,\15WX/6O(@Q5A59EVOS<2-W:BUS^GJ3
-R.R7Y=3@dS59]Y4^dA(MW-8;)\XfGT?E5^[GX^eN:2ZSfb#YI=XZf;#),:GCK;Y
LEe1JCE5YP7afB=EcAO>2K?GMB(PI]31OZ^.R]FN.;3VM1,DBDW8(BE]6[D#@>8P
Z)VEEU=G3&@(71\\8EOHaU7G);W=G17ZZb/0KL<7;MQ_eHA\D6YWSV[-29_dgCO2
gf8X-37:._([Z9755<f_KW3F-PAIg?5,25=8,bC2V^?(O.;Ig2cB<7?JI.D]/T7+
Qd0MLU<\\d?:4_]N49f(H&P34E?ABR#YCPa7U7059+QTV6J)aIXWR-O.CWL[1?<5
P/<E^[)D&f87H;Pc\##=5__28DMF./X=Q:S&I_X3+T891L-d5?9PDU8aI.JTW_eA
LO/GW;4E1[B0@>BF2R#b?TJGE<ag66a3F\Q]R19/A[TX6f.P3Wd+F3c_MII+(.)<
:WVD^Y@4aR@/\Q;1>,4RJQ)6^G0aVNZED;Bg;OWTLe3>/aAU(f2aO[=:&>93@#O(
/B8(:2dGd2)b:E4UH\eX<C^Rg4dK[/c6>CTATfdM]R7d:TT^TII1UJ8;L=d0@gVA
9T/bDdK>X\[+8/7HRf(/fNX6f5X6KG:VHQ#//7.R#.f7LWRbTaXSCM<d4?B-D-J)
a)SD&?,^YL[30:+4\6(BfEV95Yg_N>.I2P7\f25=\Z=GBR),gQ,:;e301^IbD<<;
]G:dg:10F3Df>;)Y(1O&FN?^@f/)e<;Y4[#c.?F7P7.L@7LLHT[:W;0Bg\YJ=24B
1097#\^Ib.A/fSX=::OM95?L6V.LOLe0EL>9DdQ@O[40N-4:B))WP0>Y:acK:\MB
REM:d^EVB41,A?I#Kg6OJDY.>JO@Y@:e\VIc]OJ4Zb)1@X<(>3G<]eV+/8[/Xa/?
cJ/=C_#Ig9HZA8<:@DfC#KR=OYaHC,G_d+/>V[eYaV@@0?=;\;XC]>=_Q7ZTeX>I
C2-Q9PMJ9Nf+P^.b6]ZW6Z.OW0e+DXU1GH:,V[1bC+b]U@16=^Je,.1:1TWO[\-8
2a[C@/T+bdT,[F-ae6(e24<4/A:_?=LA>^6KbI3PPc>3eNE.-Y:8L>M42&A_YbeB
24NA>]D7W,)-[FfCP:WX(1_fb/]Ad4P[Y1,T6F^:8+]V6e<fC/&#^]G-c>2\4PD.
H(U;CbbV-K2Of=8a0D1#O;#5=0=4BD0Z&1&?#dBHV_@(,W-5V1@?1VT#f[G4<^)Y
U_H=GDLGU:BU3D1)E]F6dc\PN-#Q[Q-<OHEcL=DZQ[LO#WJDO8+W[)E7[?MeOSIM
:[fWgQ-CBcG1HBFM+W84Y19F4I[,@@Y,#ObA2WN+a4fGc#WPOdbRcHa2AKE0RZP&
W9NLB&535RLQ50WFgcQ<AA#+S6Nf60db&K]45YU6@JFb9/&4HC3G-fD>8g0M\__=
J:cOW?\?eRA5E+P)7Db@]L3=5=Gd>TRe,fAbWY1&\R^Sac27.=6BcHF[J?Jbe5g?
cZS_;]\b2YMRJ4A9^7Ke4;_LEc)]6f1KB(>f2\)b0;1F<4b934YB3^=-0K.6TcS1
R@G&+FgcDJT#bV/b&N,HcKDgSB\S&VggVGaS4,6CX2E==?34H1aX]X50ad=ZEO-=
_>1Y9c5_W9O=[4]_.T5;2^Ve[M?RRJFAXaLc_.LY7;T)>G@SZe#O,7c+Yb#ATS@]
;1EYM7e3[E8HQNB<WbcGNHKXDLY\+R#&AMF=T>.gJUB5/\=@(JQZc.6Q&c@N=O0^
7TMeXSI9#+ZGHd14GXcae69(VUN1\&:/AJcG(X&2_7U4KW?DHJ?K5>d4&??D3CC0
a:UQRcB?];<,;Yd9)LIW5CfDAB#5\8(gbA3LMG-^/-[e]5fBI:SX6:&.aR8a6P]S
H)0+>?T:4bKbT#C#QYf5K]&JP8d=DP0QW+-2=VC]#]A6Id_GQFBd-TW=Z=9)d[T&
Ga<&N]=e06;gIB7))+DBZ=_YZYEU_3_SFO]>9dG(]2,aI;);D.B68LWeIG]6Ha<0
fEeeC=#:Nb=W[)3GJS4JQ+URR?O[^+^g6FV:HB>&E=DcXIDV0cMNABNK;<:1O>]F
B\GU0.?2S#Z\EV@0Q.<_D+?0I[B.fV_#D#./UMbQbSJU1]1acYFBI=R0f6)BILdQ
?>O>dDMc\0N8d>+D+#PF^<gO.#QK0._K[\Z=+cM+P-17Sc7+0.:G+=#^H^GN,7PY
M.TceLM,d4NA4fV9e-9B.EO^^W:YC6G;BJ)Kc<5TYPKW=AZA0E,8X+1@N,T247_0
9LQ&gV3I#V7PAOA\,57FcQaG0b^DBOe)8K[QEeJZX)_;7,c?X19#ZAe.LD,;B??@
^FKUX?6@Rc5<JF27^:MXdVYA@eS[:G_KEf=\B9UN3Sf??/b8+(D5N)]W0-Jf=0+Z
=Pd,L&H+O,#d]C+.:ZX5#A5)3fTBTR7Y_:fR0K7_V#9O:-BV8I<P]NXJJULFVRZ>
#1,-b,SOR+eG<Y5Q)<\D\ED<SA(354(R?1>5,0d/?a=PDe?D/7>[(cBG2[2K;M/&
@LNc^@3EPC)2UI@c_]JUB;Y^NC<@DGM#S=GS:QTA7XAV8PD>I)742JKdDG52cgZZ
a@=_U_#S^Z?Ja@5[0S-ULTOgGa,0O)-L7P#FI_S&_ILNcU2).dc(8QSH9,T;D=7-
;NX7b(Gc:-F#gPaXI8T>IF;29Ug[.&PdH3HLS])3M6&#fVPOX?7AE>e2dXZF^AN+
(90Ng,A#)bNfg_D\8YX-N3Nf/J\\ccc?Z>X2@]B#(3,PBIXF^TE1;V#gc-\G_RDa
8a>84gV2X5aPN[CHY@CJZXB5HcGf..6?FPPQ&=F,D@^.AE8I]9XEI[E6IdO#9_gC
+2E=PC^WYC+:IXa_]8MYUff5gC?_CX].(c33X;a+9a^5>9)JKeM7C(_7O9&&:Q@4
<V=0[Sc^2YFg6-b7,a6efGF?8(^0#Ie1&1V4^)HC>T[bOQR2+,QJ2IW/)TIQD.E4
Kga+,aAOff0bN//W5#MS-\2XH3RTOd;I0QH:1,ZPd#&YQTSc-5dU17K.WA/-5U?3
J0&Q<WcPYaIQ)0G\_WUZ0(M5PZ;ZD>7<L:aPLXBeHL(ME-<#+>N2a8cgQdcM\-^A
<XFN3.@YOe,2NQAP,WU4S0FBL&9IcQZa-Xg7&MK4=IVSH/0KL,)OB841<XU8C84Q
WdCPQ=\RF,;,>@c>#5<,[DV@.]f>M8b^;Kb&-84U7:[1Q4HY)&e9IaQbVJ=[_e(3
\^=N-W_>/f/P7QAdV])E8La?>VUJf6)4PI]2;7N:W>gTR5gCU<2ULI_@/WQ60W47
g1C[>fC<cIB<.741#B4V(=a?2$
`endprotected


`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV
