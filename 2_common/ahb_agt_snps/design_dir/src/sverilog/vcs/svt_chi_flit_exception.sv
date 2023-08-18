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

`ifndef GUARD_SVT_CHI_FLIT_EXCEPTION_SV
`define GUARD_SVT_CHI_FLIT_EXCEPTION_SV

typedef class svt_chi_flit;
 /** 
  * AMBA CHI Flit Exception
 */
// =============================================================================

class svt_chi_flit_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_flit xact = null;

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
  `svt_vmm_data_new(svt_chi_flit_exception)
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
  extern function new(string name = "svt_chi_flit_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_flit_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_flit_exception)



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
   * Allocates a new object of type svt_chi_flit_exception.
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
  `vmm_typename(svt_chi_flit_exception)
  `vmm_class_factory(svt_chi_flit_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
A\#;?(5J3:#]g=]^S#)<=BQJV8(&7O6a/M=0\g,X1]W18df.8(=C6)[QR#SRH5.;
)->5&g)b8<IJb,3)aCb-c&5PQI1VEcV]&7Z+72[+&g:=<HEL-dU+##3F6IREPKU,
Sc5Ceb6T[85<R)IR,,:F&=b:<FOPQ)/K3cbIM9+ZY_Y[,AaWb)6f+@?I;(Q)&8C0
RQCA>J\E;.#N>-X[HRL@5g-,ZFY>FF+UadLJa(6Z(EI2?OM]I4-[cB>GePWPe.1>
:c8K9@G,J+:eQefN/3bVF;bG26_]SVP3GV[4c[[WFbT7.@;T700](9V@WDPBd8C)
.g(/#N6OT&bU3U3EU4&>]I:aTGSPcF#57e\:Y_CBQ(8^^fFTbBbcNR/C?d5.Z57e
3F;/?]ZLGMdGX1QcZHBYdB8_WAA<MF51DLV;aAMQe6A_U5aa&<T5@+e55^Z,fLd,
,/aRBOc@K0=5:AD-Z55aJ^5AaY,[)=L\b#8NH/9LS#-d+HE8VPVE)=6bQ2/N/[2bT$
`endprotected


//vcs_vip_protect
`protected
V.WeK5IX7&f]4ZGb8I<:Q?SEG,#bc#bV,I[Af2gF:EG3d9[K>[Pb6(#TDgAgW9XR
53S0)a;cba6HeN\(?_IU_)c284WEd=\9Ne_[;^<&Kf5dWT>^]E_X?LX#fY]IF=7g
CbEbE5S#FND//BIbBa--@Y,)RdY.I/3J[SN;&IdJ/_2JNHEL)RY[cHI-W)8)RCb7
5R[4IHD5JE8Z]:MV_-CH_4a,=7^Q8Z+Je2W?GG0D5H6C3D/0a@1&D]+Td(R&(W@:
c?+Y6VVcM5&EdbCBO(CU6RE1d..L_<G<19X]OQ1T2aB6ZK?eWL[5A3^A+T/6?<:Y
RSUO1C<@,T>BF@CbA1^>VJ;1[V66-(CM_3X&0\_LHYX:4T7:53.J7GE.]2QB9Y7a
LCbc&]>RI>X,U]b?###X]0d4c:eF1SF.c/;Qg+M)/3]91^fD4:K5eVac)&^3AT91
.2DZBOG1)06,,$
`endprotected

`protected
>9FI46EB^\M7@V>754[dIfKA.T[GXaa@KM#Y?L0IC6.9X^L&a\LV.)FJ^QR>#LP#
<P^P8d?ME-[;-RZ_]3fA:AK^^g[.cG6W;38X?8\R[XYIS]-V87#Hb6TeDObGBNY<
,QM7+;3Peg<F.(@TG2+fgZ\I52aH<O_0\LTGBDEE+,Xb3>5AE(<<BMTeM$
`endprotected

//vcs_vip_protect
`protected
@A6[;Y3XXUWBEL<JX-K?<C:Z0CFK6Pa)]1JRfG.9W>7ET7a2TNF&1(]_LEcA7[=R
ZRRJAH#B97NH]G4Z5AZKX97>b.B&dc,<0fd>dVU+LDa7XYcDBMg>.FN4fO&C8[YY
Cb3VQgRJ_=5b-VBH52JbE>CW&0)>ZSS&(WMM<Q8U\>OgL=0fVb4@?::IW06e@<P7
@->51-dL+T#Da<E.JVAP-K]EA@8:1\F_3YSRQd_-O<e(Z1[>?,FV9aVG7=MV:)B/
:)K\6,GZ0d2<HCM]WC[D?_(/?9e+?24ROE:bRMT:9Pc@4P+A;SCggAdPA69)U)aW
:P[5,NKYB?QBg&K3F5DQ(SSREa^Uf@OX\)B2<Y0#?F]EYPDZ>E^ODbT/K]G@F6Z[
SC^bQ\)]B):bgLY>C4I6aB9?_[,@3JW\N#M0^#AS4-0J(4Z1[GbBHW1<N&=+N)De
CX,_SK3W@XRI8Od6W]ND=9]7K]2JbQKN6(=3:4IZ9XR-9V-&9SbAXDf]A&P5=F6I
UXa8DM3PbL=79W?aBNDA<WMS9C2&dT?3;NDTG^2b;dB2dLc&Qd])VVgc>Od9^A?g
3<NGM[)g^(7FUY<8JO_/R7b&.(QL;KE]&^K9/8/@C(P4<116.S[7G&6b5DJ#OWQB
gba\ZI?A>bD.aIG=^G4SQKGU;6-6f3SYW)eP1&EGC6NQNd\&I1N:(=P26T8].2=a
AVaC\7=b,aNV#[IGJREZGSL@C]Q?P04^2@3=c&=RWJ+(N;b49[UHA@C.261eS_f\
G/O2]c?5=H7(CJ\)OD-&gPFKW88DS#:bH^Mb@^Z4O\gIEK19L0UX:PH(e>3S_T+[
8W)^^^.1Q18Zb\e9+9dV5e?Jc.U04I6>WCO#NL^U<7eRP0T]ZT2ZJf1XA<dBF0_+
8UZ-W93J7dB,bN0HeR^X0SbOQF59XQ_#<C)K^CS+a3#=6V42>[X\?bA<7T?6_B1,
Q7f&=e.<\N.We0T-CMg<V>DZCN>YYZ3P8a+aOU>>]L;B?]6)9QBg1Z/3-+eA;RWV
0#<VSA^HAY3+f)c2-.8<@T?9OFaYPZ.X9ZVR<AV&>N#,;aKS:VPKD7c[@9>H7W]S
P?;?]L,K&&0.7.Q1XTT3LRIZNXJ#HI#5IYQc)DaVgVN/D9+G62&YTEM/T>DM)Z7V
SX3N>_F=XXg9c=/_C>IC6YVJ^e+M[D&(gOcD?CC<_(Qb\T,8,T@NU,8Af.AO_g?X
-_2^8[Hg7(,f_(@+69AYZ[UVfH)cJ;)QN:^TV;JaP@-N2S<[@Wc,,N\=FZ.?85eI
a.b^g=5f5SM1MB(#:3QQY,J9(2E[[89e_9)_aC\(f/[g_&#QQ0OU2UY7Ne(SS1KV
VdF=73e=>:5N.H#25MS:Rb=EK-.:d18e[WNH6)K[8;CO>KCWW1HL(#L;E54RTGZ]
fK.GJ6GTB4_QI)SPZ]NVag1]@#R.IA__b+eI5aTb/)7@HC15?,+<8/LJ[40ObKQQ
<1<Qf1+Y57^6gC;;)Y-5G^M1^ZZSC9@.eCNfJ#UbY.BMfFG(410BI0VUeN=ae5bO
g],.J7e9\;aYK2N#gXK+9FV?E4#YC_CbO.dDGV3.#dH(LQE(7\&L;V4-abcQ]EF&
S\0;C>Rd<&b?2A=If#aF(34VcKAPQQ0=B]JR4e#7FOJY?<<@5gB9:)e0+f4UT_/D
>(UX&c&PO#Eb9gHg1BQB(USW-31H4H[\&X^U[]_4gb+ZJ@F\<b>MbG)4fg(FY9.4
7=&T7Og,6[9N.0B6=)]W1Y0U7GUI:=T+@6C,MD)^)+U9dSVfE@PK(5H+(K,8R0\U
4#b34e64\ac,6<4@4M.IHJ@d@D+7,SOX6KNI^F]Y4.5^e-,A3f)#KB3J]P(X#4G3
=G+L_(YI>1M=02e8XH]YZ<N_-XR^64Wf0J?Y1aIR[&3O802LF=U;/3EH;e@Y127X
cK6YCHFTN<GgC,8H0+FC3PV80U::(J\eEDTX/^V+4+L^ggaC=J^[d5K4=4EOH.DJ
F.U2K_f1#^=C>8DHbGXK++^AC.>3D:c=,PO_V=baVPZU3M7B+059P(FC-+3A\>0^
QFJ+Lec1c.,#RP0^P42P&14eN[)^e2@U=+d6SYBGS=4,CY(BS.RM2A3.PQK9>:=;
c(\KKAe(XfWXfR^Zd_?g+C,^)cZC03gP3Z2U0IL72gE(dD=O)Cf[AXM:DcYMH1YQ
cN4\=YM)dX@\AVePg7J3=a(7>ODQddI0\J7X@43M[M+1\^1R=2Df8(:GK]C0@g?e
Y09Y#bJ)@9LHK+ff_7GFLTA#8EZWLPZYGE[V(I,#,KK#;NS8&K06#/+=]NXWb3Y@
1_8[@:PG?.@4AJ^ID1XOf^0\@Db+H,04PW=\0<-F)HIF/5c701VD;G]7bggdQb^]
/7VO-=7&37dF(V5:e?E0R,2H^(S,G3H?eQV88eS?2J.FFKJJc>PW[>UAE\0^g4QH
SX)/]e=KGB)f;_/+=WKa?]1J.EHSW3MYY53LMMC;;;S1R7:R]>K5MO;V3L4C[DdD
MK]@C@f\?X_-PQ4(0(TY)B9R<AdC]44&V2RFb4T):g)6JI<7,+_fbBE+&1c;-]#.
eec]MOUN>R>U1NYMDaceADV2TL\[<HYQ/8Gf>-e=HVC^_C<:c<P;FOcS]9W>_e)d
)XTZfZ3UKd-L\_0;bT-)T-C?-47,e[2MESEV5&;dGgR;/+BK7ZSPEW#ED8T=&AV]
;L501D[G,FB+,Z:Mc+.(9c-bf\-Z@VUH#@7DRCbbB2ebIeWA.JY3CZE)e5#dEMW)
.5dHQ/@Vc[.@bRLD3.SB2A)YK7SePB@U(9B5].+@OOf5Pb_T-1S<c\42,J@8-c(c
1aMfU:Q-8c4;d@TV#YS2B[/C7IaLV>+1:NeOJ4#V2_da;+][5.Bf/Re[R[S[>,/f
fCfG(/V_>9BP_\f:GRUB\bb8#6ZCJbb4S[da)Z6WM9XgV;V&dFZQ&_RNADYSc?f\
g:GN/D,,+@PC(UWaM@\A0F^]a4X(b]SBV7(5Y49&8AXQ_;_f3\VHHEEY;gMECb<:
QX<4X-T?U-DYeHg&POY##8K&)]&Pe^)CU5d=)473+IaZD2CM)WQ#M>J&NY)&7)AJ
+?JJ7I(:4;RAZC2H^J_e\@(Wf:^/+8KKaI7[ced_F&e-A#M<&]>^+f02(3ZaP.D0
OZBHadN<Cd;P&M>e&_D;EM)Q\H^S7@J]]@a,+ISH?XQQEJM<]_2#1N)XEIQCGP<)
fNb+(MdJ]\f/F3KU[^Y^ETM@aIGRV,0-cT?;8;_C)B167+]>I6YN][VY2HF@H^T,
]TIE93gG3H0FJ,5/,-_b0OFFHOY]Z;JZUVID7_Ja)+M[3U4OFg(_ce(Da/Ib;M>?
TF>a?I7]M&I8aN+YYMaVG@KWE<8YaH@XA,4=@M;gEQ:FJHB^cU4X;>C^<\0LZgg[
a^/g>d2H^;6:KOO6WfFPaKH;.5\Ece]#<PSPLHSQJ)?.\D9^HGI_L=+)N6X]Q)N<
N5SY\PREW,.H8J>TW^S2/>I7JQFY#)dK:ZIg]fLB25Na;b2L514^QaHT[2d^)CXD
-3d]P1PB+9C-JXfA8<JD4E@2MYg9g2X5,=ZW^VJAY-[J<F;8=3WPf2^I[MC..7+\
POXAbZLU;27Nc_ZcEKb24E41HTW#3_C7]0-ZS)NT2NO:ZEVcPOZ)L>A)=RH@06:2
;,,Za;UOR?Z+Y7NGD_<1CB;H7cI/EL;]HSPN81:I1EVaf#gXV@:4@8bJ\6K&#L^;
>=ZeG0J/5D1-b9N+Y9fXSb\884U)E@DX8)S-E1V&][5@1a\Y0J,ZR-/Z;UC--8_K
:J=.+He85?&5;O<5>RO4dd97JY7-L0Q/O:NSbUQU(Te8;6gIZJ<e1A:O@J3ZCADS
XEe1[3DKgTGCO&ZW.WSGE^EJNa7&3R&/?&c;K#]K4R24GZ8RLFPA\f@6Za>YKMTb
;QRBF86LZddbYI9)(7SE=CK(8b[/<Xd)DECJ)#NfH1P8[527>E)c:dc1NTR+:@@F
>#Y\,IQKP]M^D;e<PR40_<E1\+^.6<R3Yg)4H<)Z4@6R]?,;AbC&^62H684-11<L
^3WAUF^c?S9CW:OMZ#U+@R<](?@K6/(A5NKOgaV?CD763@(9#e(;:d&\S+SU8dSN
T6^P=LP78V5T(62O;SFAC<DK.S:CNd;))0[X@O;_DKDZP1cT74@.QJ/SH.:W5f4R
>:(=PgUHU5-WYbcNZ@+0c\FUd-]5U2G^1?T)5\)>=9[ML#Y3R^\G<>\&##bQ]I&E
MBfFP-+gbH@7&N@O;M.d[\?(EY\=0]6ON-/Z4EHVgb]S6c1Jg,SMF\Z:\aef,0-G
[IX#16HeL,0=,bI^)+HW#(SOVH(=AK[R)YCGfF7N#H9:W../54G.9PP&eNID9>LT
_HJ)^6[@0;T9Vfb,+OP)?c^fg<6Md-Y(OMD7A7ef7]).aM+\O@5_W+4<_<Y#Y]L8
#TdJ&@f0(#H4A+Z0;TF:6+0Jf3^(4_M60L(A].]##((V0AKDHX:(5J?&_32\]F8T
+M)JOf>S+Y969T63+a8WO<<8\GE1[VVa1?Q3Bf(PQeK9Q#MR8P]-<\bW6J^5KQ-U
Qa8f&M?QbF5_?20Q.D[FOdXF#<&dUb&GAMN]d/6>A93&K?VG+NPGRH+AD6(LW@_+
U7&QJ+SF86SEg.J&_8A#+M^P[e1>(RV+:[BF5Z1fda=,W(B4d<5d&^RB(CHPbL7<
f_3<2GP;J-J.[/G---gRTKF7#<I;=]ZBQC0GX5)+a5,3]/AJ+X&=TC?JDL-fY-SH
-PC-OZeX,bEQ.6d[aL]B>IZU4U,(1bf:e)KRNc0(3G+VB;^\[C5b>0EZ?A;O2LeH
C6K2EBT>[K7D&8HT3>cB?WKIFbPV;5,069K_4Ng[D;RJI<@UKfa5I\1Q]ITK,.RH
D\dB,24WU5;T?4FJQ-&:L+N((a_@@[Ee?EUYJ335ag,YSXCQ.A.>1U-7FVSZaT1I
R=G6=ER>TEEBdY[K&/dO:R2V0d-WNMOJI&gSGe@<1/,33Z7[3L#,O(a)BOJ7I2Y6
X)3@75)b7ZE&/9Y@5f\/(]DUV+:a7)?9?]M<L)2JcP)]6KeA6T^<9gKVgYBU3>PW
X&<6H/bRdf,NAQVN.B]6F>SYZ[0?+?Q(Y&.V2gQ]-&_f,F-((-F0B^_PC[;,/8gO
KY&SLeZZ=W8QM\0;HQSH_@=G[43KWf=f;f3Z?6F.,IQaQ_EL.^\KPU_2E3^(JReM
O\b0W1We.66^&2))G7CQ#IYNe(T<Y,??DX9RSD>PK=5=__LdNBCdQUR2e=g[NYVT
a)/8L,)_;E[EX-7C-8M\^)=.EbAa#WR3X<L#=0geC41BN;:QA5:S4MQ:E;@0N9/X
]>d661U8X-=F7MRcfK^B5a\A(Xd57X.JRD^LNF[E&?agQ+=g^R->7KWUE;@B+[62
Md0^WSU-L#BP\K]1\d0)9fZY;(:XUAf::X891P0D=g^<>aB5PV-d_Zf<YB]WMO=:
QD1?XaWW<(^0DK:46;RR:TZe2)INN:\/4IUa.f0G,7cdCJ&O(OJ8#6RKJI@&DVVY
-F_BgXVHU0;UfcW\@Y-8_=[Y,+G[XKS[[50;X@^3c6J<;5eK)IZ((F.FQ+APB7]#
+((]_V0_@WGIXfJG7fSP?B(aL,G:G./W=DeS_>=b9Hf7agI4M6(1,E:Gg1Z]7ZBe
5PN].)E]faM>+<9S.G1X2AI(,K^\Q+-6TS0L>WVV#ZQ1e5\7/(#_dZF/?T/?VfF,
C19\G0fXCL^\^OXdF0O0(McVN<:gNP-<a&X7H6c79,^\L(,>dd[M]M8#_)eE>?+?
ZFW3FX:E)H:@\6Hg4&A=?-^,+DL;9.RbC9<\4+e1Ua@Bc>1QS+V@J,:,W+[(Y^AN
0M[VF[+Q[1[W6_Y./4fCPJ3gN&5#4_8Q#@e8>P>_e6V^NZ(&Z?]V##=A(UU<dU#Q
X@W>7dII#\?/HH0SQ.U#V1:XDK]dN>F,YcAN=;H.?R0^TL-OS^1A7U]-dgCLJOXK
(=CKc_TJ+<Q:Z+4Y[VK/S^>RT/X\2H/F-7B49a7:KH3Xa/fM&<;8P;)]-cRVAH(S
U#V/>.MMHCSR=]:S]P^7@Ve\LcD9I8d7;Q,1/CKa[gPYF&3,JB.H-J\:=f[NeS[G
T?[_KbCb&]T>Q97Q34O+8D^,67MZ:HJL[W8ZG5KT<:RU3A<I8bg_L=AcWH9SV2I6
EC0E]bSebZ[N]WGW4NTMdK116;#>0YO(95ggO=d;>OHJ8198DT[M)GY?eX-Q(-&9
U>-..N_0VN>XJH0&YgKNdU_OJd=Vd.S-3WSVA8VEgH77@E2dZd5^9ETS75I;GY/2
N2Hg?dQD)fL+C]&N8C<K&FPX;9EW=GgT1+AH]g7B[a8[WR6F4Oe0F<>68;N9a6C&
C&5M28:EOKBD91OY?Fb\S-]EH1;JcFFa[@T+7^[5&e4NK,ZHRB,fDJ]5,A3E@;9W
F3YDO4N<SKM7N>,9TA7:<5b(^f6OXA9ZSGI\N.85f<QTQ.U)T[[)6WZ&4[gT2a#T
\^I)8>B:=WR2M6C\dD2Y3F7c3fCHI4]_\,KLC5-W9R=Gac8P#(,d_MZI^+Y0H?C[
.<.X?]5,bQ.6NU4N@+=^_&aeX8]\<a]:LL96U;0c]<BR]X7@#GPU34-6g]>A0:O0
]0fN3;H:3DDW=N8c2dTIH:BGF:K@:L?gG^2Y-]e1R5>a/8LCg/=X?:?5GYfDSe63
AH5?d5R&GK6GJAe[PN>9,=PJ7c+ZSY1\A33/5TLQ;COB8E;>DU/[==MU1PZ.@cDN
Of^&ZIOB@eYY#86)@e1:L4d([/5F<,SM56L+BCL20I>/[3(?]U<D?15a+a<.(/QT
ggcg;]I#I/G?2BI(@7J/#aW8<\fYLALQ9L+(5ITBfg&J@P&BOb3X@(]YMQ+D?8=E
PGB-?BJ[#H6R3A4QPDAR[MD(SfX-K/I)6eTXA=g)4^AI-)8;0.HKCH)1[:E])Lb7
H4T[U&U=EPN/4^I74)52\aP:He)V/#d&c3eMUZYLQ+<VR5fE.aXB15P.ZWW2@bE-
&P21(BP[03S:N8b\;.VEJfeC=LCC,;2B5_(,&ZY-WK1FfDV3@-O^fV#Jf1>3G0J(
BRVU.6:Db213eRf^N#?&2G0AdM\M:->8B7Q]LIK8ZIOJ,X2^>((YLGP=<f)D06/K
V99NPJBW69JPX,gBU6OL#TO?Bbg;=OGN5eW[OJFA4eW(QZ/5ITOe(7QQ&^d9;e]g
Pae[M@^D@Pe5:0BUA,c^SGZ62R.:A,H/e&0)Y=7>_L(BY6-]V#S4C,bZD.]5LKY-
dTV=&:c3O?W(&Q3KI@&>5fKN>QB@OP&75WE64)CQZVE)7<7_4\R_=(0)7FSb53eO
SU1RTP56:<T9VMI4NW]V6cO#\(S1(W:-S7Y@2R/d1/(dgeSFU.Z9>=Y^bPXP1#(/
UI:,b,-7a\MEL4<.XGKK]8)c:?6N@BPA<N<O>P53:5eEP?BPZ>+W)0f8c,eEJMB6
d8\XB;MN>eRX<Qd?cU-gN)BT>1&\CdQGJb5K8R1IPFRVBd4a\;e,9KJJS2-aI;LT
JfdUWe5XfAM#68;GSDa^a2e=aK[A4>WP(XM]M\Pc/X_.5g)QX,>D21M1H(X+91>0
A.:6fTLGJMN],_VXHe+aZfSRf^fZb>\eXZ3\6Z-62OQeD:f=Z,OW3N=gBBC-J8Ma
EEUFR7N3G?3g]70,S=,R::M=X47].VGc3?ZZKOfc;K\0)V61LQN-B5XYQ&)TaP^U
JbQ@9&JQE>+5QO2@7:cCL//]MdO284D-/1,,4d-S&J=I=UJ-3<TSeC;gU3F\XVfA
C/QNa+HegHA]G=XEPJcZLW-J^f;^8(Abd:0gV?=eg/Xc?G2XIPEQE&NH&AITEFf,
Z@9UPS\8@_R\&g\X>-I=56(2B7(.9bbPPbJ_-^)P+G+MJ1cNDC>?UU?\<H:N?ddP
8BH>XOG<GO/7((Vd?]7.2G00&@_Y5\K;^X-2,4G\6?/QIf46J(5(8WJ#N.8Qb]4W
6GTYcRYAcF-@G(4gP[D_1C[QcD.)TJZbHL1bTO+N2Ac98L>G5P;2gLY4<0Pg57Ae
fUO,0>,KSR65]1(>4UT/?8-2=a]>WKgB>J+LfbCM9UL,\.NVX4OG[F-2LaKe@A&Y
KCa?,0fD==HB<gaHDO?T1TgU^MZWJC3f[F00g4V51BDYT=A:8E3A4e#XVXHc_Hb.
.7#5F+/b?@MB1+[UM5;#a4]KG+TUIBFDS]aERU,BMAC9.0<<:2)62;8[.d)Z7]H@
4^D+T[4B]GJH?f]2(PY5Mb-:VW_9,KDLO@:AUC8S);FZ0M<A&FR-HHCI9N^agb3K
XgQ&FUU4I+7)\aFCLG_NO7bH\CAAE-ZAP/ZR[3-7)#MADD^b32P+Lc8/@B1JQ89W
=F=;aO.5NC7-A)EW7aDI3TXZc@Be,^)_aN_Q3O/;\7+K<a.WC2W/_,D.9+OQb3D(
MRF?gW?LTe.8G0M&YD/;U.[&E:U)II7cTKI?9gG857EVL^aQ=D3=F&#0)0V:L7JJ
1@?EZ#Ndc,&gH-]ZXHg[Uf/.&XWVK8S0&M2L?9#03IV.,_1f-8-e9&.f#1\.EFgS
.9A1O[SGLb]ADPS4a(+)BSO?VK(cT9X4CaEO4ZM/QP7]+\=BN,^7@1J=TBNdBFUF
SeaC;B)/;^+&[GBJU,.fY\Q</(1(.FP(Bgg.(UO<KED,<.[3<b37.@?V7&VDSg.-
ad>EgQ1J(=bRc\U++G6ELZ8L?MD)Y:P]KO39@[)gXE4b8ZQ&JaLEND[DI#S?4_2=
+R6&XMZ2d_eNg6(1=IcXHNGD?1AUGc?/Dc/3X[9Ra9T:]@g)c@QeQQQ(>Rg[1=c5
Q8]O/^P=N5YWbaA.<EGcFG#@(A=IZ/FX_#]<]PdO^f[5,,KU8d>CX)E5AJdB@LK3
G20g=6Xe+/T^CZ<M_?T]X/8,OX8cPX.OTBF3,9=beb];>A_6Of-EO[&4&gX1,QN3
D\#d&^CR>)Dg2L:a]X.I]5gY8;JSTR?B=B0;^M1ea]V_8#a\]UXN.H_]<-4eeA8f
N1a.KaEGV9P7S-7@,b2O;CXX2^8(7c:&I6<)eBUC@CB2.MQ:BeSK.4SG1&/4K?PN
T)eU>[,cC+WaHf+-[bU4O>\C,U6_9VTSMA.8cNe8123U8)XJAXg7LJDHQ9R,&R)I
<a[^VSBF90/b-8JGW-4W/WT(YN5)Eg.VO#D+B3IbO&II-V<E4+D<ZKX+bEAM/5)-
d6;G,:ZCHPQ-4cZ,AVY#/)9<Y;8YedZdCXWLc_@(N<D[2^N>C2:7\O:GV[(ND-N6
K(RgPAS-HJ4TB2^a(g#CXGBN&89c_VT#bcZ9)BJ2?J]>Ld,W;QJ\LVB^2XR+P1L1
f:SD#?43F_PI4J94,dCfe&eFZd<@.<]Xa;#>U#<=PIP_Ce/(COQ\,d=SAU>?UT;f
H;]I>5@V6;);+2OZ3W?H.dIdAaIgZF,1Tb#?-/f4^V#<ZWUMX@?cW:WD:g5NbSL<
g1>,(=AG1R^]b/f5)Y6>LZg>>J3gPIa[JfZ<WdD12Ee/.Pb53C_[B4VBJ1Z),4<?
Wa@KcBc5d\G0cfTW+)@(&IV]FMGRZ+E?b(_ObKS2efU)JA.)KecA>S+&Bc3L6F9B
LOH9I<&Q;-Zg)4e7>[7=f8ScCBMPCIV9+>0/P1>R07/;=9J\A:e]dU_b)+6&NLYE
\&<6)S+N1_W(gY>(S=,G&a:6,72SO#5.T2@bIa56.1CKJ0Q#1]PeBK:,UKN_]-9M
8O;fU,C/YB9@^4S).JE/@I(K9,HbD[J1H98XWLL+,b1c0Y_-[+&_S^#LIdXEK/Q=
V<6If:]c_Se7Y02O,M]\d&9.I[a;P)LZGY/9]G<8CBe.9Z+]U;PQHe:bMDMBH8NU
.bRO\E#B&>@^0&;1#c>ZWgQ,Mc.:EM).8e?6ZFe\D\SDa^dPX#8I2<dO707c[eJ4
776)M[P.-CGg)aLZ]@/]3gG3c/P4DK\-T3/_2g,Sc^P^&].#J\1T0+7,,OHX[]DW
<]3(<gUYR?<6N/S^_+>,4#Dgf/T>VOaBgbQ0RTbHggbRPG6)J/7U@ZEY00d8>_e<
=cXEbOS1fA&f6gY5e)#>DD6fHbZWRI_RKKd9_fO#?#3fATH4YZ,\&UEA,fd;H_;[
<<MJd1J4\8ORUg_6NcQ0)I&H,?f_Y-07^ETgKZ[@U?69@^)^MUc??e#e=TAV8Y=X
04<e(5<UUSc)QP9Y:eE_U6@Xc,^7EVT4e76G+b3,U8CVQ0PJLLI6/RQ_.+cJM]3L
fO40Z\NAONd82:[gZf/<gU=(RMW+GZ(C+W]LQQTe(BTNB(adLG0T?>9+EW\C^#X,
AX/0a1eLWG6QH)^AdR89KEX97M=G)3)&SF=B=aUH7A04KV)BU,07(NMN0GX>X&g^
b[2f/#IB1T.+;d7Fd<OFNea?R],A#SJU#<XGZH&AeCKE<O<O/\8R9L9.fQbaJ#YO
_>#>=caPF56]4^_EVWY5-_FaYBRR1G^g30e+4A_9,;^K?d]63:=NO/_TWSf91c2(
M5ND\S+3UHLMP6ZM_>6bEf=c/D5AZ^6f4+bfHC5g9O?FVg@6@E5HTe@2^E.R6H3@
J&PTd6KKML?;+Z2P0VS2OT=&^K@K5J\fOC_\Nc>a;U</?0R40U/PH][KcSXcDZaJ
EP#a35Cf>0fP/f]3X6EO61K;HB(:SL8]YW84\Q\8+]KED380_9=N/Rc7468@=&eV
6IN(:HY_)N-J1[C:-G-06?[QO;Wf9^68#[BL/G_0gI4W-N]F6=[=)@d=KSK#X0ed
-X=>ESYLcL?N1H>8J9_,<3]MbPE(G4#)XeC<CQUOO60MB&AbPXQER(IYGbA6JTV#
XIGdJYZN^c2&,<IgB75,&GMHd2]M8Ta2J&&\TeI)K,8JI#?5#ZC6CRdJ(Q1+C5(W
eY(6;E#J(#,:J^L+aebP;6a-C=S)).W681bQERMJ1^=/Ag,Aa@GHS_E<6I^BXWM[
=&97-K9=P8SFV([Igf^ZH(9386O^]4NCUTHDT[VVfT-64>)L=5P(\)OY;Rb&.c-d
/S1f1D>[K;e3@JEJUL-X:+AA-[1HOg8R.\cAfN3PR@9>>f?[27:G#.X1I;CgR-7/
f@\+GZ#J^EAQc.THB:AX9;GGV[4Q1A:dg.YN]:O;>DN&;V3]B9?F)7)S6822RI&a
XAH,d/J<RQ)^XIJ;<KG#CMd-WdHAUOM?&g3Be.O7?L1_-:,,G]Ng-[]&;>F:OM\D
\PA[&BR,eBTZX]XX]QB&Wb@COg6QZ7^.Q-(=P^b8a40Lf]/g7T_A_.&IfAc[&ZN7
#6_H5\OMZ5BcH6M3N:AG@T.V=SQH#PW+C)E[V\I/G[H]I0,]&7f.,;2I)2=3g39U
P4\#>;L#ID/Q8\P?&AAZ_@;6Gba].[GTI:F8:Nb.:a7dU<+gJedHFQ9)@FaC2Sa+
WLaEAA.d3OBdPeCe4E>KKEb&USU.+9/\PM5Y18+6-_P/HG>C><]VY:d3KTZWeLP4
WFG),5ZR.Q9#/EXBI/#I??Gc3A;8S:Xa_83F?7K+)#@0g7\7]:2^>3J(YI);M-TG
\JOg[J[<P)D_6GdV&(;1O.TFB:6b>3&TbaHe3KO<<RGU#069J8aMKL)AWdFgX6Kc
AZ<@GF>VCaC)BS2KPD]DE])B\85b_HAQKQJ\cW7BJRS.()L0L5_OOg:7].QINe^Y
3HNGEX2g:Z#ND]9NII]S3EOZXMDUELgY5,^TLV>FX9VRIA4B;,FO+eYXDPKF<@f5
SGd[+.38]G?dBPV7@EgR:G9WVO9S@aHdf-,F,H3c&&JedT;X_.^\fQ+)cWOGd,W&
S;e<KBf>&5TF5f0^,(ZP@ZO)#N(cG.#A1aP6^b>f.[U1A4WMVWVY&X?S6?Ec21=D
6ae,KXg@-3#J?]+1D;>RS[Y)Tf7DJ<YBS=>N]S/YQE,Q.UCR;aO\?,ZW692&SHH8
&IPAKO;^ATMS:_\WHMDW1P>M]T4MX)#]0JDH<EA>.B6\I9([P5U#ZP<\8faOG.CI
TZGcZW8Ff.I)JT&0MKT&N,L+&2?dJKG[#?Z_\/<.W(W4TeC_aG#VYT3BQ,W(,L6Q
;2[G3Y[RcL?c-A:cJ]V1Y^KBg?O[]G2c?E:ANBL2U5?-B/^9?HCHdK6KVLc+7Q\K
MaZ:6<;73([U;&6MNbfcd&O@ZD>7)YU24=T>1/\g4QIIbEVE(\K.5Q<19S,Hd6Ya
Ydg-dee3Y);NOQ7>Z^Z?0:\QY//TCW-EW-R=K(Z^#YE_^=_C#J<;[6?\U+SG_=[G
^PP\-1NPA9_0J3ASW&cP]T@;7W(f.2<bJc7)6V(U[C0<=AW;]Cd5RUJCHF5++RAT
e2(,E8@/QRP/\UIRJ5_=W\89K8^F)Z4_,R9&E--C2O4U18N:3?ca_M\H>1L+7N7?
#Xg4H+J&.&KZQL?(\e=9(WaLIS0X4NPDX\MgBM4/g)DIV)UK8g)8DEKf)cHX#2T?
?C:B:\SOVPd7PESS;f-^<ce#+:13WHK&8EMM#D]E71fR2F5+fL-XV5Vf=T<]JA(Q
3^&/\:DRO_cYI>/3ZPACP@ZeY_(4-_M:V=Z-cKf&FQXM?\V\^>FW(IBE+1ObcMZf
KbB9aSPB9P#?N/5@X9+@R7-IdIO[OL)A=UD.O:WS&8FAVE93NOZ?ZTEXJ>ZaAMX<
g1@XI4b8,97YdVAKL#W4bgZBDJ1R6#_T&_A)GJ5012<OBe]8KTN(NWa=+C^V_-8<
M0F7+SNB9?X12Y51OL=/ZHR7W,@QVM&=dR&//fZ-]8E:8-_\KgJRIDKc=3Ub:/BQ
R\,H;;^C)3S<7ZSB_UcgM;+8?AP[<<NU#aHM/TO6?8X/EBOHBeH/)UF+K?.#,bL#
1T/fNK=5J[0=\FFA1]6A]WPPO0OT)NHfL[O)PRN1)L/RM#X<g)<24Ug(6DN<W7?4
Z2LVAT4f0LLa9RaETYZ7dB5c^7/Fc8&?1#SAY0B=]87?.W_Q9UWZT=[=.KfG4VRG
1g[.:05A9.1T<e.T[<.82B?O4WD?L&WJ].1?dK.Og&Df,SOOC.;7+UI3O-<)(Pe#
^,4Z_XP]3BeBZ;,IK&=P._/O7NeDgGb4PbJBVI7?VT&DE-;3732^W][9bL8[NUQC
VdgD:\-f6MN?Kd-J;PIWW\9d3.S:fUR[G[\Lf0W/1JYeaN#(KN;TA2RO.+^.XO.Z
QBC^b,[IQ>6RH@GQ/5^Xg)[ZZH^4.;_f^6:X.=cdRQT&W?R+JREc1URON$
`endprotected


`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_SV
