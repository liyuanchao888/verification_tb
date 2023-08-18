
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_slave_monitor_pa_writer_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_slave_monitor_pa_writer_callback extends svt_ahb_slave_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;


  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time =0;
  // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time =0; 
  
  // The following are required for storing start and end timing info of the transaction at beat level.
  // Stores the time when beat_started callback is triggered
  protected real beat_start_time =0;
  // Stores the time when beat_ended callback is triggered
  protected real beat_end_time =0;
  // stores the previous value of beat_start_time
  protected real temp_beat_start_time;
  // stores the previous value of beat_end_time
  protected real temp_beat_end_time;
  /*first_beat_start_time captured time when NSEQ/beat_started
    remaining_beat_satrt_time is for rest of the beats in the transaction
  */
  protected real beat_start_count =0;
  protected real beat_end_count =0;

  protected real first_beat_start_time, remaining_beat_start_time;
  // this flag is set when the first beat is encountered and unset once the first beat is ended
  int first_beat_end_flag =0;

  string parent_uid = "";

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer = null, string name = "svt_ahb_slave_monitor_pa_writer_callback");
  `endif
  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
 extern virtual function void transaction_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
 
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);


  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus
   * by the slave. 
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void beat_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
 extern virtual function void beat_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_ahb_slave_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_slave_monitor_pa_writer_callback

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DEBF50TBzejqeW0lvbowHsbkhJbPfMNmRdOBDTyp8MltOW0BMPxZOfTShglRMwBB
quCLCAjd2AnqwQ91I962QehdUFMuKOAXjHPnkJTmNFZp4U9SLyclv10ncsElaA1l
tC/48QdjkRT3yWBtxJ8OejOuIwPW+T5eazjZ2iecuEI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 558       )
z6IeV8FAHkQQVSQpCkYwK3WXeCdzzLphNTrGXSgOPrXYejIINCSYLFkiH4pn2mqe
4lSsmCgqtQvJJnvqx1IwjVblKej9YQb5qESaVm/uJxxlH8LmPsW5vDeIKpoZtBqj
PCEF1pTmj4BlTvhZBmCvtT4OTLluGn8pzru8jbprzO4rzk9tAO/gcCMZeHIys91b
jEC/N8K0OKOQXEIpnS7q3k4b75YyobLsYeBYiMB+G1sdCoZTFOwkmwqFoQRf46/O
Itj0srw4zme3llJv9R8mvbZG9D/iJzVhyPlbfTNG6NQjAL4fPFXKiTphpoyqlbQQ
QfsZZ1iCcj2KAYAj8Qh6YXCu+/JGZO89PHgCVJvZqulZD/WlamJ5JAhWpSjYODe4
7OJ7grlDBMwxIcNZUHl88LijJtHbmVWLdhFpfXhTjLD+w6GkvZZsHggUvLDZbOzN
fR0z3nJjXEDj0weUcByQc5VmLv3puxBOjPmMh2aEyO0bGLJ0CSDvrNjD3cLIWOU+
/dq4F0fIS1Du0dy0DIHUvpR7XvbXNAPd3zgjA5Rf+tiGXfy6PeMqbujfJqPNP3lc
QkYSCgTEhSFmhBKLmyTnpwDlSUJSwFDPMzuJs85te3riUC+iltmZONG0rq4e5rCD
c3TRauI97/wu97XtS38Oig0snQGLb4ermGHGiu50Ep4VLExbLxA0sji6BDGmHJZ0
yLVQahnz40sriWARIum2DfmSWqYRS2d2Rv7jiXwU5VI=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ke2YaYp37jZglAltyIuP6czYJHkBTGGpOd1zmTUtlt+4GlKoUOqfryiea/K037cw
fzo5lRFUpUZpnmDyXvLjCFrOll32y6Nx/zVk4ML6+klOFC9ldkSDtI+zOwTNRxk+
R0YgGrpPRloaFVqqWSGhy1XQ9zvCpISGLgQ7hMs7KYo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6458      )
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
`pragma protect end_protected
 
`endif // GUARD_svt_ahb_slave_monitor_pa_writer_callback_SV
 



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G+UBsejYEky8XUo7Ch7rgmfdaTuJzyoReeRl2sq3ZaI2DwZgvO+S9UJQ+b/qe2zZ
Ko1W0VD+cc55yIQRCaFlbNfN6zaX38KHiO7xw31G5gaketpvLw2NbCF9OAj7/kd2
6cq2NkC4jGLMnAw0q5D2kpo9uqPbWl8M1hvjGQx0eTY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6541      )
61S7WfMSwM17rhf/gf5fI+NAJYFoheFjnNiOZD2Rj0PTNuLBrhtOGH/lZuSiRZjE
JgPuHM0SSOYxSCNd7K8KRBSXgRG378NhYfeT3T020NDheRv5UoNCRYmQnwjY/4vW
`pragma protect end_protected
