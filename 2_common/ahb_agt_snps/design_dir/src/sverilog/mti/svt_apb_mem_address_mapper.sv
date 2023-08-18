
`ifndef GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_apb_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed slave configuration if provided on the constructor */
  svt_apb_slave_configuration slave_cfg;

  /** Strongly typed master configuration if provided on the constructor */
  svt_apb_system_configuration master_cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_address_mapper class.
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
  extern function new(size_t size, svt_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided APB configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_apb_addr(svt_mem_addr_t src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided APB configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_apb_addr(svt_mem_addr_t src_addr, int modes = 0);

endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z3YXC0ehJ36VkUkl54V0JTS8Ry+TdLPGZj39zfO97mXFtZSDDpsnIXuitmZUmtCZ
+3dYSIu/uZKs6fvdVQlmkR9/SEU5DPKhyZlPp13wANuriC5S2HkxLzVCTViBobUl
5i4uy6hcEuv2K2CWV9QB51lm67+s8xKwuIDzMO7Ns2U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1024      )
YwNm2vSXJS+vv1zcwI1xFXCM6tgi8XxILqYJMke6s0VRbLomQTmFiQaEX9oiITM/
njjpxLgV59lIFB0YMnxijT/zLNzsOByeu7RpCXp6vBMvxue2gtaoaUzvb4oPokbn
FPV+ibMm1CAsRCuXkTu1LKFiIwSw491JqwJHWrYf501j+y4B/UBr1UPSBaQEqHlA
mpyiwMJcCxb5NHY/pZX4WBBciVzEKroCORXW+J20BT5arh1gU1qEpP5UB8kY52Yw
xQDa+PuLL44jyN1wDFN6PX5yxI4DgkLFoN8k+STBBP2CNWJotj0ntEybIhq6XJ63
Kr68UxYwbly7dVlZX27vyiWU/P28OdvxnX7zCQ2JZryAm+9azf6Wt6aADLKMBN7w
P4WEE+NGFcZwAZqXyIAK9giERjx6n1wL7ed346HoXB5vHxboF1rA6cJNQ3km3Etv
JL9eeKRS7ng/LXssKJ93R9wsdf3BMHz2MBybX6bSfHk+Iq42VYwzTypePofU16an
aEBjTJ/bK/cUHIeOxJPueii8TlaMX205VfEl5fFmdGPHTD/RFWnn54a04qljnTbH
qrk1nTyjsjmXZbvIZZClv8dD2CZFkWyymALK6WCZQJBlBlBE6awBOnLA7UN8E/LJ
42Yxm10OEvNIChiUW4YV66S0KekHOl09N1TORlFpRfuwb+JHgef1E3Z50dC9yh4M
6OhPQur8kkLEkf57xFdNjpzQEn5PUSKrL+mSm1pM0gsHutsbxaCGF4j2hm3s6RvR
XdnzHs9wCAW5tMFhYcTj2Q9He5kkO3leFHHC1gFv2ZiZ+jHI9fM7AvCwVSSRLqlp
YUjxeXImM8LHmxuthcfsw+jJlgEYTk0xrxtGmestrF74OD/0b57F34N+jQII+0Mu
c009a1yb3aLzGI0vo3c1GGCVsSG4MtqkoOX5fSaM7EY3tfdLRmGOHvMeHtWuVDxT
2mpL2g1tFsXgHWAUXQ/LjeTvkye3JEf1b/r7pDHWxZBUZaqZAoOFd3kZHLPUDDGv
4CrebWfdlbKgbTmr3qgFDl6T1vOP7cAJsptNgE4BNPao94PbSUETHzVNYNCi5PQo
kT/lDgWnvx0tWon3XEwNDf1AHjhgrDIQtdiDRG5MKdYGW7LoMGo3b9kCjYwB7K1n
P2b9DCMtkCCc0x2zewp+lu+DO19AvShDplxugGW409P5uxkDz8Dzmxbn3km7pbrW
9ql2J3QACEP0W1dM2xODpMjBMlufsbM/ThcvP5E03lzDJA+5L1VlHexX19ssYbgT
tRz+BPl1oL7odZ3aQojAxlJY7Npvv5MnBP4Pq/ERPSL3paYKob5geqLN7JNDPruX
JJ63N895Taa+12zAP9WcgMWCm/xESAuJ1MX2BdBje8o=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WSf0H6AX92QQcHdh3iU1LuwulmAc4SWqwQSkDTMw6VqvLU6cwAwMM2zriwQquzkO
nhTG0skHtZUbGd2qz2cAJxf2csbzUazEW+c7urKszT5MKRQUSw2dcA01cMN148XL
ABgxPTuK4/P2kU/F899yi7FgraT08NHtjcxDElkf1Tc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3507      )
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
`pragma protect end_protected

`endif // GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fZMoWLQIvY6CaETAMldSpUvVTc+B6XITd6OkQiS42YIK6weVWUdM2DzVyshNawgh
e2DqsmmQ0wuOfpodqoJ+N/QRSM2OMHf/fsrfC47BFgAuZhPZJ3UTCfrix93usYVM
cpUyZJFwdJTfMjlImgYyjLAb+iNBgJ6KPtFAHUVA1Bw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3590      )
ZiB3KOi0BdkzzByGlpghRUVpQZblR8rRbbUlTXKeB/YpxnUivF62r5u8U2rTpBNO
ovNzR81e8zHaiPuRoyRe/YKaFNBP9kpxWP39euoqTH1HsigDBxLZXe7iCuARGWE4
`pragma protect end_protected
