
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

typedef class svt_ahb_master_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`endif

// =============================================================================
class svt_ahb_master_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_master_monitor, svt_ahb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
    `protected
OYG\Md]6#cC)IX_-C[\A?V^Y9=?;e+HH;VSS7O)QLFdKX>b@ZOK+/(#F\(S:.A@/
(+6[#cWZgd8)?FWDa@TadRK:eac=a?/[41EL-[g+MW@E>W98gQFN@NRKXc\&+aV(
.JJ1&@g4?]VN9.X+S?8V0TZO#GVG8D31d^_Y4eXOeZ1gHNL4\YI_P6\_gS@B?]af
Ib4&fDL8&@4(:_ZU;Q]bBP-D:>#.^+BA[5?d_YX<P?\+QP0>[6>?FSXM;@GYD-#a
Q.@9H3&1.3D@T[AU/SXH>(-:d9BKC5Q+dFd.?fG=>8cF#^b.\c43fbP=/D.YW_3C
;QC9cEK7\76A1aKERG=245S&ZZM=.5g^MaAZ7bDL]H24BTUVVPREgBCIW4Y-RE#N
2,C&6&4Bf)D0,+#6/FOWCKSQ3W+[HQ6\=$
`endprotected

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Analysis port publishing observed transactions as PV-annotated
   * TLM 2.0 generic payload transactions.
   **/
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_observed_port;
`endif
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Monitor Configuration snapshot */
  protected svt_ahb_master_configuration cfg_snapshot = null;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Monitor Configuration */
  local svt_ahb_master_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_master_monitor)
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
  extern function new(string name = "svt_ahb_master_monitor", `SVT_XVM(component) parent = null);

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


   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Called before putting a PV-annotated TLM GP transaction to the analysis port 
   *
   * @param xact A reference to the TLM GP descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_tlm_generic_payload_observed_port_put(uvm_tlm_generic_payload xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a PV-annotated TLM GP transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void tlm_generic_payload_observed_port_cov(uvm_tlm_generic_payload xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low
   * 
   * This method issues the <i>htrans_changed_with_hready_low</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task htrans_changed_with_hready_low_cb_exec(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans is changed with hready is driven low by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void htrans_changed_with_hready_low(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

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
  extern virtual task observed_port_cov_cb_exec(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_tlm_generic_payload_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_tlm_generic_payload_observed_port_put_cb_exec(uvm_tlm_generic_payload xact,
                                                                        ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>tlm_generic_payload_observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task tlm_generic_payload_observed_port_cov_cb_exec(uvm_tlm_generic_payload xact);

`endif

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
  extern virtual task transaction_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task transaction_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task beat_ended_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_master_transaction xact);

  /** Method to set common */
  extern virtual function void set_common(svt_ahb_master_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();


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

/** @endcond */

//vcs_lic_vip_protect
  `protected
D#dBRS^\dPYQ+Q,Q&;I8HJ&#GBcg-&^#aG]JfY6ac#V>AP,PVH/]0(B\1LT=W[5=
B(-><c7+/bP?9<U7,1>I,:VFb5B66<d_&&;ZgKGIX(5]-Be\7/JB8#H&:[=I;/5R
.g+I-XEMJ^J^18[3Te^cR[\d[-bJNMOT&HFX:e45>O1e1>c<&A]LN,7>##P2?e>c
)<-D#?b--MK#D9d\/@X-QGTJG3][LVZWOMH;@I5S.2[68Va?T_<NI,J_6QW(ZVCR
cSBYA\#f^cBF]M#6f[ae4f9c9E7>g2487BKA,K?\BBb6F$
`endprotected


endclass

`protected
QM1>2Q)MU4(d]&a2^cYIYH.?3]@/EN;J6A^5[URAB&;6<aJ9KPGH()HORFB@<(cF
PE=:LfWV&?H##<VG,9,f/XFH>)>7SW/>8d8H,YFKZ&KEeH)J5N&;P]4FX4/Df4@)
^R77-9ICGI/EU3487TQb-f9\NeH[-<WO2Ed>Qa:H41)@^OP@JZg8d&.@,19+QBH5
=gV/gIPX5F(I4_e)MP)-^JLHS^J>7_gfKO<7;c(O<PD)=E_4#BK9OX^a@0R4IE@8
+aGN.D>>g)>F1NVdTRa-\=K3[fLa_5,<0d)g;5BHZ@bOQR+Z5KNX=H9ZR&#BP8U[
A;4RNEMF(eA][4C.:;ZQNOB791?M\BMG82F.TO/X+c&>7^J4]7F.6&f[I_dXL4W.
P+?:HHMN<60ZZbOW)HO^ABHE2dVLWL:8_]\:X-3:I<8N?XKU#,0-=dc8R3SC2PH#
YMUL1Gg8F61<XCNSf<5&(+33Bc]4HWG&e#8KGNP0fZ5:.Z)c:fIH]#c8M$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
G]\]8;JJ35-f@2BP4LDcLKW_F4/;#aCZ3Ia4-a#/:>#9TIbfT+D=5(X:Ja<U8[_D
@9UL<,C,X/gb2.e<IeFf.8)EYPZ8b8[1G8LFF4?P,]XV\,1.)K4S@Q=0C0a&QRaA
D97(g8LTd?Mf5aVKZ26e,NSb@J<RbA?H:QA,f?N)N_EEFPG.#L=H45#dLJ2R<.J4
OPI_[J@^=_N;@#3Tc:_XJ14Yca6A+-];##AWBCFdLDJ@=<PMfN2ZcJ+UW4/GYGB/
3_@\OF78[-==,XUaD3PaS668FgJ62:gL@JA7,5LYNgDgDO6S^>_U:d-V@M<J<U2@
]dYOa(F&+1K5@=;JWT5?4AXS?3BBRTMWPS<\\/bL&<\^ba?FX7<Yc+;U3f5)&?@-
.:<Y2KJLB2g\Cg1#3b:\;+:0d:CGLOUHR,:2=STUEL\(\RME(?QRYK@]P+20VQ.G
gK.>A)X;&R\VZ_dM?9e/O(/SE+<,&C5Kc+ABE0_;]#7][P9;]9G<E@+YeC7\74ga
AZY[T@LZ[4O4ZUbBZ9L1:#4WQ/5CAR3],d/d4R1c1>,-ZQ4)Ae2)8;Td(Z[MC3OS
Y^1)[&e3@,^]bH60+^V]>R0P\<5c+OcgKH,(I5Md8_(M/0VN]8f(g_,cQ=a+86NT
6-T)eW2T81-b3D>\;N3R/F6TQ89,SKf/7VGQAOa91<2Y4NR4?e8_UU2bZ/1;VUf=
X&.A#5\8A7H3RE9&H]2bCN(&^@J_BXgWG2E4GJB?,?<R4EacBIWf#<4)IIPa_&HQ
B^)3.G(PF+Me?;ed.N_TFFc]VXSeGfX@(9M7::?V^G-XITP4E2W#XfI+#\J6@YR7
N4f=AS6PV8[=V+#d<b4J];O:<??f;=<<]XMSf\(-2?D@Hd#C_g/30gXc5Td#MS:1
aZaJJD]S8=JQBBa4C70?M@.:7U</A=a6WZV7d2cEB^N9S6&G[8JMde\f1@42CI8M
^#A)AQ5JDB[;#S?;PF5c\gU-LO6LVO:J&H>X<Z4R(R+.f0^E06MF#-13K(<&:R(9
W7<c(];8&YV:[@:<XW>OM3RVM3.LM@#U.63+.<-9Q60=S@+)BdB[K;X>GdZ&@T>0
-/aNaCfXS],JZ_;b?[OgTOf;C_>Z#UB1L#1U_#eH6K\,PK\;SJT:_.;?KPf@F@4a
][JRXUZH&HeS10.feD\f<c[77I0/ECH)XC73;OF(7Z[6+6];DABL+<>X+CCgI_T5
L0G3TdXGdfJX)TUZda4@:I/1a@-N75AfR#gMc>MOCIaVbM9;>JbY-eIaIa^:(\SY
8X7bGPPdW,3V2\JZV\N.ZFYS5MXge))aH.)?f=eIXQ(,NE#1G;5>IgEG1R]__]PC
ZN_cM2d?W-f(T9O=\2#bcFV3S>^Y/O[b8-^[^,KB38ORXT)A5Y=a+#+I-Y/_DBG5
@D]&\->2<&#K82UbO=d;.eIV4REb&cM0Ba-KRXN.QF&H@fOZ@/dG?)fRER1Q<#:+
.\;]cT3FL6#B:J;>G\YC.D04LO>+-Ia]A2cfKR3(5XX+]#&:gHGB]TM#XJRODg1,
G[D1)<3+.-(0PDO(aT:2\8N)Ve;OGF(M2&]6&BF9L)0fX8IDT&,W:cVT3EfEWN7Y
9fY3:M>PRAO)Qe.BI46QP\F1A@M\Ea6V\;+5cNeA^OYd;K,PKbJ)ABH1V]=:^TL/
-DLG5I94>#0VOSONg8B&N:g;0&f+9cU&EbF\a4V&[F.8QK_d.HU_.3bK8YT-_/=1
0A?;Kg&^3e_&8,ITWKIDF^.,)ZW\e)Z.c.9?&#,.;@,YE6#OGZT])7(3NP@cY5K>
G^/1_#VH8Yd<QSG]dCOE.P_.4HXQ#DJG^Q3_4G/[QWF0b_]PeB[PZTQa;XA-JTgU
VSg]20H>+:.EM>W\F7)OW[U7e.9GOCS<>);E4gJ_K9?54d^-CXU4<F9D]\ZZB2YF
\5e]\B+3g;6#&bWMP&^,+fAd+HGSbBce=J]U1F@UX.ERQ04K()[W1d#=:X5,X?c>
#&33Ef3/A[,eU,VLfDKHdCPeBMO@<7e)_9Fg?gF77PCFTY-B7C=X?_KEO(eOe3ZG
.9@bPYC/FM9(-gZ6Kdcbd4O7C,f<UH)65Gf1)VWG-9?_4ATW2MA>4f_LKBJIF)7a
6aPL\c[1>7]22a2.Cf#M@]OO48J2SSR&URBZ+29S?5&a.c#AFQ&[KLaZB(;?LPI\
Df)QPEc?fD3ZM/FLY:VPP6Bc;/:#=_f5/.dYX]P5RI)U/>G#E&]PN#Vb?RJ#(862
IJ=[6^;PW91Z^gH2>UJ+_(-[=TT@c7-QNMa-QNPB-UbA,\g/-W2-21<)RQPZ=3YX
DQ3?c>1K]UcH3YO:b2(0+0->B+NQI;_5+aQRUeG12/<C_22(OL+><aH9e8D3I+:2
LSQJPPI0;b5)YS+4VE\#[[QL-RFe+,;@@TLbPY6SO_(;fM&J(YaTR[,?^UERS&=Z
#If4+7#M7N1+A>RgKVaC=[XC01g4\]Y@FffBe+dD:gLQ/B3.c^>6A]dYYR9\W<NA
\P/-<G?SVU3=BP=cfJ[O(<IDRg8G>8V5TW(J4=(PaNT+SGGQ3(7L#\R&fL04FP<H
UYZ7==(gP-G7G\O3c/[-Ra,,X5#4C5;47ASUbTdC.30Nf4bXZMSeWW<Q.>_Q5C?U
X#GIPCA28_WaZ<:EJ<>476-BP:50XKN,Y^TDV7WdcPARD+@f^W]9H:LCZ8W9+Q#/
050H-A>#^1AP50UQ9+EOa,90gR(YU&H;4,I^&HQc4427F_I-H[g>^eM;HZG&804c
.bTMADPJa?,X.YgG&B?fYE@FGF@&DP-;-N[WIT][&EJUU@)N:?S;;I8dZ\a3^a?]
4fdb]G]ScZ(:0J1P5DKB7bd#PQVQECBO[LE-W^K:IFGG@3R=S2<JIBGdE#3Q6J6I
[RAPVFEB?73c1;2Y_gb_>fF1BJY-5?WGG=.==gQTf(MMD>71ITAZ4IR;,W^aC6/P
Q<>,<2e9SLB#3a:U4Y);CD9(,,3;Jg>-MH,9RN]#;+G)PQ-L85HBZ6JP[M>?/]E8
LK@:MV=\T;5]<;b?O_:E-Oc,O[R94d?&K]:J>GTD/9U@F6PM6;3PXeT@b7A/a,R0
\XcIOdeA?(,>.=U=;9)Q@QB:a(;V54T@A)d\d9C_G1\)9R+4)YHY^J1/T^@F0UN;
9@FT[40;4(S<=J<c.TY9Q[E)a7VAL&BA7J>8)6dTf]1#/(J+=DeLA.X5D]cVDZcQ
;QAILCJU.=/BY;6:Va0,+5>5D(-3Lb?>EN6eIb<[+KaU&AO._;B]38^9#;]N0L-,
VaZ5LXV(Z1H#ULTg,=8HTPa2OgAPAaOLfR,\NK:^2aF?4NGEeV3S,&OPcA(V]Rc)
2P->ITG.6(/]30gHW&U]OGJWI0D,ZBXdGMfY;950R8T8KV6JC5X8bU13&@4.S;^e
#JB9F<Y79W&GUFDPX,aD0bH5d)_FA/7_bP\.4=::&(,^ZVS0a?I3,)RFCI056:1X
V@/dg>+WY=FgY,,F@K[=3,c,4+:+,O:KH;RC,bD&U/77>/FA\0;1BPbEVTdcMI2P
P6;Z/^b<<d-0]9,1(M)ZO:T>&?I9KSbUec9>Wb]T7/2(P2:CB0Z>ZOSOO/B>>#RN
E093<Z9_VMebQ:1_JG/Q7,?:N[,L>4@KLT0Xd.KWQNYL5dO3I9410YdZ@eaR6E9G
bZA>:,S5N1Lc\3YgUe1DXL.C0R/4;B[;Pc#eB2[HSe?_AR8@23.2.;BgbES(2aIP
94A?>?MJ9@I/KP?[bQ;48_U7JJY1b0,UE;-T_)eM5^HW-27f[9.c>R2Y.8EO_/BF
G-59LZdC22_SDd/@RFWT(9\I75]V&)P8[4T9CNa]5RS&3daGd46;,Bb-+X:]#IXb
6c?O/>fd52/V;G7Gc=<A0FX<SCQSN:@+[VHOg)1B[<H2Y69BH3?2LZ\&9g?e#c87
:B?RM1/g(PS)TG;=LNKQ-FUNZ9UU0VOIbA&+D8Z=]OVIB>TJ1=/;/@;gV7Y,&B^K
A/-N-[gW_&)LE8a]a\/NZ#N[@;T2Ga0]dH?IWLfFR+3e=3FVJgc#.1GQ[(@bF/L^
^_C,[D9SRU::J;U7V-BMI9&,3WMEE@9]MZH2Tf,B:O_JP?9C30DPZ.E+/d=A7f8=
&SC_/R,O:9KUH@2UNZ:UFXMPLMIEBHgLJVNYVEUOO^@W1TAPKII@SQ;HU9c-N,<>
T/#Z[VF.RMdB1JM0D0YT).Q;@e0TI8]7.6#\A)5g\03c@2gA-:U9[D,&gbU+VQ9(
a7DdA1-.;\C3-83(I?,XQ)8B4\^N,6H=XbPCgWX.J:7K]-1\^X[gb0g#RNK>[XZA
UG+1gVEWC62\Zd/(5LGH<[=,+:M)K=[WRSQPcBD7Fb.98I?]YVMOLI>D\UeC2[]8
LI96>1_@)21gFSN4&6R/RQDR]G5fSeC0X9\e;e0Yf<PQcH[V#B:I)[OOM+BUBFOS
VDP^W)IUe;Id@STEfdM>RZdQG/]2d7M9WGAU]YK](X[Y2>c<W\J?6g:XMI0S>&c\
L>76MW8K/HVK8D.>\I0D^gf@c2V#FPg>c.O3:FEUAOgVVNWLCS:.R=Y0E/:2<QDK
RFWcPeS?/a9]f1;Z&S3aF?H+DC5d-2NFH<2&b92[@)63M5dfNBGU7KSeYS=19QCV
aHSS\.b=[2LZ_/ZZH36FA^e\W>Bb8b)7+5T?+A=6g:(N:6T:492aS86^I3fXT/4P
A7:0J25XU+A&KD6670)Q,R=UQ&ReD@A9BaL_DH&UP>c9>c[D,7[G(0O2a2<,M4_6
9W0[]Ka;e(fE+?>8P,?BbU.6TA\/b152TeZ)#Z2^2G4ZZ(Y)IV:PIMb3X.23aJ:e
,f5cN2CV;6#SJ+7DeMeVgL8WA,1&I;bb:EFDa+T,a-0B>[fE,X4B=e&2d3OcaE1b
)U^U<),ZA:RM2=(HWF.8g=4+G2#d<DM+M>LC6c;6D,V22E8feQW8DDE/MKAAWE]?
RED=6VM<I2a>-UNb(#=LGR-5RK/([/1c3-8/]]-09f^AdYbYNgf2VEOWI1B;3Ja+
(-.W@5TF[dFH1K#gfcE8RYU[V_b5S:]e_b/(0+F-6KJ9/@PL>-C\d^agc1&]#UPK
J\gT7LV^I=N-[(\ES<E6PH\+Z2<(Y6Mb@_4STNg?.7U@ENS4>FE>Y7=2,&K@E7SK
e-BO0e?U3MWaGT[?B&8[G>;9VRYV8S#Y-?EW-17IS.A1KXc?eUfYRJ6BIAf&(O<(
__]78=A&ER/cR.HF_d6dOH,_YITJS#-^VK.TLc_HF&H36S23S<3,,c-6\CH?eJF7
BPE=c3+EEFWgXK;D9O^e0+PTY/)?^eJ^GZN+]B/,b3OGS4HU2GBF3YGPE0C\/55F
SY.9MdB;;M38C-)?7/-?))UJcA8WgT9V9RHe:&U)F(PbXF<eR(P:MP]QA</MCAM3
Y:@7;#3@VV#H,&XLXc5?NU7a[8.@>[?Z3^)RA2<Q@1cfZ6A?UVY1G21?C/.)BD<2
K,6&W9g(_MNHE>a&&4Z)N]MCg1>BOGIF@G]BZ\;6A=NL;Sc.7A1KN+QJ++GAT_.0
36.>.FAR=_PFB47C6I?>;8D=JR4?aT:9g:MJ-+&VI<J&,J#[]Y3#[;=:DXZSaeL:
_IeA?7gcRHS>5G4a#N@X8J9\#,A1M,Y0E53]PL/#L4:B3f,bF&U[UKbc=deE[#VW
QTa(=#aePNe4YS8eFZcf2#PR:?_Sc3P[_cPLB>X@M\2D@@,51887WW7L7]3BKS9\
&D\19g]1DW3aTGdY4BgSVb;R0#Jf-<ZaGMP/HT7\_GN6KS0Q.X;PZ7J2MVAb6N8-
N@g#^647/JXaE:e<J,>MaW?G0IXB=0D@WZKfQN/VX5Re\8d2.a\9DS7NHf&=(5T&
FNg2>9BDC>;(1^^OXEO:GJCe(ETadI^LVbU;S7/2[C(ab#gU_?cC@./Q)36C:D7N
9<#0LMdZ/RINZ#c^13.+[^W\eP.CAQcOGY^AU-?JWbbO32IC;_A2+]VWgaK5?ccP
Sac2;]3)BT;=N#DKdd.JK&/\/7TT:JBe;YVEM^KXc?gc\#S_(J)A\dL@#/^.FY>F
DFGTS(.3Q==RW-Y5.]94XZ(C_.V?9aU75TbC0?)]ec.\@ZO;_c..Q#0VcD]0NC_b
UD.I-,2;T[L>CUZdQQ#&b(YB5^:.\H6JM9Qd<gF7]QW6b6[fTJ#WJ-bTeE1.22H(
b4LRR5<6MC(O@N<I/HeAAZ_&f5P54=?1GV2#Q9&7&e00JD_[YYIgW6V@g&,+QaOU
B2,+\0SWK@^J9A]QO,/^f9W/daB#Eb7cII:dPQ647Xa,T3860)-1bNY;5](Jf?F/
,;XMX<g21c#2^0IDVIB0fK4\D7B#1CULJ2g0-f;&]RT5V-2cM2W]C7Z>>XZ5[VBY
CV8KB<XNf&TI^;5)KB7^BfA-9CYI.BXPG@AP182R7]D,7@8W@_RBW?D8O#G;((fW
,b96&](9P3?a;W=1c:-O5>HO:,Z[SJV?A])RWGI3F)8/_CO-(Hd#WG2Ega37/C4S
>4eBSW#b4<ZcQF:NWV>4/@9R7K=_];.FW+\@TUZ-0@NZd)a3[CU5L6G;5T0aFU?4
@b6FRJ#:fCF,.G_=1KWaG?B#L1R#^RQ5Y\<MVf+K.[FS4Ya)8<_7c1#c\I?,ZZ/4
,9QMdN,Cd/S]A_c#AQY=(W2=D9HfK)dZ3)/6N+Z3e9=932)?+V?ZL98WBUG6EOO8
7#(V=C-7>[6VU2<B)SdE3A]84N(,QRP5V]7B8P,fJ.EZ2[Q/D583Tf,?J?ZP.d7<
.g(4E0C8R(eOb&;(A+YUIX@R:R.0Sb^V2-K61++XM5O]?>G7cOg<LQc.S+[R<KPW
efXCRU060g\/?-YB-C[F.4/NG=98HH8?@W9::Yg#X(T/1/]_[K/]^K[P+5SL5\)?
?K8FgHXa#4=PE(GZ]^@)MBWIZ@cA@,D#d=gg0(;Na(LDH;=E:(ZXd2E=S,<4?OZJ
0V_85V:RaL?EOO9&[g@#1.+\GYVJSVT92Kb-bd;gVQ:[)Yf?3EgJPON)<#b,Y)@&
cWI[HO4R.MB9^IM+68W^F8MZ?Yf2,^]F_F?f<eJ3XW]f(UM@<Gb)[4H8KX9cDKDb
_)F.[):Q;D:^0LJ=^E=G#@?2>@GeCZ>YS3e9P#4c.-A[NJ5)fS&8@eK[\(AQ)Pa[
@,^US928]WfC/=IbFJDbI]SD?4QGQef8ISA?WQ8>8PEY#+C6A2D@G73NUHO>:YN+
e0II[9eX#;JU?^#<>MGTa8@O;1;7;_0BZS7[@IAJWH<)+5C)TNPWVG&2Y9^[6AcJ
\YN[1QMfH4S4/-D]ZAA;46dM+JW;ae5DVXSA.-LL\FWW.2G.)+gY@+=+3F)7OT9,
b5..F(8bB90],_KW@<>]>TT8D>4Q>FDDM0,.?J1RWJ3BYFH1.=7c9&KQI&OKS0b8
3)>4Me6ELf=D/VTB?HMf@L3R6Y,+:9YeQBJ81)N07,[[)=:ZI&B:L-8D:X##C9dU
HAX3UC3);;_)U-He2)DLJFDULY_#eE&A,5eDZO01949(D34C_@UH/B7BK5Za.6G=
=3[Jf8:)IZZ4MI@<_+8J569(ad-0IU51,[2I-TS]GWcS0;Q[fB2aR,M=Q3F2:]Y3
eUcb8/S(GXU3A[fHQN6U-+],#&FTM[)NAXPAOS.FgJ\:06Q&4ZD=DS<33LdaG\;N
&X:4=RI]9X1,/DJ:9<AV>U37=+[.J<bG(X2DKM-+d)VC^N+QW9RT226Md#0U4J]O
;O](8KK^GWF46=8CML?CDgL/()c5dPgGN1a@Q3/=QKTRFDS=Z4a.<A6aWH/A4H\]
F[5)#4^ZN+bL(E6Fae40X9/c:aLW.Q7DEB1]PKNcAN_6M<4.1VLbFWbMO=-@M.13
5]7XBI#VKdT]B-Hf:47ID@9g>7SObNQ#@HFDcg;J6<J7<A2H#JN]/8b(FC6@C_P5
<;:;<>/)NB-/8V0eH)YLGI??_(6ZUWdL[P5Q,N\ceZHK_[-;eJ+&-WTeaM,-Wf=Q
;[SF<M244YcG=VUcGWQ2[CMQ:-H2]Y<5()bGCI/6g2)7L,]P<#\.bX7Z[Y1.77<5
fZKJKU#<?TK;]fTU#,6>^L]M0ZC@790<c]6L/=^:c(/V_]O^899ETg>5#:9Cf.&;
F)?OZ]C<.>09>_aRE4\<]:?5_YATU>c,S+f9^=a)4D5CC6UQS#@[4#R]Z)H+Z=_-
JA7<<J1/OcO,eDbCJG.4g1>80F=7JgBa@>-5\aD>dTJ_/A2FV83FCT1+H3>7gA&g
,ceKIe8O#)GMfPegT0_#W.UDPM:360G;@DVU<W,MUR)46BI;>b:Sf36\8K.4)/WE
=@NB0.fCQ5WCMgFNC\HAfQ(YTeUF@9c9bBb<P_\+N\8QG-I3<gVYYYE5).=@4ON0
P@_aZ6S]4-[:(Ub:#VW@PSB&/Db#(de>?+gH9B2>_@.+?E)3ZBGE4P(-e(LB&-Ee
7E>UTA^LXBgeI3QY4>#TYF7MfN]^XH4+B>ZB:/:W(b+X9-O6M&:@:-6?.&KAg#[5
?FU8dJTNV&<]:b;RXU.EdSNRcX3DI+Sg/&^0K<Z-7gfa8)ZCfH\g:#L)-?@1a56.
/>6^UAD;aBZE]N:Vcbbg/HO.P):9_>de?LT8KHEe[=TeA3[V5.2K^_]O9Pb<YBSL
1^8M[1EI=4)@LZ3HEWdH\eM5;1aRaBfZ1?\fa4+J.CD#7U27_R^AP-QOSH;cG+^c
f+Y\fFT_N]d]YCNAA:XDEb&NZ)NVJCc+e//fHJO8IW-#J40LV<K.M8<e-SW#ZQD7
B7g>S)1:(H[B[.P#B6Z4DSZF9NT9-_+H#9d^bfNGLHafb)-HfDZU(RC&bF^^Ca;5
/[7E)HS37e8B5?D:-S?Z9MDfXC>LPPYHc,5:.D\QW=EZ2c1Ta+I[&.a?LBOQX7.T
\+M3?@Y9\VN1\J#bYO+YFETWE1SM6M9AZ1eOgcW-#[QMK&0f@0@\)OFEDKJ&7<.=
[-?JBPLeSFA@<a>]L<]@M8ec@-Hf<33@3L^)^C#4NL/.fD2DQ-a2,:[<EdgI&:L@
0Sc-<C^SgML]QSBg:IAA0]X=U>[/5#]AIV>a&S\6aQgb.(ZULe-PR=[/CN6//=K0
)B-DQKWa(:IQe5(<+MRMUF2&I1&^C)H/T:AR@GSg.-c;>,.SOY32O.5,abGH[_M,
.D4,/(?b,IWSJ(A.bDcC<G_CJFUZ;F+FgL#45aI#S^@gB_]C8b-e7N[C[C(/G(K@
Y^ff,3RKCNZ3XTXX3UKDaTS7.a3F@&BV<97gCRe,=5E0AT^&O^I.DK\)^Fff4e@_
)D:-H7ID6+JgPTAf&D2Df=;5[.9U4R^:(_Q)5F(-YRaC2PG0(]P58NSAg@/f^\ON
#]H=IF(],@D;MI9YDK1AS?dDc)4KN&#G.U@UE6H=)T)]28V,aZd>=I5F([P93Z+A
8Qd5C]-4KO^O8E[(.gId_adOVE&[_:MVb@#=G#GdE^SV-0;/EVP:NJ++J;a#?[AW
6/e=-P<>WSU9/,3Z[HR0a_#M8C&>;93:&B5(<_:M4^M?f\J:WfCHc+SBJ3A\-@b3
6:#R4,eZM^1G?D-#P6=LAK3aQ?eG,^/+;VfQ)\[D&];3R.Pg&aKFURLag[/D_g+B
0QRWP8UY-EU@9OH]V=F^C4UD<McN()U@fJ7SAJR:.2HfAG/N.fK)geXX=7c/R)S-
:fP)LD@Hc1[B\[R:LJ])J_5I/H?bRQb^bA1)64_VAG=JR,g1&G]RP-Q&EK)TbB23
R9TEKB(18OQaI_O,E>\0QAeUec:UW?-2^E3.3KS,O@5S7HaM<#)>@DLHOV2L]V2Z
aB;c&/ab987a6P/05](FQ(9@a&FH00Z^CM[d^g:F/X]-1+)7gS:__#0-8WU=E_-d
Y9eOP&?;PaL+G&)Q,#1CT7,f^1<H[g.NZK0Qg0#+&DWWF3AELU8;=+ed6NUT67a9
26LeSgdE>&T(U?c8RLM:Q0Q73/1;]RT3H#N1Yg65XC,Q]FPLceR+V;;-WXgXe]@d
>JO,\e?HD6LH]35(cb)R(7f_8dcNB720@RSb;FN8e_UdbfX6L=5-=G3dK979-5aI
BT/77YS^4X#)E^;_SZfAB(:@U0O>/6;];SO1BZPB>+fQ\H22NTLA:b[5/92^:A)>
45Z@@P2?^5R)?-+05C?e-PC9BUOaE4U+[IG2KbQY),Lb4S?d7L77=O^:2d6P5Fc\
X89HP?^-e[7ff=PTcO?6VXN/1NJML=DT-c>fe4(HJEZ002S,:6S76VBHS]T.@BFB
\&g\N#DCPUAPgF@MaNeA^&=/.3DTXJ(]TSI7]QfHLS^RTDSGX&280@7>H:FJfHQ/
F#9Fcb=V<_OfY&/NCfZfE[B@g;C,G3H:WV0a,UW=/7cHLAE]_+L9^(2bc,52I7b<
L,3=GR]Z/S2FQ7IdKQ_BCff)e&/L]FV.@a\1:&I0G3IJ&UO.<e:fSWa].G2I<1Z(
EC=+]RW1)>0fa4@^K5KF3_#DJ54FNJ&\HSc6/A8QXDb_YNQe5a>PdMLB?KYeD<EW
dZZc6PD;RTJPf.UUMPL.G[BJ;CR,.R)VGQ?5U^\,9)J9JDbc>/T76^[1\TY-EcBJ
/;G3>6G^9O?V^OJ_0EPDQ1T3VGC5X^Q^+T#C7=EX5([ZN]]X(9,8ff>;9;)dEDWS
]RRZ@,a.M\O<]aaKCB]TUC?8EILdP4F./6a@KU:cC4=H-.c1:fHJ]=]1EG(Y)0P7
&=64/J3Fgb]#+J?)<_UTN#RGe^1]c(LI^47MJG91WC]:dNLK/49BY+Q6?:9>5GC9
O3/N:^UK:GA+]I0FP5-cXRE:FGWf:33f]1N)7gPQQCFJce2I).RKSOWSZ.-a.\N)
U6IaRO.YN2g4e&0:ZbLW]_1eV_^YR26F?OdIHBD=)aE89OX_\4]S]]dMa<Ge\2>e
BPF:I2J+8dVJX,M9^[G:).a_4#(Jg+5aZ,SS,/SRfG@RVHP][-N=8:XPgOGRP/g)
1dCQD7H5[=L#A/)85PJX#<BVY>^Q9#(]>b=?#dB=R@B&AS:-TH[9K.UM[9M^IL:1
++36;dJN2X4bU9/HUH_&QZ^-X.gT,97[KG#(SP]:Y9?_Ka+eUaL&Fa?W6GIDPKSG
@/;XJDU#^739U<c^EeDcE8UQ)a[ZTRe[ZB[D3,XXPO&Ebc<.BT?ZY&MX(UK@,J#g
SLG0JNQ-eL>BGRJ]E(BL](3>_I-8=YHQaKc3(YEc][9ZaXT<?I5EaG:Jf^I59X<Y
0eJ61RFBC0C@3)T_&&-:@/ZG\:;N4b&M4MPb,7GI,#H,4<-+HF7DRVS5W<dH;F#W
dCb,;1XJG>YG3fcIEA:OC>D6KJ9@F=g\YSP5T,^>g64P9<W&)7\KZ7fSU>1F.MP,
eXR[QQA.V4:DMOf^L>-#fUA_g>@X@K@G([7LTHQfTBA6eR9/I;7QKa2R,f\ACPA5
/IFbcQA+=D/OX8d/33P?6D6W?./>R?,I+JC\@LP^(EL&AM/VHd#@VRUAZK5+U[^D
@5EdYDE2Y/V/3MA(d?EA&4Qe@GGZ9@WDPaNe#GO\1fQf0X07]Rb-:[?[F3f(d7JI
(dL9Y-f0IQ-af9#(f&X77Rd+H#bAfSJY.+3f^W#Q0KV]<f-5g2=V^&+D]+/GE#EM
2MW(b(8N#@\78&[G(TD1E21#+a5&5ED6+J>SC8D[4?&\4gGAF.>e211d(=IPLC)9
,7Ea0AQW4.\79F=8f-]FfDDOEQ-B?F3,-[D@RBdNQR?0J/+1=TUSR[H:7\E&74__
+)>^59=,5OUA3@84^@-+#)[;d&D3P?UaT>[YEQf_&c#O-[T9bQ<+<R:K-R8d06ed
aW&Z^ZXdV<#S54R#TNBdFEC#O07[R_TL=M-X[@)@MfUcD1=+JA<L2.W4WBd>g8S4
(-C5-.8ZSED>>/=WOIW1IF[S<Pb1+QMP/LE>C>IT&f9gH,#M[4,YVG]I)fW?[7.V
IJO;5PVLKL@:NefHeA+g22BK=:7C>f1C5(bA0DSA6B@6V71He6+Q_e#CD@I7&,DO
8<[H8E_)M,0CR2P)[OSZ&H.42E3Ne5>OGU_J9a6LFV##DF[T8;,8]Zc5-HAIfb6Q
eb,=M/0]]=M?R0SQ3:TgK2dQONeV#eEW2BaLbG=7UOT>A2X.0e.4I8&_?Yc5E84M
FE#9]S/,;TO_4Q6HB:[gOJ/(3/^+LDT1=7E.C&AFT^f()V?M__057TUFBXCH:YV[
G2OdDK78f6E.)5TBOC&g6fT7)?O8\^\I@YdRB@aC^V_f&XV]&,)CGU&bV8OIKJ1d
HX)T489-1J7VBS)99P^S5V?JM__XLf-dTdFFVG]WXMS5+X:.8#3>H06IOM.#d-7Y
H.-Qa,ZSWcf03X9d^GO^cE@]=]=3J;0QVDSbZ[&@^cGLO:25;d^T;B)QfDBU_V)Q
bVd9).6UO,2cD2H+N=>GX739:B#Te#MU3UA1g)2.E29=@dX@V/WZKZ#JAS<bKD,)
QfL7?762-+/AG=/a#=b6P&[gTcDLOKeFJ1J7WU/VYV^8MC.YFY(9Q&VgDVJ-CNU8
d1-be,)AMeR)GP(C+\P^M0?-M]7DDVJ9P+(EeIg2O(P#<I7E+A+LfQ#WSCVM50d9
3e-APg7.R&,.FO+<:G:V,>b^)BEBRJ3\eQ?cLDb;KV=dZCBPDOM[I?^(VP9\g@DG
>c6/-@K/GfO=T-UaTLKQ#71Z,EBAXPSO>\Z73LC.1X#e^0:9JQBH5:OP)b<MM_M+
6fa)d02)d:)7:^eDG<b7U4OZbBC#Z29O[Xg@a6SV1^9U7D1eR(.)->&U:\]-CfCb
:X5d<K)bV+&-GP]QSFc[K^c3BP-5A,KJ_JDT4[#DIfYe8O]@\RSFKU^(A4XQ7^FW
>UW[WGYeCd.WB?e3KB0E\f\_F6fQC48VDOXXg12,[OH&\J2/^R,2eG\A.B(@G;Y=
4BWA-=][9=0^GHSU-6X^9_5.\/.SDIPg3b:8\:Y6Y3L;543LM;?=S0OE@OcZMCPJ
PYP4LfA:&4O@:K62F7U)KWLa2#RP,66c@e.(.Sb6-2_NdEKG/80WC?](]=S?DTI_
@S6JNF)N?G^aG[:4>O\6WS00KA.5DT#:,=8\fP,cV33d,a@5@,A]K7D[W&Ng#S??
5T@G;@D3=]\ZJaEdX#GZYU[;KB_#MRV/^c7_VBC?5.B(P\M93DU8gRY0d9#e]O6\
G<g?(>HI7#cHaCNd#\UWZ#a\\^@fR]2#FE;b9?<CA4,I:^8P;2]bITUB<LVe30&d
<_/F]-UC6O_ecbX;347M&A<^bWX&:FdQ93Eb&4,IJ42:de>3DgQT8:(OWP2)@CU0
NJbE#T:FU6.I@0E0+?A.gHIZb1@Qb9,JBW_F.RBN(6L/@#\6g@<[],83N32\WfDT
:J_08S@I2.YgQ]FfG<I7Sf@3LH@_G2H./7cT<@aee29;?:dD=[Y6V;cFVffSKIb8
SRJSTJ,K]Mc@ZZ<aT^1YJ+YE31V<c1[]Z\>P-\dV(1QWC21eSH;X=L<C^TMQAagg
KWNM&IV9eM+.b&;6fIG;RR^@U=]2?CO6B15JI/&KSK5\28+(#@6ZG;=WQ^NL?NJB
GNe:F8SBcN1H=g(0d3Y@1Rc57bTGeH^abdWA#(.47U?4D3::K/TQ=fdBG9LK0e5a
FY@>c6D7CVNe_a&DZ5/@b,2<&QP)MU8cU7XGZ#U+.c5)=],;a^P??(F(,]e6Y#0A
G0X(I&T6NL481Vd^6AIM9QPXDJ-)b#:;(BE0?bJYW8&I/LA46cQSb,fORKHBN(XA
5,,MY)[e&Q8,B&[bM8(Yd[.9]F_/5BPYMIddNTf/=0)X(F7JbY9A2>R#WM8-Z\FU
(L8\;2I3cS7A?6Q/9E&_GPTdFS0G;bF&]?&[.8X;\CaQIPM@:[[E7+&e<HA/c(L&
.;Q/c5O8cSR,;[SVb6]gMc8D,ZeSYYYMNXQW-cU=AeM\MeU0_7GAcW+-]MK([P-)
?PZ+D>-#F-+BF;;S8e[DR>,A@T#)6c1XXW9.0>cX7W:^+L(BZEU#L+0Y=1:7a@:d
VY#=f5;\e.P)cHJT+b<HL,PP9@PJ@PHa^SXZKUG&(R>TTc8(GbFVCA?_9+U>0;A?
c#KH(UgAN886YPS4-DI_Ma&<1Hd@Z2F4+Y97cP08)=-<35SQN+Q=8B-dWRR(1#&Z
/,J^IW#-:R[/S^8R0PXNR+gFD\UbbR[]Wa^5d51b01W>Z1GY28CDY_2F9:TPT<ZL
1KC@ge;DMC=AD-KeV8/1ePOR)_J?fM9=E6GaC?33=#4T&c+YFO?06]RQ@J;4&18^
_\D(fV2SW?),ZAF8>[bM?W+,Y=4A@V29D3Xd@cZbPRb[V>A_?4IK1/0D?gB-@]ed
Q?dIF8Z8.A^I_\:QcB>L+\\<-)H_B;W5;Xd.8+\WUZegH[>/V.OC[TABA64@HL&e
<BaEg[WP=)\^/]B5@K_/4f<8A2ScC\VYYX?KCaA#D=>:f#V9]07JQLJ.dE\H9NMZ
-L,G#?#;]2BT?S]O-P8(9XAC+DBSB2CIYZ2Wg2<&(#gSfSW(T,1b&CO0L@6Q5B^I
:_7WHN?X[BL)<c977gF_Xe;GBFY>)8[Q==)60f1FAN3)KgJUdMU/MS=WC8>aI]SW
2C&,aP0>QHK?J^A5GD]6d4O.ZKGRM.S=^/H0(D9Wc,LW=&6[:R@?..I/>SM#M:H+
.gC4\G_TV;9;OB5E]H5@LG3+6,O=W2W(,/>c.IVZ_^XeQU[ScW_67IK>/2?\KYA<
^UPD^R>b08R((QZ.#Hd?3EF/;W.R@7][;ZZ6UfRKa\1GFYLH=bZ?HAJ>JHFGWc]0
c4209@+,:d^Z>9Sfe)?QJdE=a&G7?-)PJN=&UW-(bNN?N2A/TSY7A@A-VTTAc(S-
/]T^1QF8H;\<2,<9<870].=\I/V>-AE4dM[a<:(3DKgf.^eQ2JeVO#BB[U]\-=\@
R3KZT+EK9HH2:95A\(M5=8WNF@;MKLLJ&W/-GMZ:bgV0;@bOXLOHc3:R]Q^439.Q
07U@g\H3;>5&bS2cT7VZXRK,T^,[[Z:\PX>\H#,U-?18Z1;[&)NfI1H:[gb0^,J,
[>,1fS4:;CdAZ/=b#US()6QdSI7TV6-LB7?e+M(.4QV=+7-6LF4)_5TSA5&(PSC4
:@Df@@:gFJ[bH47L]91gZVRH)_2c/]f1IC+H.P4D[<M3A6gS9,^T:KcbN+F<\;^N
2)4PPCUR<RfP)<C0RWD#Yg)ac@CDURK;.>Q^QL/KUK-CYKb[W9UH@SQGS46SE;<A
FF>RgP5]gUQ#3N[JL\M<gMeaFZEHc1fe1CS5WQ;MNSC(),X6RUT@aPFD9@ZfNNN)
.V4@#6M4>T3A;Z3^(c;)N:3(]VEP@=(PcT4e#/)=TU24ADI0H1@P^;\BL)d7I3@g
F2HV3K0(bOMe7Ke#8M0NTd&[::@T.N5DLKd5#L@/Ld1R4A[(9g9OTb\G\).\5,O0
#W3,c/;(_e6IEg8XbGRGHYYQ0VOU>C-XLK+fGZ[Ae=VD9ZW,.dMKEgJ@LaSd4EXf
?W:W\a(7I]90?8&;<IRT4)ALM=,7:6gTQc3MKd#+K-_.?6++4/DEb]27HV[7fcTO
0,(_Y#9g34BO]#6_WY:2GA6LaR?^_KZAG.+\.7NH/QcKHGYA-HK083J0O7W4PLW(
V9\Q/-?23\H,Y_<(:6IHOZcJ.@Y3/0GW1=/b7\&S7CPONG2]TX4J3#9P5O76NL2F
IA&O.L)LYNBa:1If>3O62:80B]^_,D[E=e)1V)&2V@WJ]R1TB=4JE+_J@S_M-.DL
>,UBD<Z&gP-Ac64aLR;8@K@X8Y+O.56L=U1#bGbc_F67@8?<K52G]cab,0c:1^IB
fa5-9Q2eWBFP,ITH/\2R<5PZ\,d1QM8<+_X>-c1TALb->6^0NPL>5X-3Z^H0>\HO
T&ECA6b@R>++6?F47Z0f8g+Tc65-\@1ae^0RS7U6FeJ/U&)f#UJTaP42OBI<_8CM
\=-J3&/IKWRB=#bS+,=gT-ZT55D;1#K&<9f#_=,82(KgYDE@XgIMdf8PfBA7fYLC
/^f-,DHKB8^E(#I[SH05>)0Z8(3)bYA5ZcY<gW#ND#J>JEb0:(DRRNa=]\TXC>,U
bVQ0=85]GbXHKFO@EHe&W]8R_g1,#Z,fNLP;F2G=1;D77ILcNZ5TT\BH#L>:8Ie-
697:K1.QB@6g.SJ1V?^T?+g<IXS;\eZ<N(ba_2T]UBc4LJg+,#<13^ECY[g#/)BR
)[9g;B-W>P<CRWUb=K>M_Vg<3$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

