
`ifndef GUARD_SVT_APB_MASTER_MONITOR_VMM_SV
`define GUARD_SVT_APB_MASTER_MONITOR_VMM_SV

typedef class svt_apb_master_monitor_callback;

// =============================================================================
/**
 * This class is VMM Monitor that implements an APB system monitor component.
 */
class svt_apb_master_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** 
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
   vmm_tlm_analysis_port#(svt_apb_master_monitor, svt_apb_master_transaction) item_observed_port;
  
   /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Master_monitor components */
  protected svt_apb_master_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_system_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_system_configuration cfg;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * @param cfg Required argument to set (copy data into) cfg
   */
  extern function new (svt_apb_system_configuration cfg, vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
 
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void access_phase(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after reset signal is deasserted
   * Callback issued to allow the testbench to know the apb state after resert deassertion (IDLE or SETUP)
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void post_reset(svt_apb_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when transaction is in SETUP, ACCESS aor IDLE phase
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //--------------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute.
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

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

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_master_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_output_port_put(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void output_port_cov(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void setup_phase(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_output_port_put_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>output_port_cov</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task output_port_cov_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the setup phase of a transaction
   * 
   * This method issues the <i>setup_phase</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task setup_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the access phase of a transaction
   * 
   * This method issues the <i>access_phase</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task access_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after reset deasserted
   * 
   * This method issues the <i>post_reset</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task post_reset_cb_exec(svt_apb_transaction xact);
  
  // ---------------------------------------------------------------------------
  /** 
   * Called when the transaction is in SETUP, ACCESS or IDLE phase
   * 
   * This method issues the <i>sample_apb_states</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task sample_apb_states_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called when the signal_valid_prdata_check is about to execute.
   * 
   * This method issues the <i>pre_execute_checks/i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task pre_execute_checks_cb_exec(svt_apb_transaction xact);

/** @endcond */

endclass

`protected
+1agFTRDJU4ceGAWX\IMR2cH6f2W9#9\K).9_fEFA[e1f,7W_XQ-.)M)T+AI/OKC
MKQ8GG<H:AVDG38,7d+8\KfZ[#@Vf@BWPb[]H+..5I?Ce^]=F55)JEf@)bOOQMb2
,_c@T><32E:(&/TDJ[KG/d6F9?Z\bK@@N_d=;U&K5T2_LKY1B7)GT]MHA3&]<bBR
D#EU)>+.=c+@ae@@PFeB447M+Q?3Ug^Na(EPMAg+)>d@3]bEI@A:W71X;:9D-,Ca
M)K?10]8DNE\=JfOOba<e666HWUN/L-LUHAF5ZW>:-gdQ4Q<AYW_R(bYU15Q25C1
Ib(,V#&d\J_1#.#FAT[IdFMT2Y=/A5:WbcW1<>1@=.fbB:H4.:.MU4O7eF0?NC&)
2&?SAA)T=X]0_cM9[g#VY<@88AHP<PHNAdZ#@:+^I(2\M^J;J8GR4\?N=RFZSaG5
U]TOI:8a?\^AEBO/D@a6F3,=I<EFN/?RX8-?fRH0ED=C&4B=F/&@KcMU2S\?2Rac
-()aNYAd4+NH]/&EggfF:Tb<J,a+;B[S+LP7(/@IM?QfL9IeS]^9GRceA4->MF_e
JB.G1W6I[ef/UPd.QgAIK_/.)afOIB]DGc)dIT>:^+fUBR5LOdC0(\&2ELc[aSWP
7gD1CN0ER=JP+\4Ab>A<IU[HZ48KU60EA(/KDecAg&Z1.=c\SLLCWE_9&N[cZK:4
1R[R<W/AUJ8OAM>g>G.&Z;E292bRECRYW#MF;2G^?/(I-J;K++8HL\&>TdL6H>2/
4b?(&cBfDg^]Z3;b=e_[cd)3JP,&?/J1+43SRJO89.DCMBeWHJ[:I(=_]0+-Z=7#
SEE4+E8\#d70HFd+\,(?59LS9M]GBS),CLcd(2cBPJ+YX<b.^2)T-E@.MG_a7ZUV
A+:=7_#?PR6>?egVb]Z3:1FB)YX,&\VcD\U55&8cLE_WS@MOCN[]9AJ)YYGSBBC/
E]G(C4B27Y[&]3:S)Y<P.UN;W-^XGO8\bGVK63SSSb85BJE0MZ1<Q?<e+=2=DI->
&HHf.V^AZI>G4>;?dfZ<1#B8.g=@:P7HddQd1,.RVPP:=8AOObWW0;I#OQX4gHd=
fQeV=BXW_<:aAS6P)BCWeWS6:9b9QAQTV/ZNf,&BHC=,<U8?[aU:=dd_<:+9OIf=
dO6RCKa[CAVR=YJa>P_]N)KcX<2]c.^4>JcL9UN,M5RZJFF=M&G77Qa;?C,UWGH7
6P.&<QaN=7QR5NC2/VHE7=HbP]2.U[SIQH3f=MDJ;+<f1=0WdQF0S8GQ:]AW&@[>
&RKO]Z#BPRJ2^9ULUGDA[V-^CHKGKC+S@f3b6f+e;c[@SAa^NB2L/#+J5=g/X#5GU$
`endprotected


//vcs_lic_vip_protect
  `protected
5\8Af=b3B]6cRb??2A1EL_^M>e7R.MK7/MNOA.43MIR78bM9>T+M.(RY87+b#SaX
WJ&<R88TSV<F5fZeJ?/LDZ25)b>(fWL=,CQ=+>B9,^Y_=B0[\/fPI\-BXD:=+[7B
@4950_Cg\+:C4#2APg.cPL[=MNXGT70\ZM\8]g_(ZFReU\:AO]0E&8cM.-#M6YKS
5V?f@/CY]EHe3[AB94<SbR=6X/becU+>Qgc3OI4KAab4V8Qc5454QX2^7^?0]6Z)
aP9IR1L[8^FYZU+I,@+^a/e<&9XF6I;-EJLdOUcC1GC@JV1P<fRQaef]I2Sbc\>L
JB_KRQ2D&B0;O7UF)T&;>7=V(D-4^9J0\4DBc(H>8#d@W?9=Pf._ccIB3ga:[VFR
48JYNMPH_-VWbK+Y+]E70Ne87_K2U-NVOX\X94_(b,3-7)DE[eLW&Lf\[I^d]XLc
X=Qc+]c--HHFVb@;TMR3;b?LU1Qa6(R).)P,[><;b[4&Ve>J>&@[@<c#SF:Z5?FI
C/6_0D_[b^OS.:ZfO^Ke>,b5D./R3\Za_Q5O<#P3&XET9\<)OHPU2TC1I>0]26@:
=Ab#DY<3691X<@eLW#+N>#CXecPR=Yd>abb#RF5?D:S2\3,F)P/db_#MX3WL90GD
/P2>]L8_DF29ZcL\NL8QKed\UKBQ0d8<UVD=N2/YYb@dIbL\L#6&G)J3T2VYTF&0
.5f[Z51W>9(F+)3-+OUKP>5-(\+-R)V&eR/SLBGZW4gYP_>Kf?;0e5R\+482?_G,
U<-8;D9e,VKR9HIfc++Q2Q/La;R1\^8Y+eJZP\^g)aM0IKRE3)]ZM5aX[7@IC)/5
M+#RFAKRM-ZXLC05>0?PDbU-f#d[7/b9\]84O[Age_I_9Db=Y8<+W8a\Tb1QHI_7
I3N;Zf&(&4AWC(b5H+-4B+4I9WB3?]YQ(T)Q4-J?6^Z<H?e:52M@)AN@?0H:-HC]
0Z0H9,3J.R=Ze==-U@I;:+.JIY7?)/CY_=];DYbL2/U70.O3@SW2H4K8_V5HR?M<
&PIZ;LDPY[WO)73KP&U8;SA^1:IPFN-QE^-87RQ3L#H<a0g;J^+PYNANB.IUJAa9
C:U;UZ;eIJ-UR5S>e7:b4TX6O](>e5YYeYcf:[aHf&Fe[TG>0UD]#ZV)I69--c<9
:?SCR]GHcJKP5aHD?,+fZNBSR,-3K6ETDX^,ZL,0e[XBV8gXZ[^JC_^Z-?aDA6>H
3Q+VWdS\FGR(L@,8+M3#R1F>:#HcQK>eOeL+29JLXB_Y<]D?6=2b>VA/LG3g)VBM
4M\4?X?g])/EcQDX>^PdC=e2V[C:d;dXgD-7RN)e/98&40A+^J.5?^c02FeN.4[g
e2R<L+]4Idfg0Y(<+/,&Q.(PeH_B_N\&ELBFgO;;2<QV4HTU-3,#E#Ge5?MaS=@L
@&4LK3YWd>6.5/M_]V+eg/GYTG/PIc[SAXC[],:KM-?ZPA[8TKE9SXY>f#2U+fG5
CJ?KV4.fP]MI3-<[YWUQ;5]4P?=<Zg7N2?:ZLJPH:?_QCNFbcWQ<8:c\>,E>aY2N
HNS.c,P/4)4#)PWc39&f79PF,\=cT7MO][M1#Ic<JZge@._QVM(J5<;:SbZNP[Lb
]41O/Wa@<SNN>DSYDJRYA)W4=/JGAcQ7T(?7EH86R[MZN7c.?BZa?AQ;ES?YP=W_
HQ3AafZG#(H(A4J[=VcCbTYU3gL:CB6F1074>IX@3ce:_WaO7LJR4&8KPV5Q,NEF
(bNNQ+E^YMPOe/Z=/H=3)KC33;[L&YOV<0/\<H3cCG1^5DbAH9-EV>TD[D:63gPJ
:A^9\JJ(/W/F_-JH=J[QcV0YY<D&QfG?a,+;?XW:W<DRDZ]B1T-P]-_VW_/0c_O;
#4>YW,HFgKCb^_CQ?4(G)HdB&R>,9,c.^_dDdeC3+9:,A^7<-dOI0KDR<H):Z>&O
FM1)0IYB_#A&6+]1F[0DTJ8RSJZaZW?)a7I>?a6dL,UTg,=LbG3&2RM+D:/O44fg
];c)>Y4bI4-\Hf\Z7^3e3bB^2Q5URWWPOBe4P^1O,^RY1(A6I=g)a4W8@&<2_L,5
Ee>VQ(RS0Ib09_TcR>4LJ0[G;0G\&88I?IF?M3,I\\(5f.C6)GX.;O=5g0gYJ[R5
X8JFfN@N6Y_(e&7^1@M<KZE_7c@\X4#M\3.K;,.+NcGTWaI+c@\7+a1;J_ZPZ3ag
fWGU,P:_B,F]._->_b_\OD_bSZg&F6HUOCbTAFHbTMC)_TJO=#ce\];R.RB#d]d=
QW@E-E[N0TC\B>T3EL#TY\@dGDbBTT0bg[D1JWR+0DRY(=:+1d>7ZQP<:c>VaDSP
IfU^4V3)T:Y]Y\&Z8)#e;N#b1F^.^I03F5.=;ZQ?)4B6YDZD#&4RW;K#D3fX0FT#
)#27c&9K.,A#Z[8V<)dK+Od?=<fM&_^4Q68a2<\-WdOHLS4VMJ37^F3XST4T6cdO
?;<JE7U/U:b6gE/[\??/7].eN4J3fBW1;S?IfTL.HQ7FUe2PIVZ#6UWg,)6YaIJH
4Z7<+=KL9E;.E&Q9@W\:<?H_0_H;.RDB)20MNfK.IET==R7.L;^3g>A7-IY<FK;?
SNIG]gYAEPg\R@(]Ta9d>,1A-2<.E7Q[fNZ,OE_W\bR@>&4J8JW&[9(MWE0E76eG
F2T3&YYdb\?#T<>]a,S>1W2/e[JF5PUCHQ/=X5R5<(6cZcH7&EDSN;.5((R^d8ga
KL;U=/+4edX]BfIA/:X<[<+^>8U#G]9:6U?G0=;820FbJUYK68I=U1SPFNS4Kc(8
J^L:3FU^/AQQa.?6,>I61HH_(HN_6aAM4S918&E>\fOJ3#1M&]NPX?2L)ER0(YDN
,c;00S[#f@[0<D&8CPQ;b>=cXbZUK)QXYZ\L9?;VR0\ZUdRaYY2XX<EKH9V@c)F1
AP0?VeSF<A===ANH4<Ac;]UIX0;J821@3T=AID,M1Q=TM-1#))M.AT9)X7a1\SID
M,(ZcfBHL9LaP7IdGdQ=F-/(7LRV>_[B&PQO\SKKHR6d57c-@06EO1)S[]13;\TQ
RR(f=(A8/FIR4>+N67HY;FFR3+.<CeD-HFMNX,ZSAB#VXc^,cM<Ie==7S:AG_O@^
@0>J3)Z[0V)g,L>6A,O)@U0=:Z2739FA88DRIF^/3cCZL2D=77,G.P0/]a]F)R#?
OFH;FDIc@7/#\XI&AE9C,EO<a_V^fU4^47,_V^5E;P1YF)H=Z9,)QLNQ7HUC?F.]
6?F_,_LIJGIS\?bgA7/NBKLgG&POMdV?H@#Ze6gf7N1QFJ<LbVUb&QY-8,bHP&b^
VKadMO_HW0S@I+-D]7F.=>Z9IC0WZZc:NK0ZdR]Z-#9Z7[(f?F/P#3CJa4NJ^AGb
G9B97=X<ID55Z3Q:c@,G(E1+,Zg#AV?dAH=>efc^UNNdaa#5Efd@,K=-\N,RgN+2
-EHbg4JIeP#-ObJ3?;HU\Y&2U7(EANR.S.:J6eJQ(1]R3)QE0Q3J2D,@33./0dXI
6U,8_Q9:>f^9\,P6GG;RD1;64BHEK<S/M<=Y:LRN]A,NQ5WI,bfd,G9ad=HbU5X[
2=BUFgM5A;WQ+5@8/491<aFC@DeXS:d/V?fZ1M0745d#3EN:+dB0O9^?,?1S,cYK
IF?V\_M^8X0_f,U[CeHfa0cY\I\+b_#9+b,.2PWS76DTB^NSMR&[bS;)29CL>KHP
Lb=)J<>]0M?UcDVV0Qbb1.8LC35,8Y@@[fY2RE-FK^-Hd;7Z]VLE4GIVT^Z+6.70
E0&K,:2e2YeSg)A&LP1^(]?33faCJ--,.:Ae_g+.,@^9Y/d]J]^bXOP-4]CQ@(A3
U4?T-<=>J#+G][[#?WdN3E+];(B)/NBC_FfFN;AdI_e9#2Z;dL6EQBe8\:35EEb=
E@]ED0IE<dDU#_Y+Xg2(0S::@+8P_a5U32[-KW2fZ_B2#.A&;CU\36.+0>J7Q&+P
8BY^YW([SQ<MXe7,8)Q7M)VP--1=[.+ND@4YV8/:[E/G/M1//>_,X+>K_Y+8+A[^
).-J:@-&.4V9QMIcWZb[Gg]NIad+\KF.P#>d5HDJ)fY7G\-_(^#RVZf=WH1>O8KJ
B:Ue:a=H+M3>[PVX@E_174<K[.X8SS^??PgKg&8-3.,,R0\U/X#;>J6L,TI()7dN
2R,.)M.]d_<:>BNf&I8K#/L^f3V7&eLZIc=ZJ-XC,U/G>X@8=#f,XS00Q[?3AMDS
,5]E+B<I6/&^#V@fM0+eUA\,fJ)fBd+WM3cJ]OeI+(ad>R<e77XD--eX0gP[bg9<
-2,WV5[Jc7]/4Rd^LK<,ELVBN[B3Y61>&4@9NZ4ZABDYP+cN178T9\NXP\K[^e&>
5LYgUGBPHV82f@>8R+Bb\L/E7E;4eE/CYX\#5M3LP_dMCTR-Af.,,A4IQ&?D?X74
86#,O0;feO/cIc;DMd711P=@-e&+d9O)#0#S]D4XXOG\U<E=a3E(GQLAIa40NVS)
]@7#7V3QfgNBG94RS+&,?0]G:6VWIZX6C??4?XD9d#A8fFM\_W)[0;LQES[Lc(=f
]/(d8WX[5^9B?^GXg_;RHB2><MT?BC1RZ.RMMOM[T>G8UF1E#,TN\7B5\;b=J-4<
L<O])Mcd(<bWNCFGI2FLRW8cbK+aMKMJ[.&[B+&T1K2GVaH)#dEOBb)fd^[aQL,&
.B6V-/][b<@V_FJ89&^_M(+VFJ^3A9S;NBIL-HJcg/AA2YM>ATLWI+J>Z/?eO<QH
aO3YaPV<6;8,2bMFC=4?[PeeO@.KD;-HHBVbfK?T,0\;A0\[0Q(UIN1EQ5#LXPcS
4Sa[+@C/(=0+PK@I33-S<_[(VE?PX_28I8BIU<(cB7,QUGJI#a3a#]\O[5[.I5bb
B;/Pf(f8TE&I]Z8^@EVg<1JfIE:(24AaG)UC_be:UZ5)Ug^/860]N>,[JN;Ab7]X
V+He^E+gY>&BeH[P8OFcc254Sa;IA.2K<M]@J#Kb3:TVJ,W<#TXOg.RO8#G+T4KP
(ecICdA2C>[BfFdV;OL=J,XDbIQMCH,]:^GcSfD>99Haf&]<\QM@e=b?b8WYSb4^
590DUa^4Mb+Ze[7C/\MX=\CLQBH4D50HJ2VE/=)]WL?K^NIJ)Qc)@-<ZX<H3+-&,
U/VC8_Tf=L(C:O>.?5cG/C05,H;VV;SIGI;&FP4>DL:cNMGJ1[OcG6?,/U69Q7)=
=45DTLE#\+J5U<;1B@55M<cZ@FK,0FRW71>TP^5O@<\(+0NaK&eNdTU.d4Rf>KR>
S3@0[-F?UH<M.1\c[ZVaC]g@Sb0OY+GgH0#3\^\U@>7B9.(./>Y?;<<2I&UZfI<f
T#QUag2ea0:g8550P#B7KfedQ(MS.J[8V#;=R,1+a)YH/D-(9:YYUB#N_04CG?eK
V;9Eb&4B4DW>KC+\3VbFQ2V(:),GR^S,CP&W)QK),JZK<gL[E06REC,LMG)N<KMQ
3X^3I)V4fP@]077-J\.BPfSMGa#f0eMPdK-\R1I&#&?c?N/5P/-\b-2.PdS&_,?&
J>4dI9_J^c8/UCF)Be=NE8>A?>1+3a6S12Z(Y/D20.1?TVc</#[ZTPGK0&(FBJ)I
RNO#d[T-DCFU6KR)W^RP^?dDXb4:)X:1N>W?#Qd0I6_&9PK>=9\X9b2KM,&_=#^U
JZI&2>M..:f]N8F;::>UceF@>>P^e/0?)T/GeF(RK,XdeG4Q=0G\6YQ[1cY\aS9<
QL&/:_(Z#^cW_8<a7\K60T=@GZ#96-(-3,W0HZ2EHFN^VE.9.XU3M)#D=eU6<B65
-OI):)560=2?FVW04SUAYd4D>.6]fZ;T(A^eJDMQT@&@(fd?1[DPT,>YW;]O9E/_
g&Nbg6[Q/1?]7?F/Q/3/A<)H_3.dJ;L1>9aUdJL-SRWN9C);26Y]()20+&KEIQ51
Q;N\6F<^2]0L=gKA2FgYca9a-SW>4C0D:?:5a?b>R--/=4<0SP\1?Q_RfY&NM,>]
?\FLZOWP?5/Q/\&T-YQF?S9L>NG&6O4H<>P,dB7AG?2QY>e;K?X4H.Og\D;Hb7H)
(V56Y]OWHHGG6TeEdM,(4cCFVBH+GMC[(0N7=+/#b_;9RX&,2V==e52O+/APA[aF
e&6L+?,CBZ+XLRV^#)6b,g]?dR>;eG0+3KY\^TT<S)=a\-I><Ob^:@<>O;NbbJR(
Y@6&XH+BCa:YcCV4@2X<@-9>I6^T+@7]DgE<,JT3b7R#VA-Y_5U+-HY[8VBC=WGQ
aeb<>AdG:)G)U>Q=7d:G\,ZE\C>Hb;R-//Z4N@O,bAgFH/I2RcQ66?9K:aE=EK,;
-2ZEdQ9P^WG[11BBfG?]#=>A<8TU0c1U_8Y.]7&47&W4fGZ;_EAF.7OX+BW]C[^G
OTYg/DH.:/T2YC)BQO[5O_MHC(6&b#QTeS70<G4&&P@.,A/[&_RNbbc<^EO0E0W3
W;#LQ;d[PW@6d@UR1;P>M[2090YT9[.HJ8f8N:_2OMQ,L^@:MO>&BJCLcU@8U;.E
gJ/MBBS.f8gKJ3=W\Q:<6-3JH]9W,1S^GbB)OLVH:ME9?^Q3d7FTP],3X+X6\9?T
<?^\-.4fc5MT?#2&4(1YEc\^F-36_J1-fAfETf_P2b4&?Y]NZ;/c#e[WD(<^<O16
?/::Qg[/+8@)VXW[?J?(/,_Z6^^g->QONYe75b(F7ddFA;CS@K?f]3P9TJXfAFZ^
IV80@JJcIQ>a@[4gTS3LSCZF3R6^bOcV/=-O1KH=VQ&@I^1L#M2AdcPF0S+66_ST
PYO&OJLFOP?M/^K)&I6<]F-6)-EJ?UT-ZV7(>VGQ\^?ffU043fCF4G=7T#SE_=>K
P>dCHT&;F_3>(.Y5M8PU[D8L&KI>O,/_4,8,,&Q>O;P.YGH\b?=A]DCaB)&I2,E@
<))98QbT0P-_T:QY5&&5&MJX--GZCAa&P\M/fB.:e:4(:TN5,#6cE45N7>G=BG;R
J.;NV8#:bT?Z2Z>K&>\H+2R@8?T@\7[#e.#6OZ030=VMG#9&c>LTEBC.ddZgTZb/
KgbCKd\O-C#0.BX3L>^::OSD3/Cdg<[L6ddIQD9M_(MeHU1N4(d&2<cHTEBXb+2J
3-Xc,b?Xb\c1[6NH2g7D[1#e7;I(<XR;X/)eHBA1OLFA8@U4Q2Z-EKH?_RZ]TP+O
P@f=LD?)]gMGB5e&#HKQUJTSS.3GbD\WUTZ?K9AHPYK>4.^(Me2)H1]C>9LbSL+U
@a.b=3/./B&A7B=bUD4:O,fLB6&Q.^_ZMN8RAcXPM&3IF)B/W?d/99/VU9H69AN_
Y:_6=J#E([]:7_d\4[KeLgPV)8N0]BWZGSa=SfI16DJ9B&BZ6&3=E?^8Z1VOB>&^
Bc_2WBJ8NNNTBfSDEd9CXSBT\-.UHOES+9JbQPLUS2.T,S=BNMZ1SA]T,8Gd(D)f
7OIDZ2Fc[Q[,X@PSLe?DZW>#>P<D=\Ec4eA#8MQDIQO^R:-;.BVe2?/,[^fG-d(d
AKG>ED/BJS6;Y:0.3[J_D6UF,0B1@O&ZI;3SDT48W5\9>=@)W?gEH9QO/A#^4a4>
=KFEI13X3WTXAe&C0:1YJM;Y3B0f70ATNJU0KN2gd--NW[XZa@MH>>=?>(U0?D/C
_Bg]eP,CR6+Sd,1H+C@DBY=bSF-cPXK&LRgbV32d?--+(\ZI][.eNZ5V0>Qe-?)I
dYO_RU#U0_<C?D,F)FY6,5N2\f>cDNeC7;HNN@R<=fLdUO^]N7EWKS8UE6^HXOX5
bXLB#WUDW+K2V8^eR_EgL^9@c[>9MH[+?dH/\1D3#U<LU9N:3:g^P-PMV0geDc@F
Q1VJ:+EWWCTIT08U3#)c:)JP5dGQE@Ua<]Y0CGMYB/Q#Za112KBV7.UWGTZePA_3
NFSX>B^SId7S7H7fGdSI+W)@BGG5;BPS11+gX7[VgQcb[e=\SQ6g0RTfZL\M9ZB]
Ib;UD:#d,UYcS\RB]4/:OH8TUNd[9I[,0@d/)8\)bA<:.9f<T)T\d==6?7.XDF5^
0ILDbSHSdg^YG&]<&Uf\-7M<]P.B>)KGM3NYR/A(J8fcDU[,B<[ESfO@Q]33#.SY
CNO/_K(e4T&5a]W(^E=4de7Ce6BeU]RA^J-L<aBaNEAdG/3Ie,eO+3W3C<)@b3AM
TB:PEVKBeZJ_DJ[KcUJSJQgf)-;A4[/82@1B?b&W1([cJ;^;fU?CE(]B00^7MG<9
89PP.bX31F05L+ES9J=2(_T@AH9]2A9e3b/M_))J58aD0.@.dEO)843Sf\?4^ee3
BCK(&/C^aG^^[,dF/L\1Q5W2W_B[8BaGe-/;?N;YV\TdK)A@b4Q2GgWT6<EB&9+b
#<S:2M\QM7BK;<;0=B98bGS@d[EFTIa<b/I<W@O,_=:?a]&T.J(-<3Te6U;PG]_=
d)\N?8ddJ\UGaF#V27D-8c38g3\GM[62OCTE.F^)CB(VHR4,O-OMeVQVW8V/58I]
&72]_19g6O]D_^_XO@3f(/d]E^O;a+a2VeLe^SR/RfG]>IN.7(+3Z5OI<)(aZOFe
bNUPe#\SGd@.PUSWACU>EK1TD3(NPTUHaTLS?FG72W<@7]=HQV<C:dC]B)SAD2C+
&JM0H2X.+T7=TZ(_6cNK]]3T=f/2JV.6>.a@PG#1X]7E<-3Z)N=M4d2;f0+c0fBO
8>5fW]]cBb[405@QbCRP:RPbfaA]Z<9_f8;_bYCU<1fD46ML_Y1G0/.9-AEJ<bYZ
)QF;YX@D?Q6&K;TfO8(MdHc(Qd&IAd;JQ6D^1R+P8L4Y_<Z]bFV;K.eZZG@RA@ba
H<Da=_NY\<ZJ,_3P3,3eVd6,V2ZfAI[)TXOK>3a7@bZ158T&]g1&g;VG-WRM[:PY
KTUIJ[<Y<G@.7_-2(LcT]baK[IPX],GXE(8-eTE7:HeaTc_c&9[M622[))90>gWc
Z[cWR]DQ/AS0D0.YI7M28Fa7RH8GXH&1MdM?D#O4b7FEJ4E0abAYe5dXG(LJDM9V
/8OKcF)9F82?69EH0YfLGQUZ7QeK2NgB@WXD0TdK0Y3>0;EQAIdE5eAS#:V@&dN1
fg8C8:^a=G;I5.MB8N7XNJZBS>LI4/Y3AH>PL_7\4I78[^:2#)#UaYS_ZZQE\Y?2
5+H)-.PW,PI.)5Hff2F.4FI=4H1REC0T[K#R3E\EW,S56@aa,J;XMZdS_796#;=5
>B=d9=MT(Og9@a#UI,BDI&cE1[=C<_#N?$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_VMM_SV



