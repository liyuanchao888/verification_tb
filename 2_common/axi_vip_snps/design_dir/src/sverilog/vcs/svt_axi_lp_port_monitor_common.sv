
`ifndef GUARD_SVT_AXI_LP_PORT_MONITOR_COMMON_SV
`define GUARD_SVT_AXI_LP_PORT_MONITOR_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_axi_defines.svi"


/** @cond PRIVATE */
typedef class svt_axi_lp_checker;
typedef class svt_axi_lp_port_monitor;
`ifndef __SVDOC__ 
`protected
:6<):f@^<&Ud9_KRY4.=2NBZP+BbZU/0MNYV,dc&C;N)\,L^aDIa5)]SUE)YfYN2
9NB9AY5[T#fd*$
`endprotected

class svt_axi_lp_port_monitor_common#(type MONITOR_MP=virtual svt_axi_lp_if.svt_axi_lp_monitor_modport);
`else
class svt_axi_lp_port_monitor_common#(type MONITOR_MP=virtual svt_axi_lp_if);
`endif

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

/** Analysis port for axi lp port monitor */ 
`ifdef SVT_UVM_TECHNOLOGY
  uvm_analysis_port#(svt_axi_service) item_observed_port_axi_lp;
  svt_event_pool event_pool;
`elsif SVT_OVM_TECHNOLOGY
  ovm_analysis_port#(svt_axi_service) item_observed_port_axi_lp;
  svt_event_pool event_pool;
`else
  vmm_tlm_analysis_port#(svt_axi_lp_port_monitor, svt_axi_service) item_observed_port_axi_lp;
  protected vmm_notify notify; 
  protected vmm_log log; 
`endif

  /**
    * Enumerated type to track the state of low power interface. 
    */
  typedef enum  {
    LP_OFF=0,
    LP_ON=1,
    LP_ENTRY_ACTIVE_LOW=2,
    LP_ENTRY_ACTIVE_LOW_REQ_LOW=3, 
    LP_ENTRY_COMPLETE=4, //same as LP_ON
    LP_EXIT_PRP_ACTIVE_HIGH=5,
    LP_EXIT_PRP_ACTIVE_HIGH_REQ_HIGH=6,
    LP_EXIT_PRP_COMPLETE=7, // same as LP_OFF
    LP_EXIT_CTRL_REQ_HIGH=8, 
    LP_EXIT_CTRL_REQ_HIGH_ACTIVE_HIGH=9,
    LP_EXIT_CTRL_COMPLETE=10 // same as LP_OFF 
  } lp_state_enum;

  /** timer to track timeouts on lp signals */
  svt_timer lp_timer; 
 
  /** Sticky flag that indicates whether the monitor has entred run phase */
  bit is_running = 0;

  /** current cycle */
  protected longint curr_cycle = 0;

  /** current time */
  protected real curr_time;
  
  /** Sticky flag that gets set when a reset is asserted */
  bit reset_flag = 0;

  /** Flags that is set when a 0->1 transition of reset is observed */
  bit reset_transition_observed = 0;
 
  /** Indicates if reset is in progress */
  bit is_reset = 1;
 
  /** Sampled value of reset */
  logic observed_reset = 0;

  /** clock period */ 
  protected real clock_period = -1;
  
  /** 
   * Triggered when a reset is received 
   * If a reset in received, this event is triggered prior
   * to the is_sampled event to ensure that all threads are terminated 
   */
  protected event reset_received;

  // ****************************************************************************
  //vcs_lic_vip_protect
    `protected
V.7IQCOMLb=Eb:_@Y;2d]S^]/aUZ+&IP:UeQ@EV8cO9SO71A?1#+.(J&XS^3:OI)
g7<F0Fd=@[[JMJC[WH#HK,J@^^I;P5KWcb@:ITA=DY7@5RO>9C2,?#\=Zff<UUOJ
E1gZCX\+#H(I:=1B_VY2C41.&8V&L8B=.^F_95Db8UVQGHV<0)<@)5?JVfbQ=KU:
X7-&?U?7@R9LI_-Yb#C).V?MG]Vf&CFB>bOQbgBQR2)0/]X/Ff-S-a&Ya:YV(R]d
J[DRT?HKOQ+1K9Kg8OZ6WOYC3AfTH[PPC1Y,KVZ3[T><JW+d@X7G+eBS-8TVgR?M
4(1^+6V(/1&Rd?dV4a<453<AJ/JJ>EZcB,@<M6SR>:?G)OdW#Z:@HKN-L9&28_^]
TLAQBPZ#:119.f6.3\C>X;OF)8Hgb&d:-HNJ-+PR@]Fb&]1BdV@9F<3;FaX\=\-;
:D0U]WDC05MQ8;+MaBf;e17-H]0A((QV3b6YUeQ1cRE3CFW,Z-fA/+NSX:[@YO(P
)B)-\3^bNZ9M:\:X9]^G]_U@.H+_#9L>gRB_Ja11YAF1dM<7&<Cb/CNSK$
`endprotected


  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
   svt_axi_lp_checker      axi_lp_checker;
   svt_axi_lp_port_monitor axi_lp_port_monitor;
   `ifdef SVT_UVM_TECHNOLOGY 
    uvm_report_object reporter; 
   `elsif SVT_OVM_TECHNOLOGY
    ovm_report_object reporter; 
   `endif 

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Master VIP low power modport */
  protected MONITOR_MP monitor_mp;

  /** lp port configuration object */ 
  protected svt_axi_lp_port_configuration cfg; 

  /** variable that stores the state of low power interface */ 
  lp_state_enum lp_state; 

  // ****************************************************************************
  // protected Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */

  /** Variable that stores the axi low power transaction count */
  protected int xact_count = 0;

  /** Variable that stores the current transaction handle */
  protected svt_axi_service curr_axi_lp_data_xact = null;

  // ****************************************************************************
  // EVENTS 
  // ****************************************************************************

  // ****************************************************************************
  // SEMAPHORES
  // ****************************************************************************

  // ****************************************************************************
  // TIMERS 
  // ****************************************************************************

  // ****************************************************************************
  // Local Variables
  // ****************************************************************************
  local svt_axi_service observed_xact;

  /** @endcond */
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter UVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new (svt_axi_lp_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter OVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new (svt_axi_lp_port_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_axi_lp_port_configuration cfg, svt_xactor xactor);
`endif
 
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  extern virtual task detect_initial_reset();

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /**
   * samples low power signals
   *
   * @param cactive cactive value
   *
   * @param csysreq csysreq value
   *
   * @param csysack csysack value
   */
  extern virtual task sample_lp_signals(output logic cactive, 
                                        output logic csysreq, 
                                        output logic csysack);

  /** detemines the state of lp interface */
  extern virtual task determine_lp_state(output lp_state_enum lp_state); 

  /** processes the lp interface */
  extern virtual task process_lp_interface(); 

  /** samples cactive asynchronously */
  extern virtual task sample_cactive_async(bit low_high);

  /** samples csysreq asynchronously */
  extern virtual task sample_csysreq_async(bit low_high);

  /** samples csysack asynchronously */
  extern virtual task sample_csysack_async(bit low_high);

  /** monitor entry to lp state */  
  extern virtual task monitor_entry_to_lp(); 

  /** monitor exit from lp state */  
  extern virtual task monitor_exit_from_lp(); 

  /** monitor exit from lp state initiated by peripheral */
  extern virtual task monitor_lp_exit_prp(svt_axi_service lp_exit_obj);

  /** monitor exit from lp state initiated by clock controller */
  extern virtual task monitor_lp_exit_ctrl(svt_axi_service lp_exit_obj);

  /** Advances clock */
  extern virtual task advance_clock(int num_clocks);

  /** Samples the reset signal */
  extern virtual task sample_reset();

  /** Creates timers */
  extern virtual function void create_timers();

  /** Sets the configuration */
  extern virtual function void set_cfg(svt_axi_lp_port_configuration cfg);

  /** sets the vif */
  extern virtual function void set_if(MONITOR_MP monitor_mp);

  /** Utility task to set internal variables */
  extern virtual function void set_internal_variables(svt_axi_lp_port_configuration cfg);

  
endclass
/** @endcond */
//----------------------------------------------------------------------------

`protected
G2gYY++\/e[3YGKaAW22[N?^N]5.[gIPR)3F64ZfI4ON0_S6=1FZ3)ZA95IK)?0a
WGE_H/-_d.N5]5g4-//R\/2f92E8X&7a#8ASggYT]_DGB=Q:<g]5:H9/=+@X?LN6
<].=&A/8O3N7U@f<X?Cb=#HU&(ZK-+d/Gd2E=a2W3BV?J?1V(_:VeY<4IDY_?)86
-S&f<Z]3ZC@VS++6Y;e@d&AR:T3]0CCECdBY:c.9WI.WOPeR57=/YVB=3\QT6[_,
BfDX9]GUD)0L+5SIV]:2Z#J>4VY-,\cFBa^>cY#,;A>^UY[E3f-5c3aB;WTV:-gN
1dGJ0VJ_O1.SCaP4_L@&UE+QH<PEFFC5P4]WDA7?+CJJGEe#JaaH@D3V7J(3^78Q
SF2fCA?\Z^W9-=SX^V);JPN>,0?/=.8]T0DQ)e\&0685M@\E/Q0L2H6DO_;]9[>8
\@c_PG[[B(deB0IaF3c\Q\<)H6=B?D22.1c5[Q?_G[<:b5C+S=F<CQ_f@NeR+=RJ
g;,&+JNdHYd11:V1CY04-YH[Y>+NgJGO&;,=K(f\1WXMOd)W=TcVHM-,d47^X2EN
9AZaXI>Va=2T-RWbI]aaFUDHQ5J9>4fgMN&f7ZLCKE(5R[MKEAeTOJg?4afK?0La
G@8>SZ4<_PfR(@Fe#P^[>H5eC@B(3A_,YPa[?/3-^1HMQf3f?(THF2:PD;gW\Q^d
L:RQ^[+T5fH]MQR<?PUI/ES.5aE>Z;78W8-M#7HOafg?2IH(d<L/AUQX7S_CML2K
@F-5\16<a]^H\Ab,.^gF70<_=].GTQKP5=1Q+WLPP8UW:3@>P/M\2Z3@ePYOZUd4
aS@1<M2d5L7:=;1C00b+4DU/DJKbHc,J)UV>V5=V<JIM&;2KW</+.R[Z3PSR>#c6
3egJEM&M^WP,-S,EUYVLY4UAJCc/T,OPL5Y?^7;XE\0H/e?MH+DR<XOPC6Y8ZdDa
dJPJb4f/)GTEG,1HJ[/?B6/QQE0KQG#S0I,gIJJ(+Jd<g+)M([R.bF[@AdAP;+=/
T)fSD2QSKD_c-/Y4,b]gA.)J3.<1gK0&L8aEG3DT;fU/R>-?&A93ecU(K0OA4XRc
GEX?e>@C7G8MOfIbI,)XM\50EMZFg5T[G&c5SD.QGJB\CL+F,YdEgZc5?\-2\KD>
-&.gTf(=e</(M>_R.SG+9#,7&-8,>?WUP@?XM,\62/PI_6^L.W7;[6&@ZT1Q36@L
QQH+#JNT<3K+RT74\.9[]J31D.6e;=;f533E;W;7dL7VOXIAe<SAD2H/L5UQV2=7
Mf_K8:L)PMgSaY@MO+X+8J288IceF5-P(?3.EG5P[d4[SP>;25A9HSYX3.A?c+2O
4\8N#,dDLSI<4f1P&OY6JN(7S641JMA/HXNKg\B\=U=dM>AD5?[[(=YXO$
`endprotected



//vcs_lic_vip_protect
  `protected
Z4BBG\M1]G9ZM@0Mf><[]U67FF>JS<Q<_T^\984d=0W)HdV+YaZC3(d#Y2;4DegA
e1,\LI^4ZK;;>U-?(A/Z733LTMRP?A/@b4-Y.1P&>c_ULMT6L_U;dE43gg-APT7.
#K>8?=QOc=7,cbMd.?C+6IFJ(7#e?.bJZQ^8P73@&7)VO&C-fV;fU.J4(C5-L68d
.L37USFQBETTINE2(:b<PINJ+Q&8K.Bb&BMA^542Y,:Fg#fQJgOR\SbPQ:7,7F2Y
\Ic)OTGKKc=cNQJeaJ1(?MZbGJ?GPD=(0&PcRf@3Tbe>-T:LOF?K.^I83d=9HQT<
TK@BOR2-gA9/T(65^eeC2&RS/FXd51BJO3,O)Q2-Z=@TSdV.I\QMD0gaFUND]H.d
Wc7SS;5:G5[PO?Le-FB@\De?-_[JI4g1f;17G2NHb(+NJZeRXKIgAJ+]>>S9.I.H
77RE][]QedXfgLN0>P<J8Y=HOAVAM>G)TYNEY@W3YLGA9&#8H:>^eBYYJ#c#?44_
@ea/=XTC(gMfc[\>KCg9JV7UX4SK4d##P,^7@O;f(=6TGK8bO1&LFSR+LdXNZ,B;
<SZ[&A/MH1X#/1a2;g8;\W/@#O^QgMQ#<7.NWMb->46XF2=Xb502C;Z&#<&?UFJ9
0@9,aX/I]ULJe27&R6=\-=MgY2b(6=UMg-5<PW4#DM)NB3fbIRRQ8\bN6C/C4RcR
;\6#OYR3dN(JACgN?))7;W>7S3\_[@)/D;O<MKMYY7XZ9Nef.XR9NP.7^#KYG/.4
.I)O89DJLC?RM#2.,Hgb/Re2RV^6HVgcL:V)eKXUM[4e;>=b47D8P@R3X-\.H3;A
I#gSPc^)=BSd2bg&]DgRJJ)5=\MF<38D4N#P0-)A6P_V53[PaeF4@L,_Q4?D?Rg7
BI30G^)DHOIXa/741YV)Y:f.LcZbXBIQRGIc6b/VL]@41D.W^QTKS(K^>^WO?]b_
-S1)>Ka2^@K80Z6=BKeH].50+FGVIa#^@7N@gSQU]XSQ-KJ;WTKDRLDaJNY;a1T1
,dZ1NBJ1+\RKe=TTHZ^4;4./+,]8NUa=1QHFgKafPLX^aeO02>J]4f)\5O6E.L,:
_e.^)S43MC?DOf=AMUAW9AdHY7=9A7DUZ0fQ_7S^&+/_:CL].JZAV(9MaB0UA,WA
ZN.I2R<:Y#HGC>@Ofcd_7Z>]Wcc;)PXY9D.G(Jc<;TRA-33H.2_gIJ(,E<#F;592
[,H6J#3/aU+0&A37B;XMFS[>V=?PfWKPTO1d6C?QdDaM,VMb&cK0NcX7&K-HE,]=
>UXCd?BO4\1R0G_H^WH;a4+2.Mc?Wae\6.Y3.GeI=Da.&Q=\YgSG<UA22dF#Ie\]
#=737YSc869<ML2E@cMgHd^G)9CTR6e#T5&:Z-Ie\PI;HP3M6<gO)W73Q_@aa:QT
Y&,RWgJDI#eD#J9\6[P=HbH?ge7#G[g21Y&8bM)#DHJ5_F23aK\T(&RDC8[QaA6U
(5_.]?&g2,R/_C0bDLVYE\J39XLEKG^Me/2#=f24B/_d@dbK?D3-THYXB//TEWRe
7&5Ca<9LfH/.7(XBNETc^SfM\B&9-?4a^&]0c[))?ANV->Y,A9^:1J:6AU>;:FX^
GB;@)@IR8SS+WM0.P7<-8UH0f5/95HLg1^99:_X3Z^aaOP789V^-_+P(3;Z\L56g
NY(.@bbCY[)JZ2eW2U=6E?cZ;Y[SGOUDBO;7X9@G+WK+QV7[aRaTN]fYN@(R/JKP
)/@R79XVUVC(1G/+2>IA4DP>(GC.H6cU5B#HGG@)c^P+1HRU=e@gALZfV]K&e<[X
]Y\.+I/NfJK7)L1X4cR<VDSDdT#VD(W]/5@.J84A]#01+E?aD8_]d(HgO^0M.L34
&&H4GVPXV3S_U(g]/6Z&Y#R1[[H8:g+V/M7#@Ec.<dBTGU6R0FR/Z5TD^dVO_[OE
FQ.S9_.bG8DW2(Cb-7+X(SI5;+<5)e_)-CHRV1I/NZ^UR9a/eP;<c[7N7HVEX6L;
P-EgWFbe7#[(LQ4\-2(AP\bS09P(/bL]CO[]11K<(F1YUG/\?CbARDBaC<U\<=9P
)=G^GGM;d>,^1QKa=PU[]6]T]P;:-QHN_&C]NL#a[2gV5EO.<=^;UK@(4a._H:6_
<3P1V8MHbf9ZfI9GgW^5<YJfIQZWg:d];;I\GP)ZVIWELeZL^5BN4YG4/6,?AV<;
OHd3LO4Sg16.a<>?O0_\EL/=?E7HX.bGKO2(Z@H?:eEM2()_d:-_T(H<:8WISOX8
WG\:eCX/VYa1ZHL4\8ZC]/Z@)94W+C5Ld4.dW?SO=f9(K,e0H^Yf4VG[Pc8N9O(N
g\b6[_L5/0\9F9\=GEOAK0J:3OCH<1ZW=)UEP#GR]X@&dB/E#CFX>\:6D=P\OZI]
A[[5=E-X)IJ:^3f\D.=[^9U(^U/](9E7.>DBd;UW[,[MEEFJPH8U32)Z>R+Gb5GU
^9F5c?ZeU4adOdDB]Y2VE;W;CJT(5YWC<UY-GH,#4MdVa\.LYB(K6)aG<f,&HQ#K
B7dBFWB5GCE8&#,Y)T,UKa#MN]O(@@Z<O@JH[M(cYM5DU&f1\KJ0^Z-<VZ.8d7CB
GTVbB.E_E-K]\FTNU97MU[2a8#-Q#.PP,@dMAaaHV:2Dcg43.O(6OZ,A_H?0#5^,
;:)[1C0(ZU9__NfROP[Z1G\7QF8Y_>.Q94)1HBZG4FA7&bd;8;5H]?1G;:DgEY-P
1&SH,,GF(HOY1O\V5EeC1LV?a:]F22RGIVOE4eAHLg53:KIO?Mg>6GfG+<E\b:#/
GQ4H=M:#W25:Y1#QV#VJfbSc34U0]b:<F97/4/VY(K=?ZKYNaB3\,&_U++^>06eF
;U]GcLS.R1K,f_QKb[a-RR[Of7Q@(0&QU1gO,LQV669OWLK9FE)=a=(bAQJ:TE4B
[?WWL_9Y6>8:;)e&Udd,8G/Z=E6J=@AGC;eAN5-c8-+&TX,HJIF77^-N0P,AO2^(
SXEG8)Re_JFBeV[H^Z.Yf]GWC=K5Xb8,1gFKR/]7FVXY-5c1,&8^.afXWPC8ea^2
H&FRe.TW-XE;1Ac)O-7K]MN1#g?36d=Cbfe<R2aL=MKN>09g6ZY,&2_K5V,M6)a&
ZO&;fDaYMU3g9WARWDA.9a?IO7Ae)7-53>FO,,9,AB77&6&-I>HASeE&RJ78TS34
NT#F\=gA=2?X.1P.5YH11JZ/=AcfI0F=>EZZ+V&fGQ5/0&9cF)&BBA58<7AA;<[d
;e3C]a00Se0B5H]\@LY-#c@UDaY]_[JU8);fggcUHF95DGAg&UgVB51GJSd@Ra;J
];U/THMa0b@cHK^N\gC,e4RJ&-3C<eY^HW\A+b&8/;8=0c9#,J;PDKG7MN]^g:FL
1AGgJSG]Y[d_MgAH#246IB<UMOY6AaR2W0B1_:#eM&/,4V6PP&_5Fede>9A&E^6+
.cB5AU/-\cEH>,,fR;@-M;Ua;.PHS+\SAO7YPK9)T<RTBCe\?6O815O6+cHdMB75
G]eW^ASG6f;g?2Fa9S\H5+P7(>d@P\/L_&ME\Y_@H=0Cc,TUe-;XL]Y(QNM[&Ca6
AU<Z&]C4K>#;/[)+6N@_Y1>?\:,PPWAc2D;gT+1)A=@7NBP[;92Q62+g;B6E&SQ\
b??HZd,aG>R>8L:++c?ZQBU4>aX<[0;edRH+ZCG0LR/ZMT=T:K;MSN)?NP/7N@S8
[a3.8_e8>gT=Rc^RKTJ[3CS?))fM#?ZC)b125ATB:G3MLPLS=.PFSQe0Lb.6#5\;
\ZfUH>OB>E1@Z&9bBSR(1=Y1\XQDGa?Z#QUMgH=f6X-bf7R810GW.F9=+&NE:IN]
F1D(e16FHJO#E[0U1DCR=UaSHS?OBK6Pg=a[#Mcb,:(gEIeM_EdBRN04Q#VSR1BB
N/E6JE(4@aS-OG<\[2G;POE=C?LbR+Gg<EdF87#4?(6_EEgafMR?(TMe)[A:[3_P
SSWVeU\NB5X-7FUYVBc4KA@ecg-\N>4d86Q3QTZTKPdQ20&[CUM(MLM&I8C37WLZ
30A.@3+aH^_(<-);ROMBOR,\6NUUJBXN\Jd:Q:BMDb[:?Z^+:1L_gH3PZ3+RDY-X
SR,:<=L)TJ2b1O=SL0,32IU8=.6CLO(<^X3^--FI0^b@&?<gBWgJ=_-,;B&<=A?M
)B1O;>a>cGOTPdGe/&JQJ(Vf22)N+(]KO_7B5F,DF8-,=(VAZK<AB_;6,KZC0G>=
U@Cg>A89T1>eb<1=L():M.M:e&1TR-eA5SO3Q[eBP[XDVS=^5594gV4E&&a/VQ;M
V]::7W#7/_@KVQOVVc(2;)G9^_fABQbL:YY+T23^d26O_cL:CFU5=VJR]@W9#;@Q
LP0&(e7(+_H5?KBON6&#K?2Y84FN;(&B96,S1LKBXI.0HOdM#b+JA2[&36W=0IV;
#+9Z()aN[BAH#D-IeZLQK,WgREO#)HZ-MCJg;Y.5RTb2ZfeeY<\<@Ic/1>@;4Ne6
gB8/LCdg)TV:B4GT&=2B:Y&:C[Z#3AY<\[?71@7HL=?ET8#3RC#<H+d_c:UUE6(S
LQJfNF6B?;9?RQRTV,/8d@_DdGH9G\S7TQ]^K)YD)RVLA2#^@35F)b;VQg0aTA8M
]JLW-DOb]L(64eX]+bU40^>D9Kb7c21f?(LNHLLOSN^M\Z.Z.:)df8aX.G^;3AEa
:V,C#YBH/T7&(2C-KG3+)KE^c/1/\cWL@(4R1=P6g:f50e+>8aD_K7ac3Zc]<aSA
_MJFO5HX[4K\fM]DH6@QFga:SdF[eGIFT#42e8FG,ZSRH0.Yb.8Aaa&X>,J.0THK
+E[4+KIfb3]FO+>2;-F>(6++SI=;FX^>4aM.1Cd&&[1(-HVc#V^MG]/eY83QCg^R
U5UMGbZ;7<3&f>R)13_]O6.D)8P410X98=A/Gb.+31DbN1a]\\N,RJ4)c<.7KAIJ
gDa0H5PX4?1)e#?LI^-cb>VRGf[Y#,=(8GBZZRE+J\WaY:Y/7T.W;\I5&4A?5cbN
@06RMW)fJTI(0P\<RNgF=+aGcgR)[#0--OXf;BZRDOY_AY>a4P3G83)^Y9g(g&1a
+H[EcKc;V:[(@QCZ+E-AUR;3>PTbLG1-J_a4[cPSXY(4NadF(4KIU5db0DdIc>QZ
KdR4][)XffD=Y#7MG0WEF:;>_Y&C\7N&,1;JZEU5&Q4,:WH^8U_3eccY9(.WU0<P
W7a@(d/QXB+QDPHPg_0eFd:g9&;E.E<AJ>b]OD4C\,<a&IY)LfdA1(?^B=#M@:6@
GI584IVD@Ma,5#.Y9FY2_)M7QeT-6HK06[^UW>99H[H#a-a+GZJ>^NH7QQ<M-_TT
^04N75Q.[EYP_f2VL@GS<YV8<3aCQMKF08KedVXZ-_1SaLZV[R=6R[D>)TLG:R?F
?S)VH2eQd0NbRCNF4&[C=+\)BaFRM+\]NdD\7_1P@W[?-&&VH[T0RNXYD([QQTGf
+VgG[Oa<7ILCU.=1V?2KE?+ISF=HU&Q^(>=L[E.^@CdJ5a:L-3GJR-bI9Ug>:T:F
E.LEf:YH9,4O)(Y<60F&M\CV8P1:9b:L+32H=We#J_GXDQU3=cH_&FXZ_^V3L:)G
aMT)<bFg#^7D+X(_(;a_BfTg:.b[;3#(P]U?6f6A7ba9b4^cVf30S(;RF<Kf[K(5
VIaLf2[acG\A..Q/FJSRB]Da94<^M[AQHJI>d<X76?a3Oa60UP/P-4@BPK@aY1VQ
f_Y..^OPUHB;A&Ue5UOObL^8.8G+)_^>&YV1C4LgUG:eZH7TL_;0Bc=F2-OQVO#E
AIf+[75[1<2E,3V8?O^\H=e#._-b_77=\UQ5b]gLb#TO\;2=E8;A<-;ebMQZ;f?R
12)@A2IPMXE))WDF<Fe?9A^,GZYGL8N@?51f<]6[N.J:&.CR\a]^G=a]cgfg#]VV
)95g<6/>V@2F9@ZcC;2?HT\YVQcO2;K]+]aC\S7Z5;<?\0(+aH=>]bSNUaF]>-TU
3>GDd=X@2a76OYRU@X@^T+H4gR^#Z29,(G(;Tf:aG::(X_EGGN+AP#=Y96JOFTHJ
.35VF.Z+KE@O#TC^(X>3[;+^Rb^IZ5]U&@>f)O]+fFJGK,D9WH8GC\:ggd<GPLaH
fCK\M^.Y7</C;V5C80FG<E/V[6A_:(D,F5S\e=C[P/?T:2RH3YSX=Y1A(]YX7GID
YL7::;5_[]H>BNK_Y\DR?>I_HOAFV)O)IPPaH+J\6DID;1^.E9Q9HBeTIH]B39,U
c</GS+fTgXPW\/[9a#U\@7@B&+@JPG&8)K@)@(JWZ6Q339H-J#@(=H03W8JaPT5]
.8C:9TR@I-V&FKdQ0#+P6P)1g7_[^H_)+I@O[1HC9FXB=URM:<,U8@A(Xb_f.Z(P
WB9./)+NfA@._\V20M2.bX,EJFIaRKP1YGPDf:?:300[73:dP_DfETOX[cY:+CF/
WQ#8(GDG>bQ\,N[I&G[RA^[(H=TNFTM/K:^.HP^#-GT^=dI2BR#=QW<)68::U7(L
F5=0):4?C1U)+S/7e:5bNQY2O>e/\2C#B31A9>6R^2JRW-I&?,;d4>d@<aOH#,\7
J083,\OCa6/@7aVX3RE3A5&1]5<-U>0VZJG?bD8&([O])#)C)18dcbdH:J]W+ZJK
e6Q(8X;OF&Fd02HCM1U-3b=9P-0Z:Y)2/U:<00PH=]58=>b7(.7C+=[M/:6DJ\<_
\^BdW,+>Y]aa;\)X&G:-a,GOg273I)W4;.--BA7(F9Z=1a@0<S.2Kd]4GY(<?>CT
#B:5<,aCNc0a&^INb?Hbc;7f,T^RS3;IF17JZ,<)JX&Ic\_D6_/Be(.+S2&?^g0e
,WO9eW2N2WS01H#=1MeEID.N2d/=L#JgfNdO5UdT#LR@3?VGY#_gaI4DF0+HKZ1U
\8ePMPffXc\;L;KY^0),<9UXL_T#cE#8-G\VJX<(=8Cc<\GaY3_W]]?Pa&T704U#
4O8Ae.(2/[f@R2U[K9T783C60W/NK<S+eNe-Jc0CU/+ECb>_=6&1JA?_LfCO4/.d
I4C<5B(bPFU;6AR8YHL0C?;[L<#Z8K99fEZDY&V<@09G;Xd#Q=\5JOGd>>Fee4Yd
&9N-T.e8[@O6N#^.0_c3Z#M>D9\K(GU_RKH)dD;J4Z-2;5+&VD&IP[MF/29H)R>Y
7dZRLI3;6MHOLUHIUCLULMLKR2e;Vg_eG5)DWT,6=-EU/^;#]VL\Yc2MRDV+eH;(
>a.]b,DZ2F-g)0cXI15eCPDU@NOSRW-.&]2f<57cP:F_9#Rbb()1BXaH9P_SD/P4
4HXMf)c[<\,&+;V3Z.=K\_]Re@GZ1b8S&;ETERe#U1I>FaT#9+F0d0S^VF;KVCJ>
eJ\O\M7N/EP+Q[4//\a))U(1=+-g.\2ROF9GE3_\)b/#VOE@N/bL>L#5&-OO_>Q;
60AA6<5D5+bdC)A6GKOW\VJ.D>c^#T#EE0NdE+(<X-2.E@GYE,X)^-U+.V/60a.H
9c)>e>NNTK6g6QJ&#cV0HJ[9]2V@X(ND:YGdUAPH-HaA:),UO)DH;H5BQGXVY]8I
&0T/[bAG5b?L_^2-1eD(Z1?^CR]5RgeXJD)7:CeGT8)5EcKXHELB)X=S;2:E_JEb
IcDZTN:T7+V-O)A\O3eX.A53;,)/IX8<-(N?QGC^PI_;D][IDJ2(^6,+W)/fNa^#
>A<DRSd<;-2UgI4^=9RgZ3VE^A15@;47<ANGYFVg.JeJ6S:c/f:cDg&V(T5C?@?(
BEKd_EPYDg1[cP>ET^VULN0/9QZ(V6KQ,C>,W;)\fD8#I1(.&WWa:O\QbCWD5C9<
9M+E]HHM[2AC(K<24LI]LMT(:[d[fdEe7&&e[I?fK8(OdTYOO:VUb4MXRU&gE=#Q
_b3/\A4HNJKS^JQZ[8Y5KBT4.fU5O_(PM9#;,b3]&2EDZ\#c.A19VDPW_H?P@Oe2
=CPC?N-N?P,a-?_VW51BI4J3)@a]V)33)X)O<?.eSgT213#V_KLL0HGW7E7g:/YW
5c\7gSA4c2WH)VX/RE?dB:)&TB[@NU&\Z,8Iee>PJR+CYdXV.eDWV&>\.=S-Y8RD
Q+Ad692RM=b=T+(DYP&&c\RJ2ST?QSfD5:NH4NPSKMYVVT>X/^MA?R#STDI[DZ#4
4V<@?fIcOYG:R5E,[T2L9NHOVQ>(R:TcGFOWF6^4(GddYNSgT7S#9PPWUdR?-H@/
#@FH3gMc^GMF?1X/+O20\^7.],b80_&&eW<eIb^1U-/0W^/H6+LYP/WP0S<9/W39
XND_e2;b2gKIZ0C=b=\eY&U,S97e?G9X4+[b;CKW:=V/]CXF,Q5.Z#N<2Y]-dbC-
OV[b)&2fM1(0,0L[eY@VVM,D@JQGSU@K:=,J?X,dB5TMg3)_M._O\YD9K3.B,&D^
#WS-_DGQGGbH\bS]O3A9A^)2/BT>5Q+9I[V[[+X.@c?d]aFX8TUSY\IQ@LT1(Q^N
d4e?a5K^APV7RPB-0d_<8_F[b5RKM;,>3EQOYB&SIM[&1W9SOBA825Qb5Le>G?K,
-gK^\NX<5ACO<UR+60]Z5OLK2O60V]@9V(5CREc>QP#HV.b3OF^[0_YF#J+d(D;9
4G^CK.7Hc52@bBVP2:Q5?EOOZB+DDEe_cfa(g;-<UWF]FM2)_Y)]-2/?#d0+ea.3
NTfA<#1FMQ+MD/7PXI/O21?RT1??>g_cg3/4=gZ6>fdg=-_N?Y_;cOI;e9^YJNRH
?a)4a<6FbV?,+9g1)@)O(\+ZS&5CfVBSXHMVG5:T2f5Q_6VV;-UO=M+C;P&8@ZV/
eWV8NTZ8/5?NZV\<.J<]Xa.[+<EM7AbW,9X@@TYR)S#N99\89(X53XE&3E70G2Pa
7A60FWagbOA<BO27](WO;LOIF)V_H./B[LN+1\XVWf2S\c[FK]V<RQ@@98RZ-Pg0
XL:7R>YgL?CRN(e)&>@18ZD6=e;fOaDS/,[AGM:BYeD4Ra]3)Qb1(N25e49A5,MU
-62F9O;92G+\b8cfb&+gC:M,?aDC++([?FX-da\:(@cHNQfYGP.]-\504S4CU\AS
QQZf3O5G=06)68+)_,gHNIg@M\8U7g_-R(7A9,J0G#&)<?Vcd6VYRB(SX/=^I5JQ
?N868A6T[([GH2TJV]5VQ.A.fW#.18)(+&R/W.@3=UEX>9L6)X3D5-ENK@+HSU)F
@HSd676M.,@4Z>b2(cfe7[XU?a/M\32dDUd&N@4UB<dH@5>JD:,A+Y+[a,aUVTHN
,[WTTH>6c3b]/2.<aD96-TL^A4c1L84d<dd71,3+742g?:,8,_RUQY\XEQ=09[d^
CY#Z,Pb&[J7)UD5J3CY.7cd5AV3<N.(#GW]@IJDPG-0JaTGQ]\XT?LeHMI]D4:[K
Z6/R+>3OBeM2=E)A6Q&NQZWWSAER;-cEWDY<4de2KV,V;)W2+2W<#XeRGe_SC7.Z
MCeP@10<683>-b=RRd):,7J:UWd5SG4(Z):1Ke#:0b_LZ?O?dMT&F)3PeJ#V_e,-
F)@0@&+5^dHI.V2^BPHX\+LLBB/G)6V5:c7L109WMVV4>+Z8KJ9D#Ob?RBR_,TXK
;7Y/5I;4KV^QZ\YbY4?JcT185:_NADRIV&4JV<c0cg;\HXZ-B8@[X#G3E_@0dQ8O
6/C8fKF61Be]O@FIGG46F\\)BCIE_WM0_I>E#XQ+61(3DZ\XTO;T,S[)FUd;gC</
HQg(,Y-e_eFQ&B>I.=bS[_aZ[NDg=Y??@d;=Z,0=e]GH;N(EH_S8bARNV0-gIea-
7bQg5H=HWg?E2Z]=.f;M:bBA4Z,FWIAPM+>bQ)GC3HBK(<:G&5<J-#:P\Ke3[6=E
>VE:2L;YY)Mb54E0@U];Te6C1B(f@NJN/f4096(9C_VRY(P\D,3#bD_F#\=RLB8N
\+UANJEB__@(#QGaC9@#;+4O#@8#@Cda^.[]YQGP-DEbTNAbLJ4P:BF?6DcLF9PL
L1W;XE4@FQZb9aQbC,5H5EEVT)CQBfUY^2A@P/>^LSf1a2P+<P-W)7Tf+:VZOOY-
HEDcKQV,N:7<Z<&PLf8UIYA\-<fVO4IeA,>0QTO/D9+;(6aHGR:bWcNd=9I(>A[F
<ALT;9dUFNFIcdHB/42214fC;Tc5T[/ee<dXAef2JWf3S8:D]7I,TIOXF^\M^6B=
E7A4X02B2W=LYK,3G^?S?L.\]1^\/;>c#L31UAP3g+0PU)>Z__GOa^ad&7<aL04;
&Z85D(Za0agM7/f2:9A6P#NZDZS-fU=3(2JW,6:c4#A61Z;gO1=7@8O]GNQ/5<.b
Wd(_gPM662e8]_X=^)AfZ8+LA7.S#=gCQ_0YKAfMEJPM)3^O<F>T9f?[C5=BfR=I
I3E^:gR-69fMDW1\&G-KNaE2.K+V;L2&C2Hc90/Ea30DZ(7&=Y96H_?(C,W&G&8:
GM<\VXN>#G<V8(VA?:L,^b)FUN>E3MTP7>-KE820O<_Gb:@6d@0E1\SfY7IXZ&\+
aAXM]ISG]:f39>IE:JP15WG7+a2X]7:9\eRc:-8Z3D:0R<:U;H6CMK_LNIb:M&WP
.[R\e+PIW(E_,@.3/\S1[_WS;HP4AWA-Gf1G.:V#30eQ#H,4-?R9^\fQ@G&8^Ga;
KR]A[:<FB7T6O,?1c-Y=MdF4@O-Z)0E2&1EGNEdFc^7PfTCV.7^E5V#I8&6R=e;G
.:CK];EMg-=Ng0@?@FB+U;7-Z,_TXXYU2b(D5P\W8e1@DM0\aLSL6JTJQQJ_/K57
aYQ+bYSM-U7P1>,P4#AO5Q,]-:,f/@f+32;=H\7?RAV<+7.:UeBUZK>7eFO:9[a>
;)bad&;Nba5SbSO3AeF<];\G;cP7J)TPb6G;?3dATfR+W57?ELYW?N,M>JU0?Q);
a.+9_Z:?E_?acLHYA(d),/T&V>@(f#](KBR0.A.DI-Pd3KV_)D&0DMF8UM0a8D#Z
eO+D>#f(_X_9@8@J/=)fe6#WJ:)7GU0[P6D0079VdBLI+(,d,AC^8X2]]U>5II3&
2+]T+P8D\Q/(9HR4E_Se+S:6SUQ-#\2)BJW/+4a@C1&>7HAc0a(H-MFX8@WN[#:M
\BY7bGBf4(M/FB(X9Z7UI&W03K?R)D@J,WX,eXWB9J/7@E8C:Y(#2ZXGT=@AB[>-
M,-;=388<6UY<3TBFeIdSbL#f&b3/KT6DbDTTE?.A]dBI[8X8d)=c\g4Ed2=d&PQ
IU2-U^9e^)>C(YY-Ge((;&2c,4.,..;,)N:::ffNQ]=5Z#K0>R:XR?Z=#L=^[(N/
b]I6D-+I26Mcb\V-#_a,1/ZOB-+A<dI,@eM3HG1^Q(BA8NV)3:A8CfQ1[3:)YMI_
I0+K4EB_[L4bS6?DO\eBQN3b+VTA1C/56)TG9G-ZV<+YBS.aJ:]##dgQgg_C(/#M
)+)8dU^-N5Q?/cZS])2J0[]B(AO&FT&Z;->RX>;dM;cIO-Q+Wa:\THX<eTJYa^X0
\06dWPQd)cP6N1#6gBQ,T@GSGb9_#N7,>GdK?R->+<?4/;H5B@J176/A7WU4;\04
U>?09PNFA039:^Mg:RY?gcI=+8H&YLBbgfTW@6H\)(5NP=D9J>\_D5W>=EUcKVQ^
CS7=gUcL78^gWWM5OK6X&\SX\D\e8RQ^YKf2J:#Y<Z8BIK7Z3AWJ(AVHK^c\B(]R
/1-YeHC9^cB4/eB5+M/BcK)F\0@#Y29E1g=:=K.Q3?1=_\BQ@927(D9MM9]c?S6b
-T@]A^29Y0g3-@V@=T0__9@c:-,gXN.WdL9G(TS[O_9&9=\Q@+)X0@W><e;3+3C<
;5B7bVBcRHNLE]_B[:eYa7C8><\W8E.+UJK1F(1L[E..N))):\4-&7(X^4Q]0NF-
-e0ACCGL6LBO57RP-/SITd/=F\N/&7cGaXSW(1aLV+bc<</J<KbXc/RA1(D=cb41
fb=X+9FGA]=H+P8D1fI-62IffdT=B_\;,Lb5,71eBJ;(+L3c>8^(3+QNL4.f+C2E
K#d<.9L87^&V/NM<3NPe4+OE&gacK1:6[dMFc)CBHQ2JQgAg.(?Ge>3NY^E),7XC
5<cJ>A<fC\BHK]:+XZO?Q#0IQf=8F#\GSBgB#&0BSQ.-#9;+2I70>6:6VPEMZ4R;
a=AP_bEVdBF3Z)ZZ37(f];IcE9NE,F-Y&8DJK1M\W_3SFD2369[aeDA2S(OWRZGK
B#;],A);eEK369,J6IaDA(DC,cG.\a=:>bNUE<?\<-CFLA\#^E=))fIQ?U&01[Fd
M248Y&ZBX@Rea25a57,?]DHgb?7F;a.#C?++ILb&fXMEQ#Y1MY:CSJF:1BJ)gOeQ
_3(.gO,[^,,S(;:QFCB&8655e)Z.,.=U-Y6#BcFZ9LNeO@aAAF0OSUOU1X<fGB9c
@Xg_0@c3WfWPB/aSVV&B^T<,bAaIS<<]M9<8+QBOG/)2O[9eX+F:XW+O;Y7,dM8O
?3=L(.U)(^f7/]_SaG-1].^gU+R9D0J8;4Ff6,f#gAeE5]=_[-&c8D,7CFZ,+cJ+
>JVeLd+>+O>>>6eM0F^GVOSCc)KIE9F_EH:37,592&SA#\VB6I6CDM;)9=+#g:\R
(Q4T,;@TFM8bPN63d9KGGLc0/7E86H@AT3U_:)]M)5[Z9,1IGLG4e?2DD-\D2-A[
WgeQBZ7O8BMIGK56K-L/aQ\X<[.PX3fO2PF8Sa6eI(OTg<+YV/3..:LbcRJQ[G<#
TV[86)Jf[VHZAJT3KCMPJ)ba+M&9[C1;1)=TP_F\S>AdUOZ92XGHWCB_QZS853\:
g^G19WA54BaH]FNQ:BMBQ?&]?)I_3aaM^[L/&a11W&-TWK75/BY?VdH#_.B\/f4(
JbABD^J5=.EG2O;[N.45T[STB40:+F88,GJG:bBM@_3&\WRXSJf.@:;[NNLf;HgR
ENVDAT-7+[OfL0P1=6_<GV3&KM4ST.8Y#[;4,8Y^=YZWZNPc]bRI)6QAAI@&@.6<
V_?.,@3?Z]Q9PV&YEDO#Y1&M\+GfS^B7b#a3F:P=\6H]G&d\BN;?WeJE0fC;TOOU
-=MJEB#T7,;LXP?VdbZ>8S(I+3O)[ZZ5-6+e/>+,c/79OKdE[/:?JOF]AP2U9?2O
Bf^WI,.NN2?TD79LYW[^5)/)0B@DF)[,TJ<TX,f[KbYN90bPPDC3^=A:T.eCE/G_
/F[Ye,,^XHRN\.4F]TS00AKc9AZR7VIBIUgQV?g->.M?R<H;NS=@@^[I)<:#@Q(6
->BLPF(,:Z)OD\AABJO:ECR4.RKfTC_4dI9K8K?Z]T.:G+<VaA=b34>C+A:]<adf
=XH-:TCeZ=K24.RP>F<Y)2TU7W1W]Z2X=PC:L44a@[>/0>K+HSXcPI18P25e7c@N
Q1a5JJ78[d#>D;^Y<Q-6VRc7MIU[fg3FAK7]D7W4&Y:VI;bU47QX/X[fX<:D=ebI
)VYSa6e0(V&RcFFXP,BW<K8IN@(G]>K,f:7)BX^G\;WDaKEX-D.(WK7c@:05ZL-D
;13UA6WcdUW-H>719#YMa3[IBKb_E.6EORI?NBZYc.>).::O/(#V&M54g];3^=Sg
OZ,<FD]4KFV5Kd9?8D#)H-#eC9GO@KBX]aMf]eE)C/T])?KMdO[]7VFfEAf_MEX8
[AEIQUBW>gcDX@^8eP4N/9\ZgPQF0f@Z=250/eJO4KPP^F41C(V9GPO]YRgQKUQH
dHM9?7^7>GDcaOT^3XQ(;ZR?O1.N[[GS2>GKH=ac]K2;Q&fWBIe_.>>==?XEGeaJ
7aIgBWK-J.Z8<gNgVbGMWP2>R6@3U>;f40]@cFL1:;R#-Z#+g)gW/P0QgC>H5^+9
L.17VVV0L)E_&;)&JR@]T4QR]OT54+7_)LA;5UN;#C_8,[+fRQMS>9aCgNf;AF8c
WX1U@Sf\bdI&5,)5Q+W:V)9II/<U>MKV)O^YIJ&1D2\8fFGD\8;FMIXO:3S7]@@1
KPMX1F34S+.11DdZ9J>R:T2J)LV/<^M/Y&cg6][5L-JZ1/VREC-@D#@#_XU(A]3X
RN:I4K]b<+QU5J?VETT1SG,XTB<a&dHU[U&.1M3@L:(fFf5?[3b2,N3YcU),#8)B
5B/\a-LST2gTHR+e[G-NTFaCEHFe#NH/afYc\>X3F?<1J);B.=0M,XfJ9I9SCDKZ
U+1c,aT0/,A<S@Qe6;VZYKT^+JY^gY357@_M.=4GG8M@XF\[8M0T_3FN@V?,:/:d
Z38A3OIc-NI15A=K:^D11^(D.56@QA^+H,\3+Ff:e2L&e+/:JIdA7]e[YQTBXBCI
;<,>C,[#=@-CFFZYWgVJ(c<B?ec:O3&<c</W;>Id>;c.L?79L9SNIK>#/M(9ad^X
[J0GKXVBB77-^_.)BgP]dBX&]P.0RRV7NFI^g,JMCaTU,)2NH:47]Y&/b1U\:C7E
RXdEe;#a5(O:_/ZP>TZ1J]UCO]RD;_a:VIa@W+7,CSbH3Q3>f]B#B_/3^@.@[d89
K)8fd3(gTFX@>9BN3)K-13=YE3HaP1D.#C&=C^I5=(GDZ.?3]&PJ_T+Zf.;Y4DH8
/#()(?QS0-&=?10\/Z/Zf10\edF:UaI3L,B+[CFWP=aVVK8ZAF7F#PNU8FIb,6\g
R=(]Q1)GZLM,BG84Q3>BCc8?Z#0?X0YR_YFFNeTb?&e^a]E3fec,MAEXJbafBCQX
K<NaQ@HY6)[08(>M.-NbWd+\O/QL_c7_U4&Z,D99CbHC?,)XVPU<7A\eUKJTF:(,
Cb731Y#0NO&F#GY1U^YS/.#YMCd<aNgLQ2=9cT]@6[#AYP]W2Vd1Z+B@cFY8)^_^
<SS>7SI4_eV8)QMA5bC>FPH_FXgLC^3)M6,TNS4:()e:6RGEP8McV6VPC8EO83Q/
B\]\edRS1&R21C69XEVKG6;WaD-IM7WcFL5<PC;+cTHY-^=G]+RENXfWUJ=>,CPJ
U^f#PPXA?eY48V:)J0SCD:AbEaKIZF>aIf7\QRfX4/W\9)g\7A40?daLKFfg6Z5X
a)a+Q+_5N_:^[dDZeAaXb\CI>P>86KS(3.GTFLI3=.-8>1RO;69]I4Zca#Yd[IPS
Q\.)+a?-I@HQ&\3@@ab6D?0gEd@5SU/<^AA6L/<B\27Y)?faP9WI^(cdf(&FEM<L
LT2132Qc6+gL=6Y>ZcHgAQ-A4,XR0RM^\d9DYCL:MDD)XQc^BIX,-Fg0LY7T]_7@
YcCUC^TeYcN7g9--d_ANIH<3)#G9?MH[,<5&&_C^I0=bR3[eLX2UbO&\[02XeggW
6SG@-#D)Q3@G/X)?X<YF71=D]E^^KQ[KdaTSAA/e[JO2g0[/[&X?d?U+UBRde>Z,
YQU@cP4(NZ6;>K7ZC(De@f9JUbe4JHR#JV/Wc#VbIP\HKG<4<fe/Cf<ZY#B3dc(g
,KaY5&<@Fg)EP=)8J5XPc/+L&eLD?4Xa4fFUDS/V7.-/20./E_e[]H;UFIS_BVL>
NaNA-(YP:9L.d_>(_DU<3C&[X/0,,E):UT&374_a4F?L69RL,H6I+0\HYY75+7P9
Q3Ua@a/_3Xa3/a=-5E=M.1G:)^7R;MCVSVHVM<]LeWIc#S?MAH#8T,:?63Ad<eMG
?#VS7RdA9K;UGSOd6eeaB3#ZZ5Fc5^^7L9?5_>QVQRU;]Q99d[BMJebg-I>[62d.
,#6?50@B:8\B2H:R-dU>5)E5P=QO6E@=+KTR\AbWT(9,e^TB_,.+<dBAS(U\e_D&
9^X]NgKPbReEURD6[AZ>I)BW@(NAVCXQB6LX</K]JX)G3F-[&9V4WF(1b:#6F7=e
\E8e2]1ZV,CPHYf+VV>US0X1()IIFL8T=)=/:dQ(64WeLLRH_f3-H?H7I1Q?+gKa
./0=Q&a4U)-/56C.^)FXCLK+IL:5J7e+GCd8^OGECGY(Nf/W@-3OLQ7\4WV]\;-M
&Y35P[]ZJS?<;Y3CARX93D<LIZDVDJH^X;DbX<KUGc43Y^,C[+S:P[@AR)2:0f./
g-/)RF2@,J3VL(V9.,K(XEBYfE9d28XJ>Y&(>d<[=TALCQA=9D>3D5)N<YOM>:69
XM@41:fR+4I_/-^EAH1H&.(aQ,a1Kg[Y7:NR5@S(43+=e->RMD/K@M:KQ?,H\5YQ
F;Gg([[V2Z^7G<VDROLC&3^UI;F,UW+Mc)Ma9T,+2f&H;R,RIFYVT2D>U:GTN5^3
9L9)+fMU3>W68J#I+C9>eL;XX.Qb@[2\Ge3>32@_M=eB&@U/5Q]C3VKBN+G@ZNX:
UbWN[?O?R0I,[=E:3,fY0SgeYEH2&@4PE(5&d4K?Ge[GO9DNB/?.AP8J;,^g[(C)
XWg>9JIb8_[=DYNR8>@b8DAU.UYEOOS\&c(cDGGb6D69_N\K>7L.C(F+gV9a_Y=T
4_gb<1&AU4S[N#EeKTfE[XE+OC4:S9R#f:^ZWJ&>FCIVb\]_O8T]_Oc9CV>7]5Vf
LLF9bV[cF#8FUDFaODY46;XNIbM[bZ1]-L&,>&0DU2W22b#HH@H>PCJ5Cg3U77]?
X37?\TXK^IGY3U<UYX@-B6UX.b^6JZ=2S8P?_@G#/;K1\,;d\EfF52a>ZFeO?J0+
U-T[PKNg1QO;;;/Q:8-JH_M&@Wc@DW];bYK6Gb=UM;:c^c]EF)-W_F9RDd]M(LJ;
]?)6>>G/CJIHMC#<\R+4]?&>.#1[@fe&3bTcDN]</SH]H-gVC_B6\AF8+IX8@6_Z
Pd4)d0\H++0/dCa1Qb<Cd#&c>8E6J]UQWZG>/OWU-0;O8V0-YD:De4gB5d)^FKO_
O95NYFaYSS1.K8gd+aeYLW(0f_[0-=L;A6PU0/69+JJ=+Aeg68Z0<_a1;4\36\b[
E/.cZ,?CYZM4C?WF9g+6]e2OA^fI;.IE^P3(+1&cYLS)]DPGdVYC@JW2EGR/_)4.
aN?>K#)Ag&cP(3dR),/N)VLV4#8(d/>3dG&RKW+PC7bN7T[OGYHPDQJW@,<JeIND
Z#RI62NZ<f0-NX]0#>IF(?]<D>J)<T+,E?cEHaAC-_=440fMGbP/,_E\<U3]L9F@
F&6/^\168L=VeV\c#KB,ZIT<BVO3@Y#0OE,QNMfB1P<]5IS+3aPKCT,,Qb/214df
6(.8D&f^^V^?^UBFU34-@J;dUfYbP->53QHN^[bP<ETBP-TFW,4>^cW(CRd\^SO[
,C7FEF>\ST>C<H>(50;>H^:\QJ.LKLSbFe7XEQ(_ZN:UeG,P6g2(KT0Z=8W0,Sbb
>fNUL3^2g@_)1W8N=ecaf/0fZ)W=-+aDJ38LNQR)V[L81f+<?]XQ^23,J#e#KV:1
1/BSBZGR2MGF7;7#CS/A37;3I_-Cdc6b63=Ye42/XL(AK\.41R]&aY\IFYcO)XD[
@?U<3aALXQSdP_eJTH112F9:X/@SN3:.\A-JFN.<,.,9M\3fJQ-A-GfT#a0QcPFD
8Wb0e8Z<bUXZL;eb]4/2+6Z0-d.[4.F64#^NVKC\GW2V2SQABVNd0gE(.]9(=W1J
^G,=I#f95WDK,VP1XK/4KX3V0Y#CNX05N7JNSC,,g_ULI#S^34#C75X1/8Nd>C[(
]9P[7S\CYMRY3WQ9N)G4cAaEJ&8J#@W^OeFNYLZ3?I_9,SH(BEO1IY_2SI+]PcGA
0]QBU.R8L@HO8OagR-6gFCW;VZ@Q3\MIPUfAHePO4TQ;MQI,2P:IA[=NPPBa39@@
BT;Z]aXX0@EOH[Fe=Z,UW+UDTCEIF8b3-0/Cg)>M0c\UREIb70GJY3R5Q)@_.&:X
\g_MNCeFKCLQ#29)e9@ZVWaWHVR_/1A#DJW&.Y:#bG.8]<eYdgc&PYW+CLD&&d5E
H]JX?0@BCT?A?(8gM#JbEcW-O:aX;_7-AVGU:9Y0D:@,9)Y1c1UY0aP:f[R^_07J
Y<W[eB(IQZMBg,JGP<RNS.BKMRATWI^dDDMAC-76I482N\b\\@X&<[]ITEd]QP\J
F6A/QKT5WJfH,<fW^?0df^39YWbfW(0\JTXS8fY3SI.>7)JM6c6cO#3=56[#J^1-
:J^aWSKa&T;=eZJ6TGQe)SW(^DD=LPIRD+#Ud[U=EU7DI[54HWNH3ZF3P/L:Df8&
cB@?dX>c8Vb7;^=cI1TK1T_S)NP4LP.a_-:D\_WFECfB]-O.5<6&KF@bHT.FKACG
,;AU\P>)/O[+P]]YLf#&\;\+aO_LIXDL\YSX=T6)]EX51/Lc39ePK+8:dWCEDB13
D)758]a98^/5L:Q/ADML<.YMVg7/M5Y,&fIO^.?N4bSFa#aZAL:5_A)-4[7#DPI3
B66_8>Za)_,\-3dN(e;8#_D[a?EK4.WWK5MF=#cND(5#Q@S3/SFIdYb3.>gY.):U
=QHXBJ-A39>MLS/UIF9Z7ac1bc6JZ>.FI>,&NIb9;,d+f)/XA-M96VJJ^PQCQVKA
.J10CTT9Q]Q_&A_,XBVEe)WOa>]Z(2</bO9R,+P]DO534/.M&A&1QIHg/:84;eHe
aLJ#LU]_^4)J1aGTM9Z1JWN60e-VZMV#U\EO(_/=_>E+H@Z0K7.[S#H()--\b@G)
UD=<JZ3;21-da,I(X3J+IO<TN6M+:QC1S#J/36?ET\[5KA.e-[P.\K@82?]?:Z<O
\7H^GHLWT[8R10W<+bLb)>=1S#CS_NP?(.a,eWRAH+;ODcMX--5PR)=C&GIf66;5
U1(&8&E_32df_LS(A?2Z2g7/Y+2=W24>=:#gZ;U2SCHeIAMZZYM<9R]7H&O\cc)3
M/M5ZYe<RbF]&LbcN4?L(4W,:HH,Q&_X6I^c=2[JM;L:?cXSWc^]8eG?ZNY-[C\1
afMX@D/L;NRQbIAAH._T@@C;V^dZ6^(g^X]3M#FVe5KNAf74cFQ?4b@K9#Z>J.Uc
LJaP=T__GURKK=GD:,eW^S27:O,2G<9)+2@G2H7,EbEUW1@P=O[?<I+bgLGVU(7A
8M1@N/fG908Q-FbAWCRS1d;EY^M#OM8[S6C=\U]X>O[e1X9Zf2JMQ7J.23]JZ+5&
6YKD3+6OR(+QOBI3<Y&(JaQ2P)C6>),;^[\T8P/PHM?HH&J7C[cK<5a)MHIFEE#3
[R/?N7d\f(:)d+g:[8E2bB5)WO]TM4M@4ZQ&dEIdNG\+>AR&A=(Te3aL-Y_-KfOT
B[Ua7@=>T1(W^SdKY]ZM?R[X1F:=I19@(^E(HQ:+/+(FB,W]JR/@<T0.gCKZd;_7
=?J\#@]NR&g5E4)DO2:2MGG(G/d=@L<K@DUga^Sf][=9RGaXc.(-FYXQ;>UL.Fg<
MJ3T-dHYJ6SVf(H/2Xc[0>S)B@+PI\K1GHMFB<JQe(+Lb7dbc0Ba,LYG8AQY1,NT
[V4(Z5+DR<)Pda[;.)^d3FH<;9T5M.4:\c:d7UCfF325fO7GEcV>(DZ4;/:?#H5F
H:(ET^)4KREQ/)].RTRJbSYM?=?9M4WW=][g\A70,?T+B&YIWY->gf0.c.QY=g95
eeHdb4ERc57;QMLg>V0>)DSSMA0#N5-X.OcI-GPI)_cg#\fQd-_+(5bT]X[-gbZ3
2T4QGM(^O;Gcc&,Af7C]g_=C9##>Z^2a.[AVGEQ0e\dKb<\Z./8??_<6TI9@PBG7
?9;O\/_WUPA_dSU8aHK&d.aNYSBDb4+Lad^MJBI]^ZK/COAS\Y;YQBHKMSG(gFf0
_C.+@EA[38:]d5e0&4,1&(,]ZR:ZS_:N\HZT#^K)DPgePC:7c)g>1JPQ;S#R#e53
+:beTe#CC_gDLT@?8Z^R7R;8J2<eb&X7..U-_45b:IUCE-<UU29gG;(.g5M]?9[)
^2^QR6TRW5V=KF?eD]C//aVM.XTC46R5bZ;(EP.gb:S0(_?T>:)OVHVg?(W;@(R>
be\NcQ-FYZfFE\)N01;5U3?af)CQO0842R87Z@H;Ub5/J2W3@<]dc@>g3GPBIbCe
H8N0A5C[R+>K8+JP(a(Y&WCbE<?6-N>);Vg\c\]6U(6>TVIf5Te6N[W]d#/5]Tb0
MCS6I1O@EEE-eH>2\05>VSVM]&Y6AAIX@RWXPK2a.ZYdW&;e^eeC\=Q7S#031&Q[
/aRT1(8e<+73eE;^ILf&W0GW:K9A])>^f0.T<P6dBY:U9W2X[Z>0TDf7B_Qc21Af
>79X?,XDfNW4@I<1Q+&Z:)Y>TX0M-C/)[\X+0UY&aS<,P6BYV]#G>GSc4D/,V/;T
HeR/b9Fe3(]HNJWaJ17+PZF.@)YUL<4(CZM8_&J7JB/Y6@C//5^<0;2F1K@+bd=,
N^@=\BNQKN?<@>@P=AA:8X>KS(.7dZe&PV481,BK1L/;BXXKd1+KY#[O7N2GN8@>
?+)&)5MeeL=]@_P/[4[4\&Hf(8?9B7VcQ1XO@dc/43XTgSG,^3D/.5II@&JGe4XM
cI2W#LT<W1^4+_e2IURX0GdfcZB1&cX1QL(=X7Gb5ZJe41,R=+Q#BYD[9C8cKdHX
d)_VKH=Tf=?2(><+S+_:-E#QHeWdAM.0SFX8gdS0D0OJZ4H+EKWG5+JQ5PVR?G_.
ERB0aIP4838aHH6M>g,a>?W.Y:GX/Z8_a1BP408,4:4AVP)9953V<.5(-[4@Q,@U
EKbScXL:;I.e#VW7V0P,D9(&e>FJT(<<aUC\0WdLFK3RNGfA<&[/]&=))K#DgYCf
^@&?E\4\.2:Pb2\Q(AY:=8c=ge_F,)+X]H@(:(7af:C7C?W,a3#RB);7+ZO<5Vb7
WVV-K8JVS#[AgdbF>U_9C]gNbMY9RfAU_19>1UYEbPJO9Q]^]<6[Z/@0eP+M?@Y?
GIY]aC\G[K2C^G0A+E8SeG[7>1G9S?56L?Bc;VOZW?U]Gf0N,_V1PN@SUIB+17SG
?H[-#a5KL7@b5EEL[3TS8K3fBc22JP(a^QVA/-V&[>EN]^S281P2GQ_A;2Y4FGN/
,-aQQKK(bEVa=aVEfEUI_-IE)]6^0RLeH-<S^cQEH)bQQ+1&/BZ@QaI]9_cMRL&g
C43<4O)Z8VM9X3eJ+#2C.-)gaZ2@aYXU>A;gMWST;>?1W<e>TaCd@VaIbB#_Y7L5
gG9Y1M>\:ID<F5EbC>(.QK)V=4CKKK((7FSM9C3((6T)JI(9eSNDKT[75H_-6^CD
7X@R18\#/bSN3,[V3Q3>e1DWIV>_1B3VWBf_OPE\;KXSU@\aAd=R4./PLNd/a[FN
4@:=ReSE@<U80R,5GEHIO3_6cU<?4E@?Z-e?;[IN]Dgc:HP&JSeIa=Z)A-VS^8)Z
cCV/&X+YUMP[c8.DIW?YUMTCPTHB256O26bMfHKF:8[19\b#2]]a0MWaHUZ06[(,
[4-+=1a:M2R2V1Pc<,60K\3G8B9^;A16O/a(I6)2<c1UW]U5[2L^XQ\#a&ca,.[Q
#B-GGK.4UZWKC+Vg2(9+#<6PA=C]?D]5R5@./&S#f.+2Ee?+5I:,AgQb&3B.Wa9^
R0b>P_W.^CgAK3DPd-QNf.QWRQBXQQ0@_=:^?8<DIe;g)F7,TFPWe=T^]fU6Z7Qf
VUC<?[Z?T/9bL,;G1J]@U]M3Xe?O3Q+Z8+755XL1(\/HGcP&Z2JU1UeRM(4LLCA\
QK1IN\93,=:WS[HIP7fVJ,Xa6^[gBc(Rb6FRM6GC.3G,X<=C[R@ag/:.^J=E7_+<
0DP:;4MG.d)=QRUfY=HY;4>aHdC5PVK1,d.TUdf-6)7U3-FSMN2X/?F@g67H_B,<
ZU]:]a9,;M<GHc8cNB^^gOK,bCJ0<1M@f^6#XD-b-)1^K32QPd,cG:6d#)N&P0(J
UFM8K531d1#.02aK>O),>7&&#T;6D,<KfT^ER&7>F6U0A>WJ8=\-K@I^10ZI(H#1
>\X1bHeX1YI@QGIV<gFgg=?_8P27I#06)\GeeK)0T8bE.30/I+@3QdBS<U@8Y3:(
1O?#g:2?&XQODAY)=C&-(cT0B@Q>IR@.FBZ_/SPVK4S.bf=1TG/-R[g(88_3D7OR
cH=bf)Rg5I-D60M+NL8Af/8M\#ccc>E1:ILZ8<.69=;d=PO?UQ,P1fFFP\GTF.2L
WXKAJZ<^UH#IfM2Wb]F6;aF3E=7P)_EU@#[,TDHN]#3M]X744S3RW#-UAefaG4&X
)e1+.PTfSJMc?DQ(=TODAWU:POO316,[C7Z9/Z5d^L:WMPX^-Q49JEObg[dPH?(?
d;7b6bP>D3V5-JI/QNPW8T)>^0=J3_+@6M_A_CY<#SYA+.HEW0a]K/]+-<5_IP>M
bXI]5;,,Z8G[DTa<M;:Df/T0F;,)DV.LOJQMD&Ge0@6FRQQ_#)I8fR+a>LUO)Pd6
49c4Ycf(RP)C_cQF\O]Z3WbObSXUO&N7e&?E2?+&O;).P+]N?H/DQ9_G8(aH1G3M
Z52IVbB_<I<C\X=9^8cRK)YZ>86U4C#1D.K=-=BR.V@2:&JPf2J4R6DPA:8SK+3@
/eMZFbX]\A[HHIgX(cUN[&:)b1[<.TE)&^@(J:V-0P(1:.cA0;Sg7C=Z<I0D-4)g
D-;I5:.>eCc<PgDXA9SJY;^XfIJ-DTX<JQ;BGOEUDIX\]_b9A>]+)+K)#C;(eHB;
EQ+P:0VM6>30e4gU(IN@^/(:K3,[#SQ4=-;[@?KRc9X<#Ec=DC.LL;HO/-5S.EO3
OS10?:204bf=0^FV0cLTLX[,;J8O-XY+Y7C5.Y1SGWU641gVM,/K@=?2#F.SdOW]
QF889B+:?G9fTDN2=_#8:AZZ/=KY?Yf[:eb6LdJN^E,]]VY)9SA[He69e/-5S/O^
9V4NO:XPS:<T(S:NQ&c&f.:a<E-aW)e-+8-4EZ0E+QD]KXc3Z8P50Eb\&9e^d^[+
ZIK9#c@9>_F7=M.42H.MWI=,CJ&5UDKcP,b7X0M3</SW0+a9c4#+QP@/_>dF8^c2
df,##EeK\ABfIGc<;fb]MV@-:e5<+BEUO\1P3#2):Y>3d\Ibc&Q71cB1:;Td/1Qd
1<@0#aI>@C6)FDA;TVe<M?6H=.@\;N/KOZ]bUN_(<.@OL#2[50FMKHJ6PfU\RG52
,8^POL3#KE3R1;Z^dN2ZgKAFRQ)SW#3eW9[U3GV[A53K9KJ:O:aBSH>bEJe85>?1
QQQ>0Hg]-_N1^HR?EH&=d46O1O5K3EeYe7)M:K4LYS)dcTbHK<e3#4B2f)JF=b0S
/E5575,XbU.A#]>0X]NL<RH,:[fa8(EF6A=]_NT]ZI4;AbAd>]BA3YZgB^#LabGQ
6FO@^;#?;7EFb]CI:DJ<T<,?J1,aY)Fbf4O]Y35e?P]eUPbPY\P/I0Cf>.X<OMS,
.YF>K.Z..GY4M7-W??a#gIIX5GAgfG7D\#,L<ILcO_CeV?Ac,LZ<+R(#Y:Y_4DaB
J96\E:F0H22>T946+^-,-#f<2g4WJYQfRD+L^Kc04>@gGO>>CKR4.,bO.^Y/N9.1
7=:^Te-E7R)4EYO=O>WF0<P@/7(:D-;e0HN+/L_0#N2#Mf4\LbVdC9_:KVXJ3]B\
=O#HE,ETWS#JKb)=9KD1be_0-5LQE8S]VD04Q4YX6eA;[P<@&M:TR<9J(Fb;B9P,
QCLE>\PP/\QXFY(\IQ@)1CfWdP>Og^>HQF,Q@_f]>@X:DP1X>#V&^A>A;C#ZG#/=
3=\N\#Z,3G;F>HKZ7dR;<]\)AWe9C-:/ZQ^U>fg3\,a4A_@GgTD,bN4WV_@4fE8O
#SLLVG6G-VUVUe2\6O[eXQU9363Q]__DTf2;4XWG&F=RA8U,)gXA-3OA@.Xd1]_Y
@&0de=/NP],,@K^EaY52fC)Tfc<QLa@-YZ4<8HQV1b965I/]b>J<Q2RGAXPV@:PP
<fZH<CeX63,9WN=.EMLcCJ-_:+3@0#+_B4D>B&NR]\HaNO8ge66ZPUD<S@WU>eg6
\,Q^SB:Qg25;^::ZY_&C]K=&@ZUX;ZXCgEb;SQ\?F_:#CRD8:-]BSK/I.6MZH>Ld
fD<_R1IAd<)T4CFZaccO69NZf;A/98WeJbce[JYVcW<Wf),4J[VN5@VRRX+RZU23
K>=[_aeIT1Q<SLe;c0_7D7=^Q9:#7\ZQ4AQ-ba0c7CTQ88:?1/(_AIT38e>ESCe;
L[@IOFdTE/9R(IQO3TQP/fcXfI+]W/PBRYWOXBfUC+-UON]_)W]FV)NZHSA/_4:B
X4?LBS9O8E)2[&P<7K<[Z0_3gS((aB53F&FJ46SKN@XNV>(L631X:JgMgR;:-24H
WBc&@_BX.SAE^]PVbHN-@P\IS\.UG;1,-IJ\HdWgK5PV/eb88/X.D?fKO9Y[-]V0
#N0P\=-_&PZGW1ZCM=@BY2>S(Y9@@9HcVTG5&,+1gNYI>EMMfK3\AL2\Tf.0@98N
\R<eA3f8ENRKWJ-Q&,#d:.,:F;87Z;8E1c_=<UAf\Y5/46O9.<=3:a2<H)5>HN7Z
L3&V:7&JQHYKHZ;_62\(G^@:Z::J143YI5@XSN74-be7ee68-,]J&<a:f^ARM0@X
#CD8_[FFB_?Q+76RNaB]QOVK:?_:#d9NNMaRVcVM=5LFW)SK?<I3\464.^Q9<:g;
QC&7WT<.g5@GXEMBJXQ=]]Bd_S#1R;[\5:SG2GYH-eI(DbPEI<&@\P1)M9#<D9X:
eY6Q71B.8ZT@BdHPF)-<,QO=8e8[/He#IM,K.10Hf#UG6IVcc[.f:T-89\&f[VPa
[e>^6A\>ZM2=Y^Y&Q0P.G8TVRC_K<7@W@C.B(eMH>ABJ/.gdB[>DIW5[=E(Me^\D
CM6TT@;D.4UUHM.:V+S;>#I^g7S+SDa;W&FN9QT&,KXT+<O(cbM(PNb#f/#7V?#a
=[&1\]VDX=b?J73TAc6;fZL._&)Z?KW:P>fW&@b4dH]IA84[MWC,E]UdDH_Q5.P&
I(LOa^9d&[RG.<K:GWL/F:IKe&JP:-_I,2(H9Ib8AV6RLe5###5B>gDVb+_g];>_
ZfM(]#+W(a[_0P\_IG:]5@UVLZ?6A;USW/+W@.PeG+<+)Y+_78GQ)gJQCdGa\fSa
8J6JEc#?1T5K:PBZHecfJceN=VS;0B>XBg()A2=_WS#;88P+\QM:9Ac8+[RfGUS_
ZB^=Y<WEJ]WP]g=XBEVPT/V0/T8;@eB>59M>#g<2Ed@^ecJ-ELR;/-7Y8-5UEDY-
S@3OOg-)d5cM&BQ>TULBQ0JcK.[K1d^?&b_J?3Q-[g3PIQ?GcX7M(WF103g.+Rc0
&D;7ZD6>AC+GYT6Y<(UB:B_A\02)X1-E>O82N-(B3M<)9CCCD1?_OB^VFS40QUfU
Og.NDYTKBE++Z[7>4K9//Sbe;LO?Z7=MR.2FD^^ICTaU3G3@a)>N1UONdCJVD):b
[HV<?7F=N/850QLef_(;c5)e;;K>#U,eT)-:-/Nd:Y6+@Fec:0=0/7,,?bQ/O;KO
&W(_6>Rb.dQ=.@G\46GB&ZL@7=Vg6<=W<)8&LO]:SEGRZ(K(7W+G&X(I<0)QCE/A
S@:=US:6-&XPT@AP734S,/01AAJ/</b+A-\A-ZbYEYWH7C0+#^Y&G+K=6bH2\&]E
R+E6R2Rf;FS7\bHcFU;15JNIMN[==/g?J2a4F;@<g1<c=?=WYAbX7FSd+eJ5[AbT
2<g,b0T7JG?=91PYV7U+(86f5J#ZVebE#3#f(\Mg9dfUXg0GI;.2B5K2T;8OWM\<
cae(HJL[a2A.X5?&99H/B3^2.MQN=)g@a17[\B:a,:+T7(_)7NV@fD05THP7FGCb
ZP;eQg4HbTN3V(ATEZGU@b#OC^gQJX^aQ+RD7dT.+BQIa2.0[b)U+Y+FX9VY4P52
;cPe:T:3Z7B_;VX/@A_9TTfJD_@[\EJM_^VT??]=JeW/@E1FX;+6f6F44^+7;TB]
<XO,?a_+OO.I)R8(>OUXHG1a>:b;]5PW0&@41af-4Q&JRVc0.e2f^d<+2:EBAb+3
4Q#I-G<<R^?_AFA;(JSQ^-]P4C4S0R;9@6RL,fcV9d.e\eXROKN^L\e-X@.AQ<S8
4TD@KD_)QC3F^4DGfX;KB>NW8Y?/2]?X\ddOH)e?HT\Y@C\A],VVgUgaJ<SIe2Jc
6#Y:Y/R-K&e3W/^0NWHE^-G-K8a5-_4c]_f7]K&MRZd^&K59He/7b2>IHWAd)HBP
6DQTED0aBM6UFgMHB3CTR+MU7A#C(ZZ30ZH3/GQU):W9(1Jf?X-M0OT<FU/-<XUe
^Ucf<ff]J7)eYH3&T_Pd99FSd3L3VbMJ+OA-OL>)@5?Q;G0AE80YUE2e0@eb)8Qf
4<OD;H3gdQB-,<XNTIZe5&d)_Ta_:B@HP>03;f1:VGG^0]U1g0X8(QH_#NBB#e^_
RJb+S41>,<X;<cRJeTFW=+00&R/]Q>O+<I;UQ/ZRTTJJa-T11YI11KKT/?CX5>CU
S.FNQVYD#,fM6BBT?B+>?\@Z/QT^VN5Vaaf3R#cLN09_g?a2(\RO_AH1+NM_:-4L
.KE76B]6UH,@b<F;).L#bPA2>6U?9PP>;TTdCHRP/Ke+;fMULE^bDEQHD+Zg8E:O
HfdQGXKYEW,eH,::ZbLETf0gE1VDUT.XY=L=MI_XHeX-#FU@.a08/1\&Z(a2aL4G
SY5Se0X+[a=e+,Igg(^g5a:aZcVDVbgeTg4dA[Pb)&<bQ]YOe.DC1?>GH>,8^PZ(
]ECd3:<XU\K:INCAa/d+/Lb<U&b[7Z,c@9WIfIJ[\N7&H=GT+#:\/3Dg7VZ_,E#5
615O(_+T.:^PQMK(5KP4I8PdH_\N_L06J[4)&@P3C7?a-6<R1Z@W3SW8&XQM&X^&
F8aP5;I)R<:M<:;.QM(\?a/O@_fgNCN=DM3(TG+e]:]d\?V++BXQ5EQ9AdJ]GW#3
YAUUEAN8V\;WJV#^<W.UIEIW,J,B@H=:=FI<]O[bF?&2PD#S>J?.L^8g;[0;<<F8
&SLESVSRTBY+1(d017Z@1/+VD5]K?&19G[763Tf6M2M?4dfPO3JDPFE=gPH\O:\Q
1A5Kb^]db(R&93PGL_abO.6dZ.X_DAHQ71N2SaZQ(>46D_Oge3TGf)6Y3;&+T8;A
ETQ#BT9DZ2PPd\EF^:0(2X_^3NbWW-24G6LA_/VPbdb1f6f<J^D[#K?@8.STAQ#K
G060d.51Q[P7>)B>2+b[T:R-c;bGNe^7INSFQaGgc)>QY5-T:2LKEI,I416YA?AD
#eZ?P&DIH?G>YW6B]Ra@>E-MJARG9,)O&K3)GC6E+1IS-L&=(0ZBM>=<)3DF+WU;
1+ZaZG8;UXKIV)g,DBD7>U[I#FV0Dg#LNS^a19#:T8FE92#(NI[8JHC<RHGD?f0#
8?@^.WZW9aJU#QB9,EV4Sfb1@1>dA59H4U/UcG6=H_7D)/O2TR024C?+=RPZ^E@&
dTHBH/Y@UY^f[#,<DY>MPM_=WU2d+OQA=R59C]eTc&bD8eZ:0]^_[><35PAd9&V>
MD6g,DUeedCAcKU_IP]7JC7(c?4G,W=X]LJ#PdDEbf=\)(61]PK]05;Ag^,.gBFS
7<+N[=:)1;E,:&-VLV>P]U;-Ug\f5#)XDFU2.bJ0[33MWVc;Dg0NF#77f&R3-+3a
PJ^O/\-O,XKK>^c7aU#M-HV]/M5AMe.O)_]UL=7/JB4:fKg0IOF6X-FL=L0dPeMQ
&(M/8Ob<WMBgL>T,/DcB3[K&@KCbWMf;UZN0KK06(IR;I[L2?&[gW^+HcN&4B2GH
JdAP6C-A)-/?W=N>@eR#YW+J6V8C.J:Nc+UR4)0M\Q8<CAb-T\/Sa47K:[1M\B/_
RDE?/Eb219ZCe,+@^XXY6DGa16T/V\d[J?9>XV5F]4S..=cdCVfJYd7fc8-4KE4D
_e[2A_VS#GdMLbU1c/dAKd]Y.MWSKY#RFfC4JWFTcb_/Q-6E=DO?Z#N[@SD@gMA/
7Q?IT34=(6eY9AH<5?c02=E;cb_HNR8&_L?@OJ]G8UK<T>P+(TE]4(aXTPCS@c0P
THO38/#S4ag2VISWIKKBWL/3QAW:BNH_VRM4KK#A]J..S-QSbeTBBK^fHM#O<?RQ
^cA8DN?54F7fbc#TQ7,MXeVQ0=K+#[GLJ1+IRfA95RE5[1QXGRFbcT_;a#@b3>H9
5R6]L@a9UV0.94_9#g0OJ,Adb.CFN-]MCac\QES_W8,^E6IN_--A+]g0Y4LZ?4-+
?[)WJ+R]21NSLP_>@dBM5c2PD?g(Qd(QV(6K_KI_MA?<bGIYX:=E)XDf49;5gbJ?
(Z3cAI4,YA#99I;8Q=HKg(D_53=:T+_WS=2^P6H5:X+F<:6J\BbEeaF3GNHACV.9
A[&Nc>_Z768YX6LFNABD\T#g=f57,LgPb3@[,M5@=1b#LTd;TXH367@(J=O99,A2
5S,CBG7d<881.:TIBe7/3I&W+WYe41/82_Z4)cU/5X7_b<+MfXa90?Y5f0[&-Dd&
fYP:MLf<I,;\F6.d=J>G#B3H2>3]H1LKZ9bdUW6DETbH>3Y5^I,6G_@=7e<)H):S
8H#7/LGO3_^3BI9X8.52e7DI,:@\277FL,L=88d@+<5L/>-STRYfP?K=K:FTWH:I
CEfU#=3Qd\8^ZaL48QY/E;BBGOL#2ZFHBXC5TeIa2,.+>3Q284O:Y[5&A]/+Q\4<
]KFa8?<EBc[,(MV/be5<Q6OU6c=Cc^Q5ZK>/CDMFB[E0(U4O>;I98ebgHe]a64,C
,;.ca:c11ZHdJFE>HDU0b>XAGdOg;^)0gEW4@fYF/-[F.;4(:b<RO_ANZE8.^?>6
>Z,XLe(1MM=:P(Id+aEC&(9cHa4Q5\fG_9g0_FE+9B_d?R+VF&N[[W&W,f-WIFD4
-Od9Jf?ECPdPL1H?E2XB(>+)bAfT;A.aH8/R#_M70T+Cb.eBW)2C?ZGBE122OC:1
K]^ZGO2T7J7D_.TLMd)@eR7dAbaX>3(7G+;SRNKU-WU2WKW>#6SYB]/39](UH-?A
AE=W13bF[dRFE./g+?>K?R?=A//<e71ZJg=^N#2/_#<Q>ZK>?(WdTYD0U]\D/e#3
:Z/+Q#\SAWNE#P/P:M+?6;UYfYVYC&?1^dI<>F9_EN,16e(M@:1GYTTY#[?63QW9
[ZJ;V;ASYFSIOG/B6LT=)(JA+FZU#2[;CS:6<@-OWDfGdX2^O)G=PT&_Jf=W3:fG
0>7NNf>c9E.UVI9-?R_8/)gBg>E5eR=+>8Y15R-WHF^E[6(0C(2<OW+cg9EOPJC\
8\#FEa<,WVf;)aEYBe9c;d=E^5W8UF#gEQGVFZfK1J.aXL5E9D?P#AfHG8,](>DE
]-WTKdVQ+&b9eG_a?\/Z:WY_\:aZQ.+CCZ/ZO3?b-7Da?4W0A9e0Q-8Q?-&CX>I(
D+@MLP-2VP7IDZPXK5.d@cBQ49EHA;MLdM/QFd;=;.X:MSMGJ-O@T<R;[NPRNX=H
X,D@ON05IHJRDEEKER534D(bGUJ908?PS6F4c>gFF.aY8>PK&1L8O6=QB<01b#aT
\XO3[\@9YX:8:0:?/OV_W@;Q@1S:_;^aSgfFEg:V8_QINJ>Y)/G_Be;9@A9eaAJ,
)<X^EFc[]XA?Od#UVCQ2\;/NH/EdAOX_ER_9STcRVJU_<AG[ObGRZLN/[bC1\1TY
Y\SLDM_GG;374FL#HK5C1M8(5#d&/feU@O;Vd\C>=ZU6.&Ca3=ZRELB]_cVVd<L0
H091DY]._^B<f+Xf]>&D)cbAYW>@c6Y4@$
`endprotected

`endif //GUARD_SVT_AXI_LP_PORT_MONITOR_COMMON_SV
