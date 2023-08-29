
`ifndef GUARD_SVT_AXI_UTIL_SV
`define GUARD_SVT_AXI_UTIL_SV

`include "svt_axi_defines.svi"


typedef class svt_axi_checker;

 /** @cond PRIVATE */

class qvn_token_pool;

  local int token_id;        // provides each tokena a unique id during its lifetime
  local int token[$];        // queue to store tokens with specific ids
  local int qos[$];          // queue to store QOS values with which current token was granted
  local int grant_cycle[$];  // queue to store cycle number at which current token was granted
  local bit enable_token_expiry_on_usage_limit = 0;  // enables token removal if not used in time
  local int count_token_requests_pending_for_grant;  // 

  local int clock_period;
  local string vn_node_name;
  local bit is_parent_slv;
  local int max_outstanding_token;
  local int last_token_req_qos_val = 0;
  
  semaphore token_request_access_sema;  // gives access to token request channel to only 1 process
  semaphore token_queue_access_sema;    // gives access to token pool properties to only 1 process
  svt_timer token_usage_timer_queue[$]; // queue to store timer handles of current available tokens
  svt_timer token_ready_timer;

  svt_axi_checker axi_checker;

  `ifdef SVT_UVM_TECHNOLOGY
    uvm_report_object reporter;
  `elsif SVT_OVM_TECHNOLOGY
    ovm_report_object reporter;
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename( qvn_token_pool )
  `endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log log = new("qvn_token_pool", "class" );
  `endif

  `protected
I1Z9A4QMRFdQ/-U=EX/PUfgMIZC^/[//a2fe=EbOZZ^HO1AU<)6R&)bD3IQK70NJ
AgD>:,:QGT3DEHPHKZZ86a+a9^EF3M)NRKcGMYX#DNb8V15dVQM(L0XY&?_DNBfU
5B&<E198_505a=W[#T7GX)3:.&c\=fdB^:(\@D6C0KA5ZA5R:d5Vd0<^VJFb3(6[
+7SV7IS][A_4)9OTaM8,S,(7Z6]?JUGKVdD>a4:dY/1?3fO>3[ACGEH.ce^LT--(
gSABJ[KC-2W4<SM7_PQ1&0;/5(^:\\B/(W7CUZa<)<(<T;E?439QB4].V&3AQEBZ
E7.J/aEO0?HR?6#N_A.773IeC[KIQ/&2fY9MZ/_F=S\/G;^2FYO\D6Q(-_e3_J[.
=\NY^&cV+WQ6DRafK6GZC((.\VaZBc]F_ffVHW.eBWVFfKaXNI:0P[#-,+Z,H^)A
I&-<UTDFg3fWbedWgWMS/^f7W_2g+YVc7^?P?bR1&--Y^49fJBTRZ^S@HCN0\+Fb
I),T,@d+)RMD\IB-JUaOT1-(U;=\=4Y;QS.aS3/eg6E1JH_E+/R(6S;3]&24+7Y,
<.R7QYH#:<e=a&P:P1S(>gKcAHO[g&bV+bbM<T5@TOPf>H5BIaCM2]^V4HE6X\I4
JLXMX=;<_S?:FX\^9^G9DM&>++[I=XCE=1GKLM:DSF/MT?NJ\N&9Rbb__1VJ25:/
71Kf<]?>X47FW:@U24D[eLeZ6IR5eV<?E5D[M.JS6?;\dgH#ccZFS0f?STHe?f??
F[P(eW]YeJTY3/::3=IeHQ1SG;-HfSK&V/#.CJG=]645WGN_<a#)]540O=B0F7Ud
IZ&HgSR_UTE617=6gO]LSR.,R;JL#g44X?Q1JfHPU,d9B_PWOX]::<Qd6D]W#[_U
:1L_gffPC95d<[+@AWU)<3.<TPGU+;R<fN),DfX:dcN)P&;fW1g+Hdd(LA1Sc((S
E6eO-fD;N#WK=,9RB?T)DX\ceJ-+deYHK^+f3^VSS2K^95?.9-a,>MTR[BATR)Ce
-H?,RAbP<gaX\2a(--eX2UOOeW<C-MN</+T8IC2;/HcI@3R3JG0+,.S24I8>W_:6
OPNLfCJbHGD7a\5^Y<U(3/E+5De6e?-Q&5]QPM>4JR1VD;Gg;bX6N0]QQcXPTP;3
W#;4CN/U5DYYN].=U084(a,)d43)df?V#<-GIT\JCZ1gf5<Vd=R.#^;ffSeWID6\
g<L1,>HB6gC3H<7/e(<RAWd?IJ>2Z;T<USR==,8PdUDbLOL@J+#:RS4O/edY32]P
6(eCaYe138Hf.29(T27Ke,X)Y3[/FF&;H=FTTMIM6KP+b7>&ZU#U#TPS(GeJ>B;?
\/N1+;3)Ee5T_9a3V0V?\VC>N<L&[bc275=T,]4:96=[<EGO/AMRgC9)V4-V,a30
#N<6HYB6A;_9A<Z;7#PKe36^<C?Q/YO;-KSQd[\\^:;V(E33UeF/be^dB+aYa,[=
QT?#NbF_XKQ:M6^&S+g]ZDX/GJF]Q]:X<cZ<,:#eKJ537=39T/Y4.H_RRQ]\J)PO
cD^@8g=,/cZQI;[<VQ-=&RX/7$
`endprotected


  //vcs_lic_vip_protect
    `protected
3:Yd\<@:&+M)/NZcT4K13/5KXUXB/Fc:)bCd+EJJXfY8SaDa7bQ(+(e24#0VD)7b
)=#<\g,d\Ka0<W18FHUKE;3@Y@E_Hg;U_8J=2N(g=Gg@^9-#F:(f7[,9LH-4O2V=
F8e>XOgDc14IC#6dd4;#R,b(E53)#>7>P4>-#(JI+,@?(-L@/[d3X^[3V9H<:<CC
Q-Y=f^EL</Ce6FJ4PQeR]b_XJK?eg+?U:Y)O2cIR^&X#2H#HU8F:Z^6>(_;;G__X
S:c>@5UdcHAQ<3_5Y5eEQ()&Vd;PN@^<R07L^.7WO@Q)_3_7,O=?./b>#3P&BOff
A@MdLRBZ6./[&SO[_Zcde]<OK@@9bedZdL\a;<7].GDeac0aHI6Nb9V#Qa;c0KYB
6?3aR,Bccf+UD3H-@VXV:/]K]g+BfLH0NSGcgY(Cg,WeF;B[SSaO]0AV0;^3]cC?
:fKV&0-Va;_dRd&V4I9X/;JJ/ZM:b;8e=Mb#<8&EP#H+=Z:Va?.cRZY?NSVGUeE^
<d8T594)WMf^#^.AQWBbg@7QT<BgPO=bC.JW-<0&BAd]2)3^3G:?KY&7gV0)TDE^
UX^3CWe)f#C>F=4HLTOM\2c-<&P[XMPZ>\N02LHOKHOZV53/]&XX-ZZ]0W&4>VG>
S>U^fd9UR,.XA+c0&,\FD1^RY6/:Ca@R(&_G82F9Mg@D5AXaBETWe2e660M_PT[W
/==E;#e?59Y01K.3&9)ZbEb4WE&XS\XI(AG#MS,I5W78GT?VE20gWF/0W_V3K67.
X.YV_0N#QMJZbQ9/IUFTRY4W<ZKU,bE<Z5&HJFS>GJWB?WYRZ=66+SgU[+75[8-(
gACWU54LV+]U\R11HAB7DbU3GJNJ+U7#8;>WX2Uf\[FaCM_CK+Rb/D/A^]AH1-X?
UN>7]a6/IHNaA+B2NJD(/Bg7#11/LH@Y370TVL)P\d_OR[Q@_Te^KG1SU:bHgCf(
/H)40@S&DC#W5fLY4g1P8+QEY#=W2+c<\fb4T6(DWdAW&4.7KDc?6fR=@X=c]EP[
P+5dcE3H9BdKW(^]S)&NgbZ7YEYR)aQ_DBH:EdJX4OGb0_J#J<RSNI3f_&gT08dd
OT](+[I\3gMOU/=55eB:+U#E-a?F\gSIA)KLV]2B>/eO,?M;=J6[K.&K3gfI(aT_
=Fd8Ae:dYHI<ZEgUC?[#SHgNJU53B3Q,Q&H^[DU@d<=U1E0U4::\S(0f?D>Xg/0F
_g^\Af347?B-J.C7+8KI@aQM#^[aA3YQW#Hd[0PM69;8TEUV2FJTJX&#O4aGJJQe
T+H)RfP6P_?d:2?7ZU<^B\Eba(O^D;AFIfE]<+_c49OB#dHGIEMQ6=YM=bI4K0N^
0@&D,de@6dP3LHddZWV(T=HagTeN->KEaZ5:=]ZIC6HXAIVcGLc;Ec?BBbD.V&<Y
5R\_aZN#f/M/W7F=VWQN6O#_T)TR?Y-B<0@fW^13G6gCLU-(M;\;Y4VY/-g;##K6
<W=W#GfV-\Q@C;Vb&=Z&YIg-OXQZ-XY;<,8.1/DWS?]=)NKZ+]CSeTI\ENJL;\#^
#F;U6]e:(YO?J>O9=C0I2a2G,Y=&+NZ85(-IP>Ia2cF<fFC6A/I;VGX\EA23E;E\
ERBN5dRD1B6L1>a_<)F=BO68:ebcJ+L/4<gJ,gP\Og8Xfc3JOEg5OcPSPCP2O;\M
#fdEC98;;(beI_WQ[UBI.N-S=3>\TV&\6IgX\MNFJVdO]HQ4IS1dWPcbagTR4J8>
P@6&bM:F#:_Lc;HHbFM/ZYOLX>Q_3,R?#_IZ/?F5LL_I:I\)B##JLEaK/5_T<U#0
>#Z)g2c2G8@0LZ7J_&WZPW,d(6-Jg//9\&eOM[S)?\M_6;A9F=[-UKXR,]bZ6&CC
.M=M7XQU8:Ea@(MO[A4E+e_&KX[SQGB<P\;>W_PdC_<.;QEVb<XV\UFd\=+cS&Eg
aaS9(#]SUB;+4B(>dD2.AB)58HA=V;/A_/)G^U66g5@PN3fY_]U>bcR>Te0X394,
J)D+g#:/BWSLUb^Wf94<R\C,\==__(18MQ<_HYMR4I]):(Z_3&Y-NQZdAF;E)]ML
=bfRTQ23#&\DRC:AG57+gF6c_gdW&-Ba:A<H80YQMEP#:?O-=Q,QHBA)=3g7S#)P
;4.6G5J5)&ZcX?,J/B(d.De3HR)S1+_I4(GWRJOJAJRV(IM4RT_.24-SgD4;K^4d
WZ#9\P8[]g.EYV3.T9+95+]=D#YfK^DIW?:(#8W#fJKCV3R739DaREW_YabUKJJ/
GBMZ9e>?Y(R+D3([eR_:1T1R4:&RU9SUGO@L^]P[W\bJGLL@>:Eb6=1Q@9E+T)@B
,GHZ8eKQY;FG)dY]#Of(EZ8@3@^#]_EVV\\X:?C4g;GFe-:B02JMS#IJ;5ZNU:Nf
13@JTIc^)#15QL3V5P5c1\:(V[JaBaP5_;f--Ce7R3I<&/JIHF@DH]48UYVaS+N=
BNbV]]@S:P1[(f:)D)Ma8I)]BSgC,B\]EMT&7ZRffR\?Tgd.5K:4gO2(?><d)^3?
<[B05f#+^M-ZFVb7FA=Vf^,Q_)I<<7@afc=g(YQ)L3(Q1(5<e1/Tg(G+H0:\_#2G
0QGF+&P+aYL31cVH_8+bVX4G1QE\9Q1PSNKYgdDLM?Y+;c3E(/,A(KT73Y<Y^HX.
7AKN@5V;&Oe(Y@88-1_3>MAUf;+78?JKf#gCK:dg)6=UHDcNJB/5b<FP=-5GYB7d
7f9UJM[FWd_de(+eP6ce8gPObC&NXRPH+=_-XNf@JV8]gNNE[DH[/_>6M(JCVTWR
MLCE:H[NBP\N#.V##-7K=D.#8eKNQ-I]801-(T<V,/>+=Y60FW\O;DAQM6#A]f/W
B26?FKGa.^_<UGAfQabF>;(3LPH+CP7Eg3dM.5\+ZG<_KebHF7YS2SL8)3AXJGP:
KcDS(f5N>]+=2d^RdT\U9<MB;X-,SQI8MP@0@eG]LR&#g\GBT^=fKUf@\(V#5[@K
IX=9fTC5EG6D)]5E^[<Q>RaI.d[45MA-4dQF2GZYc<E,8E\f/5FPYP&&UDfVgCX6
5IE1PB^D&6]-D6-_G?B]R9d-bA9b2D-@P?4aS,_;:,6YaXCO.Z@,.9\]5^4I]@ZJ
GfLM-0f6B,&:.&f).<2\?N,WCRQS63O.:>?_0WRV5HDST1SQ)bYGQeUWW0[\:_TE
[NY;;bU<,BR=_SD\2P.1\BLF(W\4M@;a5CWQJ#QLCbc5eK6:P(WZK<KW1ZGX=KLe
)c7K979XR3M]YHb\SOQ;)aD<=-JFQU?8.E>2)9#NSdBLbM&\f;3M^e2dW0-dP28J
ga9+IG9?E8D&DE):F@FV=fU-#a3b</6LR/WFa29V8AaBYS5eD]/cT&OV-ZK(P/#&
bS(MRPH>XQ^Y7I:a\C,gXe7_OV=MQ_Q]LF??6TWfF\HDf/\ZO<b-dSXG<f.C;4T1
H1X++/\c(E1KLDC9/98+<M=7P9);:0=K5HXU&0SX]d#-[YeSEZ/+??d-E@I)MN@M
BP.._&\WeDGZ(>+^LJ,__#R,65,F]42R\3ca#=:O\L+FF0>EYTW74:B1S?O7L6KV
COXC-(^XKHWbI_6)&.<0KB(LgZWOB?#_^;X>)5-EH1^J>1_VD#Fb-HI-O5aT&:HU
Y>OB4>dK9Of^Q(aWNMC=H06>Q[#JRU&ef_Y4bJU1bPO]:V=.NE4?d8Z<R#9:G22R
4K-cW&0A0c][_Ze;E5fgG2SDB[QKW,HaO(Zc:MY.X5M\24G552S\cfVL6gA5d-cG
ed4Z1cVK1W(7?_=6\U69,7?5OL)^F.FK_T1.;e[aV_E2CZ4H?PN7TS.CWe,K=b3X
F1Z?MOf)T,?+5L<.-Afg[SA3VS.<S3/]aRY2S0ECHe]:WCNEJcH)#Y4GIQ9ITP-O
MUVTNF-N(EH&2_J2U,4b.<EdE5c<3[+MS7/eMH<L-Fd@E(H[faCYP(]SE/g39>bN
>3)BB0.UE#=P==dT:R>@)A+RVSLa4Y6[\2_,.@_?86:\ge:B^]Q6RJ<F2_8ZIf\2
Q.RRO&J@\;?QCT#X3X@gK0FUEfC7.;9VKD->GS2@fYY+/+?UHeQ52S[ad7&f]fY[
I&49XcU+cJU?05>BMa/@?/1gIdaN,ELCcG6^M=:F[_fV+_FJe2+BGJMATaY5\Xc@
M):6D#b_-@8M:d989=AQdD^-aRN+f4bF3_EUJ37=-<P#/:a,JTO-[9X;(8BaXJ55
_C-eS,N[^gT(eG+.M\Aa#5(35D-HF<@K3,eEZ7_gGT[fJ.fMNf6QZ?dK/@Odd34W
@A.VT7]7K1C)^&G+KK\L8\XGaKJa/E3e86/WW]HKM-S54Q4HI\Ag782OYY[g;9@8
<LH7[fL=-]9:)3C8\)c>d=1M.>7)Ua\AS0_&7EFM_W[cW/L#-Q2dI5ZfZJT#g_=F
&;IZ7CCE(+.6MBIMM<Q/GVH#,B[7GFdaC,ac1E4GZH\IcZRE]ZQGPD,F9\^@f4Y(
B(V=D31>&6dTaT[TM;4@42WINaN7YPTIXM8XN&A#I+ZOHKD)D+.JUe::>MT=;C-?
K;(W62NM6Y[AO.#^C7M</aQcId&,OIg1]0]JPdLY<ZZ)Hg9b(d6gf_Gc(aLIMLV,
MbgU&b_C)&1N1gIW+M<fZOJFNM[065HA?P@b7aHNLXJNN?e^Z;5c)e,T_=)fT59X
,1E/2PI2(AdANbLA-(,XH+R>O:ANIBNeC_EN&W?G[SNTVKNQO-cK1CWZQ2U_69W>
4@-e,A,VLIR4?Q(/)W.0aYRFS5D-+D#>XdC-OSO^N7[c?+<>W8ZggBcaZ>eIH8]-
^PZdAXS8?W#+4[28,U.TY?MDgb]W32>WeNKEWFO6C8R+2MC\2->8]]c;-\0a>O@g
Ze]H)SUGOOd1H)S_Gc@@3L/Z6YI;ZO0&3SP6OIc9JM^8:B0S5SZ58G>#e1V19FB@
W#]e2CJ8.X:)=]C<G92F2AI6Lf0/YW,c(&40W?G@[;IH]/ZcN_09:Eb/3#148UV4
bA2db[0]DfYcB38Ab<(\=D0XT6^.H)7[gbeTf@RgTQK@-VE^_cN/0cGe1=GSBbKO
(2@.TNUBb/)D=0->I<0EYCE0JcQ7>B=^cC=,443afc^G@VZ5]&_J(:^PCP+1De=d
(7;eT?,73Z@FW@U[1e[@QZG<HIaRD/fWLgeGH(+B8C#T2AKNT)R7&&5;/Pg/K@Cc
Va[E1OF[H5K;6JD^@S)>/Z=XB-G48B=3=Z0+B=_5+&bA]RHUL802]8M)F:Cc7/9N
6P-),cZ@:@=/L:3Xa>f)U>)^IJ/C_AKGTRZ5F3K)dUPe\\9+G@HCg1B@XaVG3NCL
4=.GTJI@&UZ0bF40GI,A&:a,S>2E)BC6\KX5H,:OKA,bXC5HL&&d8VOU_DQL</?3
G_.Y;Lf0WV&=1UPg/BYGaO=b,8;P]8F\M5.N9NW&S<Mc&ICL54eD&_2C:@1dQWcQ
)EgTeKb8^D^BHLf3Z6V/B?bcb6HaZeTdHPWC)_BG:Q&BLZ3V<Ad4)Y=]MV&8eD2b
AW:KT#_YSXV\A\RZE7WJfSWZ#gEYW1XUZ)I)FGggR)G437DBV#DILE)M3+<9;7E)
aLc7NdR4PELZJ:DOa;0/dFF3X9&.6[Y[a+G-2Q+9IfQQ8=M80c(g(COC4:(]72Q5
89882C4HE8QGG:Keb&2J^K1Y#-[?J_RR1(Ua?(>LM&7PZY0@2COSYE25(P@K1K:S
8df_Ada0U1Q0PXDSc-.dNCB-I7WR)d2U26Da^E(,XU,e>P,7MFcRgXB[@cb(E^VR
K<+bXaUW,S7LUdX)[PeCI#P<ffaJ8)PBR=U(dP9=[_fg9/+?,\J79(->^N-GYFK3
BAGR0,9_4N@=S41ICNJaH?J2)0,.+P)^E2UL3HY>&,A^.E]64g6Q3?3)KBZ9#&:0
4D@Z@55T(?_(KdDVJa/L/dZD=@b3[9W?U[#3[J+QB@74@I4Ige851F2Qc>C;N3Z=
e2d,M4[/KCW=XQ8(+W<CKS9W7LbKf=L-RRUI1R.A:-K_DC,04d)EGbUJMO>)9P1=
d>e@PG&?2/cg[]J)/)_64BV;M4IZb5b?\Mg-daPJaWY1;8[5_PA#.GZ:GG9UcN&+
1#QN3:L?/@G^fV.VX+HQ3W?1_;[6Ca88M[ec/cH#;<fSH]@VV9+a-/DV,gUVU1;.
aEF8[7NU3#PQF2VIFW?7+TaeQBX:_FNQLb31b3-fabXP+<SQ8JX,JZ^M1V1C4Bf(
YGLMY^5<97:)8e#6T9ACMRcC4:VgV2891FN)_HP0Y#ZI#b7dXFEUQ>D4Y1M[VE@L
@#H+LG:&YCeOU_AOg=/W+4LA1g5+DRfG?4^=O3R8J0.1Hb+C1\d0?aVLDZZ\)<D(
CPEM,X?^Hdd.Y3=C?9C^BT#D7S#eV,()^I?K/[b@+EG4-90/;L\M-88PI6IVf_(8
fJ3574fG9&?]]5VO3ZH-ad5204E(:2Q7MTW@T7W3<^1=.UD.@&.A/R?JRO]dY5_X
H\Y^.DOZ\KS+Y@V3PD0YVKe>]A-JJacIAZeP)fXRe7@bD(+.\2U2)9B.)fME(T8@
IXgM[@F1IO,OKFd\R8=(VO.27d+8W:9Z3bT4a6H9NU9a-?P^-?+TcfLTM@:NR^1[
;?MA;5f3]fKH=99/4GI9=_,GB9S2?^LB,f+fRSTNEPT?G8>6R5S+L\gFTB?7R@J9
8GcZRe_>YIV):,(If/e.TGD^Z?:(FX1Q.[(FV>\G2FH+G?OD[f>T65g>U+4Z_=41
9=NcB3CH-a9[JfOdYD>ZD<R:6C?LRA;IHTL:.dd;LBBD)MC[Q[&0+\;])PQ<2OB]
@I1])QN1CC/f;R8cQ67[6J>0A^8GJ6SM4BML,.HgMS./C#Y3L&bF(5&a)4.GM294
=fSF_0=<W7BIe1ESY(g/]\+0\QK\<-BW77_[8OT#EK.3(PIEREc2NAWCF33KB&(,
J-MCb>.+_H:X>eD<:7OF9II8(41+d:\VYIEB8_agL@B6,?cV742bJ;d#KAHW4]Eb
a&1#=G\\@AUQ4b0^8L]Y-VZI-D1BMa(CQQ1,A\4A=MPUAYdT8<UR)+FPWP^O=XV#
^R03WeV9S^0E0C].92)DJ.RSUd&-#+I,-S4=L^GT,WMY[LDUY_[C>V-,+/71BdFW
EU3gSD=;<6MC^L/EPQIGWKR_#ebM46[/GBaXb,OK(A8fODJX@J72CP9[HBVf_+&7
;\=R7Hd,JJB(@I:VOP+]L8RL]&ND=g)QdFO8We8OZ)TOB;(8QZ(#^T]VL#Na<U-I
XKFeI8QS2/B01C&M4KS?\g=V5PRX?#c,_]4D_J;L(8A.L3GY/RTRH45^\^5SE1fZ
/=cZIGD4573JPMe3SP2S@A@XRXaf_3FD?Z:6P^F<2#WF)S]\#B;R4Kb(M>&Jb&4R
;3908eUKdaRg-X[HQ]&Wd&UF:BWSRM1Ac?3>^P-GIeXK1^,,5&&Q]\2R^:QE[1,R
+O&/./);SNGg2#7\/_aQ,T-Fd#9CQM^^^-DMA2&S51NC+,3<=VXA3+Z=Ob_P&I@]
PGQ)E(B60DL_STV48TC7BDRPW/.<LE7^BdU(K[70]/.J;6c\)<XcW+RQBXSEPgOG
/L9.IMFM>(eO^Q?>;I=f/8&7[BJ^8D\H@_fN((eV#;d8;)]/[27EQ8gC8(8Sc8B8
?PY1f1IA@8aP1WK+O=N&KM-HB.B8_S:bSJ167dHSH/3d&Y/RP7-0G(-;e1W3bOZX
/;=Va]DUBI1]e+TWaMM-;J])8QB11P;)8bKdA@H9.AGJ<NTSEINM#>7ed8BPCL]_
FB90&JCJ,S67&(=INgH^XUe/aW\4F<g-IdX?1VcS5A[]/Zbg(,@JYH(#@DfB8-We
4>OP>O/dUAdA.AZ?<&+bP\/ENg5W#:G6;$
`endprotected

           `protected
X>(2,A^+?dWeP3WHBVUT8POD,TL[I-IWD8?#:eA.V_;V/C[,/,R9+)<E0H&2D4QY
1F><4(cPTB,P+_4?YfDIaJ@dR[[J8&SQKbKAE+OZ6#cVG$
`endprotected
       
           //vcs_lic_vip_protect
             `protected
JA1,F[S0:SU4.gMLc-CGS/c?IJfH99f\UUE]K_QFEP8&Y(\@/J3K5(WAYF\\HebX
6);G46E^H):A01&XM2,PIC:MO&gVV?dV:=MN56[,\81Sb?)2T>?BB&/,\H-9(OKM
=Z83ZB^=@gZM\Y1_@A9O1]V9D>>9Q+JZWCU4MQ_R-]\/+CUgNeUSJdMSN\C.F4.G
BH(0]d=M9DC>W(L.TTD-H@D:H(Bd[dZbL3@T2c6[@UdHb1.H#0ROHaA64HJB4]Y2
V)?YE01FA1ESf9/PI2d_+TSKDD93)R3WLDeM82b:+S3eC/;X21&/EYPM?1/:Ed04
RKKbB)MC1L8L&f=##&I0cEUcPQ3T3OZ@4+ZDY)P(VAO5Ig]DAc,VcQg-5A^=f=];
\F&OF(EC0OL0YCAJM>X8g(Ef5&_(3\S(Z8U8N,,^JOC9J6#VbF3<-?c#K:_AE[R^
W,6^5C/e6@;Z)2eC]1ZeN<JHV1,S#eGA5L)9BJbW)TFH:4LS>g2G&BQ5+Yd;XX@S
V&Q)N?(O>RV?>H<6F<FE>8:=U]FJ)EfM]U:C]^]-/6V=fa:9dTb?@A=WV)G7/T2:
VH-@UJ0&&_:]Q.R(2c0K.Ne_[>0])eN-a4cCG(UXM05V>V?(.NE<-\6&(1QK8XH(
6I35GJbBV&O=UJ=7R<f-f_LdTHDFHX9,;5f=N&SK<L/TL#5Z)15=)>]d[[Q@WSW@
>SMPWAI[V.Q\-97C9N+COf39@(KTC;@3KR]C>G:H8/G;S.[G6C=7MC\^8#]02gPC
(]0P+E5=^RCU_TYAbc\>QKLP[<VM_#?4A:2E8NG(UM<gQ_@TeF(?(Q_:8Af5eIPH
d+<[SS,f]LG^QU03J<U\]P(F,]9J11;c6YTZB3O<RW5)CM,)?#]1-S7ZF&_aNK]D
EZN0cSB1H+CN/FB[0;A3D#3DWGY3)AY/2B-V-6;#Fa[-?W>9QA?#f8T(5\[K(fLM
ROH7^]NAUTN754F[=[G3I3=[9cLM;ZK29RVX/a32S_Ma7&Ed]VC1MYg/A)6B7Sgd
\0R9\:TJ(8Fc<a-PYb#8MVQc10HLB^V9RQIQ&DD2X#^JQY7DYL/Y+_)-H96[0Zg5
;]8;PVJaddX-:&1.^UG3KC7/N0aW[P1MB7(XRb,9S_O3^D0Vf?@[XP=Lcdg31EE2
-gNE9]^g/H)Z>\I^6aWD)#He0gQ7PaN)>db^TVPDMFB-WS;c2&&^K/9W+&WB^A7c
9(T&[X6WVSaG[+Z4fUO:?Y+gI43W7#0[W-WG[M2/^Z_eN3V::ZS[e>2,Nf5YI_BR
QT8E^\;=Qf-^\08G[KNEV&&6T7UFB+).GH/]BQ6N0E8.A+&2Z^A40T5YLg;-J28/
W?41T>#DET;V@fW2]PB0L1/4WMN?([_>>U)E(20d;a1fSNQXL=+QP)73P+GJ#<H:
BPS\:=#Hb/E[7b:\D/KT\R@10HL8#gbJ2:&=>gaTD]a3J;YLe=GY;(IcJ=VOJ4_0
_2eQ@?GG-<(121a,3:L6VU0d#K/1Z]^dVZJ-fN0KeGI(5E=0I/O[L?T@\X(F64Rd
:HFNJCaJXed3JB_1fAFb2,[AVb@+aZ@2>\KI42W].5B-@WD^<1(3G<GPC8<+Z9)8
OTG64A5b<(T^-Ka@E59H^7:UL2g:?](AO;O9c>?1[bUF^8gCD=TedHN-:TEe&(1K
cY/3SdBAHXM.N9?)g6Q8<Zb/F:9)G8FW^HNYV>A/3a,8FWCbd33\-0gdUV;28?^C
CAT3Y/6=50&HL7^C&Q=G&QX^ZER7Lb#/+N7HP4ZAK#a?-7W.cLHeO9=;:_T[4b]3
33cb1&6_gV/LaHKSO^/J@cOTea;2&DU23#+_&UXSa-LS>5,^]TI[(#5].VeO/aG2
4]CA#3+Fb+<:+Q=YN(RVYN8&R0c6?0^2b0L/3LY&FU?c,9S7bWQT#IeD&/8[f)cf
I6J([/ec<:]P,=8H]BgV:YaRLZe0APR]S^?^G:.9RUdU3bQB7S3DcE]KIKUL2311
^&]QgXXF7a4-Z#(SD/FgJ47-^KIQcVB@Z(KUTV4ID(&[+];a/QB;BXC@295[<>9T
BM>ZY;.+RJg?ReAD7f1Z0&1QVPJ=PSM:dF9RH6/2[LJ&g-.#_+X;7L8X[HF58fS7
DDT<2E(fDX=cdP7QR3ZGX+]#^0Y(Y[UV,ddVPJ(K^-PEK,^R^gP8aX359D+Z+N4)
7)>E+<edFTfE9ag#G<==8dcG/W,K8N^M1M;aDY1f5G5T^O6-LbLaN?EU<D)8)9T)
?AaJ&c^R=E>_ZH^,34UM7e,eO[K1Q)J?#)K<CA[7:e6IBKD4[M&A5Q5317<6&=RS
15MaB69>Vc>)J#d2^#WX/8IJEFe2e0S9O/NR2HZDMUKAWFeM:I,PSJ@#TH5RP07V
($
`endprotected

endclass  //qvn_token_pool
  /** @endcond */



/*
  * Exclusive Master Monitor::
  * Each Master in an AXI based system that permits to carry out Exclusive Transactions, must implement
  * a Monitor which observes all incoming Read/Load and Write/Store operations and track the state of 
  * Exclusive sequence, Master has setup for a particular Address unit or Coherent granularity for ACE systems.
  * Once it detects that it is broken by other master or by itself, it disallows any further Exclusive
  * Write / Store to be successful, until a fresh set-up is re-established through new Exclusive Read / Load.
  *
  * =======================   
  * Exclusive Access Rules:   
  * =======================   
  *  - Exclusive Load registrars and starts Exclusive Access Sequence
  *     o check exclusive access Monitor status, if failed then reset monitor
  *     o if SNOOP transaction is received by the master for same address then reset monitor
  *         ? does it apply for any snoop transaction to same address or only those snoop which will cause cacheline eviction
  *         ? if it invalidates or indicates another master performing a store
  *     o when current exclusive load completes, check for response. If NOT(EXOKAY) then reset monitor
  *     ? should secure/non-secure attribute i.e. ARPROT[1] uniquify each Address or in other words, two Exclusive Load / Store
  *          operation configured as secured and unsercured, should be treated as part of two seperate Exclusive Sequence ??
  *
  *  - Another Exclusive Load for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {same-ID, same-ADDRESS}  =>  no effect
  *     o same-Master :: {same-ID, diff-ADDRESS}  =>  reset monitor with new address
  *     o same-Master :: {diff-ID, diff-ADDRESS}  =>  set monitor (one address monitor per ID, N number of ID supported per master)
  *     o same-Master :: {diff-ID, same-ADDRESS}  =>  set monitor for this ID, existing monitor for same ADDRESS from other ID remains set
  *     o diff-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *     o diff-Master :: {Mismatch in control signals like AxDOMAIN, AxPROT etc. w.r.t. transaction issued by other Master} => reset monitor ??
  *
  *  - Another non-exclusive Load for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *     o diff-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *
  *
  *  - Exclusive Store completes an existing Exclusive Sequence
  *     o However, ACE supports continuing further exclusive store to same address      [configuration:: ace_exclusive_continue_post_store_sequence]
  *     o check exclusive access Monitor status, if sequence exists and monitor is set then Store PASSES otherwise, reset monitor and mark FAILED
  *             - no existing Exclusive Sequence for this Address i.e. no prior Exclusive Load  =>  reset monitor, FAIL
  *             - no existing Exclusive Sequence for this Address, address was reset            =>  reset monitor, FAIL
  *     o if SNOOP transaction is received by the master for same address then reset monitor, mark Store FAIL
  *             -  if current transaction is not chosen by interconnect over another master due to overlapped transactions then also it'll receive snoop
  *             .
  *     o when current exclusive store completes, check for response. If NOT(EXOKAY) then reset monitor
  *             - if any of the propagated snoop response is erroneous then Store Fails, reset monitor
  *             .
  *     o once RACK is received, check if monitor is still set, otherwise Store FAILS   [exclusive sequence monitor to be deleted only after RACK]
  *
  *  - Another Exclusive Store for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {same-ID, same-ADDRESS}  =>  no effect, PASS
  *     o same-Master :: {same-ID, diff-ADDRESS}  =>  reset monitor, delete seq, FAIL  [ monitor > 1  =>  no effect on current addr until limit reched]
  *     o same-Master :: {diff-ID, diff-ADDRESS}  =>  no effect on current address monitor
  *     o same-Master :: {diff-ID, same-ADDRESS}  =>  reset monitor, delete seq, FAIL  
  *     o diff-Master :: {any-ID,  same-ADDRESS}  =>  reset monitor, delete seq, FAIL  [ snoop will be received so FAILED ]
  *     o diff-Master :: {any-ID,  diff-ADDRESS}  =>  no effect ??
  *     o diff-Master :: {Mismatch in control signals like AxDOMAIN, AxPROT etc. w.r.t. transaction issued by other Master} => reset monitor ??
  *
  *  - Another non-exclusive Store received by a Master before current Exclusive Sequence is complete:
  *     o  any-Master :: {any-ID, same-ADDRESS}  =>  reset monitor
  *     o  any-Master :: {any-ID, diff-ADDRESS}  =>  no effect
  *     o same-Master :: {cacheline evicted   }  =>  reset monitor   [EVICT transaction]
  *
  *  - Stop Exclusive Coherent Transaction Propagation:
  *     o exclusive sequence monitor is reset when Exclusive Store arrives
  *             - various reasons: load error, address reset by another load, reset due to store, snoop received to same address
  *             -                  other master issued txn, cacheline evicted, not scheduled for overlapped transactions
  *             .
  *     o snoop is received to same address as current exclusive store 
  *     o if it is known that, it will Fail as soon as current exclusive store arrives  [ Ex: monitor reset, no corresponding exclusive sequence ]
  *
  *  - Configurability for each Master:
  *     o ace_exclusive_continue_post_store_sequence   =>   address monitor continues to remain set after last successful Exclusive Store until reset
  *     o ace_exclusive_sequence_starts_w_first_store  =>   exclusive sequence can be started with first exclusive store post reset or Unique CL state
  *     o ace_exclusive_num_id_bits_supported          =>   number of transaction ID bits used to identify unique exclusive access by each Master 
  *     o ace_exclusive_num_addr_bits_supported        =>   number of transaction ADDRESS bits used to identify unique exclusive access by each Master 
  *     o ace_exclusive_reset_monitor_on_load_from_diff_id  =>   if a master sends exclusive load to monitored address with different id then reset it
  *
  *  - Secure / non-Secure Exclusive Access can progress indipendently => use different ID to ensure indipendent progress in AXI Interconnect
  *  - Snoop to current master resets monitor, (same no. of address bits used to check snoop overlap)
  *  .
  */

/*
  * ===============================
  * ACE Master Exclusive Monitor ::
  * ===============================
  * Master implements a master exclusive monitor, that is used to monitor the location used by an Exclusive
  * sequence. This master exclusive monitor is used to determine if another master could have performed a 
  * store to the location during the Exclusive sequence, by monitoring the snoop transaction it receives.
  * When the master performs an Exclusive Load, the master exclusive monitor is set. The master exclusive
  * monitor is reset when a snoop transaction is observed that indicates another master could perform a store
  * to the location.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * ACE Master Exclusive Monitor Rules:
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  - Exclusive sequence is started once a Exclusive Load (RDS, RDC) or Exclusive Store (CLU)
  *  - If master does not hold the cache line then it must load it using ReadClean or ReadShared
  *  - If Exclusive accesses are not supported then it will receive OKAY response
  *
  *  - Reset monitor if snoop txn is received to same cacheline (invalidation) for possible store by other master
  *  - Reset monitor if same cacheline results into invalidation either by coherent txn or snoop request ?
  *
  *  ? Does a prefetch resets monitor i.e. Ex-Load followed by a Load
  *  ? Does a write by other master WU/WLU reset monitor since current master will receive snoop invalidation
  *  ? Does a write by other master WB/WC/WE/EV reset monitor ? 
  *  ? Does a write by current master WU/WLU/WC reset monitor ?
  *  ? Does a write by current master WB/WE/EV reset monitor since it evicts cacheline in current master ?
  *  ? Even though WrNoSnoop shouldn't have been received to same location but, if it does then would master or
  *    PoS monitor reset it ?
  *  ? PoS monitor starts exclusive sequence with Exclusive Store once it fails i.e. not as soon as it is received
  *    unlike exclusive load transactions. Is the same true for master monitor as well ?
  *
  *  - CHECK: A master must not permit an Exclusive Store transaction to be in progress at the same time as
  *           any transaction that registers that it is performing an Exclusive sequence. The master must 
  *           wait for any such transaction to complete before issuing an Exclusive Store transaction.
  *
  *  - CHECK: If monitor is reset then master must not issue an Exclusive Store.
  *           This prevents issuing a txn that will eventually fail and unnecessarily invalidate other copies
  *  .
  */

/*
  * ======================================
  * PoS Exclusive Monitor (interconnect)::
  * ======================================
  * ACE Coherent Interconnect maintains an exclusive access monitor for each point of serialization or PoS.
  * The interconnect can pass or fail an Exclusive Store transaction. A pass indicates that the transaction
  * has been propagated to other cacheable masters, but it does not indicate whether the Exclusive Store 
  * passes or fails. A fail indicates that the transaction has not been propagated to other masters and 
  * therefore the Exclusive Store cannot pass.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * PoS Exclusive Monitor Rules:
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  - Exclusive sequence is started once a Exclusive Load (RDS, RDC) or 
  *  - Exclusive sequence is started once a Exclusive Store (CLU) txn is failed
  *  - Master must register start of Exclusive sequence for its Ex-Store transaction to be successful
  *  - If no successful Ex-Store from other master once exclusive sequence started then Ex-Store should PASS
  *
  *  - Once Ex-Store transaction from one master passes, registered attempts of all other masters is reset
  *  - non-Exclusive transaction has no affect
  *  - Ensures that Ex-Store txn from a master is successful if that master could not have received a snoop
  *       transaction related to an Ex-Store from another master after it issued its own Ex-Store txn
  *
  *  - Exclusive sequence is not stopped once a Exclusive Store (CLU) txn is successful
  *  - Other masters can only register a new Exclusive sequence after RACK for the Ex-store that passed.
  *  - From reset, first master to perform an Ex-Store transaction can be successful, but not required
  *  .
  */

typedef class svt_axi_transaction;
typedef class svt_axi_system_transaction;
typedef class svt_axi_port_configuration;
typedef class svt_axi_checker;

class svt_axi_exclusive_monitor;
 
 string           inst_name = "";
 svt_axi_port_configuration cfg;
 svt_axi_checker  axi_checker;

 /** Variable that stores the exclusive write transaction count */
 int excl_access_cnt = 0;

 /** expected exclusive read response */
 svt_axi_transaction::resp_type_enum expected_excl_rresp[*];

 /** expected exclusive write response */
 svt_axi_transaction::resp_type_enum expected_excl_bresp[*];

 /** flag for received exclusive load transaction error */
 protected bit excl_load_error;

 /** flag for received exclusive store transaction error */
 protected bit excl_store_error;

 /** Internal queue to buffer the incomming exclusive load transactions */
 svt_axi_transaction exclusive_load_queue[$];

 /** Internal queue to buffer the current exclusive load due to reset of 
   * address by incoming exclusive load transactions */
 svt_axi_transaction exclusive_load_reset_queue[$];

 /** It sets ID to 1 if exclusive access at any monitored load location
   * is failed due to current normal store transaction to same address */
 protected bit excl_fail[*];

 /**
   * Indicates if an exclusive access is expected to fail because of
   * snoop invalidation
   */
 protected bit snoop_excl_fail[*];

 /** * It sets ID to 1 when matching exclusive store transaction has been received */ 
 protected bit matching_excl_store_id[*];

 /** Indicate phase between a successful Exclusive Store response and its corresponding RACK
   * during which period another master can't start a new exclusive sequence
   */
 protected bit successful_exclusive_store_ack_pending = 0;

 /** Tracks in-progress exclusive store transactions yet to receive ACK for specific cacheline */
 protected bit successful_exclusive_store_ack_pending_for_cl[*];

 /** Semaphore that controls access of exclusive_load_queue during read
  * operation. */
 semaphore exclusive_access_sema;

 /** Semaphore that controls access of exclusive_load_queue during write
  * operation. */
 //protected semaphore exclusive_write_sema;
  
 /** Timer used to track exclusive write transaction followed by exclusive read */
 //svt_timer excl_read_write_timer[*];

 event sys_xact_assoc_snoop_update_done[svt_axi_system_transaction];

 protected bit no_exclusive_sequence_started = 1;

 /** specifies the type of exclusive monitor i.e.
   * Exclusive Monitor at PoS of Interconnect or inside Master
   */
 string monitor_type = "pos_monitor";
 bit    part_id = 0;
 bit    part_addr = 0;
 bit    secure_mon = 0;


  `ifdef SVT_UVM_TECHNOLOGY
    uvm_report_object reporter;
  `elsif SVT_OVM_TECHNOLOGY
    ovm_report_object reporter;
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename( svt_axi_exclusive_monitor )
  `endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log log = new("svt_axi_exclusive_monitor", "class" );
  `endif


`protected
T&8Y.M.f@Vd0#F9YVd#g7W\O(cL@.WF.H/ea=cb[MSJ;#4</DX287)3Nc#/GS_^;
VFg(0,,bNI#FLQf?=/&?\LV\a-F1ZBD?9+ILH2L=R357N==<_fOK)B_NE7ZVcdb3
]@FJVJMN;c\Fd^W-fB1g:YdT+YMU\2D[f^:[;ZWe7N/\=&36eA-(=4335fV&0R=M
Df\UdNbG+U&SYNe.W0Z^c:d9JXb@(>FH(Ub>@XLL?;7f=2f=<88KC50Z6f^AA@f@
XU0-+W;JHL&[:@^T(LXLV6>QPA+I_\70_4^W:.H>W^>(f##K97b]S<?C7&[X.5(I
C[P4DDBEA0/1F@e>;8a&cIXU7eCMXY=/&-@7DfHD9FH7gGg57+>-c=P4CaFS:T/G
BL&-=PcOC0WQ:3OXXDVKG.&68N#]:U]W6K,b_Ce6JS/1f4eGLH.3/:RIQP5SY8FF
[adTNd)3EgY.H:F<\OW0E4PEBE2.>WQaZc_.11cT-^Ob#V)dB4OC?(V:S[Z2a-/B
E2D0_A^0MJ57J?aOM(_(?1537]a7+,<[.+N3=d9dOG8U3<&1LGG<_:=I4c[4(GZ,
.EB1Pg<(d-.@#5J?RAEP/<L7BG2,f62[bB567]7&-Tgd,=1N&]L>#f0g#G&E=PFT
W3d?S<PQE-Me@?-C)/4(G&07E=TYQ[cS:a?(UScJC?-PB\RHC&DP7aPKH]QAcP3d
-H__#]Rd2C458H6b3ESBDWcWL,3;ASJ4N<M\SZVQ2OXe_H:G+2cN&[3FX@=<;K5K
b-<2X1OTP@7(-aNL?]SQ.^C80fJE@GOB3>/G4Z])KBRKS0(<PggI[7RPR>1OW:12
I)F&WF==QFgOES/ZY6bK\dH+T,7d[]#5HP@2eFgb.I\DDZ_P8@FD/Le&+#O+)4GL
gX+T6-O9g9dU>(/bRQ_f:<[=?,d)RQHf4gaK+TEYQ8J240=L>@b5EFB0+W@2-dcR
1=g@c3cgC+Gg6P]_Q1eZ5(6XS2]&c/\60_:>:Pf6)0.,g71N22a:#V9C+:B(U_>C
d6eG/]Y^f?G7AXe5,7+X4G>G75ENaTX,L>C4P9]D(D]_^?V@N\T\fR0[S[b;5O>8
6T7-\T0&2K-6F-W7Q-Q/Ab@PW_f)QMF[M@T(f);:Ye#AeQ>g&V_e509D9\:AN,^(
#=Z^R:D9H)DX#[@PQ_g7.U52HK)IJQPPK)cf^&,2<bae4464<:/A^[-4XDKSeXZH
bEJfMH^/;]7gfB_a#(:0]4d53Yd^I.CCg??GG[8DdBA^,#2d+H^QIc2YZ3B<LgUT
E)E<<R=_?4Pe;U#-=-7&=]@I29XPNg=?E#U^C;e#8(Q8\7GM:@<TSI\\720A6aM6
L88>:[b)D1(L[HGb0[9N)Z;5HK)YK4R_XTg[cUDKJEPC:2=60\D<(28##OMW3G(#
gc<<4cON(^:e3K:eURZ30&/+g<\:Q/D1^e^79aW8TONWX:&>/Q-M(8[ICWS(]S1.
N]/8FB2U2>,&T+?ZFbaeLH<58JTF=U&=LT4N9NgF5Q<L>27YR3/+;J3JGKK>V>7\
S\LAD^?UL&8X/5QWc57DP4e28aGQdB)_eUX0.QK4=5.aY6U;6(IDL2P@OHR]SUHE
[BW1;W87])KFa9=_3P6Y-7-6G+,>aH3:\O;PaY22C>7?_Ia2e[D.KZDL6Z&BG)&W
fd#0(a^d&@6QU4/)0\,4YEbY:26Y9TRK@$
`endprotected


 

  // -----------------------------------------------------------------------------
  //                                EXCLUSIVE PROCESSING BEGIN
  // -----------------------------------------------------------------------------

  /** returns a single unique number from xact ID and ADDRESS */
  extern function bit[(`SVT_AXI_MAX_ADDR_WIDTH + `SVT_AXI_MAX_ID_WIDTH - 1) : 0] get_uniq_num_from_id_addr(svt_axi_transaction xact);

//vcs_lic_vip_protect
  `protected
3S+KQGX3#>):Z]I3\P3B,#JE2[K1U1S=EXKDZ6B9WJ;_3U8.^[X93(GL01/XRIf9
J&VVEC?K[SSfQVWXfeOSAf?Be#RJF3IX90N2_(8fT/OFPN_BT:.=YQI2E[/;(Kc<
R4\3O-]-E<3-]0G]U3(UH1AZD.L+YHdB1b=+ZdD0f?X3f6:&QXZQ8(Kg=HA>]R(I
JdXG3I<12g_GeR70XCC=<c0EODCF6_@([T.OF\<>=TL[4#\J@6VHY+^GTH&:e,6C
<I9;f\>fL]:5:@?6QL_)+b;QDRT150XCAf-P_7-ZOFMUYJ_NLO&T2#[UE,);_7be
e,WMb/]D9(65UYAV[J<#J_P\#(&/\Eb+>>>cVV7#[WP12O96J2BG#V,@^McCeM&-
1TLdd5a.37;L3)YCR/Dg\f<;?P51WQT)11ee_^DEW6EYU(X=6M2L=NOgFCMXQCV(
#(4..@>;;254(I/+b[KAXBR)>8UJ;F0&Dd.PbB3>8T,b#R=M2)/0#L2OXS7UE]R\
_6CPSSgCT0_TNRdC+?M>U[2T-+YI[>XLNS+T3CGTS1=7bDE+XG16f(&.K1R6;(7@
@c)-=ZZA0S=^EHZ>WISVK/Ca3f6^(+.V0?R)09D.,F5Y#aP[PWM\G84O+g(6&8NP
NVD]Z)IcXN,aX&.-,G))K9Ca8$
`endprotected



  /** It checks the transaction with the same ID stored in the queue */
  extern virtual function void check_exclusive_sameid(svt_axi_transaction xact);

    /** Pushes the transaction into exclusive load queue after all the data beats
    * of exclusive load transaction is received
    */
  extern virtual task push_exclusive_load_transactions(svt_axi_transaction xact, string kind="", svt_axi_system_transaction sys_xact=null);

  /** function that compares the expected and configured RRESP for exclusive
   * load transactions */
  extern virtual function void perform_exclusive_load_resp_checks(svt_axi_transaction excl_resp_xact, string kind="");
  extern virtual function void perform_exclusive_store_resp_checks(svt_axi_transaction excl_resp_xact, string kind="");

  /** It returns 1 if transaction with AWID = ARID exist in the exclusive_load_queue queue */
  extern virtual function bit get_exclusive_load_index(input logic [`SVT_AXI_MAX_ID_WIDTH - 1 : 0] axid, 
                                                       logic [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                                       bit secure,
                                                       output int ex_rd_idx);
  

  /** It monitors memory location for exclusive access */
  extern virtual function void check_exclusive_memory(svt_axi_transaction current_xact, bit is_snoop_xact = 0);
  
  /** It monitors the response for exclusive store transaction */
  extern virtual function bit process_exclusive_store_response(svt_axi_transaction excl_resp_xact, input bit excl_store_error, string kind="", svt_axi_system_transaction sys_xact=null, bit only_check_excl_status=0);

  extern virtual task process_exclusive_load_response(svt_axi_transaction excl_resp_xact, input bit excl_load_error, string kind="", svt_axi_system_transaction sys_xact=null);

  extern virtual task check_exclusive_snoop_overlap(svt_axi_snoop_transaction snoop_xact);

  /** 
    * Checks if Exclusive Address Monitor Set for Exclusive Store transaction,
    * that is, CleanUnique Transaction.  It returns 1 if it detects Exclusive
    * Monitor is not set, that is, received Exclusive Store Failed.
    */
  extern virtual function bit is_exclusive_store_failed(svt_axi_transaction xact, svt_axi_system_transaction sys_xact);

  /**
    * Checks if an incoming Load or Store Transactions (Coherent/Non-Coherent)
    * maintains memory attribute of all currently active exclusive transactions 
    * for a specific address. 
    * Attributes that it checks are - Shareablity AxDOMAIN, Cacheability AxCACHE
    * This means if a location that is currently monitored for exclusive sequence
    * then all other transactions to this location from all masters should match
    * the Shareability and Cacheability attributes that have been already set for
    * that location.
    *
    */
  extern virtual task check_exclusive_sw_protocol_error(svt_axi_transaction xact, bit shareability_mismatch=0, bit cacheability_mismatch=0, bit use_semaphore=1);

  /**
    * Updates pending ack status flag for current transaction. Once called it sets
    * successful_exclusive_store_ack_pending flag high and wait for RACK/WACK to be
    * asserted by the same master. Once acknowledged i.e. RACK or WACK is asserted
    * then it resets the flag and returns.
    * Typically this method will be called after receiving response in order to mark
    * the phase between response and acknowledgement.
    */
  extern virtual task update_exclusive_store_ack_status(svt_axi_transaction xact, string kind="");

  /** resets flag no_exclusive_sequence_started to 0 indicating that at least one master has started exclusive sequence.
      any interconnect model or system_monitor should call this task for all exclusive monitor when it observes any one
      master has started exclusive sequence.
    */
  extern virtual task reset_no_exclusive_sequence_started(int mode = 0);

  /** returns current value of no_exclusive_sequence_started flag that indicates at least one master has started exclusive sequence */
  extern virtual function bit get_no_exclusive_sequence_started(int mode = 0);

  /** sets value to exclusive access flag */
  extern virtual function void set_pending_successful_exclusive_store_ack(bit[`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] addr, bit val);

  /** gets value of exclusive access flag */
  extern virtual function bit get_pending_successful_exclusive_store_ack(bit[`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] addr);
  // -----------------------------------------------------------------------------

endclass // svt_axi_exclusive_monitor



/**
  * Checks if an incoming Read or Write Transactions (Coherent/Non-Coherent)
  * maintains memory attribute of all currently active exclusive transactions 
  * for a specific address. 
  * Attributes that it checks are - Shareablity AxDOMAIN, Cacheability AxCACHE
  * This means if a location that is currently monitored for exclusive sequence
  * then all other transactions to this location from all masters should match
  * the Shareability and Cacheability attributes that have been already set for
  * that location.
  *
  */
//vcs_lic_vip_protect
  `protected
Cc[;-C>ZTQE)X^aCO0C:W1Z(WPGRFTE1>9N8I(07J8&4#<7gP.]91(FD8dO^:7WP
V:SBa6@PB(B]?]WDZAPZeZD^dF#_O+UXH+#C^>Vf2:=e4I6M0_8OOXCN.NLSK(06
HHWB9Oa>c:+@SG^Be^6&J/A1COTZJ(<R<d2S))_]DUS5dIBS4YZ?dC&C5Y?)WgeA
;gB41FD99>+>RB\I5gFH_1HQ04Q=)U,=)/SK2,CQ^=>D/B91Y.YL)aMAM^a^ffQ-
^9gf:6[0TSe2^bW?P8O2&@)KC]=7\HM(6cca(;,dZAJV0NA-EUUJbA5;5C71fR]N
Eb5[;-b(CX(0[a1aDf=?VfgS_Kg>;Y(J>>b;<fHgT24^c:1>[9+#K51\5EX_[Z:W
3:YLd4cc#8@.[O;EU@5e&1<OLK3MP7BQ1POdE&V^a:bW/>J?EM9@AaBac;g&Ca>/
QAg)CW8TS@+[._\+W;8cTc6]9QfP+BFF+OdL[;9/d\2W1,BHKN^fF_5b33c[Q/ZT
Y3.6#36[f42II]0/SV+O8+F-O/CF@DP2a4<VT<[W1_d-4Q[bULCM(TCP-J^3cd4b
I0f](3:RQ9g>b0<GJTKWAK4.]F_AN1UbZXHN=0_@A2J)dK#dB8d#@V9T9H]L1(38
.2L?/UU\_:M8I[4;\<]=8\9K)X/XTK;U4bNALA\NTf-CVbW[ceU3(d9?L2fg)6^Z
P1Q8-Q[@)_NI8df#:HHG/#2Y-JF320XQ-W#>WXZ_B3Vb=GcUR@:E+3&)@U<[.5.6
dePA7eKN:BAcON:,<2P&&_.^<+af7b;b<]JU6HH&DE2eO[S_S5@SeN6Z=<O^?KYJ
AS2792CL)VS[e.-M+eK:T5-]7UNLYgV\(e#gZ2LUAFJf=F61[V4Q17??BDW#2C>]
^:A5-AI(6NDFXcf#R-,-bgS2J#/PDc^TFOT6X^B;WbB)F?WK.d0FL8f&+>?5I(,;
0/E68YC?4<G\>a5#a4^;EHUI,b.ZR=_Z+GF9<&+4[b6F(\Z2(_@]&dI<?FT)bC6Z
?J==UVL_/:(YX23K0\1C_=[L>O_D.G7M?g=36,?_-\?)[33#I_8VV8\]Se1?QaAO
)d=E7A7BMQ5K6?gC^2?7L\^H<>(G@),,1IO/USDZ-:?8TC[0+Z+PH;F[Df_-B<5H
EKGX0]PY#QR7U#EgB7Zf5,(33e@=(+&4^H&U&0DI/-C<F^d)Mf+O80_E;PN6D=VC
ZC\^.c+X1T5S^LF6G)7OSPARW5<A>MGIZUF,2#+f>-2:6P9U,SacF/<S<@B5ee,?
W6]0U^-Yf)U[V5_SM1C@)=.ZPOcK1739[BL>&KW[3=I8Id?=@Fddff\f-=PRMe/9
WW2A:Ng)g@0B&DGEObLYL<JaWYcDEFO>7dGI3/5[+4MK-SIP-PSX^:.-UbQK5>15
PeM(8\fAK)[8WVPZ[gG&e#E8[5W,(7XLW&+Z#@B78;@F/QT2aEcA<Y9HX=+O0d1F
Z<>P[G6#Va2Eg[#/++N3-K_L0+#A\WVJg.>24(H;5(719B?PWP-TXD8Z<4D=g#1I
-J^[aEaZ8R2g7:<A-OYI@eBY5V\6Gc;,.(SSBR1Eaf(4d&@CXIQ-2]H.XF;aO5Uc
DP]87UUd=6R_L>a(fL3&cea#R6Y@Ne9@THE/Q;Y;6;M72D9_07,L/Z&\g]F-G+M3
IS@J1#,<8,<H;4/DeHQce?9PIXg8Kfb8JWeT;G-)AMTUW#@H#R.\4[0<(BUSB5IE
b&=;E/.E)bfO5PPC(?AXc<RRJ(RaW5E)T)^^JY\eJ.LP-;(M_35#C1=YC[,NcY\,
8+.]WJabRB)a^7K_FQg0f<3G>8/(eEALHfFaW3eO;S.8RQ)5ROM-c>N+1AA]+L[_
FKZV;6WG.Y><H_5@;18NK&_\I_INT-WJ#ZCS>AZ;]>)VJ.X&8QI\O^>PEIR)a<C/
89)7GZgD4P?De-C->5C]bEG4&^&@ITAdWW0#.N5@53]D-W,^TQ=47@[LfV#Zd\QS
XD<R<geGZ38QW#=E.K&EK&RW/HB=F@;(=+U:7R/=AHR6UPXXF5S(W3>Na]F_0UcJ
RDC:_>7KXIC1@(<1&N0UEN>d4<9/_,J9SUAK6?g,N6]^a/5+RZAY-ETG(GBVJ^JS
X7LLPUd,/6ZTF,27#2H#+TI?cf&@&NbbGH=-^A.+7>I]E98OER7?)]3A6a0DO\D1
-5\IZ0]29eObaR#0cV(;2F(K\5_=b#f[H_FgUS.4C0E&-.J@@e>\eZY=egU/Ra0f
bJ1>a#00dU^:RH@6^XWB(=Cg3.MW1<a?K[JP&(c1@7XaOa\:/dW-C3YE#Q=,_c;I
PG+1CX5GOH-R<#9acM:OG(0>T(E[]RDXPO5^9EOTA\X4aNU[f63b&:UJ2/T.8I7\
f]M7VZE[SQNQ#0W([(GYIR:()\d[94\SOgJff(:R;-]V0;B0(?A=5a+YUE&G4K.:
/gEA6/UZ99SF&XgLd=bY&)#L8P,C1^Ff8MUNHbO8B<<^Y2<P4W&]aD-]1(Z/A:HD
#+FZZXT^FeG[E3WQKMaL9F8W&_Cb(;fLLQLKKeD9LM)I/XL8>e3.ZIe481.D-I#[
/=dL2JW6R&8e8T19bbDJY=T4[0E#4U[^DK9\bTDYF;2g^39V/O95g/BeS>E[P,3M
JH8e@,dKN+5eM-Ce@49[^#^>@JF>+Wc?d:#aV^B32M]F<d9a<E>+)&b2^B,X^>@;
DU=FNKJBV#UBe(FVNXZE-HV#8g[bOc7-^:9McIEX.c@F?:LCQCBMQ-^C.RFU5=(R
SKJY++O^RWHa.aB7>0WI;<W8bN0,b_&FN6,XJbIJ)OWZMJ&Xc^A<ASV0dHQ,#HHW
Z(GQeX&681cFN\SXD.d28?-4]&EIQ:B;5E5EfJ\+IPa7LK71bH5TIbUT^XP2LZR(
Ue\-)@0IHQIKDA=L\:\UU:M9OQ3VS&5DO?9C=26J,57HgN226V#:XP/:57#HVc>)
;7.a0>[N;_6,I/=K^WR-0bXGZENOfRHFJZZ?;X]e?FN(7F:HIP/8S[P):84FR0L8
>4/9C3gaeE;gLZZd?J4_3d@?I/=P1(X?>Bc3g?6^2.AK@[+;ANZ7/8cacgNI/CO.
D4NZX^VP9TcUaU\L/e7J<B1D2&>,;=9bfL##]a,&MFDe-?_D^-#I9R-IK?+gM_EN
EMH?X@;OX-=?+bMS.4H=b\2<H8:K+_8aScCL>>@6=0>H&=?K:)E6?bL_][FWNCAb
G6#dc(QH11WY>9SfAaC-bBT9+;(]N,CIC&7WY:N9-[I5,-C]-RX4LX;2]g[_&\+e
L]L0T](K7b@PNY+G=OHdRUKQG]JA1PX2/5aQX#;346^]cH0caa8417D0S>Ga0agK
@F_:]a\M.7IQ<\?K)1[VDHF<ceOA[,gW)A>F5Qa5a24C14N8I@\IT:)&^S<RaMQM
-7FYeeK55S&E_N\5B1-;NZ#<OK[0]<GA^\b]8N,,B?YT(9K;#FK;fKF2<K\TW\\0
RC&..R/A(C_R@95CU2X?[(C1:H+(D<[<-a8-RES_9LaU4dBS-,gRC9V#>7^We2AG
\9MW>AAacMH9AQg&GR-cQX1C62eXWfbMK:RQ9>\&FF2U69f&D2=IQ-3#<:?f+4SE
Y-^Z28)B:)^7CU,TLK(EIGUL09:&_MR8,(<O=9XdAO])_LJ<b&F/]?e+M<,+bMe)
Xb:60)#\8.ACQ=Le)JVP57=5RHD)4BZPT<R/JBS?;]82428D+=#UI#d(#F4d#d/<
_XS@+A(8B5e>5?.cI?8VN@ER-eZ93KMOG9DZ2=Z\4[>^eDDB=OQ>P@&C:6IX1L?H
2XQ@[]_==XU5.a.FHM#E73e)MO-]ZDNS8Q@(<LB-;.6\A>WXfa[-8AgHRga2,S.g
9>8]0f:gLUW(=P4bdBLIB=@I3<a#C</1g78HLP1cb&cI/gHC12R_U))=fH@>2#8f
DN5fLC^S^gUKQ;=/GE(_B<#P56O<(O\ff.,VHg;1b-3J2>Ne[VGc8NBJd5U4LZGG
S8VO@,QD&L?D+>#9.4&+@-a&,NOJ.MX7eJ:EUKY:;;K4O:,MZ\(M(?Y13)_cGXH7
_=31UQH#<W+\<9L,@,_@<f?5X0SM1PF8:Y-K=(.f38e2H>4=87MQ<)N;3&HQ<EB3
#J?ce9DY>TJSYXKIQY^:>-d@^fNF<HTEZ65EG.L:G\+K#P^^6c[UNGdZL;X<Z6[P
+bX[6G^_3(V)\JA/.-01Z(]46&D@+(1BT5RX\O;NX/51LCFOAOcO_\_ZBJA2HG-4
4M4T9:7^]Z^W>9>.eHPJZD#@O=b7(4<,G\\fI_:TTC8>V[bgJIe(I0Q.b7+?P&>2
9D#9=<8L->I6_?D[8=:GXG3C8Ge@g5PF^(IL_b4S.KY)M6G+MMP=<YWaVb(W6AYN
/5_O1G:?YTc2<e9<P<5+MM^IKA/(A9POU[]aS=FC::U+/G7=#bT4,K^_)P_W0,AK
+<QOOa?N;+C?<792SUROdgbf[#)5A\==OKFFT^6M.9@<Lb.McafQ/@]PEECIQM3J
(R7R,f&27=L=X6gJ8M&EbS@4\UD79/fVHJOIG]0O+cRcCe.FC-9\(4017->,50P4
+4dEP]T@(>7,_fg]ZM^LFZZ)OC1@7K?CI4Rba#1g#=.4f)5AOR7GcQB-G>(V:ZUD
UeQ=WL_X^H8453?3\SH17[G3WB#C00c\@[T5&+1(HOL:7#]MF9CJ:f=7QZW2N\5G
=@F40d&)=U.FGKEVH7NX0<[TY6ZH^SV#YOWPV^d5+I74T0dBa=<8Le2F4F.M(S#1
M\K_ZH8bL;XPY+YSZ59gCGYI<1^18<ZQ-./X8I(--C6TH]WV(MW[A:5,SRH\_d@#
OFF.9#0CMagQ,cO1]fEOd4c1a&[NNPE2QX2<88A=;IRTcfAVV=WL0_Q[HV8<3;D8
-.QY?bNMFZ.HIg[L6G)0^O^J;)=ZR+Te@J<c=2DU5^-bL_1)[cDR&;NOFMVfXI<Y
ANCGM=_.7?96K/gPO;8S>V+0(S#_#]0G1Vdb.2<K8^H0Fdd[-@UOP2;34ACQSF6R
)L<dP?-5DQH4YP.Y4I);EK5G0NFALCV?L>c6EX#DHe+=CZ&[gTcCISNN+:1UeCa+
6cU<)c-KGQG6F6DeV:J<f4dBc&>[:55.ZQf&<BaH84R\2YMBB@a\)YOW6\=&0<<R
6YL,E//R1Zf/2O2Qd4e0JKOYPQLM.gNa_.VN@)PEP1FJ/N.Q8DDU(^ER64?E+LVJ
RH^N+JGa71PH9C<C:K=P_08BW+GcDRTeTYbP8E>g&Gb[9fB(2GfWLD.M1)5Mc>[A
WP.:(:8,FHTW:P4LUaG;E.XACdNZLAcYD1H:(F=a.X.]K6-[81([MV?(50I,U>RC
V-8QBWT3,M^WfO/e5g2M58:0<Xgb<LKV&#16T8X?I[?cC4Q(0<g4Ld^TYB;@+c]F
L81S\=K=N?T[S5ZPTd/)6S,K<0aH-QaZBLH-KP^]P[TYVVG3&H8K\8>OE;RRL^M?
fOAGL_5X)HVX9GT+&_HfgIA.(L6M-V23&DE.,#/1(L3NL=eRbD<fF+A?LWeA\)OS
L+:._TQGBBGZ+[>Z-;(g;eSZ;c6.G(.=C7QSKD]=7O=,E0-=/e#;\g49>5)SE<I_
G/,#ZSTDcfISG0Mf8AH+9DCOQA[-;5,_>K27O(#^UG)#EW3_;U;[RS5T1PN1</#^
IgDA/#/(\:A5VK?(MZ7c..=cfPeeQVbCcaAZ&Wd2\2U.4Td2X8(/2G9LB.B)HWgC
=7BX_AVeA1eI.&&KTIF>.+VB.e0Oc6>UT)gQbHEWe;2B0g(g=][#[-a2\,/8\.Q_
3E>K,).5b0TgF<G^R=UZgCa+G4GZ0-<U,3^0R+G;;M(-J,+5+6W?fDF[5[WRZG/b
\D(/9e;O]cRK4GC^d)4[&714JXMAPBX8>BT43VFLYKDT7Xa^Yfc?cXSVRMEAC1A?
155-_YPb[;7BCK8LR:_R)9-dfPf0SeL.Hc<1?QAZBSXgE7K7K,F\D8RB(L/.>?1B
93#4SD:d)6Hd,aNe/bgM\;LNTWB(R./(1\#ScSJ,DSVR=@-]?N]Kd5:B>71U_1EG
/Q559D#dc#:Z.<5bFgaSQU7^.AXZT7b/e=08860<R6:?=./I+<;MS[K]e[I@5T=f
d>^2(V[(2H^BaH2Xc>C&O3EHcW00(URM\M=aYI\b?Z0LgZOEY=ANLDCH/(.4WG.T
KXGYER^Ted5?Z5RdfD=C^3;W/(.1,>e&ZG(S-NJM)CU/D75eI15RR]5&8\=RA&V+
M3b8JOX9#K;_K<.]aHXG5VBIQ;()B:f5@]IIM^O&7U^GLW;P[dB:8)\O9D89YU;g
5)E-ROH^BDWD>(2+gJ:>_&fQ0:Q=KE#g^,Y2;MW>9cC&VZ9=_Q=P8E-2#Daf,:F^
5_::O.7f[+]].[>/K\N=?1N=I;86/2CP;P-./Z00^OXb2_EDI[B=C3Te#A#1/bI]
V=f1@X7^+BFDWX.520>_>JV2Wd8eW3>2Ae0&>Y&bIJ]1H,Z3H&2_#0NJg3e:3EGW
_f.2&[aPO,K6I+7)\LTJN21KFV=-<[>T?g[#VR9+Z=Y9?efGd#,aEOg6b&44I@^5
Z85&e=4;@SD8NF,[-+b-#93SZ]S(P8^G30AWcBL+HbQ<1.>HV-JGdL]dE-7<\cXc
YS54&;A0E/@e5V@3TOZ^V5L_7V21;aFPge600b#B_41K3CGB0/I>+-f2#)50De0Z
ZdBYG6R@UMG\#aE-_cd6QP2Mc]4#^+b2T\_WTA^^.4WKd;EX8HgDE[ACb2XRa-.,
M<F=X71?2S@X)RM@4E;bN7O5T2&58X_AD\ZVHEDGg8))>6YR&L9Gf&>(V][[(U53
B;/Pb)c4X/LT[O2bXg/RcF07OUXZ&ZAP3#PT0HQg<f(VCJ&1e-[_)TfB[Ta5\<Bg
-<G^:<G_R_N7=3VgS2B/#VS8cAVYB8DPf^R@4X;3gF>9QV/RAb1#eHO=):_/I/^9
;I-,\<f3?;3ZQ#3].H,72_WJdYP_QO@?)L3Hda[OQg8/J<eG4<:VU2gRRWG^\J(B
d#X&dX2T66LTD-8[]Q&?aIE\:+V.\V,CB>W(\DZ=682>0AL0^WNN;3,ca>EP@H1^
VXL,<D:+.F+;?L.OVX,+\e]8C+]P]G_Vf(EOSM\PJCX4aV]K.EX/^WE,\C+O9)T[
P.:E3:M3;6YFg+BI5+@TA#>QN96U>2142LfcR39M:A8_.d(I(Z:d;d]#G:Cg-7<5
.X6]UQ8;GYVbJBMaG,]#A<)eR&VKD.D=IVQCGd>L.C^fP.AQ9&]M1FVV4HfF0\9?
JcdBV3NUG8&BFKUDV@EP9bC8\^F4VN^,_FQL^BQ;X)L:U>/)R0eYO<L(aV3J#X;J
9/W&Sg#AXU4IXJdaMSXd[@1MC(\9O5+(5Y;NeU8CA_IA>cIT1BHRBQIY,RAW(VSP
c/+K8^g2YW^SW8<f#f?A^ec&YN_g\e/a<K5e595-ccQXPL:Qc<(BAUeQQ4#Vg#Tg
8TR+WTIE8WN25+-_CLEG9G^bXYZ9HP1U#>f01C>Zc,C)_6PfV)7?..VN\a#(MN[_
eN1OO5-?7FH(4S>G1,L8Q.X?QWSWHU3Ld&C_2E[P+d>A_&66VRH&0e(/)(<#bc-/
;T(JgeO]>7Se3d=^-OD6acN<0dQf\_R2FMMMgB)^;H)4+;a]:\,T_c6PK9e@Q;[4
1.\=(9IEfJ5=>5+LeFIXDODg5/aQJ,G(cBOde@WRS3b?\,T&;LOIL[\A?1V;G^>Z
d0+7\IYZ&=,g[(UAMc+0:_f5-X8<F::T2(:I-d]-3/FLHV_J?T[+-47P:(O0;40-
.@Y^Q0BIc<(=F>N9XeN572eF98C=^O](=CaaE7Sa7GBEI2b&BMV)MEMB45;\eTK_
U/VcLYBN<V8(-JXb?C9VF:V)NTCM,NCfc+FZ/GcJRX0XZbd4^-H@Yg^,@_>,,37Z
U5PHVISF,STdcUM@VH#a+P0427EOHYde(&+GBC8DZ?)#caVCW(;5#(M&OTY\Y=6H
9K4fR,^XO+)[Y]]>AX(H@3d^OL[03JR1&GQ\#D<VD5E(N)8BDcVX@I=DE79)>-M[
\/G8KZS?:32(.3GQUGTYS\=Fb&^/Z4HV#D>H#2@\VD3cPL#Ac=B_/dXVY4N=1T]a
9CQONM<WC0@:UKILY<SK:B&XV52a-#.^O1N#I^T[\FWH>29;[9&4P5:+V>f96Y@E
2GI;9>K(,E2UP_GU&_<9e8]ad+,AET(K25ANfb@#O_/4W2@]\/bAMS+;<dE7b@N<
,]],dHH;]<[UPG,e=[8LA&-AODX;XJ\42BX:IM\HTF;+Nd0e2@ZH:^8]^A.1RIfe
=,dN?2:;.+W1/2#[:]KgKM8TfI=ebK.NO-EMZ))dQZOC>^5Db-..];e=\&N]ER[O
B+:TO1XZ+a/P9NcJDO;d:&_gKLC4.Nb(]Ng:#g#e93.EW<BgR)ebS(:>(/@\&,VU
a(L_b<=K+CWMa)SdaH^T1K#A\P.IV;&.K>^=DICM47c4&:)H>+YfG-(c\(P990Cc
.(2\/&J_DeP5;#bQ6K(:/HMYDd[5A8LJ,.)0GJUPA-NO^B5VM>PZ:2-NS-H3OBcR
-MOO?>Kg4Y@H;>L6YMLc&-QOK.Fb?Z7J)]J^Ed[0a]]FG&Y=3MP&>U86gWS=4gO&
<:<\4T:&3@><PPgCEW7;ZXM3Q^RM0Z<1W(:eWIDC.P&X/J]HJH[2LB^I5(DMIWR,
Xe>^2:TP5cQ]WU6c]CfAa_=Rb;QJ-;(</8BOK&=>Y4RS48E3D;?G)^a?Aa#2Ag@,
F),LGPW#c3cfNSe:H2NYg6g#UR>IM,gPNdD\Kf#)eYIcQZO3<c8_=&d(.@UMdP?E
I4;S(E4C#DIK<2QIX_OZZYV9R:Xdf2f32=\H3?.IB2=_5Y2fYb:AV#,Xa\b3PL40
:bUZTWb1G7YJ1\+>b?[0XCR^aOSU1P]IBI32\1V8\bVI+\&QZO<9=Y&cCTOR:V6I
F1:YagDb3PggA7>#R;:e4J>Ac.]LU\eMWf_VGIIEN6Z6OSe?M^W;G?-4S/fW>=Db
@FE+040GDQeY(TF/d>=>447,AA,=W#>#a.F.7a,+6,6De.4Z.(Od\=WAT#&/5E#P
ANOL6fP>Ja.+e+>gFK0agW)M[1OWYOO2]ePd.94LTH(N_9?S4TRFT^@BZfZQA<ZV
GU@8JZ:.8[2^1a?M?&YDF)<&FbdBJa&X#_=WQ@fU1c81(68a_Y5^QJ[GX7cfDW;(
7:/Z:JBIF=3QG,[//DcePJQ.5SS-)USEUWe01gZVBYe9F/J3H(cTQQa+1WL#GZ?N
E(fS)_:0A7[4#fHE0/(DN>;KaMC9@RPRMcgbVM,(>\LAPLaf1gN#?@<Y:<cb0J;I
\A=b6UFH/\X\-CCNL&;7.A-0M9/bJL>ebLA2LAV,LOD@(f<1WPR?OLHGW)/+>J,[
D.ETSU,R<HF[Y-C4;XJ^+9)ZW[7VU:&33[<RGK)300/fZ56(?UPP-V^YL[2P[_c1
^<A@^RZI3&VP&6#BC4.D1#G[WXKV5#TMF5:ePae>c?&W8bSLQ7FBL@fLUY]YGP9E
]eT?=,>6\e^MIf,&=1ADNB>L9]>P)BPW/Rg[JQOZ^I9NKR9O5OTL+N?C-aBL20.^
R@e-&McDgVI_=)475-3E^;0-W5#cCX729:3;S9+ERM??SJD?aV509X]]MY\PC4M8
G<)^^IIK9_c#Q\XM8cJB1D^A?H98YTS956SdJW^-aQ0S<fNNQY5[Z9gQaS3V@\7T
>^:0JM_d8c&TTgM#^JPG0<>:a<gZ/<SYXAg-?=6<g-94a<W1E,e@.:MSYJO)aa7@
7bV4SgF;OgdTNT15g1FNXf\,K^/?.(>>1&9TfQ-AU7^QT<=>Te@0bW3H1V/NFB(d
+R\4&BI[862KB:TEdP5J=VZK=S>)&@&E=+^7Of\I>#]/fa(MFM6SCb_]MbEKH=_N
O@Z(LU,=T1ga4COIOe=EA@ZaBVDHX)FJVN_CYSPK.5Yg-=:Q.f\3Z,gG)C6,3##C
CC7(b7?\#TfTV4;=Y\+a2&PF&;PYWUI\dV#:8dF-e<;,^]#>VP7+cG)b.5X5^72+
9cEc;cfc=/N#^=5&a];d,2V2:13)Y^C&?9:?7@MM/US/-]/Z,7YG59L\7a?2d=FJ
(T+00:Vd8=O1-H^?J[,C5_,74dC9BXF^F>494TIf^cCe/-]4F=W&ZCPeTLd+./6=
NA\S(JaX9G\>,)R<:7A;VK#TRB+Yc3LL]a2fe>TS@E)P(#6)(1NaaA#N4L+ZcaNI
XbDW;cLS+3Od5)(1DdDNQQX(GIMJ9&P(Q47Bg^I\BS-T:RRGWU.2Bf<a#aBDD\O<
fGPT220[S9_)_,:=_bEV6bNfRYDeZVY3:K5b+36RU62MIVa9ESGSa5XG5K2IdZL/
FAJ2D&N0<7FWZ6\R:4]D;eeTF7M&LII;]F#K50eCXE(VVffMEF1F,1SKf3G2UT0C
FXIEL81=2PL@.THNRV5=JTJaQW&F/;-GBSXU2QNd\=(e7Z7OZ3(:TeQR=MV[EVVV
Y&28__^)Pd+Y#2?WC?F9;CaLA#1IY+[K+^P]cXc9dIbIJ012=^OE-^5BeEb1(8A8
ZZa4SZ\8.B9[0P#7_@F]VbeQ)M,,O#GD,QX^1EYE37=_G3JONI#\Q=,:Abe05Q2:
<9b18PWed4HJG=3TfFFKPQEaNbRd(a/aLHO,OT8R,CgVGFG@LaMe89c(>f8G/8Z-
NQ#F@YHc<_,W?WRGdZ1<T1QA3/:,RR6R57\T.#PJ4WeLQ/;SK_22.HU>f/32[-_\
L2&[]Y5g_b.2bDZ=Pa?cD?0SMP+@G+D)R;T&@&D:c^>gQgPf9J->1e>_^&VbC,UM
#(dZWD/#UWVG)B0191YETD4D6XE>410[6dYQV1d.BJB(,VSE8F\6V5LS)4dG8LGH
TI#/8ZZ)XQQZ4RPR.7YcA5\#8?:PcLgYMJQgN&.<XUB8fIG;\@(T&&S[O7-W;9YW
g71f<,<4/P?2U\R0fI]1aWf=0:C)69Xf16d6DdI^)+=V6T&<9(?.RB[L:#O8;cJY
&[aIXJXT;EA=bdY]4@P.JOg=@5Q[=?6)X(N_F;FFO-V_/+^YK^1C+dF4Ga/)HG,0
#Vc<##.&DXT,F<A+NPge\67G.)f<O)6c:gT4E0g-J&+)(ZJ?DT0\02Hf#c0dX3T8
+cB.,D22P)a3^?N6F2BW],FbUOTO?-3:?XR2f6>;bV8AG4^)[L,+;M\.5N)U8PCY
>-JX/@C#.BP1@1=#+gIQP3+RP2[GDQJPB\>-TDGI.W7[0R;]-9283V9;9?Q\P^9X
dKcW.X:-)a6K]DZSZ)#5b44)A#V3F05@+0KDW9/dX[5+0AGCNA;\I-GWK\\Ad8<:
_C^-T6B-0a4(dNa:>1],Y@]/UdcDdg1-IY5?;(fSFRUN=/>2bQC^,>T._bOVD;fe
1]X_R?VZ9#e]6&,P^W=5;)CP;/e&R7\QHI88ca)#,IBHHVA?5ACH9OLf1^2d?Sg2
U3DFGJH.B(Z66a=T@12K0bF9fggU&d^>(]Nf._4ae,)JWeR&KF<Y(^f=/e5PMKD/
S/N9A#4-OP7QU)0A4PHCcG^1@PY^\?JcJHW34UUJ6\HNNI2T6,)^UW:7#EB(4K)Z
Xcc>=I]8KgU:.dIL[+S[7<Z2D)_[-\HY7VFgU4H_Y20I=?43WA;#f?B)TFa&COY3
UMQ\?&#)Gb,EC<@cd59gZ/e,D>JIF@7Ld@L9[)84I/M20K)<\,^^bJ08>=a+_IBE
B;(YE25.@HV.V65>,P+[27A5XRW<b\b9-9b6IWHWM9,FGbV<(KZIP(Q/gZ#.TLOW
\(0@)-DVP;7T/fQ_5-#]GBR8bC9H(BOZI=M76YYSYa9ga]L^A)L]8]2d50LE+;=c
\6#R[bKS.;RBBU=^aNQ5)eK4F#QU13IRD?WK)0[02EQ>LYRRVVYEHNaObIcO@B6<
a53gc7Db)U4/UHg2b6Ef]0^-Y)ZcQ[#;NbWQX8JI#1;KC/A)DMMdcU_,>(C5BcY.
W/&78OE^#VE,JA>UHZ,b:UW;RI09Z)7e?a03J<ZB^dS0.IZE/[eY8c&KB5eA;ceb
8;VZW.FPX]\V@-190:(WB_F)..ER\egbLL+;fFCb8JZ:09b=>3NH]>dXXL)d3I)-
.8S.IfL;TKF)GY5cUOR283.U4Z8XFD&3YCT7XaQ9_]Y7)\@GL3\NO3XF].Q[[?a\
.Pe:_70.04=@X/TME2:>_?C4fdg9cFKDH#8?8AegIP_6<d;I>J&_?5\[A4K[=VW0
FaN:a[7:5HdO=c=)UH?(RTY^[AVFK2daRH;&(38&WT;2NT##SA@>+aI\LD309);.
<A<GC4?CP;.(@9U^]VOeD=>M0[(JUGM4bCI>8B-^YE]H7+HHM8;[CWI-<a6N&ATX
VdGVU)31.BReEF2@\3A-b)dbfS3FB)AVeG2gScJ=KH,G;f9a2KbP,59fb4AYW:Ia
TST]2ORXXQ\ANE@T__>OKPP]L#IOOa0RB,.T>CDW?7(E31Q7Ke2K&\^RFQUfCLAE
?EKNKMR-;fJY2=J;<W7PO)BS=FIRJ/@PV.GZ3C7geBda3,HEI:D,eETDSW[Y:47H
_A&-ALecFZ/S@4N&1,,KEQB,_F]bIRgPA3?aRf,-KBY2;T/Oa-N1N1#VL3&IRUEB
Wb(gTKQ5Ba<P@a>bR7;Of#=>D_dQZ(LRLU;18M@1Ic#PFT,fK8/?0?GIPKfYHTPJ
U?97&4G.^8;4L.E&/W#W)[bI3Z[@FW=9<H/JR?G=Bb/>]1GQRQP?6IMTb=;X8LR>
dQ)6+7R1J=6c?45d5E\VTIP7TRgb;@Q[S]:@+dYeS@0[Q4CBIeW;FbT_ULKS?HKU
K#C&79.Nb?UELU^J#WWC<LOeU=)^7ZY]>/bSR8CG8eG0,I@NXM&I?.VOFdP)R^)?
dXK;eSMND0[1K)>@#8G&=1^G684GI.7+<BN0F[C]0T<fMY[eE)OfVLT6OEb,-H(L
0V+R_42I@389S/QTBMe7P8=6&Q;>>-NA-P.H&;-/BL4g9d323S,I,&+3I#U??]03
D]GU(\OKCSEUW_EXHSOd<[T3bbaF21.?1X_[2a80g#\LF[YJUd>]B+G]XZJcW&-T
G6#BF07W;]>3H^T=[#SM\?7)S&&CQUM3:CLW,WRMXd=T6ZB+&Ia6fBS>WAYacBcF
cgYB\?[;3.Z3J/M81AA0)aR,)&^7?O,(4gI+gZ.SU:6.+H<NNC4+3PE>=dZO:DM]
f/,+JEH\/?(5YDdXFK^.HC=I4H\#C.WB&a/U.]79K8cO<&d5fJOT+RbFS[-e:IfF
:-Nb3E\e>Y9Q\C7-/ZKfY5O0O>Z.V>R@P((g?-gBU+I_7-(\U&/G\TNQ#29e&KKD
[@90D9[-bY9B1A;+cAH?gQ9?US0Z#fD,M^a6CKI(2E<5BDAL^4@\7b7T7></Tb-_
T9Y/Y54;0B&/6E1\[;Y)IUBXA(A&8.,]+F#Z@OTSE<Yec_T+Bf1d+\U@^IeO3FXQ
8ZW2#(L^>:1,E)DZWE:6?M(BGM>PdQBcA=Z\-J1d&BcSBA4Hb4X;J=/)OUa_d;B?
MIF<7E6I(XPN[0S&^K/\RZcM^29\,GN-gPSX10HW]&EE-G0PCIg0fLMG+aaV;ZL&
<LS7gcV\0-]Df6=S>\8(IdX=61efB?5FCfJ2Re5Y28dDEWM_1g52X1L3NbDNDcHO
YCgEa.>Je?(0A/G_LBR(S5Z;X[A]_8\@X8>JNO+896>IC\-YS_)C9)ALWMWS^c50
;9SbF\)0JC?:[U0HE]_:91Me5Q;?))[Bbf9e3+fAfEG#.]Z-I[\@c/SPb>F5<_e=
/.)]agHd4/Y^9f?Bf0IS/OWV+#Z3>E/-[23bQ?gBgUYe5\Af[.-N=],1RIL<;W9S
RI#c<[IXI/X#=7f3NGO1#2cRcE842?)\cMfU\?I;94\JfcBAR]&;LPdUD,2MPW&A
K:b]#OLfc5@-B,>]b1;M8Re1SSS4J86VL5Yc^V):<@OI7S>WVWN]b#0\V[=[TIfG
bXPX.cEf,)Ec_\e)U3-+GP0D#,)0TJO_CN_NJ(&adUCaI1:<-H97\eIM>dN0>USC
^\=FID22bX9,A0C30L0@X5HfED?@-/SS:7H787L1M<@8_G:@V,]8_Y@_7_(8-:Y8
#)&@b?4Q>KCSY?Q,=88<gTS-:g>TY.bRI:7#eHdWVQDgKbZFWX=_#])]1MKN4@UB
->=MY-=)3)OEG(EEbQ8<5K.)X?Y4\ADY^M&(C>VaHBgA#?I8&@5:6VDV1;HV^ebE
+GaR?^7JcdT8CR..SG6NA=IKC8,D47I@;[XTb[N8_-g.M+LL6Cg<gMAWcd4R,2+7
@XPE9<O//0[L2H10E-d)HWfU_N@f]7D7^PTTV4A4KHNIZP/a#T)I&41dJHe^+K/;
Q(Yd2CM&,(1Af9R+I/R<\F57d7=]aX=QB/^+@7EedeBWE2LePP?>>(6ROA&U,dJE
VfO?670=S3)Y93^f,fDSd6.FX^8+,-J6^3#79;EDOW9a5,7[/gG2ae5P+UWXQD,U
WI/]]2HV+?,g1aFU6I?8EgD0G^OT1LXKa6Hg_5(H@71Vae7+HFXYWedJSYO<fT&:
Y=W8UW<4Hf<WM3?@NW.]@:+(;H3=aP@E:];>-e,.:4PK&I01PZd?ZG)>N.c+)&OL
9+BP/@?0-eN<AW9)7O]U^ebdT[f.DX4_2Z2\/c@f3.18IH^&gKEFG^Y6^M7#e)?]
A]2/?d89aQC8GMMSO=#DfRJN4<BE23-W^IfIbCD2D3G,O72e]F6f@aB0]<c17YU\
BOJaDXTf[N0c+\>;SQHGES8X#0P(aP98P-CXEBKU4fd_GK.T2Y[-L[1RUg8)c4+K
H&Qe476P?La7A\fY]UQGAZ[0[JMJcF_ae&b];LQH8[H]5Y#O(>ORS8GWT_;P:dP0
R>#B/N)VF@^,]3aH]-KH=^#eZG\,L),@B_W=U4L6M^Lg]Sb,1JZNbRJK/?D:G\Ic
OBaZa).cB.1@-@&-/bc-SZN=0-aJ^::ceH?H.D13<G>(KDMEb;1PMgGd)D,PP+0g
a>9[<5B<Y)9gcS_(BWPY8C@7T<X&Z[[/A8QSU,RL+GICE3JaMd(S+O6^^8a2A8,O
KD(KR9/ga,?aHFZ/0)1<O5IH04:&4327,YV0>eN\0H(H6E6J0BU(A.1;8BL]N?ZZ
LgLS#CGKBJAAPC@eI:6M9<Mb>Q.N-AY.\DFg?)3accIcV[<YYd0#\b)ag<@J37^M
6G#gQb77J-4bI@Pa#g37f(N?@SXUJ2XL1CWWQ?CZ6DdD:LSS?^GC]KX\8bRUX1\d
?/Pd4#XZB-5Wg+KMFKLU87@&E:/=9De<+Z7F&DNaF3&JP@RQ3<P5@\-cO))FY?Hb
Y/?67U0gJUO/0#1YB)4+Gafea46E<#UM<L0dbU4K<6;06JLU+C,T-J/E:A69W7DG
XJ=BTN@;F-(GbC[:fP8#T;N92YfCH#?^\Z6BDaAE\T:O7eWEd_8gC5>)@,S&/8^5
F?Q>7^gOE2;WcZ:g#Ld=^@LLg2gSHbDYM4c=PcZ#O/61,2_;62QPZ4@[J8gMVP03
N6E3T,:gI@4AIb8XOcXJQR:f=KIeL12QE_1\IOIBIaVQA[J;=ScYBV+?93PL=,^f
93S#=G+dC();.L60UE7+-WVF(W&We#cO4OVKPVAX4Q2RUHSBQ3fRTG[TB9aBRbgG
bg::==-&g82WE9^/\15_E7;3I-NW3&;6<DOW4IAeB21H8_IdgKA[L+UG_V#AG)37
K+f]N;-+33GI?O>1/ZHM/T&7[FH+6BU^40KaTPC)QNBf:=QGfUI(N57,I3?H;G]d
^H./&FRA;Q-_/WC[0/V,3+T;a1^HVEER5-5Y>2683=GM52;,e)^^4\O;28K#7#-<
#Ec7>5Z-0944,d#bMUeNZAS8Q/+Z(EFGQ&,8]ENHf(OPfN:Y<:YAN.gPSX6[c7XC
4R;LG&9]7--1PSKJRcIOW0ZSNPNUA?(E92G5D<bIdRbR,MKAEIBR?S;R]gQU@GfG
dU?EVF-BV;JL\?>E#SgJGR6FNTQMW@HAe\F1-2YSAIETP6D\N;5X5dH(CdbW)J9R
#T80UO0;<B6;M)b#<A-4M[8cJDd736aH\(,]EMF<9(EENNPPGWf+(_.:[Y>;QUGJ
EA\T]3/9e)W:&6OZ6K(8UKLCY47-\bT-H]gg&GO8fc1Seg#[dL-aT=O.74Q>6(3C
S,Ba96@69dK#.,)FK56F:_9Q?d(bNdRWWRMH2gPc<Zb#FT#9bU8I9[193.&(:PO<
N5OYB??).9OQ->D6aZ<APX#F15XaU#EdKBRW0=1R^R[9DMPQ;P<.d.+MG?L_0&ZC
<0NMQU+G+.T34fF/SP)=?:>R4KN@[[=8DeYV:IT?2g=@#B[fV[e+EW0E+KS##>5;
6J4D6?a#Y]#W(C1U0d0:g2RH/<c)=A)gQSNP@b67Jb&=1dRcIZLTC8E7S(Q5(XCB
adEG[/XW7[5c)T:7g.e>QC3b)F[Hd\bMX,<a]R&dIFW2J1P?@A-:G56cPaCP#g=R
g2;3.DfY_4eK#a@C=+_#]>aYR(SO#N71RI?Z<a_#a.R2)Q)E^_?+9OLdL\g5R#Fe
\SECMW:@&HBf7Y8N8D9L)LRPT<XD#eP2_;K9f.+#;BHJBK:E#UBZ+dO=,54[AEgR
C^G<_0TZ(U-gVH>HR-:[6LZ-;dPd\;&CA;2V?/S.fL])XZ#NgI(I/612=KaR^8NO
9e/1bD<.W2Qb5FXBE.LHb^A8,aCUXdC?Zb8<)<#2<0>#fBWVQU]._Ia<>\QV<8)-
(LR)FYb.@e<5M?cC9\IF(McTfCUK7N1f<gV]]0P<HH#g:4_^PC_6VWcWb78g7E4^
_QB^0HEGf3ga-I9))(N;6e14=gfa1X=XBdb8_]aRf.[(+#fRXYKQLQMZX6T&_+R&
IM6)T)P2<,PA<f+U\KJf7(c/T[g)/bM,&LGZVeQ11H>[d@9-[dWeI-](BAQUeC+X
MQ4PfN+1.EB@=JDfbBFdK6P>B+<#T&Vd#dN4,O=+OHONG/@7\:Eca]&?0O+^(4cg
/5PCQf=1/[7+NSaF5GJ.E?X?SeS@5&][3Y?P^[8R12Vd&eX86@GAHQ^#[_D@)D1D
U10Ce(F:V[Te,-CS[TO+4c9cL&#SdRV8Q.26:7:(b)ed:]?ZLb(Y/WXYf5XPc#VQ
^FT:8N>-98ZCR,M=EHdW^/a4?1UTAcVF)Kb:d:QH5P@3>JMa/aZ7G<GE7JPH5L8/
&aS>)J&^9CA]eH#c/;F:C[HH:7JGK7,ZfA[?<<EUdYF#\6OGYa?cLaWVaJDVRUT\
NQ#gX-A9&U/BAO.]OZG,)_AAO&-[[\251DBe0Z-Db[KA]5c>ERT,O#F;HcgYF\R\
T@bGJ^HfNDF;5UGfF(7]2J06&^a,SgU-,,WKF)UBK6-ZZ:7Wf5fFJP-K<_b0VEeN
G7LP80g8/)PgB9;Y5>@g<<G9CL+VJ;cHS4[2R,_b&5>R9V-I3D@1DVX[6ZdgM<ZH
2@\>)g#[QF/@8WV+2.LM.PPNe\,=RPUE6b&e\)A[S/2[Te2c+VT=@e:8XD8WL?D(
.gOd)1bD5X[dOL<b5A,J2SIWbKdJNPKDR<;W]eIgT6J:YFb]ZEX[E^D/Ld_W)VbP
8?_\d.5We<KP58-ZL2@CTZX(7aZ-0@2A.<9POZ?^g9])#eKNJZ+b>H6#AE,4gI(W
ZF^c-.JO>N5XIUD,/b1@H[4Y2UD)4\3+653aE-^QNOOTaAODc4.FS,VO\4YML4U?
Q7afcTX]g/^I#C+5[PYf4L7]ND3<J.06QY5M8M1<6JBJO,:EMIP::.LG4&Wd6\H(
I-+IeF,1Y_\+_Hd;06LSVLK/Kb(66)^4d:TXR&A43g,Q&f,)0WeY_:N+/&6E[X9-
;.^DKWLM(Tc)[7URL8AM),cMc[(ZU0FeCO+BOF^cffBefPZBL>^TIc2]^d9S00A]
?+Y.DSH:=g9H=B3P52gR>\8&Y#MI^fb\dVfYSQ_<25P.)OMDE//4RP?e;QAWV?WT
N844Ef_/SYL)?RVNcRZ=ED7[RF3QbT?H?D9APg^-V+CE8.Sc]_[OBBBKC-A9Od)@
d;G+N^adFG^KOI/U;PBSfD[//&GC1R>A6-fHd;VPC/cXMT(EJX54SdWWI1/OF=C8
VcJ#/GD@&I>18#bL.bTTN#&M,aK[-2G[6<c:&\GHG_2?R3PfRS3?L<HZD_N4WCJ^
:CD_OOMQcQ^,A)_,6d)7GDFg.7d<-PB02_1RY,O/]3.FdZ\gNF409G^9e-LXS<8G
#MRD[89M0([Y?EZ.:X7W^\GHXQT(SI@VUB,0#;=1eWXP=N;f4dCT?()2MKfK5bg8
K.N77C^(X;^J1L;M+&d=UCMAUa,[TALBaAOE)Q=Z0adLIX/1X[7S?_SMf3AAWB9N
;F:3-cc>Y]A&d>]NWd7,98/GGHgV=@eU-VNJ-PBJHZ6T7+8T\b9ATZJHIeaF;?_:
=CDG3+#]H2/6c:f1G;2BERHAIHf0]QJ@>FE8RfDd_]-_#P\7dcIE]3b^5Y[^cDZ)
4(&MO696,,Z8Eb/JE+3?=(efM2U7]#CENg[U9#;W]DRDN=;FgebHR4ZeV.\)RfJa
aZZ-gga[KB>1.7]:g8FA[M^VC;CB-1BdZ_=^T&[^Z:Q8W47:#(;@bJ;O=fTdL;3J
126&ZXPR^0CcY2WO3,.+]>JYSaQL30MLZaE3Y.S?D8(bfV;8aUF]:ZB_aRQ;]6<3
>8dY=W:BE3AHcT_T/P(&-AdE9aBWPRKW?(#:4gML=2Bd)\]F#BE>Y3S+=cE5bN88
;8]Fe/8B+B-:)ZW+R0a6GI]S_/?H?UO_61NPD0]P7eL085eA)a3f4b7?B.DEbaBG
/DH#d[@?L4HQ04g5/9+b00&4_-;Z2NKH4MDeUGRcD\825OBEG@#Ag.U<aCZ5aRRN
LXcT6,_B>5>F)4LEOfY4Me<>28KfEbDH_3)dfd>e]T;M],g:c0N_+<EC0J\ZKWT(
cK2R@ASFLg2X2U?TW:?:F^QHRY5W#I5VX=NX(d,SW&.,TL5KdM11Mc<;,[dJ76V[
[PL8Z,//FE16A9G^L#fE1Kc#T#AH]FN.VU>0XY=ITOX+DNE35>N-_T_M#=,7d[d:
XPgPJgf/2@YN8]AKUg&YA7Z0dgY7Y6TR_NC1.MQ<U+3V>IWT(&I&W6I\B7;:&8A.
(eKE<X2715U0M(I#\&W#HAd)5Wc)SUg#T0=4[_B8N]5b[[>TJAO5<V5),@V]gD^;
;6(c/\R,ZQ-3dV7Zg4]M5d&+U;\=L].7.E=+cE1RE9e5SW.;SQ4E\bV;3=:UKR+g
35e]19.N#C<Z>@;Z]XLcRMP35P>TObSX?(.Sbc,d8NE1?,W/_=/+LJg=8\4RIRE1
-aH<&Mc,9W[EVRbE#O0(eY]=G]C13IV<@S.ZAAY,d5)2S:[I-/e7F\e<b:9AJZc[
3@b_L=FZ=5&N@-:aW;#3gHCeX#1&4[bc@J46T#7KaE1A,^FaZ<E:gba3WO.NIZbP
a7KU]S5B3I,O>MEG_)F<c,@db.R7Z;_U1b&DVeU]fGegeg^8Z(3e1I5W(3-5Y-==
;6b\1=#DDZB>cP58fe/OBFANEdWEQKd>+.OEaN^bJKU]J.f62FKEMHRR8E[b35-e
De=T4VQ2-5W9Z)H+(@;V&-.OKH^8B?@=[+P^O87IaUg=\<OOP?XB+15N1>f@M&Z)
X2Y9=AFW<9aYH.6[b5S/MM/H&^XdZd/475Q4JS&O3IC5W5TK2C4X.UP5:F^,UJ\J
)BU+R^CGYacW:W#?_0?H04#NcH+c4K=<]Vc-XUb#(AF5WV:&1T;FR\2E^AH]b-LR
]EfRZ)Cc[<2D;6aU2Jc6_=PSRW_eeFO]V85H+Y5eXcUD1gXNJ3ZE_65WQZ#gH;\L
AP>X_,-O>,c^+[X_ZLM;YXW-fb2R2dT0H+>2cAP);-T0];b(ReK3A,#;81^1:aA6
T+#GS;/>M-89LAO?/T_D0d6[W5FH?9-:K00<J&UWCg@9NfSE@;HJG5=3_J-2T\3A
)#3Bga.d.MMDE9;b\gT1DPbFU(1;0[QH)(]&GQE-6YGEPMX]>@Z49b>NO27OK:V1
&>7#cKeK7b\&H5ffI/]QPaC7Y\b&^b]YW_a3#5<F4,9X4RRUR6aMf)5SdTZK(T/d
+VA-U=7<-:FVQ-S5e1IC@</B&0C26@D/<+W1-?DYUedTY?TGaY9].Ba?-<9bL.]:
Y&/QG3+ZZbTU7>&cWM\OeNX:(BE5)QJ>0RA@bd.F(23RJ[N=)\PM/V+8\O;2[OT2
:D&.VYcEP#G+XREZSDSOV+E\Ldc\ZM8.T_=5#V.aAQ6/b&EW^dB)I#Og;5g87H5X
V\\fYJGHgN1JNLB._C9C>LM;fK]MP@AR5(9Z>A))8RFVV6aeG12DB1@<,FPO#BTI
]Bfg^Sa(5_9KbTV8)B5A<-Tg?SB3^)9T;-[5+W,P0fd_VQ=;67I3ST#d^(GCNUTB
PL/M\<O6PVD^P&_0_2e-<dL3&;GP6>4F\0b7I?eDU=;0]C<PDf\7IP/E-B,S:1LJ
=,,F=>7E[fGW?;YRQ]6>U42Qa5WMHAa7()f\RF[;a=]^?EC4>Y(5O6dA+6+?K&dS
HW]Q_&@:7_afOZCa9OAFU:GZRDP7?X^.4NLXe_8RP6ZX0ZTXaS4aZ9@74e:VIOK<
S5DX9SaaK(aNHLPL13^.<3+#PbS\DbJcDLS2fedf:AIV_&QCZRa2,&XE>3,7L\LH
1:@;QKI&2fd7SO[(\F3,/J,]SSX>4,f9<Ac&2QM9]IL.I>/MaMM>[d5+\MQe8)A=
15\[<^N2G1a.a]YRc^41ZJOgRL<@Ue)Sb:DUdKgY6;[Q]QW5RE86?&^6[56H[Ug,
c/;a&RNLH^90OXQ,YN6OSJYJ/TK([3\:@OefC.4LO7c(X\9J4WZ,RMH:-PDV)Y8@
?8I)8/bOL:b<\MQ5N+AE<,O<0)S<6Lcb9CBY[9cU]QCOf1Pc23fg2_JbGIK:?1MN
eB>CCUeKc>dHf1AX9cZ0#?S/97fb78MPN39dWZd3Y4&gQ7\-_.V_4DFd6D,YfdI4
/X@L=b/Cd43,S=PSM7&HUMG,QUaEcb410O6]5@=2LK2XX-R;;XTV&f,[-Z75:D/D
bC4Xg.D&GDGbW6N-98MPF30aQBN(8==[g^]c0)/8D<_<18K-]GT[7Y>\<N/CN0:+
3+])>HUY-dX3X:.:?OK+.,R:^5cYH)B[@GCLD=+g2EH1#3Z5V-D;?((3(T2e@F;U
59CEVH)WWR+F&Fc3LI8eMaI\Q=]8Z[IH4(OZ9SE2c;Tb+A=dGM\^aUZ=SX#Z/&F;
6,fVcW5O2_U0bM&.][cJeJ,HPTc@5#H@@LQH::YBWH\]bSQV]2?af^.g<9/f=.)H
SaABSPf[A.B4J>(Qfd?IR[NP9]X/[/UL>Q-5;@0C>^&M6GMLC2)gWA4<7aZ_TL7I
30RWY[E0=JE3ZGT]5f#B(0AV[(M9)cBIQO[&?Sd;APOPEYWbHNCMb,L+DE]Qe).(
L<J7LO</[42QH6a\24ZfM&N9N-[\N.YLS9d.)UD\K/,+WMPBV.@H_C?,2#G58-8O
&DA,Pa.dF7AA.Me0LIZb0DV:2,8;=)C.768ecY=\L@3:=C-SY0:H@.ZWd.EEaSXH
1eBc7L)fKP,LWPM\9HW+T=NZY:)Q7Z:Z8dLS&DQH3>a93(02-)P6K<9A_Xf+:EcP
CfBQGV##U4U.Z_-4VHM;_S1=7;EE2/XO2X@/d.W#[KHc0Z7_KJ=8::^GTdL^Y+g_
?4f1eP2_]/ZQ,.dCc#XU:J]OJ6/9UIC(BdDd0D-:DK3FX,L04DWb7]1M1d,GcT1+
7]=Y;c5J\)K--?:2Q@:PKUN.0+VIcaLBA.I;1KRF6a#HcI##\0:[^T#=[984S@EH
?[^(a?YHJ\_716/cW,0I+?1&IEVb=)O#QAH+PU(#56;V=#3;TUUe3^=AG:&3-b/_
L>,:QZ6=bX=#_Y;25TcIEc1;M69,4#7J<^R8FdH=J@=E-VL;EE)VU46^.25#MIHZ
_+[/0\g?IFSI-0DM_fObXeCWTSDZ.EMOac&AaK3gg4&4aGac+B\5,0FV#[#5/^^S
@3WX+IJCa^3;_\Ld&a]#c4)-?^e2=NHU_67\\2NgN_dBO,;D0?A6/fLRX/UG]LO(
,d9@9,IJdbEa9fLQ>N9/-=XR_WLfD9BWCHY]()J:FB:(?J96JbW@Q.@9J@2P(faA
4-b,-NUP1Q7-8G3,9;_D[9>6fD4T9L[f_bV3U-GAJ#f\P(+/IK/-E@,#L:;N@KcN
0J(>(W#)Cg+?(D<E\4<f^N/?KfQ(PE:Ncg9AV-=EB+@7Y?@EWfG&CZW38U8BPea+
K7,#WK[HK(ETREJc4Ef9@(I/^V_88T\0g-3U(\ZaF_9#7^eKJ/E^D<9D\-fOSHYc
/Sggeg>/QA;@P+;^:Q)7eOTb(&CI=^MQ7UQ^;5]LH4QD;fYBe;82Q\YCIG2S78Z^
2AO9Q4=U,]VY^I1GF[G-;ObLC5a)V18NZM6cF2IWb;CNLCc4eN65FMgMcEOc^B:]
&3ZO\\2Z,@/I?B=BHgCTE5)FH3-1+0.:TD[0=0,KL;JKAcRH5VR4/^N.5[cKLY+-
W=LE)R+W>Re1?ec(.P?\cIPWC@YNFO9ea)#RZVW=CW<X&-:8DR.f.LPO@bS)^(P]
gQ>GT2R>JKC/7)-J#>WKCO(Zdc?O3&EbY8HM3H7.LUPZH=.ICV,:O]IcM2>K?)YU
)E>N+e0La7Q4<[]g^5E]:)YDHM>7[:0=:;G0W90;JL4&CV@IAOG2Z,>,-]N:7@BX
R&G,cUW+Jd\-&-]]]:9#E51Q(6#D[]V9E=F3c8eH0#ZIW3_YOf=LD\QR&/YQWW1G
Tb[e8\,@Z?CS9=]I:X:c#7>4\RR_Ba3==?10E<?^CGE^OYDbOCAQFXPE7d;8FY3#
6dJ6K2OU3RIbKR6B>a8<0.^GeSSQ]9We(CE<ebA#I/:Sa\XFK772c<-0F3d;D[?G
4MAcN76(_-.XUA=eTRR>WgFN=<?O)^\#cdJ3OL1J4E(:ZN9f6LZ4JEX(7bOc21_;
QA[:KR]T59e,:g#5STK(.L;)4K2?9.8T/:<0L+9T1<Y:HcI(QIO&LDM]5#g;;T/)
4^4&?P36MX?c^<0]4EZ&N]BIQR/4I>N)[=-KaF.ObVYY#0_]7^GePJ-^#Zg#)7K1
fOS-)1Ib@#Wc=J5;4e/J_PB+6<#XE\Tb/Y>;[GP+MIC+EE??055XJ^?WgHY=Q?Ye
:WODA@&CDH\3=bTNHAb0#[8dCV-NV_5RYC1NX6D3^Z@(#Z/G#I:_S;L>Vff11F90
MM8aG\cIUg#&O?9@#_cW_7B6g]@/^W?b:F60VRD_0^SJQd]DI9N<C4f?Vc8X9eIZ
UV.2E:7gKC1;8@1M)@LE>1fAfDN].dQFN-<dc&g?47gMdG)g^Cb.b.K6gZbPY_US
YO),#DPJZ0)F?+Z3G?298\QL6T&>d4^7CI1(U2YRCZ)XZV6Y@PQ\PdU]K?H9GEb+
;A^a21;VW/4>-TOY3eMTYOV=fT+0N5H=O6:+H;#9\beOgW\&+-7f/.2_?FbXI4ZK
:LVKZ:59HT;?(OZ[/_a@JX9.)MIbHCODB@cg,DDSEL^F8(FDGLg6/N>66ASa<gIA
Bd(U]PFAZS)OWf3A(XCXJa=Z1-6?.&I^,5#[H61E4UT+6dO-#5@-VJ#gWWWGMN.C
DALTgL8/B__-Ie_23?WOZ1G4]LX:gPJAL5MBBAUB/WNXI0#aH+V1bKI_E4O-FYCU
&JL<8O?TE9bOI(2V0gHgQS3?QW2@Vb\V0OK0MUJRZL9g5O4?/Z#7@A&RHZ44H/gU
eRUddLV9S9UX,/);@7B/#1fdM+C6;]b2[.f6.1DcWPJ(_1[<-7E;CRa.HWGd32W&
E@U\+^.(&;>_:4I8BS4b.&#+[^64KE)(@eJ[0A?>+[RXSg6T]0S7XO4H24P-_TaD
ASPGW<-f5c:SKI1EGEMM769:H=&EA)#6Z,B(=7;;b<XYMB8HDBg;@-=4\6>R-M@A
42&E-Cc9H3G_c]@XK_N8(ZZ5Z35_g,04HJXEZ.:;?@5\899<d9gQH,U=A:g&_@e^
,-a[,3@Lg@09Bb]4d6:DBYU^Mb1U9b449Xg\YaNg0M#;<O?]aM/BLR?6,VL(M?CO
\5.V-Za_AeF]XMTa/PV5X^0CTFX;NeDJQ8[T\GOe3)ZRJ[3>3>e1c2N>&@@a-X?W
:Q+(;X&9FN-_2F\f=J@P;g0[].^//<ZXJM1J[^D\/Y8UTd+aRDR;,&-#dEB<,J23
I;X0eK=f8T0V3/[+b=Y,YPM;&/OVSLg^Dab@@F,c#R+ZZIRYZgGX:WW-7Y-8[];d
X?Q])DIU-.MNBN-H3,OKbQeT>(HGG,2T6[Tb+L<D8Y]b,cc;[D1=c(P7fM[T>Y[a
;AMNd=NS=<f.f@]890H0&_I-)f9dG?UfUgSc4Ne\M\K@J<Nc9>=#Y1B6R;--fV&d
72[H_VS40Q2=d(La:+,3)FWQ4((HE(G:f\UR4G;cD^3+T@P5=Tgg^(bI9+_AC#NI
fE[#d6#,\ABfbE<E3]^=1PNaIN(3X\6TU<Xbe_A;E(b1?,S;:&P/-;[bfaNZDTWg
#T-L\;B6=MSTT.Sa(&0/,/c7cG/acbC]b1I6FYU_=0=KC#:-U;J-=c_EXD;fTb:Q
2:<cB;3aa^<4FG^P?_9C)3O6PYNAB=+#ca@GYAb;;cg16=;MK&PQRYA<]gNR=g2L
RfBEHN=U<C5[NBZ?fVIF.B_Z&X6P21=^aJc7(P=]f6Y+Z5ZU09bX1A(XG\3b//3>
YFVV#<dJO5_:Cf]X3:_3]9=FV,NQ>ZBI-#P5R=+QDQ9XD(D[^S0CJdBfDQ956Z1g
ODDC?A?&9A5beA1Y\Z_+[:=0D[\DL=@>,:J1HbT._7H(:e[UT+bY2BFCB4e(7_JD
1JTa-:#SG,S=9^HY9IVDW5/2^+0JX9efI+QT:7\2.>c_T:LX\ECGZHXBeN[CN:DU
3#9R>K]A1,I:=^Q./:@GSXN436T6\WAJFU^JebP@5@EeDg;WX\NV@X1b.6Q4S-BI
JHU4d#=I5&INF<Rg3<U)7F<,c4.+A-=gG2eY7N209\G13KIc;[SgH2+aGRAH:;eQ
Ce0FN::^ISQH?+TDF4LPJCJ/#1dU?Kc4>_6Fc+,1DT;,YIT0S7b-CUK^:Q:><8DP
L>8/SDAa4V?aA96VdH,EMLYE:F.+E.N?C^=_;;>NH,WL3_M5UUYEdXedBORZ#?D(
7TS>a^WV\6W9K-1OY.@LCOL88-8E?L.])R.68JA3<4HE_L]I+)Yb-+O2Q;PZ-0Wd
^<<+Fb6@[YOX9-e40F+Y7gcA]DZJFa]_4c#([.21^RW9SV91ZARDWb0]+NdMd8#Q
a\^<G=^cZ.#D>PRRAY22eIU-PSV18Qf3gC\.CfgAQf=0F#K0//BEVMO]d..F&b:K
[(3bZ=0GQM6T8_^WWQD?H\LH9Ca.FOc@Ue6SGK4+&N/S6JFHbL_d@/I7,7FS<4D(
?@Sd>1]/eZ,0UBb@eY2;Xg3>_5=/ABN]YAT)#U=;.CCM\]PW;eegSVFK(d7MWbCD
d,X6PTF_MTf\NUW]1;]c].A@B)>9N6/Q>dF:_?[6C76cM\>@&T8@)GVAP&dMZHW=
\SG.bacMRYFNb3DP2,2(-(?VL<c7e0@,XXV3Y-)&KUZOHZ8AKFWCT&YB7=@W]J2U
XfD[ONaW1R9ZQ^.+Zf:[2fBA7L?C?4YbXG\^&IS&=TZ8beTgB(7B-+C2MeL/Y>#?
W@18F_)3U_<6YY891HJC;NdHcAZ/<1BFA,5450[C7\1_,cFD@H8[..8+9c<MCGE6
J01[8A_;ZS/XXZ<)D>f_<CJPYXaaM8JaW+;I;Y>J5Q3DR37dF-<6C1<N/&IefX1U
V(YeWWR[ceL2\&AYfgUBGV)G@]5N/E31;;7LRI]b<0,4RRI[5=3aQEPVPS]DAI^:
;VXFd:Ca0b?Z-YP@#;+?(T,dQN<.3b<5PU;+JIK#2Y&<cW[@UH=O2XM@P[NOC:LQ
X]g-<_Kb_+N6P9M:/JEc)_fdD[/#I.QIW=\eQ:==Z+HU&cX=I(W\bU2K_&)c.T\I
0(AW.2RIU[J9dTQN4+g6BZ)9;Q,M4Z7MX4H)e1C2U?GC1:RNb3?3@03(YV2&;]8J
J?cYJM:27G3P6WbXLDN3ZHGbJMH9@6<[,:_2_^47cP:-(6^-/&5Rc;+&>_6@^e5S
](=aG0[\RZ^8O0.XMI46WVJ.S^V;Q=-1C:^#L.\3Y)O=7AbRfC_CXC)Y.+;7)N6@
V)7(R>ZV4Q&,dC8#\FYCXCI-_Q^=(?4=RP\-P)HKMAQB.gfRKEQ>+T&>>F>7[8cZ
R,,7+J#2DaFb\\<=_cUMaV:ZHe21(GM(,)fb3G0<Ug9TY-@a2He=R850WNEPY:P;
K^D:7=:.Fg],SC^H72:B--#^-G(>Z.H7E;\Gg1eAP3T5/0.E.T\8?Y=M?XV#0P65
D_@D@Sgd3fXE#eXI4TOX7M0-OQDV[P/g<B>YCbW):R.O+gW=@ZJ7_QUTb:^)RATR
I&G^6BS>0^GZ7Z):0ZbY.Q;VH-G\Y1KNCYWNg&DF:JC7C90gVXU,Fe.I@VYG]_II
f#9RYC[,:]HaHI[V;WT&N,\PR29g/2ZCIZd/bT=A)_8&0fJc_RN](e1LU@(8(b16
Q_I2L@0F2Z89DH:JDC7@Deg(ECbW,g-U1bJQNN;<CJ[@?8cL&HLdZ8HWYb4\2Z7+
?F.6X:T1.TBO3N9ec1XK+HQ?YZB72B>B81)WBQ5J,)f3dAT>XY6ec2bD@B#gBHYF
b);5.O<PA/^E52T,H&@E[VO2#@(M5,SgE9.Wd>-\7Lf:.7?K@JW[L<J&7^(#JZ\2
-;gX]KG;F)-8;Y.gf^FRFDVC4YY,6S9WJO1_WM-Q^A)7@McMI;+/>/YK9RVXYff#
fOSIVC>9VZPNfNYSIMOV\^M2Sa1R+0=[a(eN#Ia]Ge>4SOWc5^<+H9@T<O;[WGca
JdQJaH/=TOGHgeS\gNf\gJ#YL@cZ.JgSNF_<f<OC[>H6_aQ1d1)DL>fKM;/R/CZ=
VW^.E+a]_eV_GVALLK6DG])D];@TG#&[D_SJeEe47//XE]2\8bA#3](]PZ=R&AK)
(b;<@?W5>_?(Qb@CUee&^FD2f0DMb8>\T.&>bO8=[J&\g1QWL\fge(0(PT41Z.02
Q\U;B8_IIa1M#[@VZ[>Y7YKS5ecHe=0=J(dD5D-c5T.0]1NED3cJVQ4:\TIQK&e7
3-;Z8LZ10CO_<ae(,gEHXP62_:8FLfa?(1Y>)F82_bN<?URUX8@38_.;?9;G3PX+
RQVN2;686Q]J&A6f1#EQVb8CT+#6Q++R]A?CUG]_/T=6\aF)>]4I=XI)PgL5?3g?
<-d<,UH43RKD6@d7H+T+OTKG+RI3SbZ,R@;A/CdUO,[RQ]DR\4J;KTYS.0SS1JA_
(2K&Wd3W7,J>b;ce+?>FQY&BfF@YYY6Va;TU-E^T3@HA],.:<M6AR7YZ6a0=:UE7
(]CC]MGRd7f91GUe@&@L_05-<Q+BH=/U@QV)E2&8H.4X.<?Je,gPFG>AcQP@,&+N
1d_)TA>[NX6\U/+QOP+MNR4Nf.,AJR)aa063>11WNC@0;Dd;B:J5C(GfaC&X,.]E
2L01f)IgLd77b8#4VWY>+:?V5D].c\#@-.DL.E=ZCC<WW_gU-,ETd9B#DL<FN4&<
T+_;AYECD-3XT.X5C_8ec=N;a8cK:NT<eae)LE48gCGB5&HM0ZPW-:;=L+1PJE/F
<cHMFSL+D7]DYdM>^d707FfHd0TOC#4S;6T)8aSd.=76F2M=MLQ\bJA0_]c=a)K:
IJbK)\\e_#9-b4\W@[H2a2KKSfC^HBQEFTD\79XODSe;FSBR?)481:I&aAL;R3<F
dHVES9;-:[+If]<Z?Z\gJ8C)97[aM)DX5M2&I&IX[;[dV\HF[1[5(5&Xb,ZV,F-#
_a3HZ0FBD<^XGE?#XbQW3Lg)-P1\a/]eI4C64Q\]/-AcH3:fY/NCPIZ=8=/gfXE+
P_O0g<Sb2PYe5?Q^fe<?I3LM5\QCg\[=e9ND[aEX>I/cA[OT1#:K@aG)82JbCV,/
9,G46b^\51[BLAa3A;Q#^N9]acdN+FbHVJ-)/CE?bc#CD8U_-XVQ_[)ScZ;R5PYK
LMZ#E5(/[6H2G.JgFfBd9&cL2)Ka3HL,_GMCCOR<CNSBVPYVfF8K=_+KfdgECL&3
X9Z1.Q@D7d)f+LA8O@-BTX.(9:^Dbg7-9YQXJc+cKONXT6)4+D414U\>2NTd+Y\L
U8_ZeX9gfeI99EMU2&3cA;5(UbLa)H<L+^LY)84N0.H<L2@cRcbcI4_F;K#,+aE#
;#CO.bcK^9:?<;_-0Pe;Y<;/)0OPEd<F@/.?.9QbcFA)5MJED+&A:b^;E=fTf^4=
U^0a0G,+,SS\\#0^;(Re4Hc_A3S5O9GQO9PL\H,&R\+H0-e^G=1M2N2W:RfUW#FU
0:dAMMd(K_bF\5\#dJ?J0Q1CYX@#e5B=OS#D]@IBXV7=#>?U=>MOX<3WeJHZE:()
Tg6T&R8Q]CdFYMU]<VGW+@H\2R>81L/)[XZX.gdQOV=)>UbdNTHL:B7E=cRZC+@a
=dbBWedGMP-P2bBPPJ08Df^aZ4)/J3F[^X0O,4Y><7C:ZX8_D#&UBKHAPfDL]S5)
^Uc308fY^X0Ee[dA2bF=1]11G2SbMC8B<Q4M8cURSI5PU=MB-G<C#,(S,JWVZe>?
X82HMe6?dgb[:2HfL^G4eB<60N=I\F_7=MGAJ;I\83fGB<a+FK.9K-08:20(&YOS
cQWb<Z,[?XdO:]ROf)])TETdA+DY].UH(>6MH^Q[dfL@IITXPPQ7HPPCE/6YQYE^
2d)<W/+I,+2S?Wc_>?f__8fDLXLGfO6]b^[STUSFMJ2LXS)Y6>O4L4P^>0_O:VN5
+JLWLFP]]BgB>5CLB&D\(:bR2gg4fL+a4/Fg+PVQI4g3.C9<?6K7P]4GZ#5C308A
WM/TC0=2@PY\3#d#E5-^T8][/CAZ-ecXd\7MTb?MHGe[=T@;>2dUdbM/#@UA[?I8
e]We@]O.U0PC;f^C)HIJ7<cVed_=B7\C\I\+LBDQ2WR9aBZP1e&SSDOLd4K^A>YQ
FPNXS:H1)a87FEGLeWTf=C0>>)Z[^5-WP.D<;Y9-#C.,cA)V6D9.TT(I:FGU@.W,
K&WBN<,RX=/^b@QDO=>;7:5@@Y/Qd+DJ:QP_@Q\CL>HU\4>LW=TE6+b9L1X&)H+G
aMP,9?<-A@E:1[SaRZdS=^S:QD@c;R-=OM,_9QaN&=IG]HbAS>QG]+7b32\:Y+LL
<#7BbbK797R\X8+GRS98b&WPa^P#a:LAEUR-OLa]0H33BYGFX29Sc,O;Y<dg]L_>
.O]DcG3[.3W,c9a[bX3Cb?JJJ.eDg87:U_&Ma\PD&a]D8dF.7=7&OT?HE;e=9BZ>
H>CBVe.c+Nf=BMH)fLRG#E8MD0K?C=4\Wfd5,,^1@YYN7-5SQIDKU2K0?\WR?fOY
0dG4+,e-Hg4K:9D4X?8[JV&=TbIKVF:Q/PYA.N?_Ta/ZQ#83[aeI=WG&E#)MW)CX
gN@+#UE/-)HHdMRQH5[N.9J&JbS93.+WEXLbLIP>Mb0MI@MDA2)BA-CC1E>)T6-D
7-S#d-cJ]28fH(c[;VT:dV00K(+.&=PgHO:Dc@4UcX>Z&>K>Y\\O?@6bP(9NDJMB
^-W:0.6D)]W)[9?B^(fHg/49FI@F^)G;)4KEF1,eZX77@.I+bH^bW]L@##^B\X(a
(H&B65dPCYMKBP3SAHZ,6?T3,N(;W#&c9\)T\P[U0NH71KL)F#7gTMJP21LSL65;
36/0Y5&8QMJfWQbOcPWW9:F=R+Z9MY9I3f@79Kd.<DDTg22P0H@[BR3L&+Q,)IJD
]3&_.<&^S#-#SKT2T;YR>Wa:,B=LU_5K?7eE.Dc^O.MaD0IL6R?FP9;,MXcC\8\A
Hg]8F8W]4[A459TWM.K=Uc7,0e)I/T81:>9YS0(U?@]+FAT^J2-^D&ZBX[5,C<P4
9?b2++fM8PAB-Z-c^aY.CB0DRJ]>/QC)#.OSE4ZUbT/L:(NNW6d4B\fQQ/M6(WN+
@7_,R58=g&QITYCK?9,HE1M7af\^0Wa@P-ddSFZ]T&7^NeR9VI+bZO:([#cHI(NI
8^9bU77>eMJ/^?;afC119@9PZ1R(6[N3W8CRX6W.dAN;-WCaV2,g]<3:_5;0@LA_
B42g@^)T6/76[X,ff:KdDaVJUZN;N4O6#JE3N-Y;dCLB6E.@agIV&>ZVJ7e@GZ>I
JQ\NJ(SV0O?I0B0LHC3Mc?RCXGRX95@Od<)G_&6L@B7<PI_4Ga2.BQYT?U3C?,PO
CZDd@NED=X,+JW9.;0ga9VL.\MW;<2C77c3C8=#?6M?9B@:;4)7UW]CH/)\U);9b
Y:/H?S@SHe-UYQ#F^&)K_9>O.>D\]Af_&#VFMe0FOcW[HG36)5>6O0d([5e8Bd#N
5GVLW:UT@[->F]=2bJ>3b#F4ARdJ54U9KT8QeFU&O1dBPa76PU26E/A\e&B^7FfF
YP9Cc#7]0^P43^V&BbB(,E9/;,^0TO=:J2&/IL42MN@IfGf92>f-.6/B3AOJEL[P
@0::5-G<YT,WN<(H.>]KdCd8g9FPJ9LXf//U<98,f,F8H=>1M)3^aS4.SN-\D>1R
;:a8f@MZV]ITZD0)0BFQ8XPNIe-54/-R.2>F/<S?9cM/LK[/R,g,Z+[U<7@e^>U5
TXK0;-[c\J&g;(AHITU(H^9_B8b>&0f^.58K1W2Z_gOVMe/ccGBI732MSL9YC+75
EO=NUFZ38OG6[]a@8cHCM^?-6KLKD]47WffL_8.:9\B+2BG-=>H]^5Y&_b@52#[<
]DH^Wf4^JKf<@+V-K,TfN7[a<.O06V^:P+Z1W+;BCBPQ+gE[cX-(3gY(4EU>@3_D
DO=L1Wf6(M@4+#/RH2-HW^fD7N8>L)G1bK+Q)aR@7cGWG&F;QXb\1Y3RZe)V#^c7
2#VDE<GG@2.<d)RP/a5U1>=^+CFQ3fbM5B>)/ca@;7J\N[B1Lc+6gOX90(,FEJND
CfIFFTRW?^c6-:\EU#e2;12W;NUX35b\OI/<,05>Q^//Y14_L<DTK@[J[E^YH/@0
N(K)#I4&@-=0C\N>&&c3>(^UE^Ad@g<daLK\9XH?[?<]UCeee#a.CHND@H=Ec>41
OHVgQdN?)^?Aa57ab<AMD)a=++F4.F3K4fMc72,F>30^9c[LL?C5fHe9<#BGP3\F
90=UeUA/QTH#EGeO-(7fC[]Cg]0:)T#7:/#9EgE^f(bag@5QL//V1V69Y+J.^E(\
B2M613_OATDSGgd:Ed]7.S]/5K67SdP9C]VIJ/@0O#)KMY^?f6KdHJeLYMF4,0_Q
;<P9R,88-=T0T+?:Y-U#^XF6@4)P,F5g_ZcA.DT/J\WZB(>J4@+M1;.fT(/0fDG2
UZb/7M+Z[6f.(9Q]2eFTC-d<#4Td)UaV<B66cK6VHCGWSBY;@HAR9;XH#f4JPA7+
XYK;L_eQ,0;Uf[cVe^_/D?;eTF+aK-?P=@S.7\-JaU;,0Y+3DEXD;E0dP\eG6C9+
E0-;D99VDNe1S\_>8eeLU;H(VW=:[/8U#@-)_S1CC<CD+?E7YIV<_D6S(.JPGY?D
1W<dCYLY[CTY^Vf\RfSIH:bB5ZI);K\d3fMB_CJP^B;L&-J9\TK^e.3[)\_e_AQ_
cABAG3)[?79ZDea\86W_J7SWSBV&QHAXe0;<S0=DT;+a?YU;/?T_aHJTV/V5M?=P
<RX,H,fQS6#2XKB+;gF(&/(46.FGC&d^ccERU-AK/7_P>:UB+b[?#@8c>KX73[PM
^_>7)K@WQRS-OR1,_#?,P,beM(OfY_DfX/ZKaIJ7=VJe\f^&3/Y^OX.=c5R)>YTU
40VI\U06,514^Q&DKI](5g1>a+-R7F8/]]f:_e0T-=77MW)U6deIS9XHHQMa<&IT
6)&.5feMY-MYC.SGU03Ma5<JOGD/EY5M^?X-)_Y/Tb>Mg>F=(72[7LS.PUP13)+b
f+3OC1H@FKW)Lc9A?f(]2eH77-MD3Laf/cd20;LU5I+]5T+Z7A/?Z[:P+)]D1G,M
4+dRUbCRU:]KZNC9[]@XaZ7f1.De:GBJP+e+\,.1f^gW@R+IXKDA0;2HMA_Zg->_
JcRW-SF+cS]Q[VNRdDF7,\;ac5c@WOdW]Md/>]F34<^N0KEE4W?g?&3&=Q]\\JJI
A,K4b+]W+cOQ)$
`endprotected

                   `protected
+UK1AC?ZI.731::;#GJ@,GML=A.3cdOQZ?K766XfK]b_Y/J&a83_1)1bTgOD;>/g
CQXTI@M/aK37NX>Pf0>O1-W&2#_-KEg514LU02,ff\?b.fVWK#,XNW01NK^[b.NP
GME,SOWO>YO:G/ef]Q7BB/EE@Q-\,:7G\/]D?ceP,XeA<<e:NeY3UO3HP,:V0I0N
O7Y>6V=VR<Q:+$
`endprotected
                   
                   //vcs_lic_vip_protect
                     `protected
((R];?XLb-[7&eg(eb[fQ7X]gM:Tc5g\G/eC]J;J^J#6.,ff(C8G.(b17K\d(H+U
CMQ+-a,I.ZNB7N1b>M2(g]R_(P@=,NJB46]_D,-)CH068MgI7Vg;G4Q9,RYY&(DS
Z:5E=M[W?b^5M5UN[7&G:FKcN^c,M=[O_CgM+HeE@>M(NIMe49cE@dS1B4#_g9##
Jg2-2ZC=#e6P.FF,?La2e1JU&-fN<T)@1EaQ:\eD;b5e?;FZ<6^Hf#)1g_;BW8AE
RGGXb[0GaC@UP/L=58SI(MPb,KKDU?aa8c_XB0\gA]B-a?#OIe.BW</b3R;OW^I?
EPR>K4Z/AgXP.^B>[J_7^?,NMEKGaLO9ZQ)W+EEE8d(\APc#gVO(\=J4>fDS\UV]
e).8U46#OWENfgZ&)3-Y/&JEYL7aI>]>UG47UAeA)B02V9J[)V?:TO\;7NEZ,/BF
?Q^;AB4[?9TV4J-,2WR=Tg=GVC7a3X@A;HXaQg3[SOCMV[^FRLCO3Q:aB2,WBO27
=T#R?5a\OTO)6@\?P4]L=3R2+OIgB<>/b5U0LIc<3J^d;\Y_\R>V+?03(0LOW7/R
Fg_V>GSaXIA(L@67Z.C\IH-8/Hff1CYT7=E)A+a?f^\]5;Hf0e<7GCM?d-13\>?S
G3:6(aI_eIESa+VLB,(3]WM6A1)S^,a?bbXg8E9WL>^K:YSaVWCbJ>N.V5VK.;V,
BR=-9FBXbBF??YRRJ;=cJfH?;EO9f3eL^NY@Af(S2E;?S^aPSX@(:Q9S7\94D:LE
?YXGfCb.NH(_4><):bI8Q4E:D3DU]W5.R<@3=3D0L858D,(0E:]FG)KORFT4G\KC
9FPHV.)[3Qd1;gCY@T:4.H#GC@GV?fT[=f;(OGS3P+XU=<B\L44]Z5f-HX(DD4?9
\K?(AMN(FN5K.>daVO&N7PC?(LUX8\<NWB+7BTKgQUM=J4/AY;)a)5MdI?D5FW&.
@Y&FE:Y-H2/IXJ(G85a>RcH5^R3QT5RD_f&&OH[=M35FLW[8Vd.8J9L,.,+LGGJJ
O)#(&(4XN(#cZ>W,2K2cI#:P7IHAP+4Ib:G<a]BQG4^.--PAbd1#@/<OE?af.GKS
=Lf/D8S:>c=>CP;1TGIF=QA95PU7TE87]L<WZ>J3H:FBQb32KbHJdYGSAWUT6;5;
7P-Z/8<B=6e2+a<QW(ZH9].J5V97aGgYfG)bV^S.K?5PgcF?K121CXP?/FW8fEYE
^@cYd+0^Y[&);/Z0:b4<1MGd,BC1d4&G]WZC1-:_C/J/gW<^-F]M7XH]Tdd,eR:?
+?9\N&NbFL9.VZ6Qc&H6BTDb+QLN&8;;HU49._S1=7+MNL^I@;(Z1(3(P3Q@L(;S
bU_Z4c&I]#X(=V5<Bc?7HNb4PE1f4CS@[1:Sa.=c0Mb\R18T^,8>NE0G?AT\SD@H
[SI<::WK.HY^@4T&G]A9V=3\LI0/Nd;:5]:0R-8>E<f@;g6=g(Hb.1?(>dF7[+BA
Q<-g\I#M07@Rb/N?/e_L+PUCUX>3CQ1D85ERP7,RW@N:DP/>>HC[HJXV9Y\4I^ZR
GcN),[H&0HT)NH;O8Ee/H_[Te]d(5\SNYUZ&Q6cEL7RIQ#d,.LLE(?PH?d\IIZN/
Ia8(WEW49H^B6VV@HM@1)CCE8WL0/KZP?PI\(;TdZQ[cY7(CI<HBQa]32IIKSK//
3>NTU4VA06AgK0aLN^99^Ad<R?Y2#?LD]XQ;+:Q04>QW2=0RU=a/&V@MSI8-/APg
P7[Y-G;EeZ@/7\9f&6+<SP/g)_<53_:d>P-STR2^0)\(+AKY@HB_1f/QLEM;fOD;
[ZD#J+8=R.:e-KWH1N@EX8C3.[\VCFG#K8IH6;::0]U[2I]-Me<XF>UffO:P5=^a
gAD7U\6a^X0WE,:gD60,>@AVW>WYgRKQT_G8dV.VNZ0.fCYT;2.GSFQ4SRO7PN9=
PMJJ9&DR#\,H4D1g>9_cfW7bEU:Uc]3]:V9F=]B59<G#=9=RedDV4S9fX]#&+OYZ
]\X-X1WBP6-2L/J]S\8PWJ<DBZ1^10TR5I<TOKJ.BP#O,aWG?1QQPL08?&8;H_dL
<UQBF4LcIf9IA7/1/#MK3FWAHT16f2GU#Pa48=@<I@J9]Q.?^4fgXeMeRX?#]c:\
<]P>UA^SdVQUfJGdXXTaMHD-8EN#-\;_&W)fcQ?I6WWG/Z@:GZ(R3W#MRVISFN#P
AELG&3MCZ20Ua)/UGY+ab_,MOQWZ(gNaQSNSW]W?7KUU^[M^R+P0cX9[BPB9)b@@
@,a/O^(bJITPZPZV5cWP3Q8d4RAO,3X\e&dKZHb2P[8R;<PYa&RIgW+/f834[6I^
&S[-PbV8EaVa0R3TRPbJ=--,Y@G\BPD75dB1>6/LYG@OW2.[ffUL?YG0T^8F.,6N
F9@E:<D9X5GK^M88]7Z4\##(;:S+89?VG-OOH@YGS#D[<LC[S>65YGHUV8JHIWXa
Q4Q=M?1<?6Q4:g<RLLOH9AaO04Dg]4fK)I2.)G)1WOIC5^+IF:VX<\5=0@XdFgX0
L-K>,(,B+7VO>GU9(;8O>DV.d?\-&5.BB8O#)=9VfKb<GM?;,^0We4e6EKP1+aI3
DMNO,,8-/Gf@V>aRdV5E,_+f5LRB[7L/=O,W+X\MYL/()XKbc8QeS;TU9CaB,;=Q
L8-K(aRH>P<X0M&TgVCA5dC[7H93WPbb;&_IP(S,1UZc,]8?Z06d]B:O>T(&TTJ@
6L(=;?Q6M6KEgX\R._:eC_:2.QJ-2]:e/T6fNHTH\(Z@51\f6LE]#K/3Lf.<5H^g
9ZICC=87X+)U.?(Z1@?R0L5Y=ND#SbM8/XU6S0&QV#1)VMJ80aAEV3@[fgC0a.8]
&#)LP<\1=VU:#:_8VCC?9+Sg,5cd(UTW1J/6>Y1./O:Q6Nb-Z,).+&b1BFA[NC/@
+-[O3W?4c1CJd83IEDL18]4(32GYTb&NeNKgS3a)IbHFX?3-9X.:8fF@9VJ.DJIG
K-R#I.T@C_@NOg>&Td[[2Jf+4/?QbaF^L2)O4S0:H,b\/+RL>f)IVCIf&?Qe.(Y:
41K<W?a9W.fUQbB@-4R7gP>^;ZZ@94^d62ED<e.&U?6T#AD@(KZH#>L)<]^-&cM2
U=]0K=0[#JNfN?GX#ND]4V[BHOF,JSG0)b),V,g/2IC_f0g7PgCFPZ10;UL:#?RY
d#-HBfd\EOZ]4^81,c.0UM6G4FD9<AF/WDYWCM3[:B@AI7SbIU\)I4@4[PJP/G.L
Q[_CR&AT;779gfN#VZA,IP=CQ\C,C5#G=Z&0b\e1WJE-2AM>2<:,=,XB99dbAVb3
TFK&R[U@9SFTQ&L<ZWEgVJfIFBW6ZA_Y#F[ZWPgT-B?<+^[NJd31R,AKa@02Y0\2
2XZ(I3P2S3JF).<b&QNQR1\@8JM[\^Cdg5b#&/K=?3_f7E=(H[8eH0cBM,g):^9G
AagH+;Ab]a]?b?b(EG/S#W5/(<KPU^&O/DT3]VMafb4PDffFXXDA(d5PKERa_7:O
._[3G32]1:&3-(4\(IFELU.<0_FPY2bcfb.U1,3V_.F)/6[TJN#BPORSTFb?b(AJ
7U8KG-bg2Ub-@,]G1)VR@Z;>;:(KXVdG[;>N=[4]:=cV(1,_&7F2P7M1KNeT1J,S
+CJ)c@HI\.^\1,CeUEM5BP,V=9-ORg(3=^XJWaSTgK&14TN&Fg3Nc+IbcfQEaMR:
TeNYO_,S\0#dE2XO4Xa/1?Bdf2I(];OOLU>R<-<cg6c7/,677<PaP:]EMV\SR,<Q
>d]:6@Mb_F:J[F@ObP4.[6#OcCW3b3+QG.50)Z7C9[RVeB#=RPF=6+/#F=Sb^O,>
ba(LH@a+7^T<EXY=Ta7\)08>&^e]T=P(_H#)eeJXF9FT3?J+SFD:Ka=/C4QBb_NU
U\_78K=IN9RNC&&S]XW?D?VC7REZg]5H#7Rd3cOIMR;H#YI&YS0WEW1_2-W:c4;8
(T5U5>WeY^NH)#&4SU282<_H9[8UP7Q^^&>/dJN\;,Bg]4SSYZfSZO(f\#aK7TYg
0O8+M9T3SZYL0C7=,_)^1_X@KUCdN-GJc?F62/X/E)3#B1c2YA;[_@IKdV&WFW\?
Y3a=VS1aS8I@F47RcLQfM7=dHRaMHU\-MT:_&3JaFcL#_0=\3VEW9HEAWMUM@L\F
<c/JLWaQ;1#0@Qe7P_3<Re/_LW-9/09>E>UPN;3[e:(<#)@?OCZ808eIUCO[CeSD
:.96gZWJ7HZUI5KVXK^UDf(2B9c>(+Sb_>>5;=K<-_]E]d3&UR]+5FXb9FVH-#2Z
OJfU1I@QUA?9?cVWPbb8gL>1;M[W-?Z<c.,J+G9DLU_-cC)TNRWQ[;<(A+@XZ#g8
-I&)H,N,@e#fH-,I8\F#^cY>(_8Od8fS6/M7?>#IBQXOI0H&\3FY+P84Pa-TR4<Q
?aH@?<eN5#d=\E27N:d=PdZP=JB8M7(f<G6FN>I=)fICA8&=1GS<P)K)f/#FW0L_
#8^:KE1[7Vf&A,N&cKDHFBd^W,=3=d<IE8PEV.GS->5AV-U=Sef/DN_TB5(6Q&dC
F\GFDTfd,I0@<NW.=^BeT=+>fL\)9E>=1U3,VY,_G1B(X?a3YR\A9;Dd8(5X-H9#
5&Z++WKY<ZXV&8-DY>,23N:#YK;DF^/@UJU-)AYO8R1b3KcX>MPd4YWX(]/DR1E:
Q==M?aM4N/8XP@DG5eJb_+IJ:dAb(7-d4W+eU>N/+E5bde?RVDcE(4dY1]0IYQ6&
FS;N31<dF^dEg,[XeLX;XUWb<68ZE3c6[UG5>F;S22F+,I9V7]JP4Z<>=[HeC(P+
0OVG00Uac(_6F4P6QDI5;G>:^Rf&,+Fe/-e1PIE[OfO47;XIc?_E/JL.-^HKX]I0
9HN91ae.D4\bd?bQUN45Dc9/.W/HP_>+L6T3dLgKM.&c.ZcV;Z8&<J/8DI_T(L,R
_Q#J,\dI:f]R2P#Zd4B_TBC<2Wg/N];.\;=aM>JZ3M=9-.YF-^^?Eg?fY,[&NU6R
\&e6d98;gTS3J(d6@CX=^(#Sg<.CSgAD?-\Ce/@W8A<W7/Y4?#]XJ#c7cZ>4cWM.
MUA=V\\8&8+JZH2P0>>NX0QC0_CTK+,931M@H=0I/<cXIT7J6K?&X_:/4O>f/XZ9
IcG>S>6_bUMI+&g_D<[X[625VXUOe3#[=Z>+E5Q:^IgBBK-Mf)N&73[4\gbfW9I,
9B#@f:OX63KPTCOP>c<KSK9.)3K\g93U/b@1X_J)ebWcNGFd3=.MUW.6S-L-5;^H
N?FI]WI[b7P?DdE-f1F].Z2O>G\VO(S.HQ-/BX2X/[Zg#I:X1/,?^SKb>.(#O+FG
,S+cV]5=5TcCY]-J)Ra_A.+3+GHVT-VO6Jb56OGbcA\1_cSd+RIT:eDJeQCW2I?A
WWD9e8eNOLFDg:J3g10XePG-15N.SgK3\U+>LLbO>dNBT4P;a.1@dHdCN.YI4G^^
G)5547c=P??fK2Mb\1f0PS2@;bdPK1_NbA/XV2J;\0Pe:UdB2,EUJ#P)<9#^-PAN
1Sf#&f/[),XbUB?)M,88cK:;<&=E,CL=]G#8d/RR9@EM^V:2V_5EZ]_?J]Q8^QHd
.2/\S^#PDO0-aLH)07,\VLKQ#FeOG>6Cb7ODd,RZ\6#?K:O(0L5XS_BXZ5&=]582
3XZ\N2U6J[K01@Yde+Lf,;XPDC+5e\KYdgd4ecEC8@#YUc#IF;N7\>TTSQ/T2<SH
YHI#.U3PJ<EKeWgQVJ6M0-gVgJTDL<YVg6MG/)/#F[f_<GU=;A6a2L:T_cW0b5#V
TY:BCaEI)[USW2E[]R[.OBSPe1KKBTC1ZET[RJCM8?4_8@<8Q,MT9+Y,D]e=1T_J
(+,HBX3WZN@M7eLN04F?Mb_46AZ\Y)3#^81]-ZKO\00ae\c]M#LJZF60M3?4QJ,@
L<;<@7fPFUVG/>Z/:dT6a]08GI0S#3M.C57--S\==gGF5fXf+0KNZPdSK17f)OWF
]-,P#UGTdY.SbQ@e.([WLEa+SCM^V)c5MLU-Wf_NfJ^C[U?1X#U(5PbXbG,TQIOe
f&7]-J5V&)K():@P8L(5J6g^\>8#=AVT7Kf20K\Z1-4S5M:>#F>b-^aPdWE_&4.R
+<]#9#G7[W-cc-)4BTIET(,BH5\7_dKJ(F+53NPKT_]BJ=,O+R=9&6^TBW65WeHf
8A7M@2TW>0&;P#L2OZF-AJ(;=:eC0C?FVV>3^,)A8a?)Y3;X9(-?DPFK8@Y@;24+
A-Kg)GMd.MPN,Zf\_K7-^L<PaG/<D[8d(RBW6WRO3(RG(H=IddS<T5.Gc@M1@fDQ
LODfX-\<R<_8#U#_.:MDU?eB:NY9S.2I/(e\V)UGTAZ-I>7P4X&;9:OFY[WAdZfU
0<H]b.]Y<UO:@KX7JB[NNB+g4Ac@4#GD89B7GY70#4ea#(\]H=XFfI]N&M\HWENA
LKbX2[&_<YXL<:D-&4C1&TS+E4B[POZ/J-N=f<gT>53ca91\=TQWCB:8^&9)YIc0
Ja0P[dI/Bd.?T@<(f3]=NH@A8I6@HYdb+IO<,3&72f4G]X@O4W1[IPIII[L2_8Pc
.<0DV7/EO[<@-F/QVP)=,c26/#_JI.3?P)[B\O0\JJ#c3U^JW\BRS8X@(=D[Kf:]
FQV2N7](XU.H&T25[AQ7B(51Y^E<dJ^[aS[+gd/W^-&RE;aMdK?e\1-G@:JER@T[
[MU,E3ZJMADOO#Da\TL;4\SQA,,(4VYT8\G>,/dg0EOMFPR+Q@6gE&B6(W]9+d5<
DX43J8HV>1)^/QIHWaB(.&^A,,(.M?aIZ)#XfJ^9\UZaKM<KO3E&Pg6;7Nf:(e#K
.24eF6g>[WLOX=2-eeEO(?7g9_+?I7J-;H]4U-cOSR]#=[RV#9[U,C9af?SM3AcH
\Q2AbW6>5d.EAf4YSeSA[/S9NgW](@?99Y0^-Ad;^ZW+6:)MUd3.@RCKd;df3\WO
/ZaYYe(>9EQB>_3<75e.XB1+I</ff4cH(I^)Vc-fg;e<U:OXc2Vf4a\L<>DG8/&E
IHe-SFEU7fYb^BXB0[>R9>B@<8?(?JME;6U3UOW#5WX(0>@]c2_HTYO+]+HgMMO3
;P:+I.#gaH?TG:J?@YVfTcbf:,[cf&E<EYW.Y8[CdKAb5V4PTO?-\Kb#I,W,WU^=
I4b/2DJ807\MI3#a4/L1V5#cdZ(P.A<4L/1T.A/@]#(B4^_gB19+K]\UW_?@HGK5
X/80Tg72AF9;S/R>DfAa2-:\-22UR#LO^1_F2>/X^#>\8(L7a/XEeAU]bRZ\N/FV
ZG>NZGJ)RGJ++e[eND#c75GS)FX97\c5^Xdf,(9)_&9KT9fFN5,AFYP.5F>:N)-9
c/<@\9,+2WRX6E6NM3+&7KD-FOc[VOaIXNHJO7@AP2UC7<<6NMFBKEc1e^&d)U(H
d?1KXB4gA46U#DbEZ1G5H0^G@&RA#F>>d#JZBSXC<=E(S5VA)SF.:>BAaXQ:&;(b
3)D>+\61&;7]V,Xa=e3X.KIE?<>PgOD;QQ?/RANH5ET]LL=5b,#E/0XdVff6FEA@
c4OT>6Q5A9\P;:==A)2gBN:Ze.f;(>7eGQW3GR7K+NR>ag=AL/W9=a:.)e_:,fW2
JdW+WR;g9gC0_ge(K?+9bKVJT59IH#C]J#4Je1?7f-Q34\?4eN/PE.N#eOf:\5P5
R2X3J^>]S<O:W_20fN?#[<g\:B3P64G#0J<3,ZU4G,cdcJCT[G(MV_^MGOgH(IYP
QG6M8NdCUc[L=K,8+XZX?/(^#d6(cfd:\F=SZ:D[[W8LDc-Sc?L5Q,gF_Le(#1LV
4YS>4KV(.D)+?,18AS@\+.S.=H)(.Y40\)_EOR<O=92eL+X2:YLgO:H(0[FB_O3M
.2IK>cB\5D>)dR0WSEc]gOV0O;&EfY;32?<W?KR_22T;5a+##6DV>XaP&YaO39_^
&AV+:35Fc?IR]=1CSA&K6]B:\;fJH).3_d/.@EHBP:)CcGY>]g3N2N&JREZB_bDW
dT@_a0&</:(2CeU;FCTFVd;POT2\UN,f)aV29QY;;KK:c6[,7U<\>Y.2AE7Y@\d8
cN1g+\3)b6]98Z>7GE2Q,2^5A&G.b]YgV(;AXVWG5#/ZdLd+/0K_?C@R(9CO:^P-
]fVD?,#f9c6T5W1.D#/TYP20[.-V\Ag,=,N1(Sc2RZgA[,DQZOPA?3=GLaFAM_=X
f1bQ]58R.GM#Q/YI;VE?U>1^FBZS^V8-S.D.X6>F3]2H&[FIT@/aN/]Pd[OBL):R
\/L]\dXBVJE:IQ]UN4a,/[_/)_GSGSd+M[((J1QLaR]31DXbXZ]53KLB:IZ,;W&9
+^EQJ/e(Ob8J:SGJDFJST3EKHf[=P_]EVOA=DQaOAMfGUC5@H8B.SETKIY+DM@M_
T)(+R(Z^Y,>PN,/3&GH_)9,LY)C^.G-fP#+:@M@9HOVC<+J8>SOA9A^GUYY/(3:;
AKJH9,Y6S;2[7Uc<^cKO+e8?:/?M@92GAgN4W-0g>QP7AO[(4\8c+<DTM)1WW30A
3S1L[:?E]Y<e[E:1)(#,:(RN-5EX2M&(4HQ3bOOT;M&Z2&9<Q0O?>DBW_R;_\B+Y
P3ZNe0WE5GKOg;QgA(+-b;g+dT+[K_P01=Ua(H,9cESAcEcf)bVZ9,eTS#O0F@_^
14aQd0I3S7247H3[+d,QQ+=64NMP2BDcA=[Xbg[VV-F@Y&gV>c2e(Gc>QSXT=[.7
OR,2]],cM5=C4DgW;^-H+Q=]Fb7WK0ES5eJJ<R<KV;11I2HBZ9/TOTU0=gA\,NP-
gVKXgWO?/:@4U3C2NEQ8TJ[Z820/2]OZbDIX77d),29E/\6Cdc.>M_,&5L#_RSKW
P?4R?<K(:5(bd47PH&]_Y##(=g;AGDHR@0FO]QBNEN3S.\^<Q7./JE((O.MB@>HH
dCc@gN=O+Q@1G7f5.dc<@E^GcJ)aDaKKdAPeDWR+,JcOI4ab4&4]3;[49LQK/Ue9
3AFF6D<E54?]f&fbGF8eZYWQeEAKSf;XG)DV6?^]2.f6<HGN]gJ/R(F<(fHQFbSV
0+3eT:T-8-O+1-(?5E\-NVVNHGX5EKAAe4<e5TW>1-EEDKa3E==eXb2TCF;=SK#?
=_Je8HCP5NNF8b=:?^WY+\1H-4OZ:L8E;E0J1)=SYIVGD<>e5f(&,[)_<)&8;aHa
CM.0A3R<(J1J^EY6#f[Mc/N\7QR94,MHd?7#5aU1\@P23/O-8#OT88NaaaLSJf&J
5B63J5QS;;C)EXJK^W16(I[L7<bE-.[T??;<W#=d3.04=e7eEceIeL6FWF7/YUC5
e9-Z:Ac07bN[WO/=dK[Xff_,#B3#I?/Qfa1^(:+eaabfZ84;eOgI:=8LZ4\5SV>,
5=)3TT].2ed#R^CAMKf>(YT?PZGOECICN#25S=/A2:^W3e4>7ga/^#Y/dAUHPBLS
c17C,N_O7]gMX7>2dX<=e)3?eZ1PJ3L(NFRd(bX-\EbA9,SMBR+(+YXF(TId/:Rc
UBX5dV]PCPCe::19\,\U_e\WE@;a6/PcZF^+J9(Q/Bd]Xf)f.R.DJ#,IdUM_f+dY
U321\>&<5eRP6\1N;0IW>f_AP\7B9D2F);g?(d6YWXF?8IYN2]+d1Ca3IY]NS000
BBJ?T6)a>1OMBW-IE4OR)]&6Q1BgDS.5^Fb=[W4INXY?c:cJ>+7F-bD:/\Df:W/P
^A>5)efK\2AYf^Y5(W-QRNA06]XVec)[43c4D8LY,J+6S7B:]?e(ZD?UH,N+J28G
+NIF@KNeQ8&e/O4LTH4aNTgf+ERP261,Z,aZ]9XC#C4NT<&QJ\OQ2O+RINUfMF<b
@:9]b+3JLE0a6cbdcCgBA<X3QT;9/NU)TM0M;Q][UD^fX?26=4HRRFSNH]R3KTY3
d7]&39RV9Fe_Z(1ZQ]>LEQeI;baFHWH)+L,@[43]g,#QI_.6_/a&X;2MQDS9\<B;
c\,//Dd4A>)aY4D_7.E1N[X[=QN]eK/:_O/4:UT1U4FbE,AC_L?]?[E&&O=b3R+B
-Sf?LDg[((/Ca6&Ae2]JVX2]542=F.^5R;If7-&&^&0O],b0<PE)]73f]b:WOZ?,
=)Q:d=/8C@?Kbf4,f?5/]4RV+e:LDLMY1;V]U6,a9>,;)G,3e<0\9g-WfHV:]dIJ
JM[.2K[,cf&3O>OWLTaKEXb;Ca[a5VY4EP#1cO-7>cc[@YP7/_9.TZF;_2gC5L:]
;[#2;Ta5=2SQS]A?Tf30RSP4>D9I5UKBZ(FF(_0&)2AT&F3/.b20_Y[BNXJR1a4^
CaD.7#/PP-XWS7M?ZDO;UD<5M(#/e80UWdWX#62fK,VB6K.D^f,W74WP3QYI_BW6
@:.Y;2E_V&X9L(80CP3d8f+0]:NM?<N^/U^^E0?YH:,Ae<6;WLA21J.aW^SX:)Gd
HJF/JH&0Zc=X5@5,9LG/8XAW_dU.dKESGMPOB,0R=9d2U]eaI42E86^(WKY\VMEc
0R2;BT-6:V/?I9GP>[BV2I2(I.JRAEJSgC.#<YS\_^R@E6CU<;+]U_8<ZR(C]9e_
3cb\V4+P)+;U?2Z^3PHVB+SAX@Y.0=3)GUQgf?44WCYH/EPT\KV.H@C3_#We/XbH
aXE.N;GVU+#?[H]EKY4(;N#+GFE)AX_AP<8[#:Rde;X4,&I0U>6,<?4BCEP]5gQ=
MI[U@eM022I_M/Ie+UbYA7LOCM0<\-b><K\T1.^5_1#Q2-a[VK)VG>?+ObO9>\0]
/<;#,8]L0g<;5Mgc9>7\=&;3Vde2JPXaIEJFEX,]H8b]VZCCgf[dL_0I#5_FF+Ae
=b=(&Bf_L]\8(4VKEZV-Cd-?8^&UHa7Q,(_gK-:f)eOQ=;VQ.4JA6709]F0M3+6,
OUU?PaF90)OIG>/N<VU^ZOMWb+G)f02F6/CfV_Wc&+-dO[VP=4ON@Zc1B[XW3OK;
bTMN7/15M4+2E/SdO\0X\.,-XHWH1W(I/8N6Y2XD,f#]&YY(6eL156-JR2Z3E91=
BdDUV=+B=M.@\_)HKCQ>B)-Z:EIf#B\>bA_/4I1K)\U@Z[:c9OD,[[UIc2[--)[X
-[6(Z;[.5N@ZTRd<3GMWa1\^.1U>PMH=-e^^BJF^-.3Gf#LSe#H?EbE0Y6;eEd:2
3Z(?+:T\&D=6A(K.V)g+S/2e:,bXN?WXQKZNNYF]+cCH21:)JC>T-+U^(S4=YEQ=
&?4JS76?eLX8agR2BB)g7MBB+1-N)=4<fY8cE&gZL&--6.J8F^?+-8_:DC@RUK@U
aeD=#f&QGRC2^C7]CF8HcfKVQ1BKX[A:+[A2T99H,NfSV?G1\)D[O68;ea(N05LG
544;LEZ<+P6_7bR1B:1X@(0>0BY^Z+d,<Y[45FM.?M_Dc9QY)S>7MID=0ZF=B=L]
4TEVZ1<BgcGfBF;5]ZVPV4,4Ie,fP64(GdED+/?CDQ>dHScLE8Z(H7/Y(3)1<IK)
/D-dTMSTB/>b-LCG:[(.f+_[d(SX<K+bcSTN>.(g9G/Mg2<[&?3(GeTJK&&Zg-4B
8TgG^8M:P;Rfafc7bBFRSTFdW(8KUe;?5RV@#D9.5O?Ab+77S5a>I[W#.e[C67@>
JM_ISIB:;8gIf6=P]=f>G2T[,RQg+JCb?NM6AOTU^Q#f=^DgHR_-@\?U59FLRZ<V
E&=QdIca&3#4[9,_N2M(&dQZc-?YE:C8?#F+QB3D<;=Ebb6D1CQ4U)gX5NeR?\^Z
CX<dL^@dCTHX@D==4/LM1d.><9\P/bXUKF&C6VMBUQ)HK[d\5gdX-I_Q(:@2bEJ0
E]3Gc(:H0b>3J>17QNIM=B.I0EA.(]BR@MKS65bBOI=[3TU#0/QMT]9))567F,Pb
/T]YGGSVCEBX-Y0QJ_CKK_=CQKG<3c^,K?@G/:FZ.423GBaH,LT3SPT?XJ/\=DN]
ZB[3L1<ZUI494?Te(d-IX(AOdF;J(([\E1NXgC1I9,bM;Le>9N_)e&62N\H@RT#>
.dB&FX^RU_X-VFW35[M?QdDN(;<af]6_(@BO+gM\<Lb#H_#MPDZ-&5EAR#A]a5cc
4NSUUWAbWSQ07.fU;K&668>V.&ZM.9P@-KNVV(JDH]V^KF17ZCaGeeUfbU\UD@RQ
0(U?ccNJWG?W784gC9V=0RN;?5G-,:TU=ONQ)N3J,P=^[Y=JO>(D5BZ_8INR&Y<B
K]4B>XeAWSY+D_^CX&5XJ,YP8bdL7AFHHa[B-N./OID?D+69_\TXdeG^6dA_ILYU
4(g32H7D3BKZH1Jf5)@9T\b//PCULbbc.Z(:O0+VO?ZcDg,d+CKE-@QD>dfAN47E
[NZ0-025P#>gd:PFSGS26_bW-N<M<HO@G^2,W0QP;UA-[NWB2O+<IZ9b9bWd3M@I
9WM:+B5)H;ed;GH[1VR1WC;[Y_@8DL.HG9/WaO(A08[#&_DXf.471@cf_6]?gRYE
S/V6:IV3Bf3Dc<cY[N^9(-<TF46U9e#QW;c972c;0FQS2GQ3G.bI9><(BB5P,@SR
K9gMOe,cfJE4@4I/+cMg<Ma_,]X8(>5=\cE5B/K=J5UVN@Rc81+e2<@#@H.\4<CN
+f)-aI[S?#IgK+=YY-#H#78<g?Gb7Q)f2bAa-3;B1H4@IR(US9ZGBFMNQf>9)<N#
<_MY32HCZ3==52f]Ad;eC]M2J6BH-AdZC6<g#@VUKOgbG9\7@&=T881G__U&C5PZ
ZP;0(U_-/D;ESAWdg#L.eIg8?AJ#eI>Q79@I8>ZDA77Y<7<c@^2UAL@7;ASII/(L
(e9#cCM:16+V[KcQedb_.?[>NNU3>1\I>:D/O8KeV.NdR,:cV)EBF)(>/CENF)2_
cE(I7+b\.6cUeH>P[M^d\88c_?#Z4PY;-0#OQcLD3F=?U360+&Aa<.WbSY\#dO57
56b8aSOF59>GL0]VSO,MZ:aJ\YB9N6dP/^)[;5f8:c^.\DP#]IbKa;Y<U#?ZHMX-
6ZfDY1LI@1=2WWR:[O(<8NILUNCP-UICKBLX.8[78L_X:JX&.I._>CHX=3,<YP_;
T<V[GPf_</AXQQU[-QMga?1C)2SRPDE0aS9O;/BV_:XH(<Wf\U@KL#,He]YP1\b@
BNCG7.#4@Lg-^QQ&g2aZAS_@I&;-\YW/1^ZSbWHO351GL]\4C92FHcK7F_ce/BC6
Y<=_;c6W;C5,;6AIYf[A>#RaWY/E>S(;</8.>;f?28+7XBIb<_&&T37#<.3&8IJ]
U7cIK;G<>KQQRPI@P.(J[F?I>+gEf535=Z+GOGbA5Oa::?Ca[4EH4Z##e_&Q+W8Z
gf.fSb92XGf0J>L3<WW<-?g1.586\XdZc&7:Q9_58>.7<c]X+\&70g-2&)\fRW5Z
Q+-]/RP4;BPScE<d^LG-]H<)>H^S-U,2VP.TS3LC,QGEcVJH5#L6<3]69F/E]O19
HD+)V;)1c\52<Eab7RA#09]=5e#Bgf?EZ+DDN=8B?T?MK)0dIc6Oa:4f&I4KXQ?T
HJA&ObB;DGc1O-K:/e5[#&Z.SCJ0\=cH0YAV>P)Y24H0E]#D@FRIK#,0U3MKg/FH
2O)L3:,V;8K^UT,YbOWBf]C094.^HDP,YA]4JB(4I(U(,-9/\N0OM5UK1/<?KYKe
@@LE5e&@#@L,&fcU_-,I7&N@:C[E_3V&R.>d+-:N.:-HGA_g]&6FK>C;gbIff5F/
Q)gb2d3B6+CJCPaGaEN0M+LX;QgTQ#N0L?V7VC_Q,G_L?BL9:L<LDNYVA,F++4\/
,PVb.X^<:2fM5Kb(=.?,P.^gZCC\Zf<O06<#fSGTF)RGE@5(.EMf7Z&NfR51RY&Z
I@\?@,4S;3GPO=(<XK:L<XR)Pe0-#_ME(NJRA,&C09.e#32HJ)O0<Hb0V:e;/Y&)
7OKH?K+g[12YbV.=6eRRLV?:TZE7f@:+#E)R)>B1C(#4eM)Ob6ID=gQGCd=JV2Ff
5Pa&-[_Zd5Xe2V9]DcI;.gSL2(6HYI=:ML/29WJ]KJeWDO-BE>[<PgGJ80Be#L3&
<T20<MMg/=D9ITSZ3>L&#dUY+Ia3-,Q_\=OS)WSN&-T18d6R+^]V^8>U+&L3[K#H
b#+TOg_H^Ca1I0#fb/Aae8ee/ZC2:44;=WX&]b<fgZ#I.)N-GD@(a\7=@)/N4,#/
9\a^Te#034VIaQ@F;#,LCY1]8#RS=SF91)J2EARDf/Y#7QI>f=Z;[@f>f_]ZD?3H
/91S[A>^NO/:)[_a83W+J)J3&.H)^[-e&A1DJ.bdTD]1eL?aAO7GC9NN0f[(aKY-
fbgP?H3M\cae-/##G,7A.+KcBBfAcX?JAFL)6G/AH=aC(=BMZI\/#U-GB7E=5a[P
9c9+0IYbHg=42Y2gB\U>C8-XGZBEKe6O=dGSe:eC#_7M_.\C9@b9A(D\2BHeE]QK
_:;@O6Q<J10f#A)D.d6F\CKe4<6,_@-Y?&Ze#^2F/BKYL@;\@;\VG5W#XTTVZ<@Q
R>W[A51T-.eK^MbQR#cX^4ZDAF_)R7e6IFQTTM<PB/^FN;dWQ=(19_P[S9ZL(7A/
aFWK<B)PBFZ+g^]8fM8^.S&4KD#5,1GUVa1=3PE2JJ@WfQ)U@dL2SQS:GO_E?^eA
]HS+V]>g.9253EgZ<Y]-?E9-D8/[TZe+]1AGD;Z2&dcD_gGKHL<=T(H0Gd<^.\84
G;(_0CR[45EE#-Z)MEJ7UZXVY7LTb:NF1UT<(.KEDJCeO)SXA97JAd;YW@IPe0_/
_Y0^<UUFL0c^<+(b3V,EgJ[>/&g6LbeF-GeZMa6LHD(XX@Rg[7a/,@7VIHSF0876
KC#-Q=+V>Zc=U7KN-Y&6?-7QF1(&&=3aPYTfG8>>_<f^YKb6U;6DL1#3QC^b5WI6
J@D03c<<T/P6cN565UbD0ZM:6O^E=^>.[X;.[F[=<WN\gV=?UJ@3c5EN##:(ZG8?
(?[/MAAUd8@E&-)H\=\f_#HWVA+N:P/9aO:[AED9VgH3^[c&\5=>Q@]1U2-0M)(F
2@:Sc(cLH&GFVcV@;^WMgY;2D^]KZ(RJ9H(RITCP\6F1I1A>8__J8.egYFaQdYMK
-7H;+U=3M:O)g6fe855=Oa-:0NEMebeILcKQ9eQ/3DL&JJ;I)U7#Z^R)1EZF]AWR
ST\(;HV)DENL?)O6^1L3I8EOA=SeG\[RW3=LSSGLIgN4)9\50R__7:28:N]6Sd50
P177LO-Z-PB?ebC<^0SMW<FePXWRUIV3;.KGG5\X2NcJ2FGUQ?b]..B(SV&S1fAY
;O(9+O#.=5g^W&B@7KX=PLUE=1FO5IOaD>;,GcS8VQA7EbL2L(3PB8@Ng-_Y0FRS
&RG263Z^dU<EL=(2V9?==4a,HI_EO;<9QQTGK@.+[F(_Qc&LHQe&#RWA),YG7@-)
@UD8,#1865XQa?8dVaG6Pe9Ub/S,4;R75[#U\CL&VJ/CQ2N:Y5P@R^cPcCe([/eM
d#+8d&IZ@SY_;G_9J?A1<^E(aQNN+Z&11;6]4b].#8I[f?4+aT]?N3U0549RU=2=
B[5?)gfZf<T>&O.S_31c\?N1BTU@33:1g&=+[LV22fP@LL4FAdR\S/E]U0G-8I;J
d.\[2KO?H3)d05TfCec^RcALa4E+-9fU5>f4W^WTWO6A_<>&P&O8L#(VO<6(V&Q1
F(g<b>Jf].g7W@;;7RXbYQX,J@C\^SJ(((CRd<GMRaX+;/fS)F^fTG_@./<dG[DS
9Z-)(aeW-_1VOUQ+(e55C>U-[JBSO5?dFO-&LY_TZeL5d\CI15;2Z[fAc9PV)Q#>
<[\K0=F-[O&5gB8Q5R=N@^[V0WfGT95.M3=:MM((;&M+#UUT0N;Tf50PAb9)Q<ed
7^>6gH-AU&Y_,+HA355I_;1ZH-PW;PR?P\6>_W)<b1K31.>,C@4B>AG_6C?BH6=.
&Fa?PL;+96PS.P05?_KKD1YJKV?H[6Ca\ZX3Yg9a6fbE^/SM54I7040(bVYa/d#3
5bIL_f.MJBQTR\3)/2AP=&7ea(OY_8H-Rc?eRGe&@HXW=UT;86/4#9I()6XNO?CJ
)@LBG3[8U(VLWYf.+G3&fM18dXcVXW9,+3X54/I_SWUNf,3>]8fSe1+5?P@QF:PE
&X6G#58+\(B2Uf@M,JHfgL\e_KZ/^OTe>b2R3];E.dA,KDZI^OP#8:/8K3E_O(b=
[],;?]Oc:IaEb#f7c6SAHRVU/;/./@Fe12Sf:Y8Kd?GU3\VL0Q?2TVUOH?0^DgfP
d^4S]BKZWD,Z(:&_X74T=CM,(;be=YW\<aQ=2W:edQ@6POHDTcRO-?2U3X(#cAH6
b=3LHdLRaF),@\O5L#_#01F=0ZND?QdGHZQ,_eCFJYOBe2)/O8[1@<ZD_g/3]7Sf
WB_Z>Gb7WJ>G\#1^CbLK5R\(?V;bNB>;(JK#92[c6,07GH5R)S;4LC2NC8b90X[5
?.?NR_9&ZCF/W?U=>8a-T9CW355<#?UKB,QUc]]&,(@LTNX-8c?UCfUOIGTddT6/
2S&6S7JD]J4Y?Q&^SURc+Yf0[EfT[T7[G6eO^FQD=)?L<X:f)^O[:EMf0@5>9REB
3U\4E7A:+JW>KeS13Yf)&T)[)K?Y5^4UYD49]3\X=c,/GRBL<HcY[Tge,;VDIL8K
]#;V3,Wg7HY>1K@_fXIYdA-UgM]4VGSFH->cKJXJO[JJVcX,dEbG]7e#?:;>3\67
V11YY+@;EV2C,UaEeV+86QBQI(SLJ&ZfJfQZb3GYKEHV2&>292#V1afgCMS2F)?A
44DaK78X[\JZ&2^KU@^KWa[I1_eZM2[AU1bULY<]H)0>FNLCY,5SSc#>U\B_-,e2
E5[D.PM.@@<S\eLgdW5g5G;@B.6PZ&XfG3Ha9c>_/.32ZDA+>a3@0-F.+]L_G5J-
,S7T&1<S7S(T\c</DfKcdES7S#ST+B;I..d8((C.KM^OA@Y/:/LVUXbSTR=08eJ@
d\Ya7)9T-#8@H(e;88^#8#5:1NdF3bJM>-+\.;E7&3F@;&B7;5)X+83GA&O=YN:N
2e7.QBQG;(21EXEcf@[ZZWH#R.d-G\WYBf6S=eUU2AJR8_)0N03G)2_Y:d^@G7bT
81+(0PG1?-?e.KN57;EJIQ@TG+0dI=)b<C,J7S1I/#>=[^:/Q=X.+-]]W<7H4EXR
]5?+Y:^)PZVCZ5I,BBF3,cR?56&][-<C5+(GSU]241Y-H=\^DJQG;O@dSa:@08U5
.JbPO0:AOB2]H&A_KfbB+,@4PV\WaL4.aQC99/3>b?.M>71@b<&I=AIfJ_2@5CA0
K<71US&]5b\XDM;_5)-MZHU^)^PP+)YC=fS5B^49WBSUb;UQ\SL5ab,d2aUe?V+W
7-Q-gUH._XRP;:.HA+dV)bZIQ4E=B7R)3U37YJdVdSVTN7#8:5GeaZA6+MII^?aI
?XT4;TZ/I.3^?L:?:IVPO&aT7Wa4e/Y;9EV\GDVZ(GEZV[B1A=UB\32cgW@&2HL-
cUCDKIZ6_:PE6e4X2+OD&#e;JCG-J<b=+Y(&FO8KQNf+afg1cbP:#@I2;4A_&LV@
,>I[SI?&<a1Q]2W=HG[@dFQ0\(:bA^D/,QHJg6:Ug?Ec;g)Obf:K&CO6\;dB=6WY
CG-cZTbHb8RB\D:1#Sa\Id7R6(&@M]ZA;6(,N\1(8Q++f[&LK\Mb;-bYW9#6T,IB
N]a^B3EX)>N:(g&^Q&aQCQ]CdMQHV#1Q/N1V?X<fOGY1G^FE:0af_LO1,/.MVN2E
EUd#?\]:GQ=VQ8W/1Z(G)&+&#GBS=TPMg;,/\02I0U-)YY.I_DZABQ+Wd,>WbLFP
XH0D/YH+g[G+a25V4;)H98GXAV1F&WKFEXG+MCBKg+#?O5-AfbH0B4J+#AR8d/Z]
O.+?g(_.QM4(977]/_:+I#A2,f)/=OQ\[,fJ6X2NeGC5G/HD7HU()Z244N4QW0RK
0Vd5Y.gQR9C+I9RV/(>b)Q@7<6CMAK8E>2Y&PfA@JgUIO,1>RS.<1cE;1>ePHBN/
)[DF,LR11KL;L7@F3NZ>WbAB9DXE>2GL&g<7/4T9=VXLJ>.C_5(fTU14T\1_7MOT
GNQ31/A-5JB5P/R:@PJ1?g5+N.F_bYT,g-cdHU;5BA1J[HBQ8?TAM+_<A7cVN]XQ
)Nfa6]U3=,52;S\/4PaOMaU@Kb=Y&O#Qd6WK3V,_6,=\cJbKFW,Ae@QSZ\DVf?:)
e9#3B;e)7=QV&68d(^7E[@VN;QQ\SDDUZBRIQ_(EQ7KK),_7JYIOf&=f7O2ZN:N<
^2I6#5Z_^:Tb(UTe?4LGa8WJeA#@<3J>?Te24+dTOdJJ5,g2ZKJ4#F\LLQWI&L(@
Fa5+9;eaTgF;f>g>Y.&:_N;U=,WcW<?@75RI68MQ5OO?5VQ_b,E9XK@.B@<QBY&:
X=CUBAMXPO\UJT&4/8#Ea/5DRJ;58>5a(W\O06PCNUb)M?KP.SNEORNA3eL#Q9P#
T;]L+4d#V<8VJP.-PLT<0aT3VLfe_JC?^He<f@c:OQXcMI9g86\,?(+7YD+&I/[B
+dG@.BM5C#]5_&BO+\VDa]9\IL9]B7RMC]=?/8(+@OA0YOOBY@7D<<CE+X3VTOOG
7+/Q)>XO+R+;O+Z6\PM@4;Z;3[;-F+b6&cIRO2ETB6XM_4e.0K@/NIO?g:?B1LTg
_\\AQ>&L4),ZaHY6^(\O]]+_[]1Na>QVV92[/>2M@-VPOVAR)UIfg+Z-C--1AAgU
=/Ve1WAG,g;CVA6@QMIJ3<IY5gN?)?ZS):c+Qa=KLP0aNJQ-2-GZLOTb-^C8I^eB
/QUC:5:O.\0T=33>U/fGZL[KQRIT?1>-EcY1TYL),WJ]cc0X&eW<Oe]^(DLX&6Y_
5I(4cC@(Zd[-L@26N=9=OEgA\T[JWD=-E/6TZ8R@.;MGRM&HL/RQ92fL5I5A7We^
]2D[.O1B;3ea-;OB\XYP]L=aSXUE^#<TfP.-Xf0+5\5<M/RJ^g))+<E0^1]YZ)C1
@X4Y^__?><@.X)A\Xe&GJ:bZDVVBWX)X\>7K861GR2ZL@=-7UEGEc._L(eccFU-,
gfY\TTQ7&.V2\#Oa97M47Xb=F9-1N;Q;-40^9QK_V@CBO=QCAK5#8SEV,WTJf<)g
=Ea::WaVNU[[5TTN1(QA)CXZRL25aae<bd_765RL7]2RIJ48TN-^M[7)#^@]MJ/K
P4#T5-5@9Q9SH(:+G:5/NW.IRM3]9V_T@dHJ#+c;4#AHT/X3J&#S)e:_>&W6T_=c
EK+]\73#fc31+2Y7WC^S;\1eHWKK^>0]b\8JUfN5=ZCf0)eUgRb8R+O/)Y@T5O]0
B<9_RF;C2&&S__#8SePgRCO0#bV;^M0\\-51D_>5C9=M@M5W#.<2?W6.0;fgY[S,
MX]WTb.F\NH;(2MUFXJVQW)?\]WOb]C;da@8(&T?9&P-S<U(6AI;XU3CFa.Q;e\E
?HF)DG[^DY.J;eDWV=/TXGOS)QbH.\)F+)EaZ&b^P;MLRa=ER/H9Vf-X+MLD34)A
F=)>PQc09aMb.0[PC:&\UN8.KY\affL_POPY)E/?3E3QC\NV)+L7R&W;Bcb:T-YV
/]R=L[>1EEa/]618f.-;CLCY62V#3N7OW.FYJ7bQS72fMU+_V.[-:7DJEDOS:b7K
J?K?eY\QLWC7I99<6g06,Z(\MTT.TNOIDK:A4KZ8YMFSUBdKaeaOC:2RL>/V[gS+
TN=J9<&LW8E83CR-(\X.Y67I\f>WG/\FJ.Rc9B,94/bZdO+IEJY>X#5E^G6ENe4C
ETa\A:B6+LJ)_:1C=_bH322AM<87T=DP]4(/,S<,b)g4+@&WVR>E2f,@3U]fY=3(
TY(UKWPXQG4I,.e[f:g>CS>R(Y)g0aC<Ed4[)UC?HCO^>AIW>XS(4EAKY0ad81^b
K7L]#0IQS;AWFUB-T:#7K@ZeE_D\9(#I>^XN5Ig.@1:3bI:I@#+e_:c#=#7(3)>9
dN2T3-0GBGcDJQRdgZL6H)7+^B2YV(SG8eXT;1.Za.:/4Z?a>I^_WRfEaAFXe6>G
A^F+;,:SEc_7M)deC,295SbP\&b,D83X1BB&P+Z\U[QY9MUEW,E=MC2g(F3?de=H
6N0H\BU7g@B8746XW^9SJZC:]&?M-AEOPYLfRg>CP>[M7)_NJ)VGGS+X]Wcd5D\S
A)8CDN/3_TZ=7)5VH,e>(]TEGG8:A.+1#;fKJSMOS@E#7S=e>2b00I&5>82WT\52
&XdY&Z^V9QJYB-9=d78HP78FTAKH>W7WTg,X_]78PE5dBNDGf3C5ETOX=345d:=^
T<TE\-9U12GcPIGe5?XJGD^Qcg8:KDKXZa<H8CRedg3:2d=>9N-<Z3VWeHV4XPWN
T<V#2ICYU&SE;/_@\M(6HPUd84MG8CQ4d-)?F<<8,+_G#AcD8T6^-J1?K]:)1f3[
O44>0SK[,AKN7fbJ:bHB,^9\&QP4@B8:Q#UECBDH@5TBNVMU+Hcd7(gJ5=&03KfB
AN?8YVB)8R/3V@)WKB7d#?^]B\C14(,5,LdeD-#5RXL5cZ=YETQ+&@eR/2R+]<A:
B#+3LN;_,-d4A5@1OGF<,;W:3ICY]>0X@]MHA,R4J&_]_Q.&70^IV6#6I6<gGc5e
M#5,JKUV+XF/A0.U[S@WDNe=[U7FAQ\H\eH@,.?aZf?FLc1VZf577/QF&IP2&dPJ
G;E;\>19LPSNf_YdQ3ISaEE&c@WZ<(+8MGc855G].cY-1f+:8_=TDQU32e^@XH^-
B(7@>c6QUFRWZ:+0dCDP:E\<f_:2e9>LI0Z,+gGCPFP?F.VK91#cGT&e#67YFY=D
97(AU?g3eJ\PC;R):F=D,MIg,O^Sg/^)GLWLRf1^M<P-AA\<_DE7YZH/K0F;^?Z6
8V-G:WKS9FB=J[RDD(8e??3\GYHX#-eNCe_DU@b#gMTQFTZUVTAXAB/TbE1e0T9@
O:@88^d]#E+eGKX:+65<OLf.OKR:4d?2MeKb+MLV96@S>IdY:J8_RXE63SLD;Q7b
cM.+VBJRdU)O2fOJ=/b:c?I?,ZG:=>fR.-\^U7W_g@(W/ZT/VDUY-2b;e_6EH?OM
?8E&Ha6-Ud5V8[R<5e:;<JR11Gf-AgbbXU#<=\4G,>LO]gR_\G[\g]US[OcBZN/9
^M=Z:HVA(+C0A6Q\O)Jd);JR5AX7P/3gf?3C1L:Fe\F632)54W>S7GO4LE1?B_OZ
;1\92-gBLA^SH3_KN5/LH&:S.c3#KSd3aED0&3(JGUe3Ng+be6IZ1;ZK>CVaIK#d
-b6cS1(f=OU]EW5&E>Of.,;cJEQ8\D)c9VF?fEbUEO7OgaA&cRS?fFg2TZ&6g?H:
c[4]eUV[(.C,1(B:9KHTfIU#-XI2WE)d-VNH;LTKN>g0M:6X2N60;HEH^]D36_/J
FFL-c?B,2>#CfN^5g+&0>M=2gEMM_/E_3?K)S.7OHGI-Y\ED0Z&>WdfY2eIW2g)a
ONb:6PG0a79K+eDNG2@6;GVbU3O7d-^)V9?RQ99)6WLY6:YS?N>>=3L4Ic;LT^;?
4F+O(db)^L,fT5@L[P95(cW#+J&^P3YFJ:f3(^M_.NOSK?^fA<6=,AO58EFW2HZS
VR0A&.XgE;6(^MCKa)C[NM<KI7c;BGRT5gHY\>QZ@SI[JC@<>>MZg3JIUR1&cO.4
-SfPZ]dSP@KKX)BdY>AM^@K9\+4^QQ(SKdYT;:/IXBVeI)T^YWZYP5S2^#B8SELa
g/AQ7aI98Sa&RYX/,?T>1N,_C;?CFW_]JN#[((Y&<<LafH.NJ[&L,1IYE9]G2,_O
WMOVf)]=aL9:OP)\;P.EQD&-@2FDf<V\>\5E<+IL81GT)>?9a\P/[aRWEAIOPHA-
__U4F33c>58;(47KcQYCXdGJ6[9+.7A:]S,WN\Hb[0CZ(KTc:-XeO6(;(+XO\HJL
\7N4(Td<(\bFH1C?=4AI[NB<#)NR.e,VbLL3_,e3AD]W>QUPY9/>OR,MVSY):0\1
Z2HA2-S;X\<>Z8T.0?IYafd:,_#P=H<V_8CUC_&JNMOZI0dZ2^CPNeUa;;]P.G(Y
H6?56U&1W#c;>NQX3K.I)gLd=SQ3J_XA2G4TR>(dD#46,]NYPf3K;9AN;;JY[/G@
IZUNNL8WY_-(MaLa3&&)<GX\4&+&9&/C.4ZD3a<A:0QMH(JOK=:ZXeH\gXPZ[af2
E]0LN-NB9?;/+/.MAIX[\ZG2F#L-H_/TZ3=cXOF8PG^R>OI,1bbcQ[&d5fCa@UEM
b9^S9696)9>N0GK@GI7eOOYL-/A6ZQX=Q6G+aG[RDE3:]HWZ1H&[g1b[Xb_7(.cS
P#LK>.G;#fD7bP=LK:4:(Rc[=39,f0E.=3,H\X7aPN>Y.(P(=<1.MF0KYB8^V[g.
5V7W40V?gR)><a;3Zg.[_/(@3JX2]1Y0LW;eMB<+B4,5IT<gX;;;+GSSJMbA\8b+
A9CA9cScM@)0]M(OG3^(@fTd.KF8EUTdT(EUe=+.R(6)U:NK0]N6:=63D:5=-g/d
6PC[>XbFS0D@JK\7KDAT^N-RC_THZebV6.g/V4^Za&-/\GNX:14GW8eYg)X9Keb,
/IgJcg2c?4SeUfa<c_Nf?=TgQ,.7SGLA]Y^H,9#aYbS6UE[TJT#COF(]GM^gU),B
KTMZ1/[_H[ZaIOMbIZ76g?F>.HdX,]:UZ_#6YWI7S4AfXSB/@N[9=:5.Q_=.4AaC
B:b.O[\g-Z,OU:P&NR@?Gf&1W3X7#T(?AaIc-bQU([S9>ID(D\c4-d5.J$
`endprotected

       `protected
=MWI<D=J4_-b<8E5IYgAeYNPN2bMb=EFbFg:fBG=N.d\1KT5A1[C2)_/U.O.\F@T
[/9P>S.+77?6d(bM9ScIb,?B7+^M62+8@$
`endprotected
       
       //vcs_lic_vip_protect
         `protected
UEQD<4&e(S/&5DWH/X]:MSa.ZCbU1/[LS6a3X;@KBg_KBg/5bTWC5(T&b/D_,A0X
[;C/Ra<E9(@5J],P_XbD8.MT19QY8PcIdI(W2g[FR9QW4,&fRB9]OcHYYZUCZ:9<
&5/g_)ZU1<]V&)\CX]0O_D_D9GUMQ;&SS?L#)g?CK85A.CDK/b2P3LIK2A?]#)Bc
4HA^dCL33I?>.-d]>2gDa/[B.dA/ead-gG&]#d4_TE]GXZ9HI2PM[+Q_cLaaR)LF
g5C;3^a&;AOF58.Cg<ReVH^A.E7RB#&DM<\VRK:;bWf4;E9VHSFfX6TN0CC0C.7g
@Be^PTQI[D31+=a_FCC?[/-@=bDHYG;T\1JW\Y(M/)(0O;LRMP>=//Ce7<BWf;ON
H@X=04cP^]0OW@3=;J[\4DfbC?ZIA<gV5W0XMZ8J(F]T=ID:]NJ]G_]=#>Y&7]b3
K/((6b=Ya\]ON:)-&S:cZb4g\(++eA,]76b2\/cGZX5P^C]0B:<_O66EC8cfCY>T
XZ^e)UXdVF9)+U#Q^CMacW?J&3=K8UR<9]-JRg-:X,?Uecg:S)Q+BfcWAf]F+A9_
OFX(Lc5GU(5d(6VB7DaZTJ9:1/1&f1L1DK4FMTB]33XfE?>59W]bGefC<\Zc.AAc
1DC>98bE#U6Z].FX,AcWMM]VM54J@@=5/gFg0JBV8Vb/Ab/[2G(.^+>C?B6:O1=7
5H];b5U6e1>CGOf22<HSRK.6EH0\ac1C8S&aIQg\02BbY<VGT4FNb3]JL,;HNEQM
72++O#HIf2-eR5J6?LT^-B5X3+Z:^;ZMb2:c?MDY_&AeD9.C2Y+6-6DGVN.0Pc4B
VNeH>Z4=J4ZUHS+R9:U::51b-^@K+)PYS[/,4TJSD3:JXF?#FU/8_E]L=K/B+gWH
_/bDG#)/6;[=e-BF7Xcd=7E?dY_X^X7:#K<GL\f?J)U8f)T0K>OS7aIRJX^O\X[#
]Ue[BY.9<R5d=c(MUgG#;>@=dEN34J/7TSS:eR<@]6:G8&QP3(+,SNLFGgJ=aD+:
&cLeeFGJ10IfL[Sg8L49V(<0aV,^.=[(57QfABJG1+:>fUXNQ>9-?D96,Ng6V[D_
7DFUI@[CMGSZ55B5X8K3/)9+beE&U8C4SAH1K-#)bTg=ITST1)c7;/<4[V^[07,M
Y(IYE;>Q=XOPG.g3Y\2.6Xf^/9>^70,_;e@3#VUKb6\@c@AE?:],,P1V.<\8=,YY
N+6TP]BEQYD-\&e^G1Bc0XDUL<De,CgNR;3Q1BFJ9Jf3932)?S@DUSNZSe6JQ:BT
&IcK]a^G.VLa_:M23eQY#]2Zg(K4ae)2DZK--]\XO?04,W4P]C[f=/+IB?=,??C)
b[EfZN.Pc;+De5N.>EI>HJX3T68GT(2f082H?:EbJM93P+/V6\;T+?VgCgVG)S\L
KZSI9bO1BY((d.?.ZLE.>=US5W1T02I=b[Y8L&2,1=578HB@+JSQ2Nd8BPWUC^9D
0V0=D>):b&LB;U])M+&D)):&Z.f@HYKI]VPa,B1/a8QBZ-SeUASGEAKHCI&0aZSF
.DEILUDgJC6>gJH3>,QWVS22T1PQQTeMFR_C#XZ?b=/1(O:LdZ(304,P-62Ja__9
6OR66A;TJK)/9RNbWe4VU(OM9^=6\a=6XH9<Hf=a58DK;69_6[YJF@Z:YNg[Pc2U
8:U4eT+PMY3-1)Pf\?^aG+c3M-))NN7_;.XZ(Y[HRNa:P[+YDHYXY^/A0K^:RY@1
B^BO51bFT76@Rd^BbOHN=)FQKHO]X..RGSE<2T.X_<N14]),ZWLZ&#6CN@Tb;490
(VQXN6#F88N6S(FM1ZMXC#+)#A7;Df>&GJ?L<H4==[8QQdF@YMF.QG,81f;V-[+V
>.&.gB^1)Z,-,d2^AcP8I=29&ZR<+:^S3W1^QcRP]b:OVN=N^QaZ>^^BFdB(9\70
9>ac.Ed+G)_Q,^..7IOKRT3aCJ-)7_S-L^d&_.?4B2,(O@8#Nbb?=aN=Bf::<N^/
M_RHON:L^_S^.KW/dE]?7V_5?;&ZEJJ?\gUZ<\^0<YL[6+-6<CKbe7B>2VMgO42V
a5=BSD+>J_PA3JT/d\[?VS??]8=NR03-[\.15U0LMGF5AABJ+2<-5U?YeTK^/9G:
1>S4=9F)+PeP(;7O/cY,=?^1?R[^DZJX)F-f^S]93c\TN6RDE>\Ad-g\437.TMVW
OZbP@YKg8/@Ig](7K)[g(B;I>J^??@UN;aVEH5eB&^PP_gX>(Td&d?J8\QSWQ:Ng
JT7e7fBc3OA.5=-@3MRT,(c>^382gc_W&5H4S;eYg0VZf9_=]B8H(Id4U(>0W]1U
YBb;K2(/FUOZZB2^6LGYg7G7F8,5aZUO,2K3=aQFZ3@S<^MD^EOZ6<?68@6S^5b1
BEb6&8+7eQT,.IV14c0OWMgCXPcC=;Z4FD)81W/27KA7gT\8TMY73;?PL_#ONFM8
K)W;H=0ZOK-DB\]7F1TF8VXW[40,aEZV_R_G,GG@XWcL&\<g55:g42Oa6^E3@7bW
GARHd0PQG-81g]H/,R0P6?L@Z-C6HM)JAOXFI4XR]Ye-ODCS(LgWdJT-1fW73_2-
)_-g&S3^D^10_<P:_>N]aTIe(=;N?SVJgIMJT]QQPN)#-X8CMLTV,;J3cXd98G5>
]M1V747[1U^YJ)W(OD?WZM9X@PJ@bC1dH?YNc>\B=L8P+V^<3R-IOZ4LZ/VW:D?Z
(ZW65>MZ;Y><JUNY@SH>YRd).1Y08/c=01PK,Y20Kb^VZ]Wf73eUPMd\YP5WSPc;
E=Z6R@c>@Tf;IY+_AA:Y53dM<K[KMfdZ3ODgM6YRQ[a0<@E<\QDE-/[XMF)6GSA0
HAYNb#eB04T#JFcO=<f#E3#KBBDHYKU0>;<K^.f@HT17[&OSP]\dP6[cg<HYLfIU
II(+ZWJ.>eb&F9.V/0<[MCNIG#-:>C6@<F-:3\5#JM;FLB(CIOP<e4MG4CfbcaS>
Je)aE9EIcGbbFca&U35:,+DP)FWUcP/-P?6\6^PdF;5#_:Md(eAP0bcK/(EJ+NZ/
9CfM9G?ZYI3NAF3D>[Y1Q;6b>8f)4;WGD,V[&5>4L9<6>6,KL9][K\ZGL#Zg-J<9
gcR1HbC_=7fI[:6=X2Y)D([e8ef\A?+&fX-I:KD5IB25e5=4A]W:E.EX]dI7fc/F
<;)3EO:;?AcN5P,44F=SZ1?S^;>PKN89=H,-)4I6412PT>CCT/G:W(?YS1[9T]fZ
FV(O[S,O2>Z1.a>FB2O.bDA\4VR[)]+Y.W=G60@?4b5_YDKJ/Ec:IHCP+A;8_?GT
T2f+dP]_T](eVg@5c4+>]>G.Qcg0)4H?(JN-/9)+bA/W@L-0&U.@O_F<Cf]\Z(aa
5/H[<]Y]Tb,Z_]_K?Rb-cbTTfbL6d2aA<#c#LA@ELM-M>;)-=YC_cXK??W[PFF_,
LE1GU1O\[AJXU).7KW_D@#U6.g(>N\C@NU9[NLS7;NdB-29Y.1M1ANMP,?c(C0)G
V/J.?#5@cC784aL5K^?VZGgB;NI&?]Ag7UVH_aT#:[Ga?a+)ZQX465P=b9NYKU>D
T.[P<A65Z:Ua0TCCd0<Y[=C\eSZ?:2fc8IbS&:7BG/+-0E99W=S][8)]/^1.F6T:
-f:T1^T&UIYJ.c3AD-QcK2Nd?2RfW_GAE/CHTY3WVHC&#^9NJA:)fNRW5a\cZU)<
HM0LY&GS=W\Y;?3KS>ed/a:&a4:OCGA.NMe\VL^:>,\fR9-K0\TK-A&EA9)Z>BH1
STN@VO@J]LBQf&&:#P48cT9YL00NP?IIZJEV0c^/VBgO<FQDYS3/&,A_gY]^fX(V
@A^N9eSd5^8<gg?a9)GC^<WUFa]_7SAL#FXDGY=6_Ed(:4C,;#Q[4Pd6/)>96;MV
;S\<W7>9FVW4OV>O<5K[[Od4b5Rb6]Y_MOO<[T(..KS&FEf@)0egOA4#.Sf/0(:,
&e^JD,T8\F]#G9<(NBUPcKd\<KHSe1WG?27\.Z?)8dD]VZXa/]RH#2E:6OA6SF#C
O)G53;:IEJ5-J,S4=&=4QCX(M9BSX<#NQMQ^JbA36TeT/dCM(d5[K5;-P3N870Q\
19?GR>>C\VfM-af]]<3,X)IP5=S0EFY;#Zg)M+O(6IR=HHPWA^34UQ1+(;+[\Y5S
g4@B1Of#6>KP_@WW/\T[J7(&^ZO7H<)E5\.G31Q=PbKM\CdOHT<PG/eXgYLB\0I\
Gd3R\#>&S<?LG-9^&H59=210JUg)cM\QSXUG4A7KGC0ILO:R&?L,[<2:6H0S/;WJ
-1&AH\0,I^U<&P<.dL1]=)5F@c28If#@bAeMD]SL>gTG00STU)[#9]6&A(H^f.HB
WI:J1eJ-XTSH9/>f3G)DLgW?W23cRVO)1-JKeC2),&EF+:JQWP1(G)JI(3KP8UEZ
f0YR;OWPGEE(\_:d5f;6BDJBF(#<[bCHX7.6(=4#&?G#a[g.Lbe4_-J/+2cFP_I&
?G=9P)LQGK>T+EUfX2;#/TT+-7A/L=O8VPY<YNUF97^X/dT0V8]C,SMJaJ]BSLY9
R[a=NO=4-B&-NHMV@?96b;H4M^Gf3MJUWYgOAJ)&[NY.VQ#+]4bbTTM^edC&IA;N
PR:V>9)P4d/I8a-VI_;8CIc/C=//gB+/RHe26?fA-@[cV>d,X,@EXR8[X\eEYe^F
X\Wb/<TG<]_.P0d;NMZK<N&^0N0L7BZW.fPe>_AfMaS9=2c7NdQ6&J0b0G)Cf1?)
7eU)6L+#2PADUELI&5&)CR;c:cM=f#>b.<RXYD_VJVecW53IFgYN,.FB-;XWX),=
7PE(P#(RA?VZ>Y7+T2>0>fNA,037/L9bZJc+NG;4I,f\)D&20,2d(MD6Ha#KS?X^
]b.@EMPa8\LY]gd&@R-RA[JUF#,M,VU@.Y6RZEJg?bFM:O_S+RY^];_DLG3T,WW(
@1[[WPZMFROdcQ-N]>X@JO:UY9N(bC&(1T-:c],K+#7bgQ/.8A8;._E#aFgT0_>@
6-I(,eOL00a6C\]DaQe#=\4N5GV6Z1@Pg6AIAO&>df/@6M_@:^7WQVK8Ce1[N74,
J]0-VPQ5-ST,Cdg&U>:bX@6P>+:HedMK(;ce6(MWUYYEZ>d?JL3_AY[3,16Y0#c=
[S)2[eaRG34V1Gc_K@\P:HD=G>#[:37==T_XQ4W<fT6]+2D[dgLTXS6D2FG(K(A)
aA569^M.8EY-_b\d7]7RReHgBUK&1&WG:-0+^f=-aK,UP[[XTSHY63@1cEEfgOFE
K=N1#6UC=SJQ#^\X9]<Z.<KG8>JZKK:,(-Q28eVY5M=(P>B>Qa/7K_?FJW;RNM@H
,/;K0/2ETb8B:<C2@AN9P.eW@3XG>/?0N6Y?E;FW6XC:1e2UW>?8Y\g7?Pa6=HD7
=2c?/2([AW?PPa_3C/6BEU6.LZOMZ3Q6Hg/aO;Q<2;-.86a=_;eJ:A?EB#&_g-E9
.T8^\B0f@S&28V>EQ)J/<9GKV0U<26Bf]CS]L?:[^Y9a3=U0K0PZ2CDUM;EfJ?31
6+gZ4X@R>G4V(ab1aRSRDFET,;U,&]IM+:cGVb1PWGOG?KNPN+<EL2M4^T9&?N_a
5>YEXef9.B19QceWe?,BV]R=TN[T?_B]#C/C=eQLdFZQ0bH/#+VJF62aCE)3D[26
J]_(O#SN#c=<_O:FEC,])IAb1;e50GJ<D(S<)<FMB_FN9NZF2D-JfK@@:E0g36B=
C,M_b^NROLWRf3ZNf\Q9MZ4<c,-,U2c2Q9b]USX642Sd_OSZKR2,6M-7@4&+>QO)
bT_G:T4/@c.N)V,Z[&+V;)AQ7EVbL#SNb-;fQJN)X;a-^RC4DV?KR;]b(OE-fMUR
T_[:??dLff45FR83-P4BA=^,TPLU4#f,XJ2\(BOd\>AP8EOM[B@f69:=P>bL&fg+
PZa[EZLTa;aaD3YEG4Y./5/L@IZ8R2T;@dLVGfR@b^,G_NDQDUBee:CEg\/=&T;R
.eQKDFC2F_CW;LFSbL?;2EVR+8YS@.f8gG;7XS.NJKQDe(ge:d1L&T@4fDAbZ>3K
-b67@Ngb?287A.?&&CQ&a;9FZ8TRX)E5Z_b-R9XLg:H15)Ra-@a:D84e2G[U>SeG
.^bZ<TRSUb@5X&2McJb/E>H(=^HVWIBd\e.G2PF[4@/F3<A8e(FZ:3?g)P^(M0@C
(>UG?,Xd<TM4g#&ROK0RPcU/DJOd&a[d/.F,e,+^_[Y^J7EFb#BD3dXa2^KCg(P+
ggN.>7Vd7CZJ9Vf)K>>SQC4ISU]NV5Pf24C=;Va@HFPbM]V)<IR)MaF#M2DZBWUB
HA00,0]SHTaH>96IagC\C>R<>/P@_5:6<+<J\>;SW>_dXK>/8g]0BR2=&&[e6TdJ
#XL^e@abDa]&4fRdR]0KgX,U35F0++CH9/BR1d)>:>-.MSCLZeA+ObX7?H>-6C5/
VdVZ@#_6N;6YFYg]?NJ]>,<&NRbRM1_.EYU,@E0;V67ZEGVY\IK0&X8=C,EC)/>2
_W\)C?e?=5eX,46gLWM(OXTETFgGf(\:@b0#GcCSOV^M4:X#2IaT;1E24]dESD=8
/,@IM#\N@g96Lb/,4a[gQ^0OY@].S##CF2^d;.,[K>5))DOBa>Hg,WSPKV>DNfFM
/<O-?S7)(;MOQ2[))ae8&C2_LDMSIZL<EdX11)]XZOKP,daV4dV/CRKPgPW3[1[U
N14:F)gfQILffL<TTR::2Qf.7=QES:Nb+UV\(#BcAG#:(AL9/6&75(D8dCD8TCA5
a[af&.dJL^:d#\K_6X/.^c3^3)T0N,e_N<[>?F4T9?4[\+HUL(@O.LIL.c>K?A-L
,^Kd#9f6AQFTT5<PNCd]d^T@THXYKB/ZC25T7CL,KBD.O<-M:0MaZI15A5Q_)A3#
@H>I?YMLS0Y-8c78:^V_c6IDeJ;JW=Qf.fKgYP@N3@D<?>?1[KQYa?eeD7KY#<6-
019;VANB;#c3VIP_H_-&]YW]ELGKXcF2OR+YIOWKAC_-c]e^?O)4>RbG_^)L,WXF
NJQ2.[,JV?YO(KZB2<83AgA#;QgZ5)gY-)E5_+:H\#9N2J8Cg0]+13e4XSON+Y5Z
HDK@@Se:EJ?I?XHD:R8AaR6TDAZO#7FT<9SJ\?GZBd/K/c_#,UWHC#(?(32Vc#D<
>gc3;19NW2#)9X8L])gFSTT(/)GdT=T60>=@L2?6KRG:J53eR-6g&-4Y?CCOBA@-
GV.gLPf,6+2b::Hd/-Z/<5_3Kcbb2-#2aKabM(Z1MFD,B-MKX<Y66G^,?/]#_<:S
AOMI[.[)gVU2^DD[WZA=R9)PS+U^(Z<K\314.Y#XJ,<376:CU3)#;,&BHGH7AGK3
Q,AD,2V16_@NXf<ff3FM5HRL]16U&-9UD-9,]:dB-M&ZEP<#OaJOO@7&L=BIDHOU
:U7]8[B&(77^UE4G=&N=[Jc&<+^H5^CEJ@@/d@e=8:HIW72BTa7gH+UK(B:T6&&5
c#CT6@+>KTXeVB2g?.8e=WXI8[<_G#OMH-SId[O)<H4aeQL1a-?#e#U</BLYA^C=
&Z3J63]&W1@.+cBM]1/fKT903^::b->F_b3WGgbLTb(/@(6Qc&b5AVOPW+f[E+Y,
]K,+[^Sg]UdA,+dN6gbX5cIS)FVHABcKg@bY,C(/S[\8gPL[Q?f^JX\VJ/(-P?6D
@0E@F1^P1b,?8HaTaKF<(Z).;_4J#PK)VBC,:W#.WO#(R<BaH]84XOT\U@X@8EP@
_eBRJXZNW6O590#C((HKB1Ag(6KC3d5EB0.#,VO)>#[B-W[7EWDb<]MP<O2c^GKX
JBN^6:B]UQ?3-b7AR+^PR03HQ#><gW=M[TbA/N1;N1[EG0R;^gBHXR6E6Y:@[YX.
=MMBG&W37SW-1WQ+d&a:#\4:T>?LIBX(U#KIWceU-/c@8AANc[L(PRS1[O7W9@-F
/F)<^<@gWTP,Ng:WLMC/6N1bQSZeZ[=<IF7,RHWF#NM=V6HBXVb69_fF)6SNLSD7
c.gI_Z)4<7S<P\FTD#[JON>0eQI,:REA)^FXVE.:M3,>^KX[0@7MT-Y=/EbW7d97
C..0M99fKDV0fM8QS.)O?\F;\e8SMRdY,EgO-DK63QfL8XU@5>D\9HFSbJ&\9J9J
AU?fg>O&27[#C3&CK.96:FGZ6<KW2b@ZAYAef.)AC,a1WJ6\RU&Z?2&9#9KB=H)2
MEg:03AK4RG7eWO4gF<bOOYWC0e>,A+C86>SM:FXegNQ#bUBAN5>J><D3E3>T)XD
3U@7K40L4OLaO@_GU28f2DBI@7.=d7FAZC<-40VZ_X;<EX(H>5[P/f#8f53\)-#5
dL1W9aBFH(a22E]&4FLD\-(a8:#A05+BdCfJZ5AO9F7Z?-VDYQ5C_b9Ae/Z/ISQ5
^4ZR[X0V_30)(><GTVKRd/=d_(8R#f-IL12TX1e+@2_V&:]^+Sg4Eb9U(GYTf:N>
SW^Q@AaR2K900IA@86OFD=2.3f0DUZHP/:BAdBbB=ZdYOCWC6+R[>2T7?,H5JfTQ
bb.c=\[J=;=3GRM541:>fLK3A.LMDTOaKKW?Jb17=T:=0Z+QMHFRb]YP+IUD?->:
-HRPI6^_A<XEY_V]_9W?K/4K+V7)36B)[6O8NV:S50?D.@#)b)+Y1eMf3,(93,VW
MRgfRC5_7G^>IIW3/EDc?-+JYJY#&+d1KZT2F,Za94IQK_PD7W4GGIVVeZZg.dB5
9NTRWC?R(7QeVQ(;+H.<ZOa1e=\9[Q>&KO_>c#O_3#TKZ2g@P<34E7>c/6_/PWaM
e#22ZT&\g#6WM+dR/;X@\:2J#PJ/cH[O<T_a0a]S7g\P]X@Q;fR2U8gRBY;.ZLPH
TMV1.B74HEX<X\_KQT5e8H#\b12Dc6dVIBAHBQ>E((,[VG<(gUFNWIE5=7^QBDDB
a+;&@\RB2W1Ec7E&J&+JGW88EE9]45;[FR<H/YN06NTPGYK6TI2@RU5HDB;JK)J.
[BH)@^:ZgKU5C,0W)+]FXZW@XUO<CQ.RII#8g:PbU7dc@_fJ6?74b:P\SSPA.#eL
(KZ-B9NKHfA^9B2g3EBI3aSJ2(5SL;cf3EC2X9V-K^XM5XbUUQGZd\71LP2(UD,M
ZPZ/)Gf:VSVG\ZdFXMWW=Wd6YaW6]g;^d>O#.@_[,Zae/.EOGc5VEa3D4P5\SS:_
LDG]=S2C4G]Qa)B50(LaI<V#TAZ&8<\(Y]Se)H&DR3@NE24BIQ/6@I2ePaG18<(S
dHV,\D:=2RX:;86B(0=P=GRJ[6ME[gQG;g)[HCC<>75KN<4_#EFC26ZN]4AJ:90X
\/\ICN<:KSN?bW=:,.UKZ4QT3VF12+b>\.76&/65NT3^g#S#S+>T4FID?:&5fH\X
a;C097]?JTg/Q-I#9dcNXagAb][1R)g.X>&g.TZ)][,&_([_8X]\1CRc>Y;bfNMP
.9B<(<JI8(YR4IfbQ=<]7W@)E3DdW:1(\ZXcS3<?\X7G@)gFS)Q8<LK)_\_EPc]-
<)N&IZeR(ZDJ//JW/O,EISJcZC;8U7HfTSB]49@FU>Wc?5PIdHVY((G7&LP]3MC5
01B9V7+I;Z&XgDWMH^OF+VE=?PFY6EA9:g=0\(4)VD^ECG=cGK?G+&/80#J3QG1(
b2PD>:U>Bg?B#_<aVPS)O[a1PW1?>HH=NYJ/H7U#L8M>)<-@WcaO5UDQXQaJEZ+Q
D_-=?+MUR^R4-],g[@,IM7Zf,>3JGU2/b).b;/A4V:PV+IV9U5HAYdKJFf>MEdGU
B+@c[R<9+H>]V?;[C(8Pc\I>@M1FWe42Ue35U,-Dd)4?/,.H1OB.B3U\125,]534
0=EQ@6S&35<Q1<fQI#H[QW#MI_[gCe_E#-9.8)eM>8JYLAgKH8f?#+[V0PSe,W96
c:;ATBb5^RK=XD7/Hc(K-Q-868<Z^VO4\,;GCK>+Pf;#84>fBU_[\8V3KZf:P#24
=-JR^E@##)8V7=YF>=gX[4.^efa5bS)+2XBd8-9#.-RXHeIBPd97O?=:TP+32)X)
&,EKgG/UA=gPWG,#N]L@A&UgWWYG@;\aD=C-&M3J#9Web@FO<,8=f3:6ZHJU3Z,S
Dc8[-/#MMH2JODDFA;I=W_F_D^?D;A\JeJ1A5Ce\?/X<XALCOR@gXYZ-E6EM\LO/
4[TV^U:6,/c#YG+?5,15#X^Y4OEcZWX-^aTVQ?<EKRYKEI@_MeJ[<.(7.<&?_4g7
YWO1RF[+K#C93HCDY=+T-@b2ZKaP,H0Za42GLaH;K2L#EbLg_O73/@_+;7BMCa9(
6SX>O+\<0d0VV^(:R#9338>;>RS[,,OZ3TY3:)f7(P7QYBg(ed?,g@2GU/Sd/6C4
R.1HEAU^_UcXbRg_JdacO]4f9P]-2KE^?SSZZ+TOFe/cD?W,H3PF((dfAG^PI;;I
,EK4]6XF@Z=7VE>F\)bHgCTF6PNH,C2H:3[7d#U@ZL=Mg?(a53M.WCZ?Q-e8\aN#
R53#R9d17R09OBZ0B/Z)c31_ZKEdTQF2N64Q+/8#CDHL:c@(RPHX\NG+\JdbB[]+
#3;W-S45dcbDXQ<Y//H7[?[>D8N?NS.c;S:2GH63BHW&cTIe9d#e,eH8E5>66YAa
)HT7OcY]+W8YfVH[a-2#a@]S8UDDYLa5TD\\@gSXbfCfD0,8d)7<,3F.[e/,3_IS
_<eD\[B6HY<Q7YW)#.]H[Q-YEA-]b\9K+Oa87Wb=3RcT[O>b6&P-3gWAg:T&Z/\D
\8:5R_C2>=R0E+(b(7>?KgTU8^gWG.gQ7<85UcZ^TC[@TbT0e9.NgN;OP6I#6)L?
7?Wg+0<fVW]9c::4-0]_)[N]3]P?9IOTZ9B4T]C\+1\7(/>1K1<IFdIK+_8a-O+X
f7?;?3?S6@KO4N@?QV\P@D&LGS?KZGW=7c>6YN[W-4ddLE:dW\P)0IP4E7-f=#D.
E<UN@gK5/(([^=:=3[#daF/)_V:C0G@.RSRJ-<McZN=M@AgKf(PW&KNEE_JD;X@S
W/(e/S(/LG]3?VD2cdg62P<ZZ6G&<(T\[:7US-)8I@D@fVcO[>^6G7?]ZOG&TJAF
6PL@TL3&XG@U;Q2YFg_?QSG1B9OY2\Z>9fX>0]6USMb@G>3MUTU/d)U7.M3(B0Y(
Y(FUH&=C+e(7+4[8Z+IKa<;F-cA_PTeMP<HD9R>YR53RJ3bE]&KPM>:If]P2]X2I
X[OT^6-DSU0-G53^]b@TFEg15#^>-T)ZC,[]fCW&ZcJ?.9)b-b-C5+Ld5GKUKL?K
:edBMFT3cA?,S28)6;aF^C?4\YX/+ET+V9/A]B6@M&.MV=U^R\PQ7?);FS.>GO3a
^C[/@#>=W7>DI37GAVG7XJb[#@^7a65(I,HO]:?M^1+,_7]Z1OP&FbbSXXbL]SF5
-d[f]1bg1>,_][OH&_Z>;+AKfC=HSDI[dJB9XgfXPQ\-Fg[\b7_1dZB->ZdHa+-1
#QKOQYJXEFK3+DR7J.9\&FKO8-=M,VfdUAU(QL7;5G[Q1PSBgcg>QXDZ]=\@YO87
c?5_G^R98Z5e<;R9V#)0_MKFd]-E2X7G6-KT1&=A:#=3K0LD;PHc/L<_gLDF+X2P
?3WWV:0CN,:aL5gVZXGS+/8.B<[_M;CCE#J_A<I19,E,R&FE&UWf@IYae=abN6eR
?&#6IR:86;X)AMgF+^/AGYSU;LU\3,:/P6F[J+.7Wf<1=/=RMEG-gOE1(BSK/5TL
>@_PTZ5AS25Q,L&e@SHHW^W/Y2#67f+6gfK[.0S4E?EN((TZLG8O88<Mcb0:0(bd
Bebb8G3\PH/^a+83&V#<bMGP_NEBRJe+V\#aOSf1U)\JcH8QP]#,P^Q]8GKM&)U6
e2O98_>28=9)@Z;c)9[gDLE<MKYR3I[@+_,+b+5X^EB#[^@]\PD1#c3XT46]FROH
LCb&X2)#<;PfQ@/^L>gff#.26ZaW>0.?P[P;TYRO;;CL;3Z;]HES4UEU_aS(NY;Y
&#LPcY>JS0UG+]>bFQc-S8F01Y\fabJ-/6E/\1OK>-._95c^5f[Yf.@/Uab9D.J&
3(QZ7WCA.^5+[I-U=QRW,3VYcR#>b&>\]3^CHf(\;J3S7.;=SD1,)[&OYFRRNDCY
6)dJRd7.6_-[Tc6Bb+&bGN^32_IK[d-MA[&BSce60=>Mgb/VSSc1PDYe7J(\W7FB
@>1VU9&NUNIDL/4g@3N5@f<?LZN?9>2NOCF?L;c&KQPNe[\\T_SZ^OSdeSQ?3HU.
-47-#4^ZHKHQ0-fXA^(J;_Q<E].M/Od^3Z=;Y/LOXHUf0(X.Y:Z63Ya(b_QK9YHa
W]8:)9-.R1Aab@3M&T;31)E^RMee7?g2/?/.3eWD=5#4[bT74E2-Ed3DRU7V1OF@
QZb9d+aF9F9\Vc31:]9#A7]1a4U4]Q&c#V+L=MFX3Q,.>BG;C=3T)Sa.bPLQ<HCS
@N&:G[?FeK;0b_7eOY<:8FMD#FW==V)#G_eY9=T-9HZ/^:#KB8[[@0MeK;,C>F:8
_YWb#Mff/C\]EY73ED#,bHDCOV4e,cbT5BaJ9(4_c<8]#NWBVQQ@eW[eaVG;(/gB
eC-\N.g,2M/Y7ZK?9JQ)e-1fCM7a_AE)\EXaRY()S(aY^R+^c[0N4EQ#CGg.K>B2
28(C&0_A-<@SR,[/9Kd[gc48N.gA\+(&JDGPF4f]e;@5,W2BMeSaNKYA[E0c_&A[
WNg-UPcBP8OD#;?YZ/QAA7X(KSYI8XT(0=;[6YJ2+[?_fFN<8#,M35Xcf1DX7U]-
E[H0BGGa_YV(6]JVVFCP#M#/:46/O)TG]]PBY;42XFU/25TCB2MdD&f4A8O4EKM-
5RE6FZF\65ZFLe<JSPHac7AK-fQ-[XVOP=cL,Ab^43@-U^Db+<_+T5_ZCDa+I<4O
(&Cb2dBKbKW_cZTHP3[]NNU>g)JLT0RTJWCcCF:I#/,W^^#Xa>>L\E_[4Z,YaaC=
ZUd_(7CfB#3=+6Y[1AZCNN<(_+MJTf<@5d-0C6N2FW8XY?-gC5.W\9B:bX??geTF
9[Pg6_HB8M&4BKFAF]/X^-He-7W.92RJ1RfB-4QO,)=>OWa3<Y@8&^/0+3+>fQd>
4NT;HRQQ[D?HU?7Of+:#HAeZ24R6dH6NC,)YH+dU\._a9E_V5+^UMA8,W(5_a67^
Y=XKTcQ9X&P<Q8F7DVdO_^Z17GMC;/5+#6?^I&FP5;a-<,V?80VHIPZLRM1EHec?
eVF0:4ENXOBQ3[;G8>HZPe]T3>3&faeb/\(?52>68>:1J:;208A;WKX>I:SV?>V4
RD8E.G]eI9R((5d02>3AKS-#H-ZYYC2/[A9+QV_d#G?XVTb,ZI\XG#)/GHf?FDRW
?5DT7B;ZdPeMILS)0A\8BI-3PKTc9#C?-4IgK7@=,0c7G(&fRRB=,d(=:e/HMgK>
JPXHBS[8;Je3LRZ#\g)Q_ZT11?E\\8CgSG-6,M?@,_d.AH9@6C-512TbX.b9T[_S
T.e]PCL#BJX75K9]6IcQO929Z5G>X:2dF&gE?LMa0X)0TF.d)Q#B)\<2:[MHe/4?
;BUT_[2B&8;E[I@CAD84YO.3)V2+7R[^SaGA=STE,S-0e3W<UQ.W#)PgbdJ4>Y7K
8U7N2@Aaa(>g:cXVN;2L=+HP=A6G?\R^+I1,Y;YW7Hb[(6UTD^M@U<#&&d@_0Y>V
826-GgV9=OM&XZ_cR&6&P5F)(/)86YHXM6_YMBFT94,DJR15_FH1T\3[JgaV?dV2
7BOGJ/H>+(MAWO=_<G?YO]L0J:Q/@,G27;PG=:a)_OID4))+\,<]:TfRZZ]G&.)G
BL8e:cZJ^MG-&f6U:[a#@GSWW0AOU0AKS9H=de-^;EHPe9)^Y+HNP<+_bZA4S=^b
XBQ;F&2]\+[MYdOHKV6@MM1Rf5P/dX>b,40NR@I8eB[a0/<A<fJVRZ1cdTcK6UaB
B2]2R:=0L6]<F>\cf>7.MB2EM@=HZ451F5>@9SK>8Ze@+L7XH=VMK:D+\V\JKH@;
GNA\B1=Z@\Kf^NZSYHe>c45aGQ1C0X_4KI]c;EWG@@dW0AA;[T[7/Q,dA6;1N:[B
1(\@(\EY^S/aMT9O8SbO\5JM]=..:&@\2:-VG<;E)KB8RD.3O20]4SQ/-)BZ_\Y8
L[3\>Y(+c#P&-0D=MTL]Q1aVYcC9W]KN_6=Y/Q+8=7]OS0R\BJ&>8--YY(gA3U#S
JD)\6g=(S0A=cE>(489:F\L[SSS?U^23S@.)GV#\1N,SV^JXU[@G+1c/7U,6D_)f
MaFO:M2YHD.TCZfQ^[RL]c3>6ac#2@7+FUBJ+[38=PggDT)E&cPIKNbc/GffcFBA
[JT\T(?=[[IKNZ;c+_[beN&fFITgHf9e2BdVM^S(W>Y7R\?T8eZ<_.EKQUL&F9:a
]UB-,CZS,457UU<C?-><#0f/TZ6ZM+KfMQUDQX<c,:PPe^H,ZeeaD?]U,=(8FE(3
\b;8M\A.LM6TXgF7=5FD18SZL:AC.&QN5-WA4(D6H]O^3G/+7aF,0;A8bG);4NV=
Xa0F;+.>,T)T^JY]R;C/C#C[2Q#LfC&@HNRLV@9N[LfI(&/)J-MY2X:OEHbCZ.R:
\ReC#-aW37fP8IaFODJVL/4D4SZN@9.P#QgAI^V3ZNS.KE[&/;1KdM_24\,BUVfW
>WK1P[eS4A^CF#A.M1IdgbeX4W+02O>>J;@M6?=-8AN6K;dFG;Rd9(#fF#;^^1e>
Ge7\a[T=e[1d];^C2(+b@<LcG-[[R;;G(L#W&H(7UUG(f;O/^d=\8(64/dQ;VQ.+
d#3Y>g^fB_f5#-6H?D6BD(eDeJDLKTVF;dQA)(=DM21VK6TB?,Hb2N-&XMad+Kf[
#bG;Gf4YdacLP4@#&aedPOag^^a[;bR0D6Y;K;>6M3G_8QDZd81HL?F;@G^=FL>,
3K)@[F-gI[DXX?JFEBg\Hba,B.?J2K?c[G#?,H3#C#P;WE7-IY,=^]L&M.IdEI[8
B>@BSI1,A@[f<(,.A[J9FX_4)BM<Lb6CgKW8=F7_-P@FV6[@1Qg2NbJ@;SBBY5XI
3L)52A,@RPB[e:]VdNda4T]FW#A):?TLNDDAOSd0Waf:Tb1EfXM[2F:3cTB#UHIB
eO50BZ=CSY7[__G48J56_S@\8:fERSP9a@fG+)+I>g4PXGG9e,EUFC?U19@>OCX=
PbIF/b\1bd/9.\4&2R=#2GP3[J59=+TMU^X@8f0BFJ,_FTF=QL@G>(@M[5?7+H3?
+#9TfIIVZN#^3Y<9C0E>7EF,767MgUDJ&c6_8>THK[:/d/<1ZUBP^C_]P=cK-UM1
KLb>ZI;;U1e^c8G@1a/f+2T^,:c0YF4:f0-S<XX?//\.[MT/]a@eEDR/O2PaYV0a
=a)FSYLf(]&HS?BOd>@M)UAJ&++]2EVA2LFU6J@d+>1&Q:SZ3V0O0FG<ZA-?=\8e
Z\[Q+WUMQb\B]_T+8CGPSHHc<S_)cD.PRBEL9HP2agK;@g/U##d?L]#]ZW8=2dIJ
^f6)\OS8<+dFJG:0/c)32B7:QD/L6YgLf,U)473O.4S8UJH(/H:0;eaGTgdBeN.L
8:R219#-1.YBIB(7F3UDXTN/+X3#dFY]H/a^V+,Y/gR0e7;F350-4^04PdBR3)RN
7S]M[++e>I@\?.a0Y^N?a::(ZVK];BfMgI7N&PbP)XL#M]+4#3@N=:X\,;MEg3g6
2A9H:=2I-C&W_^a@K9_V_])UWE_YTRR#I:Jg84GG(=BD91-#F,K6+:::cCe&CR7c
K?O9C#W#:YFV>gMadD/7+\@JC?0@d)B=g:<C_-Y+H[-MV=8@VL&H-&a.)PLHUBC^
^Cg6f9G^>M49_2H1-da8RC8d@#^?I)ES+(.GVVC4;4a5A+49RI6M(G]JO;1&XG1E
-724_;;3U^I.G+UJWF320Fdd3=F)Y&1TRV1Y[\TTX29>^PN2KNT^7&XWY@f2+2Tc
=_=N]9RP?VI,V]\I\aC4^Ka:-P5@@L=TQ95JEIY.I3(=@c\(XL]Xb.+@fZ-RaH/7
2c/)B#38Wg>1A2c>7d.##ES/bU+HE\/C7)O^(2+)0?:7KKO^e4\1eR^R4f/0@>O2
V0T,-b^97M01*$
`endprotected


 /** @cond PRIVATE */
class svt_axi_smart_queue_2d #(type T = int, type K = int);
  T sq[$];
  T ha[K];

  function T get_random_entry(int offset=0);
    if(sq.size() > offset )
        return(sq[ $urandom_range((sq.size()-1-offset), 0) ]);
    else
        return(-1);
  endfunction
endclass

  /** @endcond */

`endif
