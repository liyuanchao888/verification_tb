
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SV
  `define GUARD_SVT_AHB_SLAVE_MONITOR_SV

// =============================================================================
/**
 * This class is VMM Transactor that implements AHB Slave monitor transactor.
 */
typedef class svt_ahb_slave_monitor_callback;
  
class svt_ahb_slave_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port that makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) item_observed_port;
  
  /** Analysis port that broadcasts response requests to the slave response 
   *  generator #svt_ahb_slave_response_gen
   */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) response_request_port;

  
  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  /** @cond PRIVATE */   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Common features of AHB Slave components */
  protected svt_ahb_slave_common common;
  
  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;

  /** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;
    
  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

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
  extern function new(svt_ahb_slave_configuration cfg, vmm_object parent = null);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Stops performance monitoring */
  extern virtual protected task shutdown_ph();

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  
  /** @cond PRIVATE */
  extern virtual protected task reset_ph();  
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
  
  /** Method to set common */
  extern virtual function void set_common(svt_ahb_slave_common common);

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

  //---------------------------------------------------------------------------
  /**
   * Called when hready_in needs to be sampled.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
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
   * `vmm_callbacks macro.
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
   * `vmm_callbacks macro. Overriding implementations in extended classes must
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
   * `vmm_callbacks macro. Overriding implementations in extended classes must
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
   * `vmm_callbacks macro. Overriding implementations in extended classes must
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
   * `vmm_callbacks macro. Overriding implementations in extended classes must
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
   * Called when hready_in needs to be sampled. 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the sink_response_request_xact method needed for #response_request_imp.
   * This sink_response_request_xact method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the sink_response_request_xact method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   */
  extern task sink_response_request_xact();
  /** @endcond */
  
//vcs_lic_vip_protect
  `protected
?SYQ>eP^/KB1]O5a[V.bA#2Paa;H9MZW0F?;BSO2PB;F,<Y^+ME96(Ac=f0(c_g2
@A0A04H&?b6:gL>T@+1e1Z++JPI]OCAZMSXZN],]I=Pa).SLPSZ(9?V8E;8.D.ST
,?P.MK4AODVN_;c.@BV@OO-/&;-]:GG1N>@,<G61+YHR18R8FO@(89YU/b?;Z(af
O=W6[>.;HDe?_)UO#S^O95Q@6F6]=Lc^E(c19bU((YTE_)@QW1+R2]C8A3>bffe^
0VZD-LE-b,)#==\1UcD=ARQM9P_f+(-V<;)fI7,M@QGED$
`endprotected


endclass

`protected
=N-]c-BGXN[NC(M5A1gD^Y6MZ72?3e5X#_2#3#&_P)2LFb5(aR0^2)2S?H;QLc-_
PK+V88NP7aL(B28-1NUe5EOcd@[/9--[:+Z)?T(7>ZdA-@e&YdbI;B9UMc?;B_L=
]_3V,-P>C:Aaa/fZZNN.bES(?0HF5A=aE,9KR@7UR=[VE(/ae-DcGOD0[bE>Fc)<
NaA^[W=T.b.&SETRRCf_:V.W?E-MG/dN-ae0=6X:?(Z/HD?F;(RfS#^.c;4X>?+]
&CEX1G3f--e-\8KbMcQ@]W4,TE-JGB2>]LCR7KIHI&<;R.65e)gP_JgS\Z+d7FXb
PRF7Y<Qb7=3aW0\=N.R:SSHf#]>_U^0WHa?f>6,eH)[;)\<+SY.eW-,P38GH>+AF
e/RP14AKc1B>I7D-48L\YR::0UNE+IMP]CfSDQF#PL:M/>#/5HKIaE9]7H:D1bT0
BY\;[(FKI#/dE076Ba<b4bff&?(f;1A@IJ:WUgY/YcXYW]?+N.S5YGLSEW+TBZMe
P#VU8<.U1Kgd:>4QQGOH?.d\H5GYW4a3K_,\D)488)K./NXd?BC_X?#G\aegS_Ra
(WE40;ZR#PK5DDb:7b+\A]?R?5[^a#Ld8GDSY_5\-N#S;Qf,Fg7a2@,>d0TK#eR&
]2K&>5,b\b[?5O9M:_KH-W,(A,X2L;(UC8e2E?8[B#?T^X+NQZYGEEAA,]ZD&QO0
OLV=WN<_@6)<fSK&XRdV+MT_NOY^g\Y.&7[e7g94,5b35T-JC(MMJ912&YPWVBH8
.(-a]H4NU,U8XNFUR^]L#K]#28,.4;Qc2,]:LSS5RTFPeadM97fRR:+;Z4H2LQXX
_S4gdPO(>TS0)VdY^Z4a:e304<41PgQPRA+[PX=X>fMdH;H^7d34-2D]4T0,Y:Ia
+cVVB&[+UD-)R:>V28TZJ&4HD:3W64\f#Pe\H]:Q_f5D;4[KE#ceN\OX;P6()8NY
HN]>)N7&RI\0-Y:?1S54(J3[3@N;/Q+]<S#6RHDM.;NU-J.R]U?VS-gEXGO\M4RY
](6]U0)S7L/Eae=+M?HfZ9FKa\Z3#9F&_9OZeR)W95ADE+RH+[^F^cK)1D\A2@L2
G7949aN?5b6_,D@/+_5^M2&1:&dHU)N9OTaFJ\4<Ld.[?XZE/c3J._#SE2<DX5GN
f\4VfKN1S_[3?8AFQVT6G:JcgKUeU_#L?4GKW6-d(ADM4JU9DHG[TS_WZ4ANR:FB
5a64.&_6STPIEc,dB0,RAAgK#C0cg@9bLdOf_2Q0d[^M^U;230N:M@K=Gg35E/LJ
YB2VQ1H<FYNU_5GTE>C.QaRT7MQ(cbc<Yc;9-2BKB\0,8,5Web)ae_THaKH?T\-P
SBSMF2K.5fI0Q#aaSJ4;YLGc:0bCF<5Ge(_>&2;];)=<4(N:KRW[Fc9?g1H2cPZ&
.,NE).HKbYL[@@C(Zd\@L;[96fS5MAMf3bQ>5F5V^F,?7^<>Pc3XPR+:R>B\A]F<
C]-70[1b<P8a]>8>#LEa&I=L\0Y0.AP?Mfa+T#Tc:dD<2?42D5e#<YJ,[\e;1G#)
UD.FI,&dL-<cMVH-U&)ECZN2ZVdK+Q3,g<AKKHH>+#8W2P2=/BbG3VVQ[>1?FU7^
,bNB7]U+OfGRW2033fQ2+UQ[(8+BXE+SFK61Zefg+IJX0WWC+Dcgg/M_BCX]FH)4
70/OK?B)@9,g?>+@R31T7^@ggN@CA9#g>$
`endprotected

//vcs_lic_vip_protect
  `protected
JY6-=0\PKd4>OHf?N?g_?.E=6:2H.@ERC+ee7U_)^JELf78+Nb#Q7(>P5DUP[:\-
]C2X_?/.@-J5A5B]+adeb=WC<&fcZ.DbZONIC:;SR4IK,V_bM:Y7Sb)Sd\gP]&5B
-NQ?KZO8WO.Y-T23_5DA1F4XEZcRb#/5P>BJdS9a4FB)SL.eOQ5GIPP^+TFdF2#Y
;2\WfT@Cg6ad./XaAT;L_?Q@+L?WU)c#?OY2RP;2V8g0(_J\X.9Y8#dRZK&?/)6b
T6L26^],?W?)K>O,Y3b?.5_MN0a-:SD&3(^g-TG/BH&R_0G-^I^O;0]@:I32X6f0
FgYO6C;K6@1I_@cBKJ-f/7ICc4g>9g+ZB6R@Z-?>5C(KYgVFcXEI+S/<J/1e(6dS
U9;SW.O[X9FFK[BCb-ad0-6VJ5QMa(M.T889cA5ZLaNJXVDT<T?1IF@G.SO_JSW]
P8aOD=.8OMK:-@<=d#P(EL?H&bLL5:^NR9?27(J16ETQ8)TXg4^CPJQ(-=BGN8(a
6g-JCNJ<EIHL-#UP>f,1AM5^ZeZKG:[2:Z>4/[QZQWfP==[>OE-c?CSXMd7+YC1B
+38++c+F/OT@#&_;X^.&@^ZUZS&:4R5^_,b_743B^VaZ:<DW]Q-PgCMHYO,VZE6.
TZ&6CcSBGY&,B4CUO[AC_B_W:cfO=H7DI)T#71HZa&:3U&;Ic>Re76A>-aRfST/1
/1CQMY,2P0aaIEV:K)^#OW8=>^39@2F1]R0^M)dD?RVfcT+cKG@U\bT<[M^=[A,T
[/_b=D.dfPcc49BKW:A;XEb</NA)#5b4UMN7+131V,.EQg4b-bF6R]^9M)/E=b@Z
^?ND3XHF&M7YV?dQKT;PKI+GAbOU^?OL]^,^2/UY+aP)CL_1&M+ec0Of#__9Z,_\
G:NLB21c9_e7A=H6ZO#VX?1&6EIG?f]MIRNYd?S_(>14bK+TM@c.;9V2O9)/K^Vg
7R,R.9/Rb9RX@K5]&J8;b,OGO3]V7&:[Q<.X\b+^8GG#+,632PEI/XP^B=A(?88Z
0/4fS)K^eFSV@J?[>3fY?J)9P8,a^80/?TRB<b(AB?,YA5324X;U.11f>SCDgB?f
E2.SB/Kc,)Y2)0:X5M9gEUO2/,LUDUL#I,PSHaO6W]JgH]2\egdcO<<FTW7^@f^?
HY6_S&.T^dgb1I(R9_IDSGD[@IdO_R^g0cT\^?4+9.@&](?NWIb5>b/GV3S<]RWS
?P8L:Pf\#_W@e&340bM[YE;bTIH-BFIMZ.?G2[3_D:EHMT47=+KHK60IX08b6g-f
ZUf?512:aX0,COa<F0C\02SWLa;YE)@N4ZIT_5cT/B1OAHU/:0UJ+CC^07QC.e[e
=a:F[-[d-QM6[F7FgW_TQ5-3W#&AH>//Ra_R=PJY<R_S^GW8[B7#V)9FKMD@Q0M\
2FH6&B42,_8TP0/Z[)?2b06_b>[7f9?6dGGgWE;bQ8aN9Q=8^0FN\CF4^P3;T/F:
_\-?LW[+CMR^ZA5gR1X@A#XA_MG<He7Ka6OUV[7=@+,V;QDLX?GeE.5>Yf[>UH&_
PT-D\cA?)=;NaL,/TZ<+?6P<,KOC;HZ20X6065Y+4]Q>\M&cf\/.B;CLSe6,VV^J
.C>7fd,WN__0D78D@Z]\SRb(J970G+f4?bdD4-;[6TQ(dTL4bD,MLXQV-1012BFa
HcYC[,D?PF&HRGQ]Qa0a(@[a9J-<ORWUEJf/=U.PEa\Zbe(aINdTe:1AG:W8PQZU
85#J2@BWM)IOF7)QW)MS<M]9]0D?;YK(O\+LJ3H\OfJHMKFYg_B42PQ;g9#XDa05
/eL,<aH.9?([P]V6Q@ZT8ULOIU7O/WR)bBTe#)Rc???b&Y+YcYaM)T/dWffNLF0g
:\N37=E<dTeP8-06b5^;N7OfR#If<P-&(S8Ha>6STSJU7&I)^E;F0:WF>,Q(Zg)F
NX6CU_X9/\U8d4H9KPUbS4Ug_\E8(QDfP/f=W+MIKFY20/:]>6Wf.Uf4^a#[4C5W
GN@/<4^9]ZZJ)NS/Oe^<G9GTCBE#YFPc78^b[ffb(CT_S^06bZ7[&X=QF-8E38V+
Gd)0)84XY+3&c0WYRDPA]Qf+3>H\]8?FVQSf73([aQTNZ]Y[+>P_,FGN<\6.RMa8
.\?(.?_,e(,Y5/e3]-]aV9@7Y+:_X(OXM-\Z@^;YS_9T?FRNI/a6)J0G]^A.(JBd
;BfQJCd4H)<\9[9ReO/L7.A_Q/276R4H0+92_3[(<GA8@a\VP4^/1H[6@0,SbP\D
#<Z^c,3&\e:#)#CGG)3>:fR]-\fZd7^X;6gT0JG7/0+7V\\JPS<(>_A/\OfO_&c.
]Mg,1UbNPMX&U)?.SP))GYJf]#>R@]?Z-&B9^O@OE\;IHa[=R&G[6_/eYQT.+:[-
@6]gBG>=WPJ4S0BI#H,KPDaIaKM(:K]c)EA9R+g.J,;WT>E]3KM4_M3O2APD/>]@
1e(&>#Q?ba<F47cY<((@BT)BT1=X1KFGeA8XQT-=_feI)U?Z2,R+T^C3H:YP,U87
L-7DXQfB0BWR_M5B4GW&Xb6L.T5e@^3FT^P+ZE7?M&.cdGKAEfZ6M9EJ2JX2O1J_
XC:J];VVZQCI(gB0f0Sc-1>,WU/VCFKH>C@Gf&AX(aO(E4.5INUROC6a0D6TWag(
+-/3P_84af1@[dP<NaU:H._>#c6GAN5.0U=Y2IR@EJHGeL\,P9)Q@A:_Pe5E/772
A>2^LZ[2_]=+6:TdXeY<a#eWD?DdZDV/KF@R:fE^M4f=Z0cZ1eP)Oe1eMI.Q=VP+
bB>?S)D&HUR61A8]ZX-\1J^Z\WfGB#CcGWFRQ)2T@F>Af5B1c82:AGO/)g>W?+?2
.H[_F,OM1M(A43^\N:RAFM&Ee^>I&>B,0V9&-f,6aI2GSD.B:<SPQSY,fCC^I[EL
2=f9I#Hg(UF4_ZWX-F0HE,TTc]Cc=Q_WA+1L6A=)V7#eKTW+\W^22V-FIRbQe-?L
HGU>OJ.8E&,c<0[TJ^)d=ZKQKYAJ6MKS(\Q=2Yda/05:+_:2+0dAfA0J)+c_Q;AV
(>Vf)10-57?S:(XI[TL&AR94U/9HB-/2;QI?;G/d-[eE8&bKW45DG34@AcV:G0(Q
f+4UU\3-+3d-2(H:bSKJ&?RSe7;#a6\NMB@S?J^0C,07N/E&V@VQ84USg)UO566T
Y.+Z+/.=)<]Y<.^UX=#d_1(bc&PWE9)ZFZ@1Y0>SBBLdE7Rd3g<UQT<BI?c)^6:K
I/Rcb_/_W-]D&XJ@]2[0e:YLTa\+UT2/N3fS_\1@K[D>))6+5D3Qc:NaLb=8/0&1
c&BJU=<gYA7N[&6<ULfICZ[8&B[aTK3BFHDgJU>YG=8VOfLFYG=UDG4;P]dV;f81
-ScS4e+CC>VH5H=CM1U+c2d6VAb3J01G_>MXBg5a)5N0EJ1Q[LMR\\)]ARb)(3(N
OH4ME33;C1K#/R/8GS-1T1N;c>;LMdB/,cADZSb828NZRHK8&d7MI5[bI1F;\>.I
P:WFg^8#UP+96<3;f+9SfNO&DSK#R\-40.5.9VP3bZ);Y5efO>?^PF2-NF);..6A
a#;YR.R^Z?#7KS,F/(P[(&PBM(gY6&X]TDS?.,+TK+3FBZ=BGJ+\C[cb/SO):Z+a
Oc\^^(SNe1[9Q8PO?^dYQ/F6,BZ.85?+DXK/W0\S>=&#DUKdW,R?7].@MDBD9?[D
3<70LC8]cV+N>_(fC,d;]U,D^[Q1,FLJ2dZX;FZ<LH7/gN;52(@??D::&[K_Cfe>
PHS.E_(9EZH[\dC+R4@D8B.?3ZFHHOHOER^TcK>1@ALW76:.+3f3QT=G.J4CCXU7
,A/_T\[K=[3>,E/>VE=V/E_&]FfZBOU#aH(9(_25MFE)FGC=TZI+:_N)SVRBA1U)
T8:J[AH>cCHUf+/:V>/<:0/ceF#K@)=Y_K07[S4:P4#(=\N<cE7F>SdO[SeLV&g>
0VYVQ51.+M.NgL:6E9VYfFQC@<AcIO>H5J?1f4d[+J-gf&5Oce?_M_eQ879WW.2W
EZf45Z_IM1E[6KbQ5OT^=)fU1c&),.Qdb<Q_K1NVZWJ_HQd;g+DXCTRMNX6I.Y@9
S;=67eK,1@>dc#9EBc]+#I3&Y2U\5/5>:>&WP-J(8Ib7)B0OT7D/a]0KNVSdcN/A
_\b^9(0@L=?397I:eAP6eEEJ+?2L2,T:-F=--^;E>fK:S(M>c?.IUL?67a:?(3]9
g(_-QdQZ]g1W\.\4J;6eP/0)de4&426?CDETCgT6Y+;Z6_X4:7OI[+PZE8\@c^?Z
d([B=YLa[1#GQ]8/P7KM@H)J_NXVN&KSKbbZ4Y]eJSc/_gc40f7.<8)PU&CS6UV@
-R-aX5[_FcPV8XgNeC66?fU^^TbU\M.OCSd[IWRA,<#17XJa8Kf\d6-=9Ec07SP8
(E:T^@P_XPg-H(1_<fdPTf5HAC?B1BD58?T@VN_E?(6/@.C257DOA@+6]SWG#g)M
H@:a8I.f?RReNEENaa(^_QJd:L\Ug3BG5Be^[,;+K6aR5Z/;L&40?2PAeL@8AK]^
U/;N_]ORTJ/8b#=DM((7X&QJD-9K<773.9MLU)cc_MFBFf_0^?QIT:\&\,2g0V(P
KNc:D+835Ofc-)=R>O-#]>@_N:4B24#WL<F2=X]KK1(eRefK(?SeZ_I?]J_dfR>g
bGI.8;ga-_-#S_-F][A+,GCJ[6PR/)V7LSTZ>\JN#AfD,]RCg18AUb4XEf#/c_51
/(UTVG:(eQa]<dd3UF]@UZL1FZ,ZIeS9VIT(>A&G_bFgRFXAcQKUJQ0+7AV2;Z/K
)Eb3^8)-g)4Kd95C3HFZH:@S8./NXJ?_Z1P2JUKSA5@==W:?46T45CVK(6Q<P0I=
+LC(Z^g/[M(,J1N7/e\B(<M]7X24N2)8fEFR2&1E=[&bc<:f6LF[9Z\H<7^U1+NN
g_SWN?_(QKM2?UN5#17+,TPS=\Q@&+f9bNP7KE/P^;S2VX9@M/-&AV@E?C_7OC,b
LFH)gZGbGQ8<C0./T^WG^LcS>+Z_5;XdK(5VA1C4;T?eVW-3<C[aZ-JQVQbH[P)V
2]@44;=<7FO=Z?UbV.1Se3M^Vd@8,V;69=)#O[S:NF^a3/d(=(H2]AaU2F5GFGT&
JOec(8FADe;<Y<K[Y^<N;/Z369/P[]aCGLWe6c^O4/G_bW_GQUfVMP+K=4fH0C8U
\6P]&+?])(+.R(C@)+WG1)^?)1&CB(RLEfSKKRIZS&/\^0D>\Z.ARBcCZa3FZYEb
^cD=\JNJg,F>/[bZU7QO0O,.PXH:2YR1Kc\9;UJ6[Pa?LXT4Mf^=eK1,;^2MN\XH
?c0+R?FgVN(eS7KWDJ^FC?g>(/NWU:>UTRf4=cU]H)78J#\+ZQE&I]]RX4a_1XAE
/UDg)c<313>N3TBg+-dVJXV6[LD]3-RD]IeJ438,d_0:Z<g0S#dK-U.C(NURT1.(
,H5.)XH;:_fWMDW5M3#>\Q\8#76X\TX1B8=8)XK<:7.74\)K0UbS7,cO0:BRK:;6
(c]\[g/4JE/W612Gc&D7g,e)e8P>W_KJQ//2<6TfMB?Q\>_@P-T;Z-#IZ&<f>4LZ
/V9MBW4Q46?P&UJC.QJ&LOOZ(HR-GN_W3RX;5F.YO;S65f#^a8/E6gPA]<a/P/R5
:>RUXeVMc:gR/LEHL&P2.1@?NXP8T&ATC#eZ9#-3O=:BLeIfLC06[bcOJGZ\32R.
@CQCSSMWd/T+]O=<38?8Q6b@,9R-C0LMA?M28B]XM&A=]E<:A;e(,/SMT7M(&4?#
Q/OJ15X\WEd0cagC5<,_]cYDeLB3S8TeQ:UU2)D-8M#3]Y6-)[]BWcgINAZF6PG6
ZdTc(B^>VCUVB#a[5HUBNg-2=Gc/H=AACHg4F/LR93))X\1;a^@BJdMdA\A4JAT1
SSJQ0JYfNcVGZADN,^<A[GK@-_\c-YdBQH<F45b>D2O/Q#/BZOZS/#A7Q>WfU5.6
?e3Z#4ABb^TAYa4b]&e<]@U#MR=4/?7>@#(bTGXZ(S[_?U4B1+AO9c34<C]/aF80
?WFTTT,^4J/QKKdUK-G(KdE-1BeEB_RP7fVd30de2X>_0d.6O>(>RUfcQAV#6/2f
U9b5/BW3+)&bQ?aZ=56]_6-a0I]g>AW;R[a4179bg&7#S^aCQEbQb_C#R;dUOaLd
X&\f8Dd582cF9BPaK/EdABZWf;,.J6XFE7/#NUZfZ#TT-PRJ84L#I+<RCfC4]F+-
YS?>@^;WT=4PP[?E?26^=]cUQIId#3AHdAH<J,T>e+3F#RO:IaVMKDJW+K&I23;@
H:YU-+1BSQSMO1@E67O/Q#&CKK64F7X/6a1L&E?H>.LH@MBX]HJO1UD@RNS_WMK>
_BZ;Le)OR9H7@GXgPXJUO7cP0O-=[2,e(c&??=QbLbJ1UPN<caBZ:DIU=_H7GCd,
c+6A,N^S93B@4H#d3#.OR9D+T<4:SaHc?(>1UG>FE\dXLcSR/C\Ne\11fQ_Q@8eT
I#.=Z/>DMN1^WDCB]5Kf,SPP0+aZBEQOQ,>e#TK(S)bTK6G]SW84Q8RY8</b6]TI
?G.LVW[T5611YSFQUU?#e4cdV&HC4RM(@bLW4TZQG7-QR]WHHWWK7ODG>\@:=-.H
P/HH3g;QIRQ^5=/QLd2Ab[O];P+&DE5CgWAI;.@J^^GAIS/D3#OI1DTTMY7C+R8C
G9^W:PVBeA5.Z4&eRd<)B.=dHU9_Ug(B2P[KOX8P^)&-7,SL&R7,/#Ma8cdEO11#
HBH_OMX)A21KV<>R<0R/&FL+R_=0TIg6a,+_CV43>ScDMVT(ICT1S6F&58R-TeP&
6/[bUHdcJgD:L7(9DbVWe5A+FWW]]CIcPg\VY/V@FBZeNN9O&[P0M?9@fc=.C;,8
;@c5Adf[H=]ZG]EfX^@41a?UY.(]9EBfJ+fO,@\>U=c:TADfC+bRADXdR:(9bAb\
OKNdX\MfG>^CU\gUKHR=4=S7)@T15eN+U1:679&RZFY^aX28T&C,#aD/<\YCR>\2
^KJD]9V@6[NI(SZ9QD0N[NJM]2MaYSTKEW--:A&77N6,,L8.Q>;,TJRN9>LGD&+M
\//cT#a@<M]eO-g6OF/V.@9AF)(X[b4OU_R_BF(FP6e1P?a3^1E2Y2.F<)06?W#5
>DWAPVFaZ>+A#N=AHZEUB+</O@?g(RY3LIe/NdYU-HBK+N3aK2dV+g/4=MU8Ed9&
YWcI;f0R/>67+#\c?Pab-#SUERBLI.W6>]+@-d0?ERHNLKXd2@E3SZ5\F&I;^99:
VN/T-3W_2fBa(dV9TKbY^DK;gXE+=XHX/SbK>]M+27=?EDV0YZ>,(/.dF#,I^S9/
=TVWMM5:L++0H9@=D;A5,,N@F-XTX:_I4&63-Cc]a,ZaJDceF))@G@MG47--0#bf
,_gN?G=;)gSVQY;b9eDVA\SI,g9bF88_K=:\;>85:LEgS6BYG0>G?UZ:Da>@YU@1
Pd[K&U+&U,1PYFU-V,[DZ3721PE<D]279^NM/+E>RFOgd+L6;4[P=W3QA4AU6-(S
DLI1g4F.[WI-9M9EgcLIe.#)>2UM[Ke/U)]CS7SX8DK>N<QRcQg(BC6.8_HYVV]2
.SB2KY4RgM7&-VXT:6#0>GcO97I(9XaPN064Qa)eG&4gOS?>50cOZN9@CV5d#(@E
/MF;O9Z\J2A+U]E]APZEf6WS5I\fWU1c(,Ba=,9dCA,HNe/.eIfFJ-CaI#UN<Y8_
O[5L?;N;b50=2e-0#=,<(<JP3FMC)FF2a8X0,5,e-W[fe+M:(S4X[OY43edKQa7SR$
`endprotected
  
`protected
S6c^^a7f\S-PFW3GKWV^-,8/1Pee);)<[cD(gJV\5OeL<27HWN(91)eg^NUUgEXd
-NEgg.W7\:,P.$
`endprotected
    
//vcs_lic_vip_protect
  `protected
2=\V#:[3]d?=)\/+KOV@^GK]#\&,WQ1)2QXUZ=5E;9,@;>f(1@VP4(\0BBD\VZc>
(ASXJ8=aWNFU9]L5>[JC^5-\Y06eT6<4KedL6g#ST_B\9YRWe<5NK)&;H(ME?@ff
RHb?\9dPA>:+X_X@(W51=@[+,H?9(;>H(S-c&X]DaM=SHF.VTB0+c81MT#7ecVMB
4JC)8Ca]Q+\&gY9]+5XU?P/JBJLX9Jd.?B4@[;:M8cHR,Z[^14.2?/S7MW>JQbY[
&\UabDU@b4b.FN507\f,TRHF+a0gSFV=Fe--gXT@SP9-O]&APN_?1&8W+H6[;8Te
7)+.V<N9,KXZ(17BT2F0)@VD]C+E8<-9DPU=cGCRZ0f@VVI2>,DCeKTW94_;MV5,
6.K2:(FdLI.U@L6M]D]/[3D:[Y]JEdF,b(cS[DT,)GKXN)4&0dW/--=aTDD^8VGO
7KcJ2WGJTR2:b@:3NbZLefIYWGUNK<AO=E07?2N\/DN<@Vc]=/80[AY-:8e),GOV
adJ]RUI-Z/NIBaBf_,W<7dWQB25-RY.,AER;_,+-RMTe]RKWUC+<)M?E;>JV?TF4
fBA=K_&OG:+?cf^-]>2\4>L-LZZOZ+#?Q+#5XZV2F7T#a#_?0VZR9RKUCAKV1T_I
8SDSE1=-Z+.+gS1V=P;L)<0<5b7dW-V4Q<9ERHc@c?_[MdSY-;c(Ge&ESPb/A?OK
X/BR:P1ZYQ?K=&5:NMC[X3X0D0HF_H2DTVU:8<QVf&+[N+f3Hb18/5P-,0>C,^>W
23g@I=JM<-K9^_FMQNCXG;W#G_(;:1YYe?>G0J>&,J/9N<YWgdE#4XL5FOUO)OPR
9(?R&d20D4E2BXI=>Q3KIYIBBJ]655Tb[Lg6V.8WX=18AfSI)fVE\SL;?G0AcHH=
Vf]Hf0L@Je2WFKgK-\[AQ87GeQc:M@Z\geU<#4NO4)g@GVXD@HQdVXEEEIfbFI7=
+W?J92_@9g=7K.YbU=AJU](;4,2_0N<V_Z]+U(Mc6C\S-ICaYPAc1#.O&YM],F^+
H,<0T>aUTGW@/LY04NU[+7(TOGCP&/+)UU4>E/6C<:6C_[LH_?/U\.c^Ka+N(G2)
dOAVc5:?)OY?^Y?T2EFKeec#[+Z+d?Bf#g:T;^BMGBg\G&09;+VHc\52OF[<H3+O
AO0HIS:^f:5QS/W??J4N0=c/TJA(2GR&ec7@BJ=2RA&1E>W8dNSRZ_?>YcF-IV7H
5:3P>\HH#M?_MFYA4P;4[?(@:P?PAe96(/4#@9geAfXV@8E_Td\,YQUB)d<?^G#F
PR#CJLe7^&IQ__Y478/<ba]B63^c6[EPdJ-8-Kde,fME\WKQc:QGE@=BH;]NI:AP
VPX\V/1H:83/60OG8&eK.]Q5K=[_-NZNZ((3eBK4+>c@3+@,ZY(Y,VP=d.AMGe+D
5L2=I[H2Y)KNHUKZ>8G8bR<MbZ^\Zd;:b9b#),^4<<P>2==fV3@M0:U.+D[B><,a
(;XU\,5<:Fd)>bGJ.c-,7B5YI31:d#6Ze=;Jb7=:RE?/L=.MTCRKXQ9c+:MP<MIN
UJf?E;EW>N@8;g28V.>I9GZg&;BR+/EE+:WWdVDECQcB8,41cGY>KF_KFaOMJBEg
4R0532<G&=?dUV>COc+=K/\d.L]G./Od:,KH17^U_#?c,M(P]:K0/\LH4WMV0+98
O38<We(7L;5+W?)+&_O3NV,MC@TeO?M\71Y4Ke_Bf>_1aK1:WATFKbF&0&A^?2/b
9\@]O>J,eZ@EQ8840^Ab?de5V,72Y8F7+FGH/I[=&D>EW,JJ@)f]F[<.5&WO1dJ6
VA^]-?/JZ(EY2_-/<H,7@GAgd9#<=72.&a+cd+J:Z\XJ&<bC&dEXFPI_dDDC@UJ\
0\Hce4gBV8NEAKd=_RcQ^ZZ=?,VNa\+E#TL179T,[f/B]0g1RNbGYd9;L_5PN_Mg
C4>(#&C^5V9PPP2<&3fBMVA6W&,,g[[]W<CNeB;CbQH-f[Q[D;(R8^EGG;-)\3]Y
^QGDL>.6=I9fe9YQ[GL)G)=WK\c@UC0OPP6AeSLSD2Q/9^/LYg2:[<XET,ScVNM#
^+94#UL_-&>=TE)5O;g;99TD_;Z(;A,#/8?VUR+/;HT<[(LB0X1AG2T;DVDLN<GQ
9XN8Q#)DJVb,JJef/d:2D<f8=_E4ZC<MUBP>0O)[N)Ha&8_T>>P:4J07\;J6?F<#
PHX+TMY27b[1/bR&N#J#,EZ#C&@9c,VRee/#UO?.7(F=,/1cQ++2cdaD/GKbEeC&
BYeU??)W,egFJ-[B(4\IfBMIBfbc5:K6\K)X/02AG^BDf4\/UP5(>5QU9UJ3J5)4
Z5O1\_X&&Sb]P(4eL\MAE26S(P)g\N?LA-g3.MW-W].?FfVOAXcLKNb[ZKCI^#S&
9>U\&12cQ@8Z:A0<Y.W>4OT\.9#C)R+^Db=&d<C?/O:ZZH6+@I.;C16X/497P/8&
7WdOWeCM?bD1-Yc7a<aA9D+>/f^Tf^\TU\ZNX,LDSG1f9-:.O)7f,WD2,_5e9/;0
FC.^AH38\S@.BBGN]B>[[[#bQLd9Af=@gCK<[K76HM=TCG3EY]+^DUF7cc1.M]UX
HU#OP)KWFOObM,D0SBY60PZZ\fgdK?X-IT3-?)>.g]OZc]<^[L=KA5Tb3d^21b[a
SJZ[77=]E[62JUC/&LFJ4g<?^^+;W5ZN?^aaH;]D_,B8H>Y?0-\J89WM(g3\R/NE
EN[;M0M0P7eec]eU[T9?BOP<LD@3CBg7C9P^:#E(<\(8>&5)6DL8S:3;;?:Sa0?E
&TIf?SHG,=B/I1_:1.ZPX;X/7JUIJU4f8;d3.C#AT[D.FI]G)3\0)Y,QEY79gWA#
c0&ReUVI?U1\5GL:)ILaFU9WVUBFgHO]/a#S]^_[@A+C&P[Jg)Q)AgUJ2E^M@#=A
BC68QO#RV1]SCeIE?fQ.XJ4JIDJT>FW#dL]@FP.f1H/AOPDUES50@-ee.UZ+d>C+
C>>(4SH.6@-P_@LfdYdIg;PS:-=fFGFfU7?JYF_GUY3FPF3=VQ=WGBXZ8gMBPOIK
V)?eAFe8?63;_7BO\U.H)/?C:M;)PHAaSUL#B71_Z6LXI)<&,@NVC?KEd)g&=1OT
FUM4BbUdR@fYScQY+VG^@NVPUAEgJ0?)STN\&BQ]38BGYKP33=^NDfYT=f=)64PR
031G9<)OC9ZNJ)f8cM]B[bWLVB&>SL5fF&03AVSS;0c/E-a9B>=H_GF9B=B03\1f
I[f1UG15#8aRI<I-\@9bDB^JG2T/RR=;cB>>96(?#LR/C[0]f?ca&L^UT@V[,6))
T?\UL1eA15[8e7@93AJbKY1V1.ZR&?Z@AKD<F:M4RN?EYFPUIL,:1:SI?FI=b4eV
5NWT(JI3NIf6gG1^H[5d0VJc@4?DV^fYY_3.M)dMZ]AEg.=bSW#SbUKB9GC0A\&7
IUJdS#VV/40fd[KBW:W:6&T7QELX7.-A_<2:X&f0c:\6Tg6=2Q\RV)S9C?Ob/IY>
=2-SPb=/P_Je#YQIa1ObYH(O<.<Z<@4K,\G-4;(X0WHBE#O/=:d@DG554B+O4aZg
UgWa-CRW=#fE&^Lc]K44[Gc[Vf3&GZ>bA2785#<,#V?_J1IBP\+=I#Qb7UObBR-E
MWO=MDI(5[^D+d3D(_@4_P\YSSZWK7f]A&^@cNEd@AO6[R+=>J_:5_=0RN;DB7CM
B90TD]U0&1BY_#8NXXH[O\Q6AJMGPPE]8(]B5(XB44H61UF><QSI=/,NC#)5C+VC
D>\Q2Da.&(>)d-_@X/aA81=GRZ,MX-8<R+Le]SDQ-D^NDIb_0(81&T6?B90F#deA
<E:d7]X[SI@[@^Z:->U=ReANBIYU@FG>(Oc?:3gV0<TUE=5W/G6=>9SU9bB2X,-;
gFS5HfO.1<?aAQJe_dH9J27&gW@N/f.SfEb/(]c?PBJ;e^M\9DNO7XLH956=FXd_
E-.R.NZA_M,:.=5[RZc1LNMD?f<L82PSNZNI(<C.+U>G_+BL7e70WA;#)#6deXg@
g:H^&IQZb+fJK&QT)@78g_D?f8NZ_KRI\KdU21D3JX[S0DgTER;4aH,<dLGJ[dca
PC4B;bAV3+SdW(e?:CAc0eD-[JQIV>VO=^FP4QII;D5CDdP6)#BN-?>ReP-\bA9c
De9d;XccGNWYI?5E<4>OO2S>6gY>.Q&61b;AYeN)).O.@fCa_BC;2#WA=7X@,7NN
JG0YJWH?4a\HAb;Jba/FL]OALd/DY_R[I4/^2,7:0<FX/[G\bL5=eE:7;Y=8b2BA
Y6?UR:-UW=:&^\#44?ZC8VH<eWBUAY?+;/=T:?Nb6#IP/]EPC#3S-f1C8OQ=?2^c
7eK+:1d<[9=S8KJ#fL#G60]=0477I.3WfcD2Rd&R1:>_:Q.FN>+<aC[QSX_)P-?R
Df]B?MEZHCO)MO2Ld0+]K6TQP;d,OZ8[92H:=A/eA:C&,I2)TUB\-/UBg3N\SYeJ
]RYZ#_@K>-ITF;,J69db;G#X#]O\\:XY)SE:GPaaE_fX51.)PZI8U0O-NbH8dNND
d9DD)-gT@SKH,@(;-c5VaW1&/ON^caH=^f<(.@?VV9OFR\bbcB32-(NOK,+?:TUM
YUYOIFR8]22JARLDE[.,ITXObAUV]35])=.E:&&]PU)gT_.P\>I)8(7^W7\:E>_R
93UKUT3Se.Za&>GV\,]P^<TOeJ(HQ]2D?LGPJ13O#,^T5?(B?)KNc5JdP:CAcIUM
ReDF:]Nb48ITVCa^.#g>.e^)Y<X>Wd)UGJQ/bFPH7=>&1UcV>R,&<.L4U.d+(;<?
9UC>7Cf]++#R+#&8?DE_2fCSL9W5D#@WUL>c_7:<?(aD8aV^#X2N+B7TTPL=1PXD
QC]2L](@NIZC/[4g.8:/?Xb6IgDeB4cWgB8YY<UOTb#G3/\dg_Y:+.60UK>W&eO<
]M25?Q7^Lc0J@e[8Df5O6.aFd&E7O+]@gV_]L6g\D5_H.YI5906G?>fF@U0.5\CR
CRPe)O@3I(0:^OOB^3c]/)88/Xg.6@UeeQ15FUIOYE]7dX/F0:c&1IEE,VQ[<Ff#
(A:D#A+B@A-VM+Q3\.B<T5LQSNJ8K80QR.5JfU/AW-?O4SadY3&&E=.2CLV;YHgU
D)Ef[c?2AdH5739Zc02M[M8C2S)TH@Ae[:eZIPOZaDN:_+FH/;(c=O8Z6>b>D13?
?^cBD[0/,)#F&aa,d:Z-25+Cda.PZ5XYYJ@>bbeFAM,UV&G4@2C\^)bI^ZQ+Y8e9
Pa2[X&OePf.)OcKAJ:[RXf7:cMS5)RGPQWSTHODbd[<=a:7YT\IDRTMLf4&+LQX#
1>03F0J_MTV+gZ/P)P):7#MG^</ZRfRJWNH60\ef=0YgQ&+VM6]N&f?MH?Q.f[>1
L349?:9W#QH7Q81(G@b;&L\f@E)aLAdGKM(?4R(^C>=C.)R_3&^.]cQU,>CDV93X
45L3H4I0^a?PZD8H]#;;3?4Yc,,MB5\)2I0&COUJaAH9QDWZYHC&A/R7EODSM?e3
^#GUId^JMI/=^Yd3VbWM^0O=BdJYPKJaN<gOa]-]E.QTYfOe0b]GW1g5e:/R>T<[
2A6KTW[+JI98M^/V?WYNH9Q1Q9YIIL/_);^B/]EM_W5c9]]ge5A1GS&X_FaSE>aC
50P61=\.F(/<SBB^8?@]9=G-Y#N?+WGCY,K+]BYDP#b(R.YB^3EJ2bX00#Y_F[7R
UO>4_4:30+W53]2OR^8V@Z&N>@[E4T?N,SIGcF335GB=;?U_0CVBYKd;]SOCCG6N
WH#c&(IVYE;O3Qd75EC<SF,\.;VMRWeRI4:a,V=g1TeZFD#)[49I-cb-248(1#YA
T;+/GN4S5IU=1<4RUZ3S4f6743FAOFe?Z7NSL-XQId,^DX0109HH5RYU(W\CdV-?
:>_gR>BbcW_gNFA7c6VJ&U;RQ?WDG9ASW+c/J\H&+VdMMCeSMe-0MIOR9CWfWVBe
L8TA3M(3/V&RHEc]0SaN>eb?;KPH5ScEWQ1\(O5MJ@\Ue^_IPA:a[Leg]TC)b/e+
SHFdM<b3;\Tb41\9,F2\N\(bY(_(1Je&^Hd=M^TS.\<>+L#edVY<)bS)[7-BW0b_
Y/DM\W/1<O1/K2C&(+9[,MCbUS5-dbRe2^NdC7402F:]55;8MDF6](ZLWSVIR>c3
66O]3cP3;(Q00G-2JcHfGbMY=[fHN0UABC4>UBFXWcFVHfCb)dPIdG.UdWE>Y-#U
X(\&219F9)7f9NHBW3V&I#[1a/gfTG<S0[T;.[eP(DF^[FBc?0W],6=MZIFKKLa#
T\^5#(IGE+5N8[-[<#&bX^g(T1[&OJQNb\4[gZ007GFBffUBb:,49ZXecJ2TNCLg
7VW6,:e+3I#O?bC0+gTg\Z-a#95b)FdBAP-c1Q<[R@XWZ6G]X^@W.7N(FO<,4Je@
N#\[BV^@C269_YdRFR<bGD--c1AeLG[f&IG_&4GUcU<<V-0Q?da]Z(c9]d,Z)\Nd
^A2K+_[@cL:dNJXaIHR?LWJNPS\C]NNC;eHcTKL:QeK7K+-T_c[_-4:XZY3+C_P<
F]<TPMP[C^a_4QG0Og#/J;d4#LU4IBT#b::(d)3^Df>N\VMN3a3Y_A#IbE]ZMd:Y
T:C=5(RCW:GU7.deZ9<5E=\b)d:]W1,=2?2,K7G_W(05I/QHXJQU_,;&^?,G.0&B
P]2K:)7VSb/C\.<QZUATYY3>TB:3)P3K;+ZC]H9>D_0NQfFaS4-e@O&MQL488MbK
QY]0ITWJc;46Z4e:1>b2_-/>L:eG,>2.+LSPLZHGb9+^E0YbCe8aVJ++9-=J)SV+
[::/@/F+.V.E^FS+&@86a[#4-U:7N(];ZCB[9K0),54^7<O-/@F(9RS+M,OgUd;:
XX9@f4MfPbOL9Q8WF;cE:2a_(Z/SLA:c@0K383g^HG1DRde^221[2JB6@=W^T8D2
)M8QHSTLBT5[Z8).E#,G2d],5&+4G##D<PIWO=.HE1T?a&2>EW];TOd9-cXO+.XV
.2=G9RGH2,3EC_Kf\gVH.5-ac&:&GI80S@f@[f[Z56F0/ZE#(dJB<]K[E2E+O\@]
GILS#P)DBK7g#,<522T]31cNF?4COGQ4W@&>f<CD(PNT0OK:+.7Q&[#9..&+?E80
(^Q[f;R9RNRK3#CaB(=J:Q@GgP7-ddN8.cA(U&FK[>F6XE\_SK73LTMP&[>.MPgV
^+CVK<8ZU3faRMbF-_H#/KHMeWC&-9:>NPG3\?I]Td0.5C;+fbbX[f0Ic;eR#Q>[
&A#0:[\MfJHCXPR8/[@)QIe+=OU.]OL@49X=X_QNRO.&3+8HE#V?TU]g<]e-be&&
9^I;^CD>b-4>2;SE+f\Q(cSbPU[CWD)=:XFQ)5.1d=Q:TIR[G?6F9\\OVY^]>^</
RD7M@2_GU/N/O6D,TSb<G1O]EQ3#KX@9OKT0W82DIDBCb9(&[SK:XeK0GT6aag#5
)_2<.J(MbC4C-VKK7V@=6ML4e#cVf3e[2SR8UH1E#:-CEHHe7K-:7[2BbEI/P=7N
&4eM<DZ>A/c)=2))3+\6K]^2c=W1@S)3<QUe1.PSFFA4:E]b.f^LO^</=d)BeS>1
UI+S=,Ne1[TeKD2(W#]ZbWZHBH30^NK+UD.6aDdS<2Vce8:W)=WX<_X_/)9<3VO[
26f;P/&8=g)C1_600?6PH=/DPJ:[ND-9cG3IM8J_<1E?CRGEg1A(6&49^6\eAD<\
PQEAYgF+=94<O.NEHX^I^4._/AD,g67,0Q3I1>aUYVX9+FP,DE:0.55>)81-L2:f
:I/UF\<-aIBf#]e/DKbJ_0Yd)/3VR4>-907/8N5;CUYNN\@&QN[B>7.C;#4=/IUC
HY.5b4BS,)5=SGU\g_4&1MUG8d#RNc3-bUd[Q=\WH)Pe(D^=\\fe<#W]IZ0I80U.
TL^1D;Pb,#6X0da;@ZfVZG[Dg.A786YfIO#=#1^J)VJf+<+Bb_+SNE(X/YNQb-_/
5?=I6c8?d4UOW4KP3QB8>=g+7)6&<2+bVXa3PW+ZVJI8cNE4^T.[SR<ZU3GQL1+2
bC<F\3MT(0.d0U4?8eHb96YdWGS_:(a.&V\LNd3#==SaVS?)0PH<H7.J@<;VLLYf
4UCCFFf6D92^HM>f<8>?f5T:eQ;OD3I^b3-/gY1DV1/_X&^\H?bSPb.N,C8d3P_a
MTeR37Sc,]G+#9DOKM1V+IFb;;9&_RXa9Q]C>P(;.c#.Ld1Z:acSOM_=1K+fA=Yb
_PVJ^2SF#-SHY:[E[YO5:^(5&@BbW7X6b+S31^DC4:R.??D7Y>?+_=#5/_0P]JY9
B;QA:3C&0M/ab[9dR2_72YLJ<&&9JU?6g7M;FI00FE;U<3gW:^<aN?</a24?+:V.
(daLbH8@+gT3B0<,,RCS2<])/0C11b.M5D<:67dL)DH>.c;WS)P[><9c\>a</caS
1;:?FP,3J^]Wc=d,TQ;Z3(,K/#g4T;)U4/YJD28PO>;O&RW;OHU0-HR<:gHH:Hf7
6+4S9)WX?G&\gcV&=?>feU\9>T)Q\WQ^SFI6c_]&22KPL.7ZfXO[NK5-H8fW?1I8
V4,N]BfEX61@cE-^3A>g9<53N)IY4)2:g@DOI->@5@C0^9dW;-/(OdPNH4NZ7?O\
?f9<bO:F^K#)d2/HfVJP&_T^G(fNF&A=#ZD;W:c]dK01aB+Xa.eMB4;Me,7;_9:K
KWdU.M/IO\HaN)E^>BK4Q3QgTY_aG[#&-U4bZ0/5>b37JQF4[GA)^#HH8RU?F<5)
_1X^0f_@^:gNFEd)gVQLTe/BUFg=Z.eVd#E@Q2<d?5Pf#JHNg.#C2)?U<gJYS^J9
@0bf^SU-AWHfM_/7,-d\(\7Z0#ZdF+-]RZcAG6,UC+K05bLORa;WOI/BLB-IR\-]
>8<7((c&(6F5d;;P]EOY\<Sf+(8C7M)63Z_D(WWRULg0JO7?;.T)-5dC&\_L68?2
.H82BHEH3W5P>M9I3P+-.YN92X6)c7JLLB-IV9THV,0W_69;Y-QcNYA8WE-X]XcY
Te3^A#7)FV2;-C(-+6E49[?6G9#ebJb[X(5;cF9-,5NQ.L>0?MK<@IM88H0\[3B#
JYQT[5Q+b-W47b(a=?76)TEVF,K2&cJ>/B=;eH&>_MJ\B;_6#e.0MH9@NA5)eN(2
4g?RJ0+)?:S1CEM5^KedA6SdMR3G3b-g3;+^8+4B#]6^(WW(E^HH.@5DL;@T[T[.
B)C4Y6?Y?#V1946/YHd9,J:C2W]d\2XaT/8)QV^TZ^+]b2[Y^c3E:0Z(^I&f/4KW
0C^=;2W463PZ]J?D-ed,&3PCB::(#SL;d?/9ZCM6X:1Q@[VcOgM)YU6dO^fG9bPY
0aV<=eG,M4Y5(UJWe>U^VB:>fQ3LW4CR(F&V^Mdg@4e@gI8a\.fY\LaJ,]O,d@M1
_Z\^I+cQ,cT4V/F/&.(TG4(]QYaQL<,Q?d(_,V7-)fTN.&1e1aU?I)LL(]@X<RFd
)_b(LK6>K.0/)eM:/N1UQR+/R>#<0@XZd&E2Ta,\W-DI8D75Xga-^5P1LWV/?U;a
b3ND:c=a-K>>b:-H70?Z&e4d3NUHdMPC52BcG2^0&=5]S413e7fFG^,LF2Mcd<R\
>9&0D.XY9Wb(9O>bNT\I)]b3K/J;&HIJOcKS^-.YA3<]e=DfcVI&]51(>IRX2D?E
N#Og6:ABLd1^S2VEQ_P,FATCY4^eF;cW71F.E)38f5.(>G1,b(PY_e[:5/1[M<)+
)D,-:_?N)P]c+Tc3:ISgGQI,R2)),Va7eUDYVPMQ_8+5L/eA,Q;bfdf3[QV-b5N3
PH2,M-KF9ec#&3b8]Kg0]OJ@-L47GQ_[WE2)X3#IL\=Ca)SR7H(+;B98USZ_S>2a
X_,HCdaCDcBN^72TA\I9KL[^&&=UeC4I;+50/\2V8:[]/=LQRSXR]E+3>EVW_)LM
+GK1VK^768&0EI.[Ed90dAA_0G?ZLX?1U4C_(bf[G,X_N17U#gEC4KS9RIE6+9gL
-(?N@#gBXXUb>ZIe=G92KNc#\\QfWa0fZOASS+^5g[0?8:9/C)dLF>?7590IWc:<
)dbRYeXQ^bD2;fD5\E++Zb<RI/EB=<=W(S5IJ:+O>K2ZOUAB6#e4WKPM\HE5=>.e
N<D</=1?7L8UU]JO]T=1LI+#OC\JEFLDHa1[[QP)ZdTZdEGMae,_][Dg9gNVB)>G
)aG#<NL]=@9IF(?/dIPS-:Sg>L:K/>G9]@^/RT?I)eN;)=O4d<0&e[1G6.Q<G8SC
Xf(X0@]LF[^57@[AUL]K#6QFX(d<;g2O5eXf6#DZRL;>E2;:-RaDBf@Z0>RDM(6?
Dg2E),3DTf7O^R9d.+DXDRb&ab^M[0e4<GF30H7X;,9P.)]G7<:<:)fASTYQ1[K1
P_:O)BKCISM<YL];e;U_ZGSY,YQ\UY3[c>6/Q)UZBa2B=@Y=RY>_\L+J#IcWM<;e
63_2YgH2O+Z(dBZ7DKDA5<#c@b3R<ad0R<^f#3(CIT]<H_aO1f-3VF^:PBZ3WUS]
TZf].-1Q5a[&=O.P7Gc0TWdD:?O=^,8I&MVH=@2SRG[=0Z4:0Q./\189FE>A/[T\
G9BXgc.JT)c<(aYKDgW9KI1-#B>e3N(a3X]=VMF:[K7WfA@Qf0XA2^0cIa4-+3+9
6RV#AJ3:Z,BTMZ/G8G5Q:Zb5H^@&M]90f:HCK5]GEa^D&d?4bHPH@g9^=^I08#6]
=WF;BQJ,.J9O&+W=L-;RbTPeIEg[AFB7WYWg(15BJ[MM?cBI&4d;F9^@)_EA@),>
;d]Ge5;UT33U^b\QYI..a(>X99-^cZ8VJ&f]H7>SJ]QK7c=9>?VfgE<L\<4_ceC3
2SKQVd5]7\dLX>0+.=]6Xf-EU+7bM/-U@/E_bc^HK[8887(^URTRg^(O.W.J-61E
0)F)?fZNZ,8@e19+-_25WY+XN_.KF,<A6=Wd-,Gb2Y]Q:O?L,8]@V]Sc=0>,2)(]
&ITDb96QG<H(Xf#T9@#D-^/TN&@NDRHJLK5X^fK^M71M_,F;_]:Uf&C?^X)/&aM0
@B0f+SL(#F)KG#^#\X3RF6<VL&==Rc&-S],5:Q^gTXS=>(<6e5/]<Hd?21?FE-6Q
YObY-b^B3VJ6a(a)Y<TF9/;c]BM#=XW;BFF8JW72@TG=A$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SV
