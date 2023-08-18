
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_slave_monitor_xml_writer_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_slave_monitor_xml_writer_callback extends svt_ahb_slave_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_ahb_transaction ahb_xact;

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
    extern function new(svt_xml_writer xml_writer, string name = "svt_ahb_slave_monitor_xml_writer_callback");
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
    get_type_name = "svt_ahb_slave_monitor_xml_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_slave_monitor_xml_writer_callback

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
akPNGzV5g4Ri3oS9N+eBrrSgaKlbcf5Z2akdEd8wmAZcSNgJ0lsZY4LkxUdYjOzM
R5rzHntZvN5fIHKiJXcnUR3AcC7/QsoE7klOHIXe269A95u3uR8SKWIwqZ6uMhtU
zEKxSnoNF2Ym63an7bwY+P3I9MmNJg3b1W30jTPFI8k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 508       )
rcJX+Mh2bTp6Dj70Ph+si2NpWmkJdg1vgysugSOJ3oxN1RkgZ+GwhCcaSn+w3d53
9sv4cszU0A40b8iFmPYZ7NzhSdreOobR8hNpgazHC3A5E05zW31tYsrxrbxnYtxP
4pDH9Lc9sw3hM3qhpB7Q5XV3kJRZ/203Uq8UQRy0K+cLwmGFHmaA2zCo/m/et9Zm
qngpqulSvRAvi6oePvQyB4tOIVb2lnjh8C+h0BgIFmlxJ6U9SUh+2RjKgt9Z0OCr
xSMSMwce/r6ZckId/Qj26eUbyLp1YsnOvYbOXcdERsJeVIqb+BdJ1YnA6lPgtI3i
pTKkz8WXx0Np/fpku+ZJ+D7Gp6J8/lcQ+Ykaog5xDD8n3LUoLbB4kbIw6Be1uIVM
n9cxt1FAWBV0OVWhKychwOQKUBKHAWGRq0D9/OeBl39N+izoRbCqilDDFaLYugQT
HnpIsJ9nQ1/YB3buacsq3/UWe5mhX/CUpNpwNVGCN6cUGK72b+H9dE20j2+a5Nq4
1Ol7ZY8Kp9InF7il0+bBhFhCuSrVVvYqmwJtwCT211vwSIkO0J4IyopfUUczZhYv
1YOrGyttPLLoJSvMRm1FVklbPM0/Lhnc8aYReaCBG6MmBZnEbcMA/3iiEAh3QRvw
I7Aa6Zk/RcQ0iXHMQDsJNYlKjz5m4hNw6NpHlZafJrw=
`pragma protect end_protected 

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ns3tpixhoPoGRiFxP00IeuIGUj81s+hSTSWiz+jTdzFZjRVhQCZJtbXHlTMZEzFp
SJ3JfLwvjiKggrWltb5dspRwoacl4VEMIJuBO6TKXvySzqVHdw6KEevhKmW25xcF
2h2D3JfeRqjCYiFby3Q0BHGauLJaM3knlgQDzDLLHW0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4927      )
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
gENsa5dKCF7S8vpTKzpFUw==
`pragma protect end_protected
 
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV
 



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oWZrvNbxJ/19wbXwQUgBMvEzjMvSUB9HpL/0KiN9skqXi+lRHnRnsIDN4rhIAeii
209hpyDMnWoaQPYOaQzj3d9Gz64w1cYOKPBSXN+he0wKB+Q5hW+UEuQZFBE0AMor
uBaiRXyc1IemkLTxkzN0tKX8rhgVc/GTaEiNg8+IWGA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5010      )
htrzGmLxeoRxwjuLOEvgc5ETxLuxF+OdlD6Ot02/u8/2YuZmw5R+u2E7WESiroOU
5/WHF07tXV1IabRykEZGkIhJmNIEhrhhMr5xtEa/NwRVCD4O2dXjdSGhOxFMlgdM
`pragma protect end_protected
