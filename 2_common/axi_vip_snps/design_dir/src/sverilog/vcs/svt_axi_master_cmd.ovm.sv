
`ifndef GUARD_SVT_AXI_MASTER_CMD_OVM_SV
`define GUARD_SVT_AXI_MASTER_CMD_OVM_SV

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

  `ovm_component_utils(svt_axi_master_cmd)


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
  extern function new (string name, ovm_component parent);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   */
  extern virtual function void build();

  /**
   * Connect Phase
   */
  extern virtual function void connect();

  /**
   * Run Phase
   */
  extern virtual task run();

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
   * @param notify_name The name of an <i>ovm_event</i> event
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
  extern virtual function svt_ovm_cmd_assistant new_cmd_assistant();
  
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
  `SVT_CMD_BASIC_CALLBACK_METHOD(post_cache_update_cb_exec,NOTIFY_CB_POST_CACHE_UPDATE,`SVT_TRANSACTION_BASE_TYPE, xact)

endclass
/** @endcond */

`protected
?>&N/,364U].OMJ:UD=W/Kc,:#4.<5g9NN&.YWMT;fB:OI6@EebU7)&.D[ECZJ)>
?;H2&:=+OL_,DRHJ<)9+8-</(8IPH,J72bVI6&88#NfGPABHc=]I^->I&X#eI<M4
-J(PK2CKH[69]Mb1B8159.D@Z[f9R6X@4YT0126?-+<5.PfLNW[^=EV/ER3/]@\C
2^7/7UZM^)e<NHY),CILI#:Q&MRN(aVb>1AI.b+1M,?U-WK=&7&0_Z=6[aY&@P\#
+EX3A64e@.A>]J;11BQdH\[Z=QW],KaK>$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
Z<L#WPB\[0=J>+A.VW?MJ>XWUa25.GS6ELFTGg(S2>_G@HQ<A\g])(:QMg)(gL?V
,E8Z(RXNgc6_XaaA)KH(Lg_S^T((&^>-Yg:AF/X(5A,P@G=L1=_G)14P=-BJK,ZU
KHZ.4IMDJ)I6Y;I30f/D]SS-TWW1caV-16NSIg84<VK#H2Q,XF:EIEeY(-&6K#5_
W[XP0d-R0NN&<>Y535O9BNefL5LQ]E0H>VaRH8,,PYC]gI<R^BHG,M=EMZHVV1Lf
Q16=[W9gT2#LD>9P.G&9=^<g,+fTba\0MRU7Q#N(0N[[];_E&4-RN9C\8>6.#gcg
T(C\DY;c_#(U<C]#1FH=^(fKAKG]+ce+aOA#bS(@FFNIX)M^M^V/P;2Q4a7ASSbF
ZA(.g(dI2L:Lc)I)/\8I(/8[E:Uc6UXG5I/1OMc]#?S_2WbR,)(^4<12\2(<g#@d
@A,CV9[8\C[MC:SX@EFA\e\[+E\&B_&+2Q,UZB2(+&OF^4(#aPE=I)+7K:RM^-P)
@c\)U#?.ND:,L@dS0:dXIUG,=YYBa?V:UVF7N.1IER?eTL5b2I;S=PZ64G.A+eg&
I^\^Y^_@]1M5E=LHPFZ./RP0>I)8f3-A(9H.,:,\TGEV;Rga=A2&^;,1OU8+@Z4?
2fBgg.MR,>6M7S+YKE/^Jf0+N47<e00=P>aGSR[F-d9^bSgb\S_M&Pg93#9ZcNS3
d?6;#4:0B7#+0A:TdOJD.69Zd4#[=>d[^FdY2ZPH\70Kfg)M\G@gY4663Ab+]F#Y
2Q4>LeH\a>->?Y0dPRUUdB[2U31@D(_Z<AfOED\5cAaX5<d0IVbWDPNI0dL?a5gH
#S.Oc2ZAEGV(M#68X72]Z>Q4B4G-f:a<Rf;C^XgVULJE:JOW?C8&7TQgGf@d/KJ6
LZKdSUU^[Q9FP:;fL[KL@Q2eeX(Xc5ae9URaXLB:5_T?aH_Z9bL^1XE@F-SgeW)+
]NQ-=RS+1@E+=7Cg/,)ZMP[<I2C.:O;NR.<H(+Q[M?Pd:UX]0f1#-I,+Jc&U59V9
c0]SeFUaH7Ug3UID]AROAZS\cYF4>>6JH<2B/OUV2,LA[COJY:JT;WL=<>g=e+9#
KcQ)e7fQMO87OQHIBDQ(].],XJ@N/4[]g,WGM@8G97,SYa=Jgc->OXS=XER2]E/4
^J9AGT?Ba94eA2)Y_d]ND=C+=X?M1E46MHI&S][D)eaZ3,BBKY7KD;d(44P<ML>K
(^TB7YH0<09g<bM>)ee#R=QZ<>]c/-e7-=YX4[3+_(d?=(<^K<K<+O\)JPg972E)
XT>22NG3QD@ZgRY;Vc7YaS[>(Z2VL^V[C<]7/bA2E\YcO?F@LTMc1a8UbF/YSLJC
ID147_:H<7PYRZKg+W2.?+1&f6?1E;T3Z1>e)_0+KH;bfRFM&]5/bgSWf\NRBd#A
D5K<BX[]&fBU>HK&K=9f:Oe&Z_T,D.KN(BMG7N++E7T\\,K4)fFK4g02^bgCbT07
7&ZT@^RJ4f3g^eG\FXf89SdHgW&6[UMWOK=)LX\XB&OH[I1T4SgB?1?_EUTSSV^4
D1)d<\e]WMRQMNfPQAa4<4^G,_CED#Q2.c)cGM<K0Dg?aW@XJZ.1cW3&K:ec6C&c
\TcH36X=BD.S;?a3G^0PE\P,fV<K2\W<,ICL#c@HL&,F</S5fN<ESFRB]R>+0)e9
JR?#(5+0,.\XYYH2/B8BCLC]K>4VJ8^-=7b]_S2eH8G<VY9&U1LbU3:eMJLQ;P6J
N#_#]Z5>]fbBA=:1(9QQ<<7a5:a-<C0:]TBa0._2H&egPI+012.]OKT0^J^]+DDC
[H+X4NA\T[<47.#_.d05U/>MY\-BLF7W,fW:9D:6BTXIZMV[7Y@Ac7]Y?9e,W?S/
5#</+1;D+?3<[?S+U&K8OPJT2D<X?1BD=NUHUDUg99g/R9dK?+JbIMX#/5VRT)fP
1bd;6EYG/RDM7X9U>RQ]HBP\fKbG0(W^dMJ&Z?Q/<7.QcRI@W\_ZMAd@J25C&KY@
8F@G,?PMPZ[2d>5SZK?BMH(ZIF[c^XPM;/H1&He.)e(f3#GI/-RON49eO;1[CIH,
&<;KfBBLB,g7AYA=PG@:17_]^\Kd=/_D6=#>C78&O]cB0#BZW9+fcR^(@LB7d]_]
1)[#R?F6eIff\]EA&-SGLS76)ZNa@(Seb;R(:=?=./:O05P>D._[Of3^d2OG>9:[
0P@V)P_cf@V-I+c.P-#/&TU]XH/dN[1/)&b4eA?YU]V^,64??R)L[0H,_3TR.-XY
=gBbN^MSX[A+#M/VG:cMGf+,M(9I6fIeU[>1\V\\=<L5I[TTSKIGfR9#D,3]:>3C
Vd]]<JFZ:^Q2;R90ETW?K2Yd?.XS5^FG:1:1fMKVBPZ,9UK4M.?EZ_H3?Qe;Rc59
XVfEAWYJF9X/UdTNCJV?I;T+5ZQXWRaZ;S);UN@;c.YD.I?6JN&]JXPJL.>B?f(Z
SGWWQY]5b>BP.gL#CI/#gV6?16Z0L?G0TJCX4Ef3dMK;T@bf)-,fKO/1?=4JU:aa
J\40gAT:+9(;J7RFQFdc10URRdN#,^GZUVaZ^dD#e_-DD(F;-]#P.[YKdBe@)8cb
:;d54)@,\c-)98Hg4RC<d+38]4FG#Fbg46gFAQC,;H1;(BO1/^9E]Y62LTVa)P>/
Z#O5^[a64-()[e_[VEUdgULI2NBQ+[R\fWY0W:1:76d54@<#W\1)OFD33R5DN);W
<W/-N.<>8&-Q_@+9UC8@>eL_KeSJ>L>V&bQF1e<9K:cJDQG[0>PF^OFEF9^>c,KU
8)^LDZ2RDeDg[C#R^);<Td2JbK0,)KQ@9T9XGgVK&)DN74JHTLQ,D97a:-2WM5I^
802:-WW_9f3@,OeTSM1\0a9@-2d)(4(.CAS0c9Z1MN>@/1-(YR@N#f_1FUD3cN.@
J;C1KY/d:YHD=H&4PBUO1aMc3>R8Z&[_WSKPGB,fDGP1)&30L2HY[7NdZ6=(BR28
M(_.)LC78DS#6YBb&RL&X-6WgA#^3dT+)0X^F5X(3/8Q?UY8HTJV=JfALOC=B@SP
#^1/O7LDQa7V,>dMW/L(NTUJRdWE\9J5W+D/b1_B_#Kf^</<;O&<O-G=R^,ga_MP
>9>gQ+EP#[ae#::2df]_J1f3J,3fdbE?C<9<d@@G]FTP:>^UF@^d+Y+@eXOA.T^P
QSG#7O/7a\EOUEIf<0D/d8\CVUQ.5H/g8[,e/8-&ZSFA:eJOZE:N&2U8I:NaCRZI
.[)g.9_Z8ZVGS>f._+eJG15QCM9-YP?OSgeASQ#\bOLI<Y2YE\J4.g8[@KR1YM1]
/GeBB[M6V5X0F^JPOB_aJOeO)T5S^SPH#UZdIJL)S/DU1#^[aJGB3SdDLLC:+#+<
/?7D;c>G>BLC(L=c5OY>N=73RY,+/(<D/_:[fZFH@CAVO@,1TPVC,MLG<;A,@>(-
3-@YU&+)gVc=+4E(?a^@W<]A661F/)5TP9NJ,1^8g-TVAGY(:]6M=T4.&EYe;<UJ
P^&a_WH>ITUXYYC;-_>0GK4+48-GbX9_DS&BRP(@X_.SR0WO7@8HYCHUWNIFTAB@
@5B]P[RN#g7Y:@1ea8JJ3,3OQ1d2QS3_=Q,NVOe_b=8?X0ceeKH/FfdcK\/BW0L[
_=6OI4@aBV=+NX5b44aG=M#.BG,CDBDM(89g.N4a3-)]H5&4W-f68TVFF)M5++2C
I^.XeM^=MVBS<@3Rg?>5TgYER74>@QLbf6<</FR2#\TMZ8dA#;[3QOTbbXD3(&d&
Kb#)L#K8U_D)EO&^Y<_9FXNCI0<WH(9(WC@Ed3I;A(2V&4/Ob>:Q^X6?0+GJe<(+
G>+]IH,F>O^9\\64HK?&/cUa,F4AFEbEF=9&.>dB\BF;Xg-0O6U=OZ2,WFR:F3]4
>UIG\X=_93gW/0>\,M<>O=.LZ7VPH^:=@T[:De7Dd=Nb=cC_JKEL<0_78P_AbHG3
,\KfIcN/=?+0>4[@FV]dVd\;_A@2LK(DaJS8U7M)aFZ;O[)DeF:P3@R7<N\<Le2X
_>H=OeDc&TJTP?^f??-&7LVb1Z>.0S2g3aGb:Z([^7fNO=J9SKgFK3>PXT/WV.8H
1VE,_#VA^EL6V1.HQR2/1S9S5OT4\WFM;@YS7(J__TD8(MK>aNJD6.8<ObMb,NI2
fB2HRgfP#=_G1_DM&76RGF/\L^8aJ.HG32L/G,C1e(C[H@Q+CWMGbHQe,f,AYdQ(
=f#-ZL2CN5:Z)L_[Yb8YYdcFX9dLe3SZ2JDZ:WBeVZC4.>A,J@f/<-:0@#4V_W5\
C.0BL?_fH]@:IR6T_7QDAMQGPP3c;cKCc,=EK][/1T9AF45STF(U?K0a(Z(W-:/&
2<ZVdGSJ,].2=7\-9H,>N:QDB@3JTLQZaNKUbZ5f(C;9Cf/&._L3LF-QC+7ZR7dT
9>e95/e+@K[PROea9eg/L/3[WVDFP79fC065eg;QS)5,;M1fgeReHcMTJO_0UU3P
VNJ-XbbIc4J/3&FK,D-@3XYA_7=]N<cDR7YB8ZTHV1[aPF31NIVGD+_PDM7/7fI;
+C/^M8f.O9?1@<9gM-UB:/c#KB6)[(:Qf1bF\13Q37V[DWE[YZB:)E0@W[XFW=d#
640XC#0<<8Z(JQR^OIe+G]gf&GMWRR[30,c_VDLCSY>aH[,KM5YS2C:AUUP1Y9.R
3T.UKHT2&YAD3XQARLg+5(Q)JaaE;G)P94;4bMY5IF>T76E612J+Dc+8+^B[65f8
MN],5SNWQY_b<=MG<F&4f_M,&&AR\9O0AREP-W^[K6&fWO-&513)87BY6a-E?N4e
/BRIAcK:\F>ZXNN2V(ZDG-+O3<cY=Of97HF9A.bPc5OEW<KH.0IZQ2#5f0]W+]eP
JP57?\4:Fg3Tc2,O#]C557OJ+eB3NR-+,E/d]P4.O8,DB,C+_@C:9d>f(TCPZ=,1
T:HZ7,7dNbBE[668Eg.,^60?ZXJcB-A.N^YXH&0fbFK^-8Nb(UfEI#@I2(Se8/;_
W_BNZ@U&12NMHEF7&7S;Q7EVU(Z7dD.DP;@VXW(V@PJdRN=2CK1&c7>3XAC?Tc][
FC&TS<+)I4X\VI>8\ZUA)\5<7R.6cX0]6H-L&W=9Nc@,gQ:2O6KRHXJe(U,TbD,Z
bM(D,I(</S_0C@C02_:c]L\X-KFf:e9.aB/F+25H@0-87DLQ0+@1^8<RVdM,\e)D
+;]ANPaE/ZBUWCg.@fZX9PY/)V16VY_IYAbHWNB16DR4^GOBRg?6XQ:@3,#3F8gZ
2UJ-RcGS5^Te-GXHWR[a8e7JE0?WN&VPV,^8Q=aM#/4aFaNZHX:=[G)^-cPQ^HLT
JK9GLQQ,[b-_.VK]d+Q4=ALB3f\S5KQ^@53A8MQaB<#:310gfZ=0e+LScPfN3-(<
8>+++GKWM[-\>#.CH)Of\O+D^4=K1]#25E(/2-@I4DL1V>C<,E/D/(S;;0ANR8@;
O8++-<<=V?M<36\WBL:cKZYTS\2RY[+@27H^..HX]K><3PIP.DNT\=PYBUX3Cf_F
X#VVBNGK[<C44^R[fNWd2Cf?EfD_7-8f-KdQ:2IWVNL7I=4(b-&LdR6T-BaGQ7-G
e1\b.8ENCH7Ja#G<BO\:bCa)0LUBO@5.+)b+-0W^a^@bVA;df@U<L/GOT3[5?-eg
)LL;E@0RT/,/,[.Ia?gC]F\FO:N,6.7)O3;0^5aQ][D/\V4(T926b\f\a#W21F=.
ZQ:P+E5ZVZZaA56d8#G&HS\Q--7[<FA[/UYO9<.ZT.7[Q^UURa/dI@@N/@9L4;:\
U84F1(LIP-P4B14]^J=42<ESf\DRc>gVY;1&a;(LN/gVOJg96\<1[R+Ea0/cG9b(
D:VU:2H.+<60W/YG.5Mb(>F[,;VRA>H6,E4_K=?5>a>&[,E)gEe(;W(#H8Z:^9C#
)Y>CV@_^4L5BOSJa5R806F->H2Q?R87O,HDf5/fX]A]fF.(SV[Z./8&R2BL#4\(R
+XS[V?B\S4?Rb.NgPXEfP+[5#fX))Q<A<@9aeL#)-^Y8@QUK^>TN0O#]1C#Q&4M/
H/=@RDb1?P:-^BHW1>LYb_W&7HF_c,ZNLC=KgDQLM9&ZL,c4+f7(0U#e]&g4W+.U
<USe>6c\aO>5#52L(@J^;+]][,]K5]\fSMNK:(=5)Y#8F-F)=K2cLXV+Ea;9OT5G
8V,@geG+9ALO#8E1QWbWBYb4<WBUg^&MNEJGg66,0+aPeY._1+)2/Ig6g?Wa_aY>
TdOJ;(//HYX+U@2@&cIB-\PFGRF#N+EFT6SW96Q]g6a7E=ea,97C5F)N26=B:Z+a
ETM393?/;_B)DZ^X/H[+=dX&2W:&d-L13e@)#62ZAIeS7YWKU:7R-Da#Fg_?d09&
^D6.XGAT[W=0fN#Q8Sg[YR?A9:_-#YOX-EYCc&-<N\WE2b,bc15V7Q&3@#f)JJOU
Y5]\WBJ+Ya>V0BY0,)G2H[SB6HgbZ@DUb9@@a8B#B=7(.@MfC?6[25&dGY7N=KS+
L.GK&B_VV&&AR\[d<8&V^;8HcfY@\.)LeGD6@_IRg[>#e[A6QLc[@]7(aCWEcZ.f
/.MX[<Y@M8GQ/IPV<QV]MQXSUQJ-B&bb7S&f>f?^57TXD>/&T3ZcT2TGd5e76L#[
NG;3OQNLEBg4RAR>;F.LUS)dMX#HDCcWMQJ/3b<?KCIf2cg\IW5_OJb.9\9=EN5.
K_Q]Ga>Zf:Ta)O]C7LN>fPAW+2F.;#M-W;?B^S3>3=1^QDf,:BU_(O+:+X[E+ab&
XbGgbOD[cCH+^_>J7;J&>#OC)CJbHccY,Z?^KWGC18Z&T/[)V6L-,B>3WQgATTTa
1;DM+7QX2)#RP/N>.FUCL0Y1Cf3Pf<]^++4M0,b2LF;#A-7_Cf#NQ#WM__:9EDSH
^0b1a,KS+6g?B,=U8aX3OS922eJVJKc.Id++GbV0HeO3B-&;Vc<f;58_KF(YfAII
e:\7#7^W,(\JOKa98:<A+d#bJDf+,Q7Y0Va4<O<[R6LI;\f?0DH]^=KD5F\NXNK0
M@W:V<<A&O19&\-/,&=(72G?4\[NT&PRM<dT#1?[157_)IYU6>AB65eR>@+D<=->
ZH6e7;?#Ae.&[M:=P<@;Ee=KPfN,[L,S7cNT-XWAfQ2bK1D40gAC347LOCOE5UH)
A#&S1d-OJ?f][bE8O;a@T7VZW2)3^8:CNW9;[;3([ZddP5#=9;?>A/fG;K014E@4
Z(^SRAOG3NE_ZI<=dAE+S/A=SJJ[G#&,;d\,)bWgOLBSd6B0W]+/_6IH?.Y8L9,-
E]0CMW=(V:=A-6Y[8eKSYcO)C_+\OXgO][dOF>F^0:IJVBc8aU[b-330R0E>EXA?
A0SS<KSe;d2gfO13VWZ57f=TPO&7-2MJ@]ddbW(1eA)@dFgW7P;9&Md/HDR.PFC:
Y-OFb/T/U],8Y+@VL03E&T(7BV?,RY>8TJ\,67<];-<X0N)#X2HJF1IDXRD0-<0[
Td37_LfP6_/.\JNZ)O?PKLbPBR35^P=bWJ=Xa]7>J3<YJT7b])+G0F\+_QI?3a,8
P#gGV&D2\-d_45N77)VbC8XV;K?D,?:N+L58G\P5OWZQ\/]-G7;11237Q.LR)Hb-
2277:Ya6=J5M-7S=3dIfK3[@e>0>c-HaID=ff6D3UEB+94A^#;aETeWV+=@I/><C
D>Sc/fRZCQU7,NfA5&2ST+?cQW4R;5I_.IB];TIf)^);U5(GLHbe)BAE>bBUGQI?
d[,5(#,O1-R+ba#C2-[I6E_Ag6YFd?(&>^Id&[\TFZU_0]Z>3d/5LIcQ8WM[3#,d
NIdRB9I/\FRP#_/5CGZF>)T)M8;#LU0BcF\]WR(:-)&eQ+_F230;1S(4c.549O29
Z1UGEa;YNVWGRc:bWf<=FFLC[W]5\_b4)EAWC,CdD@W1[1H9IH2^F:_V9?\<A24Q
e&BM1\a5Za\3RVL62X):I;G,E?9>8#G6^Ced=>.H8Q;.NZf0-LO#[_=ILV&b09a<
]U:QGV3]BQa(#U;3V)gL;;NfRPJ+Ycd7e<O7RFXZdaG8N(/Ab,Vf(,C=24)?]L<f
gI.70aIc@RMEPCP[.XZBLdLTZN9V=/(;\5IZ:6E[&WL4eE;V5&\>](d4DE\2Q9</
2Y^&=Cf9HbR,;Cd8(XX[^2#D82^(3^YHRWZdeQG7,6c+5c^C)dT80><g##\B(aXP
TXVFSDL5GcG>+T?A5<Z[cWY60>WCa^d@\&R1AL+e^_E?#+d&.]<D[-ePUd>74Bc?
g/a6aJ-aR2-K2S71X54)d3H2VO;=L@RDb]-&=AE1M43IF1:X?5+30Vf[Z78SIdUM
2K#7a0U]4G1+a#>#CX<g/F.;C@EK_?/d9@5Ya+e:]-2YQ7HC(cYEOdR7OZ[aQR=,
U>ND#W6a2aKIDR[AW2DdbL(4WCG(DdcR>\.<BcBL/gJ)EgKEET(^_#C#@1)52+QW
?\f+-9V,)0F]+;8/f;TR+2g5SUQ3dTU<6XZ_WNcS;cb9&/3/CVI=JdVN^\_B70Je
d:0AD>54S;#6X,MgVQ]L#;+DSV5BA\8\3Uf_XS..a[[^W(G+cDY7N-&)J^9@P^VI
)&/4d=Zb0):VH1,VaA/.(ZL3@K4@(##,&\f@bMNDb>JI=T<QVC?-d<<&MTCQTGDK
\J01/0O_28#/Q\fCcSHNQJ_&MJd_DeAK&5d7+_V4X@8V7;_],^b&D+Z6EHcde?9T
J)1Ab]f2XbXA[ZL,1+EN=\M8fODZM5^@De::8JaeWFA8a-Bf&7?fEJ/.+(<QLgIB
C8D0+bP+6#N(e[V+fbD<,I&fGa^Q)7LM1CLN&/TEE].J33_#eX&dA(QBM5OC;]Cb
OT5;eB349_LEV?:JZVQ_[<\,F8>X@FFG]G>d\[.Ff=77ZC#cCM2f[a0;GGI\;T#)
N4LXHGDPTK[gXF;.g[.V0FK1J=1X\#]D4SJ<U^/Z9Kc,SOJ#D,_WQ9^NEcR5bBM-
EN7UK7@^b-+ME2,7[0>60U;^b0(Cd7A&JcVZWJgPVDb)ZU)X91Y)(5]SI>@.-UQJ
HK?6JC2Z>c\.PI=\b-X[(9Lg\6X<53,L(8^CGWcCMQ]1Q5OVT\6N7b(VNJ+&^,X4
:acP&3]O=]gE?/)Q(U_\]7GXMMG<,:<)c+(O;:&G&dJCQ)[Udg9:e33M=\=L.(DW
[4^K[2GfO2]\TL7YQL]GH/-^PWVEf;W&A6P)7J[D&fN1f2B#@/SZWLJ7YCde#V3&
J6EeL:+A8:B8]4#[U67aTKGHO(e?)-Ef<6dHWga2f9AB;@.:E-f1H13MfGBL)[9J
.ZP8I1T_W=,?D]9K^E8NaJJ&<CSU07:X\(&R6\28(&aD(&]4C=_e;DY;0BSfNJ)E
CPYEH;@Z,,NVKUAG1EeP2;bFSc0T8^Te6J&b)/1J6AFLY4I,]]F+J/aH^26_cd:2
YLbONDUXANL@]GSe^(G5e:=I-U&LA.)4;Yg9Oa\/g,2#He6cIEeQa:-=-a^V4-3.
9BY>(\XRY?[>IL@DGb:cd/YHU/d_61(,-5febC71I>LK1Za&(P2GG?ED0>GN:Y.+
=9968BCKXf)e1-[_[\@1TW[D+G)AA]NT##gB>[@)X)4H]f@L+:Q^7XL1JQLc=OfR
;5cURYGQ@9gF#e#DNJQ/e.f=QS44@SbeENF1Z2+;QS7;<-)^Z(_4B9>2EKG[+/[@
P7MO:HEF>DN,/U,X;M97S>V1;+Ed4..7]V-8&b:]K^]3cS)<f[eZH8QX5gD4Q>F#
Ve_cJE[O[O_&R]=M<&Kb3EST,:4A8YDZ\-cXR?V+#8bMGb#cX[=O^1&FJ^P73QGd
HcaOFKEUEf)CId80b6PT1<0>U+LSF\M/],-cZb_OR:Tc6]2429>AS#Xc5>Q&+&+R
M@e^B4(C^J\>VZg)W/16HG6(eY#7M:eLU:RC#f4,bYRQN_\FQ@81@RPC6J>YM9b+
:.Sfd9=V\\Hb>)D;_&_78ODP@2e9(DX3L82,[,O3=;8X<49dWE+&M@R>LYG&-Tbc
HKaURb9fb?4GPdYcVa[P[MSgYP?J1VO;3;Pf4\4@.4GgJU[3/QcOTe9(<V+@ADK8
c=0Sg8MUT#J(?SZfQ)&^V^a;46&>)#@3]JM,+].</WWQO+SJ/X@)>0Vd9.f-X^RC
7>dVFYcPP\TW;^ZN.(:9-)/-0SME^XeVA;aZE&2H_/^K;-U(LH@?V)R=NPZ8UKMa
[JF21f1(75U^]9WSHOdXN8=+12Wf]-cb@H::gZN<#AcXfR/[cMBZC^a+_)LM^_7<
-P\YML-FVb8NC0<F?7?TTN84THO2BS@716He3A^3)RZU[(K.;5X@)+f3MYY7B_4R
L/=1[W[X_D=Lg0QQGeZPO00ZWa&8AAE@FQJ8cKQ#2T\O?ZO33O=dZ08WL60;GOG2
3CURA1Wg=;ZW-&QIK,A_efa:<@S)G,++Hc[Q-&S_.K539BU)/03)UdeNObOQ2c)S
Q.-f8LFSFPdUPJ;gIc<?ac9VHU)+1KOBCYPO9E1_AI:0#R85X6I5?@>=)8)JPeP/
I@)XJF\-aU:@dS;HSSMQ@<;\K,#9PG_NEIaIL28B;.J+LfOFY;I+<A:2#beOMWY9
R#ON9dcHe]O=Be^.eObaZ@gM)PB;06OMaYa=,8b62]+5a?I8BOCQcA>OVd3G?9.=
A5@/bdDR<eaQJ+R+?:G1KDUNaM#c2TR:.4,(Ya)7WeM[+N_2RPX-)&;JK;9R8FP4
+PI.V[@SX1D80V:7P]7S;C@GZNHE#a5SIQ5A?ba71cKaP==B\>#)H;Z=11<H=Zg2
V_L@b7[.K1@L(GURYI2;baD-Sd7Q/1Q]5I0,B+G29;]KAFQ)]B;HYMUeeJPJ:9NS
X:e07dCH]]LO_K>E@a<cW\3G=)a;S1,.6)4M_2G;JYeY4a4+YQ?LAfJX(C5]:78+
,@GV&C,9bL<8JJ)@NC-7cR=O>eX^OJR1/X5H@7c](KWe^A3SRbM27-K:0U4.;/^1
D\^A-XAIV-ddZTL2N1&Q)(5C#XG)&?&#2g._Z,A>#P:>EEU8,A)M#?@ReGD6D1:P
V<E,e#bDD>=9N?dPO8,ANdS51/]\dC6<]Ua+W^36B(4H,g.MVe#_+JR40/Jb0WCP
eSF<]>6G^N1]#,1=<\MAPcg@-2E97+d^f@f-\JCZFFME=6<&8:5I1[H0)/;U@K^T
9g,Z;c+ZJ.A=S>TPeKO&>3A-g<d2?PY?VZE^8G;Z&AZLQY6[1JVR-Ag;YTS-8=Dc
2e:cBc@#;5;3&.d8K>T>eU7gXYCX3;,FSIcC_#2:/_-70#@@JGQROMf>FL-9;K3P
ZR]A/^=2YEY7:H[ASUQBOGee2@NQ>64Wc3Q=D.,7)Jf8<R_5,MO6af;/fUe9g6Hd
2b^cR\I)87COc-_UHA/ZefE]9B>Lb&W[/d&geE:?09EP[T-,[L]-a7_SRdG^A5YW
-T/ATcb:?>+e(<HaZNVR)eJdP^&F0BcU[4>.=,O-\9bg\:g[P0_0R->aC_[A]Q&P
R_45[4GSAT[:W#-3O>M@HLQS@<@(TM>[\I>+=4N>ANJfEc@U+d\J></KSN)YPV^E
@&:)E4;E-bUU]>E3?M?IBHb7:M36ePY=d3/V,[EA]b9YgaJHJ2Z_R5BeTRNF?P#H
1.2<7W2bWQ8?IWT??D@8B<\/ZAH(PSB#)<?D#@H62Ze,c.P_:6=]XK>><3A/K;Mf
#_B5-#O>-#CBLR@^)GTEUW3VZT=J_Z\=;G93BJQCR3AI6ZUOJ[PECTCX<TQcR[A6
;gbK8GDICL>P,O^1+A>G\P(6I^/T-dKI3(_Sc@IVV7);cMQ8JJ49]4M)JFE16?D;
=cZN7=)FSQHJ[PKcL:1;BL,YI^&&C49K-e6d)]ZKGWW2=V46E</b4BQ8WA/b#/[3
?N<X1<<UTF,IcdH=[0[O&,4[M=TD@92H+F7;ef)Rf6I/6HVA^QD15<+,NNR6&UI0
.@O@<9>^8fNV(f;Bg-P0cPG8b7:XJBffC-Z/c^ZYX617H[@C(XPecMCL8@e.<;I#
Ua@WY-;Jc>J+#XW]B0+W;V?RB=J28;Z4PW8?D-S649gK6^:4g4,Q<(5^XHO=W2]4
?S-CL@<U<US6Z:OK?Y<g&QRUO7DTP_LRZOLR2g4E,E6.&=>.fSU+VWIGHBTN.,KD
NN@,@7H/d)N[W?3S)RR+;EgSKF@FO+bM9.aPgMd>>O&NP?C^&]&0@YT,L/G;P,a?
:Fb#:H=T33L/T>?C#9eKb,7/K.CcP]JM-db??HQaLYQYg:T]AI2e=);B^INVY/+b
HN1ARE&2b#/0?89]U2NBZPeNIY15<NGH3WJEEP7:1IZ35]0@C.^aN8JF;S1J?GF[
?=MV0C@09Y9;FS)+dXNJ,\<a<5E>LTZR4O_a+Q-DV5bcI#DDf4PM@WJ&AB#gP2E,
2B+./+XTN(Bcd+H@6LE29fa7f0Ne)+;#F]1cZ6Ib/7cYI97?f02Ne0;?9U3Z6R^5
O,/eaaENEb\#\-][\&N^]BBTb#?)_7VG,2cN@+#C&/+=ZZ4?M&FBH)K=#-=B@)fO
LM@]6NGT<fKYPB&a/K:L,#g6VSVB=9-A)<T1ERWd+^3-9BLeWTRJg,O2[M^9e78G
N#H^=(<<?W0]BU,^L.2;?SLX)0A<[XJWWEe/U#YCN-Y)b?AQY\YZ_A^Aa[0\L,NW
10JcB2KR7G\LXEX62OM:P3Iee9:-2J5a?M5=f;66Q-g8S5SQK<J(XVD,:1RcU.(5
Td0#8.TGHAgSR/6K+.YL2[-/FGAfFBM[^DR_0:L@Q_6_NMC&^@9;ITF=^aCJ(0;4
5S7DW82-AE7D[KNSXG4.G@bU-H3I+),GOCLdde<Q>@@3)RUA,IL,?CFd,4WR&+MN
58KO<6V)4W,,LS>b8gZdWU_Y,0O7.5aKHGJ1dI;a+b#ZZU(,[YRSX0Pd2[W5)6K9
5cX--f+a)>4AfP9/N0K0??W3->YR:NHQVb+A>eK+Cb)7/8J+;#I[.0f<N4+.d9dY
)-,NAJd8WJ2CQ7a-ZN8_J0[b?L<9U39G\&<+@C4XVVC@d\1TD&7(S,BQ0X&^2M(L
g9+49&<dLf(ETb0?EA]\c_KS.=#UY5(Jc-#^-.56./B@E$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_CMD_OVM_SV

