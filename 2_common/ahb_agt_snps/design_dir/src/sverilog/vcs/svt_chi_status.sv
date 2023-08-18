//--------------------------------------------------------------------------
// COPYRIGHT (C) 2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_STATUS_SV
`define GUARD_SVT_CHI_STATUS_SV

typedef class svt_chi_hn_status;
  
// =============================================================================
/**
 *  This is the Chi VIP 'top level' status class used by RN, SN agents(UVM)/groups(VMM).
 */
class svt_chi_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /** Represents the combination of TXSACTIVE and RXSACTIVE signals. */
  typedef enum {
    TXSACTIVE_LOW_RXSACTIVE_LOW   = 0,
    TXSACTIVE_LOW_RXSACTIVE_HIGH  = 1,
    TXSACTIVE_HIGH_RXSACTIVE_LOW  = 2,
    TXSACTIVE_HIGH_RXSACTIVE_HIGH = 3
  } txsactive_rxsactive_enum;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  
  /** Represents the states of the SYSCO Interface state machine. */
  typedef enum  {
    COHERENCY_DISABLED_STATE   = `SVT_CHI_COHERENCY_DISABLED_STATE,
    COHERENCY_CONNECT_STATE    = `SVT_CHI_COHERENCY_CONNECT_STATE,
    COHERENCY_ENABLED_STATE    = `SVT_CHI_COHERENCY_ENABLED_STATE,
    COHERENCY_DISCONNECT_STATE = `SVT_CHI_COHERENCY_DISCONNECT_STATE
  } sysco_interface_state_enum;
  
  /** @cond PRIVATE */
  /** Represents the coherency phase. */
  typedef enum {
    NOP = 0,
    INITIATE_COHERENCY_ENTRY   = 1,
    INITIATE_COHERENCY_EXIT    = 2, 
    ENTER_COHERENCY_DISCONNECT = 3, 
    ENTER_COHERENCY_DISABLED   = 4 
  } coherency_phase_enum;
  /** @endcond */

`endif

  
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Property to define TXSACTIVE and RXSACTIVE signals value. */
  txsactive_rxsactive_enum txsactive_rxsactive;
  
`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** Represents the state of the SYSCO Interface. */
  sysco_interface_state_enum sysco_interface_state;
  
  /** @cond PRIVATE */
  /** 
   * Represents the phases of the sysco coherency. 
   * Phases:
   * - NOP: No Operation. 
   * - INITIATE_COHERENCY_ENTRY  : When there is need to enter coherency enabled state, initiated by RN by asserting SYSCOREQ signal.
   * - INITIATE_COHERENCY_EXIT   : When there is need to exit the coherency enabled state.
   * - ENTER_COHERENCY_DISCONNECT: When the sysco interface state has to be moved from COHERENCY_ENABLED state to COHERENCY_DISCONNECT state by deasserting SYSCOREQ signal.
   * - ENTER_COHERENCY_DISABLED  : When the sysco interface state has to be moved from COHERENCY_DISCONNECT state to COHERENCY_DISABLED state, initaited by IC-RN by deasserting SYSCOACK signal.
   * . 
   */
  coherency_phase_enum coherency_phase;
  /** @endcond */
`endif


  /**
   * Updated by the link layer, this event is triggered when reset the reset
   * signal is asserted.
   */
  event reset_received;

  /**
   * Updated by the link layer, this property indicates that reset is currently
   * in progress (the reset signal is asserted).
   */
  bit is_reset_active = 0;

  /** @cond PRIVATE */

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in DEACTIVATE state.
   */
  bit accumulated_lcrd_tx_deact = 0;

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in STOP state.
   */
  bit accumulated_lcrd_tx_stop = 0;

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in RUN state.
   */
  bit accumulated_lcrd_tx_run = 0;

  /** 
   * Flag that indicates that TX state has been changed because of assertion
   * or deassertion of TXLINKACTIVEREQ.
   */
  bit tx_state_transition = 0;

  /** 
   * Flag that indicates that RX state has been changed because of assertion
   * or deassertion of RXLINKACTIVEACK.
   */
  bit rx_state_transition = 0;

  /** 
   * Flag that indicates that TX state machine has returned all the l-credits.
   */
  bit returned_lcrds = 0;

  /** @endcond */

  /**
   * Updated by the link layer, this property indicates that at least one reset
   * transition has been observed.
   */
  bit reset_transition_observed = 0;

  /**
   * Updated by the link layer, this property Indicates that the link activation
   * sequence is complete and the link is active.
   */
  bit is_link_active = 0;

  /**
   * Records the simulation time when the TXLA state machine transitions to TXLA_RUN state.
   */
  realtime txla_run_state_time = 0;

  /**
   * Records the simulation time when the RXLA state machine transitions to RXLA_RUN state.
   */
  realtime rxla_run_state_time = 0;

  /**
   * Updated by the protocol layer for active components and the link layer for
   * passive components, this property reflects the value of the TXSACTIVE signal.
   */
  bit txsactive = 0;

  /**
   * Updated by the link layer, this property reflects the value of the RXSACTIVE
   * signal.
   */
  bit rxsactive = 0;

  /**
   * Protocol Status object. Contains information related to the protocol layer.
   * Refer to the documentation of #svt_chi_protocol_status class for more details. <br>
   */
  svt_chi_protocol_status prot_status;
 
  /** @cond PRIVATE */
  /**
   * Status of the HNs that the RN/SN node is interacting with. Refer to the 
   * documentation of #svt_chi_hn_status class for more details. <br>
   * This is currently unsupported.
   */
  svt_chi_hn_status hn_status[];
  
  /**
   * Link Status object. Contains information related to the link layer.
   * Refer to the documentation of #svt_chi_link_status class for more details. <br>
   * This is currently not used.
   */
  svt_chi_link_status link_status;
  /** @endcond */
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_chi_status");
`endif
  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_status)
    `svt_field_array_object(hn_status, `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_UVM_NOPACK|`SVT_NOPRINT, `SVT_HOW_DEEP)
    `svt_field_object(prot_status, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(link_status, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_status)


  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_status.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

`ifndef SVT_VMM_TECHNOLOGY
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
  /** 
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
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
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
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
  extern virtual function svt_pattern do_allocate_pattern();

 // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_status)
  `vmm_class_factory(svt_chi_status)
`endif

  /** @endcond */
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
QZ/e2b2JGL+9-f>M/La\d(F[#BM\)-A+F\J^>JH9e:N#c+a0@IWB+),M[;OEF/Nd
gW?caS-bFJK>B,<OF+Q+(N2KL6UG?DSJ-:LRX]UKTfd.Dg5B<X\+H_A__N<-gN]H
2aK8,^;[&X&ZNK(31egL9#]9JAgT&<A?6/,;HP^:/5QV#dOF7aL]:gIZV4CQA/GW
Z@bB1d#NIeER+:TT5113E?&/S?+?3(2M)WJcWAaQ6eCOdC=(d9/Fd.0:f@7Gd2Ed
,15e0_?=V?7:-U(f<^#33;SVaACJX7H1+/D8TA<eg)>AIZWW=</0^<NDbJ<;-FKT
X#H47=F638A6ADJA^;:cR;O582?ZcDLEG?3G_HK5)@40R2<H<U91@6H:NJ=KgTKS
D[^VHT0:\\),6Ng(I6\#;^K_NE[<&4cddO,<cWC)9]8ALeMEDQVFP,<HBF[AG>]8
F.SfBL43:gVOL)OHM\^R-GbQE3[4Xb_<-6O>bO9L,6U\O;a:3c5]AG#eM)H>34fD
T)M&BCC6YU41SCENSI;@RCAQIB8A,Y:&cVSN5#c_+)fWfH2[1+IZ_DU&NCL(Z<4O
e]2#PeG@CgI_G-GC/RZ/CP=WC]-0FO5EaU=(@,7faNG8_O6>PQ>DP:A9P(^(gF]+
46<RL9agV)#GY8=S>IJY3X=W3$
`endprotected


//vcs_vip_protect
`protected
,OK(dP=cKEYE2NBe/^THX(1[[7M#CG:c>,MJ0JS1;FgSQ(D>?AC:-(MF9;B2UZB:
I<c+/W\4OV1bfP7gWF/&/E8fNg^>FT7Yeg,)6g7^)M]R/:(,f-2637+0;^YYNSVP
6OA.?IO)-<66/Bb+O@Td(C[I++F?\3DRXBJSD7HT-@b-_;GY:.<FWXSYLfB.IP)?
.L56WS;EAaJS(?6^;TRTN8#F/H2>5UXO;738P/4NaLd9QC;0.D9]<F(]Y;T3ZQb>
3#4MPG(=3TN5AKaeIQDX6>G6>5a&dY4D-PXME2.IXODM;[\EETV+=&Y/ZP8;62.&
Ag0E=bVa4J-<-Q:1VcESCdOc/bA66L7eJ^=Z.[:PcYN.N+(NY-LGP9;K[AZMJHO:
F1U>#EQ4[VcD;X?3.O88=]&3f>F_@EaVULZ&-P;2YXe8F]_@3EJ\3SN]?9G,Wb4f
C:KZ/fOXKMT<E5&K_[AU/P\.3.4MGL+)SKXN3A_F=FRA=ZEX8QBc8c#=</1GaZ>)
5SKJW.K^^e_4e.f&^8CSIT2PZB17E^W:/0:e18AKBE)L24ECKWe#\T?@)Y:O5=+W
3XDC144L&N4,9NJ/@I39b5?9YYE1GLB/0F+SWU#C37]?GCfD9];a4GH:UR:++M8X
N8c\>MU8_TJNT(dK;,-.&Z,XXIRV7O-5gL2.(TO,(Y:]QU3A0/B,4>5VX_[A1_;N
B1]:_0(0-=B9KYARUUK/2<aFJT5K/d@WZfLGLb,=.A4D\,aKILEfOOXQC#PL1JU^
M@f;F6W)H51.;3LP5f\)&>T;G)+S<N?<<e9W+F?^9@7_]EVVVGgKGJNIA,.aW&(^
&IA4]2_Y82D3dS<_WDPKR]DYN1_.UWU^VY7:AV\/7.OPNNd7=b1F2G>)0^0HAcM\
W1/:/UW5#_eG0a^WId,B1gOJUMD7.3-g,.a(e3:@(\e0\IfA3>QS<[CU\XC#dOW/
540:085]VZZ:72__+E5U-J4[>37/Q]R<(8/0;>CQ=Y\]HX<I,J;BPNI?aU=1S[P.
XW:_F4_-/V@A8<gCOMXF_6_7&S&/2gA5aH#=:MdKT-)WUMFTc.S2<TgM./?6U_+9
/@QOX&?2P5<QN0#Se>GMe?944_6/9R]Q]EDF+I5#L-AFfB>QM#c.fRK4>D<VNKX3
FG1N^](RSR?3\-7RG&7(AO9@aXN2F+HRR>2TE9J6?S1_TM0ULARY5eAZ&Kb(E^W5
DKB<C(G?0ILg-gV6aAa4/b^DT2DXZ5WI@0\2>F/@&fA#/HJ)?6Xb#9c+REP&Y+#K
^0YE)S\=<#3]f5?(B,EA]E8K##2_S+CaJFa,4T.R&<E)0\87FPA(LcP&.E5W(b93
Dff&4U7#=RIA#1=FJXVV-L,)KWP91\)M6(7L&JeFWb[/]4K_?[R5c6I?EL1K]=+#
GT.^:,:,M[7G?CB8KR?7/^KN<4+1;M:VJ[#UV5d_5\RV5Jdea2ceS^]5g9[?^_@c
:]K0=>Sc05Oe67Q=b?>I9BP-9HAQ+\6E<]EH,G4&MJP]a+<WfgJ1V32YKSd\3\S)
?/YPZI/#Zce3JY,V2??;GBAZ/<dOa(L/50@AK>+A;?b#dZDdP0)WRe;G1c]CETK;
8Q-?3>;0652R1&I0USgY)ab_X440d;B7Q;A9]Da71F:0(;&gT7^Bga#57Ee#@ZBa
@#SL^a:UM/IdZLOVC</OaIgbE^G>7658NCQ5Cb[\=I@FZeLKD-YR6/PD0gOScG@N
:R_GN^-Ub&=#&P=Y[VW7>L-\&IJ1)-AG)\T[@)E\F0(@2F59_IXcaT>&K>UB=_?_
3K1+<V-Q5(;N[FCB1ZgPT4c-FgWHJA>K_Q=UUBP@VH@HIO=JGR7&Y45&SfcNIU1\
c#GQe\F<^(\Q/U2_QT4:.^OPPR0IFR+7E_F9?YUg1\YJR7:]]I^E0UKKPUS::\)D
/F0FMGQ@DBJ?-fRB==b)V89>;)_UBV>CM88-,VcKJ[0eM<HNO_J1[IBS90MH>)Ec
0C,_+RS^=B9SH++4Q[.bNO+]5.>R)Sc1YfYLbA^-/;g[,=56J25XXK2F_&.5/14d
YeD,<):XWb10#NCJ):7&4VVTO/PNa]_,K?]+7]V0=\B@ROcLW2dK39GXd.9)KSV7
ZdNSC6>?3?_ZMA6b1ZD:.^\cIcGOdbKZACI+g.CT2[:fQ+RRE061_>FXa6DQ^R]I
T9F239)<2/bbeVQ4L9M=L6GO.F9d1DS]e_Q@CP\f(9bZY:RVcF.-TC,aDaBc-LSY
;6e;[X[8XAdH6..Sdbg(\c^C4M3YFJJO(-P4AL[BSR4OV38>eN=;gMN&,D?<gN+5
].Y>?fC5L44)Uf\<ZF-+a2:G)SJP0BbJ1MIQ>4(IE7caGgbH_A/?^J)S:&TD0&T)
_Fe==eFb@YJ,S@5/^&OPeW++.aI9P)B/d9bDZRQ7(]a<>N\F.^U@1L;)38BaZKCX
BCJDCU^3;MDBWRcD5\gNRGLR\8GY.EO(K;Y).4XI.7eNEA>a1XS@(_#EdfJc#2O4
8PWJ246M)@KUHE8P\[cIB)2Sg5-.feK>K#Z^a]BBf.bdgCb6JGGF7[]bQe7?>B;7
4+^<ID[[H4@7R<W:9+21]aYH53)aWD2L4c1S_=5\cBRb(VP0MYXcF9ceM^5;ZL?<
aS-3Q_](2@K.IXYGB(I_)HIeO)5I4RO)dN_;UU9efQ)\WAON-c]Ab]@T_Xd=09\,
e]WA1G]7bWO5-0P+^;E58>]G^eO\0W+,F^/OgUcaPA-[gb]^D-JP<:f49]R42]TB
c,=/OJT,UdV(#OKJNNVORC7JR-Mfe\O<0_gEMT]<W7D>2_,3/Q[Q6IDCHf7PPSdf
R0#Z4##?VTQQ^@2HY+.@A/Nd31N&_F5)fHAFbH=:\IADD7_H?F?:9(@LQ-/+(UV^
LVARJd)6cYKMUX&/7G0P?)?eQcfeEc9O)06Rf32YZFQ.QY+eeH0NE5O>,5MXV(X2
[(;c0N&bbJc9_7Y.C+M@GJJO;UM?N7ICA/-9/=I,3[C/IdKO7eE37R6G9\Y5/ebP
,&-g;#d8Ee,;>ECGTdBLI5?>(,?ZO#@&#U4T:XX.[-Ja(SI2F[SNPI@GFI<fJLDc
?(-NXDQM9gg?^Wc_0IJ=BNc,5YK:U_]ePI9FQ?@X5ZOQ64.W/.<3.H^#ffbg+G9)
g5_2d6>I0-3IB_D(cA7c(UF+\\>AD7\4&BBPU)E.CaUcK1-<V7g:c.N/GKF/V,[T
]H_dV>Y4MF^<)-5C[R]<X\_P#QIXaV/#W;QD\faV,/?E@D=9TUVSB3NZ).KPP&<3
MA?1Se<\4\GL>G&MM^\#^.(aBKfU@<]INI]bT>G#fQeWS?1I_dT^Pb[JNK=cEJ=[
.gfD0;5a\?(AQa@<,b2G74ZYC244)8YKQ[fM2?I0_:GBb0REKISSB+b:J[^aNE)^
_HL1M]4/Xc?a0@NIQe<SR+SZ&1JY0UF=g9_<07<:-564\X#c8BB.aSfB9cA]<(Ba
-7WE>+QT/d>FaV@5MRYN6a=AR1N?@baEcU-:SEI&CF&T,96#(VSJCJPN8\&,cA75
.0ATfIY,eX2c]IZ;O]KLH-<f:0H(VV+W_]e66ZYG>fCYOG6F)cVZXF)DW/d9eG3Z
EKF/6SHV0#_dV\NRZ7;aO0PH&&WT8EAWWBPdR50K2O07aR;7PB.^2VQD@c?PSZ:S
&=Gd+]g5,;S90bH^b<RI\N]acQ&BM>^F:5ZX(H27I52e7KZ@6D>8Zf/;<N61aU[W
a)#c<3<=dK\7IC9\^#8aN2E#))^.WG-<>C8=P6=7ODEfH1f+AQ@8_M61Q>#Y5:=V
&J>.?.IABacS?4AKFR=.F1-BO(X-<,_E)D?G^/)FB(I3B.XFQ,6L.aIAb1:SR8,#
O>/gU\V67I;/BM)Rd)<T];<2X\>G?Q<J1SW8,cI2OEM4PU)KF)@c0@FLK.g:Z20/
F4aD)ZF<#UTg]YCH8U,)Z_&M.Sg[-b;KDL5R4LgY)=(FcEI&0V,60O[5;fHIZX^Y
c,3U^195W6T=,;II<GEHGPg[,#@[-JIQ3ZG95G1<J5Lg8UL^Bf91UI4e:,_,UTAd
ZY-)Z?<);gP?)DG8-Ig)IS/NQ9SOZPI7O:T&V,=9GQA&DN0J]e:;TfAbB8J7]S::
L[S[+;@0Y50HB+:E@;G-1<S5<^0[Z1]3E3=O-(1A>g^bUeK0@7<[b.=MJ01eU9AQ
6KaKbe>PREW@0e\OM4T6/K?UcFPBEM_[SUJZ_fUD4/d,2IOM)PV:N6(.GV;c2&0S
F]Kcc2R8()FH#T\0KM:6^OIP<OMe^.JNe=WC+G<7[].YfN&3RE-Nb=SO+&EQTKXF
-eN<E/5+Z+E3\AH/gX6=8/-a&R]1)D@JYLUAUV_R<NfWJB]RY\W/S6#Z9[&?Qb@g
d0Q/,>I.a,:O\R7KW.=1:Ed:Y\3CMgA#LLc/&f:EB[e@J.:]U.RZSdC(.3YFD;3@
=221>/7HEU5A<+?#M\9aU6bRM:bVE.)b;G>Yf?1]<4_9&IKI(46BO/UC#LIK]WRa
@c@cM/M\eG99(KNM?9gHNPZd^S-G7IdJbJ.TgU7JY2O=&),_YFJ6_E^OaQY^H[U5
5LN6gEScBF3MIc89J(/7.9-[U3)3CYY8O4GP64&KE5R8EHP)Va7>>76E9)cSS[VC
59[6bVKQL>4QNfI.0;.FW)[T#GD];Sa+5HB(g)b^=9VF<FL,BDO<ZHAb+L<YW2L-
LEJfB6-GHaaUO780E:[?[:H#J-Gc\RJG-6G3&PY)Kgb(&2M[7<C+GH]X4,@e.e8D
,QdRD>8&g)&e#L)2YK5b^_RE]SMBQ>G[APIG6C))LRB,@6F6fG96)]_Sb0RU3f:W
Ig(]:c))(A.1fDI=BA<(+5F7_/XJ\]-1bSX/b<gefA/1J?/VI5IHb0K6JPQ/,G8X
gH2)Ff=YPaPH+;?c3db3]F-_e-.U0ZF?^#c2TKCc0B[_W;T5;54GE29+N>3a45>E
18L0V.,CgT_G-Y)b5M;Y2/FePW7Z\/d>LI]I1\Se([0+8KI7CXUC2^C,7@+HV_8N
42CXKc>SScB=?.e/80;RJJWSUHKgCH)e+Z(8#P,4W7L^-Z;#5ORFI:X;<8WNCG[b
9^fcPF5BGR0daM5DgYAf<DZa(a:e&VDG2b:_QI,eD\JXQ&Jcg^Kc[DGPX@4M3bNK
F_BVA+5<\N>Q#G@3Q4XP[SZ(\E=YZ7Tac7O]3::a/F[PT+[R;6^POP8/,QcbF0/C
-b5O2YPbc.Z;@8HceJ7]/V\B_IMC[;^H3d[E:+#W6:[C#_B#]YbD2=B>\3\KBZS=
Jg8ZHLg9XDWS#Z^W57HHVM_I,P6-?aY6R0_+)_A@eYgI>e;[]2D1/aa@;>LHMV)a
OMM3,IKOY\28^cE\JCfb[=KK+eNPQA@d&0>O,>Z.P]O+&1I]50DCL>?:C1CQ2bZC
8?FM313EVW+S>R<#LWZ3aaB;:/g[U)HO&VC&7(175A;Z0=8CJG:VD5d0VMQ3S6GM
2O9aa,C>>Q&M/I]7#2)fE6TRQC<U#J;g/1E58OY8f8@f&(.ZA?DK\&BFD=U<@?f>
.]J)e_5LE4\L,VX1C6D6g.P7#a/UKgFO?W?[I>a#3O,#080^E+be#CX6L;:@]T5e
/QA0aCQH.N8,RIaO2RN)_M2b7aI5,_34^VM;5(+e](:S_WA&YL3)MHf0.9U/;:Y@
)B#4edY\UFC[?Z_MQaI@B.?CM(:1\C=^N0E\fUU?Y(]<)/I)(VJ)L:&UR@f8fR7L
P1PB.Gc]A>@g#a5c3HYdSX#9Fd289&;<?6e_,/K813S]5AJ^bDgE]Xa^57SGT4=K
Kf+5])8&=ceV4:FEF(ge//TI2gS((ORT/]^2<M6cL?S6#?53S7M>bPZ<YcHSF-I+
dPPH=4Qga39K.OJf>_#;H:I188/g(090X83&#=1,J4GEcM(>&TV3c(@P;#\R:#YM
][<F./^W^bAH(dfT(W)MaKXEC[5ce#C#a>EIg=fd+AG39ZW<&\6aFcYagX[^6bb(
NZY.F4]N4<.d,dY921#f?=PZHQ1ZB>7KS#E#5VLHcV_H(Q(R&\g[RV7:ag^e1HCG
WE/ARI^K^K_KLgCM(Je0[P5gSCbSdeBUGdH3LdGGMC6EcL^P]3/K/eMABD)LYg0?
RHIO>f?/X9\B8f7NADeQ^\4Y\/7ED2@Z4/g&7@:>_<P1#KJIe4@]8G)3:[U9e:G6
X7ZP4TLO_1]GB&L0OR4P:dA(OBFS0TKVK;Pf[M3\1SS8Gb8.d8aS9OZaNf+S4Ig[
1RLOd&Y7CR2:(=&aa907dU,.G[CT:RB?4&^7eU&D[d,;(VF@[CPWC<Ma6<,=36,C
JQG7Y[L<X&T5fI=X:RR5?QFVUAYBeR+5H[XIRT0H?)R@N6R(+EAHM,T.6>TN7<C#
O9B<_8E.6b;F_TNTD+O)-KgW(J4\7gLSWVc<]9b]++P2UA6F6\TDAdQ@g:)M\^=/
>NUA];QK-UC2BXMOF]egbP-1aD[]?e_a9+gBRCGC+b3>CEPIPSa5F@X2]+A<&6@(
dF)QUU>925;6F]f1g(Ne,[^?C5/,_^?56L85O31=RGTHNHM-0L.6YfXG/Ibe-1+-
.Tg@/DQUAVK,e5@[a68O9XX>\)d(1S]V;9<&/O.>W9AB)6GIQG1#8@;4^gX_+;B[
IH315;bV=,f<aG[]dB8Q9<^,C@@JTDb?NUN[\P.E\?;6T&NWVHG6A]7T&6@QJa1g
/UJRAdZR4a1dTO?;F,4SeBdb#,?aZ[aBX\9Zc5NF=U@387dNbgWG)=3O\GbU@Uf#
R++UUOM3H4ENM8ad2\[U8IH5YVQECVW?09IY5-N.&//G4I5=8_M;CA?GD0\D#Z1A
/8?1;4^)B+)_U^CACa=OGF/:Q[g[He<>UW#@/<>edN4-&#<eR><Vc/O/8N5,.aV2
;OD/0OJg\[S>:F8bK)?95cG;[?GC@+Gb29Y?6^Fc#aRR-Y+)AXc03]D=>;(=f)QX
02C0EY-#PMfWK)ML)TR:>UBeg[NZ5T2C)X3PL&@WGecGaa53QS<@M4Z&8,M#7=G>
P4@J9<W@KDd@W:(XC#S1&-OM);IV>L:JB@CF,^,..S-/<KNS0D^6Cf8[fG+7LaKC
ZN9W;QdM=I0P-)VH5&]##PO,eT<=WZfc^2<S(?=B8,3f@_J8>>aLQ37I/ae[R6V@
VNfG;0/6ILI,Q7#M)I&</Qf.Z1_,NS+&b-7UC(TA[</ED0_#D#8<-7D,EROX>YQW
a7B4>F3@1JFV:Xad;gM6T[RY7,JS0eYV0?6ZNOVg/9WG-U00_[CJS+PLULFZS]H7
Q&&+V/W@-MCa[&BC]T3\a_U7+X/&Z+\PYe9PJXH2-3<WK7OgK;,dG4fHC[f_OCP<
fM[.O32fO1C^=S,?7336##dX#6.a:<J2CfC:e37A>[A+E8OZLeO)GRBV4+7C;f3?
UTd7,7TTY12^>-_4TY6gP-ed0H?&dFb)B8C(2ZOg\&USTR5IVH93/<9ZDcFJ)b,e
d[]N:EB24;^9FW#YKD08(7a?De+_>9]?A(@VcC++4SG]<J?0HG(G#^.QF?d-b0,0
;](X())^,fB,UI?IF.EPdQDg5YbZ5QQ)aETe9SdJ2eA=0bLT^^e?:e,[)f3Y4603
VaJJB;PY0fZJ6R=f)<a\Fc8GTY&DY^cR@bB^HH9-9M:dA&]0PKV-#\(T#9E[Z(Z0
BI1??OePOI6?N_1;eL#T;G2+:\A@ZRW>19fcSgSSEb/cWDNCZD[5a-;[=OTSEaPY
[#<BH+3Y8#9DE00>:\KHD1)PgU@_IU@_.T>&Kfg<OU&SOBR?7=1/0A+BC2(Af#c@
YC1S_S[#S7fd=1@ZY]VY.DX0aT^]=H<#LVZ3a?<W>eG,bd30E\K6H6^0HC/4bG7<
.dF4]]?\]=9eI<BE)ZK+/SCQVU:?GVT\a^Nd>P6U@R+^X(<OO&0a)L=C[T>KfJ)X
^XOTFf,CUc\OY\CP=_U464OTMTLf.<>FQa=Z5U<VeYLF8Ad6L8(\9(K1?JW@BXV7
(N;JOC&C?J[J.M(3RCEIQEE3\P6R_KJ3K<927K_Ba]>+L87.cD\K5aAH2U+7a;Te
&ZL7eHCbVJGKV[W4OJg_8C.K2-X+8PB_=QE0JSK9)K[75TK0c.a_JI;XM6-Md=ID
Tf\7<EPIIUH3.f-/c#?5FTB=]>93X#WdT9J\5T[-b/?C<e#3M.))^WIM0^3I8CU#
&NL8+LUC0Lc=fc5MG:eF9/CDQVSW+K6f7f505/eX@WM]-:LGKRf_=/6Ya+UE6PEE
DRL/&>2==X?QY>PTeNH-ZX95CAVYYNFDN-W=1DY;ZQ1X=94TRI>J?L7g0PH193c@
(Ac9^M:IQ^^WC:G[8d17DWRO7a+0a\[4YBg-<Q5?XKCZ=MG26]J1cU1aQ)+UDMaf
LJ,WG^?e=ae0LI-5GGEaB\)6c1DXc&>Y##^1MG9a[4&[M2-8MMJ3BUg(M3dL:HTM
]U^9(&3g\[B.P?VH7Bc/J4HH#VNUGW?XV4BGA&QNgc5f]XH\Z:-Y8Lg8#Hf+ZJP)
)1YZg6_(._,3RgW4N64H5Ie_+2g9#=d<)cgPU?Ig_6?/IHH)LFSD#fR524UTC3;2
K@3dL9@DFS=4=R.dX@)HU?^ES7gR3E+<C=-U.-G>[<2=\6@PI06ZeRQBeL;HLJb]
H17<##4L/AUQBN?TE_H20OL-LDF)Aa8Yeb6BIMb\b>/6]/KEM(\42/,WPO@8c6F_
egO:2&(E4+MBaWQK:B9RG)O8A,8Cb#T_E54+dP[0=N@:(>6UH&[VWKYQJc:K3c\I
5.):(MHeIKC[(2AD8?O_,T>4aY99D5E6YcXKZD(MPD7d\2L5W3+2RTZ0M.])2X6I
3BBY7TC;0[ABE53G@R(DT4>V;)BfAfJUH2:;,bTG<>#.Dg=[TK;<^B\_EaH_fP@f
LW;=-&F#JM/(#&><Q+NTFDG;#2Q:3VW@@=;ZIb@JK5-.4NcR20Fc&aRZ[#(=eWI_
]L^WVKeDY+Z\1Ocf/b>0J\:[S.aB[(RDP5OG:,/BOF5UQ\?C1K#9VAPTd@fHS-F=
=Z,S00X.@HU-bK&.=Ga\_3@b12>HL[V)3THRO3TJ5@>YH,e5e(1H5aR;4(JGD81.
3MK=Z)B/RT:XZ3HcGg8NZ=L._:X1bf<QY>7:2Q;52d)8H]cW<]175_ARU=C8b?+J
<:#aOL2EA_H63(Q6SVZFcAZ#O:-2X:b85<V9/&.&)dWFON5DS<D0dPS>\-,&.cIS
8864,>YW2<\Jc_KZC=3[SH8V+(KKg79@-1;M:S>>5&e3;[0edU1c=N&fZ5PD>V60
2K50.FJ;5\].:]1;];FdV\3_f7cMQ6KDXc)ZO:4ZUNV@^,FB7H<LCW-)MINR^#85
[Dd#]>+eg0,S/AFLN/EAQ.@CBNHD^Z.-45AY5\TL9(.]VAPXOaM?Cd^N:W,I_AGc
,M4-\dN\ePP?-<#be+K0fPBSCW,#KA<,+LdX-3HJd7-OeF7dEHbT_?>c7DK#:919
M;AXe1B6^+f=E;D^)f]1e;^>Z.E#Vee7<33QV?a?921?6K&6Q0X575bS#Ef.S#dL
KR[ff(#0cU8Oa[U7^P+e#S0@V@@D:6>a)9P2e8O.(WQJK-A,Y)^1_7g[WGNEDQb(
<]I8.UaMcXLFXOHd2@EXV)=_Ff/#a87]&Xa[D?:G:g\dMBY(SDIc3;<a,SDQ36;N
a^V^(WGYGNMR.dXIQ;]G^(@;5gcOa-:37K.d)\FA?G08ZPGgQR>XT\f3-HM&[g0K
fFOgXR_+(.>\3Y]VX/d\8H2_6\EJ1B9]_La&d6Uc;=;ea<M1b8TPB69&-Fb/:(0J
U\(;/&TB@^6K1-UMF4N7W)G.7aa:8,K,EM;)\)Ab#,BE34-+abfU+Me^E[L21X#<
ZII:)?3Z05V>)-gOUa:.RJI^3O)QP.)\N3\(L<[gK5KQ0YR26@:8(>0R,S_#e.Fc
9fEZKP?4_MgH??V/+PRHI8gIg/_F-6g.XFgG(a^[c?MV,9WXDI&?6H(]#NXe;8>]
M<@LRK94NSggTfOBKb:I^U82K3J-&KJ#7>9AZ_Q0[>b(DSS+8W8WTLdG<c@M_H8E
I8X3#-FXFL16K<VfWGILT0MIR8+#CfRDQ/[-1=@,Qd2aL90NX,G&I9[b+MV.7LaL
H\XH(aVbga99]I-V3N_a)Z77MgVD/6e:5X]e.<84C>JZ#P@?a^TEg=g^:YA@S6Ff
]Y28;]D/DY_Fe1:cQK,FeIP>5@Q5OJ#W#HXC3O>/\=dYGRACJ[8,1f1<?Z2LMY[X
aJE)V_)6=E(E,6=C1)e1N.;=H\c6#I4=22(X0dTLdb[KZ(UJZ60XeEBgZ@\19LQ2
N-FdDH9J#=3(T;AMfdNV/A3XG-a-#J-SU]1Y?agJ\/1:TR8?5/LY418;6aN5W-J/
]^>dIAfC/^^ZLQ4eS-7dDM2F:=GcA2_[8c&/91Db6#.<MD1,Gge:ZFB68IMTH&e)
6TG/;JZaPNQX7GZ&)8-K/8[:+5c,RFfMH&bFD2R\_[WL^AJbMY.YSf62:[Zg&G3b
K9).\7^U/Zgd6^2_>NdUfTGaFa<3eYTR2]_7@,TZ[O3>C1:SWc<>D9C2ON:,4#^6
c1KN#[&VKQR-EbOFI)g,ZFd9b#67;add+g4T:<:-bQHAJ@=,4.02TT-AF?CW)FR>
2]6-5?.WM&AG4IC9M<\4YP>FE#-U6,Oe,J69.9cF62.C?)?N?#AG#(&4^IT9gL?(
ZMFFRS2I;CBYfG[\)>-C:\;2d@Q2JPd^a<0#_VASX^e,K-M?G,Gf&+/f9f;G6M,B
YOfQ@9&Vc1J;XD#SF=T[BBXg/^)[E\\H+NY=U.R;S.a#FF2FZ\fd_&BFAMdF#1cb
Z(Q7^Ed.3<CN>Oc<EX]U#@8gX;H&>P#_aF)\G&8SZRA5YYVE)6b#_/-EdL20Ca2S
X-fSU132@ZHc3C\a#80Z9,g(aKJ0MZS+@#<,+_D[/AXD<;3N=H]6Fb7[aX):WF,K
4)@^4N0_=>Y+[VV&#K@\gR+.]bHcKe6-V0WT0eY8-GK81A(NKP^#D?,(27)&&L&^
I#PB;5EfBF37R1TXgP\dJR>^6,19&W(A#[5BU[I&VPD;QgNcIEQOdCYQd)BIR\5c
aHAg_#SS_fD+QV\H,>K04D?I<B4D6]-S:b]ZGTJ&5&@4+->M<ONI,/D_0TP3G-Kc
-cQH,GK\8A8c7[+a#WXI]1(1-<R3.(ZHCB3JI/Kd3X4[KSCOC>8&J:+DY8VAOe]H
3EagF\RC&0eH#;\_16.;=T?SMQUV>QJ)<LdA9P,E3d500H^W9Ja\,OXS2g)\=6@^
DBM+Q(U;#e+cOW^05/MaDDfA4@6LW<OO#RZ;cG)L0PG;/#+1L\X)[g7JC\dA7SCd
\[]FI@GcF7F^&g88F\\#0(gB81=82-UFc=XWGQKaLf;Z8]3KMC+XT?eJN5]QXL(4
0a8MPYA\46Y-Q.I>CARX:.FGKN-aLW9ZCX?7I9FG_+?-9fDUTLe)AFY;c:WNZ.d=
)ec8>35#7W.gAF-gY_f]B^9&F&IFddAOC.SV#U3d4CTKO>Z-DgaU6ag]MfZ5fCcP
VMcXbX^MT&.8GIfY)9,gI8daYB3+IR_W-8BUPM<WU54H10H](Of5M&f^BR[0V;U9
D:P=g4+U:T@)LF&:QST6,1Q#O@@BNT.V,DR[K0+)N=5:M^B;(:[[(.c,IF5cXN\5
0TYUb9QI1_9.BU1-)5Y]#]H+5T6T^FD]_HcWXRa+6TGP\)7T;:K_?<J.8LTb6IGA
DO>M[:JGa9^NEG-M9=#CNPKC-4N?>2c4Y[>H+[LXe\L1Kf0^88I+@&R4SZ4<7+H4
J&YTcfDM^(>>g3)H.g(f[RH6OT_;aE5A2B8d5;+bSZYOAKA,,gZ.1dQT7,T456aN
a][4A@J5;?g(@=V6/HK2d/dECS#\627DT>TAC7AgG@=#.UYc+__:IPPOPKE/YBMB
cTa98W:d=GE#Le-Z<H\Q8,Of7?2d>D6ac5Hc/g@O?4X-Z1[7,1A.cU#:7WG&Q\G5
IH8_PYg9ed8#A:Z>GELK6?56g)W#1Z_#>bfD/SEIOPI+HXX48&B\[W(2TZ0ga>dR
^Jg;f#G&GI8#cDB(G:F/35\2BKNe&IZ8<;YbVN^AH32KGfT\OU6DITdB@[SE8IU-
(G0+.DDeI4Y9Be@:g,DIe41FP[[1),#H:,:&Va<NWdD34T,L].AK4_)aD+e/Q<;<
-LU4fb_ef6J.b[#aT^8Y-EEXb2+I4F[dK7^F2DH+1.]4;gdKIM:&:b9N;[S8&:G?
Y5@C?S/P759AI1M7YXLdHfI</6IJJS6M#XG.cb,C4Ef:BYOM8GRe//:8O=CZ)fBf
+4FO9+HRGXNDG@1\FZ=).O^]8U0YZJ=?-bGBa64I:72P7D(=f=DB9d)2][@+_\FG
EK^acXDOZdM2Z]KbS\/A]^HS-,JB3N36N.3(bcfEO^25XDL^&cFD>=K;-bMH=bV#
3g^/[F]N29FD]U>+O7Ng\(g]6+gH>@\0^Gg?V,c_1V^.2ON\(2FfO].ZI;D@E4<7
LFQ>\BQ./I)K4[M8aM@SRLRF.8UeHMdX&Z<]N<\f+(3-A8D4d^MbPURg&@/7_#-C
gG=;LBPI4dZY6/G0#,0@g^;^d?Q&\0+;MVY^HTf0N2e@-N1ZBFgf6=WVe_VEAg]W
S<+KW+?:a5SM@6N1fU4-RU2.LAKM+>.Ig8PT<IY48+OC0<B;@>((L]8B11HMP?]J
+I,_/[0SZBb[/7&TK6gdCAb.\?LVe]Y[Ob+dc)+dX0_Mb2SL0g>D^P;F]5U^JVbO
DLW^+a/QYcFN[?^FM0[<EE5A,S\R9Yf-M9Jd1\KQe?1^I-BDDG71JfVJaS8CXO?7
aaK(J^d/Ufa16GRRe/TKZaS+PG9&[]?/@Hf1NC4]4_=@0#(/KGSG2=N]+\TeZ:B6
5SW4BKAEDeB7/E_^5-Y<>dO\c0.<[@R2&PKU;RH4eA^&832Ge@P:/bL<(,RaNG)=
W/3ca0<a+#a@.Mc)+U]^F8BY__#KTRFK&^(2STN1ZAQ&765.Oc(d7Ea-c:KO,]A-
&6^B;REN@<AU[N1XBV,+:V7A5MG44OI\fbU9&(G7S+C>TM/cE1;<e#@<d[,X-P1^
WK)g]UOL:bC9C/W^Z61>\OTN9AYD):aY5<_-bf,b#.,=>BUc?1.I;]QASCd;Q82B
FHJPG)(e=#fRR5@YI)0O4YMR68JLeT^3Yc3&.;YaQ6c-3FAg3>^S#IV3394\@a)/
V0]&]bL=,U3NNT4&eH^&/Y7@eCX12b>_&8GAQW&VRVV0;VZID(gT.&O=aSHeD9TK
@c&SM=N7BKX@2QOLGAfDY7#>FfW(]._2/<HUKZ(84H[=/N,3=LNUe1KX.DaAbYF(
</:D[BW7U:>FeH;g8;-b._aFENdQXU^RFY=/F[0J+D:P=T-6_Cf6V@<9PN<2@Na]
]bU/<GSG2cJ;A56WJ;(9CATf/).36e>EO1&)BMQV-/H:XcNPgB>J8^Nf2\B^H+(W
E<2T_##2A_T70e--ZQ9=E?:8G8EKVEf(fDLBNV7AQIc\6EV4Nf<7L7JFO&L\0>-a
6\aF.cE2BX_@::9,TU.S#3RA_S+1TPH+UVQ&g9Y3B0AJN-H+1;IJ#1/d+.&b^_-D
8@_3\]Z1REO[E0?/PeM4&\#&)aFVgbW4TB2)MMMcc244)+VB>:?3HYbcW5f]I]/?
]3fGZ\OZ1@1KeYQ,9S3S>-EeO]_;FD=_aD+?4M1SD\VBS1,6@237V.VgEaS8Se-e
J[ME&B9(A;G4\GOZ3X2\8[c,5&@@LY<]&LK.JI)dLI<DXUX\?)J<EA,UJG(6KY,,
X?_bH+L9AAY#U?M7P\fXTHC[K,H(d^?-CDEabJ:4]^WKf6eHZfMFe8T^eDF-d0Y:
77#-&YP&@HF(B^d&3C>^&.#AEW-LIIE.RRe#KU+SH?EW[G(^\C3E8.(&D@19E2aZ
FT(f)?>d<5@J23>\/14TT8e[/=#9XZD<5:SMO+.Wf1XP[&^28/aeF=5W354C+0=]
^VeD^G<.9E;&,0=Z>L(R7#?T=K7LK,>UO+35a6McKDMDaF07DLKCGQ&2ZXC:a+<3
;g.eaS]3cc_e.#:79,_C,V@1.NgUAgV-U/7[b6]&Qa<e:HdNWJ]+GB3?^)6H>I3P
L4KZA+VY7Fd\EW<]\3/UEWf4\,43M+7ZD5KE(SG]Y9VL&&,-d_>ZE,(DeSVSJ<F(
2?^f.;0S/8&[2JO9<[),[:=FL<?2_S-,\E41OKU0,]N@<<YW)O>_)c[@.B<SX/#R
3Y;;(;4W^#C6aU66Y:[\9E<0=&;^/#=<dA)O;X0,W050=]L+A+61X)+1)O8N//)^
Db[Q(O6Uf=I8I9702NNX0]GW,bRb[0@A>ZbG#/B+O9B)COW,,b<P7;FOACgE;?K]
;LbPL.P9+#Z[Q621(GJ0A+;0>V_M+331/5-1;-ER78bRf>:6VWFFEM<=C-#d1ZP2
PLBHQXb&6TfLIMOcS47SND/I,I8g-HN:GaUb2>->QW_O0N[#A0V5aC,WDD[/3gYW
\1bc,&e1e-17PX_&;3I(eaK3g)JDgL=+A0E>OA20[eG+EVFQ:QLNTDU#P(SJTLKb
=5@9O(X@#]3^2N_MAI(&1R.7eG)D6I>?^]OO/_(V,dS>/eONW:<5BF]KFVY#?OdM
4V=V+QGC]OE;C4-V4W@7G9W0PaA@f)CZM.]4-G4);,9GVMeQI)EIR/2\HQ;2A2R/
#QWXP9D1e=5eNF_2,Y3\YG^ECMdJ@T?NND1VLP&c6E8I;:C4F@TFH.I=])PA3PKY
Y;DaI3GTf\JA/a3DRC_3fG(?30KN)\MbQH/#+>QG<6ID18BdJ:MN#=SOAOC/=PJL
6TU9G:SX.]G^6fJ#X5@9T=FTI&a_cH(b:GME5BVC\Qd?U^31;PISRY&)LE2f)-,6
LFA4;AE]YcK)>IdN+.V1#3:e+cX,Gf+6KW_8XY#ZHa:AT/E;HDVf/M25A_?4-bF\
L\<9;5eF8FA_5c0KW),\<L.,f4SUCef7(U2@V[,&P2/F_\cE-)-6+(1[XQ>V_GLX
-9gB:N)A[<SI]_24ME3I+:g(NS8^WH]ML(I[]fC:)6,U=)I)/(8QL>b.SMNMA7A^
RKcg-O1OQZg?#-XP2Zc\Y7f_g+VM,.EK^,>dI,32G=fN)a5dLEV\34@G^.@1FL26
WXLC,RN7W[g->_NQfF;-4FAe0RaV9)LTaH\#9VYV(2/)>B1Z@K=D8Z:ECUU?6\GG
V8,\(JdWFbcULgQgKI@OHRD8PE_UEC-<.fEf0FBW_P:VQT]f70C(\[?2dL7FGUN1
6e?cgBD[(LX&cWK?T:YNW&f?@NGf3)/6.EFWC@QC@>B03_#O5FBgWV@KGX8.8HEI
RM]HXOG)Q?+bHL<8RF&(+G79Ed)8ZCR-^D/-E4)&Q\B)]KO^_X6Bd:Zdd8_^&ZMH
72-C)F4(Y#OI.FaLJ/3,DMb-4daaR;eHcEC9)SbeOBSd8^7]>Z;B\c^G4.3O<2+L
E2F<<a[_-1?J:M?Y0\82WS[55HK&6eGdL(<?H7G_-C#LLE(b<5Ea7D5N>OQL+b#W
/(I=)]JM#D.,B[-TJ#TE^/6#IRGKPD/CNR/(<EMSC?&4[7=ZVT<L6,^T]4P)/e#P
_A(JHWe\00><&L])\@J_\H/QP(&:?Y])P]H]5e:2)/PR]+3YP;8=4;f9T_).MaRF
/26#(<I4M3+I=HGMaITF[2dL<2+RGL?DPcb-L;83eWa,4\JYMD.Ae8Df917D50Je
dMO#JZSJY2E8/TV>V:Hd1+6aQIS?bgK)O]5F2eBT6e:f^(1IeGB/V+;Cg<<Y7748
M>L/GK@VVHWe)RK:(J[&\+_WLL.1Gcf11DdRS(F>--O>cSf8ZK6R>J_Q7Wg8NDa/
3I2C;H[AK#7AaJZ^&HM=8IBd)Z@H6f)6G5@HL]?1Id07O.2)GKd9/8c.UIgf3)#.
fXJb-UVY(2LWO7Y@Q(EV80.eW//;Fd^3.<4:K#GMZ_4:,bOCDfa._B3.9A\KVa9L
S:_?Be]R3IM]\RV#_]UQ/eE7RFEg;6^/R&0KJWOC1N4UJC]P9U,Y\UdK1e]787P)
(HM8ZMBQ3c?P+GVAF@3GddPC\JT=F/1F=M[=N(1JFe+::Nc27]Z6c<TZ/F8P#5:F
5G2#B>=VNF/2WOUJNQR6,TJ=-2[b18H9LM+6O#+[^F4\Z[41^SB6AB=]LWU42)U(
[SS2XP.I=B?Z@0J,fJZSRRg)Lc;=MMf#XG-W6R+24GNORVE/PbC:5cU+1+S4/XcR
7^Q/&9UX4SN(@6ZE>_Q#.I,8ZdR=&(G7CEWceNC[]7+4LV=@^IV-W3:7-g5Mg(NF
R?cb3WQK0+P5[(80@fcdG6bNL-N>K&6H8O/Z;+L.OZM-.K&XB\K/)SESR:fG-.T?
_-,]9b)2?CE7@@gDAR[V?235O(7_]GJMUK;7T?;LZ]ESN8,/^+b96MO8b-CHgPUf
E;@9O[X\9A11O/fe<Q3V(29NA&,TZ-g&<S:])]E0DPTEe\[>[>DSA0Q:6Gd+T#[3
:gW1AX6e01H#\aKV#T1,P;&=f@NTGfC=0XYc/Se2Z013CK;aB=1&QadSW[?R;TT.
7;+Jc]PRIN8BC@f2113ZWFUACfUBT2JPU9_62G7A)db<]9&1PB,D=g=J=<X8eJMY
:RE+NWIf&f<f>V2T7JG@;G.IP[+3=?3BQaR4?U/bAE;^30+SNSggF//RZ\8#B\M(
=]Q0_;dgP(<C[8/HBB#ZC@HLOQVW-N;M7+DXaUZ#0C=2:49,a2BPG>-:#:XD=Cg_
.CCe4QU75LE(CD_S\\^K]\0fe+&1L)0H4U0G>1<983>@+TC\];>T>b5OAPJbNb?1
&FG4=_-V\5CdOeO<VK1R+.YG5+;N3e\OJdH_OXJF(+E=&Y-I6GUB5,EE[R>35O=G
]\UQfdEJ1(2@3>70>PaFHSbbT_e:8eIPHgI\ZVN431IT6AFS/d-@AP,2-\I^758>
NUWPS3aVMO;,XC&CSYaC99^D_7cP]Y&-CC@,TPVC3d]LPa03T:+<J7@4@VeY:U<1
\;F:2.B5VDY:a:.@fQKOH_ET:BPO.R6V<](@e/O598(7S[aQ7FHVCCa>222]3=)]
:,UBTQWF]UTAE(]@8Sg+.BMGf7W#6^cf\=5g1A]EAW[M?DIU[,+HJ\gXYS&S8gH2
U6G0JFDHHf&O<f[#fCYXd2HY-JX0RZb-K]@]S8[cAZ[7NV8VSV]+1ecg:O1,LFO0
9:,Td@H\C]TAARc.7N@8NNQbVb6FPbK</O@a\Ef3c,c?],?W1Z,SE?+G+L/#NLY;
:\\G(O.._H,S0M.e\;FUMU-RcI8cP;@[BLBJ)9M-MA(1QPcgX7-A8cAS18[NE9+-
aUGJ.V0g0DJ3&6T;>aF<VASI\7AXQbNZ5aFfEBJL3Bd)1gH:PUc-U[K6?G_2D\Dd
=+.g)e+V=dD>80dL#.KFc5K8SSX.<Bf^cU+C.U4+;<b6]3X8g\KdJ7a5MXaZ+C8[
W09&ZK8&N+SaM8K52_4^]7,.Q9=)-FL_C1KIee)X3IabaGf6K6]INT](4aBUa)Pc
:Z9XL@5:C>\EW(b7HQ8#TDeV(O3b#U5E:g)g[a)^^YS<[gMV,.9CVQ]VAN#:D-#[
Z-6,E4-MVg7ENY.N^<fDL)YS4NLEP)J@6F:KAbGX7gf3;?7>=8?7XL7U541>Eb52
e0BZ8W[g+EOO3f\7XJ4(CgcISfb+&Y+TSDJEZJaH7ILd6W&=_e71J\Q7IG42]??X
Y(DTIPfc#+8,RSROdL;O^;IR0\\D=dNNP345PfYK-&+W#7g3#F_]R(]Q@(45bJ4S
6<Y^a/)S_X)[UZ&@\/34B^UHL:K6,JD]87=>2Tb#A,eOG14B<a<)7G;Jd8[9M4e3
#4N5I#GNe3?51[+3ZZ+)Qc?6]OG<Y0\de?Y^@P5Za_XFdTXVeZT=Nb&1If1X=3?E
3f?8?9E5;)XNIFS0ND\+.e;c9gQL__f[P-7HU7]f8fJaM\5J9Uf^#a6a>&>Z&]9<
U?EKM<6f(.)O1gZF-89,g\X4PYCM[._[2GB@U#3>eL(@9e,D822&254WBc[4Z?HN
-4@6Y3>U:ZgZ]30&=.+]()^ObC>?+#./@^-XB?73&fVM,:/SZ)DT=6U0,7-^IMgA
;A0&:#6bH\GMW5.-]R;N+,4?4VGc:4-Y<#JR\DacKX&QN+Ye+Nf7D/G4TT[K1fAW
2Pg1_Z3IAf,e)-Te/U1+O&,CKLMf]He<.8S5_XMfUKd)T9ZHU^XEf>,\c(I5g-7@
P]d.;S)N7NY.78c#9R:1c\17bG:/0)([J&&&Qb5;b=SdZ7CdgLc1KY.]:/M102.,
YKgSKU8fKQ__JOKM2,>X&W#b\6AB;//ML]8e?MB^aS>UO/?I?SLTSc9^MR4;Ve)d
MGgM.^f<[#RK_3ge58F@#bXFFZY^6<P-F)J6>#-,YZC40eQPP30LE:>))+?GXX:G
S/Q9NLOU2Y;3W5EE;I/,,2M+OBZYfWVfT9]C.4)]dRa(15#J;,fd]7K[\]?E5)7A
WHY&+:U9IZaSRPUYR[O\^dJ_fX9I-[PZPDU;68\bWA2,V6.E4H12KV+=_W@)XJ+D
1ed;H.U:Wb7JX+U?Nc&bH:@XgJNDW(0>fVZZHg+DJa.9_W==)#Y?Y--C\ALe4E,2
7?;]Q+^601a2+5GR]J0fc?)f(EI@NcGP-CH5NFQU@CXa-//Qd?A[#SR1.L)8;0af
e/G@GHE;@9M0W1a0XGGOY-KeZ5/J)YCA7@ZFH79\c)A6-A1DBd&/bV,#VR<?Q5CD
<<)Z&,1Z0:B3=BMDOc=+4^T-gE,+XT87FHF/@;8NDJVLY#L,KSZMI6VNQ@F;RK.a
6>QH@XW+VMP(6DU#V3_UQRZD0>dF5=N8Q>8W0Rd;fJ)Y<>cC.S]d1:QcE.Y,EE=(
BRTEZTDIa-&HdFQAHF-b.#M3&aJ&KS/=Kda:#7<N9BBN=gSPT@=EFFAG]U8/b[MH
3-&YRS;I84.@R-9>NBb:YY6)EUa+T^KHg5]46WO]O;EVGg/U3e(U;1;>=JIe5=0/
]GYA#\D&<,P/0.Z0\f8MG2\0/JQ?:29)^#U,JL)PW+\A6C++A(Q@T17CU#K)X9Z6
,-Hd2WVbY(af9EFBN&Q[C1g,]CNT_D1W:6O=)B<8OBCMV7K54TPB6PXQeU:@)8Y,
>X4]]1c2U&4D#\^/1P7+@b@AJf-B?RL+-(;Z_UJg4NC1XB&b^8aO,gQe7Z5#Q(1V
JGJ+CBMA6M1@6e\DKc)X8,=EXWS:+<D6M>c+b_?TDS/0Z]+05#3GERd/0dE>,9Md
J2VLP\(060B=UBO@>YI)5&)V_f=:@UI;D2Xf):8S2R2=Y:0Q#7TAZ=&SX/57]U^E
6V)Y,H7+Id3_(X_KG81OA<EY^:2/R4P8dC_QUZa5[G&;RI1=P-X\C6<.BV1F2410
^URYa>D/<4a<LM<)_2R=>7^H(NQM/gF1dE_<XSZ4@fEK:>1QRXdF8BP2QIF:WD^5
6^UTUF&PQA:fB&?7GA<[KO<+EXGP^JePb0eK;U6P\YSH>5:NYI(VQ1./f^EH32fO
01b_fA>>)EbdQecQ6ZJAS6&[RB2/M8/TE:JXFV-U_f[,a1+D^Kbc??1W2?[d?54X
OIVP.aIXWZR[381SW4=?TISd0N?\)2]#BNNJce9WS=)>R3:Z[b#+b=A>f-fJDb-3
#NSX0E5_Ic(_O<T;F1Ga,7VBZ7&S\T,EQY9V:0&:&VE4A8-^T?,G3&dYA4U;BCaJ
g]fVD)g1UdQHV#Ie^U;SXFVZUO)fBC_+IMaA+DTgf8cN)GJL1aTC-RW,Ka<,N.Z/
B7WP=gJ7KG6Cf2XaR\H50cMU\7H3]dAQ^DAJ15JB(_,A@?fa6afVGIPM&/NcANF>
NAIWEfa+<UOIYdJKQG[@-IW65)+8aE&Z7M/BV@U[]c^;62M5&ZE?3T?_UM&=VLJb
E?6,bYFOGJF2Ng(B6,MC:CS>Q2f(Xbd(_<?4bCF4SgYTCUR8_;LQJP_4Nad9U&^V
S/fFM]2>c;K:=cP45_[PJ6)5EFNJ[CRX>1=f/D=FRQa&2[=HK:Z5Y@2MK?M8#@-B
53<eB?)84g&=BCPR-YQD4LOBHITF64EMH3<><H/VFWE1Vb^A#/a0gdQSdOV_YFfS
OQVRE<I/D4SIFZg,,6@A5F/LQH>0b6V>aF;KB3K922P-2H=?P0A93)Nd>\<fFK^(
/^)^^=21@FHXW1c&<KUY5-/L4$
`endprotected


`endif // GUARD_SVT_CHI_STATUS_SV
