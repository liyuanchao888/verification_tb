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

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_base_transaction;
 /** 
  * AMBA CHI Base Transaction Exception
 */
// =============================================================================

class svt_chi_base_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_base_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_base_transaction_exception)
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
  extern function new(string name = "svt_chi_base_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_base_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_base_transaction_exception)



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
   * Allocates a new object of type svt_chi_base_transaction_exception.
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
  `vmm_typename(svt_chi_base_transaction_exception)
  `vmm_class_factory(svt_chi_base_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
,,:4__SPFS.ZKKPAK=a=\B[8UTYR^;;3S3Q@Y9NM\IA.EV-3Y?NP0)V<]],5:3Fg
\;7460&d4cRg/f4cT<\YHGZ(1/@TgcQ=>B(>497C:NV96U-.gC&=<JDW&+9[<MBH
fD@1AFQT6@)]\YR=,FOeK,+1QeJ-eVcAgAbI]UXP)Q;HZ@g<_>)]gDFIE-MT-A8>
I6a\5+?Fab?;,N#Z&g5JIQ>\8:,YcCY]Sc/Kd))_<++H:-QGSQgU3=YVbI.<OG85
QQK)g>#=f7gYdAXe_W-S]a40EZ@W(^UQ)-?#Z.\gGBGY.dU\d17)K\OG3OKOf]2X
<TQO+[Dd;ZFZ]P3Y0OT4.LEgIRT,+1LJ\6bN6^0(TM#L+<C+B^?/K#[.5=\<[_d8
]3-2f17EUS00AKec^=Q3P8ZQ;dGO:;[=L:+E2UCJOY39b?MK,Jg6A\/Q=ed)CfNU
#bOIEH-3>KBF5S.HNFE:BRVGZ-Q+0&Fce0f(0WDKK&A1J)aIM79H<XafNZR.@Ze\
3H(/(1Tb.T24ec3af]^?Sf6Z>]2^c?+c1R8+Z^?]\:WXN)085IB;\W7fOKM=>)X3T$
`endprotected


//vcs_vip_protect
`protected
C>0#P=gQ,BbTWN#9W3A:9)8)OBa4Q.=cPB2f_N=B6MK#AO,^a?(c7(NI><Zc1OZ2
H9Y/5HHg]7<_:cQBW(^8I3ZZ^5gEe,9QMVO<AY#+=L1=UWgP#FcOJR#T0d^&;D,L
=(M8.GecS44<J-cEUPP-W0_X(9_SGMBBE?JAT\5\^1K>U(FKE&/95Te&YA[EUI[V
U[.b2I7cX&SAOE3;b+IfE=/?@XH2KERH>+Fa@;/.0D@:[#9XT5\Z+\?@VVE9W;8]
C5E+SRTE:TUgQ4cK\=YS\e>QCg_<@^G]M+@^1aA_.]=(HW==D2VU:8-]@Od^.e4>
H>T)1YO[BBPKC16?FJ<V0SDKaFHKAUWJ;$
`endprotected

`protected
XWH@7WAKGHJJ<R:_g,^L_Q4>PRK@+=OfG]bW&YJIGb2]Y0f>U[@/5)9e1U=[4:fg
OQ^Md=_]Y.^#CQ+V8X#^0TE^A9b-Qf/J8&BC,5)R2HHT]AKCU?+/b-@AK(@5ffa7
ceTZCba(a^RFMOd.JKP-f[<CJ<1/.SK>>ZD]fWHIgb@69[6fO.8cDU-Af8:9?+[_Q$
`endprotected


//vcs_vip_protect
`protected
[I\aM79@<;-+>UJKL6DS;bAM+aU4ZKLE^G9ZF;IX4:fZB?^OY.a#&([O,I(+X3bD
GY9]N356d@PSE&#b[NB1K_J9c>BFTR.f6Z>Z6UX5^@)5QKG)c[<W[DN6F=DZGfeD
.IL-#Y7cdEG\DWD\K<Y,@3Z-^^fX25MDN4@/7LD>F1G[FDH,T#^?BE]b,^M3c[B/
+a14.^JEe:-/=a_0^<aa_4SAT>3XK7W8W7g4J6(C&CALgC7R>B;PY\<KF)7_Sa)(
c6\:ZC1L6/S1G;JU)O0R8fH;@^L8CH9)(^g>-C5<Q#@Q>1RIDEOdE/g:6CdZOBfB
W]V[S^9-]KF5I\I6cXd\g#I,P#dWS2=/HW5ZE8a59fRe1&W4M#KZ65AF^.SCR_Be
#U@MFac?^GA,]@CCQFGZ]@<O2)\cZNa68,DAf5c]]R)KYQf@-3E9?a888QC#\Q;&
44Z3^]a0VL8f@-,FWS>-2MM=a1FTdJ85P/<RBL<OF9FK-3GVCcL=Z1^Qf8,OW,1e
+=J\X)?NSSZfd9gIS\3K1TPE5]/HT>e+W-)710JB1K8STFKTZf616C^3(XA:R-5M
O,c8R5X+f+(Y>A,6_.2#.Ye-6d]Q3-PgA[,3P.8KYBSOX_,A&_3T]^>WR3,Z,T2)
c0.TGB.fCfD:\VFR3c\>BI8NP;)eY#I<8Y(;X]QZc2[?4P_;^g\e=P>+[)/CF5FP
O,ZFX?24/TS8^B-V[>gUU:a7cN:4#U+?BN+;b\cM+>gL=U#/f#eG/_QK2L4PD=9[
IXZa+K\E^PKYJGf6AKVV@UYAW;OBb[Hf#3U;T3HgV6eBg&-:([QR7(+F8MJAb=GX
aDe9Z0Uc\>+R=a9DcFO[\SP6\U\.f,V0EDVOg1H>cR,;(4P3]d.:Y:ZfBd/W3I,Y
_&W1X#0\TM6A(11W-HCQBKH&CIN11\abHb&_,=ULS7e/Z8OY#)^@aWDbSdMR[\0]
-2I7U1X#S>9L76,481?EfQ^g^.;;+G@RfMI?^JSH(<>AFeGR_@<;J:R]7XceR.K5
SV=bQV?NNJTQ69cN1LI]XH2d7CUXM]c5J-O-LCL<=[5;]T)7.&XOdNT,Y[gGNS?J
)_OW_+4f-0F,1[&7)&IGRR>VeAW78)<._8ZQ9B9><D[)eV3f\T.K@dab[cND1N6H
Z8U<dfMYPgHG4PX^NG47U./BePg&Ed>eYUd])-F[BIADKf5_?\f0/Of1.?d=R6Y<
5N#_K\(24.0fDF>S]Wd^PRDV](b#>,),\7#8Fg+G1X0_24@O_f<c44C8COA,GdXJ
S[\KdR;_6)^@[W>;C_-_=Ub@XQ9(+2[(#TcGQK>]A&6SCJ]f6J-Z)dG=^:3KE6.C
#+;N^9T;gMP,9GRO#@&4R<SWL\d0(AC+Zf6R#7Jf[IC?gd8_QJ=VFOF0AVb#=af]
A),MUN8;,MPTFSAg3F=M)+8B(-O(F1T9T_=caV@Q+NFVFbSDV][;F46gYe/10\c?
7QJ<AST)>YOT58C;KIT;&E2RYGR]Q[P4P:.<_GYT]6#(#+;SJ3AXIb(?VM.S3HO=
Q+bfM.KGN?X?OYIeZSF0e31@NDc)Lb:315e-D;g7?\B4_O_DB=M_GA,]6NLMX:<6
#?7+O#RVTN:aB<//6H]U-L\3Z\<<J_NZVE:T7fSM7ZUPP?_3+Z34(fKT,W6C=NZ#
Y.SJJ@;_O[L)>Lb28I/^YbcOKDQQ7K334,Fde71#ILE:9OD;Qbg@KU>Mc27VEIGb
>aE-YBce,W)+)>#fL>E=?8SXH[aBSOPE#.LeD=70^bH3=?KfRT-deeEQN31aL,L>
2^F2>79YI9;X)0AF9\g[M<C(&I,9I2+FD+QYFE:d8QfU7BdP3bFF2K775)TSgR2U
\W^@3#b.D923+:^>S;V(A0+3=X@Y&K4.6;0Y+D]=40137XfL#(=F6-CNMPR0@8:Y
.]b>N6T^#DBK8ddb??JdCMTF5Iaf6(\CE]PX-0.N0,=SZVa@^TCa@gX8)X(fON:-
82,O6VR^eJ=0_QZbCgS^<PO:?aC1?82Q2T,\.YL3)f<Y;,0H09T#JR3::1gG[e,W
JEOB\0J;0<\B@SJ;aC#+)Y05/.^KO6d1A?U#HKV>TV1DKBPAEJYR(HJP,B_;OUcg
cCSXK=-G8bVgN@CaRS)M8^gU5P\B?@=P=_CK9^];<2e)T?;UXXCN&.:;K9E#Ke<T
90EKO6([,_0A1LS8g7?2;_GL1HJD5Kcg\:2+;LQeYC^g_UEVFK&\2I+DefU)MdP4
a0fd7PJJYa,YDP\(\A(C+WeB,0f9.WN2^?,V79:X>)g<_8DPM;?FK/B&2X^PdWK7
#9CV\G0?3Y5<eS&+2&Ie^D8&=c7:D/bE-@gd1??bR7H4Z,V<aLN+YSId.Gb&0X88
TXU395Y._8]BDaEE?GI^?G+a@NGIS5OgHFJ@==](GW1B1-)M6fI_A:_R@H8T[2\1
e,c(>K4<Y)dC+&;@(e<d5X4]GFea7V,]DG@c@7/HPKD)RW9aI;b>H=QAI,5f-1<+
P4ODeN;<X^-&N?LT+B/4L(IeDUa.aNb7HZ87O00P#=2/,OGdDC)H9)T-)LD:4CS8
O4>3=E49F6;E#WgE<U14g<#QZ;0GaF4^JS/W&2TMZ3-W-,/4IE=35U9-H)a_W<9>
_?Z963Ue=S+K+==/1QYb6X3MYI@T/@#D^)^R@HJQ7GVc@LgMZQ>HW[e@)?WB#94T
R.-RUF^3:[K<?T,2VSXV)ZN=4A-eLa]LU[6@T<1@0C57=#f5/+?^1=Dc2N+>,[T&
-+2R[M7I_]2#@+gc.P-QS/X\LSJ<MTSA0b4b0e7FHT#8T8?6f9\bfB,K2Ha<H2&V
CZFBf@TGEB8efL\PP4]c4VU;ROUGg7KG+)X/d<gY];A)BE&2>2E<P#I6S:^f^DNS
AQP?9KC?e3B-QT>L=ET)aM_[9GV3[#<4Sa85X=V+P:Q2:;e.=RB)77SMZ/.7RJJN
/L,8e/c5HAK7S#W;eRE&V54HTD,ZU+_3N+[>Yg>:]M-[;AH1^+c&LXT)2M\9U6eY
#.?[CQ^ePKbUI4MS1U],ZFWB=/CD13#\/34JaGCR[I>P(,XE<5S-1VJGYCD(aa,W
OYdYBfJg[:1gb7R7B[;C?V(2\NbDQ&CQT-3FYHO@Af]N5/+X0c.#^9N\NLeEE-D3
[gZW1=1UXPNGaCJOJJ,&,AA]H\B33)T/b#U&@VXI6H,9C;HA@PP&>GY4eE.d2>IS
HS@@@D)Wa,QcfXV@KC\;>N[-Vd+#.d:AQ@&<].J-\PbH@>EW6(dS2AB5W<D]Y:AB
UN:1\60))9-HMW.N/_MN-O5(=[X/V(6_1)D1,5R[_JLdXUBOXdFSe76[DVAZ/)d]
BBb5;>)NI<&8XbJ/e[:>CP]THK.\.[:Gg_.T-geA-YQ;H094)MU;Sf@TU+]VbL2Q
P5/S60\OfdA\FA@BH@>E9Xd/R1Rd3I&7+Z1OJQ\N1?LRCYEbcY(A#1g7<27MMN_>
QeGe3DGe2JZ5,MX?[9<E>.+033/dcJcW/=XL&U=TEL6f4I)U-/,YL&b_#(-I@UWE
\-+e/(E&,T:EB5gZ/A^N.R&QKFfDCGAb?YEeVdV/\_PHFX7>OY&X-UfM#C4/f-#B
BN^KZ&VO]]).&79:cUF5R160P^Bgg8:2=Yf--^b-@Kc+>1>:8+?DHD.DB&CgS))S
[O&-3HP92VN_@U>S3C9((Pc5g((PW?)1RR^+ZXO,B:c.7)?<dB_CHI]aQH+&LB//
7W=/JO0Bg2DXK1^I+LC(MIXa))YLNG3[+X8g@/ZFMa\AY&5MNO-;#HW:J?WDL7/D
MEY8:8cP:EMU5XDVS4g.IJL@<-L4U,bATAADM-b)56)N:eZ/&DY;.I]3EC#9>DWT
\25&/Gg_N]IN,LgYO4Y4-cVT.(5&TT::I&X]WTV^>Veg&Ac9:S5g3G;1?JY-T)<c
g0F:de[[BA=9W?RNWD;L73U/:5G+f(R#IUTI6.XHZI-.,_M#-Y><6eMg05&.QF7\
QU-&OfPE@D6.MFA&0WR7R[cOeJO#9[<dAK+GS6()>?OR2>Kc0(d<AFeY2)gMKFG^
RE7#]CWeaMST?D3LeS(R3<WF4U:Q,OQH(^8:?,C^1M+A:IT^9FILL,Xa<XEX4&ga
JV4(.:6(:I7ffQd,bX,-VEZX<OY,+efB_XLFL_RM[>e(N7MXK?]S\g[cdT@Y>QgA
+^aI<V?PY(@G=E0_C:R4#R:d;;U.:U2].Z+b[IK@3Y1H_Pa&,b_#-5WF7C/L^9PV
NSHd<+7U@,OOI&g/K917YS^>b)-.T>gHW/ONITY-_]TGPf.?c-.C)/UPBE:T&3XN
Q6^YJ@P53G>R7-@cg:\6eK2^]])\H]96J@3aF:AI6[H2b1\PNDB[bg51HO#?6bO3
H-QdaXI5O5(&(<e&3cUQ:HXc?YMc@<SX&A/W/DOBG[,LBB+ca(_?Ua-4A[[A7P6]
5GNJgS7e(Q\;PX;D6c)^3(6#PSX;+B6MM;#M3^b5?V;D:J21M/fIN61AK(EWPF&U
N7e[a4KJ<=RVA,F?<HIcFT6V-7IGYPC/8)VF:?4BG]Fd4+8\]<;/YWM<AaKBMXR\
.b^J=()6-?JgdU;6Z&Zg4BW[dddH/+P=?ZQdKX/C7S9F[#.1FD\HE^OQ=/2\WFD@
Q(OM>YLZ^L>,:?RX_(8/H_@cPX5.P)S;C,:Q&WG@SI)(VCVNOM3K?6.&0ZV@)>H)
2F&1Z.aV#Tc&+J-1;6V[:>XaQ7Y9KU,E08agUL(94LAV@+5UON_PU1O_J1C-(:=M
P0SUOeS=-LL[3fB/cWPTWO@G.O<^@IdH7fZ3f/T::Ae1V5J[Y<B.1JWCg5PVP4CE
)AV::JXW#L4Mc?38/MZC[+-,=JJ7;SHe8B49dF7KUNdCO)(P^,NG4b^RE#cSH+aG
\1Hfe&UF/9P.Fb+_;RCU/A42&#;U2:US#SAdB&#W7)2>JD&5G3dO&Vc6@:;Dd_RQ
L<.1&P\XH@;T:8YSOe@>3KY[BK=JCM\gT,6/WFF41KX_04WWc^5NBM[g-D>-VSO<
-]F<QdMR,AMdL040JNPKL_QG0#c:M.[d1Z^TKTg8+#WJ_g[6(+8(0:>N2P59g])f
TD,C3E^345fVQ-7S3c/cXZM<6A-7^C?W@ET;M7-78f3RD?=#bbJ_;KF<3f6Qe5Q@
SVa>41:S889OGKc:7#c#ICMJXBHZ;NCPI^ARcBB;8<34L]=(F4bPWB&;Xe2QWAY@
(3TeFX-8MUB]S/??Z/5Y&GaZ=FAJ>1JGZHFaEa7PY)Sc.ca?)dN0Zf>;J@X-42]^
4=ZdLOZ82dV=cV5:&H;K).D;1._B2XQgB<V=;?X36T^R<>Xc425086TG7-YULTZT
f_1gRYZEQeY6_T0B2P+MHT7a2DUVNX7DT+5aHI^aJU[+YH9A\?>E&8V^=DdPS.+:
Be;Y;B(?2LQQ#F:Y_EWN6,FPRC\U(78@SH^D3?C(R[KFB<Y)]?[e\K+fY4O2[[?T
S6P+C/52a2M0V#+;/2Q#8J@@J\L->R[ECMCP36f]1+28:f_T9bG;bT59(V8aKY2&
TVIM;_]_T+Z7b\BP#D+1T=GKO_H\-SgbX-Y^&J?(E^Y)HKdVIWN\HN@I_7(>W/J-
LK__02<4-d4AW5:ceKa&_KE/FD[b/g<6F.=LdSg_?BA22fP(7#[OEaTPEK-0c+G7
)<GQa#Q3]_@XaHDL<gP^AVEK>A=)Df0;],6K4:ICgB7@9QUc(D9.&PATU+2?SE[/
a<DF=/4-,HV=]f-M=X[4ge:UT+#BfbJ>1^Y9/C(Q5EKHHL.0&:Og9(R-5b=+@<2b
;]BKU9)J)&:cE6WB_Z(EOdW0[O^WV/Gg8N^]VFT-NCLYSY4>)eF[5?eOXD+<D7^<
fT+HYD@95WC[2E/RQ_M)_>>3+B;Wg[XFP-&(CEWgM8+Q\#+^93dK-]\M;c.<5P4V
TCf5/:9YX5C3UeFIJ-6N6(5d,/=1O,O-?EI63HQb,,Q5DQNL],D#91YB[/b[f[W]
,bHg:O]gY_@b\aR,:,^NB-F&XBMgFMA_<3bf-\_<Hc;?KG3GbE-YF18Fg5C(:3Z\
QCbK<:P9(:B/KIK+L)FT\;\>EgeU&#NC:QgS.FJ60:RO<VMH+R<^eK:>;aNC2S-7
8g&HW&M>Zd-QI&)KSQ,d,LD+WbK3@a7^/CC6UDB,=6O\a^A?KR:&I6fG^Y^fe:0>
[0RW]B6PQA1<Q/1E:UR>2Ld&8_(Qcb1#,I/ZT[g6WBE<8.P_cd#6<RM;;S_B77@6
?2AKe1\7J[f6B-0E3]Jf332:eZ:K8W5)&M?cS>Jc&.?f^g5W>#Kb;)JE##N)<TBQ
CQE-eRWgfD?]^WN[OTc[eR[6Pg1^MYDeaF2D[1#+a73/KGTcV/W>@B]b7JKYd[MC
J60HM;OdOH36=JS^d24+HGeGK:K3BWKYeb8^KUJe0]^PbSUHXg04QT>c(5TN#+<=
d=TG4XFKC^<0Kd(d<)(4XYcG_3B=CY9CO.b@<SV;<V>P)?g7KCdR>_2XL9C/?143
NgF11(dHQC4bgDBgO+#N936Ba++3f7P@QG/)fPFP2^5@Z0bD>1;+?XY1M[+X2bF4
\DA^e4[1Z,HN/#[;\]DUJ[&2_,TZ&B<_4@7bXV8]9f_GgWW=L;T4M5Z4-Fa6+-fg
^KU,N8g0.DQE6>0RN_4YcAaCU[7f-\C;XYE5PW/AA_fG0+g9bS[4@TGF=[Cg[#Jg
MMMaK&5>O2I5:K[#:/M)P\_J?R+^1#]]UM9cF>SOJC-Q\GCA42,EH4.J_F8:ONa4
^B=c]F.VY2ELb]#^DKNUU4^C_:CBXGU7YP.^b@5_\&.8&3W7479FR_:,(>a.#+&3
IG;CFG(C-AP]O8+8/L_;JQL?\3M#>8#Q3<EU+^PFQ;ISN@AZ0OE1WVJc\&BET\(_
AOI3,1#f+\NKB54C-81RW2R=JE#HcCCIF5(S(F9W+-A\-@D/3[cEEXLR>?9N8>NU
/D_(H91WNT;R;b&-3/BCZF->99\?)Ma,[0&\HJ[XIB#,O6Y-1J@fVe12-&cZ51Og
&<2_Y8FFc[M]FAEG#3cTBHU0c2_)e(&H@M-A;6SGC.WIZU0[,JDH2SAgRg]cUH,W
YSZeY1GfLW=OOS<N4A#:Ga]<)01[.@<B-@U&7GV[9RAOP;(G21.dWZV\e@5?2[:_
6a)FGD]\>FS]R4B9#D##1]ZRIA@GMgf]5BIdV^8[OM]D=0LO86?J&1#[OY64<.Y_
8I2];2JRgOL2_/N]]:+W:aKD?@8,Sb>MP3]?7NGC)1IE1(/[/dZ):8UbE7;B2f,I
13867PU@V=3O@PDNeTLAC>BIc,G4?)a_KY7Lf0HHdY(<IXaHG_=\6Ca2bW8MT/GQ
R,.?+RK:\;WTHC[F+3FU=QfX;H\;];N/33.W1(/P[J+KVW#,SdcU9d/b?MW^75X]
,?NUVR6]](0BO#Nc6CLHK2O4J80ONOF/F6e48gWPA[:_2&7N;)^D/M)U:B11N@0Z
]A;E4#RY=g;8F4P/OBeSLXbAXQLLOL@XePa#[.];D3=3GW&_7e:N+H89<&)TeS08
R(H9AFPFMGM10[_/C^Bef(577R1)HN>2-SYZZDFQ28eLQ&0d&1/0e]eX5?CVFBI=
LX8GAFLMN^@+TPVPJ>ITKBK)Qa=&&gRG9JOW@EeE]:Wd)GWV8YW&_EQB)HP]J4Sa
A0/A=gEHR\AC?LP8K=)(?XGP,B[53[Y&e5QMd-XPYX-W.XFW4/T)6PFLSJ,NfOI]
,F]:2QU\H5F-KQ<FDLU>cW4&BB;#HWKS/R9LN->O=fI\RB8BDCUNQfbUY)3N_.-)
G]S#E?@(a\R1;BOOEJSV/@DH5AXB-?E#WVSBf?4E:X9AdD7eQ;Q?HY)Y#CESYQFb
Kf>00:@K_WMDBM;aI?>7)19(<b?++_0#2JB0>G(3^A3WN9dc?M^U-/]\7O+)2=J>
HFHZ^3_36\+LU[.G.-4Jc?.8B>C(<X941,0BdNV5@>?8\SUY:1LM,3RbSOg2RF0#
g5Z.VZ(gVN&Y0;8/MC6La>MR3QN18;::&L+)#2LT1Rc5ePBP<VXCM;>,5<N(CEAd
E9=(>NG>QfaR8^A989<.\^d-@U;75XQ_O/g:FOGF110cCbS<,N<NSP<-,+B^#>C?
@LP:/d+/,4U;I-24:V6>df:b)4WAY]9\DDe456b)=USD<Kb[:ZQaQ]AbCXeA9c,C
),O6d??B_aB5-,^#f0,]?g-]0f-R,#8T/dWagR(He;#>\IE.FJ\46K@.YHDY?;#d
-3(g88:L<D(8-IdGd&ONBX8cA6S.4B?ZYD(5Y9&B/?19U;+agE+74G+41[EeC^U@
NZ^DMaDNcZ89AGI0@[XB.+X@EE)F:AEaI,@S(b]RR,=T9UcPBb66)1(Uc80#T3_\
7I^D#SOHP>,c8A4YWMF/H-Z:4?R=^NDM@HH1J;5dGY_e[:MN.XCUHI#e]V1[/d]1
a8P?X)<VdJfX4Q:JS>BQ:P2UcOc3-Z=@,6g?S40RPKRZ:8X>Ic[O>EV+_WT9L[I@
(9Z(]@O+2R9GcG]I-UCSHV[)SQH?;Q7UgB0-gPg/,\WC>RXDDf5[??dJ:6@Z,K3a
Cg9EFZ?RARf7D>VU2FaF[&410XUJ3,+Ad@OFOJ2Sb:91U;&IE^\;;/7?=cBJ1^aW
:50eY5Mca\9RRLD?0=@:9:,V<U-]W]\E]<CIEN5BCL28Cg\IOb1:>geb5+(K):TJ
Hb95J<9-Q:(U60M?@-2X9ND+N/N9;P6]cK=8R2BWX#J#=PJA1>]&?/;7N8GVT<Oe
(AB9,O7LI6;E4?89MZIG6C+CBP9JBP<1TK,46KQe9I8E5Q1G4Y,5VWF@KI>BCgD(
KWZ6=ENaKRQZ1b\GVcU]?6-O@/LZPG6fAagO@/I3D#RF<8a2ZeQdTCa3IeW_8Sb?
dMQC.=8+33)UL:T<a#JgUd5--M.1XI=+@OK^:/fTFRHT[Ggc)O+>NIK=NAA7NJLJ
#5>g&c\,Qf0\QXCX;G)5+V+(#AOV&1,\XHR(KP4c;/UU[WH+G,c^Q;1[D1Ba])DO
2F0@&aM(<0d[ND1<6B/]Gf^(-S6a-a?AL^D)X-6ZB+UP903RWXfG90;Od9(#aZ-^
7XOP;HY_P-]>Le1e3#^Jd/_XRc>?6UPYIHcfgBac,;4:4MHR&Af2<^)6BQ^b1N,\
4?SNO?I?YacB;]VTD_=He,SIRV4-e,A7698Y&Z88c2JDNU_2ZBVMFA7f-Fb<K02+
2(((VQ4-JKF??E?#WG,DRPTMIQKD83_FaY<JF.WC\Q@cV(<TZ9EZ5J11S#SKG3.e
E;_P:c>=)<cWV05+BZ1WK\Q44_,R&Q(KfED#UNOPd0O?Y#79bYS0a<(L)3O/FbF?
NO9c6c+4>88JdALX]US2B1a\JWR(G8/TOUPZG)9Z4UT/\eQLeNLa;TLg7];gI^JU
1)=D_b)g&[LTWZbRQ&M=aW0bL\Z?3T0K1V2C(+a6>Z5RGS;f^M,W7b2.VG],M@Vg
F:]ZZDG-GH(<4S@]Qf?&eR4IK(Y8<8c@/24e\Ia66[8][CN2^.C&,>WEKMe8J1>B
Ic[ZA4_L,fg5H(8PUZ.J<;<>g>dDQIUB.)#>A=^+5G_D4),3:0AAXUVJDc_Y5>J]
0>R;5eIY<T4N;(e=#4]:;4<UDW@MMJd6>HFO8fF4]_-4A&cA@?R#)I0:^+&\.).4
TK@bB__.EbY#+WAgG?bd33^XT[&]5LP8P.AWK()Z4<Cf1d[fG\U8,3>..O+C;^,2
O<,=B8fG54ZdIUPaT7PZ+<5>9U]P&T.KT88f_A^K:9LAPac@:7g0RIVFORM58T1b
J-3FDAFHCX2D&&R(Qf3R1#HF95&T:D7LN9]NfRD7WDW-BJTP(]UH#JH#[)6b]FZE
O+541/f8Y;6[QLBK7N.5dFKP2];4R7&HZ[<#\Y>>RFS[>)-?>+8&(V;L?\>=4U6K
@ZWPTY(-I4V6GYQ#7X9=T02Q/YNQcUc17b_G06M#W\BXLI2BVRSVYf+,(e>9FC;?
gL>=8=5B6_L1;(g6eDXD2fI<B/@C3VXObf\58R0ID0]6T8J#CHG-^Odgd^OgWV<N
R\c@gR6R?BI0S7g5R=:]D,0;8VLBcP/L[)W=O8R/a^;\02\Z,4;P\-1\b-9\[1I_
P;0:^B@Q:B0HRa2TTeEcHG=C?944H4EGP.UJfU+D:aW(g.V9GQT6LGFCICI_HV_E
c@XLYH.^#gW:Z@V[V>6^8ZF=9Oa&F5?<NGY00-.<+,PIXO5+:2?d([M7K.N,A\\/
P;Z<,7><F4ZHWD4+e-KO8GLF96RKDccBT=G#UX.GDVGAKUeQd(TRHMC],JE#<-3P
a-3=?[N8(Q?YHMBE7VN??CK4Rad,eCXS92C7<:8.PFfY-JF)Ae466Ud<0[GA0W/L
_:J-YDS/:WCeNWc.KD)4[\F/_eK#J-;IPG#PE@.G8PY4LKDCgMccJMZXE5(1443B
-L:-YK6a3QHBge\?9=G;JL?dM2H3cWV(H6.P>]V:O,:FDQS(La92V7?11=HA&IIO
N53(QS_/W/,b45PN[41Mb/&F[[)I#4X&<f4M3Q6aH=1&8>?Z;Q3](QH.I@>->MNP
I))fUa>5d=Q]>AM7V@fWC+D8QIQ)8RT1WI#)JBa=:?U7a9/X],b.KbN6>39.a24>
9/\e\XHdUN\Z<&R:6<2WDQV\2g)4ce_28Vfg&><6<FP#@Q-d5^Vg[@T379MS@7]\
\T#0KMH/#dF-Y=N7>^4E66X4?V]?;>ZKcf2f)c&MLQ5=C;W_M,J&GeNH&Og#JP2X
D3c0RNfC?JQVXG=8S]C[a1,DP1V6&IV?F^FO:b.HJ_T_YIMe6Q57:J[WB&8d9,Z@
Z81[<.8KE#T^<&X&?>BF=FJ4SPQ8:eeTT8WcPPTPXBaY&1cARJ+^3PacJZ\RMBEW
MSNe-L)eU2BWU.6c)TG>6e6DDR_V+@;I2@d+&):]1#A]f._&R,/9g5ReD;VFXEa[
K5XP,ZM48I,CS(eYN4:1a6cTbV1H:(a--.0df?]GdJR2-]S7c2>KUH-]G=,I8JQ:
3#&^D5Xd59+1LDPa@e3[X#:DODP4UGDYCQ;7g^WD_LUXPKaIag0cd/HY]E>./W4P
Z-Mgb23<]4;I-:G#C1H[#M?fg81MR\X?81Yf\?(<[Zd7]Nc+/>fMe8A,bAfMFe#(
[DR/AaFe5@GKG.SEN7dH:b-1PORg/9YcY.AdZg8INGIgNM+a[??Rd8]db1^6,-Xa
80M#>6PKK[P:8F61,JbP2Z3DdFC<4<UI)0N8NIXNZ+V0IN0Y8Dc#d;?LO=.R_e:(
A@D,IeX>O,cXOeMB-60XVVd,EGL0/V2&?-IS)d1b8M?R/;BZYKW[-:.63aV&7&ZW
gU6\,=\8H@JPE+AL;+@]S9Q/I&UY)[TP7D+e-I4&(:a8Af4J&JfWU-/=7HR:^DD_
TRWW/:cP(=0<H#R9R:JPWBbA=Q]=aW?+I5][ZLCY4(LQ_22Wc[5+]\bN0+e6[3@f
J+,F+8+],5Ga0>;]OII4I0J-XOb9&eR5ZM&e.C@AID.2_86<?>X0E_7ZM]/EeM[:
HVHb3c1XOD\CLG.Ce?,/R+g>VKb-RJ(e,Oc]T2QK5Z<Z/+F-S?3S0P2>[[^4K?PI
L;5<P29Qb2E5LER/JIDd_RL=HCaLbV+H\@_1I)d.#4]g;XY/ZLM&9c9#HXTfIP.[
@5&P(]MGZIb@Kg)BTSA2Qd0G._DfBQXR42+\YLP7UE\[;geccXY)J\M,gL=3:G_&
1=Z]WW=OYQK[YFfCJKG7A(_<dWFL?5#DO7^cWTfWIN@:Q(<GGHH,WX)AH_)O)LSe
&8=NPdFW>dZ_[W,;^.O3<@a7c(V&2JbLg+(9Lbdd0,d]V66^/CH=;EW7QMfFe79Y
/J-8TLBL5:6\<NQI1I8AS.L>.RNX4c)DbLB,Z^KDe4^T@-fZ#A^]&eX-PF3<@YYg
3G9^R8f;V5B9Ga9YFE.SY@X2]&[5ZB@+2)/eN\9/H1DcbU&fHCTNg9(9#0U1W;(d
&J,[=FdZOG\FT>1E9e:KI=Ae0^T\SWI4+JWTW_X<ZRB63.#Cc^[6RLN+(^(.Y>BE
>&&eYeNPZ-\DPN1+D3W[+L9&e8L,O.VfJAA>#.D8V36.PA.W#]c^IO5M>Q5F)Wfe
D4>VG&]Pb@I2eeD0_A-1:=[,9EWK4.)MZ6@32VN7>P_2f-X4<-#\8NGH<2@Z0\96
07_a7TV+]FBCMO)cg]#4YSY<V.f.90ZHSGe7f:G3dA&CW:)OKIKe>::b4EJ^/Z/V
;W;Ta7[Zc8F9&/&;&1#a[1e6433Ia+f)9T:Y1^dVEG)#b[WG3cK9UPg)L[:U=N&^
7?TFQ(b3QO&D6,T5We2ZKUY]E7]f01=GD>K-G,<[YQ1JgNQ35)<RB:+e_2O@Ra_4
A1>dgW9<@0L1@^3K4DHNUO>bVJ3HT?4E8PS=Z8MHP,<C7&SBf;#=c^EG/N1AcFe\
W(U1(Ga9bP3</b=OY;DH7]QDTDIH\Pg#87>[_NHOeCF7\P>Q,/a=IQ1K5c)\_#2U
_07\)PCI/<-fV]KN6Z^LZeR1[QWQD:PCbY,e:>T>G#XV][692P/FM<-f6-GA2N[R
YG/KAOd#7dBM]#GSfeX/=LUY&9A>RaR;G4_O,V^2N021L3^dS1E?QV9bdKA^3+<W
@GI(I[]8C+O[8)SW);[TT4eX/L<3aG=Od9D2\cEGIH/A)>#FV&F/35HF&+F6@-]Q
<_-[PaFXc47(TQK-K:Gb.RHY+S-B/ZW[TT>Pf4<=:WV8:A<_5gN8.@C/8XSE1NVd
#?Y,]O#.]0>8SJ&V30S\HU]85K&/L_8Pc,/5#OR:JC59.ag[,cERFVT--1V15GfO
-@NSU=/@Z7GW41f6+\P;F>TBJE\DN[&&Mg+1f5<g9LUP9/JYXg@fV&02?-E_T:fP
Q,[_S43\gXEM0W]RCBfFV]_D)UONDKCXP609]2_,L5#WgJ;B(&38<53QRYAJ=/)B
6,H&/Z749+ZVYI&2;(80;<fG.1XXb2c02Z_R2;KY[=aW__1#3P)57(_V?e651+\0
cf5(UOX_UT=\^W9Ag8cO^YX)Jc//D?;2<_Z(&JBeYQ#@U(ggR:2XA21A(KS#NSb;
Lf=VU>\NFU4LBT)P6@gYB.TKO5@P>@G(>gfCAFbV;NZ3<UEVeE_S8LM6d3=0gN0M
+5QSW?@3&N6cb/1UI:FUWF+RK))7fHI?P80cAKYa#g==]N7I/W8MaN95\IVc>+Ea
K>WBgPP__V6O+bQJKg@fZ9<+eHCH/CT_&W:IE]4EbDgTSY0CKaVT,)+bT0SCA@53
<9N.)21/>,DP9^CJP)(I4YEUcGE^VF=EP]5^I3<3-]\dL@g^DV&_]E]fZ3aef\+>
^M:IfHDKE3WcV#_Z^2K@#;=H<ZC.fbFG^U?6)-Y]4/J63CENCN+7_>N)IR&KPM8?
-Yde/@bC9.4HD,+]UG4MZ@1,80d\UV,E2ZP(K#2:gJfDGcDSCeIbK&10IfFBBA;G
fb26cB@8\C_?P56=(cS98CMU]+66GI>2Gb9=UMa2MO\?BgT@Z(:C-bK_C_:#\=V&
-GIcGQgC,,P?*$
`endprotected


`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV
