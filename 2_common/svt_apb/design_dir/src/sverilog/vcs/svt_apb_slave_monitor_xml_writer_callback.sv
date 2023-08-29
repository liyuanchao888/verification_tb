
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_XML_WRITER_CALLBACK_UVM_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_XML_WRITER_CALLBACK_UVM_SV

// =============================================================================
/**
 * The svt_apb_slave_xml_transaction_timing class collects transaction timing information.
 */

class svt_apb_slave_xml_transaction_timing;

  string transaction_uid;

  real   start_time            = 0;
  real   end_time              = 0;

  real   transaction_started   = 0;
  real   transaction_ended     = 0;

  // -----------------------------------------------------------------------------

`protected
.2WZRC:SPPIAde8Eg_[gHeRN05CGHHd:Rd]&g_S1E#cG+^G&D+dZ0)GJZ6><F6;e
dJ[YFXA=Ea?6&cTdKKeN;^abNd\;>IX]3/CIXE2M,GA0bS+RNd,=^]E=AaA#MfN[
]@-+7(HB+RJcHAgFS2O:ZFKQC</eO^NUI&#UfL:>S2.WD;;Q;71?RNS\@8D2AF]RR$
`endprotected


endclass : svt_apb_slave_xml_transaction_timing

// =============================================================================
/**
 * The svt_apb_slave_xml_writer class provides functionality for writing an XML file that
 * contains information about the specified objects to be read by the Protocol
 * Analyzer.
 */

class svt_apb_slave_xml_writer;

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log = new( "svt_apb_slave_xml_writer", "CLASS" );
`else
  static svt_non_abstract_report_object reporter;
`endif

  string inst_name  = "";
  string file_name  = "";
  int    file       = 0;
  int    xact_count = 0;
  
  // -----------------------------------------------------------------------------

`protected
YI<DUSQA)QF0HK[\aSRf4=PXcO&9I#\XBA&.gU7A7SeMcZ2aba\M2)>P39&9H6?b
H/b=(-Y&U#93eR12J#_d>G=6.R>1Q6\RG-3OTca>0FYAKL[bHcJ=,dYPZ@)@=14(
1\V<cH<&?+cF>2C-&4M)^?5,#>KTC]+4&9f9J3dWAg^:[Y8JSg88Y><>R-:_YYV?
P)\\V[2Og;(Q#ODHAVDaNWMPV1fGJT+)2SbHQd9LCbdA?8gabN7gc1>-ZX1F6JZJ
Q+T6dD[RN/T>#A^/5UP>941_4#49YS8D?P,=ZH]-c#;GH,M<Ve]QaQ_-]\gZ8M3U
<HNL#efQ01Q=OeA,L5,K)JAK519C/+D5_HKS[[c.+)4]/;59<gM7e;9A;<Gc(09#
-SaB<9X.,a/-ZUP0eYU68BaTIVD(]8E+4_N6OIMe;XM/-\,3&a(-@NUR:AU.H_)e
ZeX;C]7Z:E&GDbgCNFU5+05./JMd022FSOGD&B4+AN7g_>R<3@?PS338IVX/8)I.
JKf@SZ/4F(1a,VX-X.EVK>5.8$
`endprotected


  // -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
E2W2OE7G9UGX..bfYFLg)@M:a8a-Y,?CYSOEKe]Z=_=LX-/e,SF-&(.PE5L4]4cY
6QS5Q-bDDS4+AG-Me/,R:-PHY:ISR3ag3Q)D0=RILB)<16RR-39NV-fYc:g:4OB+
AR1#10N=+5D3&OTKYbHOQOMD@=Xd=M2KZg3GU7UaJ\ORUW1NQ2:g0JBH1Xc8JfG,
0\e.#LQYM@+fE3@8[/RCg&\JU/g:4]#^f>(BL_3LN<c^(8VL(8=UC=FZMZL8-G2/
A0);\4Ie3MTG\c-HDEH?&?IU0SKG<?db0>4P;MGf&.Ea,#=[eM3,ZaU(^^9YBUd]
(T?^=(PY-g2\fIddDWE3.GUaL-Cf+#ecBW1QU=/EaTfL7?)F=K8D7/0ac>S/LL-c
7ZQB=006@OI?5\d+3&DZ6.cX600R>\;O(J-3gf_E0?>Y-BJY;K)77Y#,O++TP5,J
^=Q1aT4f[e6PWT+J@dPYL:J\4a,:T8-=F,JY+38UT,5>Y-eaY,HcHKd+LO[];9O,
Ve>VbX3aG=6\:##UO;U1B(;C>;,OT=?ON+N0Cb=?Qc>f=B.F+[8@8JXNA<fX_cNd
#9#c65&>AKF/3PQ<Y2WU90bCd5ODVEM&GB@>XJ>A)@.4=+C2>Z^,82JH-KC(4QPZ
IKU;9J=LZO:/Y9=W_Kb_(&JP1Oa8@7eD8)MPZ^>5Id).:e#G?:eW5/DcG92deaa8
Z4e<C#AA-F@fGFY)V0]W1(aHgB@6T,6KKK,TQKMPB5I.TP.^DUJd9g<P_8DPBP#X
^Ee/aG:9<W#Xd0N1.H;;LbZ:_WK)UOSgc(Y9HeJ8UG^MLF+()B&IUJND&KfF18@W
A?-FI<+BO3R#Qf1=HR^6eWeJ)C2/^Ve#5]-#0[H@M_(&L4fH_/Bb]2>\6WV.H?3L
cBI:XCQ@Ua,I,N1QgFBN2;[[P3<M4H_Pda#Cf^eWD-c=,4S52G:+K>^FfH6BT?L5
/?;<]DUe6M\@5FD]IbA+-PUK429fCV,YY0.6D4H_[(WLGfcD<;8\;De_F)3_c;[G
c]3.9#H^]QV6U.X&N_BRF7J3Z7X-UfeO/A:B_-<eJW[&:\^1a2VEJIR-W0g)cHCT
V15:HYbdD/ac@-,XCTN=0F+G=I7H0-[.#4_=@fe1Pe\Jbd1\.LD2Ub6COEM4V(>.
))-f#2.ac7U?\a1f=?EU&S1D)>HSXQ[-&aS(]>&C#J907CX822a7H0Pg>)P9&0YU
B@agQ(Q;&RWa=21133A750J[AfQ/_>5P06R^,OWEJb77??(>;;O+SF8+M(X2>P60
TOU>X-Q3T\YF0Xf8/B<3b)[Ae7g>Ncc;YYT1f-S):]1)K7A:bAL-RYEG4\Je^6VS
7_79Yg,Q-22fVGREERb[(^F4Y&-@4;)8I@PSTBfJI2?M&P&g=cJBT=e08<CF./<6
4gG7N?]G)CTB9:TI0]#HYgOD[@]=TdW??JZPHLad/=XBKVb_:=D.2RRG=[\dN7_;
0>>8K.R7;6>2e(a289ZC&_N4@MVTJ,N1a6&R>7L=HPSS5,ZUHDX>]SJ,1NI5Xe/_
A1&Va:Nga?1621/#P7KE:g.G)JUDGG;6(.:VKcRE1H7JR0IZPJCA(1G3JO-I?TEe
g27AaL(RZK-1aAP#:a/\\6;]@XMQVdE8Z5A:>?E9gPW]>c=bbQG>.7A]U0<6@AaC
#(HB],?Jb\3/_W_5eVK5g;g[J+HPWS@efgPaRNX2N/?D-8G#g0(gN@ddQ:P[bC.#
KfE?B/-\@)dSE2A9^-:fXMW#ZeG9;X]WCA[B)L9:>^SXT<B1,8dM(J6>U,FPCXac
A/(:X#W71RY7P-PFX94X@;U9RWVfA\B[Ib;e?D5CC0dUNeXLLaMUUHLNC-Z;A2:/
RP2T+,C8LC[.cGS&H.c:CNe>:4EN\4\CW5XA:/8]MJ3?&Xb?#9=3Q3K&(MP1QY:;
PUX#A0O=77,VX-O3dG8]U9e&2<SR;?;CZDUV?Z4T/;8fD-#UFIH2^P=C4ZO>USZ[
IU>A@F4-I\G^QD54B]R):BHR\;H=c3_<\00#EC6;9I\#<CaC7-6,PQW=_b[F@4=&
>N1;HN0,_>W[5Vg(7eW9]^>,:=E]3?J^GBBNE[OcA=QM1+4FGOF+\3LP>5fS;;2b
&PQIXeDOd?>Y)5eUJ;1?-+349D#<]Y6TDU0,[&gJ55<:H,Ye1::]^306c:fc.^,J
)/7YYIdf:g36MXAVB6UTc9D^g?5/^9#3\ddBbQB-/J9Y+R6^XOU#<RK6-E=HgK75
X7P+\]Z,?);#-E@?cf9+B9-M5TSS_XU\F@g)XP6=+ZG]eDO)X,2cf1TQXI\(#LM[
eW)@;>O(U_J4/EV>.e[ID;?@U,A?7_A5+;63P2<^>#)R69A1_\B#feDT8SWa.P<9
WF_ESfE#&_X[3De::K\0Z)WX]4V<LdP0PdJ/Bd?;A):f(84FG5bUb.:R;EedK_FD
N_5gd;(H;e32>KJ2UcB?-.LO>.)87S?gT1R2e\K6TaT:I?FVP(;I?5OS7T#IG7;C
b#+LSf_/++c/6FD=CI[,0[b#X_;2#LPcLXOYY^N204R:?J;GRZV>YU9.],)Va@-L
Id10/#?eO^>:10gVYLTCbB,\J8(2HN6\D_G#):TcDff.W4,Mae8>QR>90gK@LR-W
&fV;1ATXNb<6:\&[Y3F(EG61&B5N.L=U3M7P9;<^)YD^STHA;<ZJ:MEBM90G9SCd
[ga/SS+GW>#4:W15Q(UQ;XeJIBA2(38\E=\<gG--\:-&ORcgC:Vg;L3?V(CFFg.)
CN0),:,O9#DT80RWY4&gG-/51=3b&:B5gf0R3b[A).Y2A?=PO?9.H54,(76_27/U
YVZC(ZI0\J8M5<T24#7FeXZ,a,<QEQVB)T)P4IX0Y-.Qb6^M=_3HZ7c8+7D.40RJ
6ORSHZN2;G9d<P\]#I1BE/8\D9\.G@]R,9&d29c)2>(CG0<OcB2IWcY(V+>e+aBA
Dc>6-Z?WFZZI1?LU5]8?dD5Yb^=>-YOISC,OD;CV(,^X7_R_:)cEQJTBF[@X\Hd)
48F29KJN-Y-QL#58UA8+TZ9OM)EX>CaJ?3&/[QZ_=5T<16G[EZXT<IX<_O6FWH6M
MeQC1-:-S-RM7c.BU4VFa@1LfMb>?U<39=M)[VWfE)>dTY+=QTVD69TX0?D3/NZ^
T(KWIYE4VfZS4GUbPM@AFP]D,\a1c1YJTQU4ET7Ue)d<^eZd&V+VQgNd+b&TF30G
D2.;>;_F574<+KX?ZZZM3Y+J@&Q5fM[79I)Q7TgV]f]#,L+[XP8([WD7\#VcCQD@
+^/.6WI)6dBIUNTB&#a.G^0PAHA/7^0Z[0^^F\+e1VP(FPT;RU9#g2J5\82TEAV#
)_YXc?/g_N_HPX7Z1C1=W\M5RRUM:?D->^),dNce;M2[O.b+4\Z_?7,&geV]_OU:
&H#/e@b[;a]e-S;ebXYBAO2_@+AWR:&eKLcHQ/Y5W9IFd\.JSR^<Y..#H+<8[Tg=
E.404](CP)4OO;,G39gc?LD9,7N=IP1-X.>YI/55Z.XdAK)A4O[bF?^1E8[E#X<E
8J=&=>)RbA:9[>9<[9+^Y@cQeCdYQEc4::3/YLK]9:Db/S?Q@;+b-d97XHH./VG0
_F<bY+G42(,5RA\7TLdC]4,@@#,>+67-3[#4T+_dU&bd&(f)+KF;+P=cRgGG4H:N
JLSfB+SORe&_(K]fMg.2J+E=IQF64?3Xe=POST5[LL9F<>(F?,4E<6:[c&610GB4
]J+R4bdP_4Y0Q4K93W@1KS14DR;NIF8D@O9Q4+F5Ab4.fgRZ=ZQ?1^#QO]A6[Y-G
[,?IgEb-,+eOaK/;./V^EA1:OY-F-8).YcKc:cA)Y-cVK(X?(c;IX@\f@W:6)&>B
ecSX[GF1<5&.V#=PG9)>LNZeUW+]GX/F<H1g,,&?&3(QXRPE8cUL8INP7<)Q/A=R
2-E1&2YFH@aFg)+\.N(?Ua>0848>gR>NCU5HX4NP9cbM^X/7T0#V.ISCFe1T.aAd
;QdTT>AR-b&]RMP,\W#[-3PLN@e-?,-Rf98[g[a1QHV4ag3\T9J]ccN?5^E+;STG
(2E.RSB^Oa@I^+HWD:6AY8XcL--^77H2&Id_+^D@Y_5.;WH^2YD6HHFZG5@HSAO)
1^P2.OBO1,O@=aZ1,bX=/Xb)WbKf2fG<.=B(d67+Y?B22b9C(fI<T@J1N\Z2G?S#
NX6aW7A(:XIc[<AB6/]#HC&4TSEWDFL2Y2+[FU9b5ZgDL@B,3X75@#)1H/0fR>-=
LZ0TL?.-&7ML9SE7QQI1eg@=HZ+ZN5/H\<&M?Y-W=7e#.T[L&MCNGO.J:&dE6AGf
N>(F=RL6QE,9d@7][5Y#6Y7]fK[+Y9VJ)Q@[3J&cD6DZc23]V?/]e8+<ccGF1FK8
b:J^;WCD=DATWSAZAM>^_fERI:@1FHYF9FD7T@7_6[W;N;@/1a<2NZc41Eg7:<S[
5#2C)\4g8Jdf/>gEV^TX&MSYX),M<;K7FNI)JKASL5L9T[):>AU?Y7_764;;]Bb)
>53EN<gBCLY?Q.52d):JG:LX\]]T60.FdJ.fAcYT(-9,VdOHT,+ZBO[KL6e0cUOK
N9K_./LDgBgML=(\0f7JH5b.g#gE/HY6I\T[M>Md_<23VbC4B,J@dYV<BQAdLR,+
9aL#2-#KESF2H;T_(4E=-aAHUe3EBf/\9POg./LBbU6:N\DX1dH-+0NF2fED#&3D
/2-_4HH?OF<T?WAgZ3SO+PYaH_=IFVeBO(M0D[0;[/GN4MC0cPKfS#:D<(+TafG9
H9F/D3VfPFa]b=7&=^Afe6&bR\J/:8<:SWDe.cSU+PJU.>A^<&YBgPH]#gA5:BK:
SYZK[C574dBZQb[HYD.6.JP-eKH^4-[#MORLOLTg;=B(KU3F#-FB+Q[<AV.:e_X6
-//^B2W2YZE]1)-_8M#8VU#9)=ICLa/0O1bW98JC[[C21_45Pe^GP]_a6O<(Ldb;
bR;UF-MYE^/LUG9_,Y&Z7MO238MA77;f@-]@AR32&2;)G\[JY(?[Z1B+H/Q5:2[_
>J2gb6THSMG7[a0WPZ5E^@0RS:E/,<I;/.@L<g5N,gMRfZ-ZUK&Q+28K;JLA[B5#
D35]>dQWTbbe@R;L^0(F4=FGVE)Idg[c3+;0R2X5U<Z]2Q>VLHIX#Zd]63#3K&@S
G=O-+?a4dN3HP5)Z1#A\g7>L[(SNW92dcaKC;3:Q-2N;=C:#D?WI,G5/2OI7f^R_
LS7IX7dFc[\8^#P[dVAMS#DWA3D8:MQ;9W04R7Gb+@:M#Wee_RNNfU6.dO6dPILJ
>YA_)E<J=_cRAcMcF;[U;eR3WHC:8\HH0=N/83/]bXPd988?#aGQ&T)7/bDPRG>:
WIV2/_\O^SO3R6=W^N+>C(YNLL]2U_::MIP0P]1#3;_I-]&^a9C3#K<LdE7YKU59
;C?H>a5fV=eOb[E4)RDI[EIK;QF9^@(>d23Gg2OYU_)&&[EI+8^.<DZ\S>T80J?]
JGXFKV8C#S9NQ[gUC>3:WPeJbW?f;?Xb_2K-M0;<.SJUE2d?1bV2R1=P;W[B=[D?
R.C3DQC/8OS/ERXWY20/g^<@JgK5KOZ_OZU+/O+U9XU[Q\TAaTVV4\\KT;=d\[=@
:0/c\b^>=QR\^-Ta=F]=C<M4Q),0@]0FMDUA/:G&T7&O5ONSUR[>,AD7+g^cbBN#
TP_P\E)V(-J..#V-Z(a[#eC[Fd,<,.EKH#c?1Za=(2)FC-RO2B8<=,M<=^fd7D.3
S&Q1Q2&065VLGBJCLM484bIN1F)>F\ZHANO5C\Xa/H]C+e)FAO&-;I&>dW]YYJ&7
\TP)HW/SFZ2-Ga7ZA6f_U@JL;.]gOH4:S3RZLQKb@Pb?=RD:JdZL<(T\-,S7YJM1
aJC;N4OK;6KZaD0ac6bc+6A4WO7VC)cc5VWFc7-Y[4AaGV)UPAXVFCMb)IB]T>)6
B:EWY>/E/__W=](d,;YSAGNT1XYdDH)1MXd&N-KDZ;f>V+,(N</&Tb6(a#_aA[ag
5^Z@8/<2N1)G(N_ceW_:VT5X08a,MUWb5NY9B4A0Db6f#17Re(C1=3YX\^^8?&Na
;cS&IO:[D:e-P/X0d@Tb_P42=]ILSPA<N@POQI//THe>HAAc=;Z8Z5S1EaX?&9X8
UC9SNU,f;IPafBE\#QM^S6=J?gYD+Z_:.;KXS#ZL=[_QA^)^_NG5VZd,:=M8YX]G
-fXdgI5W__)gQ]U/B]5K:g4>e;-=CL2fT.ILJdTRGRAGM2[TIcJ8XK#2_ER6RHWN
Ub,<Lb.e0Q[M_.S)M(IX.GFKRd0P=844dAL<F.2R7,S(1VD[4_O=ScK@Q6=>B-LP
)G[d>b:e0SL6,>46e#+7C8#c6ZMLE8:WI)VE41Y//FT3]?\V&(M-IS22:#8OJF8/
4SG2?N79V.-/2(5;(3]^/JCMLT2V>E/9E8?(Zd#?>=Ycc1(#-b50G;-cg/:D8GG7
.C8<X)P60,S)&0=,I_R]DIA2L,_+Ha\-G9^e65&cgF7BW5d4/G0L<fA8(Q\B2[.R
5LH+=\H^@:I8RTJ^K_0&3aYaeE[aa.cBE,GagI-@&-4EM&<f[\Gg3)f+g5=e2O^[
g_MfKUBWd:c(R+C9LbR><e&I+QGR<X5L@;YFX]QEd8&ZPTD&0L@fRa4><DB_LfgG
=e3[b.eT2YeJ(f6^\(;7O>X:U[SJb2MaE.9#a6+.CA_U>b#0(\+^=F;4=.]X>QaG
T>1?D7V^7<PIg7Dg7F(g,1g#O[f&)#ZL;BSG;;FT-cA06TVTTDG_FQbFb-cOgB3_
M=AU<<U+[9ZI[;J-bd_cLC+0,+cT@>-SA_U2,ST.22cU_L,)#GN-FSfA(1:UEKW[
McX=[Uf&]>VJ]</^D3dO3CS:E6PdZW^K-.F36[#HR7ef,bG1105+UW.V=4^?UgOV
9KV&<f58_@(.?VDf]O#@dM17--d#g:L0J9DY5_E5a-H_,E73dOU<ccS=<=JA,#Ca
:f>A5FEeC3I4J7SJW10\2e7@ZdZ1+QbORU,84)d)eP&<=YBD+.C_UXTIB_-LP&7\
T+@@9cVLgJ9-,@&SV,5c-]<@8<_[-7#XD,E31)2AKRB;3:VWU)OW)V>L7.g2H50J
.J:N?KM_4D57]EGAGI_9DeeW8F1LOR]4MZ?\+Cc6&CJA=W1P1\>^fU1QZa5I<^>[
AO9d2bfCTZ&M7;LBV?Hg43dVcW:18VALH&Zg1R#06F3/YbT65V_Y^RQ.FP>5J&)3
UL&V<eX\BSCZTAY#S)_>RANY1,9ZTG:+-/4]\f.]eK^6<EE@U^)aSIRW_A>N:Y7L
F9=GM3(#0<9T<Z,46,6K]N_8F4X.dSf_FXUB(F-9]E\ANcB;/8PM3[e5][2A)=4T
L#.JX+Z9?@2FP<5Md=Fb<8T2P5FA&<)4R<&RN5LW:OD3<bQ>L;\0YRe8\I89(0W4
;E>,SU?@[]/5VWc5PMH&/<1E0/>8Ac:b=;8MVFdc,F;A8N.VT0W_K9JV03LeLA88
d;c?,cEKgUP+bN\B[NJ5Q4??a8X-AR[5/^6O<egMNdMIGJeZIT/;)3..&-JSTfY:
=6R9/1/&c6K&+@YO06&47GXOBb13+cXeA?+6)9F>[?PG,H&bE+R3HVGGC/b+F]Lg
g20)>4/Y0?V^#LQGBKIUdd#T/V4,N#1UY6/-+e^]Y-/ZUM\^&0/<dQH:Of=NAZ\)
V/&+]_QbO:+GMKHfO6.?-2P?)0e&L3fF_gKI#eG_N-.a,GBX>9a7@/,1L2VA?DO3
4@GB](bY9g3Fg&d;,;5=eKB;A>f0P=4=c?XJ7CX2&7FCeFH+DL#ZV64fO.9^MTM(
CBRUF=@gA:-Nc:QPcJJR11eKA+U)B-T=K[[GZ4VYLIA)34\BML,L(8^C-YX.5VY\
a;DZL15WP:Q-ME+b+(8X(O<fK\Pg2R?-NBFYQQ<gQ#eaK<>acZEGc7<+e]S+R@\9
+aUOBJ\Va91YMM3d_VD?K96EdS#1_]Z3@fF[bC91/L_??1]Leb#8I-#-BACc=cUb
-4N+RKC@\4L=ac(:d\(=@daF(B[cR?DB<PCIXd/]>eNVcgbC@G+c&UcH7#?0@3G6
1?HKTOCY?B7RY8^U8JYT&1^R\LB+RM7#I750L2Q8)fQ1V+9cd_46bX6+9P:+USdY
cF)MUC\E0F@=gC;BEIZ2@_#ebXU3O@A@b><TCc9G?^IJ,?WDHf[<TVJa-G<)9]6(
PgQ0K1LEa<,)fA\V19dL&a]d31XTT2T,7CG:N5CN+\@/Mg1Y.eF56KF@bFZ]KN+f
)SaW&J4?37Hb8C>d@W0>X<5ZJIOD/J:5O:PbNHd&=H6F5QJSPV@)4<N7;bLa^LUN
4b4U\:HG@00R7Z;K_BM&_7SefS]X.+DJ7:B^GZKDMX0Q:@V,N;S&7>>/7E[HW6B<
K#^?R8;+AcU;;E\5ZA=3H.J&)J/&4;<QINE&)f7JgM5Ob;D0)7+3QD\\=_U@.__U
eMS0fTBCF7-<=M72K-T1(>N4#:160JPAae2XH)R6b33<I_<PI0X7eQ^AV_Ud<<9:
Q(ZA(>5a=R[H8@QW.=OXeC/>63N,[5WZ=+afF;4GN^+@^Vb@79G<<@ON@cBI\&^#
,J1K-G@9F_)AZ7U#d?eeUK;528D;)^,_11HX4^b/8Jc7T9)^H+fXL1M0KE#e2F)6
?LG..H31Q+YK;8,eQ70]QYY&#3VT:5T&dGD-\BE88]FDLZf69[W,^#XWB8C[Q23/
H3_YL(-F^M=(<L<[0@4R2Z9]]2O2)e3b>N?83RK)^UUeVC]@d3b?^0P2aA//K;L)
]e4U8U9C_,OK(-VA>;GK,_[7HaXRUFY.C7Pf;d732K,&fbcP[c-?WgKH]Se:I;e\
44UC<XYLAVI)NB+1D</D[dCf42+YN/cFgH[GO2gT:&):(HcIQV#)EEIbMSd>/O6D
)6G9N:]e8@P1J(M<+,+X9A\+F^\gM_B8P2(NJP-K?Z75K5N8A66g,f>;Fa2C>[5T
?7f4/Q^ZbT@FUIZY6Q_0#:PU,,65LY[Z)9DKI:a+e4.07-R3Ma6K=J2DXgFEM<G^
eTH^<U=9Gda=@J-dfe/>B86_?RJN@^)F?,<HE[+_K]W4R>#L3TSEV]BT1SJCaVLW
=SZ>?/R9SWVe2NT,=f9e#HLP(C[OJd):JYSIcd\O\GKP,3JB\N3ESQNT&8X)SOU0
S;QB:aLW@d=I:dO?8&\,9EYAK@SP##4CLfRQ/=1THXQ:.@e,.&0_,8S69-;3,@HC
H:AQR8Kffa_>>f@#JA0^F37@G;LR<73-UR:XNH_DCOcNe]WHW5f5@,NdE3/cMb8<
[)1R]C(O3MLQRMC\MeX7<Z#5HX^5DJOXPKIDC.FK7.L.Ica+Y=G1[Na4F;MTI)L,
@F?1YWMMY]0;FNS<_E2Ne&^YW7\YPLKIKE@Z5XINfECbIWBVI)b1VL[1FGNW&O0f
,_[3eaH>M<6Mg<1e(6VV,Ve\TFE19d]f4G[SKDDT30(e^W7CR#5,<@bJDB7cD/AL
\NY6e&]AZ\)7^cg+=3L>H7>GQ1?A,78<[1ePCdL#\@\Z8NA0QNaL1,XDHVeeME2I
F_IVI#da0C99]fZHM]>FfXXF:f4QdfH6\9f;^bdAI(S<I&0IaWB=c\8Q,:IXWSJ>
)OBa73&5eg]H8_e/;6J&VNbgc&e->dc=>#U.g1.Ia>bRCPV-UZNZ=MA#<_BeQW5#
0+ZZ;OEDWE=^<cY=)?M3,gdfIUWZd?@MYgWaK)1ZMf4/X4X04C1?QF43?ZZ@DGWg
:)7,OPCHRPgP^JOV0;/<T;VWBGII8RVfQS;-ID:eQf]R\EU.a:DM4)65H75.Z7@(
Y-[+X[,af?G,5d3dJ3,\N[9QW/ZD2[[f8DHEH_PD>14W8-[8APCGX9KMU>M_<A+V
3B7,aF^#_ZU7a&K&LP&@dM.0YNNYXTO<.J=/-2#)ZPb+)\2#YNL(f,b2T;_3X])@
./:JHdY[9?C__<O8e]F[N&[291U)TC_>^N]fQQcf(Y0b8KMW6Me7VY5IPfLEG<LD
V3f?DW7EYC+JaLP,aPQ:9IMf+-+gWc,KQ]=<2EM>[d\X5=R?4-#a)VM5a5=?JA6)
@,&BM(cBLcQ)+/=J/DG1Ig\XfZ]6bf:QLV6ZNHbJ0DLVNSb&N1[8+^T4L4=4V(d.
8#8=KQ0\2TgE@gMJg(61/EK9b_V_2E\3AKcQG@3aSC\S87E8&#;Mcf819FH>Y0QL
&)(&6e8[8^NC1K?L^Y5BYF6YRaI\L3E;VdQ:dWOTN3/fYX=17FH5O/GOS8;1W85G
B9R6IR+MC7:K\Q1M0gF,ZG?TZ,e6PX]=M=+&G>SKgT(U7PA5bVMJ4Ab3c9C6C\,U
g^^X2=LZ0K)WI1&:_)8IG^L@TOI6Q95<4&K(G#H4-b:H^EZaDU_Y,b9,MFO#K2PY
DF_/]XJ2#Q3]#PDKB7AE36FK,#0XC2(GBc@Ggae7EC.@]V1QXP<F@U76AV(2<<Vc
6)XB-9@_1H)2IG0SS<bWJ2aQWI)a/8\9ddB_d0U6:,:&>T#3\XDLC^J[4O@2U6[9
VgZR1JQ9YH)B,S:3CW]&aJ]0dX6&M;VRQ20([VH_9-0J62)?TcU)_f3(1]/^3M-8
I;H&SS\I;RJ2C?R9b>(&GdN0Ka8KHV/aFZTBdVFB]YXW<BbIeUGP0?\E/?D\A@H/
<<OY?G5,FTIQB,2HaKJe,30\TR@J^WDeD3CVD@0M7J795Z<eF\0HB(\JE=10c\8M
),aI@W9e:&7e\g\[fU=;RPF4_@.4#aSJA<S@DWKc(WbGf+JMJ?;-RDI^UQV=_b8.
73D_(]O1?ML():=L9=]:9MbdaSAA/R3_gCW^QG^7]./1cc82(@C6U+Q25+:2<26P
7M9Xg\<&C@dYR:PNYZWS^(Hda5P=MG.UC46)HT044Gb5#aR461-G_21#=<>B9NVX
W9A6=N3_#B#:MT=f]9978E2R9_T=S;+-N7&d(]Hb3HOJ#<04V)627]FPOE0>]@;b
->^IAZ9;^=SAQ/[&>f;g^fT.bgPc]\0M45ZW4Z<E_IX@:cEX4c+KNRDSN.2RJFBQ
#;(JFNbK7D8ReLEc1++=)ZEQa?N)<D&Ge/MB;GJ\)<d83SX4;R(^1Sa-:9S5JAS(
&LbA+4&2OJBYV67(_VGX^\;X.T)S1EEP)6<=X^L9K,9L-;CNN,8/E-:#6QeaU9^4
ceK?_Pce?:;=LKQbP82L.N0?HgL/+N]5.VR8TA\,1OY:TfTdYSa=T31#SP^/S_Y5
2AC]YA-G,)@D,dZ#H-Cf@]T^\\M+-V]KR:]]6-]\g&,.38ag61MP9#R]M>\WVM+@
@e#@SSC,)e0g/)f3LF_6\-IdI#^RT57L_QK,2XO/R[)b#eDA3[-#5Z+)^.,:R17R
@R>5E;26EAF[?.C#2b7gIP-JU@&>DYNQ)3N#2eMJI>>:;A750J^VT(SQ\N]YOUgW
J_Cg-C1RI8C\NfG/=<5dK>YS8E,XV1_4EF1YKI^JAZ&(MSJ>.F39G=R=TeI^8:T^
FJWY=-dfTG(LbLOg(C8ROb_EfN@\cPSLb<748_2J#V\W#V0B[W0UC@^b[RQfD22N
dgX]ba(\E_d;F#M<PV(TA\T1R5@LO\T/ggQ?YV]&Gf[fR+H4-eN,\H^^+M85RCID
_cCG7(-#GO</3=Y98L9/gdQg70F,=T-LV[P5MI1IRb4NYLD39d)<YR49S8.1F/T4
9XDIM2S+c>CYE4:8](d0B(G^TJDeLZbCG[a]faGK-fR0UMJU^0+),49cf^TFKN_c
PK>RE?3E<:.T0_0KVW=EbW?#9X=&gTSd=4aG1XNQSg?NVadIF<bPgPJ1QJNeZgSU
4W?Xa5&KE(bNV?UD@6)D]OX/-5gGJQMgc8dfOC@DWg@RX>CQg4E-;1E/3=Y49.aB
]=@25f\U-9gY?LT9&RdSWY4X+QNSfVS1?G7@QBPFA6eK,\Fc_(A1PaSbQ@-7O]F]
c1\S9+V/^9Afa:+3B//F#=,>JSF;U0a;5aUWL>G151YB3Xf/RX^MQVc>60:M^SA@
9\.L[9NKWHLP]&LN9I;=ZO]CU:b[eA;bM0Vc,]66F,#(3Y-FC:b<#.2,<TbO:&VX
G_9D>)QDe,M5H_.3M.E_CaC=O@+D+_\Q9-.N+-.:-3LdJ3d[gL4LYI\5&75;E<-D
(HN1ZCd?\EMB3VN9DdO.[+MEA4.=\1B(IJDF9-Zec&aQYGI(NgFSB?HZ[)7a&F]/
0QEP=M1HU-T5\gLICg0-HB0T#G9]1K43(g#^\T=g[_dYXB5L8>DOT@<3B[9@U,)Z
ga0+).RPJU?]TF_)gYYTcOAE&45,&(7Z3[_g^;;W?#Y)F9LW--VUeY^T#.T48S01
7^#G]GS0(R92)+7>;18QG#?=]])O=D#URc\5>3d\8A@,]5KJ<50@R7@AM,)f<Se+
TT\:a.GM^_1R+_Z=[b.DE9KFF3e4QQZ[6?:^eYG.1/Kc7AO.)aRBX]dA.Z&P]PH)
a<HNS;9M^#c>4U\SVNfg./Q.Q^PA+7S0;BN>?U4E\6,5Kd[]2TK>MZI&[6UbN.38
P-O3EYbJ;PR?V/-JT-J/G34c9J]454I4S7UI8Q3I]OJ;4c7V]IJaQ7,>Q2M?^LN\
,MSW8OY>Sb@U7)(Bc[J(<Y^[4&QMKYC,2DN2UMM]a]TVE&NA4AF5=K.?O955FA9g
7B4FZ\SHgJ4FHYbKJgIFF?GBeHe:#U\Ic6XIPSfF2eMaU,\EIOXbad@+(GYcC((J
3&Q&4f.faUY&2FA3U]K_V5Dag4dKC?7ORad3?5[1JDL^E5,.&V]?-C335D&ca[=A
@_Z[M?Wg??H#@V#_fP7TF_+7-WKH_d)4[:FZD/=<8eC:I+-MJg<KK;))8^E4d6I2
83M@L63Sd4[DF,eGHOb9c0R6#a,WS=5,[):TCXK]L)LC_MX?TTKWF6B_);C4Y\=c
#WV)QI)PDfE0g(;0Q8c>=CY72c7NK_e?D#/GU#:[RgTgABA5X>1,=cb@A=[E^)Q&
]gGBLY1g[TdP2GD^eEg6;R.Pcac]QR[S/RG82P9b3DG-[&bZ-eP1:V_Ze/Z,L&F?
_@U]O:L:T)\EX,g.CU]HEBd&[IM?C(77=K6N@)Z.[>a[e/556&_6]a12X[<3\a8+
)DD8[:b2(P:_Z68Q[9K,8SP48[4L9BQ#Y/0,Q&bb-I66-8dgN0X&9W=L(HdRE,:/
C_dbRR<6EdA1?3<ZST^+E?;S&W-TRC8Z?&A:dU20LEA7I,-IENN660(9-#CM@8FX
eREg=Ag5c(E&^+>9cf^[e:]^WFVgYNP2_P/]eZEf(R)_T#GGNdGc47IcI^]ZK;=9
Y;VC(PdQD+9FdC,QMF9dUHc3?=Uf)+M<^P)a3L^K3KK)(&L.M)SXTO8.cO6C)V4S
H)0;O.L,X_XH]QVTN>UU9:N@fYLg0G,cfeD[3QOd@@5V8g#S;b]I1W]c55N-#Ac2
BC&+G]#;]:.Bb/22U#9Q73dS;71ZN0YD54/d95(0L3H)^^55DLILQ\IN;6KUH=d]
X(B+,ORLW?:a[5T?gE4JA2f^>;Z./.@d#&J1#R\.@a?XHeC_Yg8^DbE[^N#KZ34W
]53GXJZ.(>9&T?3^?EY6?/-2.B2K[QZWUT\aUZGaI-OVd_CPW#1PV2_W^W:ZN7P;
1/J]aUAVQE?Y/B0cS]+A2e)7[Z#SC-a:\P&LO09a(gI46?aDY6[9Of=F38BLN5W+
?d6M(_=E1a>?ZSJJLJUL=Q85ACZ&6;eT(&0<R&WcBeQM&b7SUQI.eU-9aEK##_+P
:X8NQ-SCJdTS6<e#@0-:g],6YLLG@5799.:HR99,)(F_VF\HNW[))g9f8c7I@I.S
4V&@7@7Q,?R097?;QK=SaQ7\4(W+S1]9Ie#gJfT97g[0^Fc[;FPf7?19CeNV^),c
\K;/>XcdSLGRPb--O9MFY.FO0+&CC]>66Qc[I+3UIcIC4+V2fR6IHNcHLCW=]8.=
0ccS#(\XV/2I<VXYMJJ_1#@MQ>NgZ]@&\PMVeEHN)b;]gD7_9Lg>T@2BCSB<CV\d
7YWCUUZZET<X_KQ_&V?eNVd;TZJ-/g38H_B5QIa)[CP)bRYKHY30D)NV:.Y#f)Ve
/Z[A9B(NQIUg_TV.ZV=Ff]a<Sg;:21W,^@A5eDBW9g;DID+1P#;/7S)8c>VW/FF@
+/3P\--82C2-eBKf;\(2&70Y^gOIB7](.3RD,4.FNfDfb((e,/??KbK[/FYW6_ND
?[+=Fa&6.06HA2c_H6K6dd)Y7_X/K?+B^0&fa+Ze/)d;0K-./#1OTHSCgJS8QJ>J
;bI<TbL6:>Zc&PVa4)ac7X5bV0EUA-^COFf@,3B,bO(6W<<)8O2<Z>[?]R?X<MW>
)&4(7cG\_/J;0@BR)<-FP;;\f2]-=<MIb/K>0A31b;9\0NM?g,M)&fHY9X8>PC[c
1JS\_<J1S5O)XV_]CG8e6O1)[\1:_#fdD&5<&e\=R=D]))egU;>-QO:cfYGde565R$
`endprotected
  


  // -----------------------------------------------------------------------------

endclass : svt_apb_slave_xml_writer

// =============================================================================
/**
 * The svt_apb_slave_monitor_xml_writer_callback class is extended from the
 * #svt_apb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_apb_slave_xml_writer class).
 */

class svt_apb_slave_monitor_xml_writer_callback extends svt_apb_slave_monitor_callback;

  svt_apb_slave_xml_writer pa_writer;
  svt_apb_slave_xml_transaction_timing transaction_timing;
  string name;

  // -----------------------------------------------------------------------------

`protected
SB5TU6^-)^#ORA_C03U7FbF8,Df:835@e[Ac)gN].XOJ8I1>V:Q,5)ae(C-S.Qf1
ZSRMLA,S11bMc:7.cHg-ebJ=JPJYDSGZAd240&AX2^Qea,G:4X@4:T\<+Xb;&BS6
7\,0RJgZ3[Z>SfLfHKgGQg(Q?L+Mb1#VC]^bD:BSIAIU<WQ1^Ie-JLMLe_/b2\BL
9TGRPBA5[^(+XaG?[<\@[3fZA=[QCHTbSP_99Wc25JG-a\M9AFTBSGN-:G0YA4GQ
2\cKUWK/D6PH3e^_-J\dC43+;XUMO?Mf:9):&<MVMPTLMa.YSbK18]:S&E9<4HT1
UL/?dLM]HTEQXaHdW&#DS?3+3$
`endprotected
  

  // -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
:D<ebIB<Gd+SXB?:E8-<37F#cC_B1J^<UG8@=2a>X:V38,Be1V?b1(]+8O-10b;N
5O;_,I.WQB8DT1+/Y\/W]I30b48IaN#4UDcG:^?4I4BDL1]/6H\V&f-.B8M0IVC9
1D?\;=cP^)[.f5<3eR<UD4),\Q+X@R;+[F]bXHA.a2)79T@T@X1dM-XCUJ5:M.RI
0G04[G/S77XdMO^9Y?LTKf.D>L;2-3)fZP7e,;SEDB\f0@N4_N)8_166[]W1BW<W
=OI:8<0^0,V8[MI?#b=b+^V&T94F]@G[;RN-/d:F+Sg4QBXc-EF9Ve-O(+STTT1M
XFQPBXH(KB3DYgSMK;7c@A?[Ea9]UFUc;a0<U?Pd8AMDE_KQGHL&#5=AS+;,HA/g
DDaKH7M8[E=G3eNT5]V[:<A(MDCP6QNeH0Z0)8NJTH83)FDgZ/]]f(Ma6X28FJ7/
ZO?6\=+@Ze5>@c&-[@b,7&+N=.:TGedd;A\2c@4:=?SWAIU2(3I9^YMJP3f6/)VZ
-A.)LZT]Ed2D:1[96.]8bJSaY=YCaa)QM/KXZ#d^DAK&=B:S^c5b_[@Q=7&8g^89
GBD=fMRQe&PfMVN5UKJ/QN>..fdB/dHND7L.>ZTYYBKYgXLGY=PD7]I]2QcK^@8+
IfKaI>-Kg?fbB)(?Ag<^g7WXRH@>BV[\f^^0OSL9]0#G4@RVLA:V\6>,:-.Ic0NB
2/A6-3T(@EEO\?32;(FaFYQ-C@VNI,[26CE+HS#(2-HIE8Wd?;6?YQ0\(Za7UI80
[VJg5_U:5H3[\5?#gQJ9:TD4B=N=64aC-;,>TMICY)/c5d=>PMLH;.9fMEd:b8V(
XVOPUU_^c.,a_T@VNQA2_>.0f?GcG9C.ZFI67)WQ1e+78-@BID8[d)EG#OF2#R[K
($
`endprotected

endclass : svt_apb_slave_monitor_xml_writer_callback

// =============================================================================

`endif // GUARD_SVT_APB_SLAVE_MONITOR_XML_WRITER_CALLBACK_UVM_SV
