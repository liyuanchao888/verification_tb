//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply SN Protocol Transactions to the driver. */
  svt_chi_sn_transaction_sequencer sn_xact_seqr;

  /** Sequencer which can supply Protocol Service requests to the protocol driver. */
  svt_chi_protocol_service_sequencer prot_svc_seqr;

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply Link Service requests to the link driver. */
  svt_chi_link_service_sequencer link_svc_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_sn_virtual_sequencer)
    `svt_xvm_field_object(sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(prot_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(link_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
fSD7Ze>X1605U8GJP)KJCMCcQ8WS00111IAOd-0OS[?J=[0+\S/^&))VKf)8=GNT
b#5aS;1O,,/9FN5JKB]1DFN=9,\))>-DFSd?2B.A@45DRNNX+Gf5dR/CP_6?)?^#
-e4B9XRL=S##/c3:6\DOTbL\M5(TK8Y_c.6)BY-4R+REQ5VN:b;dQfI4PC1N/Zg3
#LY=\V)+UMFU+O[0WJeXb[_e[AM0>Z<PXH-8#]8WOO;FJZ=Z#V4H;VOM#De=&a^Y
UNT=SB8+AZf4IdU:P0UH=FSZUT]dEeTM>OGfeW^VJW[PFe2U(ICWYV8g;,;bTQK/
c97g-DBCN3A-#VJQ3O<,YZI9TJ:Nf0/;@$
`endprotected


//vcs_vip_protect
`protected
5C5/&-N.8/If.\I.:C=U9E/[S@?KEO[KI<YKAM81?9[<2SW?GAgV0(W^[;21egN7
R<I4a1U=THH\^LLT@,L<CFEI6b&P+b#5NBZ#B;09YZO:?G&3aGQ4cRaFdINNF-QJ
3+@&[WYLR<I4B2R\dO&Bc/3d_V\7Yb2]>eXaF=(JKS_gKY@SY?H_.KQN?90.YGeV
)3bb_L9gF+Pb=ZTA^CD]LJK)7ALJ]OVEDd,H0BALAE2dfPT2J-_3F+#4AA/0d+RU
05B[+G=;:N(=fB91[?d>g.V/Q^5IW7Zb3baSMQ@V7/WUY)cKF19^\JO^?1#_<HN^
0>BRK)OG\f#R]6O.F+2#OJ[K\FCS,85XfE7>0GI183ME3I(-ASF(J3-aAEabNaHT
3A6&:,cAJ[?NS6.R(M2;+U?W;N>d<2c972/\EFMbC+a5Oe.YE;3I@76?D\gd;dIT
@2P<QFV/6H3gAUfDG\cb[_YBaU]0UB:B8R6#MV>g0M3B[b-NA0Ng:CeWPRE;ZRPZ
K4/_C.PO]f7Y5;@[\2aHZB8[@;#=R)_&N45FQ4MJS:;d@Z566dG:e,89JcT4ZJ:U
I\8:L[HR0=XQFGM1I>cLf9HA;bKO.7@_V2c;aWOMee]aSA9R,D.WTK]QEb:W.:JY
5bJL6Z8RJR4(Ib+9KHZf7_K/.<7A0SMCD^9630I?V];7LP(:ag+Sa3b04J-f62IT
@e20HQTDP;<2TB^_P@016[d&LX0Q>SF7A+e1:NFgP+cBK,ca;=F(fX8?:5-PYI2C
^AV@Fe#V4)<a>)d33EX:4><TF330]UQJOEC3\4J^P<_6,F\:Db:dUff+-4E[)d/;
Df9:Pe<@#+RL3GKN&EFY[f9R\R[9&MVE<fCN]\5(4>&@M\>)MFBOg8SCC7^)&3MV
aR((<8O/,5:;3@c/Y@:XAMD-.V#fYHNKFN<S<NPT+UfMLKd.FN/eeM5#5WJO:W6F
B+RVVVBaTH1(Q-&dWf1AP@FAf6AJP4Z]SSg\Ud5I8accE0_<,:E,SG[1NF,DV^/]
JcWZT:BO_)fN=\-RZFZ=63KWOc&]C6;I]JQ8??CgfZ8Y1&g6ddIT\8#WVRZM9b,?
5&PCO0eKSYV:58MHd?d=/UIcVQ#e(:93&UT#-;/[L6F&&5]0@)4QC>OcUU\5T7KZ
EU7NBFVW^FI8E&5BS5T8f#8)IE:\\A.BQ?S-6[bP5PW-?fWFVJU4,e,[R:c[IbS5
PT+]78(b1WC.9A4aZ]W+;OOYMV#E65a<WKU^WKP:EHU9V)/;R1M#F_.Qg2(^IQ1T
\bC_=X_W+U[;/=)[TP6Q:QQc#LMVR9YTF+fIde;a#66:7K-,E6@CM<,Q=?X<]&JB
#=AJX9M[\C5a>C2+VW/T:U:E2O&LK(YH1&&W55/V.Q;9P<YY\BM[K_,..Z:PV,WP
T1>cXOTe;5=);&A()>O1-Y_>U\Ld,Ae;Jgc/+<LLG?\[BTD@;_P;XOb&CeRfgIf&
,EM2XPD&X^@?Y951KAI9IPQ/XBD[3ZR7=\N4@I6;TY\AWdB@+<4Bg>65c]>[FQ.N
[RT?ZcGaIE6eb44cU?g9R]\VTXgR<V#QRZ]B39H2)IT--d3a[=AE0B@<4[@#\2b5
GUE6XK9d0IU^0<>@R^N?M)]>-\7+),D7?0aTeRdcF-0aOTOW;[/90>;XAbdB_;/[
F=Q(Wg-c=>)V6&CR7<ZOWQ\?<<CNQ2]RQTdK8I(P/&B2gAZH6&9V]Z?R<^SH50VS
H740@eVb7W5Ia8_8(BZVRJ2@\_P7Z^Qg[,gTQQe]/P=EELMb.B[8)S26JKaX37(6
X>;<31_d=+(bJIJHd.8#VeYg/(:;VH4WO3V5aGfUXYIFd3MC2-=Ec/&JaX)\0/1-
?4\4QG\[91g^I.\Dg-JK:?B47L6/LD:2FF?=A>d5Q#BUNJS\8<Qc3]JUY>gV7JCM
=V(3b>eg0.U=.MIQQO.5)_fbYEP]OOAG\7U^&WIS>d2GPT_90gIP90]gVD+U?YLA
FL6)Y5Y\QT^L.WQF1Mg&^^TH7gFX)ZT-;]eCF3ML2/R6]?-Z#f86@@-cP0DH6<TY
.L1W83XT\&^2.F>=PYO7;PF>QGMZ\MM&LM<@QC=?d(edC1-8U^e)Z-9K#8@,e;?)
1,Xe]U3CNEf>@MaBbX<YFN)Ra19MR7Tc(>;@SVEOG8P?UGYS:G)Ya44&\QN>9fV>
Q9#PU[SBdA4B7RQKY7cZ4JCbV/M3b?5V#LeRF+gS#W?aPV,cFHE3@R?W(2Y0d#^B
UN;fa54U]]J1X]]7>;ScYSG2RFI#P+fPG<c&\M/#[+91OSVUG9QS_>NANKZ)SFDM
ZLI5O#<@6@BN];0?6D-_HN2@^a#@g<e^V:(X20SbbT?+YM#I.g6JbD(Z5J.D72@/
X4CL8UE/^+L[f<(Qa@;\<\0_0.QJ0DPAg4]P=QC#FN,P&-6TMcC=6NO;DA+Z0aC0
CO/QZJHIZ7/_?24CB@Z\-<M3PTG#J/H_dg7RKCH^/Kc2eQ/bC)0.&aKAS\YSMR_f
?>H>=.G_cV[5AWf#d7aa[cY;>S4P3TGMEGC3AGXHN)8Zeca3@9]Fgd1KNZ,03LY0
9?O6UFE;9fJ.T1#KQEO,V@a,9GDNc87RG0+HENQXLQ;5#-4\#K^(b&[If@JQQ?c-
\>0@a0Df#Q&BRNJ>PEVQ+f6:K@>/:>3]X.ISII1PO=<?Nc3(PdFgMFKge3.5B8NB
\6_NbXBRURFA\<TTgGT3(D[UTC4Yb11@6)2cDgJ+Jc/@HgB4?1IS+2G/cgf8@RaI
BJSUX>b=&,g4<YG#L.>OX](<SOEW/+]EEL\?.>41-e+,F<2M&Y,J7=<W?Z=E:;dB
gZU3BWc#AUTf\OVN,?^?O545Cc:D?@L7HFFJ.)NQ)3\8c-E+F&a)TIKg[U:U:2gG
=ATb<_^6.VC#UUcK,f61b3gd>1AaV@]3VU=.cdd)A&D?8QHO_8TNX20I#\1()5Xe
($
`endprotected


`endif // GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
