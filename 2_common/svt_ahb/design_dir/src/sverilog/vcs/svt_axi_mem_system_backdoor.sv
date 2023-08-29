
`ifndef GUARD_SVT_AXI_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AXI_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_axi_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_axi_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_axi_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_mem_system_backdoor)
  `svt_data_member_end(svt_axi_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  //extern virtual function bit peek_base(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]  addr, output svt_mem_data_t data, input int modes = 0);
  extern virtual function bit peek_base(svt_mem_addr_t  addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  //extern virtual function bit poke_base(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]  addr, svt_mem_data_t data, int modes = 0);
  extern virtual function bit poke_base(svt_mem_addr_t  addr, svt_mem_data_t data, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek and poke) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();

endclass: svt_axi_mem_system_backdoor
/** @endcond */

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY
//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
function svt_axi_mem_system_backdoor::new(vmm_log log, string name = "");
  super.new(log, name);
`else
function svt_axi_mem_system_backdoor::new(`SVT_XVM(report_object) reporter, string name = "");
  super.new(reporter, name);
`endif
endfunction

`else
//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
function svt_axi_mem_system_backdoor::new(string name = "", vmm_log log = null);
  super.new(name, log);
`else
function svt_axi_mem_system_backdoor::new(string name = "", `SVT_XVM(report_object) reporter = null);
  super.new(name, reporter);
`endif
endfunction
`endif

//------------------------------------------------------------------------------
function bit svt_axi_mem_system_backdoor::peek_base(svt_mem_addr_t  addr, output svt_mem_data_t data, input int modes = 0);
  svt_mem_address_mapper mapper;
  int idx = 0;

  // If there isn't a mapper for this address, then we should return 0.
  peek_base = 0;

  `svt_amba_debug("peek_base", $sformatf("Entering, addr = 'h%0h", addr));

  mapper = get_contained_mapper(idx);
  while (mapper != null) begin
    svt_axi_mem_address_mapper axi_mapper;
    bit contains_src_addr;

    if ($cast(axi_mapper, mapper))
      contains_src_addr = axi_mapper.contains_src_axi_addr(addr, modes);
    else
      contains_src_addr = mapper.contains_src_addr(addr);

    if (contains_src_addr) begin
      svt_mem_backdoor_base backdoor = get_contained_backdoor(idx);

      // Make sure it actually supports the operation
      if (backdoor.get_supported_features() & `SVT_MEM_PEEK_OP_MASK) begin
        bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]  dest_addr;
        if ($cast(axi_mapper, mapper))
          dest_addr = axi_mapper.get_dest_axi_addr(addr, modes);
        else
          dest_addr = mapper.get_dest_addr(addr);
        `svt_amba_verbose("peek_base", $sformatf("Based on original address 'h%0h requesting peek for dest address 'h%0h for backdoor %0s", addr, dest_addr, get_contained_backdoor_name(idx)));
        peek_base = backdoor.peek_base(dest_addr, data, modes);
        if (peek_base)
          `svt_amba_verbose("peek_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], retrieved data value ''h%0h' using dest addr ''h%0h'.",
                                       get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), data, dest_addr));
        else
          `svt_warning("peek_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], failed 'peek' using dest addr ''h%0h'.",
                                       get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), dest_addr));
      end else
        `svt_amba_verbose("peek_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], does not support peek. Skipping peek at ''h%0h'.",
                                     get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), addr));
      // Should only be one matching backdoor.
      break;
    end

    idx += 1;
    mapper = get_contained_mapper(idx);
  end

  `svt_amba_debug("peek_base", $sformatf("Exiting, data = 'h%0h, return = 'b%0b", data, peek_base));
endfunction: peek_base

//------------------------------------------------------------------------------
function bit svt_axi_mem_system_backdoor::poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);
  svt_mem_address_mapper mapper;
  int idx = 0;

  // If there isn't a mapper for this address, then we should return 0.
  poke_base = 0;

  `svt_amba_debug("poke_base", $sformatf("Entering, addr = 'h%0h, data = 'h%0h", addr, data));

  mapper = get_contained_mapper(idx);
  while (mapper != null) begin
    svt_axi_mem_address_mapper axi_mapper;
    bit contains_src_addr;

    if ($cast(axi_mapper, mapper))
      contains_src_addr = axi_mapper.contains_src_axi_addr(addr, modes);
    else
      contains_src_addr = mapper.contains_src_addr(addr);

    if (contains_src_addr) begin
      svt_mem_backdoor_base backdoor = get_contained_backdoor(idx);

      // Make sure it actually supports the operation
      if (backdoor.get_supported_features() & `SVT_MEM_POKE_OP_MASK) begin
        bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]  dest_addr;
        if ($cast(axi_mapper, mapper))
          dest_addr = axi_mapper.get_dest_axi_addr(addr, modes);
        else
          dest_addr = mapper.get_dest_addr(addr);
        `svt_amba_verbose("poke_base", $sformatf("Based on original address 'h%0h requesting poke of data 'h%0h for dest address 'h%0h for backdoor %0s", addr, data, dest_addr, get_contained_backdoor_name(idx)));
        poke_base = backdoor.poke_base(dest_addr, data, modes);
        if (poke_base)
          `svt_amba_verbose("poke_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], set data value ''h%0h' using dest addr ''h%0h'.",
                                       get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), data, dest_addr));
        else
          `svt_warning("poke_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], failed 'poke' of data ''h%0h' using dest addr ''h%0h'.",
                                       get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), data, dest_addr));
      end else
        `svt_amba_verbose("poke_base", $sformatf("%0s, associated with source address range ['h%0h, 'h%0h], does not support poke. Skipping poke at ''h%0h'.",
                                     get_contained_backdoor_name(idx), mapper.get_src_addr_lo(), mapper.get_src_addr_hi(), addr));
      // Should only be one matching backdoor.
      break;
    end

    idx += 1;
    mapper = get_contained_mapper(idx);
  end

  `svt_amba_debug("poke_base", $sformatf("Exiting, return = 'b%0b", poke_base));
endfunction: poke_base

//------------------------------------------------------------------------------
function int svt_axi_mem_system_backdoor::get_supported_features();
  get_supported_features = super.get_supported_features();
  get_supported_features &= `SVT_MEM_PEEK_OP_MASK | `SVT_MEM_POKE_OP_MASK;
endfunction

`endif // GUARD_SVT_AXI_MEM_SYSTEM_BACKDOOR_SV
