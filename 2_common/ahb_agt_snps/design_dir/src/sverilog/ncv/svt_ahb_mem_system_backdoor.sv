
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hyhSif3Hufz/ogcM/hCo2Z9RRSq9lYwwP65hlz8D0tsY9Ci8NO8tNCAT+WYL24Jo
mbbiBzsOVajkq5tZc/KQQ0yEElE50OZaKXVcqdLWubHnYnVJjIfmE7xIp8in5NmR
V/2XVO7Z6bnd31n+fIkImHZICuBXZ6DkXnJsJb/L+5hVkZs1FYBeSA==
//pragma protect end_key_block
//pragma protect digest_block
q7eVriHkcyDPhYUTseXhyFFWtic=
//pragma protect end_digest_block
//pragma protect data_block
dbQRs8hh4QVGJH61Ny5sbvUq3F5lbrAOWHPhfg9oIgp2bOeZViSff8XHJvpqiKN+
YW/J60eeV4PXiUgrJbMWi9E/ksRCkgf0NsT+IoK6KtbHTUNxFakTX12vhUk4Qngd
APowMo7MRjjWm4Aifb9/DXDOApQEXNq6wzKamK3rX2oVAFVwgnqDZU5tvG48VTvB
qdI5FXWDP+7m36Iw/MNCi8zxfCSiMT9eYwMpnWocJMSjQqbuus3DSJxWDNsCllzN
Jeghkw86ReCIedCMulecHe32bqBlT4VU1NYKIXdnwyAXROwRQFvTvo6LeP1SJML9
jughUVIVJmIy9/s6+wVTfQIQhYPZQQqtAlC3KEFvFhZJwREGGJLUFdcdMwn3yh/Z
DPBzPOsRFRq32GxznbwYSYBE4403W4+qgAc7ee50VwCJ8hx3/C/t+09IjBsooqYQ
VaYb11GzS16827tc7xhCL3cfyYx8IkqVXqt+YN/2jaNogHYBnyTczccuo3CaR8Ei
AosqyProm/YOuSowzjmjKqNU+ycUn9GAfKDnD3gsrBypR8KVp3JZcHjLRSRCXBq/
d91Gos3XmelO+AoAR7MsWdb5HSWzXnXktnD/XAW8jtgtnlb1g2uEv76b9OIa0fEk
vIdFnSh/FD47PjRzgbcYocfmK4vmUVp8R/uoY4Fd1VshkzdoUNTF/ROYroGm8mzb
0wuLluUW7X3Ym8nJH4kjU9Tn5xpefg51tCwlc0A/TOh61CXof7/kf2q7IVByDTLj
JOpfoZ2urZJcRhYYSFIL40DZRdjeFz/vNyqrqK5gw4D3n45Y9wz+6F7eWzLBEg1Z
E0Li5cfeQoagy3T5Ng8yYIkbQ0jlLKUVZ49UtrXbL7AurexL2soTr3UVAVdxWyu/
BEAAqx1h/WoHshBPEPOWwJk28Hoa7T8Em2dfnH3zod3qtOvO3eN5QQCs9SOPN8pE
ZpmBC1tekMO/S+k9SNTdQryN6G8UfDLOJ4zyQLg75V7N4eiNotmpbk4j725zgJNA
ITOyvqngNsOP83B1nRHvna4hmwSgV5elqXNxWEZsQdmkzfMQKqxitf7xrzPGL1aw
VXvV2XvtpLfYJQnlfWM5JThLrIwBfiTfw2tGyLkq1IULXIBPWRsW5DF2j0u0jguR
qcNuMPirnatui9MKflXhKa4WXiDLSbLx0j3IHuVqORqa4/efvsKOd13TjV3xk9sZ
fGc+FBd02zRzutH/D8re4eW4j9aSsr6rle8L3i0q8Kct/sUaF3eMLEMzVUu0Nq2D
/hMNWh0iS2NHLs5MoWD+9HQ0iv56UrHdoPZdx+aaEWhQDG+CVwg65L/KFbCOR28t
EPev8AP+63IkNn0wVd2ddJj7/R+LYKY+FNZQH9aYyQs=
//pragma protect end_data_block
//pragma protect digest_block
GGeJ9PSED+nMJLIIi2Rc0hwQWKQ=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CfTSmiEJ4R7EmoB8ZkZ7mOsjip+M237OxtFQk2TjXUvxr+V2eptk/mbDA9XT0mGs
YMahw3TWED8vwT6RJYqGj3mwMYCz/dJ16kFWnxEEjX+MPnGLQ1DKFvAb+OIn90up
TsoQloMGDa94CCGnXqV9UjalbNZZ2UOCxrWQMHa6yTuRw+tnK/ln+g==
//pragma protect end_key_block
//pragma protect digest_block
35Fg7f3bYPGWsSEfX9N0VVg/RT8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
luoZi+vaWW/sc5AZvZTHGLm8VjE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MEM_SYSTEM_BACKDOOR_SV
