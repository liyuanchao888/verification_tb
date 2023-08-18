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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
W5+OrDIsDZ5a7G26CkRf3Toy4rINvirGtRVcAupI0AUIdH9UwPZPKeFMYb97j8L/
ydEw29dWxcgtbkcRwhxFwx/k+/gGbXPSA27MfONCrbnMR3FEYRJNBAqNUAvWmk87
MxyuvFBYv5xDdIrY5KnAweUyfno7VKPrw3cSBkVtxpM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1931      )
BKnxGcHeyqv3lwizHGQa/8kF/i42SLa9GKUGwMNBbqZvhGbrs+ISUiH1jYcKUnWD
T4M9nWoA/k0XDi/8bCbUgYTWzgOr+86hUe91OZrOygIyN3ks2hYUCRsBMLT9IzVn
LW0nDjL8aw8MQdhXOAf1GEgcDnQFhV89bmSmO5ZISmODqYuKQGTeQPJq4ma8W8R6
Mr1PrPyTLKI5zadSWBzHuJJPnoA8AZSJ/Q77L6UTeZKylNu2TxqyljLtQbnUZxzO
QpsEEGOeVQFcHZPsCoi/nNF3zZ9h0FumKS/hyWfHz7b8IfBgyR1aWUG5GN2DvI4d
yR9FXaXnQgdQhR/zcQ1aBmezmVMSPcMxDT4UH7g9NnefIwyKOdAOp6ASqmqaPedp
Kc7pxBxnHXaoc6ahhonHKp+JWkJUBUHEXzFn5tmZzZ+aPRkWRx86LZL+Vwj0s/VG
QF+/M/6UvFoOCWFMcimdas8RQBrt0uzn9wxMGMqc1DPZazw/py0BZuxepMya2VNf
zaBZibUHqbeQTaFp+MP4j+um80SoiJKZ/43cxESjBeTxiLdC0+x4/CGg0RGcZrHI
XG15inM/rcF1Wj8i/JVog1sx3mjjbXBzvwPQ03LxHH5zf4NjfPrxgp7Asuc2Q3Hm
rX0ROnLqGeahzgHnShMphtYTaIDJB38LdLwelniW0ZR+gijRf1jXUXkbvubL32Fo
As47eHyKV+T7KAaJPsJ5WNc6Wdgec3oYnk4N1d4GNcgUgYJKS7DPSNienuPNv9SH
lLfUgmKPftdUuTx8RzslaaxAuxXdOn+KLk4A6X/eLBDXNr4Hqz6n9U89Gz/rKZlP
W4SgmBsMA4jDBGQX5iGFruZCCgcacOzWLr7UQ4smZ8kdp1aAgu69h6vDPMzOgKPv
Onrwc09kTadQXMagUr0+3SpT8fVzqof6E7HN6r7EFR1tgDzUAQ6lc7V2GkyTMuj0
YfQxMY9mgatkjavBObyfNhc9rix+w+C2O5MvXWRJWpnkFhsSITnupeGZ/LQywsa4
U+3JpiuAV6kKzzjV2xl8O0Z1oO2YFaK1U+5L2aexVesv/7tuhddwncdTOlmQT6UA
UfIrgcPuDfmzoJCk5MNGUJmEMfkBojp7rnQwYXM4KqSZopr7p6UgykytL/ndBYM9
jbszrbc4BqLELPpxu17b91leN0uqeVZjq6lzs27Qu8nscACGOmK2MW0HU6wqNHqW
DHc2nJ33HZS0OAXP73hMKkYEsO6ZJJ+iWVcneX8oRS2ElbTV/3gr6f2s+zXHTjv3
vLGdAo4jKsD/8aBk4iLgOR1YGyAISwupDTs+cdKI6/Oxk2PyAlLaRZiEDC8Pj5lF
RBtYpLh0HJ4EvUeBvrYDr0ySUq2zJ71hGPABjCuuy2ylOKU+pkPd+XPDzCC2rF10
CRfGJuNrNcpXfwByI2VGafSSpCs17VI8Oyf47qwnv6gkLIkk0vVqdI3VHzHzTTAb
XxgGL+eLjQmf48RULLjzw0I2SUT6JDOvcnLJtkgodrhh7I4/738fUQxn7w2s+uJe
mCM5+vdaBORc2s2HYJuZFmfqEe1olovdkrtLVBGUTKOz9KeNsLAgRRPsknvbVGjv
PbmeIRCgo71wkA+x3KL7twvmZpLMp8rfSnNOt6LFd6OFV8RTq15nOBq17D/g88eK
iFVA/XR2H9Hn7rLHEIXV1fj5h6T04kcx4XYgADo/A7XUfHIOrtBbU3SlcU7eHV4a
IJka4vvnuqgjbPdtfIvHbZ//aum3NVYAWEQ4w6Xkf6qoopWv4Hi0wnHeux8GEyD0
opO1FDzEIabj5+76A0KTzTaBlNqHX7WWGd4+gocWPoQMkfIRC7Dzt9KtUwqPa45h
3KFsQKH1Y6eMnUzvp1X6folykIUXmjYKSIji2t3C6swz4qgRGSSDaKapkNX8j65S
V+KHymauWwme9xXo8TjoHei2tH8+5iLp3vzN/b+XpICQ78aAwnGI5dCR/J0LrhOa
I61vbKBsjKvC5st8ub3TTXHx4cn2km5h5C73qsRlvboVsDBlNtAWUh9I1pDjb+XX
rZrrD6zlttNQn//uHAbh0UTDKRuYeofkRwq3riqlyTvmHHCWOvvyfgM+vEB9NWqJ
N1aWHNiq7MuM8T1SlxK/ImfjLDp1w+sjoPvev/ytMAyqZU5+PsD46Vl4qeHscNMo
mwLhf4ZWgblg0GSLbcPsetwOFFc92WJOk8PtYb+HPUi+gIkmnnBVqoTombWJLcN7
BwPNWW7RhsfbZu6cUfBrpA6ovl9v0qvDuuHuqlRHNW2V8JWv7gpVBUh3Y5ZesGyZ
0OlMkTq2DRp27TZDQPboBL5vXNLw374sUBUTO9k/0K1de0AtQ//JeRaXx/eq1TFR
9U7HqSDFog60hKqzdiFYzN1+8z4RA3+ae/MFvPk+YShQ4CPhbWfk/SgbQjHZydDP
UligJxM0H8aPqqWdqRpyUmvThf7nserfR20Qzf4/XD+X1V0j4UpaqbK5BFuXDiyr
aQ17eEZ7xLXe7Y1yHeiAhgCXK0UEWPvrPKsuTtpHVCu4VUu1Nqpj/+N9/xBnGYE2
575LpFu9foqhVibNXEzSDQ==
`pragma protect end_protected
  
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
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Fo6Xipj0aKTOSHw5kvx/v3xITPmoMXuXfrxVB/2Bdy9J0uQiA+wbfSKYM5LUTNe7
zoCMAEn61LIlHPy5OJb6EPOOCzrYovuwkUHhImKotFVyE7M2wCQgcFjioguJ7Edd
JSpFLExIFvOVYegi+zDbMFlKN9Hn4VMsqtwP/ByRimU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2273      )
rMjFFAeDElRwyCy9p2NboIMio2EQ34VZjOxSvh6Av95EdLcAkMNwKqdkA3OXRRrn
xTPQq9SEXibReaCwoAPJOYEbaxxJ6PpuGxLQRVT9/fTbRkYUlyFOxEw+xu8y+9AC
NnwIqzvCY/vwgd0BFyZpdL57muReYZYrf8DlWIlQVG+WqzAP4YCdViXl4y3B15R7
e0gBRi2jstZjlZ6WAS6qD+NkAdcafUDHZWnNn/MNnTwZRaHZZyRL48tjuxwQEStH
WIi5YSyZEFok6LtTIkz1gD+YgF3e8/7A2Ul/KTxyUw9lVLd7pvI4u5JHMoChgG8A
FqHNJ686a2JVq9gGInwEvYVI5pbAydXxNytH9GzLjBrkGUc/fDoOkV4GHMj0BXrP
oKmnLmt+gJJK3MR0VEOzwLFYTUno9AhQOmtBBA0FCg2rLluXRiQ+OtL6OVbiE6G8
iy2/XObhdS6yjobCyCIt3g==
`pragma protect end_protected
  
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mM46d1/3+YOkddLY+lXzFzgP3hV6R0UWxNM1p6oD7dreZpp0ahUmfEwu5njGQrKA
EZQOdRUIyelrzEudbp43q662cgX3284fA/EAhp8VX6yPxbvFIXFAx4i99TPPIfDm
LwQhxTuMbzcddzGDTM7wGUvTmgSDSxOtHNW072fVjiE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4929      )
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
`pragma protect end_protected


`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_node_perf_status)
  `vmm_class_factory(svt_chi_node_perf_status)
`endif

  /** @endcond */

  
  
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U4Dub1jz1KUeAc8TR6M+2l0+cg6dFsHd06XGZzie5uOx3yldHTu6vhRC9g+GrUM8
K4f0AftGAUxOe0d1fn+FNMtz+N2IUJllCMvvSkzCzF96A5vekm2recWtQK3lumMK
1rxdjF0T7kY4khbJepE6H7GU0j2PyYjndR7o0eDk0GU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5619      )
u8h+xxoHMgl6IEj5IumBFAFDU3zwpyTfs6yDpPwG24y9MCQsYkVNM28csxbpQImI
sQ5dneiq8zge3qy63K/jnd0Jk4TZo5xY/ZUAqYoiUrKyUL05yJaz/P4Kv447DCDo
39JzOR+mHpaRbDQ1wzUF63FCWBN6Szaki0EI/eXRh+9M9EFctqi2gKKdxabBha5T
ldsMH9s59czIx4oMwv4WeQy1MyDojinKBst1j3LDsHIf+MTq1SJWKDcZvLIirv2s
htIt3muZuXnfwvzSwUV/NIKyDMFh7H0o2as8lcdsu1M7OJwu9b1NiSla4NOG5OT6
yUPJE0M1ESEd60fKyVknTOaelnn2qxOE1H70EgFhtl3xAyPwTpV8C0uvH9JZyPN/
QJtU+t9UUW9/A6pYXwNDlfgw6FAaNco0DGdfEWv53x/a4wcDIIAcOKLN5q3orogF
+DHvCj/GjXZOXjD4VXyAtI2Q6x/c0h+pD0r1Sg2AsgSHrko9SkXJNNJHPHQxffrz
Ig4IbRIo5rzmokW3efyJ54k2jlESILfHT5/NvmZy+AInJAZWCo8B157PYUDEew30
S32OI9ZX2KVG1pnHxN5EmmtHwb0enT+hrjEoRE8SAuDSEggEw94j+vJP2SvJQjZj
uLnztylGAtgSB1RlXzffl5A0xzD2Sq9UoLkssu+GU/fWgSLISHqmgTdxZ8sZjX1A
7cWRGgDsWTxEfGYegqC5m1Lc7gmCebn7G93UGkW5Bedf6fCidkTFNwCWmydcBjfi
UV74kALZm7L4KNZPAu2Ujdww3kEFxjHWNrIvYkmFI5IvVvKvJAtwgLZTQWut0E2M
uIQjSmRDOmQTVi6qsx/Ytu+Dow+/juV1goGKPXIDdhbc2qO+yE/t1pMOZD8JzIEK
j0dXoGdlbIlGs59ry+jt95KfAjo/71+7Iyq/aM8H3tU=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lTSJ70YfxBopJUKHuTog+aJARgO68V0eG0MS5dE7XpNwOqNEMgKrziGKz2cgp+t8
oaSicvlnaCVFx7aDLdtqViUliUGXHrY8XdrxATHwdAusWukMTlnwKqiDv9y9H1gK
KMk8uVsYWuwAWSlmGgBLWFatKUkf7a0dwdvPGsds2Vg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 57696     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_NODE_PERF_STATUS_SV

  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EL3zbb9NY3MWA9HL3mgpA46kg7uXxXMD0B51tr2sfbmkK0ziDIS0UEDQfSqLQuN4
hNuAhkVHhuxcjgOynX/IQRyNBu/i8cQQI5giXfg1Dpd40QaZtYHbTireCdjI3XLg
ocuIHBaLg5hzx9wUnZreUvttkPXFRphVUTTQjkKErJ0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 57779     )
lthK/soi0Ha1Haj2SpGE/qPVL5wVq0+R4TxMRkRdyeenzNsoDvXof02+6vf6eSl9
Mt53WGCkTUvVeM78hEesjA/pJftyzpYa0OWG3FYk+RIR52TPCjGAGpJhIdQNvEd/
`pragma protect end_protected
