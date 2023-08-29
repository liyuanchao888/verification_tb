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

`ifndef GUARD_SVT_CHI_PROTOCOL_SERVICE_SV
`define GUARD_SVT_CHI_PROTOCOL_SERVICE_SV 

// =============================================================================
/**
 * This class contains details about the AMBA svt_chi_protocol_service transaction.
 */
class svt_chi_protocol_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  typedef enum  {
   NOP = 0, 
   COHERENCY_ENTRY = 1, /**<: Guiding the coherency state to enter into COHERENCY_ENABLED phase. */
   COHERENCY_EXIT = 2  /**<: Guiding the coherency state to enter into COHERENCY_DISABLED phase.*/
  } service_type_enum;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /** Type of protocol layer service to perform */
  rand service_type_enum service_type = NOP;

  //----------------------------------------------------------------------------
  // Protected Data Prioperties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges which insure that the Protocol Service settings are supported
   * by the Protocol components.
   */
  constraint valid_ranges {

`ifdef SVT_CHI_ISSUE_B_ENABLE
  if(cfg.sysco_interface_enable)
      service_type inside {COHERENCY_ENTRY,COHERENCY_EXIT};
  else
      service_type == NOP;
`else
      service_type == NOP;
`endif

  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_protocol_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_chi_protocol_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_protocol_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_enum(status_enum, status, `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum(service_type_enum, service_type, `SVT_ALL_ON|`SVT_NOCOMPARE)
  `svt_data_member_end(svt_chi_protocol_service)

  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

  //----------------------------------------------------------------------------
  /** Method to turn reasonable constraints on/off as a block. */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging.  */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_protocol_service.
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
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  `vmm_typename(svt_chi_protocol_service)
  `vmm_class_factory(svt_chi_protocol_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_protocol_service)
`vmm_atomic_gen(svt_chi_protocol_service, "VMM (Atomic) Generator for svt_chi_protocol_service data objects")
`vmm_scenario_gen(svt_chi_protocol_service, "VMM (Scenario) Generator for svt_chi_protocol_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_protocol_service)
`else
// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_chi_protocol_service, svt_chi_node_configuration)
`endif

// =============================================================================

`protected
L=.^\<O#S&#DSEJ#[QOHHTRG^0,08Y)dcc.Y,F5\JZA0<N2K(?4/,)1^9d[D\DG.
QS4M\QI&d)Q?:XHHdKT:g2L@0b,-KF:\_6&]9</>;DDENPQW+:HM77(>JMR=H]9F
J8F.FRIDL-O2#6_9KXPTe^Ma@F&Z/Y-QbZP(Gg4;70;<9QVB&H[DM9?:/-[W;H/T
=_J-+7CAF[B&[5=0&W7GBWQ37AP&Tg5Y9^NK?B6(=VV:FP]cX261(B/1(BL53-I1
T^>E2:Vc[QTQc2R63LVWNT(?C].@ITP+IDCMMIL-\g@EKV8W4^fZJ=;U7[1.2a+&
85I6=06DG?f6GC4:.aD&QXRF:,8@fO=I5FbZBV9N<)7>^U5[\S_@.U5#4Z>8^WGA
BJK,0eF/8T&^IYT2-=VG[4T5?88WR8@^,M7dMET6O]:8WP_#O)1L-FC-dJ/1(IXc
@3DTbT6#^6EXP[KG>(#JM-S3?#?R?f#-FHL_+<YfeR57&DVPK6bH9RRNV7=G8>C5
,,?S4DQ3<b=1H[C/>gL6e\IR&gE^FA4I>47AKSRXQ#EQS.XC5LDH(73LE/PW4G=/
L/\A](^bS24SI1_H+&U,]dIEgeFB2<LBB&]J^EPGSMI&dP@1N)()0=#f@,eFg8_E
4EJe8f4+a=f>JRR@V>e:E)99\??>EO\X1JZ:0716(MM/FLH.KA1<dbU?FcER/U,;
LXV@;H2BfQD(c7\HE;&X+ZMBLeYCM3-RFAde]J92S;K28cL1UX=Q>];=XR61O0AQ
_Y04&->J\Y[PYfSX@+;HEA&Fa?174C7G.8\5&FR4)S4IG?R:9)Ef7.dg;4(9[[=]W$
`endprotected


//------------------------------------------------------------------------------
function void svt_chi_protocol_service::pre_randomize();
`protected
AW)L:@E;)V#8(WZE=JK?g75R<8]?eK#H4A[:e\8YcaO(4D,THB]E+)#][#B?d6PM
YKVB\bW7QHC-^a7VCTD8R0\c]IRXE3DRMTI++)?-V>&EZ7TL?C_(5W)YYBcGPPI8
I\aCYRMZ98ECIIbNFUC?4U:aLLEU=<A/>Jc>\9L[U@,2b_8QS(QP?;^MLD-7B92Q
Ig9S6EeJ/QEbA)L>[0:Z4L:a2$
`endprotected

endfunction

//vcs_vip_protect
`protected
AE)4;F9\P1[-9(Q<2YJFG1MQ=bZ[.f6R5[-,22;SRV:Sa7D.L8:N1(1C1Xad[5+H
Fa2WKFdM?dN+-RUf+5If_5&g[8L[+/Q0gVPCC]+FR9WPR7_IRZ9.?Z7g)bb<B3.W
f6AH)HS-IFb>L295f-[19,gY.>;a:D_JCJ)91.34P_Q2A^,6=g&NWA:J::Q4@a0/
gAQEHWU^<:.[]]d.X+D#44^cC?#H[/3;MXL[>9fD]/3[>./D5.J6\a.(5ZSX8\F(
>b\De1OG,-<9.fPf\:^PH7SLaKM:=(P<&]I\5H_;dWGP9bWI//1==>+H&QW;<,,G
EIAV89+5OFRfU@J#,O6f&HJ1f9g:.W0QS4ULV@OZd&/D9dMH&:L-PY(;RcDQO[+7
KR/B2TM>01SY[HM9d=03X4E@_I/<+0&WB>c7eB+cW[U\C-#50_b1X4(S\C,M:6GK
J=].93A]#,cB#TPZC@24gKV)Y.9Ue4_J>:Z1IU0:;?5Q8KWI63/I?+N8[T&?KP+.
S:6L=,<H,.ZX^+Aa0)XBOAVBB^G9X\O315]BG/969g013>K3:bZ&,+?Z-BgY3.(_
D=;&cH]0^&]>H7GE6@A;2SY71PHH)=WQfP@9AJ5e5?fQ+5B;AdIP&29#a5,;+EO1
#M5HK1R:3DX&(.)cWR2?ZE_YJR_a&-dR(DXd?YKP)8^)+J4<X7_ZgU@3ZE7;9<Z@
VL/0<.Fg9OH8cKQO+KW-M_ILNX,YQJSQ]4#R\8D7cH\<0>X3876D0+2>H[\)BcVS
):Y)SS\bd3TGMZgdWf3-,KR-H+b];Y<9W]CI-6967[0d0TgRDT8JaeL3Ng,J58GN
_N@,I_Kb1?<T<gPK-\QN[2Q-D_7KHd,Y.U\+T-XeVE[F<@AJ&4^84H^1)84KMA8H
fJgLcG:ETf+GbU2?^J13CQTc@PadEgK<B5gLCc^U/CbMXDQMPY;T5aTZR/a/Y.5.
7d&6O+(fTYdFbMRB\L5_Pa&@Id_JT7N8YS\f9&<?dbAc87)b5.WH0JCHTIP0EaNY
eK&fEMDJ14\7W1@]Gb@+H?[QE^)?H>e,QX5HN(^J0aR&RE(]DVYD&?b/3.11D[F\
,=\_>Q-+/Hb/P3BE(3(.-L04&+WMg-8&TP3DFB\T]5&8gV0Pa9E?1>VQ)Db?L+_T
SPN0LU_16)THP_ZIe.L[+7;QU=]1.Qd/>G73UR)3e;+,W>3,DgQQ0W\Xg,c.FVKK
^_AcOA6?=cY\[eX-aVV+I8E-AL9T>HP&#><C]@A;&gF9[fPN<C]1?C3DO0LV3DB]
^#7R.SGfF,gL^]>a_/CLeN.@)9I<O,+MRWWZ=(;,8fGABfTI^1-NM9+fOU1Y20LU
HJc/1EN,GOMK,dgZ@1D<g1FX[U?=5/]C^]&APW\-J>J,-1#_B^?A;[JRJ;S9[?@X
6A/5?c+.N:6EI(/I_b8A?:G_.TYO8.AW&IaM8-Y4(e(]ZfE8RAEL]JD6a+fA9(6F
FYY?4e6HH.G&A<=Q60F95Z-XcMH8/;28cG1dSXU[TD)]L<K^+/L4W^aE=E3M<2X0
+5>1:#+G(>b+Y^[+=-VHXSb4W92dNgI+X^I#KSK(.J5d?Y17T@10;cW0SHL,]HC6
I@7XMX&_:@Z3b,4K/?MX:EM>dJYLCGT.ed[1Ub9.CW<5W@L8C+7/b<KO^7G^=_5C
dGfbf5a3?8eL=,>X7)eMRfI(dPA(9.=5IU8,UHQ:d/ML27ec.Z0eFV4[e^PQec3.
V4Ef[[/8])c(\#^>^Eg-aacO,HK>/TU3)&Z3@@].]gaWF<.AQ^f;fDdNaM8@eM2)
(40O\fL<AGbIdeOL9.c8[C>P,UK(ZR=?5EF3Z_L(NT7(2WF1L:YWAa=aY=0)7-eV
U7b9Af],F46S.f.NKQV)e3IfZKYVCEN7cC,7^BM^YJ4^+H)R9)O)S^Eb/ZG46Q2K
eF07\3\a3IBK2@3_Ab@M]W1R)-HK#7[\8PY9>X=5YDI1PNB]BK.?JJg+/\&QP0_Y
<Eb4YDBAO?S_LLL(<WG&7>]T0dUc1ZD,c65c/C:>V2[8E>;H>FEA[W,S-TRTdcV0
^9,E:=YeR-8=c&K=eBJgDS@3F(c/4/2(VRf#J\1]+OAI2+9VK/,8Pdc8@1Ja7-]N
@+ZD4#VP38EA;bD4;Z.gCJ.KL]B+PWBFP,]A&9#4#,Fea76cRHCB&F^UMJKF&c9?
=GJ38^7O<&&3)-TGKK]F3[172RF:TNJ1^K&S1=3FHeM84YO(#?JPP[?TO7S=^6PW
;:R[7f^0(P6Kf##-IUNb;V6?073AdLVd:b10[(e2WQ\^LU,3f6DQ5QE+P<5B+Q8O
[XLgcF?2RML5gJ0a8aINI=)3=EWN_H<=XM^1),=WOa.W&P-7ZBM(O)D51\+I2Y9-
JJ119U</-OC3_+ZaaB0GOG@.RJ6JcbLfW88^OSJ/VR_Dd]NVC8dJEOSaDf?RbfY1
6UOg2,fZ8cSQPLa;7[:8&FVGOO6W0T1cX62b0G(]TKf@A:^L5U8:^A5U-6[1=#L7
d34\?_cDW[<#bI_cd/24@_-G]Jc>WFJ9[Ka(#&V]Eebb[VVKV?TgO\<HV+WTE95d
E;2-N^68FaHK1M[]7VT<b@/TdR[_e?@Xg\:c6+04EY023]M<eN&bG<X5fdQWEQ\B
@>dQf=Y9/AXA15FDTDP7-3=SRZY8201PY4d_Rg72MIcaNYP<S/QIBU^;F+ReYGN[
N:TP3F=DS3JZYC3CITFQXE)cWB?R2G.4=O.7@QP[INL5<E4aG6f6J\Z4f+R^&6VU
IT[_3Z>bZ/SJ3\V?(d;M/-Y=J4<ETBS:H0);29I7gaL=S]4WAa_OP8dL&G?[Z0+3
6fJS?EC4_[8,]<c,6OJH[_]@SC2U/E8N^,4WFG>)8MZ]@FcfG>HXS1LH+X?gGRaV
8Lf;J_ST?WY;KNX#:J3@PdI<I&P9NbReX4EGZ)X(Pbe#\Ndg[8KNDVOa7B_P]^9d
YaPRJ+CK06/Kec=^J^0/9ZZWcY_^CF5^T40,C^d:71?F6K/J9gfL]Pe#LUHD&+Ea
;N)YDYd2@N:e)b;ET4d+;gYJ<?1K-0=9(?gG#/[QdHGQ:46E0.HB,HC@Q#H\?\:H
\FS.XL-?d+C;NA>SS5_5R1O&4\XH:\U7eDSOg4Y;?UH]>UCRSV0[40=Nb:TOed+R
>X45eJ[:g;FHHZS&Qd>Q4O#P)O>HCeW>V2JcJ+F\OG;MB-e+WF<:-c?D1HYB].2A
a>?/#,eP@@OG9UZEM&@[95]7LZN7VKdE<LdDG\8J/6<IYe\=gJA#[+U\b][.WfbM
fdGIc@0QaA_4H-V9]T=SOV(<-8[=&&1L9&\>TYb4A/9,5MM[<=2H7S=PK#]Fe5A?
I#Q1_f0e)D262gUB=K:(FCOPG.[W1UJ>[15+S7HX)[KbU&-BS]2=1QXV-A-N.QS-
.7JNLN4^C#)B1PeEG+HefS\^S6;I9bKY);RD2MDae;VY>W(=gM.E8OR#^)W>#]#&
Fd52fcDCB-EY8cM8_?\K3aKD(4CUUO:Ga=\B1eH0L@V#QOKO@eR7N9[e0<M5fZeW
-ZAA^7;3_M7TMH1dAVXfA;fM>?PKY(PM6eFIc<?Y/?HKJWE&[10OCC9V/S+B38c<
.aXPbeV3049:K]5BDJ7/RP>CKJM:-dT(/^MZ>,@<e,,<T&(,#2WJ>+]e\G/<MS-&
Z)g65QWTcPZT<YG=J-:J3RKD&=S;QZ@?Gf3HQR,a>D:^TUHWgHCg[:P,6RB@.-#P
HGILX&?VF<R>&CM,Bg<ET4EP8@7=AUAFYa_4@M=PeNZD6_bEZVR.(geR#BABZ][_
D;eNMQ[>1\PWH[/;#afXE]EUOg,/-F^X\NSU7GY&4&/<\E.N)e=0?\(BL0O)M3(7
K-)Xg7E1L;CI>#A290E=,W4f]^+E,<SfA4c,&>gW2/?XFLeK70L1XC0Hb^J:A9/e
b\=;20WGT57PcUBbVS;0UA4KMFI/Y<6UefA?]&cQQ4:5\N)e1A@/QO98[JNQWAK_
=cKYU+=d(+bR^PM1W(5?IdU?QA9+.=\Pf@1#;?/_;O;,TUDa5K1T^/Q7+Ad5YC3Q
:NL<Ygf+=.GedLd=;fUP=Od^2IPYC,-g8.SUW>R,8^N#GULH\;KI.NRV[[c[9X]b
SQf@gEVcVV/4<1P1E8N.a7+OP@eMR#4#W9\Q1W3X-fJ3UO5UZAggFB9DBF(_#e4&
DME6^&?,V<c[IOC:bQL)9OQ8dX7c(YbFA>7Q&_&N:&MW-MW^>-CTX9^=+4IT^:_Q
@TZ)?K:Xfd>Db_8e9;Y\^@RS8/-]MRH+_,H&Pc1F45U:.;Q=^SL,HO^X8eD86E#=
c8b>BB&e5ceJBU<eJWE;eGKALIbA_W)SO\fd[/1ZYGgf[c+I@;1W6OFZ[b>3O?#_
W_A=_CCA\^8Rb@QLO.,Zd@f+9TIQ034WSPHD2T:PK<26;S?N#YOV>+>7+7RKI?OJ
afb\]L#3ARfIdc\S?H]ec-feLV.YQSO2X0Z4gS3:/,XQY[,USBcW6OZ;<P-[U5/^
6AQ>>e+b1+6SVb7E.#:cM/7]e=)3ZW=)C@?R_1=QTggcCd\SG6L;[d1-08,<d(AF
&d#WAJ)>OD3E1Rg<?Jc=3P4J?Te@fX+:;1:#DQP77,L)Z)(@Q@-#:8>c0+)5c0:^
==]TBG\0aAA=L(?HPHD.8Z?\SLL9a[?Y\I&803XcHWBIRL/8,EeYUCM;U.WSMJL<
2,L@4@K\N9C)g]EM9&M^+N&X(ecb07+<;1Y@b0DU@^:@9CB)e1Q4<AVA=H&d&f#\
Vd)6:+RO5DE\<]OA98O(2eG8R8VYd4MLafTULXg9G.?WaG]-,O.ZRbL#]\MebfCC
;feb^6OR_5a_^6^S:2QEBG@<HSLZ4^g<[JN=L1\0DFW\J4RfA^8^6;NIQWRN)eY4
WQR,(Eb5bc];Wba,GU1>e[Y^2)3OdIEL=DC:a&?Y+1Y)bMQdKI#TN/Ig+56[N_>7
WT\U1T]ZFH^/\],E+C063KJ;F/Y5Q^FQX5GMPV6O,SY&</G5>3:[3C]\4TBe^X:a
AP3eB2Td<,gf:+Ac.H(A,XNb-[E3(]N1f0EF6E2dAWfWL)A)[3,0Q-)2>)S7a;JM
4QfJ@GQNF^]XO^)Q\PB=C>71RXb4&8[]J#=:6BETX>VR?<Bd4CYEREcIZ<Tf05X5
.(c,eLG-2<aE][-7></Z\2YQeWSF4?37AFNPD4]NA]f\1IN75YK?H7K:FOHE4:Zf
3&QA33Z2WcN+bH>?8;eI?H4cC(^)GeZQe[Y.A@P0bJ^FF&K65MBI_eLDVJR;4NY^
f4)\-1ZQ/-:dBa,/6V:g7I?ZDHBH1-#=a4M(KPLcb5URTSV?FdDY2c(Z8N:<((GR
5g@]b8M6W..+=dAKOC62)3B[G8<1,<FK8\C]7:134KX>/\IW8aS58.8Y?_U[1AF.
QF:KMCKdbIB0:D5-?9?g)@]KOb@T-H=dL6gR^EWBATWKO;W-S[Y6b-,aI:PgVg-2
2]B-EWYA/R1+NC43OEb^[[X.BTM.#U#@_O=TR0+4e0U__DT@gI5?K5Pe1gL:1:]R
^VQ7XeV3(fJH8K9.I,O]<=aFOG7Q-:F\ZZdIOP]3\]K[;>C(I24Z^LE&+bH]Y7S6
,G-FNeR[2Zbb#5[@,FO\T_5;OA9AQeX6,c[UF\P-Y)N\#RY\09=:;g;S;C@F^V>d
]I2;Ad1:+TS(\T6ZHCI@>G+3eIf+:NJFL@UI0?=cMQHSZQGBd_f>(MQHWX#+6G7H
E5[NMSTU/V7#JP^0BN;3)X#.3-<V+??O+,]c7TR?I++7A=>P[WN<S(c1?TeY:=OT
)V.B_\A&eY;7_^-T,.#=XK4#1E4PGg=F;;Z>M8_8A-B4Oe@T(AKdggB3#.JCK:f2
2;P)_;;UEbL;HJ96[#ZKFQ3+_(LE/7RXER@+8J0,L6W^O;?>(1[GDT=PZ1>4Db&+
f9WR++W40#TH@F8W1:?GFf_OG\DX6_44H.6[.<?)&^9J0IT1)#Z8&/XAJ31IBC==
XW0bHEJ1V9R/-#KMWI+aQcY?Ze<YBK8gBAUEL(F>/4Dg4.N26GdaI#.S@F([-F?S
3TLHCSO(0cOZbG?gA<EaE88)CC:+2\2bgc>#>2PAgXI0Cg@HNC86:Q_9?f>P;S.-
DM1^EY>fSL9(_(?/a:>MEaf-eN^4QHcCP^-W3\L3HX5O)_[\35#]^4&bLDH;CI];
N9TUSMVC^DPNW>Z+L\@D_Sd5>KRPRFcC@?e\98[RAL?cLSMcU0>a1#b\<0-@<\eZ
WY(Q_J+=aA3WFW_6Gc,/BO5_Ja2W^I\_,UVSdb?HD9J?G10CA1I_(YeN)OFd_@S)
[T/WS&&VgZ,MH0@9^?dHd/:3-4:KFI0_AW3#RNH>S(F/:a:X-OefE1/;T&.Y6]a6
Ea4RMGb[6E[D>V&dd6BAL;GNEa,KCW#4e1KUF)N,dKOBcTPLd0[@;VCCg=#M^/OD
LQ=EUOD#Y:HYD62C]aS7^fWUDL)_FH_d0\Q=7H@_gTNSf[+ARUb4bVWE@F76Q369
4:2IC,6=FYF._H6NLW1F-X<_DN2IZL>R7(,QGda2#8K3dB-OR4[8SH7LQ#4GQNQ<
HcfCBQ)PN2^)fb0_UI>Pe(.WMf_L&U\3e9DM)TDP4<;36<Ub?GfaD1S:VX=&-?_K
5(FB=L[O=@(7L++=1FWINWa>6b@EX5Y]L<&ME#9U<V#3.1K6L>Y(H1[1ZOH?>;<9
-#=,^LQJNE)baHQTG10&K:&D;B&bc.&IC7LdWROd.-W3Wd4dRdIKN.X(UF4]27DI
?6JFDF0#YObJ_S#R_.4BO]@<O5RY&cUXI6ZF\1DP;=8?V/9VVW=CBP-AG7<O)0-2
?Me[>)4GQ]f=,T015>Y0K.G:2-a(8_2La3dW.,P1c)6S9g5OV&7-W>D1_e.7_?Q:
e2#4e;E>\-:5b^[9fARK.IbC3.1eN3W;Rc7UAJ9=>5K6^XgB@Jf/2C:#]?]>.C,c
bf0.QN\>_g)CO=##,UWcP#gS4=DW;>[DVM]+;,TIXH]3PBc45C&;Yf-YF_7F=MXT
TZc1fO\ME-Pg(MW5[TDE1RU=b6K&gSd[<:6+FDK&<?/Xc4JK@#9XY_X/X[)(#WeF
;1QTe@?gPb=^-T1D9XTLaHLfGN>PA5>#cVE2>WgVg@=24/:G4SY4-RJU?YZf;[KX
C-ad/;W4>YNMMgVHVWFSWfTREVH[\_GVQN+^]JW+BIBNOKf9fbM8))a?K@O@/35?
d4;8HCO9a#N6-M)LNY50RC=@E1PO=N<8>2^W599DAA1YB^9]5DY822aAAK2&IY+#
+&I2\DQ++/(=Z;S7f?e]GFf=f>)J]7N3^3OBQQM\8f()F8M7?MT:K(#-aA\D2QRd
=B:-BDD/QbP4GUL87,R2d@ZI#^?JH(Y/6=Z/I@)N[@=.&U7]E#:2PNeQd^(bDUG>
;XL6Y5F\gd;36>)cNE\2WUET&D]ZUECgXG<=V06;C2]+;ZUSdEDXX4BZZ#\E<;)2
gRR>ZCW^\WZ&NG[RJf)ePTSc;g;679N-e@#_2(5b95g#IY-;QE;3H#1eTf+R^.2:
.B5YC0N^fKC3(Y0)D9&)HU_M;LeX[)g)[8#PE9+dFW(&PRAPDgDBT@6VfX7f3g-:
O@eK3e.b)A)G/8-U<-?JJc]@D)T)6QZPLFQ//CH]Gf0>Yb<3ZL^QB/a9X0\CUd/D
N^=G.SAcUaO7#ND77cMWYX.23WC0MK.dDe5>9Y&),)Cd<Q9QDSWH(#)?X7BRB38G
E4CWF]4X.W<.&#@f,=&NgCU:Aa]MUgY#O[#5B07K5-A?Pd><8>^Ra-3OW:N#[=HP
_(9G/M:\21eZT\Q0:V8dE<VPYL&04&MSfI9<2\@&@@G#AgVMbY(]STBF_N@C;,S;
Q(7)Bd2(aWEG&5/e,<B.TUR,aD\^]P+MOc5S/g\N?T&6D_N7_5YZHM/PaEGCHO;a
^I1E;KV,4>^=eHN15=)bZe>B6TT>95,\BEVX3d&gb)c.If^;<XG^cYCR^,f.D;M,
FR.^a-db#I#ID[9c7[U#>5N.6S<_I0<4Vd8?7-:QM5d+gg]HHO]M:2O<7?WG\M[5
)7J^<],c<X?99=G&T;DO3dfGd2=R?CZY65]P4Qe\K[7@Xd#KfB?f./WEH(#Q&H9=
M4^7:Q_=>])e#N.):8,#B/0GZ[LVG\(,]V3bcPE=]CaRRN61U3///P[9&V9(OdbB
;_4a^&Q@4/g5Id_TCaf]=EEeg,?;(>?>BVH<E[3.(a293=0aOB==YJ@S#Q)&a;HS
b7XI@[O5aPB&T8#6K5HJ((?S<L4_aF@5T+AAe8_gfQI-1LR>E;=<E,(32R(gO<G7
X(JQe5W:JZ6@?:(3^#[G;,/PaO+7\Y4=,P6>9,6?PQ7]=,aMI[@.1G+5(H?S(G6Q
U[8g=3I9P:Zc5G].=Pc^SX])_>c_LI/.)ZT[?P7YC,Le)&PMFH]@3K3/0MJT,/O9
5B,X:S5VX]NIJ1ZdSc@5^EXJGH]7^JLe130JXJ-RZ];_Z^Y/T,\>[Z\9^\/UN#7M
OPL2bV/SZQA.67DG_>V(9-HBD3[JW/=V1\2A5+1N(@d4Xa:DFSW)&3ZH\?#0FJ8W
BgXR[:,YNJ&@>&;f@EH#eSNM44TC@,4fa3ba=KJHQ+a1<g^fV2.K/B)Y>42E<gg9
.0KP+)8a]NG?_\?gg;8>K2:#b@<G3(9OR8#5M,P25^2_f-gO\gTG2GGCT#Nb=1Bf
KO144>^.0=O+2J((d9e&Z-RSV5]T)+901<7:9[DfdfABbI#P[I.&3O6<?9OJ.L#e
K/J9V9,b=d-/4K]KLK&)&V-J/c#1IP3F6[?=4YT.S/+G-SK+6+/J8gU.3O&O+1aJ
&:d6d6DK9,46.Y=64Q7b3\G/eV.,C_USXMI4GRERI(XVSaU7E=BZC5a4.B(HTHDF
6Y2Pfg_;O&/=a&-IWB,&]H8cPW>CGaW)TK5D>.Ta4@YA2#KfK8+ENd6S__;^X-fg
CU3f]TXV/5D>ME,KO>4.9S[6:P4KSb-(.LdL=5&M>MeJb;SJ1@/+.FQR6ELPH::Z
V=6)2M]K^:+Xdg&9&X>@>S4PbTB:Z:,/#/c9.P@6=Xe&8\+>?G+G8\QYX>5V_a(4
1HG,,RFe3\4=Qa^PPd8d+4R\E6C>cfW.+U]I1bdPXC.Ta2>DPLG>ZU=-NSfDIHJG
SK)f53<b:UHO5):d7]_8?H?VGM#Id:4MW&gZR+_9W<<M40feA]ON2D-3J&X(9?_\
fI>;bLeAf[.@2.A],KB@<QIO;@2VW+QBIDbaE4S,N=Fd1U(gTOMXR-OSJ.LR6\Pb
)K:e6RacD#^a0aBWG^S+W9F@:T#JT:\-G^0<##^3J4d6C.POd?(P.+?-(J0MA4GR
4&_2Q6-K-;\T>97[+W\IFAB^a+8,,KU#RcAf]KSF.46D_<(?8CO[Dd8[(2&C4G]+
P@Z@OYSLM;_XM&,c2XOgb+\7>&SL#PKUE_G>99HMAJ?g=2/]a258Q46_;VA,UYE8
^Iafd2CG/I7#<X)J#ed./V8bW@FJ8K&Z8OE(5be?9FH(]b1E;35eVD8ffdNL,WBV
a>/#3-OccJ7\J@8NN4K<C#MFb6)eW.TNbPI-MHD^AcCdP,,YJ?^C^PX1b#>-2:DY
#]8cV#HA&cdSFF+7:f.T\+RJT&4f(U<T@</O<T@RB)fS+O<Pd-.^M>S<61)AVGV_
9+][\4OF#&[1MED^Z-ZEELL3\DJS?T/,8&&;?^[(P,^@=M5c70YY4,_e@BC[bG^L
?[,\8aMZfNCMK0/aMIL9U/eA\RN=7#>_8.6VNAcV<FE+7bd7dU5A(aDMQ[<;WC7E
ULI3-/,YF?)T]:c1a3_Q,>TZA?3S5D;:DgHNM&VF4GY9G<CTS^<H>D-BDR8MSUEg
95B&85OL9D75<EL^LC/adAW<g?QAN3aM?&bBJ:5W5.MJ#CQ4H(A]59cc9/)XDCeX
^RefbO)gCLX6a0L@:&8c;=c^08IWeJB-GHaE5f8F]OaIZ:86C4.c1+LS>E5?ZM\U
f36HY)1YZS7OQKcZ7g>:0?)SSK\:]ES-RX<.S]cK<X_bWI]Fce;4?1U/K<,)-58b
QJ.=8:I:0V=X,GN61#^UB@0.<CeRQF[2H4;T]ER2T9_P)=77L+T/#B)]A>aU=:bX
:0-B^JRdfA=ef7BN/SX4+DfbT&2bDa#:VF12R3I^5.0H(OWCbZ:F.b=]A-bG+<RS
aLI?DGN?L:<&;&a0cYII)SQ6Tb,C,CO@3H)c[a0G2g_32;e9Z/LHgVI&KcF_1N4]
5K<V8D#(0U=VTgZY>T;WH\5OPgV>^M?&@98ZSU-_>I:)YSfZ?UHDTc[(_bdeY/]>
6(&(KfY2/7ATLV05.<5)ZW?WQ(>3+R_/02;IPGK_>)3J0&d^38J)OEdPIBR^F70;
.C8f&H[N43._XR9R4LU+db<8GHD:\UeAL8B56;Ug-V9@88IgU\(E/Jge1[KCLCEP
]?ETP4^LAWd0&,)))Fc7L15cDES:e?97B^1:/151&RA)^d^C93(VC&dU<=P>);e2
G0Q:M4R&J&SY_P)NLJXTfZ:9\14GQb/TE4aV(eM4Z)5@b(a.c-I00DB\/6BG_b3)
:XbRC7g1A;9_R2\>FT?=XFB=HKYfDE+0S\d6C8F3@>T.;)gZ\4HA&]00=R;KZePc
:dZ#BQ9#,P[3][fUd>(BZBPW:?)0)@/9#6#SVPPeJR2[9ANG=#3^96#N[gUMGOca
a/\V\>8X8B^W5>#RAM2RX)B5#:RE(Q68d[R:(&KVbJN5?LO[dE2Da,-2T>W9W)DU
R+FSVC?MA<+<^f3#f@D]Se\FE(LY_WNAfYTC-P(U>&TRE^1Y[(07F-7K,dTU<F-#
@PSTA#&[CSgR7C=S#1MI,+^Z,3U=_K39HTfeI66e2>egF)#Y/^YFgS-[Y=D(2NU/
0.C?6LW-.F^;@7=W9bJ2g#NARM.3FD#,U/dNM)afM;DK<O:E?/^7NaMY37cM=?Z#
d3#NAb70V78ggR@JDd/Q+4>IM_.;b7a6)[,I&b_T00f6W:9G)9eeC=K^/gNJ)RNF
T=f\NJH(GRSLa^Hd/faLc.71)QbBS6?917R+Q<+Z2PZ\WJ7=I]AgUcdg2I^B,YWQ
WVaVRFGTY=?K8CX=\F\W<V;_>MI3&3YF)48VcW>(,QMg=;\)H&\3DQEaFRWa9E7a
8)X^:2(=&D..]<.H,5e\92J99.CH(48+A_X\BA?(f\+IIFMdP(E)QcbCJUP5A=8[
)=8/HCY^d]^]26\)SJ;G>Cc#R1_fN?=FRA<[P#^?.3d(e]JX\Uf.BM+(6E/5DSUX
e6d&Y7Q#6MFV]ATZ&W59[]WJ(0F;-L#R40Q9WPZ,C8>#gc;PVU\MNZfB6X:V=08#
O6-^BJ&ZQ(c(Y5IN@3/3_eVP9ACR?Z(J^&:Ic9PI75a&D(?)=UU.b=9]DF.aIcR,
CA/-YR^.22:(]81d1^?JG(2=W0:YK-9-:WZ^6<3PDTR/F]B=)+6IYFV33VQ-+T2M
+VXA)H,7<WFZZ)A?:BI\IDFNO7GOCNCX8dYPV.]S8.f\P)YQPAP&(O]QO:g5_aDb
c8Jfa#R^-64f62)K/cH#gDV-BR7E;?Cf<],UYfJ>A+]Pd=P;##2<;XB:00cVY(#E
Y?g<PcB&e3/)IMYKg,2b[@AbKHFOL[Gb<^(NPS=0YI_S[<3R@eD1]FPE0gcU-NV5
gSd_49@/X.L?c_XZ,EFGAU.D36AE+-[?dLO73XdC?d1(bfA+1;/5BU?=d=&d4dD:
=CAMIbF;G1I<KEccJBE_4WZ,Sf,#GQ-+\FH^YJ_PGET0=,5:L?S/&cUOQ]/Y?J>+
3C37A[>S37ZYa4d7^CE&LDHCfG5/9I>,#_4g+c_GT7bdVQ2b49eEbE4SR-6)T6BR
-HF5C?fRCQ3<+\A]6@d5>)NQ;(@Y>+;C6C-aO<-YP\IZ#-I,P#?@Lg/FUZ=#0^bV
,AUbJ\12O]Z=AU<OX@I\]VgTMEFF?21]06A(+9c.ES#OJTJKf@DYa[XHT-[Ea8fX
Q(?\>007]Z<g0XX,.6>L#>4bd3/efI8:,X=DM@7Ygd=L[.YgdX=Gg>)9-M-aVL9)
SI0(863VB&@M&<95:TZA/Ye8.Q:<]>JGQ.U.V7I--e16J7P8\XMI/bg0/@BeGG)J
QZI6&DBZG9&g44^f)A1Yg)Q5L\b;Y>T_@Q1c?;QH@?aN=^R35Nf(-T#7cg:P6FN2
]_UQL6^b)Lb^BFLM5<WfK^P19?SdJ[eA]ObA4C1Q9;JNBSa+bIg+gA6CR,HPC&VD
W+\K9We:W9[T,298/7PWDaeI88X+,L(gQ<GR[eBLe:(#Zc/CEQ^ELQL[J:PP7Kf,
?(4]5&3<>fE\Rb73JKYg?/@cLO/KM:A_U9=A4RPAMc/,(S2HFBE^U]3H\3_PF2,<
M#.-K1+cXM\I1gfY0]7RU3c9f3<d\3N@.ScE(I,,B-)Tf],QEfPBSN0]:Y<E8Wba
JI_)aN0d?/c(_g&4\T_#cT<H8Z]RTM(#3c-9>ZV4V7->V@dEM2E62BPN?I@cD7S2
M2OY\+IXX0;5)RL03?DBaS#R=)>g:5U>U>g][)DUC.PgW1@Zg1WTaa3&-@1/W6@I
-9G=P#Q&TSOR>@\B?4)efX_D1^JKR&U,_:F_H<1?E>d3b0W9>\(e^_EMERZ@Vc>Q
Bfd?4CT,E-8F-&D)Y?CLK.46V8ZV>900LKKO.e8WC@8?2F3/TGU)7A02QD)E/EgO
VJ+\U>LW/RTNLTS;fG8Tb\YEO0UL4(MEJLL_EMZ]G0cb)a5K7b6,.f\XR7)TM>?>
X)>#gLKE;[fFQHO(DZ/46\2&@PHXB)@Q05cb+)3JYJU\PaA/076JGJG/;B5,K?g6
W2da/Q8dgT5K@M[6=)L4degR6[0bMK0?K8U[_0;DB7Eg1R/9#M@A;-ZW7VY+Xa,M
MO)]d@2MVe0:F[P<7(DV>\><4AXXFUVgY^G;eB/c9>&F^@bCI-[E4bM)DM;_5gLg
,:1c+\IV:.LXK:g;04E^0eXZc7I(PS<cHY2?HO)F9ZLdF?5T<]XBJ1f_/6YOVYd1
#ea)4PEG>/@_9f-V/>;V1eZFBB_,d[93W.])+Jf2DfVH?[g&O?XBU]1P7fWL>4:/
aB_:X>S^+a0N2.+:9X9\[QfAJE5A:TF6USeNf2;ZVG@H,GQ-b#KE8^J?)-+,(R1a
A),X7bOB9=6>GF9_G-T>-2[5.2b_gV)^JZ?CPKH8LH+&T1#M-4Kag,Xb1;][9U^-
=IIA6)N?AF=b)PL?=P0a4P5fUa3-^BJ>6C\a.OYM)HFS=QQCd,dD25E;eC\dObdA
#Z68Rg4K[,=T88W40b97]PJK3]TT988\GRF)8X_7Z^RB5QX2)_XXAgM72;&1c&5C
?MLJ92^7gGFa)AYZ(P7)<f_cGd9+,#IV-)<SC+gLSXYHB(McDVPBCI+=+U((c^Y0
R^>Z-\_(T,0OF.&U+QJ,[WHHaJ&AGP82dg.Z-.NgL@81&27DB;YT)G:U[VUc3B.\
?2XVdG?P6EdO:^)W<=\dHfFXcNA?-=,D#,:NEUbZR1aEGZMU6MLF74X39N+Y0&SW
KDJ;W)7FOg[BE^d=-],8b<K4c@&UQ4]<T1;eB6W0^7JC@^5DbXWLT8@Ed>Of9P;T
NG<)2b^dV@>J0^_E8V(U8,\/-YO>Yb#..LF:AYd)?IfSbHCMMC^W50O\AcQ4b8[@
8adXYfH]+C;BSZZHM8=E+0PAI#a]a?2[5e=F\a6+a#WR^JM3@56QC0<@@UH>2\4(
(27XLg^,-R>U<43>@@_eFY4NL;g-5BL3Q4_==L-)?0X[R#F)1/LOVcUDfSHTY(HN
)fFbS<GI;XCUF=+HF@IUbURf?0N]/gU+V<Z8+4cL_+W1W+7Bgc(]JK3TTKK6T)JJ
eD3Q;>>(b0XWTA,ggC^P.UcIBN9-17>eZgZ)[7IYc2I7Hc]T2SO/TJ9(]>^86UA2
#(45+X;eR&H;HNGD+(BSg7FIM1Ke[5.a,3fW[QUEeK:N8E,ag-:UR-_G;Q;@50,e
<?0?]]WE]M&cJV-\UfZ,e_5S3ARgQ+3MV(73VE+D^S_8IBSZBPRD6eGXS3)9TX;G
J+\+aD8b3e:.OO5SGeL.H+3aXNY:RLW9eS^M[X@5^E7^ZEMA:F&6fWJU;IISCD?L
397WM_DY-(GT8[IVM\/.6fONE7J_=X(<D&]-Jeb-757<>aLB&aE42G\V@30g7FIT
P#JbO_Yd_[(DIb.Bg333U2B<d:FPZ6F@KeFe+I(F88Y_b9WTU3_C0H2VgDf&9eUK
:/F>=&e6FD=V>=D&gZ.(^<TaEH0U5(4T7aZ.I,?WR5+L/Ldc9O2B\8JKgDaa:M[R
Y_La#5f62F[[UHaQ9](+[>M;B#RL<R]fYL12b,BOgA<b5N>/U:L6SGP2=P#7#8IO
[L2Z>0S[2DSe0^.^5Dg7-T5VL&[8TK&CdB1J:+&NM=f10d2A]F5&&5@U]X6(:@NH
ca+GMOZ:KT7FS?]/_SA)\b],acCMKMfYQJ3K)L/H6XDEKE(-1B;.CR\21F@GdEd,
00-2>DbL1-b&.#M[>O(:4UaaHOd.5(&A7.L@HVK?e.\dS[XMU.:dQ1a_?+4DW\J-
:O]/;T?RDX2,dg54)6\F=6_@7ee@QE9d]A2(8V]M+39eP_0dNKR72Ub?X6[Ec<[4
>HV>1]IfZ2(LK2AI)KdPRPbCB@Q)2MX(Y<XUeQ>4LN@_^?7aF,fKK40Df+fJeO8d
1-DBE:91GVT2#Cd76G^J\W/_VN]UJgA.9EEP\(VRDQA[]Y>gBL//88eR(baJ_3.5
gf6TA(fAH<2cE-F;.T,K-PdC8+KeF+(0W5Y1LgFE<=[,.?D>.aY-#.?ZM8=be2SN
>M_QDe5U+c&2aOA#<8d-JbbP,[&J0gA>BKE-2B<7-)O4a@Y\TdQRdYF8bTd)EDI^
e8H];BW]a93A#f/ZL:B#Mga=\9(7.VSfUO3LXdP8gTS;bEND0Z_CD(\+>CXf7A&[
K]-TSV#)Q&S9<ZfW_LN_)X\,FJ.)=]7;]II9093L5\Z:,;bUb[cC=6M]@b4W)Y(8
0_AF1TU:08UC0[A<QdD(904#H_HH&U4-VG:6[9+)^3c@IGUE[9^@X3ZIL)XfMI8T
4,3EgKE_2IP[CWaKY87U(cX43^7c6:=_,VZS=EJ0F,1])cA7?)fK^_\AbOD[[?#I
[HN/IW3M3@K?[FF0c2Q34SZ&XR??D7A[Afc3^PW=CTS8#=DD3f]<@YS0.Z&<EJaS
UHEQ(\gY+-]NCg8cK&1YS2R)e+)YG0(OP1f(#2(]aM/F>6C8+&aRbRNK-#LR6IU(
+fbdc3[HQQO^>[?NPJ#4]I._7eJ3(H>@^A/F\I)S+X_8g&F19ZO&5B[H2df)ETDR
#Q:_DK@)ZY=@.2W@3B&VWe#Vc#g>B]<4fUJE;E.SQ3cED:d<<R(M3VbMSWY(IJTE
>.]=/AJF7T?VCM#)>1)>NAJFP)&R@62DH\Bca<^TT:-c/_?M=46)I182QN;cQ2Z@
3O5+H\=P8O^M3f6IF.4MT/dP=Cc)>(Z/2Z8;TNPQe),fC@ATg;fWF\:@R.Qe11H6
L#0QZ(E?O4GZ\[1-[,VYIVE4;EaHD&Bc+3?]B[^7SR6+7O>MUC8F_DePUC<9e(37
#-SdGD[K9FIg#9;D.G^&&:37@:7^-G\NF&N0=([49J1:JGL>\&]90g^KE@[X>M4G
)[bX8^dfMJ+2<gPOR@ND0(D=J/;N&U3DaKcZ)>SHM>U],#c.a:#M]0WH5U(O<:gX
:]-L46[..SG:gNZ9^cJPUGBS;,K666)4dg_OWR4d+N_PC.-CLeX;GQLB-M=59CFW
Z)2e0RGgDYb.2cRS>3Wd/4PZ\KDJP0@4]Wga91YT0-7I0-2;IL4P7VZHUG99e<M1
MLP#8WZ8^A(aW7ZHHOU/-gA@gbb)TI[e9<&[W95^HO[Z?+&&048A7Gc@]e\]3\S_
^=(YZ2@0&_E3W3_K>Gbc&Y=X-fdNY?QdfKL<@O(JNFUN<\:0ffceL]^cEc1)-ZUb
_Hc@c#9fL8\P#O/.dcM@DW-)#82A/6B+]c7[LVWNGH^G<C.gQ2C6afb]Z5N1+UIP
C>SA@XKBW?.Td\(UfBNeMN#/gCVKMFZ-ME(P?#5CN[9(0Na#[Z_gJfIIGV]FS2O7
dWYa53&M<7)_D;6WQ0P8OGdAM2\N)<FD,0#<[=\+NLgW+>T)geY?(VM/#C7Y(EV[
)D5eVH5^OGXC&fIB<F5.LSDYN/VE4(g]>PLDg(T8IJV-7;SU&/?WXON5Y_eMJS1#
.[:I.V1&:KE=b)f2OMM/GWOWQ=F=+CBa:]5@7=gfTWJaWg-=#B\YC5fH0/2;9e70
&)^M777-S4E&QZFA[JV26PH<V^34P9KZ(f=&68fHO4W<V0(Zd,(K1]Ja8SIIZDS,
7\cPU:-SDN/ZSYM]M+6dEIK]_R[1?1@H\60\LSMAUAJHG?)F0aOc+YE^aV)_KI4G
>N.F48E;4Y4a9]-]U1QZENQ?DY))+X2B@LO535_+Z\U#LF>@=-FR/V<PKU&D2b3O
Mb/1J:X05Q.KT+5c>2?Xc>\0\.CEUHC:^]?6^,JbAQRg5ZYE6DLF)9/&46Y?EGAN
=<4O>d&?^VDB:C&g&OVd0D;1IQ8AGEE);$
`endprotected


`endif // GUARD_SVT_CHI_PROTOCOL_SERVICE_SV
