
`ifndef GUARD_SVT_ATB_TRANSACTION_SV
`define GUARD_SVT_ATB_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    This is the base transaction type which contains all the physical
    attributes of the transaction like id, data, burst length,
    etc. It also provides the timing information of the transaction to the
    master & slave transactors, that is, delays for valid and ready signals
    with respect to some reference events. 
    
    The svt_atb_transaction also contains a handle to configuration object of
    type #svt_atb_port_configuration, which provides the configuration of the
    port on which this transaction would be applied. The port configuration is
    used during randomizing the transaction.
 */
class svt_atb_transaction extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_atb_transaction)
`endif


  /**
    @grouphdr atb_protocol ATB protocol attributes
    This group contains attributes which are relevant to ATB protocol.
    */

  /**
    @grouphdr atb_delays ATB delay attributes
    This group contains attributes which can be used to control delays in ATB signals.
    */

  /**
    @grouphdr atb_status ATB transaction status attributes
    This group contains attributes which report the status of ATB transaction.
    */

  /**
    @grouphdr atb_misc Miscellaneous attributes
    This group contains miscellaneous attributes which do not fall under any of the categories above.
    */
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   *  Enum to represent transaction type
   */
  typedef enum bit [2:0]{
    NORMAL_DATA  = `SVT_ATB_TRANSACTION_TYPE_NORMAL_DATA,
    FLUSH_DATA   = `SVT_ATB_TRANSACTION_TYPE_FLUSH_DATA,
    TRIGGER_DATA = `SVT_ATB_TRANSACTION_TYPE_TRIGGER_DATA,
    SYNC_DATA    = `SVT_ATB_TRANSACTION_TYPE_SYNC_DATA
  } xact_type_enum;


  /** 
   *  Enum to represent transaction completion status
   */
  typedef enum {
    INITIAL   =  0,
    ACTIVE    =  1,
    PARTIAL_ACCEPT   =  2,
    ACCEPT    = 3,
    FLUSH_ACK = 4,
    ABORTED   = 5
  } status_enum;

  /** 
   *  Enum to represent data valid delay reference event
   */
  typedef enum {
    PREV_DATA_VALID_ATV  =  `SVT_ATB_TRANSACTION_PREV_DATA_VALID_REF,
    PREV_DATA_HANDSHAKE  =  `SVT_ATB_TRANSACTION_PREV_DATA_HANDSHAKE_REF
  } reference_event_for_data_valid_delay_enum;


  /** 
   *  Enum to represent data ready delay reference event
   */
  typedef enum {
    PREV_DATA_VALID_ATR  =  `SVT_ATB_TRANSACTION_PREV_DATA_VALID_REF,
    PREV_DATA_READY_ATR  =  `SVT_ATB_TRANSACTION_PREV_DATA_HANDSHAKE_REF
    //MANUAL_DATA_READY    =  `SVT_ATB_TRANSACTION_MANUAL_DATA_READY
  } reference_event_for_data_ready_delay_enum;

    
   // ****************************************************************************
   // Public Data
   // ****************************************************************************
   /** @groupname atb_misc
     * Variable that holds the object_id of this transaction
     */
   int object_id = -1;
   string pa_object_type = "";

   /** @groupname atb_misc
     * The port configuration corresponding to this transaction
     */
   svt_atb_port_configuration port_cfg;
   
   /** @groupname atb_misc
     *  Represents port ID. Not currently supported.
     */
  int port_id;


  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** @endcond */

  /**
   * @groupname atb_protocol
   * The variable holds the value of ATB Transaction ID associated with each transfer.<br>
   * parameter svt_atb_port_configuration::id_width.
   */
  rand bit [`SVT_ATB_MAX_ID_WIDTH - 1:0] id = 0;

  /**
   *  @groupname atb_protocol
   *  The variable represents the actual length of the burst. For eg.
   *  burst_length = 1 means a burst of length 1.
   */ 
  rand int unsigned burst_length = 1;

  /**
   * @groupname atb_protocol
   * Represents the transaction type.
   * Following are the possible transaction types:
   * - NORMAL_DATA : Represent a transaction sending NORMAL Trace Data to Slave. 
   * - FLUSH_DATA  : Represent a transaction sending FLUSHED Trace Data to Slave. 
   * - TRIGGER     : Represent a transaction sending TRIGGER information to Slave. 
   * .
   */
  rand xact_type_enum xact_type = NORMAL_DATA;


  /**
   * @groupname atb_protocol
   *
   * Represents all the data bytes that will be placed onto databus as a data-word
   * or byte(s). It is stored in byte-wise format and accessible as a collection of
   * bytes. While placing these data bytes onto databus, Driver will align first
   * byte i.e. data[0] to LSB of dataword.
   *
   * parameter svt_atb_port_configuration::data_width.
   */

  rand bit [7:0]                           data_byte[];
  //rand bit [`SVT_ATB_MAX_DATA_WIDTH - 1:0] data[];


  /**
   * @groupname atb_protocol
   *
   * Represents all the data valid bytes that will be placed onto databus to
   * indicate how many data bytes from ATDATA bus should be captured. Data
   * bytes that need to be captured should be counted from LSB bytes.
   */
  rand bit [`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH - 1:0] data_valid_bytes[];

  
  /**
   * @groupname atb_status
   * Represents the status of the ATB Transfer.
   * Following are  the possible status types:
   * - INITIAL               : VALID/READY has not been asserted
   * - ACTIVE                : At least one Data Transfer has Started
   * - PARTIAL_ACCEPT        : At least one Data Transfer has been completed
   * - ACCEPT                : All Data Transfer has been completed
   * - FLUSH_ACK             : Flush Acknowledgement has been asserted / Synchronization Info has been sent
   * - ABORTED               : Current transaction is aborted
   * .
   */

  status_enum xact_status = INITIAL;

  /**
   *  @groupname atb_status
   *    This is a counter which is incremented for every dataword transfer specified
   *    as part of the burst. Useful when user would try to access the transaction 
   *    class to know its current state.
   *    This represents the beat number for which the status is reflected in
   *    member xact_status.
   */
  int  current_data_beat_num = 0;

  /**
   *  @groupname atb_timing
   *  This variable stores the cycle information when data valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  int data_valid_assertion_cycle[];

  /**
   *  @groupname atb_timing
   *  This variable stores the cycle information when data ready is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  int data_ready_assertion_cycle[];

  /**
   *  @groupname atb_timing
   *  This variable stores the cycle information when flush valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  int flush_valid_assertion_cycle;

  /**
   *  @groupname atb_timing
   *  This variable stores the cycle information when flush ready is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  int flush_ready_assertion_cycle;

  /**
   *  @groupname atb_timing
   *  This variable stores the timestamp information when data valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  real data_valid_assertion_time[];

 /**
   *  @groupname atb_timing
   *  This variable stores the timestamp information when data valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  real data_ready_assertion_time[];

  /**
   *  @groupname atb_timing
   *  This variable stores the timestamp information when flush valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  real flush_valid_assertion_time;

 /**
   *  @groupname atb_timing
   *  This variable stores the timestamp information when flush valid is asserted
   *  VIP updates the value of this variable, user does not need to program.
   */

  real flush_ready_assertion_time;

  // ****************************************************************************
  // Members relevant to Master Driver and Monitor  
  // ****************************************************************************
  
  /** 
    * @groupname atb_delays
    * Defines the delay in number of cycles for ATVALID signal.
    * The reference event for this delay is:
    * - For data_valid_delay[0]               :  #reference_event_for_data_valid_delay
    * - For remaining indices of data_valid_delay :  #reference_event_for_dat_valid_delay
    * .
    * Applicable for ACTIVE MASTER only.
    */
  rand int unsigned data_valid_delay[];
   
  /**
    * @groupname atb_delays
    * If configuration parameter #svt_atb_port_configuration::default_atready is
    * FALSE, this member defines the ATREADY signal delay in number of clock
    * cycles.  The reference event for this delay is
    * #reference_event_for_data_ready_delay_enum
    *
    * If configuration parameter #svt_atb_port_configuration::default_atready is
    * TRUE, this member defines the number of clock cycles for which ATREADY
    * signal should be deasserted after each handshake, before pulling it up
    * again to its default value.
    *
    * Applicable for ACTIVE SLAVE only.
    */
  rand int unsigned data_ready_delay[];

  /**
    * @groupname atb_delays
    * Defines the reference events to delay ATVALID signal.
    * Following are the different events under this category:
    *
    * PREV_DATA_VALID:
    * Reference event for ATVALID is assertion of previous ATVALID signal
    * 
    * PREV_DATA_HANDSHAKE:
    * Reference event for ATVALID is completion of previous ATVALID/ATREADY handshake
    *
    * For very first transaction in the simulation after reset, driver will
    * use this delay to wait first before asserting first ATVALID.
    * For first ATVALID of a particular transaction driver checks if the delay
    * specified has already been elapsed from the mentioned reference point. If it is
    * greater that or equal to specified delay then it will assert ATVALID immediately
    * otherwise it will wait for rest of the delay before assertint ATVALID.
    * 
    * Currently only positive delay to assert ATVALID is supported.
    */
  rand reference_event_for_data_valid_delay_enum reference_event_data_valid_delay =  PREV_DATA_HANDSHAKE;

  /**
    * @groupname atb_delays
    * Defines the reference events to delay ATREADY signal.
    * Following are the different events under this category:
    *
    * PREV_DATA_VALID:
    * Reference event for ATREADY is assertion of the ATVALID signal
    *
    * MANUAL_RREADY: (Not supported currently)
    * 
    * Currently only positive delay to assert ATREADY is supported.
    */
  rand reference_event_for_data_ready_delay_enum reference_event_data_ready_delay =  PREV_DATA_VALID_ATR;


   /**
     * @groupname atb_delays
     * Weight used to control distribution of zero delay within transaction generation.
     *
     * This controls the distribution of delays for the 'delay' fields 
     * (e.g., delays for asserting the ready signals).
     */
  int ZERO_DELAY_wt = 100;

   /**
     * @groupname atb_delays
     * Weight used to control distribution of short delays within transaction generation.
     *
     * This controls the distribution of delays for the 'delay' fields 
     * (e.g., delays for asserting the ready signals).
     */
  int SHORT_DELAY_wt = 500;

  /**
    * @groupname atb_delays
    * Weight used to control distribution of long delays within transaction generation.
    *
    * This controls the distribution of delays for the 'delay' fields 
    * (e.g., delays for asserting the ready signals).
    */
  int LONG_DELAY_wt = 1;


   /**
     * @groupname atb_protocol
     * Weight used to control distribution of burst length to 1 within transaction
     * generation.
     *
     * This controls the distribution of the length of the bursts using
     * burst_length field 
     */
  int ZERO_BURST_wt = 100;

   /**
     * @groupname atb_protocol
     * Weight used to control distribution of short bursts within transaction
     * generation.
     *
     * This controls the distribution of  the length of the bursts using
     * burst_length field 
     */
  int SHORT_BURST_wt = 500;


   /**
     * @groupname atb_protocol
     * Weight used to control distribution of longer bursts within transaction
     * generation.
     *
     * This controls the distribution of  the length of the bursts using
     * burst_length field 
     */
  int LONG_BURST_wt = 400;

  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_atb_transaction", "class" );
`endif

  /** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;

  /** local variable to help in randomization */
  local rand bit primary_prop;
  /** @endcond */
 
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HQwUnAIOxV2PgJoTxlqhJIbA7zdZfK1Fub6oM9e5DQDGE9EeABH4DZRRwCsgIlKf
mwK3bUZJev4AZJ5VOzd4eOgX0eWAy5WEoI+KGMmJYIE0yPQdlRWc9blg6M7ZuTpf
2tty4OMTxPRC0yjdvACc6Ep35VISFtLOKhFrHa40lJw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 743       )
42bCUI+gD0YWmSaGcA6RRGk5WMaPGBI0WjmvZhN2Kah66btsO+nFxDnN0W0SteDa
8r7vaxtDZiRgzinvrh8Ml35g5M0qyRIFbKa7aFttvsgIvpEdMB2Si9f5h7aCO0GD
v0/1D0xjApASNLZWUiMUVnnTGa08Swbo93gEpiZSAPILLktQQs0xX3UhAg2rcq/c
lvgoSJIsydqwPWCxH0Dr6I6sWa0e0sap56Wibqxlc717rqKYHEO1dkGy1sZWYi0T
4pJfjrhc6R+6O428kjRGu7y0MVkhDDD87HJKPVUbYV3aeslUoOUNBGtjoi21aAi4
JPQEnYEY+jjRfGJKshkAM6LMBAGhRSuO+yTNMmRy2c4vNdhfUQGmvrtRIotgD2eV
Ib0qBXdt/1PtuiIri/x8eEXjXF5g+kBh/h0xiCMQ9/UYQQ/muo6FVdFhWSGRgWdJ
mJiV3ewLuRqhPWkuro6twyXBox4Wot3/KSsbx8+Btb4TlvOvAMFqAHT4LTQ3siBB
5pCocNrTipmUYRlJIVPYzQzMjN1prgZUUvhcmqgZXivX3EoeHus3Ic+Vo2Bn3BSG
cCQBt4cER6707RpkkbymFWYugnJxtJr9Dbnn7Ec5/0BIAY1roQWVqtx+Nbye8bZX
KhwxeDbyo9eX+T4FALzDGe2eLfVIEZ03Bto30AHNULVb6UdLvKgYh3sf8roabPKi
JZt3EYYO1m8hXBJ2ht844BIfQOyfwSXJbFFy+/6UcMjp4sFTfm4ezMwl7V4dj766
sTT/XREy6unut833sy0zAyfghEra0GpTlnK4OxPNprAARyalTelZrzpQsV795ZoA
B49UDJOpDSSDKhdyyW5cvFPFM1oLiPZou7MGqYo7AgmQ63U8L3+REaFZtMqurZ21
i9ZSS4uchsQ0uxX21ipVVGwG0pSdSK6fJvrwonni/zAL6+nmT9IpCoj1q7nWgdk9
hPDxR8Y998uhTkwSDHljsPP+VQ9ej1dSQV3jgdBoROY=
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_transaction",svt_atb_port_configuration port_cfg_handle = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_transaction",svt_atb_port_configuration port_cfg_handle = null);
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_atb_transaction)
    `svt_field_object   (port_cfg,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
   
 
  // ****************************************************************************

  `svt_data_member_end(svt_atb_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

 `else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

//-----------------------------------------------------------------------------------


  /** Sets the configuration property */
  extern function void set_cfg(svt_atb_port_configuration cfg);

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);


  /**
    * Returns the data in the data_to_pack[] field as a byte stream based on
    * the burst_type. The assumption is that either data[] or cache_write_data[]
    * fields of this class have been passed as arguments to data_to_pack[] field.
    * In the case of WRAP bursts the data is returned such that packed_data[0] 
    * corresponds to the data for the wrap boundary. 
    * In the case of INCR bursts, the data as passed in data_to_pack[] is directly
    * packed to packed_data[]. 
    * @param data_to_pack Data to be packed
    * @param packed_data[] Output byte stream with packed data
    */
  extern function void pack_data_to_byte_stream(
                                          input bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] data_to_pack[],
                                          output bit[7:0] packed_data[]
                                        ); 

  /**
    * Unpacks the data in data_to_unpack[] into utemp_datanpacked_data.
    * For an INCR burst, the data is directly unpacked into unpacked_data
    * For a WRAP burst, the data is unpacked such that unpacked_data[0] corresponds
    * to the starting address. The assumption here is that data_to_unpack[] has
    * a byte stream whose data starts from the address corresponding to the wrap
    * boundary
    * @param data_to_unpack The data to unpack.
    * @param unpacked_data The unpacked data.
    */
  extern function void unpack_byte_stream_to_data( 
                                            input bit[7:0] data_to_unpack[],
                                            output bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] unpacked_data[]
                                          ); 

  /**
    *
   * This method returns complete data-beat based on databus width specified in port-configuration,
   * from data_byte array. While returning data-beat it considers current_data_beat_num to choose
   * which bytes from data_byte array will be packed. However, if this method is called with a 
   * non-negative value then it uses that value as current data beat number and chooses data bytes
   * from data_byte accordingly. It places bytes with lowest index to LSB postion of returning databeat.
    * @param curr_beat Specifies beat number for which data need to be returned.
    */
  extern function bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] get_databeat ( int curr_beat = -1 ); 

  /**
    * This method returns complete data-beat to corresponding data_byte array locations. It starts
    * populating associated data_byte array locations from lowest indices with LSB bytes of databeat.
    *
    * @param curr_beat Specifies beat number for which data need to be stored.
    */
  extern function void set_databeat ( int curr_beat = -1, bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] databeat ); 

  /**
    * adds array of databeats as data bytes to current data_byte array.
    * @param databeat Array containing set of databeats
    */
  extern function void add_databeat_array ( bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] databeat[] ); 

  /**
    * adds this databeat as data bytes to current data_byte array.
    * @param databeat Data beat that needs to be added to current transaction
    */
  extern function void add_databeat ( bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] databeat ); 

  /**
   * Does a basic validation of this transaction object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
    * Gets the number of beats of data to be sent.
    */
  extern function int get_burst_length();

  /**
    * Returns the total number of bytes transferred in this transaction
    * @return The total number of bytes transferred in this transaction
    */
  extern function int get_byte_count();

  /** Returns 1 if current Transaction carries Trigger message from Trace Source */
  extern virtual function bit is_trigger();

  /** @cond PRIVATE */

  /** Turns-off randomization for all ATB parameters */
  extern virtual function void set_atb_randmode(bit on_off=0);

  /** add ATDATA as byte array */
  extern virtual function void add_data_byte(bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] dataword);

  /** @endcond */


                      

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_atb_transaction)
`endif
endclass
/**
Transaction Class Macros definition  and utility methods definition
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UpQ2G6tr14LqeKFgWnbm83NTH3OU+ot9Xr3AksthjeCG2C9GfdRm00aMF3lphUA1
BkrnafkAlUu2s7BuifMkYGBM3E7db5x3qLmu7T6PChszHCJB7t5BtNksHTGu4L1G
1q9kJFa2zv6hK+GrVJKUtxX1yEILavhD3iB2U+c4t0s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2401      )
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
`pragma protect end_protected
  
 //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NPbdEPcIysqUM/uJEdYi44SOXaXhn137AHQJFc11y5n7R+fLpyQ4AVpPgh+XbTqp
64Ogy8443C4occywTiyvkZPSx0tG1ivBHhVhBqf8GnSd3Uy0XY5cM6Qma9woqwgq
ivTHBVpIj9uaoWYkPP+V4K2HRhVkB/p9N10WwtElLSU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 42677     )
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
AeFQmyfq3c9MwEkcxzVnAg==
`pragma protect end_protected
`endif // GUARD_SVT_ATB_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XIr7vs6Y11E+so306H4QEKK7lSYdP3+VtsxdltgzYvHxOJPasJaYoPAlmwlI8vnU
y/6ZNx9zKfqJ2LMQU30p3r1aQzb2z+47rZhqLbgDbWbk5EXle9u3QGhPqnp2kuXI
E6fTF2NbM2MN82hAT21Hl4Y179RvMg1NbVxIUlB5nhA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 42760     )
+Yq/Y4DfRKkbuB193tcL37kboZRW4jEGLg5vxj2D335KlnjNwBZNw3n9VGFQi00a
7av8Y1RdrFkz3qc9v2YQSLl+8apeRf5UtEYwqq0WGHy29kdIXREJvLNjg8JRg3ru
`pragma protect end_protected
