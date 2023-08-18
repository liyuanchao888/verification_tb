`ifndef C_TRANS_AXI__SV
`define C_TRANS_AXI__SV

class c_trans_axi extends uvm_sequence_item;
    parameter dma_width = `DMA_WIDTH;
//read
    rand bit  [31:0]             araddr  ;
    rand bit  [ 7:0]             arlen   ;
    rand bit  [ 2:0]             arsize  ;
    rand bit  [ 1:0]             arburst ;
    rand bit  [dma_width-1:0]    rdata[] ;
//write
    rand bit [31:0]              awaddr      ;
    rand bit [ 7:0]              awlen       ;
    rand bit [ 2:0]              awsize      ;
    rand bit [ 1:0]              awburst     ;
    rand bit [dma_width-1:0]     wdata       ;
    rand bit [dma_width-1:0]     wdata_que[$];
    rand bit [dma_width-1:0]     m_axi_debug[];

    typedef enum {WR,RD} op_kind_enum;
    rand op_kind_enum op_kind;
    constraint c2_axi   { rdata.size() == 5000 ;} //258*258*128/4(16bit)=2130048
    constraint c4_axi   { 
                           if (dma_width == 64)
                               foreach(rdata[i]) rdata[i] inside {[1:64'hffffffffffffffff]};
                           else
                               foreach(rdata[i]) rdata[i] inside {[1:128'hffffffffffffffffffffffffffffffff]};
                         }
    
    constraint c_axi_op { op_kind inside {WR,RD};}
    constraint c2_debug { m_axi_debug.size() == 10;} //10*10 = 100
    
    `uvm_object_utils_begin(c_trans_axi)
        `uvm_field_int(araddr, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(arlen, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(arsize, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(arburst, UVM_ALL_ON|UVM_HEX)
        `uvm_field_array_int(rdata, UVM_ALL_ON|UVM_HEX)

        `uvm_field_int(awaddr, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(awlen, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(awsize, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(awburst, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(wdata, UVM_ALL_ON|UVM_HEX)
        `uvm_field_queue_int(wdata_que, UVM_ALL_ON|UVM_HEX)

        `uvm_field_enum(op_kind_enum,op_kind, UVM_ALL_ON|UVM_HEX)
        `uvm_field_array_int(m_axi_debug, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

  function new(string name="c_trans_axi");
      super.new(name);
  endfunction: new

  extern virtual function string   psdisplay(string prefix = "");
  extern virtual function void     do_copy  (uvm_object rhs = null);
  extern virtual function bit      compare(c_trans_axi tr);
endclass: c_trans_axi


function string c_trans_axi::psdisplay(string prefix = "");

  case (this.op_kind)
    WR:
      $sformat(psdisplay, "%s# wdata_que=0x%p",
               prefix, this.wdata_que);
    RD:
      $sformat(psdisplay, "%s# rdata=0x%02X",
               prefix, this.rdata[0]);
    default:
      $sformat(psdisplay, "%s# error:op_kind is not WR/RD ",prefix);
  endcase

endfunction: psdisplay


function void c_trans_axi::do_copy(uvm_object rhs=null);
  c_trans_axi cpy;
  super.do_copy(rhs);// Copy all the UVM base class data
  if (!$cast(cpy, rhs)) begin
    `uvm_error(get_name(), "Cannot copy to non-c_trans_axi instance");
    return;
  end
   //  Add lines here to copy each data member.
   //read
   this.araddr       = cpy.araddr  ; 
   this.arlen        = cpy.arlen   ;
   this.arsize       = cpy.arsize  ;
   this.arburst      = cpy.arburst ;
   this.rdata        = cpy.rdata   ;
   //write
   this.awaddr       = cpy.awaddr  ;
   this.awlen        = cpy.awlen   ;
   this.awsize       = cpy.awsize  ;
   this.awburst      = cpy.awburst ;
   this.wdata        = cpy.wdata   ;
   this.wdata_que    = cpy.wdata_que   ;
   this.op_kind      = cpy.op_kind ;   
   this.m_axi_debug    = cpy.m_axi_debug   ;
endfunction: do_copy


   function bit c_trans_axi::compare(c_trans_axi tr);
      bit result;
      if(tr == null)
         `uvm_fatal(get_name(),$psprintf("compare transaction is null!!!!"));
       
      if(this.wdata == tr.wdata)
          result = 1;
      else
          result = 0;
      return result; 
   endfunction

`endif //C_APB_TRANS__SV
