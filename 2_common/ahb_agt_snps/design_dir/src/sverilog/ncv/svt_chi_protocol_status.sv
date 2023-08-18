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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OGDkW6XngH2bFuliOeTJy7wZeimtymJTYLYfH6ryKV1wWwwc7HWj2g/Ro66JPuYA
Wavc7rbRmSVGK0R+LHvjC6N3SHLlXSW3YRUGEO9iezhXE0ELPNl9LpF+NKNptOIc
6xJhlhDU2iz0vDIsCyC2xZBVZtb5N6gcBOADjzx0crbUuUEj6nwJ3A==
//pragma protect end_key_block
//pragma protect digest_block
TdAevNG+9AEtiup6kKB4xZcmS1Y=
//pragma protect end_digest_block
//pragma protect data_block
4fGl14r9sVfpcMDlddVET3jezt7ETk01+kgHX7q7ACr+qdRLNDtHv4/yjT9Sl2eY
lE8JdFcQcrf29MndfDaOj0kvb0HTwzWmX7LdQWK85zwsk7BCTlx4lsKoo0xitEee
gI5ghwpZHSJmODcwAfZ1k/qbKznXJYJiuEKG2Q54mQ07QI+eDtkFyNBbdYn8eWJS
8oO4Ibnqge4Nfr+OmzoYvsaYPtTfjOovn/zTizaV6i9CWtOWOVJa5DC9OPWoOdup
idHN3uPPSQkfEdK3qY7k5LErn2zFsmlalXL6D9VWF00n54qsbLehkY5vl4Ev2LPK
m5IiMSt2djzKTfaF7oVHrj606r9fhbh3lSJ6XIgHhIe14PyFU9s/Gy8cogUbOJ2J
BqlPgTbPMo/jKhMZVWJaNFfliD7rXRgDbh8yg+lwCRzI7TcobXMowA5XrS3KJuA9
C9xjqEmVVBQyp7RfYdfnovKvGq3Z02nXn/UVSySHh+aJdSRsmNZEodR1HmFB2StI
C7eJ5HCHYvRuPxEL/0j6PCABZbVlMqeKFbxPY9y5Dw9ur5qrM6A3yj8tOGATK93l
oVAj3xFWTBF4E/e71Z/ZmQvVFcWFZfSjlc+u/mD+OwdG/FVujKtyL5dFvTlIerdR
VFpPSdhLcH+eEdARO2ylOnEpMLZUca0fAVg1cbJg+vw6EnlVFym6NW7uljDMFHb+
E/nbzs9lB1HEzu1MtGzK5XB0ddbwIa++GA53KMYw8HNXtEoWFuHz8c/9qJ8zn7lE
Sl+mCx07Bc6dq70R+EQRdg==
//pragma protect end_data_block
//pragma protect digest_block
ZIxkuj6uPOb0hcyoc2OIwMF8xOQ=
//pragma protect end_digest_block
//pragma protect end_protected
  
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6LOf77zZ7f9GCySkkipN8pMGD4dHNqebMW8IIzwUuKVOUaM3vdSp/92Uzz/c7jYC
h0SJm3nFDl7raSNIPSyKBR75Wp+B0Wh0tjuj0PJso1PYsAoZtc+SKVO4R49gw+Rb
XKFq71iTvQohs1iG0JL72dW3zTSgmPsDePj18EpAFLD+tpaUywbpTQ==
//pragma protect end_key_block
//pragma protect digest_block
LU6rFekAvZKKd5QVzAxDVCxtQ9M=
//pragma protect end_digest_block
//pragma protect data_block
/vPTXAdKyNz/o7L4unsdPgmBlyxBGzsnN8T8fDcqhB8C5PyrjXsUXveyZRab4iNr
1AegIwhlAZPMAc3de1CEhC4ihhr45lgMAyWRMeAdD6S5QWtvp+Qla5a05e0HAqQM
Gln5vkvKSOuFr8OyUlqD6sh6l2h7AJHhwl3cHQcG3fZNU/5hYV1pm3I+uzKJEBqN
Bs/nRQpuS6vj2VahV4SW1eSk1ltYELoLGmr3rG3JdLZHEa22EIEFSajmkCJZ9WxB
zxqC6M6vd/wUvfL0/YJgrs1HCsZP29Eh6zf0PSyYcZLPNItV1xEXjivbannk+zCC
HdPE4L5YmR2A8a8ALCWTawSFllI7GiwO2WcdIVpdO8qrC68DhCVn7Vhc4Eph9kq4
2uNGe923jqW3cFKtYKrGbbyZ6AlmSeUSW4FWPdWThQX4lt1mfwPekrTBmBcSUm1n
QO8mru+rp6eveo+qXOlDxsksX/ZyV+KiU7bBc1k1YP0F9vDLl6jgov//B+L9MaCN
eiA9VT/o4XCTc44uQy5gLnoJ9T24VybrozvboRqqkJC91oehyEJStzrLiX/SKpDB
5YFBOEjhQ6uSpbbc1AlePRpgQNwJFB4v12lfM/hdvZfJCr+3+6VcNoRKRHMQ666s
j4cIVw2RZrbzqGRUgXj8RalQizBqd9c6XrRPmHUetqL7LzS2PDDDImFHrMYFhA5w
GBWmtYT73q72Sr5LkYxJViAxwmSzmTjjgwxP14WGGApWIwJl3Z76xCXL2ATLi+8b
zNrWXBkiFuBDjIGYeQYeWaWoqi/55ZSnZ6MG1SUiApJS6brU2mFHaFTnBcQY5ngC

//pragma protect end_data_block
//pragma protect digest_block
HegUBRZLLOMq9eBTQ3OHcoMxwRI=
//pragma protect end_digest_block
//pragma protect end_protected
  
 // ---------------------------------------------------------------------------  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_protocol_status)
  `vmm_class_factory(svt_chi_protocol_status)
`endif
  /** @endcond */
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DtQNcDqTvHpbFiKfgHb8Nwqdjr4JtUHeftHvChibQDr/L215mooRXi6cF1h49Ycl
cHu39lHSB60oq+gSXsqxseyu8UVrV4uk2LOnCbg6pvncOJuTUCqNqAlPfvGbLjsl
yIc87+qNq2jp1snWSWTrQRN2u8aySEYI2iN0jwFPChrCwk4rCoAkRQ==
//pragma protect end_key_block
//pragma protect digest_block
O+o1hfg7Zm8o5Fa7YZq2/jJ862U=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
lorlql3fX35aqghgP774uBdIUYc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RqRr5NOkjBSxPRdPp/w2aI7h/UcKrDVRl2FaWtRRuTnFAPc5Kwvj7GtQt/f6382c
MXY54QsA01Z8/HWIfKPbSdd7lqn+xsXGW14Rjd9NWxxMUB9R5uyw05NmQX768DPG
4/K40fy5qiacWBLvWDTdvFH+2tOazAkjOQtoqACko75V+u5rOoPPGA==
//pragma protect end_key_block
//pragma protect digest_block
Qtti0Dk5h/IgZ0fdUpn63OrBvLY=
//pragma protect end_digest_block
//pragma protect data_block
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
o1C84dSjyyg+wkWXGzszRQ==
//pragma protect end_data_block
//pragma protect digest_block
hkBmlLr3GZbldibtucaUzJS0EUQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_PROTOCOL_STATUS_SV
