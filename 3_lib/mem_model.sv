`ifndef C_DRV_DATA_AVMM__SV
`define C_DRV_DATA_AVMM__SV

`define master_wr m_vif_wr_data_avmm
`define slave_rd  m_vif_rd_data_avmm
module ddr
(
	    output wire         amm_ready_0,               //                ctrl_amm_0.waitrequest_n
		input  wire         amm_read_0,                //                          .read
		input  wire         amm_write_0,               //                          .write
		input  wire [24:0]  amm_address_0,             //                          .address
		output wire [511:0] amm_readdata_0,            //                          .readdata
		input  wire [511:0] amm_writedata_0,           //                          .writedata
		input  wire [6:0]   amm_burstcount_0,          //                          .burstcount
		input  wire [63:0]  amm_byteenable_0,          //                          .byteenable
		output wire         amm_readdatavalid_0,       //                          .readdatavalid
		output wire         ctrl_ecc_user_interrupt_0, //   null  //ctrl_ecc_user_interrupt_0.ctrl_ecc_user_interrupt
		output wire         emif_usr_clk,              //            emif_usr_clk.clk          2 rst_ctrl
		output wire         emif_usr_reset_n,          //            emif_usr_reset_n.reset_n  2 connect_0/rst_ctrl
		input  wire         global_reset_n,            //            pcie_hip_ip               2 global_reset_n.reset_n
);
     parameter dma_width = `DMA_WIDTH;
     
     `uvm_component_utils(c_drv_data_avmm)
     virtual if_master_avmm m_vif_wr_data_avmm;
	 virtual if_slave_avmm m_vif_rd_data_avmm;
     c_trans_data_avmm req;
     c_trans_data_avmm m_trans_data_avmm;
     bit [255:0]  brdata_que[$];
     bit [dma_width-1:0]  bcnt_que[$];
	 bit [dma_width-1:0]  araddr_que[$]; //read/write address queue
     bit [255:0]  rdata_que[$];
     int rd_cnt =0;
     event event_addrss ;
	 int m_active_master_wr = 1 ;

     uvm_put_port #(c_trans_data_avmm) m_drv_port; //trans from drv to RM
     
     function new (string name = "c_drv_data_avmm", uvm_component parent = null);
          super.new(name,parent);
     endfunction
     
     virtual function void build_phase (uvm_phase phase);
         super.build_phase (phase);
         m_drv_port = new("m_drv_port",this);
        assert(uvm_config_db#(virtual if_master_avmm)::get(this, "","m_vif_wr_data_avmm",m_vif_wr_data_avmm));
		assert(uvm_config_db#(virtual if_slave_avmm)::get(this, "","m_vif_rd_data_avmm",m_vif_rd_data_avmm));
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(),$sformatf("====== run_phase :start ===== \n"), UVM_MEDIUM)
        super.run_phase(phase);
		`uvm_info(get_type_name(),$sformatf("drive_flag is %d ===== \n",m_active_master_wr), UVM_MEDIUM)
        fork
            reset_signals();
            get_and_drive(phase);
        join
        `uvm_info(get_type_name(), $sformatf("****** run_phase :end ****** \n"), UVM_MEDIUM)
    endtask

    virtual task reset_signals();
        int rst_n_cnt = 0;
        
		

		if(m_active_master_wr == 1) begin //master wr
		wait (m_vif_wr_data_avmm.rst_n == 1'b0);
		    `master_wr.write        = 1'b0 ;
            `master_wr.writedata    =  0   ;
            `master_wr.burstcounter =  0   ;
            `master_wr.address      =  0   ;
			//`master_wr.waitrequest  =  1   ;
		end else begin                    //slave rd	
		wait (m_vif_rd_data_avmm.rst_n == 1'b0);
		    `master_wr.read          = 1'b0;        		
            `master_wr.readdata      = 0;
            `master_wr.readvalid     = 0;
		    `master_wr.response      = 0;
			`master_wr.waitrequest   = 1;
			//#200 `master_wr.read = 1'b1; 
           // repeat(10) @(posedge `master_wr.clk); 
		   // `master_wr.read = 1'b0; 	
		end

		//------ simulator DUT master ------
        	
		//`master_wr.waitrequest = 0;

	`uvm_info(get_name()," drv reset start ,reset m_vif_wr_data_avmm",UVM_MEDIUM)
	endtask
	
	
    virtual protected task get_and_drive(uvm_phase phase);
        int i = 0;
		if(m_active_master_wr == 1) begin
             wait (m_vif_wr_data_avmm.rst_n == 0)
             @(posedge m_vif_wr_data_avmm.rst_n);
             @(posedge m_vif_wr_data_avmm.clk);
		end else begin 
		    wait (m_vif_rd_data_avmm.rst_n == 0)
            @(posedge m_vif_rd_data_avmm.rst_n);
            @(posedge m_vif_rd_data_avmm.clk);
		end 
 	    `uvm_info(get_name(),$sformatf(" drv_data_avmm_start############[%0d] start \n :%p",i,req),UVM_MEDIUM);       
        forever begin 
            i++;  
			`uvm_info(get_name(),$sformatf(" drv_data_avmm1############[%0d] start \n :%p",i,req),UVM_MEDIUM);			
            seq_item_port.get_next_item(req);
		    `uvm_info(get_name(),$sformatf(" drv_data_avmm############[%0d] start \n :%p",i,req),UVM_MEDIUM);
            m_trans_data_avmm = new();
            m_trans_data_avmm.do_copy(req); 
			seq_item_port.item_done();        //finish current item ,ready for get next item                      
            m_drv_port.put(m_trans_data_avmm); //trans from drv to RM
            drive_transfer(m_trans_data_avmm);//trans from drv to DUT			

        end
	endtask
	
	virtual protected task drive_transfer(c_trans_data_avmm tr);
	    int read_mode = 2;
	    fork 
		    
			begin 
			
			  //while (1) begin 
			    // if (read_mode == 0 )
				//     data_avmm_type_rd_transfer(tr);
				// else if (read_mode == 1) 
				//     data_avmm_pipe_read_transfer(tr);
				// else 
				     data_avmm_burst_read_transfer(tr);
			 //end
			end
		join
	endtask
			
	
	virtual protected task data_avmm_type_ar_transfer_slave(c_trans_data_avmm tr);
	         int araddr=0;


            `uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read_slave ------------------- : \n"),UVM_MEDIUM);	
			
             while (`slave_rd.read == 1'b0)
                  @(posedge `slave_rd.clk);
		   // while (1) begin
			//`uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read_slave -------------------read =======1 : \n"),UVM_MEDIUM);	
			if (`slave_rd.byteenable == 64'h00000000000000ff) begin 
				  araddr         =   `slave_rd.address;
                  //tr.address[0]    <=   `slave_rd.address;
                  //tr.byteenable[0] <=   `slave_rd.byteenable;
				  araddr_que.push_back(araddr);
       			  `slave_rd.waitrequest <= 0;
			      // `uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read start do while  -------------------rd_cnt =======1 : [%h] \n",`slave_rd.byteenable),UVM_MEDIUM);
				  do begin
                     
                     if(`slave_rd.byteenable == 64'hffffffffffffffff)
                     break;
					// `uvm_info(get_name(),$sformatf(" do_while_begin_break  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!------------------- : \n"),UVM_MEDIUM);
				     while ((`slave_rd.waitrequest == 1'b1 )| (`slave_rd.read == 1'b0)) 
                     @(posedge `slave_rd.clk);
				     	
				     rd_cnt ++ ;
					 `uvm_info(get_name(),$sformatf(" drv_do_while_begin  --------------- rd_cnt  : [%d] \n",rd_cnt),UVM_MEDIUM);
				     `uvm_info(get_name(),$sformatf(" drv_do_while_end -------------------rd_cnt  : [%h] \n",`slave_rd.byteenable),UVM_MEDIUM);
					 if(rd_cnt == 8) break;
					 @(posedge `slave_rd.clk);
					 
				  end 
				  while ((`slave_rd.byteenable <= 64'hff00000000000000)&&(`slave_rd.byteenable >= 64'h00000000000000ff));
				  `uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read   bcnt_que_push--------------------: (%d) \n",rd_cnt),UVM_MEDIUM);
				  bcnt_que.push_back (rd_cnt);
				  `uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read   bcnt_que.size------------------- : (%d) \n",bcnt_que.size()),UVM_MEDIUM);				  
				  rd_cnt = 0;
                 @(posedge `slave_rd.clk);

				 ->event_addrss;
				//`uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read_slave_even_begin  -------------------read =======1 : \n"),UVM_MEDIUM); 
				// `slave_rd.waitrequest <= 1;
			end 
			else begin 
			@(posedge `slave_rd.clk);
			end
		//end 
		//@(posedge `slave_rd.clk);
		//`slave_rd.waitrequest = 1'b0;
	endtask


/*virtual protected task data_avmm_type_ar_transfer_slave(c_trans_data_avmm tr);

            int araddr     =0;
	        int last_araddr=0;


            uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read_slave ------------------- : \n"),UVM_MEDIUM);	
		
            while (`slave_rd.read == 1'b0) //wait read 1
                @(posedge `slave_rd.clk);
            
            if(`slave_rd.waitrequest == 1) begin //wait waitrequest is 0 
                `slave_rd.waitrequest = 0;
                @(posedge `slave_rd.clk);
            end
            while (~((`slave_rd.read == 1'b1) && (`slave_rd.waitrequest == 1'b0)))
                 @(posedge `slave_rd.clk);
			araddr     =   `slave_rd.address;
            if( rd_cnt == 0 ) begin
			 	araddr_que.push_back(araddr);
            end
			rd_cnt ++ ;
		    // while (1) begin
			//`uvm_info(get_name(),$sformatf(" drv_adress_avmm_type_read_slave -------------------read =======1 : \n"),UVM_MEDIUM);	
			//if (`slave_rd.byteenable == 64'h00000000000000ff) begin
            if ( last_araddr != araddr ) begin
                last_araddr = araddr ;
                rd_cnt=0;
            end
            

			bcnt_que.push_back (rd_cnt);
			
			
endtask*/
	virtual protected task data_avmm_type_rd_transfer_slave(c_trans_data_avmm tr);
	    int i =0;
		int total_count =0;
		bit [dma_width-1:0]     rd_addr;		
		int triggered_counter = 0;
	         //`uvm_info(get_name(),$sformatf(" drv_data_avmm_type_read_slave ------------------- : \n"),UVM_MEDIUM);
	          @event_addrss;
			 // `uvm_info(get_name(),$sformatf(" drv_data_avmm_type_read_slave_even_trigger ------------------- : \n"),UVM_MEDIUM);
			  repeat(3)@(posedge `slave_rd.clk);
			while(araddr_que.size()>0) begin
            //add random clk to start send read_data			
			//repeat(1)@(posedge `slave_rd.clk)
			if (bcnt_que.size() == 0)  begin  
                `uvm_info(get_name(),$sformatf("error :drv_data_avmm_read bcnt is null !!!"),UVM_MEDIUM);
			end
			else begin 
			    total_count = bcnt_que.pop_front();
				`uvm_info(get_name(),$sformatf("COUNTER :drv_data_avmm_read total_counter is  =============={%d} !!!", total_count),UVM_MEDIUM);
			end 
            
			if(tr.readdata.size() == 0) begin //null //if has data len and data has ready to send,should valid the data ,or not data invalid
                `uvm_info(get_name(),$sformatf("error :drv_data_avmm_read brdata_que is null !!!"),UVM_MEDIUM);
                `slave_rd.readdata  = 0;
                `slave_rd.readvalid = 0;
            end 
			else begin
			    //`uvm_info(get_name(),$sformatf(" araddr_que size is %d : \n",araddr_que.size()),UVM_MEDIUM);
			    rd_addr = araddr_que.pop_front();
				`uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_data ------- : araddr_que.size:%d\n ",araddr_que.size()),UVM_MEDIUM);
				i=rd_addr;
                while (i<total_count+rd_addr) begin
                    @(posedge `slave_rd.clk)
                        `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_data_end burstcounter i********************************%d : \n",i),UVM_MEDIUM);
                        `slave_rd.readvalid = 1;
			    	    
                        `slave_rd.readdata  = tr.readdata[i];
                        i = i+1;
                    end
					@(posedge `slave_rd.clk)
					`slave_rd.readvalid = 0; 
					total_count = 0;
               
            end
		end 
	
	
	endtask
/*	virtual protected task data_avmm_pipe_read_transfer(c_trans_data_avmm tr);
	  // bit [dma_width-1:0]  rdata_que[$];
	   
	      fork 
		     begin 
			 data_avmm_pipe_ar_transfer(tr);
			 data_avmm_pipe_rd_transfer(tr);
			 end
		  join_any
	endtask

    virtual protected task data_avmm_pipe_ar_transfer(c_trans_data_avmm tr);
	         int araddr=0;
            `uvm_info(get_name(),$sformatf(" drv_data_avmm_pipe_read_addr ------------------- : \n"),UVM_MEDIUM); 
                     while (`master_wr.read == 1'b0)
                     @(posedge `master_wr.clk);
					 araddr         =   `master_wr.address;
                     tr.address    <=   `master_wr.address;
                     tr.byteenable <=   `master_wr.byteenable;
       			    `master_wr.waitrequest <= tr.waitrequest;
                           while (`master_wr.waitrequest == 1'b1) begin 
							@(posedge `master_wr.clk);
							`master_wr.waitrequest <= tr.waitrequest; end
					 rdata_que.push_back(tr.readdata[araddr]); 
					//   @(posedge `master_wr.clk);
	endtask


    virtual protected task data_avmm_pipe_rd_transfer(c_trans_data_avmm tr);
		  
		   `uvm_info(get_name(),$sformatf(" drv_data_avmm_pipe_read_data ------------------- : \n"),UVM_MEDIUM);
		             repeat(1)@(posedge  `master_wr.clk);
					if(rdata_que.size() == 0) begin //null //if has data len and data has ready to send,should valid the data ,or not data invalid
                    `uvm_info(get_name(),$sformatf("error :drv_data_avmm_read tr is null !!!"),UVM_MEDIUM)
                    `master_wr.readdata  = 0;
                    `master_wr.readvalid = 0;
                    end else begin
                    `master_wr.readvalid = 1;
                    `master_wr.readdata  = rdata_que.pop_front();
                     end 
	endtask
*/
	virtual protected task data_avmm_burst_read_transfer (c_trans_data_avmm tr);
	   // bit [dma_width-1:0]  brdata_que[$];
	    //int rd_cnt;	    
		if(m_active_master_wr == 1) begin //master wr
		    fork
                data_avmm_burst_aw_transfer_master(tr);
		        data_avmm_burst_wd_transfer_master(tr);
			join
		end else begin                    //slave rd
		   
			fork
			    while(1) begin 
                data_avmm_type_ar_transfer_slave(tr);
			    end
				while(1) begin 
		        data_avmm_type_rd_transfer_slave(tr);
				end
			join
	end 
	endtask
	
	virtual protected task data_avmm_burst_aw_transfer_master (c_trans_data_avmm tr);
	    int araddr;
		int triggered_counter = 0;
		int total_counter;
		`uvm_info(get_name(),$sformatf("  master waitrequest 2 [%p] ------------------- : \n",tr.address),UVM_MEDIUM);
		
            @(posedge `master_wr.clk);
			-> event_addrss ;
			foreach(tr.address[i]) begin			
`uvm_info(get_name(),$sformatf("  master waitrequest 3[%d] [%d] ------------------- : \n",i,tr.address[i]),UVM_MEDIUM);			
				//------ simulator DUT master ------
				//`master_wr.waitrequest  = 1'b1;
				//------------------------------------
				
				`master_wr.byteenable   = 32'hf;
				 
				araddr_que.push_back(tr.address[i]);
                `master_wr.address      = tr.address[i];
				`master_wr.burstcounter = tr.burstcounter[i];				
				
				wait(`master_wr.waitrequest == 1'b1);
				`uvm_info(get_name(),$sformatf(" :master write address number should be aaaaa : \n"),UVM_MEDIUM);
				@(posedge `master_wr.clk);
				//------ simulator DUT master ------
				//`master_wr.waitrequest =1'b0 ;
				//------------------------------------
				
				if(	`master_wr.waitrequest == 1'b0)
 				    `uvm_info(get_name(),$sformatf("  master addr bbbbbbbb[%d] ------------------- : \n",`master_wr.waitrequest),UVM_MEDIUM);
                @(posedge `master_wr.clk);
		        `uvm_info(get_name(),$sformatf(" master addr cccccc: \n"),UVM_MEDIUM);
		        if(i == 1) 
			       `uvm_info(get_name(),$sformatf(" Error:master write address number should be 1,no 2 times : \n"),UVM_MEDIUM);				
			end
			
	endtask
	
	virtual protected task data_avmm_burst_wd_transfer_master(c_trans_data_avmm tr);
		int j =0;
		int total_count =0;
		bit [dma_width-1:0]     rd_addr;		
		int triggered_counter = 0;
		int wr_brust_count=0;
		int initial_addr = 0;
		wr_brust_count = tr.burstcounter[j];
		`uvm_info(get_name(),$sformatf(" :master write address number should be 11111 : \n"),UVM_MEDIUM);				
		@event_addrss;
		//wait(event_addrss.triggered());
		
		`master_wr.write        = 1'b1 ;
         initial_addr = araddr_que.pop_front();	 
		 j            = initial_addr ;
		 `uvm_info(get_name(),$sformatf(" :master write address number should be 222222[%d] {%d} : \n",j,wr_brust_count),UVM_MEDIUM);
        
		
		while (j < wr_brust_count+initial_addr) begin
            //add random clk to start send read_data				
			//------ simulator DUT master ------
			//if(j+1 == wr_brust_count+initial_addr ) begin					    
			//	`master_wr.waitrequest  = 1'b1;												
			//end
			//------------------------------------			        
			if(`master_wr.write == 1'b1 ) begin
			    `master_wr.writedata  = tr.writedata[j];
			end
						        
			repeat(1)@(posedge `master_wr.clk);
			//------ simulator DUT master ------
			//if(j+1 == wr_brust_count+initial_addr ) begin					    
			//	`master_wr.waitrequest  = 1'b0;												
			// end
			//------------------------------------
            if((`master_wr.write == 1'b1) && (`master_wr.waitrequest == 1'b0)) begin
			    j++;
			    `uvm_info(get_name(),$sformatf(" \n:master iiiiiiii[%d] : \n",j),UVM_MEDIUM);
		    end
			
			if((j%6 == 0) && (j < wr_brust_count+initial_addr)) begin   //disturb
			    `master_wr.write    = 1'b0 ;
				`uvm_info(get_name(),$sformatf("\n :master write address number should be 66666[%d] : \n",j),UVM_MEDIUM);
				repeat(3)@(posedge `master_wr.clk);
				`master_wr.write    = 1'b1 ;
				`uvm_info(get_name(),$sformatf("\n :master write address number should be 7777[%d] : \n",j),UVM_MEDIUM);
			end

		end
        //`master_wr.waitrequest  = 1'b0;
		//repeat(1)@(posedge `master_wr.clk);
		`uvm_info(get_name(),$sformatf(" \n:master write address number should be 888888[%d] : \n",j),UVM_MEDIUM);
		`master_wr.write    = 1'b0 ;
		//------ simulator DUT master ------

		//------------------------------------
		
	endtask
	
	
	virtual protected task data_avmm_burst_ar_transfer_slave (c_trans_data_avmm tr);
	    int araddr;
		int triggered_counter = 0;
		int total_counter;
		
            foreach(tr.address[i]) begin
			    while (`slave_rd.read == 1'b0) begin
                    @(posedge `slave_rd.clk);
			    end
				`slave_rd.waitrequest = 1'b1;
		//	     @(posedge `slave_rd.clk);
			    `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_addr ------------------- : \n"),UVM_MEDIUM);
                
                
				//------ simulator DUT master ------
                //`slave_rd.address = 16 ;
                //`slave_rd.byteenable   = 32'hf;
                //`slave_rd.address      = tr.address[i];
				//`slave_rd.burstcounter = tr.burstcounter[i];
				//------------------------------------
				@(posedge `slave_rd.clk);
				araddr        =  `slave_rd.address;
				araddr_que.push_back(araddr); 
                rd_cnt        =  `slave_rd.burstcounter ;
                bcnt_que.push_back(rd_cnt); 
                tr.byteenable =  `slave_rd.byteenable;
           //  `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_addr_end burstcounter -------------------%d : \n",`master_wr.burstcounter),UVM_MEDIUM);
             //   `uvm_info(get_name(),$sformatf(" araddr_que size is %d : \n",araddr_que.size()),UVM_MEDIUM);
                `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_addr_end burstcounter -------------------%p : \n",tr.burstcounter),UVM_MEDIUM);
				`slave_rd.waitrequest = 1'b0;
				@(posedge `slave_rd.clk);
				if (triggered_counter == 0) begin 
                -> event_addrss ;
				end 
				`slave_rd.waitrequest = 1'b1;
				triggered_counter ++;
                `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_addr_end -------------------:  TRIGGERED : %d \n", triggered_counter),UVM_MEDIUM);
			end
	endtask
	
	virtual protected task data_avmm_burst_rd_transfer_slave(c_trans_data_avmm tr);
		int i =0;
		int total_count =0;
		bit [dma_width-1:0]     rd_addr;		
		int triggered_counter = 0;
		
		@event_addrss;
		repeat(6) @(posedge `slave_rd.clk);
		
        while(araddr_que.size()>0) begin
            //add random clk to start send read_data			
			//repeat(1)@(posedge `slave_rd.clk)
			if (bcnt_que.size() == 0)  begin  
                `uvm_info(get_name(),$sformatf("error :drv_data_avmm_read bcnt is null !!!"),UVM_MEDIUM);
			end
			else begin 
			    total_count = bcnt_que.pop_front();
				`uvm_info(get_name(),$sformatf("COUNTER :drv_data_avmm_read total_counter is  ==================%d !!!", total_count),UVM_MEDIUM);
			end 
            
			if(tr.readdata.size() == 0) begin //null //if has data len and data has ready to send,should valid the data ,or not data invalid
                `uvm_info(get_name(),$sformatf("error :drv_data_avmm_read brdata_que is null !!!"),UVM_MEDIUM);
                `slave_rd.readdata  = 0;
                `slave_rd.readvalid = 0;
            end 
			else begin
			    `uvm_info(get_name(),$sformatf(" araddr_que size is %d : \n",araddr_que.size()),UVM_MEDIUM);
			    rd_addr = araddr_que.pop_front();
				`uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_data ------- : araddr_que.size:%d\n ",araddr_que.size()),UVM_MEDIUM);
				i=rd_addr;
                while (i<total_count+rd_addr+1) begin
                    @(posedge `slave_rd.clk)
                        `uvm_info(get_name(),$sformatf(" drv_data_avmm_burst_read_data_end burstcounter !!!!!!i-------------------%d : \n",i),UVM_MEDIUM);
                        `slave_rd.readvalid = 1;
			    	    
                        `slave_rd.readdata  = tr.readdata[i];
                        i = i+1;
                    end
					total_count = 0;
               
            end
		end 
		@(posedge `slave_rd.clk)
        `slave_rd.readvalid = 0;
		//`slave_rd.waitrequest = 1'b1;
	endtask
endclass
`endif
	
