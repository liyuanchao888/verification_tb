
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ak+wlEhpZ1O033u0HWStjsxS/puUXBfFZ3EPG2lT+RET98P8ZalpxCnt5Kfqa6Rj
ZwOpZ/3SHS2WRDhxQoqvpq1LubVSzHcNa7gI/REaADmyxSGzxWJAyF8AJOwAuH3z
Kk7xYbNTbqfSL2uRKig/mX2vxIIabOmBJcD9HHJj4mcozWFmrwYy0Q==
//pragma protect end_key_block
//pragma protect digest_block
lKCNWgVcEl4qkMRYEz9n6TSYRCA=
//pragma protect end_digest_block
//pragma protect data_block
W6aDRZLdVXt0D8/d/QKsX9RgFldurvvnXe9j5dn4weActl+vkEGpANuMXGaptFa/
rjyDqC5VTCl3yIN3dgPb3FYxLkTe2UPryY/pmNEjaVOKvx8FTOObcrbi/W2vXtPl
M1BfRk67Wz0l4gbLqainlzHytkIK0x+5Oz4rZtuYUYBI0fY8rOZqgEMyg2JqIJu0
Z4jIvgcygE8th/lP8tMv1j8IHfAr94iIEleRK4W3lR8NPTY6zEY5wl7RTBfVm7bu
7lCdoNVMYTHF2a+VP0MQkZ9ydsDOdLWrX/ytFTxBvw9ip6cq0q4FC8JOZv5qz1dA
Fb+RReQk8Lnn00yGzWDWM4ThEbgXRxF9X/vz2JrypKNO95A3rm4K2gqnmydi0hJ3
lU8Fxqr4LAqUtq3HfSSWTvrgzUVSdo970SLTUd2UTQu3jijX13SZ26z/6pEBjIVB
JP9nu5hZH59MHfjTCY8X+pDe8jDfnfI51B1VVbcHrDZmVqQBsVcNd3QTNNmHATPc
oW08k4MhK7J+le9ReE09IxjY8x36fJDE3rnfn22hxqD9shCML3a7grWfvwurqFMF
WSJBXBXr4drGaaXYQE4nA376ZdRtywEJ+G9RsjUn0sLsP2VWdIFAC6/xIJLVt9i+
A8UJM8y+dCyelXPtl3iNJvTQXHvy4siJJT2WD1Jm/t08tRN26X3QYqUJ1cyk8auc
2LzcZy/5iwSPRnF9wu51Rha4DFvQkFs5nw3t1W77rihktY92DRyvKpVg1DGB0Efe
3N8bZ0cr7K08WRmiOAWkH4TeB7bgfD/SVwKknhSANVl5OoCGqfIYkiA9xGo1A0xH
Hg5TSLNIhuLfowLPQVvLPbo3ZHyazKzKp+nf6wqRXCNma/E+DKwyrP/KN6BcJc8D
P0O03JAvDGFCe2sUooppyYFlwtSBjoTapKKdW36qoFEDKQI6D/ib6ttsgjQEhSyT
sTrTRAvqcsLSqvVJg50BJQCD1NpuaxPu6RvO79XChhM2fK4nBukvMPaDC2VHXg6n
ZBzDBdQVb2C7f2iL5/0IHzW0WakNgrIcJWMup7a0iEOhQ9YBcx1qEvPzFFvzDcvm
KeEk6r4wWdL/2EAHqoMkY08XUDt8w6OvW3aByqxqbNV/x2NY39Ve4/IA+NXhDtTQ
oD32fuHjW+lQ1oF5ipw8vcqI6dO4pO1MX+F6ajiCjnFtD13ixMCalOONn/bHNsmm
rwxyqpASQqo4k1cFT3fAURJwt4pJRLdy6DfLPiF7xgkdFQWwk9vyOMurnw0DFkPJ
31ss3nG96j7c8PBRUMxJCRB3ZJJwgFFJ5hxc+xQ0oms/PVquLRx7iBblQiITGYdo
Txezde7UFlyI7U7c90WEiQYehqLpOfbHUPLAbgTZdCM67paKJqZJGLXvjJ8WdR15
7jByQNw7RTMIfJgMgPPJfWxofLKcgNhiIbsqNvknvKbrfCT6Z6hw3fTcaXmUOO3z
w9+4e9oweoStwHnF63awZCp2NyLMGAab5Bzl6OzjF/tt3YyEIhYc5BHJPlZfMG7y
T6RMvN8bNx98yGKjzb87zu4T0SlRDjIZjjsisIn9jp220cFo7YShApC2X8Y7WCQA

//pragma protect end_data_block
//pragma protect digest_block
AatCjWAJutVTlERALQRU2V2A5AY=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Aj7m1+E+5WUvmBNbBdmq37XNqo3CBl2AJkP+bTqP507ml1YXjLMNUNHS15C1zGtZ
oC6Lwharu03C5w2Z9m3Aevx8mX3Qnj+YSOUhBJ64KlbdXgM2gC2grExICwyQhzz4
JN/XFDqvMS30MTarJk2BqUu5i3Vcim/+BQrV2kNCpvafR4eHkCQZ2A==
//pragma protect end_key_block
//pragma protect digest_block
/e0jQ9WyoidnB/YA+nyQq6hPMwY=
//pragma protect end_digest_block
//pragma protect data_block
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
lo+969De2g71GqGlfndyRA==
//pragma protect end_data_block
//pragma protect digest_block
swdJeiLmMekxJWoRmNmfjEM8Y0o=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV
