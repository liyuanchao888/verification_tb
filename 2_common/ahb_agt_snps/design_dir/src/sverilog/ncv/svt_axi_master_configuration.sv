`ifndef GUARD_SVT_AXI_MASTER_CONFIGURATION_SV
`define GUARD_SVT_AXI_MASTER_CONFIGURATION_SV

/**
  * This class contains configuration details for the master.
  */
class svt_axi_master_configuration extends svt_axi_port_configuration;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
    * Default value of RREADY signal. 
    * <b>type:</b> Dynamic 
    */
  rand bit default_rready = 1;

  /** 
    * Default value of BREADY signal. 
    * <b>type:</b> Dynamic 
    */
  rand bit default_bready = 1;

  /** When the VALID signal of the write address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum write_addr_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** When the VALID signal of the write data channel is low, all other signals 
    * (except the READY signal) in that channel will take this value. 
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum write_data_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** When the VALID signal of the read address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum read_addr_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** If this parameter is set, the master checks for any outstanding 
    * transaction with an overlapping address before sending a transaction.
    * If there is any such outstanding transaction, the master will wait
    * for it to complete before sending a transaction.
    * <b>type:</b> Static 
    */
  rand bit addr_overlap_check_enable = 0;

  // **********************************************
  // Configuration parameters for STREAM interface
  // **********************************************

  /** Setting this parameter to 1, enables the generation of a
    * byte stream type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit byte_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * continuous aligned type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit continuous_aligned_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * continuous un-aligned type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit continuous_unaligned_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * a sparse type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit sparse_stream_enable = 1;

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eExplrlkMetviRzMnNbZ0jN1z6ByBNmbCRBxgWiCB+JmJ1C4kABVXTwyQfzQIumn
cFVKf10aE1TZPr/vBb1yeNpGbrWjJaqVsL2SMj65mbdIku1F1UUlZ87ekYz1BbAM
oJd46XIV3pYKpU8XkiyDeX8CFVPwrtrPoijpjRAOq4Z5xvbk4B8e6A==
//pragma protect end_key_block
//pragma protect digest_block
H0kz1GFBLxc6WI8uo8UPAM3/2rY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
te0wWndxQzmTJ/UzwTgwYdDe0tM=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate 
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_master_configuration");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate 
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_master_configuration");
`else
`svt_vmm_data_new(svt_axi_master_configuration)
  extern function new (vmm_log log = null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_master_configuration)

  `svt_data_member_end(svt_axi_master_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
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
  /** Used to turn static config param randomization on/off as a block. */
  extern virtual function int static_rand_mode ( bit on_off ); 
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /**
    * Method to turn reasonable constraints on/off as a block.
    */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /** Used to do a basic validation of this configuration object. */

  extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);
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

endclass

// -----------------------------------------------------------------------------

/**
Utility methods definition of svt_axi_master_configuration class
*/


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gF1Sk5Tow2SoJTkZ6H7WdEQkFmW62lDrnLiwkEcEICrvJtIFa0SeUZgzBB+5hZVe
lcSwl6vD7zeTptVe4/tZpQQ4CDb1Q5xQaTSXkErQqgtcRH7SX5U5P8RYK5TGfI27
U2OR3buP1qB+88VRpMc6/DJsZp8falqa2f2w1v5rUkJHxl7VVTVN3g==
//pragma protect end_key_block
//pragma protect digest_block
y9ooQdsNFw4RIi5rySlFbOpUuAI=
//pragma protect end_digest_block
//pragma protect data_block
+agmv6EjcN+W6zEdPFVTqZWiFkdFTqUi/DJUX/n/OZzSVI+O9hl2GFDK2DeL83oX
UzWU1VRRg2FEwOVdVCRYPr3l7dIrbLpozFMdLhqd6RDzLjn3hPWgyvkf+pNKJpY5
9ifDPClqMSXKS5OseiB6mKvTNtqmeWamsAjnOMvb596++FkK/Mm3JOFcAzivPY9+
rHyUFzwQoLUGzUpSY9dmHopaG9glI1lBK/waV6rN71mnbXBcAc6CihBylXSGjhZa
+1tJ1SWWnOtfhmZhb9LODISAu48CJsFYPXPmz5s9jYuEaxeLCXbNlmszeKZt3UYZ
sjH/IjBngziQpZC1/T1jFGMIL2VSXodpS8msRe3FsnKXHVMQbHp828ZWBGf+6V8x
NH/ImNktRQF31zp3KTWUIxQ6yaAYLnamcc/qdm+asDEbaQZYPcw+Qm9wE1bQJN3p
SmeZNTJKRuD1yrFeNySGPuP/WdAxi9KvAvkIBppVqQLXJH5LWwq2SUKLMU73l6ty
YdrrPoRj1cCM0u+d4R5hl67Syfcm4zNyGZyYWq2kBcUaDU35SwFK/IpW3+xUqkB/
UgIdpGaQhGWiKR2THfEyVRCbusIsD6IPi9Vl0lz1xmliDKV9xRCPgFkPrdWv/FEQ
Ejwjsx7DtLiWpXsbSnkx6bcT3yIffx0jAfmHBl/4Fu6ynxeDcjj0C77OG4D2D5wN
kFOqJ6pdJAxHuMrJCQNnB/YgLtr42Cx4RgAW8RIRT6AvWd+e41uaUzUWiYjha8v1
OjeW/KdqhvRBtj3D7NAX1T1bC7xChKG7XnapV7Qn3pMOhl0Qi2ascyjfIWXDouo9
IcR+foPN6IRMtwnqLQuWZiewVo4snQjrps6eXfzbU/f+C5G4VZ1ya2KZZJkH/5pO
ZiVe9rhba+m8eG1IguUp2MIaWZKOnTPu46HZ26u1WRn4z08ioIUk5pLi3AZhSp7y

//pragma protect end_data_block
//pragma protect digest_block
kxNS+6sRdAU8WdjR15nsd+X3hfY=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
35baBCUEzaxKOwTQ/p7+zbCzlTMaVxzTNqxYCND4DGW6to/HcdTb7qLEaN+YkCmw
091DX9qHAX3Abp2skmozGx8EA9xE/TK2tYkFo99dHV5MicyO2Ka2JYBlskX836EM
wiwwlREH3AZtLe54sPf7qvrYFEvk+Iu2IXhavTETJe9tW43uSwSJww==
//pragma protect end_key_block
//pragma protect digest_block
HwvBxije9EjJwOJOPTxeLPB4hgw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
7pvAxifwrfAmiWhM+jg9xFiwYXs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
