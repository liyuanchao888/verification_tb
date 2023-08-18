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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DQE4pZeS06OSnoduHjepbcMVX7i5vAGl7fQq4stGiWjRoy5iwIrzKO+eE8oavQ40
hcBIpE3O/lfZqLzYApW6T0u9Bc8+LHG3y03UPh+N84hf+FFFUVC2stTcts3qHU0J
EWh0jYhQ/tYc7p5brsTraff9luoCqXMvDtQQXFy80Ac=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2449      )
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
0dMTLtrW7FZAJiNxVYTOiA==
`pragma protect end_protected

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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lCYvhjxpjYXuFgwcIoK3XhYNnNy98wigpl83XjXv0UhahMw2E1d5mtOND01bsYQp
dKA99iiLiOQIGkS5EbM93rjhJiPgQJQQqB5lvYfrGpMRBhV4UHBvxeTPwdvREHcc
QnKwMdiAL6o7mjlS/aUgsaw25pzj3IpNi3GxBoscH8k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2999      )
k4nchoszcczunNybMWRapmVBqQOQNFDkvexhH6mzUsbU8NauxIZZFX5W440ocfoH
tX2XvlgF+SqJtZiBNeaediSyQulYLnUmmkSFEH6uX94/KJOhyarbP3Yt6l4AJdI7
ZILlh/hsnHzJJEVzrfTmt6UciX3ZHt8i48ESRTzgBJVMw1zPKp5NeaPpIAJ/EL9m
ZC6Woc+HQItOpHce/IlvFUJ0Zj9a+qgeERuUctOZopqnkpcwHrQGeObGPbaed8F7
EjEEdoyCixjiVmHk80p+ZkA08cTBh5YMfiuA9FHop/VwpmCzO4f8t2+yP7ku4tLV
wHF/e8k7GZD7s1YQa2UE2K1sbIzLxPe6nNaxzexiy/OxTR1iMa+oedgJLyY+Y53g
ww9n84cYwOKITZepmhgMl6VCIFUYA4QK+NS5MlNTHI+MSIEiQ04/pxyAUh8tE1f/
q1PwEkC4zhyfcTJHrYocBIeExfsKq3bRwlrjKJmFKGBK0xkyaAqt/0b40znwgtgQ
eSno2knWv2lfvE9uuTmqR8cp8G6KZKPfbZttLX8jkSLnB7V5rdmpW9A0PVEpP/eR
lv3ju7goTybljSMOunFmk7HU2v7b5J3Pg45+xBV0uuwPMFnhaWupLIKsCL5plUHF
h9VD7iqtcC9wBjRiA3gy+TsIIMpLvwe2CcKIwOVHcIhf3dHyetV5u9S6mD9g+BVf
lpDcppFWwimaaa+agEFd2SBt0Dtb+NaogKLqxDLr+P0=
`pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RN+cjqGPx8z3yhVJ4w0hw7XwEMN9+z4gvZKk8VI2PBTD0Yo28Hcz1e610uqMaBe4
CBi2cHKxaI76KV5zBfRXXvTQRROj/v2UDbXhqW6tVvLuX8upPDmzZIpJL9w8SWxS
xUbeXbJIcExeKwNVdsRh8OQSRtwgi+bWTZWZmtQVog8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19948     )
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
Wl7cS8lucplRLuCu8k31BQ==
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WUzZNoN21p7hctlu41UJwdUMSHIxRL8ULS8R16adBx3VHozT7s8/QPylxntIQSBb
94gtr3ABEtzZI8x/o8pwVw5kietiYE8FGA69WUwaHe0Xmlr3lRR3VuxtgznU0q1f
+NOzzEhnvWiVnKViAYKX7Ox4gw5+QF14qQPW3Hn0z+E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20031     )
g2ywg5VjioZGRRyFUunYCPvA5C/zQyCriT4ZjQP0w3xgoKOLPxM0yMZDiZbBj6e0
SpnbVDLD2O75kPcZfo32QqjSNUIjr0fcPa9HPIQs1jELkgMJ1OqwEk3z2ulmUjS3
`pragma protect end_protected
