
`ifndef GUARD_SVT_AXI_FIFO_MEM_SV
`define GUARD_SVT_AXI_FIFO_MEM_SV

/** Add some customized logic to copy the actual memory elements */
`define SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COPY \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COPY) begin \
    svt_axi_fifo_mem_copy_hook(this.__vmm_rhs); \
  end \
`endif

/** Add some customized logic to compare the actual memory elements */
`define SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COMPARE \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COMPARE) begin \
    if (!svt_axi_fifo_mem_compare_hook(this.__vmm_rhs, this.__vmm_image)) begin \
      this.__vmm_status = 0; \
    end \
  end \
`endif

// ======================================================================
/**
 * This class is used to model a single FIFO. 
 *
 * An instance of this class represents a FIFO in a single address location. 
 *
 * Internally, the memory is modeled with a queue of elements.
 */
class svt_axi_fifo_mem extends `SVT_DATA_TYPE;

  /**
   * Convenience typedef for address properties
   */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr_t;

  /**
   * Convenience typedef for data properties
   */
  typedef bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data_t;

  /** Identifies the address of this FIFO. */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr = 0;

  /** Stores the effective data width, as defined by the configuration. */
  int data_width = 0;

/** @cond PRIVATE */

  /** Stores the effective address width, as defined by the configuration. */
  local int addr_wdth = 0;

  /** Stores log_base_2 of data width in bytes */
  local int log_base_2_data_width_bytes = 0;

  /**
    * A queue that models the FIFO
   */
  local data_t fifo_impl[$];

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log shared_log = new ( "svt_axi_fifo_mem", "class" );
`endif
  
/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_axi_fifo_mem)
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the FIFO is assigned an instance name, 
   * data width, and an address 
   *
   * @param log The log object.
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_width The data width of this memory.
   * 
   * @param addr The address of this FIFO.
   */
  extern function new(vmm_log log = null,
                      string suite_name = "",
                      int data_width = 32,
                      int addr = 0);
`else
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the FIFO is assigned an instance name, 
   * data width, and an address. 
   *
   * @param name Intance name for this memory object
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_width The data width of this memory.
   * 
   * @param addr The address of this FIFO.
   */
  extern function new(string name = "svt_transaction_inst",
                      string suite_name = "",
                      int data_width = 32,
                      int addr = 0);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_fifo_mem)
    `svt_field_int(               addr,            `SVT_ALL_ON|`SVT_HEX)
    `svt_field_int(               data_width,              `SVT_ALL_ON|`SVT_DEC)
    `SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COPY
    `SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COMPARE
  `svt_data_member_end(svt_axi_fifo_mem)

  // ---------------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   *
   * @param index The index within the FIFO to be read. If -1 is provided, the element
   * in front of queue is read and popped out of the queue. If index is not -1, the element
   * at the given index is read, but is not popped out of the queue
   * 
   * @param data The data stored at the given index. If the index does not exist
   * or if the queue is empty, the data is not valid.

   * @return Returns 1 if the element at given index exists. If the index does not exist or if the queue is empty, returns 0.
   */
  extern virtual function bit read(int index = -1, output logic [`SVT_AXI_MAX_DATA_WIDTH-1:0] data);

  // ---------------------------------------------------------------------------
  /**
   * Stores a data word as the last element of the queue.
   *
   * @param data The data word to be stored.
   * 
   * @return Returns 1 if the write was successful, or 0 if it was not successful. 
   */
   extern virtual function bit write( bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data = 0);

  // ---------------------------------------------------------------------------
  /**
    * Returns the size of the FIFO
    *
    * @return Returns the number of elements in the FIFO
    */
  extern virtual function int get_fifo_size();
  // ---------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
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
  extern function void svt_axi_fifo_mem_copy_hook(vmm_data to = null);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated
   * 'compare' routine.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   */
  extern virtual function bit svt_axi_fifo_mem_compare_hook(vmm_data to, output string diff);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to format a display of the memory contents.
   *
   * @param prefix Prefix appended to the display
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`else
  // ---------------------------------------------------------------------------
  /** Extend the display routine to display the memory contents */
  extern virtual function void do_print(`SVT_XVM(printer) printer);

  // ---------------------------------------------------------------------------
  /** Extend the copy routine to compare the memory contents */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  // ---------------------------------------------------------------------------
  /** Extend the compare routine to compare the memory contents */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  /** Added to support the svt_shorthand_psdisplay method */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  /** Added t support the svt_shorthand_psdisplay_method*/
  extern virtual function svt_pattern allocate_pattern();

/** @cond PRIVATE */

  // --------------------------------------------------------------------
  /**
   * Checks if the data is within 2^data_width. If not, the higher order bits are
   * masked out.
   * 
   * @param data Data that needs to be checked.
   * 
   * @param data_width Data width to be checked against
   * 
   * @return A bit that indicates if the data is within 2^data_width.
   */
  extern local function bit check_data(ref bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data, input int data_width);

/** @endcond */

// ======================================================================
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
vK1zlTtA/LZIBjfhRlkPIbT9FR8onTvwZd5EpQEkb8r2g7whzBGos/fg1LIGaCqi
PbpyUYIqsBWi8VBBmHzxy8fGfrBwYCcj8iwYlm0LWXDB4EaXjZOB0T1ERjn48LC6
rPVO1IdiTHnIOzLeXvf9bKzOUm7ToTQzuczALsTCAlPxe6MfyoNCUA==
//pragma protect end_key_block
//pragma protect digest_block
CE9GDe/KRFSW5oT5c+egKmIFhEM=
//pragma protect end_digest_block
//pragma protect data_block
Wscr0MzrSrvsdeQjxq9XdFQ3OaZm4oJ/2Y+ozPAK4yhSJvH88nnszH+SfZwN0qFT
CEtEHdtDSYKw/yE0c0PX4XdBSGC/ttJwKK4OKl9g/BSNbCt/dOMJI3rwCDw84YNt
RAaybxnZ9hkkTNT98g2O7PdtbHY4j3pP9PyS7EPZv/FEshRmlfW0shF43DyTK/Xw
Evn9dNVPLPwlqQrMp8GDpNx3oWyN6V7LJcHIx5dH2jzaE123grARTJllsmoSfSCa
hjf5o+7EnggIo+XYrDtkf3Cb7aM/NLwnTAwJ5Aygr3cJok/fTsX1kQY5OwyziOUU
2PmN3/RlHW0508C6AH/cBgCDF1yM9mtWvW46rGNV6IdG5UurndyRJB0bP+bWV+uA
e78FNqKBlK9TyCxBwDTGuSYXE4zGyRJmpC9kFO5g92jAy6tk9hmw19WI0Ds5I6c+
pcwIQiJfbGd1NGN+DIxbpRFjBUymM0CNY5U2vghGCOkc6gNJJwlQHi5URhJqKCl3
61C3QAAwR2WadykkBLbea/81sCI2B2iIGzEc3xjYrtx3i0gC6n7MoXaHDz/89GfT
JfPDJpypCivDWA79RUUPk0ql6NEHyo3ToqWu6zsZ8WEKor2Tgpd/iukB0hatuqnv
dlIXcrWAYQMZNJQQtskcm1ge805mAyRjwnWYg/FXpm/Uz79DW8opMi5/NCzF2cyp
AEJUOwWSP2YvtvubB6SwmurGL4v123spyrjPQ3ZRS+YkvqwVIZ/Wf6NUo36kGWOI
6lnaiNUGObtS7CvjtvspZ8uxH+JENfzPgzT7gB9vV614WeXtjygCzzxxE0jeCBPG
SovfcP31fisFDyYLgg/icRFwtP5SsQylkG2yrigvctbdNbcNx5vZHL6dLsmUlM9n
ImRH005023cQ4+Ap4l7J/iU2VBEv6kG80DP60Jtajxm+LlhqaqtbNZUt7RmWueGs
b2pT+zTCoJ1dmJBMA1xxTDMgelaUXXLBUxVJ/5t8NyxjRhKIMCMuiFXSosNBC0RL
IcCtKAe0w3YRMWs2WOprY7PyYrXJaZeUWdU/qQ6ENovbmuEpDNuPNafOvotqSSeH
ZQTXLxTTjpJ5oaCYU6Xm6Ch7sP0nUn5hZ1gGurwdxandDQv77Q+wzmg9VfH0hd9i
MacnBVInWQqvBSiJuazub3CTs+dkyG/cjw+I52pvUXapiUoH27a8ovshxxsH8LRM
nqDFdDjoGeYDlOj+SUoe+BpE71YISgiCAwiVlLXeXerpVa9WBUXKkbZMLlLnOctL
4PQpzV4Vno9JWCUnaLhiEL+yxRF08kM+JbhGiz7bxQQSoBWQm7SbF1noQf+mJjpG
6iAbm1zoricuM8os4Dhg9a12XOBBfpIbVn6RoF2f8jq/zptVnMs27adKrdGy8NvC
55L44OQK83kGSvBhPQIP/klD+0oi8fXbWisYcvnByko=
//pragma protect end_data_block
//pragma protect digest_block
g+rLOD7udMeUOzOzopOeKbDlfX0=
//pragma protect end_digest_block
//pragma protect end_protected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eQDjPtX/7XhiUAGOKS4V3m/+atNoHi6wCZxi5r1RvDOq+Po9vOMAtlsiKOPicC4r
8oBl+8OQuu0gmHblwzaINXzVOTzQRC5xdZOmLO2DOwpsKRZRnaNs8F+dnxo51HrI
B+LZJ69uR1zXtUo+6JAXe2vBY2nQhNaioaXtNwd3Dm5v6lkQXwVAFQ==
//pragma protect end_key_block
//pragma protect digest_block
bjNERqh6sGUosJ2DvvlsjdhxryM=
//pragma protect end_digest_block
//pragma protect data_block
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
bX2OawWOsPBaXEtekVfh9Q==
//pragma protect end_data_block
//pragma protect digest_block
WaiEC7Ip1+oUMvNB6XKjOzQny20=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_FIFO_MEM_SV
