
`ifndef GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV

typedef class svt_axi_port_configuration;

/**
    The master reg transaction class extends from the AXI master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_axi_master_reg_transaction extends svt_axi_master_transaction;  

 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FmVZMLXMmwRFzEVYDohHf2J5+QDO2pbArtrbWpxlNXEsdbCZ/nulYwGB4jNsRlLj
3X8T3dCv4T/pWYwlIv7lKMJce7N0JxbffRzwzdpJj5qTTxMWIGm1x/KSE6NDtscc
v2FmaTV//GW+bJSR5gJ/LI+OGnr5/aCBd6r4NRXj2r78yZBA7iFy8g==
//pragma protect end_key_block
//pragma protect digest_block
8IVu6vFoTPULBEyP8mK9L0aWAD4=
//pragma protect end_digest_block
//pragma protect data_block
ZWrso4eKiFEoIxJOmRCEPmct2lkNfjxLu8S1BgZtIVIk9XlrNB+WobwDoQZ2//7i
XEEZEXis1cLnKwkP3fZ32cBbEEZQKETj/1QeAiLxP8/TwQdUYILiaD00s7pIjziF
uuCpoVWgPCggCnZCT+AXH7iQr6OS1V3L2Gad4DhUXHTDWGU/huGa63DHdiKOfpbs
UFC1k/AZW/fnIbksr4EIrHteYPDNrOXl5XUosX1HNipbX0+Cm1EXuPQiFcRpxicC
WWsOIn8jlMPoH4x8CaVuZOzsiHHh8q3l4yqlQkJedwSA+OK9zKVIHR0LL4cguz1t
3qtjtL4+xJFD1ZeXzzJcDTRRNb92kLa3ILuUw6mW7cTNMeEcw+SIPIzXHhY4qWXo
bjVEQOajKCsBPtv9+oOt+9Qlk8nv6Y9IXa7CCK6btGWU6VKZksrn3cW5EUJvVO/r
Y2ZkHVudoJomw271cEAz9KWnS4Cj15ARfHGZQyt4CFwbzTPvbj4WbvEFLcCZlDRC
G2sOzlGCpTIdFWMapB4Zm4/DZydYmKZB60AQSkJv84wK07DTBbdK0v6lDADXS0mc
n0dGnyrU2DhwQuneJ1D7h6oJCD9cZXk23Ve+H8nSIsE332a2vN1iH2o4XnfJQWoi
naNgM4U2EAGs3CbXZc+wBUPd7TkqdQKPU1ZpTVyHloFGpkI8wXpqfjkKDzY/nICV
ZpUpDxxGIResjXj2rCfx180HpRvzGKI9PVlJh007FeZj/CvKa9fhKbUk/nKpQsQq
T6y5QR8/ivTOS9NklHZEJlm31cXm60KUnbM6ntIR/w3pjcVZDLPMeVbBvNsC9y/x
juJbFP2s8D6wHHCdUzXvdGCzbV8vt8eWDRcFaIDR0BOZVneQA2mFTL+hjSb/US1L
E/eLVQKuzXtbRqCqir4lr1sfSI1EKtKN2BArBrgTk+9hxSndHuM1Vo2kLdyaAxLj
oiVQ29wtamG+IrJwezep6kxGXeEKkSfBaUmosYSFh/4HiF5qLJQl7hTZ+319NqwX
hahfz1I70Prf5zM4mIDnLEFytGOhJ4+VuSFaLrdx6UbaPd1pelBJB0Oqll8OL0uI
0uBd9n/lTbT0GdXz0woyNcLtEqFqUEe5L7oO4RZjNKRpA5wRPYF3MpkMJGiS3P5W
HHEHw08gsP8144oZ+vyJiWlOIJQCvGHW37NhTgGXcBQuLUm4zdsZmWznc3HkETso
0N5YfpK93dqDRiuha4VfLDl0yBLQhmozsy9mz/ruUG5nF49HFb94Of0bs5EVN7Vr
Vy/7yPX4IWgvxE8JNNFIR9JkPDfCpQ7uTDd5GsgNa3VEZ60fWqOUDWxHq1UYockR
e31kmcLgif0DPGuDs0KZYuL/SfKBKzksmiIGC82tJUdDz8k4IqM/qp00cPjvQxdD

//pragma protect end_data_block
//pragma protect digest_block
oi8re3r0LQ4pXDuSRKDywV1xqk0=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_reg_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_reg_transaction)
  `svt_data_member_end(svt_axi_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_reg_transaction)      
`endif   
endclass



//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
n8eXkN9x0i3Kf04q075OmEPaJ1HXCrS/MtGVMsM30BvF+34+tDBbfPzovgXC35FO
U/FSMqapGZIOPO86oRnlmeLOWq77t+J4jPwdMrL1ykm4jNJnBPeA3+pwQiT7Br3b
flChj7Q260C/eeXQRbRRWwol9hZZx3/VOcQYYFcvuaNpAr6gFg410w==
//pragma protect end_key_block
//pragma protect digest_block
aQ9C9rA83surHrjNjif3kuMTxNM=
//pragma protect end_digest_block
//pragma protect data_block
TLtoq8ACGRENcV1LaUPkGdFTxaSPXkx7KGGPgQ0UoDl/tFGy0VphDXv26HDoL8Qn
XkWr6XMOkjHNRLw3BeK7t3mVbUDNf7rPaJ2H1kCsx6N8NgEAJ1TqvZpFjQ4JmU4u
AXEWdf2SblW306ItTwF7RIK7D3gbtSwTVbt8Ne2GLyfjUqKBreX+bOfpvI3FfEyj
Uv0jOfS9Gh9+v3ptuyzB/fNR5F/jK/CsefnP5GsiKKoHJa7uTTsI2gSAuIJFS9DZ
tDeT+DTEZPBgmVueUzCsg47Pea5UGKv+BXrRMqKjNjPtCQRCf5nZsvXcL83X3ecv
ccwmPrMcao1AqfD1O0g5PJC2YBCVCeude3JbXwknW4RNkKNmfgj+A5GVse3yk5XV
nyxd9aXTF4rS7sOdSkNCelpeJ8nZr4ghhQLhalx2OlbM6h72x3ATnZPjJIEHzIRD
9OJcxnNwNEIFRcdGX5FdN1hX7qS0StcY9zqwQCzI2lD1RfuCw+ZabbbP+JKqpOym
Tgq41eMmtNgkSRIYUj6+4A6cZtIS/QgNUaszJPKnSRIxkZHHwvSI+QscgH/NgI2X
OqVSHid09igB9M6O+JQndsMeelhyMJs3xOtQht/X0pXpytzopamaQNyU7eg053/0
hwyPCvZABrY/PbOm6KYpdBGVyeusiPpAHVgXhFSjQHFQfC0Vw3gwwKDdQjFvFn8z
xOka5/pkzxO/dqbQiVMEnyc+9hiRsU04pg/tIFPc3Kob4i0mazfDjZdee2t3+aBC
uQbs886KAXFx/8BUK1BWwPRSw4obHAIpdcbfmLnTbnt0S/NUHDzEbPwqq5uARNkK
FDRm8ucNzk0j48SQDsg2xPARv0/Ktvmfy3uis994BnrBp5IlO0RLqOAu2TA/hpk8
NeJpQNwgqPRgU9You1IepBqKv58SztskJwwVR9XGpbxeIDMqbgBOrKiDq6bLUbmV
5UqaQ2kSASONQ2bs5eUMaEGoaCKgw+zYQnAmPc+T+HjUYWDo5RIaivORUDJSyL3n
o0skB4sDBUBeD6cNTSf6HW3R36VwBP/xPpwe922Fh91ZK6VSKxfj9hnt9QglDSmG
Fd49zjG3O1ytQlMX6j6K5CSZmb9kVIDqOG9dFjiJHNJmEhx+RZLC4273kiX4VK5a
lL7tV68j+0nLIQRwiNTscBkkItS9z31ea1V4dxfYVJTJyF95aXu+GmgGKy6dN7ey
4dVWk1E4Z+R/9C7FAnBMX8SUyUvQwlHzhKF0z/Bo5ZfRl3wcJQ91I9UOqECGzD9P
22ZYOzsxeqqiybkfxmCZtUkzZ5HtcPJhlHPqjeucLXXQl/bm7VDEqTyqezSVkLAo
y1Zge5G3SFNvEdk4sO1MUSdXtSBb39xuwWAdhph5tkX+1ujNNcDgsKK9X2xNv/Fl

//pragma protect end_data_block
//pragma protect digest_block
k9DmmvFRXVP+jIbgD82ntW/FUBI=
//pragma protect end_digest_block
//pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
