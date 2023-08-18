`ifndef C_MON_AXI__SV
`define C_MON_AXI__SV
`define slave_wr m_vif_axi 

class c_mon_axi extends uvm_monitor;

   virtual if_axi m_vif_axi;
   c_trans_axi tr;
   c_trans_axi m_trans_axi;
   uvm_analysis_port#(c_trans_axi) ap;

   `uvm_component_utils(c_mon_axi)

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction: new

   extern virtual function void build_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual task reset_signals();
   extern virtual task trans_observed(uvm_phase phase);
   extern virtual task axi_aw_channel(c_trans_axi tr);
   extern virtual task axi_wr_channel(c_trans_axi tr); //write && response channel

endclass: c_mon_axi
   
    function void c_mon_axi::build_phase(uvm_phase phase);
      super.build_phase(phase);
         if (!uvm_config_db#(virtual if_axi)::get(this, "", "m_vif_axi", m_vif_axi)) begin
            `uvm_fatal("APB/MON/NOVIF", "No virtual interface specified for this monitor instance")
         end
   endfunction

   task c_mon_axi::run_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("====== run_phase :start ===== \n"), UVM_MEDIUM)
      super.run_phase(phase);
        fork
            reset_signals();
            trans_observed(phase);

        join
      `uvm_info(get_type_name(), $sformatf("****** run_phase :end   ****** \n"), UVM_MEDIUM)
   endtask //run_phase

    task c_mon_axi::reset_signals();
        wait (m_vif_axi.rst_n === 1'b0);
            m_vif_axi.awready = 0;
            m_vif_axi.wready  = 0;
            m_vif_axi.bvalid  = 0;
            m_vif_axi.bid     = 0;
            m_vif_axi.bresp   = 0;
       `uvm_info(get_name()," reset mon_axi m_vif_axi dma_write ",UVM_MEDIUM);
    endtask

    task c_mon_axi::trans_observed(uvm_phase phase);
        int i=0;
        `uvm_info(get_name()," mon_axi trans_observed ,",UVM_MEDIUM);
        wait(m_vif_axi.rst_n == 0);
        @(posedge m_vif_axi.rst_n);
        `uvm_info(get_name()," mon_axi wait rst_n release 1 ,",UVM_MEDIUM);
        @(posedge m_vif_axi.clk);
        
        forever begin
            i++;
            m_trans_axi = new("m_trans_axi");
            tr          = new("tr");
            void'(m_trans_axi.randomize());
            void'(tr.randomize());
            fork
                c_mon_axi::axi_aw_channel(m_trans_axi); //write address
                c_mon_axi::axi_wr_channel(m_trans_axi); //write data
            join
            tr.do_copy(m_trans_axi);
            `uvm_info(get_name(),$sformatf(" mon_axi[%d] receive data_que:%p",i,m_trans_axi.wdata_que),UVM_MEDIUM);
            ap.write(tr);
        end
    endtask


    task c_mon_axi::axi_aw_channel(c_trans_axi tr);

        while(`slave_wr.awvalid == 0)
            @(posedge `slave_wr.aclk) ; //could add random cycle
        @(posedge `slave_wr.aclk) ; //could add random cycle
        `slave_wr.awready <= 1                           ;    
        tr.awaddr                    <=  `slave_wr.awaddr   ;
        tr.awlen                     <=  `slave_wr.awlen    ;
        tr.awsize                    <=  `slave_wr.awsize   ;
        tr.awburst                   <=  `slave_wr.awburst  ;
    
    endtask

    
    task c_mon_axi::axi_wr_channel(c_trans_axi tr); //write && response channel

        int wr_cnt,wfinish ;
         wr_cnt          = 0              ;
        `slave_wr.wready = 0              ;   
        `slave_wr.bvalid = 0              ;   
        `slave_wr.bid    = 0              ;   
        `slave_wr.bresp  = 0              ;   
        `uvm_info(get_type_name(), $sformatf("ready to wr:%d >=mon_axi_wr_cnt:%d \n",tr.awlen,wr_cnt), UVM_MEDIUM) ;
        
        wfinish       = 0              ;   //the flag of finish a brust opereation in axi wr channel(1:valid)   
        tr.wdata_que.delete()          ;

        while(wfinish == 0) begin
            @(posedge `slave_wr.aclk) ; //could add random cycle
            while(`slave_wr.wvalid == 0)
                @(posedge `slave_wr.aclk) ; //could add random cycle
            @(posedge `slave_wr.aclk)     ;
            `slave_wr.wready = 1       ;
            while (!(`slave_wr.wvalid && `slave_wr.wready)) begin
                @(posedge `slave_wr.aclk)     ;
             end
             @(negedge `slave_wr.aclk)     ;

            `uvm_info(get_type_name(), $sformatf("rec_axi_dat time:%t  ",$time), UVM_MEDIUM) ;
            tr.wdata = `slave_wr.wdata ;
            tr.wdata_que.push_back(tr.wdata);//data[i]   
            wr_cnt++;
            if(`slave_wr.wlast == 1) begin
                wfinish = 1;
                `uvm_info(get_type_name(), $sformatf("wlast time:%t  ",$time), UVM_MEDIUM) ;
                @(posedge `slave_wr.aclk) ;
                break; 
            end
            @(posedge `slave_wr.aclk)     ;
            `slave_wr.wready = 0; //or random 0/1
       end
       
       if((`slave_wr.wlast == 1) && ( tr.awlen > wr_cnt ))
           `uvm_info(get_type_name(), $sformatf("error , please check awlen:%d > wr_cnt:%d \n",tr.awlen,wr_cnt), UVM_MEDIUM) ;
       //write response
       `slave_wr.bvalid = 1              ;  //response bvalid 
       while(!((`slave_wr.bvalid == 1) && (`slave_wr.bresp == 0) && (`slave_wr.bready == 1))) //wait bready
           @(posedge `slave_wr.aclk)     ;
       @(posedge `slave_wr.aclk)         ;
       `slave_wr.bvalid = 0              ;  //response bvalid    
    
    endtask

`endif//C_APB_MON__SV


