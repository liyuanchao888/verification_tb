`ifndef C_MON_APB__SV
`define C_MON_APB__SV

class c_mon_apb extends uvm_monitor;

   virtual if_apb m_vif_apb;
   uvm_analysis_port#(c_trans_apb) ap;

   `uvm_component_utils(c_mon_apb)

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
         if (!uvm_config_db#(virtual if_apb)::get(this, "", "m_vif_apb", m_vif_apb)) begin
            `uvm_fatal("APB/MON/NOVIF", "No virtual interface specified for this monitor instance")
      end
   endfunction
   
endclass: c_mon_apb
   
`endif//C_APB_MON__SV


