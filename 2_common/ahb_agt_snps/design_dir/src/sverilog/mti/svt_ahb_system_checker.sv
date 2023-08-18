
`ifndef GUARD_SVT_AHB_SYSTEM_CHECKER_SV
`define GUARD_SVT_AHB_SYSTEM_CHECKER_SV

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KTvVJsDa0P48V9SGid9EhyCFUGq8GunmTU97UVpBkoIYnk+Ac1yGkdqO5sY9uE8P
8MrgEZLRoBSeOVfFKxboOuHrbE7y9QmWr4OWnFE7oqUp5ndfMumRgnisZp873OQi
d2YFDE10f2OGaYpxv0bQWFjriEe9wNJ/3PlQj6nwd2o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1264      )
n8xnh1gKpB3WXiOsRS9bg0VHgQBKr2tH2xdvaDJdt40jQ0hR1Xtvgoci33u3yR2C
n+vudiekTYBexMtxSixw+xOSG9EE++ALhGpfuS0h3Qox7VJQAaUk2qLMTEf1zgeB
Rbz/LkX5O44wsMGH9NxhPxGqrgRi5mxGpgSWA2h4IJxDQBhJFoJ1u7PUjB9yc2yR
xsZsZbAQczFMnkmhksKffU9ohhQgGX8SqP7GibAFSfnp1s3nslrApFcHhHe1oDiN
+ZsYFT3suBpAAOWWktKOgkRI2JSJrrcM1NVrSk97wThESh3ZZxQE6h6CJ8XlQpYY
ADK1qUtIBM3HQ5IRgQsQnMu3jBDiz8lhQPBvvCObSOVTR9DQU/yeV7s7PmgF6t/9
kxZ1slhuKYK0AyiBmYeCCEk7Rqg4soea0kRyF4t8K9uRQk23/rtrpqLyWTH/hD9Z
SxMHXYxZICtmf3c1ndBUJhWTqRWMtH+h/yVuVB+fIxGT/Go6fxremtWT00ICwKRn
QgMzCwmS8JZ4SIHODmLyp8olmG5vVnpwLAo9JfIPxOnNFY6HeJRMheZ0xgFf9fdQ
qU7Q1+DFVYYMoU+kjEQPjuTgAGfyTkx3AgHdCyoRlnjay/Yb6EAmZwPHO3jTCV3K
zDMaCWh4JGl4M7Jq7HYZ5mpkxzAsz5f0q+FW/xKw2jTsm9KnPf2FjeG/8GvmGCjc
TyE/F0wha4oitNubJNuWCtak2S65DDFH0IYwVUECCHO3oyvhpgTo7Wxt4FzdPQm3
8mm0gjApzVll+x6aA+9inLy9or+vSojzxYsE0pxs+IfVXTpqqpVknpi+4OzZ6Iwi
WQ0EQHJb3KUSKsq3LN+JfFuuz/09dDXAxSvjZPvYTTSwmIucw1wXAdEXsqbgB2bJ
QFxviTh7pgPVLtZ18uA4KC6lulYI6DtyL57S/8/X2glV4BploL+KLrl2znCfTZ7y
laf0ph8UNbx2o5sdgx0KEUOlG3VGeKWHwjtrNYNIExg2ebwDePZjQa0uHjxUwxJv
/oJ4ITvwu2thrtsIOWHCyYnbYnaB3jMeiflBjIgPuTECwzecE/j1oHLMPTOyJjCj
wFlKFt5YEJ9k/LTADBY+F77EPb6d6K8UmRja/qF78HwzfrIU0HFRH5RKZOR0qYWG
ZcAhkQmmvuk4yx1L4vVxdkzT8vB3xLh6vf+y769Db2n587zWj7SWQb+QuDb43DWc
wuK6pRD5sveTv2Z1CHLeqg8c0LtPesJVb8Q1nig/sjXI8TCqy+MMItlPSQyjs6qj
R3FrcEztvL2bVi1Psk4tT9QjdgecZcJyUTkPunnBMkOXOmGPj6BX3ilzN9NvmalH
3AG6nshoizToBz0+xBWK4z80aCDdSa98Ya7OgkSY1G33RQ8/nKwV3KxX5J0lG8RV
BzaSoZCXbQvdlDd+pgrZRJ23awRuExL8DknLP1qBrB5KOFDtZlwjcupGzIOQs9f1
zu9eUjD3IjeCF9+d1tSiuirFzhd16fktNsB1xT+B8a7kz5GsI6HzClEEZHZo0cWo
yyHKRoUYMLtI/AFP6ZGjn8JkV3ri946bb079t5tLn7KBb2OKjkbqEKoI4oTGQYyQ
lEceFWIS19/X81PICT/mUO020Ap4Hq4zo+sNH1G7mBxHqVrNbbZZSrsTlg8JWzCz
eto3+zFKGAO+vKC1qhHhDtxyKywDJDZvPZ46+f3bSes=
`pragma protect end_protected
class svt_ahb_system_checker extends svt_err_check;

  local svt_ahb_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
  /**
    * Checks that a transaction is routed correctly to a slave port
    * based on address.
    * - This check is not performed on default_slave if the default slave is set to -1
    *   through svt_ahb_system_configuration::default_slave.
    * - If svt_ahb_system_configuration::default_slave is set to a value
    *   in the range 0 to 15, then this check is performed on the default
    *   slave also.
    * - This check is preformed on all the slaves other than the default slave irrespective of the value
    *   of svt_ahb_system_configuration::default_slave.
    * .
    */
  svt_err_check_stats slave_transaction_routing_check;

  /**
    * Checks that data in transaction is consistent with data in memory when the
    * transaction completes. This checks that a WRITE transaction issued by a
    * master is written to memory correctly. Similarly, it checks that a READ
    * transaction fetches the correct data from memory.  The check assumes that
    * a transaction issued by a master completes only after response is received
    * from the slave to which that transaction was routed. It also assumes that
    * there is no other transaction that accesses an overlapping address during
    * the period that the response is issued by the slave and the transaction
    * completes in the master that issued the transaction.<br>
    * Note that this check is not performed on the transactions that are routed
    * to the default slave.
    */
  svt_err_check_stats data_integrity_check;

  /**
   * Checks that the decoder does not assert more than one HSEL signal
   */
  svt_err_check_stats decoder_asserted_multi_hsel;

  /**
   * Checks that the decoder does assert atleast one HSEL signal
   */
  svt_err_check_stats decoder_not_asserted_any_hsel;

  /**
   * Checks that the arbiter does not assert more than one HGRANT signal
   */
  svt_err_check_stats arbiter_asserted_multi_hgrant;

  /**
   * Checks that the arbiter assert HMASTER to reflect the Granted Master
   */
  svt_err_check_stats arbiter_asserted_hmaster_ne_granted_master;

  /**
   * Checks that the arbiter does not change HMASTER during a waited transfer
   */
  svt_err_check_stats arbiter_changed_hmaster_during_wait;
  
  /**
   * Checks that If all masters has received a SPLIT response then
   *  the default master is granted the bus.  
   */
  svt_err_check_stats grant_to_default_master_during_allmaster_split;
  
  /**
   * Checks that if the Master has got split, grant must be not given to that
   * master until slave asserts hsplitx.  
   */
  svt_err_check_stats mask_hgrant_until_hsplit_assert;

  /**
   * Checks that the arbiter does not change HMASTER during a locked transfer
   */
  svt_err_check_stats arbiter_changed_hmaster_during_lock;

  /**
  * Checks that the arbiter keeps the master granted for an additional
  * transfer after a locked sequence
  */
  svt_err_check_stats arbiter_lock_last_grant;

  /**
   * Checks that the arbiter does not assert HMASTLOCK when the master has
   * not requested
   */
  svt_err_check_stats arbiter_asserted_hmastlock_without_hlock;

  /**
   * Checks that the HMASTLOCK signal remains constant during an INCR burst
   */
  svt_err_check_stats hmastlock_changed_during_incr;

  /**
   * Checks that IDLE transactions are driven when the dummy master is active
   */
  svt_err_check_stats xact_not_idle_when_dummy_master_active;


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
  extern function new (string name, svt_ahb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   *
   * @param log VMM log instance used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.
   */
  extern function new (string name, svt_ahb_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HQAysqCVSad+2uBJcEwserGhZc1O/LT1LwEvJOAktCTi+qjdEindQDEhPKGMklpG
QGhk4+svld2NhjpA5Ee98eRO+j1AtO6T+UGmeRzmdxtTwmm1zBOO7GxPJWUk2F1s
iGIop8Q+GaYzH4lnk6wP22b/HXZMbqux3pGewQt0Mz0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6944      )
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
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Nt9gyRSJcqNPlOwD7WrcDxEsX24d+2w8nYoU47SQza2KClWk/r7PnB+DZ05u2KLz
LjfZUCqSDiTq0GHHbNrNDYY7ldlyz0GwIw6tsnRDBpVi7vhMHfr0rjIG05Ck2+4V
OAGC///qivnLQIUMVM226EPaTixWedgyWt83ljYK6U0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7027      )
dEdAyirUg+JNv0H3DxOI35IKXpLH7MpLjCghhHiW34et9OQUYTVhNSiOgAyvMQrL
83NjeZbaKGCEj8ls9GmFVxY4K4nPEfOdu1URTp/je33rdtEEP7zitbYS+UC8Do8g
`pragma protect end_protected
