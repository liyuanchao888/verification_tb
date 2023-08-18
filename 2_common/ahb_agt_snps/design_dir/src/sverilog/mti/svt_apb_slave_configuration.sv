
`ifndef GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_APB_SLAVE_CONFIGURATION_SV

typedef class svt_apb_system_configuration;

/**
 * Slave configuration class contains configuration information which is applicable to
 * individual APB slave components in the system component. Some of the important
 * information provided by port configuration class is:
 *   - Active/Passive mode of the slave component 
 *   - Enable/disable protocol checks 
 *   - Enable/disable port level coverage 
 *   - Virtual interface for the slave
 *   .
*/
class svt_apb_slave_configuration extends svt_apb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_apb_slave_if APB_SLAVE_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  APB_SLAVE_IF slave_if;
`endif

   /** A reference to the system configuration */
   svt_apb_system_configuration sys_cfg;

  /** Value identifies which slave index this slave is in the system
   * <b>type:</b> Static
   */
  int slave_id;
   
  /** 
   * Enables the internal memory of the slave.
   * Write data is written into the internal memory and read data is driven based on
   * the contents of the memory. The read and write into this memory is
   * performed by sequence svt_apb_slave_memory_sequence provided with VIP.
   *
   * <b>type:</b> Static
   */
  bit mem_enable = 1;

 /** 
  * Passive slave memory needs to be aware of the backdoor writes to memory.
  * Setting this configuration allows passive slave memory to be updated according to
  * PRDATA seen in the transaction coming from the slave. 
  *
  * <b>type:</b> Static
  */
 bit memory_update_for_read_xact_enable =1;


  /**
   * A timer which is started when a transaction starts. The timeout value is
   * specified in terms of time units. If the transaction does not complete by
   * the set time, an error is repoted. The timer is incremented by 1 every time
   * unit and is reset when the transaction ends.  If set to 0, the timer is not
   * started.
   */
  int slave_xact_inactivity_timeout = 0; 

  /** 
   * Sets the Default value of PREADY signal.
   * <b>type:</b> Static
   */
  bit default_pready = 0;
  
  /**
    * @groupname apb_coverage_protocol_checks
    * Enables positive or negative protocol checks coverage.
    * When set to '1', enables positive protocol checks coverage.
    * When set to '0', enables negative protocol checks coverage.
    * <b>type:</b> Static 
    */
  bit pass_check_cov = 1;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cZsuo3nmWgiNJZAoQMHr+Ky0Gcq3/uOlMmnEV8XEDvHa+X8KoudcrysMcUhqXOJT
iOj3e3MpOnGTAQ7gV5xofcB9PkcDofkci4/QuWsjUkvKAoxsZmNaEs3L1Nr9YmBg
DPbSAdSiGcp39POrNW/0ZkxsU3Hl+pMGYMTlJcYQkqM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 115       )
wL9ZucJwNn1wC3yd4jAQtkbUwtlQF5urnr0lDqxUt2vqVXAT10l7hifXFHyqv5SZ
l1FlcxtI1hp5V69Bq7gNYa7RqAKrQApN5z3Yd1bJNp6L2H9mkV905mhs2PlgiPzh
p1SLknDcrm1k+7cdvJ1YHsX/tvsu0ztHhqstBQLNshY=
`pragma protect end_protected  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_slave_configuration)
  extern function new (vmm_log log = null, APB_SLAVE_IF slave_if = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_slave_configuration", APB_SLAVE_IF slave_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_slave_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int(slave_id, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(mem_enable, `SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(memory_update_for_read_xact_enable , `SVT_ALL_ON|`SVT_BIN)    
    `svt_field_int(slave_xact_inactivity_timeout, `SVT_ALL_ON|`SVT_NOCOPY)
    `svt_field_int(default_pready, `SVT_ALL_ON|`SVT_BIN)
  `svt_data_member_end(svt_apb_slave_configuration)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the APB Port
   */
  extern function void set_slave_if(APB_SLAVE_IF slave_if);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /** Extend the copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_slave_configuration)
  `vmm_class_factory(svt_apb_slave_configuration)
`endif
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ix9MCcIHw3DLoWQI2SUAK6ti4eZ1GJKoT9IsRVv09KQWzYLTpusWohNqileGdAAQ
ll3suADyS2cAx1i5m/8BapmUn3ikHeYltxCbGRtW7g7kGK4T+GM8IAIy+JhJj7DP
jJZy4z+3J2ggjkx67OnJb3UBdkUOqwzRoL+Nam3G+aw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 706       )
v3MzOaLVONdPA817t97cDxMfp6tupvBIDUrtbi7Ui/KaY5uxFp4Hbg3bdI3cx525
KHw2IGJzIZIkaWyM8pU4AWRIB9jkZ8K5wFwIrbQvPPrUxEvw4u0jE0aihQjc7Pvp
KwsyX7FkYfXpQBa2xi+jhKKmgT9EDuQbYq7VU/EO9GtMCyrw1vYUSzgCxOZdBpej
GFdbt/CMOZdlehmyLUlrX2ZvEROZMPXFF9kQSi9IHZAgR5apTU4G4ohZKmPIOJ8X
b6qoFrntAnP3FpaTsFcbQt4WBsg7GAM2VFjheM81/pq/62F2afF+iP6XDgIf9Bui
raYSJpzJEhMqusDqiWpJSXPElLuZeZQA7fsPHgob2FoWrb7hvXKmD84Xh0CLUziZ
ArSnAGQ27wp1jdpZgq7/qqeOJ8AevasFtYz/MgvDu1N6Kv3RpsqV80gtU6+GEdLB
xlLUIZgFy0gsu7+cWBl3NAzNdz00le9eUgQKKAzymZ0G1hMRvOHOP9Zhej5r3peQ
ypFk/ELFCHwArwzklgPUT/iPQcLgI77HCd8viExDhn2YBq4PWqhMmvfjreiUuMUh
VekIjA71YHsIT31QpdvklD6+lhslM9vt7kstMBz/ICQvDRc9OGfBY5stmzViZVCU
O3xisE7dE8XFVSCKDAjOHezriQc8bGaFdXKAZFQF4F0AB282OtVQCQ84ieDxttFr
Ch5okCnhIWRUBJeNPaZtR5KVLTz0xKQPdESBLgY1gQKL3nmpzHG/dUIlOe+Gu2uw
TiJETHtqpQKJGjuqoBI9vg==
`pragma protect end_protected
  
//vcs_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
beYLBY3Kx5CaCpJEgo8tEttecEiyDag/Pu/Ojt7LmlKfZsNIb59N1m7WOE5Tw+Zh
hCtFZ3vD/dbBUPEf0fDQrMfswL1cbX0rTZt8u3nohySyozmt4zGHivWR/16o2PfT
qgpp1gL/QiC1n8FL/7Ax+Sg4Tx2hjshBgphKUgWJp6U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9016      )
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
3wztl2RBq1QJNdwXZLaTiQ==
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YFNPpZTHo6xlHdJbCgGmTrmUzCGwr6f8+mR7Dt2v/FR9773Eru1Pa9GPK4tOVsJE
6LQOQoXPLc72+PnFWfmsRp8hbjuD19ljlZi2aFHeOpFn61OZy2izKNG0gCC9quD2
1HCQxWG9MKG9iz5WDcj94541vrUqDbAZmKdjiPdl2c4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9286      )
PON1GjFoAugBMAXD+XbGvkv1oRE51D2gl1NDOCcXxGR4/Ua82nS5mMyihjSKTayj
GV64DWzXDIzGApiyqeFUjp8qDJqOjI+ycAo2aRE5jT5KlCXe7PlQO+1/gYySVAQe
wcyP2tf90bT40spk76hZheqRl3fM7sodkfkEGvcitF3Ex0Qqek44CbT4QBEf1mXm
bH6gjkXSY9O2hJU0i75UqQBxM+zFN0WunnWZD9O0nUcMg7Gh5bkzTfdYRFWqj+5I
yB5ujJGBSZCk9Pc0xOSJXgzMprmiXofEyHr2OmSy0WGdRZmZaJ+OXrAde1q/NCWP
punBnl585z4zmMJDzi2ZSc8FwNP9VwosA8YQB153hQA=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NB8P1uDkK0clCTxIAZZOWCsMAMihLqvGwuDG+bjMROLCc+dez3mb4wUbbD9fwU8Z
HOo1XrZXjJx/0nWv8c/9GzgIXj0r0pKtX+1pNwyIy5PQptXkvi00rP4MMzFiDVnm
sdipFhrzTB45hHt3xznjbB1auRGIP4ejdGq5ycumBSI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10533     )
9RhpD1qqBD5zL7CzJOlgfNbCP8JVzJAvFoaeUlkmPqaPWbXOTxOjviq5TBCtndo1
8g396MUjTZ3gf1lpiAO//7vgOn/kyjUK3Hk+/JcGX6mQkfCSEqPJIHbniI7eOPqu
So7ZEqphzrxCbBUDywt/d8+ERSvoPxjTfG+DZ5j9BHO1kcXkcwkRBAzc6/+kTLCG
z8CpitpdmiSMg675Yenu2CaWDOL/EvjG4AQ1UW1nQk1YyAZKH9AMHym2WET8aS0h
nEVZ138Tkibt2ygAfe00KpAhgkXfdYuhauweTdsxhIpOFmpbjvyXjwOAAsiyS+dg
S/3D0kMHY0ShGZm1Pl8bDxkfkvBfNgVHypw6M82nLjeDUVKNH5qAIQFzCyJ/ljKT
Ie/6FKoHMQh/htJsVPfUNKorwyGFs998Bis8MoMEj3ke1hdNdBwZpsI8b5NOEFk+
2lEpkkjQjBZ+VLujvAKyt41HNMrXMZFh8KAK0klswxeohOL2QbpblKsVgD/96ffX
XCMn9us7GdPqgQvm7asQ9OzhTHEu6rmdL03czUq1MhxJZzEZ3NeCu6PAIuzjyc3g
sieY+xi44DneXL4U44gEHWY5yVfCcuzK4I8MIyV9OPy+5Sb27GcD/Q9oEE7J3j8b
Qh0s2FxqT2I/ZT0CrPDtQKhRPOl8+hwU85ZTrTs8wF1xdEddCmJFI3a1t0rUTyJf
ED19xzMYN1rSpnUiqu02yeliJQYhRHDctKbW7FffzNHavv1Aq5c1EgNaFR5mjlbB
gJIGNooFJDpjJ9a5eEyyjaI5PFoze1yGuTFHpYss/qT9WaSrmzxploasU5qjyguZ
Rkk7+G/kaeppvnZFcYdCtQl5ZEIg1bREYZJxZWWde1+zZyY2Or/F3DNppcZ/5c0F
L4HsmB7EhA5d6+nDP81JOoNHSMudyiF9bbwpFgSpTbYUDEqOOd4cY5NP3gRf+yYn
iA/PC44DaD9Z0QoiaTmodmuWxvvjlZtuuFXbmfLsyLr8jYkMeepxx+OATzThei8b
Wd8gxwu+9djmf6OA8DXv9GqMOu3Eo4rEbCwDGxAZi+PavoneQWKjOrldsso/K6OF
jPrIBSyBOBeNBuvgOu7uH6LerCK3ferTbun3Hld01p6mWS6mSEfWKKlKy48H9YbC
UQ83/KS2GB60HYhQHPrjwxV9T3ms9rCnaqaaRmHYZhIAdlkQmOwLdYD95CvP3OPL
g4UtSTHRxtnGr2ZJweE0yXKr1vn48can5vISoP8YL7XpCi3vQbHvWDSrJ/9Petir
/x8rDhSEhYQqPjm/Eei+uR2vJLeqXUHa+NMnVf6cgUYqPKRGopK1xUa5KFwiJpvd
vYd2cHY7IjblqxknouN+/U/9HqilQwBxt0PfAAozUM18HAsS6WueeDV5RFtOMwgW
w6fdM/xvcrpfX/VW/YHpdKjEnzh8tuo5ZcVgtbEmVilfpoq1BHArsnUMcgu44Qrs
FBMzaI22QaHkKx/sDwK5NVSQNnDVr2OSD5xJBclVzlIQVzsyh2fbi5g4nCrfvuoM
3psOFK3ziIJYewB9F0Rwqzy1KynjljLxV0tRpuDYa73m7L3151qTcaLMIGcL0ZXr
PVK6jwI02f5PdPFMJxnC6satyl/D0HZcVPZb5kavZgUX3lWoPRsm9MwSDKwun8T2
`pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gYHZFp85g7w80FA0bI2fqtXE7uhtS8hg9hwuSAhLNnKYMVi878C20MDjsZf6Pg13
MLLOux53cZTcRoUFlALfhunTHnKg5oec+UEBw5//ybyZKeyETSnc4yTufG76Atg+
2Vno9iIzbSWwpKircN9uKwiobQf888vjicyNMt2DT9k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10616     )
KGfgOjQPBYdbRUad83MPylxeVs4gTPyM9qIsf1NGXByYl7GqNEY/Apjh3nlw+EJw
PhbJJBnn15IWIZWmGRNGOR4IVfWLbRranCnhMHyhO0Am1GjDz+lfIR24lk45Xz1x
`pragma protect end_protected
