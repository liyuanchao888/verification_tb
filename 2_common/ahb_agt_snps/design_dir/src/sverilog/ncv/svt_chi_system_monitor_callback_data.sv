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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6wKbetQdnIDb0IQjSBqxZZDn/9ob598CIei+YKDEJn8QdDY01zE8Yjx0c0jbHysa
Iee9rqIaN9adSZqJmYK1Ru7w9J5d4+Bkpt5IsDAl9D49sxs8IWWKNFgEcbdS5IZs
Rho3xAtx2qnyv6wO2cyuVz1IwWT0gFVANOxZBgL+UZ1l/J/KneHEWA==
//pragma protect end_key_block
//pragma protect digest_block
6cQV7Sew+b5rXwSij8nXivA2Ckw=
//pragma protect end_digest_block
//pragma protect data_block
XlitpGH/7fGizJIwTummAEXybYf+rpsty7+jNxWNJ5zGHkAFEQIyOw6ttuqK/UwM
hXcO0XIDGQdMmv+loB418TS+VrYHhzIlzTLnwaj7V0qqy/hARX4OAmwFCtC0gvt9
aASdrGswfCfukWnVm05tOtxLhEQC1uMrLxXOp9QRbhlASLvvor4XxGytAdgymU3n
LmfZ7xTkS69pyrwMMt6/YF38kxTeRe9MX+Q5dj3ttA9ktk3lnhV9ydOMPV0liuVU
fUtGPv/E2H0VIpFrltYRdb5bhJhvUUUzV4jZEvjpe8Z192kN44T8svhHi3gVglBU
N56yASDWpf8jNEMgMcHZbtshErEULWU+giUpSJ0Wx3Yr3eg0sbCZ5jq3BlgM25E4
uVjjy1esq4n1nENzPo/G6XjbzkMG/B69GcwTSvsEIhy1bxnJek8AK2nJd35hFv8e
M62TJ43OXhPjggL9ZaHXE/igF2Qo8CQCPxyrXnvYCD83VJ+GZds4PLKXHQWxsYah
E0zJY3pqZJRFh0JWEC/2ZyQfjbp7rDK4sptMQkMs4ZYbzHXJHAdk/P66ALVyyD5S
gO7H52KDAu1t352w2+sRP99NmO0KhcuZtGzj6KHLXhy/gRE4yZQKqVdmfBxuDqEt
3G+d4uvtRt92v8vwQAJUMfrl0QlBRRXX8MLil1BCZNiVsRw8ZRUcsvHxBw/EJLMp
u0KwbiuwBUabDEuYLoTe90euIC60sxbEXQ5mLp2LY/b8zQ1EwnzTWHlzrcGl1nXw
m4jg4NAYVQaIhVncIEfFel5nS0GrbnUUHqNGqa0xs7VXPDOLsjKOs8nEwR0yr949
jHjfMjLax0uptuJGl/Neog==
//pragma protect end_data_block
//pragma protect digest_block
ZzwmVKXGiP+8k5RoSbhwXQKo3Dk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV 
