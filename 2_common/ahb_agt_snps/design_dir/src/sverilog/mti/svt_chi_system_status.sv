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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YUMAqpiBlnx5M5p1Qq4qQt+bsL3DrqVaVFssN5PynOy9vWJsfJuI61mw2xvyukaE
q5FJp2U4DJuE5zOGIREbvwrUudcCCQ6+4AcRWVoUraTq6LfyP46nkgpZ/aplXkKC
Y+gadaFzL/kPbyf52ulBDpV3QgNhVGZs/ZHkW8UtWjM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4178      )
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
lV+kA8Nhz9nHN+M4UuqO0Q==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C+omEtG+GlPZ0d/avGxVCCYEceXAthtMUHlBr3XUQ/E40SoHoXvIauRFiO28e03I
Qgswf8OtmFKcg0JQBZLSkBCWHFTIq28wowClu7hnCalh+ncQ2mtq5Zj4Gonoeaw0
Scoh19DQu1REYEcStp8qufVatc+tg23BX9AgVlWrvck=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22352     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n1PJGczLYT9QgpO0FUQzi1bknAS51DgABkgozyXbdEVrzNG6+RoGqc8gXl1+nxjh
gyYqgZCvV4ItEqn+/VzRxeCv2LvjC2F8yObmTdYwzxH4RLuOKllDNCddoJ1XOcYO
YEFbVqL4COzrkJ3qrUJdvFdonvZAS4B3woeFvsycE5I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22435     )
afJjvrr3QRHbvimYyre0oTGxkSgTw/o+C5XGSkxzJklJ+ivaUgx6sLCMKUccTIPP
tXtrkYtjUYl75l0g9RyZ9qlXXV26gSpUVZgJ2PEglQfdPIkC84bV7nHIaDHJ00BO
`pragma protect end_protected
