
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV
  `define GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV
typedef class svt_ahb_system_monitor_callback;
  typedef class svt_ahb_master_transaction;  
  // =============================================================================
  /**
   * This class is System Monitor that implements an AHB system_checker
   * component.  The system monitor observes transactions across the ports of a
   * AHB bus and performs checks between the transactions of these ports. It does
   * not perform port level checks which are done by the checkers of each
   * master/slave group connected to a port.  
   */

class svt_ahb_system_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Channel through which checker gets transactions initiated from masters to BUS
   */
  svt_ahb_master_transaction_channel mstr_to_bus_xact_chan;

  /**
   * Channel through which checker gets transactions initiated from BUS to slaves 
   */
  svt_ahb_transaction_channel bus_to_slave_xact_chan;



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
  local bit       received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit       received_slave_xacts  = 1'b0;
  
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
   * 
   * @param mstr_to_bus_xact_chan Channel through which transactions from masters to
   * bus are put. These transactions will be exercised by system checker.
   * 
   * @param bus_to_slave_xact_chan Channel through which transactions from slaves to
   * bus are put. These transactions will be exercised by system checker.
   */
  extern function new(svt_ahb_system_configuration cfg,
                      svt_ahb_master_transaction_channel mstr_to_bus_xact_chan,
                      svt_ahb_transaction_channel bus_to_slave_xact_chan,
                      vmm_object parent = null);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Reports transactions monitored */
  extern virtual function void report_ph();

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

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by master.
   */
  extern protected task consume_xact_from_master_to_bus();

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to slave.
   */
  extern protected task consume_xact_from_bus_to_slave();

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

  /** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Called when a new transaction initiated by a master is observed on the port 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
   * Called when a new transaction initiated by an AHB bus to a slave is observed on the port 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);

  /**
   * Called after a transaction initiated by a master is received by
   * the system monitor 
   * This method issues the <i>new_master_transaction_received</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
   * Called after a transaction initiated by an AHB bus to slave is received by
   * the system monitor 
   * This method issues the <i>new_slave_transaction_received</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
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
    * `vmm_callback macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `vmm_callback macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id); 

 /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `vmm_callback macro. Overriding implementations in extended classes must
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
E4P,/Hd;KFc(6\VIc)(/9\c)41P71fW4D-VCW)J7TTXHV;YVCYTW.)(2JV&2_\^-
908WSR_:d+9H[TA#K]A6U[c8P>)BQff92aGgHE&cDgGMRQRXXS0GG.1U5BI.]/dC
f#5]O;=c</SC3LF;.c>PcMMC)ZeC^;BV&)G2JJaACS@-)2]Pa:E\dYeB=^AcfDWY
4L2VB+SZ^)WQZ>IYQ;WWB-\NJ6g^&+;M@F)E;\8M/Ne+#>)0Z63]15=X?7L^J^L-
,,UC#GgU3<.O>GE9/,H0#59P7K+]40I317C___\-ZZ.[MO.SJ3ZaN/PLN(D/gL<Q
_d+O?55DZ+943B((VRPBHc\bScIMeHB#?8.S\Nee0^[cAa[fEV&65FW-WM<F=.TY
8@8FXKKaJ^Z.Y-(F]A6ZZH;[)Q@c:PDdWcY<<MYR]8eU^)N+5&.?4d_\=T?,2P4^
ZM3]TUM1e#f4D>e:C&WcFF50Q4aR4NW704P3g)Ff2J6\36PGJ49&R;L8Q9D-Ye^)
dR?_P#[L_G^9A;F2B)bdSOUbSF<aC=L.QgFI3BU3feT4aMZ=@/I?KBTT)@\f=faQ
39WeL6(>3E<WY00W(^de+:9=R.,AZ(\1QdfVG<:=EN@A1L9),]\/A/.dUSO?:QIP
N5(,VdafgB<TLV.)K?OJOB(@?JC0McN.58,EY;8,Z?B-^VULaD4DD,eZI2S71W:6
/SCQWH=8,^7Kc9Na:Vc23LS/&T,?A^W(CO[L^R06R:82&^Qe_UG9]??/g?SU&3]g
:S6915W8&Wa2J.cfe.5Z)/ZeTX,3,XFI6C_))JEUC4G5g1Z.aW,b-HT_RQ88a;)@
3eKBR;CMQTJF8[MCGY@9UcU-_YFA.80\9_f)3/VbW,dGS^HO)#P62fL4IB-6CbQP
EIcab#VBKP@N(?0FEDP5eO,A/J9VZY;E<9(#<BWRL4=?_FR:aE4E.])]\]LeZTUN
[5Ubb]D_70?-@-XERI+N,&=<HHO5fS&.4M>J:0;]aP?.2_99DU-(bANY7IDO2:UT
A<DEeO;E-@3<4:2(6@:@a.;X<Ig)_E:Oa[>+eJCXZF6@P?JM&Z#P+@FV?BGD\IH6
_@7&a4W,D3W5Z7SCCd;BHFMP>,YA1)6D55<d0(cKfc88JTGJQHO,VAXUUW,+1&B1
>IZK50[[:S=(Q::f@PS-W(&U72[M[;)-47#<a@A\-C_?9P(L\:7PT@KC4ZSe7E=[
G>L^^([9Vg-I5<=eOG+5AYL4-H3MB<Q8TgA5e[L/293K\Y1=[>JFNaCe,(BKZRU>
YbVaI)HE3;P(:e]P-L7046NZX@0?M@CcU#;?@RFd_//_fUB@S7S4<d879SS5^D12
f2Q)A-^Yc[;_a:NP/RC0=-9EPXfKY+[UQV@gVM@>Z):3c:J#g-Ff_6A.Oc7DBc0>
GcFH=+(cGI>aS#C>-AIYKK^c]E:[LbH\)U33Yg+4Bb1O,5TFUZYbUgX[ZF?8:):2
L7NP+\Y:c6DKH?K#H]/>NPZ0=80_Gb&;)MAO+?(2gRA9_LgA3eDAL>3?OaW4#_)?
?:1@eV;<UI2)YO(:1F723FGDL4.4YO4ZCZ#;<SR\Hd6V#9baOF7JCQ?K.CTTX6f#
e0\(228;6SVa)>b>35<bD:GeIT=H<8-d:Q+b;a/3bA?Y7c=>66PU?f=@8:Q#V#RL
.YdKc]]2W<P_0g/g:_Sa]#aD[]6B&=bd(N/>b:WC#PTRWf(EMPXS?,BKgBU5ECg:
S55QCf0(Te\<,?b/_=ONK9,<.MEg@-.#HedgW7U9H\@.eZNQ@#]9_bdBIcfA#YWN
T&F\V\18+a7g=;HWa?7-H(INTB5ecDYNgQ7,U[T;B\Y?fMAMU^f&&N8Lf=K0OD#9
>@e>J\8,-1,TLgHScc@g:/C2e94ef2@g?<,&M5O9D15MW:>@9,V()WeBUe)a4<SL
d0VQR^?IO2_&LDNXNX5P/KW2#cTN,(H2Y9Q/a?8C]49f#R@02#8@E)b7UfO4Z6TY
=3WR0(@4Q.CgQ:.S\,YY]P1>YE3^MQd3)T6)4D)YbO2\PDg1J_1D&[HIda)X?.e#S$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
dK461cOZORb2NQgTY_SK_gf95f3GFA@GbK.H>Ub=UYA?_bI7-dBL+(Q0KYIZ3=GX
bTTBIZTCPgX=KcTT,T@V]RPR<#VJIacf7&OHQ@Q<LX__0Vga]DFd(WDM58JeeedY
)1&a<]FMB7=<f7ME0X??8<P21JNM:JJO8P+;5CR7G>LfSU;-2J<8g&H,E,TI+7]V
aaMAaV8I>O.TL/#f5A^-^_M7E9[^GAL4gNb4MO_,AXaa,PGTKB+a:5OI)?=WI\OI
Wbe(b1+.UZ4KJVe=a-=fG[/J,V65>0VV?J_CSgg/BDBEdf,)U@AS0A[>/&W>_UB,
Yb84_A>=\Ie;H,;DNZAP;6&?;&Y=T.VL:WYE<4_8W5M=A/Z9KGbOQ&R=+>eSe@Z[
]/[Ne.e@DS;UKd=60X3P\S&P(3B.MJC>0FZ8Z1AEXBW6@Y<fF5d;09Z)de4O4(<?
K1>DT:&[]PXZd(8\IV1I12Ff#5,I9?;K-ggGY#,,9@8MUUCTM+:g@9I7e?M?MEGE
BDJGBE+\Q9=R/ND.BI=JVdXK\T\eF&=OZ8?bD3YBJ;+O)c+g8RWT8ZYDe(_e59-=
=\AdA-c0Ve2ZF,LV-HG7AfCfPM0(FK]S>8IgQ#)BJY>[5AJM]Ec6TAB@MP5CXgMB
B^@VS2c46c-e01?9efOR;/5,<B/;,2IL=L[V0/fWd5e@C42(+9g7W76/RU#?gfbB
GML;\PB>W[aG#4YRSTPO-EOAPDYN<4(/]82,cC/8ZNQa18:,UZ[;T/#6bZe<Sb\^
VUVNO+D-Y.:1:R^c-U-<c+II4\L9<RaKE+@&+H<7cG^#\]&7DeMbc)Q0UQO)e[TW
b6]VU8N@2_-T^[b\IM0g^gA@_MO)V:X@65-X6XS6,G-1O.AG2QJ=:1Q)eBMOU)XB
g6S\O)]7M29WHYf#09_=f&I4a=/9-GS>Kfb>H05#e>HUd,F4TBDA.La,;5;0YO+5
3R>M(4]2)^IU5P74aSQ,9c]QS_/WF\8O15J-S&5P]V.dYEG_Y07-(d6&b)9./Z29
/KM0GG]SZZU@@7,K-;b@3,SHZH@I^Hb>95dQH5H)]DI31)6@QSI\(d]EMJ@6@ag3
Fg\FRXH3<M4ZJ&[DLaecGUWYBST<a=SAb\<#XaLQYIHNNF;dJH4@+<](0._bA.eL
#JD+4accZ4]^/9PG8/D#a2DZ3f8P:2NZ7#L&;ZD1Q(O8LM?R91\Bc2O0+<X@IMU/
R^O_46YR7dE@T=Ub,FXKQ_(:dU.+H:MVZ26:D>EW4_@bZ&O_^#2B&<7G2cH>H+\A
N\10(f-Ig\PDVFHVgLJcY>fXcKa?4B=M#^R]3<=VEN&@WI=6LEb62QTb8db9>9E;
FfYdg80RbbQEZHEH?FG>;f_V.&MA+CO_1cF>O^))Y3KXc2\[LKO22&&WWfSSSM6S
EF,C-.WUMJ\b2WJc1V[CB27S3[C.>.V/=WK;@DOMP1AfWG?(NX@(a/A<^^VCa;gX
:@[O<2>1g^T95QG\_b^7(7c+Gd.a<_edSZa((Ue;=#1gfH-<OC1Z8\YVJ,TJ=JG3
.dDO__+)OR0>6ARcF<<6..F:[W5CM[#4[UFE+N[-O:YRN09HV6Zc;AX-S@CGEe[]
^N+W8),D:J=P7K2+:JMT>LfCKD416(bZb6Se;e1Ka0f5(/f9gSbccQEJ+f6C\KA^
1,MPH<D)8<?VNY4d2W03MZT6-=@4EW-H\[f)WMY<ENd4K\fK7_@[2R0;U?Q<>^GQ
\@\eWVJf38SBRCR,L-/F#=QFXFTO?S=c7NE_/>BD^:L/-cOENfK3cc;B9M^#A8@-
QK<VV_9gL]eCIe_e^bJ\?4R]64):VLDD>0Z+^]2D<?gaKcFS9BKGb/874B\^2XL<
VV7)JTA.b7ZR-_#g2-YX_9IR)MNIO^/)gR=ZM/\G=-8>\,2J6J^=>Y<\JY=X=UXX
9OA/2BT:83a7E&Hb,1>JZXWG6I[FV5a]208U/#,3OD5XaI29f&Q@^676Q_S9fZYf
L+D:X]956#3Q\YL3WWb&N(=)Kf@Y&G#WGS>1f)fWM=MR-Tc)Kg@eR:Db+b1)=DaG
4V&FX.E^cZg8g?8AdScP?XG+Z3)2N2(=\@JC[SS#V1\/EW^S(>OIde[32W\/TK2,
CUFK;\JHIbJWQC[^/X[2f:\(KA]UE:;N1:+2H]K6cJ8-WRJ=_/ZdS,(1b);AEc2=
]_eTQQ8TLgVfdO\?YI04N&3[+D8TUa\N-M(K-K+gGKHNE(Ja0[JY6X:EaLDLHW<M
agPEgT)Ga4K6g#<O.UP-?JDXaU:KdX_IM^5+Bacf\a4CEO1Y7f:,X8@>8]VaVPQ^
,g;2[/I55M2#bdL9Ab#L)J+FTV036Ccg1gYZ>?Y@7Z2NE7;<,/,O@bcLHMAB;RA5
<4[JCFeAD5_5,U.JGV/GIX-:NPRRHY7HW,=fRN/Uc?;-1c&N9L8WK(Cd6\f6((gb
OCSWd7Pg4,1P]Hg:3+f>fA&<fU=eg7ABAee0N&J]M<P0][M\U/R(e4RHMQ/3L39B
3^EO:Uf2>BA7>5\2+:UgPG\Dfa&=;XYX->b4=444^;=1[A-I0FUFZP9+J-6Q=2RY
\R298ZXc>?AaO)e;9NcXR(;O(=+361_+^IL8EDF\023UA&dM.D9MU:SXaRDaOM4^
C2PfV&ALXa28Z7aPN-?@6O#.1\D(^S;F0>Y=G=eOO-._6]G:7Qa;<Z8#F3JYTe@#
24.(7DXFLIJ\#H9O9\^E0c?8d_B8,T)e0]LJ\\X=(S0WP@X92H=;N_.9[U)[>1JP
(bN0UfPa(WKZLD?8V/=&_?5QT/ed+]1gMf+gB[#8SeSSCZFd84a]]8?4?6BagQ9(
G>W1LB5d5d9CeE9(GM2^\_518+5WCe<ALZdXTI[]<&#D4U<8[4S<[VUURE+@=Z1I
U-XZ2R)K?G;1<O<+FZVHXQ#DSD-,H7I+?H.FWe^,/-O]]4H<L8F7bS5N2D_FFOBI
XT-K7:#D78MO40>Y5J686S^06@:I@gU@TS3W7eYM4R:I&V=52G(a:5_5>V#3@?fX
=5.ITC@;(EYY+7ODd96eP6FXDH(8<E40:8+_,_#=B6ED)0UR/W>f9^V7S[<HL,VP
6#EY2KdX3gDJ_2>:QbBHF>6CXf+)QGB?.TK;-=V#:UXH(/dN\FS\D3ddPP)AY73,
9.3QdZ]ZVbC9X+G58N8Qd(5BL&Y+/N&8//EaZ;CdW+e8E8QVZ^1=8=d-dH)898WJ
[F4GE5]SU/9N6S>,T-6LKI=CU3FHfF;S4+7=SW?X<dG[)1;84?Q72aR@fcbHXTY<
Q/6_=0^,4VQ5=0X\aP?Y@[<VfU]+TXc[;);bgP_bR:;\E[EICFAZ)JT-7TSB_PCT
DQY-D[GXICYP(@Eb=>LYX6_Y@4YQ6Dd:XC24<dZb.gcZc\ZPKQGgI?\D#8KE8[(?
XH,:EN#3)9-(1P<97U@X]A^0OeEF,6.9(FQ^-JFGB>c[YQZ2D-<f;ZRX1MM-Wg=1
.GeIM\a<,QR51R)3>M^D,,W0U^:C<G\FaW6NIHdAZcg]McN).0;[c&\4J?A?>66C
WRP?>U+Y;G\-E9eKXC:JKA==_^XH;A7K,3V#U0+SEH?A=E+N7dB<Q#dQ=SH)7#@N
7U9SP,=f4^DHX)/QZ7e4IcV75Z4HW##dd]5+H0>OMO)6e-#QM7P?a-g;ZbKJT-;T
1bAfefbC<_[U;KR8+aHIa9S99c0-4OWL,CLD:34,<f3_Z:Kc]9:b>?N42Z@+;JgO
HN:g)4)AE[9?b^0B288YVg\3Wdb)dTYe[&F:641=cI#eJ&.\O#3;6V</Nb)FN;E^
).MRY#B@3T[IZ+(Z+:T7B)V4;J=VO9K\ENIAg#fEL8.)OSVU43H&W99cO?OK\-b+
_TIKSL<db:dR>gJ#Z?FKe/@(dVE]/B9P]Y2_2f:=2g<S10/?N\Sc<9:>f\N[X<,W
:ZGC[8;Q..T.Y,AZXg;IUJ>N+f_F\W)^^@?3N#FZb)J.ALGDG?5fg.XI7fU.>H&9
9^+)_@IgCe#UT)RdJSQe0Y3YadV+Y2&c75a:\+Jd#5WN=9ZL8_&0@#O_dCP[_0f>
SA(DE(H:_GJG)1E<L_8)fH_U=](GK(.76W#P(gJ6ITaAPI@Da+[TaCOg9dG6Lbd_
[N^_Z0a1HS0^KRSL?.GMWS]L8e?8\9YI&EDV&f7)F2];,QYQI<e>>\+]2R.\2<4f
Ha[DZRc,\fTb?]UUO58.X/W1XNZ]T#8f59L.G;SgP\9-PY?>J?ZAAWGOg(ZLK/(<
)]<B8e=E=N[8f#P;Y/60VWE=/Rg\g3\+QIC-^49HeVM+#)F[Y@<c6fb>;LP<8+f_
>eW1cVV=cQ1Q4KQ-,N#]JcIf^OO[Ofa]M#@4;fBH)OS]TKadRbb]MA@43SG?1&PG
gWgRECS-]Q?I#WJBNVPH:EZbV6E4CA#[d@VX3OEQAX?^H=H+Q@(GWN>G42U\R]@c
T21G)Bf-W6KY)<Yd7\?Wf8F1C\C2L;7@>X0JQUP)\7C]aQ@^)2P4HW_]NZTNF^Y>
R8Z7(OJXB58JQPf[;=>cEcagK/I(_(<@50LF=S7>b;]KHQe/Ucb(\Uf=:]]JO^6=
1NEQ<.d3Y8gZbb[V349/X+F<?>/\/8KeWUGdWAbOG5TD<I3/[S.;VVVXLDdD@EWG
c-_[)4Y\#fD@0+IHDX,c\FA+f^NZL8ODC90)dZ^&=[R;gB(Z\DA>bF;.=>DaBJ5^
T8S8=[8Ua/+<a<7V)<<_]+4]QUUK+OU0.T4Q?@=;Q1.7L[M,Y<ae0=)N=(NN@Y_g
ZDG\[@/1d9ISHKeWKA4XGTT(FOS:0@dOb3R\b_O[EK=bC7d^IYM_)2HDV]\6Z[W7
QgcX3N=.#PYT<^.?\IN\<VJBP.N>-OMD]R,+09^Q#+PFd\gAe/65X&Uf0b2bV.JI
5@^KG#DECPNGF7TTFOA7&WH/X]f./&F6#F=3LaB+eQV^O.;150+U>C-U+GR8I-Ob
L<^G>V8HbJ(FN]Rg(aY7Y2SB?ReU+W/:QG]N[5JeK@bAd4L_2S(]+^L=.L>Ue:,;
K^.Z4LG4L23fIC9L7eJ<[49EXM,VKP+bR5A4.f+FP6g)e[dfHE(O7IdGXU8-\DEC
6E,;7;GH@D3\<,=0&.#6ab\Q\Hbb(-]?F>Ig1\X;9B^1.a]e?\--TLSUQDXONOOe
..]WFF&dTR5],(&@5&R=H9R5d4T^<KX9)BMc+5\1<0E3EXN]#O06K7@,1X<eY;.[
YB@LL7MV<Q7;fcC:<)51-3Y4^R<gVfR1QdVgU<?K2[;81B\\aHS]8IXZEV,R5[D[
+TT>MS=?ad5B+F2H.:L:&F)(X6g@b\FDYNcLCX9,J><4GN]Tb^GAK\M7061.)W^U
gD3EI\f@-Ld_[8.BO8_bX176T^1IYB?]b&K0LN9[S^+-1XW8@;1W<N,25JQ;T&fb
N->^029dD7-1R=IeGV?bS[4U]SRe(HXf32B;7d^Vc_Q7T0FB[bWV9I,E+>D<D^0U
LGY9SG;6:]OK/Ve4ITe4JW3?&20;^M[_20QRTL,CG8L-[_(/6aG044@V1V<O.MZb
WF7Y>&Cg>YLc#;,2^.BL^a5g:RKGN(JRFc@F-N,,IZTP;<_3]XJ0M],_=L5K:.b<
?:DW&SM[3,7]-#52f&L)W>A3d/7M63eS1a#/;1(>9DX=T=TEX^a#RQHN.6HI-fJY
.B3/WBDCXHRd\d+F1+BeOIB..F-2?2SET5U>&>_H)^4DV3+U,UVC[=N+/5gYD_(0
5UP[3,U(V,@0JL4C5=2)PTG?9_^G=QF?\01d^=PPI8Te:MCU;CSD@,&D)g<7S6-/
_6B?)J\[a>;L08M5XO67:W&(RY8QFL<WfUOWO,XXNPdM9UBV#._gE<,DQ(MaBaf0
Sd\<KW7\He)TN9?:1A,MMc-O_/-S>g8V?0&]18C8dLU;=)FI.@W.Nc+2Me2LPRDS
?3(&WE8a=:c(FK=.dEX5TMLbL\VJORZcc6K]HF;Fc2[/F7Q]:,U\ZXYAKA&7_IQ.
Z]QeVGD#V@f(KCd\gJMVgKLEdBeHZ0PN)9?7D1LP+&-3EQFOKF?.&_5C=7b#7;3Z
#Q#@PgB(;1]GTRVCA)/47M)39\45P\UC/YFKG3Bc[)[eVMK^cQ(g^f8K:O9W=&SX
Ce/^J\4TG.OHC\2KFMD,1,)P=T1NZYBg#U?HeZXb7)_@AKXU1Le+BYg<2KUd]5;g
JT5<I^MU0@YH&FWUf;G<+e7;PXf<RQIV9)?Wc0SFJg1AV,c/WW@4/?Wa8gFcT2d2
aCFYc=[+b(9-9)a?>BUNOg?7RB311J6HFHDF?bfXLWCc3@JEKDCQaKa6E@-Fbad:
):2+3#6DOR\E-0,;M.W#5(5IdRBRX#]ZWH@W(GH>UF7]0JR&VLJHaeK]FGW;EWJ#
?HSf(]\?=Df:7XW\95PO>LT&^ZIM#\2\M8L2Jaf\RJV>5@&3@/(ANg[VQ>,c9g;[
V2[<<^83KH:/TcFFRdPJ^#GfY8(Y9=c+^;/SF]I^cDEA4W1R2ZMA)//\139+5.4#
+M08#G-KVCE.Ab:(4>]6SK)88CUAI^?39I3gP2?_VHPJ-\2,d;+C_2E03eINCc#:
3U:^,KNZf?HAQCI[M88-2cf.(0-OcM/d^<HGabS;\J1V,gP&MG._dM5.5V(S4@Q;
SL#)-0RGL&;D:\RN3(VL]45:[)8<TF2dUX<;&?#UTbU&6A(5B?[ASg6b_=XfYL]H
@C9,Vba+[BcB7bV^Ja#a7WYd&LE=0KF)&TeDNXZMR1IJ>0:[+dQ77J92O=NdfRJK
.fKA4LJW6HfIP/A0YG:AM4_3B7OTSCK\M-)PK[OefM-G#P#O<6+A5GNbf-HM,#:;
d2:cgPE-P>g.\+(a9^I6N,/M=L\]>Q(>]TC_]7H/.0RW935V7@;a<,BNedI].g1@
Q\<g>+V\D7MW-)V(NH@5XS;HA6Ga5ZK,^0fd-c+9JgTC#/CUe-M,TVDKD&=B3NNC
J[8Q7KGPFWgXE:,Z1ZP[BRdDg\.=W:_d=7#gD\VOII[g0=8bSTDC-Nc/QRgAIW((
-X4B5B4ZMC1_FYf6JX=1Y/PQSONV8OX]\[b16)4:65T/[,A&4DRK/F0Vc7]QW_(d
@YX=O&1+.,UX95^KEdbd_6]A&:fK_I2R<^>F;XE6dCZ48KFJ-ND6>ZT:)J5&R?M:
[OFMH0=g)1;FdG5b1cBC]MgbbUAC=@_,+ZC<(6BO7,,4NDdEJ+4.Lb>X1TNR#>f4
59KH_:QBQYO=4#]S[H[O9K0_&-XU[)<IL[H(]H<>CZ<R7L[N+A5IK\=\5D/I8C:S
#FE7R8U3\I&-dDW<[2U9E6aJW5OXM-Y=AbB1_:F=NOG&c-b=[IS)7MTVF[RQc5[7
PEaC=\\#)c#,ZTW?;-2_0A<=Z@:Ze=:YJbgfEJ98Ke>X+VDd@A2&R41aG^SRN7-c
^A=:^)DAE7OdBd0P\Q_<YCbIaB4:DFUTf:VHENWdO2[>><d5T\Bd+N3bFUJ@N<PX
;FOTTL(Z\9RE?Y^dd87N#ZI/2/VT^Gg=^56..ga0LaMQ=a5NN?XULaa/>@bgOW)g
Z2>8KWJ5;0M)4/_KOR6/Q]XA;M[D?5G[#Fbf=J&OH\DYAY6(d]+d#U@FS3OBg]FV
>-AL44<d)bWF.F,+8:e9bU-D3O+?-GagOC=e<B63@,#?Y?Y-Sge+&)=\IM64,3+C
KVeM/VQ5C3KVRN+@GeC?5b-A4L.M1J.[<aH]g0Z.L>6RE(g4\CMA-gg92UCLNKS<
Z.caS)a3D-AgUTT\]IBCG?[/5WfZX#)0c+;ODNKcTbZG7V^VL,OJ-M_?c/R^aE>U
>_Ba^TebdOH#^Uc<a.3_]+dALbDI9WK2d2QG<+aYQ-F1F_4EAX3cA(:5:D48SA+f
8D3ND<8>I@&d<BYZ@WQQ]KV\/9H861+DFMBX5H?:E4)8g>-J&1WdaD(d3#I(;dLM
FS?bXMe57L/g_C_Gf-P>aU[LO6&a-4XI@OX3g6C(LDVU&5O[M8Q6F=(+L?E=M.;N
GC0QfOSOXN8EV<]-PAINI\d_gUP[5&dLN>VM0Y_Kb.MFD;\RA6O)0KR]1K(YW]LN
TXAX0XI/-Z>O[d6<.::4(GC<2P4a;&0e]L(+0g2UbA><\JMQK-,<XH4T/8]HX4(+
:=JLG(GYgA<ga->4IG^C15K=dMFP2I\D@\1;@(ML,@T9c.>)c_P:L:BWA=4gVA:Q
^HT_G6BUDC@97L@/9a@I_[bK8>b0;P2+?\66O5^SXV.WXb00X<7>T2aKE),71\0X
K?J6,FJY?IMB[b1f4gL=2SPffZb/VCRBde;C(YU&<WIAQ]dDTK/<f[U#d5e/RWZI
+,ZV3&O3H9N)?SY)Jga5KgE)^@&0[[CZK&]9R5Cfb7B_UQd2(;FLL9-E=OBQJ[9@
41_>LNB.8R.e3H;)N]G0O>Q_(QW39AgfWO@8ACHAS@<Z@W_:>VQ[E,eVT7>c50.b
?XQgF\dHGcO8[9PIS>9ZE45K1[YS7PcN?O)GUE7BO:^DR0c=-DZ[dUY1Ac_b&-4;
G:WaO6<Y7SC0>d?NFCJGV[@R7QbDWRcOFGBgEG@JF]?XK7e#G9e-L^0FGcC/g^+M
0I@+1IQc6__87EBR8:(SS9IZE(8S.QQULA#/LCU>8RATNKNb<J,@(ed^.=X-:.YP
X<KLg<FYW#Wfg<_[G(LT;+#KFd>WZ>?Q6TdTBG38YKM1N+KVL6.S)@\-XBB^LL1&
M.DD#HA0TM)3>VCId;VD&+g)L+D10L7K.E2\W?L&ZE?AQE.#FJ_9=4FHU0@]/8g_
OfX.Ec1CdY8cJ;^>c0]@05F@)178<66=<CfC&N=JTB&^K.VK5LTPFNP#]JgR0C=Y
4EQd9MF#2YR?(WA9.BO.^C;]I?X7OBcKK49.\T&<6YCED^??E4N98>\GI?eb>[e2
Z6/d_AUdOb-SZFNNM1JOgab\7Z4CCYfR86bL<X^I&ODU#f=eL]1c6HN3&V5#(-H/
A#=-PBU3GPeU7A(HGCF1?-Y9]12aW[O=YRb#UD(XICKUCbEbdRIb8&U7/S.89Z4^
g):@F5A-_+N:]Kg3<CY[2[aK:a(2WM=#UJgGU=<QWO/:A-ePXO/]cX2O@LV+CMQd
EP\SDcgbT,J2^&/VG2#/6P2?UI?J)gCRU;F^:R@fc6F>5\D.b([G9e7Q[:#3E.H+
Tdcd</Q6.d84cD2Z^><D#YZ==)U<EefNGI]L9;-U]82:R^G5HT3-[1daIb;PWL^O
I6RGN\T)X)TTA-\8P[C)9OHOI/E4?/<Q6O^OddP4@<D@G8POEL3H,WdId^Y#..]U
cZCD^N2M)S1S4Z=)7+_/64bT4=J3\G(UMDff?eZEd.&^2Sf,F^aaY&d5g6[bRgQO
5X;MV[bADU[HWLgK=2fLWF1P+]J,+2X&c(PC;ZL19M#Z[3L:\;KDd+;101>AIO^6
1Q<-aeW7K[JA&_WBAYJb&-#9JG[MA<U(6-OfT;9W+&=-,MecND.FLEFQBN?(a,=g
X&+@0ZBA5C-^IB6cfC#\T3SZHO?;g@ND^b5E#b,5c?:9A&8(2c7P@Y;8F<JSQ/g?
2B)C:f)gE2GTE;f1V1EdSbb)3#4#;=ZAaW&QfDP3I7&D,.Gb9Od-V3^ZDD:9Z60=
+6Z1HbJgC^]Z__7(5ddUgT<g9a&<2e2&1,T.5@PRDV<(b)YMRQU0PHJK.Y3fT(B0
5<^ABZ)W(,>3d,EbdB=,/QY-AFNI<6V@f>ZaPRFL6_]VXO18P)7C9a6)R+K0)9dB
]_a0)665#+7X:#CG3L)(\/@ba-H<<>7=-K+D2f#)-gC#_+)+&S&f@\@Y66g8<I1,
3Z/6W7U8#aLf/)K].d2QU\SQVfQZ]2Z4Y^.0bK4S2SSM]NLX\UW>b8K[VOaZ>X03
>CBc/OO@(4-eHI3<=G.^#:VJ\5)/X.R5b^IN:1TRd75R-Y2W+40@<0.;#B-R-9^>
C+R)ROga/U]4cW83&N1XaCbOWcc,A;5e8PH[K9BJ-gU2T:9KO_75C^#0_M00(R8R
bWZPX,\[S[RU_-VW7NL=RKI@M/b9FY9&0CEdR#SSefJFUefLd)1)0Fg7BeTL-.1]
O(KSZV;fGg+[T8H/5eWbVMYI]DaR2]cWJ-4^XWXKN.J-F>37d[]\NRVJ#TZ8f\<e
9N)UfWP=P]J^J[g8>E1f2aB<HDGVO&GbJ7Ff.1.1gRbHbL:df2H76U(A:&#->G24
-N8K1KMK6_<Jg9M:05L/TBe;J7=f(D^HYA;LCcU@T-WAZ8G]<gTc?S?76YLU^;17
XG9L6;eFMAY\3GD2AB)8)^WF>1),WRc(+\-VOEQe^PGfZZPW2:MFB5R2<C,DDKM>
6SY^Sb/6^_g/X+4dHI_@,8Q<Yb;_-94@K)-P81(T@gA5gS2ZRKeffZ=,]NZ3H5.Q
AF?4a(C?Me-H_U@g&e7&d9UC[KU72Q-X>#)JQSR\4>,0)GD7IF,;La@.;QB0CJ#Z
<+3+S_c74&L+A2S9D)/+a<IYO/HR7)T62WdJ[T11J.NgL;Y0VbPEU-D0(AES-e5F
=XPG=0.g<4ZWGg1BA15fDXc>f.ZeKF?SOJ.=I.V)[(Pd(?FL7CgC)TV:\DI5JJ&L
U.-L&ZT<e5IJ\@D]I_dR_RL6Y6,RJN08Y\=-FPA=.-U?2B++Yc3LR22CI.W1HW99
WR<W26.MYd61F(9A.8Sa1Dad)^OgWGZ[bC1&+bVJP+[.//ga3@e50ccQ[M,F7V8]
:CfDc7K.=[UddMUH;Y(WK.B-Hf0<75[b>1U5KW.QIg2(V70U#_E3ce&W^P]TP?UM
HR8<2,[IAA9?<I@RT7XRQ;FdZXCK=DW,^&0J6H;e3G;4J4Jb,&HLc(GKJ:76X2WL
XbeZ_g)Tc@J]Z,WN&1BLO12@gB\AgLV_63e2I#0;;P4BaJ=GMfd^5VM4d2^.:=IQ
E@08-fZ\4GB[IeYK+f-9:?J.eU:(f)_;_a](</Z;WAW7d=X@?4.b7U]+YCM]4Bd#
&L2aFR:16VJB)Bg]WA_fRDBZe5ZDed745Te(>C+KX98:)ccI^5T4/\7MX766_-5e
>TX/<._@?+P9_D7A0S8^[OE;J-=76?Of2\@I)@?e<)R4eb[F7T.<>JA.(4RNGO[H
P4X+&/UP,R[1E.(-TUL9[FaWNLNE;_KPR@(Y;7MG[E4,Cd(J3gN)ff@&I\<77A6X
VM6e](e,eb\0B\54dYK^OZe-BQHBMLD.]6R=FKXOC4?>&A<&b;OARRSaJ8N+;gU:
E--g93c]&Mf/0a[P)#[b+YfT/4@8)J<M-\Y4B1#.OK-2(25@D(:4+aaIV/1E?(0&
cC=UMCL<f5:bQ#/K&,MFFGJ=)K8S\_WH@A1FC#<@eW7V83NUQ5C>>]DFT?RSAP@I
UEL4#;JOS]P[JP>,&00W@^&^.PA6-@GZTFA8O<e:+=Y<6fA9W6J0J=ACeZ;8VP#M
;Ia=#CY30XKOUKF#Sf8)fSP3H#J&S_f_G>.,UdRI1-@fJ+d/5bIgY4^aeVcNSVLV
)Y:a33OI(BG0X=;T&E8CAQ<]I#fVa@HF?-^8S/Ec_U3QbFWL1)HA;.\(Ua03)_)#
=?0Z2192W+.PR4@1:_/NEDY<1/E^B2Y0SIdSD304FUK@IPHK>)/Q7>N,<EPXS3#:
:ddd9,=ca#I&9K+RAXCSeL[>1VH8RB)+ZI-B:bfM=F,LW>/,U(:2.PL;cY]#^)L#
0\0)@R@,>gS@.\UgR+FK6W+RF^TX,-cUDMLaR+QTM4-T[Y]1?@S=YcL&DfS-@L_8
BR>:RdC3[7,G4)UCZF&fSGF]de?Md/P1WZP5NXJ\H&-\fSM8-fR\@S#PNT<;+0.0
Q[>cK.bOC[J>Be5Y.S.dCSB6RT6C<2O/X\52_<6V>KJ^?N;IICEZMd.W>[I;gJIW
>e1VTAF4&/7ZU7,ACV#fG@We-5)P9KU4GR?>?:_U@W&[C0c+U7\2baB?</;?PC=b
Tb&+(XP-4VDOO]:d<Ja(F6FCA?PE5B&a.Z[Z=35,aJ=O:8POJeW1JNLZREOfB5]W
T<+<(?TE>:5W:NDe;XWZ9TR@;aXEfHAGHD?f=NA#H,R9P)DL+NL&#TX<#-B+BC0F
G8S&6@8\E7O7M1>#JF3Y155+CT37)TT/cDD0g7cVEa-2Z3O2I/Y;MFI>L^WJN)fX
cQ#A.gA_D?]e&?=D).c[Y?I=Q3(eH[N0?2-/A?JM3P7ef5-KN6Dd^G8a)+@BCMFe
G=SLFdT][+1Q=<>O0](46OOF<=WHZQc,:WQbeC5GHPc./XGT9b,d;0UI5^X.Q.,f
@>Z//DGUb0U_H@K3+1@QW\OW>g#8XMc;c8<c3e\<DKe/8ZfX35YeA0,14\=,Y?a1
54>#/@9=C_7L4J5_+IYM.+<cdR#Z(K#O,BMb/6^gR9R3=?_,c(L#CaPcR\<=W?He
]H+M?FP#K>/PcA\F,&RK7AIO)a9,a1@4MBW^g#)?-MZ0)J]?6=UK=g#@ED8bPIH?
78)Hb9J([_93WFLIacCGZMP5RdK?aDQ5[M?+L1XABR(:V5?U-TPFR<\eC7PBBDSC
dLFO+KS5W>Z@+8TOS=SSZ@#IPf.7&b:CD>Q\g4W0SKK>-VPS70<JF[g1_SefOW^VQ$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV


