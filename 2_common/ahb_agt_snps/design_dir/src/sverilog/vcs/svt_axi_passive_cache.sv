
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

`protected
0J&U^ZP\FCb)44?>MX&B34R\P\E/\C.U6&O>D.M@^9/APa+PeU8[()YbW>Hb<WTM
?BYVfeW[<&>+BTb0=B+;XN12]eFLf9IgOdE[eHKBZS;21H^;?<+3G.cS+VANcc\L
M,N)(gM22-UN8bKT<)FTB;8b?JSgU=(-V#N^C>+:Y)FQ9\DMWb1MHKS3g9WC5>Ga
D[S9IID+EW;R8d@4HPIZ?&c[TEQW>N>W)22ca9[g8F.6J>^11[1JIcaXP3U&S8GI
;R^V[cdL?QDN(8gY7CX7>cbaJO0W2K.aIYKPX,8Q#e\g(-ZMH?4/2OG0H2R1B7-8
f)@_0]d;#M+BKbYP4W9Vd>M-NI7DNYB/_&?aIdZ-cQR:==F:V(&TU9bST6EY68[1
Q5\fJ6/;?eJ/QIKDG4QIHKDX7U?1@#IE/)(b\A^[c+=A144(STc\6_,\Y&6/4@ZI
K^fDJWP:R5:aL;/B1?OJXUX<FFC@#P@F;2ePL.M3R3RR_fWKS[eB@3.OS#X\K7_U
,AG?<Q,61+<_1SNI8IKRB^YcM;f\/16X^NYLdDd1&EZJ,+N;=TH;S1=IHg/,UN8a
/F)bZS(]/&&/(13I=?5;H\gIP@V7I)Ne&<T(XK>HfZQ]@JW(<T&NKbZ\3GIgA04S
=\fcARB/Xb,=f4+<P>H@N2VGULBGCa-XXL(WWb;=J\HTAGcW^1gb/a[XO_Y_2GWG
Ga]5]#c)GXX)LIONffJWZeXZ>WZN7O,g5gcH0cJMVJY,F)=C0.?g2>d&P#<7E@1(
,9EeNMP85\6^DQLF5XeYVe_\500bN&>A+&SF5TWSR&..+S?N(aB8CTFH0]<07Sd>
PCa8E5fS3VWZR_a8]Ka8]5O0XVTN4B-L\QR64TfDE:6cH14Q>&BTV46&2gWY@._S
Xg&@P,(9]A+\W_2LPRaS5WdAE54?D&^Z.4Ga#@Yg0Z]UZZR(UPB29<YLG1c0dNaL
MX&gL\;dBR5#AD(3Xb0b/BC^a.P4SZV:B3G_d.5]S,(,L]3GSd;IW(8)4N66G>KX
^_#VI)VQS^2#c,QOB^c[U\>VNN@G6C(d5=W7d]BG1_eABQN>68eS#^E_C+J/]@03
F>85B/:C?QNfGMD?D&990)UNX,H80\XIEEOc\-OBFWU94@V=Y&LDXD30586MC\0P
)]aT\N=221WF^Rd9BaR:;?XKeQ_)Ne#(8c1d71TA3]AYTd;0RY>2bL&2O;4PQMF+
J1a.>#PBBPdVECHGDe)R&1>?:HbUJ\I/6G8KB\\NT_LTZEaaYT<?Y2ZG7&&ETYU5
A#I+g-JD8XJKW?b(O#LOM/P1G5?+&)3H+/2XQF)DOJ5VIaMdY5.KI4UW]bCDQL6@
Jg>:OVVP35_fZ:a;6J74b<7W)Md\.QILeEILe/\F&SJ2Y/WS=5>g7LQC,aFB^U>a
f4>Qa/?Z[#;aTT-7edJTDZaC/cAU.25@3,XVU)5D_42A/e+<?IO-K;e6_PIFe]P@
Dd3)NQf?BR]?/F<;Y,Y,\&Lfb6e6[Z;SRaRXW9eaBbB/(=^fBHDO]+e8DGeb_#Cg
,cT<CP0X?U>U]AOBKJ4Jc>=&)7VOa:P)^JfXdAQ_+RZgU0]G56)V8W?S3[:+,S?E
gAb7-C)SH25[2Ef4:Z<bCO_I:])B=2Y/0M,\\1,&,4G8#FHHKQCVaWIg,W]T/#bW
G@3gG+I)QJ-TcfD+W?DYA>I<4^?MY/?DR_(1P9,=1]cM\XD+<7F52)TKFH_)B@U-
a^MOS_1gDWIeO9L1HJL1//FgV+e6?bH,Y(/>5)c3W.OcP>T@+F.Q\.)SX./=-/2^
#Uf7K@1#W)^D@&I?USR5=/3W1W(I6H&;D3Nc59:[6I-d(8P(GM_F_L)F#EOA:V4U
2CJN41c?2@c?ZcIA]0?+61R[3d0HH_I9??>W_Dd\N1099]>MMT96\V,B<0M3MN5.
geLB)\/A3?;HBe[]_T?PUQRCIML?URB\ZJPBd(R@D]_\&0,dZM2>OU>f;LLGNTXG
GEJOV<-\H;Y8#GN;(@O?M3?/XdQb5,\JNCS::fASBWF>6<.KAR\\3,_B^EeL,DCa
AO#L<?J6B9(Ce2g06EcN\f1LCW(YU9bVH(fPa7F7eg_1SC)P,QRV_AcGG.#E;e:4
XT]gZFSJ,8/0YP<&HHIS]XKGa/dJWgNPO5R)P5IQ;L015g86UgX8XA\B2RX^.MG\
bLJNIXJG,+MGd4KTBgH1I[aYSNK8@,GP2c-OY@N<R<1#=c:C&]2Ge;14(;;RH(]]
B)?Z(PCD_/29/^\(e\c1D=<NP)_Wadg?+d1]GcU/0C<V1T,HTD<d,]eG]XEUAFI_
RV/0#<>M_I>W9]7EN63?-fCL5ILFd6]4G=4ScD^7MZ1B1B5G<Jb]9S:;V@F>Dc.e
NKOG7B0E&109LU</>2AJ.b+E?Sf)0<13X4dP.Z+/PFB,98PKe:.[gNBM?f,+H_ZK
^ZTJ2cH]W-WY.TQ(6;,7MB_>fUGa+-:f(IG1HY_+WYU7>5EG>JS@X.>ecB,D62Rf
2\bBCJ&b]^QW/Z>9N1JE&cDCJ.H,KTDSIeJX5bdg]NQ;[N68+Y611<dfD?8)+M;Z
63)8gPGB((/#d9=X3VC&CAKd0&<4I7,T.\S0^aFg:XK@+JR8;a?UQe#R6=IWc>]X
-B4E;.C+cU7PY39C6J@4OT:_B6;_>/#Q&3OHN?/DWLC.OIU,M:B^ca_^G+bcc59_
_Y>c,@a,1\bEc0HW2;#KcLD_;Z1fHMJ.M/AA3\^;>MI]@dKWCP1T<-/:JYCFa<Vb
5OEZ&,G6aaH&VS]/C5[)7e;P[/+)OW8QHV/?a3DC?ZY5:G-,e/6fW(=E<IVJ(D^.
bB0X6L42fON1;]/EN_+,.a@Q#0T&=VA_>gDNQ<9]^Afb)XBccIPWf9CeWLSOS_J=
.[OA->I>XC0Z@UX=fa,\ZdO?U+)ET^IMHZP8dA6^@:V7DQ=LX=ae4M-fA98;GI)3
;gVMT0-)8(7dHL>G2IGSCg.?U,0J;G\9UUCSd_<2-e)e4eZa?5SIT4/8OZ.-2?VZ
&4V#]F@ZCS0MX:33NC1eQL#YT<.gPgVY=a3>ER\GFM(N=AI;]V/T^C4T3b2,b6WW
_KPW0&NNZSCV1C=e2]UZcfG(.Y4MY.,eHD7^OJ68\Fb+c5YRW4;dUIJT]0ZD^+]G
;Vb;e@TE>DP<-3_>A9I&+4NLJ/?-(QVYRY.Z5\/X:(O6R4)BM4b&Y#>B(=,75:PS
/H<=R+(a>,7O\,=Tb1(S7FS/70E?7#T);$
`endprotected


// ----------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
XJ2P6&X3g1bU7T(:@,9=Z@>9:.>^SP>N9IU/bCCZcg<+Q:3^7<962(P.V-S?,A+U
GN94G])bX6;?5e(](>Gd5-Xf8E<3HQLK\:g1YEU4Dce@LT6+1+LN.S]ZN&V2\\\P
^_=#PPMg@W8a3.OgbbgLT_JS@8,4<\MGP(ALRgHJGI-bM)=12N_JX]Z\IM0QIff<
XK9W/L7bA18eS]=YOF<-O2L=>H5-X95<KaYAg6@B^F3P+&2Z)>):0X_Kda=/UA\?
fSDE=d,WVDKIgSALW]Zb=LE(g<5F\.N7=$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
//vcs_lic_vip_protect
  `protected
4E92K?-QfVK+L3UGTeTE06T,^?Y((FLQRKP;Wb(>bN&K_8UJB<V/2(@7UH<dTdIQ
9B1-=253YS04[4<5>-OcSSH&)&8:9E>@7PGU-E\2.=dREWP6YLI[2:dIZ2[:dBG<
E_NO8HR+8eUbgCb=VXB:>+/(bG)1cP<&FTK[6R>SGNPaFgGg>3G<gZ4XQ<D/EU:Y
3WSSW-0MB5JeS6(\G/.+eHfC)(fPL]OF,43TW+I?U4/4\^&6gHX].<DcAYEIfCY6
Oc&7T_^5TW_QLUgQ6[U;Q]gG3&Lg\dBOe\4;^4+LbW.HV#;F0/T542DW-K#A/RDH
PKa5)a[(6VBZcFJ?&\P>eOVB@CR5&TYaIL/cR)BH4N6NH-SU:2<,6bZ<]]N9G:(S
?LZa0dELPWEd7,G3G:+;SJ[(Z8JREP;V#X.SR4,?\#15+e<2=8W0ERPBPf11EW/R
R14HE+I8a=,L)1/1I;TX;XG26fL)SN03FS=1dV#K2?e+c=5Y[EPV0P@990<OPf0O
)W&\9XC@7+;4B.ROI0.7@96UHAM;M=7NNcR-I>GcAB(>.59beHgG0^JW)baZ_dV]
-db7^b@-(Q.=Te(5/9K>a&?\9B250GAfKISBgaX[bg8TVSXAfbL-NFT-cP0L_7QN
CV#DNU/HR(bc;F_GI3?\B<:M\-U#cU/66HSPMHaBT?2c;BY:e1HZ1-2ffRTXfT:R
)aHY<[>PNUUTV-B<PLWdc/66^BE.F;,[g->#BK=Z#RTZRY1O\5?S5]8aLB[RTVNe
gQ#Pb2Dg5L7OE>_WE2G9S[@?/XO(>H_<=DIOQ/H(@C@cS&.4^>Y94XPI&?C6NDI@
P>+8fJ<<Q8>d@^-6M9,R?8;H>L3CIX_74(a#GO<a@6_.[-#D4f^Fba;(LNEPETc(
cF.WNJJ3/&6Q_8Y^S2LJO5ULNgfE><SJ2/XNZTY_[H.+M03VY?N=GVM79fUc(b:#
\GJZ?GI_H1JXL7-YI)Q.<a8RP@=XCWXHUU:#QRcag>C@1KDa#0;B>?VF:4Sd>e?C
b1U4gdG,QY/X0&K(f,bgH1C.>b,aWU/#^<2X0VH:EgP>HO<HO;&S5=/&BXbRI=VM
FQLbWZ2FM0>M>fOF#)]TA^FCTf9RdBa=N+MB8E=]#<;HX@7CL)5VaJW(T=+,(+EP
K6##6L-1aSD9WJ_Jb9N2O[^&+\)SV7@BDDF/^,b;RgLR(E3GWDD^H^[fe[Y,O->W
J^(\(=H=<:26:002If[J=+[^T[:MMFI+\9XF/PZT\eH^H&&07^f1RX7(R82(WA)=
>TXY,YD.D\[aY7(.M4V5<3?cNF<WG;DO0JT:4bS0_3[Y?LSEP42dBg4A/5BY&N^V
VdO:]/-g7Ge.S+18L/^2(1#1;:)U:.CG=48_7aB_[:d-&3#=>;B38=3?U;4.2(J]
_)?E8WUT?4ZES&fb46SLKSXa7gTfNR@:_B(C8]d8:^_NNbE+-Y./Wg^dEKQgbQBY
<&2b8IdaeS.a<-FLcfI]FNNI,F[;)2d3HWXT=9I;:F84,cDa9P6>,5Ad(43d4J5T
XdY1&Aa=#f2\NMAH:^2)2D_;MF^<eB2.X:[H8DOXL2I)(?6b=/J9@U:+9O?3Z=#c
D,<=/1X-3_6/O,(V7QI71a[)-fg];ZYBOeA4c(g-H5OCMe\-T,3P;=g?N^6&(:DC
cgNM/:YWM;CHIB+ZV0^;A6/44>R4P@M[TV>AWS4_>G0GED(;]3P4eH(aRYIQ>ORb
SQY^PTf9CTKI5gM3<I?9H]T8,^6(C^g\:+2c3#V-?fY_Cg2fdIKQ@UE_\4L[e?BK
2[9/DO5ARIAE6H+]./#]LLWPV4Db6;QDCM&/C=S6<1.Ae.6gTY)a[d#WL80-,&AJ
YVdU[b.]A..YF?RX,M)4DVONWbb#U69-][\],=2LaFgC7]<V/OGX1eK=dR@9#CFR
SFLO7@b/\U4b+N_gaNNNV:OTC-D1&8#QCdL169\H)09^g.fNdcCYY4#Q&^[eAd2:
Y\U:HQ8T-&D^>5<[3UA\Fe1eYg6+/Z[GC#@0.=,<][@?DA5Pe?:U__=-CR)6#U=B
MJ/dJ9)A>JKR?+V6Y8+DVbM_Afc/^TTEGaAI(N?0;B8YUVTPNM:e0W=ebe@H2b=X
(-A6<c]5cdGY;94(/L5GW/E]Ya,>@,bYBPMe;TUX]EYK=>f6H&@K[@8?B7cPg(b6
7P@0.Qe^B9;Jb;\A1F-IP3LKSW7c9>]:?&G:IS#-TcYGK,BeGF;?ZEBDTSgA#Sf9
BcT:bHAM0C4/G8?PL#8Ja_9[)<Y;^aJ\^K<GP,BYcR;0gdDcLYUC,bC,YP_Ec5U(
_cfZ4Gd2K^NR:^H7=9==FJCKd02V_:/]QNa]B_<3^S8<QT6M-eA(NW\aIKFY^=2F
\b5fPOW.QBB;?UY433;J.#f(Z8):EZINQND)H\aXc#.A#gQQ.TI>NYJbN\?CV<8#
Y6T)WES[;-/9-@,,^.9Q-S3eTTL[J.=+[?U>9b(_?MA77QGDSD3^,YAZY,bH/1.4
ZJ#OGM_9>&dA:]6LM)a4CHc3GIb31[<O2Sd=)UN=@3;NE82AT.CT[b6EBXNHBAW&
FL)1f.09X.?.H<fEd(Z>QRB8\Z6PNI-e]F7aT;J)1:X1KGHQ+43cB5X95W5?/B)O
@+aTQ.c0M1D6I_0<LEaNRH<&)TI/<6?+2[+C;c[(HaY_]/=P.+26bGX9M$
`endprotected

    `protected
;d]F#P2FCd#LZc\M8:B7WY(=;&gJEL(b_[H68XDXU@U7bFAbb^@X/)eS>#7,/.g,
S15O#;N[(O3ETRN&bS9f7;(=7$
`endprotected

    //vcs_lic_vip_protect
      `protected
_4MJfGE9^cJJ(-0fH[GATD8[bBe]2:8Z@d/)J(4(B,I2ZR5_^d/e6(F.ZP9M1)T]
<M;35F/f@I0ZH^F+MI<,?Y)32N.-aF+SX1f/g[dV0O=-g)VGW7D0c\(A]fA5aHSf
=9bC8K;I=DD55P>1X3#HG6bA+YFU&IDO0]^Eg_fU7#W5?_8U5^Y3)?e3YIGafR)I
IcD9N8__IWH7LKQP38\3>OTg8C4_F0Q;NBB.&NC^dE2R@a#c,78:5.PB8SI;4e@]
Yf^P(>V,.SR&;AE1@c_C3A=?73CRV&([9&M?6,XVg6B&)a9RK\I(QTSKa1_IR,M0
AOWaLESAP[H:UE3?g0]Z^OT9Y\(R8EIHPB7a2c-@]RS1g_X^T6+PY>d4AF\^=cfV
a=)gDeaQA@KK=3=9])?JS#O2N-9,VI6^J\CV.6<[8eL=1.6Vgb-[(M-T4)SM6CQC
,L?COC-G.gg:Ra9J6;>c@0fR1>E-ODUCe,T[+K83Zf=_d@#-RXKR8[-TK$
`endprotected


`elsif SVT_OVM_TECHNOLOGY
//vcs_lic_vip_protect
  `protected
HT9_:4731F]1SB;;4B?b;CEEB)M_Lf8=Z,#MAQ#9EEDg2;,:.3)/((/=ATHS4Nb0
]B?LKf6Y0d60P-d[GF,FfO=>+&T0-O3UA2Sd_56>)X&R9BFVCQ<L7+]0-T.[X#6<
cD_Kd=,CK-XS(4.bS7c_/CgK/=3-X,84F\Z;ECG=b@(F+>1?N2\\:8ac(M>Y&?Z2
_J0_OI3-?R\^c-MgNd:G^]^RGT.5PF.D>X1fd#1C:G\c)22WOZ1;,T(7M&_cB#9L
O@aM3\,2FN69C,F3S:/7^8@cf_:1Y_ONea(aET1^I55XS36PGF<A;HXT\#.M8F_2
XbKUbO+Y7HQ#G\/a8&[6#f+_OTGV;]:E0>@P9DYAc<VANAg\IQYd1g^@eU7,V[Rb
J]d=c\?Q&_>c>5^X),1#5W--?_B#0ee?-;SI[<ZC0Y=F/6G#6_-/?#=3S=FVdga1
eVW-bRAY>>=T9P\4aGd2dCT5L.CbNWLCK?ZU+;:57K0H+G6Ub<)-G6R0ZRPL/=7W
US>7NcH/R^>@[dHC/&GVMH#ZW@N]]+<\SfUf)U>>]-C]&MVZKUU&6VRN:63,;MZJ
D8VZ9Ne[QXJ\5)RF9KP#:Oaa2,Ea9aL9;J-gEQ]:>b))XQ=3I)+A=&[YYcVcLBF<
:Q#FX_?B^<Z]:,F&QQ/:J<BT>)He,E</L.DZY8]=I\6N_YH_[-;;>WBK?(/IAO:+
^FR2fD28_;HW>4;:KH043f;3YALD8e&T8_M6ba@N(_V6(UPHBC/Wa+R=,]@,8Qg-
\HD+L<T1d/@cV-e>cNTcMGKN7FT5SBZA2K@A_gSV3=dID9a8?P8EX8T)4SRDMZF)
a3M\T5(HOHLZB<];0KJ5a,Oe&B8V12gF&0bFg@eUPL7[>QJ_;RT@0;C#(]V<@XJX
&>H^A#T-6MEV;M4cRC-b(>83NI1X;S8d@af)gP[R:-^:De+PQDPQceD_(ZE+L)[V
^O5]a=DFA_]_N@/_HYaT.-@8d#-CR4@FF(AYU62?HQF,@PYb-?O/4T=CTQT3F2Ae
H<X0IdG&Q)3&N8\Sb4L3.,]d51(>-M^B]g?CM()&acI2HDG+e^f6JH_5<-T[R68L
^#1(\P?WU#a<)9)X23<&&49e@KJ:KeBXFQAOe:Ze7&PM1K32:\4#<79FD;T?YR9D
+M+9B:?I-cZ>a&2f_1^<NeJF;BT]8YIDQG,0U6K+HGMCWI?/C.;9;C?NNNQ:L/2=
SP.TX?NJ)B4dU.AeQ_f_7US67<,ff4FR)W/OCWVK_O=df_O6[#)O4PM0+UJ#bZ:F
c>HSFD?bO],J+@K[D:9KQf0M=08/e8cHgQU.B^Ab<#H82b<FK,5BZ:&-K=adAH3@
TR&[:)]=bXCSQY.H9O2KMGa;G#M0c_RHTMM>eRZIdMX^?]PPZ^#dQAR(f_1,D2WL
;>M79+._AKZN>Kbb[ee0?<fR=Wa(<V+Fa65D#WLU<>#[G?C621[:U[VQ#_-;\f;1
BX>f1@0c6X&5M(TcHVYA^.[e)cL9X5gF^_7GM#DIF?F@fD\J_\57DUJ9JC([1:WP
DLNNfVa\4M>SPB8cK\31N<_/)DT(<fA/a6S1VAYNaE:DAdS3>aYHSX.LY17=:Y;>
4M>e6;6]LH,]dKQ9N>3EG>.)P-.)N-GGHeG?E]:?:,P5a;7LXR=D^^HX1O_DW&Vb
M&.EQC4]g(46[4)]A6,\H]3J-P/[<c;&N?^J5YSX9#,W(ZaV,G,HG94_6d.G:7;9
[g=e6@7L<g1^G)<0/S]0:].1V+b/.2I-F/?HOY\PW/^6B:]BPf=Z0U;M+.=9J4Z7
WRI/3.4V)EJV,;3[2T/f:1\[@&PF+B(RH#O5;=@D;KEL3Ec:dEg:([U=2UW1Y-^1
=dG/4]+)#FdD>9[R5NbZ00CcgV2\2DI#->P/G6/UW,AC<IF)K;Y;YMfMXC:?E/.J
0D8^2Kc;#>AJLKX\Pce@=2V(U_e@QV..\N(HQ6dX05;b?6VN/KO]eY<I@6FH4N.Z
5JeOPLa++Zd2b-U>30N<JGB06N0Je0@BAN]T4_50#@RZGDVNMYe()D(dPL:Y3ZFa
fIP[1&KLSI+^TL@bG#DB6I5V[.X0a6cPUZ1]UR)QAAH=;f36#Jf6^XcQVFQ<:3J0
NFS73cX&JXSON44.?_J]=cXaV][Da0B?.\FeUSVE<N89<GFYagd7@EJE#YbXb9<^
-([-.F,aZP;4C)@F]N@VP\V0LLT?I[<O8T)5XeaCT,5KNL)S4_X4T&.#+8fd;M6X
3V3:U[e[Jd[\ZUMY,ADKI_)L/__O>&-B/aLQb4Fb8+)@c:/F(5J_^ML4H7HLd3JL
gCF^C.ICf#_96\4=<,51ON=BZaTLYS_[=JW2A[MO\PO9#MP)PLS@DJ-O-A/2=f/f
5bb::=-E5,]#D[YUaUQ_E2/\TI8OFPHI7B@YOa5UX]A-7(=WbEU]PHSEJ8CY#2>b
)K.e6M:g?3/d(ZO>^#3]ecaV;6e/3<R,MUKQSO>B&E)INT4Fc5-J)=\5R=8;BC64
(#9SB#2(dD2^a9U53-+b,HY2O4E^bL/1MA:N3-VQa2K65?_3>I#g759[E-F?[\-V
IL>(.C3:8OMH=MJgQI@FGf_F2aE,=2NQ1V>).;>(LgXO-W]:@:L_T[[_X@bXDDGT
:H9C;UBHP-8PEQL?FcUJW)T0:#CF5dCHC:97/c,(C;a/A#],bb,V6bb#,OA]X&F8
^0<PJQ@U\-)5X-S>B2+4c\3P;^NKLK5AD1@Cc8O<g4R+-_D4BO:F<4cBDH@3QLY\
#1]CTZC9&))=X#:3\=4aXb8<\ESA<(?6;(EfQM9DIe(J4FNEcH3V15P?F?6]f5_1
_N)8#b:UAU\9dO?b,Ke5P^9_fG&ML(7d&>WNPPebC#IffDLR-N^[[7]#T\3:BfEa
IA^BC6RS=VW+L3MbUCH9KfT[)^dg[\@[1<&[E/c&-0V37EF\FBAbEKN;U():aAAE
LNU]fW7?;@ZPB[e(&P0bWQQe[e\J3W-;(e^^GB+SfdH:,AOH3KMe(.^#;=ZKf31A
+Q7PLFf4R?EDY,8/Ng1fM(HOSW^;,\F>2-GL5e(4E/6C^c;-T=;a[CQZ]E3N8aLF
bQ]BH5:BUAQ)[@Q]]M\9(\H/B[.)AKKRW4CD+VV6RH,U7]Og>4:-EF33?;6\;##7
bfWbg2Tf-)PGO3QIKF;BP)d@S]_Y3SQY5@026T,+fCMG=MHWLe=RfJXZ\R4O74@b
A(XfCC#N47a+]TcSI9=Rg@1+&Ia=f:?d8UT</>U&P7BKIZI_O)\g66XZJ$
`endprotected


`else
//vcs_lic_vip_protect
  `protected
<@,0EY#]X,O\YYNTc&+>JA:R4/J?61aETDMfR.3#O5/bI)[S72T1+(-7g<.9WSGJ
6CAEHS]9HS1H)G@[LaQEN?\=U[e64+F(N\3(&d_8(gC/4M[A):1IbTD/O-Q(+_.3
3O<d^H?\c?@V^c+?S>]>+R038GY)G-_:Vc.Y>]2e+4JD]dMHRV&Ne/6,<\\[[/U:
,M=\&1MUP_^+;FO94D6ED_GZ-1Ed0f&:#68&>QT.<9bdL:cK1)T(LT#^)\^@]D3@
,cddcM<g83UL/dKHM9UB2DPM<0;X/bWe7a#F4\ddYP&EJe_6cWQ-MQbI#,JcLb?C
2&bFZ;7](@#^)McK\^FD[c0(TaV9G^XM?(E1;M.[LG2-&OcfSUdON35bVVX2YHSf
>VdJb=W6/I\R\BS(][=IGYb7L^_G=3?DAS?4NY]gRQQ_EH3Z0&(YCFH&egNRKCB4
[X:W-C,7S+KWG>0_9:FP+aHRNbP8Zc\.809/<2gTfP::;gWXJ&^C:^Ad0^2OX;X(
;CS/abLDBga.Q)DA[D,FS]D:FR^8f4UEaR<MY#aT)ARUI]-383\TE4/HCEaTeeO(
WUV0+\a<@Y-G\]QQ<->1+,PM4?,Xb2GbWTK9<.#G)KGfLQ=UcA<3^Q@[dd\?S]-4
g>TKKI)J3B5\/JODP@K:_<;<-[R\X7],3>>b^eQFP)>^=/(=U6_I&#<c:[@C=0gC
Q9[IW@&6-7_SgOQb:39bC@e+\P<N^WT^C37cPYBGcR6,WLS/Yc=DTb\V_=P=W&E<
0M08I;#3c5Mb.aQ6<7D)W7F@91B&1X=]-b9Z7?QDNRc+[?.NC=9U8^1E?JXJL3E_
WL;A8&[K9@Yd?Tb&VV&_O?<f)_1[;S_2WD(gTafKI=_Zf8A<<;8a3(,89Of8]/L1
H@b0c3^@X;:a\(b?T+VY/(Y=C7AB=g>XS47R]605cH5\NRM?]T(b,K^U7,]NPN#3
+A^M,48(B#@O>EWSXABB#>Z2cKWRaGTVd47F,S)^YY/f?K-,H^ID]&A9>_;SMY]3
b_2;QMN2G>K_[Ne5b]KG3B]eIHd0b2[RbUb&1UWO<[V2B85(Y@[-A;?76#g?9FZO
\=Q6)Qb(B/3/A=b=MU5]M=GccQ;;R:+03@KR-&X9_#3MWT#Yf=@OVB/D5T-C,:b8
TX18ZQeZJ(824f0HA),SMZ-8@KMW:GAc^YA<[6UDBfe-e:&3?1;G#Q7fC>R]^]N:
[YU(4FfKL1Ne30.KTB?>aH&KV;#/+Z/R6@LG:3@gS(SP4;;#d,@V-\PQ39O+PP4^
E#f3C?ZI)F^9&;eV1+Q^<9GIJ/P>/?6_f:UX0+_YbFA,&K6>0])H5g6]6EM/+Z#&
bUJ:@:9XCQRD0N4E/U=R=R;8eC)9ZR:E.X.P,>bJ>X[KA?CaRg_4T,L4HQXQ</O\
cHK?.\Y>cM>23FSV;CCAUKQMG<+#GMPSW=gOBL70gTaFH(/,[?LP9JEFO&1XEEQ@
^_aH]Rb+(\)\J=9f[R;[]\S#&KT]D7D4931[#1P7A0(g8[7P<E;RP-R#TMW<>aBA
U[FD1LJ#7KPP=c_OdO0<N.,P54?3FHB4.@;I#)-FCEK(SKHBSA<_D.4J4F=V57M#
CO_HTW^.[?QX+;+S+XfZ)G-/gW^N8\dJRP9R&#WB.EMZG,GWA6gQL+UbAX8R;:<E
eM0_]@Cc6CIH[1O0e-/:I]5:-#3WQ8\/K/&+@dC]9I,V_NTac-2XMR56[L=@Y6D2
UeFPS0Y8/356Hb9Y7]_KFL&62LH>]TIDdK3;.&M^C2O6+9Z8=:43LEE#2AN>Wa[(
A>Pf4+&A2-[d+:8UOI6:I>3cSN7CR\\5+(/G;e0)_BYB5NS(.X9(S0a#gD^Ig6T3
FJbZAcHGX\82CJ_F/b=#HT=<QGd;dg;L@2,<5CJ8[=VeZ_[[Zc>28M]e?S8bJ^<&
<ZG[UIe=-IbeTaa]LU[.CVX]bNg_NYH@]^G3,W-42T658#A4#TS&KE25/+4]0T4J
:54+KIJ0#G2cRC8U.7[&(?F?ZMQ;:;eP-^5dgHfg-6MYNSS3^<\.J\XA0.0OFS7/
@a[fMX?_QTKYG?XI20:MEdeN3X-CZK,.(?.U3ZU0?.ddQ/dOP.^&6H_&+f)K9@-+
:9QXS[E4H/>&d@DXFf1IV(Nd,8[(VNeWU1ML6:PE7SU/R9UD7HE#\NPG/0L))bg<
]^T[ML\[f9K;>E#fM#3f=09,=]-=-a30\Ig-d,N(RcgLWCgF)FR-#DB\F7GK8,)J
&f7d@RQ8<EK77DNW@6M#NK(X3FdeJ(D:DJ/V8cI<,@g]4;7^4XYZ:VJ_=+.AGV-D
[b3]+PV&GVHUG,G37Z<85A,+Y7D43E]:O5L7<11OHY=WM/>S\2NB1X>C()(767[4
fbe:T8V?d38C.ZB54>\EI:aCZ3[8f7TZVZGJ--Ma\aZ1b&cRB#?^;W_A>]N1U3@T
JLMA_\+8dLF3O]?6JWHd@>K3@X43R7Y/Q>de0D.aSQ+HGd1OCFI4PU-CE8^,fR^-
17ZgG#89ZI^RZ2=Y.-g3W#Q1UPFaKUgY[Z3J5]Y[,KccRQ]LcP6X0_KNRM\P;:#G
^[#(:Z&BaD,I3KGQV.9cTS9I]6ddO_ORIE,-X>:IWK&4&,c1e14U3+DNBW>IbMHJ
[\=MJW.()47c6CK,U<+8W/Ld)\?(_S?P_B,+f3^?@Z8\.X>831ca<gLHf))c+\P=
(@[VP(^&DK[,aVF\IU2IFL<)=BE8V.G-HZO>FcTaCTNC,UI>BKICEKaJRG-^^(W:
&EK6/JMSL8&>JRF\c0<28:#Q#?RfI0NcCQ>N4IOaFI(c_DO66H^)>(e=b>UT8#G^
17U9M7TZ7UT8aWD_@bZ._RV&BFMV7@A0W>\FO,ePJ#fV?<@=^2/KJe_f#IHf9PSc
/e@FU>]3WBfD#/JFZX4C7<)_-;>MH\9/BL:R,[38fB/WC4C,];63eT<e8eS=0(LP
\(G]G7#E54gO_:L)>;.f1;bVITNb[.eAPb=+)[aVHbVUL<,.L#Yc0CMQPeP]3GL.
_PI]9Lf9f4]P4&V7NTGQ6D86>FCD>K0WNW<7HZ?[W.f#BH-1Ua8[B\<CfJ&H.Z3N
B#,,J]gUdQ<OHO,]67/d1TbDPUC:a8?(eC/S3XDB(+J^#_63gFR<MXd0/M#(0,L4
.>b6>c;U3VUT0^O?F:6+WNB(\6Q8cMJbP2G/4M5TTSYa,4U1g^QEK=)X@DgL.cGL
Y.Y^/Hc+?a/(/[(P<Z0U?&#RQEed>N#@&11#bX52O5;R?3#414Xc8Q\QJL3>96L;
_8#_+a6REb18&&R7:fYc:5;C,&H5^22Q<RGB]SbKX+P8c_4O;G+LV1A=-?cZ3?>>
/7RZPI9L7Rg[J<b6,EfSZ6J+\ELV,AY1V10#,57>#H3]cA(K^,E6F4f#H.aBb@FT
a/;JB)VK8,3IRE^_[G:B2@R&Va;4+Ib^;9>9#[U+79Cb7\E&V_#&UN:0G48AOWFI
5c_S[ccDX[8F(7GJg0.g3XWC9#]TfQFBPA@f6Ca:9M7TE[>CV?f/BB\>A0@TG-bD
9M(#4=S37PVA)=]37a5\/1JAb7+1J/C0Sa(Nf[J)2L\;eaIa<=:E0LOUdTHMaS(B
^F:,C:bR?[&.[^;^cO<eGX;]G\/80CNa>R\bSHe5)I<5S=0)49<F]9X3L@Df_T)K
dA\#0bX-LSOA>>_N0ZF3C,d.c<G)XZ>Xa/JDgN)/@A0:#,S^+9e[5WN2:51Z(Df7
+a#LF)<CZ(g5==(A_IE5@5^7e-H/MZ8CDM[<_9M1Y3O911SNHZOLS-BX.TA,RNP2
(&0DUER7UT5>WX>GA8]@9[IO8)81gX6Nc;2K^2g.:P7PBP.RE&_ZVO1M0<\^IJ>C
,RdA#38ca72B9U?@CVC[TD=<ATA)2c3KJ(<[JVYM+>.;A7DVMIH2&<26I@dPP;Gb
P87]XQ0O@UF-OZY68W0bg]3&7CdfeAMEc[H_2\TV2H4-IYC(AFf9d\]0]G>Z2A3#
K?F4=IJeg#04GGNd&\^6eNBf.f&ff4c)IV.d[9-D<dgGcf[8D:dB]FVc]NaG>X+=
/fU\.#:D=d[O=/V8+e]5/-3G(2If&H8Z1:_>P\U3#/B2c\58)\c:Va?2^,(5SNcO
36Q18_edL4gH_(C40<GX]3T,9VTD2I^WE570c_E1\#&Y:CYM^(f<TWaY@bM4)X;D
OO3#&=>J:0(-g/K74=R[-&O/N1P8W&680:_9d)&E/X12TYD9S<^\1\/2MIC0:/C\
b>6OAdb1Kb@;KJXE9IQDG\&VYfU[=91gZE7c@8&089b@:XH>P]2+1PO[cfUCHgK1
&^d#WJ#9MbfR;46@/DE036bD.2Md\fYIf84^DVM=_SDKA5[P]SG0R0;OKA3;W]=I
H7gd2?T8#G=8A)ed^(#dfb>>-H1a]Z4,(eWB1fQd&cSU]7<e-T++,X+Q,7U#CF+f
FJM7Q&>,<V16930_Xe2bI.bENf0YH8RYPU]^IL-#dLV-I[_JgF:.:#VA=U>Hc6MD
PO^N:_E-f_G?WG2K2-^WAY-2.WY#S<M?9eH/+[,5VK1?;Q7[\RSKa[BEf]d-7gHQ
/&1Fac5Xg)M5@DDCTKgRe#DVbYRQ@>d\/YUJN3e0]&QWAU8VKUI=K\NJ\N)4:58a
9N90ObQ4^Q3Hd3>)_:FAf>4DN+P\P;:ENM<JVW?,^8H7>\QdF@P>1:MN1?fEDgGK
8X>[CEP.&JW399>cX8X_)][aM;Jg.Q/b_OWF3CP;)^bRO;FH98URD7J_V8_N)JL0
^^9UO;7,M/M@DALEH5_F=)_Ie?S,K<c26K(.UL==\LR,([)C#1<d_)e;M93?G]T@
c<RX4C/OYZ[;(MEb6<TaV?UQK-OE9B&UfE.E+[ST(^a:g19Z>+QBAb^KLW:[LGS1
,d##1d\L1[fUZO0OUON:f&DA6//.GUVY3PM9&OdRMY(O;)5>=>?4c[)Y]cZ:()1/
1Q)C\QARgNNT(JE?F:32[b@NTJ-)071>A.)If??=HTHa(E-e9;I)bV/>R:SE_EM8
@..S70[JLb40DA(@c,IITf=O-@(aW@>_eU@)[<c>aTKH,K<)LU_g,(_PR31#,\2e
Q&5NW9OTZKD(W12a7_YSVE(O+N.A9ND1Bbf;M3\GDT[M8+I2?;)/8,?/7E?[UT?J
,(.Y=N9FG=d[GB=;X.f@JF_T)U[9&,JbI1=TgDa-LL@Z&E4(b[P@_/AYR7-XfLAZ
QMd6(4=^M04a/#^[@M8@G#7[=.SX:=d3Mf?G:dL\@E?Z]AA2W1EKZ4Cb5CG.2\@:
MIEBQRD@80?5T^HDF=D,bLZHH[eBEB\/cOKQD1-LLJ-aXPB./.BJPX2UH.C4)+>P
E?NTT4=C&(U_Ycg2d+G3IPGc./[=SZ=:R,C^T5JHHcA7P03A_6;>ZQS5GcW?+a75
QUK&2d]\,4:bAHFB2+ZfKf:K?cO&3Q>&-bf,FOPdG(2+gP9_Q<WV8>C&I+47M+K:
(P;e\ZQFPd=BGgeN>0UJ1e62^O>HRg>G)R<0IH4>M.I5G+=,/8:.WE,f>SIHH]^T
(:+CU-9XK_&bfNV-4Zf[_)]>69#0aTXRBK?YQ5^]Q1(:PVZfS;7fENY;\KV2#gW(
DQeL(8bd\TYIOaSY/SPC:_8CZ/fFDZdP/e?@fFNL).D(\0Ya/X+#=-PLY;:>A)NV
[f4N?GW1^Uc.F#V;_Z_[c,AKM16ZM3^U,SJ#/Q2fUB++:GggLBV&T(-;/=FAK5\H
^R4(^F5&@-RMc]>DgP8.)[7UNbX.-CR0BVRa1BL^Q?e51#+7KB]SV;QW4]aF+OB+
gDD9T)ZW6B0>;XSTV[[T3FT4Y;3ON9RV+;3df#(47WfH6M=IQ\Efc?L_LIbCY7)+
5UP0[c7Q/-=g00(CM??eJS5A^bd<I\>?=0)#bgANWB]3=cPHA5+2[NX[-9WZ/Sa<
_FU:H+Wc;1R3[K^SRYVJW/9NOU1@82Xf#F7HI@R<U4Ma-B-AfY-U:SV(JaZ;.2+Y
2gAQ02b6=\7P?Jf@&KNB]W.6:SMaNNZ;bc3(](f-(H<WPe0WVcAWW682SXI#IOb@
K@>/f^W9^GRT+9\AY#NA2Z3.WS\.92)>>DG-Q--<[NTGV+89N]:OEK>7ZHE6gR57
S<GAC3_7X;UY98-1HG-6I5.PHR_R>8U7[V[9]VF&eSAFTVKZ<KaPGZSOZ]T,5#fe
VQAaW0Z>7V43\6dJP-.Y7M-2MXL?7#G[cScdK+]A=UbFW=)7CMP>3GeV.JY]6A_3
NbDcV[+0)D?ZS0<JKX4>6O6Y6=>^Y6Y5ZRV&Z,/ZMWWB4a,+)NRZaNEeb_RS=H72
F@.GD#4+^D^Aa+-Ea9..VdZ)QbX[]:;>,(VS/;R]/MBcdII+_2-3)VS:BbT.-B3F
6[B@^9c8RKK;7+2d4-169Rg7A99c^Qe,W[&9I..=b.2M-U;ee?X418d)J2(7YZ=D
)F0N+bO#-V.-D2Z9KIf/]1d#-?0B.XC\JGI\])KNb#X&Ad7-](5<5RH?XNCLW6-=
.+f_OSF?->A<O0..A3RM?D#C@fR]BYGfKDgPAOEPYM9EZAg4eNSa.5O#82,1,U:R
:19&KcHR45#X?1BX6D6_?0\IZH>1JGTfY8LAG(=L<)>Rg41O7KQS^+,H_PP9YY#g
VG(Y49;USS-+N3S-C+;Y,gL(1>X2[A=K,\]M7d4GbGQ6O6LD8G>L)NBeC]VJ7LNP
#=YVMS^@dYe&,+9RT9OM:?FQ>\57H0_92-[K\N2@Q@e5D:]bF&/?@REZU0+&0673
A#6[XYI>&@>EZM@DH:_OKb5I?f/.<MSPJ_?4(RJ/8Ab<=;<T-8>?QO5(XXe^I/^)
MRb6\I@,><]#^F@+/92,D6faW\#3Y;b8H&MQ_O>31N?:R,0C7@LEN6[T7U2Wb@a-
C93g3I9D=KfN:>5?SF(:L(\1E[,4Vf8:1L7-AGDQc9\e)aOf[8GR(#K^2N^)a?CQ
S-8MRFO5J;/=E;D9>:>e,b\13$
`endprotected

`endif

//vcs_lic_vip_protect
  `protected
-3;AI;P-fT?KZ.7UBgDbgY=g#E3;V/[>g=0DVNZc(1-e/K[^WH1W&(&MeAg&.;X?
QQ2E9T?>20L2H43U&Z(cDN/>I/9R[fO-:<cYE=L^Q#H3,9B+cILf@#8ME=)LND9W
8F#:5f]E804K[191,YEcMRR/]c-&8G<(ZF7+J/&3cZd0\(:\[bD/d3HW[&@GbWa#
8gFfVA>3g4?^B@aLgIK_6D&BHSD\<#Ke+QSc2E+A;Gf-]3S4;7:RWE8@XVT&-2bN
]&XJdG7?SCD(?O68a>K^1_W<2R8(-6Cd#:AY5_bLQMJf]X,ELF++d\^\M>J[2DP2
d/T?VY[1_@D#\ZQY[3fc\;[\AZ[1UD&S5&;57WVKX=FAX_6E#)dE(F-eIT)0H4C.
QN\(^W;;e>(5KNWGdR]#;W)LaW@dJJbD_(7D:4.J_KdF.2B<HV,:]=#L#RCAN>aG
LLOd2f/dR+->+IX.#Z;/HVR)48T71>(B+[EGK8HR4]5/8T74DMS3Ya0((GOAc?9b
>W@Q[I\D^fRV_RHeBKF_,bWU7\51e5\#Q_R@T?:0OQAYC6+MG2g[E?c@OJ?;R&4W
O33.),Q(YI:(\cD-V3=5J?K;CA/bH.8R<g_I7+X1M)f+T]7?[JYg_c5=[d2:3P6;
40FZK(2OJJb_De)P>@g7?6BR5V+eOBQS)7_1&S&MUFMa0WQe82F=>;V_1d=P7N)U
4#=]+(ED2RAB@7;,>4IQ=6\&7OJI(5(&3[KAU2\d-6Q5J1efOMRQV>4G=AOBAE\Y
(e1Q\1&?S:HL3PWQQA9I/M,[T>NHDM1A0LA5\>ZH+VY^Ec9MH[fJJ=7L;A:HcLOD
W/Hb:]<])d_5[9M8:,#DabU)LIM,aJaH:[D@;]P[;d^Q>[Q(<#(:,UIeAZeZ[(OT
W.WZa;6]KFg7ODL[DgJgBUaF,MTA^P:1&V;/B+5(L;fZ)BOX5ZS6#NB2BT)RGT[;
&dP42+I6F:SQ?EI;PUcJeM[;N?LPe@-c_9M3Z]]TETTA:(a)MO.a9Q0WNIC,ODYg
&WBS<(,d_,,\G@?ZZ?\]-Pc3P>d7\M<@fIT?\G=@NZQ[1LNK27:_17[1a5c,UL,a
3)83g.gU(O)5?W3S8.A==9D]?.)DX)L3THW9@;b@bN/,/4<;YK^L26AP4BSZ:U(-
#?CCXGXDC&,7CI[DLR=^bYK>-37XVB9O_(P#c:_^W?1Y4Mcg8#R[GGOaGG3H8VaW
V@FS_WZ<f6+^L)Z>a(F9_eBYP;X.27TD2^Dc#e@6e_=HS7D9MdBLe>75T.[^TVeJ
d3MXc2SJB0PQ15@I>YXR?b6<3?c??PdX9f@0EGY<6,9?BZ^+6fDT3T>]]NW01]>V
,EUUL^48LKL(]I.HM&2.>V+[T[Q0_b^a_J_/B^GOXTB@A[Nb+>9[5,[J+Y\1?CGa
O_DP/@bYc-I@@A&S6WC+g&XXg;)RIR780Q484LcVD5M>Z7AO[H9EJSN_+\F=F5EG
6VU+Sc^E.aLG0O3<11#ULbRQ^,FQY;5Z=Gd;+Y7B[(BVd;BZ>SI?GEM7YM+GSGb3
WOMf7b-3QI-aB=7beQ?_ZM]<3HG>;.KWfFJ,[^C&A^;XYK^3;>93?#f2Hc(:&M<K
7.Z@B<X^J4#]M=X(^c:;aH@7II(0F5(,6]+@?]7-K)La78c>PN8PYT-QDSO=+;_5
P9Ff\F7C45R>E/E_T<WGX(1Z^QF^:We,Cca5K^5AF\(MVO7MFWbN.7#GIT(=LcP3
Kf/9gX#QHFN\#9PA2g4[LdbLNADVBO292<^2<DIaXTe=bBMeVH+1(C12I8\UQ[(\
C);^5F8<LbYA=M9R>:,=S_-M+TeGCcWK=4OW3Bb[<\/ZU/1XVbD[BU</PU+f((.4
V[PIIF+&HbaV#DLFe6)b4Rf54ZE-R2e=?8P4+1?\;PQS)E9R@@H-SN--:AeOJM2\
FgV34IcBP4;6QQAU]aFU2Tf,8O>0,H@:Q<M3&0FU<]VHR9;aVGBSHX-8HCVf:1>4
Q6=Y9:]OL37_4A7?46#J_^Ka]WBISb>:D\XUQ8g.L?UW(eO,+^1,[cQAUFQ(H8OC
GfF0Q>9H.=&AcDfBD+VP,DG&+>=fM_-RUgQ_G5=5ac)XFbW51IM?BN?#Tff13[ZI
XQ&5J?2),5<e1K/C_[L-3^:S@cbV&O3aGGS[GbYEIcA_VPbAgaQ,@^P._H/W#9Z4
+fASQPfVFE\f-a1cQ@M5Da\_PCGX9,5R,SfDTV:5>],&ge:<L8;0(Rc6MC2D\_+D
N9H97H0^O70=6U-\7fBV_.XPZEB9bC^c)K4d/dU0O-.\&79@.WCM^TY/ABVKRR,8
#L#I\ab>^53NFaR9E57CURb6N:?4L6>LG3MgQ]G[Y;E@MI,-.f)(.RMYL5>9aVU?
?FSC^WA5@SH,c@a1@TIeN/X1=3[APOS-C]5C[I6gV^cH/#2@6>[0[A2X>374=;@_
D3=FeKXBG:;d)#T_2+bTEHX<<a\#aCIU5e/;H6#I=UBCbH1_Ac10PBE?DVSf>6KD
8Ud(Vgc@.IcceC7D:DPTCUd4S.6@6.F3S/J^0bQTeEWBC06264P8:)#/8Q811-J^
1KAYSG,fTQDD?14,I(g7ec+[.(b/OX+,0?0^b)Wf,1/AWAO]_F-WSS]Q(-HU_JI^
8GY80IZ1,,BZ4?4M767J_Ze\6N.9XVHM-SKScZU#^MQA0[#OCcIH/+4IXMZ79U=I
=@fJU3D(A;WD=BA(.ZKID]c@\)&MCeFL?fV:7T/02OAO4?PeTJg-eD=b6#9U0BAD
)V[LC&<LedDJN=8#+:(_=7b(edFFfNKgScZB-K9cK2e3BNEVfH3gFRI[#CIL[c_E
ZO1SOT:8^a@0JP:J0_W,4,@5^\4@R-&b@YZP4:^NXW:beD,>3,BJM;#JR/TbULN8
2U9/?ZM3;Y7L9e#&9]G2@=-1,]3&3Y#2X#H&)HZJ4Tga+6?+MO>K@C5=N]=??ZBB
N-9>>/VAYLV<IRcS(8:#d_W#)3,/\T1OX4>ZdQBRB=OWT[WgRCJIIJ?#1WKag1O8
)(:\Q3Sc>\CKYf9K_H#d(Q#OIIT;)Dc4;0T?8S8J+UScGX/:[C=TfMH.AQ:9=+EQ
#&_.#Sf/6c^#&?6^#MWa5eBHU8e/bH]&Zd5G&0F&AQ6\@7N,7\Cb#Wb#aNg2B9+f
g?(VcJ8\GKVHUc14dgI>>XDMLTf3&6E2J>9Y/TQg0eVaP[CU-89E.H_YYNaBH[S>
LSd3\]Y3.P6-&7Z9_H\E#8K?@6,57T=/YE9[AVegWH;8@79#4X\]4R&?cVG@YSWJ
af3G7<8:T>Q,G:;VJ;U-T\R9YHFYbJ#0Ca64KaHV.3eQa9SW_NXF&SA^O_F<-@[(
MXJ;HO^21J=agK<cSO52feHPVdf>J\Y]U-b)W2a&0=PL>?D[,QQI\-eD2QVeAg_&
R(+,3d&5.-J\GS.^&.S)+?g)>(4Y7VU+JC>Yd[S:a8c;)e4FCMYN,\\9<GbSI1JH
E>/8\ZV3<8gZB:)IO54S:dT[Z&Rf-(T\a0&N=]W,abO?[RMVV^D7@KWdDcFL-\\d
8<COTF5IH>:Ic607d9>L;+5=7]?HW.W82-X^5b;6R1O^9\.4+A\#I7+VdV@[,1L2
ZLD[).AQ#Xaa>bd.655dTIIWNf4[1UF/525O:gE(GWH]B,8_.LMe]H5F3Y8b6XIb
D,Fcb0U_ZR;X.4E1XaOU_9.>\6+a&.F<Jf<2(BDcQ[,;>>J+-+-K)#37.L^7QA0N
9S0OKaG5H6B09@&VU5>+OJXO1TdC^bB]a@/F@aM0EI=]_P+LA4eWK8GFMT:8TFNQ
^(\Z&#7BJ._dPF]4H/ZV627IaEe[4#eMJAP/RedA&.+4(B;G+dVaPGR;9V>@ad;^
AO[_<AMLY9.Q3Z8H+WU]^\_M\T/ZTJ^-L.NPe/M0/+KF))>[8=)-;/_@L<QFDf-1
?(Mb#00_L@f@K0\;63Q>N=G)_MP[U,U3)SFe&\U_VA#0@,ASgU2PH_R.QY>WAaaP
:LbF02\M<70=0ga?;KNRI]:+b1&U[S)9YI9TF;-2J/c0OR7.f.2AcTKH#&ZadLSK
4[.B4R3?NVOf:-K[SNQA##eaNM75(e5Sef--_N#TDf@NOBfAL@D5\2)\5)^)&V3F
a,e(4ad\_B=8,VfYYIQ_2I(]RJHU<^[=+Y,;&>f0g/ICGFYUOBG]42AWgX;Q^-9V
90^1-NXQ\](0M2c:43=K2.+Ncbge#2YR/CKUEZee3FF0Q_^.[cLVJcBOOQOK4P]U
.UOCeNf7#fCDc<X<dZ\KA1cV>&TA4b]3^A3]25(WR2))E.@UYV04Z0GSL>f6^7>=
Q:TYJ1.#dS..)/[)W?UU:+G_^S2)=bP+.X4J+,L)a2?FDJWMILX=JA.A7)3d5O6]
\Gd=0?QdEc5UH)G(/&?NRD0DaOf>BaOT3OSU+AF[eF\gEW^F&^:=7ZXf25b^fZ+A
PC])S3VAU04TTW?adCHKSWfAT8-XY&9a];4+GW6g(^OBN.gbGbGa&/6[@_N[AE^P
F++>8fM&&XH#MOH]b1<K^9;EMTXT<K(OJ5;CE2_-HZEfc2G/PA;80I_BW@9+D4e5
AWFWHFF+[;YJ_IR/3HE,SGXgA3U0W;3;UN,.&X19,QfSRUPc#(ECZ+0O9CD=1<-b
5fBQ8]+e8I:US>T-?>8]FXSCT>5d+)7_BC9U8aJ1/f?9/UEJPWD8ZMb.d@afKXD8
R.A1[=\SB.#b,/3gDJeD7EK/gR;Z3DEU9W-cfBLFH4KUg;H4b78QV[@K7#gV#dRA
B,[@][M:MTEPE/5N(cZ,Xd9RYZc2gV57>bB\?cee@2_Ug809d36<EC8&\B2dOQ4d
NRbS@2T;:6F&]5HQWI__Dde+JdBb8(PM^QOQ/3cMOcbF^G?[&9eF=Y6(DI2Gf2L1
T(>f1;2\GX0)cF0#G;OH4B6#^dA]9?##,88L?O#9I?=fdFIe>d0QQA/H6fGBHGSM
Lfd(9&-OB^P4VM#WIT./?QW<,.KgcXW6A:JV(>eMR.7(cF^G_X?YaDAXL=9\(:S3
?M)gT)NL/H6:QV)N#b\A&&]^8Hfcd[]-^C+c]<7[#Qc<O<::VX:F82])IR^]MH_b
<<:X&U9C3@7P@#Jd1<@YN7VLIU#8?05PGSMS?N2dO):XV_4OW6;;[bM].Y@2^2JR
Y;g:B4)M1KC34@],c8ba0Q(IWA;\);<MC2OR,g?bM#N_?e#AbUQH.4f_fVP:LIG5
c>DF52RQ5QJ03-,Z@V[dQ2@PGdNCG^K9,R[c1)d@89=:I.O17X(+W/0.MbJ.\SQX
IM;_<4BHTMR.4JbSO48Xd[ZKe)\2-.e],?d?9[TQ/<FA>dWUY5#Y5\9c>O78:=4P
:f-e2c+U/H].RA>I+HBDdH@.6M]G<GC_K3M\DJINNX_3REQ,g&@a=d@bU>^e8KKQ
MF18,R\KZ<cOX?C31)FVFO)N/]19Q)6#JJ_FL87fU^&^1<TT485F;g7_e<YW589L
[/\2\T6MN,Z3)Q^L3Y/K+eBX1:\)c647KfJ;:3<85CFVIA[YgE=7/09]ULW?3VFD
6-(+->9c++bJ3Jg5;17/cI9/2<5YU7g;Mb)ZVX1.4_7S2.1)HG.[N\?\OfOF[&D,
Bb#@AH7CEH6G9N-1VK9.I:0[;2S62Y#OS_[Tc?Z(Q^1<(Q&U5-W0I2)&N3@WKQS9
Ef]FH.W1SAB.e)QGg);4Z+F?B>>F;WSOS:>P]SKRW[\4;]NQM.JC&6O)Vb+_fc:V
AA68AMgO\=Ge(&POI<cGFYU-E\g2g#R4??D/g<E>P6Cf]T<SbW<Kc3A5<)@\\Cd7
Re]\JJ5Q9192B1,JUE_1P=M=<K?+0&D4UKH_9.CD&=U9C^)HA5a-;SUJR+6:AK5+
TXgO?H2)e:H&FRR3H(C<1=,;TF&_U-A@W&FcX)4S]M,ZdOAI]^JOaadT:Z]IK#/[
HM8<@GfX/<+TR0DI_381eUY>U.+^7Z@&\aAA30[O_J@cQNJ4F]S9f^YbdIU=.;#6
K[D7_H8Rg=C:)=6I3ePLQU;M2XQ.LS]6a=eG2-C4GOOU>O.4LU1&;QaM=R7@FgK3
afG(JZNLO.TeNY7gSGe\)DE7XQ[FT3FP7[77B>dN?]BR]Bad\J7M?DG5Z_Ta/BYR
?OGd@gB>)gNHX_ZfKKTO>f24)A5;L/90_KVX(XgDY0PfMDY:]OI1[Idb:_b5?=e0
eEYU0@QHZEQ06NI3S:_D7e4MLYA9T(]a()]H83D?X3CIf/6BL#43D;SR6_E(Sg[)
8V9,W+&0dBODVJ#5fHJJR\>fS9+I[RXeS7=g^7I<_8e@TP+Q=S[@&U8O8Z>MJYHL
@GF(6-:1d[6JL.95NgOXB1H+C5f?H4J-T8UG6G4PAgH,V.83W;OQ4@]U3-EL1Q04
b^+Re-X+V]5Dg/=,R-^3UYYMFDY]J>L=9,=>e+dL,C4+<SXe#JKPdMBXU#gB4IZ/
cJD(PPKZ65^.@f64PG[YX&JVZeKB/e#XaLNef>/N<QYbU4H>GeOeZ24;,Y2<f^EO
;[T]Za>TR1N:F]W7T(<-PW\C<a5S&AAT]B<Z#bVZQA@G\2K_Q;8X#G2Df_6AIV<Y
EXWVXZWGG4SCa_UOZ:KA])2++O_B5&6b,c=WLD)@BaK.X:A3.@ccBF+1D=A,MN>F
)+f#[SDX#NZ\4W0-KeRgd.f]R=f>B>2<[#/O0+[AL(4FWLQ#FSKM7bGWb:-RW,Y0
QI#FQU=,>Jg5NABd(N36G^^].>NU)LU&/99H=e^6HZ>IQ8H^D5YO5HbQeQEM[bdS
1<4.)6UE:U,+(:Gc^N(TeJCES&SAWXFB;/59_Wg?9@B?[]TWI/^6W1Oc4@8>6BaA
_#EE:V>JU@3-.V&O\8fBB\G\9S,&D<JK#?T#_Td@+P?F6=N6,E9^=FC\>MU8P4P&
TS#G-DK3JH^LgL+#Ef]H6Y#+[F8KMJSXS-^Y4<Wg_bJB#gg6CKE3ZaH\K+E71BHf
+b+^)aW[;^-<aOZ9>OLJ=8?ZTW>[NRFM]2S:9/H5WWef]>)Q/8bO=\cR6@]A=T[/
QO93PB3f)d]-I(QTFccdQg]_RE0O;+TEcd4H.g@HI?R)_ZF0g^++F\=2_B054@E>
5J3U4;9OVN/E[HG&A,DSSX?A+Q0cT_dL&8abRR4]_+()A^dC_@gWA+^.@M19#d2F
67(X\#NFH31-F0c2IGegB\Y6,W(+4VT&SXDO;4=L^Z0+LE8fTf59LG:D-#.MgUTd
^V\JCA<W:2=3ced3QQAS&BU<^\\?=.e(\Ab;O;@L6Sb;__F<97PCCa:c2:&TFJ<W
e5NB+c5A#b+.e:9L+b:]\O[(?RBTfW@EKbeVNLUWH/g]H1c.]>JX]bA8CZ7/5UfD
Yb^2_RU/6e]P@=NNYe;e@11D0E^&JO=_&Q&WJ.cg)+20A/^+PdGQ1QEgGU1?>#?6
97-6N0LR.P?W^&<KgE4+72P48?AO5Ue+N=V#0G[2UH2AdgN^.N.3Y3GCV\<4XJ(W
aU;F4X?N(QR6M9/OO-@+Ub:E@,#3cdVXf1WFb[H1Vf3)_d+CZD^Cf.M0dI061,aZ
L[_H?(XBYKP8>2<B+&N^;5-^H@FO/Yf]0RNMZ:]-0SI&4[DY<fN4+\]a#)([:Df^
:)DGCWO[/HN(FTg_^0@GVZ1O[]#&TbI^EO6KTW@H>B^8;XdDN86[?\0V@ScC<b>/
?K\P]Kb/:E&9ACafFKgU,_5RgK(7+5RQ62G_+eF-YA^DCT8S]T@9@3O:e2&(WWY\
L9FR@e(G-_9__f2Xe;O@0+:AH&a\/2CCS&[PYT<X-DH8bH#=fTO9,EZZO4NPRA^7
]:Ya0\UgGS#B\>D4?\Z\?D,G#J<(]\TWK[C,HCFEK)d&=3_Y0MGF/bYDC&ER9U5S
N])CE)T(7:_N(\C3.F#Ud6<S(,]@.RE)+\(JD,UC2Y(AOD[aE(2UA3=DOK=a:;c9
:F@D&TH,UTbd<89Q?g6(aU;HW0ddEE^aKDW]Q#(8,7OH[dI+?BDSDbdYgZ-,#)84
aX\3K6B(EK_3_+E[=90,VIAcYL0APFCKUV)8<]-^9/Ja.BNTVKSCfB026PefMSQI
ed_17(YN2&.U/U6^gRgQL;fQZBP-\4;3D,)NK>NU8:gQ[#=T[eC.dW,C9GEdF\f4
5a#6\TV<,DPY=\QR)0SYVYQPZP/\FTWN11cZNSE43A0eW9,VI\SKN75UT8Q/UC/,
?M\]-/:S<QB>&,/e.GOEO:OB\@<DZ&:+2;J(5RU=_OYdBeYc-(8YND>1KC6J[B4)
Rgc/e+?1O\b_R-A&b?:0L<M2#dX<FJ:[0H)U^-H7-2GWJL7&bFOK\e=NT9R6:UKI
MRe.2B]#\H5#T_+^=XXTUMIaM+/I;^,ZSN^?&0+BAdL9/;F;.\YKd/7.&0+W4FDO
AE@ZKRSEG^gS]O69H[W-OIHUfcZ/=I.QF].V.+^[&<FOS//,GJ(F,U:\ZAE@(R?Z
FCC-aA&G5O?X\:S>\(@HH7FbB->7Gd>+^eSO&&)Te?T#:L,J5[/FL62PDSKfDU@J
WA.MNJQZ8I1O\U<[eDHeP)1(G6b,VLe)Q/RLb+Tg.M;>-WKG@XP2?IM-DN7B6K61
_I1FX-JHfe.g:PbLgbb80EGFB,X5>T7ZLITM7:)R\4b;JH,&-Eg?CMae_+c8MeH>
]8&0[V0G0_R+)9U/G3LeSMeSH@dA&E1^bJbJCG?;IUTBLOXE/\c&d3L7)TG?1@5<
H(\V;(L>RTU<.gN7&a,WMW9?86A2\()5;@9A6eB[M9O1BK)YNV:;,E)CJXbLA<RD
-#==MEA+EBXSW;A&04T3)b+9-&0Z^<g?_7f#SPdffa4\O4I;c7[/->LJXVJ<V:V]
OXcNcR(Cb2(<P)129FbJXXOF>V1<MD&J3;6MOK[JU9];B(E<.9KVL(.49D;AWXSG
g0KI4<9=2,HfP\-^FB/ML0=e3U3+5P0_[KWe-06P.99Kc-)DY.bP7(Eg@d2>I#R=
))[8MAc#U\L\G0J:J<ec89Y/baOTRD<T]:P>aVca;K8OS6NU>#_T2))4?:UARU3?
4]8V51/Rd4W6H[:+:d+VeK>\R53K)8=B1D8<4USJ5AOM]:K0>RX--P3A;-LK46JX
V\A:G6#8YY9U(+GRS[/AF)IL]ZL4/R\(458P5g0(B33:2:7]W391W5IF?BHaO/HZ
Z[6._NQC3Wb6,F4f.-+,=7@OZ(1H7^,e_I.a.KMC)6FBEe<M_;E;+2PGVD<)9RJ;
FfSL2C&g/)JbYV5:SUM]4?KO4&)-ASAILQX4R^^X4WG9eQ;XRA>CQ71S;9\S=J]-
FN\?Mg+U)\2Y#,K98CR:.<L_=PP8(T+UV8S&c&Y>K4&A7<@Q54]\8D8IV:CbBaHD
T/J.IF71)2=d7bR[A,R<>BgR3@6S5,8S897g9UcI5b+KaD,UZW[@28=)+B<QZ_L2
QT/8[6bS(>#8_M8acWJSDL<(5G_,FT\]HWf1H#&/Y1<4^>A=g^1.3bd@@WN7XgL+
d8]KM:JA;^1)b>30#VV2c0T6Y#,+6?7b[IS:4b3H<63[S&FKUN7K._[\Z3b?BNOe
YDEfYW?g_9AUaGNTAEI(L?5M:H3C1E8ZST@.MXH0:=>YUWI_3b;gEe9X@ICXX>4S
d;I#3F-g@J&Qd7JD.O_B-85g5_BSF\TJLaA6GJ32FZRSZL.UEa=W?ZcWaMX9-]#U
P^8;/0[bEFS;^IJI]cfQO6<VQN_K2EC[fH-^g(Pb=Le?JR#cg+_\8?@+;:9^]1VZ
5K@<f@SO=@?GGKFXg)1W6?KB)E.FYMB(b7UZL9FJf?RPZZ>cdg@GEA-JG=B/_DM<
@]Tf3OAd5FP+P0D;W8CEC4:ERE\f,fB>W2UGG<@0AU-(:(UH.f9X6X;b]QgT1O02
Qc=?ZH+R89OJT4GM7b<C4VAKE=?Kg94XXeAQ/?9^+B3VZKRI9,>B.X922:Y#&:5g
RRXIe^.4[G2de9Z)FRLZ.&PU1-1KR)XbA^#O&Y8)H+O+XL;=5];0d75cQLM9fge9
-(UC5PNQHH5L?7&6d]adYZ.]0D=DTfOSE9A:&N<;A4;K\BKg0>9c5ba\HSf=a^-2
P.P\B&C@ZgNSW]-(O\LSLeU\]3<]J]<gR/36dN;-eVfT#W?@Pc_CfGOA;=GfSU4(
=gI9c5-387I9fb(X0>J[@McaW8UeLY.8KNf3e+d4]91CEWBb=4@_-GQU(J[,MFEW
3QA0PX?GJNd=cbAN0G&Qg1Gc1AdI2&K9.>#ILC+H0E5cg\81e2aV=ZcK,E:VJSf:
fTRb-bg#ScO]PR^.>A14<YX;NR(BBC2^ULAW7ZfY>0U#B\dF#C2M/VWT(>@L0(;U
HK/FC0S8?65VW+R?=beNJJ]/H8:.M[:^C0bVWD]G6gQ(H1P4&^N(<R55D_&GAF+g
>LA^09>39+T\I-?B1213.\fJ1;V.&+@[GdGI[L>NVCEG3^:b7=dL,MDf7+B[FdcU
DM+/7gBeJTK?bT,RLTK<A[DP5LS&F[=V1+.3M-c]FXVX6&Meee<E)(eLG)[Hc?O)
Q#?S4M2=J<dg/4H//UgV]G#d2_bcgQ<^[fR4YbfM<8?gMO=ac@,E\C(C?8cUfU<K
)6Ma=)^+_gZXR>+^3T#BM]S-D/<A9X/fHVe\I5@BJd9PTac(5L8\TWR;A4[FY8[C
\VGV_>Xc3.b_gg/2B_T5T[2Q-8@ZEG3NM=b:Lf_gQ8C>M9GOS6GAF1/AJ:._9Q8\
a(^Z3YWD]aPHF:d#H5DGVa2U>G6NIZd3Eb(:.T]3G&;-QB(=S<G-()S835)C.)9D
)1^6f#X,>XZ]^.VeH9V?>CQ[785W\;<85]LYFgP;VHHdQ@BFEVZVH\K9<;EQ;2(^
Ve#7cR8@f++9M;F)fHFdg,b2M&.YP3E##RK>I>@W8QK]4cKQ@;gGdK9[47<c;AEH
NB&eU)FT^GcJ)[8gJOB7Z(AS_6SY<3.PPW9OdIAG6^G9:N+SZWe-cK.P3.4\]ea(
&5?WT=If\f@2NcGJJYVgJ:9:Z?N?Gb;9FT=PVg;F1IM59AT)7cCUJ2[;+.=IEK?a
&X80<gN_cKJ1DWdcf(.]YT@T-@-N>gc&DbAeV1:DKaUdA:g_gF:=8/J(8<^Q9eE^
2cO&.7+1[(SgcV4G_=gN=-@H8ZWfL^;DL81d0YC3M2^)0EFBMcO<+9e=DI9Y[Q;M
Z/FYZQ3dQc[CMKQ>L-2ca.7JH+XfZ-:L66Pf5+_]>I_.G#]O,Id>61PVa/8V7)b(
<<QZEO@CS33&,RN_@1VdC)#.Mc,GH4a5Z0YZ\H7)8:A8/,UG;^OHY&1cV#e_4Ge=
IFG::bCM5=g[dO2)2@A79aPd;JWHOP/_M??M[;d@,4U^T&&:]fGJ#aI)@NPb-U&O
Hf85CM<>>\a3)=KO#UKQfd&U]Z8;e-UD/@U9S+3LI.:]d,T<c7Q@GZAc?B(Ya?\b
=))-NbCG)JT\P-Y\Ba>>V8ZbbaFXa=Pd6f,2-f,1\#TEH=bbD2EO6>@7>f@1Sc+-
6>RZ@a+@WF5I[C1bRJ+#KZ&PXL6>@6NOZ5KUCWL7BdH7WX0#BNI#\0;-#_9TaL_V
)24&JB1@:YbWg0.g@fM78]NI-OMPU1[F:CKe5J].(=<V]R2[K+_<95TcE)8=M81-
W+C;gB.M)-A7QbGaRW7gDC.,K1EO7_T_Y+1B_O77;&+80g[e@<7(/HGKXM9ge]-Z
MWf7+,0Va</0OY9LL^^Cc1T<_LUS0Y=+7ebd9P8.PDAY-?<1caTX^W+MA]8842)R
9;9;D01.Rde#KeGC,D;T82^ZCfG7cAd+:M;/6b.#+XJgH0C\A9fI,>eCEG:XF)X-
Z8X<cUV-_O&.PRC&>K8fN:bO@STaS_HYV\:0.LD-eZ4U2K)+HJ<15.eM3#Z47eBB
<UP9D#e.DFKV2aK<@F(eLD,^.0C\]S+H,Qf]6<CN-;eHA,C_HT;+;OBEdUL?RB^c
0RVJ5g4>S,(3LHc;<DaJ?D[QLNKZX,]f=f1)_,=?<(6[_6OU]Pd#>WTVWI_>b6.#
^8LRKF(?KF0S+L><EeO;=NbaEUQFb0-7Z)>C_>_A\MEe;<[&T#C&M]XR?A2G]OCG
&^ZM.WQ>^L=]Xa5E0cg>Z8c&])LF6:CbHW_H#/7UYDF0-NX1\V/XCKKP9@FPFbU8
_8BgZW.0bJA,;:8F7IFS3L#JKU3Ig\Ve6(=V#GWRTP[OaLX(>HeN6\2d4VZ@P#PE
V74;7R5>E=T\8KfO_Y.6F9BdM]I+&NS(3Y[eH#[f&MANc;f75Fbf-.9dMBDX2Wb#
PKTLV4FWeE\H.K^_)#62^CgdIR>(UTNXN#^?ObLL1MA(9_E:<Pf#ZACI4L4C.5fc
KITA1@2:]WRN#cU^&-/cJ]61Z,YWX.X=;QX^T09]&UfM4J]XTCRdED_@d_]6KKHO
&X<1Y1,UIG_:DQ#+LP[N<[K3JeQA_Y9G\Nd2T\[^<=Hc-,]XD2)@NXM@f2(c&=K^
cI\OP>&[D(c<B(UG:D1V/W)G9VR_4V1&YOK]QYG9<3K;^L?+H-N+@H[Z)H&Zgf;L
fD?0:R1gWa9A/XJd+3bSP^gVaU/fAe0<#bM(RYcN<SYK4JQ.RfY>@>Y3)8K5e+c;
X17/Q7<Y6b.(0b^/PORfgO&92,b\AKUCA?DL\.WPCf&TY3TJ54_P:dBS015Q7cXN
_FVg4>=17U>1HQaX?21;B:/56W?e]NH=\\-d.2?2Fb&NE?0[MQ[g8K4D00PTRb+B
AF=Xa6IcYdg2,?E7I\D5@)&.b^67I/]@_(B5W,7;&S(NP;FZ#<bRAE8N&,;]3/g/
6:#O1G=FFF@YJd0d3^]HS>&J=/@\T2]T#X:8NHO7OT;5RB4e.NG9),L(Oc]_L=KV
#fB\R6^76eVA2PWf4QaSff(RGYP1>N&EY??5M\]?7=T21J)J[A5<XW:FV@3fDS@A
[cTZCPa[U_8)W7F]CW[[TN(&H^G;F3<3-I?O2bWICbA4gD=#G)XRb(-5UB>7T55X
I>E>WRE4?dKNFV.TY#4Y66NB\<D:6LNRX2^]Sa)7>)We87RDN+HFfN\cTbZYcIPQ
5/f:BHKYPB;fR.]EaLI94;=JgSRa94U[@-e9-44SaV3eZ:fN76R0XgJg<0RN51,A
8Z[\IH-.gJ4EIRcZIG;SF,XZc]ggbC.<1fcLT#Y99_bLB@O74(&\-_W2\+NW>F@?
C_W91bT,B5<WY84#-0[/bN9>aDIVTd9UccaOTgU&B0>MZ/X13PJX1-\T6e3:9Rg]
10P?M-5Q.V5V)acHI0(Z,<K&XT6dc.Y@5;_:C\,<RCQ0:+MCK-+U]#:dKK:)f^O&
W56gOTCIF[?fACVY=?f7<8^/=Q5QQ9eBcVG(PN/#KTV?T9<^XeGaG=\ce@BeagRb
V;gCVW.CDN;;5EgW\0TOAcX&?CV?IF@Z3WO331=A91-66^OfGK2.-RP-HPB?7+[4
3M]1+X1VG.;))\Y>gb#E)I;]2?4>bcS<[VHN32fU4KAI<1Ode@]gG=B1/b7#E?/0
@;S]?E3Qe3g]7F_N5,cWD=A6=7Uc950>.e-VM#+H-GB.ESU2S\Y(+WOfefS;Pg\b
M;c]]a#SSY-P<=C:[VE/dNQS=cg&ZcD(c(54>V6RWgf>3/Hbad<FL7Y>,F?#eH^=
^P8BbN[1eQ;]4SLD71P_FHT5AebYN<0I@7OC_7MaMB:)e9+3E8f9--0gPGP#aV]4
[NURM[c.Oe?D9Q>a9^CNH&V2dCH-X[7ePNa.NLDTF_>]&+f74\(F5U>\#NHG:3b5
-KU/.:(,&T76Zc3gSUeZbYZgIVHeN)\,LaR]A8G9LeI0-&R37QLKgM0E.GS21IV.
L.4cX0Z9#4_8&.S]KYeF>J2X9IJ?;B.aUPY\3APfU/SJ6KH@DK>8)V(R)\aEcR\V
^HZ@Z<KO-_+b4[;261Wb_Z<(A(UC=EdQ]:K;[QYGcCg+N;),+I8ae.9B3YHVaf7b
;9AE)gZ4ed5SGaZ?T46CQ1RfU3YE.[>Gc,NCc4XBO?L@=&QTgF^L08YRO6P^d/&b
SXCg+FU,2e,KQYJ#BG2,)g1TKJGBZ2SM[\L71;g#MdbJgg-A)SHC)0-8AOeVN5Xg
]cYUUWXbCdZTV7SK(EC&JZE/(.]aYI+#PCK\N82BZCO^,<JRHV0?L?BdI[NMTE_Q
HMT\=+[=?Wc;8F)a?2,@PBOOGKT^(G;0LZX8HgX+]V0EI@\fE9JdTC1)QgLGTPG:
:D+P(R_6eJGQ8b(UbQ/<<W912,PRGQS=S,/+?>9G+TgFDaWYMB=M=?Aga&_KRTA^
,8^Vg\E&@RV2;]?ZS5G.YVKZKF5/DSHMNP+M?5<54M,/=V#ae5.M&c7cfEW]P9>D
,Fb\MeKE4FTVQ6OP5YS/fbZW](=L<EUQgV(TOH.4/7C26J/3I7WYM,)>:bXXRCd:
C_V0P0:Oa>:[]eHBSNV]5SL69P]RB5H;,]4V;MggYOQB_NIc\[X7QeA<WU3;#-)R
2;456NE0-IKY[JKN.P=A9TT+b(U2TC/]?I65T5dE:XDPcdKX<NQE[-R7bY9>c<>8
#???WN;N<_d6=[e\X=3&c7]N2-f2QY:f6fO]JNQU8#/?7a8D]_eU(/QcK4<5@B[E
<RW=\6#.BX;>H0[=g=[U^b\OR.?<=PHbGFM/F>=Wa@N=/;OYT:SJTINI>P8TY<;Q
9[F_7C;CC8+4EMPV:6>MAX9J6/_fA+=BAaTHFYE6VJFAaF_FWL+;FGg=A,^]OU[,
@1>d#(Fd,;?P8=5dS\]DY&1A<a)^J>406S5[<f8T5&gYLA6fRb^cRL-12aO4e4RZ
501bUZ>50F?9>T-H;PXfaQ5PdK8DJ/QHE0M_E[d^RT_SKER-]/e>aC^OE?E7K>K)
\D@#IaX0\I[cE]2L.VT+=NO6,//,K+5V=H41MH<AX0>)8@f60XLA7A<Q1eNc8-&>
2cC\&LTK&^Z;>;WQH1@b+(-&-g?:O+5WbI::<^](JG-B;JY\ZIf&b9^66<eBb;L&
cMQ?;2e(+Hf\f,W=AD7M3b,ZdE3;CXB.cd\UNQ9UOLV=A;FQ;d-UM;#T>:6]2=9d
]>.S#e@]+Y?4+<B>6[Bc1.c\PUN-QIS8bSJ=8=F60<)<3J/I)S/5cN+cVK/4W5D1
X.e4B#e/Z8+UON6M(JQcL#0G8^:F+RDM+GYU)?XO)KI3[c.8P8\@aH4U/RN\T]AM
5P@G7bO4\7)c9/M4g:RaIFb^CYXe:J6-PY44/3S\R\_d:FbNNc>?E.S[N9_CX80X
KIa6f4:F5]aO65H<=(OV0IFW[b>IF/;.=f]eQWJM&6U0:9.,Pf(MO=/8#+0d(f&0
(^6/\F8GS1bg+IYFZ^>N1@^?I([C0(Kc=B03)b).Q]OWTK;O8gN;9#g^-e9/6YWF
PGU5\7;-.7HRN#b)8Q<YLN^::4O8.Y)?G5=LNNZ4<dB#VZ-e:5dZRb2cGVP?P&>9
[/B/H3M/565:MU.Jc2U72WeL0I#eF5>WLJACK2[DbM0O2<cJ\,Z-AYAa+BLO4&[I
f>X58#/aSM64eTQ625C#I.-45C1^C>)17:[8AAGD,PX08EQYFZ+f+JH65>IH/cM-
FG.8F9EWRGR]L?-I^D_.BI+17?X:3J;XSE2R>Y@RB8Q/a9AN@>5>1-W,gc5c5ceQ
L9A,ce-QQGJ_(d2?OEH9][)Y+E;A4\gINOWCTWK=X5K??R0SE_C7.<g/c<HU\^&R
fLWH5(RB@fd_=37ed;eI>>OL\T:I\YBY+Ob,+IZg8+^VeGDHf7a@?BIM(U7T:Xeg
(3/+^F3HIa&JV6P(a4aL.d07#NS4>:WAZbR.8A0O-4VW.1+IagT[U,UPYIa^HU0=
,T8+QbdeYb/7gJ2-C.d1f?^K86KVZ-V.-,4d6V5J4[aeP^95PL9?\ZQX@/;R>M>;
_G4?#@+VO:;aE-SC&5(<U6P=)\3;\e-Y-@P(P)CJK;60R(<_Se^b0,?MN2K5AJEI
_E1>Z)908/M8/=./#B\2[SA42=ffSbD11EbG&M;,:T[E)-FLB6M&MS4\(C(F_6cc
dE/G34.CD^7-bDM4?Q1\OJQ[2#X;LZ27]eX-f_G+d4G.?&7eF.>8G._a?1KQd,##
BgO4OFY2aNJ)8_Wg[F&M4Jeb)[QACYD(5:N^0>6Y:8(;^Q[URdX0c9#g)]Xd5abO
@_EZ^=F3dG23RW7B#73F@7@#[a9QEG+LD;73(b0T[1&@->f:#WK3.gfL_a]PfQe6
ZKT-:7L>)RD;D^(97?6d4ScW2,6bO,eWEg9e/B??EJ6g#?#]8eeP@UbBe,VX43#3
E]MBI>EW2(AR[TE2<#6F-b=8-U.=O@N908]d0gQ(9K49/D><ADYFXP(cLSb8LE@U
/RBDIIIIF]EHG?12Y)KXGYW_LS>5U4.5fW1RT.ZG]EdJ#33U4aTLL910WPNdVY,D
7#X0?6B+\ME/TI2K+7E&]9GP8g:^MXRF;[gWg]V-Bca&a,d2#gd201F_2#5(gcEG
ES>O;TaN8T:g_+0>\2Q-]372e:8Ace>2fZ6SR>6&VQN@gEee6:Z^(NCgEc/d?1IH
@dTX5]LM)[;@S]6c^ScM(&Xb#Z7=a#]9bC+:34&>&[Q>/X4J,O]-;OOL3gJ^a4P^
_4--_UM5L5b.QZT@>S,TL,9^[6(CN)WWe0GM;T?]R4c7.(_4SL?5//KL:B93F.aB
:adgH&B=[&5)@R,3PYJJ&&SQO:8dKI&&L9ac?07^B<cCH6Z4NY)=Be[O\,G/28.#
,OPQ]I>_KX1>fe?[\ET#TM76.KV5\a1d[-NfK3N:e:^AZNW1LB<0(9a]^f#QcLaL
-?Ef-f4[+bERA.[8F;C+13STI8961(ID-)P29PXWCWDG?B:dd0(a#I]UC,ED)ASI
8bM:RH<-33&U.=V)&LF(TF9J^cGP>XZ(JJW918^>2XP&+YUR@?M>CF9JfZ_dC6#-
6K(<F@0D]GV<RGEF1)BOg.T&fbSUX,EbWGS26?#EH3UT75bDOe7YcYI-NHR/]N(8
@/C/5QN=&Q3E-;,XEM/fYO3eb_fd@FIGC\#cMX&XZN7YeEFFKKX6RE=a>Q4V831+
=]XL]WWE@cK)4aCbVJG2aC&M^7.G5bg91a-d=7ZfP[-1.]d)3\N1_6VJ<9;^S;^5
&W96]F[EW^2Ea&10IgV8ZC<HW>N36G&LP0?A7,LD:aXD^b2N[I1Y/G)([CM4M2[H
.=HP[McgQ,aVJcfSQ)@04.EZH_IVV+=R5/,cO,eW&Hdb^P=RU.Fa2FXK0Xc4\bAX
(22&:4OV[f-FcN7WO\+^I&L4AJV^8Q,^EP8f02+AR1:)3LLX.YG[RIV2;#J\L/C\
L9L/N.7cL_0^C3BTe,?:I3P(aSK,3RQX)agX8-4-[[gCKO>e@c53HQ/L9;C943[K
U^/&Za\.G<2KEQ1/<Ea/U;H@^b;]c]IUG3Fd7R3<5JdZFKeU9M#B/J.#K--2=;3B
61\[ECNa2C)OKc0YTXPGV.^B4N69D5P6KUB^2UBc1Z/.K00N-DHSeATK?^B.e)[(
O5,G31,AEV>4EcGQS50S(f<SINbg0>Z@OCaRY9M<A48B1e+R^1RQ7dFJ-(&@,?G\
#fEGN0=/2S4BT\f^Z(/>\ST=Qd].Y#^+6[;TE]U;0_9Z+b&]QIZgdSM1/3G1HM#N
XQ>67)\cBEZLOE@?P.DR;X(=L1<g-4F^5</O&g&\+D?Q)=[XfI^7]ENMfQ49cS;@
(T4.f>@1^A14GbJbMF#g8;Sb(JVCQNG;E_8[PSB.b<498EZ02AXC:2TP]Y/SXFg\
]DDEfV\IR,>7)6=I.V6S2gIQZ0H9b<I3?,e,]#85<R>#Y:<=4cQQ7/DAFLTO>FNB
B(/+=Ia@^NfY4^:S:0+U^G]+&HRIC;(7HeWF9@9,)S5-37Nb0O]1B2d:B=GbDbMY
;?0Oa(UQ>9Z_<Y<f&0;8>d]+4$
`endprotected


`endif // GUARD_SVT_AXI_PASSIVE_CACHE_SV
