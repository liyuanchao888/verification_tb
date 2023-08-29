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

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_snoop_transaction;
 /** 
  * AMBA CHI Snoop Transaction Exception
 */
// =============================================================================

class svt_chi_snoop_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_snoop_transaction xact = null;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the exception settings are supported
   * by the chi components.
   */
  constraint valid_ranges {
  // vb_preserve TMPL_TAG1
  // Add user constraints here
  // vb_preserve end
  }

  /**
   * For exceptions the reasonable constraints are limited to distributions
   * designed to improve the value of the exceptions generated over the course
   * of a simulation.
   *
   * Reasonable constraints may be disabled by the testbench. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG2
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_snoop_transaction_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param name Instance name of the exception.
   */
  extern function new(string name = "svt_chi_snoop_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_snoop_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_snoop_transaction_exception)



  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_snoop_transaction_exception.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE compare.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision(svt_exception test_exception);

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

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
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_snoop_transaction_exception)
  `vmm_class_factory(svt_chi_snoop_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
T>AJ+bVL]g4@dKdQY6@L/d^4d\5;f+J-1<0BfRY7A[IfgCY6^^S\()IQF9Vg2\R]
R-63.3-0bA//Ybf9]&H-\_M61WNaZ_[]7<2L\T6,).Ucf?@JS.=.)&&)EPdbCg5R
JWc-X9/5..g,,c9cc@KZX9ZX<Qa<JP^Rb5DcfH9WV2EI?47C2MPX[P8SFS)6;01-
>#aKH,P<eZ1RXM^I=BO;BIAAIO].<aQRf<7@bN5^PXA-_2S#J>17N<;I1TH9(STD
CBbT30Z0U=P-I.<c6-#(EaA5NW##95O)Lc=e0[_feOX@9F)Bc?>IG[O&+eJAQ&eP
J@8UUSBA5]&LOA]2^?G9:B6R>gW8RDS_OQP\-g\4L;BV]K9.0=/;dQ>Q_@g:Z_D5
#d-_K7A.^4ZU-ae-QOD=6NQUWg0CA^@_2PB.dMTWL;Z_1>Rb.RfWc[0^P.G4P[gW
d_gH9X/MEZ2CJ().dE>?3+@9JS:;60&237F1bI68Q##0b:O>P:;]CGP\,:IJ>K_b
X_ADM,E:(A;BC=Ag\&XO3a9P-[];.N@J6-VN\S4;@B]_:Xg64aa,7FA.]D0DYL\c
($
`endprotected


//vcs_vip_protect
`protected
AB/)&:^_Y?XTGWFE\f:@cQYe#.)caZQCOCa1aAT[Q67CDf&RA+GQ5(&/Td(@9<R1
4.<3Z#3E@T3^PW7AQ71JE#O[A@OV3Tac,39Z.<MU@2U1@2X7Hf7QIXdPg8>;\cg>
FPB8,^GN+GJ0dO,E\_a6JB8=7&P^M601ANg4]0aJ57L.KQ+F/HUVHaY4&2C/RdbF
,3A4eKI8F2;_0,b9U4=.;J2V9?@ZY(,PZ:CD<7+K#NK_H1fLTY5XCg=/M<9+SB^2
+D;8\DS9\R<?9+S\a@[6>[CVUc@WLQ,f<8.W=T8-0aO@S9+:93C.W2a>&e@3_P\_
G-,HH=]a>-C6c&ED[:YFN&\@;\9;:G?:?aH]],U+[Y-f(dLEKXSDU7N<&(9_R.cF
GaK)E1cX3;7FFg50F[HMD6?,^Z?MWc?.B<cd3=Yc).FT4DK^WZPR7.7U&cLHI+/:
O3>7C?)T\U&7MR?0]g>D#Q4[HfHL_<f69$
`endprotected

`protected
0ERg3>W9QKISLX>?/KL)M\\f5PO967.:Y<&:_S=b&]Y[>BU?PK)I,)/EdXQ)QZF\
<;Na_)[b1BV]/R9YCT?KW7V5IB]dY6->VJ?ME[4PgWd:M?3)]3Vgf[cU/>+bU8N;
_A&.U&8&J1E(O^=O9YMKaQa^:c\=(4C@<H;(^=RK69B0bYI=@THdVLcUM$
`endprotected


//vcs_vip_protect
`protected
9<8GKK]]>O4J9L<^FF/D_0-5)<\LbC6S<#f=8#XZZS8U3X;87b^<.(=-ce[3TAb9
f0NABC&dKC:W7C]R14dW5[Z-V6.=g0HT8\d3e]3N9a>FK@04(>AdN6a?._\D<3__
T1<@Q4:ZfJ/7Q-]=DA<X:F=&J]2-ZeFf9EVMO1;?2b159;&1GRN-6\>\=WFHSJR1
.4\>@J/,)U=@f(g-C:44C)T^O<CNS.X<E2K1\1fb6:X60a_?:f4b&V.\;RLI5dA6
HI(6g4#Y0)0S&YdYQHCQ5ag&YgFTA]a&SR843V36,Ra78(?b/]LS:,:28\N?dCL,
QO3?A#bFc<?G=]:GBNGBQ,R;TASE^NgG_^HCKS@2=gdX9O^51ef_=8eA3_Dg>,fT
GXKLIJ4W/I3_#fX7)H4dD9NFaO;SP]PFA(YG(BM8\Z#bfUSRRU5/2+^;UK5f/#JH
S^4[(c3+,;g^d)H2B,YaagDHeDB-^dbGGcV)G)_5=A-0#,AYI]a2IUJJ&@_d>U\8
?,\fQTO&I9R]ba;CLfM8D+&^D+6KFA.GY0Z(Q=0=6VNOgODb#W0aJYNaRNM]^VB>
g>/&f38(OU[&EK\<A7^[1c:Ye:9GDJ[P,82U,.eaMEF)^.KQdT;NSJQO[3-Ga+fK
(3K311fU;7+N][YCF\->]4;>e<;e(>E;Y<0KgQH4#?@Ag,abSAH=@)L+[Z-<Re6.
E_eFCd7a3TT\=HV+448.fYa>@3NBdKgVA47D;FH<Z(V=EZ27A.5LM#KT^:IAD?\#
>bX3Fa7B=HJ0P&]NB8NIX#dgHS1NPT2.^bg0@_gD?4:VNBJBK55W.)\SfgW=)aJ/
N^XBK9D.ZC>6Q(O_V(CcUY1e/&XQKEe83\/^KJ.HB?^cL,_W_7\&+]RN4KI]9Ub<
NS73TL<-1C(F(b?<@XEK(3XT8RYB3T1NbZ7_&YN\YA@19T>:I+^)A.4&;PP9I.=P
b9dACKB7A-PSX.#NZc4HD@D1KSaB8#]GU\faLC^?1b/V,P7T\(S&&7E7-,<9CZHQ
88WB6,E4#T3+N1&M7O=(?JU8/\N/,CBI6b,eKXe3J_)[NM-X#XTDN?5FMTgS\bcQ
DRMY[-cMXd?QUQPOb]P#=4I9^NKG;[CNBV)&:&aH[_JY&@^N[4FLKPbCd9OL\SG.
db9gO&^EM4g1/Y]3A,:-,5gTG,IN:@55C-7ZQ2<3)YXeF7::0>EOV.6:=,X.G;KF
3RN=Y[\ec^]6FH?e;@70S-_VQ6BL<,_PcTfS:>7]19]:.eXF1XMJ5CDA\FV\3KWd
<=AZ7dB\P@f+?,(,^B9+2/?)1K,UDWJP129^K@?;#GFT)E-C^H7\V6-8:5EV;4=a
&YU(-V(9OL&VNRAU55)a[=PF7X,C,+9gHb&-@FI]APB<3M.B+JZfGKII+I<e=4]N
,V/;JccCc_CI=4Se(6PZ&CLS/2W)&\O-?G(4a&d=A=G8Ha5VRf;YQ4I;SY8a>BW7
2f<[:@R/G92J/-M7EC.HT@K//H=RM+UDL/J@1K52aSB(TRL;R7=62U,9X(M^&=>e
A#U)JAgJBf-?DEd-;b[22c8?D>YQgA<BHQ;A9/9_e(S7^0;,<3R]PZSP]ZC6OD^K
+&:G+;g+V/If:80YE6.<NXF\JN[8Dc(]W2-f@QWUO^5(+WZ2@EUHM##:U-B@Z_=1
KF>))+:4<8SQ,6e\A[fI270fPT>#Yg2JN:L1WVINM8Y9WC[[?PXU4?8T2OM,dLW?
aUN4ZCR=4>)a->^-8O3C#0?E6&#4@Z_WbFP5GYX0gdQMWaMLX>=?\K5H4.(K^6JE
.cZOL?]#-&^V-\_6X0EWI)7(S,.X0KcEG(42RLcIe8>_1&@FT5LKD3:WFTC9b-I^
1\g/I2eS[a9N9[OK-a^\K7+cQ&9MUC(FbZ.6f>J.H/\M\2Z<CJ.9H+PMfUM&&/S7
@P/0CeA.F8XL;L+9]_eaPc9-6&.gaa&C;/12->e5MC3^g;aU)J>F/>1MFZVbG+^)
<22WcDg\AL_T3(,:8)NM),N18^:-eG7d;G)&37N7d4adP\56JFZb>M=NdH\CE_RR
BJ\9QX/VI:J4)AU2FbTQ#/Xbe?IG.4e5N8XJJ+C]UJO:NKV5e^fNT>678d#[/JdJ
XQ:1b@?R7+8:\?f;GXc<_>U/L>HDc+?-cB#b<X[TV#61CAC5HRc]g77.?1e+.:-&
:I]]UW2:Y<DV<Gf\U[eW]H#3DW4ScaZ4H8?5c7fMLC?5Z(QT4:CUT.EKVKU0J0Jb
XL6AdZgF=4;19@dEd&?V7TUE80X(1[(#PIg<3MXDNd8L2EX6[VNW5e@f8/9.VSV=
LYW.fHF/aG&I6P47VS3U<.LUQ<48^K7<ZM9(HU<@=b=V(5W^HWB[^@TL?JXUMNZG
=5IYLG4dONbG=QM3,d&VI#_HW>dP9PbV6gdDJB-R0JDKeE:3;(X[N]E.U;AVXQ&D
HeLe@]5bV+@1OD&fd)[G849\gU[)/=BTBX?3aK/DeIXXEZRZ1Gf;KcOAc(RH?XFO
8ccIMMTS3>AK[;X-#4O^O9MB&fFJQ(g5+95W9L?7#9RRAEEcfVFQ)2A6HeU7Ic+d
Q_14+A>#a7]NAM>GA,/fMdMePc@gaCP:#GSR(DU?>@[K.?3C3Q1a#=^?<J8UDV(2
RLg#.7LWZCK3dA_IGP\;R;(O6BQNBQbPV2FIG[KeLXbJc#O.)1=JLGR+b(1ECK0N
?[e.O579+D(.<5>9]2CO?@\];,<aLA&\RITTC[]1HEY#]F&4VEBF+QcMS93J]W<3
I#P;6-2_51JM)E(L>3LCDM71KX?,B.)?H<+c59B?L)\e:?=VBY1HO5/,CNSIaSgG
/0QgUR+S3(K]Z9CI:b]+J5(YBaW\FE451BZ4.)bHd1]#CH4^2@=00-WSZS(,XIgT
.Sb.Tg26E(cYHGI>,X#gQ@+/9[S#D\2K<KS<7_9R--S>;BDI>2SLWg>-@^<NU8TW
6]LYU[.d;F4e632C(cMC\54M&;3PO^[RQ-aM3U,geO[<Dg\a&C,+=bRG-5bIEMCO
2C1TSBES2OT>B;9^T0HUNV?7g.,SWU3RT2W^&;aA#/;UG.7>KEST#\\<HbH54L/b
M#HTb\00a(eF9eZLZ;&GCDPPZ#LI)g)?d8a,CO1=3fbb?g&a()OZ5+X#?-&T&UI)
1C<#ZLH<cF<GPV6O[S<HNUZbGJH;;J9Ff3-M026,A8.5^)AAUNge;?cG]5.g_E)6
+P8/?g(JBHMQZJ,FS3MJMUT-;Wg-H8A8eBeL79Pd@0]A_bK6OQR@J<5^Ua2\f&4,
^(Q9>TVT-MaIG-f2N9K/FJ(TACN8E.YV3#UC.P;HD@g=?3^EINL=:-;QFW<\0V1J
;O?4-Y577S7)Ag=2Fe/-UM#JPH5H7:H];+d>UUeIU#)f5aN3A:D_0-H81/Y8++Z/
1-002&NcSK:=a6>8YG87dcF^W9D]K#BFH+Y+-Id#\F0EQ2U0P=.ZU62<167,;03O
,1:b1C_fWS^<X2:\B_DR)(-T8Bb^Z.)+@CGg7,Q:DY4MKKVSb+BFLf;bUe;.)C=\
F5eQ2(PLHXP9EAg,N9MF>T@3BUFN7:.=H(4YE5;L@LL5U;9\M8+#J()3-6897;F1
VKa\;gbCRaD_+N_YJT[32COgBA2>Q_I?+\06VK<J?TTc#E?ETOBH+VB0VOC]d0WM
/15DHC\PQIFSaE0FF0:L>8BB^a16/Fe/^Ucc&K12cTgD^3=M:CWFe.L2:J6EQPf(
<4gPMX.P-?;ecJ_/^IUS9##YXc4J@XcEDe3EJ7H)(].X.E?35]:WgB&770R#dWK@
&MgQQ?W;EfZ5IgFICOE-VI<2eFdV\1IE(_Fa0P9g@^.ea6U<Eg0#9(FFNS.XST12
IK--A?XATJGf77]#L+#E#Y0W\)6]BEb2#^?8Ibcd_11-7+KXcQ4S>DBM.f,#FUS,
F?d8_R7]#C9?eCBH<(C8f0INbY8AB&SW_O9@^2I)TU\gSN6d;3XCKL)M+&>MFBJ8
PH/>91C1YLT(P\;H8>U7<ZaAe4(Y)XYO<B-:H)\d<LM@:ZVF(S9^Ge?8MdZPK4Hf
72NgQbO?]W<5P6Q5?IV<>eJ3TMFIcJ3g661E,ZE[bfg=@Y8@GE-?c?;/cI:9Z:fd
)W9L.]UW3ECUaU/c9-1^1Ya]\8E9IXMXIY@a]##^.-8OR&^I13,MUYX7FaCc=6-Z
>BQO(.fJOX6DLLS7fd?Y<ac6S#15dM;IgG;5=KEEBWB/[a[)W<S]\a_>(b^Y^:2[
91KEa,)]<g6_HddK:1T.IE#fRdIg]CP6ELR=X(5bA@OZM5NB4Ma9+PDOC.4U?]9^
TK_W>M1P64?_Y<7BANX:U([JVJLI261+MeS[U+=0J5GU37Y?9KJ8e9RHS000Y4<E
KO#>,>fY8/Y8YF,.bOM>aC8RgVCgE=8d)S;L8Fc>NGfEB)FBDATR4(6\0=R]&O_S
-4CUD&&,U;N4MWL7D\]4,V19HA:(#b]Y\Q#<bW7W2JAFXT&cG^W8R1+NS[c^U2NB
IT62J:;J@-bKS\J7ZWcDQ+_0dLP(+D=Ge/R#G5;,GNK@@,<M@A;==,I0K.,d?4PX
.4W.[<8,>5][EWDL)bF6ZgXG<AeX(MCV&MD=bg>DRY=E_:b?478F1;R(0S@GOg=X
G?75L0U0GK_CI0ZCT-=dYa6GOZ2GI:GH8a\LNRb=G+H.BDf(H,&]U8Kg:3?V=BL[
8)@+AVG61X3GQ_61^:(F5EeV98Oa)+VR3Ke_<,\Ye(@D)U+=@51JI&N7HB^ALI),
8M.ER6V(BQY[;4a0#TfVY?/g1YUK]e0;+DG?;Z_,C_>aM(C9EQ)CcJJRQ4U+?Ra\
gADANQVQ^J^IY>dB:@_\H];CI#^OB8SO7FcAFO/HO\Q:M.LS;&7^gH8UT-35+D0_
3JP4JIJ?d<_KL];-AE(E(;<8[4cb(F#[+KaS/d/1KI3NE1JR7e.2LK^W/bW1+RTD
.GYM2(-)#-fGM2N)4,.:ZV]D?<=B2OP556C:&#U1N7f5a0SL0[(/?dLbd4I8F7M+
ed73Q)(QIbPfZbe\EAg;<@6,M5YRUZFXF5g->QF)S>JZ]OdC(XX?<?=P.#,+.=BF
>G,A_SBM3MQ_X466NPYS950AFBSS,f0\a/fI;b.6C5+5IN&/\UM08T>16QS&:C&X
ZY0U2U0NQZ3UWa+O8P^cf;/QS(,d-@K8&fVM.aDe>2aA(Z7):S^?_S0&A9AL-\.A
#1dQ/fY#YZKI;GZ9DKGT1Ec,^5E#O.I^,#2YJPd3/J33.TO=>(Pf(K^)V576U)7M
]+CIdYW-UHIK)^c<#2TXY9^\cF=1d^;ROB7bd4gH=O9+dAEZfA(C<?HDCO7S24@3
TUcf#gAX[217b2N6TT)E@MX:f]3]-d2CV,BFNI^c7U^,YWdJFfM4<M6CUDP+TE:C
Q?Pg6YL2<Q4@QBJ6R+3GKQ.FF=N684Yd+RV?-V[Q,Oe?c5(Q:2Lf6:HO=Xd>;]AS
)=]eO.FQ@3[\DY:MQ,19&A51fdXJN5Z3GCTHC.ZebHgZY3329WEE<8@d]Ae#&@?;
BD7[T4^T?^T5[A;LaBVD.bGY:fdb<I(TEE;V_^+]+Y;bc?NDHKEV<831.YfH0;ga
Z.ccJ=+c;A<_NQ)2a&O&O<b28XT_FA#@307MWH.8BBCfLGF/_1NSV\d1?)E?9a\8
V_d#/D>BTYgFaLL96-;;]:)Uc3?FQ2G,7QSIC_O,3DJ8J)Y.f]EKP@g3W0KBL<C5
gEK2OF4)),+^5F.@a&VWRZ?>L:3SI+;dP3R;#C7E=6U.QCXYc>G-GHV2O=V_Ra1>
^O:cO]E),9b^_EN1=X0BW,V-\VZ=8-Xa>+-:3g9C?8)g[#XgJXfQ94@1\M4dF.ZU
X\Oe-FM+aYP0W.5X9PP@b7>g1<SFc7[bNRR[YDHCa[>?187c>d[]&YROeV=2TCea
66eVOAe<g0H&/D0&_N29KM:MYF&f9KOTHeVL;5&SVBEd2D\F)(8C8Q&6:Z_I(g.)
?H\a).BaM_M3/bGXPgR+=.E3&MVX;\L1W<0<<B3BC5UDQSQF#ab_F\_VNIcITVgD
?@996XJ=X9W=g,B>+\XZB=8?;S2;gCb2_;Q_&ZLWF1-Rd2a)3#RH&(DT<EP-1&0(
#&1Td--CLD0cYcEW]WKRZVG,CU2/,]L/ML&Q9GaRC2/CD\1MK6QaC#SO(HJY,XAM
P-C,Idf^baTM^W.CX:BCeNSZf,/Qg?M4Q^a^B@)(R>_P9cN0Pg?YCK=gg]QA?_YH
R8RUGB/TG3BZL,c@8(ZD>Z@6,\9/WIE0c]?4UXcT^=K&+Q:4\GO2(1FUKfM2IWS5
>_#];&2K60T<#D3<Y60V)dc75gD^Sb3/\EA)2<WR3E53I9[KS\H4SYM<YMO;RKY6
<XS?Y(Y6)58X^AOVWe:L(3.&:(9LU5?fB[)I78FIgc]K(0a,dU_=FeS.3<31<7+W
5OQM;F>FQ63Te#7N@_=0<<QQAg2-J-\\W0S#B#SgI.SUT:R8CP);)eI+3M#HeK;Y
[/gW2.>BaJH0VW?>#&I1;(/C;-#OL3GTW+5P07LD8S1gBO+94g_4-(ZMa.J:cSaY
76_7b,P^O[Q_32T0@/Ee?FT0/YK^7[SV+PZS^RHU2/:Ia;RLO;V(d:bJFN#2)QQX
@=5aFZ6,:>3Z@#3)bU:Z89EO/S#<J>W@&5BED\WHR-8cg:>Hf<A+;G08fCYaa-=2
:3P[]AVb]GYQ6D4cATLSIO9>+43[9&S86cZL4C?=eO6=5UK/S+Q3._I\-AY\IVRB
U(d5e4g<,B8/0GRI&C;(/9Y3(?<J4SZZTRI5SA+.GAeRI@<_QU=+:);]&.b3gJ.g
9Gcf8>Iac)g?B2Gd5B]a6>C8Z_gNLR6K.KD4fP#[-;H8L<)\Da_Bg>_55Z[P>L,Y
5K0>@>cfU^1d=(9[=C]A#HJ:YCZ,M&DQMGO&YXc9>_C1/Z19DF78V=KQ\c_4+)Be
b;:Y5Rac,U9M&d@/&aSgCd[9.b9OO3#2PB;4.74^(F=>)KC]]9VSN1#G2Q?58I:P
e.Ug:X92#IS19(d_+g-A)6FL]Wg@^f=aW2K1)A9:K,A<M(f+HSCH^[R;AU</]DLb
6HKGXV,R<Ab/9gS6[HVP..Ebd.FNAIOJ2CV(3O3(Gc)4Q/+\e&cb0b.33L<;HS^I
78U[M/.B41??)=#MJL44f([>aOKEB8[D^]L13]c8&;dCZb_EHbMM0^JD:TQH9W3(
[N@?Y9DUTMYd(SZS:GH#GefQRPfW=@b6g-b>S@S0/3>?PORc?>R-SBBWCUYLG[>V
cQY65Y#^,-Re]KP+_5TfgL;M+?P_?KIQ0]FfT?[V:G4#a06#/&)_e;]C.<QT>d)C
YI,C<@C6Ma:GAH=BCF[H<HX:eQ@[a+4\bU@#[V;a)-/\Y?8B[?0\A,NgfQXD0,Nd
(CSbD,OF1c4@FML1XQBV7FY&a9a,gC3];0]^_=<MY2UZ46FZ>L7S#VM2L>UFEDe/
JW5fP+bJ0?B=@f&a.^O>4UgWT:&PPBOYJD&JE[QEbF]3?E8]0/JOE88?SS0)LA(A
W<\MX&]UV.-fc:F98_XT7a\_7,f)CM.Y5aKX2#L?6.^;,]JMTcA?9;eDge:R,6WD
.[U,:gVOaaYRLc+4V?ECgbbSH+0):S.L0cTYJA)gRRZDP&@a_;_B0GbbL]C-3bT_
MH:YHV5aV^RK\?V:)J==cX;I7d8Wf4<?=.a<FI7e<c;XGC:KYF#1;B)G<X?f3U4K
,:SSE(O_R=MeBBT;RM-1T#R16de/@F8^8H)3OcK(FEgY_<-5SA9MY<3;1P/N61E?
_1Z+c#GaW75N/.@CDJa2TAM2?.]<EZ[:H?2],7U1]B5ND0+2OVIYDX8bDA#=.>UG
+.2.@#6T?4#P:HYQ?_X):d>^&e7P4INf,\/P7Y(.Y14;dE?D^)Z@Vg,;7P##YG1>
PD+02;NHVSY/?J<#9C@A^?g_[e93MHJB@L[1c8DE727QX-2F&3c(;A?E[gFc03I=
gJS8aKacDY&8gKKY8[),g]ZCIRB888@ReaI.K#KBH,@BAZ.A(N__/)W2W:N;?5[N
]><>[<E:X()I:(V8?#]]^^e);^6OW)(=Of7W4;M<K<4#0<Q8?9^a<f14RS853\Na
f+B@ES;e<>B+N2eGQdBPBO^c];^Eb89.:e@-O7f2ILO?-ZYg(L:IZH^?faJ=c4f,
?AI.]9J4UB1L0+T8W0a<V\ADI+ULc-0VJ690XGg[Z&U:EXDFY@e_F8(AY5IS_7bb
ZCXGR(8[6/?=HKU>KYd<8X8K2@,<eVY+)@]-^<b7F?>Ab+^VC;#Q]>V_eb7<IgFC
^K/gNBcR8)N1[YM=O(LZR+4)L>c]@7(=]g-Q#/SG.9c[;C2D3.bTc0&;&#M,c;&V
:?UVDAe=;ULI]7XJEWXK35g+c,]VS<JATc2&3E)8R\D#W6]8S=7P+]0NE?gCI,?R
>-e6OI3ZA;37;A65c,ScB31#QOL=e.LefeVEdMIg>7a^_F7,ggf:?8@FUF-J8097
I,Qd^b9(YeQac.6C<B>7^75BRHY.ARAbFgO1+A(e_([O:5XZKE/Y>RPDB:QPJd=A
-QgT/R(S>7S@Xe:JXZP7@KH;P8A#WC8515<#W3T_#MFCg1/MI5[CAFJN_QO3MW/G
R5^1)]O7-/J4@7@J?VB=g?\3&aad]1M@MgIM1WNZ+fPGS(GI5Ga/Z,>gYUJ@FQTc
/+DaT)EXWOa],/@,],@E@3C\;2c>Yf6I8JGQF^MU)L-7[]PM#R>,(2Q^44Y[.X/d
=#V</)Y;ABgfH^LVKc5+7@3]gP3bKIPHUVR&(#XOJD-(7_6ZQdUBZT0U6<d)KK:C
e]#6T1HOMGHc@\].:QRB.(N#LZH?L5@D@a@3RQ;;THIN\9/Z:WP:_?J/X=cd1+gf
AZ7DK8=>aU.dN/,AYYMYL=@IKJ9^^7>]QDfU,;)HA32^?ePXc]=1#&SEbR5)U6[[
<;9ANCAY.-M78VKH3@I,/#CCFICQaJ\B6VQY\=8KLSg+\)AET@Pe^=\Z/UASHA/H
gafP1LJE^/gZCBFPVgF4X4.H9]I=2?67<64A.#-Y?+-81)4,9cV&5VL44V=aV;9G
fC]IaF;N/bRRd#gK)>WY#9BD>9A6R;]F^/=Ec]3V/eK@@Ra.+0,5IAW]TI0Ag1]H
3+.^9H7B=cGJ>1/<U9_&c)+VHdMbL,_^,SGC\9?U3[8P5=O8(#X9P:NPH?:K?TV)
GRS3,gO;_dV0,a)&WFCT:;5)?6T8@2OGdgIbG@J@9e>5UL::4]IOA\4\TNR\c<>@
\eM9gfQ26e?ZYNXLDQO0T:[,K<f(7J+7DQPIfYC6J&471IN7A_2U,<;=]ea2f#a\
^+8EQH)CK8:)b,:?ZL9<U^c__X\BG5NWV<V?d.ERPeB]@-C/_KF(G2X&3X=?XWSN
:YFN0D,@>6c(DMTG@/Ygc7Y.UFD<KB8B\0PV8/BAN/Ce>3(2>D2CM3,OT3D(4^2:
I\cYf5\51.T.(#\FNSB)EaQd/4VCSRZH=gWb[efX57[_]DVCCH4f6X[MIP7SJHUd
;Q[TNW#X(b&U/V?8b@]]MOKZ[-PBGS12DcX(E]B301\]cKE2\d]?0WTHTFc:a9-A
(BHcKTHVWYI#&Bf^,XD2TQN(\:U56L-O8&Q6QV7BefNY1e;R;1aP@<ELRW(NeZE-
(:X@V[FZ,.HI[+c]Wb,OfL7cg1W<JO89#eY)+_fIARQN])X>.RM4Q&KIX/4&)7>f
3=KdDaZ3A6F,f:1:ZAHa&\fBWVVL6RWN01)^)(B=.S7BT9U]YeT<J/cQ-[;f;S1\
V/81XV5Y;W&=NPVKgN[<P1/1]4/XXYDQ\FN8)eXfY9S?,F1d25=NVF&#WW49:/7:
42LH=+W\YT\#-@J/F6)R>_2b2TKK3Q.O7WAb&D2QB#b_Q)RK<ZfX^@HZ:eDIE&;-
7Y75P&Xe@N](W+F.Pd(0IL3;25_TfY<e#2fNH(5ZgG9(;?O<dMc1Ef9KF[3Y#fa4
8_RRWX?c-@-N?38<<8(A]+3J<:A)A_.TKGUWB+DRDIIa@c.7(-e-8&d?&UY.C:)9
KZCKa_2IH9)a,<CX3f<S>0TAN^N-K837P7A[XD7S:5K+Q+.KNWXN=]PLgb+B,K#,
ASJ-)U76e:@a-,OEP#FGM4@,XY_RWNcGLK-7^Y7e1cAM7T.AZO^8I=Q,b#8?5@9H
NG0:>RF/WE^31CQb6W0VK(+JUHN/EbU1FL9BdcN-Q-TSfVME+FYL<T\M5BZ\L+cE
V,E&FS<C&M?;>7UBS:MKQMa1UaNBJ-K@eT\BME>;?4)GOTe?M^NRQ[+56DUN=ER2
8S2d.gGP&#7JdZ_I&cCY:_;IT=;b\C<52-&(9BX^L<?GG9DL[bKS3-R[?5NHY.Fc
5bG@-2dKg4d:WH#OAL.bCUYdY7gE.I5?T8-E?b]:B5&3RNR;YJG>C<<&^^SN7FT<
X7]MQec@49V:+<=CX[29e:b15H/M=L]<&O?GKR[8ZKN/cM>O0N+XFIe]N1X,H6]J
P,a80WFdD:?:(((K1RI0--dWTTQ2KgQB9-E9FCU]_[BdNdS8fAe1Y=+<Y22cMM)T
5=5b#EKdb]7&1+YGUB9TD(@IWDdCW/TT7H_G&J;cAc/C;aTWIL>03YDe[eRIPPYa
INVH.Z0XL.B2/4Y5TfOB73QVV7<+MM#)/LGNKK&\NE(cL9BXOP41GE4O;:-8HXZ8
(4,T58d)3g0#1aa>HeeH@+\K#LB;^7\2^Z0OC,aH<f2:S3YPK4aB+e]3+V:,9SC1
<B5W9\-bLG.e>.#&]5>Z&Hg<Ac#FSB2S_BM]b]Y+R[Z:^f;L2.W+_Q\#-Q[2H(LG
7<_#C>I88PV3+B/I97#>\SMO0I6&&5fAUXg;2Y8Se/FILDA,:65e.&I<SI6O6H:S
CA#E\@,,@@2B<1d]59&Y?OXdTW4VX=EV#83SEW<e90gKXg)?Y)H1E:c4Z:Vg8f@b
[TS&f\7P>=Z-C&#LR;PW&EWg3(RO;TI9:0RGUaVJ#6W+1e0a/U)T=a,]X;T+L,Z<
U08=RT9WE]bG]Na7bXS4O&J+a=E51-+VH#7g@_SV<Y=3GQJB.@^[/J+G5H)=8@cL
E8)_,N:;FScRZc/PEBdT87D0,@G#_dT9AC9L#(#Gg5,[:]<30)C;>Q?(Wb&9W/X9
Z;,#;Q+T>&,0<LC38-,7F,5Ne7:=c.>F&,-;g?8(d=a,.S#M=VF]6RX@abZ&aR(2
TRXZSNP-dd)I6[-Ja@F:&J8eJT:[W+(;0.E<^HbR?<G;D.BV3e(=Sb#PJ_>T>_fa
WEYR#L7N7R+4O)BfK0T;\D8b03L6V/cg>]WbAbV&6;\QK<T7+K2BQN16c2<OgJB?
>1a5C)UX^@S/?RYJ?L)E++F>A8dCPB<C]Naa\Me)e<&cf7A925R\YY<J+O:/HdD5
/N_)aA6SXKVPd?GAa/\Wd?^3UQ@<@W;46L,SAgWeLBJM>WBadMR5aSV1A^BMcG9O
Fd[.6MPf\Nde.[G^Egg+7e1B=f0,#+D)NaWD.2:d[TS7/b<TeFSIaA>U#O.2dgK(
D2#bQ&R19SJSU,@NYM.P?dB<,Y#SQ1+HNCQM?5Fa;G>c=[(E[V0?X;5+[CQMcTN4
QHIeSF+TRHNZ#WISVb?RBXYb=&X>N4F8eFK&-Rfg7_?-^+XO;\?,RK^MP^\53FC#
2MAJ#=V+-e4Rc/,9=&HXgVcB89d][H#g7(:N9I[=41H?^]L_YJc3^OW8Sg&](G6a
Z=V7/_b5UV:,<LVXMVPLH]M5gTXaQNNO8W.;fGaC<2g=8,Xc+>&aW>\T=KMB0V_e
]RBJIZ/]Gae9bXPG4S(?J;W3IH5GQ+1V>4b+H@H=bJX9AEDWcE:/MO15e#?>1R,U
6O6=BK0/1He1\M[>VNgWZZTXEDcMQ4a^H3=EcSIYM#gWbZ.Z?c)8?5010CD_0Yb5
4R^\=F\[?fF(MB-=DZV9[UDe]A/C_EbT88[QP^D<)=ae85BO&[9JT-<QJ)GNX-Q>
NcBJP0T;gE9AbXD;9),^]4a=921d5>/gc+6(27#)M,+dbQ[&BW74H1-DHL8FF8C2
=-db>SM\:[7?8<f^-F1JAHA8L.HS_XZL:KW&ZDOJdW70<4NQ3IGRebC9>BGX[Qa\
GZ_9R6RT\^:(Y/4VJ&:J5;?EC=&BKCBd@3(e[:+Xb(BL_QdZUNX>-07=[7eRV,?&
^_5T7Bc#LG3X\6>9VbcZaK=V&^;?eLGRW,I5,@,JMK:FZW/BFL&6gG+c:RYEae)5
,#A#(Sd6M0N]_#b3VXC^f9_8P<7W#=@9WJK<5Lb#1Gf.P;Xa_DE7)[PXc_^,d&1G
adJG>PU(B;fJG>L#2BIJ\>?)J.,?@<A4BF/gPaL0;I8ER,g;T8ab86_FYV2D[TEV
S\.TfJ;^V#/bG(4I^C\VC(X(XCDYAE,^J<H=#A,aSQ;)J=dVX;17C;ND>BPg1>@S
aeCBPF6<MB3PQW\>W]gVe#(HS=4OISP3RW^5KFS9WCA#Ld@=Q35FH)45RMLJ)S:M
M7-ROZ6,@ELU6QSW8>F9G][OA[T/:PP@/bBaLMf+Q>(NJY11=VUXQA@^3fHgbFER
?H-_2K[S^8[K^D[<N/OKZQVbPS2:CC11cfQ=//K<U^\=LH^<,<S@d^VO_N[_^4RL
<;YI[J,[NagE0J;3UH7H067/<_U&[E[V@<S[J1)<HC^4\V>1bXb+C@AeTJE.ZS5M
Z2<&]=TJ4e;7?RF_F3,9=ca;(74/Z^#?F1d0[E]S5\#G/d@EeW#a^74K//Y(IJ>,
/NgPKEcBME[9@L4ZM>?RD,c5@9Q3M<O(A/LBdZW/_<2_DBfI.(L=c8W&7e8B<C+N
#^Vg.\:7/NXe079<dD=QLKaL5b:1T40]N_MRWOX8DY[-1.9EVJ<FG(SA>/3Xg0<.
b;C6D^H0.]#BL3]RMF#_QJ0)H.5[ZEJfS#Y8F/aC\X_ELM64V@&LH0g_N6.>=[=N
_M4e?\[AZ9ICQVUCYN?+Q,#-1EZ>b64dGW;e>DJLDa1VDM.UddbMdfSe8:Y45QJ7
,-)FZ1U)2dS6gYA.J?,9ZJ3-S.Z+[B&7df8H62F<3(D)UF43Y.dVGH?ZP.S>VY8T
N5ZTJL58@I,Q60EF2-^ZLMfUF8MBQ#a[2-G@G0Cg9\-]18?WMA:8f\4>gN(@JN&.
>/W.fI-5HXC74#?HKAA^J)(V61?37a[TDQ6M@#I45N8=K5Y==-_YQ&,;V/Ug&e2;
GU9YP9T2UP^.:QCW/bO__N8,:D;g0&Y-T4)<[BOWTL,X)gd@[IXZ9W37eH7cSJ[T
GTb]J_./;H-.fU.0C]GHa82:\ESdIFQ3gX?RgU\:KOP-g6GQ+2CK.N.\7ZM3+Qcb
1=f\JK-KTOVNaE?b,IT+6?=CRPJ<\V/(,KeTXd.S+U6;V<\OU3OD18+Y9MeHF#-S
LCMOVFU2;f(9[;HAfc((]752R\fNP?aFLJF^M&09SD;b.VSIAa4#[Qf1eJ8R_>+N
[:((1e2.;4R?>:\=eGfcb4SGW)]MNQdG93CID\[fa&=_1X3Ab-SX(8>2U:V?@MIA
E\f;U:R=cO]A/8Z<O55HGM=?OMK,UAd=@$
`endprotected


`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV
