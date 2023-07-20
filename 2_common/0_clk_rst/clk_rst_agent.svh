//////////////////////////////////////////////////////////////////////////
// (c) 2013 Mobiveil Inc.
//
//  File        : clk_rst_agent.svh
//  Project     : UMMC
//  Purpose     :
//
//  Created on  : Sun Jul 21 03:32:33 UTC 2013
//
//
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////


`ifndef clk_rst_agent_svh
`define clk_rst_agent_svh


class clk_rst_agent extends uvm_component;

  // Factory Registration
  `uvm_component_utils (clk_rst_agent)

  // Data Members
  clk_rst_agent_config m_cfg;

  // Component Members
  clk_rst_driver    m_driver;

  function new (string name = "clk_rst_agent", uvm_component parent = null);
    super.new (name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    if (!uvm_config_db #(clk_rst_agent_config)::get(this, "", "clk_rst_agent_config", m_cfg) )
      `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration clk_rst_agent_config from uvm_config_db. Have you set() it?")
    m_driver    = clk_rst_driver::type_id::create ("clk_rst_driver", this);
  endfunction : build_phase

  function void connect_phase (uvm_phase phase);
    m_driver.clk_rst_vif = m_cfg.clk_rst_vif;
  endfunction : connect_phase

endclass : clk_rst_agent

`endif /* clk_rst_agent_svh */

