
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FLzZ3Ec81TSn/p1C6ftCegJja1S65nsL8xkdvO5rX00hHnehzI7fZvGiuHGiPWbT
46hkWyPfR5kIyIQ+itLXNEu3ccPBKjPjWFZ/6PN+l3EH5eD9MrUpX3RC5j+tEGW9
eW8w/F7Dci/LMDNc6mfrt3xFFLWJqxMPem7yT1rGovM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 454       )
5hg5BvaCauBJEehcK9jgKegN0nJdfa9eaa/bvbO629AgRYc5sVO+cVwrxn52zXUX
XVKdJfJp7azajQsKalpKBU215QSjT7UU0LmddbJ0USocTXVO99LhJi84TPiB32n0
Fe+/jyqxIr+3vTSBBSnVzJZudbqXcFnpN9WSxfcj0ZvY+MW69W9Jtvs0ArzR+rB+
TZfGjnnKF7hcjLcK9Ha1Zz7k9R8L0Bzx7Jvox9snZIXrSzx4DTf2YFkuUGzkG3ly
9qnC3XiPsh5QgMyI5UhHtTGY2Q0+UkjTm4XzBz4n4M7bl89IwXrtuHriCddnU9dC
Q7MxpAbI5tP5Cb/Ijt2XY9PWDj2bQXisfGa/zu4/ufS6TS91jGeqdrL82UxEWC6u
sE9YaGc+smzxHaCQBnXn+R3sxr8zzq2kXIVwnMFZymSyLXkfAzjxqYkVyPMGtdN/
ayq2zaXapkgQId6N2m+fFFhaa5VLGdqkwk0oHwIUYFLdIEShItsPzKEj6dMHmJuV
Ak+zJ8Mx+V3UygEfPzOKCkvTFXKIcTeXn1rMWe6eSeF7CNnFdswJSl7RbyU2EyKM
FDTCUC0plI/6zP0NlZTqFm8zvd8qB4J17MNNcEM5iJ0=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cbQuOD2f4TuZudNinymTgp1YEzyu1tS6ncski5YDSLSi1kfnn48Zxc6jYf87jgVP
cq8exd5JWY5dCWonEZrD29aAjMK61IZcuB9CRCMAb43gdQc4CX336lO5Mnw6XLl9
rNMpm0SeOUQzgTD7WNV57Bnsk4faQRsFTB8QV36lBOc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7992      )
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
OA1OatRqEgITyqnMZQeikQ==
`pragma protect end_protected


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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IDowZ1mQm2v08IaE1QOPWPQQso9PTKw5i0FUmJgBVCptSSe23vzzbuEwaBdQwOd4
aUKS2Yfnt2VOaDkuV/uX9eqg6l93/lXNzL8EBM0lkgQZcaR4XmEav0DUUB1slYR4
li1MUsaj7tbgbavWjpi2365Hfc0Uxm4yba31DN6TdAk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8403      )
zVbW2H1dj36hqqhnlq0wXPKS1w3nzGDTznFqb1YbrmhYp96EPs31j5mTmsNaiup7
SI6dsTun+Q0fLUOddY5jBa+pFX61zCn2D/BquLzPBk3Ytf3WPSNshqHfxUlw9OcQ
eFxPSZg6CciSCae8eWji7vpB5MwszcAp+KZJ/B9VZsU0hZcR/0HmOrPfGqvXgwTG
vsnUo/iiRpBp/WoPAJwCwPSUKDe6Zu+WmaL2Obvxp+oX/bBfB6zWSt8IvsARsaQN
ZNTVpQeIyjJwU+eNqlI8+Hr2QmaADVnWqjtYMgRN7KkAqLai0URB19wgs2eBvlMQ
+wUO4TTz6lf5tXmazMJJXDQ9HVcVhXiYvxVXXZY/0X6CkrTbM0r7c7yfFAKGNeNJ
x2FS9vQ0prFlGe8+tBSgilJSiSvVTdB/mRRIdwQHnxDrVsH0BRa5Pv1/DIe4wek+
R6l63Q0YcP4ZWB+IRrSA8DlHptHSysjLgLfobD5VCP6Q+mODys1//eVqwuGxzGqA
0PX/webRLL7eHhBcAlNLG0h3JsbA0keAgzYGPqol0AM=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BRI5kXfp0l6dtVZtT5enf5rYC6VTHbanCZe87P+d5Ql2TiweWCUyw3qk7zLSNkgp
NzfJnNBDekRIbkD946o+yhU5c1rzDSMfXyFwbDm6UhtKtnHX9A0s7i7OUufhfRXm
WjQSlSyR2lca6e3IPztjCQdiClxor8pbMeQF3SeuLgc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18476     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mw+poe4Wf0ia2ZNFt7Sl7D0sBqAHx5YlTTfRNxCivAGhihtFqWl3yW4/DrYAxf5t
0y1olY96/T5D9tPbm4eUEd9zkDLaNRXiUGXkp2xwisxbvgqst93Inkw9O5ltnxCR
vrM/nvb/p2qKD+1oC/e61ni+bLdcjkSTWbrOtJgLhvE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18559     )
CKxlOZNVEdUIqrPdekYS9e07YtgFnCIIDmBz5N5027cptV4mv36kWb6iQVR3ftOA
Jg76V21GA6um82hjvgxcAw97InnhtgCtKfsWl8Ia7LSbIdOjkPldbFCIhOZFVLn9
`pragma protect end_protected
