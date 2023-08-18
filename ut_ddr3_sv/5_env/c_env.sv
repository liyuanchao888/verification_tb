`ifndef C_ENV__SV
`define C_ENV__SV
typedef uvm_reg_predictor #(c_trans_apb) c_bus2reg_predictor;
class c_env extends uvm_env;
    c_tb_cfg                              m_tb_cfg     ;
    c_tb_cfg                              m_tb_cfg2    ;
    c_tb_cfg                              m_tb_cfg3    ;
    c_agt_apb                             m_agt_apb    ;
    c_agt_axi                             m_agt_axi    ;
    c_agt_sif                             m_agt_sif    ;
    c_rm                                  m_rm         ;
    c_scb                                 m_scb        ;  
    c_reg_model                           m_reg_model  ;
    c_reg_adapter                         m_reg_adapter;

    uvm_tlm_fifo #(c_trans_apb)  m_fifo_apb_to_rm ;
    uvm_tlm_fifo #(c_trans_axi)  m_fifo_axi_to_rm ;
    uvm_tlm_fifo #(c_trans_sif)  m_fifo_sif_to_rm ;
    uvm_tlm_analysis_fifo   #(c_trans_sif)     m_rm_scb_up_fifo ;
    uvm_tlm_analysis_fifo   #(c_trans_sif)     m_mon_scb_up_fifo;
    uvm_tlm_analysis_fifo   #(c_trans_axi)     m_rm_scb_dn_fifo ;
    uvm_tlm_analysis_fifo   #(c_trans_axi)     m_mon_scb_dn_fifo;
    //for tmp no register
    uvm_tlm_fifo   #(c_trans_apb)     m_fifo_apb_to_axi;
    uvm_tlm_fifo   #(c_trans_apb)     m_fifo_apb_to_sif;
    
    `uvm_component_utils(c_env)

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_tb_cfg  = new();
        m_tb_cfg2  = new();
        m_tb_cfg3  = new();
        m_agt_apb = c_agt_apb::type_id::create("m_agt_apb", this);
        m_agt_axi = c_agt_axi::type_id::create("m_agt_axi", this);
        m_agt_sif = c_agt_sif::type_id::create("m_agt_sif", this);
        m_rm      = c_rm::type_id::create("m_rm", this);
        m_scb     = c_scb::type_id::create("m_scb", this);
        m_fifo_apb_to_rm  = new("m_fifo_apb_to_rm", this); 
        m_fifo_axi_to_rm  = new("m_fifo_axi_to_rm", this); 
        m_fifo_sif_to_rm  = new("m_fifo_sif_to_rm", this);
        //for tmp no register
        m_fifo_apb_to_axi = new("m_fifo_apb_to_axi", this); 
        m_fifo_apb_to_sif = new("m_fifo_apb_to_sif", this); 
        //to scb (up / dn)
        m_rm_scb_up_fifo        = new("m_rm_scb_up_fifo", this); 
        m_mon_scb_up_fifo       = new("m_mon_scb_up_fifo", this); 
        m_rm_scb_dn_fifo        = new("m_rm_scb_dn_fifo", this); 
        m_mon_scb_dn_fifo       = new("m_mon_scb_dn_fifo", this); 
        
        if(m_agt_apb.m_sqr == null ) begin
            m_agt_apb.m_sqr = c_sqr_apb::type_id::create("m_sqr",this);
            `uvm_info(get_type_name(), $sformatf("====== env:build_phase :apb_sqr recreate start ===== \n"), UVM_NONE)
        end
		m_reg_model   = c_reg_model::type_id::create("m_reg_model", this);	
	    m_reg_adapter = c_reg_adapter::type_id::create("m_reg_adapter", this);
		m_reg_model.build();
		m_reg_model.lock_model();
		uvm_config_db #(c_tb_cfg)::set(null,"uvm_test_top.m_seq_apb.m_cpu_op","m_tb_cfg",m_tb_cfg);		
		uvm_config_db #(c_tb_cfg)::set(null,"uvm_test_top.m_env.m_agt_sif.m_drv","m_tb_cfg2",m_tb_cfg2);		
		uvm_config_db #(c_tb_cfg)::set(null,"uvm_test_top.m_env.m_agt_axi.m_drv","m_tb_cfg3",m_tb_cfg3);		
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), $sformatf("====== env:connect_phase :start ===== \n"), UVM_NONE)
         // Agent Connect FIFO to Reference model
         m_agt_apb.m_agt_port.connect(m_fifo_apb_to_rm.put_export); //agt.port to apb_tlm_fifo
         m_agt_axi.m_agt_port.connect(m_fifo_axi_to_rm.put_export); //agt.port to axi_tlm_fifo
         m_agt_sif.m_agt_port.connect(m_fifo_sif_to_rm.put_export); //agt.port to sif_tlm_fifo
         m_rm.m_port_apb_in.connect(m_fifo_apb_to_rm.get_export);   //apb_tlm_fifo to rm
         m_rm.m_port_axi_in.connect(m_fifo_axi_to_rm.get_export);   //axi_tlm_fifo to rm
         m_rm.m_port_sif_in.connect(m_fifo_sif_to_rm.get_export);   //sif_tlm_fifo to rm
         // APB connect fifo to AXI and SIF
         m_agt_apb.m_apb_to_axi_port.connect(m_fifo_apb_to_axi.put_export); //apb_agt.drv.apb_port to apb_tlm_fifo
         m_agt_apb.m_apb_to_sif_port.connect(m_fifo_apb_to_sif.put_export); //apb_agt.drv.apb_port to apb_tlm_fifo
         m_agt_axi.m_apb_to_axi_port.connect(m_fifo_apb_to_axi.get_export); //apb_tlm_fifo to axi_agt.drv.axi_port
         m_agt_sif.m_apb_to_sif_port.connect(m_fifo_apb_to_sif.get_export); //apb_tlm_fifo to axi_agt.drv.axi_port
         
         //--- up ---
         //rm Connect scoreboard
         m_rm.m_port_sif_out.connect(m_rm_scb_up_fifo.analysis_export);
         m_scb.exp_up_port.connect(m_rm_scb_up_fifo.blocking_get_export); //analysis_export to blocking_get_export
        //monitor Connect scoreboard //analysis_export to blocking_get_export
         m_agt_sif.ap.connect(m_mon_scb_up_fifo.analysis_export);
         m_scb.act_up_port.connect(m_mon_scb_up_fifo.blocking_get_export);

         //--- dn ---
         //rm Connect scoreboard
         m_rm.m_port_axi_out.connect(m_rm_scb_dn_fifo.analysis_export);
         m_scb.exp_dn_port.connect(m_rm_scb_dn_fifo.blocking_get_export); //analysis_export to blocking_get_export   
         //monitor Connect scoreboard //analysis_export to blocking_get_export
         m_agt_axi.ap.connect(m_mon_scb_dn_fifo.analysis_export);
         m_scb.act_dn_port.connect(m_mon_scb_dn_fifo.blocking_get_export);
         
         //connect sqr and adapter
         m_reg_model.default_map.set_sequencer(m_agt_apb.m_sqr,m_reg_adapter); 

        `uvm_info(get_type_name(), $sformatf("====== env:connect_phase :end ===== \n"), UVM_MEDIUM)
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_type_name(), $sformatf("====== env:end_of_elaboration_phase :start ===== \n"), UVM_MEDIUM)
    endfunction
  
    virtual function void report_phase(uvm_phase phase);
        uvm_report_server m_server;
        int error_num,fatal_num     ;
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("====== env:report_phase:start ========\n  "), UVM_MEDIUM)
        if (m_scb.m_mismatches>0) begin     //compare fail
            `uvm_error(get_type_name(), $sformatf("error!!!:Reporting %0d mismatched ,%0d matched ",m_scb.m_mismatches ,m_scb.m_matches))
        end else if(m_scb.m_matches>0)begin //compare pass
            `uvm_info(get_type_name(), $sformatf("Reporting %0d mismatched ,%0d matched ",m_scb.m_mismatches ,m_scb.m_matches), UVM_MEDIUM)
        end else begin                      //no data to compare
            `uvm_error(get_type_name(), $sformatf("error!!!:no data to compare!"))
        end
        
        //testcase pass or fail
        m_server = get_report_server();
        error_num  = m_server.get_severity_count(UVM_ERROR);
        fatal_num  = m_server.get_severity_count(UVM_FATAL);
        `uvm_info(get_type_name(), $sformatf("Testcase :%0d ERROR , %0d FATAL",error_num,fatal_num), UVM_MEDIUM)
        if ((error_num != 0)||(fatal_num != 0)) begin     //compare fail
            m_scb.fail_display();
        end else begin
            m_scb.pass_display();
        end
        `uvm_info(get_type_name(), $sformatf("====== env:report_phase:end   =========\n  "), UVM_MEDIUM)
    endfunction
endclass
`endif //C_ENV__SV
