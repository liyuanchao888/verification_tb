
`ifndef GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV
`define GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV

`include "svt_ahb_defines.svi"

/**
  * Defines a range of address for each HSEL specific to single slave identified by a starting 
  * address(start_addr_hsel) and end address(end_addr_hsel). 
  */

class svt_ahb_slave_multi_hsel_addr_range extends `SVT_DATA_TYPE;
  int slv_idx;
  bit [`SVT_AHB_MAX_HSEL_WIDTH -1:0] hsel_idx;
  bit [`SVT_AHB_MAX_ADDR_WIDTH -1:0] start_addr_hsel;
  bit [`SVT_AHB_MAX_ADDR_WIDTH -1:0] end_addr_hsel;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new address range for each select signal of Slave
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_ahb_slave_multi_hsel_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new address range for each select signal of Slave
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_slave_multi_hsel_addr_range");
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

  `svt_data_member_begin(svt_ahb_slave_multi_hsel_addr_range)
    `svt_field_int(start_addr_hsel, `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr_hsel, `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(hsel_idx, `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int(slv_idx, `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_ahb_slave_multi_hsel_addr_range)

endclass // svt_ahb_slave_multi_hsel_addr_range
// -----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NjhioUVjdvyKtTEX5p+Dg4zpYUOewlqu6e3Yfkguc9xFCvoY6yqzgpHFMDZt+5T8
tMkwDfTmevzNqKuKpo5Uai7m/f6qHXvmpDNz6I7+o9VSbEOjSY+951Pv+rLYOK9i
eq94xznpZgvSPwnAIAolWM/PlzqlbIA0NIp61A+G8HsaA+y3eaz4Og==
//pragma protect end_key_block
//pragma protect digest_block
F3D0idiFboJQtqM0ysk6zxraLTQ=
//pragma protect end_digest_block
//pragma protect data_block
g9a13WSam5AnHaq3ipGWER3uwUQvhgxrmiZleJQfXLpKbMhjueRcbP/0rMXy6JEb
mmwz/aizD+BetaOmFcYzH8h6Z9KI+tMrebFn9TbM4usCV081bxk8ABR7+mAXWri3
rfdxgSer5NvkToZ/I+mnKLj5VJQJtxjnHTA2UdrEkcSoP/LvtiX8/RCTxViSQaOi
Q3nUVn/5rzZNy1lxvFj3+rYGGTzVF118YODkiRP+ltTPk7FyQgiqpHMflUlWGNGz
J7QtxXuxYc+Ie/nkXwmNvVSc+qpr39e6BEdwVo0UpVMb6+lLCHD1lCmc+wrmarrc
Oe47pHJDOb0cUrp0rJkAGQK8hqV44y76HJvwdP5hLgPMB90lHhR7Yk3VhPwf00gn
HNilHOIjK4ZlV40WOcm1YXM+XUZ0WBtx3e0p9demWB5oEKFWqnHKBUHAdIoRz/SZ
MQRMAheaa8peg9knBOp5RaFLtUdqdfSHdfxMppi0coGIgNVkqskCyonK7LVPuMld
G5tpqrnawuPj2OXXxqKUXoCk/pBnulzyMOaTZVN5/WBGHt3pgeqeNQ8nw4NPRxXO
QAZagnqLm/jsdLCcfBa6xzSrTcl4mT2HNiYnyGtevALZTCMWrIph7BmsxWAGKj6i
jV9ZWshWqCBFic2AEwFZd3NykrXy6J/dp3hXwOOuxPOgaBJcdpKBKbHnzjQcz4nR
FS9BrYSaKrtNVJrUMA0Oibt6sNH3xCezXLbV09vrOgG4HFUIHU+Lj7f8Zf/WJ9AL
di0cHiHsW8sVhEM3Hg/lWmjPvWslVgSQOWDiBhU5WdtmGXDilEGPdCYIwtEMzcEN

//pragma protect end_data_block
//pragma protect digest_block
tC1HT1Mz8HYFrpp2Br2bLKjRvHQ=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YWC62psQnTED/jWN5wiwrvvy4z1veXxPEUCYnj3i6fLuBD3s9h1hxlTMZJrCxZdQ
7kuHKgqSocBtpQzjuCsWxJKLRV0jr61n+xgeynxbyzMirIaU8uY3PChuvW3EmjJG
+pYuMX9Tiquv4R7B0EtrCs8VUOl/1pkQ0uYVQoru7eh8S8TV00ppRA==
//pragma protect end_key_block
//pragma protect digest_block
AjtbkSDqENr+K93JohXj5VWBW1s=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
sbdkWOEvyzTx0AtztxHLUGbPwrM=
//pragma protect end_digest_block
//pragma protect end_protected


/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_ahb_slave_addr_range extends `SVT_DATA_TYPE; 

/** @cond PRIVATE */
  /**
   * Starting address of address range.
   *
   */
  bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] start_addr;

  /**
   * Ending address of address range.
   */
  bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] end_addr;

  /**
   * The slave to which this address is associated.
   * <b>min val:</b> 1
   * <b>max val:</b> \`SVT_AHB_MAX_NUM_SLAVES
   */
  int slv_idx ;

  /**
   * If this address range overlaps with another slave and if
   * allow_slaves_with_overlapping_addr is set in
   * svt_ahb_system_configuration, it is specified in this array. User need
   * not specify it explicitly, this is set when the set_addr_range of the
   * svt_ahb_system_configuration is called and an overlapping address is
   * detected.
   */
  int overlapped_addr_slave_ports[];

  /** Address map for each select signal of the slave components. 
   * This member is initialized through method svt_ahb_system_configuration::set_hsel_addr_range.
   */
  svt_ahb_slave_multi_hsel_addr_range hsel_ranges[];

/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_ahb_slave_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_slave_addr_range");
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

  /** @cond PRIVATE */
  /**
    * Checks if the address range of this instance is specified as the address range 
    * of the given slave port. 
    * @param port_id The slave port number 
    * @return Returns 1 if the address range of this instance matches with that of port_id,
    *         else returns 0.
    */
  extern function bit is_slave_in_range(int port_id);

  /**
    * Returns a string with all the slave ports which have the address range of this 
    * instance
    */
  extern function string get_slave_ports_str();

  /** @endcond */

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_ahb_slave_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(slv_idx ,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(overlapped_addr_slave_ports,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_object(hsel_ranges, `SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_ahb_slave_addr_range)

endclass

// -----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TlDIKMdw9obwWh1FJpzQTbfRUmm0DKFn59jkh+fad7Nu4sIgBBxAcVh5RR9H/r+B
MKf4DXM4r67BNZ09AIWnBz+WnT0lFVzni3tAIIDFmLdkFBDCIi2oUFRTRMeumTuO
a9pnaopX4dDk0P6izYK+fYEHpdKD2YDIUB3r6NRKQcTGh+GR0UsXlQ==
//pragma protect end_key_block
//pragma protect digest_block
GeGxfoBh+GVmPVIT/tvx1AVieGk=
//pragma protect end_digest_block
//pragma protect data_block
SUBFWgHd0PwIk+xteOMYRkJmNWzGP2kbrFB/wZH16pXJuQ/GU60i6lxZd5s73o5v
IwsQqg5JJq6r+oe7CJMU4B5obQuwLnRBlHhNlVAp7HdNTLGOR9oJB/5X+AGH419v
qXg7WZppdJloipFdixewnVq1JtbZGypViyD9iBmKvFtgGzecovePjTjQknihovM/
BWtfYD9d2j01qSFf6tOLz0P7vw4T6Sl7Udp4ome5vbgYV/OuA7WDsqqqcjuxT68I
Vn2lDdLzMFbbM7bRt232WyqVcSOPdnXJKW0bDpzDOLXVpfgtO6P2bgtbZHGJEERJ
6OmwQF9HO82PacbIkfX+rQ/xi0qVWiZcSF0TWOPEKJsOe+NLQkXqr4P9Pujp46wY
6d8pYHvWp/ueKO6QQOlz6sQSxaf0GNS2zkXWVmV0pNkcrOpqpXRe39n5PvL91jNy
jQ80NZ0S53pUcXAAAf4j6Zkysct6YSL+xsQS9D59PebYXnE8NhILySrJV4ScPy1K
u0AjwfJkXE+l1UY4ESqIgl0In7ssjjyoNEUXNHAZTqZKPuJeowKUfsXiUwVNR7Nr
vkAoq3/+zvCWqLyW06DzBmBrHwZjot6IlgLNN2QoCxV7a3HA+a0HNOUbuk0De8ud
59EnVYjxsc0ZIvlugHu/YIdJVHOA1yqwPc3LhDM8ccUqJmsK84+FpIVmkCCMar2+
ePi8wC5vKTdjmBfGd/J1ff38gmitMYCnYo7q40WTTOueoEmxUELx7ekWLUJ2Zi6P

//pragma protect end_data_block
//pragma protect digest_block
ZWo6L7KUgmRbeu1918+njdixm4I=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RSJok2zKAFjpAN9J7WbxlQaDCsdPhUtG2bwRzjCAEKeTsHDfW51XhkzOVRxJEmRF
7FRoHAv6EDOCSllwWWQVK5d/eGgd4CqXdORkQAXksiU0DwagTw3unYuiWy8AQE8S
eUoqaPLkYB5Zle52oy7qaRJWnO4qUeQskdubBvMt54aBnD+q20toLw==
//pragma protect end_key_block
//pragma protect digest_block
uUurPJi08A0Z0PlE3amrIz5+HHM=
//pragma protect end_digest_block
//pragma protect data_block
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
SYFMxIUW+2RVNvtD0yKA0g==
//pragma protect end_data_block
//pragma protect digest_block
mnErPUrBcf8qg3DEYLX6OwQozZA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV
