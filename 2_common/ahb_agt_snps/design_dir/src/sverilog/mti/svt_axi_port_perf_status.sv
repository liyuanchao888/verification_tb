
`ifndef GUARD_SVT_AXI_PORT_PERF_STATUS_SV
`define GUARD_SVT_AXI_PORT_PERF_STATUS_SV 

  
// =============================================================================
/**
 *  This is the AXI VIP performance status class used by master, slave(UVM)/groups(VMM).
 *  This provides APIs to query the performance metrics from testbench. 
 */
class svt_axi_port_perf_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  /**
  * Enumerated typed for the the performance metric
  */
  typedef enum {
    AVG_READ_LATENCY = 0, /**<: average latency of the read type transactions */
    MIN_READ_LATENCY  = 1, /**<: minimum latency of the read type transactions */
    MAX_READ_LATENCY = 2, /**<: maximum latency of the read type transactions */
    READ_THROUGHPUT = 3, /**<: throughput of the read data bus */
    AVG_WRITE_LATENCY = 4, /**<: average latency of the write type transactions */
    MIN_WRITE_LATENCY  = 5, /**<: minimum latency of the write type transactions */
    MAX_WRITE_LATENCY = 6, /**<: maximum latency of the write type transactions */
    WRITE_THROUGHPUT = 7 /**<: throughput of the write data bus */ 
  } axi_port_perf_metric_enum;
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  /** Report/log object */
`ifdef SVT_UVM_TECHNOLOGY
  protected uvm_report_object reporter; 
`elsif SVT_OVM_TECHNOLOGY
  protected ovm_report_object reporter; 
`else
  protected vmm_log log;
`endif

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  local svt_axi_common common; 
  /** @cond PRIVATE */
 /** VMM Notify Object passed from the agent */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_axi_port_perf_status)
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
  extern function new(string name = "svt_axi_port_perf_status");
`endif
  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_axi_port_perf_status)
  `svt_data_member_end(svt_axi_port_perf_status)


  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  /**
   * Sets the handle to common used by the agent. This needs to be called by the master/slave agent
   */
  extern function void set_common(svt_axi_common common, `SVT_XVM(report_object) reporter); 
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_port_perf_status.
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
  extern virtual function svt_pattern allocate_pattern();

 // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_port_perf_status)
  `vmm_class_factory(svt_axi_port_perf_status)
`endif

  /** @endcond */

  //---------------------------------------------------------------------------
  /**
   * Computes and returns the performance metric value. The metric is computed 
   * from the beginning of performance recording interval to the time at which this method is called. 
   * Following are the prerequisites to invoke this method:
   * - svt_axi_port_configuration::perf_recording_interval must be set to 0 or -1. 
   * - svt_axi_port_configuration::perf_exclude_inactive_periods_for_throughput must be set to 1.
   * - svt_axi_port_configuration::perf_inactivity_algorithm_type must be set to svt_axi_port_configuration::EXCLUDE_BEGIN_END. 
   * . 
   * @param axi_port_perf_metric The name of the performance metric to be computed
   * @param xacts[$] queue of transactions related to a metric. Supported when axi_port_perf_metric is passed as one of the 
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
   *  - min read latency observed, when axi_port_perf_metric is MIN_READ_LATENCY 
   *  - min write latency observed, when axi_port_perf_metric is MIN_WRITE_LATENCY 
   *  - max read latency observed, when axi_port_perf_metric is MAX_READ_LATENCY 
   *  - max write latency observed, when axi_port_perf_metric is MAX_WRITE_LATENCY 
   *  . 
   * - -1 : xacts will contain all the transaction objects that violated the constraints
   * @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   * - Value passed to this parameter must be in the range [0:(svt_axi_port_perf_status::get_num_performance_monitoring_intervals())-1] <br>
   *   If there is no interval corresponding to the value passed to this argument, an error will be issued.
   * - The default value is 0, corresponding to the first performance recording interval
   * .
   */
  extern function real get_perf_metric(axi_port_perf_metric_enum axi_port_perf_metric, output svt_axi_transaction xacts[$], input int num_xacts_to_be_matched=0, input int perf_rec_interval = 0);

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
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is started as a result of this method invocation
   * - Returns 0 if performance monitoring is not started as a result of this method invocation
   * .
   */
  extern function bit start_performance_monitoring();

  /**
   * When invoked, performance monitoring will be stopped if already the monitoring is in progress.
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is stopped as a result of this method invocation
   * - Returns 0 if performance monitoring is not stopped as a result of this method invocation
   * - If the performance monitoring is in progress, that is the start_performance_monitoring() is invoked,
   *   but the stop_performance_monitoring() is not invoked, the port monitor invokes this method
   *   during extract phase.
   * .
   */
  extern function bit stop_performance_monitoring();

  /**
   * When invoked, indicates if the performance monitoring is in progress or not.
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is in progress when this method is invoked
   * - Returns 0 if performance monitoring is not in progress when this method is invoked
   * .
   */
  extern function bit is_performance_monitoring_in_progress();

  /** Returns the number of performance monitoring intervals, including any in progress monitoring interval */
  extern function int get_num_performance_monitoring_intervals();

  /** Indicates number of completed performance monitoring intervals */
  extern function int get_num_completed_performance_monitoring_intervals();

  /** Indicates if a given performance recording interval is complete or not 
   *  @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   */
  extern function bit is_performance_monitoring_interval_complete(int unsigned perf_rec_interval);
  

 // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DhNJwQDxGr/aq5w/rQ4XDpO0G72jkVFjwZqsnT9SaHXQxmpU/CZ9i8M/WJDqNBUY
46nYCdudOJ6lt95RR3A7D4RP/JAgu+hebV0XKKZ4Y7k0k2y4TDrgBzlc4HabI4Lf
esReSdSYijSZrLYbhbaTYcoXHrxZcFWuiFSD6D6HJj4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 505       )
RSi6L97qrqEmZ+ciECoIPeID3LUvt+U7D+vZ8eM36HvDyziOIFOdrj6qzm2qAZqh
hTamZ3w0czjS6n23Ujes8X92XFhWQgKP2ozU+ueQr0EQjTGr70KJ5I2dUy6lQDfn
nJWvTxGE2isGEllwRrrdgG6So8jv+bZzzl8qZWxvW6lULpF8e7+r48c0dExduIHP
MzKOraoKC5ZSZpvZpuYsUFDax9ceIChx6baRDlPaqblxNGgWi4SBTM4cUKSd0DTu
amDH7SaFZRIaW5eMWUPYn43P/HU7BZKjAIPsVAv+p/cxNq2Zx3PoVqbUIHOzOjFj
zGxrS4xx50QFgJ8pmTUyPmQSrwlDxdLO4ht9zhmSSB6UFHMmv+kqx2VeyuB4TswY
G/+WSg2FnDMoGpMANpr7gWR+pqHhpLGeiw7yQoKy53FYg26/nTzc5/ylnl1AFMJD
+HWzTO87BN28/aO2jHy/i2gizPkn8sj0Tahv1+UJklFgblJEx4VrAxwDtcZQ/l2g
oLdP6zHlRfQrOUg9TdecRHKYu+rSzhish9VXHK2NHiOwA7HI+8aBHwXfPPf6sKH5
sJJAESSSlEKS05UGXcNZpBL8aKqG/vPYbFFrWC9CAvvz+chg6/VKXy0TjLfMmmou
krNogBd1p4JmVSM+vAs+NuF8bFVZx/psJkDjE5p4gQ4=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aALjW59J2qYFVLKDyDzUeMb/nsBtM6wS7sfhuJy9edxCMuwc4a5c1J5J4JYcnIpJ
m4fS6TUCz9/BkbZ2GX4Sjw5ZLoiQXbQkw69hemZY0YYd9bvLFt2VbUl43+290wRW
KIAt7TVNfRyejVqlQF/rlhUQx+Lb0PbINZmRJIHBUnY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35302     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AXI_PORT_PERF_STATUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FEGCFANryBvqKlFzEtKM1wD6OWhoAOA13Kxq69N8Zo+RapMYqDXYsZXDBAyqLowo
cJ0nM3uxRe7RbK1MDIZoZI1puZVCZCkuWq1pNRq87MqO4dp97QnTRg8UAJf8ksPm
xAa30r+HaFeSj5Qsl7+zCsGq3BB7HZWxGS5bZYQwu8w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35385     )
F/unrscXnnAjVm8e8EPXqgba7QR2BLaILGEjvuNU8xy7iBVi/AcY0UhyD97oq/U8
p8qJiYiX8fEVdy6gOjE/zTKGB1Fl8etLnpDAFxqt8ZW0pSeUo41PlPGA77QSvghq
`pragma protect end_protected
