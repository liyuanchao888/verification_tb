`ifndef C_AGT_SIF__SV
`define C_AGT_SIF__SV

class c_agt_sif extends uvm_agent;
    `uvm_component_utils(c_agt_sif)
    c_sqr_sif      m_sqr;
    c_drv_sif      m_drv;
    c_mon_sif      m_mon;
    virtual if_sif m_vif_sif0;
    virtual if_sif m_vif_sif1;
    virtual if_sif m_vif_sif2;
    virtual if_sif m_vif_sif3;
    virtual if_sif m_vif_sif4;
    virtual if_sif m_vif_sif5;
    virtual if_sif m_vif_sif6;
    virtual if_sif m_vif_sif7;
    uvm_put_port #(c_trans_sif) m_agt_port;
    uvm_blocking_get_port #(c_trans_apb) m_apb_to_sif_port ; //from apb_agent
    uvm_analysis_port #(c_trans_sif) ap;


    function new(string name = "c_agt_sif", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_sqr = c_sqr_sif::type_id::create("m_sqr", this);
        m_drv = c_drv_sif::type_id::create("m_drv", this);
        m_mon = c_mon_sif::type_id::create("m_mon", this);
        m_agt_port = new("m_agt_port",this); //new output port
        m_apb_to_sif_port   = new("m_apb_to_sif_port ", this); //from apb_agent
//        item_collected_port = new("item_collected_port", this);
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif0",m_vif_sif0))
            `uvm_fatal("agent:no vif","the virtual sif0 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif1",m_vif_sif1))
            `uvm_fatal("agent:no vif","the virtual sif1 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif2",m_vif_sif2))
            `uvm_fatal("agent:no vif","the virtual sif2 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif3",m_vif_sif3))
            `uvm_fatal("agent:no vif","the virtual sif3 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif4",m_vif_sif4))
            `uvm_fatal("agent:no vif","the virtual sif4 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif5",m_vif_sif5))
            `uvm_fatal("agent:no vif","the virtual sif5 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif6",m_vif_sif6))
            `uvm_fatal("agent:no vif","the virtual sif6 get is not successful");
        if(!uvm_config_db#(virtual if_sif)::get(this,"","m_vif_sif7",m_vif_sif7))
            `uvm_fatal("agent:no vif","the virtual sif7 get is not successful");

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif0",m_vif_sif0);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif0",m_vif_sif0);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif1",m_vif_sif1);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif1",m_vif_sif1);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif2",m_vif_sif2);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif2",m_vif_sif2);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif3",m_vif_sif3);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif3",m_vif_sif3);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif4",m_vif_sif4);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif4",m_vif_sif4);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif5",m_vif_sif5);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif5",m_vif_sif5);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif6",m_vif_sif6);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif6",m_vif_sif6);

        uvm_config_db#(virtual if_sif)::set(this,"m_drv","m_vif_sif7",m_vif_sif7);
        uvm_config_db#(virtual if_sif)::set(this,"m_mon","m_vif_sif7",m_vif_sif7);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_drv.seq_item_port.connect(m_sqr.seq_item_export);
        m_drv.m_drv_port.connect(m_agt_port); //drv -to- agt
        m_drv.m_apb_to_sif_port.connect(m_apb_to_sif_port); //apb_agt to sif_agt
        `uvm_info(get_name()," agent connect phase ,",UVM_MEDIUM);
        ap = m_mon.ap;
    endfunction
endclass: c_agt_sif

`endif //C_AGT_SIF__SV
