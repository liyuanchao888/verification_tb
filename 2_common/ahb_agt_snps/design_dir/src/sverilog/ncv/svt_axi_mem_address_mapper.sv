
`ifndef GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_axi_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed AXI configuration if provided on the constructor */
  svt_axi_port_configuration cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_axi_mem_address_mapper class.
   *
   * @param size Size of the address range (must be set to the size of the address
   *   space for this component)
   *
   * @param cfg Configuration object associated with the component for this mapper.
   * 
   * @param log||reporter Used to report messages.
   *
   * @param name Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(size_t size, svt_axi_port_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_axi_port_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided AXI configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_axi_addr(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided AXI configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_dest_axi_addr(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] src_addr, int modes = 0);

endclass
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VzhRgn1g86g9oNEAMniNrlayOcwIg+RksEsvDeF3kIPH96xqPJpvmw0mpROeN4fq
iYsvxitTPzKaHP5zqa5ygdhzdlPoWRjsq3G+NaQpamUuJovcjkX8rNraddzhPYME
uMJTXrphodAGI+lg3xLZtxXc7MPabTQ066X40ak+6dQDFTFXy1PecQ==
//pragma protect end_key_block
//pragma protect digest_block
HP3ubHbWu+BLAgDH2I42F7qNMtE=
//pragma protect end_digest_block
//pragma protect data_block
Yn2NuUj+lUw0nXTz2/guw/F3dZ2T9uJ9Yr+HpRUAbQzRwKDh9okZEG11YkZGnIqh
+85m51DTVYGm8VgM88mvyxOVwooAvK/MI774GTfgdJOLHlKRYlB1KG1QaQvNE8wi
51SEZmqwohDQQyzPaAG3D3nGOLsq0K0O3Pj9+Rsetx6PuupNYZElLwDM4qtoZiEs
1pR1Xt/N2wjsuqpzOIQcBZ5UHrbLy650kgmOqHeGkQGfE/1/2arjqEay/RIkYfEq
Tpbgrbv2+4GpFruSLHggCR5dRsocxH1si85mgwhdPEoNF5v/+Y85k8uMbPl3BxkU
FjbH82wCHcX/4V+LU4OIv1w1ZSeZaYIjCp1DQOF2dpENwPINvBsRm57fF3au+rBW
tLi+9SCBbnrYze2SVg+z7GBiHghSviArrBdBUhq+rBjkG5MUNsSzwhbl67GXARgT
kFdRr1LdbV4lc0lFEo98HsxR4LMluqnQjg1mW9jxuYbtZq1wv2qBkeyrKoo8j6Ra
thk8pcd2Ex5PQJGrgN+ObnW+iez9EyEu6ghwb0i6OpvHmVOQ4UaojILiJUejhsJW
WVJnGDTLxzhwxL0jd1OuOATh7WQTO85TnwyFlK0Owzwz0sm2PhEQDvPf+ybN6jjc
CGhO6JjNINQC4sTqIa++TOgfQKUqXuO+epS7efQ1GtoxsX01SCmMeSGac49mXpvZ
UKD6NG9qp1zCY4hf/9McI1hroeOOhNUxmLLdbDUV1Gz7WEOxZR67U1voj7HNZ/Kn
rqltrg62bkUPHNTNcbBS/Yif/FQx8I7U+oUWiv81jm/7HekVkTYJJ0hTV2qfur71
1lk7OT94ONR7/PIxmFIWqMLMaz+WFu9ERhBfREElb2iHTgpliDgzl817ahi7LFhr
lMXjMFBHSvUiqU+KeY7qbclyK4jLGMIR8Esv08RN2+FA22X0WbNr7iJuVLVf5ChL
y9dqYdVk0sOvp6KX2eq2/jRpfrGhesWn/zZrwnB+HqMroDAF9FGe17yhCKD4QMEr
5+2LD6La04ZCqikQyYBha7ooJdCg3CJzFo5+rgmsmI8HuARPX7BYSnNX38jP3INL
mo1R4cCoURP8DgJLnX7sEGl+yus/2oa5lcyKzbJw3O899TVVMWYv7CyDI8FVCFQI
5t4V+bhZOLj3NVvcdI1PGYacygDMUekUASL6YvpQjP3gZGXJ3RJ8snImHcJSQ8dQ
zGlIXVK6UaR1scjVJsZoEcoYvuG0B9E0osVsFBxnVH3TVzEZhpqGh4Pdl2jsP5Vf

//pragma protect end_data_block
//pragma protect digest_block
rvMvy6zR3ojMsvOYdus0Zh5dy5I=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RlHpzngR7mY7Ym3PGNASro+YIDY4RGml/a76+9wh0k5JJkMkUgs5R3M8CW9TOOw4
h+Si0rWL412ccYGA+d5XniujM1RjOl1ch7+X7IVZxy3qbr+86bF89JtI+M99L2dK
fhCHovcaEhly45YluUjfXRchRQEdamk3I4j630MzN0kpZevuaV/NGw==
//pragma protect end_key_block
//pragma protect digest_block
/o9DglyN3P7fQgWK7nCtv32f2uM=
//pragma protect end_digest_block
//pragma protect data_block
3Oj0g3fjoqNGklxkIAxZBcaCIAvnbuGDMATwjLs4zBODtKxKVvLygVizjLKmELvE
1DgwGaEpI8elrBGeOpG1McdUA/L3dNm7gXbm0A1bZdpgaoGC9oRnYBpH0ice67Qx
0hIYfyPMXAqvyjzyzq8e1Kv+C5Vfzcdxo81DcgLTaGUcfxAIrlgJsC4NE1SN5LYf
3uTUEGZFcCwgGEoYb+9KpCDch8WTdy9qhXGI8bfqw4BxT/BCXkg3hxfM1CIl0oxw
dYeKMBUPyNiPnI+m7sUEejpRMzBLXvEEUo9ue/HtN9SeS5b6iyDqCdeNEeMWlXTi
Lg5gRaq2wTJdnSjJGb7EjcThzPFMQENIo2k7N0uK6Nodu0Dd/1IW8mJSGyNeOG9T
QeVvyvg0GBvH1tDzu9ov4DmKDRnujxcge2fs1/VhjJfyVi0CSPyudvVqbWl46ToW
/GbsyjN757H37wHk+1liYEmLh4zvm2DpJLYA7pqID0PtoQY1REc4okLCGhO6kdel
5q17aOF4l/XoL4QvXrHxES0C01DLKJc6NaaGM3TfdqcEHtSmjI++HPH9n9e60Jw9
PTqalHBzOOSzlg58FdUoSSnA+q87bmQwzoUPvFvIBMihWDQ7X7UgPi+gEXiZbez9
2uKWJwlw/LT90ji/Nicd8FSyA3jt37SVvemeJ7EtxfLE06W6UJbehmDwmG0vQzni
6/DTDQfZxgC3+LdyI3mHC0hfM2E3DCLoeUwnYqtF7Cnnf5gDl5b/AX1l8LUuzOF1
hgh7gWejRWWTyQq81btG+2PeWMKbKjrWD8pf6fOeUjpqAZGQR/Hu0wmkm2+suJYh
em3fHG/kBCvcUwITF53+0lz7R5wRWjwx4x1YcDBZvOt3/bEu85Iq9gw2F0G+hcvn
K8m56hlO7qC4cgn3wQ7nlXUeYjmk1we8PCzWDKXYWqcc8fKMD6XsWpN9j1x31AGC
5xJlLKPLpfARiDmz9HR0QtFqcHC6LS6Ud/T5lNUf77GUQchf4ThZjBNF8ku2srP+
i20Z7uYab1bsxCzXeMi4EcaiFcAORD8C9W4LZ33s4y0OsmBGLHJvHYT18USbBS7L
B4ArYJR4rxHtJRjSQwicuRahlCRkp+XV12yDm+HTQ+nYCMjBKO1hdu5ekTLNF6EI
1W2TKGKaLQBf3Vs5P5i/rxWRm5rDnwPovpym0r7zUkLh3rE8PJOv58RTwAQK/Luf
r7wVgGu353rHdrDSgIj2a/ehMRpNd5FKsgHMrNYhuHPnQixPEx5HSiZLT0ALOV53
exO6FWSw4GIM0A1ARiSnEcqLlU+6DgKyTuA+6safp+M+HSLoA2Iorcr9qDEz6LVM
URQFwXjTvhnfTRN/zdoWYTbrYVzhrmRtDWe/ckaTaWcl0o5WGMj27uZYAgWZBTbB
qbTd3biqaY5El7r8iP9HS0c39EgrqRRQYYDK8hvxlGIIFf5mhHHLa1pCW+SWEK2F
6J6yGELA2IzWACKQFWOv/BlvR//zQCUDtHZ6k2qLsvOO9EGI4Sp+DzHf/RGoqSj/
D6qN4D9Z6sMOiemrllj6oyO5L9rBD1xQCnN2+yiu2nae9CBqgJ5YwSkdGyj1pL2J
HmWmruFsnw5dDIJ9xfJizhRbGgch9qGIq9xGjkDruVOM34kT1rwN1yYn3Ui15QQr
ebZEby95xB+vjxs6OQbLb+jo7pv+SVCz8KXp72ynLBto4sLIH//1mFdkpdm7kHT/
6J24v4OJMRnM5txZjbcRPEse/3YCxRTw8VyrRLD2E5yqCRODKAMxBLuQ4T5ev+PF
WW6JbIac54GnbT0A74cdjhbxUf8alSgX2frnzOVGRVYdnzO08s5uK70miGqFXvrh
5DpVnTGNbTM+IaPdbD694UnUt06REHXMu0+7FjNsVIsDpdQSOA1Vsd5hjZi8uv/z
xmaRbPoxEiczVWTU7TiAzFtqVDgzdqnHvFikPfcmdM86QQJ3ywQU+3SeIc4bfIjP
J8arB/5wk+1NF+REY342G/tBOWMSgbv2BLu86HPPOBFxsULxso6L1Ia3FlVtDjbz
dFdYv7bZh6bjfvpx2ATJkwAk81X+hJ36VPf4I2cbB1JLZ79eB02SQub2JnisavQ/
z71O3PxMBz8vrcaTACqEOBmTGwXueM18M5HoI8HCFxh0XC0TrdZ7z6b/4DOlz17T
KJdlZ0aHhcf0NnFwZWdin6XLo+MmzxML1WnXqNrkAfm+9VtclFXgEMKSMYgVarRP
fE6fv5y99nQtjgwGpwBtmrHBhuxAs5m2tmoZt8u9y7OBU0VqNn7OUO84uCAmJFyl
FZVcEnOIROM1nW9Ew2LkmLBM3I2VUUO3yelmFeYmWDzTurjsMIkgl0jOw2yG/D1a
xtpcO/LxaqvtnYUAd3qViQP4KM8YSp1sHJfNlQPOA399nmTvteDMlcqxDHrDQYxg
wByi59Bj2XUAG9engrqfoi7cSnnrpjFSyggAuTCZ7/eiOsx2VLTEXDS/M3IfMfNb
5mRM2aRg1M7oNu/S2ewyytTpVAV+oUkwa8C75C9KJO5bC5ROC5Frd23KbkHMrD8o
ySU3zss3Nf5W3EsPVXOQnx4y//cUNPL0zSqDd5l+ElzpeUbIBjiHCH6jzW7yqRRW
qb+ZBhhXhHBHvR7M0GytcbmogntX1W7UZKUdvpvE70Wy1bWmfRCD1cziE2TwhgQm
EOfiAS4RIM6rlAj1EwGXAD+wj+pezfjaRxXPgW5UikBz8pDVwJgKYCjjZumX/WBl
wKGC4IdfuHqiuOi2diYODvLwB0+BlnzbbTEiJCMBcSy/bNlLPstfWYDs8CUIyko8
BV2rVSCqIc48owRzWhXtvjF17qDnChaWbKrJI/6VhrXJRWKoaSA/BXnjhpfKO6Vw
4RobpxQpD/Z6/B7bUdrBSpvFKfBHhZDC4R3s1ASzP1EE1sCq2MsHm/P3kefJZn8X
TLGxfAm4Bi/y+optCztvZkvSjCDa6sHLuV5jp4V32trqftmoojdeQXRXhm8E048D
FEHkRFamsZflGY2LSTX5o8b001kZZp6ssyEzlAg/eD6I5ieIQcxImMcfp6JuwK3o
M7zyJ/xiodaADvJTQ1Cnz5B/F98/E4Hw+SZ/4IrHvksMPKhkeCdh4QVpxTxvBrdl
jq1+TH5A77RTM5XZV55Q6ubzlwik+kiEur3F3a81vF+oDBhWSjgrSeF6c4MRdPZz
bjvDPsE1r65/7MEvEt2GnWya117GDuPTewmRs6gIFnWC1YiSXMSw2HH12AZ9qrbf
t0R25k2+8t8s3uqCEo1RSaxVCkghWSEXuDLBWbUiy8SmXwLTcEp/RFIs5MQZXb0q
zmjCYCtR7b3+Ram5SqslApH6WA9Q5hS7MLzcns2pqU5tOw6DB3qNzsbrEPZYDMoV
Von0LujXiFZAUtVQ/tjDYGRmived8t6/qruP9FgnhWQxu0oTnZezZgoZxNJxQt+5
UDkMcipqvcYFnJBDCF2pX2oMncumEK4tGnDZDL6ZkgUwtJFUdqF+RpIcwzyRdNH0
ZZYbE+IZMAOq3bXMPQv2LlcSBkpWkeAMkCZl99p8kiNqP55XBH5CZojSKDlRfGsh
2C8jOy2lCZ/LQIVwazG7fIlRyyQINequt0AsGTjtfrMDh/rVCiH9SOokm5iyLhlM
IUiwA6t5DXC5cPA+EGSmAhNBzIQJFDUzgBqDeHmH66qKEsZEbHr/MQh5oDBuyWek
CvtCUSfVsYGfltmNmKWHj7m/ks6r5luPmco4bRy4TZu/41xn/otLhYC9vCLGeB0K

//pragma protect end_data_block
//pragma protect digest_block
MLswfP+EzRp78gtaZAN9nB0neCU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV
