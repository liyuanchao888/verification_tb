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
>T5Ab(>T0WPE=[?A0,;01P/<Y)9]9DKgg:2QEWAJaC463J:.T>\W,)fSXG)f[OQ,
\<UV11O9FY5-@RgA_N>0d3eL/U(SCM\a3?T_@3.HY-_#HP_9722SIa0=G@LMS@_V
46YSK[;K8(>A]Mb_,3^@a4IE3I75/(0YeV(BYLM2/]GIK+=Aabf.IA]PgO>@RYQ>
2.B,HMA\g@H2]OQIJeP(3FY)Ia)g;H^a]#MBbK(>+00ID$
`endprotected
`include "svt.uvm.pkg"
`protected
6gH=24GUMS#)R?/AGaJ=?UI8731C_G8@32VAb/=&M4A?57K=@\H;7)&8&Xd[2.P;
0_Gc_=.1V?25W4EKRBKf14=_NK)OfQ]1B8UdQbWVVOY#X)J<^F<W7G&8L$
`endprotected
`include "svt_mem.uvm.pkg"
`protected
2,bPF?]VQKdB=JJW\LUfd84d3&KP#4#S7EPM<7U5eJ@:.8Q<9I7]-)F4VZ)a#W:.
:aL+5_-dF,XV)ZA6b)LDTP4d1$
`endprotected
`include "uvm_macros.svh"
`protected
QAEc8H]1_GN04J1])WT_=UQQ-e:M1O=&D[.+PT^<JYSG[NR2dG@0/):21^(]OTUF
##Ac7KSV-O8cNYUTM#67fIaHF_[>:M;F?$
`endprotected
`include "svt_uvm_pkg.svi"
`protected
7)GSTa/<J=b3UeU)#9GJ>##=[eZ-Xf[@<0Q@He=,6CGG_C3ILJ58()ET?CU2gdM&
J&<N4GdQD&78GU=-e-C9@Bc@9HC+T0\?MWL-(44DPbL-gKL>5A7A84H/?g_@3Ya6
MC(HW^56E@G(^Pe7c>>H9M7#/LNX?0QGGTUg6XgaMJU=>fOCe>Y-.V<Q4E0R8MLXW$
`endprotected
`include "svt_axi_if.svi"
`protected
0NX,=SKU:BU6N.LKM2f5-^1YUZ?7gWYRUB3@fL/dJO)((FR08JP82)J2ZWT0MdJ8
IYF6]@8BBf&6)$
`endprotected
`include "svt_axi_master_agent_cmd_source.svi"
`protected
E#ZB;27bcJVJ(e)Rb#O)6@(X1>(57d4V:.dBE5_c/EEFH+@V^bKa2)gS[N_:<P7:
&X]0(cFJ)B#[M5MG0(0_QFg^H])88]Qfg+0LONTY:fM.,\>5Y,fHe,(\8>&/^(I2
cQe8[N+ON:<\NDG#93b:eSO2.6E1N4G/OaNL)&,:+aOVO5K7R>&#4NV,\&900Ceg
A58^X&R<@;.C,V\P]+a6f=H[6A@g,EaCP^3I3Q;4d;U-/[75aL9:@]3\YC1??I_C
5EBF0G_WebW^;?1(42T.ER,R@B+A8MGODU1GHdE;E7[S>Y=EY>_T6=9E/dKbE:a;
g\)WX)[_^Z9I@KV@(+[3/+Ng?+]9Q;RZ)(MOHC;[QGH8DBRXNeB^2PM>SUG_R&,F
WJPL2V?JDKgT#A=1;;I7?:Ng7$
`endprotected


module svt_axi_master_agent_hdl (

            CLK, 
            aresetn,

            awvalid,
            awvalid_passive,
            awaddr,
            awaddr_passive,
            awlen,
            awlen_passive,
            awsize,
            awsize_passive,
            awburst,
            awburst_passive,
            awlock,
            awlock_passive,
            awcache,
            awcache_passive,
            awprot,
            awprot_passive,
            awid,
            awid_passive,
            awready,

            awdomain,
            awdomain_passive,
            awsnoop,
            awsnoop_passive,
            awbar,
            awbar_passive,

            arvalid,
            arvalid_passive,
            araddr,
            araddr_passive,
            arlen,
            arlen_passive,
            arsize,
            arsize_passive,
            arburst,
            arburst_passive,
            arlock,
            arlock_passive,
            arcache,
            arcache_passive,
            arprot,
            arprot_passive,
            arid,
            arid_passive,
            arready,

            ardomain,
            ardomain_passive,
            arsnoop,
            arsnoop_passive,
            arbar,
            arbar_passive,

            rvalid,
            rlast,
            rdata,
            rresp,
            rid,
            rready,
            rready_passive,

            rack,
            rack_passive,

            wvalid,
            wvalid_passive,
            wlast,
            wlast_passive,
            wdata,
            wdata_passive,
            wstrb,
            wstrb_passive,
            wid,
            wid_passive,
            wready,

            bvalid,
            bresp,
            bid,
            bready,
            bready_passive,

            wack,
            wack_passive,

            awregion,
            awregion_passive,
            awqos,
            awqos_passive,
            awuser,
            awuser_passive,

            arregion,
            arregion_passive,
            arqos,
            arqos_passive,
            aruser,
            aruser_passive,

            wuser,
            wuser_passive,
            ruser,
            buser,

            acvalid,
            acready,
            acready_passive,
            acaddr,
            acsnoop,
            //aclen,
            acprot,

            crvalid,
            crvalid_passive,
            crready,
            crresp,
            crresp_passive,

            cdvalid,
            cdvalid_passive,
            cdready,
            cddata,
            cddata_passive,
            cdlast,
            cdlast_passive
            );

  /** Decides VIP will work in active or passive mode */
  parameter is_active = 1;
  /** Decides the instance name that can be changed from top */
  parameter string inst_name = "AXI_MASTER_AGENT";
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

  output                                         awvalid;
  input                                          awvalid_passive;
  output [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr;
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           awaddr_passive;
  output [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen;
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   awlen_passive;
  output [`SVT_AXI_SIZE_WIDTH-1:0]               awsize;
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               awsize_passive;
  output [`SVT_AXI_BURST_WIDTH-1:0]              awburst;
  input  [`SVT_AXI_BURST_WIDTH-1:0]              awburst_passive;
  output [`SVT_AXI_LOCK_WIDTH-1:0]               awlock;
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               awlock_passive;
  output [`SVT_AXI_CACHE_WIDTH-1:0]              awcache;
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              awcache_passive;
  output [`SVT_AXI_PROT_WIDTH-1:0]               awprot;
  input  [`SVT_AXI_PROT_WIDTH-1:0]               awprot_passive;
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             awid_passive;
  input                                          awready;

  // AXI ACE Extension of Write Address Channel Signals

  output [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain;  
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         awdomain_passive;  
  output [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop;   
  input  [`SVT_AXI_ACE_WSNOOP_WIDTH-1:0]         awsnoop_passive;   
  output [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar;
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        awbar_passive;

  //-----------------------------------------------------------------------
  // AXI Interface Read Address Channel Signals
  //-----------------------------------------------------------------------
  output                                         arvalid;
  input                                          arvalid_passive;
  output [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr;
  input  [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           araddr_passive;
  output [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen;
  input  [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   arlen_passive;
  output [`SVT_AXI_SIZE_WIDTH-1:0]               arsize;
  input  [`SVT_AXI_SIZE_WIDTH-1:0]               arsize_passive;
  output [`SVT_AXI_BURST_WIDTH-1:0]              arburst;
  input  [`SVT_AXI_BURST_WIDTH-1:0]              arburst_passive;
  output [`SVT_AXI_LOCK_WIDTH-1:0]               arlock;
  input  [`SVT_AXI_LOCK_WIDTH-1:0]               arlock_passive;
  output [`SVT_AXI_CACHE_WIDTH-1:0]              arcache;
  input  [`SVT_AXI_CACHE_WIDTH-1:0]              arcache_passive;
  output [`SVT_AXI_PROT_WIDTH-1:0]               arprot;
  input  [`SVT_AXI_PROT_WIDTH-1:0]               arprot_passive;
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             arid_passive;
  input                                          arready;

  // AXI ACE Extension of Read Address Channel 

  output [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain;  
  input  [`SVT_AXI_ACE_DOMAIN_WIDTH-1:0]         ardomain_passive;  
  output [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop;   
  input  [`SVT_AXI_ACE_RSNOOP_WIDTH-1:0]         arsnoop_passive;   
  output [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar;
  input  [`SVT_AXI_ACE_BARRIER_WIDTH-1:0]        arbar_passive;

  //-----------------------------------------------------------------------
  // AXI Interface Read Channel Signals
  //-----------------------------------------------------------------------
  input                                          rvalid;
  input                                          rlast;
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           rdata;
  input  [`SVT_AXI_RESP_WIDTH-1:0]               rresp;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             rid;
  output                                         rready;
  input                                          rready_passive;

  // AXI ACE Extension of Read Data Channel

  output                                         rack;
  input                                          rack_passive;

  //-----------------------------------------------------------------------
  // AXI Interface Write Channel Signals
  //-----------------------------------------------------------------------
  output                                         wvalid;
  input                                          wvalid_passive;
  output                                         wlast;
  input                                          wlast_passive;
  output [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata;
  input  [`SVT_AXI_MAX_DATA_WIDTH-1:0]           wdata_passive;
  output [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb;
  input  [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         wstrb_passive;
  output [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             wid_passive;
  input                                          wready;
  
  //-----------------------------------------------------------------------
  // AXI Interface Write Response Channel Signals
  //-----------------------------------------------------------------------
  input                                          bvalid;
  input  [`SVT_AXI_RESP_WIDTH-1:0]               bresp;
  input  [`SVT_AXI_MAX_ID_WIDTH-1:0]             bid;
  output                                         bready;
  input                                          bready_passive;

  // AXI ACE Extension of Write Response Channel

  output                                         wack;
  input                                          wack_passive;

  //-----------------------------------------------------------------------
  // AXI4 Interface Signals
  //-----------------------------------------------------------------------
  output [`SVT_AXI_REGION_WIDTH-1:0]             awregion;
  input  [`SVT_AXI_REGION_WIDTH-1:0]             awregion_passive;
  output [`SVT_AXI_QOS_WIDTH-1:0]                awqos;
  input  [`SVT_AXI_QOS_WIDTH-1:0]                awqos_passive;
  output [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser;
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      awuser_passive;
  
  output [`SVT_AXI_REGION_WIDTH-1:0]             arregion;
  input  [`SVT_AXI_REGION_WIDTH-1:0]             arregion_passive;
  output [`SVT_AXI_QOS_WIDTH-1:0]                arqos;
  input  [`SVT_AXI_QOS_WIDTH-1:0]                arqos_passive;
  output [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser;
  input  [`SVT_AXI_MAX_ADDR_USER_WIDTH-1:0]      aruser_passive;

  output [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser;
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      wuser_passive;
  input  [`SVT_AXI_MAX_DATA_USER_WIDTH-1:0]      ruser;
  input  [`SVT_AXI_MAX_BRESP_USER_WIDTH-1:0]     buser;

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Address Channel Signals 
  //-----------------------------------------------------------------------
  input                                          acvalid;   
  output                                         acready;   
  input                                          acready_passive;   
  input  [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0]     acaddr;            
  input  [`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0]     acsnoop;   
//input  [`SVT_AXI_ACE_SNOOP_BURST_WIDTH-1:0]    aclen;       
  input  [`SVT_AXI_ACE_SNOOP_PROT_WIDTH-1:0]     acprot;        

  //-----------------------------------------------------------------------
  // AXI ACE Interface SNOOP Response Channel Signals
  //-----------------------------------------------------------------------
  output                                         crvalid;   
  input                                          crvalid_passive;   
  input                                          crready;   
  output [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp;        
  input  [`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0]     crresp_passive;        

  //-----------------------------------------------------------------------
  // AXI ACE Interface Data Channel Signals
  //-----------------------------------------------------------------------
  output                                         cdvalid;   
  input                                          cdvalid_passive;   
  input                                          cdready;   
  output [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata;        
  input  [`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0]     cddata_passive;        
  output                                         cdlast;
  input                                          cdlast_passive;


`protected
d<XFa\5?PeAAbSZ7>N7Zc[:77&T90TQ89?7/LP^>Jb++VIX\4?W22)UYa7;gP&.9
W)Y.:QfSd?L0]c0PO9)M>95B3T3ZQKK)aOLR2df-++FD4Y@^&ECb4-]DZCWKMd9&
J]:8?ODRA3[0J5DI#ZHd3fa(:;GYGf]9c)37_&5eGTdO8M2ZMUH?X>g-X=P0Qgg4
C)Qa6/8;ESQ,_ge+Y,5MD=9B-Db9fd:S^Y/)=AD^F/<Fa6IaV#JW)_8g0\]HC(&a
Y83IB...I+C@4,.b?;V)X1PZWD&#.EbZ1f/#-]^82VQE=V#cZ2L&<Qd:Eb+;HB=_
aMAXS/.]G,R+;\bJM/;&C)&ggNSFCFB9Y^XK&L+D@/4[0a7&#O.ZWM0W?3K@@S3L
fVTX0Ja7+,X+-$
`endprotected

  
  //Pull in the common SVT HDL command 'export' declarations
  `include "svt_uvm_component_export.svi"

`ifndef __SVDOC__
  initial begin
    uvm_root top;

    cfg = new("master_cfg");
    cfg.set_master_if(axi_if.master_if[5]);
    cfg.is_active = is_active;
    sys_cfg = new("system_cfg"); 
    sys_cfg.set_if(axi_if);
    cfg.sys_cfg = sys_cfg;

    //uvm_resource_db#(svt_axi_port_configuration)::set($sformatf("%m.%s","AXI_MASTER_AGENT"), "cfg", cfg);
    uvm_resource_db#(svt_axi_port_configuration)::set($sformatf("%s.%s",hierarchy,inst_name), "cfg", cfg);

    //model = new ($sformatf("%m.%s","AXI_MASTER_AGENT"),null);
    model = new ($sformatf("%s.%s",hierarchy,inst_name),null);
    model.is_cmd_cfg_applied = 0;

    // Push this thread to the end of the timestep so that any other VLOG CMD models
    // have a chance to be constructed.
    #0;
    top = uvm_root::get();
    if (!top.has_child("uvm_test_top")) begin
      run_test("svt_axi_master_vlog_cmd_test");
    end
  end
// =============================================================================

  assign awvalid    = axi_if.master_if[5].awvalid;
  assign awaddr     = axi_if.master_if[5].awaddr;
  assign awlen      = axi_if.master_if[5].awlen;
  assign awsize     = axi_if.master_if[5].awsize;
  assign awburst    = axi_if.master_if[5].awburst;
  assign awlock     = axi_if.master_if[5].awlock;
  assign awcache    = axi_if.master_if[5].awcache;
  assign awprot     = axi_if.master_if[5].awprot;
  assign awid       = axi_if.master_if[5].awid;
 
  assign awdomain   = axi_if.master_if[5].awdomain;
  assign awsnoop    = axi_if.master_if[5].awsnoop;
  assign awbar      = axi_if.master_if[5].awbar;

  assign arvalid    = axi_if.master_if[5].arvalid;
  assign araddr     = axi_if.master_if[5].araddr;
  assign arlen      = axi_if.master_if[5].arlen;
  assign arsize     = axi_if.master_if[5].arsize;
  assign arburst    = axi_if.master_if[5].arburst;
  assign arlock     = axi_if.master_if[5].arlock;
  assign arcache    = axi_if.master_if[5].arcache;
  assign arprot     = axi_if.master_if[5].arprot;
  assign arid       = axi_if.master_if[5].arid;

  assign ardomain   = axi_if.master_if[5].ardomain;
  assign arsnoop    = axi_if.master_if[5].arsnoop;
  assign arbar      = axi_if.master_if[5].arbar;

  assign rready     = axi_if.master_if[5].rready;
  assign rack       = axi_if.master_if[5].rack;

  assign wvalid     = axi_if.master_if[5].wvalid;
  assign wlast      = axi_if.master_if[5].wlast;
  assign wdata      = axi_if.master_if[5].wdata;
  assign wstrb      = axi_if.master_if[5].wstrb;
  assign wid        = axi_if.master_if[5].wid;

  assign bready     = axi_if.master_if[5].bready;
  assign wack       = axi_if.master_if[5].wack;

  assign awregion   = axi_if.master_if[5].awregion;
  assign awqos      = axi_if.master_if[5].awqos;
  assign awuser     = axi_if.master_if[5].awuser;
  assign arregion   = axi_if.master_if[5].arregion;
  assign arqos      = axi_if.master_if[5].arqos;
  assign aruser     = axi_if.master_if[5].aruser;
  assign wuser      = axi_if.master_if[5].wuser;

  assign acready    = axi_if.master_if[5].acready;

  assign crvalid    = axi_if.master_if[5].crvalid;
  assign crresp     = axi_if.master_if[5].crresp;

  assign cdvalid    = axi_if.master_if[5].cdvalid;
  assign cddata     = axi_if.master_if[5].cddata;
  assign cdlast     = axi_if.master_if[5].cdlast;

// -----------------------------------------------------------------------------
`ifdef SVT_MULTI_SIM_PROCEDURAL_COMBINATORIAL_DRIVE

  always @(CLK) axi_if.common_aclk     = CLK;
  always @(aresetn) axi_if.master_if[5].aresetn    = aresetn;

  always @(awready) axi_if.master_if[5].awready    = awready;
  always @(arready) axi_if.master_if[5].arready    = arready;


  always @(rvalid)axi_if.master_if[5].rvalid = rvalid;
  always @(rlast) axi_if.master_if[5].rlast  = rlast;
  always @(rdata) axi_if.master_if[5].rdata  = rdata;
  always @(rresp) axi_if.master_if[5].rresp  = rresp;
  always @(rid) axi_if.master_if[5].rid    = rid;

  always @(wready)axi_if.master_if[5].wready = wready;

  always @(bvalid) axi_if.master_if[5].bvalid = bvalid;
  always @(bresp) axi_if.master_if[5].bresp  = bresp;
  always @(bid) axi_if.master_if[5].bid    = bid;

  always @(ruser) axi_if.master_if[5].ruser  = ruser;
  always @(buser) axi_if.master_if[5].buser  = buser;

  always @(acvalid)axi_if.master_if[5].acvalid    = acvalid;
  always @(acaddr)axi_if.master_if[5].acaddr = acaddr;
  always @(acsnoop)axi_if.master_if[5].acsnoop    = acsnoop;
//  assign axi_if.master_if[5].aclen    = aclen;
  always @(acprot)axi_if.master_if[5].acprot = acprot;

  always @(crready)axi_if.master_if[5].crready    = crready;

  always @(cdready)axi_if.master_if[5].cdready    = cdready;

// =============================================================================

  always @(awvalid_passive)   axi_if.master_if[5].awvalid    =  awvalid_passive;
  always @(awaddr_passive)   axi_if.master_if[5].awaddr      =  awaddr_passive;
  always @(awlen_passive)   axi_if.master_if[5].awlen        =  awlen_passive;
  always @(awsize_passive)   axi_if.master_if[5].awsize      =  awsize_passive;
  always @(awburst_passive)   axi_if.master_if[5].awburst    =  awburst_passive;
  always @(awlock_passive)   axi_if.master_if[5].awlock      =  awlock_passive;
  always @(awcache_passive)   axi_if.master_if[5].awcache    =  awcache_passive;
  always @(awprot_passive)   axi_if.master_if[5].awprot      =  awprot_passive;
  always @(awid_passive)   axi_if.master_if[5].awid          =  awid_passive;

  always @(awdomain_passive)   axi_if.master_if[5].awdomain  =  awdomain_passive;
  always @(awsnoop_passive)   axi_if.master_if[5].awsnoop    =  awsnoop_passive;
  always @(awbar_passive)   axi_if.master_if[5].awbar        =  awbar_passive;
  always @(arvalid_passive)   axi_if.master_if[5].arvalid    =  arvalid_passive;

  always @(araddr_passive)   axi_if.master_if[5].araddr      =  araddr_passive;
  always @(arlen_passive)   axi_if.master_if[5].arlen        =  arlen_passive;
  always @(arsize_passive)   axi_if.master_if[5].arsize      =  arsize_passive;
  always @(arburst_passive)   axi_if.master_if[5].arburst    =  arburst_passive;
  always @(arlock_passive)   axi_if.master_if[5].arlock      =  arlock_passive;
  always @(arcache_passive)   axi_if.master_if[5].arcache    =  arcache_passive;
  always @(arprot_passive)   axi_if.master_if[5].arprot      =  arprot_passive;
  always @(arid_passive)   axi_if.master_if[5].arid          =  arid_passive;
  
  always @(ardomain_passive)   axi_if.master_if[5].ardomain  =  ardomain_passive;
  always @(arsnoop_passive)   axi_if.master_if[5].arsnoop    =  arsnoop_passive;
  always @(arbar_passive)   axi_if.master_if[5].arbar        =  arbar_passive;
  
  always @(rready_passive)   axi_if.master_if[5].rready    =  rready_passive;
  always @(rack_passive)   axi_if.master_if[5].rack      =  rack_passive;
  
  always @(wvalid_passive)   axi_if.master_if[5].wvalid      =  wvalid_passive;
  always @(wlast_passive)   axi_if.master_if[5].wlast        =  wlast_passive;
  always @(wdata_passive)   axi_if.master_if[5].wdata        =  wdata_passive;
  always @(wstrb_passive)   axi_if.master_if[5].wstrb        =  wstrb_passive;
  always @(wid_passive)   axi_if.master_if[5].wid            =  wid_passive;
  
  always @(wack_passive)   axi_if.master_if[5].wack          =  wack_passive;
  
  always @(awregion_passive)   axi_if.master_if[5].awregion  =  awregion_passive;
  always @(awqos_passive)   axi_if.master_if[5].awqos        =  awqos_passive;
  always @(awuser_passive)   axi_if.master_if[5].awuser      =  awuser_passive;
  always @(arregion_passive)   axi_if.master_if[5].arregion  =  arregion_passive;
  always @(arqos_passive)   axi_if.master_if[5].arqos        =  arqos_passive;
  always @(aruser_passive)   axi_if.master_if[5].aruser      =  aruser_passive;
  always @(wuser_passive)   axi_if.master_if[5].wuser        =  wuser_passive;
  
  always @(acready_passive)   axi_if.master_if[5].acready    =  acready_passive;
  
  always @(crvalid_passive)   axi_if.master_if[5].crvalid    =  crvalid_passive;
  always @(crresp_passive)   axi_if.master_if[5].crresp    =  crresp_passive;
  
  always @(cdvalid_passive)   axi_if.master_if[5].cdvalid    =  cdvalid_passive;
  always @(cddata_passive)   axi_if.master_if[5].cddata      =  cddata_passive;
  always @(cdlast_passive)   axi_if.master_if[5].cdlast      =  cdlast_passive;

  always @(bready_passive)   axi_if.master_if[5].bready    =  bready_passive;

`else

  assign axi_if.common_aclk             = CLK;
  assign axi_if.master_if[5].aresetn    = aresetn;

  assign axi_if.master_if[5].awready    = awready;
  assign axi_if.master_if[5].arready    = arready;

  assign axi_if.master_if[5].rvalid     = rvalid;
  assign axi_if.master_if[5].rlast      = rlast;
  assign axi_if.master_if[5].rdata      = rdata;
  assign axi_if.master_if[5].rresp      = rresp;
  assign axi_if.master_if[5].rid        = rid;

  assign axi_if.master_if[5].wready     = wready;

  assign axi_if.master_if[5].bvalid     = bvalid;
  assign axi_if.master_if[5].bresp      = bresp;
  assign axi_if.master_if[5].bid        = bid;

  assign axi_if.master_if[5].ruser      = ruser;
  assign axi_if.master_if[5].buser      = buser;

  assign axi_if.master_if[5].acvalid    = acvalid;
  assign axi_if.master_if[5].acaddr     = acaddr;
  assign axi_if.master_if[5].acsnoop    = acsnoop;
//assign axi_if.master_if[5].aclen    = aclen;
  assign axi_if.master_if[5].acprot     = acprot;

  assign axi_if.master_if[5].crready    = crready;

  assign axi_if.master_if[5].cdready    = cdready;

// =============================================================================

  assign   axi_if.master_if[5].awvalid   =  awvalid_passive;
  assign   axi_if.master_if[5].awaddr        =  awaddr_passive;
  assign   axi_if.master_if[5].awlen         =  awlen_passive;
  assign   axi_if.master_if[5].awsize        =  awsize_passive;
  assign   axi_if.master_if[5].awburst   =  awburst_passive;
  assign   axi_if.master_if[5].awlock        =  awlock_passive;
  assign   axi_if.master_if[5].awcache   =  awcache_passive;
  assign   axi_if.master_if[5].awprot        =  awprot_passive;
  assign   axi_if.master_if[5].awid          =  awid_passive;

  assign   axi_if.master_if[5].awdomain  =  awdomain_passive;
  assign   axi_if.master_if[5].awsnoop   =  awsnoop_passive;
  assign   axi_if.master_if[5].awbar         =  awbar_passive;
  assign   axi_if.master_if[5].arvalid   =  arvalid_passive;

  assign   axi_if.master_if[5].araddr        =  araddr_passive;
  assign   axi_if.master_if[5].arlen         =  arlen_passive;
  assign   axi_if.master_if[5].arsize        =  arsize_passive;
  assign   axi_if.master_if[5].arburst   =  arburst_passive;
  assign   axi_if.master_if[5].arlock        =  arlock_passive;
  assign   axi_if.master_if[5].arcache   =  arcache_passive;
  assign   axi_if.master_if[5].arprot        =  arprot_passive;
  assign   axi_if.master_if[5].arid          =  arid_passive;
  
  assign   axi_if.master_if[5].ardomain  =  ardomain_passive;
  assign   axi_if.master_if[5].arsnoop   =  arsnoop_passive;
  assign   axi_if.master_if[5].arbar         =  arbar_passive;
  
  assign   axi_if.master_if[5].rready      =  rready_passive;
  assign   axi_if.master_if[5].rack      =  rack_passive;
  
  assign   axi_if.master_if[5].wvalid        =  wvalid_passive;
  assign   axi_if.master_if[5].wlast         =  wlast_passive;
  assign   axi_if.master_if[5].wdata         =  wdata_passive;
  assign   axi_if.master_if[5].wstrb         =  wstrb_passive;
  assign   axi_if.master_if[5].wid           =  wid_passive;
  
  assign   axi_if.master_if[5].wack          =  wack_passive;
  
  assign   axi_if.master_if[5].awregion  =  awregion_passive;
  assign   axi_if.master_if[5].awqos         =  awqos_passive;
  assign   axi_if.master_if[5].awuser        =  awuser_passive;
  assign   axi_if.master_if[5].arregion  =  arregion_passive;
  assign   axi_if.master_if[5].arqos         =  arqos_passive;
  assign   axi_if.master_if[5].aruser        =  aruser_passive;
  assign   axi_if.master_if[5].wuser         =  wuser_passive;
  
  assign   axi_if.master_if[5].acready   =  acready_passive;
  
  assign   axi_if.master_if[5].crvalid   =  crvalid_passive;
  assign   axi_if.master_if[5].crresp      =  crresp_passive;
  
  assign   axi_if.master_if[5].cdvalid   =  cdvalid_passive;
  assign   axi_if.master_if[5].cddata        =  cddata_passive;
  assign   axi_if.master_if[5].cdlast        =  cdlast_passive;

  assign   axi_if.master_if[5].bready      =  bready_passive;

`endif  
`endif
endmodule
