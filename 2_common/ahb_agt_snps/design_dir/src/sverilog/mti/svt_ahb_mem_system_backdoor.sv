
`ifndef GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_ahb_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_mem_system_backdoor)
  `svt_data_member_end(svt_ahb_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek and poke) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();

endclass: svt_ahb_mem_system_backdoor
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CDpEsHzOkWRoF6XqAc3Oiun8es37z8GfgQlb537gzhfGmnudN4EqGShE8yLti6LL
8B5kkCX2Y+PujtxwMxsNHsnMMQkkaiy63GZj9kwh6Y96XN1lJ0iIHTP75CHsMEp+
xnrERyDJxwvyW1+1BIoPfBb3Ll3aaP8OjLJ1EnTQVUg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 866       )
3U0ENMEXllfXedj8BYvIWrItsNcU/54WPgIxGPHm//AWLX/P2MvglRBhWz+m0p+5
UQHHTknhyJNw7/W4uvXbEOWY7c4K1IHbfcu4EGp7w0o0KLbgL026kLwmqpKzyEfz
PLGwl/e3h4/cfR0/E49OFtfEyVFjbaYYczuuvWepQxDxBPCbDK5VBKWTX8l9QMV7
m6LXcUvltStgmzJu9t/1Minf20R0siYgTDKodzomJBYthoc1XVEEzCbyltsJNy+e
T9AbBdSSdrizQ6dHHgOwF4SsZq1/sKiqoUfOBLRv1rOLnAxgyGtDtcr5YsWQsz7M
bTmYSfsST96H6XPfGvE4ZZiJD9EO/mbqbt6lN7SyUqL9oGL1U07+g7o9XHRYtYGI
zOkewX1aJeePs+VGcIxgpfxgyNtaS1WOxG+e1US63nkz4IbBqCY7W5Edxqkl7dzj
u6XIbriMGZEVg+mFXD5rSA/zUrvuGfqleVeKMryR2KKjLX/RQ99vFbBT5HPfSqPk
LcdW/RDVmYNTidLLKSZZTgOpzr++mHcYG0NEXV4aGn6RY1WXFNefo2VESWA+OSWJ
pWbvTAuHkpqW6qHp90T6/ejaa7kQoO2T94v4lI8PAuyDcE2ec8/S7l2y11eCcBLl
y/etGHTv1FmswXKp53cZTenpn1Sd4VGpf3/UWmcV0xdAPQf4jRqd9DvqKBw3TTYr
bmbRf7fZzKf2SegcAuZW/gR6SjnEIwbz35xlPn0OKVzmDI38NWAy0W3Ay4OtCxJ5
jGSMoaxDm5b9Cqhl785bgIJb1AYLzIF/0UL274321VYDWcdWxM911fESgdRs7Gmd
yhcCA0uC8jNRch3Pk0OSRM/O/pGMTFMLv/KzIx1mUr5NjgqsgahsD6vk+Ok9t92o
RhP7lzVrJ+aZ07zuxsECN/1TOzRjhfWXvCxOXJhY4FHcUJ8BJxLCG8qao/gsZU+a
x/tQ3N+dxOlldBP3ihgTVIlMNd3Hw155hmiZMIKAYjynGvLvlQV4F5X7DbiUXkx/
rsnDcOTsYKD+MiCN1MtZvrdZxugWQU++Gzc71hy2yP3ro2YgzZeYKyHGwyDRNkIX
+2T5+5q+ejbNC/4rfQJ+gnXSDSmTJe8ODOFcMNEKKzBFY5exK6hq+trPGgY/alEk
aETfY8BiolQBpfhVMpnTow==
`pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C7yOPxz1Un4weyYfzA2FZ+8fRb7kpHN6iQa35FF4YUDCgUctrZ8S2lc1zVWS7k2w
NMrbF94yl3UXJGqiQSY4OIkSboR4MJ/SBNeWWNBzzYH5Uxs5VH/cpM5bkRJmci3A
ud+H3KPTIfg02EFxubyjOgY5F6zuBQcDkamoDN3ldxs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6387      )
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
AEm9K8PH69z5GgFv9gc6MA==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EW73WQ0pIRQ4mpHVD+m3y27pZEIYw8LnIsiLxquvdRDiIxHOJrtVh7vmZvdrL6QB
uJhaMICX0zKy6KYoH9rsl5vVeGz6d5kLuf0Ds0x9YlyoEs+te0kOhWBUt7pbP4r8
L0UJtHB6tVF5imJlBlwBQvJIGKuHULKjT9AexCckfBI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6470      )
ZYYOMDjCbulFj/AZmIllSQ1ax7GwIfg0k19QYeGbSo4QPscnY091BWKK6A/JjOZz
XNXAlHnsuLyI6dfmhtf6Vy7/xk3wZFOeGL94Js/3471QbhZ3Aq1Tbs3K2igIe4o2
`pragma protect end_protected
