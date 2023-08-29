
`ifndef GUARD_SVT_APB_MASTER_TRANSACTION_SV
`define GUARD_SVT_APB_MASTER_TRANSACTION_SV

/**
 * This is the master transaction class which contains master specific
 * transaction class members, and constraints.
 *
 * The svt_transaction also contains a handle to configuration object of type
 * #svt_apb_system_configuration, which provides the configuration of the
 * port on which this transaction would be applied. The port configuration is
 * used during randomizing the transaction.
 */
class svt_apb_master_transaction extends svt_apb_transaction;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** A reference to the system configuration */
  svt_apb_system_configuration cfg;

  /**
   * Weight used to control distribution of shorter idles within transaction
   * generation.
   *
   * This controls the distribution of the number of idle cycles using the
   * #num_idle_cycles field
   */
  int SHORT_IDLE_CYCLES_wt = 9;


   /**
   * Weight used to control distribution of longer idles within transaction
   * generation.
   *
   * This controls the distribution of the number of idle cycles using the
   * #num_idle_cycles field
   */
  int LONG_IDLE_CYCLES_wt = 1;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
//vcs_vip_protect
`protected
[T;b-\-RWX8T0?6GCAd)#f?0X=V4TE0^K:=fYNUEOO1>?02O.=SI6(O&d)(gS&g=
7^.TW#0b9;gE3UVV1@/HTYSWZ985gUEP^WW#]1?PF1D.R^H4Sa7D7+)(JRd=IdWB
7(7?RR>74>X=M\Me?&fad@UYb<\N+7PY/bD-H.MMGFFR0[g3S4\bXP#6-_O(?3E=
(a#DaRHH802K(2#MIcW=/H>V=3P?V8#(X]4,JVd_QAY>:FFY@.0-We7b)W][F6?J
OS-)2Tc:?&9c/..G;&]2,dB+MO20MdYTeHA?.+@D5RR>gE,eQ4:=JO]K&U0bT&PB
gTB36/PQC9LKGM)dZ;/7PH[ac-T)>UU_aS3U:]gIPUTSgE/,W(+V8:W5I()0a&AM
G[f0&77_UaDW\a63)?13FPVf9a6BW-d@dNcX#XU&Bd)cX)>>K27d)0-aG5KdF?3=
,]-R&4LLYQX0:\];1:W/L1a1^^gN,2N+G._8AA;GL8W5g_7FPe,@@3R&OeNd2W)@
W7W@.cFf)^2>NKZE.\_Y6KMgS62COf5PQaB,DW:O_X&#2=@35O,-1\^)YKM?,857
MGR+#Z6B:U:#.G:J,c]I?H1QLg[9N&+Z,2:H)7<::LD^FUV:FUXSV.YFV>_[W_.e
BTcA];,,)@N]E>BN+[QbFUA<6ea6>GXRd,:a[Wd=BV:Y&QU64Jg52eVC+QC9V:\d
b7Y;;YY;cAegUD_(NAMINRdR=[ePRB5LbZD=5ad@g:U=SF[9>Ca)\WT#(G6?f[\2
:MW?TM)FeY0Ra\dQN2#_4ggUb/JJ/)0;.0578(He42bA7KcLS)5d=XZdO./5KBK<
dI5X#K&OGO5\D:L.^6\bbCa^^SL:9=?@.^ccO^Ac39Q6M(c3A-Ob3Ieb>T)0dD>H
QZf1E,R-H/;,V5#&_@#3FWR#[>QG7L[R4WE_EFCF?+G#^1,;.Ud()\G&_Ve:4IR8
,E\KC[b)<:MEb/VS.#VPeYF>Y,f>(M[:E-_f-(ZD/\,1D;WKD4NA^5Ud7;-K(,@2
0^O2X;M<f7T+S.bcZOG-,4.f0^B54GfD4X#LHI28CP4<bb147[BO1_6A?/<0M)^<
Z+7b_)Eg7:cOdD6,HO8cGSAD.62)fAZ6HZ:LE+5/#MQBWBVKH_VV?ACPW<Rg-X-S
:CQ4[?HI3-]0f9QQOWBSeRTfSD[5=#/VdF#6D8&,]1DXIJG1:e,:M6AR\HKRb(4V
>7SJ#21X?ZWG=(OK.U7ZT?@&&X/bLg>7YX]c9B=0&50bMQ@7:baC1J@cC:?4,0BH
b;fC0#QM8Z#(eD_ceBNFKPE?RAd_]XTd^(]JO6T(#HC;GONT[P9D(1?9a6G>dIMD
/-#51PH5O&-,S7\faB_CMIIRK#Z]c;DS?Ud2O>4_Y4?dK/8FN>:VAN]O+]9&2Z(6
SR5@E]]D9<Z[U^.0T)g#Q>5EE3;KKV&SVEUP^PS8Qf[TI.W1B&OFcT,1BR=._a49
&0\_0@-NA@OQ6>E#2MD0a-5E4$
`endprotected
  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_master_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_master_transaction)
    `svt_field_int(SHORT_IDLE_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(LONG_IDLE_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_object(cfg,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_apb_master_transaction)


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
   * Method to control post_randomize
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);
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
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();
 //------------------------------------------------------------------------------ 
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
   
//---------------------------------------------------------------------------------
  /** This method returns a string indication unique identification value
    * for object .
    */
  extern virtual function string get_uid();
  
//--------------------------------------------------------------------------------
  /** Sets the configuration property */
  extern function void set_cfg(svt_apb_system_configuration cfg);

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

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  //----------------------------------------------------------------------------
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
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

  /** Ensures that the configuration is valid */
  extern function void pre_randomize ();

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_master_transaction)
  `vmm_class_factory(svt_apb_master_transaction)
`endif
endclass


`protected
8CcYFC9W[__G@/P55L7>,e86c9-G[.O/>1O///Q.>C2,QdG(C\UN3);\Q;^,FQ[;
g.Yg.QOGR3QeO#)<>RF]GT&VS;Gf<<\615.1.Y.c4G],F0fWMfTE&Z31T:2(W7.V
4b)XFSP_CaQ.B.QXMI7IHXIDBF^bJ:YLNN4ecU@AB2Ndb.N(CaOX?-^EH43HdMWT
HgLb7@8.#/TA-B67M#<e[aQ&R1WTF..QbZ1-4/R5T<aZ)<UPF7LQNI,^[,XD?VU)
S3L3:f9Y.+R0>)SaZI#(a+Rf0/UT=[b[4QDf:?3A8=>;#aX9J^HYE7fb&ef&?.#,
79#a4=9T2J3bC.,O4H[<PQ>3GD.EZ<L(G#P0eG9Pf?)H^0L(63Z/Z7\NL;?J,G?)
-E/LXdFM?QF<2If>2\S^E.H//\Xe([QZ,QQ1:&.&^6G<J,d-KB)3@fH)#XCMdL8W
7S3]>cB,aFb3YaPLK+TRNaT17QC(FAGNFXNON#+HfLM0,ZJN:)C+6BW5c,D24BWf
,ONB+b-eOc>GI8&/D4;Ua9DZ(@80FJJfc#7\XDDeBg+AOD274I#;@(f-:MLJ.2)L
CDaH5TIRYBI>JK&XP8F<SeB9SdYCM0;.+WKI?UQK@WK\45)MD4#I_HLY,3.Q_\[D
J08R#]CEc>RYAPIZ0^=5g((Hba;c&S7FAD]Pc,b(1VCcb3JV-B9+P[3RMTGc4C9N
V\.A=?_DH371YOf8Z><V>K:,PeV3[[KJ+S>G-d1RDNL9T:&AYgQdP13RP$
`endprotected


//vcs_vip_protect
`protected
@T(fgL70FPMN,K@7CQ[fb+9&;5a6QAgI66:?89c2=LCU28NY^8cH.(,&#VT]eUV-
_MSYCL2.1-CO6dFaT+=IF5Df)_T+..3MHO-&([b[L=7=<+ACGV<Y_OT=_PM:/UeH
\X-?#D53J22RCA;H(E6&VN<bXc)S9:U9RPM,f^V1g?M#ObPI3f-S&<\PNJP[LGbN
cdORKG][bEOV3/#W-fR]=eYQHb2CF9\TY=2MK)\cgYe\KRbX6Sc/E_8C^_T2N)e2
L?8e<4MEN5&3I@fEg:2+bcg8;O3.P\f/e\597+K:Sg:-N+#[>:a\Lg+BIV+9+#+U
I_I)GWN8LXM)+_g&/Ya2fETe^R2@CEbXK^P=U^>U?ZH<BJ^_ORMT795C8@X-<ZdC
M14+373>.[N&+9:CQYP<>cM+\SDN@ZKF61/[]#^gE3-SM2@BgRBV4bWD;eUe,#,5
PYHa-EMeR\2)28)9#0@B[:\P#O7a^V>d:7d(L728@Fc0A5FO=Se7-2bA:.2^@]Pc
#I5eIC,:_a#/VVI14U=_+]G9?4_-[Qd=MU-#MR2FMO08B0Y9CX\S,L;V>S_6cAPZ
\S)XNZ\U;,3F0SYZfQ14Ea]-,>XIf3?#5ac<07R6(V/CDVf6B-K30<SRbG9eMUbO
+@8VL77@[U\^S/8+AK<c7A&\K)70L#TK43F6#(b8RJ8a?/8;]AEeUQF)2W:-<D[K
2a0KIVf9g()=,QW]eGXGGY7^R/C@8Q[<gJV\T^#fPAN#K_8YgQSL,M@1=^bI9SU,
D9MX:ZB;+#b:HUZd79fQ1F^/J[:g.D)KT&Y<e1b3HP-VZ(&&5E^BG.F\>A8UJTaD
dXIC5<^Lb=a<^7;2]M2g9fV2VW+?]8=NZ@YOTSeC;A3)(dUcdZ#eL>&LH3CE>7H/
+@aZH6_7DaED5gAF8KS7DH<-KWJC[RQW33J>N\A]S&?aZ(;&)U@GO\JE7(198^PD
]Y,RdK?2VM6TFc,9R(5P8[M\bTBNY(>L/6EO(0A=e,/,8^OGQSb(2Y\]\W7F]OF8
])BVK>7E/V)@^SfJ04DKA.EW[F+4aD9QXcTVW?,4?1E+/a[TDJD=D4\FQ)OZ>][V
>NR5_2PLC<T@-$
`endprotected

// ----------------------------------------------------------------------------
function void svt_apb_master_transaction::post_randomize();
`protected
KF>;@+e)</:6S[Z0+e>#I2:e\I5F)3UIJ5D4A)1b&.S-c[?AcBBN2),CV;(Y531+
JW+:EME?a+Z4K.+D/#_#8d?\4eJ8]]Xf+g?19HF=3#YN:7Y:U6AUaa].L\cZ<SY)
Q02c(d5L@^&J.G(/0=f+b6V&Nf_aMcB;[[=1V8S&XKCY7T4B&YeI\NcIba4K(T4a
EAJ7QA31,^1&@Y7YFI,)2>]BGD8ea<MKg#gU.3d=[@=32E(63:QY_BMY;AeZLLOJ
O18S7-8];:88V.8fMIL[,)AZD]A^,)UCcG:fA8??W;HFGK#.#49.)X^HCOF&IC8G
.<)G6,E@:+#^F(4=DYFaO(W#fQ51R>GTeDMLOMMRI<<N/\;S5ARe3/T32VJ]7(;R
<VcVDKFD?BTRFZZI>8aQ39K@O7J_,Lb5Y]MMa^/2(91??Vg#W,a7#+bd>BI=Nd<#
=_KL8Q.@VbbH=XF(K8:6R5EOTZ;F3VKP2I0>>_TD6ZVKM7cN<EQMTPL3.5e:M0<K
;QKGU;PLUQ87;X4+H^7V:,?/?R3:9F5,65MN=c\);L&V][]&+ZW/F/7N84feTDD+
a.CK/TJY.MVL4#aE:@CE@gGO(<K)M\^]R[@&.Ee5+bIYTO=,@T6]->UT7/V.24P[
aHT;QEf22>4EN9bdbPB;F&Z@b\<dZV\6EODE#=+2^3\?89?Ob#CG9D:YV<QTZEDE
1YJ,=ND5+bM?M;=BP+M2gSYFUS,Q/Z4fIP7.&4;000BZHae)CN<YDB(G4d;.E-??
(^1;]D?3]X)NKf\YJUOb.Q1M2.G[UND7R)+&PPMOaRG8;.P,<+QO:&dc/IX8<daf
3SdYA0=?O<K<.U+IW.3:a@.G(Y@R>aQbC;g=bN9M./<12AFJ1#9NVFO:5E=P-)<?
C9W?HL-KUEES&RKGO;B8R=dH[e,=6ECP5e+XMP?^f-<1H$
`endprotected

endfunction
// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
F1E;UP:+5\7@Q8+HI20?Jg23E0/D)Z:Gb4MG9fXQ9(C1P5b8_0&g,(W5D)a=&@#E
Qe/CQ83>/?FUYFML8AeS<20YCdca]_(7KgMJ_<A8:41,1Ye@VT+YOI?-6J1ZJA-X
Q7>,3#\I(NgZ)^9FMI#JNa?@1aCSE/(3+Y;/BGNP5\>;3+UP_:[QTAbf>8.,QgfP
M&BG@Z(MQbU&:9.[(+5<^COc]20;e3;RU+5QY[^dE/YMgXB,Va@OZFDbXYWaS1XR
AWDF2[<]E_VaY7TZF>0@YE>=.Y]b#P./NRfSF4Y;5S03,44\._8N6g_S:Cb,&6?U
MQ)S)A(:V.dG,EZKH35BJRD?5K8&E=@;<AE37dSV,&4Y:E&I59/D;/)50gAX&cQ=
=M-(_BI]VNbfAZ]][-5N+J6[0GFJBcJ)BA.7Xg/(^2c\3&eQZA)He(]eQT,+4?28
R)X.O5]87Ue\/Z^CX6:7<f9UMGO+A0>;L?&[\[K+-C-)0U,&/;KD#NLC+/34c]6e
?gZ1VPbT#T)87INR\[=E8TM[XPDA+N7gXCfLJOHG&&E;8aaWRAeU?:9f3c]>KU:V
Sa;3FFHUF\@R)I\NLX7U:ZT/N#3dO@NG?]>:&RN7+LaFH1f[>?TcR4/2@6B#)J_>
@8SHg:O)HS#0OVf#V[cJC)Cb32f-S-dcc+412)=FQXGK<Wfb)Y<Z?^8KL9Xa1X7D
6Y89]JE<TW3VB/TDXeU-\=7,(05+M&gJ,@gI@XLeUW^(CY0eI)D+Nc_0_#f6IIHS
f;&g4FA=WUGH<20#UC(?b+T;7NAADWK20_dGK9O8fA#1XR?B>AZ^Z.T(D263/G@F
#aI,GUPZc+H9]fa[4ObSg(VCc>/>T=V\#b=g.66BAf/R,DK:X+TNe_A4]C\O[U5<
3DR4-YC]1E1.U@)-(JdHa7S0R[,(FCK3I9/^97UDV>-(\GR<ZU=]BB2<D4eB.1Vc
J)6fL.&;07)(,=eM3]]/9#5W=Q-]ACCJCd;f7R?dR)&(D$
`endprotected


`protected
8@JUPe-4bK+BEdb19LbgC^1A(g;#\0\O@=]H]P4?V.3cZXHUA@WS-)-eJgP_1fF(
KGN-H.E)B<bB,$
`endprotected

//vcs_vip_protect
`protected
[B@;(U3PA)6bW;I.DRN],g8Jc-URB0LV_-K>AeI\.d^WLQ_3f7Q.1(47N=]]@2\-
JDXO4HUC+<\Z57[,GW1LAR/6F^8Eb;S/=PSC5f,<DUSJ@[ZKX/<B=XU&TRS&?[LY
TTf,dH7BWW2(/E)2UVS1G03Oe2&cQHdcC/B^:T]6#OB)]LSGRg]O/aZ4>?[cc9Kd
7.g5,>JGYF/(8R5aJY8(UaWcY80TD&/@UXUaW&#Wd_F.NZ]<5?R35ZWI1Y@V3<N_
X&F#JKFEGOKfDEF[NXR9b.AXK[7+#+8ZF<c&6UDVASgcR[eOIW+@D<X#EgO/F+0R
4f6Z;a\-3-_33#3a)]L\NUJNL.148(9V@,@.4CcZ?P]ZH]I8d>QVSE0KM&LR8f/1
9.d<N7&MLg:)e2_A8A@IK-)N9OPH];W4:dKKcS?]JMOZIF-B67g03032.H]-+]>-
D?#=TV5T5&/2^b+XS]4HX(-Gc?_[A0M53/:X#Dd;O@??=C?bA;Q.3baTZAbID22M
;c.L7JXe3+(-4.P-_Xe<B\Lg;>#[?1^a=,A^6WZ92@.Ae2IQ+V^X+^4&&=ORO3[S
Q-ca&60QQeTfLb>=RVfT&,a8+K94X2@,DL2-M(cQEXA38ccH9P2PWg,7Yb.eNe4^
X.DfXE9M;-[>@)cV8X6+a95GFW,45e:?gG-NTQW;f1EGU1g&6g<af(f[UN,-C&F_
1H12U5NNI/<YZW2.Q=03N;Zc^]6K.>8#JAe@=ggHgY4Z2a9J=KXK2JWZYTH:_</=
4[gJU>?1b+EK8Ra\87=.[9:BMG<O960L?@@Y\M+OSP]]B(dNSF3)\&3&=4M5dRBT
U5TRQ)OdA0[9I>L-LY]J0]1\DK_743/-g5)KMG5\abMT3WD-b&^4T)..+1#A8d@>
?::SQKCW\[eB3#BN&-cH\R6569W(H-X]<_1U/N2f:7R1K+,[Y([O06N?.@1//c[A
HRNG_;=]#8J+VT(M2Z24F?aN<8.RV<f?XUeJQAbdOXd=ZFL[V@[;C^aJ_2aR=d]W
:-8d&COQ,(fE(40ZWD2LGR?Q;VE&DB_,.5MMG.^^If-YRfBD9].(L]:/>K976FH_
Bf/1=TB85YdR4fd(OZYNYgV,_7@M_B1<Xgf\@JADQ]8Z<QFA0]K[fWG>NVY]90Ic
R+cMKG-[8c84_U?CLMHFQ&Ne\G1c@<JL^Te6X7b7gAXR;BO4e5CNA/a1I\<T3b^P
#W@^B89Pg:MP@W@-gP?GOgK,Fa\>>XR</H=RdV-A.A5;:9;A4?TQQ+g:WeW>CQ)D
VC,ENGMCGJO3[>O;<0DD]gK-XK;GMQC3FSW-bVYC-BQ35:&X(OBR+R:b1BA#C^I8
Wa(8bM:>#@4g>Z_\.>ae;=Q.T0;-+D(8cPIXRB+,GY03^.?d:-N_?KaPNgKY8eN3
1SeKU.HgTcUae=L_ea4ZON[I#f9DL2,659H)#N&fabQR&@J;P6X&&c^bRTMS0<HV
LR?R^;4,6QJF9H69Xe_PXK6>9LY=M:dc0YLA#SRI<;X3QP[DPPVF;94J;3\D>#1Z
9<XObP\]XX]S5/I5QFEG)e]AH+2TFY&MbU+=Z@@2-@1Ke-VE5f56HFYUYRE]6047
0a4XSQ3[eW,@NX[A,RY2B>/]QcO1G<CF?D-R]]R(Z7X/D\03<O0f2>e74YDO.;&g
H2,-XP>=]g27\a32@;&34=U[_A2-D/NBc+RJX4EUS)C5gM1_B?Dg\2_J)8W4I(=+
:)^Q3(XB=O\K:<Rd8R@[74C>LGT?O4O09ccK,?GBa6f>g58=R+G+=d>cTQ3N?SA4
P@\KO4X&\_IVdI.SI(/8_85XR.OHYSBII3fVKS=4E+bEC\Q75#0+2RTC4RM\<+@1
>1UTAC#O2<@>QC#DY,<^_2?34\:+g@d/1164K?NTFbX88B&B\G,Z,0E2N3L>.)S]
e6T[KRFVA6AgHUV2\BcZc8HAI+I3J_SGEPL1U__6\A1_8PeNHEUK,,=LF3Q;N?cT
FNR=a_J_KS2,6KBa5MUM#Pf/aLG^HH#4T1>TOg@WcJc\HHCDQREP(+IbL\TUFaHX
GRJJY\?a@J_,e^cE,O7+gG6/A<A\CIS57GJZ9ZcZbLI-b:99Bd,1D@aVf:1LNONU
QDZ3W-V]Td:Ab36^,,9G_@3TUT9+,WLD8X#2D8g;d7.;^,L4F7RKG7^b_D+>QP7.
RTO_:\XEH;XMR)3aH;BP&PcY.b;7L2@Z:G\DX)cE>MG(MK3J;89UO,UHR\6^K/IV
WC0e]UFbOQ<?Y1M6,<XB#S=bEUA6aM>79?,#Y\P^Tf\FF=fBY@Y?>D.bQLd4<@&^
K(-:F.=X\?CGa],:56\NJRU:4V9072=_,fY5a@a4LN>998eW9FE7/(64E(S=2gXA
VG>61E.D)30DEe3XN-c_@]B<SAWW5:0I\EAA\KPc(>G;fW>CS+B\-@]JR)DXJJP^
EGB\<(3dZeRJR-H<,@J(SdGMTRc76U6_KPV+6@5ZMP_C.@/^RI\b8@D=KNGGCYc1
SPW-L=PeCR<QUA>V2SSQ;L@R0)(FIK?cI7Q#K(-&+>=-F#N8>L_0Sc#2L]R49XJ0
d:2A9KLXMP.)0BB-Y2_VA3Taa;1NKUGfKc&>#[\2I)BJ9211:FEPIb@?aB3A&>_.
aV_gB7HD;bZ][?/c^6W+J^._HDI8/IW<-K,_>Ld[D:<_DI1gU30P/a91WU/F0[Q9
/B>]OP;Y&:ff]f_LHU_HN9efLS:8)SZN4g,:U8;,ZKBQX2eT;XRO.8HS71=a4];a
.P9+I5B;e&d1Y/<>3J1aZ?J0VacU+(OeR+&Z7^]XZ1/=<^.6V8RefU2^6L4M3I):
KO-GHd3,6I-fX>6PAcCEAWF(@\<.>CCIJ@]H=TTQI399?.GFdB)[9AI\f30;IG1f
)feCM<RbD&ZO+0[b&Q/,[Y<L4UbZS,RE96O/-2[XD;_\XAJVW^(ZCg5.M9ZRQ8/T
;]/((.KLIH8)]GXa3[2F;?XGPK+DAU(AO_..5^[T5/EL+(N4P/D]PGb5TcVQV>P(
J9AV>.;9f5A4?L)]MZ_:HcR(C36)TW15V]N-[^_4DQ37R5dBTW-WT^]<NI#D?\PN
>;6@NIfVPM?gK]NC<,HYOW5^e3fAT8+K2bE4a5_(bcANU-L4YJN=S<g>_NX?)6U\
Y)LBccZce35CM<BV2YWDNg7QD@C<&84C;UP8>PVTGT6B^MCLgWX4Vb_3KMfH[c)I
PFfE)-1._X/E0:d\52>M3,M[\;5WD]7QgC]4N-cZC(XGOHJPJ:G5FM_5c5XH9K7-
PT]3LWXcWe,;8?<3T7B1HY4I/:dNgIgB42TH@Ca\BgJOCc3gO?eF:VNd0d-QdVOY
dKdb.<\YI4KTM@@Ga\8U]+ICDESb_9)_D()cVNMAKOL8eN/)bIc=-RF8:ZD,GHf\
//2eSY<9aCL0Q)?A@S-cB9f72EZ-f>>Y^G87(0-2(=?J_/&e(Q\JED-ZT3BL(=^b
K/,Ud]aId;-R3e]]YK5a0EKX+fF^TW;bU0D.OAWTXZgZfLJT7^MI-3XABfJLPPaB
3_C7BdA,N&VdM:?39@MW)#B45>b]BQ/>Jd-58Z>J,P2BG(-^#2^N2fA7EW,)/N9Q
4-cZ]^]WMdZNANeST167FEH@^Q_33>8O_^4c1<5?<#<4^aD(_CJ^.(/0@H\94^d=
DcDIdEZ8cH@=Q48fQ)NS=b:K8;SH,:DWN>Q<Y;;;O)OH:-JG7XcZ&,Bb2/bRbSP&
_e,1aK?]2]c;@^KF)A)]R7G3S\>?.;eR4V(VBL_g10/56<9G4>;[Zd/PbV(NYYfH
_S9cAY)K[ZgV0NX;<(NdU:gC0U(&Y,fW<9M]2W8f\:C<e#c::-Ma6+g;G9LY(<Y-
@4-+_X0J_.gGd&7/T@JcA88R6T66+T4J=DOMd#+)/)9/<U\2<-[gHO&EbRD[.gR&
X;MF>)R##IYEOB,3D[;H;0+#[ABM[@@_K)T2c^ARN1UOVVBS_2DgDLV,Sf#&GW#Q
G\VR(ZWDV^b?@cXOSLYIEH(a,G3cO_6^=R/^7HA#+MH[>\#7RO:K1@)<4[@TH9.A
5DVK<g?9<De?#?8DXP++:S6)\W54fK79ID?=a:H_g>HYBE:S1,-B8_5AR,aRCGBE
aD=PcG^<>-a61\EQ<0><6(2<Z]?[9eb.MVTR-)cIC+<A;IU]V_\K>#WAd]XfC7E[
BKN(NR\?SM>8gG[TN49b6AFUGX-C.\5a&eWI#cD[(582#QTR9SMWf5@FG4N(:/a4
O/M,3-X#:GKgRSL_TV9C(XF>4I7c\ASWS#/M]1<Hd4+QNHTcPQYG/Qa5H4&I@^U\
NfB43S#D\JCMK8;U_gT@eB#.P4U7.Z)(UeES]:OPB80<<I8_#P(W)b-H:EF/A.>,
K3<@[&Vc8J?aN00Pg44e^A#.#_0U[WYQ74&U2B8;OY=5RL=KQ-#e<N?T3SQ^cB@@
VN+CTc\a?Y+.3([CK<4CRQFS.aX-E&g1.eTZf\-&dF]H-f(R0#C6CM4(AX@0Y,O(
b9DS_-\_aY&JWX))106b2V^+X2_;J\gOQ[]O2?1[[Cb^/VEYWH262^K.C@b-M00g
Da))I<=/=LDd83:.HAg4>YEB_2554a#=R)]:2_PMT_5XG><S?MK/e=OJ:9.T:B#L
ZK7QG73=-&(<>>1aKd^0UGI7QQD5,(L^IGHPg\^N36C\X9)e]#S1LIgb35(6.N(T
2(L9EaEK6\XMJ,ES^#;IN)WdPdR2,979;Je21H^JP_fA)(2^HY6ZMEJ/.83E39d1
WR:-L2\6H<Y/_G?L_WP/::&OYJC>K)3eANXBVKM/8:6<,Q--ZE;BJ;\4#I#JOJgA
eM[0:5Vb\(:a<M)SI+1::ZL@#J1KOLQE2&Z:X5]<_YO.96[I&U6[0&b\WE-U(=:I
U=3fP.O?5cM,U_fKS?d>c&a5\D3PZ2)AbUW0WE2?@;,;L>]QS/((8^^4P0cJ5Rc4
I^>E<c<N@;W:G]E>W\AQ^[=@XZ7KJ:^cQc7QKc;X)&._J,QW@bc5T&bb&eFf083C
Z[cM3;S+-0EFKW^]2H>VY/=OR\>]>fQ^O9W2H@^F;C>RX4fSG@;C@S1fI[-?PcOG
[016P@Q/d01e3dJ)CcTf2<Og&4I3QfaKAO&4GU<928C\c:OJRI+bW7f3?.>:,RcQ
0_OOI;OcX(ScUOFD;8M-a2PM:LCMX61]1>[7d4/A>EUG/1b)W@f>77<_MI^/G,=U
d<K7)ZNG68XN)RX(MQgA/7TLNM<eF3@^6A(C<&GKL2E.JZWP8AF1:Q[QX:#BM;-?
a#a>DXb:@?6aO>#+PaH1GF>49I__RA>EH/P,U&#>C]cEC9A;[eMK;2ZG#ELd.aBT
WYKG3H>=W\:&deA@3-KLHPKab@.Xd4M>5&G4Q6)O+e(7ZbL=CJ3cJVC1B0]6>Y&.
-2a.IgDBH0(eGM?&T0:HK[:_N@2CHeaL;J[KHAHF67K]Og<)WW9J#,?Kg24V=:IJ
C[\EMXAdH<U[X4+>0a@:/-KebL+9UMG5S-b0_-&=BBK_Uf;4/0&A-JPD\;,RQAEK
;A,])>_fg?L)53fP1CLQeA>=O9gS1]Ye^<S<&L-XV9S=3A/TI4:01bQAUd[Ka3<D
YAMI6)7_502TB^3@L?@@JLEab:c1cUN:@fG(7?J;P37DB9,62JHbFH]4N?4cUOK#
RM&75)>&O=.C73CeCWC[-OE5H>#FNR^?&TA9Y72C/\aD,[d6aHGW<K14A;\[?e68
?^8=^Nc[XGKOLHKE@)VZ3M9UeL/^X:\f5IU(U]9^OAWSI+7d,[ZBaORc<<V2XP@^
+O/cZ:55K01P78VEWQGPVFb=-[T(X>;=]W5Q+9]:eAg::Ac[/Bb.C=>/POJ[A@9M
:^D;JP&O83e3CLFS&#]3+EA=+8ECCA9:dS;.O9Ef6b3<bHZAIU5,0770Z)Ye7)\J
=)5Ye_PSS)6bA5c3\25[3LR;JJYCae(J_+Md7TXUQ,F]59dC-5<)XMNHOSG5(QTR
ESZSbJQ[+;)PFU\OVKL:=K]6:N;APH&/X20?1:3S()?[;TR@NX6:Q]-Q;JA].P_.
BD3@d2eXMH1a3#Ae=FY#CgEef4V6(1X,F+W\@4CL-AV>^>#e9T)R25OR2ED.bL4.
_>gD+8>G:N5fbc2V>Z;@0\OZ]g52GTa:e)3?e3CNb6.>JX,[1U63WgF)E_)S:BF>
=;LBXcRP^^^d580(=#,@S1M0)S.Gca_DR5>,LM?LQU=Z6Xd-:1@&<XTc2F6F&TWY
fE+AaG[1FCCL#4S=&-7/X,4+2?\JICP1@>DJ<2aZJ)b)X^QQ.XcD.bC4(IPg^\?D
IVW4#A.&Ld_))7VfJAW3_?IBeGE03&T<,>(aNPV3_]f@E^>=8E(IFT<S\gK2-fYK
Dg6aWNOUG,RXJ_I/V^JVTaWe>=5^<LLY<OX(@PcTP.c&E7f9=V.T8CfSK(=?]a00
>I/@&4b/&,d:MOS=IENf0eI\gZ=4T:(<Tf1?6]G6<75?eIKJ3[1:3-(P-[+D8D.^
D-T7Lb51271T13RFg>]U+#Z8ZA)DG+dWTdL5TG83UWIFR7>/3\^)V]VaP8FdS^/^
K8]V&\;;=R,6U6Z1+]dcB<Jc1X_&+-Wd.9_^D4@@T6#13YaR/RY1\D?OaEO?+]A4
]>+X552c7KKE6dV.)IGdTLBAfDYJ&1d]X@de-f#&A?QNTa7<9WMUS/)K5J?S7:f4
NMOJ10W65R)HGLU3&DS.DYHCJVaCE[.QLR?#V5:Z48FcK@(2<)R?OceL8b.1VKK.
E@^@HHVNe&U),V/9dDF,FQBE,<<]J:\:)gV6-F<Gd8?J]?/EBVb<TCeH?If6K&->
ITI\+-C4C4:@?d;]Qe[g-O;;<&9G.G5]Lf7BJ\BZE<HYdbYOd\THD3>5@d600IFW
g<VX&b#93e<;e@JM_6-CUYLd&[I@2)faO>74(&>)I/OH##]8f)UP@NcKOYa3@##_
RDQHYQdY9^F-fO?O.Za].Af3N09)[\97Z;W(C#T6RO1K#DC_)L:3(QII:UZ1dDFD
bN638<gZVJ#.(1,LfUa=W9Sa:F=bW5F@O=4L2_JK)N351852>f<:/ZMBY>9:c2].
DXdF[ZT&Q42\DJ&MO7#_WO2d?6gZLN:&XVg>QB\>@DbL[+TXU_LH2OP53C^+7.bB
.YX?^cDd:F.P+\<0W@,C@ZYU[VX)D<:UI4U,8_F^0:VE=2]EHN9,g1L/DWO+ETJP
ES2bA:YCY(&U<A^W[VQXRP;J:6_#>PK0:)R-_H@UNf6;.b3bQJG8g8aK:)5<OHH0
-LcWGZ<-4bVc^GbGJ#S5787c]fCb)U^YSUYcTG^B(6K?T217A@KHS#C7L)Wa?b_Y
#8WS0fM\M&OU.1[#M+YSe6QV.5YQcebW(QD+QKc;.+F=4&T,)HAN?GFM/D@DVRL(
GaPGB,2Z<?.&GLcKQM#?:?_-Lec;g@b+[IOZ;&O\b22If\EQRR(HH/aCDVW,GK:9
I.DCM[IPAG@T,G?0gL\?PFR^eC<VG-_+Z,KU^;5..<fe>[#>:,A;,BN-f#L9O\(?
M6;]\b8C0deW0W#1[#e_A--3NUf6MR1L==[8P>J:&^VH;eJ];P._H6D;N\Q],&f.
P+&0G5BIbBbd6O9f\&+A^8KSR^PcPPMa=gC2&V)-b#A,-B8E[UHRT/RD.5#M\aG&
UE7.6WRA)5;4^B@RGG&M>AN79E+aVH36VB@S]SdQY2;@[O[-;AbdEC@/UH(W<Y^4
+MR>Z:dGB9J)]3=F?5#OO2[//W5S)0^HK2^,[@ScV]A@0g^?Y2)IH16Oe-b8HY+F
GDY5N=26d9a0IAA/K8-T\Y5PQS;?DGUIRCDI&6aOa<?XBEOLeV?8.2M/MF<-[LbL
#4)25=<I.7KIBV)0R.NQ<BKcPVS:c0Z+?T2fC-Z/d6=4M9E0>3YO0Z,Wfb4E[,gV
BGX2XI^R)QS).IIL+3aUZAAAEVD9<=4eMYMbX@>0?g+5H3_J<;(A(.VcRRd9(_W/
0[6P=L^[cLWDX4PVG;6@KA-8YJPQg51CHO<9daUX2Z7.O9;ZF3]@D114XT=CPZ,I
0-5I&KP7]\W/RPE[I\:<+)O&UDWO,_C_JYW0J4a_D#g&@F9.J&d^_YDD\HU?P,aA
W=M^a9GVd\.^GPb0gTRSUM:;8gfJ,C<#c2A4c\d-F-7Feg^UGWdV9SXH-[a;Ec=O
(NIPFa,_\=95[/]RWV2/bc4FdIA#VBZa&E;bX[(GA9BYMVMS@02dRQ,9;#0ZOX[1
A4G2YJ6&FMK70EK?MA8d_,S&P]NLB)[,_3B#]3C-7;,b;f:e_V/d72-?g_.1AS7H
bWSO+SgOB>3(gDR(+3_;-./#KH#9GP?g08Hc]620SZe)Cd>d@A)DV&E9TYI,H)WW
KF\;H6NQ^.>O+CVIC8T&;+J09(MIRM&V<)L100BEXS++HdOfa-E9aD4&^&,]0@fE
FRdXMgOcS?e<34D+IO1:^4,G&N)>9A+574F^X897f5C+6Q;?<#7Hf.Vb(A1>BbD#
VK@^:8DdG+47aR;3S?110KR9fc_K_SKg;>2bY9f6?dA2PX0B/.U.,B.dH@II4>X<
X\96c1XF/2;d9L(>HQDS9[dc-OB0b=UZT[U2M>;QR@2;b2.OW)/XMM3AVbZ&<RWO
>^XS\e&aY)ZGCD9DYKgN0R&?+#S4P]UWS:__3(-^&@g393DGG2/S7EG<77VE8YIY
]1KcP33:)0JG=R6?<>a^BYRTDJRcEQ#f4S0HUB6BFGX=:=\YMM8FL:M)&GL,J):L
UfR)&,@2D>g90/OdFJ@NV_UW+[.1+V3fa_QeWT;bLPAO=;O@85XUGN&#2^.=.B_8
CCQ/RX09KE[H;5G2EXfB@SQEXf9^GI8<3)?_ZTO_CPJ8bW@e:Jg?9&LDC6GM^^gU
O@-J]795/dBS=Q9NP=PdUE/R^>F#8RW)?#dL0[^EXJZ)#1T8))1N4d,[=,gF:?0F
OW^S\EPRYNQ,O\SY^f#BK>G>3\,fC1Wea51P?:<=eT/DR:5X19(MbFJCdXA,ED2\
+@&3\P[R,gC9H4Q.AYf-J3]-[LHgL(RD>8=fG_P4,U+>W_3d5dP(WK>K6^;WZDb4
O1b-8I9f;eJ9ARW22Og]4BW#:^-/=QfH+E/H^Q&VMeR).)JKRRE[_NYY.07T7HEW
KP70;617IG/#,AH_#:(-3,DI9)076SMHYFE(PG^Mf-TOC/egT,HH(LI9N;+gS--U
[AXC-c?gA6dA0KJYP]K886(;;WNgN&[14O)/OFZRA71=dA^d+3RQ[\=#_GGJ<[KX
==A:5?S[EEMOZ843PX,B/9YJ1(fDd?B.L+[Y:/0\L^@O6XVXP@(,_J,OZ18U0J-J
7^2V;D7d/0V@3K:fN):0-LW]CSE.#9)T\PY:G+=OLfOTc.BX+NO9M_CK#E4CPU2d
f]A(A8#J#G\JQE+7d^@JfZVXb2f0#,NI7@V&T#8R480O4LLZbI;^/Sb9&Vc=IaA;
O+&C2RWV^SSFfD,.Nb\6#86/gHNbGJ6MWKMQ?0(JU9ZG<#LD1I3P_32YP-g,VHg6
6((7cSd_f<>NF.X)(U.(g3\?f4Qg-I#((U:Z@80>eB52aTP@.(d])F#U@HbITV],
.XB);AfTSPH0,ZVfGFMG>Y9gfTFd@]],L7G9fA].AD.Y7-OW?N(6=9J@QK]VH:CO
)RGOZ,ea4B5L7L1CQ4AY^#0PRM-JgQQ78Zg;N9#UC8Ig^#O+XdcI<a:\TB;bNb+g
a&:SGWKM^UQ]a@b\#B+.M\E5T@+SdC=_=5Rb#N=T/^g&5O)./>a>#6B_+Q:)K/=b
-]/1&HD:7d\5/T)AS(WM1Q:[#[U[f)0R_7O913\AAKSLeCM#/RgDK=T;UP;)T24=
ST1A3Z/P_/T.2gDdTP]]9P9f^+HeLL+O+91U6FY]YK\GL?<e_OD?=HR]_0\2I>3I
5S:OM)Q@:[DYZ8ZQX1cRC20>d;U:K<W85M?T]+^8JK10^a_6W_[bCKP1QBEfRfS7
&fX9bR8a<?d+C[N7D:OT]2OU4WS:I08O4Y4QP&DI59=S@65W)/\W(-P9+bbf3\SG
fXQAS<,@dB+>ZPF)SX9D0]&J-\;44A?.88F#B/);0O=9IVQT[&##&QEf0I;U129U
bGAV?EX?XB8OF+b\9X4EPcU]F+5Le((91a4Y+#C9:U(NYCbIOd0)KTGI.aR]_J8f
^)ULB^SN8S/3a\K]Sf3#QDFZc.4MHN-.,/VcLAFBLD=A9497cM[1Y>MT\568SIFH
,6.],O:a[I6);[aDPUG\>_L_]IV[[Pg>FY/@Z)3IR?_,S)S+_eWaBC]HK3.e8,FH
G6Y25A?@UKTCQWOL17gG[8I(7.\-W\CeUTMJ,<]M[dbLJ^G?2<27OW[TR0,eP@T3
N=]]8JaSSdEe&Pf4g\Dbe)T0IPHHd128[bL?)^H>Q=MZ0NSQC2X_f9F2F(JXE-aS
M]=>@D=F>>/-80=f7T?K1aL/cW:YXST.<b)D4&Z=[^5XeT:8E-gVHZ38d:\26CIR
&YF1VeW05aYZKL_(7JSC=aF-a(WeN.(UeA2Jf^_U9:#OVR=d\cQVQ/4B=<0I/+>g
,E,P4>Ld0Ifd(VJb-_.?Ygfc[O21O<#F]ALbY&ANaK\;&Sb6OYVEE@Cb@1g;cSV(
eYa@,d?Ka)VM:fDK)O_-CN1HeG-+)CZ,Pa.=#/01XPG940LSX]6RM4+IKZX;^7=I
S0GY_\N=;agKK)10_[&@/A2>4U0-.REJ17H9.WKMWbZeJ):dB?(GA6b+5T4E/IC.
R9_fgB5?7W9TgT&Kc<OfgCVRR#NV4UT<g@&CG(8ZR]:5KeNYT;<,AR\#JD2O8<-C
b9@A#7N,2A?GVc&YY8\J\#0[E[E=)M\YgQJF1S/g=bD+156VVd4/TN2&=_N@/=>+
]Ca]Z\Wb85I6W<8<&5N:CN3,<<(SN=eLXg8DZ;X_3W+eUE^f7RgF:A^@#-3(JXQS
fR8JF\CRO-93e)LX:EM:CXFEOPXQ;G>g0UY#XeU.W@;>=/8a_ZX=\)7K&+eO8&?W
0+aK<DVSM[FHDJM1Xg[?CBY_=2ReN-]<=a<<]9>G9T>+6ScJ>@91g1-V_D#PM9D?
5_11?I]cTbKL6R5-UKH\HV>Nc_>)>,[)RB<?C4,0[0#7dGH;Wd?O/b@,D6QbHccF
(>NG?fZ6Z.R0&IC7#ZWb(\?:66Gg-Q2(GGC9)&7JX:L:6?H@+KRfRHIUWYFE-ecG
gLJOTC2(5@c^\VgZ@)G@N96-ZWL,EeV8?eR[c&76<71;VCPN()P[gW?)VW3H^S;B
?]L5_&^V)AJb?F2JeQH8X2PZ\SBX7;Y74SFQ4,EY)84R?\0X]6\L\D:,ERe)8NFc
E=a3TW3M[2&[<PJ/SST.C-]T;IM0)GeF?4<fL;5-9-WYgAU#LHV:U6fcA>@abYIB
Q;AVY&S>YR,e68NNMd1,<\W&8>FVI131)A&YWb#OX7I]J#[3?3bbSVSN>cR.YYEV
TY[D6@OL[bgVW)N63TW/d.W<E_?#fV&DC_CAJ>#aUYcA\K_K8L-a2Q#f@,55+E.[
d_^#WECQHcJIL&#:J8(;.c]-4UP#-Kd@9>,S-Ha_@6JKF_g^eP?PB._9(bL>B/(V
8PR=bOAGF>;TW[PI@W^2aQXbPa_JI@>W<OC]U#AC(bDaNGC-_?Ve/FSPP#PC<5>7
G,0Y,eR0V.SLARK+fbN6=9g\>0O]e)Of3cQ/TQC_H.c1;O#T-/T#:&H\@FBEIR\6
\S-A.WUS]_1e#HSRQ941bQ<AC)1I#;Q2]WL.5JN#KE7f]O915\_<dVRM1&/\9/<Y
\I&.2TJXYgd1HZ4L7#<aS3AU0@(U>G0UG.1<Tg9C98[gN):KQJUYJ-=[\L0;@3.e
5RZG3WMfBM>;NYR>5U9C4DB=0Z@&-UKNa]75H)R0@aW@;QP>LFN^1IN=f(aHT(HU
,F:IS0[PSBG(KJ:L?,),H1aWW<,bPeL70T)4dF8JLKQH^Me;L0e.#[:bMSB.==<;
I2-&NJ/e/[cCH@W^(+EHXd#TUT_Y1[DCH2L3@[Q.]Q0fX8T\^e71VL-Za4Q4fVX(
#0@O+WT\4[QfPES>M1GLZ[a\OaQ^[7T0N]>^@N?V)ENc,_VgVH1N.F.c-VQ/c3&+
2;P.Fbc+McJ)SF?9]AL&>>Q?,bIQW_3-173+^bKbOAfX3S8G(#W^c\3e<V]_?e?C
#5ZL(&Q_\I+Y_TJPf\@W91N@C-/IUM\T4E=/Za&\g.SP&SY.QO:)d6X_3H,_(4?4
9cWE2b-UYaHZ56]U2XPXf:0N=UN8Ba#BgeMF96W?#(DA</=8\P]5EUH-C/]?V1T?
<ES1A;XP8,Lc=[;I;Y,fb4C&B4bY;E7aMKGHcH([=D#(Y7LCBL(UcIKJ-2X]aFFg
LQ=eVV09SCXOSR9K.eT]>M?Lf.2,5;faC,6e[K#\&-.&M,CD;8c/_16ZX8d]=cG&
Ld[Y#XA.I36#Ae2Be-C].8HBWD.,[+=5<d^]67&4T9PcRQ[1]Z8aES?JGO&&Z3dY
d\OGX?;QSAHHQ69DY[?\+XY[(\PP/+BFbQ?PVT.K&+EeG.g^;Gd:dAg63^Off0cb
eS7D2[?(_2M2021R<O3N6EE-CR3,PaXJ5<e:GO.+&Z4U\O3_YLFGgfX<7-M4U@_Q
Ga<9^WS/5DS9H[aYH+Q=;B-&6.0cgQX-9QG[#07SXdQ9IcOMF4;3:ZV>TKAF0QDQ
HXV4Y>HKKTD?WAQ;LY\H3I@N#WQ(:O631KMCe;7HK/,,Cc_]^:#-WLHZD3M?I)1N
(d=5/Z<@5V:C+/W6QeB:7M\G6eSN/:cf<A,dWF^8UQDLE+6@]7g^J#-=JSE:^-H<
cY_(^585&&SO<@QBaCcF#HaX(]H2[/6+e=^dbg\/A7B]L77\XeZE.aa)RUN:e<U2
cLT,XMBeAR=D4gg]]&FZ:)LXc7SIOU_EM&UW)G<9L&YbT23W5^9PNAQK,;fNK8WQ
6+BF&+DJEXA)(+BWdM[;F5P404,Sa]]W3/9(TZPeZ7U^S\gOQU>IOTV-?7&c_5BW
=^8D^YD[\>-=b1-bbgIK6=.E<^1/._29>0OF4N0CCR\g5N5;,_34P/<cJ(?O[X?g
G<CI/GAFa^M:3J90H(44V_HgcZQGOW4OfO:U++>C:gbg_)/5=P<6#ATZ,XBR,<+O
7_<G@3VfL8I.d\<61<T@^;a[2&H4TH8N0(<ScFEU?B&7.D=g]3;YD.E(26_Mc6Dg
1VO_IK(\PU@9D@C=(5UQ)6O<c)@DWQM:VYOdF2NM7eP+9fRgcB\?AR._NE5#;;OM
ZR<N/SK&)CCURSCg,\NgMG=3J4:fRe[g+(3^_@2:5XC<;b-eg&)_a8Gfd)#MdXfX
&5f_]\PHIT4Yc1U2;-_2IV]_d-H8Q=Q-/.?DSWA1>O7;CA^c/]ddYWO<K]A_)D5>
II?JP>,NS=@-]g+CU56gOJQ[>dCHg1_L])Kb753Z(4)#AgfLU4P/@bJQceWc_MO(
5c<A6G@FYPB6V/bJ_=+#[E@-(#:c_#<V4G0cc^R^A)E7#?TB\_R:\]/Q0.&[Tc@-
):e2E[83eU<2@U)>F2MG6<6e8KI6g6_5D^)<6J\@9K>^>gQ]=aeSdGL9N:2Z<]Y0
bFb[:>]Yg<?@>/2..([-<:9fXH+65L#UKH8/IBE^R-)D[5HRc(00;.T;_,Cg:[?H
eL+8Cg7+:7PZDI_2,[IX2O&K.dH/dU@g#6BRS\adAIV&\SY.:3-#=eAFLLU^D2d?
WR[&/_5Id7YT9S4@;X7-3]e&>.cB<J\H+:GCKC2Z7aUI8I)W>?f+VXLeL,.HbEH2
ROMT=])66&@T>+&H3]Kc5.V<M=)0ZL6LXJ/BB5@)ST(IF$
`endprotected


`protected
eG9=ZH27PcQaY@+BB5f94D4?08H8<dVDB2&8gf3,Q+W(XJ#2VdW:6)N+1EZ&TU66
P7F3\./MHg2a.$
`endprotected
    

//vcs_vip_protect
`protected
C_HX1QBWb/CE9fHQb)JGde>QFbH^bcJECgf6f(SDF5[[P7RLfe#94(U:PBW[R#T1
Zee^&^g]b8Y,>HV@Nb/Ud[E/I[&@9U(K<M226M7D+(.MXV+.-\13fYEG\+B_eV\I
gSE7KKZ6N&X&SJ.:_B&O6S6@\ZWF@H<&4.HE+[O)&CVV/ODRUXM#fc,J.0L;@OUX
^0/.GGFS3JHW-?ZR)I=eY9EAO2dMXJ?M5^41X?52JV?]RSQ>ZF1&+gfGIP\89G)6
#INNC33KU<CH4DE980+MCJ.#AR&CVH\E?>Y=Q9X:F\:c^bWaWX#0FfP=07KN5@JT
Ge7T3]+E3MV_KELC22#a82,>?FBJ=S[b?G1^Kf&X4MFN1RWDTOebBZL,EF7Q9SZB
CGD?04H[YF[U,AB9M/U\>6UPRKJ,WY^2)=H0X]UO)-I17e8G:SJaO>4/5#PR/EG=
d-X?)X,<JEQ84-4B6G0):4eUXC)H[YUT(QX#d,M72&dOZdIFS<gOAa#-82LLbH2f
Y3aJJf=ZX7[5c4^?LEB3W9LXVg1WDZ:AdN#&Zb^a<?S(C.LAB)Y(>c88(6R_.fSQ
+1.L)B^>SK):f4(3B4,VGF,46K..^<+&DT^7Kd]U)DG^E390W7.E<QN#)_V,Y74f
=-d-D2,\#U+H+7Q&<C:BJ\7;R<f>V<JAD;44@d>bg:UIG58BdM82AJ0O\P9?UP:-
(6(U(?cRSZKE950g<6;/FYPA#.^<ZCC;XJM.fR9_OE;NXVA15N,6-A^B3@dUZ119
g#M2TUG1:]A;A&B?KPNf?).P^>VL]?1DB5/W#N5F&Y,f7g:YNZY=A)F7[0^=OQKV
AaRJSGY0\5;&K7D2@VNU<d#I4faUag0<MX+C:0_GQL8fXFaLSTLL;7(9?2Z,G9YT
>D\gM)2L[f\SL;9B3<G_B.TJ/GJ>JfPCHQU4V#85OFG-X/d0;J2fDB0P]-EAN(dG
C)8HX6\f.gZ7[GK]#.SY,>47>_;DabXfI036Qa],>#d0PVE2&Z&./4/&aFYQ>EPK
CSBGBG[=aR0)5.SW7TCA4b;@:PPJ3M5G?TdLLUV]<D:UOUXfOVIS:K4Cg.b\LMaT
^9MT_FT&Mb7)P@\F>F:7#<+VGHZY^V^=I]U&X1)Z9S.[Ld5+.G]#LQFCEK/N^/CF
Ub^>ZYQ,Cd;c19LQ+=39_GX>D:YICGO)bdQ=b=H]b;LL^AP@/d#f]SY\8d;(d3/b
RDIK<=+S8XI>/J.adEOW6);H_X74ePA@(e48,[;X-C_XHe8G18;eSG^f(9(,T-4J
4^YE0M4+>K?.8A)Ye>3#@Sa.4\@60+@OC[:5XJ8(,1.#<AV)TEKd:]]FV;Sb..S,
T>&[5caA:@1[W4;HCJ^U?S](RQU]#2IFcNK^+b;Ie614b5)J]?bCb5U/1g,fG7W+
)TEDK,U&TgN872^0G:(KDM^(F@gd[JM:=g=9If(P?gKdN:SIcU.JFO,-#]F:R.cO
WO5cBJTBCe?^MZ3<<OM@=TGMD8d&+g8F[[HH[;\?PK8N;A#]]db0F2e4>0afVNP<
8G2(A(&&>5c@e@/e>(TE+]PF9ZRB^&&fH-ZKJF<;JCe^^/4<3<-2=>Q5c214Ze6L
[(Rd=f?c8Hc\cJTF+c>bRcec&\Ub-Q.:&3K/]185A^T10&?c[0_]3aZ(N_UK8O:Q
54GGT,#:1DP]a\AXO5]@Yg0.cI5IF+<5-68#BaN;d/c/9>BC>I@5K8JgSRLa.J+1
465VDO^[X<U1O0#ZbfA[\fZ5U9&S_H0)Q,2^.#Ig3HE#8>MFV<.eQJ&bg^DG?4M&
F93\Xb]ReG8;Ug;cggUAd0.R&K.[.\dU<1X/>:^X[e=fDG2<<NcZ[L#=Q/J^=ea0
Sg4GE9a33g(b70V8PfM,?@/d+aZ;SEJHF)B7?;J(ZTQT>>Z)W+_#E,UFR8U^#^aO
eMS@\aCMN@b-a._84bUO6<7RN/(WW09>#P+V,B?Z_Q5afZSX2_;<cc18L]#E-<L/
:=#bBU&^/PWG+V=QRW28M9EY>,GJZYQ1Z2AT8,L5(^P2PT/3=T3Q:A@\QB>W8#)Z
&&R(L386=?dc7aRd>0a-1N3d;4,RN-SZ2W3WddH#2VC7@.dP2Mf56.:V^XEN>XGZ
OWYFG01&N7U-]@#W14^(#N2A+T84@TSZO73J/1^AJ.NG<7b^^-ZP5Y[;c9;Z6d[6
Y#H5GV>C14=-(X(V_Q?d]QF<4.KH5[9D[,d(WRPa0b),)X4YE&>K2/Q?]c=J^a6(
G<9MT-MbN70BUa)1GN\F6575aQEf19PG/aC<_(Nf>J+dI_bHQ.1+X3aCgU.g,[W3
9AIMcF+bb[9L1O19#;#@DW>I6K:@FPNN<$
`endprotected

  
function void svt_apb_master_transaction::pre_randomize ();

`protected
C&ZGb:IEE]@24&F]+FTKI>MN;Ob=_?S+CP-YPCeFNL1HS.1@>96;-)RIH<05@#FY
\L<3M1A;N\/.OaQ<M2G8-M4Hb:Z]bBWV[Md(&bb?+P.W9_&E_J8SX<2W1b-Z/ca;
Q&6UCC8VdL@UZ<PcH/FF4abM>4/c]f15Z::70)#.0#_J5QO3G6faLC&A.&(HIJ_Z
MY81;QJa[,M-bZDPMZd@RU4:LAfbT@e=X6=RMB4@^:&[M_bN+4\:LN<N4@5T(D-5
IeDc\KZeSBMdUGS-S<>7-YM]2S8.OH(eU43)I7I?UO(>&15\cH7\ETgb9056+0bZW$
`endprotected

  
endfunction: pre_randomize
`protected
B?WPgb5DS]AAFMF?H&&]c-6PQPM90S-c+4B&1@9H_0[Z90,c,^J=/)_H?#aIITgX
^RfBCKO.DVO^^OFVRK/FNGZ5PDPVd>07Y.-3P=eIgN9>M9))gQ<W@347UB&:NE/R
PP9)B&1(BPVOUKP\AbI)ef4T5@bWF)M#g&C)T@6Y5(7K,XVCV24+NM5G;1)Sf@g>
KTZ3FKC4I+8ZY3[M\&JX/^]L=2^GB58&9.,:^(:UT?Ab2g[N7EIW82XD@aVe#BE8
EI16=5IY0c&Ieg3_dPdRfeUH[=Ic-bH)R97@(.A\X.#[Eg,BH3S4<,=3=^2P=c?H
8.,^I)Ze;b9JV72[^+0LeK.4L9:+GDQ\5GNOb^66#g8#a(;207g?PP5A?,5O2F&@
Q&J=NPH6ABMYb,G9[KGf+DKK/,4B6GM&eUO9KT#+fOeE>gfe3?-FW.4eAEC[Db^R
4O@ZZ-1EDSI+=;+FbT?\=5e6S534^ZTDW8Q<BgKbCLED?U2dIQ6(5,D7?D2([<B#
+MN[f<J4PP=^d7^?=71JAcR6RO1/<^^>[4/@[C,dQ2Z;E6[(??.(K?/>)-RFV9\]
S0YNDcF&O?R?gFU>?-gQ?9M@eW&&+?@CQbOUXW=YY[FE3e&]a1@D)SH)8X36d_FR
ADV.?c#J4f=]Yd[#2_\U#K<I;a,H(Hd&BUM,>e3+e?HEE$
`endprotected


`endif // GUARD_SVT_APB_MASTER_TRANSACTION_SV
