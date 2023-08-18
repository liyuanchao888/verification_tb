
`ifndef SVT_AXI_IC_SLAVE_TRANSACTION_SV
`define SVT_AXI_IC_SLAVE_TRANSACTION_SV

/**
 * svt_axi_ic_slave_transaction class is used by the slave ports of the
 * Interconnect component, to represent the transaction received on the
 * Interconnect Slave port from a master component. At the end of each
 * transaction on the Interconnect Slave port, the port monitor within the
 * Interconnect Slave port provides object of type svt_axi_ic_slave_transaction
 * from its analysis port, in active and passive mode.
 */
class svt_axi_ic_slave_transaction extends svt_axi_slave_transaction;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_ic_slave_transaction)
    local static vmm_log shared_log = new("svt_axi_ic_slave_transaction", "class" );
  `endif

  /** 
    * When the #axi_interface_type is AXI_ACE, svt_axi_ic_slave_transaction
    * represents a coherent transaction received from the master. In this case,
    * if snoop transactions were sent to other masters corresponding to this
    * coherent transaction, #assoc_snoop_xacts stores the associated snoop
    * transactions.
    */
  svt_axi_snoop_transaction assoc_snoop_xacts[$];

  /** 
    * If the transaction received on a interconnect slave port (from a external
    * master component) is routed to a external slave component,
    * #assoc_slave_port_xact stores the corresponding transaction sent to the
    * external slave.
    */
  svt_axi_master_transaction assoc_slave_port_xact;

/** @cond PRIVATE */
  /**
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating master. This field
    * indicates the parent transaction from which this transaction was split.
    */
  svt_axi_transaction assoc_parent_xact;

  /** 
    * If set transactions will be forcefully routed to a slave, 
    * irrespective of transaction type.
    */
  bit mainmemory_data_exception = 0;

  /**
    * If set, one port which should be snooped will not be snooped
    */
  bit snoop_routing_exception = 0;

  /**
    * If set, the response to a DVM operation/DVM Sync is sent
    * before a response is received from all snooped ports
    */
  bit dvm_response_timing_exception = 0;

  /** 
    * Indicates that a write to memory occured after the interconnect
    * performed a speculative read to memory on reception of a
    * transaction from a master. This means that the contents of memory
    * will have changed after the read was issued to memory and so the
    * interconnect will have to read the contents of memory again
    */
  bit is_memory_update_hazard = 0;

  // Triggered when the assoc_snoop_xacts queue is populated.
  event snoop_queue_populated;
/** @endcond */

/**
Utility methods definition of svt_axi_ic_slave_transaction class
*/



  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_ic_slave_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_ic_slave_transaction)
    `svt_field_queue_object(assoc_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_slave_port_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_parent_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int   (mainmemory_data_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (snoop_routing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (dvm_response_timing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (is_memory_update_hazard,`SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_axi_ic_slave_transaction)
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_ic_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_ic_slave_transaction);
`endif

  constraint reasonable_ic_slave_response {
    if(port_cfg.sys_cfg != null &&
       port_cfg.sys_cfg.posted_write_xacts_enable == 1) {
       bresp != DECERR;
       bresp != SLVERR;
    }
  }
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TOUAUlDmHmXOgmWk3E4sATdzRnIIUL+TmPr4nVbKLLrLS22jRlSItcgBrBSI2F7K
ABhpZM4VBnWYpOo+g0nKDDHWsoVAoFxdFDb2ikFwvPWf9A5DYGo84F2+05f7Im00
8qsz3xps8mwy37GH6LkW/zlrsI1l7z7UH/y3tnEK6Vc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 812       )
Ruri9z2w6HWw2o7AFGhl5f54IeH5rcsqCk+t1lj87VWNyMrlVLM8qLrkHtXxM3/U
bG73mJc6DDAoO3OBFY+LzfRPYvcFWggcTpFZg2TRTpeJ6siJOhCNifxkfJN2V5Gd
g1lYBTkr1wGzxgk1G0FO1WBdRL01pbKxpOEa1ykWdhIyTpAqoBe4/q/ZO2iNdczO
lyD/tY0FWWqohK4hkkDr8Vp6CBCVLFzFqqq7zWxSuWisfqfcW3Ps/4hEDRiYHO0K
5bq8rlIirwBGtiIxEF6KeU+ZG59GQiTCtb1FFm7+w0s78SOC9KCCM2yX3Ap2H+Ap
Nq9juZ0RXmcbwk9K/3IOwqfEViz95pBoK0+yFGIIpFjjAAyupIhoNeA3GHy/tnl/
zNsjt+HaKwiIgi6OwlJteY2oAhIQqJH+eL+B5tsKOKUnrC6s346Ax1jCMIaSlHpt
iDwYUODwZ4xf834VeGdC9nttweiS6pbwaHg5HEBD0D9oDOSfC525/w5KRoZHMx3Y
oeMBlvEs6yZ56HdYcPQVMJKWWyUQ7MaHAo1FbEEb44EuHwvXZC8uJ0T5cKFwi4Cx
ilihxvOS7/EKCKYQ65eNJFx3hqMNZzXoWjFEsC0MdldWKSO8+KHcHK6XUaL9dcHe
MzauY+UkPQABzr4YJAZyO0YmEgo2fzsd22tZ57hMauVIs/pDVdBZ1wo49W3+ul6t
cUoNmh7sdXKqtD/pBj4u2vYDkiRzWyggnG5z7rmRCd2wNZn4hdJr21KCeGQoNMIn
oHkWmifM/D1IQQLNoHVmustu7WhzNjMZNXj6Cm96+htKtu/0FFMD5I1og828zF6q
G+bn3Q63FB0Nh2kFPN5lzVfu+in9RJiTjQq+h9wrMCQdDU5QE8E1CftX5/fm3Vgw
EWVIcEWA4lfJsijjRIwQ8JW10thHZN/8u92xNZuLxOBz3UMTqKpR5OfzkGJGrYOJ
RFVCjmHnkQmMIptcy/hZvghH7ow133bn4csVqn3LeeVzQ0SR0STuJ7ZYjtXALQJC
CeyGd0oZPAmTL3MJGmLZ3Dl8UMdM00zOT1HajgENP12oC0V00fy/QdT8MISYgqNw
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OgYKfe4CGNzFvoTdvykrtXzbGRl2sYWybmQcPkD/dc7P0cGe4oRl9xJdZM7RDp6D
YWJWSAwGE45ZFGNYlCpnyeoTmpoEr/Wg+q/Vl0dSE3lTvKgl21TuaOqMX/ZjuKjn
lVoapQntCsmpOYyyLOjevV7O16rrPqM1PhDmYoNlSLI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1521      )
eOvZ8D1uO+K2kA2nW8JuRBAOi5myv5NEkso9hFGvLNa7Mz2fdV0CVGRK1g6QQW9v
kxao2gV3NJPeZuz8V6uNUTlwQBeOUaMnQED0rf2uCnTjKE8z+3TIrsRQnh+GsF91
k/f9Wx/GFAc2OpThKFkWIfV/V45YcWlyl96Cfi6OXO/cGFe77ifo5dKeKuVLD1IA
e0/48WyboGvb2AoplRWKCBPjR8k1zzRTpfdUHW1Mng0X8rqcYAjHc5ydX2PyKViB
0SBPvffWZqXqKjkz4OH24ssyGObxYR260uNver5i7fI/FtAKxa9pi87hF/PVtrsS
7QxtgMrcaAU53ZTvisBfuZXAtkATbryAiL+xj5az1ZmFFeABdcCPRBqyybiFkF+L
lLCrhbLPlQ3yYZ1IYYUjRjkBv8ydk4/GcYi93cXTguuffAa2bQQIcSDsTYvgN1K+
oDInxl4NmP+9AfRYuKTFqhiWccn8PCx8Vr6P3DmNbj78W7QfLgN5nFQLy14hGxJF
UYcBYgSs6TXIHWmRL9Ll/mWh433hIbGXg7CvzwLieiBfSEnYnS47KB3jnSGMLuHp
g3qvoLAllR7rvtSwMo9UHi2cWDQSR3EXJpdTQfDmpHjzCcrizZksw1oBJW6LZw49
HuKMHbVGXzBfNe9awsaev/XqVC+RTzqEY+pSJITTtzzFtVWBho3VKBUAvcmUVqr4
7pevAOfWMWrlOGwXYw1Ts2lAlSXuudqhGRgVY9KafePrezf6Q+b5MGhRam8CdI4S
WeVea/oJ3vUcjEBobEzo3VyMmiNX+OJOg5N7q8UQdwZuzKrjcEYktcOvx70OjChU
hwybgojYAjc5/iM/2QV+A6WbxErTFB1WSoMLxWkHVh8r7fhPbBXVtG4NAs0uyz0B
FLAp6iSmeGq1VBfTqynpNFjhqZy6l1TUEBeIFPG4hMu7O5Fwa6j8hzElpQ5ICr0z
`pragma protect end_protected

`endif // SVT_AXI_IC_SLAVE_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B0MZKb4brhevSU1I2UKMqSlVvpFGwaVAQ+8kd5xsIN1BoLC0VgPPR1NXG5KA6+Pa
JONhMtqZCyZ0c36faY9kCUZ6D3cPDXgbjUcG8w3H1fxaFic1WNvT0AUkZuPeErX6
cS9BnnRF1jik+hoLQk20CU7vF2T70NzDJN90m9LE9+I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1604      )
3OS9Q5WV7tkEoTd4FJhEjm/CEXf5B+Ux8w/Talz/IHMEjs+puIXRSrtPHfo3iOtH
jo7TtJnf74g/I0CmPh5eT30cp5Ij65XZNyNcg78PADeQNbwua3NhLfn5k4SuvxAl
`pragma protect end_protected
