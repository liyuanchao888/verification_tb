
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
`protected
J7H5K\Q+T>^T_g3U><Xa7SQLc7Nf4:L?c>[#aBAa<RPT^Ya>>&)N7(]^e>1O/8[8
U0V+X(C9+,&LZ>5^/=S[5)^[a-;U6GO_>J#SNDCVQcdRVg>],;#61HdYIC/FWAGe
>^KQ0/21L[7c@6R9-Lcf]^L^)AT,M7a2)C=XIbaNLZ(3Ig;B@56TG;^a5.6K,Yb;
7@SM/5f?(Q9:,UQ3c0:#XX7a^a0YC(8RG:QagT,>Vg6\1Y0^6\7716#+gM9HfgB;
+HWYY?+EF<-+@ZL0C)X]2FOK.:-NFTe#(8e\PP#bc+9_IHH4g3R1QHB#K92bgBe)
BeC,-^bKH-7]IQ>N/GG6U;EF1Aaf\=g5F>(eaKU5QV^eQLg7LYMR^fP6_\I@aCO1
eN#@.BNL;,9f,g5=).TDNgQJB.\MZ>5AHLR2e:9^D5f608ba15gNZWWK,&TdWN^.
3.^3-D5>A1?f?DVEF09c:2Cg]L9=XX6Mg/E4^.C9f(^K1cTe2/C+eOagX1>V#2UZ
D7F((;fCKB283GE^0d<VWA8C8#N4a0/_VH>e=eVR65KfS&DdZ0-;M(TQRNHc:,9H
(/:?^NY1ZbfA4_;d[;\^G(MB#fX:S(<)GV/G6@1#W=QS>3+Ug<^^HSZR)H_.0NHV
\FB3\,(bg<>GLdgNI4(7^7>.ML+=\X8P6;g^9e8EE_R&YSFH,X-)cTLa@fC_.VOL
>K?Y)SD6?#[a7^.?T3(KH8CYCK,DNU0c.d)C^cZ8b^gWaZdKM0;+H.[YU#c_G66@
dAR,2+^:;]]U)T>GW85J=X)4cOW;BS,^A>&/C]Q(Z>C(0X]JIJ\NOGG/(d)L;7JY
8>MG[.@O:TH/IR30[@TcJ:91dL]7.[>K7^<U](F7ZdG<H4]DM0g]<aRG3<C9KbGI
WRUO:84.a34b2JLIfW+K&.JUb@Z@Q6-[dUaZfJX?_P7[J9Y(5>KV<.RGM$
`endprotected


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

`protected
JRIH,c>54TL5R(,N^#VOGFg;K>f18&Of6ae.3H4abW3[V+gg-JEC4)^ddYVQLA5Q
QI51H7:8@_gB=^2.&bWY:)MA?JgE4<>T8&-AT8_L6c7G]>,agGTHH?.\cY1D2RMB
?M+VI^SRc)-</]N&H1;QB.Y@U0=@=-C,O?6gYS:-f]@OI9<#A[A1WCFT>0PBWgKa
^fMS4)@Ng[V9[c&J#&7Q5.PKXeQ)_P[D-?#C\@-Q4MA19CAe^c@/>1FJ_[-\GZ_+
[,cA&gVV4C;\5DQAYN?Qc2L,9MT02b\;M:UPV1<47fgM5@(c+Mb5Q--<JQ<=5FE7
V0^F^_05.RJ0#d_gN&S1:cC4a?:WCfHA<W]PI[aY;6Vd@J^:FfP54,&_?ZX8(>U,
92#GfCIWB&@1-(IL61CecT3B8GST?UaH8HA,.bZZ1QX<F592WdZWNKR0cYP:9d9#
GH[0P19@Y1gVLJ(I;JC;TOda[BO=/?QgIJ6[8+Y+]Z-Z9,,SQb<Y.KRBTB5T0L#d
(<SbJD(fH\E<?:BVJbK>ccZ6X(GF+IP,a(;8E#YXB<\>@L0BRD^NS;4+7=NH<S,\
(P@Y#0FHg.Q>^IN3=I_9PDW)=(@P<W6gC;FbW?eN9#a(K)EW-GSW9T2[M4fXB-Be
(cg?Z<Rd]daZSg]KA#]+MDPE?>T<&Y1OE/?09<V->Cc;(,R,:<dZ>c8+bSDdJ,A<
:K5U\1fZAY4c(@]cXS=I=L?[=K.2&^,XMg5f#\eH\aQF,_QQGDO5L>XLXgGKUR#c
KU<U/G1@\AC7A-ZG8VOQN2JaK[aS4)S-+&#.Nd7Yb#QF>@UL6&0<WZ-B_2YB5>c0
&&f]caE<D^/N:)3/g:fg_)aF+I[R0F@,Yc1Q<7]U3EYHUT#@=9ecS0\Cd@8^1f(V
^<<K1AGI0/WWg>8;QaW2a?<VAfQN&=6V3UN2,QWQHfRM7TI1Qe@5_:>a41?f8U<V
Q=L7_[d>TIU6M9Z:;C<X=_W0;LcHL7:fQO93OD=I@O20(cLD#=#]>67.K:;2,XLZ
T\#7/FMc-5f)IFZZR-#4-&+N#aZQ=4[/G-#a,93ACD6c887;=YU82cW8gAW?#a9-
LLcdGeP<F+\(5F5N0#<fDH>>9KI-AC>M+Dc?3ScRTC]\d2_7dP\TVRKOP)?87VNB
SH:\MQTYdD3;^QU/#e-?dP:&9e/;bF3<KB@gKD/Fe8dZ>KRW5JGP9F?Y1V7?@=8_
SZNN+B03aC?A]S-YV?\&g>@X5AXWeG2E],1aJ\NI2Z#4ZHf:\a/QbCM+cBCA7Y/R
XTJ)Q\Ge8184S@_KM2QV1RTV72J+?A:R;@?(2P\7XULBeGS4e?:75CE8RW4^9TRe
EQRb>GA,bQ8\cK?8#5L.JXUa4K=gI?P]S^B71Tc3bcfRNT]2Ra<@H3f80:Sg(g/[
cHO.7<&I?6DQBVKO@.]Z-3;:YY&ZE0JXa3J]1:Q5?[(])PdZ>,g^6#,MeA5:Ea^N
<b,QRdJUZf@cJ^^A;fP1JFEN0/]c:#QNR19W=;7>H^4<U259U9KJ&,<JD@#\T-=3
G3YKOWM+AJ4=C78+V_#@G)JTEX0IMd,/a@^:Pe.bY_7=?N13(eN_P:@U8>_I:^eS
6K_.G@I>\Q>cF@/95]DI(UH1]]SU7O,R\L>+:P)=>_6AB9b76MdDX[NUWXZdP/OD
M<-RB<MZ?ZEa7/gWN_.K?\UG6BBB[4Q^6J2Ge//WR(^T3WRVQF?UPTQa]]_-:@cM
[^[P((]]dN//IaATVfZ+D\H]S.1K-QEBF&Tb/_aTLc&^ZFQ&>I9R&4WfY(FeN,a=
I1_EFASf6F]4.?A0H_;.e(X#2=cCZZ_#M^2,N;^C_36&c:#S]@P2;0A)#G(6F>a,
YC+[<N=L([GG@?K\+:X(e?X#4$
`endprotected

  
 //vcs_vip_protect
 `protected
)58R=Z(=<PP3Fad>^YS=LU8,Sb7bgZBXUV4G\>MSAf8387MaX>S:6(X/W9IZIM6+
RUZH;/=#G-[9\;==EfS:a?;)8\2HX?5)(XH#&L?Q2DL>4);.PXWKT3e(\VW(dA,>
Z^#,/g9)FACD=,6G<^A8HC-Fd6Xd6fH(G4+T2;f(_??4N]LX8cQH59@eFA-XWM^6
#VSC[80e>)HFa2PX)4O,Sg3A=XIe=3aB#J.;K&HSOEZ+>CLe9>.@?7O4LJ(5d=7L
]B>N^8,KO<+.7GSN-P-&;>dM,[_7-HcEe+ZDS7J<3a^A3H#bK[9TbSB[Pgf5[#ST
1L-3&XC\>B=bd?8E,UEeS)SH8f^b_<V58L[HNW50da-^b&K,2@0@^@_R</SL4;4H
=YH5.:LL(MT[@;FW^.LFb?aQY^8SD64B9E3+G?=9R3=F]7-;Sa+KY7L7\5ULB&Hg
MPS+>/YU2>XB6e;T,6V1c=GM?d\8Fa-VB8)W9&CCUT-E(b.EIZNY?U)MZ<\QdDRd
W)KV.gTWF3=?LIG.aKG9SUeHWD7[BKRCYf8M]H0e^]g^6B?Wa4/YBVBPZPRbLEE>
<d2F#9F,;(WT5D&Vbe,?NWUQPYa;)@)e_XV.&I]5I^=JZa>W@V9KcGFc\V\H->R,
OfBGM]-<fT>IQ.aO=KH(Vdd&E6)(.&XLb+-,P#B=PcV;M,eY3:bRLI\f_\4[fSS5
[+LWJa)KcU]X<:U]/W2C5I/LEbW#^S/.I=)WQ<(8NDX4cMU=]U\9_&Wc5\P-;_&J
MU>RE(PKO)OUdATZ_KH9ZB#Y^]8>cU=P)K>[TdP@d33D_XWQZTaN#SW[TD1PS?4I
ZKB:aN-^G=C\4\)41,HH@cW[AbK8Fg@]\C;3].G-8M@>6E+=QI^QDK_;&BCa#K[(
V]38P\Ma1c?V7F5/SL_>9#+cLZQ+O;^CL3>93O]3E8gG_7U-dX@NaACF1Z;KDT<R
(:<:.=@BF?^8W]D2f1HGEe.3B[0FQ+T(@eNE>P>Q,OUEeRb+]?.@ZCKG3A.VTb/4
@-^2<A6X:]>N\e)Q3bYCK,C^\QTW525U>@A>O>.Ec0_SB5IPP_[U@\DaJN5e\OGB
53A/H&0ddU=C?5#W899?:&6EI1(853g8N[e,.D(,YAdCA(KN=a72RM?7(HL.<-]E
eP91V1,0egIJWd2G;55WCNZefF)AE(OP@O&bY#gG#.E0[U+83fD]3XW38A)D4e1-
M.<^FL>V/>Y)2A7H?_43c.08&QeP?D5T,RR+EG^/P1#L.@(5F75;HMddCWCdV84a
NBc[P8cI.af4U.+AU@Q8A\\#MI)R=Ja.S-7@LXI54CH.?D53T67TSJX];;2-+:0A
bL617VBIc&W+H1BA0]F8=FRG?.c=@??3ZdV6QCX25]3@._[B07cO#gOW.QDVO/Hb
(<fdRQ96-?e4dM+^HRNS8C9D9KBVSQeH+G)@RJ+a22[_FXV(</:]GV7-UJgLFXa2
5.09+25Z-.8I7YZEOW;f+]&\f&F6=OWXQH@De[>?.QCL#b6dQ]aPJG26S2V+&T76
R/3[Y0QC5N&&47-=[c(&HY+fd,[e=;GbT,BJY2[-fOK,8_3?DN/^2GLY@7UaWcbG
VNV[d8^,1^A6,DV90;M\R7:>,e9BaYY:RgC@Q<,2>/X2aRdTW&I<O@[F24fSH@RA
6UTbW<a:GG)9,_eB<6b\Q[QM+R2#,,)V13?3Kgb4fZ9Z;(F;\<W(Bg#&1(1-;N@e
e.bD8XRXZ(=_]Qe)=1TTHFS_N+Wb@S2D6cEV227[L&f1XB4aY(B]5@cU\&SW6?\c
T^)V#)TOccdIdM=ULb82dB-6\0O>^g/<\>8RT+Y2,GGZT4K8#3Gf@+=<HE9\=]]?
9NF<,=d#BB85]Y>64Y+H.^4+a&508TI2P#+OW/FeC&IO:[-ZOg\7ZTY+[+.aeWD&
^=/?FE+(R3H_QX\#+K#N,[.f3O-4Hd[fBgH36#TN^ba?/A:<FME[K;]6@Z=XS&G&
:faV1c)7_J(<//EK]]9E^O(#WU.Y9Z-SYJBZQDQa2fc\[K+[@<BEaQUJGSf2V9--
MWM:cIAQQ]Ic8aS74gPGd),&)ZLHI]fN0);\d<#6QeW)SUFeGFAf\_3_U\:+]RBc
[R=UI<\JWIJ[5;dFG.,d\G;E?27I)aLOM0\d\]Z<TR^XQMd?<;eU)cU,8LLSd<HZ
c)M[&A5F7QXJ<LR]&8g&SbX^5^ELDA(U9+8>T:/e-aXS2W<R8Z;2WR]?Y[;3_>f.
RX3S:9TL>6X]]HDb7/<#QaJ].U#aT3))N,9<:&\JDKb;C/=eKTOT.#[]ZSL7\/4,
=;\&Dg8dA:[_6,[^BGb0)V^4UX1)Jc3M--<f:N^PPA+7DYg,TK)YcG7.+5cc1LI,
AQ<V4G?_7I3bK4QJM85_K(J;_OScCYKGeC426S,Q\S1J[dDWC#e6^H[8\E]3)7d?
G-+EBK+I9&680Fb@HU;NA=[FQf.9?>\&FK>\9/9HIN;GM16#M9F4>f0fN2V4640_
5UC\WXO0_EKO.Y4/5fDD0Tb\KA/@#]Z-e:+K4<@+bY58BDSEfKfXBT4aR8\^[3eV
E7[/57SSB]MUN^aTMDbW0=7<I\HU0ZYZOGaHD?5P&0KU0?^49cE^83d^[W_R+L:[
SVMJTIc-&R7d:\(0&fgJG[Gd(8]e,(2,#5&@YFRO-LO4<RfUZR\_K+]g=NO<KHXb
OgK(UX-]H)H+b2b#?XS(/.c.N^7F3O;^@V_PK1=X[-Id[a_f^eg7/PXg+8cbb9L)
=f0O2:f/:2925b^SeG-#+41>3QZ32g/E#/2LL3N1?JLS7=e-&/KBWgE4f=[:3MTN
fKDLOE78<C?N#[Rf=^Z5:g#dIX]F8[):Sf,4(LFZQc@O7NF0LV+X4CQ42KU-fXAL
:3Ja/\J;IKXC&@5&3[??KC=b9(a(#e+X7\?.<E^FA^IYJ0@N-;]C(066::f.0Ga[
dg69M,=>:+UY8bC]O@#c>&@TGVJ#A#_8>dc0YUV>W\acU;5NfT4d<e#:VRf^)>17
4&Ag_@N2UQ_2,)XTP1GQ,#;IN-A@K@J,.A@C]W3_EAE4E8B^CAZR8U0K?WP7UKQ<
5L[,FMO1;JY/NW^QIFSI;]d8:eaa&eV#YUPA(X67M981g;S/--8(.b\GZR-]-TQ&
[KC6ENLAFb7^;MaE,[.=YP&U)S0(Z8f,f>5HBG?.@gc-(URXPZZ^f:.Q_Z;^^Ta<
5MMaJWIgVSGF6PceJ&YZKTZ=F]fe?OSNA6-ZU536_Tad321)U3Y;HBOfE+8=cEfV
V_4gV+SgN3S7>[R((.+L>ESf?A-[<?C<47UJP181L3#a\.>R<Se1ER>fMDWfCP3a
CN]-WfKC1Vb4#IS>VD?WT,1S[&8/H7HP58U[@E#fEa20L/-533\(]&3LXVIN.2PR
&b)aeI3dE-5G#gI6,/N;7bN5X-CAc1)#8PS).fMDcOJ9AefNgGR@J1BV]4SeCX1X
[^HI;]DKYXFA8SQ/EaV];2<P1J(U;(L&/5-^SX9JQ10#;C:W>_VNIGeAA6K6Z/(J
/5&?fJ+Le;?5=N7OUe5KVBK0;(@IE)S#.ZUL15Wc7:5WgL)0X.[+KJ&45IS#1\-K
L:P\(\TEf56M:?NW[I&I0.CdIK1fEcI8)A34O=QBA0U,>e_,[Q1ZcWE+0E03ZO.;
bCfO\GR&NWQ9X2\4D4QbFVES\?>ddb4FE8==K;)[&B;LKG9c/-/a>7[^NN,&)X>/
\ZVfBBWJd<-\H)KYMfU5[?Y[L6Z?Y>6QIC.(Z8^12]E(7P-g(FC:.MR2Q>5:17eG
L?Ycd:TY+/HXP:?&,0X]F\EDd/8#c0(_WIOK3+AD6dE3/R<2BA&01JbWAcZg7f7S
3<a[[+AV-\d.;cVJN;aX1[@Y7cU=)Ta3L(Q<5c_Z0I^ZB_^[=SQ3+>2063?EI9;/
8eNST_5#O=\b6&#BK0G]AcS>^]4Y8\BR_&I@e3cE\EPW)_AI;7-8.?cfgB<K-6UJ
gCe6N.[fBSM]6<V2bc##Q>KEP#fcXB)0X^APYRC7&;62JGa6J2K.4LV4SB\5SD<c
[6R2]RC2/=H81O/a40Z1L7AWZ)b&>4Q.:B2F8U)0OGAKS>0VW]ad[)M1UW1)I+6f
9:bXPXFV7g_4MdD13g#YKUJ;Yd\7/2QH//^bG3[JRY]d=ca1@IEUQMTDLI(ZJc.e
_V4I==[cZ-d5g=^A=L5.@(.K?XDeA+&^_>a,70SV_Q2?HVF=DPL[(a85TL+#0SVC
=Ye_/?QXOMBFR+FYd#]@VG9HT)G6eY?1bbDV[6W;&1[N9cKC3<)I+D:5+?Z2ANYf
36Vggd#H#&1H_Ab9V0\=@9VM3JAM&=:_TaeS&VSFTT8,EG\9FG9((J86:L,@6::3
#-6M>Cd(KI7KG3\+=VMf3>PX+^9XLI,P3\FROFYDQ0L<Z,1U-SF&=/:\M1I3c?O#
8CL)JG-XBAN-)_7]D/H7Y/)F9<EH9:YFM<d</-JNFdH>N.DdZQcQdU>aYP:TF\aH
;N^<A4FQNVVgW_9Z^JWN-?E)@YPf/f/.\[NbVUW1JS)<HgfG3Z]MD9T?W5M]5TNc
Y8ec5_53bgfNL85Hf]6Vd(b?1.BXF9C)())9HYL3J/G)&K8-fYY8NHAV74]7@]e>
_a4EOI)P.XDU,U88+8&c-\2cEe1#[I/MR5b.2-0.aE3=5:QUF&QB<<&b#88ZI<)6
4)cPT+4N(?2H+XQMSb6]/E.g3#D2Z;&Sb?e>>>VE]^-_76H/dfDUf@=63:4CFBNP
RCD+?Mg]>)B[O,-Le<9M5HaN4E34D;:N3@@9HN^dU570R[OBM1eL3K=@(dgdOGCQ
.4;[_)GALF;-I=@8,54IM.S_VVMX+08[\J(=F_I3<Na[M=P&5L4WU:X^7()gYG=C
.e-OWZU(5QL;3>2a81c,B+5Ua@DWOX8OMID6E4bL@PMSOC-=:^)8[22J-8_(TC/0
3_/)6L0;H],QG#JGRYUQEEO2\U]Bg\_LLQGaE6;8+\1U&[<1Z/MH0^0L(14R2\]R
4FeEgOKV@.6_&YV)&PR5C\8/>;7][gHU-MI=.[QMOF+9?7b[;CFIL_SLY,K2VAFM
@+^gK9PA4)Y#Cd-,_O0.fMV<HA58\<(4N<B,cITBR8U\Ta<3MVIN@;>.W@YdQbg7
-+TJd+XMK8Q@572B8PQ5GF&c]&J:d,[G44IS7b]&]7OM4VEK^CKY\U)2Y<00^RJN
YXW8fOBOaPccd&]MQ:aVC2CZ(+8,<QgTSReIb/;WR7cfY2D^&\cNTHaIT3+\>Rc9
_687ZLEAWS+3]F[^3+fXZTF8:;.S^S&e\TW9gSH^A?,g31(DgHF<=DS]SC)4/47,
W35)(&6V#XZ\P]aVSK@IC/&7U#Z0.SLO[#^@GPgN7FQ[\\47OJJCV[W)4PW.D)BQ
-/YBTJV:P[5LQ?82E;P\#DXWZ]XRW<H.(;;S&F[I5ZbP)f0M#+F1f/3H98?&g92S
R\X9WP>@RUc+-,S:cO(2gJG6PfOL4Q7#XF9@b.MSG=[PJ]ga3,XMQL:6^M.XUd4#
&<5>Qb=(OH#I?1T)16B?2:HAJ?2Je-f#):)\6,OVLMO@Y>K(7DBRGT1)P[T,+MKO
6;a[<D6RGRX_0gI&C&<G-LeQ4\=E]624H]IGN/FcVJZ_J2dVWPL^>@JKH4e6M<F8
D6UfFZ]N<A[ETS&bNSBFIO(8G?E(QIMN8<6dR1AR.UK58#<-E)@V2W56UQ0e;,PK
gaWAIe7\N52<WT&BN^R?Z#?+2\,10\VC?&,gISAP@JcG@6Z#@-ZC\7C6GL9cE^KE
MQ<JagTKBLgSd^EKf&/AP+P9[;<EWc@BUIf(_)(cfe_e0@gH6U7D1OR2@J=9[0C8
BK<=#?)<-2,feC]+0/S^HV/TBL.PP#:XKAc:eV[3XaL[]UR\8;WK-Ed^GBCTM[Ia
S/4^Q1XE?eW/F1]4<3&;TS4JOVB&.0,:KM)^gMN,bQZ\P<E6Z;:24&IgRd93@=1N
DE(^G276C5U&L+]0f\+M][C(,=H^K&eV?dF1b(g2<=>^4<B,2H.XcNTFe6ZfgZb9
2X/6R)gCT5\VMY[4YVb_0JG4B,4:7-V[8CB0=?V],<e(I,BV4e]>@C[DYS2.6+KW
K;+Z8/Hg,@eB:[;J9NC5e?U-_BY^4MKC2SPV;b@\fac\L8^VNE0^G,ZK2]F=V)1O
X@M)2CTPPXXF9]MYed#b.D3AGH/:ADAIbc_4AJ<)X[]/E0&A3+CSABKBb:\@#URc
07^dW.bJU,9>dCBN+D18^Tf6I_HK>3^P5W=1=bfEIV-cY+^_S&gB:4_bX03bTfH]
K<8C4eB_?VNa.F44X\(f/:D1(C3LA0260G@GS&<)N.eMa2a75gSD>X72OIG4+g4I
Q+A=A1UVK?)KAX]e8\dELc:\^AUHNZcJ]eeeOO73,J=J1AYXT)#MFP6PKW7P3:@Z
64P?))Q.Q;0/W,AFSPEK56[BX5;\DM_TU_(L&BZfF8\(W[)&?8/4&593,-^4IX,J
U?cR4T6LA_Pb/@aU.&F^/H-.UX.(Ie,JV:3:EOFM7b1JS56SFc+8?FU+?DH4#FXK
RBP[>I),_K&CWNeC2d3;D?aPd,,](+?;,I?=N;DZS\CYaZ86AH1>MG:HaF^Zc9Je
0b,+9^/_Ic_-9+7ceV2)FG)M;9AVF_UJ[^5Db[0=7C]D[L(5M7\J.d4M8(DY\VM+
VS.VR2HR-f^##0,UB#\5M4LG=SP7;(=YeD0VDKFKBIV\L6(AV.1:U,A/+-&V>X)G
[TNWH0EC@?_)+V4cCPSd0&OS+;C54IFGCM,(b,5.B7f)IZD?NB5D<JUTdU14:\JW
:gLJBcCd]Ca^G,:9RBKb8_@Ug47fa>TW=<)Z&J:@&RD>9QX0HWKUAW)85e)H94[?
T(0eT/d9I1NJTIf0]0(F@ZP(2KIX\)=;.\KafEB+_<0:EbL(0)>N.L/,cC<31W]f
>LZb>Z81:C;7(PLeLV>RQLF>C(K^Cg16)>TZ_Z&DQ_Se?N;5M:46<4I;&3NGYO(a
)T4O1L@_9PI]M#K.Nb8U3e#RL]F2[SR7#YJ1@6X)S9UGU&dN]8G.9^2:_/TCKVEK
]=SaRG)[SaR2W8L[K0:X&F&K@;Zb9[cOHYcaS;J3I&)>_9;Z\J69fT?WcR1B+b,W
R4XT?_(,ZbJ.7Q<CR-W9[BgC981TKJK=1M>7-GQ:]dCc:d69b:X78-;A0PNCU5.f
)^3H#(IP<]QY6N+=Jb3d^Z.SLd\.4IeNBM4W)L_C-^B_4:GcL2FZKHdQ0\32a#Y4
fT#114S;<JF:SZM&/;e_b@b0_g+QVOX[&-@4PBgfWZ#3WGXI9(c:N319.@g&8KGP
I:3T^8AJ6H<[7FW:+.3&?]X+Z>b\<SBQf;D;F==QYAXH@52f2]PO@7LcDa5K)1JT
ge/4-)F,UcQ^f(C@^:]&0^@0).F#4\?&>(Kf];G/(/CD.fSX(f/ZS6GaMLA.D815
Y0b[=6;A0N6Nc,),)\X@02(]_a0g/)F[@^I9U69WUL+5[bR/f#S.=-dCf#FKK=M[
B2,VPWAOS3I\Z^c/_RRG].I2,D<FUSR_5bTe(&]U9+(1HXgeBONbW/0+]b5U&^Hc
VeA.cA<]9I<F8PAf9c==A8(.e6;J^XeAgCY=)4\XWB^J=8-CJ9W9LO[0dB.a\><L
fQ;f^XZVfDX7BV09Y/YA]eE)>/.Mg0=_K:2>KDBHTHLN=;#RQWMH#^9+F;,0KT:c
EM=S&+U^\.^]O.X;W;?RJZ&4e\]FfeZ2CPcM)Z.CMc9LB^LaE02TWH#@_-3a6a><
g&Q<0CfE]_F449E;D55K9gZ^\VP90[3+702;XD6F8>;CDb[@W@&dJ.e&8RC;LTfK
)E^Y?]\CVC.c9a5YfbZCS3^B\g=+T#dd^-bSWNM.T+WbPWWTKBZ9<aEXESD34_R:
DO-^P6HBPRK>A&UcU,;G-(<[CRaCCXT#_FG3)d;.X[;g0>ERbUe9f<5WNIdZ.Ye2
T;dM;C4RS4[HKF)\^W7,dF[ZNEUZTZ_Qea?A+44L5D/3X05dP,/8I8#(3d:gcUd;
QDd^A0.\D999[573K@J>,:6O1\[dMG^6&UBK4X;UI)dAY5ZF&G?,\&3+I&TOdQM>
T,>KY(J23VGGBf?JTWC>:E;MLd)^Q<9e^;?e1PY1Y)1FYIU,4AaVN94:56CTK,(A
>Ic[)WHSTELfQ,U::-]Q<>#Y.c=HOT/9)C:]/Sa<4>JGH:)be7E[9RI<L6076b4M
-G_0c;SZB)W9da<7/6T-Y17VW#=DV8N^WN-(6O#L7Y;]d8\@&)CX6;<?64?#WEUM
0g[cK]543SHdW?ME/11DCQ_OE6,N-JS31SZS7-5K;;FZ7@_-d3:@g1cIGBd8b?LP
aX.Gae+Q6389b4/YA6ZU);e/f5>KLAQA;;_[49DT4TUdKCcU#_aPIC-332@.R-3V
=Gf=2W:c?0f87X1FGdgJM_&^&M=J8E:CP#YPCSTNZf6caf#7+g.V;Y-7]1?ffYWV
]TTbF(<TKN;b_IQ3U73Z<FN&.bM<7a_YcPC6U:3Pa<UG@PQVbe7dI:a3.72GHH7Y
KLN5?]75#[5AHRgPbcNY.;K_+ag)/V.[aQS.P6,XS_)C=D9#3<P4Dab[>HSa@1Kg
VLSLEQYSMc9]RHT-H,UQgT?73b-b9NgTGeG/TQAW+Y(9#WH9^QGI^^63+@0(\.ZE
78eCBeAXdR&bDI-<R1QYGWV47bdDVcNa:IZASe]&9J>_A5_P2[aTU8:a4LO=a>9,
8aY7P#/2K\[J1c>HADgNZa#+8RIZQKE=F1[VEW5&Va84.Z##c>@]:b0NM6RI0EB2
#LN&O,50PeZ.[gQOEMe?JReDFU(-8RH];3cRI?f&])[6/VPROf-_.LK7<]U6XggB
R?Y9NCcf+6eR2985JZ.JB8,V)bC^@WWR(fgBY__e#,LSd\(LLHTCSYa[Sd)gM6=\
<f4U71bSg0K5/TCK.1_g[b(B+V-Y^C@L.QOH5P=6Z;RQJafgCY\P;baM^Kg[Sd2&
4[J>&@?>bc0J_S?YQU5IaW-KOdQ(aAO/[#7UFN<1>6dJ-#)O[_RN[&2YQ]0Ra[dC
E@.NN4d[FAY62JPIXdPI(036<OQ+9CW\OF92gV7.WA_gIBR(IK_.Ya8fYSKDL/#B
CNK-[GT.e#Vd^(fK+4S)9=Bd:TYTJ,(SY3bV<U>QVO+gU=0VSeDIb-c9=4L:..F1
@L.cJDC]I?T<ZAa8WL@Nd_YeD6\FJ]dN1X/T<I76><a6Y+BL#NWT/MdF464B+:5G
e-KO[d^RF@f\A\<4XT:^19<L.^[X+U/<MO.@EMFgM#..86DOZXg\-8Jb;@^_=4d5
C(5(I5-])8d^c,-\KZ+OK^,Xd5J0F;KX/&\2LIQ(EV4O_bSc6;ZV#>TB:AGP.f/&
A_7S(5,LFFA_]J=C9P+ZBD1\^+?EbKT18Z,W\7]S>d?9ba,+U@?Y/EX4#)>H0(ff
NHM)Qg\eSRaP,^:b^c/I5+)c96:7e#SXd>,)AQ3=;dT6&NY];Xa24g6:0g3J)\/a
=]?H;J:01SM5<ZPS;..<bH5JeBaLeXW;\,H_:A8W=:^S=b1c6A9ZD8MfWFWJTT?.
EJaD6+11[3-#b+c[-\RcIZ_cOB029dHC?c<dMM7/FOZ]J5UYBc;]?^VBcFQ0_L_A
Y@<E]0^9I#W4.-=<X7G@X\-O8Lc^(R>\XG_cFLc/DJ4<Y:ZTWX&<DeGB=d:M2a>B
Y2RW;eEdIS7L/d_bG(F9_8/MO\cHe8<0E/A>?L+bC>KJ-=92A6/0LF6UYQ?)c6HE
X62WGBR.[<U&Y0(Q(.[X;O<?XZ]]R^3YY0OaPRdc)B?gKPd:aYN9eWEc.;)^B[La
)gZ,^LTcZ:?O-QXEKR9e+2=K87,E:R+9a@V8AE/@]DUg+?1;0F^EdJfW)B#,DOBL
^6<6gI/_T=81+)^Kb13O:0E#MYA4XF84J+6,PC9Nda_=IDfDGIKF/GQDUA9?G8U_
eY;<\edWOAN71F:N5N-dMb\NaMTY3_AEK^1(9AR>K3Y;gQ[c=<geEc;:U]^;RD?&
K/FG2_P98?]]40GG6F,B<R,.4aY\c3Z82/;e#TI)d2W,\I=2BJeXadDM>EUa[4S\
O+)^U==184\HfY<5YUP:-XFX6U]/ec[6eQ)XNW-7Q\80-SLKeVKY]CD(g8[@K_9D
B7&6F;G=0GSO4/g9HCAFK:[Y[#C</7M(fdH01[c59A,B,O0/WVBe0(g=)>BCR8Y(
RGgSTXB^T[+(KJL0X\/&W<OY4B<BgR/e9E:^e[O8X(YZ.SRG?;HMNKV_EF?BT9e/
SKO&Ed--F+Y80fHA&T[/E>KaaeK8;)8@\I/bH40/OZ;[<bL8G^eSYM0Qe5TYVJUS
gfg>T9CQZRX#59XY5BG,/;A#2<e^HVQD7LXXY]#F8cY)T31F7;KRGA9dJVWTbT&S
I52X+eaO992M-X?W.g?3D8B^^0dHQc_\@/C@XR:QMM^M(fXX&T\VGcf8@=b19dZ1
2<AaW(M/],AC+a3+,4#@\@P650]4;JY+)XI3U:B<a9WS7;e(g9EWBC8[R4/[+L#Z
E=U_42N2W]N;O,fa(=Y.JP7\=cN1WN&DMX4=EJJ)I\e@EM-\.cG+SZT<K1&]Z&;a
Ce_SVW0M-TFD-^-<2O#B@Q3ZDMGb4X,Q#[fYG>==gY;B1\>)95&P-<bV+#8]^d2<
5/?5#g-#>)XPV@?P8&:2C3dW.dJ,5+Pb&>DIa3OY1UTRg75ZWVK@5;>WF&:d+Kg?
RGFP63^,29Y9,@L^FBJS8AJI\3FA3R7R/G#J2_NK\cER-XAR,@)dPTC7e]D\P<K6
eK6(H/2CH-cLC.g&&^A-@gcBYd+E#(H6#3W;fC8>Qe9])K#Y@LePD=J]NS-aY&b5
--C[AX?HKaQI/PWLN2d3,E2Q>3&Y,OU<;_<.N//gRBP#B>2e@f6/g?RNEED/WBD:
K#^5WcX3UTZ,,SH#fCI0#[4@]YEY3:JTE\L4&T>V_,Q2<3e\M<<19;0D@<\9SKAX
aJI/>Ee,7:SNC5W<Z9b1/DCTfX03.1KV:JNZ?(SS-QK[V2#)FeKSG/_63-:#cD4V
+I-Q1LJU3MLGWdMb##?,JJ??VY1B\4V^&=D+Ifgf\.QJ)34W?\+7Y;79C=g0+/8M
fbV6M+<TL@<N:I(/,LeX8:RPH9RJeFgdM]1,(Ifb3L8SQQY,M7BA>A]9XVK?BQL^
.8f,V+f9U6#]+.2\1J9SRLBM)b/+:NG@4Y6g5X4a#ZUKA<IVV\Ne,5AaS6AIDS?9
P_SVW)0DX\Db2&DV]gDRNGX3W/3Ib[Z1FgV0=?J1EHFS,OK#0#=S9cQ24Ug&0]7R
N2caV&\TEK>WRO&0R]I2LT,:?:#Y^cJ)=D>>1UN\()V?1^<G]Gg=.KQ\e/#d/c-?
75SK:c;D,G(W/c7A=7Ce:6&+Y70<<),]c8+JEJCG66-P>Jc6<3g49=e9.&QSRF,8
98,W:H609bKWZ,@M+^J#P#fI=NS6GCb:c&ZIGIBF]\ZMa_D)AN(A^Ke9:;/SO/:7
?B]3#?O.EF\dR@F..WgYg/U9;7=[P:a8B1<P<9I/?M6;Yc,83]a7I:09SX6f8,\]
DWP&[XD1)0>U_cJ9c@#]JVb]K9SY\HMFXF5(WM,cFWdR?4G4S(EA4<[2V3SJI<Ie
J5fFR@)]?\gMf>_FC>CBf)8.DN1J7(-A6-bWf-8a7TU6L).AP^M31H7D#9-Y2-\W
99G8H9.<XfP/e-+_d88e@Q;-4BM&JHd&;&3fbg3:\cBaGP;DDIVA=;?>_OTFO8.(
>0]ZO[+\07V].GYDZ>UJD#PgKL1UQO<3ETCF8aE,5M0C[(FW69NXK_9,LN8XG3+.
-/P05<c61O8EZ(U\[XK[UYKA:af>S,;CZ++MVPb:P+_XW;&40agfPZ2(ca&JSHe&
7f6^]LF^@0)M&6Y#9]2a&-=UOdV/2PMe4N#@L5?/CF0A-[2c9RMV)6<^#aQN=[E_
g93+a?O/;9[JJNg2@bV41<?9.c4RA,ZL#/7+>O(0f&?Xf.bXU]Y.fg2DDgT\b:8G
.OA#O3a#O_Ud=IA_&RUcRO8F>TQ@f^(T_QF>HC\fL(Y8Gf<&S_/\g5JGKFCULCD4
cYORB(\cWH?15M9V@=TJ:JVb]>ACaW6cP-f8SNJF8L/_7PZ-Q8#0OXMZ0[dR@)Db
gWMY0CcKUW)M&B\^5aY24C8cED7@df,0FVQTc1_CMEb9-f]HVQI[dLL>QW+g7(B#
.-D(.g>_L4?HA\AQ<7M<1WX(6I]Q=F<\C&8/Z_e.\5eP.-\CfN2<WR;6&U-Z-0PM
@9?1_K7^Fc9UACJC8UO7g5KI).,>[2/X0,NL+LBXTgLb1>IZMDf/1L7a9gg@XfT[
W:L>NKS:R\C=[\M/4UEH-ccVX:b;@cVC8aGfM-fU0I(363V<@gBL2/bEXP=c(,?W
EeP<0aJU^Ad;0R?)Xb@JA=gJf[[V))>2=H.^7X12S)?f>IW-)eV1J<>GffZb+]LP
b^,GdTg_Y8IU4Y;.VZ[DZ<(f;.Afg_C)/[SKF0&:<#OQaR5a+8I+^]E)Hd?1O67V
6F.4aee=B?I_[Ve+_^W7/V\G+F\<Y7H\GEYFBW]_Ha[\9K#WCWF?5FD@gG>50C(Y
.aCL3f^X&EXU\=VIfU@I4.+1,V,;JDK[d6=W)<>Y>K1#;fQ_YaP1=5W(N6.GPZ;K
E-9ff;Z)>\O-)+GZ=ScRU^e;4b]ae8&[f>:-Yg[TdOG&HYC/EI0SPQZ&>9S,/dJ[
PbWD(\/VPO:LNN.fS1//?W6TU1fZ(L=\:K?fX/-\(F/X/]VH7;[f.[13&:@fFCKd
cKR<Y(02\#LJI0IHUZ17C(dN@14;fB5L#VW:,.._f50@(c^:9AEXeZCSEf;]X,P^
gO<46(^7;T5:\R#E]C3/L3(Ef0fNA:0NDYX#/DWcZ=W1I#JS050;f=>G0e@OcYW-
+_Q(C9?<-42/XSUU\+D,\TO^V(LB,<IQQ=d&@PgBf)V^20B?ZY&NQ7HVZ^UW-\A\
C,I8^Y=EcL-#8D\AA_;L^-0JD?5Qab&==:Y.SESM-e5H7\Q?MQE4/6TZP.Gaa1@C
X026ReV8GNUU]?QQKg8@CA)?>9CO889[#U@7bR3:I,9.C,eG;O1@J31KHFRT71Q<
;I62ZK,e&6aLIaDQQLX=YQTF0Zc_,)3XLI+cG(1R^e\]f>U2XG7-M4<H\1-8^I.6
F;MF<\@T:e\]NVf&\&7b#VYC1G;d@4)(RKC\6_4.HUaS,0,DR&0:\:1>WDQ@>c)S
(2OE?Y6[g-3#E3B9GUYgR3EQUXY.IH9W[>eJ@1Oa1[JT8)gaX;T3dHLQ&Xb]V&F9
)CD9-aR(7=@=LW(d>M1]3B;#(12@aCg97Q_]EB48U7D]\)@E]TE+f\?XWY.X].9#
<O8VI#M9>)#(64f)RH)NA#g93/OZA9>CZ/4+R-&0@F0XX;4:Z0aX1=F^gM>)J,1#
1G2&R,RJV-];;YT+6#6H5#M59M=NU;YK.O)IN^MHBA<]N/cUH]\Dc-M+J1.-e&AV
1=G_L6@,#JM.>_\AZUQX_U0Q\;a]89?LdfF;JaG,GPS)C)>O&4<:Xbg.DXg?aS>I
J.M.31:SdE+6[5ZbV=CBDc_fUbJc[IU#=K#C+\1C-T?)bcR[U[(83D9[RRS,WK,7
FNNI3)0)^=S47KO?_9R^@J/9e2DO#YO)OKa_,@,CN:\MG<ED</V;\Xe\.>/,/U:2
#=Y\E3b_AI)0ZaD(8?FV)?ae5ge.JdTfY6&Q,W=<(5JTaK=W:@?,KH+A,fXcD.]?
=^86^.W.[NTUPV9J+A3FY)dS@,6ZXb#g=9I&C4A/^@06FI:U9-PL.R=a[;@X.eRC
[OfOZQ(U#EdSf6b+J+5fV#W6^dIQ4a::9E3D^D6^P2#5K)>S@<(ZcI+JM>P^94Y\
X<g-I9<g79EM&7MVB8LbRRbOe1K<\Y_FQFJ;N^dgFcUR.EQV]a(&(4XRGQHU2ZMO
0Z)6f0Ic-gIaAB8\3]Q?HR+9&[9XK7P=B_>b/B68?S9\/Q<S#;GS)]H+_)AA1g5@
J]LHRZJKA\XH#WU4,A9[=Fc^_X1dg4,.J0QCXgCJ]OEaSfffRbFE]P\;&@S<^5.L
/W]1g&_KA6#M:-C=fPe<:&cUYggWTNC]8X&EY7N(]?\5+P3]<L8ZFS:L+2E;c-0c
e\TK-NHF?UNgUL00.aC:BJT972IL^6@KLEaX2V[TOQ1/)T>7;=(5?967002CK-d=
QF_bE(Ng5]-fTL9Z??>L3=d/DI/Y(eT]#4S^Z)R=bYPf.gdK;cMC7R)=eY-86R7-
EO1Y<,HMZXORINDBU=cL&9P^d60Y>^RVA_I\<7F9LNIG,cM8.]=2#Y.&MbPIA-6/
2=ef.cGQcJ@e+D0-(/8,E_\LEUU.GEKVDTVP?BK)?&J#VFABOPNFbD5fO<H?W)Ad
8C#6P=+DV?B8^),YEU9RM-fZRQf<^\1VYHI1cXcG.1Q.=G:\.1=-\Zb@(/^0AMU]
UPaJ>Xfaa#=d2U5Y\aUc8,#?IAV(OXGK#aTXV+V?^d8L)T=#0NdHgg5ZeCON\;74
C?Af/BX>fF1E_H-/eg.WFc5A>IXPa<#a8B:R)/1BO]Jc.K(C6gFX,_Dd(VBSIcc)
[.M#2<S:2ZN7EH#7Q2AA))e-<[4a(77?SDR,-:JH2S#RA#7-\<YRMMPU^VTAbCea
V+ZV=[U?D[W44PP;KJQ.V-[eAEZ__>IF5=9X#8/WWQ>/]QLVK+MRJ@_,2b(G,.8F
U&BZ5Z(_9dL?DUREZKE8G#SPN\>4&L(MCfE</ae\Cfc)D@,K5aTTAaRfgUD(:[@c
C]D.&5&:_[Q1Yb5A/NVJ>dXEe=ZY[C5g>]V,LN+I[]7FUEF[I=#PKQKd)/9FObM-
<AES2d[K.(EKWT1f?EZIRPW.?TD[X[6,A04PL[&P]YS+ANT_XI<3[WW1A\dK\ZeP
D3>\S1^/HTdKaPDG_0<9>EQ=O;\(Y89IH@JD>J:Z+H:/S^WTJcgK67].72R4Xa)@
<?gLgG9U(WTO7GUK8ZK-RE.f)<Fe^A=9SR-I[#d#KW8GZ^H)8JP)VC:^Q&R0V-D#
<&]\OfY1-DHcb(@UG#>(OK<_.X8Hc86Q(;FC]7UWVa632?_:U;ff7RTB^/W(/JaR
a3E&7#2;fJdRN/W.8fUKeML6]/=0&<Ed2.^_-5Zd=f6fQSZ[@>NM5:&770_ICIZC
>BKLbXL=OZH=R^Og7J#^H?E\J.]&b/DA#C8/>6a]f4,2;If06EJQe\H]5HXD19b7
9WA41W1gOA07eG&^;b:Z#66c-<SVUY1?ace\D9OTMWFY\,LO>+;M:3/a4CL(/Lc9
:I1,RX0JdZb[YHP\4-eUQ4R\L.b@UTKK044SVRK:LS+>,&/LS];5XOcQY27bP&]R
Bf4g(2I3@>(eU,#5CH4(RKK3Wg9VfbFUIA8D4CF2M)-Q.<>Z]c<:O1R0078cE@;V
<+d6212)TJf]2S02&,=N^33c82RPZON=;6A3J1_2^IV?gE][-T61^+QEK8]Tc&aF
,]_fZC?,BAN\PdG3X2NT_W+XW_Md>@:EI/dG)f#LS/bb;[>MVXc,BbIF5LCVg]J>
Z5B1@HG:CG4VZLVf.AKZQM1);^,>9&RVZaX>SWKM<A7G@SD2NFY7)d.dU^;]Lc?4
N_eMed<0@PAUY<UcQ0RMVWDE4V+:TL7SEe.G4,[=@EM_6Xg\S63[RD)2\dIPRdGY
DMLV3<6<dPQ(TQ(fOQR)CO@\-RfIGEPII42?@TcL3D]Jg_@eMTV,F1#g][BT\\K7
I&B^#G0^HS6fK/<^;>&gAL@<]V@.7e.9MM][Y++Ig\Tf:\DC&fS>VY/<O[7XA\^N
Ua1,G17=V:BYHXgGd]J+PU36T[&:NAcOKNI+CYG#]L=>+gPIW-BP)?9M:^fS<(U1
\U)X02-O#0bG.W<0N7L8R5)MV?7+PTDTW/fF&J:7f7dM3?H2O>Bd[_D?Ub,e12FC
,_e\V6a:<Y5)a/^dMeFH)-dZRdY)9(f?_P@Y8Zbb0#2L(4g5cU-#53=,_E[X8+<P
)3YO;VS;=PO9K85.J2+97[)6KH4^Sa/_MZFW5@R+G_@;1-_Ua=Y8WS,2S_XdK_5I
60:W@V\>6I]98(+PfC3bDI(?ZVaUY7AD&3T(IYMZdGQ2EZ;_(6=JN#2&c^7+UT0;
@8T5VP8QBNe7KdG_P>#^0:>K<0_H(H;6D927O+<]g22\56A)A[B2HI;gDf+&TH-F
Z#;b0A=>)J[UDTQEBRa6g&UZ;#6K:0AEN6Xa8CIb4<F@Oe>SE80Q@YNdG.AbPT:B
5.Xg>bgF,0Y_0ZYZ-b+)C1cPV,W_eae/FPCA_KQFM5D&S(^Z:LAUe)0aH7^MHY3<
0gfT=U,V\Ob\,COVJBcS;\P(Jfa#3H-)d.?]V/gHeR]Q=fEA7X:J4,Ld/]CG2S\K
@.S@0ZK:52CLEY]J)f#0)e8-&e?B:QdG^0YM(A8.IaUc[f#<J6KW&7\BN@?Lf;Nc
X)C^)^S/2RR+&;:;\P90bL),[D&0eQHM]aZ@Zd>>bgN,QGC).?0B)BDQ(Ja7.9CI
Z/G2UXL&M;R)a(^gcYaZTbcCV1[(EcW.VAZ+12Gd^F&)[OG?Ve0dEd<9+,6:[P;@
YM9D1P?[P_fZMbJ-e3VbJ+7g2;J6=KM6-b=]BQQ(\XL6UO@gX-OdFNWCA:+\RK-\
f\CPM&g3DD20LYNS5<CKc/E1P)cHZe58DNYYYTM;Z<Ed-T(\bcWEaY+T+O_/UHHK
I:@N.c&0\De).de0DSW[a9Q#71?XOF-g^#b42]6KGWH7]IAC;#Sg/2_bWdLfTDHR
YYe/bI,^[RC.3N/Qd]/YVV:.D,4Fca\0=3=@1@c8DS#N-PAgHJO,W7\N<?.<gI<)
K9SaPQW-9U\_D]QF7eIZ_YDF#c:9fO]2G<XV<KgFTWX8e@:57Uc36U8BZcd1e6JL
8[.f[BM<<>J\b2XX\3<>589S\\/7LEKPY/3=a[g(bY09V1S\KOE0A)_@#&U?^&V4
?U7=-g]?KDV1>Ya2ZK-&O0O@JH<2MJ9(5=ZY?<IVbYFBSD(FC\=<(RBFONG,M_X@
Z]V\_9/7<0.Z^#8Za;.7(^6I+2JF5g=&Y\^Ac0?Uf9bKb[6EAgc0U>(_^R2)W23+
M+^gKP.=VML.Q4?.C<197.N>&H6U5M^X:74=a[IK:FbT35?4bH/b/:Z.D>1N@C)8
/#BFS1\aBL)M=W:BYJQ)a+153/9ZO4:@?NZ<RQ2B#)P&K_;NP19d\0,BO0:@g?eM
QKIV+88Md.:XcCW_.O=&gYHA5=28BRG5#3HI8Ic;-+WMfONc/EDG/U/>@W#6^eA:
HDe.f0TVIOU3da@CEc,Ke]Ua9&g0P.S&;eg&fZBeWOY]aUD@?1P5W&T52[QT^.W.
R0)&+><@C-YI>5fT2=GWILRDRa[\-<I5JC#Y8=/QMdX@LHP.V<@5\LLc(S<7&JD.
2\-PB;.EMOIK@6_[C]=3c:[ZXMM3I6UNW_P\4._-HUB7>Q<B(B2,QWQS<F&aC05:
YfK+?a>:^R3.MgfH/;_gaO?:H[G/=bf#F@75-H)(g1M+,Z/e\Va7(g/&XET3<gGR
EHabWdf-DbC-X,-8fdWJbHLTVFRdBF>fM5N7;@1[EcJCS=.3\.5.[^Q#@=W.fJ7b
C;+SD#c,GVIS&@JCP8=NF^<]<^43=BJPVcYNVFHTCE)0]QV#:(MEU9K]HHGeTGT3
H(.fPa6+BD^79D]62a#@^3L^4OO>\:gZG^I6^JD):V7f7NVD<,#4D5KW64U,(LZ:
;6HX(GXeI;L)6-^NE9KEZ>a_&.0>FFdHHP1#X3ZgMACQNCGFXW?#QPc6;?4;#IQc
ICaOJ7SJ3@E69W[;9,[;8JGEd>bZ4]2&O0&7)GH)NCYBDY/IVQSXJ]Q(8LB9GHDD
W=Q-gQ(&98NIO:J0/\+Z#Zf;7>O+W:N4D__3b0Y4QSIZ=S>TY]bfWV>H6K_)[,Ld
RcBA;9)-WEVU(M;W+RCc6R7IV?17b.g2N^f?@3gcJL@I;2MQ1?J0=c9-(/6DK:@Z
+Z6:4ZL[PP4Zf/P&0Q?GE[+;L6<QR?1[@L11@&,(SLc>a@Ae4.HHCb^EO1>eAF#:
I6&6EY+NaP\2,fVS#G/5L>WXN>6eR,3ZAOEBOM691[BSeTX]7N5<1>MYD</dMG_J
SeA:&7(-KBQAZ7K-Z?SHRF:bV<NE_A-[U4Q\d[5V.9c[J^O-5FO@Mf&1.I(5IJ[P
6c70-Z<5&@?BK/?])M0V3X7H&7C-A9U/f/>6fFV2VA0K)ZXd.,Z2dV.?DP;b3cP6
/5\Z34P-;g0BMW=O-Z^K5B_,)]g?0bW8Kf^+&?5?3/SDWF\]_.3]@aBZC0>VeP/E
T=KC/;DUgD5BC23f&M@W;14Q2^R+=6(Ke[>cXONYEKPJQ-NGRIEH6:\OYK8;dd(4
,Mf\8>a-00N:/,?::bUb]RN/6dHZ8SOHXEDUQ>#,BH:Z#?OG)cK=JF(ZePX:e5cF
;MWfaOB/+Tffb@0T6=UKL9fTR;W=8LA+=?eW#Y:#-E0XZYT;6.0g>0e7+84:6#Te
9e.><Dg+UF88WQ3Q#42A-Sa)H2YJR.6XG;]5H2gR([J#6>Z,Hb4>G)deFI/4LIXQ
UcL_Na#&cFbQ#1/<,3/;/SF)W(7KXY\4A8.KZ2&g;W^NAF^,.O6X-DY-:DF?,-UI
H[gH6AESR@FVf<4+U,3SO,D@9H]=/X7]:,3L608.51A@T(+)fY[Q6V,41db1c(:U
,+N][ZJ,LFT6SVc&M9\?B>>,LXd+bEZCAK)[P55CKFB^#f?_FD)?1bA.2ZX[L<^X
-,+_T9C+JK1)S\I<VMM55,6);Q;FH8JeCNB-[cD3\XbYM-cNfQN_)G_G<=L6)04d
[&.GKQTXG<gZKCbS@HSgETYT7RJDL9c;#LC(C>CgbW@YQJUA^,e,>6I1fBTK0J//
149Q\2EUAXEC=C?C&/RT]YNOc4E-A_88NWHe,;TVUY?8E>.S7&B3X/,BIgfa)8K#
B6d4(NAO#(ZTY:2);5NJ;a4;<&B365eV;MA<0GL+M]eC48HMVU.@gBNFOX7UL,e6
I=fLB3S4g7(Mg::QK?U3[-QM:O7<8Q1e7)D,3LEN7J9Ne6YEYZO-HJZe:[SX4Q7[
_f^N;f7?DS;,?bAGH9VdH9\+U>MF:88Od^FfdJJAK6I4V<):&ZN)]YX8]W,69]=T
D@-e<Ke<cg77&@9[W)7?/ReS0dMZ4.QGX,aS&KJ,ISSD=O2HCWW&MW9bT^5\5N.b
YNcU6ZVA5.1[A>W[eKgEKC#c_\,bA/S&+KZ((f@-JNDaOTV<R)@V__2FIf>]DV.a
WdAX.K>Hac&F75Y^[0YaD\dU?7b+.F+R?ZPNB,7Q(E:CT\YOX):bVg)V&Za5_c^N
5>TcgH3L,D[\QYJc:7Y0-WX5Ua(<]4B:(7,)Jd5T7J5?.<;&A-#8EZ4TW/C8N=3M
B82RG)U=:[U,eNMa:1/:d/\:6Rb,-O)BXVTQPY/PSS1Xd])54-Zc32&S_Be_2aL8
V[W_g^E<4,Y)JP=5LPV2dX:]LTH(_aXJ&_JZ0#/WH08R;AI(OH;3NZH1,Y_)C^DQ
A++K(D2##9E-TFc0gGF\,@F,)K2(N8GM^\JMS8R>-HJ#,V2.^XHZ/C/g+\3U2.C4
6@SMfd^>+8,QK/I7XPPf5]8F5TBBRVB=#CM&UZ1DgW+/(0+gBG[GfX_.36-^\@\2
2C6Zc;Y/[0?3EC7F^ED2AcZ<&(K@d#RUg@(5<7aWW@0>B>TH(-@Z5>D7+O5PC)gf
U0c?R-2ZKD[>_.MNW?/VUEYK[ATM:@:[R/;=TK8#NVAd+RBY8UWB^-DV&UG+.Y/)
8YI>[EN:J.4/TaBRca^]&_/[IRSP:LJ(P5#bC[WM(aePAI#Z8OVb];)BOEZ.&Q(J
[-<;I.<6\[K_E-JY2gA(8gIIg/<57[]<Nd4Mb7;S+:FAAZW?\-A?U9>C?H5f6N(Q
BC3FM7]=PPOIY/G]Rb4(0D(V3Q3TJSYd[QDI9C&(3D\ZJL#.-AZ^fM#77-^D?ZI;
b,+e.LC#RG9B(U2?C_8X5Y\9BQ<(2Q_HQ84#N<?M9,@6WXbFcJEAb.,B62M95[2:
_XI)J<-U&NG,de7ZWMH]eR\F3O4:+RJ41+Y[[de<H5N8)#3P.,\Wb<9()3J;@+T\
(FWU]f(e3TJ8]aZ4dS5OV>XJURS=6fI(/&&=)TJBE;=V-RX>a:&^;(<G67DZ1a>R
212+,[<1eKCQ_T]7\f\)+96\Z5CLK8P=7/SYEV>T9;1EWRLV7Haeg-[gFc@RO30J
H&7dOa&PU][2V[\X&(eBV=N3dJ)Q-:)ZH9(;a<9E]1g4W0Y6+90N#<,)X@&\P4<+
M;WfH58D&fEH>X9+,&L^I3,Q61EN1>BSX\>Xa6ABd6BeV-NF5?S-JLL6g)dd[).3
b.F6[XHZV<FX14c5a15g\O&2+dc0Y,5_U,-H7,fAR-a20f@+Y^93Q6Y7G^W9]6A#
O)W@4W2X,ZHWJ9[-Z.bcCN[;+B;6ZTYFa(LU+d?&dDFa@#c>B]^C5KPX2LVAB090
,PD-[1J90dBI\U5G;DG5F+BLYDHF:cW^\4H9bRMH\L3N0HBPDgD1]<7K:-4b_4:P
YZ(/]MRM5]_B#T_a;I4./9YXCgfeEUBI)E>+\[BX7B)7;B^d/:8(UVPTQCR<V\J5
:S\GA:01X0GKTVN2CZ.\/e89^6>]H4O-/V#ZP6,>=aK8:0JD^d>Z4H.GR]g/+@4_
Df(+NU<cVV33_:VL#WN#KK5UNGNT11UHaOGFXX4f=OB7F>_[eP.cFS=Jc3:DS(g\
ScGd9-#YHF4d5gRC2-1SbSb97D_F\:\TFbY/ff?9bF9KJA4^a,TPB@_D[7ZWG;]2
]\GUZ,c_RX1K5e]&KaAXad8M2;YbB-b?K?dU<Ag7Yc#?H?^>J2@77#g&\MR/?;T=
]Kd92F,L0@.aZ7UN[J:1._9REfWP6C^e#4-gV?RN?\b9=#YL4W#[>JgL=AXDM3K3
3O[cY+4?I?5<VI/NR#\(=.,-[L6cbO^SLXA82>]K/,fI:T3]43dfNK2+(c/=ZWZ+
L>SBY=]D2[LSXN:78YReT-4K,2[W?Mf?RVXE@3BY-L8T]f<XB[7OW&NI;I-.d.0V
J@f-]7W@_)N\UZWJ\NbRTT[8?FWC(/CN:\FB;bMH=CLbKA4&?0R+dg,>N:CAVAL_
_.^]LO)CINXT^\fGGV)<&2Eb-11N]5M)f2_.GIGge7FWC/AY)N.ggSA2P^cTPTB1
LE3?<5SeO3f+)@6#5aQ8L_T+L[M:62^C@WAUE(>ZB-ea\RY_7+ALJSe^M91@e?CB
bZ3d#GPVe^O]EV>(gFM@H[W:QdH5Sb33N4?^96^U?CXP#5?A9QY>O;&GF:WHC:6-
66WWY4C=]BXH9H0&cg3[E+<^\2Z-M>4#>;:N)-W-2E?d]6F>AfCI.2LGNaDCXb@>
75@O]<)FWZ8;VCV,[CF?@\,eU2]06MOTB82,df\.1/Q[8EJO^S]b3V,=?&Ge=Ng\
K3P&NH>\BL\baL?;RdcX;\9VG.gQQf1_6^-#FK01(-YMXC2-UH4[-8X;M,M(e=IR
EC3X3Q_0783M+\gb#7];<.]XAS_S)S?>^TC?MSD4=J+bf:5TeWZG3PLJ\&&fXB8)
.5&[BO9]8fZ=VX\b9dNUZ5S<]TVVAFAZ+ecT)?X.#Q&GbF#)-=RPQG<]f0_<e(b#
9Sf[&Ge?,GB)@_S.#1>g81N1e4&B9HWZ5L<Lf8P=EBE9Q67YB9^dW@G0,d//NF,(
L6T4-1,\.L7P(FB+6c7?O(eNVcNXg_()&c&IOF.QFKY.J0f3KU,ZREbRIgKeNP]_
0c8b#EI#9(fa2Jd8M/1Bc=Gd&41&ZN5MW0Jc)-?)#;&>,5VF9Z#(JUV?NA6:WLES
@6]_7ABQRSPVeU/VQ+PH8e:6PTe.-a_V8N&c_8)L[13<UH>E3c[+UI?UK)1]43)&
.g0VHEND1_H]Z+F4:^SI]L].R&.K92b___G/c.[V36I?dUGeFQ@-K[NG;<C;^BDf
V8Qc+5O]b5L+&ddO-TaZC[\84dY/KWQ\Q#g&4#U85U#Yc]187YB/CRFQC\/BVSLU
eDG,56Vg247-PfaPU2\I/E+=/f7AdZE0N<G35GCS+Z6a3B56.dKNC^LDc]E2?8[J
HCM9X@H4Y3C_WcaSa:6J]NCS]gf01)H5>fPA^F601AF&7f@0Fg=0A=3c>9b5+#f4
E23:+Tf3dDbAJ6eb0Lf&857-=1OTMDC8X2NX@eU)32&O\d@3F9Z(F9QA7QN1-2c@
70S\++>BZL3O^FSd&5<\3XV#_>Qc3gUA9R;.Jf(4&[UKYABKc1,QE1NE@:?-K);8
JZY,DWf9GU(GHW(e?SS502Y[(10K389IBQ^gTAaB_SAZTXdf/Q?VN2<IH:J]UO[O
-D6_0R41<)0MXfBWW8W53G0S]E3^+4V]N&RJZV,#YA]dD73Y/2+Q\(1\T0gVNUFZ
OebG_25@JT5/>#KRGA/S/f-Tbb(9g3]^IV-/QN;YdfJ8-cA71H4W,Q;H)A5@fe])
<T/28.HLGc<)0)/E;]J:I@WW-4Q=PXSH2S)ZH@X?FeGWAJ=B0bV9g33;4NRV(:b^
<@9P7R,IMV<#@2V(-.^_=1J-SDg:-U?Eg0b/E7JZVYY_D,/1-<8d@eLL\e#(UcL>
6&N+]_T[=<bZd;DdP4N8AD6M.-OJQTCJM-Qe&C3_Y9,RL6@XQ6^1FNbS_Ib#]6a1
+IgE;MW6#>/P4>O/5)@B8ecGO#b02M0Af0eWF,6+PR2<eI5ES47Fea(&<T]6?H3S
;;[1+G1D303O/NGKM1d(&-1Z,O96KYD3cA[f6Q3\4K,YVPgSZM;_W-g9O.FNB:=c
.2=P=1EJKdb(&..CN1RU0>+DZ,2;E;DFQ>-CQ)+#7/Lf<QS(cZM_eS9BAC&JZ;VU
P],02fS3_&2O[RL^BD;JZ(NS/Q8D3)7XET4(]d10);1?57aRQ[1RZ0JWQ6Y[afMP
,gQ^PT8?4H0A\QNVFVeS5A7)TGTY9>>+0>cA[P)3cd[6GFfdH9.5X5,.GA4_Df90
&:2,<W]0NV\#4J?3#38YFP)?KPc.+F=YbJ7R^TH5(L#[GI456b-IMd.S<O[+fPYS
g];eQ;eRHdZUab0RC5QW1MSO02J^E(&Kb0YG6:H&&05?B\F-9X[0&&c,&.<X_5^-
3-P+Hc@MN/g)PHK555d?@;)\&OX:[-IFgJcO>e+?c_/Yb[_a#B)_.YHAB2J]XP<D
cGeNc/cC28GK+4-fX+4LMFS6O2BQFR]AC3Y.&N5CNQXgD?/;-I[e>8ER^@Og.&9.
ZYA5KL\]8_I(EZ.T[AbYP\XE>A+::NKV=dC6N#&2\d3?/.d\8LOS1PL^f1ON>5\)
FT^fIL0EI_H3@bXY5G9E@cDH<e\]TG[1?:EDWSD\,N4,?(I1T3fZB>_-AUR>TdHG
[>\e>7(bQN):#17JZA5f#aBRW1da@K/(1cL&EeKGJR22_M#_cUY=,71QeY[0d4F3
_P+-V#UK?HE4L3B-g_?[946_H2Fgd(a2b6f(gL4O(?_13D81SVRRD074B8I<Pf\9
Z18bef=<.KB+aH\SL:&TR+CcUTObH<SJ/YfN3/T&=<29S&85g.bJ<&0TGF\?]<3#
]BTD;W4eBYOH1.3=]CD=a;215HTDHOe1030.DFc4YTI:EFeM/e7I0ALAdUAaf:E1
0CMa-Q>D+(D_MR\6VSeHSRHFTE:fe/NF]JVHD/7]@@\bU-GZ:F?:<+I2c^:QMZ6E
\)ITP&<,8_FF:S\,Pg&ae^X(U\\+=;T=:VM=GWa_WNH;3AN,[YdMH2I:6J=d)QI1
K+X>&eV6BG_Gb9-E\<d<>E7.AKFV;_?):AOX94-QQNA6<((2?N9fW#,:@f8WYD22
1(ES0&Fc9ESMVa];d=1?&U()cPfJYQ_-,b^C^_?VN^eV3g(#[[,T&V=0FH8=L\fO
RPcc,?/dMc;=C[_=24/9:3L3BRT?\Tg7AI=ce9]DMa,?.CE,E6LAMMY?1cAP1FU^
@a;FO;Z6B2,K]Sg4=@Sf[:WB?0GJ6aH(XNCG?O?KU5G^JH7>HL?>N;IGb06BQDFA
NfUVO7f(MV)]@5\P4:_e9&+I00[95<3[IR&@+WN54JI:U,\[gAcRF2.R=52+113+
_c=@910GXeE#6H6g[(X]fKY.I[;LLY.^,OcILLRgL>&.^P,a74K2T#55f)P0+6c9
_4-B0Tfc7RDT]6YPZB7&O>;T:fE>Q#2U6aY9KI4]RNMRCC0:Q@8/GEb(31cF3e.N
V6SF.4PcP/&LR+-VUS,JOY:R1U3AZPZ7)db(^YdN/CMf>EbS9aSO743gNf\BEK/&
G<-)6JSa/;f;feTOO.N2(1I4@<9]Q_1VBVeA(IeFOGgfebY8@NcTa/Z_55fO#SK&
0f<LXP[?=E<d6A#+03W?IYC:R_S?7B>KRP&gH_MMK/bF-M#>e0@+\0YDKM+?Qd_^
YTP:.-a7:f#?+,R8/CP,G]2CK\=H9,J+@WJ]>QRGOe@Sg^QY0K/;fDPB[VgW>PYJ
AY3]9.E?^M9TW(FDS<aHee2Mb/f_OVD4:d2aO[c9KAH>C/K,L-fW26ZA>9>27[:T
E8ca]?K[2K9+S?>]_f_PIAIdJ[d@3XC+29Oa;cMH5A(-S&b7+-Y#PN7:X_)&cdJ<
9f0a^\G(/^b>e(g,6:VJJ@@IJTO,K=TbX\B=+ga/31Y?Z.U:4O3K]88UARG-deE_
c0>D=d>QU4(?edO=ZS)&X2dD#_J12#FNK>J\81VG6W:#Q[5U0M92YS-QMM9ZLa5P
:G#5=d]/K&(.<e-Ib8]7^;+gFbQ\B2b^>T9_=BJGQ_Z8XdZ3G?Pe/;L+JL1M[Cb>
\\GPPJH-#J3:)_T7:LO>g(YX6c92SZ,:NGJF.9QJeKIL,Z?+:I+5fIZD><P_GbZ\
<af/-YYGD_>3beB\=Yf1#2]a#4C-eAYSE8:C:5^6I5J2cE:bZY>7/Zc[Zf4NKO^M
GO,FQ;ZA2Q1-@?OLE8;QNKTaf?P/+bE\N)Q?N@UHX/IT[>_bE=P>U7fIC0K5S;Zd
(W8V.<b23Xc?]/d1@?O6#:2gLP4UVAX]<H0EbcYLCH),?X]JG18>Z7A#>e1#2dA.
5L<SD5Sf9Oe-3<N:@4=OXA-4DX6@V9b34Q&=WgJf?N(8OXe#)VdK9F8EPK05G0W?
A(:-EF^>[IgMO9I26R1:3J[8UYc&XKV=/&E-U/TIMO.UOEKeN@RKF78138\1Uf3O
AKIX>U&#11JIL<Kg47?.HH35X@1U:&;I]B]?H)H,H;+TF-&S^&M(bb\T[=UBZVC[
g\9B/FR3R8-49(7.e^gP.L\?33CeT3S9C0EBKQ-G[O17?C<2:1Ee+N-d;(4TQZ\W
6M8LK&E9#P5LVWLZIX<(c^+F<=3S,]\E98]027#/=_55A>ZV2+b1=UJ\-?G5:Ndb
)I1Ud0J)MMIeNf+<.(.QIA(?C7)&aW&Z.Af8U7Ma/,;W.QJ=&YKQ;KM,_bUbMGe(
0:U4@8d56,=Y.OK3AE^UIIB7_AAQ@W9EX(UYbdH=<@PIG>^6WAN-&\5QJZ_D,]FR
+-Z\ZCK#\7=G3@^X:]J@Q]&/4QXT1=?YC8(BH/f@YMQBY-BZ8N3,9(T=F]0._+^[
:+Y51(Ce>g0A03:T<H_)7]E/HOH-P^LF0d+O&/,.N^0P^RP=2#e-,V51@/g&MFX7
-QBQ_^VEOXU:bIfOCK],L+B\W]F16@I-+#MDBDg.J[3:R0a@/;#cEU3JTf4BLTe>
\,3P]A88G:_-RJAHERBe]HUKOIKX(]XBJP6EQ#_-_[G,NfOUYC>)4aDAE]PU1K-5
2@\#G_-5WE=HQ\K:c.)J/G<G>We=]):QC@BBLPg52-A7C\Wg+EU:==;PC#HU2fOb
&Tfb0V\50Ze<..TJMAM&^)ECLCQL@RE/C@fXY,3KC:,#6@FLa^e=b,aMA.3>8KQ<
XSW/95P,44YEG(V:@Tg,IP4@XeSF?g&S>QKMc_U).H49+Z@6Fg[F?=0]W447P^26
-4>ePd52K0=YF:2bS>>/,K?P<U;&R7aUc\aTCI.>-dPf.I>7b+;A;cC-Qfe:Lb)Q
aEfS_>0QePQ14W_T(8C(6;3EJ16eQSVYR&\^DRIaIM&WD^E1&f]JR5;W6be6fT9a
ID2&]5[6^B@1d\MJ>-4APWC,AOA#K(-O3COL7]NY<5a?1Q0d+CVPdG_Vg70:3LJ.
ZT^]e(</@3cY)#3A]SHGcMb+PMag.S]1EM@dGOaXN__-AYRIS7#5)\.XJ:R0>2=L
)M?fN6>b[d#KR_6W<cHY13+]&_&L=I&gb2LM:eI<Kb-7\R,I;14aL5D1AV.+Q6U#
?3&6N\RNW7R:FEU./T^25L#-BYJ248G;5.f]ZMGQB4Q2R)K&/QZ;N/+<a._f<ZEb
0/3D,OeGf>e]KVJ?8G#;E(aX;b:>\L)=D](TZ8dPH(aHQCR,1[7P6HY<YNaN^&?K
?2K?W<Ic12:SE@U]O+&L99J=+cJLC8].fK9Z1RJEe)Q#9V4J0f0VO\Q&3e<ZL9)L
3@T7S&Fb;gJ9]>C?Z+:\:FJE^EeZ:a_RHSb\RT>E)BFL5U>IJD#.M[JENBUFEd7(
]?..S;O]J30&ZHI)PL?b^&MaFUHB5L(#7,#3BSK>=\8AG\,OJR&04(T]O(R8#Ube
?S&6_&ZJTcUg=RX7]-HL(S&a;<K=3#)Z/P@1Ke8bJX]@U-KX+_J830DOS)\E8_:-
&,(Z/dO\^OOTM<F@FgNc,3=bY(>f-@Y/MH+VSYI)QV^)bS[<AP)2b>c#<J_^a&eb
YSRY+&/^fN9;-)=;IB_LcM5\VR1a[2&?^^TYG&(fD,e@6F+RB[FJg,YGU>[(8HU=
@?,^DU73E3FEHE(G\50b&J_KMg?4D8bX.fK:]FLYf<[cY_fQI@a8UbZaIG@OJI7b
[1KM](VaMZDWYDNCedB;T[R2G\]cY,F:6RQ;g0M,)Z>b+,Vca.WCcb1.@7QT]L:]
05W1K#._7AD4^UD1+3K:VeG;FLW8-ZGK[TNFDg3g3e]HJWgYb?1SXE_\f2>Y_FZ>
0#G1LW,TT5+(eF78ATK&XCYOHF#HadO#),Y]BQe&I,NKQ2[^6[IY5f&:6\P1aGJJ
@\&8d5N6WCe-L[0347LT42/QC^L4X1LFb()bH.(5K-_W@R[aQOWJ1WgL6MH(,Z0C
-O+1LPQ_d]04A_L5eBE8&^4@PGH7-PH-;8Efb>X25,-_JO99>NeZCZTG)8(NcTc^
67:G-^SA)MDR)L_1:R8Z#4&)08FH2a[QG&=ZN#[=IP&461g\EZ(g=R@<A2d#]bf#
(@/fU\cb(b/Q0cS>Ce&K.BaWU-[0U789S\9?73g?b;=LWLFD60:BXC2?S1]L<J&_
ZV23cI^AG1<.3-4/L&9B02[@T@KecCEPb7D^G2_[8N0<QW2[66c3?8gI-C&EMf.,
Y_::#.3+#:<QeQ\\A&)&O,Z3A@^0#2-I:f\AU[W-4CT104[Wa;;2U:IQ1A]R<&\4
(];bQ5e8,dSc4PGe9)E^IZHg&+)@WgD@f81Q,M(:B@AS1MPZU:f-W__R]1dL5@UV
KSegMSF-OI4LHgX_b4O?]6D:F64FLL0KI9.;@6T@7(9U4ZFF8A70-CXDG[_?HWN:
_8ZH(0NA#Uag>U<&[A27)Jd;<[AKV>aVD(WO\CC1S7B(RNUU))d&5-X;d#bA1->b
#^[=S;-LTgV.W4=+F3T2-X(3F4=UI:P=R=\J]S2ETL#@#NG<3UQ,a,CfNUDMO,)/
dPf?6,c[/3OPB85ZTQ?K(9?E5(eQ(]bV7=Q@-?GW9XHLBZ81;]?TK,WY=4(P(c>G
,bL5db0+C;RDCKYLA]I0>CVR1MXA>RU0f6S:9Pa25YKMQLOT.cZTSV#/60f,I:M4
C.N7Cf2c&3^FYXZNV[U@(R0Y(V:GMaHE9EW3\>>&eM+)b1BWX;d::@02gATbbX(8
;RWIPg7A2B]RR.B,VK[(.E?D\9A;MAgb7)V<I29A67P]E_9AUA>-8caU#[N,gWaJ
>G8LYW4ZPC\cP\E\:#7<PL467KP.CVBP&5eX<_3&,ZHDQ,geX1PfR;]65C-5]8:0
T]gX,DUG+3A<^J=^5.;T1Jae:T\XfR5<^^-MbD/^^b0Y@UYZ/6NBEAX7E0;UDc2d
WH_/Ae]4F,P2[)[dg=.@PF7]N5HG2GcY>Xe#\.:D::6W/?/8L4?B4ZREM87I8JW-
^26e3ZfEJ(,<PP1P<:TFcIU2PLR7d&.6cE=BOM+T/7dIM<.3W)+Xcc@OI(gRdK+S
aaL#2P54E6R9H;Z]H:D2aNGV48ec<&FZgHDHAEA@+\NM-<cNW](96DSNVcB;=R1E
@>^B.aZ-<2+?fUCg>&L<6G2b8I/M>>^VEFO0CCaURY]Tc(H0&>)>&M0B/K3^ORgO
8E[Q?FH;T=TP2a]&\;g,6WG#;M^&W3F_e^[XE8;+R?V&QYA/S_F6):I,.d7F@H@N
)HAc3KTKOSN6CAHJ0Cc<VBM)#DEb\(gKKI@f_.b9CcHT7^Q?,8]VS[KOPYG^I/WQ
\I-bDa39:VI;Z]</:G]Ea-[M>@+P\T0T0^KFJIT=F;HZf+ACL&VVW3dYQ,M99Dc@
.CF:7)=COB>@RbQLb=EJJ&0+<,F1W<b,CGb&ET^ZJfc9a]OF?=SH-3D-Ga+2_5(5
RQIORR#XM=-94RA?OV1\,/.fW1c&UB4W<HgXT>E>^@MT,WKDZ^g2CO/D4/]:8<6?
W3DSZ:FXV33=GRV0cQ;>:fgS^^Q-M_UTF4+088FDC;,M#XC7;Of-b>5>H^LX4=]T
_A#DMQBP&LTNCEZF4.A6KJ84c.Q3;S7Y&^+S7WNPgfVFAWaY)\a_LfcB(VeJ4_bJ
EDD6KXX__N::6N;0EAVU;GeW7S(844=YUe:+S(V##<K<Fe@+?O+.Q-8O9]CQX[B.
0DfH>A#A?.a?Ga8U/92=)@W1+/JF6fP/#[Jaa^N>=P)?8=Q1&5L??JY)BX=<LC.3
;-S&Le6cP>RQN?Ea:0UU/IXX-IgC_G^+Og-/Y2W1X;8PD]aMH1?TS4#d9[fLJO3c
5#a;YM..=LO1+7ZFaHB\8Q-d<^g#C3H)8#J5G04+bJ9C)@\.e9<JFI^=E4P5gHIH
)XDE)_6B(;0GLSL[eHY5A+H?FL1U59\b8^\I>Z+F<1XB=P40H77OfPT9H#&XXU;U
G<I1.9)eH/9e]S#Ed.dVG1.U>:b6QMG+CEO5W;]Y7:[G/DOKQd+@)-@Lg[YHT1.e
\TZ-EbO@WEY,M9#Ed\&5=Fbe?8B#VE5#;M2;cW\HfL,7,d#c@UQFDeUK.4/D_]NC
V@c4V[U^_I2H[D.8G;+/37]DKe3S>?Ga\H2gIMTR0CM4bA@_R7<&(U&AGM6[QZSI
UAEf]gE][d1(H(;&5G+AYAJS\M12^[>K-SF4RG<[WJ^JN#[C&Rb9NWB+ZM;5.T1<
7K_.B\ddU04c2dD5L=VFRddD0aD>;O#4/6SG0+4_NCM^?J9Gc/7D)H>^N0V:Gdg\
YA1Sa0bD?W3VB;.499B:Od;6+I=.gQ=gAU0IT+LKg+V3I<6):(A17+FV5T(Z(Q6I
#00.[9RTXY)J4K&eF)&46F;7F/=_K[?8V[0,#9ZNOJC;<HK=90\OMJId(_R<\XPA
QVE\UT+@4FCE.Oc^1M&OLd-@SfT[9OSVQ6aC_N]QH-eZSHGgF^^8J5T1?SL;c^Bf
)FH5A@8-Tb_H&@GcCXaD3O#Y@,F-2/P66.7XV[7MGc>B]+N.8JF7Z0Re&<11WfD7
Q&/M#VI+b^9bKcW[<T#C228(UI@FP9:1cGU9H?AA54Cd5((gKdQZ>d3=c28f.PT9
746G4&CV(+<2BfLR+(J:UE[\D_S_I_6BIX-A\]Eg9[/+:1Q<TcAaPcDbGe<HPFF4
1MGM<Y]E<\XM>1]Q/Ye;fZZ69QUW\gKZU._P8c?(;(?Kad=YPGDG/(A<J6/.JKJS
KS=:I=?=8YQ8Q4QIS?]?&QNS8_760J[Eb53PJ^P2KK@15Z8PL023:T[Ua,;^>JE,
d4X(>H(7UH7RW9:Q=10.Q&#W/VW5+WKS-2V8L8FAD6H6E0RH6JT[#A1\+TBbGJDC
]K<L\(aMBaI[(>XYDI;_:N)_55ga=,;(Nbb(;=D#-@6XgE>W^6JQJ@^YWU@d>@/)
Kc>C:g?ZI8bdBDX\_U4=P3Z3Y@^M&0?2+MggW_H7]>N48@M,aJf&_D530-GaIa7:
c/</\3R_Vg2_/8-Z.E<PcL#dcC-AGTFBR_\)ECV[36bB<NcLa@;Ec3b/YZG]KPKS
A7]TgIfMZ2_.63J>L<67?cY4#<N2@XL=1YD1F>H<K:,,0NYZ8Fg-J(I8A:HVTOY2
=ef._E5ONAQO(9POg:73XHQeX>e=g&GJ&SM;G0C+IF&a0DW^&F)QZJF-VdaP_>4,
HP^)V2dP=R2V;c)_JB[CPYQ@XaA_VUc\cP;\f[c;.:3,2fSc.XY_GDZCfVJ98fP7
:UZ11#70TCNPM]Q=MCe7[V)/4<e\RDDL.TA8QNPYgHC>TW[;2c[OADQ#6,@>-LVY
.>^&2DW:V.7P42Pb^&KDCO1W\-d\SN5e5@9NI?(e06=]?)DH]-Se.TV6.>cXA/\0
OaWA-<V=S\XB4P35REW.T_DNC^5Wc)?fF(g#KSdUJ[_DSY,L#(L)VH0(g[/E)3E&
3;WXMR?LT0fZE3E&[c8ZQBfI)<X/4b]/79>(S/?6GV3\1cYDfF2KX+C19GVBAZQ)
X5..:ZQb7L1Ac#FY(76@BE>#]W)T\-gZ>J,1LcY;5fb7Pd[2c1G,GVHOHg^&f)1Y
;4TE84-._50=Db_)@ZC]42KC<JZ&WTTBa5fF^;CaADQ6;/>gX+&0=E-KFM=OLUE2
HMKaIF-?D)/?C;HZ,H<0a:;aDIg_B&HCaIg-MF(WJ3FF26G)d(DZZ&@_f#3.D2OP
[BL(X6.e(XC5>:0QQXa@MVD.751P,7fG31#DH.1\VM+2TJI;EIG>+:X[dUK8&5O-
?F?Zbc9[&S.Z7cJg9a#(3E-a9+HH^3_,0RQ_0T>N.gebZTL1W#Ae^_)72RbcYAU[
\:Z;\KR0;^d#1OJ?-d#U<K&>++OT7Z83R5AN(GJ5e]SWe(1,45Qf0ZAX>>bHX]1I
P.1AI>[-5P)I1be99cN;F#MK9Og:32/]?gE5[EI4-UL8@=K<Webb#F5>)+SWBGS#
X+C1T&/XA^dQdX&gI2g5>SK\M#Gc&U&,((7&Ve?4#Zg<3T3-+DXBVY8e?3[+6WGK
H<d]+KQcL/V@6TcXL)KD\4)HRFBT,V[V>WDD#?4V\.-HGHUE>X34DC(KOLAU^GNA
c#KK68H>7]&:)/QQ\2S1fgfgAY-AM3]6)>^W?BS0-HG?&Re2cZGL<d8NO<QG@/-.
9D_D/Qa:]/Y/U=cK#3P7HB&R^>-Z#dKZ0)7Mgg1C1dV9^f)G8W#4)LF50ef1DJ9f
]D\U43^J;=+Z[4=Wee\50d3SL.GBbVe.LQ[WX8T@V7/A1&#:^Z]Z(CSeW[:VGNc(
EEZ7B(MKR4;C]/89dS#gJ--2U^^eEQSfVZDQ&,P=]MYT>BR(M:K\)6RATcDX_>>:
\MY&(+Y(/Y)C5VI?N;SK55KMdN-4,PO-?:#)ReTWHAU@PUC8P-FHfMT)\FQ)Jf<P
5.3DFM)cV9KIR7<(S1V[Q&8(Y4SD;EcOT+T=&(?\RTG@5_R->5@9a-T(-?6KKRdL
55cA,XD6\VeMPI1cZBY#VS]b(C6E3IRO[Q^#&+WU)[<BX0KDJS_7&6Aaf+A.+H[/
CJJM,O\@7196B[PT5;DF#YZ--OMN_G]e-(^G6^\O@Ca.6[KfWB:M4_RB4Bg?5OW+
/OaQ,;5RRV<e5-ONR2\;La[YAO]HYY9HPBd0571Q6Tg]#[PWd5B&79F/UO[Z@V,Q
_\1Q0V#eG4@&OG&;W0:=V4eg7W9YINaF.ee[B@P98/[:@TP6ZP<V1Jcf-9Z.Q:Z<
;4]&f#S;(#L.2GG_YP@VD,<MM&-B8\+SccFRUUe)P\,Dg6U--QXN7c8.P-aAWL#E
^FOgHM8-\=Y9]NF9d2+1:O6\a,CH=XZ&BTdfDUJ-26g6K=eAe_Z+=].95g-0(PYK
;,<B.U7KTe<A4EF67&;C7d+Jf-APe#6cEMXGXAf\bOafSYP@f#RLK8LZ16KKBQ=a
K#,=XN,WX#d_Y9gNGXfU_:@1HOfa>BO@7f@W^O(c:PLQ-&2B[A1)KT[XdKYWD9MZ
WRK7E&e,-S8]>^O&.220G)6,8HNWHF,;g^3VG=9UV?E[=OUf@e=YFHab;c6]]]IT
cXB-IVDEWJNVePCc@=/e7X&LSVSL3O&dNUF2]0Y:&FJ04C(3#D:fC]gR50BHe3KH
ZF960c.GU/CbC;^c5+RI4P?ecaZe8WOH/_>a?TF(9a<RS)-&<GN3)7?](E&U/&_;
5+g2&/FK044d1fR.8HC:g(02/GCH50AC5BU&T7Ja_):Q__gQ/U:]MYZ#&4.O<6P_
:<WN.:?=:4LUbagc9a0Q#N\06)UE@89aFYU&e/5:A]\]EFMb==RQ5ddP/X>6E:8A
IVd107/[UTH71MC&0]U\_aJU:VLH#,Ua892Z:C2T=&g=_KDcd0,KfXZ=KNE:E2N^
HL.S8Rc&QDGA)43?LR4.SaX\^APDW=I]<TF&4fdaf;@fAPR<X6F=aeLSTQ7^3S0_
F;@H7cVTa(7V=B?[/cKF))U0Y;-.N4Y>c;T744LCK-8\6VC]b.M3>4MPY^#-[Q:3
aGbNA8TSA7OJ3TNRK#+UL\_<396+B5:L5E;WE4HUGV6N5>?(7>d&MMZ2&7;=#O)X
g6Y@dJ.XECF0=Nb>T.0,;\>\E+9@/P=TR,,CDR+W.WJ#:MTCY:2KY^/41QSLIdYJ
\N3J+\K2LLJ/S9KE<_(4eC2+[?VdHd]]>b,:E)Mb7=,K_\W@A;LM0+WBUQ/7g1#+
.WMbWeC-aJ_?@I_8C;M0HKVa\bD]FeY<cO<<&SaXI/8aH&X;b^D^K0AFSfa#6\F1
IN(1dQ7/_a]);J7WJ^ZU7&Z[#0e^>da<:C<ZS-()RQGG6XZKS)_U\F^)^\T-,P<#
?KU=:Oc_eP[=/RH8-_]aO1f<DR6Y3)HQ(#MY,aQ]bg+I:RY6&KYSD^-agJH_PI,<
47F(:-X:Cb49AZLQ^F]1c9S-Q)VUDd8d=^E<e^I6=B#&7Q4JJML^W?+TP+=<F/=5
aFM3894b_7@-(,-T4Ke>b+>=EXK7N)HBA3\7<?@,e6FcKdY.E=(YK=NLV2HdD32d
\4YK\9g3\.F+_C;>0aJe:E=\J?A8ZR6DTIVZX>X\]8gaW;Y[gS_5QLSCQd&e8gU\
T\&86IQ#L;FPCe:1L=8Z2^H]SHPJHaE6e3\(S9-GXb.Z-T5Ega:@\7a?V[<Rg1g8
945eDC):ZOX\>/^D8@H>&ECRGL,LbT?2T_5/CD\g:O0.(R,93X:CB.f>^NHGTa4J
WT,d/:FAcJ3Zf-CI];2>\,EGFX\Q06d1H<]_JBHUBJE;X7<2<KQV6ZD+)4ACN/]F
e\\^L0D7]gE)9J0]+)#84(]G4:;8I=I@WM3T#OTe6ac5.15;;68)P=@ZRV=[+@]L
c&MW2O52EUFWMCS<T<@GQ<fLSN6H?&f@]ZD?OGe)8BL><]a76W(ITbDF;-?&F?\Q
N6c\1?Xe\EL[1\J\f.[c[22S1]:X5e1c@XJg2_fZ/-0bJT4dH6U>#Q80&aH+2@)R
@.CC]B>-W52<6_/X_B>\UXHRW:I)Q=^,#EL_bVb^NS3DX&_MM2?bNMbJF:7G<Z;2
=+]Ig=J[gaEDK/.)>&9&9A[X5M)g^=H_B=7DFMFb>@Q@M/fd@0M00@J\F?Yd.0#e
^0)Lb\K1S+#&CQ0<W#VJbROVLRF.V_(:M,F\9_G8D-(cELSAW@8=NC8O_A(PZe>5
BOQ,6W+Zd>;PA2OC?5R[(H7N0E)<9A=COR736/]2VaJ&I+?;@/\+4SB/3NZG@+Wc
&MRSK0\9T8c.M[AXL-X@58bCg,8]^0:_8VdIC@a_EFXD>+B(/W>8Q:RW_8@(>4O9
O=_1=gQ5.gBS_1ZFW[3Feb@6S8O8e>M\>EMY\Y;(EMJ/_VKIFcB=BRb;H8JSZ<;-
;K-UOIP(OBXbfS(<2:X^\=8K;&4,1SYD=OBfT9eRSDMeZ=V[gVAaVLUS=GX#1(I5
gBFC[1=L\2JR<CIP2cL>H>\YNNEVXVHUI[&THR,e.72#&O>HgHT(:ZdI;dUM2=H<
XVHPK-^MJ(=.>OTR0EQ_>OU:D7:Naf/\Seg7VT5[.^f[05\WOO4H+@b1GdRdg(bV
J>9\034OM<d.+-,e5R#dbf2Z>2O#FT[@UV^X@9fTc=b01_QZ8QENCSX=3)W>7;7Y
O)aZ&YL:fgI6.C4f4W/YGU2(d:aIY5#+9b06H9Wg3,1D1\(4KX0dFP>:RB_5Lcb1
Z6KTJZd/WZIL,M1/TeILK(>gADH<CA[ccaYD>E+bMW4+RVLe7+&6b-(P2G&XJAV_
,NLVJE1_2JY_=<cZe;ZcAg71F5^K578aCP1,?;HQAaE(SD:PeI=GPBW:O2E:H@1E
K@6D<+YV^<Q]R9>eBWOR(S>M<JXPNG).0EEQV2;,:<E2Og0(Y@5UTT.;K\USCTa(
>I\OSCU^Fg-G]K[b.D&e\@X[8JV5D-IA.ZH6f6TZ3=TMW4C0UHMO8Fe?@#6;080d
HO>8YXMg;J_^)c41#.V(2E+V[JE4=/<H3#?1X;6Q/D.P:EH@G>5#f\SV<VIECe+&
[#(f:IDdU4eW.2@76KLFV01L#83QNR6,ISMC#a17aYWgK,,=31PU9V+1((bF@S>P
b>W9;52WEQ=W#@72LJ\K5XN)MI-ZS9ZFY<gW-)+f[M(AB^4EPf1MI76D;;.](->M
K;DOV_&_>>P.gX@I3FL^9OZ^V1PG^4CZ:&BLa:NVO#Qbe2KJUW.Uc_EY>]4Z.9=2
V3&ZXZ]O[#D<e_-g+#Keg84_Jg28X&&-H97UUAO#-f=H@(9X\c2V>)@-a.TL-F9;
5[Re:8]9PAE-F>^DS)N?07]Vb>L\]ZGR76;CYTc1L5b2;g/Z57YM77Wd;ZLM.?K-
9X]UBJ8KE0OA,P:1AV9;H_CR,6<AE&R5+L?C\+;\S]2(-4HY;N+b\97(?f[SScOY
HCF_[@I5BcWXNKO7QPXLH,_:J-HNS^beBP&^OQ\XB3(;2HASYXHLR.(eE/\8f_M4
BRVR7Ka6;fbQZW0<51O13[ACB/FZg<_POMI(Q2(02:^&;^ObRX_-FAd<<O[MVZP@
C>AfH<+G]36,V8GQ4HZ1EF?7VSWW7O887K::?;/g]CQ8Hc7E=DOcMdMafZ,XQN\9
bD)8.2SO&;#&aCXUc67f86TMB3>.dNJcfY[/.e#=dd>^E/cQ@-8Q3@-cIV>XL>):
#(3X]Lg8\0b^AC7P<P]ST>105Q@5O^Q^<0Z]3e/9R,/aKdBI_S3089Q(_=4=d9AK
D=3D[9[M,^J#9&c6\M;.e[KDbPc5IS@WFB_4?#DRN\&d(8MO&CLc+&AY1+=c0?64
(c2)PH+AcIAK#,1YIW&>8(dK.W,I3X,P-W-;(A,J>=@d^ZT],#A;T(_(<.8EZFH8
0G7IG><2&dU^K7)NRf,BC-Q0Z:<WO)E?)TEdH<;OdQ8D4NIA9fJ?dCaPV.9?+EG>
\/DVG:d[H1[HA,#:gEK[PR1=10D;<<a5J>I?WLL_-Y]e7[78..B-&)U&9MJINMP#
D4H5e,DP2IG7F01)4/Z/A^I-@Kbe,_5O&8UW96A&FW6e<eC\U>28f@<<Z5H5cce>
Ccc4]Y&XGT[S.=LV#d=3W6P5O.7RS[Q:[&f@VNSZL5>S/:-:6RbXRa+E1_3.)>2Q
K[(:\@-.aZI8)\(T_2-3aOW,:WG99aKUc3HbW1W2-R<N;V4Q?.C^)R?c1XPP(AG:
.-DZ?,:HI?\[<>ID/,J&6L).+;+4]9=R0F__JVMDO7ba8Jc_PW7@@5^Yc#_LfQVX
HN_;ed4GJc(<aC&cfIf<&e/_Wa8[Y696ZVO?9+#c7OR,E8d9;UCR/[Y&TW-C;]:]
&aUO<d0AGG@b+XGc=X3G38N.PC8H:S[_,OK#OA).JR3UK9a?0W?dKX,W5^(7VAFK
0,&E[78aD;a[GDK>QATRa@Q=J;T+E5)>B+<TJ+&>FNfCP)GJ0V>E]U+gAE-NeR#?
W+DL^IP+eK-CY8PAR>)N(RQ2:.)X_MTKYc<D5979GHL<(eZ@3=#SO3CbeeaSN2aP
cFE6d/2AB<JNVKcGgIb/f_U@.b^(59^W<@PME.N^U0f[@Z\7T8]SXZ4B4(B3e?[?
bG#74OD;b@TV.F0PbfWIYI(/P&dS^TQY9;TPQ99JWK>eNRZGQdSX<(>;NYV3+gIg
N+(KK6SWWd]V2#H_QX\TJCf;V^Qd;,M.2L-^>LK5?)@J3Z#9:?V4Kf5/0bI]e76L
NYFGe0Y3gML\FD?F:0fc3:?@NY,V..e?_BRW.GXWY.DHB#V0]7gL>#/KOFaEJH0f
Q-JacQV,V]G/F-eF.FN5XYaS<^8SP#fX)YL8NLEGc>F3W(V?N;?A;9d;9Z^6J.^c
KL#P][IFUEZG_5?13&BRG1S4GcCL8YTEBa5G+J+;?K.EUICKZ?BLC=_N9OE5a&#\
-N^#IQE<gVB<cI;-G3fN/.TSJWK2(ALJb;+fdT81+?KXgTA>&ga?Laa]0S<L:XNI
_?f)DLcQZ4eccU3VSU\KL/[,5W5GUMO+,CT.-DKD+aB\<M7]Y^8(-H9>RK&_.)RD
N9:I]LW8TfMFWMMd[cC^4B;5]S#4.MAW\/RW-C6UW6GDSCNaQ\>C>\9fIKY9YEa-
\\(cEDP+QHJ(XK-Ua_,6;MDMb:5&4U_+ZCgc>I)fS6+AUcCGNe2MP6IfG67RB7N6
O@[>5,/B./W)3KbZ6]I3L<E61+CQ-:eeP.@\;F2KY]OUgH8aMFCg;.&#aV+ebF+J
()U/WdAe,4H(N/]U?)[,G)gCJe+RI.^(fE1KYL2e9S1Rg<_BOXXgeF^^RaG7476A
fb1\3-2gFIAMfAa-YLbaJ]SA6ZSfaVHb?RB#;36PM<b^VO?.aFW1I36CB-+^5;18
\CE+M+^2-C5FUA1X5^WS+fF(ZfWIJA)/Q<2GO((.fZUK#N@UK[92IeSc82]@_]?<
X7\;@].aF3T^gPJWCA1e2RZS/YKY_XY8SaU7>1O.@C=febV0^335=LcADU:&f]F\
2TEDNN3f.bdYFOd=7Mg1VFXUVb).g4BeLWLVDE#-Re\O&Z0&D@47fL;I-1TE=;+)
4c0H;:L]\A\M,06BEE@H511(PNP3PIb<9+L22,3/-7R5Z[<[Pg:/U(^^aO<C?3bd
[33\e7YN[FN8c7eMKO?+Wf_?[RK9eDcIg?bY9UF@f9Z_]c-/6Q/Da\<3T/Q[ZRRE
,@6[6:e2ScG@J/FaP]?_[>+6.5^4)=?FGB[dM6<\5>#_W1&97_KK)>/Ue+U8.-RR
=TfPKfPe(ISY^J;P-T,/T@+161W^N?a3;J_C#_8dIVAO3^7e(]eJV]>0U67.5&aP
A^4?KP50B0P8=XU\-Z@8e8a.]W@.LFL6,76,M9(FcZT+F[=F#:&LQ.[&1R#9aBHd
b.GUDBZ:)KR)RT1.IC<;<LXYO=5OFd<JGK_6PWL:I01BP1G:@E[DRU]4bVH;MLgQ
gB2&?+/U?d;):A[TAd4PG&>=f.^F.ABLCD^;0J6M+;JKQ]H87@--b4d[2-=9ad]:
.MP#<(+:gT0;EE\>39_,2N/Oa#^7I4O-fbQ,g7)LWa=.0=R.5aO#]U/M>E5QUb#<
Uc:;OQb?3Q37+GSSVec__#]C#TE;ZP/aA4#@W;ZEEL1V)HM[HQ,<YZfGM7Q:59D>
\A(BfJ+0DOdPVHPDdJ+a#?(.Q,<1efLLdB8K]7_QIZC;g\gLN#+ae7@QCU0_LLK=
U#)19FS8^XL1IG)IOK7<cPH?2Ld(/8+c@SW>J02IF=98a6&((:I6^^,LfA((2][R
3U2?P^<XZ5TDGLMC;e8b=d2<Q^Jb:A6DU5@9;&^ZcgY?VDCAO6U-N?X)70f>P/(Q
0=-]@2:?G/[TI7/FI2P?K3UH@?5\WUB)^8WGFG31&#>9g-#8>PB]6<CHN3K3VQEC
@\;[P3CBPB5U>UN,[VO+aC.R<6>CcD&d+T+U/O5gN:=^<H_XPOY^c>>T5c[&L?da
0d5NdHN=OE4If9c1(Y4I87[[N9_L[OU-aN=T-K4(U.fJ7_cfE1/85D#_XG](d4?.
3D41K(;T@BX+BWN5Ug1Q>1A>??cVVLS[EZ^e4Q7>@BGAS-39+a)I;NB@-cPJcFS=
GB1K\7gbA44aUTD;I<71D]cTe)eUT8K+)A=RM7L40Mb28G2.;Q>-N29#R=A>V5^S
3aZUE^&W&9g#AQWJP^aRS)[CgA2_H5f,g:,>\A4XDV]1Q\c42@M2U#/@c2<>(fZQ
b>-E9g/HF^F3LWb?QcC)MF_e7:XcAK-SQH<42aY?dD[d+MH^J>1O1]LNd.Z9B3fb
D;gFd^Q)+c;U/B0W4<S-7HZ(T;cRdcZ02I(dER^EF[fULT.<_H-F\ZKWbWM/5?/J
>L,PBK.dHV<O)>d/SEL@-(KG:>dHLA&QWbUOIZfgI7-;bO8#0/K@.;U5IVSd1KKc
.H<YDH2d&73GI^_]/>/D\UKY89J8ZZ#\4@]YW\33MWJWEY(Q-D1Q9Uf[SL;OO(W#
-Db^WISMZ0^.._+JPg+)893SRLcG_WdFS?SJ#bdC7(/P/LM?>c3K6=7aa+=J^GW>
eJe[W1=HHA(FAAKK=a44[:PP1d?-L3-3&PgM,>L4/)0Z0M;/:MLDTVPITZ4)Q^(X
\O)Cc+N3PU9T;670<W;(C95/Ge:^c<@&dK&=0F[FTdAKYAdVX,R8&[C8XbcS)M<c
:@(2=A5^a8<=9/(FKE8ZGXIC\5K)1VK[W-LaBU>=38-a0b58NL17Z-b9FSB7FdWf
/JKXJc,[7HEWQ/#-]B.2.ZPHY7<Ue<<=7Q-S3Ag>bN9QDNS0T\fX?8<W)_\XYQC#
(daVe9VN#,KUB_R(AS5.R5B7d>[K-.KGJVVK4IE.XT^:@:9,D(TXR]HSN82Yg.PD
9[.AO<Ob/UA?VV4A?:[+8N#M^cD8S/gX1HDe0aGK)?B0[9?A25_7<7MJF;/<#-MW
d7[2R#<S=Df4YG]8G3?QQZH:d)?1J&[K]bIf]W6g42QS7NRNgNLb^0]W1]I08=63
^A\C04CSR67>9>ISGOfL=8B),Q.FBfB;-9G?+:#2\.O6K^XIG#X1X5.7_S>>Y-aM
#K(=+/fZD+?F(L_0?EVRe&2;PJLE/7)#Q>-W-g?,P)d;KWPUJXV^8&8SggaKBN,:
9^80;/RE-<GASE[>;L-N/U>2Q5LXVUX(&OZUU@VAPbab[Q=dRNeWcAUF>05[YQ6\
\ZZ(=E,5W2Zb>^YO_75263PIF,e/.]:M/<RKfL]R_HObYBGI)UWILR77V,+98IUf
PEd>0S=64P(<+2[E\2c3ZOBZ:F,USB:RZeR-X<&7EW#9fQcWb2&Sa&\5;aMg:Y-S
@76#-/GBI:CAaC9>gH<O5EX9E3cZ0_E-?4O5BPUFM5M+MY-3A#gB\A;@ed.3[A,@
U1E@6/UBP-ffgaDV.@HHJF8=/Vag7WJU92^Y8N94cE3MOV@OL@ga^&APOag8,-02
Jd^?[_^-B5]JKYg(UJI])>)<&d5Vd22e--(JI8/Ud0LZH]cb-ZM)G;S_X[=7TW;e
fI,7D-a@+4&9L8)8)HW25L@[(W4&NHcA;5[#0C5@3T(8CCY,Y&#AeIe5cY.W[9PM
KQK,UDcF;^3P6-2K/=<a>fX^e#,8/CebCb)JceOd9B9,JG#B9A)A(=>(-YYg&VO&
KXBF8MW;..Sg\(:Q4EW89)fTTfW&O6dBT3@AD](2ZLOGdgRK,2dYBM::ZaMK-9RC
4XV.NDbg;a)VAOfO(f^IIB#HW,;+R)cL)NgGI]J84-Gb<gALKM?Q-@_05K,g(fH&
WQg@8LT=[C,bg<G.<dK1-9F@ZXS7V#B4V9\O4,3D60[KWR85+f+K66PX&bQVFgKA
XOMN5V1O6=_C4>3T=\;,B(d?T,=92eJFHf\HN)6ERa)7I^=^FPO?I2)A:6HX7NLc
+A=DL#99SP_<7/[a+C;CF9X_PHaN]N_24T\)NQ6:HRP_78[;DbD.#4J>N4Q,,A2=
>c1QfbW((,ZGVSaG>:^R>)W)Q9#Ic8QK2P\CFG8FJI@0V<S\<AUgeGP5^^.?5O^V
g>.^C2I^O>,.Z[W^W<DH2[#T]9<A58;T86C3E(\),VM+U0W_P:H9RXAU<E4J=F=\
@&(efV7Y_.DcM/)--aG(IP1Aa<:;AOS:)D,Q+S<OU@KL.(3B=IZ<2DR22B=8I?],
)^beF_Y7PX:U\?f<W4Vc2&8W62e-DXZ#4HNdFZCPCgW3f2MCCV1VcW>SW0SL[3Id
AH<M68S3R(.SNFB.+DN2DW4e/>fC.]ga177/-If4(2RWD5@b(>NMX]04<C5Acf+6
@2F5A2gN4RK71O-&1YLT.#R:8-cgWdWV;^V;)9:3KLR^74U(b\?c>)d6PMH3KUKB
M]HAX7I.21GR.2cSf0I?_1LLNdD[J_@=,9?fQ5A?ZF1YJY658L/aK\QLHMf<.U^E
O9@&BPeJf4c^>f2JC7K,JKJ236gU-e88DKZab6:/G[-IbJ48]WLG8(38b#W2#N)E
(K>N7F28H7c=Q>4^SDE0FFeF7]ZX6:=8M>81[TPU;a&/SI#0R:W#T5-I2?WC.)..
8^__&(^bJ)MKRTQAV;T6>^<M@RfYM<FTM59X#L[HJ3)D)9I9JdMGKSOA]U/TGE?^
--2HgG43QA:dbKf+0\WXHZPVB6DK20aKNgDVVFXA8U_M-+;U4F3\g0MHD)@<dfeE
K_8cD?RR25(F-N-((XLGUJ9P,G)DWNcD443L0AD]8VLLS7>V>NY?3DF1G<4[E&V:
O:;QSR+b8B[HC2]&1,N0CGb\#DAOC++TFWL-SI[\e6#^a_NLUBC.:3L0.DEU.F\+
3]C=b--YfPEM9Df)^FHGT3)eS8@LPg/#Q(MJOc:=(X_+/D@]cMa/S2BA&/b0eJC-
;ON@FIOSfeE#QC.^F2[.c-WBECaQ?(3a?cMJW.Y:QEK,A6gS4+YIA&6MHOEea-&#
RRW_ZZ8CBGIEB<[JP&aA&L(]UY<-]GHT&cR]TI4[F[KUF-PIWR\d0(-eJMM=dIL+
TI7:BLPd#K>gS,(]Q7Q+YT7a9,/I-#<L&C[8fa+<@eR+GOR83Y)XGS06#KH,L/G1
/2>4JHa@@J(C?14DMdXNHaB..Qf2cJ]B6J.T\F=BW[[e+dEID7\cET)ZOXI?P4cH
6.g+F.QJf;.bB1XH,IHIIEVS3KGQO;f3V\VQ;P3CX<9,&&?+Yc6Re&.12[@_;3WQ
_1)^#(94=:I,&5253OH^cRT@ZV<13JN+FJc)SSZ:S4;1MYQ[]+1#I#)/SR-S#]SR
R;AS&^+]YL(TUV+<YFP+aJSZWU;.W,dB=5]DU&d-HJ-[//5<+aHM]_4K:3a0STS#
bM1adJL\cfW.-Z=7g,g]CE=P->28SZJ\8g#4V:;386:ES,Y2He+6cdR/6eSF>6Af
2Ve0aPbF&G]E#f^/O.BE,W3\P2a^fM/^QQ^a=4-d)4##VJ7=.EFRbN_P;@R7:eM_
55+V-GCO<Y3&[UE>]I<U7^:AZB4_SNX7EU[XDJ5V9+92e3T:,RFS7XfZ^1=8MT7A
bV]a3I8ab@\;/IE,V;7]]8=_D5O9=DQc?YNY0SbUb>^Z7,EU8#/#a8TG:HcLE-5N
,g;a4C;4+9:0?L;^W?\DH,EIcHdcS\ZY8^OUO3b1QF8[X3PeH;W2d5K1M4\?+8PG
B=g79X#1J\(PQ)eQ?1Ng]>d_/S2.<F_9I0_>AIW[KDQ&71=FHTI^_I5;O.a>/B_-
)]DV#C5G<a5UHX/Y>TGJM:YTd<@BaIN;]&+P.fK4^MeV<62\W.>fb7?f#H=,cDJJ
BGN_IB(R;\&eBe=O32-F_Xf)6Ha&YIf.FaJfaYMIT=.@Y@@d(P7E9U7b.\dU;[P#
>,FX+2&B3f/KKU:H=bP:9:[M,)M7[L318,a&MNU[CP/a0B=Ya\@Y0P[D:H<N+/;I
=#V.g4)OeQ)RV1YK[K0>0[XD[I&SP6J(d7/NG>JH(JbdTM[Q1V-cJ3E/aVLWAcVC
;FNY-WZL>3LRHgPc25RD?>JP.DBc<HB;UC?/G5P5.FQ)XYV:SX9GHJY/:#(2f(/b
\@H:_M7(ESS4(D3,JR7U4>FQ9W#6D?d@:VYTANS])DbF[bQU:>910TO[NC)C0I6:
+#/208gG+CX8cSb8KBL<.\BJ+Q_]+12#egPAa37J,ddQGMT>MWF,g,>aMTRfgT6<
gJ(M/&C^-[<fW_>21]D7GZ[2VKTJ_-A9Qd_I?MC[>C+)5@XN2ac\#G&?(OS1UK?L
S<-\VL/E@8K6^O7W(?R_/+0\d=6UKg,cLLXe(B9BA=6_IQC_24\\G^>8fdQG7RF,
8);==^]MF:8)Dg;.31_HTc^9cdTF[JI.3-8cbC@W-:C(E++HA>\H8a((daNB)(,K
:<#MSYE:T:1\MTU/b]H/W<f^JZF16)YHXaAga]RGP.c.M:&-+U.<M)#P[+T3(g4#
YaNZ@9#-4We<;/,\IP>bG6]<5L\NHD@F9abWc0[ORU9&QC8T<1XHJ0AEWbQeB=(f
aKRMB6P5[W8-GdBH8LbF&17O&-JB;0)W>6(<AO>fBX/Id\KaR0gR2+=P^ZJ_(Z9E
FSVdBHdO=<eV.[fS3;8,HB3b:9XJ:^UEf6IZ:<.:A_TIT8gFX)[bRWB:HR6A4F@Q
PQ()#MJb^AO4-8CbMC+],4M5Q+bF]6UM&b6G#7=YbRTcK_:)V&3F_2fTU4Qg)AW;
G9e6a\a-MX_P[P-UAH:VX?-&YU/Ug2gR8_+A=ANUMN^C+bLS7eZ6+_a(Lc_=,\G1
@Efb:9BLFTM31CRCe76:[#A3#Ye6Q3eW4:(O-?DP;=^D,De5&<>1K#6?T7ILRgKP
@?\,(ES)VHKeA<?H<f0(&ARR)NB2d[=9)Y5&<+^ba/1GMBcZX?6Mb@O8aaJ4Q5H:
a-.NT/#DIb]2aC^e\;Cb(:W_K4+6,WbKgVZIE:^c4I]ZN=#&^07QO,B@VVX.T,5?
1>KLbAagX@\G@LYD\ccLD&FB4285U4&eCD1f+G^VdI1)[:#F.7]A?0gH_I)e#F1_
A15]8_N.\V\OI70MM03TL_]:Pg]QD8;WHbH<8:e+1f(.gKDVd4+b30[1Q)G+&c6J
fQAe&PQ7f>&b[H3SU0:-)H&\E&CCXROe+[\Q)W^g@KGP_&0E5cS?\d+^J57D8]_H
:a+_@X,/-Na>Ka&JA3F]T2DK0e?2?:A>P#>M[#F-R5UUc_+eBEZbJ]1/<B73e0_-
.EAc;@e<1I,>ODQc&=9I;DB3]I;ffE\F?6SK[\++b^)XDg>+(<A>LJK@2dTW=+Y0
YK]aIFSB_=M/0O[=6(<>DSf&3De)ODJJC#4db#ePH>FE>@Y-KbC@9<\ND;#S<dVU
,F&&NcDZX3_MGCLd[<&:SWP^c2HKN@e3P9G4)M.8.DNd26T6^ag([NJ.3;8PU1NE
^2RTE7K7\SXBP4AOBVSa,IGcXLO/&0;OI1)Jg6Q_/75a#WYYSMBTcaF6GP13=/B>
5XQcYQ7I:bH#e(5-E\I+8UEO6Ba08XRL:1>^dfBOMdQ;6)gQ6dR;IM1_JVK@5Ja4
WOc#C8\bZ;_YB1D+[+N9J.+X+a1E7H6)>Q::ZB.M8>^6G152_0^31_L9W,I0>@0[
cf0P&<@1[R@#@3S.I)8G#-??dHZ0MQeKQR3Yc:<N7ce\TV[?>)Z0-f3M@d//:&6.
?[JFNSENAQ,@dCN+\]>+FfE+NQS[B+>,RQ.+K&W:T@J9^b5Tg3MMBZ6\>Q0TI>+8
OSG3GIReTbU5f(VNTS4LJ2#P?c-+YAcL&_[9)>PDBV)UI[PHg-XRVDL9ML^><:b@
(>->9ROC54;Pe5cJ[6()4:Xb#2a),bdEgCA\)&8_^#6#LJK;^A8M@[aca]L96A+(
JDNA.3]1V.5DMV-K;K4^I6VZFe-UUAG2^>@X&8Q;?X@];=0Sa(TYadTPgE2Z^T9_
F_)aH21):f?eA&@5c<Ff=eU^TO7-QMNK6PPU)UT8U]MN#F;J\:=M5E;X\@PbA2:e
^T?.(.,HO8Zb66F#<QSB93D_ePe/GE3/dU9YfZP<>KY<]=e5>YV9_g?aE]I[C]5?
3_RW(RTSIO72.4M#LANBI?8KDJJ[#8c.7^XK0N-AbKJU?f)4]I1BM:bVG?@94:gE
PSU2d;;f;5WSAPBaaM([B=NbM<U3G5T&4OU<?HWLEA<43(e8DLQT#XWZ/@d26D]^
[2PLJ_B@V7BOBg4W+/A,1@bU(X;LCQ,G-1<<LEJ7H+?:T;eW9G8>QO/DQ)f3JR1H
d55HA?Q#fC][_9?C31>6,5edDNQYBA(Gf)JfcG7/)=]d;26?8C6G./Ng[8@CfM#/
+fc7A34Q8KD7Wb-:_c)0GR9F9\_I>1Gd@-T-(e<JXV@aI9481CWbY.9IP?<WCIJN
f\fN^80#Y<TB5fJT3GRJWUF\4E:)R?LM1C(QQC8N]>3Y4,NA8TRAG[2L9@V6+JHd
FUIfb]VB[VWCE7f,0]934SD-K.QgPV#F+^>XIWXX+(C:&[+5+.>QW4?VPS5V\b)<
Q@_OGQgcN.<NcR&U/?SOgM,IE7:#?.BbC[Ib<KRKSb3:LM9X_\X;IA=?W4^<9T6E
6bAH4+cQ\ab#0eWK38O_E9@Xg:[0\ELTC#8ZL)R(?1+YJf_CF@P/JfVY;NdXO8dC
YY<QaWBe3@)5Q]&B>0LXMQ>AfIICC>dAEf)L/X@H8\WK.T>3-:O^9R2bW_3+SU.]
T/F+9MNe-SY9AZX#E+J[IEA+/]=)e/LO52MCEE8-YWLf<FOW_KMV8_HIaBP37>\7
=+>QUBC7_JA?4aW]#J26KWb6;();;MDANH<OE<07fZJ-]-aIZ#]9U<.7NdKWW;@9
-?I;JAde8+><Qe5]7:KO+]TY9Wdd,UJ3R9D;LGgJ^CW>A@dY&2465)IH:WVcLS.=
XP&DO]&)8,DUEB(Z<RK8DY_eAM:6);@XI\>_._c@M>S^P#Q9L]QI>-2:;cOJ,QdN
U@[7Cd9W^EbBd0Y5-O,IIHgD\3&TN=EI&><_<X^KMVXg&Q=5=WWf7E7^]J9Y/BWT
9RO[K?2[I&K[9?\IA2]XUQe29=#FAZ:OAI]2G7EKeg-7Y]Y01/5DPAe[ROd.2&NB
B7NAY>CTM)>d6?,NFBD:3/912ac9R=0J#B?Od\E8aFe#Be[P\/&-QaDRdOJ^80T-
=3^T)d_L/b_JJ60-+c3^L@)4[>JaNTSS[^7;[UU3Y.H&#DJ(YE2,K/3fg8@LOU&)
[K3M<Ve,H)ML.1<HC?=_b6M2>VB=.C>,/[d[I:8;&a5fDQ/UF#&V=:&WW:Y)&dJC
VM2JO])Ib_YaAI\I;#U94PR(,@]K^+?V[FeP.-J,K#^@a/)N=15LS\5LAPaW5P3O
>G>D94UF2GUZ+4,AA<MIAY4YcV+>78,#A[ZfB?<?Yb<5\dQKc^+S[QKWU=ED)[^H
ZY\K/R1>Z0MYY_GTddHS(,HH<If<@\5[/1^[?#:=57]XC;2Q[UX(B6/RI9-\YUT1
AX38f/XV[@-LUDV?&+/dR[5-0e2VDdBFAOXHR?O_2+XA4D=MA.b1;-D&,IgSJ/T:
b]]CGagPWc?RdS,&U81WYbI[XT&V\K]dd+fQZ_#D^dd-6-H0(?L4F2==+NEM^-b<
^2-J_KDY.GXO;^g3ZKML=bRWddW=\CgW<>\TT)]1ZSTB&e_EW(Qa3#Y.GEU;CE<8
)@V[1Z7Z]^QC7?-8)BE/9VY.]EBJ3>B3]fHM>+P9JR_VGPb]#>@g[B7_,_0A.aDd
3IV3X;1T+-V)IDeZg<QV[Y]^0LDN^d/e_V@\HGPB]U;UO<_>M(7[0[E&ITZ8\V>V
Z>6R&Y)YPGZ#-/;f.]/--Z:7W3\[@SSXC=dL3>fJe<&Z@:4+1(NBB>/MV,?&^3;a
6MB7^@e>(+(Z;#4&A6M+:=T2LG\MZ&eBT+0-QHN5?[M1UJ5NZ.AN[:/>G?5XRX-]
@=Y)P[D.LSG3R9,A=f,9091]0]3#9MR4SRV:;>5/=B+6W5\^@]g&Na;Hc1ff[V_Y
Z802[7+b,7g-7^30-R#Ef<07ALGJS>HRP2VWbg/6(IZ.(DO.S.B.Q2O,aXfDX=H3
RJ/U5b3Da8)<YN-Q8GcQX2GA[FW<GT:)O<8^aIBb6D^0XObX7)J5RLCP3aNbgf3a
Y><1N.7#?:dbB0CWa-VBO&bO<M;2/3GFSK3IOD+8BP,#;MOaBYcINY@<f?[K.;E[
/2:A8KH<_<.7EDVdNFeg-U6FC>-UJHffOa/ZGLI)2M(.QT<.&7I)^A)O1Z3K7E\Z
?ISF?[5]PYYD^&Z]L5cA#R\OXVKI/P1F2=C892g?52B,QK5b^e/1]Y&^&V<3E:O/
4#@U@dPYB4KJe\3&c8U\KI;DXYFb:=[M?REV-+-3<?NTH7+XaVf2QefI;=;Ndc3A
3/7T]fH4+2/H<(NP:.ZSb\83Y:VDZe<)-KE;]R9cK@:#UWO<M]AIZgL)gcXE__a2
c9-7\cU>6\ZZKSeHXKMV/VST[T8db5UER7IKX^=GT5VA1gDNe0@NVFUR8-7OaQdD
ADc5aM6IW1K-7[.bYaIRNDA:d=;G3);,XA(dSFYWF=[E?/Q\I1HeX0/)PTOUf:@:
,<_FHYgCYP7)dP:=f8S8U_c^.J8,GMWY]>dEa;3d@8#Rg>X;fL0/B_S+]gFH^G(N
F8=-16+Q\A54eA/LB9R#K7PW2#>DX)HGN4fF:;I9aKV3->Xc5EZC<=B]5LIC149V
O+LJKSR6)^cZ/78TI0N7R8S7+;dYOGdT)/V1G0YJRE;^6gMEKFR/Q5351/+dRCaG
cO#CS.L[4FaW^&;NI2V-#M-IKM:XZf5.8cJd]9FSWbTW_,C]P6dH2TJX5O(T;UJO
8fNbXM-WY[@,fUa^/TUGO3^L5E69>eER6e=[5Q.)66GR8]E-B3H=ZCG;Q+/D?+;f
5(R&)QAO66O:EG+eU.:BK=fGB(<<:JKdc#BG][-e,72fQAYAGR&IQ@D9_2>BT12A
>X8N1bB<Cg3fNNE=>^dPL,H@_aOX5Q6=^MC_3#>G#La]G_ZD.FKaC93RK#5WM:UM
]X4WJ7RO3a(4S7gIY_e5LV1I2&g8RFgbA/#f0EP>>K;U(D:-ZEG)^Ja)<+,IO4LL
?\;e#3U^[&W5aa/0RM;HJ.I1ZW+CNUb47fE>RDc1Z]L@DF:[V))ddS6SFL[C2D^C
8g<a-O_g]?>;NZge-(\1+dDI0/PQZa^Da7a-F(.1Y?(AZ6Jgf5b6.KQL-HG?O_Od
Sf9JEce&MT1.fBfV28fAU8B90PK>CYdCA>]UIK+<UWGd=(.X)26TUfFIE=UPD2#7
#0T.I[Z#F>X6@56JW1S1g2@GFG28f17G5/;\8\Qc27b8aVH3_0QXb#aZ9BP\UDSf
(;)22Ga_J8_b,&c&W;[U-c[2L\^309U=\N;Y6d#UN1056<-e?8g_2H@.(B0JBHOQ
P,[VQ</)e#^:Hg+Z6T\TY,ZY#&dW>5?<SN.-+Ga++?^X7)CF&)<PG2L(Ab9fKK]J
=4];AER>LD6+]].RIU_(?6IdRgMDV<Y-61#Ze=/eR[4Y\^2J?(LT\4-^M)S9fM.L
]Pg>J6Od3-X9>RB>7afBF[bR/^C=AU8YKVScL5LM+U>B/+e;<+Xg5;[>(OC;D9E\
d)>HcZ0IOfAcfH8g?)4S5R_T+^+@@7/24YE0UA)fQ_2V>]KAXeIZND1a,Q65=DAE
A@OfF;b1H75S^\eDM\+1MUIO^KTC<WN9TIJeS<aKd2VMQQc+eV/VKeF9]M4g<=gX
<#H8d@Z0L1:;O(2eN[1^fS5cd(65g.Y)+d]@N#FL@aF=WCO0V2,Q2SN6-RS+;/83
K005gAE^6)P6NV7=/,MC=L>^0;QZFJRD4]LUA6)#[OQ(cF_S@XM-_Ad3#&Y1X6SD
\WC:Y20c>d)X&IXe#&J]PX?<,ED-)-H[TW(NU4PGL?_RKW0]>bH8T7A9Jab0IG>N
WSTQf>C=](1KBX2bP3dZK<:N#UR(Q?OBf7Sb<0R\C7W&MfO+X,YWG7Y[__H-Z/#e
FVJGb-[be>3=f_)&@2g=GgKZSLLS12;LfWZ.dP(;/IB\cCG\K&:G3AY+AaWF36A^
,).@=OI3V.b8]EV>1><;Z?>YH9Zg^LJefbYT^[,9N=ZD@8.+#.3K,Hc8BBbH/3Wb
QN9PYQg]E7?W,/-=3\=F:4M+<,eDB/W-^N,J]LSO]644?K[04QL[>6G:+#f+8b?N
gDUX:C0ZHKMO&g;I/eD>JIFfDQg&(eC4#I0B;JX;5E:@;9ZZWJ6b]YDJ8/OF/,<I
FCS55Ue20L67Y7,K)0=g\f8^F\KJbegB^aPW.b4+NBD3f_5ZBfQ4d(#MO<f\bFA^
,0[RX>c>MX[KU&d8N]=PNYP#39F38,)KE2X/&:78:PTCC:)?^-=/YR#^@.(0\Y&4
JF/0I>XDFP;1MfBKg97&d.)VWa_847geH4G._43/QV#,U(CI;VP?IE,@&D>UWQTB
VUGJ\Ed<fKR;P=Kec0SE?7EBa]422(YTZg_g\MG8:?:c#,=:(.C0;?\=4J,7IJ4Q
YLF_;1I5KN[N>>QM=7BC_)#Q3(?.eRO4Lg/bDYGJc#8-95JF6,O;JDD)N^gO/VQO
^#Z=WJNgb1e-6CEbATEf,I1?GgF5A?3EXCVZOP:D?g?O)[LcL0-11#E+U6YA2[Ha
9Y#YC_IZ;_70]eKG)XTLQCVg>W^EPK35Y;I)G.#+?7,;2OI]LV?>FMF8?-P7_04=
#/]Vb0S@>Z>OKTg3O8DT7e#g7^-bE(4;VRX<I[@GW4/b&#@c_Ed,B/S02KAQO:N5
B]DNG\:2/NY>+F)Fe?f71HJc9-2RXS<20)MC@D/AAH:adGBZV2C/XEN]+Ge5Z-8J
7:B-7K_]VaAVJ9.A\D_G8>;[X=MGb5H9:cU1&:QF@1CQ(BF/\Kc)LV_XI)I[_:2E
>F&8?_Xc\f;DgO94AXWXC^G>D35)0R9aI5f^ROB\SO<C52[KBLI,F4(ec@-?.b&+
=A>U7H?B-ZaW:87ZNMH27G0cRM<VV;T[0dFG:F-\AaJ>TDYe0P2Pc&9A<RdW=>D+
\cULB4(_&2Z(64bUc1Q:12Z:.,[V4_J)[OGC8VR1QA<(8UeQ8UQ2;P73UL^K-<X=
TGbe2>=+b36MEH^3S-3UIFW(0Ig(B-9&0FK5R5;K-9(C^;:dI4[Fe6940P43U.._
(SJU[?;EfL?H8GeK@H_CR4YPHg?6CcN7JfNZ]EJ;cf1Z&76/Q?8CQVc:@4O(.:OR
.A+cYF+>KQBA<8,(O>TX<-@9_I[4a<77bfJ:KaF.0Q:LEXbd+>\IL=&/_<2Z@VLW
:4JI_Y6[cTP=HP8<MTIED<LLgFLAVcK2WZP6.2I@F&D.D)->[0Y(]b^VJ;He.fO?
9[eZU,?B,N\:#.A:HdYG-_3V9-:+4E^TR<>HI7;8Cg^34+DYP_5@RO=PVFZ7UX)9
(aW+YF.HR3FA5K6R:Z1ffPJLP3^#-]_Q]-HF5T];Ge6U1P48.<S,NS\8.F4f:(g?
[-/5-;VeOTcVII;,8#GR-ZZ[T\&:2WUMK6ba6Ja:J81BGD:HWRD,cLVM__M-GZ7[
7.^X9O92Bdd,?#W-:)0.FBV>F44H=8cb:aF1Ua^][8]C1,(dBaaeb18W.AcHE+#P
BLfGSI&fE#M(+I)fS[2Q10gHf5KF86)Vd919W\W+F#1Z2=-UUQ9X3:7gA7@L,>Q(
6Rf\;e1I@-A??):77?d\g6O;PO;FRW6RddLSKR10JbUdSgF)d_DOe/;Ze4H7=+Dc
8YHKGGaN0d-?+<,SJ9:+1L<FVd2AL?R3dGP:)gHgeG=YM7eIMFPIBKCWL>;78b4I
16c[F5f7)aA,2^VOU\IgB<R.QW\)T7&5GW??-3a[g?_-5AI>d71M8[OXHVX.)3+d
E3WDAbeNTKQX\UEWI1e.0)DdTR8GILc3P;+>S>[^BUE+OD0/6>N<R,Wc)Id/bCg-
DF1&?^5(eZ]-KL\g2-6Ff:FR2\O8&/+Og\Z^M]PJd-(;^0P.9@UF37VMXM#[Qf^9
M,X@M3/W6U)K42G?9]PQVB?0NMQ06.GN>2O^c#aV;,+[8dO:]I@e3I/[dc[YA_Zg
0AGBf<eBT]W,H,8,g75E)Y]aF1ST+NLga[8]H(WCP>ZZLPW+Ca=EEa;A.Rg8R:eJ
d.DFe1T_O3\L[\3IQ4\C=>>^1@Y(TV#8MB2P]<1(ZCeS/3BZZYBRL^)g@,;aAR[@
:@(SX6\d1)]<#G/ND<PZG&=?K);PaH\b]-+P;(&@B:[LI7Y#C0X=5+<APA#8FQ94
ALW4LP3X^dPTQ&J>KR22N?J6D.-R\U5gI.:2S_F]R<IQdR6c(>4WN9WF6b;aK150
FL#OH_;-M#T==6HNbLZ\HUVeDbX-#=LbL.?,SL7-2P,[:@f1OK\R#),PYc[PSHc_
90C)^6\cYMU)X/fA#2P-PXdHf8.#0<<[^FID06W+]N=<?.C)UX20+abC?dJ]CA=e
,,eW]4HY\@:P2:QGS/Fg;JI,.PEDMC4[_9U0]C/MDOQA7W-YHFN>7\g(IE]SI,>J
:>N/cY(<:dAQR?O@EQHSMJ:O9\34T0c9K)g3:\_?3UH@e5Q0-(c9&2d/,D01I:^E
UaSRYSFI\@&c52(HQb_[,cO):KB@V<_87E,#>[@c3\DL>MKE+TQ9=U9-VBJ_\UWG
9=HVLAD;+8e>7c@>[./9<\:69e3EEXF6K7Y3J67CaOJREc22NFU0gBLdC];.L.LK
f4&)TD?7G^G>05)Ag1&Q/LPACLIK3JGK?WGS<IG2IZGW#&NLCHF)LbV^Wg-;Uc6d
7J5eI_UKU2b],(GfgUN+JM2/RLH+NAN6UKdBbK8d,_3_\[d+AWYc^+^L4C05[BQ-
GZ6<,M3DJ4[?[WI?/aAaF)4Z7B-NS+ffRW9U:bE,Ge9?I(2+]gf>3D#OH_#7&:Q3
#Nb1H);=TOJQGfLMg>CcE:78DFAQa#7XM(AUf_-Kb;MgS?P[b4g7O54:UJGJ.,^>
92WZd[dg6a1H8(]5)?M3.MX3.^;<;=[Yg0E7#G,.TKZ?ZKSQ^(@FKFXPW&0GLa08
03ebf\&_:cF^=.SHJgS#:ReH)HZ=;CWQe^Z6Nd]3C?6-T+=8(J_M,eQaa6X+8_:c
-=G8S-bLO@.bKRKb(&.d#.MA.AXI2B]_;gFVI)FNOE4g)3G7.329LgD^^ggd(9&_
G1b6&J_57LB=9>MCUXc@5>GJOAF]&d6+b95D@7Z42+6ZK,>^>>,b95aeQ5FR</]P
P^YcQOQ?\.Q84]]=Z5\3R1b7g:O/3YLagIbY)OAa:K4FU4B_F3Lc9FBdUFQQO+YS
P5g),VZ?8MRfDg^M7Q>9;gG1,J#)<7H7YLP#&2S5gZF/6d6KJ[,^[J:WVfBC/AU7
Fa.4HTe2T&RFg#Q&g2Q&+/AeJSIIAH5gUG&VF7A3Z14G<\UXS[[)(c4JgJKQTJFI
K036#B-Q4(88(?-VPNP7VGEIA\)QI^3UX+\A=>5CBYdCd:Y0gUFC<JKER#+4F)Af
+MK@<_2a^CRKEbc<VF8\3+CR.WgK51;C0;35,O\-M)ff^2@IKg]Z4S1dB2>S-5(U
.A46X(1VRg2ENeH^8.:#Y];YOa8TJ1847+E^S[>f:#\HfR9+HBJ@-Nf](=^T0bJX
6OYGL0Y=_]GPf.>CL^>+2LU^.ZRfD^H_Sd-If=>.[JeM^eLFBU4^BLaKQVaGbI=1
&MHf=TI6aB.1HB:4,-NaCC7#>#3PF7;HGT9^IOWaEV[Og45;BYZNJL<@0VCDKS=3
4P2OM?f&3]7S-+?YNGTJGNB:8W[17;L?Sa04ff0<I_3e[F-61I>M;_?N7g-eTa[]
WBZ\F^gRb:E^;V(U1ESCQF@Q=D3JL(KYcD=4Q&9Z]BT[Z2,MB](LU-MM>KWK;Ve]
XANF+KP>;CdbZ7XJ(SS01/B2Z],+?QK2YgSL5+?UQ-),422&85c22fW4AN0\6JEE
^HC9>GA\afH#M\B,R@^VeXJ+aIabIDWIgeHe9:1S0TJ.S<e0QM&d]3<6g-..4[H8
)^@SF\)b#>bY^K;O9OD(8=1[&>;IU.16#]RXZeNZ(OW,)9H6Z\]LDaW6D/aI/8Q4
GWg(?W:XA?45DNSTFO0?P5O,0)J\+\I/eW&YF[cWecX)d6XYAc;aSE26a-Lb;E>e
JP5JF:OR0LQ?XUH42OIDc-7@4;QKHa&)9G^aR43N]QPU<#)RgP.F],F0[C:7>V@E
/P/>Q^FGN[_5cOPRPOQ^KW7(eRG--a]>]CSHR6be[5]+/+-AT:[W7YeX4B3-J?[b
XNbZK+JDEV_4=+]K[8;>^28^K9,1[8.VWcK(Kb\EOW0C86e;JYN+<Zf1(7QF,U\\
D2]JHE89GY][ga[+)D6J3eDBb[Q@J5I?\F->E4W-6[X\X&e5>YM3O2IAR-G^,)#/
=0#-G]fHTGY6]f.\81^>eAcOYCI;1MJ?5G@P;<8Ja::S/8]7@&&W?(e=3c6+:F#:
M>Bd;K5SR[d&b/5_]H(eAW@fFHPYdJSfK[E3RfF8Tb(#fM5JE7O72DgVPfb.2W;C
6g\##VTb&-]EW(L):g5K1<Q5C_IJW:C7^61bR+<ISY7/<03P:XM^UGD+)S[gT7f+
HVHUEdZ3B\0-XJU07QFJ2I.d47(Y#Ve-K5);R:9Eg,bL-GQA#W:L#@P\3cUIKPPE
DQ:^S-I-/&8JRULJ4/WaV<5&,A^Fg[MaX2--,?Q17e0@]eO6L@CaHEBW4[H>fQT[
c(8&3X]2^E78WD.cTA;XY;OI6)GA?/9Dd@2OK\?EVW1J7:1UGc.-\/ZC04+K<]0;
1?)QeOZ8[E.I/^09K<AEJ#_BbQ4L/,G_.#&53W.Gf5g-f1QPM8\H]bb1&Of61_ee
I)MG<Q7HbAPEX/96VXP)2&]P#20SYHa-&f+dg^^B?/_ST(K9Sa3b37-[.=X-JJOE
^7_D\b2)OC,b4A7K6QcSf1_0[XW?6735<8=2:-W>,aKgcRTN7dXXdFM^7:#PaTKU
X0Q5DF<+E@bGYa]Z#^(60;gKPVWc3^SG+2=[UV7,]QJN),@(XG8)+1+^:#6?[S?b
DgZ([/ee@M616:MDGW[4[4KC^bBP:,79O=R@8]D(Xf-V+AD1gZgPRG/V##50J91B
LK@UgMaCKFX^cR=/SBg]OCGFCRPJ]EC)-9f2.[af>Kd7KN1^1ECg>>?;)&#1BY2L
Y4_+-KD&B=B4L/4A?Odc[K:6bP9WgEFTWf+2:dS#B=IIMd^8M>d^2E:9AfaI(Fd6
@F3<XJ@\DMUg2&RG(/AF[8:3@/L@6B2BQH[/T4b40DbV9<_NJIJXcYT0U;/8M&c^
@3F]6H?_GNaSA@4WcTME.,Q]X@gH65A_P8]IG]<8B]+UB;)(ZfIda1?T)B3GHHTU
g[JBeRfXE-OAW[.NWf?Sb^>\&-:=E+F]O=:[#PVbCRY0gdLQTA4\E/9(5R66P>RI
&ITO&f8IYR/?M@UD32,LL3@_L9,^3Ze-?8[#MN;QF1Z&++FZ8&SU&]:_)\)R,WX_
,YgNHD5,W)PLU.ZcBYJ/XU3:/:L/<c:ZQ^H>9/&<3T?9(D>_-8U.N/27#c)QMg8=
Q^#9(dSF+TP<(bU8eO;2.\RO7Dgg5]9+DON^DcJKg8]2?<HZW4SLDB:U_(WF@0EC
3J.D;8?7X+1d\TJU&3a5>Xa#9?c\Va2&e)Le(0<V=[bXF>Ng\a>BOR.RVK@DAbIE
bc0HM;(8)NS<>HaUTY9\L=?-Zf7bc_?0d1M\cMEa-\M7,>IS<L9]C#8fI2#^e-BV
2D8;eZG.b/1391aR<M[),-/cC<daQcRDdU#0:Y5/Z0ZB#.;;#9_ObZSUGC;?=];)
QIFeZ^/92&fc&0UE)1O@J+?4V4b6?WDYD9B15P,PM_03>\WO]/MFT708S\MV7=;]
Dg:/.=,U_aDS1D[0EYPV&d,E;&9Jbc3/:$
`endprotected

`endif // GUARD_SVT_ATB_TRANSACTION_SV
