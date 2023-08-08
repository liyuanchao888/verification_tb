
`ifndef GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_amba_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_amba_mem_system_backdoor)
  `svt_data_member_end(svt_amba_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

endclass: svt_amba_mem_system_backdoor
/** @endcond */

`protected
X+e^-eg-gNT7S<JH#F:;B(_cD+cHSaGG(ffX#ZaCKRW1C7[;C=Id/)@PcL^b\_^Y
U.,&)g_AfQKe/,2L/;2KEEKZ#8d&O,OTdU7R@.O,QP#]NdaeJKZc^-\OZ#g_f?2F
\YJ&)K1/M&Y1W5=]F=SZ]YW_S25T#9L6K5g64A+OPOg0Pec6A()NO],0<)[QU6[&
B-(IIbDS71N;VD.9VIaW[KbHSC_J#?UM]f,##>I6fLFAVL2Q[S5:,+A8#SBa;9K(
D60([[HXKG-_XMVO):5@W_C:1T7Y];UKL:O47JWe.YLQcA_6:8NG7=_M;NaGZe2T
8Kf^G4MYa=cC5QC1-1/BJ.>H))JIPf8NJ#F<B5A.H3-528E@JYLCU=17++,1]3FL
]A78&e4Ia.K&_RGW;TH32]J&J9X]@LeP<5f+FDF8e1?29.30H^A0e)MEOD(S1_C4
;/I6\c?@CK0DCbVZ96]b0Q:PI;TBa)SD?c=/K]D1Q=La_IO26&E;JY9cc/[cZ47e
VD--LPfD@M+-;>bU<.@&U(bNg(I>SG03RCQRZ,,EPZXXCN)cW1+)B_1>\EVN#>(>
-CZI93LF#KMcV1?FF:5D1,fN&a0@dSG56GOOP&/F4Y-JGO@+JTFK(5.JBX\DDB2Y
g^BY6YaSd-ED-d.&/Z4PG[9cN.OA@:e:62SDC)\;^1PRE9R&YBSgWMCS04Z9ZK1C
(IcS6DT9];N-EI&L+<JSg)J&5F@7=5&OZC=3?8e6MbMVM>600X.-_E&deW2,;C,A
\K:QV6+VCd8#b:#+S4EUFE_28BK/Za.-e-?17Z6TW3.(;Ica<@4/9Y.NPWX5S/OR
A^73INEC(#LPZb<)dH<[^T1UOH-cbYOU]F66R84dW&UWM)&@[&^I1AG6(L2\N[Y/
U6>BH@.Q0FYP,$
`endprotected


//------------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
PA\cPMO^dKP1aIH)Fc2bAJP6VaD:ggHQ\O-H8Id=J9a:e)9H)6)A6(92]94<13Vc
eaE^3#2;)cWTGV/Nc/gYAf+cA:YZ@+YUG7+-,Fg8-eRV>2;)K)K_Y:E8EYU?4BC)
4C36<(A6_.1U3TDG^UaD=IgZg3g/g+[TZP)XL3:XI99Ye53NY&/^,H3UVNCbX2@e
TbH2G5=6R49:#S:CU=C6W^MMKCVOYb7>3JE@?6Z;#:TB?94SM3LJEG89+LO7P?:^
77LAB\T739//TSbUAb_T,5M)+A66ZXH@1UHb_Q]MVV5cF6feB=MP5:A4VI<?1V9+
>KUb[[.O+=[&CS2^VU@F0DbP?/8L7OMBVKQfEG+9agL[(GP[=g8QGSSJ^,[-VEc[
6^fLFf&SZP=KGO^AB[X<X2?.L3WYaA)-E@OIg#BLdD+QFZe7ESbLECN-Y.A9HaBA
/WH#W8GX7OCZbYc;A/;PK8\H1(1?f44(gc^^RJI9_?GIR.P3g79U>g9VL,,.cZef
G_;J;+5<Y69<886U\0D2ZZE>d/Q&fSfD.WIeYQ6FC@^.fAS&0H;aVYP4Uf>)Y@+g
TK^0DPO6FXVDY+e&Q#7>M8K89^5F8J(MJ4)W+e,<N=^=]]OKaZ(/(UUFS4Yf(\7a
^XJK9RXWeY6Q3bHMJeO0HfL)=e]^5@]fFcQTUIb:dFg\]=#=gTPC<(P0)SbM.1-?
Q:V4ZWL(]VZ<-2b+C2P&&#67-Ad6H@SG7::AVZVcP&[@LQE(JF_T760_Z.eND2Wb
FB[N3R@GEBTaU4#U((gI1-820BN7[VL.IRFJ#&BI-J@bZX]:P/NOV?A],YV)AI,1
GM0Ka6OL,\BN?fF:b1B=34eX]Q&1f5Gg:L<\8a2gd5FbPY?bQc-VgfHXBS+:@fP1
]_K&1_->]P2/@U&/DK4,;>e0;]2AU,Z-M[T@0,&^cRSQSXcU]>L4E-2OUDV1SQM#
P;R]X.LA^dAHAEN.A]_2IFf(WCQ=N=fg;^9#/R[QA:9cW]AT@g;T9VZa</&1QfQ[
ZUXR0-I22Pa#.UML43f4fQNfM>A++a7[^cKY[:STPD/EbS]--/>^F+()19-1\)#;
OV\ZHc)J7Z+7NU9+4SU0V4aJT8SaA;^;4K8FCQY=4[0.B(HC)AeYL5^ZRGZS&L=D
d:S=^P6-_U)M?a\W<Re(CPI^L=;fRbcXcR+R(-QK,g92UI=M]D,I&:I]X:N(AU0S
=8:+UQ18(&EN#8.J,-24ZbeV>25BgGc)c9Zgd4NbUD]0=VPDCf0()FZS/M>)JAZZ
I..H0]-6RC--VHU.(^W<ba@5>-8K<_@BXS4]fB+D<Ue2TIU0cF/GXbgW<A&fXb56
<4>fJ?0c)>F1IXbN[Q,+I6d1+XEU1<)W2+1FB\&@>/A)AfLbf/<A[M?;(D^bXD;Q
NY+LBHFJQ8e.S3OeZ@gK\_?B>4FYJ)YWB\C[T)c+-P,4@1LG58-1/c8O8ScMJA4S
6+H_,^7Cb)C4?G7G/_E>dD_BbTC>9@G;a0X=Q7PHb=1\&6OBDP9DP28F\f#(QU>(
63A)9e4]]8NVdV(_@B6A&6b?]2M&RPVTBZ<:(VG7TX@LDDM\3.;[7:=,0\T3cab8
>\=?R?OANb9Ra7DDRWBD<f5[BA<gBg;-;6U7(cRc&B,DY;QS8X_IO=a]&cgH_EU(
7YTYX&&L-=\P;<^I+E:7(CKfdVI>KBW+ZMXEe?KM&N?-4\H2(-JE475[,IK?4K.?
KX<55BBDU?65#dH<g:RRI\HXaF.6=6#8Bc0T.f9bb::\P:cFW8.08F8C(MQVW72+
8CO=ZJBeWC8D9Y3F_&4GbF2:6L#dQ)=N9F)V:=Z;g4/CPM?8#.fZ(GEO#2953DNb
O-W9K@aY7FN8YS1F4OA;F:9E(A@:a/MS/>A3G[BE#7OC=EM?ZLdIZB8XE=_?[UHV
E\^)g0Tf<,>Ff_N7F)QHeV<c[KFIS4b[6:-/?#NdO#MPd.CfTPSM,\ObNO?.9YMT
7X,Pc+:IR,[8B.)f>XIK<e/06A=DVGC+.XVa65<dJBRAB8FJdP3Y;W.<8;a4E:90
H9c=J/P_IG4A)bGB6L5]QW/KH7_;P/EaWS:<]_@MJ-RF>2MX5G+1K.7E0W.^.O8D
_JCHGFVHKB/C2AR;RG<DaRJQZ#=bPLV6QR_P;ILPACCd:;.3QBU[EQ2_O1=QHdZf
XCYPMO3c4Z[SFEbIb/bOU0[@6EU@#[YUBE5L>96\E\53>U-K=CR.0[0N#UNJX+-S
=fPH_dO/f#;bCZI4LK#HJf&EMM7H]N9(Ca73d35b2#H.22Ef\FN8cJ8JPRXL:.KL
,5C.J+RF<[8#(WbKZ]/:J,28?(+^R@FVb,#MN2:]A.#>,+E)32?DA#=_GT:1KH?R
4I,=FC(gGCEB]-]d&Q1Hf[2-#g<50dD=4d33HTbg6BF=@RDM06Rcd=IXP)S\5bOT
0\U)B0G)>DBJ7>;O#,1U\J\JKHfSN:0?B&fLT:FbZ[[3=#OPBKG&&GN,RQ^cD\T4
R-E;/aUBU(Rgg?6X6UV5UN0bM4W[fKNL8IK(Y_=GHKG@+?O,KHK[4G4LP3Z_Z);/
OLb4OZfT8b-+4-@B=^?=N8H8Q+Yc]>;<]K>X&=dYEL,,:OS+T7B@K@#+a&KW</8d
&R9I58,STL7S&eJJK9NO_)6II6ed\ESVHD#a[fW\0cG1.E&8+T9)>,-EAQ=&JUXH
>YN1Vd#(b.+g.<80P;AbRgKJW&^@FRWK_6<H(TC[,\M6ae5]L+;VUTaZC/c,^95g
Z/KQ?gNE61#VE,LT2H3/_Ua.38HR1MFgN[<)8_R4ZS#a]eLA?gCJ7#IOb\R.9db?
-H@XH&+\:?,/1[/WDH/TJ4&9ggL;YVHQC=F?3L0SIWUX]@SgddUF[d6g?3QJb4M4
_MQ)Z<Z3#bFF-TS]CCH3f?,_YMMN<P.8QVWZ<Y0\Y(D&;^HR<V03dAC,TV;@fe_5
#_RTB8-N4Gb(U+H,]E,g)ec,WUKW[EWSKdeeQS;(W(Uf0=1>[7+A,[DYU^J+S4C3
9g\=5N?[M5#5bZ:5GU_OZW-XVM@X)F32_JfHE6)AOL,(8Y_V?FEUJ7GV9<Q&<TI;
S3:&4@14LMT_1A3C\WE:UYF)d]#Z=G:L7@BAUN8aE5O0@#+JASBFIB3-52R250)A
M2KQU-TDPWfC+8]M9^<Mg;D+#=^Y^)AX=[bQ_1[:[7H&gSA3TG0IIX:L/KTg\gDI
84^N[XUZ,DWDBCeMXO+I(B2b#ed.J67M-<DfCWX>L6R50;HFGGBZF4U9JX<O9HL:
^,66/@2LUS9-]d7PMd&b9/HNM=(37D.NFS[bM_:dbS/U\&^^QGE;(T0@8->+<Oe1
)g:f\V6F3;V>FW4=617NPaC,60MQ7(CM&/[>c<O(A^IRIXO8;VCK[2L5e2Tb3ZdW
DBG9,I>KXC1:FHe)TW^OW/E7(_R[fDLf@X5P;]=>O;DQ[;gP&[>5T\FS&ND4LXC)
0M]#aAeT-+cg,J_\GHU;OgYf4eL-#:[ZHIM[7>7WIc,G.ZVZDBHB/BbEbTD&KdCE
+K^7]6P8[:EE,b&7J0S_S1AdGOQbQKD2.XRYTQVO(c,gL&ccf=4DJG5-V9MP;GgR
51CL&(B5D]JeGA-)R<D4^;Q5/eILY_^e/G?8E^X:O<b&>.YaQ?B\#35Z?77,:R^S
,4B_7?WdAeO_LTW+N\E()2I[8#4dHXeE,9BB.Z]D.5&f-8MdRIde4#2==W-<DNI-
PP4(+f)HLF-/\-g,YYI\E_TPWa<M]9PYW:49cDJ1,gX6d9_B(E-JQMFEB+VO=,#,
#N]SZ2gDUV3KD]E?VJYTWTDG?f;-BUY(-GM]X>0:FffEc?RNW+=U?<?]IZfMcg:I
I-U,HSf_:Z3HB+.A=TM=a&C[,WdTR6S]G<^&^3ZH+3ZK4O.K?NSR(+)fe0)B[E[6
:SAd+];fWO_EcM0V)XO34N:;XeHQ#6-#A=gW(\:^S4J<&_27YPVG9b<D?<Mb2[VQ
17>3#ADZPH121A/N](bF&)?J)ecF;=FT09)L:E#T@;36/-5TfdMX0<8fP1cC15/]
D:^C)Ob@Z(V=Ce&43)WB,2G?\fCgU7aGE3@_e/VVaT8WTaRe3.A5(1_B\K>Rc=V?
=cF>Z]L>#gIA@RPQKK2bI^0cE^<eV3WcX+8>7VGIJ>798bCUMU0BL5FJ5d8e8/V3
-AD9E]ED#S)T^]?C_)>A:LZ6BV)K8A@#+9;OgEM]U])0aW1T?<B]c&V\ROEcFS-f
R(9&L?)\b89++UF,gY#XA_WM=9dCO7@^&A1M=d:5TAC55dBMg6GIH3ES?FbFV/Je
eH6<UeIB8RS<cRWWPa>-WDH3#Jdg.=c1gA#R7]E>3_@d_36-aLQc)&?\@R1CZR[@
_B83;N-CF<P&f/=^3=a2&?(1c,PCRSQd>gT4BAWgW9?#N&=H)E]5-=USUL\d\Dc>
2QOYC;8=56OdU=R[R0c=@aC2U#^98(6F,Fa1]_+9b2L2R=,ITO#/3bEH0QE>g1;?
c@FOZ[(?.,:)e4g#+=GA#6]-bfdc=G8^E?ZTa:G68XEK9=5/.e_=)VE>.Y_gaFa2
&EbVg-9W#EeK;7_J<SOF)?e(d-^Fg,1-43]1I-LFC4fJACLPZ6B/YJ:fARfgZU[D
&4_VB^5@-;HDM1?10[>T,+B52V#,Eg6/RXZ@L)NA[?3S9f7B6Zef94KOa+4VgKVA
<TS_H;?LDc(GVdO_-C55(#]5=IJK?dQV6/QeGVJ+2AIL&E6ZI@6<YY/=8,R@>=f(
@=P63\9-f8?MCZTP4-2@LZFML0d]DgM)b]3G0_-,e)8Y.FJE85ee^YVYMQ<G0XCM
_9O=E:C]c]I]56a]ffJ(G[36Wc(Q:@3NE[@PV0:E)c;Z.8g@VJ?:L.-\7;8I=TCY
;1S(?X=SM=P9OO<]Y+JRVcEDS(c83aN4DW[dLc3V<^B),f#L59VG2GVB2(dTE>f;
_A&@W73//WHXVKfD::67<09_17>K144ePW1K_=1U,#WcGR,cHY+c@_;Z_IF8I2/8
-L:AWQT6A7@e,4J63dR?,98MZR;&PZG>cP.;HHJ[63:_Z&]L<.\C_F^@TDJ-T(B<
X[cTM1G3/R];9<Td(agAda;&<BdP:K1d>J\T^VWZ82\_BQf62XMB]\;&Bg/9FB<S
HU5H=)YU[_d[Vc8M_d_H?1A5A+ZRfP:_[HH-MS=]D/D2SQ@#D]\0UO@=]1[dB8L=
0Aa1CVMf[?7B:GX(A=_ZPAL^?S9=#51XK52@6fe)TUgJ)Z4-AY.Z58Sf]=_d[OZG
6LG9A1)R)9-#c6Y5Z>O&Y6N4<OZQeGN/PL^<0)&bgXbF)W<Y@7f=)S^X\<FT?A&R
YRGfTFYJIRe3B#OCN[W;[6DW<&O<:K=)&=[=0UN@R-.NE_DMCR2W7SI)T_;I>]c#
=@N:^YCW9PB1^T_59/A_2D87AUf/N.a;IL_+d0Z5?+;f)Fa7H6I,04OQ:dg)ZW^#
cGD._NR02gIZ@R2^P#2Tadc7fB_aX@]CI9[)DJJ0G>DM6Q(cOM,Fe0Z[-DgD__b3
e+[I@V=BMOQ1ScK^&UOC4ge0\[@,GURE-70H/RSaPP/+e/Vd+C^B&+6G>+e@.71X
>,dfe,+.M?P&?/eSEJL1cfJ7bf=)M].bSU2S9gAY9Z]CA&RQ_6M&;90^B+YLYI?/
YG^:eGe55UfDMX3ALWH8^+:?L2C0[c9K](bdESBV,.IO[P12CDf+T.X+95eGe&,R
7>P_4#GMdD0TZe6P&H&S6b4D;FO)Q4S9)GZ6CW@f2g]ZH?])9:Ga)ae?d=7aM5UC
@4,C14:<Y-d[(@L8-O.>G:Ec[Y:.?)D]JC&;IE5[Q)dY[E>2bVP_AW=b@ESPR@7B
-]_0d)N<)<V90]-9QZ0aWMFfDT<6g3dT\(+.=/FdE-HK-7[YR@2K2UfW6,g6X25/
9VUY\LPHS;1d>V<]DJLPL3VLI=:=X=M=&7+/<<e8XaE07WFZM)aSA0NT?XY6>3^;
0NBX#56^M-aF7U:#,@8QOWOfV)f)?;80A+/0ZI1D[/4,g#C\;H+=7ZUTTcWfCg6<
8C(2[7ZI^7PTWeTcTIFHaJ@W,FdQ^0D=D.0:Ad9I<G)M>@E/P[]5^CE_::.9E&()
W25A;GC?+@Hcb^WM,Rb,N^WcQa\40_?))&/UW-=H-T[XWL[-]M<[[W3H9FG6edD\
A7_Vb3,R2?U[;:aRC0>RH+aH]I\^d6c=R>Q&1@YK2;=:-.FXRI(I8Q[L,G[WC?5X
BN6=M]?(>0Zd:Xc5EL87(>JV9GbB4RH0,SC96@cPBTIGg6LW?b8W20(9B&2@_:He
/,fX+W=#@,9G=a4T)>W>e#NW7R@3-bb:edE7:F,8:4=V_PaHaW;:?T6X<J[QNPg[
.?gF8P1b#T==[4QFQdQR7TL443Kg;EaN-,IgR>PFWJ->cH#\V:cS@PFR#3[98L#5
+JYR.OGKD8,-d2FK68#JVI0EVO:T33SU#A(IKEfV,7_c)_O52gP&Q+gAe^>50ESZ
->3\W=#[W+39NdA(6K3<.f8)NM>1Q\)?OGBLW-eX=47ZE]-af:@^C@@13C-&V_F]
^0(LIf;\ILbdAUP;M[YB?0TJaML\_DV>14EUL\Yg:#=+.M6bDOZPY@\C,eTC](bT
HS4N8K4^9[2JBH:)PO;[2LE1>,<(>.\,d<T(@B=W\NZT:RNEM4XG7_5?]7OReQBX
>WM-;NNRRYQZQW9/0M9>A^SP7S<DY96Ug5HHE/=QPIa632MF4H>AY80Q@XKbN0Qf
b0+:_O4+2#CLQ-OSN.(+T6eR=BP0c76K\-;2aU6<:Q#-R^b+K&g\[g6GA&?.DN(e
#2)M+5eZH,3C28OZUEdZPWe?ba+OJ1G_MS]-79@),+a5]d+M++AcWPe\.(1JXMQQ
D56@TU\?d_fc1f&TG/VX58&fLB>80-cC<A[;a#a0a@)AIK7KHfPPeS49C9@<<Q&+
-NDFWC<0T/CS7=I2K&9JP6];PHS\]7N;ZGbZL^\2XJ+M[J_BV8/2Wb>@UTS8=8Ub
N,>Z:gD6/M>fYPZ3f6F[TBAP1@+fRedIPAA2M6>/^f57FO[R+;]7?5)[)e7Ue=_Q
DdO_22N)RZWN?4=DfBCP5J;(DF0X+]&(ZOQ,SWR2JgYT;d[\&MZ-#G\6TF7Me4P)
,:HAW??c:&7=\Hc,^S11(_[bd\c(F9QK2_P4.cNLPGQ8:UaT\b#>4dUN&NY2/e<2
Q1]0faNcfU414M6f:P3>:)X:^LXK5Ka#5KGRE?DQd:\Zf9OZ[fYV+QMID<LH;>@[
7.fTbgHB1?Z8gE(#ff5SIH;H/-Q@9Q;gNaCVFADG-0OAU=[c46E3dU_M-VbSJ78N
MKg[-F^:G-R@HdYPd#Z;OdP;ZO,A^07]&)#+A>K92<X)8&E[RKA03d?2:H9\K-@I
3KK@-GN5A7Mc>VJ?0cW>_YMJUJ61c?fZ=^.5f[Z<EM&TH/&V_3(bI9TYZE5RJ]P>
E7,R&XR;8#:JdB=LA]9@^0QYf@-YMc<8d?cSV25d/0YZ.,,f;18X+0c9(.dM9XR@
0\#DVNMD>@-[PASC&P5Ldc<0]]=/6JJ/Q+XH=5<NdTPVK-H@SHU\7^=J)6.QH4L&
0,GRLT^K8YGU(aMI9A6g?dc\Ea<IN2c#0QHeE2:G\QEKQ#1>CfbdN7+&;&BGcYHI
,[M=0RGF]6g_VRT2BKBMSY8_?,=8+XS@CL.<Ea4=^gG]9V/E0PIAPgU--;cLTfR=
9[RG<N.4?Xd<T7KU0>-UVS8eLFLg5cb>UA0-.5eBR=6C<L#]8ReG]S1;>?cI#[#K
GbO=\X4dP[Z,c5@8WLSX6f?TEWW[E4#]A2P(e^9[<57XdcYA-9RSaTKJU8[G[3XE
R^_>_+@?L-;OIOYg@HE_g.3Bb_7E=G#HC4e-L04]Sg4_#TeE@JL^EeW::W&UQ(Jc
=9]=U_8\WL1;Jd1&5F0FAabd&_<MXU([&O5+1_=eRGAN@@]+5R4G;.?J]G,,eLWW
cFUb.fGWUQ:@[-dP8;a_H1,1=Oa],])d6<DYU7]a:B:228DP5(GPH:&@]VfQSM@>
F2(WUX2G/@6]cWM_2#A[O@d>U55=;67[MdX;CE3#U=+9[&>Y&539U;NMGO8^O)fg
GbG2;P/]/1aW^_(M6?f[8eI#F)EDCSU2VQ&43T.=HC9;E[&Y?_Z<09>X(63>+>/7
?ca(G>,g6e&N8:^U/=<FOGIT4L.b^7BZ+bfX5B@)=:IFBTK1+\X61Yc.bFD9+&+\
+gF35E<@.WI>@MMI?Y5I[[;dge-UgVc^7FRVGPV<B&HCe-<:]f:K1;,Gd:78;122
M:VPa3H<D,,^0(RC8=]4C,K3(#0[\-PB]3B:#:3D@?71_EJ46R3[f6T:W>D+(YJF
cC6MKJf-D,&]H#@[;BaSE99LKd67RZV<K47Oe6XW0@]f):9Db0E<HFCL@a?4\H]H
L\\J;U=?:@8&\d5_U#LLJZdWFH1d_W1FF]CQQ\+YHJ<Z-#G5,=,-F+<Y78;;\6Ng
Q_+UfUZ@dUK?QP<[5CC3&9<-=(e;./?AJ?1^,eO,(>Ia[9)EJXU5eJ^SEScJWL\C
H2P5CRKaG:_-KOT?VPZNIT.eTVP05;S__;FR8D0N5T0\6]LSW539N8HbV05(F2KY
gJQ\?T3&b+fL2#:HED4K(S+;/1YT=LXB<D0M5+G=6b0QQ2-f_E9B471JX55C>&3F
>OSI>\)(#_X1^[F-[.YSF-f9CfZ24.GRNa3PP6<gFeLJXQW5M>LZ0NeL+]A:da83
^XQaK(9M9L[ZWBX1-:MCMI1PPRMcdO&_^&BC,B9-Qa]D4?8)=\1DDB>&84a=E\da
P/(M+\CeRO\gQY&/(3ERb@MdD#U)8\L2<aG\D8BegH7]+e4M-NJG\#;,;S&BI,LZ
]&_>L0X,WK?aadX5R#I[<;RCM5dS3+GBegdS;T)F6V^HD:d-(>HRKWY.5UGf=5Pd
=1\6b+X[P:Y,(S.a)gTDLQ9:H?[Sdd)\c4FJ5:b]\]aPDVVPYD;\Jg7J,.EHSA\U
.-Ub>a\C^be[LA]7I\P1Tb-DG15bN_c-MZ-D8dXJGNVN\#_aP:L;2(920^Kc(0D]
(7=83KPVg_9acH/Ld_HLAU^HV_VUNf7@PfC/?SNBOe9&D9PF)\>R<+5d&.DX(SP.
?4IG\gZ3(CRZC6CAVfa)1gJdG)G52Rf&89>-QbAS^K^-U+W&2,TW0(DE3XKH\UIL
KbGSDW6e[9Nb\/VI_?.c3@@+=:2W<Te&8VHKfWQ_T5f)=)Afd.\@0]DEJ$
`endprotected


`endif // GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
