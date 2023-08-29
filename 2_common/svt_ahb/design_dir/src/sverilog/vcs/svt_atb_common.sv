
`ifndef GUARD_SVT_ATB_COMMON_SV
`define GUARD_SVT_ATB_COMMON_SV

`include "svt_atb_defines.svi"
typedef class svt_atb_checker;
typedef class svt_atb_port_monitor;

 /** @cond PRIVATE */
class svt_atb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port makes observed tranactions available to the user */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_analysis_port#(svt_atb_transaction) item_observed_port;
  svt_event_pool event_pool;
`elsif SVT_OVM_TECHNOLOGY
  ovm_analysis_port#(svt_atb_transaction) item_observed_port;
  svt_event_pool event_pool;
`else
  vmm_tlm_analysis_port#(svt_atb_port_monitor, svt_atb_transaction) item_observed_port;
`endif

  /** Report/log object */
`ifdef SVT_UVM_TECHNOLOGY
  protected uvm_report_object reporter; 
`elsif SVT_OVM_TECHNOLOGY
  protected ovm_report_object reporter; 
`else
  protected vmm_log log;
`endif

 string inst_name = "common";
 /** Handle to the checker class */
 svt_atb_checker atb_checker;
 /** Sticky flag that indicates whether the monitor has entred run phase */
 bit is_running = 0;

 /** Sticky flag that gets set when a reset is asserted */
 bit reset_flag = 0;

 /** Flags that is set when a 0->1 transition of reset is observed */
 bit reset_transition_observed = 0;

 /** Indicates if reset is in progress */
 bit is_reset = 1;

 /** Sampled value of reset */
 logic observed_reset = 0;
 
  /** 
   * A Mailbox to hold the observed Flush or Synchronization Request 
   */
  mailbox #(int) req_mailbox;

  /**
    * Holds slave transaction observed by active slave
    */
  mailbox #(svt_atb_slave_transaction) observed_slave_xact_mailbox;

  /**
    * Holds slave response transaction received from slave_sequencer
    * This mailbox is updated by slave driver after received response
    * xact from sequencer.
    */
  mailbox #(svt_atb_slave_transaction) received_slave_resp_mailbox;


 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************
  /** port configuration */
  protected svt_atb_port_configuration cfg;

  /** clock period */ 
  protected real clock_period = -1;

  /** current cycle */
  protected int curr_cycle = 0;
  protected int last_curr_cycle = -1;

  /** current time */
  protected real curr_time;

  /** Stores the last sample time. Used for calculating clock period */
  protected real last_sample_time = -1;

  /** The cycle in which last atvalid was driven high*/
  protected int last_atvalid_cycle = 0;

  /** The cycle in which last atready was sampled high*/
  protected int last_atready_cycle = 0;

  /** The cycle in which last afvalid was sampled high*/
  protected int last_afvalid_cycle = 0;

  /** The cycle in which last afready was driven high*/
  protected int last_afready_cycle = 0;

  /** The cycle in which last atvalid was driven high - update is deferred by a clock*/
  protected int deferred_last_atvalid_cycle = 0;

  /** The cycle in which last atready was sampled high - update is deferred by a clock*/
  protected int deferred_last_atready_cycle = 0;

  /** The cycle in which last afvalid was driven high - update is deferred by a clock*/
  protected int deferred_last_afvalid_cycle = 0;

  /** The cycle in which last afready was sampled high - update is deferred by a clock*/
  protected int deferred_last_afready_cycle = 0;


  /**
    * The configuration that will be used for the current time interval
    */
  svt_atb_port_configuration curr_perf_config;

 /** @cond PRIVATE */
  // ****************************************************************************
  // EVENTS 
  // ****************************************************************************
  /** Event that indicates that there is an activity on the bus */
  protected event bus_activity;
  
  /** Event that indicates that ATREADY is received */
  protected event atready_received;
  
  /** Event that indicates that ATREADY is received */
  protected event afready_received;

  /** Triggered after any transaction ends */
  protected event transaction_ended;

  /** 
   * Triggered when a reset is received 
   * If a reset is received, this event is triggered prior
   * to the is_sampled event to ensure that all threads are terminated 
   */
  protected event reset_received;

  /** Event that is triggered after every sample. Other processes synchronize with
    * this event to ensure that all signals are sampled. Note that if a reset is in
    * progress, the reset_received event is triggered prior to this event. This will
    * ensure that processes that are synchronized with this event will be terminated
    * at reset.
    */
  protected event is_sampled;

  // ****************************************************************************
  // SEMAPHORES
  // ****************************************************************************
  /** Semaphore that controls access to the active xact queue. */
  protected semaphore active_xact_queue_sema;

  // ****************************************************************************
  // TIMERS 
  // ****************************************************************************
  /** Timer that monitors atready assertion */
  svt_timer atvalid_atready_timer;

  /** Timer that monitors afready assertion */
  svt_timer afvalid_afready_timer;

  /** Timer that monitors xact activity */
  svt_timer xact_inactivity_timer;


 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************
  logic last_observed_atready=0, last_observed_afready=0;
  logic last_observed_atvalid=0, last_observed_afvalid=0, last_observed_syncreq=0;

 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param reporter UVM report object used for messaging
   */
  extern function new (svt_atb_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param reporter OVM report object used for messaging
   */
  extern function new (svt_atb_port_configuration cfg, ovm_report_object reporter);
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
  extern function new (svt_atb_port_configuration cfg, svt_xactor xactor);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Samples the reset signal */
  extern virtual task sample_reset();

  /**Performs checks related to reset and update variables*/
  extern virtual task process_initial_reset();

  /** Initializes signals */
  extern virtual task initialize_signals();

  /** Sets the configuration */
  extern virtual function void set_cfg(svt_atb_port_configuration cfg);

  /** Waits for a any transaction to end. */
  extern virtual task wait_for_any_transaction_ended();

   /** Sets the clock period */
  extern function void set_clock_period();

  /** Creates timers used in the model */
  extern virtual function void create_timers();

  /**
   * Sets the delays in the transaction based on observed values.
   * Calls to this function must be made before "set_deferred_event_cycles" 
   * (which updates the "deferred_last_*" variables) is called to reflect the
   * corresponding values in "last_*" in variables of this cycle. 
   * In the case of bvalid_delay, bvalid can be sent before the address
   * is received or after the address is received. In either case, the 
   * burst_length information is required to calculate the bvalid_delay.
   * If bvalid is sent before the address, the call to this function to
   * update bvalid_delay must happen only when the address is received 
   * If bvalid is sent after the address, the call can be
   * made when bvalid is sampled (as in the case of other signals)
   */
  extern function void set_observed_transaction_delay(svt_atb_transaction xact, string delay_type);

  /**
    * Sets the "deferred_" variables to the values passed through this function.
    * The set_observed_transaction_delay function works based on the "deferred_"
    * values of event cycles. This function needs to be called after the 
    * set_observed_transaction_delay function is called, so that the current
    * cycle information is propogated to the corresponding "deferred_*" variables.
    */ 
  extern function void set_deferred_event_cycles();

  /** Checks if the handle given matches any of those of the active transactions. */
  extern virtual function void check_xact_handle(svt_atb_master_transaction xact);
  
  /** Starts the processes of a transaction based on xact_type */
  extern virtual task start_transaction_process(svt_atb_master_transaction xact);

  /** Does the necessary processing to end a transaction */
  extern virtual task end_transaction(svt_atb_master_transaction xact);

  extern virtual task drive_afready(svt_atb_master_transaction xact, bit add_to_active=0);

  /** 
    * Notifies the slave that a new transaction is received from input port.
    */
  extern virtual task notify_slave_new_xact_received_from_input_port(svt_atb_slave_transaction xact);


  /** Returns when specific events are detected pertaining to transaction processing */
  extern virtual task wait_for_slave_transaction(output svt_atb_slave_transaction xact);

  /** Advances clock by #num_clocks */
  extern virtual task advance_clock(int num_clocks);

  /** Steps one clock*/
  extern virtual task step_monitor_clock();

  /** Waits until a valid or handshake takes place */
  extern virtual task wait_for_bus_activity();

  /** Drive the idle values after initial reset */
  extern virtual task drive_idle_val_initial_reset();

  /** Detects initial reset */
  extern virtual function bit detect_initial_reset();

  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_atb_transaction xact);

  /** Waits until the transaction ends */
  extern virtual task wait_for_transaction_ended(svt_atb_transaction xact);

  /** Wait for Reset to de-assert */
  extern virtual task wait_for_reset_deassertion();

  /** Updates response parameters when supplied through delayed response port */
  extern virtual task update_delayed_response_parameters(svt_atb_slave_transaction xact);

  /** Waits for specific functional event for which timeout is being tracked */
  extern virtual task wait_for_timeout_event(string wait_event_type, svt_atb_transaction xact=null);

  /** Tracks timeout for a specific functional event */
  extern virtual task track_timeout(svt_atb_transaction xact, int timeout_val, string timer_name, string wait_event_type);

  /** Returns handle of timer specified by the timer string in the argument */
  extern virtual function svt_timer get_timer(string timer_name="");

  /** Drives Flush Valid signal */
  extern virtual task drive_flush_valid(svt_atb_slave_transaction xact);

endclass
  /** @endcond */

//----------------------------------------------------------------------------

`protected
g\fA#\X0(RV<bD/8TL6=CR8^49GPg^-WcbFNVNZc2[+,+4UQA0.R4)94U.]BMBGR
H#LA2>Pe:]^^F66g(5WI1#]2)+]f_>T;Qa4(X9LH+dd<IU#L0d2[c<CVaQL1]Vd7
V1-;eLa5L>9Dd1UfL_QU5)E]0bW&(-TRVUB3cbDE[IL,\HXF+PGE5U/:#cR46g@S
Ic:LaYFcTdTHKHaT@f5.C([6+(-=3Mg9<,M<#,2=K6UTE7UGC4U^()\]SXB]XO;H
TS=_BU-Bb20,2QPMQc2aXDF;H[NAW:SHC97eB<D^\BQRfbdGZD6VD1[(6T)Cc4;1
F<cb2L-:E<(d3,UYRQBD>g+60WWD-H<AW.b.PWIQgcEe6[CMI<J6PZ:(QbIg/L4c
C04&QW<LOY8?M7@=XV5Z@cAN<(+M>?H_BK(9OTgGHbAB?[HNA[K+XD@U1TDT#egY
K6.5DWBL75fGYcdDU64c89a/0gKYHSNZ4S?6V8BF=9V;IE-96=K]7_CBa?M@]ZZ6
f/<.VAD-3;^C959MQ-=<?[<Hac\PS8OMUM]1QEcYQ=P9@eZE3VS;UO<CHK./#K\P
[L,/RH7F#4a81V+FPVQTZ7Z^&JIJ&A9c:=E[cf(51g82_<.K?L^YIP\_B,(586>K
1Xbc9g3(_&E=()J1gcH#2]8.LF3:-47caae3^f@&_G@?ca0P.?DN9c499.Ga<FB<
+9#BLH(Jb1F75fU@K/G#H#=>E3.e;2,><#cA[YN1@BI?66G:dP52B.Dfe>X)#[F,
,#Ng4f\5)YdA6LfZU6@E7-H(<?LgKM5II(QA?88F8U40VKRD4=Y3fMb5c_eNfXG1
b[>d&9<1HV_0)CP2+#M2N7HV+E3e-V=>R(e9/?1RCU=7<SQJ@MQA2GEY(TGHbF?\
+=FP6:)JAPJ)(0W2.a6DOZ5-MGPB3<^A>>P^#L)MVRE7L;-(7^V5)db>Y@(\TfP,
.+POB0fRC_4WFUT4?D+?8=>]84R.>TFDWN.3_]I;5.dde\N;1e27LMO7BCOBZ,K0
8591d_Gc34AW.$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
KZa<O=JE4W:T26-FB0#,8YIHP),=M-aNU9fC:RAbf<<]>b6P+;)_)(;Y>\CQg_41
TgOLX/<=L0b&2U8WGCJc[F:4GJ0bBR\4(+L/BUG0:01bB.U_YX[fNKVG>d&Q&5(f
RIZI[95]K3c(Pc[;Q/\B4:C9YdAKeAdN/DORSDXea+YC;XLQ75JI6Gb=Gb9V4P)Q
1NaK\=,HQSb?@1G\)1b8DCT;XUA0GDD>#PbdI2a,d]1\,=bND=6T?KVVK9Lc#eAM
=SR=9RR98YGP2A8]gf,MNUA1=A3^(a?U]b4P8]a>^2bbR?[c5&DUJY/W(#3EVd]V
N@+FP[JJDT;HFeD3\@SeQ9M4FWJ+<FQ(4E7\;>-;+8^1K3)#)M:Q:b:+7,>bXJHV
ab9V&7N859bbWI4[L=N/AC<GNeVGa915bXJfBeEKQ=Y[B/[O&X>UWEG8+&PZWBX1
+BG1+H[Jec)g7MW@W[+&eSZVQ18WK.G9BB;-EU^OF]/6agf;8<G7X)6&1(0[I/X)
b[=3HdeD9?53(.:8H6:X,bT==F\;.-2CY1(;F\S:d,B)[2ZIcSBfW&+OA[]#4eA/
Yb(0^\/7H5@Qd9M<VFXTMZC>X1Q:,UL=,_G<Z(.=X9f)Aa[89f=D)?UT:GW6WV.=
-Y=W).<->\BQSE8WL0dK,&B54&(8c\T#@?5N0/Aa=2>6]F@?=/:=RNA^^cTO&V:/
,J^AZe[=.<_SL(UFRI5_L/(F7S):;AZJWb-]Pd<c8f@8bdF6@]I8d)b0,;]X?5F]
V&J6NCLY@b]&_?U=U]3eAdO2c=d(?a8>=2Tf<YDV_C6.R\2JUCP5G]=S^]82=>1U
bFFX>:[05.60+1^=R72ED),1LR^1,+A0#^2EH9D+0K@Q-\3,H;d:VJIUHY-&>F9:
?O23fc=d^f2cI/G)LTd;;K^:T8@:LMaCOX[:C62b.)BCFU8cAT>2+H,(=NP::fWE
bYG.,0bA2GKfKc7D5D53aQ^QF6Fe,9QPF/46dF_EKLg^/Vb+SECeDLA8WKD>d:A3
BU52DNd7E?H@EUH5/^:WPI?;P5KV@B4[EIUI9\IGJe6J.e;;>KD8b8EN(0IK0Sc/
[BbgIFIDc<]PM8O;=1bGN&_;WS04@N2G_=_9:&Rc0/1POL>H2/7/.]/=@;IH_9@c
_<c>b^d6SU4gNRY&IND61&X&&:,^+M+<,b5g/&Q5]F,KT[Ic4G/[0W^3V&_?OU+0
/WU.UX<6b=)?B\L(;a\WW^I-+Bc&f_L>]QP/YK/[L7A)3R99JZ(5YHS>Y3H>-K1=
T1T03-,MMWJ6,:R/ZZYHV<H\#^TaNeDa,CR2_^\=J;XY-3L;Rfa8J_NBNX-AU.bA
6KJcO3:#aA]46\M<NTGQJO6b4&;_T]VCQ(e(4DDI=?@4DaG,9B.Y/Ec28A+-7f@9
IGS?)J01dE-)8J;EAC=dfI)S5HVa\P<;_b<45:6S\HbQ+[<C.[X\XT:FY__\ETT[
,#6eOAD2;aYV1)P?(KV;IIV\@?MEH]1H]-N^WHad,Q&EG>A>4Hg@(>d>gHX0@J=d
,](^G(aK<,P4KbS+6&EH:K_e9AVDGYWQM@4e2Z..(OEg:;7MCdE_gD@0=:/S7[Z-
\f)RP112d.#;FI#L:6Ie#\7([f=2XE6ZOLT,8+]+XCH;8@.LX;\13VgWI3IOIBHb
Xe;dK#Qg&;g8-9a=,bb>2Wd^=6KG97?^,=G]gDbTdd35=&cMO.1/KV<G<\6?/@5\
H+_(D6XFH[c]^4g5C,a[K<]6F7-C[YGWNETPH[8O2E[-^f\4dIO3ML)L:3CcgX-2
U857Da9bPO9\R6X-))[@DRa#29O@LB0M;2N8V0VJ)PK_&3-36?=^e(d65TBF8V9G
MU#IgJ:ZVW-Q[4FVM>NJ)UDI,=S:@fMd3H2VOfYL1M#aCF1N=0SgL.d0]@PC6V,8
_Kc<1R0U?,L]^gT.R.=/1dP#,>fD>__e17MQBG/[<9A.FFCc.83KN1^6O&3);b-e
AJG[&0dCYSYG5cN1#QWF-@ND_GEX-E4H0,:bJ41RLWgW2DKaREA+15CcEc[O^+-O
@D,DGN&1W-XO8Z<f7JWMG629]G6OI+.WU@C9]R\AH<>0H0ZL-K:2g0\0GEb/FJS-
Z39cS7]K^JHI&/(;E20FdK.H5eQ8B(,IN/cTC&&T8F8f)dJD)gU?dJ?(N&b,6Rc<
+7O6#eP3J(UQNHYX45J=dT;e?_Edb1bGUJ&W/A>.#IAW(=SMQ,>1J/5[2/Z)aQ.Z
4T1+YdAaGX<DJ/d__+KRB,N8AU7fHQb1WQfV?5]\BE:7Wg?UNbGG:BL8JBaJJ^^9
-NA&>QYUUWF0aGY;+WF0/0VW]b>0AX/@635\NG&3WY&0;.@0@XdQg25WK:N(L-Z6
4G]XD7MM?,Z.0.2a(bKHd\/L@\Nd)g4bN:J@d]BXV6V4XgK.<>]=(R#,>QSe1C8]
fGgWZb/A64XGTLO&RWJ49AHYV()AQS&b9CIF-gR7\bS.+HY)c[>e#;cX(CTZ6MP7
PIc?N&L>e)b/0M:4V7eN58@cQLeW,R6&OKHdgg8VW#b]>-FHL=8@LO#fe1eE3_GB
E4CF;5J?8N1;&Lb[+<KG,@aQP6V:IRMfF5YQ4]U6Pd:bYJHc,.D0@F^a4a1fS0UJ
(8gH&QGV[[Aa9^(3;:,2dKLM@I?dQ3B7>0O&MDIQVE#?0-JWZc4R;E;T.GNO<C51
L@,BRF:fb?#H34O)eE;<O;MAA.OV3.b3LJFc;@+fY8bB<(@_YWK?6e4Q5/(\][:,
fS8H\MQ7=@W62WP4Y,<B\2K.LX/K.<+017&L71>=gWTD4AI>E#<T(>UL6/cTbdb<
J#?F?f1^(UJN6007HGOY7V#6SbVKa&6Q]DF.Vf<UW8)ISaM(QgJ7=/>38QUH]@:3
gW7BH8<QM4G/VXX&M8TaPecDT:Y5U#UEe>O>>,5K1NJ8aKf_QH9L<6[<Gc2<P16M
c4f=_(Bf2Z[d/)B01@)b>eXPa1KP#0(dXb+@M?e6g+#RXQS7AE,IJ6U+G5QdYS51
9/,DF&Q_d9DIdDL][HUF?<4gFQIP78729WcMR7EQeR&(d2bH0d+_?QdOeW7gWPSO
D[O#AF&5OI3SaL_(-bO>;#DP#S0]DE,@JJKFMg11[H>LQDZPA:U()6&XcGaV6G&.
G0V+R8eXT95XEcQY.X/Xe\+5gH8+YWPP(;R#bU8S#aZYGMgPG?-VLcf0Y[OKZR@@
FP&M3.+2GOSOQY@)C>[6?@UG>81M6LF99B\?-Q5?H]6&ANPgD,5W::TbM]XCeX77
DJ6GB//<K[6U27FUQfK6Ie^9AW:6TRT^?=.(^6K7JC-&eL,H?#J-OQ>\A#3K.2:R
@]Ia-?:5Z)YeICBSg9EdS_cafT:XC.bLB&M>@=#B@OeM16MT^&gCR^<>6<MCTPZ+
f8<cE_E?.MZ/P6.Q^<P-Nb/&1XVW<)dCTI95)L][EgfIa,7YWR5GWNWRGdCeL\eO
b.\VcAEF.A/ZO@UB>N3AA_5Y.<:@<.b(c.=\EJCTC-/K0\d0J[XYXbF6>8W]X@KY
UTf=+4?T>#d97ZGM-OGJg2;/Q&e6e\B43b/=#H@EOP,<M]7\SSNL\LY-^6NG=bX=
<_B(]^&F&R9Z3-9ceL/\ab:aRC8XVZ.FMDfIB(MAEF)07C.++8#(&NWK8eF.#&F:
.3+:,R/_K=JdP7-[/^QcD4N7J2cYN82:F;\8c\UN=fF6\=E66_#>=(LI3U&@L<bd
F,W,I/]S&>6L&F=2<c75C>@15MM5L=)c9(K;\B+9_&YQ.YOH3\EBd)X;LTe5c@J3
GB_BMW7CQL;cK?NRI-JZWb7U0NH]8+(^,V?I-5Y(4.\6@9cOJfY)/b@^D70@1B(W
.4P=?5>fRebD;aJLe34NY/^9G4GI,PQ#?eAUVE@\JUgM8/#5d6bMKFEE_PeM85V4
O24[b,g8.\S\QP?_^eA?TYL#62Q?(LM+<O4B>>D<1)bPUF@]FRe,MI8G5gYgaM#N
C+Y1WS0_B0b&1<3XM-fe&dUY0[b6RPXe.aW:(439bP(.R9BBSab).]Y2f[82[L,,
L+Ba;I8),Hac8BM5))0J@IAZ>\\.c4b3&RP<6Qa@N)]S7Rc)A,?MEf;?+[YW,4d/
SU?fWCDF.I&Wga)8J(QJ)?D6PN-MdS>Ge9e@\.C7ZOL746Ab;)0]&+WQ_E[I0TJe
<&MaeNSAF<Z57XP9UF_:LYYU6F#]eJZ8aZ^R1]B^H+=^L-]g_3PBVM4S0\/WMORP
5R@,bff[d:/<KY:YT>-c]VQ6MWZ+8N_VHYJD^C0\S34EUeebN;7e4J\.HFIUCFNJ
A[IIN/?7>ZG2Ec2V&V23e#E+FRHI3#<YL5D0I93c8CQH@63X+ECQ>Z4/+ZIK2,0d
NR]EG&F)(;&&Q:;#4?^37[V_<7f@2dD?:WH)e&..SNW&Z(@KF9(7f;Jf+N\_8)+D
NeI@g9(8O1SefCH&LJ<-IW,1T4;<F>Gf;HSL98F)G(<#NBEU(8d;EU^A8(Cb7_IT
a6J&POg01+Fc5Qe)LL@De.1<Af1c3J)T:DDF9SZ&P(F&aN;.K\^FO.+GL#RX+9?g
&LQLKTZgB<10:Y)4_g-XN3]QTO4N];7FQ9U,EY=X]2J@e&.B=7P<U[?#SA4(172A
1@=.FaL1;[->8W?RSBeUa.];E<>d_Q6H5gNJF-9]b8fB1]6GD\PDY6UU^;-28L\)
=O(4]OO#[Q#XKKSRJ_PaG0Q#Z04Q[T.7L\AB;IBC#&X:)&_FQ+^&@=+\@A:f/=[J
?CQAbK8U=R@:c.<?+(,:;ccOUNce@(U4Bc;14;9EVE/f<(\W^QCFI#B,L?J7V+^.
:^TBQf7X7Hg&Z^]82LA7M[U]Z.ZDQd[Qb@W^37a9HF8<N2;O.^493)IV66@_(GVJ
GD<fN,^BQYaD]XVYW\gaAG\UYX#gR6>[d[fbIQWZ9Q.TIMP1@T5DXLIY;)B=S@Y;
\:E4RVg<U9?&ga(+[JJ:Q#4R:P=Y?WIS7_+W,#8IDdb=dX(];R]3+8-</]+8(g1B
NJc33@Y7Y<fWGV&.V_NJfM_PK1=0SWYKe?]UdLfZMaBM[IfNPX9f5c_656d#NfEZ
a>X@]?0OFLV7WBI\b//A.T]:GN>d9>+XgP[;5e&VKL0V+C5RY-5Ba[QVI-^XGc7O
9QD\_e11Fbf:M)2,::,?G+?O?K+A<TZASF)5\9-4.dQV[^OS9C><f#75gGS362f<
I17]Q>_)b46<^3MV>Oc+ObWcZcCc@K7Z(e#62?+Z#1</6>e@c7L/,C3U#_Y6Jb>F
Q>ebLE+\T3S-?(2-SGcPE9Xe[U=-=5QGc3X78eK^9V/]2N;c2>-3_E5W9TUdf(SR
=ZfX[#VLKKBOVI4b7@7:H[K6(M\E9)E/8=<\<WTT@\HVQP=fG\.;56IG1F&L\Y\F
M,3/Q6>ZTUcIDH09J#TTT]^&EX4eA]CL3D7\76fFg[AL)fW4[f7?UY541W>-6Qb/
G4[2a)W]1cX6_U=LUK^T^B.)6?#JO69b\eV_4L5ORcPd9La-8V&cAOU&Y[-TBF((
bcR3MGfF]XC8-TEgJ_IC2OeN6NgcQT-[Gd_8Y<?B0bP8L+Y=./FAF<=KV,@5fK,A
\GPeY.B;a\WHS<28:,SB>T4GM/c4Z]:UDJ4@3?,\A58dc438dH1I@^d(aG8Va?a&
^e@L75fTDSddIVH^B(A=)56E2P:E>-Db=[LT7[KZQgQd;Hd&Rc+I5_ZE^6A<XVC)
0ReI5QFQaZ0]PaB+<94VLE3b5:VMBXKE)Z>U^+6]bAT9I3E8)UKEQ@&B::f+]Y\#
I@D0UOHC(QUNE-N\(7E4\eb+Y&RRQ(M/];8+.^)dE;0c?U<&Xfb;GB77X^8?VaAB
=O23<RIU9SDCc>)TNX]74<,UZWd@dQ1^T>LBQ4#6(VO[K^ZIML18e[PeQTf>S:<e
WTBCXdJ()d.7,Z(YWaGCU]+(_K]HC+1[?MD-2b:R64MW_+XPVVge\fI+9301Y@LB
CWUe;=RWa8db7G+07Y;BD2&>aMFe0BfCNCfD1IF8]OVcG?H#ZLN#_T=:fJSYOD2H
-9E1<?;bUL<1ZT-3/@0O.K/8Ge[eSOaAZ;L7JKA=JX2<-^L@Ecd]/2a8IL9U44W4
Vd0W78,O.dXSc^Nc7;VFLCdK\fWc-(_-HD9K1?S1,@9LY#Q#ZB\#VI-5X0cK)(3c
a,C)]ZdDUSWY2Y1]^71,2)H#96eD?S?8DEJ_Wg4-D[3CDI#4cZWFT9;:aMTB36aF
b\g5\NGAW,;@<FW1f)RDDE&gX4[\H<@T@S_ZfW(UNQbULTD@F-a.MY6MQ4<E,J-5
G@RXY8[,Rd1S+&K/.P?;E+/T\eKcf\gYFD1DSUI>)LP#S4/B?J/DcA/3&]bT/-aL
X+8L1HZ1b?bF@c2=0VM2A5_Vd/OANdg[Le7<b+c3C1H\_=)^(9,,JNc#L@YU<LAJ
7a1Ca6VFL4?,0?64df6UXYEcFY6Ka7P;LT,B&6QA@1L61RYeY,C?GV/UgL;(MQ?<
@LG5?g8F>I3;L/5>5OKB<e[XX7)\JM;_K55G@V(5XK(=RI\\e)-OCcB=@DO9\4/=
F3_^3P2@Cc/M;/A(3S6.[&dN9?:K0=c9Oc6+S72-e,9W)-LL,J;1GZ02YM40QGDC
#H@M@4H;P_&=>6&#bT-S3X2,&U1)+IB(U04>6,8KU/a,=/^+Q?Ea?-e+UedU4LOd
(^E1@Vc0ZaS6b4(ON])MD4AB=dNbL5^I;TX@:/C8-8c<aHeF^DIFV0c8@GdW1DK7
@\a5@>bRJRgQWSJ42^8;.TGNA@#Z,D]:E;ff33[a56QGVO;9NYYD4T,.FF(421L1
I(VQ[[+3[#C^VZ.O&[GV7?;FS3W8OT#R;-T^J/WHC1AN()MFHD3-U6QEWS)#[Z4a
3/6(-c&KCU[11_KV]Y5@X_(+0KD(K_>8=#<7T1ND@b]9QFeM#>AT2/aPADaSJ80M
6^>W;D?<Q_OeHTQXB[gA[Z8(A2GF#8X:f\2ZG):>21\/#SP>JeGGM>CaS-S^eBW#
T;3J+/U8KZ0C9;Fe3A^VfZH@X/a\[7[\=VONIQ=(LZ^W<?\D>OV-:DS[OQAd2WgF
;8##.G\,RGCSZS>L?8M\P[63#6X)QA9P0Y)(=<a?55.T;5Q@H8&Og&Z_c7N;YgL<
G_&8A^ZGIT:]\C9,O(KL[TeCbad1QDd)fF]AG#ICgA/][9O1JRX9LI5=(PRGLf8d
eV;+2]1Z8fb&XM^R&#0dGd<[\e[-81]X:DP@d3J4ReRFR4?V-Y&AM_+Q+bR/:148
^D-EA)9=^1,-Wga=J?]^.,<E.6LXISD2KWP=Ba7E(ef=F1c#a+aT@VLaBDHN#d[&
1QNL?T@2TOI8)J([Z:1^=\;NT7=,,KH,1bKD87ed9/)_@V?M2C@+N0b/5D196FMX
Zf1L&/e]D(TVI)T</<6GR:L(OBHQSOF5=M4V-C>YMP]0c9R,#_H3ALb]=g3P;FaN
U[?7(>=U+[bcT[+P9LEN:9;=QCL5dZ521[9;M;4S?1J#-]A2]IQUJ::D&a-cWAC[
\c?-0&BM.UD5916\IT:JT;fe<953D)&,6/a1NGY;113HTd_[cT_8XGH[YRUUgDE,
;UU98>Q_J_8_0T\^(?dPM(G@^3fY9.@4#FXN,73bP[2c_,9(&L:P<dI5DDH-^c0#
Og4e__NSa&GEg3NQe5Y_Y1MC>)P3YJ\f65RaHH=E1N,I;<C,Q)DeX+?U;M+fe4W3
:U&V=a3]>Db9d8]ETUc])/P?eLcNLUT@LQ-/(2[eRg--Pba5c[AYVgN,E<gC,CLA
1YC@J^\&JI-Ja6EbT8?&SMeX?GLW/3MU7SRLJY;15^B[.HB]\;#-()LRfVg:;eJb
b8J5CV12g))V;ePgA+RK?aKX8&d<ZGa50bV^\CR3(AV]=C[5K6S8^[VW;F0H&;Pa
&.>G<b+[X5R;aS>#Z_eR\4gYNB/[cRG+YK+GF)LIQ5?MH;_POUM\NcX4DcA;#eFU
)O:A,K:0Tff9LW=IH98WTL)aLLJ3f6E=AD86#;IVca/X?@&HNQOI[ccSb?;<SY2<
=])1FUb\:PEF,0\.DYg,?X&FcR5]U&J9<CX5UW]6c\Cfe\8XNRHd0:N&BCO<:;RT
WJeCJg08M_S._(=B9J##[cKJ=e93eLe(Sg,Q5KIF3/b?:?FHIb(gH:=Ddc1H1^JU
8AM;MWN=dfea1Fc+@B15S]RT-(+Z-ZU:)#IBXgR6G6f-bBf6JJb>\ea;fCVVLLM4
F#A4<^O\5/ELBUGU80QYJFGE60V\78#b?4f#5TQ:DJWOa=(.6W[J]3Z;,,R/-Ce/
F),dYfP#X5UJ0Q=OLZDO9O3MKQ-3>R,CTAd23]\L,D80,4.2-.430OKINML8K6#:
47/=R_/VU-GeZ;7]#C?3W8^#QUc-.?S(PXF_N]be(?9^=gCBEPBe;-ecZ)&-V0-T
EUbL+87IcY6?#NW@0DRIY>M=5L]c-^I;gZRA_JLbK<S2-CTbe+VNE/J0&fBP9LaB
_/G00cW);;@8daW=TFWNN.2dNPdP;[4g#dT&TCQ1X8<.]JIe/;N?U:B^UQ2_[Kfb
0cbL-GZ1Yc#?=F6ZgZOAUO+M1f:-Xf6a(;?T6-RACGE,6W1F/(JZ3dO<59CGOCgG
9aKZ1@d0J5(+]2._KAUe(:#HbVSZA>FXQUDbb9I1@MG9B]VXABNWZ_2I/^?._G?H
+A[7Qe2VIE?-a+T@egb<f:DRB<OcdY059,cQLf.;LRM7dY93FDb@c_?>:U\Q9CLO
#/.d13A4f.50dF@X/S=1[IS@?648&DX<@^)<27bAbcM<cT&LJ^C&7)2F6-#4W-,:
-S<D6&9Y6<(a__9DdB]QA?5?#M,HW]cCX-HDYQ+bG++81fOM/((U>;]WEKW(5;a+
UIg:0MFdCS8@@0f4RJ2+__3.8=>>_F@]&W<M(bAd[PPZFg51<C<\R>;V2G9-JR>Z
X6XB;G,^f&\DAGWcdKM,OgSOeW,J#K5<_40>ZE6Sc92-9.E2EKJM1g@P:XWPR)a,
-L/9<F2E<&-dTK>dbKJ5Y_CQX]f>2+WWWO<\,-gH>LR[T.WYaZ:@:.V4Z+Nc6Y]X
dQ/2ALb-\D0gJ5)WT=fgQ1W5U-Q3#<W\J#-L>N_Gc&63>gdN;3W(G\X7A>/O#V,\
\@M&QGK>JCF<&E]))a&<8NFdUTfNV<+IA(2MZdWVDB)1_BG#<OdO/.3;B(e]ZUY:
=Hg]YVeI4c(8[;1^f3KO@WY3HM,Y5,ZHS;(3)0P7RKDQbO^A^0BRS#>L>,dPBL.B
HP&1(\(Vc2FT5JF=_OEBYT\O@Fc-&<J<dQ]+XVce,Z/</f;;9V,bLfD,C9cQEY\(
/VGcTO.g@>1?&^<WQC_.U8Uc_[eR6@\U^?T8]H[2_aY<4F57)ZN3(&98dc.JG0]L
VS39d[-f/f\a)B)gGY04#?^8e[MG2#T2e1N2#ceJ[?\VICZJGb879_-RJRK)&LN,
/4c:)NT)HPN_c+IJK:a9^3]N]/MH)&B=YYC1LC8.&ag]4]+Cf2[@VcFY^3dYT+5H
_046GaE#ffd1[M-H36.@[\@bG3@42,d8&b8aQ:_TQ25X8H6[&U_O4a9KB@<9ag3@
VBJ=6]P)cZ/AU>9X>NOM>1COBS6ca+fV7@=XS_Z)[=GONUM>V5@ZVfP]7L9?,LS4
RNMa>L=(:+.^-((QVaDK;Y;#;LQ]_EJD3KKYM3K@E?+3LG?S^R^U7/\,_S>#V#9C
G?gQ;#6KS],K)CH8<KSV(e6-^3;NQF8QQ]I[Ic#aZ([?6K^#gUAJ8[9\3,E(.O46
RPF1C;<Qe>-XgbfVS5JT:K4>fW71c6,,8F1aIK\QY2a,QD:P72\5)?cOEPV8VV@:
/S;N]f@UBHS&T0.,NfY\-3GG<9.S.O4SA<&B3876P1Va@8O[3PM,3O\a&dfC1JRY
V;1?Ra(E?UT,G6)VfW^f]1AE_d[e^2U]?UCYLCOe_]LHHNOY.54cQ26\P99TG=02
M_4[aNdL8?P[8L<Sd<B]^8,S66)9A<[4+_Q0S3MGcN&=QTB7\AUYH?Xee/Mc1&I)
aR#&gF;FO6;[#@b.#H(5?KG<.0?HD8O#/bA6a_e^O5#D#c/53[f#Z]/Q\+&af#JQ
FV;/F1W9UJO\\M08NbDO@:K_=EPdPSI-U6I,-\fQVJTMS_+-@>Z@-IV.\g&M_]:U
FPC(5-H^;V@W&IZCPT:GMgQVc8c?<b2L+-WA54=[TE<JICY_H,C<2#Q,R4FO.26X
?CGAMVXWdCYcFAH]OSPY@N>DBDW.(M\e)dL4CD)NVS[71GMc,OYO9>R)6,c/>bWX
1:N(P]GOf[6NgJPALFHCP1eDIPL+4@I6<P\>3=VZ24ZC)?_H9F8[/<QQ;KI4\S:>
MO=2COfOcP3?5PX88CT,5Z(CC78]B;)egWB(Md9S/WX[c+58Pa&><&,K4cB6gZ4,
&-FSV1?S5QE@QE8\E+gMD1J6Q8aV\(7MgD<PA]TY7Y+5>GC0R,U_4cS2=NMZ(Y[1
UNR,&,KS##DO5P-2dc^T>b&G0W?7A#B9.Lf8K\O+d@gN>BX/GbeXa:d,@L5&LQ&D
HGf#8>:/BeEEJ94R?.8&S,TF-QK1]aC=&@_ePJ?OV+/3R>3U+,]=MKMB59/ACM#5
M_WHDU\A?P_<VK^8d/ba/=?<O-gW:gD\?8c0QC_,)03N+bfBaOcMG][g_6?G[9DW
;2K+f<OR/e8IXB04#?6Y/Z:/I)(#)CQJJQ5Z4TNL7JecVP)fK&D94H=Y+aH#_A2V
B:eY>)80P#-(MQKV#+2D(Kff0FO\)f@:W^&Rg#/5L0Z82CD1YEf:MT0c8I6NdcM\
Y4=FXWg6#T?#5UYUD6SX@J=a6P&NZ(D>/dB>O_D;S>,^+3-,=F?UDXIe-LBe-0==
\dJ\A:fPB-NGbLB2a5<2\^PCGDg#1S?83/<#8(AE0#@1(KR\(N//eN>C.,Y?RbMa
@4J?S2(F(9&>AJ)=If:EXafY?W_TNWSg0D/-X,EdR).Y2Xa-C2TKJONOaQ<TgNe.
QK.:d8f;2D[(=E_4H?O:7[;ZK^VSY8^&8@#^aa5Ybb7:[-f7<[@b-&?)3&(ZQ[(V
G@=GO3@/TID_S^Qe9TBg=Y<:K.^S=GAb:gGJTHVRQ-9Y\+<IgcD8NPBXgfRA47bT
GI=1(01EZ0G?RFWa(X;/deY5+TYc38\MXc(\4-J\L1eEV+<5X,9O/)#PV5XT6Y-4
aXC/7E/:P/bf2<RHH^1NVR;)0.+\R(\.-;>B48ECcWS#6V6>MV<SEa/E1Sc7AJA5
J]H<;=W:G6<=N?c@B#F]_/L36f(#T8Ua&+:D[]ANdP;.Vg1d9PAAO(aE/dH5R9EF
5U144=QUXbURN5O=RQeL?YBSC-P6J^H0@IG5CaG+&L\FVNH(;R5^4;L+GT4POU(5
=EZRE2V)NOaSdI:&67)^<,:/+1b2;+S@bX3^)UWYa2K8U@#[=/XY]TD<+V1cRQg@
[g@1[_Ce[RZ6+=.866<>F1M#9=ICFcgQU:>-bF@TE</P)-ZA-YSW)RE6FIc5_/X:
A4HF]V2ZaCWS?6(OR<a=]\KA/g0X)EfN-W=BW+ZO+BKNb1)+&@A[,T2EfT79ZN[6
L4)ZY4<1(AA25QH\UO?9\Z<)2?TPD:H=MVBPD)XH?)=e(5Q1&A:<aO3?DCH8c7H9
T@QK:R,0U=.#8cRR<G::@O/HD_0;+DC8IXGZRY/-d5.D@E[.DX?bQ>2-&76I:NW8
<GT=[16V@+5F.Ra-+/5WMK_GIc\&C.WXM0?cF8SSWc.H>-8-<_afH;L2,.dYcJCF
&LcLa/7bcMSH9+f&68gEY55</b::cUA>J8)We9B@4?I/L>Z#.@K?Y/;\SFe=MdF0
>@W=]9/B@?S,3#?/N,#M4QOg7cB?^1,S76S1=Z[8^V0Ig/b>.<6FKc/8_@2F0,89
>Gc(C9(9RMZ->UJ2DH[BJ#W+-SV(g+YV4EH&WNb.Q??ILGVD;CPJY=RH#P+,fG?]
6;3cR43T8bY,V@AC)/bZ5/TfE5N9BLKXOEe04,^EITcB/+.E=OH+SV:CB/<E6,S[
<W7BKRaU&BJ&^7(JU5MO,RMANdQ#JP:]556E-_[;B74g+/_.aIGW/#IG8Jg8A9)=
]1)Z(XX_[=MYH]aHN\[JYNd-8===E[5Y)M\T&@+J:IC\ZX06>Z\C?c28G0S]40VX
[CPV[5:((?aNH&M/+c5\F81g^R-^&9IY)DUHAF=S:WSC3RXQ9H55FcZ_P/.V(4.7
MZ&?19X#[#VTE64FD6AR)-E?D[2Z8VH3DKM-AcJUZa(,0gY(;fXTYT6]-&HdJCAK
LL)<@Z#8]3-#3H?:IdZ5\GF@bDVMWL?WDMQSMBCY+Q?CU+GCF(LY0<eM_c.0TX@Z
FDT2N>;LTFE2>6(b,ga&a][YJ:IB1\R1,@2=BK)F)XKCI0E3E\OdP-dE]&G7f]e9
6JVLg;Y4#S&A+>I>B5(9XP+Ea<:-D81Db:I[F>ENF9aB7I0IL:?/?;E)d?[5Y^H&
8Db:KE/NIO33-2+>&RL]6QT6;Z.H13=K#RfRWf_Lde]3V>T\?-_>F/93-bG0c>a[
X+Z8P#?OM_V)<.g]Z:(R-7^06AI[I4=72^O9>ETTfW^;@e07H6V=T^;2;D:<93O[
\SH:N7F_;RK)g8a/9+HNL1QDIW^H#A#XZ0/7M<1+Y1fW7TX8cZU<(D[@_OL?3N:F
ZfbHb@]]Ob8U9W/;M_?-+3cFP0Q_/K;)C<G^#LD+-#7.0^9FWR(d:@>@78B3&Q4F
gbQR[c5a@gG4A/G/_4E0OMJ4),;<QAJWeB_V)2NDFEb-#1dN<2UQb8L2SHD4])^9
6CB.BeFRQU=_;TD_E4UP_>c/XWR>NWZMKS#GF4S3d2LIGeS6>=.2+1+]L]KW9N0-
V.\g0A,T;4UF20<V=?5C?YS1:.2VY)XN7N+EZPQ\ceFI8BFQJbV<]MR-_/X10]f3
/UEd-E?@,YTS=d;I-#]f3?bcd,[#+XR>E7782V[TbQ(.S_:/[dL(W]dLK2?586RN
[]P]-JM7.Q[G.]Q)0TO.Z3/9,0\5)?>R^KU&=dXWdSCXg@<D2GOc,K=JQK9^/L@e
NU,)DV\g?D:O(>AM+4XPb@+#2e]bP>X6T5TX#SfL0f(de)ec?L(eNY?.5+;#gP7\
?G@1)U1>ZJKXWeDI<QM7Z4.?>;MZ^G6b^O,;dgVJ8/)6#>PDQP]4C_:_71I?S6NC
6?[_b&#I[&DL#](9:=<Y8ZLRIbZOeJN10G_LM)=beef.0cE65B?S,0/P?:Z_b]C.
,<ZY(J+b;5?TV?(55bCWE@9GSHB6XFeG#K8/^;:C\/>N#B80M128P2TM68I>SC8J
V+c3MGG\USDaQeE_-V+/Vb=e\gTfXcd.6CKB3ADW#\4ZAUAa)W^\E:+?>0S:S4<+
\L>V8We[_eY.F@\R\Q[b:8FV_LGU502>4TZ-a4E<H\gCa]Hg<)G96GZJR08#Z:Lb
N3ga]ERKX:6C,H@a3BI=f,G1>R,.D226[^,>g#(W_:P2,-3g?X,-LQ8Y#;^gJIA>
;\)JO05<FXK1(D9Y+UBHP>5EA]ceY_)]NO2f85)+(4JVAg<?RJ/G1D1(Ke4CZRBO
&>b\gAY=GD2b@8fX@(e>1,;gZ:e]CQRfA+F]W0_;]CaOE7=CPb<HeG6J5GZAYLS8
b\Y64(1&-H7)7=WXRJ?4=Fg23/:gCV0He[\:JBB/GJ):\8bHP<[P4XFWRG)YX:)=
gg?K?_[B=1eJ0I>2[?U@X\A(eW+Z)<A?I\2D<1^&JO<E/R?.U?)K+aQHMZ>N0;:e
PXSfL@@2(/QGBOR\I8\>,,#BfBKW9W;1(A:WC3R#T./@@BGdbL]YdL.YJ7_QB/L7
&]0A3UA_D@EC>\_T:Cd-YOS>11J\GC4V;I?3>V5b8S2X&\f&:)0ZDJY+N/Q@ESCY
H6W:V7&RWW1HLdWJ>ZB/TF;9P[B0I]Y>gLJPc/17c@aRVY/0TO:T7J-0ET8:N-b>
:MY(#BP-@.I[^UTN34:V?5KC2H-fT&0,-#9O7-FV^cD?2<7V:dd//K)3DLA;]g2E
G\]++=S&dNQ()6G)EH>T_RUM,50]V]YJXcN7Dg[WV,38.][[L0Af>#T#G6+(TR.>
Q;0N-T8PJ,[-D>.CN\W94P<S5[J5c#Sd.[B-1_bd?TddVbeN?.YR70:)bUYg3&gB
_D+/IGGAXI_S4aJ,-N#^\N[-#6U\\?dEJS=>;<(G<:2E?3JBcO8&8B)>b;LSaD7?
=ePHU->PM6S),bC9:.58Mfa9?UOQS7HOP;gXWM1;aH#&c)M@NIbe=B+e.KA/210K
aN-bBSJ.8PfbHb5LVN&d)dZT\JUI4_RUE/[)C0a-WK<e(USO/AN#OFfK8^KTJ#:F
K/B1>We8V,caC->B>M-1\\B1VdE;3@fL),4R&\+W]SPIFD0&c<VC[\?JFZ&fN.8O
Ee(P7+VGE(^-#[fI4@3U6IQ1K9MKfg#U1+@3->cLc#ZL(=gV<b-_R2^&8bdIb(1J
W3EU=e3bN[dV=PdQ<Zf>aV>-;2>48cPC8,EeZI?YdTNY&MSfJYaL27(&J\/OF7(_
YAUPL.EFPZJ-0)229C,>f_G=OaZ_1C0SfV=e3[?HYHVb368-IabKKcV\/J5)ICP,
]P-Z?<P.+O-+/(3=>(d#<X-V<7cW+<NYQ)A^XQ--)W,7V.a741>1/?#NCKEe-<(b
RY9R,Oga>SI\CaKZEa-BCdOVGbB0b(XL2&,Y\5.CI\(AO0S5SbQ?SB:4<cC#C2^Q
V[WWFV[aQXcP;N)NG03=9BNG5/^ddE7TSI--UU47.b<O/P>S<X76YFG[:-1^=ff@
(+A31M\8;FN#2DEE<+M,\MCB#67F[M>.V^;-c9O_AF+<:O4U6RB1WY;S7NY>Gg\f
I2GPV>Q6gNWOQ[SNTFG(e3VFBGM#(A@)KI07NX##3\[BC#GX_@_H9LAR>HBB9+E9
^6,G.4;(<@)5S8M6dY3ZH;&MR-bSIQ;^NGH/I_74#0d:@5:/65)C/JP4NQF@PNKJ
+IaFNUbO3&Z0S/]W.]).E>373>U1^GA1V9]a(J#?gcF[_W6dJB_0@[T4TZH#ZbCU
_M^fX3^Q\6A?R]a)3a\C+d/3O(R)d<V2YQ@Mb1\#dN8,.(-Q,ANaOQ2]EV4Y89a<
P4#^<Cb0E2#;FHJH,VVgX?HWO1gB@8-(4ML,L0\S@W_1cT/78aD:E_]=7&,3TF0X
8AQR-+5D\7>P0)\)WD<.H-J/R+3EU@^4;8b)91gR)_;bA5QFNOW0a7aRe=5,gK+W
TdDI&Kc0aWLDIbFHC60e\H4K_aX@:26J(S^X@:6VLS@0F#4[f0#<(@8dM?K\F-c.
6:]P472eKJ62HXDebAI=.+&RW+FfASc6G61&@>O8-45[#/M&(ZDeb70#.cFPN/3<
4:=ZQMZ223^3b)EGTPgME.GVH?CI0UYH4+\??PJIS2XQG@O/:,f@A9&+OH<\O^C=
R745g>70Ba5ND35eL^c^ZWEP4ROZ?&(DaVS(RfbGH+G2P_c^J7;4Y[+6MFe-=E8&
S)d^X>bg5.#RUASfH;)\-e3H\<XBR3TG&(?SeVA15CSdQSe.4JQWPF0GN,[e@T>:
LD6G/.T?VbZ1d2]WG\Z[5XEE:O2c5(TaV=K(g,QH^aPT[Y&,8a4X<V@OIMg6?+O&
__E7?Z5SFaB>(gYJL-eL#)eV7ONX7]NCF,H23M:>?Db1+FfD2[/GVWT#]C7AZQ;#
E+[8A<5\)D_TS&8^d2XF>NBN^PVH5US)0NVgQ(./4<-&dP9FTbfR-FP.7e:W+WD:
I2.7RD6I(B,7>Ac&;.K>e_<>(+3]//IV;M;aJI](H\Xa^E-^_+..9HW9)VTX]U8\
:7Z:U&LU=I5^;4JDS&4[O.H)0(?U@J>1Z]7OYFW?9Rg\KW6PXdJbVdH^+&(1I-M]
)bCGOd\^F6L<2OW<gDdg93M([8cT-c_Ib3A^]Q8U[4.]8C>/14#8U^M_8>4L(O4O
<>>XRf6C]@4[adHG,C85]Z)U;Y?_cW4:?GM^Uf0VXL#R<LX#F]<Y\(X[V[-Q))[8
7N@TbY;YaKZ^2U1U2eISD3PP/^JP#NI8N+P:IS7VYH\f=aI&M1\[Y\bF88M?I>SB
F^-\XDF(Jg2)7D4@ONR;9:S@GT^VdX>/Ub/OWS2Q1SeNH[7>)bZ=39cZdI4f4SFg
8\^M==+D[ef)0CS:B>S3F>,M6\7XF8&_Gd+(/Q]<O,\C+0O3+J_)LQ-1BMC3(V06
DO.>X#@gZLfe&e)PeZd9JAV^@WZG]#;[P0+8^-gLFf#(+3,e:II\2(GX?7-VJUQ+
RPQb@#f=FZ=#N-BRN:)1<^97]/TeYC:#Cfc#6cEfZ,+6VBXBN2S3+BG]0?9.\1F_
08K.LQB=3KS@UGAa)2EMTRF6&c+Lg6/)_7Q8&BYK/HB1#Sc=QeN>]&c@gR+6^YDD
3BQ)<[.,.22R#;c:b(U#1](K9B.V_K-UV<ZTd@IC97=NJDg/dFA1BK9aS+8R<e.c
c2[gd\6-Xd)<bBa_bcI1Q;aE[RU\<SEEcB)1bTRX[(KM9<:MXIa9H1?K0J].:776
_LD-OIT,;:^B[ID+.95Q9E:^.]L=)IQ(-]R\I51B(T>BU1A=[V6SHGPa4eQ+S690
f,+@\XM0JK5_:CdZ_(BB\9_eM_8#eRfL3_@[#eZS(_[<8<&:^bKI1UOdOV;1@.:E
\^W&27?7Q<Q2,I?C&U2_1,gV\OB,Hf7g@KMSMLY_&PK.N,H5,X0WC+28MM8VYQR4
6S6LKABe;Y6>T)75,A84\P.)1G),@9X=Ua(9M;dfQ]L50OU09dc,9=FS8aHe\Z]=
W\X>Bc.Aab]=e[f\Cg?5EH36J@#Y=C0LeAB9]:A[0fGbQ0:FZ&0>\_8[9T_W7E.Z
><+SIX#bT&F)f1X79+d8[g/BWLC8?+8DLJ2a3EI?;BG#X#G6/VMU7O]1ORCM+FBa
N448QBYBYF\RgaTG@GV[[9X+gc+HB8.HeA49E^P;VgCYX]c7-beS029a&XTM#bO_
M5/f3eCZe?SPU_YSTUM7LLK^OV86FbH@WKG6gN[.c+dK\KX..2ZSGE#O^^BSYJ>1
FOWd[HAZc^9:0DQ8U@@M[a)^dDdV+U.a,Zf[66N-J^df/c?V6-WD=DI1aAG:HV@L
6Xae;(aG:]eba?8DV+0-#]D4>E0TM\PXPI1bK?5/fAeUO]&+[)@4Afg^6I)4GK@X
WeeN;7U9O=7PcAV1&Z=;>E1K9@VC#AfcaJ_9KZM@+eH4cM@;+7ge2f<J5X>gK0VR
_2JO\<-0[_BFGdCX^Y4/^)5]da8L8=;W<2HIU[H:,.+UDZ_I,B/RQR>Ra+&[fR(9
]d-Q6J\DMcbV;Kd(ZA]+]X(R(/K4JaaZ#H\\^KN.-MY,V0#,OAD2Fc7f88Eb9>RT
?GX]W>GPOQO_RUTQ[F7](>8d4JLGI40\BT.,XJVa;c#PY<H@42-1]I-67_W:#1\.
(\f\WRN+5[PAf54J[IL:=MI4c,W-+c5d&97aSc,6FVE9L\U2R(@cH88J^-#DD+c4
R4)[VH4:WC4AEN;>],=0X9b9>3c,fY&e>3,Z/gZJ9(RVYaK5H88>b],BQ&f1V6SE
12N#HUXe/E4K//V,fTddGW^F?P&>#:W=GU@dP?\X@[g2M+@4+:fEUS/F9:2^IETC
W4dC,Yd&L2.fY0JTEU0:X+d#CVc&4#4;8+M_GN4;2[B=O4:&dBX16G48H?+D#E(M
1)_fSTOe-YQg/(>HP=F>MP9K(^NcXJ_B>c1HBY5efg/D&9^.EIbNKU7XRQWb;_U]
PZ:=C&^&U[cX1D/9/72,E0b0\S_>6(Gc+10;T_c13;I>::(ZBV<7]We)3)V5aMM7
fOV?>5K[^dPdfDfU-FBM/36YG<03A]a;E/IO-4=+Y9VC_?NQ)GUef/E>E;><#4W-
JAIT_fKNd;f/5bXBM1c]EaNWQcP=g;L8&BG[L7FTEYSaUZK?MF0T_LRADd4NX>:D
--(/_,CgO>DL[<e=YK.VH7QFZ_JH;,FS]CDVWa@RC+_B#XGPKdd[,;-(KL?YGG8#
_g3F&(4ca=IY.X#>QV^QgOBMS/:.f\)gU>JGNX19N@LU+4ZPIKD,:965B<ROE2K?
HTA8S.T/f7BAXBY;\JLd-\]Y+ENOQ)WRFJGe7;7geSHI>T/OS]RM;HefMg/bYFcB
(1dS1PKKC<X_1G,bC#b5LBN:T:g.-WQ/@L]RM5e\?BW5S2?HH2YCEdHgff7?]W(S
4SZfLgQ\F.^c&-W:(Rd3A_dSeA2fYZJZ+_M]\@&fJHPCC82DCAFT[d<H<E^Z;Z?T
AL(S?/._+\fA@<XdHeE->d2U;9]@V0H@1a/9g_)6Wd)2U+5I@1?SRUE[76c;[^/L
8W6&4ROMC3J>^+Z@YF[UA=5H,DJJ\SL?TPCO>8GAQ<UAD[/YU&FOL5I>(D4Lf08F
?5SdLW_,MV.H>VW#@)KRQA,NKICQ]+J@6Q)N/Z&>L>IPSH7[ZJADE@.U<F/PIRFf
eKaXG6^9XV;Xb_W4)A4cg<>33Lad7M<8;60b>G4=EQcD/?B3Q+^ML&O<1^V+.PgJ
8Qf@]ReM?P@8Y_aM6\[2#UUS#2X@,HXg==Mec7,L00A9GBVNPB4<2U#f6IdR(@J8
\FQ#3>gaU,RC=gW7@+8;AVDBIYT=S8).ZTPWM?7@4M,eTT[]ADM5SZ2f:>?gUPcd
APU[aFQ95-4]OE=4GTNEOVfH@NZcb7b2:@]4RgbK><OLD&K6BNINCWS:2fg=]E,1
_g?caU;.YY>U-2I6BX?D&dg:g/B>-GFZ((0dGWTW<:K&)dUe4]19AEec?+I?6ef,
D+cP\Z9T1U8E0LNW]+OR(>ANY9,(bgd2-HZV^JCaDTgQ5YXQ/eP55Zcc:S<&(T7A
CGZAM._56FGDTL\EgGL8f@OA/+.F?M^E2cC;V/7d;U4;<CN/2NbT<KA?6):I.P9V
XdOJMP)fa_4\]dV_0IE>DIOPG@:(HZ?E3LF<+V6U;TJR&,g=4f&gV3C4(_H-^4G?
XOD?75Z,C#OH0-fHXg]_O,62W&B^-_b10D<AgGbLLS+DO@MQNDA-A0U?D([.@2&,
?R[V+Z9)VFJ8X56;aT1#+8;WQb:VaHNfV^Z29FLN+WEbKFG8=UYd0+E-@e^@f.A4
MELX5g941SO3G4\\PKB)_&@:TQ<8JRP21UZ5HA0IKZ,P+O5^Sg<7bB04+#V^Y?\N
U6GdMOfNX6K9.FS35;Z(dLIXZd@OTZDQe?e6QSBZQ<Cc:B]XDS@=R_E]641-MLDe
0A<NW_g?:+_MQV^9aA/KUgPP2])7^g)QDT(Te;,--35U+CS:\3I^H2T4#gYf?B-S
+&RU?6D)+fC--bB+]B&T,LLJIbHSZJZ27X(P:6^023N,bNg[:0=@M-)F=G[(VZX-
J?;2P.@.]JN63RXI#4^ccLFP^WZ-;^A3ScKff6TCH&Q5GB6X[G_G.Q/V]X[QKCFB
d@O9,)eaKGNEeK&-N4V5O70U71SS7_QW];4]]#;G[>aI5_.IdUEF?\:\42BD(?AT
J<;gNCG?ff^3WS)f#_47,TDbM\J<?LVDd.=S4gYG3e)b.]7b5;f5V4U:a_:/E(+2
P<(\;Xf.IM=Bd?JHALECZIY(5H?27\7NaHb6\;;0HXgXXH;0=H:Z9JaULFKHAF0S
7W\C=8INS^6NLA+d9IYT,[.-)_,JFQ1SfbLf_E(S9Ag:Z^?0[HEWA^e.g@H8<Kfa
UfQZ5a<I7OLN+$
`endprotected


`endif
