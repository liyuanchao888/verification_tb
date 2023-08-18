
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NVIUTpjcLhLXypqCr15iQKBBw3dtYPwGgDy437Nb+c+FqL/OeGBMhXbu9FOBQ7w1
y0O3Fh+yekWGWDDHDZ0L7VUF7WSkqnhi7FkLSeRNz4CISBdKATcKP2tcvqz44uBV
0sb43tbj6ck20R61LW/D2EWkJElZtJrZdBZUyvue/hE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 785       )
g6CAujW4WFnUriqJZ/aCMTST886GDFKxWLk/rOG0VW0qnLUSd2VEzJCZNx8fTMVe
xLIzgUfufV6FK5gNhlZ1HPcJO75XEUC73e54BmIMns1/SCpB+v6oyfa9lk8DIo4y
ezBNJpR00oLMN1npIAWlEFXBj+uNN4ch+qbdYO/+0Nwv8AuzEdY4AWdtiRMLmrRb
4mn2GK3Hm3p1wKGtHz8tiT1SxBamzx+0dZB+L1w8ckwHyHNbbwgfs60HUaT/06fB
Oygf97JfZaB6XxT7noFIybc0D0PQzNYOny3pFsfrgQScPoOgcM4kBlz0UY5dkPwq
goApeR1acoJSs06BRhs9KMl9Anh34oH+/87IytG9+ScVntB4h8NnIFx0e/UP5EPv
lJVOe9VjFsDJzs476aJ0mdtNsuceql/DqAvgVA4CRVIzM1HL2x1KVHdtZEr1uBTf
GY5keAtk6hbyDH+p2j1H3HlaKsvE8IvjGAhTWzvRkCw/dBooMSU8gMlcSQ7ArU+7
0oAV34d5Nf008u8gb+1hLeUGkbI4BQboldnbjCuDV8jB5+n0PCDXLpe6qGdPhdqq
ak0rfpcy12JOfOD5baf8d5K3kiunqM/yMcIx9mfSsKchfoUh7kwgw4hNkvY314BZ
/Kr4XAIoFIgHrJoE1noC97IQqCOs97cX4KJ/M6f4LvkH4n+WQMo1wpLIo2wuMqDf
3dGOL37w+c9x73xjURVSSOp2BmDjmDa4rOKm4e+Q+3O/SebCXPa/u5pOaJNINtpU
hor1pxeFkwqR9H5TmukABJ1PSsz7xEA6iorqBWxbpsb/4xhVh1kTk6fqYMvquBlZ
UDMRBe7ZCN4xmzgwu6BerKmlzN1v45Y3ZTW3I7p4DMSFhKqJwv0AgN3Z9dKvDn67
2jrUq1utM6ANy5BpE/28qviAlW1yqNSopY47UhmwRQxC5nCCftSpMDB6105ADuv0
qkka3sGqoArd4HuUE3SfxYgW+4/Jie3fcjSQ73ydPNItxPE9SkvuTopT1ZOv+kQt
qCraOoaB3/dCvqLwdVZDkHk5j40V2wKy5FwJIzgV9Iw=
`pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
itS4YbUKwsNwsCj64LVkIpJ1WY++kFnsMjTV+fGdJJJVWlpZKDGuV6fXvIiz3RF2
jbMZuTtl+w/hTmCIP/t7ztnwNe8rV3ZV7SMbH01W0tNIQhvdDk2gtXy0gs+l2b9Y
GUTPxIpP7jl0vP2tAR7/IiE6C5PPOV6/HMwwi+C5A08=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3444      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JQsSDeg/4ce7lwHiOv+KPhNgLNYeg05ZYODOXn7WB2v9HBgOdzbOku4P/974uYHK
fYtxFf8PIv2TCFPl3JdfXaG1p/abGMqECw7ooOSItoLQK/HdNhQieUgB309wv8M+
QKWTvvlgn1LNwb9IWAyMy0WpKaVPnL2d12qXz/En3AY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3527      )
oQy8cirnX+8JtKFKZkugAj/q8ckmWlWfBH/PymhLLCrsujmzyqr9NBvfSh4ornWw
WWFEsFJiYgTiwmjFAW3WY7k5tjgLdp5/MHDHie3JGJd2o2uR3EizRiL7dM/sFTm2
`pragma protect end_protected
