`ifndef C_TRANS_APB__SV
`define C_TRANS_APB__SV

class c_trans_apb extends uvm_sequence_item;
    //apb_bus_trans
    rand bit [31:0]  pwdata; //data of write data maybe logic will have more state
    rand bit [31:0]  prdata; //data of write data
    rand bit [11:0]  paddr; //address of write data
    rand bit [3 :0]  pstrb; //address of write data
    typedef enum {WR,RD} op_kind_enum;
    rand op_kind_enum op_kind;

    constraint c1_apb_addr { paddr < 12'h1ff;}
    constraint c3_apb_op { op_kind inside {WR};}
    constraint c4_apb_pstrb { pstrb == 4'hf;}  //dut is full 
    `uvm_object_utils_begin(c_trans_apb)
        `uvm_field_int(pwdata, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(prdata, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(paddr, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(pstrb, UVM_ALL_ON|UVM_HEX)
        `uvm_field_enum(op_kind_enum,op_kind, UVM_ALL_ON|UVM_HEX)

    `uvm_object_utils_end


  function new(string name="c_trans_apb");
      super.new(name);
  endfunction: new

  extern virtual function void     do_copy  (uvm_object rhs = null);
  extern function void     post_randomize  ();

endclass: c_trans_apb

function void c_trans_apb::do_copy(uvm_object rhs=null);
  c_trans_apb cpy;
  super.do_copy(rhs);// Copy all the UVM base class data
  if (!$cast(cpy, rhs)) begin
    `uvm_error(get_name(), "Cannot copy to non-c_trans_apb instance");
    return;
  end
  //Add lines here to copy each data member.
  this.pwdata       = cpy.pwdata         ; 
  this.prdata       = cpy.prdata         ; 
  this.paddr        = cpy.paddr          ; 
  this.pstrb        = cpy.pstrb          ; 
  this.op_kind      = cpy.op_kind        ; 

endfunction: do_copy


function void c_trans_apb::post_randomize();

  this.pwdata       = 12'h5a    ; 
  this.paddr        = 12'h014   ; //0x14 (mem_addr), 0x18(size), 0x1c(rd_cfg : stride,id,sif_ch:0),0x10 (rd_ctrl:1) 
  this.op_kind      = WR        ; //0x1000+0x14 (mem_addr), 0WR           ; 
endfunction: post_randomize

`endif //C_APB_TRANS__SV
