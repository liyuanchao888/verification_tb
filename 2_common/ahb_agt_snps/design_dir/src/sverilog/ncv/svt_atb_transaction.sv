
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ztmVTlcITZ9dCr6El1pd9NIJkixPfVmsbj/OpO7pO6JbnSwfB/TwLq4/vaIBXlk/
VixePLTuc6VOPRKiWXLWse6uVHOKDEE6VIaAnhvrn4UFqCCdaCwokIUASXpB+oWm
qDQR4SeZirYPE1HiryopFP4WlLccsFDaXNKEp22pkcDwmuxII7WRXw==
//pragma protect end_key_block
//pragma protect digest_block
wXlEsQtKe7IDgJ1N2KGrDzyHeyg=
//pragma protect end_digest_block
//pragma protect data_block
3rV1e5T0p0bb5Tx09xc/O9X4ng73njDsy7pziynYttGm7uV5KDw5CV5LoeXu15sJ
fcW4Wp89faAhpeWJl5++P/o4mhuOfNM64L8yGZNUCN13MIzVz+A2egye/mj0X65O
z7uclxOeSZngor9D8h/FUadw3htmL4q+jDvv7zNVzM/NaZXk45FCe6+ZJf/o6P3c
n0/CRYhz2qzyrc2VIVmxJN0Qrs3fJ14VOFDah/s6NqjIyLdmuq2IwxkT5Y8IaxiR
SD69KARyaS6c1MQTMdGX4ODPyIYcjVIWe7LDUQjK/qxIaFyP1Y4hvMLVjN7VfX/g
PL/6WhlTmv2frrkYH62rSfBYwRo3HsTgUcbhLHPHo/+A06IqSPgSATMpTjCqRRHo
+T8hq2wtX1soGoMZ+N+w5xpfwHU6y5/bxrONgLyHO/apIswYhr5WWOXN4fM05kM8
Jve79Y/8VVkLEyGaKkTKyHXv2b24hDxSfMB7LrbHY9C7OY5XWDQt8haUPkP9Ow0J
MpMEULpMyJ9xYwssLSNQcqxs41/6DjGN3wlUEaZ6kM0MgjKDFsqzwqAYaSR3ecp3
sek2IPRZpcynFJS8dOGxyCjlQ3QEl/srM+nu7BbCHa0CacHq2PrLc9wm9Y7mt1F+
VQ71hXlbeOBHnFG6AbM5uh7PC7niKBo+ADTxaJa6hqkod1MRDP48ABP0uMa9A7Gr
9YtcF6USXTdg8oJWg6vmNjptcBRbNS0wbvI7Wu/X4b8WYjK4UroSQVlRZxq7OdaT
M3Qsob4y5J3dMaXKOhAQDbaGlIu9ZDQly5tHaCUunP3s/ZyYU43SAhrUYJwhPoaz
5jvKcShDNXYeoUPBbt4JAna9sGzupJQjoLac08lAoz4NLUFRSSG1plDOoqhI2RSg
T/3H9rlNJyT61Rr4LkirZrLOPKMki2rV3zd5Voa0ifRCy9T2gSK6XEVkLjWCNaLX
ukPVqpzBLb10sosZs8+atYXwkI92dP1n7LDL2yK8f9ntwF6nUN9IzO3GNQjtyYNH
EOqYea/mkV+Ov9lMYW3AQkHOzC3vYXBGI7gVy3f3PoMQnow7NTArVVMBjB1WY9To
jEEa+1y1dhCKeIFwEuF6F9EiQxRuXadC2NvDTfzfNa/aqGlNkH2wMFOAXjc33cDJ
1vqlIA2SNC5C59GqL9MBdQFk0bHQeutsrFSZxo3Pbjh6QtoGrkBVjtqjYX83dQPJ

//pragma protect end_data_block
//pragma protect digest_block
mZoFLZbMG1CZcoB1wvhzv8E12Nc=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TQJeMs98fp/vQSDkPXjlNBLcdYI6C3wCCWJ4nb3aevqizwheUH+3jeZ7ZukLY8em
hdhQeGxo7U4X5upsbSrMugwMlqwRmoEkI+fUXmSqq8X4Po7m50UpWWdY7oqNgn8p
k6zqHyaPst74YdNmt11NoI20SRyhaMhFfjf10TdzhxicAH42oAQXfQ==
//pragma protect end_key_block
//pragma protect digest_block
qNyz5649LpL1JUEUjk7jGxMypVw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
QwKQR/7evPcq3hj18C81wFdpj80=
//pragma protect end_digest_block
//pragma protect end_protected
  
 //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
e0Oj8TFwQoOxIcvOCyUVIVRUeL5gSfo9Pe4xrumh24q/ty73DGr68aDcLrH4Tt3l
YKTdFD9/O5h+WI9MIfoRqtm3oUDO1debCwAeivptQ3owIMQm0yAi1CRz5j6oHqrO
7QkBKV+9MiGfefiiijYHMBx+dCWshf8FoPMdWIDsTbW2KRTQZ8oIkQ==
//pragma protect end_key_block
//pragma protect digest_block
drohpGqZemDQYq48uY4YIdhryvY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
157t/L2Gl6CEwqKSj2X0UpBLJSg=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // GUARD_SVT_ATB_TRANSACTION_SV
