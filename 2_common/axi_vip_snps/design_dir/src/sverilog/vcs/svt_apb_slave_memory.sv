
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

`protected
J_XCSK^<GI-]4/HdI&MQ>N1HgK?f)B1\<);6-\4fKdZ42cTVARJ(-)W5gLYYD5>b
_()I0KU&NF<HBfScMgf37;d<-g5I4cOT-M/Zf4\;fXZ&2E?S68CRc]SScL\PKNPc
Z&E]Z>SU6=b9OJ7@b]+aF3G#,EZC:C)IA.@21K8>7TD3DDZ<+VSK2VJU#;HM4NZ8
U/IeHT[-+9fSA6_92BecJ)P(;RUZ8OIAZAaB&5/b;,]T(YR]CS<N<MI@UVe:)_C6
__6L_fQ18ADV90_4=/@NAJe_N&R?084E6dN0OGIQPPJ<@Jg__E6K3L##a96SH+C.
DV/84V.VQ6QCNLYCKYd6QMNNc4K>b=D;<C#E\19:/@C>A];GCA-cJPTX;##M6Z&F
5f.^XQ5N-8K,U>695A6PLFf(97M-I2?LLcC6JM7F/U[cMR)H:O?Z]L;Ud1FL(QO2
MffdTJ+Z@Q1_L7,/Z1DX\4aM5]R0VM0?5G.5/I..-RgL,AGK0#)56.&>K=Q=)b<K
+cEB4S-\N.XI)bS.NHXQAE=[fgH@g)@F3.I_09\KG-)E]/g/7=.&F9844^>_CWf^
-,f?.6]&-E(+0S58^\E<P=\1#.7IF37EIK;Q-fN)=XdLM-5Z2Y;c/4-eFQQ\_S<9
&3/\5fbgbCES<5EZLKX6GS,HQ.\TbS&G5(26V(#5J_.]T8YHDHP)Z<2+)1bE]@Dd
IOYO>XFR;Iaa5Y>9Y?VX#<3U06c.ML52=caG@0V;c?C<g(X?d:QKGQ3L;8N@_Gfg
CMaO+.HYJV]ZJ-4KC2G/E&B:I#9#);>aaRA(NI^#\H.N\P778-Na-1QQ_8-;A:94
Pe]W+,B0(QVG&/LWS-FW)d:[BZ6L/K@[^H9F-55+O\#=H9O(366?WGD0&/7<W+:c
YY2X=ebPD?QGD:-9R3IVe&:69N7A(&_@\SA\[HPC;?PP+cX/:O,0?c9dCIWd0YL,
P>1VA-/(FL,7>H4#MbJa9#ED47?H[WL/4Mb((\f)DGU7(<9Z(3df3I>IRR<(2.+c
-1J?;^ZW)EX@87^BGO]5dH^JgT?9>XNG=_QJ;7HGNRYV;ARbDaPIY#g&4-4T&=Wg
[Q8YHNHbY@99=U&:G7DQP[HN_Cdf&?D#-:E9AEc5B5(LP/f[ZC0,TAF#HSK^3H1a
($
`endprotected


`endif // GUARD_SVT_APB_MEMORY_SV
