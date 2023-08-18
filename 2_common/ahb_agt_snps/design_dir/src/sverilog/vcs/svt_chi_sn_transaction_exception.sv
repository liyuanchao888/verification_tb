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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_sn_transaction;
 /** 
  * AMBA CHI SN Transaction Exception
 */
// =============================================================================

class svt_chi_sn_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_sn_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_sn_transaction_exception)
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
  extern function new(string name = "svt_chi_sn_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_sn_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_sn_transaction_exception)



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
   * Allocates a new object of type svt_chi_sn_transaction_exception.
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
  `vmm_typename(svt_chi_sn_transaction_exception)
  `vmm_class_factory(svt_chi_sn_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
G3eHRLC[3HS76K\FfAT#;QU_F(?.J?6X1,L;+I=9E_&K-dA9DgGe/)Z2L]4_YU]K
HB.O-F^7OBXN/(H^8SW2e27ZgXE/]3\I2+92d\UW]9.-gQN<?WSI3e]NOKLMI&/#
gH9U=5]N(Q-C&,aJ1_\PT8:F4AW[&CXQ<Y^0E.XKJa@,F)Y2:2]S<#Q1(\SRfba3
T.X:7C[5d6++NO_Gb;_;=-5/UM8X\PH74X4ZUIH.[g>Q@>fF1FR7EX)gd1f\]b31
N1&05d0(6EG)Q/YD<LM,<<WW48K4)+@;+.7=N5XgZ<Q&c14UcH.)0TP)>C_\NXb^
#XIQK/Ja2H6fX/X<9Zc<C,KP(B3(4b;d@/IN8D5X7559/U]HW6J9/aI842GO_EBd
eH^(W/J<S?W(TDITY<^UGGEG>Q&dB)52>M;)bS(GPH5^?7I;(1SU2:91WJGER?^[
RM(ZW4,.[3=aDU1)6a1db70:7Y+C_d54]3>_RgQ8#bLA=IJe)+/Z4DWdBV-Nc/_X
7_^TPC@3O0HABWG#R\;@f.E5QS7b;[N/8g4ZMVR._R;]#@Z9.cgZD#WdL$
`endprotected


//vcs_vip_protect
`protected
VW2eFM:)CVeRAUVfSfM+S6&eE#35D7Jg&B@2:8.f4Z1VAYC4JX:</(CbRAAH:DPJ
,A-?CSDD;.e)7LK:7f&]#e6USO:K5T<+QHHLWe7,[COD1JGD.&>5LP@>;G\Z7SEG
6EbM8D.:FI+9Wc383LX=S@;7M&DeA@:019LN_BV0(QdOU.+14<2<J-+I19AQ&)8;
G\gE:NY]P5/VN1;Q.L/F3aS@fTJ.>=<d5<c4-VcfBYd9DBf4\d7bG56#29-5J8,R
83]@bD^PFMHHaU</)T7gYQ.#.b20BC?G0X.SMb_U421BXR(g216C8<9:H;M(FC[J
:N#\0IEOH9(8RMcJ&OD;<eV7(CIT)7GJ9$
`endprotected

`protected
<D:-]LNfM/JO?V>SST0=^FZQHDL@cPfY^K?3&+[Z(L:3++-/+J^Z&),DJYWLH/6?
H_ZV?f&X0[9&0IJX8YIL+RgC\\M89Id.,4CRVF&7WcPbOPR5:,IB\S7-.A+I/YCG
b<b[E>.^WIe1?,(db98Ob14G7T;K-USA7gO^1Z/2Ga:_NOW:(EJf5>UL=@+E[20]Q$
`endprotected


//vcs_vip_protect
`protected
-WgX\ZZEIbf5f&^(Z\C38-Sd3,19E26<BN(+P1.9IG4?-aYaF;Xf6(]^OCQ8)NVb
T,@eGA6M^8@(1B4^1VQV^C8a=H;dUaR[.TV/0_K],50Ha.>YF\E)WK2\COBc(dee
9@;c1RHC0<6)BMM3?[X5;U]L[00P687Q?&f5GZ=[aMc7\U_&:bB40#0:7S-J1d&I
eZD\(J<\<<Sc7-ZKMH&@+HI4FAN^[UO+f+5H=LU8/B\@J9\B)L@0D-9I64.eWB-3
U(@DYA@NVPU0fG4/648AAUTMeG@JGX0V\.75U[4V?4^Cf]K#]X\GYKc.dVdMR+LX
5N&EKHO8_532==_2/N0[:HJcT.c+WfW7,]9NA^J,<K]M)QXJE,c[LLN\T.-BV[=9
W]8PA7OO(9)83GeX32[556KV3LY\)<Pf+G:#I9NC,3X]Gg+9KdXT>[=<WM9-MMdJ
+#fb^4U>g_F0?ID>)O_>@bUf?bKS]3B<OP&d/+FN#gV\YMV.=(TT^VOa)YN2@F\8
JJ,1gg[L/2\,><F(IR1I(]CK^>fHN>eN8C6AVb\a=#&+D;e>P/RH.6M&,ID.KC^b
(VV\IdC@PKE<g,=+6/eE\N72[[P_Z:aQ/4bRgCTAJ,K)8(APQ#L+W.-P1(@XSG+2
M^VE&R\5fa(aK\MGE+DE00-54#74Se6G7Adg--TTYO+H_^I,Ka_RID,PYfZWWQ8V
YU46Lf+NF9MNa3-_;-5K0@3_1O\_KQX_4P&-;J.@\6#_DGOMCb(<6UZ2YAVXB2PC
&+@H;.D]J-UZ1)IbY\N]>7Fe-S,^96M+eJP-BEdC+ggOV07JG\Y+ZYPZZ2-J1)#3
Y2TC6A&8P#9VMeKc:O^W_6A;eLU[/V<^CUD.J6JK93M:0>R>90g<&J,BQdbCg0<]
/2QgHb71HHLQ;3LUWa=5&daGNY/5.>IZHAG3UZ)/H1)756bbS)<][;LIS/#Z>:S&
?:7._[P6f?KA(:R;?gKGF28Y]8D@Y2]]#VUc-BS<PYJGRD91;:M#V2eRX1<)VO[2
H,VW8-f2N/d1N6<<])/J],acaeK[F#J-(RJcA=/FQU]eSVLd^9d<U-dV_+Qb&5M]
/8>g_Ff>1cWN>NQ)^RHfE0NY0#QTISQ[O,,,3X67HR5BdCYQ9OY_aH&.#_J.]K^T
bdfL?XA&>_9cd\@31D@AXaYB-]7QPeM=Z)4#&H/3SYFYLPb=b#1;UTBWZ<+R.(;f
+8E;X#e>QW?+U.+Kf0_/CQIG78;^)T1=;A1ZCU9_LH11bJN>I+,27KLEGZ/762ZI
_R&A-_6G-Z-bV,bJ?fKVZR)/J?D7/R.U88LO#QRS04eJZ:I+4/BDUB)N=12f.G1H
U<^&GQZF(F?=Y<DK-.D=_.RHU]#<_YI)]G:L-)O(PD3ZU,[ZEAFR-5L3GUJA=Fg#
.UXQf,CG-S#(Vb/BEE-&9:>4#G:JZD-V;#d8dO/MFJA,-VQPY/V^]6A(,MH]6I3G
?H#]-7a:UM&>I(8RDU5Z81e_^=Ef9GAcCQ<=d8<<bD&H@W&V009&7ZA4a;8:F/TZ
R4ZMObfHf1Y#5R5gACd<1,e=QZDdAXbDNa?#NI&eF00).\E#XH,&5d2G)cU]8+M;
YLN@DD-^:80EF5g4A_.GY?_^:N>ad[fLQ(KAX&GPW8X;6Cg8g8ATe[4:U5EEUDTS
<OEWK2B&Rde_>X0=4fAfP^SNg.\#),,2:1QDCNN/I6^9fEcf^:dAWg;).]\Z_=/D
ULGYXb9ON];;FYJT1N&6HC@RDUa>ZM=F3N8ZM6+a59RXB/fI@OJ2L>4U1MZ>01M&
6MIWef-3-6N)MOL].MZBB@WV4J:^aC]]QR/WNGM@F/SO>YX0^dMR<HUJ,@dO+?31
[2BH^D,01)RR\MZM&@,,?V^UXa)PGC]AGg+&67@;3Df3Jf0BeR>@^Kg-bGD_.cZe
RB0U#3@DY]L[2T=f#>CH-b3.#H+Q8\-QPNZ:XLa>JZL/TF_4G[Z__9FRQaAgHY(0
OAO@=@ZCP[D2=8S^f@_=_12KZ2@W^JMAD,V:G14Dcb5VV0^\N\gTK]RCXa378=S&
:d(L6cT-dH(WPdPEX/^7=,gJ2_?L:9P3.ZCd:<.>a3;WZ2U1#>d0B@DK4[\N^_1<
PDL/N@CY#\aW@+bWXN)5+U76c^D&c=V2R@F8<-7A8GD]8fCGK?X]0>FdW/,dF^3_
;G:KA8-f-GP,_2\&]8g5&_&B:6)G&\38]2M-V^=W8#9#\B-N/KK<g5F.WX,,Kb=J
[G_X[fg:JcN_E,.[Bce@_56MHDD_4?8Q\:(K#-=;G[J#.]7_W7bRFMFe;SGQC=,[
<R8Wa5I,W.;R\/Ig3R7B8KQY8D5-EDGI?E]cY63Y-dMOPZH2Y[=\.]UR3THLQIG_
P(R9M+D:E6&a)O2<fUCJIfYSfL[9C]/A_f7(SCPLR-7RdG_@)#^UES[)2VUMQLGC
6I4;?3#D13eZfX+2Va\Sed\bZ:d^:FXd0-Cg77K4K(b@U[Z\M?4N@Z\dK_SF=T8C
-ECb=<X_deA4B[HHRLD^.-P_Z;IIRLSfYGTGUUFb6.Y\T?eZ6L2UD8<=(PMQ4M3F
DYd^?:LOA17E8E5231R5L9&XK#]g#5LK\Z.E_ZdE\g8APV/ITVde3:4I9H?-K]X?
<K(g\&<5b#eZ6U=05eK-GX]VYN0AW&JD?K,B[8T+&=OYf2?@\GRS4;eI)fV.bJ?f
,d<MWNWb=KB[O47QOW3]YV]59W=@FGcN;P&7SG#e7Cf=5-:aG(T@50/dD\WTe&97
YCG6Cbb_E9HSFe(?A6DHf(&?8/XfCZPB7V,^/56NLP#2B166-S9J+,NQ5+f3?+WK
:?\T0)_M[(&LY.@ID;aDQHc0[(aN:G2STJPKIK?_G&@S,e,NX;5S\9PO_0<Z1)>=
fPZUH:UEO1,cb8@-8CHKSZ=:TffMc3&/bZ(gBK42c1Va:eIY@(=E6#1<;4;H@<6/
40ADI():F-3C:>;2>a5O1-Hc?0.[<D:YQA8112IOT^(]GWU3&265a7EGeRgbT)^T
7U&VY#2UJDC9+)XD)af@L(JXR=bFfV1b4ab44^ZfE#7UN/W^]a;Q#I1=J1)_#0TF
FcH#)[&?0_bdTfaWL^:4?E_A9Qb.gfMa;=MY[J8b&d6B[5Y#V&K^N\1G(2&TK./Z
HD+ELLD3APW0e-Z:C<)]2aN+]S]@5-;;B2N6PC,K-#)L90WCX6AKU=?PCfgW)8.J
D49Kf3&7f3D^cR^IU0^)KdNMVW&\N88\@_aF(8),K/(QI#&(Hb2Z-C0G46X4bPM#
M^)+ZLE..e)FY99K^9Y0J\Q#F^Y_gPe3]RNS6)d6VJBNY-N/.GY=^Ld)WJdLf/2[
XRDA#N@U>-O+?4D2M;e#C_PKS>+D=OR3a1QMZJZ9>FH#M.=L<R5Q@Wb+L6-?7@60
P4R/5TaccA4\QO1>933O7M)Q&:XUE;(S4+.MJ3dB<)2.[(F6=NVdII<=2H35J_ZO
+=WH\1<ZMdGHNeG6f<C#TM6R/a=SXPN9])+b<T]8&#K6ISdWfNZMMaF=F8a(0(\4
3J]e,X3YW?6,^aGO]PQ:H)OBd9R5b[\37^0L:F\,bGb6.:-=WdX-bE<RN8LXC,[G
B;8Y>-FUc7L8T?+5^6MH<Qe0Q0[^^-4<]TeH2F3dFf\<(e39V2=47bd_B(FW7c4:
6^:;JR^@b(V3:7.GVAN.cOTaC(T3d>]^7.V5;[YL+6>7Z[LSL?7?DM5MK&I.C\O1
_S/Y#O]==+MfU946aUKP=:Mg(M03ZDZb1T9Pg1R?e:8\JMP8V:;AQ,_@?X>Ve]4_
#8)#Y2>(A43bc<Xg1X&g3A6UcW25.36cgUGZag[JZ(PN3<:gLWY)b=X:G^V2d0;8
fO5e83+09@JLc/+K?I<>[SGcBYU29TLA,/0cU308&.Va(>HV8/N>df/1P[Tb4,8O
JP0@5-MLB4CPAP1M,C_e^^[CcC0,/d@O).9,1[<8.WLP<FJe-b1CS5KDZW+[;cf#
]E=AW;4;7#Q8AE4[#C)F54PU5F365Z_N1_a<Bc(,PD5:@3JRISeGWIM;-Y[>>=G#
_PfX5addPS74WE?(::)B.N>beVF]aAY+)CggEa?W9g/P#0=P7ZIM^9H&8G@EdED1
\QgPZ)4\N5E/#d7OJQg,)?5Qe(@8[dZP1FG[<N+5>^9d.[TY?a8HaGb9e8X+Z4^(
/O..&^CJ1X[SB/f_B:ba]WSg#3[6W<GYN56G04Ge?8Z38BXZEE+?d\cXf<bC8_SB
c+6?I582#G&&;MQ[185/f,VKLaF/L\].SN;-6;SfX@7+.7N<@LTR\c2GB1/]ZVQ(
dLGE)E=QV=FY.PG/35dUAFEKHKG:Ab<WfQc#U^>F/O,&gVJ)44>6-)4+3Q4-H..?
E3.[TYa>]7P4]fG-\?NB,1cc6RfAdUd^D..@1N3G/GP>bEDG]&c/J&I@PCQX>R,<
[E?+0[?fA.eTe.QE?/1U(MP-BCY0@PE#I\=CBRR]cJYZbf5PZ_[S#K7VE.bg<PBK
F3-1+0C&9We<EQ-FdNQ>@8.:b,1ZUO\DGfO:[B4+O;#]&M<_VP:+V:N.KW8+0K28
A6e^Qa-f-f5cM0@+[.DL)beAFI565#S[c8&838N>T#X(ROcYE+I/[ae\F,WCb(OM
-8#HR-L46G<bBJL)dE9YbN#PF0D^C<T(0@H])9Hb[Ea)M+TfY)3BLLN;M787K)2N
E/RJJ6J>G.6A)b8JD7:ICb#g60P.FDA=^119&&N8[21d[CB6Ja(@JcSYC5QE]S#M
AaYO[Z771X8JXX(bgP&^I67GX^RG.aRTB>9ZX&/JLEAM#Q2OZ7DW39@#d-bRQfJI
EA2C<O.QY5NP\OV<U:cGSY3R-D/@MfS<E]H_2NcX1]ZaXB[GV=5/Z]O&W0[SRY)0
B-2:#+a3/=U#T<;59edAV06D^-64;fP@7,[\;_X9C^MLa+X]@F?8/E?ffTQ10NZ@
ee/Abb]R(gga#c7J)QcN.^1>,gIMG>./[dO??>CNR_HI[E+U6I@8(SDPf/CY>B(O
P<>A]b03RH;OF@fe2b4=[8Y.ePG]#/)AUaP@_0ER6\7OQ6^.fQ(@BEbb?6-;-@-c
,1GX&/fL0GBbL(FePKQ+,7-3YX&\eQ,SU;cA1W7)8;[:.+/[#9-d)Z-5F42,U/KV
OUCfSLLSU-S)M=#/6cKS1=AIY]_J+_>dN;;NJWQP,)M<W@8cJ39XPd;/e\LU?[I/
Z@12d.GRd7gFX[5J<X487YA+;D)P2/V7(>DP1Q\[M-2Td\Q;bN&1AfU;O&cBVQ1e
:e]?NLa^>cfS8H]N3=+cac/P(DHIb3;WFS_V<@WZ2C^XE)Z54#D3DEd?(\J3N_N&
E.LJg)F335GV]==>@LV<b-^LU.QgR^0PII18I/Q4^J\VD4D+\)4(b?0+6bL;;IA.
1GaMcK:56@)M@\>f:L5ga]VL=^gCc#?3B&T]A+BL3)>GMX5^RL7[G.@=<&V@]0;]
Va;K:J.fW\N;]c0/W+&;&+.d6XJ=R+UJ5CM^1:=<.X@-KJ2I]_1DF+26b)R/C42\
VeXQgb8;?d]]a34AfGTP6VN.fT09f7_+\/H]:<g#8FBF.2C<+9,fM,XBfJCDOP0^
1:gYYQGEggU;EDM3PR/YOfU_7>PQb_dRRK1@CLTE0Z0?2Gd/@.C49CCG9cH0NIZL
E/X8@&Nf0C9I3#Y3-6DVWX)A;L6@c(\PFNB[)P11,4W1#/bH+1MaQ^E_AH\AeDYJ
;8C4e/[5KFYWK(Cf1AQA4/_^S1:TceMP;CEEg-DS@6]-5S_CFed-64f.RE,^0ARd
-/2I8fX\6]VPc;@CTacJ)7(-.GI@K5</TE,LSC5_WF\C[\)_\0bY6g8U_.RQVHJf
SQ&\Lf9OPVgKH/>)9bNV.U\1O.J5+H#0?W@Kg+[g>T:&Rd]BQ[[N2c,4]4dOf68R
.efc],#4D8a\Nc&23D3eL(\(:=4d_V0g7GI&?N)DEXRAY19#96<?<JQcVfT>a.(#
]B@e&c3[-;)[4=[b-O)LH?D83J<=_<3ZaD8,ETD.M+.ZI^afE1UeMG@2;7G.0A1K
.-5.\:46+U.f\;QRHXg()X&&GDNHDT5IVM8OLY,;SAZKMVbgNEK>e+U;JQJd>aaD
Z?Q#\&^dI]@U--O?3/eNX3Z-#6MD1,EMcWgYdJM[HX6)IU-59<HZ+0DG0DI=6a.2
6gF(/1\Od#_?U4FZBBG@D]=/KOQ?>XO:IXg4I9&277].3C&.]P0=6TMDHMNT:9Re
EFG.dZDGVc4<:WFO2ARgE](^bJ.?^JJ4^C?])Q7X^eJ4Y3<N>.O7FD,Ia#76=/:<
eg2#Rf7S6g2IT.=&H&]a(?+BU-YK:WE/fBbYMfC_d5ST9c0?8HHQ-IT7(^ABE.IL
77#.]?ed/)USP5;S#1AT8>8I?12Ra:]MQ47M1g+&F7;9Fd=d))_C;.;()JB4/MGd
>?947aK_H6)_6.0<H][Y0Fa=_,)/=]VO<MfTOAS.H+#N.TNTBeYNY^G[8C&c@P,:
\eAWC/_S3gX5\+EQ2&+B(8Q8E2HSdQf0G,9V@FR/e@:I]I@@(A6[c5(_,8#GGd(&
AI62DXCP#-@@0N?a=N#6d@[0UW:-H8I>(J8#PK5AfIJ3>Ea?edA)8e3^.IdJQSca
.NBM,N3d5NO9(TJ3-#9PZMV&18.&VQ?21P^..C/W_BT#afI,\=[/IY3Sg.+>/&19
#3S0O/TBK]bYN>BOa?S92F@:X[^68K+;3;R:RT\JQ07.Xd9?=WU1Wf3O&&-;#[_S
3faae_LEEX97)C?KgE2]+YJdTA:6Wf;E\H0;-<LC4EJfI-K,];U.2P3cbH(D\>&+
YG1\DKY^8(U2J>(J.6/0O7e]I8L>3g(1]:2f>.5IN/<dJ:a?V^GX=be<AVSGAM(U
9<5]@9FWa1(V2@W\ZA2:-Dab+_dRb<)dD\-bWMWE2AWGd_^HIF-@TcG.O;MF+@&+
R93A.DTAaM\fT]g^A_Y=)IW5XAJ]>FP3R]1GC[dL-C+&7=gS6SdT#Ca.PZE^6V7?
@cG)<dB4W#@GNg&C@ccADH@).WGEU&;=N13OGY5L78c6aGT(L::,=g45U;_68>T)
/W22K0_?8N3-:[)S.b)&N)^a:P;@OZU]Rg&8X@)JOA5<A&XE\5fG,d\QL9?O+51e
;ebdZb5,>EWIA1aX=-g^WI(LfHH\7H@6O7bg4=[A]B^Q4cX=/U_O,Y8JEJ<CH#g>
O8W^+[F:7RMgO4N3,2/Hb?Y58EaI<ZO&(0)]0O(\0X@^Ga3&T\Y17]+-H;bI.6XZ
ZMKe;V0P^9^V9)L#XgF&#DDM3N/EPCDdE)ZPE<2I;M<_L85^Mab\0cYZ]g^YFAM7
V/ReSZ#WcVHF4.@M&TUa+36)S;7-0PN[]VU:@C;fag_0AgLIeH(9b5aG>B2T&C;f
D:.1@dB_3->L^UH4(Z;a_7b?g.f;IP43gS:WgR2.H<B7W/@/8CWD@QdRB,g&a8bK
^1@ab9JI#9G>>A9V[J0cF]aJ5>2O/a@g3@82XM(B5a\-aT_5U4=WeaXV]O8N_E=Q
YcGg@VS1..;e@@&>4@+:^B:Y0c=>?)N#N=)F_<Fcf_U0=/S6b/eT9,H0<+W\#WP6
7L2LP.4/e4DF7]1e]+H04N/8:Z;Q]8(?@]Fg40YE9O,DWKgEB&.9FZ;]D&(F(QN>
6;TMZ29eebH=?ULPJ];O-b2[#+4gNb[;91N[)F,6+.V4dPWRQH08;Q7:M\dbE,^2
<bX:-ONR7b@E0bAfZ_Y,B=&b?@=,HAg<^[dEf>(>^>Qb<dCFZMBNf-OL]\\0.5Qc
C@b1QD4:,<AP0G1<3=E^K^.B>ef[[W#dN9_,@),[RP,;gIE7)+L)I8GdDfP_Q(_K
dNg84J_4?V]/1&[2-UM=<[R5<UO#RR7bU8YZE5#Za9b+=?=MME2d(NTKc/VX_gd+
+C6@Q+U.XACcS8;YZd3;IZ>TW7T9VR^Q3]16J825Q5PZD1]cda(d<\MOF::ETe<0
8<Q/:^;N]UJDZT\+6AJgcgUZ+Pa,9O_JIU(@Q3;<K36W5J/(9RP^BcX&(ZWB^^<2
UgL?D/WNMBfOb<d6)75AGTVO#&XcBN@9fPgZ<dTR&4WaISAbHI.V>P(7<1+(#8L[
Z/OT)@+IY-;?dTNfc2M3;_52Ub.b\f63UIAM,L.?2PIgBB/Q,8^a,S]e1bJUIM8]
?J[3,RY,5.2\Y@:@@^D-Qa(cc\eF2Ldb#a-1\@[7;]YB#/ST\<YMfA^e:O3JI:,f
HE5P\E&?IUZ.g4FM[5SQ+,[@_)?B\+C27@SEEG0e^J>0eEL+Q;+fT._>?X2Z=;TT
5PMJA:FT8BYdVC.WC,:B@?L1WDM^2N9<?(-c=&V2+7,SgQB#eb/Z-;?EcJ^ZE>6L
9&@Oe^:MM,^-3J/FKK4(WYQ;I20DO-W)P;cXWeT_/e[R6UBUV\GL#VPEHA;D)P1[
g3HWZWB^HR-OIEL(=L\G5#C7J=;B/CY8,U<-ORSXT8T,g/e179H04F4GKQU\7c6,
-)4G3Ba#8,U,<1&?VF^I6H7OKPbe:<PBNVI3^7JH+5MWKB1f&E+Z=>P6K:<\>eT^
@ZRbNP8JE)G+LWF_)f3?\>,]NQ\H3fLTfSQWBA7.bJfVg50>S&8CFJ=CKJ-T/)^#
Z/T,X<d0&&E(7,WGF<U^06-O>.5aJU/JIV3HbQLVG]:6R.-;TXPL(=?T32#@H+?@
<2UR\\+(<4+_5H)J:4[?b;JHR5bga]&3aDX1@W^+E#;UC+R2:T1N,cN[A\>\eA>F
UATCY\-?Ce=5XV_2AZS:eT5<<&g^<?#K>QBR0,aS0M^b3g\9+MLWZ]]Y61(UHZGT
6NI--=5@R#,A[:Je&2B#)-Oab+4d@f]1(S&)=K7X-?9(:GTSQ;E7E>1N:f&GLNf@
2K6:VG7:2P@]e.O4D08RM>LG]:=<aa:5/\]&Z<bKg-?ECY<-7^L>^.CORH)g#g;f
>50IE20K5TBFeV]f4+^5b#[a5PC&N,fRLg)N_<DU2F:WX(HgQBHeJ[J;1+O&(3[d
BX7H862Tc_+/g@^;ccQV6_D_R,F+4CWJ)C[QeIK[US?;3K85Ka[)LeS8=I7D4#b(
^UH^UdX\G^6B,50>WY0JQGf^Z_eL_5UN4.c7YZe\C>[-#))9)96U&7#_X,HVe#I.
S14CD.eG-);AGA^Nc]EMVfQeG-H6087CPR/d3Pa(S@Z;4NceIPZ[5VMBKA:F&8@9
1Uc7E21Ed;faG2Y3#J?KfDMT&X:c:YQZ#A.,dBb:ECg,.^KAG8SYZ2VG=_;FT3(1
6CFbPX8WRc-@S;G6>U^/Gf.^d<:&PZWgFP8cIb@GMN^c-1JC8.=CHdN,/Iae]+Y]
LXL1DZfB+a\,11N]1gA@T^RPM)TJe7M]>/A>,(+d#\T()29P<I:-Z34F9>H.VdbN
adS1cP.=9#@bQ2b8=IEdWMZTKEV#GQD]FX[AHePYcP/.0:9c;(TKM;R1VLN^e_8_
;X^cR.7^]^)#1>b94/f?T&F&UdAH?R&WU^b0?-,3&EFA]LGQ;TK.4L/(@^HCVK=<
AAE:L;S^E<[#/FNOHYa/Xc_0[T[-PY5[E=ZR^CVEDI&6F7&YaN1\G/CE\[WI2F_U
Z[:J8-0((>c[DX&QI:G+.E<OU0IH7/LT7,^XR=/X-MR[,C[CbDIc53CLXV]bIaFb
D8FWeF8&=D2_PQ9C+^47?E@gX;:&T#VJ^\V92CSLgG5@K?.a?[B9+)Ta_#0g?33&
fFMW^46?OdbK@:2-?6GK_aE);D^LU7,U@,ZYJe^e.aB:=R=BFS/KESF_MN+\.OG_
Y1)),S&->V;PbT.(#6Wa(g=Y6N@228aC<Y#UNM>[6KAd?eEU>N)S>cKfc4d2D5Qa
JK\X;2dMcS>1SMC;Z)+))7W&RbDEBX5WR\IM[c<9QE61\-f106W+UWbCZI3)Vg.1
Qd\acUOTR+d5EfL5[@gfJ4Q5Q9V4[Y_SP\g5,?KKDB;Y4]Q.O=:C,@&9IDdbGH][
ELgBeb-=X\cg.1)NZ.VN[UVdK,[gc#;aZRZdMb\f]4g:LE3+.:4T3AQ\1D7Z>1EV
/L_8N^g>:d;#A\C(JS1P>ddG^YH59>Q6UKRDP>JA&]33F3Y\\fb?4WJSTJNf.GHM
5-GJVf,>G3;R)::e)G]7D+g4DVBf-NPI=E?N0#]S=>N)FKO0Eb4ZJHL5#CEOeQ]<
dRSdO/\W23AM\57?.M5@?KF7V-AN0#)Q-ZX/WHa\7,@JE,R9,:IKAY:+>@ON;V>+
gH,EcHM/>ZS5)aH>aG\.A/RQ1W/dSOGMRHG9e,3JS58ZZ28?aKT<]_G9bQ?&SADd
c2W/D34O&1L/>=e=eHR-8?1;]+eAC,BeJYY8Q7?#cM.^-TbD)T@QCNIIeMIGE80M
:0+cAX0,UNNd79/87PE)(F]W0=Pe1&WAK.&d.S4f^S#FcE#Hb_9b2>_g)YL+1ZSC
J#F8C0T,I>F8e9?79;X_GUSQVJ4,/^07f\30/2TI07G,b7>f\&V@;(OJ1@;7@X_U
E#JIP6ARf683YWMITK:+KO=a&&M-+C/?Xd/+a@J/-.IC6=)Ff0f]Ka2DNJ+Q]1JA
\>]HdVZ]+BF[S^G[Z<FD4+0e1NLJ,YY4dGK=PZ:LRA&7>,>)>)L^>a0S)G#CBT9#
E;ZOA6:(07I/HbG2+dZ-T[Wb.e?X?VZCE7.E<ZeJeaDMARfPS./9I/-E??3C1CD[
JL0d=4^33D1:a_e,aV3QMKQ]AbUPRBU&X3PK43URW(6/OZ(?B8;AP\:S^Da3_J3O
6-SIPF#8Z0+eN\OZPT0PYQ5Tb@f8AYcBR1P00V-RXPHE&&+_PB&Na=dfQSX)NI38
D31(MQ=HD4+ePbf9[:\Z4=b-VHcUF16R1(-.[DWg+2^+Q:@U&#a=1<X]HBdV35+:
_fV1ca?fVK5PWMVVG2CgXQ\[5N.YW,:O=8@7WIBg]HIN5/1#Z<G3N6_)1I=YF(B:
gcI)H2?e4HA>#J/&E[&UX>#H\T-;AgcBKa?e]7E6?ecGcgC2)L3cFLDQ==^/\<R4
QJU_DfOXICbT9D.&AfMfA(.I,Og6QEd.\>a&._aP&V]3:X4aAZ2QK_LR>F]C+]L9
GD?VA+U#8^A<KdMVOLf]UXP87^#(/8+.WPW:9D..^)919O9dOAE,&2M>.E^I6WLa
A.NJ4=?31(2#BgUM7^X]+)eL82:MDL\,L2,G[B3JQTKc,JQ^eN0/(:f:GH/[Q&@:
9:2NKVc1MOR[e2(24SeO8H9EbgFJT;1H2-IJ:?E.5B^1>WL#5MFL]4I2+c3aEBL+
EUW<<O#^(H7aSVRWIUQTP?BS4f2H;Hd/bP8(&9V8D>:0-CF-M4e@XPMO]\eP[Z#9
)(/YaVB03+fAMgHBLG[\[Db/dd:T]^<U23MH[BTfL+XCYJH;BT0)bN4Y&d\3g54e
-/=edC8?ZW3BdPDeMX:LDST-3fAABLA4RUD-S&8;^@=E>0c_+DX@</HcZ,--HO2X
C91Ic5=AJafSXQ^JZ4G)=)GLP,NAX2J>.0-W/K#F5=#a2a\/C@e[SdBLFCFVY:.K
+g)ZeggVP_SPG\B7.PX.[=DW65UN+D+B.ROTN/=5>.dN#a1GIO8B,0L[.2N,f908
7b0<../d]/EOPK33aVK]:=QdK2YZ&WRL4NVGBD;>N)PBQ_/)1EDe:W_5-.dUKCM6
ZDV=;gH:Z>#-L^[9-2Hg<GB<5AX;LH(;4UBA[#;U7aH+F8gE1Q:,HS]U=(+24T/f
^FTKF42);>-RD4N)S+HUYBadB3B;e_e,RI.Q8]@\^[M.9[1OAF)Q6:MG/I;SBOYb
QOH-?O)cR-<YSNaT2V^#DVEFP6d6Ag8a?L08^Tg<:SW>U^f=[a@]bHbN=5.-K6I0
KK2K2>#N74B?d[@eSJEgSE=(>a4EFbZUL-_1C.(OO>XN?Z-7b;=72bZ]P8L0X5I/
DB/F_3EQN6dcaTYbZIM#4&R+[F)>a27R&Z-SF@;cNf+#0@J8gK]>bK(1#)7P[.96
d;&9YO#c5FGZfUK149GOe<V#QZ6O/H2AIR8-,e1L6eQa(afNE(eeUIa>EF)gQGJe
YHXJ79\2g=TSGLMA.;+)b_Z3Q?5E6AVL3eQ14=K<51AMGCK-9>,W6LEJAaKeYBAI
(SPTc<QA[O4><.16e84e\.Z@O2Fb_:RYPEB)V+DA<(\g>7/,.7cf5a6-?SQa&CZ9
E,Xe=X/fED?45979Q,UPBC&K>43M<GZ>JF()O3CUCOO/2F:2F4S@Q[OR;@DLV-T8
d4HU@U33PfQP4_FS_?U&^^YPQe<M8S?I5,8T\/a;=X_c;&:VQ<-L#/_2(<_3KJG2
VO:eA?<[HLTN/MC-W7<Q5GP=VC0<IPbd/TW-71V(T^3\HSfO=7d\@6;-Zd,3(/H2
DT5(W:,0QWA?DLKM<ZSe7@]&Y;Y5aKIc,R\AU?/T=b[WOVXIPU2/D,QL&<IdP)dD
:D^M5+GY-5LPYOGHX(&_]bYc8HfA0(?\+02K;IDYPM0bC9]0L__R@a<6LJ7Nc&B-
Ug[b3VFW5VOf3:-JUS]AUea#\d&ZRL&]TMcd?BDeD49]JZLJ<J\<0f^SgD1F6F/6
G[N8\I+#VSU=5da);Q0W(Y:G1BEF2@,VfT-a5S)c]OgF@W<Z0:QL,X)RJ2G)PX2M
XK(B\C_8/dgeO[GL.=?9O&6EV?/.S?.H03I<7bH[;(_C?=e2QgBaBHPP7L&[BbA6
N4=//-DM.P:4<<MbMP+4/G/-B?U1OPg3C-ITSSHf:?32>)YJLQ1I3=Ddg03A=;H2
>BMb#N]aG9F9]JNF;2f-)KNGZ9N)6O-.HU=^,J?AaE]BEMU(12#H2VN-ZA93V(6;
Z[6]gAX\RAC0KH0.VE@.Z-T7#)FRW)]dU,fX4gQJUCLgTRN3W=_5a(SJAX=?B5UK
18\60^<]6\aDDFb+:BFV13NIf=P\1X;e1(bS?^Nf6gW[g,KF^JHM#P)]DOV#bA9B
CMVHL#&4g]]3@:B4cT>W)DG1N[+c7@H\Z/75gM;\O+M>cC^(634gL#-L5H/M4@c6
4K7c@URGOVH?eOE4;D@7cB1EMTGgGDg>_:1-;cC+XAM9aR6FX2(;9(OcR50/1E&?
gCBIYI[9VKMF]K+I22Z]/UI-197f^91)3[R[4<N;/\>=Q^&)01(fX=FRZ;&R17AB
,_HUCH4a82<#&]F_PbB?ca@Ld-SP0Kd4IWFa5eAC4RS8(665>]MX01FTdXRM&[70
YF-S;:7&;2C&#GH]58XI#[#V:S38FERE+ZcQP:IE7X7)T[+Ycc?&PdZH@E/EKN(8
YcN5&<XH#BY1Ng&3P,HSCK_:@I=b/=F-XT2c(3@IF21A(:/FJA-ca,:_HMZ^YOB9
4;DA#a(/,8eT?&Y5SL<+>C=2S>EE9USL&7OU_.X)\:VM@&0cC^+][JW2BNVSgG,;
I<VPF@3e;YZ^2F-:?>fLa/8e6C[MY4:1=:FfK#BA/7+.=-D1][#f.8ZKYC_XA,92
F1FF9P7-G8<^0$
`endprotected


`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV
