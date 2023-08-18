
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_slave_monitor_xml_writer_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_slave_monitor_xml_writer_callback extends svt_ahb_slave_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_ahb_transaction ahb_xact;

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
    extern function new(svt_xml_writer xml_writer, string name = "svt_ahb_slave_monitor_xml_writer_callback");
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
    get_type_name = "svt_ahb_slave_monitor_xml_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_slave_monitor_xml_writer_callback

// =============================================================================

`protected
e[cb[6YL,gGA[?H_5DPEdG,dZL72?T:aWTc2+S./NYe97)B[9WEb0)\X>]8?A:WC
3TU,AcLIWg2W++5CTVH\+#(LPUCL?=.g41U=.?Z5Af(=0=d1^&;\Q-Ad/Af(SM21
:JbO.W(gJ)IaN_0F(W_B,<9J[7M-U3ZfC/18,OH4R6@N1G\>]bd8D>80NPdD+2+W
_cE1J4F\^C_KP7TUTVfbAc69.D9&WHA.B@fJVS^FYf?-T:YU\W6_1T7aK[3FfZb_
e=:C01;H.+V:O(H[H6fU&1[J?EYB@D(bU?@@LbNIa3b@gAAGg353&:VXS)3-e#\@
-W2(KQ=7fXaV[AMSP4[VN8+#I,eQ:7)BQ+T_N@MGK(0D==2eV=?5Ade&GHX3WEg+
X:caTI4O4/7,BM57D,\O]5^95V8(3[L??fc&;B-T+E#Sd:SMg1=O?N,IJ]Ee&7H,
+=Q_T>3MUB8Fa29?@\>VfT4e7eBERW>6:$
`endprotected
 

// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
U>YZ/](6^89^<B>c+I/MfLFb\+,?]:)3J&]B1A/1D\3?6Q>J8>Hc)(<CS/\IYT@(
BGRcCeDC,NFLD[([0UbG[Y/X5ST(0=UNa87KaTgZCHI6+[e5S^Ra_B[^a)1f08UP
3ZRZ+)^=XP@I9\-JcCH<Q[/C=CHDXV2c/>:=NR@b9c<4OED1d+Q4:GWAb;WA9M@H
\8e.b9A1DEKJD\7a;N7.)0Q?4@TdO(/GS\8_00e;>;dSZCU<AF(1<(T+F;/=1cX7
cXV_M)Ub+)cN=V9-+\f<RBgUfGZ>f]L(BP2ZSZ_\+O3E@I4@K:E>ZN=Q;PFB_>D]
5Ia0HCSKYER4eMUbKNOFPI@JNMa@V\M5\bG9\b#;RZTWH_IG3[KTMB9B@cG<]Fc4
I(,g8(>A0a\)GQPA-)P+33[?bbdVCWV<8\GF]+cd;\0E8?XJ<:_U7R[HHYI_V.1I
@>gaKY;dNAe>,Q>VH-E\(<D&F0b/&.CUNSf(R<JW;@P5MKSfH#W9.3)BcMNTM&8]
2OB9D]V>f[gEZ6dLZ1?[gLc-A4f,6Pe?IE[bcY,,HMc]bU/JQKH>;YQ??;I-N_dH
@K=]a5dD<_Rbc:3a>O-/[7XD3N:XgXf+Gcc>e(a=-M2F8@1@fVY37(@E)K2AfBfb
-,SC6#<#5f=,F)NWVK4S-82T1G]aNPZI(^TIZ\f]X8UQE&TY+Z8.O1/V0+9_Td:b
[-3-15/P&e9E6/#^)a+EEb^HQ@)Gc?9c+f;#_@3DU0gINM\\[2-b&7KVcfJ&=Y;e
cc9,/@U,BJXE0C+e7_@1/#9QSb?8(S62Jf]/V3Wb+7F7_@Q2+:D&)L,c]0BVGDD.
R]HL,1]._D\B&IO78+aOQ:0]d8R^8Z3<ScJ#90A/\@FL9:J6KQ?W6H^<-?5RS:4X
3^^\C_X-/OUa^),VDM4GZ,ab2)+P-]f40U_FgGM#H#&&:4V3+6>_:S<F&5b6??Fd
c^K6K32(1>16g00HZTCQ14HWMD8a]JM4^S3R8]FRBW2V:+A#a5X:V]fa>@]4D]))
A7[#Z.3J8_aNf_=<?gR\,+^C7PXM3dJ+@-(R&<<PIeL//A<^CNgR&XP22gUB@)Z3
^GdV@385/LG@O+^_=J;6#8/\K<5FFeTTgP8RZb?B78.>G4R]L^B5bb0FNc7+B8=A
?NW&=&5X-bB@gN;9/V35P41W,fc-3YBRbKG[KE8UA_G_DEgWM76-N5ffDHGTAR_F
e:F^]RVa9dZN@eVW)EW5&KR9@NUN8<PR_9b\JUb9X2]ORQ34aR-O[I,cQ];5KZ60
B3_gPM,0gJ9c_P#CEJ38fL-@6Pd>]Xe)C81bH/19_dYgA\2WFVZYe0=X2CeLHC#R
2eI83d(()fb^^9@d82X;A3V>L,QLZATUVd2;.aBUO>1^;-V#?:&]L&=:MGGW/HR+
=+TZa22I(3+U&9S_]=FTR[3ZRU@R3.9NcRY[_Z;Yb]8#aa>S:>XTa>^QH:U-V<7^
D0VNN+G2#XLZ>#\,7;9=dLe;cd4N)-FQf7.#N(<Yc&(1\//f6M9)A@IfMS^3CI<2
W45\d8:5I@H-,3V_.382_++cXa=aOP8VAX9bfX?Z.1cA31,E(0&/+4GIg\T^33cW
Bf4OXU;B=GWPY.IgSW4=Yb]+cH<RP5f-K;PP#VRG-LD5BJDdcT_+cWBg+Y=8<)5S
#WKDK5QAd6C^]2>9(<NR0P6TM[S1>V\ELCFR;.3)d+H9K,X,T&U\cAB/_),Xg6/=
UG8,S)^V1PRSME)>O7,K_51^Oad?<ed<7F?g]ORd^F4+-FO\]b1IO:dd?IU.Wc^5
PH\<1]GGLe&ge+TFV)fcBbN])2]6<AJ)]-^MI)?32KETFV?-584c6-/E7L0)=KfW
S7JF/;W:R+BF+H5F19c5XU[M#61;bU//ULYgPYGaNN,R8KKgUSD@(C][V3??WK@B
5.(B<OH\+NQ0ega+aGGF9[58FJ4ED=Va7P<FdWC_<c/YC5Eac[Q.a]E5?[66_^G.
aaV)abU?2]]_ZXTI,<_?F;_-0Ae[NJe4DZZGCN.f8A](9..SDZ)ZSVF@a>fZUJ))
C92Ef4VdP<-+OKe2LN]M.]D4ONBWIJ&39gXf/f2=+]R)I2Ce#?<@IYNF7(a=0ORY
MD<BP0\cIR4G]9gOe;0ORO-N?X4XX2^+?@9ZU]AeJgA&7\6BAd9gO68>XWdH8Ab@
,\3VV6\3AUTSJ9STZ1Z_XY)5A-.c^cTT0/aNWMBF8&V.@H6(:2J,^d3,EfM[1HN[
9HS=7gbdbbP\W8Y5.R9c5BIZ?(.3I](J\A7gI>DN.0T@>U8269Z7Z4b_>II4(>-I
2#W?\G;Ef_94_@9MV>8B4RQNW/b&=dg?S>Q5_N>]/A6\b^N:)\R=[:/=<c/GBF=g
4>J+Id><@V(V]RS8T7<XEd\^eJ<FG,L1E5\)XVQU6#>LWa&ZGd_+:5gSg+(dU53T
C9:@L8SI42Mb6UZ24.?VCHeV:XOT)W)W?B=24Gb3be=3TV>=A=>XPcDfNRRY2^?R
>B>&]FR^a7P#,d\b#^KR3a=3<C;Z/O,NaDdY_:ZZaL#]9@?9.^d:V/eF2H&YbcKc
ZZ.+2U<.A?7>Y(;Tac,6,P.VTUS@+&>W4SUM:faVV=:VBCR4JQ8_DFBUF7K1<;(g
BRdeSc(a=]0:g+_#TO\Y6P\M301C57g,U/>VOd9XHT3B7IgA?K>Uga=]?T?\0,#-
We_A3;.3+4,=ET<O7Y(MZ9Kfb;P?9C]Q]OQD0U5D)1[K8Lc.@-#J=J6RA=L=I6;Z
U9+F/I\XFcE?PI(C<IaVHdE&QAf&0<5J)IQCTM^b]3+3fUT?=4,I+2HgEgRYcOD(
Cgd.AKT:\CQQ\>\>RB8aSQC@;+Y?#L[3@M1DUeIP1\ZLT^7QcHM<_@]3D4.N#Q2&
f@<d(LUM)8/d/Z\J@ZANU;Mg&(2a41RNY#]4g]E))LSb;R2.VI6L;P3ES?C)?Z-I
2_26\)\bP&W0=[/Q?_=_XN7FJgAbS\1aa-g?-;D>_Uf6/]0T/C]C7.W@)A=G^[5)
<U,WQOUXOND2;@1O5L[eC7/O6-.>7>PBS@V4Hc18(7^DW[(\KLV:f:YWB/;SSa-5
1^Be?#DWFBYF;#gBA0bP-,\GH4YPJ@cJ(A\,D[=L_<T-@T4R98WdSaB(aRWeC77B
[V2BK9fc8d+V80H(/NZ@7g<PK)7E-0Ae_bfGZO=^/0-d^E/:D9ODbg+5/<RFbCSg
K9WK-;T)FP&0KIL^NEIDe7&aeb/S5RPf;>P8D?RRF/>TgLDK06Z8a5edR...GY)B
d5bfEPeHSP4fQZ)e,X,@_ZAYC0-10AAQKK)HLb/[KJPZ_W2f=KDJQV887XZbHLg3
L+LGTL5#-:cX.V3T.cJ^F/X,9;:G7cfM@]1+XbR&NS9JQ;\CCcfJ=L3-IbPf]]QM
Uc9d=C>;X+C<[_0&e+YT4&#e<4VD30?Ab?)2,2:[BH@a?Y;g9I@0T3V,HGO7#M<D
eNFZLGV#@]a&7+=5:4K5E8]+T=3Y0V[McC[&@Y:GTb,fN#HfF^Xf.PA,PcQ8LSFO
fH;OFY(=7NG^JZ6(V\<N)WQ2IV:1P;ZcW;/f:3)(D)\NRSON.4ZTVI?_Yb[1&XOf
G6:A.Q5UV3,WS8B_D>YK?cJT^IL35E<VEA^U,[Wc3,0cZgR1(_)cJM#ND.6Y<dF1
U7GA.GJ76+1O=0BV/YGTLK>#[cK9G>/J^+F)5+Kf=^d7[9)gC>;MF]K+]W/cdO#.
>geZ?N.cL^S75;.0T=?7>I[\FG-F>KN0XTcFe@[.(dO>O1CPH-:L=Q0VO0b-0BcQ
cK6:561Bc1=^;U8Y)(0TfBV9SSR?&ZSB@X6c[KW-Z:UOA0>dV;3_0SY09Sf_C)79
#&KQGb#M@3af<4-I17VGZ<G7&8_=H:fEE-FH3_#gE=R:P:<B?^#;>L@^M#d3J;B<
g.DYQSOS._/_I&-VM\B01?05Wg:>R(.geX?G]-cMV,?(J(^fKI(;Y@;P.:S^_3@/
0-;)MPe[0L\OV(4/;-]<A1CBc0E5-5.F0aI@#KXX]2fVZcZKIGV.\8ELb1cWFF(.
,b/7\<@Q5OOYLT;BF2ZdVFB^=)APTI58++OeNBDGKOA(^Pb/5(?ZD_3KNb90I\ga
@YeTGIR6;H3aE8DKI0TP?BbQG--<D3[7A3e6TG/J(+[XB[YV?0C>?B\PeU[-D&3H
c)1#GN>)/,^f?Ha\QZ-Aa<;d8-;[X=;bM6c6,=7Y)M4]SA,90TQ7>&X\bO;Y3/-J
>T.3EW04_H05+K==)#PUM+D.HYeObC+YX0_S).?G)S;MI)CPP;G;M>>FOH(CVFKW
R=N7O<bN?3b<SDU3@PML-M@8TQQY9WK/:8ME-a/_2S@f+6QDDbK-.LLF0IOgG-IY
0]g)E<H=1;GIg.(J</>)B7D7#BK0Ta?)<MOK-=PBO(:g=e00BZ[aZ(OMa/#<M,CD
+&#OSa/2YK[[@L65aaI0DUT;.6Y0BTM)FaYMT&O?(+.[OF0NZ_<Ib7A10QF70/c?
]]Ge(FT&4+F/^ON?+L##-SU)=BBAMcdd^f:G&I?8QU]JbHDb2D2\GgaZ(A?V(33F
[6//2BFB-QF+De=->V<\3CS6?OB_\T5e-H1<E#6gTOCYd1P/\eKE]3:d7J(M6B/H
,1U8PDa0,YNWX2d]PE?SN?IYbCW^8#HH#T9X&7C:#]]V.[\-1#U0W5_FE@#2#\79
Q=gN\/@8=RI]2gRH9#0QY,II#3\N[#=e3P/>T[4Z6RVR@a]?V7I#KTM.BTLG;]Z@
[JcD-RAA#DYFMA<,&C_,O#.ee3ST9C1-M&^21&;N:<FfCEA8=C1T6SK)<D;=N]@W
K1)K_JO<P?=]6_5d;=AQSB69A@dBP)7AK]bN7J6=XNfZ[De43PO=K9CCM-N,UZ4K
-\:PC#JR^,P\3OS/FZ_2DZeXZ6@\;]bYbbLRXa>fB>aJ&eRK=63H#KHWTJYfIIOK
<ARFF(FWZ>]=0DfJC>P#X88<20,<b^X++T.U&PDWVXN5XE/&I8))Se8?b&1/R^Ua
4>S[B?@RO_F\Wb@4US7AFFW>#.T7CK9OJKQb)Tc+8<?CIJ)_eZBDd:(\7e_(+#S:
QN6V\QJ>_G.4&eOX8<1.GP0J1^C&4JeDcN[&d64U@EI7IM?G/Y+&;_d>3628Y@AZ
E+F4PIB\3-B_RTXV@AB[:@R10O(>4d#\d)MT_@=8Wf;:64HI/U#E&CGU:#@U2gSN
4BZK6J8AO?BX(XP1<QedbGc:&P)@X#U/(C^.cY4W-XAb^.]+Zc[_:I)1<6S3U/@Z
1MNNCgBX\\\L9_.bWfSgL2TD<RXYMf29>#J8OHM0A6C(dJ:W:1Z@<&1=KP7QE0Ld
]4TS]TL-<)NbeI,?WP1;Z72C;YRf32WK[LHM(gD=>aKCW9=fFF5ED,ZJ+?5M1:e?
?=-M1WZ&LMZe<H:T=EE_=F&VOg8ZGf;b>?IBaCVC<RQ?OFVcU9:\Ug,2563UN6SG
QJSbQG7PfQ1A7QE&,.[4RH@_cgBR[YA>(Z\BNba/_+g,P3><bU7Q;@G+3GAKL4)L
Jf7ef?1;#.VGKfbVO\,@gdaL1PGLXNa>S]-ZUNTBL9;_X-4WNTE_XH7G6;@G0@4(
G?aSe@T0H1[^=1+3KIG]PQVP7#b]:4.IDCCffV2:X3=::-S#TC-?aRU,4:fM:^-S
P0HZ\EY.La>O?_V[f9.FFaBc6-=[aQaJKY#2BT_G)bGgf^[75-+VY#95>#/.XCI[
_8eg^b)JO=8b:9-13cE?9+Q.UDD4B@VQVPf@L31bJW@+&/_)Y5L2bMH0DWB1/@g_
XSOVT^0[40L/eG:RRJf&>JX#DX,.?<HOY@+L29If6P.)[Bg=EY2[H5:A8-@#HG2)
#H1J+PI+(E#:eIEPGCRJ79;1L#PP/+fd9$
`endprotected

 
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_XML_WRITER_CALLBACK_SV
 



