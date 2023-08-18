
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
awRdXwsOLb73DEuLLKLeMydhOFSpWKbvx2Z/SmGMWPUmaDiM6Gbc+8M7kPCEh+ZM
X6Qn4UUP0f4iM1TuEKmTU80P5uhScXgVYGz+M/cmXmcE/SW9qyVGpb1g5C7zodKF
9Cn+9xN8BiqOIBANNL4PVYbnoxArZxqRmq9YFGlef7c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 937       )
ZkGOLcUOszTaScVLYREcUtJteBP0JQ409wssE6YHUMeANXAVrkCtE4E0P7K+PZi/
+qTTqz1Adb/NXxWYbc7vTW+uHO9Hqeimy3Jy+MgXztbn96jSBD7otxFaKccaB9sq
sxEhTNo4rSHM6MoEdqrSdtTrtfAmE+rnoC23G5HcHHX5vJR63mHhTZvaiYWm5Cbz
80/T5XOqFGuqI0Bkh6PnM0IJzLg4TzPYDBQmwPOFQXPrGl15Nus8D4sutZGL4XUL
h8dAbzP4Giev6d2Mr5V8f7C0k0pvjRdu+nj05nBX3jf1UEcWtayYS/FGZgQ1YgIU
/cdaFFNJMdr9foZaI0/+OQUXoBPCO8t4mapCR77msHmJMgQwhUyr1UeAIK9U1tcB
/BmoUVtCHijbrO04EPUM5f+jwpS1VrytWizJtgPSMPMPOLXy8Im8pxCiPZQsmVck
SejlDoliLY1baUu4S3F+l+jG/4yXs4JzEDaOQihjXV8NbOeGxmqrQxgCzZXGSlBU
dE9uSDPIaI2aFrPIDFIDFO39GOkss1RxZb/51fimLOwDwW9bUDmllkO8krnXx8Zy
6BrGV2zKteJxl3gMqt/neuq1n/Z8EtnoopD3MO2XHBfjGlxneAnxxEek8R6eOOyl
UM1bhfYGRA/I6Sg/MG3KErkBq87Y7GA/xB2cthrKB6ThbuHfe5f30m1NRwWWrAx+
oDmtzhIhk+kmQHI7eVVAXU0B0XHJVUN+H6pxpU02lX/kCo/7Xhqsi1jayLbRjRid
KOPOV0bOhPMpT2FYhDWVe4zDN28rq4wwyZ+OXbeGDzEJcmKR079trn19ZDkMJnlX
lT/bZvE8ipYhl3PYskdW3sYzYXQZNems18XQ+HhS0h//zFK2UTAtX1Ljz1xdHA+E
Yc3pRoEYIXxpSmetyEhe7V2jJiC9Q2p+CgxCpe5AXTPLnjN2QDDyPB0trQjKGC9I
Ri0idNNIPTRi7Rm8gG1ig7BJH89cNeJ8hwJGkX4sH7gahmt+/yiqfI2aQCSE5wdZ
xN6mWB6spZbi2xQ/v9Vx1JYNzP9HHqz8XnmiBykyXTxec7/aZaTyftJcc5lVNhZy
3pcaSzE6ZFHqt/vasZqfIWHLCBhU54nVX6Gw6jFCWg3gBcjSDHi5MkH5hYtfOi1z
lbPQROYG9ggdOZSU58rBUhNhkah1Fwyh/dY2xhMTzJZdnQSvRRY7NjrQ8SFqxiUW
5nuSKk6qilx4FB7NYxtYDKSjRl/rNuqqTv+DO02t7Sw=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MEMORY_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GPTBomswjEk8nH5x/hzLTmqvmge0VhhcscTzLXsR5HQrZCyLb3GM6bb6Vhs+6Dh3
rt90yvMQqFZCcM3ttWmyeeBn7GpZxZwbZ1l9dOq6ZDx6t1aTpsYIu6bzeg2WoEnw
mbLwe03cjae1ZiEnZuYxdMq1buANQIH6c4iYF3oUHjI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1020      )
Zqlt+D+I+YynS7WZwlKCAZppUPf9rQWo17/yNjNoKC4yu2Yc0ljo8alzmBogM4Z7
KR9nIlrUrTno3PtwtX7rxnkC9cw1j17n1vSOV7jd4Nj/ShiJeaIfZnh2n4G6ENi8
`pragma protect end_protected
