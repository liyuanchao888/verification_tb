
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NfU5K749Qwt9C+/9buNmougP60o2D13kGO+ssmINoCyGqPOkEcCrcAfOXRqGjCND
/dUDxtixSI0oQJ5HCPoUaclTsaepbxSv4axYj6iesXFMkJ5etFme6WmbgXYR2FG+
/agxr7p6MmSf5A1bYIF5y3nLF5Y/tVzIsjToQWoOOok+qeihqynFbQ==
//pragma protect end_key_block
//pragma protect digest_block
a1FygvckK5QEts+TzC2HUlCmk9A=
//pragma protect end_digest_block
//pragma protect data_block
ntqx7fjSDVH97YThCY+LEH9r9VAPNF3+sKJbdxqO2nbtmH7YXpDe7Kufj08UR11n
vvjNpM/BLC254qVtv6wa2LwmRT+F6RiO9ErhWagyNEcMu8Q6XO6dcqLcZ1OwPTS7
T4KnqE9utrXQqyQbYGOerHTp5QXQrqqbGhp7ClB1lI96eu75hYZ9/50BD6URUGHQ
SSLuXgMNfa0Zoh3El7Np3soRFdoMDEuPo1F+XkpVNtajYHO143IDaVRA3sE9cZNL
Ir/UxG684QDrglIzlRGPBP21xkudF0SAq0+/dQ2nwB/gLy4uJ5oDEfhORnBlvwEc
nbypg+TkYwc9mcoz2bFkL6GJ3LPs8zwnyPVT31RT8pppVwCUUUd68DmmlvXP6aG9
KnDB9YQ8qOmPYNYbQXNZXq1prQD8CeGeP2LmHDGuYwsF/1sHPjqkG7P61LW6GmQJ
ASXnq74evJhuIHLpvumiomrhLduEfoXad8+inthDJdC32hZ8XmW12bX+2EVUpB6q
k8qa4Kyh0TG1MMSuydIU/WktE8f2BxSHyQHWC403I8sldEsJ/kr+VGlERru4v87D
N2Cq7MJ+OwJTC8o7u/24oZm8bes28vzyVIElRtiZsL98FjuRAc0agqUMAHDbh+IQ
4OverJwjrGMS3ekaz0DJ++6I0gQ37K2B36of014782n1xFIMGnVT2zbob7Ofl0PO
TPDHqwlyhOcW/U1pXl1UkPdYJisdvRlleH3Cryb7aWderTgL8IRb18knGnvD8DSH

//pragma protect end_data_block
//pragma protect digest_block
AV829TZzZ7ueLdm6XSuDu3djcB8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w2iTfo0EWvWi8m/HWskU301VWRJIv3ZsHShAiB/v5ujYNvQLExPiDcv67XKEolAY
kC41puDsHZXI7hiqtkfd4aNqtMA3/BYUv0C4gYyEEhaRj1MXA5UnUQqVP2E9hYQU
yPJBzq2z5ycUjQq9fTzFidaOiJj9i8qxFmzrqlbg3lTFmbXtezivfQ==
//pragma protect end_key_block
//pragma protect digest_block
lJdxvaUM6jlIZ1lOyu2RIbDB0rw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
LqY5L7friubulJ6yhaee4BtVbw4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_ADDR_RANGE_SV
