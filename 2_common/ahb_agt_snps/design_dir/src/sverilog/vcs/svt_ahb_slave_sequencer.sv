
`ifndef GUARD_SVT_AHB_SLAVE_SEQUENCER_SV
`define GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

//typedef class svt_ahb_slave_agent;
typedef class svt_ahb_slave_transaction;
typedef class svt_ahb_slave_configuration;

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_slave driver class. The #svt_svt_ahb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_slave_sequencer extends svt_sequencer#(svt_ahb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  `SVT_XVM(event_pool) event_pool;
  `SVT_XVM(event) apply_data_ready;
  /** @endcond */

  /** Tlm port for peeking the observed response requests. */
  `SVT_XVM(blocking_peek_port)#(svt_ahb_slave_transaction) response_request_port;

  /** @cond PRIVATE */
  `SVT_XVM(blocking_put_imp)#(svt_ahb_slave_transaction,svt_ahb_slave_sequencer) vlog_cmd_put_export;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  svt_ahb_slave_transaction vlog_cmd_xact;
/** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_slave_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

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
 extern function new (string name = "svt_ahb_slave_sequencer", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_ahb_slave_transaction t);

endclass: svt_ahb_slave_sequencer

`protected
E[+(Tb@&ZF]b46I^]@c:U?/2PfNUR@9Ig@K##=ZZZ\^P]DfLH^:U5)d-MK=(f]T.
&?gD4KXW/:MGd/R]/cZD5f@c<G>DIRU3H^F?fZ4XHD&Kcb^QOW+/&A?TZS5V\<VD
U0A[QN@30[gd0.@[:\QI\c,CP>BK+P+0MU)<fVZ2HQ5>F#1M)-cJH/:(U=&S[Fe1
ffO-6A&_J4g(c+7GEZ)D^_[&T1ZL1F,N[1]/ISCDYK,F&40;d>W,ebY@9.bM<0g.
ccSQ.O-4)([1;aL9?bC7fH41\1W1Qaa<FNPfDODIW@cb?]JfagMJg2)7Y.T)8DMf
#g(:e]1+GO<KO-_][7,dQ/gKF/,1f(&+\,RcAAY.bg7)&ZVR<0124Y<W0U[B7)Jf
1EM3N66[_YR-B]4O^\ePLfVG6?)?EGB7Z]U^J6D5I<+]&CG+KS?ML9+.N8Rb\-BK
ZS6(0@=BT\H4O?g5cJGg6M:QefN2_IJQUeLL]DDE.@S1I8g&58+WGERU0#Y9+K^,
H>2IS3NR:O]#]dUg[Rf+d=&=[EI.-dQP9$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
F-TJ@A:T@\&I7-W:W^K6[,R.daD]>E3YLJV.GIJZ^OHL:VJ9[7F11(DQ_,:4S:>]
@=RfRIDA=ecL7TW^N+F-Y.Me(TUFV?OMGH3<cOFJO=Q8@/[Tab0FP.BE-52DOPNA
R/&ZQ=A&B^.f85,=aJ5?BYUeRHDME415SOQL49(TFACBSZ>G55gG:bN:F>79YBLJ
QfSO,2UJI;+c<.PU\16?I&/AWV7H_\]af7[bdNAN-;[?N);,(a7;(-UF2X7OC?F=
a+\OLW=[Md52PC;W9G9beLJDE9P.EIKg_D]d3VT#)>Ia<=FY;;N,=Q/O(Cc)QN7+
>1C2a92K[c>_5ON)g_N9P1cTBS&+S4(A49)SaQ/#?F1\N[:>T=bIT4=F8SC>N8EH
;RG[^4Q7>/fYB4(Q_E\UeHSD[-?6[f.=Z:fCFgD>NU<=Xf+)@[T<R7f.\M]0A4CT
^[RW1I.T=M?0@5LW[5(-=JFUP[4(HJV2H;61B\cI1MSg14-R_BVU[8f+^([TA;2F
(=>2MJ\=]]f?6d(]QR<L[].=^?C-?JPQ/f.P87;e0@:CFfFK+=8O>)^7+V&c_C8g
7N0+[fS\Q7X,fF-AD:S?e98IN#S42A.G4,\,^TBG\JIWba:5a_bc2#9J,g>PQ#H)
Ugf.DD-&]MBS;2:=Q822=J[gd@6cT<b=-M\^)b8VT709-?I23Zf4Jeg&IE/H0Z>U
V9c?1cED5<SQLH(X1ObJ07.&>_4LYA4VLb5f+V8,P_I(DG18RB-=(IGE.d+cUV<>
g]P-MA_=^&J0@T#fI?[].-?K#);b/L9@\B=G38F.27K#fXP&(K4/3NY1aA)SD+gb
@_B[OL4:Waa-&:(Z]I,<GHVQ1Z73)P)Sf+ZSBf+UT/A8G_Uef7FQDD8U+Y,6[MM[
5:]^5S^Yd/HDZF?dT&P+g79)W-2H75ITJWGSH+SKT-,ZQX?&d+Y5QY/dJ>d8PBCY
/0:6C:?5<5M7UR;<aBXZH+]c_d.NNM#0,J]@ZXGCCYKC\F]-?]a=@LQ<fPJA[bF6
H_4>/#QBRTTf104G;4>4Z4_^TP68:?YM36<)U+B/a2X1BOaC+BA@W9^G?7c=.[VT
+OCWFCegN#V(:E@#+.=Rf]GL@&S2_d49;]2L/U=Zd03JI]J]O0]MIS61LIfUH:S\
7[G5Bc;<3.PJ^;3&TR9@UWO7_fYSJ+@T3fP7#/e/<G9R-B,](V3PZ5>E\5AVFHE#
JJ.A+_4EHMWSX41Z7#^bK;@7P9d^LJ]JWGXA@b)9R8]WE<<;G<aJJ]gMY[QTa2H3
-BQC>>^Lg&V72.HdOZ\=UbH)-^#U><Q(fW=G>G@LId4^W76b+a13RB5H4KP7e_0a
_-L9/\O?3GPP117=c\TXbCPNI@ED[fS8a84B-dD1SV9QdST5Y)5Y9M:A3:2L2a,]
a<BNe/:-@N3Sd,LL#/<A<[:)LS\#eY4QV,S3FOK&)gO7(-)e\bN(4PVS,>,E:RDX
1/DUdWG2EVM]9SYX4e9/Hcfc/Z8=<Y2O;.H@J_7??D/2GgbT^RCW4)VZSg5cCf,K
UA;8bW=EQ<#_.D<CWD5)=dfcfS_VC+<dHR.R)QW_<4B(BaScg:Q+f>R69=/)]8Md
.bDg<DD,_GQ)=]3L#9+7b5>K@UdO+c2R9C+U:c\8<S[3H(M+5KXFBE<bCO[3>BP4
7)4cIQ)\14J+R3,<7BJ\bBJR_1OPA+)C,TW[;7\WDBcgC9ObO\@;]9;Wc9#JT6LS
A1.0)5UIF>[0UH2W.=2_D\=+#KNVRgF=:KI39KD#_2++6JA=C1VLQ-dYA3C48gaK
4TDCe=aB6=_AZ8:J8a(,2-V8CY,X_>:>P6C5[QD8AHMI53\Y[GV=T5M:T7DX_HOK
Md=2e/_O8PORK5ERK=bLK+cDPXL50R)J\@B216V:;])6g]85Y:8g=_WH-LTC2+.O
@X.X8-1.B.fbg:[VCNa59XM:IW66-FD.H1PC;FJ_E.Y+@=S&,SLbXU5F(d.#0-fO
94TeC37@6T+RFA)L6O-7CF1M,f9YBHf>FYFQa;@J-.B5RK)aM>&GDQa-AP6CZJCA
T;WCN]cQ7,[;5(&Nb(>U+9#R.6)409LZ<\aQIM6(W?JQ+?:d(4\K&,TgdIQB)E:<
@B)419MNaf\9P+IgFSa^S=[H0NPL(:73.,Q^D-#G@L(00RS>53N[^L[M3];2+3)_
QDa#Ae,cMNS2(6@P.J:BSU_NCL-Ce;27-HKHg4S<3I/R5g0P9<SgQVB4/?0_bI-6
2HT;aW;_KM^GM1APBHg61)QRe66cJ[cZTI:XEP64f8Tb:FMV8BD_<Uf,=>f>\_^2
XOB[ACdIIFa5>Sc68-=Y4Q3aLOZX^E[KEJP7a@KFO72ebGFd=ZGW.MCQN[Ca\[/U
C^=/CXd8b:8PUJ3LXZ1J8H-#/+(S3c.,8Y\;[+fQ_d^M0D](U2\^>N#7WP\Y,-Df
45+KGTJ<@S>7GZS]R3SH,HMCaFUfN/#Vb7.-TWZIZ\:0=H<G2]86)400GHDfEeJX
_,gQ1&])0E8.8.B=[,fVGAZ])YB-^+@[_[T+=4MH.26G)_gFIaN>UN>8S^1<)7[A
ZH?A#U>T65>]_3b(/S[_8bWY2VLM1<Xdea^KDD_<F#DGF$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

