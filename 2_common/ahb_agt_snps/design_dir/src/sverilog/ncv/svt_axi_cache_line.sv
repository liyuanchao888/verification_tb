
`ifndef GUARD_SVT_AXI_CACHE_LINE_SV
`define GUARD_SVT_AXI_CACHE_LINE_SV

`include "svt_axi_common_defines.svi"

// ======================================================================
/**
 * This class is used to represent a single cache line.
 * It is intended to be used to create a sparse array of stored cache line data,
 * with each element of the array representing a full cache line in the cache.
 * The object is initilized with, and stores the information about the index,
 * the address associated with this cache line, the corresponding data and the 
 * status of the cache line.
 */
class svt_axi_cache_line;

   /**
   * Convenience typedef for data properties
   */

  typedef bit [7:0] data_t;

  /** Identifies the index corresponding to this cache line */
  local int index;
  
  /** 
    * The width of each cache line in bits
    */
  local int cache_line_size = 32;

  /** Identifies the address assoicated with this cache line. */
  local bit [`SVT_AXI_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this cache line. */
  local bit [7:0] data[];

  /** 
   *  Dirty flag corresponding to each data byte is stored in this array. 
   *  Purpose of this flag is to indicate which bytes in the cache-line were
   *  written into and made dirty.
   */
  local bit       dirty_byte[];

  /** 
   *  data_check corresponding to each byte of the data.
   */
  local bit       data_check[];

  /** 
   *  data_check_passed corresponding to each byte of the data.
   */
  local bit       data_check_passed[];
  
  /** 
   *  poison corresponding to bytes of the data, as per poison granularity.
   */
  local bit       poison[];
  
  
  /** 
    * Identifies the shared status of this cache line.
    * When set to 0, a copy of the same line could exist in some
    * other cache.
    * When set to 1, it is known that no other cache has a 
    * copy of the same line. 
    */
  local bit is_unique;

  /**
    * Identifies if the line has been updated compared to the value
    * held in main memory.
    * A value of 0 indicates that this line is dirty and that the holder
    * of this line has the responsibility to update main memory at some
    * later point in time.
    * A value of 1 indicates that the value of the cache line is updated
    * with respect to main memory.
    */  
  local bit is_clean;

  /**
    * Identifies if the line is empty.
    * A value of 0 indicates that line is not empty.
    * A value of 1 indicates that the line is empty.
    * applicable only when is_unique =1 and is_clean =1.
    */
  local bit is_empty = 0;

  local bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[];

  local bit tag_update[];

  local bit is_tag_invalid = 1;

  local bit is_tag_clean;

  /**
    * Identifies if the address corresponding to this line is privileged as
    * per the definition of AXI protocol access permissions
    */
  local bit is_privileged = 0;

  /**
    * Identifies if the address corresponding to this line is secure as
    * per the definition of AXI protocol access permissions
    */
  local bit is_secure = 0;

  /**
    * Identifies if the address corresponding to this line is instruction or data as
    * per the definition of AXI protocol access permissions
    */
  local bit is_instruction = 0;

  /**
    * Identifies the memory attributes of the address corresponing to this line.
    * The definition of the memory attributes is as per the AXI memory attribute
    * signalling
    */
  bit[3:0] cache_type;

  /**
    * Identifies the age of this cache line. 
    * This gives information on how long it has been since this cache line
    * was last accessed. A replacement policy could potentially use this
    * information to decide if this cache line needs to be evicted.
    */
  local longint age;

  /**
    * Identifies if the partial cache states[UCE, UDP] are enabled for this cache line.
    * When set to 1, partial cache states are enabled for this cache line
    * When set to 0, partial cache states enable are not enabled for this cache line.
    */
  local bit partial_cache_line_states_enable =0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of this class.
   * 
   * @param index Identifies the index of this cache line. 
   *
   * @param cache_line_size The size of the cache line. 
   *
   * @param addr Identifies the initial address associated with this cache line.
   *
   * @param init_data Sets the stored data to a default initial value.
   *
   * @param is_unique(Optional) Sets the shared status of this line. Defaults to 0.
   *
   * @param is_clean(Optional) Identifies if this line has been updated compared
   *        to the value in main memory. Defaults to 0.
   */
  extern function new(int index,
                      int cache_line_size,
                      bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                      bit [7:0] init_data[],
                      bit is_unique = 0,
                      bit is_clean = 0);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored in this cacheline.
   * @param data The data stores in this cacheline
   * @return Always returns 1
   */
  extern virtual function bit read(output bit [7:0] data[]);

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
   * @return Always returns 1 
   */
  extern virtual function bit write(bit [7:0] data[],
                                    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                    bit byteen[] 
                                    );

  // --------------------------------------------------------------------
  /**
   * Sets the status of this cache line
   * @param is_unique Sets the shared status of this line
   *        A value of -1 indicates that the shared status need not be changed.
   *        A value of 0 indicates that this line may be shared with other caches.
   *        A value of 1 indicates that this line is not shared with other caches. 
   * @param is_clean Sets the clean/dirty status of this line that indicates
   *        whether this line is updated compared to the memory 
   *        A value of -1 indicates that the is_clean status need not be changed.
   *        A value of 0 indicates that this line is dirty relative to the memory.
   *        A value of 1 indicates that this line is clean relative to the memory.
   */
  extern virtual function void set_status(int is_unique, int is_clean);
  // --------------------------------------------------------------------
  /**
    * Sets the protection type of this cache line.
    * For each of the arguments a value of -1 indicates that the existing value
    * should not be modified. Definitions of priveleged, secure and instruction access
    * are as per AXI definitions for access permissions of AxPROT signal.
    * @param is_privileged Indicates if the address corresponding to this line is privileged
    * @param is_secure Indicates if the address corresponding to this line is secure
    * @param is_instruction Indicates if the address corresponding to this line is an instruction
    */
  extern function void set_prot_type(int is_privileged = -1,
                                     int is_secure = -1,
                                     int is_instruction = -1);
  // --------------------------------------------------------------------
  /**
    * Sets the memory attribute of this cache line.
    * Definition of memory attribute is as per AXI definition of memory attribute signalling of AxCACHE signal.
    * @param cache_type Memory attribute of this cache line
    */
  extern function void set_cache_type(bit[3:0] cache_type);
  // --------------------------------------------------------------------
  /**
    * Returns the status of this cache line
    * @param is_unique Indicates if this line may be shared with other caches. 
    * @param is_clean  Indicates if this line is updated relative to main memory. 
    */
  extern virtual function void get_status(output bit is_unique, output bit is_clean);

  // --------------------------------------------------------------------  
  /**
    * Returns the is_unique flag of this cache line
    * @preturn is_unique setting of this cache line
    */
  extern virtual function bit get_is_unique();

  // --------------------------------------------------------------------  
  /**
    * Returns the is_clean flag of this cache line
    * @preturn is_clean setting of this cache line
    */
  extern virtual function bit get_is_clean();

  // --------------------------------------------------------------------  
  /**
    * Returns the is_empty flag of this cache line
    * This is_empty flag is only applicable when both is_unique and is_clean flags are set to 1.
    * When is_unique and is_empty flags are set to 1 and
    * - if is_empty flag is set to 0, then cache state would be represented as UC.
    * - if is_empty flag is set to 1, then cache state is represented as UCE.
    * .
    * @preturn is_empty setting of this cache line
    */
  extern virtual function bit get_is_empty();

  // --------------------------------------------------------------------
  /**
   * Sets the age of this cache line
   * @param age The age that needs to be set for this cache line
   */
  extern virtual function void set_age(longint age); 
  // --------------------------------------------------------------------
  /**
   * Gets the age of this cache line
   * @return The age of this cache line
   */
  extern virtual function longint get_age(); 
  // --------------------------------------------------------------------
  /**
   * Returns the address associated with this cache line.
   * 
   * @return The address associated with this cache line.
   */
  extern virtual function bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_addr();
  // --------------------------------------------------------------------
  /**
   * Returns the index of this cache line.
   * 
   * @return The index of this cache line.
   */
  extern virtual function int get_index();
  // --------------------------------------------------------------------
  /**
    * Gets the protection type of this cache line.
    * Definitions of priveleged, secure and instruction access
    * are as per AXI definitions for access permissions of AxPROT signal.
    * @param is_privileged Indicates if the address corresponding to this line is privileged
    * @param is_secure Indicates if the address corresponding to this line is secure
    * @param is_instruction Indicates if the address corresponding to this line is an instruction
    */
  extern function void get_prot_type(output bit is_privileged,
                                     output bit is_secure,
                                     output bit is_instruction);
  // --------------------------------------------------------------------
  /**
    * Gets the memory attribute of this cache line.
    * Definition of memory attribute is as per AXI definition of memory attribute for AxCACHE signalling.
    * @return Retruns the memory attribute of this cache line
    */
  extern function bit[3:0] get_cache_type();
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
   * @return The cache line value as a string
   */
  extern function string get_cache_line_value_str(string prefix = "");

  /** @cond PRIVATE */
  //----------------------------------------------------------------
  /**
   * Overwrites the is_empty flags stored in this cacheline with the value passed by user.
   */
  extern virtual function void set_is_empty_flag(bit is_empty);
  // --------------------------------------------------------------------
  /**
   * Overwrites the dirty byte flags stored in this cacheline with the value passed by user.
   */
  extern virtual function bit set_dirty_byte_flags(input bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
   * Overwrites all the the dirty byte flags stored in this cacheline with the same value passed in argument.
   */
  extern virtual function bit set_line_dirty_status(input bit dirty_flag);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the dirty byte flags stored in this cacheline.
   */
  extern virtual function bit get_dirty_byte_flags(output bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
    * Returns the sum of all the number of dirty bytes
    * @return The total number of dirty bytes
    */
  extern function int get_dirty_byte_sum();


  // ---------------------------------------------------------------------------
  /**
    * Sets the poison field corresponding to this line.
    * @param poison poison settings corresponding to the line.
    */
  extern function void set_poison(bit poison[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the poison filed corresponding to this line.
    * @param poison Poison setting corresponding to this line.
    */
  extern function void get_poison(output bit poison[]);

  // ---------------------------------------------------------------------------
  /**
    * Sets the Tag field corresponding to this line.
    * @param tag Tag settings corresponding to the line.
    */
  extern function void set_tag(bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[], bit tag_update[], bit is_invalid, bit is_clean);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag field corresponding to this line.
    * @param tag Tag setting corresponding to this line.
    */
  extern function void get_tag(output bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[], output bit tag_update[], output bit is_invalid, output bit is_clean);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag field corresponding to this line.
    * @param is_invalid Indicates if Tags are present for this cacheline or not.
    * @param is_clean When is_invalidis 0, this fields indicates if Tags are to be considered clean or dirty.
    */
  extern function void set_tag_status(bit is_invalid, bit is_clean);

  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag fields corresponding to this line as string.
    */
  extern function string get_tag_str();

  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag status fields corresponding to this line as string.
    */
  extern function void get_tag_status(output bit is_invalid, output bit is_clean);

  // ---------------------------------------------------------------------------
  /**
    * Gets the poison filed corresponding to this line as string.
    */
  extern function string get_poison_str();
  
  // ---------------------------------------------------------------------------
  /**
    * Sets the data_check field corresponding to this line.
    * @param data_check data_check settings corresponding to the line.
    */
  extern function void set_data_check(bit data_check[]);

  // ---------------------------------------------------------------------------
  /**
    * Sets the data_check_passed field corresponding to this line.
    * @param data_check_passed data_check_passed settings corresponding to the line.
    */
  extern function void set_data_check_passed(bit data_check_passed[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check filed corresponding to this line.
    * @param data_check Data_check setting corresponding to this line.
    */
  extern function void get_data_check(output bit data_check[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check filed corresponding to this line as string.
    */
  extern function string get_data_check_str();

  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check_passed field corresponding to this line.
    * @param data_check_passed data_check_passed gettings corresponding to the line.
    */
  extern function void get_data_check_passed(output bit data_check_passed[]);

  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check_passed filed corresponding to this line as string.
    */
  extern function string get_data_check_passed_str();

  //--------------------------------------------------------------------------------
  /**
   * Sets the value of partial_cache_line_states_enable  flag for this line
   * @param partial_cache_line_states_enable setting for the cache line.
   */
  extern function void set_partial_cache_line_states_enable(bit partial_cache_line_states_enable);

  //--------------------------------------------------------------------------------
  /**
   * Returns the value of partial_cache_line_states_enable  flag for this line
   */
  extern function bit get_partial_cache_line_states_enable();
  
  // --------------------------------------------------------------------
  /** @endcond */

// =============================================================================
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7gQqOC4xVbidffvLDQtQY6EX2cYkXJYD2AfBr20dwPC8jyGaYG0td9VQ0nmlhxiv
AywdXeoWT1qii4ggNP6YjgmqDpcn0BiJikCGSCr4pylxTmLOQzc705PLLPxEQZg4
VcfO2FWdXcxNt0TQrYVa58FXc/rSRe5pQCGWgKDHzfO7YpHTqj+86g==
//pragma protect end_key_block
//pragma protect digest_block
w5iOu8xQ9aKYfbe36J2zlhIuV8U=
//pragma protect end_digest_block
//pragma protect data_block
GExBrmvyGN5IRwfPm91bI9Ouv/LDx6rIvHSd1O/+0Q22EN7CjiMGu8KiJOdKTR5L
F6DkrGQxIfY8vyiPaYQ0psGrLMBfHVriLeljo/iJWBCvYb3HCMXLjknpEo16903r
dq6JhyglA7h+ENUkv7TvdiOuLrtufkPnXGVLXESq4loqynelslAVoawvBSErMNF/
SHZnJTrqt6ipTC9ju4KnNT0eB9vvG5vM5JhoD9PhWEI+KwCgwqCbKRy4w4JemBXm
jGhMVryg/7PHe+DNd3bzw4k9Zx0PDLfeWPgBpgJoS4CTcxjq89HC3Of86eiaqKA0
z0Xb5ox7tmmlszP5/3kvT3xZoKaGjmF/REXUiuuOnYlfUJ5KBjgvGNaAt7V8qs2N
oT2D0BYDaxkf/K9NsWAefL/LqWESfRoVVGkZ32UHr8I+IliOe55e78dd5PjU96SO
fno/ekb4M33o02AA9ZX9D+Qvn7vXuVep4NqZp8TKTrPoG1OwKijQjTi42RMgS2XM
VJhzIG1hmPdETqGWhDQDg7ywEeo6Je1R9yiEi+FG8WflsVkQj9FSWUpxH3qgBhpn
TU6XSKvFetCCciN4x4C7mdr1/m7Zv3d7crTjWobEOGeJfCflD0dSElFxWkPMgoVf
/fCKBKaqRFFlCTJGz5MPRz3frEOg5gplSABQShykTK7WsbZMAxM/VerUhrWuus4d
zFHh4F8HK3XxNEj4AnitWmcMyGZp2eBGFdvyWZEyFQK3Bplyfk+n/CPCxqMBANSv
pmtOmMFOOaLDfCOsJea+Ex18EsGDZvsFC7kPNQkyD6nW25nDGCVxdNn0DzOQG7ri
ASWUxV4gW9DT714MQPaocEsdTwBhJm4pxACtJknsawbrjP8zh6jAtABbD2Bwgd7c
rlKCyhd/zy4Tu9ov06Qoip/ZDPsImgOjPyPzNdu9tBMthGoLeo6kELLl2HGlMetH
/TcJ2dpDuEv6itb9AwWkfAdudAUIDhECdr/S00Gzvoj1rB7TVbhIL6toYzai2JOW
vnCoorkFw6yHVPdxeRXgC2BaW0RRkUi7kQCehqwY+/udpA3D0QWNhPwoMir/g5Id
qNBaZ9LPUQvQuQB8oqdZudYZVmqg0KVcMF6Mfm02IDWEX9PnaUsF5okHGLJBeFCa
TSbfXoksY14paTy9+OJBhAS2UAeF7WT5oqxtWoj4QecSxxtU+15Eiqhgxzk0sDYJ
e8bs03Se9uc/EX+yC/EjBf43/lypH+5AEukaicPOVX58JMfBeIENuWUicRpywsfS
C08KynK2oEJh3RP9MDxQ45e7vOWqY0TQt42rV0rsKVVfOk9ZdRpMSHxSv80CsLR3
O0P+UOv9S11ZMzqjczEjew==
//pragma protect end_data_block
//pragma protect digest_block
IVcLEBUkZOd8RN5ZVrdGnZ4cH7U=
//pragma protect end_digest_block
//pragma protect end_protected
// ----------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PmH8O5rHh9BD6krRG0aORUWsjCs5hG0SKD9KQPWCZ28tYZNlWBJzL679ylKmN8gO
x5sDtdtu16GPoC4UeREQNFTKtKsq0cc6PhCpBY80oh+GvNl8NkdHRqJ3KHDxFsVq
ssV2+O/Wf5sL7c8TXOwYif17st9I4qIxLaQ5qoY4N+wSMYby6C2kag==
//pragma protect end_key_block
//pragma protect digest_block
cYG4roL5ouALEIfM5WLilXKG4aU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
zu2EVPBBzdDrtbNp8IO2oAig5ZU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_CACHE_LINE_SV
