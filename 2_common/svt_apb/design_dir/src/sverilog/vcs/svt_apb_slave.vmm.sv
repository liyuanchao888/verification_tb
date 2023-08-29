
`ifndef GUARD_SVT_APB_SLAVE_VMM_SV
`define GUARD_SVT_APB_SLAVE_VMM_SV

typedef class svt_apb_slave_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an APB Slave component.
 */
class svt_apb_slave extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** VMM channel instance for transactions to transmit */
  svt_apb_slave_transaction_channel xact_chan;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave components */
  protected svt_apb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance
   * @param cfg required argument used to set (copy data info) cfg.
   */
  extern function new(svt_apb_slave_configuration cfg,
                      svt_apb_slave_transaction_channel xact_chan = null,
                      vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

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
  /**
   * Method which manages input_channel
   */
  extern protected task consume_from_input_channel();

/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_slave_active_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction descriptor from the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A bit <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action
   */
  extern virtual protected function void post_input_port_get(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A bit <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action
   */
//  extern virtual task post_input_port_get_cb_exec(svt_apb_transaction xact, ref bit drop);
  extern virtual protected task post_input_port_get_cb_exec(svt_apb_transaction xact, ref bit drop); // Vijaya: not sure if this task has to be protected task

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the input channel which is connected
   * to the generator.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_apb_transaction xact);
/** @endcond */

endclass

`protected
T-:UdR5;0?HV^25/8P4G\<MfR.<Y73\^TdB+3bVZON(d#1FQH6CR0)e_aDL&Dc_N
>2VZT+=WE=Bg\)TA#2_Y.bf,#?C;ZMKK<88^Z2JE79[P36&9QW]HJ#:/Tb?c2P1N
Ae?IFT5(8T;I4fXfT8fX5_ZGB9)/&cL\\+;063H1+GfC+FBV6UJBE?d_>Z.]U7IC
<37OEb,\4TPb([W3#EB^9P3.:-#fcU(5bWdGNGYXU2AC[d7;B:bW[<RJ1+CYH\bS
4+H<cS4eKUDK[f<22fHf7#R6aO::^Qb/Z/KRH@Zd]-g06;JOB_MWT)QBJ1Le.R-.
-.WQHg<#W_bS>C2<#=+A+a5UW0:b^f&YD-:@]3cBMQ(ZO=A&e?6S4()PHZ5>H7=-
P,eC5=[6_-Y2XV6-4>1V=;XA]3Mc2O#,XVGQSQ5)/AFJO^e,JF<L#^Yc_Z>:4^NP
0b430)41TKVb4C>R-S#/^9M]2/65A_AVYg9]a).83=2g6KMRI[CJ9cafc^)8K^\Q
;+b/.TL#+BN@_LDTCI3A#5@cK#.GN;>bVA^ZGS=OSIFeRFaLDPZ0W@T?8df&R3?E
Lf]-Ra\),Nb.DYX4c7]6DCdJJIY;)f]&R#GY9U@([1^XfZRMK&+4CX.R:E40>QRE
X5<ZEe+#\.7;0]Dc(8PZ[E=([c/.1URCDadgFW_]b)&Ee)@HFYe^<.9fd[O&@V\Q
P5-1H0@X.ES#JS]5g+R^3WVRK<O.6@PKUH(E&^:,Vg4ZN@_eOTM2&WJUV59E.3:D
48U:F:\+YQ#IWaX&,NYX/20GdXeI;AJ;9J4IR[C<Nb)V3/G4_<?;bgU=?4C]f;DO
fOY<0f-VF.c#9-gdOTHN>Y3X^/fZ-?X0&(F[Y0Tb].G#VeA:LZgV-9ZSNTZ&V2ZK
M__2LSgXAQHB2=C0gBTE-&XF1V,5>\#5,>BH6EP;?c\_#De?G3P7PZAb+I1DHHHA
?I;@XAHg@+-dR7cW/KSC?3,WfA<dBOVC2]-cS]TNI7U_A<7gV#-8&W(BO+,>>E7V
ZVL1(b-W&HZH2)+8M6XD1;O-.^EMe9.M\WJMY1V15_K9aALf1.6eIaFG,=.f>W[E
K9_-,dTN?P9XG;:;RH(WFFa:Df>(2<(eY9(OWaAXL\9+d8I\?=^:M\?757XH,T6b
Y<+be&;LCcHKY:PY.]+MD.f1R6F6T53FQNgMSdZScE)2UA.@S1N]^BZKBD<UJ66P
.0T)/1HV0\0Bb6<\IT.=4XS#fT2e()#MK)aFAdQ6NND/0UUV\bG(^gBcS(;)eFY/
T&Bf_E24VDC6eLfR>?/BHJ0;IZQQ?[CLE_B?L=5CED/;6?,E>/\C:<#^I2K@5cH[
6;]2#UdP.Pc8M5_-)LV&UOKU0;#-:CNQaZadKdAg/e/FTI3?YF6S4P\;KXacbc+:
8J0^G5@,YBf_VS]TE24P3\B7KB(Qf8.K9,2OY[4UYbEa4IUMRK)&Z82F5QY;4OcP
T\be[bZ,/17:f5.9/e1><B:+63RbA5UX]N;X0N]2+3UU.\X<>&OMJ22FN$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
Sd43U,7/4GL1<Ke^#<KULcIS8X0EgBEBS9bf;;^]f_BYRY>F8WbK0(@b/FTEB2Oe
5cRTF(a324EYHMHKP,LX@_W>F6Y@_,(R5GB8Hc:FBV50G\HZV+G&DBfbbD\,WJgK
<Va94]HX]<DWG.PJe77(Q-@_If:&Gf3d]c<R0:0^&HRO1ZZD19d-G.H=M\2:P-=^
X+)dJA&D;S8SY>]AG<7U#dVD>DROL,<a?N&V\/fT4LfJ7);C+6C&;bgTG17H40]e
&6d9,VP]U^EaXS1VO^M-DEP5&f32b,d#OG=)_T9/[4f.EF95[K0_+K@9J^U)/2B>
;4PEU5._c2KE]@VQIf\U9;<##A6XbX;c[2YCgT\9P.0ROc=026W<ZL85<P1e[XM_
ZV.(++Ub/D@#;JZ3-eP&[0g7RE>=^RN3X]VEa7)G/9SQ[dcTJWa\&_DUMIY9f+QH
=fE0=;Q3Z56D692-U#=X6)99D&L63>/<\:C.\CYNUW>HOYdP+AEK\]3gfAQKPLG9
-2[AQ7OcK>RM_-Y3Ta@B;Z81bcQ8H=VE:CX^PGNHI>dO;\(EEJ.UT[FH&7RTXZ/6
c_NC=<;F5E7@;9L@O(dUAdWJBJ8+FS#gCX6+L;XYecgT00>/LOXJ&>,5Q:;?Ha^Q
GHeWg;6Y=YPO(^a+_dTfQbIG1HYbPZEacD7aK/MgBQ\LIPF1BfEMIR:A[43^33B=
dTg/fU?]X8Na?]5GM>PJ:6Z;5Y(+76N0Yd_2QJ83aHfF;X\bJ[P\#,NJ9XS:ZG:f
/b@.:12b>2VNDgP:W^?_0K10JRY#8)J2U&/[.J;]f9QZ(#R2M]N+PZK3_#2+D8aY
CWd+Y+7[gcd_7>_80I2W(&9LK^Dg,>X69U]e]V;?C7/c0O5@3Je4@PE;WR-6]#;2
_>ZC(:X#L?:a[b>Z/DWTCIJC@^XHfe;bYJb?]8[2gS6>J:dbPeR(:(AK:(U#[O0J
PV2^^6;[c[.J1O+:cWPULc9UU+b6W++Fb\eG-6WUL5/RGL73]>S=Qf;c&P53[f65
&0M[g8\TA<]3bUVVLV5MWfJ.=0Bg[eOD;LaT@P;0dSA7L;N[)Le1O=(WRURKH@NG
RZ@&/6DVV3e,Q^CE-XKUVCVgb7O_,<#FO(f47d5)830._fE5@G_<SVM[9LfbP^\8
M+2-#?D0S#(cB-;=5>dF0d#A)W/A#.b,1:gB?\_LPHg1(,?Y)6eTc_Sc,^1>3,SZ
AGLU>[\^Q\=WTXO3O5;b8>UTKF>\[C&CFb4^ef/R5NcX4U_9WDd0B-BKI+75g_[T
D^C;B)3;U1N384R<DXT<EgWfT6LdML?91^:)WEY&e]IEaXVRQ9C-REcIV_6#[e,I
H(UK:G^0^B<YJC+dXM:dJ\2FRH>K#9NOH@+?T?7H>\57W4_SF::6d_+^\#PPX5Rb
AUN6GGSNTMHS30=e/4GN[K<TMO&Xd]@--?E@<(,L[6AFfD-CT@F>9/&bEfNLCg8C
MSAVY/W=R=RUPUg5T9=2:CZZbCgF&Cc<(W=UHO9bc?5GD\0_cKTd?W<D.e[F\5[O
[,B0a);5FBL&Y_6-Q+I(BRDE,g>WHZ[?C9+C<Egf_ceD\)9+/UWC>:9VWgfJbW:P
L.>81:32^J=7D8]]UJ.3]L2>9Y==g?I\V)(4QD[D3eT?cM_I027Q]E=FY;4VD]f2
9T/B_N?@ET3E,LQ)C/)AJHG0V8)/(2^3K@:Q4e]I7JJ;;M>4b,5.K</A2/0TY>V.
^EEg]8NQDM,&Q84+=b(f(WS@LHND?7-;<>.:\/XR[[-J@-]fTO6Pb<=Te^8fADVV
IQ.-V5G@g[aN=:?E0+IVG-@B>,JL/LgRf,ON1IdU\c=((=&@#b]e>SX]Y][N4.-S
P219?T@SOG=FY:=]VZ6/0YNX5-#g0XDT\4A,bQ@cFa&DW48<.Q[dG_e>,;+O>=<?
C9#&I,-7L9d-])3MbC_JEc-CO9?bfa.gQ_0Q]0>33(7+4&DXfO;,b@efSSD?_gbd
ZTMb]<SGe/_U\^3PT1_-YgK1B=H@-9Q9.T/,#41CPR6BYUZ-Ta;ITDUI[Jg.3X3T
=O6G>9A8?68#YFTf83HD+C]S,6+1V9A7]I.V3MEQ5CNOAbTOR716&Z?aBQW/;>4?
,,I+J8U8aBW3.f9,g.M_F?E>NR)BF:>5\A<dEdB>f\5NDZ4:0(V3f1H9;A)9E>)C
W,(]8E@@0dc-A^&gIT;(X3>EdDGBCX2MdNb2Q(adX/HaO1O//LVVeQ+U=^:WaV5M
,AD)1,1(,-\N,X_3a6Wf5Sfg2&9bNZgR.^X6S8V1)-5GX)<G#KC6[)3feT8.&d[7
9Nc6N&03(IJ=SM+E_+de_(3(11g->M7?U&;L<+NI,DJ:@/WUaEa7/]9G@#RDZ923
@K3)If3#gYYL5V>_g<&aR@/S9QcDG9ECZ2BN.+E<.C&U,?d9fT5:-,T3:bLXFKQ,
))M7.dcC+RL1UQPX4&b-L#F@=<.3)HF7INd8gVaVV0HWEJ&LXg)YS]6\KLZ,O7.O
:9U8WGI3BN_-<PFW2AMLf\NFcGF/XEf&eNEY^&PCA:/Y<QAOAWE4EECE=.RPJMP4
06]BM(3JFUYL1a_7=@Y-5BA-c+1@9af&??e6ZC><R,@1W.<c+>IP#^0?BQ;VICZ]
b#@F15DV?bMbH336[T;7bZ_Z4PPeMV)8FH&B3cWTOWIEab+c<:9R<9O&F]Z2+E0\
[9KVELUOEP)Z.QA/g@YH-B<_9O;UE9J2_DaXA827]bLGV)RcF3U&,-S]gX_Cf1bf
/A,YWV):63XLW4R2Mc4aTZ9b\+ILMW/aL\b-]>)M4J06R^6.N#IaQE_/SGK;eP;W
fd/aP2T9[?PZ9S86Ce[5Y\>PT[Z?AdYDEYA?2R4?(@6<2<Ff[K7W,IdCaIS(BK4Q
XDb=<<JYTVe.#QQ,\+=9]+IIXN.:+H]+acc=KUcV[R;BG&Z.AZ\:bSV][>+_RN[9
#X[+gg.L,/CcJ8FV_E+fIMP=MD\d:(Ne(:a&f-,b:2PLJI;T@DbH^QOVW<A]<JHd
QNe7@)X-T.+(ODEb[4&08e=5<P_:C3&\0W_]X(H:X;S(QBIdL??;/1>@1Y]6H-A]
-8S_(5-bbe55)Z9G^-VfZ6FcVcQ^L7_e)H\gRLa[/gf/\Gg:&20/=F@g:OJ-;C-S
cE=Y#@6817HD0Ga7,]J04YU9]:N69-;gPDC/P&S@A6X;\8?]1b;]0WQ7e;&#)3a.
M+EBc2YPB5Ebc)6ZA#3?6(BD08W#UMc:a-\6)NLF&=CUU\UKe;;Vc[@RN0KUg64a
1OH6@eZTR,D-2(-<-T<&0LMMQ^\2@G?@(38]YW?H_?O3HLR0<I6^T^ZU9?<)\DPV
c[-E.5;LXO9-Q:T>@&,UdJEIUI5R;0L_01RMU^1e5FgTR8-T#O#9.(>FO2/<GUd#
))=ZFBTSQ<PU+PR#PP/)Y89Y_@a+2>#/.@a\NRAXIW2aIK>.a9-K#4;2W/-CV>SZ
E-JZ3)1U_7HA^S33f@@?2G62:<&2.IFD?41a_.IJTe[2HcU=>2]:X_N[U2APBF>M
EDC@FG\JJR/53G?WGb9_-@N.^.ICOMQX<4Q.ES]#Y9ef>0(1JZg1(:Fb;;,(4I7+
7DbP_=+;H13Y\ET,I:\O6,e9egAM4W5^GT.WG(M?\LW:bZbUX5fYc:&]XV=?J=ea
];^M//(4OV;.Y_V<OW?7),\XCL9QGd/8g+E^[=C[481#9QZ^MS1=:N(/VggP:OS6
2HRXH&89QWY9&aM4\/eUP9HV(Da9LQ\TbN]>GGI5;L:9W#AB<Z-e[@+[;#,;5Y[)
.fJFe_)/2EH<_OJc+#QF4FWOSC>IVd)/-J(8FFfbR;TK[D3O6<N>R^B^:6QGWQQd
HH:[XMJBL_9U_OU=EYd@U=,8<]L8F]@&-^YReQ9IR=AL,[L/Z8BWEaP33^A-W7,W
A>bHJB3@GD2^dId/A>;=2ZC\_dbaLZ1CB055>1CAD5EId:O>@E-;W;/QfH/M+@Id
8A7Tf:c9327PVK-;QRKcZ3b9W4XdQ;;\:ND<,:R]I)&/cLIQ>4Q,]9f&75D]0NN/
]A<;9<@@1;).^^Oa189b#_&S=[2;(BggQ]?^CTG_@9+XBI=LcOb>KKU9E0?NDM&D
[V0<2caR).CQ<M3GOYe93b3PLP9VHU8^(J6(QST)I(]?aUIb/GZUVWY5P^VZ:Uc/
8+7K@ZS+O94_1+4/HFIF56O]c\dD.VL/[7,cQOTA2CTYQ,WFSFL)]bQ>CM4)O_CX
5::^R2WMN,MH<DJLc65-U3PAJ.:P==N>O1g3&;ZF#IULA6M5+\L)777FH=(H+0EK
9g)/K1KS126\_G:NH?;a@#P=B5XYS3Kg;E1R1)aCR(PI&P@bCS<=gV]CF1?)?g;<
^c^-TE+^IgQZ_0f1?,1\c3NA5bV<C9Ycd3LXY;U+:13NbH^XD<e;)>>,Me76R]X#
BD-ZSYB/<f19/^B;QN4?1JM+MXVJO+D<^bL<1P;Y2\_S0eS]PO.<DV0&P\GL>M5<
QFSK6.@edCMZ>8:QD^ZU_AC6^aGJ-4+RP5dD4=QcAaa;WHcC?3N6]@gc6;d/D(8R
ZR#,8.KM7R62d;b+I>NT(?TaeN>G>)1H+IBaf6UCJ]#[Z4L^]^Ggb7<_KDYXP3?]
H@:YIO-S/=Z[5>;4(/HPAV24(^;^c:,;&G6.PD<b]7J&EYD3/V[If,PQJK>.83XX
N0+aN3G6PM(9L9dDBZJYI=(FO;Jd]:\+.#N]?L_aTefRHHgLPfAOV#:SHUaB(Gc[
1#_8g\1df;(T==I0C](27G)X\9L#9?,]>@]=\A?E7<TU))Q,0TQ^GDfVZ&09.[/.
eOc>&.PMgCWWZ,E2LHZ_Y8cGP=+#-0DX0G&:75\Za/d,MabZ^<\d#+C)fIZ0.?0U
=aaNE+53KO:/#M8>J;aUDe[SW<5L&J5C8d1?d3N@19^<[OB[=9_2R]V,fKK6cKe[
=]^Zg&F2&S6WVC?2=IZV=-#5M-CJ=;2M:>\H\NL->]S>8(g.=O@FD@>()^)fI))\
T[T7[F80YGP.&^S[Y3X)QRQ>J@\BQ:R0]/Z;@:aDR1Ng+);FU2eZZ=Z-O7@?G8d,
(CVZb-@+,[EQb_a\MXP0(fMX\cKNcRHTR)-H7NV(.,Nff#QWIWM>Z,Xd/Z#(c:dK
T^,#b3S1g:O6W6e=]e=Z7S(5^PJ6Zb5W;AX(+TLd+<-))XK;M4d7K8e[_:>Q/[d[
(Bg[7@<dEP81^,P1Pg:c[M]LNF<<-WV3<AZ^-CC<O]gDcKR-Y=SM,4AaENdAUGD-
G54TfAcLJW(M?6#N3H;WDeXc#LM[1eJB8&#OO7)T<[C5V6B42=<IQCMT3L/aL^L3
AO:-?2\(UWX5WdB-(F<a<J/4&b+HB_.LIP,4;&&1NO;ODMSCP(^O@OE0ba3X4K\J
fA])VC3R?TP3LB;afLF7<LA57-?\=0[dO9.U139PT/:X98K+8:SQ1C4<5Y[6=cge
g9[&CH/XR7&e0A3[>_UW6J^Ia7S>TVVNM470MP>;NKQ?(S/)3[Bg3/JKRAb[gScd
1Q>T7HS.;_HO/K;.fg>7E#RHB1eA=dP&dc7O\7fLR,&:QKMX8a5EDI?2/cga+6(e
HT0MaWJ4b=/TM^;9QCb8,([2=WHYL0W3[3/c,;[]WPbU2@U\?.QOTV>ZK5^MY0\[
b,##37e@O83W3eXG/=[SWQ13J-Y(G6:E5^4-fEX,LIQK+&D3K??I9f=@#(0N-X2+
UE\8?_4\9Q403;F[ZX+&8SOe#P7@CXd&_;XW<Nb@[EKV5[3RHT1#FZ2N?6fX/G8>
:Sg?EV7.SB\H.0FHT).LXZKUQBZ7d>HBB_Y8.H(TS<[WN622,S)P>G-FQJ?L+>)1
gA>Cb?D?W:,a@CAXZQ6BgKgD8T#d(;;bYJReO_WQ<(SZ<b8CB(L:&J[/S\/1>@BZ
YNWLMcD-2T<&52,TP4PBT+[[&[/OXgWd4U2C6LBa89CB2E4HM9#2Sc1Y_GTPdJ<#
b4K8.(7OSXD00ALC_ZV@ed5)IW0[5WK:N>TS;SQJN5&5OB3^#V.HF57D.FMa@>N@
JUWD<#_VXYO?4(b&DUTRb_b&3NS6?^2=ZS4R]9Y5I\aMQD[E/X>ZBCeS\90Va?(Q
W.?]]d7<e,2+abHWP?gT2(R2+>>H_#XbV+IT-7NB_Q8HBfD.7AMT4#@2_JV:7=KO
0H\=55:#W#Cg:8EUd]Z=_LST:.WOVS,O86Sa_A4P__#^(77[__EYgeTQUT_:2&Xf
=R+[b)d?Z#-H3b4[#AaECNMNFVBS6_Xe1?,;]4JGVKFX,-X[G_WIS@/ScZ\8c9.2
&T=Y9XQ]&XH&GVXaKHbAB6Y-..KSG=_^a=-FXL]TRa;(W+T;,]MeJ/UJ2eBXB.)&
O2306T/KQV?/6AfCWH7LS_->_5E<[V\gDDJ#QMeU+&^0IVO:NWW0^bP9#G\aWG,=
<8a_A[WET8OSPB[=D5T>dW?IEWc_D;AK^>736GNQWcI#gTA2ZR-K_C#0T>QbLIa7
OEVcANTF+G<8B+8Q)+e3F7[3YBIG;)1gg,.PE\>ON[>CZQ27<b;LXI>/L7aWU#<F
NO-9>07#;Q]_4_X&JKB&S[[S+6X9fLK\B;_fT.cLHg^II<,G+e5\=WP,Xa<6..f=
&-AL<ZUE;<?HUC]FDB8&,]8c(3OXDg+Q03c,R[<RBKDS;VN;(MPdc0eDT:gGaWP-
O+VP4.KfF=UK3I&1=KRFN@SaRM.He[C:EE@P<2Q;G7+I+&DfT\:-N:1bXE^X[2.\
1:RM/+T72,Z5JXV55e.:b>1;1&7KKeP1LbX79M6.ZePZd8[8>?.69QaH0TZ/3P&F
L-DeF5?[,UO22TOTG&Rd<?I^BJ]4Z>EW4Y9K37K2<Q@g.b[:]XV]#2HHE.KKe[)@
=Ca>A_^SL@?6(g@IFF>N;?GdAdbQS0\FSKB0MS?+>EJ?B#XU][a@&)8F&a?N=_+K
UHe5S/\eM4\^(cf(JTR:6cZ11T7K:fLX=U<#Ta.Ref(GW>R6EYJgVEe?+IJ_ef3H
-fP.3MaaXT6,^a4\_]I(Ca;H#&Tc7E@f5M-;?.+>>F-,_\<b4V(WFJTF.Aae6;E^
G(<+1DVM,]N,+$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_VMM_SV



