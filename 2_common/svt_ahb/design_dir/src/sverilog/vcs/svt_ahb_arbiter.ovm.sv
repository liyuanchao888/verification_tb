
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

`protected
YS]d+G?b.O6.VGgUTNc^9_C]F6)?WSZg)Wg#N:QOB&+GM;Hc<4#/6)1/L0W&6eMD
(ZVDTA8OV_+.0$
`endprotected


// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

`protected
2>OKR_<[^:46;(F_^OH#d3,P1<B:,C\C6Jd23KaW-g,(-1QA@38K2)dQXWK17PV4
@,WZP;U721E6-$
`endprotected


  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of ARBITER components */
  protected svt_ahb_arbiter_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_bus_configuration cfg;

  /** Transaction counter */
`protected
_>3eKQ<M+-U=F,H6)[Ha:=dU#;NRAGGMJ/60)8^^DCV:cAW:5@O\0)J[_e=9b^Q4
EWf64K9<W>.=,$
`endprotected

  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_arbiter)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------


  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_arbiter_common common);

`protected
#f6B&TTAQPeG,#Y<4V4A&M6d(#OBR2>c&d;7050a+A5\/;cV\(]G/)FJ273VHNXc
.W[4f@EdEQ_G/$
`endprotected
  

/** @endcond */

endclass

`protected
:b2B(Y>;2DB28.a;>f:d2ZD[c(#AHYZ#W;(+e)MZ>dFe/d746\K_0)fW#Xc)NTUD
-d:2;UH;5N#=.YG1F<2GgZb>e+ANTC:(Paa_.8AW8[N&b?>(;IU[4SE][fZE=2=Z
gAOWIc\1GHA,4;=^A/NdXGc=FF/=O7626OQYaOHP?^3+G-M@cC_F??fZ,CEZ91M^
TX&>b=SHA81dB:R=4.SQ32PDC]4:6#5[+g(9^-<IRZe)V)a:W,\CaaPGA+C0H#D0
7U&(62YI@>23eF,O6GHQg\&E.PdY#,KMdNDG7UbbJI()B$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
;4=4,&e\KN4-&ZZS+LUZBe3]F/GT)ffS:TVN\SB;M0D8D2&1T=I^&(:g;:^Tc,Z^
2JOJ1+)+d1>>RQM4:VH1@I+6CM.W26]/::[ge(H^[Wa/6&:^Acg3c-0)1,-]DKF6
I3#0\I?O9<&ABE^]4>cNQ)4[KU>@_:R1QULA79fY_45EL4__XMT8+8MRM@8(>ABX
A_G+eKL4<D.ATT\N3J?EYUKOR<Kc#8FB)f^L\+A>MMD(A6>@^N:JHe6<ZE2QU(V3
fHZ[14;-3b;3HPW/^OG&37F0JB.<-GF<9K7;45GQH-3G5CN;e=SHS9Q;M.fN:_Ue
a8<QBHJ1&]_gbVZcc33QeN&M3@Kf,K6fFPcPAE)6H&<WKT<68DWPY)1#.cJeW7W>
eWI@S>EI7UL;[9=0A09<Lg](#G.8O5<Z?/?3[DLP+5\R?NaN8Be^ISJ?a#-\,G2,
Za?\+O6gLJE,K_:c.d+SH5B;5&gTC>AgRMMH;GGIAgRJcQU51?f9[PRO^SCE6)3b
6JF+LYf1N:.eRaVO4.-O9TJX)H6@/.H_6YX)<JHFP8];G)<cUU7\Y+.8W(b3GS/R
:FPJO./YC&X>@6gEPfLNT+&[,QfPL@J4_YgBVLSI5JIVc)^FbKCYGGf/?Jb_2/WK
@8eC=7-:8A\3\gccb7e+R_I;2^5SPA[PZVR)8ZUJQD+1Qd14M83S:D?+H9NcUHUK
2<#7LdZO<>^KQBRbPED9<]D.ZR0b9OJ<02=Kb@T0Y9C5&TC8,-MO9<XdWa[g&.gf
]7#dgB8aW[Z//@F>&3\&eR5:C6Xe)+V]cb_F?6gP..1VM4/@GegY39B]bf_g[E&I
+g0=bJc<.aAa[cZFT2Q:fNVE\5KA.-3Y[FP<6c8>?,ZH<Z&d+2C]I\GLQ(+,GVAD
4^113MfC/_F=/2fUS>K_SXY.3&7[SN84@4I.,__MW<H@7,LE(8QS_DITV?UL+LCH
;3YN)4RVde1C>._1@Pfd..V+2JHcYfO_:V4QHUgcgK8E)_#G)Y;ZX>TcJ3@K9-\d
=?SCB=#5,X(H-9SJUULY.g1>0a_dH3=e:YBNcVBF_@#&>/c\S,Dc2aWUSKT^I0I/
(e8>b2aDNJ,G(BFX>N)&_U:])AGLO=SE<eL3IgJL^(4E]e:&eV:PaBM5GUQOS/_E
EdP@=Vee&@OKY#@&D5aU5,.01KAZE0\[BddbQN@+&cd2(-g]0M1U,?R>Q&-O,aU&
9;_A/FQ>DPV6Q\c=08,NS/c[,aE5&e.e-0K:N42,?U_=4S<7Cg/).1PeNS#Q+dCZ
;VDWbf[];E3Je#9>.D;)38Bf9<4K#?T#JDSYI+I\]FGNg<0T_B66B8YOg2.GefC;
V&-7GRIT3a,)CSVY38NG\>4TIIg0P:JFURT2((FWb;2W72VZM+TEKI&V\]:L@>&)
a],/20X,LfU1gTRI05<>D@J5Yf7&>.O(bN3W-Xb<P9[RUF;E5YW-H+?)@&SEM_bM
P4+a0)Q;_-,L[?SXMCBL\D5(gc8PDM=cK^E.I:5\b2=L;=(@c:g(Ef7VGE+5U5f>
6KPb#Q_?7YXZgbM9&]72F4@,3D4XB3I#Lf9A2GW<T_3P4A.Wg\@1NI5ecfTY?13P
WT7\B@VU\/6F/Q.cD;J5/3^(\TWK\H<?Qg/UPQC?(dGW6J:TO[,>7GWC,9K=[(5C
f;\<R+TU5K@(TMfVMXA_&-DYV-22]0d1KKI=I,UP;,<SNd1J6;;\6O#+L?:JV9(>
WW3.I?CQY&20EZ?fGdW7C1gO:HK>#H3D6B>dQ@Zf[BfU3;YfXHbAfMd20?AG/)3A
+Ha.Q?aDGV/.48<PcAD/G3YcNHE#_<=]Tdd+#dHfGaCW^gY</D?K6@.33PcGYdFR
JPfC0,ERV\2NgLU5(+^g81VMHY=A,9aKcJB@gLGTGU@-;Z:Z?^M1ANU(5gR<KcUe
I;&Q:&=X.;?g0fc0L2LKCL.5,R07([?DH4U9ZYO^QIcJW?D.^M=F)W]D/g_<g-&<
&W;eRQ.82\J2MWFW3\X;TNXaAQcLOP,7e7.I\_aK/:J_/CHC@U5+R^45,G)dR.fK
GQI:TK^0fDa>c5<DfRJAOgEE-9+eeFO?[_A##U=Z;4463DA(TN@8-T7,Q1:U^gJ>
HAF+aFF80[YD\UROF)KBCSTSRQH4SZ_X27:HJRZ/bPDdDXN@J9(C;E\N2^6G=1@3
WG-SgXF\_1WM4VOW?3+<MR.1Oa&?FFMC?L8^R>(6TM.?5^=^R.W^<AQ]:EZ;3->3
UI&,a;/bY0b-7Z.<9>K2g(595E)Z;KQW3J7?,gHN8fg7g:_d#_9BZ][^MQLDS>5f
^-<c\),<\5[d8b8aCEZTg4)3E@V:?.>N95N3::IMG#c8DL#N\cJg@eUcO9E+>-&]
#ZN;]@C>T4?&&Y)>=.42b[9]MNeW/=#V?Md4cO19QV_S(8fcBS]_,[X\62?3]YPC
6FELZe-3/Z)8).fY>fOC/YF1PMdHYD.-;P<DZC:+FC1MbGP]-V[BLS6YXF0c-0gK
<)E&-eKF]1I1]^I^.FE:S--D)@C94394dM&,MQI6QPS]253#4=E@E1c[2SgL7:[a
bNV#]GLg(]C&SJ5EPTUF8@ddgY]3A^\7:cW1)HNYVHSIJ291]gBDE_c[I$
`endprotected
  
  
`protected
7OHVVYaI)EF(R]6B;0>:5/X+TL9K,Z#]?X2Q8E6Db;,<4<15#8Q[7)Wa2>^7:Oe(
_d5[@<DZ-1W(/$
`endprotected
  
//vcs_lic_vip_protect
  `protected
^2M)]e\E:E8:^SGGP.YM7CA8XM=3999b#2MY9A5V;AXd\-[JcBFF7(V(MK]Y[071
?\R\.,CGE\KGVePUUX8#-_75SbHD[Je4H<2d+N@QL09@R@:,4?VN5SRS0@fSOR+]
OU@G@)A\53g[aQ569M8\QEQ<>b)CN_1f[=9]0QaDUI,^J)>Yg6F[@-R5BM6I_g7)
c@gCQ_4&;SQ9DIA\PWB^^HRT&;e&</bS##(M>O@F@GcFGB30bPT0BO<F,M\=a7&S
aA30PN)<-b&5eP&gd8(\QWSafXB>F=MVA^A<^^)Va2JM26A&\WRG@F>fH<K)_6[_
S(PY.HI6(>BDgV)]e6WcY>7+LfP#V+??6,7L4PW>K)FNbJI/cC[MQDVQLMg,TF+4
DVea>UJX/&EWgKT4OB9&]YJ(9>8>UdB3NCO11R]d2U:L4EFZdD@_FT+)1f#U#IQg
?b6VZED:ESbTR#AD#8&&e)U;f(V.MgA?+U<]N]W(:O,K,UXV)4UAdCV_)e5VV[E\
WbFJKJ423-VJL[Q[JI,BeT6cGF;GL2gbF?F-8)@3(DHHEaWK8466H79P/;Q[]cfG
?/HL]^2N0Z=fW(A3cf#SHO:?:FN+Pd4U/7_.<I(PR9gQZceX(@a[TV2^;^_<1dN8
TY_7LZTT@5^R@PKd8Q#R)07?.3eTB,+3<L1/:/5=+=]^)WTX1L#9#d3,>W,6LM.-
])dRR4aU)NZ.d2_NeHC;(^:]&d0;LMTWQZZMbLFI,<_#F0W\.&A\XH5FL0NF]M94
f),YE4+CQ@?H,=(4[g[^[d8<6OR-HPZ\UcY/X;]eDa521RbQdRDe.VAT))I_22W4
M\,A_.&6[]KCUZV3g&9SO>e3bW+RJ]AP))Y_],Y7VeeE_FCBN0].g)9OA2^Rf1/Y
?/CO+e\RBKDa@C37+<7ZaFgdM2c7M=gBXSKVN(ZMF>-_05G9.YcAD&V;Hg_/6HLT
=QYZYE:G9MGOTS&5T(GM=c-Q]WA;c>30gZ/WdM)Q:J^@e.;&=-OUW5_fdQfZZ>2U
c9Yeg6X.fURBa6&g8FM;@]<f(RA\S2ONM(K\dQG>6.O:\X2U^3,X_D1J][8:4,R8
>\_X9,LX.TB_/;)07T?ME)W8YB[V\b;?Z,?Hb=-O@#9527LZ>)NVMR.ecP1cAM(c
6HSc[eHO_SC=3<[SR5>WcABKbH5b:)MY]5BZO<T:ETaLD7TN;@:):,+gV_1X68B5
g5X=KUC#X;A8:UMMC/X0g8c7D>B,3?X0eMW-GV=[S4f1eW6VQL+\(LUB[1()_&c@
@:T784^3EJ9c73G60/[\L736J5:.?cRHd2F6Nb2C0dISe\^,d:3=MT[b&a14>Cg3
+VDefJC-,RTFY))4A27,]a(F=R6SX<c8H)F&FW>fS9gUcTS0K8e5+F-LE-AYD+Ec
_B<@LgG0e>K@8?a\_DfREM5&<-8E^Ddfbac,J#29\<Z3C0+X;W-A7Y^>b#a?5]d=
UD3WMW866)f_@PLNe[SA.RBL+@G[G0]KGcc?-\H-&0/WS=f#VPHIFWD\Jb=MX3D-
\2fT_+7c.E+HM?,SKKG<;8GD\DHLf7;E\ga3T#-5e8;4D(7P_(-aL@\ABFB&Y\QX
d@C].?6N&H8H)K>MdT+MU-_X6AE7Kf:_M5+#,RA,=CA/VNC:F?27Q=9-FEe59H.g
<Zf;3KY9#F@7X@Fb&DO=[U:]&9/B#0DGPIbBDN;UNY\/(^;<M/PKPEKRA9aQFE3M
fTbT/7<(@V\Y]K3&Fd2MR),++#<<\+dY2)/[^.J,ZPK.ACZYBM(dVdadJ(NeR.eZ
-d;)0S@LA9aBdSRAXR3aO6T#3;R5&AS)V&0[Z1edH_gL#\G5PL=5gV+34@&gFDeN
A>TV:Z[gJJ;XS-_-A3b4A9Oc)e\dgY2VH3AJ/7^DV6TG]ReN68FAY+379YS5XRB;
9-0KEXX=2AOUdF#g#[7;8L>X7/.bO4GAS7cFgCcG4;P\8-\NRZf_E4D.>aAN-(D]
C5HW.<U)X\-+,S>-W6WY#7S&aJ=WW;TNX7I/:b5LfdGJXX0AO2CLX9<c-cDI.RTF
Q2Z4<X+?18+KKU0Oc6@.._aRff2^\JX0&:S_=3EOKT2=,NFM\,6+)>]51G2<NM+T
HYH(UY7E7MJdR\=@OFBC<1MNM@9M^?T@B@9;#,Xd5W>DXaC(D-^d+Ge[XV#fFWZd
BfIADGgdD.QXTFZCYS8MI6BVI7D+-G#eA=^4.bPV((1KC\:GPb3=5X=>K<G1A\^g
JY1TAMbS;-V:>GN5ZDFA=-KO<a2UH6<ST8ScO-gA16NNbC.^BPQ?<C&:1OGDI,QS
-T[5S:P,=IH&GL:^=(;R7,V>R\B7BfWc#WU44G[:NLD=9RcO6+KHKHJ6K\H^>d5B
V,GBA7\M2Q:J^)Y//VUL<b29adJ5BL\N9.7<=Z.SQJ26Ua@L5/73E00&WKQYS6>&
1OZ(T_&,b1[aTF&MOSG80MLe2Eaa2:BP#/afLDK0C(6:c.O23?#TC<7d-[4e:UTO
QIX5aUKJ.F<J=8NAH>KYbRWHOg47RHKORKNJ9G[f5Sc^3D5A8fX9S3B5;)U\dS<c
O8L]3e>gL?E/cITF+6:GPfcU\-L:B2:1](,_QgZYb=\<5>PO#G75:>=EU705O\LG
+2A2IM-c#eCAfTOe+9GC/OH.dZ#e0S6A-7geFQ0c3()8P)MO[V6K,HZC0-eNg,/W
b\;e3bU88]&C4f;437?H:bX0NIP^MB-?79V?H9OHWV:gbC-Kd:Oag.a<S32F5_Id
F&EcK\CD0T7e<[N]Y9563V4D67^:QF?L>\-7-Of5ISEA,FG1P/e9BN]@/#/@=&SP
IV34MTaJ?\AH>>]FdZQUGgaW\NXXSWf)TQ;)&XUWgD[)QQ9P?PE_1ad+?0O)(AHA
V;dF;#XbbH#9?6FDXV.B<b;gH\L@MSO:Ia\6)<4Ld1>#f@(TcPF8aJd+O$
`endprotected


// -----------------------------------------------------------------------------

`protected
A<H=_gXed)3<d4PHOa)=U/Q@]ODCG1G101&fg#14D&I?cMUS?+?O5)Rc8(Lc0=SM
GXVXWOaPTI(<-$
`endprotected
 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
#5K5>.IKgCNHf6AQJBD2@Cb5<G0S\ZP>bTO#+PcJ>4\adD4R\L1-4(31L[NLMe)F
):_,M&M-G4V_KLN&ZR[7f6IC\[5AHMVYMZ5]YY,YZJF&MT+G,2,IabCeKeT^0ST/
dPfO+SDeVbZ0c]+^?&?-cf][&Z<YCR@U@;LOg;gW#=5S36bO46W=cI,1ScTW.L<<
8&g.RLd=C_BX.e@gB4OA6?>P]f<BP^TW2_E3F)AKb:C[U-(R4Bb>6MdP)&,6TFO(T$
`endprotected
  

`protected
3Q-DJ]=-(Ia\A&LW.MX>J@c,fML)5=V5&FJ[e)F[OGRO=c2\GCRD-)Q+X[5[11MU
+KWX\gCIXbQ\/$
`endprotected
  

//vcs_lic_vip_protect
  `protected
POMVf0f&+X^HT5dg1)CO4:F,(\XRb;\;P=OGa0X,Q\&Z-VV0U)@6&(ZMaKZ)D2+G
IC:O(HKea+7KJ2YD&/I&6+0##ITIW+>YSZVHbVYSBM5#7=8_N1cE#9bXV9bU?8QT
1:R0,\CPQU+K.$
`endprotected


`protected
e4c0=Ua9Pe;R+QOB>TC?MbHI&PL-d8/_C]SP,^\T#;:O?=RL4(g+5)SY/P?3Jg:R
/4ZgNa>996D&-AINCBfe=_HI2$
`endprotected


`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





