
`ifndef GUARD_SVT_AXI_SLAVE_CMD_OVM_SV
`define GUARD_SVT_AXI_SLAVE_CMD_OVM_SV

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

  `ovm_component_utils(svt_axi_slave_cmd)


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

  //----------------------------------------------------------------------------
  /** 
   * Connect Phase
   */
  extern function void connect();

  //----------------------------------------------------------------------------
  /** 
   * Run Phase
   */
  extern task run();


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
\f:;eMSdJR#<2=YA3gNJ6G.f#OAINZG[fF)8VCSIb.e8,9/b^H1V+)4cFZ1IG=OO
?EQ@B/#e;&IZQ&L)NYU6aOT?)>_3-fQ]#9Rc+9/)[PKA]MP&-W<;>M49Da9@9?=+
gdU(X_GEW_2LOPe1IK5GaT3CE]W0<]^B2UK/]<7H;5b:\/.NY@^@cU?CbQ/bV?<I
cC-f0C:=.f..bQ3JPK\8c&3Ie4-b:W,]<K07^e\DR2\45T>e=2\7O>H9_VCWAL:I
QC:NXOW:UPf=_\e/K7M<F\,5Wc<O#\4G(eJXLMJ&]0JX<D75OS2XOI@&&.gWD7Y6
E2HZ?e+=<^LPX9eeD1a>TO._^YWeX,-ZT8=1;-6-3:@;-;[c)I?K;;feJ)#<Qc78
aHCad8F8<+2;:H>G=]]3N3W[RNZ=#9B)Z,gTCUN6;>WO)S<Q_VFD<MJ4R=dBN\-b
LeUg9>WI506Ge5W;^4b9N-42f.7GB@#9Z1d17aZZ<.<5OLV-,[g:ZYGJ^a(,WKd;
Y=;]I?HC(e[>GO2c<1)C2bKN:H-3IU5F)E07[Z/;NTJO[Tg/dF-5\+OO>c_/QOQe
b2)-23c&@^.6],E/dF]]g9R_V\1D3J)5QPF];MVGc9X(I[XM]H,BYV9+BS>QB_\J
.F,H)fV-A-bC+?5\2)]?G6KOFFY+I,ZOG(_0aVa]TPe65@,@DH3Z3f<XE0Na<^GS
0<.I=gfTS0]GF[/;8F)GD=VFG6KgZ_gF/0__[OAUX&SZ&eJ4)\73TL8MC/DeEL]C
O;\-J7=NBB36TNYS5Y5(8)\A6W3VJZYUWQJ\Hb4Q,@beK\cWX_2f6?@M;)9D[DBU
0)L_\gTA/S,b5b/WIa__:6HXW6J#0=9NI@@X(@C])C>&#Mf>g0J<V\W:HRUXA/dO
=\Sa\g55J7W-Fd(@)DJQQ/^)+dLFZVcEJV@5_N7DR&:PT@@4(,QXH),PcVG+5_T(
GAId<5_H4QI#\^NZFFJ52-P;CN,JB1&^K=:P_/a-Y<LX-OO4WSB]=B5J0>/+MLTd
,:.IdFOAO;6,@gF@5(D@X/M2-1B0HE@)C;#5),A=aFN9KOf?@dNg@1:/^QFH)6RE
PFY.&O[4F#+TVNMAZ/N(TQJ(P]+Ee58gKdFbeTebe<(VS3OS&D6PDL=<2Ib^A?0L
dTK&B3NCU9Z[<eMM=ObFX5UMF9DM#,Y^P4:4=-#S(]^GZ[W55BC2g8U;>H]CRdg]
DBL#d;MI[+a+#&B3YQ/MZ43^Rd:5>7GNP,/^^-H,3LLc,f4a16EIEOb9Gg>Q20UW
==UV&@2EEYCO(:Qd[cS&fE?VTfQQ4e:QA7,Q(222D;C(b1b)BO[B^03eRHX]R<Ge
@2E+[\I\6H3#_AfI<JPSDH^L8IY,aA[ELYFG;-HSL@/gN[U7_C<)RHMS416d^a)e
G2D0MY;(&=0\Ge,5G)F=)I=GE<SLMcbDb=geYY+6)18-9TE+;O.ZQ[,EQ9WKL1.L
2>G7G;SWf-LG.J@3e9_CY-gdb]BZe[/B@WT2Se4.[IbRH#=BZCg3@fH\-M<;fTX_
A<9fcVE+UYS\(K&gNXE]cLJ6);QLRT57.GYL9R\NISRI;-R4QP^8/dIK0^HY2,S@
Cf).Q0[e-@Z9[P^<3RZd:AXHbQaLbA7a_.3O#<U8d1AfJ5CVd(@3\aZSV?O(J4cX
^GN0[P8e;A(X(7d,dHg-Cf=+)/cRDae^HV[)cMRK4MN;+QR6GE<GcL-DMD:;4/@D
7T2J;#&[Hb80-_PRd-T^#HKL&M_>5]JeU.aVR=NW,a=f4FQLW(f&VNWbVfVC2)[Q
IP_MB-&^OC=R)cb4XHc)aRBM?(2M]e20_)=G@C525_NV\4X^.Xc?e:YQDR;+=dS2
83.DcJYa]<TTaZ+EX=P70NeXd>IL@Y>=fW<=?b7+0WKY68d]AV.^K^YH?S8/<30G
0_[36JXga7HLc88VN>d,I?#DDRO,ae-;R\MGYQ-+KZFR2Gf)f6FdNCZQ]Q.ADOJO
=c53-:]<_9RKL+>gAe5DNP.27?N@X6@,-=<#TAGeF;N:Z?8c5,^W&5.aS=/J#)[e
\SD^0f@,K9eV=UN5N2>C(Oba,O27+[66+RZ^)J2XHgU.@^D=ZMK^NHEX:4,P#(^3
P3XE;HVH#Y<ON]X.UC\KX+UMOT7N=McU&:SG[#<ATZ/B))E47Ag(f/;cJ+L4NRAK
_NNag<R.G7VB>4_C8^@J.;8XM@QGLJE?NY3O@-4511gN?c9:&2/-^6cIL:Bg?D?g
/@19P(4LIO+X=XAbQGRGAFIUD+AA3M>:N&F-A.<5/&[6O2+X#?__DQ:J)dP3&#1T
BObJQEOK)O9]D3<R=(;&YgQ.+SJV]e<;bJ(J;L-fC,+19@&g,@#-RGc?[AGa#CDF
P70d,H+-&SWR[8TY?]7-Q\G2FVOB4ZQZ\_Y]IBBd72/f\e#_EPb<FT>DY_/&H>_7
dE<+_T)2VJM)</RFD5I.^3_-BKc>008\4^e2+3#X<2c9()MF9dB&_5)2#^NW#PD6
;;24fFR4];&8P?_AMEA\Sb_T.YH\[E=[^D.PN1S[F6[Z1Z@b4#>#Haa8B5:ZCJDN
S6GJUdJAUEPAWG#c#9A>?H\dTGTgG?5b?,-A4KUV:AS<SI=-^C/^<1YCU;WU7_K>
V-F+#3<;E),WWR&V-X6\,Vd-.;9DJD6A+_H1aRI+K3N28T@4\/8d6+&/;.1AbQ4G
aU159TD86]W3KILZSb[K5_FYW0VcXX?a.cgDZ[FacGL;b7_CIOF]/TVU95a2Af)b
<U:b/#a.3/E\d#\(JE.)cT5:>)fQ,_51;K<7/CgWF.OOD>Y4]CID1S<b6I^M3;3;
?>:)^-WTP#TO=+Y:gI3S&Z3Sb7GF2JAOdb9J&^;4YHDZG6dDC6TE6aB;3R\Z.3AF
U7a\#;Lf45:L,<]L4/?6YFS#VQUIV>=.MDEDZOb+fCT[,0cQ39R<BNgL/<4VW)aH
DP&Z3I7.b)Tc=JBWS<CgCf+ZG-=GB5E74=1HZS[N_JLIW[\^L7)Bb8P7>,]KLaJe
Aac3FQ,C:TZAWU6cAG,XbU_7CP5K&=_A-VV5E(@H0MA54QZGDM@WXb/(XUV/G+NT
]NC27fE_\Ibg#TaG<5<3b=<G\4YRR_>9e7+?#+2-3)c<bUJ@1g88??f/V7)81V_?
N[7.Gb06URaYMS4X+/8RX58I]B>\Bb-7H,)#e8-<GN=P4adA-,YIc)<<W/7b/OG8
P_JE+11AO6N4]JC7@4g[9bOIVGfd(bZc\-D67g5J:C2;<5<^]gX8KbVRM5aC(UR@
BDFPSJ:2W-XYYB=cK6cM+1@e4B>]C)cI6eA1b8V7E>f:\GfSB+MBbE;98HCE^eV4
+16]J+&?6fITJPU+^_G619PQ?gG((/OcL,V;[M:4JF4--g)R539UNB,[\-db.=f7
g<d3@P20N^X0)^UD8+2e7d-/@FEG1c=@W=X>2g/b,8.B^@J5FcSO\(+<?+\./C/9
+==#H72eL.J<c4#)e7fQ2J#&(:L@b]Tfd@->7cAAG&PIH&NLAA8)VQaBPPVE7cDX
6e;U7da#I(GHfLJ_WObbAEKdK:XJ2)gW5X.aY16VeeNZe,W0:Lb&;4V9Z^94T:?,
MH(QWdB0^-;5&,C,)-@ILb#5W^]]_YbC#6/eKKUH/L7=4(DT9?):0L+3R5e[?M;@
+=)eCN/;V9;c[.JS7]12EIQBH;J22XUa.(,:Vf-^f/VCEMRAZI/+EAP8De6\VY:&
V8NX)UWD\Vg4BM3e&M;60/B(X_1^)Z-DY4VcM9M[GXQY]JR?APAI93QBL/NF3+Z1
K?DFNQVKFICF/E>0,0\B\+=RS#S##G1[.8/Z;/O6BLcZ_A,@Q6<J?#NX&&INV3OZ
YRVdd,\HH2_WE(;Lb;B].Y5a>1:L?bW]LJfDcE-DW(1R#+Ic7:V2C3c6-;#-c.^2
<W)P76P&)GI[cXeV19?e5T2MV\457/F>#.T7JFP:c[KX1[ID4/7A89\7dL[[#^68
1Z+4T[17FL0L-YDDQU5S:OG0RG3fZY:0gc67^JTg=Ee4E:AJeg[NKZfINWJAYDeL
&@^CK2YE<<8)FF:3.fTHg-A<UFET<3FVV+Ya&L58TSP[@\TOaPb^^W)H<;8?\-+A
&fF=>?&6>gU86fJ+Eg4fM8I5]d=[b<>a[C-&LTFF0PW;OGM(<.daI>B^D)7gPQF5
:Sc33c)[+2Y9Fc74V<aQ\87U68V=T<9U48O:7>E?FXD9S+BIZT=E@GE2d4;Q_4#W
bL2bbgd-dIc&[U+VCgV/NO\4.D(Q^O5IJRc7X4<W=W_cda-]QeJ.cX0]UPFHYHbW
AL0+M^Z=c;7053FaPL+I?7J8AYS.FGY]b(;&-K43f3eQgBgc1=27<4XCfD-;fgD2
N^U7<L?PLX.e9Z7MM8PeK01H>,KbK)d\K.&CGNF9g3dP\a5./ZNLg.>?)(f7\)YM
S:c--8L7?cMCQ.#J.C^GDUa0;.b^=-O(4=M;5@6]77Ba,aBV7[#>:FKdC+;;b&]0
aGX@4IZEYPE);47#&==b5eCH.63?UN[-=5+GWE@?+?S)>8&DE:YR.SKF5@SB#RIW
LQ#Y,PN0M&G^9:0_BAL^gKI(8,/)#[f<E9/,(^D;TIYQU1RD(/@c4Cc8Q8M1b^]#
D\X\\XF1fM\M+TGRaXS::GFP</SaKJdUb2J=R1?Z0.VWNES0Y7;Q2CF=94c0TVJC
,3J2.)7P_^]De0CMQT9[Ad?]V.KaR[F,PTd+_6A1=UcOcF3g2.DVN1Da:S#2#2+^
N;6/G70<[JXZB:AUX&DQ#gfCP9,=>MXVS_O>&5Rg4T]^[NbZ^/Ra/,1L[&7TE;S_
fd>)#5E2K7S5P-8NNW3)cgT/G<B2R0II@Z3BV\RgW)P\4:7fU(K=SG?#C@+@X7PQ
bVW>YD?3:M6cLP(0gL_Scf2Q&^.1VOA&1NQ^OM2&O64&-G85X7I?ST_8WW.9JC^.
\CS&<N1M9LS>48I@,:<6.GM+XP6P.#N4,@36EK<;V-3K=,4eH(fRE4aeUII\^W?P
ZI9POUbM74dVM1>F5.J_V)77=2KTNDP?<OeA-G9:d;G38QG3SOTEZV:CfB7[4R[=
gBIN/R&ZD]F5Ef_;]feEI&37-;a@/4gKALL_>N;=JYR+X0V^O[](FdQ@\)YKL-@U
I4efKB0MDHWAXH<;8<MO91\0173D1D?GHV]d=.G_B/dGV[bN5+47eFR79LdOPa)0
GRDf>d\&f&eNS^CGPgU@L9R#4C+VZ2VH\2Q]8,.)LF=VJVSL#71gB=Q)7eN=a85N
UT+I?_/+:.P5<-B=4AQ4GYY1IY<V_+)PF3LF[.HLD-9;cY9;U1f/)aWB;2,Ad4/6
[8YY56c4DMR;ICa:(4J\[ed;TU17I3Nc/LPT<ZG@\NU;W5#<Ag=bNYKU6LD9C8)I
9:c_;<50e:/N5V]UFHgICYd5I0#<0599T5MfgI]IOTc<@@[H?GFTA7QY^e>G_/.1
fJAAbF@,:8Qd>e3Ea4[=,H,O-JECOL^0MX;QdU<2a_8/36=f4Sd:+?M2L-f9Q.2K
gM=3Q+J=C01^>:SL-C,R412R27(;c0GVZLPR)C5]c+08JUZ__/\N/.A3]A+QBA65
YRS::2ZOZ^X1dPPb5@=8fMZW_91QI7:N69=O^VC\]84B&N2G2)#)F>,W#J>g9]01
HYafC-0R=.@J.4M+WHEK^EA6c@gf&/>1T336Rg,JPaY)c_O0]5gWD=]DfVd.:OgG
[OJ-(g&J@_;a80[bSGBM@QbW1d[R&RPZ+8=;_?f>a<TCU(L?N-QQ?fDELSR2;&K:
C>FJ9FE56I<Y6W.S-.5:O,8I#PRJV7W511:UW8>9:aUI+:;f>\?cdBS:g:@9<bD<
Ka6AA<\&;7OAG<D0I\]_eY2X:_VA0V2c[1@g]0TD(/7[R<d3I2afOU7TZM?G/JBL
G0f47Y)bJf;RT59I<a_)N2/W>ILCE-<48HfCX-YD6@9eW8L/++b/g^KJU1;g/ZA3
f[V72EBUKM)eGf34\NTZ=f7eA,fJ-3f?LU0\XR5Ub16U\U?M.=+GLfDG+OHcBSJ;
.11R3f8H,A87+</T6/2W0V1UH-?UE/;;[Q;ET#bIe8GCI/)<O2;<E&>+.:5gJ/IZ
>F,;TK?LO\ScGPYL8#>F<1:2KOf@YDHJc<\HI8M5,gA>7a=ODE0#a];Z>ODYVEYJ
\QIMKa\4@3UUc):0\9d#a14gYSZ3M-,@]+=+DUWaWXFIEccQ^CaZVCY50b#4aAR)
ga=U<2aO#:d+8(SH7)66QdeJ:RSI[cR<+,1.:HP-fb^O_f5M(;Yd3:ZK+b4LS3\O
88\9Q/,<UOP^Q4<P3GN^C2_MD[6TVHE_GZ-3C)4b#91M?GIN50(?<Qa:M2+bTNDR
0->M]a8T>914]gK485[2)&[)P/-]FV78SePYgF1P4)PY0_ZgGNW?]#SCOM1bP-/Q
=^69NgGY;4]=:S)H^#ZX(.[e>]TOJc=:Z.:LN@;@][Q),QOL6EFg\DaQ_OZ]e=B1
Dec0UW0g.Z3-FFZWI+3V_O+:;bRb2+,Y0]dS-1X,S2:_dM8),A?R0;YZ^dBgM_gU
/.]AN?1f6G7+37^b#(Sg]>:_S=E5AYXL?NEBbQCb^6PRE_UCPRN#8Q)VMC]1dTN6
[WW2I4O>YbN/8:T4dL;6#OC=WKC>AX?DTg>;P#^N\.^WNeTXg11NQW[T(==7^80B
6(P\F-CL]<OFS7J1Qg,D0K.#3YM]J@NK,2dgE7dWOX.5VJ@[a14_]^2+XN@RO,.d
12OBa?EaL[6MeE##3F3B?0?MR#ag6XdB_2NeZKI_BAH3:9.>EHZ(6Y0OO-\3OW&O
/]FNGAA0]Z#H=&BD^5OJ\\9FG#UMfM(TE9(?:aC6f&Y>(PS#>T:3dK]&<7U/:0OP
3X@KHPd;F18G@/+DQ<]HXEg]SUIHX4CM,e=V?BKW_K:]6.?<@<cL=244ANS229G6
a7I9^/0R2DcQCfCPI?\2^1#6^a/KAdDRN_^>7@;d/7CJ[g/PWJ30/6Q#UVB)FP,,
7,(9MVdCKcS#\4,bM_:&+ZMFA;S^4H0NM=QT^IBa-4P(J0\WG\ZZ,KF38I].-]&b
&NYK=Y.BQEd0)5Te:BaVJE(@/f\^X;d@MDF,gA6@dd=LV-KfV;S2/d1g#3OC5#4?
\.+]9_FRIWPBVMb\K&0@UHN6(8cV[W]AE+&EKM]g6&3Q^V>8/D_1dY-M@/bE0KB@
OA6>EE90AagIeT&5SLU7XK.3X5VQg<W/S1U3>VXWN&TO(JAN->6N0P7BVXcK=8bB
PDK>7Se?1fRZHFWL/3Mb:+.#>R\ac^K>-e/9f11@J63,Be0?4e3ag2:<D.>g)^#Z
2I@T9-+-dIEK(L9@_^:F(Yef(6T[B5UDf<^AP32WBY48c(I[AE67^64W9,=e8A?D
8[99.QdD4=8b-[>#AgZPK0=^5RBPg6B4@S=38<.J-Q00]>-?>UQ[cE[M5UV++gEM
72R6CB<X>@dI=H->@,F@-SNTB,#/PZV<15<+gUB[42JL<D+35Y;K8;#/a.UV@40T
TcJ&DUG@W28N>M&[&d<e:SQ,FKT2f,R#;/E3g5JBa.0&MHRK79cJdHeWdTdJC0,@
@2.a6R8N=Ng&<W\MCWP@7W:H8M#82<Y+EM?CMVP_2=V^9?->d)2JH9N\O)H91.PI
//^I;1JI8M[\2-39L]8]B^3CafU)f5bUES1,]/I-(5(Qe^P,a2_#f96?\G0,LS=1
&,NOT6Z_/8G<J11(Zf6G3_0ERA&d1MM](SB2aSTK16[5U)]A6,0YP]f#MJLHW/BE
?:A#-_32.(97-H&3)[(([/Q4cU(\U.XU-HY2LE>WWYISA+#aN6U;?K<LfBU)AK,N
gD[OTB5V+73UeLY;\;(^8^0NYBfNX&QCASRZ[eXBMP=U)Z_^N?XR<,fH@@:dNZAL
)b=D]OH6d;F8#+a=ebL\1@OdP&:]/B3H,-D=eN@)KM]K_RM=[^>ObNGUDI.&X[e@
:KDgKT.DdIcBYFA8Q1Z&cG?9AY(6QH17&1cb4UW991;)WZ\X7OK36fG(LQ28J2\W
WeJ6^A.fgRW&:L1&]-#6_KM8GOf8MgIbIAbYKXO5=8I_,T5<c7=bMN^O13XXf])/
SP5b0[LX?+d>EJI_W0EI=+]?f,g[T17+3OC^.cHZ_WR=5_DTO_(AefC1aUBHL45Z
(;L\OE]Y<2:#-9=AIb+=E?f42<I9)UTbR>>X:(M<gRU5IU(][L]Y<1d,T1gAE;2[
DAHS619OE[(Bg&bO86Gf=)d/FRM;c5R>Z]U^.(0:^4\;c@+V22f.\?+gaD([4c[;
L?DbTP_^7-0=>;He>OQ]GKLW#g;2SW)?EP:LH81:GW)#b^K1=UKgBAgJ=]AW3OEF
GRP:A[@BU\))K+X+25cJ)+&C@(IO<^2OU]S83FAN/<^3>GSPdKSO26/d2P5D1Y@C
VeS2+M?+-LYV/eO;a6<,K3/72f;74NQ[BEUO)BOO@)D-7;GgWfD?K+1QgNFZ+8F&
YNTJCPCR8N.U[W1ZAc1OP[=X^0WLR=RZZ&D#0Wa?;05NR6HY+A22PTGE5-P;K?.E
;VBPD8caW+^BcY-HQBF/,@0G((Q;X>8fGQO0eP+[^S_d&g#VVc]:a/^BIM.SXe\J
7#\Mf7CE/.bA3:U7]8\^.a)1ZLIe3W1NPO_#PJ9<^fdTSQ#BUa4U,R)R/bHTCDU7
;,6dD;&[JR\(,<E]0ZVJNe00PO3<_;=K@QfUW,+=4;af5+/f/1,ULT/VWSD7A@<;
\9_[3Q<SQ6TUBcg?K_[DN[T^<]5AJ_K_=6#ZU^=HW<Ug8[5c;)+0G\g1]SS)=>1S
]+(NGeMIeU5+80)+EO.C_:LF\#(I],Kccg[Q@V#fg_^ZUQ>D9e(,K@40(;W9bHYQ
1MG/G/RXA(^40E4>K83Qcg\P4d?JRA1R-O#8Q,eQYedBIaeF?4]J&MbT=0a30UCI
2&:dS+O>U4eZL]dY6aKcd[(-A8ME=K^QDYS0dfB(KT]0YE\M3<[5Q8^UDCH?\d1D
03NZFfXH[.PW7gI3Ug0aDbC:&#[E,@9RYJR1E05SLPAPR;^PZ?[5gR:^B)b87&W@
VKVFPf8P@XeQ-QE@#0c],]ITZe5AEeV7<6:N=G\]+45-8_0Q>3UC81(03AYeJU:a
&63SR[_+GX_<&,g,NFO234C)6(FR48I8aFSK7XaS+C\K80+b\=P/>UJYFK+@/6@Y
cQ2U#X_K/2=&=A4W3b4#?XH;YAS-gVdL+T&gF^C[F,AOA/D)^,BYT1AaM^R/=<,.
8gU)ZR&^?6A-fW+4\.K=7^/51B_acKCf>\6P?F(08E\7:V6/SH>GLDW);:SB0D(]
a]P;M,Y98]NMW\;8Sbc41VL0?&Z>aH#IG]#d(?NG#:aIT,8eGLQ/ff^gGE(cYPXK
RP;4SPS;E1C22LDBYNAJdLV7C@DVBFMb7N];(CcbU+-ZQWT&@7EU>6^K=;Ub-(N5
<4>ASUFR.YIMgWK#FgWX3?fM/S+5/S?UL1A&dLbg11-RE0I>,ggeL9)1<V1Y.)>f
M?W-->b5-]K73+U8EJ1-Q]e0NX51=0HZ?0)ULE2D?L-.<U_>[P.\9W@@]84_+CA?
_R)ObO>W)XC_[]C)(;_B);feQ>gU5QX&CVW,Z;,CPN7a(#1Q8;+#=FcCDK1&8P[A
Z#53<;]G6Ye)BM)JH>(Fe<7I#YU@7[XJ/CMKC&V]6&g#PQ&FM)GG&8(LPd2W4)C#
6,1P1EV21#QcBC2X4MF:9.+0^K2D26LTFQaIKM)SS<#WZ;S;3EP\Zf?R<X_7(4LU
C>RS,M>-e16#5UQEaJ:Q^aYf0KDa1Y)HgNf3cRHXd0#X9(ReJXJ1e;J;&J\8,6L6
/BV=?cfQe>e]]G^M<JKS^>/deOAWQ^1V2YHQ3#0=+c]/1?I95#5e068AUg[d7IN2
)dYJ2:A5I)Q##1P8SP\bP^Iec0?^?J(J-.fEC2;C42_+V:V:W@[#PKMVcA^=IE/#
(.:_.@#IYVR4=+:ePZOJCM/TF)ZGW610:#LC>g+Ud#]K_dEHKM8;IQ\P_:X8OYQd
?e&.-BR5^DUeb;2O-c/>:VY+)KQP(5?\(D]^MARWM,9D.c)/aIb\9E\PL$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_CMD_OVM_SV

