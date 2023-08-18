
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Qu2arLxSGEYxnoC8xrrBnSthtjtTrd/zwiVYGW149PWpHMiEdswqCqTlp4w2GvzC
CYUb+cDMlsuiLOZQI17qhKDTRrYkqPIH1AnZha0UzLF1qMt8OtzcWa97YR+xx/Nn
xW7+pK19nX2oC6TKf/IsvvCuoESXbidtY6L4ZzurpEejhFwaThdSqg==
//pragma protect end_key_block
//pragma protect digest_block
6pGBcFanmlwUESy/+UzMpvN1QEg=
//pragma protect end_digest_block
//pragma protect data_block
PcpGp1Vaws++xOQ0n0gf6l3F/xf0qglGnpuHLbG/jJAd83J5C7ctd5vtX/fKKNjK
hAFMKzEDm9XJsVcwLQlgGQbPhK+uIxTS0vlXMYWwZCZI35BGfSjR8FZZNTsgio6u
TJJB8yJdzzGmby0ZvunaWb9H7uVrDtKSQvHk0OsGGfnRTjhMyPt/RwwhSv5dteJz
Nn+twIFWQADw8nSteHTHCqgY0NC0KhWxn71m5p3WGuSyO7tuHTR70Bx8T0ejUQeq
dA0bxc4SjJeFdIbTVleK8nHk5DHUM1GzrM4xIO7tTyEsz/WXjYSfIzoQG6gG2ESm
8qfFhXOUARfuxstiR1pay7KMdZiOEpuOoBL2MXM5p0J4b5It5l+JOHagettivOMk
QP4li8HcAEPmZvh3YaEYRBfLXomkkcCnYjkrcIgTU2mGiDZAM9SiJZ1GXMViym8V
dBFSdpFdLBqMyESQcJgywXM64xOjOybS472qmBFroKw569BVVHz1IJL81j8XL6W3
tHpAuVpWWWuzlHNcYQVCf2bPWgX3LGBBOkZSZdUUSExnbHDOdg4Iu7Z4fQammBm9
BQfvKrUxghgvGWMQxg8cxEvgH/pPh7mddpo3tBtLWK5raA6NPiVwqe42O+g6Q55e
2CWRYAvoCiE4TCT8ImFpbAqRVkd1vhwxuyYswwCsacl2EqJYh8YA+0oJFOCZWxAH
BdXZQ54zdaRouuPlZVS8/U/SOG/dHgahjk0RKhdIH2HAtoYZ1vnC+HYyrkIWILHF
eZ278KnxTQKyjpAIaK+UJDNNYkVcCr3ssuWBA8BHLmAY9ePKk+r06JbB65MM/HK3
7tmJQuufgtd2zJv4dfpKxWte+/x1qudJmpbTZynOYSVwx8MvF8s2nvXrRSxE+Pls
4SXwLGs3gEQ7LI9WLZENpsyS4wyohR9gIN9Z3v73V5AYqHlymKWzREdA8wMWP7hJ
yYj4OfPP+vCqqjqSlh6OJA==
//pragma protect end_data_block
//pragma protect digest_block
vkSGAnBuHCCWSYAW/+yc9B1XosY=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cushcueBVM1eWUGCNHDXP3ZgOjaIFDpUjWin+CZThjcHRKYZX3oXMNdUAJmAgbn4
f7/cOpDCnQtKufS3Fl4gwrbB2TEix9s+FySW0NqzEGOIWbhoWcVSZVl3ytpl9kcj
3Mq582RzkU4oitSRFyXPD2xvWSWAUHsYz5BNv5xNVNkRuaWWS1YHdQ==
//pragma protect end_key_block
//pragma protect digest_block
NXxifDhUrSp0dcsvhl4k1B5T+yo=
//pragma protect end_digest_block
//pragma protect data_block
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
riDBuL7mqeg4KU5QPWe/NQ==
//pragma protect end_data_block
//pragma protect digest_block
qBrj+063bI/v2Fwm+LeQFsteVVw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_svt_ahb_master_monitor_pa_writer_callback_SV
