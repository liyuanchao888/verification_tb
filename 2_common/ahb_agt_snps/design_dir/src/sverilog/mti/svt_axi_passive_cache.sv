
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KR1uCgnB3Ay3YazzwxnEoEoCYhsIeVtZTivuP4OY7R0A6BMve2S9oMsXMufc9oBi
MQcN+hLsLkrKT7/i1y3iyB5TwDgNtY0lezSeGmMcGPcKmLBiDuWnpxl+kbm3z75c
xq5VqPvtuH+HxkpK5zX3XecgyQZDTVjLz2DGM4eKPIs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2526      )
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
`pragma protect end_protected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FGyO0zkMglUpFfRmRv2m17U3B21Z1vyNM1nimcGHFWkCStS80GlitbIDcca5jAHQ
/VQJA3lD0NbyZddxUPN6qVxKnwlp8v+rhHgjWexisGXZEXnn+ORCs9qCSD9CqSl7
v3ItmhxCgM3YWE6W7lOTtw00zo1mi5FoWhpLOJPW6jc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2773      )
MedwBEDBUy5SGkUBouAAanc74r8QYLsXF1RL6L8jINl1LtIREf7DJ1nlSi0dVGZr
nHUsslNXU6DtAr86NLMr4Fz5qmxcHDIxm1kocItu2gESuYtMbM7xt4nzrv7SkUXV
wg8nkw+WVDWiMLmsgJLXBKfiAXsW5VsSRjQznoqtUGairDzka0J7u4t4e3YIobg3
fN5zQK/KcrpyuIFNgwUAg2AzoyIyRzwjNi0OfV4DFUFXZTtDGAPXcQrnf13kzN8G
FVZewQYbG7AxsrCDs/xLMWvuAbyoirGqlq4wSuVriHKH+Lj+SDhQgTzynt7ZW6mg
lLPm8A5HEjXEym/ZOO51eA==
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GSBQ6K32TBnKb6cB4ayBnYzsmwxuYruD//QoTm1r2k2Tq7sFSBrDR7s0HAT70kHB
6C/jxRcF9NAgioeFnQvvwnDqj3BAZ8MF22SvqJ7DaiW/mA+iqHB/d721995eMPnw
WWUa81YnMUiNXATxwUsl/45WuvU4dyrvxlCtmEgGMvw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4808      )
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Fr5rN5qEg6ESKut9MeIYapKJZpNYTUWAY7DIV1/kiZ9dNss0Frj2FYOqMl/4eu9d
JRROsPvBRQzNnMCESYjVI3rWv5iXbSJwofvQBz3AG+X68lVOSqK3sSGkfw6rbNgw
a0X3NlQZE5B6jvDbS2pY2Qi0piQsk8r0xaeaYUC921o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5024      )
uam+Dcez9BlQNxFsL/CVDEMZLBBYS8EunIOeUSPofPQ67P1ks0O3x3MNykICPNfT
HJHhICPUQ9X0K1zzFZunEDAv02ONq/wf4pnizak+zCw6YOcdJ4Ve8yRF9/zzauJM
/78LfLgWl3ZWEPk1MB7nctM+ZroSYqZaoVXSc/Eqpm3jJ8kZlJ3ghG13hYggGqIv
IyeYsBv+nUTIr0VtjK5LyJgJGB0FrGxT0Ait8zP9b121f8/9YTLUPxStWGn5ARhm
TEtACs+IQS9cwfRRT4VKWuL0ZLkMM+/U51zi/r2lwgo=
`pragma protect end_protected
    //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Tbpeq80U+twHJ9XnhfWeRfKbpydz0tKXkg8y0qJ4E9mTPKBpTFJ51WoORrldJI71
oUSD9TmuqDfwyxT2jekS6fU2C9YrAKVIrsh400GCTseVJjWMbJ/jWixoRwm7/0A9
f/Nenff43MZCksTasLGksDINpPE6aeR0sn5JQTNgFB8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5429      )
ox/AYbIDK8yOwebIpTU4wcYyRAW9h8V+cwIiwE46TRjJOacgTXb5T9FFORYpK8eU
RV1oMqpKmNri42tRGhLQkqjwpfhw6FuRT5swh2GiXcxHCWgDf7BOiYEB+r3hGkai
wsWgLPPAcUyKgYuhoOILuObJKtR2bCLJdlXm0PDXJTxKOcHOzo7+oCqC3V3pJE0J
rmKOsY5S17gIKeKUjTIpOqap5smGqbe1MpSJWQiAtZywGsREmlPRWmFry/aFALvQ
ZCwv3Cj0OUG7HxngRmTOQe6oj4z1xMdDrhVQAWvHsiGQhN7qrHo4HaolNt9JqLDD
I5Y5nXOWgXdeYpEi+aPl+FPL54kD4vzvqqUzJfqhNlKs6o5H6tShzweenjKyafoB
Plj/l1r/7nJlcXwxGIKuFnnakM+upok3Fv6jUkrYxLPfXn6OtcqspxprZy8txc/H
wK+A03ZTkWVfuGod5SZbsiPdvJHfzC7JItrZT98AsbPnsT6QU8dKLCwSM3Air6WN
Bll6K+K83+LyajNzhCSb8kLDgcVBoDd2rjkov6xr4EI=
`pragma protect end_protected

`elsif SVT_OVM_TECHNOLOGY
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RDHknvSXuUfKQb1f5R93zvFMPRqaagOTtQjVxIbmzBXk8f1ERs8BT4t4Mnn+J0X/
ZlH0CYbfj317E1VwmQ2by6OQlUWoq3i3JzsOMz5xKKcXMCFkzcm48sojVmMUVu8C
l2kx358nscwC8cz7KWeaOwyIySb9IqI2S7myKpALPpI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7897      )
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
`pragma protect end_protected

`else
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EHDM6zjsq66qNRsvkSvlL3avQ1TG1199M463OJcdm4XvvMUGZYMmi+Z/bvqhgBC5
8PWx8YbwHNQR1NoSEXMowG5Ltp6RYnZKhA6in4veM8v3bxhR16kaGvywb77VrCZR
waOH4EojssKZ67FoYA0AfUvqPtEf3X0eQDTVEEm3AoM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13126     )
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
`pragma protect end_protected
`endif

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eBJ9ZNP61ycB4lOGX6MBwJq7VMJjo73SkS7YKD6zmEdzqhgqi4z4sk/Kn6Tlne70
qtDuQBUKC0iwLJS4hq2+HTi6Lwxpng9TsLeJTncnS5FIJrN+aLhFi1xmxtazam+3
Ih+DFMrNALjszutFNHhaGIPOqLFf6jYh/mWgf+5i0II=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26468     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AXI_PASSIVE_CACHE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZYwDxceq2tOegJ2YZiMzAhOQgzf9G9ToW3FGeQd6JowU7ynVtP79jAQZ6RdHkTxE
qMpbl+pk3lImuS8AVE21AmxPw/aRapNHaW7AinLpnR2J5bWI6ZWJQ6Lw+rJi0qhd
PJV24FHwk2R1w5Mf69odwHN149jy8b21sZQRauJ84oU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26551     )
rSH3vrJ8dbJCXCR9NTCIXQw21Q8fz56yTjub/MWKb3Bi/pguTpxOldCpaznpqRu5
LqGJ02ofFK5M6/9hk0lJD8QuUbogfBFl7UamYI7m6peU91NafllCmx3VqH8cRQd1
`pragma protect end_protected
