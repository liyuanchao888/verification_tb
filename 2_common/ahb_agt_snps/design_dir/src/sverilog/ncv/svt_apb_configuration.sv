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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
X5JlmTffxZp+wIbXOn6n7E/Yzo8urM15A+bfKuKO8nL2O8knvrETGgPyMjNBN1VQ
FzFr3pPJS1nN1deYr1YXUmreA50Qu4gbs/DlXXLnBsANqjtoMZ7A0a+/QryCy9hH
MvcgKaTBrS7vShOPKDSsLz1tAE2CpQw+5NPy+NsxyB+xBQMGu9/eEw==
//pragma protect end_key_block
//pragma protect digest_block
ujNuoETn1G1OD+H4rOWbAd1J+wc=
//pragma protect end_digest_block
//pragma protect data_block
xDBNcZqbGxpT9uQ/TBKyebs6S+CoteqSEk2PQornZqaJqLtzZ9RNVEyi6WxAkft5
1zd+qhno9rTT+X7MzqR2neEmqbLZSedOZU7JACvoJkpBMLXsdOvKx69yYTLw+BhN
InrX55KVWtTEV1YTIAU6FyUvLBMXPj0GkndrmAI4LraAekIYo2CDA611gybDW9IE
7QwM2MaKAeIL0AnX7xjmfiluW6N4Z2BztYAgvxFn2kM1+AZXoAOR8ioY/wHXS05z
meP6OW6jv19zR0xofIOuLfRxNfc4zSYuqz7dbIwy1/T/oFkq/0u5+8+BM7TqYIUp
wJCoRZoOW0QRcWwt8JFOEZTuvesCvR05M5eWDJfLi1+CqbikG+54u8uXQ+piE0tu
2H39PxokDHRCItRoImE7s3afG/1yo63OzlQddG0GVeFnR8Q9Fm8TEggM+2YjNFsY
0bRwNgjEs4WZr/yaKqbHc8zhGtUHnfPTZsEFQQY+dMwm/7nfGFrC+Kdu5sfN7VWo
HITowiS1wuQxusLPnkuU6iz+efbXumYPt3GC30uaO/kE254jTTtDRjQrYur2FwI7
6J+IHpZFLqJ1PHZ7T/bZiWlXWygXh3rF6+ipGMy2OTm1ie1LKByTWve9yYCSsdmI
a690cLabt9kG2eCdOaocesvZj8hFSsogqEkEnX6LaYSoj16FOV8EeOadu1rHnN6e
Uw9ekkRHZ9L3H4xbtxUThqNR22sWtYTOOnAd5RwWfmfPh7h9avMw+ajtg+Pk9tR/
WTSFUCEDYSEwTrtJlVnP5zWLqY5kL0F2XYkO2q1QzmPZQaD4Zl229OCcSAKHWqkD
ovZvkVl1vqQ/DHoDi+5kOgoFuV7on2kheTqa009E3qK/a8Nw5Snhis2gSX954ijh
q/5zbE7GLW1gMLrYG0k6qBKTmOUe3vrCcuGsKSIzNb89vYlXIhBGhOWIo+qxdBTU
xqQ4AkrfDuENWfVwwU4Y63mpofvlE3g1i1IYu5hKK69/sYD12RZPjHLind2B5WBL
ROjUmSaMs156rZZgg4AsWssf42wz+eV3Qu+//olFro0VRBBxh5SlB06zG60hQFmF
vPWwr2uPCNpXSiLXxe1gfX+H3kyHZ0XLRQfp56qDu9aOYyX9ItNVIxEqbK9+I+dW
LLdsgSlnq+y/Qfy0hu+DBq1J+fta4jv2gaIVK+7sOnz2LBNtt9YT22CSGNHhOM/E
QKB2DyhurKtUu9pffO2dIhefcUQ92UvXPP2BnrCSTDtV1J+keVuU5nOmv1B76FOr
NanSMaJvIGzeZrIVQ00tcDLszeG/w6hP4tLSkhVT66qsg53gS5SmL7eFQTYWcK7g
LXziY0koNlA5/Xfzp9rZoRjMIm4UF/c5cibsiAll59/MKjwTjT1CP4DHjxokqBaA
m15CBJzwYKREnnke2H7aNZNaYxY9MZ86ZjsreKLTI1PENM4yAWqW3FL2BK7Io+/k
wwmmC/LD4jWWBbqYtv+bas8X8tntgYMrSE6agfrrCq+oJknYY5AbXG/EELDNCxcg
qqtJhsmc/rXRbvCdQkd9/SlLPrgruO2fl7g+Zj3fMp0=
//pragma protect end_data_block
//pragma protect digest_block
ZHYAstcW15i0iHAKTDVP98dVROs=
//pragma protect end_digest_block
//pragma protect end_protected
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
URWdkB4tuo4S43hbPywVs3VmyandQLFwtH/AjC6LRYq+pwVEXWkjnJ2FKOyFEctt
06bFx94wtbovwp1LSRroXF6xUDeEYo3UAly5KWRmxZtvXEe8AuFPAXl9tNB0GHJj
KK4LokkRoehvpER7FBHeTGnlBN3Iwz4skvnF6BnIl1Z2rgvDmRiMpw==
//pragma protect end_key_block
//pragma protect digest_block
6kQSGprj57BrHkJe/dprMdWD9JY=
//pragma protect end_digest_block
//pragma protect data_block
aBCm26/bRV3LWJ+oG34wrOQJCKIlxTAanFDFln/ptBCLKmxzP+QDSqdKYbBWOSGj
z6nZ6wFhLA8WsRTmZVRHc6jaPB054AABvfJoqTFLLzBOaoLyscxa6LfQ63qWHaMu
O5fQF5C+IkqfZ6T6Q+odNPUhHZBu6Wxromgx4lhVUylr3w9AV8dEC+iVW9Xhmmnk
yPPhrIKF7Gcanwtvrl4bikzAXH2uDZYcn98mZAK4AulOUF2VGHslgBHfzt/ff0Kw
uFDziKCSkdLlGMhaksDogRwlTgMsoLZp8lDQBXsUEEBSkOTpeC3EO07ppe7rPHgT
nVpY3CsLd+uq8NsI2csIHnz4qTRRxOnHvE8/fQj75BKuKfkvDjexJG3B/D8od0sx
g8jlZ4p6nZYyBN9sTlMtEWOAAML7Awjhw1+hlapTI5Ilw2L7fFNYbmd6JTqclz5Y
jdrYzJ0GIeY57v5NlFz68kOYfAp2eSm63kL0TdB90xO+95NK2/85J4abhMsMS666
qpWJ/OFkXasCtu5Qan7vmCR9wWGpwCWTip0UkAtKURcUuZX10gUkiQzFgdE8CnHm
hxUuNT5EwSfvfQdZX7rKmlvy1D+Ze3bLS8W5zMe2myAl+NCmc8ghSV8LanQduGFY
bAUc94AAf5BaAAKN0iM0L67aEV4E+elGWao8VfKzIfI3hr7RnWXtABdJACkPzwci
Sp0GnYAHLprikX8iHT4fPeph9UvmUjpgWb+r0C+E3vRN+mIly59fdpbGP8e6Y2dd
Flt0HsBbUJrJUYAtQeZKOSK78aIpTqMyRSAxfjhqJ7PXvXEBq2VUHrTYjqRLyt9k
MljohC9DvaA37yPsrQ7Fot5eMwf97/yClypuBDtSmRQxhWQcRmNFgkWxdR+Dhfez
ZHgjjflCsEo+Yn2zimiSlQtTELOF2unh3PustN02lZM2hKXZxUmtIsizWOYKsmMq
JlEF0lyjwUvNGmkJnFe+NiapJ+1oT6MJpF/BaaAE35HpDOxyn8hIihKGkqzpGpKf
A+yNJ0Xhl0dkqL9N3mCGxwWfOYP7XEaPaWksmCRgPsc7ICGXsJLJpeZtSLo5pkfm
/piOb1M9xXd3fa1H5kBahoZUyrifwhfcDGGX033xUwVSN1fKrLeutWOLvqbyOf2P
UTMdEK16d8th1IIgS0VpHk9dT/6So2SYcsPO7nUnpGgKLKFWcs3rHnpdK84bwMUe
rdHaQd947ND+qC1FxjKVsKOaOKvEF+/vZy93b31WVb9hX9ChEbLI0X0GgwbgF4yU
GUR7HKNqSjua7S5KSz3bL+z0XRz+sZhIKtQcLX0jiuRAn5ZRnD/CWoUW+eH/V2KC
YzqlngY8hTCbRjmPz+RCLG/4EtgFEYQYqcFqf8VflcNpZLnwFu5j6k/RsMjHXey6
+gFQbKSCNZS1j0B0Gjw8c/5wDIOtd4KdOrI6N9H/BpxRDIYQ0PgbGL4sUtC/xT3G
wMaat6mQiEwZBzDL7CvusrB0WPOWAGTNseni8QuIpLmeadH/MrVcmIli3ml9c0Rv
pGvBGszeBTZmmLIFPwPm0ws54G+LbEbdNKCVBgxfP8is7703o9gr/BxfWZeDHeGs
QqF4dKtijsphXT8s7yorYv0xMb2AWMqVCWtu6Hq+ccHAGZgnlud3qa8x34urdYle
y5yOEO5fyZowr8G24wJKE4lqrHyzIoiHhNysEED4VlQR7rLwdnCjm+KHGrX8GMJ5
e/aG+zKnPaFrIQjyBrIdK8nboC5dx0LxrmQNOqsZPkEenC6+swdRjf4rFZR7oLIF
Vjw0csY9Dl1ZIJ4eKCKBNAO0JkJkvLcI9HmHT16V8lGCD2dmScIz/uMEJiGald1V
lhJ0cDbUBw0bne4uwj6K/IqUsQV59bF63BaB5pMs9/hzLi20hs8zJo/rpqCyIF90
xL0PFjyC3p1wgh+yuB9h0So+feGTB+9LMXnZ0umIjgNvCrfLgf85/uNlctCw2OxW
a1cs+KvZwCEZGDrzweW/TLuHclgvt8c7OBa6osgn9liqQ/NSI/KG95MkSbDeSWuU
VRfi3iOg4rBdOKqJV82xGvmcvFoqy5nFeOOBE+xF73o6oX7q7cmnYbpa0A/90gAJ
Sfxq15/9SMqN8ASkKUs/JtLkHnZhMRstDITrOX2EJzFB5VKbRXxNxEzTIcCK9KFw
+neofg0tRuTxN4ISy0m5AqlJ4aDNZ1lNd+tUwynBEZwEjstXCqtIsiKd5/QNphNU
FtEFqop5LmWxiZiiHuYxVNjQGYBCwjwPkQQ2buAFcbFF2DniphEXmxbL/UAxUsG4
mndMm+hHHabwDQP4sRM+YKvQTD9LUqjEdR7YcmAjK5ejFhxXgY5nGRzQe9bd6I6z
CUO00lHsrZDmQEPURyoSCWgVINDuYVG/8qhgqsJHEyVXhx//07gRJ2PYqgChvIos
duWHga0VVorJ5hqCAriqBe9W+2mvsjqn6OSCIXuQMbR8K5AHS568k/9uy/ZuvuPv
x1fybL36r0wR41tAhSGE5VsX7/3c7QbvX0fvbkc46Eey+7OrFDa8ybSih66olJOQ
6fLs1i5ScnkVHhwOUPg2vs3/1vrrDtAnBli9/wfxMcEe/vDMDKJ/xqJh6FxdK8o1
vKn+24Lmz9Q0onmfV1UQSESWM1tIYOqbeiEmtkm5NVHQqtXR3Etr9ERQXbwKwJ7S
/tulKx5K+oGpgFyLiAd9BUfmK6Y3WJ+ca2dUs9HzmsG7ewcrARUXDkqVOYqKy6u8
i5u5niF/sJyhgy1TInCQDrQbgURSixfqdJDnlsDKZy8Qj403COhtK/aTBxe81n3a
ITC6rI2nedEuckh3n7x9wrcn8zDiYhkFnjnYk4e5INQannNApfwiaRPNnsMsuqZ+
k38XdmR3TTs+xlT9tGp+LV5FjBTa/HLdNec0ScehDLk6Xybp2fxQ11/ien8pGrZm
0sT2PkArupLNZKypJTysu6AO6nHqWgLBBdO5roksZwboNhwyqKukcCLfbK+Ufd7S
yWWWULkdevCt1n9qXd+fbtPStEjcc/4ZiHUMo9lx1LPYTxGB3DR4nKq+2qFCtdla
pHWdJbzCaAJlp4KuZmDYyPLAtpXZp6c6E1vx0dvtnTLGlY5nQY5tke8MwJWjtFQm
8Qb10R+NGLyFG9TrUqHwRyLKDssF+2Nz8h8X/NHt5gMJoV+uBWuHuDwwfjRE2rn5
QAkiZjXiHDFEL5Q5eriqtT1tc0jvLd1a7mePHLVCRJyE2BPLafKlqsn/iGAeUkGK
6MB0OwQes/GL8G5F24PCgH0lNYFHYFhRSiWb+6Skcd1TUslqfqhSEjNln1SW86WD
mj878RN29nmmIT5Nm6c+5I7bsLkxvRsY726i8E6ny4+PcNLZfPR71hXVdbCNxCtk
6/GNjaZAZ1KrRxIdlXodwCFAfzs/v2AIQ92caDmsy/9iwEn7icJm/yWA2sijQ9B2
lTHavbnIfDHIAct4s10FntWcfBiWMn6DG6N4Nbo7rTMSbfCpUnpZibMjHHB1ZDn8
+fNQXZbxvNvnJN+oHJNdy/pedqA52Qu6qXWKTIY2bFsam4g3fGTZEhUTGjExczrv
Pg+pSMQyw+PAhUHF5LFTr4vRyqU7hL76or4P2w5XEfJUOki9fgTj45sHxNcMfvRZ
1d23juN7XFQvYo0avB1O4PhdfMQlJEo90fssA56LNG4Z/mCX/4FiF12l84yDvkb/
vRbzEoHmCYG6Suto0q9ItTq4+/LsAOGlFvGj+2xzHBJhFFEXcXXJh7qNDrKARZfB
zRL/Naz3RtW4Ya6o4Aa07p1lvlINqwy96l2ZGK5SnzuUZ9BAojN8Mpd0n+hI0Dta
xZ9NZ1enRXgONAGxGGSaNMPqjqjOByFwnCIswCsV6AYYSVT+4KYT4ko79Hl4mbq7
LUexiL7useR7n0QX0gd/ISSD1NPoJROFj7fsqLdlTZHLmNLUG8zhUtLi8srr1rs+
USxdZGAjSzaSaGozo7BRJOJJHAMDpcq2b2U1/OClrmwNRaI8fnoOoTImK7VvugB4
xWNw1pS0Ya5ffIl/4S5ADpGW/eKzcWr8W1iTJZIQbYWSrno99n2tQ3S2B9Qpt16m
lnHfrdqSjv/8jazi0Izu4EqgLEM6IDkCEP9PiUz/SiDxq/47OztOobtBbkiV4CGO
8XbhY5gBUiI+oktPTTLCpqUm6uGPiUQOSnkC8xdMoe4KHhrDfPZ6yV8eAKZGuH9N
KHFfKJXHdF87TJZCbZd2XJdQQKm0Xr0RCRJd8XI1YW9AGSL811MACwa9sh1oWuDs
L1o6ia9gObk0460JGPB4EhBbpnvIJ6gp8oMiVbNq29Z+CJSaA/UKi/ctuAm5OLty
WXa1mv1v6/l9eHSXGn5GUxKATScaMEJb53PFul5zHxuRs64TB7ZNpEGga6Fch1Vp
1OJRnjaufbay+o0jAvnvbwH99yisQMWYG8IL+allLjBQvRsZ1ywEomcvZPuqc3kx
dnOP8Wvj8xZlMHMAUTZ9G/Z5ieX75j1NOoY4UeEEAfdzcruB+Iw2TALHjYAsEC5A
jAXbqWeWq/HA0W+Y/vQM/BIsmsf1Cs0t7jw6aZGvnktmx+uY4HKNfUiYE1pvKV99
r2/0ipSvGMeYK3hzCrAk7bSMCaKTRcC/fdpenfkfFc1eG2zCV84fhys5eJjQfLSp
BUXSuzIGEo/Ma+sVO8s2ZxmNByQh4GevHOKB/6vKth1pWWXc5WMghwtdfO4UEuhG
ximkNxPOprLq5jy+GMF/+vSoCF+lJXV6Ih2z+bMG4pOFRDDe+C050VU4D1Nevuy9
y70JDDxBLhLBHcef8/NIxwzvStTMzgSsE5lMiVQFDOV+z6t21BX+oV2SI6S1biPa
MOJtW44GvkiiQtMZfvkSFxADSzrc7UZCfKqrAwyr2Cl660gj6k6jdsgCY5aDU033
2I37WReFpCxO6Al2jw7s0MZN4TqnQBetfdCnRK+oAdrw/OT0jRIwibYNgjkrI2xz
SXp2FBhVztAMZvWcATtv98y96BTnVCMDCPcDZi9xt1YCE+rdMP6adVXIAjmNY/5+
7oQCQ45nugke39LCV3ErFPXjDQ+f7qPyxe+DLZqocbsWqUWBcqzFzYxCq5MQ2g0n
6BKf7sDD8E6DO5o6iKLa4oEDVWipEIiztKczynmFtvCWaKQ7g8q/pJNUqiL13Wpi
73k7UQsQZKviUWxATBt9t6uuqEmIpSTtUrQJ1oTrdzCCXN2uw/P/DRxjfIFUnoLI
qBz09dM7BgBNeTLgsv/eAMc9VVuvlVSXzmq7cia1f5nzUinfTEemwjV+DIzeLdbV
xPUVywHD1kfpyfWuGf9sSDysd4BI5y0RQ4BeTntkMiKIqQzGXCS9tNV9gLe5kODy
TYg1EPUObPT2mdcz5l/mDWtH62XrjsI0HsJni1ug7PVEEp6zDzwzZcA1bWfoxaqF
01NVX9sqWqIKiLb9DyBd+eXBa6X2hlTK51bh8Src4m7gfeFrJT0F8decR9fpt2tu
TC864YVHmBEOMi3VemwJKA1bqyuwPfk+LR2HdH8uQDQH/dc2B1ng8Khuh4k7cIxk
ETwmPn6n8GKblUef6TXlSI2p+lKiEhKqJur2n1xE1bDkEdgzWJJaLjIOgZcE0bm6
0mRVCrpvOL8cK5S52VxR/jsAvc2kM8oigHTgDRMFnopjN0GoZtGq7ZwxGR3HiNe0
uMKMRheYTpmXiIFLVsZjSC+28Jl9ejYRR3StfD6TSSkRwP8CehxxBpA6EOBzm1g/
KbCAk0iR0aliDjhCZp/WvwJmhH+ggRp7PJJEh4136O/SYi/cAw4GJ7pa8AnFAMaZ
8FPnFSbMxEtc2qGH2BiK6sjg/Cb5htRYKEDvE6zxNWEds6Q2XkZchOyt0DDOiUm/
M20CT7gFK3viKwna1yVMDYcBYBkoyOdU3DnhKu3EzTdYnetgNpzechpTb0cI1M3F
YN+Cp6UKF6xrb9sq8CCh/2WxD85CTQESsKtc1FF5lIoLhfTsrYQHd4ml9uDdfKDU
14z8KxOGnKQEDxn0GlgYKrlT/gj9CtqS5JeZHUIpt+Sqm+xq3qDyXTDN1TSeEr2g
I+jYJpOwwSFjxfpX3OHLeVBghrkoVdczfEjGDY8XmLycWjjgHmkAwFC2sPoeU2Jl
trTU1H79IVd516Qjk/u678gjrRmSpo+mI6E9C3s0nLCOL/VMwV5VgNF+sE07b1zt
+EtCXUVURahSTbuKgd1y9AO1nkYGLqZG6+qnQBlKfRch6kcGaq1g7ZrRrFItEiuY
3ohvq7AAaCxaagRBHObtig310SeWE7fCWQN7s2X8+1cNDR8mFcVxUbn00llzlftX
98dfTSOcpLLjWxv0bWN8Gp6AUG7ZzsFBsab87OzhSfBv9cRUmmqk/DCjw84fGPfO
VcA+NLiaHUoXp+zW5ROMsuKe0e3mwSoFrK5ckIfthoNU4zhjJuQlphLUvpFUSaFZ
QA/Vt2OcONFQ39naJz9zeRXf4f1OguTZUylkMQhFZvrH5VgfaHB7Pf7oRx+NwxM2
VCYm4cQg20kXbJ8mH2H7x+dsBEpEVRkH3XdDa2KhE77oYCKuobU9zgxT+EzKGwnd
X4HfsEm+SVVRgB+2d7J6zQ3je6WOgKzWXDYGiAqR3f+HY6hr/JgAdPOMvovrOmZd
YXGMU+xjKo7LOXzoRg/Uwr+Ki4cw+UAbwhLqikI0GviPNK3urbNd42e0nt10+EXK
5+1am6cUKixXqdd0DR8YCe5JXWLY/4q8AevHXHgOvJp/sY/orTF5Gy7nfhDGm+m4
+Umx98Qtpr7OBgzztfChaRP//NGhz1/sW5plY/e6BwawVBJdk/cCC06YkFv+pEvI
avu+JkyQfPFNC9mKChW+sO72FdaSemAKO4GHGiiArXojfX02C/UAHlunJ/qy0Eux
IAp6LOPVzn1t1FOJ2OqGntSJLXYJ42FpP0EH7Cq3Ze1+mhAWRbPODYRHyRMtYrxb
E13CeLi6gGRlBrO+pijW7B/7Eos0EoHV6exUfkPvAXFwKbTPpbcchW2ATEJwI6+U
BcK9NsjhrLnjTeWqpsqw5ni6oSin3NJ9hVyz5CL+oJyIgLQBcxv5Qxc7t06IYCoi
QiE9tUBdD9htZUZk700ZufhmQJ/baWB8rjzP7617g1Unnfu4CvCi/NwXsXW4YFQ8
6QFW7WJiteuyL8Qnoo1LBosomG8GSoEZkieKN1udsSrEkCeUFykCAgholjYlA2On
kOBU4ssDoh//Hafl+C5VAAZ8gnp7VfS0p47irVnCfhqsnnB+SaZBu7ERztKWYJpp
AbEFG4C+FkmHPNiUZZCaqlmhCqsrBhi9lNjtCeOKjh+eHYD0eMRZ3dxtutKZ1OiS
GaIHPBFM58UTdIvmZ0bnS0gR0x2hKsojHeDeJg1GAiLtWKCcZkvty195VaQBi2k8
5+u7EbkRg9rseXIFBZkJpsvYJr7wlAPZ0P1ZGlBEgwo0QYAFzpD0dV/khfw2KXsc
/h/LWtWAYjkFIWEX+qlkCFuW6Dhq0kXFgD2mocv8WouNRKDCx960OeWMeNesCe44
jlxjxyn1XWOtyHE0NsvQ8kgGoMvTBEKFdYJveMnTWiQ+QRifbHZlKPAiPtyaS+gV
XcqrVJAuA8vc93q11PLik+ewnk6+a18nCfbOh85gcMFnI3AEppMaIp0UOs54QqA+
lLE3uGmQjG4L+sGWcUGWbJhM3NTCOE5qj6VqDYNCEm8cmUwooFh6nQ+FOXYbr4q2
QkgjjgQMC4geF356a3c/calLTsSuIEKqsiUEgiduhmaY7j7eYmKPzLzS8cAw1EXF
8VevguPMn3oJSUfgvAgtEPdXe/Ze/jT8+nrlYK+qT+NhDrsLowjIKHD1pfT7891/
mRu33EkkTZMupm8jneNYe6YQSYfqwPbY+rBT/8SRN05NrkW1i42zVtCD/ZpOE8qW
/8hXXKHPDbWhp3likzkJs2WwNAi7+AtSaAHmizJsF/dkq+OFFmsLKSvOvkEEF4fz
n/3U6MO5mieu4TkFXQDRNWKZzyVQk+9NP4cY4K6nxu/E8/X3wE6lKxnX9zBLQVJ+
x0YODcCOTofYIPghqe0XrT6HRX6EABaEpIhybrv2KTfyZ8Sn0bugOTD70sU3m2LF
X0cswddRxy/rcEa6iGbE8cXgQS0QDIOAK9N/2K2ZKaxLqWFGz/Qa60qQNokREcIu
u6KaXatNJ7yd8iLMbpnd7ixTVgvGzWFDrNv7nK5PiRPSvxIFerZTGzPE3FDIDKCX
dvK84jaERM8GaR80PMW5CFfX1lgLs2mLWTtWvoLUn3xK99+go96d5fxN3+LR1HTh
JblZkdT3ldcKGDI6ADDI9p9XvqbCRtmLy6rjnfl193oHm5SPWu6dIVkX6pRpkTr4
zgGpLc+LTMSbFKNY9sNjTxlYAH2kRzliNQ+StmEICGNqUwPiGG8Y1M9eu5N0VZIZ
q4PHe/JOHyOfKjbbF7eNPm7yuvOn8uZMdkkfkcGhBDojjbIH0cHNxfsqQXEUpymz
tGIKvY14qem93Ak2VcPDV5y6isUWrXBPsZDco1PF/fEIDiOIghuzFh85oqOSvc5i
EcCJyafL6OgfHrwVeGls5t84VR2dFVGpzhkVWNctd2rCMqt0WBOeBXynG8LRKbW7
6caLSUgZSVL6eLITr0TupXFsE5C8RqFaNxTQem3spF4EQjFzwNlcgmyv4kZdiDb5
FhQISyDzer4VM76Pa6cD9jZUWvIzi68qmQC1qpZ1eVwI7egRKoOnqRP2dDZkGtFA
mFVB8KMINFl7RMtCCsDwoL6N9JtfbLPU8D1J8+go/5naDMzFQVyQkMbcXmD9qYdR
tX9gLUp5xrUg1nX99Xp/4g3Xu1pHUtQGBSDVf1JTRhiOH7VtJS0pAEeadjC15uun
oDrNQpWKlGIWMxeKkkdND2s+JLOLYyOFY2koUkYsNG7caLZfjbgNeYuuLnzpukMR
RcHbon2+J5khZ5w6wZJDvyNv2PZJ5uVZknZHAHkG6NSc/5+9KiHUZtoIvehqZJ5h
ycFWEsQBM0hPAWX112eySii1SXm9/vTI9XZrae0ianIvuBadBDQzqkCLpKee2a4V
9IwKtpNN9MAh3AZN4YWat2SqYoXCVaoO1rO9LhKD2eIx/VcCh2K8WXeexIMTIhOX
JsizQW9vdjmJym7SQpEr3PyHiG7rAWawO1Xdvde27CV2GAYHd3lvNMd3/qDiQmdE
VtZlTOGO5/CuSDfIkLOTbsID4Qw6jRXtScc2wCLVewZ9FEG5MHuLdWMR5P8bArkD
lVt7EZYHXsI5QRvkxgnqxQwnlbcNu7XfFT89molN5BPIsETGouw1kiT3cIgQdHZx
PtIx+os2224qJIyQxMrt3TUhQyRfOzunq5ca8GNvV378K0ZS/Apa7RVWLddxTHWU
9IHCTFvK9Y5i9T2VuAjUdUl7COL0Om7tFHM6YRDaYopWWnBp0rUiiYpjJKBSlJxP
fK13jk/oKiQiFUvM9x+c1IaCrONTSMJtt4+XBnMww5fgH2MSoJRXbQBlgWDkRNqW
VRz9y1b53bQcNCBHe2uRnc/1yLBzlOLgtaaZd7etzZ3I0inkZlSzO6y1XY8ND/Op
jyvWX8ZP6wR3gBatIzhtjhSZcxBBe1zb+OuBbGRx5vefFGP2cGVPSSOm81JCsPTe
WYw13uCjzDKPP/zdwNU+xLvKw184XIBF9/UibVaSzHy4Olw8sx7sYJShjXcpzN40
xrIyMvaWlc07ostXe7T6l/4uyJdY/vx6nfZuGLncU6mpR4YajEK71arl9gr9aHuR
tCeDHsyeyzKWWeYnM9Bv+3SsAjXLkraF3fGUkgCdO89tjNTuqDcN8IpJCUx2kXQ7
gYSDYEui5KBU/olvf3OoE3kaJGElioNMDwsTUnpVe/XR9hbpE6Ep7vPIb6Re7ce9
/nTQUQ7ZHGnuURF6jioG+oxcOEuJF8PYeZVRbXNBu1n9AzLojm4Hid/JJWTTdLWz
nPz8P/5L1QuJPmmPsxvV0E0AUQ/HAAsL+KE2Wf4pHaanBEf5m+GTDVB9LkKK54Kp
DdZyOT/TA7VSDCbTxZKgn3+KKcs6X0vSmabowSNePc4ahiMibYpgLwNwBct5pfzY
dRtSTDA21XX+DLvnF5DWHX4ej9nzm0mRObsZaiZOZFaCWwUBiMAGv5K8Kko5UCp1
zWWNwwi/V/vRABg2+WBbuukUylYfYBpJpUzRin8RztJAEjJWYPgQ3PvQxMyPbWAR
cW8uKGzsZjid3+X/hRh4axtHf7s2/NEYgEm59HZyhxTPRwi7/NIO295qHQW5dfKH
8Y4NwIdQNVLqpJlxno3Fqh7P2HWQ7sxm5azO2HDczCqByY5nnM+H7AlPkNCdu9Xy
TCfq45yvzHbjpxiw0pIxUAejCRkEFFz6kfe+OpUm3qDRclC2N2rsiWHpr+lfGzil
Vm69yOQI6ISCE/6Nhb0rzPshehZon+PNgKOpHdBV0T1gF5kWobaYQW9sVhPkaPk6
WjNGL1+kkFICnpRNFud4IY6kBO6WmOZ/aeCm4dgzDQo8LWzMD82tIs3OcHftj/wI
f0Ofi1cu8M5hbqTSiBix5xAW3pJORLSSiZV0ojsqAEPQeVfLUXmfz8da/OKbW4h0
y2Upe7tQeetFaiGs4a9xYv4LB8IkOemN1AKBUGCWPYTR1y1QILob9P2N6SycmjaD
NgxkhAgiueT7POXvg9r+csKhtDPMYUXzINEc2f/zaGFcf97UA5zagi+kuDedAG/3
bnlpJ0Sd46dXSG4VF7qGMbLi1X/HPMbaLzYfPMqgRg/uLB4twSXgPXYtnb4SqH/L
2cEEpgJXsddibNVbYWs9RQ4aStyDaF5sJtVqmm6Fw7Z/3BT1mG6s49jjGhguXkOL
lGtAEn7H5LM0Z/IUW5Hrxja/FJJNT1vXaW1+yhRz+1wnnzFQL60gql+NBs6D5Yph
ZENfPalBUexBAkXVXMCuQ3yVvsN3eOm4yPBKujZLgsYjYkgrPS96FLmtotPzwnYN
VfSqcJbn9hf9afm4QUeS/p2qRLLQCVLcxAugU7+TlscrD+/6Ko2fCeEYpQnoLv6O
Sgeb6Bc2ZGMxAVP0lLZUwZR5DyGX16HNzrZugOqPA+PkZId8jZQ2P7C/S/izu6ZV
TXZmn1DvoJewn9na9OWjjgGgDX08k7KxIwBIr99XaH1+Q5xnpE8FfRByQ9Vk7plU
ZsVgi+Skpeb5TYZHI6DXl8Wh0tBJ/PX23mLYHeti3bMCoeC5WuOHZnYDbkaFMhi7
SWtZwn9T2BPGdJykLHZcU7hkKrZv5xsKN8YQ/OOWjqeuc7gdZ1gg4CZ0y9Y7n2sp
FeqaUywKQ9Fl4OY3bTnyukoZbJeijj4bL1sNBdlWtY7drM6aI7HFT/+gLVRFF9ZY
0ee5Pa40EbmJ2VtiAfbq1IvtMZt2UUcxwDBAAtb251ia4d/VNeYCEsC5BlOjn8G2
yjUXgXG0k3y+tj7NQ2GBUdJiODDSL4KILQIL0nafAWpNHT7hPyyUNCMK7NESD3QA
e/60fFVMsu4EMAGs2wXeJ4lfbnSYOCYCj3eiWTtspxE1QofjjTJdOZo+TdvA6edQ
2uGj4hEBcraNmmXYzT7wOv9wWRbDloSFLtGyt+nDNgpK4+gNDT5JJdQhXyjKPsZG
TgX43nnEynhnI6ryUCzKVLplTMJRyxQIYrjKunJ4YYvvINqoQ2pJhDWfPewQ6nfn
4RJ8plE2Iv+2y0SX6BG/y7fSxD9nrRz6gCKEjzFvcbf54mFlYB1WgasLDWqgdxcH
OTahbU8rK/wmRUD9UOaOsF6ZXPf4o2MBeV/3sE/RBGxIIJdvsUc0rM1xcAAVw4YV
9IZQ0lAnssSXvAgEZKyYMldnRvq2rWE0fPIGG08nN3zCLt95leF9uh7IYXHYksP5
AvKBCHP6ge1fL6FC+MNdH1HfNVzwlbnQbUYlN2OTDfTVE0lfSBOKxeLEd20QP+1d
2TasdA8ohiK3OmNwP72vq4cDG6XKLHtULOnMq7O3cG4375luY+5uetYJRHmsywyi
K0pwppg112ooma9cOOlnrdE3IvEWc+Q5q5cclHlXTnew758z00JeiFVRyi2TFx42
Y+srxVpUL6UHssy/MP7VGCgfRk0v4nabp9m9MHfu1h0ttS5Ksdyxjwsn51NS11ry
EeYjilGo2BanbgfX7be3MtNusVUI+QWTOsBEIgwg9kHEJy3tEknrLZXBPTMXX4Kb
853RnJP0FMr99PJin85DVqrostr6Cz7okblccHci1E2cjI1+ePl9AOM2Hyx7NcE6
Brl1BXExPHXa6W8lWN0hh1qrtpNDMeeVE5cEsg2pvUuonYkFyQja7nixCOfUjD5p
zmN+rC1i0xpG5X+IojR90FjKlYD1Ts5z7pjtIeSM299spgxsZe+l/qRfO08G5N87
5sRI8gjsJJauV+tZ2HFaxm2SIvTR4lqM8tyR8B4bAdixjfdHbpVYejL+meAnXGf9
yUYCbUfuaUpzUJPVKL3lQjxpBagLKcEm8fc+Psf0fshUD9fXTIgHrQcej/XbiPqR
gzHWoTuPT2AUKEyJjoWH+4JUFaAyCqOveXZBYtH19M3glS5Hhi71uDVQf6o185cO
dRAa8AMaGJXF1i9K4fzHCUKUJGuJs3SHUC0DhNUU3jjQastdWBZnueAMOPlqDtmX
boSQehw7Kq3+bSwaG1bmA7LsS5VSeIx00asRgiLwldhOoQdE8tg3MVcaRN/GLxIs
qoa86OUyn4qgKOKJxVkwwISCOUUwsdkmF6EpZG9R3IGNndJ9mRNJ6gMzqQorF/MH
tlZ0jRWLUwKICvEhp/bN/1TnxpbUBKsocImx9xSqBI41i2VIcLq4G8nzivP1eQoG
+ZKpQbIDr/8uQMIHYd/4JiurxjRDFI42+osD0sY6aihJ2oIhSFbaaIngMhow11xi
p/LErGl9WW9bz9RDeRxrtoXG0q9X3DoHVXuwbNn04gaQgc2k5ZUQ0rcJHLCTgb8i
XB3dUBlHhN9awIiFr4vGDSQBWLlD2iatHw7bilY4+s2tka6JLw2HrRDC4KE1jL5W
CvOM8WkmTQ34QNf9Ry+1032n2Vy+ExVqB60HiUe9cTL1orvSKb+WbFOYE5dQoWin
v81ZqyAQTyB92EEU9QW7+jCixeT6fzNoAkEtgnwUwogpFlxOLSXg/3logwwpmApR
Oy8IM7ZmRhJ7Je7TwEOAQeB0pdp9dXMrsb/o9EvVvvXNiyH+ldAgKVszxPRBiFFC
nBA19wQH4mrmU7biS2vpsqLI0FtNV1gXpx0rgC/2u/LU2XYtOonU6SsTftm+e30m
j3ntUlphySqLEbKM5uSBvRzJdXNxm38RMRXNcUh2SroT6vlKL540aizkTCmjtZZ8
0ku3gab43eGqdX5Dnf6bVHn1XPA3MNw6YkPscbQDw6gLqXNL1FAfXLPwtFS+GBpd
oxXDolM9wSNV9D5+SbNSE333cnVxI2KuIf4P9+fZ1BHq5pJpB1b5JWPKUxpTpHB5
QjG2rBQlgadNQQUYO0H/4bWzF3WppI+IuURHJOodprgOLhQlksg36nbTd+OKTC/2
BaNzv3CRsdZzLw5vREm1TKCNv756GRZ9tMva4hevfnrWyhbwnhWp9Z5KSsk+9G9L
G7lLzP0hFwr2RbS5MUJG5f4AMHm0YX2mlSyaKjE9ouCfve12mvrFYtGSwLqMERUT
t2V3k9dQIxFAJHVYw/mRXbfwyJL0KyP5BspXzDSbDTaSRG3ql3LUnTP++AtUwvDy
zZyy3CcumraeX1/5uj3EcklmCxCv8JHpz7s+g85a/jPyOyUGbUK9dLWdVsYc1vG6
lPR+ZOzvYdw8UKMIfdcsbLjmigjrgCKLn9Ims/8cplbUvUiv4yPp4RdkJdVK0hnk
xYv7B9eyvpjCJe23+IZVr/eibieQls0Cr4ouMZswSqP9hbzS6UZvNbMngOfl84tk
pi1OUD1VBgdTwGam3UrArarzB2w+Tv7ZcHYr7qssiYKwBY/dy2Z2UcXOvU0vzkuE
4+/EZEuwQp7JuBgzKKzFqOlnA1coOxAODpPmneQ8E48qdER+JJswJwZwThidfZTo
IGhRi4pa8ovEE2pFbcDAnTEcFVNzK87ZjAd9CLwxYBWcNqlDqAhRMXhxkC+Xn2sC
q++YpU+2bWdBFPeI+rKypm5fZVqOyx8sSTjCDw/D8Kb3eN0TBYPfkBuIoCyaXTE4
pvEpk0TSkSWYsj2d3Lr6uWDVTk07YlCQASJcrUMZEO3LqxYlfa6VC2mJsvu3t2Rg
BswXSz7xdFsydR4BWtS296qygaxlsIqhMzFkgdT2Sh2HTZsz8glbU/waL5Roueb8
Mn0VcPwUi+LA6RJBAzEfC/9XDK7vFw8l6Wj8pUbTHFDGioz2t7qxnWH/dV22D2D3
j2vXZT8XEkS1WvHSySkQuwzFagg8bTP6BGHv+vrjz5ZAkElLRlrsraeGZdqH6fX/
6VOOQLXtlD7kiFE+7+7QMZiTLqyBYP2jap5uJvfQxYKRYorId2C98aPdRrTe4CPr
AZ+zNSIrpUik9thpKDEB9h4lGiYh/l+4ehxlZq6mfEh2FVbUK0Cpw2o8RUkMhiqP
fCpWEwXsLXX6J0m1iujFt7+6WqLEQs7RE+TVF34fNkkqaqKBaqSGP8gY0PhBJG/9
KOxv1t3Pz0fAHet2hrxhdGmGXhyND+l/2n7p/K8mRc1Fm+L4kF8H9ea4Of+FW4uA
vXGyv/6cMAcSY4Nu79Xfr0ZKGk1O/7hrCGu1OECwYfGe1E4r/UKfBCz7AkHvMzvP
ZWSDx9lRflvAdVI3P1vQRHOsu4ME2EpUfuHuw5km91BkWbGkbDvMkqApk5zmDzE3
G+7mmxdz5BMx8gBepjEOZ/lMyk3b79EUVnmBlXG+U+5zGf7MvO0zanXaYMsfQQjD
tEbrOp4AJ/JJ/EFTs7z9AK0068O6+uw4NtMrWzNMFAS1cmNxhS1XCEVg7DIlxISM
p4YUltF/ucFqrW0h0pN1/5wdtiIOOceC+AoX6gwR8Oi240Z3zMZA4Gcb/aemZ5/H
002odz5pAlmjk1Wxbuffb5G4CQ6KwFgW7MGa8guvujTHgHdNA3A3l1+mGP4Wf+yN
bDnx3Ec7Ck5DoJHSZDKOLDGFr09wJOm4PMol0rVRucPkOtpuET7V8LGihf0lqKxx
anTOIabnwx8HvKhJxvz6iXULXz1/Jrh2GvTIrNM03VfDnvQtAJtoOsh7Xg1aMg7/
xyebRCvFKorbispDeJdijyqHMw3jPfw6OtThkJbFbN9WiyCBIiKvPqsVjZtLAZZP
ZNtq7XINNGft89UGoW4axhE/hgJ2p1Hyvwgm8n4vbAsr5s2MCu5aQO+WljrmE04O
FV8YLESSzzZniJ/q2zBBMNZIgaoyuSfvGlqqHghISKyZia8Ohom7iPVeNe2XyLwP
pS1++CWPMxP2bXNwcHGavrel1E7635mnbEUC1L2AbgH+4mp5eso90SiJY2FDJnHK
7XzTdhSGIXlYSgKrbQI3DJ2m0Oy0VNxyPMplW/KY/2GmFnDoABaqj28jBXamaCJt
xuA5N9GVfg3ZK3PTor1NoQ1/Fwxtf00CQYIPsKUmvttsmc/XIZmJkFaT08regumQ
rlzXd6/iBMeDUL17OCE22bNWinAgtZbKbCK9FgFEsolJdQoz5zVFupv8Jc94ZL+u
cECqk1zOn7CZABSNQwnuz+jL8KL24ODcDVjBIb/VWSwr2v3DVHDHpjDgz8huTGEX
PBw9fIFA1VxsczACSQDDiq0ZEmrZveXQ/cR7BWtZh/Wnlshm2jDS8rRNu6H4AbnQ
kLJnSmul+fy3Hyy+eN4cMMlZmxSGqbdkKjaAxkfMX3irXynwwAn4JDAnDYbvzBvt
1H6XZs7jU7qgSaW+r8Y5pAZSR1s32RMEhcFT1GcgoC1OfE1iNrlAZno0yo1y0tf/
1TqWnqgVTvf2Yle6nrRViLf4rZzPqEuDp/Fh5MHYbwb3lw70/ExJldu+yRUiFhnD
LzPqTwkKd1E3RyTcAJ8GOqm6qxKjcljlWpbWr6x0mk7bt23Cb+IFMPQpWU3q82pg
BeaKnidW751bKS/xGyYfq+QwaHxu5sxXIomV0uBpejPKUJeNVIzeXf9ZlUnbpOB2
qHc7FfJ9V4dIEk/t5x2FLeDwo5HTNAjqFMWyUh/EYIX6GctoHncD6tvV1qpThldx
aBPaZn9UUVML/zrEXMn8jelMRN8xXI7ORUJ+52So6xnBYPpxRpJaA63rp5gIOply
0Km9302MZ2Byv7w/gsZTVfbfnsp3RuCmpc9PAEaclJw1SXTuXTT+bQfp2POTq5/c
yQIotvgJAgkJIWjzkQZU5d8e7647cHOW2GA2A0cJZWeThgYAM5SdSCcMldITIwsO
YooqP5mjNwMHr2MH+M5v2kyR9lgilRdRBWo6hTot5+X1NBs7Xi7X+x6dJvAc1fdV
6ZlVDDVYVeHXtoZq7aGwEqyqRj3GIcRIsGAGu0V6aOwnmZe9UzObb3+j6gp5QHoG
9A2u02AVeMA0frDxmmEilGo6fClQBxymsTiSpGOjOnaxk271CSjLM7SGPGlsFMwa
lWnNfAGPRlhKVsatA+AYNDofLKiSltG3qKBP/d1gtnLXL3OfIaOjhmPOkh0Qm/ZO
CU4oD6g9JyRf4RElfH8MdGnM9F91B9BMgfD3Y9t30jk6mkvFOTAcjgnsLRPBpRO1
FoUsEvc06R3FZpBcDziqNpxStL1iEyYg608dfEYBitcQbkn1DhUxdgi+csFimMMA
bVk5ZqlO6kExcgE4rmKqfuXLpCT+Kf5736K6Eq33/4NNwta/pvrE/D/frpSnDlPK
edFrMd+0/zzLqCTH4Hhq5CTKXqLXqT89XZTALZNXFwM+8UU83gwl0mmq/3iqez/H
3IN/MSkrpNbIOXkHWRby1wCBcweAjyq9o5EY/7N+ItbLk3q2kzUgvt2GVW+l1DCE
/62NhxBZfB+d3JeF7pw66IykcT+++4GXp9wdnlHx/bggUb/wfq7obCBvDXqohc5q
1JfsoXKEB4uJz7nU01ugaEA5mbnK610539JzivxnvaMDv5BWSDb6loL9PbZ4sVw4
vC/Y5oCNIEaB5Zls5u+c/GU7RXmGXEBuCoViomIiRXTM4/yNvzs4QgmS9kNmlz77
/Dw1lEcV8Nd7YHNJ5KcHwCkyHNRMMyqbD7lfEGKYXyPLdvq7kq9b1f5wuOstr0si
hTEqygx8YWyX89H6zTHgB1FHHOtuWnwzoN8DtRqgbsMPwTQ31jS8NSr2XuIpD7DS
MZgiTdKdN8mTeepjf7W60G8JpEow13lT1epwabqIW7k9fB4P8mj1wxpTxkxk7/ki
DsHHlB43TPwNVKdyWCetRq8J4xoV6GI8JCZY9wMWIjvAFlkuIFbTNIiyx1kqmnT3
xwaBYZYwKWdSRpdDLlFkZgwPNWTphrp/yamYeXWcJ2nIisqplAZ3Qhn+HfCOnabV
l55gfMC3OJVxxDQ/E7+ju6NoJD075W8ynE3WS00y0laf0UDgVVeReaT4VCpisbY+
5CqJ2sbM04LOSvqyaCg5XWjAjSvbKf/1rABOy/izwcBw5YWGP3RfZ82qKTAFGzZu
3kf5U2kTz/nKJcwhFbh5Q3Zv48GvI5b/wmh/uiArSsJyeC7kQuku08vUMkC152dZ
PT1NGzNDQAr8sEpLYIygl2tNRGuHzDo2ePvuZbQw4gRhnWQngjpuvDnEIj1Tgym8
peSHxREMnwksiAzMVqTcnqFpHu4vaiVGBu1YGyj1a8sREZ+Q0xFYNJ10PeYASXXD
0kU77dvmBUjPZjtWcmaQOhZrntR7nFYQMPm8ZCiTV/wZFyCY6BToEU7DiOLADfeu
jDRKoFMKW12orb05QHenm4KPxMQTgqzko/j8vcrjjYZJi9CaIHZIQyiNBxqnyjr2
qEzRiiByu15rGsc8UMhgs/Y5Rinki1lxda67XNuPkTLlA83i6PZHHtdfgiyR2zfc
kDP2YcQw9xUKY4Lq85/Y3dwINy6vH8kqZCHiAtNCvwgqx3xESnGT3jOr8U8StXR/
iKNlfokHtrVmGuKtON/Olf5XKpMFL7VfLn+oz2YmkocBgFTVBwgZZbpqKMnNrL3G
gpZYl3dVn9zCw74rivdfj5QYqQW8rsjr6E5i0k+2vp5nL/HgHDH9rlquQmmqWFc9
snkt6GNkTlpPOrOaHTwPJ8rlu0W/pWcGlVly66+EqRAL6DUmW4BRmC2t2+v5Xkck
3HbANrZByJDzRvfq4E3SN5hpgEJAQRZcoCXJXnCSVSe+oEVA2vHTWSe9IEapwM1e
oAJb8KQ3lfMFPPr28hYyDXXTZOkeRrE9E+c6thMaSM6LMrKPQWDM8Z1Oj4ylWK1Z
3Nrf1jZ00Y2eKzyPGY54Sz8X3A4a7wpTHEQZXZ0XP5KfTgJwNlN42iWnOdK6kKmV
BMf+jr943vwbyRmIVrobxFj6tg8UkFHxTnB2ZjwnhXw9neMiYCQVUIi27vMrkZ63
E2A1tf7n0YEk2Pa8HXhgNtff6T7Jz3pW3qlggVUvCCzLbRlBd3H9GxugJMPH9gJq
0cpoIZwywDg0zLxhrg7zbV4K0jDLLqm71mX4OVJ9M7bMGzbXIlGbCM7aR8qS3L3I
U57ao4O6rlOKgZ8h+QZwiTtUxzJf96dcNGEorb6eDycv6mCea5EILa/zTsFB2iku
+95xlwzEFCNr53i0t7zvHug/o6VEr/RaIKqDfNlRYKTnMZQjS7Yhz0yk0S40Q30E
/H2RSg+dXbpfAZSmR9olIfW3HLEqrhwPEXFbYiGRh3q962CkoMQjrNSNshqGPG24
jKnEQ+SACunQU+J/4wz8lCAHxGsWjxVJ+VIrUmurs4X8mj0Zs7SC4seFO3ujyjFY
aV2WXdkImVpA+LNMQ4N6KD9GgWjh+TBAoVo0tMqKXCJLdsU7jrLAtkiXC/vUWF0K
ObeFPzcoOVk9WMkxYRhxNKHlgefnLK+gYyJmDn3u5RHvTe74MZuB0FIcwpc2VFUQ
2uiaw+g2UF0jy+sC4uEmPdo8TN+8NZy2ZrDMWFQ1FDZb+XWxJA9V/pU2LBAi5gqK
0VHIhuQCdPEefKtssOz0XidiRiut0AuTfLSd41Zpbp8EOcV+BJ69DGLo9KTa8cQK
odNIpwVyy1gIf0jAEyNJDfkL/UJWVWFC3pieAhkH686RuAFOk3I3i/VjSTgUQI8S
7OI0Qi96fYpqZxqxdruPxarC9si9yemR+wzYbj65Tl8qQjAJSTRXvUswU2OE/Tg1
TUw4VvzgRmbhBu3jKyAmeYj/0UmAAof5m7pL5NILsTxtl8s4+P8xXlV70HMo+vyC
HCrYPOjOldEB+26d7RBGeW036y3Ff3eEmEJXX6DI7vOhKSXrSDlGIIRqiWcqFH8C
TcC/H/LdkdV6sSYHlArt22kuTmEWmPDMe7JEda7mcPm71E3l9g49NW8XEIu6Bdg1
zK0ulLjLNmMkoaDFL89swlGJOzR21EmsoRQPtCgySrWSJZii/9aRptJ/9SeIoO8a
WGx6cHH27zXvoNI8uGvlZlEk+b7ivI9wnoxsPs7stAYoxJDADWky0gibUNI9NPj1
AZeJdmBfSLZlDYlUBDUvUWoMxQ7tN4tZXFX/mF/Buh4lWAyh2czUyauHGhTlUFCS
1fPKV4a2xPg6i17KCLfUM4X23Kl7pKqafVW4J9Q6xeYdXMk45oU4PI9gQGTnNWGl
gu4R9GvZzwk3v6CCVAu/JLDKXyB/9p1iPefmjH+x8rUjYoBY6etpki2sjFBoKj2e
IDEw3kXq4aVvcgetZ2vvJIyVsqm/j5YW/CCROkr0gBVV55YYWK8Wsy3MdDm1gyOe
tKfDEmpmWaGVsI7Is6BgpLRaGAuiLNnaG50zQ0enDP39JekpE4KWIDfrNHX4yz4a
NDHGe8ryLQ759gcBeFH+oNSPiXaZpJ2WslYIeV3maUHZU7T3Yzo8K+0he5eA15nt
U3dCiw4ybzlwu9rSgoFepY7bzhuql7fM7clU+KhGVT4/++g5rYD6anG+B++bRVBQ
OxNrnptw8KZtxbxSsIemwPNGs5fF/UFJaRaVDXj95URkQ0kNEBPJDxZlqf+LiT0t
BuXzdrTRsHDZPyfvrbNrI3es79Wvb+aJ5HbXDJoPvdkoWgHrVNzDYxzzZge4Jbip
DRDYYURexOayjrdxBIxVn5+U4NCq5SLksp+N04BMt71RmdJI4U1976OL+LEfWBj4
jlj7Sej23lDjzu0UocEEFolSwxYSLNlTqhlUD5x9YOpdAUD240p4i1wbYinnayWU
Kyh51P+jj8sYeFvDN/gEkvYr0+AB6VqhgDDYLTni1jnPqN3NQgU7xFfJAX1XKZRW
Lkfro7uc9qEBDK8zayNmW7KDScQikTrVD6BqQ7FxSLRsYxFywbltCHj8a2e8BTcm
c3Q8N2hN/zq6x6UdZUJF/7n4FY/vOzPjEDOImNTebJIZhC5AqBSuqlYaGRoAhCsq
9sjm6phzePKJ6A5LgvNQ/OOZX+nfbVKOqD3pdpfM2l77P6CR5bV32Vt9bFA1cv82
alR1dH6ICmMqKYhO3/rU6k8U21Jp0fxzhw3Ancdy7ZkQf3crxGsWGmwjoXC6FcfA
IKeKJ4fuxDi8y3t4SOXrY1yqXM98XMy72dObffcg6hBdC9qWyWZo0dWYuHKLLitQ
5Fzdrxkd2HDYUO4aM+mHST97P7Yzdlo4HKK0TJR6zfifitvZO/PDOFMd+r20J0G1
SnWwfneIN0R94KoNbZcbkHYs7HWpQcgYkeeIG0B1emSIzCf+kFdonbse8rSUfIbJ
jhTS6PgFxJ3RArHBUB7WfwlId+cahFBKaazAhNMlZs1FrGXmjcsIkIuF27l24WHB
xXD1sTQjV7WFfZPRiBkvV7H3Qqw+gNlzb0CC6IiBwTEgUmFQkKGjeMzkw8L/7I7/
dZq4mu9ZGj5/6FsKvVr4mawPUURqgLmbXnBJ5s97xqmIcyT4v+FonjCQxyk+xphF
iLKM61J2OVF1Y0SLiMFgckK209Dn7Dn/cILqqxpXH5N6Orls0yC7YEXNv8OSfA0p
Pvr0Vb/B7aeu67c8dc8oHt6/pQjT/BAZ6VTtLru54gZ/N432Us9m1djkUtQXg6kD
YNFg2t/9n7dxKJi8AR53PRHrLVYDXjO94LXh8mEci1emf0JkCXSa6rNZGfF4KBMx
+Sx+FZf1Qze5xTAogmFXppOiZNinHb8Jm8QUBm6ru8lgLZIO2rVOx+YqfUxBR2eZ
TRAcCiEK7xWklgXcFElchy/pYvizQ89rpWmwuDH4HvTXrk4Haty4/LV4ZtIDJbUv
rFB9vbyOoKmmZy5YJ1QgzityGbitJNbRXvsrluOyTfMKU1KHk2nejPsBTxStB3uM
8IF5VWnFIPATMHTiEKOlggIHy0YDhY1PaibBxbZZGpEfj9xQs2NZ+5GzQnAg5Wln
Q9WNE6pECv05SSoTHfNbV42uALH0sJgWlKtM0jps1OSe0gLz1imMOwr2DmyL6CNU
A+H+MizdwvYqB6WZEw/ihkNVQQCTCRMJQJ0NZkQEpL+ped+pS69PKxZF/Tkh8MBA
kZcvxsBS0xp4O+IqIhDU+97YGH1Y5wj+SKDf05sU8b7JMzzkTUIiO0epWTE8jyHE
4bqbUNPBHdnnT0a+R9fG7qA55tNtl5NaPByPlj+WU+vHm5kzIKmLhwBGRlcKnGgn
l9YXjjXcWajHLx1aYrrf0iSmSWcVT/deDbCLis62op5iCOQgByMydcYqAK1AiNXZ
FsHYii+17hi1+wM3HNdxNGWIHcoj9tlHsfQiqNXvgvGLEw1/Ac5HKkDSEmtMHf5a
Hwh264/8dbHlEDBfx7sKr3ZS9RLPbdsSF1HAKmOnYNavBe3zPXp5snGNYSw1cfHc
NMKWwwGzu5H19mPT2SNi4FgI4pozcjzSTQ1D6BjMRHleaDeBMuCSYik++Vy5gaLq
bZpJ3nV22wCQBDEl4GQ0CsDUUKPcRdU7oo1Mn5CDidnF9q0XDbPQlxaAzyCjHEJM
dnZmhbR9ZMJMgsmAZ9RABUakI2IRei9hn/SKg9FQ22AoN9zP2qKhTh3cDGWU0gz8
U4PW+sb2XG64uRsv6hMu2pI0bDKM7343XMID4/YtmWxDFun0UuyQ7svZG+95gBXc
T2MgqUfvMJc33C4fSZNoNQnXbo8CyoKU2Q2KnAIbsXjFbByWT0JuVMNrZWahMETp
j9oQT5YJEASYLnEp3ewcfMya6ynVJDUXICssdXwgUwsIcpPxLL9ByY9PE2VU9efO
iC9+3Wxptk08vIqmpiFNaYFfwc6GK20cxU/A7hC58VOjzn+kHirw9AZu8hk6a3Cc
++a05ngsDWIfjmntUTgxEEOheVXHxTPqtQ/u27cVj5VuOOoaXj8DW3h0/5L9zYq6
JXK58GsG2mTeJGSZ+/0F7UdwoCtXUkUq99OEboZFF/HBa1GCT1UW0jkfYtgLax6k
f8YF0eJldp3CDp7dKVn4B+8DiU3vWzeOnw/agJKlI0TESVXXxiDBMOvKWpenBcRG
bZyvp3xudwOdznVmA/d4TMHk5mqhlmnTCX/iBvy9Ha5P9PGnH62cgmV354/Ht3a4
Ip4L+sFzjaLc3iUOnQVg847Ufsn+ULXeS+0ahq9bg9D3xcHAmYHrDCyAXAn8vhtn
RUG4gtYJCjbfPRhJZLbsVPoSA9/snC42VT/PrsFqFbMVIVzOCqdOgqtkWoKAEpJk
ZDNWntO+HjwuAxgU8DHNPq22pvDAoCo2zWggt53zXcPSrsF8ysmpzJbJZpD4wC13
JQU4TYHcZL/D1nTrToV3xNHWLVNJYJ0erUENd27VJ2SyalBWulnhqdA5OR2e8yXR
05l9gvtIEiRuPWR0IW+fEct74b8fh5B6TR+RHnxDPgwZxDPLkD13kEw75+Ov9XEd
TnMvkyfczjY4xgOm1DSnBkDgpdnoKvWcn3hQkDmqha9ifEiVbPSglDX6875m6HFi
qu6llQBdBKNavqpJi9wYVnMQVz96OxCqyhKtaZMS/S4Ti0ZFqIvCmhJihv4uK5B6
NpDnvqUcuahv/K9stg7M7GVCURhOdZQmoGNLgPy2RunRvXrx8YoC7SiBzcZPr7h7
opECK7ETNGG16gUyzhv6Tahq3eGMt9O2ukSkOpxgw1dH2ozk79fmNqY6db6Tp9qa
NZr7HWDp1K+0VljwRhdATCOn1qIZkiJKHNH9+dm9HF4IZm9v0G0FWVamzQDMb/m1
Qnl1c1VlXFrSyWgxTBccpnjQQkmmb3Ew/wfxDiiY41cUgYbSMRIG76D5V4pXJwiI
ZW97GxPdmZIuzB9hBfGsq84dP2W3vvveLWobjINxoay3ZtEtC9S78u9EXfeSnAT9
RPgPigNGfWqSLS4eIFLjtTLVD8CFBUyG6nnYpheraYgBGY7/AXvwjp3OKJS8x8mc
rlW/bDAA7LkAAEoDAlDvd/WfaUkWg78RPICjhpTBlkoCUI4jInLNRtSjM80tChda
bSqmL172AmfugYBIc+yDnE0qDnHOGWlo1FRCCZABz/qpQRjve0AoKb/dTR3V3hy5
YARvDdxObMOXSruaqPPUZTNHooOPPY7jh28QtHvMxaG5aybuyE6s2uIENN+kjSMg
0tVwYNQRnCbN6BreiXHrFlp7o3dLxjfIo95w3bFUmuwYtcE/lpZMkpJQeMd1U4zC
+hdQ5DP6mS1RhFccgffEq841/lWgYfxVQpKiw0IXP9eoNJi6xqQX7/yHLn7OccYi
MUc/iz+3P+jwhW+CVR6xr9LhZ1XlsHEb1MGINCuMt1nPz72hTyMep/ggwH7RdAlL
y1APA9OFr95OB8vUupIy3tbb7NZpcLy2HPEV57SEOJK8Chry0BDvkjwGu+7PEONv
dniXPo0k7p+RZDrrkspdSC79PlUYKNtIV6Bp+pwDGYGi9iLdsrJl7i/pIq2uDWsE
EMMWrCEL3uSL/DVN6Pinh78MartrM+p/LL8EGgVjRjlHSh6CWi1n+oXaQJOgDdL0
IgyyU5FIMduJsIBYtHzaXhciLIwm8PAv2YNpec0PuQawiiubESQfrAizoJHLJkJ2
VhY49rbWjUTDyFez3CyXweC6mhA/L1VL6bqKEe9Hjx/hVKxeUcIaYlGN+Lc2V0D6
pDSOlYhL5L9jY+64S+6pvQ3ctVsPLTOOx2Tx8CWuadttaXCDHpRTsRaPjS/0gumn
AD8lFrPhy1X9PoAN3KaMZxEuY58hbVJHXtHcLyu6xAiXuWaJnkKA7mD3M24kfEkT
UDLDl5OxGmjrGOTEHL1luen48DggP2wWlCte9hVC39HDwl1i1n6yIBvIAzf1zK9E
wU3Oa43AT5BDMLMHbGYTlmKY3sF2wGMRxNC8qfLmKfVzA82KcEzfe6oy8/A4P93U
1tq+EGmL9mdzu5ZsmI+0lDlq/yEX3HG8pfscz9k3o0NzBL6f7TakzVqZq0fuYpXB
KkmBdtk3Cs7m9ChJF7Y7c2MnYdi6qzKw/2DCUZrCqeWl6zxceBgaO0Y/ubIiscFk
wsVmr7FzekGklD0XhjWb2oBbDf0uNXs5V9K/YNIGKFmd7bn9UJ15A3Koijt/WUsO
icHjihhT7ZnC68insnrGVG+2Bghi4omPIOt43REucMvsvmCUXoEP7O3tYbi3xAtE
3hQ2Rfb+b2r65h56vNn2nwoUVSIErYseWyqCh8vYhBKUaL0Xns/jEyk/YVeM7SiL
bh57OFdmtDAD3zbH1ARN0jUJ7rXjzlcmrqiQCVLeeMfwhTfINKl+szjpZyACcuUT
/CZmgFDY5psOD9KQ+waR/WO7xPiWFDwvhQZprkolB5b9eqzdvrRXiZXFWs3L5K9B
eAaAqKaBnhi1rP6+GvDeQ4ksDhrYhh8rSgzO7/c1799BMMrJ4ye4GQGy+2/+CIog
/ynMLEnFp8aPrd7BZ2GPK5XC1+N9mAU24KNT2qWxdkKs9Ys6+b9+4fxjBbVs8Mde
2xjLkcF+7xNaqFhA1YBNcPlOIqyqYxPkiFczLbqW6I58RhKGNIQ07CUN/sO7VkpM
AtResVYrYhkGg4Qzi7Q1p1e31XLU+0lIiAFxnbOtH85eRM0dLK1Ul4f1DIKOPxE8
K32TL3aFjwl/nUwGGdVCCvpwnEpgDwU37xmUPOP207PTVAKNPTAwrEFZRmXipFCB
f1zEgfxVBhzPXvT/mpdygAlDXN9SqIjaqJ6XLiWeVjMoQpU6bfSHFvWKv7t+T8z4
EV+yx/IlaBjwM4u6/WOjplASaVgEaxxwxITB0lmS0WOYB0dgWMpMtQPOUwaMvCJU
VWeEEr+ueySWkwaEN8386tvU0JmO8mOX9x/uKIwXBDd0Xfg1T1IS68uCDFoKgKc/
7v2zaXCJVfwYbUSoxMb7GtMaNsj/9KY9EWLyuwyXuo0XUXwxF9GkLcK0Ulm5fCe0
p23JlCPmJWyvSOf3PeIo+g6c5uKL85+2hd8FN6WlytzYagWz8MkfRIUexam0rvWf
AhiK7+YRHA30lZGVfPqkarKqRWbw9sJ5ZC0pjiXbApcurW0yWbJ9OR2KLOOE7vnK
tohxeU8uD5FdrvugUdnvy+YeoG3XY+SP6mAe3X8q4/ZDX6QT1gnD0VeUhBjv8Ik/
UHLM+8WxG1jQX54pRkTUQSq2K7A+62YNwFoNSJdfQbLS9hNTXlFKt2is9Q+gMNeE
FBKYsp59/xxUCE9kplPjJNyhhY6taJpzrhY3OdorV+eSTvUIOwhVbhD6J1ad9F8k
JnT6nS40O1AQlxU+MC2IEvr774sLO/9pI2j0qm7sPamLsCXOMFsoNtZ5TA2GTTcs
5JM4KQlfS6SNaEskjsIRTzqsCgzoWUn2q+TP/rzPs3queMtZwyFUcZTt5N2tOGYs
Pk5PJsJPEARkHYBvonyOs41kCNq6Phc1F4xycdWOOOcAjlH3Nu5vCSBECDgKkdAH
R34Z6fV1m39YB+eM1DVhSzDT1NzbGgTOJ7yoYBndYuFEXOOQSnuzXECcKKfM8bgi
5lo/E3SORB42GzbbY1Crx5CM0mWIa7w6+kteIA7VirW1e57U8fYXUb2Lvnz7PiYH
036s625jsNIGbLCqaLFVRRG2z7k58zBQgnSWfFmRk8vUkjxbLOkNNCxU9uPFkfir
KmsGraL65EKb0RutkVN1U9AJ2w8dVYFunwxVnbgMBV7rB5zmZRXRZGbBNlOV0NNe
1mT018xs436OIhsK/Ji56wGkp+d30WSyLRp1RENlDLNbq8kTAJlaPCCO84l7vqLL
Smt3CClbaOuBEXTBHg3brAEH32zJNwOSRCq5JdZhgF+ozV9u14yWV3FQtAGdEf8n
0A3gte12xT/Z54i46XfO6Gs6mfZdz/TtQuWxOdfyQsEHz62brA92QhidFVfCzHrB
hHbvt0RQk5JgCc4w+cWBOeIYV97ahgxbhN4KgsakBfl0nvKz1jY0Vqn28zfUWJZz
oV4qrBUxD/hAitFVWm/Sg400VGCvKsBkMlhCaP36fuIqlIW4x2mbDsceUtw04CeM
H1lO8JWXIL7yhBOfihSHB3M2Zwu36gO1DOsV+h390h8lV1dQIb52DsGDSw3JbwKl
VKsl8OxgRHviMx6DVRwOHro69BcRN4q/VCDWhSsYjNpW0m+GUYfNyjUZ3rkKhMau
n7khxnrmgmBB17JuY8gDqG+O34PxZWxFWxxC9B61H+qOAAbZxAWG2/HWIpLjh4a8
Rn07V3JvcaKDBfI3GV0MfY0PFdlfl+Om/6K1+toVn+6UDIYZhGPb6p7Ljnh6lGK6
ftJO2WPeneEWhGX/9WgOT1tcvbURf4cb4wpNXyyO49loi1c4+yINwHUGCF1E2QiB
nJt/bdta8efeV71wO7PoL3StrLMi1QmfbYJcYWFBUV4Nlg+kPJgQyXsBs6j5cP2/
HcPIts2XsPMkTlG0kr3RjMZOPex98W6GWC4EvSOl1pd80iph0fFaV5lrRZgoQqFe
+z6n7AhjV04owWaTrIUqxuUeEgaGwsgliE0osFjLyZv+heGiKOAbVIw+kDvlhxVj
oGex8379xIeF1t+SA46FctdjGujFRnQUTlg4RiXEoq7Mnmt6nsVKTDrHriG7j/Z3
C2w60ptzgNgmgDiUxd6LpWalfKe/SvEdEsvpG9mOWQzdvawN+ljMRovb8c+A2lN/
YroNdCEas0vuXzPWGjwnJb71Jabjkq7dNMyRPwu5lz/AaYwLBHsen8EaeQNdsZLt
PWFTHXbussuJcAIsx0MbKhNRas6II1YokwU4o81TuwJNZPCi4LQnHXdt4RFiLN2A
a4f4KxiIlfWiXWz6Bs7LO905wxRPeuS9VPBw0aTzWSH9l94g5YNiP+Cfj64wPOKe
bK28s6q7cQjtpYuVEx4fnOb5OdQZDOibae6btxicwwLCCFCaunsden4tdDV0Zcmo
A8cxxJYTnMTszQnITXGasPz/1bpMzyPicrgNtHuOO5VPmED1+OGiv3HoW2BXKbZ1
wgor8018mRdrbS0GYYoUg3lM8Hard6SRmelO5bZfrayHHMRtsHmwjtHKymGGdzOb
SWs8PGHCV5BPMM6INDwIX20h5Cb0bj95CANmYl7n8FLbykZ4XSYmkbKZrQposM3w
aAjsgvVW//FfMeQ9ZUZ3WjBt5Nst6Ubfju739/l7Zw5qcDJYZBVeWFNkulG116GO
rw9Ix5HDMWkZZkreyVqf1JhQCaU0Or4tOQv9PYk8m/0pZk7ry0Py6jctCBAGfaIB
7s7Fr/Oropo3cyJl9VeJGJtnhdvvLknPInSsimCPpjayIiAMA1LTimAfoWHwW3tK
BQEgdh2yQxVjAVGpdI3M/CI8SEpxw6ZhpOIdJ8Fa/GHN6jUYr+ZqLcdnBmpox2EM
8urvHcHf/P93oPq3+G1WbpIkzq8Llkd4A7O8OjOB6djCoBDFZCbpsWsqZPCoBPHt
ymhaQBqnApSiXcIiFSP34FCCKQ137ueAudSFmQnVC/aPRbkOvz623C8WqWW75mRb
+jiFq8t8ngEgaCBecwMUhve5jnUBEr4ItHs4o6SovXvSGpNT0CctvyaF1WDeOhCh
NMuRBgpxuY+llSjVsD8enANIL6nBaUoUz+bSL7aktxD8/2kfAREuAwNuL/7g5zTp
0CzWBedFbPFuJ60/TrapjLrEVZAugP9zpzqB1R+PhSsNd6LzOHDhKFybpJ2/HBoN
iEVcem38SMsCojZEhfXhHUORRRO2F63wPvENByUqwINU0tZmU0FsCJugKR5CSUGV
m7+uY3mlVn2CPJFOOwbi6Dqn/5n/iLBykTvekZt+ShmQWjxIkG/3zigC3WDu4vyo
MgYP3+NW3JYrhS8bNXqNBc3NZK79Baygh98O1MEbrjlHDziwuF7xBT+hx+IMkKoH
dJt6i5f5A0N8bBmd4u8IP7qgAzY1XHCKuRF5d0jt33/eD98HgyWXhTG/AmsMK+Zk
L5XUghiY4qKf21v8UdAK7+Ae8O+Mnu2QR5NcNDftGeBjRlrkjVc6MVIgx4EAU3hn
xVebrLMC2dT45PHwP8c1nJ6LrWgssBgT4aBto/23z+8K7lESA+90bVoFrfSG6NxU
WDNS1xAgcOCzYdx03Nsxrf7drUGZfYw/d/yKgX6v4ZbQLfNJlU9DedLElQ8lkOSE
wYyYCGrBhUL6iKEZltTgCqBdvJpg4CizO2J+UClaSIX4AsN9tHzAmdBm17g0Zp0M
EutRXa65UZSCmf+yJOvrNiP6SbXoNvFIqa4oYHB9RkCcHaM6WnN32Hbz8FeuBYP8
K0VWwSVX/kay3ot7qlLN6ar3dp89YsMRRKtMtEn+K4g3x/oj0mUkfSJ3o1qdOcCl
vIZddVl7dC0vhXaUBWuf3sZLhEl1F78i7gexmjokKA6k2ZyFXdHmLCxGhCfNnt9q
CRTsVWNKwLdN3W7CWe8jkeCZ/XwBz0CDG8PAFD0Tj04LgU8mS8HB8sGSpRxR8iM4
sjXkPsyZRidUmUUWASZkeJKM4kKp00ccaQb1HEIezjMrVS9A4arHW703EUmXOhlS
hNmT5b72Q3wyWQlqEsyLVNZi1fXZW0CIivbVHoIQvFQ82XcjCoDp0D6HoaBVgosc
e0vH6aXXk27M6o95EfnegVYZTv3qDbqV7f9y2DGM1es7pDi/tp1X0mVH5gBmNw96
sktN4zm9Tp56VmbkSHTa5kp/hLFoCefUmN1JJ6ZBFPGdWEfX3LWa68OSxIbH/bnh

//pragma protect end_data_block
//pragma protect digest_block
rvfKTOItEaLRS+jBVrTxbscwviw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_CONFIGURATION_SV
