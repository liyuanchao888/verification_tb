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

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_rn_transaction;
 /** 
  * AMBA CHI RN Transaction Exception
 */
// =============================================================================

class svt_chi_rn_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_rn_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_rn_transaction_exception)
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
  extern function new(string name = "svt_chi_rn_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_rn_transaction_exception)



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
   * Allocates a new object of type svt_chi_rn_transaction_exception.
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
  `vmm_typename(svt_chi_rn_transaction_exception)
  `vmm_class_factory(svt_chi_rn_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
TCeO4)QI1DT=9b=\d#f,a?Q7]OR:DSb=S>7@fbf@cdgM:8dXe]Eg2)@[J/9ZO3PC
1RV:MIMVc.8N?QL5,ROV]KHAM[[OcQ2VJ2=e+2#Mb\TV)43b#Q)c0WA\CG@QHX#Q
9AFN2_I)-A)7SYfXX^ZF>)LR]U+C)]be8I.I)FJ8O3:9>,\7;=:)M2986LI[C4>,
A/JMPgQ;-?T9V)MbfK/Y+70,9:NH(#+SK\-(He]2&E#bI0(e(:RYC)A)W[/.KLgN
ePL(;#)Of]5PA;SF6Jf\57B1QXZB:>S5\c@@#HO7&-FE</LEKRT;UT=4Tg+c_A9T
&+ad59B2ET@Mdc_/e:9RfUfDcP22HF.R^[/BP5M4_NgWZ/V>A,B_BcROc/]cUNS)
;C(a98@GA:1X>9V-UfB8f:1FF)S.EMYC[7+H57.-0f5fSQX75E:U.@VF)/A]AMD>
IGX6]<=@]@STc6)_L6<AC_;SYL8g1cC)W_c79N@.^8cBT##]PE+_NXe=c#LM2WVD
:RWNRV]VK7NYXA3>M[)<&IWd#ONBMMLIK^c?MA3[&.)[)+8[0P[,^ee=L$
`endprotected


//vcs_vip_protect
`protected
MJ<CP9V5QUZ6-@15/W.Ta,DF]6Bd\TU=VG[Md9e57T^VOISKL/0X6(?Tc2.Z,^26
LVLFV5OX?&EceIC\]>7G[P^U_?;f/dW6A\#=BfeYZ@6<WQ?.&Se>HEC7;HN6-/E&
LdY0\.4faWD2NSgD>G29bY46T&PID2+9SEHN^&LQC@RaY]<VZ@U;O^&ZI>c.dJ8J
6[KP-MS-27f(#fPAVA8RdH,SGS+U1H>NY,A;\DTgSA=3U<YB2Z0SXN?&dGdfc?+M
G_16+@\b0\WOOf(8c9-.LZdTMd)3.)J5&bJ3D=R8LLRScNfeW@Q.dag;CKL[(bX@
-cC_V48-,9RU-4=;@(W1U636,#DTV684;\W_EZXW>K8_\A?-X)5;SAEgO8(-GC6V
bZ]Y>X.([P+)KZQaI<8P;P&D)4XG7R1&GTH+)R9@6]>>I;XY=>C@UZCdfA^PSR55
MB#G/M]:4#3g)e?^3SS2[]&D6$
`endprotected

`protected
=]=dTN&)9Y2/g0[+b=FB0X6CY,fCRPcY8=.#X.c)b;2<>VRS6EM..)1WQ?E6/Y5D
d:=:;a0d<IdD&/B_UOPLL&VLR\ZaPUfJD]PL_8feTbP(#_7WWbHFaZ)c8P;\ON>^
3D&X_=BSYMDM93/W8S5JE7&d936DF5C;>P<:.bO0DJ(5DE&g@8K1Qa)cM$
`endprotected


//vcs_vip_protect
`protected
+7[/#C,]57BBV5:=Q6NJVNHg>)Ug<f(1LU?MYb0ZD?PJ<a,TZfQB.(BBO[O(J=6H
I.=VdIcP/#gI?.;T>D59V@:@09feE/M9QP^(d5W-4bcY@543H-A_9M9bLD,K&<1X
8c^Y=&<((\1T7L3L+d@;T#3\ESB]B<XfY;ZLFJ&^.Y(W.T\fAB\J-3La867S9+3?
0CG1BWH6&c;[SIH/a=(SJ8P7;#e;RH-<dPJ^dA/AC.Je3@VGe7eQ@-1#E\DgZO\>
H;,(2S@FIgR;&PZK+-8AKd)VTJ?^TfMS@:PE+7]1ME9.^+16<\aLWa(f<L[@3=;G
8g^d)XMA/4ECTO2T6YTT:AFY1b^d^L[^QeAWAW7#T;=gd/&B(I346A40Hf4,WKb+
UbA3[44\R-H]/X<MZ/FPGc2LQ?03d,^;;:gZBZG@ZJ6)b;#PU\FUJ)B^3I4XaGAa
&K##&^ZUDHHU&B=FT(V<BSL[J&<aGGHF9Vg>:_UV+c))-N=N=[)>cTfNOaUVKg1f
9bG=1bP@DHL/9.45JW\H:D90]RYPI1]bC&bg^#cD@#Q@[#QbL(P93,BWP0dEQ2fe
-@U6dQ@\7.(dH=5:)0ICR.;3&U53XXN-b23-Q0HOdHA0,U@\>Cc#@N6>;PbfdF1-
7-<RdMdWMb/_N5L,TL0c6-Q,9B@50)F2YSbQYW>]JT=<ETCHN3>R0gHKZc3+.cFb
eM/AX_RU(8KITNIb.[[NE@:_E+GdF4E33-bQ#aT9;ZBC\JUJ879T=[S,b<Df>([X
@Z0d0;@6;<Lef:d#YM_TcQ7F30:V,OI]&:d1NSR78fM)NMbAaV;K@_C:V#Sc#\=P
^X@fdEC\g+L5e;J5O#Q2L5)/BG&g+dc=PBH1VB#b?+SG[5Sce;AEd_5QHYQ2U<:M
9b6DNWV^Q^X)WH6?]+/+[=5OW_1Q=e>dN2dAE6VB(42CDG=)D0B2OL6N=)T69WN_
AWa(6=:7+3FYc_+G@<C<@#>5Qf2f1^O86LN&_Qb])Ea8SU:#QO_87Qe]GW:Ec(]g
DGZ1=)XM]NaF9c:,T^=g<>Z31CVZ7,O4b>c>D/7,P4QYU;a@e.6IPO(>+(G,a(3=
N6ABPfYD(U9/F7W0]=FOFAD\gY-#WZ6_Mg]_GNJUfH91M;2V&\ZCJgH\V08PP5@S
VTGVPJa)BW4YD6K5;(R9=W^VBAI@RE<8E/=geN^V^3X3Y72HI7F\OC)_#bO?@1+3
b-(8W5X6ZZ,-9-MM]0)\1-9XA=V>UC>&8F7+NO^HWVM4O)LQ6S;;(RIRL5UEEd8=
QPF[N/A:Zc.=2JI0)2JP^J4480#dL#&3@OaU_O.?O^/ae.G+F^_[e0/?eJ\aOGAR
ASEC(L19V(F_e[W6T2-#-)@(=#I13;E1NFXb#IS;f2=W/@DbU=9L-HQ8/>XML5ML
TH(@QX.J;4?^17aJNCCc8Rd5JGc4JI@),#R4+4UPO4[<J#L7J\ZeEb=[YO\BPe5,
,O\VN5S>9<C2[<W5J@eCT0/&F3b^PXe=;PAYQ7)Y.N[D_XRCaG#2V7<P/9->;P.c
W<<IC..,()_+I)FN=-Lge-DfJWIN/KFgDNNWb]Fd++RM,ZcDYD,M>K,^4d\[a1UJ
e?VU^R=dfVe=M2[=/3bR\2&##M&cWNa1LCM\>Z@8?CI;_WY#TL8EKTD-91SBQ0ef
JNU4RI]Kd#ICceJcG\Ga^O93Ug4gP^g_@Z^b^M[:?N&/Z:2eLJYdPD?eY-,/4d_0
FSE.WJ+4a(0874#4QH1,\gg@ASN#LW8TAZ:3Kf[Y/GQ?GSZH?4SV:Gg/2@]#.PdS
,2d.9+&W^:Fd^)NYHBbC/J\Ig6_Q5[5(OM?UGT/5JO,GLWQ4.+:cH#JR=3TbLDK3
-#4:f<O>3QT5O@N@E@PEK-8L-CdY#.dYf+80f_&DZ@S=e#BdV2HI,;L=(?DV2(g6
^PgLfCd2eRcXJEG:.D-^fZ,LgGX?Tc5afMb9RdSC)D\(FJ7d+5@TS+27[BK]T,/U
:#7ZFJBbf,VG+\D6VN<)daWMHMWgPf=PM)(E0)c52S5bWF+#>E_Q\:;Ob9Gd1NKZ
:.TBBB7HHCWC^a=-5XD,<-NMa9W_P-,CM.M;+Q9ZO/aV+Gd8e_,_&1^]=J772CWb
Eb#GJ/gVT(UFbX_N^.;b^cTR;<\,J1+P16I;[/136<LJ]g\dM:Tdd-CbJV-GWUQe
H9H0=2R8/[-@3D)a9&QB2eYKT-;=,6K7QGK/1R>[,W=3SQW]<D_5-I1H6<?=ZYgg
S8]MaF#I6<Jg?[?)\XC#2A,344b]5\)K@RS#I9?<(;T[8[Z:gaI^O4Q+9QVKWIHF
(1_Z>]9S-YLUD&5Fc9IYQGcO)P.gWC(\TdO.P2/8=()\OZ^D?H(?OLN2AWIR/T/Y
&5GPI7c8\Ad+ABfT?_U+V.eFPe4<@Z4PZJ4<dSFJ#;ERULTV(JKTU293/19M81.b
S56(c6T@<]XH0F75M=WX9ST\S(D4\D7L2G,>G[,ESI2)-Y_3RR+G;f0Gg7+_PQ[E
&:S^\(8Y?&38:BZ9.JNP<@E_;WDQD>C@M8>dS.K<HJ69_6.<A15M0<;[Q=OR\VZ[
T?WKd^T-<.K#HQ7f&G,7/3Qe@2TZZ#[I=NV-6BNG01T#A]cfJIK3c6D6=Be-0_B)
PBb1;[81H-3RH=\=BDV2KA>@U5bI5FKgLb[8J4D,&af<&C==;?),Z+g+PXX7F)Cb
7YI7EH:AfB-D38KKEY-e<B[0N23Cd;(OI\#fZ8-G_[d6P:fPg^+^U7B079Lc6eD(
1d;\L]><4e2WNgfATfQJUAA^PQaM4:YbS&c.EJ_G^eOdBgKX+c/>gIIJ6]?D-Ag/
G=,c-^P/TG\(3cBZf)L7+T<M+aP:1RX,OfGA7A@3N19YL[(3(^SZ=E)-O;T-=E48
^([HOHXS)&#N1()>B11:;I?#0@d/-c3UCaS[#4S88\IJcg;<Cd9;cS<D+J)(#2</
/_EXbG5ec\cZQ#:SS4XLRT-(P<N^f6FU:U#B[N)(\B))@5Eb)<9fVdgdNWHL@D/:
W6O&RYYNc[[<+W9&7+-/:f.&YfV8:E6e6S=#AZCN1BL_;+AJ2RXEV\97_DEK]/5C
#K=c>e>Y:[SPT_-Ee9J51R.1e#afI-gK2OPVKFEAALQ/O\,5g_\?Q#M&H3d)U(@,
Xc\PcO>EYM5eWNgQC<+VC@>,^S)eN[ZI.N@K5QfNSeD5;7[P0EV4D-f#1b<H-.UQ
f25[d5RIP-dJP6RWbZ1]H]YAU(Y_C@8+(X-5O3E44/K;eS+RUf8;[M_.#+K]L-82
=KICS)\/A59S,gRN7?U0T/S9B;7^(:#J82#]8XI&1)UT(3B6)Y.I0Efab<<PDUGT
ac[L,W2G<&5L;A>c6?5>_4&_-d^2T?8^3+8gg=M&:d0CDWIOaA.Tf-bH/DRL6ZW(
Bf]&JN(R(83_BGZ+U^g7e./\YF\L,7H&2d>NRQ:;M\Gc3E=(UXg2F;_3RAHX^YIR
b)_a1.f\XfV<aQQWag.)^Fa4gBZC4KNJFKO3EV[<CaF\:cR1Z7#3_&-]&WYYF._G
2)\Z\J(?=aQ9[[2)./PJ\&IC;=UF\cVEBgPCB9-:8-L44OT&Q,Cg7C8MRWORF/a,
=D+@#fGG?/P2^VKe+bNGHJ-M(G6PAS/@)&AV&\c+LW/@f?&\cA@4U5a.fVR#H2/<
L[GX:YEX/6BLGG8:MaOF_:0O0J66W&\2FY62XY,d=1^=+LOF&SG&GD+UV[CXOf^=
a9;41[]d9BIR037GYPcbMfG)e+.-)Y=N=OBAa9[<=0N<F4BD]OZeID3&@cbXN8,;
>RR([;M.ULT.P7fJAffb?B\\W6,E]FaVDeH#Y7?g.04d@5GUW?WK:/Q+FZ&g=E.F
6+NAJ?9,F^/C=b/N\BgBNVS_AH-X_OeL)cQZ9(E6WM.&5U=(WIPe&&\./LIaRZJV
..M9b,7^V\B?XMUI-0g1b/S\I_O.Vbac-FWaYe?RbH?/XeH=SWCg@-OY8#2&RS,V
<X#>RK/+B15J51d=6US4[F>3U[f6aTP?=@F@#f2<H?+Q0><V-1^R@O-1A-Ng:V8/
FX8^-YbVA)0AHGVdHZ=g548<-,#D]>+KZNC95O68[HFBJ]OSaf=6XV)>YbYCKWV=
a+>0G3JC?&c5WFS5_56-.:(-@#)^.6.&H_I</=SeDC7)a5TR2T&Qb5WJU13\7X/_
a(W3;N)eaN;4UFGQI3G,S;-O@:dHRVEBeBbJ^@J5;DCeFK(9.X+&FJ(+IBBKDN.N
Pc_(:E-DfZ<;T99/_O&C+#RJ3UGD]L6XG21g;6X245SC;ZV1Ub:[R(?O/G8RaG^c
3CJO9dF+1[KQL)?_L@^/DcD><+V[[3G^I.\gU48dLg/7>b<PgN.1GgPFA/dT)NEN
ZF^f<L(Ha4XS7[RaIT6X.Z9J4d6.^,&;Z<d@M\.&Q^^\O,]a&TAgHKVb;=1J8I7O
R=9FQaeU[2\cP8@\8PSbYLQ.4&4;[IgCT1dCa#2LYGYcbO3RO0#eb,QKEBcYM,VH
#G_0ME<9+JCBN+>0Zd:-UODD_7dZ8a5MCN-=E)^,ee7FOf&K[cdaV]PC0>]XXR=Y
XWA@5]a#EUTbIKY)A?NMZQdH]6YEa9BUf[BIK\e\W.[>E6(M59V8aSOZ3BC8/f-\
O<9B5K.@X<M\1\b+E&L2G5f>7Y#3V3TBMaB0X6N2NV(Gf&b54505g8-=EF8:/\_-
DgGOSd-M6--<c=?c?3\&JfDLO(@/6C;ddTERF^FSCZ+O](]8W3XC0Z8Aa)0\O;2d
T\-<T[10_bbBP-,_:.2^?E.f/0,JJEDET-SFP6V0ga8K?b-2QX2OU@6ge1DN9a.8
S#2+/Ic6JL6e?;WREHL(&/S+LF-(HKZX>M5B](0C)X[)LJDWY9Z5,KN0>P@9C(/L
b6UCd+C0T;2TF?X-8(1#L&4)L6,WJ<@bMRcS1+MQe+Z3V;EWX[O)8WdS?0R&&c:A
bD#J]FBD7@@I:9[UD4[8gAGT@ADQ,L[V]0@]Z=SY19(9\eU(8&&F47b\acfJ;^DC
7\_Z8dF#RH6L+5#J=4)WPW7SU3:e<3aUH@.I.Ee:)[SB?VUU,C1UPK/g.=;.P<PG
.gBOM\fUDO<eE(#?Y-]PR\DDTG,+A6P<)OccNDbH5&C2f_1+#+OFB/N)b13(f)]-
.X];9f&.1H\cfPUZ-/gF7Jf)6E@R\8Ka:QfE2)[3N2JA7G>,E[a2OOg1;YfJ>3+Y
d]M>V,XC7Lbd-)GN&4IAUWSaRKAUW-fg=.Hd=Scd^C:I\7bY^=-6=UA-ZH&0A=LW
S_WLH.NN0HbB_^fCc3+[B0.Y8QDL7?H=d[GacMEc;>@:b@QD?2,HKOJ7ORR:QP&?
JBeQ]CV5+O]<)FFP01=e.OMe+TFM\[,WD7(I;/B?1T,4bXZISf6U/VA^R0Q@28NX
bW?&A@:.c=Q09ROBTC5:(/(RC7ZIH-0^H:0NL5[U/_egR;bbbI@^dTP]\PXJL^AR
<@JDE2LKO]5A3NAA?DVEI2JGEVcRadF<=FKUG8+0OOMIfY>NRZMSCcL7Z-TF@-Bd
XBRE1?\F,>E>XWf\O@L7,3F#\^96G[71U9TVaES:[.I1/g>\N5.++]\3?^-OXLSQ
;V4\>,FK5eG69B2[03I]B9Id=G==;MFJ/d/cN=cdMc:GGV-:2P18OZEBK7/H,7f#
gY9LK80M=;T;b)e2@U#C]5JL#B9eHUJQ:UIDL;(D94:?3D[_8XJETP;C9SWM=\U?
+Q<<(W\YMTa<_Z]A:(T#3CZ?5KTTXANKe8^D8&YgUO0.a^28bc.GULJ(E91<6(?-
eA^1d8U1F-;=>C>Gec4FeaKC1P/JRI+TY_)-XD3GH@@XLeC3827T:XZEJ7c^F;RW
fY(D5L\]&0=T_3?8N+Pf,RPZV6PeP^&[_cCPS.R9E_D^98>XB[;L@LAQN9gA^/.Z
aeFWT]E7B5NPIeG?=T=F9U\=W>PAfW&LIYd:4M3+C2f7/DaGGJ+:M6a]C]#<V3#7
gI>?2K@H8KZD5[,6^6Q5(Db,TAAF_OeYW=Z7L1,13Z&?ae(NO0aa39@@-PMg60/_
Fa(Ya3_Z]EI03G_;6&;43ZX=&94[gD/=UZFH^VI/J_#P,??8B>ca+W#EC7:QJYBV
=]>#\-dG]\J+?3.B]<7FgVKOa(\-2a=250#NI6H3#[^QJ(]1-6g#DUB[fWdJ5Ge<
-2;/D7]#(F\S?(Q9(Eg21;@&55FTJO/00Kf^_MCeYH/.32@DC(,#/JE_(-^4XT]g
I9>)f<D@La5Q:1^#c6f->&/gaGCMLHU3P;):YWYQUU>^IDI,U)3H@0Y16AN/_:&?
-c17DUHYTMdY[9MSE9+\&&.Q83F<XYfJ,+6[\\=E<ERT2-):fX;.ZHTI;R[2E;OZ
HC=[;7_&T[+L@(b8,85BW1>BFQH.8ZILE0#:6VI&,;3;RT#1dA,AL6M:5X_E,?#U
A(,:PdU1PWJf>K8?DX>G:R;APK7GM4ZB,\b3#.^fC9cRVFFE(eXKVC]>Z7?f;]Ve
2O,b4>Lb>[(F51UOL0Q+8UL<-3I-+X+:0[:W0<AZQ=KYOf\]H?JCc-=;f]]QJ_<c
(^8(b7.dF8(/>]d2V=4OR5?5_T3[5FFRVf8a4^(>=:^[Sa\4F)=J_U0<1HY/+ZUN
+X2T:bXgI3VSa&b=/DFc+OXB,8-37@D(N4_0a)_G7FIKd^XbGJ.dQQ@9-,M6LD)4
XSJ5/BHH=QIgJD9CNNI<+Z6[(Kg\XP\PKUZ6XPHQ+N8g,5@-f=@A.Rac--A<0\0Q
2S#4/Lb7c9>T\<ReCe0G->;NeJYN0T>\45GA1M4N013=2U9BQ(15O1IN1H&R6a<I
1AgJR#W3@99/-[X,9IQ(/1Ye/,WTTT3;]T0K294a(._3&\9cfN\5,[NBNJg_.RBN
WNCL4D@@MSefI=6,E_GTec]Y#B-0DJR[)I5T/<0?D[ObA]P2<<&9D<HGfY-@HA@)
-^V13e]3f9[>;>8cTE=XZT-J_H#&5KgK]P_T6?608\J><A)065cO+9DC)IUT_POE
-8@\KT&c7545KGJg8bW,-0NcW^.DP4BC1,&PN[b&B9g,BQabB[6cQ6PJQ2MFZPKF
5Z@[L7L]0<K]NKTV]S&dME3cX7FX2BB<H?6SaAOe@_B:X)-[XFM_2T;2I3NXc+>P
SYg/_R]3e7Q\3d]7KAbVJ:0,^H^\S?QM/-4&8/7aF0=\([1#C/,@A-(7+FYHRM5_
UdG99S1a5&RfeIWb)^&7LFW@>3S].G&JBNWHW>fAEbf6.APKMPL1g0Q6>6(IIUgO
BFA(dGa]WgH48&0-1bD)2?8a+O_EFbX?C_b38_e/B_41cgO@M(LBS<C03a)=C1Oe
27:aUQSf.f+;5&IPGS5+_CWe2g5(Y/c-L[F@D&fa&/\_-aUOKDYNHYI/RCLC7UJ)
A=(B4X8^R.5LDCQ^<G(KP&8@8H\DSG(V5QB[XP/S,OT[CIEDHbbLD^R-822I9bO?
KT.F;VO40L6adG>O-(VD+SXB7LYfRTDbLPcNXHAOAEQ8U==6PI@)UKNC/M27Q3@M
E\R/T3c^M;BEY_-DMW)UENY[/eQ+9U&P=Z@?BWU92YM7<I6eFGN6cQ@0.dE<&;ab
bd-K\VZN&YE<FDVPF;Q8^LfIT3:b+]Ve#QH_>f6<fMe?dL6+@A#+b@?8X2f.6EV.
+AL)X/SW;F,1.GDV[.7/2H6;c;.5d8Vd(8HRHc(1]SBK3;KDQZ.15FX;b)IH,TEg
3SHX6fdJa]=aB#TZ<ZH,?9U>VSI8?)03_,&KDOdCW,a1TO4BC4HD+0A>.,+?W,RL
C54QgGKEA2[I.@d-A8<O]7;eEg.eTN[H3\5K78/[<.a/+KK_\H/+TD_J102U^RGC
3;ETe]c>3OG:1&^a;HZ7VUFEQRaY9,D=(P&a2P;LegM;GJ1PVEHI,YFbV>B]86P1
-X5@38/[&d]4^Wg6ZU_?[KD#MSP\VM+f>b@Ad1P5a(3HU[Y+QC]&IX]OX[E;Z\b1
[DJ)36./EP3,WX]83-94I#_B_ddTBBHY4;1g5#dfIR3F.:bd+[P20FQV##IXFMDN
8cg)>b[SUO5AE7,ARgdB[.;3;cg;JdUY,C_EcG(KO]W7F5I3MEb>0H,DefLX=RcY
3.P/3c@gSW(\-PCVg?dC#QPg3@4SZ4RQKYBHV(<aI8bf#dE;4]25eANGHZP.WW;c
;WcS7WT_C+<F8Wb./1.=.EgW=CF:[.7gV1S:)\TZ)4XVU)W?A@MV091a&f:X;,+8
@>:NPSQB(HDUf?NbfIFEN)@+L;S37Pgf4-JX0;3e5>aCN_)FBT2N>#71S&4A\XWA
0+8M:0E^?O2.5>G[Qg-4RM)^-QG7O3gf,dJZ29YaJD1PE5KZ.HF9==(YKVPMVO<@
Cf?3_^0+fG1.^NaE,J/@d:Q4_JP9g;JS9VN7(QBB7A[N6MR,3Q#7XY[NUR6QW?RC
Y?b]cT7UEgX)dT?e:5W=#eL;Iag#;F@F\\E4Cf._@/2JQHCM5Hc&T=HGL-ISb;.^
OIVb>@Q/?2MO)A/1@D::W7.ff)?HBT#]+POVY.VZdS<IKOg>&&]?a?c,.,QBN<YJ
1F4H6NdZ?2b++O>L-+UVJ.2_HMT@E7Bb;;AGWKg2&5VP8T&KN[&V4\MN#@3WP,F=
5FdbMeBB;LQd;O]9Y19/aD\5IV;T4],M/DUf.WY5&R<LZ_+C_DM-PZN:bE:d43D5
-[K7KMQ_^3\b27.f]/9I[.bb0ZXe1PR@W4FVa^_B5L0[PG?XKYGT0/Z\K_7+(8?]
ed>DF@#b8.;F2T;5[I1.X+,@491XTL(@Mc[.U?U-Tf;8AJ3A>ae8:]B\_62YHX-N
O5V5.]W+P&d??/X]1NZ\-;5g1V5f@W-EFMSC6JI&D9g1XFIBEPSI@BW51,;>c]^]
5P]=F56/(@MBRdO@2^KHRc;79K6GER87Z2[J2;-@Q>31/1AWNGIR7<O&L/5BI+a2
N]-O&:17-f9Y3J^AO4MJ-UCEZ,BDM)^XS&7X^d&(>DEE(-H3:O1-3Q+Of:/dCX\R
<Yd;FKRQF8R][-5)3ACI\:-187@+&]a0dOcS-45]-AGPbEdR_OJd1O#MNT5V9EbC
E9a=)-]EeR9g5M)g<P@(DA^\62M+JIXJ4AQOP+\CDe73@9K/)7L<X?;@B->@906=
dc,;&?L+F3VTX-NI]SW+X?\=eN<0R#<Y)TEP?;]62/TS.3:a\6NIME-[J?\C[@)I
+SdJ;^W,\(SU.PXAVO518@+5?4U8N,]a#.RAaC[M2^M.^>a@Z46P7W;4FYHPON>.
,).g)DZF<e0V(5WbUb_(64.Y:\(E0]W4.Ng<S?K7LLaf.3U@[N/d_>(15&;gLE/B
R)ZH\V;&GU?\/C^JX<.&\bKO@XGf.UN\1g+9PgT7&2\IKd_5M;,dB4\+,3YJN^S2
=4[C;I3_ES.QbBc9&1[O&(P//(V@P#_H]PP(6_,7HGOOEWcBXFO6cd[5;N3,fE:^
Q]4IW&&KDC.eP]]]&H<=Fd;+[>f=g[4b-_eE[Qc(>AZDM8ETPcPM7=cE#.E=)XP#
]A^=fa#@d;[5Wg(0.8gU3\,Q&+^\Zc;\PX@dN3DC/DYRH/@DT8DB.B88MET97#)G
UMJ@?JZGgH/5C>_9\b)&CB\]3N4bBEfP+ABS:IaSaWbXC,))M[Xa1A+YFS?3T(K-
]]HV,6Ucb3g-B&E6cVaM^8XYVN-?HCcL,X3UARc/S;QPU?[;7SJLIH\<DB<YJ[GD
@@6g8Z00M&5dB(#S1e_Ca(D>Z#\UC6[U[dbB93Cg1e9fC<#[X8V=fQ)8)V(:dd3Y
.6&bD]X&UHJ+bc6P9=0gb:3#4c[)-dL0VBV^05?f\(X@G,XXf0<VQJM1EVg:-2gb
06@C4M0_DFJ6RN03Tf_<@;/PG@Z0#[1<N>VHQ7V+:-XKS[K#8(R_Sd@,+YX&->Kb
S3:VUUfIOL9^/>B&VU].]-D<KVM?H9&<>UcN-f<2T@0I[+bfP6>UJT#@UA]1G4T_
WC+/b+U+ZTE0RGS_0^C);@9(_)dc5Y5KWYZ.NF^fdN483f1;YYP<;?+F#AAeCO92
.fN5gY69IH.\FW\MSOGb]b2^9:aW8L,D[,<@#UOJGYU(b0Z:<6D-7S#:QJKT>3X.
P(+:@^]Fc:([gZ6Td5P/Y^VXeP,[9[Pb/5&Z:K&e5AK^T5g1.IJg]J[@E@3eNN49
UVf3#CffDaS6:V:S>/AcH0,F1R\33:Q(75PX<NRA8;]bfc<b=X;9]K-7ga0Q/Z8[
F(Gg_GHH;Z=g1)2bKgL6NI>2^C8CXM:+?@4/<=+67^a,)DLB3e6#K=AK>5#F.NP>
6cO3OMZOOE:T4^4>Q>(O7,-<TC<>Y:e&=&GDF4X)A.Z+Of\;4;E0PRXU^YQfP6[A
fG#+8QRT&NU-dU78P#PNJRf:?NQdF\6aL6c28HfgJ?bGa)I#b6fXL(0]:LYM<\=^
\IH0a5+U)#Ud8a7FB2bK=LK&3JadJ.)03\LT29.9M[(S?c5[@Re?E<3=:eOVgfO4
KE6/;>CPa\_=C:gDPBB8d@#J@0?(26@]<7:EIIgN0E=)>?74I:d1GG6>4,D_:OA^
LWCb+#&.f7?.][TB;YCLR8&6,2]FM11C]fM1EJ+gP6#ZTLBE_RP)7-a3WK5XYd<Q
&1];2Zd(XWBfR6a)^@&ZINF\fBdXXWJSeg[ZOMfgL6E6fJC1ZC@277P+&,=9[S@(
f9V+\[7DR);<EQc75Td,?0>;1\84Y8#VJ(JL>L6K#V-efJ@SFa2>1)8GD=91:FX7
+(,MP(3)eB<>MN0\b5K[9OQI],1C3b&-?(18^&0,ON/7fS3eBOX8.:Jb><Xf;]T#
9;::Ic9fQW5_3W>fF4f>La7/D0;2aFBf;UG9d2bcOY2K.I7SVY0/43Y;X[TKb@JI
B,&cZW>F/1d5Df0([]0QZc>=fP<F[&6.;aG5(7+4Y:1KNPU4<eL3=dcM@>(2cI-f
eOM=?0C5?&::9MIb]XZ2_/aG)O\HT7)M,?I9ZRTTdAb<NaQA16Tdd.RaMBD;;a7<
e-_D45A,a\EC;M?R1TD?191<S8U754<H_<#LDVc.ee0^Z#OQV#4;.c5O.b]]Da15
:5_PNQR5a]11J55?G8CQJ?7<04SD6Sf/\R_?Za4R9UL&gWW]N3d;])gJ7.][DJ-Y
GCAB<F.FBI+J.YZ&Ke],^6;O8e.><d6>\J2OMM6)d:JKc]D=U7AIg[c[63]?S<aL
ER+K)7F@[d@\,AWYf1OWSKYP-BO6M=JOBK_H9V,<O-.Z9R,e9Q-W?^QP&-1AS3XT
N1=2]WA_7dH5f^2^JYT?>VV):cQ/JL:V55FM(5F-ELU.PD@BYKcM-0_.[ZE_DSTE
Z.[ff6gV(-A/R\U7V\^Z><f:g480G1:-1(,:5c-d:5N=,-ZF&UU,M#TTOC+Oc2+V
aQ]=B0J7G9H0R=1f\JP=7ZSBQd4gPdI+@E,Oc#aV7Ta09OHO(UY#K0\)MX_WaQSE
FEXE5OT)TZ4bW=UZ0_Z?TDc0G-0RO1YP^SVD>2d=eJLS?Y0Gd]RK[cIcCB:#,LSJ
BB&BPD]VgF-YN#a^b>fE)<bcfc.VNA@7c5R;#bWYH@g,U#4H5NaaEA]OFDL]>XJ\
H0>7Dd26Ua=AI=:@A2Ccf/Sc0>b1&N@O(U\P3:Vb4FEKZS-0JUHT,EP1)<Q2-K2D
I2)L_5QeM=eKO+4>NdLg#4;M(5X_;><UaWNdg&A)PY#Z6()20a9[LJ?;#_b)-)Z-
@8ZMW-_3G)@.e.T[_38ZI2DO8_B^+ZE,DfUdaKg1RbH8;=2ZR:.WI;^NGTGG[W#=
J1&&d[6e0UEKTcB(/A7/.70gD1cIQP@]G/;93eSTR+c_3SWdP)C<bJWV.0BV,3dc
>61dZMZEfTY<,4d8NaAgY]0Q#;WZ;C(6]c&4>SG/;2+QRJ2Aef)^dHD6\+c;LUO:
NYVPe17=A+[@\LQ37d(eMLTGKe#+E^D8af@)]M=IMOPMTCDFU@#YJ<3B)T)-?M^Q
)-a?8U@JG[4dPf^3+4@RIdJUA5769K?@9Y@8B&:bVMb66I\+g0OOD;=WeP3Z<=62
8b4FE@F>e]CGW60K@TS(\XI>aF]]8RKb67]V/=e@RQ@&CT.PD?YZ(0\OB4279+7&
]f2]?_X<S64KAT/Dd_SDBY8U#<,TK=U2.3@Qb5=G#=HaE[dD_7R,SB7P?C<T3P?)
+fZUbY80-cXf(DU64+1a\>LQ@>90=RdW>]5:D94#;AUHcQgVJ[F\/AOSW?9B3M1a
BYeKA_E;Q85K;:KV=H:[8MH@aMC])XR9<^<ENe1[>]/Y6gC8G+YPZOf]cP[KD&eL
KD77^Aa3JS),UYB#FRC1Tf[[4DT4+Y)3@BR9EIWC)(UJ22>U.1BOLgKcTJV=QQd+
NI-7/GA07BdTA^EB<I:KR<dDbHABIMa0_3P,;Y^P>S9gZHDg#NQJWe;&A\3RBg^a
J9?\67F^L6LAcP<?W_>^;c2M41/R,Kbe;-1+0E,F_T6G7.RX;b56>VaaZ,d,YSES
G[?]?U]PR\-WbN=R_bV^E]+6FbSGM8A_,6UWA:PNO:3c&E18:\9@/).O[4[8EXD/
b/=XAU8ee5-S<Y?@EF_@4O_A6WLS#?0.AB;f@9f5@YFZCD@]>L=/=C1&(cYHCFAI
Ug9]&gW.6L>/E:Y0?#0:e5)Y6#0&WF,LTA6eU:.=<FR37f:J?DZ83Q4\&MV)M_^g
f=2XU[XNTRYSX9HKZ,^5Y6E(@H4cU@a<b&cSR9,)UKfOEYcHPaJQ)F2cZ?6JIQ]M
KR.<SH=(:O)Q8CTXA(E8bHK;+-+)8)<U48FgL34<_^-_&69B#HMZ]F78Qc[>CIS-
=W5U0\?9:A9SCKB03@e@C[0++fSH:IVXE_\N>gVWCQP.1g/]8[>U0c4#MC_:NZcC
T7KZ/GCfdQbJT+>H/dbbEMJf9.:RWf2S#WLU=XeD4B@I_KUDO<^:CD^(?(^(fT/F
JdCUQ>T3^XeQ/Gb-fS<P,d,H[b_W&RXAWe/fMM]gLafST15<Wg/>8JS4[/^JBKgZ
X7Z]]NG(D=:TWQ=>2T6>#@YXR<-YL?[74YZU\dUBL7+N:+B,GJ#<,(PL-1EHDLW&
JeTg@TLIU2.GM?O=.A\c07UPQfP;U=RFDK(7L4/VVb.HKePP#RX;D7/TNT?\&C4L
I2-;7>\8bXC7;3<C#79cHb)O\(&7M46Xc0N511633Y3C&<6],_/P^D)GH;=gcC^]
2_Q4O(&@++,AfK691-XJ:>@@TTT/B#LcB^]:&=L))Dd7BI43,M86I#7(A_AT.)O3
EQKK@gY-c:.c^^.DXT,<X]GR(],HY>N&E8)3)f5BS:96#9N]^(GT.#(:+^:W-IMP
;]9)8]>39:.#.BT#\[@)CJ+UA[gEDYI82c3+UR46VDR&05FON4S2T/2gc/-0L9.O
CZ@BPNdbcI_GKNH-&8fb6KO5/5bDG6UZ73-bbC4gYB-,F/g5aZPT+N1]=Od8O2Zg
;eN)fA>T?O]G0$
`endprotected


`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
