
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q+PxVrEnxEVXG++J2fJySOut+5Wz6rzklFvfGcaaPTVuI6JWg88NYvyL/twmzsS4
+N/TrxclKgZsgSj+FxtAMmLlKhvDQFfV8ttMBn5omeyEkrw4tlPw35enlXpHYMgq
8xNpaEW62QEcJBofYZWmIARt8TMWMAlyRYF4NKHlJMk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 854       )
tTzfG71yVUZZy2YW1EdM6SooX15eTW+GltcFyoQZs32wx7ypmHFHLkkuaSba2M7n
w38lapELwlRsl04A8vVNFYK55J4Gz2aMmOddr+RmMOKJ0fiMOGBXlQDYu+NOzI9A
/EhCALIQHsr5f58GEnwzm/KI+S+zYqSrRJq5M2ZoNbFeHlVRqlBjZmGVIspoHeTs
JN5G7V/9IA2GHivM+RCQIVvqmDGWWmYAKHbvoAvXJVa+Tonaj1FxepcHQTnvongZ
wk7IsJSoMJw8tq+t7CgZk8xOawaJRY/g7oXDsnnHMc3ua9hAwzzgnEtnE+gpzXUp
+7xCagLC+FhEtf1+97WIz5Cw0iYdiglQxXJE7gT/hL8kiHR8vPPwGACjBKdCzifI
Yyz9l9nlrW/Q2FbsbaGkgzvyuqRddNngIdJDMnaJNWk731lpxT9SGrwj+MHjtd+W
vfHEy4/yrlScmW4bWltVqcKbhYgZ5EcTmGEhxYZVNeTwew7pI06lXZPeqIWios64
8YrO9pDxtvcxE6kvic+j0+auD+AXYtuH0894vmCSbrHiBjKw+mfc1Ybg4lQDv0AB
w2kXAvy9jdH5nK2OZ4ZZgJhBGWmaxMr0Mju6V1oTUtBmdN9DRcXxkA/J1gv6/RZ1
G13yY0lMI92mFd1sr1CjBNCk0UAmysqVg9DFGQ7ekvB0IbTmMQSIpFpkQ6OJN4sn
Fr2kgDts8ekLqzGtjc0BVNfurZOJ8NhvCKH7/fpDnPbRTMz6vRDoOaqUKSODm2da
Hi+KR6Q25kgMMpUZ3dhcpaWmxVklER66MlsSZgF3D9uS6m6i7s9Tz6/b/7fEoWLh
PAsQmSLgGJ4iiE3bmrecsUGYIFJ8Ad5FJo73cXio03vsQd/Q1pn5uEUPOw/wz9PW
s8Te4qYBhyesIKclmii54gXNTHl3UbHQoR55NsQQlXxpn3Qf9NoLx+tEuXdSfUER
3AT5bhSAuu2nIMJo8Y6CbgA+/UBIRpcCkT11RIEdqJtHJpI+23fzgzDMc/WugugE
eSLnoSzj7wfvFfbx3ey9XsVH3eNmOXJmd1SkWR3PS89fhofsfhuAaYt60VzP9OrD
3MPma9v9cVCAudH05H8rYxcI5rNq8os9QQdfVOwN5SYuVn5PNOv+ewa1cFkjkAiB
`pragma protect end_protected
// ----------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TWcwEJBB1mQQ4Z194I2Xsc+AkE7gaXOZd5P70c0RZg6LC97fgg5tT1we1mHMCDgT
ZCUJrYE/jWy0+1AfHUnyT+3w9H9OBxT2SC8XcW0gvLGKOPKvSOVWNfC7K6dwPbtJ
pljcUXfxs1c2jRqZMVXOOYcugvjMXenIstLz+S7HIAA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16240     )
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
jkdxIuZ3Xd8l3KPuevTG/voUvW4Uv0x0f5C9Z/xz9XocYQAwJo22FYineootB+Fe
RNQn39ZEY7iqxFxMuJvOf72IE9eS5/UkjhcC47zPD/SGno83xBQXzcUVrThVn5Be
mOjHc0oDFeR07iqzfnhfJO1ewuiedk1nOJVMsH3+23EJ9ZCfUTENeW/P9NtFjsHr
NeVHuoFvncn1lwsOiSjE6IdDdLtzteu1GMF2rpLSb/nP/ZH6b1Nut3rKKqt++ZQ9
ku1u1tf7YzzdLAsWbemht3ZNrIONDQ3yF7bWMK1ib12ieKkZiKXcU3tiuar+ZBZw
gG9/5NHdPwDmj36tBj1z9hZ/4hH7nfib/UjiL2N21PSlfrhEI8DS3R1niw+Pvxqs
104vobuqs+FA2lrTLaNfUZfeC4OqGL+DrCxJEU/tRox7BTc5JkSkDE4/rnSwtE2o
SU2ZnCgrXYZyHSdR1KqkQwPrCcGRznylMK8EGlSmgtD8IbdKYY1o7/CGiU9w2o3i
UG6dFXnjk5ZaIP0ioYbQQfAV6FeDIy090wAslilBSYrL7+8f4iisu6hYlOzt4+Yr
iNVTHQhCnKn7ljE6PEtL2DttEHIn7mTuLRy1hX9eTjwKlOo0gp3BAhkegQKe6ncZ
8MxGTfeonsmBTuH8H9xxWTJwaZDKsDbvAWkySuMs7mZtX3J1YhyTo2i60BzRb8nq
9lUxUIrDLoL7oYtFOxCBigcptNw7s5xGRLwgraZl0zmmI9c2Tw0Nffh+AcI9fIhk
XudA8nrLxFcZfLKvo0Kwyk199dy88sI8pEJimYNTsze026/2xrRzQdCyfCv17AcK
McQErek3pNIuIyUpuhUobUqPUngpF8orjXKGrLOB+MGTrwr5rBvNnSAWkLJ4RG9z
Yz5TWhfjlLbhjvXmuxmm22GZ1ajZsXZcYOGkNP4vtK2NyfPTGElprduiq4s16uV7
VvcojlSOKOkFJ6JkLJcUxEHL/04U/vWhvsCwvENrxInsasGr7iwIhSiiIAIOwnu1
1MzI4ayjEd31vPktVxAfSwrm2Tju18QnvBrgKE/0I0c=
`pragma protect end_protected

`endif // GUARD_SVT_AXI_CACHE_LINE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XkjwHlqBgku028RtLRdYT+LvlBrvQ33mXwlBcEBxr3DIUFAtqUeetLTdR/t62QEh
GNlaE8VxTjoIdn4u/g8l+LSaF8MSzu02+e7jXlScC3rRI6yJUwn3Wy6VtKA1zshC
lUkBUBTE6JHUk1g8LFHKJY3sevzvbBz6PVZ0nxEpROw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16323     )
t5FqN19UZC5JWmuLkR1ujGJo+1cEaN13EbJFVs3wnuyEdk5qxompf990NO8Exrju
+aocNpKy87Or4fQ4LICcvYLlWz52IAUrF897VaWOkTkygxaeqF5Fo/3IaLjSZzR8
`pragma protect end_protected
