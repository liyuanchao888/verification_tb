//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class extends from svt_chi_common_transaction. It contains attributes
 * which are common to svt_chi_transaction and svt_chi_flit classes.
 */
class svt_chi_base_transaction extends svt_chi_common_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * This field defines the size of the data associated with the
   * transaction.<br> Note that Data sizes other than 64B can only be used with
   * ReadNoSnp, WriteNoSnp and WriteUnique transactions.
   */
  rand data_size_enum data_size = SIZE_64BYTE;

  /**
   * This field defines Likely Shared attribute.<br>
   * When set to 1, this field indicates that the requested data is likely 
   * to be shared by other RNs within the system.
   */
  rand bit is_likely_shared = 0;

  /**
   * This field specifies if the request message is being sent 
   * using a dynamic protocol credit instead of pre-allocated protocol credit. <br>
   * When set to 0, indicates that the message is sent with pre-allocated protocol credit. <br>
   * When set to 1, indicates that the message is sent with dynamic protocol credit. <br>
   * This field must be set to zero for all requests that use pre-allocated P-credit, 
   * or are guaranteed by the target not to result in a RetryAck, or is a don’t care field.
   */
  rand bit is_dyn_p_crd = 1;

  /** This field defines ordering requirements for a transaction. */
  rand order_type_enum order_type = NO_ORDERING_REQUIRED;

  /**
   * This field defines the 'Early Write Acknowldege' field for the transaction.<br>
   * - Value of 1 indicates that Early Write Acknowledge is allowed
   * - Value of 0 indicates that Early Write Acknowledge is disallowed
   * . 
   */
  rand bit mem_attr_is_early_wr_ack_allowed = 0;

  /** This field indictes the memory type associated with the transaction. */
  rand mem_attr_mem_type_enum mem_attr_mem_type = NORMAL;

  /**
   * This field defines the cacheable field of transaction.<br>
   * When set, it indicates a cacheable transaction for which the system cache, 
   * when present, must be looked up in servicing this transaction.
   */
  rand bit mem_attr_is_cacheable = 0;

  /**
   * This field defines Allocate hint for the transaction.<br>
   * When set, it indicates that the transaction may allocate in the system cache, when present.
   */
  rand bit mem_attr_allocate_hint = 0;

  /** This field defines if the transaction is snoopable or non-snoopable. */
  rand bit snp_attr_is_snoopable = 0;

  /** This field defines the snoop domain of the transaction. */
  rand snp_attr_snp_domain_type_enum snp_attr_snp_domain_type = INNER;

  /**
   * This field defines the Logical Processor ID. This is used in conjunction with 
   * the src_id field to uniquely identify the logical processor that generated the request.
   */
  rand bit [(`SVT_CHI_LPID_WIDTH-1):0] lpid = 0;

  /**
   * This field defines the exclusive bit of:
   * - The Transaction (svt_chi_transaction::xact_type) AND
   * - The Request flit (svt_chi_flit::flit_type = svt_chi_flit:REQ)
   * .
   *
   * Value of 0 indicates that the corresponding transaction is a normal transaction.<br>
   * Value of 1 indicates that the corresponding transaction is an exclusive type transaction.<br> 
   *
   * The Exclusive bit must only be used with the following transactions: 
   * - ReadShared
   * - ReadClean
   * - CleanUnique
   * - ReadNoSnp
   * - WriteNoSnp
   * .
   */
  rand bit is_exclusive = 0;

  /**
   * This field defines the Expect CompAck bit of the transaction.<br>
   * When set to 0, it indicates that the transaction will not include a CompAck, 
   * so the receiver of the transaction is not required to wait for CompAck.<br>
   * When set to 1, it indicates that the transaction will include a CompAck, 
   * so the receiver of the transaction is required to wait for CompAck.
   */
  rand bit exp_comp_ack = 1;

`ifdef SVT_CHI_ISSUE_B_ENABLE

  /* For Atomic transactions, indicates if the Interconnect can send a Snoop to the requester or not */
  rand bit snoopme = 0;

  /**
   * Indicates the endianness of the Outbound Write Data in an Atomic transaction.
   */
  rand endian_enum endian = LITTLE_ENDIAN;

  `endif

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
  constraint chi_base_transaction_valid_ranges {
  }

  /** @endcond */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_base_transaction);
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
  extern function new(string name = "svt_chi_base_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_base_transaction)

  `svt_data_member_end(svt_chi_base_transaction)

  /** @cond PRIVATE */    
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
   * Allocates a new object of type svt_chi_base_transaction.
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
   * This method returns a string for use in the XML object block which provides
   * basic information about the object. The packet extension adds direction
   * information to the object block description provided by the base class.
   *
   * @param uid Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param typ Optional string indicating the sub-type of the object. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no sub-type.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method uses get_causal_ref() to obtain a handle to the parent and obtain a parent_uid.
   * If no causal reference found the method assumes there is no parent_uid. To cancel the
   * causal reference lookup completely the client can provide a parent_uid value of
   * `SVT_DATA_UTIL_UNSPECIFIED. If `SVT_DATA_UTIL_UNSPECIFIED is provided the method assumes
   * there is no parent_uid.
   * @param channel Optional string indicating an object channel. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "");

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

  /**
   *  This method returns the data_size attribute of the transaction.
   */
  extern virtual function bit [(`SVT_CHI_SIZE_WIDTH-1):0] get_data_size();

  /**
   * This method returns the DVM address.
   */
  extern virtual function bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] get_dvm_addr(); 

  /** Returns address 'addr' aligned to cache line size of 64 bytes */
  extern virtual function bit[(`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1):0] get_aligned_addr_to_cache_line_size(bit use_tagged_addr=0);

  /** Returns address concatenated with tagged attributes which require independent address space.
  * for example, if secure access attribute is enabled by setting cfg.enable_secure_nonsecure_address_space = 1
  * then this bit will be used to provide unique address spaces for secure and non-secure transactions.
  *
  * @param  use_arg_addr Indicates that address passed through argument "arg_addr" will be used instead of 
  *                      transaction address "addr", when set to '1'. If set to '0' then transaction address
  *                      "this.addr" will be used for tagging.
  * @param      arg_addr Address that needs to be tagged when use_arg_addr is set to '1'
  * @return              Returns address tagged with address attribute of corresponding port
  */
  extern function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] get_tagged_cache_line_aligned_addr(bit use_arg_addr=0, bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] arg_addr = 0);

  /**
   * This function sets the field datasize_aligned_addr and updates the flag 
   * is_address_aligned_to_datasize by comparing the addr and datasize_aligned_addr. 
   */
  extern virtual function void set_datasize_aligned_addr();

  /** @endcond */  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_base_transaction)
  `vmm_class_factory(svt_chi_base_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass


// =============================================================================

`protected
Q(f&ED=6G&:<>P006C(KDYX7BP,d(2VN>Q(-ML8+^>XPG<5S@WZ_-):+dCT,_fF[
\,SgO]MX?0;O<ga,bJ,/f5S[B.87?JCZ]NV,+I.4OcYac=O]cJ#EXBWYW/,2WK?M
-f:GMdN(K9IR4\bUAKbXUNLF/Y4W3^.^]-C@Q_:I<\?[CD(<H#Bc@SF_=PS4M?7=
fc8EGL;H8\YGJ4]HG?@68CP,?=cV-Z[40+b-&a1@;>==aF0aEUPRBW&0_)S20f5e
^f@5[7@2S];Q@EA4-1>]+&.Z7[1J:Ufd.G].41aBLbb:^[>([0f(T#MP#D]c/c-6
eX?CLTTU]IAG/([FL3XW+L4Y8.DZJ):5U.Q5=\/EX/7;baPRSf]g,SX-d<?&ASG0
5QB^>KATS(g?W,PQZ5@YIQ6DUS+a^&HSC>;L^-X+fQaR75<c:,Z[B8f\_d-c3L<U
)4?;Zfe-YP:M7C?4HJ22d(5(cT(Jd=F,_DMH5#><^g]>64_aG=-U-+ET7EJfP6+f
>)9I3@<bd]P^3>;LV0QT3:>/3>Na;W[FW.&0,1D]U1H@C&M4TIKW7TbP^;RJAf7\
ZYB/#^AA>fJBH(Va?)+]74+dMY8S+-HBS8]K7#)IOJ#91^LWC?#_X<8D=J(KgB#B
BLQ<Vf)+;OR+BYO2d]XZ8Y)>-GY#FC0?Y(([KH]58fbFEHSR<.V8M,eb<dZ)A=W9
Zd,N3V0EO:f<BF2/f.^\QQ(Eb>&,KMWW&e,F6-fH>I?,+OS#a->C?H.]Gg@U10>?
DSL1g1f,0=cgN<D,9C4BC?0XfLME0gV;++.O.FG\M6<NGJQ&;S=U_=b;(M2P:\&H
0/^CgXc5&0/Q)ZGWMFdc2P?<;D1bQ9?7aA(K2fSc.GIVKJ6;6,SF2AD:Zb-A(KN&
eM#Z+EO^OPL:]\bZ;;a&fF_E[L]KDeW?MF+7fWEb\QO=^ZF_MU3)T^Z/U8_VMD>L
d3Nf9G=:6B_BT=J050>V8PIW8@AO[11/Z8<(c60#cDNSQJMb?#D@;PG=,[WgI>6B
>NdbUcN388-9ffV6Cg).HF[KY)bf#PYP^^EC()Wg8D<>&=[/-#?E+Z;\)#fV+Id3
Kf)fQOYC2W\U&Y#f;HA_6e,c1CaZ=&FEGa7&OG/=d9\O#7c\CYQ9C#@?K=O1/&-O
1JEC-Z<C]6^1M::N)bR^IW8/G5O3L>Of9aW]1HX2L@W\Q:,1c1T;&Z&?7NS#&VTJ
2QC>Y.6-IE-10$
`endprotected

  
//vcs_vip_protect
`protected
(/JF,;4??\gK<[C[S]XDFDQ(_4QRB/ecR2AOJ5?-]g5F<I#eIR?,4(2PWZf@-6C&
Z,&F3/:P:UW)KO^Z43TY3?bB(Qe=H:J=c8[-HAD+JM1,B]62;KWEXFCO=W4:>KHC
@)V1aBb:Q>@@E+IDL(WMT.,;&R>R=36&8DE+@(;aC/:C978I/X9,.7-H.g[S@cC-
?9[EO0#;IdbN:>EfM^F<;eTMe5=cA4<?B(dDSPP7//AL]=Xa7fcfW4Nc(V:[\LWX
5<=WKWB?QDNM(Tga.U]L.4/g>?_&6#^WIN=344N9&.W3BU[CU^+\ZQ)0Q/4W&UT7
.eYK;O=c]4>M0$
`endprotected


`protected
eM))E,U[/CSg#B,>ZF,#4PbK3g>b)4=,M[/+,3<E@4:L+Z>F+J4/6)NSDZ-V4RTP
EPQP@63;EZ1Z9CZ1X#DK(1NDHT3<;EQKA8;g\GB>b/J>VQZSGX=F^WO+:H2PI,_T
<d1=Q(COIYT#B6+KUVQN7a9FZG3J89R&@;:Y71(E,KTg-9_CF@-Lf12BQOC\MO_LU$
`endprotected

//vcs_vip_protect
`protected
;=5>/1?N0:.@]2\TYOg60R]OZB:[6&VA7TGE;A125)/3W;#S#K\].(S17;90gHbe
>,bTY-bBe;E7g]Mc-gMF=QFNcCZ5V0\]31&,\V<>U<OUc8N=PdPDNC@]YV^.J66,
MHFL)(Y12A^J-;Q_D)49-WE.c^5eLO;(d[E:g+46]]cJ<T+#5-\AN9gC?-6B/b89
I8([D3M>TBIZF_YX\9[+T3N/)bG[R:NTG.c4?)K.Y_]M]cd0^B)J^6\V6<=9\8.2
)DN+YHN0C;Ke52BbcQ(4O23@CGe&\eOd7:W/A&@T5+U0YX9.-Y,f)16G43HeaR[4
7[SZ8JHI;/=W[g_/ag57=1WA8RdEQ0,I6]#6]LNIaIS=SKTLOL3^CAP_;C0=0:1T
)-F_SNV2gPG>B,f?S#2?d+(CA)(Y&K&5GI-^U#Nd.N&1Cg^[7f[G>B75LgAG=g=R
P;^C<0]8>>/9^CG/3/3C/P5S)BB@M7V2E4Z?9\f?(_\<\#e;>)?LSS2Q5;+T(LQg
P(W+E+(,YA[1Md#_:YMbSXMUcWeS7TPSC)Xb?-7Scd,6ZYQ/2dbfTW_F+)eODge\
\9CTG12H29(\ONR11:E^:.KFe&c,.IHYa;^7_5=]CXR_=a,/1_.FO\].>6:-FE5f
Z;QSH7M=?]-UdWbc7I((8DGb8fN(WFDV5\(WBAddJ7dU)e1fG.M4^b0K?>Me>/^_
BB83-e2TJ2(59GB3aEQ_7K&?W8O+>e&=1V.8A;>\93SeZH@=/=_6b2W)bQMF)O0T
,P__5;-0H-#Jad8Z8ILAU02ZJQI5fI9(cT9EX3T?dIR/a1GS?J9DLbC_F8S4c]cc
Z-24\ND#@M[G9CP-&6,B;5g,@5VV<3:c5GU-B..\T>5P\5d&:66LW;>RR<-G0b1H
@G@;Y+J5PNUF33;KGfEe/X@[;4,IJc#7X&9519&bS=#/e\JV^;<CCeJ-28c1R3_=
Z>#K2XU1bUXDQQAI;b.5SWD\ce-2)Taea>c;ZR:<d^+3cS+IW8A:6G\d0\>44VCf
<-_dFc5@3FK(DgHAR5PHFgV/L]Y:+M:,+gV&7/QFJCBfdL\@C0Z.OZTP^[\/E1<C
:UgE9FF1JT27FVH2Z=2M<W]UO1H3LQ34A:Z\4C7+P4FX)_;Y8SL1PSA207MS)6R=
=4>V9Y2agK:7b(?7dSEQYI-RW9S[\[^VdP(a#,TSWWeGcg-#@H[<V,9e,RZ6)?W5
c06UM>85ZR+LAL&Sb#89RJ(g/Ig@3e;WB>>YaXd=S/;@cGHYE5fPNRJNA]@V&Z]>
CQ,Z6U/5LN4G/Y20[9XVUZb9RdSPYPf4#>A^N.2YS4MYA^_4)45URNRT?@5K\g?U
HR4G8/F2_KPdCPg72,:QR)g4c2LKOV&BGf9-+626B]fND8_3W^JUM+g7Q[@e22C3
TSHWg0OS__<V+NB=:5L,=eL:_+Kd>d?[6?,)T3#R\e//P@.fQX#fJ72<a&KO/]6M
G-bO\+=NTJ?SWdVS/I5C&2:_X^@8PKAL1?0:DMY7Ca[&4?1aOM&d^(gY2PCDLa-8
VS]ERN4EBGGbT^Z:eXEe0C=K[9eLe(A[,:E/BfQ,e4EU#,WXAPgSFC&+K<4^E&WX
5G\-ceEN0#gMN[A[FU&MKFS>C&gDaSIM10GU).8,=_NNB.J>d\eA]Z>P7WFKTO<(
_H[-56A<BZXb@D7JF@DAaE9(2Z.=-/NgP\SWaE=9^eY.1a7f^Z8P?#.1S2^+Q@I\
3LPY1Oa\<D8:ZUHI.(e:LLJU.;-G.-K(\C?VE=RLV,AXOM\-Ee_A+(BB(9JUZ_fR
4SPb-/Z8YJ;0W&fFRGcLD(aB8SVGI<2EP9E][&#N/H:N<=egcUG)P1&5g_<-V1:C
_99M0P:I==c>1cMVU^ED.?T.0TUgD9c/A:Z6=W0C/A77^?IZJ&LKf(=5\HaPb)5_
,gZJKW&,3)JI#Q,8E.1(\XfE7;EMeBZ.Hc[=0Y:1^990?TBFad8Y,G8@7M&dYZ2S
fBDMF,HYe<NOAeYWbcaQB&g?OZIA^=Od(E@AROOK@.,WgT;1/3?V1Te))e_Vc]96
:B@U525VWcCfa8)&DP-Y+Q^PQ/T\WUNDbOWOVTH>bA@6X\]0#[_WBJ8WP-ZeZbM>
[APfF6&>@+SO2]8@S+2UF/@PMGd>J&&),&/?e+2/B>8Z?2AW(SDS@)d8MYL\GU3&
@5.dE\HEAJ2IWcDG(().H/cgXW9[?;Sg[W)V/JTK=[-^dX;I7CTZE,8X@M2];D:B
3W^2&^cN[YR>6RF^44.#3I[XQ)\Qgb\O_b9_8+([<d/]O4Ha,ZO;/a6-0C[1_2BL
5e;PQ=BEfJc^Jb7,SDGF\9GJWDM\>9MCd]\GUU0Y4;6SZRKMYEY-:CA?)A#+(<7.
Fe&#\)7?2^3[B[UB)&Q79)#W8caNe29FVW8UI^3NSWT-+>=VKY)@.R^H]1;S_<V<
HUD?[/,BIHI(LQc=IW;:(B,X+C4^DYE&7<6If)HPM3G\J6BK<Q00&J/V0YcHce(^
8K[>b6=a8.<<.\LC;>:aVW6Ea,\W,#(3+7IL[^OfbBgNd@C1^g.Z&+>88.:W@EWE
.<.:dT1T;UaCT)fOeU-;Y\Y5-XJCX\=P:@T/0\d6MDHM=S[40V?X=9M==:9OCfI-
)QK4>&PZ7)?JbM>WTKK3cV/JU+8fWC^e#[_D#2KAaeeFD,OV0,?^64FC.]ZR_Ib4
=cd^eO7g#E8X?;&7PWA:a&B6Wf&.BM]5f-46Z:M3MLBT(N@Q2\^+)UO4#R+SfF:a
aN^O8G,4=X(H0^CBJV2a-VUSeR52YS.+M(WCKJ7#F2@[Z_gc]Nc,<@PW[>2.aM9X
gL5S@LW?bJNg7C>AEd5F>L<bbHNb>cG]5CN?.I]\U>a0O1-53MNBb?N&EVeMgS9K
,gRLD/?g[P[\^eASA)XDfC))9_T9c=J1DJH9NP9HLfWI1)EDT+ZGZ@cM+GcNT\4-
A\]1d@S3af])8AJ@XdNVVcGYI:.(1X)8,<1E+GYZ#Z1Q#9WUaWZ,28b1)AT72X]M
eT@\LSXK4,XWBV)I8#12#<aA>144-J^b^06@MC&#)-NEJcO-ZQ[Gc;>#4G7AU3\f
HOB9(H>F#G\-3KWPE9,+DPA9[]?X9fO5[?=gD#_d(NU38<?eW12C6BIL93^T9=NG
dM8I[]P#5b:T1cW8U+P:AfK&A+/SRaU\PfXX\gL4\dO=cX>]DT#(/(JM;O0G#W[8
C&LaRJFTQ588Y_[+JZHb)[CHI?8.J+.D&.>QA=U99&+20Xd\YX;b)P8MMJW845RL
eJ1;@JC7A;GLKd^[c.JTU\I,Q28_-4VQB9dHP^:bGM>SLJZ5PB90XOBX8F?BVC2F
O#<JQ\eLFGPJNdgXR?<0:Ee/0B-TG345U(-I2V@AeJE6d)ODR@AgcRAAQT:V+EC@
/(N8A:_5]6S=5]&a:^1?TJ^[G&f/,00b9D-5JWe;5,V[5=9A5O5;D\0OGE545F>2
S#7><Z9WXJX[T2eR.7/0>^8QE@=M>;SA&\W,C]9MF#e++10JCfX;>ef:I\=gRTVM
<@>Iaa:K;?U^+W=C.=?TCA4+AO?:C,I\H3850]TNXHD051#_^+@LEZ97OgNCbQHI
>eC;@a/43L#R(\dRQ#g6E;e&(N71KYFH^>N_Y2:6@WP(NGLd(R3A_OTX=eKe^gFD
R>dE=ABaV1-N-:4&L+^eb/AEcKbE>b[HJKab<V@[K&[6C(KJ<.,Ea#bDO1Td9[</
&EL#QXI_Qg;VebE&P4(L_d++;10>@L;^UHbVb7F9&8KLEZ#7RDMGWS>9YCQ4U)c.
gF3S2(X?aQ874EUK0aeMCGXQf6<a/KZ[^K<PZUCXgW4.dee.I<4E1W48HR8A.;fA
4GgKSUS_.J[O=fV&Q0^0WU.68V6]aQZQ5\]]F8X/X\J7=C8TIMcN:[a_R3d@8NeE
fAP^@3,P0[RU@VS9MgDXEE2AVDPDH4O0?@J-#BPRZ1^ARe7-/@HCM#OSaYIM&I?,
TQ.=8S?/./9&YX@<ZY?98BSF6#66;,6/_#@(I>3]?&dYSC-W(eI2NQZf=5+82HD=
?\YPRD_B\(/Q,70J5WJ(cbYeE:WP-J-.26#3N5T8(VW^-G].E^L7,XX5fee;B&Rf
Q+N;?8EQNWeE-PF^BH<\3@bO[LbJNd(.g-FQPccVH?GI/6_<^/?F]ZT2(2(3VYX7
M,M6Z.d]Z^>29?4/)JJ]9/8@UT4@(@dH.X9_Kg30W=dC+ROO;F>(H1:APL>ULY(d
D=<e_?g88gH@L&;Z,=4@=-)^/_4BfQ15GVXUZA;=#IaQf^V0+/eTKBc#)a<e9XT_
a55)b[91IA]F3O6+XJ_Q9KW+gF2@eP.IScFZ5D#CG?JF2AL7)N9\f/>B8ee?>fbU
<8Be<@ZZG#H1e+aG.G;\cbWO(IA3G[eDN1SEKC[0U;_W9NfL4#W8?-cSK4B^1.<+
KC]AL>]X3c6TW.8C,E&LdM<JAf8Cg6)/V&)NGZ62>NHAIRU[W+J=KD3e5\UHMYgf
#+XCNaOIDgW-P4/XbY2a/.].gE9VaOccNZGcWN[Ga,J9^UPFXL)1_V6H6:cER81&
Z[NPPCV\cCC9]^5A54M4TY\QCP.SB-H4:AX.Sa0;[,cg2cgR4&CC>-8Z@L01dMX\
cfQ:dJFO^XYK/HW_X+V,<3^NW(K[X#Y2d_^cR^L2#5M(Nd\ENMDSF]eCc;O(TTG.
YNV;ZC4K3^\=]fRS60E?/P\VT=C5g-&9EGDeA?#O50Z&gJ^=4cYY3)cF4N8HX8-8
1XC2JXS;LI2dZNB0#I3HVO=@DV>X8WT7YSfJdBgSQF2DHL#I\:DT/GL,JH7\+b3[
9>12^/6E<I2PMN#&[+;EQR^KLVS.]3-S^^<aK0b@W?9@f#MDS</7N:^QH1HL.I2B
&;,>]STO61(fXdN413B@LCL_53O]4SYQBgM=SS1.&-;.67FgPM0D+S&Z:@3>GRNF
0ZR[NP-SbeeU?cUR=(@SCLNS<7Q36c^/AG8<2(0A7ddBf;fc.;\84g>0aaG\/SAN
VE@Kc]O/+gU8c4)-G8GNO9?2H,(GN7RR/]BN;BUT0MEbW.ROZVPLcJ&;Y8R0:MUd
[SR#9\HK2=&ZXXfb<>3:T1_ba?f-LIbOTJH:)g@OT0aOB&WeKCZ130f16aXK601d
b/TeX/D1NUJ&FLS[f>G/dBJ.gXXB^R+cOI_3)?5c5<TRRgNE_=7^Q.-#1XMGd:DN
WV<BP(fWbMMc2X-A^<_d//BA)PcMD,a_+:)@TMRe>JRH6:8\\>Wa_1=M\3]&7BgE
_KG#.6d.GWX>_F\b/>:;OF1O9SHTI3,g^[CH316RcY#6G[Z.B^#._Cd-1YP8=5gK
1fX51d-+W@B=X[;A]AZI4Caa4QUTS+O6ZMT/Q73_057\3G:U1M.QYJ2E8K&[E?)d
D:L@eFKVV[d.=295+DKbd51^0eEI8B&_-J4Q.@(bT^;(-aLd1_06c[PfI&R-(DeC
E32G6?.HR/DS<#7[620Y)b2gFBbca/LL<#FeW[+8\d^7S=98F=F^@XbfO.FKA6Z/
C713gN=VI.;=O6LFDGM]#(24N,X2ESAd3#,-=EAM(&7f47JJ40&Fb.V(2c(@f6aF
Y0?Z)VF>4>D8.SGN6G42XUF(:U)/WZXZ8Pg<fP?Fbb>;XZ7&RNMJMf[DgGZ>Hfdf
.+;_Q@JR/gA/LH&.L)L9Mde9V6E\O,5_7R:\6MIL16_T?N3=E?ZI9cI=2d->;PI\
-f8/_1=#AJ)8Y\-_#)a]8YAX&0ELf9;V11(GR=Bd@N[BCBA>J(?b]R\S.QLZEU\M
#RPgQ#/Ac:d?ED,ALJ1++RLQ#F=\&+).]&&d2SF3\UYEJK#f\[B7RIaIF04?(7R/
DV2g+Se5GP+K]&fd]&,((>U;9>[MS=AaBW?9MS.KL-N8&M&;N&/RYOTNMa<KYE2e
bEA-T0C_e/[NI4S@X6[XOQF0.U)X96D.W.I9(^UUU-625FPMI2WREG<S@7S7=1E>
SI;F^bPS;R&\=/:#OJ+TA=Ma.@-#8/<L).g>OXU;?Z+WK6TT,07Jc)6TB0=+LbD&
^^^_>C_;>YdZD_EV2?@98a&M1>)EfbLf@.c5.V>7gSQ+c@\L?PLBDE3GLFX&f:)F
I<Y7SFDJ:HR)0AX.YA-=_8QY@WM>-^[KSCg^Z:Z)Z#?VcML]JbS+J)b&/&N].)0G
@()bQ3Xg64FcdJ5/#RL#Tdbc=L_._ZeDZ4^,Pb=5bJRZD\@E00P=TAG>ZLVK8WY<
C8b.O0T/B08bb;[Kb1W/76XYdFT-Uc4W79C#9Rc>5FJ<?/XTA8RWU,Q5RGV76WP\
.WLIL-B2;E.1H\&P?@>f0C5+Ibe@OKQScYYRg)N99(UJ<d+(2Ia1+cJ@33I>0_C/
SR#FU_-T&RLPXSL&6/L:PWbgEd.56Q2d)EVLG40BCQ&H5GMY<NI.6X\;gaZJ9c=G
.BC_8\;9[-T8aRYIcKdXNXg3E/b+HDUV(;_AEXg]O7>QA197.Q/XFR#/WZ_>+>3/
eGSfDB>Y2NAf5#&A;U:[3<81_:596P[ML0XAX8G)5/K;5SQM(>5#27+Yf=bJHR9;
5Q0QFI=I>V5+IG9CQ32cDD>]#C8+6a<G\3&-NBE?(RKXN^OP7-;@XV8fT_NW;;W-
^</gQYBH^WE35Y+AG9@,J^6\Y2U3>Ae_/I:=9/PJf52#a64.TP9c]Aa7N2B42e-R
@cGMX<;[cKN[2de18/VRa.RY-73P-5Y0<^5Q+(Y1[cZ&L5bd94?bFGAE&=eX,F7W
?V<IRV.IQ[.2TW;ga+S&<8]ZSR==DG?8MN]KGX(;(NDIfbKXK^_5aEHDB1B:SC\B
J17eKbcWT>Lcf#5J;Ia^[)1eL?1]#62:fH/O9-MVcF1[XO_<38F?SSW/;:@C_6O<
#/+Wg757,TF#AQYcbUO[4<-7+V_IYQe1>[Q]7NQTQbX+-3BfM9f:H\g;]3.[-Pd(
G7>LN],3=E_GN.<0E[.E0#<=eH+6XZ<Dc^V32UPC10;[gK>19]#,JPGW1^M=53/e
g#[e#e6;5AG(3GY4E.Y3>,b9QKageJ+ZS;^+5\WMa]D_e+VPffG(f4YgLG<DB\O>
Eaaf[-2FeGC;J>]_@2AX+PY)F[22.G6cJ1BQWNUF<;KQe1/b-5B\SM4\6(ZLG0B)
JP85SH^L9\XgAPV.\Le[>7gWDAc:U+#_I5C<Z4;cRc,)+Y0X<HB/8)M_<PRBa/-@
28-,Qg=7@W+004b?_]E1Ta2/HVCf?,VI<5>FT3[g9FdC-0^-75bNP^<M6O1>PVH#
N:3^3F]#.M8_OHMDb#.6;6YMe.[]Q+.a2]@:Ga8V>EVGBKaVa&O.[(BAZV]=-U?6
219:GEb0,6E4\a2f4QQUCaUHYQNQA[>N^e-::e)NSA\[cbBD(BK_3P3#Q4,^(5RS
R8K8gH(9T2Qe.6^(5=T(U94_Z7P-fCOCOEM0NN@FX3.1CS4,<cP\DRDQMcPb]BK0
Cf-PJ/+;>MJO-[<#//S?6+MW@:Q)8UTJSNL,7S/W;dAc^7SV4X<08d+D0JZ9?Q2.
>F0S\M?,F,@ATJ(\J0\<(:YOH\[.Ig\W<4S<R\IRU7U@]D4.JbSIfIgKcL\XZ/JW
LD.3A_2Rd^P+FQ2N#9Uc;K?3G56=@85U+cUW<AeIEL-:)7Fb@Pd^E.ODLeLBYSPg
Z]YBQIK2bZCSLN,NN.=[K:=[g+W/IE?.fdE8^:Y#A\W^X@6>LcVHdfV8A<,IM)BT
U<aV)/W^);:Id?QJbcPfK<VIYF&>XBT\[P2H()ST(T03aZ&C_3#Dg[H9AA9&29@E
:(_@dD&]HQB7f<WKd85U7^d0T/;Cd@4YY@d;)XeIYAW2d2OY)N6KMaJ5:@bA8-SY
O4^[X3cR>)H82)2YfPJ_#R):?Y0ZEd80U?TCFX^;^)e4K-[aN&YJKBZ:Md10LU\(
;9Te8GNA#d7?]5_2aL7AX-VTUg/5ELOPLDOZdW>=7Y1NX#A.5Ca[;3@#cL>B9R5R
OPF\Q0U6[^5S[4#25U=/J/G5TJ7X)]T7]PN-HJaK(e[+F3#+SBHRK_4)KO]f]d2<
EFRdg^1GQ6RX4_F7HVfddX^C2RE-8f#[KbdC3ZXMN,IgUe)W>P1UA;Ba;]/;5?D:
7e)/?R/g@44((([0K=bZA:#9:aa@P063^Z6:;.+1QcV<;;FP9gQ@3W^..##GAAc]
Y7M=Lg]CK(ERe(Vb471IVb_,FVZX7AIO&/A7XTA3<9gQ;JA8M@+266FS5:9>8g?_
_LN@]VB[;,6?55(HOQ[R3#21<MKL[K4f_7@LSFaW-QYQ0\<(3M(8P+ae:I@8?fPT
^Z\ZJJ\0Ybc(>5gM8HBZBa]7;2[YWYT.=^=FO>FDZZFRO]X8A)K.a6^J+?.P[<&I
FFS3cc\@7-FZ]4V>3L0FRK]W(]Z9SVSYPS_FO#]SX&V/f.QUI<f>XKfX+IW)<&R6
DAM^W)eH_e.Y:-VH#:_.&]bJ^--5,De(EJEeX,QJeeH8KT@,WEMEe/@Pb/L-1O7M
D@X?Xf=\[,MKJOV2&FgaUeM1<L[86bV1>J#Xa1JU]fPeDQL6\@a[J.WFK;[.I]g/
ZGf22(WaA62gV5B1eYYI0Q/#a;T7RZP9=WC7OPK>(:d12LE[FJ]@bJQYe[SU8a1]
IXUQ.O(OG9bQ0:VXO.0I<WJ.V&EHL=_<dc6e-KBHI](HfWHa9,E?.KC]63URRIe6
<Q]+_Rb?E)&:NL,d\NK.HBDXVWU\XHcI=L-T@4.1_b2O>..XDbf1\N&A5W5E3YXb
a=<+WE5_>KHKC?]ZN+^IeS[X.A3aYMHJLHU4-H5g@),W/TL)<c42:=2F8c.Ed/^S
4=dA5ZVdPe7a8S5H+?Q.6PJa/dJOIHA,I,_DVe.2CH@K=VG.A&,=.X0(2>[;-@ZL
4W\@Pf81c8+-0E@BQZ25,FMY&[GLR..=&G^O4LfJ(TL#VVD/D7&Yg_1>,cYT2M9b
/7Xc@CFU13La^WUJ-6FKJDK-UcFZL.^5I4Z^R\,F&]Y@2#5@[^\(KNaMdc@)R2W#
JQ#Q/F;&^4I1+<HGNb0ePA..dda0/8d;d(B-=LVJ<W&+6E2>WW@5I(,+e)B0DW#D
T-a7aCcV3e0]YIHFAIAW](/S@I2M=-06]J(ZbM]/dg<QC_Y8TGfI6b2^DF>d&=\/
3DG/_R1YD43#=@>1e.^8,=&U@3\PFeKRRJd@PN>7SdR^bBWLN]L/GXeU0YY[AVMG
[a8FOM4U&=9:Z>MKFI6F-T&E-\=B=AVDQQ#g?OWAR:HXO=PB7cAVKUV?1LLB;Y=U
Q8U1B.U=[0UG@@(P4C.9.BM)T&^/-9]:3]E<NOb<G6#FK.bI<+X[UB]Ad,&PK.;V
Y&4VTU]?7/cVV[2=&M[CP@SE6G5g\29,O2cY:8GU]]Y@b^b4:^&OGEL+LU;7\]C+
Q-TM=8QP5FU)I1-FYKJ7PGLR]:I0R/7AMJ+\@6+FMBI;K]+EHZe;I[1d3ZJa37L4
#;G&NPKF6U:QQCM1fO)#49bd\WWH#K30A7Y?P,<Y/(eA7bXG;3Dg#)<eMe9&HSF=
OE5Q-K4C#UbgSS+0d^9SI1#15BaRGLEY1M470N]W4W.EC0Y3DdDO89\,5))b#.:Z
<TD#N@U(TOVLPQcOaE14b-YWd_Vc0\XH3VC[:_(J?KLga11YfP^VB2a5Uf\==#4R
aG.aIQ>^OVO5-Y1c@-ZSFI/NA#=#I:\)f]8>G)J>PECg,+a2L]2T\2@\Q#GPK?#;
4Z0Q&CK\Fb:AKbgL#Sf7U3U;[],Eg\&C;LOM7cW+7:XHIP^C^WedV?:a1b:19T\&
1[<ZR[11/)AWc2&XRMeGE<[FIb.FMCI1.e#d<<<b_CHdJP3f?Z\DEe2e2>HY&]N?
\B<S<ed+.]+c5^.G_K:<^0QNPRHOVEJ55IQd9Da^d[2:/8GJDR+NDAA=LfFI\9W9
I6>I:-HRQ<gN^>SJX8P?^dVc26/Gd<GSYOIZD=V&RGW\SX5ML0egB6AH&Q8fI=V^
O([<7B=/FAA3T4;.7.[+AV^]JRHR)Q5<[@ML(<2S\Dd>WedOAe(8#B,C1eB.5.BR
NQ.R#/aZA^aJ:&R]e66N3aNZ_7Id]dgU+A7=?PS43N@ZVAaP4TMPHZ]f&S_<V?_F
4@_R#OSFPWC5aD3:[[\B/C[KFF(^-VQ<b_H1PIN-4Z],ZX3XUSdX>\O<^\8XdR3f
F(Tg)Q5X=U]KM2-IZ/=G@LF(0:S6UN)dK:A+G+cXPNZ4D)E2#CH=RC^f3.WQf6_@
fSABE\X@IAML1VYVMf:_GZ)DA>gNbg))[8;-D)UDf_eI>/XLE?(X5(L1#c1US]>>
ZGg_BH,-fCJ:.:\--B&McP?D(PTbP+O?;>cD2.FK;-D^0A]JW.J].>d@LXb@CG\W
c2/[50&_P7.:BTD&88#M&N);B83cVWVAU^e&A;[B8TL#7DK:Z\LZXDG?UL,b,_/9
[g:GU/Xe]^B4G-_,IO#-eb<bS,@NI<f)fXH_X[Ag/O7KEeW-]DT)I30eIE=CPZ/I
ga9>>TKa7bS;9XF_4B=0(TZe()aH9.GJPEC^/aKHO5aS3;2:>J>Of>70#b::JPBN
FB,4eU@#KX<FeJ#S<Z-b/d)PHBL^J(H7/?I4_[WeU:YNM<OC95f/KT>)d)-6gcPY
]@2L-X&((Z3HKULG\gKQMX^J;Ae1?Q[;3/M@bGN9;Y/9N#dB1H:)bd&e[U&c3a:6
]77c5]XB6Q)DX8I,\de4.RN45QQZ7QRL64YEZR<&;ddV,(N(U@KG[JF>\K39E&E<
PP,Y>-.86U5NL-cYQ^a>5E5O83#?^U06+//1FfKT\EaQK7^IO^,QK;F,378,T&7W
V@3S_;^=/feQ:Gd&G;++[?3:gaC>KCXQ0A3@)A1SIQ<Q8&c=>b.?,+;FW\:1\:7,
eT98::eGQ+ZO;ET>7S.S&L;Y[U&O-^FSUK@-<e4;TG(<e4d:8M;I,RO_T/>?KGT5
E)Y#BI]\)dJa<P?EeY,(5WNDMRGX95M+RI2)<&FgS]/;0.Y5RJM]:-,Q+RS<\20M
&VWc5A8bKf6?D#PS].>FUS,\KZV,LBLV-4?^eK>XA,U,E3,O6U.K&(3gY1BTLOgO
IH4/_Y\0_@c3E=8MUIIIG=PL5E#+7A_3#?Y]\\L&+b7XMf/gaC-<&O<YFEMUIKeF
R8^@WQE_=?>2WbS8fE2<;JQ9c;dE0KE3^S0T95GX2V9B&)IR,PI4CLAQcA<2D?7C
/.Pd=37WPY&Eef9f]C7OBeP=TB5Z.DHI(A\7QISKTK)6D>17B0A/H<P:@O-ZXe6#
1b+Tf&QE@H>M;ggE8:A]U1]KA/GJeG/[a<9=G]KS#f53@VA;L0MP/SDTg38;CJ=+
?ZR[K,/8)CgOTXgLK49K,MU\MVJHND5ZdS[g9J)aH/dP,B2,TgOD8f=V0&7:(=GE
M70N9VY)8L.2+\)BT@YeC@?8]_cLg#W.YU:.-;LQU\6X9M-/[Ke2<@5]:RTTIZP<
=/L9Kbad8+T.M2<=(fA^TD][#;M18?c=KA],\fW#X;>5T;J/^SNQIaPPc-UQPY:9
MaN+#a5ZF7MAZ#7?0ONC#5@]OK=dE&c2,/3LX6J)NdC6eSO9a@gW.DN6UL1#<;PO
@S\K;YA=PV5^R,Kg^RA8TNTO?J&adOSN4GeTUca?DW=,9=YGa(S<PRQ\d>=1\<1<
KY)@,@SA-MH@C457FLf[a^Y^4a^D(WU()4eS6DaWTU+5@DV0A-3>[QU]^/I=C.EI
J0.?6)TFS1G2WO.W_O)ZBDMeV(XKGLb(>aff0C1ZRLMPDHcZ,D>5gDJ._Id#&Yd6
2N2G>A^8))969AW;;YgWCE4\S#a1IQ.>:H^8W4=\^,8,#AWG@5b)/gSFNba2f5XZ
)?04PO4F9\VWF\gNUJZNF3;LLR+.g_9Nf9V1aL5?XK@cQZOU@aCd#Q-7)TD]:&_0
@O?9\)8;._QU8_FEI,ZcSM#Qd=N&dd@0T4H8FULKGNg1)/e9589NVM1M?bN8=3O_
9aFPW1b4ZgI\5AEc^?g\P(:ZGQg2WN:6NE82I40:DaF(]Y23HJcbPUS3beFIF#ff
7F3JVQ(C8b/72NO@0W<(]7+@Aae3(LDQG?ecE6a<@]^_E#e0c]^YKG80&E1LTN>,
J^8LAgad:MR_T5H42<UEG_Fa7)71/AbPT>DOc?(C]gAe53W_gbIU=1NVUR@M(,P+
KIG:(F\4FL^/X,<2F]M86SJbR&;E5VFgT0,PFg8N2(2#:]EabI)#^/D4@6Q.(GBE
7I,J)IPKQ\L\fU+8W#1Q9PO[+)Q,#]W\gaFfP<Q^4CBN.GR\;:[D)-g,g^DFZgLB
C&SK\;_e,eBY2P2[1eX;V/JRbNEbWHW59/HF73H?K+[<OCUCJ=>T_#d>?G55d#X/
5G-;X@>2IQ#06:+,0NI_Mba67dbe,+RYZW\2L]f0,KR_a9I<@[KX[DX>LfO1He2,
>,XQX::2M</a&#-_CI23L1F/P)4J(T<5-E\<5]e<-(U@TRAG.ZGP1/5XOJUA+Z\Y
?WC<?3H5=F?[b.SP[g]Se+IVGW@@BHJ4aOH@2VE+fW1:,6b2@O5119I]Jg#8+D;d
O9AW8O34bD=3+WPGYC:>9Dd=/ga^X#<cCX7FM)\?DaL&A:F<VJSJ[=C267+?[(&Y
:#Da.bF+FC9cFDJd2Zf)CKHACA9/_V0S9?@U(@REAS<(\)7MJ8<J+dSI6Cb\KaXD
T9NP@5\29X=]eU_-6IW;D;e38&cTd[P<=5S4PcB7/6J+:55YSc9BAJ^e\N8R^/@?
U+2?//gV_6e-Ydga/M/:?)EF?ZLFHaL4KP&\#P)R4fEg,;(8FM,fY_J1.0N]0fec
^NAI+aR&VG>2\]^K/]>X:fBS8\D2H&1?ME:<R+&KG;gNVV-3;QHI&R2WIA[J[2_U
+RV^#NKf\(+J2.b-Meg,eGGE:EN6C.7G+,0^8WYFa7&VN(,(?.,<0@A;:?)b:gL9
BZ+XQ#:,GJ9_^USIAUg-?^QRBXdK6J^_V88Y4[(5]&ZMg#L:^\Y/Qe8?JP#<J+:]
g.5SY[RQ^V1&5Saa89FWNW)fK_@gPgB0BaWV&,XN>EaOT59JB2MZELaC8K)^C>SK
+8@J2)_7)D#E0dd2<f[8(K,,?KJZ7B?aL]O2XaYW/EfTCTe,#FZSS&HL(:8-TWL(
0L(D.R7+7;.:.^SH.2e=Gg\G-WQBRLC8fQ4>Q]/eH,e,6D8G\.7M&UAS5J\;/g^V
3D.(0;:eG.@&J51-Sc\6M6CBSC5V49UE<=S\#?/:ZJb#WUYdb>(J&d-IXcIO4.@a
EM5SU6dG-Q-ad8JgM19XO]CT.?fTJ;.e^LLF?@YTA<CV@63X\[Vb>\f_E)QJ;Pg4
D,;6S+^RcXDLJJT@>-EU;72;4Cf(+C&OH.@fN6HVH)Y+bb<8gQ.S5R:#H,LB4a@>
URL@&&gST9(.)M-^T0bORC=DLg=8AZ#.:HJKY_7KgWEFV/f(P(;2O,FFE_S<<_=/
3M_0RSY[DF/K1Q[1M0;PG]6[f7GN,8A.FMM@18&d:,,5,-LY-XI8&0.d3(9R)UW_
TS05d#-&V]^KP4?aY;AA]ILUVTgY?E7cZc(=Y8BB^^WD_,WQ\:-KTZ&1dUDL?.#K
S_O9B847^1V;=B2+b^VR1b:1SJGMLK\GR-:\#PE.2J&20L/Ha?TE#ccL4[HV+1Y\
G5T6eP<:G[Rc#:#D)K>dYa:-IbPA\4e:GS>>.\O5Z,\F_bV@dg@D/<Qcd#)NJ)H)
3Qg0cG_/FNbW;0a#ee,V[UK<bP?Rd9AMJ.^829NFQL/c&e\S2a;B?c\-HRa#03WA
#_2[Id]AY<ZSH0[398L<B+1P4VN[4/9g1_HGeAJ3AWD6Z/cOM?0+35OfRF1;Dc77
O#MfCM8\SY+-0_D3?Qag1HCK4@>d@R.<L:\.9B[R7\5#;^GKLIS6=UQZe1dFS(-K
b:3DH\NY3Ub#DaUbe,Kb(I3W9E:<D7MI5RR>.Ke#V6G>R4E6J,/V9.]FIbGNFGMZ
?I4SeQ6G1]L=6VODZ,M[NRdND0V4C<HJ]OXUKMG[Ff1gH_C1O+I9@-d6\bX^<J\,
EaLO8fE(3<geNEYCZX-NXIbdId@3Ugb&9CAe16?a=EVSO(Ee)Ve>]Y/?\XI_J;H?
S=\7M4MAN.2KU#JUc>PB4U4b76/8VFW\KPYRN(d/(X:T@ZP5g:?[7g=F?+IRG)YA
8e2+XP]#78=XQWV2_(.]?SHH5H4[D2VLdO=fMW+Fa>gBR73E5EZfgKH+0b&fE]3Z
@e<N?G68K5K-XLP84OLF20P]8PUFOODQ:?2dIFEPBJ7;5O]V[>_WfT7@/B[0R?>U
8Z1G+=dH2S[?Gb[R(W#QR3X2U+MAG;d\P/4.4&cF6O0g1BQL;bO[^WSY51YS_L75
1fLN.bQAA@R82EQ;DMJ7[WEcT#4=dfIB9WaD@/O9HBP8XURGf(cBLe)P_[.F&-_4
[gI>/(BU=8->5cCA2Bc7cED8(Xd3H(bE>N+V[U5NXN_<U;#-?^^<PF4egU3TCMFF
6BFAXU3/[6)C>L4RIea\\>Tg3E3@/ScK1<]8=21M?KP0fVOdF;8C;^EI-G-,eQ/<
DOU^M&gZeYMX,^SP.,@bI;LB9J>cg?B,9?-Qf[#+3bE1-\eHVC)D.66E55Z/&J_f
\=\0dLfY/I.8FXASCY;K7PGE6KV<A^I?K/H.+XdaU[3Ve8@Fb37F(?P_+a9/LN0R
L<9H/DL[B+)PHd380)cV18XQ)SN\SNK<D6O6f2C,c[QWc5NZ/JeHCA:C@/TE&_Z?
O:T+SfT;b;e>BQFLg\U&E@_4_TTM\bYW30LIaZc\B_PG+RL+I24RNL5d:48S1c3O
G^ZVCLO;@Mc>>2^HGZ:-N[I=NKfc2ZCf4:>Pc0A4(Qd&aZKe&T[MC8#=_[]f_P#/
OC)25\fgC3YLE?PGA/[MMBHC#.SLFK9D)CADWXc5+5P3(2a2Pc#QPKL8#A?FE+X<
/0YS;7>#VJZ1S_J=/5Q37S\;aA=P7/X5MD0JVd#WPW4,4@eOaHSLbbT;F.A9E9@W
H#OP_=O4EN+EII61^BE)]^)[GFE/P3(I/WL:U&fQ0fA)B[V3FM3EV,@K.>3@Z-PM
:\Pe;<,F@]e;ZeNY431aOMIHM4-66I+>(f[fF^\=&:X;K,F=A#5D5F?]EA3QF?8H
C.S+Y[0;UDOA<SZ@2dD_cD^2?)G96aF@RUJE#)3Gc+)AZ_LB87;RY\Z\),_J]F9)
353(gTEbL@H]Q<gQ:N71N0SW-B>HH?&,<(IHKBX^Yd-cIUd0VI12&Z2V-dd58,X\
19e^JLW;>WSI4-bPb5W7=g<G0490NKZbV,WTOKU4(=:HDNcPWBW<FIN5&dLATM0=
1CJ()fS(,F=YWNHT4JJ;TI^75I#-&/8@&f]:Lb3>ZQ[U\<]&bT7QQS;(bYGR9Wg7
ea/0_/WGT0Y7ccY0+V/OYee&;eY:ND5,R[6G;8UQ_N:8B52b#S?FY&8YF&)D.-f#
0;4Z:9d1YWe)N&W3NRC2S^/#gF=EMT.^J;?Bf5?J]L165RU3QQP,f,4gP)/:SLGP
5[E9(DXR51;EG05Kf6@3NVfFV]SdHX4COBe4C_fT14@NCEMYQbW9/4^f2S9;bSHU
M(.A<FQ]EgJ:5SKS(IJAL=D.0:\RP4YfFeBb1K&afYLZRaNTE/#]GN/=_eBM3S[=
YI?Y5@YdI\O_\1KJ]4bcHG=F[U:L9W/LN)LORQGKA#?C6-8F29g;G2ea1T@PJBO0
c)gW0W]EJQ&#Y][f#YZP-f1ZNe+OPI^#=IUfb#21/QN;3?5gS\V()gU\\LC.bI./
73>\MK.LRIA@B:\ZF+XB>O>f43PFYgKXfR6)U?+:a>9J&&Ha?X/C+X5,06bfI1/-
OC\&<eGD[&BQ9DM6b3><Z+K^fRE+=d)B\aWd+<b7J-S7N57=Q<1?Q96SX8F-HNaH
.);^-@2)MZT(_,TTNN&RL[)ZZe+dO2g996]):WQOT7_]:RbE,LHX--5=^0aNM)Le
(CQfGgPXJ41IGQF4OLGd@ZM^Q,OA(>2]63+Z.;E&TVO?_NB(-;+d.,CROQW2IM[P
^EGR_IcXaMZYS96#MJ(PMZKa)W[E]Af+cI<3,I5TO&XR4=.GZ>RNQdXc,Se,HD4=
-7.-HXP)/]f;>?>U#R+\#G[#Y5N^-MgN<D4#F-<26VEW1>bKec-b]L+C.EO43\Q;
0+;cX>LL8H59b(X/JgX@WZT=03PF0T]9dZ6))1I:.6;6>beJd_DVd]B-=&)H,2)7
@f0T@)Y585eMC:B(DIA3A?>V(6O/\H+<c<Z6<IUL>@aL(?E][&@eGL4=PMeIOd&E
0/U.a:;OW&1)_7/f+fY;NeP&4&WR6#=CX5ZE]Z:=2W9^[8T(9+MFB1^#aQ.bS8XW
Q4a?f]P-3[V>2b0R&CC@<;<28DdSfOdE2D\#Q111F&ODV+3UIcTbOJ)8.47>b4\.
;B788@Q(S<g,9S=^gVe4T4ILLMe7A>HgA?b@8fF094#)?-WR>Pe+TKde-gg>.PY]
1R>_6bYK:#P/0eTVIU],A?Q?I-.2(K;6XILD.+M=CL&Q>N52:(5QCDC&<W@VT;&@
5WTH>0SdbW&)S@QY;2IE.-0]K7<4_5?dI?O25a68>C/KGO5)#28aNd-,S]_fdJ5C
SUdNF9\g2ZYSWTIJOQ];<53)U+2BPRB@(eXOC(E<Z_g1YZQbaEY[F<Z:H+)=;Y@P
2,2YK?Ag(3J8a0AFaa16:R8&.-_\TfB,1ca-6;@3Yd<0]DER63QL>]]<<2G(E[-X
d&U6A\>Y7-9A#[>B7cJE12F5_7b@fMX7Ke&:E?>0X^@)Z)b0L=BA#;QH8A41X(B+
b77E^8_Z76B\(GgX-Tf.#,9J^2C-,Dg/>MO0^eQB).Kb-=f85LLUgS#7]5Td#cHR
<5[a70OBUgYY0XH5L+O7]BeM52==^1SfTEL<6?]836&4#C:D7E8P7LPM,W=FSA9(
C(aTQE<ZIHXTe[VdbM<36JW;PIH\LV/)]C:PD7?ML9M5,S#PZ+_QJ=/;_G;W[O]B
b[Y9[A;XFR#\6X=HdCL??b1PRH1f,3KQ72>24@gdU0DRG]6L,#B#@HS6HA]^<38;
75#=ef<87#_Lf/G9\2IS#7RZDLZQ>+ec&#0LLC/@1^@78aBLB=a-WTDVD0WQfAT(
CdD?1#S=g5LJN2,YKCc9+)<I]&(c-V.0>9b0c909EPYH_CeO#/_EgU^F.0<^^7DH
c+(e-LXJ=F6BFT-1CHS2@_<3;QgD+9d6TI>67E#gFC5@gJ4aP=;Fg6:&.F&eY#[K
g3\(e:_0&J^CN9fG=[EF&gI:#Ke)<BHLKDXdc?B_ecNQ/8&ID)WMJg7EF6<@[g(V
Db3OUQ9=RIcK@5YV</a@:cDE2<N1B35547Fc]aQI?@^EJ-W@#7Z]-/gRXTL?AP?(
,/P8)R7A(58:8-/F<#6\RMF;+O,)BbJ0_aJgW;;,TA6GCV:0]fN(OL&5YMO#V;fW
X(_NfOJDO\Ab\AVDba>d;7dA=F\9cF(J-X_IY4;CE8M[c?ZGDeA]ND\.Q@]<\&^3
\&)+=JM?\F^/O1P4=8>\OD^HZ;Z0LPa\(;0,BPY/6V6UHKaV_Q#7LffC;IGTQg?,
:Ra,AcbX0J<(;eI24CdGQ&J]JK0g3-Sa7?TZaG,IZ)-(9G:>SFBSY]1.g<-14ZO;
&Ldg0,b9SR-QWF6;L[a:K@3a=Y1.?QbB<GEK@.>TPR4aQ<-Q,^^/&X=Q^F(JSI3D
I))T/&-MFL4X]U(S9WWc.#__a,0I>Z_28F).1gD4IBD^@T<DITD3^;2CEL@b)&f#
A_O0=M,A@QOJ]0(W4VTF\(=2SV5fN.:IK^-XDA55:3G=.N6aD^2IS@,=[5Q/F^<,
)#-ARNNa80?VG<8ZgN-MgR#O[&NQRA5HJee<2G[-V12<1>0b;aUQ5-LV\.&cfLe9
ZTEU=J7EYEJf=&dONcWLLJJe_TdOe\Z\+_VGGRTf)2N^)XN7f9bVVJ.<+M4)=VWW
6Z(A<#(#K&Q@7#cFZR2C\Z2IJGA\MC1-J>,<JX>]&eEB+Q]4(>&N<V;E9NAQ4dVQ
7+cbDFG(3RKL)bV3MB8ab5(?2gTbc#SO098FP5J>L?W/ce&#E;>9D43eB:.>/:Jf
[gM4-0<+A_P<cO5>M-;NE3\+H0T(R):?.J]OgJ(g5FE?7FSW6V6B=@[-7JIJ:O?Y
JMF#RS^1GX&IAY;=K^,V7)ID>dP?;@)WNI1NH>;NAO9C3f>&<<Q_:C\b>B+0a>AI
+9],B?@=C@6_Eg0.](_cRA9H;,^eFJMHR+B&7f&AZRD+#X@H6KMKXN>^.0C8W02&
6B?#>D2:Df;NZ[I9I@N9ORDIbHW^@_ZcU4>FTIGdA.K#(0NH[]25:C(]E2CO]ZXD
SPHBS]LXG_CfIAdRTSG\HLWL&BS/G\Ib_<]?C]D-eW4XSeO\a,dBPG;1eIgO,-8/
X>;HKfdGL1f.ZMJG)86O-2K<b8,gY9(]IZf-KPB=(G82>N@PC:+PTQ228f3.REd,
BD,J]C:aP?V&PLT22HBgBSV+W.5Sb?O2DI=SZ^f/WP]+PEO,/R9ZF9)E4IgRC2:_
1O:f<>ZTc:#3BBa_JA-0FGSaYeTPK4+,7=2V7eVUT6-6/0G/@_V2OUcKG#5MeT_1
X>WU\[)+^/[ZNT.aR&4cFI3B2_I/G)>bda-?.;J&>:L)-@H1=N7956N@0XSRSVbW
74#39EEZ-g.fL]e6dBfA]@A)g?0=X[e(&bg]1._K87=YB[YRF1?ROR01=V==Cf9H
f-LfWV23R([IJHE#6;S^A#(F=4FBI=7Y_NV136]3]U;VKVL+HZGV6?XD/@?@+1<A
H>V].GND\)Q^(>\aKJeQ7BJ+IDAYWKWZaNOGI)aM4e?G14?,M@^Fd-9(d0#N]cI)
TBW<\V(]W58TPeM)FLOZ>JLB_KX9BMU9^GV&>(CW9TBF3)+f?UgMG?IZ#ZHagEG^
:@A1=;1(cWdIL)c&FGJ8PT32XKU]Eg6/<G:/M+Gc>K?.J>?TJ.9Ea.X-aFQBed-B
3c/_:..->0USF)G1c=&(@1_&]^6G=4W9EfK:9SP+E#cYUAcT#b@YBI(\_1;1=9GB
Hg52_:B.dUGL8WO=Z55c_b[c;67G]X-B0BH81<AWNT54a<;(^Ve1WSVYM55TBeLM
K5OW:RaMec)U/O/PEEOR<:MAe@F>7CcfBIYW<(UfeVG9)PR:R;]??2b,J6]dUKBW
3c#d&D;;:&;2+:<8,aAc7aC>2L4S6&GGbf7ZGAYAT:)dP)L(f&005H=&ZV(bN-@5
2^C?GXGe90Ce:+^P_:-MMD9LI^MM_(1dZ>JGYE8&a:2HY0MDO42P7[Pb?JL;^Z\Z
;;\4-bM2S:NYNGH^U-gD^&97]^A-4]A8ZfK;-S/f5fIBO?;9.=763Vg<B>\QebSe
>\3eg?,)0Tf>[\9f\NeKVGWPUGdddGCe._KG?SV?/-f-RYTc<0c<O]9B4M4^a(HA
+/FZ[Q0RS=b?0S0ZgYfPG.a=3WK6^&R/7D#S/4Sb=V,<b\Ia5>I9(5X3JU)\=[)L
D9;FfK@-[[6=PBX;5B<_X/@b>839dW7#+Qf)Qae0K+(L4]EVHD04;^:&NbELDKe?
4b]]47fL,eCXX_)3-ObK6c^cCN/]>32_B-N:W>?J[Cg-<_>eV:>M;fB;NOX.XJEU
:D(2;dMQZP^Ceg)?CQB2\90P5VGZUHFUVR=E2UTD[T\b.F&BRN5&0fC)1QS06G1&
.435FJ\E7XG3KU^ONZEB]M[Z]Oda3V9@>/F)6Zf^E\7We#&cCJ&TP\FA,PDL.-M+
WW>WA-1U;\H9FV6YM4FP@OM)D:W-/N]#2Q2)&\M)(ZM1b?/+EcN()>1Z_7cJ-KR/
d5L2[DG@6;5UO(HU>X<?f1MEO@0QK)^H#U=fV=8Mg8EN^VbMP]HQ#MHQ;B<ZcgNE
\IFAX)RNJK.ZTV&FXKF<I9J-?;aCQ9UQMA6Q@I(>7daA;g#_Ea9RVMGG.[#/L8JP
Y\/?-=]--SZ?#T?,cS/P,?<f6_4M&7H[(&U[bH;)4\G(f/5@RGZY2MZF)be1US7;
FX_aR5A?/1F@.d1^S5.K=[S;ReZ\JI8P__S/P9gG.egCQ=X]UaYJRb:LG#>cHO#+
<g2L@g.[-B[0(SJYUH@QCU.3bPKCB_FQ\&a4/ZIGKG9P3e[^-5@aD\He#QZO7NM,
&/,TK-AU\NLG;a@V)0L7D4SFTT.2..Q9^IVU1.)C#fS9-UW=1TJ8FS&L&K(SY6Cf
E067;a=dJWgU65#>;\9S=@[f0HTC/)+;K\/2@,SBX.)WG@fU:?EcA[;<)AM,Mb(F
:,5OFHLCF:eWZ/Q<_7c?e+1)&Z6^)>Y:S]?)=9gcT@9UI+-8HKX=P^JLWZF#WfEf
WP[H9?Yc(ZN\?#Mb]&(fb_C=P1JbcP5/KPDD&W(><@N8<gEFC(DdZbKO]cE56D+J
.H3A>_C\G;RDK+#BF0:Z,8=7FRD8e/T;cb9cNG,]f+^)>^D[00W61ND&-(V[21FE
2+KJeNEfK3K;)Q(>WQg=HD3.a6MI@NZ10FGEHYBa9DLMbMKX:gGS>0QH.[G=UOGV
aKf/B.-cSSMTB])Q:cdb8:?BN(gGeHEMVVFUOgZ=bCfUA(]1FKQ(I,ZMe:+/^:_?
&93e&Nf()c\^7]R3ECNZZfUa__QQ6IP?P#3:M3e?^AG3V;THZ@\O^eP:9D2:)3SU
9OWe4)YD[R)<;L>b6E56PWQd,Q.M:OVfC^02:D?-e/Tba3JOC;YKa/YRg<KYP@.8
9BHW]&?1\gT:WC:4U:MUE#?IRISB8DM3#fC0OLGT3P5>BDM6VfJ@.G[a;cb#G\ad
GYS1CT/ZBIW>,LE(9#cBe_UO[DRQZ(4g8L[F,d5XdEEDL23[fO-&?Ode.QD8c(+7
+?[Z3[2fA]>Nb2gc2fJDW_cST<HI3bg^A<3W:G_@RZeH,O4K=S,1XCN_F#UE&Pc]
-edaF7c.==_WG&gZS8;0<B<d3ZHef=>4D_Ka7&BR]0S0HX-8]2@UBg9/9:-?E^(P
:M3R0VA0E)@=?=/O6J=XcS-.&f1J:E,DAFP1-D#M<6e57;V-S;IZ4_-W/>feHYB.
NV=.EH98@S>QQ/]8M/;[\PT>;(DN49[Y,\\#b,_M&NB,@NOf:T(4S/deF2a-O9_A
C;RbTTWd6^7;&]59POZ2(TQT,]DfE@RHE<Vc)MN6B)\YGDbaRXZL_/[C;RaYb]SS
06)b-Q\Bd-V8Z);NK\e08>P3.7>T+:TD6<S9,D/]R9IDR8Gc+FG7Od<2=.<64Q<_
P,a<6aO<406L+J#Pb)VM-V0IJf:#b8==ZHSaFA[(MKNf.N.eG7Z#?>RePG_H5gZW
29cI\MQdBA>fP3NY#[gFRJ/+g/90O-I;E#/?XDFQ1F_>KWG.LX&f0R4bdLE8[BHb
KcP:@NP,>VQ5)GXRbIZR7#/OYWR-;U#IIg[>XVRZ[Jf2J,fP[]QRbX;QB]TfH6+2
\WD:bfEUN=<<QPJRKC-V]DX\]TX_H]@CNdCR4,Z==fWA-XcZ5^G1:OF<bJ1-]4KE
<ONIK6SOXYVdM)TD;C;;4@[IC?;c2XDfCG<F1QZ#eX+I#VZ&;e_=eS2ELVOH]J;/
D\=.5VF<U&4JUB>e[-CNGVf=NN1>R0MO#=7WC6G.05^AF@eHV8cTe,bb)Md?#2?7
86D638+QJ4NUT/GbRZ/dY8A#O^<870FXCT],G\C1ZU(#J?51LMZ&5-g7.B6=a,gM
4XPQ=6,D3DG<B3MNY6X:Y:VN=C1;7VI_;\fQ)?+NF[OP<3[TK]+-ecce\NKQfU0X
Y>2O[&1e]]KE2+gZL2bU]/CeM?5RS=+EYcM<8Q=cK@AIgcNI4+?f.RWcIW^gXC5D
Cc9fd=(@FW^7gS&499T7aUaOYT3O^a_[=4A<-FA,XP]+KKL#\1PH35d/985XY#T5
[532WbD>:Y2f13e^+5KVB)HNgeSCAV=FCHagDFdO6W<L.-;7HDKEGf;#2F#g48]B
;C(T0.],[WJJ2gY4(a=1+fT_:a(1O(/ZF,+>3]1EE6?9<6)e,/^CYZJ4Z\=4U8II
\O7E0FY(29)2/K:3E4][DFGA_<6WPHIg,WYb-_T5:)4QIA5F000^KS,3_M.@6&-4
D0\YY4.dQS@V6UZ?TY6XVc=,[Z]Vd]<]\_&K?,=a\XMAc8S=9A\5]_JdD@)7a(=c
Y0#=_HCB=-H\UK>P\.^C,AYM9JI&+=EDPT9]J]P/#.(d6/Q:-XUJOc4(fJYbWCU[
O^&X6N>;M=0BY^A1U42JKC=HBc3Y:[TK[0f#a),/,Z[LDPPEgI7^I&3^]]cR:e-b
R9.g=BX.A+e78/L9]:+.Mf/3&1J;RI4CME#gf189=J<Nd\8=KUJ\AV]YdJ6M#I+I
TILZ9[0FKaa:CY@VHTO\SPaN)D&-/FGA5DdX95S5B_EccNegQaVgT,Nb[@Z>8;7_
N+g+YG<I8J5&Y?7F;X?E<:@=.bKA:ZZe7O8&UK?CW,(FJN>+a^VL&4_2\=8C:3P+
]E^?VU2CQ)9HGbY,g/d>/NHW[,P9cNKH^7LBFAOeG4>AS0C;G[J,5;T=0+aW;]5_
G^#K+(17EWWOLd6.EA^V97=Vf@Z8WE@egTUECb2WZ@EYY8-DM+-5ZKS-^ILQ/FVE
TH5F#U8U>Ng@QB]SbZZ#Z3AIbWc>62[aNc4D.(5,X8BS0;S,Re5AF_O@@DMDRP)3
c_DA7LE@]LB>d>_YeFLH?W./g/QPa[26H0F.cD@f9SgS>0.a+dBB;GT^YZa@<YRZ
\+3_Fa,OJ#g9E>S:DNDc24P3+>EHP=(2?FEV(>6F/O-KY920<Rc>ObV1/:6\[[<R
d.,bH;#EI^Ubg,NH1MSP+QC/.Y2PYYD+^fDf\Cd>K8282R?4<bKN#=;33SU,K9>S
Z@T&CFcV_ZYdXdEY)DV@CEb@;cGK#(_P=eDYb6&W6TKZ^2K/2_[cG]BMfc,FZPcf
DaK(73cLdaB\Ae-).-BQc\DeeCXW4TGbgJP+1.#3dae5K^ATPP5SCQ>Ld9RHI2EO
4509;@J/LdHS4WbV392SIE;d9P^8:&/#&)7GeA(/HIYa@FF<_aXZIP]8GQ>cX7E6
R1-HSK\=?&9AR&CVD#Y.E9A8[?@-fQg4OEN,Y:fDf1Vc:H:)3<XA=RLbe:0D7<eH
Ub;[>3K0WPJVMQ3A9)[+-+OJ>e7Q#_6d]TC]W#S<S5,#23^/^._S@W(P=c<)WJY0
^>Q5dMR8;0A_>gT:\HTEV@.82?]<T-A0\7UB[T5Ag+)e6&Y/>XfQY0,G-eONNDaJ
@11]c0HK?31Z,682R4_IV^#E/R;+bK+TL^EPGX1+=V=39U_&1<=?1DUF#G+YE_:B
3B=)Z.D;G9a-bdE0P0\ZUN9V4QF/()&>?O&M@]eYLQKK_@990<PW62U3;-N:CYW.
2C#0cP5)C=\-^d5X?M]O>O?-9Q7#UXK(3C+5PCLD/^9)bOf-dS2[D>>QGGM)Z&,S
b/aYd1<7]e[OOa2HbT/c6:76:R01XHdDI@LT,[M::2XcDMNEGE\IKR34Z?A8M1#@
6^YB(c7I+Z=b\+)c<8fKA=F=eLY/Y5X?Z\E92?/\]:9+/bS^8Y]S^]>WU)LSf.V@
V-+T9TKWNNbf&9KR3ac18eOJU)=DeCR0//O/+ND@X7(^aY?+#,e>/U&0<++=eLZZ
I\aWA7eHZ^0(G[94(=VGU?a)V#C_DfG=g#N+GBIMJbf,I+@AeKO3LM.UF3.+&<Y/
C)Je1OA\J@gQeKP,QKf9PZaRR3D#&Fe47]C:ID#7R9&_FMR>/.NA&QNHWV.4^<SN
^8)L0Kb_TXOOF9fb.+HS.?8@C;?Q5H>,M2RX4(XEFP04B_.<-8CfEIC<<:T;M9R_
b:7fB,LC<8(3>2ac_H6^VHD&X0L,fBV@FB9>>C]YNT0d\g7.18R&ZWGM(AS)W6g:
CDWS#3&O?0^V5D;;LC:K^\F\(Y6L2gS6Yb-<5G]/AX27ed+W[IGb=P9+7:BfAI@G
)5[&Kd#(HI4fNCRdB(e1HFARN5TE[6]X3YOTH5MLG2QIV&PXd8M7?g6J-aLDcD,-
5@@>1e>VeXdRI\8XcG^7\fEEHRV9_3;P3:.LdGfW2PCH3,KPcNJ6eC,I,W2b=PS[
6(^AM&_:)?3V45>CLC1@>Cd=\<RCT>KH)V&E_QfI.VBTL:.2Q55]Ib9K(?A[HD.(
=^41/C@[6,+51NfNW\O)[:/[KW5LY<3S_A;4fZE;<+X&N;XQE9\VSP>R+]XRGHQd
ALeB^F@0a)G)S=dbCPW+.AEbd)MM[84L\@OGE1W.YSd[,BCfQ6OgS5-0F;4JHc^G
KX-)[;ddV+UB3T[I2X_9/<MG^FWK<FAb>@)#)L1-M89VED&KUfX=9)Te]:/QC^G]
fcFW(\^RB7[B34aS>7TeG_=EB=000c=.^TK&S^bPFD?3QW.9TZ0P9<W.Hf2BH?P-
S+ff-;Sf?0aS_AeERLF<>YCfU#]E<U)/?=D..F)XUDK@L5WL/XR(+JM;M16;&S6T
fGf-KIKc#M(\H5EK.CVL6[^)(WPVP^K1?]2&#/cUc>G.[Q@3H_AcXDDL43.@IIQE
+f,B[a5+U;Fdd0L^K6;b/&.D-[f207LA6_QOC8(&VBHXCEN[)Qbd,>DP/f5B)BYJ
R;eDO0IU]D05Cg[aDRc.0TNU\0ER.9M+L0+J^3_KMf+O[-KCV2W43_T9F]22T\\J
H,5,-CMf@QJ98<I2fKOd@OS=E>7.RbX#]fJaJ]fg5]/Z+]-=9H4g:Y@T]7FXc5C.
7gPJ9LOJZ<C;8#).;a&+2]4T0HVW-UG#,H=>4BK(FG5R7-A9CUOL8Q9SHGXX4:Le
[K9HH10@Q&T+@Rged\KSeMV&dF7Dc4L,H&2K0Ug@N3,\@40[Q8aVe,[,)cbOAgQS
[&0AAc3VL#](1gTQcX6;[P)SZc)EZP10+E=Z&&LP.T9WY7ZI,\T[^J.P:6BT]HJ<
[K^H:M8B;F&:;)+.6^@?W_I)J7]EQ]6^M]YG^?VRTI<>+_JXV9a.cg;JVGa5:DT1
aW(C.,)HZ+=@AE[AT,G=0bNUTC?MU,;61.06bX>+MBVY;A<DE0U@Y5J?;XJ<2:<H
6eG;eQH;?=b?8->CRfceU@ZOUT@/S6.G-<XK\RV?PP2a//(@U7:D79:/(XX\g+Db
fDV1+g^<-0HLNTJSYSD&/fYe(QE(c+F>.A8#5e#QJ^96X\R;)GeG&Pd/FaQPaP>_
8VJf=IU)JLW+,JI(??,K:OSTRG7aM[5&W=KTIIO/&UXJQ2_.-)01]4GHXIR[[#HD
N&<cBZ_c8H<dMUJe#>M)e&6a&TPcE_ed\6W1G-#,37g^<@GAP&6DU&4_KgS?H#d^
,fL..a[W154?/ea2fH&=:&g@63<5M7<#=6VU(6D>a0,dF/bSR61\>:A#_(./Wa4]
\J\=RJ#?_^0(W.0+\)5RVfSYAfD(^OFN.QB1T7XcOE?:#3_d8c1H#:X.-5PZPST:
I#K@Ze0g=(47BU1:TV,9[4R#+<aJAM>SBWEZQ,8U5IGACBPZP#7EW.L]?cLd10YC
T^Fg>2\^\d2;_T)G(bFQ#E(C21]=@ZZ@J>1M.<cO4-L#JD6)/L2NL,U(0:\BC/Re
6B725)]bB,fRR<?PRfT(QP<8Q6QK6eFSPddDM/;(KE3Cgb3N[U<4488\L_L60:c[
C[=RKA#FZb_M;1UO#@MI)TL>#FO4T-50+Z0=g#6J&)9\/R?-@_]79UTDNM7+K;g,
-Ae5QabBT9O,LB(+YGd\(;b\5=Z0_-9a=$
`endprotected


`endif // GUARD_SVT_CHI_BASE_TRANSACTION_SV
