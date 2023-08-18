
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0SPbzLD0dmDj7/GcWNLKCzrAn84d3U5s48KT+ZAL9mbtsa/7n4jRDvDD2LjmZZpq
oeiX1y7V3xA1QXg15H9ZuezIcjeGNxFuSnE4/LjMzNI+RwbxlnOFZ12t8+ob7SmN
RbLlNxquhKD3TDd7uu6UvB1lPVhSmihV02wMVXgDTcUI8/EHhc14MQ==
//pragma protect end_key_block
//pragma protect digest_block
XfqRczj5L5uufL5F/7KsEJ5sUdQ=
//pragma protect end_digest_block
//pragma protect data_block
mz7wLkC5D6/c0Fzerk+vdyvWsaSmfMYqw1Lg5Xr+zWkprKxwNVK5BB6b1b0R4N+w
ek+J8Wb6hSkAOq0g7yubu5WINtczb9Qa/TB6qe2a4owLTOofg5O0QTYpBTKb9fgl
LZMniak3LxXFfs6Znouw8biWon0I1qHTef12LOLbkjFrbBNfy6Fn6Cht5LLwtV3P
kBcOFk+uLjSzplEGKA4AmzkvWQtc/q696EyG56y3QJuwbS3U/OZxs4x3YkdAXXBe
WK3xccpKXnobP8g2WLl66VhwzLcw2O2Bnx2ymi/E7AHi4dPqq3BAhefniGfiqXKq
pDRLqLENTUDosLBbxv57XLjrXRHOBHs2NzHjRm8GSsQY7hITE2YjDnlm8YTY7h/7
H/gfhjqFHyycv9OQOaIshotFFsJTF3e2FuRRrMssCXlfrfg0L59ZR0R1W0uRtxcO
ujYo4lcKXDOsy/DmcvfDF+xcQuir8n0s4VU96tUhoIGtSjaL72HtEwJkM7oMG7ko
241O8QZLRg0WeoRHA4H7QypXbBUKP0W5s81SvXgjbvyrzQHtTC4Bq5/QKBSaK55O
L8fUndj/JQoB1PB/KqP8ExopsBqaedD/KRGlXGja9Qeur4OzpGc741a6q3yxkL4b
K8b9L6VCo1r/i7KGRee5aGVyHBXZJVkUxgWlv8KR8B9i4I4t2im3zFdSMuzKxU9R
n245ivYyf+pXvOVZgrJcsAgkcSixuAC5emRasryeoJiPkvLOw0MpRvXilYop84u+
XNaSzSULBFErfcASn6FMLl9TuVyndPX54Al93eNXiHSJfMb5aIHTNeDqYq3C/byD
tlxOEg3c1/fS0ViLM1iaBIxbv8BaMXG8t32SDblwXIkxQ5GedvpPKN7Y95Y1iJRv
OsiM1eycQXTJmkpU6uubQrb+QMvqD82Vk8mCiZcnSaQDW9yCxTkVY7Q7+RP6QzUy
2yDFMuZ3BHtcPSqrkU5FUd69K37t+bv0V5oo61FV+ewEKCJdNsMZNyP+tTHBpiHA
mCc//Cwcpfi2GPQqd83vVHxIZwQB+pV8wfz4T3HxoL6XaHY9ULnQxQqU6TcG2nJV
MNaLVgtP8N4t6/WMIjbkUGjlhMXCttAymHB6H8DIoKQO3lbLRDaQtrWzQ8xq684V
5q+mRbd6XOssXtat8+2cRVfFva2UuESLx7ekSSikqf3VzhT+pXzFotAmjZvcLmGz
ztwrmIB6Xc2nHdoj/21Nmg==
//pragma protect end_data_block
//pragma protect digest_block
iYFQYEMqiCJlmTQsO1NgumD4kxw=
//pragma protect end_digest_block
//pragma protect end_protected


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
