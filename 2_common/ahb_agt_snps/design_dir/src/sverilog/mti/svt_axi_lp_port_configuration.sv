
`ifndef GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV
`define GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV

typedef class svt_axi_system_configuration;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YpElwuwScdr1lL3cxaldvViHswrr7tBWG1ipI6EHEBw7F6W9RpC5SXH5ybmZGwGB
qI9T+3CrDshuRs3hUS6cI7IBAsp+9WyD678mv7zei9Khlx4GLC/MkTUnFbxpYm6t
k6QR2xSRVxVBL0BXlMJ7R9Hf8uP7cvdQJKW4eeIR6us=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1003      )
eOCNzgAfuLyMJBuZ9ZsIR4CJdOEGfGk1XlFLaCDg+96fHTg7Aaj331E2ry6TtOei
JPIJYv6CByV8XofjvsOYT82j0So9thtnHjJHsoMNzN8OoJ7N5Edicqh5uSPdfShN
ziv57yl7X721iIE4cDX2YHLLr3MqHxj8GlIzhhwBRs9FtIikXMTdQVYb4AecWKS2
FUO+cJsUSeYrwk99ooRuh7WG5dwzTrJ1Y7lTpIaFTwIIKWISlSLDCE0/EpNbJVVT
nvx5nJJSwHMOQPoLUnA44oykdOrr1ApmV8/pihJfm0ZuVyjwEUW6hMxRraUkR6zY
ygJEDGrcxCKVFx02phPKk50+RqyL46ehUeRGAZfxiqR+GE1Z21xeFuVPsDEYRStx
JQ0DPbigwONPHD7yaWPUH4W43PzxbcC7Ad9MkrYsg52d9ees643EtFeeFMBMdvz6
4SE5lrubjS94Pu55fOu3uoJdf1lhjaTkxbaf7NDrFCrseFPHB6NlSfMvysh1Wfy/
sj/e2DbquvQ41KEgCg+opGoZrl6E1wo6E3amP8bNeh/yyvkbMX3YxuKpJovHhV4m
bqrCPFeiBWu9bE4FkmSseZ+pjTzGWxU4ac0ZZ8VU3DWBj0Tvoqdl/4UFNYYLXFpv
u7pQx9lPXAk9B0wLkS9WRnDcxlcVZZD4yTLnFE+lk7hFcg6ie+1vMBQpzqRE1A7i
COnyNFnOLO2i9I5U+YkPNtBBkNqjlwMOw6oHlBk+FGnTq38gYvf7tIII+kSpftNk
11bV/PwMIuAZFh/Nd0lLhmCEo+goF5wIQsRFZw7LMdcHaQYQ8nol8MW8OKCimb6y
YawZEvNMe+jV1tkWJfZO0GeyhGBJdv64D1A7OXt5BuUzNA4NgylYkykQDBfqhJDH
3tpcQeQWOFAodCmiM2jqP+Hz+7IYiYc+K/s9Ry90GG+c+sJ9rFRKGOMNuMHJPioS
xGGh7gSkssfcq5b1qXsYdhxEQMr2x9o05O8/0/kXg6d6A+rkGuLMwt6wLoBMKe+w
o89zg1kaCdI5SVf5pzKhobWW0JjZ+5kc3YUXB+UaHia//V3dAZME97Mnx0pZnSL0
n9wIyPSlOIkU3Rr0a09qOE47lAaZACgb11SUOCN5yAFcg799Z+u9RaP02V0X4UBV
BRxCy6EWPU+l8z+T51TBaUW6d1jU4AQmrovq6oqy4opobYJITje31vqZECUBVP9l
cELNTtKwUmfgWWyqWWbspwCrKwS9pOUEKp7aQXr0N40K0uZfVqfmCjKBEh3EToYl
ZgUuR+QVHwa1X8iimh3g/9zFRpjs7K8j/Ey2mLT9dBIVJRVbeVN+YEBDAYAccead
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fouW+PJGabN6DZVjaCpce1rFmptjv0ypXSJOTK3PAV5N17gMatgEIcf+HnAPXfkd
+n/wlW7NmGf1vJdM8zhlPk/UScnai7Oe2Anag2eBd5qaEIee52Cw7wOaUK0NnD+r
cn/JnXmj/B0E7mhLfsEVq4n7HkbeDM7DL0dfYCbCaVs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1791      )
84NjKy7g7m84DmKDct/liHkleeF8O49dOF4hWnuxTlzxMy84byPDjzoTmeWKygcH
OeHCbzrDHa1ma7EYSG1Rvrl2RG/52xuEghmxnOYaLOcS3Vl+9IwrAw7WRcRi1x9Y
0yPW9/rAQUxamYhWCEyshIkhO8j89qOKZRHveSQUZCFkl1nGkpGtH/lBhKs6GbEv
tFEhGtzBuZkukHoIusB1iC1n8p2EaAN9/djS0ALwmrxivAyie5vlHAal0mBHarHE
o9pAZCaFtANhDTB40ZOulEY7j/OYeAX6fao8X1ENwb4kCH5l2PAXKzdgeCcEcad2
HxkaP9APlFUFrQm+Xj+eeaBXO7MsCWOo2IYqMCiW1iIsKqA/KIPBmaVuucgiMkFr
+MmuL4zZ67DgDXrCK8WI+jK6wWBXD17G9fOcLBnYnhrAy3EHzeV1Er2Q9GpJPA1T
L8DGSiuLMQxY4VE/qi7EvH4u4C5pHKYCKyBndlvZg7A3C4w3YRPDUftOU4JhP/VA
gpmCAuEpgSoXA34MMGaAQ256+N8oCFu/fjfweRBDsDR7nWoOoXAeMkLyVCuKssT9
JtUGeJVi+fjntUSEpYaMeKezl76yxojcvV7U7HSbLN6CvTaXY/eJrjt5MJZOblF2
1OO9dYnnT45PKj2HX+OxUkpZ4QwNgg+Z//THOMif0+1vBv/8HB+gKQxSlgSCqtcC
fLDJAWU1H0ByDqiO2EVrbpVbyHafE7rnaxQyaBPVaIwa0/cUylzPaZzf4na8uRgd
jaCZWxfvofeSDB10OdXRIkI0KBoc1IhnYzel5Udrbm0iNBrmDa9ghgiz/fTgNbNm
pCI4QGJRWUapEuzNVP5Py+Qi0G+QQuT8r7Z32OqY9PK34IWlXP9gFLM+/NBzu7S4
Kd9HyECzIzUlTTeTc0V4J6A7MWd4NL6ew956zmeguuk3RKrD3btMpz27z23/ARtB
QJ8eMNMtpMYNEkkVZWDfalCU7g5gB5Yw8npyU9e844R6thVEOAwh6dkijvR/8z5K
v2TLFNQJI42BiLTZvQVHxETeqytgXst9Np2XzRI7mSU=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PgbEBOxWxS8ewKWVHX6rNPSFyknlgoG2m7hLv3+0bxUU2J3toIT6BNl/lOkCjE/r
2Jr8mYowMmAcRVRzTh9uKnoPjV+gbLPvj9AhL1ibeDB4ga75l96m/o5EC128lLPi
noi2AXDU2q+5mLhlq89eewf4FAFpXbidCnAvKx26x5Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19273     )
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
YznLEdzjtTtMczwO/Qwt5g==
`pragma protect end_protected

`endif //GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c9K7JuTJrt2pdzdIFxYAEwGJTZS+6O1DDXEts5KxGu/18s7z8ZshUZp5DKYWdGty
v8mTtOIqVjV+ECKJCVTUkbgwTCvAsfZVmHjwhPS6BeL+d94ruZrbov0ceUJg1yKp
bSrDEW2yz2hYTDzphUV3TnN+WKlWPfgqvvpHS4SPcUU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19356     )
9L/P3SN+vaRH9tnQyT+iCcW5QQ9VQmsDC7cGpZ7sCUgC6tu22E1f4tce/U6zX1Fu
lGR3NuqyrMOsBk/tgEQDXjoIzIqLBXqkVR3+tPa6LSRcXV+mdBFj6sNulfmQ1FPV
`pragma protect end_protected
