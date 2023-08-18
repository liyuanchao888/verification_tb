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

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_common_transaction;
 /** 
  * AMBA CHI Common Transaction Exception
 */
// =============================================================================

class svt_chi_common_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_common_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_common_transaction_exception)
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
  extern function new(string name = "svt_chi_common_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_common_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_common_transaction_exception)



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
   * Allocates a new object of type svt_chi_common_transaction_exception.
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
  `vmm_typename(svt_chi_common_transaction_exception)
  `vmm_class_factory(svt_chi_common_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
LX_g2.2.B@9=CKa:ga4<aEeP9,:@E40^a(UE9dgP1^HQPHM3JY14&)XP[1Q\RE.Z
(J;LR6W(5.IMFMHfe54<A>ab1MH,@R8Sb=f\Vbb@6::]<GSMU8]8d)U\/X&[ASE8
0KRbA6dLN6ZKd7cb\B2W+L#/BAT<500^,7dNbN2@Z5NAYLDX4N9AbZ5e(UJ[94;P
WHc-ZL>X7&N.19>c@W[__WNgbK5@gUJ5NS?/WP<bTJ<QO7-gRG_Wa;HZ_bVC(&O:
#/0Og0,MS?RAK9g_=MP@P8=2+dJU8D)2C3]QE(N;-95M.0X2FgSFK5(CCF3Ce(4U
gaf@OI5YW8H[Z;OF[N],KZ-6b&4f_K6,VRf+gPY_>6H(?)^dX,F7WG&NE4b(5U7/
@XU8b4Mf1L239BM=Xa^e])XZ2&c3_2EU-YGd)3(_eKB=:4K>H_EF)16L>C^FZU-=
>4eB:3]X&NJ--F^fa)48\QQBLca8.f:(3NI^&f<eRXbafMT=1N:<;H3/;I0P[5L4
Cea0WC0HO\3QB2B\C1.I:?6L]\C4M(7HNL0\J2(P_TQI>[BM9GR-N:N-7K2fJS+<
fM?R#^(8WK-Q,$
`endprotected


//vcs_vip_protect
`protected
FNW.8M?0TBE#UW8_(@/bY<.cW>O/O.G^JVPGLJ-MX;((I[C:e0KW0(POb7gTJ1<Y
:XPbR:g=>JG2B>+[Z6S7IP:gRK_N:W:-e9Je/MT,0dB)HGSF:gE[:g0I^dT^HQ18
SA,>LF<7d<&)(,)OE2_^d)I<KZ)N-_A]DW@0?R1XeW)/?(MWb/O^QB+QTU)7-U6V
XXI#3)/_9?ZJ#MCCF&PPg#0bd,6HQ2Ve#E&M\e@H51caK<AaITf&)I2Wd0W#d])P
KbcL@0/)7OB#(a5/OUf36TB9#HU@TCU9[bQSO3&OF;^0cP=YX<b8)8:[K]KMa6?Q
J/Q-)@TaGT71@K.M5HQf^IRWG/=V0V(M@AXH01MWOd1J/>4(3]8S=G;I6^N9eDY9
BRf8^JZZ9Q,8eT[WQ548CU?.NZ=@G&#-cS:ddITF-:#UE@VYF=^C7KW]-<GW#E)E
cDC_8P[(I8c(R8CRSfR2JSH66AJ1\N]7:$
`endprotected

`protected
ZQ5ZE)YG^QRGEHgK,,;UeWQ<AZ34g/K\XU[\IAc0b2[fWN_LUOe2))QdCDT7R1C#
-+e.OUQGXKG]0c3g<R4(/^D+<0SS+YTBWUW?C^C=R\15BS]<(CIdFK7+C#24Y6V<
B5EI5KHaW=\-+K<1ME29V1X+Z_Gd78<W)F7(_,)(2Cbc+YGS^YC_6H7+M$
`endprotected

//vcs_vip_protect
`protected
Z2<f;?,XWRJ?d7B:Q>L8+00@VOJI7LC2QH^^:Wg9KN,g-<JDENZK&(U3d]&X<-1#
QRPFP7FL:7S)P>Tg2?d<eUSUWMI5Mb/C0:HRJ+G.C4@ZRR98RFM_<>e83H\L:g/^
B;DV?Pb#f-SY.d)BbJ9g4,5.^;3#Ab/Yd^a;;S8G4d2AEB,UFB)?2=Zf<GBb4AOD
M^3Xb\Q,WSEe(_fXJge7UH?V\aDc\QA;/^.[/eY=8<F?b0]:#8I4->\CVZKH/SF6
b4,5Nc#c8^8<af&=A2?Dg3-_/@Ibbbc(0_+ZLW;)2X6f<ReOX4#gMdAXA,a.K.LK
6g>[;afBeZ#60\ML:0Z<KNY3ZV4]RSOO>]P8VH#PN-<K?gP/J]04M1Z2b:#Q>1eG
3AcU:.eZ/TR-XW67JZS(-3e>JK9VGac;&Rd#V^c-(_<d2dUTW,ISL1gXM=0QVbKB
J#15@YfP529Nc:5VRP.?QaX/P-Mb)0G[GfOVf&W,K\>^PET_N-9J#I=>2KdWOT=(
7@XTA6SB/QF^(DebL@XQgY-c]FJZK40/KRO=70WU&R._>-D<&;[c1(0-OOGK=P]c
8_9<]c3A^DO,6GNA;<(GS;B5>)FO\II)Z:eLDSIYO=cQ=D)a@HBL<>4[(^T_?7d@
@7cH9N-DI4[P4gF;2:^)12SS;GA=TA;(@CXG=g\BbRABaYfF&BWfHR8[/IdY4A=;
(O120-SOfQNb9D33#Pd_I_S_bSCB4G1,HT(_N;[(55>ecQ1gXaXS](F4G]V0OJU)
_IQELK,V1_c<Pf5D=5J+,L03]T\Kd^gF@L[PR@278Ed0acW=P^0bWNB9((IeH5JZ
^fH:.S?\FQAe]&/-?5+NAXXLdc,RDT6;O/?aBW)aC@4aGL3De?+GTT+J??1-g]PQ
(C.TUHLR+PWK6DJgO9Xf8WSJ4;<#4U=0\)3g/,WDgV,,4fU+P]:\(-Yg#XUHLQEa
E0Caa.PS81+dHJ19=YgHAKT^Pd2&)M3V:EBB/M[;U#,7[aW<;9(SG;FMBN]FG#I2
1I/bG6(cZ)5.E3XII#,<U+B(2<Y2MaZcW;H;?eW_6G@NXZ)RGWD<+CF-FIKg=(dR
fd33[9RY>IbTD3K52/Q0F)(NPQ:8Pg4RIW;,6?fQe),CMX9JCaBc\&^U-#/AeePD
YK\+dZDY\+0P8T?B7/I79P+^J5?D(E6\0d</&(^F0eN]2#R2.9_CeD=/Qe#KL]NU
.N7KSBU5#N;.Oa7G4+N6GGQ[Ca=EagBYM\4:+6a,2a8]8ZZbPZG=POB-6HV/#H,H
@L1Y6I^>]YC#6W2KMcP?Q+1#c<O#SG,M-^ZVDRTK#J]EI(5XY#U1P;H-_+gGF;_F
&6_9F_\AF,5K,NG45]ID;\Q75[3/1514W&E4X0)KZ9EZJ4LV[P5,LM6Q]B,Y<I+6
&Y\;/:(0+,_BQW,O)78-:B9J00Z4:P<@/Y[]:[DXJAdDJ)9+GB];G\8K8:?=Y85)
4.gME<NX=Z+]g1LB##ZX#M]XAKT3e^:([T.H-.410d+GOX52F>[QcN>-=_#B_M0I
Y-0/HOXS2^A8fFE9B1<0A3(C@S(JE5-FSgQ^28d6CQ-,MLXV;YF2H2d>,HQ>ILg?
8&QPI-#;B<gbT)&T.HY1LJ21=FH>QGJ4H>:.3+RGWB].UVC5SDW,#1;>O1MBEY]b
F<MFPdgM0E1Nd<1JG#e)eO7cEBJ^PKJSeS=e7b--\&Ze;F4X6/]8YE_JcQPHc5>I
O8<f:C_Q61MP=1^ZPWP^[GR1,=F\aR/(.8;&cS^FS?>@XSCeDDT3\,\a8RD#<g]c
4QAeDOR1SNd<E3(D9L:KJ>L?;37a@dO[X&dd-@9DY3bM&F<5O.<:@(b@YZOE?E^\
NE_?P&e+IXCgaH+ZW,EN/.>.)_fJ-.P))8?78#?WI:]:JA[&Z94J^Y=N1-f]@R9L
7NCHFKKMGD^DdZf2GIe[90N:[4=WV_>IcX=22e(UddT.H>LM,ND4.8#c>]F;#A#4
L-PU<#BPC;]6Fb3;)cX>QMX+GgNXgAPW:1L3HF0LMSQeT(TU+L/\g?X.Fg<[]&^R
?d)0H7U2W&A?KKdH01G.K)H7CZ6Q?V<EMDNZP_^T/C7O02K7K&[5d/IA)SQJ1;K6
+N5NAWZK2O(A)N_V.Z@S1X;EX?-A)RcYPH&KK?2._T[(([4=<R0^@9XHAXUPMNJB
@T5D;QdS>g-]S?Y8cANOH\X]ABb(&8X((U#AKad6=WfF?JGX63E-(M+1C&,L&-Y5
C0D8#G_3aT8#eMP&e/AJH.;&[2H\MJ[]P8SG<WW1BUf=Sg#S-N#P;F&^G9.9(5O]
g@PZ\7/(@VO,TD8)P<GCQ[Q6#5?K-(&[E0?-6Y];T5IFdL5\F>GM2W)K:>T33M0.
Y,38S,OWLT>7CLBg=JUP#95SK@^+ZJG14e3UV9C)&D=:_MJ;3E)0bF+S&Rdf5Q@E
)-gG9#E2&7ggcYCEL:^.b+?bW&I?N,_=NHBcd3aVPB^d<NSBfbbFJ;4]DEeSeE>3
MTcd9f?RC3B9N,>JD]9QM3?,;E1CeYdP_5J9P<_D+c>_0?c@F<X9-G6PL(2T(7E:
X>\Y3(+cL-2ZGLSE-U]31&;=HY1/?KP/45)J:/F=,dcY7M?90LcH)\cJJZ.NcB@(
f;&=FgIM(WU21EeY&[g(,-A].1a<g1GaUTaV9YdGbXS<84WBY#7LK>R>72/LQGKZ
YIB-Y&FSQ2F<-B@1CH9;)USHB1aL9;H(c>7#0F78W=cK2[dW#(Y4H[e_&)B<]_PS
c6?7)cHaV)G+N1g.)\WQ-S4;6;OcIK<^Dg2X=?gLa^,T&gaOR7V;OOF.P#U&92+=
Tc^/]_+?0HZV85FBU2C92cc_g,)N]Q</d;^TNc<1?_\Mf(B0=I6RaK4^2^/TAI4/
1F)/S2PW(.J(W1d;@93GY33Wa8DbMM7KM:X[+@cI-.(d4Q2DET-JP&4cL6B+[D;g
#.HIPPa#eI7NUGB,C@U@M=DT[:(OB#8b01:G:/22SSC0bc,CcgLT^?NSWJ8NBXZF
CUU:@bc_SHJ.>Nd2WQT-I:a(]7:N[@JF1.Z((S92Z-V@?/,^8b@8&e#4c)/8D[;:
d3.J96-.-Bd5POL.YPeOd-aPH^MX]f/.DX-[#8b[2df@1B@7PcTNKDeB0IQW,:+D
6&,=aFP;KUW@bRR+X5E/;5]e0Ef=aF80B?2[fL&_VI.eT[fE#e_cF?GD;;Eb(_H#
]aDgU-4>?#7<P&5_[Y@D>.9].)[B3N/P3gK[S:gZMeMZK2V0JV.8?-R,LcVg@V_^
T^\KJ\6.CK>PT6Bd8E=GPaSC4TJ.:@Y;Z+[7BB?EeIPUQWgcZ+666W6I9AQI.[eV
T/L4ZU\QCS(3.R2@gO8F5<CH<gP[d&C?J)0AP:Ea<d5XFW4(:+C:J:O<^M[PH;dE
XZ?]gHZ25f&38EABfAE:]J(&PP_8_5f6P-37#I\H7M)9A9];D50;XWO?6E]XJQBM
1+-g^a.AICTV6K-20HQP^_5cI3P64JVBQRNM?b6T4[I\O^UFD(:U)aZ[P,LAfJN)
AA?+5HbN8225ZCSf2=PLfcHUJ?WXbH?7OR3[FK1>#E(\SG2-\9a93;,^9B./BB]J
&HWM.Z67H075S=Y4\VAO+4URSB7?DH#=OQdG3KMHGR4KFB]385F-Y?g5N]-#0OTC
EJV>f#[6cO1+?U2FVKb-Vf.Hd<9B.2d]:U#<1PH4=]aY3e3S.=E4O].a3I)(9gDV
dJJ_VN>4g+HBdD^c10W]YeBKWS^6)-V:=JB9DZOJHY\/UdaGHgDf=bA^4?<6gAG]
2?eJ_^a7]dGPU3^:)(7N)-)<Y8-M-aJVA0X0+SQH-S6GOKCY@#EJ=]MF<&LJR[_T
gaU\&0:#__6E=83@7<WPf^)NF,F6K,J(,Sg6S1)H@](3XfY+E7[KDcQg>^78F?RA
J]L6\N^6LN@V,d9EY[3^N?^6JT-3TUHO,:C-)LGacBf/EVVe<MI[L-B?YB&/81e4
>aHaZ/H/R/X[b@:OKD)f=N+1\^E_-,(eQXT:Xb8a56M_>cH1N+IWK]]WEPM5&>L_
DU<MV-#11d?SZ@K(0DM^SW6[R0.c50,9^:IgLgR<:94(E)P1@S@LSMef4;^C)W]g
WLUYQ5UF>FEGYYEQ3DN49C@B+gdP0]#VCSX[=##eY5NC(\(f7DC67U(<//We0B=8
9M/-c.INL&1_N03g(7^=F8.9K,AM#_&YS<YL&9X@1(56b)eB&A.[G0HI+2EgKVK0
Q?V4&cH]&(cd80+0ZS-9VHbPJNg4[(5B1;AVd>RA]eN]3LA5C=MKE4(E<S;CB-IL
d-G2^9ZGU:^7T--\8[_,?MLg^L)&:,],a\)\&H<4L&bc?9<BLK4-3QPKQ[3e5K05
Y/X&/Hf.>.N)Lea&a1F7MG\Jb#1\N+Bc6DY6A+&9SN0c3]<Ce3I[#W1B&c:YP.Dc
_/N-0>:IBB<:W<DDYKSeZI0RJQXb6/BfgO<+)>]QbD^M-G:GKL:SE5^\C7?4@3Hg
c@JGUIK1K\B?JAVT9#1/&0;bPVF-6&E7@VPHaH4\S=^,Z2d5;S,S-;d99)8AMXc?
31,Y?Z,^==dB_INXZ/T2QG?a[:NW=cCUbfC/._<e,E]K;7-.dHTe>XDS6TLe5PUB
E:/UD5,BG\SJYJ?Q]RODR[)aVYU_-a_Bd#UBMM/<d,8<#S2@QBg9f->>3+Yc\C^I
4#g<<Qc)V6]UORME,,0:gY/X(E<6+(\b7SYfLadU?+<Z<=&?&7Z\SF9,fd:0&YfW
,34fC7_:3U^TaGV\WQ_7W()RK2#SDDQN&U9KV+]&LN5]<O#GN63aLZ]#Y-U84:W0
=caUHX^U2f&)<2N?GdPagGF+#A\K\#RfW3?J4-;(643Y:KLFd+LZ)V2L2:eScVU4
J@O4EIJ&;)1,+7/9E=?V5[4BL=MW7AV6>6C-RHF8F+^KPDYQ^GW@bES?JIX\)A3O
986M(WH1?P?3Q7&d#J[\#>Qc>5]PJ,SL@D.VP/D?;#\Z(OX34eU-=HG-W&aI[_ef
;\ODF;OA]@(NNb@CVTY+dOCXVRE@I6Q.?F0#a=&K\T]TF=bdKe7GZKTQcS4()(H/
-)+QH5C>56P9,3TSg@MHAPN2E7]REM@_3T-#)97(Z><]KWWQEfS>3NH?(Uc-1gAf
Gd7JGBGJ[f[3<T#6IeX(da>Qf,^.XHYEZ^[_OBJ\>a>8FSS0V7A6?3EN_6D><6>,
gFWgQU\VW\.cD_\EG7Y(b8,NK1&b(?aOXe:=6B0&d2E>2c+GdgfXZ/]#b=5YOZ]:
UPO@&@WEH&=H[RWYA3^-&-</DGJ?[UeNVZ1#919Z[@b]9-?eG^c]GFI9,8&WZ>>W
\N&N9/K+X-JRASXKdA1SH#gUO73,8::1XEBf89]#>2U2A&HfPD(79=cQ89YR4<2^
G,;fKdfRQ5:-T8d&4Q&Q-ReeL.F_:4fR[J6/b2/a+RVV?O?EIO5/L3C1(PW5D;PN
\S\#1[/GJd8d]]/>RC32A3_A;-4D_)DVFdCdV(dPSZ&BJ@?RLdbQ6]RX@Z.d^>DO
4RO:ABM[(3#=8RVW7MX9NG7_C\_5fIR[@5LVa@&TeGe=50ROfHRV_50aQ@^1N@6f
?PebgF4\XKZ8TL&2[D\-,E^C;>YQX5W]K,C-F.4N4AB;cEQ4E]#9/6O@/EAWLWD<
4D[/.YGO;^:/M(a]Q\NF]Q1R5^W,;(df[.b9cC8.M5T^CA.F3K?NZB4=H(WI(J(F
-M:P/aO</<0823e/#c#@AO1O/d07^+<Gb:+/TLf@KUC[cE4IB#fFJ;D2gVf=X5J5
/7O-<2A\YJ)O@KfJ?@3X@b\\4O7e796?]b@V,d]]M#L3f_10DDN.]_3]O:_BKVDU
L,/K8\H4@[2^NV[L\5_^ZVV:487A4)C1.QI4DeO,M<+bda40X,/XJ7OZ1VPcgWW1
Q9J^O.;)GWMgS0DA]W@ScD?APV]=)g]1c?B97:&O&KLZ),R/IE&-LH#S/UUL/,Lb
<7JC?B7H6bP&.L]LIfcY02WKJ:CWI947C(&JMXA,RR832-->AK7C4Z:QQ9/1T4,:
Jeg?EeP(B>PAG:LB?g9bd8_)g&(F_5Q6/,6I>deL)?A\&-WIaLET,86c^Ie>3T1H
CDAe.#\RB3_,:X)g&/FFLS[<IXRQL<-:F2_+W8:K9R=PSaGKMKLHW,)4JDW6JT/f
0&Xe]4&<&?d]@[/GIELQ5e+\]MX;aWDGP&^;]_GI0L^ZSGf9-,<DB1>.E/LKOd1.
X\S3)4>fD,N7?32gf&93::F-9cL)Q0gL?CT:6B]NRV;7KT+R2&_:DY\;O?OOYgT_
b[\?=7;0?RU@S6Yf[PdMI=>3)AUL(ZH8L8&2HgM^7.I5QT4^2M.1X8VS?HIDa+,f
:XdY[E^_S]&1PgB)>M3Q/UWQV:EJAQ1;7V-.D,XIF8#1FNWXH>MY;HF\dW@R7SD_
AY]<A=TJU=@+/+:3D2:=L::HF,DM0/_?CZSbX<9?6]YCWO>>gE)XD3Pg-XTC3<G:
[\5)(9IYId(D,9S2UBR>B85E(@U#QY7YHa<#(-C0FZdU,_^e[BUKg_L._;fOGCUF
^J&91c-V+_Oef1L+VNDbe.;2R/GPDN2,^D>eS:S1GB8@:M(a4T]fdMQABaKWYI31
>0[V-IK5<JL7d&d&[M5;0(MN,cZX+^W)=PdO4bY@(D<O^gS7^,09<eV3NQWP9cLU
+.T?);4ZQ<8YNU\#[SG9;3d+c8\.XY.&&U-Pbc5;RHYNW+99DJ0g0fg3_<3?D=-;
,H0G8))NF;>APYL+]DLV9LA7@(O_O5,P?N-D2?-GF_6S=4<W2^daCQ\?>-f^8ED=
KK.:e=_0UO))>XA1CLCQ<Z4>R/QDeceP3JK[b(K:#G_R^:(+W2LH9/bBEd:5M)HL
UIS#R1<^gdN7D+f8+>R@7QR/R9EX/LL4?]+6SCK,\BYG;[,I3+;M8BJY98dg5de]
\C_ZHG#A68;a.a5?C0E,A;Y2M&=8>([NWT#SB/IN9A@>CA1.UN-Q.D]Dc8(fU-0X
OO8)\0\:>V1DU1A^KcS=-?F;NeE;A.Me,UTIX=6M-\9(,B^1((]cUc_PbJ^\6c0W
0>TPB&76G(0C?T]4#9=\E80UeJ(>aGWQ?XMI#,F#bBc3<2\I_B6I:NN1&=?FKD&a
HZ2O9^8:TTLO7[\c[3))NM=#Y9bO]DWITQ?bNVAL;ZBIdWZ;\fS[\27QEL^V;cCF
&KHWPDXd08LHFA4RR>K7<NJ=<RQ-<IPYbDAI?A:\[dLGT9E#JA=Xa6W4-_:KXMGc
<I6D9fIDY;LKZ-7V7-FJ59^A4HRLH8VVI75K\&dBMG7[RK7=;BNSOK()&TNAg4JD
5TSP\:E\Va,f;F,VH+9g[OZ8T[>1IRK46HPF4b?@9G7@]I=K0<dVD/Zb^/@6&aRT
K]\9CB\c7>IfC23#MO9_N-C#AQ7JA-APM8J=dR.efFGHW1R7A78>,^W9W+Q-;W9_
7D1c;RDECY?WNbS-BS,99;4I6:Z&VA\4@5ea#S^[If>33:(6\f9&g8NEA_fa)^G.
e==&.C=WQUS/B)cBHf8SC3PgPb.#61L3^DAB&I074VSR0;#d6D</)f:C;+SU>TQc
X)Q/7OE.M0PR=?bL9OL+W<C>KeKC&S-U#b:@HbA7@J;\XHLgKe,G^7e/EG[9_DK\
>K@@)GC^Q+94M\WeZA/CCUC6XR&:f:)c&J[7#d73H]3gD8F8B+UE&6[b1,PNc0S1
ZKDeIX>d/D8EK\bBAfQ5;f5,C2>N:MK-eG\287\0(K^=@#K5bG3g_Q<?<10^4@4C
Qg<DcfW,1+fPXa4_eU8^KfH-N:TbA6QbcS=\M7=,1aD)D^1GH7@16dEX244(H[U1
LYg(V#/\V\TM#<CEG[XCRc7N0Q6+KBZ75<1]Wc\E/J[T]\a]Bc[G+/\3)>(>Tc#^
[(@]>B&]@(4NB6gN@D\CVCIcX>1\\fHZ<L7abQ74PP14^X#WF5ETaM##9\SYD+R9
L\2JKM6B&\P#0\F.@dRD;S<X1d9Z@ZcRX--4G-9GS(Ic7X>_K5T1KR1PL9>DdC4_
=2<2bggQ]-^G/2JQYI(;WF\2EY4(2/LLX_+8,eV+84Z\gEA4W0..Ia:Q.0X-^MS8
^<7(-HAN,Z^MIUAfLc2)Q;X6-)/1)->/E4)?AM]=<[eg+_6-T7/E3[07V]B@Kb2d
8&B<12Y8He2Z5,ZF]\8/PQ_=5b\_/d7,5Y53,8Ddd\V.QZRJR\=W?LIVaN_831?]
KBN[He.7e0XX?4UcZQ[TPBA\Y76gRG\_(+D8Vf\L([[/(2WCPNTCeEMgB/c2>OJ^
+_#5D;0BIbFZgK@]+.,>,O1RVK>>U_&(+Ce7dJ2_MBR]bI<4Z)9612WCK2+UJHQ:
Q5\:J;I61)Y#5.=e)Z@-bPST/<SFE822=8HR7d9ETGP0FK6VEgGE0]N-1C?2#BGQ
U),/cZJI0-c:;8aY0L/Wc=J-J1fYD7g0,#495B904]/9<VA;9Rc(>Y<?_+IUW/W)
&JS[2cG^1GRfK7C=H)-JBe\09bQ&b,d8;#Bc-D>D,BNa7D,X<P)O&;VcFKdOb6eT
^8):[P@:G1^KP&36#H-:<MY2fZWCf-::\<Q.XKMUCUL0\HRf-AAGC6I#g(J&^:6c
B9P;M7]1[)^FU_/WTMREd[FCS^^.Q)4Z5R?fM9JDQ_SKd4)^N@J@[;V:;=2=UQe[
Z58)3OgPM-C]G(UcH(FQOWfa3<5N0T/R@c0_b@HCNQ3JAF4)7F,JNA36fLG+F]db
4V8IA8Y#G>5e]^]6D=7=cC-MF>]JPA1#8dD3YW\]XJ662?J\AA?^3X#.Cg:bF151
QNfQW-Oc/CF4U\66PgENd?2&?QPDbDWSe_44YLU/:.+aLgFAF]AZRaPCb(>g=YFU
\a.G7KLC/c42V[L?+G8WFK6;O+4LdWFN(XS#KV7H?668SICZ?1d\2NCM?IJdCd85
T>&,cIY0IGNE8QA++RO[CPXb#(_NdMFXB+J]TI>.IB[.?NP,c=N3[P<b1A^P8Ld8
)(OPeYCVDZH_:bM8<,J6MbQKOFZ&a09eRcH+5@dFO3eZ:\R8<.Bc4OK]7KW\ZZY1
.UBb=Q;O:ABY6;[/)P9aLO?CFd2f.JEf)P(#ad+RW,UW.?e0b#f7LNFY.DQ7XXG1
)aU5-F)eV;;/5RbG;gdN/3IC7BOL#Z5QJS,WSO8N<3UBeQ>\-U:ZKT:VT_Bd?7#Q
64._>18-=][VN5M<-JD^>66AYKaM9@T&0.=M-X;+,SGN?8,R:QEJ/-Q6g?b;SFK/
O1Z[7?10cc9U8QY0&Q9MM]P[@]aL=-X\&HJ#1#Zf3cXR[MA@,AFPPJ.^d\NI=K:D
X/2,=\[52UcaMJ2#Bce&S)=34T7KKO=)OQMf,=^4+1dJ;YYVA]U=NIe-d]_QM.Ge
9,Sa1]PQDHR?M(M0DCIA&K<8dAI0(>2DKbbL>)K.CSQ=ZA>B1NaUPTVa].)c&b6X
HMMEXU&[,2f=9@O&/94VEC8cDSgOc(3+&80YYB(J5>cJb-ELe>]Q4Da)-1?,PJ;L
=8MF[T=E#d^OPIVgcV0WK(fD_2,N)Q]#(D)1#&BRHYRD.1X0_gf;4998g&#U4Q#=
,df;c/0O9YZ\)AK53@/dAQE>]I8OK-=A,EL6K2\PR?VDe;aAB2NTFd&/\X)aL^N2
7/&EQ4CXgMC.F539353T2#8QEb)YB5OVIZ/b:,/UZ3=0SeaCCW/DRMMed,,]dOPJ
e0gL]_RBbYX<RG(:Hb@f=>(,ERB,A[dQ&@^STJ-C^J416fDWOU(\TH/&8SFY[5S:
&D:,1<RAD2G6Q8AI[.+@XW4N)gD:J;7N1(13Q\&D3B,#EYW,Y/-cS95L.#H(:dUV
5NJOK:<NOIQ#^+K4J0/-MZ/^6a:/C^]aOH#]W<Q7=0M0OO4P]9bY;a<eL<G;<,MU
aGX6g#:g&_b1DK4/UDY;DUg:A(6FT+.R9e&_,0c[7Q^#U<MLc__<+8PY9MVTb(H(
\c[gUXP2^+V<gZ5V.+cHWgU910Z_]3D53^J@eL)WB&g492KTVZe61AF:a5))_.YY
3/&.F8A>TR3U:3JE]DX5)U&/K/b#PV6We2>I1Qd14E_82?c4+9;8EH(;2f/O7PVM
#3-b>Ie6OSfAVVaLZY9F_\JMODB9V=O\e+:&;#d273)cU?UPfTBZI@C118fF8SJ-
IL<1X/PdUC/@\Qge2W_gOX):]\64W4C.&4(B\SQ.W>a](86L]1>Be()XdS.e\)M6
.b><O7e.&@Jc0HbJY4B&&V:3__Z,=,WbEfcN6#,30S1/,CNXHL7//^Q6R?7>H@44
EacA:7(:#K+1WJT.L<L5BS+G>fP/8dDP_gNC5&CII.6&\[J?\?Z24bNZ2<(ce\R_
]1_f=@,[?H2ebDE2(cG\030&OZ,.MZHQg)YR.N&OJOLdReeHWd=fa(R39a&JJ@(8
-G<6X/@,@EO69[TGfcQN]SKge929^S5[R87MT5WG<S=9<@&.(FG^;g/8C8=_ME^;
fKd,DVS@3\Df)UI9O83[YYQ0^S.#O<<@M+O_RKeL4a\-422D]R3TV&&UP/cG1H??
TYYS,LP(d\S7,I,RZ)U[SM8+N-#@D(1V_4]D<HF2eV61W?K_6925Rd;OCV1,^.ga
RM=F&F[f8dQ>Y<DRLT]cSH4)9#>6,e4F.eG?YZ9/d/GPP;JgM1RE;+==BcY4R4_H
QN2K]D]3Q8+2U[,D2+W;.c71GL60Z=V<U?&I-\D0I;(eDYRW]#>)VQ7LFNTYZ8CP
F1MQgW<c]4B;#+KVSK.]Y=QG6?)f5/0/+77)C=J8D[TZLH_^YedQ=g)./(/9IdZ6
3JUFKYZ\R)LT\ed9c.+F_[^Y1B[G#9V5T:JX9T]fGY@OU\TBa:3ENOXP@0F?TO/]
/X=.1CB<A[53@;ROV.,8+T/0F[Td??C>g1)W;@Q?A2&D<H+W3T&UYbF6a]W^9\cA
P+A&#H;KO:X((NE],VM;M;3).54Y,CON=Gd.O:;C>TUb?65)X+M8eRH9.7VHPPGM
Ma.?Db<@HeDgRDJcgQ3dCLV-T\_U][b:CEe\d>YJB:3(:N>c1^Q):(WM:3K0<N-A
30:=36d8R#3@d(,(-E5HRN8N)_>a^b_1-M6=&0+)=LUC\1f0J.9\D86N1>8O3IFZ
W97USOfEDU##:CdIe=RPQ7@\[g2UY@;5?#5;,0b]]YX(1Y;.#Cdc9Dc5][aDT;ZK
,1AOQD881H=T2V[YXbg#P@]g8b(-KH8;LU;Y;YK>YHU7]7,Y<Q;1.O@e7Y-JO+YP
43#B1<8g:aXLX._b@&Me,3Z-b^KWBHPX<>SB008:(d?@\U#Z1MW34Fd\Q2gWd2Sa
N,0>V^0dRI01MdL=S6_1;_QL-gfd<<@.TZ=dSK]])FU@d(eNLSRP_Y](0T>7VSAG
1EY<DG=.VPH9P[,.J>6L5YbZbY1_,TDC@0FRcZ4&Q]9BJV4JGXH,@5/0;8P/#)[I
0[K00?/^AdF0d/;O]/b>Y</<,52IHJXg#Q\.\0QM3/#G6)@[X=WY^@#eQLU<g@Fb
Ng>K08:TbQ752-T^+;)OC9<T3?0_T4/&R0Y#b/U4PJ_3Y\,S[X>0S\=96IK57CB\
Jc6+L(Tc,8593B,f+H8,&HOJWPe5M:@517R8IJCB6Z01Y0NS1U0-;+T(f9DO<(#B
>7049O5COM:aLHQ;5UREK(9dN,TWJ.0+YNE6>JeH?<0THe;UM<a_LN+8CFEO04OA
,OXF6-J0V05HYY75BI,2Wa?8b]E\BNbZ76(WK:SRXdg,AG?F.Db-_c:(7#PMM;R6
&g0<df@;cdR0Q7;R=daV@WUV_05g>B+.?5UM;Ra\b^^S6W]CXbd/<#c2^(_(Y.Ta
7d6f^Q^T^T]21S^c667_==HFJ2E:0^YI:Z_GZH5dE5^9R,0c96GfM\K0M9.F3dbC
=#+KX]Q]+OHD^fPOC<g,AKEU3<c+V.D\MF/0-8+WP+Ae(DP<X8gI6cMXIP,9[30<
7/#f.,.0_Gca3?U>AOE-(K+g5S4D#LYf3#-J4]FQ^GB/V[@\(V5XOQ\T=)&E4@LH
e@eNF2VZEQ))UeIRC^&c)RH)1b:XV\_\07:Dg?D^W,S>9HVC83\3I<.E:J(V<L67
GFD1=b])N0(BA^acKN>VC_Y3)]>W<7gX37]a<Fcf3;[HY7AR//&d;DgFQJGEEZb9
?(GJOV<#D4HOR@X,LcaM-/3/cLRgF(I;2V;7/b/_c<U?6S_/WI,7gRVc3^#Z_S[-
J8@X#RF;2JL=L;AX-M(L6>PeB@7b[8A=8(&d/JFWI.bF5Y8=:T.2EbI#@]+3+ZNB
;[A)SC]FN;=bO[_g2#GN>eWATRbc.L.]U&aeZ.<W:8ZPU<\MPD5-OE-A?FO^H8Lb
F:_0e>2MdDc4J/XN:(U:QX;Z\/HPgWI&556BB?73(,V2DBfLBb?1[)XTSG,LFU?_
-ZJe^.Q?Cd4FP4++QUQaK)e70b(Y?RER(@T2]R^3-d(a9^a[ERS2\fQ5,9b-[91=
?129>-PEB:-b25N5dO+GCA&#TB?B/KbYLKXfMIfXG&72;:ZBE_HBL)=e[+1:+c;>
W(V9Y<8U?<Z8Pa1CROHfA:^8FA-<\9=VJWa]HDP-UfaFF^(gG<1N(-_L^B2@-<F5
EYbcANET:7)7aW9+NEEaEV?cR;PNJ);YD-&@7[7&34I28Y)._K<ee\S4V_T6a#UA
[KE;X&X-S_?_YQb6P6=)73_:4=KWbK<KEE3)34Q^=g:b=KYSdO1&]_F@(^3ME;gc
2bZZa8(?AZ+#TI-/?9]N9fNc\D-CS8.Bg);])@8IXK8H#,U(7b7B)FVb.b#A#R8c
&M3M4eBZW)KVNLKc/L&Y&[5C=M3AGaT2PK#LbRPS.F8W>EBEPVI;I4,4EaEb1I4e
2P4[K^EI83Sf4:<dZ&2O@<MQK:R^VRf(J)U6aXOaWcQ,9<]^<P@8Q+Ac;H[YJeZN
8U?@HL[QV7T,)99\RDO3>A#EbZXJ3>4bS]AWFgTG\.MKWU.1bO9U6gW&#U-3Cg^F
#e:,__5aE)MPcY]G)Q+fZSC^P]3A]46H]+S=,+8g&D9;LBL#@)(f++LCTc(=]83(
6\+AG655cbT9#4.MDfPM]2(ZP-+g5MQg+KgG<H7;N1Y)a:10<,&ANJI4LQQN3M^:
#cZ[#Hf538ffVYI>e4>QIO&T6C&7O11U[FOL/IOV6K(O]#/8MTWH-gbNL>/aKX&@
#6f#;S75K6KSQZ92Wf/PH0)I/;eD9PY\Q16f3R9[H:MW)_KBb37+37<2=eI\@bLW
\N60>(dEfNNdV\_01K0[LK-@deE&9HH;E)9;/;)L\A8(efUM_@]2QW7NR&ESY2+8
TgAG+Ra]@U_76_F<a_&<<@@Q#C]]Y#e9E\3fRR)+(+<g]ea1=)@g/0(R=693c[E@
;Q-6JPf5cdT-M1I@ZdIUcdH[5?/20MecCMMHKHb@60Vc3f[X8ANJKY60afKOB^_A
#E1L(JDb[.Gg:6/S3D_5KMK4O8(ccRFP<GL=VD?0^#dXYL4L,@,\EfAgB#NNP?>e
]FAEbVBYc8P&bK#79A/GV#<H=WKNXK=#.b7H0XfSfPFaL)X4H338eTAgP$
`endprotected


`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV
