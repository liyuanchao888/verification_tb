
/**
 * Abstract:
 * Class cust_svt_axi_system_configuration is used to encapsulate all the 
 * configuration information.  It extends the system configuration and 
 * set the appropriate fields like number of masters/slaves, create 
 * master/slave configurations etc..., which are required by System agent.
 */

`ifndef GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
`define GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV


class cust_svt_axi_system_configuration extends svt_axi_system_configuration;

  /** UVM Object Utility macro */
  `uvm_object_utils (cust_svt_axi_system_configuration)

  /** Class Constructor */
  function new (string name = "cust_svt_axi_system_configuration");

    super.new(name);

    /** Assign the necessary configuration parameters. This example uses single
      * master and single slave configuration.
      */
    this.num_masters = 1;
    this.num_slaves  = 0;
//    this.system_monitor_enable = 1;

    /** Create port configurations */
    this.create_sub_cfgs(1,0);

    /** Enable protocol file generation for Protocol Analyzer */
    this.master_cfg[0].enable_xml_gen = 0;
    this.master_cfg[0].pa_format_type = svt_xml_writer::FSDB;
    this.master_cfg[0].transaction_coverage_enable = 1;
    this.master_cfg[0].data_width = 32;
    this.master_cfg[0].id_width = 8;
//    this.master_cfg[0].addr_width = 64;
    this.master_cfg[0].reordering_algorithm = svt_axi_port_configuration::RANDOM;
    this.master_cfg[0].write_resp_reordering_depth = `SVT_AXI_MAX_WRITE_RESP_REORDERING_DEPTH;

//    this.slave_cfg[0].enable_xml_gen = 1;
//    this.slave_cfg[0].pa_format_type= svt_xml_writer::FSDB;
//    this.slave_cfg[0].transaction_coverage_enable = 1;
//    this.slave_cfg[0].data_width = 64;
//    this.slave_cfg[0].id_width = 8;
//    this.slave_cfg[0].addr_width = 64;
//    this.slave_cfg[0].reordering_algorithm = svt_axi_port_configuration::RANDOM;
//    this.slave_cfg[0].write_resp_reordering_depth = `SVT_AXI_MAX_WRITE_RESP_REORDERING_DEPTH;
    `ifdef ENBALE_COMPLEX_MEMORY_MAP_FEATURE
      this.enable_complex_memory_map=1; 
    `else
//      this.set_addr_range(0,64'h0,64'hffff_ffff_ffff_ffff); //need num_slave>slv_idx=0 //ycli recomment
//      this.set_addr_range(0,64'h0,64'hffff_ffff);
    `endif   
  endfunction

  `ifdef ENBALE_COMPLEX_MEMORY_MAP_FEATURE
    function bit get_dest_slave_addr_from_global_addr (input bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr, 
                                                       input bit [`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0, 
                                                       input string requester_name ="", 
                                                       input bit ignore_unmapped_addr = 0, 
                                                       output bit is_register_addr_space , 
                                                       output int slave_port_ids [$], 
                                                       output bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr , 
                                                       input svt_axi_transaction xact);
      begin 
        
        //the transactions are always routed to slave port 0. The below statement indciates the routing info of interconnect. 
        slave_port_ids[0]=0; 

        //no addr translation. The below statement indicates any addr translation performed by interconnect. 
        slave_addr = global_addr; //note that global_addr will be tagged with the non-secure bit if address tagging is enabled.
        
        //return 1
        get_dest_slave_addr_from_global_addr=1;

        //the below items can be used when applicable. In this example, they are not applicable 
        /*
        * if(xact.port_cfg.port_id == 0 || xact.port_cfg.port_id == 1) begin //transactions from master[0] and master[1] will be routed to slave 0
           slave_port_ids[0]=0;
        end
        else if(xact.port_cfg.port_id == 2 || xact.port_cfg.port_id == 3) begin //transactions from master[2] and master[3] will be routed to slave 1
          slave_port_ids[0]=1;
        end

        //register transactions that terminates within the interconnect have to be specified using:
        if(global_addr>=reg_space_start_addr && global_addr<=reg_space_end_addr) begin
          is_register_addr_space=1;
          slave_port_ids[0]=-1;
          get_dest_slave_addr_from_global_addr=1;
        end 
        */
      end 
    endfunction    
  `endif   

endclass
`endif //GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
