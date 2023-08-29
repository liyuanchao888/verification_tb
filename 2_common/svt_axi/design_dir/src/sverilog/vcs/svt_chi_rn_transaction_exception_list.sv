//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_rn_transaction;
typedef class svt_chi_rn_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_rn_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_rn_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_rn_transaction_exception_list instance.
 */
`define SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_rn_transaction_exception_list exception list.
 */
class svt_chi_rn_transaction_exception_list extends svt_exception_list#(svt_chi_rn_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_rn_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_rn_transaction_exception_list", svt_chi_rn_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_rn_transaction_exception_list)
  `svt_data_member_end(svt_chi_rn_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_rn_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_rn_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_transaction_exception_list)
  `vmm_class_factory(svt_chi_rn_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
=?BV#g&ZQ4+b:W.QDbT.0]T;/2+bZcSO9b[GEL[g.?THR&P^[2@Q2)LKbFE8DL:e
LHd9^?+Jge-Y0,WZP;J>F-4,d/I0TS_[#Ma6:.Gb)10ZLD5,f0#E?gK<U+Z=eZNf
A,f(]e)OgP@\>52W#(1T1/I-6>SI71#QMXUXV[<OK?8bYQBV,^)f<D#.e@9(cCSR
9O]fa(CCB,b>QW&;+E9.[C^KA=41W+Ec.MOJG-UX+/G8C/EM;<WO7K7P(G1NOAU(
WN27[2D11_gBY[W-#eKF80^4R[K3@92C]Q:B)geRHc9^]WS>=LJ?]OK+PEBG(BFN
^LAf9VG>R^2T44gPYB8(f/Nc4(\:g;d:c0XZ2E3ga&_@+@5fUeF(^[:,gSCBfANZ
4?69M+\>,QJ:X3&+3]4DX@I^<XN6=,VAH@#a[Q7Wgf&X+4ZB(Y.[#5#4bN8K_R\6
-_e?O9bW#S?N];O-+G#P(Cbb.JcUJ^fbBSBVe.,3O(/[ba;9?a2UT4VUGO61X+;)
0Q#efXA<T&6&G]bgATHS].EO9W]2TD>NW3ReA/)SbXBNcFB6f9L7E6-P4&Q6>;U:
VdPIBT@d4KD\OfJW3d03YP5cN,bX6CBgG)4c^@KQ+d=03E(.KHH.+,M:HX)f<X]=
SDe4gbTLQNQO[dgVD?YOd]9Y2-=K]+&UKLN]:T1&@@CL<e.O44.8Zf&L<O<Pa[)(
fW.bMG^cBK-c+W5,NENM,ZEJF\5O4@CK?)OSc@-]b@a,2YZ7ZL]G:V,9Q@aDO3-f
=aT.a]_5PC0:gX+0eP^\3dGWT1K5T@CTXDYMXTXV@eDaV].NW0J?6g&Ra;O2D7GP
.Ia)KV]N<XFOKc/\@E3G@4P/a,+WKPBF7C&BE/5JAFdXf;&HD:OaO1Y(]Z<OMO_@
4g?38J\.7:4/>6RG#XKY&<C1H[QK6W[gYPW&BO5#ceDPIQ(WK&>5Cf60S0X+X-,=
L&)+@2G-BeD:LT8+F#JN=#>)7OVWTVXd\0+J=XV-G57G:])6V2=4_8?cYOgcX_JX
b><Q]XBRaUbZ()L8]-KC_&(;KaX^2f-f;TgFBI#MBgP0)]UXGPQ+9PQeNHZ4,V,+
KGM)a;MW#KHC4dWWVTH4/PY>2L2B]X7+9)UI;BE_?N]Q/<+Q??C<(1Eb&]H;Z.8BV$
`endprotected


//vcs_vip_protect
`protected
&]8SB+MXWGKDC]\7\[2/eRF[BZBPW7831[WQB&:bcf@WFg(RZW]D)(,V^9_#\?J>
P&2EG,-.0YITRKG.8=ObGdPb^\>#+(UUU8gcS>5dOM/7F:S,:bKYg71@)V:):Q;R
8MN5OJ1;OF+1G@e+EHUI]KFBZAeQ0ERO4aRP_>D=V0V9>UE_Lb9.?^gW(HB?WU)J
&0L#HJPCN3aS7U:dH9IIJd,G<L&&_I+=C]P25>].IH(HJTc:]XE[6AEa0N.:U#N>
TG#/DNN,691O.3YA)^2-6N@0c3>I&<TYb2VIA8B\Y0+gM?:Zg@SK(U:5Ae1]gY\Y
ZS@X[(X^#NJ6S].-0WQ&S_DW(7=bYFN&FF#<;>K8+[R_SK;GOW\+^@)XQ[f:<,PU
>/;_(DCgc-?[[C.&@:M=@a3bc>LP^&OX6cdF()DbDB__K&\T6V3U6+BG:1TX;>VU
AIY:b17-Cb]\X]9D^W_Y1O73e6:>J9G>?MPf?J+2;TLc0f:DEOJ=N]bS4/@C=TKa
B_WGQ#2(UFcfdGLP\,D:S\B3PcTRLPL5/7?G0H>IXGAd90AVd3)IGg]+Dag6U-C\
gA.c)I=G6(d;TBd6C(fIWbT<\cVWGG\8+b0bNP5EE;GO[=9,@F<7a0a82VR13[/3
7f7A:g:d7);(Q114b0://MBV77QOT.PE;=T.-#&@(&+dE?]FTc;P9;0_^c^H.\<U
TV7S2_H.48FF+e?0HVJXJ9#B=@-=#YZ+NON4RLNYO,C2cB0C8;B5U3I;RPRV6J_L
;9HM4XR66]KGX@LN1<W_.^XSD_>Q]KE6e7@-[LSb:87b=E0Jd,aJ:09H-g+Z,A2;
KM7b=)B?7JfD(f>-S_.JR8bAVXSA)1I)K17._\]<B_80C^5_5IS7PgYSZ#GJBP,B
G3b&?Tc5C/IH[B7bNQ<UO(W1[T)WACYgI)&:fG5P@YP0AMS3&cS5FF]2NK7RB3C[
V[NgGYWU(g\A,T60_AKb5.J7(OJ(2AXO>bfK2IVS9T/;C3[M?MV1(O3eNYUW\AY]
L;Q\S/0_>EU-LMCOND?357\YJcO@>SK)DCEV7T@Gg=G>-+Td,Gb+C;gf,N@#a30E
<_NC)-)V374+>(KNW+4R(&7T=I<g5T9@_cR4HU^&RdV?0;UeAOB+ON(=[f_9K=Gf
C02OJa)CWDa2UKfSM<II^AHU_;EcAaW#@T:g/6E268V+Zg8?Z>&BTBe>>gfE@8E(
U,J7N]4G)(Q#0KRD\WJY-8J)/8IQM:=e,T1aU75&UJ;).>3)1_Y,BG7D#LYU;/:M
BAKU]1#/g<7LVFDBT=7P41\UfT/fJEP):YTDQD]/+EG9OZcS;[84cO^B&<@b@>]I
ce\a<SRVYH-,T&&&+DO2C]cW&GMEeM;O]Jb#I.[[bU_(Q.4&/P>K.7]/_1N5^87Z
6=0;A1[[PCcZ]&U=YE]9]#^18Y&30&;R+]d,U,G]4B;]Y1ZfVX_NM@;[1/_P9Z,e
6dY[]IWd2O\,.g1RFI1c9bSbMFR8U=K2>12EC1?QE#3UAXU[/LI;:Fc]?8D#=Z^d
.;W>GeCK-(.0OKAZggQ[c_VR,f9258;K5#;f(\acRLI[7K[/2Z7)QbF?&+D2,C_+
2L+RWC^U6,BA=g>8C):Z&QbE(Y(8?XKPTbS19M,7aWH&bM1bTA7[OEV(.2B>(HUK
fU,gGCGLISLPfb-)UR=)g8[,W6?Kf;MQ-(cZXW9P>e70AdILX54b[,]4KKK(2M<V
/^3M3e:dX?2PbeH0&W4)5DD^GGb(?KUb+ICMKg4B#V9<9TH<P7EYBaAUO-5UC[,1
bD,Q)8]IR5QbM6M#+aX7@?VBU@:^3_&Z6I+PQM=GeW:06HLYX=B7gY2UNE2&f;=X
eEA.+gFb3EEAM5U_LR=?\UMTH[Y2XUgIJ=VbOc6\?U0;Q0:^--4F_)>&/,;9GX7(
e.RdI8@PYG@NB?A<#);4-NLbMF0GeKg.&BGa;-97QQC6PDWKOG_,0GCRIN2Z8FX?
Id_#?3GX/,OaIVE3CZCFI>QQ#0@3P0IE)^LE2IG6MU.6/+JB<e:=[gGEa3\):^_g
+c^E1H34K\2S)R.SUY3:+R\P)49[MSX[&<X^,@,O6HFeeg1FRB(W-B4ddO+e,RT@
38++MR<E,V1XOZE#<&XVWMMg5d-NK7,OM[.RLOMWA\ME08XPJNZ6g-[Ke#]6J-T@
MQ-f6@+1D160F/.R^I7#gACC,a8=<-C#X?Y3W@DXM]b1KF/Z,Ic(;cG?7;]+W@MG
US5LV]EgD_9[ceSCP[5NAKR=46X6WLP&PR11):^;0)_D[]?EOGQS32?W@A,\AOY9
F3NO.83DFeO=e13gbPX@Y/U.\5HYNeE8)Cca=/dTReHHOdSAQZ.(F[QO2Q584_,Q
I&>>^aC95].CC&_(FEQ>H\VMV,^a,[0^<K#?8IEHRP@(TM[cD4K)#QFR8[47I->;
;M^OF0L/?-U\5fTKS)^44ZUTWB_VRNc_TFP41IJ#0PDSN(&]GPGD5S4,L7@=<#Z?
bO9F].d/N02OC.cWgc6)_P.<>W3/5[61>6(6;d:RY#^W)<EC1g\O?-MZHA>4V;dU
9XSc0[ZZYFEBH9O]O&cC6KHbH9ce5GOGX[8dNE2]IeM;?D8,a\BJ4e(4+7Y43QKR
#<J5I0B0[8Jf<&4)Y(2RWD8I)EFeKbB;KA1JMg6S7\]+^_[SI3N@&_0A[?KR01]V
KU.OgQY6\MU@1^=T9TSE;C-NCV4:;7>STK.3Jc3>=@b-Ke6R;XT(.=(XdPa-F5L<
5I#8g2g5991^,#T4cCd5FeTQ9L]ZO#^HQaG402WVH2SEB[7QeO2.>a8+AgVK7=DE
H/SdO3CcG:>8_-V#0O;/DRe&3YbX<X/>B)HHb@))#SbJ[4KWR.Z@9<ISfY+OUATg
8O9;Xe;0I\9VV8UJQ=-3B#DI\#LYS;U(3JA\@4f+I4]+aD0G88fcA/-[77=c#(@D
Q5;9[f:F1ebB3#g^aBg^IOK9UFE7HT^R&4P+SfCQDZe1^_/0c8eJ8W\G,DGK([7S
^eNH@?/bUYS[4B&eZ6=0.1^^GSeWAI0>LD&Za;g[]e8bBc0aDb6)]VKDD731?;J&
:@PRAWZ86b3\>639T&dNZc3^NAS\F;Y/5K9=;^fZd61g-fEdfee&61:PXXR5)+JD
\S-6063Y2:Y:?PAXL?_Zg<3MNK0-I[eb(N+RVW90.XH,0[JOPGV:e0;dX(&S)e_&
FS=83R#Ba)f,_RNaA9[[.L5_?&9\2D:V9A?&LUaX6FQ:4@,];V9PDZBFU+7/Z)=R
L_VD)@_F/@?E&ZXD+e3P6BN<(@>6)c+7OXRWP@Oe&O[X@GdE<J?Ie27VWd^#1KI^
L5(7TG+dB?;0?).+.O8cRXVZZd-=3:?[RaO:4]]7W>L_AS&Q3fQC=II)2C(G5f=H
SX42^Z^:AQ(:((TR_\4gJQACU>8Y34HAIa]TX]V<A6H0XQ3&#+(PUV6ZXGC8+6R7
GRdV99Q5GA,YNO\E;BZfA^S^WE,;0S-5Z^-7TCLfa&:<FGRUY+d2)66D8L\X/L[Y
J,,H\+\5>g/]82H/0,@6-D@H/R(U.R_&T[8FP5UPZ26g0acASBWSSZ61V74/BX>/
T5:4.gCRa?(5M_b_#2PAKcVY&G)(Md+3;MM(C4Z53,5,,B24W#8>;eB9MJfL5gX(
#9EU9FY;][AZ[#V7@g4F-E[IJ7(dECg?BfbVY9?ba?QUHb_MY^PNL&TNLE)JZ_Y^
5&2H1+WPKR:K(G:I9g&/9bR,-[Ad.#AQNP(=X<J:KU[-<C)I7-]AA+f>R9-DVLVA
L^I4]0LeUI4f:6OT,dA(8UeGC0X8LT1=ffTGbC2DAb=f&Kcc<-e#?,Na&&5S:g7H
@^g59:1C1dSc(I[-d,J3=A)#Ka[QNM8_d6E;9cRN,I,0R08M]B7N>#HKYLf;#ZF0
69>UI3gLDEf/3C^#?c[-US+[dL4cZ7I&Q\gY(Q_.N/FC@VWI#5;P+7_+#cX_:Ebc
.\c-\\=J4M?W/VS(8c1,dR94.b-0//)CQ@AZ#H<1?N8UMA2d11K?OdF?R,e3J9G:
FTeYY,_B-b.,^7\/6]-L((Qc+J,370:L6N^?X?M.Z4-)1.eb+/5b]];#<1-,03CB
S<\LQWTA?R+F<394[2LWg=R//,Aa,9XMR:]@d7:08]AK3VJRe_0\)VY[YH>FaZfF
F4P<[.=_&RDc,V1A29286\Y9IL)EHC_J1<Q[P/KaV3?QJ=?(G11?K78AYIEVJd\Z
JMRC#EU-ePc:]3LJ-#gc5U@1(U.H_AZ>]=F5;fS^+fAf8^1C7G=XP,dca6S:B=.L
M=/a9[\MWcCXXe-Z:-d(c@b,:95YBYYa3Y(?G]O[9b1#3GL6S8&TEA7@:6XF;f21
e&0N<.V;dO1bECeac:&Mb5d=@;#f/F>:(^[U@\.UF;B:;A#TKU:NQBfcCVT2H:C@
FabgMNYP9)>=e)N^I>)[-4\L)G[GDB-=7C-c64#+V[(f:50LVC9P^@^+L;:R?6A\
@BFfE8^D-D7M>)L^XE9HZeD5N2Se#]T@,NM:d9II;;?AZL6J)QP^,d=b(/WZ)(18
XaX^2QSdGZ?B-_WEF4fJHcRWXI>1)g\9.,S@ZFfLBUd,FHGBRQQeR,.YK3^GQ3PN
IU3a]R9.:/JI]CMfE,\K4D5,3^=9>/Y=O)R7^d,<_1=b6J4TQ9-IG0&]eBT^\<cH
)-10I7gXAg]1\A1Hg2VS]7DS):HOZEY[\2[UA+?WceDce#K&VPOdI\:+:>Y=BdDc
159,g9OGR057L#YaUbCRBY;^.\G4=;+fB5UfJ+GS/d(@)VU4.#9e17?bf;/=TQdX
++,ed-()eP3]V[NMCd.&A\E?:WO/eQE5KWUK>#)8M8<Q=/PAV[APGYC7ReW8PSf(
)G/F3\d6G)DeI7CAJF)@0ZbKY;XP/0;WBF6-[7>)Ma>ST6fbVd>&]c6GC2^Cc)^G
FU6)NCM7>a9(,2a-eFK:;UD3Z8COOZABB\ac=FX7L9=aZQXN_XFC]7[],)M>aRA6
O:]E+JL8:I<@\P]3<NeN9>:T(a0-FE^bC>4KCTQ1:XdZ/\V5).fS[V-IXA(39CFG
<;P;3<75gR]:#9Kg2XK[WI6cAb)V5A:/[4Y4P#T6acJ,FRGf=ZF7)X/Rg=9[Gd=R
AQ_X>Fd.VSg)QXc71,QZ0<0g0&?<V:e[AdcZgPRT[1-RU)bc0RZ+\?#ZWPc_)>[\
@Ja8>^:SN#4b@N.RNagAS(Q&X0:-d:ZeSe-4=8<MU(\Q0:TQ0Te0/f)C9R5&eJcL
^C<((Q0F,?LMCK:WEAE[[e6fRfc53cAZ8&05S\.c0:C]M1(2dcNc_g@GD4/]-;-W
0SSf0/;&BY<&F([1&F/<^@^;Y&=g1GP5KUG7M]U<=?9#97[@.K7P\a>5E=#g,)A?
dCPJV<27ZaM.@U1=1(;aO+PabI5fK7g7+:P@F,>Pc2.9OY:3a(GU&Xded#YTXP7[
>,31#0RF^W.I\V^#BK<>(f^OZ=6R)\1V\N@P/NOU=gIVT[46_IbWYSJ;dW>R1-L\
4+MBe+dDC+>AGc0_0M242^6ENXZIRK6/A9<0S:61JGQ_IEZQ8V\).7+5#SZ\E755
?FZ)2Y8[+dP>V2L_@1c@8=5SC)&g:MYO\E\KE7UTSA:&ZG#<XS_VbaYc&UA3R(W8
)J7;;,B5D#de5<=Fd0U[K9G5BAPF(/R;FgEb^NH>](BaWacTJ;eT.:W51Y].^;QQ
d-BVeB.BF>>SC7P/caMY=GIL<ZNf8(3KE)WYf2EBRfb4)\.\_9U@]TP_=3X3;7&8
YF,,+(2;SD^NY6=>.63(55EdW_MXO:P[))Cg@4QGZf;9V:X2;O:]ZQUI[#=<)6=[
8LcA/,Y9H=&-E/Y09\]&+6g.]ea6;28ME:?LLZ3(@4XEJN5c-M/0+N?:G<#Z>C>Y
Z?UBY\7H2Na]b6[AU&IK?+]?+;dO2ce/M7;(LU\)&A9GQ8FA<Ja23Bc]\K.0)#R5
e+9T40@BQP7?+fTX;&HeW4I..6<aUHDKKZ#@c(@Q^J2cSgJM1-0b:Qg3d@9#.K68
UUfe;&Y5\1\4/VbOF1GF.g+dJ&3U.c1fHR,YS1c&]\U9?aMGEX<=/S2R=\+g:a;>
V_\^PW?-@a7JbffRGX&9Q^,0^[d\+<a(AD]B-A,K#QZEEb\F](NI>#Og)2aa4b&)
M)<dKI-O+A&KZ;<17ECZY6Kb+L<Z]=WF6[QaE@Ta.Q=]^PQUb7AU:7b3E^83[7M&
O6KLPd#GS>?U6.4S,A^FZD)RV&Q2\&#GJP5beW&fK2U>eZR0J8J\1?D8]SGA3EIT
9:B3:2,a;\HILLY=QZVcCG3D@M8JNOKed]7>HQTgY5=..FQG81\eKM:N.VWg>6d@
OL;T7IJIZL1\BCBEUUF.cH:T26L-g_)]RD\-6KbRZ7RPa?R,5&S.]=+5AHO>_8:g
+)2Fa49_WPP)#^2(ec,\#]@^YKW?K.1cZ,9;4E56QDa-T;KbIUIA2-+TW_X;?M8V
e[SOf#@CEWB\VFN])2?I)H5+_2fQ#LL)7LSe=eeA0DYBPCa[@1G^L(f0<UM5f:M9
0B?Qae]cJd&LB],d<-0/J24Kc_L<cX/H1C@=g/9@^[&,PXWMN(f6S@QN>YK]Q1[6
DMJS^_6;?0Qf-96?GZ_3P?(8BLTf^d[WTA=&Z2fFRPI_A&BebBDKC/-_3N(.1R@X
X,AZ3AM3),7=A7&1G8KHMCgIN3fWNKGOWd,L2U2/VeI]ee[LfW,7^>VLUEQQ,IcU
DJPP^73_[0JU>J5[aH]D3U=b9S-gC0f?D(UOWM#E0g^)HI3CTB^=_OWN,]@D+(cW
&B_[#d_?P_LG>IbN\g<fHA\29_cMcVMM;S/e_YR0_^8^7e=e7W=:(\#<USDXd1bH
#ZW936EHcOCN@X,?89K2@YX72PD[#Cc@eVT_.D&E4bD=@:NC>#B#>-_?:B.[HgD)
N?]#V7>KM7-V74M@338Z5+^7CXU-Ga4PG(VSS5KgSIKb=6K-;[M<UaK0.==YN;1<
Va5L,:-TO1_AQVf?DT>O/]@f^b0FKY,55^ZN>3T,-9)#\)N#OJ3BMge,.CF3e&_U
FgWdb3(@>L<WCb.:VL9T9JF7W,J[0eRAFf\QX[R+d@H:MS&\R_e>:/>bK^YDf,c\
#;e^E/dNdb1C7X,GA4J_AL9_eID^;g1X[X3(ZG5B)PAH-=RbWU3QNVQF[05GTFDM
Ic#,Zg_XK?P?)I?6O2=](B+M&53)\[fCNYUb&[LSBBZ^K1H,bdSg(Y8(U-aO8[aP
3-G_QGMI:^UD<bGa+:W555Bdc2b6&0XWb&CB-U7-W&G,[E?IUP8O@@9&RdP8)^;I
9b84V=@0L>X]1/=U=YMeFZQO8g+Y(e])bW(8F=-ZfUTD5,89C,(=;#R8?>&5]=,N
T41@c?LN&1gNUbJ-fb&OWEW?Td8]+^SQaaP#QJT[9?b1L@&gPL;/4FAVCKg(=-^b
XI4Y=HIB:)N+SWS<CLA]WGAKY0)M]0/RX8HFQ#cc;A9?[=\GLPJ.L2U/<<UV[=CY
Sc;H:8CQ.CRC\a3C:HFPN@AdL?4L;W=B/NcTc(]6gP+0E:QX4c1UfM7gRSP&)K7U
DX/FG,PDSSeW;-A^A2[MQ2J(0<#5]]d\CA6]IO8C9f44HKKb>FMC(<fHa&DW]fW>
/0VP@#^]=&>-HCNWV-(X;6HND0T<G[8C1?[#f]DHW;5+7=Y->f9)K<-E9@#P.&ZW
Y>F3?-/Gd5UZNI^5?gd2T[Y:G+YJQ,+E,3W/:U4d7]4=S0?R\F>FBTC+=]MUQ5,X
^13=VC(P.Mg#See#4.fce00)Sd#ZQ1FI1C)HdVL0@&MAda)M@a.G4O(/T?NWA0M7
Z-?d,G>O-RUAY,+E,-)R\E:U(A0J<1R)DeSF&dS+BfFW6RJ03O;97G;C?,A5-5,@
KM5=U3)e.<d_R32aU\X03)XMA,;KCT87@W[G0-5)9P()L:g?>10Q]d&F&TTUT/-=
197&[H]0Gd@T3a,8^S+Q-EeWZ[BI#:eW^5+QN91^XZc>S\/18^3C7S0[2#XK>B,A
aLQQS;6>SR48(T)MR5&?;)a&R-&O,e[cPUG9;?\/.eDB0>DAI(Ne4/]1_\Y4JXT/
7>gF26F2IF&HJ(:?-G3TJa@K0ES4U,XP6>S:?b?2JJX,K0W5_6XAI[:;/D#<[9M,
ONKdCA/#E5RY=]Y;]F.D=>A:(_QBXVH:K>M/3Ea;7I>WR(O+?1KYMR:5DEHYf)3N
?V_KVf9+IEL)f(FDRJg-f^GS^eLMAF3,?=DLGdJL.^&+aM;#Z?WU5YCCGE+FMY2^
3J-WC7a1/L+V<:I[5^M5fXUdQd5bHL_ETdLK\REX<A:7X(G_^\e74DDW8CHDf]T#
7MLWB\CZ?I1,[+L=&fU[D9OLc.Ub:6d/FN5-#UUMDT(+[/eQK&FNME1>[&#F);(8
FX:]KGCVQ7OC@N>1<\P84QV/V8V7)ZPSW+ZdIPe-Y7,\IXdHMg9RWcA2+09.,g:)
R_Z]?VLWNG=FBDM]FG3;3>FeUJS@4T:H0ZN/Mf+d9^4g/1bAJP:IS?7T5^Y6Ua##
9g]edfQKQ64M>9VdU8KM_5QHAQc&JEJ@b;#V;]Ff,/e/ZeP,\9g,@\;;Y5DTZD2C
DQNegbggR0aFVQH,_&ID^)Mbc(;]b.T?:c9bH[6aUNPdM,.2W99^MT&=aJQT/)cO
VfC8GaV)Lc/^M33c3ER7F.?Ea^S+3E[5QN)]R8<7,JH+XRAKd9[RE81]2K[1?S@Q
JT:@DV3L2&L=IXYFEVf6g@:/5R6]QW+,c+M,TE]^G+HD&XJ:+T7TZ-a,+=A/(RNP
CE,K,)M@GccHf7L9EN-Q99(KMT,^=+c_B(c?eKU5#@D)17)0&gR?O1B]&bQI^G?-
QHL[_HOLT^PRg_GUfe=fNSGEbZ@:T&DEg0eZ0V_g9FN<1W=cTZ,F1?R6NAL\[fM5
A\_SN\(,5\5;(JN/Ug4GbQMPBF&,2?R4@:-f3MTG53WC/I^U/D&Z20eR2]PX==0F
>.7EJK-.ScPJ&g3]VKJ503A?deM(fX<E5F:eT.\C+XL3632^c?)SYB(=_Sg4MAK1
;fKGdQ,]=^K\#.0M#6GO&MbNC:IU5SRP0SXA&cC&bC\R<Ud&;2<_IG6N0Z+8<90G
3DCE70#QAU<@0OcY6bFM?@)-]G7##P0YNZCT@3XOD2,R2f#=]#(/Jg.,-#6/bSU\
/;<1e+Ie?RPK@JK83Z97XYFZ?\BDPWSFE5cRJVJS\U^<;0I\:&26&<cJILR;MGb0
d&CVE+CNQgN60LS883VT]W0gQU+&36Y8JABL2DeM)B845FPC7ZO9W9GVc-#bWd=X
)AaG-G2@UJZ9+6K]fe.X-gCF=XLN:2SLXB-XS6<3SOC]SM[c9d[T-cM_D;5V9=S9
Z(KL:Ib^[^UY]B&3TeK;OPQ;0bf\.G?gT&?^-AY3TQPIeZB-T1SGWa<b(3<76R]E
ENeXL^d<564Xd3&6@K+33#:\V_?_FF+[/GIQZ?#H49;Q)6[dIO<g2U-H,>D4BRbO
]-L(^_?VPcVUF/US\4:f^6SP8/H=7?_NM_Hg32TWH:4-P/daH\WQ/OLGY=\)&[)Q
]<U+[J)cL:F/<\(IH\0VT:3@ML(QMQE8cUE.XMbgdF#.c2EH-)KDK<1ggf0U6.-8
=+48>4_?B<K.EA31KJ7?;[.:a_&@ZH^@H,[6R9PXAHJ.=N,;VB7G&1[d@,S9V_&R
J.JK?<2KI/+gKYdA=.#HPe2V7;cG_[eH@]+\>=f52KE8C+E<LDOHA//Mc70-HT5c
5&O+ZH&94TEcS;FWG>efR6,(Ha84+/4d:(PQ(&0>c;E\J]6c5B96\6FRgZIV5D.)
&IG)T&,MDLSTc3-CWbF01BN3JSE]I)L6a5T(<HOYJ&&73F.g6A(S5QGC.e^Va1&J
UOaC;AV]F-Q\WR^:Gd5?MYUZGF\6WRd(aV2Y_SEK8V>d[?(&1?[aI^Xdd)N.1eFM
1JVIV&_:/F=907Da+S;:M:6S<AEbMY0A[W@>OPeJfOZ:1+ZKcBS11]Y^^SO;R3/>
c>F^EK:;VT,IVg^/6R9J/I57O0Ie;#1+0g[b7IaXXOeZX?P,YC9;Q7_-BJ>#:VUX
?BXIg:Kf6C;X7Mb6^Ld1fCeQ=.17e;MV=N=SN)#/V[N;HaLe\B)LT9TGY:8X+,A)
V:cV=5M[T#PaF9(N=R\VfO5\S0::[DG1[,^RM95E8@b8^8EPE/-JKQ:bA)Vc#OK-
._Lc/0@b:0M3]Zf\TEWQ2[J8W\^.._CBQS.OKPVZ70I@4#bPK)2-1)_&CY7U#OQA
(33d62-8-KSd<E/HKPAE<eefERaLE4dJ8eLD\L)e<2N@COZXEQD:N8S;2VKEg_BI
3:+A4>a1HE].5LSgDbf8dKC1Q#>_7889V9^#?^2TC6gZBOcEJ[>>A@1[/4C??;MS
T:EcE;,IP4d>cKY);)+RfL,JK-_>[?):LLY:d3-K7,e.,IcK7FGFO\eGM+)7f;>S
<a_E8<ENV?Xce,MZ>EPQNSH&TU6c9_C@1I>X-&N76:06@X\.,TA<UJ^JS=HST(g+
c<62e\_3SNe;aab.G#^d5>f5QGb<[)\;fdG,UNO#3\V/OZU@G0+_F2F+<^)7eV)M
9PMcI6@EX>T9g:7KVUG3e/f52$
`endprotected


`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV
