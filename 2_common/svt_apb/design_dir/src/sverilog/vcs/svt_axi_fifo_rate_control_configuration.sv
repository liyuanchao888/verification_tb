//=======================================================================
// COPYRIGHT (C) 2017-2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_axi_fifo_rate_control_configuration extends svt_amba_fifo_rate_control_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_axi_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_fifo_rate_control_configuration)
  `svt_data_member_end(svt_axi_fifo_rate_control_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass:svt_axi_fifo_rate_control_configuration


`protected
.gV^(<GW83b;(:>S&0?BNFE0(e4M]/6NFCS@b8.I3:VE[I0KDE)@5)JX^JR/Ae/L
)2PVNWFA9A@_6Z6)SM31P>J@9+?F7BN&2^YE@a03a,^c,2W)fVCcC2XaN+d>PQGa
+AV._>]2=6Y7943EO1F2/XR,WCP/LN@d_7eC04.OHPWZ4(BfB-QRZ.>d]3XYE2bI
DJ:NfHY^NAbS?)()TgNLF7>eJP>3E@8>HIM^@;Z)fN^(AZ-XGCZ<@V+2XFbQN=)Z
T1e]K]6.,fP0dK7AGE&BP(0AYK5S9O^<JBeb.BZ5VQ/\)0#07EI\5c&f[\#-KCb@
M\]IaB-?R:\V96g5G5:)=&<K\+R/ZZ4d;_C,QD,fWQ-Q:=IE_/MgI]SdP;#9W<XF
L?_/ZXDY+:GPL8CWdSHYON4ff.PR2LA;3abEH#2V[0P#_K8X,A7&bc-TSMYa,AR0
VNU:KVJe/2<NC>(9&T?.0]gI3H/_@J_Rg8T3:V<c4eB,ObJQ6Q#T^g?KG_/:]^TF
JW)fBR9<3Hd2e.)1RK=g/,9+\KbfcCN7F;Df;(60#Z2ZP,,6AKT_O6+V_O(UC6K_
T;H3cV1CaLK-RI^6U;XT<SWP&4]IXfU2Z<Hb-b\bAZF=\f<;JACf<^TUTTM#A(L>
P@F9C+JZ<Se->d>OC7cW1Y<bWS]IbNg[^f:#e5==QTX=F$
`endprotected

   
`endif //  `ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
