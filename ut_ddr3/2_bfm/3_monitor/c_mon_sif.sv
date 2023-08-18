`ifndef C_MON_SIF__SV
`define C_MON_SIF__SV

class c_mon_sif extends uvm_monitor;
   `uvm_component_utils(c_mon_sif)
   virtual if_sif m_vif_sif0;
   virtual if_sif m_vif_sif1;
   virtual if_sif m_vif_sif2;
   virtual if_sif m_vif_sif3;
   virtual if_sif m_vif_sif4;
   virtual if_sif m_vif_sif5;
   virtual if_sif m_vif_sif6;
   virtual if_sif m_vif_sif7;

   c_trans_sif tr           ; 
   c_trans_sif m_trans_sif  ;
   uvm_analysis_port#(c_trans_sif) ap;

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction: new

   extern virtual function void build_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task reset_signals();
   extern virtual task trans_observed(uvm_phase phase);
   extern virtual task up_stream(c_trans_sif tr); // upstream
endclass
   
    function void c_mon_sif::build_phase(uvm_phase phase);
      super.build_phase(phase);

         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif0", m_vif_sif0)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif0 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif1", m_vif_sif1)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif1 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif2", m_vif_sif2)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif2 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif3", m_vif_sif3)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif3 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif4", m_vif_sif4)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif4 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif5", m_vif_sif5)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif5 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif6", m_vif_sif6)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif6 for this monitor instance");
         if (!uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif7", m_vif_sif7)) 
            `uvm_fatal("APB/MON/NOVIF", "No virtual sif7 for this monitor instance");
   endfunction


   task c_mon_sif::run_phase(uvm_phase phase);
      super.run_phase(phase);
        fork
            reset_signals();
            trans_observed(phase);
        join
   endtask: run_phase

    task c_mon_sif::reset_signals();
        wait (m_vif_sif0.rst_n === 1'b0);
            m_vif_sif0.up_rdy = 0;
       `uvm_info(get_name()," reset mon_sif m_vif_sif0.upstream",UVM_MEDIUM);
    endtask

    task c_mon_sif::trans_observed(uvm_phase phase);
        int i=0;
        `uvm_info(get_name()," mon_sif trans_observed ,",UVM_MEDIUM);
        wait(m_vif_sif0.rst_n == 0);
        @(posedge m_vif_sif0.rst_n);
        `uvm_info(get_name()," mon_sif wait rst_n release 1 ,",UVM_MEDIUM);
        @(posedge m_vif_sif0.clk);
        
        forever begin
            i++;
            m_trans_sif = new("m_trans_sif");
            tr          = new("tr");
            c_mon_sif::up_stream(m_trans_sif);
            tr.do_copy(m_trans_sif);
            ap.write(tr);
        end
    endtask

    task c_mon_sif::up_stream(c_trans_sif tr); // upstream

        @(posedge m_vif_sif0.up_stream.clk) ; //could add random cycle
        while( !((m_vif_sif0.up_stream.up_vld == 1) && (m_vif_sif0.up_stream.up_rdy == 1))) begin
            m_vif_sif0.up_stream.up_rdy = 1     ;
            @(posedge m_vif_sif0.up_stream.clk) ; //could add random cycle
        end
        tr.up_data = m_vif_sif0.up_stream.up_dat;
    endtask

`endif//C_APB_MON__SV


