
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV

typedef class svt_ahb_system_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY  
typedef uvm_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`endif
  
// =============================================================================
/**
 * This class is System Monitor that implements an AHB system_checker
 * component.  The system monitor observes transactions across the ports of a
 * AHB bus and performs checks between the transactions of these ports. It does
 * not perform port level checks which are done by the checkers of each
 * master/slave agent connected to a port.  
 */

class svt_ahb_system_monitor extends svt_monitor;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_system_monitor, svt_ahb_system_monitor_callback)
`endif
  
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /**
   * Port through which checker gets transactions initiated from master to bus
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_master_transaction) mstr_to_bus_get_port;

  /**
   * Port through which checker gets transactions initiated from bus to slave 
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_transaction) bus_to_slave_get_port;
  /** @endcond */


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of AHB system_checker components */
  protected svt_ahb_system_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_system_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_system_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** Flag for reporting master transactions*/
  local bit received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit received_slave_xacts  = 1'b0;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_system_monitor)
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
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_system_monitor", `SVT_XVM(component) parent = null);
  
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`else
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads that get transactions from
   * ports and monitors them. 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
    * Report phase
    * Reports cache vs memory consistency
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase(uvm_phase phase);
`else
  extern virtual function void report();
`endif                               

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Method that manages transactions initiated by AHB master.
   */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_master_to_bus(uvm_phase phase);
`else
  extern protected task consume_xact_from_master_to_bus();
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to AHB slave.
   */
`ifdef SVT_UVM_TECHNOLOGY   
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_bus_to_slave(uvm_phase phase);
`else
  extern protected task consume_xact_from_bus_to_slave();
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

/** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** 
    * Called when a new transaction initiated by an AHB master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
    * Called when a new transaction initiated by an AHB bus to an AHB slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);
  
  /**
    * Called after a transaction initiated by an AHB master to AHB bus is received by
    * the system monitor 
    * This method issues the <i>new_master_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
    * Called after a transaction initiated by an AHB bus to an AHB slave is received by
    * the system monitor 
    * This method issues the <i>new_slave_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_slave_transaction_received_cb_exec(svt_ahb_slave_transaction xact);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * @param master_id Master port id which got grant.
    */
  extern virtual function void master_got_hgrant(int master_id);

  /** 
    * Called when atleast one of the masters request for bus access.
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual function void master_asserted_hbusreq(int master_id);

  /** 
    * Called when atleast one of the slaves gets selected.
    * @param slave_id Slave port id which got selected.
    */
  extern virtual function void slave_got_selected(int slave_id);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * This method issues the <i>master_got_hgrant</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id);  

  /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param slave_id Slave port id which got selected.
    */
  extern virtual task slave_got_selected_cb_exec(int slave_id);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual protected function void pre_check_execute(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * This method issues the <i>pre_check_execute</i> callback using the
    * `uvm_do_callbacks macro.
    * 
    * Overriding implementations in extended classes must ensure that the callbacks
    * get executed correctly.
    *
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual task pre_check_execute_cb_exec(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** @endcond */


endclass

`protected
=NZHIR7=HM)V94R&#AM8PXD]HJg2\.9U;L<X3>/GA_=V:LAX=F2@0)fE1f@&g40E
E.cBDgE/;4S9@H21&gOA00McBe:R2\T3)C[TR<(&2gCUB,)(GN@>\V=TbWfT:K>&
^c7d/g+@f>]R<W-&[+d(C>[ZTYdeIN\48AZ(TPI5&SWTdRYb4H)g-d49/\Id;eVM
c&OVO+XXGV75Ka)ZN8\BQ@S0+ZVWca:eZ#Q4(P<N1d[G:PYcSH?MC29C4UT[cD4E
S9[,fP86V:B3X8VPTCIKQ2E0/[#AgIU^+WFN^;M5Q?4bDR&e5BgHKC7g><TI&[M0
_-AHDPT_(4#M+<3<Z3OTC-ef<2[8d=1^W)JLWEQYIb&-?-DEA^0V^@MOXf@V[)VVT$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
P@V3IA?8XPd)POO0K.FcgQe#ED4S>81Q[T/(4V;0T2?dW0c6Af#\1(c@7A)]S<SZ
()5J=eJHT2ABD+V(:/HS0XVI;&A()X_CZA?XQ>aSe;_f9fCM0IC;,P=,\?bY,QCV
N)7BRdV2V)66H[fPW(+M[5_+V?0B<8KE?@7MUW;)LZ:\8>85;@7gFe,9\QU\5(@R
&63?D&KK4eC_?H98?PA20#]aN7g./Pg8_Z,Z1TeJVLd]X3@cY76#/V1e];e7F1DU
;aZE/eZRT1E7g]A8?,&e);55PD_)4(f1_Tg0#b.TA(c#G]NLE&-EaPL?H=Q8E>5R
))E@;gaBX[(V)=27GMHEOcF0_-f)/HW[Z:TFP\HcWPPT)LO910O(SYe,@+W@C@=\
ZD)0HKOTJOG?\c(ASK#D4Gc.0aP5EBNF;RY]18/aabc<IEXGW7+:,F[>-AE8>&IF
072gB0J+P:)4,33B+9GZBA6e>8L:Vd>7JeUA&,R2ZOZ2OT4+AQcO]<;?LQg@0HQK
S>Na/J>TC/E)9-[5X@68KFec0_F+^U9WgefZ&_5G<X#3_fG7a\Ga,+AE8ID<BBJ+
d=LZ&O6.3;)0[K;X.9_=0#\/=JdD5WG,FK>T=-Ae_KY)\1Q2D/N9GbEAcb1:9=W_
f]_\QNDTPM86gVMO+JR5CZ;ccF_4#[6@WG#LAc6@38.8STD0QU6A2XZFbB9:3<9L
O[33b&,:[1J;Y;3N54W_5X8_/B<0[,5b&TH&6ON-:7F,a5D9:OYZ>.]4,@f@U7(<
9)7R=9EXd^V>Z(6.EZa]G799@bU\?QE?EO<72TM4>?afFKXFg3d\)PQ9^>=\O#?6
[#8FIb&&NTI(M?6E;.4.3JX;=(N3Q9:ECH6b#1C]6>.:d8F6HTK,L9BG.,gSUc+;
A/Z;5P9cP=HJ>4+N&3W.1dIIRb[9,:0,:TBQ^f)MYea8AFFf/R]EC&dL6<2JgZ3f
XcIZ,KcY>b3</0f=df0;5f]L)R^R1T><b5);+:]SF<4,<BWFFSKEK;&64&@Ag^8<
Qc7#W]3ROf@I[O-OW^[>-CWEA1-3Y=.^1>?..4\RS9Y@=N-5164B3NA?7OEF/@=&
eC11Z8)5W?4;.RCSa#1c[H;McF1U.[SPK=OgF[1^M+Ub5BG7<3g5Q[L7+dWTWN\W
g5\P\e-9>KI8ESZIY-5T9_^;g=VW7TSHD6\DaJe^<bIa.5<NDUEOa-9Z6Y]dZf9\
S95e0(>R6PWU@-]\?bFO@I\/;8GLg/F;Z05&\cF^;R5NTCYT[a(a8GT1ga>(+2Mc
daE6S1XT7LE5@#XT(B@O7eP7FK-JUTK)<8).-f5W/&I&OQ5,U98+:^^;ETbYO&?8
Z;>R(2cLd)e#QK>YU&8L4ULf=,e/a24ZC?fg9^Q,?:[3#F6M[Q3RR]J0QD4ZDg)Q
Vf_.ZNVTH3?D-?3/@\2VDggX[Ec4Lg#C(KM06#_0EPOH[^(c\FJd4gaEC1]W.IA_
f&5&6_1WO5H:G]9DG3B.D;R=3)#2F#P=&N:B@_T^Y6S3(7YbPHW56;)@V&9:1(U-
-DVSSF5V@0ZL:?e)0YC<ESWHX[-Nc5JYdD4gRL,@bZ^CFT7d/gZ)A(\D-d\EA?G2
\\<K?/JNd=,RfJbe#38,YKWZZ7LG.dK&^bG=bG_YCR;((f[5JHYe.TC\QHC,8c?R
8N,B6gI:TgP2-R]Kc1KK8==AFe(YeLSFA9b@&KD=(CQ22Z:7&ZD>4e4Ze+Hb6<XP
0>[;@FZ+V<@^W0Q&/O-F8Kd9?B<OM1[CDR,e0?]2YH9QK+?f/K#\14;31;PADQE;
,_+AZK7J:gfMg-bgCQLHd]_a6NMM7HQL:05O6GOT:YT-1Xa23M6[WK/G+:2]R<+g
)(SPHE:EGN[9I@1,IX0e.8+egK/7CS:d9D[7>2[@,/]J4[IfPH=RB2B5J&I.^IW/
ABD/)?a/V@Y[N9,=8A-9V1[f3@d5V+bT:_RYZf)#g-8Vc=LPae&);3PASd_W2HW6
V2J=:_5([ZJf/L4C30LX_JB?9bU@a88DU1AE)B)S),NIGc6W__-XQLE[f5MdYD_?
33I0=+)]MP_0;E^+<RCN0THJ\.R_GT/6LDCW)EP3K:D>FUb5cXIO-g,_\7:SX6;d
NCQ+^CcEaQd@c9SFN7E-G8;SKZ8G?5MYKD66+ROG6R#K<5#;,#9UH2(GgCeQS3A6
f<A7ULWc,a=5265M5>0ZOB_;4E09Wg#dB8C/YYS=<0gG-0>QWf9:aaR(^N(_<f0=
fW5(1G0Hf\@J>G3SZ0+CA#HC,TS&SC_T42OY<R@bS^E@^RPQQ=UU9)T0JM.a6+.E
DD^_JVL)\E/&_SJ>>;SJb&gEbTH-X25dH#8GGI^<c7?W67LP_9DZ5U><BY)V(82@
];VO>2bB,^N:#,,LEV]S9?Q5)#O;_\K82(QBJL50NgU4E^H5cO2ZDT5>3=SI&.C)
JJR(N?N=f0#_:\=KRK@&9deUL^/9WeG<P[cc_@ECQ2:D@O#-fNN&e-/8VI2DX[#O
69MUI#Bc-[e.X;H_2N8FW5HD@W#4gDI2:H@V8E(-bbB_CL^66dIQ7H<0:_7=4]8#
7PZ4A5cDFLa24V-c+?\LHBKG&GKH:G2>E]>7NMSFT^T>5]TAD,DLE<=1d2&?;TTG
8&+cVVdN5EJZ-Jc[cbRS09EXg6?4=c],Z9b#K?J0cCOKFb;N:)Gg:V=T[T0,>a28
ZGd7.[[]EO(VaPK>2/=DI3DO:L9IC(T#0@8J/I7/J=V<\J=8OBP/NPI&7;IeHJe&
^4QN78\B@?1_<2FPWN/2MYNO7<\AddBd7;2E:\7<&JH5=A[c,<=+=-:/2e[f1L5&
1>/?aKKI8MJ42J\,,=+ZJG1;]#.-)M3L/36KA7V5J0<^?IS3ZBOM<dZ[UG?d+6KJ
1RA6G_JOAe4D[@,CgOXL),&^UYTPaW?\\V2:c(VUZ[FU8/U8fdNN=?E1T116&cXQ
<_;Y:YVg-d6CaGbS=QFNR7/S7b<OPYEYaF7FHWU#.e_CVVSd,>7Ka1#(aZ=[A]E(
b)0BN_JEd8:_ee+bP]+^Z@QMEFWMM7Z9Oc/2.ABfN59,P#<2-EOTa_S_/Q?g=HT<
/<3&ERDfJZ>)ADcCB/WJLA_/OXU[9Y+9LTX?];T/=5GGQZBQ764(?fLE(<#N53c0
RJVU#6BbY;AdAKIe28-&&B14eQ^ARXgA0)ES1)XIPB2bfM<fM40&aBV#7KSJE0N,
+#N>]T[gf-5Z,d30BBGdfUSgE&Pb5A^RXc\PY,1?FOf.HJ5JL[,_PJQ<ST(2(WH6
894(GNWc&W3IDR#T9;>[=C6W)?EK7(V[T<F8Ee/-cPM?VY.&XTeT;HBY<:.0gDR)
>#C59SM+<WILP=OK>GK6A?gXCUR^2BNRC#N^JA5S^;[Ge(bR@_L9[)bGXP@.T>3B
/FQ?.1e\[c=X]gPfAK@O9:5IJH-JeFUP+#R7:(;7?U&B)>888SbBUCW0Gf@g37:d
_RFX2J10OS<.)M?EXT@a>F#KdWJ4MYTWeH<_ZEM:,,)7IH8f.,a^<;b3YBM[9)(Z
3=\V+cDH@P+/Y7&TY,gCfY:FJce-;WV7)Z#V5Rc8@>d7^,6,\8a:JY0=;9V]\?XE
?SL.A:-8UR-DS3:U@#fPDI8#bT-\#^Y,\0#@Kc?DBVQ@=g_R@2^4,_d3&UZ)+:CX
VCfIa5b.]F2/@;]>0ON]TF4Y2H)EA@4cd/#f6=dDIH#]+eS+)C8<V=W]4eH7IV.K
fI>_F45K7#G#WCIOQ211[Lfb8PX^X?,X7/DC0Yd_<N49B0V:)d=>[SP\1^/FEd@Z
P57)5a<A=,UWfBSQVIfUJE?c.ZFH[DJ3,cV?W)^H:7+[gK4._X/ECe0A@71U.DXO
fU)[-8&3UHRX0X=NR>^Og:/E1.S=geH(dKa^_=Vb^\:FR/,V^_)=aU[2;;78B;KT
KB=Z;\SaM;cK\2S3@-KQZ279XUF.9Kd?Y[,3)-VW\&DOD0V[+f6Y6ZO:<>6eKXK^
G\30Z0USX@@<Af5N?]c.STUGdZ4G4,^8a&/JNJ/AZ_]cg:,D6GANHQS(JgP+Q+XH
:4(8X)e+g(Ra^.0g#MY^,&VD_V&^K1.=UW](-UX5@(I:T07?K-&Ha.@RPHB7J;,]
6C^)dF2RB^<6g#@,3[b>08QU,E;YTK>U/TebP.8I0>YK]fOFXJ;ZAF9b+C/,96BV
F&=Wb-+KJK<V6X#6afWMMDDf/3ZT-6DH+LP/>;09Q0D)2^1(60ZU@7;88Q0a&V44
.5B782WXSA6PG,QZ;JG#@M5NdaS<@DcH)V>5)N^C[^H=>RA(M]L5FdI:@,])6A.<
O(Cc^CN6caH[5>^OB/)O95-Q]]9B>ed)6S1^R^4g1eLRa3=_9G2T[MHa>RGee(>f
.EO@;#4)0:2Mc]\d7-SFS(ZTU82T:XINVeBWJKY#@(FJM@1QUKGY1XDA4(Y39IVE
f2X</K5\9a4<M(W/Ga&5N&7CMbQ&028=M3_@(J1d2?(ae,2Tgb1R^9_8.@3CRL?f
WBB/</7<5EA20cQ_2b7__Be8Q@fMK2@e:IaR7B;]^:#K>VV>[QSZ>KKV:T3R2GD_
4)1,QF8P)F1;2_)9HF9CUF<WS/:Ta<,>RFZR=_4UF^4:[O>0U[V2[5_^eM[P?^R9
e6Qe8KL&fUNf1BZUC..^\YG1G(69,((5;Y1+;cS^&HP;fe_G]-SJ:G0gAO95NGSV
LU4(cG]Y6GARF9GWR?_?==a1#.0]g?gd^a3fB;#._WDPZF&c69PLZY5U;Xg4(-MF
/8J6J,bGH,D1fOS/g)gJO.(OH5\4ULb]gLHUQ\-,^1<(c_&2\#Bf^eL[=_-Sc&BL
M&Gdcee.aKb9DYJ58UD<KF;MJF(#-^NaJV>#4GMQ[TNJaPH[(B+MF5B7026d2GXT
FJ/N,]CA.c2^>F38^_FD+3LXbd(g06_J@=#2GE(ZHeTLOV5GF@JCS+A83I(AZfD<
CWgVgQ2CSefCLT;Z\6-O9fVH6f=/BVE?S1@[ZL/^9]-G4LcT@+R0RN;NIc5(&db<
M,6\ZAR9Z8U;e\N?5a<YNB&bXdGTeFA([efF-U/()>#f5(YYe-=R_1LO9\\\Y5f=
:fX2eR6L__aH)J[W+45BB6V=c[)>)W,2_Ma4065HR9CJ^QE)2I>gXeg]Q(8,/_D4
O.KM\)]\;<6KccM_NQ>KfYV<<S^J+]Wb>XD+F7QOM;GU^K&S0FZJ0^Q,T1S[^15_
XM2OP=7C=UB>UIg-_WNfIG3&==>5S#cD[[SL<&cAK4cSEO)J/.5_I5e.1+_fbXL4
Y^J293:WG4NARY:eU@03->X.Cg>AfeZSaE&;e7A-6U>cd153)POJFeO)BZ7g35LF
e,(0FO11FecN7F7E\FM8[PfKYV+R3/(GUY(IOA]+>2J.aFaB#7P1A#fb;2?AFgX_
.f),0P6,bQfUa?g2>:=B=F(3Oa5d1\+I26\5M5)0T^6;UP-e:4=04Y&__a:+(6f.
)E7[TSKc^FFc.PI90a<O7(]7[P\cDA-+^e@Ya^5^)#)=Q?Hg#U]c.MU/4Q]bgZb2
ccbXRQ-A5f>ME[c[NMXDW2d2(TIb]P,=GP>#Kae--)8gS^4La1ca=g<9cA[20ES>
JVgI=BL)0:N#d?e;]&f8d.T\DE<CM8E5S[4+2&_5Z68>/3.7\BP0TC,;MdEeK(J,
b2O/RY64PcNHUGI:f)N,QK;VNCYBRT,Y)V6.3e78X9>EAO25,PIcF#=:8=-[<.&M
)7;R,K@MX,H=-_1B==]5+[Q4L^/aLAbQAe.H]0M,BF;XJg[b=O7/<V0RdIIU:J<]
H0F[_RWA3,_GSEF31@;S5XY71Wg(784TL[1cD2TSY>2LBF1FEJ^XQ:BaX=LEO^M;
8bbg\Dgf^M+^aI1BZYc?L3)g?Q?.)dPM,[-Ld)eME7b,-c^?fT7#.K+NONB0NZJ-
.d(N3@_5d-ZU[KWXXU,#M1_:55.?U#5(QD\7#b)LR,TPK4_Ac.HKD:[VF+Z:^f>Q
]KJ>Sg0dRaLZ^A>9AdgQ[;2Z,c[E?#B&0+.1ZE[4aESe<J1QIE>eCdCDDReW7BYI
cJd6dO^Q[U&QJgRIO&Yb\J-FC^\9:5Z&,_&+5TYQ&dSf+=#9fBK0)Xd>7R8.R0W/
KFW?09_bH]/A#-g-Bg<W7RDfg^B<P,0gbB+NN31cAR,fB/&Z7F9.#[0HI;@M.5-f
/4NfOfg0Ue;=CJB8925YXP64#<+U@OTAaOERV^,J2c/b8QY-De<Z_91ZUI^VH\.a
KX6V3H.ZZMb[>V=NfA_3I,&/A),ad:2XO^W4#QI5R3U<X_)bC6_8.^S-a1>E3WZ6
a>QP579[VYG4g\f[F5J@;WO1ILe9BIg<R&bNU-)FPDU)+LdO_<&bYVB2>D&VQJ2.
H;XP1RY<AMEB\[EO0=#0c8Tf-C.]E&XeTY(NCW[QfT@@b]9D&/dO\f6Ra/T_M3?U
7aP-8f9g=TJDeM-](^Pc&cY,b)9JB2_=P24MD#V#f1PNGBX371WUO&U=[YgdJC&2
f@YX>#NZFBKgV#;bWe^)P5HBeLfS_^B=.O+Ob7,aT^GCP&<eI11C/KR:g>_5ST;I
50beEUO(-b>GEZ2YKFPMC?&)RfYTEW96N(A;O674Q-S@YO,2LEWD&c+]^)NF\ZX.
/eC7+6E/0g2cR(,M.53#3a9SF+3N9PeR,;H-_bFMBZ&9[QKJQM@a,.\F;W<-U9Y]
>a(+fbTL:)I?=FDPT]Hf?gPRO?]dQ^Ca68)U]-/\(Y.)6f0\^?Y/IJ^NgZX/MCcW
(,Qb.;,^Y044ZDJDP66gXOB4d<f\HNOL\]-0B?Y6MZ\=F&S.(Q&Ba_,fb2;1H_LP
#c\KV)6?g=)=bP<8[TgF=\<W:/1JBV]]-Offa0R.=QN:@4(7?fc+AB5#SfUR?@V#
5)Q4c\O[R\92A//WcA267Ib8)[d_Q\4&TGG7Qa36U+NZ^NLU]G<APRFaO<GRPFZ/
38/K[]/X/(@6E0X.?(PdJ?\NGMV^K]W5eUH;dZB861f]+[X5GL63YS;adMW7US04
-..NOQIe[S^>9.9D>;__(5.c8aTG0,U(B><ZGUN>g4&,Wf7UVT.JYfKOX:SLa/\6
>H..VgfE3eT0_GL=@YUc=EgNK6\_MUBYF[13HOX3#Dg\[&@OSP4U5>FfY8F;S?DQ
<)J0<B8WAXB5N6]6J-FBPB)5=&&d]<#>Y>43V5VI(/QN&3FCJ_&U#H-1_FWH;XBc
5dZNSa@BNPX,1P[&B@GB1a]_a7eE0PD<,=aRZ78e/A@.-LHWbDAEGNc>#Xga0C;N
JDJ4&JE^]>1e7XeDJ2?)/U^@8P/ZI=[>EdF#?258;F-C8[]]0]=&V:H>S<>-KK6M
H?/;/e<1fZfC^3ABf15ZM2D-<NgZ4_5;K-.V3)+WH>7D7?]/_GS5@7-C^-?0/)HS
,;SYg/b2R9fE]CV-P=JdbZeba8H(dTS16#bcN[[@>]3bG+7EYOQ.>f55Oe;:d<D>
B[><3^c#bHXTdJ<EW(75M4F<<6X=++@<N_UQF:&NU^0R:)J>_VFS^;b;T+]XMWZO
D4=\5NXFR^f5B<\g.ASP1(SBR)geW:7&BQA)d\MC<)-,TGJ-d=:J0+8E[,ReZT6T
KdPHJ7=AQA_DMI:WXY/=B)WA:.aK)g76fN?c:,;)(.YO<Je>1=fGMKbXIABg\)0-
K9[F;AW.0ZAR:aHB#VT_XIO7/W#XQG,NX8LIR/W,#]b>))\eZ+Z]F6Ye0_#-QL1:
9TbP?,aJF3>G>dHH<R[5>dLWe/T2:\34a_W.3f?/R\6/UXY(ZVJ4<P7WV_1.6]O-
>,X6g2_g;2(?:CGG&,,P6e]]c,&M75F>LQ3gD;SOVFA?0]#2FVPY8L95-SJG\CN[
e@g#fLVbAYeN-W>/S2.(4?efCM.)VdO93?M;:Pb7e6)0@1&V&dU/6UD@T63g]N\X
)fJCS=aMZE8015:FXE65cP&#=Pc#,9^_)#1_a[KL:#I(Z6gL#NFJ1[J.[B^J,NUX
^cEEAVUVEA+1@@\HYYWPX-,[9BK);ITZFe<+cCMWCP5YPf;cPB5.7F#H]&d3F9<M
@7(]e4-/<E-00PI0IM\#B^dCZ#b_.Z(89WDG1DT24XM[[4^KZX\[>6BdY2ZYbTFb
fTW)BGO6D,2=5,g=b&K0Og^YU@UO0>#Xe3E5Y,_66+AOK1HMfE6edTTNBC_<@6^E
DaE3OSa29J<TE4(/c@3aKM0/XfAI[g83WaW\WF<JN/VS9F-[?-HgD8)^Ke>LO.P<
,8CQ>-g?H_eB+ZYRQ>g?V/N79Y4+NeePAS5VAWWd<(b3,)b#8)3WG=Pf?^AYD5E]
+-B8/[R:7\.D[e<UAQV]Xf@JeE(7Q^ZY9eUL#.B#Y0d.V366BaQbfZUT^dVN1Rb7
d;T05/5NL2JU,a076GPee?(>_-32OY&EPG>1@E771b&F5>3EP\[;,/:4VE&+WRW;
GP^&c@[#\UIKJU5/[^E\@8#[:R\]f^gL;J?eJ^M(>gEgfe4G2(Qa.ZAbTD4^I;KO
RJNb?;YE@/F;.@JTXfIN6/&6GJB2IPV9R9HEXaSV1fe1UbM\5B@:351aL_\JAC-d
B^IIXg0UQTN?bX.+5_\dY)XHL2NBTG]^#EG1b\8-d,g:@6B=G7Ff^-_4>T-;L4fR
I<)1/#g1^eI0N5#4g8LM)Cg+<Oa+4>][P]7USCD?bNe/VYDa;ObDDDKB+?,a^#aJ
2@TTX>?_cK4M/D.Z0FVRPOXU0M,Ja9;BA\8),G&&@af;8e<H0c?MVZ0FfU(#+O3(
W<^gPN>ZIE.XU<JT9f[E4#_7OH@&W2Ae6D][0\FACE21E^VOa]8#^Z]/M8d4,:)F
V8U,9bLg]3;Rf.aYYGLVXcRU2/T.Nd4.(WES0YER8^)]c(.E.E\/M+Q)KY5dc]g1
N9e?O3X3Fda+X,Z8;FJ#c>8I:^-<(4S4J[0Q)<Q.&857#U\BAR)g:Ya<J+6F-J)+
Egc>(;>U:(6FOWJg>0@2A<S:O8^BNc]3I^,:+3U3ac&Q@JCd7b@.FF;<fH)>Zg92
RdZd,@M\U26?80dU<,ZRGPP>g3MA9SLD:_aB^,UNX=X5>:A)8a[;2\WB3.[=Q&A6
81O7T>GL@V9cIV&BZ1JGS:d\O#>MI:&.8SRLY+(f0Ucf<G1bA^;eePNb1cQ@H]Nc
_;XA&4\S(=c)9E[/GgZONNTXXCZUeCQcO<ZI=#RN.\YHdGS5a1\]HB.>T]=:XZ5P
I4I2fU-P-b(9a8H(Q3B2b+ST+e,5JTeV(bdIc??G8/E(CAa&I/3W>CP06#d6&9R]
Af,#V55+R<8G5L[N.SP;PHP/,PM.+5cLd:ESMQY]\9EQV9U2d46c/f-KVMa+g#0a
<FM#3=,.SHg8HNcNWf83E5T;..KSH4.E@U9V-+&7FQL/.LBAZcAU:eGgJ8?;_,VB
4f8CDML#7>T>#8@PWgNce=80,+Y3#I.;H19)N,YOYSGA9B;;=gFQO&+@]PcTL7>S
CI]1^PIJX[_8KVX@I3,dL3-6CC,+PM@V5C0ULL3WY6L=+bWTL6<1]O/Ca3cC<1XS
0R96dHHKdI3Q]QQOf[(PS,UL(CWZQA@OVZ.8O];>4MNOef#dMd=c:(G0QO8cPe3O
.E==;#P\0b=_L_#X?a7f_F4_6fL/CXEaIDIYbT_4#8a9]-)<b-YIN\XWaMRJ-[N+
bf2,+&gFH>U(ZM-ON(VgKD-Z</[D)Z]H1O+e5)A/-T[+G[1@B_d+PF3eAG/7@IYB
DP_/>KL,]IT]5NT0@8#J79Lf8C+EIZC3T<YJBSV-M)OG@9#a;J@<NN9>Z2&1@7F#
aVe^467(a@60]EVCaEMS0XI1M+BH[;[b<KX2V@#FI=?QK]g0N#T2O;PVCQ?d#FRa
Yc\d1L/fLNd/a_9V<;DR&G>WS@+EI;EbVgNdcHd,;(OJZ6]UIgTa_[_&:(=6T3US
be)_5WM]+eF3^WV,+##T9VLa?8Vg&[9U+fLab>1-+S[/?7,Ccf:0[ee\<O^YJ;,M
NRUGB8B/XW>6]7QG5\:&39NNKU;:>eaWL=<_=_H9MJ8b3;Sa[_.[_@f\791&Idb&
-gB7c3GSOBV.L(bgZU,EARL24WcSG#3BEZLFQ#&f503P[AW?9SRALYJ[eV8L)T9.
KQQL:K=[6<C=M\<a)ARDV#Wd=>.+0>1cEOeWJN^[;+>_O3RN\c6Fg@gW3^+S(YEg
H9O:Xb,7a14K+B@f.K(gbee,DDKc+/IG5?Y#JU=KT\316>MC>OYA0H=:)&LKV/QM
f;c0NXEN6#D+_563W6#M78M>G9>_OEVE<a3C7I94;[EZ:HNMDWB,?;-R?ZETE-G8
0&E5.1G83I0F_@JF6f;F1_gH9#@B/<4d?-=<@gU/F-41;@3B33+<Gg>Y>aBXAFY_
9T[:Zg<:\WXQ>CU>/BL/WR@<AIfb?/XDP2./#AM5Q0f4HS.P/(<5>#9Hf-eSWb4>
I?75JOb,)U5bf]Ye[LH/a&2R]H3-cNQ2SL6B[J+CXS)TAcHGF=d<@U.&CJU2fYZC
Mf9QQ)N>T1D??>6IN4];2XT26@d)IC,RA7XODM0<])H?)/](B;cM)[[RR+55A0TD
\9JFH5\F-\8IXK8#6&4.aM?#IaXUM<g9E5B0[>E1HA^,ad\fOF6IJUG]c\B1=4Mg
&Q5:DJJCb;9;0eOPVB9bODX];Q1BG>92DT?RUR0^cUgA+[7NW-TA.I\A4=EM]9+_
4e9E_0Jb]AggU<0/C;[XZXd=1],5B^UQX46F-)&<J(-W_I1e>=H)gF_2(A#QF_7K
D=26Sgg-^P.9a17F-7>S+&S;>/f43/[+04EPIQ&A8@@Xa8-b1e<R/CTF,gCW;:Ag
:P7Jfa6E>-/,bGF)0.@)TeR)@&\g;55#)>0eW3;FKD#.VF[Jd@O(3H#1GWHDA=4X
(8E+dJ3EE8F&T@U4=T1UUPRD/bPP)^2Hc3-04PD>HI+F^F&gD+F3e?7PF[X8?:eg
a+c4d6F)K/JO\ACCP(6KT]OU0a^C0+6NTM_;B+&UOEK8C+4<B#=E#88N)ZMGLfL(
@\S5#O[0[,Q]TN>b9]HY@FGaUF-\IRRc9dc9.-9MCKBA]G^.CTcF&aN6I698G80-
BICdOZP?,RLM>,Yf_W7M()@\7BIY@V=QQ=EQ4]MUI3D0;d@\2[K8e]5e]][<Jb>T
_E=D32YRT=P,<,NedXAeg4KY1:C#T&ZA>(NgPG9F0V,H@#3IIYWHDXbKXAK&19:,
M=?];c^)WYJ:9(SW=+;A.S-Vaa+?M#@T\4W/=D?23M?a3]]g\1c2==3.S)(f;[O,
2>0[I_Za_>#EKI+a\3\V#/+A8ZIa:#cMdHJc13XMGQ9U89>L+H_U05V2Ae,8_XK:
,]QTC_,^(ZQA8)G+(5CT]DWD/HTe7a[)?5F_.9[dM5T?/)F3UQZ12G=IZ9L,I\UY
6EO]X0OM\^H2YdOA;OS(I.>LY[>^>64+3M7,GQ9&cXKFPLJT\CBB.Na?GE:LT-2X
YC&(cTCZX9+VE)_&6<B-#)QK.,HGSHP8,,O<8WYY@fB)?Q1Mg4NT.;12M5VG^D^H
+a+.f(3]Z7fY#+>-^f9^78./[Y/(E8f13VJZH0)E^(2;P(T(J7f.E-Q12)fV<T8Y
B&5ZLIN7O=+G5,X:D;>-3E1cA_IdDe;W9[SPPfGYVN),=McgPK/4\^H<E_4;>PVf
,IIW92L]3<;#8.[^Ebg&?d^&SI?+&XMRXKF;:Ig/c++f@ZE9]&]>[CMN07QUO+eU
;/Z_V3R9Q3#M[=[.U0gK=YI89HKOgQSIgPbQ1#(8V1#YR\ZUWR,MA0Gd,F90/[[O
=PeWg5-g;N8-/XDZ+NfY29#],NOP9H(D/O5,Q:=WYfeAT(BW,\dYfK7H+2(\3(8#
Q[,Y1NeF4c4H7UM#4VS90];E+XJWAaUNS;<\-#^&IQ(CP6V7cbM(?A2B:S^FMGPY
?e5BG7UN0cU,0fEg?&6^J(5>>cAO.S9.Fb-7L9U)DdAV\f-&M\&P&?geS)SSZV<M
1UX]ddGU4c6Ucge/;86(G027W&7(]W]EO[V=Z].23e8^aGWU0ge_V,J?<.g]b,Cd
3@&.Q4?BC]b/a=M8R4ME]4@[H-AQ=SV3Na9VP=FISgD4IEV9V&S4-<FOK.B2dZfQ
7K3Q3):MZ(V-P=<Z)+0B.0O7\IXaeWd?gG&A;9,SA<c&KKJ^G=D,6ZG^<W81^GY#
?-@+)H857^6.@Uca3E4G#e2OC@OcJ=,W6[^^\4V@_YMPA#G^a[KGV&cWd1+<gLRT
<T.+EY^AEU@<Ad0c5HSU(R1dLVX/cCGCR97<@B05[=:.C/-QHBW^Z#AJ]G4P,WYR
D)G]C/YL,.+_HJf9b[K:,>?U-1KCU[3]?(b4EaGU;71HII5QKU8F[3HA>,.)dXe8
M=#UY1-XMBKLLT&/_,95.BdY2&_NOVMZC:8=YQdV#A,,PK2WDd2YMH3]G^70XRUK
HT(@?d):+C@2EYc5[AMc@?>aYI0V[J9e\VUU=<//AQAaMCRBV71TgMV4.d9eO)GU
a-:2PU,KT9@5G/?OfcB#5,SgNE44d0M_WAVW9YfWP+GM5H4197ZBe@^:DV0]G=TW
CKT&N&98Q:Bd:30)a/>@B_&J;]ab;Z_JbGF4bP]+?ASZGX(/3b6274>(MNG/B=E)
cX&J_OH/GYbZ/=b^?6=XQH:P#B<eH.(0BS>TG>1(C_,87&RH#9[2[41SL>),P(+>
Ie>^\STMNeb5ED8a_=JcdZK?f<NR3?e=Z^+K63N2JdJB[KDQC.E_RaQT72Q?H5FC
T<#-aa;/D+8G5g[CVJcdKV6716#P2a2F0]@23,5g&7UA;8NY5Z@8\]gHGO9^1O\c
^WJ#U#7Y8^AI..1QDJ;59QHbA/KT&L2,>ZYNfBF>I0^a0E)M\EgQ,JG4:<c3[\^_
OY<(=@9A[4.Ya(RF7LSX#D)I?8H[Rg;+bPI:Gb([479BMN\B86(7=)JVXT:8e\&>
7cW7?B69=fS4GF,BV5^c[>+=UfXFg08S81B+HY7/4(YOCLa06N;;5NXKZI1(a:Z9
eJfQP+-e--@-1eWMeJFf:U\F^FBD,6dYF1QA.?5E[gGK;^f#K]WFH+S]GH7507XG
/[?=[P?b;f]UB^:PLMW5#8L\Q4?W5C<?7@a9e=cV-8>JIN\&4C>(Q]KffKeM/H-e
]GgdD3A,9EP(aJ5fBXFX<C/N4ORNOU?ggGP]DSeb[?7;HSJ(g)RcCCJ#a#9S-U+P
G46eFL0g_A^dfI3PZbU9]VK_(9.8TL\+56d3FCY_1@^B?33/.)GCFaA;RI#GSKe8
]E&/I:##AC)4R7,_Y##06C&RPSUc7C;UP\e9KZCdNARJ+:(XFDc4EKaRHUB::Ef?
9g:U#:)TdfMW_7(-8T+gV9_X5+O)gV2d45M15[TAIaVKM-KOc#U@#8</^DM^ULDD
?N_@LZP\YLP1)/VU5Se=72HH5L8;H47P:NN]OCD>gX_b,ca(K_<J<U.RU#^DgW@g
O6E4<+O5\a2^b7M:/ZOG_4OfDVU8\g]#ROLR;F3)J/I<HEg)ZV?c[NYa^4@dEYHe
NU959FXG&CdH-DN/H:P,2dQ2,E4KP52L.a43P?^68YYLG&J/Wg.AeY_+O>]#(Ea@
A[bP>::IB^4^X3.\d(e:CPYcW(V4H&bL]2WU/4U7&#?EN530Te,b:5:9Y_J/\/?a
bQ_cU+aVPYH-B=IP^<7C:7XSHU8&[>9RG4bA=1b=IedM8Qf]<L?T^aL#^_H,PJ8f
f:_2=>aCLgV3G35;d8XX=G>G,L1;4-cg,T-6fLLO@T].9+<\IG]:f^>c(CY+=[_R
4L=MbU1.,E>MT8dN<;3g##V=XN7AB@M.Sb53<fWAb16#M(CI[C:;;UAc)D>[3M5+
O0-dag&,dK0TI5_9C3^f=R[IUT9V#U5@[5N]^B(X7J[T8QS=,ZY>9[KE,VJ?d9JL
-,=Z);]aGG6B1[5(T0&@2W5g?O4e)YTeeJad6;Wg]Q(g7Q^#_J[ON4:6VWQ0^[TW
[DFR]BLO)c29T(<Z,5aHba5g8$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


