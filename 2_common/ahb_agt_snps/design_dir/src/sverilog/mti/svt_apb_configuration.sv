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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DFAT+7FM2lGjEGRfFu6gnPmpt61eVLTd68Kf37NamM68mks5srd8462WD3n6VGi7
+m/etjelMRVfbkJaVgeaOg7nx8+31B5JJPDTmDXR5pNbvEIXQbUhk2XR289ABhF+
yMr/7rmAsGg11xaafI62Fy0to+Y/ayeNwlVwK2ivcXk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1006      )
2BBkMCvwusXmVidTrAuoHftDGcyLahQPA7uu+3sUT71uVm3vmSzTmXOzM4wKXXqG
N1bEF2oOiVLS8ahaEhHoncz+bMMTQMY68nIGRqgcgcqtOr+onrGcTDU4t61wL4Vm
j8vfvzaLI7tYpt8wr6wI2V0ev8DPOGv7wMZsHrBCzEWD/noLeliybSCkttNOmbiB
ZeQyJe0JxJt2DXsC1cAMvDsjDHeZmraxjNv5n7TNdWNMXXn4At4Jq2i2wa7wt6NV
liZJPDG5G9IiBuBeEVREPWPd42onfOmQ3bZUn7t+aUPKyl4mL9ixxUjvN2+Ndbkm
Qiyn9xOmZuHhlib02n6iLHBMZOD4HZa/P6e0f2BW+yXn3ZtUmKIhZpYIUHk/7Zss
f6qOvdOzIQPBn16ESxr0WjJx42kHiSArMQkFfb3AN2RqGrA+wQau1u16AJ5+7fIH
lKllE9HpLC2WYYsMtW55YQEzEW9hcv5gKwLVzW/X1rIajhM165mmwgdBApeHsLmr
9kyhKq0ZTUPuIFFLrURLtI2+xO4NeRjA6kgfqCtIebY7gwvc3or90FY2bXYK87T0
90zxrhquEm6H+/vjdDKAy2ddEJhhy7L6hgWovW+YbhJptTNHTRe2wp0FIvwV0BJ4
JhTGs26TWWRnUMjkUwbma0/CFDQJjkKVmS9QV0MabnX8eOS7IqP39pu1BlRNdpT9
/zILPw+S25oEIj1Eh7JbkngMnb2HnpVB8pMKDMkabxaZQw+A3IuRCMwCPvNJuHwM
fTLAdzODidHXeQlo23vqCcNZ3SUPGuMd95zvvkn4CYmqCHtE+UC3IbW4OGJykMxT
hA2iL/rLlv01QuJssAyovffphIe6Qo6Y/iXfCoNbCI1Pv4BjtrMYqNzmsIVODMnL
LHZb0FaGnjcWrUKlt6YdqL3dGmm1JTgVWSXCGuB+9/GkWtCZ7IgsrFg4AlWAo35O
wVD6w/za7DLy3UXXR9moLqN8YkzKvMHylg1dh9oqpXl5+GGYjs4qth4eyTXCa/9A
LFlekS+IUMcTxg7ByJB1c4MRuNKPKPBe5mG+10hZa3aExhCwQ5Lb2iz7eimo02dH
uIZGuVkYcKuyWTsJGyFiYHJJ7+1WT6TO6ev4t7kXW4B4LUeKMqEw09H3IGsbPJGF
J1KqUA+Q4vXD8cyxZiWcmQ5FcgiB9OSLLfV2TI8o3hdaKls3RFKCAwTcPpsnboUs
Kz/LawU4yTtuwC5yPWXpOtxXgS4p4PH1IkKQQuITs+2kADb6B3eVLwQrLd3Xc31C
QAzEh+R070/t2HJ6JDMGe5moMsXx2K8GGTDpTULyOcbD44cKr8OWyeHfyRuxWf6A
`pragma protect end_protected
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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Qn2BBE2iJ1eLCCma7TRWdnfEhjZnug6caxN5nDucFgCw5OXXvakSZd/9qWejauRE
hQy6si2NyFZdLOBkDvcutZlQysnpA08KPha54CWHkguIXcFWFThEgTmhkrRzhgOv
rl8eOoxMAuMTMByntM/GDw5OZV8I117uZrAuYH9LGMo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22728     )
EMhKrzcGTZeo7r+1rRZb83CPQYHeBcTxxj40r/oO+yHIs4BsN8brTBFfc6BmAlGA
BYuVbG4su2dApxusf+GjH67/FOPdHrZKtd4MLwWiaGJRdTT4iJa1mTT58aGWPhtc
zyZtSutwc1CbGSq28CukpmD2Nh+iA/1XmGmpyguZUE8IrA8Rj9DXHdHF8AUaZn8V
lmtfD9dw5kQ3INm4ChjOwR2xjXVXu7dY8FWLhEKXXopecPO6PkKPkJC/9u/YJ0Da
du2O+xUZa2sV/DXohftsOn10KDZKe8zRyhUQV70eIXqMHvjKXXG7q75Kl8+SsJfU
hW3GG/NjuzM9jFnzVc2XQFB577uzLs7qGXl+5LlNxDaPus2fm/iZIGgyxz8TLqDm
LxRi0TEbud7HEc4cNOZVFebEKLE2xMdrboYc39Abpm7qUIldRxRGKup2WyBm6sg1
0vVU6qcTvp+SE7Bva3L3bs72IjELQbwZ+hWxSd+HAWnnSE9B47rQbmaXcyOE58M1
PhRX8BDp0GWkHWvxDe5CJ8m+CupkzWRIJPVRc8CukErzUB+Cgl4mbfgGTGItYCh/
zroji/cUyzLOjiG7vtiYtSfllhKmnmhZ7pttxhuqgxCEL0AbowqCKibidbVsQ1zr
zPNzJgC8XfUjKTcwroBm9/AG7h3rABSTLHGHZtpxbogbCfTJwsuH6k1DaGj/QC5E
tMC9KCBYe/67zQFpF1sWdCiH1N0m8tL3G3/t50ZM3Yy1pOiryJR/B2C86OStZoNo
U0JLV8jEsJ/hJ8CyHMHEkmuPiYBZvvDmfbDzdjOGq9HrmK8p+3lT3r6LkXEkw/bR
5AXsbe2z2l4pYQkpf+4JlWD/wG53tYr3h17EVNPqP1JXq4cQo8hKOL0gTvA7DA7k
g0Gf0kb8qo7PW8dm8oOQU+RHtM5RIrNXamdH/xr0KdSnkdC00aUICwdoe6pQZ7ci
JsbTyJaeFqLcRq9+3DBLNdb5/AOHTXhzeMXWNuM+EGixFSEr3aCIFcjP4Xr15dRr
cFQ0C/B/5l0m4jKbgpH4CHBSOxDRuxIsImNVOr6KNV+bdZNGDZIYd/bn7+B4ISZv
DQ6iolwWbF6zBJvNwd4PZmWUGRAShaGEvjLqgcBdjC0WWPkA8GzB+guUfK4th4Sj
HFk7b4OkpvU7YBYeqPXQj3aZNSMwDN3ccMLTMaCDEWKrjS6nMCsYWr/RA7IecUNa
BKhc1mjZ/QPGg0+ZMz6T4sBaY8/WkekU2DbBZvu5ItRaF5yyZ77OgMQufM7XzSx8
nAyRadXaUVjIX+TdsW+AzDVfF3BqmNNlHae8t8hHUzY8abnka76oKuLF4voiCk2X
SPzh5gmoAmoWhZCWgnKPmTIlJKHSUvWuHpHP6c+XQ5GY77bLE7KwoIBMppuQLe2D
JkQEQvLTPL5spEk/0Ag0X+0kAog0eNcCu9ujREmSWdVvDNq88hfodnzXTY4W2Gya
e56zYK+uXS0mT0lpTVVpf6DoJz4WaNuqr/N8PG4/rDWNhRWzjReYzU3PnpRvoFnQ
F1PvqcWAlZu53pDHg7Qwe3w1U32jke/x57QQu3WAckkwicxOBbwVfoZ2naBtqNHO
9j2E3sg3nRpWv395qvXv/3Sdihm7USltQbiPfqrcB1VtxO0hCBmv+AaKSX0m0GTL
kkKnU3qyaAXFtHJIL5Zu1R60IHAeDtbX2tNKOpghEBJPPIQN6IJ40frOwNrqPcXf
up3SHfSd33sBSdcPj9NbAuov7ZZKC8bhtsSllr5xAoqfl32mRRiqdmAhBNeJGk0B
VMB4AlheQ//lj0KbAdKJD2tNyfhbMODv0CzTjWWEPniM9MGw1mdlcsZ8JH+wsdlc
rsvC2943W+0Ubo4NCnHwRel/LxBmtakghx+StqoojUJcRSInThtepxMjj+fgahsM
SgSbneUzTF4H3bqdqy52FhZT4bMnANQhV+ESxRiOWCXuxJmM6qYvJFwZaT2eJ5S7
xXWt0RqRMtjcXpyWGCVV8+1vtoimR7GGnIXr4lcYN4whQPaSrZLqZDel0v7+NGqK
zkpyAA/E8CIszn4I6ccs+6GGR0zluzUbgw0852o5PpG04+kMcdLsknPwYA6DL5Mg
0rpcR1/qctU0h8hv+r9bYP4L8mklCytcGIestCLuBZNOtCthn58XGlEoRS/zun4q
AIl8dek/rEAsDBkL9olJ5HsL03G5mT2Xmbns6lH+/LoUInhvL1hSz9NYTMYq4CcD
5QbXyI3G7+gHfgJylCR0AWaRAtWvWc+V/bp0DLqA5dPgjx6QNCGbrIPwFeYXUku6
N4884iLyctesPiJxynvvsxSNF/m82dIE5gnMf7Vx65fKScf1ozhNZGSqwqSKrfsz
vEl3XNbHzWYNS8vjyxzSXH2wU569XgKguSieJNmCGyzS4KIs8IZkQH1VeLBzayJe
N63YcbzBZNzBmUn37ANWqOTUS4264vPzt7wsHzul6ZIJx/pmt2S+yy67QOdPkUiL
onPURD+o9Vul37R2orPKfHD19fSFLsgbGhZgw73Bw/LwrxDVP+nkvw6jljZ68o0w
yfvTWoeIU0FHEt+AkWmrmZXE+lFlc33Qq49jeg/oMtsMQkwlRdk3mU2s+sirFu1/
YodKkgrSShawo9BjIABD6iayoIQIfN81Rhyeji4+NKO6D/M8qhaceuRM8UKsZHMp
zY14ZpjInZADUIoEc+8ZSyZmEKkuiO19tplaKdEWRfjdFpnL+0pYHAJzaEB2nDs+
Jmsspb9yxlK0pvb+QyhwvoSjyyIbM9aDYzYRm0EB9xbHC1EBRkE83+r8MrbqKFjY
ZUwEV5XAwu2bLINYf9bGAyyaNaKDqMSzAiYLlzLPcGH3WR0vohYda+wxn9fHEiKL
PJAGy9caYas6FGKJozHsEw0OyjXrrjeId4bu4u8BWyO5/HTSVCZBC8lWQ0FKwRy0
HVuEfWwnUmJj5lg6m3T5PEhMdpj8g8xDXUkHDjDxp45nSkoB1XEzielRAviHpw/1
7lHnpnrvhWbSuklxI8ae1Lw40RqWye/yJLy+vtXTNpouZq+G/AtdzByjZjJJiWLQ
k4bxE3yBBv8qmVvxqlaHhZzzhmDFh/kX4RKQsZ9C6QreVOx63PaL7foQg+P/+yLV
IZLVYS55/e7MEvfO9qCMz9+/eqrtF6Re8h3H9NIs9pOeagfGm4gj8aBC3wKv1jxP
+oauK+mmSNBVUYwf+Bsr2Sc1JCO6x/OZJphtAeFxLKPOp6cSCxD/ux+yztihVKrO
miPV110wHItRH9cWLJ6u6RtO+YnO3hrmwnLiRV9GtQfdNOstQrtLJOyrqQxCprAm
Ju7ErkTh2yJOL5WDi+3NU+jIPnDzh0v80/7gb5A70h8da/41bYDB0AgI0DnReoz2
J/gGwYELL/Z4ZnVV90FWyLQUekFBoxsYKrHr0+0s02EwuzKhdf67LTE1VomvBRxZ
/jcE4QcMlBUy/mvnykKVgoWHv8rq34o3EoqlFe8auDsTkycIjm1CxlJ5CWkpGWW5
ZnRGaFJwcnC+Qpk6j68QmUi1/aQ4ENLrSj1jSrfCnvLFOhDHdjFyBlXwYU6wMh8g
ifoxEG7zwzLZdS0LyzkXtvb58y+d2VKy0rTnrwBKkMI6HR08YdiI+lfaO3ym2PSf
g1NrPPcVtGa2QfdMqrG+Dvg0LRH7X0TFVcf0OQyyWGDKy+y+N/KdscLlIIYK690t
Hh3IJV5xjWL+GJiQKQS/5/vcNU2ATR/6OVqa5tTbH4QZGQ5hF0v6GYM1IRINVrJ3
VybAHnkCT2/R4HQItr8/R1riT/yKKk0CcsuZQ85bsisLgg0BJl468ojuKsLbo3yH
tQUgVXG5uoUfKlvRmbn/h7BZSPJwFIbvSgHNsCPD25XRKARUODuuw3ir0S199zBs
xpr1opzl9B4n4uc1ZYw7b0uVhZWfcUv1M9U3nAPXXAybR3qTRKFB0QVflvdYA7v3
u7L7tZpb/F9rimvPPmDCxUs6lQNsBW7/bIUj9aT3e2BS+V6H/RYMO84cnCGQblQt
a9949IFXaJKxK78lZyEfS9wlWeGzaQLzBQR5s6OzUmdmqRJiFAvdJXyz0dM0X0fF
oMqAqIKPvnqOrr02cdTosivRupw3biah2R+gklxpiiFkYfq9eKE38ff2lIqcm5sy
P/pxEjHCr1oZD5WOCachYcntnvtKxvmBVIiXaCd/Gp7r9PrYe67vrJ677erZDqQa
Ucs762Xz8sGvAiq+D409bGXjc1XNrolIysL711g84EKgUsT3rUkjRAaNeHH9S+2U
7cQ5d7PTJM9VUBpuE64fHoz85hXxDHviNoGFOo02//vYARbe3UlUQtGJG5mn+k5G
ts10pzEtV7ZFuFLMt+O+opxiEekabaYjLaYCnwWQ19HC9fk8mEHaeJ0NQJxKwmAM
6/WwhW4F1ew5pzgSRfItDcx7niCm+5PtKLJb0UJ0yM2d4r39KPhmkkgFqKPcrarW
CscOOn8MQNbIbUvNcLPiEjcDACb83JBbGaBO8pU4tDvq2a0hGSYAEonZ7MfUOAQU
rIiUwOFwukqXxYLUFpcsAQ7V7QjjU6v3WpoaI4yWlI5A3L16jaNanNW3zcmSOuG/
4fcVtazklYu2G/qzheDPTc/EGtGGiWG9UfNNjwtqtVvF/b723aQVPhdMmAb2HGpa
wIhPEz8+kTJo9AVbdJLqLN+m/jAiL86jm3DIJvbd3oIINlboYzo/G51C6vUWwhIB
IahHSbzV3J6v3ItPBNREacuTeDEPkE/jMV3cAfUMjbqdiQTs9L4akzArGfNBf997
TefHxUV0A+UZd/7/OUlTGdGTlVVeSk5+G2nefjElQIIwaCy8zfP6dzeILQeWAaC1
rJPrOwtzzRPIPrAiWGazo0A5DBi0Z2gRdlAzuFbhL4rMkAu0rVmmScw4QorygAu4
93HpMVdmEEZYG09lOdK8BH7FX4fQU7Bs8SZLxlzjUHyOu3hd/hNmjxoFarogGjxg
/lgYO9uii4P6ClSYBaktUhXg7BhuDrXMroT6Fm6KOEDj3FEoHoW5nmfbEYPWyZQ9
zFcMZIlnwFRmXyrVuM1QG/9Qt6fhnfn16mLyARNoaJ2E/cjbprB/RhyoLR/SgNyT
nUvSydW36EFxV9A+LE+ifD1VY75giemrFFTvwu+LefA/vsHA2jo3bi6TOcC3jt6T
7+W1DdOhngfEJJuztNIsDhCCUJgBJVzEHNCHPORCv0EV3LZBqtQ4AujRWfeZSPtq
vY2+tIptllh1j5o0TQo4q8wi2MJBJxJCJ6EUlegmC20mhdGxCsXDuASR26h3NbgO
DNPquPxUMSishmkxFiFgLidHaGQVxUB43blJ0pQHByaHvODKBRmkB44OFDZjQkC2
lvs+zZvJrHSXexpqIbsndc1Nw4hDkUAPDOnOgQK8tyO4luLh/zLm6tcKqVBjXTv5
BdhCHGF9doU5ZMbPhzFtuu0WqQLu3D3Y1ak3lDf8PuTImb1sFnS3UY81M7PfyxLA
gn4//jETw/vqZp172RX85iAa6Q1rG3HN6GURQMkfuC/RBpTFj7dSlmO/MTezhNus
N7VUC+njTcqwdpm6n2sz7ebDdIBR+lDe8MflXlkb2Ns//xKRp1jLbZZjah9wcKqV
pgO8xC9LX4buy75jDSLBsD7kzg0pWagQHPzYlou+BW5f2UvqL2cIY5ymF7bafvmc
JjJ1109j9ZAHeaLejpa3/gAH7xfc4duptcBXS4Ld4aHL8xcvrh4OkQZfjkjOe8+s
s1Ksvn89iIjr3rpFRf5Pfqk3Nwbds+Fj4G8zsyEUy+9T0SjzH/P/bGeV3MDtv5kl
LK6B/US5W2kl0hWXKSViGxdlZ9mbTS3xCalKyEg3QLc0LiAqb2lOsBA9Z0c5UYV4
42psYtgjOVWU8Pf+K9lgUSzv6xsoiT86dHECIMJUYpByfRudy5UbytH/av89YKKU
oVzbyaqABdj1VahneFH9kbXJKPi74x8wwrzrZWVi8MB9qhYx80otpsB+SOU3WZq5
5eN1eRiAYzy9pl8UdXheJsC/39w6SNgJPXQlC9o+9wlf3T1OVyce7WtzEJYgvGfj
3jjRPnYzuI8iup5G7CkmH90lrXxgpQ25TnZ3nOtNlRTcQ97BMV5Szm6g1emu1x1B
J9aPqTzIX9sU8MXh9R7zjucq0nWenPC8dmXhBP80DQBUr//iUmaVm6iv50uNTBqG
oTIagEBOPiqyxligePsYE2FpSkimqlCZmmaIaX4MgRUNzrTi0vwUWS96N6MuIHA2
pcYVEvM15F7htUJ/T/t0M+oevxIj6ZOYj8jtNc2VUBHUaD1S2iP1BKkG47gH1Ac1
LFsfAdvtJkwfgvMUWHHMxbB+8K1BocsCfItwhGpJbtIs4ZD9UvOtP2mTMGddybH8
h+3khn7ZsDcNiH0qFv1RYMJ9s4b3gq5Woq6wkT3uOB6TQDSqO5ld+fEcljVF63aT
oS7pX8H2PYq2DlYcEkiKJw/0nF8+q4kH8eWytXg+NyFmOMcF0O40I9XUMchQ+iWv
4Pzi/ZeXKVJvp41Rj5f9/tW40Jfru15zVc8pbDa2nSMotEC3er+rvk6jnMbhF4ji
Z6aEMys9XXgSMMfhubi7tRxDEECJkBYJWNRM9cjTixoSZSXjknyCBpC0uFmKrRBO
YrfoaineK3yBfEd3b1DEb4wDuCGnHAp1P63SE4evCslZg641kkvb8+N30Vi5Fhhb
Sbud01VzPaR7g1XjWAFGlreGWAkI9Dsmh1lv0NiWBPV9VfkjZPqlC094O2nLFp+w
mXWijuBOs9418RM9R+W6atzcMOZvnQniBrLCcGj3+dAzyEPZ0THA2W7wz8QFuoyo
eCk0TmrQDtqn/N940IvqiTyO4ml4aHZI9BD3ZM627Z7cHF70cbxP57USU1iNehO0
aepDztE/Vd0fDXGqsoTLGr7kdOwqiDf/v6oyEj8uxLGXJ9UIDt4T3HjT0aHyU8od
BnWHx61ejS8L3ls/UdpDT9+iaUSxg06lRBpXkxsGOYgjsa+9MpKNBYyBqiKDZ+2q
yXfX0t5iaPwYF7m6hDBSOfQmuyhLZ8dopBHQM9PrG3L0fQbJz9rwVaSZe5NcTTnU
XmfJh39R0ka0cjwSdmVR3Rxfm2EvkVUSRWRUKzo9LKBJAYPiWdLHAerVBD/rkZ2r
w67rv1i95YMG3LV81pGu5rt29PgNceTttw1StaTOiVTiKvRDIUL7j851kl8zJlyK
U2VpBXaV+/kRdMColXhTfGujLdvQj6S+lupvf12Sbn+uYNOqNcTqxiv/FGAzX9gO
l6Bms7obFePS77V8t8rgML92N3g4pFyl+mpPEfrwK1vmLDWWl0Q1b1vrBHgBYbCJ
HVUKYV/Vf/QpJYQBe3emiLEWCsmyRPhgAQL8ssUctTLRt8a9rdPXUBByQ8FFnL+1
9+9BxMvzFyB3Ir+adufSlLtsvWwUvcTjmcu8i8edOkYuEFBzVXKvyL8UsEwwZ9JQ
o/n37avUauGYip0tRhplFkwAkHrnh3iY3hxLnCbULr47869ds88gab0WbHGgX+0x
carAfMP6QgAxeo0ohXxokP4BlidW4BNRQiB4OvYjm7WyBsnDuPphhpRaFcVe0eYm
89zF2XJdXKlqb2/17eg3CQFbONs2NfNBawvB4AoaD9wZLcB6J2AOiPaFW93HBElU
OC7cNbZO/i8+qQ/CXxv83A1DWHWGm3j1QwUXxJcTLilCZrr3hs1s15xyYa4O7P4C
0fs6FH49qXcgu5ii9t4/52G14TdlaV/9qaRm+QoPCbB4tB0taRMdh6Md7YinHIEo
+8AUejBqy6M8pDmCWrfipzHtXnw1A0xcCdhiN0FTFIe4mUH+2hjJOcEp6BS4M4TI
IYIkEKmhtp0ZThKxFIZ9bJZQSkBcXXmUJzJxqW7iLxVyJt9N0iCduqtrEQMfQv5n
iQwSHDepTfNKxqXQlB9A6505v0k+KNy6Bme2okNCBaJWOhpRAxsTbIg940Qb7JgS
S3XNSufVEWf8bSdCibsF2yBKpB9hHYI66rl7b8Iy1ytSxVjntOL/ws8pzCOeHKGq
Pb6RrBXHXkCsnc1pR21WwlUU1SDS6tA5N34IyApMGru0pDEsBvs8bVTVwt4+mXwQ
KYwS4Nvy5h2uGGWzNWLitYXFrLBgIPKqsh6SWrB+8aK7EuobpQE8peSIai2Hh2QF
1ewYdN9fzfPmsWujht9oakNarlcGDxj5rTORL2pTec5AwxtC/iAO7mXG0K4Y+YXt
jXrtCccRdNo5oybpKgJSiAlwfvbDiL2jysp0rnsYTOLQXSd/e6J1QDCZQGarEEHP
B6ZY8av0wi+v1FwKplUR2pHWABTRRLpEHETJBog/0+VGJe9IJ3acbCPPKsiMZ0VS
XEboMNWeN4om35+9k07As+y/q8X3Oc2xlMwTdwTxQx+vqXBpDHjRzyqfZQGvpY34
giqYawkxI4sjNxbV6CGSFix08p/7ZjwyroyS7FGQr3zixQG/RjqVp3UovuFVRccQ
XEhvQa2CVgfRK4nwTpCyg5HQWKbxO40Xg76ONo+m0bbnZdwDL7GsUAMIcETnrTWD
E6PCL04MuN9h180/hW6x/hfF+BdBFAHtaUqNipKwoIfk/l3dIs7jBovLVh/MOQ+n
JXwRolN++NGfsh+i02Fe1mcSYFZRFoDXTjxWflCQ9Q3jxkjOQUJgL4LDXn4gpIzQ
XLGpgMTb1e+q97YJ6cB+v9k/6jpUzcuFL6Z3hXaX+ey7h5wHK+Wer2PeVd16k1Lc
ow4uOR/7AHDbZUiTumEeWlpXCZuIZTYRkQmLfwr5oVbTfsIfnW60LYMi4+u9kgF4
H45V2AD4pCQ6/JkymspL5ouUTPJemAtfzqpSpZyfOIUsK4N5jafr9eVvC9i95/Bx
FAjNONZl0GIO1emIJ1fXM7uUWMBUPX18bJPHYiq+sUHPbEEiGBg50s6kRAjAuaea
Rfcabhre2Rg1pqTJ3Mejr96TI+C2vjL5fkTV9ds4ExF8vznU5YtJmr0WFsIIK0JK
OAHCHkxVT8zL38WNj1hREylEo749/zWCbu0qV+zn+702EuXkwt2FWanjYNrh9H+R
PaKI9fOwpFBm4ZbmlpE6blaHEO/4DOU3bYfKTCdZLK+mB7SwQ2B6OqJMt4Ig0wgv
4HSr0ejuP3uZ5RfJSBKAJj9Cb2F+oT/NKtpPvBKDzcD3CZpuyPrhEjPik9wgCCK/
gsAYxcBDOofnnjLM5b2BcOgXaX64gDNTkcVohUNDXEJWtQqUejh/ga1jHKQuDo4S
Ntm1paMq0WxkuTTDpAP1Y+4XJVicGhNxAKlo82VsBwV8XlJSqrH1S9TxXUWMdbLU
9yYqDGfVsGDtjJ5Cig3lOTgLcIuUQQhasnMr4VdwUTQSIHfZr4894wq+FqSm0cDf
TDTJaSkPOmD+MpXoZxEi6ErDN8j6CTFBH35in0N7eqv7zQJxCHoMtRglZz94xy40
A1rCjeW7qsbHtnEkF+d8/zLbtp6c6vWVp90T68VBf/ybtK6ZtNQPpJIUxHCPTMSc
jLSUBsmv01TLtY038HQZAIlIvXZ5PRFhRxslwpdY14pGLYFbwg+XHnAk+OHZtE7d
eoPdss288DkOYMHn2ohZvQBXDjuP81Fi6QBvqvL52bGzZDK0u82kKgyLxbhSB4m3
hsrLeAQbf7f6UKZ7j1YjXGaaDuqw31E0sUDs1tRt+tYpplczUTA9lfcBfEHsFEDk
RQQ2qyFDCjeyQX34fnZolDKh5w6ICuRZ0xDpu3OiqzEaXORuEuq+Sxnh3sCZyGL8
HzC3lm28wKbNxtn6jot5VfCBYTpUqP+hlsOoxYbOxR9FOlMVfzEcXSQrMgc/bVw3
niYZHazqEAwM+YuRwxHuO8haWZbhHFNxRwzKhCK5uA7eLPu32hNbvn1MaT906xZ6
pBCBGPOibQkTl3yEKYWy7Fh9qe1vxH5pB512SFDFbhQ0GVnJHUVlfCriekaRKH9m
QoXCbMfB3KgFQtdoW4eB+RnKqdCSVsRGlfmiRBAymvzgfmB7JD+Z8FkGtK9G7DMW
5KwPUn4hbXQT3QToBWaR7aIbF1bHi27Q5xG346h5znLafvHLZ9e3/3xrbX4CN81a
BfN5RHbtb3ADsDehEM7tBDDaEnd/Mnj9DumOEubzwUgu9GqjxDbILHy/GmEs2EV7
B1w61YOzXLQAUjwCSPrcJPHkcQyj1fNMM2EcwuoqutIBtWiCBa/kzQTc7k/WIU2T
t4GEchT8N4L5yPFTBvaOWwIYsFsxa/EfceNw4baXIcI1nMBwpTqomDjcYz/yG1fg
12e1FcAh9WApdx4q+uxtX/i+/xdjHBzMgQ9770gxbQhIrlcplZCF9dB3QHgnFb1+
jYqiYW0MOsaWrOIQEjEuoGyGfs7sQh7wcZyRwsC7l6av6DJByCfSvk/3zQoyBGDZ
pzej3/vwf0TsHlNtZe+4hv0bkm0W17Rj/8XvAwc1vBKTquvJDRh8AGDYc3aeYYkh
riEIEtE+ZWjO6U9fRg2zIFogxyWAlBWANyVcivA2zD73tF+r92BASm4L4rp1XRLQ
xh7tM/fSk2VuKkEYpx3s3109HciyHRQ64gqAUEAU4tMJKMdykVmRPcDfzDHpyI9C
j5//yXDyco2tA1qaHFHsef4JrXB4FxJ7pkOILYvmipU3H4nC1gSqbXTsFDmgUNYy
d0qVe40lSWxLlSjGna39vmKucV0ITYAQeSrnflTvBVLko+m30Gf73wkl6RK4ibjg
e/QEuv3g9fpHn/kl3VDE7Lt0SdmzwoTaBPa9ZXE0lpTN5ze5pfCzaUptCzz0Y+/I
sz4HjPGdQC3VxEEcmGZ0B4g5tM6zWi09uXTS6hTHe6bfGFUgGZj0TXjr/+cglN0K
1FKL3esmLohVvc5iwPJcyJXI1xXjZUW1nxepC9ZQ9Lp2KTIUqYZHdAit7Pu93npM
DGzVKMa774y9TpEGY3AVG4B2dZnL/46ljFmlAE6BTIqVlIWDpu1I3J0GbxYZZdrU
0Lyf2OO1dTnsnUzesi76NFQxP1PUqwbM67xfb/LwyuBlvdCKJ6wmRs7KNTOO6NT1
Fqr6qnnCx5AyxWmmldJ8QJE3PT5myDEj4vIXBB9FdxnMPpBUcU0MQFzh8Uxufa/4
EhmIMFP/C8SwqRK2L0jcItEE+6B8VPb83RZrqeLAJ7Gttr8BixwiLJTOlQVWsUrs
+v20DaB3SqKIVYLSME8K3K6ozouksQDaE9lwoETZyWlvcV7+vL7f71jJo+gnbMOA
qGn+yVT0Nljj3i1NmPQhFwWL+ZiV4lwI63OXccOjYSNEzaNki7tdIEGy+nO0bbJv
UvtBEwPmJ5bM51gRtxsXb3snZrKZOgv8UXWbDxty9qlWea+rLfJiewoUJJ39m31/
uJNnJ9ERQGs5xhCtXssgfEojzbqC1awv9GSkD7WawsNHp6j3ArFve1kHH5Vt9KdB
JED+MaqYBb90nJAOKGfHu4QKWlU72QZcsTG5B0kvfqGxdHYBX8P1xYCyLGm4Pr0y
jiUX9x3hB7t/COAhmxkBtcLEQOQW7NcI7SS5QKiK/ZBBye6VbhccVvPIFwoZyqgE
UhObCcJftY9nNlHOBLkNwLSv1+6aGNCPP83YkJVK4XuWLaeSKP8dSIRLko9wljrK
rP+XblY7xMlyp+TTHWI/E+NzdXlHNDGpxhkTZ4sEoaelsUX37Jo+k8XJYreDULfi
7veJSu4RO6dJtSWlc+cp/NCWZ+9BBCC4l/CiMdzaG5zQwJGb/AQ0tAwbJTZrxQ6d
yDMngNJ8DkiY672G9sWtBoSbBGYLv5ciUnJzqtIlra/oyI+GBSI0RFgAf4aEyufd
JbTZ/locG64qYorjT5SMdkKNpdDSWjJZx/Mn03hSsVY6p2SOyZbFPRry7tQcbnSw
VxqF3ivT0Ab6kO8agPGj3MqxHjrGXZgrD+4rpLOO0d8HS0x+ygguidqERsGY44KN
1yQ/oz/OABJHoKfR4wzKDFE6g8AUmtI2xFm5zv4/NDznB3j3BkSgn9QQULZTALCD
hZ8qaqLiSIXSZUW4MQH1qb5Ww8H8LW0mc6fz9wfuLa6UEUNWlaTZYPqu1WD+PZZ2
VP+QW3JdHq7Vvc58f1Qq5EcOv5EFtRIY/BRjTtl3rh3fh3CAY8hsvj2726kWC1vF
V4oP3iDru5hu4yTuSkEiJxEIK80cjF/Ww5a1RywMHWmN/m94+5awV2kuSN6iuHXJ
0H1HlFz6QA9297VX/05HNPLhnCWBQ53fbuclP/RaiN6ICMutNtSQAZ/DdrKfZF01
/JkddZ0XuFBQR1gw/zLbHIhXJ4GGtwYAusyXHQ12DDUoYGlWVIRBOmvooAdzeeqn
CHT9Q++zwax7jOtulEYeHaqWK1ukMt+WtfDTDi5pnfAuFhKZNZXiMTXPkTwcTaux
qGUTJimbuvsfe24Kicf4ST7B9g4IlUTf20ecv9+sU1zByOxtzAjm/h9BCes9JLT4
tw1jaS71t1Oc6Bvycp6MyyhnBAFj2zlSQPlZGNkqqICS3gANyBd9m5tvmnaTcF4+
ahWWz3KUnzV2CPw7rRzuswGUKkjHEgXfFhV9waH5p0C2DRWDPF6SSZ64AAfyfoq6
wGdLzAQwOIFJsGI4h+cvI5gTsiqblVPp+3wJrdacvtywrE46Ye/Fmd9d5tCzBFj+
tyd55IQ5xAij/V9iZpsezlYZ68P2R4hiYYAJ0M6VDZRH6K1zufjCVv7xfap/22T2
2TB4rYrTFI3gZ4x3Qbxz+QkzHtkrC3V5q0redrmkee/0464gWMVTG/ZzQxIGKzsF
ePpIr2RqZEyzj/Im4WRVEdLD98CZHLuCHqx2g1KGnuiGDo09bd/gPwN17IQ3Yd1A
KowyNSe4nNjzbUhbV9do8oG1foZ0/oLHt4jHQl/LJ7HvKXe5RhtiAomzjSAtgvog
pWDpmfq7waJJBQyravT6fsH7ZM2shTXBfxx4ejaGzySZoYo8/HBX1ckpA87a889f
tkgc2PRasFreJp6XFst8wsWGGEedpSZ0/agFf26CA8bOWFfr2lCu8DbfeOI8uUot
34HxaTA+KKW0ElJt2kQ4q14QyytjNY4sBGMeD4iP37ykgAtsfIoyNaos3UY9AKOc
HYl8z+X6iNG+H6kwbuHMP1QzDDlbj4Hgrpc9jxUKSjFqSJDGY23NlMDCDrajc7wR
r6GgXviKTi/BmIZfFSuQSpQdo4vTD3EeLrgsOEGRbGtgaNdhRNunb67ma08kCd+D
OfO9iNr/vp1V/6eAMyjeu8iywh97pwkYL2s8LR6vQuR5PmGBAV76p8JaDo7KCMTG
gadVZ5F4xJA7uPvBcBUR/dDQO8f5PqhHL7GlMqwEzPpOXqDV26LBb4Iqu7tnbh/G
d0i/p3Qn+csZP3cAtz0aHwpgZjKgVeVJ7fzbnj+3ZvKbtkkoDUhHL+Rrp/EHBZY9
AegGqkFTh8y2GVVSqXl9SBiMG78xhc/N99WhNKjZJ1rUPKX8H1m+w9iZs/w3bQdr
oWWKfEiBugG7s+HKgzbI7Oy+LK3HsdE94t/xlGVbwPYzcvWKb9c/pYRMWGMqGvBf
VwRW/1EXskmAc46Cny92y5pRbEhTuZssyZL+HPawFHCWkRj7p4pHSeSRCiqy93gp
nO/7ppnJzgf7DxP+4GFbi4wwB8pCraRz7vUxJ332/7UJ0ocqvULQH6ccEeu0WMiU
AHXa6BXRk5twNSM8TBTmk6miZR74cQBYngO/rBHL/yIpJrlxrA0cT+PgrI3CXCKJ
xq0FzgmRsAJ/vZthwrSsQJFSdePgwunQmny3RrkUDl6chHL2HaJCzAMyR6jey2yn
9+J2pZRBOnxxTgvPlnT78CD717pkhTZovaQlYspAvIGzBsKM8qPkFyYR6MCrrJKZ
Gb5yp4vPkdXxrii7tQr0xmZUQHxVHNdiwrQqXFvGfZHtD5hB0s4WY0x5qQ8RtQrb
/FPlj3tozJZfxhkEqVh2rrtk4y+etKYk9I7BGCf0B5ZiXhEPmM4lxgih0zkqYPjj
fnHEXiTt7WWruSxYP3aTv/YStCnpAvfM9yNSmIndO1KgTzenFb+GYpzhpxWmpqbC
mpQdFFzBCoaM1m9bsN5AbilKdiIA7vdXMUUDGgfOEybCvTQYbK7UFHxuAfkp9VmT
DVo7BVVx0impboS6FNMF6kleeETfaGL2DGWIhJ/cgyRTFxjwIZbynferScLKdVq8
MQUlTYxOafWHh5a12InBSBwTB2/h6FsWhSpNtUwSUor89VxmhFE3nMnWq6Zr9AHl
HpGhb26kJCSIneQA+emwNx2rZPZAOiOQcuyLY9qC2g5KkYIkZwJ4zB6e+pIbeqEw
oaYcy3Av2xEhpiqnICUi0XNFFULAY9nwKa+hAv1rOArf8Cb2Jnj9n8gy4+fOa/VW
QI69SePF+dO5XF7XIfEmKGl6zJl5dBPn5zioCt8h91mhajJisR/onOSjPte+hRQv
aoylicmk6SPiqwKBJIOXoOgxoVP89XQrZ80zrRXDX8wdsYQJbrLXrTz4InPPqSef
j2+Esl9HK7S15GLviinsa5z+Wcg3+E+WY2LCTMGYgEycw9IHGTb7ufUVPfLoxVAI
7X1kzyBrcYMvaG5AIaABp7gMn0uLM5OH8i4oCxWcW/yWKIKJIh0zRY9uLyiEwzb2
dd0ulMoy/Bq6GRGKp+yLJRQtwE/QAPl2D8+rJP6afjndrVV4kr9iJl5jGuM8de7C
hG7at2zudlvOYUkyHW5XcKTEXMFE6hY9YOYwIxAPRNfzIurqdvdemS4cTQkWOqyE
3f3ftGgjuBRJ6STReUbRdbHk+dH1QaQIQEhdc0VrKDkE8HVW2Vd6meZP2VbQLFBS
Y/QNyiMZROp1uKoe32YFytfYtGuSTcPhNOnAdXdOxen+u6LcxTTkOErJ68OIsZoy
Xa8dlKpzNgtQg5/V/UgpBWChb41aN3UWjjVI12wb1yxPF8gkGcG7gMw1G0Lv9coi
M6xoAJWSP07RJrmgE/nqHzZ2bjmeWwchPX6+sy0yJX19Rbtmt54mV1f7khsSe4qz
WPvoWB2A6AwvyMSNuRD0SBFCOwkIWDsVd7A+sTgBbmGxSBHWlsXMNpD3zFXdaz7Y
AeNq8ehiCG4wI+RC03AQS0XaoPpmml7cTby0gfqMR0pU6kgr558zS7ZWAU8kTcJS
P+get4NxP1XmJV1eSgmcj7qd1bF5XVpSOxATHorcTXgQe4smanHUHvCaJ77Lu6b+
jYT3PAhFMepJeA+8p9ZNrivJRcEnNICp77LlNS49f3R+Hv+D/riiatbsMf5IeboN
Fc+J7+I0vCqwDkacqILGwnHkjt1XjE5MhwV4+ytmDITkv8G+ZVYPONObHh0uHOc1
6UZFA1urrO0YJTy44yAFc4XbUfmzMGm/fKOKFIhtfsPpPk+pg5d5GG2u8AnUYMg/
dTzu0Ji4WgQqbdxOkpKsimL5BHFB4lzN0XtdsaaAVRVuNrY9bdKYFRSB0UWLIGDS
qMYO3+ObhDTla2+PweXU6XeR6HGcEOYQm535HPjYFHVNtVSvKBi19l7trCNzudL7
Hv9c8mH2Y8XGM3C9x1a+FwHH16X+QQzpcjjxJApNWl1YYGwFbGYFBBzXYmJACB5l
dtBdJnC9SSZS/n+NwGwDHQdQkVw4HUjE2sOtF5iUrA+/PNukaZ+kgwABtXzyq05Q
l5vz7mP7KqxK4zm7Bs5oZaqon3qX60ogWg8093oxMVxHG2jiarf6H/gJCXSkUcjZ
6ojiq+dWGr9wtIQ2ploiQvICceL+opfp3e6OV58YtFl6YY/0hJ3aXji+mWxhXXtJ
OCgT6YOXKWykB3TapZl4kP7kp1T+JTSzHmZMXBp/nR6zP/Cki/AHdAq8UJgyTcz4
btL6M+yupX0z4FgrY/3YdjSYP7YtAiBBEjD3fZTxDyTiR7EIKguoPhvdiVhcuHkp
RD/QpRqjszmESexL+S60Jr3PQaqqUWztE+mqzsa20TgKKx0/+hKRfuU9cxHrpmW1
mxugsnXK1IY6SoEX7R0smxwHEIDtim+W9DRuGH/tWTSkRC+Bg7NWGSgUR3rzc3GS
4qqikIODypDOywTNuv9DkKmmnTdbk0CEaDBGeUwpzfbjWtvr1rUnCup/MAyM/+Vo
/VRnx44qgBErHzVzfZ1SwlLhR/AWFewbGqPG9Jobf++PZwr0RuCCi+fDRFl5gfRh
5owo0PszeYuRRIf0qLfLgKAOtN8IzRvE78G/KEt4xiR881adaL3mu4t0sR5+mT0L
DqNw5sIbKRZSt/DQ3wvkP4xk2BQmLGxTXBICJi4SuICqMKeimJlZRokXINPEdJ5o
OPvbiXn8kXF0ucXITSkxgQeQYhjRjpb6fEmxe4wVQADFsWJMceudp9BaIaxLx+KA
XUMutX4u7qhvtruHsTupAab/nP7qtlVkAk+N+w9BE7sVp9DKUElORVMSwUZ40k8K
WWv1P/hvcEApAAdZ5kQJEpjZK6NVIFrryubpyKD8fJStg6Jfv93wqSBF2hKyxUzx
/LWQe0OV2Iy/acBh63o5gfT3d3Cur+0vYoWolqx5Rq2NucsFud3Mwk+bbh8UrU9S
OZ3/MGnW3/XCWDUJflLtYR43V5yvHuZZxUkf4KnBWR9v/GjSuTZIG+x7TZ2/39a+
8oWyc7aqGovYN54a0y2o16i/4cF8WEkmIwcLjSFP6KVHvcm7j2W7AZZm4JV47KR3
GsdqWdbGNZ3oy9gOhaWmlHXh7yR2WHtq+W8L8QZSo07VEmuqQ4wsfMXwZqJpWyKv
dUNt8Ei4kaa0NbKrwrBDT2q+oHX/SV6GNi6SYNnx5RTcnBymjyh+f/SJ9uUFfHCQ
Xud8UGFiewushYlzhcAZgVppkd2AAvQMJd0kcj6GfZVq4Rz33ycT//AodnNWYMDQ
cHK/0hYb7jqe05kbNR+XBk60KcqGWUz3BaCWhw2HoysvTHC4BMaGGfHfNxp+z83Z
GJeimgXrX2W6uHhjNtkutgUK/lVcxLmIAJDbNKNUXf7E5baJ7t+vVJSrtECnL9TJ
vI0mvaoE50lvA0SkGuq2Pcyi4fZ64ubWeJ845FH5Q+om6oDobVYEvpX7n3EN/5on
yf48f+bSbP2KYYDY3lyWAXswgUbgL0NrZPAKQCA5Qqyhr4HpdGkFFc2wl9Gd8qVX
od/V53P7b2VSmMvCNNXUzzR1zu+Q5GTmKeOm5/Hi6Hxy7UmlvLi3e/9eyBmK4cjV
yfU5hAPbT4S/7g5e4DUKMaDnLXzNG5aH1Q22gqjIo7oTdZxSx0Gtg8xaQaPDi97x
qCv4K0caPCGDCPWxi2AIj8ydYtJvQRj3WNVBxezb2CEHlEsYGeHEYN90xPYXU1jI
/MjvxU6OoaOQbBJqPeWul2G+8xzrBWvOkrJjSaCIoIoGnzPRg4YxVTqQ52U51OwJ
douD0J+cjwyLsEo+2UxBx12JcJ6ke5xtciKHQ6GxHvhXSuqgTAT7Wyewab6N9Vn3
hF52Eurfb5K+UufkJLeAMjSoAQDoAj5AAWb9+Hjl0rT/ffvqBuJVglTwNiuUvggg
rtGD+3IDbRJurJZbJzKK9M9KyKTHry+qxIVEGSyniRjWphAEbGNuhG2o27tV1nV8
rOoas9kd7lGA7nMeKqnmXdizwyWhWEAL+CLwhi1rRNZOClljlnDPR61w4via3oLC
vx9VSqjLCovl77jc1I6+TjapLW6nlqZ9/PUvR6bYYl90KdGthkYDVrJZOfigH6vR
/D37BNCRvXg+iUErbyqGTE9HkFOMMCN9U4ge2o2vd4+TYDTBKKvehDjfhELzsY0N
kNh6vDLXPAsrPbkOLGlQ4WScD/AWOuZ/3D7aVcS+NoS29QJ57eftlyXG1Vl1edIR
Cn5GMIWnFZoYVow5pPSbngd6MNJDIqFYaR+dMrZV78sgm+7jS3hfSxFOSDHxLvGX
ghKCnikAcDNky1xhw221jlqFHXNksIdx6UOjoLtjyVGP754IxPB8XM8A9R8M7PVD
xkTEYzs6zuMf7p3v08Q6nZcyVIkR1PsQty/ORbtlI5xHvMKiyM7C/5j3fWS2E2Bc
GTrrH4TuoZZZRCQ8mLjgCWMUYsmgoVERQUNezDhe7P3AAj4nZidJ/Vx/kcph4l/Z
sWxW0SLgQqT4KI0QU5Cmy2NCAeUTZHe8r3Yleai3F/X12t/gsEyVb/+FufDSCNBz
QU9nnnwAKgyjOz+A3wqEk8W1KcXaSNwktWV3oISfW3k0FjxKLGjuKObrCVMujGpy
RGNUA+xaqYmBS/SUNBbW73VxO48xlsFEcyO7/LqqlyAvS8uoprD4goyDOaUVIWP6
uINiEqoSgV7KJ/0ioU+DvF5b1UMoK5qX6gqr8ve8MUeMzYo+WIWK2gRI62KEdBnY
nU2npE/w00q/yPw6It/K7e6qzzObCwTT9sFlCYSr1x1ht7f7+PMFdCsJHoNTxOer
7HEg+u95e1v/wF4fualwna3CKhmFQdLdHVaVPjxiT+7l/3hHFz9zMkRXc7L6HSO6
ZWssg98zX7JdX4L4a4mshOlWAbjzz0vVSVYopZ4QW4+Oldy3JUGo8NlPvqP/EPkp
XRhlEPD4gLwBnzZGfh8xS4X1MR3cnqJYyiWrFhT/HTgQ9MrVwpSdWtS9j3D/9/In
gbBbowyOS9yffAErHFSSMadGKbg9eSnof9Gyo3bWxJ0y3R4EIOzx382uPYvMaeOu
Qa7srZhmEiEK+HYqm1q+M2q6+4yTasUAW5id+6MACRGGXqttntfdntc5baJzUhm4
10bUXy8GWRUxSTKd4mdFeYkt09wyQ9ZT9d9mGG6UpbZvMjWrWn6jNtonG2dMKWH1
jRgwwEdXiga9VZvggeWb/Z2UK/kuizzeC3N6T4R2pjeCHWFJU94uKZI6462aVZHF
+9jiBEG+vLsuHfD93GGuUV/kOU4ZlXouctP2cju2B4akVApukI31IDEgxmW8zsmm
+8zJ9kY61U1huiCwRzfbNNRfNA3Dbq95pzRIzecCL2PpXWeLevhW9NIJcUfHsZCZ
PS1P9HRn1I9Bdk478j0NWraDbE2VWhEVD0BLrnLlJj1LEKupQ5GBuw2q3TauGl29
QSy4vzYlT1Z19ovq9TetrLqYJaegnQAz76XJY+P6lxAzqDXNmR4UrsrvHc0eb9QY
JOAj7RBuIdDMB4oyuU9OSVhKNmJv1vNoGE7TK3rYQg4N94E6C58qSU3iPyK8bnNW
sdC1BuOz26CmyssK5KRzBbSlALw0nPq9xsE9J9yd6TyTocG3VeM9ndiuT2TQPyWr
9v2bQqlhjpY6hlFj54E5Jvuj80UyzRrg1YepcvDRifBICqjZmh/eDbq3xltBNpO3
dJk0mapfT8O8B4LKsl3ap6AifUiwXom2cvHB2pZ4cZv1RioDfgVs2q47od86GTwy
HQwc6mpKsHN/R/WvK2bQSu7EGXbbAwK9Alo2QW+wI4NG9HQWv245PSMccv46JJSB
1ViJMoRAFgV73rwhYfZq5MxV5Ks9cfd5PSvAtDxCGViqGxgLN8OWqmNGwYji+iZB
2tGY2O9YRvKVBU12sp92uliihP75zkWf1dIxUmC0UhxgpcuWSCbL4Shb813VJctk
EqEOZZuz+m155p5oeP4VDuTRvtFuqXY31cj7NcAvozw3Z8brfnr0g8CXXQ9J9dZ6
oEODtZgbXKED99SqXMpD4sluPCPv5VwtwLUjfgCGo/I54PoIoNvf45qwzxcTE6qM
o03E8pCd2AdUWrDYaNwsc6zRu7WArS6zWQyl8XfeyltdUxyC4lllviDAvbwo6dT1
z8rHLkPa5Zu0RoOZTMzDP8cWuTGyqWQBhy82OSpkECJQgoTdqEJEINHLNL3LC+9s
IYEBqNE/GFb0jYB975JQY5UOeRdtEkYgb/2LLzKcUrw7PSclkjr3e5lVDoWc/UPi
GVDtkExy6amnts55xT13QysfIR7a1zrL9hWUzyufywr0pEjn/GYrtKir2SKuzRlX
7isr4BOWTctKM+Vm6A6F06iXXrrNK29/Nbj+0Jw+c3qf66hTu1DZfB0rnbOlCwfE
c2TeqMm0x4u0daasZh5jg7BRB2ChakUspIFKmpejyXUgVHdK+V2lVZD4hf4jOdmc
HgNYvRepGd7oFGmfMmbqOPEIUDcgqMgVgQnnK06k9BkevHVx8kRgrPj8dMf2XHtc
RMdzkly2DyJ+7gh+5qkJuvoUkINdrTQpY/smQAGsAT3F055zoLfkZX2btAglr7+E
pRn/hrb4GsK2lXTq5GG8KuI5oj/4A+xZgGTxFHFmIwSbQBSx/vb2fMoeyLTbH2jj
MPlifpIBsBbXbO2fo0YvJg729ZxISHQs1YcMos/S860jAxHJ2/USEtJq1GmtaKln
tpW4ZY1UrpFI4ube5ln1xdX9pWI9YgVYJ0s8+355np/zIfQFAFt6lnniO6SVeiTN
ebnkRqLwJ8GkOCyERe36OtT7iGRDTkvM/bz6mfjqC0nnDOH4A5dYI2kordXaZe88
lmBcSAF+9OgvOeMtZFDFKDEIIJSlk/5z0SIV87Hc6fY3bwLPNhm9Q3uG9VBW7IRK
kux0BUc71lvR5rgF9C7+lxDvzn6UjgiFB4FcmalYGqYa8AubLkGmez/JlWK2/ESg
eQNFOU3gZaTNj884PSaHt/akhmQXoSp28QcL4vYnrnud26Oz/h7PKUCtFlUQWosb
zlXwaRwOcb9Bt3v9+BqoKCNEI7T4JpOAmApH2telQ1V8u1ikpldmxzY6S/GwlsJt
XPAIpiJZsZam++RvY8x+BAlFkK+C6xxWkzuP7X0pLYcI397AaYOkwbhWl30m/omV
euriy0ZRju1oKS21RvRD8DuHWQuldtUj0yBAmnMm0qyQAZpaMeaZKf0W/V00ciTd
9J26/Sj7IMWuHwZOz+BDTxuLOstxTdT2QEbSyJ7I+zJ29QeQ7LAokdMF+G4LlgoI
mVBPN/GC0v7EcqbHHgx4W1P5dtJ6pRI6Qe0VZkOfhHgQh5mkZPdH2IpR3GC5A9ct
15uX17ukCjUYkhrHKbTryfRhIggFPyH/UUt8J3zHvxA+uXxnibxiltvAjaUvL9Tu
M4w+YLqMjZvliudPYslH3WeG6uJrguEi4dQCMao4d6JoH7BV0nGBvm/giUUxsKiI
Coc41mZRpJ0tGfV0dsG4VUSvHAmMohAhTjMfGt5QuVEWF3Y+NsPgelZKUb//QiGZ
lWXArfmZeOfT9kz0FXOGfbz5CCQY+1Stjtey6Cmi1numENdV5CdNDLU6r2O5UT1C
2iZq6BdAjLkKJi8UNJt5lAWoSsFhnr7l5QwKCZxpUtJ/0HUatQslW5jrIFn5HNem
m1s/ywmH2M4IxkOAtTx7eNY3HtvtienyEJCxmPievwbrzy1/TQsXT5vzNmiSbvZX
X6KpMy6qWj7NzI9Sl2utea6T4OULtoLpwzakXDJbwg2M1cXZ0Ou3pcHOzsva21BN
6STd80/V23pl0NxN8UTCrkS7DCizT4at5wAAFjvVUTfWSRNG9qHjMFP9Z8Bm+Z0j
8MW7QLmtCv+oV76ZldMe8wJgyEDml/ig7t/PHL776HEqFgItKDs3EJBAu6Eq59Lk
PPpK6ct8N+6oYUnHcaksyppctiUqazD23MC9ezF0rZdSXJp9+rzd35/bV8baX9jQ
C2qofadD0N2QEobjnolG9p2hbPxhzl07VGV5sZcTh2/+OM0P3jMqOZGsSpXMKrbA
MXuIdxU/ndVHzwYAKwBNTB+7Ssv14tDK+XHG/34kGDoedFkpqhTuUYI0fC8ObJVR
M8SRp3FmHnl9L/qlPNm5SHWKJg2F8XuiNpe9bbPxkB9KTMXsOrpWrDwZrlUD6C2V
9PEK3No+t8jpbaZV55vg1kaaAd2//Uq/SGsDVpHY9QfKftR2KcgwN3C/DfjJczSu
UilpiUT+7taaEaBJQjJjrjwqBYn9AeC80Cl5x1K14ssZBQqhFUOe+um5UQYdubaN
/jlIoaXeV/7/JQxno0mmLDDKRSsUrE2vFuQ7cDrGMNStaTj+RBIzEmcGj6XKNbRY
IHBTWXNMkqiQjXjahveMkrFFZ8vU98rWUQFvUEBxt+cqMeSy0I1EDWzJy7JNt6y3
FurhSZ9XShhLF0jV4OTdmRjOgXFJ6JyDlMIE9hBk2toQVvf1c55gQUYi+fp3/ML7
ksT/ZEkFpKg/feOHhZYs1xbV/zZ1TiWgmPCkabAdjhQx09S6s5y5y8SdUOCxNgTp
GvmTz7QIArdqqUYHzM+dvyjMMoTpPC/FqqfWNQr5tNhL4c31Dd2nuLySJwfuryN3
oINF8fvg9z1OW+IjFQy0SR6wd+eJ17vrZXp8RXCWurY/CHdpypi2oZqEkM3HQfci
UAAtmA+Lzcu2bJDC1QY2XYgZQXPvIf+1WW+9y1AGgB40GigPMCjl+DnAYgDaD9oX
QhILho67rELQnE8AmxpPXQNcBkTJHun+f8vo6gFqsEJy6poPhqs2bvJSiTMj9EdC
zGutpbXoSX7rAiUkUCiJETxEBudbG1drgh6tXKdgFELmkfFqoYKn9uAs3ieZoATV
zO04oASkgKKZmYJyAC2Vl0JjIkfYw98nlGyZf4avhoss4u9DrRM5E3+adX8kF+54
DYoin8Mq/aMYk0Qf1cV9T86nzxSKF1Kc9cjAYcrKgFctDHL13HNESMehkZpwe9BJ
DMB5bpRe3k6MVHaQ5egUL/+PpOiNliM6fgjQ5N36kpybWhWqWoITNq4ILi40S+IZ
ZSiMy2xsNsA/iYMr0pmAQGRHeKRIDQbo2qd0ecGsDv7YWjI2FWCOyylLPQuPom4b
LzCU3phGL16lb1WgW4BNyCNjnhzFkYYAY5zis9M4iCwkrriLgMsHPidg15O/0TQ8
1Zq2JkrgqXeO+BoYn1+x1OWYdU9l46EOL8JDjPhfSy7C4a/WX36yiUTCqKUyZvwj
egY2RMt02K3TX+yXMX0qMgeych3iOocGjxW3B99nq8NArLlFcAWzF9scK6gjH/Fw
E5//vor560mTXLrIZe+YbSvAvA6VqB99jCR8mdhytjKRqJo/o9VFm24D4ilTVZ7b
c/UOcDYID6l2hg72ZRirvcGiLmO4aM35F+LsXt+LV4N8kXQuL3rmQvCD45/XQSaq
VLSFDHiaOsSvApCLBx1iGTVQgidLp4+6ioiXuiRh3dLDcL8DVvAl+DQOtPUWVgfs
0ipxxyc7IvWAySH9r1JAJae4URer1bzA5uwKV202LlzpbXr23OPXUJh+H1tbHOqA
XsriZE/CSGsIGiMH4uLqrCo5ZTxO9SjznRbg/FlsmIz9CvMEv8Zov72pVJ7QjyO8
fBy9JW9M8AbDAyvtGSccZrCpvgAC/J+qZUaapKh7eq9jt+rsXcqOb50fURu9n1wQ
7pDqX0BZpAPfUfO7bPglPPwPaYvXU0eE6Shls8KhK5RYbyqPylcc4JU+RVUFxq1/
am4Xe24GWDWWW3WyrYtBY5XXyaU26dhOdXbU9Oi6CWUUcfDU+TL5STevo1kFYS6j
xWKNK1DlkJPEbz7nQThnsaBG92ed22KMMbgiHs/gtUPUmaN+z42xmPWP4FU8+AQa
79LTpR+nXd2nfGauO1Mu9B0Ork4xNW00LsM95pJJ8dySQLl4L8cAaPNluM1J+5K5
M5aHSt9wZ+YUCtjac/CFBWAslo5sJZQmnKKWoxxkvLbIsoIsWTZgptFsHZ6Y3jf1
K38NNhv8kYd1fq3bS+Hb5GC+9EW/o22DcMaWhROngSXZH1hq5K3RWgN4TBztWNRs
5RnPStBJs6Y+mF/hspniI6qefGp7cuXwQ7PTUS1FRfzkiIhOdmgJRe7caVzWX6l/
XazbVYC6t1Ra+fOXiA1A1ExeA2nAuhhseloe+qMLJkilmVK/9R2GzD8QvCCL2Aki
gBwLZommY4L4Kptf6E6MYy/jysyYPWpk1D745u3uKJhroqh2gA804tKNQCMO12/g
H6LkC4Rb3mVVPVIG7RqAlwTgTkfBD2rQ7FY79EkHJ9/kLq3jlwD6/sY/34NC77nG
EKvt1G0HkN3CevF4p+i4cPks6yverXpuIDWswngwWjg4cgEZ6NHWjfIEJpBNCWR6
3r+tQiKutkcoZMmXBxuyaaIwWpDjYlTpZJewncqbU6AlZSAcFgjVM3BIyzcS68dr
JashBwKpvOuYf2ehq0gS+3Yn6yeHWhCjWnLMLkvxzz9SnIchlVm7G/BXN1HKTJNT
Ly0Tyzg3F+e45EgQkGwbtEwDMJ4e4C/7kuZyZ4TgW8MStemJMGg8bmJrJhBGdSRt
EEB9AW0VhlxGp+kdiycc8qi01+0mwnDpKDfA3eXnkOrhLQmV8Bdvj9vy+X8UcmZL
uI9u4/ICklxsHNiv4w/ZikKBNLJa/bvWusOub34cXdDV4p0WUswoeZlKdKFBp1G1
tiZozPJEEEjtVqSTk1k854BpFQtBA/6p8Alp6kbR5UjZ7FXamZ/HA06JPTt100aF
51ltl1YUb3+ncxm/MJStYMqgffyL8RiKAT+Jqt4zZfNHm9lWAij7iLtxL23r/wmr
Iv9ltQ6vGplUJIzhkqNuMdQcgsnjFWFW8JjK/G407SJxIQuL7QFA4zJu1rVAX0yn
uaDyYT3gsvbAoUvuDECqt3Hh0oIRhezYJhqkZTHXjYCYW18r/cPjS/h9PaOH6c6B
08VFTMzr3u6JsE3VKbnP/A8P6iTay6RsLz0Py2/Jq69w7+qnNh967v+QZ/BTaoaO
BPWIFo1hz78L1ile9lf3P1vBAmthyIMV9yAN2azyWNSYlFG/6mpkguhicTxRIGJg
Jl9ZkuK/QzltqjpPgwz+6ov5Ir9W/GyjtwbKcPc2r67tl5rPD3fqAAQGEUL1t8XT
XfwicHeMLHaUoyVITPzHz0x2pbDav3FqY+sf4fFcT4qwd4fMWgeAPpCUUJXP/nmk
OHVNcd7kGA3kOxWPaeUxKjmCbp+zFHfDU8wvQB81ggYIK+vr3j/S3N5kIPKEGSuF
nKj/waJezxxWrzKpaT63L6miOn9pZ2vpBiD/JAZCZrAiX1zXoZXT2KNIKxn2Q1cs
0UV90yOutlaFWXSq53vmdMR4tyzKfc2MMoM8fxkIauxz5FS52Hoi0fHnRiZt5VZo
gox+DYUObmiNzUI2eInN0lJ5omHL+AKiIO3eh9tWXHaFEa9uedO/ZkisBsga5Au5
lgfBrttbnnb5zY88A/d/7ya2uHBemuvY1bFI1bFwhHvWMz0nvxgkGkdOIacFmqQ1
RKKTFqjz5aT5gK6tA9w5991DLKhDRuiCN8EUuM5MCNDGfL5YcH1InwHvhFCiPUqq
RkLs1q8SFAC4080ckkNQR/iRAWxkTpqNt82RF4g/LDFsxQcVuEwPos4LN+khX0Cs
TxfBw7b75JHQW9iOh1IIEB7h/MkTB4l+ktcmx0U1nYI2kNM5p4qRb//trQQJqGYs
lQrauvzl7JGmSLPnCdPHg2JjUfbqFqGFloL+vpiVCP0qBWPEW+bRpCKywFQF+2S6
G4OyJSsxiptwQmDc30E9TDw6mpmHCiYbqZqWMZQWiSYGZ43Rkr/ZaQnMLM6wsQA7
IegY+hwp32XsP2dhRq/lF3eN7ZeWHgda9RC1oQSQjH5Sb4vDwG1pb1E+j9Tz1TlY
4zGljWkdOf1MXvTet/pn9AJws6A2Q9DqbBEIneyW2HkWc54I/TwQomsCGmwCclkk
BrRNyFBEcxFL+EQcxyQjSl2ABCDVQG12IyDTipF1MNMg7PEyNy2FF3e0tCda/jrl
ehgxLrx+KJAKc1tqRaEs18pMyOVDRaLb5Zdn24Wpdady13MfH6RokEd+q5qz5pij
cjrxumoYR31VTUTUiYwy1Cbm91vUfZvVdKbOMZC8G2n9+Hk53UtIjXHG+ta7zsSe
ya4MjF6gxzcXe/sK3C7enbBeU0iSpRGmh6dAUHQRUU2Q0jIdxPnJIHTJETxuzMS2
K7RjQfp9Wf4xTKNp0g10e9qVSk4JBraoC+sfvMAnbn68VgZUW6JSuN/O2nXkYc9K
75QQX5++Y0IOIX6NAINcE58buWcDemB6I0q2o+MnbQYmZQ24ExzxX+QOxsvp5iu6
MKAiFhpkkPcExQnbm58nWx5SB1RmhHqhn34TQjbt4GNo4iqoVFbkOy1SAuutEJj6
RiZtJSGVy+YQ6ytrZhSk6utVCebSx4mxzLxe8KriijDQ6p5ln37/kChZXIIsk3U2
mt2RepnevwYhjT2H3Qjq9xSz2H7+4Hgl/Mo6HIDFjSfXJxqdzzFz1ZP/Ma6n1ByC
zpC8QGkjtLTaH+a4XLZtL73QYSC48JVCdhew9J47NAFf2aEwzaYVPGIFWfvMzDso
0ZXsgRwaGqJxY5euV3eOPCAv+FqHTJvBFXgkZy6kTq0D1SnHvB1PnPpb/UoHOUrO
YA1Fhm5JkV2OkHI9MV3L3+61nocmZWWlSl01uhbMQCNo9/54CzGZQZJ1SkgKIbQf
H/Z4SylLvbghoNYQ9+APTqaKSRvLDf1XkBr4mfhHtXnHlEFftgLkOQVkxTIelBlN
Z7A3vgV6Fv36uP+bg11k4xGASBLLAURQbHBs6a6exDuJ9Msq0qVjjO8j3rOCghnd
jHwqy1vW1eL0fLOt60G5BkafDgv+WIIEDRjcVWDZcH60cZaIPbFaIaEokr5vRn0y
rTcEsolcOvnzOEWb8U6R/glhMqEHS37+ILrIXNNBjrJwXXLlxq6Y2iGCOdBKVdn1
YOlWgLVLzSZ50MTlMbtYdYpGEOxfIAyz+DikGyqvXRDeqn65me0urDFIpRP+f6Rv
4OKT6VuhYX5Q67i8HeL5LfoKt5NdSRS0WruRHbMqm4tWXkUtFUERF0Y37UgmqDfh
GtXTuFLztTOk/ERePV1zodaFZ0qozMjqtCCPM3pwDL+ZHbTZDYVXyp9Zd41gtdW9
vwilB0ZoN0Yob54XVN2VI0MBiqaeOiMM1KpVSYV66VrmnwbgjtZSmhz/yT/bGdap
WHfDmkJvgL49TVYGan2dccYiGrvl+tDCjVJ7bwaS8JOu/W8bZBvZj1Oujamvi6/e
Bx4x+Q5WUs0TfkXwjwT/5H1wXBbsthgRCEIT+neaCtsU06yazK/Br/yh6UBOq0Y8
60vio7pxb+YEqdj13aJy0avuMB78/vGOzHu76iUiN7nzy9rXLhU6wkoAcpyirFIV
OgIO+ft97/ZgWWJqzrHs/uV75h/PZWgrn12MMahGLK+KG4ZbP+45FO3abIQfVcR1
XbczAv34SSS6aC2iWQHgJCy8Nownn2WTW6k1SEkX9OG25gApuro15ngvXPxBn+M3
A1gTRyl1fp0660LwrSx7GbtFmTZAhCGjD3pgxQxFCxdoclu/dfmjISiFfmTJIXRw
zXvmRgOUDCpuwQjhecuFmFhM8exZxJSDsvY26L8pQMfbzrW9yB/ZQYC3fuKRfPQF
0ET2N2VG7bfGEvLtg8udfc+uJppxjMKch7Z0P7sWU22VJdwEHfLzNNjA/pMXNDkS
tY0IbOY2qZ4ITMmwb8qyoeCaiiODgkaZzsW2tyGJA4zvgtwoATgXFAkiZgomD5/6
UMTvmUWsG168vhrBiYMtGxCcSkm1tFFKuKJmiQtYLcxlBx3R+Y2nYGvZWtjKueO8
cyQoqkS0SPsCrrW3g2Mljpr/AtkYlluPuoD5eSR8BoO3FbnriAWgWBBdVOb4vjfc
PdSpwTldzkOmpteTU8xA39uTZxr8Q3+QK7eDG+T+zPowR1KjVhUyxMjrSyHig6D3
k/PRsAM8FElp8gg17MlKoX9hBETvmyRP5SXmXjExqgkmrq/ggdau6evIqHsd712w
a9A94i1ImOWHVoil8+W9OMhNCabCnfnsX5v+zTg8eDbvoYaajUxhi4Jv+sBBLtCz
iu11IQNiQE+QxiLNfZwN8HEDO9uXsHYaoou4BDvuv2r6Xh4k08ZZpK0LzzcBN2q2
6I1sUS+SX2cphaOIVRvZVw9qWun7EtSKh132XHm+CBYR2czfYyBrR8Uk8o3GiPtp
5lGs62gOggLKoQLyNPsnjhAcIsurhtoyFNHMf/FiojHwDTopkC2sYSuBWOT/3wJg
CcBDf0fviIxch2RC4UjQNRBDPRT1PUB32ltX9HFJsHCsMQ8Jwl//VBAHl/77e0t6
SrgKj29wZFEGHj8dwpxK3n3mXFL/yyq7Pa58j7ogjSwfoEba66TeYPF8GiCw/oLw
8V9QrJcviob1amCCQCnjxQcMLSboM5hz3TaVTE2d/t8w35lH4XlcYxpsFTBZG7tG
jRDgHqWK6HIP+Y0rERWAKclqSJJsgqEfSPA0S8ECjG6rQ76g8F2sQkG3TIeJyiyg
/m56T1jvrsEqIwUozPwH47OA93cXhbDMHgw+7pD3bRXULDyGtqse3E1y5TzetGIT
BE4ZWtrEREsLISHeG+2U9cENIL7kofKcH+NwqUVV1+xYe0jnwGsc+oKf1X6dIsIZ
5oC0zkcNjpao+NWqZhNvbUY96paM+EeEbIbYpER/Z/9usrWb3NqZkLljqloi9bi3
EqmEt/V5/G/QkkuO5GfT7a0uBHb93NBf2tQS2pNn+RzwK32jBK3rKTWRTVxRuVNy
e2IJ5te76P0D9FbiGgJK7kPghY0dfTcjMKTbizVgHfmWxU31ilg6bJQzvspQ4j7X
sknxpuQVh1lF/cR0D5BS2yLfERbkmm+j2FWv/EDLN79Cotyt1tSOoNrQYQQIn1Cn
rrae6vWq7qCix/V4z86CNJ/aVVrZDc+R9CA9NtGrc0eLmr9KiQ5giqJ2nkjLWk7Y
iJZG/QePgpCCK234bNQcPViyoWNX/Nz29JWBx+ojcu13J8NFLYGwAxkFWWAbPN3Z
sQmY+cywE2jgRj/OratrBJdKqm46ZhbbPcXhpT2ffHxhG5d8zGCkgIO3FNn7BZ0/
VSuNKt83cpJZbqcpXRydlY1/4/dXWy2MZ8WjeV1et+YfSqx3m39E7ziPJvdOpsTr
fmboqbxCUDFwZSACRpnvXpeq4UWi4naxlAX+TIMuvBg=
`pragma protect end_protected

`endif // GUARD_SVT_APB_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZMaH6jvjxgr4RCloawh4R55fbWDBRkzuvNF+k62/jvM52nABRLlwbJ/i1lWYjiUG
obxMXEMWIdoVFuIWpeHdbb4OPuVXNU12pSIVS08N+eM/JbL4v6cWFGsS/ji6aYHX
KpxXOIzMNSGxZ2g/qEpKbysgIUc6mmSwoDfpiaSlv6g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22811     )
wqvuKwT7bEx7bemhVXCWqdC01crWncHZuUgqP/sYoRGLHQms7ngoG8bu1uEjO8nk
c9p1R1jbKhLTnEtQ0q9ULYQArUCrxtV7h3rTpfGOOxV2Sc4Y6Eq32dyi8v3xfpZT
`pragma protect end_protected
