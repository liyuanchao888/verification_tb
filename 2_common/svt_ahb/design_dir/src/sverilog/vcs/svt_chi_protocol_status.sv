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
  `protected
6+fW(TWRe-2F](&d1J&N#[XLON9^>GR6JZCd&\ZCc#YOb4G[OH5B,)6LL8WMe^J<
,3X8f_YMZ:3dHJ,FVaW]2S#fA75,B_D(KVA1TBCRaIX+@5D-Nd;Y4\50b6Y@3g1:
M85NZ+04MHXGXABNDEB4Ac#e[8-TT6N]<:5<0f6N?d7C0.]AQQRDT-16O;8?PH(3
>;0/Z\AX147Sa7K5+=M)]cb990N6fJf3P.WHHQ-G_EJA1XN&=<XD5:O4I-AfJ4?4
9FI76+?-E>9S+$
`endprotected

  
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

  `protected
LP(M:T9NHD/QEB4Cg\-fS,W/MRO>T4cK(W4:c;)[1PMK]5U]ddf)))K0BE>4ZCBc
78[IS2Q0N/J4WdHDJ[MWY]:2TSI1V9/.J^&cVUT8\eU3J1Ig_]W4>E4N^XQ)_L+a
;ZV]0J@D\M^dS-\#OAOJcW[PFO7b7aT8]G4H@^GNdK#6cZTWc;D^@d/KB.]@9:C)
Q39#\[YZN^[/e7/:IJ=SbDI5Y.71?XX42.S5OWA0S@8#_(M8e[I(@&/KO$
`endprotected

  
 // ---------------------------------------------------------------------------  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_protocol_status)
  `vmm_class_factory(svt_chi_protocol_status)
`endif
  /** @endcond */
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
fA\dU3MOV:2PLT9QOH#+/D,VBfF_YaJA_(gV^4B0U/2A;WSWS87&1)cO-=CGf@^J
5PR?fB:S0OC4B7@M,U/O9M]c)QX-IO=D:AJ3V-f2G0REA,=H5WfEWfFCW,>#f/[)
DB]4#UO:M);=5G+HMP/+fJA=aX7HJ<YNL;+=H(,5TS]PX_+,OPB&>JKYL+dYJd40
Ma6T^AK&&^@b=-Ye;8;V3=:L2R@b3V7G2E]e.@A30MRB:JOSKHF2MI;MD>5(O,c(
.C9bK.PS;O9c#e@>Y\>9J][C#M;MGZa6N]H@HYD0a]a&:ED&3LKb)S_fOcZ6KIb+
&_[2NC>12@Y\I3.QH3A[4e.P+@\RTSJT:Cb#WP4Y=27g(Bd>7/Q/=/URa)=LF=+)
R9OG]b?5@#]:IFNGY4E?-SA\<\Y2:#--a@CW)GHD8(86WCZEXE)LMAP&N<cH&L<Z
FBU96SU1U):cOQWe/49;8MR:E]W@=28Yd(E9GJRbHN5PQ/dY\=O(9KF3bE7E49Ja
X9E2;8<3GXFb0.Q9A&47[](7O[SKgF16-KE9Y//e5NO^DHISdLPW_G<CaN4&JeX2
,3cd6d>KC<;P)/G_GF5W(G4_+YMJIB0cJ0\c=gfbAbQNLQN@]D786;VMaM90G8P4
f/ScW;5gM8SQ[I3R?KAA+V&Q0#O^UZ;.GY/7FcSe=)Qd@-@+6=QFF8(Te=]B;GUD
g/Q,)3>QS6RJ<2NV_93SVfFC&(@W?)@M,eFA7PGLY,=Ya&#I_>&,@/@(AI;:e.(9
:DOFU-e)T^)9JOgYYMf@d\^8#d[S7S0)&;F&?a8W3TL+a_8<?Q1G?KO56./,-&bZ
&Faf+V<?;F5d02d_)<VaIccKZcJMaR#V(gW35[-=O;)\0f?Z7E4XB,I-T0UF8\78
<TC_cJ1:Xa3([Cb9YI&R3g#QPJIT5C29<3I+.g,8<W4T:D>6#FD4[E.KU4TCA&d(
M)2\[UDE4WINgYaK-[)WZJV^B&cH:3EK0WW0NG2AU\aR?O0/e4LNT48T6U\C+(45
>)G8H4;Ze&5NAY\<YC1=4_V4gK^NBQcA3A@O@2TQYX8/fA6ZPQY-U-FdeR\X]d-9
;;0_[?YgEWS,@,9.aGYF./[2dJ_DEeU;\75e4PR,PHL139\fgK4R>K<Tf.OSTF9X
?8;.f[K4^;b8N;J)#)I-QZPY\[0gCB\-dGYTS=_U[<0@(F,:RLNJJGILUgd\+3Z5
g[a4BU9H^NGM-4ESf4Y07L<@Qb:9[>\R@Sf4T+-6A\ZO:_@?@#5a9R^U3>bW71&?
PRJU?SA)D3NM&7Q=QKC,\&gEPY?S_]+2;/)_Fbg#@Y\5.DaZCFT1YJEdV=7JVN[G
aHF7b\OeT;>48]Y6E=X9Ig)BUcA/UZ;I4O:)ddc=2Z]X3FGHD=5Rc+OA@=?(Zd+@
36J+-f:.Y4T1\KgEa9bc,TSUWE6I8P]7VP[;(\LcaeUe+g@e4bKSY(gE.&88@e.O
DR8\[a>]5F?<4NSC:24N.AY\^E1VeN#cP+W#EKL85T1B<<]eP#GO\JPJ/cfG^4Ub
JQR:?5[GWK8M._@-dWD</LaS3I(f<>LDC9E]_OA-J/AKV\^(5d:&8[9E#UH<EZGE
^C)VdEUJ;E]L(MEa1_=La)9SHUcAg([6V0KDJa]35^I0_MW([,RW7Bf#,C,?<DWd
SXf;6:0:2F<L/Id&I;bY>N6OOL@Z3ddG\IVTM>W\e(K>8<-Ma9<.2;a6[+<?+dE)
)cS1XM5#0b+,K8U\430e>WC-P94L/6P(+\W6?BcUEOXJ@2O&)?NK2SRD=aOH[REB
@^LaGATB,/]I^F<a#S9;Bg/A^^P21fZB/01/a+V<:_VCR794H<^JcBBee\;TgUV_
ac=aga[A+3TR[Za;a911)(f;g)TAbaC4<_?MeI&&K_KaL&.\<QRZX)gH=^DS(GWL
=)B,0LMTJP,P6GG0W=RM8+2?;&]XZSX6XKeN\5BXIT1#OGX_e@2S-4=f7dJLL@2H
H\,fSJIf_W&Mc7+&?9LXM<E^5S/Iea<\7b,^g#P9Og[71;MTXW-dfU?/D7^=TU(Z
&\]A\]F2c3J)39^]@P^O4<H(aF^DZ?<[V)7=3FBLg&fF?\0f85DIDS\#5MMDP/7^
)VGWb5a(V#;OA&fX.@0=5#6V#b+OGZEQ_JBTUCfK;;TaHJH<bTf]28M[;)5c&)5A
eB?#P?_<<45Md#E]TB7?JP]fg.OI&KG4B-5FIaHMXAW-L;+04GASd&W;B(LV/600
569AZW;_D(;T&O[[TK+dN9_&,QB)3+JOaV:R\HR(;f0Q78K]OHd[/6ceLI\J76.E
#(GV@5gZ45A/4KN1>bEE+1Rg,;6/:/554:^);Ga/gLDGE=g817MN622dXJ(YF=[F
9Z;ec[.&>b^J>]60<N6gMCWQ^I+;<L<F97b[J64VB+]_BeIT9X<9<CYMfMYA93^Y
?d?6=..:97ZOYd/aO[^&<CRSS71-_I)FM<O]g9>I5(UFaW0,0-]SV-gEEJ^J@^M2
102;&W7_Z#W(_(3QR6Aa-T696/CHV5YHd3]eNJ;L1W3^<^H;K;(TI#?d(+_QW7W2
0gEW,5I#?fXCa)Y:W?f@a[(/>O@9@dW]^70V3d<JU^RQ#WX^L>2NNFeJf/VDcR7Y
WJe+_S8F\=(@Z.TB5V=4-[Y(//-,P&_fD];7g8G6;+eM\6-9Jb).#E4;1PSV[,AO
XQRJM4MS,;IL?T>a93\;&g?_U=+8bV.UAM8Y(6a-8ZR+(;E)AfHRK^FTLbaF#AYJ
ON39KFEg-,&e8I)2OT]R:c5[RJBTY/X)UCS>J8c]@c4X4Gg9_aI)#=5QR7)UMb(A
HC@_R4K?/+\>XC::#aS3C(_;LCg@N^_fL\MDOc3XY,_[a?YBMNKFT:]RWc^aYZ7<
:O4;S?deX>E.58.39cI8GZ4YA,VdbJ:J?_N0ZGSCS(?F3cR<U-?aUTY,(QK09A8D
FBN/^=V:).5\)(W_)O+LM4=cRM&5]8cVYMfSG3+Cc<<WX[__fW<&-<;IM+@WaCd=
I@CCE=P#FO@6H(9/g_1gTMHVC\B#:V>;6E(]+IQB.2I(K3H9IaPdcAQLAD-2DD3.
JBf3c?VU+L@8WA+C.X>)GL7Wa^OZS;14<Z#6SRaOX7]7_:eWX?42EV+4#P.G1ZBN
=8TBMX8NCTcG;0>XE=I8F[,S35bW&_1\W5T-EIUP#L>TV.H^&R.3=E\fgTLO/5=.
X+90T05R6\53a?1IIAB.-T\fOcc?9?a?]?P?aJ@>D61d2d>IPCP)gHT:<0[MBO3_
4RXK.LQ+-V/5.4W(BbFQMPcg,Q:B\32VC0Za_818DRCE#M=a[XB:&\BCAC0U\E][
U[2KLQZ1V;O:d-dN?Q);>8c=LfK-(M11;X]]/+5</MI&IY(-bdR2]WXgg3;9M[(@
:)FH_e/<=dA20MGZB>+GM8Oe2LY_Vd/F&B5,3M?8PbfVV8Y1SDF6GVYe;.d/]7&1
?#@^FM6LH</PNKW<WR]&XDW=M-]LYbB8608N@,D_H/6T^#M>+.71@RAWG_G@7.CE
DT^)gePOc&(>cWaf5KIWRIbGee.2X5cG1POS+UUQb16PD#9KVK/g@d,S#J@VS8-S
B&N=EK+1A_:C.#N=bb<&6gc(XfdcIYf1/N=77&6fbebeE3PC[HGF^MFK5;&Z-JKe
)eO@)\RY420BGMS=TK\3fI(gP9NPYZa7aDL8SS]9(A>/T[MF1&+?5Q5R5SPT<PcZ
PR7/&P+3V[7>709>BB9B<GQ4>U<#@P4ALaAV.AaH:3=V#2?cY26S/5+.Ob0J^F@\
Zc:5QO>AK_7#_4O5G-BD?MBc6<(eSZ/FecVY,A/?#8.[f;XaD7_0[0.74DKVU=-@
Y^UHOO71=V3EdMJ42>-^TDBe^7#&R33c5EYT]MF0[ff=WNGP=\QD9LBPGI9#^e_)
e5#FLV?SZ.fS5I5eYXEf7@IP5MY(UG:3M:b3cY3(d2RCI[Of2@]fYTBPI$
`endprotected


//vcs_vip_protect
`protected
#Fc[,<L9e;]ID,ac:4)^P?PS,YUaE/@[/VT655,,KVdDGfI4+gSN3(G2GTS23J&Z
B]J6YJ#R7Wd:KKYK;B997NYJ(J#]5CIONP0[bXY&GK].+#J&PWc^FW#?]g4<])MU
FUV7<3RUf2FLFK?&:-JR_]P]D[?e=][Gb:.J^JQJ^MGKR12<O4gKM(6TDSO@]I;Y
3f(H:X0e-1PFTX.5><3eW@V-9+0bd;4aZaG:Q5cH398TVW.8aYf;S<X][1/=[WLC
#b+6]XbA75L^W6_dYSg2SI<YYP&?WUfI_cK;T-6RE;JGCC(_gJDIY+411HD[NL/7
HWKe94gcDR>.T:FB<E-SE]\WZ,:G9CZ9,#>]G2bKY,LaF;J/gdD2/:QY5K<WRMW@
04#fRIacI\MON<\gcT3Bc:.#/8-H/U2K@.UFLT<P=+7e4d6-#c^&=C4S,);=^W-R
<)gL4CVP3#PfDFV?CX<0g#/GbF]974?MCK@&eU6,+@9<6]/)Ke&PeP<E);2d6#-e
PEH):4F4XKCQKEL:MS:T91X2)Q+>K>IZU9-HbCcH3I1U<;]bO0RO>)bg+BSN7G[N
>G<^+QQ_A;?R?-UGFFc5+9A1DeA=0K17#&8^M5L@(/C,CBgRZ/V&6)^VdBLF\&34
63.bZWS2c<+E5I2?;UUgO23I;EX73J.A>F@O3O:[WN7^M/gFY+IPP=_.EMYdd))4
B\5D=;M3,:B@GB7EBWWI:(AT8T,E>5N=g@B)H333#?Yd01Pd>NEHZ?(,a2_AX1d7
_LG:SQ<^,X^;B,K#WI\EISS5QM,^YFg](6GU/,Hc>dc/\6F=>^R17bQVX8756;cF
&MOI)2c5cD2aP_\e3.#@),2[He88/CGTVbc_Z7IE(A3bFR)SSXe5FZ+)b&Mg?^C/
AJ4a&JB14M/Bf?>,<=-CJ\65AZb59]O<Y+C1LWb\=XU.e1.A^R;6b8O.H/@).7<.
MdHK&C=KJ7R4&)[g<51AKJ4V.7B-bg?C<D>B.E5ZQ@N1UZT#GJcfeGO==H5eM?>J
g()_PB/7dW.4K?61a</D[9XJ3cgV/A6C/SfAI7W4bM@OAe-fA(M[L+3TR-bHM,YA
4/:5;8+KWKf;fB1dD#bX6LD0@7(NeB^0F/YSf=I^:^MLR^&McW6+/+DK<OOXMZSF
N<+HPK+^0WNbe=2:b:M(F)R+S][DZ,^\2g478Y7A-Z+1aTIXa0eB>Q0-:Uc0g\D4
V8>3a_@9+b.F;1Xd/S8[?&dEF/+&Ja8]\0>[T[gPbcEa\Q69QIGfgb+>Z=a@<PFc
_XLATf&_VI,#F2L,)@W9PMP=V#S4YK]0Uac]4AReJKH5GS6,e>7L5TIAf59Z0]K7
#^,#f\CPH7;TEUPPB(9NGf7;)Cf1]g-O2UDPG9/KYed1M7SfV^1cZS#.=0-T7Y_[
Z@NBOL+D&<Z-)fQHCFXXL8<15\^M,>X8-J-42[H006AMEN2T7\)=][U/5-G7LZ)7
=/RLXdaC]b>?U\RK9:6@84__fU8^]dM(71HeQW5^RZ]MDT^[0=\=O._aF&[O+&,)
FKB=E0+1\(8:8U(CEY77ZANWbOL4N9;f2+@9,7^[RI+Gf-;ge892Gf#99]-RL[2d
<P)APQD>QNVGc]<4I:UM<Ec]<7&bG\U#XK(U:Z@@<VY>4J&D(.A-BBHBYSU=6-QF
^T7N5HaCX19\f2=46>^+d8E&0&BV7W2(f[<gg?#6,QUg3F9K0EDI09^:11CcS=&5
S&eIFE@LGSb0\PgQbFC-+c,Sa7X0?<)<\F+8\???XX4<08G1213MC6HaVM;=WQON
O]-4=8NR-2IC&INO=](5dMaQF3O_/AAL)6UgKMG,F+;LJA]+X3.2Qg/BU5HVM(:g
;]#</N09FFSOCK4g8B]MAJ4GI#NdJ>N_ffcB3N]L_)fIUH#O=gRRD?U)<J)]6@BV
PX/?A@acOXYbA\Z[97SPSH;9S./O0A@D1:D3B#&7M_fc&&,@NfH#2B]-B6:_Q]\f
J((D=dJTJg0[ZSLK;b:BTYbPA++d.0Q1UBSd(O30S2[8Ge]4MT+U#=;V,:_6:UGG
e^bKAT3G_LWT\Y-=8e\0;Df0Q9<29g\(+EZRaU6f<&f#L5fPK8HRd)&C]c#MfX3a
Pf3<#.D;7#-).D0-8QW0)PR:;ggZ;+OgbYeX>/>G\R2b&.VD9-?D08E\DYSOG0SS
0]f33GUdM590XN[6&1(3;8BLPEZD)QA)4)8=cON8UR]g);=_bW[<[:NY::NAE+f^
#+fE:)6IYSO1;+[G>#-.-9T<e//c+1Eea1\PPVgS]=[/@W/9/5,[fD509,aVKX02
YgD/G4c/EP0RQ&2[8S>QgW1D4M.7.b,,,b)Pd^ULX?3IY)^&H[:PDLXD[8L1V5.B
MJ:0PE]N-R/ZMSM@D;V.e^F+DG:#dQ15fG_bGD8E,6GZ<4cLV_+=;)fDY303(K[D
,(<7(\+P)XH=<R:d6NK@.dgbCA44#F&HPH+4:M#g+&_G3=<J6F?dL@^RNLDWgWDT
VU&J1V;FI+J1.+U_;QJF>B:H>@_d73-4Zg,N2E.(GF@P-U<Yb:BPR3@R<]_e7ZL^
eKcGYIc0bN,@RYc1ZW:=3X=O1S_J_e3N(b6,=.X+O07W3[b&#EQfZ/ZD^A./I&bg
,S5d&gSO:9&MP/,c,LACWNC:B:@4&:2-6D9B:OSd<K<V]Y&PQf>-_N)H:J(:H^/f
-e#M126XPJe5HaUW&dbYfO^<e.<D9VW^XU]_#)/E;9=9gHI&f5TT-#BO^gbX^P;G
Z/KV2_+7Dd9(\fd#?A+]9_ggZAI8d=YR/@&O8.._\.51Wf^#1J_ISeMWBOIfDS;0
1X0KIe;EfB(&E<,MBQ>9+XXF0&WD)<LI=_fU2[,]9B.&H9Qd]2HNc>EOG&X/:E0.
ae>0U<?F8DOIWX/?YFgHCd(7?AeVDF6DY2T9MZX]8<K?@<9cV#)e\3_E7YCOV]+,
fDb9fRN3dAC,F^S;N3VC5=;ddYU@DFb4If-S)GdNYS]gM.aK</dEAXM^;Q)K83YY
T\:I6+:(&;I5M3D5;-BC:T_3OYN72(bO001:WF7#P:,I8=910_\g/EC,@5PX\;;)
+(6e9;&CcDde;C_AHZO@GLTEB5^?gPeY]I;DR^[+<C9ACDWG.];eUc=#4@\,^bSA
aeb4C&a0/D9#M@^9,>()#<gZA(9?\LWUX[38@a3eY12D_7Q_R-,3/@G39P;7?E;E
+0L_[3.V+#VecO&F=\.0JBT4[(]-3IVRa0PIeHF2@/IgQAMK\1#P5-N_^WgJ^LM7
XF79DT-0O-2UV[+9T;Q)OI[V:YZHDNd;C&+3M[?4HPdK[EE,Eg4UdT1R+/M(BH^L
0I^9\N2>QM7d4G#+b/gA,3VZT&YH&ZN8OM[Wf=)=ZZH0O8OD2#2J.T[N<gdE>:AW
I;/IVR=f,;<-N+eQ/4b>\_N5JZ?PSdX^Z^+#)Oga_VIbG6ZTB3OP:CAAO/R#\IHH
PAa+7H4B84JLXLZ[:Y_==U;IdVZ)b/)A?I?T2=R?=15QCVPIW?ZU2GFHfFaU=f==
P2dc>2[ZPZJ;=VIW8bNC:H>EK6GV9).eUaKb-gY<>9ZJ7F3)\QP615I0O=J5XF0_
aX^G4<O@JJWIa=CGR#O+f(eBGX9JCPYF1]8B,g3&<QPHXF>CBMV2-cTSHTKQZCJN
R?#ANgV-PcQeMe;b+c2X\[O&Y?Ke805ZW2JgMG)\8U8[cK#<M1NK=H(F=,Ag(V^N
3BFHW?=JPYH;=2P[L+12PGW_F1PDIg:#90.M(HR9Q=Y+Zc1:[CZZ\?eOZMMF,L1M
3705GgZSNSVD23@Icc9U+H,K,e(>8+1[.CT9a@/9;?UT/:Me&@2Db<;6J=6UL-:V
QeeM,>M;&+ATM:;?K6c9K:Z\/R5?O1MV;@0TNY:FI3#eKXc]F5I16R--LE[<R+R,
EUYO?)b,CV;cDWZ0D(AO]2fJZdXbaO@X<<&I(1(\X_]L//EO3g/5eWA>bCX3=MdN
Db(\+P^6<[OH>-0:@U_X/?<Pf/&F;Id6e9gN,>]YHRW+2R+RA37^#1,6MBgJWTga
F5[^?]^Y-YgKP98eN=86=#bS#&O_c02DQ/XDI0HTO\K>-_:AVXb;@#UE5\L+7WLC
.Q=GCM:(J9WY<8+9XE[+E&\c[#\S@=/?@F];LaRb2BR_KG4/)A<96IaR5/#SK</B
N([C(<D1AZXA]EIb@H.0BF1CFNYIPfT#M=Tb^P6BAI=<^CdQ.R0[Z]gc;9Dg4JG4
:;.cD=.>M/e;C46F7.XYeC3.WA?0>c+NFN@DcU3U_:GHgW^W&A.H0fCWC@,JCH<.
B>JTBQE#?Da>_74A#^6+c^4VMNLAgK;A^.4<#eLSRJK2,WK?_Of,QGSH@H.)aD<e
4#[UeC=WG)SLTHd1dJW?EPdN@I6IX2[@23c4/;/-KHH^.4\CfXH?-3T_+3<3fMF)
e[#J_OMD8FT).1)<FXK+_@1X9F^4ec8aK\V5d4XX\@0Z1-+:AH-E(f38bIXFBW57
g4Ud117?]9eaJU/QLU?L)U+^;NC:0b]\O?.HE5(OKZR&e76NC1:8e]\_C,aT^+eZ
RX^7G\c(aP:cL3+]9e:@=8#4+QbPeD<BD?#cWR[1-148JYMOSaC\HE8[a?.(+_WK
\4C\PLRIe2CH&.c[8\H4&11gfXb5U8J6RCOY+-JAbR/bHL1<92G:V=Zd+eK:XU&2
4bI8);_f)_XRHK]<<)V7O(0@cP^_P-Cb=-SQI9@c__,I&3Y0<N^<A3+5P.3bKZL,
Ye\::K(O3FJ/dJf=F7VLG.4IBEcT&MU_[ML,=ZV9UHB8.BY6\gMMNbN?IK.8,_,S
f7([-<TUag]UQfH4Kb:P?V:@G@S29\53A>(YBaK7:f;6\4bNLOY9Y=SEK@UN=a6#
TN;g(YC9a-aJXV/>)#T>e[#IgSIBN9G/^QaAKR?MZfJFfAN)?Z;IF_FN1]QbWH7^
1WZGCI.ZIG_BB7&X,205P;M#gOPJWKI0Cc8]B()V=U8F3Pb,W[U=OU-7>.IIR:R/
6L5AZC[2U0AB-;#?&A?L-(+[NC1K([:IIef=89,RF_/WBQ\3b<gRH@HbC<c,X=,9
2\\9EZ?[E?c7eJc]TIaHe?J8NgZ#+2[PF9<OE,92N>WWgE:(cHD76^PE&VN\UD0>
<\KfSQEO+2RU&Q^2T4.3bB0]N9;R:VfJ&^Qa#SE)VeR6>IRRfWU[V83YQ1VH@<&5
BXDL23[8;H\d6+>1P3R+ZB;Y:]+faKQ8\d8^=IE3X?TRRMH^Z>9\3(g0D[cS/5J[
[(7X+C<N)X_#0->0Xd?<Pd2eKb_8E(=48A7Od]a>38/JK8=0,1_P\#?#8c8>S5&Y
F:\MIHeccVTE95,M)MC(X8.=\M5\-FVQB3>G2D^5+HGZG[91C=N5T:L8DFW=US.g
O8IL&]O_Gd?_23f7[>@;IFG49J3WFfO[EF?1J>7^_[cc2[=+6L^BH7-_C3IBD5DY
@b#Gd;5X\3A=QP1fFFE@G+_YL@UI-?S0ecVCEH[;K/F0KMg9MLH]d8>IHd0SB-:L
B=:VE6-F[a[GDB[8::Wfg#K/c)Za:B]HT#TTBUe;3LYW,#K08O)3T)?S0]YBb@WF
:[L=aPC>V0EV/,XP\T\6\,DBC?JGX?S&L-)E=0XgEW7B05c:e2D(<=3.Mf0(=+\6
8(KR3Cbg[d9_<_b)c\dYZ(?bR4Cg)#a;E0#H1D9N-1X7]cRe7@[B/B=1N-U&Z65@
/G)ccW-8Z4^#)b6&07+2=b&(-J8XF1XGd5^W-=_0C@aS:gG/_^Ff+]55A;b\3C<B
)2]F^?Hg@7MHBIcDSLAHdCDYF;DY)&gd#3aVE;4D]&TLP8fU?]Og7UW\VML7\JVE
YM93;KX@\.,/Q1E=[=I?baf#M57bWT8d&+U\T@29;GaZ>E#)OB0K,KIBJc6TM8WJ
R.INZB<f(TQ,#(TW8.54)?gOB\V0]1\PUHRE@=e/VCV,TZX1GKEc[gTgcU_P\E\9
77[AJCdQ0E6K#K_E/MK(HD/7_J-1HgIE]\Ra7K(9EFAD?=HeTIZdd6+WDZC^36Pg
QH<_,C0Z8<2;86D1<g8cf4<Ud4TZ@87E-34KHb49U=L^S2U:2XELGKO3D,T8D6A+
<XR._H&2BC;F>16aP4cb[-dE\5OL)a\[U[.-5C]Igcd;Qf+SQ[P^E70IK)DeQ7>(
af\K+c<LGgQN-&R2:b-69AQgL64&SY31)ZA&bb?@4/La9@9GOXZ:KQ(N;7RU&Q:b
RZ/PN_TGH;HDIR1IP;X9&P7MeC2^#M(X+eD+c.2DFV0^9_SCHY(SXgB9#D>][Nd,
XZ2K4ZWM\?:L_d;/J).XQYD;BMF./N?5>K8P,b-U[#d#F#P0&F<5GDgC->^dXKLV
O/NE.5/V\:b>/\a.XdYZHfQ6U<d&)Q5),V/V#;>U22K]:DJ0D4NUKe[fZ_1HM^Z)
XXRA8=M:1A?@[0Sf/af8.K=.Ec+[P-XJD[>aDd^;]U#SEdK9-U(QRA)]SP\(T8XP
?<NKAa&@Q[02XA\(E<>D2Y)fF5&A6ZBDb3f5XUK7R8?.M78Q]K2)+G:a<=Rf0G@(
ER^I1N4PO[D@R<2VPe@RYOL<;QM9D@+4?da963J)(GG4RL/IGJ;\W/P.4,VVb1cc
8bIZX6MAKf,VgU)C&D(-7edWP@TE\;4+Mf>7Y4F2[U<=)]6N_>?QG7L\2#Y\^]ND
5?PD-0RSN]=5gQHVVZCHY]Z0]@dB2IA&@DP0S7I\48XfJ0ENI?>U,35U;aH:P41]
d9KXVdBfT&X>-?VJF]cOZV/f>_RL2_H+3,c0]))9D?K\M#0]&&]AC&=Q@&<A/2)f
]9\8OBQZH[>Zd@d?gg-+I6ZEAE;7Kb4-[IEF>;a_fPa9EIKHNDN3@OAOAMDb9+8C
K2a[P#NfNB\3=_<+I,0QZbcOV24R_,IHag_D,UKC1]:FX(T)Z4VfBPMe00N/:H_F
R:f^g0DFHN\Z]WK8>U@WA4JBSN)Z=NV^L@)^_),101:5+V[+=30QF+(K)P65;W]f
NAIS-N3.?eEKbc/5_g[D8.N&SIG0)^-+0.([^L8>-<,82a,Q[I2V^2d@^A,aH_(U
,T[QDJ&R>KgRGGP71B/]=IMSd_^)Z9R7gADX)5-PePE]KHU#\BW,/NRZ3bVN/5XQ
\\^[<ETZb^QSRE=ZWdE-3N2WX2[CN3gO4,Q)NBS_SZ&U<g+KHX\IM;dCae7L_U>M
^5_cRHFJ]^(bb=6eS:@[UJ]R^#\=[WQ79>Z^LS5W]=S<KQg&<52->G.-0[.Z7H2.
,2[WVccZ@R<gV4O/cC:7PBbFNEg=ULTEB3-N]=/AE/TL1E;Z+T[0LJ[J(D?Z2-EK
Q:b]#X#TRWbD&?<AQB8aS7H9D&PQFbKEf3bB4ee74[W8LJ.[0+-[V#E]YHFAe]P0
5<#F64a/+LZ=E4ZC,f]9/f,6)cD>8K1GUADAD1/1LQ1P<R0>]]_XU:bP^?JB2UB#
X.7N#;13fTC/P,^1UTPc9>ZIEETB38JZ6YIM@C.13JPfD:CFI,QP]U:I8_<N\f7E
,AJeTN;B)Y9ggN>0Tb8#b=.W5a&HAFL-;c6d(3g^(2,X#V3f=S_e(TMVScXIgG:Q
cL[XB]9[UbZL^(a8]I^a.Lc@X3(X(^B;HIG7^4Z=HW+4Z6@GJg(MUBLed339@4<&
a_JI1bgR?6N\dWW-=U\8d1eIIR/\C[QMcX@:S8ZU1ZS1(6dGMK]\SO;Fa26FE@(A
eHf9KRJc<OL5HW#R4A?&Y1d?:WbY+@HP@28:K-Xc1TLJ;I,0/Y_.Z+\/3[f[DJg1
Q<L+9&gSB];#J_Aec=<6N#]1_,3(<;C4.UEdJ>Ub;\/(O^B2,Q+b9E:)\RLORF&E
9C:ADQdG9M^JfX1B9OV;BD3UK^fI[2N:[ME9LfAa+/7_;\Qb/Y1?^?B4^J.>?P<4
II?99?=T_:BY]FVW?,)D7HaQJ@>8GdUXYW@2EHX>:X6@\Mf8c>R>V#+L_31RODgS
eFZOXA#1Y?PYK9P+eK,7F)-?3./7ZA-\XO-#GY0;TMV]JFQB0]a<_,FTL?>I:0_E
WF=H4cQSdHc]78KS-\UXfP(S,IKPV3A#>>+._EI3S@A6ZHCTMeN0N_XdTARK]GTK
=)XLRHK:RCE=0Z>A/A^O@M^@=0(\/cH>(<)+O(3JM^-[c3MOW,2+^]bY6/U</9Q&
8Ge;:Y6#07SJX&R#D6)/#=A06N9bZY=9/[)]C3NZX.3f<:S9.];4<3E2-Ed(E7]a
#8d8QW]d>&UW91Y(8?e)N8D&3caAg\R(5833E<JWI^a9ZJ6B^YYB5G^D/bM4/IP2
?gC0(;;DEgR)V^9_4BKFAC3_4^AQ_46V9+W&27?]A:/cNdLO>Af:4ZSCHI.U0G9)
VU@ITa4dT_CN_,dIaOMQUAPcI,EN=8(-bAV&H/f>5..HbB)S.6)UN)SHf63A1<Ad
5^_B86\@.P1;[VV[;_JYM6c&)A7#[<(P7<:3-dNO:)d0>BCNCE.EIF(T@0aFgY&a
Q;+RWgB=2B;33/VKMgdF462^O)?9;M5>;(:C=-;T:PVKYeHUROKK,MT:-+9^QC-c
8.MU[71T+#.APL>SUa&0HXOd>9V-A-+4JdB6Lg;-P:NKPbf<9TPT9A;?6C=Ad1XJ
U,E(V)O^M>VO_G5#]Zg)+^QEAd:DVYOQ)^gA/Q1fR.6Ubc_-8FVQ4+FA#QZ\\OJW
ZZQI]6YBaCO(A=7(G5-)<ICSPT##6MWEX90(.[&gUa6#0ZF9aYbG2J;V)-OPE+7@
NBU@a;XA=UY8W;RU-O6<f]((7A[2HXIbCXa6==WEF:ZDHHLRUFEe[<dOAS9007;0
)H;V<\H]g[53(:JQC_]S88Q9);d\?M.eL2/.0=2c?KPf7JYbZ^D^)?\S8;\gR8MJ
LQWZ8b)gT]U^AVc]O7\;K6>=DMD_GbL#KWK,KJg0PP4[?9Y&#OK35DB?,73F5\g\
&;;JeOL:>_&.>;f+-.[ZF3C^CH2TW2BcN(4NKVDPOe9g0bZL6NPES&TY8GQ0d^/=
DYHH4KL:KEFUZG-9\[7a<(6E78[8f,D&N:^fWI0--6=QRdWbf4G6&0N4=-5IK=2\
@0MB(b\;.Te\X[8b19Z5b1U1XI7eSc,.^Xf@e,Q#.F=)M@eZDe2&+4&K7,86W=M>
a<^\[b?U]cH#cOe:YQ/T?0VeM^-FQ4N\4-&(d(Y<A]Q0U7O/BbKc.ZYHF?OV-@BO
7G@WI^VSeH._@_A)dNGW>Z?V2+DfbS:VJPB[:[.L[Y&Sb,?>?)UgA3>9;FZ0MAFN
89#R,];RCBZULQDeP;2)6fI,W]cU\&@,^E36b##4-8Fa>?S^10g#&7+<\VPF<Q16
23,cPZRLFL/PeGE58>6\<6O_WSE<A=Mc4.&O)I?(V&OS+Qggc?5a@>VCB&E&f+1;
OB<NS)6EZ-\3f[UI]-)Z95?aK,HFDC:#NC#_a1?Jc<bcX)6F-LOBgMWe;L6Q/[FY
Q\^A&Zg[_AJb5a7GLd)?+Z9<E:?<\+>eC+C[bVCf2VZg,UR(CM,)6I<aTDF.W._a
.ZV6>BW+(5N?Qb#-bO7\KVD0:,?3c&=7CZ[)QM/Q=-V^ZbH94;C#^434YEZ#X_5R
d)bb,J:BV8=R376=UD8VL-UA&W13&S+I+)OE89(&4MY7=?.C.DI0=KMB&N>9KDAS
L/FF@;5T3XWK5c,GK1OYVf=YHM#LWPT/07K],X>62GgAYV9e/_C\2O6,A_J_BOJI
I,6aA.aHH2@JN0,HZg)]))-F]eDQL;AHHAA&CNEU/0DM>U#SJ3OdRJAN#N>A<SYK
,8cAO)B/1NK/Rg=7-HHLZ1CF5M-NRT.-fA(BA8\PLgO>g[O,J0UgX-e?K2]A89Ea
aYEOJAC=5P&QPcK-g,<&Q->NV&L?7&eMM948@LH-E(1S.2M,O)P\M)[.NB/@V;_1
a0=+W;@D^#H=\;,ZAZ;WWL@c)WdEGUX:c#56)GTF&J+01X7eV+f^Xe;BK@6\fcL^
N5-C(ZE&-gMDg-SPD=7V]5OD6@6cJ^;.28+,Pg6fS>=6\)<c[Y0YF8PS^B>O9d93
,fF]@3C?=A/G+DFON0:WEKW(7d;M(L2SL=6GT>#6BPZ/5UKg.8d+K&<8J;);1fY2
E(PKc?_<G5eUBW3MB+4^94=/c\Ac1&A&O+(.=0(#-aI4eVdDS)A+IOIR()Y^=6J6
d,&H:fcNT9B7YC:cgU8]d)dE_;N)bgL?LT=/-3=-);&P-KBd>H81LP/341M[+E7E
aBgJ7MbHM5H5f-]]UKX1/)C]0R:F:?H[bXFQ>2D],_^d6B8ULb,Hf)=4WO]?C#T-
96Q-^#9E:4DIb.SP&bP4FAW_DQLL:8++O_#?40)1[@UW(Y@^M?ZZ8I[TNXH4_^+G
:0<JgEB^PH?+@5JE^;:cBJ6M[Rg[)\3cf^OB3b\RMMCG]T;:f/--WN9EDBCZN?7@
gUd-)DAK_BScGXfaI=(YQ4?\9Y=>D4+7).I&WFQ/?#CBb#CW3KGRZS;D<\+,<C)P
VA5=^L?7BZ1WbS&DBWJCC.Gcf<U>:<eVTO:G.:&=Md_R86SI-S<DZ_D_aW9Md;dC
cUE^V::[SZ+S-+O^NQZLH]H>LYRc1@U&^240:gL<,38(HB94[],@8)SZ#eBF.Z?A
6Z>Hb@V0+X^A-9T5eQ3]eGfBFJbSCL_&9fV\(\1BV6,_FcS;1V>]1)N<4YY:#0Z(
&0R]Ac:JPa#A8YM#ecEM=-GVX;3A.A_S]1+0C8NT(GH_g&(ZX1;SZ\edg32KL900
7>,b?Z8,\LbFKOXC4=]ebHAJ1W;LBT:A(@&<\)Z5fE>JOdZ3&7c5gM;>)_7R#?e_
\T9AJ;F=Zf992R.D8Y+>f)X32I7O>9Y)GIDXB,30^/a,eO+DfL(RD#Q]1ONCa>+Y
HG]?ag[Lb\UJ0>_BSPZ;6>#\FMQ8@fDKKP?VT;=N;=#MMWJc]LP4KZa+,439+5(1
PfBe,1#O]U^U[.)g@CQ)F@[#NNbRJA@T)9G5:Y-8N>7LE6/TH-CaWRGNDCV\gDT&
_6WeH0E6VS^OODWg=:BNc=73WZGB>B4M89CJ_S==R7;b5ZX252SF&J\LK</NVQ\d
8<-]g#^.7L,C[bS-;E<)M#IeS[M13+:A@I33d#MceFJJeFV\6GKOI&\IHda+bUI,
Ta7OTLc5.\?BQ^eLaE,8GC\1)Gda4Zg2.5?6?]VG>.<R_3]DO5A=:=X0B]C8GVZ9
+EbS4eG181[P1QK_b4KHLeYSGXYOU&WS^<V562H&BJ?QUE+0@g6LH3NC&YI[NPcQ
b1L&.J?P=YO+BET=d.O9.6[T2_YDPJCCa9&@)\a+EVR4AKcg4#J=8SRaXbX^c=NL
<Ld[(X5G&cGN@ROEB&GO5ZEG,+SF2=Z6Qa;?,#W4O0fg<K.4DUP\KVV?d6I<c7Y2
R>Z6/6H[ALN?;O1^:bN>a/U2738FV,I#6/dV):_\Y[;?Ed:1e(]?E]_b3Ia,+g[N
&_=T9CG93>1aF3A(/:G0CH?)B/ZFE;V+H8\6SU.179\S^>TE](:c,&gGbZ;e34cJ
c]-?_4_:eMC^2J3_-:Q_/;f\OLBCWYSE-URVL5:AJ+-G:geFD^P;Y+^[=_OMA(9b
SR;P]55<>[+#>OHQ>=0I;)<JcMS-gc<J0[5+c,<)^,IIgAc;/<3Z2#J93AVN@a\K
3B4<\NI3XX9.T=&.48&A(Od[\+XeZ/WW6YH>#IM+PJFNZ:_;6AF52])fX-:N=V]d
(#-&PM20S&ZHaRGK&;.+VNb.f>VLR=NQ<g_Q3Gc2O6GXF5M;Yb:]D;G-d)7Vb,]E
e:^LH1.0X8\IJNXIfHJ5)1fZPW^c/2(XDU,LVJP(S^@[A2??_&@f0d\W62/.-g@=
#a6b7YCJ7@BLgL]f<(#EeEJ2dZ,.6UZVVDP>6f6][Y.YD6,;]b&8OTMeZFOfZ\2)
c0()QD4GOY-1@d&e2JD1QBReNaf6LC>4KC,^]X6TJ-78WKb@E^\6SZ])@gX0LCUO
W_B8Z1P;[>0,9,P:6]gQ1&B3dLT890DR);6V(c)LM7SJ^7H?F.9SZILFY,Dgd^_d
+6\&X^J[>NF)K_:(YB>O0R.]VTQ)D7GK@<bH.GN,YRZK-JY&;(OHL&QI_BL9VfJ>
(3g3(6>TP#KU+@C+\-DHKcbM97,QL2e7SY,=S2;2YUS:Vg]Z_._UV:?[HU&S(WE.
\7;TPI#,CI2V->[b-@\c,^dLVY8I:fH0ZaGb>>R0G=g2E^2.b9&J4@SGD2SC9ST5
\0GL,VGA,.Q&e@+KP,[[:&8>-_(E;OMa2#7@34QeEa#JO4V&PcAK<O0Q^\Z9SD2,
a\?-^4:Y^ZV0>?Y=\X-YU35Y>B07FM5c1D1Y(a;\0[.b8BBW/L<<WI?>g<F(cB#G
G+)Dc4@^3&]6A/)04#9=NO,3?dY+_b3\])4g4,a[g6PX]J@/bfGSbZ)Tg+03FU7-
_1e]1((gR&5Z2#&:)QQdF(<G)P-YaP<].^gR,a(U]R);^gKFcc5QDd,bZGK</^f1
VF-bB2?>RE0,\6dP+2KZEG;7)QFRAf_O?-Z/XGCb#.6g;AL2I)2UQcDOd[d(AU8A
EMKbX[eOW^XLV+He@\0:54[&[,cLSL>9b_84A=C\PeHIB/=-SGKfDP/>>dX6MW@:
8Va_0eF3ea0Edc9(Rc2BQGQ6..2-6L<beF:-QIWe>H(^(02/9J/dO5U-(9:KKV1<
e;FS[Uca)TNOG_YFbLIG7CHRA2[UFV_CZ?4@:?Z/>)^4[(BJ0#12B1GC4?]D=EVT
BCUfK6;bX[.IEFf.44RT2f6[DI\[1J5(1+Y#/9^C<8aTL)]AAD-HC:fJ;b7H2Q-5
+J-UNE5FD8&/7(PXC:8Wc/+3M6SZX2UR13)M)QBJWBbY&AF2UXL_YIE3GUCMfU+Q
VY&RdIS<+<#D+A3_BLg=N/EBLOBFCFY)R2G\b=2241=8@ZKN-c46+(P@HI<a[+6@
1UQd3P/2G4Ld1#)e.^6(2QNLP<^I+cXAI<N5L=B>?6e^NfA3O8H^-XBaF&AWI=HV
TA\27dLHE]6c<JIIf+S7W[[)#AHWb)J<IS9&))7@.4\3GET<D8(GVFbHbEcGeS:J
X.+4/]R>+^dZOJIYfZD975W8Y6326>^/d,L\eW<538;3T>B(-R7ZS@4PMA/bQJZ:
S+dSgG>Qgc<MG#TIC@AfNbbK(A@O_OeEM@B+[5^db=[BZ1Ma>--2O_]WE)VJe?^V
ZS/C@9C>e_/ceG2G<?BV@3cCAE+9Y&Y\a]@NQbM7^O5FIKTCHAc1#3D];S+C(N3L
@4;\c_cL)&>g6YA@D,[FZNF;H/dD58f50K8cX-9/&IV0IG&S+A:&8bT@a]@gH5Ea
#fR\91LO8O[QdgVcY4A5e8E/LTVTWdI,W4Z;OFaRO_^3;O7fIZ:b0D_gWX,a]E)J
)0aOU9=O(6E,H6)?C.\,EEb/bR=0T<^FRDNB9OVdf+I-e(][X9g+E=IN]GN.PPL6
2,@b;0XCXMMF:<g[40NEcZ<)cO#PBQI&8I^+X[M=Rd>cJTdV87@U/Uf9=C:KP2Y^
\U6<Vf#7(-F==WOQb9VMg\]CC53[9?;7490UHU,)L4J1gb:PJ7eS[7&3RF27+J_^
W78TC@5<4<2_@AE8944-5/F#e625+[V_#d\c=\,+D8F_)^6Y<JbR&PY]XJ?5M<(M
?&D#?X^0(_.N)2K:efbYB&]7;;&\@>J\\#U4+Y4[VEKf#RF[=P/ZK^8P?+ZD9=R]
a_C.^3#,N-M-303X.aGEaEYA/BH?//DKCC(9TQ>P?3XY[(^;EK2Za8O6=I:PPX0>
(a28?E<F+XFcW9N#]B)D?NK\Sd/=]?_[Qa+9f^S;T4.9NbX_FCFRX=c\Z7XYgHc@
F<Oe0PDfR27WA4E^(a8C>G8=V6RM(@D6c_9[eSA^Lg51X)?#WZ9<<OW^GEB.<<U-
dBYW^JO(fH3A[T]/HCSb@3a,5E=,3@,LWZJC^P813MOKK]U2@6cH\_=U_JTV&d(P
Ob\d37T81f1Jg[bI&_bLc2YaeaR5P30/6e4K0\;cFg+RT&G^FAb#+^EH-Qb7IV9.
NA61;Z21GO<_]-UY19W&FX&B@SSdQ7)D\/2IQUVWK?2:Z@#?H#8ON77O\7g3G]SF
SGf3gdQ19Hb(Q50;<Fa7Nb.JVO[:Fe82IY2b3PPIFJM3U5gW15[.0WHP\J3>T,a4
c(F]aRH;>_VSPc5d&-e)TC/]0&9?/a@aDH(:1P?7W6J0:.QA#90M9@U^@g:B/0DB
?aFJ2=>>=g8?a.ZI9YGZ&)M/Ke2+_T8+X?F;MQAN/O^X[J_Y;a?5H@>CK1(T88c.
)2QW\f8fXBULa7Z[MKE8;D?J-0H>[#QEd1:EYOgJ9DJ(=2:GRV[5A<87#54eP:N)
fY6R[9GPI)#dK5+YQZ-J0eNf]9cD[/6?1/&WKd,5]U,&0I15EgJ.F4MY=b+[f#Pb
Hc#^/]KKV2c/)H_0db[X;C<fc0+@<U#:YFAG_8VG3Ea@g[&:58+-dZO4bb8Y>T-+
-cMG9gK9@YI(-T]W.JQFdbc-W:S2:&>0W7L(?LgQ(BW18[^(.@=GDORDG5<Z-CA)
?,DGY;;36W&B8U?BTMN=Y67/Y\Ac.@[(KK^eLHcFd&&E)f(cY;^GedOZf:R8)>;P
E\GO[eK99/-X-6_53V25e3BH=U5gU3R;&Q]EK_-D?2L4=IIGJ[W^V2L]OQ]7[ZP3
YQg9_CL3SI:6a6]>dRY9=TKH;QD?DY6ZVHRJc4bGaE[E4\a;B.+89gVY#W?)4\H\
@9T7IGXYAOFce]XFK+1@^7gdd8ag:7HE7AYZ[F60BaD=JM8e.-\46[MQ.F(@X6)J
GURWX+3:E\4[8@(fJfa,Xb(e>:@]4d4P0Mg4\Ab70D8XTBGEF^@^+PEZ:B1V@abI
7I1L.IcB128MOCI0OJ((gfN_-O4FdaHa71ISP#F1_X8:Xd@.EI[a/I]La&2UTd((
X)WH&UEXFE;cI9-1\-Qb3^>2T6Xd&GYQ9cd;I,H=->-Q+]K>PW7FN]&;=](8X5(W
SBe/M00eaG#V=U.++7E8D7@MGS>A08]7]V12@<,TMNC[Y1>Z>+H1<.f;a^OO\<UL
4:NCe5?EfK)gR@73/,X6)ZLWHLa^aVe59SE-@(,IK\EK<1b15&/]aBEa+0B;+GaF
9d/?<8I>UQ(DU9SVa??XQBPZNP^BW-+KE2.-1I9Xd1f5:07c>X[K80(T:,;YgAJ7
f(Z(Na7SA2&AaH.W4-:5F/Rc#G=VgJcEHH&[Z-\UMg98fHgG5S)1GQOG8<J>=]#[
#gP?g2N@Gg/eO6EWZLE08^ET>HE3824_244K:f:P?.+K00I<cQ+FMT5GU-@8UF+L
aR\09-M_2:G8-TD;RDYZ\@1Ja3[2PB)I<X#VBK3-Y:1aHR5S&<QQG3Q7S&#<4W7L
;B[=GON-V(;c3BXbc8bYV]_7/-A0RA3fFM<Ib-\7;X>O\_cTP)d@<eE>d@>>&IC@
7_/W>F#4Bb(M-LS(ae?&0aK3NNdd5#70]4R>4X^4)5RAR4MBVeGIC?)GV>@D13@A
gLeC]DecBOQCDMeTFbYQX&N2UT5MDc:Z+Ta43DJ_PGS+dTPN4^HE[<U1e>OYH&9T
71T5@&d9NHG])4O(F134\-,_M9>8bR^<ZM\f8RUbD&53KQY<?^G<N<;F6XFfU22J
V^eXK6\K22Q\7<.Y@R#e6&8I.^/<aG4Bg>L8f):,.=?N[;AOB;-UAS_]O:7E+[CU
R+RJB<<RV1B#TS&E@<B^T86&.bYL4U?O)K,?@M8(\@66BA<<&?GUgb?ROQ38S&<6
dMX]&3EBI=/XP:A?,Og,+.V5OVOG(6X:&b-/Y1V,C8cL\^<1BE^PZYBH;PMf(FaH
7W&,\eebVC8BeILcZb][3Qb97>6./H^BGP?>@BV]>eKAMYOZ+R,A@<_P3fKg7(M)
Yg+H[&:_gV0dJK+QT;#U-b[-WHSQ=GAN33A2@)+&\N_5X-3aN2\/B4;)+I+^L[48
;DA;383&9]&7=8\&f<@Q0_03;<8G@g&bc3@//W(8FF]2P02b)J_:6#COHBdO?dJ:
0QHYQOL1.W;#a5L?,-aONAP[S=b5C^]3eYFUQ\U\AfBV4#g92LcV(d&b_]3?\-[5
0^&94L;1/T/BW-?F7M1e#-ZfR38KKS:BgIZB9]T33g:W2g9.P8/60EOSLS&>TI/0
AJaGEL/:MZg2TP;\M3Tb[3dBQ9_4_L,N1@Ca_/,D_/EWM+IBX=&1a2C7dF(CK-MO
-N[LK35e@;MW)V?IG,9;?dcG<Mca-W=U[BWM0E/U4)/TNGfcZ-8;MB#PFQ\b<C)G
X\FF\d47<f3?4X2-,+H3,ZB1eGg_#K=GG02,F=E-U.EbRJGY1WQO=_;c56/N?@A?
WQZD8\\AF-7G_M4-UT+>SH]11FOOM/^9?J=B.Q83fMT..31L.19)\fR:HGTN#R6/
d;Q-7#=S9UO-9B0eL)FN5^0f92:X55Q7O>9Y^^G66N(P\?&&D)YR]L#,(6S^caN?
@caO_BZ?+3NS5&-]XDH4Vc<P>;1QZ)<<Gf;->deL8Ea4FO&;BMfIGP?a31I&NB+H
L:R1GT1I;LSTBI;Z[C#&F/U=V8TZR1-8(2:&aL9M(5\;c]P=?:A]>415MA:a5F;)
8bW0=&F#+U&ZS;fPKAbQK0<VNTC&&,Z?=bI@eUU9+=P5U11O+\U7&__cK1<e;bB=
E(\8=:PWgLDH.O7+\aG5S\FKL1U)YPGd^-=O2YMAGFA;9)F=fUJ)V.MX)##<6F>_
XSHBe9.L_.DQ45_^8O1HTPKb6cf01^T<)I9)5RETH^)>+dRc8dV>U/c/2\Z&8T?Q
QF[(\)C0-#3B\QF8,S73ES./[aJ+XB-W-6F.D3R+a(3@ZRN5ZP7OIG4GPB2ec>9g
D@<BHW9Va#>d1DcO2,+5_Jb/Wb5;&AISVVc2b;46c(Be()fEJE1;g#ZaUdGG-.B8
Ff;X3QUS<ZU@VH&2):RSBNM<)#ULL2IK3UTJ+T6g/8Z=_b=A;0FfHca)MMEY:&/3
6(\OKDMJ0E_5KJ6MbA)MR/cWC0Qd(@(LD-d,++\:_Hb#g8#f7L.96XKc9geNcLAP
C62C^E.L7U-50]7bN029CTBJd-1C=1#c[.-OC>\^W56H3@R2bd#KaE)_c2bTd(YU
OV^b(.LP+@2IW3BFREUL<g@5CG+;.LGONbbAZ9,d+C(W(U^NTPA\5e&Za/ADf;SP
2<;FDPTD)(45BZ#=^fNTL>ag2e]Se_NRI1E-H,&5CRN7:4<+_NTQCUZH4S;FdAbQ
U\REdX5&FPc1MQ]Z5Zd,T><Rfbe0VQ19NR(QNKXJ3F-#GM)80QT(>OaMFO;a8)a<
N2AMH=;Ef7M6c_Ed4I^Nf=]8[198?DQg-^HeLL=WT0cB\)6>HKg(F-:E09db>2X_
.<SE]UUX[QJWf2HP#f5B)KZ:EL[;HAT97Ee0]0Be1299dDU);\SIW.U@&#ZEMeT/
Z<W#gHDcHY#NO)V.IBJ_)8@IWW6LW(g2B25,II1&SYdda@39C8A;W&WH;UHD;E0D
Ug-5ELf,5e:R,&L,7QVHCbV.:M>,&IF085PDT;W5-4<TN?T=-aY(BSY,DV/@cZ1,
VbF92@3c>G2638@B<C3-X,&U@[07R6KT2IH+5L)]HZXKN9Zb?V:LeX6TKTSHA?dA
,2+E>\]YU((WZK9cAQGF@@4;EK_&X#HW0VaPQ^Y6K>^>CGe=QVN?H?G__d\K<gcU
6=&U(TV47?3W:1.U>-ZK2e,5Q&YL(3JUR=BfE-5BX0QX0.<DQ36B]2P1(e/NEFA:
2+YbY<ZZAFLgP_=247?=_UWb\(F7gWU9X51>BYZ>N7UQX-T/F6\(^G<1]LeFAG.T
Q[03)=f(0Y)dE^Fd>3TTa14G6@PQ,@.;cJ6#H4T#/B^+@S0=YJ0H7O[dcQ?_MfK-
]]0KU6@\8G\\AXSCAWBCECPe:RD4URb(^I_K,PPI0WCG)8II^XgUT/H7SX)MYegO
<W6(KR,3CZJ08c25a.U7_a#^A5#4R&6-f[F3-gBGQ\2N[J:PZa^/U:QE?:&cHHd2
RHXI;;U3+d0aX+7Sg-TX)/g9H-I5LL<Kd^XU?B,OEWXZWY_X43E)f_E?MA7Z/-BB
^U&NB8__APf\?X=D\9Z/PAR\:^.E@I1NWaXC=DKf7YGJ.DJ&8<@C[YJg,-/g6(9G
DABg>)THeE&WP^)#&>@X?,Q9T@@e(9PS2M9@I;b<HJ]K^&T5N5UPVY9V<>7aAP:M
QIXf&ZYBCfI,(7V252N:e3_DTb,B^>,3H+]gPfI8:9&ff\EB2g4B2NVZ@#XVA.#-
7#:7G7R<XPB7Ec(,6R&7PEd2]O83_;)^:]?_=?WaTU0R7K8Z/@DP&&XZ_&=7,/1H
0PVMQ8@4M9YdYUO#M11f;H1Q5MF0Sb]OUZ?350_S4bUCJE=#e_OK7>K[?VV.+b4B
=YU&&YNWZd0.FegPdQ=XUe2Z=O<OcW4E)?;MTE9/B>4>&4GGU\#4PgLT?Q84EY,Q
YV5CFM<7I)8fM27gb=)X,)I9cd&8WF>F@TMGV0BQAL\c8=fccSUWC:aF^,ZFIQEJ
?>H_\@9dK0\U-JcG75OS7cS&##4c\1[)gT9:[(X@aFec0#=T9g69Y42(.M<?2c9Y
ES?RT@59;/Fg1c+6EYCK^HH>I<VAJ4(2[Q6F-_f)67?A1.f6KW8)>Y@ARFZ;]3]-
;)&8_dP/:@)TV]V&5<X@MSF-):,4P1agcD9<Y=H^[eT0H+(XdA]5+eZWe10>^8aR
:Qa=C7&F6a0KF0Sg0O2NDEDf@AfZfG1UIDRW@&0WCRfM4+SNL#APD6PWVEH+1D[d
4\@TK/g&9b4/d:D9@,3H6;W1-BQ^PbDQ:Q?FS49eCQFdf1HU98W?=VNYON:?EV=a
fPacAd<C45f0KN&W7F=AYO<FURO&TG8R7UD.?P2#eXXCWF7>?+W;F/SW.4[O0e_Z
0/GZXTfOWUL(^5b17><^fIZ3[PH+E1eAZY[3W=73E:13:6I+<>SOJ7OD7\=Q#,d-
[U,X7>W<c7[+81PN&=4-OEZ:]JSL19K,\Cc21/CR^L=.4T37#2Z^L+:A1_[^TeC&
243F^L#DHXb1EGJ.::[Wb>NP5DVB^X@.K/,SE)6O).VW<R:2NX2gS[cP=-@V//DY
g:3bKX@KM\TBPKEdJFE4+-JF]D3#SP_9XG>6,IT4X/78b9?bY;.SgN]AC1<O?C67
UN33M2G1a;_[__ZeB:Ne(aT[9UWFITKZ[IATe>/dC4[Pd2=OgYSM:W,P?H-0#cTA
Z5<cUA\+CX@G;(+2O\UB,CG<464W)#]g-(0DcNgAgUOeGC1\]Id&3P=f2J>cEPH3
+5[V^1,bKHL/fWS)6X+>/_SFf=,adI3(PTTXEWBX#.2-0\:ZXWJPV\?)(cgXY+W:
cYS95WJcLVCW2eJNL.L97<TAD-KRZ4]#7]WJ\4V8-c9<dNA+#0I;b\XePgXV-1IB
ZK@7dV7gcEf]ZLW<XMBZ02WHYfJM06JM?.Z2g:-MdK^_VIbHQ\\,^/DDWUMf7Z;L
2ZKLR7IaEb5dA+&^GI5@8<e2CT&-0ECb>PJ7&(5,I:dH1IC0>BG08&35OSL]<>Rb
OGIf@[V?_M4WDJ29&bV2O#Z_P[@1=:[DN>;(_P]0PIV\eQa0[?0?F(a]L>=G4[gN
IUCd>8X&OS^.5d[Ha4RPLC]LI&V2M/4<CY?6ba:H]4eTI,8I,&U6=L?1=DKff91O
5/b.YQK/^DFCK#)_36Y]>@@X90Kc^1]&WFHVI+<e.b5NJfC_WT9M<21Y8_J#e,[&
[&c@^UY1KF@</BR.9XbCV?\4P-MJ/G8_1C-(8dN?ZQ;I?U(JQ3=8KFXG]cS^:=Rd
RYfLZN;,Z6C&T1Ue1HNCAP>H/=c\=SdE+YWHY5JN4<EDc@WbN(R[QT-I]d?UEK.J
6.9:-#abI:<S.],J(+\1,.@]][dTMbG&@LTBHROHN6b;EO4P:,OAVYac<W+bVG=3
0@F[N=^LIW:9743.,4SOR-S.^5,ZP9?EYe4/>4ODYQ/71X1DV,KMK/Q[4R512.C(
eKYa.N95I7NGMSEa2d+AHP@?FNGN1JI63K734XIEZPST1>a@C9T;4TMWFL=7VI==
B=WFHJ3,]-02HF:agV/KC0#aJ6.d)8Md[0TSI&J9QVf);PNG1a6MQP-W,J+9:c)9
f/@a=Xc\N@M1_P-<>>XM9c-4]CFI7V[H;8fKR[Df_A+R1BBYa>Aa]U84Ngd4;B,/
H+H@\fUR2,25LR#f+/_YL)^M0XdF,K\B@:@+eL&KY?&]CJ&Tc2GC8S4F]A@<-g9;
PXd.KC).M\c5RZRZ+^N;SWd7#^I<:DE.H]BV\)1JA@ZF+QB&7\N5^-eN6&AP37Q&
#F6gYVD9SNNK>?H\40]gN&0M5KgX5@+GB38B;dO#SK&-E89Y#9g,P19HY)K?0b:S
f=OE0W_:O5C@XXMF2<S=0\.@/1ILY<L7]7ZF5N+,Z[MN()=>b:,L]8B\1TN;-TR(
gMF(cHIZS(XC#00J)EA\90AF&L(]Q12]&LXR[8cA)@6;26d#DK5e,:Q[:HKU#8B4
B55a6W[/&YWN##&\1K4I<?f8+]XMfK2]\S2G&5U/CSF.>H(<L:f.+GL+QO-Q@3@_
(1\F]-HL64#<?_^A=KE[?9S4gUW_&G?<S:QE_;37-CD;6Fae(K3\eMW-9PUNO&F@
&;8/HPT?@XL2?IO8[,gNGMCYScW3g=g.b@+8=f/RK42Q,[T;>AG/G/-deEaEIC;I
SN:<23;D\=c#M;7&g7^=QL=24#_;3?A,K41OY66Z\Z21F5.Ke=IOE+<1^4)\SOW)
#/@<X40__BaB&]/53)e3daOV7ec>2I][a=<AMM9fUR3Fg#RA>HCRFC[K&bHfag5B
+(:3UFd>c#,>IU78a6fOO0):-[H_TLW/d8E^6f?+(OY</MZR2fW3d86)eW(SWPPJ
9e#/W^MDB)-+P0<LcEf])[F29be:6(c2_a0R^X95@IaF7K?,CK[;(GNDFL+MI,O[
#Y_EEL@\>D-Y[;#28WJ87;Z^CfBCKXCU[_f:Na[Nd[3&1RcDf2G8>4\C;C?ECA_9
K5BQc/SFW<EA(YEY\>^[Ud3Zc_VY&S+?f^ca@^[UZ\&@Z&-7L5a,Fb;d#I4=PR5G
,gF?B0J)9g]>Q]Y6MG9[\9@dYDGf.>-MM8LeYf;=D2RJ8N9N:DQa52G4<_,L8.B4
[=C.ZONe&_>JFDA?3:4&Eb96.e9H\3SOf\H.@FQ,d24@cHQg)E?T9Y<V34:@JI6N
XS+S^.cA3WcB8b47.QRUY3S.M.\/Ea^FI8@Y+TRdaW/(J<_aM>V+=QDA)?^[8?VM
3.TT<YDE<,e<Y241daL>[f69P)PNXW-UIf+_]<2gG_Ogg-K93GM8MW#3Wb,.5]Kb
deA+/da&#2OSLOLYS+E//=5XgE+1.R[M^<)XU16b&._4O[[1\>b.5LBfJX;T:.I:
@[AMM@d8Da5&Dd,R+c5UOSMVBS^_(^MZB/XYGUeD0\&^K+77<aQB=d1BX.^BZLL&
)9HHF.J;9HH8QEIaJ2UYbf02Z1K)\L=+Z[JC^&-ACBCI#S7DIA(3?5JFWJ5FG4WR
@+,-8<T_3P(ZR[A-8KOXD[QYfR9/&IN>^DER]dDQK;Q+;CMC2>B_F+1AT3eT+OQ<
BOIA[PA-PI]d__S<&@TYD4;a.>FL]e3/XL<,051JMb9<T\N(:bR#EE6<c^>3T5V\
2K\5X(>FF+C3:XKJ+cD&BV<X&)9aEO;;0]-7@55^D1_.;P-LJ+505FfHV>MbgM0B
=.gVT=ZN4H83OFLUgOR:\VN\+ILTQY53^9_eBNG-?_Z<3J968:38\]/g3,b(4Q+Z
?>B<1?EcI9)T#K#\1+eJ84R]S:2+.V:,Tc(eWKV?MPTb#\U]<2[C7-G7_c):c&c4
Z@gACeMe7HZO-U#f#T2Vf,&0;UWD5edOg:I0H7RU5WZ=@XST)/Fb//;ObWAbQSQc
71(H#bS-((X_.3(/=J5#,e?>A40e9f]30NW3EOXTb5?N_2^79P;]<D6P=PSX2;BQ
>fB^aD[[Jb9Yg?ZF?:6;61fCO/Z2>HUYQR/I/GBc+YagBVPe<K)]FFJ[>NKL)7DU
?S/8T3\E)@6T4@dA7HeP#SFW+?cbN4A&/>fIFPU@I]?O[YGP685,,K=LM^D0d<AN
2Vd8ID.H.0.F/F76[DP.c4g0,;aa?N?RSR(^&S#2&I;fQ06A#[4b7a-NY3Ic6]B2
c:P];L7XW+3L/QCc[Y,WJ.CO=I@URCM^)/4[CT.Z>g?V@_)f^VJS7eDA01I#.CbY
gYF@3fT[&c&#>DM&[X=eXYF.M:M3<SGAEQ-E4@#_HA1b9^e-#WfCb8&>ZgN@NAJ+
F17@Jfa2#a?L6O9d;e4JY8J6(5;I-MTTaC-0Y&)^1VJJ@)J0F,(V&;4<ORZZE-Y6
RE>NM3_.>MfKN13>G\INf;4e=&6g->\@g#15#7)YQbXdQD\6[\I5<Y965V\&CDO_
Y::Ng0V7WE3IH=g<]4.,>)Bag@6g1G>\4ZS[CUcbW3IWK>5=;>YX<G-8\-^8FCM&
A4A]KfZ\IOS[@]d9VSMR99KB6:H-921&[LMfB.2bEK<+7=7\=XPdP^>[d1P<8MEB
JE84A]YB0<QJfS-@C/L(fVY_AZOR<+<McP]QHT)/PcO-Q=6)8_+Q&XJ3]dgUB#;P
Z+<_&,^0<DCPOUAb>#<9E7L@Y.d^VSHGdO.L2:R=L:-/<\XK_:f,2B]-fJG_7=0A
@Bf+DH<5Y3:]0gJC[:3330STYFdEZ(#RLF9T0ZX1_^AKe:)9@+c\e]-.SR[XT)8\
Hf/]&a:Zf05,2D]Z<DQGO&g>)F:aF?\S>.Q7H.<S&^;OG+CgOW#3D_PAB[M]O=DS
dK>H[C^>T<BA34LAA>:=/_/g.FP#a<A5?S)bJHEUPfXD;5EF-J+X&3;gbS.14@1P
:UN:_R(LN><C5U[gKZTJ=Hd>G\^_RgA9;,NBL)-ST0DJZ&OB3c;\SDAK/IRRgCW4
#&LfMW:K8b+,ILRe7YPJHWI1)9)/3PfbOVN?V^-&EcSCQa)YEeaN11[T1^RA,2PX
]<[dWDeOI@CGdT.:8Eg6YFVJ]4FA7E@HXG.[e.[,7O2<;Uac-[YNIG8=)Vc#J=a>
PU#GC9B0E,=g:R.Q&b>5,\Z;;U4_W62T#;@<@5&R+&3]9[ZU:VbCeOL7,)3UPPJ?
P+d[ObSNJ#C^f?T)c=]R#[+^ATCWPI((MM)AC0;:,U2ed_THV:,fWGd6,X@NRgQ4
VUR_64NaMVFD+78^F\Y2aHO1\/:E:+;4f^P/\\(//6FM+N+<BgRcE_EO\b0f/bM6
/J(VF0E@9bICJ4/I>TE-#4NgJSKFVL==32IBE><2[Cf)4O:Rd\21LUCgIg+([R82
P^g5RA/M_J281OM?bZ&0:dTN>+Q2=eKWN>]&ED/I,025)IL2G[[EQRC5d@X8+G9Z
A^7?e,AF^VOVPAd-WF2]bfc:.<1dP;a[#db\7=X#Ba&&BV3XPgeSELSUW-@5Z4PK
685cb[]39<T>a:<CS^;0KT/U(LYbT9Q1LfLK#d.+JCH^4V#dLdHM4]3SS;e=[UcQ
\[],UPf<N7OWK?&G&_#[B6+=I<3UWFE#bUTfL6]gIC3RA+/MV?]/T\9BJPJPTP(d
2O<#SOZ6_\VNI:g5[8L(8,ca7E0RAQOU@2/O:];WV^M-U2E]7ZR;SZaV>NG#7I4:
3(gg8B;-0-e+J<Va8#>GB].G?gUb4=1.T<MeNe6<40g4X/=>;d<gfD[[>GBK2-2e
-A]/S@\[1MgFg#)NH3_,E5dXTNZA+?gY(D0>,P?&042-?TOGP6@^N@I&-+O#0+X7
WCeA)D28b8dK1U#0=Z_G&HQSfI=?L[PKERD@M)-TD\64MSV:.dXGDIE-@RXP:BE+
O:e<L5L)gdJI26FeV7fF(D_2-KH.J:8R8^K1XI,M39(UD68NEK_)=[^TWQ=a5=W#
gd;=KK\6Z&G(;b@UPWc#/1gE+aIK^MSW-30=J>+[YLX?MbfR6Z-/(/MN/_C0@IFQ
5OfP:aI_^T3:X#A]SA<6fL=S&#gU@==3?U(K1(&-\YFQ_Xe7DP:Zf\Aa3],5f7-B
1F[Yg5a8;0.D/Z)8>=gHO6&W2123-J_);&<>]ed(Ne.;)dP@>-)EP#Q5OZdZ&3+=
16YB3A@\K:EK7+Ga[;JMc)YRcZSb?IDO0g?W?Md,0Y)ZRO3PF]?eDEV,F\LcLB10
<d:-AA[?dc#fX4M)UfSH)#VA1N9Q?1\PLdM]dWb)O];I\Z3(-a3<\K0eH.AX;Y.^
IE.]aB61F7N=SJ1H#U\M#JI_/?^g&<,(.^HVIGc6=AOg5^I?0[RFEY;/8S3<2W&Q
P5T]S[<gDg54?K=6K7L]APLa2]S4#DKN6##F:01^Gb^FdGVDA7[Y/N4UDPXX<JTW
_eDL0HL8@O(c+5Y:RAB9g8HR\DQL+,HB6B\(KO566@[7Se#R(bZAZM:d2^@+A]#(
H1OQ?@7;V-[4LSf8]NGT:J3,BNHG<c.3IXYM\Y)8<W\8cHL;+HE@N_?+=K7OQJ9g
\EM^@8d9H\9,\IG&W<5dID86d]D_=3Z@@FN0.f+Q4GW=MI45CE)(Z8-K@UI&>OI<
010#GX/162cEEVUMTT<2F@G^?X&H#[?eSL4Z9+R5F,Z&TAF#R/Sd(RVLR]g4N8<^
A73G3a+\XA)7)CdK5H-&P@DS(Y^3WCXLR&CS;_4WU9W(VJC.7DU=/-E+9J0/?:6,
1>;Qg\1/7NQG2BG@ZO=)?b&ALH/83a^f?D?QW?M)S@bZ=DKSTX>1UC=78SX5[=)U
HgRa.DEEVT;.C_DY@[H2B95.8We[1_Z>ebYFG_<5?C?65)7:UCH1^B=7RK-Q&f+J
(\,&L6XZ>GYT<Yg(VBeYf/eN]P0V?c\dB-8>G5Z;G9dA@S)W938#2H&KP-MIE_b^
Tf8)]1E?C62P54cBSM5+g&JUE[_.eK^D3&_:dEJL^d#NPR(IP#VB+<_a=7H_UU3G
LXRcL7Y[fcQ>[A>cCQA)bWZA]-a]IOb=Q,NKc///Y:a\b9Y\C:7NId7SFM.00>M@
bJG,#CQ##BCH/2N;KY7,A2X21@\LDAMUH>X(9-=aUeE&/YgW;NUHc/[f(:c+N.ID
/<G@&E91_@H6><10E-/gdVfC\C-78#,b)gD(0FWe2JTD>#GUFJLXKARXGd:26dB1
9JJ_P2I:P-5;(8HD24c/X\Z7((73+KI+.W.-6f#D3QUPRFeD2G(Hb:W#3HF&A&3.
H_EX-<>T8TLDbH0BfT33EQ/[/+cTL@GS9Fb,cRF1@d4#gIDBH[UbMR)gJWWZ3&7>
>JCYZKTWGdd>Q0[NQ7Pfd[RQT;4;7VgL=7>Q&K:TST]\_OGg@FI76K\[1b06?VUP
X.SX.&].XRS>=IG?g_#)FM.HWX=7_:^-E/311g6KIICG=&:UMTU-HGU9]>)7:fYQ
X;F_P+fH),ZGEZ:>IMPc<Pd?OCg),Ng]CD1J\N^2&V6P(\(gK>Y85eNGgTQN1@I>
ZeF69\DFV.-(]7A5NKH2;2eG+42CF;:fOE[]YJYS#Y23Y45F#S938R7XRQEb@g4P
g_90GX1\HKMST0[EMaa8dWN00TaB5PI,<_PPZV.BLWJQFLb>)5Q0PT#5D2J6TE_>
-,5&T;0:KAc4[f>Fa_0T5NQO21K,LAcf2:\I]eKO<.5POZ#Xg-_##GYYQ&Z^7f@6
P=eMT)NRCDfN&)HfaM&6A\,@QFD:Z3[DN.bM1MTaI4\O-:>4c:G9NG_CKG-P6:-N
/2ID+bJ5_X7ecL3I?R8:2>^7/;M\K0,ZR(/;SJX>]LQ7?BT([_Y;81MFe49GY:TK
I>fS\KfX:ISK:cTQH:+?7PPY^9J5(_fNJXbPR<>U]35R.:JA9Na.e;Z)>B[];XM2
?E<K\G4M25UO;ZORDG#@O?-J8,a^FV@?\2Q1<A,:VR5D]5?cZ9^d,2D3FNLR@JQ_
VZHN_,gXA7ENHC<\3Zda:Z67&dL/76I&T:ZP?B^]:(NSBK8A_CdM[M#T\?A@5@B]
bQA&&P_ZN<_UZ4)/QG;Y;.V&H_.=UL8+IcGT4(7Oc5Ad>gKbP6+;c71CdF.YY?RY
)XPI464fE2b+VR8D]HD&#L3AB,^M:S?\K?a=2?9@]Red?ADeVbZ(@Q2MB75=,+R/
E]bF46;V:MGHNg(F3F\A:<,H7fHD,^V2_N26Zf8US5E,?d#[SQ)WeV9cT<20G+c]
I[d^E3ZSSMAOA@=A1Y=,7FWg)e_&^\R#g1K-RU?EV:b@/1MbC]DVSDFP?6&0U)>-
cK1GL4REcXQ7B0K2/4[/e?gf?S^^c3+A=2J4Y9\NJSWbZXQaDS:-HGND(-TL#Q->
]\=8)0\XW3U1^QYI)&<ZDOEK,(5_/]9&B+Q1:/,O_@f;/4=6=L,G6Ye(.BV)eZI_
.7Y^;477.^FRHZG#d==,;6)c+1-EEGa@3<O0RPMJV&TJ5Q0>([SWH\efBW62,P6a
/#?+d\O&dMY1[CO<7K52F7R<b7A.BO@WaMH-I1EC41fIKdM0.F=V<_L]D6-VgCfd
YNWbS9^Md)(^bbA)5c<g]T\P)W2V,f0g#AHDJ50<fc(H1YP\0;,78ZOcfF2,4)P0
I40M((]Xd3P82U2QfD3U@cH]7ZgKR@>dN;AM;.ZB8VIGK[DL_CO<=DX,JE02BEb6
L.+e:=:X(7&e5@IEG\>AfcJIeGWANQe#OM=&]_KE-UbHM&;ENQG&g;#6A>a_0Cd&
KT4A2WAcKMWX5P20R3DAHTS>-.VN3WNW\A7-V?.L\5]A[DIA(Q>2:JU4VRC9d>eK
N>R9)#8E@MNHD_(6+)?Fc=@2d^1RY<fKD^<aJOKYX]L[ICUH/WeX4d4YO4daXA?)
e6,8?2Z,89f_cb<1OQE\FKV<D4&HRE;0TJM6a<<[@VPK6C6[J_PD>Z53LdZgQf7=
KYed]O>a_-V@>+]d,U5Y3=OJ4X>;:VOg4RZP9aM<T.FZDdUQPE2Z?gR.g0WE2P8N
_LYE)f6ZKQ^H7&2g:EXS2A6KfU(E1W_cIc(A/Cc/2MO(URaZ=X9()de\<S8C81PK
[ccHY.,Z9SL.M/6D2@BNVIDOfGMHZ)R6R,+>O:^=Be=HG(KFVM@5aK0,/L0K]>,3
B+_d^87@;S^e&3FTNg[Z)GQTE06WWG[?A6XgC:7E,&>+feXF9bYD,P:I0)T1^-J5
RLEHK#Y<SL7\A;\[V[=b7:Ma5&bagKcK:I6X:RAd(8edb@O_#O(Ib0B6I[/VT8:T
W;.DUXeKe^=?3O]5H6MD;J\G9OOHVIET=MZ:U7>(Lg>=O)3WJaAAG0?O6KYC#Dd/
7D:VGLF49\g.b0,AdeR[BY@KT24BgaO6W6:=VX#H=+@IE7KOK7-C0<Y9CHG(SO71
]4.<N#+^a70[(2VJ8<QHcgTI3SQSYABO#J4V7N#eIZ:BA#eg]55K<?/&8X+4\:/E
XC5.KGEf6;,JGVP;2[g4e<VfE1VH<B?D:A,faX?NBX..U/8DC0F89BPIcOV1]]Ze
4@W>bFQ&V62A2+Y9+eHSMX3BbM:<g+T0VD-<M[/NDW>=^3LH&Y-XD^IH<aTLN4YK
,^HVS/K5XGX)R3Nb,4^?U7U;_eM@Z#+7P=SAd(H;E-:aKPC?8cP@)5WfHd-8IZ49
2:>H\a.9O/&eJNT\+2gcL/ccJB.6+D<M+6;6X,JB=R-?3e+C1D3I4GFN=Qe]P;,K
gd^ZU)_e6T<HVa@ZDfTZ=WB9eeMIff+X)dXc(CUV0fZV.gZNdRgEgb3\Af(H.:O.
_Z6<.a0#cO6F#PK]3FF7&L62Mg:I^UZEeV^L.O]2-[B0E4d1(?<AbS6)?QLdH2=H
KD64Pd@2+WROg7VN5+<M_BIPOX;;-.EV&,f,PPNE66aSDPT3E^F>RE&a:b@;L732
0>Eb4HA(]T0RU[UfOP0O1KECSL434E[Xb3[M4Fb>O.URLXYK89a5WE(,?Cg3&B)g
_d==B8&WEOHa+2(F/_S9H?1CP#C+;7=EE^Bc38Y^MbF#G[OTcLRf,/E>4A_F6[2D
e9TP8:Lc@d2bST=bDD6G_:O^.7SVd=SFTZeKJ^b9RRJTI\KBQL/867^P\FG#^E?,
]8K/><V<dY[BGae/UCgd+;gP.@<LR=bBO-F(8/)\?S)W)_BRf@S5<XMY2\:D=O\]
,;#QbC1.?(H=05K[23(dE>=eZ(?4K4);E+Eb;AKNSf<8=^1.OS3&B2R=#DCaVXA;
[YD53W_Dg-<M+__I3(IXYS?Wg-f.+VN<(XG<MJHCJI/>\-/\,J4_QdE^f[2R?T4]
e)c?XC]W&1NQe>QZUT1g8>B-[+7BRX)Qb>AbPC]HOES<ObJD)edVSTRND1a;A8XL
3bb)?C=2JN-B.(OQ+C0DH4;C\4+^+(QP3MVeIec)_QFI\L/7DMNIf/[#f4=E?SB9
E\D)Hg2I.V+;NL\EeJK(>))BgP_<KPTYU:&f,+bcb?I0;8>83b8?&/S0\5G&86:6
)4UY=UR2A6\a+DP9O9CR)U.[.Q)/N5E1RRdIKYO<3,O\2H(c+CPb):-5HLa:CKeO
[(1(WeU&;\ZH+f-5TI9AaS[Hb)@()cR]TQ1LFf4]17g^/Rg#@BNfOg\^,4>agZE@
8V\+-8LdN70;CZ<+\+X\Q(aF:Z81<&3,+6/-68M/P(JY6APT#X0#FfD2Q#gB/d<K
6LWAQJ?:RQE3W6TB5IBb,LdJ)/S4JTA2\9_eeUcTfJCPcHCB(=T#ZP:aecOS@;-L
Te-F_6?WV9)VGeV_^HI^Kc&(INf9CQ/QQ1KeR@I>UY)BdCK0f,;f172SOBB5:Gge
0KATSFEYe25.0MU1(M?.U)VJa(fc8Y=MA:\CO5:d44T5567IM(CTJ0MK:8-RI7T7
R4b^L9b\@05GG3:\DaWb_RI9J3+EDgKc&eYQf?c)^M(D+U,=d-D<7OAeGWg?d,#c
a#1]82C\1@D->C<R0:8fE=)7f]BC,J5PC\dET_O4&G^@65=8c/-:K8TB8e5GVR8M
b&QJ#>(L^+:ST:=F]=L/?LID-^Z9#a,R-@CATg_I:#@5/UOAF)G>3OeMK(AHY1ed
g^-;9-eb1+[3@-cV0+/VgP,&RHG1eMcN>fRf8);Ib)>09[^6N_b)LZ(T)IYScP-d
^L0;bB;AY8Vb1ZSe28Bagf#1<3@f+HSE@+3ag<5OBe.M+;O:LA&@=ZD>XQ8)Hd^d
P0@67U879]4.gV0MAAC,O\5N)AC^6Cg1XI6N,.__=EL\cB2b+N1\K(JQ2NHJ^WeS
f(G>/b,[JfIVPQ^MFV^Q70Egb8&?9EA\ECF)6NBLcOXP5AU5S_4)=Lf25Y86bHJR
M(M+GW6g6[689QK?KKcH2Ja4D+>^cbGI(:Z/6J/2W>YH(3ZM&=5D+L:R]NgaNeD6
b&L.\@1_Lc(QgEd1e<[F-5[DW21QA<L;T46dR7:T.86a_68\?#f3=&C5:]?=OB(N
=6Q;@5>5#H@A_13/c5e@fRRB\ZDFMPYX&MJebX(),V\7JD3aTN^T:?@SRW?B&MK?
CYYS7FEL#\d##@/KeN6K&1R9Qb.)?CK,#(<,2\?H9OS)I4X#+b?b.gQK\Q[NA&Q4
\69K]R#MJ:0PVXT0UZ(#@RBf;W>H<6MCEC_UE>\I6Z\^\U>1WfOEFf<;FI<c9MXc
MXf>D5VBZ<=PQ6>a5c9U,?RC)FH?C3((\Ja9D3>A4C.Wd:9Y7[aY?P/4/M5ae18O
(-HHgbR,:7>P-$
`endprotected


`endif // GUARD_SVT_CHI_PROTOCOL_STATUS_SV
