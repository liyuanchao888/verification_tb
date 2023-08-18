
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_master_monitor_xml_writer_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_master_monitor_xml_writer_callback extends svt_ahb_master_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_ahb_transaction ahb_xact; // handle to base class to generate the parent_uid for Parent/Child relationship in PA

  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time =0;
 // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time =0; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

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
    second_beat_start_time captures time for the second_beat where the first_beat is not over i.e SEQ.
    remaining_beat_satrt_time is for rest of the beats in the transaction
  */
  protected real first_beat_start_time,second_beat_start_time, remaining_beat_start_time; 
  // this flag is set when the first beat is encountered and unset once the first beat is ended
  int first_beat_end_flag =0;
  // this flag is set when the second beat is encountered and unset when the second beat is ended
  int second_beat_end_flag =0;

  string parent_uid, transaction_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer, string name = "svt_ahb_master_monitor_xml_writer_callback");
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
   * Called when each beat data is accepted by the slave.  
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
    get_type_name = "svt_ahb_master_monitor_xml_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_master_monitor_xml_writer_callback

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SkAPl+AlHtQ43F3mHdqfR/BHa8GKtTTSh3eh3/unym0h6q2ea4U0inAuCeETDau+
CZFGCco1lr16vpbv903LiAOYxjS7UZVvSsTs2SE2hg3QNcS0Yqp0RLdie+keFQRM
vcONIx9N+/hdnPjm8gUQHbAcsvRxbarwXUvdC5oq1iw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 507       )
1MQRE4GXSHdz7ufwTJY2VAEvoPEWvSC3+6o8ebO3ptishPi/BSym6V6Dmg6hyx01
uIMIFyfXm0ZpZOv3msO2iI9Yw8ziZKbXA66feQ46aUm+wC6g4w5+lwHfKWWMyzif
ERbyUhrLyf919S6dlVdSHf3Nxr0vsmfFoeYslrfdodo/wIkz/QbonLNjXaSNB830
raiROZ70Pn917XVj0DyAYshWRvxLsugNu0lydPS1hKU8fC1NEgdPWXaympDxtmOb
muV+LmQuuh8KZayEFIsm3LtVFey6B4l2kqXThu7ABxvnIETIn+HtHLrCi+UFKoaD
0EjM6dCOnwInDzaqLxSvW6yjKaUIEMjkQPv42vz1ngpB/6BaIhhA6dxhB8PctKm4
JHqOKdPKfz4tlnbmvoou6VUkAArmXHGSmSyEaNNXTVkJ4KMFHIDpPEnsn8jkVIW+
7QX7kryTXdPQ5GODhcG0nv5ZAO+RIeV3f3Mh9cSZqXOpVRDFJ3pbmKMl2zuqBAIT
YN8tH1vkxK7yj7PmIo0E6AQITrrAoyBaf+KwpCYBggMkkI4pxpnpj1KWbMeC/OLs
ZXqSDg23CJ9Vu3QcPUlkFLFIHAKMuQvkb2i/90gQRAVmT2CAUrsJzS2oPscBp3+3
pEtyWKoJNtHEq8aALmRd0StfUFrh4gmZgR4oM1eToTo=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mvBZNRTDNtMsmw2ZHAr3ODEai4+DlhbgrC5IzeEkfYPVarlk/6SSz9/YXxGYfEsJ
2F+/bYdn1hoziTdBMkpgnX5eFc+l65RiXPFdZExEVfhSTWm2QUE2a4TPEJUGaqDk
g/3qXo7fk89vqvOWkV3YhmX9QovOKeHYjCo2IEBZs3w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6783      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Gu3g2kNz1/IlbNYMYOm1WIsHFNr0YpisxNYBySavExTlzysYjKbAClqoW3bzsPI6
AnH9x0Dko5xbWu6Q9awSSktTcAMWMxnJMNPTnBRtSP9YTxN9GUGMCnM0vNjyfkMQ
7ydqRISimaRw9pa4ez0r3q1nXha+hhdp/LMyp0bccUU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6866      )
n3fmhNibRGYJS9uhyYO4odA5RQQ+KmrnbdeYpYWBHelpLhMyi0j380IuvCsZx8Sr
5qX4AUYNkesKFQAyXVU6N/wbrJLJCrpMSVIhOV40hFoJamuFirJkN85UG8ZbOpYi
`pragma protect end_protected
