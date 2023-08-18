`ifndef C_DRV_APB__SV
`define C_DRV_APB__SV

`define apb_master m_vif_apb

class c_drv_apb extends uvm_driver #(c_trans_apb);
    `uvm_component_utils(c_drv_apb)
    virtual if_apb m_vif_apb;
    int read_en,write_en;
    c_tb_cfg    m_tb_cfg  = new(); 
    c_trans_apb req;          //from sqr_apb.port
    c_trans_apb m_trans_apb;

    uvm_put_port #(c_trans_apb) m_drv_port;
    uvm_put_port #(c_trans_apb) m_apb_to_axi_port;
    uvm_put_port #(c_trans_apb) m_apb_to_sif_port;
    enum {WR,RD} m_op_kind;

    function new(string name = "c_drv_apb", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_drv_port = new("m_drv_port",this);
        m_apb_to_axi_port = new("m_apb_to_axi_port",this);
        m_apb_to_sif_port = new("m_apb_to_sif_port",this);
        assert(uvm_config_db#(virtual if_apb)::get(this, "", "m_vif_apb", m_vif_apb));
        m_tb_cfg.file_re();
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("====== drv_apb run_phase :start ===== \n"), UVM_MEDIUM)
        fork
            reset_signals();
            get_and_drive(phase);
        join
        `uvm_info(get_type_name(), $sformatf("****** drv_apb run_phase :end ******** \n"), UVM_MEDIUM)
    endtask

    virtual protected task reset_signals();
        wait (m_vif_apb.rst_n === 1'b0);
            m_vif_apb.paddr   = 0;
            m_vif_apb.pwdata  = 0;
            m_vif_apb.pwdata  = 0;
            m_vif_apb.pwrite  = 0;
            m_vif_apb.psel    = 0;
            m_vif_apb.penable = 0;
            m_vif_apb.pstrb   = 0;
    `uvm_info(get_name()," drv reset start ,reset m_vif_apb \n",UVM_MEDIUM);
    endtask

    virtual protected task get_and_drive(uvm_phase phase);
        int i=0;
        read_en = m_tb_cfg.h_array["rctrl_reg"];
        write_en = m_tb_cfg.h_array["wctrl_reg"];
        `uvm_info(get_type_name(), $sformatf("###APB configure from reg model ### rd = %d,wr = %d \n",read_en,write_en), UVM_MEDIUM)

        wait(m_vif_apb.rst_n == 0);
        @(posedge m_vif_apb.rst_n);
        @(posedge m_vif_apb.clk);
        forever begin
            @ (posedge m_vif_apb.clk) ;
            i++;
            seq_item_port.get_next_item(req);
            m_trans_apb = new();
            m_trans_apb.do_copy(req);
            seq_item_port.item_done();

            drive_transfer(m_trans_apb);
        end
        
    endtask

    virtual protected task drive_transfer(c_trans_apb tr);
      if(tr.op_kind == c_trans_apb::RD)
          apb_read(tr);
      else
          apb_write(tr);
    endtask
    
    virtual protected task apb_write(c_trans_apb tr);
        //master apb write
        `uvm_info(get_name(),$sformatf(" drv_apb_write ------------------- : \n"),UVM_MEDIUM);
        `apb_master.pstrb   <= tr.pstrb   ; //valid byte
        @(posedge m_vif_apb.pclk)
        `apb_master.paddr   <= tr.paddr   ; //address
        `apb_master.pwrite  <= 1'b1                ; //select read(0)/write(1)
        `apb_master.psel    <= 1'b1                ; //select slave
        `apb_master.pwdata  <= tr.pwdata  ; //write data
        
        @(posedge m_vif_apb.pclk);
        `apb_master.penable <= #0 1'b1             ; //enable the read/write operation
        while(!`apb_master.pready)
             @(posedge m_vif_apb.pclk);
        @(posedge m_vif_apb.pclk)
        `apb_master.psel    <= 1'b0                ; //select slave
        `apb_master.pwdata  <= 32'b0               ; //write data
        `apb_master.penable <= #0 1'b0             ; //enable the read/write operation
    endtask

    virtual protected task apb_read(c_trans_apb tr);
        //master apb read
        `uvm_info(get_name(),$sformatf("drv_apb_read -------------------"),UVM_MEDIUM);
        `apb_master.pstrb   <= tr.pstrb   ; //valid byte
        @(posedge m_vif_apb.pclk)
        `apb_master.paddr   <= tr.paddr   ; //address
        `apb_master.pwrite  <= 1'b0                ; //select read(0)/write(1)
        `apb_master.psel    <= 1'b1                ; //select slave
        
        @(posedge m_vif_apb.pclk);
        `apb_master.penable <= #0 1'b1             ; //enable the read/write operation
        while(!`apb_master.pready)
             @(posedge m_vif_apb.pclk);
        m_trans_apb.prdata    <= `apb_master.prdata ; //write data
        @(posedge m_vif_apb.pclk)
        `apb_master.psel    <= 1'b0                 ; //select slave
        `apb_master.prdata  <= 32'b0                ; //write data
        `apb_master.penable <= #0 1'b0              ; //enable the read/write operation
    endtask
 
endclass

`endif
