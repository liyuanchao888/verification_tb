
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV

// =====================================================================================================================
/**
 * The svt_ahb_master_monitor_pa_writer_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_ahb_master_monitor_pa_writer_callback extends svt_ahb_master_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;


  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time ;
  protected real start_time;
  protected int beat_start_count =0;
  protected int beat_end_count = 0;
 // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time ; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // stores the begin_time of transaction_started
  protected int xact_start_time_queue[$];

  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

  // The following are required for storing start and end timing info of the transaction at beat level.
  // Stores the time when beat_started callback is triggered
  protected real beat_start_time ; 
  // Stores the time when beat_ended callback is triggered
  protected real beat_end_time ;
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

  string parent_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer = null, string name = "svt_ahb_master_monitor_pa_writer_callback");
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
   * Called when each beat data is accepted by the master.  
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
    get_type_name = "svt_ahb_master_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_ahb_master_monitor_pa_writer_callback

// =============================================================================

`protected
;?UI69Y9K4a[,NcTBO8VXEIN<+[R.)FS1QO@-UEE4@fYTAW0.A8B0)a8ZQHG,@dg
41-[a#+:^R=K=;;C0Od/)(b624:O-2G?8HPJ>0aG.FJB0c.)>EU:V-9&6-Q.ca:K
OXO;Q9EO6fU1QMeOQ_Mce42)G9./Lc,)-^bBY6PcSA6@\IgL><<WD&9)XMOV0ZR3
.;1V=I:H)f,#\L76TLLbS>ZdT>&LcM^,cFg]0g/SSELg7(MU1,.A]TNa<J.eYZBK
1:#9,_C^#M8O3_P1gTV+4.Mc)@W,0b_90-&&W_0,.8>U(9M<#TKL?g3GNVQM=a@7
ZN;XZ#9d]B2,=RH0Z)+5afB[Yd_X,7)10KbA4PC0W7@;34#V[>3^eSF=M<d7C+=Y
(7Cg\ZGa0W,O)fI3L&I&1T<@_B7UKe5fZ<_971?;-S&_>XZ23W3cgQ_9KfD1aCQ^
OI3MY#,8V7E&\eJ9QQ@[-9U0&<C?DG:X0@W54HUFP5XNGWKD0AP+0Y17eA2#2c6C
8)]^O<Q/b&fNN3AP3&dT4?P8>;KI-57)=$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
<R#@@(B-8UC^8R<:[/SCePdV,f/&Z9,b?IUAK(,=Ig:8ZH]&PdC+3(L5g.S#MI;\
6d#7DRD.KF3\fVadCTEcQD(5SYdb@I^>:[?eCR\X/A[H86L(-Mc+=>]SBOd6__gZ
<#dYM^OfeF(\#J4<]L3K9L/Z]<_?AU4^VPG:XUT^@g<NHO)_d?(=->DUWV#,QEL#
3YEM.H_:7&7=OJ&0_;-2FNEcR?9I(^W]Nc\#-D-<(88MbT_DPT>?+79/O4F>eAH7
G0MQ7YGG]#OVYISG1B&FLgEVGe/8@-.<@UD@]]bMb4>;ASJNK,DS_J3V=4Y(M=/f
?H.=:N_#dS+<cYEMDU2>cJb3<Wa]6VJQ=H+LM9):DIe9:;#GBBK8ZFZf[L1#Q&-D
1TDT;SO)1^?--&DUD.B52DHa,96\/FR37>fKG#]]4gTb7QSa-7bG)WE@XHGC+fVU
G^-LY:\@/=H&J&<E4f:H\73XTd#6g6Qg3c8(aED_0L3L#&bW,F(W:TAR5RI\,^5)
1MAJQ>5WJKg3RGO&RE5/>[<LW1/8@@X2Pd<(8.?2B^<TNR_A,L,Y3d9534NRJ/+I
GF3[V8>,CI4=O?_:9^KY:BA]4I#Q-/@\6BeYWYA#J=M;5/L41BbC_1XeZ>Y<6WBY
aNZf2f,S2(WC77ZJ(5C;;5E5EG/I+<&VR>^YH0b,-3H=?>37&Z[D/4?UCY7(?XM)
>:?LQM6dD(?#ZW4XL@4IgHc#b?E@D-d6,JJ=II1V[Jd>,9XeE:PF-GO:5Y&I6H2M
aVO]<64+\)8:)\GJ1L<6(R?;Z(ADaG1.44NA<1?27>GR2[99bY6##&5^BEB0Z4Vb
)/]IFRE4M71ID=&@F7RGF=JOYLa_SWN,DH0dJ];2>.L7I6bN:?YFNfBN7f,HJ=:1
\X\edEIC;Cd8ZTOXYXY#I:H+Q+4NG/J^)H0#MSDUEa[bVEdT0c_UJKW#+WSM[]3[
Ab)\P)F0Wg<>c=N5RQ/(4Gg[dFY2Z^P49MF]?MT,Vf8D)[PG1#1PA1KWV:6SJVe7
C^9V/N57QZKPB4E67;QHcgF\#37dD713d:?=9\M(ZOH7L;>N?LPSfJ,J9>aKX2L^
BG0-)[Y0K8UKQ^e,KQ25U0gP(fX6Q/W5FB>V(PNg9W+#KN/0Q6-8E3FXE1(9&A:6
Ge-)?\]RR=?N7-\JZO,)^YK6RQ?=9#HM+-7P7)Tc7-&bfEGY:XDc@_9Kd8bNg,d_
II/9ad,O-OWA[T&<@&49SN0B8O)J;7;Q93,@eL^]G)eLZB>QP8\cUE&:(3JU<;TZ
+f8EC(Y^,Mfb]SV:f8UVS\6R5,L&DN4Oe5\IFAHYO#1OHFK#2SIODCZfJ]&Cf^HS
9f_\eZ-5&PD&4&);PXg5>OL=GHLEMW-[Z9Z_FI.0NYJBdN#UT<58&O-0f<X@H#Y)
eMI6WF)=7NG0_HKc,0O\CXO2<;.16:&^=I01C3b=d0&<N?c)HUJgEX=P33CG7II=
]YQPSbXFP6MTR1bR]C8gTfgKC-Y#O&ObHcEK:28aRE?_N<Ja<H&V748^B=XC<e(<
CV0cYJP4X.7U79=>F;,CG#bL0\CL2\L75[CGX)&d&J9Y4eP5POJ\X;=G[&JY7M.^
7D@eE7Xb;7a5ZH#=<Hf-@1gSB_4SbZ.(NW/e@4d10J0bdEOON=g:EC9_P8(^cC]0
](UVF8HZ9MO8dHd,+IV]3/VLb)S62+ggfS/&9.]R=Md>Ef35W+?6Aeg;=]>d8.0K
@VbF&@Y6^A#>Z?GC^IY/DNDL[IIP(b@X1[X+T[398:]A3e05GCZ(&JMFXR8IQc)&
@#GL+E(I3X+-(;91g6D@Z#>f\8Gd8\9Mf?N)4eD/L=H<_[7B05;MS??<^Qf6YICB
5R_1/2>R@Ngdd)0XJ\W&N]J:AAB[D/&[AN#+e]9^8_?eEgaQ207fKH1;MVG;d3;H
H=gUJM\,,8>8W#R.NFJ&:@WCgfGQO=HT]_-)MJ^=A0dZZb]S9AQ8=QP):B0HZ<Y5
V-?d)/ZA:LC^27\(Z;1)S2Z>,(BSYBA@_K(caZZ.H1gVH,V^7IXf-cZ<N5+HN1Ec
&G_+g:I:c9NR7ON+Xfga1=,/:O-@bDg_U/&eB@AUH.P^:_+cV,S,:O(RMF)Te@F^
/B[WBR^<2;IRPWc2STW[.@CUK,HR:\D/>25f5-D@,UaN3EZXAD?V7Q(aGV8/BC:T
N9#JL<e\N4I[JCC<Z>PSV\1DH?8-M]8Be^AaaC&8&2S3I])4F5g=cU9X9LXKB1X;
\90FN[1aU2S<4aRH>2<]R>\P[[UCFEB;E-LW.e[Gd6>A5_dMG8UL3-M:2TD7Y;H,
_A>HZLR(E)OQL+L<4&MV7I/6>XJH^CTNd<R-#T\4,-8?VU.WDc56PgYX^JXYJS+;
8XFB;JOaDbM-C(3c@]O]V=K9A0A?AS/E#Nf?N,SM4M<72NNLI^3BP?@,ZHc(/-c,
7G.7R5ST829e,UJ<2]#/VG6H<Z,;1fQC,S6TY<CSW\?9O854HAAY3.cA@#AR<F_D
IVY3AN0_b#@8\Z5O8)9g,R.TOT?QSA:&gg/3b>P<7B:NYMHW&JIb?M,DeK9:RFLG
+7NK7P[NE5c/;,0)PNfK7EP8H17:NP&AD=5)&AJRA^22@=\7+M3FQN=9MI@]?8Z)
S5-,SIa=6B5=E\GLV1P:g&8YbL;)8?Y\#=@A=:YTFQ\K-b;Q-SU[#Q.W-a1e9C\P
c@b>5,XU(Y=9+ZUO/7Lg\KI+I.Jf+L;1M?J[/-MFZZDP#=KCZG3?,]Ng;8/X[3,]
9+(ALgBaAT+2Pd?9G]Kf(#N09fA&3&Pf#?6LCe:a.fS[+Y<eUH^Z036J]<-PId,D
_\g<8Xc.\/WNPI.WMUWfCYYC_DU<?\?4QcaY\W[1],4+>?N[4aL.L/a,M>D[V?aF
b=+c#FB&)b?I##UT0C4dIf+V=2T+=/b,.OV]_?FO:,KNB-EEUOf?+DV/]/;Ie#:.
=g,A?(CWd2L=E1LM2=//c3[/ZQAQ_;;;D7C(Jd4([Gf&Oc?S+6R<G1/cRcdKc:bP
?W<T.-XaW3bS?;>C,II;>O05OcC(CRI\^P]E@/\gGSW+,=SO_4a\1acMdb[8[BGC
VSb)/H)40C>[G0IWa;d\0^CS^C+0?#&LWD3K.57RD+A=YdV8K,NFMGU&(G9@.Y(6
#W4UN]H0T]>BT/2G&DfgXFR<?a93G0M1,JX]d]HEJO]3WQ9;5GcK5gNb[E8cIZSM
YCC&XQ<[AV,/(QG(Od2Y,Ha3^RDR^5Rg8[>.D-&@?@#5/04-W<cOWf79\QD5d&AO
L,3)6[_D;IPACV^20Xf(S+8ML49-&EV,],Da^\8O(])^+[M+eM7/I]^H]+.3^8);
IEIC/(LY4cYd9YEKWAdV^JZ=EaDK_B<[LcJ6;WcXfS3(e;;67>EF1W4H^M;ADTF9
G<.&+?>VY:]R&@d1bQESP\E:,1Q5NMBF4#>3f^A-3/DPFV]1(P1-K)Q(GOQbG#V<
LGCBHVHDWV:+;RD3E;#8<=P/,X(Dc>BdNF>T3.T?I;),C3_OI7GK&DX5:_Ca9d6<
?Cb]EMB:_S;:<,AaHA2CMR/ecGEX=A&d-5\b3UM>A#^&]\OY_?RC[U)T,&][H()g
8\N8HSR2@8?4U]__:FRFc3]28:V@(CPYedYU0G[_F@B\=1175HS--Z]YM?;Hc_Z@
7dLQbg^#3?#WOeKBe\,IC&=f2cJ>cUG0(T=/+Z,TYLf<FT:c7fSMYQ/<g,@29>H6
M6,[&:Lg9Z-LUTWgaf>:.JD2G:?/[E&A3&15VS:RLM.Y2VIE(@g4\VDVZOcX(>A7
gY7P;E;M+A1JHa)N/@+FAAGPaXD]:VLMS;F?I(\76KBd_HYd/\D1.CN^[2GC8@2>
;1a[?MJ>-H)G(;V0.#UF7_3cRUXY;g#.Jf5@Z2PB=6ff<R7A=dV1KCZ?Ydc^JK&@
2.URWfeHTD7_WB063+K.:KWRCAHL:G1H/6RL#4L\eK]K#NX_I45#@gWGKf?=8NXc
S[B2][277&5.I=,Pc&&S#@Q[_?7PUMY6b.=ZE&MQ].=BW,1J:We2Wc5WQOQfHHYD
KZX@ZZGPWNLHLf<ZTWNfSC128?D&V\O.:R2aceQV03(BTB,^A0LENED26:_4A]Ld
dJZN=Ma18>HF^]M6[4_7X.N(]_Y(X),.C;0@Zb,G,[(H)I4A\?WTH=FfOT[_S?e/
2+_9eb-Ac1fBbIeO5@\YS)?/W-RJU7=KbGN^5T;[?WC5EF2BV>Q;A;:TS\:M?NUS
IW(;Z@?K=W\<.(T550(gJdQdc-H0W//eU+-C43@SQ<-D_9=(OJU9/ZNZ;B/JALd5
&NO^3)T:\V8-)=HbcP]=C@O2E1O8J9G\9VNUEeVVVP2R^)?6SPag<D)];Q1N&[S+
ZVFB<6g_N8f,UN#5B\1E0,dBAHgYeE5N+^L-P?:LHSVUe5AeKN<)06e:M-c([?X;
c]JfSg2:d^HEbG>:M#5\+S=P5)DTUFGPCPY:SP]c++)[JgF@SAK@HbP\N&:WFON+
;)79(&g-AaUXJ_D-]+;dL;OMR#A7AbV?RIAD^_FH>=b7;b2OFQ@Z]P.@7\bEH&Gg
f(8@Q8/NKKH6Y6I/g&Y^9-7:4QELPbHaP^d&62+Fc0@O@&B(ZC+O,(M##X>]<E77
#L\XDCSaVFd4Ue69@=JA+JHgg8JG_Hf=]Z,#V7T_)V07)EXQUXLe,ASUaQT2;X5_
5d=V3Y7L1.]gO:L-MHe&Pb\,18VPEb#)ZI7:PO)/V-EN.cQ\cHV3]BgNOL_8WEN-
TeSB_,ITFb1G?FVFRS]@Z=DPPCPa[JOcG_L>.dEgG?-8>1PWZ8/EaH9ZELJ6CHL#
<1:Z+KC3DNLUV7ABRTB,KJGUdf^W#Q-K@Bf\dK/=a.NGQ)4a95?74MU#]4bG>>C8
PEb1=<_(_>bPReLg&e;\2N\S(ee(@CBR=7\=+<<9\Df2<>G8.L)M-D[.]PVJX_7?
Q/5O\B[C<B5fK(a\9OI):G./_HaZNVOJF\b>Q<)K>3P3O5&9=M&9?32d1BP&]LET
CB7O-8B,<bST<(:W3(4:.H7U[W]_3=5FKA-a[dH3(#MT:]YB1D?AgaYJ0KgZEK1e
HV#_TG/9>Q#(5dFY(SSGeUKEXU5U\;XFIV>I]8WYO_>:gaG=<ZHfEN1@&:Lb8\YX
#<^VX;bOO-F.b3bf#_4Z+<,==d,BaE5FEEZN?7Qe68Oa7:g92U6bQEfc<3C.e/GU
4N\]>P#N?a>CF_?.=b;[JE4a1bf+(]P#9bGe[5:de4EaD.9)K,;ZC7)^[CP-2OBL
dQOOI3Ua;]4MD3,#>/Xe2e#J6DBF5<&[A.:NM&H1M-G2=F>=5VD-CZ7:dfg@a1RO
f@HG6;W+aV+A?K&&FP&T?-P?A(+c;@5-6-B9-N[U52aFLU-8fK:\LA2Q=OJ\_c;L
c8<?fOO;U3BP@36=INCN:4=7&:=BE=9#)B96Cc16-T[\Tb@eI@L_(d+PEaB+U)_P
eI32?5))eQUg=3D(D]QB6P^,FJ1ATZ<+07.<6AY71:2AHF5CWG>?L8K@ZY&D/X\:
5\271\/1Tb>I,gQR#)gMF5M/dNGZQ^SKAN,^7\HfXWZ<-8OP,R]145-<fa\T2@XH
^==1_JMF;IPUbV>R\;XOR)c1MfC@X43[cSLLGgbdA\[\NBgA2cOQaXRfb<R8Ccd-
105.,;7?]79<_@16EKZVP/5ga&d0FHK9284=75/FDHc\8XdY[g24.0/[g#4F4g2N
Q7Ja>ReQ+@6#SNcf9DeU,NCC[.Je:JMO,W07BaI>&DfW_70?(8AR5I+?e4,OgTcb
05R+R_>g4:Ef?3:VXRX0RR@Y4LYR,Y4300-25O)T687_P5OcQFQf@_RG85Bc.K1M
,R6]5CfGLcZ,16Y;&DAJT0>TR<f,9@=beQHHbH4QUbQ=&LQ+K=[@YA5U+.II>,#/
[P.2Q+95)G/D?:(M2JJS,N,+O8@S]IcE20(T22D<(2_18R62C8b_1-6e56II]XE1
B,9ZX+^/S/dOHIX+R+]>>>ea^_41X<Z&O^Vb+/0gT[0IV@BF9>/PBB#)XT9JN7[G
0Z-O[QI5HRQHCU/+QS9OO@2aF21-,CV#I.ZAJYEI<JZ07[+WIF9]EY15][_C<fQ]
BOQS(VK\P.88Pd@3V3GgU.1d.c8K/]>=+L#-6&5\<0A\+g=#eG_\=L0\5/MVC=ER
1TA0C#bQ/f^1V,-Q6E01G-7868;O1/MYAI_A.SAXEFV+A^LDF28K75]\UU86BQ,K
/dBgD()H.JL>)J]Qf\E8R-TG(MAGCBg:Y[Q5P18ED2ZQ9SEOaX,W]6G1I#PSQ#c>
H<JD_ZZMHZRC^Oe@+NPZ8X^D^O_MES>MV9?[1/D?=<RS<=fRdX1N.#FR3KZffJXQ
767egLZFLe-bfTG7J=c+ZTSO-TNFUP?@(dCAd;C(Aa^N?;XAW:10;>,^5+++Y2MB
\42+BW#^4&YYe^H8C@\e+PI6O?;Y&1R[6Zf(<6M59Z2M?eH=MTaf;1^^eI\(7Y3Z
S0G(-Q1ZINVcTe/QOZ=B-aT:1@ITOTB>XG]GI0cW[:4PGfC.2MSg][)5A?KPR_A[
NOC4EJdX#bZ@+9aPZ(YTeXSAX;2Q#62T8(-PO,KR]#G4<KF1HcR;#CWAENZ^PN.g
[AHI+TfaS\DG)?MJSSQ(0936@.>_,@SYNZCPBLTdG9<QO8;ZG//c(3.#Dg4:3)L/
I)DLOK+IF_OVdIQYL5D@.GY:bEgFY-A9SM/(KW8S+ZCXSNF_a7ZV0Q;RWb_@]N2;
5B.-3D,9KSO3ZfS3>dTMFb@T;Nfc4O/>e\:6F<V-E8#=gJ?E\Z+YS_D9HN3RT6@a
FPHQ.[DBTV6dHVPQA=@#PQS1MgGCIbYgYfPQ_A5+K/P_a^:C1Bf\0/29@;5TUO9:
32;,SEGB-A4+/9[?,8:;(21;7,aS(;a7##Z,R5L3[62CQHg^NFdf,BU.Pg0SD4P7
K[\?H1bTEGW7WB#061-S2@e(N)7Z8N;1F<=9W_dUYV+,aLVa;5A86PITW,)PR.GW
0:<c=0SYQP@dC7E]3K&^JY[1O[H5X3a\cN.8\>HB<8d6d<34FM_)P.[P2BC1VcC#
+a,J^2U1L(=D5Z)@Y1,7c3Q/HM-(:C<Q&G^L.cU<X[GHK8g15?fARZ,N+B@Q<8RX
7Q\+C_S)DQWcH<DPMY:abG#FaQD;CL84g>dZc9da70^ZEK5=_;SXRIE<O-IgJfV7
:2RV-+PZ:L7B5Qg&@V[gD6_#4Fcg9;eV>b68b.0a>_LC]H/N.;a;TPWUH6EQ)#eD
T)/M+D(W\5A<)8,NY;DAa1/##6/#IVJDb/d1GVf)4-ISXfN79N4e7OV&eP?)ME1G
W84FIN.H/SeI^/e&6?SdHAM8(-ac#Z\/3/N/RYWAWE2563T^=JeHDC[(N.?IT#K@
^6O8P.5A3cPG8H89FAJ458D8);LL;XM;=7K>+<(;NGHKRd.\N@K]5XC<WC]Q?Z/7
WfT/N7[b=B5SM\T5RbRbX@^aWR&^&B@,19Y1>LJ>K7XK>&_R,fF_b+XN,e6(D5N+
N.FAE3P<FS,V_]9JF3+/XB@RG\C&d\)fO@Cc.D1d]DW+8GTg5.O&0cI+^@]=]EH]
dX8+^@P,H_BRSTgDA^\QbV5fB\SX(_L&Wf=-I2eaeCHU86[-JOaHV,;).-RURJ3M
]>A(0W_I?Xb&SWQFGHNRP-d,J=^X^6\I5K7a3+6e>aHCSSg97;GS^8E]1;CYW(.)
[ZA+.7]:^)Gc8Fd[MA7Y<0R(B,6e/ZF+:MV,0ecQ-a0&SA&)-Q]Ac[W@Y3X;KdZ5
\B4#-U?M<J[_OX7e@b61QGe<E3SR17\^-JPdE4Y,Sf)M@.L^[GGLQ8T&7QA24JC=
Q3dUVf5[[GN?5-;_\X>L3G+Lf=LbAL6KU?fK@QB\2fJN-^ZR65HJ4;gCX<UO2F?:
]_),d^1HSEY]71ZF<=X)VZRGg4[2b-/3KG,EXLe;C=:1XLSV[4+3GH[[^9KVd@BN
.fW\+a8b]5D_;J,T4M?56Vd&,Z\GLKDVSBXN&;b4]FB@TB1JCITA(X<B0:&+BbMY
>,<dOUBH0a5I6Q\=VcPff^#683YG?Ee0V1IC7VNNGD-(T0OIQ;[>6.A2;ZOE=gBE
-QG<)\&+Y@&>b[VbKg2^F/]UgE,G^e5](PYJ.EEba+=P,\N4BBS7b?RLK-0<1H1@
A>>.)TF&/D-1Z8C)a_XP];egDU8f@#eD1J2X.PJ0&R\^.T(\d9:a@^Y^AJgAdF8P
Vc-L9F:@F:1>(GWA+-8WO;(#V#7ab+8=W.,J;NCUDCHHM5BZ#>P<:;40=VbHcNI6
2K^&/K76E89;X69>M4L^4&(P7U^G^BU>N06RaRd:gNHM=69=.NA<+(cL;Of0\)fD
FYYW;f=#+?@8S.K#GGQ5RdED@_6>Q?XP5(c_W@f+NE\Q_V2O0/,ED.77T@GVHfT<
Z^M;JKNZ+bZ7.]QC(3b>_^VeRZPXd><@HRQb2.gVSTZR0dM:O&SZ[&M2+0+_[9Pe
@G4X;P>bE>@J_O]3aCU8=d?BRe<7(9ZC3aL1)?EUI_1Q#<LS\aWPg:QcA2F\XQ=+
@0Ne4U)MBg\6[0cR;M24@?e/XQF=e)1PF1FY;<d0NGMKR#3N5SUV:aUN)0c<gUW,
SWa98H9^eK1I7?Oe\(C:/66X=DH]J?0MOW5^NdR/4Sg.-g#ggIA#Rc72P4W]F)ED
UX?#^P>K?EH_-QW_F)1A]8LIT+bbJ01?IaONWX/+_D(Y\[O0EQ9/U?[;TK;IPVf4
edY)D7KDf)2/2UAF5-8I8SE1d)U+GA6_G@C_YRTdc-82_VA3GF9CaKD=VUK<N5\+
MG2:_-2W(1+X_gPXXG[@FNK2+:+0XBa-=GAHLNPI8+eCL3GCV=1>USc^>.-eDS=3
HBXIJKbcbUa8+D5&cf@CEfZCH,T)J9d4S+][3.eW-?fIHN/.>)?()9a(9EXA.Q0(
MGM,&f#2F>HI4]7@M&RBW\eaXdUTCVX1XGgcSOJdFBGE=?J7e>(2VXIBE4/5:DQ<
]#+.6G2Vb(OA,10(E9KWRU&F4-=]d=&P;G-W@3DV#JQ(<#1CUYeFYSbQ18U>,Od0
g.CCbg559K4fcg@Z2)9(6X5.GK6B2,UC(FAV)P^@H)Q+&F0[F<^]VWB]:QSLW\b,
.D.2=\CB3UH\BU-Off),>T=J?e:-b1/&_I]Za(G_JKAJ[+]eI#96,UQ&E9gYVQG0
aE4V\0J047dPaE=WEg]g4A/6&]G2<WA.GQ[SOS).4U&ZeF)e?U[g1cY[^e-[^CZ\
E:3)+[^V=PT-P9gcL2++TMM_;/&MF5D[fbN+),GNN[#/-d_O>YT=O94-#4D77XCT
XZJcDQdK.L?C&Z]9FcAJ3&S^DeI:9((O98f@.:H/&ff(\M?EN)U8T5H[A)NC:d:D
:RAAXdLKFAQ]MO>J#QH0VAOQ4cF\DNf:2HYL^06B,1U/[f5KW@L>]K5c(Ff#)1WK
2f5_a[2XM)V&J8=DG;\,fgI6[+\MRXRF(^PNgb.&Ff\1J/\[](5V#3.:C&CC(M,C
W3VAHC^Ub5G6Rd;F7SR@1S5QS,>Q-dR\>C(;dUZ<cd:;J_E+,992JL0GLC<gFT_T
eG3b&0JFX26>PYf[I;]/HP3,B,[eS7,L][BFd::,HM).dZ[K1+HF>GT_]/(-N1d3
AN&XD\g0>M2+-(>JX#BJ.fMY>,J.11&0I24LAfU?C/gKN,3+.HODKffN4;0b6a>c
@bJ,-/.W;3GYcL@C#V0GLN]gFQMKH5AA>,8-JZ3ZY&Ea3FC6E@=cRA602-c2gVMA
W>FYe#M@.BZ:a7\H<TMAG5^G2VH\d=P_,R9:]0G[,7,TJ7^W4bdKYC,b>EDT\ED;
4M)U+_;Y#3ES(()[:gRRGJ^eM@;A7H6T/_4APH@Xa@5@0\S4E)-<V=]PAS1TePNN
.NXHBc:SKVQ-c;D^HTZQgL>a(X5+^<)Q_LI?>Y-Z/^7_KV\cE?[>R4SU6:d+ZIXZ
2-+A#ZLF(Cc,K5D-QNZ7fE,(-AVPdI]E,76J-&C#W0W2Gc(-S4_T<D]G?RIA6,<2
&g@3+N1K<c:W)[V</DS[PFNC#66KF@OW8eEd6E;^^6\?^.NVIP-ON_LV<=LS-IKR
H(cB@QZ7N/^RF/1OQ[+MH0H.><O;EG+QL1H<gA54e38f_HM=<ZcW3f2g:5IU;\]O
N<P.,a,JT7DWR1X[98.WX=HggUaGVL5T>T&.31fg#D8.7IfX)IRX7:#];@<N&1Qa
JgaB_f^:8<.C<[g[_c;PE6@;,MN/236@^GRXZ<#5E,-Cd4O36D5gf&>F1NI1K&YB
MOX=O)cUWXX=-g-4b]+KX;USYW-[)3J4?J+BB3aGecV_5QNB:+UEL5D66f1P96YI
U4P=DB>5EX56<LY)LWQegS+H&LU5,#,GF03=-eE4QY)3W7>NATadH9SDc^)3RUeX
?3KZ;]\XDAc?YcaMdHeee]gA=\1DSLDGT22Ka56\-1),Cc6),YI;GNTX/ILeA+E&
7SgA=#5BBKZ41D9@OJ<C(@;dM1N4^U,-RQb&bU^]6PRKY\DJ01JRKVf4W,K,=(X2
@N;5g;M&E^IfF4LF3g5V1L>(e=;WRMML[FES/E_0HVSS)W0&UC4,^/:ZI(O.ZSbF
)#\F5aM#.N)MD#(4]#.#^Q8D,^]->DN>YQHV<L@X#)M33F)L[S1@GY@)Y0TTZ7@d
KWX>C6MBO_ASCMfL..cO)<#/:Q&O3^XQ_gGc5N]Z)Q5@;PeI?MKP?7J7>7f:?YW+
W351P]Y7<)b#&/JK;cH9AbaRdD19d3.0P)\D2<=T3^\U<=d#;;eedA#AQ>2E97gU
e;&FQ627:If/c1H==Fe@C6XQ&]/e00d5=Q3(bg>/P=L;S?B.,@,#>+d<YY<KSKT,
&<-G?1ZCV>U&;Cf#[cXT4OK73M=V3eX+59(<=MFX##FG\HHB4P(bbTf;gU.gd3?C
Z,[eT&O+)7_?IW-KeBYf]HD:1((7GMG0IF?eG+,+dE-,D^2fSZXX;VJBM4NgZKg>
[B[Q3^+(U@aPL6IH^GFd.VNRKXP6971C((R5+A6B_66P,6KbcQ(T@\((UAY=e5[L
LDeM^<QNcZ7YN)5?\9MA?X)gH9HRJ@0RD2=6X4J;9TQ[Y]A8e1<O>LCQfJQQ[SLW
T?T4-CZc0?Ib=d]S9L,Ka:L3VN\S_\f)Y1)_0P5d22+QH=dD_)fLg2T_X51fT[]W
f+2CL:6H3@;Z&\M9HcR=Jd\Z8V]4(V#27\\:CRQXNdQT1PQ>>NTO\aOZRBV&0fEF
TaH]NbQ&>D4<,OZ6dbIMTVAWG7U)<.=&Y+Y1d2I0UNYWW.4=UR_KC4I1g5[LS9dW
B?@W4]4.M>XI(W,,8Y<.X6B4U_bI[2USYOI0Z.A?[<I?#]eIR>6B#VA[T&>XS(OC
#.1&EUA]I0J#eL0?QS\2\P&d=^V90^,5(e,N-/E-,bbB0HS#-YI0f9d5LW@7dY)O
V^EF9NNBUSMbL2?<gJ#;0R>Ee3aO,[eb0;4d]R5F+gZ62<2C&S0NCU^]A)4B)&<G
[#Y)OT[.6BI6XI[WHM)PC_C;^(6I6]+&MgNR(G7a-9dGM:@3f#:;-d2=22V4:+]H
=EA/-VBR<gU9J:O>@^.&@KGZL\RJ<XL==A._=GU4(GH@[@4QJS8Y4B4CF,_KO9[U
D9QfWXZM5+Re?E2CKd8+#EMB;6CbOP=0F#JRV,FZW^1/@9B<U&O3,TXae4g\S]Af
IVN/)7d@>dW=IUKROfaT-]eFIf5gL]C0/O6C)4#=@,EW+>g#CFeF+e3G9@6_8L^f
B9(/6;OJ=UP(Sd,8&?)0[[,?IZP[=?TD\7,^=f9[)M/O(Z/g.+Hd)LJ[#:?:7#H]
e[XQ3GSWNDRUeN5(g\(>8>05((60-@f@B-/>:2.#Q5>Q53LN8PAW0>HQ0QR771(3
K&^2D+WJ?WGPdO;b]_L0<L&3fJ[0,YSeMJdZK0?a<dH(e1V.<+_10I=GONbUN/A1
E&GHPC55/d,3QZ>IFc3@,&6N/Sb\Y,H^HT<TR4=Y48WE_U5G(WHb,(,e4)@dCZ5>
Jaa@39N?&BeNO3+]2-:R_3R4PC,HSB\,EJS>>KS.PN+F-Z\)#BaZFCMO9=Y1PD8U
aB7B31LJ\CN<]PE7R_-aTKC?V]M,=7E59aWEL\8V]K_FZ;K/+DBcOD:c6ZUM5Xea
Ea9/fL2cR5B?g-0\>>3^eTHOd):<>8JJ1PG^fJ;OeRYg97CKM<(-;YF,,K,_39V4
:If_9SU[ES[BHDR3g81V0BgLSC>Y_M+Y\8S9]80A05/S#<6b1/PT+7X9/f:<55=?
4b;9K4>d>6300W;9cX3]H/-^_72bZV(6DVc.a?RU4gH#2LOdB#@<&X3_=,IG>&/Z
Rf8e=Kd8@e14K:QJ0B+aXIJ^WFXK^@eH,@)=92GNH)@O)b3-BJS]Q1YZ0)4Ib?O?
Y=);_2fZ?JPJI]0PRbd_N_W<D?6bXK(:a@1a8gY\2d;68EFbGIK((CcRSF=#]8Md
UW,YDU)F[6,#I#Dc-(@5BI,(g^Vc_;>aX]RfRYJ^C;OBI^EIS)=O.XP2W?-?,C(&
7^Z/\G])dHA?4MBWP#I,.0)O,/9G8@-[+70ZA:F7c3f91g-:9-HIBQO-PE8]3ZeF
@.(NQC]U[&29T0bHNX_D2J2@[P=MaLcV,F;3aQbC]V<fD@+N0Ic8+#[8ZDLOHR1;
MO>aXBUG-faOV)_d^:K#LOe&9e.7[>ZAO1-caeC?K(33Ag5DK-U#_9VL44O1>WZE
-KI1]?5Eb#9G&eTN4O.EU=bA2e7Md_\<g/dLQX]]FXUL?9R=4fg)cZ(HQG<XAK5]
;_K9>6^7?WHCebb=aN@Z>WfE..M\G.Z<XB4^T6Pd?bL>Z(F-]4N+N1KH/7.-U@Xc
]#SdFBF6KH)C-$
`endprotected


`endif // GUARD_svt_ahb_master_monitor_pa_writer_callback_SV
