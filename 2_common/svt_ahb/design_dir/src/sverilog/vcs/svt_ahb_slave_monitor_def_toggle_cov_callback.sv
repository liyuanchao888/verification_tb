
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 
/** Toggle coverage is a signal level coverage. Toggle coverage provides
 * baseline information that a system is connected properly, and that higher
 * level coverage or compliance failures are not simply the result of
 * connectivity issues. Toggle coverage answers the question: Did a bit change
 * from a value of 0 to 1 and back from 1 to 0? This type of coverage does not
 * indicate that every value of a multi-bit vector was seen but measures that
 * all the individual bits of a multi-bit vector did toggle. This Coverage
 * Callback class consists covergroup definition and declaration.
 */
class svt_ahb_slave_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_callback");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif

endclass

`protected
>S)/a(#aUF)TX1[f[AP90@4c?0HRa<K<Ve8_f[D7bZ?A</:9GJM-0)>QGMV8I]/D
HGL@I?NLKD(gaP:=f=Z/54/1X=SGOG_>Mf^I3F^=(@.,NA8/#:&)N3?\]J0Y:/Me
8MJ.Ldd.IcETUY=^@5C)b7,2F]\^@8W8X_]KMN-KOSf/Z#XMJJ]H:F8baYIgTQ@3
FC<;<I.D1G+3V=W0R;M[[09YS]I,DMR:86-M9UNfZW0f+H.(S^FT_,6MNgG32VZ>
G.?YSH;,7Y28;f\BQQFHF[)8P::d2_Ba^@(VB+YE3A:P(N:]78CdY[UI,4d40)fG
#M:K-LK\gI&>(6[^D1=C,HK@Fa49IaWI_]WCBFA4bM&30QK0+?0b7]9f?EM7.SJ7
@JJLR7HWQ6URfd\OS:@VU\dAd;LCRN4cN0aeg/IDJ@ff&Q[.ZB>WP2PV@g3.O@0_
0HE>(P,;;EA4>G8d&=(8RgeQ9[OdBXYYNKB_DBE(4=8#=EF:#:RGdR)FBO5)F@YB
/LB.cAD\><ND:&4BLb]MLdG#KRV9UPE5#Xe#6>R^<5^aETZe]6]B0bQgSU49BQ9(
A;2#,W@Zf_3N,Z<Qd1DTaZB?37fM?G:M=e4HU.0F&6Y?8[5O,&0O;-KT?=gG^4II
V:XS9U/fPU8VU^@DP65^#@;/GDRA/17QIYc8<O88FG30f-,::cM-UAg=gJEa)TfB
U\OC7UXAUcRD)bSCUJ^F_@-9T3eQ58>5\6PTb:<4,EEfUUEEF4DC+NOI#W2K>B=N
g_e-,J9MbFG(43LBU5@1ZF_D\@d1d;C8,Db8(RJ_UCE#X99O];fZ2)5Q7N=8T5-3
=&cLALS25_O^c5N@G,/QF5Jd_^@DS_B87:]Z-YeMd3SL@W:6T_S-BV?E[,=23OB)
PSF@Jc3A?e&X2a_U;FK6W3DC:AD>7)aBICFDPP=He1XCc=:>WSYJZJdNG]fS:bdg
bS&C]#f^+K6#J:8c++M&I&CGJTMT&\.d,d<^B=)G].:C:KZ6dVU59(9ELF3J_^\#
g5N1=7]OWY7Eg6I[4DKdg#I2:GS=U)F9#OR=@aM7e#>\FQ>FNdTV>6SGf9912^d2
7DU)Q#RfJ<C(4^B&.N=U=cK?+.:LL@-b,5I=#R7F^E(b;;>9<9K_g.[6=F_fBS+E
&GaQRS[0EI?/d<6YI]XgdAR_GT])bU2(-,g:7;f2&2^a-CP?ReUY&b5RHg/M;+Ce
7TZ#Z+XRe<JZ\3J3=-0&^.bDSc0MI)D5O2dGd<61C7O5H3[:A=KPe[?+F1T(0RIR
IPcM]Vc]6B9NX)I7]KS0R4<IXP6.aZ-##EV^L3I=Sd6W;bSaV0Rf1?1H91NbfX1C
L(^@>e<Y9\C_WD^Ggf07Wa7_NTb(FT[7<MO;_T1.H0L;d7)>aCR>8/(e#cUB/2?&
)&N;d)[GZ;>fUA=>T?TT=gERcd=;FNMOKA(1F<;-F,^I]Z_HMDc.GI5K606OgJ[J
Z3>+,e+/VO@bQAc,\8L)d(H8A67eOOP>Cf-O5YSLCaMMW06>FfO-aY03R];XE0MC
PV[+-<7_3I.N)@7:@Qg_XV,UUTG2Rc-GR3GGc:>Hg]gB:a^I-1V:Q4W:=F5BbHFb
=U@#<?BI0/@W+-]Q[OO=+Q0JF_:cKE2G43^eZdLgOaXO/D2<b8,QW0NXCR(Ed_9g
_g+T+,-=GKQ:KY?GcJ)E&[,5EJT,Td)b_5.VXb^E_\<E04E]?M2<749;P,?B?08X
9M.@GM_B-.\3_<D?8<-BN4#3)H^GO2(EU/O9=T5VV3b+>MA0S4..CEX\]C4B+I.A
FM.SHcReO<9).:H&N<WfIPX4(O9A_3:YXV9QA4H487OZ^02J0]MOAI51)@D:_)Rf
NB-IV1+^+bW(U;::]?:B(.=Y,635.AQJ=3J+0I)K,;PdB[QgE>IS?M]V[TX5eAS<
?^Y>&B1-.(:g+9c54=<+,TP/N;POXOU:+d.7)gVXaQ61[3La=eDQNTX/YcW8S,be
:VROQc^,IT=;HUB1^&c&_5O>LQ]BGL>33+)aVRZ+[:_^Q17BASL3eLdI\^MdF?(N
P.1g&Y3dZAPeSZabNGWgE:T(WL0<VFE:@]P(]A)dZ-3JU:Hg9Na8[L9DJG2^f#^;
YM/5ff8XL(CXMSA^G.f8G>=7.)NL,L#CG:Ub/Md^S/UBC0)B]^4U&EW>]L9f>H3#
K:+>]/RGac0TW+O)2W?\UdG7-B?(]L#0C?JV_>L3R,d^5AaQI-d@318G#IdOa6A.
AI=5[(^<3\R1CFU(E&g/.#0\8Q^7_P,41M1_YBZ;A;M.,XPDdV=TC/4V=9eA0<Y@
gZE\M0cD4a\,/&]=g;V;).#cWNQH17geUBaS<e&/T^CNQ2Rfa-N>_:YK=Q8=f1J2
.F3(9RNKRMJ/FM_TI?+fMK#VSHEXE[@FEZ-\?(M9H]WcLN3BZ\V(CQ]ZAcbcITa)
:^>7A8>1>.WOTM;R)^PY5^0N.+VbG].VCdg:\2#Pa+SV?E<bZ;&=Z(N8=[B9LI-)
+QWV[E7]dE51&W&7(<fITgL60;&D:,8#.?1Cc/IUCRXDEWO=YY+-^+HKX<6\1-19
EUR3]6Z?98[,b;DWIeKF3gP;d@HHdYWc85_g0/8\?Q\^JUb0bH[).N1Q,#H,G=#:
Uf5L?_GI+@c]:Q>_7S2PT7.[1g+AKGG7,]3J(aGOYQQD33G@9VSKVHQf45S7/5?R
7)-09OBeg/U6WL6a6WA2QPeLc91DK-C9;68=9Vg/WSP,bK8MLS;@(3^EXcQ=f82U
fa<#6]:]G.c92Z@:&O1J9bO?MWTJa2/f=JgB/f]I+J,H2D\RePgNg=EL;?)&&AW9
W]O[G31[SM9O,Fe#]#e8_UFDg,(G(F;+JSQ5H+HYYBA2Q9ESCE5_FgB02;BUF[33
,^IW<B#]@]-\LAL,8gQBWX6JB+-)6+ITJe39;+:X)+,MEcKZBH?9(THZ/Bf#<S/H
Z.Y?.0[IP942I44<9@,_Wa6J7$
`endprotected


`endif
