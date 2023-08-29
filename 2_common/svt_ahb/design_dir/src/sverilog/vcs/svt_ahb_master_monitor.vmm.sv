
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SV

typedef class svt_ahb_master_monitor_callback;
// =============================================================================
/**
 * This class is Master extention of the port monitor to add a response request
 * port.
 */
class svt_ahb_master_monitor extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_ahb_master_monitor, svt_ahb_master_transaction) item_observed_port;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;

  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

/** @endcond */
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_ahb_master_configuration cfg, vmm_object parent = null);
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();
 
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /**
    * Stops performance monitoring
    */
  extern virtual protected task shutdown_ph();

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
/** @endcond */

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
/** @endcond */
    
//vcs_lic_vip_protect
  `protected
^CJ9#\Z]fHCP4gY0)QN037_?+?\NC\[)Ld7FQ1M=@gMeR;cNM@.)1(6I(V_.^\-d
f#&_:a-c4T]]&<)6<UH<#M3W?cF-6CGP3QISbb\Ab(FATTLaMWJO9#YcH,1R7QNL
+BPAE[d:dRQTgUKU>;_V.J]Uc;aXPE@GIB<9LO=AD>Obf)g?E?FE+AF&U?/B96T0
W)HO>7>SFP8L(R8DOCg]YY[0aScRGeK^V)OQgWWQ:IddfeTLBP)3Wb\44d_eF2c5
Qd#,><CHA:3:B&afL\+3>60M3PNbZ5HI++4e9XGK>POdF$
`endprotected

endclass

`protected
MC&RWa4;EAeY&9<>BN;P?#gBDbeS#QMae1;Xf60],3cdbb.G7AV75)0f2KU9@3L8
+#cWaWP+5:6I\L)g,(#>:1/1-VW+H9b10bC4Z4T8?Xe^K+;N&/4K(GdLU+CF(74d
T9W8>Y@dYgM=),5M@]-aH\9?P<PBY-X]<?N?L&O5f9[K?58\d-?-L>;b_TQ+29RC
P4S][2T;[,Ba^P)8V?\LaH)VF@FG0ec>3B.@gg.MSA/_58>VMV^^[R5>PN#E@/AD
=KZRQ[;5d)b=&VNQ+b&M+GKd<]R3dd#SHUAUY+eZ0T)5->KO.D/3\\(Xf]@:8dM&
TeVcK#R\71:1\HI1^R[#2UU-2?G[V^(YbBY0ALDb^MC[[>UHdUE6a0/X:0SY(^dd
;=ZPS1L/F[KM9DG@6Q;eX)=a(<KGU);&93MdICP/a6_NGI[Q3&@R<B9]_9g0TBKf
f,_V1\K,Y/T>TeKXW&b=;(<HJQ;aOBR2g6;#SN;]2,Mg=Q#e1OS3gM)NaT=,X#KM
626<7,I.Y.OIe::\PQPX\F+M9@K&Id=6[BW_7[TTJ+,4Og)+C#91=Q7__>ab_9.<
)8gccN:9:03[.=E/J/L+A7,YPgU(?>+R+V2[fFZ-dg3Za_60A//b^8)_GPLP4FF&
SM&g<9Q2]E4.>@VW1cZT],(&c2[,Ag4_=CZ5<,G6?NWU(>NWa7M11>S3?YFS5f7d
,H5YeBKHN(??)a:VW([KdM:<8c\5;0O]:TWd#=ME[bf2[A=,:X9a]\CBXaE=_?RO
S]I^,H>U_BNM+;AW+2&c:^1]TKWd^FX7&+[dZ1EbV9&AXO-G9(A4H[Z<6IbW3L)N
#[[f9&_(<.VK79BcOf(N4cRZF>Y?f)?c9f+TBO-&2f:egTJ>9H7c;:I?)3PV.Kf)
/S:_:#;aL&9?c1YH&8O[;L;dY78<]AOKQ1[TUHK7M?&A#3e5:DRF+Jg^[eX.CgVN
/bU(S13.A?>F3FM^T-P0b^ZIX],>GDD?PSIZ0)f6+VQSf^1&<SD21+]O-A^#/.BH
d^8</0>TfFDW8XN-ME;^[f;O^Sa-V21SKdeBX;&TK2-\?)D_AcXK\0C1SRd+EBN6
,T;74DL(R/5+M>FY&B+=2@MB]7NW,\HY94X;Q=F9B,]S:DMJdZA8(@&#:#XDCJB=
]D?7f/S_0<M65CN]/UVd3fWTGcUCe]C>^]VOFZ7:cJQ^ZLA\LKS,NS)SSO-FWCZ5
<N0MLA\;(=?@M>Y==IU43.0JffH#JVP:OVXU&)V]5IA4(,WJ3ZE_Ja](?U:I#)3J
673Xg]NNBK-<#8fDKKb][-a0V;5M<MM7^;[[9BV,gJfS)C7FTbG=/2)GS7=NXd84U$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
X=:Q(@,A2B>-;#F4+VQG&fKL)FgEV03LW.U9)?#^LNZ:>QXQ2S?A2(U/L]BX3<@:
)PTJ]Xa9H-<0?V:?.,?(7[g(SL5+aG[ZQ?@2e,/@:M]Q.L48JKV0GOUDKUPWBZ=.
Gg5BM+EZ@@T(3B\_BYFRc0S<<PHGT-R:F04K@)S0;+,;6A0eQ(?W><#D7?J_,B)M
5e/55bN,&&VFQdZR8b8D8FP1b/=/G]0XH1H(YLIQNa&GD1g4[J<HcN-_F5bcbb7A
D+WI7@L=M->_a0b++;g<]K9.VF&D[NN)D(?b>,+)DO556KK_>][X4<&M?Z4/7PN]
<EJ(K4FA1LZ@#E[85FDU@5>Gb73CZ2&gN(OXdAW8/<ZSO22]I87FdL3/IeH@_/.@
fF(YXC;Dc7:)_6E7f@G\?<Z\Pa[CaN\M9C:]c4Pa(JLL\)):/6RWg/Q\\T13KP8A
bG[J<QDc,K#I-,YB#KKZXGgdMcV6+LM<b2RfA[RfZ;/Y5OM?^2/3<BM7]]WLI5;?
J1+TD?_686)-W(]dZcT](CUEg6S+QU2>K-@>DM1gLY#S?F@X^D).;4\L=9W8),HF
>->:_)/C#P@AWf9/(bGe##DP.10_6.;dW#aB@6[^c\PEH2?eC1[a)3+0CGa>F+G0
@<bZ6V>>:B+8)-B2#P\EG2CEZA07T3Z_4db3,Ng5JF69IJOCB9,NL3,CeN=YQ<1G
G&&Z#52STaeP2ZUcS@[OQM:[gN9K?3X<^&f72MIK:J#\+>g6&V1F-Za/H086C8J)
RPJ6_Bb8VHX=^E)@I/EBUR9C&8VVSK)N?3=F@[V;B_M#5SgS-F<CR2,EK4ZGc,?I
-]&2>E5#Zf1A.<L/\@d\f)8Y<5WgY&)R3[e)WBb\.(OgJ)E4W<(N#U\1G\,9JbfJ
NCYP;EbWN?F=CT8\/D98JSK70Rd^e97(W@bOTVMUC]>EKE&6NWS8-<O8;\H/f#F5
C/-Y9PZ1FRd8>#3W0NHe.a+_38g:./D>VfP([DB=ZB0+^N4^?]3-).\a=NW5TI\A
9MV0[^_7864e7MB2V@,@_S;]^:VcE3BLVJTAWR^;Y/eNH[f0]e[,>[WXLWXI+dOY
G:SKG4.<#=0X34A3Df3V+=Ra?E@<M;cc/^?2<7D19X>fM[S[SS;QGJ;DcCXf0.]g
fI)c7/gJVT3RUW?;#ZHAf5^#,;VSE3<A[)(AAd\G_/<JA0)TU\KGD4_^Md,S\8gM
CEcS.MF6NKAE9>F#1>LH_25\7506e2dT3HT;a<+)LCI6dR^ZAV4+B@,^Y4E.042^
;Q/4Z/gN/RSX,]DE\(+)Z&R7C>N),IU0<.,&La/UC+M)J:+W1,EV3G]).H@5)(M+
+C4PVb/ORZcf,5L_55HVd@M;BV\Y=PaaL(/TE\1V(:gMG,#][)fc)gAMQ.P;9,5=
AZGELg-5AdC[\4N\).d^EfJ?f0@I?:2e^8:-:#Y(E@P9;Bc[<WAI:/>O&YbF#EgX
FIE42-#)(?2:3&+#Z#(3g0V9bbDD8[CKUSO#N.?dE)fU2V&WI(-O3ADc>:X<S^?C
d97W9b]/)C\-UdD3.[EJ^@_SM^<(O1C28H?=H@D_8H+(g4)8Z?-f9+^33]2:#PEX
WVcfEI6(_VW/F]ZB[#<Wc#/2]PS@@aEP>([(FP>5=3(9aQ3:)KCfG.?f;P<H4(:[
W,B)GbCQa\+0-JBf46ZBdXGG>P7S7]B97)U2;VUb9\Z1,V;5QMZGg+ae(I0f4\,0
?;]V]1<F>,cF;[UO.&CZ5)-cb7G\CEJ6H+Pfb)b?L6#D6]@^cEFI2:T\9Q^BgQZ_
N1D--;I=F]CgJ(K_O=Hgc2=.H@<RA?ZgJOKFMSK<Vf_XLdHMTM^^X(fD3bC=N0>@
AZNU01;413ESYgEG\X#K]LYd-[)RIR(P<We=^BWLX-A.PLTeV1fMgX^F+54E&d]@
DRX>/H35,&_-bHeRROVY0QA8(UT2cJ/gddKBO)[7Y<+=PNdd7SGHC:]MC?_67_5)
B)LMR)#D.N@,_5g[Q;c32TWU-a<e4ACgb8dfPITf_<D55+6SL7)P2X3eOUg6/8VG
>Xd>L/B65a2V(O<YM@e4Q9b5E2b&R<Y,/,TS#?F-Y?OV1:I4K7:Eda/bb((L6NT8
4_&&3L>gM:HKK_466VPW#PR9HT7]\\3#B2_<9>;J;WG=TJcYX<=D2B:\@T;.DNG9
/3GA#[0-H))A9I#0bJ^(a0MP[Zg&BBO9RZM9NKO/?2KVc(a77^TN991EC?(Y0&Ia
A.Bd_#/L7?.5S@;6^;b#Z93#AY=>PZC&?&@84,[C&5[)WR#W9X>PP9@EDM^bD2f6
02+Ma(g8=MO&D/GQBFSW_[A20EDRHX:N+<5Y.]=@P-3>1WM3KdD1Jc+,AM]K=;b1
9EQP,:Ad=>Z4L8IXC=-NZLGRAS1FYX\#bg&Ya6_HXdWNW=ISII_8\<5AXW8@,cOW
/[4>6dFF_f8&DK35W][9RLb=[+d9O?N,a[B-_VLb/\^G>1]RN2L_=JSd\.6OCJW\
H6F&\>@Q#S6B2I;M/T\-PfK,OG<,&/?C\P69?M0UFO;8\QRcWOe&eg@ICP<c1E]>
V-1?ab/[B3RZ8]V1TA/CN/KP9>V#YBH2]&1PSK;/[^EE+@FZ(FW_1[NAQ6Z+2gI1
[JU:bEe<G,V5Q6]/8^EU4dD1Q2;eQF#6#;))W/>W9eCEQ6^)_V<e+D.d</1TfO=R
#3fDM4gcNY1SB(J,B(;1e_PND0F11CObe9LM5RI>\eCB7C+=\bC?57KOY@#>;V4f
,W/>5b&B/:WB]_1B#&0^YPe@==AL90YN+gY8<=?ZH+SV):Y)f;=3,Ge,UX:(:W+Z
A70INK&dISOV9N[.?BS2SG(FYXY?/@.C.3CbSJFXEHXYaffCHFV=:KD[bX\1DO#Q
=^7cO2&L8YKfE1K?Y:eM+MEUY/OJUWe<7T]:85C0@=a_5gAQ79]d8)F<OWQ@-TEX
M-SJ#?+6fF=[b@@U,06;J1HC@f4-Z\CdK#:HS.a;;^BZA,f2gAUYP)SL,)f4>dL.
cG;9c^;R;0XY&JT@e^cQLM:(3O+?-<Ea53JPUIT;Z.S(\?DEFRN4fga9@Q?C^;IB
X+Z3Q#Q>c:VAQ=&)&2B,]S3[L]J^.5g9O-]_=;Z]FJ-\DbUUN>PXPQ,^@e.9SJR=
U];G;(;V_1/H@U=;EE-#cBVJ)]Mb-=.[@SS9U>eXZ4AA3Y73C2U(TXX0eC6]2D@E
-WC;573a=&F>F[eJRdKK6Z/@]^??.\)+Q;^95]A2O2e]AIgO96gR?;VZQR1EJM6\
,S#_DcU]Z23Q9NDL4A-g[&6Ag>_A7&I=+OGgZ]7,^TSD2:8IZ8O/#]?BFWKODH#:
0_^+PBf&.(-_TYT>EQP/GW&6_EC^Qd>/DQ_Pg842IGH(H>S/Wa(N[/./A8<BL/W\
2=C5;&P][1<(]7&)I]+&@fIbJU[FAIOS03Q)EC7f3V]:<F,R:Ad=AJ(a,CSDeW_5
;AcCM.ASG>85+D4Z+dJ]M,17a\+@(N(9(XNE,>C4[5KOaLQQ>J(^ZD?0OcPD];D-
5R;Z+fS1OC_#ZA+#fEIBTf@R9[MS6bK2gFS^Q0JQ5HW(H3VEEf.TGE>W_6S+7[Qc
;0N6b&4:@f++DGCLJYO@f3.]6+;>B8RH<&bK@SA#O_H\;BMTWJ)<9CRF/CU69L;b
G0HQ-EA?^c<^KGF].>:ASI936N2Od<P&RTD+QKEA>^B^_W(@DP(17GKb#)BO.BHE
<^c]()H30[(SG&.,S/gdG\E.>014?3Q\b3\S/A1ZfGS9f^>>TfD^c;B>c=Z+0H2.
&B:;FUWUdW@;5SR/89@D&JI4>8D,LbdT?##W9&;0Kdd?Fa&PNRN1,8ZOO@F4F)@B
)dL8X&<5?4)WY2H7@\^QEN7E(56E.D(C;W782C@9e_NPTI7FIW^,_E;Jg9=bdON<
/5QZ8(gH>33b0,BI4d0J.bJ5NG5bZ#SO(S-:D@VG#Mf_H(ecPc<1[;F[6<Q?9@3-
6RR]9b=[7]J2@1:@M2Ce[b)>gdQQ7#RZ-LRgW/AQ/=Q/&-ZR>FgMNf9HJ[8Q(<O(
.MSFR):GZ.8<6=^Q[Xc5\.d9<8>;UQS[C1O1;1+@WZNJ=<]N8VMXZ5]227TMEbPY
9]C,b@B8LD0_(gf:T>I-9Q0g]_SDJSUc,V1IK4KQ.ZL9,;D07I;MR__W97XWZ87U
3O/cDI0dQBIE<@PfEd\XeIO\01T7=&2e,81KaY1-fCVA/UH2H+H+JM00UUKWD_Y)
Y<?83b;6VIE.B:,9DA?6>_<TKHcUQ70bN7V)JXM.-ZFgM/<f_E(FJ]J<MH,fI+Xe
]#(NK3T\3INKfKgIf,O6/,:LWHC.5>+R@\Ta3CADWFR@?]>9gX(-,K,1]aBdY\+d
FI+)f2<;O+C?.=^:4TS;LR[?Cb.Y#eRB@-958aP8EeX]:ACV&:b>FbQ&4M_X__Hb
ae\3>YLbH<GBLD7NQW^2;X8dWI.P)&2>UJT2A>ZC5+IXKGDf)fRT#eS<6<2O4Q,e
KdP4f0CL<?@(4<;_Y^4A/e((2L@6M2Jg@DA;DVDYWeG(61RE)M^<0[)1MTf^?TIf
W8e+VY,7\WG#a+/+HL<[FPA68;b1d/8c0ebH:]NL;2NbGO#]AgZ5dEK5B\#BWTd1
/^QXS;KI?HG]Q]:R#4>T]Jb37fDa^^GJ#8g5=O1Zb>O97L#^Ub#a0S8^F#J&d/ZQ
4Z1aS=NI2Y5)Y3,_eXX\9f)NYNNW[ga5RA572U^558[?3DBRK@Y4S-HVZL^C@R7X
VDaV<Q)]e(RVN=O7V3g>JI7(SUCRRWN^E/bYY(JF[,+5Wa0C55C)KG[WRd++I]I,
I4[/BLIV?<QC8C89F6?#:?3>GU,EB8,0D822&#3-]+Ca_#+1VL;5QW)HGg(9?YOQ
fXe9L,L6#QceM1)b=&+F5HD9g<E0TLCf4@^f.&R(H36V^4,gJ.49PKfNQYf3EW,X
4SGI)V<X1_1\<L=9)7P8MbY\:2M,GCR.CU4XR@9dJ-P/L?FOf,>5HR1=dBTP@\2\
2K)^gQ]dDVRD0+&L\,f?/1C=N1Y]JU+dG289,1/N\<c::318_Ta-7>,3RSLN1B]^
NU<J@c]-;LN8D7.]#)cFNZAgC,FBb_@C4:7eRS9RbS8+9efP+W;g,g>L6#C7?KAR
WKg558?C.T1LW(L8UDB8EP9RF#,^d<c#=#2(>,D>We,H+f2#J1:CMd;L^aVC9PbZ
-_<Q-.R91eAHXUGB:Y2BOER(:aM2d;(<Y1O7FB,30:=OEd34VYL0&<B_@<#P/KLK
_09-Z9A1T/??1\^95E0DgBMf3)g)9BO/_K>C;b/Vd[>;+ZI\ZY_WOIcHA#2#6_X4
48LOB\52U,9O5QbeIQ]0U=>Kd(a_3DEcC=:I08;:MJ_fV1FLTMc/d4KQ\E9/86][
+d=HBX0KR4HH>eR2feR8IU9^RfO5YANN@8bFY1\>J?e/ZYH0cA)_Y3P754I2.cOc
YNRU1MGDa@73.DFaN^[N=1GO.3B3[DbW[2BWd:(=P5EA,A1dCS_0>+YZ3>]1WJBB
Df;QZJI-,g>:@G>;K:J+.P?53),JE[JZ_=V?3=YeZ^fYMVOeVQP0,?JOe0T3S4EU
5@P;4+(B&0W@169Ve^@X;UWQ/XYL0[1S&7Z3Ke-c1@(QQP2?9WP\YaQ<F:YH._/(
GH>&L]EM/5#-?a2KW00eI2#A.cN1.?Z0_ERFaU1K0fOI?8KC,L9_2YK5(EX#4c/A
?IU0(Sd=(D8-Ja&8O;R)Cg;f?2LR1[<7FC>-5N9R>.\=+05/2&Y>b];X]4KC&bHf
=^f?F_@f<>OVDYI=9gBN;f]>eV^K0.:93b_,T:+LF@>_?ZM=+11,0PEO9/SdX_?e
0c5f?0@.YPIe<X1TD:QX63+NW;@](WR1A@IAZ0R5E9^VB55U:3YD^4;a_Yb>fS]0
U7e]YU_dJJJJM]Ba[9VZX67bFAI5]Y=/T&+QN73YL6OU_7E>e6DaMZ_?N&OTf;VQ
B,7Ib>RTa1IGMAY\S2T\6Z3B<VG4098=cG97\8f<:?99Y[OF8O7F-^c=X18YF[B5
@>fQdXI?NeGFVB)(08LKa+=##bNdQ<N;DTREJf+]0P<3;]L:g8H@CdD25[;[9J5-
P;08]QEHS@LIgRO8e#T@TUJ_-B[,,I/8cG)SKS-g>Xc[dSMV0-MEEYD<S_D0&/R2
\dADT>;g@:SD7;2)\(7M8U_XIE0#[K+e1P&e&CE^_E>&aa=GaW(b0b23cRR0215,
eV@B3:VdYdbaLU-.@NYC@W^\DD>a-W&HPS?\S=,-2UVS@F\&7(((50Q-;VbGWa,<
:83.VRM\D;X;<-+.(5XO[69MED#L[fGa1CC27g\01X-Zf_:=@cO<C(6]VRAX(D>?
CIENcHYU#S-Q+#LD-I6O_]gQ(;(,L&CN1E<-:V:-OXNb^90Q^;QBO_KbXA=b38@1
XAN1RD9O2WJb=DCJB&11=b-G@6S\bIWVZ0<F>N<SLM]W=W)@e9+8/3c[G(dZb-M-
K4=#D\GSHI1+[[cJ#A;KBK=,_-\V@P(fQ2=XJ@)3BRQI(<0<dLNMeY5(Hd8KYR:R
SP@0aC/2U<W/OT[\T1[5]?b,FC/_3#/H&g-XR@CC._0,SeA(_f?8YT6SW4PR@&#.
ab#1MXAEN@:a&Q4/7_VDd1LKAFfS94V;:M=RK]8>?dO;&P&?G9LPN/]\FR\L57FO
aW:]2J8NGP()PfeRSE/>,LRbD\]0eJBT#=VO.>g(+fEZKg-76LPQSZ3=\P,F_YIP
):BSCFA<B_M.KSGM=.^9d<KJcd@)PN2f,8D0@74d6Zgd,22=JFbV/2IMf6aGb?cD
/&UQ4T21/0XB-/<K,&TOgP4+NUT(BXVJ<,^2\&cK/S/H&[->?X/1O8_FXP)BXWc[
Y:F3(C<R79NX1UM)3PU0]2[63cI=7C2:M<.><ECL<,IGY&e-IH6aF^\cT:F:d\&(
I:8\B(KUX92]aaO#XEgQ-B4G-2g#?P:0,:+0[LT25H.7O_>a2=)]e]H32P#3+T)9
I./5^E:,=0C-X?ZC0d6_:;PLQ+GYQ/<Q/A\]SaV_BdFZd9I0-G5NT]S#3LDf(5)b
e=E0BLf\c(PP+J#d?LbNQC9QCF:YcVEg-#]HeaOL54QUdTDe=-@1Z_fe-8gd/EdV
)\cc1UUg1/?(FafC,38;8ST3-U\X0]HP/WaLe;9d2G3/XJL)dJ]8X+@(X?LSB<=[
K&4NSB(0Z<cEDUTU/d6-J0_>bLQWE225T,FQIR:9>CcfeT>Vg?dL(@4&559WWSX&
P(/SbcLdS#JcO+Y:AdLbHcFb\M<:#X#-1e\?ZR6)[RP_06d=AL-T0<P0(KM@Y_(M
a(UVGEF+51L-QeOg3;X:),)RU=SDeI_^90:=Ne3]H#[PC=Af+VcJ53Y1.?OQUZYX
(Eb.QMXR2+a7)BLVFIeUU@[B2@?G\@S(E1+SV,B165.(_ReWL#9RI^D.,;L.:6U6
X3M6fPe7]A8LQO.Q^b&,?=R;,f&N<#2&^8#M/W<?dYg/MI01VY\UR;8Z?<X/PU_(
WD^Q=/ZL&R;(H11CFeY,S?G.Q)Qc[>SR[+,FZ?]N3/NH70=+;IUGWgeCS;g;4Y,U
R.V&XK86.9)/8L+6)0H=W<V.Y3b5>PZQfKYJ=W3\65-eY;MY[-ICR?1P)0O+^Wea
O=#8XNCeF#2e\)BAX6<-<&[HaSf[[c5OY8Q+D2-b0R9a9?;7)QE6A2(0((7V=0aT
V7+4]DcE)GB<F0gQ^c4A:9AbQ:Q(..5U\3[ePQg&O8fY0,)W=,QQ>B/@I5f=JKC<
dCe&.fIcKBILaU_Sb-0N_QX\#ebd],;MR_C+N38OMYc?gBa.8N([@X4W9U_L68cL
9#C<=]FJ&4D>/fI;&JeGOfcZ#aSeX37KAfG?5bOA_5?13MYZZUGV2WA(CXX6S>_X
#J22Z-aagbOK-5>NL<P/L&2Jb,<Rf\,F><5dYVMJeL-I?<=;Wb.I.IW:OX#EX[7D
;#5,[dPP5L7dTSV]<d9^6g&beH6225#MS6,J:LAd-=1aU[#N12^5B]UV5[G;F15J
3Q\VP41XR01M#TgB\(;[:OY^&?H)&AOAX,?<FQZ_HPJ[Qf8gC\fOD[@[SJ/9O)A^
d/-3Y2VZ(WP?;IA3O8U_UeTE3de-\+8BYdDG&Y#1-^P88?QY_2^UIR.3TV<_4N>[
f1S0F[SEg=c;68dP@+3\+A0/]5Z#1SFa)<9GLEddPL>5@FaV30.67/,XU[2N9dL2
D^\e&]A)>18B)YY@/[<GNdPO0PKG^WLJOS?U(1+\d.@8I<(Nf6M<aO117<?0@KfW
7&U&B_>_K&>2UD[TD6+:&>P0U(:F-([Z2:6YD5HX_F-P39f9/a/P#d6POA#P[92>
P&N2B=fHBMF#YW>c661ID&TCQ1#@24dC9Q()+9D<RLEBM?,QA9U]U(,c6HYARZ--
_/51#MFF#<f1FPgLeVO,:S-^3d93G&gA-+a1O^VAYb?_H\V\ZK3RTb5/e5Y>E:#@
[c7.PSRfG1TI5LL7?92HfW7)SWGT\[S<K]g-CG[(HEf>W>[.,e-/+fW)YHK+(E[6
E2cB0ZI[/1I7BX>3+LJ2BFT@)=?5A@>R)&+]D76/?\^(49Jf-\YI@Vdab9->KD),
<ELTY55G@ZYVG1&86[]2Sf+I9-19&c&-42IW4L_[D0LE?<.aNHS3E-(3B351KEX&
cNQ<ND>c1CU_Pb\SMN=^:.?QTC3GSF/=]REE\6R12Sf\Cd3RTSg32@WaM_VG_^90
?)R2T6KA^a/gMT:a;)YTW^N04LY)L.LP=,F#MZ3M+JW+bL;,,0KTI#aODa[OL;?T
S+._.UI^C^;,?=:Wb]JWNX,D67C3K-M-Be^U@Dfd2\&[dDXK#f]\IJ5+UH;3_WIc
(VX&8)2]^)e;8JbfSRa@O==Jce?/E0^-O).4[E][/:ICU3F?4H^D/:44=8/W.]Dd
8Xe>PeI79e6KJ@G0C0g1__&YFC7VIH3F_\X3TJ^JbKRH?@/RZ][TU-C<b,QI^1A0
VHf0\LT4QfFZ\<_b^PSS;5)\F]P3FL(d5DT3ZI?0Q<;P:5B)+eYBG(Af^9:9TYFI
-]T3g\Z7bJdVSD=_Ud6D=?&9E3YgA&/LVC+H<._<\,9^aC)XcRc6#L_O_XXeOG4]
ZA4DP@e=Q3f)5Q-/U?1CV(/6SDZEAXOK0DLXg;P;7H5V)D<b@C7ANC\a-/D]=a68
Ede/9>HEF7=Ob?:5/K5DQL7M7>;1Ba\+B^.;Q<&.OB?>I&@PT(U01G-T6-A7d./.
U#FI[4,?_/(C1U[/>afZZ;V+O1(_@:>0J>E#BfcI5J?b0;VV/e-(M;P?dAge]S^S
NC0H&7E#:3Qe-K@0ZG<e\Ld=>5T@b4b9#UTN8<(eXW,<X@0?:WSF95QZ[N2M<g5_
/QU)1]g+>3/7>O+NUe0OAO)]D-R5SQe\fF]GC]LaRcC;=a<?Qb1e.:,FE]43-259
,=(eOa;Q\Z,DEF6UCO7e_cR+4OLC9UP\305(W5]fDAY#P3C;b.+Ld0Kb-e[:J2FI
L[MbJ37],EgC\V/d(T/2EFNNCW>SD#?J2e6/23\NYDYYXbJgCC6Gdc8b&;fd@a]X
bK1=a-GO22>E01.@abZK?V\D,NJbR=bMSM[Q1f#<<IK4;1\H5M[^cTMCZZUPUQgN
e>P/KS4.-N>5e.ddV=c4;K&8([eRb;(-X.b4dQ\)-Tg9?@OK3DP.=eYfg6\EV7Ze
_VH4SdgJ48bMKUTYd+NEdEaG)G-PAPGIHG\d?>N8c)d.V:CH],cZ)[\SGcFWEBS,
-F4=f,;4AFLE=gKI1;M_8]Gc554:83WR@;+[fSB204[c86>gW@UQ?/fcH_X.EC;8
dc+MbCF/;ER<[)?/N6J4dIA=GC1#f@S#F+Q4,:FI+NP3-1fFJ:U)XUBX)TM/4E]J
-1LW.S&:Y[9><c#SF6>8I@,CZJDFMYS7\H/E4<OFSWTHLA(eK&GR?PF2<7<G3Z9G
?_D)8V\Rf830SPbIC8<#B<[?^]EUCTHc3E4ZCH?;-?aa&YJ5NV;M?e(I()CO0V32
>(Z.eUab&1@BcSD:\S-Z?1J0;TZb8F?L#Q7VZ:\\.0M&M-;J-VV-,+<2=LW]/WH)
IJ-+(X[S+_GM(Q7XY@SV<S=^N]TX,bL5^RbIX0OPZ60,/.Vg(.<ZT_]P-fS/4>K:
;dGVY-eQ1GN71]1=2:c<W>2&fWC49:\OLKg<&;OQ(3X6OKX0bg.OWTa]9UWWWB5F
P@DdNeF?Y]eSG6UD(Y#N\E-_F.>)?VN]Af.6-G[cJ.[IG]/4Oc3]:4]<I1I7IU<D
@=_2Ve7bRI;5P[#++I(+eQ;8#E7V.b>d)Vg?)E<aVfXa.Tdg1T.ZfC113H0;\7bL
#1/TPEfOaNIc6@XaDPR/a./d?Q1-)E(&eCL.=B_QJ;WTgGDVXX;&d#OK\Oa2D&]V
GT,a9\ZN4c<N=7C_D4CK]TE:[Od4DV2Xda(V=Q<C>a^YS:]=XI_-CKZC+#Y&WBda
/H;SNPL]K@.U-O7[>Z[Z3RR8fUg]UC-,O.a]#:BP_3;MN00W)Iecf6;<3=ZB-0TJ
AQQ?6GVN^00[6d@#VB8>4;BQ-R]-J9gcX.=#B1g72-<OfA=>\8(UIcB_4<U9G0PM
Ja<_0S.bVf[FcOcR.GRK7W:a#:K<F3gHG+e+e\UJ>7LKd.16))IC/2a)IFe@OX=H
28ZRB4283;LL+0S@_dX<6&a^YS2W0U32WDZ?ea+JC08e2WCSfI.#7#KO^Z-FP:I;
gC+d;Oa.HS-#H1O^ZC@F-?L<ZQ^#+aNNV#>K:[6RV8\2dWSg]9&4&,_5bf2gXM]2
>fS@6MXZ6Z#1YNDa1O>).DNSa;c/KDF)1[CgFZLcdDCER??.Z:LBQUBBZK&dK)Z;
a&I=f)W?JHbDB-IOD=NZO=KD-(7MPGZR+;_7#<3>A?b2>12;a24HcBV&2[3FB_I9
1>.+K=c)W^8g#;RCEe7#,,0SbG954e@^f)<d\DHS<F+F^Y8C@Wagb4b]7H4XAA=S
gPYU0YUaERE;69(V-)_YgZD.&I+0#b:92RC@&Re99b5-W.>S18G,L:d@fD-5,0L3
2V0Q-.XZb49@+8@M5fbP?e>?752WCR@<0Q&aK,W8\Z;eF)O,A32Wb-;8VU=4^Y^:
I)3^(?]Z(+E8W7I>/^bI(WQWM&>GH2@fe58@aX0S(b(e)B@c5;JTfOA;)#Z\OEEP
_L(]eNK)BS(?S7FN<Kd4/_VRI=F?MXI\?K#REW)097_.eNg<U4(@N^0CX]6.+VTG
33:V:68(S[1@5H4N8>fM>D=PBbZM29FTOK+Z6a2UOE7L8P+8aF?S2RNO9,1>@_S0
F464e;1&?=?@X<c59QR58_KW;@MWc@7.Kc?_:daE1CO#-WWIJ?ZM6Z/C-5(C/T83
@K[/Lg)ePY)XXKRI/1J?Z\N1689E<ECOC&-)U2<Fa]0A?TIMT_HKQC_+4BIJQZ[V
N6B;0+3Sd6@5J=fbXgKT4=90YZ.@Y)K/;=<c<EFD<dMHF@K9:)IM28N8#RfTGTeX
c7Y@9_YCX?VM]W/Xc6J-V\e:RV.(^f-2gI\B8c=Q7e5T3YFDX><VHROM.0_IX64U
L<@?#VgBCL8G;>+D/ZI&O#<H&>TT/UBcH;HE6L76b\<2Vff@)<)@g5L\2aFcWNU<
:VCPCSY2C27>,MR?XG;N,/>AdS]SQ#cZEcbdRS6;S<PF8GD[D4V_8W2QP5&?FaZa
4P1HTNLCGHJ+0RfWAc+RUG+CJ&BN]OE8_96WeQUM@X1Cg?eHe@M:3BN;4K,IDLY0
8M8AaL>Q)37-PZ^A[\9A1b8fWAC06e4?:H+8,XNM/<WE[8DB,a[?c]_)4]DPZ8&6
)FK7JIGB<:YISR7#9H?5W157<9#,(^#AGI4SdK^N[Q8XER<Q^^_(a9GP(XO1<Bd7
Mg5ZTTa;/X>K1T&4RKLQ;d_W)O#(3;80(X^;8@#c,?<L#Q:a7>G.BG,Z^)BC;gQ4
Y4CL(Te0E<:2?OM)@eIOgS-6GU_=_Q#EE0LVRG1P&KJ8.>CYZ\GDR;<R8_M2GA:8
JS-APVF.[20e]GN;b0Y4=]B;,,2=g(\K;\YVe7TLQ7VQZ;00,DL/KVM,GbZC&A18
,&E2J+?-dd<YM3Z0@@A5[TM]=7D==IC3]X<YMCd#Y4U6aI\JMCW6a0b]H&]LO/bR
>=RZd7e4f/;8]-(_<1?01A)P7YgB5Vd-JZTC:^/+<K^ZJP2W[f6KRY<7)8IFPV9W
E>e_UMb9ea=,-7L6W.8[>8?66ABf.?1da&c.<:R-M-2P[)O>0ZHO.K(MN/4\>ZME
H_-ZFW[0?O@U>Q[Eb+OV/]/a.[;BHD5EDbO7\>LZ[QB^b<.aA0&/UGKg1J)/(V:?
VH\E>2]V73T?LF:Ugg43]J^]\M,a=M_Fd=Y@GL4a;AZW4BZW7QR6KB_&f;NAAX,Y
[7/HTG-QNTWaB/P_cN#IOA(g+40L8#8.\[2B-_W+V4fC\\36X:cOK550;@CRW(f+
f4J4O]5GE-K]ZF?4&J@P0(Y#:D)3Y9Z0F4;N@RUccSTb9aA9a^-EQ]d1@1LXQ6MC
<A?/GeOg_9-LW98C(6cGA#?[3R^3aZ[,RP>5;L6a;;a2Lb7Z@e&DI0KIUg7T^/N)
WY;#JaD^EO7aSH8ZYc]9dFbd44=P,(//dU>G/7+/?5E4[:C+DZbW?5K5)9O2Z[;L
Gd3>_41NH\MTWU0)SeFA[eU](d-15^ICAO>LMBX+^d9#\^,7>TE;5Ob+fNBD(7ET
LRc[)/,gTDd6c,U0e2C92\G0d2)0Gg_7MfPEZSJUXXW3=L]VC@>Z#M_@>_c;V\)Z
Ffa00O1U5HT-/\Hg?f+LMUF72+]KRT@5/[.X:W)CB8&JLBMbB:<US.[+TLIfZ4+2
#g_VO2[Z6[)[c,LN/9e2XLSNZb1b&b\<1e?TH9dB:4ENJf:L4Ggc,IeZG7-IRW^B
?dK_513REcUB<LN_;#g8<^+fYDDL((8eW/&]]\P;7@eDe9;3ZG\c\):RVK;aBa.:
Pf=L+S#QAc>RaFC+B-JdD(D&7A-4)MMEEdgRKTA(4[g9E4S5<MW6>(;&11/NO)1,
T/^5Id::aS.C;+3J_O^GV^E=DA9\3OPL7N\0HCL?3FA@VJ^>R]@[19f6/VB7_;4b
XK\=X#=>ZJ>\aU)5DT^.9Q8UI-?ZFKHWRgEZGN#U2#SZ\94=QH]6,LKT);81R:OS
?#f5F1]c+006(eB1g8.5HEfID2C>8PS@VZS>Y/TR#8V]+S3P51cK#I\f6<C1#[O@
_..A9fS8V=E#4OIJeYB#.f(1/(:c93,^SI/?VQ9<gG_V7-6:@D79Zd]fS9^\;[d=
#.gMT8J^YS:/_R2U+;/RG?5/WQOSTZ9;60CH^92Jd@UK/JbV6V<S.R.I\X2P_5bb
OCGeD:<^TF,Q_MQAF#[<J(D,+6[[4g/5RL]bVFab]9OaY<]#97DICUS>I0#U?YQ=
fD^WPa::af#5,NOeQ8]BbAX6;+F/Dba[W&]T>(=4YMg,<B\]4J9X-#aDNS5,Y(PZ
W>>JH^dSQa\PZ930J@JEWAG1TE3R?1RW[1eU7?Af[Ec82Qd@a5]9,5/XE[cLcD#G
T3a,E5e:TH<HQKK2OFP#REG>/N.V^7M@C@;C.79SE,WP-<RMF_>:2WG6F8B=G3@R
KSY0Y;>.[HS?FLL)4+J#3DfF@751(_M3>6F;6OIb]1cYSeU63:[4\Oc3e;d@NcWI
3R7HFJ[F0/@KEZT:K)NEY7QbC4MG_b+A50F8_BA.T+Z>ADHXeW[_E^gAZ4=;ME_J
).C@)H.PE4FMe/cKKUVBIS?Dd7C6]g=-/[0+B&K1EE6db=PKMd+Ha9]I\;/W0K+(
;TDWW04MSA&<cf?Q.8>QUcI?@?4YJ9e8T5D&X/=WE7&A^UX9B2VQ32Ua5\gEO;+-
T:NgW#TPH\a<8-BOMRDLda5Sc3&9PHf@1Ua?+B3>]IFY8[-+@Q>egX]ST1FWUO;7
LZ_H_+^0_cE:KF^.BdgH/.gU(W_@cg3M0OKD?ecN.:;[efC05.g\LROeEKggE>8=
#P&5V#ND?M46QHcF4(44)V)IcL5cV0G3E#6G=g5IgYD@Ed./28M37;Z(<?7g:_GJ
@AS-366eYV88PPB@cYB2BEYXK:[EXGE^^T^5K-\O&dJVI9JL.5XU>b4bgFUW2//6
GHJX(HJ70[?VM->=U[++KcVgfJ5e;Zda3V.KDb3&Ic2=NKB<YIM]QM2?[8.;PPcg
&Dg,#gdV[CfZ6^#.[_]g&dZTHN(8EZZaWL)X&CR309PfD?fP@K7O22@#LO9,bV=[
\:J0-YLK#2B?UZ5ceW;CR0#.gFS&_5SH7RE+#DMMIDI-)^2]&6&<ABO4_IJJ9_#@
dXKQ.)2;8cC1-OE[]=D8S>)1+)/g[UGb)H37VB_cLL-@AD69:LU7Y12F,4UK0S9#
@8&TGGR#WHV(3S5e5)XXLG]#dOLeQ)I=OcU\##&fE\V8<c@:+MEga#L.2.&GB6^[
TF2a](&GUfQ^&</Oac]6QB3eGT(1g6NG50Wb5,JY:WA,L4I,--BR,FO>;9:B(L,/
(?LDcPR>70D1;F+KXc>ZRZ&@7DM.=L=:g[KHM?\-_a7]c_VMV>VY/Zb0]Y6+RHNC
([UNWMBS2?M\K?4(-bC#)&P+-WM1)U(HdXDA?>f;SAH7<X#9&Cf34-3Ca[bG5\8U
NF?>M@5V);Vd/]EfACM#W3eEdF3_NJOZ5V,@@7eK&1#UU1BZXFBB<]^a[P:I[dDZ
#EOV7-11?W7I8C3?<+VX?KdgI1<JGTNg&WK8FPSQ:C3L+VRaYSU,Cb1YAXW(,&2T
(HI_2AQROWD-K\5YLA3:&7/+(\AaYC.De[d3-69GI3EBTL\bUMM?9J5HW>P+3BcU
-E60M/a&XMSS0<&TTRC74b7D+Qe>MaTOgN&/)S9N1@1;b,eDKU)+IO5HK$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_SV
