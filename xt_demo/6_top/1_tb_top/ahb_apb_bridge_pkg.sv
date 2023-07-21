package ahb_apb_bridge_pkg;

    int number_of_transactions = 1000;

    import uvm_pkg :: *;
    `include "uvm_macros.svh"

    `include "../../../2_common/ahb_private_agt/ahb_sequence_item.sv"
    `include "../../../xt_demo/5_env/ahb_apb_bridge_env_config.sv"
    `include "../../../2_common/ahb_private_agt/ahb_sequencer.sv"
    `include "../../../2_common/ahb_private_agt/ahb_driver.sv"
    `include "../../../2_common/ahb_private_agt/ahb_monitor.sv"
    `include "../../../2_common/ahb_private_agt/ahb_agent.sv"
    `include "../../../2_common/ahb_private_agt/ahb_sequence.sv"

    `include "../../../2_common/apb_private_agt/apb_sequence_item.sv"
    `include "../../../2_common/apb_private_agt/apb_sequencer.sv"
    `include "../../../2_common/apb_private_agt/apb_driver.sv"
    `include "../../../2_common/apb_private_agt/apb_monitor.sv"
    `include "../../../2_common/apb_private_agt/apb_agent.sv"
    `include "../../../2_common/apb_private_agt/apb_sequence.sv"
    
	`include "../../../xt_demo/4_scb/ahb_apb_bridge_scoreboard.sv"
    `include "../../../xt_demo/5_env/ahb_apb_bridge_environment.sv"

//    `include "../../../xt_demo/6_top/2_tc/tc.list"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_base_test.sv"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_burst_write_test.sv"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_single_write_test.sv"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_single_read_test.sv"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_burst_read_test.sv"
    `include "../../../xt_demo/6_top/2_tc/ahb_apb_bridge_random_test.sv"

endpackage
