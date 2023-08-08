//=======================================================================
// COPYRIGHT (C) 2010-2018 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV 

/**
  * Base class for system monitor callback data object. 
  * The data object of this class will be used as argument to newly aaded callbacks in CHI system monitor.
  *
  */
class svt_chi_system_monitor_callback_data extends svt_chi_callback_data;


  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_callback_data", "class" );
  `endif


//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_system_monitor_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

endclass
`protected
YGaKR@#de;X;<J>YQ98)a4EC9:WS/D>O9V97S)>G>2J[B1K:-BT61)>+cFN:UGZX
B7ZaR=OG<@@3g73I5OeL4HdE7Xca.RF\IUY#CdDgA.?.MW4+1.bbIa4<O=1L9E.^
?VJ4fO@(^IK4OQJ)REF086WX]?0HJe]=J.O^WM+P2aFPeL_]a3^,7c/B<C[;;1I@
Q,:.L8^3^>?G0DZg]&T[ReBd1+8^OdBWS:6DZK1gE+J>7[.]g[F:Pc(S9P4J^&N-
.=;Z7\&;J9Q9[4;5XA4AI(LM-XD(W?>UTT0g?T>(\0RM6[K-ce85.gX3^;#T2S:M
^M#]dVEG<(]1Re6+JMBBRX2NC\JTfT+DAg?:eJbaP?3[Db<VCBEP;R&/;gY2LIP+
R8U;@@PGBC.S;daYG]A;>4Y,/I\?IISYNO,S(26Ea(^((>4BM41OAD2R:7A3+EM+
AV8g6SPDX8#^I-2;2AU+2-DI^\JQK_g2>$
`endprotected


`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV 
