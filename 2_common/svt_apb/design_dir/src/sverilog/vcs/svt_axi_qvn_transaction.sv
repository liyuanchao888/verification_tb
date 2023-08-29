
`ifndef SVT_AXI_QVN_TRANSACTION
`define SVT_AXI_QVN_TRANSACTION

/**
 * svt_axi_qvn_transaction class is used to represent a QVN transaction 
 * received from a master component to a slave component. At the end of each
 * transaction, the slave port monitor will construct qvn request transaction class 
 * and populate them. 
 */
class svt_axi_qvn_transaction extends svt_axi_slave_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_qvn_transaction)
  local static vmm_log shared_log = new("svt_axi_qvn_transaction", "class" );
`endif
 
  /**
    @grouphdr qvn_parameters Generic QVN configuration parameters
    This group contains generic QVN attributes which are used for QVN transactions
    */

  /**
    @grouphdr qvn_delays QVN delay configuration parameters
    This group contains attributes which are used for configuring the delays between valid and ready for QVN channels
    */


  /**
   *  Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ_ADDR      = `SVT_AXI_QVN_TRANSACTION_TYPE_READ_ADDR,
    WRITE_ADDR     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_ADDR,
    WRITE_DATA     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_DATA
  } qvn_xact_type_enum;
  
  /**
    * @groupname qvn_delays
    * Used for introducing delay between QVN token request and grant; not valid when v*awready_token_grant_mode==1
    */
  rand int unsigned valid_to_ready_token_delay;
  //rand int unsigned vwvalidvnx_to_vwready_token_delay   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  //rand int unsigned varvalidvnx_to_varready_token_delay [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];

  /**
    * @groupname qvn_parameters
    * Address VNx QoS signals
    */
  rand logic [3:0] token_req_qos;
  /*rand logic [3:0] vawqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  rand logic [3:0] varqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];*/

  /**
    * @groupname qvn_parameters
    * Represents the qvn transaction type.
    * Following are the possible transaction types:
    * - READ ADDR  : Represent a READ ADDR transaction. 
    * - WRITE ADDR : Represents a WRITE ADDR transaction.
    * - WRITE DATA : Represents a WRITE DATA transaction.
    * .
    */
  rand qvn_xact_type_enum qvn_xact_type = WRITE_ADDR;


//vcs_vip_protect
`protected
G(>?:-(UfeQ,UFWM34?b[aL_ICD-Xd=O=#L5LFA>0&^3FBC;c2@e7(WTN+c+>f\O
<Nc/IZgY@2P,?(B/9egTe&@B;YKgUN\0#+YY\KC_5>4?]RADS@7gFST4dWL^LK>7
gQ9^SV(U2R82YPdcVbRgJ4gP4+MWE3?FUeC9bPDCS<H:.LfWWFJSRg+H[VVOC1U@
XG2bFg,13BI+bKK+BEWKe2M_GI6E+c\[Hc)L:MDI]#H\Y+fSaW+Q,+45A6H>J&fW
CHDY,5f[fAdVA;=+Lf.5g0:G4X8;/@:DYITDVe36fW<6a_R1A-IDYEH+CR]/?MR?
>WJf=)bgf2BG;M26fT<7aN+LG#e@AO=+f,OF4@VLTN_)Uf;9b05<DG<9<7=PXaG.
QZ5<LX=_.0EP;88GQ)NB)D5Ia0_WgNAY]69GJRHA8Fd=TXEXI(b^Y\/bebdYB5:c
2N5=.H+MI7U1fHE#U5G7d^?3@c/U7S-&-e7>MK7f\(,P5e(1FMJ+CFU6>\]bDS/S
BAS5X]X0.02@Ua/1W?WR-@MbP2RLg:Z61(KUa4>XT26@,B5IRR9,=:,)0c/1M)Y)
Y1;>H,K+f6C;a[WR?LC8;I4FI99^)0T=)G7>Y-3+cZ/VV&\QU+JHc<>bDbd:0]&)
Ec]8OW/+J176\E<#g@Y0EM];T_U?XWP7@G^0K\6MG@cQP&KDbOV/1#8.5.SKEXEV
44TCaP3>MTS?&6/ZJ+Z(10X6K1F_67IMPJ+3O/H.Z_PO;&/?YF3<QgLd/bDb61Og
=Z3X-E5_@&@YB-Y^3?,@R+Z9V94HXaK^CHM(,Vg3-8beFIH6#+EM;-Td2O0B<Q:8
a5[ed:+[_[Rf[#/#:1/R0V@_a&2#D?12b:)F:I-7ca^4gd_1>U#3;3.D41=SI5K=
N.G_e,R3H-H#K\[c7)#03?SLefC9U2Za2e-5I6/(4)43gc+][FWeHbVS]@Xe;&;V
J@@dC5@M?#EEeNJ&0/NedKG:TS;FFKI8:fUF]B(T,f/TeGE&g7VZCB_U_-,#\#gC
G93)H\R;]b4CHf](1)2,Y3R534XSF5#]V_=2;WG3]b]A:KNe49^52CQ_5/bV5Vf&
BMXdUZ?=TGE:a=&f>,QCHBKFS1>WgNG<S;)SJH\7Q98H7,JH\9gYLUUZ]K)H#.O0
:TX+]6NOT#&VF;f[ZB?>S#JU1fJ6[JHC&>4)N.<ZUG0b6fe1&aF4CDfJJG0A/UC4
84PW4A36\J5V,$
`endprotected
   


  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_qvn_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_qvn_transaction)
    /*`svt_field_sarray_int (vawvalidvnx_to_vawready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varvalidvnx_to_varready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (vwvalidvnx_to_vwready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
    `svt_field_int (valid_to_ready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_enum (qvn_xact_type_enum, qvn_xact_type,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_int (token_req_qos,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    /*`svt_field_sarray_int (vawqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
  `svt_data_member_end(svt_axi_qvn_transaction)

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

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  
  extern function void pre_randomize ();
  extern function void post_randomize ();
  extern virtual function string display (string pfx="");
  extern virtual function void set_rand_mode (int en=0, string mode="disable_all");

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
`endif
  
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_qvn_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_qvn_transaction);
`endif
endclass


`protected
]VgTU6_DLT,bRTH;[)JRBe=(SgX9/d7)6P9c4S6XC9f>L1g>/b1e+)-SL].5TH+J
I8cZ7&e@]XC&_a<U>cGF:RVa=<M)0EdUdQdb7eI7<AeEg<VSKFcL@D[Z/Lc?QbKH
,I7]_PKAV\Zg68)9\C\V63G830(.M6Y@JIKK7c<?A6&RQdOKKb(XNG)f.7Q.[E/,
IOLg<E^X[+bN>A_@7_UER=G43d/=Qa:;a00+1R5LNV-_/)FO(165;]YM[KXfB))R
,MIP7dC3MZcI9RUXR&L(>Z+N+17_4\TNN,9?VQc?3IdP5/8-NKW8g1:GeOU^+.QJ
+P7MU,M3IAX6M26)SAT=[3FKS?MW.QR6&ZK=BAWRI,6/AVAWOf5V>deRIKEQDBgN
]#HR:IAc/TIF^Y[T1<JUU2f0M[MI0_JSgZcb3Nf/8D7cQLCA4M=)f3TDE/;S=(0M
HW]a43JV3DIM4g/EV6A;UZXKWaKRQCd&^@^^S2B4?#_U;0V89H1J-ag+3HV&ZT_V
E+cD]#La:/GC9@3J],>V=UY:c[:Y?d>\NWL]9db-PL9Y&7<(:#KK5/6HP+;Me9M^
4/97A[>SO#>K;_),S3(T-6_6;3=?0@2+=Q3YDbFS^,\7H\_(;U?#2QA,;B,/\gV-
4O[=bNMD9F&8@)8;Zb8R5KP2=029,K@6KZ^aJcg,dP#]J>.UA(3Of\^58Z_(:UcM
=&,Q2Q^^^X4g0K?2H>,S;6BB;TQU]]AJO&IWcBPLH25;.LafU_ODWe0?+=eXLU[O
E6VXK9+#G.e,:dY?BO]._)<__U+@D^&<c=/NQXIS8eQBec[e/;9#&KA9I4gAd)#?
1ED&?2fQWU2TO<Gb8NgZEfeUMKdJZH9078aT=>(IeKAgdXC:IG6>E_;S2_0,=\9Z
SM;],3cVg<cT)$
`endprotected


// vcs_vip_protect
`protected
/c;A95aL3F3XBU7f4DH)GAZc7JC<?Tg@B?\EgK;HM,7S8F8c,O\14(g8QJBW/K[I
W_,NIc)9SCNR+AV[e8Q+8Z0T\&K^QQe_(,6VA&[8NGOVL-QS7.+WR>7_EHLgcS_,
cR=G6W_LB;#W2&=UK7eafNV&>5a.\d_UGd>1;5b>;#:M^c5M(8D,-c&N?aP//]J1
A78^&^TP^-d&O5bM:QbBFIe)TU&T\2#[b41:]ZCC(9S[T39S/,/b66M:fGVP^b]#
FVfd)deC1(Lc4?Ic6Af-AR=(L9IUCN<<YgI+I7=JVN?NXCF^B6,88IC9,5GC>=gI
YXPaS:7EM,\(U#T=,))QVc]K0A]K-/51>b\6gbYbYYP93;WOCd\CNN\-:F1+(Q>^
eJA9,6PE_496#8UW3-?Z/FL\<YSVPA.[;Y;f?e:b(3c,bD&,VTR=-#?>MH;A-9d+
;A202S0S3W><],P+7Te3CRd=.URgabB/c_0>;:N>#T5G-?&Z[&X&8=g6F56V-1;K
;;#MX)RN=MO4N-8&Y2)gIA---9f;>^8N7dN]e>2XeIAR@EEe\WE/e/8BW>D#5fgO
+]L-6MgU1T:Yf[N5VJ?]RfRHGO6WGB7XXVN;9XPMb4XdXa7N,9#.BUIF)LHf)EaW
H9D]P:)Ae]IT<g&7D5R;cb7V;34cSN0(/E&Q<CKMNeZ)Wdd0[/=_caY7#=GVE2a8
0BG._<FC.Z\//39FH@X[:QSOcD-Tf.W9IYF:U,MM,.9T90.>8#M^\;8JC0XY6:8A
HP5:7M@JN8]60bGKCBY?c7^NeK:e4RUgKLD^1P4dCC,B?&OBIXQ/\U/FR,Z0N/L1
@>=/?/6JJ(f[8[T(4Q&EGfZS6MT/;cC2@HV64XS2:E>J]39.?BH9eML,(9[_<HWd
@/,VX4BUfa:?+AJT=UIc.FTB41]Ted8KX(bZ6&E_@Z>S<]NCF97NE73],T.^IMMI
4E?;#9F6116Ud_D\Zg3F(<?gI:JOUL8W3H]HA1caUSZD,OMN3_/:1DLB#,XVH.CX
:U/\T2_TgQ:LM:+ZTC-0/\7E_G-61=0=#>JBES<NL/-WF[+(.d/R),^.G&0B,PW;
E.-AfEFD.?87PA\>-U5NYSI9GBK7H->SG#YeP;5B]f5]K;g_#-8PI[8fVPS2<@f0
#H\/?e]aH+3<NZ0K-H]MF<bH#5^#JI1FW]>b_9PR--)KR&#SRVY4W3ZbIUV(S9L5
UCRR4)\<fEO>(/3C#/GR/R)WXWE3<H83+IJT:P/WI,dd/Sd52Q[GfeUc:aHgG;RV
g?+RUK)4a>.;N66:4^)4adU-,:=2G6LGDK<[S<E6_54/DHO&#HBPSGOK/LZ?XE]g
H5&Z>RGIR06OIK60>#a+bKde-,-3c;7_dHAQ+@/=PVaT^5H:.g^YOa]F>TK@QC]?
Ie9(#&0)>UQZVgG=fe6IPFP]bUAB,_=K,e8C?X66Y.D=H^UWP]AP,/E.a[ae(Q1T
>_<[,?Y2,E(QBR32PbT,^3X-3JIH,YQ4<M6;3@BB.UL_:e]^CN,O8_BSPZ7K_,EL
1]ZOdLcA+]N32VUI]U+)2g>#GWX&/E7&/AU_Rb]QQ&WKMCc+&(GHZR\J/WBZaBdb
[M;:4B>RWb>^-5_,NRCIfU3QT,eK70@MC3M:[A)97//fANJ[95JAZ@C@0Wa(,&[@
4#@NQRX.:=)[]9=/^eEWZ\c\CK<1d/&H7\WP3\eSQ.A:,I.&WIc,fcTe4>c.KD8=
@f(WB7?NND[P.]EUY&SAHV+4Z(XLa^0f/DGPfDG(5-[TgDgGNaD.QSaSccZF8]O9
05Y,J&(/IJcH_]28R0JF(EP#f/^aV=7)O5EB^Y0RQOCG/bTQRcZIG6^&9XOOE(0\
?/KHIg((:H0a2X(]VX,F[U=X&&c-\bYL)]S9V96<,YQKKNb5NBIbd(<8a5;54EMY
BRb,4c?APOdZF,8&0()d)1bKC/;,bdJA3[4?5_B&Q>,ca(O7CXVON^0O,NEaTJ82
Wc3JZC<7=/&0.Xd)a>_L+eY3N-7FVLF1LS:&RJ-Xb4fbBE@(=Y3a[+QSQ-)Z37^2
H(DI[KF1AR3\f3MQUQMQ&UHLAUQMeAd;9G2(9)S1f7Y=:P-5bO>.=:JG+1+gH9Sc
GUSM>de@e[/-E[3C.K&RVN/1fMfL:WB?71\;;4a[fb61_(,\W]GI^d+//Y[AZB9[
WL#G:CP^.BZ\C16&T<4?If>-].FTdE2K\7XA]bM08WC8W&3ZYO72HNYUX-gg0KgF
-J4#E@[M?.e9f#ULVSI)XVHSWeR5GS[;CNHUUId9A5#JcT+b9)EU8_HIc5&9T)S5
f@Z8U7-YK1?R-R^eUP@3>,<DV05f;I7U.&@WKCW4?R5U(HTKQMFgXVg_ZHG];Qd#
1A#d1g<^EJe+dGN9f&<@c-2K-c[@-d.P&HFS\ZY>+(_[gC3d0RWAQ&FT^0;=VRcE
(+TI5:[8b?JV7)FQe&H[F?:&a?KEY@20-A)UY_PBV,==/HEcgXcLW&3_NX;@OJd4
#@(VXHfD5e.?+5dFf[80e17e;I7)\<IB0J+1EM;.>R(<_Q^7[3>@(N&Td,65+L4+
ef2[;cOCdQe\#\L>UCg5CK[SU1We?<+H,44?;S-2Lf79UE.#EN?C=VL]X/ag)Z3Q
D,Bb^]?4VBCMQ@AfRF\HB6;D2I3+7SXUK?[S.UH?13cZ6g2<+I^WOZ_T83YUZbY-
+g6/HC6eV]G8a7RG93SN]A).FU)+2C,dP\RDXB(HRM-a2A3:>)#B9+-Y]aP;gEbB
VYQ@a#SDIS&1LZ67FM;#/b7[RACNO0@0RU[M[dD-)\g<YWg;:MY3CX3=CXAJ-54f
]5:GTPedPD:]0T1P/9#fCSH<BUDFR6D\41=gGD#>ZQZ;F&VZ5[PAH/VNEE4:<7,A
K7XFM8QM)6N5<fO&ICIIRd3GI-8,66BH4FG7<eOd9XS\524T8[\O@gL6STFUIWC+
F).<^#4\<DHE\HGK=21[6[08g@BgcD+BK^D(\E-X]W+E?dV\f+48?fBQQ5_=S]S4
EUT+SHPB)Z<Q^:+P8.4&+3X;U)OUERLWZPITI-OKLaR:4S,/B&daRfU5.X(dg(;B
==#D[-b;^OV3gV6\VNL3X]/JOaFBY@O]MLcO?796DG==@_C>a<ZLDbc:U&<;O9&-
WX<9IHEKDXb@/ZW6<-=?+FY:[3)JS7790/7=TJ9bST6b>?b?,9RYZ\Vc+>DFdSF-
-4GJ)C7EO\5+)0bR.NEf-:&#fVW5HMG9Mc4a4@85(_;:T=:2BP==Q0-]c>eRDg_;
/C8J@/bC+Tf&ER(4F6KJ8U/N/2B?Ie:-&fEI?BTK.KN:1+8W/MRcCE#6gE9F,WYY
UFPO#e.?689fA)GL\PR?1?D^>?)3(C5)\PV^1We>_EQ@OKK]]f6NfV+Z4,.F/)6(
5I.>DA3)&^>P-.+:.=B(LZ-QN2<3C:U:XD.4Z&bI)/2AI#[,GPf]IE?R>5]RBA_)
LFe4fH@O\<?b4a;]<bcX[abZMI;S\I]@QZ[[@WW:P-?gZG>@Y;I:Lc^,-eS@CQ->
CR&^<W)KdZd,fMBA419I)8Qg(;RBeX\4[4X&OFLU8SDOcA,UE1IO6,&AKc1Y<H[+
bR5G]/FGV3AKS3-)0_;a0<2CfI<3R?TR+U7UX87D]cJ9deP-0OO4(H6?[+YNKPR=
66I+B6W2L_8V/GGAFSa&9QeU7MOH_<5OBRRW7:XHa&4(16.EfL7)XDTC_,E;-,1O
24R;81&K?YFI2Y8E:G34C8FV02f]4&YP7OJZ1?I]9XdFND4@L_21U0?fF(--Q?05
[VFGFV[HUJ5X[4KC]?:aK3MBQeWD.QBCaJBX[,\,825+MPA__8?YTPa1+<L_gZdY
c_(f1\a5</;#6b^^GWQAF<&b-1Fd;0UHTMd\+IDR):baO<fO:A[,Q9-1??Z[A-/J
:Wd>2SaTZ7J\ATTR6HYeQaCX72g=D7ADWf1364FbS/&A]<\L]@_@<OFDFJP[I\J(
[b>AL)dBMRJ/cL+&c8Q#Q\a=U<EE<#10ZOQK,N;d&;?WP.SK?LRF@VSJXYfd:b01
0e1)AJ&:GHXTF;6G?36dTe5LGG8[WO^H>S7B9<b,+)X-2SCf4[E^9DM5<\.aVG;C
EBDK3aDS15-GJ/J[1\Q+YaVA8ZEUC]X_=51?D>IC-B.D[a0&,&M3\(A(,WL/4,)4
@;#e:,E0E/@?fFXJeZ?9:Q[9b)K^OWY_e&LRZ#-X=O:Q(__^3ZN?6;fY5](>c-7^
e+?AB@3VU21R/a<A>.H@2T59OeAc>Ybd^A.]L,gSBJ3:c=T<>Z>@\,J+L6N^Pf)9
CZK?d20+CEL#&B9Nd.(XZ7a1.0,\/YMA,?N@C/]-QK,d.[S.?8;aHK,7=9U2<fNc
<#P/3]A<T1/A4U:H3FHD)HZ(R5ZUfXVD;VWV1767f[]1A:)f2:ZK#,W3#?UdMa/W
FB\6XK1Na>]AX5JHTL=+.472M+>>V?b4:<+I:[NQXF/<^Y3f&7d+P#GOA\4T/D)V
5K4WNUf=.J?]J:5/@TdSH[GW<G^RIMH_I.DNEfMHC(US=#T[NeAD\\NcNN7d#D^c
V2NfUS8SY(Z[;cN-JC8TAZZMHTE@b[&VO9/(3D8CG:KPaIQ1B;O+fGF.G+Z>2F+R
<DN>SY^G&b_ZB\IA^5_YgJ)3a1_T0\+[fE&.7XcdL\1/dIY]cR)BZaUS:f4.cH@5
A_I/BD4>B]>CDe)bb-F.@J(CJ\8(?K/DQ?QA_2WD5)299RdV3d+SC@Z]#]L,8R(-
R299;=]\(5<6E#QU+(?bNddc&CBTG_5bff2-eC1IHBA0UN(V51:<E,T@_YSK/.aK
ZBIWAC4.&;R//YP]0L=Ag:YSHW9_C7/Z5HaU^Z5K^GT/bc,)^M&S:d?R#@M6;ASS
GGC-g_dX5RO]2?V)?AgIfYdbZ@>N?7452NY=A?T3NVd:_7=b<WE;f=OQ?c1+2Q77
dDA\\]OM/4aVg,/.UMd-IdVHUPL]+E(cEOe[(WEGV>1J^G7.EZUQa_?8-O@\)JB[
]d6ZW/SWZZ#6AG(-1JJX5Q=M\PHPW-M[NG&faVK@+.OcC/VVQT_-fQE6B,?&<RJS
>CQ=>E(LdWI2E/[=)VMZS0E-S8^R[0]=8W>=dUS>Q[1IZH>G>c^^^P8Qg<M<;,L0
,TYM0O/ga7RD>JaX^F2Lc<e7ZN2OS>Wd3G[-MEW0#8X[#;LELQ9-eW[+dV0b#PC8
3-:_=/_Z()>5(DHG(Z3=N-UIBYLUS>#5T>S4H=EfGMP3@(6QKYWfNfM.#bPZ#U-X
dee=STLI#;a:[\Ed?)77Jde[68+ORa5P9EU8R#K.QRFY36AF>E_KDQC6KB??##)?
:/HR7CCV[TD<881GB<T[G3][\E]FXT[3?7\:)\>geadWA:/b\TUZYI_KT]aCW^aE
QMaB,4(b<cfP;0R1-dd\B;/?/3>A7#C-g#dS6S55KBKcg;):M9-BYB1O2a<0?,3d
Z1VHNS)P.a:O_O-3)UN1fWJ4LWI[O_dJC4E8:->e76;f/Yg<^&2^Z@Z(_7=]<VE?
J]Z?2^=bT;gf/8RE++(R7D93JX7<EU_24Qa8?@(\G@UI71##BRg+_I,?@XV(PNYN
EX.F&KLTc.:NML\#Y/>=)7[5/Y33U-<a@HJ7NG5>Y_D<Db05(QO,V8\A^AR4e&OL
R_<>F@c(_@4K^#N_/\=4Od/N1U&=DM??BIF:A,[TRd0MIBa7g46;FD=#g4V(^OcO
SIG=eUXPHCc5WIC3UZ5Q@_RP=<O&)/@Pb-9N2E^.b,&A><:D[N\G[d?31P:UK/1+
PS[.V0Z0V3JMW\@d?7g1F_?:PUNb5CJ?C_MC&0LE;a48PD#E^X.HAW^4cFX_S+_g
IE:<\bH-RCJ=cG#ZUVMMNYY#D2J-R.Y-^C3/VGKI6)_NU=-?eLa3CXFbTS_:;_=]
QO9fS?Xf,&QJS&dYQ,()O+_^g-+d9]Sa=:2dL@)O];DIVI4\2D53cOF^HDWEWO3R
g;AR=N#R>+9N,MW)T=\\WVeg@11>#GYWJ+Fe5SbUJ\&:bAC_M6;b(N?M[A8NFVI\
U9UR3UVC3&/Eg@d80^]YC3f&8LgY=f.I_b5Oc=.6H>b3^VJ.M-@&4V0I^bZH&204
5e?4+2;@_b5^Jb3ZdXA&8]H[_FFM,_693HQO2PU:6[#YFY=+WfE/bHO5FL4V&]?B
,W;-EYMK[\OYDF7A.>4>)F:7(;_FU[N;?AQTGIOWAAVJBK&cY?^-ID6ZaK=4GX-@
BU&gDa-4(#]]\g]JQQfgg&EB0c(]1R^O5Q^R99(&LDfTNc+WAY^4-6gGW=(^LEPd
>=,fC75geC0J#f_G)<7fbBeLN;X,FX,S<>->3\+.d\EG)06P\S)/;OGZ[6#LgM/7
)Od1ZG[[b]7ES@AUC(90WIb:]DS+b[AK=a8(:>;JTO]d_OIPBG2)P&19:1ObECWQ
VOFJ0Y528)&SJN6+5NZ)_&XXJ]2)[VOPfd]WKN+?;AN[Q(/IA\e1)49cEK8OE]Hf
K1=_]E+;29N>9.OfQEfZN9>I/_Zc?c4V.W44@RAaA);DXK?13(&13M&F.:=NLK?:
M?^M^;)\[+Y+2g&JeI)U9.YgQA#eYNQ;WVQP91K.YZfd2>24[2,^<0.WXS_aI-Sg
_H9,IgIAQFY]R).#KXEDO:c_5^L_HY,8TK\XAgL,S1]S.R?+A_Idd_.9bMdNe0cD
WY_LZc<e_NC9&>aFB=S4+GFJO2eM:,I@.<60?^J]LGe.S+6,bFH0^=a_X#0=D5IS
f-;]AfTEBD_e?(=(,dJQP@YDd4XN/7dbKR4SI8&fR.U/Z^OeCWY82;#@6/8OdE72
JQ]/=SQ_cP-RA&(cGZK(B5N+)5c7MA.&5DOA]Q+./3KAY-9?SU;O6+P_)IU2RXL)
\5YeZ9J1HZa9I5HT>:I>9cIPg(YCX\S/L,AOS5S<<-Y-3ZW:gM,/0,P53_Y:P]6c
E,@d+Bc>-5b1C==QUdc\AMWaKcA574G8_ZNJ(aSd4U@P.9@Z?D\X9ZV0W(V.2]fD
O[]P(3(8ZIK_+\6X^N>FX=Q+].-NfZDE:.IR4VYL#F)-2\+[5NZf6<dK>5eNFB&-
5SK,R\IOO]7-&bbU[E<,_431#7_aB<?F#D2cEa,LZ)LTV3I+IOO@ATY^[/.FS>0[
1=4Og1AFM1(<@;]bN-OW+CK,F5I&/2]eGC08YSbQ_)T4<O3ZU<[&VYW4(ZPL<3=S
SN7#dW(]E:R@ag9^T:PG,^W2>I92FHM_g5L&GRW7:5(W_-;5eDCJ\B8d>GUWfMGJ
K4K(3Q3SaZaEE#d7=+GOPL\@H-F/c;&JdU^5:19FE^c&GC4+(A1F6d?-H)IbYCUQ
-#WO0_NM9#Vb7;#MNSEG;MfU\5\>1#fMX.-YN-[[X-M^[J4(-\;a:VBd39TNU<I@
4&N@O1J\7HXD0))f87JK6IXXeBQA[NafQb70@A]A[Y9::5cX.Y3]KW-g:F?/0:61
TP)--+?1R7,H<,7</?;Hc&T1RC@3FBdfV[#RW^HH[MRY0+TO3^2S(f[_JR(=#g>B
J#V@WX[PM1H.PLKA.+3QDOL8:R,;5FK9K/:I6H6H:b#TP50D-Y]W5(5C)aVKAfF5
YLZ5&]S)@J&&.];.W:PA7Y-=;YK@BeFK>JW)8dG.J,BK\7?&_YF0aJb=Vfd>1KGT
T++Q+F7<C=Bd,V7PFQ1KS@c]Vb8R5Q;ZYMNO?,f,^8]+Eb@e&A#O:0,;./6?N6UW
>1P,8cRaKO((eAG,E0-#&QHS3JGgNcYVZ^5QFO<:-0CCCT?#\7(\JFCK6S?bJUeE
RY1HL=Y;WIS55-0[8UGK-Tf)=CaJIP>H;ERO0U@X4=0gM7TNX2=A?(e+6@:=2\LI
OHVY;1H)?,_IDK+UE4:)KY>>_6BFVE7LG^=O(]=a@_72f2-T.GW>PQIRL<a?7<)K
2Cd<G?TQ[_#>)^UcUP1.=\>X>8c#/Q&P>4c(LBNfH-HUF.)HcA&->PMM2-../Z:]
X.HV+R/bSa\PJV(UT35^U?XV9\3XF^+P5QBO6361DDc,CBfG&.>-fbOFDf?3V7U8
^Qa+>WPQ0g=GBQedQV]#]L?-EFaR,(&W1H&d\W^MXNTNIG=<gd:PeY\2Ug;L,Q(-
CZ+AfC217P9,ce;?74cg,Ac;N3BGLOY8\J]=U\UO5OUaJIKBVbA3gPNJQ98?MQbC
2-L@^I+,/>7XIN)(Y7-QQN7(a(@)A9BG5IdeD9d2Z3b]KS])^=:0e)I2bVVdU<JJ
S_5A?^27QG[?R8bI_I;M.MM.,SB>7Qba2a+a1Q0HMMY;^,QX-b/JO.8BU1XX#)1F
DFA@,RZQFdFCI#.FP<U)9F#C+2agCP:L,#GUZ78LM__3AGD-W@7=\Ue85O0f,Z]G
^U]/b\B4J^@)NKfLe3)<W8#UBSYULUCdgXEPLVW7Y/V/2):68g2O:[\g7b+cRQ?.
T__cE>[(Q(MP>5b>?/d00PLG0A_-A)..9^AIEf8S+O)C&.H-Ga4X0bV>?1IdM)/C
,8_.T64=E6UQ/]FRP/;M2.L-E0-gNL[6NL0RN&R/5]M.SD3+b_(7R)F25BF>aF1A
,)>:HUa/O;\5Qf1@.N\9fHN,P+RdBO4d))WI&\N_.Z+ZE8/QIQ?.32<[-7J0=T?@R$
`endprotected


`endif // SVT_AXI_QVN_TRANSACTION
