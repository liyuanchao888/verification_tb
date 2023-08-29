
`ifndef GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV


/**
    The master reg transaction class extends from the AHB master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_ahb_master_reg_transaction extends svt_ahb_master_transaction;  

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_ahb_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_ahb_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
`protected
J93)?2\_:5C?d_O\X\,+]\@5YcC;gZf:^;C#JC#>c<b;)#26Xa;Q0(5^B]&a\__:
V69WWD5WL;U\#]e_e/1d4WN/7_]EFOR#e&G5M#JBZ,]?1GD3Gd\WUHALQ.MU58BQ
Tf@J47D,D#9##6WA^9BQU7QOESf<_S+aDBbJGIFH;CF6<2YEFFg-W/2A(YUEN@AI
;R7DV48H\^Td34ca7+QYBGYT:,fFI+X2XMF[Z<J#2RP2(g(R/>Q,/)g3FD2I.8K0
=f&W]&02Oc10CKG>Ua3e@<GCRX=.BFbb9:[aBNK-^;d@7<3W&P#DW&K3M#_E_NXB
)IFgCEDLZ.Jc;V3(V8V.6b1^Ic@CI\/80^#F&N/8=2D7OCa5Ee#M6E?De<g;#Na-
CQZ:8QeY05U?@ZPRJ5(2d=cFC>X2VdVHg(Y@JU+R;I[US)a=fcC2ANfdH[O#B6(e
6-5A(.g9+1WMLX,fHF3[/JM5cSCNE.R[D:CFKR,2)G^&_9/Af(.NFg^T66(.R=:S
VW7G5J;dG]C6\+gdb6/QOC^/OFXbgXWZd6/0<^GI&^NQb0^)+2XS1_.=HJ+-&WR7
KaSL/KP=B=H;0e/Y8P+&e-9+bR.P\VO:=]E.IU@Se=cLXW1<B_,QS>5,F,1:g3W,
d;@7.@7BWT6@8B27Abg?]g;VASAKONXC.UfWT[-B28S3;K/474&9feL61&C_WM=#
BLXI1@7b3AQ@0$
`endprotected
 

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_master_reg_transaction");

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_master_reg_transaction");

`else
  `svt_vmm_data_new(svt_ahb_master_reg_transaction)
    extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_reg_transaction)
  `svt_data_member_end(svt_ahb_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_ahb_master_reg_transaction)      
`endif   
endclass



`protected
MVaZ569T8cb-,I;eQ_N6GHNXJF9/DU:=.K/>bCe4<U_7W^=F=_4S))KRL+A9Y9#^
]FFH#7J]fLV=)B0^&cddHFA#H3T^cdOM\+28(3G8F<aMe\UK[#_&N4d=4TS\#g&[
MaAa:Saced_\F.4R8g.9Q+?eRG8O]IC&cP#a#-F\S#H6NIfX,4AZ:2VP#1XLPa]+
;,\#8J#9T6S_YE]8gc,WP95B@.AcU\>5[QFg]B/U&;Y4T)gQ]<QG6/(;dJ83LIV7
L6S]G<7BGXY3f^+IdeE0Z]]FXF+-]=gYWKeJ&/FXO[\+FL:8bIV-c[MFR61]QJ2b
?\U3#5d,^OPWA4PY+#&=48T)[3.>KaJ4]>CI;_^N^QH@-C<JUN8&;A,HYKdR&e=X
Af3F#YABIX9JO=ZZMbe=9;JcHOd.c4N+3(Z.Q:6[[1U30\^-8+.:OF_.TgEQGJU0
e_)PdWeJ,6IVZ^CegX8RNA=)6e@=DE5EXZ4K?ITLZN+bETbTKOQ/O>1S@>+QPU85
cJcC<?[PM-KE?c[a[51]Q1(TK9=L4<]2JDgRNWb,f@F_1K3IWLQ,d/F6V<,fW-OJ
K/eBT2PM5?V(OZ1^e&VgO[<TfILBETDVIdA&f&)^E1^:_J.b_Q0=fa1Z1B>B,3Xe
3b9\dV8HXRTXQ(?@R67C?#<T5$
`endprotected


     
// =============================================================================
 
`endif // GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV

