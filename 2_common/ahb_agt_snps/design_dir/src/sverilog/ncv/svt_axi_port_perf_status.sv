
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
U7Dq+6tthEjSwDBMnh+mFiXPcAZBfNehEuA74Rn19M0Lm1Q0549lLQZGuTEQGn2T
FllTNJG+VVn7qOAepZmDF8wQ3tOrvvkuVjD01HIU+bFAtEJyOgUr5jhOVQ2Bhd00
ouEpp6rVWVfcf2+Oz1qcfOtz8BB7mkJOuMduUNqp6TC/Yz/Ezx7whQ==
//pragma protect end_key_block
//pragma protect digest_block
6BFBhlNzGu4yOSZRAobyFlKbzys=
//pragma protect end_digest_block
//pragma protect data_block
sRIY5Ky5/Cv/cYkfHdGtNLHuLSiFQ5vgWndaa6o7J91QLuMpJzazOkcXPBZl02ow
EgPCtMXspouq2RXhfAzKwV77NFcj0+nwKZPAAmkAUZOYnAVYcNlJifiNbGu8a1BJ
avEOaFTu0D9cjuJwaVqY+YCPb6fOLRCD+DMmoL1xE5v1MyPQHe05cg9JQG0VLsek
Snd+i0xxPsDhHvqKADBR7aaaLof1qIKaFwrl9PJ5aCx8tLfE1mryoLiIEBlEoCvN
GXOFN/uKXtXUHQ6CJYKALXAgLZXTIq0lOmYpF3tM9KdzfTIcuw2UYETtGH3ZOZF8
pRimEdlRuybnndrtBb1S/gtd14NRaeIJpiwlVGRao1Q1NLWB1+nxr5HlXat/sNg2
mH9DosK2WH2wTLxB8jZ59+m3ui9anNBjxzeoVWKyZMLhneQAmTinqO+ArThJQTlT
Zk3A2YO6EN3j4enQ58ctmL9MZleAE3qAyALxsoeotff8OCbhP1zLHY7WNGKrCOWJ
2/SMLb856Ovp40CD9/VDlN8iQMj/zJKBQMF3LikSPw0BmP0r1IC7pLj3yDLJ/y5G
NSIi9zI2gM5RUEZCqA9YfdaC8Wht5onR+eTRkP0beW27u06lB8dZuMa6PvjTh5E1
h8jQwVFNrEJKxthIIRYRIwmoUW93qlQeo4cOgDJkVm57P5FunhwZ6ipPdeAeV3FS
dX4x/+ImoiBMO0UyYNJELrFq3Y6ijf0DkQDRLvqoQ4bgLoJ1YAVJ/P8h5/Yt7Qi9
+dPkgCg0rNkZINt9sSrCDjdsgHSY8eQqeMdXE9Wwp5QDSSSdOjITwjL/3xuywY4j
9jF0+Y59lTqtar3fQp4OoCDGwzdP80D2MW9+KvDAEvLK9tRqODjA7WJCN1icIlIm

//pragma protect end_data_block
//pragma protect digest_block
WFYt4mdx28Vm/19DCo3WwLPA/c0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7sYYQe+c8Em8I7VQp9tXK5vFcozcQ2Oud1/1rlqpecvBJAZUjDtXoVfv7rLxSVvJ
Mx03/eWulAvC+UOIFPJLve4OrSAV4Mxw6Ap1X4ppv4XIfwb5oLkyuQYSedv0mraZ
cy4SCXzqOzqKKEODHSNuMqTN69rAaxbaBp40RglJFdGukrY36Sl0xw==
//pragma protect end_key_block
//pragma protect digest_block
DHGJESBqlUBII5AU46ilrdTb03Q=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
U6PWFqb2g8URox51UrQvvU6QUvs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_PORT_PERF_STATUS_SV
