
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
&J97[6cV&J:^gfQ1)eNHc8d1<2ga+db\G,?ZYD]6.fMf>++/R9S12)-Q]2&6PR93
a8L,E#RQ,X9DGD&,4#QM(V-1CCc33_N>JYVYB6+;;E1.f29?I]MH@UEaZV\I32^5
0B4=c2e<W=.c^M1\Y;e]VL.aI5#PPA;WH9Aa\]&>GR^U:RR5gcDXT;J8YQE/7fB5
\4bHX7,]&Q2P&fN>Y<[@=#DDGa,OWJ,OI#&SXe0+b0b)RE#Q2TTfD_3,c+4RePcT
(2eUB1)>RS6cR<\=#,;J&S^6#;)KF9N/YAF:W,2FY./W+3AcN^aI<S<)@L:(^[]&
.4BcCWA8X,\b6(S@TFd)Qc4;PNQg(U&47.1d_PB#C#&@LVC8&R:Z3X8^:V@/V&<+
8I2Oc#6V2XZ/HfN\C3ZJLac<d@_EY,b#8GKDD>C7Ud=L?@QHe>6V]:6.;VGb;?A[
#30,<Y-4d6)af=UOX?^6Q#</638<O\c4=K\XY?WF?5:7GFCO89Q/A^5(LNXX[-ZB
1X#Y,W8R^fS])?)Hd4RfCS_5\Ff+2O;?bc\OH\:I4=D\gGcA>,VJE8,8F#N9EgP5
4I/W8Q3_V)T2YK6a_&SfIfQTD;.MI608VHHO,9R,XNLL<FD@0\JcW3,ZVA(eEX(;
EEB0>BEaGK+E0EZ;JNTR:V#_I.VEP+L-X=F&3]-2113TEZ:+B9K)D-VK7S0)>^@,
ME^W1;E9M(U?/P&.ZE7aeWYL&[Z4FYY=^5R=7d9K.4G:YWN7b;GbS4eF=4,C.RVb
Q(F(fG(_>\g=<f_):N+ZPIJ;\/0?,a18]gW@NG/_BEPGeZ_:dY;KC1Ye_d37eBg;
dF(08Y\WJ1@&A/NIf5D??D)X5&D=TgN(\3>Z]0fCGQZcce-_;Qe@6RWWJc@81WNW
fd-/-CP.+C@bK)c:cUeRgC<6>G;Q7,U[I1&c:6[GH,G;1De#B/^_QfF20f<64FOS
AD>>QD4e>ce(^A[WC;=F1OTM@+[NHHM@aUSHdF8JXNM09X?6c\I,/6_?/@-&5eN:
VDD:=YUU3IdMD\DLGOX[Jf8=eOg:DeE2cDCP<^9^3X>Db+e1)@PDK[&4&e0DcR_>
e./OSB.C-Ea_c?G]5H.cZ1dY5b9(.T@ZVf_G5:-K,aHGKS3EC-fQI+>@D[=\FWZV
($
`endprotected


`endif // GUARD_SVT_APB_MEMORY_SV
