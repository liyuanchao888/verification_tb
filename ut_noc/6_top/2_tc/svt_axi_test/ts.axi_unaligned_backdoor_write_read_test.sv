`include "axi_unaligned_write_read_sequence.sv"
`define TB_BACKDOOR_MEMORY_NUM_BYTES_FOR_WRITE 4 
`ifndef GUARD_UNALIGNED_BACKDOOR_WRITE_READ_TEST_SV
`define GUARD_UNALIGNED_BACKDOOR_WRITE_READ_TEST_SV

class axi_unaligned_backdoor_write_read_test extends axi_base_test;

  int unsigned sequence_length = 20;
 
 /** UVM Component Utility macro */
  `uvm_component_utils (axi_unaligned_backdoor_write_read_test)

  /** Class Constructor */
  function new (string name="axi_unaligned_backdoor_write_read_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.sequencer.main_phase", "default_sequence", axi_null_virtual_sequence::type_id::get());

    /** Apply the master sequence to the master sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.master*.sequencer.main_phase", "default_sequence", axi_unaligned_write_read_sequence::type_id::get());

    /** Set the sequence 'length' to generate transactions with random constraints */
    uvm_config_db#(int unsigned)::set(this,"env.axi_system_env.master*.sequencer.axi_unaligned_write_read_sequence",  "sequence_length",20);

    /** Apply the Slave random response sequence to Slave sequencer
     *
     * This sequence is configured for the run phase since the slave should always
     * respond to recognized requests.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence", axi_slave_mem_response_sequence::type_id::get());
    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
     svt_axi_port_configuration slave_cfg = env.cfg.slave_cfg[0];
     bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr;
     bit[7:0] data_r[];
     bit[7:0] data_w[];
     bit[7:0] data_r1[];
     bit[7:0] data_w1[];
     bit[7:0] data;
     int no_of_bytes = 5; 
     
     `svt_xvm_note ("run_phase","Entered ...");    
     
     for(int k=0;k< sequence_length;k ++) begin
       start_addr = $urandom_range(0, (2**(slave_cfg.addr_width/2)-1-(`TB_BACKDOOR_MEMORY_NUM_BYTES_FOR_WRITE+50)));
       no_of_bytes = $urandom_range(0, 512);
       data_w = new[no_of_bytes];
       // backdoor single byte write using write_byte method
       for(int i=0;i<no_of_bytes;i ++) begin
         data_w[i] = $urandom_range(1,255) ;
         env.axi_system_env.slave[0].write_byte(start_addr+i,data_w[i]);
       end
  
       data_r = new[no_of_bytes];
       // backdoor multiple byte read using read_num_byte method
       env.axi_system_env.slave[0].read_num_byte(start_addr,no_of_bytes,data_r);
       //self checker mechanisam for backdoor write(write_byte) followed by
       //read(read_num_byte)
       if (data_w.size() == data_r.size()) begin
         if (data_w != data_r) begin
           `svt_error("run_phase",$sformatf("Mismatch in comparison of read and right datas"));
           foreach(data_r[i])begin
             if (data_w[i] != data_r[i])
               `svt_debug("run_phase",$sformatf("Mismatch in read and write data i=%0d,addr=%0h,no_of_bytes=%0d, data_w=%0h !=  data_r=%0h",i,start_addr+i,no_of_bytes,data_w[i],data_r[i]));
             else
               `svt_debug("run_phase",$sformatf("Match in read and write data i=%0d,addr=%0h,no_of_bytes=%0d, data_w=%0h ==  data_r=%0h",i,start_addr+i,no_of_bytes,data_w[i],data_r[i]));
           end   
         end
       end
       else  
         `svt_error("run_phase",$sformatf("Mismatch in comparison of read and right datas size. data_w.size()=%0d and data_r.size()=%0d",data_w.size(),data_r.size()));

       data_r.delete();
       data_w.delete();
  
       start_addr = $urandom_range(0, (2**(slave_cfg.addr_width/2)-1-(`TB_BACKDOOR_MEMORY_NUM_BYTES_FOR_WRITE+50)));
       data_w1 = new[no_of_bytes];
  
       for(int i=0;i<no_of_bytes;i ++) begin
         data_w1[i] = $urandom_range(0,255) ;
       end
       // backdoor multiple byte write using write_num_byte method
       env.axi_system_env.slave[0].write_num_byte(start_addr,no_of_bytes,data_w1);
       
       data_r1 = new[no_of_bytes];
       // backdoor single byte read using read_byte method
       for(int i=0;i<no_of_bytes;i ++) begin
         env.axi_system_env.slave[0].read_byte(start_addr+i,data);
         data_r1[i] = data;
       end
  
       //self checker mechanisam for backdoor write(write_byte) followed by
       //read(read_num_byte)
       if (data_w.size() == data_r.size()) begin
         if (data_w1 != data_r1) begin
           `svt_error("run_phase",$sformatf("Mismatch in comparison of read and right datas"));
           foreach(data_r1[i])begin
             if (data_w1[i] != data_r1[i])
               `svt_debug("run_phase",$sformatf("Mismatch in read and write data i=%0d,addr=%0h,no_of_bytes=%0d, data_w1=%0h !=  data_r1=%0h",i,start_addr+i,no_of_bytes,data_w1[i],data_r1[i]));
             else
               `svt_debug("run_phase",$sformatf("Match in read and write data i=%0d,addr=%0h,no_of_bytes=%0d, data_w1=%0h !=  data_r1=%0h",i,start_addr+i,no_of_bytes,data_w1[i],data_r1[i]));
           end    
         end
       end
       else
         `svt_error("run_phase",$sformatf("Mismatch in comparison of read and right datas size. data_w1.size()=%0d and data_r1.size()=%0d",data_w1.size(),data_r1.size()));

       data_r1.delete();
       data_w1.delete();
       #1000;
     end
     `svt_xvm_note ("run_phase","Exiting ...");
  
  endtask

endclass

`endif // GUARD_UNALIGNED_BACKDOOR_WRITE_READ_TEST_SV
