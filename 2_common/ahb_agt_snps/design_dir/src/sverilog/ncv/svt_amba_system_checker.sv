
`ifndef GUARD_SVT_AMBA_SYSTEM_CHECKER_SV
`define GUARD_SVT_AMBA_SYSTEM_CHECKER_SV

`ifndef SVT_AMBA_EXCLUDE_AMBA_SYSTEM_MONITOR
class svt_amba_system_checker extends svt_err_check;

  local svt_amba_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
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
    * Checks that the data in a slave transaction is the same as that of the
    * corresponding master transaction. In order to perform this check, slave
    * transactions are correlated to corresponding master transactions.  This
    * is done only when
    * svt_amba_system_monitor_configuration::posted_write_xacts_enable is set.
    * Note that posted_write_xacts_enable can be set only when there are no
    * svt_axi_port_configuration::AXI_ACE ports in the system.
    */
  svt_err_check_stats master_slave_xact_data_integrity_check;


`ifndef SVT_VMM_TECHNOLOGY
  /** report server passed in through the constructor */
  `SVT_XVM(report_object) reporter;
`else
  /** VMM message service passed in through the constructor*/ 
  vmm_log  log;
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   * 
   * @param reporter UVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_amba_system_configuration cfg, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param log VMM log instance used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  
   */
  extern function new (string name, svt_amba_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GrWVyfKcNKbSbAueqzNXwkLVuasznQNjpy8Hww+W8xNPiA3s4MUhLCWYtp7zC3jo
oW6csJfDmxsOJH6JEI0QQQkEOw4kxG40Oi9hL1fF8M9RftBBudUImika3PwqBvTN
lW6QMS+/LmMxgN3nf4hpbFU2FV9myDizYy3Iui5Rc7aGn6u8ZCMBJg==
//pragma protect end_key_block
//pragma protect digest_block
wfT8+nQcQ7rhgWQy6Lq8YEqhbnw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
1LwuhxF9bepe0d45NEDkBa8cwvI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_AMBA_EXCLUDE_AMBA_SYSTEM_MONITOR
`endif

