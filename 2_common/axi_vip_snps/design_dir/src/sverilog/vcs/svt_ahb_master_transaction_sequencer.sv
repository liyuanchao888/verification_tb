
`ifndef GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV
`define GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_ahb_master_transaction_sequencer;
typedef class svt_ahb_master_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_ahb_master_transaction_sequencer,svt_ahb_master_transaction_sequencer_callback) svt_ahb_master_transaction_sequencer_callback_pool;


/**
  * Master sequencer callback class contains the callback methods called by
  * the master sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an AHB transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to AHB
  * transaction(s).
  */

class svt_ahb_master_transaction_sequencer_callback extends svt_uvm_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_ahb_master_transaction_sequencer_callback");

//vcs_vip_protect
`protected
1]+EH&GO2<P\BIGE+U9WBaLe#VK/A(K9ORRR,QNYZ:.//;@Y:c=A/(5+M,b;gZZ_
C@X:dUDP8(H)W7;_2?R0+UH+BULP?#Z9IVb@4K/EH+L2/&Oc#>[NHK]UKbOIR29T
8#QDe;669RM5NJEY(?<&.85]JDSXLP9=4L/aVG)6<5M98LAF;(=SZSX]6KXXf9>D
g/+[PFK._KceA?RcG<ZIW>.@.Ca,_U[S(DSK7BB_9CZUAEd9;?L4E:M.9XJeJCX4
M&G[4W]FU@[4,ZH&6]c=<]E1D:T[857[8\PY,VaO]US0][d2(_1(?X1g@K1)QLG<
@D&?_bVA3cYYa757(Z/ADaLQE.V\6GAK+/[^Q0(J#EHD1QVCD,ZV@-/-ZaYe/##/
+X=7<e)43,<Z(:=;;8O3afSP4UL5]WN]N^9ad&0FdRc0]5I+;Q1WAK.U&Z//?g>b
XLK,HL5>[]OaME,E#G8P\.5N?QR9X5B2a[cCT0MbHY^H(0]a)H>K89(eI-HM.-R^
Z4LB:VE<\Z\K=UXY];bgFVU\J8V8(;^H_fP7W_f\_TLCFe86T;7V(LT@_^d&,>&e
]&;X4^F-J3cP>H.UN>GI;f+_0[0CCNY[OTTZY^eYcgRaLgTbGT[>7Rd\X#I3L&AY
M83[1CWa[&E]gTF(bHJ/3K@,:JTDfBC0a5,&:IVB7Wc.)31W_\M<EGcK:1US5+(&
_14&Tb>B>IMUa5LAC1EeH4.J:HdK<@c9\:8NU82Xg\1-/G(ABM[8N7#O<0KXP-)Q
J0O<H/P1NQSB>c9YcGa)5f65]3[EA#gSNFN4a.0M9EK=ZPPW4J<C68]EdX=LSBbH
(]6V93N5U,&JDb[&@CGQY7?g@b4Q>^[3BbEB2<^g\;\L_G5>.f_6&:C0W([SZ=8A
&g,)^TX>Y>Z/;)[AeO(#>ebMKccO_ab@B_Yd@TBdSaL0-8X8f5BVS=&WKSK/V^a]
gSKTRX+B9L-ZYeJ1@O;MGMX<N@YN4YVO1Sg)L<K@c(Eg=W4DMVX3Y6<,0N-H;/TM
,\#a)XUfP.@@adTXZgW7_32XU+IK)P9,((P:?98^/M5T1JU&U2(3>&XBc?]6O6O\
/L6J[(5TWABOEg+L.DgWbLW57Gc&>?#b]7DQESKDRME,T1WC8J1SWG+_@ZE;0XV-
_gGI/CfNe&fG.R:fG@MAH>U6+YI@JEEK.d@T@70gG[9C[EJ:T93J@VU?FPA.[4\;
]\Z0DZ5A5ZKQV)SYS]92SZKH\6/BGS4VFNE.BdfW<=-A-P8B.)3A>;eJAO6F3/\5
;_)U5;^7DIY(_N(La5U^L-OYM(UFF,H=<Q@M[_=XJXG2-FWLUC5S)#1DA<(JfLL#
S85&05HG^9R/O8bXcfJGNIO/+G^5DLJ>B0g(EQ1J<PIHBX=ZKWd:/K(4dS-aG-f1
2T9XPcG./UK@S.0UgX7E0)PBbUV3Xg>SVG7&^Ze5B/]JA0A+5N25]S?ZE,0,]gZ3
dbRYW3,G44J@?15MgSY#c+D1D5YJT<K#ZY6B;&W[gWV2F/T,cdV\B?5&01AH5P&L
+.-R?Eg40(:@/$
`endprotected
  

endclass

`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_driver class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_master_transaction_sequencer extends svt_sequencer#(svt_ahb_master_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_master_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE)
  `ovm_component_utils_end
`endif

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name = "svt_ahb_master_transaction_sequencer", uvm_component parent = null);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name = "svt_ahb_master_transaction_sequencer", ovm_component parent = null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   */
  extern  virtual  task put(input svt_ahb_master_transaction t);

endclass: svt_ahb_master_transaction_sequencer

`protected
Q]ZK@AKa(HIPdXZ5WI-WdgU[Z+IGYO/SQR3LGed>?\e=>XTTe)W;4)@:=gb>gU#+
:a50]/./QZH/bL>X]f52?OT/^[.I/Q#aNaH89^&A.V:B7_fOgYI:Tf<:4Ef81(S@
?[gN_/N>:\QGYf\F)b_(G2[H-8gSfaAGEY7Hd0FJaH<-=.RI-\1E8#/:IMW6,<3H
E0J<e:f,65d&6a#OO7d>4E2F0M-<cMH;fbY[C#.G=&#d;ZbfJ][8c[/a@(cOQM=/
WH2E;2TcTZ/Z1^>a/7,KE^XZMR<FAO33V&?f.HSU<AO7Z\)[G<3WKf3;)P16Q/U0
0UIP,(Q<(PQ;Q;WfK#0L_TL/dPa7&SL>T1T&dT4UbT0IXS;fORB,W-_TJ]Z,&^=-
+M0&f53D+E?fYC<b0)#fP>Q41A[;Ae_P8/++MB_fG]=3S]IdX8KN;&K6SD8ae@4U
dK[Eg>9,^9+0J?a<<^H=5I:PQ=28I9R2c/33-R7;KJ)=1dZPe7T6LZf/e[9L5D0.
F6+D3OPG/HP3Q16(aS7HM6#19SU_MD?F?06Y+Q>;;Z&_g1CAIabFb9Q87#R05fRd
OPZ-<.SIX6B6FJ>-#99>TFd4RB+UgC69\-YRQ>F=ZOc1/,02MH:eO+[DG;Z=[PSb
8_U08OLKZMEU4E[1eX;A\[HZJ\-+D3&ab,PNFVAA28,fbQ8_KZ&)=>d/fK9J-WA3
G+aZEAD?M/d_,=c-/8[bGg2IG6[1TZMBb3((BHA(5J3XHcIN1/9fQJc1CT;M^b74
c9G&OW4_SGY,B+&[D9Y4TJJ_#Y=8P54Q/J-0JXLIGD<8?JIZEPPC9F6P).-=HK_d
LgKWY+LCM&I],C+1#WVLbGI5\X<YR^40M0=f5C&S6)aIA-&=.RIW+F:T1K_J:XVT
JZ?,M108fFO4SNMN6KZ7SW@2Sd0#)dHgHa;PcW@@WgKD;8D4-Q#Z9O().PS5[(9[
:#^>W^,).RD]2E]8CCZS;#e#ObcJ:N(A_<M&b-C1U=0:KIV<TAd-5L\1[U=T?K\7
eC:PCKJ,>ZUKVW&<^V)A6a#WUVOe^SI4HHYVL+QL^f5(>DV<_R#QX_\b:6/([f8T
Ab\4T8G213HX/[(BKB67;7_X-d9YbgV#IK^TNWH76SUV/D/]E@#e#fbABOOT908[
[>4f:P^U4+2(a)+2]DD14g+fPM7+MIS<:$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
RbE^eLEWaQ@]O51Y@KeG7B2g;X=OQ7.(PI-aD_YZ/b]GG1K#^cV.0(0N]VSJP4,U
(:YafK0(d?Fa5-A\b3PH<08GfSNW7\W:/Sa/@6DU>BLYJ<eA&.[JV=R.d8B7<^]V
,ZA=/X@QW)d]VUV\U8AaKf/IE1_7E?RcA1U?&Q_U&49>7G&Y07,0Z]g8&8(-X3&;
g^cdd.Re0=IDP@O,T<T.6ZZKbY2e@+D+=U7S4;<6fbf8=eg1&N(PX</84:bGH#a.
Z0De]#dF8ASEEbO^_,U-Y&?RKNC9;HH,J@7#D<Mb&^4Y6ZFf_4b[#M:=]fFIX_VU
@@4\A>ZV^4f9[40MHf?5\D:2aC0fIdf8Z#[=\&-3D:PX,7R,fc+347IVWZL4>+Ba
KcZR86CB3@>1X0;eWD=10,?,;18MAGeO<\e_X5ge;[4ZDV0(EXKA#caDM_US+GW?
#TU(dg[a7,a9Q^;5C?/XNY1e5[AT=2_8=[H\9O=/3E#O@/7D06EcD+/HeN2W^Xd:
I:4&<>9QaXK>g5@Qg-YAP_NUA9[3(M&<c\[K(bJY;9Qd\ZHQ2>93GM^85fc?4P>4
AJT3bXGMe2VdVHbRe5IM?;@@SHY3&]@1b4XYJ_>IYQ6LbBZaP3]BJ(BSX-2+#7^\
-0^=:,d_[6Ze6_&Ua8deWbH/U/TY&)@^(g:?<8>,]P=R6a?13/d,]L+]4^#ge:-X
I-2YG2gYG_G]d_F3J;IW)FKFAB^9ed.B//]ZOfUV,/?Rd::Db1>]@/V7M_;R[UL2
d,;gdI2NA@EbUE#-GRDc-5WeUf]8bW7cZQ_N[A4-@43D+PD-:=Yde?8W[I8SB,[F
aA/(efeaVa]>,++Z4)2BJG?B7#9#f3O-#:b^^=J:-<P[)\LaEN(NaCXb4P6SfY9A
O_G+,@X;A5(R<B&JQO4/\81Ff8NG0Vf3)L45<6F0UG?_O#cVU&V&?\Q(5Z=02->]
];cTKPKO?6[=ZHD21JW_)JT&23J.&C.fDPRB0a5/XLL_UHb]4UVM8Pg6=4GNB+=L
;\&5#M<fXC?bOc202@EME?7.?Q?JI5KK(+FHe>0WR6L#XAW(36QV<OCbJ_9O5Qf2
:S3c4=^0SH=]N3G,gUF(Z(f5)RL1_]Q/cLDP^TV3L=L@1LB2QNM_P6aQNLc8a)=V
@29e==L))U6>0/S1SU/AWUJ6dJWaI4(@CFA&IaD)/PMA:_I&3facBCGMKF)UD9Sb
974@O1AG;+NCe6b]61),]b8G\;[&dG1_<QW9;-g)1_NS=&3HeBY-52P,N\Xb0b;,
(V/cf(H4A)H[SD92C0aZO7?:)LVZU1d7#L4F(P#<bB7FXPX,1@[?2GOXL8R/MgVg
VF0X_:X)Cg_c#,69)K<@=69J.B4K5YO4SE\_0fbcG^(IXYT:MgCg<,T5.,CI+;[I
(eUL8Nba5f5S7YC54(1)^a157HaLE3:1LUggI3G=D:0b9GQO95S^J7Y@+Q/LOTRL
<3OAbZNO,a09N^ZRQ:_fV2=fFa?N.FeH^.-),,3T95S]]>/Q^+7Id2ZU:0U=(+D^
CKZ-0.adcVP0dHZYB<N)0d(a8>)3AE8[2/gBbB)f#+\g2>>.@PCdYYW.VHWKN3>)
INef+9E6-MACM2S(+g.P-YJSS@<\(I3?1J(OS504PB@V=X7P(619464dDS3QVK,E
V3=F7NI@TBE^@J?+a[[;_;aI9S9PHZE_LDI[]I65AR9X0c;DW@=0c=CJ8]LQf0VF
.6bKKQ::RC5a37P8Z&&IOeeBd[W1SMCY&WE8Ed:_7@)=_>+4B-FT@bbbM-(e+1EQ
AeMDIc7a\4Q#3G?WDJa7)U.Y+_D?-NNDKQbY-WK^;ENM3WPAD]V8#0]C.699N\_#
0(2(ZB0<PI_]AOA-fTCD__S>90BNW>B_2R<1L;F_ODe>R=C;\L;WW#S>fTV]P.IO
cdN]9PfMW,S:.+gPb/HMe_)2VQ^?^_._92ADS5+CF)PP-H7YK3MEYS3ESO:Y-3OG
JU55.55=N:M;][9@Xd6VafFS76;4D?BN=(TC>A8Y&-NO90213BGRa2NG]>81DV,_
\aD-;&B+PN6P_EC3eW<_dAd7(Z^4K4eAI2FZ)9U&YfVX2?dA\^97aM(SO:6PX:?+
gZO\3(1bd8M&>=<>NR(9LRUJIDP(5@@I/RWU]a20?@A+<I8E>XEg:(N9c;6&P-[<
LeMBJf/-DLWYbdE54SHW7+YU)>[I;DYILgGNLR:QMOTZ.<9OP#d8ID>=RDMYBRO/
&BcE\_^b=;-,,dbXc<SHgI>e9.B6<;BXfXeeF-7@,3=8>Mf<3AgO6F?HA(a.CaAD
Q&b6,IK_OR=LYRd^-aG8&BbKgE;@U\9O9Vd8N,IQIVZ(=FN?=WD9R6KN?Y+0VQ[F
8SY&Ye.7G])_b7D^SB#d<SC/KJ:B6HX:T](3(F)M.+CAO5T4W0#.)9(=3<M9YDK&
&e>(D^FN[F:(Y/_[BN)D5Y&]c.eEVX-V83CQD=(R_eC+)KScg<IRU(1=V9UI4CHB
eJGg]694ME&Xe-dUK-H_97>(f9+IPY;1EG7cZT[WD(&#T/H]AP2We;#g.B8.9Y89
JTJB]LJE/,)^(,FP/4M;<ZbRHb=cfg:2.bS22\@RGe[\GMTVL,aAP&U1,>2EF,^0
X1GR:TYI.Z;2O:,Oc<^^(T</Y-)_^ZFc7#P-,dN-ffgGXS+8W(LB=\5(5gD.?CEZ
5g7.B0[Z1=FgREO7f=.;_(]f(]eeUCQT,ZUE3YLfWINNaBR9KcSEaCL4&#(b9X)c
Q&/.U,f238V3O2I2V[35Mdf1GE35[6XI_K2eIX_Q12aP9@8N4eFI#]8WfUf>7aL:
&XB&EG_(H@/TLa=E&)]G?+YIC5ZCa-DN5KJ1<?LSMBOJEbe>C5?g@[.CCX),B?Vg
&f.R=_c#gD4]X)XXZU(2I2NL2&\Y?K]^ZWF&,Uba]AAIWPeY=O,LIF+@R@^A]Q@#
V^N,C4cFDF6DVFHH(b<1Y/NAFK2:D54.C/^X+^,#KZVQ^YF@>Wb,U.KSB&+a^Q7/
&ZZdTfN;5S95ddA>/#9T.NXfZ\\YY&1FVTH^M3N3C53<NbI)^2>c(R=&<?b[KXcZ
?\:7L&36AP)5+$
`endprotected


`endif // GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV

