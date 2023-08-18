
`ifndef GUARD_SVT_AXI_PASSIVE_CACHE_SV
`define GUARD_SVT_AXI_PASSIVE_CACHE_SV

`include "svt_axi_common_defines.svi"
typedef class svt_axi_passive_cache_line;

/** Add some customized logic to copy the actual memory elements */
`define SVT_AXI_PASSIVE_CACHE_SHORTHAND_CUST_COPY \
`ifdef SVT_UVM_TECHNOLOGY \
`elsif SVT_OVM_TECHNOLOGY \
`else \
  if (do_what == DO_COPY) begin \
    svt_axi_passive_cache_copy_hook(this.__vmm_rhs); \
  end \
`endif

/** Add some customized logic to compare the actual memory elements */
`define SVT_AXI_PASSIVE_CACHE_SHORTHAND_CUST_COMPARE \
`ifdef SVT_UVM_TECHNOLOGY \
`elsif SVT_OVM_TECHNOLOGY \
`else \
  if (do_what == DO_COMPARE) begin \
    if (!svt_axi_passive_cache_compare_hook(this.__vmm_rhs, this.__vmm_image)) begin \
      this.__vmm_status = 0; \
    end \
  end \
`endif

// ======================================================================
/**
 * This class is used to model a single cache. 
 *
 * Internally, the cache is modeled with a sparse array of svt_axi_passive_cache_line objects,
 * each of which represents a full cache line.
 */
class svt_axi_passive_cache extends `SVT_DATA_TYPE;

  /**
   * Convenience typedef for address properties
   */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr_t;
  
  /**
   * Convenience typedef for data properties
   */

`ifndef __SVDOC__
  typedef svt_axi_passive_cache_line::data_t data_t;
`else
  typedef bit [7:0] data_t;
`endif

  /**
    * Enum to represent the different cache structures
    * DIRECT_MAPPED: An entry corresponding to a main memory address
    * is stored in a cache line with a unique index. For example,
    * consider an 8 KB cache where the cache line size is 16 bytes
    * and there are 512 such lines. Then addresses 0, 8K, 16K, 24K etc
    * are always mapped to index 0 of the cache and so on.
    * FULLY_ASSOCIATIVE: In such a cache structure, a given main
    * memory address can be stored in a cache line with any index. 
    * TWO_WAY_ASSOCIATIVE: An entry corresponding to a main memory
    * address can be stored in any one of two cache line indices.
    * For example, consider an 8 KB cache where the cache line size
    * is 16 bytes and there are 512 such lines. These 512 lines are
    * divided into 256 sets with "2 ways" for each set. So any given
    * main memory address can be stored in only a unique set, but within
    * this set, it can be stored in one of the two ways. 
    * NOTE: Currently only FULLY_ASSOCIATIVE is supported 
    */
  typedef enum {
    FULLY_ASSOCIATIVE   = `SVT_CACHE_FULLY_ASSOCIATIVE,
    DIRECT_MAPPED       = `SVT_CACHE_DIRECT_MAPPED,
    TWO_WAY_ASSOCIATIVE = `SVT_CACHE_TWO_WAY_ASSOCIATIVE
  } cache_structure_enum;

  /** @cond PRIVATE */
  /** 
    * The minimum address in the shared region of memory
    * that the component where this cache resides in will access
    */ 
  addr_t shared_start_addr;

  /** 
    * The maximum address in the shared region of memory
    * that the component where this cache resides in will access
    */ 
  addr_t shared_end_addr;

  /** 
    * The width of each cache line in bits
    */
  int cache_line_size = 32;

  /**
    * The number of cache lines in this cache
    * The cache_line_width*num_cache_lines defaults to a 1 KB cache memory
    */
  int num_cache_lines = 256;

  /**
    * The structure of the cache
    */
  cache_structure_enum cache_structure = FULLY_ASSOCIATIVE;
  /** @endcond */

/** @cond PRIVATE */


  /**
   * Sparse array of svt_axi_passive_cache_line objects, used to model the physical
   * storage of this cache.
   *
   * The array is to be indexed only by an expression that evaluates to an 
   * address within the bounds of the maximum number of cache lines in the cache.
   */
  local svt_axi_passive_cache_line cache_lines [addr_t];

  /**
    * Array of addresses mapped to each index of the cache.
    * Whenever a cache line is updated, this is also updated to
    * reflect the updated contents and may be used by the various
    * cache access methods depending on the structure of the cache 
    */
  local addr_t addr_mapped_to_indices [int];

  /**
   * Sparse array used to store the number of reservations for 
   * addresses for which cache lines are reserved.
   *
   * The array is to be indexed only by an expression that evaluates to an 
   * address within the bounds of the maximum number of cache lines in the cache.
   */
  //local int reserved_cache_lines [addr_t];

  /**
    * Array of addresses mapped to a reserved index of the cache.
    */
  //local addr_t addr_mapped_to_reserved_indices [int];

  /** 
    * log_base_2 of cache_line_size used for aligning
    * addresses
    */
  local int log_base_2_cache_line_size = 2;

  /**
    * Semaphore to regulate cache access. Components using this
    * cache model can use this to first get the semaphore before
    * accessing the cache. This is useful when multiple processes
    * are accessing the same cache. 
    */
  semaphore cache_access_sema;

  /** holds last used cache line index */
  local int unsigned last_used_index;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log shared_log = new ( "svt_axi_passive_cache", "class" );
`endif
  
/** @endcond */

`ifdef SVT_UVM_TECHNOLOGY
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the cache is assigned an instance name, 
   * cache line size, number of cache lines, the cache structure and 
   * the minimum and maximum shared address.  
   *
   * @param name Intance name for this memory object
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param cache_line_size The width of each cache line in bits.
   * 
   * @param num_cache_lines The number of cache lines in this cache.
   * 
   * @param cache_structure The structure of this cache.
   * 
   * @param shared_start_addr The minimum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   * 
   * @param shared_end_addr The maximum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   */
  extern function new(string name = "svt_axi_passive_cache",
                      string suite_name = "",
                      int cache_line_size = 32,
                      int num_cache_lines = 256,
                      cache_structure_enum cache_structure = FULLY_ASSOCIATIVE,
                      addr_t shared_start_addr = 0, 
                      addr_t shared_end_addr = ((1<<`SVT_AXI_MAX_ADDR_WIDTH)-1));
`elsif SVT_OVM_TECHNOLOGY
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the cache is assigned an instance name, 
   * cache line size, number of cache lines, the cache structure and 
   * the minimum and maximum shared address.  
   *
   * @param name Intance name for this memory object
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param cache_line_size The width of each cache line in bits.
   * 
   * @param num_cache_lines The number of cache lines in this cache.
   * 
   * @param cache_structure The structure of this cache.
   * 
   * @param shared_start_addr The minimum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   * 
   * @param shared_end_addr The maximum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   */
  extern function new(string name = "axi_passive_cache",
                      string suite_name = "",
                      int cache_line_size = 32,
                      int num_cache_lines = 256,
                      cache_structure_enum cache_structure = FULLY_ASSOCIATIVE,
                      addr_t shared_start_addr = 0, 
                      addr_t shared_end_addr = ((1<<`SVT_AXI_MAX_ADDR_WIDTH)-1));
`else
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the cache is assigned an instance name, 
   * cache line size, number of cache lines, the cache structure and 
   * the minimum and maximum shared address.  
   *
   * @param log The log object.
   *
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param cache_line_size The width of each cache line in bits.
   * 
   * @param num_cache_lines The number of cache lines in this cache.
   * 
   * @param cache_structure The structure of this cache.
   * 
   * @param shared_start_addr The minimum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   * 
   * @param shared_end_addr The maximum address in the shared region of memory
   *        that will be accessed by the component where this cache resides in.
   */
`ifndef __SVDOC__
`svt_vmm_data_new(svt_axi_passive_cache)
`endif
   extern function new(vmm_log log = null,
                      string suite_name = "",
                      int cache_line_size = 32,
                      int num_cache_lines = 256,
                      cache_structure_enum cache_structure = FULLY_ASSOCIATIVE,
                      addr_t shared_start_addr = 0, 
                      addr_t shared_end_addr = ((1<<`SVT_AXI_MAX_ADDR_WIDTH)-1));
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_passive_cache)
    `SVT_AXI_PASSIVE_CACHE_SHORTHAND_CUST_COPY
    `SVT_AXI_PASSIVE_CACHE_SHORTHAND_CUST_COMPARE
  `svt_data_member_end(svt_axi_passive_cache)
`endif

  // ---------------------------------------------------------------------------
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the contents of the cache line at the given address.
   * If there is no entry corresponding to this address
   * returns 0, else it returns 1.
   *
   * @param addr The address associated with the cache line that needs
   * needs to be read. Please note that if the address specified is unaligned to
   * cache line size, an aligned address is computed internally, before doing
   * the operation.
   *
   * @param index Assigned with the index of the cache line associated
   * with the given address.
   *
   * @param data Assigned with the data stored in the cache line associated
   * with the given address.
   * 
   * @param age Assigned with the age of the cache line associated with
   * the given address 
   * 
   * @return If the read is successful, that is, if the given address 
   * has an associated entry in the cache 1 is returned, else returns 0. 
   */
  extern virtual function bit read_data(
                                        input addr_t addr, 
                                        output int index,
                                        output bit [7:0] data[],
                                        output svt_axi_passive_cache_line::passive_state_enum state,
                                        output longint age);

  // ---------------------------------------------------------------------------
  /**
   * Returns the contents of the cache line at the given address.
   * If there is no entry corresponding to this address
   * returns 0, else it returns 1.
   *
   * @param addr The address associated with the cache line that needs
   * needs to be read. Please note that if the address specified is unaligned to
   * cache line size, an aligned address is computed internally, before doing
   * the operation.
   *
   * @param index Assigned with the index of the cache line associated
   * with the given address.
   *
   * @param data Assigned with the data stored in the cache line associated
   * with the given address.
   * 
   * @param dirty_byte_flag Returns dirty flag associated with each byte in the
   * cache line associated with the given address. '1' indicates data byte is dirty
   * '0' indicates data byte id clean
   * 
   * @param age Assigned with the age of the cache line associated with
   * the given address 
   * 
   * @return If the read is successful, that is, if the given address 
   * has an associated entry in the cache 1 is returned, else returns 0. 
   */
  extern virtual function bit read(
                                   input addr_t addr, 
                                   output int    index,
                                   output data_t data[],
                                   output bit    dirty_byte_flag[],
                                   output svt_axi_passive_cache_line::passive_state_enum state,
                                   output longint age);
  // ---------------------------------------------------------------------------
  /**
   * Writes cache line information into a cache line.  If the index is a
   * positive value, the addr, data, status and age information is written in
   * the particular index. Any existing information will be overwritten. If the
   * value of index is passed as -1, the data will be written into any available
   * index based on the cache structure. If there is no available index, data is
   * not written and a failed status (-1) is returned.
   *
   * @param addr The main memory address to which the cache line is to be
   * associated. Please note that if the address specified is unaligned to cache
   * line size, an aligned address is computed internally, before doing the
   * operation. 
   * 
   * @param data The data to be written into this cache line. 
   *
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1 in a
   * given bit position enables the byte in the data corresponding to that bit
   * position.
   * 
   * @param age (Optional) The age to be stored in the cache line. If not passed, the
   * age information is not changed/updated. Typically, current simulation clock
   * cycle can be specified as the age.
   *
   * @return 1 if the write was successful, or 0 if it was not successful.
   */
   extern virtual function bit write(
                                     addr_t addr,
                                     data_t data[],
                                     bit byteen[],
                                     svt_axi_passive_cache_line::passive_state_enum cacheline_state=svt_axi_passive_cache_line::INVALID,
                                     longint age = -1
                                    );

   extern virtual function bit allocate_cacheline(
                                  addr_t addr,
                                  svt_axi_passive_cache_line::passive_state_enum cacheline_state,
                                  longint age = -1);
  // ---------------------------------------------------------------------------
  /**
   * Gets the index of a cache line corresponding to the given address
   * If there is no corresponding entry returns -1.
   *
   * @param addr The address whose index is required. 
   *
   * @return Returns the index corresponding to the given address. If
   * there is no such entry, returns -1.
   */
  extern virtual function int get_index_for_addr(
                                            input addr_t addr 
                              );
  // ---------------------------------------------------------------------------
  /**
    * Invalidates the cache line entry for a given addr. This method removes the
    * cache line from the cache for the given address.
    *
    * @param addr The address that needs to be invalidated.
    *
    * @return Returns 1 if the operation is successful, that is, if
    * there is a corresponding entry. Else, returns 0.
    */
  extern virtual function bit invalidate_addr(
                                addr_t addr 
                              );
   
  // ---------------------------------------------------------------------------
  /**
   * Updates the status of the cache line for the given address
   *
   * @param addr The address that needs to be updated.
   *
   * @param new_state Holds cache line state with which current state needs
   *                  to be updated.
   */
   extern virtual function bit update_status(
                                addr_t addr, 
                                svt_axi_passive_cache_line::passive_state_enum new_state
                           );
  // ---------------------------------------------------------------------------
  /**
   * Gets the status of the cache line for the given address
   *
   * @param addr The address whose status is required.
   *
   * @param state Holds cache line state with which current state needs
   *                  to be updated.
   */
   extern virtual function bit get_status(
                                addr_t addr, 
                                svt_axi_passive_cache_line::passive_state_enum state
                           );
  // ---------------------------------------------------------------------------
  /**
   * Updates the age of the cache line associated with the given address
   *
   * @param addr The address that needs to be updated.
   *
   * @param age  The age to which the associated cache line is to be updated.
   *
   * @return Returns 1 if the operation is successful, that is, there
   * is a corresponding entry in cache, otherwise returns 0.
   */
  extern virtual function bit update_age(
                                addr_t addr,
                                longint unsigned age
                              );
  // ---------------------------------------------------------------------------
  /**
   * Gets the age of the cache line associated with the given address
   *
   * @param addr The address whose age is required.
   *
   * @param age  Assigned with the age associated with the cache line of the address.
   *
   * @return Returns 1 if the operation is successful, that is, there
   * is a corresponding entry in cache, otherwise returns 0.
   */
  extern virtual function bit get_age(
                                addr_t addr, 
                                output longint unsigned age
                              );
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /**
    * Loads the cache based on the contents of the file.
    * Each line of the file represents a cache line.
    * Each line should have the following format:
    * <index> <addr> <data> <shared status> <clean status> <age> 
    *
    * @param filename The full path to the file.
    *
    * @return Returns 1 if the cache was successfully loaded, else returns 0.
    */
  extern virtual function bit load_cache(string filename);
  // ---------------------------------------------------------------------------
  /**
    * Dumps the contents of the into a file.
    * Each line of the file represents a cache line.
    * Each line has the following format:
    * <index> <addr> <data> <shared status> <clean status> <age> 
    *
    * @param filename The full path to the file into which the contents of the
    * cache are to be dumped.
    *
    * @return Returns 1 if the cache was successfully saved, else returns 0.
    */
  extern virtual function bit save_cache(string filename);
  /** @endcond */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Clears the contents of the cache.
   */
  extern virtual function void invalidate_all();

  // ---------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

  // ---------------------------------------------------------------------------
  /**
   * Returns the cacheline stored in the specified address. 
   * If there is no such cacheline a null is returned
   */
  extern virtual function svt_axi_passive_cache_line get_cache_line(addr_t addr);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM display routine to display the memory contents */
  extern virtual function void do_print(uvm_printer printer);

  /** Extend the UVM copy routine to compare the memory contents */
  extern virtual function void do_copy(uvm_object  rhs);

  /** Extend the UVM compare routine to compare the memory contents */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);

`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the OVM display routine to display the memory contents */
  extern virtual function void do_print(ovm_printer printer);

  /** Extend the OVM copy routine to compare the memory contents */
  extern virtual function void do_copy(ovm_object  rhs);

  /** Extend the OVM compare routine to compare the memory contents */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);

`else
  // ---------------------------------------------------------------------------
  /** Override the default VMM allocate implementation */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /** Enable the VMM compare hook method */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated 'copy'
   * routine.
   * 
   * @param to Destination class for teh copy operation
   */
  extern function void svt_axi_passive_cache_copy_hook(vmm_data to = null);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated
   * 'compare' routine.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   */
  extern virtual function bit svt_axi_passive_cache_compare_hook(vmm_data to, output string diff);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to format a display of the memory contents.
   *
   * @param prefix Prefix appended to the display
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

  /** Added to support the svt_shorthand_psdisplay method */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  /** Added t support the svt_shorthand_psdisplay_method*/
  extern virtual function svt_pattern allocate_pattern();
 
  /** @cond PRIVATE */
  /** Gets the address aligned to cache line size */
  extern function bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_aligned_addr(addr_t addr);
  /** @endcond */


// ======================================================================
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fJflkkiP1pDvH9hCDYU2pviUQw1Xiz6DWcPfX+kfKngYtvX5oPEIupRLqnHf86Tj
Ez8UKPdLqQn4UfWwsiwHAWdxg4gfR4fA/1M16Y2kzzMu4y+EmNn0rfmXmSMCxAln
aEgLwms0A8v5Z5ALYYFRrcu7Vj0xn1VSSUDaZnDxYUF+2DQ16oYO2w==
//pragma protect end_key_block
//pragma protect digest_block
WPydt0g1bXwFfvEephk+/BalyMU=
//pragma protect end_digest_block
//pragma protect data_block
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
GFgthMjZFOFKUKA/BTdUcg==
//pragma protect end_data_block
//pragma protect digest_block
POqntnLbPX7YW1EJ2CQ1T7yTrl4=
//pragma protect end_digest_block
//pragma protect end_protected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VLjR2hxTj7zeRzCgmpp83FzvRd+6otOPITtmY3DOc5AmTQxtN4mvJuQu0SQA03Z4
cNdkCc95EzjCW9ZJYyB3XXKKEhx964OS6IOL7nXx+lnPfq5pZ07vqsP5rvjRy8o2
JmTgIA5LUB8s5ttPJAqPYrRpxVMtG/BAAuAWa0Zkf90urqpGT2TIDw==
//pragma protect end_key_block
//pragma protect digest_block
NS43sFouzXVc5Tod8F9Ysoi4lE0=
//pragma protect end_digest_block
//pragma protect data_block
DWdsZSjkgvpwiBxbAmlMCzX0AJSsPbgI5XGuom8MbmXmdMiMCXOgQdEo0eK9OM93
+utyfpKNdmLKAMfSRmHMjMTAlndcjZ5ih5OeDStOmIvWeVhcFIdnOKLHEljXzv8L
ckdtwnNqWYFPq1JH8i62zXVo1BedOsFsHqJHLwB9hzSkdbbgKKx4eOJZ9egR1+la
1MGq8xj5hiilh+9a6hWtpRrU2rybtSJFG3ab4eoBMD3+nJ6mJMDQT7A/sXK0G5n6
J9Paf1zJWbcc3q2nhjsZ0tC/gMtqUrjvW/Ldwkj/WnmRcX/wsdXq3BV+em8tV8BF
+oalrriOQlrHtr4vhrg9D6UosDRUg7Lu/NRiCZa9NsKfDdtvpOXH/uL/bHZJnHmR
3X/Fgu3C0bIX/A2jinAuWxeA4q/GtYpDRxTP5m1MQtJA0JkU0EoWOrzNuw6ibkUr
KbJc+Jpr7LCpYgFq79hu7zJzxS9OUA/ZTvw/q0D64OXuR9Qcu6HScvv1wqZx0paS
gWQEYoikU6+aqiUcX8tttz1plKXSUTQXD7qaec/1+7s=
//pragma protect end_data_block
//pragma protect digest_block
FX+xalrw0p+69WBIsnZIFDcHIEM=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
iia3YIn0E7rsFTG57yMBuf+XYlzRea/GDOME/N5ap8Q8jxx5qqEx+Co5dCGFcDDj
4nch9WZlOfEmM3J4R4mm3NMdR2jpmhgnpHugFrizBcAzwHuarraQyWZHFe3Aej1e
vjJ1sXLph6RWmQwKXxYctCltTFEuXfXOxzqkXDYe+RgjwZyyDyQARw==
//pragma protect end_key_block
//pragma protect digest_block
DVYQVC/nXW+TxDgbO1oCYIrWRbE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
4oL+W+bsEkuwPOXVE1jMK3gsG+U=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WxJmWTMMcCGw571Hr2KbkTMTzOYEfSlrWwuwvmNkjCD5XKJloi1u39fUx+gfSSD0
utTrgS9JiX3kwY0LTqlZUKynLPgTNYrwuRlOcBgkQzEzlGZPA1g1KpifEdr835XX
5AzXhP4ZlILdAwr7ZkXKsau3LYrpLs6EDnlZOVsdF7UIsRuTYJcuZQ==
//pragma protect end_key_block
//pragma protect digest_block
iLFuJ3EeOtlfO3p+N1YWnJkwIDc=
//pragma protect end_digest_block
//pragma protect data_block
Er1TORvz0qQ1BXIaKo3bDgTGt1YJxdGwviiOdWCBSyhA0I/GTPcDoiHcKBZpXugd
Mo4gvSJitSwfn2uZJPN/DHyvhMWwkyp/0KYn/ZwMTqVySvOvUuOwZ7EespvirS/B
0QxBJDZN/txPyegpt0M8hiHYFI+FFWRvN5srmDM0QZuUgsXf17QdUHtICbgAT/5/
mccs56Sd4hMxoAO2SwqH6hTjfqTs2oC9SDF/O3EIShuyELmG9k9jSE+ZvwlE/JOf
EpXf/u4Y2Zzb9PUz/xp4UOIDKErOiFoMTzanwh6+S/CfxPe31uEg/D00R9h8b1gv
IJ61B23novKhqhCFoTaNZkS0sR9lGv17MYy81c62ByGLNrt8R6wHViRzPDnfVBoK
QHTLlOcKNCgjiJHgR1cnfkAyp9UhN3AL7TAVaXybKE3VGC9ObRZEj9c3agP1ufhc
pcozJDIQvVLk5CS8L+cfros8A7iWafz6Kyj06h3medejp5p+foRkU5kSniyy6BOA

//pragma protect end_data_block
//pragma protect digest_block
diN2eTd1hEou7wIULyYrwJMOdRM=
//pragma protect end_digest_block
//pragma protect end_protected
    //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
QqXi3Vzd8mFvFdv6l29W5+oL00VS0n287X73yk3aWRpREyMr0DISB9bfg3JQ7ku9
smS/cVNOGpsA/3aMCIiPOUbVb0SV5y3cnV+hgwI17C8BwRdppt1/IQOCfonmX2Fi
XuLaJLmfsiCcMBiiBy79fgswD3Y4K6Oi2JU/+w5+RQk/zAYsxHMUvQ==
//pragma protect end_key_block
//pragma protect digest_block
YHZR6ibhKnF9EG4YUVlDxowCTi4=
//pragma protect end_digest_block
//pragma protect data_block
/ckw8GwSG2AzDOPFMofhsR9iP/11Ixo6g8X8pV9043d0gk+zNkfTxzlGPY/XggAs
rxOceWsKThwMfM5BB+RIvb3ygL9cUp3JjP9MR4AJQ+tZT6CylQzTk2GV+0VAhjgS
Gq0do2JySY1gJmBGlYjrL3T8+HN21W3Q72W9y0kKm7KT2+sEdp48VyD/70PLw/Zd
mddifP0bVfJrGznoLtBcs100TDIxN3OgPjMHwdLvkVGoAnooC4O9sEPcfY5zz2Zg
7QYUgW/trr2qoVIYN8yfyWA9CyfwdaIS3e7mityISkX4uZTJ2pbDjlGzEW8yGwjR
bS1lNLmAmLk4O9QC47ldn5U+25ICImUtiqJoOtj3vLkO7XoVu34RgGhccvOPlcNo
kcNBPWxMUilRxP5Odq+JOcfnjKt1WygmlRst+LhS3JPVJ78YgsYTjwhvcaRx9Cu7
N+8qhedAg7uV0/1gIqhzYKQTSZSjLyooUUbtatgeY/cMQLZH1hZB1UQbdKH9P0tZ
xJxMqexTmxkmO51gEpSrDn+zc5egPXXuexY74l3N87HtuXlER+VGkLtb8BeUx2sO
/4JbUhW15ZcNNO+eJ+EFp1qd6M0BNQHO76S4bvU6TZdt5K7zPkoTOiaLPYR2/waW
g/jOWCKGcsn4AsBqiAxXFkP3Dw1WwqokcKWTwBB7A8FfNrj5TYaxR4/b+qbdazzs
omy/Uc0t09p3wZK/D+PC0qtDS+hYg+keJJ5rfXEL9dWBtY6mxyJrp7o/vYh9E4ty

//pragma protect end_data_block
//pragma protect digest_block
gMiSa6R6RlxEkrp6KdxZ4sJ74RM=
//pragma protect end_digest_block
//pragma protect end_protected

`elsif SVT_OVM_TECHNOLOGY
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
m5SKxEAGcVodny72tPzbsREr0wk2GXguP/eU3rwQvuFHApRcMJLMwcjyNpJ7TpZD
dhjYE19MqYiQWVsmipk1CQNItbDN9AYYnCvx9zVVPgzBlz/QXqcAZYO1AFuwwwzv
A26dJK+xgNRRg4t+n93WJexHKm9FEOXijSwtS3ArqZFWQ0fJ8QBqzA==
//pragma protect end_key_block
//pragma protect digest_block
3+gXXJEqoY5kRBNoGAgS5nN4wsM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
dOEoRjLwIgjPrbyT8X4H/u1KuHU=
//pragma protect end_digest_block
//pragma protect end_protected

`else
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tWUUvAQlnYBORwL6dxXjo5GWyYs16iVMPCn8d4hMr97sKD1oxCfnd5dEJuTEX5ZH
6UK21xr+J4ZPwaK0dVtvSfDD4CnjNylY19wxcXUChx+4nauxgMcayeqyHubhZ/sG
RtQI+UyNm9QA89DoaYCFTsFp6xEb7FW0tBA3ZGjC7YG+Y/mblTAXcg==
//pragma protect end_key_block
//pragma protect digest_block
zEUd0OhI5h1buNO0pP9DgPzXELw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
EWWrjjPtyEW6mXtE9AeqSFgtUIM=
//pragma protect end_digest_block
//pragma protect end_protected
`endif

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8nfm/tAzdoMc4kb76GI/8pv/061ib3rjS2IDR0aLRpe+Ua4Z3fdzuG+eO2Mv3ncm
JODow9yB7RRyrgb3bpopxObQNujfC9S2LpSboashimwkRvbzuKEbR0d0VITdC8bn
qdqN8gjhLfjpoMXbOxdlcYEk0uc5gpGazVZMszTMgY2RcwD+ElEhNw==
//pragma protect end_key_block
//pragma protect digest_block
HB04z5/UqUvcXUXqX2C60omq5z4=
//pragma protect end_digest_block
//pragma protect data_block
n8PE524wpknim8mBaV66EwaMnVl71BX+PQn5tCDPFSBjDfpd3jfnYzSrKkUKEUWa
JZ5y3FhyuU5Lgn9SMYvkiXCL8zHtQUR2c1mp76sm21L/icuoYtt7QNm4ua7DIkyr
Rr+UnvZr1Q+a+Zr7LmphWJNmTsJCL9tNBKtpwn4ND4ukrr9HZs/+hSdiIktghY6O
tfrhN3Upb6a1wrX/MqJiTxnrpemRlHUufGlz9MbaHct+Hv3gTnOKBJEnBAqe2uAQ
7NZPRneh23DziE0tleloifOekYdOzt3Sla6KwA0qy6/VnULBP6RXwdyIY4SqkGmX
KLDPIPk1sfeii9hi+TUfb8FvwJaKyfnNRTSeWykvqWq+BPTV90gjCAp/MVoalVXS
zvW2wmVyG4DWf6aJpu4F6tgBUHFe+zmtG/BDBrEeZRgSt0h4Wpl8OuQOZv8A5zr4
2vhzTUGg7wanvotEgAPrRnilM6v7EeMJsJKVmmP/wB21f5ebAeHw8tNtgISy3aOI
EwHmwCl9WhFAHvuuVF+LTSWSUrXY9dTFcdOlCk2XwgnzqbBZGt5so8gDwxnrGlmI
VvW74VaaWXjDkpHbJ89wh8JtGG7OZSq94hE3KqxAUWYM2d3OluTW2ov2GIY3AC9z
4z5Vhq/At7DR1sPNs+c7J2EuN6FjEUIvGcX8GAXjA7Luq6GemccfwJuge1HxLWfA
vvikouZ/5Xd+Su8DL4NoqwPrH8UYXWCtmtd5NG0QMcRvnM0Dg+73WSFSaOQKSv+c
t4PQgoCsrQZ5U5SOvlAGHDeEklkCbGppMEgtyQS7tnTJbRBJHTufaZRAqw4MhBo5
XNIx+1pY23rC6HCj0YnIdbj+VU45s9XBGCXtbylT09P/wL4EBxp0rWrOAasiBEWb
zT87VkPKO329WGXKTYRtQ/xM1pm0wJpYfXSGQL31i1N9xHbNypbJS2FTOPee0xlA
6ljfVQq9A797QhjB3LNWyrKu0vn+02xNFScRd3HW01/1Fp5PS5cbd8Ff9+PVNNAS
1Ruq5rES5VqEzXiTaB+kiPCK9l8KLNxrvQr4RWfA9bw9iBukuD2gl/qfOQT28k9J
4kSbqDjDeS0LdLjwJE9bqJOhfB4n0Y+nsR3eVGemslFJHwMaDw4v/RW3JgB5djjt
8B1bUG9xahTRVcBAmUOms0oH2hdOrdGalK7ljM4L/VuUievmH9U1V/speKpiFaVp
qNioW3eAydm15Pg98gjw+vyqkhix/rgyLERoc+LMWhrWmtIveoE9HdIJA9rUR8R6
XpKgZiKfAFGUYmkl3JAgB7le3T9AejjltO9C83YliP9IUh5sLzyKXH3CjltJG+g7
s6OeCcDZDokjcvZVlSypDPw6GBUnMPN345hYxf4buWmv/cwTtYLCeylZK285oXGq
nmkdsFQffmgsqfUdR/wKrzoTNRLKGV9eNSHl8JAWl7eI22oeNy9cI+e8nd66a5k5
Eo5qBmIatHY5K6yIj6FJ/W9Q7kNy141z6tn5kZX0X9hjueGr3hvPfAd7uyzpIPeJ
wU+wVNw60BSX+Rs7II9I4MoMNfMOMt16RaSyfouV3/ZS2ZA1q/b3ZdO4XMkdoB8h
06Tz3kOnvY2iQkBcXrGLYuaNndEwWPcUwK7rEF6i9dzNAU4QqgdMZES+RQpq+f1q
wpVYEsfQDf8HJYvF5DE3IRVtl2PUYu67X4tj3indF7eFc66nLmoRqzIPehbTjIDg
rlVKH6yubz80Atm6jpAt02MeLF5BNBlf6iL3zN1Y1JiDoMwDWgJDN3WqHUEK8Vh+
36EksdSu9JIgQ1bYkC478mCKCcvSm2gAdoBwRZPX6djFhJ5G86qxVvaorYyepz91
O87WsuDuZ4+WbN2JiIL3ZYizdvBP0lbEZF4viGNr++aFikEG47BQo6dr0RsyRK0y
Zj/qjMgD7gyiR7QOUC6CesG5BPMhG4mgfUqOsWAskjsIluqz2pM6ktX2C6P3XDrs
evXdhgVRPUO+cJhOH0/wWCSoMbm89tcqpBhz4Qohl+f6nES/F/Bmr/UGXMAlNoK+
JJ/zdYmuWqavwMyBi1BeKE6iwrJtHAHANNsXNJ4xENinukMJl5PG+nwcBVHrD1fM
UWLgxAFti50E3BgA346BSnwV+TUhjgc5mTGQw68RenuSCSzR6mxACv3thR1nlHeT
mqPOnP7AJFru+Lx2rKTsL9+LGm8rOeSqKTTugotTH+N/eYqWNZbEuAhIhuB7W7cw
kYoMrdI7PnocXjRoKWL/js8a7S0IZ1mwS1mb6zIT0kl6AfwKDwxz8ItjGFJ0X+oj
VumMbycl97twW9csylZ64ay1m7sjj7H7aSctStsLMag3zazFV2GxSXcsg+5f4Bbv
teD7Tilc38x4bfyTeiPblkE3owSUA9lmO4NLKejd+W1LjFqOQespN+TLMbSxowML
1ndJKAXsOx64aVGydfWCaMxnHIZ96uaLppjXYler6nsevFS0s7pH2zwhedD4ipcg
0F3J7435Ou8RMnJ7sUYdYWQGNj/FgeRZ9jd7vpAG+e+7ciSDfJY/Qv/OXq6aMWs4
HuFjeJuO+CZWnOIuysgGnT3AGI+lnCKhiXuh7TPmF1WduclEcpIgXqC8e6vDmLsS
cSMYdnpX7dRXVtrbmoyH2oRrY+lULy+abbZCZYHrenApNmbOeFRDsiJbq6BgxcP2
3+m1oDoC7HqZZRCnwrMaeftQKXP0ucqjc61m2sxHqbyNgLCDTaqo4Qq2erPsLscQ
Wvmm1NqT2I7TOHdYwkgiyd3nnRE+X0mVQ9wYFL3IsZ1Y8wt+nnANOiooYFlce5vV
QSXw7vF2L69xiJKulQIBUWcLvb+6NdOcAXeq+BrgZ/e+A7AuiZHIbNPk8BkyQ1sg
rBCMgeenUJQ71lFdyySfThoCJAQDg9lm77/n2H+1ljt61pnuDGqhDq4xe7Bu6rjp
TcpOPZBNkEaYktzl1rUAyAYQ2qIwUGTpoAWX3tUr91ZUATRwZsahE/+S/wYxXTow
95ZeISzw8hO2i4pluU9UKIvRAt0gmBvmUmdqowzri2dkW4sMFxwDGex0Q7sdyYyy
FTpElRCNyTAD0+Fs0IwbwlkIz/25GPplXpmiMHz/FNaaKZptgKWbp9aTgYx2vIhq
Yrv1Y5S9feliZGPFqBeooSXGVsCRUnAI7JM22OukbhB5NNKHX6MFuabbztCa8u3X
++15fUHs53JJzE9w2xHx0A+Zqt0FGejWzJrL3RXbmIEEJHXiHP6/xgM/f+NiD2NK
2SsE73AdLG/IxhoiuAefk0+02iwyCcDMpYWKiZcZr8VZ1j3J77/0cyJW0tGctnJs
JLSIYOHe52gv4UrJMcw5kwVay2SUDuTRcJgtN0n7ISmrr0U78WAvNo05lth4jQXg
uTyXSvIjCxF1++kcxI55fZ+kCza0vP3ffbsmlmUGpcqAq7IvUKRNkdoZVahWV/rh
pLTWJtWPbOcIurO2aUWWo5KjRnTjN3RIGoIfnZLw/9dxr50SxaxOD9sAfdjKbp1B
ERxIqD0sBtacH0NgMS7dU6z5JNUONu0saYQNx0ZBivMngH8LUbmhI6GfqfrnnIzP
Y0t6rDGZ3k1Cc6yeRPI7byac4cx2NTW2mfL6Ruvc8693ShsZkGigpCySJG8AoS44
n45UqGMQz9SIyQCmufBGvoOPWQNnBt/wyJBYT+/3AaLv9Pb2TpKOYXW2IZYw6HKp
LUOYp5k9nAM9tyKzFuB92f8suELdiXl8VnYeBRXZORQ/c75fROaRaFG5Q1NFYzRe
o4r9GLoRUhJ2Rc7/KeSymHi1W52dlZeumBFUvkDkAXz5/YV+l0GH1TKt2qqkPe44
H2IqBB8rPts4nC4c4DtdbFmIZTkvElQDkKFeUZKnHRBe6FDRHTMAhb7Vvn0b70XD
qkrsYwqNWl2x/HxqCwiD6Rj7ewbyEb35kLY/tex7J3Wl85cl1saNixSiYWL6aYw4
IiGMe423yK+WIyIaEEiHK9Q0kBnWhpP4OspPz+Jtq9izEGV2P1ketlh06JlePxwH
wwomVDSo0rEguEIdmlnSdS69qrpC2ZDGkihuEBDTPvsMB8DSDjqvxRreCn5uskJ2
giZfuUgmZ9rbUd5UXnqZRfhbkE2mMDXTMv+36IJCUwjKgCWUctHEwCVRyNBMjIIB
RySLsGS726WjfJc2tVNZo1zJjOahfU2cnOlzN5YD0OdCgNdpj3UlRkZyBwqh/oEf
f+rmScqRoYq7f4NhinyfWvYo36RJL5H0UTclqnM+tvLKPutBYwUiTzNqaW4+LXjR
H5N20xPAtZlWM90sFETvvevMIG1UVtP3nI8yBMLcPvsVjJey7EibazpRBa7beJRe
/Gmrc1EL2Z+l24dxsdWoCja2oy62m3ZmFIaWCHltHPMN1pVCr/IUHEuFV7ysDvn9
95mWuozx4F5Lgy6/1VUpt0wFV+FNcCaGE7e5tBL0TVVGLvCCgENgSXts9qCGZ+ek
+d/FQcqjRyQeA7yUZxwqHCxtDAPl1IwQcCI6KXguSV2Pmq4vItIh4w0H//pPqLFe
5oIuIAGKq01guLtnZhIaExsxNVG/lExOF0E0i3DKDKawPxOYc2FOJKNpCOHrk55g
G56J127EGegxqh1TkreLDmtOZ3SftDNn4FkzieT/gWJs8Pv3kP1DDt3w8ZUtmkPH
CtgOWIpqkZULIDKWrYwj3MhSwr5rmlgShWgFD+Zu1wnBPbNcVDjczT0gU5a7qlFx
oPR0II2Y+Ny2iKAbz3CNjF/b1uMj1BD41WTXAys7E6mDKM5/VhRWLETM6lngbFk6
QPcvpjpsJ6Ku4W1oaDzKtGwBtGLy2MYS7yNxFTv7HWcWJ/D73D495FGpQLrrGkWx
FuuXnZ5fbmjAEAldh5EdIeI+IpvE0xzzsDBaGY+d4sLgOucwqHITrscMLGvTJSOw
oKH64qWqHEIoNayUczk9ITVc6Ht7NYATrX4yHcGXiT7puni279P7EAddQhSboh7P
cWm4TSKQ1Wb+JK2bZmBZ3FtT42w8DdlHcjJcwysFMCW76IvVCfRZ72l+EI9he+kj
M9TQDqpeVpR9fYaP/DLS9TJfktZSf0cBfgs452qp97rQjtTioBRIB0hMIFKLb9X2
2vVcNwZ/4JOHKQyOzkSNDtiwyhQWzjSRLfj3Qo4MTGvSynbrxl10WVb/J44rymXB
Nsr/2L6gut5aHRqTHdsoVZPJsS9Rbzjps1f9nihemv+n2514IBRA3SaYJm/9K0Rv
9Wa8WV/ppFmomJSiS8z17nfE4iwBwyjGYmxso0OC+AdvP+zoCj03C/8152wtn9xy
/R1Dr+rXuK9EhxSmW0BLdfav98zHxrgloHqk9bMdY2mpQ9ydTRWm2dazCLpCV6Km
9UMYVQUkJGWneqcubDJhHPdhVDbsb9FLpPzyljmlBagnpG5OrlFHWwq2WV/JYeZv
DPcqjMfYFuoGE+ycj/OFAWJv5U9HR1AREKfc8X+pS69LttpTKVR+V4huqG5a3B+B
H8jYsv2MwUFpjJ++aqfn/aZ2fhlyqwxCQUZWHPeimb0LKr8cmrBFwYx/zaLNwtaD
0B5E9EgUjtFaddpsxG5Qtm3dBFQ7PTqoTPMAQTKxWxlhdi/2o0hnOawGbP2OM4oS
rD/KxctzgrXcbZE68t8JhvZCGcD9gFghtagTOwaBibItEueeY5eulEtuSgzslPcX
fi3l4peoVvOFz1ae8gze7pl5YOoqLPPEJ3alWwFbCzzYHgfAFWB6gQvKWJ4ehGHM
g5SXGrqfsc+7ZjWZDfpfUx4o0h3o1IW282xUXOYo+OKsJ5qlFqA4jyqbGDC2DjDV
bye53Q10KmfL/C9g8MwlSMmcuPCEmNrhWlDmg597A1csi45Mud//mK1UBPzJo46Q
qnuvTFqZKnFpHaKjDSqD0uiBPCnF646KXTtekt2IkC1S+26/FPWZw9y+45oxiv7H
VhlJszYXAesp3b+IsPUnbxR/ioBFrIsE9xHblrqQ3D6yW/UkcvmbW7l2vA3WziKh
MIn3tznuN11xgJbPok7+zDOLUQR6NA6IqJw0ZpNe+qCDnEiKr/DitgkPteeWhb8U
JMgnQGMzfMcS3sxGwG1rxpDppSOcuEGWoIDLhMWf7uKioGEKBnd1sUVFfksMfenA
OkSKJ/dsU8pIHMCrdeqaTSpnMztxMB4q6JQEunovIO5Ae7POFeyeA6QvPdoob1MI
fJFVSEQjwDVjpiVXYFciGRYVsqBRQ9fYw/D4d/GJ973nRT83WnH1KeMMHlVSnKH6
nxWxc7UlzGP1PAit2y0B/quxBd/BTMwdOZQ0TNgDiiz6Xfdu5kVL/D9mW0z0oNZk
4LIqiPpbev4WGr0KPyQU/7Gc2K/071GByLkVMCGKmmvwvDWRWu4QhXotVoPgHxgq
2MLvE620rYLqcydpCoxykl0yyEDboW8sgV+ftggA0e1ggnhEodGyzsC6MXkY+KpW
8g2/SosMNH5zcB5MKryvVJCY25e2GK2Vgbgjziw5H87Rr5uTgDko4eumQxxyhyJz
GDgPOacb60A38s1utyLBlxjoNKCtAZMQce2orHPLLL34kpn1uomFgXYK/RgonOiq
bAvMxr22H6XwmNX1lnH5YoIp7UubR1q/u1e4+XT9EDEObAglDZZVvmFHBgnRA6b2
YvP4B5VYWwoyNrpLwKxzU7+exM+h6TCrBertRLv0V+v3ej+g/pn1ypggHzDjIpI8
rXKG4N7lLcnYddgxrvwhmdFkp3Nt01qcpGY59TW/GyEGZyvs3Ly/AQfNay4tLVjf
lyRqn7u/fd8rcEZVnomWZSHRUgI+AB28cwWbAQwEf3UH+eyo6OZngY+ZWGFIRvN1
iVosAu8WpydOO0fOSzHM+r9A8gZ0jXpLsLZ/AUcCdHD262OVnAQig0AtzVUih4IF
IEpOPVE+rfoAyxgmHuLIqK39iv18Q+dMY3RHgwXWn5jsc4mjnX54ubeIWRn5s2fN
4heRHR42V1IbYolXgfUSgspEHDci3/1HQVvjlaoMBhv6td77zcNNhLzgBQ/mTPvt
UWLE3xA5TfR+ArS7/WWiTn6jEVMlRaxHILCJgXKoYEAKTVK4PQL7tnV/t/lS/Ua6
MsXSi3UH9mqbAjBmXesOKSuBxfBoyMPnqFnkvaBkNtDK4NdM+qioABRrmGP3NyDt
G5T0xEsEbIvB+JAvxk9FN8bQT6rHCEQYRSg+7x7V62vxYISyBVhmB8nYE+3Jp/gl
HUWsWXC3x5AnTgZFezOyXSpq79RvYyBoSoj/OzCwIY2yGOWV9DbhSLbJ+S8p4ooo
IK8hUJ86dcHJa6JrB8uoc5YQ6cEpUNTCmo20G56WEXs966jnkQkyGHhWYWR7Jpg7
vX6KqSYwkaO9MnkoxUNuxyks/33VPPnN373ow2nA3KgaPNvI2Dq73NpG82yKgJPA
/ZD9SGV3GlqZwRNHl3GH0zrzVqQIewMNFHLHLkiPiDk23norighFr/FLdL0jdo56
vJIjNkYnqw6nHwOdIncZTcq8TLBclpXLGctcOoHg5QobE1baeUp0Tnp3yif+rFbt
b2liZj43rL10eUTdYLDpPjUzMMJZ35yCzV/1jBcqK7kWXgXIbnPVNv16Ekju7aMD
qDtCiSlGD/aUMf+q6tyV18QZK/lKn2fHC2QYyl6yID2bbNQdEMGCGmtzb3lMsD0j
aLy3EkLS3TXK+58tWn8jbxx9ixkMowYcoKz4UhMfxAS80Id6s5DcsZ7JwzSFsX1x
URlO98hRUxoofRHzrUSE8ASZnikH57C156XoXx6tS+aGU16Wqy8A2PpS9x6xJBxn
YFqOzY+C9DE0m02PvM62z9atG0EIFguJ/gfmbFrRJZIePpzGjSDRmXE3sWK2AXMi
TgQqTqnQ8O568a0J/dVj+p9TFj98xYqHnLKF9L83BgFzynrYGxuW5UOWeu/q1lVd
ASxSmEf3uYaP4wCOJWfk6f+jcgMnkyWYbEsmtWZVpWTeqEJHtHCU2+D17yguYdK8
4YmtBNIvhKHCZ2ckM4H1nMemPg7OJXRuSHp4XV130IDuPAOyh2JJSmsPmdsha3xU
JPnrBNa7xNLFZPRrZy/FKbC/cSB75lx/Glu4zK/3xZe2Z2xlwZJSclDsjOV6QtAG
AiX0HRO+bnkIOkjQDrbuNg0uBOTGd1x6IYnLJoh9FHNxvw2G2HY3xxdhy8BMdYoL
t6gwrMBeJyo/K/on7SlINAWBalTrRrV253AanEQME9B9UacdzgsAs0IESzbAO9E6
QIYXd6NpScL4ayQ+m+AgooF+D1vdZBkUkWRKM+XFrODXXkE+A4hTQ/eN++WS63tf
/nbFfZXB+7tcbu/ChjzZhV0v5RukPJ+9zhyIOpP+SjRWwVMoJkIDxJNGUd+dtgHQ
iEMlXNYCOiwS4BeNUndo3dtPtSVCAmEYx6qDvvzh+tIzqxYMT5ct/Zyt0OOAbWjp
C7alEqMG+hbJ2bPIU+Lx69C1qxGw67Fx8v2DcrtlAb3SXcXtoKvRuKydENY4jU7B
dW7OV5HJr4Yv2ElLz3PJTHuRYONxf9/W9XNi9bDNflDLvnEUP/as6imw7mZdqBng
IRVPogNIaMIXp9Y3xDdNM6JnpvEb4BFu4TQ26+V3zr/8kBlxJvxyZCt0poumovj7
So3i3oMqmMwHrfkdpovfrdZ5Ln/pVeYBH7AUgUNphMaA4PtzIxpKMt8vMzJ7rrye
FBc8dM+WmOjoEQUBo+jARwHNH5GtqWZHgTOS+hCsEaYYKNIxyoA6fsbAQEF5FWSz
u2zVi3sY9cnqXUOP5Xg4d+yQtDmJPH3JY5JWueONKYDfYgbvuITxHU9w7a9QeTCj
xo0zOE/a8L94ZuC9bPR3fl2TiToKNrnzuBO4HtkZZOhEiUbaixdWaQNgbHK1h79K
GgW/moj+lsNSJGKMHmhdYA6MTYRcZOO2/beHTitGsydORS1wlB2yJ1tg8UQUtpJE
T+BV+WoYD3zQwH4M6MCWq65nYz8gp7BdlKQKAcHi3Ziz8dN+PaTqV+4uQHwePr1+
S4mhgcifhm1Otn7hFfdQbLmhKe0AA7zvQRCvkLIlfCn8vS+TdgQY/dazcPXHyvFr
WirXBPIEXrxdE9ZJr+F9q+aAkvY8YvOxGwoYb5R86fuKou+mrBb+vrVru7/zwRX4
W7isek6bU451q4BNmQEHHeUm7dj3rT44NHFa0maYXZSADyc2nayYXZGkvQzsOOQg
2Ugx0eCSI7V1V6afi/2ff3iG1Mn4+5/MMDwddjbBABTbNvsQ+mEuTJQV32sbMBt0
ZuV+Tm/wt01DilaynbvPejQdRaBMNUkkzTp1Emg8cwitRjO4zs0rjRsvqjmMSLPE
IWaNERf7hC8Cw3DxPcxMocF3mVyeZf4lYXoX+48/N5JPyyaooxO64wm+5wS3sTrN
yi6yfRiCw5ZNuX71M2rq0pucep4wTNm4C30e5O4Wv3jsJLAn01Hq4I14OT4THsCL
aQHZpiMHaQ0W7vFTcgHvLPEfliHhYLsX6ewLhLA9LWH0g+i8QopGH+fMT7SukY9O
9kA8p3CWsfgwX47vig6wuMJMLzkCVqDOwyNhGS1Iu5EuqKP/fVssiMtjQzG3aUl4
CxgKIh0+Gpukh2fXx+CkYpEpZTTO8xIFPjVO/d6k08NzFbHU751zFr/wh1yIAGQB
y29fJfarA5aagbaONKpH4X3H8+/7EvEUx8cbs7Ro5fEy7rrWGilswoxCA8CdMGPI
hck84WYsXu0v6SqyZslyPGZ84H9ZLqHfYzHmISvWvIBRgMK8s5RK8pmARmXKXJYR
bdZTCyzEQRTA1pm8gvUcF0Ma+4vD7qfuTmGoSctq4eq3UWwXS1a6lVZnqgoOnYUX
LgfhteD3RlZ2zVqO1+dJ4iK3Q3mTVN/i8NJkVKhMgxzr3/Zj4ve3dNwJm3z+sQJN
NERPT0rLXol6hcO81lTmIF0qCC4fri/mMJZV41th1KNhn6lR4MT8H6bQ9VDs1ltk
57h3l9EJ2+KmW7p50AUQv3mmHbHuQESVuyPFP0bp8wqPw7k45YiOOtJ1LBRj7r40
lAA9vMUu0mXpUz3861PkoMmcyidVnIijPq8On0PWLVSpPG4wrhhMUT+6zFnpNiav
fxIf5yqbQRTNeza77Bj6SzzAefbO1msaOzJ/YoyW2bGyxWUEtDE2vK1dhMSjHJnM
jP8Yebn309r9oXFGxeZDWCLasZu+0Ww6hieS/VjiPezYDIjEwW4QT32f9Jnt93BG
ntUVxrxFosVzEgqua1hQ+cJhyF/rh+8hyDAZwxd+ieCDctuHztUsDbQoR8FHJW89
/m+pgPrHzXGfn0j+yPSIZoE2xv3OG4t9d7qFaZPrX97RKHeCHOdKEDG5KbGC7euu
ZZSQFuBya6tSm6AG7J8exyrlkeQB4mWKmnLkSpqVz2oa72UAeqLiOCdKQVgaZOmp
ryDXlZmV8J5KJ5W+tL0PeSreqZ6bwo4tDczuW425aY5qKBUnqcKcPSMOpZLKjKDz
QY/tz6QjParcaR+trqVsK1nuN/KWg6y7MeU9FYfrfBioyL8II15qQHPMWhYCfQQQ
4kOYaBOS10QH/VVVwNGOKpDlZRDJEJ+8atBLeeD0s6MyhBbRoB3tr8pvPFPDz5S7
pDDcgBuGRDVbiw8rE5QoYgVxV8ZdTtVZCQrf0I8TJqWm4MgM/x60tKEpcSdfMg17
NCb100cPdh54zwb7upr29JDsIE5zDb/JQD2bQJ/qIVitIqqdtCyP7oX3SUS3g8U1
nwoIP2ezdmqCk+/EHF4RJlNyK4reuRNUstvb99Lwj75Mk/INh69QdxmPNCH21Z0q
bQKMnQ1uxrNRl0iHeiFizF86yc5l/WWTk2llxgRrT9w109mKSfpwm7m15HcHLqB+
+Wg/+dayPl6IrpkuNbNdtZ3N9pPH9ORq16e6FnniWKm3PSvFeWGD/gx872a2L6FM
PEQyhr1WYDeVygeswf2siZYBlnApXlcSVMvJBllT8Op+k8jIlmrJ1gJNz1S4lHki
C1nasmJcycIB9yvT4LgqyFdep6RjHtIZzgiEI9aqHoVI1PTG7qILuM+ZSGMBJ5yR
flgDzrbiUF4NoSRNUKKqk6qLi1K5XNAoeJOqgTmkxg8BXBjEGn1r7tbtp4bL7axK
jo4ju06M+CHru8pmpGrbicCizZI5LTIQsi4+mEgrW3dD5GHxfbAHFUbH7c/W1Xow
ZDk4bsqNYod/YdiS3AZwJcxoE3+1g+uAhtZRJknyi8tNFCS66CqyB8H0OesBSgBE
8MoPQdMhbKeayvHgW219T7NHel1krqsbY4giiQ4YxP+D+zAMgXEXFbtflAa5rlDh
e4yiWKlJujoUDwZ4zsNCi2t/UThybqoKIrDgdOvwJIg04pE4ciIEvNNZ3vioA5UK
iJjhZo0o5lwnwRu2PL+M4nFOPrhmXzCPH6LzBzpQcjH/gkEV9siUcUU5WzFcCZ40
d28Cm9X3n7paN3hKP6XRasj8ZtRGI5eXyrfqnOW+Owi/XDL1lEieYYCRmoE46KQ1
rZjTWyvimYgOaiUR9QUQp0gUd7aiUg3Q/ewERitCcrSbK4F2xUOgtSF797G+noFQ
Y7Kw9G7zpUKOUxEaMxf4Tksn7A+AijH4l3s2iXiFWg8zyFzMPf1n83noMgm1i8kN
EZjtFrhPO59BbkQfI2fupC1knEllcD5RwHQtdLoF1F1GJDy6vXs0zsiv4wICE25N
0trzarhoeSOEIVDtAgSqelX4RNZDin/fqaLEagWSquRkZ+/r12BWcKz7WJ1+VI7G
VIXpvd3f3w6q1ARzVqanMR03vvGPfkD9Ol21UsnPPufNfjEtEORSJwrRgVdN78EJ
ic0Hk/+i009bvJHxACUKcktHUqAs3OIhh2flAFlgzOWcDy+8Z4dmGfJr/RTqLYmy
poq7hhB3KtQ+3WNi8EBsGVHDM4KDlhyTELbLGUVyCi1GV+/3K045+n22IGsJn1Un
qJYqQQmJ2kaZRMQBU1lmDGYVrMZ5kYpYtuOtbdkuEkjMchY6v6iwURlXeODS/6BW
ztvbSdJLgnfbVs9iNUImDnu9fEgVOwPdQWJ2ST3qQjOGnfHZmUDXbeUNISTYIKAk
7wS/MLIHUAZTy9/rM0CIUNsBtI+svZA08C23FfuJnXWH2lNNuxoV+14hMbdFALs9
FOPgvAx3hq3HxYAe7m6vemuuBXymadoP13cHiGNyBB+eRXh1AEczt5HcPGYsYucr
bW3wYzrJktkZwrFwSz7mRdC3bE7Rfo3jgE7RzhGjoHaPtLlv7TEJOXvsjBcMXdsU
cKNpK9pjbD8h4LiHro8xeJETNn+s3ml+goTahS+bkeAEEHzOKf8j0qIepa5mh0d4
7lBUB1qoBUpZpBNbxISgxM9Zsnb792oezlr+/+0reDu6L+mOhshUdKuaqbhMG6IU
BlM8JhmIXCZv2Y2RY961iXCf7m+V8/GK3eQ6rDXIn5dd+TuH69JtTXHnaEqKKKrZ
jm50zuOR60CFiFdpB9QYqfIh3/tW4cPu/b+ZGR57wqeF+zLL3ePct8IplsnmbFRo
/4NpXipBHW4kvnWJb5FpLdoijqogNwyDxo5WCOIC2IbxK1UuMVn+iOCLZALl/o3c
KLtS8CacTM3UTz8HhI35s9/JL3+iU0xsrXkXPvsSq/1w59AT+uRvm22TbZGfJ1ko
UsMkdmBlsxtcj2QMA0dVzebVlhj055RSWCJmIlg84CvaNmaMCxg918MnFIR1Az/C
4x4jZn5mXsmooVMQXIWMwR5jlDXb8KRWgA3q6o7FnDnKzpOiByZCC5k1YP6+5g1W
g2PVsIije+P9RA4jO+8N6hWoa148y26UbmETjwdSHAtZVOv58zE12/VJlS2vgni/
+8DWrxE8yFO3zoC9sbnvC0HuL/lvqVEE6WSp0ex8sBeMhXl5tMsxBt1q3asexX8z
HViXdTCuLbUUiHrVkl1r+yKp+7DoSAxJT7A+teuL2mMFuCTmTsmjtRRrs32tXyPa
Rv+wV9Uz1BlIFa87wJw7KiGK4FNOfSgoCLIps5x/h3nWHYefgkKZtpSJ41fWGL7N
ncvKK6xzxTUkM5dIHczQI6wwBt0fioVKIeBXbkBGv3MFQ0/VC9vPYdZi2wrBCdcC
oJWCWB7vhUByTESaTFXlP1lr9Jy9lmaedCZRi955OLX/j0B1ATb+xtYPg7x1EtqT
zG+v1mZ2BmaVBGOWVsE4PBwsz19MeJEOqKErAbO5TFg3c6wY9LXLjlvD+GBaJ+/1
JD1BjC9Xg/h/5TL+iuJl/xpHh1AAfnlXY6nzjOMXAqIKvFzdAx/xi7c6h+hc3SYB
qVD25WcW37t++9LXgJ5M9/fiTORyue3MfycaBj3f1RA3kU7FboWcAiqgpE/S4AFO
EO5hJmt/u9+kTtf6jKpDawm/iFmtlulojOvUxCAJlZLXduT2tPy444u4yS3Fypws
jaWnRTLWIGc6OTQgSY3icCA2BVoUISvMbiWT4SVS4cNlPYTDYTNfRjuYK2KEGzhy
SvnJMPcJaiG/FDJEPlGnDzIj0nQWxOE7CCGivFZYS/083S8sjUjL8ybT/wKLJr9p
REn5Kb/pkTFen4Vqz06gqTGPXWsgkmknRJ6SCEAZJc12tYqtVSSTdTaCJEIfM74S
039aSP2F7xWVm1xSQXG3NY33MvVKEmQ/rYFyZsCYoU6lpsPT+p7ZuKGp2sc7dWQH
dIwE25sSbUU3xKDvY8rwIc+WRGcZbgLPfq7IdvnHS1aPANSh4Nom+s4G5gszunq4
9ANYZDDf30NLZjEoRJKksrN+z7/gQa1LJ0gcZDJrRhVPuYjKRR+LbaffY09bPy9+
yq3k16u6xziao+X4R5Vql/gbfgjkxS3KQmO2Ku/nfKb7rELwh5JxnT9z9NJIWPlk
TCmzXc43Xq5bGe9aVsh+9cmVM+zP16F08Feg7kDyYGbyW4GTyQX5d2qDONLg4U4+
0LwVVe4QFK9JeBsxjoMP3ydHDezrWJADg4OGSvpsQ2bYpR1cstIdruR1du6uNuV/
RaB4xXmGCvylcvYZ1XtjzEr7rzVVpC8JLfAUtL6rSI8hgeTj3BdSBjwuMec/FzmK
TJy+VqtOb8Jnuch5trOWD8cMZFUYnsYnIdvG7Sc0vI+GQSl+z1x2PMgupnM2/yDJ
D2Pfhun1rsLMjN7+IMK8hb6cL+3ZevoqW/F+kNvvKhapaZcWYz3RWSb+pxe72kYx
6lWT1wWhnZNkGeRcO5LrLVdYyfNHqZJLC7V71VkxSVvwCFqVC02wvsFWjACdS9vO
bG/OhN/8DlLnHQpBj5tZ9fFV3Pze0dXjCulC0uadMuEwrXtIQiIQSx1pJco5cX83
gbeErfMFpF4HGAPElyzWbvK2ebn2YrzOasw/Re6MfeD2BtNa603t4w+2OCkYKpmK
6F7FP48rzCwPJXqBThLgKp50iyiNVZ8jL0XpoGoFGYsO+NEzgVTIN8zDw7MNFbJt
5i93DXQYJLSwcQLLr9hPaj2eurpmqaqz+F1v8Weg4sB/DMeUKozVXHZC6Cx3K6CS
B8Ypc5laktb5xiFDa+wfEseyg8jU6FuEoaJO7Ov0BK0F7RUqTM4lWKPTSQY/8YxV
tjfvAyc83yWXWczD5ix2bztcvnHfhl1Lc5HYKqh72ZopWLUcLiX1dfUj1lFqsaTL
UA4mVbI27E4bWr9C9LR9N1KdhO6F8IXWMJ/LfEhKFSQ74g8kjRzJntzk/WJhxW3y
2Vuc2WqCWd+dqZhS89cjp5L1HIWe9fDdTfKT/NHGpqnqWKH5mhlHWj7iG74w2aHJ
O3mPDJC2g82vVIgUukjdRKkjj5ZuLGZ3I29uDCfx2kwacVKo4zrGWYrX9Ukug72p
qMGud93kb40tL7F/ZSr5aVxA0KbPXWLWEGKDv2tH0oosvVu3JlSXqa0F3guocIo4
JMXvfBtoOcMiNB8giKT2+eGv3VDigQqtlJk2lEjq/3jY53ECOhHKB6TIDQr0r3vo
fNXtLSr3r69CpH6S1MB884Z5E1XfSYGDedk00q1IQ/v+LtLzMqyI8/pjWLp3XLS0
WQt79wUJVTb/OYaLH1VZBgeh6eiyNfvA4ElRqpg13JDKFLZpnPltlK+6D+lPbWXG
pCrjY26BAoOvA7mRf04tLJLpQy8ntxlQQPpGLgGrO8sh+oZBKSPfIftOyyhlLbQI
IxQm9Aemokhajs6k6CvnjrOF3tmMg00dljdc7XifRTnefam9jGhhXshFSeRQB+Mt
5zniXSwAKM/9zC5LdpKsPbSbtUWg5Qab6G5dHBT619WguqKQ3c7so9Nis+r3aDmT
jlj7DsgrnbjPbPPy/yVTLRudVIZl6U3cKvqFPdbma8KQMhBRGKpNJSO32+hOK+ND
89z8yJSEodlRHASNEMJXCQSegqQZfW4xQ9/UlhHovRdZ5syXm2eBDyHclW7fQNzB
dn71VylbUb7p7kKTmsABAAAtjiSYyM7Dwh079gdq7lQSsfydjUzIgbi7Sm3/4IFO
5rGZ4tpdjU5E5LutibsX5JNJ6bAybWGGLV2a1pV31cpWLYNd0CxXhet1a7QSuXqw
sJUdt7eoFQU9KDmUobTqzSy6wA4BT28fTuUzH9jbkpNwuHePTIrugESu7rUC2tw0
7g4SiIqEill+T5SY76vBF3jzMVdR3N5L+89TXMmUNHC15lr5ijmRDVZg+CelI4ll
+j/dCJQxPglyMZTKTLCTDjtGJn4j6OqC0P6KzQ6OiiAGpibJWD1pnGhVrBtGXvHw
Ygm4FzpQXwUteh3yclIRJ2tN+pdhSd7zvHluDMso3VmKnhH7jiPvO9aBZe4Cl8Bw
lMpE3Z2a7Bo8xmiQqz0zoMNeLnu5uPbDepmItj8AeCQxrME4M7P7l2rm4RISqNP8
Va/9Mlyj1lU7OGWI3qVd2IDMC7Ndf+JjGbsymOAHzysaJIFO9D+BfxsZrax0cDss
4UN+tWiGsXFk78teTZiGkuNwtdqhrKbYjcDTNBdIYUkHHW+MVY9pqaqL+vKKDMi/
c0+8dLMv8pCEkAKl+c6r+TOfyuUb+2O14T9/xXLrLHeHSQnSG8yiy3sUowFF9140
EYMaoo+L04bqgBkM46mpIH/0xbi2kdIGPya9IonAGA9xeB3oo8zO4IbvliBMzDUR
2dH8NUF+RUIxguRcKLsJ3Qbt8Ks/tlhXGp9JAB7KCoNP5F3BS8rTohRF1EZqorej
aXvy8YTHgy6NkJxh5hQySVr6NwZ5RS/+fO4rnMqr73U+YuPvS1uEIWQ+Pr6BFIge
PsaeS3Ogh/kcWEsLUBmw6C4yCH2Yf9FJB6Wqff8zPLETp7myMDwsx7g4cgJQiPrC
WB63KDsJd1ceOZ1rJunP0W9v3Mrc/+ujrcXr/ZYeZ2AY4HxI3n+N5sjBajGfdkkm
JncqAOijudljBqKi3V7nAefPvDDBafaiXzyJJ+C2ngwmJ6PJs3FaXZgyyPPNolxZ
a34/Dvb6gcEM4pr3DGC0MAQMAcwQxHOEqpm2HH41vr5RSdKsRBs5zujfM3tOwAtv
8RlJD63z+gZKWvMrX8hg4pqfR0zI3suhq2tlP7V7/H+noFKa3W7js0MGfVL2IY/V
0corTvTB3hv3OcBighSkx6Lfv6IB1ukA+vdJvkn6U00Bj0BFNBB1kgFMXo9KIq0p
pcuTiqNtrcWpzYi1c1haa3DsSyLxj99AKMTsNbSjmbyCRAiEpRBUrPiPN9xmLpDl
H4ZRAPYlf3CSPCwTmi8C96JhQEwWAFQ9QN/8MQYuoFBJMzqibR9ikxwnCqdpZCPo
ss5TYUsjH/0b4lJnDXEkCP5SY/tgwc/cSmqsaCeShwqhbKSQsPuweMPPdVeY1ZUh
pv6mQl/WpD5Rmb7cbe3zpb88NZPGhSfKZoUVtxVuFUgiA4qsqkAtz7Qnd0ZkK95c
ezX89GxbkrnqPKwlZbcb8NDncXvRBgfQJpueXJS2vJpO/rJ9q4sHh7VlEtTbwqaT
Sc2rebjrVZ8alsHBN238+ofxjhyuqgnkrLnpkm7BPiVZMxo5+ziUubI9VPyHJI1/
ue3ODhvq/VCCoVBxfM1oHMaGiUs+vPxXqsZ7QWCWVjGFr/GKfDXGyxlrIyvPvHZV
yZQsib1lkuFTl19gSKKd7jPPYcf0UuMAi43Ve653a1y048z9lJ0h4l+QFxXZr6ZW
EgXtUKwqPvlxcwe69uJkMu0L6VvzSKMGJU+zfDgeI9w6xyKRj9wuanU4n9fx9GO9
SvDfaO9ul2dHUItT9C/wjz2RDjVVch66Fk2Fxbj/v8IonJB2YUcVo1rZMpJTN4gE
7qFrc4XaY3otBM8lNyyADeKoUwCJXDEls0q+IV8lxwd1SqwFiKHXxqvpbKAqruIG
/U56DAbxqq3UaLYssoSpCAjaSBB/eE4zdNt6I02myv4Ugw8i/CxS0ZZxz7ML1vfd
ICL3ydPYI09GowdhAB/RIBwujk3NpNdg9o8xWt8BcrkT3+ypfq711rpO/uOQWVdt
jlr+IxGAIn7Au1Sk7WJ/PBuh8ojkYh4ZEIsRuRaLXwWf+bPAJOeSkIAPwjZgl2lK
vsjZPolspE+hEPsm8SFnZyS3QrnZZQFQsY0uu5zp7BDV8PxsmiCpKomGwo7WwRB0
DDRBk7HFhdQGJ6WPicboeT+/BJcJ/sYjOPwIbNyjeGvs+5MEbvLhyfAwYXyAU9fI
PpSOkT9VaCrDpdwlR55DxW8aRZ8uNoEKoV0FBhVUgkx5kdyNZhKdFQmR6fFeOiiz
N5qcJ1btlGfGJ+xd8sDnSFQSjnvxVlcPScT2cYarQiYPiEUjMvGzYzvMtjbB8TCp
dm6qPPhwBEttXyb7Sht6bYs4vA7h+5pM9pYi0DQqGHm5fbAsVTro9k9r6PVlqSlX
3+CoPSKyWGhy1WkzyTExf7w1SoH490uvRWBZPOzulOQB3mhPuRWYxWT9t8l03kr7
TgxaDlmo4+9Y3AdA0HwdbfsKLay2aVAL2t/VdbQmbTACBsF07IwIntj6aFPVsrQR
b8JKxZCI5faP1aeouwfeJLIUn6pq+OyzIiR/injFID0=
//pragma protect end_data_block
//pragma protect digest_block
l392h6KBNkqMQoUbfaViP/GAVJE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_PASSIVE_CACHE_SV
