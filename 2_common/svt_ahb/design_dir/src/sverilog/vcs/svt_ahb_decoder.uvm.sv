
`ifndef GUARD_SVT_AHB_DECODER_UVM_SV
`define GUARD_SVT_AHB_DECODER_UVM_SV

`protected
U+N#g/5b:J8C[KFPT#Y\D:4I:gQO7YK/:C_:eZ#Z_5><=d_\AJHJ6)#@@LX2K@+=
33SK/c.TV?0C0$
`endprotected


// =============================================================================
/** This class implements an AHB DECODER component. */
class svt_ahb_decoder extends svt_component;

`protected
GKWa\HE#ff+@Laf8OS3&ULZI]1<]E,7U:D\E<N4GSc;S1//c&8[37)&Bf&TMP,9@
87,1:9?XND+@-$
`endprotected


  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of DECODER components */
  protected svt_ahb_decoder_common common;

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
M6LI41SI?1>UfJFaR(Ae,G:JdVUS;4GUUNIB_2NS\Ig/ONWX@/fe6)2#/T29\PQL
c\1VNAR2+d1U.$
`endprotected
  
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_decoder)
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
  extern function void set_common(svt_ahb_decoder_common common);

`protected
\((C=+2<2S48ad:^FO[g)TgJ-5,2#O^<5HIF]X2.M<YM41U)3KLa0)NA8@54+?a2
X\V9S[]HBXP8/$
`endprotected
  

/** @endcond */

endclass

`protected
.](QE(eZ#?/NSZbV__7)W<Y1E<,[XBOA<[fN[e=E_0<82ZZ_C_3D5)<:LU4HFWH9
OOHSX/DPJNG5da?E41B&.?4HHWZLeNE5Ae]P&[4L-A76)9-fOD6U)aPP4g+_eN>b
R,L_WcL>cB<9=S9#8H\7DIg_\0-H:XHW0;AaeH+KcB?E;Y0c:R>D+#-,7d&VE+61
FRS\=NgRg^P7Ud1?REIAL1HJI]8_AHBQW-(?=.1H7MZ^#[OFZe--05:VM7JB3]ME
\e-=R/7fT74R6=CYPYe_9K=:/#_C<GP;d<Y,G26[cK6^B$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
Mg6-eH1aATIa^Pf5<-.AaOCO0]]1?3[EJEHQ0d71X5;?11Z#?52V+(C/NIH44b.P
#?d<@-.9AU;]Q1F@&Q73J^g1TX-@#(aG]@cG=&fN[B-QC:C_\0:3ADLS(bZMUMI(
?(agNH?SWQf1GX=#4?JSH<YNJ1,2UF)GX;(@OX>5,^KEJ:),#CILCY#?C]=<b.=g
>T1M/\;Y_W[cPQdc8_@JYaX#3c?^9Nc2VQA+bL.\Of@32W=^VQ7\U8EU064@40G1
c&>7N7NeZ9W1B>TR3G=Z#U^^Kb0#e/2@Zfd,90<2)Y/>e093_@aOfGTU;&CCPI\R
Jc;WcCAQG<))(\eT[V)/f)?X(MZ>f,]6b<M9#Zb0/B+-[\0NK_Z-&^8?>UgSc(ZZ
XKU&<8)g_]G?Ac^W5HR7(PJ4T5:7Eb0E/[([VF_=F?<YA446S9+DCJRb\;Jd,<K,
@9(I;EIa9DcD1JO?7B2e,4\\+ffPI(H>Ec:-c-3(9.&Q-DH:N5DWU0\QgHBaC1^:
Kg#=TRS=40X>f.X+16fHQ[E7ZD?74.ADEc=[N+[3#-I0@KB,e9)G-J#/[8=A3_WL
U,gPLCaeH\E8:L-86BH:C2S#2<e0[)[\WKZHQU<PfBQ,W:gOT3/+M&QZf-,1^Y3d
\J41e=]f^N)[-3[DC2T&#&=6HX+gJV30TT8.:=L.2EV)RR7XT2f0QTNQ&LdLRVD/
)N#bBeKbd^<3J4SP/bb?+G=;<AKL.#2FU4@c<+A9eDF4.E^4JM2R6<LRQ3cE(XX4
3W/\)88SV>:#+#T,JD1/8X1c2=PMaXT4QRJ\f.b0\.35<5MK-EMI;+2SSMRFK,LJ
IH.)?SBcTIN7)g+2JEa3)LaIJ_JOe?19,BR55WRYfQd\(.R85D(.[A,P1Pg82[-^
]X54C#1gJd<GANOSc6WOADNYSFJ^[F-HOVGTZ69K=T-RY.a(c:[Q<))T>CcE?#?O
V_#52L,AJC&7HfAC&&M#0F=>-9R0IJ/=.[gJGc@(7HGAZa(+PG\a5+,0KVR\]2P;
KGcTQ6MQfS]C=+ObI\UK\b(^gc8@+=7JU,2RfNUUB8^.<[g[M]VT.fSK3B\G+Ae(
IPRa(cK\YL3WW[Q\46Y([NBMXAA9]<N1cG4d0.b1(@>b6=b+bO@+>VcI[7L@4cHS
.FFBV^^IT8e@M9<A&b/)M99R/?;_K6W<J.WEMF?(RMSKf_69RHbCdU(A?I-96.:;
1_5d1Ud/J(QC@L&LBL8D(AaS=_K=6]HNfBfY8T<9/EQS-WJcC9@W3#X:T(??[Q95
36]>O2B9L7/QFeg-3F-gTYKLI@g?F)DC/-:Q_7.<I/5OKC7Od?M:;@XeM/;4Q9;6
##-.H\T;_RH+V]Fe,c\>gC2Y2dF5QM\S@]0JH1CXW3U4\e4YCR8+..-ZRA[?X6S,
O=ggHQZeG214d[MTW&GE^bYK8<829]YKXTYI16?)_:;;Y:&]&WZ:B7-ScJC]ESRE
gDLJ:9#P>gD+T#P)V5D,e&AVNH1YCc)UaZXQ4/H72GHGOQ+/[<g^^a52DTEa3F6P
:[JQ>/2UeLD38[+cI-U\VT4)@HIV>)^.NS[fHa:OFe>daG?=b5<JNEaE,^a8)/Yd
GR:])P0H)GH[::\<8/)_)ZME@ZAM:I.:_#K8=DWBSaX:VUUJLW_C)R6;JG>JUAN,
XNX4L[8350,P^66I#0^:^AaB.J.75VD725YQ6g8YH6#5A^Ac3[T)Q?O89-3WXeTO
(#]V#O,<FOSRJ)WfF3M[Y==B@PGC4BdKK4)A,G;fbUbBXYF:\@;]f]Z+K,NWaLN#
]2\9:\2E(Z]#ZB).gU8@.b:9&&C+Xa:34YGK1)4feTG,cgXQ;-OV03g(RZ9DZ>-B
^\c.De:RAaHQIPQSONTD,F&;&\B^EYKdT^\QaGBVRX)84(.=/KSV&_&1\HEBT/M^
9&(J1gQe,HKbg=cU.PD+/UVb1:<&6@4>\FL[(>J_c8\2DH+I.QDR?Z<5O>L&f[US
#;BE8./@0T(LL(N47Y>]D=W03dZII2SW?#X/\Lb9M9R&Y?C-V95+YWM0PGSK^8g8
N/]D>Q0ED>EceEb=QZ-HLf(WX[6-T:\b\_V&+KgO&F1Aa8c=B,Va4da]4J.O&DLX
Z@16&K#CdD;;A#3\?/=(?/d<bH;Ube1G39,H]]fI[MK_05f09QgMB;L<\1:A7?9#
Ogfg@FE3(7Z<9X6eG&SR3C=;1eZT,8_1f_\PNaQEa<@#U]/W[Y_:=-fgU:H4J?5]
N1?HU7A@dF76SYHL[bDCcXN8:9LPO>R6F\9#JA;M5XWgG)0I\JD+3ND#W.>E1WPL
]@#:GCN)d:^KFIPRgV]FCNMc\4^?:(cQgRgJ+UMKY5Ld]O7(-B8Bad2DD<LdWcWC
OQYb7]O-acc(c+WeIS5Uc=).Za=&(B&T;+61>-cR-S]?\^dgH12_.bHXI_K[FLUX
25TdIHDSc#f8LK44TF^1Qe03F2O[g/#K,MPS=6[XR5Sa3dH2,#F_Rf^4,g()-)7Q
Rf)\5.e/)ST+0f3+Jg/)1;P7,/4a,D<Y<$
`endprotected
  

`protected
SX-FefL5OAXV+WFd/#R&8\3ZKePL+/dfg5EFZA@LS(f_+#WL2C&.3)>I-=63e>&>
])D2CQ9SK)TV-$
`endprotected
 
//vcs_lic_vip_protect
  `protected
eT:RK\aF22X>Z0UU;UULS30-8V[TM[3&N<G8CG]96\X5KAOP[\_G5(C<NS0(,8;1
_+5JI;GN5/C[0F]<3b#G,#>-GCJY4,eOS39:eJFXX?)g:?>H>KF48>Rg\e9EcES2
HgP(A^8c(J\R#6/K^.\YE>7]Y9FQ/Y]B-Wa>.ddb=-6>??(U.dQ@M6a]GUZ11f6I
O,9eN6==S)0P3A,E@7<]C89(bV\T3/W3\2H_POdPSI5KRM33,,C=-NBg1+];Qbf+
AHGG)M1V)B9XK<H&<MF_P#&C5<FPUB-AbR,-SReYM1dE9d3FNHgJ(bLC;QT.Q..H
]FCSE\R[GB\WF=cXa#W<OTfF-=AaI?0eP^R,K=_&c=,<(Bg6a?.SeYR/>L0U-_+B
Rb.NBLZ@40@MS+U0^B.9497JC-F0gCCM,HKY24V,C<eS1&(JO,8=+c6W5P4<(_A(
LA4?,a?G-X=Q>;dg>7+<gCQU\A4DS#(/^(O<YHYY?0,)-gRCM@6J_O@&DRQAg09A
8b]Y\.Cc3V[5[60QLYOcL5]9VIW4LbZ=J9D6A,ZEgSOB?F;\64,B-^.0SJY#+H4D
+\4A/7X6ZK6#^fLU-[OW=M>&2KCY=O2MW()[B<U.a3eN1<egR]ZGX4^D^4C3bMT\
c\JHY(5=&Z3c)4I-LXRFZ[Q0]fJ^<R3\CP5Z?]a/\C4HX[6,gLD04eD(TacA#JO=
?P5K(AG1F_H)@1/D#O51M2Mg?Z(]2.@,IFM=6W8OUdZ_aC^>K[7>Ic[;QJ=.OHA^
CMJ9TfY#J.fTf:CAT0gXOS(P0KC]c:@XO76MP=N<VZ-A^I,2FOCL#U-FT<+<RDZ-
8QBU.(#<?/^P8dI_>R:_+d]7^X0/IZK7]+LG)/JWfdQ(&.cY4JBR1;&H@CA4Nd&-
1,eF_P.J14+&</1a5_;S7(7XT\0GJ]ORY;@@B1Ja)VDG#RQ:^-2/:.Fe/QE-S:WK
6,U<9;5A4c=VSJLMXAHOOP(+B?Zd#F)BQcYRRDC77EEOR+Og=772=KQ4LDBZc:V\
;EaGW;R+AIdZKg\ce][]/M\1MPDa4-NcXQfZAVRCA[#BWMY?g,bSLg35MgS,O4TN
E]&e^T^+S;0J20VZMc)V=SWe<e1aD0SDVabU?_@EW<][T#f5P4K3/4+fZFY65c(@
O32/OW,aU^ILQccVg,ZP-^#=S4IV?-@OYU=e@?eaG3S1d;\aN19+>d[7(5>X1?6(
-^aL6\F?B)885Kf@3+-W.RG,^H0KUBGZE_C^]YeZYAZg#V2=9L7&1?RR_OY)+;,g
:X9MA,;:F[Y4^L21LRZ>e6K9#=J0_C&I[N@)<@E(eGW70V,-b9B-XJP87_O2)U)I
Y\)La(_R6VDRb2L#S-M&@R,]4=aPY/4Q]N80/.Y#\bV+:6aR8/NbXbA>\?3/WF<5
[?\1d1-]B#H;&RSMVOW4#=B/=>aU:A79=^5c:QJUbS+&CgHOH<<#cEN(6__<+J<3
;d=3/=>cc93E6UeAQ+PQ/?<#@87DELSda2L;G0[V[;TNf6cE->S@(43b,WVBQQZ)
6fH0CZK-(R:CYNJ4/We>3=fEdfL?16QH.+IT.<XG:3R.^eV(B,g>\We1B:WW<HYR
.Jea.C,22[EAB48L7UcN,4;,UW#OQUJ.(9NB);OE:-dJ4+1NOPf,X]HLT)<66Y4a
NI]eRXQT#7f)XKdg;C+U,5UG1S?M+&&42PE?@(L=L24fY#b&_.&/98#&7E[>77=)
.5R?<PS[[_;7;#>,_bB</)>2XF.FS3bARd(cY0R<@eS<bHe[:Y?&]c:Y>TUc+a/.
,B_VH\K-f5C&-=\4B1AZ,?@Q\eO+@H=P3JdG;K[^V=6eM_>R)LV&3(MQb+[/JHB_
GKeU_B#IcO&4NGD+10QG85#+KOMfd1VBP=P31FQ3L,5><\gQ:C#J?#5;<FTf:1I_
;/]g:Pe,S5>BfH(/[8Q1B3N,KS0;aFd?<aa&H#3:5PHE3HW:LcOFE/DK1K@J6,]9
=+H2?F.6<9d+I7/X#Y<Q(AS1KFX:/?W@[UF,-JOaWPgUJ9e_XIF_]WGKLU4OGDg@
8^<A:6I>KcD1:JSGMMb)-GXaZ\-dRX#R&<#?cO4G.==^+(2UZI,:Sb3HD5/:-1L>
Y_e3fE)T&QA;-L[=J>]bZVC;MCJ1J;ZNZ0[1XQB3@G=SB@&-Ha5H#6R;I(+a:V>H
;fCcgZ2VHS)@.e49;N<(PFHfba,#WJ]S(PYWD3ZeD?TJJL@gdTM+/#]J2:K8#/#(
GC,8>]EE7PN7_\8NT@4&O_Id4d[9LQ+I68=ea3g>BbXDXQU:f9@PPcaB2,WMU,A0
L=g46(L#12>@O:70W0-EOV17Q:GV1Pg64]PNU/1RS/9R5ebBD:(a4#\&+bHIUP\T
YP=,0]V54,EgRJ.2@-8I^W@V]?#^eE<86bJ8LN8PR^dFA4T]Y#X3YY8&dV9[Yb@N
KN[Tg>^>VAH36Q?R(aFJBc>7-]>W95_XQ>a>7[Hgb)b]@Wd,>DfVKBXc.OY-eA8:
=Tb1??);@@f/<JIJ(bTB7/5A]b]P?8g12Rf<4L(b^2Q8YPA?SgAMdZ>^,7V;-;;(
<110B)P]dFF86c5R=I:cN\3ZP;O]C4+O.63X&IXL,LPTL#Q69_F2::6TBAIaJG?T
V;e/9f:A/KLgFV+/V)S;TWeTF+_Mc>42Y7AAN47f0XaCK>=@cP;E.10B/&fK3Y8V
KY0QOJ>)8OST1ddA(UH,F]\H1/<^0G<2>Z.Z5GQ]Be<.(+gQ>a>;17G2P0[><dMH
:H;N+K?=5/cFY0JGCeF6SdWU&\VS1Z>L;ZD=W/J,EY/PKV.KfBUV9@>-1<0K)<^L
,]2c_=YCH8C/HZK)gC#+\+/e0XBV#]D/)M]])UKa.1PS9C3_1U7.#MG[40eU#1A]
-UO8XO\FGQSba_>MT3g3RNQ,UUTI6dYB]R2V&+FVQXfB^HG@RN>&=,,70DXF;aTDQ$
`endprotected


// -----------------------------------------------------------------------------
`protected
W6(\,gg0;bfK<9M@)JA=eY0e:0Y8YWWS\+A[F,O-?40H>##;0(Y;,)5MV.UdDBG-
d^=DOP&./CbK-$
`endprotected
 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
SK0M,TVd>_Tc&,DK70NEf5T@L._<?-LG?RR5TM+TKR6KAd)7#(f,-(;AUHA(BfOS
P_-P^^V4+UAFWV(^?O48ORUd:d<P1Sd?B#UD-D(=G8cJ9+LFaTF^:dXM01+@[KUQ
+g[-6Td3]V?f#W;KTQAWUaXc:cTQfbB+3c]64#Vdce/8D.SM=FNKfc,@f>^&H]-X
NMKB_B]A<UJdWG]N^D72^A/9?_a(JC0fY=9eAA:BX<4N^#fdBDbe:7]g1DLOZaUaT$
`endprotected
  

`protected
Ca<0&]YPIE5XZ>)ZK)S3[:324a4Bg^1SG7Q,76OSKa</]56,?:JZ+).KP&/6>5A?
:BZ77f/KQM=X/$
`endprotected
  

//vcs_lic_vip_protect
  `protected
@cRIWE8WJg)>=FKe;1DbdH^IeQ>8C5N<SXOBNf\[a=)+RZ9YaFZ^&(Y+d#aF<[B<
<,Q0<P1^@6f?M(A83bf:fIeOP1/C46ADe30fR>Q82J_4[I.95MUU4OFRJ)]cCK->
)gPGce6+TG2?.$
`endprotected


`protected
fSJUEFMS^RZ_T9dSF-9\Q12U\;Wg_[RV_]JP/;=)TNcG/fDLA)5H))85V(;F4\DP
A(bcG+fY>1VT;N^,?B]QQ@2U2$
`endprotected


`endif // GUARD_SVT_AHB_DECODER_UVM_SV





