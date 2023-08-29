
/** 
 * Abstract: A HDL Interconnect wrapper that connects the Verilog HDL
 * Interconnect to the SystemVerilog interface.
 */

`ifndef GUARD_APB_SVT_DUT_SV_WRAPPER_SV
`define GUARD_APB_SVT_DUT_SV_WRAPPER_SV

`include "apb_svt_dut.v"
`include "svt_apb_if.svi"

module apb_svt_dut_sv_wrapper(svt_apb_if apb_dut_master_if, svt_apb_if apb_dut_slave_if);
  wire [(`SVT_APB_MAX_NUM_SLAVES-1):0] local_psel;
  wire local_penable;
  wire local_pwrite;
  wire [(`SVT_APB_MAX_ADDR_WIDTH - 1):0] local_paddr;
  wire [(`SVT_APB_PWDATA_WIDTH-1):0]     local_pwdata;
  wire [((`SVT_APB_PWDATA_WIDTH/8)-1):0] local_pstrb;
  wire [2:0]                             local_pprot;
  wire [(`SVT_APB_PWDATA_WIDTH-1):0]     local_prdata;
  wire                                   local_pready;
  wire                                   local_pslverr;

  apb_svt_dut apb_svt_dut (
    // Master side master signals
    .psel_m    (apb_dut_master_if.psel),
    .penable_m (apb_dut_master_if.penable),
    .pwrite_m  (apb_dut_master_if.pwrite),
    .paddr_m   (apb_dut_master_if.paddr),
    .pwdata_m  (apb_dut_master_if.pwdata),
    .pstrb_m   (apb_dut_master_if.pstrb),
    .pprot_m   (apb_dut_master_if.pprot),

    // Master side slave signals
    .prdata_m0  (local_prdata),
    .pready_m0  (local_pready),
    .pslverr_m0 (local_pslverr),

    // Slave side master signals
    .psel_s    (local_psel),
    .penable_s (local_penable),
    .pwrite_s  (local_pwrite),
    .paddr_s   (local_paddr),
    .pwdata_s  (local_pwdata),
    .pstrb_s   (local_pstrb),
    .pprot_s   (local_pprot),

    // Slave side slave signals
    .prdata_s0  (apb_dut_slave_if.slave_if[0].prdata),
    .pready_s0  (apb_dut_slave_if.slave_if[0].pready),
    .pslverr_s0 (apb_dut_slave_if.slave_if[0].pslverr)
  );

  always @ (*) assign apb_dut_slave_if.psel = local_psel;
  always @ (*) assign apb_dut_slave_if.penable = local_penable;
  always @ (*) assign apb_dut_slave_if.pwrite = local_pwrite;
  always @ (*) assign apb_dut_slave_if.paddr = local_paddr;
  always @ (*) assign apb_dut_slave_if.pwdata = local_pwdata;
  always @ (*) assign apb_dut_slave_if.pstrb = local_pstrb;
  always @ (*) assign apb_dut_slave_if.pprot = local_pprot;
  always @ (*) assign apb_dut_master_if.slave_if[0].prdata = local_prdata;
  always @ (*) assign apb_dut_master_if.slave_if[0].pready = local_pready;
  always @ (*) assign apb_dut_master_if.slave_if[0].pslverr = local_pslverr;

endmodule
`endif // GUARD_APB_SVT_DUT_SV_WRAPPER_SV
