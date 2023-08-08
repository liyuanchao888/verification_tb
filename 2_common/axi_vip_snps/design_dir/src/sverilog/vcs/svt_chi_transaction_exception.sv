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

`ifndef GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_transaction;
 /** 
  * svt_chi_transaction Exception
 */
// =============================================================================

class svt_chi_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_transaction_exception)
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
  extern function new(string name = "svt_chi_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_transaction_exception)



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
   * Allocates a new object of type svt_chi_transaction_exception.
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
  `vmm_typename(svt_chi_transaction_exception)
  `vmm_class_factory(svt_chi_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
DX7;_B&fcIJd24WD0ORdB<@\+&]W\1[SfRP,K@dF/ZD5G:.T^Neg()[]?3BG)/V_
_#adXDY-2,Z/Q.Pc:]-_KM^5I9C&I)OT?g2T#+G4=L)C&^:/D6g2>/BNCAbKNI>@
\EP):K5U&E<8^fc]d3MEW8?V6KT3Y@P=XeBO,][Bb_9J9W?>)XfEcO;5[4M39GC)
OJEPB_XG:M;)MN=#8\YP-R5JgM5(X.BKb.WO]b\f83F204e9b8U&+[XgO5-c0Ge<
HL@1ZT==7&;[8ZIf\\GTRD^JZ@)C24BaLK,M^>DWg6H\^E5,T12.aEUR8I_BU9/A
>_c;W4,P/+&gZ/M=E0gbWcT(7S>R@NLA_ZLXJMId=>WcLc(^C_47:)&XK6@2K^IT
#(I>IS9EC/A:1cdR\P0H8TIV.1cUZgDDHDF96b>DBcS]S+g]G9,20.3ABbKWAdcS
_;@TC#,b>a\XW\VCJJL))^(G(@[O1V_+_=ZdN[YD1[YG?7e6B7,.;GY3I[WXdbJK
Rg^30Ma3:\e(:QAWgeSc+UD-Y0Kb<KKG@$
`endprotected


//vcs_vip_protect
`protected
M_fZ-GR,dVH/G?#)(^S722V869H_3?7RG3B+OQHXLH7]\]D#9J?Z5(TV0ZI@C(S.
8,MU<M>U<I#/NAH60:-68>?2g8;GXI,\)H0Q&Ob.G3Tc7F#S_O(U,Q_@H^D_IQ3(
35eD\aVBJ6EPG56[?7=2ES9QJPKSEH0XMK#3H5P7f04)V,fFZ]dc/\Ae_<7KbJ@6
0C8P8#0F6,0:f#\YK\+PFfJg+1T]fCK\&&aB0/NGHPI=F?OeETX=U?=,3#B)(3G2
]gY6;5e9RZd#:Ie5C#d.b&D1AbSF_#XBC:\G7@SJe=-?<Pa-dTaQH)XHg4da]:8d
?N2-Yc+.<\(P5?/RZe_d>,<CXSEgR<&0M\NMg22A(8B6>;1NZcRdU<A4X1Le1-W[
5A]-]2J_^9-g8>TH80fJ_6XCf;5GYAP^1Qg:c2b#T=O\f@SaH\)C6,:Z5f&>5-0b
30I7;a,Y&;2Za+-X3]Yd?GXC3$
`endprotected

`protected
?80b[.,9#aD85[-XVKM1c)Y4Y>CIc235Q_dW^7cA4>HY@_>g7#(P.)Z.aX<S>b>D
Ld(Z3K(AIOL#BX8N?3HY4)6d)6KF_&)UcFdTd-aLVS6a1+0</Kb7547;cSH&AcD^
-RRU-:5bIK2?;+:X2dJ)#W0NNN<QM9JDgR.W)_FMUL8JbW_[H[BQeV7;M$
`endprotected

//vcs_vip_protect
`protected
XBA@DN<J;?_dGId^9b:)D649[Zf7QZg)Q#X=2LQR3g_W[0J,I-=:-(Q\TPJ-CPW9
-b\K]2T)<SQRc^I[WZ#ePf<A2c,_IX7fG)L^Ng7/eAXAJ]U>\+[Q#M6^1c6R(XM_
\J+ScH8QM4.,3X+UJ<9PR?V5/#9[dC;[VAg)#R(N8D&9CF?<0Y&FG)+b2.M<1-cY
/#V]L#;Y@RYL4K++^I.;XIPBB7.8.2,;gWF.-S-)(.96L7,Pg;+L#0V\CRdee&ZJ
,#:2U=4_Aa@W=<)M@@7QTZ?BH5F=AS,AWfHV55]8KcBG,6MD^O<N(5Z,3>>4eZU[
#=SP?b2P@VEARa]e]L)b+[W\0VSCD^_U?9B&?YCO]Ta0WU6c#?J?@?<6BgJdK>dC
CEc.,K#Yg=](SL[5c;^C<2gU2)PANNXb3f+<=(JO^J9TG=2/I]0XL7?gP0C/E&II
a=T;>bOI4-NfYY?WU>UK-8)9ZTDI&-17Z#PN]6AF.MLXDCaF;5\G#1Y=RLFI_MGE
C7:Ia((L,/MHcKJ?Q0?@W0<2(_OF(b^E@;YX>ReZ20_5QQLD,4d_))E@\APHB93e
^5e08Bc9gY,N-.V&9TOS:.\Q4E,Z_Gb0bZM;cD)8>#E&DeB.N;d4?(cBb?>9d[d_
XN5]F-NO&6Y&BgDUR^d96=fD>)P^ZG;fYZ3eHfgdAg&gIM:RG-f2Z#TS\6YNAINa
@9?VU/Z1dfWOI3-1U)@3C[\gULdZ1Q66BD+>=7B<X9N\1eCKNU>E^DSO,WC#dFBN
SXP;W8F;9X.&[=[@W#NdAY+_])EGQ(<.bcFDY^)^IS36YDN#7OL_H^bI4H>Z08W:
190a/IYWZN[gf<eS\MYQ_SQ/2VDfJ[c,b=I)+V:QI2.;f8MV53;3T]LO,a4bQ<A_
&K9J<B[DMY]WMX<#MBeT8P6\Y])TD+-90WX=08O.<0JAKBHX)TP8Rb5<?SQ^)_cR
cA-6-ISI6UaKN4[X+Kf/S@;X\6-V/I=K]CT2?+SSD#aFDXcPL_M^.9.\==W^<CK4
Bgg(3AB2PGS9bT8==<VFYEf.M5d7SfP\VT_F+)EVd5.+e7KXVNS8MVIX\?=1+;8#
(AC8S^3A<35/;?;=C3NJeV+]TC<:AK#PB/)+1[>75,RNR)&2]NU)#X4OOUVd]<#Q
N.&_2LSO[66//&LRJTX^>PQ/I2XbCE/MLG0F.7YJGZG,c(8Y)?L(C.6OJb+)faT8
-;46F]5/#J&&XeR-4Ha\#LVML?4f_GP.MQ@JbY,:PTLYL^W2Y;^d(#MZ1C5A92^G
N[#X;B9\-.cZDJ//.W6LBFH0KWA=J0IW-NWG+/DW?2LNX:JgJI_Ndg1?X8=0MVWT
U1RFOP8RF;?>K\2Md>DVV6e1A\DIVc8XL;A=:CSe_EV8#B8@WW7XG8&aOF1I9]G1
-A;-95[De=I,d2\(cSNZ<X>d3=02C4_(fOa.T_(;E/B-B&O>X?7U@E9_,7Y#b;HX
\?<JcREab/W)=d.La6K;fE5cG>E9[c/0F0eLFL6(#HNX6Bb&W^-R4[HJ_PHYP-SY
#]\JNJXT?F5+DA2)0Q5<(WK/TP+/1SO@4QgDVH3W@0Rg#8]L0W5ALH=bRg)T5(af
=ab?[.LS2T7P>GK;eKgNIJ9fAT0X(1HEC2dVCV_:@f:E@UJgOHObB;_I2]Wd/e]-
(DVNRJ<[>EZg(c2^XQ6\-3:[U(.)5Y=MCJFSX#GSUOX(EcZYAXNe<PCVFaOe@08Y
SXD@\S#](/?Hf_GW6?#?]VEb;@18bIWM-;XAI:5Z/LH48KYELKC9:Oc#^gIL7EXT
6-T8E<N=2ECc8E]]/^_b^/GMS#?JN-MJM8SbPV;2<V:-]N0,;UZaAF:?,SMA^(F@
WZ#@47PLLO.@-E(51H_Eb,#V082gYS[6#<W_PCe9=7RM-_;][^A=3&+K19=T5R/M
T^X02?/a&<a25QPe61BA&PQ4;)3&e#3S2+R+:VR9fQ3]R>B<?c-DeFKZcTaFJY)c
5Qb)#&@CAH5gJOaON>;Ne+ZUf&gd[\6@H4gV#I.F3ST6<N;Fg.V4FVO/gW/=R-<_
<(H&.DLK:^(WVG70WaZ.7KV;+8[dUfB>]I7O^aKZ2g:1QG5)b0&#ZZ\;JGf].afE
RYAQ9OO;a[:W^ESbb>RKS]6[\4G6L=RQ:fCc-DTb@@Hdcb\+HZe,CbaMWAKXIBKI
d;F0<IMPCa:,.V?:\?R.3>-VGgOWNIC4?Tc57/>WD?U6=3VDdd<;K;^D,@N=&NB@
W5,TQ8W44g_3aV#_7EO5W+X1?+?B9bf/E\+I)JS9#-F-42>Q9e2R(-->U_73+eg?
CSY\;ALT@?d3GRN)NHDT(Y<-(J8N-:RYEW7/H&EIO8:L19aYa\;A(+DKDWYZYGT+
&KJY/5.=e@HXf@F@9>CJ-d1,.ZB-3XaDBVNH7f\T@X+N]dg#-SZbH-#<3eUE0S7-
&4T?Q/;bfPae+8G:a1^f@_P0-5e:3J,dAF?1b914P;5ca/:[;<(TZE>_AgE[I0X[
;?VX^GXVKE4T8,N6@^c^T&=GA(,6U]H=H;A\L>/P_@<WagE;bF&?-f>D.CO9=5;E
4JZ[6UA+JL?Y]S87T+#HX9.BSA1W,[,b.MTaCbcZ44:Q/^3S+UAZU;36,4WGJELR
NZ:J0.-3=c#a+-N+B4/2Z9CBZRSAb06ZLWgbHMQgIPDQ[ZHQ32L^TXI#;(CgS:K.
K2f&5U)]C6[_Jc,3Z]INa)4A3;()I,gNa18=^acD+[W]>Cc4V1#@U88W>2TcC?#^
D)0YP9L=)1/<PWKVW=>-FL;3PUQMJ/9?FQ>,7EFB?EWMJYEQBA5#=G?3,=g2E.JK
21]2;MN]3>OUc3J0MZNI3e8D\AF@2;A/@EAY)9DNT41\2FZc-,50a=NY9bS-Q/cV
[DSZ;P9=L=XF)<-@RGKeC4f+]ODVA-&8d7/XdA0&#aOZ@[BRP06B_a_+LKJd#^&d
T9MWFZ?4^:HY#.GG4HES,3+@bPaIOIH5H,f:.OMI)N>H^1>>gF1a(&&.BJeYI2C2
WZdL(cN&\cL;)Y?K<,6Y]90F4;Q1.6d1eTE+/869U]B^<WF^AV8T^Q@,RJgLNB[?
6<dP8J;#I3XO=H]8b&JX1EaUW]KXX49]SJ1;GXZ)QK08#]@W,@L]7<X7&3G(@6=5
Id1R:[ZfP_B;b[\?gCYSG,U,/BS1e]#bL0<d;@3eKAQS#O.QD&#IA.F5eP[:TZf_
WS(M=-O[41ff4X5</E&g2>KTM-VR4U[--HZVOF<<-8Z:M,T=d7KRKa1NPf<MS)7P
,R4H?S[,4eM757#Q5AP+I/Rc7&G&ACLMZ(66X.e2^&?dRPf3Y86cb_GM:/S8]Z3+
Qc<(OGG)[]gIPRRWN?XAMJ>&YC)W0:c3HVFGU\&SB&c>@T?9?#_G2WHTI2[.Z+a\
KZa)_&Z<aD90]_2CR;=1VFMDe3:)ScO/X?\4]X=#eJ4MW&KQCY]0WZ,J>LPM/1d9
HaW>eb#M2^]FNNKU>a,N/d2R-5<d><AU09K][c10LbUDKF?JKNEGHdDDJH(>#C#;
+cO)>If3UEd2RWVL(W#DRT3SOE:41.>_[]>4#+C&\<[dIgCGBC-8WS1cOa5X_g;>
BRa0OgTF3:Q(WNNdXfW?_>N@U#Sa]I.07:DN,8A6c.&PFAFc>AA;a>3F4?@W:ffG
/VOQO:W._8G_K=^H+].^US-:F=E9>RAfG;fHQJaLC,gR=SfOf(MO8cGNYL8PODD.
GUNMWgL\T5AFGD(L^;Ob39G#Hc>+?]8WS-CdRR]GA.Z?.=Sd&#AQW2Q4&RN4GEYL
I^\XS\QL41YT@W^3d@?@dF1[5K<\JDdX]7=@e?(N#ODc6Y#<c@c^<U_8aJ<>74e1
7/P@TICC0N0]9J=_+Ic]Q<Y&CO0f_>9Y0FYO2\eO09^Z;BTHYfeg0SY[5,ID&=?D
.JE=Y\;+L-X.Z9fASX=(Y\MeE,YFMS<cW=LEH8J+:L_RHV]-Y+eH6T.M-Z4??<8Y
UL+G/_J+0UBPJCANadU.ZA+=UN@;LYAGGCYgAEa4\;9dAP4Q>TIg=8G6c<Q.,C,<
,;>&T+#d6.T:P[=X2cY@<S786^Z89WUb8MMdYCBa2Yb>DLN6@Wf\^WSM5.4,]dea
B=L_,P7=7>Z3MW1?WI(X:V0]c0=:aH3:<]T,FP(\3fM_2_GJQ]Kd6V5+#c.4-HRC
V-B6H+)&KObCA?EAg.g>J,Z/6)&(]ba#KBWaBHMH[24_04E.SfeJ>>KXKb[1WCa9
&CY#J?3E1,&F10[I[@OG<\.(:IP,.@;UcP;XSd[OQd<RTe4(6Zg-YZSe]JNIBMfc
f1Df2WF/X)))8=&+gUJ:(QNO@6A[#]OL-a=FVd575A(T5A-eA6=\Dg9>Z+CD58dg
J3:^+;aAHLJ/=fA,?;/M.[(KW:QQ3D]3aM1DW:EcbK;W^Q>6E&?7^ZVYE0,D]-R3
9B\,4Z6V5f.E/]X@7[N2g(N_VX+I248e^3CL4+D7cCG5PWG>-CHMG3^^&aV-;./R
5UK5UR24I,29@:9Z&\IZbc.Y7/Z23RII3(YHU[A;ggI&=P-QEe:T&S-/:TB9<&6W
SW+1-P_:7:fZYMX<WJU=LJKZLf>SK[CCHDRLE<Z463UdYff&?SM,M,Y,MR^Q:ea]
eKAR4:_b1a2[),bC+.QQXTg(A7I_]LKYUJ26X7-+?R50gN8H_#W<HUN;fZSR9A,/
)?4[ZZSA]Y&6N5]dU/1=DHgVg,P5aH?JVT,,5T+FGZVWCN/cBD(Q25Cdd(gO8<\,
]UFFR-a-d7)LL=,#WQT[KcX+)][&1c>8TRZAT=dRdR3E\K)(5)bHI:>Pf(a+1K9=
:H904H5b5e0N08W2B\(;M9FfdP0aP]b))W<VHC;RPW:7,^VSbO_gIMRB0+0J?#dP
-.OZ[SI6BIRH+KQBIJNDaL4d4X=0@95>HYJgc^0O:/85OCP>OS2:b\+(-2MU>QZP
+R)<99IFc3Ge;R:YN6Z4FRTGG+W9c,]F]M,<.S;8CEQ3=#b8+Q2_a\KLVF8)4\R)
?@:gUEI@3^Z.J1Q2@E(4\FKV;\&B(WVg;:<aV](&)(+ZKXYX[(JIT2LNDC/DgbG&
<eQI\H,<86Yc5GH>@;WCLI\geP#/L..#A3ZZWR?PU1g/<9f2GOfX9@eU+&_(P6TJ
HF:0-4,I@O_H8TQ(]\c]&ZK]OB\HB4T.EZ?)M=.2K;ZG@L1AR3AL60[SX0cQ(NeH
bf+67R.d]a,WPTB\V#5I^/:-b.:^,AVFPC-86+KCQ>#.=0begIg.B_A(gYK4Qf(U
L,XWg#13-DeM#,:9T9PI+HH6OP<2TH+;@],_IJ59UCGa@RT]X_^DOVEH0VVZ0#OG
J0@)GA7.(#cV,e+83cb1D=Q-5eA0W,.1AFgIXJG+YSM_[F1JN9<B^RMee]I^]:_?
I2E78=PD+6T+ZDG[HMQOYN0#PMa-2B)NMUH7?:MSgZGO(ECcJ9:GPEY5g98E^\dA
>0>B\WOKL0MSW2Je.A]P_[(SVa3U\?Rfc^2WK^B8eE/KU+]EfV&O;Z8(@FdJ?0?#
VgI(#I?gJ+J<DUeMdCg8;4</_a+AcKUcfa1[d@b-^&(a2K@QIbT4WV0+?\f]5=cE
fUW)Na2+DU?B38&NXefWKUE4WCD#0/EfD60a=VZ]dHM@X<9V0c5/gM&ZE1V6XbSe
CU<_2/R@=EfYNcdc9X[R&aS4gfA_9@H?(V<eXX;cQ5Z,BNX;U2B,DcPB^N4BJS.N
)@>(ZW;5GM7F#>XeO@a..@B/D(48f:QRECeX:9,I>Z1Ke[fUJZKGVVGY@<gC5#NW
2S]DWN,?>g\;I@>D-Gf__@+a1bX9c#ETS7S;R@6D:a0:IfIbF5cC+9SH]40OdKD]
1Ud3HZACVc@Z6YFULJQ4QP3SJWd6<Wg_P>MfN]H#-8]gU2QNA/ML:R=UM2VF;@dZ
.+6<?HE,b@8BGHcd/F_EFC3Y0-/R1/I>Y@MG5T@&Y?RUM3>/&aeQEG,]GgYMP@L8
:OHF1\YZ+O/_b[9E-#eP1\cMYI+X3TL]MLGB0H32/P3McaCf,2:C-9Y52e9W@cI@
DV>Fdc55?QJZBZ_gU9<,ZC<8C0.YK+Q]A^:F3IcK#B+PJcKXfT:79e])@d.M]:cN
MWVL5\Nd(KZ,fX)AA2#[HMEgZJeSd?-fE:3J1?fDM4J#G>U+1#7+HDN<>WV[FX\(
T?^JTDcSS&D_L,9@C6=VJ^WaO0PS02CD1Y(A)(#2\/.O8=:Sbc2KOg>QXLe?C3Be
;Jb)9g@O3N(Jg)5Y4N2FdUa6RI=07EHYW,d<B/NbI0K_Qc4.Gdg8,G51W[T,/IPa
CILef3CBf]:eB-Yf/)-A^(bZ&773@C.PIc4Na9^:L72TNO&7V/D]A>[_\L\-[NNC
QbSGP;VR>JN&))baFZ)LSU5;K&b[Ia\6IB_[(GdfcEBSMf&Y/J+c>;9;<cQd[1QC
42RBD>(Vb_Uc;TP_+W)<_MA]F]?B_[:ZRC@E;:Rd[2R1CNR4GMHLB)(:6N1c=0BP
6\&f+W>5QdIbW7J\Y:QfL4:<D2M;:]aIX^a,E><HJH]ET(ZfD,EIa0=Z)B#H9JIZ
V[/+[1.\IM19f>A9[Df<??^YSP1?/SQ>70bdX05Zge#>b?_Z@_/E;NS2RLE>.+C7
1_KSR#aWNA2-9,]fWNc?)3[>_d;VVA7-H+fJ5GQIZ6B=&KVM?CCb+(9)aL75OTP;
0(;\M/7<C>6Hc[#TK?9<9U5HV1a-BZM7IVG-DW+[I=YWIPAX6JfLTd]6P/NM9ecN
AEKTL2)Wd]G_&O-\@XZF4P?&:7ZAMTC(9UHP1fKXRTR:OC;HQeVZ=20:V.S4aMQ(
#4K?43[/EO?AfG;J2O]NB_Kd4,EI#I:D91MS,e9GX+=@):7W6OEK#B+S/[6f\@E4
e^^0U6Bb:].UC;C2WKQ5M?8X)dKGBg@IL:8;e55a>LHSf@>#^dd0F>d#?)cd#Vb]
UWb.+++/H3=R)Z9dIbFeUMKKN5<Lc#]L6DaNeaOX&[_gf##<Q)F_?3RGdGQR/\]@
O_@]M360875aFU1YRMcMd[cS?+_V;Qb=aISWcHKR[N4E1ZTIeZdL+XW\L3.^;NS.
#Ec[9VYdJL,CR[;[9OCWTcQ^4R6;P1G:(^YH#NfTKRLMKcWH-C#[1+6RP]=11RgK
SJc^)1>P5N1UYCD#-WKG-+#L+)c:?X\3K9WY758C=KB\F/70X8G3J<:H;D<Qe(]9
0@U#1>W>_^-e?X<2e=3]c0fVG6.VP.gMA\DNbK7WN/>Q@[F<;V8BJLIOE;WVO76T
XB_b)XJ9IH/\^8\3^OfI,_FRVC)4Z:0b8_J3XB?d2W.@aU[F8c_)EPLOIfLJV&dA
CYD?-f0)6A[K5_S3=_AGKFP??Ze8(4Od0c28GfNTLOcOS7EfG3(P6\O1c8=Z^XIP
2+JUa1-]/:T\#LK]&#a8C[RH9NbI6=Fc91>dRaM(HFT-3]^0e3PAKN:V,AV6E?^P
(Wc6IZKH+IBL=^CbQOKL]1C0VfN-D^DN1aV#H2?PK,5SZTX]\<c^;d;O_L-+-AM5
-TVK?,6H03@B78SWR9XLJTH3F8[XbJ5[;-Ob)RNR+^/Z.6ER;SB9J0PI4Ub_7cJN
Og?=?X1Z15B=gLGYAbVCBIP,L:@RPg-EbI4FJ^ROe.4JcaU4=+dL&.3>#JEEBXAN
_&0Q^OS&D:Y&0270PY_O&M2JB/eO:NIRA2c3NKZ2:a;bM2;Y50FG4RS;9g\U;W>)
bQFKf/Z6.#@dTP9Qa\A:09L#GJ>C<OE7F\@=<<>Y(e7M-]:EZ22[?SGIgXW.e034
EDQ2V55=#L6A+6a@0S;P=N2A7UG>H=MP5+:/5c@:EZ(-A</XOPXO/71g;1&^g,1O
GX,X?^V)=N<K\UNA>R@\[@4^\/_UX3PWd=;AEYTX=AD_R<PEa7(IZ>Q<MBSdO.Sg
P4R]=C=?)I.&#7C<X@K>_W9CA2TF@F:a2@M)#\#aO^5M,YU3EFB/HEd^fQFZ/WX.
\5gf8(4#B:FFKK]\eMZYbKC1?&FDLZU,86ae4P3<S:5g1/cMHf=-_9&D46Z3cS5Q
d5&D,W099]MC)J94=-S@RH^#69EXQGIG^IE?3_DY(gS^&^6:BWU&dW:3/7^N/5M-
YW\Y,:EY&F;:)9=WYF]O]+V@7C@?V:-#EMKb-BE^^2fd\@QJg8+#-[SBJB]2B#E4
4=/X]N#=+4:L[cYW=?YT:YGKAC;,?)#&L.a3H&d3@G0A<WC#NLdQP#F2BF7HEN6W
>I-ETe8/eVYO@=RF9ZL\dL5/P=b18;1aQaSeDOYQ(D[0HaM((b513^PK\:=&P^32
6)LdH&@FW366<@MN?;>&CYW\I6X^T@N+KgEZ\)K_g(=gSJY<@e>dV0EZ,D[b1F.E
(DR@V4cY>Db;FYM=#VW1cJd],8,cQB7E4A-8EdD@<c^[3T@Pcf-/CW.bAb9bf,4^
b,2NN^aX(_LK;QLLP9BJd5OBAP1#G3_#0RfQW(XJB7bJRQ3X@N,?Kc\EUT<dH=SV
69A]a[;]+XVb0;ZaW,Yf2,:J2)<dN#<:H:CGBWL2S,6JMAB=3K?Z8LQ;G56=KQ=8
O0]D0+<F\XNYM4/U&?E.4=K[S1GJZ#BeKEPb<RAQ]5B.:0EaD@?12I4KQZ2D.B(+
R=eP6PO3J]e=0(e@DKa/e0J\1V_DV/+(=MRA^?:?<eJd>J8BdG+.&VK0S(:.fJ3;
7^a5-=6+0ZRT]<]dTCP[O+7cc_6C4Y+D]dHED?KO4Fb,N5N?@3B,(&R.SB(9FEKR
--LUX,T:?-CM9+]CC4.ZOPFg6H4GBX):OR]9:;]9O]XP_@f+?\K]fO1/JB4D:NE2
R1[gC^&D]J,4>;@We_7aPc^<fCTXE]O3dQDBXE,T.7&9N4;A[gZcX>8Y7PB>AW_N
]3gO3JA#T3U7AMACEGP>;>)G)U@:QHZb)ER0[Zg2\0+)EdL.4V\?LHQZMB##?]8?
^.HFJ5Z;SABJHXW:KRXDcW4<((AEVWb&_GN\e^\2-S#)_RL>Z(O8+f_D=:JWA>NI
[[TNggX@7TCN\B1.VQ-gd-,P[#ER&.2-LCA/J3XGMRbPKQ4aId>_Z\CZ.[dAb6T8
D7I_&O+.R?RBW1^U^X^IEV<H#_Q^a=^\BKGT3?ggZ1C]2EWJH?<-4J+bd4CfGfLL
Eg^E5M;;J^f^,XZ\SO>UBbQ-,SIdH0R#>e:(_&DL90F#N)@EM#-W\DTF#4U/eR7:
B^7H3UK&4^c,GQYTVJ7K64Qg#1eK9.gg5DV06)&:^[+E.gVWR=H&2@Q_A4RV2c(4
56O-Yd6/(/M_e7;XADeDZ/E4C[5[@]WJLdRK_Q,UaSWXJV:Bc0Z7D/F3V7>Y<.G5
SW8AcG@F8US/Q:b1E0fK99+\PYFgY,NCB#Z\.;@;_9=:e;5\/@;K0)A>6^f)>&2_
:N8#g,ILNPKI:GTZC>@WZC4QN?KD6&?NO\5/f^_ZO3)_B\7<_T6;aOfgQAXG\,UA
?&.H@g:W+XW=cFc:(7]7/5)#KEg:J[)FfYb2/TRbK<)-XDVadFd]SWYI/a1<#,EB
Xb<.0egP84c5U:Z0BcBHVD[LQHZ-,>[08=gXF1X:<ZM+S<;-\]UVaTSNS>>)>Z_2
Gf)H,70_VU1GFR?S)H\4a;R=g2Y24+>O.8.:?e0U8Pd5J<[I&1,7gT_ag-3Z\_&V
YgHIeG>,7S,06^N4?/aL,H_A=#A=:H#8Q[>,H/OD.,,eYeaH=#XTG<W=-PT=TRPF
<6.^V;UN_]\-P+(G:U6(AN4LBS#K]EcPVdbF>+K@<fc/N;?+RAgAQI1(K5MB_H#=
[[I)aK1Y;=E7c<3BX(9A>_K7Y,X)4-.W3GHB_Zf2WKHX(C:XPRU<NP\&#WNZ:0RF
QTNA:aKGYVAP:Sc6K+I(2=U&?1&)NWc8:GWNU:/KH?QEAKN<Lc;I7d<B<&:Ta^g>
>+X27&EQQW-7L^f;/[0Ya(-=?V70J=bF@g/-&U;2LcS;Hcg;gN8-=L)b))N;EQcb
:+-C4,+8NVL8QE1RX)^SQ<^AR9(c<10<3c7c)MW)K-\3MCFaU#]GD#?f)+OOD;Rc
Ta<EMEAMY,P\[ZGGIgUU;DWAXb+cO4U#D+OGRE_OL(VB;-16>/-,.BRT;,X3W<L;
OgeGI:9eJ,IX\Q<3,-:MT(E+VR90+S:T&;-84Y8;>I:4T9TDc]Z.?BMN3#M.Z,.J
LLS7\CCd^:#15C.PT&E:>/2(;;VYBf1f7](I;FUEIbQ.aVDIJ2]&UADEdcP:MR-(
[V5U9AaY;VS@?_NP;59\SOH?WH;UL,UO_LE-+M9OcQ]+-6eV&L>UEDf?(bc25@:M
TEFE:C\6QV3]HTHHNB6B&OOd=^K5EVB02B3^1eGLUdG,Lc?U]C@\EPE=8#(e8970
da4&XGR500\X+E-NC&LA3I]7d-T57WfZa<[9[ZPJcX6a1G;>_DVYQ@,CJU23JRCC
;8ZK9]cVTX96-OEcH6\72QH][OORDZOZ+NZ\3Idb,c)C6CPR0JbBU-_IQ:dOQD=]
BWS_H5GBW;_\TW9Z<;[Y7ARcG\<f(HBEcd5C0YOESc.9SeDN&N[G]@()I<b_\GY=
:65_1O?#C6\Z6D<#+(g8CI#I:(N;DM]V9@MeaKN8Ze_ER(F=b^C/@IT&?A8STFXT
@2T_=R15c;I3>Q5Y,e>a&@V?6-LO_TIWZ7\a3-O]+aE?9<C/M+g<]:CH3O?+;)K(
0eDO.>ZJ:R&.42)_WL3<:_?#Q7NYd[T;/V=DSM:R[OcF.aDN6YM7>62:1U_:^;cH
:HW+2UbX\JSZfY/</Q8BJW\\DO>FBDg^\3N;YW9<CaG1XSfYL#&9>6S[MDfN:8Y8
K&-OG?=@ae2)bY6W4K]H/QR_)7VA9J\+##E\2SAa;c>(KD6>FeN&@GSVf_VR:N>2
Y79JB8+bbDAHSY1[_Pe5(dRc3QWU,(Hc^ZHa?C\EV-Bb5fFY=eC<UTKBWIA_O7E-
W2)YeaGcTB,TRB7aZ,FTW;O#AG-5)WP2Y3#T<GXLP]HGc#_J)(R5R6EO.I&][Lgd
REF^]MY&2-&c+H+@S4&>EK1:g3)>@2GH_KB)750V#RbGaMJZ]XU7R&YWSOLN=-gA
@dFGG;A.?#17L&],;Y-EbA]J-bQ?_GVOaS=6+]OP0Jf-TZde_accf=T7S(M^Zf(#
aPJ2:X4d<RQ:80D^(JZ@;Q?>>,5ONab.:Le&#&U4[feP<N=S0g#CR7L2(_J?aOL\
J:d;g];KJ;J4-XX8ONMC?&].]P^#FIZDE(2a7b1Z9OWFX;\dUZ0B0c#O:--Z\3GG
KdFMbQ8,=&/^e7^BOYLJ3[9RdQ0Q]5YPQ4P8W38G<2TO&9H0SS0FC5b&&9BaI+[B
L,QVVZBIfOUb5EWK_N>b:=K:gGJLRT&:#8J6XMN-:M]M?K+;ZbLD+(NW\Da@BZK_
J(RKBZ7&0(cc05FSeaP9:-[g8I.@(<FS9:8LX.Lba-N:-.3QHY\O)gLPAOEFYaZY
+SQ=3f>2D.)aPW4E^VGSI91/BC75ZTX.Y&AJ),0FA#6-;S=g:4G/Kc:<_L2/Y?.1
g=?VOZ+KS_@#]Y]<Wg9)VZ)?NG;WKWTO+8aJ+KGJ/b:Y3E;)/C>-RPF:>B6&OT,R
>=[>+I>Z[M&BX4,DWSaII4N_-^H>,CW^-\.H<G/QZW8XN<^D1IT1/20/EUbGJT@R
2.)N/P+g1b[TaSKFc>ab]Ue)(aZ=>XDT=W]@),eFDYN42QL_WJbgBJOS<]dSOJ7I
;Q6T3AOUXP:eT+dI3G@JNH3;Xe0JB[3Vcf@gS5WBY2X+SANMbR,QX>Y4dRKc3VdE
#_+>?,8M8LfIKR8/-1_KO@HAQGOFY[BSWMY3AcU[:;B&T_#DS(GSF(,)0TBFc^#3
D^(1eA.?RS(3&__+]8g5Z>J94\/+0(-A#g<I_OdRE&FJQBF5X@:<DKKU=7F8a_7C
HF0?.B#17_>HV_fNAJMT/IeR6ZQB//eUZ@=K58CD(#V8,E[QGgG5AS&7fFN]UFA1
[Q^+^dOEU>_CV/=,UY)UAPN^TT9\9g-X@5BWWH3LYYH6+RMGUFGKE]+edCP[A]&_
fOK[_L.f;IHVIa4XB1S_ISMgIM1WQ2[4_1Mf_TV:QLC(c+4W<8\B:gMcO+,eY)\.
9DL=WUHATe8T2O,cB-bPM<e2?SUELPS^XT4;]aHF)]S]f^FVI[]W+ZQBEcSV6;QI
UWA]U3&BE^5cEeGcbG&G<D(F&#Q5[^:ZNTW<-7UWKV+:#Q?U/93YUcI5ACU2Z9dO
I+.]KI\YREH3]N=)7T_#9;?@C7IaQ9SRO>:HD>XdI(DMIZ?T_/SV-V[(F]K@eR(#
EIXeYbX;+]>Sf;@EAdZDY9#[A)Q80c7F)OEVAQe-^L3J)).X&HFV]aJC6a9E:17M
,K]Q)^Yd,]Yg@d;59)G5]5@Z)YZ+O41PFO9@6+OVf1YZ\<Y63.g9>=#KZ[4[::ED
&I+(fe:c;EUXg;BZK(#)1?/@]TIBT-bg(cc@:M=1&?+5CG:FK2-@g=MbE3Z+:AP5
46IH=TK\,2Y,WKS:Td67@J?EEO7?O&XUU4.X[I0.5g\])X]c_[)GA5^S)<OJd7\A
KC/W=df?JBC#<g+=V3.XCDX23E+_,cU\=C8f8Qb._D,0fP-YD5/L]PCU#R)Xc2#E
8R92]B@S5;IEJc-GO),#/7YT-:&_7F^61ZB1<A<.f7^379N&KUJ@&>PVWBcUDF9+
\AXJ\/M^X-M(b9EDcVMB4T5Xc-B6WdW2FD#.^U5J<(H/cL&4JT7::eE)ASKg5QM-
^I>:Y=1e?@.X\ELQ+?&K+^MXORT86:G[V5ZSE=_VK^P&8[I;<7_CCS^.W0;(57;5
WW^O/,NZ.a1<;7V/LS-=7XW^DCD42];+DH;a(PH3Jf:5AF@BT(&>=H=BbD1(@^bF
bSZaBPd5R.D<&g]F\<TF,-3,A^@7Q\)Gc#Q6OZN)>9XLe?Hb#JU@gIN[\8\6-?S<
Q5WHdJ_P)=e-Z3XUb\6+Y88Jd[^1eM3OgNLVVC),@7E@YY)0^A>IF4K#eEQ07@K?
7W2@7<JCUC&MgN.\XEW<^;=aE7.K\#C3I1:#<)/+(4<09/P>S<CQGXV5/VA]Z]2+
bEOEUHHZ2d\49G3Z>U4GEZaZ\bC^DB<NX5->@R;0ObND73_4FA.f#6=T>d:M,J[F
gU,DXMa48+862f):W@B;_ZDV3\K0,]8F7CZD&PY/R_/W5]L@/E#UP(>W)YaPH;J7
TVVFfB>NGZU(R]0QX(eBP.R-b\J:XC2_5&0Nf&\71&0[c)8:gAMB:\M+^#Ff(TYV
@1gMETMSN4S5SI1FJ)Kg0G3&?L6SU,9K);=NPf3J_APL]aBNIgI2,/a2,dIS:Yff
5^?0NSPI\O0c,=L04Y,DfC/6K&9+T+A.gJ4@c[45VbdD+]TB8gI]8#S<LGW^/<0^Q$
`endprotected


`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV
