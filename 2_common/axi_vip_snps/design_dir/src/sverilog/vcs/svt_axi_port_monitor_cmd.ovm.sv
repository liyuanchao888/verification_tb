`ifndef GUARD_SVT_AXI_PORT_MONITOR_CMD_SV
`define GUARD_SVT_AXI_PORT_MONITOR_CMD_SV

/** @cond PRIVATE */
typedef class svt_axi_port_monitor_cmd_assistant;


class svt_axi_port_monitor_cmd extends svt_axi_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `ovm_component_utils(svt_axi_port_monitor_cmd)

 
  //----------------------------------------------------------------------------
  /**
   * The Constructor simply calls the parent class' constructor.
   * Note that the parent class' name and inst parameters are
   * not included in the parameter list, as they aren't really known
   * at the time of model construction. These values must be set at
   * runtime via set_data_prop commands. 
   */
  extern function new (string name, ovm_component parent);
  
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs overrides the driver implementation with the VLOG CMD extension.
   */
  extern function void build();

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   */
  extern function void connect();

  // ---------------------------------------------------------------------------
  /**
   * Run Phase
   */
  extern task run();

 //----------------------------------------------------------------------------
  /**
   * Command Support:
   * Instructs the component to create a new data object of one of the types
   * that it supports, and store that object in a command owned reference object
   * so the command code can get/set applicable properties of that data object.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' only if the
   * <b>data_class</b> argument does not specify a supported data object type).
   * 
   * @param handle Functions as a <i>return</i> value that <i>points to</i>
   * the command owned data object.
   * 
   * @param data_class Specifies the type (class name) of the new data object
   * to be created by the transactor (must be a <i>supported</i> type.
   */
  extern virtual task new_data(output bit is_valid, output int handle, input string data_class);
  //----------------------------------------------------------------------------
  /**
   * Command Support:
   * Instructs the component that the command code is done modifying the data object
   * (config or transaction data), and that it may now be checked and utilized.
   * The result of a call to this method depends heavily on what procedures are
   * active.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to a command owned data object that is currently active).
   * 
   * @param handle Identifies the command owned data object that is ready for use.
   * 
   * @param delete_handle Indicates whether the handle should be deleted.
   */
  extern virtual task apply_data(output bit is_valid, input int handle, bit delete_handle = 1);
 
  //----------------------------------------------------------------------------
  /**
   * Command Support:
   * When called from the command, does not return until the specified notification
   * event occurs within the model.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the
   * <b>notify_name</b> argument does not specify a notification that is
   * available for the command to use).
   * 
   * @param notify_name The name of an <i>vmm_notify</i> notification event
   * configured in the transactor, and intended to be command accessible. The
   * name should be of the form "NOTIFY_...".
   */
  extern virtual task notify_wait_for(output bit is_valid, input string notify_name);

  //----------------------------------------------------------------------------
  /**
   * Command Support: 
   * Retrieves the value (into the <b>prop_val</b> <i>var</i> argument) of a
   * specified public property, in the command owned data object pointed to by the
   * <b>handle</b> argument.
   *
   * <b>Note:</b> If the <i>prop_name</i> represents a sub-object, this task
   * stores a reference to that sub-object as an command owned data object, and assigns
   * the <b>prop_val</b> argument with an int that is a <i>handle</i> to that
   * sub-object. It is the user's responsibility to manage references to such
   * sub-objects.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to a command owned data object that is currently active,
   * or if the property specified by the <b>prop_name</b> argument does
   * not exist in that object, or if the property is an array but the
   * index specified by the <b>array_ix</b> argument is out of bounds).
   * 
   * @param handle Identifies the command owned data object whose property is to be
   * accessed.
   * 
   * @param prop_name Identifies the property name whose value is to be retrieved.
   * 
   * @param prop_val Functions as the <i>return</i> value (the value of the specified
   * property). <b>Note:</b> Regardless of its actual type in the data object, the
   * property value is converted to a 1Kb bit-vector. This return value must be
   * dealt with in a manner applicable to the actual property type by the command code.
   * For instance, the command code must understand the int equivalents of enumerated
   * type values in the data object.
   * 
   * @param array_ix Specifies the array element to be accessed if the property is
   * an array. This argument is <i>required</i>, but is ignored if the property is
   * not an array. If this argument is out of the array bounds in the object, an
   * error is reported.
   */
  extern virtual task get_data_prop(output bit is_valid, input int handle, string prop_name, output bit [1023:0] prop_val, input int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Command Support: 
   * Assigns the value given in the <b>prop_val</b> <i>var</i> argument, to a
   * specified public property in the command owned data object pointed to by the
   * <b>handle</b> argument.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to an command owned data object that is currently active,
   * or if the property specified by the <b>prop_name</b> argument does
   * not exist in that object, or if the property is an array but the
   * index specified by the <b>array_ix</b> argument is out of bounds).
   * 
   * @param handle Identifies the command owned data object whose property is to be
   * accessed.
   * 
   * @param prop_name Identifies the property name whose value is to be set.
   * 
   * @param prop_val The value to assign to the specified property.
   * <b>Note:</b> Regardless of its actual type in the data object, the
   * property value is sent as a 1Kb bit-vector. This return value must be
   * specified by the command code, based on an understanding of the data object
   * property's type. For instance, the command code should supply a string for this
   * argument if the property is of type <i>string</i>. Similarly, the command should
   * supply the int equivalent of the applicable enumerated value if the
   * property type is an enum.
   * 
   * @param array_ix Specifies the array element to be accessed if the property is
   * an array. This argument is <i>required</i>, but is ignored if the property is
   * not an array. If this argument is out of the array bounds in the object, an
   * error is reported.
   */
  extern virtual task set_data_prop(output bit is_valid, input int handle, string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  extern virtual function svt_ovm_cmd_assistant new_cmd_assistant();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Enabled for VLOG CMD user in this class. */
  //----------------------------------------------------------------------------
   
  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::pre_output_port_put() callback,
   * issued before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_output_port_put_cb_exec,NOTIFY_CB_PRE_OUTPUT_PORT_PUT,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::new_transaction_started() callback,
   * issued when a new transaction is observed on the port 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(new_transaction_started_cb_exec,NOTIFY_CB_NEW_TRANSACTION_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::transaction_ended() callback,
   * issued when a transaction ends 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(transaction_ended_cb_exec,NOTIFY_CB_TRANSACTION_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_address_phase_started() callback,
   * issued when AWVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_address_phase_started_cb_exec,NOTIFY_CB_WRITE_ADDRESS_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_address_phase_ended() callback,
   * issued when write address handshake is complete, that is, when AWVALID 
   * and AWREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_address_phase_ended_cb_exec,NOTIFY_CB_WRITE_ADDRESS_PHASE_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::read_address_phase_started() callback,
   * issued when ARVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(read_address_phase_started_cb_exec,NOTIFY_CB_READ_ADDRESS_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::read_address_phase_ended() callback,
   * issued when read address handshake is complete, that is, when ARVALID 
   * and ARREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(read_address_phase_ended_cb_exec,NOTIFY_CB_READ_ADDRESS_PHASE_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_data_phase_started() callback,
   * issued when WVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_data_phase_started_cb_exec,NOTIFY_CB_WRITE_DATA_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_data_phase_ended() callback,
   * issued when write address handshake is complete, that is, when WVALID 
   * and WREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_data_phase_ended_cb_exec,NOTIFY_CB_WRITE_DATA_PHASE_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::read_data_phase_started() callback,
   * issued when RVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(read_data_phase_started_cb_exec,NOTIFY_CB_READ_DATA_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::read_data_phase_ended() callback,
   * issued when BVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(read_data_phase_ended_cb_exec,NOTIFY_CB_READ_DATA_PHASE_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_resp_phase_started() callback,
   * issued when BVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_resp_phase_started_cb_exec,NOTIFY_CB_WRITE_RESP_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::write_resp_phase_ended() callback,
   * issued when write response handshake is complete, that is, when BVALID 
   * and BREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(write_resp_phase_ended_cb_exec,NOTIFY_CB_WRITE_RESP_PHASE_ENDED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::pre_response_request_port_put() callback,
   * issued before putting a transaction to the response_request_port 
   * of svt_axi_slave_monitor.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_response_request_port_put_cb_exec,NOTIFY_CB_PRE_RESPONSE_REQUEST_PORT_PUT,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::pre_snoop_output_port_put() callback,
   * issued before putting a snoop transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_snoop_output_port_put_cb_exec,NOTIFY_CB_PRE_SNOOP_OUTPUT_PORT_PUT,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::new_snoop_transaction_started() callback,
   * issued when a new snoop_transaction is observed on the port 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(new_snoop_transaction_started_cb_exec,NOTIFY_CB_NEW_SNOOP_TRANSACTION_STARTED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_address_phase_started() callback,
   * issued when ACVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_address_phase_started_cb_exec,NOTIFY_CB_SNOOP_ADDRESS_PHASE_STARTED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_address_phase_ended() callback,
   * issued when snoop address handshake is complete, that is, when ACVALID 
   * and ACREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_address_phase_ended_cb_exec,NOTIFY_CB_SNOOP_ADDRESS_PHASE_ENDED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_data_phase_started() callback,
   * issued when CDVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_data_phase_started_cb_exec,NOTIFY_CB_SNOOP_DATA_PHASE_STARTED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_data_phase_ended() callback,
   * issued when snoop data handshake is complete, that is, when CDVALID 
   * and CDREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_data_phase_ended_cb_exec,NOTIFY_CB_SNOOP_DATA_PHASE_ENDED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_resp_phase_started() callback,
   * issued when CRVALID is asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_resp_phase_started_cb_exec,NOTIFY_CB_SNOOP_RESP_PHASE_STARTED,svt_axi_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_port_monitor_callback::snoop_resp_phase_ended() callback,
   * issued when snoop response handshake is complete, that is, when CRVALID 
   * and CRREADY are asserted 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(snoop_resp_phase_ended_cb_exec,NOTIFY_CB_SNOOP_RESP_PHASE_ENDED,svt_axi_snoop_transaction,xact)

endclass
/** @endcond */


// -----------------------------------------------------------------------------
`protected
7]C<;YScH(V,,I=[_aafKdFeHY2U.aB;IZ^0M:DEP[,##Y(9HW(e.)Xcd;Q]c:M9
F,5]8Q46OXfB&C1KY=7QS:+_G2P+-35:)2G\[/OI3Q[9/RL_<U#?TD1^N3GbGJ]5
K:,-^MWJNU)9UM/1]a1KB8QS?/?-D4HTR@K)5:6HAL0)(6:JK.AL[cGU9YBG,QUA
J0HVY<Y?\.>(C1R+MA:HZ<A/E[LcG9+];$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
UV\6ed,[?d3RG@:-0\.L^FeUcOBeA7cUS16>UfGc27PBXE^+,?U?3(:YG5-_CXL[
c\4_FYR#YD\;GMCC&+d9@c;3(FN(M3CP<c>gM2UARBP4LHg1;SB?bK)X+5RX\4--
;9DK7EgSV\;(GBf-,#Y)f(NCc1\dEYgEM4Ya=Q^:4&G1ZO/2I6E6^.fEcYV#^QDP
8#g);JWZ+:7-]-_ML)X14[R&QAO,.8:J^d9&>>6S(=,WSZ97QD=?U\fW-JN?b,>\
,fX)Z[+GTTP4/HN[;9\XZ>=f=UEA@E8LOSeLN^ZE@ZIQB6eBH6)0cG9(@d?J1M+>
_LUS<=7@d6++=5OYNCUN7T4a=6DEXbJ)>SE)T=WJ:BL<F)1@C#07.3Q<=QI#?Q[F
QG)VNeC]/JTLdW\R)3-#E2/.[?4&FP[R@KJW[2e5Q]_B[R1M9NbH)(4d@\DVAd?1
JT8Q=2[JRMP6b\UKJB_Y&0ZMF@.A6/=L-4[&a=:K0_<<HYCC.]C?HY=PCgT6>d]7
+3RI\O&;VH^P:FFc?@K9Mg^++FX.5.GAC]a>5?,X:?^f(-PPOW\d#W[.Q[>^[M;R
WaT4>\JEAZT_fTLbR)D>gZE>95.LW1X+M9X&/)\LLUQ9fI=_K52?+A\Ia<AAf81\
?V72ca\NRd-cA_W:NABNMS;KO>aH=C#-N2eOO9Pb4\PG-E;PW:;(bB/e^=K]+B?-
]N,I(DP[,X1-FYFec_0.)S<N[IN1386MI>G+/U7_aV-=/,O)(<S1&-<-Q],N+?_b
EEJGQT+g>J(Q[@(LG>J1_</>CabbQ_);0S)NXVL?dZ<CMN#bC99-=a\X4CP;=V6O
<UOVM)>8U6FSL1_I\PLg,f8DA_afSGD5PV(ONDI<7LLN&3I:ZG+^?J\^)d=?@C8J
&d_SXdaPcXZK&KMdNH83cPC44dKD#f>#<)-&M]^O7<H+^ag(Hf;>@;L3VD^.fd0#
F3R=9EWPB6ZLEK;X[gB#2CDV]]TH&E=_F1YTDRJB_If_bW+1EN=I[JMEdM.D_IT(
Z/\=S_B&2?Lg<XNDPCZ2,8L-#EQ=b46A2/3=4JA=<LbZUD=fN55[Sc0O8LfG;V-f
FN>C8TYeX2A]ZV^_=Yb4_ecR<P1=NYgW3_+2bOOL+#V&18#5Z)^@[G]1c+>)GbN5
_@9QJWa+SITO20N6G&(9@MFLDgXaFdc9=IG:9LDBC([-PW)R#MW):MT:@Qa.]f&b
BO1\=FXcCEgfY1[MAEa[b-LMQ5U?f^e)Q4?RVZT)&[D].W?g9L4bE/0E3B>;04HA
LXKDT[\RN,F54)BeH8Q29A_b^Rfe3TDJ_1+&Wg;E.O_DOOOE#25(9WAP[Jb&&?e^
\RZUd3Ja?:0U<>D.\;1Hc4Tc;W7BQ9:JUB8d]E[[HFP[.]Q<,O6](+C<F:,Z#?S.
UOV)4).#LWS#@?R+P^4<Y<VKZG_F,P+QUI)45.SFLK:dF?P>)7Q@_X<B=4YT^e2:
1IKG7S6XJ-0V5Q9</fRNM),7LX3F+E-I/a+-+\O18@LZ^)[TW7/W/@W]T7^OE\#S
](1_NEI)UHP8+\4<F>bQ0:WdCIWSeL@d]6RW/cc\>R\;&CPIC<dTg+T8ONM\&^eM
&\PD;V)>@P,Qd/&:E8c00bR,_L@UB;C4#Pe[;Z^\UYO5@)58KV0Lg2CffXca(:b(
6aJ&b1TNd]<8Rd_T(U_>;)CISYYW1bOBg6]NUgS1+@,_XCFJIf<YbBFDV-a_19J4
<=TXLAD6H)KdIT+.LN\&6[QdP?#3MFB+)(\/8+64]YbVM<NJ^[V,+,G_>8ONdb=J
]_75F]C:c0;acMfW:L+0Z.b?>SP^)XCe;ET),SS](?f;a:?d9Vb.\A\8<8N@.V/,
T?L+Md^BP>:fGIgG@7>S.?Ra&)(?7CC(6b;BZJ;:F830(<Aea10P_3H@Z>cNG@3=
</VI8;6#Q+,d(4HOECMB&4&O0B;C#0dJ8_NQFd6J[1J/YIB;4LeS7=A4cH2QE#K1
+,Q=BQHFDE7:5-W/df&6eRGCVCXgUe(3S_1b+=.a-EO=,J@eX&RM>RbEYV)aMDV[
#b_+S)JV\g=695CgPSb2eR4I]>_YR;[JaW-;GeVAD5bZ38&_F-2SGQ=PF&Fab>SY
WP[3cd0>#4;bf,a4/5T-,HUZT^8>c5Ma0T?6\OM9R\EAeI&cM<e;Y9+JC&V=E.)f
^^[1HR#b(_BYR?,3)f_P[8YcEWJ[DGX+e0PRf1KEBb&COe-.I<J:.)XS</WcC\R9
8S=^G+_(Q-IZ()996N1M>?58--:_1RcbXI9))L@+9X\6S)0d/bXG<TFdd)#0:a)E
JV<3]MXJXF>IUaO7]?c7N;[\ZSVg9DNPKe&48b)3E[V4YAX[6D&fI&_/f/DI(>_/
\Nb;8<X0M&NUGNBI11&N]=8?HI@T^^?F^3ccOcF&L/O#QN@7@#PZA7CMC04&;K/A
#X6A2(YdCgb(+G[=+]T/QBSJ+e]d>8Q<;I4H_1B34-_,;KVP]JXFR=cFQJS=)_d+
E4)2H2N#@=\IY1)<M/SYOa7QW8^fJaZPCGY1)aLY+#C9ZH6;NTPMf.YB&NaM3?MY
4C,CUNV32GKb05XV.OS-&Z[eP-g5<XYAM#:VOfTg\H4W/&-g,Y;@]1>g0PYN#[dF
Q6130b(0a\?30,(aOeJ@/BZLU=7d[Xg)F?A0JB=M,,CD^[DA3I;BKcLUVL<-GX]U
4@fbSTF6@HIZCd<O7J0[2^7Q6]QPLPP]_4QaaI;JCQ8K#PE]FgZL9\-_+2MD/Gcg
CV0<?B1PED&BAOE#Q]^FRJ\J]M81#-&A=#8Z@1eY+-(^5OU(^NP7g\\)FN;K>7gA
#YOC\RdJ/>P<L<3)#&E&dL1AW[a4F<dfG#eLHD4bABfP2@geQ?:-ANEeURPJ:\@=
[\0(aW_.+04YF?IM6=6Z7W.72@<T:G2]\M[g,D8-PN6Z1UgD5I+;J^FY0]Zf229:
=KZ-PRD6^<WPM1B-#G/0WQKfP(C1_&M3LS0?WTD.@PXG+A2>#Z8F0<2)+S0K^]9E
-B-:aR7O-E?YPA_?XIaI1JO\.Y_d>XV\7N6/N\74>&^7cY-RaUL]9C?..He\QZS#
7[.AcJg)HPVX7SD#f:5W141:gRcD_^?@JDI]C_3@6Y-X/e:C4L#8#.BNYE/7<Y9+
K0TWM8&GD&\(bfLYO>SMCI>8JG2VRTB^CE.^_#;;Jd.EOF5eGN;EP3F>cG;8aA^/
&S<1R5A&VIcJX,VRZD3Y?/9,0]-W_<-FF8bOAPGLaFR_MHZfBJ#N[AdEWRC@XA+O
fM]G+]P;C<3f:&L.[&J0=S>c-L#73#OK+O2W_HcHK.V=ZX&SZ2)?0U?G.2E7ML_8
)#D+&@KeZUbgaT43F>:/1E#_6/I=[+=;dYO1W\2X_1JeZ3U_JL9QIL\EVD=3ZKSX
LMg_D2IAf@W]>f+gH6W7][NEN4,]3JBXg96E/e78(&F)/K-CRCbL5-+eNUX#6DcS
T2V74(&T3MC+B7=&4=QFT4J/R<DB&AWcJE0Lc8WP:cGPTI]7<LJ9IQ:J<-5a;\7@
AJ1E/P.Q30I7_^E\#L4DG\Ec&bg.T55;8-&6<f6&)@:6#O=YWZ8-C#&>940L\-fP
LMTC[Kddf^1?K>2BdBd5))a\B?_6MAK_H+c=:bQ6;Q]Z\[\AJM(_F5P5Ac):-U0[
N:&e)GH&EY6_C=]Pg]5<>U.4UXN6XDY2T4DS3W9D#<>78OX,;F_@g>,LWY,1OOMa
SQ1ODfD73H;&-CbW>_^B3[UIY?:&1.b4HQfRD_dE)F1G)5PCAATF3cF;QIdF?GdZ
(AGB?NGG<=_K=>.7Q]a:QURg1a8_9F)8W9A6<=-=LaI-]UcBFTK#Ee;X(?X#&?A@
:UY>:VI\ZfJNbJ6:f7@c])6gU9<S[\O-\F4>G.RVE<5dJ)e9+.QRSSM?0(XL_Z/-
L8SA+1E<9YS24FYd0bg=+7BM68TJOe3BdYf7d&cJUSg6B;eA@+LO?N;UcQ1GZ>&G
L_RG]/8)Y#EbKeX9^_&BV\[gHM;5KE1#H1ATbaXQ0=3=-]@c-HSWFF5I+Zf/56P&
NDec,YJc4VfJ3#gGf#CM.=5>HM^#<EgCb.W-G#<XB7AO:OX[Dd&dZZM)L>SJ;c3?
H^[C)]gO(/I1D:+1//RHMW7[#GB/(6e9eCS86L\CF@0.4JR8H&_fZ<FRFH7IDNMY
2RG69&fe@P8=.VbI-__2E0=[\dQU_d2PMK3P>X4)cM0<a-V2TC44>)5>OS7,<?SY
/(-_:3/LC)=Q4,/agUX3_X(UfZUU,^L1C;a&J(gLcZQ,R5c,;:<HeDd-b50#fU&/
,\?0TB<=GVI2O)G&=g;C72R,G=IDV.;<1BQ?(@EVFD)]10Ff^e3.cgQ>WTO/4@G#
P4@TPgN=6CJ(g;(AX+M&2OKI<f+E-b1C1d>,S>b;R3F\NB6B,d8+cNZ0OV[aZVc/
AQ;^.#/DO8]TZ+(X+917([JXSY)<JHS^4LW^A._M^EeCCcE:P>Xf6K-9a>R9?U6H
E=OG.JBKR(\R+Wa6,]&R3:f5+aZ2S7UY&8Z\bPF&.;>(5.B39=[72CW[-5SFQ2NI
W@VM.aTD?&:ZX)Y<dUAOG,S/XceV,B4&C6N,7(3U;\2I)@HR70FV0I3;Kb;UMATb
WF34EBEX2F<_<RB6LZHK5I.B.f^E<\]QS4\eKb#5HceZ=BNXDdPX1aGRK5]R?_2Z
7.9B>#:21C=</::1Z/R56F+ZJD+#:RH4)Q6SVGPVg^ICV),bI9S\X.F>8-1G0V\?
\2<ZbJ4J>&#:NgG^L4<1R/YS<5.P&C+\V/,9\VV_HPC[+&eAVA.LAJM\TT_a0>WV
Q/5>:8&@-KTHSPN7a1O8@=]I090J&^CaEKd6F@8-ZN8.9ZLe9fa++PRPK@-QS)I2
O#P.cW;KbZB^]MJ?KDAd@A:Pd&?FG)V9M>f)00:AYQU@/Y+2Q8#N/Ra=G?SM>;8R
YbdA-Ce6,-5XYYJ<g;7I(#IPB)HV,PA--]5+W:0EW_AB72FCO9.NHOS8/KW1J.O&
;=cA>B610GE7IIIcA:XAdf2,Y.=V&d2O<G:>-+N9dN_.T4S&af>O:cM#NTGA^1GH
\\7Tbd9cVW1VOd/Y,[/g:(.9H)c<1d8#gESJ0SMbMGf&8#L+:CX[Y?[Y1S[(0ca=
9Z?3/JGK^Z&dDZK,:(&:,9IL0E_Mc6TU;OX?Ege)/@>AWY1Pb>,MG)9-\8N\>>f9
(:3P90,J>9a4M->D[WVcCGT3R/7\>TE8&&+?49G4.1@9aaUA.IE8<X)VA@Md1D=Q
Q?D;+aHGU_M8(O3?IGI;g[e8KZ:?3Yff]WeA\(74R[/:^G?aO?^ND],JcU>XI^5a
PR+?-0SS:H_OTg=2N6PQ/Ng,[[acKM\LgM]PaF7-1b=.GFgI]6KA5O)McFBDJcI&
-HVS^AEI:S;(OaG6g/fa#70#D-BQZW4PUa1TUQ^]WTD66@UXAg7MOA^4gIXZbOB9
+FD<WfH3gF0&S,GHDZa&:EZFJSD4ZdSH/M?.B:S?)8/QDC6S1WDBF4/CQ.IDKaDM
W5D&BEQ+b4O)GY]]CLaZa+IF.^eCgJ-b7WC8KH9C;6R,-Ib>>@S>]3F.^a]^1M)H
g4dC0&-1#NF4P53TTc=NQ=<#7]5[e/P\g<FBB]^^)3]B0Y/IEH.Y5D]1B&BRcI?E
D8a)D_J&aI>+,e]f+L;0-Z0Q-\eaA]#A<2NYKSWW.W=9b:G5RWU00_K376C2W/)@
JM/,1TWPJb43WJdK4;:Y:FcM^-N(=F,BIL2TdBJ(g9Mfa^H30S5M91c::gZU7RN+
;O8aEddB,;_[2&:1)6+SFRagd@PN?be:Q,Z(X26\9WCX=ST@;cb\V]3T4(L9-HN4
SaPZN#JD(^SRcTNM0b(<J.ECY)#]E)..<T-aQdF989>J@\I&NDC)C\g=AgEZ3RO\
I^YcQgbO@e^\)UgC21TX6R;dg,0M&)C>G<P(/<ZC;=T0KWXH+:+\D#,Ab,<W[S2c
3OC9JPV,AL^Pd4L=dQ,XE6+S1=2LN=@9A)Qdd7;9GSG<HP@<0/SfG]D4GCd7[IXP
RY34JH:@XURdg@JTD)Ag8<MJG1XVbaT<ICLOXAS@)3&9XI\CIJC]MT#aU1UN(c3<
g/\0(a,/-Z7^\3\BW9^(D9/TY5S.XbbS(ABX,?ZMH3gc111M7=KS;X9+=D0JP@=5
:&^W6]JcV-gF<;.X57]UU=JE<0JCL1)EI-7_M&(XZ\5(OK]4QQ\/\G4a=g#?a;A;
YXO@6U[R<L[gL1,K<^-JgK^1N@DHJa^U+M_KH.Pd/7Zad#BF-9fW5,Ng[.8P.RAL
>ILAd+1:PVNN#Z3EJWH=ZJ[3;/bK,T9=,3gPVU58Aa1XegD=6,B2IcWX4R8>aSJ[
WJ@/P-4>Z.:K:Z>N/g^#Bg=a:fAZ8>#YO:D_fg(8.)8HS,ed3Y]+RbWG-1:>NEGE
QLU[b;+bHXG;=0L>QY@7XUWTMg=FXATCW/3=Q_GHR:-#AHQ#L)GF;b\HHXTX0a1T
KVgI9Sc^,aOf-T0OgX-R.4^JPJ9,3R_bA0Y[#cce[H9a5;8+4OCY[&ZY28,H1J=&
(fU:V-a+&(#/g3M[3)>(@QFBYYS7YeA<OIW^)#SL<Qg?KeSP[I_KffVR&@&7]R+D
-RK>]e3Z<.Ce^f4=MAaaRG@AgS#9WdL@=G(U13>WUR8dL@8Q:+U4,f+[MG.[ab@.
U>cYQ(EEb[V4A(G]SD\9H#@H76>87<N;TWXe(NdO_[e^eC2K&2:Q;2)(8T6N.X4\
Sg#f0#A_)?TcS#4/+_(O-U&[RRe/-N?g?@?G=DND8KJWPQBHe+b=Y7<b3266EfIL
Sfc/[QDO3fRU^3K2f(B_/<]N^NC3<1Q,.:\.KSKYIe#FTUR&3gD[&Q;:G7@\B2d#
MYI_FfI02HIW>:H]BZ\9_d),d4MT/R.TS>bf_^XZFC/2_B9ERb;c2=#KB.RI8CbO
d\XWbaP?57/HUGSG+>fbX8FGK,WfF8FP,1BU]9+6L(QcZR,7a4Lbd4+V#f7]&]^1
Q5@73=RY4Y-:Q[2f3ESK0IOa+d4I;Mg++_MSHgY/SLd23A4]eS:)=8d2V9>YBL,J
PG:849gJfCfgV?I65Y.^ELG1;cU:CCH9:dO<O3M^&IQ.Y(DGS71gW?JS<^9JY,A#
6A53FQ7T6#gKT8BG9IbA3ZUeg(_HIWUA7_eZVe+4dB<;S8H2+\^]HgKGS#DE^6^#
#P&4OSZ8H(-T,&90SXW33?2QeHVb556a</8MPRI1ISW>RV;\MbI.QG.g\30dgO@[
;IIAd3H,_,XHY754)BBFCA?K=?41>QYOGB>W,fLH0./d7f4^,<I8BW6E+IL:?Z9J
\T>:\YW(:R<IV@G<@/F#^24g,Q7U\R=:bK23DgTb\^PVdJKg/eGKc)+@d<MCe]Df
]\JXaBA0^RZgBLE(#e@[.)=_W3e8HbaPcaKORI[K#^]fVT8\V1I[XN@<E?=.#MDP
;_P--_AFCgXF6a&L2\D/H02E?>V\4Q#N@HLWXHEdL4FA\BbE)&K&H8g(HH1=R/g-
)g:dSDLdA=aAdKG7F922M&&2[SR34/I5QS6ZS-Cc64Ef+dF/S1ZIYdAEWK+f/LPc
N0>89?/64)aIS:Sb<Xf/CDHPPY_@/\Vacd]4PNO5f@bQJKZTe)=7:YSDTTV)NY-I
MHcMOH90Fcd(JbD1RV^1]-J#I/eDZTST&7eIXTdUg2NMU#dfI+LZ/A9U\/^bKa^B
A@;F/W_)BB@1\5X(;4J,Mde:c5<RKZJ#>0ENY^#E#QG&<59Sd[3AY[[_H0U+SX\M
Z:7NDe\UEcFZ3gM/XNT3aE_V_K8(IR?5V8<Z1&gMbK#>CI1J^W1K#-e@bEVM4F\[
+NUe4#>BSJeD-XGJ@:[J=)4Q&;L#6Y]62YFH-7\M&&gA+fb7Pb(TVI=XQdGEecES
PX@JG,]O\:Y<9JNCO\.\N5:-cf0,Q?>2Id\c&P=E:?(Q\^97TYITTF+0.0>(aOPf
_V:g72LI;TF0J)#fS,JQ-6X[eVYI/]XCY<MdP2D(3cS>XPCd0g&;IZEUaL<cWAM/
XT+E,6&G][6MPUT/:?IGX4>I3ag-(GU&;GLU?Zc9?J]QXQ\;=\T+3N&;E=<W3f3[
M22(RQGSS1JU<8-K(He?bN5/Z)D5.(g\MQ1.7A#<MCP5<)>NG)\(EIW.MC97\gD^
F3O(LK8d]#?f09)eAK1fafL#7gHM1bcGLI.PY_1+8d_+;K4N-#P52fA5_D(#LS<W
8+MBP=3+2]/O+bbV/4).LbF-Ge3L?H2cK28OP7B+\@LdKZOJ==X9gR(gD.XYfCO=
#\cAbXZfG7M5B</Q,OD_)>W2H4Q8)V^\Z@_1;A4^U#_GT5Y]6)d8&fVd_)J&HLG^
=4[Q)RSeSb_=J]d)9U=KJ9EW=&b\5]d_PVATbZS2[:eJ26;_GK30RF.9eE0f3Of8
=b]<b(LQ0ORfL<#WO>X>Gd9;_[09:W3PVK2Z0#KB(L1X[OIcQON/S&5g2TCTZ3-4
H+1X4V^_3\?)W-&S^QMA.0_YObJ=;(E<f2DH0\1B/KS\D?#eC0e)[[&6COg?9)^B
-:NWCVN>)V;1W<Qa2QBA&ANb]JBR5\4C2#?H1]XD(\fNQaBJIfP^a9Z86.@fS8S^
I\R,1RNKB.B&eMVfUYZI#6W3bg3B)d/-G^a5S_>)CC.:E=LceKY?4XfHGeGBa0d2
U)3H]I2(S?.X,]0B_VQVDP<c]];?VC^S(C4\3988EGAFN^fLFAK<Y=&5.1/.fB)a
C^L<TZ6:+WV=;+2LZ+TV^2N;6P[=X#2EJC7a,&RD-1V<;C^:E[H8K5FQ^Rd&_XI[
SCFH97+Y)bVF^^Y-42QU;HU4\J.55EC]C(b?G=S9cdC@S_MVV17JQS#N#ID5R#VW
[=\8LBc=[Z<gQVX@Z9-]G1PH97GW6]f8)Q=Me?[^3Y816]8RQ<70.<>_C6U?gXcX
.FH&X>(YgEgb)JC5;=IaV]S/7MNH9_:dc.L:QB/1UgQOK.J\T=BIPL/::.&,Bg\^
C+.,>M+O&)F]EK>C0aL4c4Y:eZ/<Z[),FD1VV2W1,>&@cOO=3,,91?EbdRYZK,bB
1=#WV_.J_cEf;Q]7WGQQHB-M>_];;g+C585N1_-G[Ka(VGIQg2-PQ[^2D-KX.Qbc
2a&-QNZ5BAE5)[fPfI(U-.a[EZEed9O>TdV;[DUMOZbd@6d;;0+J1<.#Of54Q1>P
21T\aZ:).(FR;gE=L0SdN+@_V,HF5#?D;DDH==.5B9B>M94d3fWAG+]Ed<KX9fCg
:0:L,D<Pf/AFEE-VEG.1PRM9#2(e?G56aC&?a6,Za-_:UCJ7YM//L^0Z/NaN8g5A
T[4WHV@^EcR6+35aUF>TECaFX4e>[WN8.QK3[)]H:/__?<e;)LZ+]:>F8d8VcYQU
Ja_cW)@3TgTOb7F.;:]>b.;]Z-3P&-RJ224#Rc8KD]c<fIb[KN9NgLE&g/c^^8.O
dB>F=FT?bg0\F^Od>AI;T>SZC2(JM_/0@K#59FL3;f_;E1=C[,1@4EPJ?A,41RTA
Ug^@YUOGI^A<cPUP@^fM=8R@a46e<;38/<f7ef<JP3J/VQ^/?)EKP7A22O<+/M.L
Ib5Z_V6F4S4VGd>,A-.=<J,0.L7X.XLM_<NJFM>0ZEPIDYSNP\RUR:PGJCCS<6OA
#&H1H7#<9LU[7K-8]>8LFRZ(0:Q=::)I?(=K@RL4,JS.dIf(?;Q0P0Ed;9+D)C@G
TCUdK;99:801_XE)\:\#Tb<;f()E.[Pa)&BdH;)0aeGBB)W95@4Q/X+4C7+@Z<OS
/.63I;9.A\g[1?Y9b-&K486VN9#SV34_XfPR]JV7OLS1;fF#gGTT=ZU=Jg/HTaX2
(T&UF5bdK1a_>>XW.<A=XH1CY4YKg2;7UY&UXHD34+F#.H:eXJO^3WEeg729CC;E
M5[)eU&GVbc:aTe(W7G?2^=166)9G.FK/3M@NX?Ec]=PNYQ:g0cC(CMR2)dPC-5d
JRAREI@4LY.c;A4_K>R<B;Gd[e)?Xc/b]I>^-7aMBCa(95(;8aRO,P4[_&N-Y?:g
VW<aR.]DRV58-SI87FBTc+eC58GP[YdMNR_SZ<d;8\S=I<gdBde]@6ADc.eD>_QH
8Pec0>+D.f1Yg\8b/1_YbV>&-_7+^B;B<#/@09gJ4-C)F\KE=GHI63N7Y1NB\)R,
2LXO9CDLU7K]f#c5g>#SL\VXe6D>Kaf_REF\.>NNP,gF8)1>P[;=?&((eMfI/fSE
WacW@9C[34Te#:7O]+d_TP+S7(;,X_18<E#5Z/+e)GODYUUadd0f5RYZe?8@H-=<
b[B-<^1N3[^(\;:[S8Iee]W@GI8V)c,+/#@I.P>gE0OZ5V<UZUe;<E05^)L7ZRIZ
-3:<<gCVTUY1;RBTN[=F@P[:4CP/N3X=#0WNWdBO8K>?dW]EgJ;0bJ64Kc)BUH7E
MK;dI8Yf5)bTB;J2cg=L:P9R;P,8H;>^,SV5&07A7Ke6L1(A/e\)8-8;]XVB;\b=
#8C^fPRE-1F-S=?Ycg^[;ZR13M<)/[FTW4=1-8L1QE?QCG;\H[GGO4++/HfL,a1U
3ee_Ragef02;CL?-dH\(9\B>D#OXf.G-E/GC@WV-R(9_@6SQG9?887dGFGeM1AY#
#,f>T]_9F4KI;,Kd<C/<.eB>[;.UG-/39E_S3dJWRI_K8.Y4YbSZaD.]49YXJ\J6
JD7],5^Q/K6]V]]^OP&WL0:B?BP,gWe#B[]OMN+R=9CBWbK3\>O31/e8,/J&V8R<
W07&)gMe\,(<)E/#9#4-X#Y:SNG0^;E)R-fJ,NRRQ[,c<JX[TgQ.869;f#VDLPWe
g)..Q_TBOL#1.)7GADYZY\_)P4eTZ\@ZO@:4/R]FE1#?Q9cNYC15LU8UBTTN5Qg_
;+UGYRbNDf,NYT>^e]YT.64dI<&#T?5(T?8F_-P@HdGe.03E32G5A)08MYO>)YC^
P6]<QGeA]M-O7.T<F/:^Yc82\bD?EDKO),Ig7JI(eF8\P;BO1GR\3AIAg)76\f7Y
3CbA/KY\B-O]>/-7aWf/]#8RVPdRa_B,g)IF=BF;6d)@e1eS:.5dbb(gITI_WIX1
gN>?JYMFA#d.I-U6MM?da79O<fN;LLeEHHC2EJ:L<&gB2<PgV2O^PS6:<VFM.^)Q
E2ZF#9SfB1Q,;J2]4.NV=9;f)=31>2C]^Q-M#6(2:Q)+QF^FETVYW\(I)8GK=_7/
\ea,=:KIW-J9L.\Q-RPQP/b)Ab@<\OO+WLCP)/HX51_[9A_&PAQC0=cSfGg<NG1P
9X,U9)0DD_E984Te\[I=Wg2,H3\YP0EW&8./I7(=I@Q1b87>Ob[@^4X@bZ<&;f,Z
L6141#6dB.S5J9G/efc.34O;Y?Y3GQ<DdZLd=2/?7_U5GYS>-0HD@S+SAU1RC<4f
QIDc>AaI0(.)RY7K1<bR16MB@KOAFWCIS3D1/=^aAE7g>+I^68T#2TVU.V=(@+-)
]XH9-b8WEdQ,DCV66V>c-NQ31.?:VXVZ##=aa\dT<X4=Td;9PP^AV>?[UR?&[e&4
IXR8Bg5LQW5b6b)[8G(e1Y4Hg2cd4R^2(59Bg.aNAVO_5T2@_;HU-VO/KU2Sf>:.
#L^LFH6PQ-T;1(gJ#aK_B)]c7:B?6Vgd[Tg;J?:+2R;AO9+=6L<X63R/F;(9b@XQ
[/Nb3ED;9[KP\c3AZE_]VH77\#c/Y634B07@#4gXDM\&@=:JO.gUT0P_5F/5f[7@
f2TT_WX7<^1CG4=:LYI&BR\g:Y8gHNTa9WQ[-6X\Q(7dK,HV/&[a3C4Z(GJg?WG&
QI<C\aL@0[NFbUP#dPa,U.d.?&V&.b8HOZfN83>H5fF0/geQ#PJDd<1+QcXa(+>\
QFT:J=4OTYb&5CHe?>S3.1?LZ-1=[[=>WCQB27EHOY_R<JL4Kg>,V>I2LC8QcH@#
J@IfcNF0UCM7VGNEI7RCY9#R]51G[QW#HX=XBV/C&LNb\d^AVa?/B])#T5-/)fYd
^94>,?+aYGa[>N\=.fF=,>QLb-X:@cXX9SF,A#248A()O8M&a+=AB?38]XLBG)a3
](E<5FV<a\@+,B[<8;6d_WX#ZYH(ZG8FK:(eX94:7c(ca46SS&fW];\\B.05ge2e
7<2T42N1RDF1-:MF7]>dZJ@_cO2JTCQLa2D(AAXU<deS[F&O;S9QZQ.@)&Q-cK6K
&S6YH?0DbD6[eAIS^Y(+NB8B2&H/f0150E#OBCJYMN.>,B&(-c/\F2R4IHE]93aH
+;D)6)?_9</RG/g,T#15T/La4NO1L8XAEQd<JCdQ\XP9d++2OSLZQ8ULJf#.<-N7
C:@?H)b(gUYKW+4[ZZ9d3RIX^JK\2@)=Wd(_:F,\;7#1_aA6#<ASWNTdL>OJ>O5&
U.3<b&<dK6U82(@(_OJJ:9(J\CEU_3V\;-S3Q0\^_ZZJ:CCWWQc.29-@\T-[DIU=
+ZTS1^cB2CZS9PTO-5HMab62-Ia3+^7L>9db9\(=3?)UT19E+,E65d[UTDGbBZ[2
e3G/8cU/99\Y7CWK+MMXeEY90\GEXgR0DKeQ#2-;aBb\K\U25/(:Q,3<;G8EgSQd
6b\Q2_]\AdHOY=O/fMD[8#0-(YcJ8N+OW=R-I(MeX/G\L</SA3[,aUI(=5_,_;Z:
Zf+&X#9#V6;PCD_<\;7V#K81ZQTEOaQSG@2L-^VH,Z2E)PP]#6#S4bYY)_FR=W5&
M>0AbbNdBP9d\.R2_==Y^<G&J(CK2,K&36>Q>BV&#)_C)^ZTK&4Z;(<)@dg;IU<)
>6T2NT(JdY#R@#WD;bQ0<QN+eYG@JMZd-K5d,\,ZIbGecF@gO^3&L#QD=Z&:YAR=
c63ZN[6;Q./#VUF&fWS5[#<F>Y<1dXB34e:_U,,D:eH2>-LVQ+D;W-7,7bE5-(KN
E,^\#f@aUGI6(K5AGA\8;87^g9X?.R4R7_PWRPTQUETLIe4)>)&8MfX4S+>0)IG)
G1dSYXX^W\QC-VU28.H[]L;/[eBVd.7(@Y)bfJRETaAP)@:&TY]K@#9..d[b9<F:
GcXBZe]b<KLd_WIQY[Md)ML:F5J</JUS8b[F6WTV4/ULc^8ZbbP4)):2J=B6K76I
DY,-2Jb2&+CN4;O_d<DX@,/_U[;HK[Y(FRf^-6U.fJaI1]PS^9/bQM,B(1bWZ0(g
54,O,]L^?C3HPe>Q66K_:.\+52_\))7I\YR76=dNT34QH[-(D_VIbPaIe7eJ>-\@
Ea-H)AHd\Wc)S(<C?MY/d>3SZ>5d..79E\gK-OKXKNP9cH-/@gW3V#+b>@Gd#ZAQ
YMe8XT?=6(Z28E,M8@)B&g&,/N2D?dL-Fe8#/)QPZ<TWLM^<:3IRXMO:?905DDf;
I)8+7eCRI4Oebabc:Q;KATQ++bG;B/.JWMQV2@1ON/.TS,=f:#].?XYVS:-B=Ig7
5=+L?[K-\0\V2f2DK[<ON1-/[;\cZV8[VGMO(P]9K?0^6GTbeeZ6AH?QG(Z\U2Pd
&D&GaeX,.XE7N+\aFc@FT,Q)QF0+&.=Q5(AI1PbgS>BaOM/RD4X9&8,<72/^DL_W
LV0V5CT5S@-)RM7[;X<82F5BHe,J+Vc/P\&3-\b@=&gRSF4O;#8XE@+>eDYf](-\
)X\&DeaZZEaI)+L=@PV1f=@<0b_7L?SO=-W3@I9:T\(LGB#f#0_Y^<B31d9gL\UU
PFM>C;#P<E<[]gTY7Z4:[gJJS4EZV=8AYC.=daa5PP9LE$
`endprotected


`endif  
