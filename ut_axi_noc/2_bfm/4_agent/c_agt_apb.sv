`ifndef C_AGT_APB__SV
`define C_AGT_APB__SV

class c_agt_apb extends uvm_agent;
    c_sqr_apb      m_sqr;
    c_drv_apb      m_drv;
    c_mon_apb      m_mon;
    virtual if_apb m_vif_apb;
    uvm_put_port #(c_trans_apb) m_agt_port; //to rm
    uvm_put_port #(c_trans_apb) m_apb_to_axi_port; //to drv_axi
    uvm_put_port #(c_trans_apb) m_apb_to_sif_port; //to drv_axi

    uvm_analysis_port #(c_trans_apb) item_collected_port;

    `uvm_component_utils(c_agt_apb)

    function new(string name = "c_agt_apb", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_sqr = c_sqr_apb::type_id::create("m_sqr", this);
        m_drv = c_drv_apb::type_id::create("m_drv", this);
        m_mon = c_mon_apb::type_id::create("m_mon", this);
        m_agt_port = new("m_agt_port",this); //new output port
        m_apb_to_axi_port = new("m_apb_to_axi_port",this); 
        m_apb_to_sif_port = new("m_apb_to_sif_port",this); 
        item_collected_port = new("item_collected_port", this);
        if(!uvm_config_db#(virtual if_apb)::get(this,"","m_vif_apb",m_vif_apb))
            `uvm_fatal("agent:no vif","the virtual if get is not successful");
        uvm_config_db#(virtual if_apb)::set(this,"m_drv","m_vif_apb",m_vif_apb);
        uvm_config_db#(virtual if_apb)::set(this,"m_mon","m_vif_apb",m_vif_apb);


    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_drv.seq_item_port.connect(m_sqr.seq_item_export);
        m_drv.m_drv_port.connect(m_agt_port); //drv -to- agt
        m_drv.m_apb_to_axi_port.connect(this.m_apb_to_axi_port); //drv -to- agt
        m_drv.m_apb_to_sif_port.connect(this.m_apb_to_sif_port); //drv -to- agt
        `uvm_info(get_name()," agent connect phase ,",UVM_MEDIUM);
        m_mon.ap.connect(item_collected_port);
    endfunction
endclass: c_agt_apb

`endif //C_AGT_APB__SV
