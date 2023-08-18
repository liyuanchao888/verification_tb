
`ifndef GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_ahb_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed slave configuration if provided on the constructor */
  svt_ahb_slave_configuration slave_cfg;

  /** Strongly typed master configuration if provided on the constructor */
  svt_ahb_master_configuration master_cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_address_mapper class.
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
   * Utilizes the provided AHB configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided AHB configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
H2ar8HIgWiZzui3eza1/XbhNvhJ4j3VFfW2KfYfMwHxhhBLQPOgjhd5TS2NsDcbL
8WrLV4U8nkILy23rCRBimPPB5mO69ek2Xp0tNIaCXCb2A2BGELk8+LmDi5JEey+x
o7rnvEjIzW84jQuXscEsU5WS7WsxUEOq9TJslzB83tQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1024      )
UKCVztc0FZJjLHYGD8tygVW58nnr7r9t8ztcAM9Pu2JwnNCBQn3JUvBeMwS8/sBD
n45CRgItXt/X8J68Ecsq+TJAHF0s5xy9rz5wuAbJ5Os8BA8lmyzYRpjAahVIu85d
g/5w4OFY5Je07wIDdC/c1VbGUVaWByygnJHPLJ5YXlYEqsrKjjJ/De6yqYNUF/Vp
lKdvIjYnua2B4hptDIxsbUnkWQQKUBfIMf7m57V5YV48dNnblbu/Pl6whFoBYN/A
Ovtcx/oZ/yJAN1r5zdJpqCayQFSdxkNIdlhbEPr9rT4tGhbRHI/cKfXgtqnGj8rk
eLQk4WnOut6neRF+eQYmdwnqS2cxO6zWNx6VGUsrA7F8LN0jY8YbEHv9fKBYq+9h
+XoiatoRmVgV8ytZLqhEPi/iTTCGnsNXlDOyfTifmORnd6nNWWdgcRf3W/ioxz2n
P9iyyTuaQzk5XRUW9FsoVRpjHfAI4wdibXsMaXZfg4AHJyaD3I/XEMHkbxYgOvqG
3m8UnXUUVxdEcDZk7xqoNp1NDfTk+IGSWR1Xq6UmTaU5qhKiy34M1UX7+HDJ+Tol
FYlhqgd1P7VW7vIZlJw1rv8HEE7AJ1n0vnU1ONi0Du/79WfBiI/i+UntTVTAA7/1
gpECdqaaQnEEO5aSq53Pi3nfXCdWqrgUSW+me1Wzoq0ACux+U6I4A91KqN9YlTT+
0JikVhdr8F5D4SFJfkUmeaOtzsuDsXNJnQDo64SmNT4ShWw+fXpg7IJpXBY7+rE1
HdbN6oQiAbqlUh8EDroVZ8+UYPaewFDgm/pHlTHvEKvEjrFBuzo5KTQ9hgvs+ut8
flfFTt2iAyOL/vKa6OVu84VZiNaS5PjIkEEP5OyBTtku5DjZzhuiTrHV9U5RDCAL
ECWlzVyEfhSyHP6ohpjDXT+kP2OmuQuE5Q/wuT045atMeuqtXVQxjw1SKlihQ+/Z
LeG62ZADKUYFsYO9fddLc+jAnKaNRZHZQx6Dk+O4tchZ8NEERZmgTFKc87mDClnN
d3XCOvJWAyK+R47voPpdaCxKiKVaA7ButRNgnIQl0lbriXvPFrspkSBICmzYU6pL
1eEBmPWE8YL47c2LzF9QrbYuyf668mLDzZJ3xG5F6QA+tNlPI641kx9XYbfsJXgV
qrADi+EYo+M5Qwk5zZZPuK3xXi6lKoRrUybNy6PYG/OqbTkX9g8P3T4j9NCznOX2
U9MFT/+Sa6oUvtS+47H7IjUPD/WMLcqEM4V/hOSDJveHXSMM7KNAMzBAttFtClzh
whoLHD5MijTRRf7/BJXcKkykym7mkYFxwkbfSv2p4nfpir10DJfnCAbJ72gaS7JI
nyG+94+5ZpMm/V+2H1BATzo9QtRn5mmfPsPV1Tcdb5E=
`pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bgMRN3kLzkBOuiWcK5SHq8wnjwmmSTu9H7PVtN0LAPiHfKfyKbfBwkAARlUeOQw9
7OOMcRxGZPHTMUru2hQ2wdU+Ge6+E9tBIXXL3PafYA1jppSqfOPNulBjpulJdDsJ
eK3KLA4sW+thbXNqyaav0NPec8TDOcKzOVsyFadMHcM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3398      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ut2w1QYisdrf887iBeGlGMflVWpxqsSXaGQOeHKBGqrQhZVqLWVJ33b6KVOzzqze
a+N34zodvAzCSe6aYN10o7PtIwnwpQ/C54Bp5l0p3ABSc5CWEHxdFkYmGaX0cwLV
Gx5fwk4bPcrkJ21m4946Iaf89LfaW2bA1jJaNNXKt2w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3481      )
U1Pv6H9rIqCk9cjgHfikc6fOq9/vbiZMxNk2C6hJd4cpmC+C69qKFRFxEy1C9aBo
LjLgC6kO/UZbGL+IBNWwUlAuvZ1a5PatzQSiO61vdGH58gE3pHwDDI8H3DK+IouF
`pragma protect end_protected
