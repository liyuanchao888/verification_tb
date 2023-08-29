
`ifdef CCI400_CHECKS_ENABLED

`ifndef GUARD_SVT_AXI_CCI400_SEQ_COLLECTION_SV
`define GUARD_SVT_AXI_CCI400_SEQ_COLLECTION_SV

`include "svt_axi_cci400_vip_defines.svi"

/**
  * cci400 register write sequence : randomizes axi write transaction object
  * and sends to the driver for writing to CCI400 registers
  *   This sequence can be used by other sequences by specifying address, data or
  * other attributes to write to a specific CCI400 register
  */ 
class svt_axi_reg_write_sequence extends svt_axi_master_base_sequence;

  //general VIP transaction variables, can be overriden 
  rand int  					myID=0;
  rand bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] 	myAddr='h1000;
  rand bit[31:0]				myData;



  //local varaibles,can not be ovveriden 
  svt_configuration 				get_cfg;
  `svt_xvm_object_utils(svt_axi_reg_write_sequence)

  //*************************************************************************
  /** Class Constructor */
  //*************************************************************************
  function new(string name="svt_axi_reg_write_sequence");
    super.new(name);
  endfunction
  
  //*************************************************************************
  // Body
  //*************************************************************************
  virtual task body();
    svt_axi_master_transaction 			tr;

    //super.body();

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end


    //=====================================================
    /** Set up the transaction */
    //=====================================================
    `svt_xvm_create(tr)
    tr.randomize() with {
	  xact_type == svt_axi_transaction::COHERENT;
      	  coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
	  atomic_type == svt_axi_transaction::NORMAL;
	  burst_type ==svt_axi_transaction::INCR;
    	  addr == myAddr;
 	  domain_type== svt_axi_transaction::SYSTEMSHAREABLE;
	  prot_type==svt_axi_transaction::DATA_SECURE_NORMAL;
	  cache_type==0;
	  associate_barrier==0;
    	  id == myID;
	  burst_size==svt_axi_transaction::BURST_SIZE_32BIT;
          burst_length == 1;

          foreach(data[i]) data[i]==0;
          foreach(wstrb[i]) wstrb[i]==0;
     	  data_before_addr == 0;
	  foreach(cache_write_data[i]) cache_write_data[i]==0;
	};
    //=====================================================
    //post randomzie
    //=====================================================
    //process the 32bit write data/strobe on 128 bit data bus
	if(tr.addr[3:0]==0) begin
	  tr.data[0]=myData;
	  tr.wstrb[0]=4'hf;
	end
	if(tr.addr[3:0]==4) begin
	  tr.data[0]={myData,32'h0};
	  tr.wstrb[0]={4'hf,4'h0};
	end
	if(tr.addr[3:0]==8) begin
	  tr.data[0]={myData,64'h0};
	  tr.wstrb[0]={4'hf,8'h0};
	end
	if(tr.addr[3:0]=='hc) begin
	  tr.data[0]={myData,96'h0};
	  tr.wstrb[0]={4'hf,12'h0};
	end
    //=====================================================
    //send to VIP
    //=====================================================
    //send trans to VIP
    `svt_xvm_send(tr)
    get_response(rsp);
    tr.wait_for_transaction_end();


  endtask: body

endclass: svt_axi_reg_write_sequence



/**
  * cci400 register read sequence : randomizes axi read transaction object
  * and sends to the driver for reading CCI400 registers
  *   This sequence can be used by other sequences by specifying address, data or
  * other attributes to read from a specific CCI400 register
  */ 
class svt_axi_reg_read_sequence extends svt_axi_master_base_sequence;


  //general VIP transaction variables, can be overriden 
  rand int  					myID=0;
  rand bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] 	myAddr='h1000;
  bit[31:0]					myData; //output



  //local varaibles,can not be ovveriden 
  svt_configuration 				get_cfg;
  bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] 		rdata;

  `svt_xvm_object_utils(svt_axi_reg_read_sequence)

  //*************************************************************************
  /** Class Constructor */
  //*************************************************************************
  function new(string name="svt_axi_reg_read_sequence");
    super.new(name);
  endfunction
  
  //*************************************************************************
  // Body
  //*************************************************************************
  virtual task body();
    svt_axi_master_transaction 			tr;

    //super.body();

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end


    //=====================================================
    /** Set up the transaction */
    //=====================================================
    `svt_xvm_create(tr)
    tr.randomize() with {
	  xact_type == svt_axi_transaction::COHERENT;
      	  coherent_xact_type == svt_axi_transaction::READNOSNOOP;
	  atomic_type == svt_axi_transaction::NORMAL;
	  burst_type ==svt_axi_transaction::INCR;
    	  addr == myAddr;
 	  domain_type== svt_axi_transaction::SYSTEMSHAREABLE;
	  prot_type==svt_axi_transaction::DATA_SECURE_NORMAL;
	  cache_type==0;
	  associate_barrier==0;
    	  id == myID;
	  burst_size==svt_axi_transaction::BURST_SIZE_32BIT;
          burst_length == 1;

          foreach(data[i]) data[i]==0;
     	  data_before_addr == 0;
	  foreach(cache_write_data[i]) cache_write_data[i]==0;
	};
    //=====================================================
    //send to VIP
    //=====================================================
    //send trans to VIP
    `svt_xvm_send(tr)
    get_response(rsp);
    tr.wait_for_transaction_end();
    //process the 32bit read data on a 128 bit data bus
    rdata=tr.data[0];
    if(tr.addr[3:0]==0) myData=rdata[31:0];
    if(tr.addr[3:0]==4) myData=rdata[63:32];
    if(tr.addr[3:0]==8) myData=rdata[95:64];
    if(tr.addr[3:0]=='hc) myData=rdata[127:96];



  endtask: body

endclass: svt_axi_reg_read_sequence



/**
 * Abstract:
 * Provides access to CCI400 configuration registers and brings up CCI400 with basic configuration
 * for general usage. It configures for following functionalities :
 *
 * - Enables DVM transaction for all slave interface of cci400.  
 * - Enables SNOOP transaction to slave interface 3 and 4.  
 * - Resets Control Override register to leave DVM, Snoop, Speculation Fetch and Barrier
 *        Termination defined by the design time pin configuration sampled during reset phase.
 *
 * - Event Select Register for Performance Monitor 0. 
 *   - Data = 0b11_0111  [5]=EnCycleCntr [4]=EnExportBus [3]=CycleCountDiv64
 *                       [5]=RstCycleCntr [4]=RstPerfCntr [3]=EnAllCounter.
 *   .
 * - Event Counter Control Register. 
 *   - Data = 0b1  [0]= '1' => Enable Event Counter. 
 *   .
 * .
 * 
 * <table border="1">
 * <tr>
 * <th> Register Name </th>                                 
 * <th> Configuration Value </th>
 * </tr>
 * <tr> <td> Control Override Register </td> <td> 32'h0000_0000 </td> </tr>
 * <tr> <td> Snoop Control Registers-Slave I/f 3 </td> <td> 32'h0000_0003 </td> </tr>
 * <tr> <td> Snoop Control Registers-Slave I/f 4 </td> <td> 32'h0000_0003 </td> </tr>
 * <tr> <td> Event Select Register for performance counter 0 </td> <td> 32'h0000_0037 </td> </tr>
 * <tr> <td> Counter Control Register for performance counter 0  </td> <td> 32'h0000_0001 </td> </tr>
 * </table>
 *
 * Execution phase: config_phase<br>   
 * Sequencer: system sequencer
 */
/*
 * +-----------------------------------------------------+-------------------------+
 * |       Register Name                                 |   Configuration Value   |
 * +-----------------------------------------------------+-------------------------+
 * | Control Override Register                           |     32'h0000_0000       |
 * | Snoop Control Registers-Slave I/f 3                 |     32'h0000_0003       |
 * | Snoop Control Registers-Slave I/f 4                 |     32'h0000_0003       |
 * | Event Select Register for performance counter 0     |     32'h0000_0037       |
 * | Counter Control Register for performance counter 0  |     32'h0000_0001       |
 * +-----------------------------------------------------+-------------------------+
 */
class svt_axi_cci400_reg_config_base_virtual_sequence extends svt_axi_system_base_sequence;

  svt_axi_system_configuration  cfg;
  svt_axi_reg_write_sequence		regwrite;
  svt_axi_reg_read_sequence		regread;

  bit [39:15]           PERIPHBASE=25'h0005ff0;
  local bit[39:0]       periph_base_addr;

  // local intermediate variables
  local int i;
  protected int reg_config_port_id;
  protected int active_masterQ[$];

	
 `svt_xvm_declare_p_sequencer(svt_axi_system_sequencer)
 `svt_xvm_object_utils(svt_axi_cci400_reg_config_base_virtual_sequence)



  //*************************************************************************
  /** Class Constructor */
  //*************************************************************************
  function new(string name="svt_axi_cci400_reg_config_base_virtual_sequence");
    super.new(name);
    periph_base_addr = 0;
    periph_base_addr[39:15] = PERIPHBASE;
  endfunction

  //=============================================================================

  /** writes DATA into register specified by the Address in cci400 register space */
  task reg_write(bit[39:0] ADDR, bit[31:0] DATA);
    bit[39:0] int_addr;

    int_addr = (periph_base_addr + ADDR);

    `svt_xvm_do_on_with(regwrite,p_sequencer.master_sequencer[reg_config_port_id], 
       {regwrite.myID ==0; 
	regwrite.myAddr==int_addr;
	regwrite.myData==DATA;} ) 
    `svt_amba_debug("CCI400_REG_CONFIG: ", $psprintf("Register['h%0h] Write done..",int_addr)); 

      cfg.cci400_cfg.reg_write(ADDR,DATA);
      //$display("CCI400 MIRROR: Addr='h%x data='h%x at%t",ADDR, cfg.cci400_cfg.reg_read(ADDR), $time);
  endtask

  /** reads register specified by the Address from cci400 register space */
  task reg_read(bit[39:0] ADDR);
    bit[39:0] int_addr;

    int_addr = (periph_base_addr + ADDR);

     `svt_xvm_do_on_with(regread,p_sequencer.master_sequencer[reg_config_port_id], 
       {regread.myID ==0; 
	regread.myAddr==int_addr;} )
  endtask

  /** writes specified DATA into a particular register addressed by ADDR in cci400
    * register space. After completing register write it then reads back mainly for
    * debugging purpose
    */
  task reg_wr_rd(bit[39:0] ADDR, bit[31:0] DATA);
       reg_write(ADDR, DATA);
       reg_read(ADDR);
  endtask

 
  //*************************************************************************
  /** Routes messages through the parent sequencer and raises an objection */
  //*************************************************************************
  virtual task pre_body();
    bit reset_sig_val= 0;
    virtual svt_axi_cci400_config_if AXI_CCI400_CFG_IF;
    svt_configuration get_cfg;
    raise_phase_objection();

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end


    //=====================================================
    /** Pick a Master through which Registers will be conf-
     ** igured. Only active masters are chosen from system
     ** configuration.                                  **/
    //=====================================================
    for(i=0; (i<cfg.num_masters); i++) begin
      if(cfg.master_cfg[i].is_active == 1) active_masterQ.push_back(i);
    end
    active_masterQ.shuffle();
    reg_config_port_id = active_masterQ[0];

    if(cfg.cci400_protocol_check_enable) begin
      AXI_CCI400_CFG_IF = cfg.axi_if.get_cci400_config_if();
      `svt_amba_debug("body"," Waiting for 3 clock cycles. Usually used after reset de-asserted before any activity on bus starts");
  
      while(reset_sig_val==0) begin
        @(AXI_CCI400_CFG_IF.axi_cci400_config_monitor_cb);
        reset_sig_val = AXI_CCI400_CFG_IF.aresetn;
      end
  
      repeat(cfg.cci400_cfg.num_cycles_of_no_activity_after_reset)
        @(AXI_CCI400_CFG_IF.axi_cci400_config_monitor_cb);
      `svt_amba_debug("body", $sformatf(" Waiting for 'd%0d clock cycles over.....", cfg.cci400_cfg.num_cycles_of_no_activity_after_reset));
    end


  endtask
 
  //*************************************************************************
  /** Drop objection */
  //*************************************************************************
  virtual task post_body();
    drop_phase_objection();
  endtask: post_body


  //*************************************************************************
  // Body
  //*************************************************************************
  virtual task body();

    // commented to avoid warning "body undefined" as base class didn't define any task body()
    //super.body();

    // perform basic cci400 configuration
    basic_config();
  endtask: body


  task basic_config();
    //=====================================================
    /** configure CCI-400 registers */
    //=====================================================
    //Control Override Register 
`ifdef CCI400_SPECULATIVE_READS_ENABLE
    reg_wr_rd(`CCI400_REG_Control_Override, 4'h8);
`else
    reg_wr_rd(`CCI400_REG_Control_Override, 4'hC);
`endif

`ifdef CCI400_SPECULATIVE_READS_ENABLE
    // Allow speculative reads
    reg_wr_rd(`CCI400_REG_Speculation_Control, 3'h0);
`endif

    //Snoop Control Register for slave interface 3. 
    reg_wr_rd(`CCI400_REG_Snoop_Control_s3, 4'h3);

    //Snoop Control Register for slave interface 4. 
    reg_wr_rd(`CCI400_REG_Snoop_Control_s4, 4'h3);

    //Max Outstanding Transaction Register for slave interface 0. 
    reg_wr_rd(`CCI400_REG_Max_OT_s0, 32'h101000); //1_0000_0001_0000_00000000
    reg_wr_rd(`CCI400_REG_Max_OT_s1, 32'h101000); //1_0000_0001_0000_00000000
    reg_wr_rd(`CCI400_REG_Max_OT_s2, 32'h101000); //1_0000_0001_0000_00000000
    reg_wr_rd(`CCI400_REG_Max_OT_s3, 32'h101000); //1_0000_0001_0000_00000000
    reg_wr_rd(`CCI400_REG_Max_OT_s4, 32'h101000); //1_0000_0001_0000_00000000

    //Performance Monitor Control Register 
    // -----------------------------------------------------------------------
    //   Data = 0b11_0111  [5]=EnCycleCntr [4]=EnExportBus [3]=CycleCountDiv64
    //                     [5]=RstCycleCntr [4]=RstPerfCntr [3]=EnAllCounter
    // -----------------------------------------------------------------------
    reg_wr_rd(`CCI400_REG_PerfMon_Control, 6'b11_0111);

    //Cycle Count Register
    //    Reset to Zero - Need to Read this register at the end to check no.
    // of cycles elapsed before the counter is read
    // -----------------------------------------------------------------------
    //reg_wr_rd(`CCI400_REG_Cycle_Counter, 6'b11_0111)

    //Cycle Counter Control Register
    // -----------------------------------------------------------------------
    //   Data = 0b1  [1]=EnableCycleCounter 
    // -----------------------------------------------------------------------
    reg_wr_rd(`CCI400_REG_Cycle_Control, 6'b00_0001);
    //reg_wr_rd(`CCI400_REG_Cycle_Overflow, 6'b11_0111)

    //Event Select Register
    // -----------------------------------------------------------------------
    //   Data = 0x00  [4:0]=SlaveI/f_Event:: ReadHandshakeAny = 0b0_0000
    //                [7:5]=EventSource:: SlaveInterface-0 = 0b000 
    // -----------------------------------------------------------------------
    reg_wr_rd(`CCI400_REG_Event_Sel_pc0, 8'b000_00000);

    //Event Count Register
    //    Reset to Zero - Need to Read this register at the end to check no.
    // of events elapsed before the counter is read
    // -----------------------------------------------------------------------
    //reg_wr_rd(`CCI400_REG_Event_Count_pc0, 6'b11_0111);

    //Event Counter Control Register
    // -----------------------------------------------------------------------
    //   Data = 0b1  [1]=EnableEventCounter 
    // -----------------------------------------------------------------------
    reg_wr_rd(`CCI400_REG_Event_Control_pc0, 6'b11_0111);
    //reg_wr_rd(`CCI400_REG_Event_Overflow_pc0, 6'b11_0111);

    `svt_amba_debug("CCI400_REG_CONFIG: ", $psprintf("CCI400 REGISTER CONFIGURATION [port=S'd%0d] DONE....", reg_config_port_id));
  endtask

endclass: svt_axi_cci400_reg_config_base_virtual_sequence



/**
 * Abstract:
 * This class is derived from svt_axi_cci400_reg_config_base_virtual_sequence and it provides 
 * a basic method to read cci400 performance monitor registers
 *
 * <table border="1">
 * <tr>
 * <th> Register Name </th>                                 
 * </tr>
 * <tr> <td> Cycle counter register </td> </tr>
 * <tr> <td> Overflow Flag Status Register for cycle counter </td> </tr>
 * <tr> <td> Event Count Register for performance counter 0 </td> </tr>
 * <tr> <td> Overflow Flag Status Register for performance counter 0 </td> </tr>
 * </table>
 *
 *
 * Execution phase: pre_shutdown_phase<br>  
 * Sequencer: system sequencer
 */
/*
 * +-----------------------------------------------------------+
 * |       Performance Monitor Register Name                   |
 * +-----------------------------------------------------------+
 * | Cycle counter register                                    |
 * | Overflow Flag Status Register for cycle counter           |
 * | Event Count Register for performance counter 0            |
 * | Overflow Flag Status Register for performance counter 0   |
 * +-----------------------------------------------------------+
 */
class svt_axi_cci400_perf_mon_reg_read_sequence extends svt_axi_cci400_reg_config_base_virtual_sequence;

  `svt_xvm_object_utils(svt_axi_cci400_perf_mon_reg_read_sequence)

  //*************************************************************************
  /** Class Constructor */
  //*************************************************************************
  function new(string name="svt_axi_cci400_perf_mon_reg_read_sequence");
    super.new(name);
  endfunction


  //*************************************************************************
  // Body
  //*************************************************************************
  virtual task body();

    //super.body() is not called so that, it doesn't execute initial register
    //configuration again

    //=====================================================================
    /** Read CCI-400 Performance Monitor:: Cycle & Event Count registers */
    //=====================================================================
    //Cycle Count Value Register
    reg_read(`CCI400_REG_Cycle_Counter);
    `svt_amba_debug("CCI400_PERF_MON: ", $psprintf("Cycle Count ReadBack Value = 'd%0d (dec)", regread.myData));

    //Cycle Count Overflow Register
    reg_read(`CCI400_REG_Cycle_Overflow);
    `svt_amba_debug("CCI400_PERF_MON: ", $psprintf("Cycle Count Overflow ReadBack Value = 'd%0d (dec)", regread.myData));

    //Event Count Value Register
    reg_read(`CCI400_REG_Event_Count_pc0);
    `svt_amba_debug("CCI400_PERF_MON: ", $psprintf("Event Count_0 ReadBack Value = 'd%0d (dec)", regread.myData));

    //Event Count Overflow Register
    reg_read(`CCI400_REG_Event_Overflow_pc0);
    `svt_amba_debug("CCI400_PERF_MON: ", $psprintf("Event Count_0 Overflow ReadBack Value = 'd%0d (dec)", regread.myData));

    `svt_amba_debug("CCI400_PERF_MON: ", $psprintf("CCI400 PERF-MON REGISTER READ [port=S'd%0d] DONE.... ", reg_config_port_id));

  endtask: body


endclass: svt_axi_cci400_perf_mon_reg_read_sequence



/*
 * Abstract:
 * CCI400 has a requirement that, once reset is de-asserted no activity should be seen 
 * on any of its interfaces. This sequence tries to ensure that, above requirement is met
 * by enforcing a 3 cycle wait period, once it is called during post_reset_phase.<br>
 *
 * 
 * Execution phase: post_reset_phase<br>   
 * Sequencer: system sequencer
 */
// class svt_axi_cci400_post_reset_virtual_sequence extends svt_axi_system_base_sequence;
// 
//   svt_axi_system_configuration  cfg;
// 
//  `uvm_declare_p_sequencer(svt_axi_system_sequencer)
//  `uvm_object_utils(svt_axi_cci400_post_reset_virtual_sequence)
// 
// 
//   //*************************************************************************
//   /** Class Constructor */
//   //*************************************************************************
//   function new(string name="svt_axi_cci400_post_reset_virtual_sequence");
//     super.new(name);
//     //periph_base_addr = 0;
//     //periph_base_addr[39:15] = PERIPHBASE;
//   endfunction
// 
//   //=============================================================================
// 
// 
//  
//   //*************************************************************************
//   /** Routes messages through the parent sequencer and raises an objection */
//   //*************************************************************************
//   virtual task pre_body();
//     svt_configuration get_cfg;
//     raise_phase_objection();
// 
//     p_sequencer.get_cfg(get_cfg);
//     if (!$cast(cfg, get_cfg)) begin
//       `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
//     end
// 
//   endtask
//  
//   //*************************************************************************
//   /** Drop objection */
//   //*************************************************************************
//   virtual task post_body();
//     drop_phase_objection();
//   endtask: post_body
// 
// 
//   //*************************************************************************
//   // Body
//   //*************************************************************************
//   virtual task body();
// 
//     // commented to avoid warning "body undefined" as base class didn't define any task body()
//     //super.body();
// 
//     `svt_amba_debug("body"," Waiting for 3 clock cycles. Usually used after reset de-asserted before any activity on bus starts");
//     repeat(3) @(cfg.axi_if.cci400_config_if.axi_cci400_config_monitor_cb);
//     `svt_amba_debug("body"," Waiting for 3 clock cycles over.....");
//   endtask: body
// 
// endclass: svt_axi_cci400_post_reset_virtual_sequence


`endif // GUARD_SVT_AXI_CCI400_SEQ_COLLECTION_SV

`endif // GUARD CCI400_CHECKS_ENABLED




