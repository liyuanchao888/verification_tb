
`ifndef GUARD_SVT_APB_REG_ADAPTER_SV
`define GUARD_SVT_APB_REG_ADAPTER_SV

// =============================================================================
/** The  svt_apb_reg_adapter encapsulates the master reg transaction class, 
 *  This class contains the uvm_sequence_item reg2bus() and  uvm_sequence_item bus2reg() implementation 
 *  for APB which converts between UVM RAL transactions and APB transactions */
class svt_apb_reg_adapter extends uvm_reg_adapter;

  /** The svt_apb_master_reg_transaction is extended from  the svt_apb_master_transaction class, with additional constraints required for uvm reg */
  svt_apb_master_reg_transaction apb_reg_trans;

  /** The svt_apb_system_configuration ,which is passed from the Master Agent */
  svt_apb_system_configuration p_cfg=new("p_cfg");

  // UVM Field Macros
  // ****************************************************************************
  `uvm_object_utils_begin(svt_apb_reg_adapter)
    `uvm_field_object(apb_reg_trans, UVM_ALL_ON);
    `uvm_field_object(p_cfg,     UVM_ALL_ON);
  `uvm_object_utils_end
  //-----------------------------------------------------------------------------
  
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name= "svt_apb_reg_adapter");

  /** Convert a UVM RAL transaction into an APB transaction */
  extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  
  /** Convert APB transaction back to into a UVM RAL transaction */
  extern virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
endclass

// -----------------------------------------------------------------------------
`protected
Zg\eP5K?b8e49QFJI_AEVbYI=UDX_gM>9A77UY(]<4f56a\92S847)+0_ecIAC\;
@XX/S)Z^Y+JA;-M#HNB,cW=>8AI_(;R?UVAQc7bG8?4QTb]2)-:?FM30(bZX#MEc
EJaR]_Z:_0F@Wde#UDLf2K>_7FO1Fc9&#+<Y))K_fXM[L_4F..^]WY6(VO2SI(@S
&J_QHYSK)9Ac?5QMa6c&]5[+595VNQ(IM=?.D@SOFF]:I-VVAFCba<9>B0:gT)I)
.8c+W(g7/Q?0c#+a<<RLK36[_1N<:9IZ=#b:P?0P:(MB#)_\E@-P=_RMA&cIPU33
R7N\(aMX.e9V;I/FIOX)fgM3UL9;K#Cb[VTdEH:H+AUVP+bOEdJUL0X55L_8STO(
^O4Q8L<M&DdV-$
`endprotected
  


// -----------------------------------------------------------------------------
  
function uvm_sequence_item svt_apb_reg_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  bit [31:0] burst_size_e;

  `uvm_info("svt_apb_reg_adapter::reg2bus", "Entered ...",UVM_HIGH);

  apb_reg_trans = svt_apb_master_reg_transaction::type_id::create("apb_reg_trans");
  apb_reg_trans.cfg = p_cfg;

  if (rw.n_bits > p_cfg.pdata_width)
    `uvm_fatal("svt_apb_reg_adapter::reg2bus", "Transfer requested with a data width greater than the configured system data width. Please reconfigure the system with the appropriate data width or reduce the data size");

  `uvm_info("svt_apb_reg_adapter::reg2bus", $sformatf("n_bits data = %b log_base_2 n_bits", rw.n_bits), UVM_HIGH);

  if (! apb_reg_trans.randomize() with {
      apb_reg_trans.xact_type == (rw.kind == UVM_WRITE) ? svt_apb_master_reg_transaction::WRITE : svt_apb_master_reg_transaction::READ;
      apb_reg_trans.address == rw.addr;}) begin
     `uvm_fatal("svt_apb_reg_adapter::reg2bus", "Transaction randomization failed")
  end

  /**
   * Collect generic data and send it to bus.
   */
  if(rw.kind == UVM_WRITE) begin
    apb_reg_trans.data = rw.data;
  end

  `uvm_info("svt_apb_reg_adapter::reg2bus", "Exiting ...",UVM_HIGH);

  return apb_reg_trans;
endfunction : reg2bus


// -----------------------------------------------------------------------------
function void svt_apb_reg_adapter::bus2reg(uvm_sequence_item bus_item,
                              ref uvm_reg_bus_op rw);
  
  svt_apb_master_transaction bus_trans;

  `uvm_info("svt_apb_reg_adapter::bus2reg", "Entering ...",UVM_HIGH);

  if (!$cast(bus_trans,bus_item)) begin
     `uvm_fatal("svt_apb_reg_adapter::bus2reg", "NOT_APB_TYPE : Provided bus_item is not of the correct type")
     return;
  end
  
  if (bus_trans!= null) begin
    // assign apb system congigursation
    bus_trans.cfg = p_cfg;
    `uvm_info("svt_apb_reg_adapter::bus2reg", $sformatf("printing bus_trans %0s", bus_trans.sprint()), UVM_HIGH);
    rw.addr = bus_trans.address;
    rw.data = bus_trans.data;

    if (bus_trans.xact_type == svt_apb_master_transaction::READ) begin
      rw.kind = UVM_READ; 
      `uvm_info("svt_apb_reg_adapter::bus2reg" , $sformatf("bus_trans.data = %0h (READ)", bus_trans.data),UVM_HIGH);
    end
    else if(bus_trans.xact_type == svt_apb_master_transaction::WRITE) begin
      rw.kind = UVM_WRITE; 
    end 
    /**
     * Update the result of the transaction.
     * Update the "uvm_reg_bus_op.status" to UVM_IS_OK only if pslverr_enable=0 when apb3_enable=1 or apb4_enable=1
     * and when its only apb2 i.e. when ap3_enabl=0 and ap4_enable=0, set always "uvm_reg_bus_op.status" to UVM_IS_OK
     * else make it UVM_NOT_OK
     */
    if (bus_trans.cfg.apb3_enable == 1 || bus_trans.cfg.apb4_enable == 1) begin
      if(bus_trans.pslverr_enable == 0)
        rw.status = UVM_IS_OK;
      else
        rw.status  = UVM_NOT_OK;
    end
    else
      rw.status = UVM_IS_OK;
  end
  else
    rw.status  = UVM_NOT_OK;

  `uvm_info("svt_apb_reg_adapter::bus2reg", "Exiting ...",UVM_HIGH);
endfunction


`endif // GUARD_SVT_APB_REG_ADAPTER_SV
