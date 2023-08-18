
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_master_monitor_pa_writer_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_master_monitor_pa_writer_callback extends svt_ahb_master_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;


  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time ;
  protected real start_time;
  protected int beat_start_count =0;
  protected int beat_end_count = 0;
 // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time ; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // stores the begin_time of transaction_started
  protected int xact_start_time_queue[$];

  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

  // The following are required for storing start and end timing info of the transaction at beat level.
  // Stores the time when beat_started callback is triggered
  protected real beat_start_time ; 
  // Stores the time when beat_ended callback is triggered
  protected real beat_end_time ;
  // stores the previous value of beat_start_time
  protected real temp_beat_start_time;
  // stores the previous value of beat_end_time
  protected real temp_beat_end_time;
  /*first_beat_start_time captured time when NSEQ/beat_started
    second_beat_start_time captures time for the second_beat where the first_beat is not over i.e SEQ.
    remaining_beat_satrt_time is for rest of the beats in the transaction
  */
  protected real first_beat_start_time,second_beat_start_time, remaining_beat_start_time; 
  // this flag is set when the first beat is encountered and unset once the first beat is ended
  int first_beat_end_flag =0;
  // this flag is set when the second beat is encountered and unset when the second beat is ended
  int second_beat_end_flag =0;

  string parent_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer = null, string name = "svt_ahb_master_monitor_pa_writer_callback");
  `endif
  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
 
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
 extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus
   * by the master. 
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
extern virtual function void beat_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the master.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
extern virtual function void beat_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_ahb_master_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_master_monitor_pa_writer_callback

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Zl9V+wdgNVI2HWDPlQfqB9PZSP0UmFTLeSBgJ7mBYFzXwHzzFwNhA2/Ma9kVFuLR
ce0c16T5+yAtXmZDGNFN/LlndFmMexZlVvaetAjkPOy3ljP7WdzQyU+z4q5yAnM0
igNGIKwEk8LfNYx6iw1xGAG9DLdEIcj1whOIacpxEQ8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 559       )
zhClQSv/wEryXMSyQscUbEk/SrEdMGRJKLL5Z3DkfQQZ6llv4DXbuERD0uJrsk7K
2WQHxLiqs9cvjI/62uZ8sFz69pSsXEf7V8YXLbBUleV4r1IECGiYo2flc8aqlbCx
DfJBjesLQYMVSA0nPx9rRbiTuPHxY5Av5u8IpcwHGvAPPHcbI7yVkkxAsY+7v5zv
1yq+nfoLQeZh1GpETPJhEpfv4YlsKJcZ5FL0V/N2u/gmodIiDIcFeuh+Peyx8Ow5
sLIEOAZz8oHV+bjZhHOMfd/3Wt8oanc61yDpyvAXcFd/om6cSFDqgEnYO5zsNrSY
KhdwU71O4sbZ4yYapHZFpi9Kh9FAio+dXz2GdAkK3hLKf3ovpyUoLXOtbNxA9SuJ
5TwtfQBaMTNkCEk0mi5hmlUJKm6b6EMuxgUpFtThJrWikevR9KDKWQ7s+GfuE5Du
FrqCgGI7Jpz1j35M++ya7lu9giC5TIQ1V4/1iObLle+0GF/+fENz2AKvSJvPqfet
uLtKLrqz4iDkTHyLK1LZY/b+uTkZxqWbG5KJ9obgl3OEQXJQBlVJsQvn2ZgU3JX8
i1/Jtn4cQ7NtfO18JpW/BImUjKXGdZDgIxre0QAPQsxoUcPSM/UNRlQBHU5i5yIe
eHxbXCswM9IsEdH1eAj97JnrFMUtzekpE8H0lN89bvRp33qvBqDepIO6EgG8bcWX
ZcP+hcMLuN3qTvsGk9UtWMlrmf9KM0vCHe5hbbIqZXM=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GKIkSGy+n21uxqgVUObxiymvaxHEd4LBv2cSCiG3rYWVvkOPpPqMdEyG939M9XDn
CBea5N6jPHWhIfzHR5ySxaGUGB9fhwi2OZaGH5yA2Ll9KIjP9K4Y6300/WYUWD6T
EWKNRab7uokvqOaD9YPRORQPlMgJ9cf0luf6QKY+0Z8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10198     )
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
`pragma protect end_protected

`endif // GUARD_svt_ahb_master_monitor_pa_writer_callback_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CAFudsNSHDIxmQ3TCvgN0Nud74n+MQ7A/C/gf1fQ89Kju1oBiMMdlOAVIEKwz+6T
v07WZ4920zkqKBR6zy3fPPLr861sz9n2NZveG+Qg4OIDCauRtNX/wx21F4YYh7fA
odIbpsvacCaikyy3USd/Hd0FddkFRIF96dGK9OEXch0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10281     )
aLCk69bTv9EbTU8VC+LZ49B3nbL2HSmKKVT0PCqfUXNRfJ8FDXgK6YPpPDGai4/6
RaT5/eIFV0vNRaO3Fgy4eDaMQ0LQPlVFbDHYLFGbS7mPSYvjGYK5ZWkjzo1CxU2U
`pragma protect end_protected
