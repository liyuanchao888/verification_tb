
`ifndef GUARD_SVT_AHB_DECODER_UVM_SV
`define GUARD_SVT_AHB_DECODER_UVM_SV

`protected
7/fcM9CLJ^UU0,7:T10OSDObU=D2G50&?YNJU:g11^[Zb3c:6A1#6)^S5Ff\B-CB
6\a1248@F?RU0$
`endprotected


// =============================================================================
/** This class implements an AHB DECODER component. */
class svt_ahb_decoder extends svt_component;

`protected
LA)Q-Za98&?LTSfLc[[#@1M]8.-O8K9EH6VDV)Y^SCB8J&O9X/,@+)R2)=Ff66NK
R&dLf\bL01KL-$
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
EO8VR]ECIF\LQGF>Z<b,,a2b(B@bAN1L0XF)3USOf84,RCQ2#gC/-)^E\O2>CT+F
(WRSO(<)Ed;L.$
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
gd4RZ&Kgb[5E_&F00QV\0dL/gE9EMDK<>#2EJ6]HGUU9/HNeG,[=+)d4]/Lb:cHE
M?_X#JaLV0.E/$
`endprotected
  

/** @endcond */

endclass

`protected
W\\H>f]+LBDCY8F88X3R/TUI=P7DD?6?SJ>b0D8B/a;B4DFLHZFK/)[DEJJNS46;
M-4DcT&Ygdd?YYY2Q5T2g/3A7-VJ\3&)-E6NV?9_OKKUXf[T>Z8[dI+19O3JYA#8
I]^HIH>7U61?a,IP2WMb1GcR04BV5]TYAf6<>]40Q8[Lc.F>I1JGZ4GeM]2K7I54
?7)Z859a?S36+YTX#2HITZM7\&X+WNJYC+M@C[J0:SW9N\\U_ORc7_#@A)-/VJ>B
9KGKUG=c04>BO,Tg^G>S@I[@(#9HXJ\((5V82M16N@G9B$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
Ue2);=dD8>Z.Z@3>\Y+PN/S@V]Kcf\]V^9@8.#KFN20P4FQOba[&/(5@P^fD>E-.
/5cNAWc;,B1fH21]VGGPcTfc.f1FXZ+dVE&W.&,A/@7(OHcVC:#L7T9)-N:1O,+A
#N_8;?Sc?)?)Lg.-WX=aUVS935OPOBIJICcSF]7I/K.@Lf8f-AdV)QDA5GMSTK?M
ZRfD[+,\F,5T#7<NVNc0TefZW\3,KY&1^WNYf>VOFd[22[)\.Q@A-9&Rg33_CGee
KgL_aH\]:,V1B->L2d8<aDb#T:PABAJYT3aKI4JVUQHQH#UX8GYTf+eTP-/0U1P9
[L:b>Z&F)E\fS#<RIC4Qd0;6,=L(X0&#G&3&9[Z=DDSUOg:JU_Dg7\2cF7L9QPGD
VDgR[\Y69FbOKe-OEgM>J;DAQ(KL1KULU427fI2d4GQ8,;XSaN?Q#[/6b=FFQUT5
X;(N>#^F[ED(ad4^#NA:d>L:,W;\#[/8gWZV2cHX0FPQ8-4X,\N;aGD4GDf,FK3M
6NGU;X(DE;719OM[Q[[gQW789T[VK&MGD9E5cC0EIT&@Q:dJ8QCC.Z0@+&g=)eYK
M=6(+2\1N0#@K_)I:NP(.^T4;6@SMR,P;DSO8]97G<T;RMFG:@T094[11>360P(E
J&1,\8A+<)FM&b[H8@?II#?HCC-<PTRbA3,]/3>fCE/#dfD@FgB)5:68QX#_(H&=
B0IU2SXY0CVfLQ[Q(?T_6PB.0d@N7GHEXH_E]Z_C?0/\T@,B+#RNCRee_A(d>:(V
WD(0@ZFR1QCXOY5)&OdJR1e^PVdd)04BI79R2^NO=6]#APAcA&6@-@:FUM5A--=<
8XOO6EDg?aG_SYUIC8U>XRZVcPeTG_70aB&CCc,F&BX75g>_C[VLScE2BY&P7Y8a
<&Va3&g)TSHg\KAe-]Tb.d#^6[F63-/2R.Fb].I&M50H+2/+G5>W::?4\V]c/I0Q
7)JC_T>JQD^^Te8]?R.A2DRd+8ANQHE-X68>#GMB<P(7]OZ^IGNOZL^T@Id?@5/J
>8gfV5P90FU.L7?1-DM.1)EegZ&J3=7O)IZXdf_ST/0O\45W1Q=+=5A,cd6#K>d-
,Nf1ZAQEbf]^@6+37)&<:&D2164;WCU4CW)d+Q.LJ0_E;f[1U\[-3631-f@YR>-I
A6OF?@LcA#=)0M1T^D4EWN-1fK7YYXEAV>&_2K.#@EWCe&a@38TDEE^-T<)aHfcc
Yc(I0/P2PH\JJ6Y5AC:9[A/OH/eBC+fGd^,_9QK?a)bIC0H4K#-QDFP&QTe5OMd9
HbB=7C<b=<MQ<]AbCK9REI\?K#?]/M4,-F]Q_OFc+DeKQ(g&W/S([(ggL.#@&,J>
Ve9QBTN26<VK@G6U,;73d1W2><@_IBLf:R)J<>5PeE]8/\c1&2I.<ARg8.004<74
T&K(e@gLDPB\WcJDR<AaQdXLP_U)[BB),+A<WZU81D>P7eU]Y7,9Z;W16)B]c>>G
,_GG.bcUFW_N@eCTZe1+bTS@Y;#)/dB(fR19gH38FX@bbebRL;9>c9UOa91?UG]L
<UNg.XDPR</ZE,7+Me@ZP[?A^[_I9-U;V=#X(QJKAf1BZXDQeWMZ1c==KfO.Y8:_
,Tc13_+_CYAgI&a[YB]-U\aNBc-U9OLK=HHb.N5:EY?7<0d6Qd5TXR>T0XV96CWL
=FDEW]dZG@NT_A5PBZgU-e3>MN70V/8fA\&a&P1eEQGHKI8&?&;-ba(gBeTSgg8#
L^;d-(S&HV5c2>7QeEc&GeG7ZYTP\ZH^E[,X9HT\JN.J&F9Gc5:^G=<TM#L&88J2
N3J\A6AX)EQC\O\SGNL=XSE_//<>LU+:3031S/P.@9A75@T/H+>M2-++^>)FEg_.
H?)3LTg:/0P8TR<J)ZMca&Y9==7D(:JWT3D2V0^O+E=RL3eDRCcLD347R8&\f<,Z
HaZT5V[I@1F><a??3_d0TQ@\>^K;R/<I-a0C]SNa5aXT38bMM=dR]XbGTW368Q&C
0T@^OVB(3.1[#Oc5ALUH<[cBN36@Xb0Le#7]XPDS,Sc6?1\B)47:0f;][[G3H]0>
cL,XNN>X?D2V2_L_=?c4K^B2+;g\BaSGYP5]@fAY3K2=DZd)])U7>-L\H6Gda;>W
I)NGgg/gNafY:V,1[P=8XI0;U6GWe>#eH(.>-J0Pfc#BGL(JPYNEI-=\Tc\(bc71
TN&XdM[R5[]60(0WV@G->M)D9IX#3=(@]-Ef=<fJPRAR/0FLI,&fZMX#6KgE,HHG
5e=]bI1KX1YC7bbB#M1V4?[>XJ,5CVe0PZ1Gg-LT2X<fN.K<J]/8Tb8]4[L-&?L:
HbEcW&?e/_]Wc&VBR\:YI)E57]Y36[AW68cB;a<_2)]T9P3(VC>\EH2Bd;JZ6XF+
<5,N/1COI8W)FIFOV3-+CLBD\U/A8^.Q]QEU@[:Z>aOfB[7G;XV@VXVME+7-;P3N
g#d.H=ZYAQ>1eET&^=ZYa6dT4&b@1PPO>S7LK>-OQW&>^SA=e8DLDe_)&.TcOV8)
#&BcS&6c/0CPAA)B,@V5)MX1\JNHONDD<$
`endprotected
  

`protected
Y<aE?QHN:M?]fU]@U3gO)GSfef.[_4N(ILEf7g#+A,@9.1Q(,:#]5)MHE>XHHd72
0Vc8+XZ[V\W]-$
`endprotected
 
//vcs_lic_vip_protect
  `protected
6&V)K)569059aSb26Wf^aSR:K?[26&XX^I.H#(&We2<V1)-H[W0V/(+0ePX.7FDX
?c#4X9b\L8OXcT017&7X(MY/1E[JY@MffTKUE?8U>05DS]E=:UH8T23gW9aVM<R&
8U]ND0gfb1bCG[g;@-2@>R0=KV<+E_DL17gYG.^VJJ9DEN9f_GQG<=7f?G^SE[5=
bM2V,_R.8@B]BA?1DTMR5PVKL@Q@0S:O-P]DBF<BRJF#@9Ig\RD3LV/S2/HZ>HW2
e=X:#O>VA(U??JgQ04gA:[+VW6Z[aO9Jd6G4_5F(,2g71O4_TZ9d7fZ9>>L[#G94
^48\WT5g]]/6G5TW0HDD4YXU@^OR<2(9R/FA-.Z,(X_F6LMf_M:AK#Y>a(W=#2cH
YT\UL2.-U,.E)Z.\.1P^W)JBZ2SCG;c6C6@e<],V[NGGKBWZM/>JXAS(<>6S=PSC
839AKO,<,8U]QXIH26b1ca55g:M3X?]F;e.a0)4R&5KS.U62C,e\)1gEfLN5HO.G
MZ)E@&cE-T,:H9,O23<,-fQ5F;.,ARE\[e:W61+6G:64>YL@X<\<W1[f]W-^HG5O
E@#HK^2<gFNE>-H,0d3\DBS:W^=CF(Q32cU:d]FVM/c4XL:+F9L\/SD9?gfd,g\U
29E<XQR6?FF5P.NAX1R6WKHR,[Z2X]e(Ze?]Bg9Pc@>WHT(O=fEf:2>(3Td948UZ
DMK4b5b\L\\)II5>5[.=QXC286>W_27F=-R]Q_KV)DR7f9([M,Q[SDRT)N/Fde[[
4D5]DB>C0Tg<Y(=]]d6S[ROWg:@.g^#B7VA0cbG52fJ<:.Y;8BA46S@?=a8BD_Hg
a@BAYQdW>]LK2:()8DBRg2U1TYA:E22K643gNWV^cd-G51:0<fMA5A]7dUOD3\/:
c?^,P)U1f4;b5F(I.+f@E,11:>]>eB;5K)T1NaPCf_fXff#;S0>P,4Da[98\?VD(
81I>8#2;M,X-NO)]38d.#H,c<:A2X-EP4P-?2]7+8SBbXdVR3Z((-BVf1H&f;Y\W
FN88FRV+G?[KT\[LX>5=c3DBOQKZI]#gd>)0f5ge(B#H(b5(\=.GL/23^RdIR(]2
74+U:MLJC.90R-QQ\F+6Z-;NOMa,\2@Y6\f_#A^Wb\fMcQZL,^:YbY[gEcUO#TQM
VX6+1-(BI257MQ(ZY=cS8/:732R)OaVZ9O-G;[EbdePG>bRc#.S\5&Q4#)[^F)X-
AWM^IG4Jd4/NeT9/I,Saf30C;-X@9OXeb]K:RN9WacOPRJYJ#Q=B.1,/NNUZEW=2
->^ONCI5,cF&3Q6@3>F_5TaZfEB:H2KZX=&9)8U3X]SL[(+:>U\CL[P-O\V8_G\Y
2Ng>2,V@W.0X-]&OcYfI;W?XX.E/621V7)/1gV28G-5MCR7[/9TPWRFXAIS9Q^g@
9WXCb\.D#)[J\&?(#YB)D;/28PE,8NG;:>O5ZNVQ(]6N^,T@/;3<9<21N]E7KVYU
e\2\EOE)<G]bE6<Y..5_SZIdCOZQX7E^.@=S_0b:=Y&[?WgD\2\WK@<^P3CDdB_5
BUc:dW08S^g_VcY,:S5ZZZ8fAg78dY3TJf^0:<G&Lc]SLCK2gH\5BP-5g&NMZ<=]
>\-b)8g_H\b5Qb:QcF3A0FUY,E(Z4K6dc30b[V6&\1)7SC:NH?OZO==+LXL(_(2<
c1gK,fF_.dBTYZ3dg@0RS4S^-NO695IB5TaE)(9_;Y[6d9/^H(E?S:?\@^8IGS&F
X:X)S4?]Pgc5T^;dVQL-L.Tdd-g>S[(Z(RcPHD<LcUb2?S@X3\3acdH9d?)dQ9Ed
J2EZ8E..6?3?HU69\R(@W?Oa,#9-c>dK0;&M2S6KZ5@I@JX2]cO@F4E.CH#=&g?X
c]M>]#E;@b.4P9?aXRS-,_d(C^33O31]5S?/]7QT[C_6,bSCU+H?X<M#I.\FB;1X
DHTLOD.9OL[2>L;=WO>fQZE89W8#G<<\Cd>.Q;UG;(HE^A3dU;bGNI^2<RIV<KbJ
9R4_B];@gN8TQ;&Je5+0P_ED<:^3ABO8#FZ;?3:c]d2LNLF;_.-bdW[B11])Z9WF
4.b?9\3fJ0XEI:R+gP)#e.)Kc;K_A1.V3BG&<3Q.N29<P@</@aaK+Y8(>PJ#+)b@
a6GS9C3?Ff\^?DD6L7ebOXf/(\Ke/1dI-X->B&\bab>86fD+WK=+=XVWSbXT7S\:
d6aa#([LT+2PD>eb0F9a>)a>f.(JRACN04d)Tecc^XP,Xe<@I;YBF<#LY=[SL^HE
Ma_F=S<S1PIQdbWAeS5YY<ACH(GZRX0D+]]@K78+&?F9F#F9Pdd+PV5&;]S8JNVL
Gc?=\B_.eSMWP2>aX-L>8\]<G6_-ST_^8e8W1)ab[P7BJ>V;3@Dd+_8#R]2@eA)7
?SI#+0_[T8L1:.)-P7B8a-S+O:^8d401_bSJNN=UUa.e>5aHM\A6F_9Ff_bHc,67
PB<6EA:DC:LY5Cb+#09RD93^,YBRB(:;[Q<-8D>\Qc^1@_6NQG?_c\PY#-1XD.^T
C6#(Z_RVJFE60S4,KBAd4O8+b97&VAQNdGNXbF(+F@8:QJW(b@:^R@f@ga^Ne?e7
)MHe3ca/[3DdF<BG?=<eVfFWPN,AD2ZE@9Ud]:R5)3HNU,:GbA1W5HVMC8U.)=LZ
\GA,SU-AI3FK,d8&G6BIO=2?93G>0F2b3=?@L(^Q42ZdVOYFa,Lb,e3IVJD&N]\D
W5BVKBX]-ROO=Eg3BO,8RW2R@-=E(g5+EN9Z62\\V1XPb#B/]Qg\De#[=<O_O,Ka
3VJ[)XQ8O(fP3TcWX&IdeZ3DbS2U2<-e?1WW98QA<XFDIO&KM6K>-Z[U&IS6VS;d
ENKd<0RIND>FAY+=J-_Y8;OfYI_;MHf8JKERfKB&g?M)Ye/NAcRG?#O76S7J95?&
;f<P;,&DQ:_E.5Gf=D(b@]P[8=0TP]_Fg.M_-2J^24E8W7eML=aPA_91N2<M=4bPQ$
`endprotected


// -----------------------------------------------------------------------------
`protected
a9P^MDKKe[)BK1=C4_GA\X#&W+.AV9LC<A53OGROU71f<#;-<Tf3&)-_bbb>R:S5
PKcL]X#0)^2B-$
`endprotected
 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
ffDKf>a1HgO,+:^U?#-.]9_A+Gd<=(CAd_<;45NfJBWG=EEV0ZR+5(c^6<[cfB,Y
Zac6LL;7S&aD2-5.OO(1Sc/LLW08^=&R],+g=>^K3[Z1F+@;EAQUQ0N\/AIE0NYM
723X&^96G0OggX8S>#R,F-:?bV(B<+OgLeV2bR-RJH>O]M_.O-.ASI?DNQ?<d/e^
Qe=F^;N^T5SdE&aE)g0T)0BD;JYB,da#ZNA,^64IM,G,]K[E;S=N)L?@Z8DaTX<5T$
`endprotected
  

`protected
VF\IZ<3ZbN/C8[N&3XgbQBTG=,71O+],ba1#7\JdYLFNP/NADJUQ.)Wg3]FfJVaR
R6&.#QJ+V-eC/$
`endprotected
  

//vcs_lic_vip_protect
  `protected
>bBD9I.&AP+]A:S?c58TVSI1,Sa.A,U\T&I:K(81HQ#;6S4f#Rg@5(DNABQ]=/<>
OIYc;G4>bC5eR4cX1HO,eeZSS/W^.FdH9aaQFH)4EX04;2XTQT[.5&M5^U0?DO,g
6V4J(>RPRD\e.$
`endprotected


`protected
0?TXTEBA9]QE]@+TLIS0[N5#&RC+[LEF>2_0SgeCU<QPE-:d32NW6)fGHNH3RU->
/?HS^UPE+Q;IM7b07cH\[?5#2$
`endprotected


`endif // GUARD_SVT_AHB_DECODER_UVM_SV





