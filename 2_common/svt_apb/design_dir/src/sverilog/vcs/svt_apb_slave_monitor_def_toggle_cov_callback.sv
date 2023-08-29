
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_slave_monitor_svt,R-2020.12,svt_apb_slave_monitor_def_cov_util)

/** Toggle coverage is a signal level coverage. Toggle coverage provides
 * baseline information that a system is connected properly, and that higher
 * level coverage or compliance failures are not simply the result of
 * connectivity issues. Toggle coverage answers the question: Did a bit change
 * from a value of 0 to 1 and back from 1 to 0? This type of coverage does not
 * indicate that every value of a multi-bit vector was seen but measures that
 * all the individual bits of a multi-bit vector did toggle. This Coverage
 * Callback class consists covergroup definition and declaration.
 */
class svt_apb_slave_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_apb_slave_if.svt_apb_monitor_modport) extends svt_apb_slave_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_apb_slave_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_slave_monitor_def_toggle_cov_callback");
`endif

  
/**
  * Covers the values  of psel,penable,pready signals 
  */
 `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSEL_PENABLE_PREADY_LOW_CG 
 `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSEL_PENABLE_PREADY_CG
 `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSEL_PENABLE_PREADY_HIGH_CG 
endclass

`protected
=_B/UR1XII3-5V)HJc?@V54^8[):TFLD(?d6@6>74/Ge-0DeCg+N+)HO-QCf](O2
4bfTdYWEWL@?YVKf6KA(HLLIgMdFR>Z)#L-^Jb--&8),_Z4SNQa=3?9PNaN>&FDO
-T(#J9F8,5;c+YZfZO4e981d_S50]<PTIJ)TF2(.aRAX7K[KM]\ae]KW29a<@4_?
#C\8WSbL0]:QXX#eN.9)_,VQC/=U[&SQK3KP:J3+d?.)F&>#;#QD,L)/NfgU91?9
I82<dSJad2gT]ZgYaM#BOF,Jg&EC]JPO4#@VD#T)3C)/+SC#?&0:>L;1R@MaccKD
AV+K[Ide[VE^,0PBF,X&\BXCBaS=8[=U0,+fC(:a4+/2:.3b^^)G_S.BY]OO)<a=
I/N6QN_.Bg,VSF2RGS>f>9EUc@U9\9&0A+)I7K^G+(KUf9N:V(ABDQI+g.VDCX0I
,6.]f+2MILIPTcH.C>eX<ZDCT@[M+/HH3KdQ=c7g++PSM7^Sb&;[>\)a:2\-0GeM
[OG#c?IV6#[KRC^;ZAEO]#(3:ILK?L\bgO8gUE]:=Q6^(YK\<JC07;?[,4Z\C[/K
:e25.g_.>TZXIPY9W._LDAT@BH-@DCNTe;O?e.N-@6EIM:IEP=H&R1SQJNK[E[Kg
PL1EM.Kd[c,9de?,45YD6#H?Q@,&Jd-P(<B)5V4dCJ:^9GO@<X#=2MLYHbF/B:AV
1H>b49g28c)Z(&_Dc)(L)LJZE&(W/cD/4D&JXC^4HBS.LK_OPH:-YQ@;VQ@#^d)-
2d0=b#^0UM2Oa3\OASc&\MJXWTW88c8>)RN]d^1[/FT;VE]Eb,&;JXY,_cad7CcN
D<A@g,>.0dQ(HB4+(V+0VK2VV8^4#:GVVKWZEI:5Fd1QaWER\U4NY&R:J5XDGIQM
V1<K0-8;?>a[]_Vb\O3g@)/bDFL&eL.Hd,ab9[?[/S._[VMZ_##MNL3]#P&>PUGE
9b>C.-CK_P8H2.T6>-UA-QQLX4=WQ]&6GX8K1LE[5G\bM47g4X#IFCXf5+DJfK.:
GMba)CC^A^44d+8Jf4./ZBD)UD.[V^ae/]d:HN?>G)SH63JGOb6.]^60_+8RYN=d
O)B9WJ(gA-T..e23T+W8I2ED4Cc\0S[&Dggf8=7c=8&6&UT7./6-6>1HC?KJVHO6
a^2FgQHF873:0VQ3L,:Q&384_TJ7U(,POB;:bf9/;#=:FfA3:<<IWe&TV-;?UOg4
LgFI&2XOeNSDZB_B9f-:W4+2^\+\0/dZeR]O4D1WJYeBf@\4EQP5TG(4bPcKZ1,?
W,C-gbZ?K93]+cG#9eS+3#F<GV([B/&G_BII/=CM0:MP?<MW5fbccRC_8;LO79]a
WBN3@0RfT6Se77@39E3=g#_/=a;G>J<E>;e;+.IfE0BLc^b<D5CXPc]^EM7W1OK@
f1LNIYfV:BYK(W,X@ND__4+<b+Qa.5O4N&]a/deE+RUaAYNI&32_:)Kgc,(X/?g]
ALMBLRV);NG@TK3K;Z)1+@,dB-1;M8Q^,:8&61,cZ[X=E(RZ[)fHgB(RTRS7O(+F
0-8ELZECUH2S4(O^a6,QA[ddJ.U\7OQgQ3NX=;UWKE1\<BVFag>^E\OCUB,BMea>
3<ES/>MO_T\,14VMb@1+6EfN(@9D4^KFR(+SE3T@HBZTAJ^EM>7J[IV\[c&P:gQP
;/7<0RP7J,G)>,.)eA)1W(D@)YdOS3VF,5(JD]9UL#/:GTBdP:W@TTK;([RMV.6I
+B:-f^-F.A=,QL\G>]c2cO)6>e&:P1=ZO9aB^S<eJ<3PA5(@S30@)YF_6=S#F^AC
2MMd22B^/JAaA^.+,KB>7f@SDIQ_AZE;1Y1EQ#B36D?9=Hb_7Z9\e=H@GL\TK:<E
aOc#HU.]c=T.Wb[T?S:#g+F/W,#-C=@f17IL&2[F2)7E&?>HI&.W;X&LLJ[66NK2
c9A9gTU2\D_T[aK/R\Y./20P::YOFF2WQ[Y771FQZceOc(.R1HFG4/?,8V#(DG2b
P?(?bD]93?-<]I(=.3#.Y[OJVORL>R_,0(=@(Z5gcb>KI@:Nc>>.D\RN32dX0&ga
F42AXZBN8@89Q@AcQO[d-HaBd<SFeOY=LNF,Z/P-VK<YbTcE/+>7a[&g0A9=QGBJ
2Cf&-@Zg1FO?165Qg,<^Fd,9_)IQ4WX#3OHf:1P2&0HD2W^dCX+aL,DS?V_e.9GD
&WWD\K<?b@B:N8:/W(K6Yc)M.-Z,QCGKCH35YNc^RF\c325=^X&\#FHPW#;<(+7_
^1A/?J1C5WYG\)fG;IC1F=T[b/WNFZ:)_[&\MYP0dP2a_DSKH6DM3=&D(cB):_U0
=+3[?1G)8T,^N:Oe9Q7@YW\M<fL]4R:X5^,O/b6QR/0@Z)VCE+fY@\4])ONIN9BU
d<fE;7L^MGR+=+5?@dR.#=]C_+18^H12O&C;D;c#G20[g>Y?:e#S&a3\O1E(OM-V
g2/gW[050[Jb&(Z41G,Ed;:4PBBTMP^cC^G82c9cc\Q9AUY]Y:-:.6Q2+<9T?NWB
&UOZI;IY-HMDPf4W3B1D_J)8\\,I&5BNK8QN4F[87NU=AXEN;XOB4K(FB#5@,AM/
)[#RCb;.G+7<E^YBHM:]HeP(9E8K-f5J(::cS]RXN@^[f-R<P]YJaC.(b<8+TQ^U
X/&cY21)3-W<-$
`endprotected


`endif
