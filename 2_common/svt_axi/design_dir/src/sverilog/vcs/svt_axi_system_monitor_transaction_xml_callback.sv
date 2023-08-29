
`ifndef GUARD_SVT_AXI_SYSTEM_MONITOR_TRANSACTION_XML_CALLBACK_SV
`define GUARD_SVT_AXI_SYSTEM_MONITOR_TRANSACTION_XML_CALLBACK_SV

`include "svt_axi_defines.svi"

// =============================================================================
/**
 * Monitor callback class containing implementation to generate PA output for 
 * AXI Transaction.
 * Called when svt_axi_system_configuration::enable_xml_gen is set to 1. 
 */
class svt_axi_system_monitor_transaction_xml_callback extends svt_axi_system_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object. */
  svt_axi_system_configuration sys_cfg;

  `ifdef SVT_VMM_TECHNOLOGY
    vmm_log  log;
  `endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Writer used to generate XML output for AXI Transaction. */
  protected svt_xml_writer xml_writer = null;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_axi_system_monitor_transaction_xml_callback instance 
    *
    * @param xml_writer A refernce to the XML writer.
    * @param sys_cfg A refernce to the AXI System Configuration instance.
    */
`ifndef SVT_VMM_TECHNOLOGY
  extern function new(svt_xml_writer xml_writer, svt_axi_system_configuration sys_cfg, string name = "svt_axi_system_monitor_transaction_xml_callback");
`else
  extern function new(svt_xml_writer xml_writer, svt_axi_system_configuration sys_cfg, vmm_log log);
`endif

   /** 
    * Called when a new transaction initiated by a master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual function void new_master_transaction_received(svt_axi_system_monitor system_monitor, svt_axi_transaction xact);

  /** 
    * Called when a new snoop transaction initiated by an interconnect is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual function void new_snoop_transaction_received(svt_axi_system_monitor system_monitor,svt_axi_snoop_transaction xact);

  /** 
    * Called when a new transaction initiated by an interconnect to a slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual function void new_slave_transaction_received(svt_axi_system_monitor system_monitor,svt_axi_transaction xact);

  /** 
    * Called after the system monitor associates snoop transactions to
    * a coherent transaction 
    * @param coherent_xact A reference to the coherent data descriptor object of interest.
    * @param snoop_xacts  A queue of all associated snoop transactions
    */
  extern virtual function void post_coherent_and_snoop_transaction_association(svt_axi_system_monitor system_monitor,svt_axi_transaction coherent_xact,svt_axi_snoop_transaction snoop_xacts[$]);

 /**
   * Called after the system monitor correlates all the bytes of a master
   * transaction to corresponding slave transactions
   * @param sys_xact A reference to the system transaction descriptor object of intereset
   */
  extern virtual function void master_xact_fully_associated_to_slave_xacts(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);
  
  /** @cond PRIVATE */
  /** 
    * Writes out the system monitor XML for a non-snoop transaction.
    * @param xact A reference to the transaction.
    * @param transaction_begin A bit variable to indicate whether the transaction has started or ended.
    */
  extern virtual function void write_transaction_xml(svt_axi_transaction xact, bit transaction_begin);

  /** 
    * Writes out the system monitor XML for a snoop transaction.
    * @param xact A reference to the transaction.
    * @param transaction_begin A bit variable to indicate whether the snoop transaction has started or ended.
    */
  extern virtual function void write_snoop_transaction_xml(svt_axi_snoop_transaction xact, bit transaction_begin);

  /** @endcond */

endclass

`protected
NYQY<WLKf9/VV3d,X_:C;G7M],D;PA4aM4A#)d#.I507bRJR9JX70)F0(]=BF7[O
fFQZFB+4UEQ3HN54B0R&g<3H/UD4V-bRg>IQT1YAbd39MZV.6+>_K+TA8-<B/XP@
FNN)U/]3[<-_R?KbN\5+7EUOUPL\.=Z^/dcQM<>TJ@=M]4):/\Jca[2#T[Q(6fF:
GbPOc6V[YJ,^Egd5?Q75A-#;VM^Zf?:BBc)\5G3O=,.:T762F>IOUPGW9f>)M\CR
XW(90G::/U;b5.W1Kda(C_RQ#MM=;F1GQfVb^7R9YL(48(\Y[dF/?A3.I;-eB;cU
K8FZ):>G;?4X-5aACK<50NBY[b967eF]<S\;#cb;e@H9&#02DMGN7<14<?61]0#3
c:e.]>&+c&@4K;_:/,I6)XL<?<4HC<),75N#c+/H_T#KN_b=ZEXfA(_VBK.:8]Ma
NRE4_V[X,P>@FZ<X=,F^Zb:<)S0Vgb;6<^U+XJ/,5E/fX#Pc,gfGE8VeT8+9bUYO
0BG[JJ&fVOe8[fgbO2M+e1W=74[CL5;c=FA]WTFD9c2-T@;gS2J5W4YO72MH9RTc
,b(Rf983&3K)AQ;@f,V6+ON-SfQ9XW;O3MZ91#8PI#>.IH6dXcN>;eQce3W]JW[L
5d,;QB7]QO(6/5N+D00U&^4Ee:Ug50:e(-=XW6Y4\IaceZM/?Pe;C5M>5GZVg@YQ
53C_O@5QM+];9VTGSPY#A;X6YBPOX#U>;$
`endprotected


//vcs_vip_protect
  `protected
I8=6K?J1Ib<OP_?GbdL60gEE8HHXET859[.JM5=>2\Tba2dYTS(Q1(.9;2+\D@(9
b)#9QD@EHA:dJ3\SVQcbZ&8+#D+/XYJd-_<&39JSDb+5QA1;MdT-@f14X8W?(H#?
95HM_=U)6SQU+IUg2H6If48NBD@MS/O.N>IW>+UIQ>PRX?1BcaPa4FE1#T#O&8NT
I94675#1.(Dggb[U+9]2JDHY_?1EbG0B,8KM?EaMU,JU+?V^cF&^(4fP64#QUAYP
GTcaER-Ceg/L_0PaEC<].9JGITL2O/M1],fF?8:O^eA+QD-L37#7&,R#S)MY]67d
Cb1=4P;SFb#-We.-35]J;d^81[-P9g:fVN,//K_W.BOe7/^W@VL/7G4MK5;Jd#RN
[[3;DWDIRL6Wa-C/([e<^=AB5/(addJ;BaMIXWD8g;RdP/\6Z1H@CEO_\C=^54,K
N:/3A-9QZGOAF75bWTZDYd:4LLK6IUf&G],AN_9BS_<?1_3XTM7ATIbNGGaHZYEZ
G>JfO)7/c;/Mc1T&.OG\eOfEXeafHA5/b0W-U;<^S<(]/91d=<6R3,P&eF\[3[(M
IP=Yc]VUa),7).BG@>LH4,H:fPAA,2=K7MW48FT.#8dO6P4>gIEg[S[L])5#9_ET
8EDJXF0?f>gG\deU9g?P5&4JOD<ASaP_T>8d5_^Y\/Y)QMb>4[H7aTQ@Z&0SU5#?
:@USOCO;7R<NA436_^f6#5eGS[8;?:,3b?M;0^K]d83\J/_/PIZ>WcEL_47<.@T&
+7Ib-Y8.S+SPEb@Y2aWgg_bM()XTYd8_9:(JP;/1/SCF+Y?GI.e\3Ug;G9#f)/P.
.dI1]WW_I=H/7?PaOR4d5.2GfKFDbMTUGOIG+10DA2EdO@dcT)Z7D_0@=+QPe2A\
CADL?3g76#@04EDX9X3IUIKZFD9BQ9RJO24^:^]J@)S;XZ#B8&KEF9_1ERD+OSRF
Q<BE9<4c+FHc<-/9c@PO,_A_OYO4#[a:74&F,=FW/M[</UPH1e?f?.\PP=87d^JJ
+c8b_c:26-N7:-M^\VW=L4Hb0agbIMb3V\R4;)I;B/#8a(PRdfRG&QO?\fe9RZff
AUON;2T0@6N6;O/,C4M&#96^.)\EENVbXa.\XL?X9.IT-7N,@D,WWf4+_:J/fRC+
FG#4B]O3;>JM[:;NT./T+ZPcGc2<F1K]&4a:cG&(eI-J3d(4_H]?8@W<6^&@;Xc4
Q&I,c1#K-XEA__8E<FB+>EfGQS@A,>OKL;C,>H:FgWB@[QI>0<f=&fG0F3@1:.=8
PT_</;f/2VgBL_VLb\2cF)C3MVK6\0Y,e6J6D;@DGZ\aQc;(Mc35=P]3RN<5,]2,
aWTNg;+G+D5PO17gN=-#C<=;-E&W-T5\3[VNCd]6<9b^]JZ@#BF-MTDC.?1COFI@
L2A<QfcE>K_5e@b_GC71N_D24)-b,e/RA@>1/E]1BV;gHIVbgW7d+g,O^a#.ET\b
3c?7S5GEdW\ggg[=.^8J>61BG:?ZfW4U@K0T([G9+ML4:DMKB(Z#7QdOWJ:geaZL
9ZeK:0:Z=\\BR>c(3KbP(.YBU\L?6O/R7Ecd]FVU+]+ZF4[b0EX6#d7_7VJS-@/O
1S;]_GJ17\_XDf;(<I,B3b@5TW[)fNd[#G]CWEFPTd8NXA9D[<6.\//5g>7Q3))?
a6KHZcCZ&WPJG]G7)+;(N.e^RBQ-P?-BHGI.-&)X>d[Q9NbXe)Q37S0BdC:@O-dc
^?JW/BP9C41PUEE^77<_+:L;_AD#TB+T9KE+47Q41DSa9.@\Wf\W59;7^;e<7@4Z
cd0I,&\W^Z.L-@9-9-:A+Ac\RIBgX96NAF0B6Yg4aGMdcNZQ@@]W7VYM@eQ))/>Z
bZSZ1XR,6>=SS&5GdI_J2b<.B\-8eC8168Aa17W3_U99[#<7SKM=Tf@X;=dY5U#H
NAV-I[IVQ@ITN,b,HbI.C+T0.9U)T.=QN0O3C5.-9^OXCW)+4TQc=^Sc)V?-4.=,
DF283ff@S)KT_3M4WgfI5^\&/9\P>RL@=BAcCTDNcd:.e.YA<Wc=3D\S6XCBC.GH
8\dX]O4N>A?[<&eQ+^Q/6IWBF6Eg)1b-;aT[7bF]d0Md&6\K)cGZ=K9Cdf17[^1c
J\GYZMSP4COJDR8-8UW\1I37)XE>BS<I&dSccW7F-7#c)9],?EGV#XTeR&K>V/6\
.XU4e7&XYK4ggKfE,DAE7Y_\_4XI(Q:82.2\f1</fH][C8OETIPOXWI<cZQF<dAG
2GdJO\WI[/:(N6U29,c,E1b_=QdK,\+5eOL<R1/:Yg#J/QUHLM6e\_fEDKEYAD0P
57EL,DY5W_3^#gXNCe/gcPD_1M;77g7F]T(BT;[5]SSfcYGgOeW_bRZ]ZLKWcU>g
bO#0/=\0^KFc/3=:aFTE^P?QcG1(=/[.J+_B.E2TE#LTedT_J[PfF>P,)A;14CL>
W:<)Z;cVbO:HaHH5f--+-24/Q/a0YIb4QD:BMUG;.)GA-4)\-,;,;UWcgVdJb]4]
EE+(Q;5M^B^TZ(W6#-a^3\R8N19gZ(W?&YAE3DS9HXD_>V5XfMa1CS(A[T)gFVEf
e=UD,25J9aF7Y(1gYeC64J(10_=^4-O#4]EL2d(NW0afceXOabU9aBFB(WXUJ38)
f_=I)73RX=X\E&Ob.D(MM0c,]f+=ZZIbHU(gf&Z+S/e;f4M8UO[c?EUB/cRQX-c0
=]V?6N3D2N&:B@K:2BXQ.1FU+^/)Uf+M@YC]<KBP/?P(b,@(M/L/IN1/.REUAa2Y
&[/^S1TN[53Ccd+gWbU,1aVW(S,;KPCN>@6cONI&_<a?0^D;L2,a@Y,/?M7LB5K(
1L7U(EedY(KgSE,9<+#NcT-LCPO70L1PCUG7-4_7H>cLAN]Wb52#9+RO5K8HaI@&
FH=.(L#[e,g#V+2NWS(+f1;4>\5NTYZYWP<.+EFZZB8:_U<SBXUZBOII8^=4/b@+
XGY).)CZIW[]E[>8=SL=eRU9Cd@?AKKdIedG_)/(H:X:2IGeT_/:45Lc2B.+c]X^
JRe^LG-TZODXI_G@O5_Tcb7_Y,<T]#d(CV1\ZXE7BZFdWEMb8?MY)^R:O_?3CdF_
OfG-2)_TT#KYbN8;-Y<_]9FJD]9OS#92a=0,P2]4(&K;84E=?EI3GA97,2GR):f:
SWON?HE;IT5+ff^Z5:V=\SXGE@dCY>/=\.4SJec/J#.F:&:,T3TF=5cB9eN=a,DW
Xe]MC:VfJYIBE.7LHU8V52a\gWNNb.>3.a)\0gbVe>B?K/HF^NV\+6P^C2@YU)MG
]7MS9\DB1Ua,V<G?F=YBA?2P6#:KTP7N8?NPQeM-2fbJ92H-9TD-+4\SW[PHFT[8
C@UK\H_Ge)_G[M[PfbEP@P>=^-07eK<D>>5IKYaRGP<[+N8][:#H2<JTHL@2d6,C
K\\7MZQ=eMXU]>R#e::=gA+02=?^_]VdS:HeZO.Pg?<,O]PXK;?4Q>R)-[^[?fU>
1@3J?U+Pf]?)\d/<2]A52E@E#cM4\cC(c^=)A<GDQ598KP6&Q+/\=OX7^/f,8KeG
;cbB<>]]=B,D0)PK7O[P&I.9)B4eHUSQLBI#(^F4J8a/;ULYY;PGX849)OEf#TFH
:8VD369V@O4VL+L+?&B/b#Z&WNM1ZeN/^2C2SSKeF\R6]Aa646degL/4#MMdfY0(
=0XYR(VUHb:LZ68LLcabO-_Xg=R/d-A&@7>:DE^\Be.>K],1SMNPg9SI98^43T;c
Z7Y[(B0^[SD_^?PM[BDbBY6]+H7\^cf#E;CK,J4BKOP-D4Q7ASZP/B=0U5@,=(e&
^-S\f-GX=_N1.e(/JD)bOZA._a-cf][=[dgXb+V&decD/V^BJPRXIBT0];4D0J/-
[-48N=]fOH<YZM)2/IR?0-BOX4a4Za8#FM80/3#FX7B39b#V6g5T]IFV^_7,#<Y2
T#8X@25T45O1YYcZ_OA_;U6KHG^bfBO.FbQGbaO.4=;7,4<b-MeO_@IEV1;b7Hce
A/5KfNBVB+aBb)D9OA_4dDTKT>Da=^)3Xf^@fH46a=dda4^W-##PE;G)3G[#>QW<
O.N\JDWAUeRIaZ1_.(1Xf-3]DU(5.?B2BXc-R/d@d[4Oc\AB^CPgT#<S9bb@GgP/
L4@ETKUBE#Q=[b<dDD+FeaeK\SYHI4AD2.4-^Y^K&MCCU90##VW9)a2JMeA.SW(O
\^;E@3ZI.WN]NJ[\C[g-VaU^[H.4QAc_[GB.+aRXI-D1L-1QTJDS5V9TAVfR()>^
C4Z#<SL<Y&+D4#N=:GX:-411KD+LaM2g:QfK7YLBD_Fd0dId>:_BYOX=4a9Y/W0a
WS0#[;@FT\eYeODd5@<72DJ9Z3T.g/^Z6;;Z_;aDVC_YdaE9:30d\4MF49RC_d(V
?1P;;0&\>9Q=\KSeb/5X.f_V]R@-UE:-==K5P,R&2ePOageX/\(d8AA0+J9>-CdC
>MHTaEQT[HKW\\2=)D=F3(UcJKgLgZ7OO,6N5_D3SN.2-cbcfaV?\--Af+a1-/Db
d,&bg5EOFA\5cXOHM1b]cY[dT7O\FT@T/B.GYZRQD_gd2QT0=GC)f(S#UF17+9-B
_GE_>VegS+9R0WGE:F^[MLPQ6Ua=JIcgEOXX#;YC1#9:#\&e>KZM8M.F2MVWR;I0
5c373a&9R3MDQMEJ+FdFFM?UUHg8L>/_&d&+eEEZ=CI2.O0GK0^(T-1RO2Y,(BWO
VQ-D\gZGE?^CN?UcSCV6:74SNcfA>VDA0&d[.T1ED;DWRF6Q0&c>Z&F(=AVfN1WS
3=Zca/Z@0g3d[d,BEV^?Hg43d9ORV&W6c=8@JTVbU66g.9GQ4;\c@DG@Fd-[cZY@
Z>N/Pd3.?<8&#R4?_cO\(:Ma/]bT9ZB<T6OSK+eaeF-][0FCY#,(d;L,]TG/>dF5
bGDV+;6P7T2dEB&I4[>Y?<NN].NSDbf^^BWBC,=B8d<E0KCZ/?QHI4N\gdO@=->7
LfPc==F79g?PB@cEXS:VMAG7?Ng-JUR>P^KE].MFL6dEF+9)]):HIRQ;W(KP-U;a
g\#e=-WP#gB5Y@+1gN&#P)5O^?d,LDFZ3GNG1fK#XG38H34Q+F/dgdE4dR[;7?DO
/@2IXKUMV]C7WF&+B9P:DX,I,B<f?[ON598?@T4&/K_S6WE#[5H>ZK-#7dR5^a7a
2e[6K-\R:T<\Pc:Tf#4<^2[S45K8BQT0#/S&W.(O;4^1P\78YgGXNU6;ZFS#Z_4Y
U6-SP,I(_4,\E_D.Sg>b@K3-PN]P2B/Qd36cZ@dO>2>cP7/P=8GdQ)Y3:A<MYe9(
#)Qc<K@NTR+L)HVe4-bC#&CDS&6aAR=Z:\f6;a-9K=)@:J2\-.8#&SYE:J,<BV3H
J87)#0T4?VZe_)0(gH_612ccCTHF:HE3N^DfgOM-X0L3?Df7MS^\>d]XdgL84BCH
&9c8FaKd?Ea?27;aE/TQZ]GJ-JX3-3.(,TR0T2TbV[ObH]:&OJXEPC@]9G]G1;T&
Q66@J-b/V5N2D>(_,PgEAI5KN#F^XI,_5gU+AUN:Q#?VT;ESLVF<^=#XROTUH^Eg
1;,@)AQ1\O[6dU6A1b3-C&-bL(_+U08LEgO0e[ag/)Ig)()C).Y-7-4QO;OPSR/F
9/9\Q^bX<,JY2^^L)@PeO&-O1^D:&Z.W=26S#9Z^)gf+.3fJcG&ef6@FTJU)-B[B
e#6<OB4.@&Ea7_0@C(-dYVS)C2g\8VK=M@+?^#We@DF+U]DUS)2=]BBeQMf4DSHY
9^DD4N/5/I:KRdM^^gROZ.43/J[5V7V;P/8I__X41]HZVR]:Ec:YWCEZSf>@1<T,
_]e#@fN,Sb408R?4[CW)-28d[5&U&f\M4GDR8AH&.?cdaZZVD.=U]^PRD&9&+FB:
H-@P-@&?..[A5O:U)A=:^62G@e8bKY?8\Waa+QUa63FfY9S-R;e3d4#KGK2aL/e+
2e#CK;)[>[?RIc+ZJ&>N6T]EB-0c_/=@1O9^THG6:.^)0\[:^TW)cSST]W/AZQ\E
EL>/R</)M-?BC.H<MF)[V-O<9_=fFP]4#=C8gZGYgVbJ;2M<(C126-GW\F&HVd(+
2Qg,T^6]@FCQY,<Ia:M_Fe53eH=E+A3YC>4_L1_91.f_B;1G20FX_=&):.dT]Pg[
6+f7D,G@+RQBIR_KBCV.\+\;Qb_8&/J-#Hf\.M<3Y;Y43LH7?T,(B=e,<@V(e62S
8gf<FP?LG=?41:BMH00c5-6\6aAN&V:8TG-[8MQBYCeFLSP8VgcNe@7RU^VHC-Sa
b<g@FT&bU:UC9&OP[PO<RdMX6Ed1/7acY+)SHP30e_ged.R<Cb;gg^gH;ba=AC5H
bEPa>AgYYWV4:.?^NRPAOS-KL8E7#1I;WgZc8T-TYa,5Ig3FJNG_PI^ADX;;@6@.
:RESKIVHQg]WcX(+&>M6eW&:P=[a+[)U9aOR&c[_c3N4+R2:[Q6efV6\Y5EH09WJ
.O^0Xd;Ha<=T3/fK1/6@OQeG^SXcaUYJ#O)?U]9ZdTPM28)7UUe-6c0;.Y.gP2YY
8(E(:(a#5d9+-Cg2gZ.7P7+?:\[E7A]-ZaFb#(<ER+dK(L^ZO[gHTaHKNLABZ]C#
_BUR90a91TS4J]B#M3a,.^A0cH-IDUKRe^6f,_.eMf-DGU?Z_6LBIWXdSHe^@cc9
e^HWA<?BbBV3),4UXB5YB_<IPBfeXYEc#32<V5d7TUc+Ie@;Tf^09#L]0ab)YA)O
..YVZJ<(6.?8SYd7b6E@.(aUb-66(f]N=)T<3/O)34[K.NERI(GfeZ[&46&R>TW5
gaLMbX5@=4SGZAW239Y2=OI3-HeU/MUK-[8.]?3);5R.S\e<4KXB<?3IRNF&KO.U
2/X_cD\ZM9?T,C@daXHMZV6[+ZbVdbe(Z&F/JSRcSO\6#/#dV1Ca90?[Z0,f&.M]
M+V&Q_MPKSg>Y.7]aHG7PCH;;.Q<a]8:Q@=^Rcf36&-T3M+]4(\<;F?+cg[7OQSQ
e:b:8?K58TNg1VWc]N\ZR2FOG=e\FT&33LZFWN2WD3d^3O44)b48eZ]I5;I6(E#Q
L>g,<B99U-)eNX;ICA@VSM?6E7O<<Pg:aa,1G^;]U35@95H:/GYD#M4VO\U8&GWK
L/>>XB.F+DB5CEdU+:6NWB+B,CI8XBV3.XCSd1+[4E9/:bGGDaR0]Ocf?D5Pc0BP
:@QZ>0\SK8TKZJ+=[1^,>W<eJF^\fNM&OdeBEfF#J<b^-F@9>,UBW4=06Va]e)AX
5:K]Q8F:G(,C&H#,]2<6(PQK.AS&+dMTH6e-K[>74)/A\>IZc@ePQ/:6<c//g2&#
85\-ZA96-5K7^4(b5,@R=a:F25EP6PZ;?g.WA&_T[W]dg0g-6T?N;FX?f-=D45,,
aBM)SN7:Z\FW/R)DS^UT[SQAG@GA,:.D3\4ae??_0Uc?f\NGC(?2e3DBXA<\DRX#
QdJQ1.&I7WH+?dPC#d9A8S)?\F>bC_]&9GOa2-8#^P>R443K]?,&HAbUWD:9H3KS
/g7JD>YE9ZI5dE5T^G<=G8DY&K7G+f#bZ89Q3LH<e@T:?DGQHd4E,+UeA/Y#^Id.
GNH=bXbceVB)P>Ug7IY+0L:]]f3bF^/:RdB3GN//WdL\-56f-S242PG8Vc^,6e6[
2A0==.I_[K1J9>Z,Q9c.--4dU;?[?GLD;Z3;>P9;WBHbK32)W4dC=[F./Ed7bA+c
]4He2U?V<8DbVZ7-8a@a@&;RJFKWV;+WNX^)8[7R0@]E(G^Z4,GaA;&=B,V]DEgS
M43N/I8Le30CLL>DJWe/OPcPN@T/_YVJR^93/.X/9&333a_Q?_bNY=1fR]1?M+L3
I^Qa>4(B,0@3g+92S)45Y8fU0R>HUfHEQW)\HRcG\DEGZQWSQFY6#B#&Yf29dAM1
:a6f_^;b-2?fL.DDCSSX-)F^@Qca81S,YENR;N(/]#:Y(PcZZf\]OV[:L8[/GJ=[
5_9g)OZL/C(^IeYO#g,1K=cc?N\,9ARHI^06CB>9d,>^@8d]QB:g]P;dJfS9;W&X
K^7KOQ@TD3_+dfcP<IG1W&e:#8E+;Q0XBb+/UDAe20HXgG2:&R:0^A66FI(3f@eJ
=g->UD#(0-g4OW._SX[B#9EJE7T/&5ZCgA@6@#C;N^^R.RLMQI_^OaFM3>UC]FTW
DO=;PXPTLEQ]_2(Z=?(2fDEcU9O\RM.Kc>\+E6VY64IL?<BQ,CJN<T2\7YGD6JXU
(W7(Y\,0D-GLALaga&UZ(.cRT41T7LeD4V8^<,4&TdIHb2BQF8ef61<G\;3XTX0?
ZZM7.W:9D/B<C)QU^)c>9[&,3(?W9&g8)HFc(+Y@RaO2e;.K_C._=ZU[JC;UU;LJ
5T]KM:aU0CS,\F#2D,9@Zg87GZ<SA??f/,=A4^]1E-@_<2:;#/1YNW/)FZ0HSWdX
?1(f+cOFK?.O[Q.-TZ(?S&2)c>C0=9TV##3SH12fITAC+@,4\0&H7J#-=bBNB3H?
f=,cg>:Y#ED@3I+,@H+F1#[/.4a)COTOS)&.=3f]cQ^X/H:HQ8V7>#U,S4QGJbb8
6:9EX9X97T,]_B#&VE?(ZI83_&)OdY<WLQb>]e8(Gdg44->^Ofd?d@\9A2\\YQ,7
/&@[Z2#UQWKQS@1(IK<_8_REBK)\B)>4\Q;7B@^Zc+Q1/f@/H@NV.^];2>bf98e:
1#6WXDEO[VOTXP#3&,\5[TT]gK<1Je@,?JdEK:+@7Fg]Sa\dTAJ+^I,YG7)1E5Y@
AWQK#YVJ=L])f;YgO)>XBZ]WRIQMYf;@&Y.(NcXP?\9]CU.FE[4Y)GgP>cG/LOWJ
<7IX;-RKTYMOT(WSN\QMS?9I,7e,S-dZKg,1=#-_@#I1:-]P[GR(2NMdSeF@H2Ie
/.-,LY@4,V+TY<<f0G?K\]6-W09Qe=BA]PXWa(N>^9O@+I7X\He=g-g:QOC/,)g7
6CZ(5H\<8@YFJRe-(VWWK5IM]JN9/Eb/?-cEF6XIH4DQ8/4U)2U[OMIY>;5gJT\M
DDdC=YJ>O&MaGdCC@TF=D7^8Vg1(fbXf(CaERI(D)9gW;6^]g3&ANJbNabLF9AcT
LVJ(.GAFFa3)F_4VK=-d:bcRDa#ZHESOcR)1VXbAQ_e9)41K3Z#232Y^eDd]07^L
aD8E,afgC;&+(9GDEZQWe+>AZa@d1X&OPM[1I(5BY\V)YU>=AbV&[&d]:B[=<:bb
/ZTOBG6^8XVZdL.6G:B9N-JC@)2+DL0[RF9OB@(-HEX_[?-<+<LM5-;/2KMe33a/
I8=XbY>HQ.6/<gT@GO:6ZAe7PFR]HX7W;AY.).V8F?(4;G7NF^bB\Y?Z9//_7f==
-/Ye?,Y=b@aCP1-c-+C\)VX/6I.N1LB&&^N->@WV3L/,F<S8RV:F3Pe&_dd\DPO:
Jc,RAXKP3WIEag&Y9(/CcGBZ/D_;OTC]OT=\\f,H?P1UE37H7WTg5C5HAY4_(?0#
d1)OF1+SH?a<M^9-P[^9g4UN9C&S^?-K[?L74BdYDc8@TM_&F9^@ENU?EB0/_.6G
>@+&UV#bILA^aZ/AKT)DW1A;a,N&&GZ9S?BB#N)WEJf5K6L2aTcV6_(HH1DP;@59
bH>9YBK6c+VbTNH,bQ9Q+a?_UA[R(@8K<<ObJZS/cR?(NFTO:)_d550[6a@YJPMR
QDN[-c>G1\>@R6=Be;21MY3[,YZ3][fB62)eIAW2=H2#ec0e.QS]aG6f;VG#Agf7
EP3P@G0/MR:OC6+X4&MgebT>,S3]L.cG#4(WJQf92VDC>:;C&1Q.dT-OXK7EP-04
g@E7]KLO4/27UWER70cE=XLH/T;TLe=ZZ\;:e[=]0d63N,DBG3+>:F/8A:K764LK
3U9.X3,^X+,VFL/OT#+G4KC.[D^bd2H]9(ZA1fX4L4C-;;,-FcP7)-2:ER1.RZ)g
\C5/LMQD8ZW#=,:a&,5ZOCEETCC2M\_A79a^89C\>G.(-G?1NSe)c?\7HM3VRN,#
:8)\@7?Ie52?;c:9(P&:M9@>,.?:\b+XDFFPcY8F:(>L8QLGe:BC/5HcP)T<-5aO
9Y&4HY,+bYR<AZc\?N>N.TX5JS78KRJbTMf;Q=0I<[GKdXJ6AR,2@WPZ(1g6)9;R
M;PE[X9Z68R;HQ(dFeWP5IRKWJT)Ia^JAX)-_WB5/:CFe;2SYa)WIOJ9O4[?H(8,
V>OHe_D34#+aQeGQaF>/OFP8<RgPPPU&?OH-46^3X(A?.fF93g(VF9e?bLJ5(4KH
(Y<\\9>J_TR1bVbg<b;I\-F)a2FeK/:)JBYVK&VRDVZIb-;fdK9;@?_W#<eHHF\0
>cQdJF9F\9V/QX\_=:=.0_LV-YIZ0FX2>:Y)]6=FAXb/fa#<R_e;:/Uf,Sf[3?Y4
8(;NJPH<K@eV]_Q>6/-[(CE@GL@<IMb?1=5gMM2dAMZ80Y<AT_>fg^(-P/KU@21]
CY^GD)(OGg7O[F.HBGGG/H=CNFF;N>E+.0KE<9<+8bc(8ZJb[XgPEU^(1Ig]J)3[
:AX1RPQVb;C+SAC^/)\E&f92P^Z3J(dBdDHb5D-\0M#d\G:\4[]:G>NT_3E1I)T5
E6^2/OUI,^U-(/f-\A6>\,0F;9g<(2CN]76dWL)/09^XQ8F<.<GE/GWCUgRYXHDe
=dQF03XG7gS;dWVaDT=6PfQM<_:;.R=BT&c-/2_:BL7(>Y#cP05C73Bd]a-NbIUW
5)36X1aKaQbM,c)R28Z&T3Rg/1_>W2KMUO]aEUdbA2eFSQM]Z2556+\VPgHN7>2b
T@,DHRb1YM#afD)1IQ<?G=M[f0;?..V,ZD&;A;N-A>]UNH.X[\L=bQZ?WFaUAIY<
&_WM+PZ<NeU)\Z?\[6(GH1DL)Q2:&0F<Z_+Ag1=S/Gf(KS/#:/<VW4-e.43eH<(/
#MC,f1E(E4E12WVaG3ZaWQTbDg0/^A#9I5OV#d7L^TFeZ1c_IJH,[=.&Ef.D[V-F
>Q5UD@ZN.MV3.^Y#^gAHG^KN\VGRW.F#0PE;7=L+ZJ+J4dWQ?aX6/HgLK?R&(,DR
6a8O1DWI>T=Ga?6K0Ub#4QXA2S0-Z&.3W;-9fUQ5Q4gb3#[_[&EB0#X&UAeJ]C0B
K7g4[K_Cg4F4)K](F8UTCPG@a/[:g))g&.(M[8Q0E)P>QIQ[</2dA:V;RC@_4(GW
]\07M4d,S3>I04UfJ9GR6MMF[@)#(ZY9-9G5,becFEB=aIdKN=&I/-D[R9Oe9J;Z
C2X<::NQ#D05N1_D<8?P0C[7f3XR3L/AAcZa@\d]g0Q:g43beVa)>LR)0B#MHQX&
eHV6U92bfG15:=^GFW^HV_HRMN>UEbZ-b(g_U?238Y9Oe6P4Rb,D\6UO&03]R_4X
7(ILL(EU4&RQKdHO7C/7W,Q&CM;T3cbJ)51S_G/N(>gIWNf6-SJc7Ed3@aL[cVMV
5JD9:M:a7Y?/+\g+Ec#,afE&.X//CU-R&:gE;UTUOd0FN3@=\E<aY;L-IR#e;0BM
aLK;YL\S2,-d&TJQB#25Wa:7=\gNI]+2&LW0+N_Ob5VTAScCA]0:70N&,)TUDQ0b
PKI][d\LZ2QV&7(Te@<6)<.F:AM,8E8&3L3)3,],;^K<]QQE/NOSA?=bQ-VI(JXP
gE;MPY:)S48J/&#<?:H#7[<\?4[,Ze8fdYRW:CUKVe>MZd5WF+/NgWWYY]L)TO9A
AI3WG(ED\L_Z(:eg@4V>Na&#O4+aXUff9bKJ0+5_a/;-=g?AKY-&XZML6X9BG-,0
.Z<?E[@+/T>TU>]We/:>G(9BO,I9:5@5FbWEARg,_g=UEeLIFL[#UG(.8.E^N+/J
(T]1eRM@H>.3(Z_1D/W\#eWG;84f5c^#IQTC^5YP-eRHSW4(KEQIGHDc+HLZM(G\
Pb3[35^,+Q(dd\-#4N&^ETb2^XZIV#eML0916dddPM]V\GZ?eE]MLdQF7H6_CgeH
@I/+QYS]((bEILAN;U&.bg[ZBNBJdH)W_1>Re37)a7/L50IELRAV\JP(Q3&f?g_/
X40J@Q9&VNSKY6+BgP(GXO[Bg@NA01>O&QI.C2F?NAYI1K=)^:fQ4MWCZ>0g-U)+
gC/=]g9DP>gM_3HQN.0Z1cQKNL>Fe/;YBD2^ZGeK3^9PJ)-M;F?N;O#\L:M=1[T1
Kd0JE)0D3E[g9EDJf3^HQ-U&7Af)aZO\#+3:dRLeY4>Kg&PB1X2\:Kg<9gX(U08@
4b4DWYK,=;S:O(IM>U#BLVeNEKERb5g;Y09:J\=4aX#H27^L9)R/.JM1;[1-H3Y:
,\(bP9DeU-YJ^IX,g:(M;,)^JC,<9(E<.UE4e][\IUCJFHUB.D=e^L)^e66N;NeF
<B;2:^06&aaP&;>[LK++9&b=S]Cb#LbZ,18c>IbY_2U_B;+Pa8Q;@2(=B(aO@R;5
FSb^Yc7c=8\:@EO/6@_D0DJd2IWP4Q8=6ZOR6]ELBH=@(>\5,;J;UaA=3@;PQ].A
c_S,eT3XJBDadA_A6KZ[b&)2b#CSUCF<CKSD]#)GR\ZC??Q@PG,/@_A@<ULA]8A=
-J\NN8KC,/)>NCcQXC>L_--=Z&K[3Y_^.-fK.V#-F/_#+92>A1&S#OA@K$
`endprotected

`endif // GUARD_SVT_AXI_SYSTEM_MONITOR_TRANSACTION_XML_CALLBACK_SV

