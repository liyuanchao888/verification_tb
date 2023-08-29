
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

`protected
4FAfU_eMA&S.EH^E5B/3)Y,QMP?E;cEID+0,EIX9;@\^[RRQ9[+=5);L^:US0FEV
;7J)Wab[]EU.0$
`endprotected


// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

`protected
#?B52X,U+_]P=/K@&@bMX2L376<e]c39ZGEe32bB2#bZFU7/2E.d3)T+/E+eZ&6H
_M?Q8WQ?O2NP-$
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
_dCcP>c=E5MD^?g>)Z^>?8Z^5W6DP7;0a9X3G6Z?]V)DQbHd.T:<5)abR<RW<QbJ
PT)Z]N\N-N0D,$
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
4+O3Lfc4\\X\,5<N]L+La=MSFE/4d@--F:@W.&)P0L4J8IUU-+A+1)QI@X5K?;K0
5M-Z<Xa[PID\/$
`endprotected
  

/** @endcond */

endclass

`protected
LV)Gad2L8=\T=eTT&M74[\JNXb#,J/+UfPYb.3-E::OWDE+?K]aK1)=2Y3b@;?V#
df=B&(^Z.5XV1Y]eAP3FM,d5d)+dN?2U_A@=@M3Zd&+3VJSKDZE^VZ;L38>M1T@[
&<-5_<M7)da_H&A?OZ^c;WWW9N#IC.,TAHS]fT>J<<(.N+Y2I&K4JD+&.4Pcd8(^
KXdPUIcGP7;f4MIaS@>YN7Y0[=[Hg4^fd676YPe_G>,L-KfI<)990[@3fQ;]Gc80
H0-QdGeb(bEJUBTa0U^D9O2?BGG+V7WD16AHH/&S7+QLB$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
9KJ[IIXQB[8L1PIQg,[QLI<]Q>/6]\NK&fZE)>02M6]/gX4<E(e\+(D?]dH2XN&F
K1(d#E9L3dDG_APZ;WM8Of]UN=V.YbDB/?8)0JQ,=\E)L(e@GEDD>;>;)-OKc6d.
bG;-<(d3;_)F1a<C\6fNb7^A,8O+=b@Q;R559-W)[_eSTPV(VG(_D1YBV)<XHRaJ
K4W;C81fD.#1Pd9O6;QFOCe=&ddDVX6eb>MWI_7D^B_Kf1\\CE5db7FP9d1NFE5O
b9]R=JE8-gW6MbG^JV=,/.#/5,dCcAS#Dd#SUaYcA)1f=_cXaTcCR/;+.^5:Q+_L
/1fZ#4G-SPZY>P1XU-7Q[+,X:].eY[J[]O8KLaEV]dLVZ)f58-LCVfE>#G-c^G.,
<fXS5WV?^E]1K_.MB\cNN])cUFK/&ae#@JeBGN9WE]HG+<=(3E/BHPI9.T8-J<c-
SKSA>/0UX(ZBV3DQ@HG<JDK^0;U6;P?RL+Kf\8]@,^5d9),ULIb:/,@(;M\_,JM[
S7LOTb8PfHQ#A7dC@W4/(=Z2G\eS_OV-_6NX<I;Ga2c_?<)6Qe94XV:3WS)g@IC-
UXIDeWP<?1?VV398YL^E9-J3BHWLQ;MC33Ge//fc\DDLK^4U?^aDCTdD8K1SWZ\I
fN)FB.I6P+fU)AVPG])-a@9S/WMRI_bNIZ:TO0KKZ6,9QYA+IP3.9?#E:17S.:If
1EaL4EaXZ/)&]b>3RV]H=I3dH8ScS7EXR0\?a2_NL2UTL\/#/.b953>6))NJ,KGE
]VeC7gU]:5F-faeI\\&4+ZM5)=caL;:=)_Q9,MR?#f4;P:8+#dOC:;Y:7UaYKRD]
f69HE_\#4E-Ld,f)&2>/L<2,H)5b;:d4@GT=44I0(gDg).eaR7b_fdZLX_eDCJBC
C65a5N##Pdg..RV9\)Y\9#/&X[P/R7&Bf((cIA/Z6;G@UP5;\SH7Z:<@cPg^..-6
MFU5+A[c9+.E=E-FYP/9/[Df2Z[73(F_+B4-PBHVPCV3E4X;^d\)NZ\U,E#_1DOg
M>0gc29fI5HD?9+HP=L?S<B-#9a4@>Kc-,0W01dOI@MBI\0W^0G]PM\TU;WC>7eJ
(2+_P30>5LQFX[1bU<9?gY6I7F)(R04_\dIW2;^C7DcfC+bGCfbGQ+#XP-6TT8K@
LNQ3JZ[1<:7eT1JM?Jaeb3IH6_LaVgeK:YdNVd_K82LBgaf_^@,H73[2a?cP\S1(
SPJ4X)Ed(F(J<NQ2N\&&AFDGZ[..b443Q@7R1PZE<_ELM?#Wa-J88g4K?_&0EBIR
^RRa,-9>Y(=I+WO]].WEM/dX@7&O8A;KC9\T)_FMORF9]:#67D8fHAAC<G(d+/b_
P+T8?Q3b48cbLAF_[>7Rc#ER@2]RO46BLPW&ScFC<HJ0VA)A/_:08AUN>?I]=-(J
T78>AM,HPR+6-?2fT4=8d-G&Fg8d.E;@Y?g/,/U-[7PDM7L+af(YO45&dR&[F+RV
JT7B.SB\I8LR,+@<^0gH3Sa>f/\XLQW_9J+S9<ZW]CV58_59=XUfO^c.bDU[[=5E
.G+MNdHX0:1]QZOb;AaN9[&TB09:9Y@1aO_O-,Q+b2B#-KgM]Qc+>6g=Q6QXRbb#
[>3=AgXE7d;]R#Lc6)c0_.b7K\&Mf;]=98&2@^.Z.+B+@?)8PO/GFD+SZAb3:SOC
\,b.gWHFAD2BQ@KQNV-[CbHF2,EDKAB:7F>H4gKWfK>/9VQMb+7L@T??.dG)YSKc
[0DQ=FQCb-)&SDQ2R\OEF_Wf++_X211gPf-.4P4IDMQ.5g4ARYPV)30^E8;2FY2+
Y[:BaE.\FW0[]Zc:f,5XTF8WVFGTI&aR.DTB5/N3[dV?A82Od=E4JMJ)H?fWC.e&
W^0Md7.TS.R&2?fIcUCZ:8Q2OYg#&6Z4B.FSW#C:=HOe?@[G@\gO=a^3F@4<BS@4
\TQg40W3@J01D-Ic(ZbD\4U2U;#b1:^[<#b1.#P-Jb]E3J+&NNg_OEYa#_(C<1XX
;3U;G:QIB+.(ZVLX3;.-g1/,?>9QZU=(4A?H48@B2Z\+cQ\&,-AM)+cZ-GCee/WL
:4N\Fd2D5;V2_E^/c8M#\H)>J1N\7d08H@ENGTSSU5:P,g]Q^B2?B5QR8?:K>dO.
.7b&Y\;NRZK42=[4Aa./4FDY/SYgM?3JTe;UMc=&J?&c,>0ML55Oc2DXAI0GPH;[
R92Y<Q#WIg>:ODbebQ.3KL2dH89@S]5(EU@_:(<NgJX(GQ[^(BF=>V)7J5>Z.>4b
=K.eVaUgPMe=@bS^AAe4&3]Q<5+\Kg0UUAFFI:e@?Db]a9Nd&X.A^RP^X)E8T_H.
@K[X]G:OMRPF4^K7->(8:R2B-?U5.OdVL)EU@,e,O3YX>:P7@,:c&2b8agP6Y7]C
@5\+T2BDeHB4,]a\#LBSU\-6aEU&IXOeM)edMVd01EO>&3D=<TH0:K=7TAc0Y6/g
4IVYT:VZ7EVLaQ&6bO^LARQ4WV)^H\,.>+5b-&@_^^Qb3d_S?LAMD+L7APcYL?DG
UDE(#X(d@:6GI@db>LeZ8c,IGa,TOVeE)CJ5WWS69T</A&RNA:6[U4deAd:DL_-g
)U/D<[c:f;[.5,HSW0MFCS)X:AY@,OJDOUWRQ4aMU7#A?+RFcFL\UGdeI$
`endprotected
  
  
`protected
LPM_LSGO>MZdGQD,.ZS12LQ7X,B+bbVFC9SeIC:f&a?EA<CB^VH.7)1+dPcVaYG?
11V)KSJMZNcd/$
`endprotected
  
//vcs_lic_vip_protect
  `protected
]\C<=K)QY-]1OF1ARC).VXFC?7/d/^S.e#:)ON,Hbd^-0>aWP&d(((+=0SF=OX7Z
GFX(_L^?>8UI@(3;<RP@L5#RV8CI(IPYI.5Q^THAA(KN\N4\E6ARGNOAL^J1\SSA
G\LPL.H;MGCIMDZ<a4ZYS[/@Nd_3=TZ@8MC<GJ54NFB6S348+;]eQ/aCF=^E6)dX
VDa?-cL2RJE@<A\#3==3Td5TL]L]eLF&d6[eV@7TY2QE,+<PJJPSF=U_&CB]E;R0
d0JKI/L9;@@^#WJ\QJcS0JT:M^NV]?2@&5Lc2Id]D(7cb.&<6L9Gb^R.DSUI-DAC
DdPTPH,.IK2(F>#NQ8RBcb3cTJ[)R0AO[W5/;SGSR=8XT0IF#_(.=]#-QR&BXM=3
U7E+,(+GC>\,)@&0aM5-PB^-58H5=FETZ593,:7gg&J8))GL&e5X>9#-\P0=C25=
0BT1/3WXOP(2(_B_)9F^78cgeY=BSUWRYZ\N6R:9fJ-):c:T3d/YY8L>8[-?B;Nd
XPC,)N3-BdgXSd3PN/=3),;B(:6G36gDX>>aYX,]gYFEDbE#g<CcSRe:M@;X=;^/
]4]1V[Wg_GR(5EH_-8]K)fM\<M,B,7M1,g+]=##.4#&YP5ZYM<8^@+\_)^Z+5]2F
ON=fbIKRb]-?)V?B-SX?,1=Z8TVK+/?ZV6Dd2S69Y?XM6acEcN9,D7IUFF/VT4+(
Le>3MS8^#_IM^(-@E]@S4WQ;]S7WW<)6,c7#6EM[,)JUS&;\,Qb1)e(G]R@f[D7@
-T08RI5GE;cGe&+=b\WB<[5CZD3&R).35IPZOLMU]F.A<I8)/4?J5&+F)O-=9=.T
f6(@=,+)10/R8/5NL?3_0aA_UU5[83Z]+:>#@M.0QYF+9#dXNU@/6AOZ0ZW9a\]c
RA8^.G5013a01fTY(9BdN^CHZ_VF+&:,f&KXa^G)>>eZH3T=1d_1\O#cbW3O?DH1
[IWY-OH->_;C?F@gUYN[HYQfd?)D7DC.,-b.<Z-2^DGN^@K>UdQ)M_>KUK#-D\(U
BPOAG7@]D+IO@4I@]Q:FV:Ra5@/MD4KRRPfL0=5g5g6J#+\aSd5b+J)>?9UHZWdg
,/OPX=T[Ad^=4O[JEBO.U>5G:HSYY&0R]9@^[+IC@fKH\P:OA^/NbZ)IIYN,EG14
cW#a2QRU\H:f1,W;bS(Nc.G3^68;N5F+RKK4AE/+WI<9;dGZA,=#cOW?Pe_>I>DX
V+4JT(FP,1<b/b/D]H20)a;/\/CR:D#P)L82Q7OHGe4X,H-)(<U6fcfR^1_2[),6
)NA2@a+8YL,QEE</=0>f9,8+-,.=F1&Dge[#)6,)Z><M5;I1cZ#IdSM:9EXIO(_\
]A1LbA.,-FZ?BF^R/=-G<SI35H4U=X6(?5^0L<\,W,bFL/G_7-eO]&V5+-K=Dd,J
fGNKb\@0bd=e:,c-AYU9U.,<>+A:d;OP]6-,LW?:)L;S[f^CJXVJTa-K/<XQ8gLZ
E22CJ<M1MR0TR<;9^5Jg-a[>LVb\##C0ZSOb#NaL?>f><cVF[7&1L+D>:5<1&.S1
XE]L?_#)C96/NKLS81>O(C#Z+[K7BNPJE67Gg7A8N5W\-_4ST62:cEcOU>1Y)N>/
LL;3L&[f,Xg<^?KG/#Ycf@S4[5S4I8JDb,L_:Cc:-?:76.VJ3@gT-HN,eb-b&SMX
(:=#c3U\U9+L:a8HF65:;JQ<G[[&IEFCf]QN4U:^S?eUD@GI2da.c\\IZG#/\V[a
QG0IHR71Je\:YME^AH\:_]^F=0J(7/5IZf,E4]9FM3##5IT<IGa57Ba\>/b[0Lf#
2eHg/SJ_A)6K1TGSMOI>Y_1C7?E6:CK5(7607W/50_d+9]5H#559g=N^A@^@dZGK
b\0[^ULDCT_47Se<5/c81JYd[0C>g57EU4P8[eUS20Z#YB9N_B-X[=gZcZ0QcG[&
E0K>IXD74.Ta1g=M?U>B@=b33:B1T0f&d@NF?49/3-V5^(E2,;G2RT<0Q5I7L_cD
c[.aDW9Vd<GDIE7PEBJ_dAGN&Y\T4NB1TU\-AD]IPWPDDO^2dLE+#]M)cU.18_,.
>3HQ^d4Ua=83&7S=(DaAORX,9fbZL^L]7O2G3GgW_fN/NIKSaU<&7?;ge?]b-.PY
d(U3d^(_Q47/McQVd4H4692LZ_=O_-KVX=]^G><]IF-X0SMFI;bDQb4G_LMW>DZ0
E;G&AF#.X75^SUX(WMXLFFV_W8W4fD)Z(J;]^2UHCaD7]U^<LV((MV;?C4O6DO(R
9Gc_S(R:a2]\DdX[:^;L[bfQUJE@7fM)Q7;g=N]0RS\O?T97Ta-aOQUaL>DBbIc[
WZQc691:F\c:X.PG=5V0K&EJ8;a06JK?D0/Y;=+S5=2T9[XEZNGcDDg0XKJPGa(J
NZ)+.3N5>T@MXJG&Kf[;f)GcZ(D0<LNZJ0T[&4KWQYb,A>S/L2YXE>+fK[CYMV0U
S9a:c>2(LTeF156>b<3<<aXW0@@3J1_e10]B7ZAW4OR@2g:OK=Wc#2B00DOg6GOB
M.b2g]+P[(Q(&JFb(X<H+AL,?+<55S:eFc<FMcQa5^#-VL7G2KAM,BWQA(./IN;>
.PB_-LPD;T^9;Wf_5aeBgKQDP?S6N(dJ5<R2B-T;Q@EW=^@F<dX_O(8-_1U0fB/Z
MNc[Hg/aQa2M^S/&TUgB/:22ZSXBXL:e1PG&dd=4b-&W^AK>R9KRbS8LDdN6Q-R<
4TXHC^QQG#1f.6]6#+TD>YS02/G\A1J3(5I[KNH<8/L-Ob9NO11P;E?077Y?<Ef+
>EO4CF]QF92Me_/.(aBfX7R[Z\+LQ<NT>c[]?GE]_@M3H#?M,W+3<-8/_f:BW](C
)#)MbaWPcSJc>_#ddEMNf0N8,2:/L(&405M#-BKC-NTc#(a[:X(IY71\Yc^Rf=V;
Z67],g.=7=5?4FDL6Y]Zc3Nc(PC],,83^K@WGH&CD6[QcEE&<3b.9W1\O$
`endprotected


// -----------------------------------------------------------------------------

`protected
6/:I<c0Ba3c^\6YaUVTdgXA),7KO@B\QeVG/&+8=C]dJN&NQLPda6)cf8fQS@aA,
GVfac@YII3H^-$
`endprotected
 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
M:Jd\N/?[-Yad7Y1_LNJR>;+.BKYXOPTKMM<A8EUD;G\#+J5gE.L+(5]G=XB+_/U
03&GBWCdCf1U3=>_AD[Bg-WZ1D+E8];8L#g(b:OD.B&)@BNIJUA^HH/bg[4+&:SC
cM7YR^)13&;ad?/g\]+dgQL)JIfH[._G3(c,&:U+SaR](79;bcd,_.<XeVNc6J?S
0TOIA([eKYV-,Vc#4@[.GNb&3cLaGeeKG1NF8&OK5C;1LX>P[?>YfT</dW/NXf.ZT$
`endprotected
  

`protected
?/L[9171.LQC\Sd#<A76;T0+,&C)H-P5]aeeZ<[,d)?X+c6CM(FQ-)@9:CYH8QDO
DW[^H;]G&8WC/$
`endprotected
  

//vcs_lic_vip_protect
  `protected
HRB^8N\@Tg=NU]WA+aY-\C)DV.01eCRI,U.984VU:[F#.UJH&]bU5(Y]0DQMAH-N
LJ>XUL3^)bZ89;\;Z4b^@DaCeb+D.EKM;EagMO(?2g]K>6g;gXW]aOaG;fe(\)2,
YT,7eIR8)g28.$
`endprotected


`protected
.=\J;Q.D7ZNE^^G27K9JgT-ND?JJbEM;\9(dc]G)gCF)VbAA-D+(,)cJ)1F[XS2#
\Z;P:#U9M?3:>cK_RPSVW2-N2$
`endprotected


`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





