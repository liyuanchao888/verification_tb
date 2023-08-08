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

  `ovm_component_utils(svt_axi_master_monitor_cmd)

 
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
   * Run phase used here to raise an objection for hdl testcase, it will be dropped
   * in hdl testcase.
   * 
   * @param phase instance of svt_phase, which is utlized by the base class and 
   * helps in phasing.
   */
  extern virtual task run();

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs overrides the driver implementation with the VLOG CMD extension.
   */
  extern function void build();

 extern function void connect();

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
Y;gGEO&e@Db&XdDY(,,G?N1?gZ=WO=Oc]C9NXA7LN-8e3_:(</2R,)JYTfM\?E3d
,)C-/;78O9O,Ec[_a6.baB69+2[B_OfV#a.OB@>?[K6#]O()bVRe@Sa12^1FL;eK
Y52I,.?F;eQ4K)CWf(caJ,5/3_UWM30eHOEPIU.f<KZ#-\Y\QaH>SaGdE0T?OM_+
g_T9H1g2BRc8/JaNZL&)G5D@24-U&_Z1=$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
>PVG9d2@,<D1J,.?3O3X1&.<b:;bBPHCT@E)94c3Y/VN2&=cHK])2([2DXA=>IBC
2A0L@4Q;J7P]6L]--(_ANJ[B2UIBWJ7b,[?GMW-Q)AY<&2.^1\^Z.;XKNT96F6/F
)4YVfeGaCGbZaeH7EPNF-5LJ0PVLQR0>.KdWFZbOI\[@5\F5+]Z8Q&R(bd0^62]M
28U8AXWLI_eKg==S?K(?e2D3SS+5(26LH>.b\g_T(I)160\0&__@>g2=?L]_X-DW
XTZ#g^.A@[/=H^F3G6H(-H#<+I__bSLAUDPP0G@1-4+gS[ZPYU0f:TKcM\6<[_Q7
G]f&6da#4D4H#8=0DO@(faA,NJ?H@IS;?DcAbCB(/F2K-RIK10U7+]M(__S4BRSJ
+_NKM90OZAJ,]ILF^d_+OYfJM-KDF)G4)#BDP51Zg+/g2],[F^Z]dP=fY^SfKVI.
0YRa0V4764A?WHMYTZXL=(b0W\GPDZ6>c^R83IUP.TIM#V)K+^9K4)]09OY&__,@
\S@\89#G2_AJ.)GKc?<0.eZPXD-2SR>K?(;\VEeHKRLJTZ70E7CWGH.#7^LW-_-R
Z)d>a>]_[L4>-:2?4??e_GecS+DYf(_C.7JI[Yc1)\O<NI4dF;K.]845.MUgaEIA
)WKP?gI6GaTGg;9[.9b0g@]14FMGM&IPZ[4&X>.XAOGU<2>a->MS\g+[5X.8T;&-
AFY\GP(^^3MGc#THSF>4[&QQ]R<aW207Vb:EQK1LVZTVAA,QU,0g\ee6T66g^TOP
HQ]_9NE4_@@X7+YQ8g[8bUXI;L-/Q2dLI\M=;496aSc.,:A/VTbT(7GP/^GFdHU>
]CZ@#=K&7eJ/NG4S^>;-=3Z5EJ7L.G718+&SA1)5O0e<7?C^/Y])NU2SM:&V_O6D
091]OWgE=)9#e-SRQ8QM1baEK_faE23aAIX;<T#B3ZGV\_C4L:O.8_@#WE\.NI#O
RT&;-cUCGPK>K4>W^76.9S,@Tc(@cM]ePB5@/gN?(?K5Q:gYg-1NP1+US5@MecVO
3M5?H,@=DR-3_FR=8c#VJEc^fO,^\9Raa-?A?e/T0(SWJYf9MWf;9dZOJR?g3N9V
-fN^AdS8V@:+3+RI<fJ.8_P4-1Xf&#P_0_(#Cd3B[]@;?9V4(JOV:/&KPb#Y/6HA
)F;@I)#UW;S8H\Lg]26QZ0;5(GE-1+(UFf51L6G(48\HW)ERBc-I2#Z.^A_#+^NM
JT143JfO0;,GN:2gN#>MH#\N(H@^;\8KMF^f&c;6OGdbbC?LN\)Xg4H?g81RR&I?
Edb0d(O7a:5?7IN[(9g6(ff:R&K-J&bFWe^]J._/F@:S[4WB0U13&S2Q-<b]M<:f
=15BY-1SPE\S5^6P_SSY.5dggc8_G79T01(4f5aN]82K4Pe(N4.Y7J52BWB\-U#3
VKC\JeF^C_<9@V,Jc/ZCCYEE(&&3=cS5e#5Ub=Cg9Q(FDL&J<GYU_-.L223HDQ_[
)6PYeFJ3Z+7=OU:N4T.Rc6=0W1T1S<_ULJG#1-?4/[+O@VV.WY]([:@Qf_)aMW7)
G0?G@=[M]^<fBLMc7B0MPCJPBgE0g10gT:\BB]Y0/-Sa8Zg)1^fF^62C[4<(_D@Y
Z9]<.(f.?fb?U+[0Z,O:8)9SNZOHX8;R1R^^eZ1MYC3;E9R_bD3R81,OA;>c0YMe
VGDX70<BHEC(DG,)5g>&.=^eDYa]8SO8FBe2[?[-4,0XARQ28L5XG]?R4<8I)SSV
3PXZO&Pf2U/Y#OdEe:eD1^KEUb:bK_17_)<ZF2[S+4\HBTDD8@[^3T[]fTT_b&^C
JJH<]&V<:-g)1&5=SW\TCaG7=NWOJ,82K>gF.+N/EW@FH&S?eHL<KXWLgK:FRWYX
5bV/Cb7e=H-D<#+(C4Q22c:FFad4&6WK9JNZ:#@KF&_FCA5;VdS,Zf_1&UT??Q,A
f^61:g7>>EX4CZ)ZXQK,;I7BHTU<7Z2e5_P#f8ZHM,O?S6)E^5/gHH^<>d;;EE2F
@-48S0+VX[cOe7g_ZGg<eY>N_f#KUF>I/QQSea12-4<b2Q0GMFH^A<+6RI1PUX86
,R,_Y<A>MFB7CIHD:cKK)d4J>H.=JR08X?OQNf0&KNIIGT0Gf#g<P&84XH<8@H0]
2^.a3L:7Q5@=1dXT0aCEP.@,O(<APCI9<PVeZZ:RLd)Q:L3C6.g>,+CP9bL/X>Y&
5L=c6b4#:B^&,&CWI&/OO,PA[[M2-;3;2fA2>T&;LKG0g\-cT@T]XB8Zd9LVJB\U
F3/Oe;Jg&/?DU+T(ZEI9;7.DRMYN;\:@\bbQE=1_M4Q2,\;0;eIN=.CP,CE^DKb]
<-<f+(@Gf3T-P:g>2M97N.(#X=ZBd>#9NAaNVN;M+/CEY;QZe)UgHb?bgEf.1Q62
JK(M2/b_@1&>bK\[Mcf+;]XF#XZa(R(6>1^E37\PTQ)2cdKWSAOZ#YXMb]C4?cLf
0QP1NXNLO4aZ73FP+fC<1>^a240b57IE78-SQeFOO/<54]JF)F_@gb/=3bB4?g(J
_?X.5aJI#5X2@GfFfgbWa.dI/5QAfaY&2:A3^T+IDM@9&SM.[M,8#<=M])21SV.^
KO\4\e,eRG7,&OHV5-WP50Bd:O]S7D/GNTA/6bd.Vg@[]HHBY805EUagLLRB0,A2
)@W_41N))d9T5[O(d@JLQO]<A1<^aZcC#cG(P,4TA:C[>CSCABLNV18+,=OBA5+A
T#_VS32Gf-ZV2e6XRP)>SW>MM=]E-2I)\aIT][3:V:O4WMJ(B13#LSO(\WdT&@2B
:HaYS+C=9R9ZDB+)G3)8MO[aDO^d)926b5^T9.a.DNYZ5?GI,+3ADD3H#:5+4dZ&
8[cB<BLaTIG&H87FQ,MU8M+]T<OF;CJDedAP#W]g/0L4NQQO=fT86W@41@[0:LPC
>DSgAcJVXO=eR9]UHSbXbIU7?Sc/-EKfRaCaAKbNJc,TO/,Z(59d>Z(X3b?8XZ9W
F&PQZJ^V2W0R(.J;^V&<0.F?SVTPPS1M\LZBX;Y&1>E>-D-CAEJ)C)?+Xa1g8)ZQ
OECIgN,/bc;R4DU\GbP+b#406&S;c45BLfT7(&eYLc2OCMW8U]2]^4G17KQ:\WGQ
&Q[9(;eBg8Q^JU+:W0IU][EX3.#\9<3Y:5AYTBMLJ+B8O@><S?\,VK0_Z@9PP?NQ
4cPKb<IcM/Y93gO,:(B#+X&eTJL?WVa3MY>\;>9OU:g9g.P=^\-\AJ\UcJ;2U^/3
2e90AQM1E&T\NOCdVfI+H-8TX6YSO3J)[PP:5abg)7ad\(REe2^W=V19#:2JfH9T
_6gOgP&ZOYd&FA&(dc=gfK(88bWBLZ,00R0J2cBeBP/B[#2@)?/b9AEdBX0Z/ORO
K4?+aY7>:Z[@N6>_&AT8CM>BMeD6C?#D_)RJE\XZDXJ7AD4PC-:AbNIR.UMH1dD;
8-Pb?F[P)MMTGJF,VaGA\D5QY>E4D=^Q7#1@,N;e(T>9;ND\M7O8@Bb.I<SZ0#V0
c)1c2>@G;eNc1PCTDceUTUT8H)6Rg13D\;c;1TX<^T>5CQ(O>=:969KeU\eHL)Y<
05TPE@:F4X23(d71HWL5,Q_?C.]QILP5:S^+G.Y>Kg,U]SM2?^aaN]4eFLY6(7Y)
F35VUJ&_>[9+S>A\2:&b8f7J=JgBF\0<(b@AA#[[[(aVb#P?X>b2_;?77@e2;J>A
]>b8.U<c0A9C)[F[-.B=FLg]#e#M@FY_[OIGM7O/Ng\BF=L0WYE<A8TQ/R5F\QZd
5DUOd+;QYLA94Wb50-71.(Z@)J72a3IZGSFfM9@)Td[TX2-4_^g1F3>\dEI,]X6B
5+IX8F(eC6.B/X];0f/gN8]Ef@&LH=WA(U@YH8,(X/@H84YY]^[-Y8U-F+1HD\Z\
_8eLa=4:=KWc0/P8@M9^PZ#XV=gXeg+X/VZRKTP]3/TD3RT7>[#@(70[E[QfHbe0
AOD.#AZ6<:YW6:O<XIV(DFJ(&CBJaQ>USeGF1GM<QEg):H73\FS(dP-+JGG9.XGO
VY+9EeUPEWIZM,W7_aO?-J_7Vf_JBP:f0#G]<F@.#;#T,cb(NLN)]H:DGRfR?=gB
I.0L:+-4PJGGH-P\FM>=)X<6>RG9[]@R5J/,1;7BEW;dc>M\6TR;;NdNZVeT9/YC
a)RJb5]f>a5GC(+X^,)IMVB]f<?aMc<B.I9/7LHNQ6PK>GVEJTV6/a?KJN>KADSS
5c8T+W+:\AET9JAC-<Lc5WU?:<I?ZC:Ff^)OV]F]Kd5,dg(aE[\gE(_B57LG/,b6
dM8g\cC6S8+Ef8<Ff3&/dX>RbPKQA\^1V(X#QQc]^T^,V;N_R)9ffJ4W3WJ-a9Td
dU9UUU73=,IZ^5c.]_P^&\Q_VW#-+Y27)::JCO8A6(6&/c6gZ(98QWTaO1)Jd0K(
Zg_[^_3M_XUSDS[\3M8-WNB)>f7]RgQ0U#LKU8fM[X:F]WZK>;f,aEOM7RQ;DT3L
[NN.EHK.KUJ0\I\5CYPgY#CJAJ:RT?JD-P4P3#L4bbMc<U4<DZ)^[?;4T/b+C:B)
USf=3<Lb4[@I-L#D8OTSg:)G7bN?W1YTB0>cc&UVH_33P)NKM06DSOM3IJT;>9<9
<6e1a@,&BMM-aHRc[#?6aU3.&?G)BeVZK:HCX@G++HX:=CS6]-;@0g\^E1XL:<HI
<YV;Q<MR^D_:N^YFTYTYfJNUfL,AEAbB6>@;T/=edHI[:]2<D769>/3bV.UHNXQf
,(SXMW>QK2#fI&58-?G0VIKdPK62KL4b8cRVCHNWPR32C1Z0(L(?4aOAH,RHg7TG
<X/.fP_dX3-VbM4I#5UIEC+@F-..56>4cBF[7XgE?YJ0[S(cZ\8]5&eH,4XM=X/P
5TLK_4(6R_,),+AT&;AOAX48L9LOSFT;)G\,cU.]&QdZ1-AWS1DbJ;/&,JaX3?6.
+A4Zb2R=d8E4eXSd50+,dIJa\DE@[6SDY\-02LJDGN_<0dK3U-QG58BS7F#=/.JV
LBX,?_O+RD:3BST2H-e)&gCDS)aQ45;R7QY)L-a/Wb:SW+[3A-,^Q#JG,E)D&XdW
)Pe1CI^J&(5/5\ZAV.V)5-NFF#J2?eL:=BN(+MCSY000QQEQ<d]03@V,;<BURH)9
Q8eeBFB2TSVRKR[06\aW]WaI-C@(<SdeOZY2XX,P+.V<3J+V1fSbKG/004_R\;15
,,?[<81T(CRE.NEW7PCTS47a+<YUa-E/@+YBa+O^I,H)e,gUHfA_-D?Nag(F0-.5
4_+?N5dS&S,39EP-)(FZCT8)8AdAD4;IP;C3@1XW^(.4<U#dQ;F2agScZ-P_f7L/
TX2)L&5,=PMc(&.b1cS1-Y(JYVFDT8SRV0K,Zaa(\F]9A5&G2;FN:(#T34(Y8=3g
d@0.N28VHKR1=;/>6F\;FKT0B>K5F]K#)7gIaDP_K7[<4@_KbJ1C?Q-]AR:U3VZ#
#WPWE;^^0Z6\?+\>9<fDO@&WZ.B6^g>cEgA#c;GWMWZ>(5?#cge5D:-#_@X1DSDP
O=\XM\S:#;06BNZXLH5BS1XgY,PQ^WCW62GH:;S6R7J\9Gf:E5M#7Vg/)&PZFCAF
G=BHd<K<&&D/Eg7C9L6Pbea_X.I@bPX?666=X>&#)bYW.b69&V-UXc)LT\)d+)#Z
RcJ4>FKB=+BT^\=,N1H6<&TaZ;W3K-\/cD;]P7\6[F.&C00Ke09Y&<GaV:8R7WJN
@KJOc&P??eA/2IEZ?e5&9F5SY@Ze&<;OALO+YO6+@WN\S1,;ObPa.SXZ:8fcDYZX
EXG_9^UC=;,aVB:7/,USHbM:dSGI-R[[V&-:+-V)-P.b5T.<7_cd]I1gA^ZdeQN,
&LJ7g2M:g^\L[UZH:3-N^WWA(>BVD<3c9L9>_38/EJ+XYV,C<U)?JK2E<X=dBg[;
a44-FfPYWCS(^9S7.[?M3G1?1@gCBKdc@.&5VA&K>/10K8,cY8]=W#MSb+&PI-c&
NdHS=[1-(?a@Ucc:b_<I,-4SVBC\))/\A^:N(L]I:SP\bg0WC95fX54K:?-J-GCc
;K(@e&D>H,M3F#4^(U0FU[QU7]35K6f@^H3(Ad1(4G<87[Z\A_.b8WAEU5QE>S+D
.4fgW1PVN/aD&73,5=^cSYY-MJ/E=?)#A&[5?UEE5T&&KWNYR\eW-J[X\bAe3-/I
:-+I/K)30fY<5I.,Gc5_e9);IV7IMcGb./+SGcELN#FeY#Z][9P9)[6,V(H(:aW5
aCI-7b6bU<9R4&;S>-HT3_.5XJ(]Sg1LXIG#\A1C1\8AgPe/5gN7P5Y?1[bG+=?:
TR.cO\dLM(4;,>0QTeO-0;M&f#cR8]XDQfKSE(K#8T&K(]XeO-;^3SK7@<g4PXV0
MIL:g2>#UA#:Kc9]4AdecETEKI_KV?@bFZcg?02VW^,+3DJ,]=\>(/J-KMa_SMHU
/)17:7Y=TB5?7ZH:-VP3#BWAPQZ4IOG4dLQDK9>+,KS(c_Q(c0VU8/.:<:VHZ#^<
Cg1,+[_#+1C_C4d8J8YL/Ce4M3dG#Q=@f]DdQV3EN]316U:@JD3eF,:G^R@HBJW]
G<G3ERM&;C-g/H/dTW3:,VWMQNJ+cU3YZ<c1:[@9N8?ML2D5GA-XVG3]?=bT&2TH
_<,<;;I-aUUN,(/f0TLCEYQ?X2FBRd]8L4P<He0<1Wd)f8;RPB7G?OCH-J&3I-D>
YBDOEOPFRO[OW8)<.8e,(/JZKBK.D(dH7[(YP-::VB,M(YXIWEF8X=Q1@YU15F(,
S_>8_&R>K)1\[b0#1G/ed/;?2W:4UX\T07<HN1QU\HWNH3aYM=YYe/64RRLd4I,.
bgg0_MZ0?U8P.K(Q+D9.>ELgH?/43bTQW8A00JU]dW3f)Y)-+;Q8X^YdeG=<aFW7
T,6CAZNWHEJH_7YJYBJ&,fERgNfcPA:c,^Kf/g-9F[IM-48<\#B&Xe>V,E^:UV,8
SEN9L82X3G,XTU?0(D7\7+P<Db;QC,5057f?<:4#7eO^(,Y_Z&BNgPISQUbMIg0,
TZ+,5Gdca<0DA9=7K8@g15&/HbOMgdI2[&C[af7A+?bXF(0F\1-B5\agW5M-=:[4
4A?a[J9+8#&7FI0X]8.U4c@GU_MT#HVG;D@LD&+]=VJ.D7@L1UH[PY[A[f2CY-N@
@[3[VcN1[-YgU[#egEGT?BY_2eB9+b)L/VHHeYRO0Fc_bU30G#BYKJG<JE4fgBL0
UX=5BEJ<M&F.76//fNFUf2\Rb^.ECB1BBD626.?D<<3GWeJDT&>D/]_R09U?gEM,
3dceE9>SO?b:Ad3c>RV2#(F/V+<g+AE4_E;CWaE-5<>I/^d6_B<WXd9e-87/:VcM
W=eMXA2-E8;bPbP)9MA6ZdPUaENc7L7C<9&M5F^/<cD(DJ1X&SV^JHY/GfLN.QI(
V4be3b_e8>OQK17+EC2AS+3U-4U\BdK3b28^-Ab?/8O389,[e_?3^YO2R+.2R/RV
f,f9K:8_;8b.9DOPc/Q2OU8-1V/QN0ZP;92Y]HO12IIC,1LHW\ffN=F#:c7bLY)T
_&@9c5Y;[0+J],WVBQ+J]cDH#J@U==e#5gFd.19AZa_>3U.H);P&OFXJRF6,Z,KJ
;VL3cG#:\Rc[)UZHEdMUI2^;Y,@7bOPN7C:0fN&XRgL3eBN&e8EQR,>[\d#6d,RP
d:2ef8\OJ7eM=>(<W2CJU&/X9)F/.^RP2Q[1N#bIUEA60dWM7\=/B@>LMfZ&YX5(
UHKe0?W;b&?bAC]FaF9fc,00K9Ua[:452gO-Pe,;YIVGN0[CCBM)ZVCUY70@XNT\
a,UTT+@Rc&Ra:5eTd,K8dUIfe8GMG.gYZ-Egc2>MRU_:SAJIXWXVbaGE-7ed,6TJ
2f8[SgFQd2_;-Md^KG(,[&0:#CX\8NT(CSO]C8b2MCd1a2d54;W]8dbfF2F.;V8E
@SMP[26O/>JUSK&2U+d&KM0=97\:PQ1CP#10,&R/UN65T(@S=2WM6c]A92ea&35C
cYAAPg0SN(G<&:OJCf?b/8+74#OV@JaD?2OZZ?6aS,UO&BdXAF7fP[P3:[(6>648
]:@gD@^84c+X06H1,--XeX)A]@U5-5KC9bY^8]9Y5dYb[dQff,&;TM[VS2IFFR[U
8T4e2]dW2CKcPd76P5>M)aO+dfP#/XALS5JU).0:QP\OX05OS/BEPR2B&)7OK-J^
D1W4N5)0^SdI&IRL=D8?fZA#A]1OP^_BLR0-G0@WF7S5/Z)YDB@[P(D1ZJG6,bVT
SP@a.Ubf?&CUF7:&>9g2V=APS[6b,a8I_DTYH_8R(cO4c.Oc7QDGOP]acJPYC=PI
CQg&1<MY)5Fa9L.7])C#X00WP;XR[\JEM8c2C4\(K(Z&&JGDRgB[4OTA#,^=;S=C
\<ONTa+Cb70:-94-8,)IN+gJRgYFH&a@^S6VJ0<FEDXK8Xe+e)>V)F2Q==>GX/9>
D.@@(&GSc37I+712[^_4/BX?P@O276P.C:HBSAJE[WW5=,KFc]1][7XEcR=I;;=Y
4?UHOJa&X0b8KP@QDX+Cc(FWNe/eS?=g]\@6MJ&P)X5/:@D4C/4:I#02aO7?-#C2
eENfDaGGHd#71V7T>S12OLP.c#9=?^:;Ea7>_OW@CY7R#M>&F]6I8GMbCE@McK5C
-L58OZPOR/HZKQ1eTf/c0HXc-U[+E@T)+?G5d(#fB0Hce]3;(T^>\?L83I[B3(D&
:<L\>->c:-Y/0C8WdA+RH#RG8=Y8]^6,BM^\2SA/=T\M-f1>CE5HR^O4c:#JO[2;
C8-PT1g5Ib6-W<7Cg7gE0Ca<UOFGQ4_5ANUW;Y#Bg:NIV8BZ@6]CJ=7B:eM&aG,/
;?F+e-/B-W9&Y>.cZT_VX5\Q((D61^;&+17H5LE_Z7fcU7/.cO:A+f5T49GYP1?Z
aV/?DGR#_;GD[M&@:bYb&K_)eg)\O=CUa;G(D&AcV]V=+=K)JXJ&+-4SYKN92J^g
?a3W-V86dO^.&/,WU02>DEF,]:0X,c#XU.>fgDDR(:^;K&Z.9P=gaX>-1MI6;e#0
fcM8?6.;N123bYMEYBOZ]+X4Tb)GF[0#GH.##-?[XAXAJ1NGEMbfHfJG?MC.JO=Q
43]F/1Q6\44eJZ\86?Q6>N;E4V(0+>42M8R;6F.a(_eVWGE+_BN1&6<J2#7H&D#V
7VK^eKf98CL6Pg_cOT,(FL&2PO@\,(c74;8E,9?C8M>XPNKEDS4X>8DE&@/+?QfG
&-P>L7EUISW4]J>G8954_,GIfaB5>LGPVVR?:@fe)ILR5T>B/;<I.LT@\4=Hc[63
56-BMUVS\-)D;g(K8;&G[I2+b6EdQGAEeaE@.bY&;_I81Wc6]FFABKF__Y):?Ob_
@O(T_e^JPWV_#7QM>7/_]KabZ/^ZG._8Uc^>;^YOB@??B\D0Q?AE[9FU,-2/\<>a
#:HWIMMC5cNb:_eS.D]5Je[O.O:6Ue_.+IfR[?[WWTYXP5.Fd7Z2H]LC=34EA),1
-cg88HZA#bT;^4W#eL&B=;eL?#ab(g^-4?]0dGg44_a2<>8ZPUdNfBH2IEQTa4Z<
MQ>P/<)05]MeVN72CEV+7)AF;4@_Bf.cJ7-\QPMK=4\UNJR_V2R[eB-5(9:SB?bb
\NMCBIL46Ob&a7+FfA45\-#I\@N3I7ATaOaP4Dg/JB7?#e\+:YcA_f]M;66TM?@/
gGAGT?W[0f9@OJ;(W[Dfgd(\ZLRD6O1gPV(HR]:/@5+/SC5HU-M#</<UR9NH>b.R
-4Z39<NU4X4G1W=,8:d)19A96d;B#[]1Ag65Y,.N[&9Ie],LF1<M.3VQON7X)C@C
5<.VTLB.OK3TLJ>@D;H9/>Q2+bDXKSKA8ID50@_#-a/#I:8G.NW/9^=B2?V(7/3G
f6Q6Z@6-M,+UR5;9aYSMTM3)3AFYR#;bC\G(PQd3Le9R>VAa>dgc7B7@9&)E1EXQ
[Z0()Z9b/@b/_=/OSgfX0U\=W_?<JbK8_fEY#7PDA3(4P5N@E(G<[.&)75cc9&.V
1e,VL@XPAA9O(J<SAYO6Ya)6^268Y,Xfd9NP_GOEMZ(MedNd+7X0EJC(:LOSad>C
c]\1EF3->aYc>(>O^P8E)IC.D@(Oec]:7S6Y23P[&AAaR5Y^T2b<40XB]d#2IQOU
/7T[YTT1bU9P=HKN<S2,:P+VW#9A7B.K^EPAKZbW,d&#/P_UZTV9[f8CQB/g+6.O
O);B\FBB,[VYg(TF74.@5_O2L\UW:9\:b<&ER;2UPW8gQI/JCJNH)+6(PA41+S<5
K0cM#@&Lg6a-gUNLZa__@2E)VJ=P_3/V5WI8_d7,0A3;P5;d4A?&]:RS<9F\-?HD
[<U3:&7,g+CG:XLgZH&K8UJ68IA2;@##Y=SC+fdMI+M_BSfH5KOWK64cD>U&9W)T
DP4/IfMOQQT#3X8E)4)+,c0]TGP;+(D).V@LaB6XSJBCDc?d_O8[^78;+&C/d(/H
C6,<fc8C^#1](.=RJ#:>(McXeB5M0J2D#]UA_GQeI]SLf;cLHfZ0Fc#6B6Df6(2/
3X?E5AfIZ5.7OA@cJ:dgf?4;[//297P7aN0Z=_L5.;<D5\K\/-K:c\Xg(f]HI(W(
3@-L?X&^RC>S>&?W4&[6,?TA0Y:LKGQQGSdV^2K#=fMIEKS+#d>Y\)69f0;)TT\R
5M/S#L;TPSSTJ7:97I3,\fPX^C(F^f3L[XZcT0KO)5_H4+2b?0F,0^I8gEHT10IF
3AM.Q<Ib&4&KAa>X9\aH(E&,cXQ82Rb?7U3/+AD@[Z:.6O9d]Pc/:7LZcfOOOGc[
ZN\FS#-?@_58)<-.G(>^Ra]55<4_fKDNFB3\#76b3>+#JV#JA-NbdW=,,4@+;8C5
E]-c90V4F&N\P_[LGCQ_2RZA(JbHP\NFUM5(HaXGEX.a.A)D;6T+-L.:X]V>:TW3
C>:YdQB0dF,G&TP>>.G7R,V-9;GX^8>(c4&.YI@8=D?TB.aDa63.2:1SYcE;FIHc
dJUVSa8I?/@)MRO9;>W=e,G6:+C41AZL2+#Cd-8If@/DeD0B5A@JL8G@K^Yb@;b\
ZSQPf-,a82bF6f^HR-R9HcSQ/54<V,]&cY?/RP2ZZ-YP68X0cS(SXN6Cc:9OeL14
BVV/fc578=Z\Ve^).WL@Ng:ICDJ697Z\Ag53D-WY]8;Ed/37aC.Vb-SA-V@3c<S8
fP<0:\RM<Z05>6RF]Og82;EN5aI]97OT[QT+19V,LN&FgcIdVVHZXg_7J?[TUCb:
#/_Q5KGcLdC74b0U#>1&[N3]GcSL[.78&B#9c,G[8^9>B&F7NC7E/5510e]UD0U<
)S@X1#QCMSSe>:Y]K/^=Q03cF>gb=??F:RK&;K&XL\8VG1]4EN>-EQD<X=g<3/]2
G5NV4a,a4MYGKeWO(1WGW2C:5H=C\X+;U5KNU@O,bU&d:-L=5Q2,AWQ0N)cCU)23
H604X4bBe^,MW7#&_dYAN2GS+23R8SagbP#1HOLQd__NAe5><11S?[(,N1#96WL_
I;0+^4gRA2QM(JK;@GC2JU8\Y5G/YaTLABd/W#31>9VI_8O1L:gNUO^FT[69b)QH
WN/C-d+J[J815VIRdQ1Cf9,N3>e@]#0+GNgP?(Y/WH,97e07TZZF5J-1g?KH(+f9
M1.c,-IQ#a]DG8ZOC;I.@S-9/T3@E>RJRGC:;19?:@\(QRX7NRZe>fUEf<;,GEHF
U4SZKIU>QQ].3G><dfFJD62KE+c5U0WKFL5+7[3(aDI7K,@I7CIa,_B<6eKI#U6)
?R#Mf4,[7N\-XA,8/3<A;CHJ2VC?:0d)WHf-PC=R/M_1M+M9[>P;a<EVXL@2:AfG
ZH&)G5G^68?+4:,JYZZLV@^M.BdI=^MSP-H9J70X0(S+9I;(6FK8V[fDMB(M^,WN
;dNS=3KKE]OCW(e/,^SWL6(7]aPT#=95T[5K)F5c.MaEN4Q9/K3Tf(6C<b(>QQ&0
1F7XS^c7cAU+X0W5bU90#2YF_N?P,J6aNO>.(<<0X@+.,5,]V.DQC?c7d0B#[S9Y
]a(9:1(0N?5]S74T\7#cC]ZcR69&=6(4#Q]/IP->@&eXTJUF,:dEN#I<D)Ta90>P
Y,Q8\OBbAZ_^9SFH)_96&;-Q@7CJ&K)PM-SXY,INUU2&EAU<c47VHbA\]NAdDbgC
.WbXd&0Z62Z&QdD)Ga.BOMg\&765-gIU:2IKY)JWN:WL\H-IX@L7E:[E9:RX;)_T
3JAXG/20g+EF].,A0a9=[SB<LbZ+V<dd9-#g=4JSNXI,G20@ISN6)47^/(:c&WQ1
HWb73D/2\ZUQVWIZ]KQW;S[CDP.f]V.?7bWc-ce(UOUe^0]ZfG\JMP?5g1G8d)3W
^?/dgd+<DQdU->TNgK5e)(=/WFe7NQ[8]\7(JA9Q\acBK?9I2f]F8+&6C]+_=E-.
F7SJ=Z2bA_aP_F(<P<e5S/<M&D?-71V+[N\ZY=EZE@@VZW=(JL7LY6]^bN(?VJ0&
0DMQeVBQ+T\D2(J&CR2&U5,[8CCR7bD-aZ]K6RH:UUI\IMIHFW(;TgGN@GS6Bf^&
I)9c)VTWcd:D4=Fe6AVd,92OJ4SM+K)K4=O?fT(HT1D=8>aA8B(Z)5XS0Rd;N#_N
&F6?BINZccN-9^[2eF2RN\XK<QDa(UT=5UZIV<T]<eA1.eQOY.Gc;6DVOKQ8XU7^
3N-S;&SK-Ld.f2]KdE?gL@OX^X-SJb4<2[b;\B6NLZ)SHL@G;V;0N)M@GL+Z;07>
ZL9NHdO(&VQX&N\U0cDTdX>@TP<.]@d6M.Dgf]XA6bY=(e6@Z>f^S[LD+RT?M-Da
-OOe[N4>:YM:0&6MXE#Y\N_>\dGP2\e[,UWeK7/+.Y,\_80O>6_cgIMM44.=R]:B
Z(WEWB47(.);&JdRZE>THb/;9d4<c#fYf:0VGbG]aHa.Y^=JWWOT<)>H.T#e#_e5
?4R@IRf.dGJ>YUOID];T6.H&_VQd/B<9IA#3<dLR-e_7XI:/>94#Gf:><CT0A^10
YgI:<VU]JBGW9aFNf^UP#OTXaYAAHPCcg=M+)=0bd>[bEd9<12BI4SU\Rf36RW5X
Z=DSV2HR]3c0UB)X?g+\&L3WP+_I=F1a86NFY4eSY\QZ@Q<TcXKA(ZZdE.)@-=X)
G_CF)MfV16:0OXI75ScgYb/NeGZFAPXR,BF&9[MdZ<.A:60f20=?E+S-VbB72]WP
3PfPY<f8UK.8ZM.Ia9(d<U]OJa7=F)B<H:f(&GZbOL0QK0bOEJ/N5W;X,\R8:42G
(PeCTP=C7aUKN23gN?YdCUXWL],\RGX5T@[M>aG2\VTTC0gg?fKO/HMf(+P#&D:I
SDP#61g(\f;?Q6]ZKfM?-a<?@?7^/cSE\Q6)1GcP.JPagb/PcQ.0R,#KfA/M(T1K
I)/e9,d1=#CU8>.8eBLeJJOSKO?::KCa#eM,L;=DNb?_L<ETZa/YfZW@H9U18C5Z
^+CT8HS-,:5K-SURWM0b^ZY_aR+d/deC[J;)L(F\CHa?W\-]W9D]KJ1:HJX8@X+M
8Z2;-&XXO91QB13<aUY.UT+_L&AABXbKL_M.[(6.=TGXfZ-101X3BFE8AKX]dE0.
b4TUKO:=df?#>Q\JM/H=+49;VcBcY,WE]-=W&bIaAY>5_--]=U6CY>V>8]:-P8#2
#AF6S3Ae/\gPf^1+_?98^8WU-[F0-9_H_>8&aPgUTQ-7EAWVCI3A^+QZ?KOY]N1a
eW)X<\HX#W;7H]AVaPL&VF/2I>bgYe6QS09N6U&,<Y(_NG7(IK7N#RDCYU8TY<BA
ff>;IMQLY^b@dG[B=;1a:LT>5L@Y@4V0U4S6^aSUO_.UL#+g;8BC/:.>f.F,EPcS
,^cXG.=<C]^4Df1/HW)gbG>W?eU-.M2/@N:I[Rd)O+Na?[(IQ8Y=e.3R7E]=Y,d)
2PfHEQbLR9,-FJ0QL\g]AV#=#4E0L\/g\TY@U+-1C;VaD$
`endprotected


`endif  
