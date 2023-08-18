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



//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+C30fKBXUKb6BsH2xz6af0RtTPMnB2mfX2xPUDQGWIiKSoRu673dd7moc/SxsIz1
Dsg2rm9i1aLU4o9TVf8trzdcKYBelRWWN0niMSvqETR/3c7HqXoep9QQFhWQRybj
otv2vAkpeL+1D1ymj7q2DQmyCO/XMcIf7rfLYqqr4mshSwwAva3d8g==
//pragma protect end_key_block
//pragma protect digest_block
juDqABJipp3j3gdofrMM6llycxM=
//pragma protect end_digest_block
//pragma protect data_block
T+/SxsSTpg+YFJhnVWNmQZxXJxUOXZca5SuUjq+qOEUhMFu/TAvfjQ0tqcokWj17
OTjKh3CS1x19scHrCkjdSuGxLj2rZeHBbXnf/QU7vNk5aCjROEWFQd3+H31uAtsD
pC03cCdzOnyFZXhqvCWY/2xgEYqTTl+GzjGRgw4EeML/zJqebDfGst2p42qG80OI
d3IdBNcvRcszbK1iMcEsJjseq7/VAQssHmH0XL9xLZ10nD51m9/DqiECuVtaN4+A
jM28e/a98GhkT7uBaYwe1nMV14o8jyTL3HsSvb8ZXT7jfxV8zOylJfxuSpfkzzRQ
B//iUOzLOFeWJ6h+DSLNWuVVeD9Ms5FdSq5AAEgGpeKGdwR9rwPLCW5R+3UqkNWD
TULU829j6J+xQwTtar0tpPt4tMEL/kdZMTNqJfi1r3RlaxfBXgO8++bNgHtWWPaS
xoclrXUQbYXAt5HK9gxPs2wbFexgiDmetMJ4Le2DXTWMeayLYy2BOayZlFLEv6UC
KJN5qSKYqgg8GqThcIW9ehMx0tY5pzlBkBdc9ooCNs0VUqetUbXhVYvDnw202gRA
lFaZNqyEh0CVFDGxfHHA/JBWvxboqNfFJkGAo0JWlUbd0wFVkVXc0i+F5tLPuFnY
zHp8yI2pLXdOk5rZahIs3fvnHkfZPUZlCJ39cWlpoa8KlEySRq9+HWK1qq78Kchn
qBFTK480QEBhPNqu73gglOn6QE0YJJ6cY6/DM7qrkBmafzy3y9/Ozvud6juiKE+b
HL1IDdJyZ2rrZ5fY2E/lzhyeTvGxQ8tzZCW5LMYX3zX//H6xqOWbsC6IxXWwmKLD
elicdLuVM78IAvVV//HlluJJBBItioBsXhF70s+Egebz8Xj/7SmZfulzP5epA4Ck
0AV8odMuffimkU+i3iiV/wwLCRPZgl+UGiMKpyU41nZH3xQymwJkKPfPxgReYQO8
O1nqWZJdXev+Q8lhZzaSltBL50ZEa5mjSsOX3ET7aSqq1Qndnh0KFFGrJLanZYLy
viIOMjqfq0O+FiGW7j511vsrX73T1wxRyZIbnI2klJPfqN2ISQxd2JfZS9Z6S9Z6
g+7udUnh/ooK5v5GRvpn57AKRGOVaEmq/jAmgV49BDPdo/JOozNQs83RLZpy0QZR
+UljycpE45BdJLOdOX+4+9RFBNFEIYt0kyXa/EoHintFB9XvqsOu6iNOX8Q6f33e
Q1DrRQs/fT180xJbYIL3BXaVNG92b72xSshbi/Ad/G4/OxN2vVcBkG9uOzgkb7Pi
7hjy8EMFHUIgd3Br+Cn3uw==
//pragma protect end_data_block
//pragma protect digest_block
Bs+LuXlm4v2KTzlDunQVU40vUts=
//pragma protect end_digest_block
//pragma protect end_protected


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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4le8Y7R0xwkDKwKjWtI6NmocDVG5sSyMZ6/lXFIclDowgPh3oo7xVeofkcMfmG5I
jBQ0MSn0Ov8O5GTsLjWNfRDQzU6k6Uj2hieW6YFp1jT6wVBorxGLw8Si8Wzdk41J
8k5a7/CcXx/uTkQQa1XtuimbvDXVIb1fISu6OewmZU53GTKhmpijYQ==
//pragma protect end_key_block
//pragma protect digest_block
tkaiybGs/8FF25iEGqJEv75f/oU=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
ipq9UJ+k4ek+gfl+wIy1LpNsU1M=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

