//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV
`define GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class contains fields for CHI Snoop transaction. This class extends from
 * base class svt_chi_snoop_transaction.
 */
class svt_chi_rn_snoop_transaction extends svt_chi_snoop_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

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
  /** @cond PRIVATE */
  /**
   * Valid ranges constraints insure that the transaction settings are supported
   * by the chi components.
   */
  constraint chi_rn_snoop_transaction_valid_ranges 
  {
  // vb_preserve TMPL_TAG1
  // Add user constraints here
  // vb_preserve end

  }

  /**
   * Reasonable constraints are designed to limit the traffic to "protocol legal" traffic,
   * and in some situations maximize the traffic flow. They must never be written such
   * that they exclude legal traffic.
   *
   * Reasonable constraints may be disabled during error injection. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint chi_reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG2
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }

`ifdef SVT_CHI_ISSUE_D_ENABLE
  /**
   * snp_data_cbusy, snp_response_cbusy, fwded_data_cbusy field size is constrained  based on
   * number of associated DAT/RSP flits.
   */
  constraint chi_rn_snoop_transaction_response_data_cbusy_size {
     if(is_dct_used){
       fwded_data_cbusy.size() == ((1 << `SVT_CHI_DATA_SIZE_64BYTE)/(cfg.flit_data_width/8));
     } else {
       fwded_data_cbusy.size() == 0;
     }
     if(snp_rsp_datatransfer){
       snp_data_cbusy.size() == ((1 << `SVT_CHI_DATA_SIZE_64BYTE)/(cfg.flit_data_width/8));
       snp_response_cbusy == 0;
     } else { 
       snp_data_cbusy.size() == 0;
     }
  }
`endif
  /** @endcond */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_snoop_transaction);
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence item instance.
   *
   * @param name Instance name of the sequence item.
   */
  extern function new(string name = "svt_chi_rn_snoop_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_snoop_transaction)
  `svt_data_member_end(svt_chi_rn_snoop_transaction)


  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  /** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_snoop_transaction.
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
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
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
   * kind value is svt_data::COMPLETE, which results in all of the
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
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

  // ---------------------------------------------------------------------------
  /**
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  extern virtual function svt_pattern do_allocate_pattern ();

  /** @endcond */
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_snoop_transaction)
  `vmm_class_factory(svt_chi_rn_snoop_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_rn_snoop_transaction)
`vmm_atomic_gen(svt_chi_rn_snoop_transaction, "VMM (Atomic) Generator for svt_chi_rn_snoop_transaction data objects")
`vmm_scenario_gen(svt_chi_rn_snoop_transaction, "VMM (Scenario) Generator for svt_chi_rn_snoop_transaction data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_rn_snoop_transaction)
`endif

// =============================================================================

`protected
I96C#;FHQW0,cEY/[IA\YJ2)&HZH?]F=>:2XCI[Gd<X\^L_]UR>b3)]JS+?b^^a+
?47;UQCN<^R4/JObEG](,+/<M=4Tg[NFXPJ1-(]D-gL@L@R6CU2?dGEFV7]=d,=)
W)fc][[]<a?(b[4^aX6BDb#WC2RR#9<#HJI.?FaZI&_YH49JY2_gEA@/Y,]QfgUc
@GL0G:/Hg+LB_S0,E=2.fH_\,a[b2X9I.B.7(Z4WgKL5K#.GZ6KZ:N424#fTJX1U
<GB\^#/OWG)1<D=G5g1[837)?RQ-_BW/dSWCH6>BO^d&G6)GW\b4SQ[K401RQe0_
_SN(-I=Vca?KKLC#P/X>)^EKMOW\E3VDRIL0@9W>>_0c=@J#>c>XDN/.PT-)_GC/
V\M3@XGE:[W&/A+_cZb+POaHe/9bV)4,DA[81\V<HT,AeJ&Hcb99Y=Y<&?F5>K#)
YA7RZGVa:9@?Ef]&W@UDXESCbKPE^N6AIBP+0V6/#a&.\AQ#ZP#8Nb]NC/aSD-eM
5]9@&D(,QDYDH0;B>88K_?->6b0#_6)L]WH.:fdK.>#&MfSfJW#e<bB4&0;YYe^T
[Ca7PG)ML4>/e^c[S,:(2\<;89,-QUUg(f65E#BVeTP37cKHA<8MBdSSO_Z;-F^g
<BXfTaJPVNLWMf)BQ5-KI7\+cJa<^7>\Ha.>^2OeV\gGP7GW:UJB3@VRSaJaVG:=
9d_K[QT/eRJ^./f#_fcTP]HaN68a)1Z9:KcYX]R(5X/=Z)Jf.D^Z&X?RCO#>P(4C
N=R4<]N5e+?I&W&4FDKXM75Ig5T@e;QBRdH5eKLPRV+bMXgZ<V/)P@&d-:eGSKR#
+gIXWFPbYN(@aGLcP#fI)HIB&;34@<K9V)&a_S?2<)L+f9]M;XW[XCGC?Bf&<;>1
gSV9L9Y0_K;2MK:Q[?\)@?E74P8W\(52CDIbA7X_5U,6G)(d[N.>O_7SM]XI]RcI
5784:E<J?:VfE7bEdGJ](M\HS8NgUZKK)c,;B@IWL(5\R<NN;=D\@fE<[b:6FFTg
:@^W-2cA:4d^+XI9+1-IIKXcWYZA/CDK287]b\aDLP>GPT9f7<[EGI.#&EWOUEK1
BNbc?2?AdC74+9:&]N-WSg#JBTdO.3FDZS3OSR(Nd+8NS=A&4d<E4e&=[+5]OA);
8FYO^@/&/?d+g)fF./1]:UCW)(6aNgE-[cIMG6&F0J=WM,JK8<aYE3Q6AM7N^.)0
dV&/D:3JZ8[19=G)X@e_[P\OfF7(4JH=ZJDFCK\=3<_TLcb4R=_D2C]\[[WK)1I]
XbBQ35G]+=,E76H2(ABd(;73N5L#9QGZ,\E/fF;.BbIF./I<f8AVH2cIFgaH29X<
W<LKKQ[GG-a&]+4gVJV,b.,aIU/.bV2R4)7MAKU]Z_WJB^d0-?G:8aOYEa4_c5f9
I8F>bR3E-d.4a(?KB^P(4,YW7a=9_ccME?TeX+/7VJI56^AX=++R.I4)3Y?AZU]:
LZ;OPV1,K,-5VPg#)X,d=V)5/PdQbG]:HE)G-#3IQE(CVX_f^PR[(gX]QGCgVQ4g
(;1)=#BA.Q7f+XGSQ)Q_Y@Zb?:=XVVfWG.PX6#+N-3Da(+W)16F:0g\1]G;d&4Sb
5)>1cL)_J[7f/$
`endprotected
 
  
//vcs_vip_protect
`protected
AVB+af]+1aXEFE(7Qc<gV:F./U?F:G;<:)>S(d4LJgI=FFVQU#fe)(LO=ZGcEYXA
YQ/&O-UeCH)aUWaC^?:0W+[&(Z6IBCf5:H[(C(3BIMPCL<2>OY)DNQRO2[PGEN>)
QP=XNMKD(9V@c71#,aGe^\GL&#[^BKFJbG/b.,0H66d\OX:0)W)<e]-^I?6OKEX4
F\#W(&^e\#9g4<K;L+4+DZ7SMP&:\YA]3TY?U+EgIc/MJ;[[b5-GeR2#4fIcR--Z
.dWaWDa57\U24;27BC)0GM\[.V:#ISSD+b[c=fQS<KC30,H[^&8aFBBJ1fR2J4,G
Sd35=d](>5=4I?<06:D^gJ\[4$
`endprotected

`protected
1]3.>eC:7?+?W<_K&#^N;\R(HeX/bM:Q85-1g/]#SH)A6ReOR8,O))g-e2]cdWQL
Z,3I1QX.4&XN0S>bN+eCU(e2.D[8^[8D+Wgc_FUA^)CUL<4?d@ca5XbVZ1<J9\B[
5c3^P\SfYDCA?6JU&CE.b5Wa+bLE2;(PY3]dHfOKK[^,>K1OT8^a.]4MA\gFD&f=U$
`endprotected

//vcs_vip_protect
`protected
WTg_Z;f_C38R[PEG;Hd3@^35R.C_9;&]-?3S):c<&]Qf)dLBF+e^5(N^.#/Z&,dd
=TSEE+\\fFR(@R8??Df;Y#(11SK>M[\GM47+E,>NM92[d;4KS42\>ZcO7ac5f-G.
8@F:R#0D@P253W:QEg(:XJQW]:71-1FDgM^J=W/DOKKNA?.)(--<deU-2TG#;#g+
f17;)<ER9C]M,VJ\CXXRQH43g^f,6Ae4&9;\9-fAS7)@HHY4V[E(Nd9gaBDRI+J&
1YIVOM)]882GZTSHMS9HV2#87I_a:ZBK21/IOLf979=Fg)^9&aJ00E[fA(7fKH[0
.&g#JDR+[I:\R.+V-KG@2]/2>5TD)0?OLM3)<.895+E0=a(>==>[f47Y+=EPZNf)
A5D/&\GE8L>d^/MD2Xc6L)R4+2Y_625PPg/RJ>)[2@\(28D8BYK0)#7C-^G+OG/Q
A+R>_&N12L4#YEDFg9F6#\G_RBVI58L1GML=JSFXXC]J&fD,dXY7[P?)ILF^8_9+
ODL6PD^A+f7IcfJdTf<Wb;KDPM@)XK1WL(TVI?XS<L;^@)V)fW9SD@e,.Cf8C6G[
<]?=&;29bQ]gTA\IP:.EK+b#F&f&DfQKI9+d7E)H0[MVO&K;dS>J>GS(WOd6NME<
7BDgQ))3Z4@B[5eRXcbcQR)dE/-,=T/2T()N0cLOX9#DM]K;D?d&&a]^;[4<)7T)
Tec[,IcQ(YAcaD)A7Gd<F4Y.T)3[ZcEN/U>G,;UgHC8?1>c.8Q?>[:P6[DK^4@+9
GEc3_E@>>g@c?GS=+aP@1KVc7c5#W/25fe0U4Z6TR9dY2f7S7BF0Ya&WePg#]-F9
2)5SIDS,e3Q3Xe6?#F+]?-]X&JS/,7?+]VE@E3f_6:()b5cN\e0BS9FW1]K(]]AE
-&U+1T<gU6<dIRX)@#WcSHKA5JR@@^;KPLdSHK;7CPQ5H\0H?<[9NQ/\5dU)[a]+
c]EW[_b,>=X:,-&,1K.KIH0aP]g+G_@EN@VLE_I\4-/OM1?aeLWE=I65dNeR6,HY
NZQY[>I<I1[C(fbC>(1F^BVd?\JVcT&_;>/I\.WS5G8,,fB4Oa?J:20\</FQUIUQ
JS-C(@,-X6C_9(\>1/R_+?EJ2,8I<L35SYPO[#I3\GS-[@<gK+[dL2TBJF(W)4WX
<5P&2&4XE)Y?<WF.[4(AMMD;Pf@g,2L.AGc[ZVL@d,2GSQAHCWGF0QBYSLNab)./
JQD@_+ZQDR3fcCTH2Ie+OB9^<>Mg9_QP0EQ,K1E0&:(fYQ+_4@5LcS++HIR<+SA7
&+FQ&RP>=3,_1IQU<@QXFLMaffIQ]c^X2+&f,WF@HF+]5.\:V[^;;]7V[7C4?@8Y
_dB#aef6-Q5f5eRH6(<1&:5E09WA^(^XZ@CAPSYgO99K39cMaW_CcaE^1T:b+UM]
eR3\5K4_dFA(AFX5R+Y5JDdF&OLZT(bgHDO>G,=ZL0YE^UYCWMW1&WUg@KO^YdLP
^03]f>9\<MU9-[WDGdEH(IY:=1W[N38V2Jd3e?\JE.4S116Nge5]JD)T^g>dN?MG
0NGWPVQT^SIB/c]7ER5-Me/]K67BdV&\UJD?)c29b)#_8>M?+cI1-c#SETHYBJ(L
B)@T-GSTFYZLY)EL-.aWE8UVZ??K-++MUPW9GN9fdO7,UUX71=,g\-/Q39.6MZ1/
A_[S3+>?B0/:Z?/)4UIZ_44N;Sf&IN.13gH3C0K<+N@bY]<_2VL,g;fUY2V9SQS^
=SKeR=7@0>YgSd/C248?BA2.Vg0BQ:SU?4&4cX:GB5Z,HQ^JO7L6X\WS)_;f+8)]
VW_,SV,G9QKFXZ5gCGM>K6(:458YUJ-O3)<Q/[f&S9a2]0TI&(dY7gRX&QGDVdcC
AY/2U89a6.g(APd1,,TV2YN/F6&49<L?)[_>L\T.]1#b>E\cf2cAJe6V+<PW;g_R
C2+;67,)9(BA#M4\\H;2J90GL7MBC(;cUUH4\&6485RacU0@ZXDKD21e3J=))I6W
Ef_@S^CJ;I(0P[?M[<\&.7Z-]A#50G?,JRA><D.e9?US\07_YW/Z]FJ?L>;>#[Mb
fLNY&B_E.9T6K=7V2J4T,Z(QGD+A4XM-13#BA//JQaZ@G8]JSCG4Ag.8H>RL3BfM
L2>XgCFNNJ[E2YJ=G9cZ_XMF[0^6e+Z/TEZ1;V-4RZ=2PY9/]HEKSe.DU-OP.8cE
(C6b93JJYG[g\TJZf<B:4/UC-&+?7D;DQQOJf3CE3;EgJ9223?=:e](D5^2@c4>,
HfT()GgUF\AC@MZ?9T?YT1O@Uc=HVg>H4Q@E)Q8/?6/LfT=&)KPYF]?a=Z@>W<@J
Z@GHOXe669O4&E/N[\(39[CMcf3T)Z/0D8YbOTIb5\NdHS/V9/K/Ne19cB7U9-YT
0VC@O636XXH-@>@_9]MRY5QJ/IPDK40)L>@P7)G9YCT:c;XTJedaH+g6JQbQ.eYQ
c3A]]g\<SVWg+QOME]Y\T\DHe9(82@4;K)\>d(aKX,)-Ra,5DJMQ)5dU?DZbNeLY
>WL>>BeYBY9JR3:T.?\)/V/CPYe_fefaSbKV7K,]4BH<<<-b8HdJM)A^SQS8]Nf8
d)=KVG.RU=3QZ7Q^CL0/G<eC.#afBc[O)]J3[#G&+^1UBgY>PAHV3KUM.?X]=7ff
02NQD#cV^EN25dN&0=.c6W(+T-X,IK5I36=;#bN7AEbC.&<^<f,)D?:+=3\[S[/U
cV+FQeJcYWFDSGB&(d10/adZCRfWD1/_>XK94Bg3FN[NP;SUa7I[B:R(4+f\/5W\
1=N/A[(J/^gH>IBXQL@2VI]WV8Z25fMP7S5f,J_,J>[Y6[9#B.JSZ;/:A,N^:@(<
,K-<Gg+EKWG3T-)Pd&HCHD\&&M#8K#U+>)GIKS#CPRHN)>X5RM1V28Sg;gLMV,GY
F),<N6L55B47#ZY:Y]B#^Sa4aP))9eK@MYAVD\GeRYCYYGWJ>4KVIc@[8.WJcO#A
+N,d/\6HefCOO[IPS=;gTUZ9\0&U0GD^T<,1Z+Q&SZR\CN1L^XN]Rac#^;9@_>db
O(CI&WN@:Ra;1gKaD&F3JZ[J1=-+^EI/P&WEH(RWa.6PC[7ZRNg41I:7>\D;G>]X
VG^-&JVg?.(SPb>ZZO8BP7VcF<R.)TJO)])>N=FIH-S2c<_/?a;UCM#F(,I<XE1_
/d:f^d3R<)DdDgIIT4R@O>]@;V_/UHB]5-,8e(D5I&b2;c6.C07+e-,9^):3&T@]
,8AQ3D#=Q(70SV=JgC279#V6\7.ZQ7Z2SB0cgNZ&;Rc#(5g7RPSX?F<O@ZHS<^-d
QN=4J]C;?H17S9D9#bJ,W963:\DUFXY:&Y0Df0f<]Y_;OWGNV4gCC.VZ1D;_K9L_
)^^E<?YR+_AHa^J?0;JU:g;#=A@c-ZB^=V]ECL:-ga99]=68&cW6+V[ZLAA5DPVa
L\)FO4I-]Sba+g_,fYX]HX+GU)LOT;B^--Q=_>f+4D9/64dH-^d;7229a_c&U6DD
d_9EfI^CWP6VBOX3WT&</?NI-B=\=EEdD3+JU(7<N<F94P;d;)4cFKN#R=?CB)F6
RE^V33NBWQY].EEZfYSc&&:.U?[E(WG?7:4Kc@BZ_&6X(KEMXD<b0+I/EGH9ZYLR
;-G^G\d/]+-U,=7=,N&YKc[_LU5OT+YZaJIZ4V?Y\-?SAGV@DCU>:GIaF=C7;=\^
B7\eG+CJ05Se)g5F9#M,0\(MQ2WY8X2V7]UTYTf\,?dgR/DY2IPCDP)fN-R^.U4B
[cD1YYbAQ18PC&6E>[U2H#>&f0+g;6(W)K)4<,QC;>[\=3R]4FEHFH1:NGU3-A3,
;F@b+X7eK,/_S_#3><Z:CQ&C3.g;_EN9DeX59]0L3EGZa;:B993(-GYeC@.+B12e
JB:1KG<JMYgO,6F<<CVL2Y5FZFTLMd]08/7VCgb?#_d<<c&?#099fV<Q>Oe_R_Af
T08d1OfWZQd+6R4M_<;;16FM0a2Tc6,=O<5#;TW@P)]K&,fU/]=aG,/^\<IFL7R@
3>PY#)E:04HJ3+EEN-U]BHG;<[+DD<PU(50Q_6e[dU2==OYYeZgEgHac/M51U?W_
^NS^:M(=SPd_=fTY#T6M2QZMR.DV0gD7=&)O8U]e;O,IN8XHQ&XLbfK&>S.C@X5H
@[B\=3T6.46-a=f#Pd/KS,JN\C#H5#I2@<6L4KEGI>K;?I0A^><MKUHX,+5G:EIM
R=N<FZG9OFR<8_gXWBbaU@^T&44QIT>cdC#<Kf,@)@b=-a59Fe.Tg2R..^93O&[L
.OV+JZO8dULdMP&_.[_-_M__BAHHM.PYb>(FX(eWGR9?]1bZMZHT-N0f/.NCQR&)
^0&b1Y2L6-gIC8b;Pa;NTd),bQ9RKYU=BO8=/@>G3Xa<K03)@Nd[9W>X+6#UM[:(
fXIdW/9B)aP3\^7D&KLe^1#E\/7C_5-RMTF:DJ(#84bAb)B@\cbWM1(M<-I3)5?5
6IP0.8f<QbS&gRLTZb>K60D3<BNP>1\SI,WXM@&J3:C7^K\=UfMG/f1.#IB9FP3+
f,C+:-/YR.GXRA\>eG,c_8CEYI6V-ZQJC//^_VALY2U()f)THWNS0HeM>#YOf<_-
NTG-;ReY^U,#&[g#\02.Q8FM[@3eE2:Da29_@aF34eQ@JF:8\1<&-=G-8/#J9ZC:
<GTL<^7Q/e2\-ACX@&LO4=N2?AC3>GS/>ZHYUBd6?;_?7EIc]]B7&@&P;03P>Pf7
abHV]=D:@dW><Ib4b8a]9Ka+UK2VPBWAFXRH3;Ace6]J6FN#Wg?K/&&=:Z6203b+
dC5.+bA);QC:NZ>&?cX\TC^e6_^7G1FAYW9>NHf#?I9.CFP##6gVQC5?ggHTH580
E5/A2DL&;2CVS>,IDg6I<KO7O\I_0#[G>N:NfaW<>X-..g<8SMH3C1Z(bg7-Z2XK
M:Ye=c8_]<0#1dX10P:9EdTfG^6H(]CTW[6?DUB?dY0?#/EZ9^@YJI66ggK9c2UL
^LFN6^e8]_-)C+O2JRF1&Q=;>/UA.8_CK)[.VL._9aI<=ULNSJQB_,VYV<aAF)UY
OXY-NR5#M?M]#5_bL2g@Z+.L-LC<<YFL1@g?\A]Pe\gC<5e_9Z_=3LR.O0AaI5H3
V<ZgNYH>A]d>:2_9K384\BN9<9,X>:,(9,8/+./];:+[)OR\@-?aVU5M(9]dM[c<
_HERbH0<::)]dd[_;g;d_:1:]DJ=,2WFa4PI83Jab(\&DJ[3F7JMFAa=BR?2eS4M
8DSg>0?X:;?[];3?1BYL<a.UCbI3)W0_(+Z4#.5.?AZG6a12bJA52T>=CK7DNH0T
X+)K)SIIX0U0>.e16#^QH7-4>S?Rg3fPX\,FFNV,V95VU8E?^2]>EeO(PaE8RY6X
a<=?42W:X<UXTZ+Y@MCNPDMOK\T;>S-B11N4D#J<e\1GaFaGJR7_MFb;#OA6>L@_
CHK=:g,0c&=D5C,D4X+ETWd[=B5TP<UE?3&R3Y++I]B/,0.?W,&,12Rbd\W2SXa9
O#aM[/;X/cVQ7;g&;W>OCC:GSJLV14ZX;.e>4fY;OM-<5ZPY=+]/NW]1d=IdW7&?
S]=0)_-aM,];EJ93J-]J,bC],:)a2J>OR/B;2]#O<d6&563b,DYb,-AXg9CZ#_GG
<S[<b3PdA9765D_^XdKGeR62S]S16b&eM6/^<I3EDSfXX2^HR=;gTW?T6CS[+JW]
R7O7^=7G<(>]ZKY;5I4CUedE-.HYJdZ9.5U]^GO^VaD.95.8]]5YD(OWM)2YK0(g
O4VOJcOOIgSQ^U)d@Wa3f>[@3aI?:70LMb_OM@K14W5J09U>+XS:(>YD/L.9?S(]
@[aX.geSBA+B[#>8Z\W;,6/D?N-Z?,244\1dH+\=K5LG7eH==c#,AJ<C87>--TgU
6^1O8^J:Uc+Z@Jba+NX@MNFWH8e6J>gF.Z20Q.S<H&G-XWHT-YO;W#UQd.<cB_[]
Ja0:1O.W.7-;^gO1#G]<YQCdgE/IWZ(ZBcX1=E+(dJMGF0X4bc3EZDN99ZI8YUH@
5d#_]@FJN3eYO::B7ZR#H>5M,8-PRY(,QeBJ/SLLE1I:>aS2::XJ@3VYf8=Lc6@N
];FDBACSf/,\]#AI@&<Z?KNPUe/;SIfU:K(WU7=X)-W+f^?=Kc80DJC9:]VJ9?MM
9,Qc7+0<6\K65@WLQBJF=e90:g=K51W^5aG<;WdRG7W>Fg1IX6.,AVa]C)\>?R\+
YC^FTHM//C]2eB<._Jb?f&IO3ES=e)3I9(1b+g71<5,ELR1NAEO_EYGV-bP3]ATd
3I;ebMIP3]GY3A(/?9A)Y+aDVg(G_;9=-S;/G(D/_J=.:e=JN[c4K]F,]^eNL[DD
/AeD>G-<^X&#]9-3N2gY_(P5,.U_HOa,S3C_G@/A/?#NO?6e;/RD7T/aL5DJKG04
J/PZ0@X,/-3AQTDDELfg)G/C4S;5KT5ECgdS0cdD1BL&N]9.+QcVGM,1]>OO<NCg
:0e0IVFGUIFG\,c4,F6J0\7Dd]H@V90&&K,E1L&(LAIP\bUYVag.XX,>=163SgNf
W7@W0-/<_X1E4-</eL>#P67#E=[M[A5S&a?^ADb65QE[-R3:CPea:\fW@177G<V^
f:A<eN&SU;K()]8WTU4D19^N@SJa2&2I(M&R0>A2Z>S71F9Z@HQ,H<KD_U:XQE[]
8eg5f0C(.S=e^[X/.)KT9),3>+d)fRKX3fb8?MY1MD\6>J:Uc9a_-]SGZ(@8Z(6^
_)VV^TEa@0]T-+LgGGL1[9D\59EP5VIK./;&\QUcGDETfQ]+6S@7b+c0(RZeI@U@
&>@4a,-JME.6b0FaDQ>>3,_P:6Q_gM#,C4TAW.MgGbADT=<YJFER4].+0C65A3f4
V@0eb(=R8ZQ8&.&)]OVHgIV#7=?L))^&U9X:WJI0c+dI7Y\V]g\6;.L;6&PM+,F_
OgCE>21=HHN-\N@(Z8<@^O[C<7,20DIH:6D)1OfPeP^b=F)Ab;62R1F+&J1EOf)-
JQ[EcX?RY=d?P.^?##&4JRA+P7CB2V>a;VHg=d6,\7BAL;(.#AMK7;e\d.G^(UL-
2SE=Y+>B+>BJMQ[@87T:\]A:4,-JF;Na:X,e^S1]?#(U(V1&cI)##e/96TeAOQK&
;D3@4^f7X0;5P#+L3@U./Z6<Z&E=X/b)#aJTPT,X,-Z7<VC0O/3D/28>N/YJN3XW
10)C?FJM2K>WZ4&6I^;2#Ad>cLFQ)1(7R]87&DD^XRWd9=d-\X\Q1/OKb8#K<?7?
#S^U[@\ffAK+PH@9:=_5+9YH(ISd=g?f#2GHAJ0XC]U+bDgH_KgBDEc^O[Y;bZdD
I+<c-3KLg&3TOUTRKdLSCGIgQKA5\>BCSgQVG<AN9CcY>a]QN]M1RQI5(<F5=Pe8
4GaXPf##KW=3]aR=eeEHWA[JQT8-^A?PFMEd5)1T8K\9]#TLYEC.N)F0D05(S7-^
C^>;4GDM;7-X1F.gSC/4L9P>b3F=7ZRBN[HAMLTUP&>_#-GMKXEB(K]b[QTC>CJ\
K[OgJI_/WOTTXHX;D7=eEFc+PUDd=3D\P=d/&?@#))0+C#:6EW.M9MYcX3)[0Ic)
?-<BEB3T9T1#W9_C-PEVY.5.,=3UZ)Q,/HU+3YOTS?2/XVFYA&f:=1eD-#R#BdOF
M7:Q0RD5)+LBQR<f1D<HEP4\O3A)J<g>/L&SI/3_Z9\AH0faSQA/^2C[XN]^@HB:
_91>3a2CN,SL9?HQ?3SH8391#<K_fIP8Q)gI=N#,fLOUF#V&cC0LA(NL0W89bQUG
cNYeT=@:M9LF3T<a,G?g9<RgUL(6S]@]<2=[g3.MS/WX<HX8[F)0;/@3c?O=KR54
T=Z6^)Og7AP,E7C/SD[dCN1M^JD\fCVN>8f6S9S+Qg<2Ab6Ce5@GP_ST7C2><LJ/
00860\;Bd7B<_)CPe-QKW<>(QKFK\/2K4C<X-W)@FW]?BWddBGBI7_IgH4H30IZC
d]4C[K4133A?Y.GJ0RD^;&ba\[HB:KC.cBY_8-2#&?@dB16Q1Ta9)1J\+A_]EUWO
Ye;^>?cU9Ac285QD=L3-R6V[US4:J?0SX[JGUZ4;F>TOR<L@SRfe4SNO;NACZ5(8
\/73#Ga1Veee-AJKY^d];U4T>V8Yg^//#=PcbK5Tc3RQdO,G#^f;,Y(SQE#IgW?;
Ef@R(AXMZ/+PQ<[Ge+K/<3fba5eT)6&.g5]dX:[1W\:/fI[B>RQA#4O,W=fBCd?U
e1V+G)dXQ+5;c(S0#gE1\.>d9HT7VdM96>HJO68_>/X1T6FEJc4ZB2_9[L;I98FT
aX7Y+VbeZ_62K/H3;X^=[H1T\3U5eO?8XL#>.Yd:\2+6G[T+&17&ZIDW+=O>PJ;]
M-0bQH]/3E>N#L-T1.+8(UZI8S69[W8.L4BfGL0-JO@aeZOF)OR/aY_E3JVO6eJZ
c<@R&H@ZW6+A0364D7H?+c&&:3)&HFg?F0@:VML<T+g8-J:HA7E#^X#^U4[HcdUW
Q4?B<d7=JcKcV&)3bSJK#:FFP-H=#SYO>[2]Cf6;3/E2X7,dX^dA&VQ/D)b=S#2^
[5U:=O&(E>5T:?6KIX,T(ONWR,X];R-A3T0B[fR]XIXP#a<__dc(#H.PQ9fRQ7d3
^L2D(,LG^2Z]_^LRA6COUQV5GOR-G#9CM),L>Gd[^3=W1.G7LVdXQVXb8b)R?AIN
B9]ZOTa@&O.2Oe/RO>H0LWdMX0N9YQCK4HQK_9M,2)@^@c^cIaSP<72_QXK)7DfF
6;SZTUTCM@5TbAeg/JUf=D&M):[U_/#=\HT<e@8aNBLS6:X;7]P3:IYG:\Y^=;U=
-c_#Q2G1B560L)6M]/U(Pc679]A&YgI7Ff[.b:ISKR8Wb]0+](XDI2&cY-N^(J@H
XXd7B+J+9RRY3Q=Bd#\^eTL_@Zb1XQYNN]/=AfG8Pf[dSM#)G_;-Ubc[_cONA9XF
.?]eIQD)EgAPc3d+7TE@DU;XBK@N4D_QZCJ_(f3M_V_gSP\NQ#,A^cC0:?HPAU9+
-G?)1G;B0->[/JfA[N4N?\>(TG#3g;.>/FbDTBD]O0O5;[V.8RU&GM(7AM/DI+BS
+:H#9[J3a7^,6<?E6=e,4gGD#MZa.4[]QHHBY>+5Kc@V/>Pf+U/^M2];/F,Q,;/J
8D88:6OOg6:0X2>ED4)Fg/C>(/2ELKcQ.)03dXE&NLb:YN5@Z\\eIbGY<YW-]I_I
QXHQI[D,Y:C0dU-O<N^SeF.>?CdgANCH^](bUW]:1<>Q:D=_=AL5>IGXW(/9NZ8b
8(.g&GG0K-(?I:ZS1:#3_2e^>M8&M,(]]&R3:XVc)BTD,7FHM(Da<Y^?C/\H,CD0
9[f)U.\R<aP,L05]OVHCeRaVWeA70J#_#D6C,>DaYYdCa,PD\F9V:Z\?;NES6b3G
aON8M7L;+;eOQX_ZGLNZX5:T#aA0IOKKC)bFTQN=3^F]-E\_:U\+=J8OI&)5DZI1
d;(AC7^LgXVLd8W@C90NQ@T,KY^W<eA-VZ?3\b;VZE63-0;+49e1O=O-ab)RD43H
HR>,+LOEbR=6QEE[@c[<C#8PXZ5GH)F-?01^Ca_3e<]X>]_A@bf(+Y-X:6-6@-4T
.OL9N6J<e.\XJcd]W8W_5GC8UJI?9#VAg5e4MaFSDJP8U)5EAUO;K-\3EKf(7G?]
91TDdP)Z2=IGfL2e7fZJHe)^)_)HV-,4F?d[U&#JT&R,4WZWAEUfO^Z=K[_]EE39
O;RT]7O@L4ME@WWG#@Y=25>+-Z:W<4&B0gQ^[6QO2U34BKa_OP/Y@e+X/XKT-bK<
OMF060<S/cfEdEC(SC7(NM2S5\J,.HPYE&.7E4I@_Vf8,Q;Ig_[c4W(BYFR\^&XZ
R@-b051aP90@FQBee+N7H/JbEMS02+&?[C&#B,)VgDb#4_c?-Qe5AL\->]W68-X[
&GCbZMIY_&(0X(Pe07HVLO?,J#QF,47JBBe<b2EOPVPIYQ@eaBN#IUJ/OQ1c&&V4
QMae[GD,J3C+IV^eg.7FHca#[JdC&#:e^S\e7Bg941[AfIWB2[<Q=OV^eOXNSR1?
644Xf:[GbPc2Ld/M\IGeCWV/&.fe^S)d?DGTWSC&AERf&aY1.UYMeRM>L&,b47YQ
ULG3>HY+WgTOcd6R,@aeMW8d5=#XX/fcbUg]7GX[<bDRJ)(AR]2eY^>dH-CC(2RU
e>QGKVTeL57IA1U6K^R_6A\3PRZNMG23e/0+:DQ/FGSCI@JfUR+_MVYL(bAa[6Q0
;aRSabD1B7Ugag2B1&85-P>.a5eWe=;Ug:930]#@.Xc<9]K?]^;8VR\Z/eON_[dL
]J[9NHcXHB#BD-@IB63-+>_YW[M,7RHY-B2KM=47PgWE_2(>2b7QEWIZAM9d3)@3
F-KE+ZbBgcE#])W:0I-=e]B0Gd<-ZX)J_2-@gYd0[055\gAU_.V((^02K6SW:SEK
Y11GDE7&Sb,R?g2^##K7a\?A=#7\XMM>51[ALBbQ.F/00&L2a[\SPMH3cS78:d[0
8BM&,##-:\^+1_S5R]>#CCV)T_9XX+cGZ@G08VdGIL4#\.=.dMcIc@2+#e/I7NZ.
()(LHJIA6&cYDENLSDaHH.-2XJ9&MDVA-.P#cAIDbD6JT94H.<Y2/V[,WbX65b5Z
=W1P#&8QCCfW7I+QbEbLP7fIM89L1SY6:P:KHVOY#L]RE0f0_[S-&NTD+R3>CZOZ
Q&,F;8PQ2^aK\4QKZQV_-;OdYa]R9BcOV>SDGN0Hg2L0W]R2NY3>:X-;9?eSCD;T
@\WV,L+7NH/62L/[),XWBF?,PT<VXdRdeMY^E^df4B4RC398QTWFPD<YVGfA\K<5
IF&bVF6/E7+4c9[AJOcKC2Ac663F]C.AF3]_CdDQ=FU2@-<IF\8/USRS9.?JG[/>
[C+cV?15@5gA/VZ]^7RVC9JPJd@=f,cM<Mf<R:-bU\7S\MQ+c>W>[5F4?06a0U5;
LA6@>K#;@.;5R6>UC]C<&,a6^5P7\0;0@9_=_Q)1#&3PY-B3>eQ]^D,Q8+\WgJ:[
d.RV(V9)7(X<.CPC@g&9_YFFb\@;bYbcXNSN+GB;LWXXO8[+efd[>\-G[K(FXX9Y
WZH^PSOV]F1H7N5SLOgdJQ;3QJU@4M,-.221GU@_YG&a/QY6VQ(\83Z6dQ-(;27R
:gb?b=<00,/XE<\L]RdEb/LKZ5[NX:B]EVg\BdTc=GeXd,JR;fE1L\./Tff7LJ.f
>2^Pdb5a#QaXKG6WWS&c;F_>]/Jf6_G6X:/#Zb>\a^8-B8U2^K==\W;38GK2^&\U
=)K1QY3FPAEG&ZCW2^bJb]D=C:IUG^IM5;HS7@1>dH.f/=GU><:<QUO-_;(c>/\c
@KSPAJ4[7E:7[;LdH9Jd5gI;KB/S@?gG7&A]C:#DR.#^9UMS+7SaAU/M6=5e_\U&
=3dZb;3IZ97J.53VO9R[a^@bQgdeZB9e,<K&;8=5/?N^.KH)aZT9\e:Z)8KD81G[
,4[4+RB_Td7R)+]e+D..,=3-,U0_LG2dPO8_AJ&+](+RQY?BA1-X@Ra?SQPW9ZW#
ZVU(520:58W6BH&M87VcOL-X1#\Fc#_1=\SWG-HM3W^Y6ZFG6;_Cf,(VKfWV)X8=
;\Q5HX#XWdHCb8.5KU4/C\gX3<9=W05;XE=9L&JL<9629JAZW8U48aWVe>>02K0R
782[[0Q9F()R>,agQ6Mb,:LS.\;Z)[G@Y105[WC6BfOA]W(&_/@\>K[1VTFc,U6d
:/DK1ObN8,>UC/;PAV\/F_,e-,gF0&PU5G;/\KWgOR>-T9OHH#WUa4>NMQ;He-dg
C\5C:dGL5:(]AYc5T8)H<@/(KU3B[6bL6\]M2dc]<=7-UN-+NfF[4AEN75.#Q25O
]:6UZ4XW4D9a5-^eJ&2>bT2K5V]L[48+^Qa13P&NHT5X7A<J-/N,RgdZGd/71?=C
C1H=G1#B7CAXb8GSD^=;M\I]O1_MfFZ;&B1N+_P#FQ]N)e(O[;1a.S+O7VG\cKA#
c,a2=@1VW^-aHR7RY?GKS(U&;UZTQ)J-I[CDAOD8^U&75SJ]YOIS<)\.fL<9E\KZ
MePKV^<4-&,Tb4EefYGZ2dHG;O#@:JY0gVfOUYJKeSCFNQgC:H[T:>KJHH\<OCST
OB[/Wdf9cT7::\/HgBTfB8Q08F\4eE;^U@GZ4A7<EGTB.ODAEO\eeIGWZaBXDO\P
)e@4J?@5QAVCZAd+KKX#96/Q@6HX+g80cX__W4C\+f.^X3+M50\Mf=g?&cPE58].
LU5Sg/?K;^aUY;+FU(5DK)L>=.AL#>7I,Wb^Z&-+O##/C)^>>>^b[T)2G[D.PR-O
d&(RQ&g__Wc:UD2gR6HCLC[?K<Sgec:e0WV5.74OIaZL)GJ(<\34X&WUV8PF\2Mc
[:V.bZ5O,WVDWNEd^\PC&_0<aS0@e(de#Z:^XP.O2]ZH@::#;QH//LdE5X1GQL;@
\P6D,Q:.:6B8K@D\J[LAB4_#HCM>TKJO<7H5f3AQe]K<(6YVWQQ0]cEgE?K6ZXf;
b+[8BL1>X^4XTYV6W8+HFDXB_\&c-C=^ZR,(0-c5DXUD>[c9J_7D@SMU\A8=LWOH
QZ&]<,HV[IB\81gW6)[R2H[_b<_9IR6@:)W=#GK+aAe.#<HO(HYF[@c<8J;GC\WX
R=YQP>cC5^cF\6/e=[G^&)X&I<^\U[(ZU=(^XN59g-7A(_],2@>_Qa.6EVIPL/6;
L()8cIbEWNV_HBC5H1&<P;0DAAO9#1_e4_0RDaHE>e=J+aGA.c,bRUMS.EQ,NOE5
W++9P:F>OWT(8;_QJG:0:P,IE1H),_M+A)=WW#e);,WG#0,bWZ52-.A+bQe=D#)_
^g)(P+XL>_<O\OdZ\age-1[3G/FF[eTbT7/J-=HeBeP-1dH^_M[2YB?62a0c8<6G
#L]O^L@RH]G07R&.HG_5MK?&^]DK..Q/RMFCbI&?feIY;J[ZK00=Qg51Q;d;6R6T
S+:KA9F;[f31<4M@FQ;@H=0.<cQ[ZE@dF5QGMWIMPIP#I.Q6P6-E3dfNH(KgH7=>
9&N2+2[\@AI(gb+@J^3GeeOJUANSQX,8&AP@W#KT>>Y,\MM@=UYF^51_RV95a6CA
A6VfBb0\>X#g2CM>H,SZ0/^d<LIV0aL?+WF4^>^UbZ8K4d3UJ,BH&2PE><<UGfI-
T_X+]QR#d#@fORHbK99G1/V97C,SR1?I:@TPC18&5=U+.:1b>.QM/:04a@#HEGGF
<+XA\.(+_E\OAAgDfC9,NeR77;=6]&:ZZN-NU[)WM4WL.G28g9&]D-Hb_BVSb;E-
/YAEHRUM=BYT02H[2<=L#NR)&(=.BP&(JU)<0T0F8E>Cf//GOB@H(4FP<LZL3XIF
57;Mb8/R_4.VaVB\bO^>(_.M^&X<Z;V.M=.D3TB3?G_FX@8FC^Q#@3LIfEDN[4/L
_@M+Df>@MNE^aTbTK2]-\MTSLA1O,,BN5VF-;Q(OO/G,>Nb]=[AB2P@\2@5V:67:
=.Z&NI\V-U>3=9Z[,17B<FMQ8XTa:54^,QT#WC\FY68376UY.^f.:+^Tec?<FGJ4
(2=>5JH=[?K30DVV(Ed:>=^G3L<bgK8Jaf;=e#,]3/&6N2CJIb76VR=<4eX&aWC0
T;5LfO>.MEcCa^:70c,5&2FIX[E@:+,ZR11#&QHR\PC&<dV1cN<e[G(c?e;f#eXb
)&^#8;=V@4()WE_3HX:-Tc(7X:0S6P0-M49]a^1\&gZZ#T^f1/cJPSQ_7]+J?FOg
Y>e0&K2W&7Z4Jf7)RGSf1]2&U1=8VEaaGe.3HV=0R&J.g43M=eR8FgT+V/b>R0WT
acIO68O8H.VEWM++^Eb)IBKL5U:[CL4>3,E^O;d5]>W5JB^?:_<L^6_4]:B]ZO>?
OGK+R(f##_61#+K=GV^(MMDQ;ZHW3P]/J6)K/;NDCfN2-&CN&>X)R<3-AbT3?TVI
613.9R(gV[gc<S@391&.,]KUf))M/HU8E3ZS6V+?0ONY->+(_#G<,KXDS?(2O1\_
@A,M)52VR#(8H2HKafaT[,FHU].0/P5[5_V2@]&\<,WZ=e93IF&P:G@.],a;(cHQ
ZOK^W,gTaGa&&9V2KW^\/Vcb,5Y/;d?1(7I9DG\6\MB:M&+,.@#cVR],g0fAPB29
)G4WQgbW=IM,3_bL-KEAW8WE#=Cc]>K7,WR]^JfeQX(5]_;bd)93IK\#8K@&4I<6
#e]bJZZKKC0VU4PC(&.#]2[ASB;V-2-9+Z]OQA#WDE?D7\Hb-abfXQJM->(_>U<#
N#WAE+MNb01^<Ea2NV:6>dBKV<9=6#3I@C1b>A7.8DCRf?-3?dB]DNJEK/e:H[D5
UPP=3DQALac&Ge+;A[=\\W.XD]Zd/dN4Ma6IS6XH(MgSY;T.&XGU/[Te@51A7\[@
7WF6::fTgdA>^b\O#1RFLM<\M(YXOL;]:[)b\e?TJe-V[)5f75HdDW/Yb-UXA1=5
EbRZFTT&D_)F2eJPfO.S(K,4D,P>4_#4@:(MSTTOgTNNB@E-,,ec43QcW6Z8Q&Ab
8R4.0IZ-=b\e2>a=,LZ=?/GIXN\N_-IP9=8_08UWaa_E<BF?5T1.&0A?P[7C5cXM
.X9(_KL>0IA,TNcMeZ##a046X48@B@:)C::)aCGLL7:cD(ZJV)IM@F=d2GA?f_dQ
EA9?U)K@T,4(Rg7C1Y#Q.]MK.\00:7Sa2,,XWIQP/06e(Z;VCHEdJ>K)6fgfT@O_
?Rc,C8e+_,2M&Z7I\.7e9=eUc&eI_WDAFG0.@7X4XYdbQ:>O\FXbLP0HO[<4?7(:
DARR[+QSG0WU\QGG\P_.^I#5BO,)>_?3V/6=.YEOeTSe/BD1_\Q&G2,g2?2L@T\+
Eb2U=3W4Ga8f?)=cc#0LH\MCD?HPI?-dZ<PQg4([\86I56+<SW)S>=GADN?KCaU_
.:7bfJ\8U)5)XWHMJ_87g)>85;?BQ>b)-Z3UFY&=PcQ<\=9@G6W+1DU\gD.1,5AF
WOY6DfV@U,;:&9R[#KKW83P)].02.eeC1V0\L6;);gJ(YMJ:Ad6R2Y-7>RR@AV^&
7g5@4R?>9(C^?e=G+-CH6edWH=.cEXD3E1J8/DW-4X4R0YUE;CPC8>4#?Wc:Z:Sa
cVN6U&.MA,D)#&YT\Z8H5[aV)#IK9dIZO?+=4fU]7>I,P)4BP>&FM\;VeR28]X/Y
0FZaK82Y::/1RIG7-E6TPQ#ONIg84W6cFVKKf&D7)S?NEa\KBQ+H0PJaJbBf5<+F
<6;QBFa>H>)bVUM2Kg+IfRMQVZ#2KD8W)L[?@,&B)YG4^540K<LAC@3;gUNHKA,>
J(_^)A[C&UWWW]^M0PLb@W7A,XU3N9@cENIgb.e-7)Y;?Z?6a,NBdAIaB+&#R+Pa
\?K^@QRZ_2[HMLUYJ=S<ZW3M>#1KJ6K5N_N)8VM3O\T?24U3)>4,5R.eDO2GcG?J
E.0G_?Q[65YSgSYVIdZaLT).WgNKIAbYAK5M:+79;LZN0f)\<IbV05H_?;Kbb6GV
RL<6eR^(&2)VU9DJ,0X1[#Zb5;0HN-/.9:3aD+<,D;JYWH,9P;f_H^,6IJDA+1,T
A)L8_/?K;C1-@b4MXPL7QK,g1Xd)BWO&Q?>;f/2PH.YAX=CD[?f@ZIZKT(L,P8aJ
M9(N7L-F[IP\:BYD@G9:,dI-AC:Y?F8KWW#F(+FD,_^dS-(I/;P8Qg0TMg\Zd+\5
<AQXV3E3>;3>KIM3#3BBR-ZE/a+7Wf:dBKL.WL#^Q8;=[\#+4:RV06._D.cSb:If
eQ5F>94fZ-R>1,9PH^(QRQA2>d#S1F.8TD,[U)A]G\(>8FDW//H:6LW1;BKSTVGL
=TW5/)V0I;IT+DH=EFXaF^=Q<)395LB>V>cLA&c6D4,#]GC+:c1G@:5,O?9<F-XH
-RGaN&Xb#:/7^.VWVR_f>>27WZE@6\_#/CeZ4bP5J+OVbN)VIV@BXX_7WVDRPU/&
;)7MDC<c;bR,H4cPC<4Tef\>JTa0d=Sd2)KdG3[+FCV/9.(:VCDS.+?GF5a[X8gM
;/J[B2FX?<aDUc,dFO7.S?LS-8698=DNIa8Z;G;d](@4bCQ;E0P3B@85LSY(#R<g
@La]BB_8Y/3fDC<[2[G.dPKH[C#HZN#02e<,HB&S-_:;g^?E[/_5^)ZP#d#Y&_-J
]AM#(G_11HdgXXGeF7\4M,15ag]N>b)\edB)g>;+5IgLCSdYJ<8+@Z69=FO)7SI#
F3I\XQ^HGfJ<>\6_0<([e.>A\H3ScNANMKP=L(fRd9D9I_<L2@\EaLP-X98F\N&2
,3fK#.CPbD6=N42M9I([?C,RX@F^F34DPZ)S9gb:YV]IG^dW(ZGNPLb95U^8>+&/
g(P2[M81SN&8bF)17MIf]F6YASLM:D:48B,_9&1)KR61YC@FM(G1[?(8H9783)?<
Z3aUE7/-DY8QP>GfP44G4<__+FC://CbOQ1a)dH8c;H.<FbC6(U-0TO=.Sf+;0Pd
,4->dBRKIIXA)0^?449W#\E:]A:f(]J-A,UA4[\gQ-.CP72+N1d5JWG/dTT&<VA&
).cU4N)].e.FQcB[<XHg0g?>4C2PafB-cg6[P9D4XfJ#MY^+A)(DC^C^J>IFfM6E
Y+J][7:VOG,W/BGU;V510TB^aN\V)cKa?DUA9PH\B\f.#]bMEUE/L/3VAH[U6,LK
^O]Wc5RM,MTT;#EfQ2@@/2]e):AIA]RNW9W/MaCFQ7,V5]T=[6C/bC)@]J8KBQYd
JaPD1NOd9;@dJ;MYBOJC]c9(MC#ZGJeY5@<&+LP7;GMLS6U4#.LD\P&DAdZS<(DO
dV]7NSdGEdc\NIJ8<:C.<GAaNWQ:Ic<(>1T_6ae<TT0X1@^#I26>##W_9F&IE61=
ZX9Uc8S0-_KXZ)9bT00_[eH]PYC,YeHGe]WZQXI[-K;5g9)Q_R?0;#S+CY&OA&^+
PC0<RWZ#0VO_8?7,M/b;/5b7QJJcBKDP2AZ#;JB<OVc#T)f2-;P78ZL=_61\X(>K
VT0E#c95@MD^-dLUF4-6.Gca5Pa]1Z05WUB_T[)cBLR4=De:8E=H=GC1WSd#A3g(
FNQ3Cg)/XBCA=XDga/R3-HC@+#/S9b@gGPW5@,B(S_3M,#UN<9CbFfY&.e\AQ?;g
:XfHL3KZ9^P:L2JDEDXDUP;<Y<de>ULP2-KK@JCf8b1&,3C+e1D1T>@1fTX5/c2V
IUW4U[4/-g;&-cV#:W+FgEC?AKBF[(19JQZ^FZ6YZ]Y2ZBeg<@NI2bN&5:RQG#__
600Q]\LHRB_&IdNaCE3IC^S8MU#GQ,5c:.5>QY\E&T^GAN#c2)TKDU)9ed^HA5e?
;#7Q&AFNEGbS8:W-B1D_#55Z)/L4&M5M^VHO+bG_&e63&;XN.0]Q)RLDdG^+4:4L
<PE,IL0&FDa39EW>]_GIV/#(/]3KbcX_3ELWOM?aK[W8E96J&90([=fSMRU&:b0Y
UNTELeGG?93D:]YP]WIUC;2SB9]3]7A)2gP3aX6XY;0??3c6J=b4g45NGEQJ^4\2
+;)e#N,&9#0W90SNY>f7M5JLgC8bc_[NLQ_Y\DV)V:[FBIdb>R]VI=@E4MYH-91e
.,F6,-E53<>P<HN(^R[Sg-M@cJ>,21fEUJC>2,T[eAF=5<F7TTO&<;+JCA0RYQ#3
J?,UBfG>24&0&_H3_AQXIR_]MY3Gda/A0D2)P<SIIIMP^.:_W?:EH=dF3QUPP&##
,R+S>ER>+9NM5G1RT]SNNQ[QgfO9_T/GV@+;6WGWFM-T5FD]+Jee]/_BYN\X=+_W
.>c^FM_caH=CJU<LG_<&GUfA>E3QJg_6>7BW03P)]-/U1L5AH#3BK?)B3[1^:aJQ
RB,F-59f^,O8=IAMOCgcE[6;^X^]]U;F:0)EQP1T[;-V50-4NG(2NC2H=U9@<fV-
EMPB>VdWHGFZ&PVO40MP][F?Q;68>H;2;EA-C]25&e&C67.O1@ZXg)3.;fM@XQ(,
MWC<;eE3;dcM3GX51#38@D8LV<XV#E3#^R9;2.Y;8f=F83]&&Zd85YZZbQV-G[,a
5cGa0?2U10EGaN]>QRZ<g?A9.1D[X9M#YJ1W8@42ZTZbITf[T>:?V_5b0P]:7cP6
?1_1@G=PTROGJ.YH3bAE?G/1g=MO\e[A&^4g?d/25&EAb&VU3B[)AO-OFXLM^2]U
a;46,;K?E#2HY#[S:WGLRZQD<15=&H37I:F;EHPQOY]Y_aX)53^Hg1X7,_OH\LOT
2?&@222dO/X-9.KUJ^I+(5BO?d:[f@W35cV2B,MX^SKC;bK7?40L0_(C++NJ_D2d
H3;GG8KYU&)P4I8F4TOg7eFX-SK\_ZEPfXX:UP]f=\9<,dEf;3KJ7d\T2&J<;#(M
AcM@.M55[BO/1e0?N.UCOM_-LgN#,8\<NLA94(REKF3N/)4I9(e<gcQdX,PQ\MRU
,OB\b,Q4^CI#O<(Uf@-]?#3d8,/Z5/WZ67b,R/V+CHKBV-U0H6TIT+e)AWfI4=?B
b5C47NAYWESb=,?aF+(XXL5W28Ne5KFc(3GXKFDS9@TE#I_XJf86a^a+[P?f;@5B
/)@(ULGMNJ?P5S(>UB@LAF?G@EN0>cAA9ZF2#O5]Q49U[]EHG_HaKK>FO/#_:_E3
gLUV2SX5^QAVCY3A&Re?>+O(]7RUVH6<_\NM>ZZJYR(_,_&Vf;G:7T>4D\:6-.K=
_4#CGZE&Q^\Q?f@@N7S-cZd;Zg]?b:(,J+T:V^FAcXP._b4e)D3VeYKD2[(X8T)c
_\G&0c]6J,E>9G#9E2X6C95[e]5S7\GA=.DQ]Z\B.SdD/-.+?&BeE?#1-^&V7Q&K
(L&EBe76DbfG0)E/QR?8M;/@KD8KD-)>4b]H.I3:X#W:7T:QId^5C4#V,KY0XNN,
b8Ra\UM+c+2-?[YPL[<^b4^MV\]WfV6g=4M3::9^(J1c82F)BXYG/HIbP2RTVT0U
eL6)(LOH\QQHN(Lf[QcNQ3F@I^?RU=5,YUc(@:aUB\Y\(.AQBbC2J>Yb<e3>0:+;
D5-)(M4]8L<L6ZK257d#VOgb>HK4@3>9R8X,^.8Ic4.Ie=2[C7d4&[#/a3X,Pg?0
g+4XEYf/UX2_MD\8&EX3HJN_M3WBWSG/\961OAX+Y[6YCI7C=?gA/NJ^3(1,]HWD
=F,^)X=(BHd0XP;6eBD-WRN>#G9[.)YbZ#PAI?#ccR61,W#4NeG7-B9f/V3W\N//
;:P6ACUF0dCXZ[#;D:4GB1R]-9fMSg,bIf+a/Y80(B8_a:[03XfXfJPY?cEc[S82
4;Ng1?<WC8U:0dZ>3A6eR@ZRc>AHM8g-aZdaDO#,?+:K7O_L>7Hb2QR\B,Y(YM9D
3F[CAdY]?H<PR[EbKATdQTcFO6Rc-d0<NecgOJ0]WV\A#.O4;M3:JB]GVQD:0c33
c#X](aSa99N2810>fJVE-e=E3fR?7QVAeeKY]9&^P9M_]dSbSfS)0^/G#.^@CXUS
AS_:.3NGE4=_cReJOAD=dIY327]<O,BEK/&bZ/:b[ODCSdC?c_<:CC>gCRgL@ZA;
^>3C1J[=e)M.5>E-Ff.V8]NPf?5<^,[Tf/9WIAV:Y=g)J&G1?gC3L<c\<1Wc5H=R
g<?cI+^_]:e<]=/G]^30B1Eg6fKT+R@0KF6SDC1PY#d7;8<MY@eS25K/QO83-OcU
7&SO_=U+=JI58:>1@4[Z#;HH+/YTD)QRcWH16g.DM<Mc1HT.#0e4K,[E_G4941.c
N;O[#CcCD1Z;Y]]]^A.=BD=#3)_MVH\UM?.6U44;23;df#?#E0N8+E..\;+(ZOIP
DZ+812S?aMJ,EH2>;U5.;/@8/E.XA4f^.A#C&ZTfKRB?P76027Yd]2:9&B&Xg3Jf
.PVB-Y8UZGJ342SgKZ81S8,E[Z<3HfS1:A@@&(]VH1,I-MU0VJK;+BA4eEWJFVSa
gSCTKBVeY2ISBL5LT&O,QdDR/\7@G:FQN(B=9afe:]J3&^bB19[8O]JHN4[8OVS^
b-KM\H,7UDgX.62RbTDSA-.TRPW=b+]c680B(4ELH^f?(&IgMN7.-D-[C_X)L7G1
S>-E>]ZIJC<NNW9c2\3QYBB5E?].D?DUS\.;@5NbCf)LD=RW45+WWIgXdW&D>4-]
ENXW=Jd[Q1TS4I]5:>EcV4;>_,N,HQ:HGE]NI5^&eCSX)X6X3&0&=PdR-CY7:;XY
gWB=\P[W?\P]=IPH3]ROcS/U=^[I&-4WJ:a]aXgM:F4/&VdS,ff+/BTb44d#ZLST
6C2LbR28dA?bQK9BTGUS94Kg6,:aEX.9[47?^Z9(M1IA3CeUT&G^,.DBWW_BTAU=
e0>ZU7=#Kf5c3]+F<<8d:XJ>D(\cL=9bHZfgR036R[57>>L7F41-D>10-C?R50<I
_]<f?WG+2@D4[1Z2;E\fG#O1/e.ZT7KW^/=U7JP+FN&N.W,d31MY&@BJ4I+aE&LO
R_HT)2cI\3XS&<834VA5_<ET\[90F#)aRFCLV673F(H3NY5M(59V^cGb:VNgD.aX
3(4@6C@F5/0,dTL&LILSN\L@8CfVF8D.L8R,U?KV@0K]GOg(.,J>]+A/9(c&#3FB
A<@U?I#QC2RdJQ6;a85DVfN48(.4TOcXbNC/&/T?Q>VA?[e+L5V:PP)cI.(]>,+7
P/6cT@X[W<Y(?;69G_CD#_BRaK-G]-Q.T)bZG,ZZQb>F&+b/5a:@Z^)[JBY1?c:K
OX+:0e7\Q_&b@LK@GSa2TZ=RUX?IXDJ<[ZQ\=Q-1=b9NW2[WA@CF,T,#-]g+bE@G
ZREU+NbKIBP+608ZEZ75VLeDbF;:S9^=SYfSgG6B]8aFDaL/[eFM@(C7\2?]S6I1
OZJMB\G/TcAd4e05J;=41bS9g7fISJ:/G3JE#UHHE8a5?T@8(V7A@#>O]B<S?a(2
Hc_BdYK4<EQfU&G;Id[IZ&e@Aa<.IF1Xb)-Ef6aOeB7/?c_XL)#C1(#@&KE]Q_AK
c]#1?C.][)TK@QG&O+FA_NY+KbK^J8R)HaMfNRfAE2.D_H_Ae(L465TWYLT#LH)L
=e+#.V_Tb:,I4A8;T(P;\-N:5LPX\A)JQN809DK@T01V/(-S:f0bDT<aPL#T<0Y[
d8[fB-7a+/EJK+gDEC.JOX^-c9BFT-X_0d.C.]S<eBDN,^O01(L-J-S])d:eZdYM
V-gNLffLDdY2-5UbAT76)G27@>.FM&#I^G#@T2T7QPB(;:V?ZGF3Y&&HUB.>V)>E
D:JUA[GQO_EfXVQ8d)IfVaPD1HIRZ/c9eE9b5;P#T8XSNWaWARbPT:6=Rg\d2,eU
T7f<23&/6K2:>@B,9g?)+2Fg=+?DY23[Q8_,<d(\W1B=O.8XNT5VcM;MGWS3)\aA
5Uc4\_d46P,5K=1UV[[<E;#cd_A#WH;<VdcfdbgJ<(69V76]KS<PN(UScS,<eWW+
DaIVYH5@dc1.I=GKVaG;[.).TVeJZ0HR+/(gc7MVZ3(K1BM7eCZQUf)V-9Y>XI9F
XgMHT=((;N>T5aC<E.O?VNP812_.6:d_=d_>AUT6c\fO3JLR<BJF)=7e@EP4C?9,
,((H0RP6CNCUBFF9.L?>UXJ=Ia_=W[WSAZ<VAFP);ZOQb__-bWLC@a#5;&9@_/gC
#RQGF#ISED6Jc[d&/AW0UG&=TN\^EJUY25/K]IU685F9@aQ30ZKY1bJK;Jc75KN=
,-IgXg+\+Z]SX6(1b0UgJ64#B51Q2fgRe_GH<G=+baTcb&?(@D8Lg@E,b<2_d)_>
K6c;\<2-[M:W:>/E,g]AY&</>a7MHgI=[MV79@X6a<T8XXO#;4[dE6K^IKV4TL@F
WIMXX8AbR8/F6ON=VP>AY@e<dK)V>FTA]YWOGd&WZSO.+Mc+)<:>8;Q3)[1AR@bC
8.ObL,A1=1.<K,XBT5/Y?;,aWJf<A,[9RP9fM.E;GOE-7>5)aK)-/X<I]8UJa.15
:P_N+17[(#L]5E#891@F#a2I;VB3OWScdaL+cJJUS)>:46c=;GfGC:G[Zeb,N(Pe
D4D;\BO182RW:+:4;813Yg&2Z4b+LYWgP5Y&:B?#SSedAU\S>cYfW\W_</\Sg=g;
M0(((H7:)))I+7@E;X.U,EXgSH048d[bX4CNV>H=g=O@;aI64T)DdZ,73P+:J5+7
7(-Ta9\M7_:Jc)\-3[^@I_D@/Z50P55G.1#^;=&HLd(VBV6f)DfN&_ZAdbL@3L:4
9fK=^?1g9Q[]NE5B0[g_BT=#UUI95#)bGL/_1(LN_(QZ8GRV[(((ZOgNQ>W-56UD
;Qagd9G.D/;<#MEC92YT<-T1JDABb0c^GgE_7\=V/MA#OGR(AD\BUVGKO/d3\8TR
S8AUW-L>UWe8#2@fZTWR_8aUH1dKA\LD30IFC>:V^LfYA[+^NBS;FND8A)a>\8dg
P;4@L_GH0OP)74^W5UGCMG&a>0d)#VP.^0K..Ag)I4RA4F(6gHf6SE4?^_CgWc]+
Eb]dPg.@=gC?BK>c>[Z]gD82;Y8(IfBTS3G(_O6_G@AYc[,9)_:_;)YIc:02LK:]
fZJ.f3+.,)9bIc7/APU+S4PJc<3b#VRdO+KC\>GQIN#,(-MIG(Ia^I9^(I6U(e4#
Dg8BPB^@OIC0Ag1^U(K^<@agAgKWJL6=b6SQMRW5BE6K2Z)Rc^.Q=+aLcJL8d_a2
(I)1ZPREAb>;AT./C#1@FB.Ob^VNZYY192Ub@_+ANO_RRU68#4dN9Yf5PTOV1#UX
L-/b4JCeR5afJJ-L_bYU+83RC3++e_c0/W);774,(Sbd1R;;\7,+;\O2fdE]Z[S?
D\@E58.Cf\JC7)\.Q&F(1aJBcKW7(Y@>R).OCa=PV;G==TQ;2gL1?(J?BMa9OMR1
F.]Dg[7b7ASKLe[@;e3F(RKUWd;L1ONK3B-,PaUW4J?GcIN+0N^b&1Q.:Ve>a,(:
G(E^\GIcKgeM5J7f/V+f@U@Wg9#+<#6bTfa?OO.7#X?A8C6BdS3=+L46/8]]XM-A
ZJ&]&B9=164O-b[0A3UXM<W6K7K:LJ4UW_ID0aRI+I-c2?2Ug(g=F2I?2&\[\G=U
LbEfR0/L-:9D]>ELg,PA4,,O\K2AOV<?OT\8[Q@>J\=g:MX;/g.f-9>&Da[15:0A
7<]I5WG:R)4EC)EYQM-QVLLR:TW/.7C]<^JcG2T@<892VU3?/]]3^.1_0&XH\;=c
aYO?(^0,c_cBFZBMbM(/Gd^MN=+AW>DCg1FcAJ^C-+;E:f@\F)+aM(Q4]L.e^@EJ
N6]W\)d8@RAH:(N+LYeJG6c;JeK3d3R7Q55g\8TI5-[(RR,Y@7VFCRE161gd9C-Y
>a#9-YV?@)FBL/dL?V6]2JH/cdOgY-T(AMGK+02-KRS5H+6:I2CY/,?0.;?<?T<>
aedfXX(UAY&IGVLR.b;SO+8..SY[9MTFaM\^+8MBe[,;b-C^;:G90U[MgVZ/;LaM
M7e=_HN^YH;@XKO?b#KBBMLS_bg>0JT[H^PJZ6g>:F]]ac(Q^>5f<RFYg6XK7B[QS$
`endprotected


`endif // GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV
