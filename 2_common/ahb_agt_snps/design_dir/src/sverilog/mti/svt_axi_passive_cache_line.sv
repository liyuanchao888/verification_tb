
`ifndef GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
`define GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV

`include "svt_axi_common_defines.svi"

/** @cond PRIVATE */
// ======================================================================
/**
 * This class is used to represent a single cache line.
 * It is intended to be used to create a sparse array of stored cache line data,
 * with each element of the array representing a full cache line in the cache.
 * The object is initilized with, and stores the information about the index,
 * the address associated with this cache line, the corresponding data and the 
 * status of the cache line.
 */
class svt_axi_passive_cache_line ; //extends svt_axi_cache_line;

  /** typedef for data properties */
  typedef bit [7:0] data_t;

  /** typedef for address properties */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH - 1:0] addr_t;

  /** enum type for passive cache state */
  typedef enum { 
      UC       = 0,
      SC       = 1, 
      UD       = 2, 
      SD       = 3, 
      UCUD     = 4, 
      SCSD     = 5, 
      UCSCUDSD = 6,
      INVALID  = 7
  } passive_state_enum;

  /** Identifies the index corresponding to this cache line */
  local int index;
  
  /** The width of each cache line in bits */
  local int cache_line_size = 32;

  /** Identifies the address assoicated with this cache line. */
  local addr_t addr;

  /** The data word stored in this cache line. */
  local data_t data[];

  /** 
   *  Dirty flag corresponding to each data byte is stored in this array. 
   *  Purpose of this flag is to indicate which bytes in the cache-line were
   *  written into and made dirty.
   */
  local bit       dirty_byte[];

  /** 
    * In passive mode exact state of a cacheline is not always measurable or observable
    * This can be inferred from a coherent event i.e. coherent transaction receiving 
    * response from interconnect or snoop response received from the snooped master for
    * a specific snoop request from interconnect. However, in some cases a response may
    * not have enough information to infer exact state of the cacheline. Instead, possible
    * legal states of the cacheline is inferred from those events.
    * 
    * Due to this reason a passive cache needs more number of states to describe coherency
    * status of a cacheline. 
    * UC, SC, UD, SD are defined non-ambiguous states and all other states represent 
    * ambiguousness of present state of the cacheline.
    *
    * NOTE: currently passive cache supports only expected or recommended states of AMBA
    * AXI_ACE specification.
    */
  local passive_state_enum state;

  /** indicates age of current cacheline in terms of its most recent access */
  local longint unsigned age;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log log = new ( "svt_axi_passive_cache_line", "class" );
`elsif SVT_UVM_TECHNOLOGY
  uvm_report_object reporter = new ( "svt_axi_passive_cache_line" );
`else
  ovm_report_object reporter;
`endif

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of this class.
   * 
   * @param index Identifies the index of this cache line. 
   *
   * @param addr Identifies the initial address associated with this cache line.
   *
   * @param init_data Sets the stored data to a default initial value.
   *
   * @param init_state Initiallizes current cacheline with specified cache state
   *
   */
  extern function new(
                     `ifdef SVT_VMM_TECHNOLOGY
                      vmm_log log,
                      `endif
                      int index,
                      int cache_line_size,
                      addr_t addr,
                      data_t init_data[] = {},
                      bit init_dirty_byte[] = {},
                      passive_state_enum init_state = UC
                     );

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored in this cacheline.
   */
  extern virtual function bit read(output data_t rdata[]);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data to be stored in this cache line.
   *
   * @param addr The address associated with this cache line.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data corresponding to
   * that bit position. This enables partial writes into a cache line
   * 
   */
  extern virtual function bit write(data_t data[],
                                    addr_t addr,
                                    bit byteen[] 
                                    );

  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function void set_status(passive_state_enum new_state);
  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function passive_state_enum get_status();
  // --------------------------------------------------------------------
  /** Overwrites the dirty byte flags stored in this cacheline with the value passed by user */
  extern virtual function bit set_dirty_byte_flags(input bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
    * Overwrites all the the dirty byte flags stored in this cacheline with
    * the same value passed in argument.
    */
  extern virtual function bit set_line_dirty_status(input bit dirty_flag);

  // --------------------------------------------------------------------
  /** Returns the value of the dirty byte flags stored in this cacheline.  */
  extern virtual function bit get_dirty_byte_flags(output bit dirty_byte[]);

  // --------------------------------------------------------------------
  /** Returns '1' if cache line is in dirty state */
  extern virtual function bit is_dirty();

  // --------------------------------------------------------------------
  /** Returns index corresponding to this cacheline */
  extern virtual function int get_index();

  // --------------------------------------------------------------------
  /** Returns age of this cacheline */
  extern virtual function longint unsigned get_age();

  /** Updates age for to this cacheline */
  extern virtual function void set_age(longint unsigned age);

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this cache line object to a string which reports the
   * Index, Address, Data, Shared/Dirty and Clean/Unique Status, Age and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_cache_line_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this cache line without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_cache_line_value_str(string prefix = "");

// =============================================================================
endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aNcNQd/RCAlSt0ob5suUbdzpqNJMiQITbVw7COJ6Qrlewg0gZ2nF2nJpdiVbLQWi
R5fQ6Q2aEP06bTPpulkxCrEs6WBBgQzmfh8BRmcJA3e8Pq4MShd+tjxoenbD7rfO
5wkvt3j/QBPRKB4vTDGff5HV5Qqj1MYpiF/XaeqCzlQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1808      )
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
`pragma protect end_protected
// ----------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VpwPn8EtJsJZJEeJachAmc2DufXzoRQbtPzEUnvws2Tfm2gt2l9A4R/fnjPyKZgP
GRKRIczvsZVmX+YuWJ2R2KmOCKglLC4f3gcDeRuYOh1zSHdwMULAmqO9SxQNQQN0
MmC/pHu7do5ULmJyQCmtvPvp/3lTWV51/wOet+Q+eM8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6196      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bAV9pOacpkBFz0yeeItZrOtJ+yBUcRSza6hGIpWfvAcJ0YWpXfJ1YJxemvSMsaeo
3bYYOqdjFu3fbUjR4zn12hlC0Hgmju0qjXar9dLkBYLq1H5OOTW0vNMeVf6yDKmv
qBuVoJJwFfyZVgDCH1KQspzN/dg5boCkaUf19uXoiIs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6279      )
K1b4lMb3yLROLFubRhIyWFGBgU7Q2GFyrohiYkyxi4zDL4ipTHz6VIu1o3L1nBb2
viT10MbFv1XLVQrs/vCJbOuFKRWJuXJLev56AQwgMKPEa4Wg/0heIlxQhXis5NdB
`pragma protect end_protected
