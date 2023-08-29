
`ifndef GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_apb_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed slave configuration if provided on the constructor */
  svt_apb_slave_configuration slave_cfg;

  /** Strongly typed master configuration if provided on the constructor */
  svt_apb_system_configuration master_cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_address_mapper class.
   *
   * @param size Size of the address range (must be set to the size of the address
   *   space for this component)
   *
   * @param cfg Configuration object associated with the component for this mapper.
   * 
   * @param log||reporter Used to report messages.
   *
   * @param name Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(size_t size, svt_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided APB configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_apb_addr(svt_mem_addr_t src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided APB configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_apb_addr(svt_mem_addr_t src_addr, int modes = 0);

endclass
/** @endcond */

`protected
0]=XcHb(4J2befQdU9AX_b9T93UTM77@T957PTBRQZH?@9HSRVRa+)<BX7M[PgF,
0(9aXFLN/+K.[_-,:B8X?c5:6?+NPX>1(>0JEYA/9C3(/5cd)-8?IgQg4(5ZV9CB
>gUK;#2R=@+1PT/\:/WB-85_Ze&f1dTPBB?M#I;LQ83&<?g>0EU9cdX)Kg\cC11V
1A=CIRbQL_&;7V3(?ge/eS[>f0gNLT_]IMY30;,:A0b75L&+4Q]CNQK>7\#J[b3b
H5D&&4c:9?3P1:aW@;:Bb7bQOVYT4?6+D/\QbWb.JZXN9_DR2N8:CR,eM9a;Gf/H
c[)Y)X(S_:?I5YNV49ZdG=-4_)4HV&&_Z-+RcDE#)6\\SN1Ue_6Ad;R)cg>_d.-(
PXV[02RX;N\S(4b=fS=-acW4RJ[9a(\Q]NZ-[aE[:0Y+D3EUQ2P;1GQ3:[KRW:<S
fOO.ZJ.V=]HF-LJH_bU.)_I+Y.]g,02KJe22_>I4P05dHG3/VM>.:FO(a>WYTNaY
ZE4#gH7#)O1U)2WNEHZ:Fe,fY&WcS:E9:IJ(f78,IO5(cCL/2=0g9+<9K:.:c]II
=GJ=0bd2TA/7,PAaVPO)T403U@PEdbf:R6GXdD>&;:8:5JR_S#b9<LBf,:_>d5_X
^5LK&>A-@X<:cQ4b/B/7<6S9[O3VR60I41U5Y+aGE;Jf18S-;f0DB1H;<bZ9@87M
7,&@#LgJ+GTAOgMU:CT;L>O<B5Bf6K-_ELHdMB,_>U)[-3EZO9H^b38//-NGGOR[
MYS/DV4T#OeC:2B:#bSc^VF;6a-.E\.EeID-1_;(Ae#aLW4AYJ5;Vg9MI2\=Td7Y
+,9cPaI6KR_F(56Hf>KT:Y[KU[)N0-C8:3_,H\V;_\]X_G?6B)4ZSb]G]?\SULa)
_eZ&PAgR1Je/>cETTUJTab91\>14:M3HLTV[N;NO;?F1a68/D[Ig]B,[gE=]a\(T
a0;#S1I\J7-O2b(SEC-A6<@)YM)4gcXU@K[_Z,;,C&VD]Z(;fcRI+=7a<JN/ZJ(M
\Nb)MC^J0^./_&?Q_e/].H#Z40)3Z8Ig#7D)C?2B,ZNL]b<H3f@&=1>WcP7,b2)F
?+OYJ&)&)bg)2A-PB6[\Na#Z6$
`endprotected


//vcs_vip_protect
`protected
&a:eA-9gcR53;e]M4NNS8]N08\gEBM:XOgJ<YYIZ=]0N+=>Uc[7D6(67g;[\^eQA
=2W1R?d#6KD+W\IURRc\b.&FKc2^)I[eGKU#GLPQ<#UM)6a+_dFKWZ/cKJV&?MH=
cE4TZ^0OW0HBD[2gLfe:49R)LdU^MJcMJM4:C,CYgIDEg@;?fMV7B9W>bU69=#45
:W@/8e93OJUY?9f6c.XGQe-Ua^^LJKC,-]+N[Hg(KZHLNTJ@c(>[.DLdggX1/\@b
#(F,W/R6bfgM9:A:RSPR3\C)MSLQ69QB.IK?cd[??g:U_UfYg_cRSaCGAJee_=V+
-8_.,JX)_)dG)&YcI#=^_<M03J6Q)+MCQ<cAC566#Y1N),[d(.Pb_F&T7HgAT^A&
5LA)JN<N(b-f7/.e@H^ZL->BGC0TVAZY5H&N?aVMNfH_T([R3^F3X?0QJ?aKS>JK
aGNBa6=43VdW#>#(,RD@J@F5PZ;&9Y;+=^J]YEE-[]CB@V5b2?Z]IGKPN:,_3XZI
9_)37/UK-#a&6+_J3a)YTD<],F>A7.B:#PaJ7Z(UdFP4(G^.-.6U-cFb0G9;OdZG
+G2N/XYBB[[25JI8_WL:4SLX\4GB\eC/YbbWKQa<4N[[;^\VFV20#[a]g7-8Fg<>
2/8NfSeAIBSEQbbLU_C\FT2=1310eEX(D)H30Q50:F[);9(^Z2DH]g3T+3U7aM@3
\dFXA?S^7FE>:I#=DSIJ>ODN&Y&>dZ@AWd5aK1L]+d;;;0P329&FS5BMcH27S79Q
D[e-?]J()]1^,WZ2O-J/dcG)0^.2.PbM-]3[7e#Gg097G&([7-EdBAYD>.edW]3-
;=S)R^\GaKMJCX&9DAaYFON@2/:[RbV4WeCO^a_]18Y]aRTHZ]H\#LEHc\ZN#LX_
IGYJ)L/5R;7:.Wf&_C;V#66C&[YQL3T)MB(R_^WA00\&[)E&]FK/9,/G:E[EZc_4
QMJOF2fXLFY?+?C4-)&(-R+f^I;1[D_^F2F.J/JC2@AX>8,-1U3ZL0bO9]YTF@MK
S62CZEQ3A=f^T2K5PYD2T5dMd#?:O=WPELU1\WYH^_(9?SEc/6f-KMSCYF<2(11=
+;ZH@?,4:;bUIGV3=d/KSV\>Q-,FaN&<A41Ub?7#LbX8/RJMHfeQWgYdO_7W(-JE
1;e?Pg=FKZ7I7PMg):194VgRa(]JGXbb5KU_aER_(O59(JN6V4Hfb/>fVIA((&(\
)cK]Rc\C/NBT8:=S<+VNbNL3eQVDaT3PJdU7M4Q1#E:/Q,&^0R)38@UV:Df])/f;
3,K6-W/Nb0I]/PI?Q]RO#55_>#GfR&##C7Hb8Yc[_fIJHXEa2Q;g;cPWXUe#&S/\
)&eQd?V2R/?1&OP^GIW20fW0TW)J.W,8BW7]>G<DGZc=\1\QGgT+-\(QcHbL&CYQ
X##b4W)G0&CLeU91E(=a(B[0A,I<;[40\C]X2M2O30]S4JY+X/aP-O,Zab(aS,/O
<aQ5EMUc#[#[bJM.[N<=WP)R^//DN#(EU1F.^_);-H2KBC-?/D/TT\ad&TP)(>D3
YfQ=-aG<[8PF@gC.+.S0a&Fg2aJJ\5VJb7>F^LO\IOW,ACadT,D.382<R:d#L^2+
+EPB8CA.T)Q&G24^&U@V_V-PR3,@Q_52:ggPA//,BYT7MUb68).79>^EI1<,PBG^
K-E+@4?#/R89ZA6_)K3T/@GR#LXcPE+AcRH<O&1X<^3K#\Z\(>2UW4WM414N0Gf3
0]((Wde+VP&<9TT+6JHGC=f]304GI6#L?87.0AFS)XJZYA^#]Rbc-?cg-&F2<D^;
GK8.\Z@0+bec=d,A@ISc)NTE;Y9J43,KWbCJP:,?]>/e04_>A6\)N#V/9?-(G+J\
J#8F8YN;PBB2.KU+38EXQ>.&KM7-ZE8KKTUT4FRW]A\^P;g7\=<L@0D_()>=]>I@
;A.DOX(&)U02-Zgb>R7PLK,K+-J5g(f9?W>=/_N_P:YCJ[X<9g,K58CXWIFJV>CU
C4>90g[L7Z7[T.BGdUWWAW\=R\MH2VFXB2PBX_bSf,:2X.0.NO,1#QPL^B=V[04U
/K>\-eBcYIB_Z\.[H1M>cJAWCX9dPCG1?FIUAP56PI#,bCc(_>a-/d6(KW+eN1E-
EJ[6a/(Cd(>#94^AJ=-\:/]eT[[UMb[NC:MCWef8dQ::b]@<JTKFMeK5OW7^8JS&
]S0;dJGDZ9+g;](=?8fbH1X1]@B#PMIE=50??==PO<^O3(CL&UADT++K)KE8(K@-
2A4dTC+0ILO^/?Q7PWE(JCT8WWFA.5W)GdC.E(?abJ.6_W21D^9A8b4^PH)+:bXE
HdHBL#95f5-P:)&&8d#K=<M0(LCQb1IOY0KJ+\?dMg73g6b\eA_&A7e<d@b-6;,F
#8WX)-N^D\7?[cCSUXDDFH\dUX9^2(?6CNf[Y<:C]fga^6Y_L19BNO>&(C21Wg?[
)Q?=R3^4?M\HBZ<_HAdEJ<b(-2MLF1H99AHHJ#2HFU--MVQ<>FIU>A2fW(VO?>?e
Y5NPfYT8:FHB#=cMKFbI]W.5RS:SAVeKb[28Q?OB\X@6=CDLcG.-I[fU3SDDWFO[
5gdANRKZ=+QO+^:1Y48DDa8+d0CK:W929U+W.N)/RP08ABM=#NM2+T8dUBf;(Q;N
4P(3@@RA,9dVbaK]63N/]H++\Zc6cA)d@Z6IT9MX2OIa5a+eEJb:Q.Y&e;&U=B3;
_G,0FPYV1Qg/He?0&@]egeNL6BWXMBM=N)#\?JSS,IHO0UERR]H@GE_E+(a@7OW:
P3=T]Q(3D<)L@<?=+(eBXO1D55-0^[6VY\?GgQ@1N?K=4^=R.,V@GQ3915[UA8F+
6O-D\T@[=fC[a.gW4aZ>0Id#CPHR:L_bA7K/aaM.g.YF-])0Q\E^5X-K=G?Ea.EQ
#-)a)]\-HA=Pb>MH^-]<+?##)<#>MADL<X.?^D&_(6-^UMB_G;_[^PfO77(C]8U:
4aT2+)0YMVHX==XNQLY69cb^[GP],E\WfR0B8S5\1Q^H_A8Q,_>P.-U36XD#[ZMJ
+La<8+c235,(2L]+JL3Q>c_F2Qd(]AaZFFZ+(Tb=-2&()#9[G#VHNGT&L0X<U13L
#^U0A8MEXYdD\00EJJE(&H=P4(+@,,1;?.,4)[[MM[XaLPY3UVYOe@S\G[\Y)2)6
CdfU#.9f+NWUZ8XC_PWdX7+(]-=:[-&R..NR[7c=2Ld;#JK)O.IX9JX9c6#JP#V2
--V-\Y+cIT@F,GVAKAEScBgX30gMR/C(VJHNQ#<?^Yb]0;aeF)W4a2RH:a&T=(e,
_4(gHBKSQ4<F)$
`endprotected


`endif // GUARD_SVT_APB_MEM_ADDRESS_MAPPER_SV
