
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SV
  `define GUARD_SVT_AHB_SLAVE_MONITOR_SV

// =============================================================================
/**
 * This class is VMM Transactor that implements AHB Slave monitor transactor.
 */
typedef class svt_ahb_slave_monitor_callback;
  
class svt_ahb_slave_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port that makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) item_observed_port;
  
  /** Analysis port that broadcasts response requests to the slave response 
   *  generator #svt_ahb_slave_response_gen
   */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) response_request_port;

  
  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  /** @cond PRIVATE */   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Common features of AHB Slave components */
  protected svt_ahb_slave_common common;
  
  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;

  /** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;
    
  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_ahb_slave_configuration cfg, vmm_object parent = null);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Stops performance monitoring */
  extern virtual protected task shutdown_ph();

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  
  /** @cond PRIVATE */
  extern virtual protected task reset_ph();  
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  
  /** Method to set common */
  extern virtual function void set_common(svt_ahb_slave_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_slave_transaction xact);

  //---------------------------------------------------------------------------
  /**
   * Called when hready_in needs to be sampled.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when hready_in needs to be sampled. 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the sink_response_request_xact method needed for #response_request_imp.
   * This sink_response_request_xact method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the sink_response_request_xact method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   */
  extern task sink_response_request_xact();
  /** @endcond */
  
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cOtS8uX9n08ftMH8CXLlRaY7b8U0+o6khOZFlxQzUvDNeOqm38khoD8oommYfOR9
E1UDOllM4qCebGNhRs0FJcY7wbM4pjQRHztFyp04cQ6i0erlcOxzSV94YzT44x2Z
7fmEwgqcWnf4gG7cMdjUNaNoAJ0Q4jfkXnRTIF+KYtE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 254       )
1xF79VB+Gcy60q5K2p7F/bQwiqjOg2icREfKX6NMrSpxOyJUFRClck2eqExFoa9N
Maz6K0GL33t2Gt5cSv6KJ0cshNq5kYvNJuTGS0+VM8TZrkH2TZzYWLmHHyeCbnXx
bmuJhGRA6bBONj1Nihs8q5tCByfezOsTZjRUOjhpq1PG4CqezElajwpALKscO30q
OyezA5FfttMOAW+6aoGevD29zJkqMlkmuB5fCy7PmGRbpG7AmMYd3ZTKxGS9kbJr
TgpO40FKSYXN0V89S09aEAhNnCv1VEqz2PHtUrnV7+tq6IJ/2vpDFM2E2L4M31dd
+JYRC7PILqlRkvw7nSGWrw==
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i+ImYzTogaWDIzSySDGbJC5K9ybnHFGSdQT4Cj49wQMfsrJvYUS7HoAxNaGxNCR3
q8p1AqfWf8XIWpxRushjGdTpJ0MId08ZXOd+cHDycPPbw7hHgDwreJWJ5+c+zS3P
m/e51N4do1QqQmqbDSVq4e85sKfXqVNfnWshOBesi/M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1683      )
rt5WyWFiho5qj3sKPqaNatCJIea4rxSZ/+lQebNTI26+F6r2j4VTw65DBrvHET+Q
GLduZJ73dPXeTT0/mpgPBz1u6Cq8QOM1j9L2Rc0Kn+QCHj3oMMGfWfdDBS9n6yUE
FhvKEb8n9zER+nczCXduAwL1+fUgUoPyRBCY4WChM829aqlXDNU3TrEkOML/R2Zq
gsSJP3/LVpX18UGla8k0oQcf6Kf/8tHZjpvil/qDZ6vBk2smqyy+zJCyibsSvsB2
J3yLftUtC1iUWPUKqKkCyHkN7FDa7otGoNBw3zAPHJvlgu2VgJzASN+uin1qhKz4
7KZ7ePBo/07Hjv0a8ydSV7pkDuTS95d8FhG8CPpNw70cwmqK+X8LWoG8kXX5dZdo
swJbIthhet5zqOpgEJnbNjYeSnYwTmAzi94zZrdP6PK2WWoZrmw2oH4Fd4s9bZ+1
6sEk+1eM8IJUdrsdiSkOpUbJPAqm1qGmLRc9m7MH0y5NtH8ZeznUcjub5R8AP9kM
nNP2bFJxKt0sFaBKt58D3bsmKJFbvd4O+6oiDFxSIXdmt5oghFigtTc4Nf/aJavE
2Yy41Yr0HQA2qmu8NuctW4cqxu6uuzjGeqkO9Ob6NaWBlMm6DI9z2jtgS3hkx8Xi
qO3kjcqekDt2gpOHzSQJYXcBVNrTFERjehiyh7yfmYxutLWXSHriJMeEgwSXWFTf
5UjcIZGBTaqjBl8OX1UG2kA7oUAfH/21LoesNH4wh6Jkvr6RGwNehYhEpk5jrsmb
s42xwfvpsMWxzbdc/mSXI5LAngBxhOGHMFq2+x+h1WDpMpltxkdK2tCvWZgXk0w/
UrHEJhsTRbHRzVNAjhFWIpsedaRS/86/YHjLxqYnmUQfwB6vw51YE2yNIORxD3wW
0H9cm5RsWyZ3WctJCGn6BhFa0p9kWLt1hRosX7IUcgfq80S8/4U6OnzYSsxUGDTh
aBK3C9zoi1g4r70z6f5Orrhc/ifJDE2jS7grH46SFoysgG77hC1+OkLYi4/wGUqR
O9svX5kDhYiY4NIvF2ZKgpthh3YHHMn4s8R6ZvwbHQXUkpJW0FeqN5cxbDXwySOB
WJ+wZrWwk6/8FOlhKQRn5vxpaeQG3NAPM333b3Am6KaOku23acDNWtk84dnJqnHc
5obriNPNDh8WwbxIt1IhR1YKSWOuoNvxwxXqGOyXq2dm332J1KLiMXDguBzkZ6PO
M8662E+ySRTob/8j6GQYtSWecSQlBL8HI05LfVFzbfMDCTu79Fh6GqOX+imawYVG
/MfEEvV2e4wRxSgTGAonZQhennN8xG93f/hSuH7RO+oUcIR1rZuLGUEYPT6l+p/s
lrKUjUiYRZbjS5ZSgTpPq7nHZcahvIDd2bMIlase7cpa65rnLTIf1ZGyVrWydZYy
aNDyiGIXsHhFT6nfkMlFfO1FCV9d3I5M+yaCNtP+yoUoYGas3FIduGRHJrrljr8i
VUxPryCgt90NpESwXfNlHBRkyfdQCwNPy1QG6EFSxaK/UywvqbWLnI5rjBV3btWF
41RPp5laJov1l4ae/+bwRk4Iz9DBII58mejKjr2swiv1QPIwTqz20tpZieGRfO2D
qShmogaidAZxBJYDLMOI8J+DdJS5p2oUVzJxUqZ1tDGdO0Vh+Q5wkuC2B2OQLi3L
wHIp+Xr56Y2MA4nUC0ADNon/JRthaVtrrtAJVmkPij331M3Jxyg4E/M1mJFSVQdm
Yzmjks2ZmqWEwcNBugRfcPk+WBlZGvuLZC862jxONfCWq5e+ieN6EOS8J6PqZ8z6
DNDGYoAUHwqiFUHQu/YEQxoch5HCrAn4V8t3TEsLm0yh6IwSSCB1CCs/lwaxqjXn
JBTMMa8GHnuZtLtQjWImmqiiBO/eDWQvROBSwpIKuwqHYE0IpQ3XwlhWY1IMeL3s
`pragma protect end_protected
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bxFanuJRx3C4rr8VZ14wDxXlkxGNvPHc0D3uoRhElmCGoPpe86FpHwAVBrf/yqdS
zZoHtFnxBbbWys5YfqO2Lb3Qcy0btsLEKUxpsRAV7QSZ90m/lw5yOYQ5aW2wYBp2
x1Ex437nETbevW6OcAXw1tf8xOW3BygiXfefPGHIMiY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7471      )
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
`pragma protect end_protected  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nSmy1h8pdWtJ+RCe8mXidulBNT8StE8r8OdffFl9ccpgNPkqjOnhmVdqrODTaXyS
NmlXs72EWvT90/lPLX/QhGFEVc2RR/2glbEStedJqfeTcqJiUhvOT67AGXBNJ+cZ
k0AstttxKXIbotzYxlWUIyvJ5R8weK8u1tlK8da80c0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7585      )
eCsZSLuQPPiRgv5rS4fWu5dLs3xjbS5uzmDGGgacV1t6+xbr873NgGg257WwSE4C
ezkn3aWk2D2uuJL8dsqOhyVAfJcU5QOWz86LxjygqAMmoJer8f6n5XbSwWxojsrM
dW3LOmgrA1Gi7wEENX5Ub6wYi6+oBSeNKMQLoo3g2EA=
`pragma protect end_protected    
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ctc7WOvQY3dfNtSUky5vQY9JGdn0up5votMXDdjC1QPEM7oXhfS7jGejX+mlumo4
18NvKObIngEgcq/h2AMNw1cQ9CwdpmazrJpNfOoHr8qlpC614IhRSWFIT96FLb6A
SezzrV/vtTNIyBwcuOARBdUhQ74vD1WZU+47LoFl9lw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15852     )
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
iPgw4XG/AsfbF6g9ZNlDsQ==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
USx837s72eM7d1o7yE9Ug6oDHICVf94Cb8tXnPRFt2v3wAxOFRbycSFeOpGy4NkY
ZqHQ0TVLg1GtFfc8sQKg1Qwpm3PlKvD+FPDe0nak/Rs+6aRVeIjkz8DZJ5oGT/27
TKtYg6AgoZ8+q6khr0C2M18+OcNTynNy1kzFupQKe6g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15935     )
x9OomYSCcF9XgmWOjtgO23ge4OKMUhkcp0gJ/D8debqoZ82or+pwHawVpBrXtKqY
t5R0vgDnQB2gtGp+muiw0J7NDudEti90g1tsIZ8psOykM+UDlaEed9f+ROG1cPgF
`pragma protect end_protected
