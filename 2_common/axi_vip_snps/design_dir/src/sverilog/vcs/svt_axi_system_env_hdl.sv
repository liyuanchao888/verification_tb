//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// SYNOPSYS CONFIDENTIAL
// This is an unpublished, proprietary work of Synopsys, Inc., and is
// fully protected under copyright and trade secret laws. You may not
// view, use, disclose, copy, or distribute this file, or any information
// contained herein except pursuant to a valid written license from
// Synopsys.
//
//-----------------------------------------------------------------------

`protected
3-fR[bf.0Ic^KRZ#N#8O>92L^6:57R(]ZL+b-bODYYdO1/E6]U^P0)7_f&..AR?8
68KP10_\5X(&;G@SfaO+PEe[dFM8)fCS/fBO>.dQ=g/4Ig4^TO.,42<gTPRF&^)Y
VN(@CGDH,N2(ITbY;K]8M3a^5-fZ7_[d)=QY>9>W5DFND=AEUg1aKaBW8Wf9fJIF
/Ba@?]X[#KIVBCP)5-GQ>BV28/Z5^[Yg3aV4+1]M=V(>e7L2<>b.E95=2\X=L:OU
382YS-7IGAWf)aC&0YX-O,2LV8a:2g\N0X;B<eM<GP6)D&3C.JM)9(c3E5;Y4g:>V$
`endprotected
`include "uvm_macros.svh"
`protected
3:\<DX;dWZbKC2T2JNE^3MH7(f]\E+g&Fa&0:gUG;7Lf7TJ#G;QF2)VV]e<2O\aR
/PRUZ,9[_GbK*$
`endprotected
`include "svt_axi_if.svi"
`protected
HSf.Fb5-CB#H6)Z5OG).2KXCKZ&gJ]^VXK\+7UOc(@00>A8O&D?Q0)A7;)a770Bg
Bdfb91ZCJU:B-f.2ES&>M;<^@31Sb6b#KSLYK5Qf]\]@^)U/V]#])R?&@cTK)B\_
X&Q\GedSA(0<fF6ZL]+Z4Gg:MI>3[<]SPZR(&D\0LPF(+B-e3KZFBf>JU]B+S9JU
DgK^]VHEeWJPC/X+LZ_0^3a=E0^^(Y?N7LC=HF1<JC:L9ac5[B;7PPYF-5&_^.7T
5DHHAPWD&WQG>VbX\U@Nbf7FcO?S:VQQW3LQc/I7M2\NVY:g5J[XOW^G#f&EG_Q=
&V(OOGK[>QGX^>YC>=?c=K1)d;N99Wf@72V@9>[T&QC3RSN&N3=f+IDA,?=^?:B?
8(A2I[&&NJ/Ma^3aKWK0P0V_H8Q+4;3&IeVL>271EAPQ.O?<G0:S@+([&d\\Rf_#
;PC^/,(8d:558<:=RbQAN:N=Hc.^,MT\+U^FMEGCR9N_QW;M-]eS2]]JfF0]0dDP
S=VXSYX=&)6J]@LUa2geAH#g,2CJ.J.Lge+VY16Qc&@##B&Q\Z(Ibf]JI$
`endprotected


module svt_axi_system_env_hdl (

            CLK,
            aresetn,
            
            awvalid_master,
            awvalid_master_passive,
            awaddr_master,
            awaddr_master_passive,
            awlen_master,
            awlen_master_passive,
            awsize_master,
            awsize_master_passive,
            awburst_master,
            awburst_master_passive,
            awlock_master,
            awlock_master_passive,
            awcache_master,
            awcache_master_passive,
            awprot_master,
            awprot_master_passive,
            awid_master,
            awid_master_passive,
            awready_master,
            
            awdomain_master,
            awdomain_master_passive,
            awsnoop_master,
            awsnoop_master_passive,
            awbar_master,
            awbar_master_passive,
            
            arvalid_master,
            arvalid_master_passive,
            araddr_master,
            araddr_master_passive,
            arlen_master,
            arlen_master_passive,
            arsize_master,
            arsize_master_passive,
            arburst_master,
            arburst_master_passive,
            arlock_master,
            arlock_master_passive,
            arcache_master,
            arcache_master_passive,
            arprot_master,
            arprot_master_passive,
            arid_master,
            arid_master_passive,
            arready_master,
            
            ardomain_master,
            ardomain_master_passive,
            arsnoop_master,
            arsnoop_master_passive,
            arbar_master,
            arbar_master_passive,
            
            rvalid_master,
            rlast_master,
            rdata_master,
            rresp_master,
            rid_master,
            rready_master,
            rready_master_passive,
            
            rack_master,
            rack_master_passive,
            
            wvalid_master,
            wvalid_master_passive,
            wlast_master,
            wlast_master_passive,
            wdata_master,
            wdata_master_passive,
            wstrb_master,
            wstrb_master_passive,
            wid_master,
            wid_master_passive,
            wready_master,
            
            bvalid_master,
            bresp_master,
            bid_master,
            bready_master,
            bready_master_passive,
            
            wack_master,
            wack_master_passive,
            
            awregion_master,
            awregion_master_passive,
            awqos_master,
            awqos_master_passive,
            awuser_master,
            awuser_master_passive,
            
            arregion_master,
            arregion_master_passive,
            arqos_master,
            arqos_master_passive,
            aruser_master,
            aruser_master_passive,
            
            wuser_master,
            wuser_master_passive,
            ruser_master,
            buser_master,
            
            acvalid_master,
            acready_master,
            acready_master_passive,
            acaddr_master,
            acsnoop_master,
            //aclen_master,
            acprot_master,
            
            crvalid_master,
            crvalid_master_passive,
            crready_master,
            crresp_master,
            crresp_master_passive,
            
            cdvalid_master,
            cdvalid_master_passive,
            cdready_master,
            cddata_master,
            cddata_master_passive,
            cdlast_master,
            cdlast_master_passive,
                                  
// Slave signls                                    
            awvalid_slave,
            awaddr_slave,
            awlen_slave,
            awsize_slave,
            awburst_slave,
            awlock_slave,
            awcache_slave,
            awprot_slave,
            awid_slave,
            awready_slave,
            awready_slave_passive,
            awdomain_slave,
            awsnoop_slave,
            awbar_slave,
            
            arvalid_slave,
            araddr_slave,
            arlen_slave,
            arsize_slave,
            arburst_slave,
            arlock_slave,
            arcache_slave,
            arprot_slave,
            arid_slave,
            arready_slave,
            arready_slave_passive,
            ardomain_slave,
            arsnoop_slave,
            arbar_slave,
            
            rvalid_slave,
            rvalid_slave_passive,
            rlast_slave,
            rlast_slave_passive,
            rdata_slave,
            rdata_slave_passive,
            rresp_slave,
            rresp_slave_passive,
            rid_slave,
            rid_slave_passive,
            rready_slave,
            rack_slave,
            
            wvalid_slave,
            wlast_slave,
            wdata_slave,
            wstrb_slave,
            wid_slave,
            wready_slave,
            wready_slave_passive,
            
            bvalid_slave,
            bvalid_slave_passive,
            bresp_slave,
            bresp_slave_passive,
            bid_slave,
            bid_slave_passive,
            bready_slave,
            wack_slave,
            
            awregion_slave,
            awqos_slave,
            awuser_slave,
            arregion_slave,
            arqos_slave,
            aruser_slave,
            wuser_slave,
            ruser_slave,
            ruser_slave_passive,
            buser_slave,
            buser_slave_passive,
            
            acvalid_slave,
            acvalid_slave_passive,
            acready_slave,
            acaddr_slave,
            acaddr_slave_passive,
            acsnoop_slave,
            acsnoop_slave_passive,
            //aclen_slave,
            acprot_slave,
            acprot_slave_passive,
            
            crvalid_slave,
            crready_slave,
            crready_slave_passive,
            crresp_slave,
            
            cdvalid_slave,
            cdready_slave,
            cdready_slave_passive,
            cddata_slave,
            cdlast_slave
            );

  parameter num_masters = 1;
  parameter num_slaves = 1;

  genvar i;

  /** Decides the instance name that can be changed from top */
  parameter string inst_name = "AXI_SYSTEM_AGENT";  

/** @grouphdr modelcontrol Model Control Commands 
    Grouping all model control commands
*/
/** @grouphdr datamanipulation Data Manipulation and Report Control Commands 
    Grouping all log message control commands.
*/
/** @grouphdr operational Operational Control Commands 
    Grouping all log message control commands.
*/
/** @grouphdr modelcallback Model Callback Control Commands
    Grouping all log message control commands.
*/

//-----------------------------------------------------------------------

  input                                          CLK;
  input                                          aresetn;

  output                                         awvalid_master[num_masters-1:0];
  input                                          awvalid_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen_master_passive[num_masters-1:0];
  output [`SVT_AXI_SIZE_WIDTH-1:0]               awsize_master[num_masters-1:0];
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               awsize_master_passive[num_masters-1:0];
  output [`SVT_AXI_BURST_WIDTH-1:0]              awburst_master[num_masters-1:0];
  input  [`SVT_AXI_BURST_WIDTH-1:0]              awburst_master_passive[num_masters-1:0];
  output [`SVT_AXI_LOCK_WIDTH-1:0]               awlock_master[num_masters-1:0];
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               awlock_master_passive[num_masters-1:0];
  output [`SVT_AXI_CACHE_WIDTH-1:0]              awcache_master[num_masters-1:0];
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              awcache_master_passive[num_masters-1:0];
  output [`SVT_AXI_PROT_WIDTH-1:0]               awprot_master[num_masters-1:0];
  input  [`SVT_AXI_PROT_WIDTH-1:0]               awprot_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid_master_passive[num_masters-1:0];
  input                                          awready_master[num_masters-1:0];

  // AXI ACE Extension of Write Address Channel Signals

  output [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain_master[num_masters-1:0];  
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain_master_passive[num_masters-1:0];  
  output [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop_master[num_masters-1:0];   
  input  [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop_master_passive[num_masters-1:0];   
  output [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar_master[num_masters-1:0];
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar_master_passive[num_masters-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Read Address Channel Signals
  //-----------------------------------------------------------------------
  output                                         arvalid_master[num_masters-1:0];
  input                                          arvalid_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen_master_passive[num_masters-1:0];
  output [`SVT_AXI_SIZE_WIDTH-1:0]               arsize_master[num_masters-1:0];
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               arsize_master_passive[num_masters-1:0];
  output [`SVT_AXI_BURST_WIDTH-1:0]              arburst_master[num_masters-1:0];
  input  [`SVT_AXI_BURST_WIDTH-1:0]              arburst_master_passive[num_masters-1:0];
  output [`SVT_AXI_LOCK_WIDTH-1:0]               arlock_master[num_masters-1:0];
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               arlock_master_passive[num_masters-1:0];
  output [`SVT_AXI_CACHE_WIDTH-1:0]              arcache_master[num_masters-1:0];
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              arcache_master_passive[num_masters-1:0];
  output [`SVT_AXI_PROT_WIDTH-1:0]               arprot_master[num_masters-1:0];
  input  [`SVT_AXI_PROT_WIDTH-1:0]               arprot_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid_master_passive[num_masters-1:0];
  input                                          arready_master[num_masters-1:0];

  // AXI ACE Extension of Read Address Channel 

  output [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain_master[num_masters-1:0];  
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain_master_passive[num_masters-1:0];  
  output [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop_master[num_masters-1:0];   
  input  [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop_master_passive[num_masters-1:0];   
  output [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar_master[num_masters-1:0];
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar_master_passive[num_masters-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Read Channel Signals
  //-----------------------------------------------------------------------
  input                                          rvalid_master[num_masters-1:0];
  input                                          rlast_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata_master[num_masters-1:0];
  input  [`SVT_AXI_RESP_WIDTH-1:0]               rresp_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid_master[num_masters-1:0];
  output                                         rready_master[num_masters-1:0];
  input                                          rready_master_passive[num_masters-1:0];

  // AXI ACE Extension of Read Data Channel

  output                                         rack_master[num_masters-1:0];
  input                                          rack_master_passive[num_masters-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Write Channel Signals
  //-----------------------------------------------------------------------
  output                                         wvalid_master[num_masters-1:0];
  input                                          wvalid_master_passive[num_masters-1:0];
  output                                         wlast_master[num_masters-1:0];
  input                                          wlast_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid_master_passive[num_masters-1:0];
  input                                          wready_master[num_masters-1:0];
  
  //-----------------------------------------------------------------------
  // AXI Interface Write Response Channel Signals
  //-----------------------------------------------------------------------
  input                                          bvalid_master[num_masters-1:0];
  input  [`SVT_AXI_RESP_WIDTH-1:0]               bresp_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid_master[num_masters-1:0];
  output                                         bready_master[num_masters-1:0];
  input                                          bready_master_passive[num_masters-1:0];

  // AXI ACE Extension of Write Response Channel

  output                                         wack_master[num_masters-1:0];
  input                                          wack_master_passive[num_masters-1:0];

  //-----------------------------------------------------------------------
  // AXI4 Interface Signals
  //-----------------------------------------------------------------------
  output [`SVT_AXI_REGION_WIDTH-1:0]             awregion_master[num_masters-1:0];
  input  [`SVT_AXI_REGION_WIDTH-1:0]             awregion_master_passive[num_masters-1:0];
  output [`SVT_AXI_QOS_WIDTH-1:0]                awqos_master[num_masters-1:0];
  input  [`SVT_AXI_QOS_WIDTH-1:0]                awqos_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser_master_passive[num_masters-1:0];
  
  output [`SVT_AXI_REGION_WIDTH-1:0]             arregion_master[num_masters-1:0];
  input  [`SVT_AXI_REGION_WIDTH-1:0]             arregion_master_passive[num_masters-1:0];
  output [`SVT_AXI_QOS_WIDTH-1:0]                arqos_master[num_masters-1:0];
  input  [`SVT_AXI_QOS_WIDTH-1:0]                arqos_master_passive[num_masters-1:0];
  output [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser_master_passive[num_masters-1:0];

  output [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser_master_passive[num_masters-1:0];
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser_master[num_masters-1:0];
  input  [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser_master[num_masters-1:0];

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Address Channel Signals 
  //-----------------------------------------------------------------------
  input                                          acvalid_master[num_masters-1:0];   
  output                                         acready_master[num_masters-1:0];   
  input                                          acready_master_passive[num_masters-1:0];   
  input  [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr_master[num_masters-1:0];            
  input  [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop_master[num_masters-1:0];   
//input  [`SVT_AXI_ACE_SNOOP_BURST_WIDTH-1:0]    aclen_master[num_masters-1:0];       
  input  [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot_master[num_masters-1:0];        

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Response Channel Signals
  //-----------------------------------------------------------------------
  output                                         crvalid_master[num_masters-1:0];   
  input                                          crvalid_master_passive[num_masters-1:0];   
  input                                          crready_master[num_masters-1:0];   
  output [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp_master[num_masters-1:0];        
  input  [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp_master_passive[num_masters-1:0];        

  //-----------------------------------------------------------------------
  // AXI ACE Interface Data Channel Signals
  //-----------------------------------------------------------------------
  output                                         cdvalid_master[num_masters-1:0];   
  input                                          cdvalid_master_passive[num_masters-1:0];   
  input                                          cdready_master[num_masters-1:0];   
  output [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata_master[num_masters-1:0];        
  input  [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata_master_passive[num_masters-1:0];        
  output                                         cdlast_master[num_masters-1:0];
  input                                          cdlast_master_passive[num_masters-1:0];

// Slave IO signals

  input                                          awvalid_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen_slave[num_slaves-1:0];
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               awsize_slave[num_slaves-1:0];
  input  [`SVT_AXI_BURST_WIDTH-1:0]              awburst_slave[num_slaves-1:0];
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               awlock_slave[num_slaves-1:0];
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              awcache_slave[num_slaves-1:0];
  input  [`SVT_AXI_PROT_WIDTH-1:0]               awprot_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid_slave[num_slaves-1:0];
  output                                         awready_slave[num_slaves-1:0];
  input                                          awready_slave_passive[num_slaves-1:0];

  // AXI ACE Extension of Write Address Channel Signals
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain_slave[num_slaves-1:0];   
  input  [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop_slave[num_slaves-1:0];    
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar_slave[num_slaves-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Read Address Channel Signals
  //-----------------------------------------------------------------------
  input                                         arvalid_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen_slave[num_slaves-1:0];
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               arsize_slave[num_slaves-1:0];
  input  [`SVT_AXI_BURST_WIDTH-1:0]              arburst_slave[num_slaves-1:0];
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               arlock_slave[num_slaves-1:0];
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              arcache_slave[num_slaves-1:0];
  input  [`SVT_AXI_PROT_WIDTH-1:0]               arprot_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid_slave[num_slaves-1:0];
  output                                         arready_slave[num_slaves-1:0];
  input                                          arready_slave_passive[num_slaves-1:0];

  // AXI ACE Extension of Read Address Channel 
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain_slave[num_slaves-1:0];   
  input  [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop_slave[num_slaves-1:0];    
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar_slave[num_slaves-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Read Channel Signals
  //-----------------------------------------------------------------------
  output                                         rvalid_slave[num_slaves-1:0];
  input                                          rvalid_slave_passive[num_slaves-1:0];
  output                                         rlast_slave[num_slaves-1:0];
  input                                          rlast_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_RESP_WIDTH-1:0]               rresp_slave[num_slaves-1:0];
  input  [`SVT_AXI_RESP_WIDTH-1:0]               rresp_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid_slave_passive[num_slaves-1:0];
  input                                          rready_slave[num_slaves-1:0];

  // AXI ACE Extension of Read Data Channel
  input                                          rack_slave[num_slaves-1:0];

  //-----------------------------------------------------------------------
  // AXI Interface Write Channel Signals
  //-----------------------------------------------------------------------
  input                                          wvalid_slave[num_slaves-1:0];
  input                                          wlast_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid_slave[num_slaves-1:0];
  output                                         wready_slave[num_slaves-1:0];
  input                                          wready_slave_passive[num_slaves-1:0];
  
  //-----------------------------------------------------------------------
  // AXI Interface Write Response Channel Signals
  //-----------------------------------------------------------------------
  output                                         bvalid_slave[num_slaves-1:0];
  input                                          bvalid_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_RESP_WIDTH-1:0]               bresp_slave[num_slaves-1:0];
  input  [`SVT_AXI_RESP_WIDTH-1:0]               bresp_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid_slave_passive[num_slaves-1:0];
  input                                          bready_slave[num_slaves-1:0];

  // AXI ACE Extension of Write Response Channel
  input                                          wack_slave[num_slaves-1:0];

  //-----------------------------------------------------------------------
  // AXI4 Interface Signals
  //-----------------------------------------------------------------------
  input  [`SVT_AXI_REGION_WIDTH-1:0]             awregion_slave[num_slaves-1:0];
  input  [`SVT_AXI_QOS_WIDTH-1:0]                awqos_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser_slave[num_slaves-1:0];
  
  input  [`SVT_AXI_REGION_WIDTH-1:0]             arregion_slave[num_slaves-1:0];
  input  [`SVT_AXI_QOS_WIDTH-1:0]                arqos_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser_slave[num_slaves-1:0];

  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser_slave[num_slaves-1:0];
  output [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser_slave_passive[num_slaves-1:0];
  output [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser_slave[num_slaves-1:0];
  input  [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser_slave_passive[num_slaves-1:0];

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Address Channel Signals 
  //-----------------------------------------------------------------------
  output                                         acvalid_slave[num_slaves-1:0];    
  input                                          acvalid_slave_passive[num_slaves-1:0];    
  input                                          acready_slave[num_slaves-1:0];    
  output [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr_slave[num_slaves-1:0];         
  input  [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr_slave_passive[num_slaves-1:0];         
  output [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop_slave[num_slaves-1:0];    
  input  [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop_slave_passive[num_slaves-1:0];    
//  output [`SVT_AXI_ACE_SNOOP_BURST_WIDTH-1:0]   aclen_slave[num_slaves-1:0];        
  output [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot_slave[num_slaves-1:0];     
  input  [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot_slave_passive[num_slaves-1:0];     
  // wire                   acbar_slave[num_slaves-1:0];  // doesn't appear to be used in spec

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Response Channel Signals
  //-----------------------------------------------------------------------
  input                                          crvalid_slave[num_slaves-1:0];    
  output                                         crready_slave[num_slaves-1:0];    
  input                                          crready_slave_passive[num_slaves-1:0];    
  input  [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp_slave[num_slaves-1:0];     

  //-----------------------------------------------------------------------
  // AXI ACE Interface Data Channel Signals
  //-----------------------------------------------------------------------
  input                                          cdvalid_slave[num_slaves-1:0];    
  output                                         cdready_slave[num_slaves-1:0];    
  input                                          cdready_slave_passive[num_slaves-1:0];    
  input  [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata_slave[num_slaves-1:0];     
  input                                          cdlast_slave[num_slaves-1:0];


`protected
NQR\^?HWIDGRG;99^5PcYgFDWQY]b.N7e=O/,LWI6Ke8\+J^>WN+-)>LK<L4a7JR
/Jf/G<0e(52_.D-S<HA]fF5G::V3A5AG<]A@N^ORIB]4c2>EOdIQ0O#IMXa)@-I4
4,5/05H^-HR^I,ebbQV#S#VZMFV=GKDV&/eCdGcZZ.RPD^g;&Z]+(<CYVX9J/S,?
N-V/8(PVIT&0Gc6.V=X)QJ3DM=@86RfG?KN]]W_]bOG1NQVNI:a9#W7XN(&cJPK,
gYO-Db8YA#C>=^^XRG&9.Fb/ZVJf\JA=\76\W?F3-MM14UAUQ;:/fW8&2O6dZKK=
3)fN(_GH5KC>,$
`endprotected

  
  //Pull in the common SVT HDL command 'export' declarations
  `include "svt_uvm_component_export.svi"

`ifndef __SVDOC__
  initial begin

    uvm_root top;
    sys_cfg = new("system_cfg");

    sys_cfg.set_if(axi_if);
    sys_cfg.create_sub_cfgs(num_masters, num_slaves);

    for(int i=0; i<num_masters; i++) begin
     sys_cfg.master_cfg[i].is_active = 0;
    end 
    for(int i=0; i<num_slaves; i++) begin
    sys_cfg.slave_cfg[i].is_active = 0;
    end 

    uvm_resource_db#(svt_axi_system_configuration)::set($sformatf("%s.%s",hierarchy,inst_name), "cfg", sys_cfg);

    model = new ($sformatf("%s.%s",hierarchy,inst_name),null);

    // Push this thread to the end of the timestep so that any other VLOG CMD models
    // have a chance to be constructed.
    #0;
    top = uvm_root::get();
    if (!top.has_child("uvm_test_top")) begin
      run_test("svt_axi_system_vlog_cmd_test");
    end
  end
// =============================================================================
  
  generate for(i=0; i<=num_masters-1; i++) begin:IO_assign_1

  assign awvalid_master[i]    = axi_if.master_if[i].awvalid;
  assign awaddr_master[i]     = axi_if.master_if[i].awaddr;
  assign awlen_master[i]      = axi_if.master_if[i].awlen;
  assign awsize_master[i]     = axi_if.master_if[i].awsize;
  assign awburst_master[i]    = axi_if.master_if[i].awburst;
  assign awlock_master[i]     = axi_if.master_if[i].awlock;
  assign awcache_master[i]    = axi_if.master_if[i].awcache;
  assign awprot_master[i]     = axi_if.master_if[i].awprot;
  assign awid_master[i]       = axi_if.master_if[i].awid;
 
  assign awdomain_master[i]   = axi_if.master_if[i].awdomain;
  assign awsnoop_master[i]    = axi_if.master_if[i].awsnoop;
  assign awbar_master[i]      = axi_if.master_if[i].awbar;

  assign arvalid_master[i]    = axi_if.master_if[i].arvalid;
  assign araddr_master[i]     = axi_if.master_if[i].araddr;
  assign arlen_master[i]      = axi_if.master_if[i].arlen;
  assign arsize_master[i]     = axi_if.master_if[i].arsize;
  assign arburst_master[i]    = axi_if.master_if[i].arburst;
  assign arlock_master[i]     = axi_if.master_if[i].arlock;
  assign arcache_master[i]    = axi_if.master_if[i].arcache;
  assign arprot_master[i]     = axi_if.master_if[i].arprot;
  assign arid_master[i]       = axi_if.master_if[i].arid;

  assign ardomain_master[i]   = axi_if.master_if[i].ardomain;
  assign arsnoop_master[i]    = axi_if.master_if[i].arsnoop;
  assign arbar_master[i]      = axi_if.master_if[i].arbar;

  assign rready_master[i]     = axi_if.master_if[i].rready;
  assign rack_master[i]       = axi_if.master_if[i].rack;

  assign wvalid_master[i]     = axi_if.master_if[i].wvalid;
  assign wlast_master[i]      = axi_if.master_if[i].wlast;
  assign wdata_master[i]      = axi_if.master_if[i].wdata;
  assign wstrb_master[i]      = axi_if.master_if[i].wstrb;
  assign wid_master[i]        = axi_if.master_if[i].wid;

  assign bready_master[i]     = axi_if.master_if[i].bready;
  assign wack_master[i]       = axi_if.master_if[i].wack;

  assign awregion_master[i]   = axi_if.master_if[i].awregion;
  assign awqos_master[i]      = axi_if.master_if[i].awqos;
  assign awuser_master[i]     = axi_if.master_if[i].awuser;
  assign arregion_master[i]   = axi_if.master_if[i].arregion;
  assign arqos_master[i]      = axi_if.master_if[i].arqos;
  assign aruser_master[i]     = axi_if.master_if[i].aruser;
  assign wuser_master[i]      = axi_if.master_if[i].wuser;

  assign acready_master[i]    = axi_if.master_if[i].acready;

  assign crvalid_master[i]    = axi_if.master_if[i].crvalid;
  assign crresp_master[i]     = axi_if.master_if[i].crresp;

  assign cdvalid_master[i]    = axi_if.master_if[i].cdvalid;
  assign cddata_master[i]     = axi_if.master_if[i].cddata;
  assign cdlast_master[i]     = axi_if.master_if[i].cdlast;
  end endgenerate

// -----------------------------------------------------------------------------
`ifdef SVT_MULTI_SIM_PROCEDURAL_COMBINATORIAL_DRIVE

  always @(CLK) axi_if.common_aclk     = CLK;

  generate for(i=0; i<=num_masters-1; i++) begin:IO_assign_2
  always @(aresetn) axi_if.master_if[i].aresetn    = aresetn;

  always @(awready_master[i]) axi_if.master_if[i].awready    = awready_master[i];
  always @(arready_master[i]) axi_if.master_if[i].arready    = arready_master[i];


  always @(rvalid_master[i]) axi_if.master_if[i].rvalid = rvalid_master[i];
  always @(rlast_master[i]) axi_if.master_if[i].rlast  = rlast_master[i];
  always @(rdata_master[i]) axi_if.master_if[i].rdata  = rdata_master[i];
  always @(rresp_master[i]) axi_if.master_if[i].rresp  = rresp_master[i];
  always @(rid_master[i]) axi_if.master_if[i].rid    = rid_master[i];

  always @(wready_master[i]) axi_if.master_if[i].wready = wready_master[i];

  always @(bvalid_master[i]) axi_if.master_if[i].bvalid = bvalid_master[i];
  always @(bresp_master[i]) axi_if.master_if[i].bresp  = bresp_master[i];
  always @(bid_master[i]) axi_if.master_if[i].bid    = bid_master[i];

  always @(ruser_master[i]) axi_if.master_if[i].ruser  = ruser_master[i];
  always @(buser_master[i]) axi_if.master_if[i].buser  = buser_master[i];

  always @(acvalid_master[i]) axi_if.master_if[i].acvalid    = acvalid_master[i];
  always @(acaddr_master[i]) axi_if.master_if[i].acaddr = acaddr_master[i];
  always @(acsnoop_master[i]) axi_if.master_if[i].acsnoop    = acsnoop_master[i];
//  assign axi_if.master_if[i].aclen    = aclen_master[i];
  always @(acprot_master[i]) axi_if.master_if[i].acprot = acprot_master[i];

  always @(crready_master[i]) axi_if.master_if[i].crready    = crready_master[i];

  always @(cdready_master[i]) axi_if.master_if[i].cdready    = cdready_master[i];


// =============================================================================

  always @(awvalid_master_passive[i])   axi_if.master_if[i].awvalid  =  awvalid_master_passive[i];
  always @(awaddr_master_passive[i])   axi_if.master_if[i].awaddr        =  awaddr_master_passive[i];
  always @(awlen_master_passive[i])   axi_if.master_if[i].awlen      =  awlen_master_passive[i];
  always @(awsize_master_passive[i])   axi_if.master_if[i].awsize        =  awsize_master_passive[i];
  always @(awburst_master_passive[i])   axi_if.master_if[i].awburst  =  awburst_master_passive[i];
  always @(awlock_master_passive[i])   axi_if.master_if[i].awlock        =  awlock_master_passive[i];
  always @(awcache_master_passive[i])   axi_if.master_if[i].awcache  =  awcache_master_passive[i];
  always @(awprot_master_passive[i])   axi_if.master_if[i].awprot        =  awprot_master_passive[i];
  always @(awid_master_passive[i])   axi_if.master_if[i].awid            =  awid_master_passive[i];

  always @(awdomain_master_passive[i])   axi_if.master_if[i].awdomain    =  awdomain_master_passive[i];
  always @(awsnoop_master_passive[i])   axi_if.master_if[i].awsnoop  =  awsnoop_master_passive[i];
  always @(awbar_master_passive[i])   axi_if.master_if[i].awbar      =  awbar_master_passive[i];
  always @(arvalid_master_passive[i])   axi_if.master_if[i].arvalid  =  arvalid_master_passive[i];

  always @(araddr_master_passive[i])   axi_if.master_if[i].araddr        =  araddr_master_passive[i];
  always @(arlen_master_passive[i])   axi_if.master_if[i].arlen      =  arlen_master_passive[i];
  always @(arsize_master_passive[i])   axi_if.master_if[i].arsize        =  arsize_master_passive[i];
  always @(arburst_master_passive[i])   axi_if.master_if[i].arburst  =  arburst_master_passive[i];
  always @(arlock_master_passive[i])   axi_if.master_if[i].arlock        =  arlock_master_passive[i];
  always @(arcache_master_passive[i])   axi_if.master_if[i].arcache  =  arcache_master_passive[i];
  always @(arprot_master_passive[i])   axi_if.master_if[i].arprot        =  arprot_master_passive[i];
  always @(arid_master_passive[i])   axi_if.master_if[i].arid            =  arid_master_passive[i];
  
  always @(ardomain_master_passive[i])   axi_if.master_if[i].ardomain    =  ardomain_master_passive[i];
  always @(arsnoop_master_passive[i])   axi_if.master_if[i].arsnoop  =  arsnoop_master_passive[i];
  always @(arbar_master_passive[i])   axi_if.master_if[i].arbar      =  arbar_master_passive[i];
  
  always @(rready_master_passive[i])   axi_if.master_if[i].rready      =  rready_master_passive[i];
  always @(rack_master_passive[i])   axi_if.master_if[i].rack        =  rack_master_passive[i];
  
  always @(wvalid_master_passive[i])   axi_if.master_if[i].wvalid        =  wvalid_master_passive[i];
  always @(wlast_master_passive[i])   axi_if.master_if[i].wlast          =  wlast_master_passive[i];
  always @(wdata_master_passive[i])   axi_if.master_if[i].wdata      =  wdata_master_passive[i];
  always @(wstrb_master_passive[i])   axi_if.master_if[i].wstrb      =  wstrb_master_passive[i];
  always @(wid_master_passive[i])   axi_if.master_if[i].wid          =  wid_master_passive[i];
  
  always @(wack_master_passive[i])   axi_if.master_if[i].wack            =  wack_master_passive[i];
  
  always @(awregion_master_passive[i])   axi_if.master_if[i].awregion    =  awregion_master_passive[i];
  always @(awqos_master_passive[i])   axi_if.master_if[i].awqos      =  awqos_master_passive[i];
  always @(awuser_master_passive[i])   axi_if.master_if[i].awuser        =  awuser_master_passive[i];
  always @(arregion_master_passive[i])   axi_if.master_if[i].arregion    =  arregion_master_passive[i];
  always @(arqos_master_passive[i])   axi_if.master_if[i].arqos      =  arqos_master_passive[i];
  always @(aruser_master_passive[i])   axi_if.master_if[i].aruser        =  aruser_master_passive[i];
  always @(wuser_master_passive[i])   axi_if.master_if[i].wuser      =  wuser_master_passive[i];
  
  always @(acready_master_passive[i])   axi_if.master_if[i].acready  =  acready_master_passive[i];
  
  always @(crvalid_master_passive[i])   axi_if.master_if[i].crvalid  =  crvalid_master_passive[i];
  always @(crresp_master_passive[i])   axi_if.master_if[i].crresp      =  crresp_master_passive[i];
  
  always @(cdvalid_master_passive[i])   axi_if.master_if[i].cdvalid  =  cdvalid_master_passive[i];
  always @(cddata_master_passive[i])   axi_if.master_if[i].cddata        =  cddata_master_passive[i];
  always @(cdlast_master_passive[i])   axi_if.master_if[i].cdlast        =  cdlast_master_passive[i];

  always @(bready_master_passive[i])   axi_if.master_if[i].bready      =  bready_master_passive[i];

  end endgenerate
`else

  assign axi_if.common_aclk             = CLK;

  generate for(i=0; i<=num_masters-1; i++) begin:IO_assign_3
  assign axi_if.master_if[i].aresetn    = aresetn;

  assign axi_if.master_if[i].awready    = awready_master[i];
  assign axi_if.master_if[i].arready    = arready_master[i];

  assign axi_if.master_if[i].rvalid     = rvalid_master[i];
  assign axi_if.master_if[i].rlast      = rlast_master[i];
  assign axi_if.master_if[i].rdata      = rdata_master[i];
  assign axi_if.master_if[i].rresp      = rresp_master[i];
  assign axi_if.master_if[i].rid        = rid_master[i];

  assign axi_if.master_if[i].wready     = wready_master[i];

  assign axi_if.master_if[i].bvalid     = bvalid_master[i];
  assign axi_if.master_if[i].bresp      = bresp_master[i];
  assign axi_if.master_if[i].bid        = bid_master[i];

  assign axi_if.master_if[i].ruser      = ruser_master[i];
  assign axi_if.master_if[i].buser      = buser_master[i];

  assign axi_if.master_if[i].acvalid    = acvalid_master[i];
  assign axi_if.master_if[i].acaddr     = acaddr_master[i];
  assign axi_if.master_if[i].acsnoop    = acsnoop_master[i];
//assign axi_if.master_if[i].aclen    = aclen_master[i];
  assign axi_if.master_if[i].acprot     = acprot_master[i];

  assign axi_if.master_if[i].crready    = crready_master[i];

  assign axi_if.master_if[i].cdready    = cdready_master[i];

// =============================================================================

  assign   axi_if.master_if[i].awvalid   =  awvalid_master_passive[i];
  assign   axi_if.master_if[i].awaddr        =  awaddr_master_passive[i];
  assign   axi_if.master_if[i].awlen         =  awlen_master_passive[i];
  assign   axi_if.master_if[i].awsize        =  awsize_master_passive[i];
  assign   axi_if.master_if[i].awburst   =  awburst_master_passive[i];
  assign   axi_if.master_if[i].awlock        =  awlock_master_passive[i];
  assign   axi_if.master_if[i].awcache   =  awcache_master_passive[i];
  assign   axi_if.master_if[i].awprot        =  awprot_master_passive[i];
  assign   axi_if.master_if[i].awid          =  awid_master_passive[i];

  assign   axi_if.master_if[i].awdomain  =  awdomain_master_passive[i];
  assign   axi_if.master_if[i].awsnoop   =  awsnoop_master_passive[i];
  assign   axi_if.master_if[i].awbar         =  awbar_master_passive[i];
  assign   axi_if.master_if[i].arvalid   =  arvalid_master_passive[i];

  assign   axi_if.master_if[i].araddr        =  araddr_master_passive[i];
  assign   axi_if.master_if[i].arlen         =  arlen_master_passive[i];
  assign   axi_if.master_if[i].arsize        =  arsize_master_passive[i];
  assign   axi_if.master_if[i].arburst   =  arburst_master_passive[i];
  assign   axi_if.master_if[i].arlock        =  arlock_master_passive[i];
  assign   axi_if.master_if[i].arcache   =  arcache_master_passive[i];
  assign   axi_if.master_if[i].arprot        =  arprot_master_passive[i];
  assign   axi_if.master_if[i].arid          =  arid_master_passive[i];
  
  assign   axi_if.master_if[i].ardomain  =  ardomain_master_passive[i];
  assign   axi_if.master_if[i].arsnoop   =  arsnoop_master_passive[i];
  assign   axi_if.master_if[i].arbar         =  arbar_master_passive[i];
  
  assign   axi_if.master_if[i].rready      =  rready_master_passive[i];
  assign   axi_if.master_if[i].rack      =  rack_master_passive[i];
  
  assign   axi_if.master_if[i].wvalid        =  wvalid_master_passive[i];
  assign   axi_if.master_if[i].wlast         =  wlast_master_passive[i];
  assign   axi_if.master_if[i].wdata         =  wdata_master_passive[i];
  assign   axi_if.master_if[i].wstrb         =  wstrb_master_passive[i];
  assign   axi_if.master_if[i].wid           =  wid_master_passive[i];
  
  assign   axi_if.master_if[i].wack          =  wack_master_passive[i];
  
  assign   axi_if.master_if[i].awregion  =  awregion_master_passive[i];
  assign   axi_if.master_if[i].awqos         =  awqos_master_passive[i];
  assign   axi_if.master_if[i].awuser        =  awuser_master_passive[i];
  assign   axi_if.master_if[i].arregion  =  arregion_master_passive[i];
  assign   axi_if.master_if[i].arqos         =  arqos_master_passive[i];
  assign   axi_if.master_if[i].aruser        =  aruser_master_passive[i];
  assign   axi_if.master_if[i].wuser         =  wuser_master_passive[i];
  
  assign   axi_if.master_if[i].acready   =  acready_master_passive[i];
  
  assign   axi_if.master_if[i].crvalid   =  crvalid_master_passive[i];
  assign   axi_if.master_if[i].crresp      =  crresp_master_passive[i];
  
  assign   axi_if.master_if[i].cdvalid   =  cdvalid_master_passive[i];
  assign   axi_if.master_if[i].cddata        =  cddata_master_passive[i];
  assign   axi_if.master_if[i].cdlast        =  cdlast_master_passive[i];

  assign   axi_if.master_if[i].bready      =  bready_master_passive[i];

  end endgenerate
`endif 

// =============================================================================
  generate for(i=0; i<=num_slaves-1; i++) begin: IO_assign_4

// -----------------------------------------------------------------------------
  assign axi_if.slave_if[i].aresetn = aresetn;

  assign awready_slave[i]    =     axi_if.slave_if[i].awready;
  assign arready_slave[i]    =     axi_if.slave_if[i].arready;
                                                 
                                                 
  assign rvalid_slave[i]     =     axi_if.slave_if[i].rvalid;
  assign rlast_slave[i]      =     axi_if.slave_if[i].rlast;
  assign rdata_slave[i]      =     axi_if.slave_if[i].rdata;
  assign rresp_slave[i]      =     axi_if.slave_if[i].rresp;
  assign rid_slave[i]        =     axi_if.slave_if[i].rid;
                                                 
  assign wready_slave[i]     =     axi_if.slave_if[i].wready;
                                                 
  assign bvalid_slave[i]     =     axi_if.slave_if[i].bvalid;
  assign bresp_slave[i]      =     axi_if.slave_if[i].bresp;
  assign bid_slave[i]        =     axi_if.slave_if[i].bid;
                                                 
  assign ruser_slave[i]      =     axi_if.slave_if[i].ruser;
  assign buser_slave[i]      =     axi_if.slave_if[i].buser;
                                                 
  assign acvalid_slave[i]    =     axi_if.slave_if[i].acvalid;
  assign acaddr_slave[i]     =     axi_if.slave_if[i].acaddr;
  assign acsnoop_slave[i]    =     axi_if.slave_if[i].acsnoop;
//  assign aclen_slave[i]        =     axi_if.slave_if[i].aclen;
  assign acprot_slave[i]     =     axi_if.slave_if[i].acprot;
                                                 
  assign crready_slave[i]    =     axi_if.slave_if[i].crready;
                                                 
  assign cdready_slave[i]    =     axi_if.slave_if[i].cdready;
  end endgenerate


// =============================================================================

`ifdef SVT_MULTI_SIM_PROCEDURAL_COMBINATORIAL_DRIVE

  generate for(i=0; i<=num_slaves-1; i++) begin:IO_assign_5
  always @(awvalid_slave[i]) axi_if.slave_if[i].awvalid = awvalid_slave[i];
  always @(awaddr_slave[i]) axi_if.slave_if[i].awaddr  = awaddr_slave[i];
  always @(awlen_slave[i]) axi_if.slave_if[i].awlen   = awlen_slave[i];
  always @(awsize_slave[i]) axi_if.slave_if[i].awsize  = awsize_slave[i];
  always @(awburst_slave[i]) axi_if.slave_if[i].awburst = awburst_slave[i];
  always @(awlock_slave[i]) axi_if.slave_if[i].awlock  = awlock_slave[i];
  always @(awcache_slave[i]) axi_if.slave_if[i].awcache = awcache_slave[i];
  always @(awprot_slave[i]) axi_if.slave_if[i].awprot  = awprot_slave[i];
  always @(awid_slave[i]) axi_if.slave_if[i].awid    = awid_slave[i];
                            
  always @(awdomain_slave[i]) axi_if.slave_if[i].awdomain    = awdomain_slave[i];
  always @(awsnoop_slave[i]) axi_if.slave_if[i].awsnoop = awsnoop_slave[i];
  always @(awbar_slave[i]) axi_if.slave_if[i].awbar   = awbar_slave[i];
                            
  always @(arvalid_slave[i])axi_if.slave_if[i].arvalid = arvalid_slave[i];
  always @(araddr_slave[i]) axi_if.slave_if[i].araddr  = araddr_slave[i];
  always @(arlen_slave[i]) axi_if.slave_if[i].arlen   = arlen_slave[i];
  always @(arsize_slave[i]) axi_if.slave_if[i].arsize  = arsize_slave[i];
  always @(arburst_slave[i]) axi_if.slave_if[i].arburst = arburst_slave[i];
  always @(arlock_slave[i]) axi_if.slave_if[i].arlock  = arlock_slave[i];
  always @(arcache_slave[i]) axi_if.slave_if[i].arcache = arcache_slave[i];
  always @(arprot_slave[i]) axi_if.slave_if[i].arprot  = arprot_slave[i];
  always @(arid_slave[i]) axi_if.slave_if[i].arid    = arid_slave[i];
                            
  always @(ardomain_slave[i]) axi_if.slave_if[i].ardomain    = ardomain_slave[i];
  always @(arsnoop_slave[i]) axi_if.slave_if[i].arsnoop = arsnoop_slave[i];
  always @(arbar_slave[i]) axi_if.slave_if[i].arbar   = arbar_slave[i];
                            
  always @(rready_slave[i]) axi_if.slave_if[i].rready  = rready_slave[i];
  always @(rack_slave[i]) axi_if.slave_if[i].rack    = rack_slave[i];
                            
  always @(wvalid_slave[i])axi_if.slave_if[i].wvalid  = wvalid_slave[i];
  always @(wlast_slave[i]) axi_if.slave_if[i].wlast   = wlast_slave[i];
  always @(wdata_slave[i]) axi_if.slave_if[i].wdata   = wdata_slave[i];
  always @(wstrb_slave[i]) axi_if.slave_if[i].wstrb   = wstrb_slave[i];
  always @(wid_slave[i]) axi_if.slave_if[i].wid     = wid_slave[i];
                            
  always @(bready_slave[i]) axi_if.slave_if[i].bready  = bready_slave[i];
  always @(wack_slave[i]) axi_if.slave_if[i].wack    = wack_slave[i];
                            
  always @(awregion_slave[i]) axi_if.slave_if[i].awregion    = awregion_slave[i];
  always @(awqos_slave[i]) axi_if.slave_if[i].awqos   = awqos_slave[i];
  always @(awuser_slave[i]) axi_if.slave_if[i].awuser  = awuser_slave[i];
  always @(arregion_slave[i]) axi_if.slave_if[i].arregion    = arregion_slave[i];
  always @(arqos_slave[i]) axi_if.slave_if[i].arqos   = arqos_slave[i];
  always @(aruser_slave[i]) axi_if.slave_if[i].aruser  = aruser_slave[i];
  always @(wuser_slave[i]) axi_if.slave_if[i].wuser   = wuser_slave[i];
                            
  always @(acready_slave[i]) axi_if.slave_if[i].acready = acready_slave[i];
                            
  always @(crvalid_slave[i]) axi_if.slave_if[i].crvalid = crvalid_slave[i];
  always @(crresp_slave[i]) axi_if.slave_if[i].crresp  = crresp_slave[i];
                            
  always @(cdvalid_slave[i]) axi_if.slave_if[i].cdvalid = cdvalid_slave[i];
  always @(cddata_slave[i]) axi_if.slave_if[i].cddata  = cddata_slave[i];
  always @(cdlast_slave[i]) axi_if.slave_if[i].cdlast  = cdlast_slave[i];

// =============================================================================

  always @(awready_slave_passive[i])  axi_if.slave_if[i].awready   =  awready_slave_passive[i];        
  always @(arready_slave_passive[i])  axi_if.slave_if[i].arready   =  arready_slave_passive[i];        
                                                         
  always @(rvalid_slave_passive[i])  axi_if.slave_if[i].rvalid    =  rvalid_slave_passive[i];         
  always @(rlast_slave_passive[i])  axi_if.slave_if[i].rlast     =  rlast_slave_passive[i];          
  always @(rdata_slave_passive[i])  axi_if.slave_if[i].rdata     =  rdata_slave_passive[i];          
  always @(rresp_slave_passive[i])  axi_if.slave_if[i].rresp     =  rresp_slave_passive[i];          
  always @(rid_slave_passive[i])  axi_if.slave_if[i].rid       =  rid_slave_passive[i];            
                                                         
  always @(wready_slave_passive[i])  axi_if.slave_if[i].wready    =  wready_slave_passive[i];         
                                                         
  always @(bvalid_slave_passive[i])  axi_if.slave_if[i].bvalid    =  bvalid_slave_passive[i];         
  always @(bresp_slave_passive[i])  axi_if.slave_if[i].bresp     =  bresp_slave_passive[i];          
  always @(bid_slave_passive[i])  axi_if.slave_if[i].bid       =  bid_slave_passive[i];            
                                                         
  always @(ruser_slave_passive[i])  axi_if.slave_if[i].ruser     =  ruser_slave_passive[i];          
  always @(buser_slave_passive[i])  axi_if.slave_if[i].buser     =  buser_slave_passive[i];          
                                                         
  always @(acvalid_slave_passive[i])  axi_if.slave_if[i].acvalid   =  acvalid_slave_passive[i];        
  always @(acaddr_slave_passive[i])  axi_if.slave_if[i].acaddr    =  acaddr_slave_passive[i];         
  always @(acsnoop_slave_passive[i])  axi_if.slave_if[i].acsnoop   =  acsnoop_slave_passive[i];        
//always @(aclen_slave_passive[i])  axi_if.slave_if[i].aclen     =  aclen_slave_passive[i];          
  always @(acprot_slave_passive[i])  axi_if.slave_if[i].acprot    =  acprot_slave_passive[i];         
                                                         
  always @(crready_slave_passive[i])  axi_if.slave_if[i].crready   =  crready_slave_passive[i];        
                                                         
  always @(cdready_slave_passive[i])  axi_if.slave_if[i].cdready   =  cdready_slave_passive[i];        
  end endgenerate

`else  

  generate for(i=0; i<=num_slaves-1; i++) begin:IO_assign_6
  assign axi_if.slave_if[i].awvalid = awvalid_slave[i];
  assign axi_if.slave_if[i].awaddr  = awaddr_slave[i];
  assign axi_if.slave_if[i].awlen   = awlen_slave[i];
  assign axi_if.slave_if[i].awsize  = awsize_slave[i];
  assign axi_if.slave_if[i].awburst = awburst_slave[i];
  assign axi_if.slave_if[i].awlock  = awlock_slave[i];
  assign axi_if.slave_if[i].awcache = awcache_slave[i];
  assign axi_if.slave_if[i].awprot  = awprot_slave[i];
  assign axi_if.slave_if[i].awid    = awid_slave[i];
                            
  assign axi_if.slave_if[i].awdomain    = awdomain_slave[i];
  assign axi_if.slave_if[i].awsnoop = awsnoop_slave[i];
  assign axi_if.slave_if[i].awbar   = awbar_slave[i];
                            
  assign axi_if.slave_if[i].arvalid = arvalid_slave[i];
  assign axi_if.slave_if[i].araddr  = araddr_slave[i];
  assign axi_if.slave_if[i].arlen   = arlen_slave[i];
  assign axi_if.slave_if[i].arsize  = arsize_slave[i];
  assign axi_if.slave_if[i].arburst = arburst_slave[i];
  assign axi_if.slave_if[i].arlock  = arlock_slave[i];
  assign axi_if.slave_if[i].arcache = arcache_slave[i];
  assign axi_if.slave_if[i].arprot  = arprot_slave[i];
  assign axi_if.slave_if[i].arid    = arid_slave[i];
                            
  assign axi_if.slave_if[i].ardomain    = ardomain_slave[i];
  assign axi_if.slave_if[i].arsnoop = arsnoop_slave[i];
  assign axi_if.slave_if[i].arbar   = arbar_slave[i];
                            
  assign axi_if.slave_if[i].rready  = rready_slave[i];
  assign axi_if.slave_if[i].rack    = rack_slave[i];
                            
  assign axi_if.slave_if[i].wvalid  = wvalid_slave[i];
  assign axi_if.slave_if[i].wlast   = wlast_slave[i];
  assign axi_if.slave_if[i].wdata   = wdata_slave[i];
  assign axi_if.slave_if[i].wstrb   = wstrb_slave[i];
  assign axi_if.slave_if[i].wid     = wid_slave[i];
                            
  assign axi_if.slave_if[i].bready  = bready_slave[i];
  assign axi_if.slave_if[i].wack    = wack_slave[i];
                            
  assign axi_if.slave_if[i].awregion    = awregion_slave[i];
  assign axi_if.slave_if[i].awqos   = awqos_slave[i];
  assign axi_if.slave_if[i].awuser  = awuser_slave[i];
  assign axi_if.slave_if[i].arregion    = arregion_slave[i];
  assign axi_if.slave_if[i].arqos   = arqos_slave[i];
  assign axi_if.slave_if[i].aruser  = aruser_slave[i];
  assign axi_if.slave_if[i].wuser   = wuser_slave[i];
                            
  assign axi_if.slave_if[i].acready = acready_slave[i];
                            
  assign axi_if.slave_if[i].crvalid = crvalid_slave[i];
  assign axi_if.slave_if[i].crresp  = crresp_slave[i];
                            
  assign axi_if.slave_if[i].cdvalid = cdvalid_slave[i];
  assign axi_if.slave_if[i].cddata  = cddata_slave[i];
  assign axi_if.slave_if[i].cdlast  = cdlast_slave[i];

// =============================================================================

  assign  axi_if.slave_if[i].awready   =  awready_slave_passive[i];        
  assign  axi_if.slave_if[i].arready   =  arready_slave_passive[i];        
                                                         
  assign  axi_if.slave_if[i].rvalid    =  rvalid_slave_passive[i];         
  assign  axi_if.slave_if[i].rlast     =  rlast_slave_passive[i];          
  assign  axi_if.slave_if[i].rdata     =  rdata_slave_passive[i];          
  assign  axi_if.slave_if[i].rresp     =  rresp_slave_passive[i];          
  assign  axi_if.slave_if[i].rid       =  rid_slave_passive[i];            
                                                         
  assign  axi_if.slave_if[i].wready    =  wready_slave_passive[i];         
                                                         
  assign  axi_if.slave_if[i].bvalid    =  bvalid_slave_passive[i];         
  assign  axi_if.slave_if[i].bresp     =  bresp_slave_passive[i];          
  assign  axi_if.slave_if[i].bid       =  bid_slave_passive[i];            
                                                         
  assign  axi_if.slave_if[i].ruser     =  ruser_slave_passive[i];          
  assign  axi_if.slave_if[i].buser     =  buser_slave_passive[i];          
                                                         
  assign  axi_if.slave_if[i].acvalid   =  acvalid_slave_passive[i];        
  assign  axi_if.slave_if[i].acaddr    =  acaddr_slave_passive[i];         
  assign  axi_if.slave_if[i].acsnoop   =  acsnoop_slave_passive[i];        
//assign  axi_if.slave_if[i].aclen     =  aclen_slave_passive[i];          
  assign  axi_if.slave_if[i].acprot    =  acprot_slave_passive[i];         
                                                         
  assign  axi_if.slave_if[i].crready   =  crready_slave_passive[i];        
                                                         
  assign  axi_if.slave_if[i].cdready   =  cdready_slave_passive[i];
  end endgenerate

`endif


`endif
endmodule
