//=======================================================================
// COPYRIGHT (C) 2020 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_amba_fifo_rate_control_configuration extends svt_fifo_rate_control_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The dynamic rate in MB/s of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   * This is dynamic because the rate is changed through the simulation
   * based on the contents of the array. Each rate is applied for a period
   * specified in the corresponding index in dynamic_rate_interval
   */
  rand int dynamic_rate[];

  /**
    * The period in ns for which a given value of dynamic_rate must be applied.
    * For example, if the value of dynamic_rate_interval[0] is 1000, the rate
    * as specified in dynamic_rate[0] will be applied for a period of 1000 ns
    */
  real dynamic_rate_interval[];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint amba_fifo_rate_control_valid_ranges {
    dynamic_rate.size() >= 0;
    // TBD
    //dynamic_rate.size() <= `SVT_AMBA_FIFO_MAX_DYNAMIC_RATE_ARRAY_SIZE;
    dynamic_rate.size() <= 32;
    foreach (dynamic_rate[i]){
      dynamic_rate[i] >= 0;
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_amba_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_amba_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_amba_fifo_rate_control_configuration)
  `svt_data_member_end(svt_amba_fifo_rate_control_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass:svt_amba_fifo_rate_control_configuration


`protected
1cDG^TVbbGW)[b-W+N^]4M;,[+:UJ1]AFW=FT]&FH^M=@/f8CPX-))ADRHf:7=KM
JcD5Y>>LbUJM>GWd5E(JF1P[ICb^0JV;()P-AN9ZdNO:OGY29ZEK6&SVYQbL6[ML
]6XaQaHH0[#Ma?F(\@<N=U/4[M><HO2:VIVb1Gg8=]EQ([]]YMQMN=1Hf)AY.6G+
VQ4Hae8MP&7W0Uff71SK;:-9Q#@5F/YOO+Z2dJfeCY-.VB7b4DaBRIZg5E-2IbD.
4D#9b&8f,ga.FT/UM12+.,-H1L6B#@\XDX:,,3cQG]A92=V4V=1f#]_X[ea1CaMF
E66;_(cS8)+,W:\bLdBb:XRg+A;(0@a4Ba]1VY4M&@[/C@/EYa+T9>9,G&WEb9NH
XV2B>GO\UDe3d.e?bZPAI9)0:U8V2Fd9U2_@HRNOIE533(^+a9;>S97bLIWT&;]W
.XSRg>@7cD,<U.4+/.d6JN.d-KQ11N:#:()&]1gT<L>[a]a2H1#Weg]9f2g6Z(1&
eQA9UF.,?2);4)NY^..^0J=2:RL&V(W.R]Pg\B:>5@/_JgLK1;@KK/<Ze8c35XSB
@[=\;B=_e]?-:adPaA0=O9eN^NME&HcGDF94EAa@T=-A1LeY^/\cQ0IF;@KU.3?B
16Z,7<=MNF(He9Yc2W+aP0L#5877YK1^)P&#X7/WX-UVZ[Lg91=YaLIFJ$
`endprotected


//svt_vcs_lic_vip_protect
`protected
7A\M&T5RP\\)-c;&AA0J7D)P4cY/R;JGeV)E-)>)\MADSGW[J#V<4(3,B/K4IQf6
XF3g6@e@1E@>A8_MCa680PWT(Y6QcQL=MdWS_\:@,&f#3.<=Rb\CX)RW[XE_1Q7E
gH.9(PcM]RZ[Q?Id]#_UbGPFB:MeP5>@[8TMg:F2#Q^TbP:TY[V/XQH1H5GaagR&
KYC&B<7bQ?707C-3BC9]3cZ2LPbIUR.&Gc[1.I]:.feJKf)F3P1ZK-[9V=YS4EBW
@+-.X>_K]GB<CBQ-#6:c)UgZ,a\GTG#CG#CL2LU&<PD;B<WP;DA605DC47I>7B3Y
6bK[R@6#H:^SXR\IBZMZZ[1U\FQX?5=2)EOgU:A,O\#=5#57\CB-Z9:NJPL-NK+<
VGVR1SY7VJM)Q4(F,]6O,1=.VMOIBMT#4;LW<a:)1_X=g;#)Ia>:Na(N;^Y_GZ(,
S3CMa?40-0+O3K.G4:B+IF?K5<f[S:4XbII7S(@=)<OgR5AP9T[8D]B>(AH5H^&,
K#99J9#QO0=bU5.4PHFR[S>Ne^OSP16&1Z]eO_cN6^;ZPQf9LR3M&WUa(35OWWca
PN_b7\gG6Pa]bU?-]fS:DA_R9N\JEe@?aX\^-990:3R;M]ZM5)JM+_22EE>EdY6,
T-B720>H;aOFcLbb.(f&<\<YLW#b9BT>:(7_,M1[fG<]4JL^SACT[>;?-.47L)3@
WeOC70+7&C8eaV;J.dOK/<.FT,1)D=7A^C(M^8FCLPW5ZF5.gG.R/b=F)ca0beMY
a#06eXGN#b@6Y<&WR>/YP5C:[EHCg(T^[?Ae6+[YICEK1a@&,-2[<a<CZ_&>F6&a
6DK3bR?/V7[+cWHJKLTPG,AfbVGK=6SP@VeP?,MQ3?EbIJ<>2;-)4Z,@=R@4(9eZ
RX>:?EUHfd\[+XZCQ=52,5+,eF75gIVbNO1<,D9+\KRPD;(G4(eY-SDd:#9G>&RB
;_N94XESO3dFJ3SOA=dbC]T5dY?^gbGZXCa3;Zb&Q9DMH-W=K,[L7L#1>YPGBKH6
bJ:a8a^d<]B[A0X[?CIJR>R4=ENfPN;4D/WE(934>^(9=[LKH\99HPQEMTOBf+/.
f6O0-)/L/<3,=I,O]WN6NbAW6-If/=gY82SOFI_?(6]_.+cC0W(>1S2f_^)VCVW_
-&H7873(D-5U1F=-;BL=#fCSH.a0;,a2,?P-(+b#\8Q>)\eg1#:LH6ER8R23\ZMb
DIL=g=e^/OX<3Y)7]WS/FH=a7M<[Y#6D=Wa5bc)/.e,8_cYVF/OW&]L.e7;KH7#R
\9g]37bO9V;Bf_TK[DgTL;TY4<)9YP#Y(afT)Se23a+T,VdS<-^2d5+>ZTYR0&1I
R31[OI,&_D;G_Q5/ZJ?TDQV95g4XOOZ+,M:_eHN&C.8[fYe/O/b0/,P>U\gUfGSA
9<+D^9UHG@TI2:]-VZ(C\4<K\^A]9ZRPZO\PeEGR:AI]_RaPGLTSB[5a(,?&8O1a
WdP)PeP(8R2?WO:R?II]WO3fa2(](dg<]2:M_6F=Y]-a[#+S;>2X4KHP?YB86T@.
YVfD.C--8YPF1MBE;U@^&HbN,Y&2WM236a=3H0,=EH=d@UCUZM,bc.L8@_L79A.H
6[6R+)S;XcP.QL:1,E\J6PHLXJ6_K8]PZNMN9E#Cb]_KL-[c_??2(=+e467J\g8g
aSW@=/@,\9Y860W,@6VZ8\GDFJOd4d+fS-fZV\Re^\Y\NDf+AA4=N0)L5SK<+)3@
K-8b)RF9\O6P>VLQd@(D,?/fb>5gE^84A?@7M_FHg<[EP[&IfE\Og>X\gDe<BSM4
=YC+0(,&YO1]W>KUQ+7b4?H\QD=2I78bT7RW=]IV>(A9TC34NU\PWWFOSEU=F[@6
VRHO60f)CMeL,^4BcFAUabg?16V<MWFgD[>HJfecSY2\XT7<5<&@1[8OYK(1HBPY
1H]S0G_F[K-J19KXB7X3b?:g[]cD>.^M6SO(YWHeFWd2C]?3Xe5[BM3L7&I,O9?#
Rf<+J(^ZI<-GR=DH1)6](=;E;=Hd3.[RG2(+,>O>+^T3Y7?+/[PY+J&B<S0bB1WH
Y^J]E[W_KG-\8EEPb4\,_-^]/5X4S6)1DTfO<g[&_.0@DNBfRGd1X@cd0f=(X//T
7-@)ccS.^0>C=_/?M1NKgFSE)[K&QS@MW;=fQ5R-8g=c,3#HK?LIK\F&SR])AFN.
OW&Qg:?f/RZB7K@K)<&#H](f.+6dKTPTe1FUUe?\;>c6BI^#M6YCU+0Ze-DL>M=I
J=XCLVJ&/BfSH8O:<-W9,4&N3L(MO&&+I1W?[^4]FR+?[;eDIDZ-cL[Pd6OC4HIB
H\#]WE=UTCYO?&\WLL=1J4);X,OK1OI_IAK)f1@g1;NZVV.Y+FM:c\IT6ggb:6[=
E&=6:=Lg32OX,5.O.7#9&S;\BHCb=-\J=,?8^>WcOY;+Ib?S5C\7KRRVVT:+:.(U
@K?4XgY9)1/5BXC284?b_P2R>ZTDd=)T58@,90b0>POL22PR],AQ_2,eSO>.AY\7
/8Y2_<7I&bE1O>TMXbCIZ<?EB7WB5Ae(_CR05f+80,U3IgYN^=DHeTVZYIC2/H3f
A#V#EC>13=&AQM]N^U,VNHTe\D3@aWd\H9^TP=GF67(5]N3^U87@T:e?(KQZQF2T
f.BgI0H<]=</BE#R_K;W,JD5GZJ)/g(:A4^RR>E^RFb70DH&LG^(a08e.]QSX+5,
Q3-TY#(2(YKY?9P@,^2ef8L/RO,b?S+IGW>B0L_L;J3XN:7_J34[_b6.Za@f5P4^
2Q]PW0e3[6ZaHOJVZNL^1U4Cb^0F^IQK<D>#GY.3IDe4P;XCEURDHd-X^[3RLCU;
_A+4A8DPO&GWZOZC2-b2:I>5Xg(UfW^G9,BKCLWcXe^SOLe&Z/#fS]3faU8@\cHH
6OI>O,d-e]1c1_fQ^>H@/H#(\EE8:>9gR@HS\e&VDRS346?#4I(^B=5E^<7PXJK+
eRffH^CDZ)/PfJZFII0-^;^e\V,7PUR6ZR:@J4_Gc:Z)[7W8eaOFPO&W7:O_0UTX
2</4?BOO5=<1cY+T70aAN?>bE<1RJ1IIGeMXHc3-7f^^#1DXF+)Y,)QII4=&^KT_
X\cFMAgN;J0L2U?O=aOL^J#ecMd634,V)_>Ge4;eM4N\4:5E>=4-V8W,QYV?IVS0
a+1-83bTeb.^^SbL/G-(fSJQ;:gM[e<+^61?fb9d^UTIf2)Ld)Be2Y>eA>U95Y@A
(<GUIc^E480B?)b)[/<@<4ed@dA;/H\444dWb9..>f9B<#23ARK[M)N3G>4)S8T]
4GbJNMX2>E=<610CLAO=L+//QNE+N4.T_7MNN6G9FWWG7b]79bc5CG]Q/]/((CbX
)U=JW1a(9TU,7e[T;W7\<A_e-#,S4V05SUF5O0+[QXK3U>0KB1-68&7IgV/@I1L2
I\c#1d7\)GP2X252N((N.Ue^M_;L@R_eI?]9=@c-/[H08.a>c;E&7;[#7VQBYQ5Z
:QK-QWAV=;bJ8EZ@DGIKeVR@[/Q04X)D9f5<b#SJ[U@A>U?1<<[MFQ(M.GVW^8H:
JKN866>QQ0(VQWe/1+W2:3OJ2J[)>g@D1(9g\,ELcV_-3+O[GcAB?MQZ+)^Z))Re
f6CSg++\9=X2.5[Ub;)J)@\8JTC+=;KL4Q<MQ<W#Ygd:T1Ad^<R&02a,MFeaGUVJ
PVb>L/TU>bY/P<fg/N(Z^^-#]5(QYg2bf]LS_TO&afL3,?eK0+Q=eX9.3gD8PYcA
.<PLd0\@>.EZ+WAU9/d,=/>4JPFYF60@cJO8L,=>JVZF<J,@P<J&6<b.Z?7.HG)O
3@NU4T&:\W,>aS<P8>-f#H/bgE^:C.^-Vd.:+@Fg)3BdYP@SH[Q]5NIEI]Q,.ZS7
A9Z.FO9a.,Z)fHa(LRZCCd1E/+9)]XZddENT3,-M&[ZFYD[JV<Ig6(M99+^1B.Be
[@-D<-S8KLU3)1NWA+.H<3(-P8(f;61E8:c3T^@O3c[Ce7;VTD<4>FB4Y&^3cN0P
UFQI&<=_J9I6?/;LE)SPC;Y410KEU=H2YW4:)QRgaaf(cMASg:MK\A@0HE=(#GB<
E)UH[D(,WK?6^9-D#)3S:&+,BQN;+:<18SHWI:_eT7gAE&K?)V#e0Ed30X)aX,F<
[IdUWNe-3@5R]U=C]d2H,,P<>]G5R@T&J:eAAfc+#I22N]PTdP<?95)RR?Z^/7&f
_DPF4Y4QQT?;PA7+g+1EH8(A[,@DOH:<aHM#G1I12gS+Q#?&^Z+JMD/Td<9V1RXF
f:dH&<B[BY=/Nb=2=?7V>DgB5^1;K<F@a(dKIN1a/B#.4ee0(S:H7_JEJFL=)c.B
/aA:RR2]E=\W,91cd31&;g@:-)gHQagVJC\=F4b&F\5@CWC(YT?5\<AX[U60UK#b
a]/>0_3=F)./EdcaLXddX;G.4:PQO2_:L&@(1X8EN@9(LK,f#TJ=SC\)ANf9:>=.
ZY0/PJ?Y1HT4=A-[]6><H:_Y?#PW:-+G^IW1eEX&QRDD@9EaRMUe/Q5#<=[)5)G\
)SO3cdXYR+@&I,>1[XE6,[g(d]RUe3#/KP&-3b0C8AdY7PF)<L:K-&0G.DaNeK@G
(F518A/Cb.NZ4,:K+2eR]D,fRUUINAQ#+,R)b]RFVK_H1?O+?KP_IP6]VJV5\JU-
?F^D[efKMQ?O:\3]<DHG)W@gcY)\_[D_SF>dQOE<QD&WM6e[]E8;HfI-;3(-9[^E
[J#>Nb8bc#86(WTYIW=W62;LR(^D_8B&?V:MfW&d(B7?)^1F3c7Z0.V<O.H=47WH
TK;6f-CQ3()f8=#.XD(+W#?a05.gQ0bQLKOCQTc#K::)cW:=e6;Q/T6IMT>SVd()
V/FQb:eIA-/_H:/O([daJe@P\g=8@2FMcUAEI(5+J8g&K6F\DDIYbc7EODJO?YK3
-L3_AQL[<.J=..J()VN:cB^2;b-4f,HeOdGb(]FLX)2DZFT\+THT()CAB(7=SE#L
2=IZ_O;GS(GdP9/RINBAJO1KFd4T#-d.Ac(Ee<M([_-?:0K6&3YC\6U:55W.\,He
:-;TZ.JdI2AJG.R1]19O<JXPG-QT^Rb],EK2.W+\;,>g558H4[gO^7XM)FJPF?9(
>A17([.C0OJAfgZD.1>Z2:J1bd+DXVF;7Vb,(\&]&+UBMKFOBIPAX\?YUNL_LJD,
BBVeGO][,6W+?aO?Vab1T\U#9aT>W>Zg7>&R=T]NLgZDd^Q+@&##+_MM.1M(DgE<
gE+7MgVZe3bSQS=6+&\eY@(d]N@Y7)A0eOFbWC@QLV<;@NZQ&6.-)J54)&QYf/8V
c</.&S\E]YK.H]L?#,:X_/M2f3?MSO->A#Ff6.(.1?(g0XbBLa5@.Y67^@<585?8
9Z-;)O#GEaAd9f+=QbU_(4H)HELMMX^#7c[IHLT:gJ8R5?e95@]1]KTBK(YV@^a-
4=@?HU,JC3g=8ML:bHLE^#>[fgUebLZf8VIS=CS24-8NP9GLZC9:f54;/HWWO9aQ
CNg=.EY5Q(Z)(PCLG5/(dd-JS3N&<KP#S)N]L^bSc,EHfM3AWDL_/RQY/R5HGJa,
AWg<8Y32F&Q)VW[#_Y]ZQ\d[-G8UREffQOR;Q.SXa>V356Me4gDM=1_F,0].,](K
8Z>>#c9Y=#9^1T#FR[R5;NQc;;X0c,.E>PFATVC[L1[@/1M@fg@F0Y0[^O:A?/a^
U@CWPKT2OX765^Z>A>C:R9d-6,5ZLg&P<KBMQH8@6e[.3?@9,V_9b_^UMGbE-BDT
A>8>a)(\;3V/cTbT/ge->aS8GKcf[E8YH#Q1T]6V52I3eMM/#>8[T-MX4eQYaIK<
GWY[L#(Z.AJ)]5Y#QV_c\>:[WSAO5+J:@gbE&T&5\Td1L:UAKV;FO\bZ:H;dNT4&
baKKPV^:[]#E4@@X^?P&_)0@1;^2e0N4I;Z<D;+,<a6W_MS_GWZY.C1,\0&&eaCJ
,KcJaJ(_0C;fIZ00X;+^/PM\F?GWT.>D/ZLQEcUa6MR)R4XS:d66&Xb5-N#JbU?a
[cJGD?R-\H=]ZE;HfH(D&O[.Q:AV#,3,ZT?1N6-eTL#O/O1;]6QbHT^IQ7>CT4FS
)0/:H]ae9(=5DT8=UC#JdJN#GBf\=2YGa42Y6J-fL7L4Mg[bCR6F51^f(]-,_,aB
.,N)cgLaY;R[,:N70-SDXbA^8;3T;7e#&Fc4aN4ZVYf5:,?X?.4eEfa#\cP1&6FV
XRKNd,_&:dT<5I?9[>?gY[#B>8FK&5-E_1@]02Z&Sb&#(^>7gNec29fT(^I,X;0?
BW(IDD2?AP+Q9?dLM3;aNgO7N-)a+N6dD69RaCcP)8A)^)9\3HIeSLI7C3+FFKaJ
d?-JD8eKI5=-K,V/+5O[DZ0[8??D#cS5)DIJP).@caIg?O17RX7J5@>;NSMQ<&H&
?a?:G+C(&-@c(EdX\:eLRb/\>29,VNNEJc1;J[ML1&]=eZN3W57@I&&\AI?^-QI_
VS[7FP2=X5,\),B46;KD2?F\WYWdKC.35EXY_Y^]@_C.8d:?B-C>c?941FNCYHL/
WQWe0:8e-(,V+HcGTf-_ENQ^7=2d&gU(bS[P@K@;0#4eLE-#A2@S#DYX680KJ&?,
+(TF:[e9B+JSc_;8(8<E<9\YC_+(QV@@_dD8bS8N0N^dUTFULY#c=aW4BS32:T;;
Z>cNE^?WeD40[W7E,JH^5?;_>\>aCf<D&11AM3g6&>>=ZGY^FbaSK^G&RP;MU9G]
<YFY4^I;ACg2e1VVGHT2JPMOKN1#3J3ReXN^)S<(6bO>QMR4-CcC46;5Mg,9He;X
P+]_cGUZK+HW4GD]:<5_;.2D4H^X6D=J/g#S\L<&XG#&(c^HO&F#d08&0d?3J<SR
=V#)]UK36GeP(5HRU[I2NYL@6bU:@:XABZ]L[VF4<JD+(.M,12\L1IYe7V]_5:8\
1Z>:F648L^I;+M-F+UXZQ&L7&:>&18L5Z^XAEe0gNBg+?>W&53UDg\P<5&2KZ[J\
B;d8>K68EA:3^UX\gP[cF5:WB\VVI3&Rf#0WR,6;TNIL]857XS8,#-Q?a9fI:+1\
_4;f.-PZL6RAHNQH&<-#.aOD>6H40PK79e)100?]ST&Ib(a@8A&04.4aYX.:Q-2F
L#Y+>,QRQ=PcHXeT(+S:SCTL0fcP,A(d=)?]S:e#Q=1@G/8Za?Ug[Q\,:dD(NgfP
[];;CE0F#Q&8EE,62[(JOLRK:>4cX][H@\3dLbA]TWW_^fXAaVL/;;P>JUA:=?ZO
X(?:W:b2f37NJc8S^98bC)4Yd;,H46Z,#PK(RVbAf)VUKa(_#9C0K4:Q0?Y.VM(9
Z[2N<15]S26eQJJ0:+:8gE<aR<BH\XNAXG#TAQ2WVOW-^S3H:Ua<8@OFVBR,R3BY
SHcNLU]=6f41<M(45cP\+/UOL>0KHVfC,EY53B+<L6299S08BUBZ?M[7U,AK^R1_
C7C6cdO.3?M(.7f[@A10U8U0MHP,dYN&RZ:G@ID+Eg]#6WA=MW#&<2=O;ADV.6F?
9&6^a13PIE+WH>WGKW#&7,/-525AfQJ#3aGg(,7Y:U?=/U_8K8:I61V_+7N,>P1;
5NWg#;,22dC=YF5VBEJ+945;5_V]@f9+M8>G?_<A=A8bDF+,Tc,[I^.g++]Z,KI<
J4B.R4F]4O[\S(\5A=<>C<@Dd<&?G_L,4ZYB]dKbA4(QPJZ,GK@CJ\a(Bg1]@GB&
E7#>Q5R?d5N2.L<0I,:GCd0LL)->E_DD+^Md8^V=<@](JY>0+d?b]/4;BRD<[Ue^
S:[>cPfMU3B>/M4GTN=Ug[&@H@8fHfZVS]SX:4<AYEEFPdBS_Qgf607IS66]UWa<
SZF.[)?_a+fJ6;U7[Y\3OI(Oa_H2)-H(ScK@BY);\S]=]ea;729QORWa])c7DE(Q
=/<eDDdS9e)L?&,HT)3YWL98M@X?J<Ke_?AQ<25L1A)bUZd;9BTceIMJ)B3N03GY
:]91XFOaF&B5:PEKd,?eP/Y#?X^fKI,[#-OU^@a[#[e:f(N#&PC?AJI/fT=L_V_<
M@&5VXBG/J8\-0N74X[,S]Gb<98K^D2GaRgBB6SKIX&F)Y]BVbZF(Ca(LYOXc<R3
-?#_,+R-\QE?>2[PTSe1aO\<-?\06&3Yd@4Ib(b8?RDXCMd2ddX3a8&@7CbS@8WT
_]U05aV+YEAM(Z854M_BZ&0b]?:6b,>X3Q2#M>0dQGMFdA4gGKW#07>1&e,QHC9Z
7M\_Q;(I,-gKaFc.&S-LCfBR:CKC#FD5-Za&W,P6V?c(7UP^R+gDXCFJ[@AY]BcQ
SR1[e.+?URBU44Ja3,U027B;&8EO;W_K-1@2+f=3LSIMGPa+:N?&J4(G,;KT;Q7g
2X)2B>g]?RFB(c_]^WRA)&IeJa\P1a?3DdMWWA@ON,:K\CZ^eK5VBC^+CO6UIANI
2_06F[P;>,?F<RDQfP[:7Z)=+KBKNcUB=7ZM+FF/)O\,W.KD^D4]50&1X7=:I0<,
Y@gGd<[g5U<KM15BMa^L<)W64=9XAYBd5^E75d]&+@O0.E;VaX[9bL[V_8L,f<D:
Z/b38EUFS1PY.Lb=U0D#9IAB-bSOA53D/2H/P\VX&C.PN/\1?]L@g?XZGXJCL8A4
X/P#&V@Og@GN)Wf6;5Reb<-eNCe_](g:#RLQ[>^M+e_eCH>WV)Y6cFTH7/J=@ROS
??GV).<N]>:OU:5FAcMEfA<[DD^e+B;@16N>\O.c@QaRNU(EPTgD>N:[Y9,6B9Z6
&dU9<</&EE_.c8O3M1(5;)4-R_-EJf\XB\&;@O.8L>G&E8a;KN[=LRD7e>3N9C)#
\/:JYO_,)gVO0\-D_,0C>eCE^6@T)3\\fe\Q&K-YL;(ILf_3BV1,7>H2cWO06QI6
M9(GP;G<[P>_SA(E-VJg1P+)RgAVaM;T<D3)DTf&Q7e0aG4TdcIa52UbI[LT@2aY
V57KI;7B9b@g6EW(cVgYJJ1-/,Zb,?fccdQaT3bX]b[FgH<:6:;5SCYfPa)49YR^
,1,VA?ANQQ_3_NH&:SSb(d7AEeE[U.F#ZHOO)QVbeXV-R&VIPQb^A9MC&?QVfcPM
X1O)/897g@8LR,KbeAB(.(Z3_LP+2HWV@]/M;W[3O^N?S9FTHF@/,U1RJ7gNF2.A
FCAJ^bQ4M@E=OHB:NK/Z4K^_.HBReW,YVDb>.CB2:7EcfX@O@RITPV0F)V+4G@W/
:1f.]ZgIaU_)#MK363MVN[8(RW;Y:KLg+CWLTRA.S<]W[>;B8P.ZW^,c3Z8\I&TH
N;,KVOFDS)_^T/)ZVT1^?C[bWd985cB+0C>+.5R/B2LO8[ZQH6g,;UMD<LMF4ZJV
E5?0<?ZM))bY8Zc/(WE<7W];F+9I@5@6:EXbP@<,GM5:@BAYb(fM2f>\UMRadI<#
@c/d;+=deACB[#5dL]8Z@/&Mg1FILfE,a3eEIV=b]f-Z83ga&bX]&bG(b3KS_gba
F^=E]PH8Zd1+-YK^&92=R21bA?X<7K+;D7ACP]#SRa8gI6D2Qg2/#WT9AT3GVRY3
PM8#DOa32Q34-bG_-&_497F@bf]=E1Z>N&6WLGb4LJ;.JPKT#T8MffFOH7:PZ2PK
0c5IF(SGMKM4?-dF/=UWDY?7P<^[QA4ZN3\Jf.eObINRB<Bd[_E5a/.7F2Z7YMVA
HI&OQ^c#..PIVU6O)K10A2N9_L6LTTV+5RZ@](30bb^8?)@5D#,+L^?DAUbb4PMP
cKTM^NbEA6HRRLST8GcX[YQ-K]U4,DI?PJ#T9,5?0FQ?MLcW(LWYBK8Z\?L45:QE
-=b#.02:M.W?H/R6b<gMZR#+Y.NEEZD)d29Ha(E.S?+B9bca?IUMIK9IN1[8ZOdD
,-3?Dc42J;N(HU3G.KCSU?geB<a/<;(A_ZZHC)fGD&-^W_)UBNPVRdIG:99#)J[A
0W<64AC=FZ8#Pb1KK#J0/Cfe2S93ad8WE>=W].N4.gUO^8D.)X(\CB]KbS]SG>LE
W]PGZ@c6>^A<R8(BN0bREWeaBNA8MZc4<)5d(4]GJD/Q[VaO/cY.#=&Af<a7[:=U
g2Y#G)a246?DZ4PEN2U\]P\UQ=-B[-cJGc2UgJH/Qc/NO^LQG;1\&9):[:]2L<TD
>KP3CP<<8B7YCT2?a1U&[-(WM9>]-SFNS+97E7:3Xf052#K-CKU-S+I95]f]A^YP
c7TR4THE^-aLJE+9=:N_Q#=UaF/BWO])Y<bQ59)GG&55G0N&(5/NfAg=?4gMUFO<
.^P?BTbK5T24P>>LADb@2(9afJE<aM_bY<OJfD.5,7)W<1)1PZa013+H/J=PZMRP
6F(0NJM)NX#R+8(6I38<C-ONg#-b1N49aCG6X8]ALW&eS@5RF5;?g7:b8W@^RA8Q
gO8S=?3+UXYL6bd?1VEI+NW7VJEd.793M]\/=a<cG0WS;5SR94\7YRI?LS<+7QH.
E?4SS4I[:19a];:]C/3Q+15T:F=[)80Rb>EL0^4acCWfY/3DVH.a,)@\5\\1[FJ=
c7NMN6>ZJ73b5Bg]))_FL>ADc,C2gf^d6@9]1eZY#ZQU:Z.O>6bK+_g#EZdC6&Vg
I-;P/.L?S;^He8CXG3GTE53#C[GO0F5,?0[&0I[XIMGg//,Og3-d45TCAM#W>a7K
<d<(P-_P7EbD==bDJ4.Rd:O8WNNL/dBX2M/>^#U5CG;J93f9CdP8O@5[(-CK55+]
87fIEXJ>Xg4=9F?fQ-2M8ZV3Ig^R:@CHQJd+@)32e7HTB2X+1WX?#9DM9XaAaTL[
e&MCS7?YH9[+[G[WM,(:</99FF<BK_.Ve9J0XAf2J)-gO/JK_.DJWI@A8ZOJ<8SB
e)),K?)_YJb^4#CX88H<>WARHM5O+.L==)39_07O,<0.]D;LKY503=e;&G&G80gP
X=F54XPQEM9<4\,PcF<?Q<[>7&W[dSVCNVL?9/-cEDATKC0SI8E@bB=4K,.fg@aJ
3V_:ZCUeNS=N>g,G5Jc&UCCY+EbG?;2RW\]:-W)0dF;<L,,gG=6>+_Z)QfS<H[&+
BENH;N2:+L0D^@b)4;NO?U2_b.X+]RG)0LHLad7SdZg)f[V4[gD=U=V/@ZM4@d#=
2)A1VSV]IR@YQGaXJY#?eX0XJ=c82HEI5)-SKTQU]_>bc8Q26@4Bf1DV>XaNc,c3
DPLea=BK-WK97f4,gSEP-ZMg>KOPL\<34BG3]UI(N=b@X\673(?/H?UUISK\[&O?
g(\e+VHc,\D#LRR_LSRg.a-FA\fY@PU,JJO@/H1#_[fS]b=5O3Yae(E2g2<HP.J.
1Z9AZ/@(L=,JEFa&]^F?GN.W8(agJS0ZRH2OeB<1;F2cEYM1H]_c4c;0(1]2\a=X
^_O&dP/Z^3:5A>AD)VFe2\(Q[.0QAHX&-AV#.c\+=1L;O?H60:HODP>ae=T&-W;Z
T)E0]e+2(H_=CB>HbMBD8/cQ0gU>QPf\#9]K=^OcgIR+QZ6^4F#2N<#U+E#,FC2R
3cd\E6Gg_9]:U-6##(<7/Q#7#YBbO1)E(;NLRLN+E,TEE/AK]<D<5OKW@.1e:ST\
@XSd@RB\CW0,/3H(>8B>2<BTS,T6e>.d__FU(.7^8T8?TBH_E.QF>-eVf/)/e[9&
#.X.+Y[M56AVD1RW3O+>M+9c_ICT__F<2(D@4,W_da1b7TXQ;PF_2AJ=Z_OWZ^EW
bDd#Lg&c8O4EPA&M9&N3>eST1<@8?P7cE)R6B<UD4UEF@_fgR6.d2T4MfE2Q^S&[
=DJV,9.:B^ILG,&e?61a?>,R1I;0O3/Z[5\bGVTAB)SEGQ(bRX<H2H=FXMD7S+d-
(_:fWgMUQ(5&0K=2X1S:#R_b5HR66BOX4OX1OJ^=U>-WA@d=0?9KK=H6W,9KQ^I&
MNeY51g+^.N2+aTW>7+K_[.?)QE+M5IH(VM-CgF(WfA\8<+T)H2Y8P^JA4,)^;VE
,A+FOT>0A3/P7N_FdORZRWYI^IYIbCK\A;.KK4f;4PU+TWdCV/6T;N=)60G7ef0+
(:>7LILD_OJ[3^1_<O7#,IKWF:gE9gaIf7B(ggSEO/QA^.1^:a=\d+eVGW,(9dOE
M([5841[L,e6;2?Mc0\LQD?C0FZX]cXg0Ya5ZTWVd@J3C^bJ)9/dCVB-Q5(f5[eX
&d5Q,2V7?9ZPOMR4J4KD5]914S]+W@D(5NaO#/PAJ<?B[>P;RF0VC@;K\[[Oe>[C
8.3D@A4@@c4=@.BJ5;1;K6.Xb4+=4aXEWG[.6b3ae5O5XM1>?.<(M&SST#Q6e_]X
/P_+Md35W3<4(2^MBFdTA#(SXA7,I&fHO6&HY7I<Z7/&3;A(AK6K[079E;5GPS<d
^KV+.c1]LM8?c>H>bGAf_M@YAD66+Sc2ZOH,UeE7NC3:_?OX8QP+PBK4.19AF+/H
<#Te]NQB)Qa)cS@,&.SeXRcIV&ccF:SO5?HMXTW&45cO>dX&/XfX?K;?:bCNO3A8
W8-^2[4Ye=;A/AJM?_fdTXc6868=Ha^7WB+]/MB.C96[b_6HZ;ZKO3C9_#FMS_4Z
+EEX?D6Ib]&^3[YT_UBF9_E+#4IB8>P2A98aI1Z^V?C#A]]8^_CWVC^^LM?V8YGJ
.CP.>>F;5Df7RRg_E:;,1dQ1U@dK=<a_MN9=A;JT/8C542<H<g<#>Q;cBWR+_(U)
D[6&3?V4I\a^[3=C31^J@_+LgSD8U]YX:BX).f^,5<86G;Ae?\1;L&N:0UK,C\C@
)^/D#U@8/7SA=8V95^C/1B[=A?9aY)E)D(183UeZ1A55^C/E98<5HB6L4;a\=_//
C:#ZbaDN]/GJ-d@&[46/)[H[X9NH.F1>)U1,&6)RC<HZ,A.GU[U7//aF6\C728D,
B+/S@XK/>4K@#ZSb=a(Ic:[_/[4E3:5R;1B(N6Dcd;WbA@A>7.#X1)eWOL\bY;9^
UQG]E42B]:W0e:,a+WAUCZ1R4U=)TZ>=<=H8U29>&;HZ^5(D_IA[AF?FMR5E]8g+
O\cS<,>I([)M/16IEA&4Fc:)I#/9>b;0T=+63SWd-7YV(dYGMA/G3fW53Y:HIY5_
-?OKg,CGM>E^U667_Xg?c-@BCQU]:)M)AEaT]AK4aMJKLbZ)]+T/DKXA3R8b=RgA
B--G22X/-_-8\JLS&JYOYF7A4+CD#U;IVLIJ_0eAS0W/1LJ@HR@XD2_,;J&2aH=d
1CJW7?gQUID[=5=+OC1A@+DQGRQ/,]HL1EM,(2Kg,HA#0TRAXM1.LDY;S(f1).+:
,e[LX<g-90C&@?X<W9@#3X/EaXMd7</[.2OM1]W,=N9OHE:/A@ZUKF_M>W+66Jc]
IbNL>9)cf)CY-CWge>MXENYg9J7AR)c)LIa^+KM]>:HIA,e];B5=W=Bb<P;KUbPD
H4dT[UAFN9.6D4]V)U:OV+XOAQ0:_ORI#OOK=Md(436]PF^NRcNFHb_/BGE:b^=-
[]=E^5T=?egRSg#IZMD;J2FI0f1/#bD?+&G>L?W+6K],#,+<_6C<?@:a]bT.HN29
I,;><C)T(_/5A-@)d#L7XIM^)c1BdD-B<dL^Xa/6].AT0AeLQS4d4>1;C\A&8Q&?
GGd)TED:S79CD+CJHZT(KALH.G\@1aWbd<<G^W5T4Ac]QXAIKA/]-A2R5\O4\)EU
9\\UDYIO4P8C9^(?GQ?OPU,dMO45KA]WW3--\<V:>(1Nb9@3DIO6;#6ISED6V;ET
JNFcJ?@;,8IDPFe-TA<BP()CM7K6;Xd\1gSPU6B0G9_;?/>P<M:,&3?RYE4I2&dK
GQGZ;J57Z[NSFc^#2NR&Hf+G3B9KZT:4NN\BP=G-X46QXIeVE]6/=,c9C=XW.QQ>
S2=OH6&afY/aEaMTe4TO>TTSSdH)83<QOcDLF\V7b9<AUfLKR7D?>0E0V?:+-LW+
,A5R^5G+M,&<dZT@=^O<-dA(>76<dXH&.A9FA;6>cMG;3/gb(RQ3O^OQ8VYd?.Bc
Led?cL])UMd56]fE_L1F+)H>@]M_K(ZE:Z>O1@C689952@SUOagC,WH5d_W/(WO9
7J+LL4eUP(1Re,&bQSeAV-U+^0./b97S/J66;=)8JWO]@YU3/Acf5<:M5JI0K7.=
?Df.d=2Y-f8K@)V+,FSeLRU,1Y_<LM&F;e51.V<P85=X+(A+gP09>+BfH3]H.DLX
+]X+IHB25[MAgTTJ8A?.)JXgYd-05B.ZJU>M)GD@6_S:;^(eD2_ZYCP4SWVH]FG;
E+=B5b:?O@)b/VVM8^RO4[U-:9EJBCYe<)PB(7TM/]\FCQba_Y#b^6&@4V&FeY3]
&.6B>;/gIZUF/^1]&ba_(#)1IJEENAY?@I4_N@/O,Y/SA)JJ05@/Pb]&()a9G_d\
53ITX_Zdg53e7@86=/-0@J(3f3caY-S?5g??J>2;[XAa2:_&<e81BU6]F+9,@+H^
)_(OE;fZVGWTM4QIY.WK,T)LR7>8=,T:-7_M5K4M]&7^D77-4#1.b51I:5JO@IL?
.Z5eYMH?KN-@A83G^O[55;)abBe<K&K,A#C4^X3;b6N@f>Ec,LE0KZR0OUJb6<[@
0]Z-6DCA&FI?JgO9cC^UA3A.YW+WeNRUeg&,?_Y,F.;fBAXN]VA..R@SF2^5EGb+
IgQNFCcEY@1O66DbHDB]N96OUWScL])[+.:1FTX9^\>B/4@Bf_e3B[M\]_8;YJC,
_&2_c@;=GecR1A6VFfDQIJ(IA^G-?cI^.f?8:=K)]D&6&ad1_V=Ng\FCZ_\H__EW
NU/=14fI,Z9=Q04)4;Z)Q>PTN2=Ba?[O)QK4U.9GZQOOUUe7;:=W7R/:cFG_]^K#
&2YY6dRE=X1JS]WBA_fB\#IVP<XO[^MP&@Ue77IC<.15D9XWE-bC_0A?TE,K1(Jg
\<f&M<LL5_\((LY_,(LILL<S2gPJUZ(BNM-a?^ONM;3,XaD>;^2X)#^[BGG)S[O7
9FeB9IE_\Q\T5E-_LOP+4#0HD]YFaN)I;UM-1X(@C)3O_VEM4O4Fb46D,_g@>^T)
I31d)QXL5IJ1\,>aULGGWMgQ#S77#XNfX?9bAc)#=6bdY37#__WU48b[)K?J-N9O
61FF(YP2[J2bdCO4#WDU>a>E6fc5]9]Z1Cf+C(cM8EOe.N@Bf84.,Bc\:\LD4>Z^
R56Z?+#V\^JXW>ZJF^KTDFA--]/(?VMdgZ>eCBYSWDJ)Q.<IEd4.>_DLC84YKVV.
E?Q+HQB,+^#K;][?JV2=;905D+<:-e[3^=NG:f.)W@DC5=3fGb?:Afc#2R=3&)&K
3YC.^dU</+e\TA>S=9a4C73=/=SQ6:=QdA\.NdT&XcA<VTK3d/DVfa@P)gTd;:N=
838?C]N)3g7d,SH33g+KV7Q^VF/7X1g^c[H1g9W0IcJW/43EFEeOB-T2UE4H2J:+
(>HH3^,gg_QI[87(9bG3/&(I-:4c(?G/#8g05Fb9+fZ-7_)=L_g>aa4V=9df=6L^
E6@dLK5[+O/O&d4]B7VQ\7<Q60_?D0G9APg_\YBFf?]bM(;d=Q7^W52KP;/?Y8eP
ZV_7O>E6<=EO/WM/W0I:_3L;5-8AN8&K(A0AQF5K0HI_5P[9g9b3\5GG>M&@d.\/
e.[_Y,R@IREQUFf(@ZK9C-8[?(,7?^5W8g?Q3=P=e)^(;1HJVC1?@VOaPV[^QG?K
6G4[dFe:4NW-=(E5c\CZBg?LXXT(5?)#X>:[-=J1e/EHCW@.>9g9=6/0:CeK5H#8
7Xa<812X/:0aLE^WU3ES(cQ9+&[)FdX_E\U:[(Q\4?@7@E#a^9PK>?GXD?DF>gCS
&GWF3?Kf]6:NDCH2QCS+)\.WCWPJM63Q#;BF0cI)f7]4YBLB_(J#LCAF.b]#9AH:
cLI=&ZQZ8E>KK5.gM),_R^N+P03_E2)F@/]WAKXeK4QcZWQLTMTbcN\g8X@&Y/KR
_):MW?PA#5J:U6=ZdLFb>6A);187Ug@#DM:(fK^,[,9QW+A)#+N1M5f?fH?A?U@:
C#T&ZN46KcdCN4e/@;R)&W6;W74VTJdc>=,[UC7Dc?0:f\0U0SH#>[^G:=7+7SP)
eXf-cL<98de3]\FVT3Y@aR9]V8;8FN_CG_M4NBB4:\HgP9J,d(PU;?+a/I@7ea04
>5BaI?)E;>,]SJ@30e)fM.--1^+b#QdFd.\<TO,A++@c:_,T972@;4<#Y]d;@+Md
PAKW8J47XAQRGLO\(A+Z11cMFIA=DeM=/7\_5Z_&]c@>KBG=XEe>cE,<G(MCR\QQ
3dKd9eJ[[M<\#4^VcH=/RG9A/<Vf_O:/:XEOCSRXa#V.7c)2J67)^88f^X-EfIf0
U?R01@Z727+_>2J&C[QX4Q,_?=4&cT8V(IU^DbeE.7R46,(Q6[<E(;?R_.KV.g3Y
NO>+\gEX]^c7@AOXJV-E689K4FWX0##31ed3E5^1Y_,JME?Ug85XNfd5g,\S4H+9
,R:df#<B<g]ZRPZ<@UM.BcQ=b]DFdbJC,U^N6&eDZC/S7?:I:(6U2^e42I-C(HTC
631;:U&V/J@QZG3f>EAYf8;NU3/A/:T;;d7O(:9cVM=COaVa1MaMX70??-0U:Q<D
^MK_,&HM\DM@Z;=aHWfZG[^d<9S]];4JTY-O#]E0]H5>^<\c,=)<M@@J[K00#D95
Xf8,JfCX<d,9:OL(9<ARAeO:9:IXBc5OC#c^_@7AC)WT>BfBO,[B^C+K,.O&eW=Z
?DY[eO[.;0NMV5d[,TXB\1N;9ef9Xc&4FMA<9-G_?)5\E8AaeJ]HT,@.XB>0HV84
Q>M3+Jd<4,Ga]dS@\gC[?8&R#306(VWD.W(4c_gWNFQ2.JV23M]),9&eVUaKP]<b
APB>#VJ#XdJeYPINg8.;eS3A_RLY89L/@63,6O.V;8S_#,H]]T\E^/H_3BH;2([Z
HdgLf7Z>+e?\c_;X-Uc\_<=a@^??@R=T;-.)b-:?f[,#R^fME05RXg>@=8)@3M,e
/BOY6dO,GL3-E[@_gB>+9I:#ORTP7X+2L4P-gfR/1?1VP6\8>M:E=KJVJf7,&M,D
O1gdMeI&P8gHJ.U=3aN#c>A#5?CXTY#XaL9UD&gDBK]IWg#G1A8PBW\X<<R\E_U/
;\FX4FYCg<QBXV>BHEZ=f#(I#6c@9<X#YO(8_;g4GZ=KFSJF6FfL2_W4>c08E),d
J-,9aW9_EM^gW)=?Z5gA=]1TD,^J:D[A)6@4I,V:E20E@c\f^eb+XRQG<,#-F>A1
b>.^M6E//]<SNWa3\fVVeSb_eS=f4\(eY^O(\>COF^D4KU;OCD-S7&)=5B#>XSVD
GLW<\=G@(<)b;#C,^5MOI.Ag9PZ@Q<[>/,=]1gAIf_eA[\.6(ef>O-(4I_H-3HS/
9gYG@>IB3G),?&;OLMK2fe:WRFH[D?N<,RK_4[94:]VSII=+>Fd06RT]98@<@07+
T50eH>;QFYef+EF6J2U4KMZ9JT\@W)+^8M0)<J.I-C6B..L4@_Y#ZaNNU;d(aQZ&
HVUER/N2T8dX\UW<E-IOY3+@3MXNW6Pg0<eD2SbbO-d5L6:48\IAV&QC7P;2UY0@
3\+)(2)N5QN-2QQM)8:A:gd[=.Ha9GMHE9J#]1#G(:MJV;?+4@BA8O<gKO76VG5(
fg00#8DQ\DIGfS2ScU73MDXS8.VJK2gcG?N[HNZ;AgJR1:O,fYcA\R_,MQS]#Xfg
1JE\;PXUXe\ED0L__aH1EE(/([T3EdK1CXS?[fD@4_G2XgMGY^C#;+]NDCG)Tfca
59AcXd-O1^3]WWTV:O:D#R3aM1L_1X_M>#]G)MQEa1&D1@3_(?(c&G^=FGAcB/MF
?,0[b_e^=g3SZOR82:5\G92>EH?fEd5F8.I51+@M)XCFTDdH7-fDc7]7IZfX.,CS
_b1QcgaUX]YJPEO[2:7b622Uc(+HW5YNP.c&E,07g(9/S<F@BHCW581=)f,<WgeD
XaaT@.>A^>Q6LK64-ONcED9H:63H:IAAT^]-V1c:Q.7cQ+X2dET(I:6.30JG1ARV
=_CXQ5b^Q1432SDXMa#_H;&<@FPG)ZOc9KAaZQ\Kf0METKQTbH4]-O?0(>bJa0LZ
U4VX,:MCY>2,0N87ZeAMTGcfGU+a\A64VbJK>&.9=e,-@1A5T43H_S[f@ING1(?K
[RLT\))NI]79RL=(O\4)gXd@#(^RE7SIB>?SdUG&OA^NSQH>]Yeeae44Y79/#,Q8
^862@2OI:>XQ(&Y-c2B>+U0T;NAeX,M_H8^I#NK\?:QK(Nb?Nb02W.AOa8Xd4Wc:R$
`endprotected

   
`endif //  `ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
