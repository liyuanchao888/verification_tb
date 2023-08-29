`ifndef GUARD_SVT_AXI_MASTER_MONITOR_CMD_SV
`define GUARD_SVT_AXI_MASTER_MONITOR_CMD_SV

/** @cond PRIVATE */
typedef class svt_axi_port_monitor_cmd_assistant;


class svt_axi_master_monitor_cmd extends svt_axi_master_monitor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `uvm_component_utils(svt_axi_master_monitor_cmd)

 
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
   * Run phase used here to raise an objection for hdl testcase, it will be dropped
   * in hdl testcase.
   * 
   * @param phase instance of uvm_phase, which is utlized by the base class and 
   * helps in phasing.
   */
  extern virtual task run_phase(uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs overrides the driver implementation with the VLOG CMD extension.
   */
  extern function void build_phase(uvm_phase phase);

 extern function void connect_phase(uvm_phase phase);

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
.c&./_eGL<<V5P&4CfI=NaX^03Qb.Wf4?-ZaQA<5a/1/GM8_cXR:/)(e@;fF6P^6
R_P&E;[F1?KVO#,=)8cAcaP/aXL5X.g<R3BO[,C.9VS-)2YDMCJM-#&)#F8YQF@.
(c]DbUU3DD)9.3b-38GHJ559?+TQCgNN(-bLaVYff6d(M+-7Id1:eQ]3cI9eT;D_
O#(&NH(VfYU^AT7.bGI5bP#K&?-HSbLN=$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
)@Pa<U,5<2OOJE6cGQ<b&D_fIF9?#A>>E>Q;A\82)+)K_^@M]X0L5(.bc6W5d12-
#Td4bAbMCG2<GE^&YfN>W^4H^f/&_1OASX_+c0SdSWBV0><,Dc<&KK4A<aJ/f@f9
)^)OXXc7LaTfIgc&VQ<;Hf??>;_?8..cJJYJ#SNS8=3HC5Gg+\dBS]J(+KXe><XS
\P7a2)Bb2>KXZGQR_E.g129GIg.aX8G^ML[1QIA/K6bPLNP#48R&E4Le+]5R92g8
(_Y@dD#<+66U4cG0Ic,&3Q4._+FaK=/P&1YQJEH]8dN=ZaK:1f4J,0f.6DCL_SV\
42b/YEGb??1\?]RL2BaL<aKM8JB+_^IKe==MG)+@O7P+gPJ60ANJ&+E)Y\X.dg3^
D/\Z)^TCgf>cBOE8f_,]\JO+3M4)LL<cI53[MXKc#/#2]/2f2d0]U1VPSL-a=C(W
HW^AG1HH>8VGRCg1YYccCU_.O5K-@BJMNMe8dPeQcWU)[2=31>cJKOZ+bc4ec77g
M+gc\XXV#09bPZ:G)V.\A+DILb?D0AJE5FTG4=^/Og7H/G7M+XK9PEE@K-dM[AK;
ASW9AG_(QDf2f>YX8-2G<,\,A\8&R.PD/1XFQ7Y(,YZ8G]D.T@K,fWX64/\<E&U/
6LX71_Fc^9QOgWE:]d9=\YP7e2YfK(-TNA5OM=VF)34c_&__J,LZE90LJ\ZV7NQ]
0LG5^5M-8[9NX^#fJD>)NQe-:^TOca,Y-CLZVW1\,5G254cS3CH-J740RR:U.ebH
d/NBU:^8V?Ta@;<6PY66)L6>N]J55;>&^^Bb5G4E)aEY?1]He8(BOY.(_Gd:BZ]d
4:GDb@+>U;TeXQ?f0-].fVRNWGdQ)1g0)J)L_2^cILMIW-E+g4C)&NDVfM/XJT72
0fg0:DR^e2Eg.(O<N&\:Y<]1,@FI58>K12-N^DeX\5&1(/Pd[)L4L^gZeC^G0@;b
_S.QJ^BSS(BYO5\XJQK(,<1_;&9E<4OfYb/3C<;_K,@]E@;Y.=SO#-45XG\@=(@H
G#>#a3J]LYS)#UbCEB99-YJCEQGN]=R^14A_<CMKI/Ea?8=2F-#NJ/Y0c:fM,;PS
1;2c]A:H9V5^7(6.8fTcGTK3c.IBWM&eU7(W\LG[:?9OPW),K-48MZ<)1J^T:1Q0
43805>+5cFY)eTQS0E)3F:-\g,\</_@+3@KE,\>>V3^.20f.._IVPe&#2-:ZMURW
gec[^F]9C4;<(gCEV;<R2IDR>d5b2NA+-#Z)D8>4e^#)GBfIg^AL15-Z\Fa.G(HF
/1f0G-V-Q,MXb+UOP@YNX+_d?+5ac7WAF[)AP1Ud#]:[(cHH[_;dCZZ.+=)3LK?U
RG&_2H):P;VF=WI9V(#3eTG)4JaCca&c[5VRbMR^]0W+>7QG4QF;P+2/7QDUUR&C
\>TBeJ;ROV>-0(KOTS27;-2ae=Ra,NeU+T&a802FIea)R5Rf3M,H;fb&J2UY7LB<
@4_9g6CB1G@S,?e_@W)CXSIE_)]PJRY8LOF<QNN9-,AgbT=VDa=\59c,4IM\8(HS
9E@[bIaR:N_Y?8YHCRA/L3H,R_WI<6OS#S5M2bEAG\.dF?&0OeQc+g]SX,):aT>&
N;/;?PB36P_]@->:dUG>H)89.SQI>]E)879@f>#5VK^+J7P2gFaN4D)[LA&c:)<M
XFd:CdFG0)df#d7LM]bWDf_;JDP#MARK8(4JQ_ZF]@^7^Ze7,NQJQd3D]>:E?V&A
2:K4,0G9eJbN4U]C+5=XVJ8Nc[&O0bK/=cYB&\H+58.;1cJ-g=7[V9)SS;dU3g7T
\7JSf=Y(.]7-&A<B1=LKG7U@gOCd19eH,LT+K]5]A6FC8+)@8(FaY]P7a.-eRM5D
0fUd=ANR3:A.D,>dU4EH9b(R5NODU<c_6/]D;f&XI6UIRNd2Va4AeNg-L1Ad#D98
QV:G#U23BYa^TB;a@WKe+AX1,VBF9I75T#6?:b;0g4)&5Z_c44W;TZdX^.C(SHMW
H]TCZGU5X1\5XLM(TEMaQ4B&QX--U:M)N3S+9a^NWAEeII)E)98EeI^RbcH##L/R
d.Y,2M&)K/)A296T?6(=bV7>dL0N8Z_?&]X;#,Ig<0A^JKT6[Uff:^FWN89d&;R)
Z.&&ID7VP4)7#bT,_XC8AX4&2E0OV(@I,@GGf=?7T97&JeSV9L,c_S.,B[@/\C+F
5<X/P?OYDCgVQ&)gaIcH.F+&3F1&A^_=4CJd0+3+J3;,cT&RP;H.VTQH#2=8=R1<
-^c.G;C_8A1g.[JWI+Z5+)E)4IO&]e_O<=SbaLd;e_6N-^;TId,bR(>_O)989&4;
@F76YW^90=LYI+=2;:+L&U>c<]=J?JSD^<_]Kd^XP0N^@R9WS(V\]CdBGfA>bZ#a
2BDP)HaR@VBSKI^)Z7NGg5aZH[IR)88aDG[M-?--@gHAM,DV,);HT\H(6K)+.OI6
^B?0:,ALY)O(E2)4G+LDWWM]@T+=Y/1Q](QSZ)SL6g_aL)FJ0MR\\X))\T_K2#4X
#g6=SGc?I[VL/NHA3(\G?+LC\1A-H),CO?UXZ>[MUD+dZ;3JH:[1f+N/<\.>^)8D
BQ<F-e):DFD:H_g[;L8>:a:bBaSfFCdPA&1FfY(G(]G8S.eQcdGI#f35S=3KI>bE
UA9<_f;7>4Q73L>gI5U47GfD_-5K@D^e2c3WP#3GH09(9&6BJI4.=([,DE7E2+FT
;)#_dS+N.KZC69Yd_5F@UO=aM;4MgL(0FCC.?1[-Z[WBLHDZ?-e^EYGR]HdGGBD4
=C9UWDU?C[]M^(Qb)V^EAD7ZQ.[8a2M)QcX#ZSS)WL]\8MS_-:RT@JD:9@LC5>2H
]BBM7^EK<HOSgO>Wa,0MYB.FSO&Z/b<TF)KbG5P3G7N^-U,5LL\UIXH)/->/CeD/
[ZOc@K(1+A1eB#VX32SN=@+[\1X0/\Qg-HIO3Bc>2\WK7#VN(T-6O1-GfGWGO,EY
6^<g5HZ6deVA@b:EM4]1WP0g9M^Dcf[WT&2@LOf5eb5:G>Ff@bUBL(?fMG?]8Sed
0cO5gaF8S#I_P99(R6&)ZfS18KI@T[O3.@7/-B?b:0J_g.M#bXgOfX]6gQ^f-1L-
(_1K?.>IE)V\Qc>K(fMO/gNQg=.>VP5<aAd,67IQ)[P&;8NDJTReXH\b4YG\WcPO
(b?aGP^=EdZX1IRE38FA:@J\A7>Cd3f@=B#DN]@/81bXWVa?<<0W]^/WgA@Y/->@
G02E/P6MJ(HM]-.C#&TI(?EVWEaE;?RGNV+dc66>W#MRY^^B0ATZ@^.<LTd8Hb\(
27:+@)-F_,d;<PBa24=RP,UX=<@&a8g-/Hd[L5<bAS@O+H=7CHN7PB.R-OPYC,DV
9D-T6#8QYF+0\5DZVRg<f;e^?_/g^Ec]\[)aP-bL^Y7TbLe)#++WXMYI4#+2NDMA
Y##+7dHEP9a3:\IRUgEeB6Q\KEMB>/6,IKKWB>:cESA>45a<NBKUPB7(KA1U(VS3
B-DbBU9]<7M=T5.R^]_Pa(RI?2<WTcI6;d8GV?7:B8Q&7=LUNG;6-)[P/A;bWAfb
+&00>U58dA9ID=9W71HAX1_W]KD@I2=1]<_M67ROKB_3_?O6B@D-ZL-E]A.&4RM(
E5::+6I_9+caBYCIM\AX:)Bb25&(+e])YO/\e<BC2gCBBYK6[O0R^9F-?AYT^29O
F+SDKb?3+8EL0Nd7A:419K4)2Y3RGfS>F8b3/#V).;76P8I1-?K0P,,M,J=)JfTV
F#6aQIeD>78ZaW+HG?TA:#/^)+bFa+cZ[B#]Z>JER=83<APUOU77]88LT&)\<gZ:
[MQ(V:Q)eW9KNW]\&;;eEH0aL611:g6ZKa(f,&c[W/@C)PbZWYY(58dU&O(5T&E^
Pc#E8G=CC3W;Q-JB;>d6c+2SW<(?b5\O^P3-A_0^_<<N0,[/)LbEgQ^0QC=A&8/2
LEb#40@gW-8Da447)[]dfTEW&GZW[YKgg]+_FAM3GfVXVU8LET\cC)0\I=,e.1;Q
RdQ&5AR(T1>H(4[DI&M1^I-;__f;K2YR0@TcX:dQ0QYZX46@d)-[<XE5a1c&H&EX
9b,>cb>4O00Q98HU[B=ILC:X5-O#>g.fIYaMc\7.?YdEX.=c>E<-P@T?9T3aR+:e
De<SQgNP2B0_SW2;A/[e2DK+c4f/M^eda?0\fT5VUWL/G-d\GV]f18/C4)Kb374B
3IJH<H=Lc?YQ5@GcYf]KQ:&6<<X-,4a0>O71ZJ-Uc/2Fe@N&3X3R,-K+D9Bg(e5O
d7ZP9.03N@SEdOdPH6Y_-]&95>aJ3U-KcfBb\</gF0;aODMHGAPaJ0@0&Sd98OC1
I)6Y53DH(9S6I8d+0+d/_[6[e)(:.;-<WZ;VCQ(T#&6g]&Og[2;(FRc;H6R1R](&
S((97OD9\<A-);BCH=bC8JZVX&dOLH^+USS>EO4-g&YK60b9Td\_V#6IA_;VK)aZ
:HOcb7MY)-?N:>BC+e_+6RKMR\I8W<Y1S8\(a&/V_@B@IL[OGH9.NdL8?MSRFWcZ
_8ADED5C5<@P\R7&ES)\&(<T1C1g]-)8YB\]O1G,[K\;IST0;d8WEK:Ga(.]3#U@
#</GR<VG9;G]I_(Q]cd\INF25I4dXP<G[I0_6BA\3=G6a#.TW_O.LM#LI6R^?U#F
NSGVEDA,YY<@7#^.[c.Z:1_HQGUMb=\:)_EBU,WJQGQc\U/JOR-R2[.>OZ<C(68;
N#Le06K4BG9DGCe[C-N(?WL8e@A6d2GM82U31O4a3#XUH]U8]bGNd425Og:HbO7F
.Y>W^-,=YA-]\U_K9/8bU@#A-7\]<2Ad-If4=@e>]UV?D<)H7X[3-g.\;V#2H+>7
B^ab#V@=N:-bJ/=N?9UfDd?daA9Kf8C0G(O,&VX(AX2+eCJ#2Db7<aONF#adAYT_
LMD171c5QbD/U3.e:\WR6UL[AeM6LP1@#K(MCJ>JX+4)9G8CUXE\dW48^@FCggVK
/PPF=696/81=HGgfbRe4T/:c74=U2?UFD?V&Yf6_V\:(.X3c)RL;5]b19-I)>[F>
g,(e8#:CM<#8bbG;[81.f0/YfY_&?<T6VW8>U\Sab;f=.e][SEU<KW^2\N?a>\D,
gg@F@E;_0Z-:QPCV1gNPAJ:4YFGQKWE03.=+d:)fGR,Z,)d7GJIWdI.N7KeD]:\4
4QBHTOg7I64AX7YZ_34I;<F3#PH5OO@@1+C0>P+_QB]Z:(3b1(PO1g2;d(/>XF:R
\Q@Y2\A:,JTYKS1C&<1BB.gf]JE1KfQRaf=?RLMX;.D72ZI8AJ13VQY3BHJ8ABS-
?9:?V0RD4)cb8d2&77\_dT2T<CJ8HF40WR+A)#6Z-:GM-3(\W;fOJEg=N5WFA9]X
TBL3dVQKU<b>]6XRPb7X?^2W+@CZPdT;P(P/><\2BeNWG_[Xc@L>bUAG6]DK<@c0
?#ebA4^;I(b[9T7?MB<GZRO9X##X[PW;_C0#eT77EGJER;f,4Qa/C).Q7<VKcKK7
_4bE6BY?Y=FK(Y?MGK/&M1Z75,7;7?-W4THK)dCD#=\fMcZaBc4/<TI3-N5EG0DC
#B64_#AWfbB84ITR1SZ];-SPE\V>/>>\JYJBQL7:bX+MAYa49R]3#NM5T]RH@^^D
6+SFLZg1Yg76@:R[a;#T(YJZ35Q5I])25bF0&JX</<EVKSUU,(@CGfdM6a4A:K5e
C?D,2_TN\H-_=W:?^a&ga1V])fM<EQ3BF.2I<LMN=TUXWC?aW5L,PR>JZ>.-\-Y5
.3PKff#1K#EW+__J.UOKT++YF(@eR>#]g@([]:SP\)>:HCK900KBKUdf:<^S>G5A
LL7(W+W+S&V-4Y:28BM0\.+2U=YW^L^Gd_-dMU8)1N;US5[A.RJgA:LNdc7GWPR5
#<cQK2Z9Z]G/QQg^aN7:=>\9;V8[b?X13;T+)@7<L-Vc6F)0[@/N@A)03];eY4)&
&5L4Q_T4L81F5:=N/@21K;IA-_K>R?8b]gICI/K(2G^O(B[<(G;>Y[g?1=[;9RQQ
DR1XUaR[fU>PAXMI,NOF)V1#G9XfB9.7/b\Q>f^@P(5Tg+,2Q=4E@_8]I-6CF^=;
R2<LeK-+9S(/8O1IVXCP\ZYbKO:,&V&]D+f?GUGWNCN8e?Z;[CO/LIL\#[<d(b\]
SHNK\DTD3g;[=</:94C9d7LF]Af)EH2I+C^gOb5fTf)7X)Yg@^X1@TJ&CLC#.50\
^0CX3/;?c@MYc?aVTXN?:CX47GaENTJQH8K;;F>4)-JW.YA<Y+#g)<;Z378aBI06
@?Pa,GOA_,@L#C/LWV^#.Bd3/<,4FKe4_>N8g:1e&1[MVdHe]EYY]C\XQP)g[^4E
TXEXce.(7:fDL8KH(FFGMI99&S[XSeNbX-O<PIX=TB++WDOTRE>7d8#G/O-)8;aO
c5a_0]e,bMdS<0K6cC6d)1)VcTLFAQ<#A&AF[0EVY.L+&c\f8VZ;KB3E<^;XAM(O
#I?G1P.J;XKQVg04]V?A/WR[@WeGe1;QSE@fYUHP)4+>a:JaTQ^Ha/E,Q6,O-(:6
<D+FY:aZQ;/FYW@#L1R)M;=Z[Y3e_EgPX.,J.(;OE96_@U5N(<4NI=a,5Y?91P69
DE:7A73>+a[F1ZF[[)/0.?-UJ0R-<//1K(2.>M6gR@9,CcYFb0HTL&O\3d@2T&(_
=4&4d,LU5#>fF&7)/d:JKd/=dHCe&Wc:YP0ZZ_bZI>@3-]F_bGZ(,#MgB2SA<dR&
,;QY[U:U>bG+\&RQU#e;/gG4eN&Q/?#-@.CLU@C(B60)NbP&:b7F?_aI\OTH?(Pf
_X,^_\S/bU9-<G,EJ=B^R8;K&B8RbCJSQX84fMc_/2fGafb8F<S0SRC/\BHbdf@F
]U(J?B>C6?C-[Yb[Yg\YFV_)Z[U2e>MdZ8>724RQd<V[W42KJ//bRULQA^-K1H>c
cQ.2:dFd[;0SDN_)e<&A488GT7E=E_g@]CWH06aB.HXPI,6K]f:Jf]SWC[4LU)88
d/;-eT>H(Dg7)AbI&]0Z54?aC:NREacP5K(V>6QCP:/O-LTc=_I)P>V0,<1>9JML
@#\VHdL5R/Ja(\4T5>9O2PDfbS1Zb[HS.2df:OJ?H1)DS,.S0U1?Rf5dAg9B_;AE
U&O8I[>B#II7I5/+I5(1CM[OU6JZ3W8Fe,ZE32NgIY/:f/V#FLFW?SN5b3]:JD#[
OBaf#<^LWc3)1W4+3B]IeLV25c0AFULA_725g1,R=#b3E/?-]YNIUDe#(ZGFG6N[
M85Q9:&#9Ng<^RHa[MG4^)FNS:#?D6d93K\A(P7FB1Wa]//J@#e(M^1;WL?[MUAJ
Q&E1#;KA#Bc+A\AO/<+Mg@,eFQb3bgWY6;dPN;WVRDa2AE/&MZf1]E<<F7.>8?Q-
Y7ac&WH25f)W=&/(@I^<]gdAQ?9W]aP4:6?M9<Xba,S.S;[>D_]C1G64TfHF8^TD
dIR/O.-(D;I444Ea9=UP6=[aA-[>GZ7S2YYLT#;dgU6Q4>3(O\<gI(F6X(B39J4+
+3QFQc)#=2=E/CR3CMVa#H?-gX&0=QePd&=TCd/)dUA13+&Q#C49SD7V([W=28&(
#4SMY/8N>K1ML+^62>FZa:N4<[S8SE?QA\=UJ8N4(+FRJcJ;;gUI5>RO/=]e5?;<
-O[8<61>KQa]eXJMD\eb[^.BOg?=<d-(gAfCO@KRIaILHI_9fWc4(#-)-,cA(@I:
g@5I?FB4@Qgf/[A/D8[>O^KS1dfJDD?[F&Qb7eDY=R[0<UI0O+);13N[=;F(E#QC
Bd.]TT_TgRJV<TR9WfG48FR&bWcY,\TG1KBC+./2?HZ3.,L7LQ@eCX7/NIR)_HTS
V&0]?I3]255g[4fA\29Uf(RgRI74-Ya>-R-J\YWC:RL>4A8Cg;/b/W#;E>SO<A>,
^4TF5+=I+&/+A;>IY;TIBXSX]<[BOW0WF=MT6#.7+\f(&9ce=1>LBWH&K3fCBN9.
L7<4f\]KgIY)+LI&C4cbHZH#>H243V3IeUY4H\?/EFH:GBE]TJc1FH&c+#&=G[TQ
T7bW;UUKH<^GBeUG&[CA&E0A1BTaE+_,<)NJR#YLe-5E.UP#dd]ZJe17N[D.Zd(Q
-bAXfFG]S^+\^agMBPFVD0Lb;e-Lb3Ue;H98V1NDIW@M[GO\bE>VU^J=HS(8DN?e
Z)WZ/F+fYR>=dHL6b?U3Y-TDC4MgS]J8Uda3I/77B20GOHCV)ZU2@,_T5B7?I=O\
Z4._EBL4][O;:ZKEKHHT:dIEHQVE\5c2(PX]M8_aZ,RbGSU7Gd]9bG,A7,d&42<^
JCa<\g>,Z#_D_b<M419ZbN)gIEW&+afTQVeA2.1[PJX47Ngc)Z+J=dVY3cR#cHGO
+1c#^S0YR@;Y=ggX^f<+28-E&3<HPZ[SO_S\Tb89J=/3UJ4S]ec7G4IR#Q1fAMUP
&VIJaBL-@:\M1H<GX/\ZKM330MU9_3(Q;PYCJ(4N:B_3F9W0T1BX<NL9UF#;(S5P
;FS72Y72P?,8-T[.WBTM2Z@-Z[__O,b)?GRe(gUIG9)<UW2=.HdFAA:KMNc-F=FM
PIF+?0dD2YM8?CQ5G&4)#GN;-1QZbN;>[5fV1MVQ>DJPde]-;0:g5.\Zc2[bgb7\
=@^M>Y7cA3<,J/bW;[MV+2\Xa+@<VPS7L[EA>2caAWVI,>Bd3[#H0,0(L1#JM12[
c7804LD,CI^+b&>c_6#4L)D6[.12S>=/d5;P<B;@SQ2DQI0gYQT(dW(]^N?g4A8\
SNOgES?/dVL-ef\\353]_;2YUIGbcc^BZe+G^\-)_bf&b<?2IeE1DeSe;EY3:>Ic
BP)-GEVR2UNaXa]2c=CN:Ae>P=L[PL+)<SPZ3C2a<6ceMS#cCWL>-V^P77-,Fd#Z
cW<)fY5]9b0DaS]60Pe8gK6-,&dQIb?CEcK[I8JADd=a>DQ94P<Pe:]>\T_BR8E,
[WC]3Ng3R9Q0W\M+FL^3L@d+IQD<+C9;]_@0/B^+Ue+]Z0_S30-UNa+Z=;TAXH-\
;7IV:LX,AGC2,0?/=QNSdg@@IOZ\A0bY\HK_Y1+J4(fYaA8L>@JI1V1dbbf@B\HE
^<F>Y#@,&V;.?+7@_U6J_ULH?cT8F68>HaL_7eT(W-UY1?fO0aJJB_V:a4adSc;/
:D[1X7OBe/ES:\:b_328AU:EAJ+4,5N+-3L>DUbJDd_Q:#8..SV,[XcTJcb8--(3
(,1-f63D?dYX([aCHN;K2\XTN@U8+07J((IMVV,c::2L(TN+Y?JS[g[b6fG0f?9T
]LB-[S3W2;3)(bW.Ye(R3d6Z)3\D[#QS@KfB032cA?1A1;23/dQV<;/H?)C;KR.O
fY1K)X8Zga9:+IP2\a,=KLX3cbH<Hb<<^VLN)8_]ZBZMV3T/a[1OQZY+.)_3Oe[3
,Y]-1aQ-4:JW#XMe,1.5X[cJ1FcM^-TDad&IeDG.+6>>_6cRKa4\Dg,gF>NG[7:S
&/98#=(6S<2F16_^>+e4&?EAEJ48\6+f;K#F#-)NW->B=6X1G&CbJ8W#[/cZPO]0
eXK699-OQS^U@RG]>e485b@HNDWU(E.C/+Z/35#+9/)9?)X3Q+51+_I=@[3<aD#>
fbaFY==;UcE7V=W<1[N[5CcBC-K97-6+R69?HJLWb\O6Ua=YJ[T+D,.._:H2Af@Z
7J\b7RV+4D)K#F^2cO<T5Ma#>DT73.7+1_>QZ[afa?cBf6Y=#6TbM_P0aEf;dGC6
6]Ha,]CD8SZc\]N.U<S]93KX8+B-2(cEZAE)6dTXX3MAB8>3L&Jb;RZQ2^eDTUP)
GO1&CM.,8UUP-[U)PDgMTR4b?](K[#g/9<\2+(.EQG_M5&H]W+=c4SL?>J(<g,(f
ZDa0^1\5?>2)F\,OB9=1a\1-(D\L^J#19J-1:Ub[+gc>S4W@RAAA1XUNG9M6,aWP
a.a7.2W#,4<A&_N3Af03V1bSJMZ[3WP(LJ(A9Vg8#&]@6agNUVL)BTH4UW<Rb8e/
?S][]5#HF;(/a,NgV+U70&c>c>O)R4#eS]b&F[Ze6?J8N[XbcM?,4AQU,]F[^,J:
)HW57eKY6F?D;^8g;&cX.EQ)L,99_2c9_aQ;?:7XH#F;A/geU&];F+A9dcO8J;9=
4;\@6HCHF^<ZNda_:2DB=M#<.72d;OM?]19=F;T/]T&I.L7ObLYM=[e&d8]e#bff
L,]ZTL:;7>Bb,#Z7J4da,Q70W#94BJ.ec29(Hd8T<Q03^O-<@L)81/RENP0C6E7I
+B.8Pe4O@E>09C:KK)D0J._a,7E-Y+61JSTOM6PKf?_E#EZ&R4S&&GA,.W[E9K;[
??Nd#9][OF4Gc:_SOaOT6aG:[LREYX&B#T::de.8CQ=caea;+(aMFW@<OB_BfdF=
_+IE(NH,CZOTA)VLgMI<QGDZ0#d,)/[@d_72_T@BQe_9Kg,7N?HN3#C:Y/fa<Vf)
6R8)39A60TD=TFd((#YSV&UUW>GbD)OIa:ef=LFHf<04d]AOMfJ5_d/ERcPFGQ1C
#..Ya,J(DMN#+[5/7E6LTBHSOLWeF_,PPUf;7ZG(_<R):25<9E:Ec.5,8g.;9^/9
-g=KAOc6@#RSLJb1&:@O(T20d-66eUO\^R.eA6D3/?LQGUZWYV@:IUd=8S1gTVIg
DE2[U#+VWFFN@0]g.;8L-aXeLVKI1I,MFA63]@.;YKBA9AQA]#a+Sa2.X6g^9.R@
XeDWOIeD.8&MBfS0\SSS^(_\6PXBISWZ+DJc&V=C[N]7cc[d=A4]Z=8^JV^=(AJF
WD=G<ZUd7B_L9)>#YJ[L/T4@/2bK4K6?&>MYe0V/F+_8N;X8B;1NBfYC/Z>/>^BL
1I,:LFNS\dbQC]B;?6N+F<&QgGZ5\f@TdbYH<M_7JZ7R)W/Q@TDgQcE0a_(A3[X;
K,H4B-e:CM_TUELY.POQ>\UD)+@Ba(9Sec:HbQ\ZIXRNdWHD#Yd?DM=4(>&)M#V/
+gNe6+?>bW8Y;Xd,VD,DZQMaUH\?Qg77aDbTg0EBNT1<R:1OHGH):\C@g;<G.2,7
=3&d#^;\RK-KaH(6;:VbK?,IN1^gJd@P=T[2K18MMU\F-ZO]AR8D+4U6f2V+bC(7
/69QdIH>JE]P1[?U=OZ.KKcJA&H,,<0\gQK^7d1eY^[+P6e4\.MO\f&a\?=),<0>
.BET3I]3(?0J+fbfVIT3-f_(J>RP.MM9J7dCJf<51/W-02N\MAD]9)49/dD3.3(X
6fUPfAEe:UK,#F3:<9V1a]]6Je>BDH#AL4BB4/KX@A2\5g?_->T#dLZJVS#fKXA3
#H@&2CDXIK]+MR:TL2I\WcN#NI@07NaUb8=e&3,]&6>eV4=#d2)[dYK\bNLUcK_X
0cQO]L0U2NdSTB+4e@[K[HL<T]I)#1M\O/+d3IMA-232_6T6_,:BCb+3d<OXE]TA
O+6g)I;.9AOS]d-CG5[AOF^CgUV/>[&>=c(2P\WR>7aCU&@X+_@Fd1G0M&7(M=K2
R67AKR(;>L)2V6?@,Z;Ac6SQ@fQ[9=E>I?)_,&_bN9eIcJB7S:ZZU(+(89R/8ceH
,R#0^JN\R7,GE7G\c-GM18_eKKQc04U31g1FV/3)S9-/RVMRgdfd\:Dg6P#^-K/7
V?TTR]#SJZOBb0.<_D;:f8AUb^/_LY_\]MA(&81-bAG<NeI#;7Fcg4ZW;N,@[1I0
_0+KK<)-QD6Z]J54:G@+5)=LcB0HX)YQNA@[eSd1g.PJ=RRHO4gF2YYE^,NY5/FT
[2>FR3A^ZP=WObPcc2)X4W,8;Ya_D2;U]]9XY2CJKMd^:EMM2cIU2F77:MX4(WXW
XMe)3.B/(/Z=\5d^R)_O[:9=Z?L-R^T>?DD\^J+?N15QE[=.4K&(caB3-OR-R>Z?
ZD6Gd_+8366&IU>8SffC?eA@30UgaUJ0BcMK3(1\EJWdHIWG6WSC<IIfEW\YFc(f
G)T)B0#+X&eHGcWPR8SHG3QRH0\b)9^HZ>MN&+,.(?3/WgF4CC)@IY/T2>Y]K]b)
#L[c9(HgX3HQY\&.L(472B9\-D)V_N5&a+I&U+QT>VaYcg,17=A)U_;See#Q,<,K
Z>ISc&#MC0H+#P4fX)PQ)VVR&,;dc(/DPYZ\)?Q+QbD9@6N1b/#H-\H-HC.01BZ3
Ba^^N9<=_,_(0Z6W(?X3/6RUY&b7_3#8F#9MOJCBaU^Q+&H^-X/;=,8a]5bXQ-#O
5_a(]3gY\+P9R,Y&Se3AHUgB>>EPGY:<b.@Z\B#aM7;M_]CB?L-EA<5WQIGLC7Rb
VGJB?K0K2[XdEALH2EfJOBQ;/J^C&AX?MY]G71H:a5O0.?\7Q3:Y_02K,S)6T?9F
+\/EfbL+Gc6_=I2GgEdC#8cLCM>@9cZ(V==V,#&gY/IWX:Q:7B<OV7N\Gb5N,J@K
I>_F81a5GLE6Lf8K;#E8fcQ@b#bg]]&9D^,Z:JG:@)=6K:XUcN4)#HWB&LACYEc8
IE1^#6:GC,]+NKcgcHBT(B@Fba30A?g:0=Y.B+Mc/&=N<8X<QMS;>):9#fVKe6[_
MbeY\Z/MG9>9geJ4TC9)6LA^-S8RgeFeJfE:U,C7:K9&H>eeSba53MK(e_=QP)Y#
cM0Nb?9+K;,?3;M8B6=&a0Cf)3XDZ1UdSF<N,6e6W_Q?F;:LX004N_]M6>#QTgDf
cA?.3+L6I&Fb1EBHS[E?Z@T#cL?AKBNN[KYM:;6Yg7#4<f[IX1N0QG,-,(,.S0OK
gdP2?)T[1Vb]S><0Yb+TE>JK&#L:15<W81UPKYQa-R/=C+_7_9]+S4<R?/J_W)eF
a&63F:N6=2QC:X+?7,/MaN]UY3(feMUSWR,dQKFD.+fNT]d6XHHc7,T:0MHefa^W
O,B62DfB;\FdcY0H>0Hd0@Q[[;#-P^<HP<,Na]D3-OH9>P/YJd3NL@&R>5Q^=)],
BDN:Y46/LS_dI2]^3&4aAf4OPa>PZWQae8_I/-GG+A..C@gJb26D&&-2[P@]</>U
]MWY5D[);R9A?+6LB91b]=AP>XR#c5>YH0V#Bg;^^FeP73>d@@@I+IRN@GeW&d<^
a,R&H=S<UJ)gD6Q0U1V3a3TD92S@I,b.;@#N:W<Yd0VdK2&@MJ,O0<ObNO;7@bS+
AgREDXb34EW;e_\ZZ#JZ,dR&[1&WYJTCFXWe)KD-f-[=X?JBMY\?L:@QV2QI\Xc=
;]Rb0N2BKfVLEXV.FBBD;G=a_DeQTO&ff1fID=J[#L^SSd&J;[@EVGM3L-<\Me96
2R:bXM865U@1HC>/TV5B&cO:ZX7S+@D1WMbcR36X[Ng&e[Y\#->_[,gF)MT=a_eK
@HEBM:CP,N&\88G]+;a;]8S?-8DFBGOE?D)G.,GWX)0+:2PX\gTFXX><81J.6J:@
Se5^Z5c;HN.,4F5Wg3Ma6=,GOCKQ-,LV_bH=;I/9+02J(03cOQ?fN_CNTf+B@\@R
11J)QW:2-afS3YDM]gGMH8#?(\&B4^^FH)gaH0DR?P9@:dd;982WNZJ?/cVAX<&b
071,ZeIA.^UNSRDbgI<6W54CB0>+>T.G4OfJ.E7+/[V,_P3;FK<#+P7A57)BWfDH
cGe;eO#C][&.cfCN5->K[M(@A9g-W0bMb^&BXA;8eXYLf+O0ECD6W_\HYA<b)4]G
6;Q>V=L8@_U?>MF+Q)aMJHb&NFTH54bFTPUF;A\P=/fZQb#c:A[cH?N[V-D>0GOf
R/T;;fb1:)NMQ+[DcA<WaE=ZI.?&3KNDCY02_P<4VMe:G)ebQGCE;H?TR1MK^9BF
B>?1e4GORHQS,Y<eOKQNG^?Vca0cDLI#STXS2W4,L>E,g7&cb+_<Z7HZ@(R4gd3/
aP(J_[I[U,A2aD4J2(b7N1XT(V=0^&X99O)Ff8#Rd].GU##4/CY@3:G3.90DgSRf
6ZZPTHdE\@#&+-AP\6(b.QXT7$
`endprotected


`endif  
