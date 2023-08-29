
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_master_monitor_svt,R-2020.12,svt_apb_master_monitor_def_cov_util)
 
/** Toggle coverage is a signal level coverage. Toggle coverage provides
 * baseline information that a system is connected properly, and that higher
 * level coverage or compliance failures are not simply the result of
 * connectivity issues. Toggle coverage answers the question: Did a bit change
 * from a value of 0 to 1 and back from 1 to 0? This type of coverage does not
 * indicate that every value of a multi-bit vector was seen but measures that
 * all the individual bits of a multi-bit vector did toggle. This Coverage
 * Callback class consists covergroup definition and declaration.
 */
class svt_apb_master_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_apb_if.svt_apb_monitor_modport) extends svt_apb_master_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_apb_master_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_master_monitor_def_toggle_cov_callback");
`endif

endclass

`protected
d<75L,IH8:^edJS0dTL&W11bK@GOCKg\af=Y4Y)B?-R3d2UO,.T^6)6(c-bLd.&U
.1WC\45:I85KL7,>I\&W\:X)5MWEH1?;Y1A:-:WYcY1g77>:+DF1(#KUJ_A9B7\a
I&-f;6WRJ#O3>UYCc9M.V+T/D\.G#KR2<Q7bNgR:eg9K12g4O9eL/=a0XE+:7S5Q
7>X[K)f&b3cJ-1,^YVYNPX1A7G(c6)EMT]e0X[b9ENC5]Y.GC_9T--63[LV8@NXP
5JB,ZEC<K:AI&f:g7LJSPH-5_,X(dX?a\&ADZ@T.Jc\,REDC/&J7UI2ABIO_#N;F
G9.M\.X7E[7cOZ2fHT,<bV^ZECF_b6_9:[>?UgbPS^TBB(FVH.9EHMBE+W6Ua82a
:K#=TD.7=g2Z;X/Z<PNQB,FNIK?6Uf,8BCM<eM<<,R<O.SP1Q8V@AN4a>H5G.g&b
Q(Jf2G.F:]MZ23Wb4H74VS.9N8UL?<)@XPAKEPE\H-SON@)#cfg;ZX4:\#E1+]d,
\:E@,<MX4=#bC2OUYeX-1X6@POUWBSa9f3GB&>06>>ME@c68/:8DX3M=a3JY0I/U
?A3LOd_eedX5MQPP]#-Ze_AGUP@B#LM2\KaHXB0\V4ZR2YAa?X-WcMH<b5:fR3J]
:P0Wf&7gG:e6G1,J@+2DSWO([CWHAJNCb-;A0@NQcRRI/3PIYV7[I+bE4-99[Nb:
J^JQ62_F78R&SY]Z@M:=1TE)K[Y=<(TA&47)Z;(U&U>56-8deDY(e/W23/@e&I(P
_fg@+<C5-?U&6b33eHW:;Z0Lb)U]d\X8]cM&__@PQST2-9+GV?L,Q>fA#^IJFeY4
-6)FMG[fQ6Y9N[-2J=SdQPGRBP[RI-d=a(&JfP1DXSaH>GMcANZQ;<LT@AT_/YA(
CT,E(APWYUHW1D/E<9&GW75@7eFA108VDf6^FgY4Ob7_T&F?HB7RfO_+GIdK.NXQ
NgA_36d.);O4-4-@YVO&:98C/6Z(RB(&UY/(f6E:J]2(W<Y:F;CYaUM05O_M>AXG
;D+;C6&00N+0YN-;G,]3FTa<&.-5eF1Y#J@>S[Jc@+bM5b/>b]3A3;ZK?EG[):BC
0cTI?.VPM;TU.(#=.c.>?JfRgGOFSDQO/URQc2M(0(8d/RW@)F3AMMgROB^[Z/1,
^IT:MK;Wf_cP<N4QX?(Ca>f/IP>Q)L@HXaK9RT2,B1<M2@W&7acP-NP.<.9QDM2R
97<;8H-DIN;>a.K#U-8Bb^Ge@B.:G3abYH;I)LcYJ,\R42.G?LU7<V/.GK;8).L&
OQ[DX73dWdcTa9G9I&C406LI\=)S,N(+XC,6efVAD(22gC]4SS87@EM[C8=DI;[b
Q#OIJe&.d.DE1Z_;,.8EP5BYC-2;(,9MN2B5-67Q0SLXc39Qa15dPI?>?WMDFEV:
U\/7XBX#,+\9:#^]97=dRJ=+Y#_Y#-1ZO=>]+27dWT479g/3LAeX/=eK&>2=R//I
8..&4T]\42S\Rb3.)He+bI?6Ka9O6M>I&=5/_M8a?00I=ZESa??)1O1fJL091dU5
-HCMgOa[&\?F+V6T;FgS,)<5cf@2&F5/KZLgR8e=<](\R\L\I+/>>eQ\)aV@FAJ<
NUW[dV6YU.;JD<,<=-;]J.FK=V)B436[7b^)J\+aWC8dbPTSeB8:]c)4VH^HfB?+
JAg3X+NDW7J.Na3>H^G/fC6&\-1M6d[f39_N7AIWG@Z9Tfc?V8UO^>T=])Vf+BDL
JQ#@U>V^3S3EWS3<_YEG.VWa0PJe]KI.[@TW64NfC+]AG:]V^-F9d#NXXE<=D-5c
+Q3U1UM\0:4N\2U<a;7D;[TD1QT<P9^P_Kd2NE&.TP^EZf4,SJTYB^RSF(CQU)-d
gWFQ2W\cQ?4\BPJ7VS-E;D?9<_.6PC@+_:,+-6]-7RVSW,I73,Q,?20_O2dNa=?1
S-]RF_X3b4ANS1@g?ROGEK+-,J7=+,5.YRHO8W>EVW.-]8;_,]8.U09FLM9DWGb3
[]I.3[RLQ(=QDM>dJ=eZ>R^)GN(53bZ0B<Z)L60N,^c#^E]1H(QU/ODX6^cMT6Q=
,?\dKY:3@X0L6NF[&F&:...+1Q]H/.b(-&>CEc()bVJST.K[_<FOUJ:E)1M;T\Wa
E]+6)22QD;(dB^e;a-J-/M\,aFF4/E43+F#Ee,/MZDFZDOZa7R3c&d/QaQJ8#F>E
Y^VE&#ea3_AG;DaN8:/D/CNNM]E5IS9GCE0PXc8&5T(b.<Ke1?8FQ.H7PB,d]CXQ
;\H@9X9Bf^;eRd2Gd>?BF;U:T/=5]N/K/OUd.;7MYBa_A8a7:-ZPG0Y07+ECSV#X
,J1@>QO:(aVLCFaWT:5,7FCOGcU#b6M\cgR:@[-M1-G_CB[c1/6(gH7Pg057K5Z-
26BDMFKP)+(#WWU[:de>L00\eG5/RP<X.O^FQ:WA:DFHfNaf1PP?UEU^\L_&3(=X
YdC_)4bee;=,.,LU^<@M(GGDC0)ag]&N=PO@GGYWOY^5QT8UI\KAAf&b0^HEgb03
UV5)c>?#>1R&cf>bWP-[KJ3[Z8UU(RC]M3E_0B&R,R0f00MG3a4/THa0K]TZOO@c
H;;YD=G:90R9C3[UR;Q4c[f.N,<L&eH[^L7\>9=,5+2/Hcg>a/,<.PAD(EcM?ZP&
KLS7=-H)@58fP_&+?OfB5URK\-^69aZc51(@bM45,96X=6e(?.:E,a=#X@)THZg(Q$
`endprotected


`endif
