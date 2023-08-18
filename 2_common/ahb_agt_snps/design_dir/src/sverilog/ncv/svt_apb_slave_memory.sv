
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
g6iT5y0pHw8h4F5QjD/S0cbOOIf6rDaAloujBWZZUlPr3bRPXQQRgnUpyBP6/E+A
1kUqpvYakfkZwZXF8ZqldVB6SipYiIuSrmOJUaXl/+7j23ZhvVqvFmz4uOPH2X9G
Fc5zNAC0naw8Z3yH+NCEL1fwzYSGy3dy9/tO8E5hoSizavFdxlutuw==
//pragma protect end_key_block
//pragma protect digest_block
Lt0bwZbRZfFprYr9qJcQZWy18qY=
//pragma protect end_digest_block
//pragma protect data_block
fRG0n41nXcxVvmX7FWSqCNcN+ofujLKKq26YoZrGqOAQpnrZlV5d8AY1g+s8IxzS
RXt9A/rt8XmmtVc1viL4DDVnGd9Pbu/cCupgUTUjvjgO6RhdrdbbdjJ7CqX0U6Te
kXYV2SYEgLJleoPyZYUJbaqsUo6NXQTSgSB2LO6o55LvyAFWwuDSmH36E3YxE3on
DYqHMVEiqn9zBzimRI7j5tkLEz2dGPzmgP6TJ5t8//r0NG8MT7+nTGzsMNcHPVyF
eZ9fsCb0iC/J8ucLV/lHKOLsbES58RQFutMgwdumC0muoJPExGaX5cWD1wMu0iRQ
4Eko2xsZ+9k/7sORiOos+zEiuutHzFLuD9sqtaBdgoww5c3+YxMzL2tvPbhE4A1B
cfKXnOcl39HzYRU+9ETLahFio9CYFzNH/gY4vtTBaFapLOMTB/cWRacArCUQG0V0
H++OuZ5Jjyd+8XslXR9UDS7wpo+/DDOf1YRrM4PwmAf6T3OgE9x72+RRFZr/MhMF
AeVgJcIw/BkJ0AoVDeZ3/Qgh5K9I1C6CETjdrCr86RZiGFwGoT+KXLGrzp9KROxa
ZKhVKnCapbP/IsDmobErlour8gFSSBU4n6GAxyZB8UoC6U2ftF3Ei1oCwBq0J6oT
WUhxEK6OKm+086OpwJRpayCelAQt5fZZCgpRVEDG0FHg9X0gtBb+A37SdCecs4sw
1NDpBG5eF6UyVYJhmg4RxGI/TrtDpFGe4A9XnR+eDow07XFcCLPxwhEB62rQ2mnu
OYKn3WdN0fm1QIjVRaJ683SRagYCaAOaEAPr40UQ6DKGRZqiERMQ+UrX4S8m26VS
e7Sv4IH4p2tj1I3ytV/VGoo16oMXRH1+BRFhMYQBVLQ9jM3VCc3Na+soSm5q7C76
pBFG7209l4ynZ3n7QzTSYg+WpZDPYw7qOYMtjr1VIhH1bAhQ2dTD14QhfrTSJQNd
gvIKN++6yxFv7r5/+JU6QWKzTeaQnQ0wyxTsLmQCmS7mtlWrdTJPzX+xJO5DtaDW
Ac3jPlz/6/g02mQSuy6HA5WS700Op97UkRyvuJsRRWJtmIscytLMDiV0sM1tl2L5
bGVjm6ajwXFPOuGPoeiOBhwZde+lLyjGs65LsEO4EhEBO7LQ+Xg5Do79bZFARe/W
TlX8nSWmYGPeJ+CbEoMjP0oure87AdxkSfcdaNd4gG15xxKFoY2T7RcFo1c5GG8V
4wbWr/l6bckXk3/jikSsZ5FJIbCWaQjTJ+mflxqSkSGafd3KXXUs9jT++BHQ+eKg
Pcp1OMSu05LlFYD19hVE47+PAOp/up3R7vTahGLsY9UK/qwahOA6nVROQRfVcwdr
hBPKLUdMqOMhCv3UVV7SxMdwjAdaKNFO58RMUlBR4SbuzBKADFvvsP5tZdHp9t9m
SFxyYwTh9JGaV9r9JiT+VXLeAENz5+6OnmeyohJ43vOfIgmoTUoI4xMrpBjYijgi
Nz5voJOSLEwg5xU4KW465ZgvK+s2NaTyNptkqLh07FM=
//pragma protect end_data_block
//pragma protect digest_block
+hN8Zdz90dXwsIqiolD+HylKRFk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_MEMORY_SV
