
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_slave_monitor_pa_writer_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_slave_monitor_pa_writer_callback extends svt_ahb_slave_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;


  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time =0;
  // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time =0; 
  
  // The following are required for storing start and end timing info of the transaction at beat level.
  // Stores the time when beat_started callback is triggered
  protected real beat_start_time =0;
  // Stores the time when beat_ended callback is triggered
  protected real beat_end_time =0;
  // stores the previous value of beat_start_time
  protected real temp_beat_start_time;
  // stores the previous value of beat_end_time
  protected real temp_beat_end_time;
  /*first_beat_start_time captured time when NSEQ/beat_started
    remaining_beat_satrt_time is for rest of the beats in the transaction
  */
  protected real beat_start_count =0;
  protected real beat_end_count =0;

  protected real first_beat_start_time, remaining_beat_start_time;
  // this flag is set when the first beat is encountered and unset once the first beat is ended
  int first_beat_end_flag =0;

  string parent_uid = "";

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer = null, string name = "svt_ahb_slave_monitor_pa_writer_callback");
  `endif
  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
 extern virtual function void transaction_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
 
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);


  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus
   * by the slave. 
   *
   * @param monitor A reference to the svt_ahb_slave_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void beat_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
 extern virtual function void beat_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_ahb_slave_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_slave_monitor_pa_writer_callback

// =============================================================================

`protected
#2U;ENJR2IOg5XPKdb7]MfSKdfIKYWC=_4GRC+aAe9eP1e0fg>KC1)JZA.E&\bCT
&.G#b:C:X;PPMBS]1\)XST9AZ=N22;fcWL>-LC8M2R:&(BT@a;I61A:@_^6GADgE
YbEaPIG46(2Y#0cR#dSEWU1QB-C/4NKE8<SLQ7/?Tf^(4)(IG6A/g<E_)F@0C;9<
Be5.SIOVXBF6TJcL3D6IG5<P\H^E=COV8_?e-<WPR+B@Q-d1/(>8#R-NV@_W#U[7
/ZW(H5T@We\P];6aU2fO(Q>ObV<G+=9=>RBN&S1L5YUe;ZQ+O1S2R\;:(,XDHFLT
QSM2W<J-:4G?d-JJS@ZM6Ua@N=/Q==87,g>-;[XQ@##(\K^M/BP;?]Ub>(X)N5#:
(>&#V-M5gERP9[;S4IV[]UOWBYL)HU9Y=#EaVaCOCIZ>O]5X\,4[+fDIOG8VWE@6
]S,W2&HH1^J-XYKD>4]BF81SY&@G\VP-4>b#eF)?\T)+]A;::><S(B)cBc._(?gf
WX2TeEP6OLd@901:I+/3R3@YJ1098737<$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
WO:W1cNQB6^.Vf?fQ?Q&g@T51_8(])[J3[#fc\ZAWGU_3HZUgLd&)(IPJ>_8Y?7e
<XF4P1-[fCVR=dZ4R/QAfXS18f3YG,=;aZ.ZN2&K#&LYCMLK)>(OS)0CTIEb=e8A
7I,[G3-e?<+a^\U^Q,QYJY>NaL(6S0L2@,aPNM;NFOeg134LGOf=U(/PX-;J]U;)
bgdD=#LS5L]f<]Oc[f8_J@_OgBY:=RA>897N-8(ccA;(a7UTCU4PNg:EPIYJ;RNG
YQHX#W.N^7=A,-:/.T<20XT^?5KFVC(S#A7fEK#:F=X>0[[]FZXHIINS0L:+T61E
+<\E@,#(2X=)K3&ZG_]d-SCY>^45Z;b;2#<8_cG;>OWSP\gCZPMMQg]3/VF6RZKd
EI74<_085RT7Gc8W-O4aXC+(/GXe\AK(/=gE,#-bL:HU@:;QW6(&eH9+UbFL#XEZ
=]R&T(,.V;AeLAHLQP8Y&.X0O6=A_c+C^=IQSG3O>R)(C4UXE]R9DDA.]e9@@X6&
8Cf-5LW-)Z-R7f/&-6QeK;M8Xgbb/WbA;eZF3[aX+H3R&8&&T=7UIMX>2^2(]7]@
=V#TKYTWeYa[)/H4V\PE4M3UYH/B-]2)D\P3N&d4+KX-E:d:/S(?JRe<CL-92RP)
]L1f\F\faQUF=^/B9/;RERQ+5LDZ_5VV5dI)NR(IP(9]K9fGT+9YEJ/[;7HDbZ0.
BJT0(Ga.e5-U]+ZV]18>LC^:2UM]4R2g5]Y@a8^C3NK0[,3:M^Y_deFfI;I.?ZeH
40&7#0=gLP,J7JW>A4IMHZ]2f0;,FZ&,:IaE[A+^E)F)P>a5W6:9c:1dV&2Fc^C4
VYL.LB<@MR2FM1YVH+0:aTEI4gP9&=a0bEaEBbG#]Y?T/7fW;FY-M#6W@:YS3g>0
S[Bc+FYD.JU?L)>PBga]/7/D>Ad&d74W015YE\Z4[<gU,H:X,#Af<1EROfT?cbW6
I>d9b6T12M^L(T)<.0I19)S6],9+42PS#6DE1a_[-e_]QE;<AY8_QDKGFe6=fbHV
L?Q.#V?\A\b3YGL7?1TPCBF5YRFUea=J0fUQC:^-?Kb,(We]VZ#gQ@M2FZa;M3&]
.]5_&_\AZ5-GeT,.>2aKM\_BXFGE#;KU_DA:7+O^7#6WNEQ?SP8fJG+O4fR0WLEO
ABHMIRa6Q>BX57-W>6]B]CZ6b,-.#&8@JS[8,G<X_RL0c=RfMMcWXc\\NGD^:>_&
FUCgV)Wg:LZP-N_IdeNBUJX8:]dLNC)D?/d0Y>2c(f3+fHJ/Zb6c2&\55WcO^a(L
LLJB:+cU2ZgdZ]K)6N^]_Y0de(S<C8^GTIOOAS-[G;GAOaA7^cVSI1KEL@@LO=eD
g1D1ZKF68LY5_<D2?K^=C]HZa>\c5M_GFf[6_LO0VSP<_,D6+OE?+AcZ9OQQRRb#
#]Mc9[dCRb/f^+Z6S&^U>5dEa(#?e2./L/)R@8/PA;..FRZ1F>g&Z00ZB[XB)HBE
W:]cMfg_T+-.Ib.b3FfK_.JP>2VG(V[:aOW\\1Z68=FJE)]?DXbND=M4C=bJ:1Qe
f<KL8Y1PSLL08L5==Q0U/]5(VV\Xgec#9,M=AfEAB-\CcY6FLeF@7F])^3PZ?/,V
c??[R>1AEJed(RC-=\73@=&-MI:JU((4.H]>@WR1#OJ<1R(9.DT52R@cN>^L2/_]
d,;?0B/:5EMcT],0[g#TZD-072?Z--6&M1(+T9/ZYfg@+#\3V6B&LGXHC@0,0]7c
YM28O/,]8fV#c/.T?<CI=T,78+VL&@C1@VfLP7cROKB1b_d@#63UDU,51Cba>dgF
4ZLNM=(FK0QLGCXf73Y)XBM/\e+86OS.Y5B4EK<IRKMM5H2SeE^.Lf:ebSV55Q.e
W8.X[7U8:);+gY]VCb.X2O]Ze5TBF0J3(:PSb/]>BPMB^BH,TdbT+]NO_K+(WZXN
0K8-U,1JH(^]TK.?@eJaP+9cTe?S)-WdP9\B\<O:^ZFUDXS^ZQG&DPVLL:43W^cZ
AgJC>gEJ2#KdQK+Z-6d7([aOLO0.EB<H^?WS.,O-?fK9^Q_.9KP?I_+09.6BD)?2
4+\TGO\?30D,=[;37gdEWfOcB?JUA[dZ?2b<33-UYc[,0:fR(J46,9FFe8aeRNIb
N^MVH6COOVfTGa?Z:W3/L+Q5[f,^^G[&@FHe<5/QY^?,Pe6G-;][@MfZT(gV0eP>
<HQ8VeRb:d2_)A/WIFLdI_bFW(M(:9.B.4BLQfb4I&:Q+L#gV+Q[9#\HcW[S+S?F
6)b7^[-fa081\23&#8--UOP,UO)b25/E<U=2GDeD=/(3F)a\=KR)TC&JbO]2adHH
V_8C&6Y[G7GNTI#aN@N-XW2H.62[ge0a=4+f\5C8DY@+DX;5JI9QcB[eA(XF-3?1
c[I/S[bWTbJE>c0PU@)f[-@PIQ=.OH&_+?X+GaLadKVV.aK[<dFRX\#78H\7E<=/
KXMQ;\TfTTQM9;bc.eKAQ)Od-gA^0O_;6JB?WSARL\cX^6PH8I2RJ0UP8/f<3J.^
>2;FISa&RM1Z5M39)J<?S<&Sb9A0#dVVXfEPfXH#W-EZ;N8/4Z)X9-4B><0c5D7e
+0EY/c?UTEZMZSc&:_.GcPYAdffA4T<E<Y^XZDQKd4VK<CI,^)IGTMXTC2bPL-:L
XYB>LXb_II:W@90>06g2gJ^9I3B0LI/7I2\g4gbMAP2EH3XTS67RSZ;.A?Q5)^:Q
Zc2[d5#,XI_?/J.RM3TV6f5Mg2A^2.UUg?e5c0)(cY]NAWKa9^D+QJZZWdHJFaQP
B5#9SD1OX8CQWL^PH-JMR>)[ga83]GP9KS\@OP=c,eXHA&d;SVR#\M.S>_e4d-\S
>VLcC?P#:94eW6_-=M;.IfD0A06,U&e7Y>c:H@fLJ.2W(6IYK_YZY,IBZ)WHaab9
_@/gX6Q3,PS9RE\DCUUC560@>SXZGY5ZfKZ4g\0Iba)3RN[Ma&68ZY4bZ&b.NJgA
R+44[[[-Qc6#&?XA^gZDQB&7)4TTUBB7b-gI\6?TV:?+V<#K?45QbM&/cI2F0@TT
2,0Jd?BLf@HffcUDOFcDaU4)Vf-OW/BI_GX,;f+aL&M#5f89d8.+669T/Y:-(.Y.
3[_XCA(P?G&9NZ1O9FRI=dU9AF973;fBAaA57G;X<32;0G&_9D=,67=P];EQb]+a
_Q^Z;D1(4Sc7[gOJ:D.GU8dNf3cX,5UXf4Ze\Y@afge:BX;DU25<1LLJDeLCYb;+
RU?G<+fU42US9@>X1:N7gfeH9/3SU&b)FLcB@;Jb;9JMBHO-aSOc;4MG][RV.\(C
fcgV?/]0QFVT\39<YTA5DgcQ_=aT?YSY<2R8FW9f46MFf\BU4:ge\ZJNbUK]PX>S
-W)_Z(CF.@aBS?P)_[YV[((MF9e_)>&3dN3@3,-g02VNGa:3#C8B?ff-:P6P?Z9]
eKf&;QL0dF^JAF#+YT)UZCd7?SH9UMU_Q#LEBePg1Z)0a7#)#YRN9;QS1IRNdA,N
0bb.8/3X?U>A@LQ\R8GD@DQ]72+2Rf/,&YNTc)0P]1Q;f?4E36YW6]S]?A:-LP)G
b5,-08H>KYPA,A7;@NRAPB)SV3U5?1UHL#5<0P2T-^PU#?<T?fDS-:7f4+:?V(4@
UD^;6-N^YVQST;f@PcV6;VE)Z=_\X?-3VB&KRIX47BK3=>5_.6EG9LUZ,+Na=@=7
Ff&#4/XL]N9UFfUc);/BOK8/ELP4U[<?bZU309PCPGY(0)V+dZb,#8E6^,E2EUMY
\.\\@<N\PMZ#;JSGZAfDg+HXf#G<?8IBG<<f7.dYE,&EXZ7W@]g()IBNW6A/:^.?
XMbTS3_a0&0KGFNN14+=YE=87Ff\L5FYE&WVL]aSY;V]YSIa@7?,U<ZPJ4OOC43T
[C?&/SDPU;8g67>>C4.^@Gb8[FVN<BegP<:A</C_ggGfI?>.OgN=-AN6<BBV?OQF
c_W.bP6.J&gc55H;[SU;A]QOb@C>=OU7A7D1AHH312de>?<dK>ZOBX.LbLePDZ6f
MP1U#0dMFGACd0eXY#6C,(ed4aM.0b&LCK(659fDg(Y>G@/VJZQcX4gDHGSJZ]QC
)X9H_IXF+V,6O\Y<D/LUX9aCY9VSTR&X6HeYcJ.fg+>K^RK[XG>#cY9EPb.Zcc>P
@GE(L:>1UVY:\]>cFN,bZfADZ>,bS\b7FLAe?gNGaF4UJ^)VMUDcD1NWEM?+^>I/
\aIP#_XRP;N9V;7g(0_30AJ,X0L_d1J:G8E3T[+#9.;\=bT-9CRG]5<83.,B\P4F
b4:G]&+[+,^]XM&N4^]JKFSTZ1QcR=&9R]KSR/5ZV:BbP>4c>^55]+Ye^dKL&V4J
ZNB9)\+W^9DNFB]J;G3GQCXA4eI8&Q:7W<:<8)X\<8B:(D?DbD5E4PA.^U5PU)1+
9b+Kg6V[L.S,C&;-c3K8J<=QVFXR[5LYU4<L]G88fAPJL,3?LNX,RQ^Q]a36L(c.
YM7,LZQPKRfCLWF2aAYaD/R2KQ3V4gH5/[FK1&c=H69/O97E/DWG>d9L<b5a0Z?0
d7Z>9-Y)NC\FdXLVL8W5&=.(]&VQe0LgE)6^4@Y\9+2-ZLa,;T\B9&56XJ[++>I,
f_GT^YW;3:UO+2SSJ>.C=4ZPT](^J7YMe7I?G,SP5E7IS/#;/Wef:)Z1DV>7NFI1
:ZT06<d:9+bX;WO]bNZeG]&+gEG3L.=.BIZ_8@-SBgW=OQ^@3&FHK8N+CV0S0C-U
J5gVACg01P.K54O=4PG;)#M<LJI?+Q>>f<1E)=TdXD<dTccW83PLBX<fMWO.]<<]
^^+86cb<([g/dA=MXV;1PEG/T_d8c>+eBTW9:Jbe2(?0J94G2\TH)3W#@E@aG/^@
DB7Pg>G3T,BFZG+:8_f\GOK<:1VI?\2N?3C@;^I4#6AOT68_D=+-F08PgLCGe#Ic
1\G>e1<K=[BN&UOV\:W-:<P:<?d[fZ6/a@a=@<CRCd;&GTP?V5M783YZ>caV3U2E
N842H72O9.D.+\cU]=2_+dRI&dT[-)ZBKGKP/Q3.Y-KT4M2WY>//d)K3,\M#T70E
LLAF04BP(,U]T:S+=TgP^;N&1?HfQ10U28eLZ6\4KJ:_c)-g\;15J9d<BZK3.+#/
f4PN8SMKAK7X@1bHO4gY(W;XH_ZK7Q=b\QPdAJN1gLUAKJVBJ0H+Hd2OKg9QP+/e
R/E#)5\P7UB-U68QI0A?:_=>UH&ISJN\Q2d[G_54^]^1a:gRc<Ub7JD1A-GDMHP=
,+-aMg)39QADcK@DICfJEa<NV^&fF-^A\4-KM]ICa891[gH&]NL(KO:-GU]_&7]@
]1Rc.\3)Y;J(TTDKM526EdB6AO#9-<H@@6#7b4aA=bP5gcG72?V@RVeNUeO1:-^8
d/W5Q_7Y2\AO)#<;LO]VT;=J@03@^VE+RDHW3(?W^B_N.YG0SgLfWU<B@8fE>99e
c>Z+UVJH?Na>a+_/@B3Q_83>(5KQMZ,PVS_8<AP2ZLUFXK+(9:Z;9#DgE;gMK\MS
+4UB7-4d&IAG4H,5S3,gE8XK))[g;ASLS64eg6^M_MeJf7OCGWL7O@eQLX-N5?U/
T_OZg:a+>_?Rc8,L8FbdVOb1NN[R(1)>?b4BJ3U2>RagX.M+P09=+;,0=c6O.0\0
7C]>X2H5T6DNT<agb@A^7A880WYJ:K3PG;BA\UM=UDB5-R>.4=YXU(NQ,X(GTLRc
#I0IXSSGVQU/[NS#.G,EY2X5(7OS9a#:_;W8#RBT8M27S9P0[+KIS59eS95b.__g
6(cK\6327La5\.aU-^I:Q;B@L#G,WMS7TE&Z;</eKSa.PgAN]3PSX_:^B;,<R/3)
aDI+9GU,XUd&3BJ^B5V<G.2JMI3E5#512Of(.(8aUY&>B/LCF;)J&dDSRHS:^bF5
Z0,].R<6E4D8W(b/E7#OgT1^&\[=?T0;X7+4=RJPT:)a_HaJY-<-81LNHA@3.]P1
6b>aLC997a4C/J/+Y8N+C_Hd3>_e<;Q;N;R>MX(Y,Y9T<26=1,^?f:QX14YAaBMd
:>O&96K/3R7E+E.H-8?6/1\cO<E^1&>1@\eZ2a._.,/E/^_bGNb7T/PI17Y/ZB>(
S_Y&/<BQTFX[FIC#2Y_QP>+R26>@<[LD[KW?&80Ua^R/NN;d^G3:XA+F[bW^Q9.6
gKPRdT9S[G3OP?0XYTS^:6_^deCH(?e=F:La#Zda+AD&8PNZ#3cKJ<GO@d&6e_;,
VUTP>J8Vd(\,A6<cY:3ZR:X1NWNfW##=).?&H6=>L?-gd86,U@R8H)-[7R#VC68e
KZ.;BU8J5_EPEBG2HX.G9(,FfIKK+C77]@1U[._<UCM\<4W=8-T5M4IRF+W>N82@
##]V-5:PbO4Cda6KFM2BeSZFHZC?;2/@EZ^^6G.b9E+;g_R2_aa?f5Ze.NfdbK(b
;T;5O_b25:CA5)I#^7d@A#RY-YGHb&b6:<XdOOFY588[VdE(>P-@b8CWB[Qb<#-1
J>R]g+IAY/JL.ZNR\K9@C=5bKA_Y,1E:]/=S7C(VQd\R9K;<eYb6?W-:S0NNXXLe
8=\XR&+#;ZI,ARHSNQ)+\2bOA;WID,P8;KZ=a>]K7H.NCT&dN+,JVOJZQ4DEP^(H
E&E[LZ0eE#.fKYQ3(>F3W@<VE&\b^^>Y<GJ,T(V#&fBBOD<A7W2:RF8\6eS;@V6P
YFYDO[AE=31F#L[_L?7Sg(+2f,]:DCK;)/AN>08R];#9,[a^G+1K8^>^E0&b#@UD
^3XB)?.S&g2A.8L1?EZ/e.K5bQ^P^T(:b8R:<Y5IM<>]G7)#P@A.(C]OLW=Y.U1F
6a[S)\24W[>(R4=6MQAZcaGR-.9ZO7-1f3G7gF77F9NJ4aGYP8U,8W-Ta2O8:1]M
+ZYWRaDH\7d#>[]1[\+SMPIEM+4Y428a]F+W9Y9L=KgW&7g+94TTMCJBWTNJGJ6/
73R3LLD=2V.Kg,FSfUU\.C^8T^()[5VE,ONTU2T0TaE#(gPQP_X>G@[4=aNI>f[E
eN;],S#cF957;[P>f6EFK:9@7V3T/80/X2HGR<D7F#P@N95Ya\[X4b3G]P1fK=,T
<-eRbJ5ZVX\gTXcK4Wf32W>:KP,Nd@:SU8R&G1MI+2A5\]b]S:BcX48#,-BH?bZ8
.49\67/AN2S3AM)-9#3TKG+OE<.gg:RAZ#>>N2.J.BI_.Ge6:>cM]^U7OF_.<NJS
,NT3fQX9@.48e\5@XME#cJIHZ.;I.GNK?(5S>K7_#\8+)KW>=PV1bFI4ZeADP.N)
;>SIcLDfVKI5X?Q7<fe.<,),R;O;O4K.aFd^.,fH6)aY:>YP8YTYa]-aH?M3+?:e
O/)J<,R@T(W2.R2FNdO0M#^]FK/3dW##K:4&)1MZ2Dbbf);#d[>^2475\1M_IV0.
d7A^::?=K6]3GM,J@Z+5=WJ]X6KP7=SM1[MQ&:;?fDH,d\[0QeP[7=R<=49+>dI=
.-Cd_IP02\aH8(#\fQ98D@3Q+]fACOd<G#,7P62^LL3V)I60S-.fPDMb6K[W]-ON
,J;IQK2]7^B<&<2a&W=;beO=+Z[I.L>-4cd^5A+WHG<W(C;XWEXfJ<\9^;f]-M5J
<(IKOX3McJCbK.bHO,D_6TMJ->bN6C8B\31?MX,_b2I7.@&^XT[Df[\\8UG#dZ,d
<cYL45g/=agZPOc[Q@9^bJ&6dDg&ZXL&=-dSRSA,Yd=b8XR>PN=^Ob?DB:XLY,0A
CA;WT[MH]:FMNNTTSS:(,LMG?3RHZ3I446W[DWIbaMK8-GWB4#YZT_+9g^HRaC<7
J1/=Y(F\YG2K[=3E6(W5,KG1VC8gS&P><QAM4MWCg0F<J3VL<;JF4OG]U>Qb_Q9d
a,^OOK84<Z@EG25G9KZ5L@A;_[PXP0]#[4XHfa:\(A+=:W?Ye/9,>&#QZe(NRd)>
UXR&SQ1LJ\F+@+A><GWN,,A;2$
`endprotected

 
`endif // GUARD_svt_ahb_slave_monitor_pa_writer_callback_SV
 



