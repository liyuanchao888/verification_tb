
`ifndef GUARD_SVT_AXI_SERVICE_SV
`define GUARD_SVT_AXI_SERVICE_SV 

// =============================================================================
/**
 * This class is a service transaction class used for monitoring low power 
 * interface. It captures the information on low power signals during the 
 * low power entry and low power exit handshakes 
 */
class svt_axi_service extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_service)
`endif

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * Enum to represent low power handshake type
   */
  typedef enum  {
    POWER_DOWN=0, 
    POWER_UP=1 
  } lp_handshake_type_enum;

  /**
   * Enum to represent low power handshake initiator
   */
  typedef enum  {
    PERIPHERAL=0, 
    CLOCK_CONTROLLER=1
  } lp_initiator_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Type of low power handshake */
  rand lp_handshake_type_enum lp_handshake_type;

  /** initiator of low power handshake */
  rand lp_initiator_type_enum lp_initiator;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CACTIVE and assertion of CSYSREQ 
    */
  real lp_entry_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CSYSREQ and assertion of CSYSACK 
    */
  real lp_entry_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CACTIVE and deassertion of CSYSREQ 
    */
  real lp_exit_prp_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_prp_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_req_active_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_ctrl_req_ack_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_active_ack_delay;
  
  /** 
    * This variable stores the timestamp information when 
    * CACTIVE has changed. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CACTIVE has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CACTIVE has gone high.
    */ 
  real lp_active_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSREQ is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSREQ has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSREQ has gone high. 
    */ 
  real lp_req_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSACK is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSACK has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSACK has gone high.
    */ 
  real lp_ack_assertion_time;

 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_service", "class" );
`endif

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null);
`endif
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifndef INCA
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else

  //----------------------------------------------------------------------------
  /**
   * Extend the svt_post_do_all_do_copy method to cleanup the exception xact pointers.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function void svt_post_do_all_do_copy(`SVT_DATA_BASE_TYPE to);
`endif
`endif
  

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_axi_service)
    `svt_field_real      (lp_entry_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_entry_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_active_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_active_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_handshake_type_enum, lp_handshake_type,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_initiator_type_enum, lp_initiator,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_active_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_req_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_ack_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
 
  // ****************************************************************************

  `svt_data_member_end(svt_axi_service)
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_service)
`endif

endclass

/**
Transaction Class constructor definition
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lQKiE0dGMUvEmqV1rYWHAQVQsWX3oRAqUHh+gRY0RZR4tT5jNZkiAZR4gB3FWpHS
rxclfcFxIqTBA7MGFDrBSu5vCSdV0X8f7GtYMQ5SdY9O7vmPA8IAcBUqHyZnyMBf
62sPHkZtnFfxScJJVouTnvt2DTM7Q3HpZM6OXZp8dg8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 545       )
PNGEGZJHrEGNX7F06+KAt56hg6KhVDqhMqN7o6yPnw68QLCMUHwYmxbwLA3eLRrJ
oyi72zVwzKecr27fYtaUdOmrSjq6uoRq2PY6aKKR8SJEGIbkaB1eFEjeGrHP7sfy
QvonOiHAZcwZnjnPb1dPu1MxJzKJPF1g+/3hscvSVeqjOVKD82oXyYejgbB3xWP6
v3P5f8KCkzWdnnIV6gCrxyfoa5fzkJY1AbKn3oyrv/Yv4hoiq2bMCzjJ6csVI0lE
utRvgzoVPHxepDDOJsVjdUa/j70Mt2vkBFw2/0lKRwGT8loksVl2AyXpyTBbmlbs
CUjruvnhQTe7J8TcIlzoePxJv4kme6c6tPYx1m9HIqwZSEfrXf/E2V5WZu/Tm0k8
4Zb1ksrx/oVuspuJAhKO3lFHsr6eAJUtFo07FfW+8PaFrtfgJ0SdxDfMcmEyYkAG
orgNrUcqU/c38CvdeuI8oVD9q8A0Xy8Ao2Ek8Tz2qXIDmM8+5AKSu7/5daKWdBtG
gksuiK10pdmgJheuE+UQq30OrO+DbigSZ7hVYzmO/Q5B/IMZGbQme4dRQNN9iRcL
qP8MvNPaYJYfIQHMUXXJQK6FKYD1v9zUEZJxqSZCvxCzoLWhGOIy3Ag3XROEO6EN
a2Af3tIJ4XbCmXHWMD0ABA7AdE96SWufvAk9TdkzmNHCjjj894K97517OEa4+uY3
noxYjjlrUcjNxkxVICw1FGAJ5BMlGbWfMpu6R20TJ0E=
`pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
 typedef vmm_channel_typed #( svt_axi_service) svt_axi_service_channel;
`endif
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dKGEV0U2slGGT6puSbLJYeiMAuYi6wQ7+qCymQeaQiRnr8KweAa8SudyTR5b6iFP
Uqe1k7owUm7qsedXNFUwpiXXx9m7sm6khnB6licVS0w8Vbr4mWsBt/hmKEXQNVJM
LDnxonREtcDutLwH7Cw4/h06ViWxH/N335yiOs0xhfE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13285     )
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
`pragma protect end_protected  
  // -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gpcfZIKRBua8BmA8So5Wy8S4o0EvhOrXIcO4CeP+S/O6IkkP7OVDiOPbwSBkUsnZ
2KsTwVPybS6OX5Vja0ikYQJghLHsj4CwAKyhub5BdDtsdi2zdnEv8TEvmLIQbovS
NBJ3Uw8Rw8ksJIna3aRqWJ23VimFjUntmJCXIriSjGE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13478     )
Zun0MUu/CJT5mOskTA5/E6FAvziNrNYRZGXg0SCmtJhIqQvB2iEimVi36kzVFFyJ
2VIJnfs9yBQMuPPpAtaLFxQSUwuiakrdRM8RTh+kQql0E7BRRlB5Nj5VQ5m6DRwh
K9zPMyaR5q+49RLluQcFhs/INGz2hQFlCBzGR53fG9F4qm3pwgM1G8UKWtUo0A/j
erVORV2X8ViVxea5nLktpW5mLMQ25plNtXKNN8mTs2ihTU24O9yS0DFUQKSSaTiY
zfC2yWGFQCHLord3bfoNIA==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WQZSE/IXmX2WaFv47iyI88eB8eknBw9RJd9vS9aeMmw4JVoI2LoQJDyE/fgM7C4R
ujPt1izGHvrAJfOi1V8zaiKPmzu9EYV+SKtJQVDcxVXl+QLkWye/TdPNtbCOxpEm
crMQ+jm4ztg0fxuFUrDrVGCYpnYAKlwl2XejnSTeeXU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14684     )
WuIuO0Wh3UNmyuTLOlrLMLLe46jl4v6SkWK8j2f0j/ZlONPLHJeVXoEG7P5dkO58
T4iRaXqyAu6mmSVxIqIonxZIA/JtfrPvD1dwPqac8fhtVChkDJHUF2JU59VOMqpK
hicfGpKcepGqQ/NXWGWXCHhh66fYyOI546ERyveYPF1Hy36GeUIwvqojHQ3NO/HS
x63wAFynDxmmwiM8ChNnDPHTcnX/1jFvDDLTeFM9UsG55yX2jY+pWcYWO9LEC1td
7TDK/knv+BDdt9iESJqnZ22tI0G8YMzk76/hFHRZSTH6Z8i+qhgc5GH1kwAeHocf
Lf5N3oeTlZPw/WkNm84P9FavQDFKKhe+Tozn9l8hzBUeqOS+UDgR1wGu/f1pzUnu
4dornmOJXKdXFxSPMW/iUWXDfygPzYOCXiyE+P4Uw15SGU2eXmpytQ5hGnU2DP0R
SjcZzqfmHKgJ8YzreqjdO3eFglbahtheDzf/2SNfzpQ03hO8qRQcjMutny4MQt7K
r3NS3HRmqWnbF3YYUUrsiF4V1FUWwNwc2BzE3EEb1OYZ9jI5zrTbXNesF+CRGvxv
nIi1JKtVa2F0fpozbVwep7iLKuqfMSkIbQS4n93WtL04mgtUwsexuLgavA5AA3Sz
VyZbUWGPSjykiAHmwPg8hSmihWB9Do2pcZdeWm/YDwmIDkLs40dJJshgGO7hL6lh
5Xr+DBwhywGDoMCQNpt8ZKvQHo8SiixfgDvWUcU/2HW1smTbWtXlIfegK7y/BHq/
5MQwWQvorl2WLx/ihU0SDpX4Bvr794uxFJ8LGW2MgzozY44fhn7c7PG0C2+IHR9X
drmSKE+B/WGWvZF05RmtXK83rz2E2d0+LYjatrmcGzTARn2McL6bmxhx5IEexNpe
DhCJ4sEPNftPXrIPhqcg97+dbZ/d19NqG/j7hbJnEpeg9AfR+mhJvrY1TQf8HI3y
nJa7U88t+OKAF7aG2Zg35/Ri/sZTPSqtYuCFGI2woyeYO4+ADkGnEy/bWO+kqptw
QyoVdNA7MTVpVNW8gcEHavuS+0Xbn1d2hVyfXHlfo/pYEPrr4kYH2TjsK1ayYYg0
HfEViiLaX8yrpqZscbGYLUpceXbcIbwBLYTlWXYXJSpr8uCptHElTLfxgWsqEQtT
9NhcQxnZbkmQBiTOwzWpT5+llprUIlasyMqKrFLf1QSGQVYmQ6/T2gjePx6aE0Zo
9v2IgwBpwBVXSbcAUpezLn6N+MHvPjA+fRu0/DfwB/gy0kJ20KI1yO2NEY2EMdyZ
fq9DDjD1GLUoFiis5Svoa5QRVHjsGiHMEGXktAThcpvjv9SfYPmXgtW9HNT5aIWc
NN64spDpmmc5VMaAYEjAxBF6QnWV6CBLxgA9h4XTlYPUIJl3nLrAmErSPCANMpKo
WJCmwpabZtQ4o6fw1tm1NA9b7utPjVaW+5zEFrErdS/BX0xcCSVPpItrD5sALkqE
UVxrFQ/+fDIbZems0kM1wRSBogw/6NE1fICB8UvTcEJ/cC5LYQ4O7yZa2coLJgl5
KclGAiWJdjUVIYOm8S0ZkKgHlu/8HSjpIgojbUw6f711TEj1EOTufxy6Wcdm91hW
2RRw/bxQ4Oz1XWcsjJSk5w==
`pragma protect end_protected

`endif // GUARD_SVT_AXI_SERVICE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fGezM5qp5svS9D8KHcnHFuRLOc0xUX9j9C6N0noidOc06ASVoBiiKAW4aTgovxqa
Q/WWd9nG7QPeT3f+cq8V1bQ6kwX+4JogF53TUJY/K4fWq1mdv3gyiECzwlxIJ8Qz
3C8mbIzIUNFhQC31usKA/drSm7o06abk3YfabHnrVG8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14767     )
eaKoOXx74BBWBMlzwRLYQqDzKcvtwcsFevfRdnxRvaI64K8Nqd8L/lT3qdqHB3xN
0So2AdS3epB8JBi2dKfT89YRmWpF4OVcFPAREXkjlvQlVGd2YbECRapFDTxkV79X
`pragma protect end_protected
