//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_CHECKER_SV
`define GUARD_SVT_CHI_SYSTEM_CHECKER_SV



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QXOW1oAqCag1QTtg+Pc81/7lL0Pj+XfXnk0UZ77dEDQTyCRjTNVTyQqcdwN13Iia
1Z+1Tw0/Jcw381YLYve5LOKrLz+Y592p3yvrAIwsSuW7Z2GTA8Jap6ttFlN1eaur
ND48AH2iSeWof1A6oiLASPmS1lnDnKZBh0iqsNmMXyI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 807       )
uDG4qrj4Se0KNL8x59+G9WeYDHQdNZSIIOnBXL/K4h7OV9ToVxXxXVYTNlh7s4aN
RhDWDqPjPW3L/G14J9cyauv4tkZn3uOOYLYy93b4ZCgmdYVX2CfejYwhXCPEvTfi
LEMrTjlZ8y71rKgFf9CpQCKKbYHzyxMfqMOPinnk0GEBVb8zraTkc6BLM7PbAIk7
ch1OQxR6V0uf/z728k90UIb5+4yJa98qP7wqewYdFV3zUFgXruqo22CgyWlRhcHy
wBGjQrNgVPhArRj1wx+BwdX1wYhyBa3BYXsJRDsz2hNW3xrV1hpJX+Tzi5MW59X7
twwixvTiNvT/iPhfmq9Vvb2yDjrZlzGzsmgnTbK8IGl62ZhNYGXjxBD7JNBNDdtb
udcnU1PJE2za3ld1B/fbf1Wzq5OWVk0UrrYglzF0a26Jus7InFbVQ5wGKGM5rlPF
Nay0cMX20zDrW0O1pwX9yIZarFWJ2UX8pdY3MUdAc9JGZTDYlX0MDXcca87F32Pm
OJvxQzb4KiXxnvsONN4/1ABqyspCkqCOAEO+VODgpQDx0XFe/u90sY76HUnjVf9H
iiaXRheEH1Q9O03XSmvbTVRLY0gUaD3MlBS9YMKDRzzHh6OLCW1U9kfImG+MB4PS
yP/e8TZJu1Ld0YSkyT0sF0ZT1q5rSezYhskIQGeZ8J55Ik2vNXVZX/8vPUi9SBc/
3WNKfS84h3LanLf/+JJKCMtg7QmTNl5OmEnr5MdlVxwNiHiwJlqo5xU+sWHedN0w
a04JwsUKATFao5VnVsoW5C15PthNR9ggLQW2zQWgkMWC2iP5Kqq8w9+hKBIoQr7S
u+dVc5J/Et6mi1MtHjvMs9hYKy4zxX9PahRdUbQRfbMEfxrBnyl+rkJv4kvm1rwu
nEROXrOeZofDT8D7oeLuQcjCU8e4kpWCxagqWldS4qAYVM8B9kI1lAf072I8Jgr0
5x2wpgx4T67qR7vbRnKs6nawq5qNFtLxkSj7SqOZdBsnM7uWwXHkNvF+kqJtdzbW
2vfEm2KUnhPZL2gPC9LYR0Ry1B0DYzZibxT7F3bo/YPloNk5qIZucW4x/fab8gUv
`pragma protect end_protected


class svt_chi_system_checker extends svt_err_check;

  local svt_chi_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
  /** Checks that the address of a snoop transaction must match one of the outstanding coherent transactions */
  svt_err_check_stats snoop_addr_matches_coherent_addr_check;

  /** Checks that the snoop transaction type corresponds to the coherent transaction type of initiating master */
  svt_err_check_stats coherent_snoop_type_match_check;

  /** Checks that the port on which snoop transaction is received corresponds to the domain indicated in coherent transaction of initiating master */
  svt_err_check_stats coherent_snoop_domain_match_check;

  /** Checks that a snoop is not sent to the initiating master */ 
  svt_err_check_stats snoop_not_sent_to_initiating_master_check;

  /** Checks that READNOSNOOP,WRITENOSNOOP,WRITEBACK,WRITECLEAN and EVICT do not cause a snoop of cached masters */
  svt_err_check_stats coherent_xact_with_no_snoop_check;

  /** Checks that the response to a coherent transaction is not started before sufficient information from snooped masters are obtained */
  svt_err_check_stats coherent_resp_start_conditions_check;

  /** Checks that the IsShared response to initiating master is correct */
  svt_err_check_stats coherent_resp_isshared_check;

  /** Checks that the PassDirty response to initiating master is correct */
  svt_err_check_stats coherent_resp_passdirty_check;

  /** Checks that no two responses to a snoop transaction have the WasUnique(CRRESP[4]) bit asserted */
  svt_err_check_stats snoop_resp_wasunique_check;

  /** Checks that no two responses to a snoop transaction have the PassDirty(CRRESP[2]) bit asserted */
  svt_err_check_stats snoop_resp_passdirty_check;

  /** Checks that data returned from all snoop transactions are consistent */
  svt_err_check_stats snoop_data_consistency_check;

  /** Checks that data returned to initiating master matches the data received from snoop transaction */
  svt_err_check_stats coherent_and_snoop_data_match_check;

  /** Checks that if two masters access the same cache line, one master is sequenced after the other */
  svt_err_check_stats overlapping_addr_sequencing_check;

  /** 
    * Checks that no two masters have the same cacheline in unique state 
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats no_two_cachelines_in_unique_state_check;

  /** 
    * Checks that no two masters have the same cacheline in dirty state 
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats no_two_cachelines_in_dirty_state_check;

  /** 
    * Checks that if all cachelines are clean, the data in cacheline is consistent
    * with data in memory
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats cacheline_and_memory_coherency_check;

  /**
    * Checks that if all cachelines are clean, the data in cacheline is
    * consistent with data in memory. This check is done on a per
    * transaction basis at the end of each coherent transaction.
    * Note that in some implementations a transaction to the memory
    * could still be in the interconnect's buffer in which case this
    * check would fail. Hence this check is issued as a warning, rather
    * than an error.
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats cacheline_and_memory_coherency_check_per_xact;

  /**
    * Checks that a transaction is routed correctly to a slave port
    * based on address
    */
  svt_err_check_stats slave_transaction_routing_check;

  /**
    * Checks that data in transaction is consistent with data in memory when the
    * transaction completes. This checks that a WRITE transaction issued by a
    * master is written to memory correctly. Similarly, it checks that a READ
    * transaction fetches the correct data from memory.  The check assumes that
    * a transaction issued by a master completes only after response is received
    * from the slave to which that transaction was routed. It also assums that
    * there is no other transaction that accesses an overlapping address during
    * the period that the response is issed by the slave and the transaction
    * completes in the master that issued the transaction.  In ACE, this check
    * is issued only when the snoop has not returned any data and data is
    * fetched from memory or when data is written to memory. 
    */
  svt_err_check_stats data_integrity_check;

  /**
    * Checks that a component must have only one outstanding DVM Sync
    * transaction. A component must receive a DVM Complete transaction before it
    * issues another DVM Sync transaction 
    */
  svt_err_check_stats master_outstanding_dvm_sync_check;

  /**
    * Checks that a DVM Complete is received on the snoop channel only if the
    * port has sent a DVM Sync on the read channel
    */
  svt_err_check_stats interconnect_dvm_complete_dvm_sync_association_check;

  /**
    * Checks that interconnect sends a dvm operation on the snoop address channel of all
    * participating components when it receives a dvm operation transaction from
    * a component.
    */
  svt_err_check_stats interconnect_dvm_operation_snoop_transaction_association_check;

  /**
    * Checks that interconnect sends a dvm sync on the snoop address channel of
    * all participating components when it receives a dvm sync transaction from
    * a component
    */
  svt_err_check_stats interconnect_dvm_sync_snoop_transaction_association_check;

  /**
    * Checks that the interconnect collects the acknowledgements to DVM  sent on
    * snoop channel and responds to original DVM Sync. This check ensures that
    * this acknowledgement is sent only after all snoop responses are received.
    */
  svt_err_check_stats interconnect_dvm_response_timing_check;

  /**
    * Checks that a DVM Complete on the read address channel is issued after the
    * handshake of the associated DVM Sync on the snoop address channel of the
    * same master
    */
  svt_err_check_stats master_dvm_complete_issue_check;

  /**
    * Checks that the interconnect issues a DVM complete to the master that
    * issued the DVM Sync only after it receives a DVM Complete from each
    * participating master.
    */
  svt_err_check_stats interconnect_dvm_complete_issue_check;

  /**
    * Checks that the interconnect sends correct DVM resposne of a DVM transaction
    * correctly based on the following:
    * The interconnect component gathers all responses from all the DVM snoops and responds to the
    * originator as follows:
    * if any of DVM snoops had a ERROR response , interconnect sends a ERROR response to the originating 
    * DVM transaction else the interconnect sends the NORMAL response
    */
  svt_err_check_stats valid_dvm_response_from_interconnect_check;

  /** 
    * Checks that no data is transferred for a DVM transaction
    */
  svt_err_check_stats master_dvm_no_data_transfer_check;

  /**
    * System monitor should ensure that each slave responds with DECERR if 
    * any transaction is routed to it with an address range that is not visible to it    
    */
  svt_err_check_stats no_slave_respond_with_decerr_check;

/**
    * System monitor should ensure that an ACE master interface must not issue more than 256 outstanding barrier transactions
    */
  svt_err_check_stats outstanding_master_barrier_transaction_check;

  `ifdef CCI400_CHECKS_ENABLED
  //-------------------------------------------------------------
  /** Checks that no snoop transaction is sent when snoop is disabled */
  svt_err_check_stats cci400_snoop_disabled_check;
  
  /** Checks that no dvm transaction is sent when dvm is disabled */
  svt_err_check_stats cci400_dvm_disabled_check;
  
  /** Checks that barrier transactions are transmitted/terminated on master 
    * interfaces based on Control Override Register
    */
  svt_err_check_stats cci400_barrier_termination_check;
  
  /** Check that speculative fetch does not occur when disabled */
  svt_err_check_stats cci400_speculative_fetch_disabled_check;
  
  /** For WU and WLU transactions, the CCI-400 generates a snoop, CleanInvalid or 
    * MakeInvalid, followed by a WriteNoSnoop transaction. If an error response is
    * received for either of these transactions, the original write is responded to with an error
    */
  svt_err_check_stats cci400_write_unique_error_resp_check;
  
  /** Check that outstanding transactions at CCI-400 slave ports is as per the Max OT Registers */
  svt_err_check_stats cci400_max_ot_check;
  
  /** Check that there is no activity on slave i/f within 3 clock cycles after RESETn deasserted */
  svt_err_check_stats cci400_no_activity_within_3_clk_after_reset_check;
  
  `endif
  // END OF CCI400 CHECKS
  //-------------------------------------------------------------



`ifdef SVT_UVM_TECHNOLOGY
  /** UVM report server passed in through the constructor */
  uvm_report_object reporter;
`elsif SVT_OVM_TECHNOLOGY
  /** OVM report server passed in through the constructor */
  ovm_report_object reporter;
`else
  /** VMM message service passed in through the constructor*/ 
  vmm_log  log;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   * 
   * @param reporter UVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_chi_system_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   * 
   * @param reporter OVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_chi_system_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param log VMM log instance used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  
   */
  extern function new (string name, svt_chi_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MC521DvyPQ//jua62aJA8UXXra3gnnCt70s9ilDSAPem8B/qfIRFFvhdL91iM3zn
ayU1Yx8pV+SNdje1BfKIu8BOpi4xA5HT5h/AViIFVI5GqIUZK/Hue43OUqGxHRdo
Z+hmD+XmF1vYf1v+zsKSeirhnOuXXdoGVHkGSu2HCAU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10030     )
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
ScAT4mBOc3joiudBnUkBuw==
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GsQUvhW1kT9yB34zKzdElHkRDow8wqId1uUSSkQNORzHYzoXNsa44vHyA0qkfBaC
3achzqfvmw2P0VzhkM19GBIOS/k5k/Ttfc0fcSz+4I47TuRQe1ojrpCJS4dte8uU
if55cYD+cyx7AIcvyMvy9ppZEgcfm6L+sX58AkNu50Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10113     )
+stEF6OFFbiiyjsUA9UzQNDImYDECQVR6toqSIfdosAq8Bf5FokDHC9FPQZGeGoi
R/FTn/G068uxaVjlWVZb0Q43sHBmzefGkyJg0y2uldSH3auVM2kh2/+gky8s6g/b
`pragma protect end_protected
