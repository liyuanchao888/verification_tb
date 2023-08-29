
`ifndef GUARD_SVT_AXI_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_AXI_TRANSACTION_EXCEPTION_LIST_SV
`ifndef __SVDOC__
typedef class svt_axi_transaction;
typedef class svt_axi_transaction_exception;

//----------------------------------------------------------------------------
/** Local constants. */
// ---------------------------------------------------------------------------

`ifndef SVT_AXI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_axi_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_axi_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_axi_transaction_exception_list instance.
 */
`define SVT_AXI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class represents the exception list for a transaction.
 */
class svt_axi_transaction_exception_list extends svt_exception_list;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Array of exceptions, setup in pre_randomize to match the base class 'exceptions'.
   *
   * THIS FIELD CANNOT BE TRUSTED OUTSIDE OF RANDOMIZATION
   */
  rand svt_axi_transaction_exception typed_exceptions[];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

`ifndef SVT_HDL_CONTROL

`ifdef __SVDOC__
`define SVT_AXI_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
`endif

`ifdef SVT_AXI_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, VMM recommended "test_constraintsX" constraints are not enabled
   * in svt_axi_transaction_exception_list. A test can enable them by defining the following
   * before this file is compiled at compile time:
   *     SVT_AXI_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_transaction_exception_list_inst", svt_axi_transaction_exception randomized_exception = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_transaction_exception_list_inst", svt_axi_transaction_exception randomized_exception = null);
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_transaction_exception_list)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception list instance, passing the appropriate
   *             argument values to the <b>svt_exception_list</b> parent class.
   *
   * @param log                   Sets the log file that is used for status output.
   *
   * @param randomized_exception  Sets the randomized exception used to generate
   *                              exceptions during randomization.
   */
  extern function new( vmm_log log = null, svt_axi_transaction_exception randomized_exception = null );
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_transaction_exception_list)
  `svt_data_member_end(svt_axi_transaction_exception_list)
`endif

  //----------------------------------------------------------------------------
  /**
   * Populate the exceptions array to allow for the randomization.
   */
  extern function void pre_randomize();

  //----------------------------------------------------------------------------
  /**
   * Cleanup #exceptions by getting rid of no-op exceptions and sizing to match num_exceptions.
   */
  extern function void post_randomize();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff.  The only
   * supported kind values are -1 and svt_data::COMPLETE.  Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

  // ---------------------------------------------------------------------------
  /**
   * Performs basic validation of the object contents.  The only supported kind 
   * values are -1 and `SVT_DATA_TYPE::COMPLETE.  Both values result in a COMPLETE 
   * compare.
   */
  extern virtual function bit do_is_valid( bit silent = 1, int kind = -1 );

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.  Only
   * supports a COMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned byte_size( int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset.  Only supports
   * aCOMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack( ref logic [7:0] bytes[],
                                                     input int unsigned offset = 0,
                                                     input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset.  Only supports
   * a COMPLETE unpack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack( const ref logic [7:0] bytes[],
                                                       input int unsigned offset = 0,
                                                       input int len = -1,
                                                       input int kind = -1 );
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Gets the exception indicated by ix as a strongly typed object.
   */
  extern function svt_axi_transaction_exception get_exception( int ix );

  //----------------------------------------------------------------------------
  /**
   * Gets the randomized exception as a strongly typed object.
   */
  extern function svt_axi_transaction_exception get_randomized_exception();

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception( svt_axi_port_configuration cfg, svt_axi_transaction xact );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_transaction_exception_list.
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_allocate();
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: Provides <i>read</i> access to the public data members or other
   *              "derived properties" of this class.
   */
  extern virtual function bit get_prop_val( string prop_name, ref bit [1023:0] prop_val, 
                                            input int array_ix, ref `SVT_DATA_TYPE data_obj );

  // ---------------------------------------------------------------------------
  /**
   * Add a new exception with the specified content to the exception list.
   * 
   * @param xact The svt_axi_transaction that this exception is associated with.
   * @param found_error_kind This is the detected error_kind of the exception.
   */
  extern virtual function void add_new_exception(
    svt_axi_transaction xact, svt_axi_transaction_exception::error_kind_enum found_error_kind
    );

  // ---------------------------------------------------------------------------
  /**
   * Searches the exception list of the transaction (if it has one), and returns
   * a 1 if there are any exceptions of the specified type, or 0, if none were
   * found.
   * 
   * @param error_kind           The kind of exception to look for.
   * 
   * @return                     Returns 1 if the transaction's exception list  
   *                             has at least one exception of the specified type 
   *                             Returns 0 if it  does not, or if the exception list is null.
   */
  extern virtual function bit has_exception( svt_axi_transaction_exception::error_kind_enum error_kind);

  // ---------------------------------------------------------------------------
  /** 
   * Utility function which generates an string describing the currently applicable exceptions.
   *
   * @return String describing the applicable exceptions.
   */ 
  extern virtual function string get_applied_exception_kinds();

  // ---------------------------------------------------------------------------
  /** 
   * The svt_axi_transaction_exception class contains a reference, xact, to the transaction the exception
   * is for. The exception_list copy leaves xact pointing to the 'original' transaction, not the copied
   * into transaction.  This function adjusts the xact reference in any transaction exceptions present. 
   *  
   * @param new_inst The svt_axi_transaction that this exception is associated with.
   */ 
  extern virtual function void adjust_xact_reference(svt_axi_transaction new_inst);
 
  // ---------------------------------------------------------------------------
  /**
   * Searches the exception list of the transaction (if it has one), and removes
   * any exceptions of the specified type.
   * 
   * @param error_kind      The kind of exception to remove.
   * 
   * @return                Provides a handle to the updated exception list. 
   *                        This will be null if all of the exceptions have been
   *                        removed or if the exception list was null when the
   *                        function was called.
   */
  extern virtual function svt_axi_transaction_exception_list remove_exceptions(
    svt_axi_transaction_exception::error_kind_enum error_kind );

  // ---------------------------------------------------------------------------
endclass

// =============================================================================


`protected
@,Xa57.3<I?+SRfBVHXdd7=S9MP9>F)PRe#E@NNC[B6.&_+-6)7<()F<X&f,Yf6@
.7=KdUL9]EA[M9e1@dQYL78/6YE]5JH+AK8[B,0SS:1IP[(U,(Ng/#E&YaG=FR/C
8\GL1+e)@X0<:SM;>2><[U&P,YCK;=I6OG9QURGGM&)a-Pd/CPYWBM.[Y]K9D&0?
:5EI7X7[eI/94ec:0E1]]5(\;4a-CSaLD_:K8]cHWU&^>b9Y6P@BN]DT&WMC(]>a
eSCReZa\&]JBY^JC_Xb7f1\)\2E>GKM@.d6e]GB?E_X-&NBbFMM4GSG3,\;^R^1;
.\?McB-_0Efb5O@Z[K/NaC4U,-WO63>I00A.49E(dL/G,L0;Z=_aO(M>;U&Rf1g6
CM_@aO(<[/QXYD+4G@^^UPY4[g/;:B,#;ZJHaKU8XWL@?<>Bf=Q1.)QZG;&(U,U6
(>38(76:0LZ4Rc.YFI#GS]J85Z@B-<EI?,:^IUN2O(AK/+FU/_1#:.Bd?RTAe#;(
gBKf\2?aI))>T+I&F\[?c5f0-OIVJWCdP>-L[0cK(\<C+EK34g,eYQV<-a#]UdXF
.9Oda=U7^)d\fFFFFAO-Y=.5,eP5g&_;@U-(.CHAeDbIdQ_gA:FG2OMb@EgdG\?-
4;FZ)X+M9Z-?@X(1b\Y=+6W7;9-e1gaf@ef=QH6Z>U?^+DNU<b=_V#76K.?4>M4T
#Q4+fWg-e^#E_ARA97ge@)^,V4U0.-9TWP16N]R]@g<G2(8@GCFZ9O\#N).P1\F>
4<FXG@ag5-JR?EM0bc6eM_</2+<)b.1<:+dC-T]LS4USg+S(gJOIE>]MHMPR)fgL
BF<V4?>f7f)73GT]Q@D+;I8[g#OO;Qf2H-82WCV[WEc2#NDgV/1D/?K8]7f)ZWCR
5.=&^a9&IeD7(&-+c_g_,ePUX7;adX94f/6NK<^<>bAJF-I&U#;W7RT7JXZFc.C2
6bY.,&(>gLKd]cc/0a^XH=I\)O2;EE:6eDD]#f96OOF:>Ga@D_GQ>11ePeL7+f6g
Ge:.XSJCNE=\33aZbJ<.ZJD5O<(JP8+#DTbNbW2UQ#LY6-N0/5,:KR\I2_VJR<5Q
@VgT->@g;VTJCG9K33JWE^Z,^^BJb3/a_5<WD2#_GYGcO_R_I:VP;P58_T,P65_(
#Dg=L3W=c?.RO&X-4.NW1&X\\K@EL)@^.W4A1(R7NA,BHN9-4/QW@_-N+K+=D5Z0
?WMGeSKd\d#,]2WBfG.SJdbPQCLKV/M#CU:OH>:G.48?;(<?ENZFP9Z[cIXB.K.Q
;N^1Q<2Q(]&2O1/c,LecID<[Z)S8/bOX7bc34)]4d@,^)JIYZd--:^=5#&=6<>aE
5)AX<49Yf>O#2^D)8E<-].=JHf,D[/OK3\?1S/A]3Wg9C9[LZeK:)(19VMEATK2:
d(8X=2W0I.:^K^GaYGGeWWV-<.(dTRT41GJJ^f<V=fU_G)Pe>ec9[9OZ>K9BNXWc
C;I[N;/#A<&d.Z3B<U+D+8@TOS@KQaG7b(I-&(R:=;b0\S-fD[K-;aZ)#76B&DafV$
`endprotected


//vcs_vip_protect
`protected
H6,-Y0<f[+X_<(ZEgB42KgG-(<.#?QV<@dX:bfWFZ>,)E-D+/M>^1(ZG0Q4SeZ32
G3[#\(O<]X3JQB+1P--.V)E3L7PJF4S#A5eDUOFX9;e_Z3,+085J;T<#<[4SB:9?
cIX.6A.ae+E4)Z]GRPb:87&aQ4e27f)gQ)6EeaY./XCAa/Q;-<W<>>P5.<::]UML
+2eL#R1QTQS5c#VWFg8/-EK4WFb#[Obe+I@RU8NbRH=:J:ZO8AN,Qd10LeXf,X0E
@)bT^:VGdC=5=WaH;?6;[&JPg+04QgPVFQ),873J;_#De97fS#3]#F?4bZde<BW]
eb/bd#<b4O<V/AC2FMX]ZAb&#7)\1.\O,M9GIYK.Y65#)0W?9[6LA<47-SND5RQ]
EN^f(@OD?L_Q;>@[PH5YCSUY-&a0.D.(5(bH6(T;4@/F>Dd?)1WDTV/M>#Y.d.B4
Z1NW>(1ae?S[GS3Ac\>QSb=&F#f(;)Z,8B(NS>05Qb&R15J#GP]dI>f:+3H1</N8
gb&PC^<H^e)>c4;<SW0JWPUU.ZI:):[FSSLBHHCLb<P1&2,UWPUf\K@M\gg/Ja<Y
c[^Faa[a6V&b^e&d#gBdA)/IV?_HR__SJT;#VMTHXPI?]\4]S;;bQYJbJ5(-:7US
XTLb0g2D:5=R,B#,9gXC(-^(_fe#YYPc7UNJ#><.E(5/MQH[fcZ0H2Dc]S_2M\)M
A(O;?&g&=2-/)B[YYVFF_LE&3?7RcQ#WT@A<b+gDJbH;0[<N&8cQP(537C4?DB2c
12O,(/)[=71c9+Y[ER@+40^JaA)T9KD1LWZPf^Tg/(\6,Q07Z.UGb(8(-C<EER?W
d0d2VG1_Sd+e=?[\U&S3CL+E#H3KN7N]FWZ/[9>?=\ZU_ceS5[dCH0/?#=@fB5YF
#)TQYD\)Ef=EWa/)YK;5[=^c&4N9H:/<;WY,3@M\T+<C\5H+,VPeEQbg^-F<8cWf
O+CCgRc-:3&cL];S3GP?1ZD7bART@&b0<1.QEdL]Sd_]^@;#:R>fH60Y3OA+4#(g
LaX[JTaKP)6b1P8O:IZ)OOaZf:8;1(Qc<J29U3;)^;8-@#Y_)JYa3a&A^@f6J4]A
-[PL21,a:X[TED4#XB]Hgce&ZAUD,aQ=ebFD[fX=-<_g6^=#U]62@7(^D2F3BWA7
]<^.FJ-L/8O]CNFM<.I?:\U_SW]4I;)A6M1?BJI_U5P@:>SB]]LCB?P;;/0-&F;]
2Y2[\CA6,6&<ffaF&+D508--\>#fgEU_bMgg:3D_(fc6-bQ\4<b[dNZO#)QG5V&R
a,P5<ZRaYZ7@=/RT62:BVe#UB#e<:Ze\c^7H8E];3Q?6,g]F1.8>>0NM#9UJaG;A
g[2RFD&,YX?,Jd;1BCC<NHB\GP9QeCW6/e?fKS?X^]WVAU.;Z;[f(eb?#98O\O#U
La3_HP64Pf5O.5_WM;W4H-H8A6eV+.=S\NPT.V\3dg[e=3OMdXP@?-1?5E?U4Ad)
>8,([UIK#-/&D4PP/J^G>YH)b-LJ?6C>N^A+(5B6)Bba=dA6Z+2>QJ0^<U82bBWa
)X@C0P//TNCCgXbaE@OCBZ1KW1:2H^4FMWb8H3/W:IK^4^<[-3g(CJ&c05H&]7IB
<#]LZ#=UP[=_UT89Q,HL3+Gg:fR&Q[KbY7)W58V_FXHCM#Q)a&a4gEC4N:A8S2N9
N-7fR5DT4XX?O-7)T:[P3VbJ&VAP#5RN8]3W2U-05.[CO#0XME&V&Ve>9W<46\TN
H4/##UYg1SE^,7WRY[DeT:X_ISb.WH5-;2Fb:/5/+05QbCKU:SH6Y]Mg@Z7eBP1P
,HGdV8.>a^=?4#&ba\9TC1L0g4f]>3XT#aEP@_PGfe(<_U;&58A<f#O9BQ5c^E\G
9<bc6J1[g)S5VX=Hg4R+^3^WZ/O#6P3bbDUAOUf]fCPV.<fQZ9YdE+c@-(6>c\YL
\+0-<6D,9U;aOI+3gU_F\+]F)16RRY]--EC=]?3+gJ9GME,;8[d+3(fGSN=MS&U>
:dP-^.NM^R@V/5b4;Y:UGR?L:c,aC[;eO=A\_;X]2V<[NI3+#_b-d4PEdFY1HR.F
a7:T)F/7g+D>-fXSP+V<]ET^Vb,9)L:<\Pd<CF,X_0=.)]L(TX_41[aRM9&.S5#:
EG)2I0CZ2)KS6UN_bXU[a1g@6XZg@-<eJYG&d4705e8]d#&9JZVdRG?<R->PDGa<
-e?.;USKZV3C4Z;aZNC3284V_2;X,1gD<^812AML/K^1[..fWIX\/?ec^RG;(/LB
-QQE0X-J=?Db_-fR[fL(?GCKSFJ35]YV+3]=E#GE^5\b1?4ZQ.6g7F:0JA@?<WQb
Pg&JC+e>,c\U(@JB+5TfC(S4;3BP<(fRE<T,+,5F+:Y#d?)\R<Md4P.D#PGC,K7^
Lg.f/3:8/Q-7fKT#(YTU4(W1bJ:#&gLUeUASDIA8I](CITc.T04NP25Jc_A;#Z>\
;:4OPN+03FXSM(PG\KO=0>e/,<JBHV##3K]aBPWZTFe<=V5##62c[E-Bbc#Pc[V.
C]5]H;A+F@5gaE+^.3PRPf/3[BV[L6f4FWbA&._cLdMU.2Q(5O^0[&gFMe8LR4b-
)RbT<d;QOVB@Z@R,,F+f@XP4[0(S]VTC_-fTbB[4b/Yb[XHSa3T?Uf/W2b9-4d.Q
,E_?J<5?.-@C/<.>aP5,N&^WeV&\,RAc&:P,8TQZ\:Y,Y(W0[F<V9U](Q-Ig0UBd
HEbKNC-dgA[.6QO<Y-W))K1UQJ\\<>4QQ#Ndd[A3cV)N67GUT:AZb=B++AM;R2fK
AS\c+O+UY>_2X(b/Q0Yc9gIa86+3_>=5AN>cO:1e.<_3PgBJG;Ma2OD.d=BI[XD)
+?6-BI_D<c275P1gRNgGf9?R8U<PWMBe7N<&:5;6RD46F3\;Cf[1#^#4N30^W9ZA
GF84F7R&d[E..)QTQ@c>MB.?YVC5c<:(]-E9]UfC9RC072T)P5_\H_&/W&M6Gc7#
[:3(/V5JT()@;]MXBBQFgIL+8&b&Cg>ZE[@f6Ff(I.;3GWDeQ^fKD?>F-RdM_99E
cKWce8U5,(ABSSMOD<?K#99+8.&(=b.Y,7:d9WOZLV8M^;g@/(_>1]F]^^bfRIN\
P?B:TbO/C_EV7BPH<-08U4N0L[?YB69C&ZEVVQRH(a=7b8UECLWDHC?D,=KKJASd
LO6K._VLCFY[4F,b.#E3a&&3FOQ:T=e.B-gWXd[,ME15f)^c<>e^(//]:Qd]LbgW
]^GVe[b-H^STK0IVe5]&-T/?,:RSS^MM)L5.eP-\H(V9,O3.[b;[S7#.V]I#_3g=
W[D<0DM^c[+Q>1S,5FC5+D<[#==#&;LD#5PbSN8If#<cVQbXS&GEI78c][PUf<O@
V(g<2bD)f_N>S6fK5?9TSIH>ab_b5^0#/6LBL]KHQL@-Qdgf7OH3\E\5Q4V>RE1P
&>7<b;VYX/IWZb2L=T;90;)@U_b..XSA[UO[ZGLgEU6);<X\_9e&dZgXR5fP?+E=
,M]W&DU<=Q7ZRb)=Y>VO0DJ?gB<01?9(NK0FK42dMXQD7?K-c1S\Z#F)D42a?L6b
bFe+eGeP.>)PgKJ#>,bEgM3.-e(>X?AMNa)\F1]Y<;1F>1P3FC=H#g+bMLC,./:6
><HRD)_)g(#A0MSM():RLQdZFC-Xda9DK;CT<cYH#<Zf/T]/^gIVcMFW#J0.77EA
&/+@)U1fb9V[):YWW86PK#Of)WX@>-_c@>C)GNHO<E&-/MNU83(QF\2&U(#Sc3D\
bN.Z#;2.d0/7W6Yd@a[.1B##/I,Z?\-GN?=24,=aT_Fb[e=]91>HV<aQJ=d@1]Y;
OUV10\ZIP?L-?e:@aW_(30IZ=AA5Y.X_WGPQL@1NJ#/S?,CQWO^GF<@<LFWJ>R)>
6ge+A#ZB@-OfHK\ELYDL2^0##=V8IcC\1DC&Ud^DKWf;&Oe5gCYWN,=2K>>MdUg1
+Y>+R,T\4eXTXZ73VULL+g#&fBI35f_fA57NIcXe.\E\5JXgMR<a<;#A)P,W:+&4
T@04FUTK6e8KQ8cA(7RJ[:Z.?P)RBBf/BZU2N+aVZ/M-IBM5WS3a^QF>@@VgdA:B
RGEUd9N6CHS?)]7:K:e@RF=f?Y]2c\)#BJ]-)8eJY0eAGY.SI(?PVN10W8GSH(5J
cTd<:<3WC^K)RP8]3ON>ZRec/X3a]6LXU/,88XZ-OX6MZ)S?8207f:cUA[W18[QX
8d,dcWGS>L<G?/-PWLS<;9IC&Gc=&OQ-80/BY=OG#)_a9WHAF_FR)(&?.E(,/+Ue
U,+D,(O7A,RPWJ@)(R;PL\cRDLHaJ.)dfG8Og6]\W8>:GBO552KX.N&5b=#bAga&
KA(Ve=MN&<aUJB+\;U/9Pf+c1?4E]WJ\efA&KQ[/KJ-;\(@Bg<,HEKQBW2=g\dWc
_<?[NG:c(8)&EJaT?2M_Pab-O)RbM(5PCY?S+A9D:dZ:U-GXYR,,bL<5QN\U&eSG
e2]&KM51J1+LHXS&T4HL/d^1\-;ZA@Y_LV[.6RU?2OJH,a_58;)J^LbR98WBWUJg
cDPIE46Ve96S2c)^-_[?FcG=[,=R/4AOZ^b4L_5)R#]Pg9^YH&RT2g959.B;/?/K
fHV<cMC,^;I^RPg67@9S/(70aKSYNRJe3#MOG]fGD7LP#3-YH>Q-3,\X)Ce&+-#2
&<8T[dM5U4;[V^4K0D[Y,^5B.I+FWEf5@JK^[)6Z=YS-dMIF>)M:>WC33L9BB[9P
HHbNdI4KLVbRSS6,0#,b]dH<W=;?5G+RRFVf6,.bX8ZBP40A6;LI)JK@9WKWC1J&
=SeL#+>J#^M;D-:95b672.&E7V^-NeR2QF8a0O-;FQC.cS#TBCJ+OSQ?G-QJD33X
J,B?g4LgE3>D<3Td&&C#0Sf:4@b,OO[+1^3II@1bJ>AP1EDdMe0bNPc>BD_BM2-,
CR/N7:f4f).JZ2IS9KYfbU6N)3<S6#D?8>]RKR7LQ7/?a@9;?/d5U+eW&M6LU[U?
;5L80e(P551RS,_M=PC1SQ4gF_.OG:9D(ZQYSLLI>a_?\RA0#D\-]W[9SXWc74fQ
[EFHG^Bc@=>6-A8S/2JMG4^gSf)IZf<.80bYR2E8E7ZdL(1\71Q4<<0D=I2ELF:X
;42-I,\1ZS5DX@,<b+5aP-S#0DU<O+KUa+T[HZK98CIfQN;RF^LUUD7:&W+G&f11
A+d=]]2-QARER-241,B-0X@4ER^]68@_[M-+D5C-1cY6EM77_/2VANe9N>O7D7b1
?120EQA):b;1OT#QH&6M?.J3>b2Q5d9cQZU\fc]XH4B(;aAD=AC4K5Y+&15cI]G,
>HGaIA8H[S#?FD,FN:?P#<&A/)_8,[WC;ZDb/&O>,GBQeB#4bMgFNIR6>9)#B/V.
1(QAE:(\c>L:1AT4>fe[P72Jb309.W-^1P435^\RXa&g[-+BTR&U.L:DW&R-E7:U
aE0IV(B(Q).NY^PL/52;Te,fL[KTAIa=6(B-d7\?;F+:@VUTB@7:.Y9E-VFK5]Y5
[;&?KW>NYPCd9d^=fg=89(1XR]@IC];MUO]TDK9VJ;4ZODf>>,O-U]?K\FP1;M>0
,09_TDZ.2J,&V<SCUNDD=@;U-N9>#/Sd^f=8DCfV^bF+&^2JR-2(,Z[c(_#+K5IV
9aX.8<Y1Ua526DI@+Fd^SX5B4B@?H56gD:6dc.cffI;8Z]>F>/;AaH2;J[=^X^d@
/W=#b3ff&V2V7H5J?[I0_#;QL1F[#.D&(DY[a:+gNY_CUIY91SUJgHISZYg8Xd8@
WNG?OV(EcUHfU<=dW8GFJGI.Jf]U^aCTT3?,S-(P=OL<(^62(<O[]@?6A#^:Z;0d
abW].cePYe3#N(HIJFCRVXfYOOL7X@5@&&L8BQ454FeSee>\8T3:0W3BQ<^EgF#H
#SC..:T\a@;4,&A.X7-+Z[9GedYgZTEPV#7C,e.)3L?F[CK)),e)I:[Z9ILKg_fc
@e^A7J?O<DI=<_&VGA8a/#_BFG0E2VP<b?H1;@8AJf>WX3UBDaaaOQQ^HF+W<G\f
=9H0AMb.>,2,MQPP8W30L<0JFEXcM9_F\>a/N/IfgdVB0B:4_F\4?c.MY;-_DbML
eP(.TQM>5IH.1&bRVT5+S&HFI:94L02^5V,\PgQE^_gC;^eTYEcC<Qd[\g>gZ5?/
7DeV#A,UI.Va[54(@.Se>Vb8f4[&YY-YH=:ZLC:7a&#(QG\O?\MQHU<>[FI/,Me:
9E5HBX1R?=X.@=d,Y#0A=7H^ff_,]4VaW,IY1)&X?4C,b#ESHK)CcRR\P@8:-[Dc
3GPTC(a2DHd<+.6ObaL:Fe6[.<X#aZ?:93-X5L+&#cN=F+/7b8]WY@[a8b3B1bbN
FMCF:YT_5g:6fY?b72Gb/P=/\SD&ZXdQ(YFWB428c-f):&V6J3)<J4XSgAJVH]Cf
9+]f60QWQ&IOK:;;@7)IcWd1V37#_[9S=F8agC7)RWOE-ZLYe2MFS6,.d18eIC?d
S[JN<0bfH;GIR2S+CPff],5#BW15dF.R6M^)N;a>0[a^GI<6#+#LS>^)&7C[aL;0
fDbMJN(E9C-YSf:;V@cea22J1WaHf;]a#1d(3DD2/?^G>=S?RK=KAa]RE]@B1g[5
P32bgAdZ_3CXGQ:6HDfgF7O3d)9bfTHH0<&.X3W1[1_(f-Q)C3A6,5gN>XXd-/DY
9&]S;Wf)[d^)BHIB9#L.aL:YG2]LJ[(,^La5_H7@HPI\0,fHZ//&,VBVfb:2C&gO
N[IBDfa1CSPH_1HX_<GMK1KFGc59\S?Ia.W492PQ[W@#:;JSVRK1Bb20S]MD_L#?
.-]F;E_0DI9Qe#^R<Q#F4Og4@WCQ&&4ACTRBB,E_UG6GPG>QYA?1ZFEVKJ[E:?X0
1XVJR^Pfa1c-S/Jd6EKe6d(2.@XPc1D,d5,2_@7e5)&T3-[6(b-&^0+OS<9^c0:=
5YS0LHXPTfL;=ZXCJW>3D.,E4K,/M^+57e;+S70XfgL\bH]<O7A4=4QTQ@K-Z5b]
B6a^=ATR]FQ.Hf(:^5@4.g:A&&1>Qa:,<fSS0_F,a82/IDSOMPJVU:AVNST-TZLH
/((;cM#/[VaWVKdT7Pf&]0Lc)^a\+.;&:XMIW\DIQ^#6f8PO:T,<6PK@46IBC[XO
,BYHUZ).6MZ.ZBBX]eBg&32:59XU3Q7JI;]+Oc)f9C7Y/J1O>(.#J52LGZegSX0>
d]B6b+.IPa5,J_gJ^NJ3BZWSM,1a\G8>dJIagF-QMI5f^O3YI]65NP,OZ8;1RM:C
0)51=@(YAT5#_5;4EJ?&8DRA_9GKW3:Z1\HN3GcS_OBZ9[Of^N>a0,A9+F9[XU)S
\&9cFb+I)e1^8O]d)<Hc^M-+:F:8T4e@QENI9?35;SgG;-3;4(L3-(KXG34YOCMA
VfZ/C6EN:CX[[4aCDFGZd[<8I,dNIFeFD_YS^f3:Y@ae+S0Ka?4_M(eX:HH=aV.)
FOK#Q1ad\[6N6DMHC+7TBF]YWYJ;7^_7WDB=9@/;Y>f&aX7ZA5C3+L(CLE,6gKcU
O)_d^V^GUE(TFY#VON<O0#U1JG77YP0E)J6ICT?@;<a8QCJTAS(2.7KUWX<QPCb]
5(-K-c_L8;&fB3ecgPQMDAN[dDg/<^-1LT[UGWB?]ZX,H0RB.->,6+?-Y78B>]LN
-c[)ccV9X6P4P,cgORd^/YHOCKb&Ibb<2B=ac5\)YAcK@&d(aP1MA_1d_7Rb/235
ETWG6I\1UIMd,6ee2cQK#DbK?W6N;5#a;S[>1F@C//P0JZb[,cC,eX8R((XW_,^)
+dMXLPBA\YdOD\M_@cVZ5GRZL(X#3JY3d.81eJNL9C\_LEbDC0<7b?a+8Z-92E(W
cB0\^,77=DTTAL(/N;]b+)0/XZL1B^3N;-?8^BQ>;X:(OZK&YQd=gK9RM<,,6[QW
TY9L<H[HCZ/D\8A&?)YZH.<R6M_8[c]EMFH\#\KgNdCUOJ3We^[F1#b/e?2GF=Ng
c=D4S:SC._WN)[T3_B:\::HG0(2\(JGU]\0WCJ:Z_cOI]c2U>CW6X=ZDIcWdERDO
5U(7_OC<ZZg2g.X,-SE19&VA\R]KI>e66.;X[P]-d^8<V<:G4f+91+Y4&7bH(T9O
,b&FE6OXAd;J=fb1=V[0V/[UEa#3gcb1aQF,.+X)Y.2]IO+_P8df]ReE@0QccZP-
-E0VKJX^5R^&C1](XLe,^3^];;a^Z8e+1A^XCFJ,M89aMDE?\_Z0&\\(&f?0B:fg
V2>-N34R&@HgPe\GX:WF=@M8=EELEc18F1(I]\([/IGV88>&g@UU6HFJRY1C_B[J
BUG0,CG@C\<\OSY8/&2gN<LWe7Mfa=b(-W-^;c=W7>/1FK]0(?KBZ\8e3V<ccf<8
V&8JTM)BM#]_;E2B(6V/0>J:>6;WGfYDM.2#eeA-J&)#YEg/5RNSB>FNQ<1[]TeA
Pc@8Y?23(P?ED;W[>3[[:229-0;,-D8@OC.)RA:8@/;[K(eRSfXM#gY/(RXC84Y/
Y?eX(;AeEG1@?aHD0\dNV7FaOAIFRNbODC#:YCYN8C@8/H3^#L5RWY<\A+@E1;<)
7;:I7/G\IM:81>?5&c^U_2B;6S\P-6@)A&(DA8:Md4N?N)a;MX;?WE[+I\F(^_He
01>ERHHM,Z)6-YFTCFX?B=+@Ha>#JS:BOKD8ME2MQUaA,<MAgPGZ-+.TC1?fCGEQ
=2FJbR:21.NfH38S7LI87K=gKR,?#>_P1\]>LYa.<+NFJM3(a23:Z><U,KH[YN@a
f<)XUR;6af5eYRF/^/3D:/^B.b+,ab^BIc:F=a&IL2>)/RDN^9M1D7R7YK3Z@L(>
=Re624T,OCP=##D[C.R#LCN7.AZ^4A7F4/^+(f64N47:B55#SC(QW)1IQB2g[6_>
ce.Q.D_(?bF8U4E97V4RRWPC<ZRY@Y-3X^NXE&I=L+FL7MLY?c5#,0]_MDFMc)SZ
@0/97\8dbSe4JSS-7W<6,f5a\0E(;GF<e.[PX[f;;MD@aI:[[bPJVX#K,(ggBd_4
H673LI(H)D.TdXD=AYXbO>E#+L_YN1:Xd.JYU4.e7\EcT+8,?dcaN6d)+8C\YZG]
THb5_I5<dV?E@2\JWTT_TQ?>8P#SC-SdXO<4W?]V:Y:HMLKXMW\g5#T&P.A/_dO+
IM@&M2I-Xa[M?;<;FC+f.C-Pb_+18MRZUGWBZYAGJ:L@R[E@SC(R0&KI<O3K&-5-
)HGf@:^O#SJ\]g^9>-GKX14318]3:aCg==_#b#bLGR.0BH><PIc032/IXI>./>.e
5R/gMY<9a:d>V8-aFL;(fS>WLP0+?[#I0f.D0+5f5R3.&d2/P-=P+@=a]ZF>CANc
VeA^+d:62LD#P?TVOTB<0_3Fb2?SM#Y^XC1]=_8G8CY8+N=7LC-]f82)]IU>)/7[
=K>;Oe3cQ/?4+AB>WT2\OSF7.NYbE^^S2Z^E3.C:LG</0>d1La;Q[EcIJNAQ[IaG
H.LDc^V<S]7J.()8e/cU+?>KNXEY?]N1E0558556\9Uf.U74cff\1c+0C5?g57:]
aO2778-(,geL[a?U8VF=<aH3>-K7P<^AZ&>a(3TO<Y2(AfFU<PQbca7]Vc&UF.I[
2G\A3O5-MSK-^RdC;+@6#0fC[A[HL&faO=1b(I(;=&#J@+-.,(E<BD<O?fD6Z-)M
[7SK4JU2_0BRBW<D+K.L?DKF.HM+7)&I8XLGS?_6f5Ygb1_Y9>GI64+4f@c]=JK?
;K2+MFAdX>I;8B:M&#Be)CM,,:&/U1NeW&6,0L?1KeRO-UFPD8K8\eKAN91?V\K5
Y.--[?c]F#);JM)]Z1J=Xg[;_L@.__Z7cZU=SGe/ZGF@G:O@V4+GO<aMJ1RH0^)>
@dLgH.Q41Y_=(CgH?/<A..<+[#;G(_O=UONUOQO7X[U0G22:.PW?S-,,gcDa.:DA
2?#OJ8Oe7)b^Sa?RXX-^ZdP_0.UP(+J-KV7._^JKTd.6c^^J0GY9?^N@82g/S:e2
ddUSa&-S.+QQG2=MAfGCG\,5e9V=<ec4(]?85D<15X4O0JOS,eZ6:A45BJ966B5#
ISe9X/PRTN0X\@YEd=aXd+b<]Xg/#9V:ag-O^0:TWZB>OegB8]VAgZOI:efOOcTg
NI..fWR;DIZTQX>KP+Y@_B+CA2B\&/1>U,2[SG<2-4]d\HE&,1MLgK)SZ12D=)aQ
5)7F:a4Ea9&<EIV/)O5,GX3Gf,-YQFMVeMR=M;CM2\T=]+AYGKKe,?&F&YIY@?P;
WFQ/120E\-DVIXX6+:QAJEQ8K/3O&>TFBF?.M7,@H7B8JC2=8TSe^O.aP+b@_9\O
M(5V<00?gWU#:49]HL4\MVaLWB[6X^g#1f:,?KC530IM]E])<eDD<(+c0WAX(cZY
>W4O7RXN8-+b[5\9Q>KFMP7/XYdC2);UaPKF.8<L<2V]E0]>WO=UWT5[fNRgTMZ;
S-3O,9_^aL(2T=B[LQW)^0P=]^HJP65cUHV/A.VJ+0MPgD<N&X,_PCY2V(M(X8_1
0@\CaeCf29279Pa1D&_-]=QH^(&Wg<5?\eZe6Q/\@Dad3/1d.eW(NAUV4;KeCBe/
eRX\7dR6?C1A(,;H,9,.,^0eN6K=5WXP;?3,/M@dY=KLXJI]YFJ234O92cKR_SGJ
R37Z[Zf0-,;(T3O(.5=&<P2AWQ;I.RYVG8QaY7#=D68fMcQ3###D\EQ.MY1Ig-I:
4I8bU:gS>d5ZCa_5UUHCR0D>ZC9Y9cMb3)c0U09SOOJ4M=JJ3^#Z>Z&=6SBB<T.,
P\\^.1)7e6dE\RT_6G2f036/2VT^<48R@N(=Q7Y(9-P^?6Z#c]\<2)S]^EB&B7[J
TH?ggIAXSB\(a3C131?SSAf#\1DE:ZB4g[EE<NBRZM^\,FKbDX=(;AVAGRHP=+]:
MV=-[5RAJ)-CeB[ATcc45F</Gd&#=,?,VU?d:bYX)TbC=fceK,4=)_0Q\9\HE46e
JN9b(Uf[:7L<@63ICSI<#XCNT=K3\S1BT;6N4M0LZ=,3GW-;XQIM8PX,]3Fe+6ag
]73-,51e6UMT=H.fKT++YIb\E;Da^8QM32:1?2N:W_>>bC_B\ZIM\N6NN>^+NTQ+
CLUP(UfEEG_cLa6\aKa0R<SM:4O;e\Sb+S#YL)fFf2H+]4[]2fgeV\Z+R5gbZRYI
AB#[DbC;GJZ-Y[,-Y^,8Me0HJ0\F-5eM3-:Sc>4F7_^Z4e9Jf\?@ZbVR8c4d.:B(
&BQ#Z](@K@AS8b8@GRCB8QX\fZ7T>WMQe4T0.CKE9S393\&PR=&ZSWP_MJ]TYS9=
L9?=0A7(Y1\(Yg-a3#K;<^f,J5[INRC6Z5BO(PIg__0daB;.gD#a^HaT/99fa,Fg
Pf2D5EY2OO<M8C)Y_EeLRJH&M3EXLb=,63<6G52PV6)_cIbM/,3>)I84^R.aKC<H
-PeEZF>)@P][16Qb,VcKL<RCMD(Hc6+2C\YW7U?N^,9,->b&V#KbOcY02&W(.>7O
/561>^/<16GM71;2/-TY&6YKdK\?cW=7D0_;gJV1/1D^@GTCBE#+4E-Ye9[Y[5U+
WE/M=\1O6/<>2fIZSaVA+7L#\aVAZWF]JbL#.I0@dHUV,)].5/4&8\[6IF<#&&?F
?>b+R91A6)E6_[>(M@H5@E/)TRaJ>-XGeR7G/XE-bS/P@B[/&SH8=&Q:LYc^#BI]
e>gP5A:;O]=+?ZP+A1cf1NJ1>9T7PgQd?.[2^@CDF7)PN2ZQ6WD9Gd:VSdHMYO7I
A;+;7GK5&D=6_a<?7>AT)feYOTBGYI.5C2W+I\E6;Y;C;eZJ)XI30:B<^I]B-D9G
K;@T3=7<K^/7)Gd\K+0\U0ZfSWeA=3?[2I2@<AN]<OJ-_]&)8\VANPR9>PT]YNML
1.HQ?=\-=efc?g[6(1HF(B?]25FKRe/@T5/(H<)He.&gH@MZZLd,<]-5d;-0<B/_
/?5Ca<A+^IYP-JBHESM3b3K,KdDPG3S;?E;9=5eL^(2Xg/MQLX.H,[b]55F@c3UO
B/d+THc;S[QX5DNQ)=M<b]U_;)cO;NW4Bd&4TDS>=/IBY4_^ae0#J(O5@G/+XTU3
G6\+HL\]&EH11ZMecJR&3VJf83UPSFN?QU(N#8?KbQeb=JeVO_I_J?;#RB7+d=2Y
8ZD7b<M-A6e.,L+OZ[BTM;7D=.U@02&1UQR+[C?Xg@@4K^RH5CMN6?_:8E(ZP,&8
bd60S-,4CG&O#+c^J_IGD]F[4L5FUQ_?3aEfG6f[7/eXZW76I;[O60:cA5/0]31L
JI(+?aI/HO@^d3;U?#=XH-bD5,#\B3@C-fM<NBCLQM#NaD0gU^3?f.b:/LP,PHWJ
[V?2250_3_FdRC4;XDPSV1<&:6f9K&ZfQ\8cVF[Z=).U^Uf9K+]Z.W^7.C(:,1N0
VWDdJaN</Bg/Z&0d28J_[PA>=(HC)E8:?@I(9I865+Wg5+8/b2:Z@gdP_ZdV9bJ0
JVd&;cS#9:O#K]e8?NEeF0[JMSL-/FD#JfcdZJ\ad24Pd3QcEdQ^]a4>QOK7[NM8
PW@G7SK/S7OKRaVZK01+a;g6BNP54:K<0Y#8W6Y-U@8&.2\__SL^1Xf]W.@U=X:8
<=8,D(=5a0F>?C[[FdK^e<8NS&XVA^0:bI6aGQf.>[I/B37N;046479,bU8f+</H
IP+(=aR,)QB=+?6]/\X[7_UK,,\J<#S=9[WCUMYBgDW9>Rc3RBAZQ&,/Bg)3XYg+
Y@CaIIa&+/dUD+X]E-EC[NIW=eeGABT\\&<PH^XbM2IF7-M5DV9a001.f./I/=W9
CE1_7/S9L?YY@6\0[\Uf8]Z,HN@.LHP4+123?LYfC)fNTG8<EO(3BLTc0QY#8de1
6^)\3X2J=OB)5)4^(KdDBD=Y5aO&C\^<O@&D3Uffb<gF_Pa)RWAcU[aI;JIbTQ=<
T1cN.0VOG;V^0I:Za3b\Q@@1;c(G;X[.e-X;I&]FV+R,]#U1IR+Ya;+#0XeY.OI4
Ue6ZW:@;92XY<Te+O6./@,[N[JWZWK9aX-CUV>&JBH&#gc:VW:V-3LVZY1HBBO/4
[1YbUS;=/19ZI3X,4d211]/];P;a)43S0&TPGOZ/O=7M<IFAbO#P;HO4_bfUaYNW
b-S3=\^O]UHKHWD0&<Nf#X2gY>=;U5BefbY?DfJF^MaXJ\D=+CK+^+Wc[=5CGAAJ
fc=Ec\T9J1a29&&]6UQ,P1eLcc#(Cc?5H(AE,N_Eb=(T1]LgW>N_Rb9YH9LcN[_f
W#4-O<bXMfbHA.FQ(U,<JKI_9XbeVTDA_CSG3=H/R_g1LU-(=QNQK1,J+1=_^VW+
CFY#=0/>_PHdC,O@ETR4UUJ_/gZW]Nf7Nd[c/AU\WeGNR=>V8f@4(O;5Z8[(<LUG
We,#70S8D)ZPV&cQGMD7QF][gY#G-RL<ZKWG>\g-5bYWe.X(VVO?CO.3b@eH:&J2
G[TX[1^f-]XE,Q>;NI6G1I/2DfO_c[KdWUG)/bcb6+[FP;G_cB,ScMC35^;#ADPC
[T]#)]OWd)\e1X11K(91<)4Ifae+EO:5U^#63BY?g&\Mb5^RI/;KL0+(I,/UUT#;
69[TWJ341HG=G>2F.?@2[76_/YS]P55)X&c:CEF&@6GN(dP,@:_fb]?fYK5Q#I#I
6Z:\1>X.a@1gV5>eM/-f7TAR+/V[:0cRLFUWMQ9ZTWTDNVF9I@V[f&:2eB1<7:/1
N7f^U1IO6[;KDDDCIWJ,6QD+536GX(U^<I0e4==-FUIca4a:5fY=LH5:7IUGC:JU
X/P)EcQHMAK0T^F,:U?]@R-UX[=/XJ=;\>HL-Q<f(JKBGHS-b5cf#@7\2;6fbg?M
MY)(5]e?deaT=ZA98Z&K)#9B9VKIdE2T@N_QG=ZOKB/38.XXOQP)==f:A<XdT>RF
H5U:MRK\5gK;WX0<.V\Sa#0#S\><1_X8eU>U[ccW[e6a<#+VW(VOG-2G5HDa^6OZ
Ag5[fH<GRZ&Q,5H8[FJg4:8P1>OG<B^A+@V7C/e.e57:dffZS-IG,C&^2/3E[C/S
J6Y]@PIEGSF],4Q^P)[TEUD+4.WR9M:g#<8\/F4\.EG@V@/+<TfT7eC@AR/4+cf;
PeTNP+\FHc8..+T:+^VA4#ALZ_;>dHd>0M:A0;X:3CfJ,_N/NQC(F2Oc/01K+fR/
dWY?].=PX=D_:d[dZIN>;5V:2(XQ\7&RK]6[cE34@]1)E.K9]b;<[8=I(Db9c-/e
UE(-VJQL.V4(R;L8/=);\4@_Fc;#2.&J03</TW\3KfW;RS\?f<2X[<cCfBdbP?VD
SaH8>R)ZPFHJb9L^EUE^>G:@^E;GLSX?Ue<dCK>>Qe=-D3([0?/R0J=D,bFLgG4+
JEK_J:4M0\IO^2IU)._I22.EAZX>/^DJVL[+&:8P,c&C8LA&/\MCSV:YS#N&X1[>
\[>]dX7RSaUK7>,#d>748Fc57D+/>T9QcG]>;K1M1cF3-PBM,<:Mc7&58ddH?YXT
T+c8.1fb0?ET:SDLNFF;JBgOA85-(>>d=TP2(:;;3/4WbLaI3KW^K7PUNGI7TcQ0
H9b]:Q@:B&FW=^NOf1M/0Qdg__CC=Y9;@Da83][5ggGT-aQcA(6L#,TY8+;5S-E^
b>eYIbE8T7.?9:\/+OJA.;28MT1-31e8U4COG]5>._7L<];>#M#T\P(:baFbI>6.
I;Ka:K^ed,N9eC6ZWCAQ>@HT,>2_BbEe-b6,7^FT_H(/[^g2eV;cb<0faa?],J<H
.^YUBc71&c3CKS\=?#;@b@3K5YFPcJWE.B1[P;FZKUW5:R2[(]#JG&4_J?;RKcUg
+>S2+.J:3GPOS(Yc?fe2dL]Ff^Fd[8G-BXJLS<gd2g\T)FBH,H>S,cK_X+-c(4@T
AT->H,:I6Ag[3-;+?N&O9DO7&_cUKf,_S:?;RJ8,SERc)EA,(2#2bN.E6@P^M\VN
<&,\#X;#N&.Y+6dWBR[/COC,WYc8\&PEgBXKU_R;BWH[1\.c>NZ07\0,SKE-RRc[
M3[,[X^a+2CD7P_^A;OBBaa/,N6R1Ua)37GYb1aIH05Q7<E;Y//>^+55+]5LRPI5
@))9F.IW=.GL]RgQVXU+K^2T:T9Gg(N9Y]Bg3#02L4[W7e(TLA?\gf0+8a4W2#EF
P&-ZN2Eb#697<4NRE4Z-8E_KP#2E=C5=I5T[e(,)ObdEV+-,+2g+/H2&;R^NK\28
f742H[-QL?4TWN&9S)#Q-9-1W2+A3aXU>S1g6DAMb?49FZQ&_8J^)A6B,=SX4U6Y
ZZ.:8)UR3<]4;6E]^N7_A/c/FM,S:Z^I2&#HdM&>#=OF\VAPeC9TMHEXFV9\?-72
;8&bX;fFS:I2/KQS1PG,<X\:MS-1)<KOWS#48S&\c=OVD.M.<;d]S3UYC87Cb4FF
SJH#,V)N#>^e</;KEA^=aP2Q_Q)ZD;EI/b#A4Y3CS;<@T_DBd(Bc,f=HW7#RDQH[
O.gEQeYP1Nd48>cVJ/#UU>A[Cd5IEGb2LA8\A^FNARFTU]c2CBX\,TH^f/?#UT#5
^25#OE^;<XAe.9])UOO,_3XDfFb@EZ.RX4\eCUNS1b<QG\)OH>c1.f\XE=V(B8Od
).MP;HM=ad_=K+L<,3ANIQY;Ba\[^.-3S7L=:+5[-[b&W6?-D7/0Z@KA\Y-[FR6P
W(-g?9X,D(E\_E?H&2T38c;B=B1aBR+?YA<Bb4(J0\@S_Y)eDBC.ZE1T-G5E4f)?
)]#LcYB^(;Z6a^bCR1DM(_Z7\L6B&LQWeC[K_cS00T6FGK?9d]V8gW/27TF49HC0
gPfEIC>N]_VE14,OUIC\KNd&5_4f,-B>6W?)XKbbd@.26MV-96HV13R7_6[Q+[:@
VIVR)D4(<0WN9ebMD;?I^N/N,B[Y9K;T=<HRSO[a:1[0#>WQ</;gVe&?cO(bK?=]
G[S8[c-9EJb3]Jg^)-WQT[L_+.YTV5MBDX2UE;bQP]=PfZMRc:TX9g1YHgDK)Q<=
JAACT4@Le2@6XeG>BU>Y\WB)MCZUF?.,LOI5J3QH9+fGYZQWA\[IZ+7,R9#I<34E
]B_a@fN3\#Y9-c3JfSX[YHRI/fJg#<)dZf\bBCXMdH3f:[=ZVTONVJGO;]KU-OF7
O&3#]L+9D^=,YHRXH]?Z48TM1L7<)./(XJFaa/ZSITHc89HW<75W:.5+dU4[4-Ag
+1D[MR9/7^f_Z=/X3#1BMN3bd3G8]GYYI9.BR6#5bC:J(4+M.Wb1G/R[Sa6FMH1.
/\Le@[cCPPC>>WSRNbW0QZV^:3JOD?HB6LLMN:X95ABZH/\(OZH,N#M#,]=GCCba
OPQI6Cgd3;+8FVY_d-&R@K[H[(?[P:(\XYFYAf&#Yg6dN:C7;KPM:f]N-/aGU3-X
;9V,5O(Qb^FgD>?[(3(VQaHLG6)CdW:B.2-;H-&@@Zb0))=Qb/(->8/^)>/Za_TU
ZR>ILW7]eXdC0\]24:<(:Sd83W)CEHDbgK(4F-0d@U,(eaS]c8-G8gbXZQB#)R-#
UH6@+-B-&[@VXYa]UEB/TX]cTAC(ZZO-3NXC+.#&cQe\L<:4-Gg@H?XKR3(XY9cY
eZ/S/@(51@g-9Ya/?J[/V@9F?cGa91C<bbY)KEc=F80B@-@d^UW:Y(GRQIG8#e:f
85EfLKI-W\^X=FIK1>=6VV2;?)RH5EM+#<./0,?;6ca41NA_VXVBb8V[<PUL;GCB
7.24XdS\fWIQ]R&cgRa3)L]9_+aa&G8(<E]O^R>)0[f?=A)[B7FId#EOPRDB2E6T
\bSa7P3K6L0f?2?74=Ea=\I-BL=Z5[UCOMZZH2_\;3c,W0(S/AXIH(##P6\BZ_4O
:ZW4?C>=5g+a^]GWW_c6\J+>1Tc0gJ+,B(YPH)T0NL&.V49M@RJM-CT:YJ=V1f\K
<39;&YO_V4]\gL\)_eZGT[Vb)&@gN+]GJV820PgXY>3@K1N&c/.]@89S@O51N35H
9Y#.>b<d(bJP=HJ)2CUDW.R@WAFbb1HUbcK9[I-1ST&e\2F1TgFL?ag@HP_1RZ<5
7Z[BDY+X?^ITb2[#R[374,\QDOU2Kd<<3;1Y+c\4-8Ue(a3FVK_:>Q]+:eA0JH6(
dONTUDORWd^T,bO;e#KVNB(3d^:DAA[_dUT.]B4?edWJ1bc#ggPP(L<MPW&6Tc_a
A^,6eLV3(6V]GT73#Q?1^_Y9ZS-e8D?,;H=2P^YG;D>/]>V9@K_IJF0.Z<W@I&8I
#(83Nc3gTM;5Ogd\#d90MIe&T^g6/b@MN80QCV1;/L-L;4:+#HF8AY-U#.e>V:gD
Q/]7=g=W-B7Nde>Y&K[X0;A:FdGNGFGCS,OTJ]YT_aGP\<L(^aTD)5/-721DN#20
@/QHaI0?DGE3g\+.YD0aA(Sb0@-Z9+(,UNJWZWCYJBb4MHB.]I=EEA@>HUF+dgA1
J7aWKM-&)R_fM3RXBKD[gbJ14&d:X]P/+OXW8,[L^YeC9C:Q+S<g7U1XMJW;.aNM
HLd]PT054\KG/PLL405X96G.(AXACeX.6L]Wa)V^f&IR@af+e1CaRMac?SKRJ>1D
@9A.>,TT,CO8g,a0a2_>=-OMFW6I/fI5&?cR-\GFf2,XZ+Ff4#_#<eCb(/L2f#3V
1HGI\f2GE#.DS(-<WedU(_AUA/BHXQ6J#&2=0[KW[:a5PPfPC;?V@0PB@S4-^3Y3
\-OS4aI0:MVMQ2@d^X50?9b3/7_;GQ8\#_Z@1A@bJ+F4F7c?CX>gOd?^Le^>:4X&
[#T/I+-5RGd(cJ]CY;[cW7B[9<P=bRc10KH;B+3<1,+SV^_YVA/O4CRc\@MIQM1S
/@^Y^PNVZF/d._d-d+<1ZBG;+G8/Z#_<PO</+&50TWF]e(e;2-fV0CBZ>bZ@G;gT
8=gbTUYfG1dS?20)R-g1#cR/O,L/a+SDC=41Oc2>4I)[KWXHRTGU,FV5DTYN]9dK
XCAUcN3@M1GK.4,Hc.USb<FCUQ3Eb;a3,/-@?2<.7D,&R1X]YHT99[-L\X3A)WN#
^6;-ZII.gNZ3(9e@^.?+fGeE?C7<04/2SG(J1AOPKS&MVK#VX69./C^;&g^NU]JZ
D4QTc>26AY(H/(:=F;O4#EG:<f>WNABJdFQe@-Cee&=f1g)QL?R]D#JPY4=5T?+L
(ReQR1>J>G,\V86ZO/2MP@2cQcdOE@-89.\A7]R]F\)5E,aY9X.9,FL<8+fY7Q>0
AZ@+b[[<e_d8Z^4C4KR1#A-V6&ECTJ-VfGX=8\LI-Z3de4Y<4/d&7J<96@:27#K\
aI<GV)#8-G2g+M+K7(U\8d9:DREbMQ4[9@S5a+?Z_3J/M_7gFVK2MZ-IN4b?UaCV
37:KPf94?X#)6CNCB<O#&,5[?/TDU58SNaM[/MO;8a;I^Se\7L:fCHV[W=K3)c_7
8]Kbe50CM?a?4=RGI]L.VA[)K-g#fc[@g+I]^bX9>>HTacM=#U^<SAJ#&9M69N()
RfHC:6<1cBW(^SW=RB-S22:8eN_OHM(e?N=C(QcWbc[5Y2I[+8VC6-2?U9ED7FZU
M-N]>9K9g\31@GO9XAX+D\eTY,XUUU<\K-6fEMEZ@@O7&5=<Y+aHH>BAGB12Obf(
P5NXcE4K_().4)&JJY\>_FLV5+]#dCfZ\RB@JD+-6@YV_@LN&4U(OA&B#HJ&3afL
6MDMN(LPf7=(&,Pb;?QT:E;E_6a<O-7DReVE9Q31B#\f0.AM]L,,ZLZFPL?;[HTf
1L[BZ\PXB:Y<,<>>MD&\BH]3d^D6TaVVHQH(4g7KM][)B\MQF(ENTd;;EF:D+>3V
=8)ZAE06OM5ae)g9R&R6KB90T,)2Q7Y+PK6afeQ+?dM^BYL]eR(KE.Pc&7Q79bUR
W//LUPRD-)NS@U0P4eFXc(ZAHDf:_CWEO^]1/L;a(U/0(8-;&:Gd\Bc3gIWX+.IK
FP[)NRTV=F+G1ZSAYSa0Cb<MaZ@0.CBIO0.8;JaSZe8(A_L?54KJREUXD/\gPfF7
G=g(K@Q^H7+=f>-KY\JN[<)ZI)7EPg6.HZR5YJ517dGaZbQV7&X/EIV=M0?4LHGE
[D99RIW?SAd#B<d<gBT3E@8/M.L-A7]A@0EZ7B@E5QL6D)F0E=9Z;cEWT,P\D(5U
U;,^-/-K1)5.=FfS2)c_/\(+McdU)G2d#NY8:NF.9:fY4/dEV(AL0bNaX6Z@Za+/
\f)87cMYKCI_:Ug;gH-R).LBLOXJP&K_=A905LLgM0A;+(.)VDHf^,V1)W8N-LM,
(cbdQEWdOF<-WC]fRUXa+VM.DC&#Q28d;Z0@4)1?ZYI24]<OMGX#J#NaNJ9Bc&Wa
9P6J<@SW\(1&:e;@?[^V-.SLFGX3Oc9g\,+bKgTgY+(2+3a?#H>d41^-fR9WG.FH
(SE3O03g@aFeJBZ.#.>V+)^B8(#U4=[Ea+T+>8I#(4WaX5SgE_Ud7M8/=[eC;8M.
Rb:eC#(R2(;X)e/DfM,:e&faJ[YYCa:2KUabY\c-ag?d(O(#)f+@fSRUE>X[,YDH
:>dO^<f8bB63:J5EV+C.U^^a#VP]_P;72EbRKf08K2YJe65/WAN+4B6PHR(-<WGO
aQA[6b^d)E\8.I+]d2I5)d/.?DNC6#1VD5AM=G#bHc>dZdc.ea8@/aFCN;A#RFU9
QC1\DCKSfaRZ,N5FU9)GI&RFGNd.Q:I(8?^@C-V098BKE.BU_#ZW#HVJ;:OUN3>R
1I;2R18EA1J\^1-_&_#X5[6E:J4N>\XVAdf]IU)DANWBe+._9&=Z[AJCA5_XF#Y(
,,]d#+eG37O<P>XLQ+;]=g8&5D7(d\\GBL6059CFUGS/):_8]G7D@-]H<\@8BNV1
c\;cE?Ga2V]BCcVU8gcM2#3.=)b(1JHE[aR4U[U[N[^#+TCY:-8.GgM0cb_aNZL_
fbH\fK2>Z2<SW3g/aS[&Cg_X.&aB5:d_7,MG-BUA0,(</S&_[A]HZ^Pc,9@<\APA
](X]FbGA,=M>TDV^@O[6F1:N=JB?=T+&O-<cbNF5G[7EDU4.De0R>G/a-U>7]G1Z
fb4BdYc>f0Q^b>O]P=R>,1[AR6)PE73,SbO^Qgb.0Jc>ZPcWSKJ_SB=,530@AOU,
d6Ee/bH&Aa-8#fK0RUVVD53YVJ4#<,eFD@G/9O_&U&#D4C^3ad8I_K0@_93Z>7D>
V1#a^Eb&4Xa52A)0XV0T:7[bXRJ+]3cW#ZH()C0KBM#WP7O2)_/6c;@<L8d<&I/4
4I=HWOSGL>;K+T6O<ZDTIZ1(\6]=\,B^+e>:[5J=BHHP2&+=5?;.2&d/gX,3N5e.
U_M(7g0X,2J+[J[^V_.UbCEX#/XV0aU3WDS8=Y1:-6O3N#1?P3[&YKPD^C&U-T:/
TS-\M7R^f@W-G[EEIRKY&EA)7CF41KJEWb(=W0LX.^\A;Dc:43>HH5/Ube#F\:b5
7e15(K1T[\A,1Mb4HLQ#V71cU#D5_C,-]YNL=bgN;Q-N<V.@f^VQBV9c+=5L18c8
ELa(RMUgfY3ULC+P_6A.LG#Jc<@Pg#L2>Q](aSf0855^ICK9DZB:M?P8?K:TZ(]I
:c_eH;,FKC0;13\[.71fO>d@T;1?6UHR/CG?H:U=:0LTB6V^E=fO6?/gAB4Zb:CO
X9g6_dKaVE69+d::):K+ZL-:S8:#KXWdeYI<P?f7g&[3gNF.LAb^IWd?g@F,3]W5
N@)JHX3L+K:dC[)fK5@C#-@DKC5NTEe2_#gJ(&IX?IbMD;a8W7H\A,:S=V5-XSbS
g&?_I@Tg2Q_gR=R=L#VAK0@FdLMF+0UFef^<_&:Z[N:L=I.FdI_5JCW2H8XO&D0g
WW8XgC#e=0]QR?3ZLSD>YANQIO3^dYQ;\)+bIb>=LSNgb8fL(+;@bCEF84VJC>@4
KE(&]Y?+d2I_Q)E3e/KbMH)1CKeU+ZHd;dP@HJA#N.2\EMOaNSJ_^&\FJ;P.aA-H
1&CYP#P0L7.?ZX5&cAd2/4,bGe6\g9N-3IRfdR.HWGW,MY>_c;;7Z@#TR_F;>3,6
.925E.P))I.1D;O)@gE#N0;AHHL5&\?/+=/<ae=II<;K^3RV<T.7,[P_4f4_L)=^
/&/BcV@KYgd#ZE8)6GAM\ZPd#U(RBX/OU+6VBH=-cC6HOI\_X3H^)WNFRICR/e?Z
;W(B+G74E260AV;I9N-g;=Sf:0-C#:INEeWVdSG)UdU?08ba4R4C?-H4-@DFX+5/
QZUH7Z_^0/[Ga9?Ta\&:&>L-?-0/;F,GEAAa\._37PN<(5:.(R@O:G3P&?fJDH&3
Sf.YG:4;UdR\Y&Y@OBMU+_EQM>DM<f9-1^U.]@e/?(C0a2[OPGZLW?S86OHS#_)M
@K,?O?LN++f9+8#YV3?:9EAeb/YG66/:+ZE(X4Jfc-J\_XF(#D54M^3T:?S4Z]CX
CBZCX6F6J6238(f0,6<34dS:([aMD_-BUG\N6f-PE?3M;#QdNY.-,A54<Z4OgQT^
V\IYM4_e855H_;=\;[MgU&b<5.6Z?=bW&.NFYVQNM]SL>:#Y,_T/97eBD9^#Hd01
&/:?7gBNR6^P^6YDPdK&;OG()]MRBFDXY3QdL[R]LbG#\573CT7e/;;]XV&&,HUK
9^6&7C_@E]OTMdCc,c=^=<M6Tf:WMT,Gc#b:5<T28E7dEgV72JAd5d<?Qe.d/>D4
a<6UaVY+)]2d_efYcU\2XGGQ<>C>Q3X3]C>[:<42E7C7>Se_CD:&(Y6UBSUV]V@L
Y.d7E9=@K;6,&gf)/RdaU>V;,AFX,7-_J/.@.E45^McXC8P-O9?C>Y5KQ8[]YgC9
IQaPe^OcT7Gd0.3eE)-Xe:NdD9g(U5S\&JM-G)Z89DX\Q6<gVY]QTgc5PMOALX<Q
85YD22S^b<5.//L(L[,XNN\GU9[K_TaNg-g,YOP/e=+\DQ7[ES1^#BH-S5,[gDT[
]5>9^gVRbY#3Kbf<VB94bH4a#9..958+CQ<7S\=9K[@W^QF]Q18=KJ_3]g&_WI@L
.DDaP5Nf:?>M=#5I&4ZO0)(SM_;GDH9@I4H>F9:GR-eRH@9Yd]#FQL6OK)Q<T.Qc
]1(<1XY/Tc>Z_R;U_2=6KIHDZNK,L>c4J0Rd?<;?ACEA\N.C6,:_6GGgP:Ig3U@;
=IBV.>##NVH@Ea\Ie@T5V>.7&<1#6M6BbX(-UO7BK3MfAT=^FO<.,f8]&+5_@PKA
-#H35cC7d4&[ND&P5[(Q^]4^\-]+QP?2T59ePQcLXPVLBfN0)R<e8<31H[W.(g6+
I3)W&.;<HPA,/=\]bHJKgH=#:3a/FP_3AOKc_KgSCG[V+Af5d]8]PD)fH5)\V5PK
1EK]3c=#H@?F,RBd#ID(BBM88<.5Z?Z@TR>@(A:RTBg#Q(/Va2J6/K_&++P(U1_)
E>+GMCKR6)+P0ag_K3gPY5W=D<+@U\&.AU\/UI@R@5eZ918:?C(f+F?bf[LfT6-c
[,&>Y?XdPV=>0Pg4@PQD;;dPaJDb5dA9f^DB#Z>;UR;>?T7M,7N4OJ4D1gBEKEHD
e]a]=K#@^cM2_79Y2QTg0.Fda5+gNA05?geZ(BLF4=O)16&EPM^KJ,]Y)AG6:GF5
bFKT+254)Wa=+]<@7dbf2&65WfL/b/K05D_eB6gP=6gGI(0K:YS2S1PMCf\(&MJ[
O.d,XeTPb4EG8BOO,dLI(.@Ub@8@)J5<.#YX\JYTA2LC1]fg3d?7F^.0UYaDNed=
F,S:4&b^V,,^FObZRLffg#64Q?PP8X_X0JXP7(8&EF)WD4BSbK=0cU.ZZ.4GZB=G
cP;gE>1-YOW]DHAA^;I8a6/f)7H1T7aJdJ\FBM7WDO:\E)I2\^P@U>TB[>J;3R[^
P<_I3)^QgO#1b:4ed73V\:B1V&g]?X<YTUd]I=3(@YR_:>ZC\S:0g8MY;:CQC0@>
KZ\UR:P>_W=Y-7J&W805A4=7Y1Re?>fZV6XL.W0^F1-3dF5>P>cF_fDK\3]@g8Ka
48Lc^1LL[?+CfPHIVG_2):J)^<8D)A3eX.WTQF&[:5UA.(bTM_L7IARe),PU)QK[
9C[I6R6=;/ca-Z5Z4:X-b&3>QAR5E^_=DL\Bg&\:#&[KKU/SY6F(b86f=CC)->W_
bS=7EC<b7B9HA[-f,UWX##,G,ZKe_Df\\06W>Nc<3445LDCaGcJ4H+\\EbO7gRFB
ec/Q=bKBT,Z:#?Kd+DdY]-G9ZQ-RQ^=gM/:_+\OI[.CFaFUL[(RDd#L)0DS:37C5
YFLXCSJDNf<-bVXe+D#g-7T3T&g+e]2cU3#-DCAK=R>>0(27>J@5/G15>4.J5Eb4
\WN]87,23/)J-[f(R8-;IOP]5>UF,A8W9[;OgMUE/0V\?d?Q0ZJAAM]Y3C>=&N.>
=@Rg9[dGY<+f==V3XBQWGLFZ=_^SDc\G/7WfeWQ_M>1MFMbIUN0,Ge>XJ3M4KRaQ
DW#^E9)^fg@f\,=2c(NO_N.-O4N[X\_SGI65-=F<3-VQ/dK@bf9+?9U0AS&3IfTb
DCePcc>f7=+<7ZIe,N_4?4./J_.#6MZ9#N=6.7(+#1/^YK]7V9-3&U<TQA@EAc<e
RKO,>c[<?Ng(GZW@ecfGCdA^.AT07MY&VZ6AMg=0b=I\2/K5K>W;1a>J7d3KD:cf
&O64(4W<G\Z^@+0_)+SX2GSXS,f(YfB9d;)aW22a3,+DD_6FTdN-[XYP^56TZ_&L
D]O=+;+@+3-[T5]f6,X37&RH&U[QV/M0D,c82;#&=80?b-E1Rd+F3E>=4A9UA-FR
=cRT>Y)^UPdR=A46PBNA]-f,SVN]J/A<:-d(;_]VU/SJD:M,KR,V3CDGLYFefTgg
I>M=,9F[J@D-I)DKD<9+X77D:\QQc&>.4@KO#U;c#U..33=Z),]5(X/@7WN==]W>
_QY1J9?Y^Y1I:\F[.[AUB,PK6,SNP10ZfA4AGe#50Y:gYe):.d2IE/_H^4fEIRd6
1f4e)EgW4DVXZJV:MKF_e84.7d1NBLBO\\Ae\-I6BUa4cCEYFf(0N;E+.CD<R=A3
)A9B-=WE8[.a@5,TXI-NGE-=VXSMfPaJegAYd&g):[N&?/XI\-AJKM:#^@//)[&N
#76aEDT,P(P5BQU?^39DdTc(eM:.4E.<NV.VG\LFC?<g+KReNBcPB6>ddRW&3X__
Wba6=:?g#fW9;,-WLE,V<Z2EL=_RY[@4A,D\Vb5RPNS^N.O;:M=;=eXF[JR^.Yd,
(SG)X8Q@9B=L]R0>UUc6FDEV4DCdY5;Z@HA91CcRBTMa+?#[IB0ZW<fJad5J-1U-
[&3@=W.fM8_]CE6UFBJed4]>B1O@DE76T_>FRXM>a/a]EPKZ\#MYA7Y#G@<OQT,7
dR;29eA)RDgcN6fLe,,.FDDacJ=E9B&Qf8O_BR=+63;gI^)dDaXGF^P,Z-_VV]<P
S3?;U.G(,TC80Z.&Mb;M&&&(#\g6#O61gf1VHNdJ)GK&GF&5(6N>1C[b4L,A[#eS
[&Qc==T=>563eXZXGf?.P0A7HfDW2):fD5eeA,JOT[(Vc9WE/T<7<TJ]B<9Aa;X&
=2f=-0NEaU>=M6L[0T?X[UC(f&2[C.0I0B(:0S7ZfL15TZ2g/1D;YOE)(\cRQ^Z2
V_A,3IG0EC0VJSId1[WI/]dR-JC-2]CQ+QUF0c(<LTc00^RKSP0e:NUEJ\9E1NcI
E3WVWR[X-Z]NbOOeY?-P1>,^<AV,H;C/Z#8dWVFeMJcKb,cF))ES4:G&VTKDXXI:
cQPB=+PP?f^<YF@2gg<b:??dLY[D8#S/A86C[@_4cKO5bS>0Z/FdB^3S&SK0YR=W
agcJd9gY[C52C)J>M+/2#VJ/NADJE>9J0)\)?//\&2A5&0V+9B;OONMS/#<N[#ba
eAF&Hb)cW6C2-$
`endprotected

`endif
`endif // GUARD_SVT_AXI_TRANSACTION_EXCEPTION_LIST_SV
