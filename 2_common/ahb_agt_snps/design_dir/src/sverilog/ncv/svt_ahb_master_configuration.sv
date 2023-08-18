
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5zqdTM9f9ojsECPdNKx44MgWacmfDEpUIEJWyuzgLu9rxCJsZ9Tq/u+Bdr6Y9alL
gQSmmSe4EGCRRGTmlKy1af3QPRm1Ew17Yh4UvWEW9aH/AqcASSTP0XpEyYv/RyAc
Aiv34YD/6GPsey7kNcjY8HNJdJo1T25nEdgN0XRHhvVD3TD6KryO/Q==
//pragma protect end_key_block
//pragma protect digest_block
FrxMZ/9o80ZwKWyKWzkDequSRdI=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
Wwi8MonZN+TKzNEQqOTUB3j1JFQ=
//pragma protect end_digest_block
//pragma protect end_protected

 
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RlkpfJYXwHFTthWYnV49KatQAF0AZC2ecs5a1WYDYyuL6lbnDm7t2fJOuockCgPL
d4J/jg07z0BJ35wFQ4wvR+YbiTW8LrbrG8IncZV/AR/M/kc72r0ZZByiBMtMNvzG
hCYYbEjLd7NqYSQXEA+HU9U9SqBl1XdHdl+n3m83srTUjlMdrhBB6g==
//pragma protect end_key_block
//pragma protect digest_block
kGAy0/3QZabkcog9QEUUk1cn1GU=
//pragma protect end_digest_block
//pragma protect data_block
//Tx+tjgLeN5aySyupI28lTzTt9ZInP8qyvQ99JdQt5+K6Z9QL9MjNOqQh3t0Md9
PWA/Wkr3CboXPLGIGbPaFRKg0EScNGs1f9+pda3OkH259dcIddGQN4yRWoulGiMr
RQl1prffr9ADrnxrWrUBE6k60e/EqoLDImrfAuq35QqNE4HZWGziR1btNcLMohnJ
soSChaz5Vgcts47bBrgbodyEHNJ7s7ZmMliSF0E46sbZsQaN5Y2tBMFuiSWQf7dm
bfNVAreuBk5+ZXNyae6BG5WCU7JIg0rg3+U7w9fXob3HQqRGwoK7gd00E/rOsVqT
hbQxvl57+ImvJ0GmzOQACIrrhviItTAc5PH2IE70Yz5gDGkyjETLx3rZc4u4eDCM
stcd52G0Rv1VZ2W0dkKj/CcL/KpU94de1TaVVjF/hCWHNV4FjbpB517bW0wO+KsN
SfJZ2dPrZuddue7I15OnsqVHioUqp5cG+ah4csGszMDFd0MRxusGZ1To9ibEvUes
L2YLZPwWCCGYTcSZN3HedleqbtK1XU739f+ICNJlsPxT4nzhfXQPmxyb+VlYLVtp
H7kAdYLagcq7v0cmIdgfaIO9tmSq/hKi+lkzpLIe2vSlJQyWUEP6b83L1pJpgtx/
wVWSLtBsKVBWQflrwrQtY1u02C0TWZdE7kddfcp2MUlzeNXUPn6zJUHNaNaA/FzT
W30BGCoy2UzfDwxjQLu5lVruu0A2zbPY2T9KBdDQRKN7hVsFHmrZbGE63BlrS9Bx
QLFkzdF5Xx+Pse5UNJok/aDqsFgOKpsbgloP5Ce87fPmKzOMmNHeGa8CtV/ahh+V
29/QTVXct9WaSYH/SH+XVEhZeFnY7j7SNjq9bdyVhZzCqhkTul9pyV+BpXEDO4NH
MbPG9Fc77g81CYUcGReFkJJHw4CbV9HCJEh8a64RtVZ8yrHwvlwmlkU9zEVtrjXz
2Rvm3DhQ3+CKgaKgZ1dvciqfyJ2CNe09t9NMJZyxRyML2TAAxSgQ1anFTLsHvKVJ
ulwvNue8wvQPwyT2507wpty7NvFQvx8/iRd2sFHkavevGOWajuK3w8ny7Skg9tAG

//pragma protect end_data_block
//pragma protect digest_block
dSTVWQjaxh4wqcs0bWFqtA95VIM=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
S8HOJHY+ADn2xW4DXq/O7X7H4Juhq9eP2o4LSyaJR0mbLWlERepPe5eTrqgQlvDg
mFemRq+oKkeNiz+2pktPSeUGteeTXe/dOfScRXIz6UpnCAgF6g5VbDyQqsRNEXxi
DiRFLD+aZ62c2utp+T9VTO1s6LLc3IrQbBqTs8QmLCTQzm0rJJFptA==
//pragma protect end_key_block
//pragma protect digest_block
PB4lNzhUTAz3lDBPjENme7nPk/g=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
stoO045tVMRPJzcxvbS7P+8Ws2E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_CONFIGURATION_SV
