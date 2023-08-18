
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lH+qqiJz+Z6upYhJ/3FE7y5O8mGQbg5rpQ9jJPD60EFKMQROl8RKQKKXZWEk7NmF
CjvEZLlhxXkCYoEAB4tCCFvCnLeLugaeol6EmfewzczoncgUzaJqFHhjQJqCb/cN
bs7JloCLhAPEf06wN3OkYic71BeFr1kZpPUfob9GSN+KM0MEQ9FCYg==
//pragma protect end_key_block
//pragma protect digest_block
ncoCWbEbKL5ta76Y+qJ6ModXp80=
//pragma protect end_digest_block
//pragma protect data_block
36eZ99SXVzGEqsqBI8TwehQeB56J75+Ed4XVfTZ6eunEEvRClBdKhvKqbUwF7pDM
1HacsgXH+hSZLk5J341vKoatafYG9IptZjcs3Zd3JjpbcABzWlH5vhkwtljxlK7+
VjnYKcgxwLpWrbFGvDbWiEJDDxSXqzIdgpIedA3bclnk5ORHs0+FUQCbiNNL1zV7
XLZNGJYVcZxJVt3cJXfK1t+nz31R/9i1pjQO3DMe5GbtHuWA0fkTMWm9l4FAG4VF
chdfwqJrNUTqtmf0/FG6oYWV7Q/gpyuGisOUB5StLrjSfhjPNybEi5DIdjeJq6rd
MFy+6An+e6HvbFnA/RoCFfA8LvB0hUV2GEVK7twsOCNg2ZRckbYF1xcHS5XCEVm1
V9DBRNFjwjxEHQbkDSRl6y8LUSpFobWyKS5l034v53DUuxActlmCix/QWGxHdkM6
MvsDsl+vQ+tzi+xb2YJrOKUgDVv2I/+N05lTdAriWhxKQCcpjY/D9FXzleCwi/Oj
p2gnn6a6fG1HGCkGaWVVsBHsyiWzf1dFkfGCBuoQOZGH95WNTnsQWwBlH5iTLWeo
2qrmal5AepCSVlhM9Ce+R9TVEmUYMVT5mDG+NHW7eSQ9bF1gdhDr2de6010EW26W
Wug4UEEmrAywjxTEYo3I18CGFYQm4HaJdeAqAZp6aP15VbCVcltIMdDBNep35EGj
Rwvm1QzzKdxidemPFF4nADiX3Dha9EOzmTbYPh6dlAMhKt+VDClhr/PLqWJFm47D
3bDs6kSg+7XN81qp1VGqOEpkFCfhjXtnJOntLwOKgp3R+CH+wrZGPTDuGWgwKAMu
vIxGtNmbRRMdP0XF6OkSGJXRk62bGyLfFCDcvx6vdlRit+PAA4DOQu4BAo2iHj73

//pragma protect end_data_block
//pragma protect digest_block
09cq/EEo0QpN4y3rQo79aO5Px+M=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Fsg3Z3ee5oPlUOU77kP4Q/ubS8N3La3P+3U/hBQ6mNvOrcZxilUG+2SwhkDsqw95
aAX7AHTo7mzs9jcBnZPGB1uInknH9Svc9VSHqak4N7ryK+GK/6JTDDLQfSN8ierz
cyhj2RcQVFHqUC6sV6gmuTSZa8QnVric3Dkak3oofmsUAQ51YmSOSw==
//pragma protect end_key_block
//pragma protect digest_block
33HtfC+QYmsPUc46OVcBCRUH2b8=
//pragma protect end_digest_block
//pragma protect data_block
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
KcG20Snmv6wSNWjrDL/oIw==
//pragma protect end_data_block
//pragma protect digest_block
DrJ8afaWQjYMuyU27gcALWD3A2M=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV
