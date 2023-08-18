
`ifndef GUARD_SVT_APB_MEMORY_SV
`define GUARD_SVT_APB_MEMORY_SV

/**
 * This is an SVT memory class customized for APB.
 */
class svt_apb_memory extends svt_mem;


`ifdef SVT_VMM_TECHNOLOGY
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the memory is assigned an instance name, 
   * data width, an address region and Max/Min byte address locations. 
   *
   * @param log The log object.
   * 
   * @param data_wdth The data width of this memory.
   * 
   * @param addr_region The address region of this memory.
   * 
   * @param min_addr The lower (word-aligned) address bound of this memory.
   * 
   * @param max_addr The upper (word-aligned) address bound of this memory.
   */
`ifndef __SVDOC__
`svt_vmm_data_new(svt_mem)
`endif
  extern function new(vmm_log log = null,
                      int data_wdth = 32,
                      int addr_region = 0,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1));
`else
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the memory is assigned an instance name, 
   * data width, an address region and Max/Min byte address locations. 
   *
   * @param name Intance name for this memory object
   * 
   * @param data_wdth The data width of this memory.
   * 
   * @param addr_region The address region of this memory.
   * 
   * @param min_addr The lower (word-aligned) address bound of this memory.
   * 
   * @param max_addr The upper (word-aligned) address bound of this memory.
   */
  extern function new(string name = "svt_mem",
                      int data_wdth = 32,
                      int addr_region = 0,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1));
`endif

endclass: svt_apb_memory

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pcuAajidr7CDfSMy1v85dR31UvhrmMGFvv/xUJLsa24FW9lSKIjd1moxMYD+1AZt
qISSoA12PZEXfKFS7MFyHfBoZZyxlPg5gIH3RY6beFuuTdY2FlihwZek+upqgr41
nFxJT+zngHgVpTvp+f1h/U78q7yYpWEkPqeFbKOQMXQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 971       )
7hKtrxmA89uZS0bVKMGRjEOvTs7+n1wl6lRrYIanpT+1zSYHji0z0uCcLPgsWH46
q7h5BVS+lZPGoKmLyKNWluvEtAedjRCUNl1+vdB1pzChhKKdfEbatj8EEy6Ny+QJ
4oJTL57W5SuKR2AxyoTGwnAynThPPv5IXc9kuFKMMrtmAP1MLPLruPzzRBAYYbJA
gcxb8uQY7mSBmdg1fYSluN+7LR4P39ENBdyaxIfqBEvLVWh5CQLtbgXFywlUK1r6
nz7AVXTFo7Y1locIB6YZM82QRklFM43HF5qWdM6PTPsNwMxX6Xw+1xk0yn46GoHX
FsWPjKV2RIQBAGYcEeIJxDpj9DZr6MhuEbGdo3FBz74DnNZtREhFSa6N6ajZPpVl
y2chsXoMlIpmM267ukkAo7Dqx7LnVLTa2iplP9K39j7rMfbfvlyF11jmn2z/Hc1m
X6t9mUFl1J/wP+nY4JbaJA+/Pk93W+DbNAfSAyyqY5jcVLdN8szL6DN/ILvu35nn
pxiNCh00WGcAIeUCJggYaQexqEYZji4+bIDe8Fdm/85DB9QbeSy4F2+F1XDWB3qh
gFcOZEhvkqAdEbJB0A+ndcSS587KmMLSQwgSJ41S22K8+alaaa8TKppo3Q9Ar1nz
Qklr8Of/3U9ifTCbt+SDukTXSX2taJPc3nZF0Tbn4RBnqpvux5hf6rLAmbDyZ5dc
6gO2pZoeLfaWWZOOAIv5731d4iSYkLiRaW9kia+g80LSrnHJ7BOAh36QuULEuA2W
mYEKYxzm0QSmj/4x8HWZIqFttIuKskkwW1urp4QcYEsfG3XboAXSjZI8E9RYUoUD
JMicX3AojekYJuiZKKsiVSPsEUvIt24Z7TihQ/TAmmQJL4DFuC3Pt+nWSCEjtqlg
8Wrzo6nXep7dNhWpa1VKCy/Xe/ypl8M0vpHBpWo/cyzrQewVsoCaSsf1IVIcNY9Z
QkZ+7dd+rZFto76h6CkYxNzayiHrzwvNNHKbwbLSdLVHJSSn9KcvJI52nYA6U4NR
9LxYfz5oe5oV75Ke87IufKd2prqdyXH3CsXwc5CxwJJhlVybXDnzXIY0XCKTya5V
3eZSvu/PKGppoxJbspGVK8UCGp361kqdT+Q7OhJwwVOlHIm/9q0jMkHo7Xz2Ycky
JbLPHBrR5qv3v3NbI0+rWbhuL/f5ijcER7YoFDCKkaijLB/YS5jduHIHAOpQ90Qy
Xyf0dvenXnnqFG/lCJefoCg6fGAD2uMy5xqml207HKmfvbh5wAWGVvlZrG0Zvtzn
uqIMGmkERj4SM4gdZ1DsIw==
`pragma protect end_protected

`endif // GUARD_SVT_APB_MEMORY_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QhfM4YstVueiO3bAGH3s1U0R5nLalqkUGK/H0u5Nm4Y6kfmzRUz+TmF9pZIEqr6W
gfU4lcpyg6Hijon9xa7WMXKVS+BiKq9GYWFl7fo8UGQmbtVh8PNnnHeNG5ou2qB9
p/TN+pKYFY8RnMzDYIt2b3PkPHfHUa13KtMwo4NSxeI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1054      )
V1WLkRQbYaUZ8yKSBABzxLCB6X/M1cYn1V3nh2iFljtVUnbMgOP+3bH0DZXBoHu7
GxcOZBL70de4M4Zs6ReT19NnA7Nx7CUAqK/6fGRbIxi/sGs7NhXrXO8wWMdZ1Qn1
`pragma protect end_protected
