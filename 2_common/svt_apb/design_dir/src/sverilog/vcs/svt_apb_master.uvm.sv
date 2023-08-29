
`ifndef GUARD_SVT_APB_MASTER_SV
`define GUARD_SVT_APB_MASTER_SV

typedef class svt_apb_master_callback;
typedef svt_callbacks#(svt_apb_master,svt_apb_master_callback) svt_apb_master_callback_pool;
// =============================================================================
/**
 * This class is UVM/OVM Driver that implements an APB Master component.
 */
class svt_apb_master extends svt_driver #(svt_apb_master_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_master, svt_apb_master_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Master components */
  protected svt_apb_master_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_system_configuration cfg_snapshot;

  /**
   * Event triggers when master has driven the read transaction on the port interface 
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when master has completed transaction i.e. for WRITE 
   * transaction this events triggers once master receives the write response and 
   * for READ transaction  this event triggers when master has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_system_configuration cfg;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_master)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_apb_master", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
`ifdef SVT_UVM_TECHNOLOGY
  /** Report phase execution of the UVM component*/
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** Report phase execution of the OVM component*/
  extern virtual function void report();
`endif

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_seq_item_port(svt_phase phase);

/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_master_active_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual protected function void post_input_port_get(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_apb_transaction xact);

/** @endcond */

endclass

`protected
K;g36/1IQ(a[2:.@1:7\=6J0;U?]fGAV&=;1]\3]^[VK+X3bcU&H-)/FGQ@T;EN6
MH4?MHAe,d=]QX,]T^NE(5Yd3OI)d-d?8M##\8=#W9_B/3XHZdCG@I(RG&CNeO.T
g,VgV4)4\3?b?#Xf.&5ZUM4DREH3fO0MM7_?>CbId2TfCTUMI:2I3D\6)D>+WB[1
VI=EVG)>5G0PVYJeESYA;Cb^\CO\KfgeKQS@3OJY5Qa5\b^XA@O[+eXT(VS<GCdL
g5.D8GCa+H^M,6,>T#HI,UWOg576<Q\gW1VVANYJTYMf6GFE]S6^8Y@^]cf-#L^cR$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
J3a<e,T,gZD8D8bD=-V9RX/Z/EMO#\^WX9H/6fcTL4P-C=:ETW)c6(8VH@>E<Q-K
B)[3Db6=0XOS&J[4Y>0(/#VMRC>7X6#(]cENY4bRb9OE?:SCV&=a?>IPV2_YOM8L
T4->Ng2^A:RPZP.0]]WKDO/JT;DE+<>eMTXDZW)ZO9C.(JO^]LJag(e7CGZdP9[@
[e@CJTAN[(UA<HOPgHf#g&LJ[D+/Y.4?.:Q-.(S?Y\[0N49:6N2-ASOVJ(6=)[)R
:R)VgT)gSAG&6YJRbRW_e8G,dIZ^@cW4f.:AI4U<-N\\HIY454<3OdN,J4[?WG(<
7Q0O)]+]e3BV#3\LIV&2XZPT\IF;Z&/;^OV?\G5;2_d:CT2_\/@3HCN21X@+3X>e
^:]d25BG.D9Jb2@eO:YL94)-ZU;?U_NOU<9/P?4P77Y>38)RB88\dO-c]6J7(e_C
F0[&RIY-e?L>V#6&0-+gGH#QB#.O-KCT2B?VV&Ca[/N3SV>\b19?cT8N)-VFF?-K
(\.a[1bI-F,8(#\3@[T@>/G122)/gW8W;AEHW/?\d0PY9:5c[?3OfS5UF&<AQZW]
]C7P)g4-)-FWKcX\6^)c\eA^9H@6@g@B=\;L.(D<65JA;Q^:71IfN&d-a^\8(\@P
b3c]K]^]8.O(dTWB^83#LOX]5=OASU,E\G+Q)AMPFZ>bgLNY.2EVV.VO(=.43O66
OA69NUR8-IaDG4XH[0/.5AT/P>S^I3MU@E17G52<V@.8&V(<Zcf)Q3^L]TXg7d[G
2@F6=RcI(,WV<I-Tc&7#\b#.(BYA^E@U7]89RR_U1715NSQ:LU1Le\/aUG#H5BfY
<&dBP0D@S/:)+T^5GYaC^PZ?[b,?1E(=+RQIdc/ZNO>6f1S#\AZ;1?#PQ>>fHAKe
_Ke??32f2aR\U?aLTEI,bdS@XH12/fV13ZMdRJ66SOIS0DLa(4=CNbHeM:ZZ:b-K
VbWQZ=IB5XTYE-9D3&EBJ0QD>A(SY1X]Y+&UeRJNWY>J+g>dMZ(S&&D0JX9J1JNZ
_?5:bHT]AO=UI)P57_I:W?KV7,PGR,:bX4RFG@A^_H:\dMYgM-Ua;-=d>Wa>S/?T
L#/:JG\,OH-Q^1<,Q-P+,fQ2GS(c3#3;NQeM^V/^f5eE@Q]^gY=P_I#O@2@_7&PU
IU3F/)BC+d)Cc;OAX;MG:Q;616TaW]6f1)K\<(a<Uaf.LJNg<e2V>VF@EC&J8@YQ
42Z/N-Rbd4/[5XQ-Q,f49UJ]AY@AA#+HM(5G0>M,SF4OT>W-6HU&80=I]3?EHFOI
N/)b5IH(^=d5N3&9RC+KceMGI:J/L7Y\7LHgO:gd[7VJ0QMY>QaZc=0-Z_FBU]QY
/VA92E8YGC)SL9[A0RDTJY2<?<VG?JDQL_KL2K4).)N8]=U3U\S@13^=f:U>U8LY
A^6b0cER=6?RXV?[)V8;^C:]3\HRA8V@Oe:;G_SSf?;NQ+AW=B62.G-<;a&=/6\J
bEdB/B(4,#;_H;F&+-M]4+53A#GQ_V?-AU\HM^GJ)-1g2cEf8]9adCH^U(@_fX5.
X4:+P0N:(L[5M)03eFJLYAA_E2S(ULUUaO<3(?N]0(N&S...6E;X[7d-VL(AA3..
-Wfd>V5-5M/=^&/&bN/9M>S>HCa&47>fCDGTO5(_<8(A?&0V\I6/DB7RW20?<Y)#
QGPO7+PE<I@:JdJS4#6VOe=(2P3++bMO)eg8d:6ES7;](3<1VR3\R9W)DOW2<;G0
^BV)BgWL\:++3.aH19c,&>&P;]MHfe\H03_WYe5FY71[eb24bHg&MBPFJRRbFL29
&+K+08O2NDA@Pf:<K5:&1<&c7UIf/X>G;.O/SJ6e0C3==DZd;_(T;8^1I[a:?M=B
SYKCU<?XIbM^>\ePKaeOdQ.<)JP(DSW[7Z0W6@c]6g2@U+6Yaa=-5(27JX(UgfKJ
M#K?6G.?@Z6O)<-T?UaK7X4U__T8&KI5M]B9,Q-/XHXO9MN7XH#[@SP4TG&C;8=+
\I+YY^4=GM9g8FWQ5B3XR=J1fY)FT2^]Z(:GNEg)+,0a][R8Af(4c;U<IGd1-.[X
1[,AC=Jf[[C39?3NUPW]:H(]01B0BJL@?]&L7=#^FXRP/,;YJN>/T9/F=76I07g1
CMN8Q<P,Q4L&T_QbWB9]#5-cR^,+6@]2UPQ7>c<LdUQ/Y11H9TE]57Mb6[)@J0ZJ
(>@R]V?UBY33gB\N]<D,7Ua;P9J3&1;&@^S1X5Z84cV>1cK89dadO604C;#&(-,&
(@YY/9cCB\OaM&NbLA<3(dg;\B:3GT#-IPNHT)d+S<=V5QY8(MHe#0.ObYLFF<H7
EM:Q&13831Ef^\C5(LMXITM8:(b#(WI\P_#@E8/?=^#O[Y5]7eWb-,Sc8^;Y^g[_
1Zg936@GSD_R\dU3]#?Z(:9,=))9KNMUBAV.#_.g_)0Td[^>7aE)]cY?>6)X8\)X
fdGPNJOZbS;:..CT^2]054IPZ/K/^T2.2:.=eKfF=&S7THPZW>ge)-7L6/FG[4#)
(T5b(KTZZ219_XN#L2T1([TGR\f>PdZ7;gZF3#IdSL;9MXNH&XF#_)TZR;9#\:OA
>Q0HA#&Vd7LS0KULM,fcfL2,SUcAT(B]46Dc+T\?TM<(8+bY@OHZZP3Z0Z<8=QW#
YDA.)G4DQ&=.YRK+/5F=P&K^#A[SOH#X?PHPb0Y4H#Vc9T-T?eWPC<FNM45WgffR
Y(WMA;S4NI790f_40OG)P_O1A([QIeJ7AK(.(MF2(-<(g0:b92WaS2c.gJL4AJQf
MT,9U).]F:.R=2WUN\T-SDS/X;8]T+=FA&6P4UD)/X(&\Yc#XEbbJYc;d.H:fU/5
2ASf5JYORZ59YN_JQeNZVX+ZSgFG9/8P/-@:K[LFFd[\dEd;C]W5ECKJMC5.^#&T
W_E)2T>Y21ZZTS0fA]T/9e_(Y=^8,a1[]96_bIU.^+ZI7K5CIFY-F03>I>0FW,[a
a&a2O<@63gSJbc-9/=aMcJ14Hc/;dXLJa@#ZWX[4;a+C[QdMZ-83B7,_G_AXV^1F
RSV2.YR,.[@1#fdTaRV3cZ6G2.G1f,I.UVP5b4L5.7Z_JC:OD5J5dRMFC=/L.e^Q
LM]:+<\R8d113b>>ga2f.UbT]22P^T-7UKAR&66\4^7gIQNW,A/(];)3F_)2:_,S
@Ua@97](+U42.b2]0N5+9N/G5F2FKcc9bL]TXF\ATCS_QDI6LJ66,?HXaLWW>([K
J6->:>;eBVYWLM.fBA3=#YKf;5>/[Y+Q;0?d1C5[+):I&DM9F7Se2G^-.ZEWZ5B9
fP&/[YG)&HURX:P=_M;CG;+bA<BWgB8&]L32IT@CWK017U\9B0Id+>0a2+GKNLVW
D5f4HbGO[YWD#G^0J=DZ3NCe4EFN^+0>H)Wc=AUC+M2?/eIVZ_9+\AKJc7:Z6EO7
9OQHCc^.]e8?4Ba4dL?#a=KQRT?D]a?d6(.6<KeLP-S=dHcJ)YNPSFOI>TH6SU+M
@8]e>J]#3;N:_##,RY8Ae:=6]AdD&:fBbeP?C81a_b8\a0F@(F#9E6-EfZO75;ZQ
I)/;S;[8;O_M:2/BCYL/W/e3FU6#OMaJSS?;Z_??G=O::\@&.N:HL/)4H.B-=K?O
ZcD16MbgO-/GUc;M4b#\PU72DdC(KTVK+PII,9,Id;NPD(+>3c^.dQZXFLMXP)Q(
43XgUW?@]K9;(.+0CMNe6EV1J16V+:IK)\;<1W7\OfP_KC4[ZZ;]g4T6<,GA\L8^
1YGbS;Q]Q+^_@=QHCY4@7fE.G)4-=5]Y+2]]e02>@0Ac0Fe.<D8W/aJ#d72gg;O)
XEJ876GBXV1QfAX@9XVbVV-ZQJH<A:5^>8LVIe_@RdV7^f:^1^<V]F&Nf9f.-LF8
caXO7c48dAP>L9(cX6Uf2<DTf9T6EPCeRV_83_E-J<Q(+dI>6@B4fa[f]/aC-7_L
OBO)PH2/gK]8G.>Cf_e[HFHDA).)B?WaT#-7@#,Z5IbC?+<=L;:->8=W&eKO<J:)
RY+G#abU&YD9.Fea-WW^+&JEbC5B,Y[<H77J/((.#CXWccAT;O+Z[KF<2^]HaRcH
bCaf-[[=d;5c6K=,bYXcd1?TV0eV0O2]<@GW6XNN(KWL#C/<Nf#IMJ1f-8-V^W[H
KV>&9YZ.:Zd9I:V:eUd((T0?)/SV@_X-/5(11#PZLP(TYRZFG(S/#E;[GUOI5R-0
TZNg55LT#fbTUQO-VX[Q:PaV_OD+DU]KO0bf)9[Me.7/Dea<DS_>XZ&bS3aC,6W]
W^YTO=c7W)S?KZgW+<AT?0ZJEQ0(M/LFLHVZ&)B^FM-F[_IF/TVUBMf?_5(I6JZd
98SW4#^55EbMgW;G,1bd(Fd90.I-^8J/4[<KXZ:3TbKAaDYc;UTe\Y=Zb.aI&(JJ
+GG/J>-1&N@^gU+-LaKPU#7S_Z7KL1>M:D\^)=#D_:FB]a6-\.AQ1?]ED_IYTQFQ
?c273>9N>K&8(gUfMeQf:151V#UfKR^C&V<Z105R<^1aL[JX3^fZ4d-CL(MW7RNX
_DSLF:Y3^#T.c4cCDLde:R:WD^(gNH2c[-KaUMU^\V9;\J;M:;,cLBVDS8.Z;EV\
a?PCcP.3(CMN9(G/HeNKM7N5@LFJH-I[),-K^YQ5Nc?8U>c?]b6R#/aH)355UaG/
T\5MZ=:]+e7>5E52g;Fa>aITFA<3:cG\Paa?FZ#.M4X#EY4E5A;)@=H)C55?V0(>
PZM:>(]^O0c?[d];2cZ=9_E91&8W7gccIgMERKgT,UU(FR)F0,0UW3RZ#8\SDQP:
>UI)9bgHH-BL76[]Ac/7_YI-HJP=TXB]Sf;SaIT+?I&^G8JA^E4R]\=c;<&?4QGR
/IFP:#[4J)T:a4^1^](0V2K@U>BQ2N7T.X<IWbY<LMU)(E//&)==Fc0/&gYY5UfH
gf&QT#=f.d.ccSf2>^)@f-3\/]8Yaa<,1&[fPM[SOWI/X[Z&8\_\AOMXM=6dP9<P
.E@122-X@#9B>:>B03Sc=RYc_85[DA]Z0.eP3[Bd-@Xf8]H2ND#Oe]PVH5O^28HA
XSZ1P61LD7C?18OGD_3,c[05WX42I1CIIVS8QO?U)J\^M^Kd])YI2SK:K9YGF\9R
aR&<(105V],?X?MCKFIHTEBVc5(YdG1fD(3g]4+#aQ.,a4CA;8X(0N8DHcW\eHO[
<9FYGW?TC_DX<.g>b787J5X4Y,?FHAU-&JbG(2JYD>Z#]ST<Ub_>_<?+He^f#<(B
8V52SZ+eP\CV9c[Ga[_FMcCQ#OLV01\Fc6.0(H-0&=4eLJ39fKB@TQ2/C7_0PD:e
[WK5bXQ:/3HED2P)[2&d?9RcdNPNH254KS_;-#A0#=M=_dY/G+Ef?dYN;D9P>P(_
a6N->M6e6-gS9cLSKQ,(\9TdOAbNB4f)-\F7(cR#:38[[&Gc?W&_M:#YI:AK:C31
8&S?3d<HYCCLe1QeeO&XgL:\/QL0e2aCc,UAG9LK1LbT2BGMDcW.LH)S/9T@3.[@
26dX(.^a\^/>1VU[cSLOfDM0QNe?KSZf5[_#&6&0XXb?=fM,C?0&I]&I#=K@a8K0
M=DAR-Nd@MBC1d2@XS13/FSe9U__8ENgHE3b(/aS7DU=L4.ZDZ0Q&ZL8T/<gKS(8
VG/22ZD;&6J:GX,eF/F@44FCaB.0KGS#47)HJY0B2+-HaSI4:-K2XA:,OBOg/8AT
=I6A,@00T(J/E/-0N;9.C91MVWCf;#_54\Ig7=>3P@eETC^gTL2BZA?G_D6)E..=
P?U7[.7X;Q7M9420gD,ZC/6c:2MZ+7NgM3=__U2<E7@?-04--5F4)P)\,R-MFG^R
O#,XNY6VF&[C5fWQ/1^cMT4:F0Jg(3S3QC6c]P#bISf,N\KENDF],K?7(.Sa/]da
fNH]:->:X0.EbDA3YVH2CWA(-O&.MA8=Z3Jg[Z>daeG5Db9G6AV>2JBdRE?A.]9A
00@35P=MBFOaLD\+\BUV9cA.e8Z+6L#?IV?FFL(3=4a5Q96NYNXJb(<?FTQ@=.EB
C96B1b?P(97U(@faH/(UL0,AF=H.:g5cZbTO)+Q#Dg<0Ne#Y)XBAL6eVM@c=C4+M
-a>-D?OK->,9#4Q:0Nd1GB?7-b>e:b;,37cS7dId.Fc+8JLTS&(1b=fe/Yabb/<F
LJ_I@f0=SR_2G)U^T1D59SdT[3,L8a;Bb\<5LdPc7<c>:NK?=1\)cK=Q13_aU?E;
^@H?QZY,0ZQ,Oe:-#Sc#SaIeCT8T]M/@.1/0(/gP)^fZ,90?Yb,&U?>G1c5.Z6A)
.5.D&d3L2B+_TQ?_eA]U=T+D=)8+:F1]\5;,^5GPBA9#Zc:4])EU?J:NGZE/Xf[>
S<CWRKA(;H,S#aSe/.4b]-D=[QV-7Ab3&M8fH9e=6J,)I2G.110+YDa]S[.P[AT?
B>dL8\Z7G5]W1K(0VfIIP1QVG(F04,Cg_O#?NA103E)&PZDaI2C@bJ)<-F[JVRUH
<?7O8A)\O7aW)@\P-Q/Gf__+(#6&H30eIU\:[O\4>@9B264-;<;I\EH=UQ^N1)Z]
7dR@dOLVW#A6c25KYG8][87I_-SH/-?X/[HN-8QL24-D[:7abW2BGA)7W-8VT&J9
KW-aDQCddU#UP9e&BWDG_AFT5:K;>bWW91f#DPDUD(Re86S3EA:<5#)4,#_O_RKa
F[7&bV9FSbK-?1f[KD;2E0Ic0_FBW233>?f<_8>QZDBD/3E7[[+V]QIX(,f,:?>&
<S#FHY<Q0SDd7TSVT[NM=+<fK=c8A&Ke[W3/0SgSBGA\3CYH-C99c.R0),2_6<=?
F)7eT,U-f#OJ=T?T-34T9UQc_e96JH8REP=/3N1V3V)]D,>5J+f<H_.-b28>YXYa
R](#-9(0Yg28J#\B+A7##-&IP3):dH[EU,F.;d[-\aIY9NIBAVZ-HTRTT728;fB.
VIFC_ZH<P/KKDWXR3MY\3FHSU9MbZS=a-1)c@MV[GQYPPg#<1C<6J)@D^)CK;8(@
cWO5RgD>Y^AO?[]+#TCU[7^A<\FZV,-?.DN1GYB)QVb7W+a(M)J3GD:COUfOJ+/Y
SX9a;YdMe@dWdZ,JGLUW>X3S+:B2/2,M?fMA>YEZ^]H_U=R0BH&213=P#b](;cgK
:\Qg.ILf>DH:.RRBC;8)L4R&5_.N&]S=X6#2N#?eY&@BSdPSM0RW\g:dLZVA+P6Z
^U-@TF@UgZ\Y-+gc?g0MSFaM7YJX])M&-EH,EHG[3MWQ5S\9GWMF+KB+C<,[DTUG
3CUPLS_b#;J,QV/fK2EC2WH0)P0Wa5R[YQaRd^_VN\X:]ME:W&00J?#D3UDKN\)Y
1VfH>f=06&_PD<d6GL:]YdU5NUeH;,(;49W2cB\1T_)B:M@8\5b=5fXR@QYYgHe.
f;YY3=<L:;&.ggLOL_JDE+S4KY(K+H(^I)W>FA_5-M]1D&W6LT1[?=\@3XM+CGMT
b:Q]M,G?5]I;UUV+;c5=)N&SA0=f-+(FLgM=;M/+9@S>bMJ&:]bOBX85DcNY/ZIN
=9+J3:]@Rf[7S>PR<GD14\Ce+8c\.A?IfZE7>K]bWN-BKAb[37MB3TL\A9Gg-(6I
L(Eae).XB5:RS0_)E?fe,9I+3bPB0CeQL);(UDA1PX2:QYa7TB=GG-GbYT3]:>LC
89KR6YZbdYbJSca4:23:A0,P],ce>C7__J?K3BF.e^</<DEOeI6[TLSD/g5cd9<>
>]<R5Y85N8M4R<Oc>CZ9,0_++]5F-<F3?eCJ.C7F7#/<C+2b-(I:fGcW?def29WU
0gd1(eZALC5=D0&^C5QP2e_DC9GDNOX.:GN;ZQ91(c67>Y,1]&QV\DIRX;,3aGQT
B4?+9(@]RJ99OAgJJ:A2g@f8QcX9(?6&@-,AF36Y?2P_\+(B,FP3PLa\D.FF?;(9
1HVMG?0GZ_W0II2JWFPOT=B&XVT86WLD6]]IMPT@C/9Z#d#_P.6>(510+Q,f8OM]
a,T1b#QK/:W7#GA@GaISI,U<Q@Y2d0?O@3\DUU:;>[.+;N_egaUE.^CBP(Z=RY;F
eV0G>G1fN;MMO@O@VG@FUMX;2b7@7IBU#ALTOR,0Y31^B#f];;RD5e+J-5:XO#eI
VDK,P.-[F&<M*$
`endprotected


`endif // GUARD_SVT_APB_MASTER_SV



