`ifndef C_DRV_SIF__SV
`define C_DRV_SIF__SV

class c_drv_sif extends uvm_driver #(c_trans_sif);
    parameter dma_width = `DMA_WIDTH;
    `uvm_component_utils(c_drv_sif)
    virtual if_sif m_vif_sif0;
    virtual if_sif m_vif_sif1;
    virtual if_sif m_vif_sif2;
    virtual if_sif m_vif_sif3;
    virtual if_sif m_vif_sif4;
    virtual if_sif m_vif_sif5;
    virtual if_sif m_vif_sif6;
    virtual if_sif m_vif_sif7;

    c_trans_sif req; //from sqr_apb.port
    c_trans_sif m_trans_sif;
    c_tb_cfg    m_tb_cfg2    = new();
    uvm_put_port #(c_trans_sif) m_drv_port;
    uvm_blocking_get_port #(c_trans_apb) m_apb_to_sif_port ; //for tmp no register
    int wr_cnt = 0;
    
    function new(string name = "c_drv_sif", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_drv_port = new("m_drv_port",this);
        m_apb_to_sif_port   = new("m_apb_to_sif_port ", this); //from apb_agent
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif0", m_vif_sif0));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif1", m_vif_sif1));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif2", m_vif_sif2));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif3", m_vif_sif3));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif4", m_vif_sif4));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif5", m_vif_sif5));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif6", m_vif_sif6));
        assert(uvm_config_db#(virtual if_sif)::get(this, "", "m_vif_sif7", m_vif_sif7));
		assert(uvm_config_db#(c_tb_cfg)::get(this,"","m_tb_cfg2",m_tb_cfg2));		
        m_tb_cfg2.file_re(); //read cfg file
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
        wait (m_vif_sif0.rst_n === 1'b0);
            m_vif_sif0.dn_vld = 0;
            m_vif_sif0.dn_dat = 0;
       `uvm_info(get_name()," drv reset start ,reset m_vif_sif0",UVM_MEDIUM);
    endtask

    virtual protected task get_and_drive(uvm_phase phase);
        int i=0;
        int dma_wr_byte_size;  
        wait(m_vif_sif0.rst_n == 0);
        @(posedge m_vif_sif0.rst_n);
        @(posedge m_vif_sif0.clk);
        
        forever begin
            i++;
            wr_cnt = 0; //one dma_write has many sif_dn_data
            dma_wr_byte_size = (((m_tb_cfg2.h_array["wsize_reg"])>>16)+1)*(((m_tb_cfg2.h_array["wsize_reg"])&16'hffff)+1);
           
            `uvm_info(get_name(),$sformatf(" drv_sif#######[%0d] start \n",i),UVM_MEDIUM);
            
            seq_item_port.get_next_item(req);
            m_trans_sif = new();
            m_trans_sif.do_copy(req);
            m_trans_sif.m_sif_debug[0] = (dma_width == 64) ? ((dma_wr_byte_size+7)>>3) : ((dma_wr_byte_size+15)>>4) ; 
            seq_item_port.item_done();

            m_drv_port.put(m_trans_sif); //trans from drv to RM
            drive_transfer(m_trans_sif); //trans from drv to DUT
        end
    endtask
    
    virtual protected task drive_transfer(c_trans_sif tr);

           for(int i=0;i<tr.m_sif_debug[0];i++) begin
                dn_stream(tr);
           end
    endtask

    virtual protected task dn_stream(c_trans_sif tr); // upstream
               
        @(posedge m_vif_sif0.dn_stream.clk) ; //could add random cycle
        m_vif_sif0.dn_stream.dn_vld = 1         ;
        while(!((m_vif_sif0.dn_stream.dn_vld == 1) && (m_vif_sif0.dn_stream.dn_rdy == 1))) begin
            m_vif_sif0.dn_stream.dn_dat = tr.dn_data[wr_cnt] ;
            @(posedge m_vif_sif0.dn_stream.clk) ; //could add random cycle
        end
        wr_cnt ++;
    endtask
  
endclass

`endif
