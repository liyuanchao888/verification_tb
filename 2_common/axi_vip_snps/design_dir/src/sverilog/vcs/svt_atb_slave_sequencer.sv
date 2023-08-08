
`ifndef GUARD_ATB_SLAVE_SEQUENCER_SV
`define GUARD_ATB_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_atb_slave_driver class. The #svt_atb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_atb_slave_sequencer extends svt_sequencer #(svt_atb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif

  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`endif

  /**
   * Flush Request Port provides transaction request from slave in order to drive 'afvalid'
   * signal independently without regualr slave response.
   */
  `ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `endif


`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`endif

  /** mailbox to store independent flush request from sequence */
  mailbox #(svt_atb_slave_transaction) flush_req_mbox;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_atb_port_configuration cfg;
  /** @endcond */

  svt_atb_slave_transaction vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_atb_slave_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE);
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_atb_slave_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE);
  `ovm_component_utils_end
`endif


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
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
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
 
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_atb_slave_transaction t);

  /** defines get method to get transaction from flush_request_imp port */
  extern  virtual task get(output svt_atb_slave_transaction t);

  /** defines try_get method to check transaction from flush_request_imp port */
  extern  virtual function bit try_get(output svt_atb_slave_transaction t);
endclass: svt_atb_slave_sequencer

`protected
>R75?K@OB&g__(..@9WDK1GV.KTJBEHF8K@ZJ7;MC[PW_aKcZCFU3)bLXZ4;R6=Y
.cO?O6I;JLP@2-+:@_<LK5^N0MB0&KL]XSV66POOY-M2[(.59[3Taa(0I?QI9M>]
Pe053XOa23f=H-/A.G@/bE1d5K.OMb>^[6c1BD0gF^U)MP_,KG0@<T;Y,>[@3F?>
d^Lf,T=>KL5GS09TXRCI7>d+1ZC>\[M25^]bC0?ND.4aKV]7_,8TSBeSKK[QK(N?
)ISMXPPGHK5J.75Z2L2LY67D\0^gfEF_-7#0_Pad.C;H7&Y_&AT,_CX#,L=&VK87
B7^I3-N6#5DEWI0Y]A&eHK-52X2TWaH&><Q)B([:-;f3S6[XSBf+]EM@#H5JbQg,
KTN:4ZdEHGS:QcdF=L.Xd&L3[Sf<9W+,219aeY2B#.A#HOTbbXQPd[3JQb6-#f\2
MM_dSg\?,ZGT@V3a3EZRb4+>:X/f)E=(d]b[34gR>0c]^-gD]EaL-bHYOf#0P4MB
9]+_>>GHVVZ[;^6JY5XAS#MR.4CN7WZ>N/1)Xg/OKP/7)gK-)+:JF3aY7HB/S0f?
65)2VAaK6N&O9EO<Q.U_7KCAM55G?b98bJ1c80WGf]FOH#M/LK:aKE?.-.bBG9JA
NKPLZTNIS2A@-[?RN<55)#Z<NX\5aVFK=#(T>G2-2VCbPHMa-]V##P1a@Z+dYGIN
--e0dG@XW=2E[AT]fLQ[GXaA\RCHa8\?^Zc4..&bND6OW]BB:(6a(O>L&H?Fcc@MT$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
bc^IG(&)SV<;;U-M7;_8^I_V6YSPY7AK3\2U#.@&A#1MK,20SOP\5(C-N0Ud\@7[
GC\bf>G/QC:7CGN0DE7]+eVH^>NCcZgKX2;,M-YCA^_@d[&KcK@M\O1]-+]V\OSP
JfV(UW+FI[gEPT,/c^g6)faFC=ZbEY1)NHS@PM1C05ae[DeDXGVWPCe7A3M5EU)X
L:faDQV#9J=7D3g#EBOeLP15&I8]4J:+JZFO/A=O?I[?H]#4,.eI9/NO87B:eXT4
])e9K31GU,_J\+W5bG5]>E<5#gBTW:_>f@\QUZ/SZUH4?B:Y::4FMXBe+-0,\(@;
JOPFd@d7eK9]4Z&3>eE.c^@F5+6S-b51>QQ7c_9_&&,E#02&#=gPGeU@(_Nbg1,_
WNTOTR>,49U];KDVaFCg86XJ,#=49TB]0;5LI1d\+V==7X@J=dCH9f:,4f9EV<H&
N];G.;W<H28CNN1g7[aIN/BN^[9f=6T(^P/(/OXCV##C^_Mc7Z+><>eH/?./g9XM
\L-gfD8=PX[fFbY?OgJE^;\#)EK\>P)#-Hc:1P9<-ZUI68DO&YcBHKb65V@OVO0K
/<H2bTR636/7ID[&2T?KHGCD2NB,a:;\+FUe\S;.<=K3/BB-S1\MY#JCdfCQc,cH
Y()&0g<9K(-1/T_6+O[3G_:)]3EfD5LXL^PQD;20EYETaS10QO^4c42#P/#^e_e8
[DWE2X?JEX7/cO[26RdYWP77[4a(X=fABMg\0I;(f#8TV(XG,,b3@MCYFAJ(V=F)
,Zb?=&<EYN9Fd>>/]HF6PcP-#Q1&IFG;IB)&,GYa4YVH2[<A>?UNOfa>)7BYQTJg
]]FF/^VC-WF?3F#ZR0Eeg\RQ3FGUL2H;U57Xd94^df@<3:?(P#+-Y+^XMVVV:P.O
82I=Yb)9cYfEDb(O5:NN)9V)MKK4H5I@;bPgYQLBB\SQ_WSDZ.?+OC9KABB264&B
C/\3_]\DA=^]Y3Gf0[XCY=Q?\a9e]24D7,8&0TA,.9S]^TER>4(&),e#>;L48e3a
EP)S#0E^b)I-H>R4_J)H^FU&/<I[gJSZE)6O7SZFb84EW;KVD=B>CJP#\PcU;#(-
XF/^&CE]/NTULG0S,A[VS<)fX25C<7Y]Z-dV7^UHbd+LR&3DAW/OMN4\SS2=6ab-
JN/:PAZHVbIgFIH=J7=#/B/FX[VAJ<Jg)Y)D<:<.9^7dVefD<:3(I3bbDZU&GU&I
2]-/YJCd]V?fH,7AW9C1648V;B\a#3f7WFATfYJA/bTg5X;-N.Y.:7#U-;Z.O\A\
EI#bcJFVGNMa7^4F721:<>KY\VDF]_gKV#=1C4/.]0/(7PbHARC#P=#UN0Ua71/^
YE(#S:Z:-TO1\2&/ON#?bUfW/R^@D[A2a5YCD(Ge&AOc5IH1Q>L?84=X.+=gI,CK
3?B48^Va;JA(O?=?FE6[)T\/a38Y6U]dKW@N-<^S[/C:c8M834G\-:6bT>LU#+^P
]DA\9H-@-7+R&a=\?5NPD32c--f_<-QZ;]6D7HZbPCbT28BB:[,=7-Ze]F89NT/A
O1K.8Y]6^4AA@S=g3OSTI<C+0fM[+:23F-(a:30JAXPE;-4-)ODVO5eXMH(EX)IV
[-DW2L;L8YS<c_^e3Da;PQe(@?>LAO?fTI<Z@g^<F#-Na&dJbG)0K)Q4cH#fg2^H
b&8A8;C0-P#G]ZQbFf6<@S[?[DFZ]&#0.F-5GEaSWPd19>MF5/0aD3KOYH\SD7+f
[-HggTceRSS@YHOaa=B4?_SD--M:;MF)5O#b<H=Y469MYWBY_8]g]UWCZ<:2^+),
@TI8aJPT-g_V41&Y)U\OV84XEP:]_gL=@(3&R@+aBX&;(a[XY)DNfTVbQcYRA-eR
IKQ_KIY?aZFL+CHWV3SDFNEBUOQ>#+,SU+ADZ&^,6&40f;FOab?Mb+XF_NFC&WL@
;A=&A=_/C<f?E@;e=Z3[80&I++d.c.5(=9V1))\M@Uae<N>3\B/=V#XIR_fXSFJ3
O\^7dW)J<0W^)K4NEOFC);/N2c5O9J6.O:+W&@OVCN)3.?PJb6ZP6BO:A2JZMJBd
<VdB#adUd019S=]FgEf0bgF4VAe^,35A&?IO[]RC/H5OD_,G@4VeI_.TI(E77SBT
98.9PGE[L(WgffPJ[7cXUTN@aN\NDVbE(JdX]cWFa4+#dY>KYO6:7MENC(XAJIEf
[;GIbL9@L>/H&SF=BbS<]D,]@FOV>^7T+QfRDCQINC/@cHBNTFF(d]4Q/aLA>)P9
=3gA_=KgS4#L;d5=).8L+6TGe(8VdbG^575,3V>gf4B_O5ZLPBXJHN;dIICWPT[A
_6Qg&4KQb[@LET]:]@?M_>aX7K/6I@,:U>aD#[2#Z9[/N0?6VAS2?SH5FMLMZ?@H
?eL7\F2eKPNA0^;Xf-Y/]^U@J/E-DC->6B8>.9,7c74L0d?VLce9RH29>XgWM0G;
YK/N.HKVF[?QCc#0#T+:R/;C6(M\P3\De5AU7P5JI\,@V01[_2c0.59g6G&4YfU<
8&eC8-K8VP]<4g2+Y0(#:.MGNWPATIKg&:^;&3S\.^(4>S?>G<_ARVX&eXU\9XR^
)/1<T3V]#,JR8^TRO(9D+1M2VL,\G;UbK9Q63c(FR3+[T.D;07,E7)g90EK4FO#8
S8L5X:\<88COK\:,_Z7ZD]VOM<GQL-4B7#FdV[RaZRdKgWWZ39JFTY7^]Z-Bf+:U
<K-TMc+TK/_9\#cB8MM=#;c-EQ:Z95NJVe9=0c\deGNf+QHA]3QP?G=EU,.D;3TM
[SQC;A_I:-_(D/7PYb(G4R]:&f@Y;;7QR/XTf6fR.BX0M?ABSCE5(#JXc=&]cI#P
6QG9R1)cX;A0bD;+_,\5@gYP>6X0#277TKQDXR5<+ZYb?QUKQVR_,>6</0[:\?,B
c]:&IO-.N[H&G/<GOJY.KJL?1UT60V>M5(B&4Z,gac/:[bJW5(fAPE<CZ?&4+86,
^U,dL>JFeJSF=]8][(;4eBFS^U6XQ-9E6+:f,UJWOVfSEBgR+5MJU2\XK:db@/R8
?QR<5/>;Y]=?+XQXa^^YbLVB:O>><S5B,9=F-b@?)\dHMaIG8Kc/a8B\7(A;cJLG
5[7a29#)JG)H[@O#U?>J]\<HFAL6T[-9&]:V9P_B48gSF.&90Va36(E9/DC70>]7
bAI\-Y:FV1-T_53CK8a-<VHC4_6/3g@)(.,41(T->]Feg=\SD/K.d(?N91e;4.S4
__/,8/b3e2d_..7TF3DE053e1Z?X+6=.+\?WQO7^_b5Z:YBae-HC(NMHb3D-:WK8
gSc5SgZbaLaTW45?,MI&XX07+>W0;=f&>$
`endprotected


`endif // GUARD_ATB_SLAVE_SEQUENCER_SV

