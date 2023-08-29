
`ifndef GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


/**
    The master reg transaction class extends from the APB master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_apb_master_reg_transaction extends svt_apb_master_transaction;  

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_apb_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_apb_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
`protected
J7aM89Q>\S3]T<KB4\2-?T7EEB-5I19ASEcQLAJ)8FZ_g<2g0FHa/([E@CNOAG9^
OJ=@:.IXLgg:JO\#MD@3,;Ua234>.&)P-97[a&4Ze6.0SX3;+Xb(eAL[2AAJJcZ0
=D/bF4-UebIUJ6QRd?[2VP=\5=SbZ01>R#7BY<c1e;VR&0U/3.3gQJA5+:XB(OfB
_9]-+]X^:R]/S1@1dg1?6_RGN[)E+J>)8+]4d?,+1fB/D5&BY8Ra;?LO^PTLEEX\
c:GJFF=fV,<0D(#Q23JDO#20V)<-JI2U;GfSCWP;X@6GVS)U1UE^g-[6[EQC6_[b
NU::VdG6G12b#J7De5gA<J&5.)-N/>G(T9NG7)=.KXT&GgP1-?#:8Ra6=0?09fO9
HGcWZ<Ig6@(cYYG8=gFTdd6JHfb(C#W+GRa.@_g/?ILC&?OX.dU&2I4/JRWR1/GL
CPVT]cZYZ7J?N-]^48G(?)4[JO:\6WK1&[b:,.)\MXEVYCbRPcL#-aG9c.Y6gBXA
C@K(&>&RMBT;.,)Ng>OD#LM3+fDWDLW8MN)(?=e\LTF<DX,7,5=<9M7Ob9G#dafZ
UH\Ogg=+H9_)^J4Z0&AXE)(4G@Y2\^@@01VXOGHVZX:O#?Z<<;[bMeL-0&C6?AA3
_E^WE_UcLTdaPP<OAITa]?3VZeVLge9f:Y?W7AKF7#Z;?=>(>8KW_4:O(,Q5[LJE
H9Pb,/XSC3YW:S0eRH:VBPXGV/cE7Q?W<,c@<YKeD=S,=;dXO.1_M:,Na2]gI+Ze
Q/@K?#YggE6f>d7g#5/,RCXG2$
`endprotected
     
`protected
b9R?^O+1f_;.c3PO[3.D-g]M1T)+VM&]+&EBWPcS2Gd.BT&#^(/D6)V)08a/_T#b
]W?EgQKO>J0./$
`endprotected

//vcs_vip_protect
`protected
G&6[<W)\eRHC7LY=0776ELO6)U2YQ,YGV-)@J3U7P.GP7=<:6@[Y.(eZ9W3)>dVP
-eOXLEPc-]4;C3cU=<#:E.O62$
`endprotected
 

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`else
  `svt_vmm_data_new(svt_apb_master_reg_transaction)
    extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_apb_master_reg_transaction)
  `svt_data_member_end(svt_apb_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_apb_master_reg_transaction)      
`endif   
endclass



`protected
UN94?/<=::-K)YV89(\6AX]GFP[a2P5]gAd(VB#U;&OQDAZ]9-[Z.)/\C0/OL>^D
G>5V&M[6N7.H4<ZRYH5N,OT&4-SJ3.Cfc5&SF>8Q&^BG8-0#a<dNNRGff5X)>b_)
,VO8_Zd\Dg\=I6G07QTOC<.[A[XM[bRfWZ22X)Sce=JVL,3QPCJD2MH/AIL@&[,K
YVU27><@&CbA2BA/#>91NGR48?FIfJK_O4&I+&-YU;;Z=0GL>FO3NN+G^+AG]O.1
3OD>S]3<(<IG;\P^3<=a(2SF\6^Qgd_B57?CI\;T_T^N:MD=Z=H9^NS;NO5;A;DZ
=<g9B(dN7ZU]W#aDbYAJ-@G^&?I:RbPT]\aEd&;JR9P)=2NG:0@P8[4:4Y:dQ26W
f/C^MYU;>9D@LbAd^K<E&K_6+2K\I:,P3?&PPAaA412ARIR?G5_&@e]S0?5RDO4C
,/P@2BgZ@0Rffa4@[;[0eUO;S#Y4ZQcG5)OfL6XC6XZT=&B?c5;NYGd<,(H5IS;M
aRZLT?^QU1+Qa2UFIA]2Q&dFPT5NK06.bMSQB7APdOOcaXE:5_^ILXd^PDaW<\Sg
2(E&8YTAPHF;+=JG5gV4FEV=[6eV:G#&bf7^F=57>V,;#G=Y&H<8?]:Z5@;G+6?R
:,(XRPFLT@N0-TM[f6T,6QV=5$
`endprotected


     
// =============================================================================
 
`endif // GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


