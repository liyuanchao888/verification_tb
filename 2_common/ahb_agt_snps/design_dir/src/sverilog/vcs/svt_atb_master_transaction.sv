
`ifndef GUARD_SVT_ATB_MASTER_TRANSACTION_SV
`define GUARD_SVT_ATB_MASTER_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    This is the base transaction type which contains all the physical
    attributes of the transaction like id, data, burst length,
    etc. It also provides the timing information of the transaction to the
    master & slave transactors, that is, delays for valid and ready signals
    with respect to some reference events. 
    
    The svt_atb_master_transaction also contains a handle to configuration object of
    type #svt_atb_port_configuration, which provides the configuration of the
    port on which this transaction would be applied. The port configuration is
    used during randomizing the transaction.
 */
class svt_atb_master_transaction extends svt_atb_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_atb_master_transaction)
`endif


  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_atb_master_transaction", "class" );
`endif

  /** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;

  /** local variable to help in randomization */
  local rand bit primary_prop;
  //local rand bit force_zero_data_valid_delay;
  /** @endcond */
 
//vcs_vip_protect
`protected
S?SH2847P9>NZM\@GO#gHO15+P7XB5H4d_=b>YDHV]8ReGB-FdCg-(G>e].6?\V=
UD@DD>aLaZ>g0?6V/Ge2<)_cN-LPeaWI.b(_QI4F5>=^JD>_QEH8?9Z<F,2a]@5c
)@NCMTFVCOSJ9AbcX3=#aaGBC[,R8SQ7f\?[^XBGMId+Se0)R<_I(MRJB08-=?63
d(<O;SH\C(G4dP=DU=6(EC32;2@1.)7A=\?^\[I7FJJ;cCN]8M6E[Q37Y<MG06+&
b?gXgX1^C48:\C5g-b^E19[dW=5P(Q4<Z7>8_(\<>V6?DNGF/Vg/#A<FC8eNTC?F
G?:U.1TQX7=Y>^IUABC+^P[a2:W_eS</,@^P8Y#];Ge<KL)VO+^Z(cg7cV)N^VR_
6?D6_b/.?Q^UL)O\NYWO(eT_bOgc1@8@F&]H6EK/NVY8YIGLD3eJD=.G@(38S?g+
7<(UA^]]NU+b]&b_MB@I9GH[^.2W_g9P>)AN05]NB;8/OVZ]D<?BJPXSA2]UT,(G
?<XL[,Jb,9F,Qd2V?P1bDGG8-47b9I8P#;61IJA<15+?ZYAZ]e2WJ[/Ib3\g^3O@
;3CZLMY^A(IQOFN&dB:3U_Q)d8CJ_D=g5597,&K[JXDIc1>Ud;e75X7LSe_ZR.6[
DF]:b2?J._S2A:Z_LV\-fRWbRcS5B-5^29^;>38g2^c0Eea[X+0E-DCEXVG+ZZ;O
XZ(?)g(TffG^=SCg3^EO\Ic_NJ#2K?QF#LZQ;]@baMR<c6N.HSL6g0X5\,OHMBNP
36d84QUA=gFa)-L2B\\_eD[cFe=)bDW_)^OE-P<PXW,HT8<L/D,f2f,gOKAQee[1
c&cW+>5dRRW5Q=\G\H_+\QU_+V5ZVgHWU4>TFP4:TS/eHaUH8O-cWWUVVd>@8=Yb
-;fb+ZIKFI7QTW#1)_]GT)U]Q<A=KHL?D(@;9-T@S)2S6/WY7HLfF8/Od/Ha-e9a
-6IcV\PZ<c4\S;9[9MCJHAc=\#^56&a7PDMDA+f5]I\B5:^7_1ZO6bZ37?G-XUK&
LZ@]gfL>9)-G[VIN]+3PR4Jf(Y657\B1>[4H@2DW9&<1TYU>&#MX1_L3D1O5E-bO
XcC:R;J3VD5@Tg3W)+CI&ML=<eABJ^;URKd9XTF[3fQAG#[DMUdDJ5[Q2>+C0fbU
]c\ZK#,-AT,#N/[9.KQCf_LA3B[fJ&:7L1-B6ZI8Q>gAJ=XV5-BO-=A0f+5O2D2\
6[(fg4Z[(,:<@_;39-8<f@QX&?Me\McIXXQ@&XZ0(fb7.-_Q+TZ+SdXMV2J1C<]T
0+74@JV568,PNZ7G)E-KRQLW\8]ZgTQ;bQT_N2SMD_bV2B4\S&KbV84\B7:?0\;^
JUQ.D.AO9Ug2CQ4>0?aPE<N^)dMU43:2A+,c]KS:a0D7?TdD39KM+CL@H:XHNc6\
3VX]4aN7WHQ&LM_[?UH+=Tb<6Qde>EC8O_[bgY.QYe]cfHG([O[JC5]HR/PC3WdO
?8CVPNVI8>2189:_RD?[1FG3fBJBb#@aDE4eP#+W(CfW=QeN#>dBTS=bE@@&6GAU
V)&,RY,]D=X3\KE])LgLB;O4-/[bZ)<:KRT9]AA7>E3aN.&L2.Z6(#PW:aH)W)7+
MY>fL?e5+C>JCOeRg699O/(ae<;3W)A+)S1?@P0OW1<S&_b8_0:_)_@[E#;8F)1U
>&639_&T4>QUVObdVA[RHKaZc>FQT9eaIL6+B=CRT-5(0:@g\+BPR4D^[+1dMH(7
\3WG&1VHF(-4b8gK43FJ_F?HD<(AZ4,aTTgN6L;6<CWFW[DM:+2XGVOGB=P[:Z9I
_N@LgMCY?W:II(P[9D3AZaY7JR5>/1fPg6VYf@cP]<P3:N,8d=A?_O[<72GCFZ7E
g.((@]_^+<V#QA<WXAIcA<X6c?=G8FGaZaLHfO093@C.eag@P?&X^:<1Q,Q64&AH
V4>DCU)9QDb<<;>;W;@7:KJe8\NZ))#;[:P\XcM6CU5WDdL42DV>A7P&RZ<#DZGg
G?HTZagW.0DM1bN_e4IDU3,-b3(O9)4EZ<.TeED,LfM^KG&+65gT/cBP2<L&U8N>
:ZP-E3&<FSZ9gc9NS1V8fSYO#M<G[#(I.6WFRU_N7&WFb.@5#ZQ\\QCC;K^C8Og#
Oa<,,+E5-dY-8VI:F1HVHC^WR442@I\8>.[I?(5[KBM?(3Ze3II<cd3H/H<+@^[O
&cB1]SM/f\BaAHM-Pb.@5#FYE3eV[XL@.WI48Pd=80C>HXP7b;L.DY/+ARW^@;f4
R_f)5JZT7Y_JBc<AEV4JN77NY,MRe55(&(ENB=CG-gGQ4G3F[IeYMga3;N]C\bWB
H>/8P;7gN(EC54a)@E)VEPa?K#OTgN9N@;UVYZ0_e94V+aS?a&8^>LKZd3d<PWS)
@L(JG_,,Fd2K2T#T[=;A7X@bF82KV#0=eR+?:.(E+Y:[I7G?WKW#6HW;7X7c1)0c
\)<>MGTgWZ7J-[FRfW__(98g8A-1R@2D;L8LE^;16(E(c<YUaF01G<ZQ+ZT<UE,N
&&.ETE&FT)dc]f=gTL=c;gZGP4>.H_@F<(GM=gdF_:.>P4))(WR\E&B3g-.)e1Pf
;eVPC)E?4]IM:?9Q;QASZ(SS\6U2Cg+C&&,d=dD]Z+X)6gA>>-/c<=;&<,/CeC=[
=[Rc,XAeSf\=_gIVSPC3UFGc8DRKG(T:O=<N6LZBfDL]C=dYO>5DRZOBM2(//1?V
&[-,C7XVS(Y+1+T3)5-8UB0B=<Q7g?(L,^6ZOTQ?<cf,A3cDM(^5FY2W.BAR+eO?
C:0(KcY(6</P+H=BW?5RP-7.;Ib(C@8.6/=G[?H\:@d<f+[a4Pf,8&WHG\H2&R2T
E5@&_W,;2HUVC\JO2F32]\&&VG[eBc:Cgd7bP?>D31U)CC@=<\X_L7D,HFg6e@?T
[]FUG[g,Fg96MgMZ?d?F#UPJ5gb9S5^Ze[e_gMa._9/IgK50OT&L]/5g2Le05Dcb
\IJG6IPaC9:eW1TdTH<1T@1-CT_,D(--d:V(b=@?H&1eNb@PPPGZC@/^Y<OVf[.?
S5&A@H.DL_>:eLd=+2YN#Z;13fOfc1CL3,9g1T>V?A)ZUM?=E00/Z,E4=(@DN+8\
XZWOZcbFfA9c:Od/?KbM81[NW3XMA\]9B4F:Q^gA4U0ZO4V9-AN=Y08Iac<REQM1
GV(R,W)b0)RAOSCT0UG[;_Rc,Sf9Y&.P(0GegE-faI8.YMG)0G);6Cc,9]AW5,0#
RJDS,:9gVB.0I65E9<YV;dQE@73AU:+ZQ6^.5OeH;?Ed=faM?&;X3.&E;V+3(7+E
-PS,@MC;g5&,]8XJ.gSFXT]=6SbC(UWG[<Y_eg@((WNLD389JU^[d:HHI\Q0T5V:
2acY[Pe0,F<;9>;2O\Ed\DJefO#=]Ff4_U.Z9JbM?PVTIXAaL3dIKc7\b?U&GY,D
):#?8/]]bb@7L7VFM,TQK1d]:=T87>VLcNM?L09D1Y(V3?-eAUHRGK3CXHI6?/Y0
58RdRQRWTY3,45DD?PN\=8QRBCWJ0A>31@@Ta5dKMI87gQ.G@5\7810UcbMS:.e,
Da0#f4G;8-c4[N5DQD(:26PeT=.;Bd2N(TLG^b+<(HC831KgD/FB)3-VO^YgGcD<
A\@CF#X0X8NIPYbf:9#E>QY9L@#;KH085UBCe9FcS(@]_KX^=C(5<C-Q+8#2ZKb]
;[_4+&@^N73./<R<XN@abgN_P^NQeGg98FX9ge;ZD],V9:8f=Ia3+/8f-\cF,M7/
Ma;WOXH:2\,?PHf#g1caI.#86gG#TZ-G6).b_4f/OAdTDX,ELC#LN\92(fJ4OU8?
[=L/LETJZXH#69LSBR&;NI9>a#TANd]H)9AY404P3N8PHZQB=5JD1SLeX#=K;UEE
5DYADA:^](;[XPRN7.]I3I]L<CP:gbF/?RH_Ud:^[S<Q&UGSW49C/6.80bb6X.dY
_f@^&6P/R4dJK8:>=T(A;P/F1<R84T>\VI@4fLG?<<AV/?9d)KHSU_1.W(c^F0;K
U\=:,aM-,Q+I[7U<?.Y>^>bF.MB&LCRE8c>6BA]NU[,<^eGP),)A9&P1U4@5@QC&
RMD\&FNQTgB#_&\(c#b?@&T-QNN\<BMWLVX^B+-LCN_#?&^e[)QMCcU,R)C885bP
5)\d/dG7f5>;CJI)):1.R6JcReTH(b&?FeEc9N#D1&\/DL8)f,]-#N,Z9YWPHagR
M[Z^&bM4(O,<C@@eXZ[Y-SRKe<dP_V_<O.Ta^gNNR<FXX5JAGGVMRFKDU(#AJS2]
(N6F.R+Sf?.aD0)@JI^M&6TW]3RFecC\O=B@8]PS;gOC/@:GTLC+bA<b<g[F0HNF
8#,d>N#HLAZZ2ZD8PYM/A,>N\:KMBD-L?:P53T,8&c?PN]_Oa2X@+Rf^d+Zaa.H[
(\_Z.W#(J;^UHO[/ddJSb0gU(-IC5>=.WHf:6@JD\75ZJEd)IZVDP-MUfL:\LWHg
X3]N[70M2fXeOXcQ5UU>[aN/c1fGKJ.KT_bSZg70;#GS@T.MD4(2_UTA\]IY5@0\
e)=@4[gOef#5+NGD+O:(6,M=gddZ4OE)D(1Q><-3>3S)+C?XKRO[3:8a>?+\_cB[
KaW7+7DCHP)WDaQG/=A:JcHdOc>COC+?N\OM6=:LW6eM[P8N@VCIaP3dGFe#J/1_
Z,(eZ#NA/><O\Yb:8/-#_\#XYR?G:-^?BRcX[e,&G1IX^5I>[G_BZ1:1R&GWNWQ\
a&+9PVOOC)&>V]4?ZKRL&RgN:0eaSY10CU(M9F3BceQL/DBMBdX/8Cfg-3/PeYDI
H<B6;U#][II4.5K.VUgWJ#/B51-_TCF=,7E?B1I@K+WH,#PZ0be2Y.\_dB+dNN.5
4>a=USG6WUB[gEYDbeZFMBRMgNb&\WH/DWH_AGN;.97+/e<I>^UX/LNU>DB0<=VU
WICT?DV=cM#[+QCY+GM)A)GWX3W7Y<Y#<YHG[HAIK:,e]RPJBFB.F9_5.JD>^=EE
2[4C[@\/[L1OPF:\[2\g9Y4QZ[HHO=I;8W(Qf5/<A/VAZH9&B#MUcG?A2_PG0R?K
cEJ,c)^(+Z6WbR?,<@g#WWYPLURSgLEMQN&W&b2\XLVB?H<?Pf?[.Jg;;7/+0aa[
<HO+U7?MW9NWe\0I<ZA7:W=K)R>3854>#NTaR(?TfZ@I?XU-?2QIVTIN47eLBL_=
N/UC\C_(G<:1ZHRe.AV:QD6/+7IX7@=(H_?gLfI9S^S?J>><)ECLOaA5]Ad;_U]6
L0OLcJKZFL:S[XGL3A35,+QOZ]&MSSQ#Lc=,1A/[Z?P>PZM]P9IY>3Z?&_-LfDVC
Kb7P/Yd7DcJZW+CgJ/0>T.^8IDVSaS9QS>/O4)GeW)JeCMP<,U@d;(1/ff\OIC(B
[V7?J<P]@DU+N1\#K]ab2V?Yb8WaNe+QG=g\\b>5EB;R40I3LR)T:.Zb0JeNN=@^
Y4d4-7AO\6&PQL4-B/_P=TB#D-2:<WfSeT<I\TZUbY73AW0dH9Hc>>LP1a_LB)7Z
2N(TW#Y76)QA;93CFJ)a+Q5HYX;,#)E(;Of6[Q;NB/FHFAXQ2P9dZ_dS^>IVEQHf
K+R<YMY=e/f8L:a9Y)OIaRSZ_6(gFG.c&a.OKGY7bbRJHWGg5,SYb_?WG<[Z83OB
S54LH#96M=6,^19Ub_AcBEdIZ[ZQI6gQ[R]O@X:b0a@613Ed?I=1bVCYCJB.S9NY
HIUYCc+:,PbJ)BY<\,?Vdg+#9_BF@3QK&2D:MO,F-.^KCBOT/Y&<&KF:CZD9.7^-
^\ALe>+K7B=YbA8bbA&RKKSQ&X=YK,?FTMHO07F;4><bW^R_fcG;QYJ4S^eNCYG@
(ELE5G5^P9V-_YL)Gb-]M2A,@4\[\<eG@$
`endprotected
  

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_atb_master_transaction)
  `svt_data_member_end(svt_atb_master_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifndef INCA
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else
`endif
`endif
  

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  //------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  extern virtual function string get_uid();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  /** Sets the configuration property */
  extern function void set_cfg(svt_atb_port_configuration cfg);
  // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique iden/get_uid
   * tification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

  //------------------------------------------------------------------------------------

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);


  /**
   * Does a basic validation of this transaction object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
    * packes randomized data bytes into dataword same widht as physical databus
    */
  extern function void post_randomize();

  /** @cond PRIVATE */

  /** Turns-off randomization for all ATB parameters */
  extern virtual function void set_atb_randmode(bit on_off=0);

  /** @endcond */


                      

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_atb_master_transaction)
`endif
endclass
/**
Transaction Class Macros definition  and utility methods definition
*/

//vcs_vip_protect
 `protected
8?1HS^<E7d9A6^1\G>e,+32=UM)8:0GW+E<\9R/JIgGOT&@Y,=JE+(R#3\(^;#2g
?K3N2H9P@FQX[+,W;J2_4F,a<,CQ#@?M-,.QSQ?::CbbAbAV-MH[04C6:.8FcSXc
+G;GPV2]6d@<YN0G4g#A4.B-gf0&6G^Ve7QF[R\=MA)6A<B@+E(MGgCS8W2GWVKE
FWZW/g3bHU<4L[YP&.3\;66\-L/?^e]e,[\I-08&N3g/Vb_V:T)0OIRO3_TIKBST
E3,aAT>0WPZ8WLT42;>Ua@C4274\&\=E;7bGYFM+2ME^ES.G4\A0-b)d3,dEe#ID
TNg@9W:_a(9Zc:0SR>&<c-J+697a:&-bGZ^/TX;>.3YcFF]Y[NQA;(cM?,a::>]H
M)VY,P#LeXQWM8I,).3S]d41SH2.cK_dD&E+<QM]S@cSA3Rf\(Nc>JdWQa/3:L+E
M(R#3dT.<^f)I3Y&H+SON\,]4_f8L6#,]Pa\=&.X66CJ:7ac6,ZdR:0[CKRKCg2S
3bS40H9fZb#G@V4d;XI=3YRO6P7@g+/]TDePa\T@;-6T#&8;\,N./@aQFB89a5RM
.9UWFf&+884^:P7cZePbX\PTD>H8g\(:/CI@T:S(3F\F)2g=+.G@VWFL;fW-QfN@
LU@4;JVV\KSb56X#J1dDfYA;QWU4B[d&_a;Q21#V<8KSE2>TCA_@M;Hb;H+#JF]c
F?^1,+(^O]f8M/64:;32<NV0aC#EZ2MHZU,G&]ZX]=Q(U6H=KDb,TKF2C=fVH6]X
(V;78[Q:5eb-)7T[>\[F^3B>-_(,:E\0)JDU_7KN@;W(,d,aLR0LBB=TXAB3a,G9
QS/C<G.;]W.>4R817VBU>9)#eQX;gEMUUOKM;7AQ:#YT]&S2W7[85/Kd>DGNPc+M
0DU)e#7W4M:^J0RKN8LEd1E06g0bQKcW/C>8W\>V#))PFDOeaX<ZACLP(NF_G7b@
P\bUB>GfF+WcCGG,c91aE9LT(FH,?>]FGP]0cCdbKU/?K+ZHP\PY<=a.g+VRMIa&
1Q]TRJ<F\W6GWN&g,?7&Y^FL:Y50,H:=BB.3[62HD-.N0>D^S;^DSg-g?O+g7?gH
(f&80=Y/ILM(eJB#M,P:TN@c.G9YWKbLfBC0&SfI^>;<5-MQIbB+2J4_FV.WF^<&R$
`endprotected
  

 
  // -----------------------------------------------------------------------------
`protected
Xa_LY829_:;Yg(c_SIcgW?F_AW-TRG,>R?#=J5YF35S5RIHAIa^:3)L5,;-0W:DN
,4<(Ma#,C6#C,[d06FEL^V#]<:IT.e[);?+?D6d5=XLT@>D3c:6_5FccYEfO&Q5X
]dWRWVAc2=:UPQCKCYXY:/]fZIH>-[4#fbO1WMDPQ9Daa15Ic_a5-,d0R17:P=6;
_H\4eI6D=1<RMR3L0LY=\^3XT&A;d8VWY[-MCKTDJF^4L7GOU=XS[UY0V??4Q\&O
]d/(>N4:c\>9Lc[1.N=LMXSe,0cA@fUIc3L5KMSY#:G+U@K8;4C_cR^Z?A4SA>.S
5KVc=QOfAb)JJS>NbJ)B&5CUa5b<f8@;O?8+Q#U<MgLWg(F#F1GOYH1V5DK=N_R.
B8N<?P4e<_+?DE]#,dN2NS2..7K[B(3Z?a&e:[[&^>^F^3&F]eR--TUJQbS.0_F5
PPH:]#Jb?,d^fH3A3TN73TPILQ[^\GNYO>_TXKecS5(dG2PS,BUQ)QfMUZJ[MVaI
0AU[NcU,L8-F>F)IgG1,b#@F,\K)3)dG-#Xd^=P>/cO-@d)CQL1]25ReX>RH^C^X
CS+I-0RZ^&?PLc-//N9:gd\N<X3US)G3aA+B/]^-AV,M_D,bN8PBfJE3IIP6g](e
AEDH6_4W6.F#Y.:7(X&_bHV_\[[:#8AY?4Yg7AFHcIE@cQ6e1Xe(EULe<KA0W&2_
?YS063<c^AD)8bV]Xf^;+VPP:(JPQEDEJHVEVcf&F?NW]_@:M-S\:,f_58:HVEF#
[>dD/6J+V=6T2FB-^FEa)ON+F1=A,KBML]7+@^0/VNOa(SScKGMM[@OD2ZbZI+-9
UWCPPM68SIbg>3JWY_IfTU7GR5[;S1<&RHCG@+;fWUPUJU(MU)M)8>?ML?ZA[>K^
UN.=TB],GgINO->B:X14cgR,[N9CKaBNGLb?[f,NL^35;74+R:&;fJ<ca&HV-01S
:38+=3OCZGX)VW:U2+f[J1=Zb3fd05ZM+2EE(=N;4<7WYE?N-[[&6f<cL$
`endprotected
  
 
  // -----------------------------------------------------------------------------
//vcs_vip_protect
 `protected
)(LI&dWHVM0N)G7>QdB;W0NTY0993DS\BPfaDX7>X=8JGV>LHebZ7(\@IRYZCe#@
g8b;QIJLM(3<0F_.;[KWg8\0+Y[]7WAC8YC)LW=]VH#4QYZ<(A03.RNV/_@;_S8I
N4]aB;_X]P=?X6]^43I;-,1@(NL<D0XDC.+>_E#_+K4>]/F5)7GJX@8>.Q<M#N45
I@fHYOUcX]<BZE@J)9A?egLTId?@\0>Pb=QW[]8&@V\[-H3=<]Y&1B-N/>Qf(JVF
O6U7]56gMXS3MPKcQ-(-,2Z#eIP7)@,dJ,Hc,H6HSbO6?M7.G7b(K3IF#>,Y;Z49
]2F+8=DKQ6]@SP1XEIMGNAJ],g8=IAGG=3\ZbBD,a)RW1->XR_:#1[+JNS?W+@D(
R^I0NZef8;AcOA@:<7DM3+/9T94A&IS/@QDg<(TX0VaMeSL7A1CM@aYQ>A#Q04a@
75D&EH[A7#KQeTa5IZLcTbcV1]<ZCa[89bSL_b?aT7B4\<ZM+_?b1N[M:WcJ;e1I
)a;L(L/+#4.[CEPB69Q8e.PAKC),+a6Ag#RN+M05K5I4X#\1TdJD7EgbDZKMc-<4
efQ^/5\D<M.^31X>#D)dLJRCbBD^dXV_LCbGg(YNZBL86[ZOQ#D2817+4a&<4_@3
4Y\;>U\6@WBaB1)8##UBcAaAW60QV+>@0OXN\f[Cg3OdMOY8&d5fOMS<>3S1(KD[
<9&BHXB<R&A7YUdFW[&0g.H0]QTR(L^#(Uda>f^:6Pe9P[3V>2)SO.Rg=R;=TU\_
a+8E/XJICDV7)?Y\-BAT1BM4YbK^#JA)3DWF((RMQ7e#]M:G267VH\,e@:ULK.JH
UWc5E7AFVL9\7e;)&XATJe(>G\=]<27;@4W82T#;J]ffJYQ:Jc=H[a2_gIP72<a5
g1[TP:KZe23JX1A63APPb.4[5DHZSFE+7AN,d+PcBdV=cN^a4AN0KP02c1.IW6XG
7aV2_fZc(59&5:ZQWH8:.,bP>@J3g<ESM2#_TZ\]52Zf.Gb1fA8)&\^?UO\4b3.g
:JM]cK&+6E3OHT#8.-8[O>5BFX77adLC8D9S[9?BVVc4JCD<0+9:6ZVY(;NVU,,)
3J1.Wd-R-W[G]RE1-;I<..ELgL0.99/EH<<Y-W^[SD@VIVEWC</>2DVEU\?OHW4\
(+6.e?2^8&B?U<MY6a;SMG;dc2b5C\AE_+c]]E/V50OP3a>5CY4(U+f2/9AAYA5e
cPC9B)8:@4f<XTRKM>&XYW]O-@\07+IC&;#@Y64G?+Z-CRWL]78)g\eYP/JNA3?7
eaE@egYAf8]c^8YU,Q095SMZ[D/08UTaN2BQJ<7S;1O=Y1A(\37e51XI67V9=cXg
dK^cHGQ#FJA5CGJ;9aOK8TJEeYOB33g#MVc_0cG3WUf#J285g\FKZf]dVcX9,3-]
@V=^//@S_acQ_ZYee]32TP?LL1/NXG8(J-BUR,80+XH+^Ya8&./0]CUBKAAHTQ>B
a_Y9_\c@dO9D@M5-OUQ#P527D#f+d<LH[NJ[aK+4R6TC<SI9SW]cUT14EXO?U5#Z
QK](3bF.48ZbQQ&=e^_CC;2_(fdGe4\ZcPE;TCe7/dT7K2bAf=51DU7AG?U]9XCP
(CQOe6KM?\U_Lg/SA[HbF#b[4SI]/b7IeLI3(1W.;#IURJN2UAAS3U+dNf=#.c,@
\()AS.0c#G8Hc-X5=-[=2Kd9K7\>d/LNL#7>IQC&OfJcL0LP&]deQQf0(cU\&a1(
gC:[KWTCgQ3IdP5;06>1.PaK>+WS7M5HKb-eQU@HSaFEHQ#;3eH(E?b&]C?0S\7-
6+afdKS21+XZLTA/@]WCUFc4AQ=7T-=(36065VGYBgc#9=E):aBLd_\D4>ESaH,b
g@-Ya-/[f>)A?JCX)V#1L<I0]:PK>6HNT+204KNPOFJ0eI=U61Qd.HY/Id5Y=LB8
]9=134M(W4KZ;-A09Ff^?g=J>=F/\KPgEcG89=FR,:D.0B,dELAR>3aB15b_EAJO
/ZE7(fVI^Y+F)5;c2cW_9]F[KTGMN^RIW0^B/eOKWL,e@Jgf>^;T]B]H8[=<.Yf;
R(,S@/)@0)BEfbGUS3IV+ZMN@B:-0Z/bJ#K=I+>Ha+9&<AHgc#;Z4K0@8QKD0]OZ
>[_NW/N-EZ:50CRa5Re=7fcWc@YF\WFaDb7Q=ERTJ9;,6I8M<.KYYC8?^8.Da=dc
S4a6cPR[08_@SP5LF=[::[PGHW1726?]fMRI/T+?04XS<HY.bS<\?;Q[&2Nb75FI
K^@>E688BR6H=H]-=()Y<F@[-fXRY/0c7)cW0Sa@:N.1KXF,[ATdaJT^]Z3b?OO(
T__(Yg(bN)@HY2b8SAVaWF/3(UCOR:JRL[WU(3BI^2R&aBOH/TWb2R5=HRM0cR_3
bAdJ:Ke=B;O\<R&/VFfLEc:eYKL^2:HdPG\9XQHVa:D0&Z&VG=ABWW7a4U#^8C1/
>#b7V6\A><;[Uc4/\[OJ_UMfPRE<++f^R3e==<1fG9Nf.Z5Qdb[G=4=U766V2_(8
A2]F,/G##C#E0CN;D=G7?0X:)[ada,CgZ6PBHUC=+W&f/Mg3AF6-4XPGKfeE?=\\
Z(LeU1-M@9[Ge6)B1<7,(gU/DTGQ>X.1[;ZOWGCLKceTY/)8Q:H5I5F(gWP1:-[4
HP:e]gG=0JMc_687d/NELWCMC:;M<N7F1PM-.bIIJMaG4gEP\BW:#71Y[<PU=C0F
+W46\6YK?dd(UGZD7&g:/7]U&,e_CDBeSE@:[:>)U,@3@[CUCO:&+UM.eUH6F^4,
G.=[2@X2W?/Ae;GfCUV;bPK3d5R^B_J9I(X;BW_3>DCWC,&1R@E_TOE[M+5I?W6F
S#f+[&ecI70JZa^Y7^<[EMHY\bA72U-R/?CS5H(;)aJKB;5W+/DU.:.dMC?.G9,#
-b.#3K/,#?&2O//-BHBK?KDfBLK)gT5J41Fc.(<G:\Y3#QbCO]Id2?&,L^X@Q9FE
@^9g1Z83,^I6cRVRJ00\;I=,HAC[\OE#T]SdcUCYPCA>-bVVLbQ^AWTIM8XDd8ge
cCcDHMGYF(JJML;:K@(6/daU.)JP0ZW@C3:N&O\9DST:;8D(AJa6><LKXQ>5KcL^
4dcL<a]d[B#^PJO0Y>3FY4^)AMGZ]&(6_SD.^?2?5aEaH&U)T0TLcWaH\B[/#P.L
Bg::7_0f?X+9BLUVb2CN1V-+fUPaf=fE-1Y>;aO+2B:6SQ3XZ,_<)G4E0O2Z>G[L
&3URDaA20^Y2.9YX2(EI3I7+N2P2LMM,4X4MgN0Z\9#e7KX;WLO:,PH97D-<dCBC
]<C:EZLOfOV_&V5SAQg#Z\;&.14SX\HL&4SHRB[ED@ZF_<;&QXSO>>W1K[5FF>2H
]Q\(ER(HFb-]EOS9PEG0=Z,_&:MTFMLL_O6IEC9XQcXf;+)+20:NDW6\YR=D\:ZX
]93]fYX_YK;IVUF60O3d48TTGb^AWHAK>PFIEg7g1:-0K0NWf?1WAcPW<CB9#BQC
:F^gI94U8.2L=\KG1g7CC9cL+@V6:.Wg#KV3[]M[J^<,43^<fLD2MOQV8KT2EQCD
\b/:3=4;gI?e0+RVU]+Uc;&b#fBY#T/Ha4_FL/eeY?LW@TB9<OCA,M+TZU&b,>dI
GW=,aIE70ML_7;?T55V5/M1NR^c9S-97+C7_)[/NIDY2VL1.<3XC.ULdVOP+30P&
+,&+4aT9A^a_HB^g4KV&.A,\V;ge-K:6V9_D_>?SAA?/O<VebI8S]27^]H/GI@7T
9AVBB?;fX13f:M+I2ZLK,-.?XNHe?>PP2eE@PD79FH)E1EM8SOO/a/LH6S<<&TP^
J&CH?+([_\5Z8#G36UKO&M3-<_+&ED;A3H@Nf&;?:J+<Y#Wc7-V,LD:A(f7fN5QR
QB\&2+KMbA@bMbQMR3_Gc9H,8d\=N#8U_0Z)&_G2O3D5FfK?2D5R1MB3g.,Y/,<)
+S7C7Y.cD^JYd4b3P_18,5Re\XJAD5/5dT6UEF1V\09_?cSfJD]U5K/N=[FEaGd?
G+8,23-<;NLO#7Y1&c9H]H<<K6(CPSEf1E2S[#P^MUbNSW7QI[,F+7,K4b8/V;M>
.+^N5F:L[bXG::EAA<HPCH.cP+Md.fb^4MS:Sa.)1YO/),8S,\C,A,E^fMGDHg7b
eC<K3Y7@1UK5Y5](W/UfFb\(3#5O&#a#EL-3e2g;&c6e5[(b4MEL5a+0DXUdK#47
HH7c+\@J#I=J7R.+4OWFW3G(a6+.K/UMZA&XP-eX@;Y=GJV>eQHH#PB7<PTTYTG?
0[aAF.Za<?9GXW8UIUH;0^9MQdISO?=)43X@#=.P#e39<(dYGE,G(R]Da7gbHaQW
[(5KfY9K/CD&>2OQ>7;9GPgP)06aHIMFEWaJOgQ(1GAW#9:<^fF[4(K&f0(TYe;H
XR^+&NW8MdEN7/D(AGL.D,//L7PN[V([8-TBK<LL<_gCI;>G9]@OWF,&WOWTI7Af
-Jc.^Y@:H\L:ZA1?#0P44[5@,L]6-B><GcQL2dKEgC3?L3:R-C0L78cXF@,/4LXP
,Ze&TMB+afTFK#-;<d39>/,;D>3PAf[U\C4_4@0SU#C7gdRYb7)Dbe1I@gFf&1Me
^A1RTc&bUf_OVW98R6GaD.//FA2TF=J^Ub&(aKa2eM^3=5Ja_LK^I6KcW7L-]I&P
19,AK6OaH68[XN:40B=JRCdT^?)UTZP?K2=cQKbF;3@HH<_X1BTfb,]#_JTaBBaa
DGDVa>=d90HB-Z9a\P/7&:&N7,f.bF#R]9^C2AK]XA,+.Y0aP/XZ-M8>XR.@)EZ(
N\/Hd1_Z2E[gOLGaCOe0SUA9WZ29aY3V7GE=>AgU[AfUDe?-P/\JRJ6.c-XHY6NS
gW(/.:f>eaP9B6(9XE7-Tf])g+MUHW->05.9>/aca(>Y(KNKSS_X]c?@YZcHU=6W
6EK]0fT_285LX(S9U-bP[SdMagSOYJ[B2=TO#SHcU?0LS8@SY]=^MVYGa>?MDG>]
J01Ug8WJ<fJ:We;bDgbLJ#?G(PSIJ)?2P9CU=-E,-C#4I_FFECT6N4<&,/V7BV;f
QI;E@PUS[O)2eF>CO(RMbY6O8;d5d5(<MM\OEA?a7;W^UUD48&fQDL2\A6CF>R?D
Y^:ZN#d.(I8W.4?T2(HB2XKKFe;daM7+;VVCL3C#KQSJ9aX-Y0I8A\45=?2Q+^Ga
T.:LK1&#C,=0#/2a_K[-8ZR:CM+&Rdc-BFFTDB1UX,V>E74K@[#>8c5M;F80Y/]=
)-3;LJ\988cEa_VZ/ZIMR_1TX+2#8402P7_Q.16GMaT&(UGRKV3K<Z4X^<R?O>96
U^1f?__J1eOUdWPda4W85c4#O^=K+CU4Y3]cQ391Q^,GUA:4B0H:NW-=?74Z+-OK
^74RR4Tg]9P;gb3[PARC6a)fULIF9HYc)cNgfP337^fB^WF#E?XZJ0[8f&bWZ8L)
,>-[@<gYAN.IB(9CD59PHPIG8N?A9I2).3MAf1O-V&c=:OD;+3AQFNSQ1U[X\^OX
e\aKL^.2N4Vb5MYBU6HK[_]80D2LUfZb_8)eQ5EGJ]3O@&NV[Q(QSQQ[V-f&f>IW
&EW\UaNfAIFPRFIM8O[I:/0cD8&N8WW.^XJ;gBPF[bRE?CTK)W>FS5(g[C&P__N9
b6QSAf?d)+.?CETX6:36TBeS0D/.1#eY+J7b9Ob/A]V.1)c\/@HXCNRN<f^-EFV4
&VUd,TTF=?S1:cL[UAGZ;cKe08e[+F7_I62E4SQHWB8gV(FNA]BHF3>:N&,ZZW3X
ATERf1BX0;6S=e>2cLB)F8H(@S8RW:F1_aG1(=L@)ZE5WKaCC1&+e6c+72JDH^@T
[\B=bd-CCYZQ=\O:;>R,D:EDC<]3D@DSP0J_cI86AP=F+^LZ@e>K@W/.(FFFQ&Ua
&DZ]T\IDY+3VM<<G7b-[B>5D<1C6DDH@.7WQPd/HF@CG=5&H-6Q+V]I06Oa=>=;]
X61@HF-UKL@A=.47F\X_#dVd.J((Z,57D[QDCDaL;)[VGQ[G\KD?]f5?Z:cP_/XT
,g5cAFUeT(_K-9_.@b:M>LRAXG[?cRK[&Q7?@(0N5c#LN:AeY.P&,124L)fZ=BC8
CSePW#IB6GbH1>@6dJReI8;f^Y7OaRSe:M=PdQE[Q1P7?:EE=ca^b]N2;-RA6fbg
6GZ2b:(P+)U&^;UK;]1A540OE62W1Q)(YG]f<O.K-P].Z+7Lb13Q](#774H&<)-]
45JPfNFB9FN[bTGAU^J6,R;A;Z6Q=He2;LI(Cegb?\/:I5CeQ2X&/BNP-HRY@TZ?
C<F,1g.AY/L8:3FO#VT>ZBaN,aEee6TJ/N9-d05XT4T\;#9]()+G=dVYI]Tf&>GV
/gDWJFW\0U/Y>2EgA7P><:fVa/JfK3ZKe)CZ(B?XP2K@2UG:&U7/-P:QK,\A-K:8
bT8cN@Kg#E@G#]UFK8a-Ld+V;.3d(OC=b@G1H5C^+/Ue>22X7:AI^HBIBS-Pb.6U
Ef?55X.V5RNWf<.3Y/>AgDD#XB,&@8[-.MdD.@?,Cb2&gC9F;d:>XbE_S?C,:dc7
V/MK7;H#fU_1dCTKK-E>0M+I=b@1&UCD7H,9GDA7e_Gd)2a_RaX[HV+BaI3)c@e,
IP?C^(GXGY<HT3S7-CSS73VMLXMHP_],2YK):Ha3VV?SB^[,Z9.H-\C5K2)fa9T<
[(cf17aaPDZL76@+R]W]TY;J.\2^cS12A8P0Ad^#\;215d(ZT7Q]/M>D3)-P/VAY
-4WDKFIJfL7VKBX?1>O@?@V1(A4QBH9T-S;CLfQ=f2LG5Y5:TSW9NJBX(D=NOXHB
a7(50^W)5_AdVG]_Q?b^88YCTWcF:5g@gGU:;GfeKRgJ5^XD-G>#^;34-O;5OT=&
9(5;P:a902=X&NA6.Uc,aUPVD0C36AfA>,)/URZ<K_6bLg.8T=NF,IS?#+<H6@1Y
Q(BegL+aIbEX>C/[/H])?WB8E?F#285;A7bW@]b]>]K=,&OU\=eT4:/C7_dG4Udf
,-VQCK/8We.^d4cGdADNG1H/JNL221Qd-CWQ9WBb4)K6-FFC+Df5R&BRd/(\Ya]]
E)&gQA@La,],<AET]Q[B,-N=ZJ=[6F(=>@N#(cfVM6+IPR+g_HR:)c9>[_],&.8K
EP1fUUO&/6&3LO(3g)U\K,&;L&.Y#bEEaNED)0G;K4dSf;c1RC=<V:/#Y73K(85Z
;cW\YRX#^>SC);&YH^<=Y_M))LRAY;UaOe4T;K.[R3Z(3<0^aG9D0+5EGLb80R)?
?PM4B.?BNJRMGb5]>a37GSND:+0R1JFbT73>BXQL4<Q4c^c)05TDE).5^gfe5&e_
?&dg-J0RHeGe1(aM9UfI>33dO9WT6\_Z=UEV.CTW<e0Sa3K<b30MQ2Cg9#6.(Af8
SRS.@3E/CeQ.(C<[R_;8aQUA48cX+.)O^FR9Fc8GCg^KA4&T^HeVVRZff0TH0_AW
FXKN>/UH[YVV7AV0aL(;<8f,1T4<;(?g0XKQ&[=NI0c6-e0H=)]eYJeB?6F]\FeG
?0?^,[,g1cO58E-bS9+)G0(,J[/Y-]#XBFQ&?/C2TAZ:Q6;88/7VPaJM[6Sff^,V
#UM3A\WPG0&^TV#DQBP/(gVBb&&8Y.5@BM^.#a:7D#Q7f;6U67[>cU55\L/Y7g(a
=9?eC_a==)N/AgacROAZX5@[\3)Qg^c1eKWT1>;MbBQ]a&UAA1FX_>)+CE7SI>gc
1M,XDJ&N7NRJO+&d5&XHT@a8A3SW17=&g7LaD2ff8Ccd[6HGWRK0WcMQ\N1CP]0B
;Y><bQ(bWfCeMc[9]EERPZSDa5>E8DNZ(,1bIRIVHVdH^c8X?=6-eFP@(+5<a=+Q
)J@a+MW1cT(S#>##2@3^Oecf,a07UgQ#V1JX(>>2T,70Y]edQTA\IMR6UM(0S.DA
OG?b<B15e0E#.F@U#ScO^bZdXU,9SW&:<2&>dG(.6V-LZa?EV=ZacLaC@HQSaJbT
S>a5O1=PI77U4/ZT5];<]3[:<c1?98fM-34[Ha^OdJE20OP/BSM_#5AJXffK<JI,
8PU-=HPZVF;)4O8:-U)DASC8BMHcYANFCB<fD][ed[73,.7L-c0gH7>D-+KD</YJ
3_L@\c_KCVGQT;7NQPLRB9[^QUB&dfR?AKFFI<N.e5ef9&?bJE&OdB&3O,;U].TR
KP+F>K^6[[0TS7Z:\9PQ54HgXMH?dWT^bLeYPgX;V3J5GZfG8Z\g)]\O&#g?7V9\
LWVf@30E.T@_=<0Ra)P;HM/1Be-?:K<\1Y0VJ[U57g.PCG#-F0^\>ff5HV<2NL8>
5C?1UKH>U;I)fVM7KGNYeE7^VH=(J3M_^WS&ORg9X/2P42QK./gJZ4?A>WDFF:.P
L:3/,aBA6Z=]]P-[\#_UD0bD:48W)g>/[bfB9_@36_0-TL59@6=G=BgE:ET[[3\>
c]KE0GZ>.&^M@F,6LCHR;(^9-6A<C#L(\U1L&0K#TZ3Z>c6W037IBGfRN[VP?^g0
@bZM_P08,O:Q4946>OIA_6PO47fb(5ce9Rg[df?cICYWc@+f\;IBa[UeV?[DIJdW
db[T?9.UL4QZ:>YW@]UGOPH((3<;GKJDOGcN=JDg,^Cf\BYUbRP?4RXQYbdRRUQb
Zbg:E8:a=IRe;/:XX?7+d&2JZ4SNV^?M>gEdVL&1WMdP.T+bB,NO?DY9,D>46eF-
CF[@AVK9>7G3L&W,OY23GSR])N.+3?YPfW6]5:SIe:9gDBK^Z[_@)Gd4\Y>KOf+5
X^@RPVPb=?N+C0+7IXDf@4Xd./,IX<H97Q.+K3L+GENNCV=T..,b@AC(=d>=:PZ^
>[bO;RG,M4H)Y-=USQ^0L2#+F_&YJRXS57DG\cT^7Y]L1KZb,O-JN)&6gb#Q_)Zb
&LX>WP(])),e^4VMCCA^FA7-Te3gYS^g[//;?,fg2E?8^^I\2BWbHB)2R1=0d/;I
H9<=B:_WE:W+85e.UM#V@(3:Aa1Vg_7=([58SNJ)=@OcIFf@I__4dHN=IWSEV[&b
G>\e5<EaKgD(>^/0cFR@OS:cK3>9dc,bTN^41+JMaM&.Z&34a-,Tf-)==L>M4,-A
M>ACC2S^eN,c<.1FM=Z&e1AaGa1H1aEG,;4LQDc8,YdZ2(^O0],1\O)9514]/90[
PP#^U,F2,HF1GKC.DOG(]3Z@7QYZf;1BD#RT@<+fVEg(NIgTQ])=O^3[0gH57Cb;
<fE#[X&@)We9PRA8G@K7Gfe&g#IO=fACT>[9Ng<MfWTg:9)ObXbW4\UWEP@7UZde
0X2D9<]^ILI]B,1cfPGe]N9)^(T[Fb:c:f^0E,a<\HL[f>_QYJ1D(L(Z091@eO#Z
)c1=>F_=D,.?:7TXJ;_19NF.Je;7L]:D5^E5Ifd8LA4f26Pb\ab(Zb5G?2EO:74g
UF)CLR9g81QG@T[[?N5aYMQ<MGaX7S[]31=P5,?V=3XP9Xb/\ZG4J].S=U)2JH_G
856MLV5K[(79&+0=HBgCX2N0>4D#9-B4g,0814]1A_K3,,db.dRE];;V1eOV;,1,
N:XGg1QOH<\bMQ+ON#F4F9;^3:[9-(De,39e,B;&/I7C<VNEQfZR]a0#X1]5ZR,V
[AZ52TgA>;eQdI/\FfD\ZTKOF;NI4P[]2?W&JM(c?8>U3)&dY))DSZUY.#,U,P6^
e[b,5Gc8.Bd3S>+4W^A,]Ac81HQ.77DOH>C[FX\R^P6@<<2Hc&L+<:X[,I0=GW6\
SX4ZP^,VS9&;D&;#Y#U@HD?H#HT2e)84YLcT^,G0egF0G;067U]KP&NUE#I0ZDV@
T3ZVW\VZ:_Q_)Q[c&K1FcYZ]>dZ1=_@L;8Zc[GKdCTa4?1:56d3(T,02dI9BK8B_
WQ&OZZ],.KQUVcEUa.\86#>a[:[9>G_-E<MNDY3.d:C_&Xc6\Ya.@:1Jd_?e]Z_F
(=]IYYO(YcS=H--d:fH4[c/[e-XT-0?,_fJSX,K+1P;TT]d^;GR[,]<DD#XR,-aU
dJN+G+KX3CSW^K)F@P=/Sf\K<^F,K[.=+1\G9JN;g&A<f(M:9ccG]<GGUb[S9O-+
:5\I0V4_?ARD-T5B/;^;SOP=@:CLXfDLKPc,0+J.aX@UfWM@Qe;)f,\\+f7V;Y+>
4P@0EN2SXJLT^C:=g&Q.E88+2^FP5Pc_Y4NZd6^c1PTa.?/[2,Y:>?TgW1WAC#AG
X=C3GNH\;/;F>WDVTe#ZLcJLE#9ARIaA>Y,)FC<3:0-5/;K_M[HW9^4EW-OQAgW3
cbTFSb>GL,L2N4Q+77,TcM]9=.P[F0<a/H(JO.M[6Y^;4VOA(H69[DY@1^E6Mc7/
=P2ecGF<DE8Jgg+T9.P::7Q2_44aUKf+Zg@7PIGQ7]/aP7fUS3B+-QWJ5MT]ZHTD
WI)\;VbUOc]_cURE5,g,e6\E9.KF7J9<2)12388c:YL2VX22,97<_H1g9@SRD(Hb
-NdD?5d&YO<L(>1cadEZb02;Q8f[TC?DE9_J?cB:):3T<+#2V(_f8U(aY\UPcJ3)
RQ1(P-Y.,Cf5/?W?bd,^]XA/0=?-^K8f?,CgNA\QRaWL2CPT<P=,<gf+JFDQ=C;,
e/MF8-WY4@BB:<\?eTdR:&SC.D#YN;\c_SHCeM92E@MQZ#Na5<I?#2X87:,V;S<=
H9LUD;DNOYP@(cI)8.G=f5VQYPLY>,LS:e^cQ+,:@VGM#KB==66R@17[<:#Z/(?A
R[[Ce<#_KBUSA8/Y72K&5QCW13&K93R&ZH6&=a7OE-/2NbZM&5(Z/U9(088V]P:N
O)0Ze.\+1SE;V2&_XV,B?44[HcVX^-O>?CT1bZIWC,VFTI3\=Q5?R:TQAAK)FbE[
PJ)KK8c&e,A?Nc,V&WY##?#NFIYbb+PD2,FG9\c35beY:CcVS&IReA]UD(.-;H(C
J+&&JcEQ\0ZLJOc[4BDA+LX.42OHL[(gfXM)T?1(6VcDdH=\A88^QbG17f6CWcd9
Q/bbH<PU@N8?[,-FfZdg_0N\VGKL^TEHK7I=EPYLJ(U0EHa9,&]<C-4I<7\.X0c=
R.Q;[d02Z?<)6]F4Y9=G/db1a:(Vb@Gcd:(FbH;=FIF\YT55Vd9aLdCFBf_B]FRB
:ERPY(_:)aV:H(]cE#;:BV63XR<@0NOO6C8+XC^VaR<QF4f^deO;K=Wa9+>6F&KB
[U;XVgFH.DB[GK16=M/(bEU4RB8LAUVN5XLQASdGPA\[7&LUV3[_,.2M?=>+X22=
#,\]BCR<(HU,aW\I:D0B?1;.[cJ0>82DL&FgX4(P^JVH&R3X1<P#^g7X77@X;\g)
K_&;9B758KQ@#&+6I6(bM>=-.P9GOC:1-F][J^LNUU4e>_,L;N;K?c)XLLc5YDJ=
XEJ223I6+AcEK1LWT+-DNeZHK0(8V]VWIQU6<9#,bgRA<#J;gGI;VHSQeAY1E[.M
2ZWX(5TYQA1\NV1SMC^&3GddAC7B7-F-KO>d64G8L\YH^7aRGAH9)7?b#N>QL](/
Pc33V8BUF(O^)5:\E2/+aQAEGPeDUBP6D@@aKZPTJ+63KMQ7\e;>\6=:gb6XQcP8
:A6cASKeX4B(1S/7=4LgI);;>De]9_=fMEJM3QAD2:E[@--R,M19]ZM;>GR\#49(
;?H^UY8M/K3cXR]WEB)edX]X&OMWYM<QD/-HT1/LER,I<AAAS[^CPXL(#f\b1X)O
,8\/3Ufa9a0-+H3LH84Ga)3:1([.a&QaUOU#1/33_X.YL>Ee/<#b\O2CV,ED#Le<
(EE8bNb03RP_6&,N,630(GZBVSFFO2)agC(Qb4PZfa[+X25DBdX5(+cBJ&O=b3<#
/><f9IWXeg[>?-[^YLE-[FSRcUU?O9dDOM7Y\NRAN^gb(:,c6eO[Wc(8e<e4WOW:
ZGN>f;23CC;MC[C]D(B\0dB0E+UQ#ePAO-1\Nf1Z]A30g/-Za_C3K;ETe7-CE6I8
^#RUQI:;..5E3/19EgdXXdQDHFLFJIWV-+4BGI7MdC/)b8PgA==Bd;TKTVR8e?Kf
_K9?3dGRd-;U1Z569N]=)#=+dK#IW;CeKHW0^@MY9Ag?He,FOdGI@ZJ9)gNEXNM3
JAdSDX.A;=W^9(0PV-JZ501:eBX[,Y>\KCB(-Bgd+?_bfG^0]=40L&]3\QDgFC8D
H6F-+_<D1@4\;bbJMI[T+408fFbUKA]UJ;>1N#8WC/bBBXB\,0QAL_?/.]Te.6cH
VM)e,PD^,#G^-@KRPSGc7:>@e(LE:#O5+)C@Q#I8@Z?0HA6N-9K+RDY+XB_I)N^W
ZMM=,cId?MUX@PY2I#;K10bTf1RYM3K>&W.]P1MSZTB=:VP<:+J5]8XcFI=67W&f
9_HE)ZNI9e8(KB&-Nb]>3K-cE>SN2PaFLGbUW\5Q6Sg[IBfb9fC6DQ)dY[GK8=\A
&LaM=(g)#-e=)bAdY_X1P#&AZ_f^UJ)DFN]D@(=MgR3GUPg2I#28SO(LK(,;?#^Q
c]27J6aeWQ<:&,5&dRI[?fgHb&cE87NgeYD8+NCUbbe]YA?6>2:1SFBM<Q_14A:.
TE(f6LX\B_JY?:1,R85G+aXJASWC69OR4WbII=L:DB>b.+[^8_J):_ag5a@1+f50
XgScYT:fd7VHfA_dHgW5(JOHYabEQ^b0DK)L_:DCN7a:J&BUb8W5K>8gF/?AQb,?
@6WfIGVcLJcg?#[HK(3:2DHgWGDNG/F/PbU?U)dD53Y=EW.Mf:7.ST]?+a\<a;NM
OPY@:2,LA5f\^PU:Ma<NC1A:@(#/+Q;41/N,I[.a6Y]D##3aD<2eM(MESc0N:DSg
g^3LNXY;b=R]#GdgG2J=KMK;DW7XM#4XJ&_#2+FUO_KNH)8F_.HJW]A\62g1D>MB
IV#^ZJ:78QYR42K_^;M?K[fX35T\[(CK2aGPg8_2WD@6N^9c\;JI<]d/(U8>TgMZ
[ZOVgZ-+2_EBX?Q8Haf@]7H-[\D90[]A;3(c;^W9(EN2g]d9[XWCX(TNC2eIQ+Yf
KU4:OUEUP+NSIY[76>UJH97b.>G)&;+G<]Z/>?1==2-d/,T8c;>T5^(WT@16NW_c
9HRC5MW;-=fPDHSDM1Tf.6T#@e>/Q#3R<AIQR_CJN+8La+J4QJ#AJ]D5&6MfHL@J
FONf+9IeLZN:e,7S5I_]J<,d5L#CC]Y]-c&BW4f-X?=5;-L=8/LB\0CEG=AMVFf\
6KF#_V,#2?Q_+)P+2[-H#G?W[Q:[_Q<S)T,-EV2bYaeM?)5ZVNF>UGX.F&D=Wf6B
N+D2V)\^g3eI=X16dd5-]XDd<MN2\O/,C&B7)8BZc,g5_.LFe36<Dd3@),Gf0]FN
851\TJBd114.:9Me:#gaf28\N\N<;BG.ZRD,\;P#P_(_3:@X][GKX95Z<7+4CeN;
;^O6@cG\3Qag09SWC#K0R8eM\MRG^LJa34U@_.;aD0JO6@Q8)cK\G?1ZE_H9^f(]
9.&TgT)U;c;2NF/Q>/HDB(e-?(S1f4AY;0N>\O]8b43TW\&R_2e43^09=N4O(@Z[
23E>WK_N0g-J4,#,/7FHHGfJ869JB@\CGdPS30P4.0U2K)X(Dg6QTJ_MJb_aL)M?
\ORb@?fa.\AKEbS)+\UYe#F0=[_d-+?,SSfE8HIZB8Wc/B80Y4_EH_AK2#WGe6\]
&[_;81PREge?.O^M?BCX:R2)GVFAaSb_A/H,L^M9BA(7X-H@?/VVGB&+TgJ>#=/A
-,[2g^>b>c[->6<8;Tbd57@2K-(+G>/C4O5FCG5U>6.TBZHCc_F:0aKT[10\dg=R
Q#f6I#1#bSfW#aU:CQUBZaPW+a,IT-a2Z_,R+]=7=ZGRf>9b_MV/d+R\D=)\CDJ)
e<CR<)3)cP(ZJYE.&\Tce8.UKDG^\RX.Z=a7:5?FXcKb:EM+?6822e(OV93IW-Y>
I^,PL;#[CHA;).;>841J7gH_/1.9Ic59K+LbULPDF&aggdd]#[2&b,Z,FGWOMJXg
LLRGbQI]+d:d<HB\;>H\D;Tg_10I:?c96.cQ9Q\+H#67,-=Z#.;<>QM^-eM3)<^X
C]#&NA_T41WB</?3GE>QK2TO5:KABVHa(D?57>>G-M(d@<-S0/2[EKNU\a..XP.,
Dc71[MZJFB,;Z\a+J[9dda1ET>>U7PdA:/Xf@8AZ@AebeOP52R/K2N?+:RFR/GBT
HfFN8SJ1=/M1UD^b63#_P8/_<XB\TJ;[OdabceM7DRP?3\H[HLc1@\0:E7303>LA
10UeUQ19=URf(7P_X^<F?AEWW?[b\JWSD<3@)_#P<MRK@g.Be&U#1EU-?gH.5?4P
&F1=A+348#8XLaY^XL4)a3LH/fGQ+P2\2e;gWSHaO,NIbROQT7dF9c1]f,EA,HA8
,-6X4Z4\RVeBb\Y^O(>--)=,bD)YMEZYL,)T0Hg1?_2QFHg08]J=ZSaLX26bd;6A
V?^gWc1P,7f0OfL66C5Z)>T\8&6[?a74L)5DM]LF&G)C(HP0S/,aCa&TSB^],gP+
AO8N02TE=<,F5gY),-3.HcB?GRF3.GB;Lb;(G&2:YUW6Y\4O6d(N;.ESZZ(M@b0@
H?ed[;]I=Z;\bWf_J2XB9U#N:NATUVcD0B9dT]7dQTZNH@LYUQVIKG3<4JdE(@aO
M8gA>UWJ(ggHTOSSB-HW2a.;,ZHTI<fN_g_4;<bS-8Z/XaPZHHTg,9MW0C51a#4\
WNT5,-RU[5I[gU@1\eX]>,b,XM,2JN/[)DV2adJYgRVPEXXZ;e2I6N48de95<N)G
CVOUB,FHX5I0L3V>f7Y,BQN[f:4=]1[a/8UEb@cV<ea=3F2:O^aDV6L3#AYd4QE+
\:/gBD)C,0DOE_b7b?1-(>d)[F9IM?ebb\A:C;<eK-dG&(O,LE@d7=.1X3V6#V4-
<A7V?W7):?OY.7a,R(D#DW;S6&TX(DeM_KCM_M0_f9=Y/ZN@+=O(aYeG<S1XFd?#
;dE:BN+L(+<.&6W+gJ9@GOedcA7E5X@Y&fI=<-:F_[gBRc[>_eB.Da;XD#P+F\PP
e3L&6SY3fH:75G27b()bNZ=4)YcE7-AMf,d4NSeSP1Rc(S&VBP3:QO[.LG2#X(Y1
-CN-0;U&:=RT8.-V]OS;3;9[F#_AWO&?C0TBQ+Ze2F2H.&R#0I0N)b2;f1db/Y,1
F>:,@Y82GQ?L\PU?5Y05A@5MEKI?0:]6>cTPdST3M4+\QW0:QM4bce,LgI]A0=g[
^Kde5YC8&V)>eIN,7,S1E9DKR]40eQ^UR&O:CbKHT,9&MA=?&,UPa1.eTJBQKReQ
2bCO&g6a7=8\IQ.B&NDe^CcWf>@I?J5Pb/))=B1c><dMbbeH#I7.PL(<FfI.Z5I1
M<+3\a.MHf<;<2=WG9#E86/12Z(LAMbJ??VY;.>?gA9b@;5Yf:,TPG_@ZA#NN5G-
RE-G>,4?;T@/Wd3/ZCT/W8-T\V5>,7QfT_HM?#.cMWE.=E:BR&>dN.d@:<0]FE_^
/F-5X5c5J/6CXe>Yc(6f[I[^XdL_:2/>P3BF;f7A=+efG9BBa7BfX;=#g@YHN.NM
+ffE_>^^:-EJ-5&QN6UI^MK]JU^VXOW_.W8Q-D<@H6ec9bB1ZdV#0<CJH<84[.LS
+e-4[?O0Rd7I0.]0PM)\_L&[UPe1L5_>GeaYa[,NN#ARH>A[P+#8&.U9^Y^F:L8_
6UZMZM8]_Sd[G0VY8C;;ZN5b-(GV4f:[J@1a18<,&d@?U6PMT41T&6]/+@<?Q=Ug
6LP3QES9edZ2;&Bb:)dAH+V-\OK&J/9M9b23GgRDG]54=UN@:RA1E>aKCg&T-RJa
5Ied88UDcd[6-=#ZDJ&>YI0f)7b#:E<(T3W4<WO[U:QP8:<WN#0MR3aD\EF<HbM=
LD_=bU[+MXO_gDU\[+Jf9V6Td9#:Se\I\50^-SbGdRG>4/VfNOJ4HQN06RSWE4(c
RF2FJ@9#@H[HH<WObbG844F4..>\[;B\)&/f<H+\YE)(-H4Sa7\-YB3M5_/@JaN/
PV2DJEUYOd(c&=G]QaAKW5.VSXN+F:E56dC+7ID-2BF(KGQMd97\.1BWC?91,8LC
f&1M>5ULG1QBD+g3gH9<M/[EM+d\&5W^d3]P+fB)D]&6cW/]aM&7#M.GFD>LX&IW
TSbg;0[CRLa\&6A]=L4H5)fQ#Ge.O4[0P&4)CQLM;ceS2BS&:PSZ8^>0bB@d](C=
^V46ZO-d@fTF90&-1_cXCWX@)^cRTCW>S-,FCZ>cS=6E&32gf3L&bX[CZ>:dc?c/
><<)QH6P4e)Zc/3\N12L/A1;?GL3.]c4I,I8V&\R8(fF2f[6EG\L-_N;IL_Y?LRa
8Bg6:<U@-#E.&(1U?Y)6XKZ/]SF&RCI#Fb-DS-I/dH-+N38AJcD7.>M]_@ML[PbF
,ZE:df342,a\VSA.&OGZ:\a_+@bYX=.\c/bVGe:NHDYJ^OPcK>P[/WBM(:3B>Mc^
_WD)gfc.&ZWBIGTK<FC0(-3SbLFP(e)\IZ<9IP0S.T0CC9D3Ca^21=?T4?[9NO6b
LCL+?LWaQ&?GR<TQ7g^ff1Q9\ddBQ8?f:/UYGaD,PKWT>->)GCUaWK+.=G_Z:7f+
(Z+E):;Y^8YM>IA,b]INQ=P-@92NJV2?1RfTK8cS-BAgC1Y,:L@[SX]a&CTde/O,
#^KG:TVPbWTJ&McOUO8XG;<W00aedI1]1]K)TXgWgO<TfFMMBL.:NEdBXLO8d6^&
:E(55<9]IOJP@[\DK+>X@e(-N21X9#:JL67(\.D)O)+2cU>4OAF0;(I.I2&.KXe;
;If8SX/:@_-c#7K8]SQS/[[a=V(QRK>ZAAH[);3L\f,CNaPe@\G-IZeEOX6<6:bg
QTPO+Y=9N)Fc<Z?KQQa-RPVag^C:VSe;&#23A:J0[C_+N5g#S#F:ESP;KDZL34.Y
CFNTV:+W#)bLNR_b8?2cC&f:D@R87F[&b6FDM\^R-/?e=LRaU1b:c=SJE7BPJ\Uc
^W=_DQ9WV;a@/7Y)\N6^+#M/8H\2[A44[X<83Zf7-@3[.2HSTB\A@WFcKf<<RQ)O
e>b4d5H94UR<UJ=]<G850?O+.]T@bN,M#@2QML_RY:NOb^gHIGg8(d=7D^W&5-3+
aN>T>CK^<JODPCPNUcd<-&@G=:J6eAVgJ)[PL(>/BS/OBIPeOgHQ7;FaE;64f?T?
875gMU>/]8)Ia[6W0S4\WD[/>/BO2[G7Bc/_53L=XAG6.Ob[)[f67X-g7RU;QD;@
^BCb60S&,a)=_<Z10]aV<M24E8IAA:H<DG>N0a6@8P@Z)&g.5e@-Ze[-7(ccI4X6
\[FIXcgIYU9+]@Mc6B&Q&G5f9^#W=c.:c8^7(B)1^(1KCO78L=]b:F?WcXX/63_D
WL;.LS8LV_8C^N0D84gD??0ceR9@4gKTU-f\08?d[X(dMBe^&d1.f5f8TPCVO.P/
0C_A9[Da[1bWe>4de.Q:gB67#O)5gbMH68>SbS3?;C;d\?:KOf(7==Y@@2gg=^Wg
/04NNgTOB/A3E_MQ4ERM6F7UZ5f-FRN41-JI4\?\D&COUR>4?U,gW2J(+_A;@YGZ
>](ZW1?VFD89,g[E>OYIO\B#DBORSFaC&NC8[e@-(f\He@BP[(1S57#g>22,La8-
P8b?@^[D&[MP0BA+:YVOOFKT[Sd,4(1a:UG5S+#<#UU/O#>T>#IN2Z/PRYYf6@^&
dCJH.L8cCALb;7\=f5>WVSf-]BH4XJ;Q/X1P=R@_W[<_;S=+84S_f0_@72NY9Z-T
<1GJV/\7YD>(,784bfgC@f\:6JCWY-QbAg2HE,8M5LV9g[D0J7[f)0;:R4>_QV[\
a^\1[(&Z\55E:E/_=.>H<IO?D^JDL4@3?XD3F5NB4I5Lf]bA5UZH-:M(eLP]7Zb0
\cb@fg5TNX88F5?T\^9b=4;D-d,@;13cCI;HR/4=:L[4GTIB^@F=Q.1U6+2+>VbB
\S[N^dRZ08F4L5cQ=9=_&ZNB[=F#Z[AT/WN9Kd/0<(UfcZWD7Z2)\&\@EKbaR2YY
T,3>FQ=53F?)2=Z<T44N@2^cUVcD^K,cH>Vc)G9XZA1BS7^8^J;+O/+T4HcA4,+-
,<SEIHJ14&\EZ03N3FQ\14HWI_IRU1Ca57g5\9=ZKX(WFdg,=]@&8][cPZCAZ,N/
b++:M_X#S0^.VbG#C378-?.&:0^OVH+TER^UQ)&Sg/^c:_0_JC@@)06\YOM&eODf
:L4Z4:PP53>K\9S/#,eLJ0=#V(_Od3:CVc_bZ9A;e@65OTgNea->_KWERd=@egO(
4^SV><N<;UDd/?#)8S=K]7^4QOP^F-1M3[(I9ZQ&(3C1JGUTcf]OGGSPPW165@Q9
5<#I;K(GOW+D?gU?3POe:Ga=.Td9H2+#H@NZ0&(TWIN/fL\14g[e?9Q^8.7XC85H
Kcg5g9<Xa:H6D#3?BVgBe&Z-G_^=]P5YUfUSR((<_Lb_VC?^_?7AOU3LW?AZDU7g
_1L:>IHR,a&2NVG+9@e]11dV)ZH-V._O&ZS0EcAc^fB,ULPS2_BaC278BM:ABJ=g
:]U[:>D?cNG1U-,7OcK@4Ufc\.?e\9HE,XS:.7BG.O+1./RW8b#4KO\B)0cI(M.O
@KJ4].N6+af3#9R<JX27&,5(0(;VYQZ>AFJ?QBZP1P#)_;55X+-8UM;8<5J[_,3,
X^]8SF93?T&<0Y>]4_@;PG_f?EJdcgAOG+1E#B&-V7#U-b9PSDW?3@1IfKdL;dg/
Na)[=3TPW+g)]N=_H1)0,(aZd2Z9I>1\Ba(96RcD?Qc4+g4d^RYC]29N9R-Z^e2(
N&9LfgJ55gA/U4(1Q@-8c-&g>_O\@P9f1^3bIgE8gb6d6T+UcNe8)QC_I]+(Q2.-
\=:3>7Q<gOW[D]@/>NgC_SA5Tc+?,.1=fbDXEC<[KP@TXGAgQe]2^B\Jd?B7A:bG
_YN0/.+_cUFFGE0RU_9HIHfG:FH\8R,L@,J97\13]ZRDf9,H\Z?5J#.F_:#]dEL-
BU)6dQ#B<1S,0\Ab5N#?ee@^(0YJG3P2JeO](Q0dQ+,38^Q#FY@P]>Q]6O-b3[SD
:R4+]2EfNf#M,^D5]?@bBdGN:7VJFCHR_#(I/d.E_\gQQ1aM-3dY8OSQMMC29M\F
+J=Sa-bE?B4c>()TRHbD@9G6#:d?0U9bSc?GJXHL/C(.,S)?HgNO0W74>2CA><-G
5@7X3MH9Dag#Z(Y9VW:<(g>4SQI3Z\g74YKf+BL-<0^.Y-2&F,@Lc,bLTbc2EegI
c(6g@8cCSSH44,-K0SL7(KKAL_6#6O4Y];0&7ZIGR-+Gc)]JdJF&SU+?a0,5_5MG
1@=#MbS4(,f:T&13#<50]MAc+CKe206Xd7AQ^JfB@MJRZ-:I8e^.f6UHa<>M[HKR
S&IC(T74=;&HC1BBL][@5]??b##-LN1GA8f(H-T<g<3_0#d1L9N#^L2fO23EE,25
-GJ+95_L15@6Z],V,U6P=F_;,R6ge[]85b:AJe@QKdD9=)/8=1e=L9=P=>a4<W0]
gbBcZ/=#^Eac,XA4IM?#.53XBGcEWGPSN4/&d<KFC&UN.b,66f#^A4C..MS:=FIQ
(L6;?7EaYELVRQ-_@T2306VGY/d5;e2P5P1(WT4^0^((I/Dg:7O/.Z@]Ncg(VH\1
2_7_?SXH\/9IY/#H):-76@6V@K=QUVNY4>.8DK/-4Z&:^QffUW;;82P1f-.&0Of&
)4Ja2.B?^0E0:7b(^9RPeJP3O9#;^dN^=X3L_<6R0QZ>XMVWaC4K&-:-@92@<69L
#=Dec,W\OHS6gMg#.F;]0]S3P^9IZdT0#BZXaDI/1/(CBYQJG.I:>STO#WC0]]6L
-DSdRA&MF[bY6^S4P1f(f7ULbELbJ3;G[1Z@f(Z=_62gM>TfaTEB:-6GJJQZ^16a
?,_?LSY76IKXY18a8RVTL;5P?UFQ#?U=PPK-D4eBPEA@:#ZQa^DA,27M(gB3S_;V
d1eZ\@f#EKLM^;,2);5UdT?WCR^gcCC\Yb;<SS69L]X&e95d26A[c1-Z6<1f8VMG
(\SNT^(Wg7WL_aeaKT12_:fPL9Z;SJ-DXb=BN]f]J5U=;QD,-7]CVCI<?YfA\CXF
g2)XEfa1_.S4e+X&2@KA_O14<Z1c3KX9N1+>K^?0E#4Q3D#8>3QHO.I7M<C>/;JK
]9OD-+2KP?L7-EeV02&T2=?L))JbeGf8C:ID,3&<DgY3<2FN5);G(GQRfG3AJE::
c:<0YO.T6/G_SGG1_(,0?QDUB(:\;9OHC5_AbA_L?&IJ^1H\eHgg=7a[N]Jf8ZXV
g2=E@8A=91MK^7dSb>d(X@GEc2a4-ZbObO#:4#GLEKMR=^g7J<RT1<J_FZe-e7WO
8<RZDJ<##G.T^0Y_,YJHM009J/1Q3b<,S_)+LHXX,=?7500EH&MENcPC=G(KTHE#
@&M&>a,Z1IQR?S&3RQ798TZ;5W89C[g[72OK2+Z(&d;=9Y(H/1K.1N3=FZU[AbKf
,b@^6:Oc\W5)[5SOP1+gS#;B0gM)4?CJU^EVA+IT(S;X5(V0]QbCB.a1JFC(+;8-
_fb5C:<]?)fJ19D2F4NKC?_6Jc@cU(B\Q,6?,@HZ#M\MTK>:14-J=Od+-eKP+d4W
?JJ2+_QT<BE3A?PS6+(7a2<ZL]=)@XETPeIaLBRV\U,/UL:N]9^(U>STC3RaL@LT
[XYS&3@2>YaEAF]?:c=CXT^=A\#<)W<KF3[=UR//XGOeI71PSA-KI2&7#eO9<#M=
Md8UW.?BSJ@K+FZ@SFK,f/65X<e9T]1ZZ,C=G&a,,S7.E,\aTQeQ@b_.#+5WdbA)
b(;;?L:P[Ge12[<7>AMN2V/=+ZagFP/W&GdReMa2gF:_SFF6G1]d8P,N3UfAA[+3
)b1LVO2BW1a^7DaE\QSfY_7I:>eZa1+9IfL-S=GO<Fead1?_N,V&^[^FV06bPNN^
[<DZB7Kc\-[+G4<>C7H@g:)>7P)FQITU6D^_;dS0://UB)=e8RBW?XaV;Fg]3HT?
RT_>^V6U#e\_V?g4[-8,-WUcCOW@_U(XPD)HS@4;E(D=YFJC13\/:=^f)^^)W/Jd
-Z)RMMHE63<XZ&Z>C-dON56AD1N2T(T,OCSJQefd)e3^=W_POW:VNV_c50^>+g4^
@@Q9L^U2GKeGCXU.RQT850aUFM7O:MBF6?T2]<17L63K#WRSAdU6&IHF,<-CT]&B
HQEP5Yd>TD[X\<CM1\V2^<B9^1@)?AP_>5J-_Ig-\K?8P:7K3c_I9c+Z.:#,MeHT
Qb>_RV8JZ28]/,4X/9HF?0d^Y;[;48X>21f#W(W.B[^Hf1^f:.a5RNNZ[4P7FL;5
[<EE.2QF3(:<QU5Z+AG(GQC==2TLZ+9R&^B7XCA8KSH1X=48Qc9JU;UFF[EM[+AL
HGc[V00Y/0>dKE>:TR\6QRf<#LTE]Q9DL9+Kg,@:D([@LARUFZ;.eI.H1bZ\b#-d
I35dgSR8Q&/+/>FR9G#DU]DH78cZLK3H#KJ5T;+7@XEeQ,Y;:_gN7[ELH1>cD]]K
2e>T7?:6UB>EaGVY-G?cF<4:b(Yb[8C&&ICfE=-W0f7f3;/?NV3R<9@=e)TY1L5&
MM#QN7061N7?)YKG\78_&+LKEMORWSa5VBFQK@c1Kbg@cN_4HDVI<M1;)-cM_3&a
<)N9EeNI1faJO@;:aFRNH;=\ZKT[egEfeF.<,OgYdQf0VOOQQEO=2)S[);\PP4HV
-JdV5K1AYEaaHRUb9)LOAU5I^Gf@>&e6GOH^J0W#3c94Eg3X?dTP&8gKYRZ+3D)D
SdV)H?]SZKX62\?@8gNc:f4e=1f+_7Y74;g7d_;/^Dc@2E/91E<1KJ??;#c4AWRM
6,<;a-\E0^2^6SE>^-6<)U+7fEYVgQc+ZE<+/^?SfG_=WCfXNOH:KgC<^Md9)U?E
DS1TWf0JC:KdF/e><gK#CTWN@2?ZF?5cP7W7I4T[4_?BPXD\>BaEN31;\@Z8[BM3
SUGPd6O]@4gWH&SbVXEX08;YM8?T5KTdT.UU8ZC^1L4Zg,Ab-P^:aBIOXR<#:2Cg
a.DWI?FH:[)(T6QQL1fY8g+eaACbJ9UFdV82@H:@cfI8feBCLd-ACYZ8QI=6#QQT
f0AfaZ6_)).HICYWD_E7g+?4]dafb#3;0(\1X=6X8H9ZeP<0=USP@N0B>C;C+Tf?
c(210eAE):VE&N(2:&/6KIL0gUJOUDX@HU+]/TJFM5W4,e/JOY5]gLA[[+(U[+KP
:Q=2Hd4Cab>V17-1#.#M85S&.dRLa0/gO-KML6HB^^XU2M-B_:;6,V3d-EX/20Q:
^H6)2(;:#<4M\>gG.P00->37cg8dK]=3@a)VWK\@^a+(c]/G=2/2Md:c[<S75D2W
9]Y+aM(.&gVR[A)VW[600E4G[:5a[:J5GHM:OYaK#;87V3GH[@LPJV,9@c)d,IDU
NM)Y49)3dQJAgAM]VUZT?^UDQ:^CJWFO49NMAJ<P\+e#1CFc[;3aTefdXF5>]KJ?
dG&Kf\BZJg4NPL1U1]EEDVO90B64A8):T9Y3?Q-,-K6MPLJK-FIBO?Jb#IP1Q/D(
,DUPJW&U2HFaI^SbMUIIU;:+4)(dM/4U>S^?HN&8,f/a3KU_9K-WaTcS)_O.3>R/
U6H6Y^BIb]R(c\(OMgFg5=PcdKC;H^L2W?18\[U+(9&?ZVIb40ZA&DBRa8<_LUXO
ZV19?V=C:=?KBK=4K9ZZK2G)<5e3cB7IEN[QM[[^S)QP_5g1W@Hf@UdJ++L+QXc9
H1FS@V8ZQH^d=13PJO+<WPa.\f11NQ+=K1E_aaKMN5?[NK)K>LBD4K^,H^L)#9]_
Y4FE(3=NW]17UB4;JIZ/(_:C3?dSZ9a)LYN)+(cBFCS80[1;:YR/_=6\H+E:ZTO5
JLD\YRA6;P=4OE=6Z_M@5=B:-Xb9@Y&Cb7?;/;LCJJbK(YE_TcAI)Z1OJO[#H5=1
8Z<Y:I)e@[J=P[d(NfY_WO6PMTVdGP:V])_:2IJ_0eCBY+Z=2ES08(.S-)]WYUK0
IWPU8:S(C3OA7fQ5ORf#7E6P1$
`endprotected

`protected
FY^,g(01US18\O\H_d2_CE1+2O^BXY36X1]gIcY_K;:428>Z-#T34)O2_dL:=\)C
X<SC>=Ca&Q_&@S.V:5^C3Q1+3$
`endprotected
    

//vcs_vip_protect
`protected
Ug1P:dWTUf076ED(.;WAW2QS-D_SWY;:Lc8_U5+_CPLbfE<>-02=,(/\<LAK<dK4
4f\)^\<<U]9I8e=30WJV>LMHT:RQ@^18=2)e_XW3G2)+>4<2d0gB<ReJXbB3()W6
W;.MP_]SP8[TSDO@P/f.JV&I4c)EE99Z=_T-3/M<1Mg:PcQY>\@Q&T6\P(8&b@b<
8^AeDQSa(_\IB]-g=Y0F/Qf;dBY2JD9eA4/1#R^FA4cR6dfPI^W-<E2M5g(+].8L
eXKfT8eU]>;5W,+@7F>]YNfS59Fg#aS=D4B?g?4Qd=I.N)AO&+GURUeMHFSF.]c+
c_-a_P+RLGe)N=45UBFS#?G4+A:Id]RU4a.3\:V?__080U,&bP9S__]^D?BDA(Bd
1P.RHQNcCB5FYV\BX]bY)U/QYC#[_&e2&/4\4T(d3KW0LFCJ6VaDYL>G,SJ,67,H
[)CR<^H<R8_[\>T]E_W3--ODc=^EI.DP?[C>5(UU^LMEEP/#I4:]22]Eb&H0(;>1
0aYPP2OR9ZB=L+#M_:]N6._81=6Z]H5dNWgVYLV839+cTQHbBZ&:+O5He/Y7N=ZO
KVK7=PT3dMNbR72PP^;?V.UDe.2]V+Z7.7AReIJEa,(6OS(=G8:\7@PeY(4QRVe#
32SY#b8A-N?&U>HIdTad-EY\dV\K\f@)YM\;5?E9P?O>?R/2,-;/B;JPA&J#2I-;
Y1:DR:1DJ_1?Y,<M@\O67+H;>CAO-;6L6+;\RXPbK[APG80?a2;Bcb3=b]Z>W7Y@
HN\6d/HQ+W1>SBWZ=)EUBf9@gM(Z<AfBQM;V6<BO5Z?W28-RW=,LUEF)&IRe3NK4
-5aN\Xb?U(&FHg/HT:NSbO@DI0#5S9:-UMAfE7+)8/XBB8NaT\FG+_Le#)>,27W3
O.SFDOFHQBU0IV>:?;1_A,Bg&X](9a,7aKM>OdgNQ/QW\5,?<[ZU^FF^^.=BHe,G
6cWW#M\a[&GHFQE>#,F8\>TL2.Y2#LIDZ#E,3aNJ<L^4GBf21GL^&:FASe9b.Y-b
)=EJ/HZW@?DB,B)E#eeRY+#NVMe;^B5S@A#Ag@+N?J,LT,/A[S_C=]e3^)3C>4EX
VW\4^eO@.e=YNdQB_\Y;GL:N7N)Y^SI1.#=X8J\7S_TBM91TWf.63(\bHcH]_?GL
FY&AOHNH0K4N-Qge&Yf5gPaKd-/]\G10M<3:fbf2;>F06^gEeF7K0:+1)G@fMEBF
\]LIKWeTS>AZL:RfbP,(RbLVG7@\XZAH=-gB1TSda-((QECePd)_,T^gf=88#5@+
QT(.6UMVE_:\NSPL7POML4H0=ZLaKGD3^/cQY_dbEe>2.LS3a>R10XZ9;TQ/@aWC
KN3)95(,_A4J/#GGNeaaRefS7>&f83HGS&&&4W9JdcJC:R@DD++FdOY4Q-QeHeW2
W_>a@E44OT:82F>.09]Q]YU).4H3WIDX&IF8,+KA6+X]a<P/:M8B9^T1J,f?D,^V
9gJb8-?4)BH#3W6;X,#ITRCSc7NeLR3F)4=NP\L2B3cZ4HA=GC@g8:X3e]BPba7J
Sf((cgSUbFcD^B<3Oa,cR2Ya^Eg:C7S=7c+&Ec6&6=,+UYNWLV#BcG193T&Mc>TF
PaN.TZb1,N;4HD10fP;8LN_7L.SAa/PSEbZ6(WD?LF[LLL4I<25fZ?f?A.(-]E;E
4T3&acJbcAfX1<>^#ND2+^F36JL0]4KNK[^;S6PR+-?);:9ga.@L:Z.J0Y;QL339
+e:I6g>P9?[X?HV1SSC9.QdfC5e#4IGE9MNZ5B43>e,aYQU+NE8BM[Q8)b@eA8Ta
F&DHN;TLJ?R:C5cJg;_Wg5dQ/,\9UZ3PXU.DfM-[9;&NKcT-+;^=AU1XcBJ;d1<W
5aM3GG3D-gP9^V6B:]DHAgH_LLJ^0SQ2CZSIW,F+D)b)Z:ZX>H)^:BgIS:YW4,TM
8dHIU7XG1D_<a(=0#EC??;VaZ3\[.:ZgPJ^<:J&d<&7FHSJacdfH/^Z6aY4f+@(O
A,Q0Z&Z8/6aS@F)[[.3;P5]+CTW?6@IJ6W>]0Lc;5T?J8J=R158)?TUfPfPB?TEX
?_A?,<R)]17OFYg2<>P,)/<AT?L?AZ:=b)#bTWV@4+3D1W8Zdf7d&-(_3Z;5AB5>
I@]dQ04Tde](=aRZ,@@U>cLU7dPI/dD,AS]#9YZOgd.5LMUA,FW-5W)MfM6Sa<+S
-M=.PO1Xe9aVS//M6H?_6>M23N3MD26^B=b>,LFF[BH^K,c)K?#QgBf->O=:03-=
370<_L;<>TbD#Z,B(e^OXR,7a&VE7A=LJH-G510)+BT)\J,1X]bMaW<A()0_CW,8
Y36YJ5>:L?Zac6Y@:,F+Y\.J#,0VLGYNLVdeI:D79Y#Cg1:<5U<D(:#92/ZbL=>(
4WVS=;^;[7_ZSHKDfN<HaXf-(F<T=e:VKN?g\KgQ:SIE1)IdTS+(Y,#]37<;1SB6S$
`endprotected

  `endif // GUARD_SVT_ATB_MASTER_TRANSACTION_SV
