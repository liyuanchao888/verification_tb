
`ifndef GUARD_SVT_APB_SYSTEM_ENV_SV
`define GUARD_SVT_APB_SYSTEM_ENV_SV

// =============================================================================
/**
 * This class is the System ENV class which contains all of the elements of an
 * APB System. The APB System ENV encapsulates the agent, slave agents,
 * system sequencer, and the system configuration. 
 * 
 * The number of slave agents is configured based on the system configuration
 * provided by the user. In the build phase, the System ENV builds the master and
 * slave agents. After the master & slave agents are built, the System ENV
 * configures the master & slave agents using the configuration information
 * available in the system configuration.
 */
class svt_apb_system_env extends svt_env;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_apb_if svt_apb_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** APB System virtual interface */
  svt_apb_vif vif;

  /* APB Master components */
  svt_apb_master_agent master;

  /* APB Slave components */
  svt_apb_slave_agent slave[$];

  /* APB System sequencer is a virtual sequencer with references to each master
   * and slave sequencers in the system.
   */
  svt_apb_system_sequencer sequencer;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_system_configuration cfg_snapshot;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions from master to BUS are put when system checker is enabled */ 
  uvm_tlm_fifo#(svt_apb_master_transaction)  apb_mstr_to_bus_transaction_fifo;

  /** Fifo into which transactions from master to BUS are put when system checker is enabled - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_apb_master_transaction)  amba_apb_mstr_to_bus_transaction_fifo;

  /** Fifo into which transactions from BUS to slave are put when system checker is enabled */ 
  uvm_tlm_fifo#(svt_apb_slave_transaction)  apb_bus_to_slv_transaction_fifo;

  /** Fifo into which transactions from BUS to slave are put when system checker is enabled - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_apb_slave_transaction)  amba_apb_bus_to_slv_transaction_fifo;
`elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions from master to BUS are put when system checker is enabled */ 
  tlm_fifo#(svt_apb_master_transaction)  apb_mstr_to_bus_transaction_fifo;

  /** Fifo into which transactions from BUS to slave are put when system checker is enabled */ 
  tlm_fifo#(svt_apb_slave_transaction)  apb_bus_to_slv_transaction_fifo;

  /** Fifo into which transactions from master to BUS are put when system checker is enabled  - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_apb_master_transaction)  amba_apb_mstr_to_bus_transaction_fifo;

  /** Fifo into which transactions from BUS to slave are put when system checker is enabled  - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_apb_slave_transaction)  amba_apb_bus_to_slv_transaction_fifo;
`endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /* External APB Master components */
  local svt_apb_master_agent external_apb_master_agent;

  /* External APB Slave components */
  local svt_apb_slave_agent external_apb_slave_agent[int];

  /* External APB Master component Port Configuraiton */
  local svt_apb_system_configuration external_master_agent_cfg;

  /* External APB Slave component Port Configuraiton */
  local svt_apb_slave_configuration external_slave_agent_cfg[int];


  /** Configuration object for this ENV. */
  local svt_apb_system_configuration cfg;

  /** Address mapper for the APB system */
  local svt_mem_address_mapper mem_addr_mapper;

  /** MEM System Backdoor class which provides a system level view of the memory map */
  local svt_apb_mem_system_backdoor mem_system_backdoor;

  /** MEM System Backdoor class which provides the global view of the memory map */
  local svt_apb_mem_system_backdoor global_mem_system_backdoor;
/** @endcond */

  bit runphase_ended = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_system_env)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new ENV instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_apb_system_env", `SVT_XVM(component) parent = null);

  /** Obtains the System Memory Manager system backdoor class for this APB system */
  extern function svt_apb_mem_system_backdoor get_mem_system_backdoor();

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the sub-agent components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the virtual sequencer to the sub-sequencers
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run Phase
   * Start the interface assignment
   */
`ifdef SVT_AMBA_INTERFACE_METHOD_DISABLE
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Shutdown Phase
   * Stop the interface assignment
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern task shutdown_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task shutdown();
`endif
`endif  

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the ENV configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  /**
    * Enables APB System Env class svt_apb_system_env to use external master
    * agent which is already created outside svt_apb_system_env.  User needs to
    * provide external master agent handle and its corresponding master index
    * number. It is important that user creates System Configuration including
    * the port configuration which is supposed to be used by the external
    * master agent.
    * 
    * If system env doesn't find any external master agent for a specific index
    * then it creates one on its own. So, it is important for user to set system
    * configuration with correct number of master agents considering external
    * master agents and set specific master index for which external agent needs
    * to be used. It is allowed to instantiate some master agents within the
    * svt_apb_system_env, and some master agents externally. User needs to take
    * care of correctly specifying the indices of external master agents to this
    * method.
    *
    * @param index Index of the master agent which is external to the APB System Env
    *
    * @param mstr Handle of the master agent which is external to the APB System Env
    *
    * @param mstr_cfg This parameter is not yet supported.
    *
    * Example:  for(int i=0; i<5; i++) apb_system_env.set_external_master_agent(i,apb_master_agent[i]);
    *
    */
  extern function void set_external_master_agent(int index, svt_apb_master_agent mstr, svt_apb_system_configuration mstr_cfg=null);

  /**
    * Enables APB System Env class svt_apb_system_env to use external slave
    * agent which is already created outside svt_apb_system_env.  User needs to
    * provide external slave agent handle and its corresponding slave index
    * number. It is important that user creates System Configuration including
    * the port configuration which is supposed to be used by the external
    * slave agent.
    * 
    * If system env doesn't find any external slave agent for a specific index
    * then it creates one on its own. So, it is important for user to set system
    * configuration with correct number of slave agents considering external
    * slave agents and set specific slave index for which external agent needs
    * to be used. It is allowed to instantiate some slave agents within the
    * svt_apb_system_env, and some slave agents externally. User needs to take
    * care of correctly specifying the indices of external slave agents to this
    * method.
    *
    * @param index Index of the slave agent which is external to the APB System Env
    *
    * @param slv Handle of the slave agent which is external to the APB System Env
    *
    * @param slv_cfg This parameter is not yet supported.
    *
    * Example:  for(int i=0; i<5; i++) apb_system_env.set_external_slave_agent(i,apb_slave_agent[i]);
    */
  extern function void set_external_slave_agent(int index, svt_apb_slave_agent slv, svt_apb_slave_configuration slv_cfg=null);

/** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  /**
   * Obtain the address mapper for the APB System
   */
  extern function svt_mem_address_mapper get_mem_address_mapper();

  /** Obtains the Global System Memory Manager system backdoor class for this APB system */
  extern function svt_apb_mem_system_backdoor get_global_mem_system_backdoor();

  extern function void set_external_master_agent_array(svt_apb_master_agent mstr[int], svt_apb_system_configuration mstr_cfg[int]);
  extern function void set_external_slave_agent_array(svt_apb_slave_agent slv[int], svt_apb_slave_configuration slv_cfg[int]);

/** @endcond */
endclass

`protected
QE2U7gJ\S\a-b4J6O_,D:_FCd20U->]=;Q[O;:3]bD610U^C;4?I,)IQI.AUXI82
;NQ<MdM9?[H,.71)#;OX1eCPc[4Pc0K^#M,<f#9WY+DBSQW1fPB_=49HU(cUU950
+gV>4;+7>QaIP>HI..D@Rf8Z?EKXCX\d49-R^2CM&VgPPeHZa8Y=VI0S+GU[<-SF
dZ#QMcQ^QR^<]e;Y=f#X&9Z6U_83SK6JV-_+6)F@5L/9LPJO\a)QI:Q<T[1QWda7
DgH8)eKDJJdUNCS3U#a>],A9>B1D/[(?<)@7d.R;eF+29;4?Z4GTROO]CfD^dbZ?
E8YCOH#gN5DU/$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
KMP<M;.(W<abZLQ,YA.QMD4,?AfADG]bW0b:G\DJedd+B7&1/Ib^.(JRP=bWGe>b
R<X^K5MG-gFMH?g.I@\eaY:6Q2g&KLB=Xb4L[9ZJ\WNcJ637\V&A8>W&6H>]W+e(
DL.4A?>0=/\e+2eESE?2WG5=P>:I4YL0#JGI;a(_O&84ZRT3)KW-5\/-d)^LB+Qb
IR^YLda;/;HY?QQef6:>7?ZE0MTELgL6]T[TK&MXCJP9)4B3Rd3#C#=:T]DdUeNf
.cA)3]NN.1<c^#L?=3f/=E_Q=_[C2:83HEQ;U_Oa0W[@:I>eARCCBd:>fZ8@0PNE
)G8>gNL54/TQLZ_8,:U6eg,+(HARX7fCV<,QA<TT)#JO5[NK>A+55FYf1g4TU=0N
_2f5CQVcS-MQ&G(GaT4=Y#_5[DO.(g,/JCT+W.B@ZY?<LQCTY+=L,d(K+>]OI[NH
767_3G^a:.3f.-HOHH,&P?3=ecA493,<+(DU(H.>B+@JAC0eMBff205M6@W(-?R#
T/;YS7P)eeScB6T;ZX(4AfL1Qb4;(a[CMB=2D@M;b^P^3TZ.Vd^M;FS>P05R8,bS
3B#fLf(EcUNa->7KQAV@^3gRV4XEDcG9M-AGM:/DJNQ6EBY<I+\+(L/@44QFTC,;
&>fXWc:f+E((F426P.D#42YF3H:abN5IBVFNagQW)G6+9F+^&,.]efR;#=S7>;\U
O]gU:EI2&23J_D9a/ASW93VXS[)Q+?Z@^V/5GJR3/e1c(DR#^RX/a54R>SUdVU-2
T\N2O98NQb#R+I>eMc]:3)87aLO_.H;Y/#^I0R>ABC7QSGa=0a[L&R2eXg??0ee[
.:7@bg.741_VIAFeX?ENfBIT^>(MA10?Y#L?^[E7<9U0SLZC9Ue\Af1-^4TULN9W
(1RJ[1@^U?;C;3^CgER#M.e?OFI]/AD,)Z(Y=SXF1Ie@CA4P]S5AYBQ6VcL>#B1H
<E7,ASAe\K:)GYa:#b,7D-T(YZ?Vc&B/d<8)U7+<gKA0#c4[a15\VIWg\S.e)6;A
T3:G]8X6LZcG]HC0F4,(..(C;ME#=BCU5D=-@Ld2(S/2Y;WHM=\/#_,S1<4QT#NJ
,#@SPQ1dM?=@(H:3;[^KEOJKVE6X6#2Z8Y;Y&&cO#gVV7M9II^8>ID)OI;^2ORCU
/PTCOGM9@0d^QgfbIRT-A)#Qc8:#:W^4MQXA-@/G3>@.3R@Z;2aZJ^W[c.OIX0/H
=F?+R:JD@MG=F=FQ&,2_(^>54]/-9?@+GR7>729JL>^&6TG73O,DC4\3VWK#.8-6
Y:@C^C)VQa0\4SZ1_Q_LY6K5)&UZdVJ[X_+RJO31fN&fSJN/ZLe-&</cd4e53:aQ
0Bc6_;7=c@DT]0#-,N.4F(.eG]8G7_:aUR;LZNOGYV@QbKJc5+2cN,YMJBW[0DSL
@A:9<:@)&4=WW4U],gc[I1=bC+#]BfS:Q\_fQ7(SRM4XHc_]3,HXP>_;9ZB0&CG.
0G7QD=X&35]ESU&0799YVFaW&4;Fa@/VH&(_T5B4W>YF=Hc5+^O-Y/_c6(:=035Q
aF12H^BB&[I>Q=aA#9D->Ld5We720e3\&3I;CZC=^A6MPQB/Q3<(,,gOI5W+PHHP
8M8QCf&_2a14RM2[)Id7I=]0SWHI0ZV=.5&PE=07a36+M>I576EQ@=\5&O:N.,Tc
HeK^J/RAPVe:^=V3[W2aJ^JFZdJRL.IUa=BR+XUBaN0^2\FW5DYG22a/cb<ZfM<J
?V3.U_=HRLO]27K.9W>+33e5C#W_TPRBOFHE20XGcT&WN^+#>]-#K+M0^-QMO=eE
:M0]32A5-+bc_:]K&.[?PP.VNQZDI8,5_@1F\d)E+D;[6XF@6_3[2bd@:?]4?R2Y
c5Q&[L[a):Sb<SX_8PT<@=MX3_OS\LP4Y-8,,IdVfA2f6aA2^R<f,8W=C].+@+^G
9W?..Qe4MRB8>+YU9F?gOcXBK15.+<E-ZJO))6R3_KRF(f]a_GOA=RcJ>=VO\C?_
?bFY+3<1Ee&TO/7N#.)T2&F887;Y3eE>AVAMHV&bP2Q/eDZN42D8Lg)@=F(IT=,V
82,c+V?&O@1^cE5<BNN.OTeK;c:3bUY:R+Lf@b@47K+bEeLSV6H)R=@e8]7Yd_OA
840QFd&CRJ=S7Q^E7(J@=3@PMJeeTg@OI1a4E2^U^eg@G.7YU.+N8=CfZ_P1-A#W
ZaWQN:bc07U8,T5B)e6QF6]G#&A5[CIZd/1#aN5;aY8YGK[YaRP9AVUUXKa:RBY&
,\>]VQ,8&0DS2-a2>#KK<AZS7>gVMBH-X3a=W#I;8+CL=R]G3C/<eP;4>+@J;-S;
+1a\6LdE5,0bO[D2)TCf\X#P-5P268f,+V90Q>1_:P:U;3Sa6daX/FD8.gV7NI1b
#?W:_N2GM+,J/#)=:eB-BKD\[;E;a7bG(eGdfQHG=\?V[c89+OUV-2JT:7&,&;)3
4M+7\d##;FO?6MAEGYRcLNP&C(^T44#:KH>KPG??P^RLd7J?S/f,#WV7<+0A1CBg
260TP1Mc0R=#:+?\#-Y[Ge#H1gUR&A2^?ESTYUZaT9P4_+GT0Da(e-\#c/([Q35:
G1GD.f#-G/#3L=SG+c:KT3E1:f/b[>Zb17&KXg]\e/B_UAbB;I.[[9HYC#Q,GO9\
T<7&UD3+]^J1#KgQ06&N+e_BIQ/c:bEB=P-NeQ8b,4b>E+<.ZMC3E/>gUaU,.J0b
JE=,+#Ng/:X6_=b&/V;^11SgJ]#G[KQRO.gS+1;77KLdZ?c4N(f:&bfVSc.DCO@A
#CIO^>gC;ceF,^aOb;/cY7:N;_(4?FJ>WIaBA+P5QUf#HG1GSa(V#39RbREEFNJT
(8eEKV3.J?Z.O]R/e^5aRB2426^:cUYe,A4OH\[]Q4N^RD0#4>:SUf(C3K[ed3?/
QQ8NE,cAJ;b]@6afO4HRQ7SK9fC/UU0;W=O?FY9]R2&Y0;f-3A+:Tc)TYAG9);C5
:ca>BN(TSX=?eT_f+FT245/J8ZRg:1]CLdJ?G>2?MUc>gZ1\5-f?Eb>5d:WMJN-X
?;];4S,c&^V[0+IL4->b)6>/TFQV,;YKD70SO[gSJR:]NHR&-JH4HfVD#c1)Had\
->E]H<F?ab.J6P:?)K0L4A]U_T8GUU((L;EDW#<)9N0ZT=d_NfH1XcVI@JR40^bD
:;]#@89R>E3e2Q88<=H=\d7X<DT>U.?+FR15HBc&7(_N8>b_Rb>&gb3@dX62(.,4
6&&OTWcT]E3D9+gJK6P?+LH\:F,Sg.74b-E&>7_W5VMO?AB00)5UGPT9OdOMLX7b
/A3_0F/ee7,^NS0-;5PC.U?E6?:WIZ\6;4GCaTIPT]\#H0[d6MU:VCfAUSU+J)/+
,1fL45DbCN1O/)8E5N3RO3XHA#T<G;/f_WX+#(W[.AVeI,I<C;cdU9__:1LWC.T?
<SA7V+fU:CJMI/@S<Mb7dEZ^gaDRC,4+Y8gHdC3]TI-Od7SHaLKa?S;P,:JH+:9:
TgE(a9Y2LO<P/,&3DQ@SCR2?O_(f(-e5(:<#0(e>#;?T8WEEC174a_0?:dXX8L[V
KT6Z5VW#a9HTXIJ&9D\=(>_3W+Y1BNZ[/WN.2GC4&9+<\[,Y:.BWeE;]aU6)4(WY
fSUQc\<T>^Ng1]SdT4-S)#IQY@-=\5:=LJU\SI@TZ?:Y/^5#0B_-_7Gg\V\QV27:
JZ=Q\;3e:eOC7]O?&3,(VRMG8<&[\UWL&&J^FM/BUfP;f^_L.g_5bg+E>=+)^,7_
<[IH#&9RWTQ2MX\d;Pb2(JKN,6>]-gV,\5NZ+1.:UbY^6#/Q=Xb?e&W6f;;D-a[(
06dagCP/\C,eU[Eb&L+,a-8Y8.<g&d?\##a-g^V/97&-\6LE:1]ON>e\0aHb\NXN
B5XId=LLEFD#WLZ4#Y\V<HMP_].:WGEC[_d4b.?4?6)a,[8/@aDBE[c/0+/(7LLN
@]fdd>1RF-XA2NHUC>cC0dR+e[Ea4U;0F2=D>AXOG)7RTOg;c?ZM.D[\UB<0Td--
)+b(HCZOaJ:TOPe0\B]BZc1FGW)H4fSO8Cg3YVJY:cR?M^QbY)Tb?3WV59Fa068T
81eV)5?Le(PJD::2_VRTPL[=5ZI8>a&V#9?8.+4Sb^4J8J)><6D4Og9Td/.TaW16
+gNcQ=V3)F/S_g8E<2\e-^QU,&\XdN[,aJM@,#GaEY^5H32^(E)\/=bEb@f\K9>P
GV]UbEH,/L.=V>Ad6JC/H#/\(P47[R=_>;I:>A:^T-e_FabL=FV0USOSB5AYGRPV
;R/FE3K)MgL#DT><)g+>40T-0=+HU?SJL0@QA/Nb5)_;04_V2e>[&U/FE]ZB,,KV
:bO3:.O1<(b>]dJDM;64AB?6N7V^bI1D@PeOaB6OQPFB:[b,H<(UK8]6e_SUJNQ[
^[:+d>F4?Pe(^:6X^&e1e=R+[YHBZ[@^V)YLMAQg(ITGEMT\(e:C?[6AT:+.[ZZ:
_Xf&g6E7VT28:g1NOfGCcSHA0H2MW\]d&^a[#gIN;,ED8/KBOBK0I(XIR61J1:AL
?EBKe<\OGdTKX,2]d/;(X+U_(N]8EZPWHMKbg>]a8\E<9[fFbU3OQ>#EVaEE.A)Q
<^9+H3cZD2I:2\PE0WUbP19E#T;2V@bHFND+;d8SVYeE,GfU3#A4VS./aWG));g^
,>D>KNS[?54TC<+I-I-/b#9+QY?F08UZ0@#DP2#8+.<2B5::K>?B:L81:_O:bB7X
,cH.g4XMV9/Z,O5LeUF41d5F8c&09=7P3dVP/R&LIf:6PV=PL-Kb:;;]=DZ8A1^\
3Q?R7.=F@7_#]&Z6c&U5-PYZI<eH@Bcg=G66E0FGA?9aF+3e;aG@gOgK^TYa#SS/
aOYeD1RI;)cFEE_?G4JbIf4CUX^WgQ5Iee/8W[\?2M:6_gDS@?#^@GPcR+0E\UP#
-b4U;O]IIREeQ,J8N(>Kc;(@),YH+L;=]J;e[Q<&Jea=&@-[2&73[:HROXe3RXe1
@MeOb8)W\D65?,XcFSd4>4X]D6\L0Ig#a5N75X3V23+XLbG(-LcD&(Da8IE3X=X7
N20DAa@91-a,#dR&,N6d.F>YLE3Jg2BHS;V5fN:)L?4KW#=V7<GC/0MHQ:A5WJ6V
gF-[2)E_)@eP:4PO^_K\.XC(?V[AIMI,B>.&])C+DfQL.FcTN]>e15[W].\V6Q9Z
:[>I<0bXa,SA2A#I_aEMA+C04F_-84bL.3GgA=_KCL]gebK],L].97,a.5[(M9c\
WB,/RMG7\C&&G(4b89f4&92e5T8/P,Rd]TI#KL._@K+5B1db,L=T^]5),M#Cf=19
2a?Jf6WKcK.MJV5c)YOO6bD&g,L1OK&]=K:Z/:bMa7Z_5[e,3<^HLbCDeIV)?XL-
DA&^f,U)dVV-CcbcA<<-Afd@L-FZ<ZeYF#<R?F&KEM@BR/)O//\D#)8>>+FN\(XU
<GbNd]CIYR4\1LUP:?91K3AZ\-X0#;8/NYOQYdR?_Z)::bV@[V\@+ad+1(:77CLP
\7M>DB+WM[\>?XPf5VA9)D>ELV(.=bMP;]8)cZ][N\XPbELe-YZ\M[S57ZZBITgC
#,_+;<JBXGWLB?J4A_a0()dY.<D=<E,6P3K79.SQ2:HZ5XOGLg<&?ObAC=DW[A<Y
Zc=D[#VNRd>3>O(&c/WAfD.;CPfN4a\QVC<LA-f.Y\4gb=,:(;1^g:Ba2:DXd>@e
:b88#(.:LY[J6QC@F_@LeH-_.5UAQE1QgPJdb=J0ND.75/W_c4S\WGE(=#VJfBgW
Q5V=]-@RRB?/[0405QH<c^@RTWcfgICSfYHJ/A\T?f2UdWXB716W=)c>5aD;c-X2
Y6,EM1_>ZfX(:c^L-<<&C1>F6T#Y/<Md,56Pe2-eN)b5>B:RYY,OA7QVP6?-2a&9
gW1[34@#I#6ge/>]b+9LS0]WWEY,3#U)DDXN)a58T^(J:4#A@c]]SKN_F67SgA]^
Dfc)fU1Q7^c[2(Q((-P.V;()1:Hb9H1Y.1@]IgQQ##KI509U0#T3SVXF+gS1Y_dU
(H?2\W_D]bCObcWV8[,2I=Y=4HMOZR<,R++8>?Q\C4e<4_HNa7?d+#A28</MZ3/H
?(dbg>[ZDQXV5<;1fA_QK9]=I76]+#Y05]8QT.I;-c-6PU#YBE31(5de(J)U[-[S
&fDEf[?G:#[DD:4YU>XPL#Q?fQ0A<>/IgS/)X:JHXC]>+]F#6cbMS#\HE(eD:O5;
1=3PgY]@_eD[IFaU(]0E5531=eL8J8-I]3W9-^WFBB;BY(3XVcIMQ@C/AA?fRUI9
c7B(+M4fKYK/@cRe,/OQDLB(Z,V30AI0HU^I@NbD3,-\2X7J._);..f+MWM>\bcT
2[;?A/_<^G/:gWK8cKAAYe2AR08[^+?b]ET/c?LAU4RBR.S<J4LO0KSV08/0,5OH
c^^<QbUKJRP2\QF&70<4eLL3gI.2V525,2(10CPVfb<NI\HPG1-f_CF.)G1TCQDL
..Z<<HX^VVUagSSE7=HQ2.N5IPD68R+XIV.E.a8W@Oa@<6N.]#5^>DTgO))QO9d2
_FZHAS7g\2<(LUZVBMQgK)E,T^D5YeQ-11GO=[9#.MgO:/+^X.4N-EO2T<Z.9.[N
M:OD_e>dbFVO.df;3.&T>dS7_U?bB?MKU,A)51c=TLX-\-cY6+KdKK#R(Sf@gGA=
J-N?:1#PK/d&1)0.2OIGEKGZY^Q]OBS]5BBeRRC#bf)_c5YC8/I7LE@L)ND^69+c
?PMST[<+CJC,;[@cL#.C+.ZaRP^TJ5-5NI8Z1+?=;d8eA0-f)[-A=MJ:;D,-[,#S
.eDQSZ7<;.M_0&Z_>P/?d(B9+d<-d2bSKc(F\H\#U&19,=da@Y-bC_Y=<::MdcIR
>CJ,@KC88=bO6.\:02JB\#(Nd_>MA+C1eFZRDfE3+^>AG?Q1+)_e92JV]gF5OR(D
d_&\4Wc^\+Pa=AR]O^L:5NO\0DLSP72\TZ^S=#g5&b]HQY[PVNR4e#c>Vb;GWEX=
->=;)e3@)^X84FaVHRd;;9J[+45WDbb@)dPGU#.6T[N?4DR>bCH3>Z3L\RV[UHA[
)OG8e,_gL-GbR=b;5@?,19+SJR7BR#N^3_P.eQ/Ga=]MEH#M:N/2)X^aS)9A2e25
->VdV\>(b,OXa^XPFV6d]&XH[^AP8X3(M3SB@24(DXB?e;T=eW^eTR#?]B^#@\ZQ
b05+S00IF#YJ2M9H]2HI6\I1(MbV(12<,L-<ORHN,N@7bP0dFW,?T2V[HCbfR6&6
fP8cB06[TJJPQ;aLBB1:VXGE7PF-LaOQ7)&R^CI[?8^4HFIFebfa2:>fFU(4:4O?
TMF]f34c[RF310LFee2IV^)Z6@gO0&=7[-LFV\8B2O\<M;@c5H^5?L]WPaT^1fS2
1?.S-30,B9)3KX<^_;I#DQO()K^;a,>XL9-))f&[@.L5C?AAB;JVZVP;J:C,P47R
&WZQOP;[X8?:DB6/X\WHHF<(Z-R[dR,fGEM9Y:EVaFOa0\UX[g&.[.c51B&f5KgW
=dSYXH[Nc>KGGYfTJ_HN[F=<(eQTV_V&^=5f?X.XV\G?RIUK(B.9Y]D75YL>9K9c
1.5Wc4WQa46(=6F7P>[UIT[beFS-A:bC28c8F]-PF@e-KT.?R^R@8S4W&KM(=SVV
Z?8(<,+AK5fL1?BM]_@LXZG.39>SO#[)^^fK:Z6M/34OT[Tb8d9H&GW3Y\>RW)T3
Y4:A_YQ?gEZ]T1\N,L3WKXcS]T[+E,C5-;eW-O+a-Q?bXFV#XY\P<M;\DeF#E=DS
=0QV+>;0Ed\3/e9GPMb#gI82QEKRK449+WePP_=I@[;(7fSZZM/<HL.U>S\312_6
)>FC1Id]2eL0MBV:J^[FS8\R-Z)28F;G]G3PUf4(<R0DU)R1RPX^_1VA8+_d,YSU
T@&H_QcL]CBW;D](M1Yc8ZH-U\C:W5O;g(_3N5S-883?O,#T2bCM^W;+HZ>@,RKa
^^U(VaC3RCU\b@d&D7D_49d;);TY/#5\(7V<>WOZ2/=A&#,R<#;CEW^3b9,0bJK1
_WY/04g=J/PXG3ZFX=9RHGRG+.=(5U?+RX0084A[([8_</WAN&/cdOUT>/CRRfUT
T9C-ZHD?T\Y9W8B,FDV.Q@RS5/MGAcMWZcU9VK0O]@HIJ8gF^:MaB8-P:aG2bW+?
O+NGV?f2B=QbG^K:-F2Wc<#Q:=):bSbO.McN]<&E4=OQX4_M.X/Yde4[O_E0,J?;
>D50K8aPHC\E)8LbH/?GVY>f@[[[,IMA<.>52QGB<dLF^1^1dS4O@e]AI4ME+0gQ
;([H=A[dQfbS:1FKLc,Cg>U7;:2&e^A#3XfFG1dZ@ZU>YA=;9^5aH-;^KF.2^3\/
HW\<<TE\.7Pe_YdKVD=)8/F\b0_C_6W5ELTa6HU:CI:.CQ&9IU;/(Cgd3PV@SAS2
0Oa8M9EA)H\M25VI0Ce)O@+R)2)>d1/g@B8,>Q8FRHDIK1eDc),G=BRD4WJ+,@[I
2cN<Wb[P?gIe@bN6C^-^4>;;A_VIQ#9dFP-K52R#APD\,0J6/R[XUd6T;)25QJ1g
ZeYbW@4gT4fFGc_BWZQ=Wd?;FU,=b))]QB?8=;=H/^bU.,C&;EHfIe;efJ.d,TU2
;5d1+;(=NMQR:&g+Y/-;1PTRde^QYWQR[L-Yd_L480G8C[=VK5;d;@.BPIH5T3CT
gKJ-IF=#1B8ET#TegO[DMeVa[EF/REDGfHI\]caJG,>eTM.T]&<3E03N4bCRJMW/
&A[X<@^UE=H-9H/Q.-3;D\/ZFUX<KXC2<D@@eQ3\eG<_.T7Z;@JCV>V\=-8]S)6=
b12@_e>C/\EV=OaCb\#83?4RH6?eOS&?439fM9UI==O50]\5Z1Vd(MTFLGd]EA>K
:)YQ82A7)NDH-9:E22;)UF6b-LT]f[eLVb)ZAB>Z;_bBNQeA^I):+,HO]N34./PA
/?<PcfG7FTd.L>3@a;W^I-S6TCc5==9X?_Bf?WRDYKd2.;MV]=F8S<<7Pg_,W(3]
TS5gUOZ[4R#=Y12673YL:T#?=:9Z[e&;ZNA-Dd[QGf3\ge:eKEXKW#;e8(ON&4#c
[f^>\A0_7YVC66@[JWO3?634((IEF^GMDb(M@e.bBc_[ZYK<W@0)Kd<QS^1O9]SF
b1SI73]96P6d;6.+C3ZZ(]3\I8LD8PE4:3O&7.g[W=,/U-,&Tf7.77O,R;S652UA
4d[?AKc(J9gLZNeLTI>#U5fD@N/^c;A7C__#@_b:@CXd,Fc2/TeAVU3Jf&SMfP-F
YbG=H=3#efe5\1gcTH]U.aM_3@RNY7F@0Jfg8?Lf80\c.7NVa6[AE@T7:M-EXNa\
CgfAOY8K_#?C:P(,HPA&^L/<T#86eEW1J,P15?->\g+WV5-\4=E(YeFC]^9cUa6U
fS\?FW>KfI86.)[)0GdBNZN+#I_EK2_5VQ2FG3KdDPWdQUCe.E@VVb5OA2>2UMB9
#+a]5M)]-?/8Y<?cKKLA#@:fd,R;S+VQQ>3aE;bX1WG&@g>;bUc6)BEHC75V/aEU
TM?-&-YC8P:gO_aO/(KQgC]EX+&MD4^4IO7P38_(<e-=Y#b;eE=-(:5(&Y5,b@4P
V>Z3NH[=3&2N39<XX[1)\XDU0;6TQcPZ)>>U]71a2IZA6IVD?Md:T5[EcTW.8);N
>D4P/6.&C-WIMXZZAfGdNF-Wd\KaMR]Q6K2]\7+^Y&[SGE<+,5+J^]EDFTaN]M3O
-1W\+\TI<4U(I9Jf+;(5ZX@aeK\;_fc3:LTa3EQ9)OfCf>W-;#e+K.=]BgZ.9M<7
NXbHCZ@X?5&BKUBUdKg^B+F[_c./G=@5[KTe^JR,&AQ?-4-/:G[Hdd[:H<+]_D]7
1d)@]LZ1F<)[ac;\g]&O0^@-QZ_@5H?0ZS]T3b#ZM/a5P+?]Wd>^JA.f@PQZ5c38
.<O(<L]KFJPHZN299T>5YKO/Z\R+@QX_,4M(,Bg^CV;Na17BQXCH+FVAT3J_BaaB
>1U;EZKJSPg69\X81_b@D/Z_C4Qa:(.3M__cV/d\^\SLO^fRWW>5:b<NGbN=TBSA
N73<<K8+4fHe2S1cFEB#>Kg/d6?I]4I&+XVd43LLZA/<90Z_(ZDZJ45@Y5VF)+/U
6F5V)b)U[b=07ZJ[R6-+\aRa7b&4COP)aL5[S5]JRY3T:M^e=356&G&PQEUga#>G
8)FBf[M1W4AZb2Z&aD)M^WWV+#^[CZ\R7?KYAIMA3G-]U/FN\,/WPc75]^];8^d^
1A9WXKHJVC_C9M)H0&M3^2B>[RXCL.e3=&9LGV1Z2LPN^&4.CA5W93O0+Sb4W99X
]43?YLf&3?\SH5;9_UV&R?9>TWQ/5;:cH2.e<c4b(I-N_UL5;M6\),,ZD6E]CeL&
TOMU783_U[BWcVM+Q?&0X-OP1cBQGg95>VX2K+IMB1QX-(K9AFWP\XUA#Y&F;W01
_9I+-9Pa+#XQYdN=O+=G,QEM;LbM7E@AHCI(<_DY1/](BH(O\I_3XLOTa[,eC56)
\22@J7(#JUK#I/:3U]8:FT):BIEcMLSZ4H;/G@c4WN]BbTfF__.B9I+H-53@8feT
G@OR6Q[A-0Bc)UBOe)YV0CU78M_UW4(BM0Pb?=Wc(&B+.>fd912g,H:aVNEK,\O^
,b+ZA0=\_9/YP53W/DH0N9EeAMe\[#bU78>[5gaNf31b4=NWP(.T&QMDPDKU=#)V
cRN.JP7EDM(1QQ60?B6[EKbG)&aX?aBN:DT6I4&)^a&5O32,bb_:0c5\7Bb9^WZU
NE2B&fa8d+@d;FQFTF@+E._=\Q?gad]cfGUQ36=b=SY.\DHX[VN.-4&UY4AA.fdC
0RG(d^HZcfUC5G,D&8cV]EN&TU,^5B[dD0FEMbf0[dR@UCcY-UWb1\_H]BUeeb@-
T_T6cD=GDS;\)=YA4:]J]/NLWT]1L=<UQ7;IcB,OFEMc/HBM-fT[O182COCH?PNH
M6#gg3A]._OZE5WdN<^M@bgfCZBAA>L>9T(VZ@N/W7X(FfcWYB6;V/:OF^aY^0(?
eb-N=W[+C(XZL=dKNKg8a\#68V^cg5&B&G^22cJHVV6:[VS[[?W)I5G-(]6=K/C3
-ZTOdM-7L#Aded4(QKT/;4=F2NT,?#_8IQbGeX)fX]_R<KM[>V>]7#C+@B)6_D;Q
6&1KSC05[MAa+QFaVfRBLOQb^g^[1Gaf&7UPD8SI2\L-CA=Q?_.BQFO3=O]V\SXf
NROYAD)->?G_8I#gL6(4TC9<+_bN>ZB@RGON&:0X6L]?)91bV+Va[G=DOC+N[FdA
:XQRN?#O6a4f>[U5fWPK2S[KCQH5f,_g@]:LB\+g#R?<,.@G\GVTf0?c+a>KZ_IU
G2A)6QJZER)[LV+GE4EF.&1I68?I/:eFb?3(KGSO(G^4]/VLOE6J[HF_>fL7^)Pg
8GV+&8^BWBDV7e?dCB@OHL25UWR@O+6EJf?::X(IZ[3E-R)E,Ie]O\H=I3Ca2c?W
?=0&9H>G(=JfWc0&#]XWHbLO,:KAV.C#>SR)4IC4;?/8]LLWRAC=5WaN.>6+Ob5U
9@E0IR;f0@XU+W:X.7@>BEXNX4[N9\\2]]gANAd0DPEA_]I.+]<<YBgFIG:&<9bX
1762@1a(6-bd\:881K9_2ARDbN0#-OXR&>3>]M#Wgc]JE0a\I6AN7@TETD(c58>M
Q]M@Ld_+XfcD7g@.]J0)=7=HP]L#a9f@<S+XK:,daV1#IS4B,PMUfZfU,]<C#cGf
1Ub&P:=O5]LEWC]Eef;+[+[L@<eL15U&bQUD-?)<b<Z:L=1T3JZ:eHX_<_HZ^1G6
Ja1>\TAP]U#>S1aH/;F,)-JEC:_EDUeO508Bb)/ADeVRGX.U)_Ee?)54:cXX87=5
3e\(.T?>NRb4@NH(XO185Z_Y<YYfP-^#GT6@<]72W/U32>ZS5M9V>](dY];313@)
^AW8S&W.dB-b&g__cEadLeJ\D&.H)YBCMe8V0_5)fR=\>JIaMA,dTRa14cPLAMXR
7YU(^AKH+#6dQRJ\72MA7^MQ(e7cRCfLO\cE4[(RB]L7MR4,@+b,PaVgE&eAL29+
SYR=56L3F<J88VP&0551\b0Q4<a&0bX)#&_(1;3X,[a?@75@?fS=7.2U-IbB>N)I
e9,R:6_USLLf?BKAS=/L\?0Q4$
`endprotected
  

`protected
Q(^-R([1GIdO)N0,(1-E\+<E<VRBGWac&A6^#/24c)<H?P25c0BY/)EJ_8NOBUPb
OY9[cbWf@CTPGNAd#aFe26)A[[M0_JGVATC/F[e^+=.-(-^8X7OH:ZUdAacWXXUU
Nd9MFX(=@JSP-$
`endprotected


//vcs_lic_vip_protect
  `protected
DO@;Q]<M\6QRf<L\[HNf/BGJBI,B+d9^7FIDL,7-WfPcSH48QbLd,(VI]B7.FAPL
SP,\]f5@)g43ENGgc4YL4gG^UAV&5f+-@>QJJ[_aC]4cc:?Q#W)LQ21U&,E;Ob?Q
A,Z/L#cZF97Yg]OcZ]_^2[U=D7?\H8Z\T\U\]2b70.FWBf&X]7DP3J.B];.])bbW
51eTTW(Kb,4D;2:Bf1IB73\G8(&f3P;d_8??Ba@_183gT1=/UF#<DeSIJ<G-7-Z@
L,XGbH=RTc^cBY^E20S)QI/SKTdL0AUIaQ)c>L,[^J>==A;O0=/&)_Pb\19J[3R6
1[2.^6,QPS3Q3#\W=&)Y9>72cW).X.:1KMK3)4NCaD05=I[ec1-0-b+Y]5UVaeU0
cS1^0/,G0P@IKB,OX3MR+36fTS]b,J;>OS42<:eRX37]IW0&JX,aX_2HAMTPRV?I
4?cDVS26:MbS_&8CERD:RXJ7e+TPa93^?1OP,#@NIQUOTb(]MQPMJXY8XfJ\b&+S
=U:1X\Y_2UG9P[g]V@#Y,FOPS;/(UbBfaPNUJJg;XQ9E+JL^Q;cM)8fd4LL]A1EI
K\-1VK(ZGF>U>F&RM<&CE.5WW@+)ZYR4TOW\f_FVdd=aDG)6J2G0<BY2<,4;V@<4
9N@ZFX/C,)^O5\IZT:MWEfHEP,?].G4;(HUZW/AC?M/>DBeHIW-[5TN6P^PKXCId
7F=b+4AX@D^E0NA9CVNRdZ9OSUHLJIS_GHf+3?\?b^P=D3g<]/McKOC<:V[Fbb;(
LHb629TY+XBD]f^Y^]g:A1\[@_gA0d21Ja8cBYZeH\1deEd>3-\UAfGJ@35I97Ic
4fOAac=3,W/;]eRZB1V1XdO78+(QNW[E[Z180CF8EYK=D@G-Q?)80M4e5c)^-aNY
DfK=.JV+R.cCRgAHP@?:T?:,M6;gCCfA6P&9TN+F)0TKE,a/-/^ZCE+G.TY@5I-&
++UQ>c]BgQID9CVZ9J(]C21\W5WL:C(JM_DECE4IJ_A,CbJ_dC)VIH&6-5F3[M&Q
T2-SP,\Q<YFF.b(75>(1]bX26#A_RKI6,[P2R?6_#>Vf/^RG2a7>H87BO_U-,EGc
RCQU7:^-66K-H&^NAIB/\DHg^FM++:&4^_e/9RFP][F6S_/:<4<bB-DdR4F6R?GB
Z5)^F5?ZZ?1X)bFI\CF5[HSYAZX8,f<#WE/_5KH>5a]P.JP6?LHS8^QR\d10A<;U
([+VJcK>&<0Sb,I>gJ-2d,W\Od2)[Q9eK=9ORH^1XA)RcU6g@K,YDAV?_RAR((0e
>Db>R(^\).O1U#LbNeCb_U4#58G]a_GZ<gZC:5SM=WW&JS[Ge]Zd_/KS589fe4+(
SSg5(Z9.:L>\<R_fMDNFg(]@Q#,g[85Q3+:,^5#/L=g&F:)I/CcR1GHW&Nd/]IGb
V3>_24L8Md)d?A0Zcb5UQ=BNK-U8J-QJ]DeaM15UcL?;7>_ZOg;VFb#HcdR>W;LQ
Pfg0)H@3[<;X_9+=&VAB,SLJU<16(EMB2f::(((C[4Y^,=H42b/TIF>?F\(7=ONY
J9SN7ZX9@\aR?])bM=,.3&]IfG39CK9):Ec+8#A7SB<FT#BK9H6-1();(^&#V9R6
/C>Q<HG-gaY(d3IUM6NbHWLcfPB&_KH8(_2P_4B]b[QCM3-1GUE4_@/(ZO2FURHY
\Z,T0Of;42a1VTFg1e5S1Jg85@PY1EgScQ=CNRgACW8JH/9HM9,/L+R@040P(JBX
<=DZ=+N4c2NcbI;N+RB=&S68WG\E,2Q3g)<VYbWPA^XG?R1d;dS]g?_Ja_]C1-bE
T_d1CT@N.Hg4(ZI4V^OcS(B9H28=J#E9fO02V.e:EfCM:XIE=,Aa0Qg)GWCTUHTI
F./Y3/82\DP.)+F:UM&-L3YfXfaYE:W;-VL;cIE+S,(_[>_8@/.c0FLJX8]^-^UV
[66e1bCQBe?B0S-7K83,[LdN5Q6MDVA\_ETIOE9X\GO0K=3OH4792HUGIMP2,DVg
^36fdgJ&>A1)DaH#E?/ES[QVHDZU]>\5;=X94&66V#(<O&EK;HbYTPBY,CUOaH.Y
bebZVa+-O+2N9^:ZR9W[ceQ-15Xb6M#.5cQLS#MdLcTS^C;4GQMM;gV@)eR8>ON7
5^ae>V+C&JRP6<b=]POS[B[XP9Tf,2L.dMb6QWH/Q[R9)bL(R#3bAJbQY?8Qf_]K
/5(bc6Dg#IcVg]V>JFB]0M6AOJ?6PO/QJ2b]20?TC\>AC:CaJ2EeR1OY(#SA.[@]
/KJBBI(H?Ie#Z:4GePNeg#NL3c2RP0\.7[C7KRKV_Db:8CL7&U:BQ.EDf\US;L->
O;(N(]:>D=T.PXQ.bg1DA#8C?]1O6/W,IW#=/2FS2T,@f>QKH8A(/EVMEXKL53KV
6eT:.HBZ^9UH5D44]GQRE2AXMJKP=9V4H9-WdU0=8RZ+Q;)QUGf:WaCMLAB_Pb;C
Ucg+@5L1e^JaOC6;f7PWW40F,G;-Ee\+7H()AYAQUDHS;>cSU]_Va@f5aHcPH+67
:O&;bX5Ue>9_NUCdBNa-E?SQ@734S1X\N2.BR+4S0N,bS7aYS(Y+b8:(B[5U]_-I
J0Q#P8,9a4<[^1ASbW\6V;(+QSgKgL?aJ2+EQIEfdGCW^gcdJ,FT#MbWC24_36?<
eWN#E]&K\C_YeDQ_S&X/4C8CLQ\8J@S&KUJ#TaTc_\a&1PIW9ZT(@>VSc=HF\YHQ
6:5a?IP-,_\JUH7QNa,:.E:f#<K)@4ZL^+1Pf9\4=Q?gQ-c)3X/BS^JRdD37X)[A
+VBY./Ra#HUW;AQXLF=FB3FNfQWK=5##YeGg7KG+JMECE<:eO5?O(-e(eJgUL\8Q
P?ND2c+QMHU^K.&.U)/ec+4YYXX9O\.[cZLF:\b-5-6GG:VDOJ^8b3.YW>C@J-_S
_gKY<GeNTMJ;4+3ZPOa[TL[M&<FdA]Z>N(6@<[[W]VQ<55c.QI>1A]Vg)=[8a7cD
&LFLR5N,gSeW&?P(]g4ZJ[PE45E8e9E&96YMRd4C9/QBMI<a:IHT<^M/:D6L:2M2
(H^?\E5W1H#>8Q@KWcP@11.^L@a4GY4H#,6>bU=:F7+AE7<5U)0L-RIF?#+^3EZS
2]<31?CE@C@ac5].c#>&f(=d@KffZgFY&E;:8K#b<V:2Y^;g\6FT#OcV1AH#OQ,\
e?L?=Oa=F6L/AgF&L1@Z(02cCC9.7N3#4)BNLdcd,IT_9JcTN0gagPb1LAU>FF.&
b\?7ZdCN#g\W.M/gF<>I,dE=/7;T-.fe(M/MU(Rc5-O40cE8M59d4C&-,)PS,S5I
K>8c++@[HS4#cQ.T[44Y@T^a>AOA+Z1MWf64]UJGVff)[-J=Q<IDP9PHfeUcDTaB
[e3/bU+Y<N@]Y0AVCS>K<.@-5@=_,L,<6@-2eG(A8WFF+/LJLYdE?>ZQ(=0bgU^3
CJb5I@+b2Cc^3gY&EdeJRe4Nc6M(-2bcZ&]ZfO->/e5@@U.=]bX5NWZ(TH4XD)Ea
PC9@K&=XeGO2T9f6^aVKc/)?A3C,I_MK>(_5J&Y^b&S9bgST;&;E:3Z\[cGR+eAZ
dO\a^9H=]-)E,.PGDMKE(XJL;8g&Q52Lb>GH>NcZYf7G+.QWHMd]6R[MaN<;5XBV
V6^c8)?RO-DJ7N([I&?ODQ9Tb@_:Y-(]C24V@D<d.@:@3A@]edOLYe8EQB^3HYH(
?Y,d>cdXTXIYB1?>CZ8YF-,L]&JgSgRD_7KE\&T7#/PXYcVFg1+fT38G@.>V7B4>
2MILd4T\H9#N?.-]=MJ8TN]VcRG?DQeCX(P]+MHR(8?4[dR#.OfX\0a230#IbXR:
=aF4Lb:XZD1VQDg[WK)?H>40OcBQ#He2IF[M5Ha#DffgY#[&g7BBAf:e_\c9UH7;
E9=]I:;=-b<:\@f^RZNT.92a&BgRG^\W1N.I5_D0<<6RI9bagS&0^ebR.0B5(]Sg
-^Z]C<V;41e^XDSg4)cTd]2UE3G9La7U_AS[aX67?#.9I72_>d2d_c&R+L=5_>Y+
3<eA<3B_)U\O#Q+><]1BQd<M7T:NgKcaCP:bN=O\G;P?7bC;)&_5RZ<_ODGL;U=R
2.R]V@?5FYJT+EJA;e+g/-_g;LXO8R83H4+-4.S4-&d3@&@NO\[^U7c.2&bR)a6Z
5JaF+R2P+]UN8g&gd;Deb[U,bPCcLLN#GZ0##^f)7gE21G0fFCC=Zb6>[#MPDKcZ
BO7fVBA)\UZC4gaYTL-YQQ5(=efbF^]2&#/W;M2+V<3&?A1dbe^?S-9.3GC?A(a/
KZCfAI<^0e43^5dDaD??Q(@?7E\cD#:]1+YA@gM&]M,g-]Nf-(EFPRF6>;9UMUFa
REK9]gZM,/F-6[3(]?BKTH6<=&#?-/_L.,&O\^=XLGHTZQ)POFa53b2X3&12=1R3
,^d.]\FX2X7eP^/FBF];:C^^H,gUHQ/K&JdH<YdYY?6IUd_ga-8PAYO(KJX4O^-<
:I2dZb;ZB?1de7TGM4G.WV:R0=0@9/>Z+4JZ;-YXW;IA/&/C)Qb)NJ6M8&4;W(R6
FRf3FfO12L>14fc3P?9B<)BD/]RYg?-JYgB5HUYG7IN;ZC+YYgTP1?&40K^@7.>Q
5#077>R[+GG/_Y\[3Ma4E+-L38T=6\^9b>RE>(DAU[&)_.R&+G1a[LS#7[WfUeI6
G&P/)(301MSWN:a_UQ/V[aWY?0?K-G_PP,HY&U;EAKd&:9CKR>5f3J?]B>&S63g2
7A-ba[,J;-A6-6C3/#bL0YaK)7\C=+C79-#Y04#2aNOS5K27-<<SK;MQQTSO1K[>
[PP>.CO7H_4+&WWKJOULU13TZe3)N2VK5+718<4gIH:E0Xa&<NSMF\Q_QT4D\]WK
M)KQd)eTAFO[[:]G[PQc)-a7>2#@\JS\Kd+PV?&M.8OOMU_HE];NNa(L9,OHO_b1
T/B^V+UdS3=F&OP]@Z92Q_CYWG^@RfAKfM]CCQ=G,c2Fg??&[?>:EP2O<P_JA#>C
=PfRER_S9)#FSbd70/EJEL?Y379;5\HAP_;LAONPC?C1X(&5H,JV)=cQ+0HQ2&OA
eN#+;,,5B@:/6V^3R>@0/T&VcVIW7e21&_?63]\E_<^@APVg.F2O1,^#KKL@A;+7
1WM3=.\(8X&I.67K-:MEOA4K+/,6\O]#-efJg]A[YN75(dW71I&<J@f/0XW@9UVd
.IX<;_S[D>D58SWPU[BBcV9)2U4;aR>d9L(0/L,7f-+RcS;fEacGS]BZ0I&F0J+b
B5eS7WXSV#?J2S#_B;;JC^+7</U8b(WFSSd/1CMVDY.B.+6OJ]\O30dJ:ES&JR)8
(<1B.@FFDP99aI1JJ+Q/d(I)#85M0O);?cD5GV7;D&fQ[)5,aQ&@T<LfL(JPU;IV
)M5gC4gE1#QR4W<a1H]LP&FbFd/G6b=)cY1(>87+.NJG=-?&,6_dNgK211,#efe<
GEK([G,bP;WO:PYG;R<Y56(NgW^\bDYX(K?0fb(TMbA_=I@3Q\cEe(FF,O,6NZ4=
]V9Pd\-E+:UZD095bBW)CJ;[Y>T.-W1(@R<7DgZ/QX-H6N=Z&2D5VRFQS?-8Se0&
^HOSHG_@gFW@MH:W:aD5/?L:#_C?.Jge/:@<@.6b7.?+Pe)F^NF>3bF>VH=N;2f=
[@.-fcPY\8WO&>>];_2TOT_AcOYK#?].,W2,\3CaZb@;U+\U@c>J[3P+HVa:I_d0
V;Fa<Kf6.^+f2E2ea(4U6=-SU;;bD&7eE@67\V^c4.dZRgU9_N[TaJK/A&A)(^?#
f&#EW0QY[fc[RDeVI\A&aM\&29M2]YQZ^cTGWC403E,J^ALXDH^6WP>/YaaH;05T
[=5J&.;7<>N13@:;Pa4;bM(dX6W2Eb7eZd:g0gaGaE=/ZVaG-IK[2):4^+fRMGMe
&&bZ#W0P8\YbZ#bCVgcPc.0@9cJC.e#U)X@aaa4HASWg-K-1V<1UIeHXXH;YEML^
(S0]()EQFf@2Q4?>LV]QN3W5N(+HO<\ET#X9;OUCSCG]V2a?1(,(eX+ede.6#]-S
A1\H]\42Y,EZ1g>E9RXV(@d_9HVg8Z^0UBO[A.:4.Q^\W1T^\V@EO8YF1Cb23Z()
B7GSA@Gf_SH<RM9PWYAYU_F=-O&_:BAU/_(B,6AN29ENcKOPNYTJA_6OD3GC/dOf
ZWM.8=R=9G.)6TU0,57c1D2Pf.1^W)?;+&+E\[(dK97FTU_bU387JGQCHI\UdGd4
-eHXNH37M11TDGP?@f?LGR,\dg^T^+g#7ON@73WARS3B.P>Yd.TPJ1eKC->R)2T[
b_X<2Q7X[B_2f,DJMT9-5H8\#F+79M3g>V>K>I14]38XL\S=O9TfLb]<MOe=YZS0
;R;=(?6-UR7U-e?Y@R<D-&#A&Q5d94g9Sde?XCYA^_Z9Aa^ee^E7<_/#:M5G37Z@
^W[UTQHJ0=L?&H[9B\(:d+6BHWAf,68&AI0E7690\cX9LWY)3)P9H,^9M7^N74Jg
/Le0ZN,T:W>B4@RKd26KC2c<a-BR#.[?5O.IGd8LW#@XFgHb&AJ.gV8/8Nf9LfU^
B7b&_O.1O.,5Pb&/e=>99+4F,;d;^:6VJeIC+7C8c,cSf.H)4aN[D)<WU=9&c/DY
DGcMEFSV=CZE.T[&Y#9B&,T6<a<VKSM\JK+LEMR7L@(eD9g?,F4@A3.;F=5cJ>8O
J&4_gS(B?_/#Y,TRAG=T]F>SIGLA0._U_2_@4+3426U83a](99T@(U:F_bW(W\ad
XTVRe[(^_eWd96/+7(cgI/Z0HZF0_EI;<[1#-\0C(GM>A(8bL^a(-W6?L=/1;(9=
,TE0V@V#X_V4/-<.ULR2L:JNJ[EYA)ETd_c+82DN>)I[-cM9deL38_>6D8)L4MS)
(#D3G>>UKP5@9[KDHa.SS6ZE=[6WEEeD<PYRU&ME/_A<_SK<VQ4CPW78dF(b<9K-
JJHQHA,]2c^__0NIB-1@E(e_EB(+7N0J(/bDaR0[D(.8KXP:V1+3;H:DWQGbQJ]C
&Lc:Og(R4AZ@8EdcJX#00=QZRL8bRPL3T,\=X(8LYR3M\25fLLS05VYHW^+E\.[=
AE9+UMd:aB]C0WZPJ1J9..+Z3^:L:(P2O/L97@\,N#1C9cP>:3Fg_+PC\&W&IRKU
3ZHQP2c^+]S[?U]4Z?J@;Q#15F+2Z?&&FMc5ZNYAd[0IG,@FR^16O3B4_7#[@)]<
>ZF^PWgRES=_d_b7QR=3N@XCN#V:QH9:4D9BWQg+c-1FF\e3<XBDMMfG)-3BXa\_
+;Lb-CU\\PY)A<,f74@Q11W(H=GIa8cV?g;<edZ<LL]WcAaK<0FLf5ONWR9R&)55
/_bERGZgF4MPDGc_<#>+YOL?^XW>1@>BRLE>>0PEVB723fT:d3G00/;&;F-H>+L3
Lf/]5718/dEPSC119a2S:F]2>CReUH#BZf<+4]c-?1XOgPRQUU/EdgHc+E_B7:(H
\S2Pa:I4/9Z3>N,1ATF^]PXSC(Y0ec^0KYb7J5\6)BbCZUCg^bBF01S>dF4&X-W)
1OP>a0ZB.T)C6,OZTbB<+I:S8#^X3Z:U\aFU?P2T]/16_17:U:=A)0?FAK<&@<eR
?JG<=726BN>_46BSeHLC3_0]9^6BTfL4=JN#>.<LA.@@0<fR>/^W7ZA5Q>:a\e,9
FO(ON8XL0_PR^QS0_Y.)+Y,e>OD?:/a(Be6eXNO=:0((ZA9]:X_eG?gOQ/1N]FfD
J[Bc>DXFGbUN9>+AUXAI8G.MS:dC?+C@Q8<4PO-YI4)[;1VfE#G(<S/?d2V#Q\;/
[521C_0DBO(F4TBQV@8T[GY&+PBWdb;[JRV6WIW8;&=\^W,3F0BPZ[7W\2T<?U4^
XQbIX[Fc8E7[bJATS6.+GY_Of>Nb0><SKX,I1EHFSPG_DKAQ<4:]#-Y9]4..E4Aa
g/]T1gSb;NI>8Ib-5Z)@DCSB#bZWRXeM<gA6P_3[NYZDBY2=W&ZY6PUJ(;9D@AIa
58f/E55E7<OTNX\=]E-c-DF)\U^QKT+H?U&[dU^[\^[,Z^X8AZ\-5K/>;QI&:OWK
[CAI09LS3D?<BEQ_X5A).=>FU.W7:H+&)^:CMS=_FW;YOaK5>f/BX,2=:B+;/EZ[
KC+gIa(Ua_]PC[K#U-Q+-2Wc8)98F<;.@+DLF@L&]b)7a]141L(HYe):F=M<+8.Y
^fOIE1GGWaV>-?6Se;acBYEX<)FO>NS#V#UY)4N23M.WcPR[c8DWAaJ@6-[1SfA@
Oe-^ESaE)Y^JUeLH>7NTTKC;S&SH9E::R;+YdFV0U+DeH^)NX-Z\BLC,f_[)e],4
8+:^8G\AM0bMfbR2T-+F078L##R6RBdYPG(<I5MN(?O3,^72,WQA&?L?]:M=UMN#
QPJ^Yg=18UdTPNaM(9TMP/IF5/_]XfgX-g\,a:_cNW<&?X9)U9ITbNN&6Ra;;&Wg
>3(Jdf;S_ZR:=V(,8F\+4.&WOMMWQ@LPV5(RDD[)JDHA[OT]+)_[Tb)b?<SX?,JH
G^W_J<c8KIEgIJ1I/2He.a2(Gd<?=,2EE&6O)9)d4/a<+#Z]-]M/6[?&b(cIgbb&
_[:BYDa4K.WL@ZQ=W(,8=Te.]\O?6;S&SV1T+)aP)I<W]adcAS:=Vb)R\C4N8-\U
R?_M>SA>XA3=J+X#N^Eaa^&,<TIH3.CX-1P?JIE9d&@afBA31<[[624C#.@VO>(F
X7AI_FT8TU(AO1T3c-2J_.P,QcPLJb,=60NA3+[H^^=1N];C^N[Y:8)5.M_SXQdA
N_H-0RA4@/+\2.d-CT9+O-OO:/MRJ8cTLV86GQ?R3^,@N7F>Sf#XTKB+Y>ZKc94F
4,6#-X]V]9H3?P+D#G(S5W(3D3Kc#:eG\5bB8,)TYVFP;X:N3)X;SWQQFZ;gT\+P
@HPDFPFTUHG3,$
`endprotected


`endif // GUARD_SVT_APB_SYSTEM_ENV_SV
