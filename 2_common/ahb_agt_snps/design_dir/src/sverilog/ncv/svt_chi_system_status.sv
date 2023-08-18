//--------------------------------------------------------------------------
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SYSTEM_STATUS_SV
`define GUARD_SVT_CHI_SYSTEM_STATUS_SV 

// =============================================================================
/**
 *  This is the CHI System status class that keeps track of CHI system performance metrics
 */
typedef class svt_chi_system_transaction;
typedef class svt_chi_transaction;
typedef class svt_chi_node_configuration;

class svt_chi_system_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * Dynamic array of svt_chi_system_hn_status objects, with one entry per HN in the CHI system
   */
  svt_chi_system_hn_status system_hn_status[];
   /**
   * Handle of the system configuration 
   */
  svt_chi_system_configuration sys_cfg;
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** timeunit string which is a combination of the timeunit multiplier and the timunit */ 
  static string timeunit_string;
  
  /** @cond PRIVATE */
  /** Timeunit multiplier. This is calculated once in a simulation */ 
  static int timeunit_mul = 0;
  
  /** actual timeunits used */
  static string timeunits; 

  /** timeunit factor for calculating throughput, bandwidth in MB/s */ 
  static real timeunit_factor;

  /**
   * Variable that holds the interleaved_group_object_num of the transaction. 
   * VIP assigns a unique number to each transaction it generates from interleaved ports.<br> 
   * Applicable for interleaved ports only. For normal ports it is same as obect_num.
   */
  int interleaved_group_object_num[*];

  /** Semaphore ids for each interleaved groups */
  local int system_sema_id_for_interleaving_group_id[*];

  /** Semaphore for each interleaved group */
  local semaphore system_sema_for_port_interleaving[];

  /** Semaphore for all the ports of all the interleaved groups */ 
  local semaphore system_active_xact_queue_sema;
 
  /** Queue for transactions from all RN with port interleaving enabled */
  local svt_chi_transaction system_active_xact_queue[$];

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_system_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null, svt_chi_system_configuration sys_cfg = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_chi_system_status", svt_chi_system_configuration sys_cfg = null);
`endif


  /** @endcond */ 

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_system_status)
    `svt_field_array_object(system_hn_status,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOPACK,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_chi_system_status)

  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_system_status.
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

  // ---------------------------------------------------------------------------
  /**
   * Do print method to control the array elements display
   * 
   */
  extern virtual function void do_print(`SVT_XVM(printer) printer);

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

  /*
   * update_latency_perf_parameters : Calls all latency perf parameter updation methods defined in HN System Status
   */ 
  extern function void update_latency_perf_parameters(svt_chi_system_transaction sys_xact);
  
  /*
   * get_latency_perf_statistics : Calls all average latency perf calculation methods defined in HN System Status
   */ 
  extern function void get_latency_perf_statistics();

  /*
   * update_inactive_period : To get the inactive period because of reset
   */ 
  extern function void update_inactive_period(real inactive_period);

  extern function void set_port_interleaving_semaphore();
  /**
    * Adds ordered transactions to system queue
    */
  extern task add_ordered_xact_to_system_queue(svt_chi_transaction rn_xact);

  /**
    * Tracks active transactions. When transaction ends, it is 
    * removed from system queue
    */
  extern task track_active_xact(svt_chi_transaction rn_xact);

  /**
    * Gets the ordered transactions from the interleaved group id
    * of the transaction given in master_xact
    */
  extern task get_active_ordered_xacts_in_interleaving_group(svt_chi_node_configuration cfg, output svt_chi_transaction ordered_xacts[$]);

  /** Gets system semaphore for interleaved group id corresponding to xact */
  extern task get_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);

  /** Gets system semaphore based on try_get for interleaved group id corresponding to xact */
  extern task try_get_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);

  /** Puts system semaphore based for interleaved group id corresponding to xact */
  extern task put_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);


/** @endcond */

 // --------------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_system_status)
  `vmm_class_factory(svt_chi_system_status)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TCPDMskFD0PtxtKxm6i9N+uIqQ0mmjfaKkC9oB7rDzXcrCeW38n0WrMJAkC4FfeT
uMzZFILtN5HfCKa7gTWBd4NXKos9eWpr9s9BdxSSpo7MEOg1UT4Srhu1ON3XaqPB
9NlWiDomu+bG4d7RsbMsQ4YHtR3lGPPvWKcabwHDrnr4HENnpxDciQ==
//pragma protect end_key_block
//pragma protect digest_block
c6xYbpvZ2I7nqyh4oCFflLsuIaM=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
knr05oBDPBvgGVY0bEcfhf517sA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
j92JPf+CMmnGMDjz/q/jf5mec9+bX/hJtxUJ1wiC1AyOnfURlr9L9ODQRHAG7zvz
tOypJfUa3kaI0wqy1LBysC+1VqTMXXiZyjkLN17VLngAi97CRzvhdhRs3tJhXQi5
6bDb+ipTm+P6k8mdHvXhKB/m0EKJQfvaYCjWQmbCxj+YO3XyaUpHUw==
//pragma protect end_key_block
//pragma protect digest_block
Blu9VetK4/SSE7Miu4Ph9AxHvjE=
//pragma protect end_digest_block
//pragma protect data_block
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
WM0qE2Pk+ivH91zjSDdURQ==
//pragma protect end_data_block
//pragma protect digest_block
+XLEjVYmUCoVd+uV0Qs0sWVJd/k=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV


