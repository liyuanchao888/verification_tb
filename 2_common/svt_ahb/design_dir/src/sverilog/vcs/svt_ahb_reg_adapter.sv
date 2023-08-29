
`ifndef GUARD_SVT_AHB_REG_ADAPTER_SV
`define GUARD_SVT_AHB_REG_ADAPTER_SV

// =============================================================================
/** The  svt_ahb_reg_adapter encapsulates the master reg transaction class, 
 *  This class contains the uvm_sequence_item reg2bus() and  uvm_sequence_item bus2reg() implementation 
 *  for AHB which converts between UVM RAL transactions and AHB transactions */
class svt_ahb_reg_adapter extends uvm_reg_adapter;

  /** The svt_ahb_master_reg_transaction is extended from  the svt_ahb_transaction class, with additional constraints required for uvm reg */
  svt_ahb_master_reg_transaction ahb_reg_trans;

  /** The svt_ahb_master_configuration ,which is passed from the Master Agent */
  svt_ahb_master_configuration p_cfg=new("p_cfg");

  // UVM Field Macros
  // ****************************************************************************
  `uvm_object_utils_begin(svt_ahb_reg_adapter)
    `uvm_field_object(ahb_reg_trans, UVM_ALL_ON);
    `uvm_field_object(p_cfg,     UVM_ALL_ON);
  `uvm_object_utils_end
  //-----------------------------------------------------------------------------
  
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name= "svt_ahb_reg_adapter");

  /** Convert a UVM RAL transaction into an AHB transaction */
  extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  
  /** Convert AHB transaction back to into a UVM RAL transaction */
  extern virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
endclass

// -----------------------------------------------------------------------------
`protected
dT@L=(QN\;Ig>S6R?^TPC;4+/^RV&:XRe8CJ8Ca]eDN+ES)#ge2d6)Y@V5O,X\b8
bDY^:fcdRU_Y3>aTLM[Y-F1OX>7ASIWN-(F1:1YeJ_MA0+)TZgb9e4HZ0_3J2;VA
AeI.)Cb>=_-9_?0MK7X:He?JKb-?-gEWW&>e+N;I,&)-LbD8B1V_=1Y6A39.W<aM
eJLUW\fcVAWA1:]CT</_MV7HZX89PNRY,8?SIddYOT1g-8^IIWQBW]JI_6/e0XcY
a&4aDIgT]&/LG>,TdX0)f5\dE>,4Ac]IcO//X:PT>a/9d2-L3.X&>/6\))RYg+K5
fA:VWagPO<,53>EM^Xf87@/J>M8P#9DaZE,9Pbe:#TfT19e#36Wc,EA[f9Rf76[0
B#_(/ZaZ;],5*$
`endprotected



// -----------------------------------------------------------------------------

function uvm_sequence_item svt_ahb_reg_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  bit [31:0] burst_size_e;

  `uvm_info("svt_ahb_reg_adapter::reg2bus", "Entered ...",UVM_HIGH);

  ahb_reg_trans = svt_ahb_master_reg_transaction::type_id::create("ahb_reg_trans");
  ahb_reg_trans.cfg = p_cfg;

  if (rw.n_bits > p_cfg.data_width)
    `uvm_fatal("svt_ahb_reg_adapter::reg2bus", "Transfer requested with a data width greater than the configured system data width. Please reconfigure the system with the appropriate data width or reduce the data size");

  `uvm_info("svt_ahb_reg_adapter::reg2bus", $sformatf("n_bits data = %b log_base_2 n_bits", rw.n_bits), UVM_HIGH);

  /** Turn the TR burst size into an AHB one (smallest burst is 8bit) */
  burst_size_e = $clog2(rw.n_bits) - $clog2(8);

  `uvm_info("svt_ahb_reg_adapter::reg2bus",$sformatf("n_bits=%0d, burst_size_e=%0d",rw.n_bits,burst_size_e),UVM_HIGH);

  if (! ahb_reg_trans.randomize() with {
      ahb_reg_trans.xact_type == (rw.kind == UVM_WRITE) ? svt_ahb_master_reg_transaction::WRITE : svt_ahb_master_reg_transaction::READ;
      ahb_reg_trans.addr == rw.addr;
      ahb_reg_trans.burst_size == burst_size_e;
      ahb_reg_trans.num_incr_beats == 1;
      ahb_reg_trans.burst_type == svt_ahb_transaction::INCR; }) begin
     `uvm_fatal("svt_ahb_reg_adapter::reg2bus", "Transaction randomization failed")
  end

  /**
   * Collect generic data and send it to bus.
   */
  if(rw.kind == UVM_WRITE) begin
      ahb_reg_trans.data[0] = rw.data ;
    end  

  `uvm_info("svt_ahb_reg_adapter::reg2bus", "Exiting ...",UVM_HIGH);

  return ahb_reg_trans;
endfunction : reg2bus


// -----------------------------------------------------------------------------
function void svt_ahb_reg_adapter::bus2reg(uvm_sequence_item bus_item,
                              ref uvm_reg_bus_op rw);
  
  svt_ahb_master_transaction bus_trans;
  `uvm_info("svt_ahb_reg_adapter::bus2reg", "Entering ...",UVM_HIGH);

  if (!$cast(bus_trans,bus_item)) begin
     `uvm_fatal("svt_ahb_reg_adapter::bus2reg", "NOT_AHB_TYPE : Provided bus_item is not of the correct type")
     return;
  end

  if (bus_trans!= null) begin
    `uvm_info("svt_ahb_reg_adapter::bus2reg", $sformatf("printing bus_trans %0s", bus_trans.sprint()), UVM_HIGH);

    rw.data = bus_trans.data[0] ;
    rw.addr = bus_trans.addr;
    if (bus_trans.xact_type == svt_ahb_master_reg_transaction::READ) begin
       rw.kind = UVM_READ ;
       `uvm_info("svt_ahb_reg_adapter::bus2reg" , $sformatf("bus_trans.data = %0h (READ)", bus_trans.data[0]),UVM_HIGH);
    end
    else if(bus_trans.xact_type == svt_ahb_master_reg_transaction::WRITE) begin
       rw.kind = UVM_WRITE ;
    end 
    /**
     * Update the result of the transaction.
     * Update the "uvm_reg_bus_op.status" to UVM_IS_OK only if response_type is only svt_ahb_transaction::OKAY
     * else make it UVM_NOT_OK
     */
    if (bus_trans.response_type == svt_ahb_transaction::OKAY)
      rw.status = UVM_IS_OK;
    else
      rw.status  = UVM_NOT_OK;
  end
  else
    rw.status  = UVM_NOT_OK;

  `uvm_info("svt_ahb_reg_adapter::bus2reg", "Exiting ...",UVM_HIGH);
endfunction


`endif // GUARD_SVT_AHB_REG_ADAPTER_SV
