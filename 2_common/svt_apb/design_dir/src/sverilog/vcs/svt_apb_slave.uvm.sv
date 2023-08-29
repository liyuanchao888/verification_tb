
`ifndef GUARD_SVT_APB_SLAVE_SV
`define GUARD_SVT_APB_SLAVE_SV

typedef class svt_apb_slave_callback;
typedef svt_callbacks#(svt_apb_slave,svt_apb_slave_callback) svt_apb_slave_callback_pool;
// =============================================================================
/**
 * This class is UVM/OVM Driver that implements an APB Slave component.
 */
class svt_apb_slave extends svt_driver #(svt_apb_slave_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_slave, svt_apb_slave_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave components */
  protected svt_apb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  /**
   * Event triggers when slave has driven the read transaction on the port interface 
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when slave has completed transaction i.e. for WRITE 
   * transaction this events triggers once slave receives the write response and 
   * for READ transaction  this event triggers when slave has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_slave)
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
  extern function new (string name = "svt_apb_slave", `SVT_XVM(component) parent = null);

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
  
  /** Report phase execution of the UVM/OVM component*/
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
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
  extern function void set_common(svt_apb_slave_active_common common);

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
7J21bFZ7YMA\9?C#EDZKHEP1733\bM]1?/)IE-]IE4^.?(JS\g_f1)CJ?0_;+R<c
2Gc;V1L_e-^#_ND;4]JR]<3P@c:3N[B^M0V4-LI95PGG[2411C1cO#Xd3^HEJ+NC
c#fb/W:6^G/VR.P&ff)5]?7<[b=DYg&L8f=C?EK+8.YI]HLTQRc58WbKOCJ,W.FH
]HDSXGQ?d)+7CQ&DbVHV+I-7KE_d4=1_WLCR24e[f91RR.4=dfWbbFS@6-=VM9S?
?1H.P^.E_ZEEa46ILF<Ng8JW3ZB-4R=>,5eHKOU(/1O<e@e4Q2dYRRS@P$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
.+Xa5LR30@fdP86Y\YAM;@@2>>[7LE+SZf2IX:[]A5d[.ATgd/Qf,(4U@ad.(F=F
&Q=@KEC6F0,&SV/(QE-F_G7A)AB<S?73O(Y2OHa:_L/JJ[WM6eVLXPHCG4LSP<R\
70_VgMQSYD/eOORB9Y<S1<CGf1J9D^OE2R17AF,B]8@3\H_7>DEW#YaZIHBaCE9U
3W19Mg.dJe8,=T\>(c:2g@T9&4L]TN51QZ5M>+^)PXKc5B/I=cCX-\3ZQ0IU;A8N
)3YY5GKLU4<T:@47LT;6\8I_>-/6L30LcJg,_40?[fG81ReG?<aeL7gfPD7ER[T\
])-1I8JI,,(,)51BSO6BaNW&:9FaEYL/SN4:g@WA03WFPPef<6(+/:.aNKN;8b@;
EQ#:[ZI0\?EI7MZ1II[c)E;,?0><J@=1K=&QGeX3.<da1KQ8Gc01(Ld<(5YRL;/F
bMB[^C<>(6X9;IeURVC)cXYd;;&>5R<\NLd@K)g,fS#YN^Vga/.fWfF&5W5=WZLW
R<82D.8]e0cIO/)27b)>)N/c);9Z:RRI#?b^MGMIPb^>a_DPG#4]<,3:,eZ>3H]Y
O(GGfGg><GNTQ\19+-c:M&ZP#S//0>76_ER9+58OZ?3>:@Wd#6IBH^2Z(ECTK4\a
b\R+e\.V)age-0HID+EAZ1N=[RJS99[H@O:C4^K1ZVA^QE^b39I_JL-AB3#PbWR;
^TS#QH[A0IX:]QP)b:;YL),KU0J)UG6Y.f(YO3V#WQbd9ITPTDK1Y=Q5\[X:_,R2
EI/cJ/9UL8B3JZ9/F[K+VQZMaF51_J9fE,g5:]4-[7:Jb&e4&b[dJ43)LI-(.[K)
35JECK.YH32fPL:2_^3FL,3CC6.-PM/NWXgUB?0aQ^W-be6#6Agd2UWc50LB,?eL
U,WW]M;RO-V\R;FFUC]\d4=Ofd^+)&C9<c;Z>6]-/9N--5a(Z)C)5WP>A]AaKH/f
]R-BbcE\+:RL]>^>8H[JDFfU#FJR(]ZT_e,23;)DK-c9c?<Q?+QUS;)2:A_G\&/P
]KCOPL#A+/eZ[U]MZQWT8\[BKOKA^\J&.R.<I94eQNP4gLeF7BXHC<1LVMVbD6CY
aF6FWW1]9S2&a#K0LF(G-0&4@509GB-LP_=QUgPYZ#b)_cD4//1c_QE]SE-(;GSd
H),W/HY8E-?]W,.Me2FQ[_4YOQ[\T4X:9Z0M)NG0N&+BZ,<G:AH-G5D72:)IU=BJ
<?4>.NXLA1LMLMVdbK2EH?fTI\C;g]K=.EPFZEVE;?9g^5^GC5b0K+b[V-0>bKU(
]C,U:V.=OWLE++G4@4PRWMId@P3L\18\EN0Fd,J>4IY/<U7XIf0PUSGP7@7FNW]5
9:CBe3DH;;.).QK&ITSIV:E,10^9>G)JW3_U.aY6>S\fWR1^8<WBce9BM7;>gD\)
H?Zg)NT]L_O3J?AGZEP:UL):D6<;4B)XPY+_8&cVg&]:Ba+3J.W/#FA2:bXBL/K^
4A2/HJ94)d^99bTfcZU;AGbTM8_KL-;e3WV>6I_0-M^S:3\E=K8cBBAK(M>34268
Acc;@J9-T[VVL]7#A#2)+4\=HM>[GJ):3/02DYL=&bd?YO+06UB3ZH)dA\;2UfEY
O(?_TXfM#T.e=H0,eTMF4EB8/\aI0UM3VbX.JH4PdH_cRbN6-b/bC>CQOUX/HC=C
:#GX[QP-X7.R4cAHVQ@b7:C^I&=/e1(L\01<MPG@g<5;[fV>Z2R3?VR(f^F6>dF&
JPCB\L:>EX&?LE8\+=Q(IX8)\YFRAL^e;Wd.[cR?,[S]H]^c2&2,:F4QC@VHSFM[
/+=1g_JQL^cU&=<8f)Ug:1-ZJKO9WceK3f@N\Z=,MTaTUdQ<b+cgA0_fRZ<#V8Ga
1\MS>,=Da\Ag+4\CQRK98&>.7)1K7R:1S9\fL&K)#/#5cWQ)YOKQZa_XHQX4TcEC
5Caa?AaEH6+,,Q-H1S7@_]<7/P6dVKf5D1^^DJ_5=eWRd7&05()I?Y4CIN.b[Z7>
&?fX\ZT8KL^@Va)^8AaPN8^eB,,8-G1c]X:T+(&.2_@4&g]9FdDO,Q^Vc&<8#;1T
ad43E9+VT\O<54PYP8[T(E)0S.;;H>aQ=8^3J5EA[/e1c?C(BR71E+<7NGD2-SO<
fYO/BCKS-I3OPCW5R9\@Z+?f.Bg8d<.^4eH29_=X.P;cVJ[J#?>DfI0\BLF,50Y0
W,][R5Qe1XLdM-:XM5X]]fCU<B+dDR[-U@b^272F\>#&H=QKB6+R>W:bAM)[6OLd
#_VY\^CC<c-DC1:^eS)f>46AL;fOD(J:OOTR]1G7-bKNJggeYHR0F.W/]ITPJRPG
0?SAQI^K9P_0KZ#;]&)/J@J5T&-=@MY+MN4SXPW^HKP,DD2@4>46Ef=/4?7a?H\+
&;^K-2dMJ71Y@3.02cK_#-geO8b9S@2030FbBRMTb=_)SWY8#/WMXaRF:Q:dG4=R
bT4CVI:2[WOgCbVHWDSOJZPKJ5AZ\TQ@cbb40TG/@A5>V:0b4-]P8:5W@4Q+-bcB
93a&#UM]^N6#,TF;\aDf>Y>F2A2gY@YWeV7#IV=_0<U,15[+.;KKD<7+V4NZ?#P3
&fGf\;)C00@[B[5/>;UF+?OBPG8G]^3PB)-WgFOY^1,Y<f,;.&?5S\6fPWFLfNG1
7&a)(</09afW]4IK5E<<M+XZfJQL;R-TOQ^/IL]bN:1MO_d?eU3OH[LZNT15B+Kf
/4JMW32=KWbV)Z2,ISUFSL)Pf;?e2@<7PE,L<8WHMJ,\4d+VP<(6Eb028BB=eDaf
(Q>=Y8QW\FaRKN<(C)Q&JULVFEXV9Y:gcdOD^ZD[0g58@_3QQ4(bP;]S<ZQ>VT[.
a\R,eOf5SUURS4[T@<GYf2UaaMa@H_6/>@P&(WeE@ZCT06A#LCDSZ(U].]K3.IGT
eU^AH#f6#Te-:)26H9WWa6&>G73-+OTS_:AAAJ^U\GdfKg&U[),=K\1Lb@U9::DN
5Qb7MM@IYbUJYVK>\&8D4#Ua:C><C:?M^)8)a-08@6b];-7LBXP=SIV/a+a&DLH8
]S?DINE(&6991-QD7(KPg46=4TccYSPKC7P\92H>I.L1a_(FRT#1TK(1S7g#+0>Y
=;OBSBGYWG7Z#aeC^Z@8FWKY3e,KeVNJB6Nf]?IKde3LRZW3.UdgaE2J_55+,C1b
M>,\d#W4U/BRC;>cB-C);RWIYP=I?H@,A8TXY#3g)@d\bR]/N&>1UB?5V96+.T]D
NZZD&LQP0#FPfN;cVJ_(@W=I.8RS1^aRg]c)-GgW1]348gN>aFA+^\g=4gBTbHN5
?.bWP:Z(CAF5Y:(;5D#CRJDE8;J4/AJ)Mg/d33A>bP:E28)KE9BNXSYP-_+?9Tg^
7X+3N8FN=K7SVMQ;\dE]0]1W<M58:JU-YMYN#0#c,Q=V[/LZf96J4-F5&1^NKSUg
;T.(G3T<f4[^BIgZ)UI(6(U\,,>Xb_SgT+8OD(I,]PUeO:gK\7c9I-cIc;P^VdY0
\1\H_2#7)J@=<f](+Q?Z<1,UKN;N_2M&c3b.&=@T#I5Sd;ZeN;#cBLB\V1.YO9fL
ZL^)HMc[C4LG92WJQO>85Zb+c2P2(?79Fd\\7Pe(54(PSbcdK3N6M:a:D@(OJ1+S
fJ5V@e-XE7E]52.1V+Mg/e?YagMM13>S76dF5b.=b]-Ic)A73gIe7<aYB2<>-Q;M
L^V\ZCI]SKLE0@<eLHZb/Fd2.=Y5&G4e/A,:79.K+BJ[BA#?7_-/92c=]7#IQKO@
T_3#U+FQYH@O2[8XUB;D5QA9=??,7,<3H:BB8KMafR,cPD7:=0bENg[C\U/LI>K>
Xd9X#-A=1SfA/V+=2g8d[LWd>>88.f:QU)aQKW3g&.MB<b[I9@Z_,cOILW8.:gR2
<3RC/KWc[1/Z2G0VSGcP18b8Ja?=YV5K8X,H?c4AT\K:@A7WFA/Bc2NdBgPF@/CN
C9dU>KI_.g33g;Y_)-+3eae/>/3U,H?<1d#YgO1[&\,QWe,L^MfC4?,SMFQDCN=A
fIO>\ab3\]AB]QZ97^I4,VUT]+4M&\#;WU#WN@EEXEa_X7.=aU^\-9K:NA72BY96
CS9BbA<H->DM(XHB-V#84Y8N;\12RX7XPbaDf7B+=AY?VA4D\8\DgAQeK-J8=F@[
O++bB:8N06T(YbW?#CA<dTB?A^S2.be0TJ7I,NIP+/>BYU-)[C@DJ^:Sg[V;4aac
[DEH1PXZe.d[_@3XU6)\e>@DPZ/g4FYD5RF/M3H]EIHPbUbPCa?e&0<W8NMg[dd3
UYbG7/M[6X)YKW6?PQ_?AE#MGZcSbB/[82dS]/)MF[5(NWP<d[Mg2XSC7g&PGGL(
bUR9XG.Y?/LFc032X:SIJef/<Ba\H2d1#.[H47e2P?(VL15=[XVQ#B.GU)X?g>@7
3HK):DQ.:f<7,FQLfa#Y&&;JN(KXPT]?#9=X.JYWUJ)]AQTRTKU:g/M+:aO=(DY>
NW8+=83ZCP8.8&+XbFa)SQ^3H&#DY[@43Jdf,ccWSS(?UX(QN#?FYM@UR]7V7PQ6
Qb&4\R57RZ9?[Dc&P:)5&b@NP9L)OV.8?CL;cHC+(NPDeBc;(aUg_K[-S,<JGUU\
Y98J54D&<26=UTf@gUU)2OIB#b0E_eL>,@PF9WM#eQ(_=3FB-8Y=,VT/gf&22fV&
42M64R3-2&60JYWX5/T9(TQ(4DWH[NNUHcYdVd]-H&CBVRNH&VXM;b_Od:T<BdB,
bJ<Q^D/]4/KY>.A]BDeO7AAQ/4[d8W:L?AWf4XVWK//[eB,gANe;94^V\b3PKH31
Sa27W9.?-g?]NJBY7Lc15gP9_Web+Md]Y\G,L0&7?gA=Q[HTBbI6dd(Q<aLNYKGE
dPDEEVB^6\UXR>L7N/5#>EXJ#<(bHGBOd-PcJ&<^HYNN/+;EdcVX]YN61PXOEB>^
]3;3.MBe=O450BIZ/;T_>6417b?PEXKY:W^_;JD/Y0#KJ51JcfHTBJ2+WN<Q-1@,
WBV3WMHcV.G3feJU8.I)dL=,eE(MCHXdDI,>QV@(QT;F[W;=+N;PJ&Wf-T)JJObJ
HKFBWJN\Gb@K@Ad5JF8gM(YJG3C[V,[1AU&a7&?Zg,X5/S)F.N6+g_fgFDVIP@/;
1#92A4=HCH^6IY]0PLJXJGW>a/>R_Vc,FU)&?RFO=ES:JB24]>P\3(<DGXE^-\dG
J56X[1dM[XV+a&LDM&OSO<LBMOD+]@/IY0P^aW@1U[3;5S1E(SUe#beG1bGJf\V:
?3/&W=G^(:2UMUAJSH7()1@6CY2&M_>&.bY.X0-WABbaKN344CT--TEROK?/Z>Z]
/5C^9L:.0CXB0FKM;S<:#6)I=ZYEAA;7C2#I3;([Y5]E)aY20B[3dNf>R_:WYKU:
HeLcZJC]b@IbUDX_R<0U&bQO(P6cT7)[2M(0@(_9730XX-bKd-.M(UC>c=bB<4DL
M^+Qg<K9N(a(O94H,c/LC^31X4[ZCTNKD_TV7J]M#75R,\I86P)K_;TMfCaB(.g;
SH.TM(dU^SVHTPUe&@?Kc7aA5XZBA2aL6M7bNKKN#+ZU,Y3@I<N_[SeH0g-g3@A1
KQIZ5;7CX9DbQNOBZFC\8<d#/JbG.1VAYf0Q&BP\IGAMP.ROfD43^VBWMaf.=>f[
K3ZGU/-6N>39d=L]X6GZI(FfMA_H.M+#&WJ.?(]2d^1I2[gME;007cQ-R^P.U#IC
=#3&cFADUPHHQ_C\NW6_a3W7bIF(agHGcD6QKN<L+HVA<8V.NXYID]@>bLa+5N>1
[5NFa=UI1NaJ@M\;L=-9/VZ:5(G+LMA@+eecf-09X6>GL;=Ed-X?7f=;QO]W?7M/
B7.YbHZ=8#YOO6KMaLQa/8CZCbG1[.7O@-ZZ(DS7D7TXR9CSXACML,T<JX]809BO
?1(R^ZSD8=?06_3fQADRg+].g9H,LYA+/aTaI>DUJU8O,5FP_b)2^C@W-aPTR2V/
X^V8R4aD+;_3AUFQdc5V).[V06g0,C5Vg?8UWb)G/7^=DU:=;:PZ1S<W2\E.[/;1
4T9bD#H=.@bZ(7X]N,1Q\.QG;.;.Q?gCC+V:VC)G/-Z1:Uf)Q9(QUb.^3d2>;5FN
97(cLJ7Z39HK:C&QP4[B;/L.F_^=Z#1_UF29LYJFZe;U4g@M3?8F3WbG)\ceADMT
M,=X.6c77KgBdG_1A4ZWH^<BB@]?W?1<C.fH9Y9OC#Cc27IAT(1e>a>G/@U)X35Y
8E-5@7:&CJ9O\_:Q>\ODLbIKX@X2;Z9ZgJS<#(H7.[A..>XYP+]d#aE,9)DgE^#V
><:8<?fT>IP4H&Z+@UfNgJ61[(^U7IS0\=5L([H5CW#aNd6.3fJ^3,F,\/[=FF)]
TCg\KKDJ;?>B5]Z[Mb0,=\)BV4KJ1,<?_TQDc^AE/H^N0;[DQe35XbW.-9I?CD;H
5G@H8)E26(8gDg0[/7SWK)(K1:=).GN;<g>W[^LMEN;VA^T/&KH(>+?&95;N,7_0
4/@T<A=HC5NPeFS+<5+W+@I#,97AYWa8<(dA&ESZV3aD7LKJP(;Sc>;/2C,Za9^)
9AQR0E0#8&]Z#[,Y.-aS\<(ZGV#ed;Y=@BI)K7](4GV=\6^G>;UX,SCTO]a8V?DD
T=MXdY?L9V[];L;&bM;Ac.8](2.[VX&Zb89KcgA@<.9=aVbbZE:Z0H0-F?f1dR-0
35)?)3>S.0?=>Kc/\L,LcX&e\3Z:BTMGDT@gHKROIVP49W\e9g(M_W<GG[I2b,;B
OU/TbN>5d.Bc-_D(6XZQeJS#6+9JCTS]Mg;PA_?L?3HQI-DbJT\K2)Zf2JU-9&1X
S6XX[+RWX\LA9A+eWPOYM9_I9U44>G4<+N4R8CBU@c@(]X0HDZOCB<=4Kc3b=cSV
?_M&P/@75SZHO@51),e6A,&87,OW1IIPB=F>U2H0-HFAPN]4MH-_+a,/C8>\BgDZ
(1f;U#6.e],^SO80N-,gAR^^4F1N+E<79d=F>VX[O;<+[Ef)+W1bZYQMd_44QRL&
e;Eg<UHE5;<]5Q2G2@H+NIgEXRRf5.M#/gYX<BAGU7a?#P2=0J/1NM5Vf;&J,I3@
M^c;Z=/R:::;gX\M-2g.PbG=G4EV-]7L)TWAJ_AWGD3]Q1F(1<],I)D/J]57,DMW
b5/38e<Q06.WX.=BZ,<a4_4VE2ecZ4[]aN_Q+M03,Mg+d=F;Kc6C=_Q\-^LR)OcC
eT,E&@)AT=O#RNZ^QJ1a@GY<MPG5e0Z02]Fbf@QBK]:&BR<+eE01a<Q+#MA_X2A1
/^L.d<1BA>=C?bcC88#S_b9<,2&NC<QCCP3>2_^;CJ_2^4^=^>DL[Z(AB1dPYOHf
_\>=f&JLQLGKfd):9</[,ge0:K@CEN82VF/))&5P\PEFbH@JSFBeN[;&-RH08[3)
B#&/26Yd75P,eH8D53dSB<M#-N?79?_1W=U+,H=TC.6^a/59P4M/SX(55;8=<fbM
CW&V:b7_FCMI#ZVS^Y\U?C[XT<;]S<[T-59A/EF<gED4=\TWUIb8GIN]d)F?B,=S
IeNM6XKRf0&PV_-gcf,DJJVE:F2:NRg/cN&J-bKY0-]+?HEDV,]^.,JSY=]UQYMQ
[+T:+b(RN84IE4d1K[,EOKM4DG>-da1-)DCQ2>dV?<,c(g;,I;[1/N[0M\;3f,AQ
(KT,Z.ac3e[V=g;PO?FQZN.b@Nd]I2DKP?LKg@_(SgeQc80,TNY_9AJ1T]&cab+c
Sd\0Z[F?G7RM[V8G.60cU.;]D3AB@I[6):L)]gE[T,B+4HB.c,GX9(L:D-_43fa\
XCY,FKK1,THLO&LZVNea5bFHKd>114b,+M?8CZ,gX9c63,\6a;Q@22_TSMcXeZXR
-Y-]M;9DHeeL[b\&FRGeQ]\VNG/0PbE54;3_)=H;dGSeK+8PE9)H)&35;\)&43YW
UC[9WBcL+7Y.b3-?P33VATggL=Wc,3>[\<^P0OG=AC(C;;V49+42PBP4+_.>>@0Q
=93GGLcH(3NY>-SeR2F<RBXH03J_PbM2G+<WPR-a+Db>3g\->bO6YA?(g\U5IJ&d
gY.93:;A6,?dbGCG[D-U-6+G;8^-+K&T1]500cb@G4.>E$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_SV



