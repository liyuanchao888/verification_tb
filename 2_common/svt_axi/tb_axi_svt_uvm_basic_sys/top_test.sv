
/**
 * Abstract:  This file serve as a top-level test file, which just
 * pulls in the individual tests by including them.
 */
`include "ts.base_test.sv"
`include "ts.directed_test.sv"
`include "ts.random_wr_rd_test.sv"
`include "ts.reorder_wr_rd_test.sv"
`include "ts.config_creator_test.sv"
`include "ts.directed_4kboundary_test.sv"
`include "ts.axi_unaligned_backdoor_write_read_test.sv"
`include "ts.axi_slave_mem_diff_data_width_response_test.sv"

