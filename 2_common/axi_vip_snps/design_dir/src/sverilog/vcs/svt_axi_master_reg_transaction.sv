
`ifndef GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV

typedef class svt_axi_port_configuration;

/**
    The master reg transaction class extends from the AXI master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_axi_master_reg_transaction extends svt_axi_master_transaction;  

 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
`protected
9cCIc27#_]=/TCHVRWM8^N&Ob3>4B\@5g?5I<XH2Z1_KQgC)[;-:2(<a/++ER;QG
SNbd.M;JJ^ISMGG_31A56H@,+N<EL-M8LNg5)^2G&I-&Xg=A/b;++KFU?0FKcQ#5
S3.]5XS,TDUa3fG-]UJ@T,KARNR6bY8Zddgg3-[F3@&VGZ55)\P98@OQ+L+>#_]3
RI:4WDH445AfE,U0/@c5>9;;CYL381X[d49V.1=V@&PD8KQ31/V52LY3O]RM#_U_
J<I/d(a:98?)7WYTSHVJ9S>FX)Z1:<bRK]A):)>L6HQZ@@LS,1O=IggOU0/I_3^c
\;dg:6X#[Mc:-&b]8Q<6BHAM(RY20DXXdMa@76^B2@#L]0U#+a+:[PZ63B<_AY+R
e:Z92P[cK#])K:@++X-Ab@S4U(,FX>U>H_e#9CFE;2?JJ9=/#>1LB#F(-<OR+9U9
?4:_Ma&d?DGP\.T:a(M._fNW,U#Z4/^/CBWXJW>aP_[<1Q>]JcWP1<dHgW#6Z)P7
ga_9[7LYg0_Q[2N#\(eAP.TEg7O<VaFf7#,2]+RSTJH),#[Ga-dObP;+=XDUJ2UI
bV:#11Vc2/8K1+7EJVH;B)aYA)[cPCZJBB4E+4)C3O@SU/C8&bRQN+e;LL8bL[\T
F33P76EAXZXCfM13#d<>MQ;K)K?=5/^(I<GENB2W+O(YaD@<,77Z(2RXZDfJ3;Rc
A=OHC>3;X7(/SEc0NBB[e)bA&_ffe-9?,Ed@VWT\fR=d1A1e(\Y\e,F=5DKB7TPA
G^D2Y2+<U(A/6W-;;-88.O8\?_G<J6\69DTcEVC3<<[=70JE1?\M\Y35TLdRX-D0
P2(eVQ\>/76@KTUK5[07f]6-<KY17\e(314V+7Y19Bb&,CELdK_C\TDR_T?bSg@3
N4I==60K;#=JbF7FV:VZA(OaU?&4<TFg,I4;81IbK/Y<<-9TX2Ke?PS,12RMX(?f
L>f/fM:IG+BK+R3854YW@be0g-:]8B,L]f?-X;WD/MTVIZ@)g\^)\C<K4.XVQgE3
M#<JcV:.J:++,TXQI7e--7@UZD^g84K#,?ABPBFFI;]<[-Vb5AX;Gf6MQT,X.05N
(P2&-:a@=40PQHDZ+NbUH?RH/.F-\Kgg\B][N=@aEYE<F$
`endprotected
 

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_reg_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_reg_transaction)
  `svt_data_member_end(svt_axi_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_reg_transaction)      
`endif   
endclass



`protected
d1H;65D0H9?B1\Va6f_XS]/W3#<P-9Rd<1Ug1O(OX-,?R[1d]g;\&)/VFA+MN0aS
c>d-XCLN4J7d;>WY>EX5LXD<N;L;Z2+O/FY_3#JQWf=bP-gO[#<P=SJMI&=dF^D\
><a@[.UYH19[:YX0-HQAV6IUP5>A]^M,)Ua=.eC:OM?0Fe<6=Yc6-PgZ7cLFP1cg
BC=C##QSDe(K3gW1JB.)WJ.fONN+S/F2FJ1IAD6/&c>0QIZDaAN@K@^5g[>YOe<3
>+\Y\R;g)YZX.IF5^4G,IK(16:M+aVC4UU[C.4c?B2eXG;bD:db;88^);YEI:.Ec
V,MY)0Lg6SGZ2_?@6#F;-e@3O040XJ#a-:bOJFP<5VdeH;(0<[)LAea<D/3CSeK4
P+g/W84(b<Y)FY6ZAU?T=3&<T^.B3EL[Ca5]ZE-3(fIEU#((QY.4@W\H]5.fEg_]
5MAe8B]b2#VHa.7A7/E8eS^_)LBAR9_)OEZI&e;V6).JHH/VVYd38[:4N6P=GU(B
Sb;QH]Z1RK;]&f4#/(-d7W53],d>>>NMV1YX2\a]G4V?_4/NI:b+BH?+&ZaEXD.F
:P+Z]2AO-Q]b&<L&IO;1K6RP^LaKd().G2N]H#A7;Ra1/&VCNYB?NGS(533GGf/E
=<:VEYZga/1gJ-+1KfOHbFM/G#HII-+RJ/6O^A.Q<Ybg4;G_TW62JZ>4J^OOSH>+
6[P\G3^1[aE9>Dd:O8=HY#gG#a.GH<-1PZ0.J6\-b.B\NOK,eD4PV(&gV[6M[WS7
a=(X,7>/JQ4a.2Oc@ZPDN/<OV1/J5bfSeDUZ3J<ZCH++Fd/B]6J_1^<1dB5:2<CI
J+b)3I>6^Z?J#C6M<#_<UceI@RU#(-F+.UYcgVW2+UO)ZLLC2;fN@TE54-cA-3\8
)2\2fB3d87V7M.M]6A9I41[6XM1a3&SK>$
`endprotected


     
// =============================================================================
 
`endif // GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
