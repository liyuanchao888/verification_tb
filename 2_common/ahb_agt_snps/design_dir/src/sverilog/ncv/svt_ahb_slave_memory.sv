
`ifndef GUARD_SVT_AHB_MEMORY_SV
`define GUARD_SVT_AHB_MEMORY_SV

/**
 * This is an SVT memory class customized for AHB.
 */
class svt_ahb_memory extends svt_mem;

`ifdef SVT_UVM_TECHNOLOGY
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
                      bit [`SVT_MEM_MAX_ADDR_WDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WDTH)-1));
`else
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
                      bit [`SVT_MEM_MAX_ADDR_WDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WDTH)-1));
`endif

endclass: svt_ahb_memory

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uvbjhKcP+awKpa+MyVWGeGTcG7kbLr36idVuH4qdM7n+zl2hwFWU+torQo0lwI6B
r5LECRJmwz0A73JJj/1nHUl4iFQiSEAP3MhB+44K1sTaOB45zR9pfsqv5r+ZUiJg
4rxl0WGLsONIrhSMMZm1loYB0mnr+Ra6A/8H5Hb96nHPY3JC3KjhBA==
//pragma protect end_key_block
//pragma protect digest_block
Sqh1JPZhLh0sMywbwK00DD9JQDc=
//pragma protect end_digest_block
//pragma protect data_block
SOAR9VK0wNlJuiP/kZaiUDG9aj6r9B13RPZN424Tu0NxfF7pekEyfhJwVo32R4Q+
ObRzDuz/cNnf28ucgMcp8zOVJ2vxIJCaryzJx2rV8ZqxxgfZLE8nc+Ad/ft6psH+
N1Nk3c+cSybmS4nl9jKnOGEFqzu0DerEixiu9rF5U1ycyKfgCVijwR08juTYaQqj
iIrLQqg+suocyiRbba6luOB09vav1N/eux4cNQYKz7I3w08dSAD0NTDIESNw8HkJ
Pu3GrczpLwBTBkrpMsmVSlh7NO+evZPKdUZ8AwCcRo7b928OyDNKEAGIQ6KvS48D
hVQmugZG8xeLxqHINTiV8JekcVN3eJypr61d6Rj0RQwk8Idheq/XK4HuAgoQa+su
TYs/bxthzYZcBjb15iQjJwBQ/4nveznDjYUDdv4PLjxGoD/HR+h/tZVieCMrruc5
go+GWb2P8zTuj8Dt/SyO/ssCRERVH9vQzx0MhceHDifj/LG+lTNq3q7COCI/W/oI
4bkSPyi4mK6kYk6ifidfUA9uNLKUvUU5iefL+kydDd0ZqTtX42jBkU7VB/wfRn+O
9WBrNHuz4pKNCr0PAOwXz3M00EegZzJr4wvyoTbsr9WgtdkYH5pwFXHbm+GOuHw0
6B6lg9O6C+p4ywckriHSkTRBIKkoyDjBO204K1QWOTx28d0LrSlwIe5v27Xt0O/u
CEA+gV4hBUQWwpqQIOsQvG2X8z9o+UUoHKbeSfZB972ohzMbsDcaz0vJrvaDrjah
sVcoiNvbZBQyeJoOX/xnER4gKKVeiZgzzfE+lw8rW3LshgBGDrSZ5vaJxsiSJCwe
j1xLebm38Nm8SxmfkwLfnmFq//Ptg54p/YYZRJEj5DeQ5Ro+XBtd/1Qx9zJf3fyh
R78IhOpzkv4936VxBPZIqe9ByT/MzKNNwV1qw1xp7cxTfMLz0IH5lEHT8oR8oF1v
8iZoQRt4Br+dPreXqWafrdqN3qfDPl4eu7npP2M/G98X6LkgljAkkFdM766Lf+bZ
jI6idhDZBeRKJD3VhTcyQRj6vKSDyOaYdhaqRDAUke/pUeLNcCmAWF0MTFAfJsCk
eAALu1LFmhH02bqcwed8qbeeel6eYy3kOidClobk/KGppilvFVBdRYuDXXpN0b5U
LokVvv5BC3qFU1RS2LZjNtsrJoYiiEeWw2jFOjwmEMcWIydZP+klXMZiq2aj/HoK
PE6v4PZxnFzviy+L6O481NzbWD5A2JqGT4WWCBfK6us8niM4faX9YiU/eji9Q9m8
5NaBRnt9fJ2YXGWiAy0tle63R6IeA0FUvuviJ6Li1uTRBGK0QrTU8TODhcBf0AwK
fTEq+jiHtVoXtEPpWCBG12mVQy0cpk2YavTpuBqzMvKjns1lfib349QeUplyF4du
4FtDOFDTT+cqKbjJQEC1JXwBp6NylLpS5N0sJ5rhm1xAUVpDbQjgrkTmhOdHm5Jd

//pragma protect end_data_block
//pragma protect digest_block
ukpCCZ53j1AmEwxrEsRzPPzO7v8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MEMORY_SV
