    ahb2apb DUT(
        .HCLK       (clk),
        .HRESETn 	(rst_n),
        .HADDR		(top_if.AHB_INF.HADDR),
        .HTRANS	    (top_if.AHB_INF.HTRANS),
        .HWRITE	    (top_if.AHB_INF.HWRITE),
        .HWDATA	    (top_if.AHB_INF.HWDATA),
        .HSELAHB	(top_if.AHB_INF.HSELAHB),
        .HRDATA	    (top_if.AHB_INF.HRDATA),
        .HREADY	    (top_if.AHB_INF.HREADY),
        .HRESP		(top_if.AHB_INF.HRESP),
        
	    .PRDATA	    (top_if.APB_INF.PRDATA),
        .PSLVERR	(top_if.APB_INF.PSLVERR),
        .PREADY	    (top_if.APB_INF.PREADY),
        .PWDATA	    (top_if.APB_INF.PWDATA),
        .PENABLE	(top_if.APB_INF.PENABLE),
        .PSELx		(top_if.APB_INF.PSELx),
        .PADDR		(top_if.APB_INF.PADDR),
        .PWRITE	    (top_if.APB_INF.PWRITE)
		);
