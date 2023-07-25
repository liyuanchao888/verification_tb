class ahb_apb_bridge_environment extends uvm_env;
    `uvm_component_utils(ahb_apb_bridge_environment)

    ahb_apb_bridge_env_config   env_config_h;
    ahb_agent                   ahb_agent_h;
    apb_agent                   apb_agent_h;
    ahb_apb_bridge_scoreboard   scoreboard_h;

    function new (string name = "ahb_apb_bridge_environment", uvm_component parent = null);

        super.new(name,parent);

    endfunction

    function void build_phase(uvm_phase phase);

        if(!uvm_config_db # (ahb_apb_bridge_env_config) :: get (this,"*","ahb_apb_bridge_env_config",env_config_h))
            `uvm_fatal(get_type_name, "cannot get from config db. Have you set() it?")

        if(env_config_h.has_ahb_agent)
            ahb_agent_h = ahb_agent::type_id::create("ahb_agent_h",this);
        if(env_config_h.has_apb_agent)
            apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
        if(env_config_h.has_scoreboard)
            scoreboard_h = ahb_apb_bridge_scoreboard::type_id::create("scoreboard_h",this);

        super.build_phase(phase);

    endfunction

    function void connect_phase(uvm_phase phase);

        uvm_top.print_topology();

        if(env_config_h.has_ahb_agent && env_config_h.has_scoreboard)
            ahb_agent_h.monitor_h.monitor_port.connect(scoreboard_h.ahb_monitor_fifo.analysis_export);
        if(env_config_h.has_apb_agent && env_config_h.has_scoreboard)
            apb_agent_h.monitor_h.monitor_port.connect(scoreboard_h.apb_monitor_fifo.analysis_export);

    endfunction


    virtual function void report_phase(uvm_phase phase);
        uvm_report_server m_server;
        int error_num,fatal_num     ;
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("====== env:report_phase:start ========\n  "), UVM_MEDIUM)
      //  if (scoreboard_h.m_mismatches>0) begin     //compare fail
      //      `uvm_error(get_type_name(), $sformatf("error!!!:Reporting %0d mismatched ,%0d matched ",scoreboard_h.m_mismatches ,m_scb.m_matches))
      //  end else if(scoreboard_h.m_matches>0)begin //compare pass
      //      `uvm_info(get_type_name(), $sformatf("Reporting %0d mismatched ,%0d matched ",scoreboard_h.m_mismatches ,m_scb.m_matches), UVM_MEDIUM)
      //  end else begin                      //no data to compare
      //      `uvm_error(get_type_name(), $sformatf("error!!!:no data to compare!"))
      //  end
        
        //testcase pass or fail
        m_server = get_report_server();
        error_num  = m_server.get_severity_count(UVM_ERROR);
        fatal_num  = m_server.get_severity_count(UVM_FATAL);
        `uvm_info(get_type_name(), $sformatf("Testcase :%0d ERROR , %0d FATAL",error_num,fatal_num), UVM_MEDIUM)
        if ((error_num != 0)||(fatal_num != 0)) begin     //compare fail
            scoreboard_h.fail_display();
        end else begin
            scoreboard_h.pass_display();
        end
        `uvm_info(get_type_name(), $sformatf("====== env:report_phase:end   =========\n  "), UVM_MEDIUM)
    endfunction








endclass
