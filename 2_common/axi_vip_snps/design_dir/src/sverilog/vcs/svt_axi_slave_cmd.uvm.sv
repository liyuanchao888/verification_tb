
`ifndef GUARD_SVT_AXI_SLAVE_CMD_UVM_SV
`define GUARD_SVT_AXI_SLAVE_CMD_UVM_SV

typedef class svt_axi_slave_cmd_assistant;
typedef class svt_axi_slave_vlog_cmd_sequence;

// =============================================================================
/**
 * This class is extension of the AXI Slave Driver component which creates the
 * HDL CMD interface.
 */
/** @cond PRIVATE */
class svt_axi_slave_cmd extends svt_axi_slave;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_axi_slave_vlog_cmd_sequence vlog_cmd_seq;
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

  `uvm_component_utils(svt_axi_slave_cmd)


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

  //----------------------------------------------------------------------------
  /** 
   * Connect Phase
   */
  extern function void connect_phase(uvm_phase phase);

  //----------------------------------------------------------------------------
  /** 
   * Run Phase
   */
  extern task run_phase(uvm_phase phase);


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
   * Calls svt_axi_slave_callback::post_input_port_get() callback,
   * issued after getting a transaction from the input tlm port.
   *
   * @param xact A reference to the data descriptor object of interest.
   *
   * @param drop A bit that is set if this transaction is to be dropped.   
   */
  `SVT_CMD_DROP_CALLBACK_METHOD(post_input_port_get_cb_exec,NOTIFY_CB_POST_INPUT_PORT_GET,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_slave_callback::input_port_cov() callback,
   * issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
//  `SVT_CMD_BASIC_CALLBACK_METHOD(input_port_cov_cb_exec,NOTIFY_CB_INPUT_PORT_COV,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_slave_callback::pre_read_data_phase_started() callback,
   * issued before driving the read data phase of a transaction.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_read_data_phase_started_cb_exec,NOTIFY_CB_PRE_READ_DATA_PHASE_STARTED,svt_axi_transaction,xact)

  //----------------------------------------------------------------------------
  /**
   * Calls svt_axi_slave_callback::pre_write_resp_phase_started() callback,
   * issued before driving write response phase of a write transaction.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  `SVT_CMD_BASIC_CALLBACK_METHOD(pre_write_resp_phase_started_cb_exec,NOTIFY_CB_PRE_WRITE_RESP_PHASE_STARTED,svt_axi_transaction,xact)

endclass
/** @endcond */

`protected
B2GMI)(J4U6M-\e8HfTfNA\gJ^S.T8\J5J282P1<daf\092c1I\O2)8X-77C_3O7
]aY_?TBLZgG0c^FMB;\=M=8,d@INSVYH)0]3e#T;7Rbb0I=<DF8061Z/U.YBCfF\
Q0MIVdZ_MS4S,X)5:+_;(JO+;/[&@2\S)f9#aK#4Z@=,QSYX4,6,EQZ\8<R0+Y1@
cJ1.S_6^G[6g?,dROJd;J+WBTF6U\CZF:D,TT-)0QAd9NC1-W<5N7.&AI.Q.>62&
OB79c\YA[,241&0:N3f_[,[^>f6[0+?0YAdN/@gL8U_E5G2<c8I@KT4^df3L(d6;
_GS1fP5Ma8K650J9fa^bUe3;2eH^7eRd08&RZ#J-e^)7;.U4a#@c4#&CRf4>.5OI
RJF?O+HINbBXI=dOdP<6DQF5g0?QeTe\Eb:>6+ADG3W=-EfQ4K/IL(VD50XU/cQK
&ALM9K:T78VM)a^+(fgG@M.@M/ALb/CB-S)7#d.6S8^I:6d\NK7HXeR(KM.fA4OP
>/5M:_7bU\EfG,>7^@(5U\\G(AdP^,dLU0M[P?AVQ99,Re#_13ePQgN@>I]?L[MA
dHJ<@9XGFF02P,1e4TY3d.S6FZ=924_@Z3d_U0L,P#S3J/_>3CeYOX=;MLG/<?L[
O7N\F(fBN333R9?]_<O5]#<>#7CY.NO^3H?ARA;K?N1N&EO-R;EfS[J1<[X^8E#+
VMdb[BgKB/N:(7(3X\b>C\IR:0#a.#7c?D)YLbMd7YAR[?PH4IN]G?JSGe\-&MU=
D?)cH9L0APVTU1/F7&(&W3@T-3&XfDK.=1c>CH>@3f52g556[4C^/g<<WD6/\(gB
:9LFf&gV^K^FWYEM^Mf+>Y9Q;&3cM,OJOSVNP8)?D3UgfKK^I0U;e&5N)_,BYc:a
<-e5./:e8aIXPMNH<CJ=]FH0-MZSHO?35@e1B3E-]<+I,(RU_9=I/D#_4\=RYaa/
2EG]=Le=((NL((-]M2RGT?)GZO6e^=\fb]:M#3XadGcO7O4TED^aQ=3P[P59QdWD
.-Ob(&VTGb)4^XgX]W^9HYfgKV_.FG_=NEOD\[>bEGD^c+Z9MIHS<g.?71Z75>^=
3(5;(XT3=&^eW#H+AG<=7<@(LBb7.e6H//7>)c9,3/8OTfG+1U3ZJ1OX;X2X\6[]
<UTT9I2S9-+Ob:<MaPGXSMEH#^T)1<b08/P>NaeGbc.eX]dA8c2/9bVHZH#\HeL.
UKOSK1.6&<^8EMAdbS[=UXg28\=eQ[ZR(M1d@D5AL4,bLdK)d,:H:8Nd1f#D]^=Q
/+4dL7Sg8#RM];6:e^OF9H0?I8BG=]V:=W-#LR-:1VGWD>/DR7A8L\RCJ.#=.W+g
8^IV1Q?:fEQV74/MO0)8.(MFUR\ZW>98(FWVd/L3\JC2-TW?b,=b@-SO(T+Q21S;
]Pb5A,>=GZFK_3?=^0<I4MVLIWQ^DdeB0G1BE,D]W3,;]d0g1b+L6RM#U6V8,#-M
F7gH;]/6^RFND.CS08HD_^I9MYNH(=57/B(S+ZPQQK-GUD_1D+NS&\QKabc>N.&@
.7cCNR_(Y9O1S/;eT<H+Y]-&R+J&3g4Q7I?Y?,9KLU<f+VHX-fLQ\\c<GMd9RH-Y
aHWABD9JW^?LWZ2/Fa<RPJ[OZD;OL+QR_0877E(Z>/>??We1[BRES9cQ^QBE7MN<
0X3NNU0(G1cD<793UBUd)d5e[N\EaE/Rf8O&])U]:;ESOM1XA^R.JE#S\68AQO1R
OC>e2N,RW,4&QddXALGXeVP+G&/Sc7OXWH?4/9R.H^WQN0:O=A-3>LKZ3A?.0c7e
>gYUEa<S9#;dU+)DX-2Oc05\S7/6=d21GD]f^P)B#4(eB&4M4P>&S<_[O>Nd5H?)
[g@;^RP(C?fAQcTQG12T_g#IWe6VD/6[K\),]VQF81JD#=CXe>Q3J1^CU^==)U]-
/Q4XD(,g#=01dC+7BQ58Hce1LdLRU:OS;E1JHO^LVe,Q1.#M5]]Qa\LD_8e.fbG-
9.>]K890=(0U?M:>GH57[@R(@3T;S?ILB=5Od:B]HS[7[&J>^0F2Af2bL&(;4;\=
6PZdB6.1ZeZ;-XFO,+_H6X6,cDeZ6#R)fPNMd[bY5e/@1B)6&YFIPCFFGBJE5LTX
WDPf>#[CgQ+:_2SG(B;-U.2H3\6e]LI\?CWcCHgZ?[0)^@E#1_8<3A\.W+AL8)f]
.a=#+2b2Q^Vf.Z)3JV+WPV9A3/;-]K2+IO6^2+fOJ=DGZdOag4:N4+CBd4c/a^V[
DD:)4Y1b76PKVW)+dV9YA\9X9ET,K(1:b&;(_M;<(Y:Hg^=@.Z=)Y\I@4S[<+6C>
D#-\O7QeXg6+S\A4,;J=U;6fP0.A+3a1NZ?f706XU14>GZW6GZ-eATK1U:K9^?8^
S[.W@L?#^4ebaXg/=093#ZAMS+A.+UDNDTKN>:3D^J_TO]6<5b,W)TX[f5]QX\8]
bNRALHL?F+F.3WLB@fGF):>E@Q,a;F)]3bSTVXbcbABe5#L/4a/:A]U_--gL,83Z
;eS3WaK5Z6F[dc0=&#5F]dXNU14V#4Z9/635/,S6BFb98a2@X5BN7?AC8O\MD<CU
=+N4[0dCb^ODae\CFAf4Gd9E32Q,)VZ9,Wd+8C;0M7?Z@6D(V50]d>?C?6[#5EL0
2M9+)C6/O=D;,IMW@?&ZL_UPIO^6SH^SP4f&fB_)(V=C]<DX_EG8FgG3+M;R8C.P
3U#=_=8g2#;:Ig4c#GZMK)PM141H<.8U\Q+c6.^6X_2a\c0L?0X,(PK=WM]XK/NP
<6A49#-6[6IM\RL^Y@K:YHAbIgbLc:dQ6L/)\f>>9=2T#XB(cR(aNC>K-Fc^I87f
\4,QA?+g>bDRH6#VOQIfEVTbO\),X/cMCdY\\J@#=JOF@K9O13R=^.5HE.LI?+a;
aKa^(>T[[ABL11=[QK)M8eE+9+KfI?89B:eNFTL:AG[S;(A_H0GJIcT340H&Z:]3
73<\egQ8e0ARYX4JQ,U7=I&]UcgN;d7.^\YY@YCcT._7)[]X6VJ<0e8d5/7T5/7O
9\<M>]PECQKeO>14P5P:cKU\>^F[#5NV.bQZ+B7?=PVPA(>HSF2TQFTg];?/3@31
gJRbS&c0]Hg-XS)PdQ[6e46_1\AQ<#W84Z665>2ag,_0]e99+fZ<XM?4DOMeF>@P
64Y6^)03?C5W#,g)Q];Od@;:NH3#>UO?4(GRfgFQfKA8OBFSg)/VDNM/b[[H,7TR
S42]I[1O:dD<4C>84;)JB48Ab5)WIX1EQLV6T-Je<Wf;:Zb2)NJ)_SO_0[-[>[e2
aUCZ>A4a.b+/fY.+?#Gg1Mc2R2QbRR@0DbPH_(fe=c,YgVHQdffRB>?QI:#AU=5&
+E&RE2B1S9P;U=)7g#&a+@5:Dac=-\gIZZ-.&@dJKEHMJ\Z;ZNf3K]=4Z(H]2+&<
8IY6N98#91]\[=-+ZV]X=A(EDUEF&UWT(7Pg;c.LQ=(SEXfD=(c(YEOB#W_Kcd_F
UdW?4C(^LBac8CHf;\^]-FW<2V8cTd/.N)D8=C?\cc;O5-EML1I-E?V=8D)F47WO
@X3EPcb>4E@0I9FKA.^+N&D;W_=V6Mg.B(HE@@_H(>WY=F8bNQbK+TH.[eOaQSg&
\TeJ#V)(8R:6C>F8g5b@gU2[6LZM[S4]9A(.QTN/..?6e>/D>:CED;F[L91R@L:B
^ZS-=GATaV<VdWR8P^\)@VLU^\;f4XERMP,KG,F-AUN8\^^@N\&PZW;2[^YgQ3KP
.(,\BW>fN-NFVY[+;IN;(0&R_C?;_Sb>JP+DCCNO4I=TfbW1F)[cY#aPdVWIH^KS
W.,2]W__@F+E3;1GP,>13ZV<\KSg?)?]3NA1dGOUI@;DR08Cgb2D1QMZ.>E4E[M6
X#b6MA&ZgZd8=ZZ<>+++_5=P8)=2Y1OLXJ3_E<ab-0OafBRdIO2,KOcEW_N)E>Vb
)\#B3(A-5U)R<&#g72,OA+,PG^=_0a18];dVD:fS0KQ51W]WPe,R50)55=>Id3?;
f[M_H>\0J<.5189I\-]3;cgHK0F3-APU(0dSa5#4)H_aQ99bDa6&34Lc.gH:cJ6-
JC[:M-.TRa\2-477C7RGX125V><M.J-&eJ5X)E.gI=@9(I[-3-eT+JEB]73VDR+9
=CCANbe6_8W030eUR42?YA-f+X6YQZ]W\V<,[KBAQ>=,#TFg4DFcOCd&NV0,U@S>
&D;+(G#<?O;/>(0#K[]=@6Ib(d]<:8PcR9=6D@g@0Y;CW]B>W(6^U5(d6X6PIY1_
1.BXQM_T&\LbT]aaJdeUZSTU1ZU8-9G\XR&^0QE;SY]5H6a8c;:T8-ISC8\,12Dc
#>Se_5<SNRYf+.#0W(CAXgbEaQ^&SaUN?.#2^:+F&XC#M^_G)SNK.VIgcFaH_FAA
3gC(bdQ1B/GGV&.I47:3MF,VI1JB\Y_F#H15e5e2O)RSK]?a=5IJ7NgY:H?<\[^E
//;?:6@XW)9QCQa2\6/C>Bd\).QQJ\);IA-@V=EQ)NfQ&,.;B(fAZ&DYU[/SQ6]<
O.2;(#W95.f3(EDJ48T@aee4(A4]+/66+.ce3_^e)8J8L;/IN;,aY&M/IedG1e,&
H_/dBf<gPC8+?HAP2[^.LW(:,OC0Ze0F_S;_GR9HC413=:aB1\>[Nc7PUOIaL5:0
+1]2P:\\:GebbPW<5UP5EVd7<6N](F-R]>YZBY>WNQ6U(7\a_2eV??[f,NcO-b)c
1Z_e6<bYN?YWB&<9FH.R,\PZ>bG2D1dcNQ4I68C1BYaJ-5NRCeRX7=MZ)gO5HJYO
P4J.D5fSZ>AH^SRM<a),RFQ@D5+2-GWFN>)Z[?/N7:7I8UQ[QdU?6S6I3+44T0bH
G8(8J_/d=ZQ5^>OI@7R;@36A<_b,DI-X<:-Z#7-5+=:6CVQ<.G8g+/:.[?VAH?Od
B(KH?0+CCZ@eZ7+5FO[):aP;_IX:UR?]KN@.Ga^dM>#-E.1f=)G@L[VN][e8?(]]
KFLKT;b5feMMMcL5g]S:?8Z(^Q<5)SYX#7_=MQL3-U1,e.9[ND@EADf59d(R/eHP
[J5GIb_/dWMYZ08MH6;\,JWI)27ZO[NLbGWgK)BM=HZQ&^QA98V2KKI64(gb\78G
V5MH0_f.1FT3(SZK71@YA_bNO6)<Y;\D#@)a]DV>BX)0bPT=RT35I@bSH^ZGccaZ
0[<J@V,FKc3T0g3GeXG_baL&DVP+bE58S66&g[dR,5/VeFKO+9>bdY&&S1PcIYPW
X8DWeWd-1S>9Q?Wc(TD6IWEI4b?9/_EaNE^2IPF6a:<>_fM@T_baYX[g)M4ISD+(
;YQ>P2@O71)A+0HbGL;aQeR74?EJ;E/DDIDc7_(aI_6\T>C)E<C@C_X<,?3e@/3+
21&D-N87GPZH#UKD1UF54dH+g_bY4BRL1f.ReKKdF&F4\Y:L]_-8\4aG1aZJWeYN
;H<Jdc;fF65U]BNO5.B3UMJQ<5-F_MdV(L@QNg2@J#Z60BW6QR,7C.9P@UG/4#4?
YRf;Y[a_])7P=7G-ZgF#EdG>HC^_AfM[,Z:2f@Wg/a(KeS7JOD_e07gU70ZJf(@2
?&XVAS>Ie:e.aR[4@d]QVBU.@.GS0&^W\BbX(eNJg.,288=41TL/EF1BbbR@gYMf
WUF44Q<NU2[dX..=0WgBZPL6@&PbW8IM1]_8a>bGKQPdN;bY7a;/dEEO<WMNQT=1
_E4W8DDaNY42Me/E\T1&b<CDY=99ZZ:^=AZJD=LWDb]4(I>KVb_2M>D+;aWRL3ER
QVbOQFJ]HcEgRZ-0A2eS5R/bQ1]IV(W#B3933EA4@>?@6?=:1Cd)=8ZE[7#VYZ4Z
R4RVWN\.@Y21,)P9=HV.]29d03LJb(PB)c,Y1A9W0HA1:YC[A>@P55EC3M^W.3J[
/WP&63Qe)>P?fS@.;TM>d[2eZTVNVX=UO[cVMdI>572G8J>&4#KN\8=JbT<ReN9R
@H0U&aBc7;KKM8<ZL3X/07?9R9RMSGEMECTg@,RLFYgfV_:e)6J-9+>?@?[.?<7E
&?D6,0NUN+ZQO+L206+J=QC@0bb\J95PVU.b6@8b=@]U0:?&8HZE;A31bL/[NL#8
0b6U(=#KU>9_[Bf7MUWKX[.93XD=MUDBU[de^6QTa@\RWaP9]#fEMM)f8-HODB;X
>G2,CQ&d_<]4eK;D,_0DM96_A;>V<@<eA[gS,Y8YfXE724/ZU_JJ4QdC242ZON70
9Xa,<)R6PZIL-N/>gP[_VKRTe0KT0V3:=3E_-K;dU+g/LM@gb&:]R#0H-O)\9>:O
Pg18b[:(g=MT-O/\Qa2B]<5B>+AeKJf==dAdcd4E.&][XVV\IIQJ-/IJ1OZC:MGZ
,0#>&L5eZL>3H\G_]Tc:^?Ig2c9N8).DAPQX1Y87.bF)a=LEO7V\6EK;ZCH@U(dW
@L4cAZba>:T+[D=.Y7;-NXL?1L/[/&0^9U##(<_]]N70J?Qf9#\[&5ZQ4]?&FM]S
g,&+,43AH4R&.A=YS:E0f,&&d0:/5Q-3&HFFIVO++D]KXa6DZA<)^+f>4^_U2EAg
HB&UCAd#d?T::Oe_6d:&7XHH.F@X&IS+-_;HP5SNbNX\0I9Y8]L5ML]59NTD:E0.
?\#cG>_3N45LB[T#8(I8I3VN-2-C-/;3./a5OAKYG<)EM<O[=T/)U/dB#D]L_19,
Zb.Q^f^U^Jdg5bgS]EU:F]VW6XfT05;(;fZI6cH^H/S]U?[dS0AcXd0a(P-Ed-K\
]7(O]fbA(FUUZc_J#163+F.g(0?0;dDa6C>#9QU<PMX@J9T:&I(H>KV=IKHY3N8&
0:BKePF6R+/\)Q?4bS3BVP^X&W1&MHHW6UDWXCOJZ+aJfH_M<5ML4GAW,<R2#=B7
^0A0G(?MfK15=M8E=5&;:KGN?YM09d,8RH&BH\bGAN##;NRabTbPJF6@2dWf[fIC
ERE:]U.D8SQ,V24b0/IfBJWGU5=C<-\<#=gD+7,+.,b73(^BKM^_TIE.0WBH-cBY
)GNCCb4/E,2+XJZ_;MNg)4JfYMX<M:M6eg=gZNR>A:HR#S,#0=.TaX3,]-,@Q6##
;:ROT8+>/.M6/8OBc^@R1EEUQ]0b<.AY?WGNBA8.OP&SBUUYJV^-0)=?eH\&6#AT
.8I]74@&#F4e,T6T3JCKG7XO.Tc,M/83g0RVfSMRN,SX2^W\3#DCNZGC[<:D+g=M
\-W8F77:4CUI0<5FgZ9Q4GF:(9IZb;NZL\TA_edX7fPFZd5WI4/X:?;CR\e[_Dg:
/X@?M^:8Q^QCTc-P-UMA?]:[]1]3^0\c74D_U38,KDT3fLVffIQb\RG8I:e)9^<X
=MeFXGW[MN7Q+I&KdM#X]+1ZL5@0Q--UEADD6)5<=b0@.\@R(6BVNSbNDPF/fW7>
Q\@]7E^_.Q(-/[LF5AP\N/eF0&7875IX-Kg.NU)eY)14Q:9Z[4Y>#(a)WdeGK]]b
/4aY]VR7L3\Q&#N<9F<A^T.U]Rg-/6Uf,U73bIXHfM=LJ>O1</LTK0KT^:OF0FM,
46FKRCfHgMde?B-Ie/0IQAG=-)LaA1VKd/(cLTZ=6VbF1f&aaVV)<)c0Qagg&&RF
W.[fAJgI[9<5)RF/,;ZE332]YJC]N.HBUK^UK<24ec^Q371N&V(^0NWRLY5#3@QY
R4_PN(95FFHSGOD0+0]FLC[AZS3ZM#gg9gQF3NTA1_7T(B^2D6@T6JLfSED,?5=B
)MD4^Y.cd+(JcI3CZMgO:;)PYCf79Bf4PBK/e7X0Vd7X^TIJOZ9<f2dV97BEF@^J
L0fMg716H_OE>\ND\3O&+DSO)c303aa39/H.?U,VSY]I_f/MJSDVFO_/[=4TN7>.
PZV_X7YF[OdPV^6@\-YC@X>8H:E8f&Oe[4gR7&(?JP8eA#@Sc\T#K(#d+A@.-ID\
De)Z\5B2P,3CV\RUJ<876eQYY4>?,E:0ZUP8ZQ76Xa)cEEVD>/\e+S5GYgGXX_I9
N:f;FG:1PG]XH#73[?aAZ1bK^.=0U+#VX)JfWAf7YGcZ(PY985G;=BDPTFN1F]/V
8]D24<J0)RU=)&LT-CU?A.,^.fXa5G1X_H/e:7H;1VC?2D#MC6VQ7gYF6@#)/Y&K
M686XZ6=fNJg1bV)DWYA@.:>USZQY+TE8TQSYFS]Je6G&3C5gU9T(W8EY&<d\F&,
dE?DJA(@]X^ZG8BE;Y<=E)4\4^7,&>LSR\RaWQ:/^[VV4fdU7<>L[0Y?0XDbXY60
BH]_gHV&g(),ZLHf]S2XDSGL;(?L1fK4SYK^&=V.:Hb\IX?UTE.Zd5?V2-g5g51d
[ZCAU62M@Z\EN4=g/9#]=;<b,VYQ_?B/dG/NGHY^&)Z0B0fY(1TA6&XGUB[?KfS/
].QQDVF7(4H8:[XCg.@OfXF]7YA-f@[CY5CFYeI\Y,BZ7G+bOT;aKIB#T;P]>1KS
>cdK(Yf#9gCQVg:0GfeQQ&FMN6eX9GKKe]\0NZ=61fRNg3FfF@<dV=NDe5-a#HN/
?]E/PSY9B;>,W.ZFfCgH72B/8c;W?D36T4#\S9HL_N;bbCGLadSbTW;ee5\dJ]MG
/72J5Q\PZ;d,,AdP:1e[bgLKBBf&WQcIQLP=H+=bN7.O\U\+eBHfQTX5Gcb5F6d1
K2F\W^FGNU48.OKC>J5cI[aYgIH&[\N3YeGd(0QefRFACU0,ZA47=[gW/B,0c#JJ
bMaH7_&S&#6:8BS0W_OdaY9/UL5<(B4dSb]5HNd:d/;b-S9T:eb&0:GL64#+4,#?
=XAAQLUBNVLg5P0b/eZ8E7IAQYW=AC/X:J.b9.b5V7Gga28Zd08JM#W.ff5#HTf,
F]aMdg)/P[6^=)AO2SE)\2P(XO4SPC3T>fCX7J1IEI<:Z70F7&Lc?SA]fa+/#KC5
[3c^#T5SW6R2fW,IUI=6_>U0f154AafG7U.E;.LUKgFX)1+ZYJ.,BU02(H+&BJ>T
9EJ1:R=[[O&GIF8;WPY6[R<Xe8D9H8/fY6)dC]cM/d()2(M?Z,aF;Z)dDe0S5S6f
BePbgffAfYaCK:SfPL;O48H[,;SXVC4:5JYF7KXe<:&7RX/5.ZC.GWZE\;98L:V-
cIOOO+),b)6/0f=:2=O>V>N;CXQMMC<cZCE>/EAcXI0Y_J@(QL9RLF&F18#>5S5U
_D#_89g[6X4E/\M@e)3;+:c0UC8(Ue795PFJ-69=Jc[8#=UGL<C2eeVO\e3L\?eJ
)g)5(eJ/g;J;8-c+DC;ZEBZ(D@T=/VSd@Y:SE-eLD+ET=O?@+DL4.+?Q^P\=:)\R
I#d8<PYO=NQ#c/PE0Y7O7XK/&UNf@9NIHbJ-Lcf&S9SP7fXa,82T4C<cgbW6ZT.Y
g2#Z72.8-?;[2\QZQ&1JbWDWVAIc+bX=V\.=PZ9L(Z.<gdZEb8EIZI&HXJd^TUWg
_3MG0KKMUZ(_g)aGLXS+4/O5UaEL1W+5_3ed:6+8E:Ja6EJ3a.^cfX_U5JVPOd_M
CM7CMH8Y@7E-4M4TM.7;L3VD=8Ee5Ce[-d)F4.K+bRC+L>VYM<Refc0,7&\DUR^#
E<AbX\2@.G7GU7/=>3TW@BJDY[ZCMSMY,Cg_3U\1Ze4KE3?Y(KEX5D04]8(>B,Vc
/-MSR_?Ob?NDD(</L6.VC,Lf[DPK;d^2#,-)8VCV8Me]/U1GZ9@,EdM>Z,2/GC1J
RdeZg12/19RK1=dI..Q#]cITcc(,-L6g1BY)W]V>SUIac.>c]4E(fNPT9)_NKXN;
TX4EH/[Leg^/;2PLR,4XOBQE_Ve6KL\8BGR4AQ2Z:+P72H]M)T^DG68Y^E_Z=-7_
>=fJ2^O)RIM+4H-PK6bJ@,RR-/X@\bVHXCfc[)[,6J8dg0H):UGHMSLK2[F70HQ?
eZW7W90].B:9.VOb(B)@>F;3U[A@]V5dU]&8b<gFY?3#LX;,C2FC#,]D).Ng3VQO
AMWPbH#/T,D&T&f[,TH29JGPQg4#W7(g5VeWD8OUQFe;/3\B4[>:;D;/8fNf-^GH
9O]ZG=@;.?ZWbN.H)L^L,Z4324;;A<O3?(6H]F<c5S]HYG\5&-B845\WZcT#c4aS
,=O,g+0g&(.-9..A,7JYQG6#Cc1f4H&7.>SWUYZS\)a@+_9-?<7T>:S:RJTIYM6X
?,1=W#AD<G+WVHJN1POda@6#2$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_CMD_UVM_SV
