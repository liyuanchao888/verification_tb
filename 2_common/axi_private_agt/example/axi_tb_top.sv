
//`include "axi_package.svh"
`include "axi_interface.sv"

module test_top;
    bit clk, rstn;

    always #5 clk = ~clk;

    initial rstn = 1;

    axi_intf#(.A_WIDTH(A_WIDTH), .D_WIDTH(D_WIDTH)) intf(clk, rstn);

    env_config env_cfg;

    initial begin
        env_cfg = new();
        env_cfg.intf = intf;
        uvm_config_db#(env_config)::set(null, "uvm_test_top", "config", env_cfg);
        uvm_config_db#(env_config)::set(null, "uvm_test_top.env.master", "config", env_cfg);
        uvm_config_db#(env_config)::set(null, "uvm_test_top.env.slave", "config", env_cfg);
        run_test("axi_base_test");
    end

    initial begin
	    string f;
        `ifdef INCA
            $recordvars();
        `elsif QUESTA
            $wlfdumpvars();
            set_config_int("*", "recording_detail", 1);
        `else  //if no assign simulator , will use the VCS as default
            `ifdef DUMP_FSDB
			    `ifndef WAVE_CFG
        		    $value$plusargs("fsdbfile=%s",f);
					`ifndef PLL_WAVE_ON
//					    $fsdbSuppress(test_top.top.u_prcm.u_prcm_pll); //no dump pll to accelerate sim
				    `endif
					$fsdbDumpfile(f);
					$fsdbDumpvars;
					$fsdbDumpMDA;
                    `ifdef CR_UPF_ON
				        $fsdbDumpvars("+power")
					`endif
				`endif
    		`elsif DUMP_VCD
			    $vcdpluson;
			`endif
        `endif
    end
    
endmodule
