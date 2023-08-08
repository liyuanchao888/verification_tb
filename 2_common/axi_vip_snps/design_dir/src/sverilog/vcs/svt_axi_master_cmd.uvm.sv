
`ifndef GUARD_SVT_AXI_MASTER_CMD_UVM_SV
`define GUARD_SVT_AXI_MASTER_CMD_UVM_SV

typedef class svt_axi_master_cmd_assistant;
typedef class svt_axi_master_vlog_cmd_sequence;

// =============================================================================
/**
 * This class is extension of the AXI Master Driver component which creates the
 * HDL CMD interface.
 */
/** @cond PRIVATE */
class svt_axi_master_cmd extends svt_axi_master;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  svt_axi_master_vlog_cmd_sequence vlog_cmd_seq;
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************


  /* Flag that indicates that the method has already been visited. */
  local bit recursed;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `uvm_component_utils(svt_axi_master_cmd)


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
  extern function new (string name, uvm_component parent);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   */
  extern virtual function void build_phase (uvm_phase phase);

  /**
   * Connect Phase
   */
  extern virtual function void connect_phase(uvm_phase phase);

  /**
   * Run Phase
   */
  extern virtual task run_phase(uvm_phase phase);

  //============================================================================
  // Methods to Support Command Interface
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Instructs the driver to create a new data object of one of the types
   * that it supports, and store that object in a command owned reference object
   * so the command code can get/set applicable properties of that data object.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' only if the
   * <b>data_class</b> argument does not specify a supported data object type).
   * @param handle Functions as a <i>return</i> value that <i>points to</i>
   * the command owned data object.
   * 
   * @param data_class Specifies the type (class name) of the new data object
   * to be created by the driver (must be a <i>supported</i> type.
   */
  extern virtual task new_data(output bit is_valid, output int handle, input string data_class);

  //----------------------------------------------------------------------------
  /**
   * Instructs the driver that the command code is done modifying the data object
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

  //----------------------------------------------------------------------------
  /**
   * Command Support:
   * When called from the command, does not return until the specified 
   * notify occurs within the model.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the
   * <b>notify_name</b> argument does not specify a notify that is
   * available for the command to use).
   * 
   * @param notify_name The name of an <i>uvm_event</i> event
   * configured in the driver, and intended to be command accessible. The
   * name should be of the form "NOTIFY_...".
   */
  extern virtual task notify_wait_for(output bit is_valid, input string notify_name);


  //----------------------------------------------------------------------------
  /**
   * Command Support:
   * Virtual method which can be overridden to supply a customized command
   * assistant.
   */
  extern virtual function svt_uvm_cmd_assistant new_cmd_assistant();
  
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Enabled for VLOG CMD user in this class. */
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::post_input_port_get() callback,
   * issued after getting a transaction from the input TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   *
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  `SVT_CMD_DROP_CALLBACK_METHOD(post_input_port_get_cb_exec,NOTIFY_CB_POST_INPUT_PORT_GET,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::pre_address_phase_started() callback,
   * issued before driving the address phase of a transaction.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_address_phase_started_cb_exec,NOTIFY_CB_PRE_ADDRESS_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::pre_write_data_phase_started() callback,
   * issued before driving a data beat of a write transaction.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_write_data_phase_started_cb_exec,NOTIFY_CB_PRE_WRITE_DATA_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::PRE_DATA_STREAM_STARTED() callback,
   * issued before driving the first transfer of a data stream transaction.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_data_stream_started_cb_exec,NOTIFY_CB_PRE_DATA_STREAM_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::post_snoop_input_port_get() callback,
   * issued after pulling a snoop transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the data descriptor object of interest.
   *
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  `SVT_CMD_DROP_CALLBACK_METHOD(post_snoop_input_port_get_cb_exec,NOTIFY_CB_POST_SNOOP_INPUT_PORT_GET,svt_axi_master_snoop_transaction,xact)
  
  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::pre_snoop_data_phase_started() callback,
   * issued before driving the snoop data phase of a transaction
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_snoop_data_phase_started_cb_exec,NOTIFY_CB_PRE_SNOOP_DATA_PHASE_STARTED,svt_axi_master_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::pre_snoop_resp_phase_started() callback,
   * issued before driving a response to a snoop transaction. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_snoop_resp_phase_started_cb_exec,NOTIFY_CB_PRE_SNOOP_RESP_PHASE_STARTED,svt_axi_master_snoop_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::pre_cache_update() callback,
   * issued before writing into the cache. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_cache_update_cb_exec,NOTIFY_CB_PRE_CACHE_UPDATE,`SVT_AXI_MASTER_TRANSACTION_TYPE,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_master_callback::post_cache_update() callback,
   * issued when there is change in the state of the cache. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(post_cache_update_cb_exec,NOTIFY_CB_POST_CACHE_UPDATE,`SVT_TRANSACTION_BASE_TYPE,xact)

endclass
/** @endcond */

`protected
RQD]B,aY(f&<O\/Y/=,\2)@6a^/ADaMILe;0@JYRf[1^?B5?2FCa.)EaG<YeD1Y=
WI53MRdLI0Qa_B;/]WDBCJ.\A]P>/>VAUWBCC=WWO09CVAK\&5P<18&TYD>5f1&[
XIS[F/DZ_E5E,MSac<CbGTYO,FJWDG#-K&W]S3U)DO>C,G+_1BYe.#>VVOe=1771
Z.b]TQa0]EEYD##OV+L^)P#5=]Qe?WG_CB-f0ccA43d6&@HTM89#VY]Q55^KZK+2
;N-ITS18PBN-#M1O=bVM<(/D@a-]H12I>$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
gMgF<5FgG4/;F?f,O)YDU<YYT9(C),L_Oe_P/b(A#5.eJ=FMI4&<6(Scf(TTRE(E
JFJR3>LaL@]Y6Q6&PHX<66,4+WX-OE0P7Mc2+KN:<.g&N1=J1-_OQe3)Qb=_c0ZH
W1HC6-M)6D@L.PNJL/F_L#5Q5Jfa4RT:VJfd.HN:=\Q^DFM.KXSTC)3-VfRJaK[S
<JEB1Wa+F^^#F3b=\E?K<U?K2Wb:<_,WE,bd6.^e<VKT?@SK:YSXd_\).K7_>N@&
bH]U>KIKV>IREP05abXNREA6M99_/:]5<08d[_:>gHMeBf8)2QE7@2WKJfO?UR0Y
>(O03<3EC3E(=OgU/U7#QWMH_.@PQPZX1a9FTVA)(#1I+&<W;W1RV)dg6C6?eYR+
g@dITN#9Q)M?e?(;8=)F&MfbO_,C.J(@OR7J;7XJg.Y_8(.][CO[D)2OIVK&;,df
g([437F[C=bRWK8XaY,EUC[YQ\,+YY6EUHEa[21]Na>BF4JI745XJW:;7d(<>gH:
D=I,[Icc[9,+H2<X4=4P&W1I3NL+/?bg+aUdLX]&]H9)LMB(0]Z:,H>e\+(4J7fd
N9e&&\\geQ;D6C+QX<bKbURcVLfI.Q[;-/&8(IEL#(0<K#.94()>Dg2R2D/_CZ5d
[&OM(H7&gfED,Gc>f56_)K7:X7DB/AYNYMG8WHY)01B2GAWD^bWVcQ=:FF=5R_VH
>]8,eV.Caf0eGWT8M[f?aR:HBVc4>dXSIgKS6Sd894]KVRd]M8<62;]C4VXA)c,_
+<@/c0dRLRBK5VBYS7;S.[7G__IV9+:-Q<G.e4K0PaN:GR99D.=.J:0-B^\6?U]_
DV0W5OEdKLJU4&d/eCd\.:c;fC9B6cXSNO06,_056?:YW-BbEeX_b?O:Q(<=\.4c
@L?=T(8KQaL&ON9;S[L\<-B,5QbM=1>;\O6Odc=>@Q<;RE4TX=L=KYZ?4.^a+.P)
U#d&^Jea8a9MKaY)OWL9JX#GN3(7B-&4EGa7M>MTY?5NeKDL@RHNRWIP3WK,BV1?
=1FFG[]^;Ra(A9[H&[bY>MT^86:DcfDZ?,@9BY?-)DTN-0=JGQ?dB]/2Z_M(4(CY
8KCN62#eRH<9EI&(I#bX_H?(gb)g2>\RcOGE/a)OKU+bcg-F#J@gWWfDA:g2Sb:\
#=JCFFYO]F:#JMSDaO-.PVfaJf43@\G),@H767KT)I36]c_-4?SZ1>(--T^\9ZW[
eCEAZ<f1DF1NRe2A@>](XR=>E4]\ebCDALBA[F;9B+]Md:;f#P\e)aD(1Jee)0LT
4/T?OF_.V+5gD;VIb8(;2<58C\7&Xe4&C&/SP_^R4c8#,BEeYT[E)_NO<OcN73FH
=4E9:@XaE=bR_N>=LbM6c+P2,#>.9(CCf>2:<(R->S;ag&ULC=>9(S:=OG3H;:+a
@E5-U//,:LJ\g[(T?:9SFd3H;A3>RV(4:@2MJ9V#80C.R^^AADb[Y:R+L928OB;a
DE(&aMT-F;b9[82e/?HJL.CRW.KIZOMI_6/H4d>H-\GCR2=9\JE#B/49REPg.f1M
TURITf<Y#-Z_-M[>:HJG\+0L]N;WNS8]U63dY6Z^UK,:JCC.GZ^)J&[Z+Ge?_,2@
a8S0S(cRQTd1SNc=J\6?:7AB8D0Z\(#R06^ZFSe\bM)fRW57\8YZ;-&MO18Q#4[?
-_F0:RaT+G>GFPHQFVWPF,DGUGNW-6D^^I7JQN-FHX>.6]2P6^FIcL_XC]TF;5&\
,W8gb0/e<XYH]UPTOKFMSUUVRFWe>(_+cAU-/3ZUSaa\#//L[Q++GOeX5BDMBB6&
(RM?2ABa.N4F+F;D+Q3f#6S1(Uc16IZ@_GLO,gF&-XB4+UHeX)9RWDH9eGB(+)#<
I[1XT68bC@\@I@K[>SBX\4:e0LE(eW(YEN)G]4:N-(D[?(feg]XS=#]4@eOaZW##
QF^RAOE?XNFJL2(+>2O[Wg5E8LR(P^BQI,e_>+E?&ZK@&@feZB9-(.b,cLSR.7V7
gHcg9HOA(bH:UR6\\EF8C@D.-XELDA,?70/5-RY2;]e.H-ID]_>>LG--M7H3]XQ5
L5M6E(#]Q:<ZeFG1>6CR:)AZVNI1Z&b4d),B+aL2;U0;BaF2UdEP.e)XLQ:dPEWb
<JUQ,fd:B=:65Rc(J9341/BY+_47UeGd</<BW?8QaU8#WO,,H2;)eX(Q;JZ99]@S
K+^gOKM=B1Lf((0,WbH=8)Rac\SGg1W5[E9&2J4:B1D3W-#:dOdRC,0]5[N)&IKe
aTJ;BU)aISc1f8I#4cD?\dXIZ0<_.I^bHAa==),(d-D5#g8dKH4]Y>K7E[57.Of/
L<KI9)@I2a0+e\:<Q+J6PLgLgPFb4:b5\D#b_7.=,H<NgY;4d3-U).YbFE,-+0X<
[8e[gKa9aU01&OQUXJgM^4H_D++&7ePW#9]&JV2Ia&71:=]?)O]/)_+^;Q;aUB;Z
H2_>=//Ae\cQ-EedBA.4C2)AfP#DI)gBYJ#&-\2_?4-X4J=/-bg/3JJ2:bEKVX=@
Y>QHWeFgY;;-(+:JK0YG,bKG>)98b]JdB0_U2(Q8H@SHLGWDQ1cCJUTF&V>Ha(eO
_LP>+6aDVg80Q).UQ[,G9]d0:QF(68(49&;6,[b/T8M<5JMa5b6Df,;gaQce3dSW
)TT@gbP4=d(B0-dWC>JS_DICTW7b&GN2cAA9LEZW6V-XOUD/\KKS(IIT_00E-C)0
?)<feD(X>g+5XBNJ3_,/T:JGBX@=KNKNdYL)9)7?Z4:(4:fY>91.VQP8.P_J:(P>
;aJ;NUee&,[&ZMf.cfC/YNcWM]2HRF5-EYZaV_a[>,;NFgLIb=>X][<1]B6>59FU
;X@fc)KWX1.6S#IOL#;3HEY,\M88AbGf(:BdHFHD]3#5e/X:JAU3f?^bG\@M7_#_
&f1IIX&(PD///75cf5,A88=JfcQYG&;:ITIRW)N3#M\Oc.:f[d[ABe?XC:eK0gO:
U3VD&W&AGVQJJN>.OaE&15I1c8g=Z];O>>CcQ0WSQNg3S_b0W/T<,X,T3ZBNY\SD
TNI]4[U^&YNU)NgB=:3H>7LVO\3:8<QMBA70I=XV+OHJ\5#bdf-6_>?,dXI9Z43[
LL&a\Z=9.,Z/8=E?U;-fGS&?Yf?3c]fX2LX2SL38[&>a1S6STG.O89:1]4K(f,4S
(ZT>7=\35U9@.#X^@Uc^RAg+>L4RQ5f]9@&HA?P,5#.;AKA7GDR^gbH=C8g_B7G_
XIg[N&(7UcV8A8+f.-3V&VMQW>NXeZ5c^E?KCZ#XL?;287(AET0BX;2R7&1HTSMb
^YH5,L/[_]T5(;^>=CT2?LF)ICTOa:Q5\IQYcA_/6=V)@</bU/DG0[239C)-(UD&
eZ5^]@#BL,G;+GM_)V5aD.2P^I>#/+WK1Sg:3fE7Ee.C(aMNVZ4<(87KKV9Z&Zc:
#\baW#VH2J]2(&)F)V^e-F;a=XYg49H(OEE>L0D>^053XA(HF9[_FI685DC7P7Td
Pc[WBZ@caQYD^+-Q)2VFac1KbQM2e)6Xf6:>M70?Da1N]3K_^IcI6V72OZRA,f4c
NZ+UD5Mb(C3.\\P<Ob4AeU:FH1\AKUc+f?VQ_2fLHKU+eca#;J+Z2G7V50+U<]2P
E/-[7<d].58:0acgDfLfB5KG_18Nd=I6LZ.Z:]35HAQg>R?)VTe#P48S,E?TS\(J
^+RZCD85X3b#f]M82AUU9g_R<6I>3RW;;Y(ZVC<_MNZMOJ7-1<YOOV/XJ]3FD3B[
A7JaHIgV;]E\0=-gRB#_PU7;eZ(44Z6D_eW_QaZPN\SE0O.Q6aW=D]#aF5VMR1Z=
H[X<7GCV>SLg6,:dM<Yb;>W-@>bd/\dIX:38E8:&PI)^-RbaTd,BWNG;=H:bO96e
0.W=C5&,F;[NN?.RENa.D4<0_R0aCS?XdAgEU],2bJ\<5:4+M:UN\OINcF@;JHIY
\V+2,>TL(ca\H@A@S98(/7dT8X7VL3@Xb7gG/,56:HICS(L1_Q=49E?7eSEM5XUQ
adS)NY[d:37O?5f:Nd,<-VMUPa(I_P5)g.WNU<A9-#_6b^KJ11BeDU&aAU^^LI<B
BYB3;E).KV7Q;a>Y/.56A=6/38\(:f.(O9<g+cEZ.49_6NPFb)R41(V=P0BM17G4
AH:T-L@_ee.]\EI:(Q9)R/?fYYc-BRF[OYG,cb+2[)S_(Mb]:,a><;FX;I\TcbfQ
[J)89;<=N^7V:CYJfT_?+/0KfS7H_BVPT9E8PQ_\be&YZD+24IYPC?fXK;ff13B;
1;;6/0<EQZ@E9/XEeg(=QcKIP]YMJD@+&DH7X9F0WWQUZNB1H46\N.,,1Q,Bb72]
2U8,19=425&P6G<FHbT+JS9b>D_EN1BbgbZN>B97^;311D.H9+DO.&-5U@dOT\L2
G3eI:M4f&M+\Z0:?Qc[@<ZKMPGBM](FbL0VT(FLBb[CV>Kb+QR@c1S^W/I6WXD5U
P0.DB[75aZ,_\EJE\;&aC/F#Y:^8<f=H]I/,/C=J,Q&R^1[F?>LT<X/PB=b87a:G
-1b;LXgMLV2F<C./.>/g]O;<4,KW/T5N]VbC^?fM][S5>f),XO&5:W?_gR9H/XQL
DM-CE;^[R(?,@F6I&<9OcIB[JK=5Ib?.:=^S>D2DSc5:7-QH5FS)>40[:Y(67L^b
>G8Ld7gE1JV4?@?SaGgF5fVIDKObd03d#K9-8^TAF704SM/-XCa5NM-Ab(PN?b-T
USY\6><ag/C+XEHJ,S6U8bE-CQP6I)(@^:>PMQB178V]K8bFTYGS_4\#2[C:^8S)
4K/N5#e5[2A?5geUf03J@K9BLe_ffV(KGdgLa+F@/-5Me@>BD)\Z0gRE98-TTERT
dF0QY1<fY=_LQQ\84a_H8dgQdXZL[VUB>_dG:R=>LIVROPR=:XaM4dTd9XZBM>ZK
>XQ3bZS5gfAGOW7Pd+HV\bF3Tg/0N^e6;)(&58cM+5=aXOA^IW#T0V=,c\&?2QG;
E-\W75fd]3DVLMNR#0M4NeB]&IYYG6\88d2+8Gd58;UA[OP)YHWRf0+-\6?2;2=,
>5=WcS\a\<+N<0PeB;dVg7],cg+F\?,&A]]D]):fDZKQ&P+&a?3>=57C;_-UIGI>
6#b3ZSY\-361Yd4EVBR-?.V^&Q=>]^,?9XRcGSZ&#Yd>WQL^g]#N^a5=-@ZZJNc7
M5^ad;VAcV+82A]&/^3ZCN38P^B];:7fcS^KKU/W=V?CEf_]NKTgQ2ZC^UI1)MJ?
?4cFNPg/[gWFNXH:P?WAO16I.T@(Uf#;4Pa#DcO9aASb8G>5(UYb3P5e[P6AQ;_/
W8b9Kd+NE;]5E[S4HI3?QfVL<G5_C#HF)&4dD6N\C[CGJ)/0[T]5VIQce=+3dN2D
3d51R2)e0MeEA67\/9TL\1<[.SHJ=1(6]V;A>ZH(dH80#7c2DVG+JbL^JGQDMe+:
]U\;74?a:2X#7V#Y-[YYCQfE+.>3V24.4\gHAUKcO_FBa?\.c,+RV-b#M^6DQDF&
M#^eMCX&CG804?::U,LHQcL>W=7@1Bf?[PR3gDc0B4fX[XO-K?Ee\Qd6>6M&WEc4
DOESR#-J<;.a@Z^c9WQ/3C\+Z(c/AceYD,I68T8,dM6LX/0P#AIZ__GRP8MF)&HR
BSA^&=XfE^HEgP@HD)AT<01=g0PWJU6+.H-^PW@?,S>[A-CEH#?3O.8-D.LSKHH0
4J&&JP#g2:Hc\TfbF>-,R418W,\D:.XX7(16.&bS>7\d@,@<6cZ4G8:5\Q44#0(=
3,CWO=(\.?W:#6dH<-\)J1fQg1aR-?#;-@?FJC;Yd8e?5Aa-MCf#e1,HdI;<_fY0
.N7E9\S^H&bfG\bb>(OLJ7>)?IfS#H#a]R.H-dL</,VLCc[JfL3g0OM?WT?)Dag<
5LB=,QMUS>\A:ZICJW#,U,P=S&a0.A)QVS9BF,84/M]SI?U0\66#HVW,?#:V++TX
./.bB@U\NP7[6g3e7>g+L0M0Gc&=46W+e\T-V2Se[X=4Gd5OPR+&;aXVNFgS&>SW
^X/Y@MU@L<CU1J6U7.&GG(Y(]Y8SYJ&OVaa9FBM4Xc)JdVGZ#Q?#5.]E[KV_X7FZ
f;0<HF3G,AZ-3U?.VAEN>)R(2aIX2&_/BI\BWb(M[V?GNUQ/c\DY]WNDI#Y:aeUV
E_@<5eNcaP=5eTV?6&=GLAUX7<R>fe\f&>PCLSP&2\W1PE3&GdVUXT^P\,f4DJUQ
TE;F/^KC];a@_dOMFbDcAJ2g6NJ1;<3gZS^R3JH-Z8NVdf?\S=4f1AP,MNRAa;G[
2[9=2NDO1VIJ<IXY.?0D.7fD)2f@@B4FL._cF?6PR[ZPU&aWNZPIR)3bZ>AZD&EP
,].X==GU9HS3egX?3d2f?(?,1_4YYG1DEeb&1+b/@<gL=/^P^/<egKa:&;A_f,3>
6cINZ]5D5_3OV>N^]C0B9SEcDE#aDD_OgY,-J^1Vcf#;cK:aA;YB^,@:Y6G&X/WR
(g9]&1A][?#6/&EK(X9#S20]O\)=[1)a5AM23\#K#F.J&G__/B2O6F&H6?C/S-J(
+P>3;&7Z5W@F::4<]2^2:a<TVKdLCSBNe1:S;T<7JJ1IP)J>U4<ULB<<7O4F6G&W
EB.=f#gCSA25.V7,\>4dJV3?JAIO<]];eTRP#Vf==J(b82NV(,]CL69cKT)g8\@:
<<NVRD1>K&aU#MBQICE=0VBFe.4<=KbVG42UVR(#SE=XLT<0H&KKDO[HBSWP7EYN
ScI=eCH/D)T[L\=G/AJU?8E:1V/K^c@^NUYXSB9NeY.&UJ5B:9;<SUJeL&_YJY48
.^CQ#eM0ACaeAF)/Y+?)e?_O?3b#BI.FDC2O540=F+<eM/J9K#bAIFM8B+4;TE],
X?F.^/V/#&YK9f/ESBEM8CZ4?OI.LXg]I.VZ>()Ec=3SMAAJEb@E,?f_^(I_;FAS
J5_AOUEa):IbH(;R2/fBM6,2>XZJ9Rg\Y)eM?g:TI+/KFYRADSZ<<HHH<?0K7A?&
R1-e-8ca8^P8?_>-@a^FUEQ:R0S_)U\@)>.>DT]+eg(#CZ7KQ+d7N_@LM=LWFPaa
FQM596?\4;E>=-MSD>.Y,<]1dTM8.G#?#BN3]f4J^^Y]S_c^Q:5ZJR#IT=dR9R+E
HHeHLTJ9c@<d;G6::6Ld4]fE,5dMSJ)W530FMbT6>NA+G37\?ZQMF;80=0-c[gda
\aAaGA1P03E[70d)<7]-fI44\7F(Z:YMFff<M&N1UF4TNZEH6C<UO]N&@49]O>@-
S(/7VB91]4Z<X>W6(;@J)=QBM(cL@/^GM.BgZ7gc<ZZ_H#NMU>Hf:#ETPD0QHI6E
7_MJT^2ddY^0^A=0Z7WZee4IF./SM>)J.HY>R7X&UR3,.fgc[cc?K^W=F0d,/GG6
CDeCeM]8593K:X;Ca,[QF6@_5,\9ad:0#A)MHe&T#RHX^T7L^2:50TCQ#c8.//g\
,_-^/]FNW;,#fCT8^MS:81bB5V5LdaGB,7=_b1[X>#F,/7PC68(9K;8O#-O@G=&E
AK)+f#6IM0JRC0X9eeV:?[1TN_A8ED.Md<,\+VX5>K@IPM[.3&K&Y]ZLB]XW&8VA
2LS8<V+)4<.3S;<?HL&[Z5Xb;>B66Ac7a36f?P,H;JGD\(YdN1U?9/^&QOB4>RLL
?0,0Z&aV@fX2d_#a)SKdPI,.?[^13;bJ[ZP_PSKf-W9LN5)A21J=a)>7J\=XGPMA
&f8gP7]Y,e2V3eSAF_(2H.Q23&>,6+MAA4BT\P:+[/M2#=+;cY#7R_(3F_@2X^Gc
R]I=;J>-ABEZa?\[R;g.S3I88>UTGI3UE]WY@H/g,Ud:E:^WFeDIVCB;9IM\6TY6
/fQ1H)68I7F.+&8/K^QG+)H>KT^a2Y_9++?U7D+@B&YSO1]0Hc>W^:69GLF5IM-\
dgE30Z&/RQ#U+L-/f(01&NAP+36B4P^Wg0N/0Fag^?RF,#RQ.YYLacVW\g#MbcH8
7ceT^]89QP3Z\4/16#Y[)fYQU^Da=NR.09X:5a0)Rg[aH.?1BDM(DU,9UVS/+a-g
d&I=FcXOEQ>BfRXJeBCA?@CFB[WRf(Z?:RaCBAY6NV.Kd#E854FIg,&c\_Yb(P]:
M[[d74PK1E;&;ER;dI?d9d#D+N4D.0@50-LD^A(D)GIK._#+R[?.d^.&H)=I]=>[
[#R2BFOB)N+dJ1C\3Z5gg,,ZYUDSb(4]e<H>O.,H_c7d0..=,S7,V<P)RI5C#6S>
S4>3_08QN0@U/aS<IXYS&(XXSaJQ5JZ:\A<d)TRVgXHJKZg_@>P0Y1&\0RbOdZ:;
.7VCXL<(_(bgZIZT+>77>BCf8/Y(C6_^Wdgb(6B6AO\(?S9#e)ecX]dHDLP<OINQ
8:6MLLYM+:64eLV-_1aE/6AOdGZ+V1VZM[g9#R_.#P+OZ_^A2S\0=@B=]PZa.9FA
DRF,_+?1GCRNcU6Y#1IHMHC,5ccU;H=Z[SIZ/G6T28I@^]g^6?8Df=Je]VS/bJSV
5eF^X:\VIg?eO;_&9;B@P9?K6XF13.-D=ce2)15@I96@2.X2.NH3EJ<a(dIfM021
FAM;&:^69K<7TfFf^Kb\Ge&>QQ+KS1L@T154@FAN96@_bLRdLbg;3?AL_8<VAUZF
+gGJgD<-L.S\IDa9.N3ga;_Q?U_^;UGU;+O/EEcef<N4&PO&Ic&3?4JGO@,8@2KZ
3WQ<LOD/YA-Sd#@bJ/d]6Ea/KJP<8D.3H]Pg_5<>Y/A3L7,2OGR&;N/\OF2OJ3<N
(d_D.[F)OD8/2NdIX;GZUg?I\8dRgL.+GO0QV)]P(:7d>5-(#8dT\Ze9gJ3_ga-f
UF[Z5BdO68DGeMP+X/VePZ;G;-+]Qc:<#N.<)592YOYd0/U^6\N@GR:V0@_8A+R<
L):97:@DNOTDYfGI&;W\&VM?;gA.E3bT5=B8O7>^d99T/0C85\LHJH-0,I1[S7@0
HK0-8Y967ZPAFaOWO1c)Z9aDI3HVF(,TX95>+U?ff#dKRS)[DWHW-(W/IbPcHGYc
^,g=[..7BIS/<a&\W@XdI^KFLd-CeU7U64#)<A1(.JP[+>-RILG3U)YdS\+NHWJF
SF59P-:^O)&20fCa2??cN0;C/Q,.II(\5/9JeCEDS9+,F)CHe+W53aRK#2+?M-b\
3J94(:3I-W1F\RDLA;B1&@-181b#<;(5W@aZG,-G2+UZR#O,18;D]0da3?Eb/+T;
aP5PRBZ)<R5C6b.4TXT,9G8EJJ&dJ[edW0/I2LP9UFJ)Ra-@UI;\FUO/U?&#1;X3
d?@D,YFC+S&KE-[=\LcOdIU#9(/HQ=a@JY_V2L<HNWD3f^2&aZACNXNe&-?>3Wf7
I-S(Udgf_^7T1[)U>GY=JF];?7Q<6QXR[G_cZNVV7K8BJ^.E3/4((cC,S9Y&\C]M
&W2B)HBY53dFe)a=);SNQ=_H2>WeOFCTB;Hb<@<d<#;;CbF\MHAdITg]KC8[#^S:
a04[WLZ1I+RS:JZ<TX9,;M(\U&SW+4BO91#@AGJ>^[3fC#O^[ad</fSWD2D3?eb)
/R6#)M/BD/W<3:B@\.M?Uc-W:7YH\G?[,G9AV-H<R5\@4<Zd:=FY;d3fOge(UW72
9I5;O)#:(EX@XMgXBIJE1LUc8&b]-:IYbd-#MSVZ8gP.FMT)6CKQ16)V^RN9:SP_
69dgcQaHXL6:IIAOdH]SOA[L&#c=\LY7W2Ac_\1H\I]H5T</CXe_HO27CgE.]XQL
d3S54TL1R/B><NG\(K9OOLaH-[67Pcd;&J)^]A4)7H=3F+fJAgH3\&6F^Q[c:8+P
SI7T8,Adaf/K7CS?GRJ6P6:8(b,JURc(?e2U4FHXdV[g;;02WaF-aYJZd?Q(+7I(
WgQD\.<B8,@?3d3f#-O?He\3Q-A?He3I8I>2L_@<g5>@Ec+dNbK2X\/]K,20.feT
0<WXG.9c-Oa[I0_G5A&b@G5Db6MLZ5P4g,8;361Y6\LT.7I(LO^&&960aKB0LAaM
,P45W#5.UPO183a9:He[c^QfPPQ_Y8F(Wg7K\2H(PYV9D+?e6CLdfO/ZDP&/N(Fe
f.S/SQH;fc0-IfY8G&YKe5cIBL&5KAZE48:0T6Wg_W8F<8P#,L]).]+^24BMMLM+
IN\)N4FMBQ8QPA<(g<P9/0>U>[M>67Pa+4=>L<7d=R/Z962A]YJX?=2CZ+WUf;7Q
\c67:>fBZ40:Q,=&_,36RV&-M0]7K7UUB]#G)7>6G9Z-QS_7&&3BO4]F7^S(Y6BQ
U5ZH/\K@]^Id/fMc6cfWFb8)F<QD=F=P6O;H./bI&>,;Qe[K3..,[a-=D::Xg>JU
f#-F)+Fg9.>;@:1K]R/VP6VA2MRIU3S41cGXU8X//A+?K[;5c6Yb.1N(^1OS:PaL
G53>BQA1:X=44_<)Kd11<RM#E4=QZg-^+7SCGS:68EG]cXcKXPS<?.F(f&:[+#/N
:VUUYEO0.CJ7cW5HCDW@Ob>2MTO]Z@QZ[U^BOeW-V#M[S:Y(CXM#7<BJ;#^BE2MU
;F8LTP5>RW+])5Y_/b7G?>JD9(_?AfGBY/R(<F:@S6(NI;XF/.,,#P1PdZ1RN.62
W^PMBdcEA/KXb5E+fRfM1/PA5V0]e=I_\W?7cO[@JW,S()@\IH@.9)Ag=E5KVGIY
.1b_@-;=Ka8QGdILOVBXdM0)@7C>Q:5KLaU?TS9W]6:/SU=&]G;W7+:RHad;AYYe
DC2C1-aM^UW>KMD?=Zgg]_@R@)?#<P?aeU4U(:W+-,7\VC62S&Y2W(bCT154&S>D
?4SJH(\KWTfA,b7K]9CSP?Y@NT90d-_1<6QB\.fAff1-[Gb@d8T@E#PCR]8cJe\V
8O:;GSAGJTQFT=9Y&QdbHFY7]:S6#^;;F/-D)[PU[Te@V@BR>SZ0\ME/S#Ka_F(<
XL02Ad1-PPPDD=#LRRADKJ)&51:Haa_()\@+f7?0&OCP9<J#.SQ3W7HLDFLSFH7.
Z6;VUH3^G\3d7WIPcc97eFR8Q/-=.M.B)f<cH/gT(1N)&ZM4TBY@)a>;MF>X)0VH
Ca9UBGO&F-#(c895>[A?N_VZG#0(C:LY^ZbJ?<-S.+/OXXbPc5_-7.;AAcGHFWfP
TZ:\>DW(1<Ve<]dP9=[0.PJ-Tc>AM^>d4Z]:URd:=3Yf_T7W3X0e55HM578A@L\O
M:VEIE0MDdY9#>[7B.N+2R?I?GQ-D8G6H?e2MBc-GK2PO:eVWSA4OPe1HY3:.=O3
)<<SX5gT__a7M5KE9EaBG@0VPZ(J93RL8,4+=A?L-VB6g21FJ<Gb+50gZ3g]&_:9
2/LFa89dSN+NAU5FQ?FU_3P5c&IZC9K^f3a)SaXT7Yb+CXSaFS(K&&&N4>-<.fT;
KW,<\E1Q>VZ8Af=C24R]VA@G\_dGP1;JB9V?=S(\g-&U>5_5O3Z)FOXccc[LG_50
F9/,d20U-HLgLPSF)F&-,Xd)__ILR_XOgQa?QF@;HRW,Sf=T&M]RLVa7EagFe5=/
RfOF<2Og,AK.EQf.=BS5Xc8e:&)gdVNG8P>MZa)1Y&DDOY.gHUfbHP\6HA:YfCKH
:Z6I\FD-IJ32:3(>Ng<PegRcW>_8O4BHMRGAVWI.MB481;Xa@/W\d3;IAO+E+\&,
02=6<3]fccSI>9^<\9#LNT=<0C<3^)E,,A6KXK\AV-aF@Kg?VJJX^ZZIQX=/aQN;
,XG<2/ARdS5NUAFc:0bSV^GM2PU(9g&L<A;9XS>4MDedfaL]FR8:;(&405_]MG9Z
;)LNg8YV6=LP8aMIfK>bKZ.5Z,J0#<CXWaXa3d-=AXV>02_=-HXH(KFa;SdF57f=
O,_HF]aC4T[RN,;&R)f#0<L,Ve[I>(?A^HYO\B4R8+7Z8)BGS6J9<gZ2YC2MaX]3
++a-3[U1&a6KP2T?:b;R5:8ZYYQ@Ma?9:VN6(P&5@ACT^Z7\MaW-be4c\A9@M76,
^?3gIYD_.G&]V&HQ?2@5(D&U:S/P5f53Y,4AFc]N>NG&FN@J7Ud8U<\f&AF9:cL3
D6^/gb3+S_G,f5]B\NFYO\>5/.[1dNeYE-X5LKO^d57009X0<EJWBPb>D#1#fDUI
-.1AICH?UO9QY:4O<,6+A5-G#LC[c^8eF@ce;.b\#PV0J[3WeF9OHUCX^I\/9MZ,
CMM2dT7bc8V5B=0FUYYRHQd1>F@aCdb2^4WTS132\PVUH&I]UDKHQbWb,MP7IY)J
IYQ2?8L(,F#V1P28E>#KO8LId4/V31+eJ8-02\Qd;1_@2aYHMG5,\<.E<[B05[/A
KQ&&0=6b9NfSUN0P#]78b6667QC/TPRE8+P4L<(XMKATZdKK\<#aHUJS7I.=?2\N
XOO0TKQHA-(2+cIYYWcY+E6=66A<1^[<5(bIM8_Qf:MTeVS><7K>X\TffeIe[&@S
H0F5+?4W+^;YaGZ&&Y4Q8EGc96N9#9F=_E>5G\d)UgQUU4&G\]()]dG2R/XYDO6I
[)4+GBPgc>^_dQ?9-ddc&NUN--YXX6Y\<CI_c<H:5cO.M&/G<,gTDKKFQ83^JO6F
B?c8[Gb:^#,87)[2)d=36Q-_b][UUc\A><KE4,+_HdEQ_34S02Z(-gYPR1<M=8Yb
GKabC+P<9U&4\:1;9[U\B\)@4DB<6&:J=eG,<5ZWZ+C18W(31.Wf@Mf?1@[\7D6d
A:W\PTL<K.;;CG25ACD)N+?)09JB@OLRc@B<_4RP=TJCc((ISH;GPS<\)DDY8C:2
?f3af[^/RK:a)X,OYKEaW6YSf(7;RJWN=^6O.,bB3\A@RbOFEN(QC+#CaY>5a8+<
^\BcP;_9>&V>1<18GU8-U6IO<JI_W5bQ7RdG.?<ATB(,HCW_NY<:<E#37KT;_(;G
WUB31:LI\eLHbadGD?C8S+]:9e]b3-aLeN0ICXbIM]J8+Z0d1MAfV5([>B]&]MLZ
<VI_Y^]1Va5X,JUG[FV-?SFcgA(0\SG]1Z)+a=)1O(6HK<1^Q/JMFgKaSPM;BdKe
?R4\UQ?Hb>I&Ob]@ECWDR+WSge5f;57@1LJ@<E8);d#]OfW^@/B^TXBF<U=DGBX\
(09I8T<)2=b&*$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_CMD_UVM_SV
