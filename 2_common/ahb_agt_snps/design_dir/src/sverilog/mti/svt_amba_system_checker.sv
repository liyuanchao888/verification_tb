
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V1dkVndjquHzDKG7SVniG4x+7/0klj5yjSeAUW7QPDHqhJtqcVOJZH8wLy8fzv6T
XzTfw2Sc1O34fUYMvGNa/cbBci9esZzR07VkQHwz242w8QxOwEM55r6QX7gJFCfS
+lu2Dxug2p1gHb4kwCyvYcgQ7kHTKNsFRoG/03to8Ao=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1874      )
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
ePSiOc+BYXOUW0S1f8xAgg==
`pragma protect end_protected

`endif // SVT_AMBA_EXCLUDE_AMBA_SYSTEM_MONITOR
`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dMo/TubJLn+nRlPWHPque8Xh9/Y6eue+eIZ/vumhe9wdk/skXrAurzmcXoj1hNZR
xgNQPT4fX0syPU4LKUZwRtGW1WjYrZ/FRdxbTNzb3RsTDzgJlYUo4hDdO3BHmTnv
bUGoiYbDujGpemX4Zf21v8RUOcvOnwFT7HEhnRcAQEk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1957      )
m8ilCeDV2Bf/1cftazZdd/MA10J4IbEwpu3lKrSXXSaX0G5d1KESLcg33IVbgdLd
VfLnsbuux+fZrDOU5pA69oXkwNVEnwR2R6chioGX/ekAsDHOcnKyUhcrGYVBmgz/
`pragma protect end_protected
