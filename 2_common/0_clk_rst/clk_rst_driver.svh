
//////////////////////////////////////////////////////////////////////////
// (c) 2013 Mobiveil Inc.
//
//  File        : clk_rst_driver.svh
//  Project     : UMMC
//  Purpose     :
//
//  Created on  : Sun Jul 21 16:52:39 UTC 2013
//  Description : clk_rst_driver component, not a driver, as it does not need
//  		  to pull any sequence_item
//
//
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////


`ifndef clk_rst_driver_svh
`define clk_rst_driver_svh

class clk_rst_driver extends uvm_component; 

  // Factory Registration Macro
  `uvm_component_utils (clk_rst_driver)

  virtual clk_rst_intf clk_rst_vif;

  clk_rst_agent_config m_cfg;
  bit  PRESETn_deasserted = 0;

  function new (string name = "clk_rst_driver", uvm_component parent = null);
    super.new (name, parent);
  endfunction : new
  
  function void build_phase (uvm_phase phase);
    if (!uvm_config_db #(clk_rst_agent_config)::get(this, "", "clk_rst_agent_config", m_cfg)) begin
      `uvm_fatal ("CONFIG_LOAD", "Unable to get clk_rst_agent_config")
    end
  endfunction: build_phase

  task por_mclk_seq;
    #(m_cfg.mrst_deassert_delay*1ps);
    if (~m_cfg.no_reset) begin
    #(m_cfg.mrst_assert_delay*1ps);
    clk_rst_vif.mc_rst_n = 0;
    wait(PRESETn_deasserted == 1);
    #(m_cfg.mrst_deassert_delay*1ps);
    @(negedge clk_rst_vif.mc_clk);
    clk_rst_vif.mc_rst_n = 1;
    end
  endtask : por_mclk_seq


  task por_pclk_seq;
    #(m_cfg.prst_deassert_delay*1ps);
    #(m_cfg.prst_assert_delay*1ps);
    clk_rst_vif.PRESETn = 0;
    #(m_cfg.prst_deassert_delay*1ps);
    @(posedge clk_rst_vif.PCLK);
    @(posedge clk_rst_vif.PCLK);
    clk_rst_vif.PRESETn = 1;
    PRESETn_deasserted = 1;
    #(m_cfg.pclk_stable_delay*1ps);
  endtask : por_pclk_seq  

  task run_phase (uvm_phase phase);
    bit start_mbit;
    bit start_pbit;


    m_cfg.print (uvm_default_table_printer);

    start_pbit = $random;
    start_mbit = $random;

    clk_rst_vif.mc_clk  = start_mbit;
    clk_rst_vif.PCLK    = start_pbit;
    clk_rst_vif.mc_rst_n= 0;
    clk_rst_vif.PRESETn = 0;
    clk_rst_vif.ddrclk       = 1;
    clk_rst_vif.ddrclk_div2  = 1;
    clk_rst_vif.ddrclk_div4  = 1;
    clk_rst_vif.cpu_clk_i    = 1;

    fork
      begin // mclk block
	  fork
            repeat(2)@(posedge clk_rst_vif.mc_clk);
            por_mclk_seq;
	  join_none
      end
      begin//mclk block
  	forever 
        begin 
  	  if (!m_cfg.disable_mclk) 
          begin
	   `ifdef AXI2MC_CLK_DELAY
	    #(m_cfg.axi_mc_clk_delay*1ps);
	   `endif
	    #(((m_cfg.mclk_period*1ps*m_cfg.mclk_duty_cycle)/100)*1ps) clk_rst_vif.mc_clk = start_mbit;
            
  	    #((m_cfg.mclk_period*1ps - (m_cfg.mclk_period*1ps*m_cfg.mclk_duty_cycle/100))*1ps) clk_rst_vif.mc_clk = ~start_mbit;
	    if (m_cfg.highz_mrst) clk_rst_vif.mc_rst_n = 1'bz;
	    else if (m_cfg.assert_mrst) clk_rst_vif.mc_rst_n = 1'b0;
  	  end
	  else 
          begin
	    clk_rst_vif.mc_clk = (m_cfg.highz_mclk == 1) ? 1'bz : 1'b0;
    	    if (~m_cfg.no_reset) begin
	    if (m_cfg.highz_mrst) clk_rst_vif.mc_rst_n = 1'bz;
	    else if (m_cfg.assert_mrst) clk_rst_vif.mc_rst_n = 1'b0;
    	    end
	    wait (!m_cfg.disable_mclk && m_cfg.restart_mrst_seq);
	    por_mclk_seq; 
	  end
	end // forever    
      end // mclk block
      begin//ddrclk block
        fork
        begin
          repeat(2) @ (posedge clk_rst_vif.mc_clk);
	  forever 
          begin
            if(~m_cfg.disable_ddrclk)
             #(m_cfg.dfi_clk_period/8) clk_rst_vif.ddrclk = ~clk_rst_vif.ddrclk;
            else
            begin
              clk_rst_vif.ddrclk = 1'b1;
              repeat(2) @ (posedge clk_rst_vif.mc_clk);
            end
          end
        end
        begin
          repeat(2) @ (posedge clk_rst_vif.mc_clk);
	  forever 
          begin
            if(~m_cfg.disable_ddrclk)
             #(m_cfg.dfi_clk_period/4) clk_rst_vif.ddrclk_div2 = ~clk_rst_vif.ddrclk_div2;
            else
            begin
              clk_rst_vif.ddrclk_div2 = 1'b1;
              repeat(2) @ (posedge clk_rst_vif.mc_clk);
            end
          end
        end
        begin
          repeat(2) @ (posedge clk_rst_vif.mc_clk);
  	  forever 
          begin
            if(~m_cfg.disable_ddrclk)
             #(m_cfg.dfi_clk_period/2) clk_rst_vif.ddrclk_div4 = ~clk_rst_vif.ddrclk_div4;
            else
            begin
              clk_rst_vif.ddrclk_div4 = 1'b1;
              repeat(2) @ (posedge clk_rst_vif.mc_clk);
            end
          end
        end
        begin
          repeat(2) @ (posedge clk_rst_vif.mc_clk);
  	  forever 
          begin
            if(~m_cfg.disable_ddrclk)
             #(m_cfg.cpu_clk_period) clk_rst_vif.cpu_clk_i = ~clk_rst_vif.cpu_clk_i;
            else
            begin
              clk_rst_vif.cpu_clk_i = 1'b1;
              repeat(2) @ (posedge clk_rst_vif.mc_clk);
            end
          end
        end
        join
      end // ddrclk block

      begin // pclk block
        repeat(2)@(posedge clk_rst_vif.PCLK);
        por_pclk_seq;
      end
      begin  
  	forever begin 
  	  if (!m_cfg.disable_pclk) begin
	    #(m_cfg.pclk_period*1ps) clk_rst_vif.PCLK = start_pbit;
  	    #(m_cfg.pclk_period*1ps) clk_rst_vif.PCLK = ~start_pbit;
	    if (m_cfg.highz_prst) clk_rst_vif.PRESETn = 1'bz;
	    else if (m_cfg.highz_prst) clk_rst_vif.PRESETn = 1'b0;
  	  end
	  else begin
	    clk_rst_vif.PCLK = (m_cfg.highz_pclk == 1) ? 1'bz : 1'b0;
	    if (m_cfg.highz_prst) clk_rst_vif.PRESETn = 1'bz;
	    else if (m_cfg.highz_prst) clk_rst_vif.PRESETn = 1'b0;
	    wait (!m_cfg.disable_pclk && m_cfg.restart_prst_seq);
	    por_pclk_seq; 
	  end
	end // forever    
      end // pclk block
    join
  endtask : run_phase

endclass : clk_rst_driver

`endif /* clk_rst_driver_svh */

