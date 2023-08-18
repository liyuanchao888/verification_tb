
`ifndef GUARD_SVT_AHB_MASTER_CONFIGURATION_SV
`define GUARD_SVT_AHB_MASTER_CONFIGURATION_SV

typedef class svt_ahb_system_configuration;

/**
 * Master configuration class contains configuration information which is applicable to
 * individual AHB master components in the system component.
*/
class svt_ahb_master_configuration extends svt_ahb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_ahb_master_if AHB_MASTER_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  AHB_MASTER_IF master_if;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** 
   * Enumerated types that tells the burst type used by the master to rebuild 
   * burst in case of early burst termination. 
   */
   typedef enum {
     REBUILD_BURST_TYPE_SINGLE = `SVT_AHB_CONFIGURATION_REBUILD_BURST_TYPE_SINGLE, /**< Master will rebuild the burst using single bursts in case of an early burst termination. */
     REBUILD_BURST_TYPE_INCR   = `SVT_AHB_CONFIGURATION_REBUILD_BURST_TYPE_INCR /**< Master will rebuild the burst using incr bursts in case of an early burst termination. */
  } rebuild_burst_type_enum;


  // ****************************************************************************
  // Public Data 
  // ****************************************************************************
   /** A reference to the system configuration */
   svt_ahb_system_configuration sys_cfg;


  //----------------------------------------------------------------------------
  // Randomizable variables
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /**
   * Maximum number of times a command can be retried if the Slave response indicates 
   * the command was not successful. The maximum number of retries includes both RETRY 
   * and SPLIT responses.  A value of negative one (-1) indicates infinite number of
   * retries.
   */
  rand int max_retries = -1;
  
  /**
   * When true, the AHB Master drives a "Z" on address and control ports until it
   * receives a Bus Grant (HGRANT) signal. This is used to test that the multiplexer 
   * does not get new values too early. When false, the correct address is driven on 
   * the bus before getting HGRANT.
   */
  rand bit drive_z_before_grant = 0;
  
  /**
   * When true, the Master is forced to ignore wait states for BUSY transfers. Once 
   * BUSY is in an address phase, the following data phase of the transfer is skipped. 
   * If the response for the previous transfer triggers a burst rebuild, the BUSY that  
   * has not made address phase will be continued. When false (default), the BUSY 
   * transfer is just like a normal transfer, which needs to finish both address phase 
   * and data phase.
   */
  rand bit busy_ignore_waits = 0;
  /** @endcond */
  

  /**
   * Defines the burst type used by the master to rebuild burst in case of early burst
   * termination.  This configuration parameter support the following values:
   * - REBUILD_BURST_TYPE_SINGLE 
   * - REBUILD_BURST_TYPE_INCR (default)
   * .
   */
  rand rebuild_burst_type_enum rebuild_burst_type = REBUILD_BURST_TYPE_INCR;

  /**
   * When set to 1, the active master asserts hbusreq for one cycle after the
   * bus ownership is granted to master in the followig scenario:
   * - Master has a fixed length burst or INCR burst with 1 beat transfer to initiate
   * - Bus owhership is assigned to the master at the same time (hbusreq and hgrant
   *   are sampled as asserted together)
   * .
   * Configuration type: Static <br>
   * When set to 0, the active master does not assert hbusreq in above scenario. <br>
   * <br>
   * Note that this is not a protocol requirement on either the master or the arbiter
   * such that the hbusreq is asserted for one more clock after bus ownership is granted.
   * However, some arbiters may be overly restrictive and expect the master to assert
   * hbusreq even after the master is already granted the bus ownership. In such cases,
   * setting this attribute to 1 will ensure that the master satisfies the arbiter 
   * requirement on this aspect.
   * 
   */
  rand bit assert_hbusreq_for_one_cycle_after_bus_ownership_granted = 0;

  /**
   * When set to 1, active master will autonomously drive beat_bstrb to valid values
   * When set to 0, active master will drive beat_bstrb to value specified by the user
   * Applicable for active AHBv6 master only.
   * Currently applicable for AHBv6 master driving unaligned address.
   * If user is configuring master to  issue unaligned transfer as a combination of multiple aligned transfers through sequence 
   * then user needs to set beat_bstrb and hunalign manually and set this variable to 0.
   *
   */
  bit generate_hbstrb_and_hunalign =0;

  /** @cond PRIVATE */
  /**
   * - Description: When set to 1, active master in full AHB mode drive address and
   *   control signals along with assertion of hbusreq
   * - Applicable only for active master(svt_ahb_master_configuration::is_active = 1) in
   *   full AHB mode (svt_ahb_system_configuration::ahb_lite = 0)
   * - Value of this attribute is ignored in all other cases
   * - Configuration type: Static 
   * - This is currently Unsupported
   * .
   */
  rand bit drive_addr_ctrl_signals_along_with_busreq_assertion = 0;
  /** @endcond */
  
  /**
   * This configuration attribute is used to achieve following scenario<br>
   *  Hburst >> SINGLE       ANY_VALID_BURST_TYPE<br>
   *  Htrans >> NSEQ1  IDLE  NSEQ2<br>
   *  Haddr  >> ADDR1  0000  ADDR2<br>
   *  Hready >> HIGH   LOW   HIGH<br>
   *  Hresp  >> OKAY   ERR   ERR<br>
   * In order to drive IDLE during first cycle of ERROR response, one of following sequence has to be driven<br>
   * - Wait for each transaction to complete in each back2back 
   *    svt_ahb_transaction.burst_type = svt_ahb_transaction::SINGLE transactions<br>
   * - Drive svt_ahb_transaction.xact_type = svt_ahb_transaction::IDLE_XACT
   *   between two transactions for which first transaction was SINGLE, without wait states
   *  Also make sure svt_ahb_master_transaction::num_idle_cycles=0<br>
   * This configuration attribute is applicable only under following setting<br>
   * - svt_ahb_system_configuration::error_response_policy is set to CONTINUE_ON_ERROR<br>
   * - svt_ahb_transaction::burst_type(for first transaction) = svt_ahb_transaction::SINGLE<br>
   * When set to 1, the active master drives new transaction during
   * second cycle of ERROR response. The address phase
   * of the next transaction (NSEQ) commences during this second cycle of ERROR
   * response when HREADY is high<br>
   * By default the value is set to 0<br>
   * Known issue: As the new transaction is driven in the second cycle of ERROR response, the transaction is put on analysis port
   * by active master in the second cycle itself. Hence scoreboard issues needs to be taken care
   * .
   */
  bit nseq_in_second_cycle_error_response_for_single_burst = 0;

   /**
   * This configuration attribute is currently applicable for passive master only.
   * It is used for the scenario in which the behaviour of design is analogus to both the AHB-VIP's error_response_policy ABORT_ON_ERROR and 
   * CONTINUE_ON_ERROR in a single simulation.
   * Example: Like if error_response_policy in passive master VIP is set to ABORT_ON_ERROR, the design trasmits NSEQ in second cycle of error, thereby continuing with the current transaction
   *        : Like if error_response_policy in passive VIP VIP is set to CONTINUE_ON_ERROR, the design transmits IDLE in second cycle of error, thereby aborting the current transaction.
   * Active master VIP doesnot behaves in this dual manner in single simulation.
   * User needs to set this variable for the passive_master VIP, if their master behavior is identical to as mentioned above.
   * Set the master_error_policy to CONTINUE_ON_ERROR along with this variable.
   * Example Scenario:
   * CLOCK:    1           2            3
   * HBURST: SINGLE   ANY_VALID_BURST  
   * HTRANS: NSEQ          NSEQ        IDLE
   * HRESP : OKAY          ERROR       ERROR
   * .
   */
  bit allow_both_continue_and_abort_on_error_resp_policy = 0;

  /** Enables the UVM REG feature of the AHB agent.  
   * <b>type:</b> Static 
   */
  bit uvm_reg_enable = 0;

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Cl5Y2UNn+xiWYCmMsepRQFzPi7TfJRWeWy+/wnX2AXXx3XjRwhZ5SMWXfZgDizTA
xaE84uyHYpF2+sJP8SmeRd3eeo0SwkfPLPLv2TyTKIFIfWBbNRB/3VNAVRnO2fF4
bCKYWYWUXQCQhRFRpVnkMHx8TVy2Nnv/JPvVoQHX06Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1971      )
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
wex6eKkISiRmVNIRD0FdPQ==
`pragma protect end_protected  

 
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_master_configuration)
  extern function new (vmm_log log = null, AHB_MASTER_IF master_if = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_master_configuration", AHB_MASTER_IF master_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    
    `svt_field_int (max_retries,                                 `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (drive_z_before_grant,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (assert_hbusreq_for_one_cycle_after_bus_ownership_granted,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (generate_hbstrb_and_hunalign,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (drive_addr_ctrl_signals_along_with_busreq_assertion,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (nseq_in_second_cycle_error_response_for_single_burst,    `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (allow_both_continue_and_abort_on_error_resp_policy,    `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (busy_ignore_waits,                           `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(rebuild_burst_type_enum, rebuild_burst_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (uvm_reg_enable,                              `SVT_NOCOPY|`SVT_ALL_ON)
    
  `svt_data_member_end(svt_ahb_master_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  /** @endcond */

  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /**
   * Assigns a master interface to this configuration.
   *
   * @param master_if Interface for the AHB Port
   */
  extern function void set_master_if(AHB_MASTER_IF master_if);

  /** @cond PRIVATE */
`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  //----------------------------------------------------------------------------
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
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
  
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
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);  
  // ---------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  /** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_master_configuration)
  `vmm_class_factory(svt_ahb_master_configuration)
`endif
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pE58p0zlVgCgrG/WygAl6mdcvBewb2vA9wHCmLdrTqvqdRgYXSav/gJ7YGsCGY1D
ykLW0PjBmYw5XOBXaCOMl4zoXkdjke9GUODlPVKrzAP60E+bcaApojS07EKBB2n+
NXyfThKjmcpOVrZ5H3K0m8RqBRFxHXSxYFXdxxeps58=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2610      )
keMVTHVxdDBcOX/5bB0felXhN0iNncvFI0hsUWA5hj7McNJNdyvTe4Oc0zbGJbyD
0Sr5X39I7IXP0FIAtFeh+wK6jEFqvSB5AEJFjV/YstE2+ke30TfQNU8LpcIIUuSm
5ZHc15pQ4vwzSkcF0FKFK4tQp2QSmVTYtTkb9OSpF/n7bCZcl23qfZ8CiYG9jRzT
Ryz40dwnJFaYMBlZNMJZBapsNBSQkOlTWBYuUojypFbTrDHw2bw6b+Tv/cfVo6Ux
GwXCTWHESQaG/YKzfNnUU6Wx72jyXOh1ljBBEYNKuq0Xq3oPSF6DC39TR21uKzWT
VYt4jW3l5A7kKgO09DlO8ZFqaEDrdn84AjEGiPou61AfRSEp4hrceDV62fPnCljA
zJYzihi2PmG5bfQ1y2SdzJcmcW0M/WHmffFa6qovYm65eu3I6O3Aj8vZlMAM/wyd
uTFhOfFldzfaW+oITu+3jblq1Zcm2yFiG+QDgsQJoNLMg9wFizVVnvqK3xA9rfcZ
FKbEwxXsBm+Ew+MjD9lqivI0ivbHa9Wi8hJnDFlrMo3U6weRb82azTIB0AuzGv1P
0kuNeqjkRvskxGGsicWlVwbaPi4F1Va7anKHvVUlINTgzW2uvEVPF2fhRlCSR8W7
/929TkFC36GCSn30SBgB1FtoZ3QBmJvk7T8aaVtV3XNJRunf5ct4CNyGUNjHpmo8
3qy/Nl7hWaRr+kFnGNgmB0yv/XIMF/xDy+9qRzlKqorQmqbE0D/PGjwQqbSTe3+R
kwwNgYCYFKlvLmeySnlWxNYSSpaPbhS0YZnDsgy8CsB1nUjiY6u27ATL/gqb0Hxf
zbTVfXc77ijXChduQ3GlFg==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KJcvDWV1EErMO2LYSsLJY+nykdW7DQUJGZwC2yICgnkS9yinJGp4Yy7QtPROY/FF
cF2RZgDDDTxmwsaH1EZECHsEJeWBKZgpFq4bdoKrb0aUBGn0CsolNKM6STWcrOfm
H/ImOlzbCxtJPOdW7t4av/82b55d+aB3h5do9cNc1Hg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20849     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XlJeJF1to8hVXtM5UkZEVCTNjex2h1YB+btUDXJ305zlN/uT88kne0zYSG4gVQVS
FgQn+aWSP1SsTA/1mqpZNyqTdSUUMi9e+APixrQdEIo3v0wCnmKBwitgpuvkPbrh
qqjFSRxfT0CxiT4Jp7xSXjF4VLS3oKUqX9wdrkAu78Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20932     )
fY4TVGtwC/2MJ5lZdeAsqJ6G/030sDj5cSQuQ3NWEe9acCi1yNAW9ubrd9MbWNhN
BrBGZaLvtOQriNyHu5d0/dZeDFKPhv5b7m8B6TTR3K96JkfJRBdWHeJhQDRoIQDi
`pragma protect end_protected
