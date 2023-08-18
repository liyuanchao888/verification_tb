
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
La0xn3dUrgh/67GI/TPqiI5v9whNrIgk04WO+dKnIMc8BJjIMvavqNzJfjSRLiQR
Y8ezkArNJlDgFASs3X1FHdOZPtv5N+PFDVb/j/y2k5BdcqoyRPx8i0+R1Qy2GHuh
W2Qir0GIdwWpGO2QDf1eZR785naTcFRVcnmY4kRjaFnblL4SCmsPgQ==
//pragma protect end_key_block
//pragma protect digest_block
qD8SfCZPPoWcfVogSDLVbTQWLcU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
1E1glp4rx+qNJMQXsHJ1K6iN61E=
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wgndvsVQ14RHWOcXqHA0onpi1FVb+ZjAc2Ff+t3rZxEy6ezJ5O2SM6QMj19g9UBX
wObMqFgf0W9nbOpTUI9tzLHw2bfEXw6scsiJcgqLmi9e6yyNmhY9CrpiGEKUtajs
9+XEitGY/8o+biH2wbI3HkPUYfKDATgE8vxUaprUz+cS/ZPLEexX8Q==
//pragma protect end_key_block
//pragma protect digest_block
Ewe/ui4yr2GBN7lFimwKpW2I5QU=
//pragma protect end_digest_block
//pragma protect data_block
E3D3T3YDV4Lj9k8+EoRAnBmufvjZPxSElIe0130yvJbWOmXNCLu5+8z+zhWoyWmG
t5Vd20d8de04ZX89uJ3yq7ogVBkWf/4NyanMsPf6aK1V4nH6MiPI106syWlcS7ZH
KnVYW/bYzKcc4vJlaTju4NkE9uHdh5uhVRrg9i8ydJICu9cSRomq4jFykWk8IGo5
kRF5wYDJ/1gtXlOjvqMVFE5v7FcPu6nV1bc572apmd1Jxvxq/FJrfAoFnLvernwy
CdeLmuXTK7nk2j9HJMPv7Mu/SjGejPfUhwTkiPNhzEWcrktU1Xy1cLSh5gQX9QV5
jMxVd0sSq+r0CL+GKH6U5xfddZLiWv0K6zzL3Rhk05jH5NdY9BuhCAUsPZyZCL8r
MjmVkPffgdetwugy/fRYz3FAtcboyMTeC0Cd3iOB2k485AXy4tKciBWGtynVUv9p
PmqeP5Gpx8T+HFJsK07AJ5+Dqi9vpy3F7Ey+83XwwQnIdvpDKVGti5mJ3fcEAqrE
qt2W7vqP2gefJ8wxc62HXOPTuVece8X2TPDY9Rj1A1c2IXvThVw6os/meQDfyP0o
LDHWX+yrPYBQ6pR4ggZT73IRd8R4t3piKIPcPphB1zJRZPmVO/BcnQzxp+fT9tta
sEp/HFvrM+B3echBPaCxvokTFhUNtXhQAHt5B9aP0Z9okLpnl0KAw72nRCZGslXT
/H/XSV5ZuQeMBeQo5NWp41uYEIBUi2pi0oFOrCUnH2YGy2kUeH6aoODLxEokYOr8
ZQRQuQuWvhcTNdHI4XdyoUaqeba5290Tx+CW+7y7jgMEa3+ACiRcjWufvRFd2CbL
AiKU5h/QZeLCGU01UO82lhVbiV4mV96l9GtMmYd2XzKYJMjp1odSxlY68EUnN03P
aAoeol5kezypkqDMTYj0PqMMfxGe3kBKd1vk3jHyo9PoR5GM8DnejU5ROBPZ9oef

//pragma protect end_data_block
//pragma protect digest_block
AEqpA/uVOgg42VTY2j8B/nxhs7k=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wGJv0JjRp2j9mq3cagOD4fu4HB0nyseN5HPeHJ1/yHxm3bpBlUi39TG0t96NoK41
FW6vrjq811YMtBjQf7QUcQJb17TOL5rhJsXloTtH3+M4i/GbBiDlsEbVRxSyCk9f
b/ml+jBIyUJZuzcxyfrLhHF5BmdteZeObD+gTzkmK9gTJSZ1RxB7uw==
//pragma protect end_key_block
//pragma protect digest_block
nK17e1s+sVVdTCpqe1SUlw3PD5M=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
zjOZVAE9GHSx2QvtPPqrGCQ4IDQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
