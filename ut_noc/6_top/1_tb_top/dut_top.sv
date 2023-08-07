
	axi_xbar_intf #(
    .AXI_USER_WIDTH        ( TbAxiUserWidth  ),
    .Cfg                   ( xbar_cfg        ),
    .rule_t                ( rule_t          )
  ) DUT (
    .clk_i                  ( clk     ),
    .rst_ni                 ( rst_n   ),
    .test_i                 ( 1'b0    ),
    .slv_ports              ( top_if.master  ), //inside the top interface
    .mst_ports              ( top_if.slave   ), //inside the top interface
    .addr_map_i             ( AddrMap ),
    .en_default_mst_port_i  ( '0      ),
    .default_mst_port_i     ( '0      )
  );


//  ahb2apb DUT(
//        .HCLK       (clk),
//        .HRESETn 	(rst_n),
//        .HADDR		(top_if.AHB_INF.HADDR),
//        .HTRANS	    (top_if.AHB_INF.HTRANS),
//        .HWRITE	    (top_if.AHB_INF.HWRITE),
//        .HWDATA	    (top_if.AHB_INF.HWDATA),
//        .HSELAHB	(top_if.AHB_INF.HSELAHB),
//        .HRDATA	    (top_if.AHB_INF.HRDATA),
//        .HREADY	    (top_if.AHB_INF.HREADY),
//        .HRESP		(top_if.AHB_INF.HRESP),
//        
//	    .PRDATA	    (top_if.APB_INF.PRDATA),
//        .PSLVERR	(top_if.APB_INF.PSLVERR),
//        .PREADY	    (top_if.APB_INF.PREADY),
//        .PWDATA	    (top_if.APB_INF.PWDATA),
//        .PENABLE	(top_if.APB_INF.PENABLE),
//        .PSELx		(top_if.APB_INF.PSELx),
//        .PADDR		(top_if.APB_INF.PADDR),
//        .PWRITE	    (top_if.APB_INF.PWRITE)
//		);
