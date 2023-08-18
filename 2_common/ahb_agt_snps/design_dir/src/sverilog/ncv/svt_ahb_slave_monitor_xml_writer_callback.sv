
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EFfekKqNm5xhmdD16mE5upmyOfGeiZiczkOCC8VBvrxo/diGnjVRN1LF5sW++1NG
yBKYR4qcxyn9cMB3zCKwn2B6x2S6Dkj3NkWAc6aYCUG1Qm02UnHa8rrICaXRMP3f
0pYNm3Ni32bkjWi8qMY6xnrvXKwY+mQlyKNEEsB17xsl26Ur+E5VwQ==
//pragma protect end_key_block
//pragma protect digest_block
MT4nuhhmok0CVezazH1cNfsPY20=
//pragma protect end_digest_block
//pragma protect data_block
GWRI+UhhQrNNaAl1tsLAH7efdXNpRqiWoO4kzoK+kDrTdS70VP5Dx2JV4fWxS0V1
U4ZcGALktC9fvpKfyhHc0QEa6ar89Oef5jRf0hdIJI3AFWv6/9EK4sXdUw+glxJF
Ugm+dtLG+XDO5mckRfgKVIOdnP6GSMkHzBtcbxXjECFAfL3/cSadg1BiyuNs69R+
psFl9eZDUQzmg++vyS5ynf+agc2vz7g9/ei8ZUio3JHTIgnuEZ208ZOFuCdSz/e+
QpFICGM51auV3b4foOf6bVsOCTtqjMTJByboDNv0zq/7uR7/XkgmwtirjfgvEhJe
q5eLC6oqaOVJpnFmfUA9yfFgx2GImLZyqdGWvIOhZETSeKUOEPKHO9aQq9WGVakO
KEuAmxeuiDuQ1h4nHKed6MQr2Gv0s+ZBjL6/5pxl+93RGyvOzpgGJ6KJ+C6GKLps
90ZOoBu78DHMJ7PMAOu3CJvmNfUDRFUufuUDog8PVFHsKv8E39u70A37xz89GewH
Yz0Rg0VvTKQlfWBd7wxffURXGwnKPFmh6ZXSu/hCx/aAZekUqHqFWFlvNYR0OqgZ
vnXqSmVDjzolKasUpZG5wxAtGRWYTSX9GTL4M8WJ8/kc7ey0A2nl7gj4QUKaDJBZ
+7Hr2NcPcNE12quFpiz7pb8tsxArRsfrItOtM91dSciTXbYJE15ZnS4m/t4D2rtk
QeslL1sQj65Y+qIBq8vfRK1X6tFnN2hWfU60p3Qi4XCRwj+/SrxKCOoXESfcjdSo
gOImcwShxkQmHkJizDIEdC3vxVjMcDsf4OZGPSSEE9OUA9gmYkCRVlQxdOb7SjNh
97FihNO1s+DmyJnjhFEEl/25d5tOKvKlDcLgow87jIygoHWyd+4gDxRFNulburUX
fmi8Oi1a5LH7cgv85WLtBw==
//pragma protect end_data_block
//pragma protect digest_block
BC8w7ltufTY5JeDQK14WDdmVQBQ=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0jLFcDGJOVeCehZFWf03Y01r+XbLqDWVd2Yp1jJnhR273VjR22/VBGr8eUdkOLyX
Wumnz21bUO60MYcjX6biPAqLUu8irZ2XYhNYpPmfv97o3ovMlTPiKQTucBMxb+ld
+4fNM3iAFlw8zK3FuHkAw7kVCtmL/cSxu9ZNiEuRNuLXXehNcYp76g==
//pragma protect end_key_block
//pragma protect digest_block
i3UtD7mlBFjMHVH1kqzu+pwlivA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
NyQe90cIAeU/XmLFrKmpySgLNCY=
//pragma protect end_digest_block
//pragma protect end_protected
 
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV
 



