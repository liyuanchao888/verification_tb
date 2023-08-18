`ifndef C_REG_ADAPTER__SV
`define C_REG_ADAPTER__SV
class c_reg_adapter extends uvm_reg_adapter;
   `uvm_object_utils(c_reg_adapter)

   function new( string name = "c_reg_adapter" );
      super.new( name );
      supports_byte_enable = 0;
      provides_responses   = 0;
   endfunction: new
 
   virtual function uvm_sequence_item reg2bus( const ref uvm_reg_bus_op rw );
      c_trans_apb m_tr = c_trans_apb::type_id::create("m_tr");
 //     `uvm_info(get_name(),$sformatf(" [reg] adapter reg2bus value--11[%p] \n",rw),UVM_MEDIUM);
      m_tr.op_kind = (rw.kind == UVM_READ) ? c_trans_apb::RD : c_trans_apb::WR ;
      m_tr.paddr  = rw.addr;
      if ( rw.kind == UVM_WRITE )
          m_tr.pwdata  = rw.data;
      m_tr.pstrb = 4'hf;
      return m_tr;
   endfunction: reg2bus
 
   virtual function void bus2reg( uvm_sequence_item bus_item,
                                  ref uvm_reg_bus_op rw );
      c_trans_apb m_tr;
 
 //       `uvm_info(get_name(),$sformatf(" [reg] adapter bus2reg value--12[%0d] \n",bus_item),UVM_MEDIUM);
      if ( ! $cast( m_tr, bus_item ) ) begin
         `uvm_fatal( get_name(),"bus_item is not of the reg_adapter type." )
         return;
      end
 
      rw.kind = ( m_tr.op_kind ==c_trans_apb::RD ) ? UVM_READ : UVM_WRITE;
      rw.addr = m_tr.paddr;
      rw.data = (m_tr.op_kind == c_trans_apb::RD) ? m_tr.prdata : m_tr.pwdata;
      rw.status = UVM_IS_OK;
      
endfunction: bus2reg
endclass
`endif //C_REG_ADAPTER__SV
