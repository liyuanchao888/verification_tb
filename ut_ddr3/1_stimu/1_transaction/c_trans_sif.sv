`ifndef C_TRANS_SIF__SV
`define C_TRANS_SIF__SV

class c_trans_sif extends uvm_sequence_item;
    parameter dma_width = `DMA_WIDTH;
    rand bit [dma_width-1 : 0]  up_data; //data of write data maybe logic will have more state
    rand bit [dma_width-1 : 0]  dn_data[]; //data of write data
    typedef enum {UP,DN} op_kind_enum;
    rand op_kind_enum op_kind;
    rand bit [dma_width-1 : 0]     m_sif_debug[];
    
    constraint c1_sif       { dn_data.size() == 5000 ;} //258*258*128/4(16bit)=2130048
    constraint c2_sif       { 
                                if(dma_width == 64)
                                    foreach(dn_data[i]) dn_data[i] inside {[1 : 64'hffffffffffffffff]};
                                else
                                    foreach(dn_data[i]) dn_data[i] inside {[1 : 128'hffffffffffffffffffffffffffffffff]};
                            }
    constraint c3_sif_op    { op_kind inside {UP,DN};}
    constraint c4_sif_debug { m_sif_debug.size() == 10 ;}

    `uvm_object_utils_begin(c_trans_sif)
        `uvm_field_int(up_data, UVM_ALL_ON|UVM_HEX)
        `uvm_field_array_int(dn_data, UVM_ALL_ON|UVM_HEX)
        `uvm_field_array_int(m_sif_debug, UVM_ALL_ON|UVM_HEX)
        `uvm_field_enum(op_kind_enum,op_kind, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

  function new(string name="c_trans_sif");
      super.new(name);
  endfunction: new

  extern virtual function string   psdisplay(string prefix = "");
  extern virtual function void     do_copy  (uvm_object rhs = null);
  extern virtual function bit      compare(c_trans_sif tr);

endclass: c_trans_sif

function string c_trans_sif::psdisplay(string prefix="");
  case (this.op_kind)
    UP:
      $sformat(psdisplay, "%s# up_data=0x%02X",
               prefix, this.up_data);
    DN:
      $sformat(psdisplay, "%s# dn_data=0x%02X",
               prefix, this.dn_data[0]);
    default:
      $sformat(psdisplay, "%s# error:op_kind is not UP/DN",prefix);
  endcase

endfunction: psdisplay

function void c_trans_sif::do_copy(uvm_object rhs=null);
  c_trans_sif cpy;
  super.do_copy(rhs);// Copy all the UVM base class data
  if (!$cast(cpy, rhs)) begin
    `uvm_error(get_name(), "Cannot copy to non-c_trans_sif instance");
    return;
  end

  this.up_data      = cpy.up_data         ; 
  this.dn_data      = cpy.dn_data         ; 
  this.op_kind      = cpy.op_kind         ; 
  this.m_sif_debug  = cpy.m_sif_debug     ;
endfunction: do_copy

 function bit c_trans_sif::compare(c_trans_sif tr);
    bit result;
    
    if(tr == null)
       `uvm_fatal(get_name(),$psprintf("compare transaction is null!!!!"));
    if(up_data == tr.up_data)
        result = 1;
    else
        result = 0;
    return result; 
 endfunction

`endif //C_APB_TRANS__SV
