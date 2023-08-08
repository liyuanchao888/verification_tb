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

  `uvm_component_utils(svt_axi_port_monitor_cmd)

 
  //----------------------------------------------------------------------------
  /**
   * The Constructor simply calls the parent class' constructor.
   * Note that the parent class' name and inst parameters are
   * not included in the parameter list, as they aren't really known
   * at the time of model construction. These values must be set at
   * runtime via set_data_prop commands. 
   */
  extern function new (string name, uvm_component parent);
  
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs overrides the driver implementation with the VLOG CMD extension.
   */
  extern function void build_phase(uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   */
  extern function void connect_phase(uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * Run Phase
   */
  extern task run_phase(uvm_phase phase);

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
  extern virtual function svt_uvm_cmd_assistant new_cmd_assistant();

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
ZJ.QYbb,0CUAWfF72-C#IZM\.KW?_^Tc)F0.:0c;^ALR@#VD/=Z)&)<\;T@6ML2[
CT#<0W>HYaK?RB+Y6.\(^O?JB(B35a;-VDA><_LN5]>gDd.#7dC?@-;e@7\bK6AS
_1FMb=Sc2JJ.ZK9?7\GB@L+9^?&-W^\D#8\_cT2RK?Z]>R0=)PYY>:D8F\K1N;3D
SUS^2@g]CVQ/>1bO4(C;-CAL-1K/OJV:;$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
I(1C+&VPG?&=^V/8))IE3,1GP36\cHS.I<@F@KcO[=&;HNQH(QO4&(@bYR@Ba.CK
+K:\eV(XGVL/d::P6=UDBCJaf8#K>1F9Ac7GAZP,^S9\Q(E:17F_gV[Q1f1<dMT@
b]-Oa3421L<ZaOY<0X^(=:b=M]SH:SFaDaaIQ.C/X]6PR[f=/Zd5O.f9L_[Ha=f&
.@\aE&<\-JB6R?BQ]ZGAC60fMMDJeA8#R-P0.\BK0d6V)WM@[P^>7IJO^25[S:6b
<-/KZN0-fIXM\,]_b8#GK45-?cD6<=FLPZbK\BE>cS)SQ4-S.e;&TTJ/DQA<)>DZ
f.VOJT69KO[\(7_XVbdYSLQ3R\B(3@(69-)>+.8HgP@H]_;NAYOP6gTBV0^<FOT8
C^Kc+b2&S?-?MSd_M&c@6;U++JZLX3M@S_a2R@:[g&dNGGc;N4)5)cELCe1K39^U
Uf29F.&X]&G.d)^ZCP:b#5VY[ZGVW(WG&Y0:=#;JK;8(L2,D0Z=g?&LC\9T03@1U
&=cDX7<FN<d/gX8a\^eUg7JS1\LOX<E-gD>\A7D2P#bH-;-RgbE&9#eJDMA+C.5-
HB=M?LPTAR7aMPG@5e14OGA&edNgdAVTee\XWd,O[\,[6W=E;Y=0F)U0?]@>gMf.
Q#b)^NB>Z7c#[dV2_?JFR3WJ^L,R5)?I=e0,1?/Y3.X\fCQ.D)K4,YF5?2dg4GMP
I_a[W0/J_+9^c&IMF+gU8-cZ.(_:66d2PV)A0],(VX#AO^]([PANc:?AK[54.dTf
(@;9OF=^LI[0G[a,-Pdd#UD^8UHP&_P11W_/Y77KKN+5N_S,Se<KKQ?.Pg;56Sce
IQ<4L24QNa[BQ@\<I3O,G5.S>)S@[@Nc+E3_5597=UA(P\S?3]QF>FQ/USKW@Zg#
]5?=.K>JHL41Y9+5SM3P=_:cMY99d_f<@EFP)JFTbW=aL67dJY^Y6__8H_HA)A0X
+>g3\,AC@-#Ogc\,eLBT.]ESEaUge=#-WYa:GB\BK;+SW6;Z0aMJWPF7E:JS]A(3
NaD6)\c=&O<LVVZbRKH<(dY+VZ;)TW+Z?M96N6K6(AX+X4S),RT<Le)A@=6b\RO5
HM)2/N72MDJIe#BW-@HBL#d<9bTQ+8Qc@/XM7>SC/XW5Ecf9]7fA<,]VBUJLNLPf
;B<1CT\W))TER&0DSX_FdcB9/_1P[\aeb;:=L^^50I(.1<[K+ICKLffe@aXa3fN7
N35I#>@P,)J^;-bD?JJ,@\QB>e]QZV1,IU2./g6dXT3c)_3)Na[eg1eNIOR/A:,b
BAQ).V^,?MYY>3N<U&(&/9>-795W[S>;N<LYV&QYLc6]-K7VJ-3H\QNP_4>d0#TE
Ec34d:R(5&1&X_aKM0f+DZ[.X,7KA5+7g=@?U0;bBQG+N&?3aBG&07CBHd<H:;?F
S9^17P;832)^,Y8AR#^@g>[4WDOEXV,P&?e#R9eED#)D+fRZcc1;dg/PT0#@5BQe
<(61S&[2J7P+;G;7A0f/@&<?.E,]#_[&_HY5eQ\U+_?9Z;#V;Y6GPSQ.B+6?X,c+
K-SQF-Uc-J(bR5Z0_>G\6(7.HSQCK\C/T0fFE-_VP,?9=1gZLedP.G6OT_=(7J]M
?A=R.8gW_JYD?C1UFSJ?54RXagV9-^Fa<?;gHUc#)6]M>>U;^),JCA_1ZcGFIT@]
H(D4]=6C\K-2M7a&399AP)Y,2-V\OB[g1I7S+-U4L:4@>=WMRULSD+WAT0^J;A9_
G^\)N8PU17]SO;J[Y,L>dVQ@8HZ(fRa8&V,R/1+>AFM6/\P?O:-d)\U4<-)H#e#C
P;Vgg(4F?gb^#+c_,8A32ggU2@AF^N,_O8YNMNMATHT3+6<D,ggX-]?gM>\b^[QL
LZ:=_D;I#=LQ^72.NY#0:0([\-9@7/47YU[(K<HKE-1L@UK<R_OFHCVa-LR0X[Ua
Q__T>U=7(.M/F-HO-31Te)\f:F_A)HI&(9P9,>WQRVYP9P0\B63TWJ3Vd_eG4<5X
5c1:\[Xa+>L=)0e:&U4/8Ha<aV78M0eMW<g4;dO8+9)/;?LMa9#TEM2aNB^8Vc>2
&HHUde+=Y+D6&U?97eKd+Pgf=082_#V^;e#_8(8c:+D6b_TETK^V+Q+8]GF4<d>C
KUaba<2decQ]G&e>EId(TF&A8SbCKd6B[6<AbR1>B4gd_aGd<19IU^-T[;5T+XFF
OHb:UE8\YgG)>f>bVN42)6V?aA-^feTfGKK&:U+0eU^B<^B>QI2E7USO:ZK;KYB2
/W=_)QM;aL.)(QY\^gDKPdRb]WN?E6g1SaN_aO5,;[[)_=<f6XIF<0;7c&DA@5&8
:F5dYY1\,4;8#aL63?6Rba0Ia1-_OSQP<(4&&1WZNO&2Q?(6IGe41Ue::B0Qa?:D
@^O[I&d;a8,.]RfRe,FI<<T1FIL7#9CFXI]dZZI9e):Z1=T(@3Ha&[Z6&(_K)@>W
1DC[0Lc^I(5F3?O3T5&OTXM<SB/bZ;5I(KO/UXcQEbP/8&FPgR4MT00LARB;O+M1
AW]N57e1Y&PHS5\GLc/EOR<F(CT;,SJ\[R0N9/:8-MgH8=8=;.\)_d=g1Tcd12,<
b3&=W.-;2<]-;<08R&38I4T@;6)a<0];=^)_L1:/-6<CB[EUbGQ06^]IN#RXHYUS
C[92)]A=E#5AUU6<-_EB+((d;YL>[H7QTV?V>ERgX6fL>K;;d[@S0f6>aK+/&[S]
HeFWB3eRVbLR67LG0SN[8]E7I8>bB19JBV]IA]1WaaU((fBeUH#@<CS)UM,->)],
gA9ARCTXg74Kf#/-e>XZd2F(R[DN.>Q/g&0eF>C&c0c6^ZMUU;c@a04Tg2=eB;#A
[cMfN.P]B4TGAJG2A108N3\&Z#9&E@+?+H@Nd>KJ7GF/4Y?a?[<b,.E.==f(B6RS
YK/D/1;.=C\^f7YKAGHUGWY7>#W1<G]C.RPR_gcJ^]2LC]1ceK7[7dc^KIL#a,W)
1>-ZcI,C?F3<(9W+^eD?(:a?A7FK#56+[W9^F]B^@X<1S]bZ&XEB7MVK9BILE8WH
4\#MGOFd:O^:OMg)63TNbUXG:B_;MMVGB6P.a80caC158=;UXa]^&<:4T+aJ,Z_M
<JA4QbfY1HD8aWHPJH=eMAAO3=.aI0VDZ7=,TMc(_\\\6Z[L<0^A6,V\9&+&Ta_Q
M6F;L#_H>TaK_06>33)+?5c5?)W[f/\_BY>MI2;<]->;]4-8M;;I/&H-=cE(X,[Z
_/9\5D?E;JF-9,VO=CA7B#[0[Pg4aL+J=3(J>QO^09?C&;VB-UgH-ZTGWB_(JW8g
11PUI.)ZP:aO-4Dg?]?#CMA;).J[,Se./d=Q]3,FY-3DCI&g)1AFEG7MOfb#]EH0
d:]^?AQ)/eXD1;d2WBdCHFVQZ?=WT6dP6cNY>cOWAU-4BEW6UAP&df49bP:5D\<B
CU^QH2<1c3^QVfM_\5a(Wb#.\4IU^X]K8YH9K;X4;,fBOe^SG1dJ\S+Y2LU/R,VY
GI7Y0WW/9RZ+7LQ.X.2Q-.MM\E):eK-EXLT1Vb:f)Og<,F)3a#0J67<g2U=I7RO9
V2#aTC)&Z3^Z[Fg0QX_UYeW/N<FLAaKd;./<ZaSdE2BR]Y(W9e,UZ:XK&NIF:(cG
54Ra;.f0#ZFWOI&.ebMBXKPKJ5XDCZ\9ME.ZT[M46[N/C/-KTD&#@EBH):J4.9@P
Q#EU&K<a\fYOHN7?Eb>OTWSHCT,[S6,SeZTP85:B]I,TC4g\5N0;U_<@579,N3_R
]0g23b#9V(++Y2M_:e/K+3_R3KeGf>L(WBFGb+D?@bG.U;Y\/OSHd[Z&_SbcJYVO
GCI@:\4G?V@&E5K.H+8P8Sa>4.R_OU(b9:eKc5KMVILTF(R:;:#Mg]O3<22[?TOX
/0aSg_cB@7RbeS64:d_\O?TPB1J#CT7-6FMV?cefU3V7I42LDT<_\=a(E47WWKgA
[[eOc?D0RRP5bHL:8#\RcbCd24PX?OMdP1BT-D<=ScXJ5H[@K5FY5Y#-,CXE.G&f
1S0<X+(37S9XV2+G-=R2X4Y6@aB:#N,4)\V-XF(\Tg9^_N:0gBH4SGRXHY.YMdH;
:[7G/#L(:BT<9cA76,?/.fW&JB+Z]6T<3/\Y^U9\C_F&_SW\O@-cEa,40a.?Pe6,
NFT0L_fD]GM--/6Fc\@X(Y3e]S=HPNB7G3]Hd6g-.\VVbd-YX=\bg7L]STbM8;;,
=]R^Y=8F]&>\:_36KGH6GML\R/4b6[#KOdP7c+>LA>D3+R:?0)QE\UQ_HA9&U<6W
SQ#]R3<])f]08<HM)&TN;V;QOVO1PK-^[5KG;\UG6V9J(-/0b8QM?+\\,c+&B#?.
1EMY0;.cY&__0.V@HI#5g9>_:aV^8Z=<JK.\EYGFFdFec)6</K08+K?BfQa43</9
Sf\5/TP>&@J.4[1U<C&cN;8/VN/6Cb]O,KLa&W8(OKPBfT->.P12]X6Gd,N?,c)]
(c-NbPL4FgQWb1]WR7I0F=0\?TRdZNDU?JC^+EL)d;Fe:]-Y#UQLbVC6=&IQ^Ye5
\O,^8f:K_d;DW9O;M&+?BQ:G;N-gee+)MNMGDSP48(dA_YTLVc<W&:2T]HJd99<H
IW;63>#L=+VHY]FI19-b>BB4g(NT?8HB?5[N\5c>ZW.Y;]B),LV/B<^\gRc2U1Ib
-)&.75D;[01KN0^?5@bTY3#-W/2JJ&gO.SKE3/SJQMT+EdEBe0^NB=>I[?W2b(_X
Y<M_I1RWV\=T-X,Q\2U:PN4=,g2W>)W8_JNL]BUd3=/A_F)e.7N3VFIAH7@,F5+0
F^)-4>0V12Q\.(g;=NMETOY;SPJ[V@E(X0U\40DCKaYJ@LZ:4)7RaEd5.[#JN@BD
b_99ONe1N/5Gd7a8T&HW>N1FSc13W:1N?[)8UNO=H/_R<:F^2Q?B-2c2Z2.VW#20
)W8?7PK_VT+L0SbO,(#aEO.KCDRHAe+825,FY#26Zf0+IHL0DN]NSAa]B?NGYZAf
.2JF5[H^S,Rf#0^a]C;=.>1,W6F)/>?[.>&fGR49_T(TX/-30XEP3gH/=]aXa4D>
f[fZ35Z?HZEO1g3XRP5@[1#ELTVSBMM7.ZX8K6aOVULDO,G;^,AH_bHCbR#8U1ZS
\E<A<c]?KW]WHDA=QdS4N[:c+a9=Q@L@cF,AgRIRLE4eXZ^K4-f)b2S#_>_0:SH7
\_)MDTR1Yd1R&V>A&NX1L=PH#4^eN68^<09V.OC4bWe0^Y#ZdJRI?9GcbYZDO]Ac
H#d[+MA3WXeX&;QA@T,gc[^_ILUbUP\J2CSKKeRZ9I2W7f\EI0RG9Eb7=88CG@^]
X&^J0VVMLIRJMPZ8?5@8P>E)e(+IT\+Dg6F,37gDD0eA<W?Z5bM-54M724-fXOCY
3;K^;,CB):I0+SF+@=&SYDHH2;VM>D[4UPO9H#-dM2HcF9WaS2OaPV/M5P0\0+;1
Z<-5>#;B^Ge+Jc/e)Q58d#[7^BCR?O=X12OH;bIeL3?^4,\4>\CL<G5Q[.=2dXC6
M5J<gE,W3W+8//W2B49J5GMD3SB>-PG8O6C=T@^(EYb;V>-OQ.B-)=OGHJef42^C
c73Le(OIP@A^+bODHM3A)c3OEIcOXF\&UgGVHL8..5,NF2cGUeb3UH&U\66-=?,5
P0Z[HXIeOE-PP@VI\+ZW/TWN]NB,64=D?g7(<CAf<=@3eWb]USfGUIdSB8D;GEcQ
K/cIbW^;DJ#ccb)4JJ7=(gRd0P3PAD&KV<_;5DJLFZe\2W3^8/KU?Q^fF<WRFb#C
A4B-^=>MX40X[7GNQG:1ASgS?5g#1QLgCU;<P+@X+/a2KA^IE18B2.I+5+c>V:FF
AOGA.29^[Hc8IBX9R2Q.R9Q.AIGG@(#R20Z>IVMI]5SUS2830;J@8>[C76#/CC/.
N,&X>;(#[VHTgJOVH:CNXQEE(ASNP:<E@f&:<YT&L:.?8[-f[.E>LFf26[;c\,Zd
Of00CQ19+1PUIM746/\N^]2gS9U.B#b&a+b-dDBVN0ebR[:BVI^dU4W^>bW&1^17
68#^Xg:N\5U-dSEdBKG78)4R[5S-^R&9E1TBW,FMH#EG7L2-E^Z#OLKf@^Z>,c6N
1,;W0WfL.LgT=e#WKU4D2+4H>>72V#Yg);M[H&;UIE.gVcS32_8W-&?f\Zf?1^AK
)f+gN01QF7JEIX3cXEVDP9gFbEbMb-Q>L96=^aT4.0?23FT##OUVgEF]aCaN\=3]
C[-\>bB2T3NfAU-fGcH3H=2GXKeX)917YL5^,@/O7[BIJ(?-2WTFFGfE320<8IJ<
.VOJc=&FSR8P:HAVKX8:J6)OFg:L&#L/^,V-;E^9Y2OJ99V:)-B_&YY:ZUL>UY6e
ZV[8HNSe,16@DCT;eI?DEXV]K#L;DJ()MXUG(bP2L,089CQRb:\-0<eHOWbS,>OW
3Ec7_&M;]-7gF60^PG9M6AddEQH9)U/6W4Sfb7RX?\,;77DHJX2e7[=&bI1.^U7/
X-a9UF7aW\R2>ORFUcGT42T7)L-LI;S\@K\=&?:GB:Wd)#Y<7C=^/:eb4NaBeWbD
X3PTf-?D:fcY6:RX905a-,;810E;BT43R_Rg+S&N64I)+RU6T/b;.5912e?/@g31
:=(aOT[0DRV+<CXF8Q9a1E#bS/O@cLZ)gG\31,^5>:c7UNFZg?Of5DN<+cA?WZgX
&BXDZM[>==1Y-AO0+QD8V[,Z64WHRd<FIGQA,F9I-E=FfEaQ47da-ZPR0GZ)HbZU
:=U9>-XIFYS?(EV<\XPZ(Z?9I6N)B_V8J=\7^67<g2-Q999[59dG=[\)dEdSU_LQ
I?+X(0<fJ.(R#1OcI<3J65]d?P+&-6;/cc6[Q]&BSe/P(W&E(.A]FKPIg#6SPOd@
,(#\ZU]G0,J</N(18051OU7JKKMdWP73NPfb?R8UL4V=,?)f07^3#=^D>bOMDV@g
<45]0WXaPBP]HTSOc/ab(N1P\9<.1M+N=_\HXO([3ZH=A.<W94KQB3+d<+[ZAZ#b
,OP\CITeAMS58Q:K/P4Reb;^;HbJdF4gaWRB#5caL<T.ZCQZg-&]AN]S:,A5^d>Y
-55GACCYTM]e9>:fGC(SLRc.IfK2(GP7eMIaF51@32)6D&S:4T)[C)PA+G?\3c@#
d&fY\]-LMNCJ4#YF)E;6@8U4Q\<IKV,(X_>E6,OD^\NBF[ebdaf+Q#Y8]BJ(2<H\
:.^gb+NMegR?aH>E\AW_Z6b/^J-_JO-Z][?Lb;N&+U0V=2:7X&^EaP?M(VC:+-fX
EHTIKc69E9[T]c(+LP.ASFVI^?;cV6a>8IeZ<Q[-DB\(I2+?;C)CV:9fe#]d/5fa
>-BfE07Z8YITL.7?RS/>2Q4S6d=F7VLeUG:Ne_7fF&gE@)S>].4KeNJ(68XUTBXg
EZfb@-PFa9&U+9NV;bUgL9fgGO(?=FF\Id@WG+Q85WdB/_e<,^,#9K9c<2QC&VJD
4XG?M9_/g3-6QF&ZO_7XAH>L\B4RR<?WQE(O+?#L.-?JLScKY0A8g(R^geYVFHf5
9CWaZ?Of;=G,U\4P<GbW4d<0P)N4-Z]bW/1O=P#=Z(M>3faKAK?6QfYUOL&Y4PF]
&H(8;\C<=fcQ,+IXaG5+Wf@_CPZ74FBE@aAgNReZD+@)?]K4QYG_9ZTFd?VgW)a<
E#gfRb@^CJ1;>aVb-cP38TL.4IY.SYAAKC()d9[UXD4J^,#)2\E:H=VQLRT^-e>9
&Lf_M_Vga0gDf;\ab4.QW2d;+O[RMJD/HfgFP5Y0/Z?,c,c_5b3YJX/P@\D,YS;?
O@)T632YCVNdd[IBCZ@V.IUI;fKNWPd7\O4GG4J/^6a8]V-I6eW.YEW9MA,AC)?J
F9H,c4D/:;TI\ET12;RSLfOdZ3XI.d3Hg^YKD598KR8]2PGHU8,:YeK?#_=Y+.be
+cPO.d;/D@W?G3P3)<]0YW@\b?<WUL6]9A+cS=8BY4OE5ONGG.ABcH,6.[FM7ZMc
bebYbf@(OE/Hg4DMe[bF^N\3,aSY^@XVe[TNN&5=cZ(2,(V<M1@A1UE&Q.W=\(7[
?3.A&d]>dgd<cT?c=(KAU[Ga)e)cKFO_XS7_RWE,FRL2^)&IOBdXUFeTDbII<-NQ
cT^V&B&50)-1aFQ=-Y(cMgg=NAd[M?QC9?^@RRN(Gg#E&X546-<S#<@P9NI1]@+=
1XgMPI0J<]O)7c6@U0KSXe6U:Oe_e>&aMbCF5b^[V:/#-2)bQ::G>\+,LJAAIO>H
3b)c+4PJ<?aBI<PXI##cTYLWONe3-28B+^.C0S9c@2Z/bVF<7O)#V17>GG/<P;\U
BFRYPd:Ye>=I+>@b^.^5<XLe.7-d1/>#M#-3f\=.5-3d<Rf&5Ba;abK7GLIVGPg.
@8SUQ:NVXENMAT-a1WPN.aW@A8-#IM<d>_;E@&<;)V;4T^E8=JA/A.&gg9/<-bRb
A=46\SfcM-(1N(]HT&9D9\/@c_T6>G5R>/FeL?>eYEL&<+BE.d:+B]H9AWEf6=JQ
7Z0PE_/V@3K?8F73@_]+g^_P=Q&&b/2<GD<T?Rf&D0I98Z_MObAfSCH7/S(^D(B;
DX5C9/aW.3GBA?^&DB)dW-5.XV8S1^S2(;DFY]a_#aYV2P6I/Y8H8MH>dU>SH3Q:
,<A33^&<a.?&)]A&M37gQ?-dY.PI.g>a/5NRFb?T?\ec^EXOKcI]Q(af<N1W-gI6
Rf-gZ4E=1U^C^KMMT_\V&Z9YX2-7gT8L?[F+R-aSNb[QF>?V8C59=HaCK&@A+&[\
OH[CaPPY_>F-SNY87ZbFI)3:g4EBC(QB#D>6b=bX^e]L;X:443Q(2=Y:8/f(JKgG
Z+T2D[W/L(1.OP2G[2dN[^1W2V1[/&@+7)X_5@N#6\JcA4\B)-X&80((4-3<4?A&
6X,X=\)[J+b)EK/W]0E?g<Vgd4.^GRSJF8f_L7RRPY9#)=)O+J4@[=UHeH^64[6&
ESfSY(ANI@Q1?B4/=4]IaI_E@WUP<73YJ,B;XeBUNE6X<9,3E^SLg1[MLfP_:g7=
T)gegJ6&H,FK(9#,8aFWa]^BAeE48UVN0M_=GDYS[R<=Ee7fM4Pf.,CK4YQ5^E0Q
Y&Kf6X3aG0gVa<0TX&VD[g4<YdJbSa#Te3^C(5KTLK)3LRBg-_E?aD(ZL(\Wg\L#
)I1<UIS)4BLHTeM_PLIeD9(5)>ON,1.Q-&R3E3E3P;R#KQS)IMPR\@[+,e&S#/@7
ASac?96LeJRRO-+=R\L>Nc]C:)ME1Fbf&(2)9CWDW<W0DYH-JdfU<^+@#a34@+A+
RAZEC2-72T.Ne<EZFU&:<27PF0?eUVHRML@>Q(QMf(63#\WK.&AD_8ecYQO:8KOb
OOL)f(A:aIb)HR(JD,3P:aDS.]\T)&&<4@_[N\B.>W_UVGXYU5BOWFT[FP1ZCY3;
L@S8UJYc:(T,_ZTXVHKZI]c>1PbD_K+[2E7f];Ge/B6Z46HKXV6V7Uf4RB.]&/(H
fX(.cW?d&(<Ce[XYEA#4fa7?e:(I-:g1WPfGNDa?dBPY)>M1FK/A,G=[1#O4+OAR
.11Z6eO@ReG)O-G]U-5TNPDd^B&.]J#3EPBJ74YIGe1D.VAP9XYSFU8ST>0d9GS@
<9QYAA578##R-1a8)Q>5IDf^).ZYYQBGFR/b:#TJ.^8d@fUA#J@5Y>?^(0Qf&bSc
&2UAQe=dc;98ROdFNQBCX-2KO4Rb6A0-N@Dg6c3=/QBI--(F>39C&;=aW&BU8L78
MZN=5]&IA9<\BfMgSWKCfCX_9O.7Kg3A;fEc1+eA-Od85MKQ6/U\a+K^+2_3X],V
+/6[7<@f))VbS_(Ne^);fBMDbH5+@)+XEdTJO/RUgTd:d178Gb5E(.BSe7eQUBH)
a)-4R5I1\VM.9C8/#[VQ;f_0]]5(db04<2&-g[/RcPE\K.\8#gW8E1fF[K)A_Tf-
@<+EbBg_ZYG#AIg3OE9/[]BG2=]R3N4L1JKX_GdK]<#eTQ=5_(aG3@,IB9.<H_]3
U?U:+Uf@]T6U692N=;\IGOD576[MR9Nce)K\^/OfbK7-Jg\?@QRGFZLOd:9_-=Ld
,P3[7PCOKCE.J>+46]HRULUa>(fYO\Z?;AY_99b4TUVc<JGHI0\+AfY,;F3F2<QO
KS+&6IQB[<F&)#E<adIg?5#KYd<1/@)cTg/B-(5OdGgAZ86SAdMKbK^ZB7e[@NO.
NU@X9eG(fg/d@#ZCc>I@U9c.F=HQN?58[cR2Rgb@DFSDDFGI+465/ZHFL<\9E:d7
T26O]0\C0=dSRf(1N?6(Q9=6Pa>:E+c3Y\<F>A_Z=HYFSRKN&.SX@/:RY9f6g[A0
M6##H?X@5TF]AHHP3-S]R30W1I5VNM(=g17,fZ[3&NfH)]>#Q&A5GZ;L-&)SA#&0
f,:UUcGG^.YZ1>W\-#9-UFPg/Wa]Bg]5Te+LWF^2N.[]f)N_S;CbNC:=P<MgJ8?c
B_O]L@<&#461Y?f3HHf27>b2FF\5]b4C\^@#_1>W)fgFJDW\DDaVD6<H,U]\g#NZ
8aR1A=cRTWCX^OQ9)QX#SF:U/Ra@\QCdYI#6#)QNC6--\3UZ6GF:e4_7ZN@PKa4&
-2LJN&eScRQ77d]R=\;6?]aTGJGL?Y=3T)3(UK6Q]S_R5GZ3PH@Bg[T=T25N[&E#
@TK_6<5KS.9CDN8-2C149aGYJcQK6_QT^/6,XF.R8D1aBO9dP@Ie_,II[U]<5?b]
aCOOC>X&43OBK[5KCI>AQKbS6Z\F5G/RQa-9B[\;B\I[H^Fa4?#S/@I1Z_R1T3MZ
O]2W/bVAY#^&:IIR@2,&gdbB#Fc:SPg7RJY\\OQ\H@GKOV^bWR]ET@Rf_,86^-7U
c[7>\#DbEe4)WV\LU)/XGZY:NHFHa<M3H-1HDR\BTbA5gVZK0J^0aI6I>UXcX1.;
e>1FA@)3+[JS?F5-+NV&5bK@_?b;B4BTM_/G\MG2MJYR:=e#+(Z:YC[D/0E4a3:W
#8XRcUGW@;OV:HXIWO?X;+A@eVcS/=Xd=M?8;+C^<b#/:=N?d(WMeMd[CJf3a#P.
M5N;:_:(5])Dc3W6S,@c(5bM(2/)dcOaV#TgY.7KY/32)65BXR4@QJ(UUMJJ3=O<
B&.e1(137P53@2QWU@6UXN-L-,XW8VRL2BJ3#7gWI>HeQ@\7;3G^f4e>J(N5SWCJ
^TV:9KODYQV@3dY3WF_0g1c)cB:.NFMSVeE3&)D_469e<XI+H#83d><;aK.WKdE<
cCCe]e,D62GEHCI8e<LGE+8GLG>GF([:_AT?#I\>]G7(T9H1>&=b#>KMe2812M?R
M.;MD@I:\)dfTDFad/JWV+5f10F5K0OQU,IUXI1@b:b#3_#Q6Q(:/9e_egH=FSTY
/OgETdPBO,F?G=g3Kd=+150^gKM;YbAYLU/Q_(;3LP^cMZECMfRPLXKTOK8G_O#[
KIAVKN:MdDW;@C<gXI_P>I/H2U0;&J.^2PC;-KFH&PUfSb+[6]a,?AE4?R-EA)K2
\JH^B[bP#UF(WK\UYI^WO=)X,]/+OK4V&?Ta>Tg#J#S[8?aEe(e0KUN^,1bI(SY@
;>X@CCUa#JZ4VOg6^I-\SEE5(ef;#,2Q503d)/ea;7+-Ya.\L;\^MZ:1B4c6@V87
OQ\e=V5>Uc9>5=C5CGOC+[FR&Wc;L&9g9<b?dRZL95ZKOF:a>K8O3fd0&-g>\U=O
MP=[2X8G\/QfE_S=NaF]RKV4PS.T-:4[(Nb<d4?AAX8<2HUS02&/Od52TW1PeQ(+
&?7&1g8V2S_8G=6J(fL&UDXVSa=G3_d<F=Fb6F:^/H2EFAaJJ.)6-<+,9P\c/4C]
6,fRWDRM<2TgX&5HPQEU>Y2TO^4fBF)eXc5F(L]>/#2OPdQO5C<K6,8AfZF7=N?S
K\XKP?1cLWD[\H5)E^GE2P7S>_<a0e0?6Og@,g9++@KR^MH_V7<UHE+8f:b3VG>&
HB)V2KQ<dC]YKY;H.29EGgDb?X[P,d\b1PK55HbWT>T>P;N>H3B&De3(-BZQ[+g>
NO.=WeC^=6ec<4&+/FbT=&10^9NRFRCIH-9g?0Z<:1+#RK_JXWb/a9-U?V;M[VgR
<>W//#.<;<TZ1P#afF0F>:GN?6?OEfZBf2>^,T_O/f=b[QAI]6EARUaRA?[AJ.+E
-EJY4cCN,H(aJLJR9bGMDS_B&4X3.eN?/X[dLb6>S.Y\8I6@]A;MAUf;)T=\7/@C
<^MI/Z>/(O](_>f2M2UNe9F<\0Jfa6.U.Z3a/7(VVb+,O7U3LT0D?W=5/b&3+^=Q
ZQeMBQ2O>H:aJNMMI)G?eV(<f+G/MK)U)+[/(1f:eI7L;I+-=U[JISCWXTGVUObI
<1\TRSFT\_0_3MJda;6E(5B9N@_OX\N3>3>:10@G>MN476XPO@?P>31R-V8RgeI;
]e-]F<cG/WE.<3A<(CgZLJPF[1LQL8H=Zd9W.N=\F<9:72FYPC\DJC\F?]^[NVME
CLfX_-BI3A:KA-&(5fS<1+eOYO3Z8#EG1eg_CX);J9Ng>#BBMUSPN&-:F<>Sa)8V
U2&T5)g?SF:B;EZ\Zb1^.f0<:6]Z526S:&NG8;S;8a/b,&)a1g0OJUCCD^:=JQOe
EdEIEIM1)7Y,Lg-:C&#M\F/AUSMN=BVVfPA2>Gc[Qc+JQ]cLZ2I=VTG0X9gU@E+M
T290eS9):^\/^YKA7d_baUJSY][eZ;R4@H(1X0O2O.&<d#_f3dZ(GHbRFYB3^+P0
#?S+b.[C+8g6P\N50/6M#H[M@+Z\MZ7Y=c43d#H2ZQX1)3IaAf5)2M/8N0&G&f52
H#21V/D-aK)]:P,G:GfC_&b+:Q\F3.TFD2)c,/K3UOA[c&^;E5K)O?:4FeF&]W\>
1](O-3<EWTHVL)/JNa>e]g5+@K/V3+:I_2FC>EUbJN[Uc#\=]6M/g-KDUBg^Q)?V
d6G[)VQ^=I>BK+JNL,8OM<9<Uca/?^:,:Q7LU)INCd7\2CIg7SBC#Z:4NE^:bPG:
[aJQ+-=)aI:?N0LECW2cKO]A]QW:ZLBg7D,E_6dIH@)K7&9WTb1GaTJOK]1CE1;/
0UJQC7SJ_b=:W>B,)QT;#KO9A_X\O>OX?RZ2[7U5YK46;A>g#7C+d.&#<@R7<6UV
^1PS.M5@]d_5,70K9P<6<c;&A:_T?I#H_X]dQ2CN3C#8ScP7EZI#C8GJ)\L<@__a
g/,=WZN_(Jb-GH,^gOBO4BcU2dMX<:00@\74_C4DV<.B4?0]>\\)]WD?\N^@2?[a
PW9XQd>9;W<3;[XXT9>F)efTe]^VR-[;\HF4-A#LcZ(Qe1]@c-DNaN>P->b3-^:)
_O4:7LAW7VIW(1M[VO(AT_#DCggU^#=#FFJ9R=O@5<QaQN4;JN(#W8^WAbPG/LT,
,#W(&DZ>TO^JI3DN0ZRS9+N13M,B_,DGI#8SOH4BeK1O7=AeK1.Zd?g7\4Xf?(80
<E<WEC,D^55WRbB2N]P5f=U+Ng,P/+XZ>SNQ>#8e^NE4,/9G?/YbDbE([[3]:X#M
6^U],9E>f+^7D/NQB;Lf-(5ZLI2Sb[fPPaJ>4@fMAPP@UN9\6>/:[7EVJBHbA=3-
HWc(WXeeZ50K_SV+^1/42;+3?Z(Y:Ta(gLV#GO(=QacTEDc,e;_7WT/36&IL(^S,
BS?PbAb,S>0=)YU\D,WTDa<PM.7-DJCe,911[G,a2ON<C]KKQ>g\)NCI.FN(S2LR
KLDgCf>FdEKeW6LE]8cFOGKL8J-O9CR3=bc;W36_7DSB_F4)940-;+>Ag32KcW9X
AJ_@Q,;DR\5T3(CM9?=UWHRM_b2A]0P&9$
`endprotected


`endif  
