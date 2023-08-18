
`ifndef GUARD_SVT_AXI_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_AXI_SLAVE_CONFIGURATION_SV

/**
  * This class contains configuration details for the slave.
  */
class svt_axi_slave_configuration extends svt_axi_port_configuration;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
    * Default value of AWREADY signal. 
    * <b>type:</b> Dynamic
    */
  rand bit default_awready = 1;

  /** 
    * Default value of WREADY signal. 
    * <b>type:</b> Dynamic
    */
  rand bit default_wready = 1; 

  /** 
    * Default value of ARREADY signal. 
    * <b>type:</b> Dynamic
    */
  rand bit default_arready = 1;

  /** When the VALID signal of the write response channel is low, all other 
    *signals (except the READY signal) in that channel will take this value. 
    * <b>type:</b> Dynamic
   */
  rand idle_val_enum write_resp_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** When the VALID signal of the read data channel is low, all other signals 
    * (except the READY signal) in that channel will take this value. 
    * <b>type:</b> Dynamic
    */
  rand idle_val_enum read_data_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** 
    * The number of addresses pending in the slave that can be 
    * reordered. A slave that processes all transactions in  
    * order has a read ordering depth of one.
    * <b>min val:</b> 1
    * <b>max val:</b> \`SVT_AXI_MAX_READ_DATA_REORDERING_DEPTH
    * <b>type:</b> Static 
    */
  rand int read_data_reordering_depth = 1;

  /**
    * Specifies the number of beats of read data that must stay 
    * together before it can be interleaved with read data from a
    * different transaction.
    * When set to 0, interleaving is not allowed.
    * When set to 1, there is no restriction on interleaving.
    * <b>min val:</b> 0
    * <b>max val:</b> \`SVT_AXI_MAX_READ_DATA_INTERLEAVE_SIZE 
    * <b>type:</b> Static 
    */
  rand int read_data_interleave_size = 0;

  /** 
    * The AXI3 protocol requires that the write response for write 
    * transactions must not be given until the clock cycle 
    * after the acceptance of the last data transfer.
    * In addition, the AXI4 protocol requires that the write response for
    * write transactions must not be given until the clock
    * cycle after address acceptance. Setting this
    * parameter to 1, enforces this second condition in AXI3
    * based systems as well. It is illegal to set this parameter to 0
    * in an AXI4 based system.
    * <b>type:</b> Static 
    */
  rand bit write_resp_wait_for_addr_accept = 1;

  /** 
    * Enables the internal memory of the slave.
    * Write data is written into the internal memory and read
    * data is driven based on the contents of the memory.
    * <b>type:</b> Static 
    */
  bit enable_mem = 1;

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ij7MmDNWcrAPvAWosJEkd02CDaoSeKuQRaJE8PlzshZge36pcVOc3r0rqAI7vcVF
Dfu1Oow9mKDuVxX+Zanodtpf+YpRN3gvhcHgqVsFJXoRzKljeN0bmz0GOXOJYEkO
lpYUyk14vKh1JSViYGDKbRcKPrikAxtBF4pUHc2/yZc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3333      )
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
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_slave_configuration");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_slave_configuration");
`else
`svt_vmm_data_new(svt_axi_slave_configuration)
  extern function new (vmm_log log = null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

 `svt_data_member_begin(svt_axi_slave_configuration)

 `svt_data_member_end(svt_axi_slave_configuration)
 
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
    * @param to vmm_data object to be compared against.
    * @param diff String indicating the differences between this and to.
    * @param kind This int indicates the type of compare to be attempted. Only 
    * supported kind value is svt_data::COMPLETE, which results in comparisons 
    * of the non-static configuration members. All other kind values result in 
    * a return value of 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Returns the size(in bytes) required by the byte_pack operation based on
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
  extern virtual function int unsigned do_byte_pack ( ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );
  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);

`endif
  //--------------------------------------------------------------------------
  /** Used to turn static config param randomization on/off as a block. */
  extern virtual function int static_rand_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );
    //--------------------------------------------------------------------------
  /**
    * Method to turn reasonable constraints on/off as a block.
    */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
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
  //----------------------------------------------------------------------------
  /** Used to do a basic validation of this configuration object. */
  extern function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);

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
Definition of the svt_axi_slave_configuration class constructor ;
*/


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pgw0P1IhtroWLW85SiBTN+OuMIVhpHU0DN4a6ezd+4GBKf/BXP/NKHZv80C2dUex
MMgzQpwVeG4QuonEjwO0ETymATLQkKhtdRK/necx/5GCLTG1MGAWDPboET2EI6g4
7mnEefqDybdAOLqmyoYtn7IC5ZKZ5T6PuTXswUI6Rto=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3877      )
mYBe0DuCJ/evPXq3JCuHyvQ9BmiVuw0ZQRvbpcYew57sYOwGnS2l8iIMZdHoXrDe
ohjKKC5VJAxbPD4lo6t6KNzN+mb43UtWFkBxOecveMDwjmCOFGxMHSN7v42X38z1
VHEyJY88u41pId9AvGivRHN7VHNSDeqJg7/NkNlZdcZprrrfM+QNUjaDytMHX+kQ
ORuU0kHHtY0bQEkzlY/inqggqEsDIQYm5/gq8PIty576ulbwKfSx5cZSugkzLEe/
mnqgUVsuPEuyQhwA6H6cTfcEwKY9z61FxoxCHJweGAgnlqR2MsYqydVBDriLhHXE
fx4RONXBz+QgeHKMAAK3NWPyiVdJpgTU75eepJC4s70tj1/ikdeFzn3ytSQuzcn1
h7qki9U3dRR42a/VKQPXVKHMXVaNLlGfITDlj2zgj4i6fl43tMs9n0XLpaQswFm2
UGqks3DmUUNXZ3Wdb9DbEpRtNUyj5KFr8yE+cxOqQeP+soTe7t+xA2wBnatLd7zW
hb4mElTBZbhpw47SAKTqBBkTeuiM3IgAN2suxvVZEKwI9D/62riyyQ44JpqapPSi
0Z2XApeaYEUscDjwf/Uc47eAh0rtZPZMCAS2vACDRdsmh5KE1tMJK3uJ1P8ZvQLZ
j5Yv7caf4qXtjHU7VkC9g6nkbWaJcfg+Ppg2DBX6FJCwR7//OKZIOvij4OOPp4uD
44NuGvXOqjfHSt1D53a3rADwh81sVWt5+b2tmgNS0ek=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jz72LTm+4cD7WQ8cR0c+u+f5C6GWFjnVKVz+5s2LkVb2GhJKmsHfRgmIZTGP1+Y7
TWZ5s+rcwd58h7mlVKLHIfPh4wodocWp6wCcCAraO19R1bp1jZ4s3pc7JdWuQfOi
ctM33kKGt59N4vST/EibKMmV/W/hUa5Z/KvPGG1VMGM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21928     )
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
g2KdSNON99/wat+cmwtg2A==
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pl2ULeO0/yBNtrIvvraRqQ/bTQVk8QrPe0aHaidiZ3u6pZktRKhpjXl92PItBTN0
7XTiu/XvDXtGsOYTt3K0zlVLyrzXTdg05E6x+Kzm6+KWY2SYHW7uVkK80+mejMGt
oqpep4acNP4etmKtEOfEGdLp4BvgoE3uXgjK5MUxfV8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22011     )
lXwBhpA0GRMIGIskAqazr93959bcNkvEMZ9FWIoHzCShIFNQ5Rd7sKG4XAQo6Hk6
aCOLnE2RuCxmP1x+3HHCv9qCsZzxc6wJDgeffSjSKhfyRvPJsZE36zCLvyhPWQZc
`pragma protect end_protected
