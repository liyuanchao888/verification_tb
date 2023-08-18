
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EfsHyJaoTGofKctwfWaqGR1cWRXwnO/IJDJJR4bQjjgmqmybpuRA+xSoA6bvmoqo
Iy44uS06pOsoKYoOGnnNkdrO1O7Q3jK5apveINksjEozrKWI/Je5JxVtJ5MBmK8W
Sd6jcK/Fyb7HO0hSbAKMxBbXGYupFiRtmjBP3xC0o/M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 913       )
yLL8w5IPDeqXqr8D2GI7fa1DHaUhgvZLbIwqTUh2kc2nujQrYRk6pujIS1zkY1nM
jTppapJHSjnB31xYHZ0eluXR/5EOcv/z/Xegs6qPiOohqq0w/TbOGohHEwDxlHre
kW6fS70ArVQVolzIMfE7dqruymNc8S5+TlHslBuPPh30TpbHHkL3Wr/MX0GEPJfr
aEQbkSh97vO69NsmR4qy34VFH779u0J+gT2UZrQ2LJE7ASECxDQv0MmujC/SZDO9
BkWmXz6CYYoIW9/jcYNKNX4F/g6235DXk7cnA795oayXRd/bJdYom27IeORDu1ql
YYlpCxYPmRXrUXDUcVhjw1clYfHRgZ+3uI7239Ip07efCKPWwmy38TgO0TcvNO8S
3j/JpxnAhEaKopJlKyLDi6MYXny4LPeQzM1NnP0T6vCGdecsDtPr8O/DFAiZHFUp
5d8S9aOLitAn18vmUwvyU9q0dEk8/2gMY71gClAQHSs4VjUToGNXlFbVoyKYMgcX
cpb9q+A7uIdXoeXe/G9J9pzJYXF+Kx9dZGFCXeLEnfubTr+uE1w+WAfZG8minuRz
b4NqWaFugp6+jsqvfg16k5//yRsm7ISFhkBllqHtLue8nCNZUE0YR3lrzaAzx+8q
PMaZHEQ9oyFuijUAzv/6fvfnDa8ramr3sfNHoh8IDr/r1BAw8e7i/9s7H8RyruLq
dpkN5W0g0h0WOtnJHGlUWr9pRa1DEwCv/bi9H/ceTDh88arO69jdLoEBK2JiShaG
lA0VZV/SXxDCt4gApN49TX5pJx7SqYr9uI/lxhTE9s1lBOeHLWOGSURI4xZRQoB+
5PWJSfw/g9MQHXkN8R6z2kcC9CH1V+jiSoch+Ao2DG+NQMrFUjtWfgfBJMEYActG
U5CgqaZ6GbrbrtrGhcU+dL+mAWf3Ow4AxW+pln3dYv1PCQfPGceiyhFf01ZKO/sb
Ak3ucPvsT1CQ+PK5lfE09VlBvO+pny/lwQwZBahzoU0sHQICU1RULztI1FCAOuc6
3Ur2iihwQohbWGP2cP+i+wuLMWWxGjL793lZWberha7Nc5ByZwIy0+JOTGkFa62j
eXIRy3+OwCFT0RbRy35/QSlAbtiL2YMJMV4rD2JmIJrVP1lRr8tpjraMD7Dbdoe7
1QekD4A68zBqRw2sK46zK56xeuC7KMgScx5XcdLjhZum2l7vVSEz2fnRqoI/8YDA
mIGy5TNCGqZF2CFbtPnq2w==
`pragma protect end_protected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IEP3T8AyPWppXVz6EuFw1SbEjeqcG7nC63h6IZSE2B+tM4AFNkWdlQAZ5o9JcJN+
N3xZTQYo83ZG7qEtXkuvpQK66+EQPApQXSE4aO2e3+cmGuzK27x5J+kngxRc4Gd9
EZbRKR9PGX0aJx/CNFHJ7ncNTaC+VhMVqgbz/jJNFjs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8865      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AXI_FIFO_MEM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XEJGFsdaF/C5xrMHr0df0FfT3cGSlk9kjrkk7L6d2CaUuKxxM9kEH7+pdKtCatW5
P1NGSiPaMVUJffDraZ9/X1QkcA5bB9uTEwLiP5wtTLIpBVCyZ4/Ar9FyXLA5yAn5
aYvW+H7U8qfEWPq+kKxtGSOYTUeP1EncDVuO/Ci8FK8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8948      )
vi9IGHPTPeCCquQO4oYW0bDlWakqiRBbPbXC3AsWHKrF8G7ml3mATUffGukXyPzR
6w+2Edy9s8vyF/7dUneJcQw2X3V+q/2RGaqeQkyWxdbOe4NGD/teCd5Bpk4t3UiA
`pragma protect end_protected
