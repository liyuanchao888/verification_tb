
`ifndef GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_apb_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
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
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
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
  `svt_data_member_begin(svt_apb_mem_system_backdoor)
  `svt_data_member_end(svt_apb_mem_system_backdoor)
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

endclass: svt_apb_mem_system_backdoor
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SHwouHxuadlKiIqKW3MHByQaQhcbfaXBNmTrMMkZwPr4/M/AsQ/EP6veaQSl7Dl3
JiaPu4AvHMl4wBIzagZK9lxp1V4soYugYgdTX85yhHdxXrZVbKYMspn5revuf6H5
tSjtDwCRpI2y28U+Kp0ExxvbA0o3yr6PSlX/y2+vvxJqEhmWQVpGTQ==
//pragma protect end_key_block
//pragma protect digest_block
QJAjjO7XMHCXR2U50ld4g+9DsG0=
//pragma protect end_digest_block
//pragma protect data_block
G33SUad39mcFYPVWZ9CVfOBRQY/JytUPyUFulKIUwJ+njBeVeAcDuuA7w7d7JNwG
jlCLwEKdPQi1v+aEJsv7JYpKElu4QMvdCXnnaIXFIqart+WrZ4P/rVYgmOCH/pm8
knBiCh+9DZKWTtixFsohASmlibicXDwAL7DOg8A+6haczQuI3DrZI8D6+Lo3UGAd
meDSiI3B490buRjpzFIA8OprgI/AfQq8IM5XBQxmcuO0OtEUSNmn/QFN3vTTsV8+
X6kfsLPZoCiWeZfcw393npkvZ1aVvBDWWmDDUOnK0j/wQ4wuYZ0KvreGh/kIFONN
LlRNY5I4IRVn6R7Q9k4AVdoBIYYLA4Z5dAwuB4dC5un8j7i5kz2fDGOsoUAc67vI
/aXthUyujCIIgFGVwjMe/t6AO5wHamzKF94Y5S1rqTkQFAoC2qs4EKqtD11mVHI1
Rrqbes96wNnssadNlTjzaZyuRYHpRQWD4ugdd+oRIG3zLvNj/AdJhn+N3B4+8tL/
T+Ib3Ha6IcWSVWwfz1EqzgsaCQsPfLCHRl+qxE5z4cWojwaO1DTAN2yQCIXT80Qo
pyS1mzlrIMGxv59zUt8fvXw0yyjslRDC6VYqdLA5KM9afbLFLjhfRta+1H9gxMUU
ykjoD/+pnBypAwW3vq7CTP/GMk3Ec6Ah7hLG20Lkwa4kY5SMBmPSzjoJaHLsnN79
iu571hbKmXcFxwbsZMAXWRcAELIYnTmrtPtGmJ+fDkO+R7AAOwdUdJahja16SD/w
x/5jO1aTwQi9avnAKj4E2DdAEHBBjHcudjXY4FMLtuK/hqPI+BgAIdMUCjBDITIu
Uvdo412xGcLnmzSWba+K2HWFKkjRmLGsEsVY4Sykhhk0jrp2prTvYX44sUne6i4x
tDz7kBRgDGcV8/5GLIhSuY6N/BYvXImNvDXoRKQWEfPCe/Y0LemqHQpp9HhIb1ZD
aTnVAHS8LRFTE6oHXH4nWWM3H6feO3ueXlqq9pZVyVztmP9vXL1YoXdmMd1g/y9o
owA/m1BhYngY/KXY5KPitXGy0USbqgpnyG90O4J2fOByJYXY+Q+lYNesF3cqDVaU
4o9/kFDoMRPtMG1tb2Tl4D4UY+N/81/WtbGDEHy6dZ3lNqTDXkRBmnrjKBGfEHdS
lxigF5I9GBXJkRkPkepWJeTCVxgI0gnrd4nkSBKbN+FUKgGzgOl0+InhY2zM02EK
GfcTx0oWW5hmJr88/QdrjndgdL3VpgFxJEIF3ba/zb64jEZXzsyA9UVtJKOTIHc8
qJ1nynnKvyRIZ0OqADUMCQ11G0Na5KikgSw4Oxa4Gk4K6azFDqfQ5OV37KlgeSBi
rWmRSz6SjH6JVjoOD579E01i2LY4YosSftYxdleHitQ=
//pragma protect end_data_block
//pragma protect digest_block
3BYzcvLX0gQtHyukOPTcPhb+3+A=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0NOONdKOs8FReODfwgy9qAiqbM6YOJtMott/kQfpQQwUEMV82KxyoDXohrzxsPYF
Ce1ZqO7V4KfbTOejK0sUs+nEX8AFv3+S8Y+z1v5M0LN/sMi11dzRFk74uo6FfEmx
Gd7ZxR32QPW/0TImoVbQBF47ME+mwvFWBowIu/H6aWqH5rZwR4IFTA==
//pragma protect end_key_block
//pragma protect digest_block
dIysvb5Qw0nudciBqBY2Dcbov50=
//pragma protect end_digest_block
//pragma protect data_block
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
7GCtIvPFOqoypuJIcNFpPA==
//pragma protect end_data_block
//pragma protect digest_block
QrwB8JLoHuqlWCnF8MtrHhbGXWA=
//pragma protect end_digest_block
//pragma protect end_protected



`endif // GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
