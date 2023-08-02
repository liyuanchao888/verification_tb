`ifndef C_DRV_AXI__SV
`define C_DRV_AXI__SV

`define slave_rd m_vif_axi 
`define slave_wr m_vif_axi 
class c_drv_axi extends uvm_driver #(c_trans_axi);
     parameter dma_width = `DMA_WIDTH;
    
    `uvm_component_utils(c_drv_axi)
    virtual if_axi m_vif_axi;
    c_trans_axi req; //from sqr_apb.port
    c_trans_axi m_trans_axi;
    
    c_tb_cfg    m_tb_cfg3    = new();
    uvm_put_port #(c_trans_axi) m_drv_port;
    uvm_blocking_get_port #(c_trans_apb) m_apb_to_axi_port ; //from apb_agent

    function new(string name = "c_drv_axi", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_drv_port = new("m_drv_port",this);
        m_apb_to_axi_port   = new("m_apb_to_axi_port ", this); //from apb_agent
        assert(uvm_config_db#(virtual if_axi)::get(this, "", "m_vif_axi", m_vif_axi));
		assert(uvm_config_db#(c_tb_cfg)::get(this,"","m_tb_cfg3",m_tb_cfg3));		
        m_tb_cfg3.file_re(); //read cfg file
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("====== run_phase :start ===== \n"), UVM_MEDIUM)
        super.run_phase(phase);
        fork
            reset_signals();
            get_and_drive(phase);
        join
        `uvm_info(get_type_name(), $sformatf("****** run_phase :end ****** \n"), UVM_MEDIUM)
    endtask

    virtual protected task reset_signals();
        int rst_n_cnt = 0 ;
        wait (m_vif_axi.rst_n === 1'b0) ;
            //rd
            `slave_rd.arready = 'b0                           ;    
            `slave_rd.rvalid  = 'b0                           ;    
            `slave_rd.rid     = 'b0                           ;    
            `slave_rd.rdata   = 'b0                           ;    
            `slave_rd.rresp   = 'b0                           ;    
            `slave_rd.rlast   = 'b0                           ;    
            //wr 
            `slave_wr.awready = 'b0                           ;    
            `slave_wr.wready  = 'b0                           ;    
            `slave_wr.bvalid  = 'b0                           ;    
            `slave_wr.bid     = 'b0                           ;    
            `slave_wr.bresp   = 'b0                           ;    

        `uvm_info(get_name()," drv reset start ,reset m_vif_axi",UVM_MEDIUM);
    endtask

    virtual protected task get_and_drive(uvm_phase phase);
        int i=0;
        int dma_rd_byte_size; 
        
        wait(m_vif_axi.rst_n == 0);
        @(posedge m_vif_axi.rst_n);
        @(posedge m_vif_axi.clk);
        
        forever begin
            i++;
            dma_rd_byte_size = ((m_tb_cfg3.h_array["rsize_reg"]>>16)+1)*((m_tb_cfg3.h_array["rsize_reg"]&16'hffff)+1);
            
            `uvm_info(get_name(),$sformatf(" drv_axi############[%0d] start \n",i),UVM_MEDIUM);
            
            seq_item_port.get_next_item(req);
            m_trans_axi = new();
            m_trans_axi.do_copy(req);
            m_trans_axi.m_axi_debug[0] = (dma_width == 64) ? ((dma_rd_byte_size+7)>>3) : ((dma_rd_byte_size+15)>>4) ;
            seq_item_port.item_done();

            m_drv_port.put(m_trans_axi); //trans from drv to RM
            drive_transfer(m_trans_axi); //trans from drv to DUT
        end
    endtask

    virtual protected task drive_transfer(c_trans_axi tr);
        
        fork
            begin
               
              while (1) begin
                  axi_ar_rd_channel(tr);
              // axi_ar_channel(tr); //read address
              //  axi_rd_channel(tr); //read data
              end
            end
            begin
                axi_aw_channel(tr); //write address
                axi_wr_channel(tr); //write data
            end


        join

    endtask
   
   virtual protected task axi_ar_rd_channel(c_trans_axi tr);
            int rd_cnt = 0;
            int rcounter ;
            int rd_addr;
            int araddr;
            int data_size = 5000;
            bit [31 : 0] diff_cnt;
            bit [15:0] size_r; 
            size_r = (m_tb_cfg3.h_array["rsize_reg"]&16'hffff)+1;
            `uvm_info(get_name(),$sformatf(" drv_axi_read ------------------- : \n"),UVM_MEDIUM);
            while(`slave_rd.arvalid == 1'b0)
                @(posedge `slave_rd.aclk) ; //could add random cycle
            `slave_rd.arready            <=  1'b1               ;    
            tr.araddr                    <=  `slave_rd.araddr   ;
            tr.arlen                     <=  `slave_rd.arlen    ;
            tr.arsize                    <=  `slave_rd.arsize   ;
            tr.arburst                   <=  `slave_rd.arburst  ;
            rcounter                     =   `slave_rd.arlen + 1;
            
            araddr = `slave_rd.araddr;
            diff_cnt = araddr - rd_addr;
            if(araddr > rd_addr)
                rd_cnt = (dma_width == 64) ? (rd_cnt + diff_cnt[31:3]) : (rd_cnt + diff_cnt[31:4]);
            else
                rd_cnt = (rd_cnt==0) ? rd_cnt : (rd_cnt - 1);
            @(posedge `slave_rd.aclk) ; //could add random cycle

            while(`slave_rd.rlast == 0) begin
                while(`slave_rd.rready == 0)
                    @(posedge `slave_rd.aclk)     ; //could add random cycle
                if(tr == null) begin //null //if has data len and data has ready to send,should valid the data ,or not data invalid
                    `uvm_info(get_name(),$sformatf("error :drv_axi_read tr is null !!!"),UVM_MEDIUM);
                    `slave_rd.rdata  = 0                     ;
                    `slave_rd.rvalid = 0                     ;
                end else begin
                    `slave_rd.rvalid = 1                     ;
                    `slave_rd.rdata  = tr.rdata[rd_cnt % data_size] ;
                    rd_addr = (dma_width == 64) ? 8 * rd_cnt : 16 * rd_cnt;
                    rcounter--;
                    rd_cnt++;
                end
                if (rcounter == 0) begin  
                    `slave_rd.rlast  <= 1 ;
                end
                @(posedge `slave_rd.aclk)                    ; //could add random cycle
            end
            
            wait (((`slave_rd.rlast == 1) && (`slave_rd.rvalid == 1) && (`slave_rd.rready == 1))) begin
            `slave_rd.rlast  <= 0      ;
            `slave_rd.rvalid <= 0      ;
            end

    endtask

  /* virtual protected task axi_ar_channel(c_trans_axi tr);

         `uvm_info(get_name(),$sformatf(" drv_axi_read ------------------- : \n"),UVM_MEDIUM);
        while(`slave_rd.arvalid == 1'b0)
            @(posedge `slave_rd.aclk) ; //could add random cycle
        @(posedge `slave_rd.aclk) ; //could add random cycle
        `slave_rd.arready <= 1'b1                           ;    
        tr.araddr                    <=  `slave_rd.araddr   ;
        tr.arlen                     <=  `slave_rd.arlen    ;
        tr.arsize                    <=  `slave_rd.arsize   ;
        tr.arburst                   <=  `slave_rd.arburst  ;
        `uvm_info(get_name(),$sformatf(" drv_axi_read ------\n :%p  \n",tr),UVM_MEDIUM);
    
    endtask
    
    virtual protected task axi_rd_channel(c_trans_axi tr);

        int rd_cnt = 0;
        int rcounter = tr.arlen;
        `uvm_info(get_name(),$sformatf("************csd********\n :%p  \n",`slave_rd.arlen),UVM_MEDIUM);      
        while(`slave_rd.rlast == 0) begin
            
            @(posedge `slave_rd.aclk)         ; //could add random cycle
            while(`slave_rd.rready == 0)
                @(posedge `slave_rd.aclk)     ; //could add random cycle
            @(posedge `slave_rd.aclk)         ; //could add random cycle
            if(tr == null) begin //null //if has data len and data has ready to send,should valid the data ,or not data invalid
                `uvm_info(get_name(),$sformatf("error :drv_axi_read tr is null !!!"),UVM_MEDIUM);
                `slave_rd.rdata  = 0                     ;
                `slave_rd.rvalid = 0                    ;
            end else begin
                `slave_rd.rvalid = 1                    ;
                `slave_rd.rdata  = tr.rdata[rd_cnt]      ;
                rd_cnt++;
            end

            if(rd_cnt >= tr.m_axi_debug[0])  
                `slave_rd.rlast  <= 1      ;
            else 
                `slave_rd.rlast  <= 0      ;
            
        end
        while (!((`slave_rd.rlast == 1) && (`slave_rd.rvalid = 1) && (`slave_rd.rready = 1))) begin
            @(posedge `slave_rd.aclk)         ; //could add random cycle
        end //wait rlast finish 
        `slave_rd.rlast  <= 0      ;
        `slave_rd.rvalid <= 0      ;
         
     
    endtask
    */

    virtual protected task axi_aw_channel(c_trans_axi tr);

        while(`slave_wr.awvalid == 0)
            @(posedge `slave_wr.aclk) ; //could add random cycle
        @(posedge `slave_wr.aclk) ; //could add random cycle
        `slave_wr.awready <= 1                           ;    
        tr.awaddr                    <=  `slave_wr.awaddr   ;
        tr.awlen                     <=  `slave_wr.awlen    ;
        tr.awsize                    <=  `slave_wr.awsize   ;
        tr.awburst                   <=  `slave_wr.awburst  ;
    
    endtask

    virtual protected task axi_wr_channel(c_trans_axi tr); //write && response channel

        int wr_cnt ;
         wr_cnt          = 0              ;
        `slave_wr.wlast  = 0              ;
        `slave_wr.wdata  = 0              ;    
        `slave_wr.wready = 0              ;   
        `slave_wr.bready = 0              ;   
        
        while(`slave_wr.wlast == 0) begin
            @(posedge `slave_wr.aclk) ; //could add random cycle
            while(`slave_wr.awvalid == 0)
                @(posedge `slave_wr.aclk) ; //could add random cycle
            tr.wdata[wr_cnt]  = `slave_wr.wdata ;//data[i]   
            `slave_wr.bready = 1              ;  //response ready
            @(posedge `slave_wr.aclk)     ;
            `slave_wr.wready = 1       ;
            if(`slave_wr.wvalid && `slave_wr.wready) begin
                wr_cnt++;
                `slave_wr.wready = 0; //or random 0/1
            end
            if( tr.awlen >= wr_cnt )
                `slave_wr.wlast  <= 1              ;
       end
       if((`slave_wr.wlast == 1) && ( tr.awlen > wr_cnt ))
           `uvm_info(get_type_name(), $sformatf("may be error ,awlen:%d > wr_cnt:%d \n",tr.awlen,wr_cnt), UVM_MEDIUM) ;
       //write response
       while(!((`slave_wr.bvalid == 1) && (`slave_wr.bresp == 0) && (`slave_wr.bready == 1)))
           @(posedge `slave_wr.aclk)     ;
       @(posedge `slave_wr.aclk)         ;
       `slave_wr.bready = 0              ;  //response ready 
       
    
    endtask
    
endclass

`endif
