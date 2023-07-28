//  Class: axi_write_seq
`ifndef AXI_WRITE_SEQ__SV
`define AXI_WRITE_SEQ__SV
class axi_write_seq#(D_WIDTH = 16, int A_WIDTH = 16) extends uvm_sequence;
    `uvm_object_param_utils(axi_write_seq#(D_WIDTH, A_WIDTH));
    
    //  Group: Variables
    const int no_of_trans;
    bit[7:0] id;
    axi_transaction#(D_WIDTH, A_WIDTH) trans;
    test_config test_cfg;

    //  Constructor: new
    function new(string name = "axi_write_seq");
        super.new(name);
        test_cfg = new("test_cfg");
        if(!uvm_config_db#(test_config)::get(null, "uvm_test_top.seq", "config", test_cfg)) 
            `uvm_fatal(get_name(), "config cannot be found in ConfigDB!")
        
        no_of_trans = test_cfg.no_write_cases;
    endfunction: new

    //  Task: body
    //  This is the user-defined task where the main sequence code resides.
    extern virtual task body();
    
endclass: axi_write_seq

task axi_write_seq::body();
    repeat(no_of_trans) begin
        id++;
        trans = axi_transaction#(D_WIDTH, A_WIDTH)::type_id::create("trans");
        if(test_cfg.isAligned) begin
            trans.addr_val_align.constraint_mode(1);
            trans.addr_val_unalign.constraint_mode(0);
            trans.addr_val.constraint_mode(0);
        end
        else if (!test_cfg.isAligned) begin
            trans.addr_val_align.constraint_mode(0);
            trans.addr_val_unalign.constraint_mode(1);
            trans.addr_val.constraint_mode(0);
        end
        else begin
            trans.addr_val_align.constraint_mode(0);
            trans.addr_val_unalign.constraint_mode(0);
            trans.addr_val.constraint_mode(1);
        end
        start_item(trans);
        `uvm_info(get_name(), $sformatf("inside seq  count : %0d / %0d",id, no_of_trans ), UVM_NONE)
        if(test_cfg.burst_type == 0)
            assert(trans.randomize() with { b_type == FIXED; });
        else if(test_cfg.burst_type == 1)
            assert(trans.randomize() with { b_type == INCR; });
        else if(test_cfg.burst_type == 2)
            assert(trans.randomize() with { b_type == WRAP; });
        else
            assert(trans.randomize());
        trans.id = {1'b0, id};
        `uvm_info(get_name(), $sformatf("inside_22 seq :%p ", trans ), UVM_NONE)
        finish_item(trans);
        `uvm_info(get_name(), $sformatf("inside_33 seq :%p ", trans.print() ), UVM_NONE)
        #10;
    end
endtask: body
`endif
