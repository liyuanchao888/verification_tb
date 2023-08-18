
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV

typedef class svt_ahb_slave_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`endif

// =============================================================================
/** 
 * This class implements AHB Slave monitor component.
 */
class svt_ahb_slave_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave_monitor, svt_ahb_slave_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes response requests available to
   * the slave response sequencer
   */
  `SVT_XVM(blocking_peek_imp)#(svt_ahb_slave_transaction, svt_ahb_slave_monitor) response_request_imp;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
    `protected
K6F<a@./Qd/O5,@09J^\QA@#]c=7)&1W?C#?B@/8g>Z@>H_@Qg2^0(ALG2c@)e=Y
(48&aL?-,JAVY</SB86]/\PFbR7O@?9a+1X=Nd_a+>#@/Y04EaEfRN&5MAQ5\FPO
&FLJ,[Z@4gcQ^;gM0f5dSJ9Db5JZ,(I1H38g09=d;eO[,HE?N/LaW_-g^9+:YMK2
OOVG(;I\eXVD+L^[0XB/D\:Cd1PEece+:I:J.f,+e73;K+(g8ZZ,P.FK\7WVcV20
Y;+b#),+81>J5-F93^+5(N19/G:[S4/3;O:])g;g8^88[9DT7J.cX.2<\^OHAE/Q
GFH0aG=8Q;<.(H#:)F0+<-EX8^6CeQ_?d^fTWb/@&Og<d&5DYYZ8KTSJHBB+GM77
>8HV]^V,17+TbRe^0=C62;+a+d;3N_fAH<M/(30Rd+R-O,ASJBO__aJeHa)V)#(.
?cDW]1fK(0^XD4==:#NFN_KU?M):.4=.@$
`endprotected

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  /** @cond PRIVATE */
  /**
   * Local variable holds the pointer to the slave implementation common to monitor
   * and driver.
   */
  protected svt_ahb_slave_common  common;

  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_ahb_slave_monitor", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`else
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase (uvm_phase phase);
`else
  extern virtual task run();
`endif

   /**
    * Extract phase
    * Stops performance monitoring
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`else
  extern virtual function void extract();
`endif
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

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

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_common common);

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called to sample hready_in.
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  //---------------------------------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when hready_in need to be sampled . 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
   extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_ahb_slave_transaction output object containing request information
   */
  extern task peek(output svt_ahb_slave_transaction xact);
/** @endcond */

//vcs_lic_vip_protect
  `protected
.f^b<4[dOXb-=0+4a?@5G_6bDVR9.bSQ#D\LV\X_PLg,1V8AQ1W/4(H,b._DS;UR
9-D.&HBRDg^MJ50D)B+(\_<N9PT]C/Z:9gV:GCW[#./9E[4<[;1-B,._UK@L9C)^
QgeRPW>UNX_M1a9-=K9N0^W7XdfRK&AV-V[4<-_KBb7c^cO>CdYZ@\=U7L4_0YCS
cGXPeF-:Ec2D>1D7?_^SDR1H)B\Vc8,R5S2/3L)S)QcBI-WHg(HEI\8\31Nf-AdH
1UH^;PL^K9A@3(>O0@3&7\O#Nd0L,A8_&?]g@?[>=7(BD$
`endprotected


endclass

`protected
dESQbV4+9<8\_QMLHI22FP[X)gQ12)LP7-RG6Hd5&3VC-]DE\)_\6)>;D]_E^fG7
HecXD-ab=.1@AT,>]SV^J7>c[7dJ&Z>1J-^@DR_.:)HD,Z5^Z?L=&44L,.cAVZW?
.CK-F^#0\A?@KWLC5\W@U#QZN5NW&PR/&OZ/T_0PF<XXMK>:PN6U)DdRY]Q>=;]J
+626ICFHD++;e)A(TBCIYgKLT@,D\.Q,B:2MVH.g11I(bKc(CG6GeHD+^XY:&aJO
=>0/d3\L1GD)b#/]J7b]_Uf>ZCe,YV.W+C1b@TS4=\eDSf@[X,TS;c6BS3Pg;[A0
g;EP#c#cI?3.P3JSF^KR.Tb9fPLU:Fa\(T\g17;9Jc2;#/I819fNB>2.:TQLM>@9
e-SZf;UcgE)>E<dE3R7@eWO_:cGB01.,e<G?3bZ@F+J;B$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
S7a:95R;)Gc-Gg)(W4421\RY/Y0EdFA[^X7R,651JDAF2R[GB[0J&(7MKZBX^c5B
S8#AcIgF(5LS?,,?&B[/?<g=/9;8B#&?b7HM?O+#8?\NW@G9=H9P2\CG#NK#QTG8
O6g\.;9f>J)8PVZJQ>JN;9<A^JA6g>K7KgI01[&bI2QW^8.8b8IA\7.>T[O]BR/J
6d3B(8)D4C@(^3MQ5<GN>G]HT^a3+D]BOXI<L9;7#6V]TecAA2c@)ZG\>C<3ONGc
+(SIXQg-KW82:>\[GCOSMWd):0>H,V=&(fQXI\COFKO^f>WX5b@A.USDF?bBO.Sb
Bc?e0Z98(X]0M=TIX01WS;?E3EH,9BXg_@^E]VV9)(SC4c7./HUSA?IVQ?6J+K&f
e(SJ.RKG=,LY&FX?)]&JDc\0E;FbBObR,)[6_)Pf<M@g5YdF3T4QgZ,]+_[8MIbH
2YJfF<V9dGb+<YUd(&9QbK5;871RFc_BAb9S1D#RU.5K\(RC7;^DHK/P9UIBH4D0
F44FK#12F3W5I/B9U@FF8.SQC2G;)^#eJ3M(0a<;1EFWRWfGS@QgCDEV(,N=0d(@
KNbIVXBdKDIY2VIOg\-Q@MAQb;EX_>VUCLS>+GVg.,,81^bX<aN=Z#\>2FT[KKbU
ZED@B&QG6^D-2+CTE3+b##&M8-[P#:-[eIN&H3SOX>VHZS3D(<F.(-1^&#45^Bf+
?7K9&7M0-,3ZHH#>eN5VFg,ZE1EH@:^=?2+W\IG&RZDaWC7YRM4N4NUbaX[C^W<0
?1bY0RbgIS2\:G9Q:cZ.=YROJY=;927Ra[da,PO(L^UUaU()4+CK2H3b7Y?ENI]<
3Z=CI.;^WXN8KQ>./I5G<2.<\B>9ZP.#a/AD+6S=:T)MeS?)H)MI(/=3<f&0aM\:
;^Kc,ETWQYIV>015GWTcYc:/,4?^,>ZH(a37[@I4Y&3:a9<e>LH//:M[gCPd;d8a
/(;N\E<C-=9-B(3^=49J=#KTL5Q=VF:2=2CB+NaSN(6]52]aQ&6GO6RLEVK+E8cg
g;.12AW(PQ\8cS+6,/eO5KWY0dFWb+RDEg^FQ5+_PR;1[ed<Q.^)3c<KS[J[(N>A
Z8>,UKb]KZ89EQ7GR2M#)YF?X^[FV,D)YH/.WZS?)IM,PKKGH:cKOTBQZ(;<1X#&
^U(:<WRSBJP@JZCWA8-MRE]MWaF&1O]0&YMdY1Pe^QR,^K9J<aRa+afebH[0)AN0
EBQ+cFJ-<#P:B07FT3+GFA/Nc?.F,Q)SeH<Kbf0G]UbcJaM:W<_2]b7Q3-JU6a#E
4)_,/-9]3Sg62;ADMNSN&@[=6JVH/IQVJ_ZM;)QFX#2.W@\04N#Hf_Q<C]O&Q:(\
#W1dY-R(f+<#=V/H/G5WMZ\b3/CF@)Nfe5O11F_V-#RIbSQ;60/K8U5(Zaf(^1KB
4bcfJ[f5B?0aSV4DXJ@UYS2NMX1-N__;)S=-[bU0[3&Y3_0fO@0F9>b:&D?JO=:\
dY&U2ADM/]<6@3[L1]]\2^0IdbfbXQI3EGESb^TgA[4CT09?FZAdcR[:T-T^(3&/
1-0SB(3]d:)&\7SUT,ggcJ,O9X,>7bM]E7YT\aWgO6<V#FE7KE3#8>5N1-YA1J6c
_ZY@[CcP3ZHIA(<-X[bU^C@FBgMULO0PHL&NR7TE6:Q?/:5.\=bY^K9MD?1F36-G
XOKNMU+-.]6Y318ZY>B_:9OH8aK)b(6GB:^YO0[SE6A7]__A),@LO2H>bM5KU:KK
1I;d-M9O8T49AV6JR>6;.Q<_HX31;\AY)5\M7Mfa>;HVEcWL&F0&Q=:/9#U^@H=&
^8_C49[)&AgRe)UDcV[A_+V>.eLP\G-Ze_,.;I_ZUK/FFZ)O-b.BfR-\3L]3@T_B
+JHXOR^W>F0[\GZ<+>:\#>d2B.I,Je?WHZ=SZBXM@^X3(?.SL8[QPW:<g+,+&2,b
->[S?I1Q68Md^Q0Q4]eXFNDA#F2(WNG+->>I57:/\72F&[=TcbYd9eJ7S38U]>VW
LEUZ&&a7,=+5H+b5Q/Q+=O3KP[;[aL7Z[\\L)^1RUA=-dQ:0=1_QM&H[8N]Kb1g#
EM6_9M5#Aa7K#0AL1BHJ,N(cDJ5MR(#,L6V0IN[T=PND)4?\M^2R#7T65YC^INYS
DW/61#(AYdKI3/Z-(251?59/[F1-<49a;FRUD.Na#CS11(e,+fC0)Ff&OX^JF51.
5U&e1J\?QVJLJ;;0Ug]M:MHcF;_BfJa@\2MMR]Fa&WWgY;_#EZJ1WMRP,^&N3.Y#
+WLB)faT?6P;PHLd,YU+&H9IbW(=INQVGPe28@N##d.:D+FbCJ<]F4f&_6bB4Xg.
=#eNKZOM+AD4d]N?)AJV7cS5D?:E<)Xce,I72LdG@?/U]Y,RGDV.M&:\>6+:5?+d
;+SP0-eQ7f\QXC8Q?HT_OEM.1Bd8Ja25b4WQ[N2^8OQfI;g,RP?8>9dG=MTLR81:
^?\&Dd.6(ORUSQ>E4R.Z4;]R@d4>FZQbP[3_)Y>5-R_cNf_<FM?6U?YbY.@:Gb)4
C7\+C(K0/6SG^VJ@G325#^&e5+TIXa)fIYLLeW:_&+c?Q?LZ0g>7c^3:F4?I@UM;
04NPdda+5@U?_,,HWG6V>S-F<^CBWcP/2&8,D9^J28Eb<2Nc,@5=O4:FEJFIc7\W
M[HHLA[aHO8NE\(MOcJg(Q\?<A24f]>[&c2<]]ge<QbLAT1&:@<W,RGI])C^fc76
5Lc^7YaQ^.gJSf;G8-@)AWP[Bd>He0EC5Xe95W;3.&)G#Cc#.0J85C0e?I^_,7ga
O7d6_b1^Xd_7:JJ0-21?<FaPGbLMXM_@Ybc5U24<O_=d]f>9<.fP4Ae[AB7Ua=T)
#G^#/?4A]I=-<dT2<0@WBX5<f-ePQW>WaHd+M)[=Z<RFP>^6/aQ,I?3<CFOEJT++
E2P?TV?J(6Q:GPNCC>3L;^I6M5dFJ?7+NaC_3O?7UfCbAK&\FBH6P:QJW]5A]^P:
O_8\HLC;;DOR=6L6DUPW7SKScW+#]0//]UP8_?30(2-#V8HQKPBCVYYc/Z--bNKd
=FT#RU-@@e]#6#51e&)TKS3QTT[H,<CA?a(^b_9E&QFaW,;[+6>E;aCUc[1)Id79
VF@4_8AZO&@0QD(,3cJQ_K>?fOB,g;/e_--62Q(MU\B5//;&1#YL(02S0fXeL;2,
_X2D38)f[RfZLe4V>>T9GP)\P,Qg-75Q,f&,8fZaRH\W(BS)EHV>QZ)cDD<I&aJM
QNV:[E-7Z-=\V>HG8LE[(@BMS7[C++D__Af#HcEZD94<L>DR^3]FU<bfMf3fE4#0
?0A_Qgc^K)?\LZW5PbL&[N\EM([4+d(B8DYDfI<CIM8KM55EQLd7g0<O25]NIC7H
.FfdVG-W5g)OHC0_/cH)Ne?-5]28dcQb./KR0CD?JOf)I[K7Yb9CO)PNJ[,0YOdT
9AD,:.RUJ+[8VV3VMCLH&]CCMS^@b+>g/UV_M9M/Z/7=UT[1V=(dKeA3R67Sgc@S
0>P^7(X6\gDO::8ObEX#5\_cYT3d@;]_dXK0-cEG>@9e\XF>4KD7&\=1>LKVDWD0
AGG(Q41d#L&[fg/f9Z2Z=>C4Y\#BYb[ZcF13I3^Ye)]M(3&,JC[\?L<.X-IfOVA>
c;2)^?XGMd<8QRYR_FV7ZbKI,=U=EbEa_=/?R^gf>?[)C81dK]NPN->NN<X\gV0G
NZ.0)e>=E8F?BCeJXG^Gec\X86S?1We3?-HcIFY:BV<?P4+>T&4Vc&JD)aEM/9aH
237Oa@K>J>OL\.Cfc?7ZXBba+)&Cb7J=fM/&PAG\2/]Q,CESLZ8(c+F2XbBFUWb4
5:5++9P0fMCCNg=04)B[TK,<0bDP9?1eeIa;<G+LSP+5LMBb\ZG:J7<A/Ud11cg;
\=Q:JE,:,&?LRM[e[4S(aTM+7U+03W<,,ePHU3@(=9M7N0_,Xe(T#e3K]Q]eFL,]
I9^A>CVg-/U]R+Y(&DbU,ZXeO[WY)GXC98ACUO8=P\0Wda=aPEOXIJS8_O:,0<ge
Z]\?R9gSaPX?WBBf_c[ga@IH+S(4(?2M(DIe3#9cC[#TW(Y(f@-8523^BQ[B&c@\
a@acX\T/3ZAM5K50XN(H2/T?S01D54@E=O5b_gE#T9\#D@eNB#D+V0I]1)^]N-Hf
(I3=:&[U_9>F2R_N?T3DZ#:#5#M<fH@Hg-DeHc5&?R0?;c8d9H_b9(7?LV<HZ]_b
A5:,DM?1)cF_EcEK+S(R-[=RS):d&U]KQ?<S&+T.gJ<4]Q#=\ZS7T>[[TAI8g9N(
&RC05G7YWOG7X/HP#S_GbUac\D&^X=U8;7YaN;:NTNd9E44@AJ+E2)/X9KMCeb5^
K:,QKV6aRWN3;d_EE@A\5J[U_,X?&U_K&25XWfM5a-<8gg/D<\7HB=IOVW\Z\#L]
L4M]Z>I81G33&;@.QME_N^AW4][PNY,8(GTPdO]]QD=@G[8bPHJa@&8f42SeO4b(
W+AfS3T9_^9\I37;B9]_D+OA9EYPPE9SK#2_EHR90S0A.@6+M++2E+OY-<3RT=Xf
=<gH/gX:H1LQW7a4Fg\3e+HC8I:?[Td/+3TNUNG7HV;G=d6Q[>Z0cd^>4-9)fJHa
L[R(;[1fR^]GH?K]ZMa2KD(3N[)65_]=5BNA;]>\6Q@;&7CS(Z1aV(QJK+];DS>>
Z30XUJeH&.HPd0b:#/.?KbQ6YK2>J8dJ(Qg:P6=K);3-/#UF5g6I620\)4bU&V5A
C^?@?2M+N0<T9Kef=/fX.HIe;;a-TYH_)D@ATX?,dK)DCKBWUZf8L;5f-FYR)C+-
D&=^\EVeAM.BZ;^V5/+Gb1;Q6KP<&6^#EcIfd_eR#ZDL=PX>LGS&YC3>2bZX<<-E
Q<fa)?)WFH);YFDd5]G1J/EUTCb=66N/Ge3(bC+RLf^+(e/aZX8AQ3fR0WY#KS2f
KTWRJNO2@F7N@0MU8^X8>8Ra<3H09caLN\cd_N&RUfP#^#M&UAec/=4;Q;S:CcIZ
A=+V,C4RJ5D]SG>gfLZ:8LI]W(0O@87Dc;W.6Y#FA#XR8T>5UO[.1+4;Y?]D>IKf
]Z?4X2R[WAcEEEa]1;3)=\8G@d;aD.CS.a^)5Aag)?9D6#BX:TSa,V3&+GRXAH[+
.0#-C&dgD#S8=DdM?B9:DS(DB&B]7e2UgC7Y\#[&9Q;W<,NR&Ne?9V4S6TZ<-3gG
8BK30M+?W@ECV\VKAYTHA^3.:7&+g57+I)_NCKfA/7eY3NWC7E]R]&gK:)K@P6,@
9;4E#C[(Mg^.TE1T](2,N/F]P.a?9>EBDd<,JfR7Z(T/-5<O^-\]bO/.;Ea_FRD5
\U/[#N/Y[6d75D0,^(+O^EJDYE[IRfP?CYMKS>a&Zca58R5T-;=QYL8NE>9+eC;1
E838VSJOL,M<A2J)J+?.,=JgZX^V5cJ-UKL+Pg5S\A(J83fL&P@3G-b:b4U<IZ3N
UJ^BA5[:;7QSNC2TNTeS^ED96O.O:MQ)Y5bT.#5-.aVS^0eZAQ1RP0>K^E[b<aVf
V<1YLg_G9eP^\;<^D[.KH&?<0QOZ+18_f6R&b_TN0;IbAQSHPG5@JH;ScZSRa,dd
8K2O+7)E-3K7L+I5O3PJQ-B>@cS6=?=;40-1FIW\cKHV#X.?,=SE6Kg\.aYF[e;@
?O(4^,HWaa-RaL_80X)ER-BX^F0D]dAD9_X+USD]A&<8S2C8>-YZSI^Bd4DM1O]/
S2;dL]B^BV3KIG7?c1(F+V3BeQGMA1R/U0Z.YfKI&c,H]3EUb4;f@HPagJ+C@F:O
WA)OUB+<Ba)^-Z.;6K;55fW+^]8UOJ\cIc1JJ+X^K</IVD<2P0ZPG_:9:DB9fQ0g
7?NH;G8C5#9>(CMYGf@A(#>Y\5KaX8+OT1C,f7>gI1MW4_>E>NTR;6E^=03_e8dD
HMZZ[>d#^?6J,&\KKHJW7TU+da(]S0;MU8@\4P2[P6a5G[&@VQV:2^<f,.MD:+aH
OX#;>b3B8B9^:GJ.OK:@Ff\L(ZQN@E#R6gR3]?WeV,3SM67A]W=ecE8+T2[KIM2W
N0cW7(N+@/@[b^&H[@)6)XIdWZI_d2FD8\df33TM966PcI#DGDcTG_=&/dcL5ZS5
.C.JcIVD3Y-bU?c1?Q&#Y#\-RH+MZR8=<-bf?1=\-TD=@E8M:MAM;GN)WZRD5#\)
M65G:@aME1HF^Zf&4>2ZU34?;EP#XHW63EU8bNaS6.W=SFGK=VB[(CT/TO#>A.W[
e/J6;B0:)2.Da);@F;7eS+,gI@)\fU7gQ0_Y85LLW^9d-OP19Od)(](RBWV.2L0C
>WfM[;WO-=AQ+((-.Pg^Icgg&bfYMC/cJ6MbIb^=AH\O700G5;L&\7dDTBN_>+)=
=E,L9VOD+JKJQ52Q]4:L6I5:0,EJ2JLH9c[^&Se<B2[a&WfXeVT\A\WQ,O-#N\ZE
X[8K0;HNM3]OgBL14a43R4a#7TI^3=,;JCG??C:OD.@H^@:(g?TD3EJ(.B2BR=GE
WJHYJZ)O(M]N(CNY@Y)K55Z:a[MTHQJIc&=]V&_2@P+LM]K:)MMK68,4X#YAP+7<
9MUQ#OE,1[M7\;)e[8fa\T#fQGSW&Lb>IJ?LDbc@9YYHdABQ^4-JA=BQ>LdQ[)68
,ISIX2XUUNK0/g8/;]H]e#<LEX)U9ZPQK#3WObWQa)2UP[7\X+IA69fVb6ab6HIL
MC:A/YGYE__5GZ>8/R+3]LKAe<Lf7a]a7DZ)/:&LUUf?4RF:?#>V@;0D0dWQda:K
W^;fHR@9P0O[(K:9[J]99XM:c/C.8@eV&ED.9c+Fc&P_R?/9?\eDES>A]OP7F.:N
VfN.[.4=f]Fd6L#6f72XRLVM+f7J0[+T)6@,5aFV7OJ+U,DaS(FHUW5d++]\.g7Z
^fHWd3a(Y&#cK]S?>0;SMM;)/[cONRV#EaI<gA=F>=5(OK6)RC-K\aad6LRF]/cC
YZ_25KI2.,Yf)M17(GL\-b:\>2(agcF>f-M>;HY+<:02-K8UQ4TPM&C2Ud\1QHL=
928-3F95aFM0f(Cb.B=S6/-cD)B+O?]a<2@^+XU,)KB#MS:7dM4+-HQYE=J4H^T\
)#@eVX\0J.dN]\OS#ecX&JP5QSR^(,HeGgHA4<VD?/[K+/0JJ]2A?a]H<YSAQLE0
H&H&d4/H<AK1_A2ZIJ8<d\2J44+FQeB.)CKf.34ZeSUF32:>5b\f-c4f:@VM-OC2
,SIP,#(<C_:b6g<HFL.=F8cR^@9I#=Z7C,G7cV,L69UE^WAVSeEI=HI]_aOHa:Af
Z[I4-gJWe;/4FH65EFV0YM^D<FVCLS5&]14/:GZ)Nb8bLWZA1;3P?BUADMIHLK7=
1c.6SXJ@J.8QV5NSS_1A\E;fc(GDQ,>fZIfN0fe>#@SC_GLZC;c59I6fB95D9#TK
.1_RO>W>YF2(/G=;g]GP8Z=RaS8b=dOeaOfC;WdV7-SF1ZJEK0ETd3?,f-.L1f.#
bgPA8]:aXP<I7+ZS.K0(d9<?&8-\SASe)_^UP=3C2DfF,,;0.G-O5f?KQWN/A#8Y
FDcQ>aB)TUC6,Vd]N]@@8BV)#VMG]H3Ug[/X4REQ?+&f&>.NUa6g)>F3&L\4_+aQ
WU#DUY9T\2Sd^LW#5&GZKYR85_HD-gMD5M9Gg?DEOM9:F2#?K8YS3>L4;;KHJA8d
IH9-Mc2WP?BAW)Za/+X(9da9d4@BONXE>G-0CNYJX[.@adF>MKD\b+M[aE\+c>NS
I,^9<5c,]IBFaSg9I5:[)W(/PCBCaH,EG45Eb+?:,M\VdJ</,R&ASR7E#0RZKHKP
Wf&J+/S-XP0HHEM./JK1UJ0+[e^+UZfE+@J-,6KL_@G5]PAHbG,IeT./<IP=a+cT
LcZ]f&XORPa,>6WTM[JFR6WETBTI_EUC[d(0bc:XD=8V2Z53^I43K_LeKZ@DG]?G
VWN1:8GFH2&.D[#V>UO=I6U@@6T;9EHY,L-Hc(27_Q5./?WMK3Z/6X=]#J^,ADaF
Z)OSUbV6UZcN0aSgA&C,@VVN4#bBb<L@#dE+X<H_ZLZ0+DcLX,:&[N,2O;[,Aa1J
MFNRRG0E0A4L03-IU6dcCC,H-<d1F3/G(J&_ZQKUCFCa3.&06aHYII#=DfX@+da?
;;KAO5L;;=ZV-(&Xe0)=FMTUQ6fLDKD_:::6H]X5<Z;2X:72]a4,,X@Le17.R5;G
MYE72AaGdTRSJb#C98#C[VE/+4fX4/24fC>W(4YLB#F^?<Z[G=(cgQBL1C,&&(97
-8H#H?]Ka/&^C)S_0e86>I7,,T9@F4AM#_.VK5?PbIU.P:]@S_ZN&@#T4&ODNcY5
S=;PTM)TM-W&67&Q7a=325d+QPKM]^5<\0<+U?&]f>RJLaA-.eeRHN7\(U3F46@U
7U&X?8=04HP&HW0JSM;\P\7d7D6?<#S1#-U?cf@2XdgAE1:[1T+;JTceBJU61(]/
V8J\O<S1/HP><c]B8C+:QL&(eVGD(JUbe<?<NI_3]1]C>AFAU/ffb(<d,>+B8@40
CCVVM247E9<gGB>YLDB8?AP+P?/.OF.)I-RA</PAMR-4L^BeeEf,0&SbL<f;74Q;
@FaL0T,=(8V;49?S17;f^5+M)4bUYE9I/\@3K3FNA5#U@J@7&J1Vb=C;Y]^5PKFd
5=]AA9a=2-=9V/E;W4O8ZZPR=XdJ@XA[MbU[>9P_NGDL(Faf&]9_N&EG98/>gg-f
N8/L3,-)I6N[\\,[HC-3:^MfaVeI0b=cN2@gQ?7?#d_:X/FLH2^_2]QG-fbc5#5\
5>];>LHGH_E:a4/Db4OXI_WTCX6SgLC<,e>7Y]=/Xd_Bb/6\<;M]RTPNaCIY_WN-
2>3:1LG2VX3-OKdHC;EXIc(J)EV;APGRW+D;fS-_@)=MB,Q(]4PRW88#<[F;@a:R
8Ec/9HVM.9d+BMZ.bd[6?SM27TKY&9TaCL41-<YD:<K/a\@aTHJT14deQ.b@d9A9
9?=OO]E)d4Y^FG-]W[ObCH<E>dPNB]MM0#/]=&#(]_N&D4a0_]HRD4\SDMX88#0O
f^\:--36Q:OL(-BEbPfB(@b14dgHX:Z4.8a9KS6<@FeWYBcHNRKGJKc[JAZ]X;1L
cOGHN9ZWE]FDE:eZ3ZX(OM;A4VU>Uc/J^-PAM\d]@#F.)>8.)K]TL1?NWA-4X3=G
XKf?a@]g9D[EVS]-BZGKYVQ-PA[U6f:W,ZfLP@#d119;g,UZ(<3+3S6ef_(bd4>a
2b3:2QL=5gLdLf<T[PZRZa?ZJ3O^^:J@_.HZ7?W,ZOSMA5?5M]Y,XML2JBTQ8;;2
Qec^G@gUf]E/4<OA8H:fHGbR#D(C#+WXcS3W1^KWP<B8]X<8OV=YMXc/&3/UOUWK
;XV<JU=(5E3UYLA7#D:=WS\)=_FM[;+(QXgFG/&29=?1605]O[B/T,LYbaLSRV,:
gce5W85/B?W_6e6Y:,f-RGTSa32&1Ce[<Rac7=_:GNPZQS^AB2Y(30WVA\A+P)R=
:@<-P#<74-S#TCbXHQ0][E#,F@?79H9e2Y[0,]D9Rg3#5A9b:PQd68L6A@(/4_D2
KL^?LI&@(AS4&f=^MaWN/D8PCHSNZK)BJOEg?eF454@TEcCVD=[&3@>JT70ce;Ua
RTEO)-.]&&H(e8X?MYPa=;/Ua,7).MRFEc=^8-[WC=SL.H8J,(g;P]:d46+H+V-d
MXD43O32B3;&>]>9(G>PGCAI,I-]:?>5D?+;L?aa9DSL+KaV.R/+XPZ;fO_.U([R
eL[4QfL\L>+1)5\AIS:JB.LM^c?MC9G@?)XR<M[S>5QQ?[)+H\@VC)#Q.=W],d#<
Qg?1((7ZLcdM2\C(ZH-3.1H41H5]b6FQUMTY:-,?Y5bb+ZN3^._G^:F.#_A8(dU:
bA[RZ#FBKM<YY<(d(af5e[U/XF6]]2)>\&A7I,>36dT-Z,U>f>3,e/KNRO@>>P1D
1;L[ARF?IJF+6cI2^.T\Z2g-Q^BX9PKNI_<gHe^BCI<>+OZ.g/^\ga0eH(,(>CQU
GX77@X15]@fJ1/\A,fPM3Z)W#00C;9,08/Z=Z;W-&2SK^I,dd>HX>7AG(OV(bMc=
07CO60.d:b\),@OI3Qc_cgXB-/IZQ3<H<0F)C>:1&-,RMd(8EbZDeL^-PfR2=I.G
)4S+AQU^?J<TI.>U/9^-_T6Sd(F>^49SV\;GEB&fSddZKRH8)/G&]1O5K@Df#Bd3
KE?<AP^1L5:@94WJ1QQfLJ.c:QXfA9RAe5;_HPHEWP30^8_E2^@?eH4AFb^<Z3Tc
EUEXVdKgef3OHOf2g7&H3(^JWb3EBXI\WOT2G9Q]H7_1\NZ:cBH=M2PKND-S74S5
B]ZGB,7gPWYMIXf-IP6HF=\0N\&OEWa(R-gEUP,)L@R@>-B8HUC\Lca@8CR<P0B^
UD[>B8d,gM0gP-e)e56+I=ORaD[>><WW[f<YF)2NIg/C>&(W<,).>\.S3Qe<L_6]
b;^<?<3_B.4:APEUGX9@Ca]]&#[J;)2@_(S93^[?__X&EH7#Vc;V).+U2RW:F?\H
gdga.YbEJ+:3/PW3Sad<PA9(>ZIS_PbT4Z871-:,TV5X13T5MAdT--aRW^;]A5U@
W<gcJ8;a&1KfAP9AN1.1P0=;<P-:YJId^aJ811]\B=)PV--+c[+a32GVF.,_T0XN
/\0Yc&0OPH+W)dGC]2K(TQJ(8H:9X,2[ABCc15Pb4ON\,14/C/9NC&Ab[W&/JQ@9
HMQ6:MG)GL4JB6fI6b_g=#Z@7P[#A]-;/CA,.@R@bO04=BCUA9Z[0eeQLL&+.gFc
,@CG1+M).R-Y,KF_EEb6I:<bP)R5.2U]CTJ4:#(^D+AW[^f@(<,WDJ8JZURfEP.g
7>N.4abcN:+1XSKYME;FgIB2e\UJ9@-LWOTW4Uf&WU\BJ#?,6gESc2<>Q1_H:R&?
X4:^NLdC2)X\_E5&+R@;L-9g1<[9Z:636PU3:dNY[IN;,^P(HD[C/2OMVRD(eHD+
^X4=#]PfA/8bTBXPY153f):aRS.HSgRe9VJCc(UX/IDd8B?@:4W6KSFTB[7JQKdW
g.fI/&T25a@g&I[#._T)GOaI@\4V7+:(Ic:_d7MY(37[02e)J>?\N.@I4f3BI<,9
Z^;S\gL8R_d;?,LVWE,(LTSPgOC4gaIC00V(gG:dB2LY><#N#cZ@D3d/V;D/N^C>
;(c+a6)^OY:&aPQLA5)_#]076MNXI@<fJ]&Ud2E-GGa4gPH0-gG]>51ACV2<8M#c
\.3//1+&C_g=(-I?.c,HV;7?07M<>f?JRQ3E[^>@GFW0Acb=fd5C\LFX<(GO?1IS
6^WW>J.&cN]BTSZ16S/(PV:=Q/N2TAPRU1NXLT)T&Ac16S.^RPC1:S(Vc/Od(XOV
7GH?^Y[4FV:UAd:Q5&.:cRfP5_9YCG2L.fZN6JS[gG9N>Ye-.[AA:EFP#I9g)+c&
A9@>f;:Jd>Ue]fF#CRU=CRd0I<8Q8K^)=JAHC6.90d^RGG71V7>P1ZFR+Z9LJY7.
GYXacN)O)?,fNRTQM\>@JdQ:+EaZ);/J3=JKcL@RAT=^\8R6Md<6;J-Nc;ffL/g(
FXW\cU7UfT4WKXeef.&UU5U1@TKf9#5971fZ)G&1;C@Q#XD=\OB2&/LE?FMK.aP2
3R7eeG/<gZHN^J,]N:JD.U1HP,ZfC/(0e:8[TQ0?B1=c(:ea5F,&a1+N+-eb.Mg8
(b7GgSXUaIaDH-<8<2P1A^U4D@+UG;U,f>8+1GRg]-J=I_.bI>DNQZ7#8-Lb)c8P
@Y6GA\0BBH?.MJXg?J4[e53QGJ/C+6+V[]K36PQTb]H4fb?E:N@1E+gKSQ3BPP2=
G3?\DAGFFJ.P6YR3)>@(>AFgNR12]QgKOFdNOWMd)NPK3);6=PQ.a+&fI4QOcZ8N
-8,;(WaKLFe1G^=]c?MKa4c6WOfP@_gFE7a\M];e(V62Bf.JW#Q:J?\-g2AL,<>]
eH+8BH\P5<A26<W_8_d<5e^(^AUAZRI2QccQH3/</W,7IB?\a(S^<G/9\0][QdbQ
a[0McfceJ4NW:B&fLY8/7+RWVZ/0YZ=Nb1Nc)bB6O78Qd19d68??_;S><)+0OT1f
^/2C<5W.14R3);KcSgMf-NY&DfJ&_7H@Q&3+A/71KUb:[UV)&NB(dgCLfG]\R>56
fIDgBT/Ob4KSRMCY(<H,d&f2ROR2WgWA0U/(+fD:@6FfQ;1/P=H0@TZb-.R<L]C<
,_d2/:JcQ>0B6M(HNMcUYDQgP<\^XGf>6b]&Ca@a6NbCG?&gNGfLeC6RR[V^L+WN
8&TJK=]HZIPE@JeK,5,2.1D:=d@U1NK_K@UUNT,-0@9g2\-Y#-Wa;U./FaGBY;]V
d=f]QA-P8bG+JRD]BAbg-b^L=c9;GO59=K;+G&.0)J]ERQgM=MU>_@ad-F2ZZ(c3
X9@Q5CJ(FSD_MU4[dagQY1[W/K)F[?D2]a)(WCMIJdafGe8BfeCb1^gN5O9GV_f&
W14_BM<)4R@g3B2E/>/T63e</]c12C^UGX57FIK92;c-K=1=/_^L6b_[5Pd[Y#.#
b@-cV#Wd_3f?[F<c1_4D+3,_e)0@;cJFS1f3];L\YZ&c(2_5NF/DbES;bF<MKKMZ
;7=21c/=J?1G/C_)G6;UIR8^;8,8P:J>=7;P4&WW6(.><K71XbC[K^UQ)g=H-?68
N=/BgeY#8I;HOc0IC+OVF:cff=g/APQg]S8((:L5/M^U47V+9f1R,G6cJNGF5=YM
ADg].KL/=.R<0=WW0W;T.?CI)@?a:YR0V@2V=ALf\K<W7:KU\^:<We2f,;V.#,8Z
>S4,O50.S3LA0A:IOSe=>UX2<;=/f&A0<D0M356_UcBcCNXEO2-bP]e;G#RfBRNP
2.PZM,D>1@2DcYV.EOM]?B:X:+c50aXfNPN>H=1bMY_5EM@0JCE5G^JJcE/5b7#1
eJSAKAgK^5e_C\G4eP05[7OL++_E.7P;(17N0./T]9d++0A[SN\gd.gUA@;0(K0I
64#)6VO776F+C/.YK.Dc\BT;9U)bU-JF5+.=C1J^,2Q0]0Y^#F^+c&-QK]DAMU8<
c>R?g([8@&JgHfeb_>5b3B_17C8)G\[._D/LQ7ZJ]TFfZ;<,C8e,g]1^TF;e(92S
N-T;E^N2BZ&=QTC#SLK&G<dT,U3LJ[+eX76O4];X9eLY)<YS];O[AHUfK2.PFQKL
dG-N/:^PcgR@P.ZR6L2[Q.SXC]&<)E\5cT[/Kd<E/F,/gMV?UL+0fc.TCP]9ZA#Q
Zc_RXZYM\cY>^fB+DB_CKOR5_./+PJ/aA67)STg^QM==:>GgKX[UZa/Ec1F@B##]
,..(M.6dKcEHVK?D+)a-/-7CB-A6-]W-c[D+I.VZ&>Ja^_SbWR:a1ebg<7EFS)U,
Z&cW<L^:_b,N_9V&5ERa9b#MG#I8>N[._D3.?>g39QeaBXBTDSgPE;\6TAXfOI5c
NTP697-#U2RIc35+WE]LI@?7TDP,P&WIb(fKHZ@@X5b#;g]/.L;eTH;W<+[Q3H.X
4eYBS4&O3CAK<H7]?bSN9d)(#2bDdRM53Cf3YE6(=U^NFZ3F(OM5F<5b,H.a8b=9
7=5MS->@e:ZaV-WX5&LQGNfH.+?OX;_+U/:+O9.PcG:bAQEOfJ@0H761?UBf9f_:
CL?#HUgF([&=]=gQHZFfQRPCV>,:7#e]bC88Q,<QGK^.M]^U#\2CeP3^fbIXFS^:
).ZBNa-Z\[,1M]Z12@B6AdAD9;fM)(E?Q+RWW,PPUF\BLS]ADZ#^HPVS#+b8[V=S
B+S(W9/KL@X04\IUOFSfb;3P;\:+[N;M<A:MCGCga?,Bf;]K^PR.ZF_KeXQ:@OGO
<M/P8NI:LVdd67<F]Jc+Q9&\g@>FNE8/(g\>)=)0V;K=W8FOQ-29\<-S+[#eT.fX
-eT&L51AK1G(V[VTE,L[B5VOAeTC;:d5bX:5>a#?/a4=9,,a,g;X#-dWA\\/&WFF
ZfKXMCG0\G?,EB3I3#_,4#T]3d,24B0T+LNT2^28I;ZTD_?:0OE)KLCY\T5+c(I:
HcZ,#M6[T+DH-./7[EIX&(J]U##H^[WLb8VURgG+:KFADbaf+bgZ:fgY:QMMdK10
E/CbLG(@P:9c.Y):]OcE_OfQFCTU\J^Y_[5L^\V\RXFL&/1^9aJ\5]1[LU,dMZgA
;/Z@>#:&-RC#L2R)Y0^FXQ3#U.X5/-<0&fPf/SBO4eW&FV7N<_X>&;,_0f>^0g9X
Og8PE8b/)XU-[Cb;?.6)868TaQ]W<<Oa#WeL-O+gJXO90&L<YP>eBdf=N)X]N9WS
cQ>[OTKM#BR0=Db_W/Rde\U4JDMVaWT]43]K.0a/I4_Kgf6H?OW-<Rd@b^_>B\LT
fV<Wg&OH-9Y]4A:;3#=d\T.Q=_BWS0b]-<OfaSeL(6;O2,5;C@QJ).,9ZdRM@U1P
PgJL?:6VF._.MfK55VbJ?ID-P^VKUH1OI/<FKJHUT<3,ZZDR@Q,fPW1HV5LDY8_]
EHV^-RYG&:_WM4P<5O=)ETYc&3+>;>\J<DUVf.NL7F_30cK\:5[,9fYT=(;G#SQ5
Na0Ifb6AbY\2VORWKSR1:C\g:0YdX/FPS,&\Vd>X>\IUL[9Sa\&Q]D)6I#;0SK]e
(]S3>N3#<]Y<\PJGG5;K>JfV57BGB5g3bWPWV0<N.HB((bXFJ,QJcHJCT;9U/R2b
dDYfcZN.FX4H4?G)=BKA]ZH[-HRM/c4O0_3^bbK\HBQTHNP-f,FV;)K]:cSI/e(U
a+4[[2]YXQZE80R=DWBF]Y0GV@DS/IaTJN@N]VfG?T(K=4Q5QY/J0f0G85-f2D&g
.6LOf@=8e/P-bZ]<)>PY(C+55<ObS[]PT_23aNE_/C&Q=B>\??#W[Ab;eY=#XN9=
-Y_NY+:#PMV4]38P[,U(IX84[^X[+3[d9[_G(>5FF6&##cREQKVQ.b#5S2Zf+;1e
B&M+;Yd6_#?Z>b=YS]Z;(;g]E(/O7Z<P)<S,g)^(I=Z&S>9KEFRII?O/C));3.<7
eJeO7DK\EfSL1;QI^RJLg37[V4101bCd+ed5AJ8-6XW(]8Y<bO@WaO>,7HCP)?@6
#1ED6/OVKP9Q:7A3O=0#;KB=0\2\aK@0=S-&^B?Q82TO;BA@OU=<g,@9WVSL7OM4
EOS8D0<W5T,Jc]4d@gTc=fR>_P]Y&e.KJ4^.&NTT:e-^?;+>J9bE2X^1#4TO1K_L
+69bMf3N4[.fADBeT6XJBO3eAD1)<4JRcNY2g#?2cc6)7SWV+?@QWQ#&)e(6,-:Z
1X=9V6&8J7RA0=X<+=?4,PRGYA[.AGV9PBJ?ML&Z,D0H?WY>M_9S:&4:AJH1IIQV
[_#-d-ZHNe^&G;ZT>b@((5U[(X13cMS3592=3V@Z>@,.HEbe2KBUX(A@;.>331g#
J.C]=GR@+@+?-MQ]G_>9IFIY+3<F#1cHJQD1-,@T_5HJ7-=V>fB/;:H<6DR1?XFG
\b-EUET&aW37ggIX0\;?@L1J>6[>1^/;7;5NN,[S5SN<:K[,WDS4@;@8WY:N<<??
:bDb#YEB-5JI7[;LC)^^Y:S@(;ZVGIbX2W0-F,1b8QJbCL.^/c(JX=Y>&SX4^W25
\/))Ug2fcG3@AXR<d#Z#]+O0gPAZ:UCAD6fa&3ZRJ^Q<G.RP6/&O5d>.SQ6a>[1a
#,^Y+cXT[/??.E\L;]<9DP4ESJ\P_3AFP7eARG4fWO&J=4,>ZIfP[?P&,dF&4N&P
/-QQRO,H)G=B+Me(7@Yc.Ob9/ODM-@/;,#[1WF=S<L&&MU)H_I0M7]-3UBF+BJDQ
&K#]?&J71)/12W^Z=@P.-N35_4=Te=UT#ZQ)c@S+17S@.WH7.Z4\EML=dS^VKb+8
K8g7bM:FT\5a?Rf_?AUeA>I5,SSXK59I6:/@gP:OR>;BE/+Gb?61\L;6JPKG(9fN
)bdP/@G::8ERK_Be4,++5;^5+UF+.d5X^I[#)_V1)[OE?2e+8MS;UAgGJ6A,A]64
I[AQG]&K=3#I4,Q.K]@1)07]4ZWcY@E4[[LZS.E4++NQ)dL7(PbZI&^H>O+:HWZ4
(/\/B/^g3g0-#O7BD:F6?0=7KbUA;(>XWX>bE7SZVI;BC@/DHA=0PWT^U.J&_]45
QV=_?:531dGW>\IG/ADg7K1^9CXHSW8H2EQ;PPU4&\L3+B3B+(Hb(8e4:Af8()WG
24.0+]X4IIQPSNg^fgMd2Z++?5]S7E;?9+4];Ubf><-C6])764=T]P7DLbV.eJ9X
JV[C/CIBQ4@R,KC/ZSP5RVK@\Z5[:7N;^)OV.0X26c2260)I(+G2-,c4@SSHeHG-
H7d1\H=:,DLRLCIV6DBe#78f3LS_\LZPgX@a?S6HITSNGXIQIcJE6V]90RKdR=KC
cFP?R,&N7AR7b6>H-9EA]BJb)Y9=e?#GI>AW]ebcC/I\MEe[U__/8PI9L)9<fO,Y
.X,S0BE(9dDHK^CW&<b-SG>4KB=U_>[;,)bS-Rc#H:4:TCE,KINHB9V>0NP./S:F
,)6H?@fG0B=6/e^5SGMNfTK95JDAXW-]\IDQE9DcR/+,8\?-7JfW]K2\-Z++bKL^
aZa<TE4VK1HD38ed)dP=F3K98$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


