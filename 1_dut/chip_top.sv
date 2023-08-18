//===============================================================
//Copyright (c): ALL rights reserved. 
//                                                                 
//  Create by:
//      Email:
//       Date:
//   Filename:
//Description:
//    Version:
//Last Change:
//                                                                 
//===============================================================
                                                                 
`ifndef CHIP_TOP__SV
`define CHIP_TOP__SV

`include "chip_define.svh"
module chip_top();


    apb_if if_apb(clk);
    spi_if if_spi();
    apb_slave   apb_slv(if_apb.slave, if_spi.master, SPI_INT);



//========== axi noc ===========
	axi_xbar_intf #(
    .AXI_USER_WIDTH        ( TbAxiUserWidth  ),
    .Cfg                   ( xbar_cfg        ),
    .rule_t                ( rule_t          )
  ) u_axi_noc (
    .clk_i                  ( clk     ),
    .rst_ni                 ( rst_n   ),
    .test_i                 ( 1'b0    ),
    .slv_ports              ( top_if.master  ), //inside the top interface
    .mst_ports              ( top_if.slave   ), //inside the top interface
    .addr_map_i             ( AddrMap ),
    .en_default_mst_port_i  ( '0      ),
    .default_mst_port_i     ( '0      )
  );

//========== axi2apb ===========
    axi2apb_wrap #(
    .AXI_ADDR_WIDTH (32),
    .AXI_DATA_WIDTH (32),
    .AXI_USER_WIDTH (6 ),
    .AXI_ID_WIDTH   (6 ),
    .APB_ADDR_WIDTH (32),
    .APB_DATA_WIDTH (32)
) u_axi2apb (
    .clk_i     (clk           ),
    .rst_ni    (rst_n         ),
    .test_en_i (0             ),
    .axi_slave (top_if.slave  ),
    .apb_master(top_if.master )
);



//========== apb2spi_m ===========
    apb_spi_master
#(
    .BUFFER_DEPTH   (10),
    .APB_ADDR_WIDTH (12)  //APB slaves are 4KB by default
) u_apb2spi
(
    HCLK     (),  //input  logic                      
    HRESETn  (),  //input  logic                      
    PADDR    (),  //input  logic [APB_ADDR_WIDTH-1:0] 
    PWDATA   (),  //input  logic               [31:0] 
    PWRITE   (),  //input  logic                      
    PSEL     (),  //input  logic                      
    PENABLE  (),  //input  logic                      
    PRDATA   (),  //output logic               [31:0] 
    PREADY   (),  //output logic                      
    PSLVERR  (),  //output logic                      
    events_o (),  //output logic                [1:0] 

    spi_clk  (),  //output logic                      
    spi_csn0 (),  //output logic                      
    spi_csn1 (),  //output logic                      
    spi_csn2 (),  //output logic                      
    spi_csn3 (),  //output logic                      
    spi_mode (),  //output logic                [1:0] 
    spi_sdo0 (),  //output logic                      
    spi_sdo1 (),  //output logic                      
    spi_sdo2 (),  //output logic                      
    spi_sdo3 (),  //output logic                      
    spi_sdi0 (),  //input  logic                      
    spi_sdi1 (),  //input  logic                      
    spi_sdi2 (),  //input  logic                      
    spi_sdi3 ()   //input  logic                      
);

    wire SPI_INT ;
    apb_slave apb_slv(if_apb.slave, if_spi.master, SPI_INT);

//    AXI_BUS.Slave   axi_slave,
//    APB_BUS.Master  apb_master
endmodule

`endif
