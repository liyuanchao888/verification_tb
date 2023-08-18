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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bTbrBILZ4QRXSLJl9d4ged5U2lD7vDiXnPafQKi0F06FHbM5PucbhYVqM5s+MGuB
E4/REv9UPn+jjLX35d25RHPCBd7k6oAQRBka3yh0LhaQx14sFhezUYJ011AX/2AN
7hpXK+TarbMRgNFtqtnvOBjzbn4QxnU0J/mTAP9TLRQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 704       )
qsmb4vzLKrWyBhzYJmf+hvnNVCAuvzT4UfgxdaaddO2GotMqrfTedUWVHcUxcocM
3+w36z6P/2vi+dPuQ7fK6Di+lqU4h+ZeD+jAusN8GOoqVGAqUMqirDFajxM8Yhcw
rXJ0RRCT/o0q3IUWcgl9maP059RqyGj1jQOg7Alfgd04mBXegc24CwBCdc+j5Lsa
wSGVAyYlHarefiaC0d4r2zjFmb3vZANSV4Tf4xhavDOz/p73FZqw7mZO/uWaVmvf
JOmZSKz4uOFnu3gGguiKa25Ya+xbZsgUnOUYpztPrkZHqkqQMmWnW0ys0VcJYnYk
X8RX1RZcqmEMxoLXEvjNpuoq0U+oTpBGG43NJi2oUAlzZ/dSIh/0JMhcqu4o197J
8cc9TQsJ6tb6kmXsATTzlJLnt1u0uoYgWhn08NlhGse/68WDIZzWuG+OzKECxFuB
bP6mBfd5vw+fkxfITJxudu9Xcfk+NjNq2F6L9sgde6rf7xUedd39BJa3viOL48nd
Vb3/TBLvKTeMjCPhuK9D9tMt5/TqHSqPAwhKkuiZDCLW63mDSpnr1pW9Fbrz6gZG
Ai96x97WURJXLwX+2HsQKAEfRD+Hbk9A7Cu+zXYv90oHcE+OYgfwmZw71HoGGTIE
x3McVZqqlXWbvw4hT4e25hyeh1b4Bzc5oBRHunb5FNnRmqOsNny8Y0Cv32AohxXW
kE9SeVXhPHjBbaT4eaj8oydR4RVpZJM1oKkHNr41pP85mqxGrwxvILYZnoVgL5J2
PTTPEzV9hos33EHGAm+Y+v1wIZSsz6lXCXoW8Xt1PqDtkb2LT8Cw/cMggkCgE7ZA
pls1xOu6VTe9f7FPXli92kqacxgtpUItU4FLoXmmJCod82wpQzyViLAis6IoCDui
GDT21LfkBrGjiXrqwghSCh/YHlGgJSu9wY76KQXh1P6E5lyK7d52ahXRZT52Wkhh
`pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HxI/jNsotysmP8ZGK7Eal0H15mioJVqRdKRx7XgVS7xuUIikcjvTPaYpBgCjfymW
W2I8DFCYc0F5xyKboJfzeqm2x4+vmmKRUvvBxGUjoGdAiep6B9kmRIISETlb8UOU
yKhjYmKYkiSP7tuyzN+cey4u0A0VNRa+ZFDcgTOr3ds=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 787       )
t3N/mFsytGmlIPEBsJpzc8aORLL0tS0hexA2xxccqzbglL5wFwseZJ07F0sSbEAY
NJU4UDo8uols85lcKEWGU1qWSSCBgTNBuADmNDLlM35vt0oXLdcr9SaLOOMKqmaO
`pragma protect end_protected
