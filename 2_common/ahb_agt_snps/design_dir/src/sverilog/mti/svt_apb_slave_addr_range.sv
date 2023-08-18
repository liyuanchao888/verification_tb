
`ifndef GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV
`define GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV

`include "svt_apb_defines.svi"

/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_apb_slave_addr_range extends `SVT_DATA_TYPE; 

  /**
   * Starting address of address range.
   *
   */
  bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] start_addr;

  /**
   * Ending address of address range.
   */
  bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] end_addr;

  /**
   * The slave to which this address is associated.
   * <b>min val:</b> 1
   * <b>max val:</b> \`SVT_APB_MAX_NUM_SLAVES
   */
  int slave_id;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_apb_slave_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_slave_addr_range");
`endif

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
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted. Only
   * supported kind value is svt_data::COMPLETE, which results in comparisons of
   * the non-static configuration members. All other kind values result in a return
   * value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

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
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at
   * offset, based on the requested byte_unpack kind.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public configuration members of 
   * this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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
  extern virtual function svt_pattern allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_apb_slave_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(slave_id ,   `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_apb_slave_addr_range)

endclass

// -----------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jw/m6AfB2gPfY4SAbO2xhZ3i7jKOS/9lqQHrWwdQhDLV+euBsgb5cys+TzaUINpX
Omp8/ZiqiPll5496XvFbLpAKkzmAfezd0ekRth2F21IjBJ4Qc1Ov4wCtsRkufUj8
QQehxQu0Leg/Lge7EkwEjYw3/RM5+GYTpWAYPPHuhRo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 411       )
HhlMZpS1pvW2GYLizWNiwXCGc68Yxaj8ubKt1QpHX8Ct/gk3UYEfbHDlDSdWvDw4
NKf44Hy7aD9agXGFAKpYUW+vwJ8Wxq/SyoEGvbwX0MWR6Y2iqeg6Tzda957bBUYr
+liGpawDYvBhmB+NIt+bOtxk9dGBvGbe+rxJ/87Wb0jCj8Bu2AKCi8Q5SaUR6+fR
6BqJL41WDsobBCfkqmDsjc8cYJx0i8nLtyUVll1yUi7gSy0x11mHbg0MLGCAB/lm
XLl1s0L9Y7c24nz1wHJGR98pYus87eaAp0Qk39YKSopKlGCinJzZ7Yn1aEjnS4Au
P3A9BXilr7pMNOcINTQQuTf7L0GjPm2m9PeVwvxqv2RTt8vXzhD9CslwPZn3jHj2
Fj69qk8gKy774VuTsC9pCAkk+YvknDTpS2/wyNUec3OG+3b1VrCK6U64En3jjCu+
MJWjT27rIXx3q64Ya1pSw7ZeHFz17vcWYi8Lg5st3TQ6eiEskvAsLv7eANwCAwI1
X+/wLpzSawPmQckLq3Yz9xQbUGev8sKgMPBgRpHQlR0=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iAahhGggXQOo6K+oQbrs+yPKYIRQqCWapNq3q+Keb2XHudG5xaEexuMn0AmQTk0r
tWGAPsNWKZftvaeTOpWR63ELUFCUej/NStb6SN1r4WXKUdaz1VTDTqpDsb+4N6ih
l1YrnPgJ3drtPiiUr0k7Bda5GBC5F1ObJurjb+XnUiA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6377      )
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
FaQaMEhwiryMQJtNlW9w6g==
`pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EWD/Owrw1kSlD2kutr1pagxHTzDV2/J4KkV3tst/0Am56L+C8f00W1G/o1zG+Vly
C5WkdlewN28h07Xvm1hviAnH5+nIqWiFpLUi158tOpy2UtILNJZd72FOtPln0wsJ
bbfSOjS0XfUa/r8/t9NA6zWdNJ/TEvkEcHMEIrmsp1E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6460      )
G1t+Bfm962jRy1SHSNz5fuwY66hF6D03jVP8U2Hjo9GLecZmdpbaIrnPmdg9Myrl
bQ3x0O4UwUZdOIt/6Jl8wCXRItiKR3T7GPY9GC0WhJr+vUtI83OwmkO97W+W0gSg
`pragma protect end_protected
