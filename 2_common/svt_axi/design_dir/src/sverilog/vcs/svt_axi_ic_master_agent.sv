
`ifndef GUARD_SVT_AXI_IC_MASTER_AGENT_SV
`define GUARD_SVT_AXI_IC_MASTER_AGENT_SV

// =============================================================================
/** The master agent encapsulates master sequencer, master driver, and port
 * monitor. The master agent can be configured to operate in active mode and
 * passive mode. The user can provide AXI sequences to the master sequencer.
 * The master agent is configured using port configuration
 * #svt_axi_port_configuration, which is available in the system configuration
 * #svt_axi_system_configuration. The port configuration should be provided to
 * the master agent in the build phase of the test.  Within the master agent,
 * the master driver gets sequences from the master sequencer. The master
 * driver then drives the AXI transactions on the AXI port. The master driver
 * and port monitor components within master agent call callback methods at
 * various phases of execution of the AXI transaction. After the AXI
 * transaction on the bus is complete, the completed sequence item is provided
 * to the analysis port of port monitor, which can be used by the testbench.
 */
//typedef class svt_axi_slave_monitor_common;
class svt_axi_ic_master_agent extends svt_agent;

  
  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual `SVT_AXI_SLAVE_IF svt_axi_slave_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AXI Master virtual interface */
  svt_axi_slave_vif vif;

  /** AXI Master Driver */
  svt_axi_master driver;

  /** AXI Monitor */
  svt_axi_port_monitor monitor; 

  /** AXI Master Sequencer */
  svt_axi_ic_master_sequencer sequencer;

  /** AXI master coverage callback handle*/
  svt_axi_port_monitor_def_cov_callback master_trans_cov_cb;

  /** AXI Signal coverage callbacks */
  svt_axi_port_monitor_def_toggle_cov_callback #(virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport) master_toggle_cov_cb;
  svt_axi_port_monitor_def_state_cov_callback #(virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport)  master_state_cov_cb;

  /** AXI XML Writer for the Protocol Analyzer */
  svt_axi_port_monitor_pa_writer_callbacks master_xml_writer_cb;

  /** Writer used in callbacks to generate XML/FSDB for pa   */
   protected svt_xml_writer xml_writer = null ;

  /** AXI Port Monitor Callback Instance for System Checker */
  svt_axi_port_monitor_system_checker_callback system_checker_cb;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_port_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  
  /** master agent instance name. */
  local string master_ic_agent_inst_name = "";

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_ic_master_agent)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
  extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components if configured as an
   * active component.
   * Costructs the #monitor component if configured as active or passive component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer TLM ports if configured as a UVM_ACTIVE
   * component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif
  
  // ---------------------------------------------------------------------------
  /**
   * Run phase 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Extract Phase
   * Close out the XML file if it is enabled
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();
// -----------------------------------------------------------------------------
/** @cond PRIVATE */
  /** 
    * Returns the name of this agent
    */
  extern function string get_requester_name();
/** @endcond */

//vcs_lic_vip_protect
  `protected
Ba&(?_bW56/#^L8fR@AdZW7W?A7C:@,C^EPYTfS;\M=BgZCSWBIG,(JG.<b#_8Q.
FJd.3M-S&&KA_\?Q(Z^:SVC\C?:F3:CHa/QUeH@;f>+_)Ce<49,SLK6>gH<c#H]V
cf3DCGg=Da;DD<]bHNdfJ@@P,1Q_&[5VO43^)O)a9a?A[f[abSgOWVf4>Xb=AYIF
B7#fCB,>fS^G=S2959OYF7CFd_0YEC/3bRH3UR04F2<HRgdf3=YfI=;b5]AXINdQ
;X\a)CLS7^e=52+,,3&Se4ReLRSU&/OJCfERgY<.\DX#?(P>F7<VV:.\UV,P/0<\
PNW,@;d8Ce&c-gIVIJ1S?22HHEHR^-5AK3(>:URYW/(T?d;2]A+3J7P6d_2>O9Ib
.A&e.Y>K9S1Q[c87-7H)g>,.EVgE9A@]X)TZZQMB;J2KLe#]MLYd-ge\PTRbTT/Z
&Z]?(da]]ZKSY]SO0IL[fR&BNXFV,K8[PKC),=9,b<.XA0V4WVN#IRCDFC()\N49
><6;67^BAFFS0$
`endprotected

  
endclass

`protected
0+.K/NY47G3fQN\R)#AF70MG?C,DPRBgb0V#V(fI>/[Ef-?R+]+,,)[NXBSg0#YM
&/X]P>.F;1J<=\4G;>Bd[2XH6/WGX3G7?=D,U\?ND=WYNG1HQDLRN;@.0O(:ZF]8
9=Z9]c1O(M+12U\c<9#55.94M1ROcG-9O;)E+J^OL[>,I2;\9H3X07.6+K+EK>]G
BYBL))I3J@.b5D/M^+WW<SK[55e?X>&B923UAV.GN3;TP?@2&(MK.=a1@g4GH:OS
.W;ISRVd5YA\V\\[W]1WNPR^dI9/;AI63,B[Z8:JAZ.O+HM3WLA>&MP_dFbR.BWZ
2&fQ>PH(a\OS]L2FJ/PGBI+O<G?T8f8a?f[#/H]0eVAfdAN)4/\#TK6??(Md9Z+^
NU8>#=aNJQ6=YNN?VcQc+[L-3dJ/8L6FK[D99JgD]J)?0WDe1G-0E76CR/_2.3^E
O29X.CW8R:/9B++K=AXK6@;8F-7\2C2d9?;OY.B?^D;\>6D;@^1H]PUOM/O8+(ZR
\01G/dAa?G85b[[J)/FEFQ;84$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
g+6C8T[;6>\X^PgV.1-SXSG&;O96c@)(=fCS(e:DeIJPPVH2=O6(3([DRPdHB;Og
J^f:aG?@2T6e(,CB/0P71YT;HO(-X?(>Y_.L/A<#.@NH[dJ;DXK2Bc&+5WSVBNN)
_Qg&2;X7:V>R.Nb5LdE;<DO^gP_U?YR[d^NPRICRU_P@afg:;]JS86,):53>1)QL
<^#1CZg:U]BDI)-,W^a-\V3Q/8RX&<2KVE3H9E(D:4(OR7^FgHTCCK1SG5U-R?7M
]4;Q?)c#(9\K_bWEa\U8TMaN\6]L>G<49I7?\CL[5\9+II30U,Fg1<35>3W=Tb>R
;T8eS:[3S&g?gV#NF;Wac.YSQCVQKYB@/W/+VBbF4\FgeSR1N8PY2YaSPMM;)T@)
DL2^.5eMHL_)#-4HW)AJTdcQSVcI&J0LDY(1BV;0fIcK:>)d=MS:S9BHJSJ<NRYK
T0;&2C+Q[/K,?+2TP[1ObV&GJ:M31.b6WV\^.A&:Xbd<(4].K4&R^MV@1N0;_EHK
:.RFT2DA:(VO4:W9X=?_WE/3I5dD6X9bf37a:+MAPc/M0O/U+[_HX;W=<=&\MS(P
Q?BR9&:M1Ca^/WAR16_,8.?=8[_0;UM,VAY77B883FVEX;QeeA,g>=4LCb^XWMTV
9L8B/D8S]+[33H42DMF+2&0_Gb;g3eE-0L?;Y(=@M?I@Y09OWEJU5S:\XbRg6MXR
0FSI2B=<H5(SNC]:+d88I<?7,/5I618=>f186LI7C4GEG>4YbQPY(]b.6SV./:X#
L/N<2\3GMO9AA(MBL3R/ODGb4\<].1Df;7QLN@\;>bA@@78S1H[ZS+YbW>BgC7NK
X[H+f&EKWaXTJ44(b,RN=f]VA)WAb9UB(:RfJefC\MT\XQ>\&?5V3<0XP:R.T5(Z
:^JOS?:ZD-NE=&[dKBN=Id41<]+98/:0:aNGX3E+eARZ/5Kb+W5gSc)2LEB=(:GU
f.eI_JN&agJ/\DPTG&e?&J8aIY5)K(:(c+UEP8JEVS^R#--b#,[T^0X]d.(f<CP=
Z88F&VRc,f@Z#cB#713,SN<X.<L?0Y\,e#S/R98RD9IJ[f.&8CN0_S3]OA)+?ER@
g0<b=@OJ=VJ#J-X]fa#GT]T7WKT:+5K8Hf4\FA7JFB4@D5W>B2ZLB:c(Fb@JYMY]
,3E_,#7J/K8F5#H+_AI5[LKf+8cQBNcI^<E5C:\XJ5QZP=KbFU9^L80::;fHK7;F
O8DVAe9TCXdL&R7^BSXUd?1GJ0U;+RF5X:.Z-/dbbJA(^X68_DIgaH06g\FC<^3d
Xe&e^g1@J&F>=UE?&d]^Z^cRdCZ+B6L1ST4DQB,K;.BFga1\U3^/;7OC\]a#f]FX
6I==A]E^ZYI&,V=;7/FdF_A0.]UgT-3U-B#8d;g2G:J,Tcd1,T;R,J+S3^NKGgIM
;.12#=N:W_-YP-/6KC&_L3]?UW4?^&6Z\VeSB1d8M@1[W9GIE3=7JRE^6F>;d:8Y
g6egZH79L]D4&1QO\]?R._KH.FMQ/D[^ccd^8EVLDCaNcR/^Y0KXEI@=Q/2JURW8
#JKCCTe,A[c]VZ2cAJb0Cf?dR5JUbH[.-_ab;72?I8:Z)JL)S:&5650HdXBg/9NV
(]bFY]D<>+7HE\^LM.]<-PP\A>\&A-:3.ZTIZAO1_-ZE9->3^9feNZ4K#bf3a7I-
^,ZQDdL&:/aVULR2TG2#e88VCO(A[7L/EZ^[Q9@G+?GKHH6REc_e615W4#X<BU4&
dJMGJcBUAE/.X]^TKE=U7_ZOMUXfd5R[aB)Y1RUW7+L/C(+HR/;<WU(@GF<QFc,S
/OH=Cc?1U@+SL1=7+M4g+7RL&9Z+P.6^VKHN#W77:,cCSA;0f<618430>G4CGN7D
]aV0)[eH30,<^P@=d:FI76aO#;>3I4a4?+QUU,@SOML6E&_.]F[5]EQ\6==XBAY^
EJGA\gD\@+L@=:<A=bGLYWVd=3PA,Y0RFR<DEEQKSB)FBJfD,C2MX>ZMU552(>:2
Q7S&]+>E@Q?\<&ODe##^-gU2N5B59HB]^.@EZ>J1c869X)^XCcBMJe>5PA?\cF?1
V@.?^2Q1g<[_O#8#88JEL@eI6N60ENgC9G)]Q\d5CZA9E_<T83)C:0gL#;C/ALad
KdW>F&GR^#56g;YGWU7ILYbHC+E23IRRDHS-Q\2^L(_Z<HQAf4;Rg4J@[Kg:P[+]
02/EY+Yc.XY><LL.P\E9>]=<]T2Q_<54XNQPAg@FXeN)J#N6W>2fF/3N8P@>)XLg
PeW3@C+ULV?aB,a-?M4Q-?<E#3cYZ+P_0-ZaeB1MQ>f,4+L=OM=GS((,?P,caFcJ
QaXWWFCA9DQ6.&eL05/LV,JFV[=VTa^@bPK8/;HQFY3]2<?aZ3[VJ:L[4A.>19+R
C25\\QB.P3I,fD?5=U;D26;GGD1Z+2JKZH7e/K9.KIDd30^^HfKR/A27HcL2;/AP
WF1J0Z?AD&g6;Gg^e2@SYT:H_XXC=C^CY__E3)g68PV.:R<&CC??;OGaMbf_QX[X
]c=a]7,0ZU^MD?HKgV-Y(Ig88@P?F5_)-13,dde<:f-+F[+@Y28/Vg/&,QaM(b:L
_1?RISM,c8])-cA[=UM?FVH3^,I,D0.Nc87fX?9Ag]08dD9gP<&9=Mg]1)Ne&(HK
?-K&bPa?VE_2-0FC=N@BWG-gI-\[UeOPJS@UZ@:/;]EW(_d+B6Z[eHf-&C(#0ROW
NQb#6FS;7H4F.5:/f03+Q-_KLBCc9<0Gd=^[V/-VRVF/\/W&T]a&@D--#d@J7IdL
B9^d491>ZA3?DYeI(EN&Lgc,<]3(OD,V9bI?,R?6,<GJWd>YaN1>^R3.S-\e6f&J
_IC\\.]6GHc&G5\)Q<B5^]Zg@6^2L=.W+1bMF6&\TX@f2\Ua(&EYVDCg(,OJ3IZ>
KU\S:/0:/&JB0[J8B@MF3@b/+.+/Z5]#ECf#.=cVaTf)ZU0.DYaeSD7B^D:G#/?(
&+=UV>:63gE+V-fP4[fXf/aaXaf9XCAU)GeOU@137:UI;]]BFG6Se73C72EgDXbN
cUGaB,U3<O-Q,U_QHH;(9PPPM<be>Pd(U)=J8O7VH)QGMe+C1^^=C(L[XFEFXaKJ
Eb4:4+XA\Uc5X/JQ9CZ&DLSf87:9RL7f3M9fSLL3ggTHCTc>e14JQ2YBc]F1>.@L
FI\e^I91D^JL;A,N:WaURLISAaAB,/0fMea^X5]2PEE6DI7FR7V69R<fUIFgO]QL
HC>+Qd]E>e[1/C1_I-.24e^]4CR@MD[XOUG5XKS_:ZMVT?/dPL,^<-e@C4(46C)(
<KHD4Nc7I@+DXY(;IFYADaE4LJ?(0JD;9L00>ME819M6]J&IRO_3a0D[Q)/TeV+J
H@eB\,4S^M-2_+&^P8K#]NRBTDEdR68Nc>-O[)?=@eP5Fc<,#03>8U-F<ILG2R/5
-(IG,f9@Y4Wf0O(0Cb2;WL-Eg_+/A:#MBF]KYdgEG+E6T>Xe\NeP]TPJLW4JAZ8g
?0(X:I#E3La2cKS\)9^SbSdNMMG&^eg>^@3EBN),9.GJ-_89\8/&467T.L[M>2RV
4CQV&ff<>MZ/Nf;>,T+YRb?;YHQgPGWY4D+E.QNS[_31?dLNeQP]0DF;(bMe.)7Z
Mb>)M7MZCbSef6EEIXR@X4K_PVc2A)P#2J>GDZf@Se=90:8T:[:G;,(0H[#P79)T
&)/SDZ6TG>.\<Oa/edE^[4>d=JZ#:XbS3;DTPSHe>WbI&Z?,?V7\X/0LGVXc-@G<
bVC)64PX(V0C8B04eE7ZUXa(C<94?;X.J/Y(BP3R?IZQ&Z[>TP-9g=#Bb1F]MCSZ
ENVMX=Xf]AU=g0C#aS>J:89e4&BNNH+5IBPUNZK\f5a,-e;Q7@@9PcD.&HL]8<44
P?2(fWK(EBPQPZOK29[K1W0D&\e+R<5g+L&)FKLH8IU;8UA95968_>(Z2Lf:J?@Q
KQ,);R-?[&2LE<a9KK39:6QGK^FIS\Z1?AOe>S&bGQ_b\]g<&9-.BWHE\)9;Zc0V
IXLNIecIN:FVCWF_U_,\>E]Fgcf@0@W+C?,DRg53&d+.Q<\05JQL=M\.Y0DV)\5g
g:U(IDGJ@P=7UNYT5Z5ZP\=?P72L^S[dT8RS1[J=VY-eR=;N7.]FRT5W-g<GY++?
>Q-e)4Q2IC0\@YFWd(9dGF;:.6BQKXE#+SdG>TEQSK:?O&[(b@O/Z?<g5Q[]:YCM
aM(dc+P;)9F5\LOff>Dc\L-X?9#cS?_U4,F(e\06H(EHI2F=d#(7^INL9G#]RP78
O--_4D<e,Y_R3^aTR)&]8\AU_=9]C><.FT]ePPE@0NN)@6H()ZZNb30]c][+_Z[a
.+-1O5-f02,(=d)/R:@F7<@[\5A;,7.WT0_;TF7d[#:;T6L7-X^ZX5?H>L+I;dd:
[P.1SF7,+P_2KO]ZBOV#3&WNI[0\PJ,]N@FX:,^.-a7BV,CU^N=_TAgB&g\M+U:c
;76UO8/9J[&IHGKH05d(ZW.NMU2U6#710](([e22UP0XT3f</cN42&E]b(e3_4e>
DLT<V#WISI:P8S\V9RTZcNAIU2OP[A>.#gbO=:]a-aA@fVFME#b.3VS+[09Hc)T<
M-UW;PEH2\3;8;>G?g4Z3U9g2<eVGI^gg?8V/M9I.3N5K&9\(?Q56YTea^)HgET\
\R?-1.(dCRKag=X4=DFe.EZ5,#U9=GWYTP+,#R?/LG/9)I)U3?A1Q+DPGOdDB/^S
b85I?P@gJR.@K0U^Z>O/9_?WfPMf,.4LffFG2dcFCY6dE):\8<NLG7W@egZ/R6M5
WD)AD&IO,WZ6>\KG1SH-^_6g?43_c49#GEJSN^Dg=D^d]7RQ[FLM>eC9=MR_?acT
We[^/b5-HXaY5/58Y7-J0S5BZ0Y/9J=XG,0P?Z_-0^&>.-^[(:f0,..Xb,__Vd30
?[3a.gFOC7,OQL<@FDf42fWCLW#0PEBE),K-GGb72K0=LA>G\Mc1VJ4>C#>JX6ZK
?fP0G-^IR<IA9IeQ\>/#Z9.>.>Ug;4C,+1?R9]aLb7VMVP)C-G+?ZLc4\bJQTU^9
6P#1>&L)Q]GCFT>46MCT\7G5X^f[70f4\EF(+_M.6;8^HOa/WY9gE&O[)Y=<YT>:
gV<&E10/QS-HU34S94Q:XDI]6N(ZE)@E@\d]X?&>:GPCPE,b>_208[5Q_e<N&P1C
Rfe>9H+D[c@@WP92I-3Z:H&<_>fd@/SO?UJGPA2:abJMZ5cNddHc>>^#3ZBX5;N6
IRA]4VWNQMfH<<NMD[5H3eQCc=bR^ZYGZce5EJSg4aZ24CO=)d=McBNJW5gKF)[c
4L3\(,ELZLeN3ZA-FR<Z+)THP9?F@]B7V)65?6JX+MbBe=(g&/&S94/)&J200N2R
<?)MWGa-D<E@8>R)b=^GRd_]4>;LDD\0b2VSg8E[f/GBK5<)5/\^0H4.T=Qf&+L1
HH.>E(Z?4E?EW9OJ3bU9^.JT(\O;;OAF,U<D-.Ta=0HHN.GF3Gg([#Da\UTD-4\W
9cFPU)2-GX-Y@.d3I3:AL49S0f<@BGgNQFdDL4-Ec8X=MJfYf@^&BcbeJ[dOg#@0
aTWV0e:RU\eST#I6,]=Md1@&[S>aL]9a\YZU31MLRV9;9dMOGFR+3I<b&-Dc_3&.
([OXFMP,+TB,:A30;M^7M@<X>c=P[+ASFJd)Z6+CXg8RL^5+Q(]R3JYZMM>&?g:2
9.2]+#[0P([6^0JB5N]#cM3NXD]=,d)./OIdFWa0e3d.eb+G)T(5<<B3)T8Y]EYV
Z0,8b\ZaaLXRIKf8_G4/NbUA^TBbD3LHd)IN\IE0S;0)P,36a;b^aG5bY7Nf1\#F
/a#V,8A#EW<NTWcOd-d/ZBYD5Vba-Q<KPeASA3QVRP04Q(L:6^E/Q2/UfT>&7G)?
(YI7#1/0[BBPK+.7L2cOO0<N]IP&-X)<.N52]J#O<CC26bE-LJR?Haf\aK)+0[LL
Db8,YP)0Qc:2JBV=H3cb0>d3KP@L3_Fg:MOegUf4#e=RBfTFIf;U<]^6,3Z\7Y/O
5,^J>8&23@d=VS7TNFFXWHJ7FQc,<]O<RU;ScFD;<J<Z/&NH50]52TG_,d/S\74O
I+<+6(9J4MZ=AKY>O;BdgQXAE5=_..N_=#75^Vb9IK=eGDL]3G,,gd?FK_I[P@MG
E4UAH.\YNK0&-R6VRg&^JAF^=KVDZBJ)9J=LeME=BG<7-Mge:/f\T&HNPU64?<Q^
N,7M#4G\>dY7b4J?S[,V?,M81CgMYAT0CfO](e(_(GfS:,_;)3XVH1C-6K_J/+O7
-J9:Z_d<&NW_-H=Z-eN.;FM1;N^,G7UOg5A,[:P[EV7Y_0#SL4DF]Z&[D-Y,5&PO
ZQc=C<4^C3(VYc)e08BZW^C0S?e+,L</ad5WAS:B6KFf+G/(A@3M<GP.dJWZ/5RW
d9@AQ&VIQ:<CC5&_+M(O+DELg2.\IU,a:&bIcGaG]H;LO/LcZ(0+G,EAO2ID4(_)
#Y+>I]\1GPQe<XKEQLcH^W;;J?b#NAJSO<gNdS.e6&C=/,--OWI;)ARBEY6g3\M,
M=]\&:#]Mff8GKDL3<4(I320876:A\FQV(GS+N9^WUSeD:6FT4J,gYZbE,3W&g^R
/TY<3Y+9PIN0Y,P)RA3[T^OTM<c1gYN32QbZ<f42dGLE.1bVO(6Bd3eJ)BJE:091
_8L6dCS@\8eD48#NeRURILFGU-bG_Z;&]C=PE)+]YN1INZC8Z^cNY\XZ(c;dJ:SW
?JYPT5+D<Q45[dc:W01_KdWZ23HRQ>eISf&=:XbdJT7OOILe2NgcHcO#64.g+eO>
</56OG8?IVPAU(3MNB.GS=GgaML=QG[L&QPAS5E?AL?POMF)5/;HI<F6H[H<G\\:
IgT^O,2V=<NcbOV@?+[bW.0R](#>N.+1)-DELSgBgO1J;dF4N0HYZ3e9-S-_a3g_
JDc.UdcGaY2TXH]#f>g+U;3_/C\B4DH)cXKP1(QM,]7S?,L7,#T8aF=V5(-^_8EE
EUUT6A1;D,V7GE&A_aQS1C&UId75Q]Obed.f;VS7LUCLXa.Y/Gb8@^;?>I-H5Sac
GFMc:,\<,&(REG4RQNHf4b0_F=V[L[-Z:Gf1AVf?]T5I4)A@LB:\3,?YFQ7ebgQ:
]1+6]e8J@G6a27@<560L7_ZWR9gFZ>g^URXI;13BRSc4I:4_QZ627;0)..];4AYd
;XS6,IQ>4E-Y<ZPGFULe;M8Le,/gS.,Y//WG4\9)6TbR.G12_]X3@PLcaO>G72-<
a[LScQXC\?-b84^\^6#8#03DZ=\a-U<RU1eV9+c^Y9/XEgQ&+bAJMPMO5VGe)0@O
;UWSY95C+aIRZ_)D=B2N1IcfW(2A^-1e]?;;FZ@RFALf07G]#MgcVE7@X)],[d^3
Ba<Z2X.U2PQXXgZS\^0G0DRf>fb/V8#DTR4CN4Xd;1#2ZW2S<0:aV:(G<<,c]R7Q
KMKA_RG,BYdF@/4/V<D0R(^(S@,#OP.U:7OF_X_VW.]WCJC\)YUR,9BV&\7-^GAU
1Q2NF>\V2XU2T(Y(0I:WT,P]8BYE-.@<O@-:]T(d+OB=7^&&36/,]J0;;6eT:b:I
(#@.)5O+()^)76XHADK\AWc&-F@7bY6>/,\PEJaUH5A]E)M7[dAeYc54+Eb302]D
70C(Pe(;>028FG]Dd1e8&Af:N-Z;;/eFLUW:@JED4)J/Wgbd+.aG:&f<_F&+._C<
33\I1;2GFQ-1WA2RLEMX&RDFGMa]50J#68.6We1;-Zdd&04RS).]#/M0F&fX(]TK
N3/,fdU8:B^M^#];aQUL(4gUOe,WD8X1O2[1WO)&5.geR9[T]WXJST1,-RI(/MM@
G=^Pa^1^V@.6JcT&C1EQB_)+\e=<M^cG^Fg3FK9S3b=H:QNCF+5PWOMEJI[D.H,?
,cIO&dX#W:JM&S>d9?5J:(]=9aJ;O@ZC]>STKTI2)(8MEGFc>]B)_YA/]af_OQ@4
G++^(NR8>VUTU8_.->X;V)GMA6bAN[c=eXQ@Y3a49K4dW4L@D-+,,/1JTg;#R,N?
b8B;gW@0Yf:.>4F\CD2A9\1c;O&#(Q=d;V40QYPY#M-F\6X+S/SaID1T(\=([bLY
Jad(6#KH>a];]89UBM-V,\5)&=QY?HR?XX?I>DWE0-:Q?>/JaP;WRE\]\Lg,;g2M
fJX3DJ&G2e@@/UM>^CL^<-=a@\T[B[J3F,D1L+-Ic:=Lc?[L_9OJ#f?J,#P,DKDM
R;OS?HQ=<U6MH.a62/)S_?]fE]DV(=^?fL4<Te)0WLTH09>ObQC&9:&:86PZSCK;
MI.];2&XB8Ze\3b+L3F6Q.:2JY65c=D\a?/.:WE-.dT.1IK?FcSS=/f#aP_@<.\e
UVHSY#W-QRRJ^_?;DH#g=g?UZD2bG7>@WO[=OXeD,7,O.ZdSIN-V[:^\DLV2NJcT
>TZ/fe>AS,gX;1/GE91@Wf0VG:b9Z&:T#7b[CR8YKN59ePa0,V]TCP_^_?N>_J8G
KWcJ];W,NTYFJSWK5A\#0dQ/D<][faFcA^HJ-\W+C):FJZ37L>_ZBfF>[M5DPfb6
X)B=K3Z+:HDb&2gOU_fIe\YQPgGdZ0.JMf4K)84QIXA\4aeS>C+3gPASOS7FE(1M
7(>.XWJaY=S)CFe[4CD5SOK_?YK0+<\dI#0W,_\9Z>.1+-8=VbLHgYVF@M[8&6-1
MI(M/<QLb<57BZ8H_eYHYA-X1;XO#KGbFP:.EC=XKW=#Jb9J@Q^[@_Q)JFPGg#RA
L=[.Ubd8=0ANF</Q2WMS_FF9P.J9fC:86f]QWAXeYDA_Vc]&QU^1PF#W;ZH]4@&b
+2W&40DE#@&J>US-1#L\J1(BfU+<&19KL?_Yb#Q00;\X6H1Ja-8;cL<;YfH=T@7N
/[=5=@8P5?cUg.0F[eM6DL6IMQYU^8;9)Lg3V2#PgEJFK:/f[73@?A+DJG3_+9[T
38L>V@E;#ZFg+P?@.?I4-@7EN6QQ]BB@#,K@8YBK3HMX_R^g_-2[WMU<5<1NgZ92
EC2_1TPIaHCJ;0bI+J>FV_Ncg8,8QcFa#ZTQ54=2##6O/5\1Q[SPTGS,/O/E;G2M
2XGDTcf0L\1VRaD_O42MY[R;<[c8U)\E^WHb\70eY3^E=M<V<]=;g,bZN]eI4]Q5
d1[cX]?O-6(-1=L1#>YTg1YE6>MLdZ18,<[2YVUb8cX8S5;?,\b&=+84VS,-e5bE
QWLES;bYAJMIfLOUMD;/N(8@^_P>H^-5Y]VU^/CFT#7.NTST4NJCa9@<8_QT+LNK
.F,d_GPD5Vbc@aH1a=>e\GXSc@g:[[_=.<SU(9\[ARU,E[0.Q==<CNY\))d@Ib?O
L6;e7BLb(U?0Gf2(NQW9D\(DI;:XU/^XN)f3d<b\.A,d-[P5<(KASOLDAc3f>@cY
QL\YH+-2?a6TKOJP9SbU&2Ed=(dAL4084UI-TW8O95I1V:CWYJfA;H3gW@?ASAH(
M^J]U9>N<9BY+6^+P&Z3PON:;(9eB]7:@+(?e<HM#0(a6\^@M)&M@:-[2,F9<BE(
_bF+d9OWHBZfLK0=_&bP+4XTcdbOOTI>=L3+(8-P^/EP8KQ7DP@[Efc/cM-TXP^G
Yg4OL89J=C(MgagF#T,MG@S]C3V69[-22@afY[DHdV;F2FgA5\NP#14W>+T3TRCN
=AW^K9;6/f333EK6;]Kd^=K8C413-Y[@\YPTe1;\2EW]g]ba(DQ<c0[0d,OaZ_SU
W@Ga?F9-;?ddH8H^<RL?/=-CR=Pc&#Q]5c9)SAL.?XK+L:7K;Y@)PBc;dB<S\_^3
/T(+35#)41,:;5=7Gd8?XEFWfN-fa,PF<XM=-RIFKJ,=QY7]SUVdAG/35<(WG^0b
M_-e3#0fH+L\]>VbARd2TaU#99RKO[VGJ,X&VQRb9Z@FB+^X#K+Jg>.Z?USUbB[D
7)\6\K8^CL\VAQW[\[SI-GR)ed5FC)-\QbB1H7JbUUP#O8[,7,CZO8fH.daJ3BH,
8?7&85N^>G#RHXFYJ-.[-:&UH^C)Nd2)_19,)F5;f2X+5697(P@MP;QKLG]fZe1[
/JXCH#]R._YK,bS?[(+[ZJM6eaW8,\AS3+8)@9T2M\\=ZDUHB&2S3KZ<bO#dWZY]
;NNZIN4=;U4W.@C=W]<F1K/_Q^BU0L^\G&A)2IEFa]eJMBeT+e)^@9[A]WA.EC6Z
=_TSX-(GK=].;bS&5eUYYN,+XRXOQ(-YX_RY=C>Z,48I?W8g.^Wb[<0BWMS9]<B=
7457/d-+Z6AAO21b[NJe>Y2UfQR-@g-M@[@gB=cA65W6O:/+Q-^@[c^[6aZ?dVDf
R3V5R2X_<NSB3):.G/C/DFK\WVbO[[TQ>3[X8C9fb]F#\9Y7:2A3(4Df_/Z?W9DA
)gZgQ)Q(_02OX]03@JR497M#,Se)/5C>#M0d=DMLY?<8/&94I44BZ@BH<51P#93\
B0K.GDWE8HRA^-Mf-PUg3c=:H:Aa2;.@VN\3VU[G+.D9Jd#4,Y#4+JCV0J2QN7I9
<F>39UGIObI;baY(N7FYEI@3;6#H-7\1CXRFg2c.TOG-F4MREB:G@,e=.#[KU)_J
cT@=@M(M&aKTaT.c,:2;>G3CZ\S6WKJN]P4;=YL3#OYcS-d]20A[d[SZ<:C5H/0B
6SWO_MdR>+c[Z27,]#URN-2^=eXKS;KFN>9DORE.C&+3W7E#A0^VHQ89R]3cKU=G
IF\CBcIX1X:+]b/KKa_[X-d,N&2Y,cGJ6]E_>gXBdX:QO2b,>E35S/UEVRUD.Ab8
?+=cc]D#@P9dSKIVI;>\_Ce@SbdDgV;#XYdVC-:(TSN9[-UE50SN7:/2>AM-8^1<
G#Qc3+<V[f];4VIMTf2_\M&<GS>5GO<Q@#K130XZSI3DcSTbE#>]@c@f76]f;K;G
ZBg<MAVP?^_W.[/&X@I]R-e5&8BUfVgKF[975&69LVS5JAB=0.6A8I1,c_LFG7-Q
,eO^TMg?[da3S4IR7]-8?eW^b-FZa8EYN[M/WJI-D.R\HS3:FLNQ@@LT1c-I>((.
0/P/3<5Yf3U[/.N#SFUSgYV7WTWG>HR.^W=[0V1U\=DY(=IR6R31^Dg(H_SLK-+^
RBO>TA4]KO61[(;_^-_?E+/UIa/MXLa<2_]7TeHCC>ca0b&>8PYOW5&6+Ddb&9Y]
/@Rb]T;P#0WWC2L3,T-P_5JC65>dCc&F@_5b)AM)7LP9I.V3\MHKa61.+4_UX<T;
V#UQT/)MFe(e..YO<c.^g<bc42P+XU555?8_?W?\afV]b6T6eYSW[Gb<eXGHe_04
:JMDC]#;8B>GJS1HT.[N6(C:a1a9R(HB?@UOFN3\>^7\6HH]:]>0^3XQ78caBfI;
C;A/EV<ID#+W4Ae7A-1_G_O4)H3\#,b/NFUB-=^&I65Q5J0>&V=Vd@>R72[.F?6Y
g:]CI>USZ70_F&a<]8O1AS-[/4;+-7(D1d#59S.gBZYf_.G7GMU9NTe#C1,S^@C\
J5aSZ9gEg._F-3edM]8SRgKg38RcO5^fSUHCa0:6;5G(/2B/3QYS]+P]EeCUYRe8
S4+e.5UN)#@WVOL2:67K1T(AeLLIXB+XKXeBR(OLB.b+T-2URR\HI,d.26@SW#bM
X]I\1:0gJEC0<4#4X)-XNQ;B,7EEB@eAXcL;J=2WE_GFVPJM4Wc97#Sc&?5-aZd6
d5T=b&b;W=JfG[,4-3b-0HI[[P]PYPceC?M)CFUHOZEK-JK.JI)7&KU1M/(==E9b
C]BIKgYfG;=SY8\>6I]?C.Z.0M3C0I6(;&;ZD41;P.5,8W7bS3I/5\Z_M]Q?/UYd
L4fL\4-Nf\3NE>M[RebLa>M?WNCT;?,X2d9IRf2_0H(DC/VbJb?+G&E-S\U)N_aT
2?&@0^AcTM@PXR.I(/#F&MeJX8[RHeKJIeIPH#9WXUAYX<@aDeLO(?IR#d2AH)2[
fS45O2\IJ[JeWb+YDAB8?gDc(>E2agVTe[\<2&:@.:):A_M3RcV79_6]+H.ddVI9
Y&daUf\YHB]5A25/&ARX5;@NJVV70WT><:Z44CM\ZNLaH+(J\d.T0.g<?)THH0P#
(7B+67;_P5;(22^;S7LS3_7)0JF0V?\M6&4Gd[Gg5dF\9IJQLXC\0<=8DW?FFG=S
@IWJUWC6X9DLg[DCCII0c&V>=PZX)DOM=gPf1aXW[R.2T2Kb)T0:GK6]f.@eN+[]
;S\/6bEXZTHWe2W?^GHH=H-]DAgG4TQCI(39ASN<WVXBA#cX\BSf)[8HKeZfd.\\
YLH2SE0#NK1e:_KLN=OJVQE(AZdf3MAMA0FXLd4Q;aGe.NDDAeQ;CP.HS>RPGR1I
?-+A<<6K2OgD83.F0Z-9B8PeddT&a0]AO#7TTYIQ4UbW]B4c=cf_&J8cA#(+3JeN
>9VB#>)f\9QJJ<4XWeBXC@V9-[(f3H8_LA[B(&Lb\e40)TJ#bXX226S5Jg2ZbG]I
^9Q4)^)W8L=VU@&>#X19/g9+5cf00_QaM(P4L9e5A.IcgQS3WJ+L;0A:B49:bVI9
B\E^bI4I4?E2T]8/-YTdBX?AHJT=B1#Zg#=1H3:-8I@=VcSFgEX31HJKc\Q^O(6-
M_)5NXQRaWD6E6[1;?BKY7,-7EY:7a^RE-HW6I3UI??.0fTC4+D5H6-RV#&L+49d
dgY-S1NLgHJ8\^>HdLg^RA6.<S+EB/5]IGZ^81-Q/09GY7KVKZ50gSceJ:-9OB_S
,HL8_(OE,bQ-EH&<91L05;D1.G4_H)(O^Re:XFHYXb)3CA@5<W^#L30V1ge.3/PG
4KA;5,ggSGf6A+_;ELTB@dc>bX;ML?>Tg3/7PC)YT7)JOD0I=Q(g2F+0>d&BQ06H
8LI?Fg3C+)8BHH)6^/4_BV<KF^,O8BX],[8QQD-7P4d,V:I@XX]3+Ud83YS??4Mc
OcF5#_1JU;0C8R)4g-HaR<VB7/8^31GTIPW76,V2N[Y.Ca:QEe6?F^1R9V3[[(V,
(3eD\-6[OJ:6;dSgcKSV1W<>W\\b<93CS6J<3QZS?KN=/H&@2N.[Z=NgF?A[[bbJ
^DB?LX4DR0H057FIVX@VS8(3-2NJ@CR_Z/McT\=9)3;fRXbXa]&KD#4NI3:Q]@,Z
6V-YgWGXaa0bGZTFPNXc^=F#S&W@3TOMT0ALCV>7@R4GWUe5cd)>0.6FI?P0YDI?
?4Fg94HZVW3+U:3gOd\EVdT=QQU4KbF?.VYQ&0PUfg83^HHI85^#3=(+]>BI1TW]
?0VR:]M.dgWR_R,I3PVR^dfE1Vbb.6RH&ZIZQWE\]F)K/a?40FQ-MVeVX2c>@4.-
NDF=[[:4a-ZU4d1aGHaJ<Y9T7(I2^bZLL<]dAUWG04E+EDdX>R3]Idb/ASDeTN-P
#OYR:TU)5E-_K>cX&_6N+N#=JO#O#L7]ACe>Afg3/,PZT3g/P)Ac0@7XXe^R/2U2
J6@WMY_(H.H/0<7QP>N[7@564g[S,\3OCWc\D5CL^4Y2SY;(^2W4]+aFB<KfSRe6
5g_=/16eKGD;FQ+KZM;;gVQ_fEOMQNa\<>aLa.Sf]@#WL1._bV<FKadR^O,\.;Vg
NG=81+Z0P5=aLGa#X()<=DHWd7\9XBAdd^[JbcJ:)09a\+\&-^OXKVS-(49F:#^L
NX/S+G)\g05D7bG>(.3T<dg^ROF_]\UCQLPB49O@_->5><&dK/@X].53.U8BG=D6
GSgfN?3P:_PNI&P+^7+D;Y4f<7LV[?:Z2RIWbU<XHT.PbN0\?aIIJ(G7(RSda56F
M.MP\#[1F+NHHU7YHfC/c>d)+]+P(&F7M+KJ^B=7X.;Ke^+bL?OP8U]93K9&>,I#
HeIHEgR[b/^W=TO&@9@5D.9S.<#[PT&^IMS>EXCWR[bHXSQS=gXc9:KEF#dCPX61
WAVY)#7]2Y.bAKGY>X(BLR;3D:.Q05L;f;,fcW)L?5Q)CH/<E[EHg2=+[cR?8?bU
EF.ZGD#P25>49B/-Y@RYC-&b@X#[_<Rd<IA1,#/b7bH7YO+C8DTe(F7/gg&YY\dU
J,/8_/b[>_C]T&2F<D>HIc+NbPK;C6e+X,I<1L3@\@)6b;9@e^baDUL?5C3LHa(/
X[9MU>aeW]R-aKRc_@DdKL6QW3JP[)O6+fcT5g\L=6A\+32=R/Y9D<QMN;;_f#2Y
FdCP2gZN;YUV@;+d=Q;=#./L1K^\#:0a/@?ZEXbJKJ).V.)@RF<2&[Yd\X2\g-<7
T6=2.PKBBSa,D5LV,f0R6@[_gVVJH-.WeBgM3W;B^K8C@BF1DLR3Ib<KfaQ:XO<F
)#^#9JB23-SG<B\-,Z(PG^\MY^(<Jd?L2P<aH&aV>JfBI0L;]Ba87FU1PQDOYTD/
F85bQ+ML];-5a<6\0M:1D+[1b+(Zd[W8>Z\^N9V1eCaP[T5J#?VYSOE310F0;.,H
7.a],.:2BJeg/O@-/gR9MWff:d6)AKZ56]L=d@FD,Y#IQd3Xb3dBPOY<E^.9SMNI
R,9^N#5?dN0L5?;&>RVGAV?M;9ON-[FBbK=[([=.=SXT8.NdT.M#<2^<WIJdQ.eV
EO\(9#?.T-0HT5CGd_FG@.?>4INM\9,5\))FcVA>fQgDOT+M.T:c7NJU?(-0)(G@
OU^.]&PDOd=21T0]HZ1K\PBE#_02UdaC?g>#1D.\MVE.ZW@a&_fPa]]VTX,M]Eb2
JLSHJ@>Oe@N4eL=E^H5^XQZ^B#e;=&TM^b4TU5@V[L94aI^cI+G[>331I9f<00<c
Ub=;4TWf(F1+N,@0S\;BO?(?>#e5\a/SgXE_>.CUa=W)Bg^M:&Hcbg8NW+U<DZ8d
D/B#XF;+O+\[A&7ASK8-[:LLbV#LfF+_PI[CSE]7ZS&^FVfB3HN^:Od.fLc7?#U^
?BWEeLFU]D#]N/CH+=gB/RVVG/@a2->NI#=PI[S_(]gF,IQc?Z4(G@J4PZT:,FXL
GfG_DR0W;4+#])..UeT5]a4UcPKeG4.P1(CWGU0NEb-bS\)K0=B3SIU51N?<-FLK
13KfDBb3-8\FT[P^bQC=5U8S-TNT0]>a+1M<63d:08bXV1;8bU>Q36DE^73UaZAB
]>Ta::HdJ^88N[BJ(?WAc6Q<XXLY5I0PW\TZ+5FKZOf\6Y-EOg>6I7Ug3Dc709=>
WSN7KOP_A>UK#Q5ffV.Z:7bX91U)I92:TdYE0DQ).4gd\VYd,@^0C:.(5)29+)?0
LR(?XM;HSHQ/6#\_f>@QYVRU?F7Q6^:>\C,YE:-b7>(aQPO&M-I1R9+YKBPa7/Ob
04Y1\A]K8X6-@WDO3)L?c:IF;4a_R.<K->KUC7BeH4/0EHdG5aQHeK03219/)Le-
Z0\LCc>deYKM62RY#0@]ONM9/W&#fC\70dbZ=U,=_JM6)]ZaG&)&bZ?7#VDVLAKa
?g\\\&+bU9gB5OC+BMJ^d7;:O@>GH)E+L)JNE#6KJKUTOUO:Qdg+[4JTC^XaLXJ[
__FQF8IN)(H@KBcJXP9gL/\@Z[)be?;LIE3Lf#7IE_GV#MUF(e^1N0&)PRE0P([S
FVR0/f]&PbCP3Z3I:J2YA=R(A+Wg.4:MFe=F59+\UUbV7+,HC_XLGH[_4[40Wa]X
BYE.\TR#c2gfM]IKX5[<U6=SG]a4e94,f+96FBB6GZ)9+?Q.;_g<eGF]-,RJH,0R
=>.c<;C/IL1\\C3,NC&Z?-R3:M7bUa:PWD1SK>5TYJYQ,MK@g7Z.ES;#/0P.ge?0
cQD.\aEL^FQM#A)ddF9(UYY&HFXT_)\U_S0RPR4>79<0aU^A--JQ&Idd/MQ]eL@c
-dNI)e,96+OX;-:aHC.DDZg[f_:_6Q#;O8-/@AR@QbQc09ZJSU9#VeP9U)RcY8H;
-H.O)R4FD[O.B==[BZT)_I>>O;PXgS1KDT.L].g@Vee3?Y?S.e.=)Ge>fY67DCQd
fJT3T[CLS1O&UZDNH#a0We1Q,A>]C43Hb^Z/DB1COKQETS9C+c@)I</GP-QUcHA:
SIbJ&:E3>FR1SI(fJO9fOYeHMJcP3M@FF_=TfBPWT=25>WBaeU?;M[3<SeH;ES6#
a>HDDM3MT?8&#Wc.>#A.)1g\eZPFYRG@JNa,GIURI?[FXHS[U7(QTB\=T#-GD]07
8-<&K58OTce/+LV#HPJ[]2@F8?dY\B@dcNX\.\GF2?^M9DOII/-TW\=F_Q5Uf^EU
E9D@>Q_>PY&.LD>O([bS&V/RX;,FfPeTfF^I\\SW#10NV4U9-,(L@359+(c@@/QL
6V5>2[YW@(H.)$
`endprotected


`endif // GUARD_SVT_AXI_IC_MASTER_AGENT_SV
