//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2019 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_INTERCONNECT_CONFIGURATION_SV
`define GUARD_SVT_CHI_INTERCONNECT_CONFIGURATION_SV 

`include "svt_chi_defines.svi"

typedef class svt_chi_node_configuration;
typedef class svt_chi_system_configuration;

// =============================================================================
 /** 
  * AMBA CHI Interconnect Configuration
 */
class svt_chi_interconnect_configuration extends svt_configuration;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------
  // vb_preserve TMPL_TAG1
  // Add user defined types here
  // vb_preserve end
  /** Custom type definition for virtual CHI interface */
  typedef virtual svt_chi_if svt_chi_vif;
  
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** @cond PRIVATE */
  /** Defines the SnpQuery Policy, specifies when SNPQUERY must be sent by the interconnect for a given coherent transaction */
  typedef enum {
                NEVER_GENERATE_SNPQUERY,
                ALWAYS_GENERATE_SNPQUERY,
                GENERATE_SNPQUERY_WHEN_SNP_FILTER_IS_DISABLED
               } snpquery_policy_enum; 
  /** @endcond */

  /**
    * Enumerated type that indicates how Interconnect need to respond to a Write with Optional Data type transaction(WriteEvictorEvict). 
    * - ALWAYS_RESPOND_WITH_COMP : Always respond to WriteEvictorEvict transaction with Comp response.
    * - ALWAYS_RESPOND_WITH_COMPDBIDRESP : Always respond to WriteEvictorEvict transaction with CompDBIDResp response.
    * - RANDOM_COMPDBIDRESP_COMP    : Randomly respond to WriteEvictorEvict transaction with either Comp or CompDBIDResp response.
    * .
    */

  typedef enum {
    ALWAYS_RESPOND_WITH_COMP = 0,        
    ALWAYS_RESPOND_WITH_COMPDBIDRESP = 1,        
    RANDOM_COMPDBIDRESP_COMP = 2        
  } writes_with_optional_data_xact_response_type_enum;

  `endif 

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Modport providing system view of the CHI Interface. */
  svt_chi_vif chi_ic_if;

  /** Reference to the AMBA CHI System Configuration object. */
  svt_chi_system_configuration sys_cfg;

  /** Enables snoop filter in the interconnect */
  bit snoop_filter_enable = 0;

  /**
    * - Indicates if the interconnect supports the Issue B spec (CHI-B) or ISSUE C spec (CHI-C) or just the Issue A spec features.
    * - Can be set to ISSUE_C only when the compile time macro \`SVT_CHI_ISSUE_C_ENABLE is defined.
    * - Can be set to ISSUE_B only when the compile time macro \`SVT_CHI_ISSUE_B_ENABLE is defined.
    * - If the compile time macro \`SVT_CHI_IC_CFG_DEFAULT_CHI_SPEC_REVISION is not defined or is set to ISSUE_A, chi_spec_revision will be set to ISSUE_A.
    * - If the compile time macro \`SVT_CHI_IC_CFG_DEFAULT_CHI_SPEC_REVISION is set to ISSUE_B, chi_spec_revision will be set to ISSUE_B.
    * - If the compile time macro \`SVT_CHI_IC_CFG_DEFAULT_CHI_SPEC_REVISION is set to ISSUE_C, chi_spec_revision will be set to ISSUE_C.
    * - If the compile time macro \`SVT_CHI_NODE_CFG_DEFAULT_CHI_SPEC_REVISION is set to ISSUE_D, chi_spec_revision will be set to ISSUE_D.
    * - If the compile time macro \`SVT_CHI_NODE_CFG_DEFAULT_CHI_SPEC_REVISION is set to ISSUE_E, chi_spec_revision will be set to ISSUE_E.
    * - Configuration type: Static
    * - Default value: ISSUE_A - as controlled by user re-definable macro \`SVT_CHI_IC_CFG_DEFAULT_CHI_SPEC_REVISION.
    * .
    */
  svt_chi_node_configuration::chi_spec_revision_enum chi_spec_revision = svt_chi_node_configuration::`SVT_CHI_IC_CFG_DEFAULT_CHI_SPEC_REVISION;

  /**
    * Specifies the version of the DVM operations supported by the interconnect.
    * - DEFAULT_SPEC_VERSION     : The node supports all the DVM operations that are specified in the specification corresponding to the chi_spec_revision.
    *   When chi_spec_revision is ISSUE_A, the node will support all DVM operations that are supported in ARM v8.0.
    *   When chi_spec_revision is ISSUE_B/ISSUE_C/ISSUE_D, the node will support all DVM operations that are supported in ARM v8.1.
    *   When chi_spec_revision is ISSUE_E, the node will support all DVM operations that are supported in ARM v8.4.
    * - DVM_v8_0                 : The node supports DVM operations that are supported in ARM v8.0.
    * - DVM_v8_1                 : The node supports DVM operations that are supported in ARM v8.1.  Can be set only for CHI-B or later Interconnects
    * - DVM_v8_4                 : The node supports DVM operations that are supported in ARM v8.4.  Can be set only for CHI-E or later Interconnects
    * - Default value is DEFAULT_SPEC_VERSION.
    * .
    */
  svt_chi_node_configuration::dvm_version_support_enum dvm_version_support = svt_chi_node_configuration::DEFAULT_SPEC_VERSION;


  /**
    * Indicates if the node supports ReadSpec transactions 
    * Can be set to 1 only when the SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE macro is defined and chi_spec_revision is set to ISSUE_B or later
    */
  bit readspec_enable = 0;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** @cond PRIVATE */
  /**
    * Indicates if the Interconnect supports Atomic transactions.
    * Can be set to 1 only when the compile macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined and
    * svt_chi_interconnect_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * Currently, the interconnect does not support Atomic transactions.
    * Therefore, atomic_transactions_enable must be set to 0.
    * - Configuration type: Static
    * - Default value: 0.
    * .
    */
  bit atomic_transactions_enable = 1'b0;

  /**
    * Indicates if the Interconnect sets the same DBID field value in Comp/CompData and DBIDResp message for atomic transactions
    * Applicable only for atomic transactions.
    * Applicable only when the compile macro SVT_CHI_ISSUE_B_ENABLE or later is defined and
    * svt_chi_interconnect_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * A value of 1 indicates that the value of DBID in Comp/CompData and DBIDResp/DBIDRESPORD message for atomic transactions are different.
    * A value of 0 indicates that the value of DBID in Comp/CompData and DBIDResp/DBIDRESPORD message for atomic transactions are same.
    * - Configuration type: Static
    * - Default value: 0.
    * .
    */
  bit allocate_diff_dbid_value_in_comp_and_dbidresp_for_atomics = 1'b0;
  /** @endcond */
`endif //issue_b_enable

`ifdef SVT_CHI_ISSUE_D_ENABLE
  /** A value of 1 indicates that interconnect will be able to receive and process CleanSharedPersistSep and Combined Write_CleanSharedPersistSep transactions. <br>
    * A value of 0 indicates that interconnect will drop the CleanSharedPersistSep and Combined Write_CleanSharedPersistSep transactions if received. <br>
    * If RN is generating CleanSharedPersistSep or Combined Write_CleanSharedPersistSep transaction, then this configuration should be set to 1 in interconnect VIP or ICN Full Slave to enable the processing of these transactions.
    * This parameter can be set to 1 only when chi_spec_revision is set to ISSUE_D or later and the compile time macro \`SVT_CHI_ISSUE_D_ENABLE is defined. However, Combined Write_CleanSharedPersistSep transactions will be processed only when chi_spec_revision is set to ISSUE_E or later and the compile time macro \`SVT_CHI_ISSUE_E_ENABLE is defined. <br>
    * Default value: `SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE, is controlled through user re-definable macro \`SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE.
    */
  bit cleansharedpersistsep_xact_enable = `SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE;

  /** A value of 1 indicates that interconnect will configure return_nid to that of RN in cleansharedpersistsep request issued to SN.
    * A value of 0 indicates that interconnect will configure return_nid to itself in CleanSharedPersistSep request issued to SN.
    * This variable can be set to 1, when 
    * - cleansharedpersistsep_xact_enable is 1.
    * - HN is configured to forward persist cmos to slave.
    * - chi_spec_revision is greater than ISSUE_D.
    * - SVT_CHI_ISSUE_D_ENABLE or later macro is defined.
    * .
    *
    */
  bit persist_response_from_sn_to_rn_enable =0; 
`endif

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** @cond PRIVATE */
  /** 
    * Specifies when SNPQUERY must be sent by the interconnect for exclusive MakeReadUnique transaction.
    * Default value is GENERATE_SNPQUERY_WHEN_SNP_FILTER_IS_DISABLED
    */
 snpquery_policy_enum snpquery_policy_for_excl_makereadunique = GENERATE_SNPQUERY_WHEN_SNP_FILTER_IS_DISABLED; 
  /** @endcond */

  /**
    * Indicates how Interconnect need to respond to Writes with Optional Data type transactions (WriteEvictorEvict).
    * When set to,
    * - ALWAYS_RESPOND_WITH_COMP: Interconnect VIP will always respond with Comp response to WriteEvictorEvict transaction.
    * - ALWAYS_RESPOND_WITH_COMPDBIDRESP: Interconnect VIP will always respond with CompDBIDResp response to WriteEvictorEvict transaction.
    * - RANDOM_COMPDBIDRESP_COMP: Interconnect VIP will randomly respond with either Comp or CompDBIDResp response to WriteEvictorEvict transaction.
    * .
    * This is applicable only for Interconnect VIP and not applicable for ICN Full Slave.
    * - <b> Configuration Type: Static </b>
    * - Default value is RANDOM_COMPDBIDRESP_COMP
    * .
    */
  writes_with_optional_data_xact_response_type_enum writes_with_optional_data_xact_response_type = RANDOM_COMPDBIDRESP_COMP;

  /**
    * Indicates whether tags are returned along with data for read request when tag_op is set to Invalid. 
    * When TagOp value is ‘Invalid’,
    * - It is permitted but not required that Tags are returned along with data.
    * - If Tags are returned along with data, then they must be Clean.
    * - Default value is 0
    * .
    */
  bit return_tags_if_available_when_read_req_tag_op_is_invalid = 0; 

`endif

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * The number of nodes of the interconnect connected to RNs.
   * These nodes connect to the RNs in the system:
   * - Min value: 1
   * - Max value: `SVT_CHI_MAX_NUM_SNS
   * - Configuration type: Static
   * .
   * 
   */
  rand int num_rn_connected_nodes;

  /**
   * The number of nodes of the interconnect connected to SNs.
   * These nodes connect to the SNs in the system:
   * - Min value: 1
   * - Max value: `SVT_CHI_MAX_NUM_RNS
   * - Configuration type: Static
   * .
   * 
   */
  rand int num_sn_connected_nodes;

  /**
   * Array holding the configuration of the interconnect nodes connected to RNs.
   * Size of the array is equal to svt_chi_interconnect_configuration::num_rn_connected_nodes.
   * 
   */
  rand svt_chi_node_configuration rn_connected_node_cfg[];

  /**
   * Array holding the configuration of the interconnect nodes connected to SNs.
   * Size of the array is equal to svt_chi_interconnect_configuration::num_sn_connected_nodes.
   * 
   */
  rand svt_chi_node_configuration sn_connected_node_cfg[];

  /** 
   * Number of cache lines for each HN-F node.
   * Configuration type: Static
   */
  rand int num_cache_lines[];

  /** 
   * Configuration that indicates critical chunk fist wrap order supported by interconnect
   * - when set to CCF_WRAP_ORDER_TRUE : Interconnect guarantees to maintain transmitted data packets of a transaction in ccf wrap order
   * - when set to CCF_WRAP_ORDER_FALSE: Interconnect does not guarantees to maintain transmitted data packets of a transaction in ccf wrap order
   * - currently CCF_WRAP_ORDER_TRUE only supported by the interconnect
   * - Configuration type: Static
   * - Default value is CCF_WRAP_ORDER_TRUE
   * .
   */
  rand svt_chi_node_configuration::ccf_wrap_order_enum icn_ccf_wrap_order_enable = svt_chi_node_configuration::CCF_WRAP_ORDER_TRUE;

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
   * Valid ranges constraints insure that the configuration settings are supported
   * by the chi components.
   */
  constraint valid_ranges {
    num_rn_connected_nodes inside {[0:`SVT_CHI_MAX_NUM_RNS]};
    num_sn_connected_nodes inside {[0:`SVT_CHI_MAX_NUM_SNS]};
    rn_connected_node_cfg.size() == num_rn_connected_nodes;
    sn_connected_node_cfg.size() == num_sn_connected_nodes;
    // vb_preserve TMPL_TAG2
    // Add user constraints here
    // vb_preserve end
    foreach (num_cache_lines[i]) {
      num_cache_lines[i] inside {[1:`SVT_CHI_MAX_NUM_CACHE_LINES]};
    }
  }

  /** @cond PRIVATE */    
  /**
   * Reasonable constraints are designed to limit the traffic to "protocol legal" traffic,
   * and in some situations maximize the traffic flow. They must never be written such
   * that they exclude legal traffic.
   *
   * Reasonable constraints may be disabled during error injection. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG3
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }
  /** @endcond */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_interconnect_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_chi_interconnect_configuration");
`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F8iszlAzLPZVcHJz1hTNHi4O8NvACdSGrkRnXm0bz35fRX6VXqNkssxTA74CiHW1
8LYYMoNoP+v8Ams6z5uKCQfASgoa/l45Ghgl1GY0durIC31txRBgk5YvVYrLe9j8
M+xw3HNWYYYTkh8qD4TjQNC+ssZAK+LErfcJeCtLjv0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 362       )
EyWWUdtkZ5Y6Y4Vnv+2XsrATlo/7SMYQEb4fu9SIwqGveuktbY7Pi0cKyiLJVuL9
SX2umRKh1qe13wNLxIMsRfhTTDbBVE6ArLX4usKua0ZFQCJrI3WzrkBl1XG36FgD
ddM0eUvN9p/dT6OlkOqrBfkdUrrdBVSceTw/NxLTLntkunOWdJX0f/9T4h0FAXYL
sZfBlBEMZAiRiUr0hlw/voXRTkEIH9NrsepBLo6Kh9X9T23pOy33x07oksM2rP7m
PIwHQJiWEl0mN1FI+xYFqa1exI2q4W5C5+ob49czEpLfw1b5vq1H4X+XUU7HZ/d/
FQRNjOoEPlUPKmClKsyQUBEiFc1gC/c68039pOmE2wBkuLpbwFA1Emp2pvSQPy+f
QPJK74yNlws5XSet66sPNsVS9dZk29/8ZJtaEiEclDiT4a2HvFtLkFOo0q9VAZr9
P11eD9hrECsJgskzC6b9aBpRnKdIUEE+f6p67ntxvOc=
`pragma protect end_protected

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_interconnect_configuration)
    `svt_field_object(sys_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_array_object(rn_connected_node_cfg, `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
    `svt_field_array_object(sn_connected_node_cfg, `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_chi_interconnect_configuration)

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Override pre_randomize to make sure everything is initialized properly.
   */
  extern function void pre_randomize();
  
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_interconnect_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   * 
   * @param to Destination class to be populated based on this operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_sub_obj_copy_create(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   *
   * @param rhs Source object to use as the basis for populating the master and slave cfgs.
   */
  extern virtual function void do_sub_obj_copy_create(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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
   * Does a basic validation of this configuration object.
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
  /** @endcond */

  // ---------------------------------------------------------------------------
  /**
    * Creates the rn_connnected_node_cfgs and sn_connected_node_cfgs based on
    * num_rn_connected_nodes and num_sn_connected_nodes
    * @param num_rn_connected_nodes Number of nodes in the interconnect connected to RNs
    * @param num_sn_connected_nodes Number of nodes in the interconnect connected to SNs
    */
  extern function void create_sub_cfgs(int num_rn_connected_nodes, int num_sn_connected_nodes);
  // ---------------------------------------------------------------------------
  /**
    * Sets the CHI interface in this class. Also assigns the sub interfaces of each node
    * to rn_connected_node_cfgs and sn_connected_node_cfgs
    * @param chi_if The top level CHI interface
    */
  extern function void set_ic_if(svt_chi_vif chi_if);
  
  // ---------------------------------------------------------------------------
  /**
    * Returns the index of the Interconnect RN node corresponding to the ID passed  
    */ 
  extern function int get_rn_connected_node_index(int rn_id, bit is_extended_node_id = 0);
  // ---------------------------------------------------------------------------
  /**
    * Returns the index of the Interconnect SN node corresponding to the ID passed  
    */ 
  extern function int get_sn_connected_node_index(int sn_id, bit is_extended_node_id = 0);
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_interconnect_configuration)
  `vmm_class_factory(svt_chi_interconnect_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fep3gz+T4VnXhIACWxKgoV2i3caHf0yRsdUMFm2xxRT9avzDTvLUWsDOFtk2A/dv
+2q8nt3Q+jWjuAogzgxLTULDmhzl2jSzYGR15UDp+pE2xy6/lVmJpNIFNQBF+Bjf
VGyzghzvJjBNTd4N79eeclvyJVNADeICIvDSIQK15mw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1825      )
l3QrQqErnRruSez9gZtjnkuSbcg5NolFT6c6T0SFTRySaVc6VD9jh3N+01RXAeDp
VNHV7O7YrbeLVtkx1kwmFBGfv7riGdGuZno+q3UnwEhfMnMfMZEAyg5B59rGKwK2
76dmOS1Vlnb3vgCm39oNgfrL92T9XB7NE2vdm0t2pSreGDEGWMiEZLPhvB2f0dcq
xQ6V1c5dx/4yZEHtfr/BU3RVY/+hcdq/Je8ZjFo7Y+3DbnEsHjAy4QkhNQr7/C1O
BkRCYAWLaYCDG87oVCX0F/+my0U9Ygkjq79+tqyKldGyHoOe0rYBwy+qIbmr96lK
lgeq2WSalHRxwM3rUKlSYJukHRn91WOyc17bB18ExkvramLXtyreOwf+JScphSqS
WrXxZiDvtF7xfh3GtADRTgThVwUxg64FfQKNHn+eNV0yFY98ytfsKMTt3qRJjX/Y
RqYX8jDJ/8S5MgJyB29BTSfQbpFE7d4I28h/EQY5wUA5xxA31dWEhGSymVDwZPrV
A+QafRQ7aEfQe6Nms2IWby3LEDCBykWnKJdL2TpvybPkuJfVMV/8KGM5QOJ6u7Ft
JBjpOQnBnA8EO8x6P0axQLat+vV8oPYjuUlyaP+Ugg4q6jFxQ666LYER9mfe8rXC
yr0DchzKBFxDbqpW2+V5fa1mEh329Y8JRgek/DFAl43TLTdepVcIvVtxhXFeop65
H/n8b23gelV260OCvS2VXd6nqM7BVicPGj8dUUUifaZuUx50bsUzOFDK7Uqs3GNn
A5tTdPvJsvcuklCqz8U8pB+rBXDS6KieQcQvA2HUWEwXirWh+1g2A/fbo/TpIpV8
xRfBmFyM+TpBPkFb+CmGPLqLUhlScjFNHAtr/U/oRLj5l0w8ptGBo2OzwAUoJNqg
UBhBUacDcH+O8M0h/THyzLjGCOd50q6rrK3K/wbLkdbExWwARE45Cd9/sqSjPUPD
oQyoHeENN+/NlmjT6W37iffhHhXz2ptDLslRCZ/DjBIrfVxsbq4w07FHZvxNSd7H
DLpKRYmbFLFxmdArK17CXyFFuV/v14UDzp78eGotH0TjhqkbGpOyVgdBCERMvq+M
UxHekfVSKzDm/efcbJ2StF+XghVYpAr6J884gweCCBiAWGFEq1QAv8EOJA4hjULp
XY4H1uxN0sUZwiOdgVrOPrgLAhJu/zVMVq5Gz6h+8ZGEiL7hS4UrYCLOAc8ME0jC
YEhzgsoJmFMENR5n+hvCjYamv08161fEC1BDImVKhI60rIb4hzo9EwRyuOMBWcah
9Kd16JutTVE/ekvFLnINqyjDPGmG/kCmoh3BdEeb6cura5ldrNkF1ZMGzjoeKfPn
SVtgRu0fy4ZodRF5o/7dbYqpPBolcPSP5MSrvpH03UsdhvQI2xlUG/Aalt927TlU
+u3GSGwGbrcXjCFBKxOtCv2vJv0SbAKveaAPPfM1qovJ160gUsAnv0v/NJJVyCgT
3cllXILt3Embl0WOy4CRmMDg8Jloh2JTL549zA6TFX+olsKk4ERK3asPMO+68v3J
d8ATU+kgi7poUFNLoXcVYQ/dpeSL7bVhKhVrQF0Wnt8skX/iwVNmB7RmBrMrXWd/
1E39NlMaXFHDhP0K95P1m2/9zeQ5ookJ2bCb/4LvS71KkX5CZjT26OX4VoGusFbb
f+EwNL/DQIOhEBVhHGpiET3p3R0Lq9rK5WzFF26cK1+gitnUKTwwMBUaAW111c4G
FCQQv80nMit6t6N+jlrBUo9XaLjCqpJHUncz9/UPzwRS3i+FKuP4mwnJtt4hDW7H
knbFkRzRL90pH1OL68EvPVCaZ/YUQ0oUJ7KQiypP24FqOXMlMARF/9Ic2QLY7c99
WHdR+Bv3IcmBrLIJYrtCq2IF75IlHvDcsmG2BqSiF7lk3SAemCUhQ8ZtwYoebym3
92HRca0FneaK1XcEoNYp5PWa42lLgFFakcGVgzyDX3A=
`pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_chi_interconnect_configuration::pre_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GggqN1AfCttuXx2SbSxWSVfVrIYzBkvTy/wnmjFhfktuHYVsGbaOQ5a3/GAVIKfw
qqxSukYgzaaW2fAlHNaxujvyKVDYYeCdrgRp4DplvESCBvfGicgU4ZM/Y+UZJDwO
oHLMvJJoCmru7FatypWpQrPRt2PG6a9SSxEv/bpEkc4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2484      )
NUsNhDlQXNNzwNuN6Z5xaC+PD/SNKFuzrOBr+ophFWEgxdE5XTscZL+eQ/bJzUga
ijAf+Y/pMdleq04A9+9zjlF1RY/uMnhTc/QXKqZTaXitG+y2W97mOgnbNo2iiaTc
3uHql3NJjGAdTUzHdPEJiULdNroYc8bYCMBXkWo5HhJrcrrqMoeLfP8kfZig3LXQ
ElS0VOZLcy+6rhq1tbbS5soPSfnzPau2AUC/iRFowAqRlTaXPrZC6fZ3K0V0omlr
wfyaWOCu40PGod41E5fdJPCdgivj4cAFuQCt2HNV7kQkAAczmRhkwb9GrniMrR+8
di9klUllSx64BBLfV0mGKTFk2T4pkdejV5Bs2N3wuYicIBoiOc+xxq7BNRW3PTZa
8QQSKOAT4DtXpWI9wAwzE5fZC2tu5DiVYF/P1gbJZTiajKkyCAGBxtuK2N2zabG8
N5ZWqTKeYeJI2VxYUWDnpfibBdv9hv8cKyN1cMTik3wY05hL2grW0chXz8DWZRuL
4AjvLlMoR6ejOLkH5InSS4so8c/61pxVtOHR5v1muMKc+zngrMtmURaF818L7tXY
gejAeBwg+ZEI/ajAX0n7ByPA4aRgY489mEh/xao6BY75f33ePw9OtwYCpo7ix+Sj
CZTSCXabPanwZr0wYOKriplpNO6Eafh1hYKHnAt8UzPZtq0rpWhmPyhEiOL4neUZ
82N0CCujLpCs04IXW2cG9iAnfyJdb5YnXSzH9wBczn6RR7Ksb/y9r0RcSEN5NSVx
+YDulL46MmrrjZyAtNytztkOCc8jsIs0x9KUQ1xHYDweSJaDqg0tgBhRHt639ws1
R7+4Jhba2Mp9i/Ulnfprc9Gr3dCSeKmGtaCCwnm/mGcuGKD4nzEf86J5lUIaoDuV
`pragma protect end_protected
endfunction

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
d92FxnuRV90DGfL8hDvTDmv4yepuZOnF6NdTtRVY/xwkeGYKV4svelS8cODtaTp/
QhP7B1x5xMnMwVCtJjlHHEbjrjrjQIhTsxavwOOndeyirTg7kGZFQHUm236AmtZX
ZEx6vFP3hVXJuThJDlkkuAp8lcuPZl988WVsYBW2i2U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4208      )
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
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iTZ8bBsDoPmi8TmcwNQoXM0+VJkq8rw/uiGXVg5Cvw62BpOK+RCR8guWgoIpmpH4
ftSSzHdaLDiLtGYKdm067yQ10kmtnE2B/P45tPiiUA8NCI1IBwTn6FQ3NzAng8MT
Gi6WdvVL8sjQZ5FXNINpu2YjAzA5MT9atf+olU9zsy8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6371      )
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
YcXnl43yEtOIlEwE6A4fbg==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XLh2XgcM5q8uW08yhzDEe2Mc5lF/C7ZoMEquNyy+zpOWQGrzQOFSjvYrAtH1AkEP
k/38rKIEYd0Eklp8IqDKROBMklfpe9LSum7K8ytRbc87918gsJQc76PgN5FRjZ8P
9BJft1m0ZuW0kEdhj/RYKdZV8t+zoEC39CZ2xRlf2bo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 47080     )
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
vsO6l614Lx3h/DMQ0WpbNA==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_INTERCONNECT_CONFIGURATION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n0KGDbjRTsOl9bIzvx6A2R4w+uWNXt2b8QfUA1SV5POhDyy0TIJ8G4U3LdgcOGOG
4DJcvvzXH7XYqqOsmShBGUs9piARANYScPweQcxZUQcLEdr/vGFOHVbyztW7Otcn
uMSOfEo23NCz76IleF1a8VJ9Jsjro0FgKvmKoLzbcEs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 47163     )
dzcni2d4hWaHLrO5qqqkfFkJRKcQRH594F1oUWMsObF81lZiYV4MQFj6DMDUihSM
2El8w6HjhUAX/1+WbyDOyvDryEhwnYB3zpnlH0/jS++2h2KBGOnK3Lm6OUKDfsaC
`pragma protect end_protected
