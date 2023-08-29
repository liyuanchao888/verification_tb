//--------------------------------------------------------------------------
// COPYRIGHT (C) 2010 - 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_APB_CONFIGURATION_SV
`define GUARD_SVT_APB_CONFIGURATION_SV

`include "svt_apb_defines.svi"

`protected
cgLR&I\)FT+D/dV<9a4?KMQca1M>_L;H.5:+-WUG.RDag>gK19C@7)WY_:Pe&R5M
1B+F.^S]#\;M.NB;_,\=bJdO^f>_c=U-QF#1IJ1NERe(XF4K0<BQWNCO^bbT,-]c
@4fG3bBE]U7CA&D..=E_4@aN1Gd;GJFKfa[:@?:C?O?&B7&Q?><G16/@K+9#R\R^
3S,A<XX\<P3VTP,K8/;\CT]DLX>3\J<YN[B7;]JG?CTCWQfCf9NL7NVOX-;eg=_Q
>?<225ALG9]#MG-E/XA8#OL]&RSOZBa1)=^e34cU6GQ#7c\ce3/<LHWF&9L)59_P
<.5C9eV?HEWWCgBJ42@6-^W4^e-J>?]>I57NG/ReD]CMfc#WMK),Q+?aLO?:WdML
Y]&-DM]4Y5K_WcT[&J)U^d0P^]&R2@+@d;e?:=EIA>IM45O>bS<c1YI7QC#Mb[fg
34JIH775IC;S)#1E=J7_=;)d,PdKGMf-YO;cVU#<]E0bSAW:b54?>-<@,8,,&,b4
:OZ>Z>(1b/.LbR[?;]2R56[)_3)(LMB@Mf84+U8RA.WO[7cW<&XP>aYT:f3H:GW,
/,Y/cH-QOV?:#;J1F:=O4VF;/a_/+UXW88@.ONK,/LGC.F@MMW\H9g]S&B^B-eg>
T1&gd9Y]NA2,[a31\HI&]1]U3Y=[YW=f_IQd49Na]0=S#\-+cQ77A-,ZXNYI5\ZW
=,B7)fJ>(dE39[H4<1Kb@FNYE>B[1\^K,2SJb<+MHLb5@@YLM#OUD.Q-(CE[-KBf
UgA#ZYLBYX=[)cIN.K&[6S18b8WZ,T2e_IYBWZK.NIDQeFJUOUZ\+.F664_FfRXe
c8Xc9>b_V9C#LR#.&aV6,SX/AFCSc/a.2__?^eQGLcW--H_//N&:XJ0?8QA4>?B_
9EN_MDHaRJ&#.$
`endprotected

/**
 * This class serves as the base class for APB configuration objects.  Properties that
 * are common to system configuration and slave configuration such as #is_active are
 * present in this class. Some of the important information provided by port
 * configuration class is:
 *   - Active/Passive mode of the slave component 
 *   - Enable/disable protocol checks 
 *   - Enable/disable coverage 
 *   .
 */
class svt_apb_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

   // ****************************************************************************
   // Public Data
   // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Specifies if the group is an active or passive component. Allowed values are:
   * - `SVT_AXI_ACTIVE: Configures component in active mode. Enables driver, monitor and
   * generator in the the subenv or group. 
   * - `SVT_AXI_PASSIVE: Configures component in passive mode. Enables only the monitor
   * in the agent.
   * .
   * <b>type:</b> Static
   */
`else
  /** Specifies if the agent is an active or passive component. Allowed values are:
   * - `SVT_AXI_ACTIVE: Configures component in active mode. Enables driver, monitor and
   * sequencer in the the agent. 
   * - `SVT_AXI_PASSIVE: Configures component in passive mode. Enables only the monitor
   * in the agent.
   * .
   * <b>type:</b> Static
   */
`endif
  bit is_active = 1;

  /** 
   * A unique ID assigned to master/slave port corresponding to this 
   * configuration. This ID must be unique across all AMBA components
   * instantiated in the testbench.  This is currently applicable only when the AMBA
   * system monitor is used and is configured using a configuration plain text
   * file (as opposed to a SystemVerilog code that sets the configuration). 
   */
  int amba_system_port_id = -1;

  /** 
    * Specifies whether output signals from master/slave IFs should be
    * initialized to 0 asynchronously at 0 simulation time. 
    * - 1: Intializes output signals from master/slave IFs to 0 
    *      asynchronously at 0 simulation time.
    * - 0: Initializes output signals from master/slave IFs to 0
    *      synchronously at 0 simulation time.
    * .
    * Configuration type: Static <br>
    * Default value: 0 <br>
    */ 
  bit initialize_output_signals_at_start = 1'b0;

  /**
   * Enumerated type to specify idle state of signals. 
   */
  typedef enum {
    INACTIVE_LOW_VAL  = `SVT_APB_INACTIVE_LOW_VAL,  /**< Signal is driven to 0. For multi-bit signals each bit is driven to 0. */ 
    INACTIVE_HIGH_VAL = `SVT_APB_INACTIVE_HIGH_VAL, /**< Signal is driven to 1. For multi-bit signals each bit is driven to 1. */
    INACTIVE_X_VAL    = `SVT_APB_INACTIVE_X_VAL,    /**< Signal is driven to X. For multi-bit signals each bit is driven to X. */
    INACTIVE_Z_VAL    = `SVT_APB_INACTIVE_Z_VAL,    /**< Signal is driven to Z. For multi-bit signals each bit is driven to Z. */
    INACTIVE_PREV_VAL = `SVT_APB_INACTIVE_PREV_VAL  /**< Signal is driven to a previous value. */
  } idle_val_enum;

  /**
   * @groupname apb_signal_idle_value
   * Used by the APB master, slave models. This configuration parameter controls the
   * values during the IDLE period,data signals will take this value. 
   */
 idle_val_enum data_idle_value = idle_val_enum'(`SVT_APB_DEFAULT_DATA_IDLE_VALUE); 

  /**
   * Enables protocol checking. In a disabled state, no protocol
   * violation messages (error or warning) are issued.
   * <b>type:</b> Dynamic 
   */
  bit protocol_checks_enable = 1;

  /**
   * Enables coverage for protocol checking. In a disabled state, no protocol
   * checks coverage is generated.
   * <b>type:</b> Dynamic 
   */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit protocol_checks_coverage_enable = 1;
  `else
  bit protocol_checks_coverage_enable = 0;
  `endif

  /**
   * Enables coverage.
   * Toggle Coverage gives us information on whether a bit
   * toggled from 0 to 1 and back from 1 to 0. This does not
   * indicate that every value of a multi-bit vector was seen, but
   * measures if individual bits of a multi-bit vector toggled.
   * This coverage gives information on whether a system is connected
   * properly or not.
   * <b>type:</b> Dynamic 
   */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit toggle_coverage_enable = 1;
  `else
  bit toggle_coverage_enable = 0;
  `endif

  /**
   * Enables state coverage of signals.
   * State Coverage covers all possible states of a signal.
   * <b>type:</b> Dynamic 
   */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit state_coverage_enable = 1;
  `else
  bit state_coverage_enable = 0;
  `endif

  /** @cond PRIVATE */
  /**
   * Enables meta coverage of signals.
   * This covers second-order coverage data such as valid-ready
   * delays.
   * <br>
   * This parameter is not supported currently. The meta coverage is enabled
   * using port configuration parameter #transaction_coverage_enable.
   * <b>type:</b> Dynamic 
   */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit meta_coverage_enable = 1;
  `else
  bit meta_coverage_enable = 0;
  `endif
  /** @endcond */

  /**
   * Enables transaction level coverage. This parameter also enables delay
   * coverage. Delay coverage is coverage on wait states.
   * <b>type:</b> Dynamic 
   */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit transaction_coverage_enable = 1;
  `else
  bit transaction_coverage_enable = 0;
  `endif
  
 /** Enables coverage group for cross coverage between transaction type and
   * address.
   * <b>type:</b> Static
   */
  bit trans_cross_xact_type_address_enable = 1;

  /** Enables coverage group for cross coverage between WRITE transaction type
   * and PSTRB.
   * <b>type:</b> Static
   */
  bit trans_cross_write_pstrb_enable = 1;

  /** Enables coverage group for default low value of PSLVERR signal and valid
   * transitions of PSLVERR signal i.e only goes high when PREADY and PENABLE
   * are 1 
   * <b>type:</b> Static
   */
  bit trans_pslverr_signal_transition_enable = 1;

  /** Enables coverage group for cross coverage between transaction type and
   * PPROT.
   * <b>type:</b> Static
   */
  bit trans_cross_xact_type_pprot_enable = 1;

  /** Enables coverage group for cross coverage between transaction type and
   * number of wait states.
   * <b>type:</b> Static
   */
  bit trans_cross_xact_type_wait_enable = 1;

  /** Enables coverage group for cross coverage between transaction type and
   * PSLVERR.
   * <b>type:</b> Static
   */
  bit trans_cross_xact_type_pslverr_enable = 1;

  /**
    * Enables APB transaction coverage group for APB master_to_slave_path_access
    * <b>type:</b> Static 
    */
  bit trans_cross_master_to_slave_path_access_cov_enable = 0;

   /** Enables coverage group for coverage of a sequence of four transactions
   * <b>type:</b> Static
   */
  bit trans_four_state_rd_wr_sequence_cov_enable = 1;
  
  /** Enables coverage group for coverage of a ERR response for a sequence of four transactions
   * <b>type:</b> Static
   */
  bit trans_four_state_err_resp_sequence_cov_enable = 1;
  
  /** Enables coverage group for coverage of if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   *  when pdata_width is 16bit
   * <b>type:</b> Static
   */
  bit trans_pstrb_addr_aligned_unaligned16_cov_enable = 1;

  /** Enables coverage group for coverage of if the RD/WR transfer is Aligned/Unaligned based on address and pstrb  
   *  when pdata_width is 32bit
   * <b>type:</b> Static
   */
  bit trans_pstrb_addr_aligned_unaligned32_cov_enable = 1;

  /** Enables coverage group for coverage of if the RD/WR transfer is Aligned/Unaligned based on address and pstrb 
   *  when pdata_width is 64bit 
   * <b>type:</b> Static
   */
  bit trans_pstrb_addr_aligned_unaligned64_cov_enable = 1;

  /** @cond PRIVATE */
  /**
   * Determines if data reporting is enabled.  
   * <b>type:</b> Dynamic 
   */
  bit report_enable = 0;

  /**
   * Determines if data tracing is enabled.  
   * <b>type:</b> Dynamic 
   */
  bit trace_enable = 0;
  /** @endcond */

  /** 
    * Determines if XML generation is enabled. XML file is used by Protocol Analyzer.
    * <b>type:</b> Static
    */
  bit enable_xml_gen = 0;

  /**
   * Determines in which format the file should write the transaction data.
   * The enum value svt_xml_writer::XML indicates XML format, 
   * svt_xml_writer::FSDB indicates FSDB format and 
   * svt_xml_writer::BOTH indicates both XML and FSDB formats.
   */
  svt_xml_writer::format_type_enum pa_format_type ;

  /** Enables coverage group apb state after reset deasserted.
   * <b>type:</b> Static
   */
  bit trans_apb_state_after_reset_deasserted_enable = 1;

  /** Enables coverage for  covergroup trans_apb_states_covered.
   * <b>type:</b> Static
   */
  bit trans_apb_states_covered_enable = 1;

  /** Enables coverage group x on prdata when pslverr=1.
   * <b>type:</b> Static
   */
  bit trans_read_x_on_prdata_when_pslverr_enable = 1;
  
 /** Enables control_puser sideband signal in APB interface 
  */
  bit control_puser_enable = 0;

 /** Defines the width of control_puser sideband signal in APB interface.
  * Default value of SVT_APB_MAX_CONTROL_PUSER_WIDTH is 5.
  * width is user can configure the width using SVT_APB_MAX_CONTROL_PUSER_WIDTH macro
  */
  int control_puser_width  = `SVT_APB_MAX_CONTROL_PUSER_WIDTH;

  /**
    * Address map that maps global address to a local address at destination
    * Typically applicable to slave components
    * Applicable only if svt_apb_system_configuration::enable_complex_memory_map is set
    */
  svt_amba_addr_mapper dest_addr_mappers[];

  /**
    * Address map that maps a local address to a global address at a source
    * Typically applicable to master components. However, it can applicable to
    * a slave component if that is connected downstream through another interconnect/bridge to
    * components which are further downstream. Applicable only if
    * svt_apb_system_configuration::enable_complex_memory_map is set in the
    * configuration
    */
  svt_amba_addr_mapper source_addr_mappers[];

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  constraint valid_ranges {
  }

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_configuration)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_configuration");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_configuration)
    `svt_field_int(is_active, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(initialize_output_signals_at_start, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(amba_system_port_id, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_DEC)
    `svt_field_int(protocol_checks_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(protocol_checks_coverage_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(toggle_coverage_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(state_coverage_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(meta_coverage_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(transaction_coverage_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_xact_type_address_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_write_pstrb_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_pslverr_signal_transition_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_xact_type_pprot_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_xact_type_wait_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_xact_type_pslverr_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_cross_master_to_slave_path_access_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_four_state_rd_wr_sequence_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_four_state_err_resp_sequence_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_pstrb_addr_aligned_unaligned16_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_pstrb_addr_aligned_unaligned32_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_pstrb_addr_aligned_unaligned64_cov_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(report_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trace_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(enable_xml_gen, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(control_puser_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(control_puser_width, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_apb_state_after_reset_deasserted_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_apb_states_covered_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_int(trans_read_x_on_prdata_when_pslverr_enable, `SVT_ALL_ON|`SVT_NOCOPY|`SVT_BIN)
    `svt_field_array_object(dest_addr_mappers,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(source_addr_mappers,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_enum(idle_val_enum, data_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
  `svt_data_member_end(svt_apb_configuration)


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

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

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
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  // ---------------------------------------------------------------------------
  /** Need to enable trace_enable, report_enable, and enable_xml_gen */
  extern virtual function svt_pattern allocate_debug_feature_pattern();

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_configuration)
  `vmm_class_factory(svt_apb_configuration)
`endif
endclass


`protected
bc3#D0]E3.SU=F\CKeE(U[5dB\XWZ_WGbP).BNS;34\+dBXZ?DdU3))CKbf#_bY.
+_Z,Zb5,Y^9OI;#Re=^8QJ->Zc.A>LgME<];DJX+(3_d0[Y)@gVR&2]D[7-T/^L@
X]Y#.QU3Ga,]JG^(>0f]VNF^;bS^8OAfU<\LNNSI9d7BN1S&_T_Z.(\ZJG]&<OIc
^.2SCb2;OUAg<_)@c+c2dH0:N/KZYC)(>J7g&A^dJEe>IJR^.#BSO@J=UbAV]D?c
8\M,a^+a0_5CSXK1[_?fU2N4HAa1N4BLCaJ@TE^D7=;:_=,eXG,S6:61;K1#:3E&
.aa3;[3;8@WA)T[gR@aQYN^SJW7BFYP1AP?I1-a43P-XcBbUPU&2EWJKaS,(+CQ+
>^/HL3-SZZNc11c]a>ObR43I0V4BEc8;=_QTV0[&DCS?YG3NdXfWX<Jbb8OBe-4L
:T#GZ/_KIH6f@DY#IdHKVW(6WDQdeFG084T&_(_SbFKX4\=NAY.^4;4H1V<#5MZa
b)6_NQ2V1gDPH8C/.[:-PO0/aWV)+GU9NIHBP:3[fX[fGa/)K/W>0=CQ:5Wcf/8A
GWO.=?0^U)QdV=O-,/ITC1>Q6SZ]1M_IB#]KXf#<T].4]8^c]Zd6e@[DC;.1=9Bg
ZE;@77DJ)O^EKM),_86[+EA.FV1gKA]MT5aW5VVF(4-b6EgSS;G_afF.5FIZ@g\3
:6<Q6/TXQ/@G)ZMfR]^\;M8YWL_)FF7dT0W>(]U,e#[C<;,.;FB_L83S=c2#/,L4
8-UMcPOfOVb2fZP0/=H<5;:C?&1J(#H\(TV4#]8a^Q_=8->Bd-X+8#,APc(7_[f>
@[62UL@I0=81>8=V9H]D?eJC.NI?bU=,KP8ETCU2VOFf7KT&KZ0[a&P(7^)bRFGU
SFZPcJU005&PMK](=^bO+48N6VUVDR;)Hb-WW29ZI9#S)JfFUJO&eF:P<E#NGdLT
F=D&gg=LWL8B]9QJdHE7=Pc6<XG#S14H>I>KKUX1a).7=aX9G@[CK+Y>Od.)Kc@.
D:8Cf=5YNZ0J<XMS771aT8L\#..ce)9?-W.VaeYJ-&<;?G9TB\I_F-KaM=>UY(>=
fN@HQ[UX2SK<MJ_I[OF^Q:588GU&85TYdd@5NJOJNacNc1//1UG][BV=+&N-(U&H
DgZ474RD=@bcS=M)U/ET[P@JQA2E\C9L<2^J^73&2eYEY4+7/Tb.NO)B^[^<]I;;
B[[U,.@S_(WHNe_;Q@:KL(--UK_U+JfHEYHI4KJ@>9.3Q_.CcJbTKe:5N#/+=;Qc
fe4:1?V#KBc1:UYB5cSZ+HZX+9d&Q.AK&ZZfa;34K4:0Mf<T=?=\SdOZ_=X_;VFN
^3>MWdRC7?K:E7-VOZb02P\5A[X1\Z6)YO63J+V?:GS4ARe8JNIX8I(OPS@g<V5?
?:NG&9FJU?U11=313V+FG\.3c[JD3@DX8]G-[7B7)U#+2AL_6W5K0W?aPJ8?4fgd
?\L&X//W?=OX;XD\FU@g0@P<,;Z7KM&8;#)OKHSR2G^-bG+Me@)9?<g/5[GUC)?F
?[\_T.>-MH&_O6-Y(8f[HgAK^BPPb4RBcfX)Dg1L]8bW2=:+-WXI62/?.@[38gN2
3?e6Yd(-Q2&ZfXZ5LQ[6<A,OM@>RSWK>ZDN)+@UF2+bFDQDA(;Xg90]7S_58#(9S
#9cX,M(A,,H^&X;G90&W-8^5+bgCNRQXB+DJ7;>.Vg,^,MV;1\Q\c?Xf:L<fGe&D
T4eV66[-#DcH54<gM31VdgHfB4M6.H&/S^8YI4e)8S#,[RFV7f0VJ&S3S9E,JMRR
MB7=,g;RKB04?J40-_C26GPD]9IX\@@KUeX0cGLVRUPdJc3T]FRH2gYJRBXZJ6(#
VO1<f&=&e[X>\61E/MOQ)G&-9B23P&[-=#b,f@XGb==PT@V@4IdC@:@=g@,E9@44
0.V02/I9OX-D0DF9V6XP(^P1OY#1-^d]d3;->B[NA+)T++L4NeZQMQ7+63+4R.c;
N-0(cK(<.EM=3&Wd?cWIU0ef.SMgS@2XW-CeFCYVBaU]]41X_B2?WP91>A(2d,db
VJUTE62R9)Afb??0D5L/@(,0Y4[c(0<0M&FG]IAP.<U(O>;5BNUP@5DX3(I1)<U-
M+#g.>Yg-^+J]BZ].(:N/D?CQAGF=D+S7A.Zd\XQ5d@@KRTAeV9K14/W@VZ24N5;
ZVW&/^:5UID]10.I4OQD[Rf8E)UDH^K:<3f^-A8G>8P+f9P[-U[9A685]f@GcMW[
9G/cCY1S>6>(L<E=[.^+-Wf^@ecJNTdEK<,4a>N@_XYR/NfHS:a0K^LUF;1I]1K8
,1WB()\<2dPB1C3<\f7g&fg[8251d+3.RW1:+-/WWY]CI>&SJ63#L5-<&:)3OS<0
4GO1Gc7L,>.0G9gPFR@M\.bTX(_8LV/&[>UTc\(L9Tc3,Wc,HB6UGJY/a:_._RJC
A:[-b]\0aFe6D(PDI=K=2:ZDA+>9-51Ad#c5[7:e-(H9a7[^/SX\:;C@M+HVJa;W
PC(6LK->1[1>edJBX4C79>]&I/EVGM=SdC-aFLW6Wf1NM2H?e4\]]]C\=(&RL.(L
-8;R8#O#G+b?\Z5.CADU_LZ2;KE^Z=e,ZX\S\SC[-fC./\@cd:V@;(7)C2#\8M..
K9IRFC?>9PFM-)L1SCMO+aa[ENSSgE/[>>1FN?MSD5Nd+=J4O,g^W14^JQFAf^TX
RbJdQE(c]eKJC@&5D;5Cf<0HZGb50J<[KMF56(?>FVIfDAf3B?W9Y62400PDXLUS
<I\X3DeF1Q8EMZaWUUB[K\DVQ^W,\&<HJA7I1.WC_72)&<4GN-FH&Z.[aTI_[X_H
60I+S#WYTRe_B^-RQ:10dQ.b4UGeK7d#ON12UZWN6Nb+J;5Q^ECT^2e3S^5gW>99
?;&,(9F8U6b0I\bXBYN)VJ)^f,](:Y4aHeS\<GI7:=Ig5a48M8C1C&_.Q<[W9?fb
J/W;eYfI/ZB&;K7<@FP7&-<X1LV9EVV.T2f&FY123LD@Y[?+.8JTcINAfMW+X3WS
AW-H&X3]-5g-L<\/BC^H5CI&]Fa8ZXIf;H@V)<()V(QTb>J9PB>U&OG>.[Mc]T8<
DD>,dT22Y]Zf=V(LcS/NUO:Pa3#ME]0)=b3GaBPT?&7A<2Oa--5TTSP^<M[-U;0?
]9ANR9GT542=TM>[0AQ/GSDMXM?6IK74WAPeK0fM>EVRH\a25.N0>PN],e6BEP[Y
ZL3cE>L47]+96A8cZUUSGdYB9WMTN-6>=DE=YU6aX)O5XX(TF\;I,/0@#&#BHW46
;RfYNb_E:QR0+-;c,#6b-ga]FW.T<>L[&BDGX8FT)>3&V3B96c[C]+F+UM=UM?:_
0.]g.VBRJ37eB=YRS<FaF(_&@&WR0IB.429J4>f@4H&?DQ&H=4f#26Kf^[&c=gMg
gG3edSM0[]99_S]G@Q_7c4>aF>&OM>GeINCQ?+G,@L?UX]2+=07QCZTC>3.0d]D9
8NdVV9Db:G6K,Z?fTM1<Y^U?V0YNW47,C0a:b7a.TG<)3(-<\QJ=ZP<GGD]56>Z3
?:5^ge)_]0R3CFTFND2eY(<J\?6Of]:9g\<:gb.MY?V8]AU5O/)R+9H97MacJQ]a
N9_-+4B:#a<BPE&?;V]dMaTM,QC8dAB&SJ1;I^,M6,AbJ-d6#HCOdA(4.;D)cIU@
,Y@^]9g,>Q:\/@&BY4BaEg^:C6G5+;SRXcEd\K1KWKG2<]?Q<(<+M_Z6_Q\R5aWc
gL&H-UHabc,3/0#LU+eB&>N;TbEO>E)e),ce?0eAP?GMMKC_AB8T-6T=2ee=b@^c
U=;W8NW0NWLAS]0e,CYK1OQ-V#AZaNcLT#e-)Q7Xf?(=/7OeVFU^VXe<XV/PLDEP
)Q22C&3Xd1PMN8aO\M<(W2\P&D25bVa<T_FOeT4?cN.0F=;XOD3dL7\aCgQVY>M+
<4T0CeSYS5fQLL9-DZVNc<ZO;abM:52gGe2,d@(-Rc7eZX<g?eG4bIf^^NQS+1@G
bHU^O6TgbT/8;PR7YW<Qcb^\?#^aJfcX#6RK9&?Ie(;-L85FEC&WN>>>A0=VeGeP
f)/UP>_?\HH,:<A)9,BND^d#4YODUN[NL#.@#8X_#&X&7d1;_)(/^dH?dP(3KLP@
_(4Y>Z)@,ZX@+MW+TETBF3CB)=CTDd@P0IZ#OW9/4P]f9gYeR2=Qae0+(d@5RZTW
bR(ePcecDY9LA(6][Z7[=dB4b[)78eQ&Oc9d)GVf6LL=G,/OJP;e:#>bD48?daG)
A:NFG]]X.N-PC[W8UA9#&K/H<&OIIXI/VRdZc9.=&)MR60)_9Sb4@8(N:C?.d+2U
NH++35MJL]Rf+PfFKe\^,A4Q46:NH+dVJI.K48@b)#dSGbQd:f6Fbb1\dY45f=YH
I5<YU4JWARc2fXRTZN+EZ5HW#Of]HWg]3>/Y[O9[bOg(X[F0R9VH<W6MB_R[KDcC
Mg@^7/X_^>Y-W;c<D5aM]4[CfGNHD:4gS_V0(.]8ZT&GP2IQCXfHD=01ZBc\adVA
ggRYBeU^fMA?ZR)27BDVAVDND2P#2=9P.7]bKZ9(SR]HQF2VM0)#9B<NDIe&HeX.
He<<(T98-ON5NcREA8Z:M3W4#1[?L?-cV^:ReA2TdLXGcI/OGXe:agJ9LVN7C1XC
CTB2d#FB\Kd3R?GV+JKKa\,VU;KD2c@Q0\a>_cVS]O9-V5fO;g?]OC#_X..QATB9
?UERDWWP:AdT9\##7>@3GZ7^^)(cf75>.46&7g_@KDZ9D\e5C>V98de\9)YI_>NY
[MZG)4U2PQ<)FQ4fe^5JQe-.BFR^=YQWP[G#Z^0Q\BQ6PVfKZHUL#;\_3cJUI1Ld
C.BYGY(FAWWFBfKOgffb?<+B2[U17Z3U/#OVX_D,5(g#@#V;41?gA-#?SEIFM@S1
9CWI4R=cYSOeG(>D1TE_4a[44H-,6187E&\T\.A[<>JaPD.XC/D>@N28KZQ;Y.g+
+,HE7:T)>TD6STH=U-C?Z.X/TMRgI_H/)9)7#)D1XZ((.9O)d(((;2=Ac-FAT7QY
=Bee]Rgf/SB8DK7/5?;]CJ/JR_2UP3(G5<D83d-Z=6?adbSF3DC3A>1M9Dag/[JP
0AGM2fDF/YH9-QI,J-Lg,M:ZJ8_7D;+8_:&\+aa;O#/aPV2&(^KI^D6^-5-3AXFK
Q6X-aB<#XQcD]MF=c4NI:.KSg(+.SGQF,)AGX-G/H4T>N]NX/2WGE#N+4Z4Z5F]_
dYKB,HT4H\;S?A1R.b9d8:1QO##_^(A1J_eA42(1[&R3_Y?JO;]W6U8G;D4/bW;?
)52EP??UJ9&DcbBN0<M[0CEd^TIMF,JL.7D5Hc7306U?/\a#>BHcG.Z2291c2ZY6
4V4H[1]E4W+=&-?cL3K<Y[848E5]d:,FF8GI?/&6CGTKcT4RF#&C7?8/<FOL,S<:
&XAW2fgZ1>7/&&T1XR;A6[&71f?d-T]D[(&bSQC#&LDF0Z9C,W<?WIW4L,87T3MI
24<8U<0QWNAA<>\0HJI9\[WL?==\./)GR:6MYcAabU.)1Yd73(fL/X\ZI,:TYE8U
fF+2&V6)D8PHUX.^?d_?^cK1:+ZE)LC&VV,8cHSA8)3Se7+YYRC39>KO8dL:2E^C
KJFGT@WL<WAKcTS@aX2HH+9&CT?4?RTV(B>fJRcLX)6L.8&eZaJG0CSI74Y>b&e#
a#S)PEUH;1J_FFfVY>J[-#-c85=gOAO8g,3BG/9YIK(850ZX4(TL#YfEM/-ef0\I
7bb[:NQ+U-bgUdG5;BY;d_ILO#b08SXABQ&eND[VB.90(9.1DR>3>]+N-(e/D7_.
f4@,f8F=d&Y+DeB#WX3[(4L2d@&+@cK)<@2d:=4aJ3WIM;Q<g<f246C].\#Ud;H]
:gb7>]QPCO].gTGKcLJ<5Wf-)]4WA-PBPKHc]Q6L#D\.ZWa6#^Y)F&)R2+&7c?;Q
4?G#;J]#A)=5]SD5^E)OX&/cGD#(TR;K.R/LQ<Kg@Q2MJ8O8@e65+DC]^7UWLS1E
B5]bOL4#+H./(:TO17H>U5RB?7;aI#\8Xd5J5N&B^#^4ZM\T9:fKd6&=g>OOgVF_
<4_gP<?1>1B18PK4=e@g<0E&LK&L,]ARYgOD0P(9bXX=+(IZ)2&aHY,X?;?9?50[
:3>d57KFLR/P>5PQIaLSK>;=U8.&Ofd:DA0acde;O[\5H56]+_>E[aR(-NJf+)D7
[S3<:<<):-)gO>\OA>MNbVUHZ\_4-RCA;\bcYa(:;=^MA.:;QUCQc1TgO+_:ZfA^
2K;7B()OI2&>+G98Ja\U,)_:K\QDLWaGSK3ET>](GK>^NS<8\-6,H?Ga5e-d/^aR
FGIZ27+3^_KX)&G<4T]O6W>Ua,HK-VBafeFc/@_#EDOBV/98N-J8]O8\T9a3@UL,
]++0J,3PG_@/.N7]1f3Y[U]5BGPLYD4[R[L]U@2L:=cA=+>Z+5?U;IeFH6,f?I,D
:85]A?4.,023#c?(0fR66ZOFLG7YCFN<T9d?c(C(E_A07N/C@-@F:ECJ.+G#UcGZ
gDK7GBfN4/\=.NIZHK,^3)7e/[[K2YQ8XNX+,VgOH)Q(#USIVI8Z=?4Cg.W1=J7e
fWS:H84GB0YK,)D_XZZ<,?_DMJNXY,1YYUPPbW<0Bd,^ZY#06SXe11^>:eGOS>>-
VRd8a?+/2NKaQ;0;0a^F&BL\JKF+D4+ZFGFS>bS5<=fLHKBVZ>RH+cAPKJ(?8YSN
-IH+BBV\,5dM0_<C1^BIH6fR_DH/Q\9LAG#Y[QDbFPNA,KOAGS.@-T<Q?L(BU,:9
?:_#>#2_@\X2#/QQ60dF@,VbO0._O6F]BdQ37G,MJZ?#/?9MXT\;UIcW#Y1I(LOf
I>B3?16VUWW^QGgA@e(bDfI(BFbeaPg),/Mc4A&Ca)&>UDH>>R^<X^SI-WKe];^6
.:MXK\8\_6(Z/?4b3TYUg=Wa+\+:/3e5G=36)\-M8]NWcU?RH_4f5dF/F)X?=Q6/
#LC_H#YED[3:\VaCIRV1+.3S=G3bSJD]S2DS7:Y-C+Jg^F#03g)-e8C:/KSL#f-_
I75Aa_&4-)e/V+g1E[HQ-Q/c&(/=M:aGM\909VICDXL,RG?IX8f<9/CY.BXKZMR+
15;V=AET<BPc\IPIQML)e<cQ6SNdW?:-27VP4I[QZPS(G073^?=E63G>FE34G[/L
-5adG6876.(,3.<\-E)C86ESSAK^WBd<4GD9,Gc=eW5D0AWYI+#BZXMJQ@PAW<T_
\-[YI.caf&@E<DA&7beT-?3H\YMN9<dL/E:4XY>dY[;#P+UUJ#945O5I3=ZWG:1N
:3C\9;J3B2R.TDF_OHY@K[g?,>L[)1U<#@gP+&72G+1-Yf3c08#LSSB1VC:b;DIX
UAJU#e@-NP4Y&9RH6b=]g=E5&M]#.OS;)G-C1dUA3X0:+7aa;W9T79ZcO8/DD.;?
=D3M^_(fIb1)c>DQO)e5H9f7G^?d7,D/XUO?Wf^aYQ3X78M+F=9?Z8[YbG(C/<2,
:]&B+NSD)TP.-#L.@cB=M&R2RG2)M33cPg]+Kb4]#]d:f7&=JB8cJe4\d_9]@:1J
_<9;a>UP&)9JTQD8V=e<\3&RZbg>S^.9-(B,A76AF8QU+/TN\#Ga/fg#33<+5@8b
RESM.:PJPfQc;e<^<cURPU@^X^>]:+\SK3)AH3TWS]1<TdPF7DS1E.T-FS7Pf)be
U;afW5Pb\71UZ2Q^b8]g6N>GK)a^&85>&B/9?(_fQ:C)3ZPQ5LCU-I;SW3WL,X5V
J[-b>#X+>UUDZ4U22M+dDE&_S8IP.gVPUQfdfV[Mb4;g4(FB=J[0)ffDICW2&E;-
>QcU.-U=&+X9+TP(D1^fPb4B[MQ_]a,A)9bZ<BWISQg[;/GfAgV?MV.2CXOWKS==
FafdJWQGX>660c,I&7Q=KaTVPc:@M1Kae8I[ERQ[JD2;e<7+a],=J@P8N5I<J[1#
8Aa,VfAcBQ)WL^CV./P7+14ceJ^?0=6M\)4LW_<.ab832Va2&>c(,A7XWX^gK>7=
E5Z.PbVf@7D4M;P;#HZ/\E2bF+R/&2T4EYUP:W:1WBJ9?#bGfX/@-6?(;aR,7KRV
SQed-RJATTF:HN2aA=8d#L(C#P\M./-@T?E(]>Y>_]FRFRJ;=0S,QJJ@@#bEZ-8C
VZ=F()c--<\5MZ>T5Y3?D62+\KdKgPe.,.8UK=f_T1=6)Z#I1(+RO_e^JYH5Rc&\
=a(DJ1a=+#^9>0bL,=33.91=K[<P(/aEP0Y?6O1,85)Z/(J^C[:95</T.HQ7O0Oc
K,Cc<g-A-=_)I[8g9>8TDKc#F6#NT<U#>6TLX#S.f3)K]1B:6M1,b=YFGHB]OVBA
N4Z]EE@^TAReO[F\<:G/bR85;#<YaY\c8KFce&J6A=\AYT(5RQ99Y=26&Q[C778W
cd=TKT9L3CN4G@<YW<ec/[#DW=&(ESOEg.:95C=Z:PM+IOAc\fW_)?,M)/QS_OOX
N3@61EbJg,0P)-,S_S1-/8^:@>85gfN^f[4)C)4D6-egS8aMJa^LZA,QaJ-bRW06
?7.&J&WYC>L0=NRBA_b?7+FTWJ?X&f1X/<_]aI\&P8CK3L7<OGc3ESEeAD[C&=:_
I;@>Cf]&;<HM>2<8@>Zf.>BP-aC=^Y\A;-B,EXfc=>-5>a[LD;@a03DSEY<-I=]4
MVLP=LUEWR99eKV2+&RebAA@DI]9e:/\9f(2-e/PV3QCG159dR@D@5[?9W?=4+3-
KJE3[6+1+U#YYEPU^/)99&c:K00[(NJ<99MQ?.gM,O(SN0Od+fe@d@Qe5K5NN;M?
SPL;N6Y54fTeeMc1+d,D+eSGU+e[)I?OaJa7QG4,?_O_.44J([TLeKX/VOU&&-B.
6(YNA3:2F?X8#[:?<<:BD.LPXESU)RZGdCZZ:Hc9JcX#0]B,1]Fb09;,KNMK<48E
EaTUE1c:G3<9AN;^6e?d^M3FM=YC0Q/9.\B7XFdc6DVRA@FQVbWUWLJ.>N1^a+QS
65^e9ZDcS9DH2H-[2_6;9E)-(Aa:Nf98^-2Y17DRTAX,>b]#:6bCSXECDc[c.Q;T
I[<U[@<f7AgbHe6R1UD#M9<@CDaC9g#OefA8Zc_DTVIId<<O2[ba&;?^N]_+[Z#;
&GU.BC68>EE&X&#V4[DQD<.^[^VWOa6]^>J1X4M&GE;OYWB=--ZK]ad[27g0YGCd
B@dGX4?T-)OKgC4LC]F_(GSg9VdQ2O\1:<_0KD\:,L()BdORXZ<QEFE09cMN7-ZH
OgABN\9J8L&A9ReMGA\+[.8ffRA0^712[]fO6..]SFIf\Q).TbZ<(Z:e;cQV8MWU
1>c>IdV\PLOT73c#,BATH<FLK+bL;H[g(>QI>CC&(VX=S&E6d]eOWdQ,YP._[OR8
E(<]aQ9X#IX503cW;-AV,:b/F>9B1d&Q;3I^U)D]g1B[13)#ZW.[,:4@+3A/NESY
#DJ6^H1TB>UC-VP-]4Ig3ZLJPc<^G)>O4,Ec:9MCFb@),c6.9OW,70>gGUO6&(Ib
=6HS[&H:)6(\CTF0Vf8,YL+RQd:(1;RA/.4Q&R6(<J+5_T(6>N>0(cV?R:>@HF;#
<bG;Y\)MWWPfRgUU5S,-#ZPD5.\8H+PYIQY45;,5c12XAPR+b1DeQXH]R&HJ:2C=
UdG,e)W91DP4IV9g:P[9J1SQg6^(<S1PN_?gFP<7\EeRH,S^.#QUXTS&Na2H[ARb
#K,WRS>8EUF7.N>bdBNg@T[>Q_3G_LNAdD)UJ@f0A;&8)0YK\dU-K@-QHE9#QIMP
R/F/566:RP7X2ggf?3[GCO:9+5KXI@;RV6ADWSA>e.Y,7cN_bKIaGRB7OOG&LO4?
\07^#BHT&]WUR<Be<W;Hf_T10#/5+T)^0;EY>5TOC(OL0>43R&.TQ@KVPB8@8a^F
6W/N0C?I/cfa:3:\)3&:C86@=XBY?0;HY7:N(H?RKW^]+JT\9G^T;+RVbUAO=\IK
a;OJ\7FG>gf[J\-b.S<Cd4+FZJHf:\_70G^=C4.L)b.9CQeSJ3?N-?K7LML7]7Ze
.]Q#bfdA8H4TH[3eSP6N?T@\?H@0Q7gF[1_-S=#RRV.YU2YJJ5EDM_+C#NDcD.YD
5@>T[/+F2_5e3GND.1dgE\JFEH8AHA8/NgKZ8aI0\aZ\_fdc9&_G^3R>RVDMg+fO
5COZB)Zbc-HETa&<A&_B\+L+61>2(-19KRE)Le@\^#(G#I.1O>AV#QCC,aGHKHUS
U824JU(8bDT8X]#]4aPb74KR1O/HXF=43bK?^QPVD7e)X7,_]\O6Nf(9Tf>&8E_2
f.X6A+1<J9VeYLPZf=/^_e^][b[QaHZ__&]BgU4XP7Ua-9EBLcS&]S6DP1Cb]dJ^
c9gGQHPD:H?VJ;V>MNd(#F(fe2YRePKJ4W3&_W32)JQ+P6,)2@RedAUA_EF^:C6I
bDc^@g6<[>c]Qg9&0&H;97YXC?C/.GcXTC=-cfUK[_OR\<L3Hg^YGK=XL4DL4<(V
\HR\])ORH-/6L.;L\a6V39f+W4f4QLgbTIKYB>HaF9ZAXg.W-\:D<4F0-6(CM3P=
?#d,O5VY2@NNK<.K>WbC,=0XC4.U[YY9.J^B[.LaMA#>XLR+>>;PJb]MHf7bfQA@
JY@7ANf6=#=D[bDF#O];SC>^FP7]9>04YcbNO)9Tf&=;9WdBF(F/UQCJ4LK2P7\M
MI&X[D+QA[&,d3LA<e[<669[8R/SD/H9N80>9AD6F_(X&,5C1<Fc?a]ea&?+41R7
KO([YPW(6Rd4L0EFFDJ5L3G(/W.FSagTJ5/(AYC57S2a^-K:VU9cL:L1#-4S2>;?
4a7G=1bdbf8TfW,c.fK7AW7_^VZ#[VccEAV-ZYJ0Sa):TO2^8:+^?7A6&O@D@>C+
U6+M75Kd]Oc+g+VJGX5P&:)2[449a5cV1_,91?ZYf[V[9Fa;5)Z8Ld(UE/N9K6\Q
PQ#Vf\V>f?MJ^fL^eLZ&1;Vg&9G#G1=S;#HPF;_&3e^JL>eZbG9?ZJR+R1(DAN9Q
a6gdCZQZ.^ZVTU8e.6=A]V@b/[\dCgJdJ0MI;W1#Y_M>IX0cNS\KI160Jd4:Z+LI
?F#4B8OAZLUH8@DK^Uf\_LVVDPXabG;+5.LL,c^4g[E5A:TL04HK^35U<3P8fL(O
Q\>9f1PAFA]fH3NgTb#L[MW36;^_E]C=>,@V-NEWg[DAc:ZF1+2ZFA?]+^/&CbIe
&I4]IHe5M=QZNe_VgVa,(K=T8WS[55CNC^->]2/2Y;U2B4Z#G(IF6L-7cD1U8a](
B,G40(J/0bFL9SATRbPa9\1&C)cJ-#@<O<5gCgPXEVFZH;@^7aU0c;M8O&:O82V2
9aGAe@FJ8aO^05@WO6A>N12C#1675_[M=XdQXF1_QWC[16Xa^GWO&5cVE[X^Q:?W
f,)5AdY@2+bE3>^52@7=<.Z+c)]1_R8cK[;[Vg;@R]8\A\]@JCL38NM1-aJ-9R#f
(YKcbfDdg=b2=Mdf?803CV/^5)_(5_UD0N]4]b.K@#_0M(g#UXW7MbK27ZN;5\\Y
,0HV_E(J?WW:1-7FKGHY<c<;:/5\LL3DU6+VL\9^91B8gN>2,UTX05+KMg9BX85_
2:L\<]TH.M<=-fJO1[[^^T3R=\D4bSag&D4RBeG;@)Y>Y\:BW8AT4f@W]C^gD&fY
<;Ebc9UB]QI/FUBDC\6@LRL:]R>A1CR?W8-)6bR[4UfG>E,Z3_eW:XI.EL_7T3cd
#>>;2?O-.,I\05(C8+=B[#Z_==..5.M]9gZ,JWYf0K\dV:OWX.(LUZP52C?Y&6C:
[^b>4e+HV7CYC^D=^eX,[#K@CTcZ<cW@80=?fCHM5+H_R)N[\PWK8@CG/[(IEX:C
g&,B=aG74aXIVR-DW(4T0&U.852\O]La<[AK>TU#2Qcb&.AT&G_D(#?,HZKe[CR<
7(=MUN7&Bea-^KAe+aXTS5#fU/bEZ_fb[1+9[C3SH@:N6D^BP(Y91VV#E@)-;@/G
RgNBFRX;6_d6d7>_&<03YJ<K^VYO@@_:3H[LEa;3dVFYJ2T?fE@[A)\)<E&W[+&&
C;G&aZQR6P_\W-_+f<14Y>c&J451b5?_QS2W_M]8@,4O<D.:[R,H+?)BJYc/g.Q:
XDcY>T3^(TLO0D&a^NCDb^/]KXF-f0;aC/Z<JJJeQ8W[C@CCG)-W>#RSQ4(331]R
da?6IB1EJf.N7AM0b7UR\,e)J0PT\C<+7K:cb(FX28U((\c)S#+\=[#+DCW^X\A4
0=P4B,&LQa/]I/:.B:6U<H+XcE0dOKIF2<#.5M.ZHJ[0NGRX9&?.IHC^+H9FC--R
R)ffFOcVYP_(WO[/>SgNO7eZ^F134G;;&a4WX52-bP_Y#aS#JQ@Y6b_e<^CAZV:W
HEP]D#8-A)XVPPJEHgd:HQFEM76VBR?T;:A_U12:)R0L^:5=RIGXL?dN/;:T4aDe
(-SP+Q2E4UFCC4QfCd<_3PJ)RR-HED->@)/?Xdd5OI;XCBNaNG:Zbg<\+gUPG#JN
HF<F1]e\MH/#>HY&UO.1#_.S7LHf9)]S_2@c]Q+dSUf(_69,C=KPH06O]Of])faS
H[2K)C1^7cTdEO<19R7Q_Ic.KDYXaBX;&:WGFY[gcI0WG[aE7@QaN_X(EgUI@F,g
MJOUV@\PTGD3IK-0WL@;=SI6>B7P<-gQ1^(&LTKFYDdS3C^9>ae]5_Z\WY<(]76^
)U:YAQWR^ZQgQ-44]_+bF_KR3?#9Y7<bMf.=g.@S\M;:<@g_+L:]@-P^5H.R=Q9O
b7??3YG,K_HF7RJJY9C?[b-A/.Y#P_,O-VFK8abWXG/A/ZG\eNF6@=#O+fHFR;II
8fF;=BLf\&G881Y\^Vae/XH1FIAY7J\aIJ-gP6Za0Y1I6,H,/GR]:>0.Xb?@B[#N
<X,0b/^.0T6:BSTa(S))IW&.-a?++V>d-GUdA0:I[0@45=]V(WN0P3B[G9EP0=,8
bUH<#5+f+V/9dR1WJWeVe)Ob#.G+2.61R_1eJ]OP\eSKW():+b\II?GC\I_(^\X3
_ZDCFW5BQMH#_;ELV+^(4-:B,DB),&7ZRWQ<W)cK<&U;CFFCWZf_)Pd1-:#g6g<V
0M&P+R770=&PgJg;</O-]?^]=<bV3^d6fV13,POH;gHG;D?^\3Xg+^^SLG&2W(bF
/=ABT3EVJJ/.S>H\16J9S\+M_XLN@4g8U9HNW;R?AG+#\FKPB@6(LCZ>MF\EZ92)
+E8RH=9>)BaAK-_Q+-,/d0@#\+;8Xd)QfHa1YgP3FD/_NUd7?_6G?],_^^fMD8Y?
[>DRe9X<FVIEeL(WL@D/&VD&;)N13=RW^X4bX#edXCFB?Z>A62bb<fSeSf=/TVB<
fd]Ie7LXC_bR^0ZV8g0Ba8IC4C?6KCUN6J#B-,6O.8&17=cP>,CN:0KPb8_+IA7Y
E#>KYMAXKed^EE,4BM=@S<;g;<bbL4TBW&T1d?M33@(IX0g:>@\2J6.,6WJPW@X8
Pg.JF&Q3UXCN1V<3N?M_bKHINN/85HQ2;YXMC:71>9<cJNX-/XXIO+bg&[3;;,,@
J/2Ke?K47U60<D:,C]G7RTe;J?.-R=7VL/O-fc@@[K)]FS2?(Q>8F2?<g7CbOaD.
54.GcTL4<B^33-R5WGZHP)[>QEf@f1fH:58#VOPDWI-VDeYN?-;>\>[1<#bX;Jd_
c)cQPM^_W@L@@B>HIJY89.]J;HBH@TY=G0Y;E0aR?UW[]DDLbBfdee3D>TR(aI^O
Y-0E>N(:Z\@O(:eZ^_fRWGQBVO1+8L0&/CUE,SQT=L[c,A<P_-]KCI^#O1BEG,S6
L,YGeGEcgg07cec]8@7Rb21@#c#+1NL\aTa>\2gD6:NTE]_W?:^=GK(AZL;g]-ST
ee]/UVJICef6??2P/@00P(dF+[8<[IG9=9C=29bdBe@N[>K-I+O9#\K>]^2,RT>B
B(\ZN22NAM_,8Z5CfQ/.R68NU:Z.(2=[A:D=7BE^?UM\O2\/HE.2(5-D#SG8AUG\
eN]aL5#F]RN@Q\1RGFI3)Ne:bK(W:RQ3;GQ]V8ccdSJFY)\>f\e6:Ld1,B5aEYBe
c@_,&KeN12OE;c9(X_67dPa8GNJg3@BIQUE^aLc=(4:aU-PS4,Wd7ZY0RQI-7=a3
Z\4gQ^a4##g2-:U-C8J]WU9NJ.]0#2&VaQ<7O_/MY_.,Rc&XN++0S.^7:f)-g7D5
T,G#c.4O55)O[OdPP1<H.:Q.0ISHCaB-62Cf-A(Z4]bKTBVQL8\&JG<.A9HN=\D3
T8.)R@51XR>,b^X9ZHL3]5/G(S?8eL6UAX#Wa]ZYI;a29gJ;718.@N&1TWT_RL[9
OV1U1_[@3JVOAQ4V)cQX(2HRT;0KOd25FA<8^2E#P>BR^;^3&^<=#3#=_8PZ=U\g
7)#]R]HLVF0YOS,ac?[4->0+FYJ#L8[d1RVF>(4.7g7W#Sa84d8f)M#J-]H<a0YG
J0XOg2J?56B2MIdU(Q@@)TD>PXg]IZVe(e@4,F?cXJ+WTTKX3dfeQa9P.eEgGV;Z
dX2bCa[^Gea/).CQNNUE;9;NIEK##fS4f^+<CFdbX#F2[KKKUWR<dGLgW;X<@#9W
R(.CX2d-;+,<ePZ9-4]90Z6fZ([XAC8gZFadcU_7@CS0[2:_OUY:TKOO-#]E<WY_
R&N+0>(V(:[eaHB79eg=1,3)MU:6(3<+e:G^\/+RY0N>LCX<PR;E_d(8e@H9,a-2
Ic\-@R3#&-KgX3D:B0BDWJ[+ON=_IG\b:J.:aXfJPEH_(L<\\Sg4Dg[&]gHW2&=@
[:g0Hee_686dE_KQF1[@D\OZ;XX5O1aUbP)5P;FaOHCQU9WHQ53#?:fF@0,(>BU<
4&W+=GSY0EHUf]QA@_Pb25;aSI&,/;7cCK7f5Q#W+aQ44T[UeKQV^#N37LF9=fL=
?+32)(]8B=B5+.GI2R70Q_b;V)?a2gY.gg[F18gf[K7+/gV7#(g1/T]=\.7g(Z)U
(7E9?]<SC_-1.VNgS>[KagNN\7TM-=+e)-K1PZMWJTC+IBL6V</AS#4.0\8KJ-08
AZP9C&Z/R[^G+PE:69LD&++0NL&8_JDZEPRY)&:;=A:_0BV)GcWAb_.>A9QX3B5/
74.bIPX/W\<Kf1T:e;2cSYLVRS+<6I@F5>>,[#3#>1ae^F(9=?</+M=\Q))=,8#5
HGfII,OU?NOTVOd1fR;O-O6[/TYY-Od;BYNPUg=bgTb=c9N>W^0&MC5^2f[]W/&I
<7DOcVbL0?2)g],dgGc,6L<fTKHZ1.ObHI82<ULJVf[\^LS7LcVEDRFDgY[62H>^
Gd@WF<2+4fA74?K,Dg9[F+g:a-FM7=K6_[2>.<[\EX_gO7^YT9\b6X^bP;0J<Sb2
_>T6SVeJ]-=R#a+8T8RR.\f;c^(-XL-K_faDZ+g;(/J,0#59(>_M;g1fPSQ7^Qc6
YBcT9YCQ/=4U9Kd)BIKJe4._YHb1.L^IBI\@G6:9L1=YaA9Q[/=:M[f,Yaf+Z<cA
dUbO7d_DP?ZaGXaI2eRg>W=ccSH22PUa&+W3M(b_05KdZ29ABXbUc4g5ZGHg1Ig(
.;gC6We;#02ET-8[)<e?PT3P2S.>MTbLV^<Q)B;XPUcB_abbIX4PSaK6]A+eCDMI
,..Tc._(;@Z0)FKI?[/X&Qc[\@ID;<,PbXLU<[4+#H#4N/\aGURR6J^^,W5WeZYL
)b_0Z<@R=ED);+gX6b[,16_@ZT5#VdEd2GCbC^4_Dg/#34FT];+OJ[3:3NPY:X)#
S,edX.U:NdabAf\ITT2.A-6KS/6U]-XWT<=;LHbEVb#)_O=)?0;,]&T2]C_-(W8-
<-LMZB/2^D/27FRa_:5]CE[[2<Tg2VdY,48WV#cV0=H>,GU-7&(D3eIKV<:Acgc#
J\2OR:_(@@?F9#K.c+JO#[-b_dZKU0RA3PT=CbF.ZRR8N),WQD>Q-.&a0B24<:[8
IEX\IMY:_O\>bf6^C,0\(g89M[HOBF,&_P0d<)a^Xd(K\(#E9^GAVeg65_2O.gN)
D9,9c#/3aYS--DS^&e:3W\CB1<\?BA8=S57^U^6?,U(34HbV-VX=dJ.0&YPTcCWP
#3WDeO9\?M&)OS1=I3[VE/NS[(BIb,bW48cF^Hagc.c<Q[L?04U)JbI,e?A5f#3G
&)9<H>?<c[6CUAVJ-c[PXC2;Wb3e445Sa\8\0=.DT^Ff?^<>V7&)]5<4IC<eI?S1
K_N.+US.;<N7C,8HYIDIT>>)-1+4+4V1JO:AgE).B/(N<<#D,S@cb,f83LMCUXH@
8N9A_([2GLF60NB<,dG;TKAP=gN1V#-#-2ISF4DcD;YA)Z6[=-?\egYK2IE&-fKD
-+e(3-S46d<K9W,B@OVWZ=>26.M]77/\f7C;XLK.6bM6RP)6[c)CWFF>_M]A)=G2
)+M[PK9T@g?-U(O]A5Gg/^MK[<K:V9=MP9)e_e.^ERG@DC6_d&Q?aHG7Qb?W^2Q:
C<?2:=\_UD)\A8G@NG#,9C#U+,85,].WSe5;ORH,N9K_B-R2A>QdGdOE(e8f6c8Q
Y/?_A-&fGAGc/YOY#X#0O9#5U.9@2UJ9K7-T]cgYOL<V-X#T[>0I9+D.AJ#HO8-R
#LcTRQM,+VT#?BL(B?;/.+8G3N5O_N:5@J+HS133[@U&ed/#<KG&@K7#]VUbBb+8
aPJ@?;6CWA:R1N9]JMF.9<aHAD.6ef;\X1RTW9&\a:DR#:D;+^SNZQf#JCe;H40J
O5.;#MTL,Z7:KIF(7I@e0<5?>,_T^9925[BBe(U:B[dKCVX\ZAI7\RSUR9E)AZ,9
c0gU?Uc+caV3.B_)RTY3142&JVN6Y6KEZUOdFT1<1)UY\<#^1c(-Uf]#OW6F.#^A
YP;?MWY0<B/D+[XV)A.XCWb+F?<_G5/DUVLU(=S;[8OKD4ZRd##JTEEdTL4_-LdE
LbX/.W@\BO:GP_#[W3OY4gBT/_M0&Z+RQ/],>R+.A(G9@S)1P5]1:WO_XJK6O8.V
X#GD7_YJdB&eA\?):/]&-T2g\J,JC8:L]K;C4^g-^+II;aTQ4a[P9L=B(CI_:g]:
2Jc3Q8IP-f^_7EOT/bf#^W8+HE7TbM?,H/A#L/:MUP2)ABgUGGXSFgV4HN5(-2Wd
SdLc/PA,.cAN=A\9/b>GV1<@gF7/N)]_FZZb_HQEK^G.P,Y1E8><MeAYA\+#2.4f
f(NIE^)9a-:#^a;CV=M[?<)F/PZQWF/U_DPF4eBI[=]K-2_S\Z=K.63&R2AfC>_S
K01;N+20EXHT0U1;5\:g>QT3<RVH9H/2=YE_/Ia(KXXPE<6#Id[FW;SLRWed-03Z
YW]?7<[2(P>_>YZeTA<W=aDcSBJ6KMBERL<eBTV^JZ:CYU11]KZ&dg-GAbZTIIM9
B,4K4O=[\&SG;Z#6P1:-MRUP4:>LX)1F3f==C[#,5=<A+J:e8MGZ,;,<(4JW7@A6
XSfMNK?VZHe^?EY[VJ:EfgU.6DG&^)JL+c[QH++_b#^8/97B#:IFO&40#+#80QBX
HA)g&e=/FX8=AURLV9=#O]7=b#E\\_HRF?B;O]5D?LG3=^5R?6O/^ZF][W)GbK\4
O[X)I\cC7W:@\C=8L3[aN?;P6ReCA8\P5P,.2J>H1D1.@R1IUYb#C2f[9W)4#HJW
RVg(Bd9>f7(QWg5;L@IK.\+.;LWGHFJe]WbENZ;(Z.4764Z?[Y?>T=_R\JG-<@W>
8A,21<S=,[6CXQJ]UOEY94@J=,>;>S^\AEb38af.3@4FUgR/SO2Q#=NQJ>Cc^)W5
-GVgD220.F2VM>B7N2L37)F5PT5e2MS[CV9HL.\;?]A9R8Q^BMfc,<A-UA46&JIC
A68;:3<?7K?TEcQU.P.,d?]^\>=:1,R<^bIRg3_GJ14)_-0X\EWVPIF<&57C+eR]
M.K->:B/Z9C>QA@g60O>Fc_T8S2B^PK<U)db&3SOb9=&&dC10,>BCcSg-HF866b:
.S^@dK^6G+YX3V1+YHN2<J_+TCGY)Y^:SdY5fL9f(AEL(#PO07M0>e;M67ZK1^77
)/2&X#IF/\9SW0Z.+K7/TOK]/bFXI0,4>,8aF4NNea80<]G-SAd_N<XXGFX(_=aU
\,4(@Y[]O5+Y.3X4H_EEQILM^_Q.YUOdHca@bO]AgG9X.f(P>28B-0=G>KFefB=E
T\YS^ZBe3Y>VXGNQ[DVbV1Z:f+D11a62OI]O8N^YB:YC1=WCI19AA&Ofd6+^BdLA
R)a.PfWC6_LWHDQ,S#M:]G5WM;K/W48.^aQYOPU[@Q;UQK)X&&9B8aP#:K<Mb3ad
<,D12@W--[(aMOV][3(9+TTN^B.,4CgdfX=>a2@A,RdD[EO8VT,6g5W.6AOQ]+S[
AgJ4(R/--9bc;fWE;=RXUVKOS?;A/0[UQ08&X#XWS08TeN,cE>G+6T<-fI2,R;RH
09e@aBS0R:P[FPM^#U.G]<]984@=&QF&.?[\+)ELE4M_-W)#d#?^Sb^(7a:ZIad:
fGVdB-[N>7M<QR[@LbJgfU<.WEe=EdN:A1DUN>e,B6/B88QMK]5:.TaNT_6MQc,X
d7;I>7&=&&E#G[B+b:BYO/1BNb@:b2fSSEJ>VWbZ8L5NFT\>VSf[?&Df3=S6VU4e
#XM50HU_8B0QS4A9.G::)e=#]GIMc\\]e?WO,::.Q=+)d@<#I5+5#>9eg_JK5/RE
=>D?L),MTHD)7C7Z2J1.Y\&PIM(I]FE3JG@N^:aMbE=;#\.gV+29(JYIQ?R/-LK6
L)@@7C0ZZQ)[VEY(+#\94B6/W>JPQ(OWK6bUOSA?CEYgBWFMMAC9I+P2(&Z[302]
dZXI#d7JEcO0.6LEX0bRF0[L_.R=c5@R06,W@_[.BaDc?;[^C-Z5VQI\/Q4(N42+
bGcAa7gJE]Y0Kfb,9cAYV/I[R/K7e?4K<=XN)FF(1ce),b.<8WJ23\;E1]I.=-NG
CA,WD]:R5=#WEA>)bJ\P8T4S5=S+Ia\GZBV\)[Y2MOS.DHTB[gLC04UWSEE5&A/1
IIb#dG6UJ\6daRdXdR]d20T_:2T-.[&M^\5D7V^QbKH3T62J;R^?T-N5MaGU?8gE
<@X3^cSO-GFZH:dYTB_((G7eW5KR3[Z/^?>:4OAd<0NPdAAIY#(#+F_b>.0#a/_;
Q9..,7UN(:9TLgfN&f3PLZN+NNXGSBQYR6(WMa@)Ef2Q:/D1]A^ILH2<W8A[[DJJ
MX#0FBNR,Y=/T/Gae<JYXf=2T-L4V>YZ@P>_)FIZB3PV:3(&\4B,a@1X7X,B^SHe
Mg=FH>?Z3XT,Z9(;a6eA93eYW9C(c?W:PD?Wb0BbY>[86?;Jc.,JMg.a?I1)b)G.
-QIg-#aGa##dGc7g&B6Y@5459PP#H]-P=)70Q)X7Ga)f&SWC.-[9(=gf48UZ=A7Q
>CT1bDFQC41D_^K4JZc=;b6<DD_DcP_[K5:1NTTD-(4Q6U\#/N2)47=;M^QNc?OR
\;e]LdNaDIZ]HZ6;,>]=-0g]SEC:ETG&E(<:I_([^d5Q;39@3VWT/aMfg6e?HDeU
I9#UMBF2,:DPAYY#>Z:Q]TFLT;&78Gca:d#CYg=cKK&XXI0UTEf67JKDD<Lb9&X9
)V_9UfVIOb-M.dbbPFcA&^C;DV</c28Y=KEfHZ6gLe0[bMJ&f[/6^Y3:ZQ(X[?NJ
I\XI;AbS7D#C1b7[@/2P[4<.TV1I4F+JL5VH(ZFLSGeOQP5,6?NNGH[(Q5?5F_MP
6+U6^(X9M7KWXS6Q8X8YH(G-\-,P:E2MC,NA4c4?@RaH1ZfTT&cR-QC#bfd-.-:3
F0JNbOZ61UMIQ3C?@c)21E+][Z>0V2<IQbc03</WV5_/9K,,bBN2EZ22bKP#SgK>
gQ7NEZ.J1Z#GY96L]0#\;EDW1DD-8Z.=5SBEe[IY4B:=I/WD4\W&\:/]Q[J,\A+J
Ze@H(S9U0ZV+ZL4]Pc08#,:>08[9Sc47&;?aIWAW\A929d\14\;;W8bD&dE0KG[J
/QMdZD(+1SQ+W862[^+a<7PKEH_Y[Q(8PZ>Z81J.^.XUgFPRB:d,K^4JC4MGBBX9
1P#PP4EC@Y4;TB2g>6Y^@3DZfPM>aBE60U2^)NRR>OC,JIKB](<X,EY+KHN,Se55
\YW0I)+UX+/QM\/gP/6=AM+_#&<#aE3:;]eNa5M;HZg:0fV^:,P7>>E07C(LGR&<
OT^QBQESKJbQ#BA0^C6NGUYW(ONMK3SDR_Oa?LP6MK8NUJJbBg5JF=M4F_/TMF3e
&ORK0M:UBA@GfOT>C]eR@YXB+e(YeZ(bAa-7Q^?]FJaN#YVHKbg2F4O<<V[JG&:#
@/@RUB\TN)N@+@,X9682TF:U]GUNUV.g6A7@G/gI3X=@g8O>KH+D@/,1JFIAMAZV
:WOGJ9#DTA2a+@64KfEg;\cH8#g;IZU(&5MQUX&(J2CLg?1990JJV.,Q_]8I[F8T
(6YCM.V[@^EF5SWS93;GLE]d_A<H2-W47:0P#&]YV<XaJc3[N2::VZZ)XF^Zgc/U
b7,PI./MDHUK53#C+RA.+f+N/Abf[_cXEYMWcH,V&?P5ZX2B0P7\09L&M##0>7X@
[OR6BG&MC,-ZIDN5H1^+J3#DQ=Z<3=JSOTQL\aJ0AG63(a<3;K?P8R-L]cMCPDVF
c7=TCf--N0;JOC]#7V.#85T3ER9)K+@;I7a1b5Fc[9=Q;#PR<RLbYWH)(.,SBX5H
SCET-E#RXOfS:AcIHa0:SIU3aR0I1@0CD;-C_1=],(6gU1JQKO2WRd&QPg/I()CS
Z(gZ95Z(feGJ?V1Z.3)O739\\+DbI3NZPc8DTIL&bAO;]d_?]e^B4?cKH^?&L?Y\
6@&?WbAJ>[?1d2VP#9IGRg=EG@d>A1<RPc)/Z23DX]ILQ-5W=f<4?N,6WHGNfP-_
]C/TdWCWS?FACX[S>T2#:Ea0TdLI8M@<eb+6E@8DH(.E3^Se0e=IB#Y>Z+[,P94Y
7>YbYeT>/?aC:=B)J)(5AZ&SD<;F(IB_WES.+H81-XATRb;+Zb6?8bH?N]&XOf/c
S_<<>&Lf2fgS<G&P9c3Vb/1dU^Z3/0OG15:M=@3@1Q+?)b9N7S@98Nb5APZX.H(.
e8gC57X3g<F8a6?dHgFdJVR[.^T.R+0.J,-0#/91DSgF>QIMHfIHB6V[F0^6bD>a
9.IV_e8,,bXgR;)^QJE(F-&1LO,XW?9PW^]HW0NHG:dX0gIXT+?3<,Q>F,aDF\:c
Z:=SFLX\]BEgPaAH>bHa>8;_=TY2(ZRJ\-Tg[>HEI#1C_B+bd.#\FE85Wa:VCeH@
B3O\=;T]\4GTV@U?T^MJ\W#1Kc]cCR&4S)373Q:VP)Q:IS;/M[gSM7C(1BT#2;1+
@6>M]KOS2E.=b:XPF#H0VST@[)@fW(>@\7E)]Z=Q]0S3V\TA&0TPHI71DSD_2-9S
7<@;MacI,9\,:E&^CBQVe4GE#dJaDA&_6LN:dT]9=HAE]P6/U+)5UFHF8[+2<=./
4DdC=/f/S.cP#6OY\9[CI/:L>G8^1>R75#>#71G]A+:7PF<N&RTM=D@F2;?BFZe&
<=C2-DA#;C72][)e2&09#K_d;;Z_OP]205<GPPSJc#@;56-&g^d2H#&4a#)>-Kd)
^D23DP&a5-24W9)S/4BHc(0B=1\BJ[X@)KS(PEZSW-eBag2,?G^-8fe^E+5-Q760
X;eVF60M8B\_K-6(,Z6fGP@H0FXQ\JcY+D?U&f7g&:Y_G+5&Ua8WA\#V^[<Ya21)
[^HYeTO_;b7YWI.U9ZU<1U@PgY.P.=<#^LP_VBaZY0+Q)1gd4CF#WNZV&d10#ZBc
Z:DW,4(G-HR?Te2:Ia&(H-<YRcE;Pbe)T/U5[B;BEQbS1a&(J=bB:4R#PbMOI:^g
C>H.ST3-H>POfS),451,;:79U5HH>[C^BWFQaVR58K51@UE.&\.BFP]ZJ=1&^.)A
T0M=<&QGI(<0/0?[[-U\g/>KRM,\/(6]P^>c(0(=B;=-50U#9_1,>+AN<ge[B1\P
\>&_YL_#9.0GBfOGKYLL]4SV/aZGA:W&XP=^AZ;V^3X8QGRca7a\/Z_[E;6>7)5D
<@1^06U#Qc7/0M&DLg5RWRK3]C\LSH2J?IWN\T_CefM<PcT8+&UHP.&O/4N+dG8C
_Z[N)S0LXEMYKPF[(0TUSSOR)I7:a#E06QK0U3FYX)UYe1[?>e6SQW)^0U6/GG-[
S4:b<U5V4IF1:D\#<MICg5R3Q&>TXJVMR7\+J<A&eAABYNX]U,M+CM.R#DWRD\0K
-bA20Neb8U?Xf29/^_JHc]N@)7bFRE9)GaFSR6C18HM/8,aLO8H16f3S_C&2>;32
e4@)]?K\G/[@514RNV<<,B08#M0M?&_WIB5M/ZfV0cS>A6Kf1a-A&ARVg2K8;XNJ
EA-T6W-/[W<CU6bFe:NbI&E,7AOKA^?_dZ?/6RH\ZX,6RTYP<7E^<>3FR^eCPV_S
4&<J^#3C7_50Vac]1:5#]05X1aKT8gQWS.@^bC7<bcY88b>T/GK:6F43_QOQ>F1G
YS@2-TI:C)[)2_Fb@\#S&3Z(,#WET3WbR5Hf.)gcedQ1T45&KVA2,&fJ1a&C2<^E
PFD^,)V<KBX4[/]FB^CF-V+\^+IT8_YAN<[:_)WP?3H<#]Q2Z-\TO:Q;HH-67:>:
J1^SQ076dLWI7AU8+));RDJ[^(BT[8cG,OW>YNUdb(VY[KaE?@b&U.?aL0N-4\U)
K+e58)C5gF4(YAX(>#H4-JXG-#aK78KMdGU&RfgO<=dD1K?/5R;aK93V[;EY<K/V
MG1@egY&O21a^L41g]S-(FMQU7/d\&(T[\bZ+6KUGX3P2J1>)GQL#A2?@-Z-_:B^
Sf_\KQHO27LT&XU&?J2&A1H_>0YE;:Wa5)=/.^K[^;KABX8=H39G4(<WT<KAJB7?
6T+]/@c74Tgb9[1<XPc]9:+((.]O_\00[R]7U@=gHJ-:>_#9SP&H>2bfT^DgT>DB
VP1LPFO&9,;9LHc9JPVAe/JC.\4Y9a]DD2(U_V5#VIH?-WA::.UWGZ3\^>]9T88B
d5>FVfXC#CcHae0_ZdJ8PS,-30B?1M^+PF\Y,+>5ZA#D#1PN1_P&2XI+_FU]XSbZ
W.,_G.FN.a1<CS>/g,e_WX&EXY\Q#;+@Z&;-D&dP[PgLSIeP(;<8+-R9IX^KO;9J
Q[,D5R4I(V8Qf:^=^58\/QC6NAVF^-)J00NN#YDH]EO<O/9Ff>OaWLC:P_8[R;X3
V@GOZWUGcDJ]-)HSF74EN@LTV^g>H][/O7IX=1:\8J5-6S]PR;UPD@cA;T1KL<MJ
U?I.-d/a)OY)FeG6CA>bG&B5WW=b?/;0T.98/5P#fV8d[R8?#c,<7X7O&9^NW)S@
2C\V=D#2UHeW]-fD.ET?Q9F^c88OKcP:8^,#/BV6IV:(6?4AVIgMX9VE^7K#Q(2;
,=-TY,@g[HKDQb-E0/\CR>MUOSEf-DS6#^gD2[I4A]8B/>BDXL3F)Y5K&-+eY+&[
OY0ZYTYY9<M[D=+FOT#CgP;(4+5NZ9UA:MGKXIO0@-gd@+=G7e3G+]?/>#:]\g;:
bCc]c:aKgRB)P8#cM>ALZ[@WLYb3@<PaQVaTSVP+W;[Jaf#&KH,cBcL-X:(Oc_V0
19J-U5AcBN:UHST9NfCU3]729M-4V9e#20OMQ/&0+#9IbS_G(-44\C/55P-SM#7S
ZD.f?XU=9(3Ya4SJ-1Y/d?b&=,LA>:bNN+5b3&]#Y12GTKWcXV9JG^E_\2N1\-S?
-CYB[gP4Kg,DBU7K=H:V?e(f?OJ]?Na40P??E[)7YC4+&c<?dKSMReCW=F8)>KfU
CILW(e99X,,^&E97;09)&>UXf5S?20Y6E.M/)K;E[NZ>;dDT?Dg0a749C[\13&T#
M>cZ,aJb+W6RUD>P7C((+KFa&g@:dMe,242W=1=bg)Q;+ZZ<JQPN34&2RW:WGBSY
d3LJ>/45OM#=dF^_SHBB=EScGGd;)fd<@>&>,?C+]T>,6BFLHgL^<I4+.H2<6aX6
YRSHCX[USFB=<UJe@aGF#\=+_T&SS.HPba,Z,Q\(;IJ[R/e&PUZ?)BA34G1^WSc4
XHC=,0IN)&Ef.cCd9e2NgHD8HHT[<g5&J=??#?;,,BA9ZFf^>e:7@\I]eUT[SC+8
CMPDYA#QY=\TUSO:P^I)XA5Mg[DG1=T0+-X=:^WT-X7XA-F99]TG0<>^g?]c-329
(EUL2L[B4[FU[=LC&F;b7>O3J-\?EaS_-@RaAPRa3KcO/)6>3J0Ga.A=bD4ga8SS
\dNCd[\(\K/U7^YPATE(P__(W86E6)X_Pd,)gd0ZYT.LN,Eg8>:,NABSU?E:4@Y[
DPNG.DH/bKWgf>,7TKCCG(dg.\db;1e^&2F6K)aX7E_XOe,Ib,L<=@3:bDJ^d]Z6
.8QX7++1cJ,?CS8CC_ee)Ofg)QCL1D\3:8^g-8bTgX=&;<)XCS@>4WLf?F<T>GfY
9>LdRZ[,EONLD<IA7g)/(e)=6,HcaD^/I5G>8.J<ZSRM98>EM9MWWbN_CZW_]S,[
a=\:J?[Z&FT;Sf[#:VSYf+]<BVTJDdZ9IMSN@dQcCg75OYP_TbGM>e\JOCAQPRHL
S(/XV8WP\>Y?9gV.Y6(Q;)+H5Ud)>P1XR.dR2(6(cTfDM[UM;JgHYa,MUef2.YLP
&5+1Z=E9Y:3_=C]7b.)K73aTIgR2^@X.Q_4:A+\C?1_#/LdAAB)L(7;(_G#VIKfd
:XVC^L+PB;N=YW1E+b\ZP>)Z[MUAE9/TcD3Jcg3WW/)BAAG4=g/CPP]H@I6<L?WE
R[bT0/cAbEZ5[Yd++6g[:<#ZA/Xaf9N1&\c<O&OCD/f>0P1&b[a=fC\TXQ\_B]<&
C[96>f4GP\MK(04?UG,HTGQHDN8g1d24PT9SJH-<ZeWMC+aVOG:X(XASH3STg1<e
1T:)VD:\\RXR&YQH735[g4dg#U^[7c>b4C)R)GQX?)<M?5?&3RA7[=80X)?UUB:d
.ZUK6c<=D-g7TXJ;MN&FH@BQ=4#bC7:+=6,/<.Jd_&]U9ZH1#Uc<K(U:Z?[+?8^1
9;BJc+Ddeb17PbQ[ZHgEQ3Bc<^Q>8aN2MUF+_A9a:&3MDZLYSG6_:9EJ@GaA>gBW
QD\f-MA(3\D\@WW2C1fJZ?^C/6NA65G_4fW22,5\V3B(>#9NI.R[cRcG2F5.D/96
d9-P;(aP^63+3&1R0X8/1?7aPbgB;2a:;9+P]DKSKX:;:7W7(</7)-/b=-0NZN\]
JK&?-faN832G;L]McYf6#]6d/)dJ\\-CDc=H=d8XG&O#B5-);YEQa&[@.Q&=X6JWU$
`endprotected


`endif // GUARD_SVT_APB_CONFIGURATION_SV
