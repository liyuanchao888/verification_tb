
`ifndef GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_apb_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_apb_mem_system_backdoor)
  `svt_data_member_end(svt_apb_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek and poke) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();

endclass: svt_apb_mem_system_backdoor
/** @endcond */

`protected
beZ]S-@eUGA1S6R2\BeDG9fVAgVPA->.@+J\KVU^E.3+U,,44ZZc.)T8d<.6:W?3
[G<(SWec.B_@CPX^@?ZV^8L.V[.b:ND/.\VcWBHQ]FBDPA54d(WK:8A0QGV]^RBU
49SIZgaY8)&Ye2#TW(5e]<PQ&[Z,4>AW-]EN:L,J+E+D<CgNUGKb+fOIWF:Q>8AY
R+>#X.]+^De,HVVZ-D2I&aRd@,6TI-]S]^1aWLT\Y4e.Q?B;D>[,a(VB7c(++)NQ
a>_SSeJ<2(fL];WOXV4>Q]G@[e_b#XeS=c0c37_>L7KYIX?)fZ&,Gc<]MZ0\Uca5
E;55-bIDc@,+[>BY4)aP]X,4S?T]@#9WL5KDeUdaU?(M,.EYGNJ52_3-2c5(;J=F
B6BZKG(e)S9OE\30^9O^3IAaLL(IPRXbX4SI]8^d;0O,T4E6d[LI@b>9\MR&X#Z+
2N0gO1B6@WQ02B(/58Z.=+DCag2Y.AT,+JFa6>WD28:)?^aHg4>>\J6;Q]5A1)C#
@A>CZ>dYNJJa<82+aWO-)=d?(=BcELgPbHJ\88DGQ4g[C.6(NEZaD9U-VXU6(D,c
UDB4Nd8)2B(3J0^5[NS4,;@A0La1C;F]90PP&[2O[S#5F\,43aF-S+JG4\IOg;4:
9[DMX(J0=F#/d?fND[A3,U]8=B\d#YP0Tf/?5LJPFF;YVQ,F1->ESXeT5ca/M9U1
\32Q?3<.)]:)0@+.M1CL-L0-](LF?^]>LBNU/=G[X;gM<6?VS##Ab.A0W+dg>@^^
S4R]D1JP2.2GbV&fEH6?GA8Ib&XH)],(8C?+ALbULaN-DDggVg7I:3V>&\7^G#\[
GYcXVWKYWD?e+Tfda)KS&VBJgfQ@7J-FMCWaY\>DMaJ:bJB<UCAfSWL(aQ(dC^&:
($
`endprotected


//vcs_lic_vip_protect
  `protected
T2JX]IP.=N:YLf2E2]8Oe?-B@e/#:K9L][LRL(;),4Q]5^#D9QB.3(c>7JWN\1/S
CI@DMg8LWK89#8eJS_[QN0TX&:>/&TDA@VTcT)aOLJ0TL,;f+J[KeQ<TS:OE5(DR
V;5C>MJ0+<Gg9YPJ8KDG]g5)TN[fc>N1KXLZ\ZLbfUTDD^ZR&/(&]fVEccWWM0H\
S&C.;TW2aagJ]Y4IA[2QWO,eX)JB=^d#bPYTU.M-3bU?)(aVQLD&2QdE76^BVAT)
Qa;/,KTQGPVRNFeLQUAM-)EY,,T<_K2+Ue/SBNd(6H?V93<#4YVYQ>Gb<;(d47Jc
RVPQ;Z</8:6gGe-A9,K94\=J>#P]R>B+I@[QGf5^>]K1)VTP\^Ic7b3Ogb\VWe#F
5,8S?VQ(YNE==YC+KOE0P/H<[a5@3U1_#OC[D#bCFH&CIBb&EGd.XYe#G^Jfd.c[
S<49=3NY>eg<;Z_4eO/Sb.Ig32O7HGG8:(+H@J/&A^MeX0@2E8TLfKQQ5Bb>5,YV
Z@><0[4Ee\g^MR#N<c;3HA]_U6a^,#<CJC:Z<Z3AT#d14Na45H[T:b(WO:M]2f0d
]B]5#,cUAO&2MA\[&Q4TCEJU<gC3_#+,g,:-\)]J^fgb<7)Y?/9J9-+>Gg@gRQP:
FQ^TA8:UM^Z6&De+XY/2@J_6)M]U3\Xe>E8@TZ?Y(27SL4JMdOa(5g.MF#1<Hg;3
;e4=QW:SP]<)f8[E_)\5?3g,IW:6@)gEdXaFP?E:N@_.R1fNa@=^-W)1_@0N=&6#
)H5#=>U-5NQ,#N2>L0XeS;PF6Z\T(NT-Ue;^:GK.9X\1e1NOIMB74&TJ@5M1/VG(
BbEPWcG4gH4X9Pa/:MF4a;Y8\C;Q8]YP:RZ\,OD^?_[V9@\7G\TX@3E:N?L\ZVeg
DD7LU@&@W-<;Q<2YJ5SA4;8,V_WZ@G#Ia7Hb.Fb#S.bKUI.^CJ:gf_.E_KX,LVcd
?B?APXRUY_<HL6DB+aCJKSeV(F#CJ>dedPF6g]TZ2C+)Rc=DE5c<T@(.,AWeZ&J5
<Yc4Vgd(/&DM?M=+SBH]7&F<C8.bSZ(W2ef_Z-40)#<[6^@[c8<,?[X]LIK(0].b
A@aW;_cO?-NGgTQ13aP)/5Y=\bSX=);>Ad+5XC85B)9f086b,fBLPU7P6.282/De
1<?d[;]ONQ17Cec9TJ0YUC+e;d.QOEef;T_AUB?&Y.FO++@7b\D@cI#^\b()Ca\^
8VX<A4?68O_USGY:EG#:)M\9_3X3gdfC:dCfGRNE<fG9VIQ4JH<Q4QY)9Q)7;E[B
_K#.::^2CgYb#IZgN=NW?<gNK,J+L?GR&=C5e-RM_R<gPIFO8<HJ[a3-;LC8\G^5
@Z&-9LdWT&P=844Ngc]-BY3F.72SLLDT5^>@/J;Xgef:J.2@KAZ@2-&cQ40>\6Y3
,+(XQHbU&<W<cf\D;Y049Y^[Ha8[.E8dZg?[,.4KT;EJO27;^/DdI=KJL/URA<;5
AZ+A/+FHPKdB0c.CBLcZ)5+bVg.\9V0[(D:E7c8E<?4b8[[ASSW\+_A;RL1f5#0L
UAZ.8AgRU3F?>]7S3J&c-15/EOeC]MW)dMO5c,Qc?LI76+eZRNDZVTRJ1+/a?>)0
@QOeL)E)A7CMY-S(W4KKV1f^_K-d7Q7MEab6a@+-@>Gc:.,ZC(@SG0K?_]9c.RIH
TM?F[\,OOGg^c24g/c1e(\Ma>Og8,Vc1.fM?(cM8^35IH.J^cc2IAHO[8&//bGAc
U>A1b;M[@7M8c.GB.?M5_[E8NfNJ[)1BOeE[gb8U[K.ZVC]+IRgegREMd9_Q)AaR
+Ic)#;aaHL^7,gBB45aC@^]4ML6d9]cLI8e?9V@([cW#+R]BMJ.+USc61J6.F8aZ
UP1ab>B8SQE=XV^/2.#EQ?<=71=T_A[1S-W#f-:AL+Q>.K_cDcD)2g]1SZ9I+=eG
4#)cB;Gff>O]24CJB(J4BR@DXeNVPd&e>Z6<WL(_bU6]#NOG2E7PYVGXg06OYM]N
JB&U,2\G_6A@U_/<I41U4.(.>4CNM3PC9d]Vdc?ffPTF<-:\4SP.fLZ@0>04GETU
U&c=L+DD]BE:_:,#U-52aUY7)]DS7R-)#,TO,\U2bE+7(+=D[.\[LG./V1f_9\[Z
=D)P9H(4Z5>-F9+3Ug:aESQA29[:b]bL?)PaQ//PQ-R#09SD,X-5G[b(,7P-cOf:
)fVcH6M):[;WY?HeLJ:,//II_U\B=WRVS;7B7J?3Q0;N<g]XC&UI(\@K]IR0629-
&<WN\[19NWRJDI4@SN(fNTSf(&c47YX?&(B.4GdP-Q<CSMdG^9f:D(A5<V#((&Q.
_3HY_Z:=f@-L5KY\7fe;)c8C@<?)YT-OJOQU[CM--XVZ-N^1N(?T-O#W>M[(9F&V
WUUe4]^G^1IgU25E9,EQ1F2[eR^[MRP91(=O1_5+1W1,7HXVVMUg6Z6.^=/SDJcS
;&^N#bc9,]6&HOKafRWa^I_T9fI/^db=;?V?dTbJ9G[1H+OS^U@N](daEOdE[GFE
UV6@;H_I+C1cY?,a[<Z07VW0O>fW(@@0c?DVA5gX7MeY5SXK13BN8Ub)H;&?0QO5
Kc[2.C/WNV6YW/EHIaaLXHHZb=H3a:ZGK_U2/Q2(..CdKL8RR#_EW+=;McccY/bd
6Zg,Ke.8XZO::?OUZ.U/Qgd=HK)2M(H5CG;T1f]JW[eH<&@a?OP\2HFJLAbWIP3^
@BMP\OV@SPFWC]/#[U:FK9bf^XgfC/@X&+4f\P=S_M/JI:a1EP@.Vg)2^/T&)L?a
Q#TI]\<a9&YH,Y3;_#_7<LD&d>@#e\_1N^4>C@NKBCC:c-A8D&V]RNT1Lf<d4U,7
71NL:[]=E\L@4/^<aBA99>U=/8fX<QV:</.ac?MT/6e>KbV27X6e>bI5c>gf5_HC
JRZ:gAbK7TL[(98-g+8[B#KN#HCKS<NN37#bQS.IM,6Z5Z0#=PB,BVTELTDGSf_b
[CDD;6E_J0\@[S(D06;:YBR);c9M7B):&_GF)G280-c1]-HMAYRD[1)93KTLR31?
fA?+/a8DIXHb<:(cB2Q.0Wgb^728b4GH6I#4(S-8e<W3UfF7/5cV^&e1765&DE)-
1GcPPI,c8d=9b7Z:-M#fa8Z01>g(_=NTKRU;IfSO0-]?B=\CSF4U;>-41ad;;)bS
dIKcg5(dFg^A@YF98+_Rc,8ZJ[149C(AE&S3b/)O+NH8A;3I)\S=LM6&/8VVKfCD
ZZXYU&ea>_\cMebEFb]/]Q28?SUSG0NZDD=UW&CUG?_d;PYG+:-W?EIK1N+4#<69
=\@5\5//^/\ICI<+@9eUY:KITW.+fQc8a^:=#5^\D,c.d&bUF2S0cc/SVga=8g1f
<3ePVR.,#Q:B2D9Ob#<\\UDL4F>bNb1.5GIIBJ[+V-V_13\]M)1JAHEXM>&cP=cG
[O#L(KZE&>>KK6C^]481KBK,0ZGH,cYeD&17,&aXY#X65(C-2V65#PJODQLaZ4a@
46Uf@1PVLK+<N/WOU<N5(4c?Y&@JTM57cJH)=F502=YTEJ^>C(Gb]a.;eCQbN-N;
,)M>5_,U\CfUdRPP;9?XeHW3VW:c,;IQf;VI?[J1S=CaF?1L\+_0f;YIO,CNAYAb
Yg&N.62g<I>QLbS)HE0:0H&bS0CT^NK(b.N1N<01[f-QYO](52e_CS=)5g:1UN-2
d]Ba4JGLGTX#Se[XR/EdM>eG_9#_#(0C,M00>&6FPS;CKW)]HI0#7X[CgBGV,_S9
U>.B6QI05^:M+D:b,TRW_=5_7F6[=\L(;:TQPSAI(dL_01FM0<^(5XP&FRE^.CaI
LIRR5V+a37G2-JR;O8W>#:aV#I8387MQX@H>->5<)?(61(ZeTQIB:3d@+Y8,bWaL
)37I(S=6VKaM]EcJ4E=6;d]d)B>WB?;)RNf6#eC0YR6HGWI6(VH,._K;\9CG@E#g
97YI@F/Bgd1B1]Zg29P>?=U&6?[>^D\<#&F-&?Pf6W)f(2/\aZAd[-7B+XDMDS,/
>TT7S+T>6e<f(=6FC#@MR^cM4X9;<P0,1.W[E[-_T>&0F\QED=;]6NC+/BIg(4-5
KBQUBY[fZY8@8C5Uc2JeE\PHc).X,>&=\/\4H398V5L[;R<E<3-TI9B/AC1.>QO#
=W--QR2)+BD)/5>H.(g7A++BA\#XLORHM-C+1/?M?#7fEK_Z@3KO>Z;dZ-S009-&
_5efa.@K.@<>)E=(.GBF]G&I[L]]NDgT1?#O-U0KJ(9>HV8],&756._D+Maf\&)N
D.@L8]M(=R32XPDecK;+B35WQI4?fBBOHOKW^NZ9ba5WgSAA&RXea&O^=K,Z/]:R
@[&E4/J@\XE(SJF5)7fEFF1AZ^PLD=UV-Rc<UWFL1=;I8:eb;aJG52?7(M.c\eI;
RTeFaB(/EMe,H?c3QX=Oeb.FT70.2TG,_Z[_9TT_U2+,_RLV/Y&HA_dA=a(1VUMH
@DL:]8P5I-0QRcN+#e^MR^DZZ/4gNbQ:F1G/66DBBJO&<a3^<#T099_W=#7ad:8M
A5-T2/He,Bd4\a)(#Z<MXA=>P]>OdgO_?.#T2OB3)@6cUW#J[-N0#GP=2D,LF,g7
T)DFV?geGWSaO^_#A(:/:9I6NN@=1AL:L17:LSZ-8MOO=_\)VT96:DL(H8E#HM++
TPN#JU:Y<UV>.eKba#93fe^LDN8PZ9E^eO7=f1QV/1.R.H<R/W[RLXW&>dcXA436
_YQ0?a0Z9fW_E6Ted^79XYaRf962R_R/;T2G9J5f1^0:M0=VP:UFeJZWNO-bX]&1
QYeX#/F>78L74+-]4XaZ@6Dd-ge.UR_Qa(R/264gdB\8<.C:U#@)C-2&Y+B+8P3\
HAbb#a?I0P>CL&/QB^6S)U&P5C8.&Uge^A,8YUGV1+I@?HTG/P@3NJF?#?H.c@X=
IXAf+GUH=V/EL85(9RHSdZCaG\N0aPI+YOHJZ(/5,V<A,]Z90:R7ZH_9+R91=)<P
bB&6B,A=89KCW<OH_[G4.Z#1Tb_^T<S#1G3F,f4@9>F;J>[0Q:g[)<b:F[POcfQZ
+7@FX7_;+XB)E=G:&bUf@c9G49IO-71P57gC<#((07<@Z?aQ,d4ScZU3/K+2G\^b
3\CNQV92AEg4VUaIgC6dAcZ<[W#@aC0T[5<C2B]S&+GA#;B0Z3DP)2T@]a#W+#B3
&I5gP&[@\R&aPLES>(R5Me=db,L1VeSDL4gdY9]J[2bO<YMC&-2?bZM.KC,BI[SN
7.YF37TU>BL&9(Y-D7&K>VS07#d7]C7</YRJ3=aGT:V,?:U@0/M-fP85DV+a<L91
@JGY[&bJC4AL>C5^;P;1c&H?=f6e2ObZb<&A(RY_G>TVPgRD<_g.H0MGX6=7#AcS
2P?TKg3#dWZF+F\Yb,^8-YRf;K8-fZ]?g;W&UUMd<dDI@gMJg)b#HOaUZ]+OP]ZX
6B#V4-BRbc#0CGc?FQ[(8,.@:=]b0Q?N:E2DQ/gM87/0M0J-P6:1g9;5^.XdcC-D
ASLY<TF]:<X6.F1>MAM3E=K;W]S3UF-85b6?Q[:QTC,.Ib4.9?O+c?O2_H+7X^C+
C;8GN^A:KgbXVX(PVRUgfP.,I,6Q6?XZ<XRa><W9ZXPM;-6?/gEY(eb5(9ee[X2S
:E\XUP:\8.:J\.Tb@06Z,Vc=)9X3##)aU&L4[X(HB]9IR[MfSRDgQKN9=dZ/gJTG
dNEDC5AM?VV4+M>^+]Mf&Ab(N.OAKG\7@^;?>&F726.-J=+U1g(_?27G<R].[FLW
[@XL8[.Z<]cFgC(TOcXYJ)cP#_aTg-YBYT9CYK.G#Ma1FfH:dP/Hb7\81N8;3Fc.
X1&f+6,]g2/Z^dg]dd&545FP)?eL,F7IOQI9<<<3KZU:]TB0.H2ge8R9PQbZCEYC
,;b[2^#>.7?F5VUI-I<>dJ;b&&Hc0Y;]V)XOeOPW2(3/1O@+U^Y#aS^LFYA-2de8
_/QSFY-EZ88S4#/P??SQc4,Sc?K@A<8ETQ_^/dV925/#+@,1eM+GV8g2^fF,M19?
?dgDZ:A(^M+>dc=N:LaMQ[_,KZQ3dBg1:^02>S_1MC3(<,W_@Z2NW9)J5AgF9DaL
]d.g)02aa,;>DMI5[BcPH>UC9UL52J[JY/S;3A]:@6W5d4E27Z5KC6g\&W368+ED
e[S(;G(OTK4f/BV&RK_Ob<Kg;[N^P;c0gI)?68BeT@+ARI7/gTMC7c_3>a=M)7:M
c4H2F>D0E-8=&1:SDf>;1.)\O;8OAb.\<ABg.^aE4)-^-1Y/S5^D6GAQ&-G)cQD6
^81,04M?W;A0F>Y]@]FgU[SH^58aTZLN<Y-FW@b>>J@B8.Nb<D4AKPAZ;US<_KBd
7>Z_K-bTLcP9YJf<V_g<,FZDFNd:+UY7#U?55<THY<I6<&]/TL3Da.DdE5Y&]0:D
I/S@MT=CJe/4a53/NPWWBLgLUQ-/[dW[^93Y[7TTAAbW?6K3SGJ9B/ZaC-<6Bg2_
EcFABUaQ@BG9\=F=S@P1e]MVL3?&V,-&V?,OZ+6+Ma93U/a7,6S65<eK;d]@W59V
HHgF^L+&P?f=H#TgCOMa[=R,bS,dbeWH>0?MYd&;FGYMYc&EW\006_[A1^GcI04B
W&],R=T;\HaQb3Z2?(:C2Te#;-4OJ]45P6G1d\RZ(4R;-5a=YC8^P?Ge4ME,TY\6
;2Q_NDCV+[#03U4H?4<F3Xb5Z6:?72J.L/[R,I1WX)BX=++-b]Q)M9SWKLLe:)Wg
T__X4;N(D>:3DR[>-=d2U_;\K&SQPE3.1R?5Ee&D=d+R/I;<L_Ef5cA,&Ug_5EM,
F<26O01P2(b][8A@geT=P:J#gOL\9:cVTeVT4ZVS[:Jg7@V:HHSZ-VEOg?(][A8L
6UGFK5K,XOJ:S_?1JQ/T2:FZT@+>NW(XAdPUdgb<IN1H;f6(Be@Z_PTD[fB4efRK
42@8QD;+?cEO:HG9HTaPKDE-IF>G/S:7_fZ5+e&=/[Z6DI(=e9GC(4=@/]T;GKa8
36Y?5YAWWGIc#EWYEfZWHC[-gDQ,]W:YB1[3PE6d?DbBe&8@adTa@FG91OU5R87E
P]HPJS)9b;f:F1^HPAYV7geV=G/ddTN:U@]cUC)4J4N=B/6^)N5Q.a8CRfRbR.P1
dd/>L.a\+Cf5WD&/&g.A2,#+CX@VW&(M(e;5TLTSG]?G,6Yb,Bd]CdN@C?7?L8>a
[fG&T/^PE6V.cWR^@X=CFa]\Y3O)M)cHG]a<;Lc9b4?#2><O1\-gKf5T[)aXV)]@
E)eLg^UX[]g17BEbTEEA93V\I;ADFbdB0S04ZU/:L_U1UT8=E_/;52TH0[F\/Y]]
LN1J^?RU\#e4d0/EM]I,5:5cXMO5G#QUbH2@J#LbKTY(;[W(Y0R4GRKI\\R6F3F_
I6AWLg_+[J83CJJWb:Q\NE:M]_@WX(J@HL\JBN+3:)-^@L:H[34FY6(H]Z/Af6-G
\ed<PX=Yc.JC95[5gSf>G56Fg0)].=WD]^C@\H0G3aO</+D@a4D#<<^>#0UgF.(O
P+)TA\A)_>2C)$
`endprotected




`endif // GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
