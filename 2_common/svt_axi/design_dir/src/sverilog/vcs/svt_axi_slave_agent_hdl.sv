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
O8&WeHFEZ<JHEXEcceILG;Q:/+D002X]EDa^M0H2Z0R/C_T,E+CL/)_SFJ\5?.0^
2Z_J,Y0-J5Y4?1EXU0I4G7#F)S,I-8T=ARDW=JE8ZDZH(+9DKWSVHOD[)]92:2=M
Z#)S=_,_9TY]f8:54+bLZ8-AM\PG]<X.Ie4\1\V2AYWM\@/de\LbH8C_;B(cS;1-
_NS^=(#+K=-O?f1/D:MZ5+G4:&_e,+MO#G^9(I:PVJbP@^&N[33c>40b#Z)T,1-9
Jb/^;7^a?1IO/$
`endprotected
`include "svt.uvm.pkg"
`protected
O[5YOc9\ELIb+2^A<<fLA,P/5PW65_=,0K_aNWd(SMgANGbTHY>.2):(=4MeZVPL
:G<3=EYbB_fDXX7162QBQ(P/1$
`endprotected
`include "uvm_macros.svh"
`protected
K&gR\FdQ#FdH<g?CFgdVD0[JDLSQ4VEc(VQGIR?/E7+@4KF(8gF:0)8C&-7>NZ?2
fTQ/@f?9?8](N]4[bA[H.e2VfN#SDLNe;,9C[))aT7_S72BUN:[GOSZ65S9BW>Ta
IU)JC7M>gGI(-$
`endprotected
`include "svt_uvm_pkg.svi"
`protected
.V,F=WBO5&=bB=g9SC5C6YVPZ3abI7J3)QOBLg@Yf06gZJ:HeL0U()\ON@7\f[fJ
Y2JFN=L-eL_C7>_X6e:.R<Yg(a[8_CJ_#N7-W#-MK-b.eSN>EgZ?(4\OJ$
`endprotected
`include "svt_axi_if.svi"
`protected
7)d4M8_B(JLKCcgb0S0NU>,5>Q:R]9BE^#ZSLTMR[6;2)]F+b))76)Z48&E<aNZ?
_:QHINa80^:/9]M7KL&dCS8M1E(JR07@^+@Dd;fPZQV2_ec4CO)_HF+.ER]>R,:Z
=e+JMR=O+.QSKdEOf()(+72X3;JD+K0-&>Ve=^LWU+dNd@]?dR:PWK]HK1Z/P-IR
e6:7Wg,K<+B11(0\:7dI\LTF0OZMB]KZ@X9c<PY\L3OO5R=3Na)[8-=2@[TaP-bK
Lb?aHUBNI.\7HZ;JR5_.\fef\NH[e,S[M_J./:<50?4D4LCU8?dbI21QJW4WZ?^R
KTC2Q2[a]QDCS(a\7WZF^dFM1EYE#@9e7YXH)O^aUPP0(<N2=fVQBWR3OJ272>TN
7KZ^afA6996(d>W;f@c\eKO\S@JcXS5XJ)N+<M[aM0g_4/?B_=J-GJ?41H@V&[S[
F+28#=ADQ:0,CQLL.CV<^P[X3G7I)W&7N^3=[\d60SMQVOG]-.J;GS-MF48&QZHQ
&KT#N\P2+dM<=-X#N&S<7#67:=fJ>C)GMA)Zbc7fWO0c+db/#>.AW3-MJ$
`endprotected



module svt_axi_slave_agent_hdl (

            CLK, //NS
            aresetn,

            awvalid,
            awaddr,
            awlen,
            awsize,
            awburst,
            awlock,
            awcache,
            awprot,
            awid,
            awready,
            awready_passive,
            awdomain, 
            awsnoop,
            awbar,

            arvalid,
            araddr,
            arlen,
            arsize,
            arburst,
            arlock,
            arcache,
            arprot,
            arid,
            arready,
            arready_passive,
            ardomain, 
            arsnoop,
            arbar,

            rvalid,
            rvalid_passive,
            rlast,
            rlast_passive,
            rdata,
            rdata_passive,
            rresp,
            rresp_passive,
            rid,
            rid_passive,
            rready,
            rack,

            wvalid,
            wlast,
            wdata,
            wstrb,
            wid,
            wready,
            wready_passive,

            bvalid,
            bvalid_passive,
            bresp,
            bresp_passive,
            bid,
            bid_passive,
            bready,
            wack,

            awregion,
            awqos,
            awuser,
            arregion,
            arqos,
            aruser,
            wuser,
            ruser,
            ruser_passive,
            buser,
            buser_passive,

            acvalid,
            acvalid_passive,
            acready,
            acaddr,
            acaddr_passive,
            acsnoop,
            acsnoop_passive,
            //aclen,
            acprot,
            acprot_passive,

            crvalid,
            crready,
            crready_passive,
            crresp,

            cdvalid,
            cdready,
            cdready_passive,
            cddata,
            cdlast
            );

  /** Decides VIP will work in active or passive mode */
  parameter is_active = 1;
  /** Decides the instance name that can be changed from top */
  parameter string inst_name = "AXI_SLAVE_AGENT";

//-----------------------------------------------------------------------

  input                                          CLK;
  input                                          aresetn;

  input                                          awvalid;
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr;
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen;
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               awsize;
  input  [`SVT_AXI_BURST_WIDTH-1:0]              awburst;
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               awlock;
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              awcache;
  input  [`SVT_AXI_PROT_WIDTH-1:0]               awprot;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid;
  output                                         awready;
  input                                          awready_passive;

  // AXI ACE Extension of Write Address Channel Signals
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain;   
  input  [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop;    
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar;

  //-----------------------------------------------------------------------
  // AXI Interface Read Address Channel Signals
  //-----------------------------------------------------------------------
  input                                         arvalid;
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr;
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen;
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               arsize;
  input  [`SVT_AXI_BURST_WIDTH-1:0]              arburst;
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               arlock;
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              arcache;
  input  [`SVT_AXI_PROT_WIDTH-1:0]               arprot;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid;
  output                                         arready;
  input                                          arready_passive;

  // AXI ACE Extension of Read Address Channel 
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain;   
  input  [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop;    
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar;

  //-----------------------------------------------------------------------
  // AXI Interface Read Channel Signals
  //-----------------------------------------------------------------------
  output                                         rvalid;
  input                                          rvalid_passive;
  output                                         rlast;
  input                                          rlast_passive;
  output [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata;
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata_passive;
  output [`SVT_AXI_RESP_WIDTH-1:0]               rresp;
  input  [`SVT_AXI_RESP_WIDTH-1:0]               rresp_passive;
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid_passive;
  input                                          rready;

  // AXI ACE Extension of Read Data Channel
  input                                          rack;

  //-----------------------------------------------------------------------
  // AXI Interface Write Channel Signals
  //-----------------------------------------------------------------------
  input                                          wvalid;
  input                                          wlast;
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata;
  input  [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid;
  output                                         wready;
  input                                          wready_passive;
  
  //-----------------------------------------------------------------------
  // AXI Interface Write Response Channel Signals
  //-----------------------------------------------------------------------
  output                                         bvalid;
  input                                          bvalid_passive;
  output [`SVT_AXI_RESP_WIDTH-1:0]               bresp;
  input  [`SVT_AXI_RESP_WIDTH-1:0]               bresp_passive;
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid_passive;
  input                                          bready;

  // AXI ACE Extension of Write Response Channel
  input                                          wack;

  //-----------------------------------------------------------------------
  // AXI4 Interface Signals
  //-----------------------------------------------------------------------
  input  [`SVT_AXI_REGION_WIDTH-1:0]             awregion;
  input  [`SVT_AXI_QOS_WIDTH-1:0]                awqos;
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser;
  
  input  [`SVT_AXI_REGION_WIDTH-1:0]             arregion;
  input  [`SVT_AXI_QOS_WIDTH-1:0]                arqos;
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser;

  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser;
  output [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser;
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser_passive;
  output [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser;
  input  [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser_passive;

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Address Channel Signals 
  //-----------------------------------------------------------------------
  output                                         acvalid;    
  input                                          acvalid_passive;    
  input                                          acready;    
  output [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr;         
  input  [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr_passive;         
  output [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop;    
  input  [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop_passive;    
//  output [`SVT_AXI_ACE_SNOOP_BURST_WIDTH-1:0]   aclen;        
  output [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot;     
  input  [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot_passive;     
  // wire                   acbar;  // doesn't appear to be used in spec

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Response Channel Signals
  //-----------------------------------------------------------------------
  input                                          crvalid;    
  output                                         crready;    
  input                                          crready_passive;    
  input  [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp;     

  //-----------------------------------------------------------------------
  // AXI ACE Interface Data Channel Signals
  //-----------------------------------------------------------------------
  input                                          cdvalid;    
  output                                         cdready;    
  input                                          cdready_passive;    
  input  [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata;     
  input                                          cdlast;

//-----------------------------------------------------------------------
// Interfaces for connection to the hdl wrapper module, along with indications as to their use
//-----------------------------------------------------------------------
//  

`protected
+3+G7,I@e9.\AM8AW6EA&&.X:5SPNAZB&M[_K#AQO789^TAZDN3_-).J,.<g=G=-
g5POM?##-<fN5@3/\_H@&M+c]OR&7F?/Yd5(ag()f+W)W\V.PRSY&(B(\LdXU<Q^
@Wa5>4501N@0K34+:KD-GC<3^DAfE97Q\TG>CUU]&QY.VHSOK)N(6NI0H;(7#+6?
@?&cQ28RbQdW3:#:&4S9P-5fF+70Y+#T5KgL]CWEc-LcQ[3f4&-0/9?<Q#+O+7+3
86+KKJUd,LGMGa6W6g>A,:[LRD4>N_C;D#dEI>5d,(_(O,L;Be,gFCBF).DMC@d+
0T2Y>>VX9?]7J^QY9&H.Wg6RK]dL_T1]OYF9]N0^XTR^=Z]]8.gV?7CTM;<SS,^W
:X1KW-B3U>?7-$
`endprotected


  //Pull in the common SVT HDL command 'export' declarations
  `include "svt_uvm_component_export.svi"

  `ifndef __SVDOC__
  initial begin
    uvm_root top;

    cfg = new("slave_cfg");
    cfg.set_slave_if(axi_if.slave_if[5]);
    cfg.is_active = is_active;
    sys_cfg = new("system_cfg"); 
    sys_cfg.set_if(axi_if);
    cfg.sys_cfg = sys_cfg;

    //uvm_resource_db#(svt_axi_port_configuration)::set($sformatf("%m.%s","AXI_SLAVE_AGENT"), "cfg", cfg);
    uvm_resource_db#(svt_axi_port_configuration)::set($sformatf("%s.%s",hierarchy,inst_name), "cfg", cfg);

    //model = new ($sformatf("%m.%s","AXI_SLAVE_AGENT"),null);
    model = new ($sformatf("%s.%s",hierarchy,inst_name),null);
    model.is_cmd_cfg_applied = 0;

    // Push this thread to the end of the timestep so that any other VLOG CMD models
    // have a chance to be constructed.
    #0;
    top = uvm_root::get();
    if (!top.has_child("uvm_test_top")) begin
      run_test("svt_axi_slave_vlog_cmd_test");
    end
  end

// =============================================================================
// -----------------------------------------------------------------------------

  assign axi_if.common_aclk= CLK;
  assign axi_if.slave_if[5].aresetn = aresetn;

  assign awready    =     axi_if.slave_if[5].awready;
  assign arready    =     axi_if.slave_if[5].arready;
                                                 
                                                 
  assign rvalid     =     axi_if.slave_if[5].rvalid;
  assign rlast      =     axi_if.slave_if[5].rlast;
  assign rdata      =     axi_if.slave_if[5].rdata;
  assign rresp      =     axi_if.slave_if[5].rresp;
  assign rid        =     axi_if.slave_if[5].rid;
                                                 
  assign wready     =     axi_if.slave_if[5].wready;
                                                 
  assign bvalid     =     axi_if.slave_if[5].bvalid;
  assign bresp      =     axi_if.slave_if[5].bresp;
  assign bid        =     axi_if.slave_if[5].bid;
                                                 
  assign ruser      =     axi_if.slave_if[5].ruser;
  assign buser      =     axi_if.slave_if[5].buser;
                                                 
  assign acvalid    =     axi_if.slave_if[5].acvalid;
  assign acaddr     =     axi_if.slave_if[5].acaddr;
  assign acsnoop    =     axi_if.slave_if[5].acsnoop;
//  assign aclen    =     axi_if.slave_if[5].aclen;
  assign acprot     =     axi_if.slave_if[5].acprot;
                                                 
  assign crready    =     axi_if.slave_if[5].crready;
                                                 
  assign cdready    =     axi_if.slave_if[5].cdready;

// =============================================================================
// -----------------------------------------------------------------------------

`ifdef SVT_MULTI_SIM_PROCEDURAL_COMBINATORIAL_DRIVE

  always @(awvalid) axi_if.slave_if[5].awvalid = awvalid;
  always @(awaddr) axi_if.slave_if[5].awaddr  = awaddr;
  always @(awlen) axi_if.slave_if[5].awlen   = awlen;
  always @(awsize) axi_if.slave_if[5].awsize  = awsize;
  always @(awburst) axi_if.slave_if[5].awburst = awburst;
  always @(awlock) axi_if.slave_if[5].awlock  = awlock;
  always @(awcache) axi_if.slave_if[5].awcache = awcache;
  always @(awprot) axi_if.slave_if[5].awprot  = awprot;
  always @(awid) axi_if.slave_if[5].awid    = awid;
                            
  always @(awdomain) axi_if.slave_if[5].awdomain    = awdomain;
  always @(awsnoop) axi_if.slave_if[5].awsnoop = awsnoop;
  always @(awbar) axi_if.slave_if[5].awbar   = awbar;
                            
  always @(arvalid)axi_if.slave_if[5].arvalid = arvalid;
  always @(araddr) axi_if.slave_if[5].araddr  = araddr;
  always @(arlen) axi_if.slave_if[5].arlen   = arlen;
  always @(arsize) axi_if.slave_if[5].arsize  = arsize;
  always @(arburst) axi_if.slave_if[5].arburst = arburst;
  always @(arlock) axi_if.slave_if[5].arlock  = arlock;
  always @(arcache) axi_if.slave_if[5].arcache = arcache;
  always @(arprot) axi_if.slave_if[5].arprot  = arprot;
  always @(arid) axi_if.slave_if[5].arid    = arid;
                            
  always @(ardomain) axi_if.slave_if[5].ardomain    = ardomain;
  always @(arsnoop) axi_if.slave_if[5].arsnoop = arsnoop;
  always @(arbar) axi_if.slave_if[5].arbar   = arbar;
                            
  always @(rready) axi_if.slave_if[5].rready  = rready;
  always @(rack) axi_if.slave_if[5].rack    = rack;
                            
  always @(wvalid)axi_if.slave_if[5].wvalid  = wvalid;
  always @(wlast) axi_if.slave_if[5].wlast   = wlast;
  always @(wdata) axi_if.slave_if[5].wdata   = wdata;
  always @(wstrb) axi_if.slave_if[5].wstrb   = wstrb;
  always @(wid) axi_if.slave_if[5].wid     = wid;
                            
  always @(bready) axi_if.slave_if[5].bready  = bready;
  always @(wack) axi_if.slave_if[5].wack    = wack;
                            
  always @(awregion) axi_if.slave_if[5].awregion    = awregion;
  always @(awqos) axi_if.slave_if[5].awqos   = awqos;
  always @(awuser) axi_if.slave_if[5].awuser  = awuser;
  always @(arregion) axi_if.slave_if[5].arregion    = arregion;
  always @(arqos) axi_if.slave_if[5].arqos   = arqos;
  always @(aruser) axi_if.slave_if[5].aruser  = aruser;
  always @(wuser) axi_if.slave_if[5].wuser   = wuser;
                            
  always @(acready) axi_if.slave_if[5].acready = acready;
                            
  always @(crvalid) axi_if.slave_if[5].crvalid = crvalid;
  always @(crresp) axi_if.slave_if[5].crresp  = crresp;
                            
  always @(cdvalid) axi_if.slave_if[5].cdvalid = cdvalid;
  always @(cddata) axi_if.slave_if[5].cddata  = cddata;
  always @(cdlast) axi_if.slave_if[5].cdlast  = cdlast;

// =============================================================================

  always @(awready_passive)  axi_if.slave_if[5].awready   =  awready_passive;        
  always @(arready_passive)  axi_if.slave_if[5].arready   =  arready_passive;        
                                                         
  always @(rvalid_passive)  axi_if.slave_if[5].rvalid    =  rvalid_passive;         
  always @(rlast_passive)  axi_if.slave_if[5].rlast     =  rlast_passive;          
  always @(rdata_passive)  axi_if.slave_if[5].rdata     =  rdata_passive;          
  always @(rresp_passive)  axi_if.slave_if[5].rresp     =  rresp_passive;          
  always @(rid_passive)  axi_if.slave_if[5].rid       =  rid_passive;            
                                                         
  always @(wready_passive)  axi_if.slave_if[5].wready    =  wready_passive;         
                                                         
  always @(bvalid_passive)  axi_if.slave_if[5].bvalid    =  bvalid_passive;         
  always @(bresp_passive)  axi_if.slave_if[5].bresp     =  bresp_passive;          
  always @(bid_passive)  axi_if.slave_if[5].bid       =  bid_passive;            
                                                         
  always @(ruser_passive)  axi_if.slave_if[5].ruser     =  ruser_passive;          
  always @(buser_passive)  axi_if.slave_if[5].buser     =  buser_passive;          
                                                         
  always @(acvalid_passive)  axi_if.slave_if[5].acvalid   =  acvalid_passive;        
  always @(acaddr_passive)  axi_if.slave_if[5].acaddr    =  acaddr_passive;         
  always @(acsnoop_passive)  axi_if.slave_if[5].acsnoop   =  acsnoop_passive;        
//always @(aclen_passive)  axi_if.slave_if[5].aclen     =  aclen_passive;          
  always @(acprot_passive)  axi_if.slave_if[5].acprot    =  acprot_passive;         
                                                         
  always @(crready_passive)  axi_if.slave_if[5].crready   =  crready_passive;        
                                                         
  always @(cdready_passive)  axi_if.slave_if[5].cdready   =  cdready_passive;        

`else  

  assign axi_if.slave_if[5].awvalid = awvalid;
  assign axi_if.slave_if[5].awaddr  = awaddr;
  assign axi_if.slave_if[5].awlen   = awlen;
  assign axi_if.slave_if[5].awsize  = awsize;
  assign axi_if.slave_if[5].awburst = awburst;
  assign axi_if.slave_if[5].awlock  = awlock;
  assign axi_if.slave_if[5].awcache = awcache;
  assign axi_if.slave_if[5].awprot  = awprot;
  assign axi_if.slave_if[5].awid    = awid;
                            
  assign axi_if.slave_if[5].awdomain    = awdomain;
  assign axi_if.slave_if[5].awsnoop = awsnoop;
  assign axi_if.slave_if[5].awbar   = awbar;
                            
  assign axi_if.slave_if[5].arvalid = arvalid;
  assign axi_if.slave_if[5].araddr  = araddr;
  assign axi_if.slave_if[5].arlen   = arlen;
  assign axi_if.slave_if[5].arsize  = arsize;
  assign axi_if.slave_if[5].arburst = arburst;
  assign axi_if.slave_if[5].arlock  = arlock;
  assign axi_if.slave_if[5].arcache = arcache;
  assign axi_if.slave_if[5].arprot  = arprot;
  assign axi_if.slave_if[5].arid    = arid;
                            
  assign axi_if.slave_if[5].ardomain    = ardomain;
  assign axi_if.slave_if[5].arsnoop = arsnoop;
  assign axi_if.slave_if[5].arbar   = arbar;
                            
  assign axi_if.slave_if[5].rready  = rready;
  assign axi_if.slave_if[5].rack    = rack;
                            
  assign axi_if.slave_if[5].wvalid  = wvalid;
  assign axi_if.slave_if[5].wlast   = wlast;
  assign axi_if.slave_if[5].wdata   = wdata;
  assign axi_if.slave_if[5].wstrb   = wstrb;
  assign axi_if.slave_if[5].wid     = wid;
                            
  assign axi_if.slave_if[5].bready  = bready;
  assign axi_if.slave_if[5].wack    = wack;
                            
  assign axi_if.slave_if[5].awregion    = awregion;
  assign axi_if.slave_if[5].awqos   = awqos;
  assign axi_if.slave_if[5].awuser  = awuser;
  assign axi_if.slave_if[5].arregion    = arregion;
  assign axi_if.slave_if[5].arqos   = arqos;
  assign axi_if.slave_if[5].aruser  = aruser;
  assign axi_if.slave_if[5].wuser   = wuser;
                            
  assign axi_if.slave_if[5].acready = acready;
                            
  assign axi_if.slave_if[5].crvalid = crvalid;
  assign axi_if.slave_if[5].crresp  = crresp;
                            
  assign axi_if.slave_if[5].cdvalid = cdvalid;
  assign axi_if.slave_if[5].cddata  = cddata;
  assign axi_if.slave_if[5].cdlast  = cdlast;

// =============================================================================

  assign  axi_if.slave_if[5].awready   =  awready_passive;        
  assign  axi_if.slave_if[5].arready   =  arready_passive;        
                                                         
  assign  axi_if.slave_if[5].rvalid    =  rvalid_passive;         
  assign  axi_if.slave_if[5].rlast     =  rlast_passive;          
  assign  axi_if.slave_if[5].rdata     =  rdata_passive;          
  assign  axi_if.slave_if[5].rresp     =  rresp_passive;          
  assign  axi_if.slave_if[5].rid       =  rid_passive;            
                                                         
  assign  axi_if.slave_if[5].wready    =  wready_passive;         
                                                         
  assign  axi_if.slave_if[5].bvalid    =  bvalid_passive;         
  assign  axi_if.slave_if[5].bresp     =  bresp_passive;          
  assign  axi_if.slave_if[5].bid       =  bid_passive;            
                                                         
  assign  axi_if.slave_if[5].ruser     =  ruser_passive;          
  assign  axi_if.slave_if[5].buser     =  buser_passive;          
                                                         
  assign  axi_if.slave_if[5].acvalid   =  acvalid_passive;        
  assign  axi_if.slave_if[5].acaddr    =  acaddr_passive;         
  assign  axi_if.slave_if[5].acsnoop   =  acsnoop_passive;        
//assign  axi_if.slave_if[5].aclen     =  aclen_passive;          
  assign  axi_if.slave_if[5].acprot    =  acprot_passive;         
                                                         
  assign  axi_if.slave_if[5].crready   =  crready_passive;        
                                                         
  assign  axi_if.slave_if[5].cdready   =  cdready_passive;

`endif
`endif
endmodule

