
`ifndef GUARD_SVT_APB_COMMON_SV
`define GUARD_SVT_APB_COMMON_SV

`include "svt_apb_defines.svi"
typedef class svt_apb_checker;

class svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port makes observed tranactions available to the user */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_tlm_analysis_port#(svt_apb_transaction) item_observed_port;
`else
  `SVT_XVM(analysis_port)#(svt_apb_transaction) item_observed_port;
  svt_event_pool event_pool;
`endif

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
 svt_apb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

/** @cond PRIVATE */
 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Indicates that the request was driven and the master is waiting for the
   * slave response;
   */
  protected event access_phase_started;

  /**
   * Indicates that the slave has responsed and the current transaction transfer
   * is complete;
   */
  protected event access_phase_ended;

  /** Event that is triggered when the posedge of pclk is detected */
  protected event clock_edge_detected;

  /**
   * Flag that indicates that a reset condition is currently asserted.
   */
  protected bit reset_active = 0;

  /**
   * Flag that indicates that at least one reset event has been observed.
   */
  protected bit first_reset_observed = 0;
  /**
   * This flag is set to 1'b1 at reset assertion.
   */
  protected bit is_reset = 1'b1;
/** @endcond */

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter used for messaging using the common report object
   */
  extern function new (`SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /** Initializes master I/F output signals to 0 at 0 simulation time */
  extern virtual task async_init_signals();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Process the new transaction */
  extern virtual task drive_xact(svt_apb_transaction xact);

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

  /** Process the state transitions */
  extern virtual task update_state( svt_apb_transaction xact, 
                                    svt_apb_transaction::xact_state_enum next_state, 
                                    bit protocol_checks_enable,
                                    bit apb3_enable
                                  );
endclass

//----------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gvVELFbSU41A2bj0nY8cOTRdj1p1kuifREkmq3P3X1K4O1Z5/Lt1Mo/EtQ/742RV
Aud391WZvby4w/FJxAVn3VjwIVDOLzkpyF/FoAt18xpF4PHEFrvR2ktaDLR4DWHO
4Vw4IbBOF0TXUo42pZHZx9PDAgrp7qcgjQMSlr326m0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 332       )
1XSIfqqHIQO0EMZkRnSDPLR8qoXM4iDxZ3joFOwGNPJhuPauIxCspeXN0fLpQ4xs
BJsQKJa/0AKiloaPwQJsGsFYghuRFwt1aMwNfWGU85F14sN2lBngAqcWAgWWnWTU
l4zPHN8zm26n6R8um887vYB27C1A8UiGdzKY6qDf/63bVEUc6qz3i4fyzKoeKYT2
b/tC58wYO8oDGkVDPCc1HihvPHo0lqQWafRw42Tgx+FUvqtiCerpRjNnN/QkM48B
0uPvBrUgYToPc5m0sRnTQIbUbIkZ0aMzJGCu1TDJR/laUnVOv+pN4HsKlhl3sWTp
Pskg2j1IcskQZlCNdhhY6k9Oi1W+VRXgHBRskt9dAchEdhJhXF5hzaMMunX/wac1
xppjXbmeMxdWz09+1XCooC/CWZfredMz9/CHrg4T1v9UNCJfurCLjktS6+vXtYIb
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oQLD95Rpj2mTLoOiCYcTQTUQVRfUyMA4rrRPeCGFI9VSWVwI+M1SA7NRVJXZMMM1
KuV8u4UQbzz4ht8pwup0gsKFGyEwQ8p0EwfMjP0O2owdgN6e8caSzK24NoGbTYAn
F4w8iNyfkn2Wcgey5c+6WesxJT0aNw4BTBkaVv9V8Ko=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4266      )
ZnaGyMKbq2hTxMuTPCsYqmMCAxkZBvoLJvC62R44ZiBDJItnugMdKNcqtmdHbXPM
z0Cs3DGPDytFQsCj3xoxWeTkyTd51YcHChKTKRRqaElTZO2tyLRR/Q0/hjgju3ov
QCJ3HFfCX13hgEtZlnHGUgmplt4nfyuwyvLZUm9kUzOovgAMEwKLFMYgxUtpakup
Wj+g8Bhg05dDrcPETE+2gO4tiZAMSrOa1rz+JjEDsupxZv8aI5GjnmkMCe70LSLy
t83DzvRVd93jhxBugOK/7ZnXNDCKLrVNcWocQ76UWSib/wrBZACuIdPjF0aDqg0g
PSPknz2wz72mHGa1Kit6WHb24xpFQimgS/wVkM13nCIclzccN+1hwLNt6UO+hGtJ
MsNSCWzp5j6A7uCSUMoOCadF52IXjVp9KRpPdu2RNvuye8k3rHSE4KX839VDipDP
O371IYsBtNDGFXQ7oAcoDsCT27UAtWrSubM5RSszCfKP+y1zemKkD5CwQenIdQo8
Ym4KUHCAl775YUBlK/kqJfMxohSv/kRUiB5pa+RsmIlhL5gKS2yc+DWERXCyV6dS
lxS2nBt2bTbEZLDNyhm4O6yu1TAptinBByjeGexS11wkPx4iuB4YSrpbIPelhbJV
OjrkfyvXyWAM5hACuhm4iznlvV9CnzYaep3jqt7/7X0ahS2VQQ8JvUz9dP/COtIc
Up2YXidgQy0Vtzx4eZFBtulNikoya7zkad+mYszsdKkhtN6yrwU52xBFbQyOwkpT
nikzNIwPkDihoVCv487hl7stuOydcg1hu1XQyXwjkijhZSR9xPE/mvWJqeW09Ah3
pSMJlA2eLv2sXXGQdF39JaHXsYonXI/UD7zQuA3sTx/i/kPStPKLqQ/mCHbNuR9K
e8a+k3c+umwnMgZTiaWqeH7v2bH488bLNk0D3nzD63B/mv7Gg/YHaHiw2AaMtlUf
FGfX7sGhLo1nPSQ0GktJ+fIH8ltj0gPLRzDuGwSXzwNx+bj7pDr61X9tSxmptW5j
Lu7MNNdni0dM1O795UyH383xGfDC+snmh0YbGa4VUrFUe0lv+k//JdYjZxtzgVj4
SYinZowmuylLm0kNs8tlFSK3C7fBI+WurjpnR2ynH1qfQLAo0NaWiOaH/BCiEIPA
OT7C2LnJUpLWl0HNkr71ThCj4e1c82tJbCPduqx7rtUxb7eixyl5zTr2Phxp7gQc
QXaIWaTDGwUtd0T9hWm2uCk0FrC5uh+kanadXwj3DLEVOjOq+vK/6X1YB3e5ZQZ9
ff6NMokUG/7ZEBYBCcexYdM9khrv2bkwDVsRc4AQSNmmhhpCjAJQyx8SLOL4uII3
Jp6wxJiY8/uLjEbn1jVE5al/c5IbKSJy8ysh4+epx4x9Xr+O66rg+4JrWb3S/KAr
mBXsRAScQdjWMgTzdeM1fbasGbY4DMTJXeJYZ5YKP5CSeyQtjHoElTc4DPSz38bl
LwMEoW+ySkhekryf4XalR23xUCYh8g2XgYnSMGzRBuYPtl58w1cW1lphyZ7cLkVr
prTX6DJ1i1jKUPqKcuLmf8+GPF7nvxEt5n3V0Bw5DZfm/JL3CVdOSK4zPH0fdR42
FrHVfEPkSsi5qIq/w24Fk7yU6+NibUsXX6tkruiA7jdHJgRa3bSwYTNxKz6bGV2C
3RiJFDJOOORNiG9WiSLxwWqXi5HZhfJOYCe4h9lHyNSP4/OhWj05jPb60Be5PeZf
CRi3Use1AcnUYvj14MG+fJxxHE2Uugyy87VCd8E6XwNs38AtyjxySY5NrAsyUAYA
YrXiEOurhZicE3XxUzxRomNHsM8jR7YBDfHBS4W+H6UejgwuTMMUjwqVrqYy54Hp
eSo7YaEKDuX3Y/5vw3bpOquQGqRCOmUfl2LBBaR385eMohdyU1Yy25MIoRU1aWem
aFdnp5wRotQDwLvnDK3zdKbqCqK83Ls88K/G0t9oBczwEqRZZSO/uUZy4uAgZc/m
lIohIT5i/aVSCthE0TS/D5DY+Sgv4I0PpQX9K3/c8HLjgGhO3NWENnqZNkB2D82D
/Ml+vJOAVSIRrRy0KiVnSEpTmdRIPJzQuJH1D0cmEiwwwgewovDaW8E3j5sU/Xmj
UoOW2+M2+1c+1lQQvwdLpVIXnGDK+6/cDLP82Ga21Xf3M5iekqx9xHBPA9s+IDZn
LxQ7rMR09OC6AFJHXOQkW8LKPclzOtQM2O0T8giJAZ4T+Ivr+MpWfLwBPg0ll4g7
Mq5uk4oWr2KzvMH5uFr/1WvCOjKFNeH/V3DPrze2DgGiCBewDpG5ljqm+xTCQ7NQ
ESvwLLwaqQKOp+ROQfrDy4LWz7ECHSYPdOiT08wdUFZq4U0Y+DSpuld37WQ3jUeH
xvpPJM49elK52xgzDM69/UTdaDqwFWGJ+3m0ed8Eg5MBsQKptyaUyfZCF7f3HaxU
08DO/r43C6sq7YiGY5qHFiSm7TtzxUGKdWsa+46NmDtWQRySUkAZeJca8LPCjU/S
eZdb1uQCqtvMh5VJnHguEGKtuASe2VQciJYzGs1yGsw0IiyQ37X4O/6oSUvXHCLT
Mhi0zI5gW5f++nxAWRm6hvNWj4bErLAI8YktUgtLGh5c4+XteoL8166mFbjVBKXp
s3LAT+q2g3sKuXlVLMEi6GG5FgDg9o65FspC/uED8ZSkXcuKvSChmZxC+bFOyP+/
DIYlMB4NhgMxna/SW2MXiVwXLSvs7TuDvqESMDlAtfT/CiVjtFcdQtuJ7+8UO534
fa6bWGwAiICZvjIoq6Ljb3X8YuGethwG6gelowECJeRGLZZhKXWmV4jbXq/ZuXvk
mEaCysn9B7oyXRUrCdAwtR08VBpJHy8LIyp/gdhuUUMPIIshnT6m+E2e6TDR/QBw
50QjcCB/UO40tfKSjufmpmFuPnFrjyOJfyCjSf9rrc3oMF8RehTE+66cG42an7Fs
Hierly6Ufua5LHF4bx10+Z09yz7iSA0nruTlXLtyIHpHyt08Zoq9Jz/Pd59HQsn/
cuz0qgZLaBtM1JIfCDB6FKmc8jTDqVIpPLFWgoVqnUwJIIBsmxW9VXeA4I0KgWlz
dEWiq4oEv5JaJPbDYMkxzVY+bZogA5NZm/M//1WAHfoN/IQnaGugTk4nIRihbNJ/
mk1Of61Riqm0X/w7p50vhVmbpHbhabYnq9P/Q1YC0WEQHHrw/n3Q90wIpvaKNGBT
ZQr1vwGKO2VzjCmdrfN34YzdKTIDHiRXMkxBJhuKPiZwjsonpdIzZSTm9njOhSPT
NPKn6qGyrjfJBSBZdrjei6MbZXlKkpYKT9QureLxho26GJL34s+Q5xH0a9rPaR1O
J9TWterjTrXJ7as8p0MEu/UgMXF7RRncusxuyc0pUeJTZT3Jr96/XC01F+cX8np2
RGbTzI6sAh2Jtl2LVetCk1WeDHK+zGXzj/v5jsduNe7l1nY2YIxjoygYfS/K8av1
mEbMd4/DuEt7kOHQI4QgT7GrW3Zlvs0tJ57EcpEVQyGL49/YNdq0C81M68PumWyL
WByRP33jUaqHG8AzCfQAPa/0EQeA1OGyDH1DeMx8MVseR0btXJ6yxDqm+C/NqVEV
gRkw/OB7GL3LZQ2t+mkH1LHOFZBTAPpwbnQL93cxT0AefKYivYwhs+lewsEUlD7w
7e+aZx4zh2LB3DxssumhDu+/xVtOt59WJiYzhP+Pf8lB8xbPVO15oNpEeHjVmOjh
sukHMRZnnEU2qn3+ziIUcCkNUbu8gMUA2I+bdvSNY1HQ5FyVRB9BIwNVM4KYl010
laPqipkEYMyEs7rX4FtSWcH+YSJsTZhN+uhpoAJN7QGeynF8fZFbq24lUEIx9WvJ
5+GodfqzxuV9KI8ltrdXSaCRHHdnIoxC/vrEh1qJ4654YGDkxpFa1DIDRDEHMo0U
VFtkMM97CnrOWQisqvQuSiLmmc2hk+ctaQ4QmVLXAbd9YJEdWDO0OI8gcMhQqaHF
R6mNeEy/CN63+0M/d5IHXng8oOrOfx9A5Xlv851/6KCMmbvpXH6tgzU0KDzy9+Uu
QeGem1qD8eyuX7jCgxMRpj7k0FhO6FMq8NvZM79AZTlJIwlwRfHl2eArnLNfHcm1
p9d+9porNZiQ4DY/9J/s3DMQ9U0L/vvpkNcXm9isMDiiHRjyrTEUAncRpS8u+aFg
6l84Yftk5QFVUpoWlCwOIHy0qdTdx0Bdj+ForbJCLzCn6YLCkCM2XbO5RwUDAhqO
Bv5NZTncad6FAVf+EUZtKYgybWpFPOXYGSxcjK0la8he2RFKo9N95SHniADtzPSP
Rz9F6jMNEjEvL1h5yofNPnrWNRhS0PVFeF27SvXaU6dkVTlrfbE35NMs5QU6oz/5
Wfjpq79eG7unuIAomt/8uZjge0kQu3SdLMwTASV4FTXAfg/l0Z0Snx9YZDxVyfNs
YeY1ie8qZ6aXto5ZHWBh7s4DN3VtFfSRtyq/93LyR9IMcpeTlQib3Shhbqex+mOj
GfDZ1nYhqyQ/TOdbDXPzW5fNizTBOp58C/3Kg2XPFVAnjZrdDvgweK7itEDnpI2j
xGxDtIUt8slw4WNE0QN54xZu7zkRfmdUJhfTnQsQyWFjmOculJgsjPSnws+8z+9f
KKnnyNRAXviyltAFu3VwUYx3JRoo76PHyb3eVCoejih/4tAULNBHRYRoPN8NX2jf
5o7T9Gi3C3GI+HDqJrkZvFfYOzurESuG6wVwGsmH0Eq/EdQXWpaZ8Lq+Rw7aelqR
8igV/YnP0CQuI28abksOXVuMnauXE5QDa8thErl3EciZo1AvrZxtaBoUifHpUc0T
/8jY44Q8Bl/At76vGF8aJv9dp0z8fXaxLUGKqveO1qAq94qsW4HZaAfF56uPAlWw
5iY4juj8FpWaiCFPv/KTFhSVCiQnPkJrwMGzukrJUQR1lqnu+gZAOmTM/rElpMFW
QkWcl1b9w0bAnVVCGqlddZ8ZTeZIWOrn5USYWyWEyZWvdpj2Sj6rm8OgZypThsPR
8Rhy93N0hNvyCNb1oz6cYHlrYUiYMsFKa+bTg2EZP/WdFSwGsFAUmqmxKCuLUQlT
ZqpAVYt3Zwpb9bRB3Ubm2MdFP9eC6nFHqMcQ9PWpDG3QL1xW6/tDO+zxuF+p1bjR
dwwqRK9qiqrDMsvIt9Zo6pVncw5I/BNsTbyTtfsQCd8bS48RsU0O2teKizVFtHkg
SrA5nDmxJ7R1KzsWPlBCAmCr4ahWoRK9O5QV4BIvq51cl7ixFFcWdLvYkwaqa0Jl
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
m8nRDebn/iTaSAk8dlB4vNfgqHW9qZEQKJ00FTCUlHw0uqo+YSEDBcRBXE2NKaJf
buOa7DiOKaJLARyfIRYue3oePeaKUoRRMgsR5lF1lAE8UrgkuPZJcfQUcSGvFFow
G2iLB2bHCxYsVH5itLZoQH2ElNzE2Xn2LBlYtuBK4+o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4349      )
KbSusaK6gqQ9bnvEbaIJp1lIro28g7SflFxwG0J53wjbrku8sWrDooY3avmg5SwI
tqp19Rpbo+9idqPfeLttvxF9crJzGD5io8uHHRzoetEraIeIWYCPLqgG2WZz/F5Y
`pragma protect end_protected
