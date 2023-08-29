
`ifndef GUARD_SVT_APB_MASTER_MONITOR_SV
`define GUARD_SVT_APB_MASTER_MONITOR_SV

typedef class svt_apb_master_monitor_callback;
typedef svt_callbacks#(svt_apb_master_monitor,svt_apb_master_monitor_callback) svt_apb_master_monitor_callback_pool;
// =============================================================================
/**
 * This class is UVM/OVM Monitor that implements an APB system monitor component.
 */
class svt_apb_master_monitor extends svt_monitor#(svt_apb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_master_monitor, svt_apb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  /**
   * Event triggers when the monitor has dected that the transaction has been put
   * on the port interface. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when the monitor detects a completed transaction.
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

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
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_master_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_apb_master_monitor", `SVT_XVM(component) parent = null);

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
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
  /** Report phase execution of the UVM component*/
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void report();
`endif

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
`ifndef SVT_VMM_TECHNOLOGY
  extern virtual protected function void setup_phase(svt_apb_transaction xact);
`endif

 //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern virtual protected function void access_phase(svt_apb_transaction xact);
`endif

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
   * Callback issued to allow the testbench to know the apb state after resert
   * deassertion (IDLE or SETUP or ACCESS)
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
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
   * `svt_xvm_do_callbacks macro.
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
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task setup_phase_cb_exec(svt_apb_transaction xact);


  // ---------------------------------------------------------------------------
  /** 
   * Called when the access phase of a transaction ends
   * 
   * This method issues the <i>access_phase</i> callback using the
   * `svt_xvm_do_callbacks macro.
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
   * `svt_xvm_do_callbacks macro.
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
He;7LCF[.UQb<0T++S)/>fJWYKQ,E.bfQSGVOW[[[8-,RMfe@,N>+)+L35TM[<R/
7G&H[&W<LD45+J>.->7SL:cC5XK&gX#5;H=3F^-8#19>^;DI9+-+>&KAPe8fdF_3
fY\,<RZ,T9A)LIA597a@PE@TRV74d[ag.6[.gJbGJIF;UUH9Pa\KF\.O^LZb[@B>
2&&&5(H\=-?I;>KG_PQO/=J+.ED&;>TUDXW^HQJ_J9;_F#[c?f]HMc-+9>62#^ZD
a5G;565a7A=0F?&0)_S3^AfO)BJ/)#ZFW9dP\0Y=eAWf;?[VO3,,6:[f8_.))X.[
>>ZF;76T(&^/eEWK&c;I.JfO2$
`endprotected


//vcs_lic_vip_protect
  `protected
</#1SDEOVK42)YVeMLeGD\-HAH=Ba@GDReS0TJfZeQH6B+=:Zc\Z((de<3Gb5Q;g
H)[6Y)-]S(,5;[D(?D(Tc+Y?O]LP7bZMW5)cTM9/]cM0G\N]+9beDFb8C7^&/bET
?]0,c)BN,.6AfY)^Nc^F#<0aaI][OB:d3]FH:.K6SOPZ7\&Oe&21F(9^aJ@7a0IM
M8ATCO>W7OM,7@HLf>&3=1Q4ST2KTS8,>VJ#F;+KSUeW<fe)<\QR+/C\1?2[](13
;.TJGL_AJJ0.gL@)Rd(8JU2g&YPTX38dd.+;#OG+XY[E4F.D+d,bBL-D&N9E=-gF
2J^K^K7THP8c3,AM/ONb-K^G?WXcP02[Z8UFXH^48(B3/&eg0)A2c,decd^/)#UK
OILP)5ER/NF(2W))=4Wg6DWLQ[cS:_N6]JV5&FVYBWOFM.N,U2BQY-3J]]5AV<<L
8dF3P40e1EFId.7^#EP@(#4fN@40\\\EI,[W9J21..SKTd1)727VJ831:(aJa;T/
=3;7M7,<Pc#G;fP/)>9f0?^_RcXH&WCS3(fAFUSF=CLHO>g:,?.#5_O&F)LaF[gB
Q0L/QfI)e=ec=/>(87=Z+-<SR7.U+WSO_T/@edXGDS;/a^0S717b[MMLUZ+\9QDK
XdC+A64-\3ScP2G8L_[KWV.NSQUOc.U+E4(;A&,/bU9&^SD7+DggL<T.eSA.M,+S
c9[M(E.KJ2c\L2,8KbG#cA798d[\:P2V.J):&SDfVHM]ABTH.EbOG+75=-0S<.BW
8e:GD3dH)F[_>/=7^gS?^bF]HO]G((A]C:K^=UgKPI\1X)L]+6V>,_(-c_5/:XV^
Be-?G5Fd,A-/HTAH_P2@:.J;GeZ1@JMJ_/@&<633,.?fH0d,XUf1PgIO^aGME4gZ
Q6EH<-aAEO-#17B:A3GW0##E(+9<]V,&bJX6Q(:bPT6#W6N,e#R07TCbLN7F6:DN
B#Z1SdfD;&EXa57Og-)D^TXDFU(b^>^Zd:ZYIA2XAdRb1c/Tb>>XKJ2G=E0(M(I&
=\Lf/H.8LgN_N>F>7=4&=e\W)26bSNKHHP,O,d=_@40:P)XU?R8S<MIURWFcC4+^
7MB5U@P<dI)ZU^K7Vc8,:f<262;>2U&GC.-R0>gV0472R0]T9c8,>+.VM7:2d8[H
TV5/BV7P+3R0I)RNEGS^[M2)>MeG(&C#6,K>.GI2N1QP/E9L.:DW7_e=-=9-S+)R
-f/=cR<\3(PN,(@.<<_P9g-AbRf>f-dGUba2GD]Z+MQ@?OTb&YS>F0dS79aSJQBX
<2d8+&3dRT8M-QP:WH.>W+\4]JfQV>IG.;2<Z8680#L:>:bGF/b#>f4><XcM,bf-
ZceE)Q-ge>ULH0D?;=4[OQ)[OD2eLb;g]Ua)bG#M3DF&C^6MHMLDW-^][VH,&O?c
SU:?]-UM/)SP2W9&a-O&[)BAF=ZK1Z=;MT-JeLOB-<AKQX=4;?N&L2\c1cOAM,Z;
6I=VN,+^aVUBd9C(fBR>3;WB:;gRG?0G)6gc2<7F3CH8#G[fR.+#0(TVW\L_Q#6e
RC?7AG4;I:5ebb5)\Ye=1T:eY_BPK0FN>aHaPA&AgVW/.\dLT?O5gFAK\W?DRY?4
d3VN71_0;:XUD<Oc<]gQ+Y#VC3=:A.KH(L,6\g&bWVEJ4#S(J8fg7ST1;Nd9Vc9:
&ZG83g8/0G?O;]RL6Y&3LE]^I;e:a>^SZEQeCKPLb7#6@O4Q0)W;OU&/OE56_2S_
+<5]E<MU:K@4]c(dJ^L,0Zde(d#^Ad-AR#1-Q5F>(MXG./AX[(ba??L2E]dGPN,7
C(a+\#Z]AO()0,A6IN1d/[.3@2#0@ZER\2PFI]RW(:E4KJ2a;]^U>A@<=;?@:1=f
Lc&.4M(AX)^dfgP7/2,U945;R8+d#KMA#gEd1=9b7e9@28a>@E,;I>V5@CF\O<GQ
I2fLZPW&CP6S?)]QE_)PHM?]G<f:b3</Y4g6cKV&Cg460EB;GD_RE1UIHL;H>_b[
(O?W>4dI^[b3@2;[JTD:Ndg];[6S\-gJ.Aa[.Y@>+<2019#9:#A#C,Dd./>-bERX
1f&QZ_HR7T=^XFG8BQ,eP\<-;^WO:^NQ2J(I)9DI@V/GQPe)=NO@?4>)4_eMgaUC
[[;7)O\0bCA:cPK7dMEY\OERQYT/fMOKEJdgc)F]1Bg.XD^DN=HYA^5\OD#ggb3.
B[[904&-aY\R\,N##2J5cRT1WO#C_AN9E\7I6W3Z_/8cVcZZOT2495F,?_D_BBYM
d9A,Td^/Ee?9^#gE:IS=^^5Kb)P],<#cd\K)Z\03L#9a^0_D+;B32V@Oc:Y38)@Q
<VH?X>EIFA?^CQ[>=G,O3WC)a&NeN2\<GBZ9J0MU3K()dfI]:8D9:FST+=bS/@8B
<I9cQT@Y[P5QT<9b8MZTKT+a7\gY-9UTUK8Y#c08d0XE\dg]aS^Wf=<f56<YV1UQ
bDK=R(]f8GI=A6/TXBCI+6+._]I#V8UI)\56d^#4;Y)(K\JNfAAB6[=Rb?]b1_1_
PL1D@Og9=C#QTeVKTT>I?/?&:/>6.]FZ7b.gM4Z:@UL:_?T0G.O?X_\DEe-3:3VX
>J[Z?SL)7V+M-E,5W6Nb>1Lac/?aeEEC#9+4\QH)HK/d:aSP2B&EMeUPH,&#26+c
K-Ie/CRE^ZC8SL(DSL02RNQJDf&bIT#2HT<D>.6gNRE^(1a+8A(&/SD6?SI[28(/
TZ=:\RXV^4I>,4Ya1g9,d^6YP8\#[?>De&d/OAN.M=KVcK--ae[B+B)?)&g+;+IU
f5T.C/gJ8Cc9JWVYN/48eDFG&FLFZTN)#:RXP+B3M1[#JD[HC87c/Xd;V[aJ<:A=
ON[PeP?@>e?KUV?RK<SHN4]Cb?YCcVP>7U:DLdJ.UT>a]@bZ(L:H&ZaNGeb+CffL
T]TU+3I21C5(F#4a7b@>M@BUZC\L=E(>gIg:3#gaZ62T;.BNUS<aIH,fO.8Y61YJ
[\4(=[C_=G,f)Ge@(/\g9Q#WS<gFTY#Y]?Z0cM1;1->@UOIg<_A,;IWB3:8H.9fS
[(.47C[SDD<S&XBTT+C]TYfad=<SA(dWB;d=CF3P?>3AYbPY7Eg[CG5X^NYbYaM)
]4A3^6N9Q,g37C?U/F@OA7C[(c.]\Ng;Mfc4;V+UR[c-U-\(=W0=SVGae@Q9WKb,
5bF5VZRG:MQDKAQ,DaJe;L_PAA;JF8D3=##Z1QCM@9@R6+=5]-OV?:C?FFH6IU;6
Y7<d^9a]5.8/8\K<G#W&g_dg[_XHBR2\:K96N>\?(37>P5T(RbaO4d.b/aOF_D-?
,N@A(&NUa=f4H^VBRV#&_Z?V3<B?WfK9^+&2\H6ZT8:d7.3Hc2>.T\J1U>6.cGAR
IBAd6-3d=Y;eHECOS8:>2[L<]8KV7;g0,EHL^YM@55fdJGCRg(;LN]Ab0.N,Z1K1
K0MD9RJOa;W9:OW)GOPWEVE6CK3PSK6aR^R@FG(C.NHL]9Z(+]UM2SZUeX-S>JEV
O6Y^gFC6G269YKM,C;A^QH+MKM]+1d7T[\-2/YD@#4W/8+RQFJR?JJVI9b-FPQ?(
9[-]dCB4VPc(V_cXCV<G\R_60?TFXHag.Vb?J&FNG1?F5G5a#&dP_IP/AALOP2:8
@8[a#F_T0#cSe92?Xe=ARJgBcVa:#E/e<A.0Sg^a83;ZNH5]:EMKC>d]?Dfa.>3a
K)Q=:c?,LSdX5gA/M(B\.HZ?2<A@O\&(=9&1^SM,-\P)(WcLX0[c^)]GH/_\@2=N
?[FceCX,6YBe#3QJ49/G9TM6df.52]FJNA(-?DWMW;d>.Uc.2V7T+#:Kc6a1cQID
d_0CUg9,^[YD5,#ASIHgQS<YV>^Y-=JVQ:W<8C=f[M@,fT@Qa[C454=aXHfI@Ud,
;G^@Eg@C#;UeD9=>YBNYJMMLdT)I?e4(KZW5M8?JGH.NdY2[:V8TW#(EOKJXD\+7
TYg>.gHSK\a:<)<XP\W-0OCHf-IQgI)>[V/U)N#A?/)WFeMfDOACaf;ba\734D/D
(5KR<EfFJ9#INUW9bWTg+?@a/N9AP(4[A/7^5c8H).+_MY(ICRS+P=f7,9YB40L4
0Y:IR#>@Re/_f><&H8O9PI&ROKLSKRS5>@UJWYLQ#,]QGN8V0H>2V>2aK&J:<1IJ
b3[;^@_R=beK,M\@LO5KW29X4cW620[.0RNMI]NHdS/_CZ9L^\7NC)bfcC0=IOUL
c:LE+.OJdbDM2ZFO\^]]Oc/1Ed>F,e&#JfC929EG\]+F86>&VML=^U8K<HRMTTXG
GE(PW?>McgDJTH6PY(>+RI47^JD#A<[/&5\D<R8B#GQP4@b>KWMC\_53^[>_NfZ>
5ASf2F#:CRI0#9:Y?45\Fdc&Mda:DA@1[NL092:J.I0ba^8-68REE]S8GFLDc4_W
WC]Q+6\<G;0A(;9>>Ja7cbP05>9>H:5fb>S?]HC)OK04Hb-aNSY-<E?/-6<7W8c>
:16U2KN1=F&1gG-]4#RGc?KJ/M2eH[TO<,4VGI;18:a.R^+;BATE@9O\R]G,BK2#
>V3V3Qe6]0Kc)O6[)V\NQ_8]96^86dJZV[:2=IddTD9@+1[4<5]8>N\PYWQfOXgD
Q0Kc)=8E^)PRT.U=HQ&(XV1QF:\8OdeZfeC.9cEQN.Ec^K;FVNXIJ63Xc,f5:082
@TI+1+_#-,aM[(.X3bY=BfT0=0?+U329EB)OF0SJ=)K#Nc&)VG=Jb30Y+9(UW>;V
BJJ(8\5;4A\c=7IX&B@.[gH1##814H1DBSV/KN#J,BeXP_:^^/F]8_6GVJ_GEf,a
b+5&#O(R>Z]&V=ESJObRVN9&V5Y:+EF4g2P\0>VR</b[a(.#+YG]O6RX3JfTAdI0
F#aMR-)F(UHQ(LRUb4J?\#FI9cS-RWB63B7MCM<Q(2(=L.V(V98ZAUR3WKfSD9/M
R1Z5\QD=eTe6E4.X/PJNZS.CWVV-LT5c21P^)SE^,e1R#)+_&7YS=9G3E=8^2cFX
LKJSDE=63L>SEUVHVF,0:XY(G=9QW8Hd,460I#-8;A@:O2/M=(F2?DZGa+Q+ER&B
KeeI;.91U?bHQ@SVA.JE5Kb/W=<c=,N9FVaM^NXVU@3&;=YJbI?,TBE,c?<CWX3(
2J0Y[(Fd/b0POFa=A3O:GJ+aJJf&b()ODP>Zdd)ET_RAYM#(BZefFaf9V0cdA6dS
=O9,PV]aBJM:Cd;?e[CQOfX-?Xe@)E:7_I=(W6M(f+>P?GaEN96gWI_Ha-4VZBRU
[MRO1Q-M>^ce&^[2NZZcG8]Y6713[X2\H8I:NbG+TRU7JgXLWB>aX#4G-PDA_&fW
QRf(cdPX4A2.]>F>NE[eJACTHVBVJVHH\c7A#,_?IBaR9T=.&JJgbY/^+_OI45S;
;eEP2dG&fDXA2PS@;f#HR0J1e.D0+JK#U>:2[7?;IcVBe5@S50N0#Z#SUX\?:a9-
TT-1&]?YS_WISB1Y09_02a0_+5A<,dG&))Y=aa/0:F#EO2/@MaSOJ4<I(UFKN_R>
30D8)2cWLBFBS#YA5A[YQ)RC\ReN;1(MdD6CFS4:W2g[LJBPDICO/^5S/f;2;f1)
cLPT3Jf2(\#Q=T#9KVQcF+>\-#88&g8^d._<)G6B0=0TQ66DJaI2[L\34S<,.f.+
D7+d\)2M@PQJMg^(Yg,a&JF\6(]QedA]^:Ecg:EMCIeg/YU66YKK0SF<^RfAQQJ&
Y)[.]XQ#TP6IA.>(@::20(I[Q.:EQb8#W5<1Ig9]1]WWP/HGd<1_HCO-UOQV5W]?
5g&M40DRH@XL5BB1I8a-U-HdGRQag54-?gDHH_&0ED+6I<<^F.KcXgN+6R0^B9=W
L8WRIR;bG]S3-+)DWZg33:L5E&3@P-cH4)],gaNc_A?\e5:HF;eGa@5A.)6/I&a5
,3>S_A4g,Kb_SaIUcCZEHbJG6:W;X7I+e/NaD@E9.P^+7GH:.RFJLg8KFCaRRW;>
a:5POW_-YAP3A:/><Ig0)P_b3#K-L91_&Q_+,U]A=GTBYgQ;#dY(I=4,2J7Y:KLY
ZdKd:5@dFT4aZS>MU(DK)U)\/5UZ@SA:[+d8d3,83>f=W5;:_CA)PLGBd9Xd<[A)
1<7bU0?#<OE_1B)13dXbNCYDV(VA7955Cf.(8S]?ed:]NFTD_0AF#K6dI1?[a;^R
FY@b#)ZQLf8@PIeW&[Q5eUa3MagYL87;d1LA8NGSEZU04R2\<,a,?V/CUJLA4WgZ
c,PO+:_V:79J0c\cTX]-3V,@P/2e@NHa8D()g4+5#^X@@\^K/OZH]&5?;;2eSO+Y
Jc04W<,;IObSgF\a6XSDf#Q7JbZF^;W&PL.B#4fA,IFMeM8WR@ELL9P4c-/UNH+;
5=.[HPdR;[PXP0:<Ha;deT>/R(B3;GMe059)^_=&XL<PB/.RfGQNe:;Y>E-R3<FA
e,:J+M[Z=0CL(FZ#TE^aHJ.L##3G<D,)X\B-@Zc;&(ZOA>3HBL\d3Xc.]AY)AI]9
AN1N.,c\;.YJ[463<02b[8b+Z^SgDL=Ta(0ZJX16L\WO]MLfUC2>@G5e\=]@A)]W
T:RP.&c?QC.2O=BAYG<(&I9^V.-3c/,M\\Wa;CW]L=7ZMKS[?@KD8V4-_N@551-Y
aB-JPI-.3AeR,(_6:-H<Ya0PIG[Y[0=?Me5TZF:6Z6d=)6E0/GdReRHK5L3dH2MT
<T<KPJQcNUE.If?0@BMZ/8^1T+OHC5YGI_S1Hc9ALC_?F<<-5@7S)S17g)NaSB\A
0eYLReAbZ.bY#]U2XI:?]OD5DT&([YLfS5]O33DJ\>M/KFS[DI2Q=]cH]#+7ZZd<
JMW@@[E01FTU3e(^TPd.?>:Y,A(NBJ#3RHI=GNN<HVgBBegRHWRS9[GC_O#0>4AJ
WJ&3G:>2<++9WeX1GJ[I364c6@Kg^g&T[VfaGV9Y)YAUQYdLeb[L5[[PZ8Df))GQ
VI@2GG:PCZBT;A-a9J.-;44&@/d?>HB\,Z<VT(GGOZ?1NS<8\&M&;?.:VJb2CS<0
,fBT,AYKHdOXKVD5;:<AUC9bJP+5Ad-MVGb1>eF4C?P&[0TQa93=VC1VDR4437Vd
C]gF2U65a\^>VcG;5?LFg]TIH-Ne?^TGT9&W^R_MAMbP\MBc:]0N^M(/0LQ=LNV_
HI[5#.8G?IF;^M8+S@H1WPW7UBN7]=D/OR0,2NLMG[V]3L(U/:I<dT2TYWH@/4cB
_a:I/EKfaER9LF#+E[041R-S(H?/DZ)SELPIR:URK5[<)d)c;-)/F#,3Ne\0(E6E
A,,>aQ[D@S;.H2,dVBB9D4-_@DMQ_PH2_W@MIIaE\/CID?Vg]eHcf;AP=ESSF3ae
K_a>BPC4#)X1G\K#-5EPDA=701=\bbRSD/e#,[T&\9a,3W90DGcYH2_:K=g3=(ZZ
>^F>S@^O@T-M;g#ODQ2aH1^VJ^@41##FQA4@\Z[87H7)]9PUL^U-]3V&4]@W^61L
G;=:P2DAL3K9F:Uf_ITHL(_fbOTO24O)3fc>8CBSYG?,=W:H8YG1Y9eNB4YgT]d(
9-:L;];a7-WX]CD,\:MG7[(?&08aC64:-Q>g2ec<KA]#Ca4\_=]<+8fg4>+W9MG8
SdMRFFSJ=&+Gd6MS6>]]1O^eAP^8^[V9FFG1\Ea^VK4/399(]MUO_8Y>DZI636WQ
EVI;KEUP6/g</(H5708_CIfcM<RWU,?D/#&O_OTNEg@;MPV+,Z>A@J3Rb@a4+QP2
9E>Q8Mc\S?U@<D<gSA;g_W-+N?[KVCHHgZ+,@DQcW/#XW/_J>4&@5L>][,;;Dc#<
M2+_-WHAf3@+6DN(Ff9SF&5LCQ?F1a9ZT^NW_FFB,GY6>GPFge?WR+6J=CHBCW+F
F=^@(Z=Y@W6FRF7CacLBGD,D\X25MF<F.A\CJ1FX4\;Fa@c]4MFJGbD];LA58ZN[
7HJ3[BC]T._-7QR?SD\A0)^&Tb3d9C5J<[XX>U92.@gDV7+8S#c\-:[B-X<S;Z>&
QCQ0;3H1)ST<Q+O3DW^G^1c_gXY_X-M7]D(3P(JNgT1CC[V9D]g8(VT-VHR<<g@:
1/<Q]MN4Sd/XDIVQG]\5+=XDN?(VN\4=(JGHG<b8gL)Q1Z7UC1TeN2+KaAMaK7^V
b.EIIAc+.&\;O+I2--_,C8[Y7,fe-8S;ZeU5\JgC\aY_f@MXNN13B3KK.CD9)F(?
;.XLV,^P.()T<IV08<(#DNQA;C8CH83EPJH6aEZ?4@5(H,6AVMe,CDd6HcSX&O:Q
84c(B;@#MR8F:fGGN_-\AT)YWee#B&?9D=Fa-J[S[\M8^8MMQ>?L-AD3d]S^W1?Y
.Rc/bG^23/_[<=4F3TPEQMMZHKR5+>e6,JQ[>7JLLP&7K353^3YS9^<F(d^36dR_
O,7)H9QdX2(:ZRPY_e(HG)31:RWZe<Yg)XVA+N]]FJRF(0[A4ZW)-Y@<eN,)#M(^
I.M0Uga<1-45,+C5Mb>Pg29SWON:D<8g2>>Y5&^JbTX\6KP=O?.9DN;XC\?(+MPY
TK9WUWI1H6/9OZP>8/)1#AGfcG5]eUJPNWDC]NOH0@<]I(4:AZEbgVDWXH03MbX6
#C<Qg7948eBZ<fJ<F-\3(10gf.3&@dOP\N4M69g5;K?;XN0XW@&V<d?c5T0AJJ?1
B.E6JK\YfZN@gWH;c_6KIMc&Rb.]#cJWAS7cNfcMW2&V_c32,TC1_3IM,&,LFTfG
,B0=6Ba;b;SG<BJEQZ)=RBgA]VBNT.[IdYY/J(cI;.fS#5C#N\Ze?e.Pb+7Fa:H,
cVO=7-,g38-d&1K:DG;,I8Tb<E0W;G/c#JMZ\CYJ5c:18NUEAF^71-)38F<cF:d]
G.&BYR><>J6RLHUC4_HR;eFL@KV6WZ]?]P;Yg-&[Rff9H0c:d;@?1N3>ef41<a<)
-A\&YVO5)R5SFTLTPK]J--^,23,8;KUVJ<+P68]7SFLPSAWW]E4207YPAW(acD2>
J)b#WU#&aOF^>.9<?YI=O)&dB5^D[O?)J<b=A_3;g+DHAcT98<a)@03&KZ63-+:f
3Y@,9b,,G0c]LN-&+N5YbCd9#V+IS3EP#;aP/2L8&c:])I@E,ST)M7R(_@&4JU\:
T4,Tb;>Z]^5/)9Yf=)G7\(RNJC_-)EcV4BCV7D]a_dMUCNVHT[W;(YN?&6D8B;+]
3WNYgG\G(^aKaMTV5&=KF)T+cAJ;T5[g;PXfX785fG?,3TR^+WP6_<[AJ,]bcE,J
fPE<\0aDFLU1;C;1#:5+3-(/8Dd4eY55&54;,D/5<(G)dTBUDE:F<B_\.N_KeX2(
C41=E(A78U+NLV46[#+f,cHNfC^<QE1URTSXJ4I_V&OC83LCae?>#F2M(,UOT]-E
bX<d5,[b>7#\9<YV?^&V5FQ[EF393M;>D2-eN[53EgE5<+THWb^WOX#B)O<;NE/2
B>E.^J^;>-,MgWbF6SH+5?aVF5aL#f7A.18CHSM@N]?SD=HWU<9)e=Q^@5(\2POP
0P9-WFUCf@ME)T2?OePEVUX\fe:TE<^fTC\FbbH@420WSEP9R5^O<_M4g+a\[+7;
eOf>L_<_3Y<Q52?HOQ&=4BB.4+V+FKbDSe5Xf@OH+YP,6eR8N7_^_Y@FL)4;GWTQ
HIKET[2_2>JgLcE\fbYNS;RbbM&FOFafPgA0O7Y4FX\9Y-MU\GR[<BDP>AW-.bP0
GB=RDM@&8cJ&JS\Z-]g0a83KXK0-\FW2=76/acJ32D2.c9UbL1A#]BYL)a-.^J,T
]1TFf2PAL\;)GS2W<WEg:&aIG^da^1+GbUBF1K/_OBCN<CE_Ye&g]VU@?+]IUe+S
b<ZNT;_cLM_9/1@.0QJ)cWeIg:g#QH]^@N.FdYRYMTXcL0gC<?)KO2JDVJ2-ES6W
&Ld212LGI<>P06)L21gGLZ4P)83M)bAONA,.85Y:+,3CS2NUU.6TaP(cP.OL+YA7
/HGgXE[EVM773?6B<0KaUI8?UF=TI\->\O-\eI);4^fZD4DXK3[X6;R^?9aRD4+=
_2#7UR^K#WXA?/;J&[?4#-V;IfdMSU],3#/M-#:>4HLKD:P)SO:fR_V/P:6cNM)P
72b+fg^KM-dbW01@#gH2<]FT6E38Q3F92L14RYQGIV4g;IWK#&REHY/I:2c_1WKM
AB?=8^/@Y7Wb0$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_SV



