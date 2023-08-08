
`ifndef GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV
`define GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_transaction;

/**
    This is a transaction type which contains handles to to base transaction
    object of type #svt_axi_transaction     
 */
class svt_axi_barrier_pair_transaction extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_barrier_pair_transaction)
`endif
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /** Variable that holds the object_id of this transaction */
  int object_id = -1;

  /** Variable to indicate that matching transactions in barrier pair are
   * associated 
   */
  int is_paired = -1;

  /**
   * Write Barrier transaction.
   * When this handle is null, it indicates that WRITEBARRIER in the
   * barrier-pair transaction has not yet arrived.
   * When non-null, corresponding WRITEBARRIER has arrived and is paired.
   */
  svt_axi_transaction  write_barrier;

  /**
   * Read Barrier transaction.
   * When this handle is null, it indicates that READBARRIER in the
   * barrier-pair transaction has not yet arrived.
   * When non-null, corresponding READBARRIER has arrived and is paired.
   */
  svt_axi_transaction  read_barrier;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_barrier_pair_transaction", "class" );
`endif

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_barrier_pair_transaction_inst");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_barrier_pair_transaction_inst");
`else
  `svt_vmm_data_new(svt_axi_barrier_pair_transaction)
  extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_axi_barrier_pair_transaction)
    `svt_field_object(write_barrier,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_object(read_barrier,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int   (object_id,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (is_paired,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_axi_barrier_pair_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

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
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_master_transaction.
   */
  extern virtual function vmm_data do_allocate ();
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

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
  
  // ---------------------------------------------------------------------------
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

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_barrier_pair_transaction)
`endif
endclass

`protected
2)+N:XXbfYRMeXT<Z4b(OP/4Fa>J:T<>6gGM@ePg4\+#_VJN^P#C5)GN@[TH=Z<O
Fe[E+Jc]>LP9D/3R&44Gd9&e8>fNAL+&[b+=3FM/47P;:.4ENFY[O)T3#9J6ZgMc
J)S#0<]:A7VM_2_7fTZ6]+5RUa:.(27\KFF:1E4W1&/&?S^U;1Fg<IL(/]3\B:d&
QUH<[bT1O(QbFB=MAN<VEMHKSUT7,(:9N8F?1[V10\CPV#e<dPN2,EDJW_:QMK@V
<<OT@K>&Q=8^?MX=HR^K6@4)537fU2UbZ7H:Z<a-VW5CCG<H3JZU3TPA^<-5J7UD
:5/d/CE.-II)WDA+GbT@Z2+B8[>@]J=KE/P=_g/BZY6&(BQD:QA/.]15H/;,U_,C
bV.8R<&_c43RSQE8f2Zb[T=>X-HdQ_fM+3a[fScFH_T]9NY;,/2)&QZA:=g_KDfg
HF-X[Na&5adcBa3C.-X;7(J;S6dg(E5R)f;8YQJA1A:c/Y3.^]>]JI]B<3]YeX5c
8\)8>e,SGbd?#bf>:<>\KT,A>5?[B=<[&?+Q@/RLd[b^/U1=>;L)S04D)A<-]G9_
9-7cTf2X7ARXIQ2?[:EV5g1CO__NNHIFCP^-2HdG3W],5#@QGZ\JCTBc;H^(H8H1
;/Z+1>8PZZILb.U&T^#H6ER4NX8gTNFQ9Y/eGbA7UN1Kc_V88,@bea\1U?+V\CT/
6([0^I0IV4ZSG_::JPQ<W?EB[B>@T,@J:$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
=\.dI?,U#I<X/CZ?AAMQR=]c0XWTTR5449(_HWZ26>V_TQN?D#-N5(H\RP#A5956
>OgRK,Af^&NARMTQR+O3=P+M:=Acac03Pec_A#_J@cM\.H/0W1:eOQG#Pb.[#-cM
80^>;VaVARWZN=_AVS6C(Z9-VT5gS\Y658V(PO-cd01YZZ/^,W&59gAPQDLJe3fY
]9a>C.;,b\:1a@TI-Q&L<4Ja:P)Gea@K)U)NZE-T=P--F._bKKSM0_&Fd-IZ.+H3
@Yf37SO/1@PX,#0[f[S/LF,16I#Zf<[Q;$
`endprotected

// -----------------------------------------------------------------------------
`protected
V3OT0FXD:5.0L#NbF&cPO@6_LLWeNN(D-BP=NZaIN(EfUI4GG0:P/)]HS-_D4V6R
Dd7GM=f?Ja\0+$
`endprotected

//vcs_vip_protect
`protected
PR.KfXbUYFC(d9La?ZLe68F#[;J]?6URVVZJ32GWWZX0d/YVZ^Q)6(Z85CL\W?\:
X7d;Uf\A/5.XfKF_H7TD57>[NKDUD381-6-DM^DYC#Rg^:R/]C1?UEZ+=9=<6U-,
HOGHaIRg.LA[:d^D&\]L.C?#F)::)G@fX<&gfM>eQ>-J_2TC_/9Q+VbY1VLMS.9W
K>=,F65#5O?TB6eR5HAP4BK]7\ONE#VZ[Uf1DF/7bG=1W:?EY?GN]11DPK9F0VN\
T^bJEH??[235<)G4FgA=)3ee]A,&]cS^&I^61DI@23Q)Z0H6>_/O,DTBYDSDYJ5Q
W>FR3dbS?4AZ-V7<4.RBKE-Xc^O0H4T@WUD_3baL]H]JX5:@EAC?2M/G.YGg7<@Z
]4<Qd+8:F5.X?J20M?=4#(P.a].-<2fSaJ0HC[gS>>8+ZR4EdX7g/:BXe;]@2Of2
YGd37g/VaRE^J<1R@[\O7/HS@a+553;BGZ=2TUX7dLcD:UR]V^H)Ib(,=YH40IQ6
0faDb9/+&#-(gG#/4_8+B+W+H6F,.F\.GAf\Y1\#S.AV0YWXYPT]fQQAC39Sc,U,
e/7Ed2IOQ<gYWA=8<b]f3V_\X]G^b/-fFE+I&J#c2cLC6b9U/81BLcg=Ed8,HG9B
W>B<B;Y(N1B>KF/<+>HTGfRO0-6:cG?[4>LY/c,MM13)YN\:(1CSD>?8Q25S(:VQ
BC^E[Ee)H)3GWf/d]^YMKZ/HS#,;J(1HBN<7^#;A=-_9NJ?\V/VL_V^B,A4?&V&?
fAg6,<TRM6FL[)#g6=4b?R.85-QeIFc[\;A&<)QLW5,?E3BVT[5LE^+J0QP[X4VC
:E=[(T@2,Z@+6CgS@?9]7_4PU+IJFXPL(^Sb1dfdXW-[L)&1(&_38\S3VXd2^eVX
HC#+^Y47YTFfc;1J/5Jg&J&TQe-a9ZHO:G&=a(G[a_Jf(:FX<g4FI53&Dc2TO-13
8IBGHT<=:@?0V>TDLN0R\75#[3:Gd;Y^\3IYCc;+]JNe.#MPTY4-_1;egWBT\QW^
Gb6+1]X/eg^g^fH3+d:K@b1LSN<:70\EKSG27\ORF.C?<]A-(2RcePeFI/V=U3T_
WPU6a\&O],LJ..5Q5d_GI&1eF2)X@L?YH8)O@6JH]/e:+MU&>:cec#Y_KcQY3fG#
4ODTNdP?04ZD+Ja1N4JcGg[\P8S2H6b3Q]_gQ)KF1Qf2dZ(O4BD318D-=B8C1f>-
Z;8H(M,1(.KVC)BJ/CB8;Aa?S0JbbK:L5L]9)-H=N)?8GO3H#])2^].(1GUCPF^6
^Y]gNFRALf,EU6YW4&#^(^GbG.HOCZ0Xb]&-gf@2AO2@M-MQ0g<?AI#?8?0VS)V)
RQYO]<CR/TV\:#4/D)^G]=#caN+N1E>RYS[-IELf1gD<J:O#]^/Oe4H#)CdBI1IE
1SL;bM_NdDSWB]XbHM9Z;(G-A=LS1K]Y?/;M,915Z5;4PH/Y<RV:cF3>E\+TR+Fg
Q-cE#bD,>)?IFZ?UI]:M91NV@)<Z^1fO)M:+dd9/8T.@\JL>^1(4E^He5<GZ)PB?
D_822]SZIT>HBe3?2WK@@,aZ483?5X>,4.D>6B@+#_F^Rb#NAX<\W5W-EBf/d[I1
X41TgQga2G,EXc<,?>>^BBa2:SBbVJDUONbcGOb<e18&14B<g1gB\f#CLP_S?D3.
2D5_,=,KEW6\(H=>7<M)Kf=XX(MGN-cB;;c)RH_f&g3ADb)?24]5N)R(V>XAVMZ+
e)H8S:B1DSB=6^W3=U]:.T?F8.-BC2O7UYVA:4A=dPRR&)B>CR<b(=Y6QfIUN(>8
MG+JOH8dWUeBN;TU0/II#^D/g^6+f]7E8)N(_&_9gGAM@MDe#gbH?c18eEJ5FH]]
cAM:R1>IYP4-@;LDN?>d7g3-c^JN3-LGb_30>/Z(Wf@3N((dSI/XHZCMa/FI66X?
R,62Y29X_g7A9Eg\3]fea,25N]:H(Y;A;a;1D<Y6J[<H?=a2]MEeVZcU95=KWOd]
H=P@+#[LXV;Hd>SGM7@@IP4)\YbS9Q9#[99+N;H=8U^DF?e^cg_,Y>SR#CMS2D=,
@3^QDc<fZUeBDaX6<7gI;/eXP4GMCARebQSe53WFa#BI,_;,R5:(DU40b=[4\D_(
cVbN-N=EfMX_.QeGZXBF1WXQ5[4_^)A-&URCXcHD?QbM-5YGf6fA\Q<=3GD+X3KD
J)ZHHc.G)TaC_J@PBEXS+607BgVX#AFA4YKH7V@N9cc;7#eJ,TH5ZgR=OP[-@Y(P
D+F&,6PP360]+6GcVX>(##FG^;J9IgL8BZ<J&[QMN=FDQ#;eA>;_W^De4SX.<H#C
e9OVRW\5IUDL7;&:&c^/5_>UNAI+:Y<J<T[OE0eGd:aN_T\R0?>g+3b?W9OBCc/\
(//NeIECg^7/C5F-_N.KS;P()K&_P]5a<0aSe@B),E-OE;@WC@U^@NLeG62QWI^7
(FB9RCX+26FL#;:f[0<N(\&e1SY)TVK^DXG:29B-0e[[EIKOdI_?gWc.ELDc2:,B
e3TBY?F<]\c8H#1=agX.HG/SEReYRe><>K,-Y_WfGf6DD68]-IE<&KJ^ZgJY9+,;
eJ_#:F5XO)+K#>DHdV,Z5&2,CUg?4DB:06bO<Z=+]@8L67+]L4,?0CT2FLCW?WAe
+6\b2D5@9fZETfD30daN#59O0d5-3RIQ?,]5X0\>[AT/7[Ra,Z0K&TLH<9(3CR-<
.Q/+/_C5+_\5^[Z([I6f]e41&@ZGYF6\.<:[aKea2S,cWTM^c\CEO10A:(T6W.bM
DM7.HQBZY]V:XNdb@2/K?E@+Z\P;W\^_P\(^IFXL=H9PbBV@B9+ZfeCf9]\=K\F4
Hf&_>f73^L^fWOY)Nd[,M=fS1R:<Z]]BNJMS);-^DgB,K5M<9<XD#Z56K75&<9J\
AcE^,LO84G-<]V@5+WcQ9g:;OL?Q?^FN1f.G;WW=7W>21A&L]]0f/JDdb.T<0F+L
&M99VbBG2fMF[-C&[Ga3=I18V^:c2IJ.5U;gK#ggNJIRTF?&#^W^##&ZTF1A2bgd
B^(4gAW.-1(-2MOd?d)M&1CPG]M=?MCKK@2&.f&<MG#NJ5geVVK1-&:&#?+EX[OD
U9A1#S4+XH=:O44ZS5La2@\7T9;;#0A--1DUSd(7,3-.J=Hg[9#<Eb#5bIQ[TC;H
8TMPK2&V3-)ZN=S@dQ-UEH5S#.2-K=9f#(Y>=L0>bWFc3>H,ZB\O/J&516Ef&)GD
(eEc;F82f4+F66P6;N^N+KG?g60S&/CgA0d;\M.;H-Z[gJLc]Lf.4/;-cPFHH.HW
EA=]?2<c_PNTSDC-^8++]B)/cZ]g<ZN4R#S7c:ffSUbZC=]C_)(C5GZ.4)<@&MFU
CDOf<37d5=\XA(g]&6)=dI.4,#V4S?G#-d8T]MYO&HF,J<#TY\96DUNM^N(/F;Lb
f[=&8[GH.W/X&B]LaB-.#BV@_g\KcYeQKFL-]20\X-OA?//\E22JScYZ<<58#>+(
dMS@FCW=)+/M#.)BW5N\f0)aCDc;R01,.&A7_RaUb0ReFGY28SIXVUQ407+E.&S7
+8S+S@63[0NNC/VX.NE7NN<H4Ua(5T([OWGQdQ@ab#7Q[H08@e@=7&BWW,A\2R&b
MDV\/0+SOU<8Z3V<=0LKVM&FMC?Z73YS</,=b-1I7gV6gC=DLX#T>4?4V]&c&ELD
^YH=A?TIJIXccVH_Z,F-f,9/&X)38dEX=#FCG[ab#ZGaOT9cGNP&[,&F&NW\ACff
=&MJgJ22da&N1E&eP75UC_#a8gNbNe7EFW=>@Y,E4c;K4aVFd=;#><&EFK[b+4dN
ddXRW[FBJ51W:ALJ&&Xe6XHKBR.#\Y-b8a]/^QD\cbS@HODR&b0>57PVEP?^NE?R
CS:SKOT<G>ZBGWX)R75Q5<P5,ECPK;^DMfBEFKWSgP,]+>b@cSd6e_^-/C8FdO:G
_T4DaFVW]0;;OfT8)Sd+<61:/R[+bJU6J=;U[2W>[(3:TR5L;H-Eeda&G2:>MR^H
_\W#MQ>0fX24dgA&#e-N0eF^.ZYX>],+?IU/P&CTDJW(22(\<<D\;JKINY+dVBUS
P0:(-F\X3dBVW1QX.6D8PL8O.B0[I\N:?ZDc6,)8VH[f3?V73OV4X#)5=2)R49+0
.ZT,.dMHcMD(P2R\gS^c;:25(KKN2-X);+_c>)a)eeg5#g.J9WFZZCM^cAL^(LK4
UVBS+48-9d2:LGb>+dX6.Ae8JH=I+X,1bb=[-^69,+V,C^fNJ=#.X2U5E,/KI;C0
/2:,?8ETSRc1<^._I?:\]a-G\.G9a0R+eD8dXF?cT&43:Ke&a@XM8NODZ05;eP.9
2F<;BEM/+T+M9BAQOXbF(J[0.C3KQ&J<Ba54;N:11[F#=#.)NY72)JZUU\gK:OZV
.9@>KPT3EAON&F,SW7GRR[00G/QZM_]:U\]>W2(3ZKaZW?96e1PD&?0?<#a)PfU=
5UITTY1/[&Je,FUV&RFN?N^4Q#cTe8g/M1+6+#+?L@d0WU)-Q[MMIL7:)c_GZYYC
TR\U7OAc3#@@IB7T+,Wd@)IcK-_J0A]#Hb_]_Jc(5:g^,<RT=KBVX+FePdT.)f3J
dXdB(B7#+/F_W0Q&gMcW_g8P0:\^_F?/e-/53#\C4,TB)MZWWaXg#6YZ]W6-BH7f
]Ve>?_IK]0_FLZ;=X(dZEDWEVZ;\M7ET:C036_=d_]AGV=FOLSUBJcJC;S&dNZIM
3fK_U0,D0W1TJb6B<=N,G.7X3L+Y5(G9b4b7FLT:I1J5[=@A4J_Na-@87>g\79[8
VL,M5;&)a@US/De=;9\7&3(DSA-P8LDOQ3#EB,Bc-D79DaDR&O.;8J0NEa7N(T>B
,Y=PeQ[GZ8EJZaEA<6GbFg=L<cXOSdM/3P+KcL=dQZL4cda\)2J=#2PcTBGY?ARD
L970daS<5fV@#VG1_ZH7ME@UAAU\S0P+?KV^+ZbOLQKYAASGNbVJa7CL)0Dc5&6e
Kb()Mf4IF+;#;ZT#]B8<G(M_PMXNU/B?R;6)BRcSKJ_AZICe87,d[6F5cM88fT<g
<@=0d<b0S+ST,Q)(b+(GSdgcB]\<cT05N>W:Q:cg?1GSM@8/A_;3A6,D#dJEEK6>
D599W_5/7aF]SD9_[G0gNJ,W#WHTQ4.aba>X3Q^+AeKf9=5J3;\<4Ae.R:NCDU1e
@<&[E@,2K\4VdG>)gS\X8Q2TF&Sde+[RYf\?^aAeQ7S3YH+1&:ZCT\2CS\7]>>UO
bDO7):25c]Ve+?4^afOXeTg\/XeQ(FWZJ+NMXB,^TS\,g/Da5RM,],EAA7=)<3g;
K04,cacA.+I@R;T+8E]MKd.]:D07M.7Y93\1BW7HEKS/3Q34D(E(S8_#^Y4+V>e4
:]TPF2QR@CG96N;SWd\RLKMN]POdGM_bK76P-E?@X/?Y/0T6ag+H1Jf8L9F)??^,
;A<K)6N\8177bENOe8CHS/Lf(J2ZV[c6#OaT@7K6#F[becgH.H_J#K8Q7VSQUT+L
HES8Bd)agS31\gHFaV=;?JM4:X6E:#N/Y622-KHB0O9V3+XIGU2Q+Q.FWF6U/7D+
J5P@@YK-#cCJcI[+;Lc]a30[d8M9HS.W..Q]UL>?e@^;a<=Sb\-OL(L@9R6IAD=Y
Eb^)UDCc>(\A2>68b;<Z3M[?;#NDA&Q\A2^@UbLWVCG1C5AFB(YOa:,;ILCB4A]N
]V1C2,49Z[aaR0_.-^c6;10bD.;9_08g_[)3\_F,=R&EQ4N\@)<>G9N=P#V+W#+4
a\YG@+=GYPa_A.35NaO8g^(U26eB22XIP]+B?(BF20K<+4dF&Y.W7ggLe;(ZP)H1
+V;e[eAG7GbW32JPeM/_Pdfe\QNS:=eB2:eZ30&3Cd8K8Xb[N<gG/EN5QK_MHb7?
6)Id.=H>Zg)00c@0cgOJW]XF;.^G\56Qc/Uf,,>eKBE3f2?PO^gU_eW&H=>fb[EQ
6aT2XX4T<4.^:]S7O.g5GBb#P4D4<KX:=aT?KX,aVUR/;_MA?g64[7LZQ(0#bQ@f
\+L?=31&Oc\(>APKG67I](R?HWc69<NY=7/Y#6<?FC6LX@[VP>6gO(,&9Scd=MdT
X^];N9;bb:<1)JC_P\OH,B(f;JHMU3)JN?b&+Eb/;QMHD/fGD29-]Z0)G__EQL(4
/HB5fSSdRaXWE)05&1a=(P&M//YFZ03=]/;34O)6/4EKIdQ3X/D46RMcL3RH]MF#
bM_If_PaC5?g,JY-::a5E+a,U_;N+eDe,-F>+I9BBP\;.YPTFIRRKM;Xg2Q]K8KI
KJP+3)<:9L9IL:9.0(0/2aWa/Bg;/UU/S5<^VCWHW6SD?[Ha[+\X;(BXST/FI895
YE)X:(:Pa@L:&0J(eAT67c:BCgS7G:UR=NY.;)QLC8&\Of4E)eZF741J]gJ7;,g:
OZT;MQ8dd/?.&-CH6]1Ab9<MTEU]Y9NaHH4^?f3JR6;5(Od+H#ca\NFJG(YZE(d<
AG0WD0d3V&:MO0:#^;Pd9O5QIF9bN5eJaL0\)[BWc<?(e2g?DOGDQ41<b<?4X4,P
9BE(a6^5^>/cB6Sf?[N=]7K)4?;(YRBI^\ZP\gW]=Nc^?D+O&L09Hc4c]d3=N(@c
CIODII7-1R-<>3c<9JSb-^NI7Ic<cJHZZ^:_0Jg>eDNf03MQ9@3?gJ;&TTOFcKEN
2N/21RNgK-QO&>d<fS2N6S..+O15HRZVTA<K\VPJ?U<=gQ34O28_1HN+RFO@7e21
QWgSW_.T_#:/XH]g.9OJKUc)R6J2F[E\])P&?2-b(\7XX9[&c@^6P=M;3d_0P&,#
2Z7KeM:;BXD?CHI.^]Q3:^CIPgIMN?]GGX;YC5+0K)Y7MPJJ/&L^3cJb0FB(.5GC
TXQ+3\&^CO?MP?b[M^A]8CVbTV?R]P(-Ce3VNd4+X-.dW3GgKKY1ULZH+a#X1Z1H
_fb?Ma/9B;C)G/1CUfa5e<;ZH]2e0@GFO4X)HL]F:=373-6_#&dC8L,YW>d1QKa\
TBBJ^gW-.aXRAIUbADG>cMM\\VB+K/d,RaP44&5U,Ka7(6=g2)5:57e);aQdXLbY
H9HMQcCaW6=DX:E&;;523>?\.\?6S8E<\SE@W98=f=)D@W_;FW7O,K5BX&g7/[dZ
9@Ibe<4Q?+[FVM;Ef+gTLU?e:Z\2U6BXc^;Ea-O@a&3QGC,L\G#:S^C/He\88W8O
O-^MHTL:74#0#K+=[2baNUW#d+CdWM79e.e;EPVbeLIXbDC\<6P>aJeJ@JA3gYSZ
gQ.M/#VOF?cE^.g>-&;S/-EWf&?OYJ\Qf7]8PIXIJDO;DX319JNY]290g]^9<W<5
/ZAR)f:R_P=5.5d4I9\fN<:KZWX?:NA4B_>72.Tg./;0H/d@D4AG/TdQed5?I)7,
/CKZ(+-]MC9XIe;5/O/KGZ[9N7-F>FJL;5)bBI7&d(_J9SI^FJb&3Y01OU6:3\E#
_A-=TI<4+/??A??67A)L0S1(G(gBRf657BRQQP1N(P:gDTC5S?F@/J>FJ+P9E.<4
K#C3/BGLS1/4,Ra,O+5&d>22BO<3Zf#>6OaQ6IW\)@FKD&MOM/c(3P)Z;GOV(&&1
#33f9eBP_L:^^g^N+-B4a6KF?@WBPJfHS0RV=\Z9)I,be,#:EO-UM7CQ>5@K7GHQ
G<WQFJ^0;VO&8g>\I:&S@^?@RLg.#IbI=$
`endprotected


`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_channel;
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_transaction_channel;
  `vmm_atomic_gen(svt_axi_barrier_pair_transaction, "VMM (Atomic) Generator for svt_axi_barrier_pair_transaction data objects")
  `vmm_scenario_gen(svt_axi_barrier_pair_transaction, "VMM (Scenario) Generator for svt_axi_barrier_pair_transaction data objects")
`endif
  `endif // GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV
