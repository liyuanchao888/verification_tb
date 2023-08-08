
`ifndef GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`ifndef __SVDOC__
typedef class svt_axi_snoop_transaction;
typedef class svt_axi_snoop_transaction_exception;

//----------------------------------------------------------------------------
/** Local constants. */
// ---------------------------------------------------------------------------

`ifndef SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_axi_snoop_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_axi_snoop_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_axi_snoop_transaction_exception_list instance.
 */
`define SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/** @cond PRIVATE */
/**
 * This class represents the exception list for a transaction.
 */
class svt_axi_snoop_transaction_exception_list extends svt_exception_list;

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
  rand svt_axi_snoop_transaction_exception typed_exceptions[];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

`ifndef SVT_HDL_CONTROL

`ifdef __SVDOC__
`define SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
`endif

`ifdef SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, VMM recommended "test_constraintsX" constraints are not enabled
   * in svt_axi_snoop_transaction_exception_list. A test can enable them by defining the following
   * before this file is compiled at compile time:
   *     SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_ENABLE_TEST_CONSTRAINTS
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
  extern function new(string name = "svt_axi_snoop_transaction_exception_list_inst", svt_axi_snoop_transaction_exception randomized_exception = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_snoop_transaction_exception_list_inst", svt_axi_snoop_transaction_exception randomized_exception = null);
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_snoop_transaction_exception_list)
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
  extern function new( vmm_log log = null, svt_axi_snoop_transaction_exception randomized_exception = null );
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_snoop_transaction_exception_list)
  `svt_data_member_end(svt_axi_snoop_transaction_exception_list)
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
  extern function svt_axi_snoop_transaction_exception get_exception( int ix );

  //----------------------------------------------------------------------------
  /**
   * Gets the randomized exception as a strongly typed object.
   */
  extern function svt_axi_snoop_transaction_exception get_randomized_exception();

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception( svt_axi_port_configuration cfg, svt_axi_snoop_transaction xact );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_snoop_transaction_exception_list.
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
   * @param xact The svt_axi_snoop_transaction that this exception is associated with.
   * @param found_error_kind This is the detected error_kind of the exception.
   */
  extern virtual function void add_new_exception(
    svt_axi_snoop_transaction xact, svt_axi_snoop_transaction_exception::error_kind_enum found_error_kind
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
  extern virtual function bit has_exception( svt_axi_snoop_transaction_exception::error_kind_enum error_kind);

  // ---------------------------------------------------------------------------
  /** 
   * Utility function which generates an string describing the currently applicable exceptions.
   *
   * @return String describing the applicable exceptions.
   */ 
  extern virtual function string get_applied_exception_kinds();

  // ---------------------------------------------------------------------------
  /** 
   * The svt_axi_snoop_transaction_exception class contains a reference, xact, to the transaction the exception
   * is for. The exception_list copy leaves xact pointing to the 'original' transaction, not the copied
   * into transaction.  This function adjusts the xact reference in any transaction exceptions present. 
   *  
   * @param new_inst The svt_axi_snoop_transaction that this exception is associated with.
   */ 
  extern virtual function void adjust_xact_reference(svt_axi_snoop_transaction new_inst);
 
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
  extern virtual function svt_axi_snoop_transaction_exception_list remove_exceptions(
    svt_axi_snoop_transaction_exception::error_kind_enum error_kind );

  // ---------------------------------------------------------------------------
endclass
/** @endcond */


// =============================================================================


`protected
1@?0>WZ8V&<Ccb9>WR5f-aXDSf\>J-XFVLDJ-SQ).\V:d?d\=PYY5)fYXMPg\KIV
F2bB>GJ1b^^/3.0B\#N\e.92Y0^G0J0AR>U_d30+HH1SA;D\<dTB0V=8YFI,bV8E
AAV.a3SUOD5:(UbDcV[S7M7@N:FLO<9J^[G(J1<(LX;M__H1JXF3I1_F-RQ&LVG6
;0CT\g52)9/c-,=/>5T,D?KJM<QS(3\>,/SMY=.c?F?:B-2TU7UYZYeOBPcTc&>#
7-?.PFZS2a/_&049bR8TPE0Q?7=@;L__R;[eA.OePSg6g#@(Qbf>Ib.&e,e@A)4c
2dKC)Z#d\;=^3O(QWcC4=.RX,9?#Y\RD7OZ)MN/F9>3QO#=C3EUTW.LA0+AXZ[;M
@aMg^&c?W&AQA2YB/&1?X1,PY:R^I\f1]^-Tg;=5GCT73,gGD\L&J[]fCfO,X/H5
4cBCB5[a-<>O<CV;E[H7d.50Gd9(VC9[d>QHDDKRcZNK@ZOb[Y7-K?(155\A@Pc5
M=b/\+=2(?e+R/Q_V#<2e[-,9J#)_Q5\8LN6OcT-7_E2.b);I:=<K7SC>P+>OOBU
3XcO1,<8[XEHOX32S-5P7a(IA:KU<@T7;\gZZOCUb)MHD8,WA(5XaX@=_[UV_[TN
4RS[[7Q7?=g7^_,CIcE[;W)KIU<Y&1+OJI#OSDT7FBgg<K7<W#\^)GEJ+MCBRIZ4
\Cf.O<#5Yf4.:bX,HZX[bN^:<8^@&RRX>#FD@6D)5NA.Lg6GF+)(DI73Va6C3=Ub
PWPJX>KHO/gH6BS1)KY4\><@76WUNdc+0WaD15Ef1d[WY273:B1<NCgK42PYVJTR
,U1e26K6G.<7\/(U85F7V^fMa^(F<F1EAOJ_(M]6OK0VEQ#E0a[TOJcTdYV8#SV@
\Eb/82Z0(K6Naf:_)7K1R+059#eTg/#+-KXFH2>P#Tc_TA^5GZ>VdG&L0I?AFFE7
JVF5DI+LY6,CB:c\\Y>Bb<-VDZ8:,&;O@:].RP6dK(4EgSb&QQ3bAfVT(aEANd@L
#;60[AQ)5+LQYM@)feB#I(T^M.d]gK]I#\W]6#Mb4IV+#:.9;RgXZ1Vc..U&b].=
@V9]8)[[.31;MF.1LV)D4LSbBD:ZD]B;d21:V(BI(&Jf#YQbLdX&>6C96-)6>AZ.
0]DYY?6JXO9BS,0#.0FR[&:[XGQd3g:G0SZ[_HPW\6fNDRdAe#RSXET))+CXJ@KN
G?/YPY?TY#e&Kd.;IdA4Xg+_Z2V>V(Jd?+g9[+E&YSDPFC>VW1.13DI#17ADbFUC
<26<[\&Z:J=HA&R)f,T47?^Z0)>dA(HYQKJO15(Z.^]H:;^KVEHX7</1+@#a+3;I
W+U@-N,Fa5;P3<)595H)S=6e,g7-)LLEBb&S8HDB=3W&d#gFO9G4S?a^aD2U^gF]
fX-VX+\^Q#?c2c(F6?#GV?8M1,5M;Q&De]:W<0NK(8_U@\,8UXWK_+BI9UAUI]A1
[CEf(GG572J+(ZAC#S2Q]PR;6PN<JV?X1G<a#HUOMSLBD77[W1WB[@_F+]>;>CW7
bb#\/64c?H)E9E<H)<H4(PdIE^>XJQJNDUT5-@e3cY]D_b[]<=4TQ#B+63>.GcaW
-FeEU>6?^:PDW]_,+P51/R)E6a-Y/[ZK(F]6_8BRODVDA$
`endprotected


//vcs_vip_protect
`protected
eG@TRVeT/DWTe<[>1>NSd^1^ZYeaf:3#9+XG&)<gRV&#0X8[J)L46(Vf[J,L<5aU
&V8f-&)@R.8.Nc2@5-cRFd/1/4:KT-S\,C[=S=W?QM_(8U9WDB0+0+KI_0[/-:GG
#AK5SG4+0?,)X>eE+X^>4[\=J-@-X[O=)[(&(;^bdUD5?G)R>B=ELdef<AL<a;1\
S7C:_2F/9J.ESEFQW#=V(FZ9V;\gOf&IY0\cIY7@DQ3CHg3Y#WJRXKS[LSK152]R
g/Rb6X&FSX[SYZ#5:)?@bcO2/Y#XD=YY/JcKJLN06R;/feK+:]Y^R+1>CZ4+..O[
,+\NZSg;]MP]P3I4ATR[eH7OJ)Y@)fG8ZHT;@LR9)<cY4^?<]7M641@FO7&:.NY^
T\N,D>eLK&e_AF@D>.d[S48@A8(STUaNQHJ=T&bCAS30?2_]#eAP/.FA/VN&&J.Q
3GNg7J4KKM1G\[-[b1H8Ve]Le>M<ERUOc[.A9/);L+[TH\AI[B1,=C^&ITS[V:9Y
^;Rb72O-#gR8A?ARF0@XMRa9ad6,\c+E@HAc:K9Q@c4E0L\/G0?G[@V+5ZI3Zb6F
d=TQK>]SB31[#<b/\]GTa(>OM(_CcdTW^eXI;c&R+=&JWFWJ&##46.07RH92QOLU
4AI[O/691I0<11)N#LG\4G6,(\W=^U;O-W(W-2Q2>9ddDf0/K/QVIC#7#TdOWLdD
O4:7aX,]KR,Ue3@X?/a6[T[=6ZW7=B,2L+6Q/@F#dd#ZK:X5N\=<?CNAb0W:7^KH
YQ^;M+:WM.4ANX0XEKag,e=aNC_J<dMN&=_UF<:6S55?;J/M4Y5CMcF8AAH-WYP-
6DKIX>PY2Q;PN4V#_7XGKGWN[48H?G+2O\g9g,[(B1ENZ>)?1>?>H@3WKQY<V>,c
>,NGUb:b6^gT-7eV#=;RBf,ZUNBQIg[ZD@73#L1[fKe[/a;-Z/6fNg>UN,J6SXZN
E3&c8#MAI>)(c54f/9E<NB)L.4I5a7SaO&#H^\<.V3c@17+:fH__@.FTWD-D;A@1
//1\;g\>MagX:[g[,,:QBZg00&OB<LZ4?@NH>)R@N<6KL]EfSB=IO@B03,J3?b;e
@D+Xd,BbZedL5)3Fa3bTa+8G^ZbF/XC434[N:\Ve@ACP4TLgG.[c@),?)JP>K=;T
&@IVU.EE&gRVRPZ>&EXcgI,L8]XZEd4BOdRa=R#4L04ZAJ/QI^bM)?C3^caFNLU?
df>3SGd)CTJ5?C(H_9#47DfQGW5b8d\-/WR;3#T[T)Yf=-ME>@X[KFb@<@#Y#^3S
be5EO.b&a]gGG0cL4IS<9dKeI9)a]5QT,Qc/L)4U7DL]0cQV,0EXgE:K@,VA8?OW
fLRfHO]HTbIa1Y>8V[gE?=(H.Ha8IB[2)Tc6#(S.KG5;NM&]KKO0\A:<ZTYTa6Tb
_4YPP?g=/6N5<TDGC7Uf>3W\T\b/\&Fd7(ESG5E&gU&X^LcSO3X.V;H/)Q&9XUDb
WX:X(aOW+dg48^],PQRCT?NG32Db->UI^Q36<]:\P_[61&=[(9X.Q1O3+C@IP:5L
8(_(,7=_PE1XVQ(M#:gVB7,/<GR/1:M)_WM@[(2U#fTEM#;C\6g2?d+8>TOF#a&(
EcW12\8IV;=HHD]KS[H8LGVZ&.5^:/U^e\8;.77A]XIETT:2>@XEPbJe2b)fAYc1
b>AeHb^<X3(23S#-2?=Q<&OWBI(.2AJC-B;[RP-f0#9g4U(-:Z+OM0KUG7d+cTcO
/8&8QQMJG8P-3A=A^8T)aM@fIZ3Ed.HJYD>DcU+d(-(QHef)]BXaa:0VKY4.]2Db
4S?IXQH=U.4dB38M^3cHS&(X_XR+^0OO1B?@,gCH+[;&1bAa2+dRa@YS.O^eWQYG
G2Vd,LWI^/D^&,T.2&T><>,VPI0A<(3,86\_eS?8M#&IVNVHeFHfa5[7dZfDJR;e
WEfJe00FH_eND_=J,bXH_[7VL=<RQS\_5&fY>@Y_C^T-EH7E\a-^L)_FAW]0M)IA
3O84QS3J17,ZXc,I-_bB:=W\&H7=3=N4b0E3,^bDUMgOaZdB,WN6^E-&+_PC0_6;
\AE>Q\F#386XAggP6XDd(VY+MUW1J]5+^fD(f>VR.+J9d/.M7_[cLLVNXI,eH9C7
f<+QP,Wc<STP+SRNSAd^TWXg?0Cf2aBSE<eAV>O[c-_Xg88W@\N[7W=Gc@=^5Q^^
:HR2.Y1&6B@<64&g<DB&EU0UZ1f)c7&G=.Lg+P<0O@ICTY8IF.RWQ2\T&ac+:4NR
1_TV/g94&N9>cTWU0B--a)[GdCZB\,T5_A(9;UZ#\Z\NKSBA;KCKIYK>a7S5XC6W
MJP(,PdQcYGE,R;B]SJ./BB?:TOTL\+J^/<;C5>E[]gb_1(BXKEA)VSM@4/^/:_S
L#ZR?=d@-CJUZAHF2LJGF/;/S/ORQf@AW\U,>]T1,VH4>OV]=D8QN=7<g]E+1-If
Z_cD80?_=\.eT_?VZIZJ1+QS/gU2be<D9d_&I8bY2.7B)1+_QfZ(L.8KK@4?L=T#
IU(]aV>WfgIf)aG;YC-0-]J>2UQNU:EYg(&HG6Z#X,K-f88C3BCR;X]R]SWYa=9L
3>6bfZ+<;.@(DN@2b21;___8)9>D8&8X])JL<P.NOR4a[;_cQ.H0&09PV?]M,@>(
cOI399QXQ/F7Q<^1+=8@LGaJQ(38R5Vb@J;N_0OZ=6DVeG?+1[<>)K4WE,_MPQPO
YL6(((-@34bYB1-L\M>Lf[ONBIWZaD54S&&;TL[cF9Hc6@#?ETO_W+2F4XBDH7/P
cQ]0_,W@I#&7d18C>OAFR+B2I[C9FZS(=bc-UbK8PV::4?9F.WgPQ,/dKb<C.J+d
/G1?<]OOCe?NOJI_g_8C6OKJE=#@ePfK:DK<f_</S2g\U/IN.GYfWeE?S1Pc[YSC
2NC+]_ZN5;WXMX1OPRaF)\G6UDYdf=cD,Z.([F+TV=c:^6H)(V(>P&F:AUbcSbc(
YgN=;C=H9#M_:A1gZSN:6@-(6LLM=F/(=/USILc>IUS8^Ia84U(3I47>4N7#A=DN
_^bGEZ.@I2>8<TF-5J2X:+aN(VB1WISOYA-X/;+;:a4]B12L5a[NS2EXbUPa-gGZ
SgFfPYQ_DGROgDL&;WAc;.R[<8>:@W+[=+AGa.O[B2;[X1@LIFF74I9^bKDLYaL+
Z]1<U);Y[Fe,@dSb6[Y,X63S&#M;S=>2I-MI(;N:C>)<X+gEO;FO=GT2KeG6dYM@
<C]BZc+=(KX[8UL)XeU.:;M8c^FAKcfR125@,AZHd]6P(TVg&\8NG6N&6g(;fW_@
?T=T/Wd/Y=6da5O,g5,Ge+8MYF9P2S2(XBGFC7>-4OE&DA^;FB.6(V\7[YW^S#WS
d<c[5-#AI0<[c=g.ACe+PCdGI;^MLSe_]JgJT(fZe7UEgOK-SE#[\^RZDde6UdP0
)X,WaY#J739K45@CFX=58<?6\=D)f2KMCM_)JL16\IGQU(:V@]#0(>-IPZ8dXMEa
ZEFd;D&,S.2Ib&FE@/]5Qg<>#<,15OdRTI7_&ZT:Q5UXDTA0JGH2H#7^Y]S/ZcE#
HfAU?6;6C&UCKfN\O=W)O45TS9-4g\BN(,IZY@J7I9,Q#a9FZ25L_Ddga)(I+WdY
dXX3^MMSH3DRJB0Ra#\gdXX\#<69-/a+668G><:aPb./UeH7W?U7F-7M]FTO1?0#
BcU(a/XNQ2]4T)XD)RZ^F\\1O;GXN]B.<2_SAEQ[OEW<LUTNe[GL4=M11C@fGNS5
V4e:LM65]:>f7Y^0/4>:F.DcaD)U9D_G1;QQR9f8VAX&:>=\aD&GY9>0.-[2(SOc
V86PMbdeDgOR,]J:8+R65O=.ZGF8P@XacTM59WK)/LLG1?.e4]>^5M(ITYL+A26B
,;:cEYV8P-2Gg115Z2R.T[cM<L4/W(2>J590Y[NSUV,FJH_0)e=3M)VQcCQTB,:Z
AN;N[WdfG>>]GXTGc9_G-NV9EDcLP=LOgHX/YQ6eAWTF_0(J9VJ[]N/[(MXL/L)O
aX;fFOSI=I^Fe3\\@]eI_:Q2]-gEV:&3M0&EU-XB0[K>b=+HcNLA;RL+6+Ie5eA?
<+#fc@eSY7e_Q)4]_>:#dH_X9O(TJY:EFZXM9]TaB)<9bS8(-efVVYa#\:-XX]4\
RNa]J@B3G#1E_@:+c1IL/9d1C44&ZM?H;cJc-I[2MYbW9[QQ8;Zd/([E<DW?KaO,
gOBa/0@OHf\GS68Q?6II3Ec7F^]>[XdF]X,9[,/cX7.g,UIMAaODMWZ+Aa.dE06D
:)01d,<S\^g->BSe@M:M&F5T6bWUW<U2JJ)Ca:#9@K-4e\BP1+DM7a60PZ>VeL]<
A)bPa4a^_OHgO0FX;d.HDe,_bScc+0KBAg]X(c-CbggbIM;b6D^/-[^X4KKX3=4&
=N.-c#CO=GRQBC5>01<_G=;CN>Pe&8]-OY@H#.Z?cXU3B5d_Q\N_WbgZN^?U)(5g
\1LFO?J:Vg5((VIPB)H^fD8O>LR]cM-C8DSJ.@>D_#3J=[E>d0VWYePH-8+4_N@S
@^BY9E_DN7CUVB5f_X7#\L2:Y[@D)7ag.&VX]#)9Q;U]05<4H<[:&EW@^@1Jc,Y#
<bI\Q7-9>R5=N)d/S2Jg,SPgH]7]:_=Wg00WEYg(WS2.I4g0^(L;/^4TORTXQ_Ig
Y6M9,9XCS7L0?eLGK73HWg&E-gFH0b.+6,-UK>Ba\6cQ^E4]9CR3O\<DVOEL)S]O
K7(7.9,<(B0)46YKKec/;]_/B+7R,M@#;=UfF9]3Y\6UFY@Tg54F)KMZJ]/R)EBE
(X@R>Fc5_UL.:D.=@B^DCQf^MX4A.L+E_O>^?_ZOfK5ZCM@>;9U<8H7B1e]Y_2(<
W\=cIE>3+<H2eCWcNK/)bc>E^8d.U(SIR5eBK_L@)@HOF=W+^Y>YY;)G#W/65)MZ
cWCYY&/YHB4Aa6[aZTPaS@]M;W20M^[WI3_BEL^:TKb&0RTa0C+X=M&<H2UQ7X<&
R:]F9S./C>0966^#T4<V,d9@\KT0WUB27f&)&:c)f#(S;N.9F=dA<a-S+a=U_H98
ZFLg-BK.[_Rb/<^gY2</aW5A75I[#Q0PbeHb^WY(1b,1FfA2A#OV#@L]C@.BV,VO
9GA^]R-3-CGKKcMPQ?Fe>OXV.2cA9=G-cOW2?H#GdG<8-5+UJ:/5(EVe7YHC0M/-
8beHBSZ<F(,D0I3VYJZ^Ha\>5D56L9))37^S>]82?2#&cF(J7f<6?EV/HIMLL1F\
CD4ebXHK&B9If=cW=.:VT;V4Id@/SVN6)@;66W=O.T)L(XZ-A^4SN_?].E_,Q]3X
bQNMd8W4eVL[cgfM2?Y1[/KT[#e,K_.>)=7e3UDM@+3eB<HL_O5C>,I>U52>[M4U
;3Y6WV\>-#Q_BP4d\AX>W/4?cF<)UC8e6-BcQM1-E))50RaDL6c5/?RTD]4[NMV2
TPILLR,dHCMIF>a/8M^Z+ULXHd#?1.EM3(A<aQf8B@E?BD8,9gWVDZK8TQ5>\TG2
gDaWc1N7aKN)VYC[N67/N[8?\\eXYR^a6SP/52(]b&9+/SC4P_K7<YJS-ZbIQ^Z<
MWMZ#S?8Q,d3OeUSW7D-(WJ55gGO#/<:Me>._bfXadb5WDS]d7fWebK28\2X1/SM
ECGQ@:C)AeXF6#(B>[.JX]1EVKdcUcD:-I,gFH;=^+^]b(0I5cTC(XJOLKb;<bBZ
WAdKd.2B1-FF\7TFC^3+3M8NUVc3.T[+,:Y9DX-E-[:.aVE3Ce[#,aU?.PN786Y[
f3a3^X2/f-Z=X5KZT9,gMfdLUb-d,gR,ZSa:L)^[2\)fPVbP=OA_LdeDM4K/T/,H
9:bO?_WICA.SaYE0P#/^cL([3G9VKW25UK7]\bEN::MVC9X]A6g8SEfK]]W,RS:]
5DE5HFQ0C1S/g;LG3GB5JeW.eNSMFLL/?S4N8TgUE_&\\fCT<SD@-W.,CZKCQe0.
NKF^NX@@.G_R&5SLZdbLIKC(2QOEd]RK^D+TA&42+M=<360aU\M.J[cD[O3KIL:E
[>0HB8f=1/UV;ZGMM=5c0,0^fcOg@-;,<9&O=#USP2H<A,UW?#6]63S;K3-<045.
U@[;13H@8H3ZDZS6L\>d8T#@<JF@Dc<079Y3A2Qfg^ReKeGR_\,S@96N[:Fg2;ZU
4dT(PJNOX##;6\[=CW4Z\;<\@@Y::E,X_dF-)g0LUA=&IK8VLYXSICY=Hce=M;f7
3:)ObMe=(E7BB5S&:T_Y/QEH01<_2KP&I))c]0I<1#a=QRE+VT.?e;.]3)W[3??B
c9.&=5dIM1RZ3/-QJ>N#7CJ-gAMJO/B#d[/=1Of6IV[VL@Rf340JR7?\LK_:aF.F
NJE]-0.QW&0L5_Kcg3<_;YQ67[XS/W\=4-.268KGL5+/QZb#/gXLHDOfQ(]5dUcd
c]/1:JF8[ac5^YYA_W\NbR5&C4,Hc>[Z=H0?)VJU(B.7_A78?&f:f62GG<Y?9,S@
0e7IWH:YFZ76cNZ?KXKD0Q>&CZ9f)M&e15[]GAf\6/(0.b;GC3-S[2EB(Q1GNV2/
?^R&:->0LGA2/1C0#YY_ED(HL.f)?H-NVY7\&?+S=b=E2/XXbS[807fFPX3aC;a-
?2YF@Gg(FJG1\#^1d;TS8YcM/c2UI5-2O;ZD=/N_CN6IR0O@:HYac5G@LeM>&^.&
OQ?Z>SAUb5X\F,_2@-0CRMHI?#^(N4):Rd7\:XQA.?dCW9:1]WFfM\;NaUc?f[b?
beP1+A>B.g>:3D/4a=/b#ZP<1J^Ra6gWb7c52HB0<>B+6<cA?T-ZVV#aUM>3e1ag
(BdT-b4341]5@L<cK3YC7,c5LbH2E(5W815E81,9:U.G8S3-:WeS2SQY[a:A.^:J
1bZ>EOb\;4V):?,#_39[Y>>Q7X^\NF0R-T2aO@T1I?=FU;4.X+R6N7+(&gfN)5b]
0d_5M&g^Z^.#6WB6F4T,P/&,B[/N]F]W[QH&+)^9N\CM1JKZL<#c98ZH3HB)/?S-
fR@=/f^17e-^8SbL\S[/G9V)gQU<Q6,RH/V9EUXS[7:JB:IGM4J5g,^Z>K>D<C1;
-?2)0[bfZ2QEO5LLZ9^WFa=R@^>@ZSbgZ7/[^H.Wf=-UU,LbaD,GO6=OF6C_IOC3
VD6(O0<6QE@DYNe7Y7-JE,W9)X4R^QY&>;3V?]IcK7A^(<<8d()(;S7_YJBY)D+f
UO]N5FMA;ZGJU_,,@0([(=VbEV=XT]ffe=)L>^#NKO3R,OdX34bMVL.MDV?dP-)J
g>&&3@);PG^4Z9,RYZI@&90b[Ae;&cM;<Pa&a(H2g@9f_Od>+X0c-\c:),(b^efK
O:OHAf?YJSX4<9056FQ,Qa&HW/6c:E@#<&)P358c0X7?0:\fa>Z&;LGX=IE[-JcJ
[gG=K@UJ<K<fJ+a6EBF7IK5f;VV6J[d);0I,NKMY&KRH)eRgM#/X(7ER_JI>C=BX
Wd]F8I;KLAG=M=.;,HD^51D_B1W,eTC6>X\V<Y=dD5CB+4Bff(^/3=V3BBOM@<+J
cZ#]:6(CDL19Y.#FBPXd<cU3XC37)>(Y-K?Gc5cC3;K,II^QEHc8U366X2M,Z]\M
Ff;X?KXX6g8O8=:;<CV2EU;7a.R9:@DWG@WU9:73B1N#H?3D)?.&L&=bPf2Dc[G\
_4aH^&GM_U)[+9/:>:e-UB7d8_7XTA>^UJaIBHOd]K6.0RV^=QJ+Mc5+f;=Z]\F[
L-(5,)5OK@,7.H-=-\2K[HT\MGF/Q>/&Ec66)N)_-Q.+F,I[0f^0d:CEdF0#gg<4
R,I6)@WMQ16K)LSDU(-8;5C1GYUQ\VA3gQDAVad(&,8UUKfS7YD,cDB#.1)O.=4D
P4T<JWIP3M[?5K@-:PU@_=>@FfUOc0aK=)Xa4FIVP/)QR\0OOJ6L7Af4=E4,B^O?
L+6H@_#;6OIFdeF2UE/0Z;IPK7[-8NDNa,bMKcBL3+#\=7H0TaaL0=Q,Z(E(Z_eM
a7\LUC.)06;IDG:7a=Y0V5,1:_I8M9Z\#[1ZCY@b\,>@4L&Uc91fT@\NB-=WUV17
aU1&U&H/CQbOD_R#b8dZH?W_A.#F1=Ha18TKOTAB7@QJACaPg7(]F\+9>T.8bY32
FX,[g+KCXeO.\#N>5F_2IfO<<,6(.fPa3TT[CHCM5#M+USZXBUX9SBb>J;32U1#Z
3M5/AF0QV[,E-(^\=e^X7STPGCLd0M<)3N62;08=A12ZeR:Jf]cF61+cfVL8>MAW
Y>=[=L3c8IAF,KMV[7:F[N#&=E6GgDF@C6RE#FUL]@XH0RBKQ/=T(<]fP@d-]:A9
,>L3QT[fe9.Oa/6AKfD]T,?c=;FIaKY-\d@IB@OLWR9Y1\[XBFdMH2WDCH-I)e/+
;XD7U>0M_1B?aa#-e\2EMBBB70ZZIb2g1(H(_PYO1)8]IR,^#4H;=TE5R-1-;\:9
\[CX75f/OW5bJO0dI][641\,f93c?f0f]J.3K+d+bL9/I=&[f93O#BfEG_P[d>[2
/P86Qe42/E5Q6\&TT5IAd8[WDf;6YN)2H7EV_(eDg)#-<g0.0X2JL?QdY9YS4Qf\
]UV]TE2P>19J>+P_3^F4f,]9/JJ6&_0-Ed.A07@e<3E9QYE4e<]9=fMAFANZMB[O
ecR?AH3@64LQgZgGNL8[UdQU1?^BR>_WgLI^]3gQH/1?/@;-UGM8ce]+IHJ30Y9G
.E8K)94Bg\Z<SgbK]PgX,&897TJ-^AMgCV8>c#HgLcFCME&;G8Y&1Q_3-6,ZKY?2
?T;PDA/<eT?&L4UC2TgR>DfK-N\K<PF=D2?&+cL,Lf_ITb)I8LAF2&>O6cM&(B_9
Dde&KZT49<PMABMYK&AL/XVH34D_2g\8Y>dFR2#K+2SL7b^(_\?S^#L]=_,^Yf9/
>#V7CZ#UgT;]XUZ9_H-\KXRC175^F7F;NG2)@VB72_F,H_AeZXGdDb/(]#&fTg;_
Y2)Gb.2LMTBZ#,NJD-;Oa3FG8JQYFJ>1JOYX;^gZN1@:S/;HDD>D:=D8#Y\-f9Bd
E]DA/+SMIOE0[^d&??9(H,Q99<J(.JHcU:7-J,K0LORU40)U3QfC/V^D]#J9?P&C
^TH\g6b;S9B>;&PXgJ3+UdST\f4VaF@JEbCQX_[^EG[3I4?2<Z>d224J4+QK8NB<
]1,BHK23aI6XX]+K0?+Wea<(e^D9MDAc<^+(W.Y>aL?9,6K2<]L4;^V-bT1;:JAV
Rb2&97;2S^JPQ79Y,[4FL1K2#S1_)7WL=NSF]gO[4g6TN9FBY00>eG2-=>#A,MRP
XX34J@D5Y6Sc[Q,W@=90c5KA#)^g3(Sbd,=(]UgV3CWV4g^YMg/bSY4-_\47I29)
FefSX93fN+,W(D>CQHR)8b192NcHU2,+9aN1&TJ-(>=Q>?8_V1g/>&YLY-26>G,d
WBY+^DOB39TQTPb::B>EKF_=/&<_BD/_@=He\d8DMHR#Rb4-a:YDW19/YA^:U&.f
,aD1^_GgVf,4=UEad&W8(NK<Xb#Dd./^#:?)\@[#FT#?&EDbXAfJ.@V2b#:&E3cb
Od.-[5Q&d,)L5IWC4:_,F<RMJUc60c?[-=?;GU3^.GWM_g0OMF2X9VMSEN:F;\f>
BY@f&>E:Ve.A#(VX4NA8[PKQ6f_1MB9eY#DEa.M5OD;<Z^==2e_TOP_^/<;-_VKA
ZMR:A<U77JKT([>5X8GL0Wa(b4A2FVD1XP33AR\]0IFL6I,3QWF3+P5;53ZW=@Uf
>93J5PRId)dc7J1/&_O)K=<6]]0:3f]\]?T6F)bD6LVZBb5.AUS4X<6B(g[Ac^;K
B>C-8eQYY>gg513W#=Ed0:RENFMJT#ccda27ggS&9WJ<)JKNED/=9)H#EP@-aTZ,
P@A&gWNb@#;\dCcgZRVGcRLB#IfB\be(A_\7Y>eY6SM2ADTH.d?<G&;[bg@.8Pc@
:ADK_=Ke[,YePg96_+#,2+U+^CPA27YYH)NF8KLXg;ND94USW?>#-N4O@\,_d.9H
\EG,VG<V9@9CH/SPVDfXS<0&&+,^N1MES<2Y9_;]af-+6]9Ra_-c49[fZO2WHTKO
cLVB#?^UgMJL/L;5eH4N@_B90BM3;,Cc_ZdMFG:G>6MNAXWWI8=Zb^EJW,O/<JOO
X&A=Sa;g;?1;5#Y<U,UV=IgHV>-[-2:[NdUfGL666dE/f3?)6Pc>&g]QIWB<ET3)
G,@G6Uf9_L\dJL[:dK.[a1,)KX@FQR<XF?#OM^WKU5HA2UJV+Sb<9U9.)>b#MPaF
J2>KW:gB^=AX)-UJ73TJ;9OCFSWg9?L(38]8@G1WKPJKX#e3P]3_Z[3gJTC#P^+_
EP(fGAc&eQ8W#2NS<8X6_,c9RfXMZ2.:2@N\V0Bga>]0M9<?_\T@0^QZ7NOKD<R.
MRRCGc#KLOCN+90.aH;C91NK06cGOUebNB;M7-PGQQD3gT05(@7ed[Y.bBDS3c+O
FF3[SMJV/I^+ea1U1,b4912<b?M.V5JUJAa(4:#=SbWS9078/]UD.H4.@.7EU-+O
#85;6gFI5@MF6W+L[C#@9MYeI.128<QMTe>Q@3PH(;XbC)WHJW1;G#IRV=Obg.S(
R0+VL^bAfLIIDH(@K+#X.\&LfY6[3cb=@J]G61Ia\;]#2gabU20DE)J@BN?=O>&K
?#:ZBZ,FO7Q/]4\M^YR-f^-(-Y=/]/OH)f6<O+[-:FWHIXW+J^f@=ALM]=>>Ege7
E^beAK(3-SAbD??[]H?De35FWg=(HgEETUCdB&9]K]38He/KaMf#b<Z<:0P2e\bN
;E7,I^TFeeBVWLRZ1Bc6BRU9_9O+.dbBWYc?e]7ReIF#87Zf\Eb9[^bP=H:3Y;<G
LQMZ-WI?6G^K9<,6P.P4UgCF)_C:+cFY1W2Z7eD&.IeR8I#?(>7(J<-6fKeeS(7I
:g^+#C.BPWDDU@-,CTU#SX(F@I@[+W+[[0X<LQY)&C8Od_3WQB69QAEC=;N\[^P;
)BG\RF5dOa7/.)/?EN+=#+g3,[SKQV9WU7ReGbQ.dL)@1Z>1;X,206P<#1SYIWM-
D?05QM(e;AU?DA1,04#]K,-Y8GY.\(T2HK7d#8WK+/5C7?D\IeeY38Q^49)H0P7]
SCRc2G1:/aE91:ASMW@-V-O9,N1fcC\WeHH2Y_4X86e>]8>f>aP^@@7IH&5R0cH=
\NXg.4\\LK_WTY=)IN-4Qg^8?X#[&XZH[X&?a_)U6Q=fRW;b8CJYbfM/]\Z9V9b5
5<:T7c\V.4ZZ4E9-3D90/6I.g_fF]E59W+gVW]4RU4e+QP_]KB,PE7Vfb#ONEH()
[WWV8BH]E.\[QK9P;,Ce.?g4C@:VM.+C2;d<:I545NM4aeb1,\M7I>YL#ACH102)
C\Q6g4BB@T-VG(2Sdgd35)6=6G6\eEU^?RK/ARd9T&UXPD9RV4W#\Uca@L@(EGY0
6@aP?MU4(#Q9dCfHQV;WN6EA,/I=;O=TSbaI;3#P8O7[FE<^MQK/B928#MY\LR=Z
V<-^@<I#[8>TZ/&P-Y<bF/86ING8Y[__XVF2(S5H)\4,[&YDNX8+e1]d,+;EWb/D
1VA1@<15Ub9Q]EX)a4Ca+-EU>Of-L@&?#;H.H1J#]f>K?L;+1:S@aK>Gb.1K;=4+
>H,eUfK#[S<LV>Xe][a2PQg\D@4AQLNV+A?<G4I)>[QF]VVC-DSVe1]Y47g,+U0.
9RG#75I:_=eg1>f[<:Q+DV];[D=g8Y<3_73SALA63740<D55&ROX05-B(M85(XPI
Y\3c9e?IeT3WU14N;5PSVL];TC,ILEP+BFg;PR2ANV^,(?97[+;CIPDfCPeHG3Y6
<a,gGM4ZQVF/bf//RM<8Wb(4gQ8]/4^->6egH@QgOeXaEgb?2Ye,TgZ&.WfK.;5;
5T8,L?.?TEWQK,+G:5MLc78V012CO,\Z(/gYXNI=IW]4&#-2)5F(+&G;QbK=-8]A
3S9e/?/52X[2Q;3K^RJELdJG+aH+3KLd1@@[0DA+ILSRTSH@H@I?^;R[b@)g[)Ia
773KD^g]_?T:fVV;YZ?6?LNJ+H_Y0+:6LU-SE@@B3&/9g?(RWQLG[G9(>R5C3ceW
b(,[,-9(g7(\E1X&QJd5eS4^TG5\_M;G@feN&;bb/3G&K+PeNC>WH,5P@AfKP\Q-
SBY?.a#P(e(RYa^3b+CH@8/<eg6\QX6gPPOU7\g:WF/2FBV1XUdFQM&>H#.QFPgZ
KGY]Y)FeB8L9R[f9VQCG^&,1^10,,FB+R=9;g[2Rd4Q<LI#9&)RDT><cRIW_E[a8
E#+/><O2BQI3VX#P71.d8R\KS(X4gJOX)?+Z?RO2cV+>T=Q[A^.7V40[0fR<C57D
(H)W0=#<=<4)gFP.(3Sd\aNWP_G1.5-)E=[ZQ)Wf3._Q=050_<K#>[T]A(B9_O2U
e=b>YR_f6;T>^5GKK4QI_DSb\O0-97Lg&^^4Z_ECX/3.^U)3;gM1G[GD,;P)9B.N
1A+CZ6,J-0X>-?aYWK0KU(]\QKaW1ODN#>>g,(_\G&cV&MG4c2?W<RU3JLND]^#I
0F4+-aE2WTXEJ\cLOO26K0a[LbPVM(d(O0:5V]09?RNT>>>.0,^NMFX3/HZ:/MU#
O08T\[DMP-9A;AE8ScS.IRS:?EEdQQA?^B5I]^7Z-+NCf1,[W[)gA:+S)gd[G];2
#.R-deL+ALICU@=)TY):+.M76/Mg6O7EdDEN9>+G<ZPV,Fc+8^,,303.2[F^X&@b
,d4Z-XJ8VT3A4Q=;TI\eU+J6)-]XVf(EHbR<OaV?AG[dba<3cOO]bN9\Ec[^P?W>
dF^N\cG/GG^R8UGI6P4b?IX?VKg8=W:3;L8ee]/19Qf1(Ie@O-@T4f0L=/-@K<cZ
@W^f0NZ])F\R6ZK8_UZ.0S:g0MEB3>I#).,PB0?b__ZC-E@+KFK7\Ad&OKa@PJYQ
&^BMDBL6[(G8LfA;2He>3b&OZHRZKe@_UPS<50>Y0:(V>Wgc1LIVU5&_&7-S;\32
DB3MDN-@AYNeP]@VJ\,6BL(Fe@cUaO6&^Q<@<>KA./GZD9+A#XUL@=H:gT3aO:I?
@Z\&L<24geD:JT3+2ZA]I@?9^ccW]e8/B,X.CTc5I0<dd.E40dga9VO+1#Z:4Uac
\7L/=.N8P]E&.(NC/ETVONPge1#AXN8Q9KS2+[Z3DJH39GI1]QI6JNbacJ7<^)L,
VfL#H.@WFaX>I:O->bd;dT4&BO)ES,Kg7FZTcKI6R1]@=@RP(_7NY5Y,b15Rc[,E
O3Z,dA,bUDM:YY4d^]KE,Ff9G[Y:90?gZ>eFZ?6SU3;^PfF(K9HMYYOB4ZGafa7c
?5J4INRM(SI@^^Id90HRV54\Zd]RS>U5a\6.5(0L)D/3@9B1AODJUI)9LY0:/A[N
PUB]C+4cf/G1-(Vf7:[2W/=,/ZSWUd7Q?OZ\99.U^Z^O]cPRa:5?T>-A-<4)WF>C
-e<:)Z][c+0HMda^:GQN8K#6/babBGCPe?SI3C)fgWU2A5U&Z8V501c:aX4G@:K:
1P863Y@<;G[8[#bL,HZ5XTK6Z>UF=/M5M;Z<aU6HcVQ6RY?>Sb_#TNY/J]5Vc-6O
=)aX?=Z[G-4T[0[0TV.\ZVT.6<=^6])\bF(SL3a+A/.cfS_A48GgcNG4>J_<(:I&
HaHfA;/XafLREVP5+@e(BXL3f2^7aUEYYKYTg]3.57&:fT\<W:Gc-HM+._=G>AH4
+&;FY+JG)74/+;b7B+J/cUXg.,b19\P^4:S3R8;>ODM8A]e?+7a76HR;][eUV=;:
]g_#.fVcN2P&6M1/a#-GLM8>A-Z=</.WM_b72L&>]b7V<SQ@L;;9Z[S-a[\;S?/b
?#U06VMV?PR0e9QES\93&&BHC<<c7=OBOC\/Med8eY650B@1DZ(#e#BI,O3K3,S/
59OP?J=V_a_9dN0LX:I3+1e._#fOdAPR+0ec8/RgAH^2JWIWg5#A1NZ;012OD7TB
HV8P-aU<P9TUGS-_MfX]+@Ea60eFWG+J#cJ_\Ea[KCY_KQ7MLb07#?L>Xg=A&9,W
S&/>YU=Hd]UW]S)V9/S#=X3&3REI8-P+=)7&bF--G](E),0?9(EKM.R+LcNb<,AZ
C;W<_>FR:M.;1REOA@XE;8@J2\7JI_-]O3>ZXE:?K=W7HcQ2MKQ-?]2:[6b6O2OK
VB]IBOGaO0)4)3&(V3QS:(,ec]H21cT)Ze:3[M:<^Z\-:F&Y81]MJ5X&DP0@_.10
\J]LX/,N2_W)fFced+JNJUTcE=DAI7Re^Nf+GR1:QP2&4)ZQg]cMG\Fd:&11HCVf
[gb.DO_UaH6U,+bQV3G2YH5EIT.)6)VAEd4\-.__]2IJC+8V#JBWf2I9;5+e4-?H
ENI-8cK1>XW_.L[bC16O@bBS3?ZF6/(&U5fTC,FP&@IEX;SN>=<&)UT__;VEB9.#
\>B#FHAeEXfFcNL7)&AeX,N)EdB1A;(LZc\X0<.W+;A:.I8Sd0dUOcDGEe_X0f;+
S/B2M_?+.P5L.MQX3MQ=_A>dU3#&-@JJ]@ZAN0.&W\@DU5)/VRWP3@.RPWgRM<@[
?6Lb/)/(g);OCK\[@ZeHH#T=#6JF6TR-,<>6>R&SY(Yca=3W^52KT29Td:GLI-S8
J6.O;4<UEBCeSY4GTEe?K(>+F+7(0T;[D0fCKFe1c:9[J6\X@D=@E;CVfA8@R2W]
f.Y&1Z,=^B>S(XL1g/,fK=]]CNHPbXFf^([QH0X+6M@ERYX1R#20DabP;C_@<0cS
dcCP>ZMC3+KXHGYGKeDO+5?TS,ad_=T1GG:]gf=Tb27TJD?(AP(]&#H\K?K+3N?F
<<T@W&Z>Q)8H0HY3-K.cM7;(N]<IJg;HM-X19Q=;0UDUKfJd+DUdf,BL&5Q85f9X
6EK;f>;GEF_1?M<f&K7-L73MHE&XCM8/f0bDB/R(dX[?#:PD8Y3_:U&P)38R_e+P
.4db(8K:&\/^6UgF9:Z>,)KdS49BN]9Z>:J1GQ(4NKJ=?SW?.1-GR\QfRU]^MEGP
#<0:XgcB30I3/O\5T[:U\U)LTCEOH7dIM3e\#/_F,UPW\DNV/.PRM94]QTDFc&?_
NHE?e])@M:GX5YGLLR6#0=H4J3\3.=cJF2=KP.Yd.9Q[H[@^_6AR[M7<BK_PQGd[
=FU]+9C#+>GUBIVUX:L<7\(;Q\AdA?@O&Z]+3#10dO+0RKP3^T84R-:^c6<G\B-_
Nf1-;)K;)DSMIG&]MSGF2^SDfGC)(F>)bIB+[P_4T&)dV225bAR.I^V2&JV);5##
,I4aAR(84+8cXP+c5<]_,[&_4Xf:5SP_dUQb&Dbf31AKeW:5;22QYIK4FLV6.BL-
P=IcMLQbeCTN#-f0\:&A38P7L0[KX^9=S0(3f>35L_C87M/8])RZ7?b##4]N#QaM
/aL,Y74M8bAEQW2[SAUEfN>K:ZZa1+8M4HfcUME(8<.M)]Gd(b)c>^Xf-7K/CGYB
]\S3^#e[]4b,&^)f=[4a^Z:KG2C,gY@FYV/gX.c5<VGY^=DZV3#TSA:7^]?;P^E)
.0/beB,QJX9Xb<ed1KKN3:+:03+Qgb#<:LNX;U?T]D^WZI@R8Qd=,E9L,c1f918>
4]7T0N3C-<0<AJ0f--c0@@^?,HC;YZKMET_WRQ>(S0?cR0>f2bP<NIYA/LW8GZAM
EDLWe5ea>U,_7MLJBCRJ5;?SS981=_\:XV9HJCIO9c:=eWZXDP33U]\LDbRC=HSL
cg8Xd?RI<:@(.&KbC3J?b,6f1U7+0=#Pe0:7HVg7KJfY#JfL#XU#(+<HK-J].Ae>
L)BBXD^BTgbE<)fN4MS/F_]e+)&egF7Z+J]&=93f+;5L4]c><1Se0dc_8Hg7g@H:
bK6PCdXbY3G,5FeV4UeQM)IAZI+@2994>WG6C[=LBP1;dN(b\#K=4>W.3e=TRM)O
PgJ;JF=(0XDWf),Y/dOVH_TeAe#V=?9f8675B<6Eg+:MZ^eEZH]B<&aM]J05BfW?
fK]VOPBKOY3:<#QP/QH=(M_N_MUXdD+ee:+&KK)+,:8I7@eeHUV6669VZWGIY?d7
BI,FHXc(J.?;4?W^f)9@NEBH5.^Ya2PXB]NYZH6D]aH[XH6VV6]GN/WCBFc4XK),
/e9TQH<&&^#SWO),PPf81HHR?.)FMXc7AMN)fQ\79OV+)RXA,G)ASg\R-V#NIAVK
&&BM,BfXP/B]CgC3GgbNX=WIDf+^2?5FJ&,#c-G]Y<0DP)?\9B6<)7>?-c0+,A]-
E-;gYBKH.8J+BR[)FIKEFa#Z7CDXA\bGB69[C<-<(Y5+@ceJWbQ3[L?U^46a\C\f
.4DLNEQ5e)]=HY_3+^K5VR#8UU1IM@E1/gP+)+WYc8MA?30<^GR>]L0,8X=BVRGB
JNXW[08O?WFCYN&eNBP+ZM6WW?P0CbdBQ^eb2I,-3aDBS_f9S27IY9+AJUDI_24[
SF,c[6KN@SDU915=53-NOfe3MHW]5[#[V7PJg=5.RV/H21U:7L]N<>H6D?eW-A@8
:LdV#+W[AXU&,0E&0g0HEG[fPMPg:[_<VF/Fb0^9.@T70T5V@,Z889Z6#Q7<JD:M
6O&6^P0[\EKU@-\g589@Y##LQE7HZ>MC7^,_dL78]@\+=M=V=I^89ZTc8RaH3#b^
FLL+,//-c[L7FT[/[MWeOf(Y8_>VKR7@XL,gD3)132NJI;9Oa+BeIbR.M8YDAJ7K
&L]ZVdA\@P&^4K,0?bMVEcZ(1Z0A_]&Wd/C#5UW68X/CZ4=<X7a_8B[DF+>6YQbQ
CE.TaK/D74SZ1M431\YZL7e&^O+ZK64]MN@c33Ve47)M;.QQHb9:MZ^Teg(UcKE&
F-e\F[F^\B+0Q&@:PEC#e[YaV[IT,2fA4=@\H<\eR_QY3P@g,)bTaILI/:eeeP4D
E&M]K/0O@,>2Ya6;O&g@7dYNI1EB4cC&a6SMBDUQXA(,5=I=]K_6Fg-_g^\KG_#R
-eB&Fd(^6LVKW&@80dD>4,R6dPUD:R-:-5KR?1FO;RMT<d&?\26?&&QO.I)LV#Db
E14+USVHH71e\g]7T4686:QT^0WODT)[5FER6Q<>B3@PLee:=TR&E?&U.9-+MP/8
[9XL1=c=A0_JD=N,5XVF4H,KaLV>M\Zd8)XTM_YY9X/<]CW6C<(0[d366g_+g]Ne
=PH?MeX;-.E&JN+;RCQ)Cca^H28OD=8:APT)GQ4OIC=\dY:AM^2&U&L_..-J\GI?
>L>PM,SZd>U6#S1.cF]0FNF>HGL&P5AD,<61aT>1AYZ-]B3>H>3G^VS6;7NT=L-H
&9>-4<^UFb];X-3V^9_QA[D7>[LQ@:__b.IM72>^bE)f.:N;bZ,^G8;^2fGOEU2K
/(eYK78DR0986EXf;#)R91M-49)2F5VR-+K_JgPX8:RRa/5@,[=P\D#<\1.L?>_V
V-TK+bJDMF>BW\.c375TC@a0O#+=M,J[\9X+LZ@^5@\3Z-0@]W<&F#?EWg0^^S_J
<IH#H(MT6:5g=#;>3<0&c):KG?4EAU(;FO]BF9Qd:gf0OB]V/#>J>#]\a,W;YM:8
A[dMB\,@.5V+&EaJ<U#&I]RRYS0d\NG3V0?fI8gLe&FDV52SKK(L>Id\Ibgg@:b.
d2cR)--Qb7fHfDa89C>].dcXY#UCL5T&a49cB?Ae]FWf?<BCafX54(TCF8I-Xba&
OYU=EFF/PXa^\1FCc_B7@ZbD#OQ[K:I=/f+^5OF])NQ5Ib^AFYF)VNU]8P)d.H08
0&g1\&JTEKMT\.ES^L)3.H8a1.RKHWRNIR&P#JgIX?UDR73[IL8DA0E1<AFO6S\6
CRU#3Y0NH/FHH9C5:Y^]-UQX3]XOXR&bfD&9<@B+AV0Y^+dCYcN3\::R4NS9.U9(
9P#3#a^+A//ea]79K,MPFfDgCE5bZZU5O-<W2aN,_>W.+_&Wg@Y[QSOC6G@g(@Y+
+0WI7\Ae@ZDZ061)ee_)KEFQNY:dOB<]/LR\\,cG0^#ZK6]>F+M;2KCL,E7NeQ[c
QHdW8A2bJ>JLO:R5[EA16P_/.2e]gWK^S7QdOI#+9DR(Wbe,fV,,MN[2F4-:#\BS
ZFA,FH#V2+5?ZM0#28X3+O1f4c8W4QEQ2HbCC:B7g]/cBQF0F]J5RYY0\<STH3/Z
V:T#f\gFTB[..O@.D307Y,D7QPGU(_c_.Z9D[)MI1DABd#ES&(PTX<:+J4&E-Q&O
<?Z\0]2H9HNd6Nag+gJ/\_[bVe6IBgJgNe4b4@D^QZR@7EK>9+c<75@RZgNKW+&e
YW;-7PfX_B9_=BXIDZg^LdCOfeVKWaAX(-a&8QH459.JU;)Mc=29,URe)gLYI_1f
AVH(P1.\(8AR@N=UaX()(6W?N9eR-@[ORTX_@9&Q,242b=3,.aTQ/gd?g&/F)LX#
D6E\aX\1&=#3ecTg#ES78cAAR)RcXb/LT/B:.Z=-ET7aJ?f2+>=EGF4:JTE:cS8K
4/BBBOG0F7KJ(:a9\18K+Y2Caa:MKQFR;A@ISH;YddZCK1GIAfE4gRJ1eff67VgM
?0][b+\dI6Ec.IYF9;,FQ8Og/M>XHZf:?LMXf&O0RaQ>7=6;:^9:QB-2+_GM3f,B
b+]8GLW(C03OD[;#4F(;=F<8\PH;=Cc7A566YZgOe=7;@/a#WAT3.LTbVT4[d:26
B,_F7BE(d8B@a[J88IQScHI=,2.2b^83,NI85ILUC.UKY++IZ1;RV/21PX&ZM-;^
b8OQJ-W&NPF_B07MUI0(O1><D2#Y8P-+VSN=+WV[]b6AS^a_R5\L<P8CY>X6Y-B0
>bb@=5\E?YXJB4fdSgL2(5S;32(IK^21dK,IL;a,;V\-+^M\ARH[XD4G/-HgQgaV
O92NJY3B4afEbD3F_)PIUc+3:Q>6B?]=[8;)B0PGa33:)]Wc&DH[1#+?CG:;EC)7
LEfDIFRFb,)Z2._F^;-fc&>?++J_Ha,RF7;dH9]])6+:8@SO274B?.A,4R?K2_,^
HCEUN=^=^6LdM]))-?]Z#(5>4#KM;CV=J1NZU(K,D_N2=K;E/XcF&^:1YOD&<FeB
MM-HD08;MC?9O+b&B]eM<S;_>MSF)XV9VEKZ@8C#F0c<E3S-(Nb+]M79[?1(OT7L
MXSK\0;CR?@OWBF;_XI)?J<;KCPD0\UfNaI=J@Lb,7C+#NLE)9BGHV&B2EKESBI#
c8#YBgDE@A7;M&J;@9,JYe1F9XeNT0XU_:_IM20eB.\QKYb.S=J6Ia;1G6dW9dLA
@)9Q/PcGPcVQEF_C?,9MB_HO/##>J0^HASO/6O>]]HQNJ0MbVL7W&&bW_XOF8[Ze
?CORN1bRfGB^Vb_[(a1[Q72P4:3D-.1<Q<DQ\++CH,,GKWNfV0<D01.N5>N<ESgc
c74Jb/&\1U)3HV@f9&0=^;]_/SM+0gQ\/5TM1@\V2R&R^<<&#4B8;FT1^NfYN7O:
JUJVU_5ISN^?<AHCN;-/,[_+#P+62O,cZJdNKe-_OPcA&7<=7:#2I@a628ZacXD\
5KfEUNb.A@RUa6_GV[f5SU3R<6AMBC6.E7,&I?Jd@8)8[7^Rgd>^QUW]>L[U#UKV
O?]87aH^0-16(bI(E7>>?f7?V6D6A(05OV<Vc87PD#<=O3;eO[J216R-^ZJVS281
E>J&P-B9g[6Ta)82@WMH5BRWSe).@6M[.>99bX.UVN[7./),MLWYRF;7Z^M)8F0G
8S.ZR/4EcI@COVJ>761DT0faA=238WYV&?_e\2D71BOg+E5OAVC@I7-O^L^a369,
-/A#bLIT=Qa+F9HSL/Wc9PEV[UG(aRZ9JVa1aa?X5-4>[XDA423X7KE>Md7VTFYS
WbC=JU_2M[<&;c<5NK:B#NbeX1eF1=D(.fe<QNeUSc:dEJ1W(T+@0+7>V]d_G4bD
V0L0@74E8YH4-X77c:SPIeYBd;U/]?CUbME/::TK1D((WY(/7eJFMLQfgLN)ES:V
a<JWB8?e-KS6)K([RM,31T)TB)C\J:e]-0X4[T#-+B&8AZG#3)E7\0(86C@^U.PM
?MLV<#T_EL;;<f7:7K9<TFC5gA3?AD#T;dQD521fd#_\;eX^1Q^0V+cNcF2M4TD2
Vf<CQ]7E@W-dY7WJ0D==>D;[KLXcPO+Z0A??eDSJ]32G4[F.QdS9gJd2.-^H>cIG
5);2X]#XQ\.D.HL@KV6G(2#@aP--S)=4+_4AA>cLV)ZdT0/Lb=FQ\6,>0BRb;g)2
KW0E:d+dD)[g-)J8WU<RQT9,AE,UUagUDQLM4OMWWBE-H)]K4DB^83L?@<T_YfUS
a(?FG^//Wg:FdI8^8V7E1<_1)PH,7U#E#UQV3,EJ3d/J;gdbA#0JL@8c&YKMV=PG
2Mg_?B/GFUP_BB,V\U3dM3Y@UN.da2J00CNP+\JO]#:;gQL090]N.M593VV0R/0<
GB;4M,3N9F;d_,(&?;I42>HVM]X-\+1X9N5;DEcQ4?K4UQQ]Q,\_E&.UO/MTC>A(
V5]\8//YQZZAc&83gP@5WcDcbaWb<STX0eKb3^#34C:eZFZF.[B;GH@4046ZO2@4
SRf6dK#P.=KA>5;6e:A/^Z+CbN3\K.dDB3S@_eH^Z6[?GV).]B/1IFIZCfTL((J5
_5+d(7+>:(;V;2VSC1\G8&3HKU[QN=^Y<J/0d11C,KVeYUc^JJ/-)ITacL6QF7&D
5Pa40PX/1,E9V8T4Z[U)cTRMg\C\M+DLW#e8WfT.GW9NS^YKD<^c)cLfb]MOUNf8
V[FBCEaITb[HLI2<:<db&Q.a11)L=I\Q4]RP8.FWB2#A)0O8AQM/:1E)fOL6#.H_
G9CdWaPRfC2WC@8^F/gU7[7C1\:JX=aJdUeKSNDGUG9ZFC7Ta:&&#]BfZ?\Q/68.
PPHDGHLRQQU.&>\a^G83Y(Ue.Z6>8ATN=TKB<;a90>gS\WI.6g<g:Lf(R78ALSZ0
5\M(T;OF0LTP?PaTGe<67KCW6==W>gLMXAJRW);9:<b(;JHMXR<P+4X0:):eU>,_
.56\CAP8fSAHBT.SVGJ;b];UO(CZbc/DQ^Y7:&eCH1Z)QHU[DN=:K7ZJCI8:57>8
8_84I1?g:76^,_?gI/@(6H]337)c&0gWO1K@YbT_]U7+C?&EaA)DeeX_DPC3(g99
.G3)bbB,afYbNTEK#RT3.9#ZB54\K0?QZMCge2V(H+0M@gP\6R-0d=dX:[e1<KgA
?5=9UEJ[>=e;J00UOAV<,UE\9g/=YU?8A<gTN@6HGGHJHcDCFgH]\T@;_O058b[\
=V/FT^8EF7)Zb=(C_/BP@/R8NbO\2T(<=CJHY#6YFfc;55B7bVB=Q,^FH#EaEGI5
^[AYCc&Z=Q-dWV8TI4IC0>ZZaUg6-+:FS97b@cT]f<_Xa]N75dKcQS-&U0@#&KZ5
Kd_/JX=S2@7^ID[R7U(a.Zec6If#RW;C#(]_9UJP:aMMQ+@aJIOSDLP\]&PFe@:I
I<TO3Y]/OC3N6H9;U+,bLL-/a&Q/7HZE=&/,RNABB/,?.O>H:JcL6Kg_KeF@WL9.
(=IO+SGIC]2,,c<E2W[3eZ9.UYJAU3YLM]b-dEYG+/E:-ID:-A22:(@56@=5f?]M
ZG^5f/X^Lc.S4]-?L;S03<^/(7]Q_dM>He/^&a9HVEc+]I@Ke1401gFE>6aO9MF)
.Wg8W42E;10CM<)e0KFg]/>J)154LD6WUO8V<FbIc1-Pg;gW#2^DJ[d.Qc,WN<X(
Z5UXg9T@1S>Y]JQWBV>;9?NWF5S.&YgI>cO2VaRLCM]A(6@TUfKdPA/ZBH72)DC9
W:_C3dbfQR5R]8_^1TNWH&>6b\8Z(+W>QI]RbgSQ;HH8:4Oae/UgX;6_#Y/>OgS4
Ua#-a^6_2g=JK;D.KT3-)J0X7+76:YOe)8Q(L^;C^-^);GIE-aa;1NQ+FfQc.A@U
^&G@;PIDDM]+fa)B_FeB+MJ#X<cN<\(eIWdDZ/Z;Tc6fI4:f+&bBE<)e]TKfI;]9
\B@J[C_GS;b8G;8LgZOcS]+UXaI6IPe;I8OU27bORX94aa]4J945^WP_B9>JWd0L
_GZN#TO7)+-gHRC/d]Q:gHPMV8dPE2e/0fX8N&MXdb_cQV)fNC\21=Y-M;9[]gc.
Lab,OC[c#[<ad.OBT3-V>N[H3?D3c_bIF/8?2QIKF:M&2M<7?5bS.YZMQ/)WHYL_
Y<Ge#[#C4M^7OC9TZ1RVDKBQ/AJP6.>a]dcI]3\,Z\<ag3bVS3b3W,4=adDdJ]fA
KWKWGJe?B=V11H[G+E??eRU>24V58L<NX1fPXC7Bd<0GB=e&[)N,HP6Y/EMR8J^(
PN9d5G/:Y:G._f4,03:d);2NH#EK?7P[R78U67R4#H>dJZ70@\8#B\CfBB4/QR?1
X9H]E-?8RZK27GE]G,b[+\FfTSGS]E61H,L&_FUK;+;:Q+HKC6P.=OZg(8\V#eR9
d4GY?1TGdTCKL:/NSg])(JcZXaJ32P<C7a=X,N0D9PO[I611(FA66WY2663#@V<2
WITVgO)S[?5PO4D_\;8)3?,CE/#E&,F30ZDWOY-3-MBDY/NeODA0Cd6V>;>+bJ1e
PQ;g/YNNO5AL6ZNOEAUR^/ZQ8BHe7[2C)R:.G5YZ1SV:0)AN&:,bY9bI3KVI<=Q3
S+eNG^9@SgIBF:)<8Vg0;\.104-?/T\B1b[g6>/W&d+RVIIbK4T9_SR2]((C#ZW8
(7A_31E+a/-/d73N#GIAR@K2fb2K;067S)00D=fI^:/0>e&7OGd(O:QBA9I4X;V@
0\QCCQ\@/aD&1d7gIJ=O0\T4Qf0A\M7_@Q23A19+\^.g-K.IQM<8_(3E4Y/,DJ<4
<RLG9^f]TWAXd@D46X0;7AcV<6U7<YP#R7eZW9d3gR8@@_bf\30FeT3[Y7egLag,
]ZY4T>AKMCfdD#UK^<-<5/9;A]Z#+\Fd18?55ILe/GGeL+J_=7f_8FfAA6NMG37Q
/C+#[>Bc)S=?G7-_Sd3PB>DH6eZG7AW7>Q?Z4^4&CD4NKK.LDDHbMLT2:ZL8a+-)
)HZJA@e(Nf#)Q.02aDEXA;@VYBE#:-:GQT99d,GXd4I^-29cY3X/U,,,EADYB,c^
-W8:9b83CL)WL6Z&5I,#(+K#&[1UFY6CDe;O&_DESN)aN(MF[+A9U7OPB3+MUG4J
OJ3PaT;E.&^<,6F;>e@DbE43->(D;[F6d>@a<58EE>554AeKPA;8d:aSa;Z326bY
OG+\cXV@e51Pa<->VQ3WV.Q;UW)DMA8S&?F^WOM0c>^K^MGPX4Hd9C03^&TBS,#A
d5(cJ_?Z4Q:<@[4S[gV9S&MYTCgTGLWI/2:J\+2RPPRJ_SK<X]b3O6,@EDbN<Xb,
(HB+b;J/c5T5_37bD\(4:FP#db_:@@f68H@US<4BC>6b:G1K_]9#8\6^@?]9Y@5T
,44QIKfR[BI4aUT.]^+/YHe.N/FPLV\9TQ?3D;cbP5BeULD29S16d<WRgf:^=9>P
/e[RID;F6.<??NTD)_05[W<Ld+9,b<KeV6OZGJB/QT[I:ea:gL.gOc?Te>6#^X1<
(YB&eTT\L=@?DgA#H\=gA_6&?0Id/HNVH2dL<@9X7K?:&8J;<7];.La3<Y]-3XU=
(VX]XOg6Hf0Z\3,#CF8S6GKVY+ffLL6@&f@BJb,A[G&c9?Y_9Hg-L:P&YBPY2f78
U[<8TUV5,:]0@+f0S[+B_@BDIN5[P1=;3:b42/HENL,Se4Sd4f=\12NUD#=Q564;
QGM)KQ:.cAbSJ:9bb5/+B3NI/#TWF0(;aF15\M-6^48W[N@P0GD0S7DBeb63A3d[
O_N<T1)=UAa+#YU?+XN_(_8T<-Q;[dY<@._9eg7geS2VN1\O-a/#RNDP?.U[+&Z+
87-A;7.^A38C1]HEV]HKCWc@F[Y&;,N/D8D7&[<?>Eb_XH4S0XV=)JW7_C499530
/7FT8+R[Zg2#=FbfGb5eXgb<D7T##S+NgcBZ)cKZUFF^QYQ\?8UND+/;I?F8R)(+
7<e,gE.2gP4T9J/6DGb)94YO,62893)\J4MfLeG2HZcfPTE)dBG]f#?I8O<=FU-I
7];;.-P>-=SA7)e/aUR3S9dU+YO_Ia\1bY_5/851,--M)7R8a:I/TP_gc+_O[K=?
BF#Y6IVG^?=EOS).Fg5\/N4>#++L,)8F<?PJ]R:@V6U(:_BfLF\75A4#GP]^fQ,L
&8d&OQ#IW#XNRE(\4#3J(C,=g&/Q^LO60BaI:L01#D^2OT9a/]-<?Aac)HgCD5Qd
Q#9AAJM<1UI948b0LITJGIN<-JY#;0C>EHH>D<X;A+/8[Hde1gYJ#2a\=a=MCL:E
L9:_.eI#6[B,\I:JKL65]PZfeO06[=-b;+?g]/JFd.@[3AT(^6A6[N9YVUC28;g2
ABYTg1>HTdNRbRLNRaNJUO?\4L3H5K_+@bUgSW@2>]\YD30Q,&DP5#W^[9SD30O8
C@>>\])I;-1^FRbgC:E9;/g.[ZGPfGB?<A&AFaTJ(A7E=8?CJdaI#8-;dV21-\XC
M_(Nc;_N8UH<9BBZLG0B85c;0Dce5Q18/.<>,:F=bOcZ25ad?^/=>H4:Od3GK3,9
JD0AR;0^&(;TW)LIU[J:;Y^#IRJO)S0Da34eTEbZ,RU]W)7<T39Gd]RFC3?O[\6&
;3GK8N0LD&)7UC:)H19E4>f71YD&]>[gX#E:DPaaD-:&88H1XNgYN_:-c]W=4=IZ
SXd8\Y+IPIHD;[2<JA&f<]c,_ZQZJfF0Tc>WBOB&F[X,[+.V8R:YbZDdB_SfA9/d
\GY_COT0#bEDCL6_JaY;5>X&PV=[LFP:7;bFCYGAW@><5;(J=8]aJ&;LeYI1;2IJ
5b+H&-^A4V_-\[H378e^]:XM6(K^YS)1.#8GWHUN)##OBSI6QeX+;(()84<X+0ce
>b5)V0R81IE8#T3O/cKa3)O]X&R-+(24OI3e;@=a/;^#76P-(58XP/KU6CB^b/?&
U4.@,0e)15dJ7R3Mb]_U-N5-<03V,9<6cb6P@-EK+CN(VX<&0KK18c4EMFOKYG2=
B;D\UJ[bCJa?Xg7;;7Yg7Sg]a-RJ=NY@d&PFa>W+M9DLM/Y3RHGA=f@gWe[)aaY_
>\?YJId]3>CMQH@Of]8P:LI@9O4O<4Jf-V9V@.1U_AXeXe8T-9LQ(DE>Z+-Kb66+
<^81-b\b2C&O?==V]YM=MRG=-=8FE7G4.8:TBAKHS.VB\OIZaI;((M3TWJc0#=V+W$
`endprotected

`endif
`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
