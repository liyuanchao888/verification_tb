//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_base_transaction;
typedef class svt_chi_base_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_base_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_base_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_base_transaction_exception_list instance.
 */
`define SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_base_transaction_exception_list exception list.
 */
class svt_chi_base_transaction_exception_list extends svt_exception_list#(svt_chi_base_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_base_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_base_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_base_transaction_exception_list", svt_chi_base_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_base_transaction_exception_list)
  `svt_data_member_end(svt_chi_base_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_base_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_base_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_base_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_base_transaction_exception_list)
  `vmm_class_factory(svt_chi_base_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
LUW;S#9.=]/TaIQ9XGKEG#3E;QIT_=;H)?\MM)CZcY,L&+_;6#4J))=,G_\NV;SZ
2e7;+L=BWTeA,O+B9SP)KVPf9U432IPIRTTe]PUC8X>a/.LCW-A2=^WOdf?@AeR_
b6I3Q4]eW+MT\C[Ia8IPeIaG17C/BNI1g_P276^La2+b?cV2+F6.E7.6K8F]YM46
a5&68V.FK5+4eEW1-bQg)ZU\RZ4@&_I8?[FO3Le4TW6+?LUf]8FL_(;V.b0:NBRC
>f<W#K:\+b0TG919DHB(2<AN)..7<E_VYaJ189UV?B0RaVH-Z][^INT^7E@V8N)P
63C?YS7KcXZ>:<&3R[fK^-0&7P]22bTTdT^29^2)WdN[Ag;&Z=cE+VU\:O#;7NO\
<Oaf71_ZUE0</8QRSB<&LEG)-D_<6eR?+8GJ^J9T.EX@dCd,Y^(.Ef<;J#9H@E.D
N4ZQ6RUcA?KFAb;,A55bTQ>+H]?_L^HAV>.F:.\QLZC<D:=5G&YY::Z8VcM;Fbg?
_,da8MYGaE?J5FB]I0QeUK@Ad\.T@[9?Z:J@Y#Z1IK/U@9=59V6eZO6A-9MS0&D<
;)[82#=G8ZM/:gQ<_O\S.4OCL-B,1K/BX7F<O>1<2\:/5CJWZ6\33PC_DID.U\;+
D/1GZX26^O0#e@,[T[(dW#49\D1I^_+C&K+KC:BSW5dSSD3f#aBfUGdM+7_/4K,0
VMR?eXU0:7TMT7YPXKc/Q;2RL:-0[T/f)#/.Z]Ge<R\a9:d>X?;f:6,cD46/JV5a
/)6&#C66fK>-d[/<_B<-QCfGA=LdHZ:-S_a^gJF7Geg[8)(Z(fg5fGLB6cFK5Fgb
PF-\gC3KSH448dGaGCA_a@DI@P[?^=4W8afQL7?<]/V9b?2M(+?O0TcHQ.KBIANN
QLW.Cb1?&SKD5PY]:8)6-KGYFIDPQ+,a#A3;Vf^\-dRd0I]DI^YPf</ff\<46?26
U0]ZUYO^;T]H6;?<Q1T@IEaJ#)2DU:27Gdac8?FQ=eLK&90W:6DQgcHU^W6=a05D
_)=b;5JP>=4#2d1&CMd3GE)[WVULL,7Ga_?F2=G-^f0K0f5<H#C\,>^&J=/UYO:#
eLcK7[R[-TcFg@\WT]/?#Q3:]A6FB0)gDN/^N?XR:,<NRED23K>Nc73-,I&6@Uce
LQ080[FDMHNHd.VICSe]@f3:6$
`endprotected


//vcs_vip_protect
`protected
ZC^A^NgQ;JJA6H([H:Y0M^939H3f:bX;(eO/+LaZY=;XQ#7/-0=d-(GX^?YIYGOZ
.d>dR0DZLAN(X8HEUA9[c4b=,Z?(?/-6K&+DAf,CZT-C>6ON38HX])/c9]9d2V.Y
;T#UXbP.7MSPB&WL@9[(DDQB8QW?^JJK>YI\2g^D;N]V1?(6Y>6@Zc_+HA8V(DDS
fX6.6EAO5=eKYRKVK.0E-X(?Z6fBgg0KJ:82>C1_E,AGX_KQe-\_L7=,HOXK63C/
1=W?(0O/BO-^NNgf^\0.::A:4,d.K,FC^]_7b5?FbS;Y&_Xacc7RG0W&fG+ASU?_
RL\39C.^&5OcLP6H8^Jb?,DFM5gKXY<7V.UcNc<G9]U^O6N)E-C;9d55Ydg4Oa,T
,G7YVfb.;I7-VIYf=,U+\/?^L948W3:V5:L=H@]^\?+8,2Be>7+bYJK6=efT2PSG
;1[3CL=eVa-:Z[07\?eKA\B?R,78?T;OOc(N@c&)9:]09?@\-]Z>.0BDSNUD^P0C
#R0>R;<_BNRcaXa44)HRTFP_?6M\_JWAI+W&1GME<(BUEdHZ9OSbb130=5M444&)
C:b&:Y=/eY4:1UXI35@4JWZQ_UZ;IbXI+>QEW,RgW+R\5BSC8e2&\^[5Kd[3R&#E
>0K?1]RV9E]4H69d^T.\Ffc\D0R^]7:fA>GJTTAYOcbUd.-ODb4U7_/UabY83C4+
fKS4dNLKDDX3GS^ba?HIKWY?4ESC#N6#8V:3@CcH\J]UQ0VYf8+2:1(T6G\YRd(g
c^[9W=,1\;6;Q[.Y->8>)O3N5R&6:F,248[X_>D3AP@(M0UUda21SDQ(\/?>\<+O
@AKGIP^TN>[/TcS][7(;=GAI.>O6/;d/(VQG&WF6XPJVX;F2efW@WS(63M635^F7
Xb3:PfV_-I3dS#TB7/)Dg0>G80><cg[[?X\8J]BRG6&SGS]J=MM9V#G3aNS3O+BQ
^eR8+f@1>]bG/7P>4;HFA=dVX;JR:Y<>+1X15,f0=1[?+7#g>HRW74+=)O6b\MK5
<E9eJOG?L:6ZGMT-Uf\H>dDV\[^?MU)[,>SE1(;bB)aOLK,W.9U1;C]A[BaO0?>O
Hf/PQ.]ZP8/f_+2#aXaL^5<b.QGgHS[e/;Y4ZQH/_?+\g/SNZB6QHBe#6Og5.MUZ
)G#T6CFN#eX8,(^g#9:Sf5\7L=OV[a&V-]B&43I2aN8-:fBMV[RM&fT5TTcV<W)a
C-8U<T8,BTYCHR6NJR0^Y@3WCT\NLEeNZ],M()LZb#I,g3CQg>_5&d_;(3=4Sa8B
7:7VXT5H?U]#d=g<d;9O+c;/LOYOK7MLFC(aZ(JeEd[Pd4KBg^)g;02C+cM8E)=[
S7]\X<.Wa]_M?MCgX,)+/:HVVH\g7fcS6).>\GYI6f@5eH\,KNL)_+C;9V?IM:2e
)I_;TV3,4NeDGAZL>VQ/QPA8?]QKWUT\GYX=;:.BD83c5>\&_95-BIK)-GD<33-(
LD2?KcDR[TTUIS#FI\W^b+793Sb::?HNDU#8I^SQ)dd=XU_g.bR+FOJe)>/;dOY)
TV8161TNCX?<KW2RK=T3D)^-FSeWQH8E10IWI7&@QRVO[,F^88NVb.]8.#&7;Y(T
DD,3\3].2=#2V:@QZ+/>fT^E^CG+F:@,cE:B(Y)/1^LTHL:f?G?L30G5b.[D[_c#
U&5QWN[b7<[JE4I6A9FPZH#H?AISM6=5c;XBe/Q6eB.&)GGR?5V5@ec//N&79efX
R;W0-VKSfY5Ug;W01U1,J2d@05F2@F[82<?dd?OW5:7-,+dR,DPUD)\E0Of=H+bc
?9ZSVafY3/Ne;P.aR#:Vd.OgJA5P,=:BGIL;XA>TEJ,dIE-45>F+7NRJJ.bV0BE-
^9gVEP,5U3g35H/2PZ7Z&UO/bWJ[LK=@RGL((eUD/6g+b<WT2HSOZ:g<1__G+PN4
GE;#^d[=NX>D=S]?XVRB7V\J.f-,FGQQcT4RO2@I<(M6:F3AB=K;V_K;H.:F/VA&
H9dF@F8Q2MG\34O=I49<9-)_DGQdO,/<ga#_KU@:(&c\PJeS88eJY_7TF@==IY_Q
[>a^WV8Hf[?Y5K?SP44+K5+W]_LX+L92Vb0I,RU-4.O0FZfaDR4A2O-+YYML]a^/
<HM/aS39^YGLgTI0c0Jb#LI7X1YJHTJBTR+J</5>///[>gS]B9U6W.G0>\V@910)
A>U38:e^FCNg)YXDU(UOD6I=]c5BEbdUXBPH(-Zd18?TFD3LDGLLF>YB>#2g>\T(
FRVL<RQEV39@5P^X>cN.FEND<UfN],QGbV9-\YD6BM@5^(+O:8_d<dQA>)\Xe5:?
.W.84^?40M.(75VdSDP.;E&+6@]F@_M1)1eJK8BD+J[CLE=TS0;:d1,MY1g(cLBS
S3]<H&AZ3EW3[f4NHKCa7bI^RF3<7F5_#V-/C)YM#W^O-G-_J)3,5];Nfe70aW#N
IH+D#-/SgU/-@3c145BJ9VLWfL>VA</><3RE?U4^/G(4D6R)(\.9MX&IO-1Y1eM/
&YTd>IM8FU.HXH@.Y+fM5(bg;459_fU9WYd.-->Z91(,ZZN\F5L&NVIRD\d7^IQK
_+S1M.TU1U9_f&](^(L<433^.:UC(NRK:DbW>5Z44<(X9/IWMIA3^+-<._F&-H7:
-HW<WAX:7WRV_e)&]S[eLd=/1>(^Q?DYR(WfH-@/;WG=NC>+5FIaOg3d[(&78LV5
AK>.Z]=U7fZDFC=[D=)7A]:AIVg1#_ceRKO4H-,4A9LaRNa>dA[#Q,HO7()8K^NJ
d<G/D[2Z:(&1YLX>\36S#ISUgNA6c(N&A7b3+bS_ObcNcKgR@-+T4;KCN:81VF5H
X]-KDS;VBSe\^_7[#MKGe=.^T1:^;_O55Y9Y]Vf<TIVH8cL@RO@f]JRM4E^D9eZT
Ie;\5CKBcAD5@FDb+X+_Nb@cH=X9b91\YQ;@C=8<2eU9<]0))D1_H]_EE#4R2Xe@
9<C;#f,b2-A53<@H?B4S?3-_C9#HYLQ[QX[0S^>aT<O-2C>g&g@TOQ^V]EL0?=S[
O)J#IYH54+&I@#.0R2[TGL3^8#aLc.1&cRfgR]-DbO52ZHK37eUTUM.gZecdP6G0
eW^-BQK-MMW?g6,,<H:L8d.17FFD;1CP^U+ZU-9:;7UD_,2ZbW<;\E+9NYdbE3c]
T]b2&Z+,RARbOZW+X)4<E,AUMUE/4I:QZ[3(&QagKO.Y)T+L=be8ZIB]Rf\E05-3
>\J14,#c:E-)H(93X.+Q:^3#MMW^#M#,HFM25ALJ7;)/E60MbW#9PMG36E)<=@HO
IbVE\-_];[_ZE5Tb?Ye+)VDX-X95TAUGV_(dSV<_aCf9,R4;PN+BKU_(#6ZXA@T&
+@9.aGbJ,=IU0?ZXEPRZVRWLH/:5)JM\M9;9,UHO0?,4682aB0<_J9?K38\H52:1
9LH<?[;0-[N^f4eXb>&0ISc1f4T9,^U)IW>:PKf5UXRa+87?A849FG?afRFC>+(N
&:09gT^Z-.gON,,3FOLDg3[GE1a2LO&)/cA\RS_I,CT]ce78/f.MRR/OPO5T;DF0
]+L_abEgD)c89Y@H\5aVM[c71DQR=W>;TT42VQZ,/>K+9=0gX-W,=A@:.@A1Y6XK
VbC4LcHAKWVH>J@1#?:6eg<90g33XV:GK+1\#;Y]0fO#]AG>I#7b@S2^KVOYG.Kc
fN5=J-1dOf7/NB8T:EOa5;ELKD^#B38PQ<Y)fIQ4T+I+.A+Y09NJMIR1X+@>L;fA
DL]Y^V^Y1.NS<L\YNJfB?(efQ;c4Tc]D1^WaaW0Q-84XP])AZg+Y/L\NA-S7;Pbd
;Tf;gYbeY+NSb#Wb@MM;5\MH-AA]D7K)X]P@R;=<:XC3HAbbQ.3D<GM99:.7+BG;
g:2]K#7G]XY1MC>L+,P^K1OR7.C/T-M)FHGL2aU[07(_\aU+=S1VNX?NaY6LUQQ#
=6#N?ZPU_(6I>+..7EKPM);X+[=#?N&P>HE=R+deLE:Q-ZLI<dgMLQ;6CZ>URA?Z
079)[&)[&4,<+]6SMD<?077F0:Ce@a\QGJZ:X=AEHTOF303E=:;.PaI=W6G_Y4>5
];E-RR].3HK<&<UaYIca#[2<L)U30gP;26:/C)>4D[]]SL@I>O2g]I_1H4>ON<J<
LcC_/:?U9D4fCSR/[-(=UU+0(\>1CTfESE39CLd6MPU-6Z3XcWV7A>[^257JEVge
4HU[RGCA>\?R]2Ug/^-ggb+I7AVQ8b1a2\20CD^X:&T3H2PN0-PDRCIVSFYMd^b[
(^D7)aaL&D0E[H5eES.A5_=H2gX2F^8X>,Q#9,IHEefB81C3<5,82f[&g2\W(25W
9_OMDI<OH50M(<<PN6\9FK>=V9+,f/Y^]<W]dY3]/4N?2+O:d6Y[_K+5CF?La/)T
LPfS<_XfXOF2a((+3)-OK\L53aS-AKQC7Y:A0-RR6bNIH]>&AMPI^;:&c5A&8(V@
Q>M8^@RB2UeG+Qg=a<LA5487ccJ3YZ&K\KR0L3=5B7ZDe:]?B=XMUAfPf^>J3_.[
<(-&\K^MKXCf</3#aJRJN>0[Gab;-7G8OKECY\S<S<=RW:U];DMGU?CeFUV#SAP(
0Xfb>)/=dDS0PI>_/_<CQfW^/+Va]L=XP=T.T@;7ZY/L(d8_W-KUJ\g&;bW35&Q&
Z\VPaH90QEd]>Y3_@aZWD&O(\CgO4DC&M&a-^5U&J&<^[_0112BAPfZZdAgTa+OR
f5&>JXfe#1/88;BaC,ZZW#BRQ(dUJC>9eX829X12)>MIGTL&QZ2=e<FOa/YB=,3C
XMO?W>T/W0_5B5)Q_G5M@,V\/K@\3+,LKR;If^EBgKNTWY>@g)::=W<g#:4PA/33
P@DORMB4X7ODD0W?XNS^O?5?@[[Z&)R(@O3d]&6P<(VLYMG6=U3b[cfK+)HMVd3X
,>;ZZ70TSUWDW=05&,6eDK2T^&PSOBFcc31F(AQ6M9O)6#@)#8gC9?T<J5dd)7>>
+Q)_I3_WFY[/8ETdeEcZH[BC=bLaO-V6>L>dZJ2fM?>7=4E-5<Z@\H&b;:Ped0@R
P=^J8M,=/1-3MeVDG\W-a4+T_^D,QZP6L_T-)03a(^N/-JZN<A8.M1eG30=2L46=
OVJ_644_W0BFNBP,_-g,E&YKS7LWIBRF[cOX8?9cba>Me,9[<:/XVFb#22J#4(Jg
14(Cb4RQA5[4VFOZ-A>(&3DVS2Mb1LcJ,E)?M;]^AXa(E3:CUXBYDG<)3+4S\Ma0
GJ7g.+[2AAFL/I/&.O-ddFbA84ZKBI])J^E8fdK3&=T3]2LZaQ<=_UXNUT;7g^:,
0\@dT<VABZF>eg?/N-U,)d#TJUKTD]NbB:F98+Ib76<dL/I[B+UILaNYJJ37V041
TV@/9]B?LBRZ&eK6FFg1\-MeHWDGKEe?;>/)?@-e@Mf)7[.G/;\P2WVO4VKR=.Ja
bFO[:6:AdM4U>]6Z(@B]#\&D3g)XSB7(fY3XFPNL/Q3\ZfP4(IS1J>Z7@d?JRI-B
Ae5]:^ELE?G3g4Z10:@/;_4<6TM4MG:=3AP;N,;80@J,4->+E^Yb92SMXg<4@FCT
eEQGH^HAWAHX0,0H\?c(<GAJK2PMZb\-JgY.eS0Sg0MQD09VgP,L8RIcKPA([N61
:bDXIBB[J/^<-^XXGF=/&4&9-O&BM<GabaaA7UKU\77..[_P9&,6cF5;^+7?-U)2
+Z#\3CG37S-2Z,<^.,=a58K:<W??D?(]a_\Z>1e=?PZ07@a^?IGd.d,TT2c6J.fQ
QK._K5HObGHTWY#^WATGJ^\]L)(F39X#O\(gI=SN_1F@&a.BNTJ(EBT5HNU]IOgX
TADVN3cg6KV:?;QBS3HI.G[Z<+f06T0;R)M+C216ITf[/73TWWe.-TM>28/2(HLC
L)LUO-)M1<b]KM/Re#L++Ia3P,+F@#Ae]TIIa,:@JVPXe5b7:4^H/d^K3;-1D4)S
<&1a79)&Dc6(E^BUDQK]_0SB#=[cPdIN+A5f_K;aVVGE2NA57V>MDT@D8S,#/UFR
6_GE(PW6.c@[aQOa/W;1-OPUSF^RA+=^(aRE<VfY=CM@]NJ0)L3\QIPTLD]b/8DB
S1S9\O/aOO>M.O[(<QG-U+U:TK#^PBNMB0]+OMN5&e5QNJY(.fQ30QTPd_@]4d)D
4YL+J1^N#S\cEaJ2Y=4M?7F#.1d]:3?+aPVK2:,S]2YA&PRHN0HGUCV@/D\IJ\+[
067aUTUF&9RG>&gFI29ECZ_,XCOBTb6VPI2a2\e4N<+:VF\/&QQ]\EI1WQ9<4ZY;
Y,4J]5]LL8===J;KEPL367W-?(;P(H\_B&8GOUg]B-_66AN\A0V87SKU,,H,<)6=
Y],XR?eCgV7?Y/1g.2FB[1=[F-5=<;D]b;91a:4VbFFbXf7:OK9\]N\OfCDT=bbT
+K45FN)aQ6PDN@W9_TM49c=GHg[0UD^0f:G_V3,^M-B]+^;57R3C=Y_5EaYWL:0\
20O(SF@@-JE=fTcaBIZ?=A0gO_dUEZ:)AdSHQ03F&)[/FU)]PKF6VH@EgPD,OH33
OOd:I4X&?I(U<IYNa[&/(KH;/93YJ;[ES^-,+/L2A.T0Z?J)[gH;1YHTZ1?#bOR@
^-&K4#e&#]8QTKZgAX+02WA6WbdQCWXb_HLV^G#H1gJIEEG9?]EXY3:2I;T(PEIL
#4NXLX\&YOAW_C1f)eKI5IC-QGDS(af]e,9DfAf:>^EEfdUO(;2[>ENGMVIRU9B)
U67.eed.abTfL1c+Z<C7X>fN&AWT9:aKdHB:Y=Q;+MJO[+@I45EDUAAQ11C(5A?b
d@VIOcaLMgf8W)+/XML.W-GPQWJ<JBE.1VJ-,@4;cRFR(E5dV6;&IgCS#9?TH?8I
++CL=1AB\F@9:+7GV-J@<5gb,69g].PNaB\PHMc;CW:_A:JC7F@\a9TC9W&9?@XK
[3ZLEQ1=KJB2CQbW.(MU-3ZbafXUCL5@Hd3]DbfB6(7EG:bEGEH+3-,EQJfOJ[XH
?^JH7Af:g(Ra82;(UR0;T8,\<0TQ/1A(S@+3;K&RXM?V@X1SZdK?C03gaQeMYWV/
)5-X5+M+0]fN(QMf.7K(8bBPEO#3gUC&4^#_?W3dJ5J0:[X6fK7aEW1.7X?CY\8e
;Kg4OFFAYD_7g?6;0f=-g^JT,&B=JVb/Uf^@2\Y>O@6>Dc9,5(]#94/&5A=&f>bV
0W89]XQY,JG\7W-SU9JcT#aG<O5+#AMLHH]A\T/+fB/JCH][>NV<D6[US1F)W2JY
dML<:J32QT6I[.^=XH7?a7^?g/LP_X,G5L&C6/U,^C5EYB-_fK,V31,:R]ZD+3?Q
4D4LBOVZMgc=.Y^LKfI_Ne<><6N)\>-B.T>fH3.J))0e_LYPUK3BLGI\L#NaP^3P
=g;ECW#0^f\3-6R9==FW,eCZZ:NAHD(2THaZU)]U)YL:;NA7J<_Z<c?3Kg:GRCWF
8SaZBYBWQ<@02N7MdbJ8@-II4EKaPfYY>617DFMIHO[CcKWBJe[W5^J>K.V?3;b^
=4YVb4g4H(g#P)Ha3.5N,9C=43Se>0WbO4<11(\gWHACVZYH683\FYN?f,29gUZK
.SSa1\PMBdaHDU9YfUVOW&(+:e7dH&cG;A.c6&([PHNZd^GV,HNNW:_VJ632IYPP
Z:@;UFK/d7)6PI52NETQEDMBf]4[dNBDCZTP#4gO93K(A]KO+8B]:L7dSdcHIYY&
77\QPfM@XgC1@RECW])F])S]AJYf2EAF?9bYe[GXBER6K^<^D)Y?O#2FGKQ>LESe
OgI;J4S=Ia<1A#KX56-MceE3&=NG-]/UUUOe28LV;b;7CUQc7)OM^(-@=OVJ<X?A
,eab;M&6\WSJP-EOMM>0)+F8S>XbTO.6H&<62fBHJ_UT,OHK8J&XdZH#E6fM??I/
dfL9\..;Y&)F<]GfdTdI_AT8T=>bC,B:MA@OT:;ZK@(RfBRPS:BB[_c-7B\=,;c=
=)+d,]=+W3N5;V7?0@G#:.JGMF]B0BYMWDaZLYf0;J4NP6+X&R(LdNGL:9V6QfFf
V\V)1b6/e(Ibgd&(7cgVbag)?g=0@D@YE,K.S<9-U,<eO^_+9MIcC?d@,<].ZC-7
[>TLdaOTB^Q+4;]ZQ/d-MJ6Zd:5bIK9U@/A+(2X(<aAMZ?9Rb^D7>8X,IU;<9+Sb
M/g)50BE3Q9SDM>eagbLZ3H#MV-3E?:HZIC(5W==3gc#J7,d:[R:MaaX?TV7<6=X
VT2T00fL?W9W@c>>NaP=X;N<O4g^(Q3_dNCJ.SRMLfEZ]Z&]DLNI:7E,D/;_]ER.
@W81HNaQ_7?EY-K0=I<0@SA]+/5..[AF9GW#4##&M4=&.Id:NLE?D+Y_Y48cIE83
11f&f01bgQ)N)[SRa#AB)F[]WSbED&)+bRLAMS86.JA=EZ8/7[a3]UQ2T8VP9J2L
?PA<T?GO4=fcEYE]aG)LfY37^C\<75/9EET>dVI^3]DQM.Uc#N^aW><gLC[(ZD)7
0NU6DXFOI@-ES+dRVX5:g][<<?NV^I?;MgCJU/T-[H3Z;SJX-W59B;[A9)ee;R@D
f06V8SBC+1&AB#UC@EDK/^08Q1F).AH>IG=DX@32c@d@0G8QNN:(##/CD[W,LQA^
U5;BB847;WL[.HF=d,8UI.]VP<?<DXW]^2c(,HY+.IB.8\@L<9K6(J1g^FWJ6R^/
ZAL(g^)Q6127A]2;5M,XaHQ+9d995;RRbSK(QU0ZYX#055M4aBO7YLA85b3-8aN]
<0B_9\7;N4f.]D_;H0Rd=88g4deHaV,S3X+8A/F,HT<C;0L44KAX;Hfcf:N.Q=f<
EY;_2\dAM[<[I[(]]9)a,@8SP#+)S]9?48RfRH[a:M#D4[Q(CG>a@PP2JV;&4LI]
5ALN@925+:OPL<<UcMfG]>_Gc;dP.LSg42=WJObM5]?V]M?S<1(A-[c)\P-9GN0#
GTa6]KJ?I85FN3=[O_\GfAOFXAK&>A\&O^75P)[ccH=-/05A43-]e[Y\)aN:VNLb
=M7,SJRI_?KfUEE_d;a9.:[&L,A;O+:;cN>-;P(@adO4=eOY8KY^A?Z87LCFY.+K
7aN<H(/3FDM].MEXF4?3Z-=-.gU&\0bZ>Q#GP\Q471<EX.Y5GY@D.@2KcBK_PeYJ
?SCNEXgG>4@_&b8RF/g=++N:c;X\+:IB[AT&gC82K@8,@>>(\C1LK8@6\PE?WYFa
=2[gbI5[^0YSKC3bMIV&:PWD5U_#X;>Me1Z;TMgV;HXG\bY()^V#VA_0CEE44QQ]
AL.#);/CP:SSUQbKBR.DSOb@0+U&X4[EX,)bST0V2TcgaT79&;5Y4IKK1d90S/B.
.KCS7;B+J&?]9L<YDMWQeQRRJY?:a.ARdOfZ>OOW^^)(6.>JNXW4ZP3<RDF,b9dR
Ia,\b+)>_:ac]4A9&8C_C2DU/c,:OYVSM,bPfN_H<\1(=V+MF>V4[beN@\8P,<R8
I0>-ZP4;4bXHR_F#X\V@;7N9ZJMeYaC<NYVWdYJe8?>USUd.YDAK6MD\A-g2/G=.
NALY^#-@:B5-U&DNdE3FB1?DY=IGC,(2,Q#7_D.Q3UVbA8,bcQZfc.<=J5Z6&E(Y
ZNbP97(dOBa\dg)CJK9LN.<HbFPObPALR;7\#[T]&P9,-Y98gCaPJB.24JS2RF4^
WX?[TZ9G&D#G+-)>25_K;E4:T-2ePDG\F(/cFAKZ/=WTWR>-JS&cVJ#&IXEY55?,
7G6B16(6NK])@JV.ZIG<Df-P-@_U>a4=[8E,-A>F/;2FP26APE/-bU?7_-U4PA8Y
1>3<7262UE927^^Y_R>D.DII.e51cX\HFXd76&WUVM.7)0_bV2KXYd?Z<8P?O<NV
T#P>^5]ZfZU1>QQU.2fS[,/0.AIE)O?RXZRO7Ve]f;M4Y\aS::HT68&71@Eb4&Z^
aA)S3S#)I<N0(VgRCWIOR2NX9GGETI#6:IGD+FKJBa-K(4@X_0UaR5-Q\67VZR@f
^F1Hg5&)L5=VX]AW_RB_G8ObGVQX)gNJ<[,.Xcb[;/8SB/a2)N:XMb7VWCE<[S+,
?gE)EQMF0\0IT,\AGQTL#(TP7b54d>CW0DKG<<\Ca(b8JN-7F=BD&M^46V,B,U,N
+YF&UeUbZM03=MLgDAd?d]\,INMebK#F^K&P_C]2#,BP7M4O_VcM1:.<QYK7L[dT
KL<1SGT]QAgGU,.EFb@&LbLE1Z]CNIc,IKI)P#P4VBM\\0/;@-02KZ(Jb1Z(G(NQ
M??g.+gUUeN)(F2@g)JGEg7DT>/f]M:I:NPdUIG_#XJVgaL#g5Y4e=(.L.-\26PQ
PF^2<0=]LM2:f?bVeLQ@e=(gaVZ3510^JWV#PUSFX-gLMEM&e6@_JY)<84T.Za>8
R8@K.#HM5NW-N?OX1e<]EAII7W]/17&V_R^L<WRWaXJE135KfZO;KaQ06>FF9]=P
0(N6JM8I>QDF2<D9a>d?]MN<DF@cL_OS>2#26X+F]F=C06:OK/SH:Y;ZZIY&F.>-
dVAggX6B1b\CAO5):--DS3C[PC20BMe7e&[:SSc2gWW?)b:IJM:BU(5U)YD1^FfG
8H@KaUf,5S7<57ZMZN^IgRC2)/#T2Kb6P9<bS02?<X8FNBeffSK/eb-B#:([IB][
HWTX<VKAW=ce2^AI,.FE,g0@/=006YQK6O7P?+G7H,O-X>KdfJ9D)_Nc>,T,YCb[
SEGMLJ:YL[bT&#RZ=YT[&D_LV>BJH\M>1U-E,:^4HC4>Vd^2.RU=/;MMM,W-D+e0
^2KbA2G4\1+T.$
`endprotected


`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV
