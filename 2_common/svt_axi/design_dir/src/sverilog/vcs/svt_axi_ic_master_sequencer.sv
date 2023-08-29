
`ifndef GUARD_AXI_IC_MASTER_SEQUENCER_SV
`define GUARD_AXI_IC_MASTER_SEQUENCER_SV 

typedef class svt_axi_ic_master_agent;
typedef class svt_axi_interconnect_env;

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_ic_master_sequencer extends svt_axi_master_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Tlm port for getting the observed requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_get_port#(`SVT_AXI_MASTER_TRANSACTION_TYPE) req_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_get_port#(`SVT_AXI_MASTER_TRANSACTION_TYPE) req_port;
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
 
  `svt_xvm_component_utils(svt_axi_ic_master_sequencer)

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
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
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

endclass: svt_axi_ic_master_sequencer

`protected
@SQ7P4R#:PRN_B\F8&CDYWOScTSK2BR/ge?Q/D&@3U&6>bQgDg#Y6)SZ;#U4+;D[
ZPd>f+E1H581cO74][KfM5.J?;.Ve,bC:,+GSNE=4:eBMN:PcD9_X(aR<36FH.fe
/V[-=C1^L=:^_TN7Q2BRf3H21K89)[HD;AW5^b><LTB&6J&,VQ?[3[^7b(=82gQX
Y5\S.9OHd<?]g0S,Q\_E/@8WLT,/^CSC:QC:d?2B)[T-/XP)@2@.?3@cMNdA]>>g
DQ=/K.&gA_H2#GQH2Q9]H(&+@Q;H16V-M6^,JTT??N5U:O4#<>(+(6Y6-?:4?EQX
;RP__ZgdB)EYaaMg7(1b=)_\.=)8)3)F/Qg?a:NM.@<XE>G,U3B?c5N)P<EFTc@b
UYC,67:#2B7JCIE6.<RDQ<B\97YMLH==(SOU41:M;H9aWBO7IdcWY-=XO@#]f#1]
=bDa#[XO]?F&Rc67(JbUMF:-ZVJTUGXD8cU&@a];P2/((eJ_Pg]9:J(/]HO3I55d
S-YCQ\S65=I@>S,aST-L\,9_/g,3[3^Y3R=3J9\SYRD\YbZ(_V/)8]_&#RAB@-MH
E_g?<HFaX@:REVeRbf[X(d&DP=8&-4M]&/4A4bPGa])L(Wb4[00/9W>bH&,^1YZ3
K5C;1L;\)-KVB<;19X)_4WeAZ//HP+._U/=)9OM/>=YVNKTHGT576D4#.E:cf>&@
LLg26f/&ZH(;YG>dcZaa:#H9U\Q81e#QdLV5aT7WXYfT0O\e:42UG,+YK2SN+2WX
HVVJ\V&T:=:^G.X=Y08ET7/FFG0BCOS0U[\PdWX@M/5O.gL)D[XOK&A;+2-Oeag.
?BDGN<IcR<B<O7(XPQ=SB\N31D.9BC7Y7H3MB4P,E(GfDJg76-[ba5XP=Ac7)b5X
>&Og\R;,ODNTcGSec<=OL/>ea6ED>S,WK#Oc+RA(N;,M473\@WDd,K070e_\Veg:
QLaY^COZ9XdJ.VX7-7ZC\gR=LN4^3\_&DT.;L&4RVLgJa-d\+cKd6MBS712^@[TJ
TPQKQDSROZ,d#b4M:D\TS>SQ>-IB[]S:(J_:@&aAPK:ZM,1d,H)+)+?]J4.=,P:H
T]>f\(Da1C1#4#AQV/9/Bc,-B\K/=KHRR-JMNGA43G#9J.XPaS;DXIGYNTG-T8YL
aYc,<D58MQJ>S^a,53\=VOUa#.+9N=?&PNXF6EA\&#@-WG-8dSKKQf6]]bQFAD.D
&;CGAa(N7DPb2e]V+CKM04LSHN9?C=R41aNZF]LH;O(Cag@-/T#C_=0#)L^MMC^J
<J9(G+PfHYc_e(@cMd+=E>]D1TLNbQ)+fJ>/-?FSE4/,aU@4+0;E;)E]4#dAM+3(
6_>IR32J#0Z:1Ge:Agbc]9,N=1.PDA2>:[/d>WBXA?H\J3[[@V>g2=S3::2&<8TQ
?S,aQLMY9dQ(,K3P.beF\XaZ?2LIIeS+L[XD&P(36.L>EKGcIL9fV-I-76;=40:C
&\C[=/feCIU@6DB[<ILE-&d3X2^V87]09LQ/8X2.//R_D(V)>Z2f)HJ4[-DIbJ]V
f47bS1KY)_Gb@HHT+CReN+]AF.Z,6AKa)T-MGb\S\\S4H^C050g2E^VX8IW7SM71
fEU-JQ80/LHbN9V2A:;(&:2TF<_@I;;SeF3R/<bP#-9U-K1\Y80+6cDPYa[e@SP?
@>(>Q5OJg<Z=f?UbQ@6G,4B?V80?c-aT<]f&GL#@9>#CXW,Yb/#X73SNPA)Tea#-
eRP-Q?2eH6YJAPBK<Y=W.#<M0&DV8?dIE\/(0E3Zbc\P/(BUA,dR]Ee@TGeeaQ^f
=1FC/?A?@&JLFg^8,B@TH/ZH]g?8(RY>=J=7OX25dX)_JDIRRX-_U#f?KM)?3J0,
;6D[I1=ZIaX>L[@M91Ab/6S[5?bB<-#Q/GgCD<TUcKYWH7dI?4VE0D][f1)V^\OJ
_COfLHF;fEY&VNVU.=M,,E=8#SNg<A/I=T)=-?&YL57;.U]C>gUC7g\5Q5W0RAQg
S7:58GJ(1Y.UPI5>5:=,C=PXf+@YI>SG7\>UA=04[LPGd;)2YU&3.e5eJR2K=fJR
Sc+SSNFCVK0bcMT9XPS?.>/_d>H5]O@.QN-b6@WE^166/1NW4IZ-E]A)(1PG^O.H
X)SAbA\RGd/.FC8Z;B7RGBg.I?f<55P3U##K?6^X;;_WKVN),D(cH@F.KSZJK]^D
:G]]G7Sd4K/I#/=@1[CZAN1U=R,aR]3dNE?5_4^02&g0eX(X7LP/^T#=d;7#^<4S
K&aGB::bd=4&]c+>2=N0GZUQ/WSc?X0A5.5NBT<#\_X(P)ERT&>]e;\)(<SNFG&7
O2L8SY.0OAU(B5Y11_B31+.#RPXI^C.0WXF8gKVD=B.E2T[E0BU6-(f#JOcc=BC0
4,O,aB/e(c@=f]7ELYaRgND7PE)#a#Y/+3Ld1gLde)fF:N5X-NZ28F3]^KY@?1YV
?@,VG9;Kf=O^a+/(f)U,S1dA)E2TB(5+BOXdHBU83fU/(gaa_[=D1_EANM@M&(9N
OYO[\VIJ01[>JL.Y=cX]PeG1PNd,DN8;e(B]4YGfYdXX9M/BMf7U8CH>,T>_)I1K
]I9UOI(K(d9fSH8AG7_WH4a:&2@A>65B@&PEfC]UA&H#;Y-OTHZ6-Qa#>67#eJSa
3\8LA-M9d+\)SS_//T\Mb5PW4;+(BVbA;R39aXR4F])T8S+bAIAUHYa:D7?]A^Hd
MU8+TJ&.Z8[,J5R5/^e?.8YVFZDUR<MT:1+Rg/,3764>0PcNW+dBJaY5=&SL/ab(
\1-3Q0aP-f.1U,f0MIJa@-1X(+MCPP0e/d_5Cg]G8DGgCZ>8;C/J@eC10b6RYI(R
.K.B9:KEIW3g:=+:<LHQ7Q:X8d5A?17_dZ^C9@QaE5Vc;e8D2Q:Z=cV3gc&>(/X]
2,<T2][\S3U/0MegB#?NWLYPF\BXRRP90MB6fRC(^19_G@+@_]1@CRBWK5[X\GU(
cB_A\+3,JaHX634D26__<T/G?,-+(eRH@c,))(&c+aeO_9e.4:_#\,C+-[JR>EEf
a:MZJ>cHdR09,O<BD+7(@O@H2bL.=NfS(.A^3[9S^C-XJWO;-eF>L-/^IN/W^;I^
D/0H&I170aRf+bC-_#/-bT+7@#RA&bMMb//7X=2c)TE?IgP(@:_<]bO&8AEfH5bS
eXC_E8fQC:UD;<LBP[E-MEK8HB^9)-MdA/\AFHg;]-4TfM?#N@NQ87=N-HX63^^>
FYI9SKVDR.WgY^+]:3_[6WL(>@=.VL<S8JL<]W\)2\S=N6?V8Se<:2\&RK#NORZ(
d^D-D9_=]^9,Q1dU).OdHP^(g6?K/ZIM>-/>=R5a__c90FP79CBGAOI5<<<FAZO>
D7JL[82D4+O3)5X][B8#TN3=J?Yabcc\;&W;WK.EH[F)2:0d.M3ZOP=C)bF:3J47
3.QJ5SBDD<,U08fA+^Sa,>,6&aVcG<)+-Q8<:1FO,bI10Q/\0TZ@Q,67B)-GI7#Z
W.PELXY4;_=L#L[MfCfeZea+T:729VeEaRS3DB]76#?EZf10C_a^dEe^e;T?+F=e
]4YMP^,?9FaI#,]J,5Nf/O>J72PA-IGU8P,YZR)QcA/RIPLU?DZE-U6WN.9SIA/C
RP^/NG_SL(WE-0<6(g7.L>AZONa_.E1B.-3JSf4U7?MeEb\0T@QAGLAG#ES,51bE
SLG:gL.HMMDgLLAWTFW>9YY>d[LB:(AODAXC3E89a-ZM(K>AY4NG(L..Ug)6NECb
B^fWFc=]g74&V+ORQZ#:aCT&bFO;,:WPU9L9d9TDWZI1CNE0b;d<?85_14eV^K&O
La=#>=6/g^@D=S#G@NMg4cSN4Ra[#JQdS#&(&LYG/?dLN8&;c,VMN9[FR81^.YUV
/e?.D+eb\dQ295WS@+Re7?a#5<A;[YS=?WbZ)<cK+c?6;-T5P]N@e1_>B9)_ZIZ[
VSHBRf6/BYMb^_JUDN<F0:))DD;JbYNGYF+,#f\XUHFf_,;]SYD1H-a@;LETJO/N
E9Ng=5DIGCa+)(Ob<RJLe,c>&)E=A^b>#BOW-3<<R@;6\.,I.IF:F7.fXQ(>fA7]
]ZI0Q1?,<9fQb_BM?\NW=;\_8E0G57KbN@V#]cV6fMO6H$
`endprotected


`endif // GUARD_AXI_IC_MASTER_SEQUENCER_SV

