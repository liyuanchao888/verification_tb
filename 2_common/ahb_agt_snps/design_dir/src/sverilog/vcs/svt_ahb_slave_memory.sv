
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

`protected
^gc[_dW&Y+97,.?F-R&-::0PP)-)/#6J+?2K3^fa>+INV8H7/OL#4)NSI28UG6I[
3<b^5=Qf(0+LWYI[ff+BS1cMdR[^^/M9]cSQ4HD7a48<f5)?+9AHR[H/NV_e3;@f
H2-@:M-9g7HR0UBRO7gB?F5OPO[6108\VCTJ_G(-([/dR:,VJ/8(@Ea^8W8Sg5/R
+L)QS&G,g<.L]))0&7#9<6[d70N2R9BO53G4.0,eY8KE6]Je8/D=g+Y_a[(G[^-f
ec-BJN7^eJS[>L(E[dPVfWa-C9)XZaAg^5D<TeE9,)9M&K<:.&7970/8EI)YLT,Z
?ZJCY5+^=Hg877IO+1eB2efB^I0]E[577;UGFRB]5Xg)=4R_acc5W\PgS+39DVCB
M<C7R<S1@<5MfG&SSD1^;#-_(4EWOO;C:H=)63P2BTJg-]U]6&RIHX_5NTag=bPB
K&=9G\+F,D\c,O/(PJI50^N\GH-2e0O?aLfGV9Af1=VN[S>9SKYW2RW6H[5JD]MJ
DZ:353Y;FX/B5EBeWeBX80c<0=055;JB6aVD@LV3b4KGT;C/g[PX.b137[7\,\Y-
63?F95G9NRd#dB+EOYX/_;H=N<)NBPV=gOFM#U&CC40799.8fL3(TJeAff]#1R5?
/I8d?^LYVGfIIF4FOJF\IcBU,I_\g&1_9/-B\<#CIb7E]b9<33E#TI.GQ^;KS2IH
#I<K;^VPGV0LRCD:PeXS1Q79g:?-Mb27PX/1<feSFH?Re2e1I0U7&6&)SA>OA4KF
\F)Sb5b?4Q@A3LSCaG<P].7&92)CT\b-G(c4CY\3PA4^V&d/1aL9DVN_8RB]/)c2
U7_:7fR;\N6XK75J;7V4>->\+==/AJAXZB4T2+:I;O=J=?cL\J4.b2O&M6:^df1/
=EI4X>-&5F&V#BA>Tf\Z2?KP>@0&<UTL<PIH?T#36/85bJ4B<e7UO5V-K[D6D#EO
<6ZU5I>M<LV/2.GJSg?KH/Z#10GBH.<J,F77K^L:U_TLI80HEU4<9G,NY^>WH)8L
Rgc(cCgbcRTI()1?-L,\b:0C+BB3[:gA:<Z(XRG80.:5Ud_cfC&OE=9H[aI=(1dB
41)J=B+N8EY4be9D]5Q>R/0C6$
`endprotected


`endif // GUARD_SVT_AHB_MEMORY_SV
