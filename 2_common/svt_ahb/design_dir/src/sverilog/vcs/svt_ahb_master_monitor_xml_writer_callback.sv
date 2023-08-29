
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_master_monitor_xml_writer_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_master_monitor_xml_writer_callback extends svt_ahb_master_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_ahb_transaction ahb_xact; // handle to base class to generate the parent_uid for Parent/Child relationship in PA

  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time =0;
 // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time =0; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

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
    second_beat_start_time captures time for the second_beat where the first_beat is not over i.e SEQ.
    remaining_beat_satrt_time is for rest of the beats in the transaction
  */
  protected real first_beat_start_time,second_beat_start_time, remaining_beat_start_time; 
  // this flag is set when the first beat is encountered and unset once the first beat is ended
  int first_beat_end_flag =0;
  // this flag is set when the second beat is encountered and unset when the second beat is ended
  int second_beat_end_flag =0;

  string parent_uid, transaction_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer, string name = "svt_ahb_master_monitor_xml_writer_callback");
  `endif
  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
 
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends. In case of rebuilt transactions, this
   * callback is called after every rebuilt transaction completes. In
   * addition, this callback is also called for the original transaction which
   * completes when all corresponding rebuilt transactions complete.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus
   * by the master. 
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void beat_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void beat_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_ahb_master_monitor_xml_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_master_monitor_xml_writer_callback

// =============================================================================

`protected
[(A#Na#\2U6MT0T00Gf_2Fba9,bHbI&X;8;X7G6=Hc(T6C+<Q1/V4)d9K^C7BT_1
O2g;fW@@A7W0Z>&+g2XPa/98D1\#3DPaaERX/9X^G:R^I=H<]@Ta_LR:)U+Za:dK
7S@b]U?_[;J<X<[eA9YLX>b,gU+A>@KcgD_bDE9&gUfSV[<<R1FGDYSUC,LQ(])d
2OFT1TLXG2&b4/V,(21MVE0I;4S^KC,f:L-@^fJCS^BV.J6]bR]dY5HGG6.Q0G]>
9AN=I:716;5AM6;Oa16Z[JIX5[ER\]6b#0A#7)K8Ig),7(cWdI^Y;RY40=]2_NOg
RSB2_e.aQUbR4O(f:1GGA2^^^<ZOa_Fcb1(9^K8&+>_9JL_O3U5FIQ51d[?3VaL]
]-@UX20N9E[2;,3W16J6.<VE]/XL&3P-O<DB8=#?Q(Gb,Yg>5JG&aHWNG17E^)ca
C78+&Je:7HdfAaO_-J>379[3,fbNIJZ+9$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
U.Hc#8A9gTa>6N1Mab-790[69ed&LIRfSZG@()3852X\3JLI,,Gd1(5AQ3/F^B69
0S:&KAU@UgE-/8e;+#>fZ[&(fF]dBN.8-?f^K&^(RX-(5R#A60N0,c:fRTXS>,OZ
PVD_(QA.)?;TKR8XNcV2:<X:c.L[2++fgdM\\P-1MG\MU0e@EKI0W=IU8-LH]TGO
[]/b1gW#FE-2&)V>ODg/1:e+,MX>c[,.J?U-3WOfg9[Z2M/S,-=aBU:#6[PK?dZR
F[7[gFD#f(/dE1TGT8W=PHKGY8=9eWC:J3WR)3ATW_PW=C\E7_V42,F:#bN_5f11
XX)W+)[T;_83QD914\>PAQQWH,1BU+W6:^fc[&TU28B3e3?NEJaZJ5]OTXKNdF\-
=FNYQZf^JKJFC6^,<74I?EOA60BL65:@eCcU2_&fSM0)9-UHC[4:N659<A#gRYXO
B35\YJGE9^J35Fd#P7ga<^7>^HaWI?ITMgcOT_+_?d\(ER/0J[#0(c?-+;NYDIBQ
ER2.TLSJMU9HX0.=.[V#4g-\JO9@7b_M8\ONW_POB&=;3KAW0V+]g31T6d5ea/UO
61aYP,9(Sf<O(A9)NJT)TTa109Q(d8X+Kb0J+CPML)WVa:_E08D32QCGZ&4f63e0
Zd-;O(PVJ+cSJcV#S5XeUC&(Y&P-]MW)<<4]U7-=-RYU1ASRgMS#02C[CNRQBD]5
-5f/N0<@TPb7:Eb3>RXcH#A,@L4e)>4N/XWg4+W1c[HU=N_?=6HJ]-M85Z&:\&T8
d^,74BP^GMP>[;=dXS+;4<AgeVcB+Y^_TI3<Y84B5+46&-@F^A74\E_3?HY^@EDU
IJBO-/7>C8a>+D/[CY[8gQ2+W7<5+&X1(BM8VRA@DVL_7SE>?@Keg+CAdb:9bf=I
AB;f_[RQ6fb_I82gHSM5.=\UN(RZN:JEJ[H.FNG9>-C+Q))F)+]4WTc&]cP+WA5N
gVWM]Je4(+b0<N5@/UL<8BB-]E683&,E1Y6(K8GYT6JV@;G^32&/_>4^@V;T^(0(
c^)/G=:2&5=I;_7Sd5(]>Hf9N^1Y5SDIF(P,C<d&</a,eZZVgYTM?IG)bK2P3C:R
:QHRPe:#)LK2<M,[B1\/<.[>_=)5.f4I0BaL5ZO@/09FGW^DbP3N+>]P#>gdMC.A
M2&,V)/36aTf_Y2TL.]d;8Z7aD[fdX26>9?4b&-Zf_5S5A3L?;:351,e3=+LaK/g
RZUOSGaW(4//[5M=>AW?cLg(EcH62UO,)g;F+,JJ(EV[X(6EQ5\CUW9R-EE-7XbY
]\aR.9:-gdf#R6:VK-6=B4@,1)FHSeV@_&IP5bL]@?b2cF9FS4GJcUK.g:1-D2ZG
CM-WWIW/0;^JfI^Q5(W19#_IRG)IaPG9Ug7G:c=aJ0>#@21+GY^dfP8OPX&QHIOA
MD:W,7PTYJ\4LAS=DG)UR2=N^GIGYS2H4OPM])A\a@RTV9_b&SRI7^S^E.UFP3=>
/U_fWZB,U<GX+9@^7R9DN\Ta#&W#2S3#J@@4WB9GS_<C9GAI^Ga5KD0@Qd&GK#6U
V0JDZNcLM<,CX2-FQ&1+2cJ3C_;DG\15M2cUVZB^H<fc1gQDY(]#ef+6[b/I<BEG
]bC:-//RHc6G,@QM#aEHPc_OBa@SWaHZWG3XC+_2KLEb;A2>P.XKaH1#egae8J9[
G=?):FB3+a.02:^SW6=F2fHK8>V)bRU]b)a89:(_8=M3a2c.?EU9RH_TG8bg./0X
&I8#6Lc0HM4fQ>;2BfG3AN&ZKe,@(AVSecJ12>IX,b:5/>-042(9HKS8a\P./3M)
5]_;1@@4U@=7L#L@cY3(&IgTX),^Q(9UV;HSS8SDGcXgcT@6]eU,gYEdI1>VXIO9
BZ=SaAc(N5E.M\&VLgdQE(4P^_L);dBdE9Q)FZKa;Wd/^ffE-PC6eGb=Z\d/VVQ[
<WccE4HNY:\B],fA3N3@S:^H,/<<QZ&@Z1R::79G3X6fGc;dK>19X3@1KXg6^E_M
&be/(HdF1?9.;OPTOEE75fQPX)f<dg#+?-NAe[gDg5e+OSGA-Q9<?L]b^b>>+bN;
C\0UX-B8F/@:cX+GD#)JQ,#:PX]8PBD7B:dXAObH9TVU^NY21ZB#G1\FS<OCQC^J
Vf&JIAMRA@DSI?TCePT<3[8^PKWCb<a?I?Q8ZH\(c1d96.Ea:Q7U8K^bAKDX+I6@
-G#1DU@31KRCFMWe=+a=QBVYGBdXS1TZcfb7#E:PR:^7UT:9XM&^W;8NV@JaF-,V
\2DZ3CE,^-FRYFJW/[S.71_>5R9>)B=D#F)ZM#ZFS3)a(/He[@^=>&09(2QPU0T1
c<a1KB3.E=[eH>Q<G=KS3F,\6#W9J[KJ-gD:SCU<OIMHIY.c+JK)/<R8L4?C..[8
gO#-[EM=We]dUE-28MA>:\S9^9GBE,[.FQCE+@QbDQ&8_OJ7e7.N4U9Y=URI;@MM
9D=LX^d##OMbe8aJfe<ddU4XD;DC4/_O<Z79S63FJZ(e=GcLR^2dga38&2Q>0)M\
S,A55)#A2^XN-;[T+TY[].CRW<6_6@.WCO[BA6G;XaW6570#?fe4TPD9^173P7Ug
YXC:SWL4UE6XXR\0>T+<N?>QMZ3DGHD;c<U;-?HJJE+]K1dC\\U]YLR@(0.g,BM7
/\:eT_E](AgP25Fb(?Q0:BT?CJ+J^9d8@,#gMf<\?=(D^?-2K]?1:BRWa,XM&[LX
.G[?2E2?6e-7X8[QaUBP3?^Q#>QW5S\N[(I]5@Z0HeCBCDAHVY:7#dKL?N@_KK^>
KPDJ0OJ4@./2=1#_V5Z()<cT,Y:7KAY54&CQ8\Y+82W^JIU6H@g#D>T;9&:>c>TZ
.Y2YK.YO_a^>:W+H=^=A51W)P[Ab\FL?:95Jg\\@fffT4FeQaHGEOEE_/e/\-A/-
7^(de7\d4cL7J,P72ENG.N1YSO^e=?F=R&bI3@LV&Ade3T2/TIF[[5#dMQ);S>N.
S[,gHS3D/:WbRB/#89FR.J\dG7E3G5Od<YC#R;=B/V+.QUJF2#OIaeJKcH=-dc[O
V@B<2d8N=LWTWGf>W>?Ab&[dc8//U)EL_K04^49<4M\_FI&<c;)+_c?bCXXA<)DG
ACBGaY:dJ#;(5\U&1UCeW^GL34>c_cbf0+5]#X>N(EP9/YR(J_OCIJ(,&NXa]9C^
)3L1E>B^OZT2I+I\\32;4GF40:?fV;KL5@J=.XPZOCc669;:Ca9A7IJJAFL4JWTA
>b+F>7YFFD5##CBaHdc</<16[<cfC0-;db\FAfML(X:HS4dD,>EG7FOF;+L]X6=F
4Z^O8eUBOI&g3]Ed@HB>5ggFU0,W:-]<42AN(;J>HK)Ff?b4^D@AERJa/@T,_7-E
(H&WTRZB,>/1J,7Y22cg=]^4(#PLgYW6]T-#NF.W3)3,DFI3JbZ5\=aPbe2&Ed_1
a];dceFLSY.dJ#>;U<GU9;c?]S1e(QTef&Rf->g3WT9C)+Lb<c(85.?fB@&_O=Ka
R)+M_f+QWIB/M#],\(M2gCcaW#@,K8B+eHCW.I;6J=8d7#,g40c^TNZFR7.Q;/.;
MQaBJ]>1GW)c<b21<Q+bSG)490W_H&He)[fT^->-^\DWa/H7-DDMNI9_4;RDH&KM
-/0[FB8&_DRWQNAXWD0R\L:MbU;OcXN(?9]@.0PLSZ+c[1&D8Y3US[.K.Mg734#e
_5##&G=/#g@)ZDU7&3NP50gP&Cd8EJ9V8B)^R)faa6&V+GgBg]5K1YO)<;DgeYYK
I,Xdb^UdT<<#62SJ,HCN#A=:)8@+.ZF#\;>M0C>):MeE9(&3e3,82=fcW:+[36fg
I^I@U8[]eG\K?e&\I4I\e=c:C/?g][H:XK,b:[?X)0PCBNC[G3Q>7FIJfQDOPeff
JeI0e\ZXHYcU,-0>85Qe:@@eGUD)\[aIa33&(Y&/O?]-W=LJ<)d@8B]DZ^e-2>1B
T3\,9Pg^TbM,)U_3-aKD@Vc6+<55=\PFIE[[:DJV3OH1(#Q6EAH9O5?#9(HLP=&L
a1:OXOS?\]Y(NMN4=ODEI]LR:(0]&Z&HI>+(/[T[R&ba82Ff1K\EAR-V?G6+3d-5
70,,;WN<6.e42?(f[WAb4]T7b;L2@2<?^0/L5gG9Se2P^GXF6.2ge3PR95VS&SSN
Kd3VYWF0<HDGR0FDY2ZO<g9U#ZWXc0^HJ@]&>f6=gd,VKW^a-<f2@821F#eM&ETZ
B380_BK:YFY)3IV[:b4LLUB]0;AU)?cK@2TAYdZgK0?H8@T>S9;J1#DHE9fH&LX4
@L53&JC/=E4L;6V;Be/6DD(??[CFCV+K@5AXH4D_M-Z7H=bLARX53&IWa1@gN5c0
5bI//DAUdCA4W^gdF,Qfg+c&GV=XKaZH9C4T#ZAE.W-cL?TL[0)=E+LPMb^D_4+^
YD4;<,B,<1_.P93CMC)bP;D?NOC,#_eO5)4-]Ae)GJ=0,CSOQ4I+I#4XTFL#E0K2
7KMWg:M_TLT\#1HHJ\FQ,@\H@aJMW:eOS\84<IA0QR6dJ_MR-T-(WWE97T#Bg?D3
.UC:WSP^I#]S5Q/4N\C^?\fd)E]Q[/6WX85D/S9_44&6?c7Re[5PXccWW&(J_8Q<
+E\S^D4a8GbR]U1.[-^,OAgD^LO,73U5,NbfB3Pg4c^D;D2cGER^<&M;,R?g?b1g
E/NY=XT],Y@RgW:a2871bFK[FcQ&\4.<?8NaA)XON\a+.;T2Ye7)YgPZ+[9;@4);
eSfCBJ5OfAOS[F:Z:+?D;.6;_T(CBSdOF@:-O,YAKeRbJeb_C1_cd43&ENcVIAFg
bC5.GV\S_KF+5PCTE<PC];Z5Wd)&e2C>,2KU8Tc?X0I?CeXYaS_A7g7L=N/.O\DF
8?(IeV0Q?Q>@^TgD5KF2KJ9Ge?V4F[+@M]bH/G?GHMWd-Vf\3-ZDV?\YWNQ6?WN&
[>BS(VJ0#J&N<2K\D<<EX:)a685BH=QKfT):/EO_\Mf:gbR3PGC>W6dDf&7@a/&A
UUTGB@<?B9Q#/-J@ObM6Ua@OZWIEKZW(NXE.a3Y7e&bFG?ef3c5PQHD\QA5@a>dL
#6g1aR9LE5FZQE\_N[;f2\_72F]CXB)8Q-PI&Qg2ZTb2,J1/R;?BNS.e(D042Ce<
,DZ4[AaeB0\)FV&NWTAPGR<DPB@U@3NKETD)B>3O:VMZ[6,4d8Ve.,1He[24YDA6
J=X<V7RBf?O=FJeQdOY(2[DA\F-3TG=;9_]#H(LU7DHTRJfb.,HdK8[2-Z/6gg^e
.U6Q1?X#EW@L[/(B4(C_0dHAf)L3<45.QKP&a[MSDQ3ce/QVP87^3Lef<Y8B)H<G
&K;LQ.G8<_I5]Q7L;&:cMe.)2[e/N([9MGaOOd_P^8-NTeEb[6K).;1R#5^G.N+>
J#acPgAOL29L@YO(MgBGCEg6P5WJP]1f&4Q^UcAP]3aC>IY/9cRG\ZP1e)_AKDMY
8;@IdE[e?(K?>IGC[g+VEQ#@A/&V.d?;9;=S26=UgMAeL?)]VKB+0E5MIT.#,C_)
BH+X^f(&g(a(da7DG)BU,\1P3=a+_VHa&UUJ3(>(2.b(J+a_(>X^@d&=&4&+HES_
UHc](Z=IL8:I.;LNLTI&1dL5e(WK0PABdPRCR9.HgU5a6abQdZ;+E7RQ,ea;255I
3OPM](Ec1#fC?+2&JK/E8M5aJNQ(^FC(TLL5&-N1UV?X/.^(<\BA:</:V]cfE^LK
FRVJI>C^J@2gU_C0\SOP+4Mb3N2HR_gXZ3&.B?)#1O8d3gbVd>0O#[7CFK#Z;\P&
G=X6Hgb<DWd,bKa?Eb5.9K(a4^X9>eY=MeF?Mc3O9,4M#WN&2J7MMD_G1Z=c7R<a
6Tg7eTeI[S_,N6H\38_?#L\F\e.;.XF:53^KN9A@C>R=E_YYf9J.g(L:R+-TDG1Q
ZSQ(bJFI7Y_Y>[DNO2ZfG:G<H#P9NI4&/EJ.,+ZSLM3?<(--/H6IU=Y;^2H[\:\T
BG8^U6#-?I#)@]W_Ka>ASB3L83Wd<eZV4;/NU,^@=.,IVVX>T?7;SEWD8&b0NNTd
A)Kb<QZGBPe9f6C/:>IIgE;LB(.L@g#c_=YIEcS8dSA.c?:]B+gVGg9c]OeK2J&:
<&gd=DX?#HR>J5\M_J-8LB;7&&GZg6&VPAQ-1+0R^^+EcF-5M>[[ab.&:NIY3eI0
Jd-bHggYDY#)#:DR3BZcMOT^^J/E3\]XFBF.K/6_T(1:/d?Y=#4g@;QV1TN9+Af^
a7<f.R?Xe9?.:\bBK2C7bRK5cB77_+_-/MJcO\.+\U-_Eg3?8?b\&Q>I1[g4?^^,
0AK;W9b]I27+?+XFXJ_f_SJRTZb:RE#Z/<1H1BV&IO,<N&_-\B,.G=Z72>UH0cO_
-Qe.&Z6?;VEgD;=gM;U\Z@708IaQ]6d=eH(V+OP2E[FS;SUd?LU[C0/409G@L>EB
61@GY,C\USd49Ofe772HTGDG:L.KTJT=-)VIc^F&@]Ye?FHeG&J&Y6CU,F9,A<5@
@.?K]2,630K+-gN0002a@@(KFHFUFGZd\TSAbYeGLg_SR0dZ:/<\D@/JIa++T^WY
)CXOG1NCS2g]B5:63_+S?.MdEGI\JFA+:Z.)YQdTJ9]H-4#6dADb0RW3_>e:eYQ#
=e]Y>HCa^PROU:W0]]=^=7)7EQVV:PX71RX)WICEF7.Zf2JJ_AVd-FZ__1>&H>g[
B.9#LWE=?.4D_;M,^=g0+8>^T:5f8]Z_.&<cFFUM/AQ-3]E??WH)XF@;ZPf76fLM
#+7[.99_OK?7SJG)E:FNKAL&(><5<SZRKPW)X#9dC9P,LKH>++>Pg8SO&6I_W1?H
VA43,_0+35]I]F@<)CMM_b61K:5UFG@WJ)V-I?55]AU-(XVGcCQ(MgC3EgU@<7S>
-/=Y+,fL&Ea6d&+bYf;4VTBe\]I3=N^Efda^8-g#X>:8-IN,M.e(#4]?9[1;T<</
ZB^E4<[Rg5KMc:H=25,W8gBVPWV:0X(fFQbP1,U49Q4V]Q:(YS?,[AXc;0(7EOTf
VUIg?F2,3A;SJHgK/aSf\baBFC8HDF[VBfVGBf[3M/FC\,ec_P&4^9Eg:D:(;\Z1
;9XgO8,.J5I-+c(U-X0.SLJ_fJ+2?aIgY._LK&TIREJ3JV3H->b6PbM9;9T-@E_7
/?(A;>E;FVJeb/]P[;=)#0N4[/cES#VY67bS1D/aTL-g5YZR?9S\6&_9Vf(:B\67
AAPJ4d&1AZPF.L,DKc6F/Z]f+3Q1CPA0U(C]@8KAA991LB58BQ-E5B,D(5G)\e;E
1fUZcCL&G(4;GU><b;>gFR-@9(D;K+[TEc[_WR#gD4Ybd9IM.0L/[UHM1,X.NDg(
PHP=&UbV^;64VW2C8X/7TU69]L9T5<VcSK^MCfZ95<([5d/)O04^FSW^@I18f@BB
BAI^MQc[<&:FVadQD_,;WcD..[W>Z2PR^0^F8]7+E(Y;>MK0dF/G#.be0.a/b^:G
/\>>\8K8BM\BDeLJD0YB[M4-QA6R78UTGaR7(:,gaa^X/=.0:DYL1^P&WY(K<2J]
\#b2VMX3aN(OU94QSYALR2@ZP>4Sa>R)dDd@E#XPea\J)D5P^2QH:O3;>G_&@d7_
[WI<>UH1D1)/TO>bD@=J9G@8Xc[Q:P.e+2acWDY;UTT/>0\+7_Q3PRO\FP1XD4f\
5.@[/6.1Z_Vg:Z8fdb9I>QT\[Y.NDA\dcaAOKI:)6?<6,;FC2058K5Hb0=;#gE@-
OAT7[GfT+.CP6IV7R?PBAZ(N9,7,TGWV8ST:A&@ZEb))MbC4T1E[_D=PLI;[+NU0
W50.]RLc;dA)6bXaf2eIGDMD:)F:./GVb&=A]6b(YLJ:7IbJ;SEPI,5f6L.IV0MW
BQfMLQIXM37?/\I7W\@gG8LN[\#[?dF/48c5aT#]&/.+V=YLE3[;,X/MO16]c41Z
^DcW7f7UH43MA;PGEEIOQ2LOS@@474\)ZeD9DXgHTJfaWYEJ?gc8AHPV;_7FG:gA
35GgZP1T.;f/UAUSd+B1C.Q(U,X#>L9=Q.[eE4.d6)PaZI3KSJTcKBV4;174KCR[
EJ?7YL3NTZ(\OX;YHDH7=#]>_?B3e&I_&_E5=+_;:Y3L:QF6;&F(.&[^,1WFe0O#
I[JH:\4g48_b8ON/&.7e;LLSP0BMa@:]OReMZ0-R<J3e:9V/^gTM;-\Y3b6A+\R-
&E&092c?N153:YeS&\87(Hb)WQ9I49]Ia4S:WOK,][V>b27S[HV2G1F)S>6^W&Ke
UN?c\]55S2c0c&;[YGB[QUPTO0;JB3Nb]dO?Aa0[cW,,?9PI;g-RfG@Nb9R#XeTR
[^cVHXC7:PcXQ[Wg5Lca&CK&<O+HILOI4<O1D@DC_TA+f?SbL=&ITgO5&TYd2[&.
GM]1-F)6f,8)OZYN?&FMX&<cZ6KgU;7cO,KV,W-:5^WFAWX;#)+P]3E>:;ZF)EK4
3[?6b:](.<#)*$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_XML_WRITER_CALLBACK_SV
