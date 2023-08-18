//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_NODE_PERF_STATUS_SV
`define GUARD_SVT_CHI_NODE_PERF_STATUS_SV 

// =============================================================================
/**
 *  This is the CHI VIP performance status class used by RN, SN agents.
 *  This provides APIs to query the performance metrics from testbench. 
 */

class svt_chi_node_perf_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  /**
   * Enumerated type for the the performance metric. <br>
   * Following are the definitions of transaction types as referred by the enumerated values:
   * - Read type transactions:
   *   - ReadNoSnp
   *   - ReadOnce
   *   - ReadShared
   *   - ReadClean
   *   - ReadUnique
   *   .
   * - Write type transactions: 
   *   - WriteNoSnpFull, WriteNoSnpPtl
   *   - WriteUniqueFull, WriteUniquePtl
   *   - WriteBackFull, WriteBackPtl
   *   - WriteCleanFull, WriteCleanPtl
   *   - WriteEvictFull
   *   .
   * .
   * Following are the definitions of read data virtual channel:
   * - For RN: RXDAT VC
   * - For SN: TXDAT VC
   * .
   * Following are the definitions of write data virtual channel:
   * - For RN: TXDAT VC
   * - For SN: RXDAT VC
   * .
   */
  typedef enum {
                AVG_READ_LATENCY     = 0,        /**<: average latency of the read type transactions */
                MIN_READ_LATENCY     = 1,        /**<: minimum latency of the read type transactions */
                MAX_READ_LATENCY     = 2,        /**<: maximum latency of the read type transactions */
                READ_THROUGHPUT      = 3,        /**<: throughput of the read data virtual channel */
                AVG_WRITE_LATENCY    = 4,        /**<: average latency of the write type transactions */
                MIN_WRITE_LATENCY    = 5,        /**<: minimum latency of the write type transactions */
                MAX_WRITE_LATENCY    = 6,        /**<: maximum latency of the write type transactions */
                WRITE_THROUGHPUT     = 7         /**<: throughput of the write data virtual channel */ 
                } chi_node_perf_metric_enum;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fD7tFBClXhQG3CNDru5By0jv5j3UhBO+JfcSYyTjxyXLoBm9O/LHkUr+8FHtVuph
rLld/ygIS3dCBkrB4z6nYLGiXNaEc1GrssLt13kuegHq4nnPkCnYGx6vo/DDaOiF
KxDqYhjYWkZiVI356fUHEFDDfpss0t/bFaiJCQZGUMmUx7Rp5Zh/AQ==
//pragma protect end_key_block
//pragma protect digest_block
rLodLHIObZLG7Wrps6YHveaTGm4=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
4iBycf2p8xzLkGsN9Ae2N1xioZc=
//pragma protect end_digest_block
//pragma protect end_protected
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------
  
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_node_perf_status)
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
  extern function new(string name = "svt_chi_node_perf_status", `SVT_XVM(report_object) reporter = null);
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  /** @endcond */

  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_node_perf_status)
  `svt_data_member_end(svt_chi_node_perf_status)

  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;
`else       
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;
`endif // !`ifdef SVT_VMM_TECHNOLOGY
  /** @endcond */
  
  // ---------------------------------------------------------------------------
  // APIs for querying the performance metrics from testbench 
  // ---------------------------------------------------------------------------
  /**
   * - Computes and returns the value corresponding the given performance metric. 
   * - The metric is computed from the beginning of performance recording interval to the time at which this method is called. 
   * - Following are the prerequisites to invoke this method:
   *   - svt_chi_node_configuration::perf_recording_interval must be set to either 0 or -1. 
   *   - svt_chi_node_configuration::perf_exclude_inactive_periods_for_throughput must be set to 1.
   *   - svt_chi_node_configuration::perf_inactivity_algorithm_type must be set to svt_chi_node_configuration::EXCLUDE_BEGIN_END. 
   *   .
   * .
   * @param chi_node_perf_metric The name of the performance metric to be computed
   * @param xact[$] queue of transactions related to the performance metric to be computed. Supported when chi_node_perf_metric is passed as one of the 
   * following:
   * - MAX_READ_LATENCY 
   * - MIN_READ_LATENCY 
   * - MAX_WRITE_LATENCY 
   * - MIN_WRITE_LATENCY 
   * .
   * The number of elements returned in the queue depends on the input argument num_xacts_to_be_matched. 
   * @param num_xacts_to_be_matched number of elements to be returned in the output queue xacts. 
   * -  0 : empty xacts 
   * -  1 : returns the transaction object that corresponds to: 
   *    - min read latency observed, when chi_node_perf_metric is MIN_READ_LATENCY 
   *    - min write latency observed, when chi_node_perf_metric is MIN_WRITE_LATENCY 
   *    - max read latency observed, when chi_node_perf_metric is MAX_READ_LATENCY 
   *    - max write latency observed, when chi_node_perf_metric is MAX_WRITE_LATENCY 
   *    . 
   * - -1 : xacts will contain all the transaction objects that violated the constraints
   * .
   * 
   * @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   * - Value passed to this parameter must be in the range [0:(svt_chi_node_perf_status::get_num_performance_monitoring_intervals())-1] <br>
   *   If there is no interval corresponding to the value passed to this argument, an error will be issued.
   * - The default value is 0, corresponding to the first performance recording interval
   * .
   */
  extern function real get_perf_metric(chi_node_perf_metric_enum chi_node_perf_metric, output svt_chi_transaction xact[$], input int num_xacts_to_be_matched=0, input int perf_rec_interval = 0);

  /**
   * Returns the time unit for latency metrics 
   */
  extern function string get_unit_for_latency_metrics();

  /**
   * Returns the time unit for throughput metrics 
   */
  extern function string get_unit_for_throughput_metrics();

  /**
   * When invoked, performance monitoring will be started if already the monitoring is not in progress.
   * - This is applicable only when the svt_chi_node_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is started as a result of this method invocation
   * - Returns 0 if performance monitoring is not started as a result of this method invocation
   * .
   */
  extern function bit start_performance_monitoring();

  /**
   * When invoked, performance monitoring will be stopped if already the monitoring is in progress.
   * - This is applicable only when the svt_chi_node_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is stopped as a result of this method invocation
   * - Returns 0 if performance monitoring is not stopped as a result of this method invocation
   * - If the performance monitoring is in progress, that is the start_performance_monitoring() is invoked,
   *   but the stop_performance_monitoring() is not invoked, the Node protocol monitor invokes stop_performance_monitoring()
   *   during extract phase.
   * .
   */
  extern function bit stop_performance_monitoring();

  /**
   * When invoked, indicates if the performance monitoring is in progress or not.
   * - This is applicable only when the svt_chi_node_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is in progress when this method is invoked
   * - Returns 0 if performance monitoring is not in progress when this method is invoked
   * - If the performance monitoring is in progress, that is the start_performance_monitoring() is invoked,
   *   but the stop_performance_monitoring() is not invoked, the Node protocol monitor invokes stop_performance_monitoring()
   *   during extract phase.
   * .
   */
  extern function bit is_performance_monitoring_in_progress();

  /** Returns the number of performance monitoring intervals, including any in progress monitoring interval */
  extern function int get_num_performance_monitoring_intervals();
  
  /** Returns the number of completed performance monitoring intervals */
  extern function int get_num_completed_performance_monitoring_intervals();

  /** Indicates if a given performance recording interval is complete or not 
   *  @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   */
  extern function bit is_performance_monitoring_interval_complete(int unsigned perf_rec_interval);
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
quBeOJ3p4uyMQwbqrj+CTOiIwI4S7fUGPcwevW5HppXWHXMMkTyCdQhT3O7rj4Hk
B6MVf2pMbs0iDlGnOm+yOsyuYjkJVQ0ivFLnf58VUTNdsmEofPmxPOtu0zmBer4I
Wq8RuuZTcqxFd94aZd2RwooaTfquF24en5mQYhjeR00lj9RkWof+vg==
//pragma protect end_key_block
//pragma protect digest_block
Ik9E+Pl7GhCsw0dfNtYNVFP3Uvg=
//pragma protect end_digest_block
//pragma protect data_block
cApFtAlFnnKfo0D9NVXiZIlT2VnycJ/jEUV0/IrWi/+4gi+Ivob/NSU/OYqZqid5
3feMgPhSyCxMNZj6ZX7vNQeuiSWQSdn7VjNlmqKtEvRLUD1osN1X6Tpe1tFE5Jx0
npOludaMXo2HSKlcqNZKfUPfeGfLu0MFkBooUnhNHcz1VXczbMOuH3giNEMNweI3
rW8itdVhPjFz/iN0RdEse63dcm+euKZJJ8qvpZ+0bn5FEzLiDd4SoCn70oMN8SX+
kHq6E3voJpZQVIrvYuIk5MXEcVhp7xQtPsSt4PFi4kYkSTL7TxnTvF+0XogD62QA
6ezXHrXTMbTmBEy0/RpTHoxwEC51j6Dfx4RAPim4+rWqaZBFYQcmQ9adupj7U+23
JD2dzXzg0O9tk5/afO8XahpscgOkyCxp5YfJ3yLcQraK0tto+aJw8VB/YOk86YbD
EJhxQ464iiwk17rC2cdFQ0ZiXPvfOrJ74V5P1YRjwxBvU+lTWASmkOw6AIO6C3n+
kAIteU/cLXHrapz/JF+nUeyb+tLcIuaLVzg5JzCpY6WSCqEzYu4xKQnF+pPT9q71
PVnBB+l070TmBqUejLJGOQk1x3HtFgINqiSabqBkCCpBNXdo+G3bcC9bx+8shRKz
r5mqsBGjn+xxaBXrBWpDVqrOd7uSGR3nbkRg/N4+Is0=
//pragma protect end_data_block
//pragma protect digest_block
WBnNMvdRWlbd/+9tLGl6zaxdQ9Y=
//pragma protect end_digest_block
//pragma protect end_protected
  
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_node_perf_status.
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DbLYdlx/DXrpaVJ8DDt9Y4OSuIQKmdC4hLkPS2dQs3Vdf1tWsMY8cYFcuu3Y7SiZ
8N3VggCRXEA1FlkVqtc8NEY30uPH3ono4LBUJaooULyp/wcTYoHm4VFob1UCfaBq
AGzXIHGaSVQbjzTE57BPeq+iuWCJHA5lgdWZ+2efNJl8fIYiHQ/+Sg==
//pragma protect end_key_block
//pragma protect digest_block
biQyQwutFqnK0KsNnFG2kcIpN+s=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
PCFeTOnqL/8twrDhftAp53Bml+A=
//pragma protect end_digest_block
//pragma protect end_protected


`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_node_perf_status)
  `vmm_class_factory(svt_chi_node_perf_status)
`endif

  /** @endcond */

  
  
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fOAzwmHV4sEDR1cC9t9DVnSjrc7iE7HuG0D4VWAmuEp29kGaC/+DxZqTxQ/+L2mn
M6ySzAXMAZz095Q2asKfy9bKl4LNmd2v6DxXhSukAoOSudLFmi9Z3bk0heElsBa8
8VEZpj4lMrrHaUMAJ92bjVCbhvPGlEhypKt47Wrz/sk2qoCqsCRr/w==
//pragma protect end_key_block
//pragma protect digest_block
VeQze66AuJ7XiMOue2Gzwa0Ymks=
//pragma protect end_digest_block
//pragma protect data_block
5mWMr7yzPZLeAh2O5jQoQINEIx22cUMbS3i1IQy7hFkjmzUVk95qdM6seGA0evvb
ZkKnbPe8fCsTi710V6YX70lAejHGUQ5IHgLCdR+1qFTlvfNJmZfJmCoXO/4f18o9
jn7yOfyIC5MMRcV5uu3ZeKj5wbmyllw8SOekBRmxvVumqOsc3kJATCm39zIvKERP
HSwSS/pMLvEBZ17qVks+SUJLGjl1FWV7mQ4NAzRVs1WaM42h418SgqO5L7u/9U7V
n6OJmhm69r4vUMhBbns7x+sqPF/FsjR2Wu7ztkjkWHuiF8OOy+HDwwesE97K95CM
GN/gzjloIGZWvY+l2DVJXL7byrrEjLY/n3HO7CE/1XdukzHSAe2dg/Guqq4NMQcZ
5DC10JfRk2cr/DeGs9kJRum+BkY1qtzvcLEjzSMCiOpWZrRtWfM6FqRVdwmL0aHw
F2+p2CINVGhOd6lhEy3oe5CviE53hXFubXjgdEsJZh6FyCLeNUcRJKY4DQ+7J/+X
meobfDIXIuLp4FcUSOb81eFOxUFBk/qJCsPt+DoHNHaOTLeyj+x7CEO2KWTi6QbC
jCCF3Q/qk4jYkMKzJDhsq90jARDPWFoUFhIp1dP8+/cUgfZRZ3lIrHFVqEQKsN3I
/FnB8F3fzFAsbBqYDLQ8QnIVT9fFXs1WSHiw2+gIKvHPMyWWVtU0hErMuR76ZtNp
S2ORH5xIyFshJAHcCiJ2K56VskZrEId0yVv702Yt4CPJ0kaOxfFXGNJs7dN8DT1b
l3da4mh4WQxVF4XNYnXTDFco+NGrCcrZpCSW4gIpno9mUqypvaSvKW7X7RvRJ4mI
fYP2W5uYQ6CP3aSqDqV1QIo4tZ7GLs9A2WtWwQkhc0afz1Zd3wlACxFnhsLyd5iF
7Tui8/p+q60pi4jXyaX2qqLJOkuhYcYd3nqbQb+Eogp8Y+wFrzfSNqgsayR2dwzX
5RiVqSuMWB/3y1X+dF0YqNq9tSE4EeATpkdAFCvFrGPjYl5q5RGwYH8gsDl/V5kX
/CYBUjuuK/oJINcW81Y1EYk+Al/vT8BciMTp7u8jMNi4pD8fP3fjYH24ToyD2OEE
IZWHZ3qcS2xrr8qb79hXQAxKLcjMIpSWSmbfrkQVutBwPmIYju2vsB8+X6a/cuR7

//pragma protect end_data_block
//pragma protect digest_block
wEMaIth/rUo4y4fAIRPbrWEtvFU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GPnbZO4KHOBZ+4fpqcNYlfwnvVD/d6mxLCm+djQK32m626rVoxA8V5oKcfwQm8RO
drgj0uOoffznNoheylFFtgKxUBagYk/3I0x06SCNTNNndCchR/Ln19nKRn+Wwclw
AJuS7coTZmaZ02JOkVe+E/wQQVW76nL7Dqyx728nprtZN0z0WS1KAQ==
//pragma protect end_key_block
//pragma protect digest_block
fjYEDJRYR5R2OkLV9Xw5mtNvqmI=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
bqyVYQN4srprKz54OY01QMN3Tvc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_NODE_PERF_STATUS_SV

  
