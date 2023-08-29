
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
/Da\)/e5Mfa1c.HR>Z.Q4CP1S[#@:,7CH6B,5[McM(f@(ef:?g?Z3)^FHYQLdA+4
CC0(<J:>:,f&SODP49,IFe2DNK<I?&FFgb](MbH_^]#BG5E_O/=[WXM9BX@_dNbG
FH5T^E2Q95X>]HI>07JeV1\7fWS)Xa/3Q_:YSH=Gb\Le:7CL62HPdCXLZQb216f5
4VEDHJDQQfIg[/77R_aY.DM]/+RRNc(GHR4LHSK&2gH5)0^8RWWAC>BBd\U=D^:B
-KD)WK2)H8(QADU8(90OH[@#+M;5C[T#;?.B#I=AY2=TDK3)PEa-YcN1<Z_I)@C-R$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
MZN1,:@FK58SEAb8_<bQNF3/Md2#8c9W=B&?ZdDAQ0;V/I/Q;FBJ,(N2#?a,_(?5
APaBL[S.7@0O0:?E-W2A?BP]66@>\PGPJ/W><F2-NAVE:U&M4PSe,W-><E,CXKg^
1UFK;G(gdI.V7fQcNRg0.QFOT=PIVI.+@OdHFQF-8ZT?eLUN/;fQ6(]DfCdJYcD#
&L43bf1]6JS4M9@,A\Rf+b6aQ;YX+cX7eeG(]Y[7gQb4D&6Fe68f4@;\)]aXN:c#
<\#Ye80Z(+</J,MV[KFXG5LYUAO^MRAT8cC=bS&/I]D:57dfA#>(gS=8a^2BQ=3]
R#@_#RSdV8R4^U(/EY;0@5/.7bL7T_caEc]FI,Ga3;:.CD9Ta(a1>#?^aJVFVBR?
H50OW^F]87X9a:bR>Z>#T:B@RMG,-?UUD/<LfeZUV/5>C+a8&N5N=58U?+IFG3I\
MM2Q-57e;VCK7.FgJ1N(Kb42B3CXWUPP=)G2L,NLVER>e1K3<fSg9:@:dZWg8IH]
df<cK[_N3@D6T\OK01aAe#8DKO/a4;?(P2f60Q7VI[?9TU@(>LE8/Z/5N_c6GB^g
=^SC?ORaC?TDRD3=<F(/U43G+G=?IL&BAIHT>5TJ=DcN?c&-8PLe9W]8TO:;ST[&
=IDdB4^K<ET@CJ=0d1#N&Zg[\4EM@8A_)NfKF13dU_KX^8^SQ[#<46SF8<g.XNI4
,MfZc(Y8[IVb40+e^aRZM0?A=#P>\fbb;<cVWa?FEeQN>&&4++OF^\H>UH#MFT#6
;+A@e51);0ED</dP?ETe765dC6),4:W7Re_JQ)4A>X6-(==,bF>1XO=\KE;OOI\W
=OFR6@#bS:XF=R?A4gGWRFCbf>Kb<EJWHY6@[C>[G3;-cXG49G^15)[Q@=f18\UM
C<X.=9A#E/,>I-eeN@RMUK#cfa-[(T1VE(WMC(K=1Bg\+0dS.AG31MEB_1(E9Q\I
^<0ZH30RM2??=QY=)-1aE:0Fdc;;#/J0F,C1D6,]:9Mb)C_g1H+F?L4RY&d=dK)=
?M(2PX+-SPgT/.FE22Tad/]?]T7XC1(Y:^>@9#@:8dbg;06>UGNT#\?XYN-a=VR4
c8a\g]KOI>A:#PZaGD\,]^]=Yf5::DB8/(T7G1eF3#.Y(3RQOI;@M0P[e#W.?;2X
d.4/;de@]6;UOAA6E/M&f8QfX[BWQSBW@+@86?,/AJa@C3TEKKf-&PEC3/Ja&AU[
bbJ<OPV5a4X#O9HZAG00_<F<eGHTSUg;9>.bgRR_c4[5?(AZKIUTV],NS]8GbX7.
/60GL?6=5HST(3TQ?eW5V8fV5WV^DWEg<YLL=bYf+R&,-]-O4a=9Q4QIG)BQ2.AX
EYP7/,>0f9A)K\62>/.EX&M&+YbW^O@Zc-:XXe+U,C<Fga(UMB8:SD.T_^eR)OMd
@[6F(Q(9,G8N:.XIP3<HIb:^<c^8V5Z.U:PPE[e:=W3)VD9gPY;(=fSC<4D7H=FU
8,N2TP9^(M5TZ1H3b&=[#2:IYDQe4PF+S[eHI.T59:+8LRe<1Xd^^.:Yb&UWP_-/
EF/+PS=3Oc8L<9.EHYJfIWINJV^.[<48PZ6e-N\d&WR);[/O2_BSC0\b.]4V8\VN
We:XB49#@0U(0+X.(RK[#09#e<WRHM^9AP=eg)=6c6SM&<d<[/.D1-OIS=TNb3HJ
1?^c9e>gKI0eGRZ2AV2E/f&O&8Q=YN([YI<3JgA@B8,OX^PA8c(/d/JVLDOR^/LZ
/_dG[3#d80-gg,cWXA2@ZeV1]XL+0#gJOPMTfP)Gd.-Y6T/^/P?P=L>-_S1451g_
VSdCS&L)30WWQ@IE7#R@e:\[:A@\R\eZQ_7=8/<V3E>IaTCI.QXW1aTB0A;LTcR9
.UGTY^QL^KF7d-^OZ:760<a9X,[;)2e4C?fSRO1g.EB/],f+DVdW2[+THE_C><Ua
-L@K2ORI(cX>Q^L[,9N6:)+VL+OY7^Y9QV)J>O&^HET6M.W)=I[6F2DNeR#U_GHY
X#3ZQ@X>NS6&;DGUD_V]G8CRI+E^gE>W32QZZ[;ZNLP.FOBZdGUFWdBX7RGFM1Hd
UOK+EXU.dGb]#8Q2-6\f)E[Y9a?^U:K<++TgV]@9#M@(5P&WV(0.7<JH/3HUe]GN
MLY5AXKNN:0(-_C[7aV&L-Y(2UO#OaJO=Ze.)IBI;[^/)R[AcSU2.D/M][PeK+].
T4c1c<(?6gA2ZReLeEDK+CR7N3>Hf>I;J27HDM@>949e=1I4PBV8NM]+V]_LH6?J
8GJF087J[CDU7gCKT?K\f\2SD)A.HOE=RUBCAg&)cOT&R7F6,]J<A-L]4=Ia(OC.
<@[TcS[D:H&2;RAL\ZCDS&M:7_/=AX9ea4U9aA/+HW2P[Z@#&N;P&#7@(,,..O41
UCfLMMQ5\N.FfNAC6@#B;?5YZB.257D(S6d[Q[Y+aY)L0aNLOUU6a-R0Cag5T#(V
6H^9W?1PR?R,)A=aHgfJ:G.]><)8QdL.HLW,Hd#ZMFN8bNaTA<-R?86#M#+(Se3)
5B#U<-.4&_3:caJCCCAMZZPe1?L3#B;DG3E<34J.T##W<PgO<]+GY2/P@6GMWK9@
gZ3g[/6(@-2<7/Z>KT-HeV\I)U.HERafAWE,f27>gB.]AGG;RbQ>)-e]1\cS;ON0
)6AA+-c)T;]QdNg+JAWMGg0c=\,];SdQ)7LV7+a^gZ5gUC#bJ.T=6Y7=IT5:cB=c
B=;N=5@WW;I?)8c/+b0J=RV:[6,:eBWYCD>I@MRX(#;<#,70GJC:FN[<#@Y@gd3@
YS^7Z2OBfUUZDR\cATKbC?&0=&a/VTJ,L)C[bXS1]6?:&77f_FR/R/f2J_YYg[>?
e]QGY_QOba/-03WFF(a\\,/5XcWNE^43:e4]a#5a+B4\>?:A\B((6UfJ89,^+FK^
Of;?C:5.I>/OYP.X0QH/5<VHY1UO?]TYVW)++_=^.FJ[2<B@.d^]9W90.T(;;06\
/&BIQ^3gOM[3?c4;A.c^Ha0(Va=U]A@#TK6-=>F<TL8J758Wf^b,HE2T<;\M>Cag
#;<OHQQACG9Sf,3PNF]DE5YHeb_,;@Gc]&d2-36,3AOK3=LWX)bN#B-cQFG^e@Cf
eI_GdgcBCgG6,cLMMA)MQJ(0V[eAE01+]-6=4-Oa?9=:1bg]CQI1-PZfDAUM7_?M
ZGPWC\0e<TJg#499eV.5\QBAF7OM=&/.Y.P2f92K,bg-B0bR\_9LeA&2FTXdcc46
/Idc<.]d;J>8cM-N@\:BK,/RXFB4&5:2<P^+E-]LW.A]6+bV?a?@?U&E91E7Y6^/
9^[\\2-&a+eDN(NReD@6;I9VcFM6>5-D+V;[W5Y:[36LV_#:)bT)X=7HDNg/7gT,
[&]71JF,>0aQ)6(7=cO7LT?8M5YOK,01EA-V:bG\KQ@/cgg[d0J,R.)O6(_,6T5L
6Tb0,e_#XIa&e7e&<0EIC]QL7JB/PBYXdKb+5>]eYHD4;-&cIC2e882H\8efdW6c
@DX.RY7+;+2M(6(554A/:,e6fbXFeE0PfIIHUMXe13bH3edG-2a#c1geVE5/N7_>
9b,d;3?<2B]4a810Ldf7g\?.cDIK.9&c?P3JJRSW[&_J@RKBV_KZ[G3S_0MO1\Jb
KM\>IR0K[:Q/LU9\C:>/(1ge;Q7](CFb4>->B&[N^a_DHR3=7R8KU:P?G>4U&R\[
X^ZVF=D48SZd.EH2QUJDH:cUWHGN_/GT?gd:/M3_QWf6Oe:,6dN0>K@<(-JEZ+:@
>T@F4CEFIU0fY8-FWD5^,6&3f3V5(0L:&:EZVD6?B@>C,Hc(SQT-2+G_RZ5<)PMU
V;cSHKK@d+3a548f,(Z=5UH<\K\S@aaH)G/8[8dL>RUDBK5US(26N+IGd]U<c2A4
@P7OXCPB]JVffQF^DR_S-GL9^2,><N>MAIEYC9OVB@TbP\QL\:V^+#@Z<Ae]8Yg\
HHT>LJ/7EU[?OG82b/Z)LeBZ4c&-f+O4=4D29EJ2f:E(H^&)GY;AeI/>R]+d;f)#
097+P<Fe(c0)QO[>ZO:D]M\E71\Y3EK7b1FTT)J?&(1E.C]9eXR:,@5&JM5cGIc/
.WdTUJV/,V\QF-(J4_?5[dPfU4_=H^]7;1C6G3c6fZ80Ua@>=e.bS?b9;dT]V:->
X-ZA)O6QMcdT_\^)TH-/2OObN]b&O#-Ja<@5PA1\eK#P:IKa=<:bZ\-#3a]^8>-G
HBHc<Z@X<\J::N9O\+K^&@]g]fX,BB.-1P;1T:fJ(WO(N^(/T7YYHLJWdJa<g@R<
WM&gZdUC^6/?JYY&C:O7f0f7R^aUNKdJO5)4=1.TQ,OL2d94PCd=eIO=3WL(]A&,
XQ8?4]7V.S?#?_WScSH4AN&V+4/CJVcdPWT3#EK:8d=_0?dX&,f2R<bOb8[-Z)bP
]SY)H-R?P77=)6=[UZ&T^eYU>XId=9]5NS,d1-O7-M5fDYd6c?;W,/)W?HA9GMDX
MHA@aH?^M7-YcE])S_):QYDQ<T3VTPf@(3?=Z+\.Md(??M;R_1M_b-XA@I1<ea,8
X0<[CS:3L1_:U>Ec>X[4YB&+QgZ[@\Y=R4eOTd8e3+O,-)3aDU1K#E2A?E&A-Pc_
<fO>0feU=5:>fdN55THXVGP=_PcR#,H,&_UUf@0aAG2:E.YV?B(-[OWeb93TaJJ_
.,T7A#^FcGJ98G+WFDXH;(2S4+,[@cUN1V^_1g#P[U<3?XD1a)Q\L0\Q,4#UcEH-
d0)H/N&fe,G66ZHPC+&T/fZ4UL10Y#7Z4)P)HQH/?46D?JX.;Q2BI9BURZ/IG@FL
GH25LDJD7Q^<4F[L?BONGG5.b:4E/QI#^QNa&<cRgX_aN2AL_/,f<_I6cT]YB1ec
N@42Se#?B,ABg5[T3=-.cY6A<OCf1d3==1/-33fCKKc^@U[I3Q&?FG;#,LA==>Q<
GS^5EBWA&Qc2c:I()3Wc^EPJ^,G;UB,+R&Ec(I7\HTd<Y2FY&5:g(&)[2]OY;0ZG
BP_T6b)4_)>5EI[X1e:QS;L.A]cUX[BX-63<=3(PO96<6K@Z9;W2=E<\=,:+?)/M
ID();5;K99:>aEd663KAB3C>\_1a.8e;N>SWAZ@6G3M6.-;04f1J+J#aWHNaaP&-
G,S<De/.+[W/UYZ;KO6DRK7cbP4b5:\GU^\2JbJOPMEg[J.E<8@9<;2<g::ee>aO
\VR[G7bdf7HK[)@2WdF;90g05;g9f+_dCEJU4g)]fL=[)^^A+:E((KeP[?WPa<2D
420[0M?QVUAZg5CGOC(L(eBc&(0C_^Y2OB<H7)SK(;NZW(7c;[+SHAQ_g:;:;@2@
82EBY/Q\#(Z1U1Q+AfdQ2^H>N;<;/e0R6+Fd>D&^B96)/\U4R)eF.]>)]0IE+X65
=4+CG\UI3S32O:&[SF1ZLH7c@@\RB<&[eR5J6T#PFPLP86^DgU=0B)[64R61OfF/
?Z5\1Q:5BK5Q=9LUb7AfH\-0<Wg0^=QML#@#H;VD0+N8N=IB&<9JdQZ_<.QE(J@M
(=<Dbf/4&2)RKcJ-.VS90^fN,e39dE@6_LRAN#a[7&U=,@eX1=aXR:HY/<S-XU->
RdO_Wg@a?^5Q(4+Y<GI&L?/I:MZ215ZZ,J#D5>1[##1g-V2A+#eNDbS(G):QT9bI
c^0(4c84Vc>6,(TW,&JV]fS7<YY-+NU;C_E^>I=O.\dXV+XA4R[Q4&@a6\RQ=\]R
PE+MBEL#2=JY40V1KIIIG2J@EKM&6>4NV3U1#V/fD1@gWD&K<RZC20(b^Tb.1TKJ
FA8V2^08TGACP#2^]Bd0S_P9-MLQ;<DIRYJSfWZ2^.:FUUZ0QAI/\La@/PaD4EW=
Qc8R_PGK>N[^YT+.@QCNBW^eE1\Xb<549K^,Z?[AfXBY1d8GVbUG=7/G:Q7R41Xe
+PVaSYMO&PM>TNbERC-Q+ZNL?H=d:c9]GFCP5_31YfFNYVMVDA:D6d?c7^e<OCP8
7Dd[=1C+bTggFX[DKK=EH_FJ89FPL5T09faL;88Tb<QO-O57NBS?3-0[/B-V8F,F
<>5&GJF[25@5V140_3/H@90A1Lf946EAPTIZaf4>E6Ae&GQXXF4?Q9\^Bg&DFfK,
F]\@a3dLG6cY10X,M#N6<(RI)@Vf\X]433bf;8U/B/a38>CHG0.,;fH@+>(&\GVD
>#-A>Wd@PPbF=aP0@Z63,QG(P(J8M>]UB/8e=?&#YdMXU@d[&=7T?WL#C@4KU3Wa
13_4BecOU=+@.(eDf;WW(d0R-S3f<QXH]]_B?TTe;]&Z&E6e)e+LMUe#CGLa1\F)
?XbdE78HMF02OKZ2AJ&VfW_Uc.S.b^5T:DZB56e;5)@PYG-9CKZ012H-XDA\fN70
S1D^O\7Q.3[(aI\/\O>gc:1?A\:_:RI8[[]5<-/CBN:Ka4=?2fP=7(0G<MF8UFF@
HY#_8Q:e4)#5#HW=Jf1^>CDa>450C7eHN5L]L_\O7PW88EC4Z(I?SGX22@\LQT>G
7]VX0e#7&?E?7(-A?+#FX>,,QIM<f[.Y:SWGKN)]c65@g16NP&D,4LS(0Z3<EJ,Z
D;.]KHX,RC6(JS1g@5Rc;P/LWc-E;>9-\5a:]AK(PHT-AK8:#U_b<S[&&,dRT&(S
KC#RNEU^7&5\G\@6a5H4L#V^\+@2.dN;89FN_6L+XKG8[0HJ]IE[>4,,#a?(DL]@
:,C/;^fa0?8EPP=<H2&@N;G#P(?M5W0X7MESAJgRQ6;7aGR9HaXQB?1;C#=4/73;
V>?fbeMIV9EZeeEd>5HM8\0TAW7gL(b6BY)_bS8J)SH^aN:HS@P>S/.AJRf5HNC,
fN8BMXZ:Z5gBHSe)U8VQKB-M)33WF2DF;IF\>_8[B:W[]9(KL#QG3dB3NH788]CW
0<XQ<EV?^CFcX^+XTZKAA[WVd(/=R?\6]+>=E]gW95=g7.W,Y9/UX+Q:Z9(Zc(g)
,O9TPR/G+CgFSC\Y/Q-E=??A0YN#aM,g6Ee;.P.4Z/]WK@_SY)dJESKXd:_F;+J7
.EEaUD]TMce)KSUJ\N(74Y1PX^4Y.,/PQM;KB#JMZ1)AG<.<:HW[BV<&)XOZ@,W+
gDUK,U]4RVR=+RX22REg\M>SV>0Ub[OKE]WO->&SFeeLeC7X[N63_14Q;XYV1T([
8eFICOZM@4OXL=8CD0W211Ee,e,QK(RO>WYXG9fbKDOdf/Nb29.@46+R?_F0BFDB
,K0X>+b>)E5S)B5#S4C95/ea0g0H+&=d(M.8#DX<4H2/:38,DQ3U<Yaa[/W2]A6#
?dX;GZ5E2Yg<)]&3U2)VT9(1ZP(9/QVMD5a^dbf&g^6T).0a8[=7[_;EgL->)FQ4
.<b4a7@G.09f_CJ9DT+;.67)UJ/0@EeeUa0B+Z(:#C(XE(+385S-f,LMW,HZbVO[
+OU7J7eFc/E>4.C)^V\YG[\9-:;SHKbNe+ONS>eY=ZAT7M1JRIVSNd&_cA^)X-c8
G#@(I6O[W2._(cMEJ[I#2#XKS/4-C;b)LJ>4A._E/O=-6)Zd_9+#cb4B?>B\K/8B
#/BTU+fADT^/c&\LSYXVE2E:;_b\b/PH=NV0@G.+[MR/,gdCZBc#cM.8^cc5EbKC
S]IFTfHLK&@d6\_57E_H8ZgR5A\d[:a/dK^YQ(:fBeBD\,4]cDQQbVEIA@B11OA#
c0J9T0\EA<45DL&c&U^2<g3N?X^N3BEBQ0AG,4?dN#bZ4&:+YU+.Eebb-+A-,TQ?
UAD6c(Q:aZ1_GU6A6Z\BAW&QX21(e&D+YF=XR@VM6/TSU69Pfe0I,+\2ICH_S.Lb
&-]>>(INf/;/5AHVO1TcJEF0LE\d--C.2K=P?N037PW4A\W[3XUW48:db#1WZH2)
-5#U+=dRGG6(,fc.=/E9RZ,\dM]10->5f:C1X,b_J#]9Uf/:P+0K5OJSR46K]7&/
U#aR@Xa[NNef:0\&>E=9Z+daSbfX7d^eZ]IMG^];=?W-&f3X3eND=O8>8<V/O?64
0&dL_V]O#OC;\XVgYI#YPc[)bYTMX8.dLXZM&d;IZM.\Vc=:2bfFW)c,C_V2;8#.
+V(S,PMDWa>ZXLY;b<XMR;K4G3=G+/6ACM^=1g_e0\2W-\4c+fINcN.A42?^Nf5G
Lg>LS<f?7LaZ*$
`endprotected


`endif // GUARD_SVT_APB_MASTER_SV



