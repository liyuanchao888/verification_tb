
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zIn/HQzYJcnPrCUFn5GX+05kvjmF1VYLeyG6QZ6PjapvAxuL5YGvzDiu9DR8+lof
Ky5BCC/l9QuCHlU6jE+ja0pgk0heSyYV/qGknw8xuTzzGbuUWfu9ZCoJTZaiCFcB
zk4tAQbIGeZrRtWr3DXyJhopBc5w+vstRiojySb8wQER7Mb3PDx7lw==
//pragma protect end_key_block
//pragma protect digest_block
qk0axyEM7I1yi08cXDj99l88Z/s=
//pragma protect end_digest_block
//pragma protect data_block
DaaxCQJZnxxyiv5M0P5IIXwoGECeOnxqgU3IzJiPZS5UErgbu8vNOeajGdWwS25d
+q+lO5iQuXa8W25LjIubMfc3T1l50xBS/eOaOkLYxOKjuL2z2AhxejRmQ/1TjsNk
6z0TbUl7sDcqq6N1xtj8GVIPrEKOQ3J7dfVs0w+hUfc8cLRfNDG33BSLvxzu6FBD
E74J0HfvuT/iNMkpe3tbVBAWIqVYiJPr0VzFQyKvNXLMidtDE2i13tYNtbMkx/j/
rPswa+0M/Xll7RGMW/roUL0U4Q+xMr/RzXXD34RkanndwJlfb9uzxyQHSDb4498H
Dc7l/tOsgYVeoZJWG7tCIHHOr/Yr1Ex3CECpSIvCkCJ+gCZSkfVXqL1Uwf9DT8C4
knd6WB+cLbsWRDJZsKYakPRK9540hCMg1DLNx+jPXS0Y9WoXb4ZMHlvhnJevAlpn
hJfotiyaEgiSl4E16kw6DK4/wO6rwayRbhVpyRAbIam8OgJeOetuzAk/cswScuhc
k5Z1bPoiYfXGPBGqdTJtj8I1b/3Vztwq32zqxUAvogM92VjkcO1vJoQIV3S81p68
s2C6b5S/X1U4ziBVoJTc78ev35LCTBAc6frKX2YmZp4ni29U6M1N/nP2Fer3FoHt
8sPhPS/pZCO24IxGCYDR6Nff7/KhKC0wUTcJsjkrMOZc8WHpP8rP4mzmZRyBxVrD
V7613Da+WzuAFaNgK4VtEpQETmjjhbXjfEJniKeT6og=
//pragma protect end_data_block
//pragma protect digest_block
PmIB8BwDAxMQr8u6rK9PpWQcDcE=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NAfgANsA/p5MEPfAxGBD5uTQ+EKF1gVZF6dHL2es5e1lLCGnPdKhwVMCBFN+J6qL
YtLW4deqlWT+fsd1QpL1Hy6tll7D8S4eXUPG+JJ8YgNl6tDRW5p+1nzYZGfFXuNA
e/IYa1hTPVlX3KY+7yuiPHItHSHG3ly8SIAGUJN8tSP6ORtU+4WyDw==
//pragma protect end_key_block
//pragma protect digest_block
Gi+rA+U/uRIwOC1yYd0Ll7F0s0A=
//pragma protect end_digest_block
//pragma protect data_block
IbHViNLVz0753hOLBoEMZ3DSHLMWoSO/FSRSbd3GJUP/r7DCSm7d5nHiG1jhUmAv
jYis/z7C7Os0dote65tRPD8NTknRlItb3VS+kdGpHfF+lBcbscBGGBPsx2qKkZXk
BZifZ/OnKhPpimZegogHFpOlCKg0YCkZaXAPk437GBUVUeMbQCc8cLg0xgyHkb9T
h6drwfLEBWx2jQBDL4puGpEBIvO10pNN6jmjxQhh2nxT1RYW/obVIvWcWI6gaPbA
6SAvJ+YJc6hpwHR12N1RnfbYWRt0UUV2trzxjQean9XRBlY5k88EIw6K61/6PDC7
70uzLI4o5fxKPVmUjL27p8EXRx16LNCnLFcc1jkOp7AYmIg6De+lSGlqrH+3/Ofi
1J/nxsKypUkH3u1fzVT7vC+UGIZjM9JHQrYaIJ0GeIHWWy/JHYhZ/4bwxd2euuZO
Fs4EwIqsjx/qm+C6rTbYEZWGUNNfvYMBw/i8EnW0AuGzhEuND5TFhtcOT97tfmNm

//pragma protect end_data_block
//pragma protect digest_block
unhdFY52SBvBrUXpYGvbz9G/hOc=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of ARBITER components */
  protected svt_ahb_arbiter_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_bus_configuration cfg;

  /** Transaction counter */
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RaP93Pk4ugPvxl/v9nTS5rOpR6KTvUBCpD+4qBBy5HpQz6OviAdJi7kDHhoID8dT
5BJsvX4RNJHMfS340YGY/kOBONzWzoFy2enXAljzdmRTInF0RWx8k1Eonz9Aj5s7
amjHlQR40n2yUUR1A9bQPCBWLuaQujWpcCstnV1lqcRWlnhJ3KDWnQ==
//pragma protect end_key_block
//pragma protect digest_block
Zhf69ixVFflZKbpC2qsMLP30s4w=
//pragma protect end_digest_block
//pragma protect data_block
aol082ceI35P7ur7HVHvvLrVydpNxZpjiZIZwYgSY/aSphrN4JwqtgldxW4OeRGM
41Hz9f9wJ8rz8pt6DPmX9WdBJ8zZ8F2AZIeb7Ra3lWi85Z5RHyPz9kpHWsusHq9m
pRAtVDhfYP8FsJsLdSvEDIHGsHy/jyf00ETxRlo6hvP5UQ6J/bMN/XASXH8bMldc
BqfEWkIRADalOeqZWWmordz34syXFmSfN/RTZyC70LsW5g3X3bSvjhOjzLn1oH49
MHotcZ6e38ZS3sBYvM6Fp8gWJyCYxkyZ7IPoJFcx9fAVzDdzjb4Y4+wuiLXl1EDQ
28C4tZQS935vFmTj0nOqZ+EzGrmZ2iPvU5/LynY5sPHvlj53j19It2qTNry0FRqm
z7IxYAxskrsplXpmgoJXxuwNBfLCJAxwWHz7quQ2ULUrzvA8Zrz3fOe5GhTfz/5N

//pragma protect end_data_block
//pragma protect digest_block
u7k0OoPaUw2QZCFBd23mCViPZXE=
//pragma protect end_digest_block
//pragma protect end_protected
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_arbiter)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------


  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_arbiter_common common);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
inL6eJ9m/lNYa+T1Miwmhmzp8WE4kEXiuV3JWcEjvn+NwO2LE4jZv3DscabrVChC
FWsW4JTzKIeAYc0fMvQ0eBTFImGpuYlwamqOddqpdpXlQuUq7RNK5/mxuJ9cQKGl
D2r1USmaILVzteKnpsfsNuWL7RmCpReK59ovMlhk5VpLpJ727g3n0Q==
//pragma protect end_key_block
//pragma protect digest_block
LABglLexN6zus8N0+YDMjsLy+lM=
//pragma protect end_digest_block
//pragma protect data_block
0FIXzMrYZQnMVHUhxm062zlqkIMkkqAl/tULyGORQai/voPkprH8i+uT1uHBlNiR
odNNyDa8342WuPDtZmg2EwvXkcG6kNyCM5PtSO48/oZIc74zxz7yi4i7U5N6RS/5
C7wqbWWvMVJBOYpaDe1cBRB1XCSvF6Hm42slx38YxBnbKYRV1DLbbcvI4XwIn1HG
7WT+95qvxDcKb7VtYTQQVWq1IUHiSQv7o/RtBOCGcTfdjdWdHykxWf1I7zjeh82m
A1WagPazhwhFVBPJYb6w2lkWtbVoH4XYAXWzN1JuVsWyNAsDb3qiLAPH38/nL35z
g+Rw/lTzyoXq+EAubwnrcAdyVCDlyhUPSz9VONfm5xP15mlzmIYsYSiItfHHYUei

//pragma protect end_data_block
//pragma protect digest_block
25I2cLqT4sv5xs9fTDRec/it+F8=
//pragma protect end_digest_block
//pragma protect end_protected

/** @endcond */

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F1qNO/mFpIbNSfSFd1FAAa9/aiXzXdYogmxGvcwrKuFaNhPzBHnLtn/Fj42BDZZA
iYlBGas3+vLTK3rnsBxZfVW+GohdktQNSO19oABregD6hCi8ShaS8shSStpnkb4z
UgghYQGHIl+gIfOyn6jNwDUh/oXfQljou6f+ncRz+lvWqomvcDVBcQ==
//pragma protect end_key_block
//pragma protect digest_block
u2tkHemS4BvhI6CXwCEGSP35Ecc=
//pragma protect end_digest_block
//pragma protect data_block
VCC2QeCosk+aIuN01jcrAiWcZgRToe1S+FLCEFV94kXsmn9t4F+PzINTJlOb09s3
+K8brPC6ZpsnJsUluZlhfu0z3h8QIBOb9D+GfCPpt02rSoi9ilWEjfvYThJi8KH1
ykFlSQaNS17HIrSjlGw/E8U4r4x32VtXdZrXprUjugDusfbCLX0IuW6S3MC3GA4D
wf/mbex0HZzu45d76qigq+/98WK8izd1Jl25OngIPnf9Ku5QcYYozGKrUENcQ4X7
3q1GWjfUnVnWKTCqjfEGca6OxO+eaj+JjMQks8C7kXVI7i24gAlf9d6ihc20BGku
X3QpTxjpUHZjiNLgisMEzlx39PYDzupu/AnZLE1BbCet6hhTgNs2WyzP1H6eanhP
T2Jo54gvNKiyGgNk83m+h32LsHdMcKQ+dezIsN3I2IXrw6N1jpoJyDLCzKJ39aJD
M2c2AHUvZh0sh9kN4KnGkK5D7rjsVy+WFPbJualgrc+cds4oQU4Hh6U0YFGfnnBr
E6QE+n0yxjoccr4djBI7JWwFhgsP/fcc8U2BBkMDZeKaCLFdf8YPkcUhEzfdmrlT
BDpNJ0v4GD/w66B7fYFnLUUqbArGV9t5I3tMemMm63IPRsXGbRd6L+u9zsI+JHK5
4X6dz4FRYSXHe2L4CmYLbJ7wxU9YUb8fFCb92tiF2+Y0E2sls/HWOW8XmnLCKgAr
sPhSoJIZfjRNzMZdQnM/U+nb5zEK1wnevUu2Fa79jPDG9fomU+AnJSezuSv8WFJf
puPWHs66K1+8jXria0XUakL8MQXwls8j8NMqF3S96SyGCxdXM1oxCVFKKqAuae3l
bLtJRgVfjA7pGTHUiSb5Tw==
//pragma protect end_data_block
//pragma protect digest_block
2gwoDdIL950v7IUKgLl4dnYaYCM=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1Wq8QcmwBrzPVKP+gz0KljuXJ4F1/dSCRH/Q2SZ9ahHCvKDM8vdCoVraZp6uChwL
J1tR01Lhhq20bTtr3JKPX8BBYjV2HprtzG8+t8RaODONVuyC3cF83li8pXrZ1ww6
KH+dHggJd5mToMnvN+1Jvjx5PQPVQBiXLkfuyw9BaHk3FpHYdSQOmw==
//pragma protect end_key_block
//pragma protect digest_block
/LYpDag3cvb8Z7EKNkWrpvynHrc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Ngit9kdUv9kXN2clhXXu0i07vLQ=
//pragma protect end_digest_block
//pragma protect end_protected
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KGRDajajtDQA+3Q8Cg0GuOuhtI06vBITVN13ov8GF8nzYQeZaaxLPLUQmzQoI7Jy
tdlI9slZIhytHHfaJjp2zFyWx9jkRtsxT/VZKb/xe8kcfBZzbpnY1Xj4PCdO4yd+
lKfGviRn5tlugLf+e597lEcYnhzG864iCmdBFdh5gmHyXXh/HKwF8Q==
//pragma protect end_key_block
//pragma protect digest_block
A3+jPa3CeeFIqxlIBtKgKby8vGs=
//pragma protect end_digest_block
//pragma protect data_block
t+/N+u7dpSGjJm7JjZ4WKyy9YbQVD1JE/0fIhwR1JfBqb3vXAEcqR2BA1gCxH1dn
cVwj7cOYso8eDc6RzhRK793exPLBNicRw7xBV0Ssi+8Q4WzD8YIjfN7Dp7aU+kFx
bBd+8f95efB400oSSpb8ZQElJOVW/IhDXzGMYz0G7n7CaKpDnSaefRE8piUfShVN
qPfiHmwh8SEfagT3QlXOY7EeLOZuuzg+As/EUM2NMThJBVKig8q1emIa5LXZiVTK
ytaj3Sp2sOXK1GeG7hhHog67V7eH7WikWzZQb1FYDPistrVjQ1iuWkU9r0E4ECvR
v44jqj1ryceJ7TjvVyNNGxZC0LFuhJVIfk60Ar1jk7A3748olN0aWPHwZQrn7n/E
eugqrjCRaH8HQ+9IsYlgMw==
//pragma protect end_data_block
//pragma protect digest_block
ff4DTWeTZ4FGqC4uns0C2iOlVFk=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kjQl0gMTnaivuPmqIhPR7aYEk49ywuiT/7sx3HQQR3dhlJ0LXnaGFEpkNdKepzHh
PHgEqWrkWwhZK4E8sLKmHYIIYPNWemFh0xq0sN8XPclwvFbuR32PUYTg5BS7lOO2
ebYy6bMV9GbzZhpYHDfOXnUPaZP5JXavh5BPA+dqjjpPNyolBRlfCg==
//pragma protect end_key_block
//pragma protect digest_block
LycNkyQBCWE1xNgcY9R0PCjcS9Q=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
S7Dpi9JntcI+wMgX6EpQDGPVKlY=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Q1eMER8raHP/yNECfk3mETrQ6HyfKnsksXHJj2xHPadrv2WdmMSWYPjfwQrR+Q3j
P7VhW6CnAY21m9xeJPtGGmY6x7OB56pdfZVnfxxcwfW0CFEB1Sn3qG5uoqIYIMFz
aWwx/MvkXP8/1MkLDYbY2TNLyFln7cka27n9Wqv5AbKU3zsglns3QQ==
//pragma protect end_key_block
//pragma protect digest_block
SmUfLNJHN59guzwZtODVg/Nnf5g=
//pragma protect end_digest_block
//pragma protect data_block
qK+2wJRsa1g/n0VatoRbvyAUJ2zjqO5yM8Yy/OKE49B2Q6bDPpBSg4fYcA+aM2wo
iE9uHv8nYb023XoHtDi6GOZ0YQabSElOTYaU0tui5St5sgv28zkA6nkP/CByMEGx
TFInp24GAP2i/SDk0RV+cmU5pqAdA2EhTw3l1Zlry8A/JQYUTdKh2Cnz3BETMWou
aMyjD3DJr2jF1toAzkoiZeyT3iRg5FqunwKssg5+msupVLTDxly/iaRH53ccM/BJ
5/ymfRj4iBCo/akir06w1epiBF/xeHFeBevWlIVMXoEmNxm80+L2RfDDuHcew9AG
Oz19C/FkvrjzOop6kTsj/JOMUbzp4bYOn8TW0Ir8zsYaMauybCORX9AppFmrBeCK
voB757jQvTbG8/m8qgBjwQ==
//pragma protect end_data_block
//pragma protect digest_block
iVi4ocFekvi3yTIstMLA+Hi4dLM=
//pragma protect end_digest_block
//pragma protect end_protected



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BvVxCyVXCAY3n+eQv97DoUNLULX06tCyCEWfQzTJtgYnSkpHxnKb1oADRbABuaO3
L6kg70mpL4rJkFQaChLedtpl6JdRhbfpVv6/Zj9/sP8oNPOgA9BVNo4KlkJzsyk0
E7dfdavNLIdgDej9SYpMDrq3S/VtH7ZlvwNaovYE6HOlL4R5kBksXw==
//pragma protect end_key_block
//pragma protect digest_block
OvXngj5L3C6dy/HRGBynbGB9pFI=
//pragma protect end_digest_block
//pragma protect data_block
+8THnW4MmBYDKiAweRxfriCZyHDIxTNCW6nG2vaqsgQba+0miDTjFNKitQBIlGGD
FhgjbCzCLwKin7w8NoH9El0RtUYkp1a9LXRxevqOOFFuwBTiGe67UYwlKWLN/gnv
kXhK9nu+LDdEwPYwAqpzpUo1h2CDj6R3HLPg0TUISO1k3rClrKRc4nT9xzdS1rzM
7dUflXlHjK+68Nz5x+4tCGClK8tLcBJ/TP+fh9/5+9Mfrye3MWCrnHIfDHZI9pr1
C0bYc7nupNPuWB4IjJg678OmTMGibaiENsDPmeSQdYJKajW7ruw0AEhKBHdMcseF
xhp15JryhUdruh7sb7+E6z8YBmJmQLd2kB2iHPx89V6C1/I6ciXr7a/Ui2ltjuMx
2+TqAJdMODb8OSfItOlfIuj5Fv+BOpNc3LlTJ27LCkdkdOIf9pzZSNsxWOguWH44
6pgxUqGTAWuFHw+/duDnyTDKeiJ2Poe1HrpFy/mwoNQffedlZYW1CHnKv5jCBuHa
CJQ3Bt69SyxEn4dazPWT5w==
//pragma protect end_data_block
//pragma protect digest_block
knM4qwSn1r7CwAzlhp7VSgvsrW0=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BvVxCyVXCAY3n+eQv97DoUNLULX06tCyCEWfQzTJtgYnSkpHxnKb1oADRbABuaO3
L6kg70mpL4rJkFQaChLedtpl6JdRhbfpVv6/Zj9/sP8oNPOgA9BVNo4KlkJzsyk0
E7dfdavNLIdgDej9SYpMDrq3S/VtH7ZlvwNaovYE6HOlL4R5kBksXw==
//pragma protect end_key_block
//pragma protect digest_block
OvXngj5L3C6dy/HRGBynbGB9pFI=
//pragma protect end_digest_block
//pragma protect data_block
b1J4gN/vF+mh3paFUW5YROuuoYzugZLHapMh1Byectb5qnd9W7zbg4xafFZK4KUR
EZXrejSpE2DAA1C3QgSNU+Fr56yQs7knmhImu1qEtQKOBEVJp14/0tYooNczhdkW
de/b1vncblVqAHN13IncvhKzzRtRoRWLYpCe9PS6YaNc9L3ongPYpYHGt2Gy33tX
WJktA2pFaqeSVoe7z8IU69i9ZMHBHX2aWAfw03pul7DqmmjejesDXmfTPHmCXOvG
5Uevsy5h3/BbP4UNX+KvHYWwq746q6rLxZ2ECjE/PIMcs6guWQfDLYho6jSa+INM
+YMwaUeQ9iIayK9FOMMdsEsFg5u2j+01pwpEKYGxq1du3z23BBsaLZgA7qBi5JMV
OIx7OzlFJIfu5Q1YLlx5XA==
//pragma protect end_data_block
//pragma protect digest_block
nFKBKd9QbmYOP2oqLGFTPqWOtiA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Zqtnwpc89oAjWtXJSrFK1DN2SkFevpAfAOUqdig/QYYeTRGS3hT7VnE9IraDFB8Z
zWC9gjSuRUGhK43QBZcxzmFBG0/Lb6UmILuH6sEXclwrSnxd/eoNvDkZ+ME5y3AB
agX0MfGNnVwXab1ue1Qp+47+hsIsbv9oPF9C7ilgZH5O0M+0eiDKNg==
//pragma protect end_key_block
//pragma protect digest_block
HEdafF8YZqsdJGE/uFN6r/XD42M=
//pragma protect end_digest_block
//pragma protect data_block
rR1Cwz71XL6EMDxkwMPDDs25CEDZeDCaeT3ZsoaCYBnKHqKfWP0MYf9E2FjMOHfj
FaiqIptquEZ7hg7Y09VUIzEpa1kL9CBfDUIaZJCUSKutlqmTfaNMiLMe1aqd033p
Ez6T5W6ZK8nL+0+QgaCM91TQlE5i2ED/QYO4nfHzyYO4/T+QNVOwnplcnCxdC7u3
mIqhcDuLPQndPzENN63snaHf21i7jmtDukCEsBOt2YFa6+4MnD7cNN8Sfkfq9abB
2PcEMRA7z3FrcSLWZqq+UzDTTXdGufV+RfD0MXTNIax/Wx3X+fce6CqkwniKPm6Q
KwjR1RgskMgrJUahhAPmBLPVma0WfzTeDWGXM+JrTNmsiT1H7MB82hjhoIb+GAB3
ffLxXlPQIC3jEN8xiDs5AQ==
//pragma protect end_data_block
//pragma protect digest_block
7eehtYm8RmOA0iXfAl6D3MZF8jo=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4IXqXsgA3nCTbqojAns0FBo0u4VdfF5gKKeEW1jt4wPaCP+fUeOtyZtrwCCfU4o8
ei/9yTZW4+PBsICaQwMUw9S+/XQFwcPKk2S/swgisZlRt7ygX7JJO6iViwOBPoeO
Y6H6ahSj77KVfnnHrywAcJTdny4Y1JWfbSeH7hPIm4t7UHl2Rizw+Q==
//pragma protect end_key_block
//pragma protect digest_block
D5nKnfMbyssyBr04xnoSvuIDLZk=
//pragma protect end_digest_block
//pragma protect data_block
hktAC1MMUP1ln/WSl8jnretcLmBuuyO7F23oLuW8VQPbYyg4oDp/lAyf8RvmqJes
bP75VRoFK+NktO/ueCkW3/SstU5dnjGTO7/NDdD48VG+sR4YzIXYcmwbQp4Ej6Uv
KJe9QROHS4PeTn8keaQQH+S3ieDSDlah9TUenq62kJ8kuX3/MOL/xoIq/2A68OnQ
4nQXOqUTB/9u18AuDLhZ1Eti0ggQIjA88tDVcUAsD9uxTYs1kK2qgO2XEGioopyT
UYXCMwOXitMEvINUJyp1USe1Ln28ff+bCwe+BNnG745rtIU6J/lEznCMIpbvGqj6
8kzywuqyWtPqrl19PZ9QDSlxoQflrLLi+OT7Wr7rmUhwWNyORmayH/Cq3hwG1+N9

//pragma protect end_data_block
//pragma protect digest_block
/WWzJycv8UHH/FBJmbmIdBs2ySs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





