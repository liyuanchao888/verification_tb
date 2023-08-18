
`ifndef GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV
`define GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV

typedef class svt_axi_system_configuration;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
REXd41cC87xLooe0/arO0Vn+DBXZ21+n7p7UA8CsVT0EvyeLA+O0PvQXd6feDDq1
7AgVOjRW7O6p6iQrxK8+yMw+vvt+e9GzXUy0dslHL7iQnMejemBXVQLYswJ6iE5Y
3QsSPb5ETV2QCS1u5rVl6dXX0hVLzjras/V9jJ6UfZaE4Cc6/KxS2A==
//pragma protect end_key_block
//pragma protect digest_block
APiGgUrIaIlAidfOQO/UOdTVsm8=
//pragma protect end_digest_block
//pragma protect data_block
L3yYTyeDgWo04TrvixLiqGlSj1v4id5ZLnKvjbYEyg0+oSym0M2wvcwf/mhkbcQw
rOi7Mz6eyiis1ClRUbXr6WPh692XH06mWFRJtOAFo4+2/006enO5uAJbewRz6elc
HO6JK0yGyuGybPnR9SLVg1Qc7z7e55ms5uLyFhvL1G6Chsaa9Dz9XBdX/DHV6+up
mNl237ynEUGS6ir6NNL+jhMT7O0fpnezNdaAzt9mjto30IL/5N7KmN0+N4mRP6p8
UZpW8/UpjijFTYymen3LhCemsX0N9CqhPjKn5oZ9kQNaaEBt9zE+tOi/wDEz1SzD
5V/FsAuGXs+17ibsHwGBukYZJx78MUuNlRYT+W4eXVIP6y8aSyIiSh/wBEprvvuH
n7s3txpf8HnLE1cA7n8G3x7MFyIEi8XbR1woFc3bA+3TVQ6WTyYdSdrZShSOGHtg
70gb2QFWEsBMHagmu3ylmyd1E4QhyXnPrpUEOVN/L2mXAvULLerBSpp3/v5J4oFU
vGR41NL+GlAEBJFkDHMVhK6HAmXgd4oq9vLcMOuvSGNq98o2vGriiWXnJ/S2zKOo
1DhMu6GkCaWKE/pl+2Slzm3kYpCXLJboNTOVR6e8h0EIzY8JchoYh5sk4sV7Re8g
LiWt0JtJ7YCL6MSbRfWZ7AD3MnNkVpsDnYbIkLdujCKvgFEWGCUO/671U/bOl+RD
2F5iRv+C3U7rEiMZz3D4XqZW1pubaTkkh0UlbTvNL2Uv9N1AIWRRFng0+SEYdtlX
k+1LvC0fBpwp9FlDc8XSQre1kng1Gbupb0I5KRLJYo+NFDCJdtmIXBBcRxkl3gPS
6fSscGsVSHGuq+YH3JHNBJ8MXfkn135jfGei8b2a3GEWpESZ9bnr2gVxlQDwF4IJ
H5+VviO4SAOdOqCRLNwA0p6+o3k5DEgzeV8lDy9j6FX/GU30kb+bt+CXh3OieoYp
eq3u7kKzbOCfT5j3gVNO6PJHj9lnlew6vOixFPMjPybg2XY7ATeHI6rlzGVrYF2+
Dsw6ri1kjG4m0trqz06ImHwQqVUO0fvxfvxmr7Z7SYRT19zhX0uSOhncESh3cfr8
+WXmp//Sd0hTCLVp+DPs8pJUboU2rQ69IQmDAo+VM4/hgmTRm9afLz0OLKsxEu+v
SLcSVDK8ZQ0Eyz+SjlgpN0948GF3kvCz6rfBIhKItfYoj45UcxkKF3kEtIlcV3ZF
Z7fHDTxxNIsgKBsAKHsezxyE+Y+AdOumr9QnLwanUHmzidfaptg3e8cboPhWp1Tt
80BHs/lSQ2fKnB6VukjLaqSBsd78EyIq526vYWeYY/tb1UOd7rmBdcK5gktBnmU6
jicuOSZf+GK1XOWmVnJ6QKUo0cs8zlU8524jAX29P0FvJ1+VJj7pG0FSsIPyh5G9
FtEYBw6uoJp4fxvPpGxmAuX2wrqtdSeZU9jqjmxbbWdNbNOcU5etV2QSCZkAwODF
Zvh71Heh5sZv99/B8pDSCcl6Y3udLK1CCEnG8KeKUCnd1tWlz1Pj9pjSsFYuGdj2
pznPsjtSlIlEb3lptE94Bw==
//pragma protect end_data_block
//pragma protect digest_block
z98f5wUsf0f66aeQQNU6uu2BI3A=
//pragma protect end_digest_block
//pragma protect end_protected

/**
    Port configuration class contains configuration information which is
    applicable to individual AXI low power master interface in the system.
    Some of the important information provided by port configuration class is:
    - Active/Passive mode of the low power component 
    - Enable/disable protocol checks 
    - Port configuration contains the virtual interface for the port
    .
  */
class svt_axi_lp_port_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual AXI low power interface */
`ifndef __SVDOC__
  typedef virtual svt_axi_lp_if AXI_LP_IF;
`endif // __SVDOC__

/**
    * Enumerated type to specify the initiator of low power handshake. 
    */
  typedef enum  {
    PERIPHERAL=0, 
    CLOCK_CONTROLLER=1,
    BOTH=2 //Don't care 
  } lp_initiator_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifndef __SVDOC__
  /** Port interface */
  AXI_LP_IF lp_if;
`endif

  /** 
    * Handle to system configuration
    */
  svt_axi_system_configuration sys_cfg;

  /** 
    * Handle to system configuration
    */
  lp_initiator_type_enum lp_initiator_type;

  /** 
    * A unique ID assigned to the axi low power port corresponding
    * to this port configuration.
    */ 
  int port_id;

  /** 
    * Indicates the active/passive mode of the agent. 
    * Only passive mode is supported currently.
    */ 
  bit is_active=0;

  /**
    * A timer starts as soon as cactive assertion is observed and keeps
    * incrementing until csysreq is asserted.
    * If set to 0, the timer is not started
    */
  real lp_entry_active_req_watchdog_timeout = 0; 

  /**
    * A timer starts as soon as csysreq assertion is observed and keeps
    * incrementing until csysack is asserted.
    * If set to 0, the timer is not started
    */
  real lp_entry_req_ack_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as cactive deassertion is observed and keeps
    * incrementing until csysreq is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_prp_active_req_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as csysreq deassertion is observed and keeps
    * incrementing until csysack is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_prp_req_ack_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as csysreq deassertion is observed and keeps
    * incrementing until cactive is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_ctrl_req_active_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as cactive deassertion is observed and keeps
    * incrementing until csysack is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_ctrl_active_ack_watchdog_timeout = 0; 

  /**
    * A timer that specifies the max time difference between 
    * deassertion of cactive and starting of clock.
    */
  real lp_exit_prp_active_clk_delay; 
  
  /**
    * A timer that specifies the max time difference between 
    * deassertion of csysreq and starting of clock.
    */
  real lp_exit_ctrl_req_clk_delay; 

  /**
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    */
  bit protocol_checks_enable = 1;

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_axi_lp_port_configuration", AXI_LP_IF lp_if=null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_axi_lp_port_configuration", AXI_LP_IF lp_if=null);
`else
`svt_vmm_data_new(svt_axi_lp_port_configuration)
  extern function new (vmm_log log = null, AXI_LP_IF lp_if=null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_lp_port_configuration)
    `svt_field_object  (sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
      
  `svt_data_member_end(svt_axi_lp_port_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

   /**
   * Assigns a master low power interface to this configuration.
   *
   * @param lp_if Interface for the AXI LP Port
   */
  extern function void set_lp_if(AXI_LP_IF lp_if);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(uvm_object rhs);

`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the OVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(ovm_object rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif
  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */
  extern virtual function svt_pattern do_allocate_pattern();
  // ---------------------------------------------------------------------------
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
  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  /**
    * Does basic validation of the object contents.
    */
  extern virtual function bit do_is_valid ( bit silent = 1,int kind = RELEVANT);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI LP SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI LP SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI LP SVT
   * suite. This is checked against OVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI LP SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif

  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum value for range check done do_is_valid().
   * The max value will either be the MAX macro value or parameter value if 
   * paramterized interface is used.
   */
  extern virtual function int get_max_val(string width_name = "empty");

/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_lp_port_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------
/**
Utility method definition for the svt_axi_lp_port_configuration class
*/

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1RUyWNJc6Ax3EL/k5+VJcAwqp8kDmEFy+W5beM/Upb3tsIiaZ7Fzf7q3uMMTgeBk
bptUKuGsleSNGYc+Jco3Ex2TWTtKL+/kywy2GLoQLoJyUr6qDtg4lgPkje2iaEl6
5keYURLVQYUOTqvy8zlkULfYAi0YsfzclWnMd6L33y1l0oB7ghL76w==
//pragma protect end_key_block
//pragma protect digest_block
QCsaOD+XXQUAnZGeXCYGDdiQ7U0=
//pragma protect end_digest_block
//pragma protect data_block
8684Cpz7M1cfeX3AiG8vKtpOZ8OeeaZMn2pPvZmHfVmvIwKdb7TeVyM0NAURlMV1
fkcrbH6ikfIc7onjZkJLXTEMM03RK9h5RLZuqIFW/4lwwgE2m3GiOwHoLl5nXAhA
IgsO3+25kJFFVJ5v39dDmu520qXC+lLy21UgC5gInJIM7EJsqchUHQbXEe6cVyMG
D2VSjl0fm5FKNiH/wBoKKEGLvb0HxTGGbCSyKhPgGVL+qFll2Q0QD6Zs8czql2KS
9SkBFl5qVuOISz8THdJW+K3y/4lVr/AQvqJwonSznCPtE0QQjlWLUYykfchNgwAW
S6wuzb0uGg5esCHdJ21qzA6f/G0Rmh6eNZTPywKLppW6t/i/aQk6NohUTidf+wHT
tyKhoBeKjt3xk/vhYWb1RznsZX5qWlk/O7u+Z6OO21fDeGoFpezQNzRaviSls15h
Pcd9Wu0zbhP+DYfX7i/ygh1SmopEVtqT23JlbPfUawhc0kYHXUfGivLz5d8zUzrW
R7t1+AL88NZf1fAdu2CzDFD4oiinfSogWxzFS8X1QimH4EXrIIu60FsTpMN/E7+L
HYssoWxzduojoilVe5cBCH8tfFMiHjfxlwI9mIBqZj/wcRh/ts2Z/yvrwiZ9Dt1T
QOf5D7/0lz5e27V3Q90jI02xj9UswTpcFe+2Yv6bei/x55CypApWyo3eDj5qnJ0z
ioYLpVMOvKDCjHpxDCv0b6Ajs5uCNv4w6vtZVZZ7W6L0gpxssu9Haws/gYWSJ5bp
8XOi/WQdayIb/sr+cUt0YuD/BcJhXPXuPOJ2xFwb4jtfnpwHAxVLmg/U57nADBHY
z8IappUHPHygn+KIDj0p5OWGHAYoP9XMXUBA/AMbddZJTspu0ljyF6iPISO2zfb6
8K36hXZXLXjmPSHbDwMJfE+J9BJXbK3AIowvnDY3v1r7JQJiwZAyEvin93rIc4pa
x7HSJwNs96aXsdkO/8Ab9EbvL4YBUI5PqN/CpLWRQu4+SukYN0DCmmaJBrwih1Hy
QnYZOlFZTyhA1PBjwrzSeUoO2W6MnZWPJukqV7toXBoCP7ah6ZtYFJZUR9CV1/ZT
fm8PT3wRMPHAtdw8idfa9NA1jWtOJAEyNM+/kuX0eOAfRXecWIIAFMLiMadBb84h
o5xVRziypmA9Boqeo97Wedmj7RAWWLS2hfc7sGG6V3i6pDtRXaJd48skVe5P1/J6
Ui2JmV4Qwu6YMnnkaXrXU8f2Qh0qJC6TRTCrV3uVZTEX5/odw6fuXqwTOIETsgG3

//pragma protect end_data_block
//pragma protect digest_block
4N2OnH4ahDqFPQwIq5JhHxrSGfo=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
02TxMG1Ngs1IDtnStmL+yCajNo09i/uFpJ98LXjfB7gXz+riwoUb9HskqvmLfFhb
tcEBb9qto01rpk1EXP2OGvDqXBOlz5udXaMz6xgZRO7IbVzG8jetawWcwZd2bp8t
7A+LdMcS+pS+QzKrZ+Hi5XfkxWwsUqWIF41hTqjpFWnhfpokzSNtqg==
//pragma protect end_key_block
//pragma protect digest_block
CudhwsyLeO7rvdkwywIIWEOd/cM=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
OasUQr0mppOkNFjHnr7/UlahxlQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV 
