
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cYngd7KZSa2BiKeTuHeg5KScrFJEBuVBiYbYwXUoP21BJ11rnbi1WT/aDaxTzk69
uzIKHSmkW8bT5DWNru27+w6hnINjpyQp6EXPdAORFOFev39DSijjEARldxlhkSmZ
iH4KHYbFqugHuARTTAIZM1rbw3nXhKyXlPQHbR8PQQ8dyF9tEepKtQ==
//pragma protect end_key_block
//pragma protect digest_block
+pYDFlyO7HNyc06cjEYMDRnKzxo=
//pragma protect end_digest_block
//pragma protect data_block
NHw7uywTGB/3DmZjvgkJzeCBCijo+tm/97aQTgsuh4junlXKyEg4W8HsNhNSLlmj
qr5arIr+iDeNR0ZWu4/cB0G7i8SVqBZq74p8sTfPXq3Y+Dw0+pvmJ7AZOBthCSrB
mvffQ7YWZ5hPsOm5NI0vkWqb3RLZjySWZ0Csl6G/UUzW8Bx3BBWAj55XfryQz8A6
Xs566iDCn6ag96aKZIybfEKm8wsRy0SwziPi+8vcdTGJNx2/lc0hqvwSP8ndPWqH
8abpXvxiI3xfTateLVwVw2knGzAJ+uaJy8pmKqySHirIViAGcGy9Gh8EpPJBKTbB
3+vGsKv1+pxCu5aNh1RhQvmOvxT47Xp/csfpVwGfvmK1eNnx7yb0kRSbDQPkSCFW
xD8aJfzh5+E9ibG+J55iNs81uihM6281l8pWGUt2cG9LU8MwFuqB4Gs6kzHPS4Ix
nNt6pQASokFyPdl4Shq6unO3xb6OIWZ4AqHSfW85tblBBu/fi9gAZetjyJ96F0X7
OrUxa2KvU8ZUpQ+ORcfbiu7w1DQINgDraAKl5xa/DYHCKGA8uWc57K5wB3mzGjbZ
Ykr1Dq26owS+HdAE19Suy2NBoa2+j8wDn2OejTH4sFJH3TNL5/HIuPpexpmR+eq3
wSULKnLAfDK3GZKNzTnPnddSs6wxOMXg7ae2GcGxr8YksA05IRVZRcKs/WrMFIFe
hLIWV3GjCl5vYa6yQqTpL6eT0P7DkQUJb8Dtv7vuPnFiH959HDRRqdKiVZVPmmri
AnKZwMz7meempOuMaJsI8xyDr+MRyqQby/vx+XxCuKYCneOyrPyTKZfXf35b+deQ
t7KnHA7kR4OthCKer0mGMrb9x4RjJHaD4NmrzkDLdZbnnRigpbklkpg86dpnpCYY
MD/Afl6gVMl58QTtFKf56y+E3rybGdjK7sPV89ZjN79gSd2aWzKTrmN3VP7dLO89
CshhWJ2byCgbzACviXm68g==
//pragma protect end_data_block
//pragma protect digest_block
1GtYaJHYLk2CGEJrVIKhKZTAWw0=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
n+WsEv3zNBOqK+MoW/XX5JyfeoaAZroX162RXhAvviYrNd6USZjD9pd8/GxXCkae
nBM9WJgOiRK5VhffpfrRyhVExksoUCvB7kFWQcWzZYbz6Ryxvl42e7FaTfhAYk4f
AfAdHEhY01Ec4LhnaFqvXwneL8jjdttqrEWLprseFL1BeaHvBUpARg==
//pragma protect end_key_block
//pragma protect digest_block
UWWEy/TZc+Bh/D0FzjDGgg0X7l8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
6S8GbtD5qEW4+9oGETyYDmlOhPA=
//pragma protect end_digest_block
//pragma protect end_protected
 
`endif // GUARD_svt_ahb_slave_monitor_pa_writer_callback_SV
 



