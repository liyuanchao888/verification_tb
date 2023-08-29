
`ifndef GUARD_SVT_APB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_PA_WRITER_CALLBACK_SV


// =============================================================================
// =====================================================================================================================
/**
 * The svt_apb_master_monitor_pa_writer_callback class is extended from the
 * #svt_apb_master_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_apb_master_monitor_pa_writer_callback extends svt_apb_master_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_apb_transaction apb_xact; // handle to base class to generate the parent_uid for Parent/Child relationship in PA

  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time ;
  protected real start_time;
   // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time ; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

  string parent_uid, transaction_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer, string name = "svt_apb_master_monitor_pa_writer_callback");
  `endif
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param monitor A reference to the svt_apb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual function void setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);

  /**
   * Called before putting a transaction to the analysis port.
   *
   * @param monitor A reference to the svt_apb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
 extern   virtual function void pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);

  `ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_apb_master_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_apb_master_monitor_pa_writer_callback

// =============================================================================

`protected
U0C,:,M0Rg?@bIDB84\#Q14d0SE@YJCN+db/-]ce4K-2/PfHdG_c5)]?4W(3^M1>
OI9TO/#3+6/<1]LK,6+:W2)gJY1T(I3DM422[MG(,7JZKF1)4<eO,6f1BdJa?U6d
A7S&[HC#,)M\<f0Y#BD]I+Ae4NIc/-I]9_O@DWFfS37GF18\@M&[Db-/FPGCUPLd
CZ&eIX.5.=9GegfROD)2,Q0=>a\562A,0:_<.4]5_>=(/JNX;U_d#)]4fRKYGY8=
FXU\,:FAZ=2Xgg/X5Aa6;:A7B&=AEO+.UbZ0?5CA\S=Z+;IZ[QVLEX.(D]TIS<+P
6@c1_g,SPWeK(I-]NgM?Xb>40#B-^&g^&[8e]Q0B?6</F@9L3[SfZT-F6Ee/A(NP
;&ad_.G?Tg0,^O7:,ZC#S)/2-4bQD>JHfOX2e0(A#M/UAKbfDKN/>H0?MQ;RXSLT
.U,:(e7_\fccGFF[[]/X#YaZed#f.G2XdIU2378AEfMA_fOHQ&f52H/J0Cf;O=dT
f]R_E<2-TK?=:@\>eOFQ0-aZ5$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
/7fAWM8d<^:/6N-),KPZ,75>dK1QNFEE9\4EDgXNP<VI7@9YF_N(7(8,VCZTc5)a
W]V]3eH^]d(=WH>g@g[)O,KT_0@[g3GQ&AHHX#8Zb>WYK1QGZQEU&NeT@57XV;_@
b=X?/N;T8N3:K]A[ST[C4GULJK0F#^@2X4gC?1YQ&?f9eR00,J6.<>Z&FfH8aNgE
H\524\L@O#dS6JcN.:&4Qb88QSSUKFC+B0VQ)ZGAU1=-G0Ja^g0UU_c_P.K2)CPE
Le1YGYMBdBB(g\/C3AJFG/[.gDU27L4faa6_VG?NW>Ce,:++PL551SIPfN6<WbaK
2UV>CDJ08M(#bK&/G6gaDbZ:P;0X+,=gO85@=?@5:0QdRbDe+X0<P/_GLdO488#W
,df]NVd&4CK>6>/.DMgML3;D/?J_aK(C[J_MW>=8I)NaS6JD,?&6C#]4I:Yd0V#^
2N5?LFX<4-<_G&0/E/+]]aZ4UCdYJ+8XCSV&GcP]-VSL2<cY2E()\bL#d/5;.X?&
g5WBE^F[IX;GUS01HQV&O\[YXR[Y7baJI,Kaf2-&EFCKZ02]C-d<(&,S;)1eRG56
5T+AGNYS_7G5-E(eD<I:Z-:D9dMII&=Z^Yb6I8&9.3Te?-E<a&8\;-@;e\UOK\9f
K@KXOGQX[XI6=U129EKdVfcXA[4QYf>cJ-B,1aDWF>^Eb-<:>[__QH/[+g+\-c<S
Cg&;bW#D:;<<S5+^AUf#:LLVLW:ENQ>S))5cP7:=^9&,5b36QVN;)&:5FMaT1J.4
f-BLXAW8Ea.6>EXBKQV&#6.?GFFP(C>dEL/LCM7T]]60e;e<g#aI^Z<-8He4D.bg
=7]8@cZ,DKdg@_;R?3JL:@OUe#5KeDMO6,M=#fI&a,A#E0cTU\^XdST@O<6J/]/]
PYae6-K@Qa@?VGeWY=LAEYAH=YP=AM1W2Q;K6dZXE_)IMW+/<BHZ9ffQcaT&aE>A
55\9D[C8.)PfOU;g8>&eZR]AH+><.dW+Zgafe+FY_I#McVS7&Uf+4fZ<Q)XLd:&)
1;EVB\C#X4A[8XeW9e9/@?d,J(W06(cK<^XB,;=[@5S(H)_^IQ5ICIA8;@d7:d@J
d^>ML>+NEe3>@15GF>6gS2Ya+]?H(>/d0cBY8ZSBH21VFR#REV03<L44YD9(f_W8
)03YQbEY7/cP\&CY=3\fgM(?@_3?98YLT]EEcQY1W_7NSB9;2gPYYYL]TM,>a7PN
9Y3BSY48=&A4f?8EJS</H---(>90J5aG0M9fSR[C8_S:9OPAP)AZ[IFAEM1N]C_g
.D6UG8X>I/569Y^5#Y#9GHILN3>1PPUdRJ=7+Z4>&3F,QR&F.AAe2?,/,<H[8ceZ
6]U?gZJNSJZ5DS,)18CY@F)X/,4VFfCV++:UD:6/6V\1RC.Lc:3G2dBD5\T[=RKQ
V7U]F[eF#BXbOE+g1#^[N6)@gU\J8:\\H<]1QLK5-[JWcG9OXgPML;TJ4Pa[0)H&
SAT#:FgQKgQVR#-,c5LQdB;MN5f6_6=M)Q6#70Y#+af;50ReOWSG0-Z4>_V9-Vg9
+9@0;JKT]9Q/DD>]cfa,RU9-Q=Z5;e+I9M@?O,MYeE1XK5(EH6&E7,)Ra,UCO3PZ
6#ef&T?TJJ/7We_I8Bd,b+=F]TTadFfe_D:FKec^4J_(B@WN/0Z(0aEDA^+c6BOV
J^BWN.L<+GT:]#9d-N/R^R1eASE+RR[dGU[(R-@]L19,ag3SZb=YcZ/;G;3)3,+V
\_>^1Za#aFHZ5AIH^:LD_:UNV=K/f+^MM=FOM#<g95E??IY]<f?AN/ABBP?R?FK\
?M<7FXU=B3XN@P\5N,SX[-Z2ME2T5LFL7=)(1e?f9,a5[-8<UL.-L/:C=Eg0VgXe
@1ZGH9G^LZ#L;&2-KKS[K]X11VK)>3LT)1LKIZXI,UY^+(H)7/]6:=Y,LB8T.X2Q
6B)QB/9.7+0P&@Y)FOL1Q-\K.5aZJ0/YC_..76_ZFB>&1L=cGc=&G;=;c(;F/4\U
Q6Tg0BTW;NU/#3\6,6d5b@YfD&U9@4<AFV<^&[]\3gBGUBXI;HU5KE7MD+\JQ,;,
P,TE;B,0O.T5e#,,Sef<HfY.N/[0=>^Y,LFLPN=2H+LOO]&6+=[HPG2U\DO_<QV=
]N2^1-DCddK^(Dg)@]EQ]T6FRE]FLg_E?HaSf);_X9F2c-acBML-RA=fa3FM?(?W
)e)>]3B3f\]cK,+6Q8Ja^734^]RfQ+>b1CS)eMZ<9CO+-B\)\LAc5(LNQ/d?Eg#f
c)c[X&/,?=H97.;Ee=A6:5eENB>2@X<c0.](>7R5ZJ3@?(HIEe?L?@bK0F&_eL@U
AR54g^=?<&H&G5D\KTDRPT]L_PP[QdE60Z)RUb(N?XR]f7BT9#^NDTCB_G0)D@(\
EcU3FgK6.M(AE1\e5A&25/W;Ye-5X[]@48_=YYW\(UXI6GMDWRTA6WPNd7T5]Zc,
=@=@OW]a<^KLGW/1HV#0ad8I:@5@AD@;7.-+#D\8(JQ;F&,0X>(I8]U&b9@/#JE>
cV>;egB;fJ9^36gMd#ZF1(D>-DCB;)X55>4>[=L58]T5&O;[?QEfC=P]T&C0bZ);
c@WNbW(>_K+E(]9>?/,UT2DF6R(-R;D(7X?JA>,4cRX(4R1T5dD6,#6-]TKF+8^C
#U0^ZV>/M#Jb+ZUV]8A)>7(;?L@TfZ#J^\,1+<ZF4KY-O&99)ZWedI/C6UV/?468
e?5f\-?N-J6b,$
`endprotected


`endif // GUARD_svt_apb_master_monitor_pa_writer_callback_UVM_SV
