`ifndef C_CPU_OP__SV
`define C_CPU_OP__SV

class c_cpu_op extends uvm_component;
  c_reg_model m_reg_model = new();
  c_tb_cfg    m_tb_cfg    = new();
  function new(string name="c_cpu_op",uvm_component parent = null,c_reg_model reg_model);
       super.new(name,parent);
          m_reg_model = reg_model ;

  endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		uvm_config_db #(c_tb_cfg)::get(this,"","m_tb_cfg",m_tb_cfg);		

    endfunction:build_phase
  virtual task inital_cpu();
        uvm_status_e    status;
        uvm_reg_data_t  value;

        m_tb_cfg.file_re(); //read cfg file

        if(m_reg_model == null) begin
            `uvm_info(get_name(),$sformatf(" [error]cpu op reg_model\n"),UVM_MEDIUM);
            return;
        end
        m_reg_model.print();
        //config register
        m_reg_model.id_reg.write(status, m_tb_cfg.h_array["id_reg"], UVM_FRONTDOOR);
        //dma read
        m_reg_model.rmaddr_reg.write(status, m_tb_cfg.h_array["rmaddr_reg"], UVM_FRONTDOOR);
        m_reg_model.rsize_reg.write(status, m_tb_cfg.h_array["rsize_reg"], UVM_FRONTDOOR);
        m_reg_model.rcfg_reg.write(status, m_tb_cfg.h_array["rcfg_reg"], UVM_FRONTDOOR);
        m_reg_model.block_reg.write(status, m_tb_cfg.h_array["block_reg"], UVM_FRONTDOOR);
        m_reg_model.rctrl_reg.write(status,m_tb_cfg.h_array["rctrl_reg"], UVM_FRONTDOOR);
        //dma write
        m_reg_model.wmaddr_reg.write(status, m_tb_cfg.h_array["wmaddr_reg"], UVM_FRONTDOOR);
        m_reg_model.wsize_reg.write(status, m_tb_cfg.h_array["wsize_reg"], UVM_FRONTDOOR);
        m_reg_model.wcfg_reg.write(status, m_tb_cfg.h_array["wcfg_reg"], UVM_FRONTDOOR);
        m_reg_model.wctrl_reg.write(status,m_tb_cfg.h_array["wctrl_reg"], UVM_FRONTDOOR);
//        m_reg_model.status_reg.read(status, m_tb_cfg.h_array["status_reg"], UVM_FRONTDOOR);

    //    `uvm_info(get_name(),$sformatf(" id_reg is %h\n",m_tb_cfg.h_array["id_reg"]),UVM_MEDIUM);
    //    `uvm_info(get_name(),$sformatf(" status_reg is %h\n",m_tb_cfg.h_array["status_reg"]),UVM_MEDIUM);
    //    `uvm_info(get_name(),$sformatf(" rsize_reg is %h\n",m_tb_cfg.h_array["rsize_reg"]),UVM_MEDIUM);
    endtask
endclass: c_cpu_op

`endif //C_CPU_OP__SV
