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

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_common_transaction;
typedef class svt_chi_common_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_common_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_common_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_common_transaction_exception_list instance.
 */
`define SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_common_transaction_exception_list exception list.
 */
class svt_chi_common_transaction_exception_list extends svt_exception_list#(svt_chi_common_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_common_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_common_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_common_transaction_exception_list", svt_chi_common_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_common_transaction_exception_list)
  `svt_data_member_end(svt_chi_common_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_common_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_common_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_common_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_common_transaction_exception_list)
  `vmm_class_factory(svt_chi_common_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
^gK:0PO/D@&&0NS30\<eZ?TC1=+8-KA[?PS[+Z8U[M5_I07#aOa=1)6D_;&X&9AC
G1M>+<7-S#(b[NE(0LKa^^_SA10X4HP[QCRV8->O&L1<gPT-ZDQD)<LN^8026@GO
VZLQWd_-bfAI43/02gE?<]fY;Y+6;(D59]TXCe59cLfNF&^&RY#c5<cVB-G9/?I8
9\1.WSR]9g1B83]U4f?VOO.J_b,(@&:6F4FJVJ4XT;^M)2#^L0Ice:&C]92-_b&2
WSfT:SUX3X@\,EPaG>&A/LW6N&B[TaOd/B\CJJ)@bc/\B,&(0g?@.B6G<cL8#XBP
5[b:2/0]Mba&J@8WZ70>6C#@:H,CA,^[]D5LX\DBC6QDMN<O^[K-?,Q#-8FD)338
B</QL6gQHbHTW7ae8CAT:W_a4^[_P?gPQ^1]>U7Z+HU,K6ee-?NN1[:N8XaD4GW)
)[U_2LMABD\:+8P-R4POB7SO[FO\M1-\51?aL9.e8dJ=ef:c[6\\c160J^Z9@?7H
(T2BRA_(1aLY;:XV2Ba1NLHZV;STI<;c=.KN.VTWU^WZC<8/\:+7Nc@2e2^4[]U.
E=<-N.\gS\S\XZ,O#54[(aS\X073#d33P\<84(>(RRA6D7LR@57V9g0f)Wg7-1W1
2JT>ac,P^[@+=dP-WF[_#TZ.5_J:BL_ZHLb1/N+U_d6b\56)f[/fAPA&JROf-&@6
e16UCQ\.a=V[ZX^^aEQ?8dXgEB_Y=][3BJ6CPa/-P]N+F<aY4;.#>TY7D<:b,7EI
]MLOS5::(V9YP82(DR[[Lc[adS(c1W<#4f,\YGDKcIb:?GM(d8PSG7+X:/Y-C23Z
a7:4>P:4W;:&4f5bEAIPJ4Q&D@CI)QYA/e^ae4L(\.QFPN8E/#OZ0)B>eK.IV?I_
&Jf9WTVEYWF=KS4OK&)3\/I0TW-0aXNGMg#8)LEX7_Zbg4EQagSg11aSOY7/6-.Z
W6_VJba,1N5M^L6O6PAF]>a/+)=RZP,QOZZ->813aB:MSJ7X/64Z#9-?9VJL_QB[
37&c/73>[EcC?BfCN:.;STPPT^bJ/<+/\dVJb[YB_B)Tc1@V+UDaR<8MF2JQLPSR
Ac-<Q=\+NQ\H8ZAS.aN&e/3d&d6SER-MY2@7JZ-cVQe79KaKb-NN<^6_7X6?=.Ec
^.,,UQ;J#_]d7HW]cIZgAQVfJE5cGeIHgGc7CC:?Vbc7F$
`endprotected


//vcs_vip_protect
`protected
_=44#ZaQ-6NJ]HPZf64.VG3N8@;6.2DD;NWEa=g^;YA9-?cXa+920([7CC)CbIGN
7&dWFa1RA.e3Y:RB#gd[&O^JQ)/7OOVD(A-4C,A)\_ZH^_SL?C)YI/ga:O&STZUF
=^)J)QY:XMKB,1eaZ/;=JSEN;W980c+JG-D#T@-PCK]>YQde=b>V#LaPRG0-?K5J
ZY/M,2[MC6H#P574O:+0Y8LF)_8]UZcU41aG.088.#_6c8G.D/&\[4P#XcJFG8[c
>2A[^P^)HdB-E6OZ[?SSAOL-MEF;W90Oge9F8HGBO4:f=H&H?G,b7eW0X0N:?Ne>
^@].7^(+b)/OSVKUcgcKe4N])g0E5Fd9HXPCHXbcWAG1B+2TW_&g_&AARE5FcQ:1
MOD6.bg#fAA[W.fTf@68M^-&<Bed9We2IgPD&-a=7R--ZaadJ?Q@,K?E\5e9b3[G
,dL1g^0@AYe_64dPa/F^edg;OWacL?S5\>eQOfODa4fP\D[>74c/@DQ,UP=7)a?C
W9(Ia-VfY4EX8Y,O<.<1aJ_W\7DH,0^50BD[2#-#ZE2P<0:DfI9eC0=+)9OK<a+Z
1/-[9CM3N\K-,9S>\UU[V&BJ;;;,H:ReC4O/CQHb:M@d=F>^7cgHWbEE9)P[B#3W
4dK:ZX44C7_K#1<c#T9922I\WV(1g-HG:fTCJG_0ZE=\-:7Dcf-R[_#;J@LL,N=V
&S/?+4C_d5_>CSL<E3]S07XLJ6L-a-[BHP04Z&0KdFR6672@9:Ef&T:XAZO_5=-8
-NA.(_Z,96U5^TI.M-B=F8LSV/D<]2O14U9_UaW0e/4IS2S69=5=39JI_]#I0-&I
&T3S7ZHg^T1UJ9(6L2Z]UN3S1d3<8U,)O58Z+1ET74Y\@cX#c/g?@;b8g6,<I:?.
.]=HK&MQa,g_;)=bbQ<SC=2cJ4\&0UD8Y=S8Mf\9,01EH#62L(GF(eH5,E94NY^P
_N5.Y:+_47[^Y8;F4e12VRMSV#NUeXEa[VMTSYefIYQ&b2F2+82.<+0.J.G]7g.e
4:Ea[f2WDdH)2>13<a@[dY=c)7Aa5Xf7L+>-dE)HdNP6;(a(XdgX]SK?.e#)I(IZ
55&S##/?]]CNZa:)UYa5_(6dZ.WM3<XDOUW??0:UcS5&Oe-2F[3?bU^;Z#L70:?E
0AdRIEPXTZ:]:dI@N]e]&M_g\FVgCB\7>DOPWbAg7Se\PR+_9#:\#Q<7:b0Sf-B#
gF>>@4BL5OJd5AgHG9G9&6bbWKJKCRNg[L8VAEDQC5Vd33cR-E=6XA>0D56<+_MR
<(d_eIB]K72Y3RGG_#T1#8N0\Bc-]86[We2ZZeCSXVJ_gOEbfVB7B)._08IJ\_Qe
7fQ;+H0VS6_4,(TB?D1FI)a3_;I=aOG8Y>=P=\V[0[MJaR6fcG,)F(&d9E=?F>7L
G7BPdMa.]fBN:GEQ#D@.a&LE^))4HEY&+H]V-3cCOPRT1L2[TXLYC\BO,H-3Z(Ca
Z:\?[W@Yb8FR5M=SfI?P+]AJLM8FC0B^-N],8X-:(=(P5fdMVf/c<V8KJ4=H55Q#
=^2AJ^Y]V8#AE#02PRA+_(UIB:6GNB6LDUR:DdQYfD^]1FCD,HVC>7[)L9>,GAZ4
_N]c/SVP=85S:^JEe,LW_c]#F[^:-3d8CO0BC4CBI[ab:\(EJeFM<U8aBV>HO<PQ
^e_RQ?Y--?^<@)F]L52bXY]U@=\=b8NZL+.D81_V6KS8bTJ9g+?[V\/S_dH7@IeC
_UU,e+FU9/L#D\<R]b1\Jg/)#b+bM(@<0/AY;cA0c(J@B0TSW&^AQ<PA.>U6(7Q?
H>M9>?]\ec_X8Y)7F1Z20a:0_gQXU(a:O2=.Z[aXE&OT5bH)W4d2;R3ad6?KUWGO
:PB^D:ZK)5W=g5[Y>^18T0(;&VNRUD6R6UX/R=RV\#\2H-V7]JGLKQYTIZF:0;][
EEL=0O8IR(1T=.6c<T/9Bd.a]-CO-2CE#;#O6;YH:[5NIbQY5;ZL1Na_>0E>FQ:8
<8ILg3b)c^)0WRYQQaaC5X+4,4[SYA9M9&[\9&?QDD:(B],S0T\6UJ/WFS)b.\F6
D76R5DM_.:c-A/EfUBea;Va6D3Pbg,W:Q66?O+@F)e#b##JA#A0SR>ZSd))1DGQb
<A>?UcLC3&NeaM_6Z+QCL^LU]C(JS5U]9=\b(JI7S_8YRT+e?eVM<T>e+^?.)_U]
d7:g?(S4RUR6a^?[aYXe]78[4>)?Ha-f8W9TeIXJT^@9)+3D=)W8W_WTN&O_MT]&
6IQS<^HU5e+HB6V0U.:)&/f@bMb7c7ALKQ?1?SHLTP44c;,OR@12<X2:2KKQegCD
Z1P]0)S3CH^8&8AF&=A7Va?U13VX_e2C0,-g0Wa@?P4[O@ZAbF]4@Kd@>VD(bBYa
=W(GCL>7]HJV4+2,PbW([H)#YPT:LK0RB4D5=7P71PXaIBH[0A?,AJCX/]b\INV[
eM51Q2Q+J9Z#SRXVWe?dBVPT-H&YM@LZ\7ESJS^Oe2D9),EI3TRL2PH<1IW;0OQ8
a_2I_Q]N_e,ACLV8E?:S2)_6+1Jb:UCP/6&ZZeCReT<Va:BK)3.4JaMJBWG6LGbA
NAIT54f;X8SH+_RIOc4-Hb1d#XT#21WJ,;(CFTg;J<;SPeW4_W3&4P30A8:^3RCX
M+Y?#R?2#G)7RH+;VceUZLE5HfLe,:R2#ag/-@V1LE.;UKCN\CLKJD<<dCM+>-5I
#<&F8W8(7cP<3g]9Z64<XQ,.H1@O0D61beS&cI_4fKT&&B2/Z.)Re4R98NTM)CV<
OSKTYb>_RM,4.A=1RdbD1)O)<&gL-@[,bLEA[?&)4b0TObAOG12-ZCD(:bGEWcZb
:Gd?-+fd77(41BWdEd,LK]KX>8a5Z1Q.dL_bf2bZWe[F=GTb.G,d^cYM?fG5#\OY
E4A@XLRC:6S3=U^2;BA@\S^#3;1.4DE]<3aaZe,&I@ca?M,F3+UY?#2+aMA[Nf=e
C9W-]+HP(S55]8NCH7d2X/,>6?cBDe=;?7S9U,&a-V<LW(AWS1>0^Za(Q5MI=R&;
BPa#?+D9]@S2e;^UA/\>:Aa]Ef6BQ<S.cI+E^Q_96G3FAHbYaTHVe6Y^KV)EZ5&C
^M]1G@W@TG(W/SZbX0LHF&I.0^(SIbSLB,bB\=B.U828acF0gM5&70TIX>6K8-M(
Y/Yag&.&Gd]PDDWV>b:<<>g]cbS9GV&cR2?0+gN^UAd]eIL6Z?Ub6K;N0ZX/41(U
]0;6gZ(LX^f+H1M,U^NZ>YT3?fbK3>FNQQ=DeV_&_.Qd/bRYFWOQ5A?)eNVNe.XG
1P(MU:5(5La6;>[S2#DS&J@MZ@c6\1TM_)<e3b3FJ[W@BaZ@G&M<=5V3Od9]R3P[
=226.XI8>OEP.6UM\V5g1W2?\eWXd62K92]Xa>F=&0&YW29BJJW:Ed]8G&,<QMAZ
X-#dSLX.[.7#YO<@XM?Y5LB8a5G(\4<ZWe<eJ?;T)4U/Lgd_1e:(/4G5EbCEMgG4
RB73E?9JOB7LEe<BTIcJfg:SNMJO5V;]K>99=].<g/@EEE[)7H92DCE3+gf#M1^C
=AQWT[Z9,ZEfX:WcO[Q5VF;#3B]&e@U-VPB?_57#)GP05Mae:39=(+2c\e;Q=[d.
?8Jf4T>LU\b9B?K]P)@cU=&1eP.N\WOBf_9K<M<A2[T7GH(;O?eD#FZDVfJMXa-,
e6UT1_SF/91=G)Sf@J##BPWHc5TRU)&+(D,L&CE?/Y:3/2/F:?\5DM#)TL#PFH.U
5gNF8YReBSSI.Df<@L.a(AO2DFB3UXHb=L:G<1H?ON+]PKG-2eJ>XLXO#_;eGf)S
P15H[AUfS.8+>6EGJQ<HWdCMdd9gH1-.H\G_,7]/U0=P:?F;)T_^NBEPOM9AF4A+
[>5>OV@2KT1R32K=c=F3bL+^)_01^F(8N2-b]D]WcDRWF[_8J_-WJ8TZbWcOdP3/
BM1VKcIXC<TOQ6&:<a8_;795;EQ_?\O]P?Qd?E[(&>O+OXG=M5g6Rf&Q.,5eNa&g
J:^_;\>T2LT\5<EUQA<1f]AdG+W?1:N8&L<U9;Jb.6@/.dgeK./.AS3\ACa;bb;J
(aR)aXcI^C-=8[-cRgM1T;08DA2_3\Q15)Af:+\L^eLU][?JC0LP5&g_f1@-(Fc5
T3I/2,Y\gS#_D8.g)@=Y6H#XfM&)#@FKUdTe@a[06Q3T8YY>JZd9V>P-OF=F<20,
<GTW:A_>F,W;5O\_3NI-PJ=6K8Nb3Ld#3I02/_>eCCKJfKWLEe=?\B7B/HaK.2],
78D^>^b[SIc>FOYS.fHWYPf=HY4C.#-4U::2CHbUKdMWV@AIO,M[HI(,#(YY@&=Q
V1C96aK8V7E&D/#K=:MFFYU,Y&0+LEF8=U01Qd&LR;Sb(XgI/1C>XdGHDBRK4b0V
^[L.F>#Ne]E8Le_5B&Uf;7<<587<a0cf<=:Z]aB>D<5e3\DT@:M&^@@I^Z[OZ,_[
S1dI<QbBUMgF1?9[_e796_B1#VEI_3Qg_Lg5<4>+f+^3SI@W+Zf,HM<=17Y7/fR(
,Z2?KZY<SC.KTWR0@+W8FKc+O\E5#5T<B8?<LP(U)3D])5SB8?9W0P]H7]&7.JG2
J+QQ].Z8;EQ1&8.V@F/74#=_-A6/)d=QAR-=ASB]<<\?\E,ggK^#WH9<dB_Q&(+)
D-eSN-+DV],L)d2+?W#PfOYER,=(bBZ@Q,W&S=bT#6N1DeUYZP>,V/g<8gHU[E;#
Bf@7He>U0V2G;aT(H=2dRH],VS(f_gY8>O?:CF/[?0V:^L_-62/=0+E=BV]VEP_3
CU8NdHW/O47cT2(F+aPM\47RdcgdR.HQ=d^cTIUXP^,60;5FJ&<\-;c_^@bY-Ye,
Ze\#\EJJT/&e,Z#>\fF;3]f6F[cH&ZG<[7_XL/=Y3YZ2<.c7Sa:5AY6D:>RKUZFC
&/JdOH/]\VY\^SFE:SYC8VTW<17/W^IM:86=W3\QCg^[f2MKT;;T18MN_B-^V]\@
&E0HdUH4?2FDZT;(.]PJ506+B3@@A6eYI4UcT+bVg]<=8P)XgZ9IRP69IP[RJJ(Z
\C4K<V1gH<;V>DgH(agHAC3:_aZS9W-?_<f=RJSHRHF3)]Ie4&:;5O_#6f.2V3:2
5L6H\AR3UQ_&A3Ue;41,];f031]JT@K<MFML=@,/1<92-]bJ3E-T>P8)ERMXW=<d
NHA6[IA85c+GT^838)Y#)1O+,K4K[W;E;Kdbg:)4BOf9d7O9,91RT.8/N/cKJNB.
80#1e+aKd5^ZGV5(5N4H3X@G+Q[7cf.16U[4@b_P^b>cQI0JE,EC-^9LLCF31V:e
;<9K1)#DdFNY.@2-S0V?3;P#7-e)0.GWYWLBDeQ6,(FD2HYbV4#2:d[]bG<6MTS7
Y1eCgUGM-5G-HfFZSNP<KfPMIV_QYaHSHRZ#PUM1aS,XTMHCTa/C6GH)B<__11^c
5Q2gGbeNg;=N)Q?];fE:,WR(/&_X)Y0a<OWW4Y^,7J=LG.&XGH@2D,;EF-<]]Q+a
+8::C4,QQ?5_25Y3^[.]&#47>&J5M])>90IgLSe3g=e,?Z<\0Q;@T&P/@_6+1fg7
S([H]Y9ddO1-DU=/@]WJ6;6QNIRK8]JAO1D7SBLTbE=R(@K(:XC7W7Ufc?=8cCO+
4V&IN1FZLY>CcWKCc:N)d1aIOa&@-F]56H6fJ?Hf=KX9-OZ?L-cJeSZ,b4>C4/I0
Y/KO:G_Hf/#2V,\)4T7C9b1#9aTF6RQ3I5=>;eRc79:abS/.RUOQV:d,W/:\8KMg
QD^W&QGKf==+;1Q+>M_C?Y-)UU,MfgbK0MbX=H:,A(N1f.K114.[34Id[L[M:-J9
f+aBUUES/C=,)5NCcX>5EFTC_D<8GI=VNF76]SQF/D&.N4dBJ_UW?I475bd0HQ=g
DU6#2\@Sd;LT#>Z.W)(;(=S>321&9KAN^]O7XU&#,>-O+N):NPT/<_8gd\X5/A.#
)W.Sd8]?BJ1,/^H2b]HLEY7eL60E9<P9C-KfW=J@>XTJbQ&+V^R2Y/]30N,S7/fT
)eYC8Z#QDT+0gA<NaRfNe4VD,;8K>35S++d#).<K(/V;14L6g+,>V>e/d04=aF_I
L-b)ZR5b[_5<8:#TNN,Tfc#YUD(&)MW?Wb-RHecgc@<4\aB_-_-3c;Y&WZP>ZFZW
DZc:dW(1VCMfYF\P?M,SHaD4dQCM:)^BKN,G\8e,XE2G#?_W9aB>DF]/CPb1ES8&
4T_S:9IEb,F+^CG)Mf00S\F2fM/1.TMXPS6P5J,+1]]]5Pb\46dd;)+d?-2Ige.E
XU5?,#30K75[GJ&Sb<6>.d;?&@A#L37G:,G<4F(V_aS-+;gRGaC#IUN0TX@17c18
1:PgB<YUI=0&)AO6#:[<0.H+=ZE,]6J.&+Xde->8YF0MTENd58ZbM[9deIeKAcQU
>0/SX>&,0-5O&VLg=/B##X.YQQFLE3Q]-<&8R5B@WE,:2UCA_f_@A]E18DCTe09C
&K\BZ5=Z.Xc@-a_eL4<@=H4:@_8+>QBcWCX40^MDdccS?<+&d9,L)ce7>eVS^U>a
-9W](=OdC[TK7A.Q<H3He<S7H,@8@M&L9Q_NQE.+TPJO[HX?R&aC-eDgXA+J-^40
/LY8)].D(<7GHTNLd=XH/B,b8U9c6Ogf57=EKI>1Yc&Qd;)7P^([RBF.YI8JHD4I
<Ad(KZ/=I/199\f0CaPWNBb1VFA7a/@EI3O^;S)H>=#MT21+@^N_:==U78(ESELQ
BN#e1b-DA6[C[Z3YfLZ]8a#fLHR1X=UL?4#JAN_@^#P+Y+=K1?&PCB37,MG\RRCM
-))#-ZLA3J\dDGb46F]g#3XV;D17)Y0gU#EKY]OD[PQ>)_EK6a@]8T[C+AdTDF2^
B@4UXHF3.abUN@.)C^:0aYNQ05;A1[]64S)R\dX<+QHRgRQ0MB-FPON^a.XfGDEQ
\>Db3JT60\VF[2KW)X46JbV,^B+4BfCd^RVXW+[ZaHe(?#W&YS6.>VBbO@Cf6JLA
MUMBRQ34]bPCTI@?IV;@a7-Z?ER-0WSRd^THM828=B>7(_YS;=3B]):S+[OQ/g(9
M6T/7);bK_IM=E9]1JX^b<]AcTNDH,C9(VR9f,(4bFHC.b8C-G3[BU\4dfLg2H/B
Dg@KH2=5<--ZN[E]@<I42=]G0&b?O4[2fUcUVY[X[0BK+1HdNWOXP1V_MXFeE-1H
]GC0F?\9OD.NLCQ,fZL.^(R&\7XY8eK(M]\3@8>MA,R^]H#F1(^3J/QKg@,U@(Z:
Y=E<;CB4<GeRV-,G#g6C\4Ae(<<-(,&.MObSO0@&NYIc1TQJ)Y:cd43cCg@^2?TK
C]98dZZ=^bOCZCV(-89+G;B^_&Q68TRHSTC,E@U))b]^>bgDU+8X;X#=73?)?(:K
,2YUg?GQgH7L+PV:DRY2&?.=MH<CI+^^:>e-aN9bD<VK7&V,M-](b[752a4,8b1@
XLE8YL7OE-PG[Q0+fOXbQ((WHKPGN][;^F+GS&[SO3-UDX^Yb7fII_6:#1\c[V&O
@_8Ac5CF2JKEM#-5-45g,:5HffYe5)F>gPQ.A?./H3;LDS(9K#.=+A&T=PP,]agL
e#[8[<g5?_3R&;a9U@E0MaT=<FA6_F-ZQ8#FODC(L/EOZNS<MM/FN1)F9?ZM\,]I
MJF1gS7T8Lc;M,/=?1VUL^2H2;g7cg6MF053U6;_c]R.]Q(&/LS]RIZE;-P@Y4W/
9O55J=>bb+N0^c)(E=EVT@.ca/VHF;=KX^N505FP<#6.(;\7P5+ST.U&R=&T,^K\
/daB^;X]Te7Y[4ZF-U4[+5EY])fOI2-4E@ENO/3@aZ30c+C1/E;W3K:g1=DXJFO&
()FEeRZG?5Od[__E;V_+/@^a0?L0&K-U66^e/?8eS^eJLP6)=FSL#UD7[M=4N/+2
Q/,_<GA+EJ=f_R[bRQ/[2/aHF?@H.fa07EWb-M=5gSYe69;UgKNOKDaZ_()TAF=4
A;-\.UC)-_0FM/]6,\;FM_2B1Z=fV,bWdOJR]g_,QQdbO@JCBBc7<TZ71Q90IRZ3
:a<0+[\Yaa8M>=KAgU_4;DT?SLC^X^H,6XD)Se4CJ=HJ^K@DLU]_Y4cKC-O;;CU^
:Bc=07V/C#L5a@ME&+[L3#c.d&-g#KeQc)UN_>G-N6g]AE6Q84S/S@17&O4U[C+O
L525FbGPQ^4Z_@#?(]_O3::G<Y@9KW^3Y1:KO7;db^1b7)QEHT7XBL&()@V8;E#G
MeD2:bA-\YXDE(4R?;Adc&5c(EEcT@O#D\77W_/2X4f4B/IDL<]&K)SO60=^9g^I
&//af7bQD<L[b.MAT6OE@Z72C8,9,6_aa@>+1(f#gN:Qd+@4LH=9?&@A;QBQZOKf
4d:?9J#U.Q-1F+E2IQfV<2M(R:1PW?(EeO[=4.[;SU<()UZ:?R47ZP]fEB(e:A63
^^-4]PZ13WWd]C^4LBRM:9RH(&Wd:(6.@PD6F;CeSP4D9C<Nb:HefIE5)QEf/C-V
1fY]Z))L.E8PN7ONJ&)>^U2_Se/>:@BJE[[LV7d=GI[(a[g]5,=fA&/Of1(1VT9,
@76TeWI^6;6DaTC1BfX=KfBNZ>791I0+DG8@C;Ra2UMMQ#b.;bMaB(;<H^&RP3H]
/ZfV[1C?FbOFB<IeLL[YU[V6MQ@1?Wd]:V_?e41D2V&8I4\Z.J<HgE/TR0e1IPHR
Ha[2c-^cd)b-We-\FGEK20AX;g3GfD#MI82)OOJ8U6a4N2S?d+QL?8]BaZb<F_02
1?Z,QK75GHZ=^<^AZC_XVE+d?QJ@SFV&D+.ESeFAW#\gY=7?Nff5Q=_]9WYa6.#5
<=9+]Y7/?X9^:)#9.E#<EI_?cTH7fL&3.58MKY5FNY3R732FT2FW4[/2KN>(M^=a
:8e/0(RN#L>_18fQb.+JYX6CQN^VHgDAXS+1_8?P,J0?-78aWS<KW:XeD::@28TI
&T+Z02W7PdHJCP/GL7N19f;Jd]&8JEM+A8:P0LOA:IQ1R\7-9^gCc4M@1NJAc_.F
T)f:?fU[]MIM)b?\V>aBDL9BGG1gRdJEQ:&MZ085XMHB<96#gX^SR,NI\R=D=GOJ
g_(99M1+@1L(^B6YNDcX(4^eA-^.?HRO9]@46GRM5H6;5P&WTX[gS,PNEQcRVMed
f;77EKB>1O3+b&Ng[J.>O+U+M\T0/Z]4LUa;f_+7(H6?fG3;UYK+HKe78:&I97J&
214P):0@4+5.?gAMB7:(\(Q49EYLM>HTF]A?H1OP_C3QCE5@WdcC66(T5AW8^Y[/
_=AX@T2Ie#Yd,()D+6)?]H_F/;+3NW9+7fM31fXb@GI6_E)O:)A0.X.H<@]g(&C<
0\V4d(DO.>-c-9b[K,FZ\597KUgVB&\\[VadZHVHS-^)0)2XI.23d[e;@>@3e5GO
_/PZPUT@56G,&6?\/4QNZ3.e+&KadE-E;aJOY<NV<F\afMMVGTf4T+#O#@D)LfO(
R[;)?#D\H?e<=^O37L<05GTK6[AMMR)_KP;,)&@S#783(#IDJ3dM4gb;#bWc//&O
6KBM(17-X.63U@?TcQg9AQ>dGWF^aC>V#W21/,dHd+BC2ZCVVJZ\B-TB=(DdJPgR
a9)AU&YbV)<G3#IH^P0de5N?D)1K)C1eKXVb//NcZPW8bbI<d1NB>?NB-U[)a:Ga
+=AbM;XRZ&CDBUXO@I^Vf]d9Wc:-IKc/\dZ:@Y,A;SNJJ#=I.UV6_I5LI&4\Jdf(
e-&fQS:9]:XZ\)V6e.SX#B<c@[D@VaTT@@W-V,?9OJF6Se>,W+Tg^MSP5T6)9@d_
+GUZd83KUW<Y>92]P.=Seg;Q6IBAcS_=,EN1DW;#P^:(/PLX-@KPQ<f<M5O?aJLd
TdVQ_D<5R1E[4gU..DggE@0XfL[.U1^:):LG5BCIcK[0CCXBO;/RDQT+Q;[8A_F=
2::((TKJeC-L<Qc<EcfG=\SCd\+M/3O9:(fJe:-ZF].=6Kdd1\ddEDbcD9P]\be&
Q]&]g>02.NBXcLS5Y[H;BMfK+6a:-<.<<\P.Y)X7?fKg&RfEZ5a#]F=.&V8g3GWe
/IbZ@ZISZg&W_[e3W(Aa#E0G[AE&(?56)\L\B_SBJF&Y1Be6NTHG\9dTT)[A(;D]
\aE,CN[Y<4T[B/&->_2a&LAKH=]RJX.gYU&;;P#72&3.;UE;#5f,McF=V1K-&F>:
:D@CY->@I@8HB(#W@.eAI[Z027HHG+CCXgaI[=MbR,=U4\E];)G+\Id^b[E44&_4
K]LTbUX4ReaFB<OQe0S.+I<YE&e2,=IN?H:]T9KQ0RLf[/+feY1;KK]JGg#cSN^Q
M^ebFg:dN,,<)ZSE]6BR[)0D83:QVL)-EgVGF+Z6ec7fKI1Y\:_YN+C]f+c6CHNO
#gOfI5Z?XeQOEP<MJVcaQS/e4__>QJV1X[,,8Pc:ZDe;1<=Mf9g:SOB/d,_DI6d?
#8V(UK\]WMX9KeL=0LJdM,8#b\aBg8P8O4/6gTT^^.3&^EYXJ,W_ERG<4b\<N/;8
:a]B9W46AW[QQOf>EFYK:3,4G4&gI3XSV6O\.I.Ybc[..?g=?U1UC5HUegI?Bg^Z
#fBC.K)G]-V/@gfEOWC]b-C24<<?3I2VPI-_@2TV[eM9D;ZS8QQMEPH6=f\EMIf9
5g4eS37BT<-[+)3gE7Z;1OaSFcKXc\9+b2c-\SZ-P6(N0C#(W&D0ZUM/0SSB4g/?
_T,UK9FLC^#9@F2##_8I9:>FYMF8:eMDNO^+Q,++S.;LGf_4G-CJ,2PXGZ#gG:]B
4bMe9B1Da2MKLKd>X]15IDLYRbg4\eI.+#P,Xd?>6&].9(IgB8)d]/)I#C,&U.1K
\f4I_M5LUgQK*$
`endprotected


`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
