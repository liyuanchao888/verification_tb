//=======================================================================
// COPYRIGHT (C) 2016 - 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_AMBA_ADDR_MAPPER_SV
`define GUARD_SVT_AMBA_ADDR_MAPPER_SV
`include "svt_amba_common_defines.svi"
class svt_amba_addr_mapper extends `SVT_DATA_TYPE;

  /**
    * Enum to represent security type
    */
  typedef enum bit[1:0] {
    SECURE_NONSECURE_ACCESS = `SVT_AMBA_SECURE_NONSECURE_ACCESS,
    SECURE_ACCESS = `SVT_AMBA_SECURE_ACCESS, 
    NONSECURE_ACCESS = `SVT_AMBA_NONSECURE_ACCESS
  } security_type_enum;

  /**
    * Enum to represent whether this mapper is for a read type,
    * write type access 
    */
  typedef enum bit[1:0] {
    READ_WRITE_ACCESS = `SVT_AMBA_READ_WRITE_ACCESS,
    READ_ACCESS = `SVT_AMBA_READ_ACCESS, 
    WRITE_ACCESS = `SVT_AMBA_WRITE_ACCESS
  } direction_type_enum;

  /**
    * Enum to represent string of Slaves
    */
  typedef enum {`SVT_AMBA_PATH_COV_DEST_NAMES} path_cov_dest_names_enum;

  /**
    * Indicates the slaves names based on the Enum
    */
  path_cov_dest_names_enum path_cov_slave_component_name;

  /**
   * Indicates the masters to which this address mapper is applicable.
   * If the queue is empty, this mapper is used for all masters.
   * The masters indicated in this variable must match the name
   * configured in source_requester_name in the port configuration
   * of the corresponding master. As an example, an interconnect
   * may route a transaction based on the master that drives the
   * transaction. In such situations, it is helpful to have mappers
   * based on the source master
   */
  string source_masters[$];

  /** The global base address corresponding to this entry in the mapper */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] global_addr;
  
  /** The local base address corresponding to the global base address for this
    * component */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] local_addr;

  /** Indicates if this address map is targetted to a register address
    * space in the interconnect. Transaction with such an address will
    * not be routed to any slave
    */
  bit is_register_addr_space;

  /** A value that indicates how a received address from a source will be
   * mapped to a target address. Address bits corresponding to a 1 is directly
   * passed from source to destination. Address bits corresponding to 0 in the
   * mask are compared with the base address to decide the destination.
   * Non-interleaved slaves will typically have all the lower order bits based
   * on the size of the addressable region set to 1. The MSBs will be 0.
   * Interleaved slaves will have some bits 0 based on the interleave size and
   * number of slaves an address region is interleaved with. */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] mask = {`SVT_MEM_MAX_ADDR_WIDTH{1'b1}};

  /**
    * Indicates the security type of a transaction for which this mapper is applicable
    */
  security_type_enum security_type = SECURE_NONSECURE_ACCESS;

  /**
    * Indicates if this mapper is applicable for a read or write access
    */
  direction_type_enum direction_type = READ_WRITE_ACCESS;
 
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_amba_addr_mapper)
  extern function new (vmm_log log=null,string name = "svt_amba_addr_mapper"); 
`else
  extern function new(string name = "svt_amba_addr_mapper");
`endif

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
  /**
    * Indicates if the mem_mode passed to the function matches the security and
    * direction type modes of this address maper
    * * @param mem_mode Variable indicating security (secure or non-secure) and access type
    *   (read or write) of a potential access to the destination slave address.
    *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
    *       indicates a non-secure access
    *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
    *       a write access.
    */

  extern function bit is_matching_mem_mode(bit [`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode);
  // ---------------------------------------------------------------------------


  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_amba_addr_mapper)
  `svt_data_member_end(svt_amba_addr_mapper)
`endif

   /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

endclass

`protected
;DeJAce]:)<bO.N=^]e-?VAB22X3#2f[5ZW?,/a9M2<WP4/<1?/b.)#+UNUgWSB?
;FBC2Oa(V0_,BTVB-:XMP)fQ65EN[?ade:UZ5[DKXG>d?DKD.57_]?8ZGfb9U--R
5ad]UTNca>R=Ca<g;<X.ecRZ,T;,JBI\ZfR=I&<8dBbN4N1;,AeUQIe\e(9Q+72A
FTWC)L&:2QH_KQ?G0C\0#^2cB&L3]WN5Y0:S=:9.b=LfJ^RL(bGeb[Z>OUbAT9U3
(b<C+LHY;b1eFIV#a]FAN4LUKFGLACSYEPRD30J[1?cVHS)_&7(UeUc5>f.N)+RW
5a-H^9,\C4#f&=a=N3J^6>0+c>ZGH0aVCTBbG-VV5NJ,5;+e4L-4=0b@1&BCOL-(
4;5Z[U2AY@aOOd\DUEH@NC&6/(CF#VXQNb3bI\<+)M.(:<4[cG0,f2L9,@8f,JMb
#FDT3J[G6aU86/K^1UT@)]9FN>[AN#ZcaCVM.[TZU-bgbK&SLQ0W9UB,1J-&e>D?
]8Kg@+)/f_^[OF(MOeM[?I)ReZR>H]M2;8IKJ+4MS8f>\f/?Xe&472ERaXH-0^4L
=NZTNJ<N193g59^[#5V0.R&G48NPOe[9Q>>VOM6<7)YIX^0J)WDRSL4g(AVB6=&3
_:TBAZC?&AK3LeDTf?I)8Fa--N41(#2XFb@2_U5^PdQ>c3)(_RbNa-DN(b&3)A<f
VM:Ne<Lg_NQF@DebMUf&<?_RRYX)XN105<62\^9_7;WH8A33@f?KedGP/9G^bL85
eCeaIdEN_V&F953T>+)HY7CFDS/HU;=)@66)Y9D3RA])/b@&&9:_[W+AeXD-Z6DA
,[,b(^NRA0K=ZC5QJ<deA>3Z@9Z-SLG>04>FOKVY,CQ^;+V:VcIC;/FNXF[-#EP=
9(bfT-Y01aKe5Z+[QVMY=YcZ?7O([GcDb0Y\e,5MU/S:UF:06O;&\2?=e:MZ>^D_
dd=2@T&<_0C#06VSQ\GQ)Z^5?R_ZVD622Ae7\J>KB(0/JGBN^G)ICW86fN?59@86
W)U?Q.P+)SbR>58bHSfW3&gaE+>XcC6f.[U,5)GE[F7R0.,26YgKPa.&V]Te7:PM
64LWO<_YH5B7PIggRTZE[76E=9d9-_Z1_OEW;#M61gN(&g_8E@@]c15SPCeRPKe]
G_Y-?LN?IbEc]0J45E3]DXXb(7R1[;g@g&.&M6R#@2^7:/[1d+)2@WMc.=338>Z.
H;,eA/@Ie1,[V#He7_FGf-;Oa0-@<9E?.Ea[-RH_P+U]9&,4NfB/1P#Z7J652DX-
#TP?4_9(c#Nd5C)LB9JN<HeN@3W.F8).5+3gc7C=7@^Ie=TgYN(O-4X+T3_<3FgA
LK^@[/T?7A2\SfCTb[.#U5A<@35b=gH6;EWdF+1TH@1@/-ON5RX?84&9Q^CFM9,+
.,?4[Y_MS63,JaQ:gJ=^)b&3-B(78#NeX&g2e8;#&-Q#R745(/gVa\dYKCCG3@.H
]I5+,H1VWg+9g5>NEg]94V-C^;F+VO04+a[[[?-O&6DZXH.;gF3U?I>FL7Md3b=B
E2<HYJFSEb5cSZ^L1f;Ab.?@c2ZRb),+P]((+QMN+4@2Gc?Ie]NNL24YU-8</QXE
O,Z_#W7ZV8N/fg#7B9.f7g[,@3V;GW:\c3/J^_==UU<+I/=^W\M.NNT-?M^++T63
5&NT5aA5)@WCb&88/>=)M<_RV@;eOObWY6TJ5<>Z^8EE>fPJ#VXF&He;0394]>>4
DFV5^B&c>:3^5e^OLJC1=_C.TJ=BNeN/S99Y)N=+DX\:e0CIgP2^Pa@\Tf:P1@dg
B[4(\<d>_bSN/:03W^TUJM;R[C>Ra/5=ZKVJ8Yf+MMLA-3c.RUD<gN91A)7X.EgW
P\dL9SUdeE/,W=FU7Q]GB16;8]IT;R&Yf[/@#a1DBZ]d8:8(B+FM#\;K:^,+2-+D
R=VKX[>55,])@1D<>,[T2,6WFU^cS1=O3^-WDCF?b-/=bFD.+/B<A+]5#B-NaQ31
?MINV0c,#NVg@GU)[J,3@d8C_Q8=82O);a^E,+CSB@D(@,HNM[HT4VXP3,HbRTC;
W4FU0.dd8D4TI+E:,5CL#23._&VEM>A5^;[,1Lf^YE#>PV:\VOFA]R90+,/db9XB
>Sa(=M;JG]0H6E_VFM,@?DPG7a5XWD4)/C4JE(38KTM6GO-W9a@Q<c:_L?O0ZdK5
]&c2DD][4\OLSSI69JP?)WY=3@e(J3MA.&D.Xecac0K?9CS-dRY@X+B3b<EOP2L_
>BBBD/c/^XUR<\b;:^(\<77[2S=CENUf),9<0D1/K/FgIS&XWbaQ^[9(Ae2[cF27
9(^O(#V\]T2<DeJ-K\&#e_bacF0TSPO_<1Q6KbeOf<V]fYON\]Kc1aTd6_TReCa6
W4>(CC(U=Ge3=T[b-9ZQR64M7-HD6F/39>,9b411[[dJ6>HH:8JZE^]RAM\WJCaR
H2.M0.YA;Qfgd],BJ4))U7JLMWXU:#DS5OL78L/9&[Y^0_;[^158-a->U1eW?-IB
&/;#5@BY(<9S1(S3^ML:bbFfNC#/_<5IfVQO(9<8^GbNUdWfD.-MH/bXFR4JT85@
4dRBIdPRCKaKFQZb@^F-J47e<.1KWLI[d]dXgd]bZ@)TO<J4#^eY?JWAYF:][[?/
[OK5RS;d1Ea]c]+R;#^WKeKMZ0g2[e>JLO?K7_:8\QS/=g,7C_MDRJ5e;YdcgND)
cJa2[#,3+&@P@>-BC#e<E>],.XAKW[=S,7@\(#-^P20I.6[56BC>K-ga#eb3VR,a
A,+6fY4Sa<:+b&Ybg4B<\dQQ5FW3::,\O\1<:ce>/;,c_#K[]/[KJVAEbJ]8GG/R
:),Dc/Z-b[=Fe^QOc>?IRJF2>LJRJ;7O;MJ^^2c[YL0c15f:IQG0KHHAORebQ1.9
9+GQ5)F5J?<JS,SMa([?d3g_X31f704QF.N1O,ED[3B=aUS&]N:e?C2acNI,^QF@
6ZTNNNU<+3(.NPJKGU7Z0OU:b(VBgWVW,P4:C(C)3a(Ccf5F[VMcdW.^c64PBQc=
H1(4c45)MeR30b1HRJ7@Ne58PB<N9gNT426)eGeN3B[[8JCE)c;WB<MU^U+U5:I9
O4I^ZaC7W6gZO#(1g/P#Od\F.AgJ6T6T>g>(<86AJ^0[JK(9^d7<FD:gF=g8/,Yd
FQJUH<VI(&Q=Z+FX:0/+U9VgP\B?#[gXK19-?e^VKM8cDPaI]ZPY5HN2Gb@20Y;6
7@@b^[9MT4?7)c^A[E+\OGPYN1.aeV2CWPLEcD<;[1b8fTT2XHGP@4&MO[K]6LU<
#eA-H,DZZVdYS8Y;6ZU-)X?c]FXaU;=#?X@AZR)S4bK]C,KJ=@^F9Xb[T@B?ZS0N
gNgO6@LQ06]1[__^[CKVY]MKMc?e@J+JV?VLI^7+KA8=I8W7<,AW4VUG;59MENdR
(>#M&eJQW0_c2TSTOd[WEIeWW+E)29QP9?0DTYV[&cYHOL]=/;I,(8L#4[#=Q5JS
d6g]?W47Fa-3e^NG02+]ePEG(PNV/JJ.X#bVN<fZ3G[eC-5e1fg1L7ULgEb5Z^TL
bV-e/MX(<fG6,&PNc:ZR##f;OEAbAabTg[aHaRVE=(B)A1-9YU\QW/4=Q)J]SQR;
Ka^>Q[=#Nb)\,RU31U;9H49.TJI2:Oc^geEPC?86ZcZ\bHUAPC\6If?QbI2K#\>#
Sd\[Y]>c(XIDHeI/dR?3[@99aLdFZH8B\g-^5_-(4=.?D9^JEb,8XDUA)F>H1&a?
gP^7ZY+F7YW>6V6<A65XYGXMeZCNVF+e=g89JXB;HB)=e,0UJXCbK#0CfSE2SY5K
K^/_A0a#05>@Se4SR+f>S;5UDN,U^0M/e]fI>b-=])[,P]75Z5M/P[78[W0=M&TS
IO-B>YE(5-:K.M<6]I?VK/=SB8b<O2VMA7_;VYPdU\aJA2<X0IRY?eSG[]<#RbO)
8)=V8CE0E\?TH@8d6\HL3BgV__c,H<<867<;1J2TFD=gQN^-L0#K.U#Xf+JVIG>A
7.LI<+6W@E:IAcW@C(WSeC;2,V@NZIIT-T:0a.SY)MF@X1(_fBc^W9L0+MWJcL-1
I##.I5g^EFH)BX#N-5;D#,S7]VFFFTGA)1OR[(.(VD1E[^&[.Y_V:_66:g(;8DS.
&<4[P0=Y:5\c]=]P.WN=-.fd:O_1?\3-<KA)OW)A\;]C+/HKFOa;LQgeWX3<N^LE
3FY7B4E>UXZ>4>?0S53a_2QUIR(>GQMP)gY&Q+AdT1-@TgDPONGS=LGO.MIBaU=R
210dYbDH,aV_Oc+QX,\G&:7XV@L>KF_<MfTc=6F5++Hbf-M:^-Oa7BJ_)==CZH_I
XEQ[/DLe#M4]YW=Y;JEb1Ub[[d^FNdLDb2g)(RN2&4WUMI0/(3Vg8,B&?7DXTgTM
8FEe5\g9C,8Pgf@7Q8.@d([M;H,+S-HF1XNJb>^IVX,Z/e?Z\ac)LCRb<:\CS4e;
?KTU\7\/P>X&bP3PCIV@eY0:_\ccZdWX#6FT9EL]d[SUQ)72];>><;M-;VbW.BC#
B\&GCF5a/B8.d=^1gW0;]=AgEDQ5eTCPDV>M)6B^f1F=d,>05[Rg)MVCPI,:_AKf
=3-CW(IU#&_f_>N-eK99UBG=\CKT]AcQ8@gRDcX]&/MfP&G>\bK@V#?D@V;C[FT=
GO>A0d7cML,ZX<5+_IQAY0SW9M=0;\GVR#^e,T^a,UHXM_9Q#W0W04;FH1GMQ,NT
b8-<>J+ISW=DDIM4f9D=-c<gZ74I:9/^63K#DGI5MPZ610R9R2=<]VJYCA.+-CcH
2@C?YA-J0KQ(_HG:-YAfWUIU8_9]7H311_8C;c]YDO.b\Lb.,DD#:L(4M#PNV?2-
<5BdX(3P1^<.Sg8;<#B1Tb_(:Ra\VE8[]H],]5&XMa1OR)fc+-=<8GO@7>.3SL=R
)=Y8MZg\4531^0-]E#[1C5F(XPQNb(6d.-=93J:11B_W:[D4cA:K4PS4eU+X[8Vc
NN-2;ELOI?Gg+G>UD&KfQDF[Qg^BP05.&-PMPK/46/PE9(,Pb>VVIZKR4;=YM+Q\
fRF)>[X>HO;(@GFf(;6Lg3+7IN_H@H54Yb#d9_\^I6MEXY+F5Y,9\X7C?a7-VVH@
WS@ddgX80dL^V/,,CMC#ADdLWffeS_5/X\)DACAcI/bLS;)>?0b31ZI9DKL+-6[c
G-0.^T/8U:=),=F5f(6F9)VK]/+d-+Tab]RJ_CFY2]U__9[a8U;FUAfbJ_Weg=E[
A?Z99AZ2&5+d_6PG4SGEa1-JA]X^_,JeL<#0(QV7?R(9a0c2CS.9@FW-fdZ4QTUE
?)UL64,:F3PWFS68B?bQT-,@G?+PAYJD+OX;J?6\MDJ<^-QWS2DRaEW#WM^-5U9+
8UMdEN,.T.A;6R0-DNSH6_DM^D9,J9_:3_3W#R-@QL4<K7[GA436Y9(-LfK6cf@;
eAU2dF1C4=-YY)B:?Hg)N@FK(a8dO;R2RNW#N^N&A2U3,,7N_)d.9SX&b?6NM4Q#
,^2&^bOS3K<9UgY4HV4YN(MS:,,AQDXSH:bXPQa?MdX2\VK5^cd\4UHDCMc[#\+]
=93=I_9H8,d]9g@5L6^84^>XWZD3M8cZH9&#8eXBQA\Q8aQ2@gFRE7>+cD?\ALVM
Aa-87L2G5=cE>-R\1C</FW?f+Pa?;GA-K+g97YKe>9A9_)f3Z/_FY&KL\7Eb1TgU
SFWcV+PYH[UFAKS)#LZZ1R,V48^8?B)-D4#O(3D43.#_>MbW&-5S3(58?3WLX/K&
TPUMd&UdAV&6O^eHN2Y@_UT#F?GN+&&PSQ?QQf\(c[E5[L/8L8UcL?#Z)aZREXFV
[3A(ANEEDfSgH#=48E-A()I-gO&0Q)78D4P;;B,4-](+/>)>B8gbH,4)O5_T]##N
KMWc]Y1]^Z?9LbO<,5TC+?USVd[ga4ZTEKT<)SASYH:K#ZTSN(>c#:0F793\F@Z^
)=aH?B?DC7Z3HQKZQGW3X<XE4WB:9^Y4A8[WRc5\]=MdT<AHNJ\,cPT_>QO,bbYF
>A0:6<c\gAH>b,;;>U[N<cKcV7SEWacF@gQQ\JZ)R03&d@<N8N(eEX9dPM4AD?^b
B.)7@)OOCEIIW4K[/ISK+WGA9b42EH3AJeD/JZEa[Z?@5HX6Y+S1]f9@#bd2I]A5
3OFS7>U\WUSQ8@,RE0.-EHg7F&G1F0A#WXJYL<L#L)5a<3NIK<C0W:<N,#]a&aA9
7EZF(.(I(AbTPbY);1UKV[6QO\R&SdN=<e-22XB+/6Sc-L4DN+c[.ND-QJQdSK5^
TK=#SH1G+K(BBN8/]Lf>fKdV;+KB0NK4JN:J#9\;58#/G_;WGW@^d<(15LKW15ZR
E/[>K.I1_U@UfI1K55REA87D?KG\AN/OePeV\Z#_67#daPCAMBJcG_]YC2V)(e:>
6f(gf<=8-T)HGV4P3NPA>.gIXX.3BC0-9ZD/2,U/8DE<[;W83L0.(<=07PLUScBa
V:.^M4(6IL?(U]gX6(Ob+[N^eRLGFCA_d>F8;MG())d244W+2\c,9Y[bPa3T9(a:
Z48Q2bOWMLVc_;1=b-Ef@N.^#0F5RcRK0eg?)]9IN9V/>NgG3H[_0_<He2f7b8OW
GFK3bBTX^XC]-gV(7&[PFJ)^::3^()&S:Jaed91BaX>TDRK28I&?-_\?ge_PCc5d
WH?MR?N_:S9A&d30,SWDe[B_4O1&?5P2Y+L#43()N0d@a4VX:d]#[+E8>@5OLXH;
CQFK_26c20LK=1bBW6=ML_?+CX<>g#L7c_M18gU^DY?#B<Df>ZVN_38;GI+N94#S
S)D(+AXYP<Xe8B42[^DZAHP#SR1;RKgc6c1C>QF)S+_(95.8VS(Z.O.L1ILK<A30
51D6cWc)CCW(O=f/\(e>NWE-2L.cSKOL:_2>G(Z#g[@DD#28T5c95XZ:)d6CV_FU
^R#^fSTS?bN48\H0AfWGB-NCT)2=ZBL+FU^P,5^Dd+YICf=,:c@E>b)80GLA7PHM
BID\]f><<[[]02IDM3.^.[ZFLQaS)4)&CY,U]ad^/aKP4ca@/5A;NcC&[@=Z(?gX
]MPN9US;5\=eQ@Q<7NM&U/(L-@_aH+d5T^e7J2=2@.&DUe=W=Xa46IZ(=(LK+D1?
0LR.:0NcM.AGOZLMg=XW6Z/&#bGGCN35f;0aO@NeGI)ELV]Hg.0W32+F1=,fJ>O7
ZIdL07_MF.2&DR9#1f,IH_)c+dV?I]gc:<\R2-@OX\T,6B4LV\1e:F/>9d5,48Tc
&Ga\B8N:=M^5[^DB@IP9<\51O+PZPZ.[+:JTRaSYbRS_RgJ-?^530a:IV])AcGN?
+e-/R&g4M8.6:[?/I[RZCNZ7d6X98d-,b#36:O/Z5Z_0ILVS>6?M@OeMd-5IfX?C
c\[KbL,DcXP,+2D3<3A4Jc#MaO+e;7Q7I?C=cb#3?LVC#J]YBJ)+aID,(BNXKNR+
/gU>&Te[#/ABA2.KgPU&O>@>NPb&6GO<)1G.CP>@F?BI\BF[MbD@DX5X\Ia0cPSd
R<-N+393==FT)<VE<>SJR_J)ZX]gJ?]\a/AF/Y0M0dD6O2AAWSaVYaaa_Pbe;bde
0D]&PM5)0\Q=gX\E&JB(6d=O0Fe&K:/Y=TT+c=;g)K2-D0ES#PK@Rd>8e0RX,LSR
[&f/gL@5^FBAT0L=+ZEVW=c)[;-O:g21:=Ag-R\Md.2(e/+^dAQE902\aB6W5T,V
\8.dC=g#E<a<??5L9;@)a9LI20LTI+6GN,X>:1-]V?X5\EOU/JH,;fLgXM2a>97I
2;IB(5K90/K+0T:IddRVSNE0UM7+US/001HFY-+RV+M@PZ2HVaFUK-N\FF<cD8,F
TDa?2GRN]BCF_=^JDYfN#?d>)b8H5KXW:]+@R9@+G_W.C8Q@E)17/_ff>RfQ^Wg6
PZR>9YLS/V;NCYO35gY<7SS:N,Ofa83-Z2,IX3,7/Pa<fM>J..N5(B5YU52<4,QR
e;V4a;3]BAO)=U^P_JY\HeHU.A#-G5#+K:&G@CBD-8f@_FR/I+Q@>XX8)UQS)JgA
dEQ@6fRA5Z-^bN>T/:6GYa_)OM]_1e;SV_ET.A;=_P81C0)C\)Y5SbH;\XX@YgM^
W;TT;)cM1CbM09(EADIXVf6)\+cLOgAKM9],dN76DZN;^gIAKg2;VcZ-b61FgTY[
[Q+8&GH#(10KKV/_b6X\CH,T-[Z<^>_9Q0f&8ZL]Y\AZ<XS;5K65HYSDO23+G8H@
cZVWSO6-:DAFA\W12bCOJUZ#;Of&5[.b9WN)9SMIc]a=8@7N\d?AJG)YT@O[WZ2;
UQ+FA5=SX>H@ee<1d(B2QT@/.>WbS_&FQUSd-G#Y_CUTX<O9XA[eJ?a4X[)F1aE5
OGDdQ##Lg1UaA<[RY]W;gCF0XKS8CT>\XBC-2gO]Gf>O:#__3HTQKEV]94)4=?cX
3ORZH-CJ;TG59=7SF6@(bPcZTQg3O,,8JN@M=Xd>7Jf_<^EE@&)Y([.Jd-(,T3fO
aMe1.U99_D-dRO->.f\:\;&QAfW/#/_HNK^O3Y(^T:Cf,PB7L28#c63]BBWQH4GJ
7^C/WB:?UY@@O,S\:5N-00&gQ1XD#g[E;-.?ZF&9289fE>>FV@<TBXCOUS02^,T4
)&ZCK?=?H-b;2VQ&;RUNQ)X#0EJ/1J)GZ(.YMD3@ePXbXAdK>T1Pc+.(W_\AGQ;=
M[0;PES77.D++=McD:DQ@fR+\b/EWM;2g=#GNe6C5IQ#bNbKZA:5^1.F93gN72eD
ZTS]aLBE1,#X7b=[RMaGaJV\673:b+E4)O<_]#_+S[gbF6O(ceL04V+ZG?M.B^fA
gAC?AR2C5<.g8#&^M,X^XG-8Pb49A@Z9.Z8PC.S-8X+H,P74/IQ+9d,QO)DG#)GN
P8Y//Y98@QdA]cJSG3Q^0S,04EA5F0MP.gZK2R<:_#X:cScP9X^ROE[b1KQ:3@=5
T^^^9:9)AVIf&J3/R))TYB+Nb7UDQF.^Fc,E8#1EBINe1/?U>O]GMK7\E/8&GLEb
+CT.IB=\Z6N.32<G)LadG-?O<#7=e6H]d<<L]YP9@d#7dNFIDWJAEIAI=[91@>7b
DV_-gKO?bXdb0PU_HCF;eIHLHfe.H@UU22dAU(<.9YH[J>3<<MJ.HdHJ#[J/K-g6
+Q\2LeWL=3O.e9Zb-e/Qg5Z2_:cGZ/?0H<^5+fH[JaTa=8A<3AJdd4c;JS5+_=Zg
P9fJcI\8F>-e.IcR/0+#RGL1GAAEQQ6F11CDY[VY8>1439Mf1[&CGX/L6IMaM[(M
09:3PC:dXU(57aH;RCVC6MeY))W[0W8)P_UZ5U7GMG@I5[HA-Y\CN<JN^.MVGDKP
=2H1OWYJKDe<d6H1#A-C6O:AK_/FS\I^E\?-9Ld/>/cGESEGVFUadD,K\^+TUGBA
(,:)D7@\4]I,fWW[HNQ41QSGS.a4S<8A0)@AA;Ag0D,]9a0<d@\:4_/YU4]H+^@Q
,8OCe\aVV67JXQ:U=0B40Z@R1>Zf]Z+c?]1-DN04N[]&QJ(RN:PCaW#U:XM8CM=\
OXgD>RQ\7+R;5Uea0]<34Vf06QGKYU2PLJY6H@0cA4f(14DfeAJLST#QX@OI]1bf
,4.RA_T_U^eTO^;P7_\a[eO#\c+a@X.Q:7(\=-TA>3182.#b?TP&+9.EMZGE8c46
]5cT.2?ea.\ZYOR:c<BJ;a/4\E<^_1+g9#W=I5.K9eG1e_?01V(Vg4(>/]Q(PVDN
b11ZA3cCS@AK<DSgJN5YdO6JLV=P7)^&BgHH3+ac-_MF+5:\_,H1b46EDd<PWL#a
VQ/A00egg:/D;^YOY/6&#<FKAU<;+M+9d<7R-AAG74=654#GSISJA6f5F#:&5J\\
>VL2PNS#>5BA+Pa@CW:FFdQV:,@_/@8c,_+K<3.+APJbP;SPfJ.PYdagG&@0;:a@
7+9K4O?+-D^(RTHQY&-^,e:OI);MT1PM=G3Z>;E3H<@/HZ&.(;Q(B7c._?0(1HBQ
+LO94_#.F/Q&>YFH_c@2:P3aEKUGMI6.<^T1E2JQ^60a(FgA=S5?,BN^RIBW4)Z@
.<?2PcS0d_0f.+=9g,YY<,.FAB.:OD:FDGL9^_YH\4(#FO?5g;d7RMSTZB-XDdbK
/L)HJ988\5G&>7ZAM)\IPA73dgOK8S@,N&L]VcEFWU<Me7Z4:S5?Hc#E>BKX>VAO
B@\LTVR0RK09gD)c6X?RZ=M?0G,>O5MJKU^N/Zg?3XSAbZJN//5NS4d?<OO5NYE4
:5)SQR@2^TY<Z3HAaE+g8A9>T&LZ]_Y#0?13+\X11GU@BNAE41J\Ba?C?T>a)4Y0
O[)MF<(c/(3<d5S[@0IcO+E59W6:4DFI2dAG50)FfQT=]C_;MEXGN<=4A]J.@55O
W;c(\CTbH:/7)P5Dd;Tgb[)NR67]PE\LR:DcQ9R+M<)R-Q?\LUH2#UGYYc:=c4]8
TVGagKELG+V&_GaDdOa-8/E@6Y1Ff?cb^#UK-<bE\aBD)C.bX4YI[(8VP;fQ0JX)
/FP(5K)8Q+MHUP^LaSABU/+P3=c8PV?>d[GM(QT1M68H1VV0]+b#2W&W),JAG:LZ
S_Y#gN<&a<N2a<3Y<Q82UZ1SH>A71?G\3_=#Mde^@0,1O98/B9ecA2CcNDU<]cHP
BO]WA&?3)6#b,CQ_Q=VC(5)4fcV+,OTI9b<2Od(-M3N@(,]c:^Fa=F@INQ6ZAA8C
E@JK24)DHB)#SH]&RO)L83\8K6T],T(\>)DE/O<;Rd,Ic4a811M8&:]c9<?5(BJD
-D7(]+ae)6UYfRX1MFD4e^)KL+cH-Q&bXC27=FdKP_SKFXW@.eDU[DNeQB75f]GO
FVX16<NR/^9<&8=6LE)EK\0W57;X8/6aA#A\;.]a;U8:>-\D>/Re(;]J3Q,V[T]g
XM2OF=0&-ZDWcS?6\Hg:DFRgU3I;?80/QVMda<_.O1:[DPQZX)L+Bef)/?F/^WfI
aWT[_E+#3:0&XeM)\d-+RJO_e??.NPHQOR<B#+DC7D:B98R&BS2e/a64W?Q9QNZ\
+4C10ILBYMN4>6SL?EZb/_PD[2O1cF=HMAB<bN]>FV_H^HZ\CQH?AK)&GMTR^>bP
SW-+[)a>Kd)AW<d^K]N6:&0F@1@dX3TL31>gTDI#(0TdVad7MB[:g-f@#?0#,K6g
:M.8TZBCKL(7FFHF=feV=dWD1CX4We=>-^G_efS-W7c)<Z(&HcT;KO@_dIKL6<7_
C]@.J\(S+a+&<8WE]&fR2NE276EJ_Q+eR2PfCC&c+AFCH>PW)fR:-bc=G=9bWU7A
:=+4UP6UeOcTc_AXI\[JIHY<-(N&-HJS6fg?7+&JTY#,gK,d(g]#,YeJ_6cQOPO;
acbd:;+R/MVM;V,<68&fP7O8WJ/A8++O5I.E88eZJQa3?aPGfG2SO:@0E]ffCIQ=
6DE<b,6&DfD/^8.G-dC:V9U2T+<SQ^U0a+_6J2&g#aN\S;TSEge/-F4#4IK0^Y5[
Hc]/^JHeH4g1>,acZ]2Q2ARN9L/UcGJZ&7DXODf_:0H432O;],1QB/^@TC/E/d<f
5BcMfe+cMQ4-UBA4+&ab)#U.OfJ4OUFNQBB>1)cgW5]FB\V7cK[1BdL,-g1C<<Nf
&Z#Nd2/)XQ&dD#ZUe/+17df\7+^UGU@9a(=aL[1NeXNOSd6W5;c]9##R9b\^_Z6P
)<R0N]R\c8a0P-.I7EK+PV7&^WNP;U>6,3R=TNWFBc\V@[B9)?fHEF#A.b-C&(Zb
ILP&Ob@YZ+DfORb0>ANF.NCF]>g4=FQW3g\?/OL7>14JBbCB7cX/>YE=4a0K+NJd
e?B-g(-J)fb\Q5P([WEPVg\MI<fDW7-T2+]#4.ZZ3Y?:Y&K4VY?N-(MT7LL;9MI5
ggc7fMB,b<NCe,.D5eIKZ^0b-cT-2ZB//QgNZ(KOA[;Pf40,:Q5I1LR1e_T6+2:6
eGN^7JbHO:#8M.(5._[JcIJfTdG3SU+(\4[7J3(Q\/2^3aP@2NcU0XM@Da>aX+K#
99@]#1?+V)FZ7)WNfC(68Z>H)[J(=L@.<)4eb^U,&;(PI2R5GCH6.1]35VCD&A6c
eVe3M(A/:B[I-JI]#g?<4,AR?(\?f&P:RJ,V=BH9PL+10SJ0KD<ORC-U>Y;5#;L<
Q4L/EDZU3B;F3Ce3I>CB2SbD/O?83]a4QgSFS.cSFPSOAVdE03^39JOYPO@d9e7E
LGW(FMR_aWTOQ=QMO@E:R?GA?>G49#_RdEU4)DIBaCVC3,2&J34T?Rb1L?WAR/^_
aCHEI[+fUbKC??ZU/Q:13MV/Z4e4c)^OK:c8NWF^[^fNb+D3^CfM=3SVTQZJd^,c
J7L8._5e?)BbV+[)DXK71WHE>\?)\4cW/eF)/25K???G+9eJU<#9d1#dg6:>BVAD
N^\MZ]fV>HT?R-_VOd)WfVRaeHI\\b0.ITZ8g/T5e_#M36+-2LW_TFbd+2H@Ca21
HO>8(QN5_I5-7]9.+,?0TZ\GZ4+PUBX;[K_;c#=2UT>P)VEZeTP6[O/9TQU+0J7T
&M<HNV1b2CeE2<7^4J6BE[R;KeSOgP2YD..V>5PO-28:F@_>9/QaT/2dc&HEQCZ<
5D)-DVUIT6XIF4.&=S(aS().5MRW-Qd<[]JbC<LJR4#6=HJgeM/gaR[WObg90]>#
R<P^GJGBAGGW+Ne>c2]&.dP@HVF-UI=KH>@+<RMI-5BT=?(M.E;;L2d/GWLZUPL^
YQB0NRcH?cOO6?Q@g0-6aX#+YRGQ@A^Bb]Q4(28]_RZJ9?f)S>+>;^cPP4=)E8[A
O-GON_H9-1=a5T-./VQ/V>1<b\3Ea.;^(0/511K>\G,TVQFPZRZ.F_<AU+1P/B8K
(D>?\5W<;.]U#Z6P)JL<V?&T&NdXZ&.QC.c(^Y])O=Y?d1RIJ]_]f0U8b0/LK-A<
dB7D7E0\Q@.b47P_9(1&MWb&\WBc>bdc:3YIDg=S#A-Pd\4@BA>]P9J#S[3c_F_U
a@7ND.fMW&H9]1X?&M\I+^=d307VMNMbHcNK/1fQ+?HYM=1OC1Cf?3RGP^?GM561
-+]B+\:?P6]_F3\CC1;^N6e2b#6+(CUO;BYb6g6:dGO2X.K9P_Y@H9&(UJ^^\c9M
g;YOdZdU\9W-)GAZ<W>IYg?NRB7:8?W;S?]:H)=9\O@_3A\,:SF=-EI40U#8G52e
.LY(\bM/L_#cM\V3,#_PA&U.,&RD#QVEeUQW<)a)1DF84_3KRXDW4TfX.=DW/)[[
1^/g^d/)-U\@VN0^-[B5d4/9_T[V[]^;GIFF1:/2^BP.BU\\AS@b8\4?[2.,][Yb
#9NJ1Y8Xa+^EP7JDDDPXGA]eT;3LdHG>?NdV56fVH+CU&M59F4:Ia5Q^&([(O7T.
1TDG:IJ,5_&SeZ;Z=Rd@G2Q^7<ZZCLA7UU;[/8g+K:=<_Z5:gKYR:N+Z3<^@F,H,
@QV_\TR2&bH?7^8S@M[JWgV;.NGKRdS=2KG[J4I)AG[BKdX_5==/<8&X>KP5?0\S
5Iee\-DIdSRD2V:Y8XU=OfHJ(868gR10:XFWB5&E?[YC9V+/)e2U&MBO.G;G=@dd
?Z_e;TVLX.gMQRg[K(1gA3S^0D)JX:WV]/M&d^DT@@W6&S?O.9,HZQ](=?&DPM9>
0E5DD9E&-d\;+1cEMe@&+e,G=UV)HC5IN,BFNXF2M=bgP85<:IK-4U@,PLdK[5H[
d931XK_)0MR39g[.fXPeMDWLeE]TFZN4&X4G.a#IULCI\a^DS>X4S?C<+?WI.Q8U
0F^cX&Q)fJg.@b\/AT3DYN(N-5eW6\8<50=:\RDU+(\I?Q]BbZ,^Q><EKMYFA&>B
7f^,d;HeCa3S>(cQB\LK&-#Q#5Ug:7D@2]VJ-aBb5^eB[S6F>g?NYBGBHe7Q#40^
R&S?gTKKAS?aLc^,6ga;?=X)<;H[E@\Z_HY>E:KPR:]f/K5_:gTca7C-1VO-Z5QL
Q(75+g7WZ.8e@79\\]b63OL82>JD+RFNOG>.R4YGcb(D(4adA>^8Ke8Yc2B;2IW5
T\AXZ;.RHK;EM0b?b<3a9O-^DO:(a\?XO8A:9bgE]B4J/&V534CP+b^IX2V>AN9P
M_(g:d-;<^VS4TTZ0B>R<_b]X911\N4g81[2f20:FKXbPA/=QD(<VN,-2DUdT067
S/+8]Xb(d4U-U(79Eg;&>d_T-?20_I<7UVDDUgg>MV-Q7a8,?QDD+//2BYTYE0&3
2e1QY<3<KF.#cH]J#?8a>,ZM^RCP(ddC3bA5O(96)Z0PJ/=O?J:0.#&X7O<FY,6L
)/_8Y+Ua\#E9O,-H<b7K6)[bFd5AN7c]dfCWQ[0L)OXa=dUO;)b]&;RW=_(Aa9LN
OO<bF8_&XLNH^IVZH552D(1:7KKU.WFC2JceQXBH-bgHNYKM_Q_fLL@D]dBQLA9/
Z2>QK#T.5G8==\]ZQBe8gf</g.WEL.6SOFdN9KE6>eOGW<)H0Q2ZWUaA;75AK6AZ
KM_YQOEIQ9fY@O_c_5E,@4]5cD\;H]G/d)F--2b[3]cC.FdLTMJ=9QA-1BG]=:(X
1XbY#2geE?N)<YMYXO75Ga7RW<:C]\@ICUBS#7gD9Q&Y7#\LO8fDUL-J?O6:M@)?
]P,Q0<BZH3g368Gb/+^X)f72Qd0P=gTKA,+.#[14a@#IG;P@OG>g,^NKf5>O,OW[
IAMaPG.2K5T:b&E.NO3P=Lg);#e/XJ,@2H1[F.F_Mfa,bcYFU(.3<&XC6,[&\E[W
O[;b+JYcOG^&/E3.0deeG7bG-bQE><8E4?<eU61>Q])FCUDb5G&1H3X3P4_895Lc
+(Fc3;/#\OPe-HZ?WY\3g)bG6$
`endprotected

`endif
