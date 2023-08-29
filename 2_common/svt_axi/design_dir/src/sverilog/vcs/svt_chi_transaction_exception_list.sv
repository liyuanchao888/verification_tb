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

`ifndef GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_transaction;
typedef class svt_chi_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_transaction_exception_list instance.
 */
`define SVT_CHI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_transaction_exception_list exception list.
 */
class svt_chi_transaction_exception_list extends svt_exception_list#(svt_chi_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_transaction_exception_list", svt_chi_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_transaction_exception_list)
  `svt_data_member_end(svt_chi_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_transaction_exception_list)
  `vmm_class_factory(svt_chi_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
9LI:FUPQ<?68CBH\#OH&a2JWL5[/:]aSR-P3Zba03D3dWC^Y5T<8+)gLJLO,LNYO
5TcWYYHPZC.15)+SCR:=GN?)?@N;T2FK714LH7,WCD5G]^D@26GQ5I53,2=(H+\)
[<:dYUFP>6MQf_7KEKSDU5dJ8Y=aGUQ=Qd48;eSacC7W&:U_D(ZdGZQG6_5@@bfG
FBXPadGCZS>cE(+eILH<)96E=g(YF8f:?gYQ\]^E1YAe1ba0/#M?edDTN==.23+f
TdR<g3(CceYZ?#4@Db/4DAR#0G6O\Q8eAL+9H/[7Z2e/;\3[2YSW\N)]3\D]8KQd
-]<#4^5[T0W0RDKg-=:RTCCS2=8C_=:Y7NJeRKR(?^>R&R]a@O4ceUOHFXI_CKe3
)/d>3^#-d3RC^.e_RZ8@2R0HIf&Z^Ma-0?+(Dc58a-fFSG/]L1HPe4S8.(J5^144
VU0Y,7bKPZG[M,&1W.+d,Y1X7W[^\0UTUM_d^#FV,4=9/c]513<VMW_b4d&2H/B3
T^JL#(365O0g+K>JZNK#X/>EEd9:906(F./I<:KBY_a0&.\fI@KcfBc()U#4/EQM
R83cfLANW#7aO:\?CUVQ6],)g@B(PGF-&2Y<GA3L:EbSWR#W/;B4<@/1MWJ+8?U4
TCEQF0AO.a-A6c6Y-OMPA1ZCWM:1b[JHf_:e72XZL-)JWL=F;aWSB<&S[P;_)]\G
UUW.\[L7D77TNN2:P,U.9-[S3PGLfJ3G&S<E6eJ)VQ2UL9TY#1e[d\&H5ZgNDQ?J
VT[<?1>Fb;Ng;GIa&0HTH.AE&@I>L7VNW2Dg8Z8:KOfZ/I43,\F79cc(C#f/\.[g
Q7]A;aF0?P7\=/3O-B14#e(Be@QYQ.(H.-+,HU2\.CDf1NL]DAd^X8]YUSg52)8M
WMQ-B<fZcJ5dUUf[010\aOF&a5/&X32[=;VZWfY<(#\AZS,ZP2:Yc((1R1LUGQ^^
5FB0M<2LDTMZ]OZ,..<O-W^Q\#YI[9)O\5Q\RYa-a7Q^6-NM=5\2R?g?=QFSGX/=
N4T9Gf)9=E;QBfU:5?JK[fT.-W>18IdE]ST-4<O0)3KU[N4e:G2_I\.=TJ9MF^)T
3I;U0,-Vb]?fUXgEQ0DW4IAB@WE?D>AC>$
`endprotected


//vcs_vip_protect
`protected
D)a,S[0)7RVb^8ZZb@6E3#a&TVAQcZ0OB>T5_B:eQ(I#P\[3d9#8)(<AM@TN0^KH
baT&X^D3K4FW^fT?0DGb(J_<RZ<O/AWT3-Lg02E_=_0.1DPPHU#D+K9ac530F.BD
6J#:KgaaSf02ZB(&-GTQf/ZQU1[\F-PHbV73<U[AB:CD:_c;VQ6VPebY\B=0#-NC
dSNM@^J@>QAbe3N&.NcBEZXX4dLQ0(D)[3S4MM/TPceJXB]TbUPJ>B^DU-e8^TO]
:Te)EM>Cb&)8NN[PTM2[Fc1&P:>J5I97&AO7W2CIXeD11+(aWH9CF.IJ,NT[=g;C
Q7LZS7ca5G38^-+GIAg#S2,\8=LA\3IO,S(?,gCI]6.D;=;M^)+4<ac-\UB^N+e-
HF#(5)@\aD6(N+CG8fBddV2DR/2SM,MB+6OI0E(d4=RO,(QAB21SgOZdgcXe?eIe
a^eTT=(U#^0A&<,#NLQ>1fEN/=bWJN9::)6>dB0B0>PfFRWSW8/1L2]1&>,.=AOD
+2=06J\-eWL?1A._E>XeV+,(VF(KE_2X31#W7#Y85(a9,Z>PF3-(BDXF7g+@XP4Y
Q3d;1H#A>4ITC,b.+.e.1G,/_^B)QB@]f9(]0\b=F.9f7f1fZ)0A,-^L[_L]UTDM
#E@M01=a=1(>eX)^KZfQ6\TI[JdJ]OObUB023H21MPEM([WM4I\#/ce8V7//CYJ5
FG:)4cA0@-S+JL/>T<:>UQc\b\JB=:9:]\GEQ-P+>@5e9a:9II(+#&b1<d?O<;X(
M,-AQ/UVF\,)TI\.2.e?Xb.S/U[EM0GbQe)#D8R5VfKG@RX&Q,?.;#KdKTM0b,Rc
TI.XH71\2?OC\F@I2.=O42BU0@JXEf:C]gOf7<M[2WQRUR&^]eQf7(#-\QcXYdY[
Z)bfE\cFPZ,TZG8,C]HG3T?J01F1(RJ_g7F)dUOCM)]?5&2J1]fB4I;G]2SD)EeM
aMUOZZe>W_e71LY;KfCe)J7^TG8eE:2_;eQGS=^-Y1&4,6T98SG)^FZA^GUY4G5D
d3KCG:/N?CcQSO_XTH2?[:L6(Ed&J61I-+-#AMDV6&P?[#AA6#e7.9,)0ZB2Q[.G
&S4X)KF4;PMRL\P7_Sf<IKXQ/A+@[^HU-bLN+BQ^NJWJ&K,/D017X-173W3E>;2b
Y[=Qb+C\cSERVc<J+F7RKO/[I,ccc9^A^GJgLNA&/ZU9I)G]V_[81GNVK_0Qa-N2
f.Xg]HMJ=4e5UF,C)D^4^G#A?(&(adY]</1-3PgET1DcK0SIN]Jb^dfKMYcA-\>.
\VP]:F87e8DP,#N?T3Jaf<3(IbJSGd@(c(WJG\__f#8IDIK<]NZ8V4?Ngc+@=.1F
?gXO-;?QG@G?P[KU:4+J8A[>.5QU4f;JWWEI1Y3JEF\RR_M^^_FFO9G]TFNSBPX/
:)(KD6\4,f-/0K]^;QG=I):6LaOV9+B[IWecC0AKd^?S9K/ZfAC#0-0=\]@ec-5E
aIQCO8EZc@CAE>6a(Dc7ZHD#Z8[)fgUeZKGOA/)2DX>JDa/92LOJMg]O]O>5CKAU
>cBeDJ784LQ\_PY[e21EZT0cEAI]gYAS:UC?IN?BFZd6.?Xb@HB862ZMPIV-bKM_
Ga.UW3>VD);<GK?J<(PYg2;E:J]Qe04R9EH@;P3;JbfQLF8_\6gG/7Y5_07#cS=Z
ED]_g3XJ(Nf_J)H)BBYY[\4^R[W:JecL[\EXb&ZdO+=Z)A.WcH^8#E5P#J]]_4/O
(>::+afPUPVV0[EB3_M:Y4E0[eQ8#K/Ae^-.gKLV59.30Z[.GS0-^B65R0e/a<]M
)21A1;]B\UT3^)2ce6\_(.a>#&a)[.\CZRgT_TMOOU;E+OZ8YG,U1N[FA))G:CG3
a,7&^cc1D)M5L:B5@F9(>B2]QK>2YN7)TI#c,Y-NBcTZ:?dN+&:KM>X=,a_a+4S0
O]aZ3WM_&?[Z#/Ga@Yb-6eXZK#e.HH]Q9,RB=CK4T,E,GJ(17R6A]>PaFSV+4cK1
K(\#WT6YE/FHK_#O_/BL;=c/+E.-8c<D2KFT,_Db<W)#68;FU57PHFI7)M0faF4\
OCEC?EcZ@0fRgF3,CZ;e90b#[\5)d559DafL[BUES]&)5FIQHQ9@BJ5FH?B>1S=,
D(XXg;VITPN:#VBGGNHVg)000VTMd@=(Wb]Pg[1Wc#JBC,fOUQ5(8UG#?-\-QYbF
b+QGWO+D4/f:/DaF^7.)\@:_&^XI]H,OeH_IYdO(Fa)=/4g,D.U-+:a;LGAd+,e+
LX5fOcA,9^ZT7=CfF2FL6GHKSg]eW:B)VC]NbH[==[S)O(E0e<2N>S^0,U@MW#01
XK,,AG1&[e4gFUSea2T^bfX@PRDf7f:b3&>-=4S+\\K_@Y9(IU;WQZ@MfU.N3A)(
_:gJ@fe+5VS1G=S1-HAR>945X=Jf02dS(#:KgL\+QFffAX?0d,UN\\<)Z;@>8eH0
E8;<T4dZ0BBaP(-WXgJV;g\V[2aQ.6]+]N.J;d[S/#Q-_;DcQRK7dNcZ2OO]fOZ4
FfWf@V?fE(UAGL<^<0-f4Z8EDK:#/(#4B\48QP&P9&<WK@R<]H#=Q@S[Z]^aVN^b
T]KKI#5NROI/0ebcA>cb#@J/&PQ&-]Z?<-F0B[&f;b>+aa#R5C(H>;Z;?b90PW:&
L4WeRUC]@5f8C):-9NbSGZf;S+<+f(D[&fY^V-bW&FKXO+EGF7e1g&LT\-OC<9f[
dcN[Z#LB?C:b\VTg1gIAZ\:AD?2G-]ec9Q6a.)UQ>?bM1GFWa3DR6\FfU]F4XI5V
8UU(R.Y6GGNONG5(361M:Cg[2=Y>,eP^HIH6[Y)W#G]9faG29/H1a_:8LMNJ:6K,
IRLC_7[5SB&<W0NR\]^cKZL@EV<&KW2;;+LOEg81AH<<]34X1PP4DG5HQ88b_YRS
[ECCg^>2e0g=S#/L2:)U2S7bVD(4)F-\dZ/G04JP,A-@[)7-N<9:QKYZ0?^gf3L_
\<\5ZB3d.<7Q(=^63#^FWDD1]()S^Z<b_/UE9Z8>f?&2baP@0X2P,]3:MTNd#^Y#
F[07a8[S_g<_@SGSD+Mf<,gYZ8ORPRbe+YT?3W(I)JWb8E&Y9L7.f987V>&+YWg4
?Y7gQB7<&&SB,)8E,OE2SP7ZG+>8c/,LPP;E6U<:Z1[4PC@[N.C+Q.5+WfHS_5_N
NDY8Z&[=/HBA89Z.X2d+gdM=ZU+GDQ0V^.Z49a;_8VK#PdbE?YS[OV\WN9>:Y:YS
J&&&&4XW4AZFE[UI-H&0S6WB]C9d4=3,U+HHEDWcUFPXNL,Cg.I0AL:e25)EVS]A
dW?A>F2H6Y78BAHO;0M7K.MJ/LLS<-GR0E#>RbN-RLV_a9)g<TWJQE9daN8BUc#[
7GQZ<,Q?72C+7G0[&7Af,b7\-?6Wg&JLO#D.=33SIFF3+#7>A#G^?2_bOIJZ56(+
aYNLIgaM0C0\6>6\59#:]a7T+4OPEM6J#5#DUe.aAU5>XQ?IY2MdLF2K#&)KZU1(
8W4=58a__6D9[C?B9HVI0CCT6fEYb_KQcH&b^W(\@_H\BaDI=,]7G\BWLeT?>]^;
0PVZg;_/(IQCQQ)]WY(bZ8+9b3E?FRLK\&7.S0+&6?]7Keb8,.6T(3DV+G2WBLAg
RSV42ZN4JP>fC^aOQQ=]GW6S+>,A2?Q]2&EeBU]JL[,Qa/>@\K39ALWEPF/5;;:E
NV1_D:390gP;d__.\E=PE:Z9Ab+CN25aWg:ObG@?ZQ@L0UdR>YC)KQ;:]:a6WGLY
LACgZ@XURDZA0Q4/HUYU,F(4+a]@,fIBCW5.U=3>NBQ;d2^9cHd4:M>;,bMaI+0\
>f&b</_AD;:GS_=TK=&4L.D4^#bP8)S[FFePOgKG0:PbRaPN<7<0+L[/BdIa8F/T
d5fdd@:a_KI-R^O&JEXdM0-L^EEQbA+TXd#(BI(9GJ#TTecW>P9S=geg\g5<=FNF
DU;8WC_LfGE]d<NYYU@@HESI#,\QGFcO8Z>P4PQ@86;f49+98U,Le,aAKPA,0-GE
O;Rf)S^I>E\LRKbXK[gKZPT\<1&b013/J:Pa=/D(0\^e<Ld>XZ2K@&XE>B,N0c[5
ZSL7XBa/C=_>9<PV2b_e[1=8JJ;N+L^.=)fN&)+PPC&DYH].7I:0XX&R,:(7FA?\
ED]8(Md+4-JVKLg,X.b)b@8CE_gb5<eWPW40^)0cVN-M\EfQ51_P9E18<AS>TVID
eP0I:;I5?-5HH]IOJgYR&S:bE)ZFUH3b;2;f^4G@MOB+HQHScbg+U)736/BXI^^4
E)];caF.@[Q1G-bCIKOK/WP?IG,((@dQ#C#W,S8aLR^VI.9gg<_##NH\UeCTe&D[
aPc0ZJ+CC54:D7L.<V.JQWZB:=g[=M[ZD1.[MMeP0^46b7_B/,[+Ue3&]7]bL<aL
YDN<.WP6a#@+fTQ\^EDX3#QM:)\5c4IZS.CDG(8G6aEB?gVS1OM#1cH8L:<[MS]Z
=ME]0;fFY4E<_>bGWI5ZH29_MQf#BHJBMY5LY,<F3a_E.[J/SS1GBCAC/NE<Y)AI
1HfcS5ZH5(9><-S0KV,EV_2]QR/f,PW8FN,)/<NA^GP#a5<Q6_AT_dDD_IM5AJ-A
a5E)d2ea]5NPR]X7D;L[CI0\>>DMXC(<11G3R.=c&DCO(T>IF9^-R;I6?U.gO7RB
NN1^Yd9V+&W45JA/AYNf&(dK,T/Z.fX5LY43F=:G3ON98CH_d>DKe3RL0&8>L6&+
60Ae_SR/T3)>_XC\))W(GfO@[_D?AD0E&0-L^D7V,U5C+FU91PH@R,g8SU&F6/@b
A)0R)5J6PE\&)dfX<Q?5eN38<C^bKKZbPK1S=PR3H4aYa2=H.LJ7.QK.OW8TOX]/
7]O6Pg33He^.JZPEaVc03-)_Q3ELGS4T#MRf)M_eK&)PNcN0Z2YH^&a^A6YK>:.@
/G8c374#fKHV,d:S-2=2,XPJN=:;bH+^#C#FPHYZ35:=A)<N)SZCZNNQeZ)938\g
,]J#a,fSe[Y)W)SZ?7W6(XF#c[+:GX7?QL]@]Z>]4@XfbZaMGKg,f(7RCfaGGM0c
XLQD=5#Of=PSBV5C<]Q-PH]9KX)8_[f;8bR0bVc?fMVE;=AdaMM[6W^YIVOO(VH/
>SB+cDSga8\<HP,T3QP&8FKD9W4ZY;98LX6<](3WYgVd.9B;PU3(H)ba9Z#\f(U=
2FZQH@>\;FBXPg3/Z79<W?59dB+OJD45A?-bZ(,;1c_8ROdII<@MSGVU0;UUf^1)
.3RB)R,UW./K5>OO8Y:(R.0DTbUgR0Y5a,J-:XN?cC-d#L0W>[FA^+GU#/K501_@
1@3Qc2aK_dGC-;@SbA>#;)e3KS/W2B,92MQFYfB&C;@<bfSR?OBYDG.;+&cHM8/E
CB9e<(W62RFO:a^11bD.3+^QOc,_Ja)\+T[3>eC?<g_L)O.,E1HbH:YRST;e#^0_
MR\,LR+B2@Z1S,fB3LEX@N8[/[46CF)=4MU6CO,a(PX3)TG[5D+fC6<-A#\06Y)>
T^7:E#bDc(V1aXH\(PV)U@6#DI+^c:VJ4VXPf<>d-dYGGO&GN..GESQSR8aOT?@/
]X--9M,LXa0]4Tc-Va:5EQHC7A)cV#6LGZ#6YX/7J8;?D>OBL^7B9IDa+&NKE<(?
R96TM\ZeNT+LFSO42=DWVI0W9M[J0TD((LJW=8N-6F,&.\=YY;f2\gS+I<;e]e:6
PeCW.O._LI>337SKK(QYeH:^ZUPEL8MD2]E3O6KdR?0Y7C2][Q7+85J:H^\SZ(JF
ONW<Z9af=e>3.H.?<^&T_B3NQFga#L&McIBTMRaQIaMF,@&>^#SL05-F7?XDCL#,
TC4DJ:(&MU/3/22^O;)F#1V#&d9W8d0DG]QV\)6O(7O(4c+ZS#\_d:.b\5/8XY7.
WD[3FN]XLX\8WfOEO6OBV1Y\S@V=[D_0527W?Cg.0=[9Q[RCI5NB_eO]e=5<^Y;M
\#b.^/V:=Bbe(JQ<W_faf^?gKgGdU6F./)Ub@M/><c6]c@EZA4Zd(N#RLgTfT[L.
9WP)eS<2(PcK9aBCVfKS/A^19Y(GC9,M8;R5M_aVd[KT.PTPU]([+de6A7#HX;Q,
4)0N4KY_@Q\J,<cO\6:WU)HHP?+NX+b/+CZ+ATOC(<SE,.?+5.6J#RU(b)::c<LX
RTXe#SNe?_/5+R[>(^,bXSF+RM,GeA;2Af)8)(eW7P@,EMHDbR5L:ILb?-\II1I1
V)T]GD]6fgfIMdHJ7629UE>a^0_1Kg.(Q2>CWT.3+JgLWHMU.[UaSaMY10cSK^Gc
/@.K7:[=/6DBUH4f>.ef3RBXcBC@_a7OKG#ZIIT7I.+f/?_O@5]>Z<WDW;P1aG,@
L@gV../AJQPKe9.E/<(#UY0R+]A,]\M@dV\C0P?:U)f#OA1T=e#FULe4)T-EgQWS
,S,g+[X7LedG@/,1c2g#4L/eYNF(7e0G=/_\L99dA=Q_6._\[3&IUVddB?I]A+XY
3ZKUggV54D,GH,,A(e@MELgfS;O\J\Kd<)bP)UE:D>MdLP5=#/]3UgS8ZdL3,RaB
7ODL_[-R^,UC[C_,/Z087.e1Va1\G=/(=?d?I0F;cX0GQWTeU,<F@dRCOg3N&IQ8
@KdeV.OU7E(b5+:HcOC^3eM?A?6X/2J;6@OW4]FfdGfU0P=W>RW2Y+HK;FF;RcQ[
dU+XRc54AYcf\@eIWVI)63#G,BFWMN(S:\72acJM&4.=RJ7B3VIQJ=U96WA;&<CU
XYPQF#,2++\M?YC\(.B)QWF:&K]GN6O=@#M)8bH3N_fH/E+dP-PK])fXBX>&XK4U
f87S42Xd#GO;X,bB,a>^SG/+LI<HR4FM_<ATV5BHX?bWE0(@+#8Xd#QLM\8^5S0F
-4ROg6/cT=5]+]fLG=PdBO+++6(BE=>EaI3@OF#5@M/VQ#SOZRH9]+L0Ga5ITCK1
_NaZCLQd8^==.IUOJHF@?,_KE[aS>P=MgI[4<F,Cf3LYWI7Y=[K=9.,9NOVT\a>-
7_gaSUIe[VRAQCVF/P\8P:[1N_N^fBIT;E:(<GgW]#Y\>&5J2,(CIKJaP/+XX<QA
Y-OMF\E\-_=BZ_TZg0Y^L5dJ1X6(+^?f8HAJQ:60aP#KI?-fc66b9O[6TJIce7Z8
/O[=dA&OI)&H>A9;&\20[NGcPgVBc?DR.O^0KC1BHB+UD(AdQO4fdN&O;Q@U#@@c
CYKU=aI=Q,K(=L.FZMX(H2?YOOeG0#BOJHYGaMN9G0XUeaLUQWb@6eC=EDOC3TeC
K.I=+A60Q(S,/,Cc_7HZ4cKWWDbEBSJG;2::0#eRF1G8-+/90,^HG7a_I2Se,UL_
6?f&(D=<I,=CP63_1gYF>D:^7]A<4J^VKB;Z.9]L,H&MA:SVV<3:@&0WQ/)O0#6[
fg;N@cB+F<dISCOLK@]2LX^f/4^^_Je-8#IU_.4,V?<NS@?DM.#FQOfN/dDd]f<H
B=cD<UT]1&]&,E5TYKM,4GBeQ7QEf,d;1(CI:,)25We)DWB;;cC:=BQ-HVE1AKKA
F2^_d2G5;Ce=SP?FFYTZ?-U<ON<31J>/)>eacK0e]]M#[S)1XO\4K^6+(<IB>8@^
2b,9\d\(f=:_Age5a@SfVJ7b=_HA)6GK)>D2_?bT_<@(:22GZIV-L5R#D)Vc^]U>
^,0G<XA2Q7^6JIC.T+Ff,+DUd^^)Ja8<;L0U@4+CUaa1HH&/ROLNSIb<R(YX<D6[
1bfKUVKQ,J@F_5CF-QYVN9HLI3=3HGb,Cd?AQH[6Le_D96+R(8(D/,]&-4JAICO@
52W\LX,+HGX_9LV)Gd5WZWE\)-9@^HYH+Yd-XfS37dEb8JH^SPWQeDCg)NYE47];
QbfRC3@R3V6fW?8:+II_8US=8eF^L(5+XKGKDUI?<PR5EKV\J.-BWc+Z)fL)F^XH
8W4FCEfRB)I:..8_ZHZL8X4Mc5K6b:/34]fH5/4fK;B)7Q08gB#NY5b[RBg:=bWT
FD7BbU3\+S^OQ4RANf>W4D-=)?UYVL0G:?ASTgScM?HJWaba(+5Je#OJA;2P:?f[
VP:Vg#<T<47:=<&SXRZJVERA)Ad-^K9VMH)RCBDYKGSfS<dbgEcOHOg\0/_:CBS(
:aAG&-U#+f,X]L9&+\/=LP\gbCM,F+7Oda]5J@cfFB=APV.0c.fA[dL6JE7M0M^A
H-d--_Ed:5g->dC_.LK14;TQQgRR6+6b(IMFZe3P,M4B7P7CWgb>5Q8W1CF&fZ?e
c(TJU-0g;\cfAWJ1SY+LG)&DN@:Z2109>:W:5Z@_W791T8,4I;(Bg8@aQ[PR5:8P
I4V1I>@QJA;A5S?+Ja2T+E7-#I&6Z?8VH(<cU,6_\e1/8=X1GOJT3JH-X3MA_G2L
IYT2aIMTO;Sbb3Aa1K23;HT@9[UH]/H6]HB@9[K6g@e(R-+8,&K4,98C4f)C)91G
E3OW4f\,TYP6^LL]A]CFb1b-YZ[KZ+&.?fBO57^9Db_LLM0=HAL(_V-aTeWP9dOC
fGb9W_#UV<_S35&baN)?Sc0APQKJ5W.-,Y@M==3GW@6@3cR/J)\USF/48:(#=DI9
?acXGX^6:ISUAGM@6DP8.[JNf:,Pf#Ke4_07gM(C<W1fFRX)1MA12FOSSQ:ZELLB
4CQ6HZDPB1#S,Q\dL\[gZZRATS=4a9XEJLa7Y(Eg6R5:2d[a#:L.dH@aPECe8XN?
N@]OB?g+7_>Acc^^)5#GH??N2;YRBW4[I#;,M3^c5>00\UG5[G&;C^F3R-#G7G#L
&VF7:7T&J#E9:aRA--2+DHMXMfgEN;:#4c]-639@21^#Q7\V/_dV:EY1Dd/GU+-<
R7/g9Z#S=LGTY&&=73&E2429#)P^VLHg^aI)U(&P4:;_ISZZC2bQ(\48SF)Y#9;a
^X+36@TaDC5NJYH[FHfCF1d18\8-R+Q71_[VA3e24JN#.J6BNFM_?YE#NI#HAG^T
\D(]_&T<P4>XXIG5&^PafcES#fU?Z6S:TGZ37[QcF03X;;F&@=ZbHUYGaG^cW5/#
7J3#.)Q_/6UZLJUg_J#0FfG8KU9NUO)Cdc-4\5NBGWT6S@FA#WK&dP-29a3Q9XdJ
1IA\a&NfU@JS3G&@?Q0.?gYa]8#1GVNI,fgRP/[d1^:NC\;5U-3:,=L8;JL92V;B
acUBfK2I4.K:5+e;;42MG6C1bY]fDb1F6WCH,aF4?b7/Oc:CN]>Q/L4AbSV&(:J>
b-O/gIV94P202X>(9K-?_e]^,99-:Ee@15[c.0K)0J6X2N6N([g12fdJU9G33_9N
B#=\Dd=0([eZXH\WXP968M/b]VYN#?XagM?,-KYES</fDZEg2>bXP;BNL;J:B7XU
0LWKK3W7f[#b#=M5?:DR/?BAE/WdT+G82JZ\&U0Pd-P-C\,57U6)QgR5T)9_c68:
2FKI>Ce3]=(VC;0LbD\[d57QN-KbK(.<G@G0=?<AZ2?(dg1?;]/9(DX,(d305,S1
+#_3a4a^22N8;,8N<-,NMe#UB_a6C1ecd/gTS\>,:\c:3+@e:YG.U1f.J1)IJAbV
)<7Q09S+K:9KdT>(S/T18:M8cYZT&9T/@aG7]>:28a6/C5<(b2MYC4/K6B(;fA_8
\2^;@?M]TM.5>O(OV(BTO\1)(abL6SGfB<[=2DXTa(_[XfAF?@R])H/H^2EXIg#6
]fQ^TO<)CJ\ee&9cCWMK:E7QG1&?_LPEJXfEZ5O]?+62,)8)_9TQc_c2CRcFRMBd
EQ0eGQ0d^P14@^WRFG-YV^g0ec;/-@=96CbNIQD&;[Xb<@5Nc:@9VQCA:G5=Y+B3
/f=8Va=2,@2]KGd?W((e;8geLBYOF=XO@0JE8SYO;PDIELT)TcGcF9^M)R?Q<d>g
9fXfgW4Y8a^JI]-L&BETK]HWPAGX1HTdBcG-7W:b+f<UX&D-0Fag@=IHUH]P#^4J
@f)&2R:7c<c&;^H[PZHUG&@V3/dU2U0=)3?.2B]9(gBf1<2UUcSd)g;Y2?cg2e6H
Y#?<EBc:UB26A0SB2)2JTG2DI)XQNIf0H<:4CERd<\J-[99d1B0L5cAMGWM[.(N,
C)?D^McQ4BDJ@,H\,>52TAEbbK4:1GNHX[Pe^4AK69W^>VT)]Z60?3JWMDR8+;HV
34,BJF)S;[&;2WI.<L5ZHF7HY5e^Y4<QS8-9PY-ab3=+D\BS.Og[\W@b^(1N^\TA
D2+77V\^(^eR\0-(g#O[V#eX6:L#-EHcYdIaNfM-8(c=aTfZPb:.M@XG/FT>>TEY
(cT8[NAG4bN:_\:(f09e4FSf;V8FXW^c4/HHTC#KKL)XNR/ZWJ597^E:)N?I1101
(b)<S0W.V.W#=)gOF(E@8YY6^.c-Z?W>aJTKNWc6c.HDCIL#.S?)gAJ0f1F)4+#H
\ZB)@C2d@K052?1XOLUT&a9MX9da;=.J7KN>?WN[<3>;WbIM7_OSU8dUR8V0=#RS
[Ab+Za<Rc:?dad4)acT8R6BE6G:A15(B0-@@K7TX.ZcVcHMOaeGV3EIT-6UO96RY
e4T]g7=bC86>]J15>Q<d-N3ZeKfW67TS0Z?PB/f;CFF##PCLc?aYI#+6Ue\8NFf\
R+>GLbfD1c/OS[;;EFZbJ+DGKUfEW-#35308=.(+J/#I6._cLdH1I3+6P$
`endprotected


`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV
