
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C5EvNORP36RnDxG/patX3eqZtv2ohU6ELOlhJcRASpr48DItQ/Vqa1SQ5ePE5kIj
jCa3vx4oqB/EPYzAghlbZGqudHOt0AvK7DS9j4klIBQGyh2C/2hVABCyIzJWnggi
F+yeddJTNsQT0T1DtxEkB9Ljj3rqhN9onrYJvzN48K8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 750       )
WIW+oYHMTGt54snAsLkUH2j0FXyxBvx8TJjR+SayFolYbQCJYQJ3v14cyfCxvdDL
60vACCb0LxHWiwkgHZ6sC24N8vI1YKhpTMNy1Yq6pMJ6jKC6zX8kv/TjJ1L8K9Yx
YDBSjunpuDsvem/KB9JLEWTl9K/gU9BV6PwwAjeirc7ZR6taR3neFEwf/QhMJqP3
0d8235Nk9wOTxQtKlxHN2jc58gZTzGUZv7RXrfjra+12p0n457SjfDuz+GNQ+/rt
o6478dvIQyknLU2yWBQfHt6jKLflQbN9Aj+M5E4FdRiDLh9mORyjwfJzVm8ZUDup
c+0KG26EKFFUdg1nFeIku0q4doOzCsN633Zv/Zo63SRbkdr92Sesqlge3ODnOfeG
J0Yd+/h2LBLAwR6Yfh1xZg1zEZecceLeUUWt/D3YstI4rB6oEIyerfsAjWAgDZA+
g+gM020xI4zPiZluWm11/94eQNkuPymcztrqHfOBC3cP+TRCFQFHWtJReeqUmrwX
/8EY5OtAn/8NJM9brDCsdjmExTwWobQq5GLWHRVaHAzEL/OTYPqXZ9b1YdMr5bYa
zIuLwxHCmSv8u56lv84heCjsM5h+xCgQgRL2smafiqKHPy8ZF4i98bTJuWxYIeRa
WRedqy5EZU2+RzceAJQazKIUWM1LrozRHxL+yrXkdOOFtMtT4UaQ640nD3g9PW7o
jE3Lj0jlRQ2awmRnedrlZ6AkI/O1f/Zf+X6C2HZkSb89ALVkpHCyF/P8II01P2y0
tlAHc1WDTzP1/KIFeE9vxTdv7PxSqfMz5yjSV7sf02NimRZ80DMg7YlGdCug0m2R
DBlFhZLCkB4UMKG00iTKFJGxvVbvknGM0IDYkgSMoq1/4CAp+TNZKol1BL2NWvrV
lXQsUyAmD/Nha5m4Is7pO3jxuPy1NFUaO/QjIF5jSDmc8dEXH6PeZrX5VM8N++RV
kPB5/WMHn7/jlDX/rPd7PMtIU9nJuUKI7djbnIrdEPA=
`pragma protect end_protected


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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZZyYHtBPFgkjyPgHB2v0Q7sy8zwM3NDUDdT6sTaCtJVWudf2O/K9rFTM3V14Lcmc
+cXsSpUM/dkBweqaJZmzCVb+KB2c4IDGoWy7Y57QiyoGmoyTGTITT6UOKv8P2lEv
5BObw2iXnau1tGfVNF4j3RwvXqjx72tNNQsk7UM0oNY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 833       )
mZi7IqEzNWPy+J/fqO9MEYBBH9xEehMhTcIi5vbzo+fEhcoNRR8r5EGaGgORvh0l
1FpJiVsdXssyfT2KC/Bvw6orMfz1HsH85MMzbvrSsLc+MAmovuL7ngp2VcY7yq/T
`pragma protect end_protected
