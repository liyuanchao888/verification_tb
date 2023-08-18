//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_PROTOCOL_STATUS_SV
`define GUARD_SVT_CHI_PROTOCOL_STATUS_SV 

// =============================================================================
/**
 * This class contains status information regarding protocol layer of RN, SN agents(uvm)/groups(vmm).
 */
class svt_chi_protocol_status extends svt_status;

  /**
    @grouphdr chi_outstanding_xacts Outstanding transactions related counters
    This group contains counters that can be used to track the current status of outstanding transactions at the node
    */

  /**
    @grouphdr chi_exclusive_xacts Exclusive access related counters
    This group contains counter that can be used to track the number of exclsuive accesses completed at the node
    */

  /**
    @grouphdr chi_driver_xact_internal_counters Counters Protocol layer driver internal counters
    This group contains counters that can be used to track the current status of dropped, auto generated transactions at the node
    */
  
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  /** Reset status indication. */
  bit reset_status = 0;
  /** @endcond */

  
  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding transactions
   */
  int current_outstanding_xact_count;

 /**
   * @groupname chi_outstanding_dvm_snoop_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding transactions
   */
  int current_outstanding_dvm_snoop_xact_count;

 /**
   * @groupname chi_outstanding_snoop_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding snoop transactions. Fwd type snoops, stash type snoops and DVM snoops are excluded.
   * 
   */
  int current_outstanding_non_fwd_non_stash_snoop_xact_count;

 /**
   * @groupname chi_outstanding_snoop_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding snpmakeinvalid transactions.
   * 
   */
  int current_outstanding_snpmakeinvalid_xact_count;

 /**
   * @groupname chi_outstanding_snoop_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding snpcleaninvalid transactions.
   * 
   */
  int current_outstanding_snpcleaninvalid_xact_count;

 /**
   * @groupname chi_outstanding_snoop_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding snponce transactions.
   * 
   */
  int current_outstanding_snponce_xact_count;

 /**
   * @groupname current_outstanding_xact_retry_count
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding transactions
   */
  int current_outstanding_xact_retry_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Read transactions.
   * The Read transactions include:
   * -ReadNoSnp
   * -ReadOnce
   * -ReadShared
   * -ReadClean
   * -ReadUnique
   * .
   */
  int current_outstanding_read_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Write and Copyback transactions.
   * The Write and Copyback transactions include:
   * -WriteNoSnpFull, WriteNoSnpPtl
   * -WriteUnqueFull, WriteUniquePtl
   * -WriteBackFull, WriteBackPtl
   * -WriteCleanFull, WriteCleanPtl
   * -WriteEvictFull
   * .
   */
  int current_outstanding_write_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding CMO transactions.
   * The CMO transactions include:
   * -MakeInvalid
   * -MakeUnque
   * -CleanInvalid
   * -CleanUnique
   * -CleanShared
   * -Evict
   * .
   */
  int current_outstanding_cmo_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Control transactions.
   * The Control transactions include:
   * -DVMOp
   * -EOBarrier
   * -ECBarrier
   * .
   */
  int current_outstanding_control_xact_count;
  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding transactions
   */
  int current_if_outstanding_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Read transactions.
   * The Read transactions include:
   * - ReadNoSnp
   * - ReadOnce
   * - ReadShared
   * - ReadClean
   * - ReadUnique
   * - Following are the CHI-B specific reads, 
   *   - ReadOnceMakeInvalid
   *   - ReadOnceCleanInvalid
   *   - ReadNotSharedDirty
   *   .
   * - Following are the CHI-E specific reads, 
   *   - ReadPreferUnique
   *   - MakeReadUnique
   *   .
   * .
   */
  int current_if_outstanding_read_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Indicates number of outstanding ReadNoSnp transactions based on Memory attributes, SnpAttr, LikelyShared and Order as per Table 2-11 of CHI Issue B specification. Updated by the Protocol layer.
   * Applicable Memory attributes, SnpAttr, LikelyShared and Order combinations for ReadNoSnp transaction are:
   * - DEVICE_NRNE
   * - DEVICE_NRE
   * - DEVICE_RE_NO_ORDER
   * - DEVICE_RE_ORDER
   * - NON_CACHEABLE_NON_BUFFERABLE_NO_ORDER
   * - NON_CACHEABLE_NON_BUFFERABLE_ORDER
   * - NON_CACHEABLE_BUFFERABLE_NO_ORDER
   * - NON_CACHEABLE_BUFFERABLE_ORDER
   * - NON_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_ORDER
   * - NON_SNOOPABLE_WRITEBACK_NO_ALLOCATE_ORDER
   * - NON_SNOOPABLE_WRITEBACK_ALLOCATE_NO_ORDER
   * - NON_SNOOPABLE_WRITEBACK_ALLOCATE_ORDER
   * .
   * The Associative array captures the outstanding ReadNoSnp transactions for each of the above attriutes combination.
   * - 'key' being the attributes combination Ex: "DEVICE_NRNE", "NON_CACHEABLE_NON_BUFFERABLE_NO_ORDER"
   * - 'value' being the outstanding transactions count
   * - Ex: current_if_outstanding_readnosnp_xact_with_memattr_count[key] = value
   * .
   */
  int unsigned current_if_outstanding_readnosnp_xact_with_memattr_count [string];

  /**
   * @groupname chi_outstanding_xacts
      * Indicates number of outstanding WriteNoSnp transactions (WriteNoSnpFull/WriteNoSnpPtl) based on Memory attributes, SnpAttr, LikelyShared and Order as per Table 2-11 of CHI Issue B specification. Updated by the Protocol layer.
   * Applicable Memory attributes, SnpAttr, LikelyShared and Order combinations for WriteNoSnp transactions are:
   * - DEVICE_NRNE
   * - DEVICE_NRE
   * - DEVICE_RE_NO_ORDER
   * - DEVICE_RE_ORDER
   * - NON_CACHEABLE_NON_BUFFERABLE_NO_ORDER
   * - NON_CACHEABLE_NON_BUFFERABLE_ORDER
   * - NON_CACHEABLE_BUFFERABLE_NO_ORDER
   * - NON_CACHEABLE_BUFFERABLE_ORDER
   * - NON_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_ORDER
   * - NON_SNOOPABLE_WRITEBACK_NO_ALLOCATE_ORDER
   * - NON_SNOOPABLE_WRITEBACK_ALLOCATE_NO_ORDER
   * - NON_SNOOPABLE_WRITEBACK_ALLOCATE_ORDER
   * .
   * The Associative array captures the outstanding WriteNoSnp transactions for each of the above attriutes combination.
   * - 'key' being the attributes combination Ex: "DEVICE_NRNE", "NON_CACHEABLE_NON_BUFFERABLE_NO_ORDER"
   * - 'value' being the outstanding transactions count
   * - Ex: current_if_outstanding_writenosnp_xact_with_memattr_count[key] = value
   * .
   */
  int unsigned current_if_outstanding_writenosnp_xact_with_memattr_count [string];

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Copyback transactions.
   * The Copyback transactions include:
   * - WriteBackFull, WriteBackPtl
   * - WriteCleanFull, WriteCleanPtl
   * - WriteEvictFull
   * - Following are the CHI-E specific copybacks, 
   *   - WriteEvictorEvict
   *   .
   * .
   */
  int current_if_outstanding_copyback_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Non-Copyback WriteNoSnp transactions.
   * The Non-Copyback WriteNoSnp transactions include:
   * - WriteNoSnpFull, WriteNoSnpPtl
   * - Following are the CHI-E specific Non-Copyback writes, 
   *   - WriteNoSnpZero
   *   .
   * .
   */
  int current_if_outstanding_non_copyback_writenosnp_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Non-Copyback WriteUnique transactions.
   * The Non-Copyback WriteUnique transactions include:
   * - WriteUnqueFull, WriteUniquePtl
   * - Following are the CHI-E specific Non-Copyback writes, 
   *   - WriteUniqueZero
   *   .
   * .
   */
  int current_if_outstanding_non_copyback_writeunique_xact_count;

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Combined non-Copyback WriteNoSnp and CMO transactions.
   * The Combined non-Copyback WriteNoSnp and CMO transactions include:
   * - WriteNoSnpFull_CleanShared, WriteNoSnpFull_CleanInvalid
   * - WriteNoSnpPtl_CleanShared, WriteNoSnpPtl_CleanInvalid
   * .
   */
  int current_if_outstanding_combined_non_copyback_writenosnp_cmo_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Combined non-Copyback WriteUnique and CMO transactions.
   * The Combined non-Copyback WriteUnique and CMO transactions include:
   * - WriteUniqueFull_CleanShared, WriteUniquePtl_CleanShared
   * .
   */
  int current_if_outstanding_combined_non_copyback_writeunique_cmo_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Combined Copyback Write and CMO transactions.
   * The Combined Copyback Write and CMO transactions include:
   * - WriteBackFull_CleanShared, WriteBackFull_CleanInvalid
   * - WriteCleanFull_CleanShared
   * .
   */
  int current_if_outstanding_combined_copyback_write_cmo_xact_count;
`endif

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Write and Copyback transactions.
   * The Write and Copyback transactions include:
   * - WriteNoSnpFull, WriteNoSnpPtl
   * - WriteUnqueFull, WriteUniquePtl
   * - WriteBackFull, WriteBackPtl
   * - WriteCleanFull, WriteCleanPtl
   * - WriteEvictFull
   * - Following are the CHI-E specific Write and Copyback transactions, 
   *   - WriteNoSnpZero, WriteUniqueZero
   *   - WriteEvictorEvict
   *   - WriteNoSnpFull_CleanShared, WriteNoSnpFull_CleanInvalid
   *   - WriteNoSnpPtl_CleanShared, WriteNoSnpPtl_CleanInvalid
   *   - WriteUniqueFull_CleanShared, WriteUniquePtl_CleanShared
   *   - WriteBackFull_CleanShared, WriteBackFull_CleanInvalid
   *   - WriteCleanFull_CleanShared
   *   .
   * .
   */
  int current_if_outstanding_write_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding CMO transactions.
   * The CMO transactions include:
   * - MakeInvalid
   * - MakeUnque
   * - CleanInvalid
   * - CleanUnique
   * - CleanShared
   * - Evict
   * - Following are the CHI-B specific CMO's, 
   *   - CleanSharedPersist
   *   .
   * .
   */
  int current_if_outstanding_cmo_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Control transactions.
   * The Control transactions include:
   * -DVMOp
   * -EOBarrier
   * -ECBarrier
   * .
   */
  int current_if_outstanding_control_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding DVMOp(Sync) transactions.
   */
  int current_if_outstanding_dvm_sync_xact_count;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Atomic transactions.
   * The Atomic transactions include:
   * - AtomicStore
   * - AtomicLoad
   * - AtomicCompare
   * - AtomicSwap
   * .
   */
  int current_outstanding_atomic_xact_count;

    /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * outstanding Atomic transactions.
   * The Atomic transactions include:
   * - AtomicStore
   * - AtomicLoad
   * - AtomicCompare
   * - AtomicSwap
   * .
   */
  int current_if_outstanding_atomic_xact_count;

`endif

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the current number of
   * transactions that have received a retry response, but have not been retried yet
   */
  int pending_retry_xact_count;

  /**
   * @groupname chi_outstanding_xacts
   * Updated by the Protocol layer, this property reflects the total number of
   * PCreditReturn transactions observed. Basically represents the number of retry transactions 
   * that have been cancelled
   */
  int num_p_crd_return_count;

  /**
   * @groupname chi_exclusive_xacts
   * Updated by the Protocol layer, this property reflects the total number of
   * Exclusive sequences observed. Basically represents the number of exclusive sequence completed 
   * successfully
   */
  int excl_access_count;

  /**
   * @groupname chi_driver_xact_internal_counters
   * Updated by the RN Protocol layer driver, this property reflects the current number of
   * transactions that are auto generated by the RN Protocol layer driver. That is, the 
   * number of transactions with svt_chi_transaction::is_auto_generated = 1.
   * <br>
   * Currently supported for only RN-F.
   */
  int curr_auto_generated_xact_count;

  /**
   * @groupname chi_driver_xact_internal_counters
   * Updated by the RN Protocol layer driver, this property reflects the current number of
   * transactions that are dropped by the RN Protocol layer driver. That is, the 
   * number of transactions with svt_chi_transaction::is_xact_dropped = 1.
   * <br>
   * Currently supported for only RN-F.
   */
  int curr_dropped_xact_count;

  /**
   * @groupname chi_driver_xact_internal_counters
   * Updated by the RN Protocol layer driver, this property reflects the current number of
   * transactions which got a retry response that are dropped by the RN Protocol layer driver. That is, the 
   * number of transactions with svt_chi_transaction::is_xact_dropped = 1 and svt_chi_transaction::req_status = RETRY.
   * <br>
   * Currently supported for only RN-F.
   */
  int curr_dropped_retry_xact_count=0;
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HKNZPBvKYtYCwLcAfeGICYZuCfUvv0AaZYwCKrSGIQnt2T8hzkeGGREkApBWyKd5
sN98NNB6vcklIMn9l5iAcuWEk3nMeoK4nXM7Rc+Lz8MXu555j5R13FWl8eh3JQ3X
6w1aiBuKBJu7qpiXtuXgYAN9O6q/Af/XybaVvWHzRTU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 416       )
x2fFqANwHooew3iyiozhbW6xxlIEoyj4KNfo2yPfewPoucwT/VHWgkuOQ7afk3E0
HejBue/ukg/O3aGnbMkpLgdSQHonNwYAFd+3CEsuHfnnnAro3XtKlwPGT5yalOEd
xinmOg6i9tuX0MpjmbKOrJhJdGZiJ7DlUQfI8oinZexLwBDzkTlD8MTv5+ZhQoPS
hAZ5mTOKoILLeACUnzRFxKQ1MRPvjrmGq3pYLC0cdz18m58bClv35vIxXnqX8leq
Pm7oJEMBQQ1vqbwxZJK4tn7Ar6VR6stJ5d1qSoiWmpt0zqzmvF4shYwpCnmsPAQk
fQ6kRlBkpcG6+1UkPnPVcvJk8qIFpOusqH+yTCZmUACoRQ4JWHQFifTLNj1tWM3Y
6zc3jT1ClgggHcaMydiVPOYIyifcl35kSUVCW5kijH3AUcTqVFHd9kTWEexxqHcx
0urvz6djzB6fe5DkgTy8SQfEicDWcOHMH9iAcNlxnqBWjZ4D/e9C0uhviTAHP1rc
wy9MKT9N1e8h1i/9GnphygFdr3p3ij+J5P8fRPSwizlrSn5iy4kWGyyIIPDoOinR
`pragma protect end_protected
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_protocol_status)
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
  extern function new(string name = "svt_chi_protocol_status");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_protocol_status)
  `svt_data_member_end(svt_chi_protocol_status)


  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_protocol_status.
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


  //----------------------------------------------------------------------------
  /** 
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VuAh5PR0RVCJUZxEwl9VQmV73XU3UD001ByGYxgf/HwbecKjXSLdYjEUBwBn0Gw/
W05gC9R9yY+CaZcfY5Cn2hScJ8K1+DGgRkyNTSD3gxvb4d68J4BQlUP0V4Aio6th
ggSOsJrMVGu+cPGGVEn+7BDEd8u2WkLQayj34CbvYtU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 866       )
z/R3UCYgn/hokv05gyHVgBi/OYo/RATjrATYYzYVhBhP0JgOBGCwEKK83RAeAWIh
6prPRMTzIuyJnOnIbXg8FxH6+o4ysUzPrLIhpPuD7/mj/jCX1lo5i0yen9XgIIS/
ZNIyRTY7Jf3Ew38hx4iP/Z4+0ILmkeNA4DzsCRF8KTR6kLzdAETT9NsaHp/gaqP4
wh9DvrQ4iBT0JykQHzIrkR/PhsacYzUSBKq5FLrrqRFM7PFsN5logCoJxfpyH+O9
Ix6kppnaEXIVYN0xUaE3ko/hidVojSX8FMilxjHzeic3pR3zTWISBwWakPNmQltI
jXM48PbNtIDOl/ADLTxNA6tPHt2Fh8JXhSzArYeh7v4OcviMJiyPLvafm+YfF54R
nhwA/6/WmjfioEM8vChFmZWbCYczeg/aVsaZkGJw7GmjQKhWpaW4RlZyhnOGncn/
yb2PlLBA2ZjU3FTsqukQdE5BObQ6BILsf+4hsOyUTV0KJ5tSRa5s4nN7N2T8XrIG
8Q8f1veBnbHPPRLJ3BaSZLd3BpUTf2+J1XYgZWOr9eZM4CtqfjQgLKWtq4vv7meO
gn7dPldVG53CnF0msCnyqgiTuTNBG5zoOOO8L2ghI28=
`pragma protect end_protected
  
 // ---------------------------------------------------------------------------  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_protocol_status)
  `vmm_class_factory(svt_chi_protocol_status)
`endif
  /** @endcond */
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RueL78z2uAT93WFPf2arecyXHYDWrYcCGqspi8A5UUAE9t5L3PZjA+eyNVxRmbGO
oc+mvlAam7+09yMllwCK7KBo3zCbxHmXd0qeguOXk8Nc50ZJvvtcnQm7+qbD+oUJ
q/2i8Zt3G2irSczdytKdfQgytv5hca1KfhbK3Bvwetg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3941      )
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
sz0YHKrCMDt+5MOEEVO8Vg==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iZURSMXvLEAKQnQn5gYRFF4JSfv3QCtDequ2QlyMbViSNDaaFCRiyU1oX9t5ukgA
gkSGwjz5U/ddZIMPKlmc3MQ9+osH9s7bmvN5CgBqZzn6OvrHkU0+TcR2TEnLvTdF
PDpgcFScPqKSgeYnu7PdPGkYeFYd4nVyhE0BOrZt1hQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26108     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_PROTOCOL_STATUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F7XdqmWJOtsYk8zizSgoZMYO3LL6sjkmwJujusOwtTVxsMKgpG1gNcdEpoOkOpMt
eHM5ysCKl5lll10V16tn+6F3f54Xckp+I1epAEpv9yM1ESqAA2GhE6h+DhKCGBxl
/Z8bMviWEazc8WDrRECHEjpTrL9DZOIfXXNNwL4C7Ck=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26191     )
+aGTAUA7GCphBBqxO/XRcUrxvofcboNe/ErY03BdsFnN8xbhF8A356qSzk1N+/MJ
4Ils5sT8yNpr/3gg90YTcxOmwEFo1aQCGtz5w1MiBDB6fxWs/tx9VYFuupJYI+Hd
`pragma protect end_protected
