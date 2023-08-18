`ifndef C_AGT_AXI__SV
`define C_AGT_AXI__SV

class c_agt_axi extends uvm_agent;
    c_sqr_axi      m_sqr;
    c_drv_axi      m_drv;
    c_mon_axi      m_mon;
    virtual if_axi m_vif_axi;
    uvm_put_port #(c_trans_axi) m_agt_port; //to rm
    uvm_blocking_get_port #(c_trans_apb) m_apb_to_axi_port ; //from apb_agent
    uvm_analysis_port #(c_trans_axi) ap; //monitor to scb

    `uvm_component_utils(c_agt_axi)

    function new(string name = "c_agt_axi", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_sqr = c_sqr_axi::type_id::create("m_sqr", this);
        m_drv = c_drv_axi::type_id::create("m_drv", this);
        m_mon = c_mon_axi::type_id::create("m_mon", this);
        m_agt_port = new("m_agt_port",this); //new output port
        m_apb_to_axi_port   = new("m_apb_to_axi_port ", this); //from apb_agent
        if(!uvm_config_db#(virtual if_axi)::get(this,"","m_vif_axi",m_vif_axi))
            `uvm_fatal("agent:no vif","the virtual if get is not successful");
        uvm_config_db#(virtual if_axi)::set(this,"m_drv","m_vif_axi",m_vif_axi);
        uvm_config_db#(virtual if_axi)::set(this,"m_mon","m_vif_axi",m_vif_axi);


    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_drv.seq_item_port.connect(m_sqr.seq_item_export);
        m_drv.m_drv_port.connect(m_agt_port); //drv -to- agt
        m_drv.m_apb_to_axi_port.connect(m_apb_to_axi_port); //apb_agt to axi_agt
        `uvm_info(get_name()," agent connect phase ,",UVM_MEDIUM);
        ap = m_mon.ap;
    endfunction
endclass: c_agt_axi

`endif //C_AGT_AXI__SV
