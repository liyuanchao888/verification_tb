
`ifndef GUARD_SVT_APB_TRANSACTION_SV
`define GUARD_SVT_APB_TRANSACTION_SV

/**
 * This is the transaction class which contains all the physical attributes of the
 * transaction like address and data. It also provides the wait state information of the
 * transaction. 
 */
class svt_apb_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ  = `SVT_APB_TRANSACTION_TYPE_READ,
    WRITE = `SVT_APB_TRANSACTION_TYPE_WRITE,
    IDLE  = `SVT_APB_TRANSACTION_TYPE_IDLE
  } xact_type_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    NORMAL = `SVT_APB_TRANSACTION_PPROT0_NORMAL,
    PRIVILEGED = `SVT_APB_TRANSACTION_PPROT0_PRIVILEGED
  } pprot0_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    SECURE = `SVT_APB_TRANSACTION_PPROT1_SECURE,
    NON_SECURE = `SVT_APB_TRANSACTION_PPROT1_NON_SECURE
  } pprot1_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    DATA = `SVT_APB_TRANSACTION_PPROT2_DATA,
    INSTRUCTION = `SVT_APB_TRANSACTION_PPROT2_INSTRUCTION
  } pprot2_enum;
 
  /** Enum to represent FSM State
   */
  typedef enum bit [2:0]{
    IDLE_STATE  = `SVT_APB_TRANSACTION_STATE_IDLE,
    SETUP_STATE = `SVT_APB_TRANSACTION_STATE_SETUP,
    ACCESS_STATE  = `SVT_APB_TRANSACTION_STATE_ENABLE,
    UNKNOWN_STATE = `SVT_APB_TRANSACTION_STATE_UNKNOWN,
    ABORT_STATE  = `SVT_APB_TRANSACTION_STATE_ABORTED
  } xact_state_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Value identifies which slave index this transaction was received on */
  int slave_id;
   
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** Defines whether this is a write or read transaction, or an idle transaction.
   *
   *  This property is rand for master transactions, and non-rand for slave transactions.
   */
  rand xact_type_enum xact_type = IDLE;

  /** Payload data.
   *
   *  This property is rand for both master and slave transactions.
   */
  rand bit [`SVT_APB_MAX_DATA_WIDTH -1:0] data = 0;

  /** This property allows user to send sideband information on APB interface signal control_puser
   */
  rand bit [`SVT_APB_MAX_CONTROL_PUSER_WIDTH -1:0] control_puser = 0;

  /** Payload address.
   *
   *  This property is non-rand for slave transactions.
   */
  rand bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] address = 0;

  /** If this is an idle transaction, define the number of cycles idle.
   *
   *  This property is non-rand for slave transactions.
   */
  rand int num_idle_cycles = 1;

  /** Number of wait cycles that the slave injects
   *
   * This property is non-rand for master transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand int num_wait_cycles = 0;

  /** On Slave side, this member is used to inject slave error response. 
   * 
   * APB Slave VIP drives error response when this member is set to 1 in APB Slave transaction.
   *
   * On Master side, this member is used to report whether master received error response. 
   * If APB Master VIP receives error response from slave, this member is set to 1 in APB Master transaction. 
   *
   * This property is non-rand in APB Master transaction.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or    
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit pslverr_enable = 0;

  /** Write strobe values
   *
   * This property controls which bytes are written to memory.
   * 
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit[`SVT_APB_MAX_DATA_WIDTH/8 -1:0] pstrb = 'hf;

  /** prot[0] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot0_enum pprot0 = NORMAL;

  /** prot[1] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot1_enum pprot1 = SECURE;

  /** prot[2] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot2_enum pprot2 = DATA;

  /** This member reflects the current state of the transaction. This member is
   * updated by the VIP. After user gets access to the transaction object
   * handle, user can track the transaction progress using this member. This
   * member reflects whether transaction is in IDLE state, SETUP state, 
   * ACCESS state or ABORTED state.*/
  xact_state_enum curr_state;

/** @cond PRIVATE */
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the addr. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int addr_width = `SVT_APB_MAX_ADDR_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the data. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int data_width = `SVT_APB_MAX_DATA_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the pstrb. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int pstrb_width = (`SVT_APB_MAX_DATA_WIDTH/8);
  /**sideband signal width
   */
  protected int control_puser_width = `SVT_APB_MAX_CONTROL_PUSER_WIDTH;
   
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
`protected
8>ELcUefS@8U0[<-B0R@g_X@NINHL54VP&>7FT6UVGSD:Q/aP2.17(HEP@P0)XG_
56TB/(Pee#)>VEL<(-.UM4[cb8IZ@HHd(aVZ>/A(#,O--1+V+/]c_;TY^7N@W)B>
f/Ye&K9T;FZ-,CQcLe:(ffVA>JJ50)7Z/XXPf?0Pd(O&T=K6E2Q:CRYNcH4Ug9@E
4VM.BD+OAZd+B\A[b?^TgAgAK+F?A2;aXB<0RfPd9fgI&Dg>@\Zf+C@61LP(#K-f
C?7RTE-#1[DL(VXKAgT03dGA,(#(/1,@d80S4<[BXVNPFW-UD8+.KFLe.U6Hb]>@
V=43aZ9O3KaLP+34GJYc)ON109#O8a4/?$
`endprotected


`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_transaction);
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_transaction)
    `svt_field_enum(xact_type_enum, xact_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int(data, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(control_puser, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(address, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(slave_id, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_idle_cycles, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_wait_cycles, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(pslverr_enable, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_BIN)
    `svt_field_int(pstrb, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_enum(pprot0_enum, pprot0, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot1_enum, pprot1, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot2_enum, pprot2, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(xact_state_enum, curr_state, `SVT_ALL_ON | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_apb_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

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
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
 `else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif
 
`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

 // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

  //--------------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );
  
  //--------------------------------------------------------------------------------
  /** This method returns a string indication unique identification value
   * for object .
   */
  extern virtual function string get_uid();

  //--------------------------------------------------------------------------------
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
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

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

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_transaction)
  `vmm_class_factory(svt_apb_transaction)
`endif
endclass


`protected
G^0)(8U[@_YfXLc4N:A/+[)QB+N?Q3b_\P;GZW&d:N+IAd.8=b\&5)S86\dQHcXQ
bQ,PQcP&d[SGZYP,T3PIS:dbM?#:SfH0eQJ,U/#9;:fY,NYR2;1(PI8f6<V33?G#
-H<-;<-83,YY\0XUB-bZ=INL39/,I1W>[2H#WGVFX(K7YQNWC[^YfH/DL0&DO98a
c8(DbgA+<0Fgf3DD)(=EKcMRA(?46<)PJ9>2:RMHXVJTH7I[;:46V4BD.5C=M#G;
MNbL+dVe5FB-?DZ6HF<=.4fJbZI6FC>C6ee6#HZ8L6AG>K+7T,&S>SU]88<8]QY?
>.FReSQ:VA0c1cccWQf(70bSgJAg_IX+[M7+.PZ5ZC3IXGHA[b)?\;.(c0KF)8a]
>/b.+\YC6#+@HS;A_@H3a1]:f7>RSU_cV&C6=DB(_2cALXD5,@PR#TG:F)<J=f-G
\I1b^Ea<c]F]1&GY2]HPRZKBE8S>T[ZHTE0^_5.Ca8-c_O9&PTLRZ,c[?/=+<CX/
WVL(eF=/^Y<HI[@^Wbg/<2g.)D-XTaC\JG:a>f:7Q>@&E#>ARZ:W]1PG;#Q_]>UJ
=XdZW8d[H0[,6?0]HS9a\.MISSb\cF>f\8?_^;?UJ7E?&BFTX<VG>Pa56)cAJ3Eb
#7BHCgX&JTfS[3S1-2?>FeR;:(]N+A4;,OMHJ74DH];aLc]b4fEdV(<70:5ZWVDK
D>U32c,g88PIa3U@F&C0N<7X_XB3Tce?23YO4PbJ3,69=,\?\;BSQS+?P;fVI(VI
FAHTHQK9QCfbFN^LE8,>I4?LK\-aR@R(cZ_[PB5gZ?CQR>5S^?H:@FB1T9KHSCVV
0ZB9+D6OMJU^Q#LTJ5A_RU[IAPE2\HT1>$
`endprotected

  
//vcs_vip_protect
`protected
a[c?:);<AaRCe8;EK5bNV1c?f8NG8O62,^&/^Fd]P/9UQ35YYcbO/(ECN?R<^dZ7
VO)I3-\\@=\X-\cFD1;MZ66PWYaH29R]A)AVbeNK7&W+N=^1\4VQK^RRR.?^^7.C
&2OG,?14+)N+)02#.6XHg<4XO9/V@=&JJ:9g5@1=,/(Zb2A37D77.F]8+GXbXW,M
a?QYbVJ+\>&,AcYG2bW<8T(B@S:[AGT\0-PGT-.I>J1ICdg:=:NI>09Zcc);]e21
WRc)TMNO>5M8cW0L:fC@H#OacG,ga[\(BKB8]K3K+adHgOMR9>L#d<CAJS[=R?78
c+fe&bX4&:?TN:^ES5[>YV;G0=K]MdTVU[0#SN1[5/9aO+#bEf96K#<0R+R.Z1K:
,CdI5(0GK[0]MLQdd0D:fY1T9_B)>09)NJCggZ2YBV^=+A>7MY<#,8]XS90X71<3
)R2NYHUZN#,f=A7=d@5X-Ff?Me,8+Y]72fgGD24F(Nbe>^P9X0Y62QG.H]:^P8RX
7,+PKR.9LLG;]7W[P&XO./<DIJM&g:@(>]1e-8eZ+=a7[2W?^NeQZd=gAV>XD^BA
cb;?9H15fbH8a[RX)D.deMTGVP7<K\2IE:)Y#LUHOVeEb=8O8<W8]+H4/cPY)O)+
^<>eD[efB?48+$
`endprotected


`protected
e8=ag=]aA<e-[&e(e^+HPEAc?(_/@0YMTJ/65^,gc-YL=fLd-\:_0)0+]&g.)KEF
aIJ9).JX]D]-,$
`endprotected

//vcs_vip_protect
`protected
=Y6/6X2+;\)5>>c9_=)Q7>c\BfacA,c,_.e&I3GGdQc^NTD.\Q?1&(eFIK:G35OA
Z40)R1dc9Og_5EU:-HbNI],C\T[_J^VD)2@.\gN2_Zg+ac[a-F31<NVeY:3B1&Zg
=)X:CLcPO.Sd97MYJ0S5.6\LO46DE/dHB5-AMTZZI/3;KVG6eS6THQbA?/fKg:BC
0;5P,_.L1T@NWe/BeRJR\8MN9G-C2c[b+aLJ1DcX:FQEEUBFJ/#e=A.]#T<DXA8U
J5EeTP\dK,Q9J:V>6C9IYE/54g@PN)K2P[,GV_]>^EA64PXUB?+XXG1XB2d_2,-P
5D6C4HGQ=f:aL3CS7EgFeZ3JK2Ea[TU(L4:[HJNF)[Td6/E#_b6^HUJXHHbII.]3
EEEK)[5c)/DM9P+B=&cL9K1[)SfS_[IZHC5_5@9NCNF#^If76aY-Q4DG3PSaT?J.
Y5X6#eNGM;HB#D6JELYSXLCIC13I)H#DRZ=0NcJ:=-C:.8B1V)3[&#B]6a#0aA4g
_VQ;.#cQW5NO3COS^V(dgRb2NE2cELPb&e;GcW\DGDB>NbSM5@-TSdNZQ#Ne+>DS
IF9\TYe:V1aJZVEa>4>eX3Y=^-Ag=<Qg.b^6#f<f<T>)GHb5=I&Ag\c4ZJTIK<eI
3O79RB_J3F&Y_<eA/6??:GN./ZbU(132gbA5RaR,C0QG]S[E3WU_G/dSX0PK:0,<
6U[.O5=S;L3ET4Ugb:7E^7,.E+B/DWMI[g+L&>.Z,CFRWg)X:LP]/3c&-.Q0(>]V
[^R+;^9&7@DfRTFKN[T]X:L][3AKS=aC#[OcWaJc?b0W+=G[Df<^9KN.QV.1_-+B
MVK9C+bK4NV-/QGQ^>4.XLaKQ)(cPZY+Q=\69P0/X1:cFH.Vg&<P^5[R+OcA(&6f
QaCIVb,\(A^1Y<6D;9417a+/4XU^N-T?,K#5+?eEFVY&PXfb<\RUSQ-aM7HNaWf)
O4K(;X+0P7BA-e=0,[:M2M_VBb:aGK.SfN[F?SE^G]5eN+@V<2<NZ6K,N/TIQeCd
+XFBbND^C@4c8+Ea7Q_ON1c2_2K&1G]^K-Q(/&/2B\XFA1&+f-D5=@Y+>9TLOQEF
.e<?X[7@J]1:6efG::Z+NCD:WMbW-)eB3b@^J^MHD2US@dYb+\Q?)FDXUI(fCPX:
LfK&U=].KUCDXc9][@0BBH]+-FZJ<):(e>2e&?PT6-3Sc4]DYA3a1D-TKGCc?EHM
^/[7])T4R[>/^g/Wc+;5d>&M;Qe/N]3L7E,OCNN2-PBY-ObMI&dXQF^Q:UB6PS-^
7gWBKRK)<<Ec_H#6gU\QJb.3DGP^fQ5;^D,a2,UG>LEAgC8+FZaSB.X2U]V<gQf<
7XXM=eN\dWM],M7K_P9Mfc6c.Lb_(IAS3)cYKcIH(P22OOSfFLda9X-8O^d\7HQ-
MG6X[3#V)+HT\>aU4(:M7K^.Q9\Q6_(e-WQ>gbg+)R/RH&4\a47.S?:fP:PZ.1<S
@?U9W^ZgH1a#,B5:H)/OH1?#HOXY_53OW:N\1,2c@H=79f.ZCMFQ>^844BJ\WD:;
ZQB[Xf>1\D8-gWfZ<eJ#K]fV;IS-)\?-CNCL1:EI<(Ua?7<R-5b+3<^VX_cDa-M>
abZWa],?NfCG/?VV<@cR,\0L8]7D_]0bd&c:&)V^1]eOdF+]eJg?9+G^4Jc?-Z62
=PIe3cGE\D3(/OB-fReb04_(_AVG&GE0,^3\1E2,Pf4#daf2._(&@389fL9ef8YJ
\RRfRRCYVa+BMXC:8DX=QFRF/O0Xc3SHNeG6fb#(-a4;NbZ]QIKD5]UDG-Pb+FXD
d4PESIS#T8e04,0R30DR:30\aSSI79#D:C1]8efa>a#F0E3-M=8^ZZ9^.8>JdJ@4
E40]F:4TWG((?<0]1PQKTVJa][+Y,5XADCSN2U5eWV)@V\b6\,&:K+C+\O@7eW0?
QB_[:fb8=4UM/X7&BBR4RXF5,7.P>]4,=Z.cK^b[b-J4([O7cd(5QA3YL^#a69(-
gYRPdUN42:S/5d?-Ha?ASYN..>]N]L,RfF(_0PL0#I=4^Sc?T6#^:XT]O[)=T:?N
b(Q=+[GWXXOZVNWe#L(T;&CPDOJ9L^GX-^Z1JU.d26N5@-X,-P[;5CY;WFM1GL+R
W.e8?cY6K^9=OgW8/F7BbI6QUA95W2Of6AX7+I-,?&W/0KSgZI)CHW]eTe-cHLS]
+Dcg8;^4?O]VVGY&D8/,B\2<HFW-CYA)>,6<\@DYK5]=]OSY<=FN.NM--Y.&SNI^
H9g_f2[eRP+#D[2P/E.U)>4_1FCK=YA?4N1RVZNc\BN2<0=8]cO;a9<\Z373c?a+
=&PERW+RY3?HV@Z6WeD6CC:D.YIEQN]aBKSWYZQ?L3JQa&-IN0#_?E._9c:TXH&9
c9HRICKb-.3,](a^1\B,S,O7^gS1=MI_Oa>A]SW>C/V[?[0>&-\OM\?<gCga0E.e
WAEPZgM_L?V;L4\7=dM_cLf<@^WL9KG=b8ca=03EC:@[UUQ+M&(c&97-^K@]0Ia6
9EF\\]>U:B8#5-3dN7W7/.EVZ&I2R\W)#._3]H[:IONTYHU<3?d8J<EN>UA_=d2#
2;6NEcL>PW92.C0.;L)aOAV;SZLKDHBPIV7fcSS2HZ;L^+BCdW;Mbf;I2^_/?O+b
KVRXWEFFNX+N2f\ZE3[#\<0gV:,K5ZL=#MW)2aBZ=3H285C#4<R_>;eL-JEF_H\D
aW6/HYa/O5,SQO/R7A#4W]AH#A/Z#.6CZ7,cWc7:=F:-LO\Y>,Q&<?&Vb(Ke<Q-d
L^A4M:Xg;AQYK2MS(QY&aN2/-A/^5H:>-OU9JG@38GHIa<-I)<N&?6,HU0@G/?J]
]SbH>3.[B/GRbWJ<3^g,f:AB,@GXdNSO^Je&QLD6d;@\3O(5A9QINC+J3PL#GaJ1
@50f15&dJ]R(=@cC.#dc\,2A;G2FgK(ZA-9+b[=]7C^Q\GHeNQ/URYZLIN^[d7-C
=X]bFLLHJEX#:@Q6S[=6g615eBQ&bOfKC?^-(Rb-b(gAa_Yf-:E<<<Abg6VFgO9=
Bf8J>U/\Y-,L_BB6-M?b>e0EA>J^d3[[aM7M#1Jc?d?LW/V+\L4a;:\d3Y523Wa[
/5]G[YZJ]6/Lg2a-M,eb42Sg42,OY#C(88KW:C.AN0A)H1@F;&W5R048V41(3;A=
M)S+fJ8eB.LaS(4I72H+9T?V>I/-K-GAO,N_[A0GL.3_XNF_D4AV+5\]9[<&+VS4
?9^:<4GW9KAaP+bgRDJD/14_@<([b9&#_@?OBUf0H1)32CIQgEMZ=;K<#P5_c>Nd
D\MMRQK1aeU8):cNLRI11aIF7U(BI,J5cS4#YIaDN&:e9\8AGa)[O9XI=VE)+R^Z
G5#]d(90f.I-IKQ\=<F;3[C/M1(:]3FJ[CT81I3\7fd=AVP@CA.E^Y^2A5EOA6H>
JYc+@O+a+T2B<XDF.HF[L>8RNOE0,f-O1_6F-QTbRGd08JC#PRXfKgS_L?BHc_?R
5RUg8AJGacVC;&+/F^@)fc:^__N.6#FPeG@5-O49S3fTG-5:\_3BH@UMF1b4J2/4
7HGNI1G<<GC5)?Z)UcZ2=WA-<.816UDB&HX.>]d-g&,c9;3aVFSOg<I=XYX_#0:a
B1[^<2FNe(/2aWZ]G4dQFdb6c/.80>8ES>,1FT/9(9TMg)VSZ5ULX@H5b4]JW4PW
MCQbK^U,GV@g_VNLC/:MZWb/FEM.XXKX?.W]eKPC)?bde,7:3ANa>[64:E-P\]EN
5d;G>g?5cY6&)bG>F9e[0RU]9[SQJ=Od.54KB]dY[0K6L5:-d9#7#.Mc#cFbcW0A
6fF^d7YZ>6fX:HTT)V]CHWO?3_dI=Dd01gANGIN0bGL/HL_Y+R?6f?bQ13XWB2FX
?#ZVR7SgOB,<dOg;&VPfW<7JG_^GL8:-,fY@?37R-cXD#4JQ\5.#6Q4J,7HM[9,?
e;KUB(,7D6C4+)7^HXNWbd#R:&:G,#_fYQ=Z4KPNL#d\NO;O/___U=-eDU]d/A9<
F.+^-)_8YE3GgQ,_e]W[<S+6b^=M30fKJACYg^?EI4e5;/=g5Q(HEO]:]0aIK.b]
EeJTO@d,A)<=MB,E5E,:93X1VQf)fTA9,4R^CT^I&XRH=H\\F;R.5)_C=170JDF6
VPIe0g-_MZgMAR?e25C/QIIa;PA<6ZAHQ&4@S6IKJ)3b)@^)KGGFC?T9]_M=3@J9
I1(Vd^U^)U2R?\fLX9?gI,UD=A_FDF-Q7]8T(dDS];eFO__d>NAAN27);0=SfGMS
cFR<Jd=fG.RbSSUCX-[]?9?P^SNQ?,T1d0<&&TZ(5B10:PZeVUXa\H;TL2@WAY5]
?Lc_/H8a1_;Ye1\0\I?@)-N>a8Jf/Fc.Z4G/ZW?Z)94>Z+J78CJ,,f=>_:F,G\27
FWY7P1@()R\,G#-67E\><QRZ0eG:DLaPJI4?1@J4\IJ(C(]HNY1^3CWY=@]L?/#X
/BR&dEA4QYc.B/=FMZ@bDI>#0:6YIJIW07-9LX8M)P/M&Pb_\CVB(PK)]dDCY#CD
DC^<)W;]V2)>=<\7d;>WQ7&)6J;5Lf1eWCd35.4F.daT)##8NQ4M>DSeILPg:c5-
aL8_[39.;;B^QbZK852K42R9B\ZX.G(@].&8eH)(CfFW@_MDQLS6W:D5)?f/b+af
N]81Yf>HQJ\QG=Vbg,<RDXaJM&76+ZZN_FXd1QBF.^/[+EW99U-4ON6YNY^(#?bE
;05g4VK=0?:f=;T+Z?SU@7KSEN_/fXHGdOK;MC_4SN1;9\L6#a>K]EBR5TJ+5RD^
HE5D8-(2_+e[?b]Xc<f>W+F04bdCQWPDe.5KK0TJ/(AZW7)JHU+Id-XN;/ScJ_YU
MD&)c-@TN7.8\CU/5]P;UK:<NKfA<NaH+SCP]+WW&L&WDe>O[Q:3VQ4b6<aC3gce
+P7.1dc7AIFZ?RC@Lc)NWZ-1O](#@e=-7+b68b(&@0?#HVc?VTH[e/8XG0;fS.,C
Qe4cTG:/.1N38NgV<[_&^;ER5SP^PPXfJ-#T)\<VNdIJ)9J8L1[GQ(3aJ)OfeNbQ
U@:7NZ,KKc>HVL<)3L&P6\RXc@fJdOa,^P/7G,4D]TXN-?/C1(U7VOaW092W8J7/
G>W6LPU#T<I_+B-dH9W,6e0OP61NT:,>_9#1XG?aNXU_6B\CR68U\K2dM5K^XX:L
QH9_^g/>1)/FM>9K[J4GGRgKJW]K(;c,A(cW3R-RNIQL4789eA&ADEgRRTPgUdeO
TL_RCW4)Q<-37g#3=LKg(-Qd1^A<)&AGM>\bM(TR#<)U=_7gE<.e]5<(a7LBQUW;
bQ)a6=KDB4BTD_DcY,XLMF_6H=4(YP4//B@LPR=HU\HVef4Ge@QILV(S-N,94I:b
O78Qc(&NC)eXT33,__AJ:7GSY8\5E,-S[/2YVLEG5;,0e_?F^T9+=TY5<I8WXS<?
4BIa8AUY?;Q^A&:?QPCV55c=\R@=AZ:LP_(O6XKZHNW88dU@T?\:g/QC4g^dIeU^
TS0JT6U..J/L=^+;+HGEJ5,,&7+5RVdGSFB-X^(PO&MKNG-KW7LGaWg^Z[--?);a
#eH^=g_;Q@MW):MKTLU1f+.:OZY3(4f_UU(cRU9=]C&U8R4;IFZG_a7D-#4EU@Z9
#?NYXIHM2OdeST[DIP[+D8e=+B)>/Db\/\7HK5+S-dX>U_WNHN=)d0Z@K<^SZb@#
-GFX.UfCO[)<e#I2+F/;E<-GGJK-),F;=O4E:73?8@:[O]M\KF>\R_eZL0E&YN7+
B()]A&@=de8c:,R+C?W5BJeA9GM>@bXO;NQ0PWeR5E0TW.ZB^JWAS2S<4L5dMS@F
/W:.cRgV32/>QcK5I>@70=.NKA/:HgaOZ+;?-,&3+d9)_aFbKP:\&BTU:&&]J]:a
J>OMBf2&,8_P8ZP)Hf,,dP+]Y7?HfB,8,+BKL3<>:?9P@C8G&DXBH0=M#=+@GX[9
-Q8I\4IZ>N)&F=+AX7#6S^M=eCDCfX&QbL:GB(^a1_b12bZ(&JVF<A#XX-D\\G5.
8E;/R^Pf:M#L?P)F[?V@DHO3=Ie]Q2)2#Id@8@738bCda][&ZU3+Y=5;//,V+-a]
4>&X-;4AAT=/MGW49FO76V2Y.0ZVVX/0,.=YZI9D-5ARNHcUW6+F7]N;YQJT<I>7
JW+([Z5PTEbcfCEB8^:A&?,J=D)=S9:BaIT=_S8_b>>_KN)/6A_f#]-TcP4^ZYEa
gB]VeWg-HG&WH>6XHF>ZIQ[+&0F.XXN]?[6DXGPA#@R[U&AVf2Z;g,6SD0L^D:UH
gK@983P]TI=9RKS)gKJH^A#O9/]#;a[BdU^AA9CX3L.V]V,K<f85Z9PYLJ-T(PD<
<L@6KDG(5Vg_0+#[E;WX+&1LN(AQSEIG5J08N;/A,\eY=L7-I[1+GYQ+N\.2C-@A
U,/f9PHJ.-8HWMT_c1VD\Z)8XIOa8;fYgXIG<B6/>O]T@DB6=Kc:>7NgGCE3EXIA
BT_S/#\00=990]dgc5bN=TU[0bUA]^a:&d@&MbF)7bRe&+#_[K<-NEB4)4M.15<4
T3a:ff//ESW&OT6C:cdg3d?0c8Dbc+\C=efN_FYNOGL>IWB184/U)SWM&G0aY9[)
NOC]^X<>V/WJ5E=[F[6BCQX-SX+d/>ZPRP[]5eL1ed1)g,Q(O].VH@.#K@cIT[+,
R2D3cD+>7QG[d2d44aAE99-M]B)YOF8P(2#&L4T,>d<N[CcQ?GCI]0X44&SS]EXM
YD6V?I32HHf[YJ<f8X\5(3_F/ODd1K\H<4_D2G5E@]3e<1a<cS1b9-9f=]H<^&Od
e7LJOId;ANO;NZ=)7f1FAU(bE0>EFfMCNYfgPaWA\)MQ6S#/45]aa5b8GV^,L?18
Fg45CR(d7QAGGN9.JHU9FX=M(,U?41VOJWY:Y^gaSGAU\d0H#V0JDWERf]VL936S
X4L1D4WVE+#4881abV\J_O^H_@dH#5Y8;LQ6KJ0EH9KMFK-@SW;e(.RYdW7M,BQU
M3@eCX:Pg3/&f.eO?\),bT(V5_]+>#:+T]91.FLAG2[?R0^Qf:8KNALB?E2O.5P:
:&0P[g3C;#^]VbNO>D0(V_Q<<H6/1,cMcF0:+a1ZDXV7^4f.1_,)<,&gg1)<dMW7
=K(e;Ff2<aC+5Wa4KT_9=cCWQ0)P;QP9SA\K4=0\C[3&J,+PH2O93NG?S#UDW#FE
59#^cU0T_+BgT2>NYLfCM]N#<JY&:)CW+=IW;GHf\;DQ]8?d/UU:QKTfW;&(Ra[e
#PcSbD3]-aI6ZJFe/XOTJaE[L)+F.)eYddf@3=Q:ZBSQX2&)e4:L[e]fb7].+.[H
9>JL.Ma&OZEFQ-dG)\gG@c><51AbAH#cTbaUYc0L;36.WaXA3?4ON(]U3Sg(XMH3
-eZEJ<PGO(cEgK#.XV,HX=Fg-0OZ>UN:#1PM&)gDMWUg\U8?P^/3B4E21M<Y+/(G
33#.R0_#QX[HBM;OK\6Jc+:6K/H=BKUd/;a(:^(4F_F#A=4O+50g@:GG7OVE/G)a
3Q&f]^Ce9c,GJKV[NeP3XY2O?O+H(^bQ5GaB6Y;287184@RgSPU<VHBfCeHIFDf:
TZ@&<>5ZdZ(K5;6#+X3(A8AAGB/1&b,/PT+A4]]K2)9-)H;546H+Jb]K]B<VdC7G
gf#Yc01b9@03#1-DTKMa-VRKa#U,,d&;KC)?8bWFM##0#aO8aFH6IF]][C4U\BD=
-QR:+gO&Fa]TcY)OVFV]\VcfF1/6RTF?#C6V(4#(Ve8DP]X=D69ef:0UT80N?30H
M<LAM,=_&VN?9-Y28(U&9,A32W-K_VC#)_f42U2+?>eFOP>U0R)RB3I5#B:FWHX<
F?@LY1M5S6Ca5CTMD3]&=ETX5WYP7?F3?=RY^?1.:T51UW)0AF.=&_4g]M_H4(E:
2OdZD\Q8K]d,?(5AC<gE_d0<c&dTGA19GI(c?X=Fa3dGf1=QcDPTYXfAT9MN-g#8
OHJ[bYH7,OZd-1PDcM]^S5#)4ZcIO;,dY[.#Y,XI,]ZY]7Z#C+@I?0G2fQ/EL:/C
A:WHY2WP]Ag>A)fFV5N#U#:fR]Ic8[7eEC5K0#9?2X89YEf/AN7_&)^)2ABZ](d6
5RT,X@HYYX0&)Y4&>NOBAIVXE/&O8^_#gF-0ZRRCN@-EZ(g:<K&C=07bc5(AK5g<
/aO.3;T>VdYAJUOM,6-H[YYCN[:e&5C^L9ga9e3SRe2/Y0PEB@,RR(9DgNDCR7UK
_02eJ+,.eR<Ig?4__Z+S/PADa\^\Q/g,7F3-BR3I1Z\8CV:&.a-P)a\S4VMX\b_a
(,g+-gAS5[K5JddY&[@-=:.67_Ia/:VF1N&+R[@8LQ&dR+]PQ@D&>6Nc:Z@._[;;
f^A0e@(4E5^9RS^)X]^2QV+C&/FM397^I_MRP[RD:Z5@d-bGZ:C[(_R#JK\]B3;5
V.10.49WQReT^>e56bX(WN#f7]^&OK3-X0)bfX@:^+30^F<1GYY.a.A/c[KQY74L
G@BJFI)@[(Sd_e0ZK?WK0G+Kg-gH[86)S[YaHSGSPLgVE>/K2ZJ/B;bTFV\af+:?
aSEQV7&bcEaX([WgG[/QP[aN,Z^@Q5?(S:#eaf:#=WHc)<eO?YUVWBaP>8K3RLH3
4>gM3L/(>F<V199JO=PKL\cbP::We-)705S4]/=>?+gHdZS3):R[Y,>R^FA/f^Pa
Q8Y^8EWaPge2S<aP\L<K>21.Rb[TAO.2V16>L#aa<7;Sb4Eea2L8)0=f?F.0RZQd
.fY].;@]_/fPM==b/;Q.A9]FRFY3U^8@HG\_&6e[7FA].[0F[M?VbW#.X7(TIfaH
)>]Me,7dT\QFcg3VP19.P>;X)Q?RIgW>90P(4&]+HV]2_\FU4+UT&O/aF1/OWA(S
,S:78H+/:H>5]../-7-5>\/NT8BWKQXM3))^KVI2HH3I;D.&+OOFASK?Rg9H>)HT
#=T/9K.9d[WXM3]RO?#?BE-8gdg8R@24XHA85_c&db.5HC/]#c&IC>1IbGeAOCY,
=MY_=4]X[06Q;)f3f,K^_B9D[>6#)40@>dZ#Y88cHKRTf(gMgg8W.IQ<2C7LY6S8
U)/&28ef.=ebf<A-N#D#/Z@/)Y[_>e:[@b3g(N2f\aI-\I?AeD)0dIILU/SF11AH
+@7R&bd;X><,7:c1A<DFVYb0\/WEe0]82[ZW]:FgG?]RFN2gTQP&D]0L(=[AZc0B
O,W,H5/]+cX?=E,GMgg?Q<#O(XWUb1SU&(GHH<ISI]5@Iab/(a=PKA#^P72V=NW4
\K-](=UV<TWT?4;TS<0Z0JTX28g7c7COKgB=_7V,2CW7G&66fc-fQO0\Fd=f5_I5
fH69\gdOI\b#fQ1PKT@7WfM_U/]O^4XC:2aIe]O[\;:SS6&E9G1@fAI)5&^CaM)Z
0E)D6TGFG(+I5=Z5;A:/b-d8-bJ9bcfg#5\X?+f3;bO1:L:8Qef^0a@9#QXLe.;e
8F19=+QYUC[bJ<L#d+ODVD=.4<d21cSNT7MQeJ._=fOL]]@6C8049=TCJVd=A+(9
1aEe9FFT-Y[<7ecg<)ee.7:13=cf+F>4A>SgA\=IV18T7CdV?dY,1V@4(BN0NPG;
<D;cT3)=<:X@;Q^W.8L8<;3;0&-8NdWKW]Ega?0D[]+KW(DK5M4cX(_D:]F.,c;:
>-/8K\8:Y2/?^O2JG9=(P#6N8Fb>gLb&L\D&2T\cc77AF4EbOP;@/+>2E55X&420
>]8f]ATOaJJ=;2(R-]=P-[GH0c+X_&HE<+Y&BbVGT8Q3Ag+B4Bg?BG)GZE6L+^D;
[C^V;AH8-2^(@5TM#Z3LJa2<TU+W2g1)+1I=E4SPb9ZIA4R2_U\_OJO/HHW-a,4a
QG+0eOf\#c:&0(YAWY-Pbe)d]+#A4ZWUER)RgY2=+&>(5.]19Pa9W(-_7-53@/K[
37MReIC,/I)^J\\WON@g1^W[\D^[7[fK:5Rg(]2JRYEUC)M@)-gQ,:H/(_@R2_/\
R=HT<a;E/K_SS/>M;,;X?ZH[)95K_4IIPYL+8\40cNWcY5E<4[W,((+aOBcAPVXe
Eg\X0gCE]-T5618&D6DS]6f?)=a7(g]Y48=#gf3-59fNPeH/2+P16429P,<^DWBf
C=V0+4V64LfaVe9JB5I@R8JcDN,?J5B3X[HA.ePS3S9>7,YQXe((e^ODRe;:Z4<D
6G^SFS(@^UOMa=HaIVTG077H]-.#W[6(b04&(C4K<4[<:XI3W+R<(Y5YWB7V=;Y8
WVU,+bMWU>V;Z_4?_[IcX1AZcc;T#&^[[2Jd=8;^<(d)&_N01GJ1HAV<H,NS[]_>
R0^2-GA/1Lc4XP140=26)1(Y7<Rf\7P9TBDa<&c2I?[U8Q9OI?@,aXd^/^QKL0LO
;A_WN2\7V:/:;b)V/HOVL-Vb#?[Mb&BeA:/WWM20U593d.73c4M,a2+BLZWF>&J\
d^BdETe=cL#4>(7cC)fEQ_8VDB@_J#12\H9\UKYVH)3?FZ5&B-69RcCZV)T@+GTM
#)?K^AUU<6VGX9R/Cd1?,><Y&?QH:]>&P).I92&acCF2HVZRJDUDFee4cXNE(H\)
IQ^O2,6_8fg=TaaENHEE.BW2T4LAP/,_fFL#I?:_WWNKQ_R;&B2<9<Z](,=LC?4#
9Y?fJNLP;cFBJAS5g,:(3:3[F5&/e_U^TD7+4.<C?;#<Y+)SDg0V6eG(?ge3[#d+
,;&&0?e>V2Xf@79N#1fePUFJZXM?<dTeZ]H\;cY&F(_41Fe@4KFZ,12(cHXP(D(V
-K#D]<0P73,#Rc2T)]7e=U8Ua0LYI;O=R1KBf&(B-bWWXD(5N2M2ZP[fSb\?bGEK
XV-e]7^5,GYMC:7,=S.DcIEVM\-ZMO[,ZGS33MTBK25ERad^V[c>FAdX_YAAa/gJ
4KW3R-5eM0f_c:T#,^NG:eY8N3)4g;YT;OA3gII)G&+#BPG?[,&]=X6VdLXeT0]+
CTKZOI[AW#_c0WU8(5(VfT04VR7cEL4aJ(4GS1KK._OC+^,/(5A0/0G@SL6b;T+L
@[6G7SeDb6A.;1dbU#YGL[M8VSa-92E6X#O//>;B+]0RgN7&P[:GHg]^J)#[+=]3
-0c/VB^NQCg(L,T/FaSZ1]&4X8Z9ZTX7^eC,GB=\d=.09[W=,UV006:fJ))-a1)d
XWaV3,bW^[HcUC[NM>-K]?F._BVO[ER#Gf,9C?>CQ#X:=bZcfLC_K]gD>+512[L?
UZU82E1U/WFXc#(<fDX)I[8M+6F6fR94#=^(gc[P8,F]N<4,B^,@VAdb)(Y1NU?#
B:e.4HcU^[\ONS_#eQI[9P<NEX0VX[E6@@^P,SQ];)L&]D4W4HYPcS&V_>#GK,Jf
7Z@)DI_M[Od?7JZ02gXW&[=G9Z)b86_4b&7a=)#;d(G2DC;dAPU5FeUW_WX&UZf,
g>bY5,3AOAeRUW\9(b(]HfA\FSU@EDR.&g2X3[G<X:=0JM8BK+051NcW9B.4GYFL
[Sf8N=NeF9##SYJT3;)#K-^N6cFNS4/OY.;]OGZPHB7/Le8Xe&1V+]a7S7(=bA]]
[SeKM,8^;&PG:c[f3,.,B/b8E,[_>+X93@?4WF=5ZY#H)(MO>=9F)D=BQ/-0:J)G
?6?TRKTG++5^0/D0W0;HLSH<AdIeJ@IYMC),TCeRX=4TR(-I4>R186/a7[,d,-@N
.V^EA/gS^VR(U4H5M6M_GJZE)/;WBJP68TRL19.a#BW^:a?a1>(/AQ#RF@6E7,#e
VZ_ORL^e6E@#73B-U34E=HPMCM=9GK&9IXcfZ>BR+_L<;W0#XRF5B3L?[;L/M0U\
WT(JKPRF.,>?R/=dC]N:JIG/=ND#1ZRAC;^DA57e19O1Q;BWeYb-0cX_0.1a[d[g
LS6J&8-N3T<9FG-IW>+VZc:Ca>(MI0-c<>76LX.aYWM<TI+N.IQ&.&2O9c5/+DQ-
^(=P@FSI6Igg<bLW0_J\EeZgG#CJ+#KX4+(dA[Ng_A8/FdF)=ca:;gCU_,;?XXC>
;,FSQ>-Pb1.#9B)GXZ_V=KMSRggQC9EM>H^Y5g=Ed5Q0Y&HV?1<:-Q737\&8--,T
CE5XF4/?KRaeNP^9QR^4eS;<)e>DCJ]OLEcEK+b71E@<0.@9eK_Ha-<,6a,)GbTd
-]GM0L/F.a;]2S;6FF821UBM&RR[H>GLWe&B=4M/MVJ04TDE8?-N\#+L<[c_#XX.
6Zdc^J8B[:9A()X>5?S/<2;\82@2KbC:^bO,1@D_BCXa[#)NH?2Q5J22Z6&Ub&4L
9+Oa/Bf^a.<H9P[&1;8,PAV5DIfg#<MZK5V3=72fd&d\IR_]2KV988QUQ7)@-W&7
U?EaF,ZeAeC^I;b6&)I?(_D+eNZ_3T=35/&I-YN.3=La18(f,CT#?#]SdJaD(ZLP
PcM9G#U.CI:/N/4BUa,BBM5#d;.QS[I24R78b<KJ/B2]S_P?AB+?1(b7T)\_6Y1N
[-d9V4Z6[0+NB1YS.a3;QS5b7_GJ<\(b5XI_aFL43F?HI2C^V[C4A6)IfRJ[3g.[
fCT^W.@Fd)L(5]._U.Z.I6GMZ^^c4EHb:e3OHBAM10OJ+;NeR/P[DMG5?M:-Qg9D
^-A=4g:(25XFMAA<?fR&SG:)BK:&_f7P,f,O0U3bX].=e2IY/58]b4HR\0ML,D^<
2dXDJL0?aHVBRT41EP]DSdNR-[O<=;F+S[0N=6@^;O?+FB0>S\D-SNW9F]B^.eXA
[D(G,I_JJDMM\>?HH5fLaeLceT]Eb5HDMP4>59HT4\G(+1V7B1;b?0RZJ&)2;Q4-
FSc^Dg_X_D9W)]WQV7V[7E(>&I.C[6QV?&T&15B,E<-5M@0Q@X:.#AgT4(Jeg@)(
M5_9WZ/&\M>BQPPeb^JY;bGWZU_NebOSEcL#ZW_2AT>C,?B?P87@5Mb(7O^3X4N@
EWagaX,I90O05UOcO=T?:T3JW/,dE8T&1J@04JX_1PF5NA9YBZ_FJd<]4Y[G1;)N
4E.[gX-HSDGXQK:f]A2T[/XYYQ_<>^7Zg32<^OOH5J/d/9O1<M=VXdV2T.6a.+=3
D#5b6@(,a6?0YO@TQ(OXNZ&5-IO^8a:D3](e4XFV&FDD3Cbb^7[KDH]9dBQ.I&AH
):<a\4UP:U:KVO6[>;N<HD04Z<Z;DL,:7(VX-BcI]g,+M?DBYeEMOf.GbCS/6OXG
#,F5^/SD8])II^?cRT=RFHJ+QAcJ+Tf8+9>FU\A=O-d#1b).BT-[BY@beHf:]-7I
<a(/1OfH@<K]>](ZcWVK?]H#,IW1/c4MJH^^#Ga]cU?>[\Z7QV/b.bGC@[Bb>?Na
;W)a\6=0B?\R/LC6Y-^DJR(0T?T)1&=e>cM>V<Be31BCX:VKY:_VH:&K_,[ZK<R]
1379X>JE_CMQQ1fUW#^d<^L2BG),Hf(.881G+W,K.[Z]Z_ff]]e,e;ZX#142CRIN
J9GVPHT:Q;e0B0F0:I/MN/1.=D4aI--73SF)J+5(O2\/+/D<E@3P43W06e@OYF#M
::;^CG]_NCT+7G>Qc926IXYNUI\d8R^_CO0Y?6_6=X&PeT@9P^Y^Y=\M\YL4YB>?
9PW\TQ9^cS,-=4(_c2[MK-R\>]A[58EW\^AFO8/67W6=GV1OG16XI@0gU&BE?W-A
&+5)Q58IS)KOS,N7C[38?\SLBE1D+e=OWc#IO3Z^dC7=N;]eJYN3ce>@E.c[F,^S
N]J##eYINd2K7^a0E=&>_MMI;MMD?;4Z0gbQNUWU;+@Z#=BG8.T[,dVR>HF-6L.9
+;b97G=&eg(V7\_;16a40HB((Mad7IBB8,)4]M6^I/THE1>KLH16J78&CBOSPPgL
?:[NV8?YeFbe60^9S0JV\8KR-4[1JUBeV4:5;]L\#+fLIVaIOG+.eEICPd-QKDM6
c-_Z-eCGac?AQJC>A_AO?9VW_KKC(NPCIKL;)=0/6;Q@MeT.F4+5II7#J.N(]\2Q
BOX3XFT0(2H7(A<=L+;ZXS#10N/R:/QHdE^A(]AC:M\cfC/BcDfSYdBP[^+33R)I
C/856\[WKN>WR&G?Z8B.f08R5\@Z@fAL.<8-)LNQ06Z8U6,TC]d.I]374a;8_AR4
A_ecR@I/_VT/7?4_:S1&8J\(RSGN)dUfbF]5JAZ_NK.XOY&a0He2X,eU=JR+GG=_
4MI<ZW:E/^9+gP_:f>Fdg3gOa1<0JF)+BIcRg>:YAXEfV_R)bfZ9C4HFJ=)3OV0;
[0FPW^53X<dQ=[O.R,_9fQIHHSVG6ZJ94YEVT+^Y1^I+;@-F/3#&SQ;S(#\0)6.F
3.C)gUacQaSDVO,Bd#47<E:E?)7O2N)?A>9-DeG#5N<>1-AER8AgLCdSY:Z3c6#3
^]c6_D=NG)S[97G_9IbN8(Z&E[HPPY.?&>YZ)-)YaY(CW/XR78,09T=(b8R_&6Q\
:X]VWTZ5VL/.8&>3=T62.NB_Q,0(e[7(3+@\9G#2UgE8G7W/G=+FT-5Q.@A?7_#O
0KC&,]S;?>H^PRO-+Y894]OXWbSc(/SQ@=9d5EQeVb9KWa>H=a=THD/]Je5-?27e
VM_J;ZN841U<QWAD6R5J>A^:4Sc?:e);1Vf6N>1KP[bHHM8IS6PX+#CJP[6?8[Mc
MR-1OX_F8OHS?)U.&.?\cKV6bELZ;V0ES;\&I?5>I]//TD-aCfOCPXYQ>Z,M(/,<
-T?_U<(Y6dZ(&b4YFSFb)1.fNfWFQX4.a\XbI=YeJgE5@6UQ;J5_d_)2Ke(;e_N;
bLJNc4\)1-W\;:NXV6(c1QD9QD/E:@MYN-5YRLZNK[^;,ZRec;\;_L,R@?BTIZ-9
33-&IOJ_f)/_UHQ_1H:0d].1O+]e-bE.#E(M:ab;3FFe^_/]#MLddXLUA/ZT\7CV
:;GB=ZSec#JA+[f=&Cg/8<-fC4AX.@MF[b-42TQ.?&A17bKbL895,1>UJNb(W+C.
Y/\\2>3HVG;GgNZQ.9-YKd?X\252V8+A<2=&78<OJHWR]@YQcROc;9+3_OfOPGBb
;R)=eV/_^O2OVB-5B[eE7UYY@PM[7K2H,?@](D:0;K;@[>Y8M<S<<7_;2,TAA#-A
4^17(g/LSe-;P:dcAWMNBK02JNe[7&S5>^8?e:]WXLYV2+fM]/JCEb3.8&_RPD=5
fAf=SFbb:.I\cB3Y=eG.82P[<_5Q&,D]DDD3E\G:_OKd=C3_a^^#4X7#U#2OM.#_
a(a3WVf+940@C+?f5>2.\4_G,NS5_CT#RIT3cV&RF;H0O(,a#Mb+M#V?8<YYeFDL
G(P60ba9e)X&I(<&EGF=LMJSXWT]U?LM@)A_R,<e1V9K1RW@ebd4,f>_8=P0f;\P
Y.&T(RU5KZ+dK\aU,2[Pe@+c8Yg5=5?H1;Aac4/eQ,K]IW8<N2DDHSG24f7f,DME
,O&b:bV[V]PWT^JN4XbgS8TNL(P\/Y30=^d0X.]:JK4_,T(NUGDZ8M?U^@Z3Ra.A
[Z=(S)70A#U#:-=1A<Q1^eTH_.T\52^H.K,XCWEIP_SUa&H;117Y2CVC,W9[aT#=
AJ?[fK:V#VL;]NC9ddPBB#dE7LK^5NS6&.7G2VT)8YbF9c3aW&#.JBIdWe#^gaBO
d/?gGTXT5<gSg&:B1H]RV]?:\B^G3d@K19@NQ;<H/OYQ4dK]-2Z+KRbGLfQBKV66
/(C<P6U\aLJ(M^XP#a01dacB@[=#C=1-2U&YHB4ALNBBOL\HEZ5)JFaPXNV(a5&2
2VSQ#>7BKO6J7N@=D532\f_EWZ/?J&UA7TZ/6)+XF/]HKT8LT#20;/-:^;4<,98W
54XOX3J,/CG04_dQJ7VQ6T2Oe_aYY2Z4J2@R@f/@<88QbPM?N3K:f07V#YHM.Q=,
W5Ng>Ecg-+_aK#36C>@e+6#^S61,)8GNNWKd;#E51?&fe=,EdSOSQL#7MdL.F8PQ
7VLE^9N:AD7fSDF<M2Y@5eTX=1-aD,FT;Le3/A,AK6N7?X5Kf0RcT51\02F+XT,f
Jbe),#Ba^<TO^a4f8IXHPK(egOC##A77g1<L],0#==4S]^Y]B-MbUITBQH0aBE-;
2caf0L@e_24@,<.JNGUN[W4DW1\GT9T64X,<L?UK24E3^3BRALMRO=2QEYTfVE=;
=9H6+D8Q3#HcIBGBbDSL,d>)Gb0M=KF]5NDY2-?2P>6)R[ge9(9+J2Z:^fQ8ZV#J
<ZG92R<,)2K]/J35_>\GW5<YWDbdYV4R7:KETF6Ud4cSQMXO&-[7X_9gCJK+U<H1
PgB4[Fd.GPIBcTDRIHO_):S5f-MTJQ)OE4,,7bd@A560YgcMV]9CF_fLgFdU0K;5
(]MTLYUXa]d[E-eS#U0XbT4LW1E]1M8QU^;>VZ])205Hf,2(:)P1HNZ?1/:O]>/J
]4J@_QST-:OG:1PD=/&g<VCK3+JHX<5A:I4><@4#>f\eT^0?=Lf1b);(14eXC#9/
BZ[M<gR:VZR[eQHI\V)Pg8#1YJYXIcd4/B):AZ(+D_4g&WE,6a@-DB7?/GT#EMZJ
KJ1QTK\/f5XVBRb]TYO_&F?1\(&EdM5bR8F_:7@dDA7EW0AKQKgG6D.XZE.#M,CN
QZ]W@aYZFb-P:)IWNHH<=<?MTV;63e4E<-+d8J2X]d,K678ZU_#IXA3G\<2T\WK6
^/+FW11&KALG_^4T(5Yc7.I\:BBP1gOTY@(dY/3_RQ84[Ug@(I/6ZGaXYKT@7dLT
JJ6[_568AG3DCRUa8&?[I]bf#f.^K5<FQ4SJ3@2g/HGX5Z7/A,g?(U#&CD<YBQ<G
6?^;D&INP=KUf]WL<G#e]-)T_8]-11DV<S.T<9#\)Qcf5WV0RZfVd9O&XUI3JCC;
;X=6UK20WYBASNW.?f;TQJ7:=G1IDG/Y:3N9)J30.0_e?()^_;P8Q\JB1Ja,;HZ<
#TC><5f45/&Oe<We6c)2d&_T(#&PP#a#gYg8GAPSV:[C]U([f1,EUW.7F<UN;9eS
7=DBI#bE8L5a4V2Z1>Z&1_/_C5UfP5P<g2I@1YFaH:]AGH/SF/.:JV;F(T[fNc9V
A7N?aY6dMdP,N9e8<)1H+2.,S3b8-ZU:YdR]R##,=V6]<dgagG9V0YFR#5;+b52_
B&IN=9JD,>-FTD)66N(?A3GH,[)HTcJ>7+><QDSN/NJ?)NE,7U]B&A8V=[,3.37V
ULCR)/JWF5g]dIHc25]>;W#Og)E<WfZE<K)G@^cX_f6(6Sf&@,Q0XRO>,U\bbA@@
^3bCB[6O5Ke:]1B?HCfPCD98R#L2FUHBbf+EDGH++)E\:8gR\#EX\TM&=<+@FE1[
#=aP;[]0)]a]W^;[QVA,J=UE9:?/(UB&a-_(OP(6HIZQ?CEEC)WAgWI_,?33=G#\
<8G]bEY/[<2A2I#6QTP,^7OO?11(:aZca?#:OQDFaBaS7K]QEA#.&>+DA,A]4O.(
H;Pg14a@BG1SX<FI,-2eZYH^f=d@cYQ3A2A[#:AE;S8_4FM#JUTYD(7LF[H7PgI#
1X6-:VA1a,:a8a4YdJ_(b@CcfQ2710<dE;<d1@/Y\W<SUP,Xd1FL9EabZ:(/6:85
,+IG,5@)ZR82RgEA?ED/D&0<EgYfQYBZT=?^?Q)>HOJM..G.5?\XNX7MH<R5,0KL
#E[<#:V.3]f.;;dFH1&AGER[20aeU,35#?;#;WM@P.T&XFE#NA-6aQObe+^0.J.I
QJB-;ULJb<Y)_>Q((C^+><ZG_<+@Z]08a/IPLA6\Qbe@ZP]\7@E\S<HQ<KZNHaK&
RW^W>6I9+7,3]D-aEE=JS]-G6L:#?bZc<a[:)(I5MeN&-g9:P[0JK:O,)(2R.8@/
e@S.9)>&eQ^?.VR6fC.4e;IHc9IMMe_e-Ne@Y&fb<DQBL@Lbb7[:H\36S6#(=](8
CH-adA<?_X)^8F1&0@S]XJ&EgXe1>R#8&BF[VagI9HQS<(T=M]f+8+36L$
`endprotected


`endif // GUARD_SVT_APB_TRANSACTION_SV
