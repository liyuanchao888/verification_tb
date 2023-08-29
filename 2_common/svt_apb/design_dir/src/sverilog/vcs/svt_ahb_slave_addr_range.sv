
`ifndef GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV
`define GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV

`include "svt_ahb_defines.svi"

/**
  * Defines a range of address for each HSEL specific to single slave identified by a starting 
  * address(start_addr_hsel) and end address(end_addr_hsel). 
  */

class svt_ahb_slave_multi_hsel_addr_range extends `SVT_DATA_TYPE;
  int slv_idx;
  bit [`SVT_AHB_MAX_HSEL_WIDTH -1:0] hsel_idx;
  bit [`SVT_AHB_MAX_ADDR_WIDTH -1:0] start_addr_hsel;
  bit [`SVT_AHB_MAX_ADDR_WIDTH -1:0] end_addr_hsel;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new address range for each select signal of Slave
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_ahb_slave_multi_hsel_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new address range for each select signal of Slave
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_slave_multi_hsel_addr_range");
`endif
//----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted. Only
   * supported kind value is svt_data::COMPLETE, which results in comparisons of
   * the non-static configuration members. All other kind values result in a return
   * value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
   * Returns the size (in bytes) required by the byte_pack operation based on
   * the requested byte_size kind.
   *
   * @param kind This int indicates the type of byte_size being requested.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. based on the
   * requested byte_pack kind
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at
   * offset, based on the requested byte_unpack kind.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public configuration members of 
   * this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public configuration members of
   * this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive configuration fields in the object. The 
   * svt_pattern_data::name is set to the corresponding field name, the 
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the 
   * configuration fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_ahb_slave_multi_hsel_addr_range)
    `svt_field_int(start_addr_hsel, `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr_hsel, `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(hsel_idx, `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int(slv_idx, `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_ahb_slave_multi_hsel_addr_range)

endclass // svt_ahb_slave_multi_hsel_addr_range
// -----------------------------------------------------------------------------

`protected
TgL7a;Wg&OH3G[#L?^_fZ=>D:GJ\J=K8Z>LP2K^Y-YM4=->]:FB_+)HI1.=AM,RV
-_Rf-CBV&e]+\9JX6HE2JQV1LW-:7S0/d)816Z;A)#3aUab@QM=QfHZLZ@N,FKT+
(/AWNKM(?ee)15F\1KOc/I)[NBRU<HF@VQQ=.CAANM+g:+&2/7/\aN3IHUNQ2,E5
E=fVV?cL<58JCFWNQc;&^YMKKL\7)HFS@WK4PMXA#&-g>7=C?(<cEIZS>f2,PIE=
Q[[HL4P,QEeJQFT(#H/3;0dMOYJf.<S-CWN6]ESMDB(I=16Ae=U<5A]?a/gOZ_3G
59SGCG&;S;BL\:G&e//Y\@c1MN15a-Z0RT<+c.6NJ3SMAZ4?]>F=;&b-?b91I-:f
fT_25XYQVE6g+,7c-#R#G,-Pb-JN/WI#)(aULGEbQg[SKDV]R+;g:d1aMc#3<e.M
LR^N3/87RJH?6OD6H8X0\eWg1c)S[:SQd35GHFJ2RR(;5;Ia3<_DC4aV-H@]^aBI
@d-4S)F=OOMZd#I#X1HS/e9@>RUN1DAAV4R_2T6\3/[+;@f/.>D9c=aVL$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
260=Da@15@g>.3>30c/&&>HXaM^Eg6?c4WE9W/Hb>];g?OX8;DP>,((S.>cY)?88
R\ZCg_@JCSOW1VHFSDH@[-TUC0U2[N=ZD_X#bE8f<[Nc12S4:JS3]Qc48,#E:):a
FJ,]NQ<34^fWDF8DLZ@A?WE@?f[cQ(a_LOU?EVIZbU;f.1aJHD<=TZ(?9)Qd&OT?
6:\g3/[Y]CIVYXJ(V4&H+UX@J3X-Y.BdW<Y2V9g&1U])C)X(D4U6b&7N-&#JJefA
[D,_Y1V]:UVPM.>PMB0.e^>g;SWbSQ@10G:;e/^6+R9)^H0O2bLOO&N28,:Vf,gX
S8V_3C\6MYEM6Q?@R):Ub/S=4#5-X^=L8W)3b.Vc?,O1>V6[5fO31-FH74.c(G]4
CW^\,TA[NE80#Z;(/ACf+H(XJ6SW;NZHF(=]gUea.)/;(FN7E:P2OA8Z>B?REFIP
_;/OeNN59RdNWI8,#XbY6^S6YJLF:U2eO0[(JV@a1-GO?E0I(#Fb,)[f#+R7R++<
4VC622d6\f7T371.cSVAYVVM<aeSKe7NTHX(.b4L=bNgJDWFBC>;-d<Bf+JI&UK&
.7S(e77KD1>#V<)bBf[J=@\6Zea1GD63IUYBdEX+7R6g7e#-<JXVae^/3?,(#U59
(@R?YM5CI#P)5RI=;.SEXQX1[4:MF:NN^)))0_3GTKX=CN\,BL5CcCQ@M.d(Z;B\
R=925CN=cDR=(@7RX(AHVMO1BNR:>@4)#F49-@<a:^G7.cE]\M\UMEO3LN-Z;T,d
U.E\TO]1Y&]T7./?P)BW@_AHWW0YL>4e^We:[,WHW7F.ZFJJJ\WYd@LZdH>MN)6C
/)<\@a+KPT[HLXg++3:=DWJ(D)-5\TSA8R0?Cc<8WV@]\\E.+OJN23<E<2O=:DY<
[YDG6eS\b[V+0+c>ZE)dd@Y:OCK2<IR1FE.I/[SX]<8NTd/0Lbe]8[@3XSMP7(SI
9#U9+1dRf\M])30<b<#S<G9LXU)K/bK=a)#AW(6;Ud#V,?aR5&QE-+K1X=02+DD_
b,b0Z2(K5^J9E]FW25(E<W,9&;L+5OTSREa.Y_Xg8J6N<,&U-Z&_Ja==TObGT#de
2C]1MKZB)fSceaP+d91#S9\6;O]2Be9P/#923K[Z;,c.RRWb--V?P-__EXf,.X=>
0Qd0?-eEcUaJ&:g^eXS_TYP=8Yd57R@fAYC)+:[@UE,)(-E.^\P_(]U]KEC[BMNU
MF.D;]]F@UP?]WB9<>:dINWW1+1^SN4[=DfY0KTFd<7+(7Q>S&L2?L3;<&A6?VfQ
26::8VE]DV(EDW9Q2+0QPWI(3T-/O4[9Z6M[S.,Z?J/cGBN]72NC/Ng]T.HdWT?^
Q/#>BO_QVWP;_DL#[Q=74T/T;FF76,+-F+UM7WWa/DD[Y+4GSJJ,aXWd2IN9Va?^
aUUV9Y.e@(4?P@7>D)4WP8J3eMbIQTU].(AbG+a#M63=J>Y2a0;2XLR&5ZR1,1Z]
UOPIY+:;:;;fed8BT,((:U.6ZK@3&@7DB.UK-WG5OP+)5g6E2e:4+#]@.?IX-^4;
-DSSN8)_.2T3JAOeE+>7Gf6#c61ZV92,XFL(8PRfA-S.=NHbR),b^:6_C(ATP7+-
X9#;=&DG@]IHIe47-BPAKA;6TU<gd[&JW?9W3>R11^d(L:@DOfdXUP?_6W,;ZYXJ
/e+N?0-:#)+^\@4I?_Z[3//Z(cKVI9e_9XGCYcG[5M_SUU5)/,)3[c77TX8SJLFG
F(1O@XHKQa0GOQW[GU47VS5-)_c0OS:(3C_0:I@.-.1S>,5]T[8gW?_e6>CVWV[=
:f7V)L&GRM73_.e8W^ff+@]WZK,d[DG)^fPfS.]13DC1c0R).<3Pg?>c]UWJ53dI
E_@->28MQ(;[#@CFP3CH:[8e&FH9OBK8[R0&F@&[>:UT2<ZKU;Jd^.dJH4PcJ?Y@
,fYNUGCM6)W_I90^=<Z=+@aG6e#QYH5EDWEg^2_A9=1Bd\YcE/F31OH5&_9e_bga
_,5@d)NQ2be<^4UEHL+N@_D?Z->gRTL96F]ZNAPZDK020Q2)+KgWFc>TE;2F=0e-
4a44GUaTIU\:>e.JbKfL&[9IL)@(1gCV7GKc>CXB;-PCLdYE,0:P=6R_#ONfY8Qa
X@d/#MNSK/A9<:D9F26+37V/+1#\)fVM2OF)8&7dF\6V^,b,=7M1@SX@0A,)T95#
-6/K2@<KAcN?J@P^f5PV>Q]76+DGHSYeEecf_//GG0>cbdTP,;f]f;:I.Q6G=c.(
E.Tc5^.)=>.7.)KfAIK=F)K97K4<@46AZFR23WUZT0M<KY7+JeXYDN5c,K.<_CgW
E)eW-29.EZWWb>;ZgTW<&WYXTX//&H(FcMNZ:;53#(dFaNNA48=9\/g=1^e.-H-f
3Y^bYc;IIg,/1f<+#<2D-+X:bQ_]G4ARfA+]BS9/Ee55b=<\)/3S7PB&&F00P<g_
N=;Y4N:.TKC&eeIX9AJ15O.GS7(28?,>4<KES2D1QUKM0<:bZ)C0Ff8WJQB1ADQ2
DUL;1g[g4J<^XH-RBU^-_O_P?8c6\]6&;a,4CE9N+BWW[a.=WZ<_CX@QH@H77CT9
?.6;^Z(89NPI)\,=:\Hc\Q,8+=]76JgafSD(GZPTR;_MV0X<]VJ2,bMH.?(CM9aA
MXPR<O:6aa/L54)Wba?bD)g>^BRN(.2f9<6UR.A3#1ED,?@J6OZG/,EF8T/RT0BL
#8U^8EL93.XdF#]KVE0,5:Ag212]^6g\^<Y+?@,La+SF=<J8\dg:3OPbW0a)cf1S
Hb]EEQ=-4be??Q^Za2f2DBWd@N#HCD7:aJC(;D7-Uaf(-KbU?,4^[1#eK/,)3Z2O
b2#EKS)B3Ma>3L82YTdSVR&M6MGNdF42PbY4bIAKDQ]=g/N^QggZMa<]-aHIOBFS
/<.fUfN5#C:BQ;Rcef_0g=[5e\e3+#,/QZeK1X9_L(WUY.&cW0>cSRAL=.S]XXBQ
]5f:(F2SGJBUaXFR>8^E^CTUS<]<99YWNOL#K46CK3(+/\QbGHKFC\b<e2_^E/;a
?VM/_Ef1cNK4\.8G3BVHdS63U?BT,#OSd+8PbRT@&Z[g5Z2^bW-X7cN2=Z]27@5;
X0UVa09P3V7E+V-&J[IdON-G:>^M_K\5TgPJ(EfX>O8R8<O)BOYEG37Z\8_;HC(4
&[;Ie.>\/(GYffP2;-ZF@LH?=JB/Y+EaDe;ZRQgABXIeR)Y;I)APFaM5Y=gPC9/B
P5=,:+f7;,a#3(,2fXR?(FO1IYD[M-Y\>[8Q]JY@TfG-OHF8H=<^QIg#8=Pc5WC.
Z<:QUM6O],W3/.BEPU^_W_bG)=5<?IIZFG9BP>\APN.DN3f]]GWHIK5:#6.+D\)U
OSBS@fZQa>8&;GE;RFJ\F.7Y;TM<-3d?6OD&(Ic_b1#gMIJ^J>_0X-L.[4f//79+
Q1b>X_28P\4R@-@&Q]QFL9=1SaZ>dFB3<ZG&G[&/^Kd??7THGDW:B;c3RSMQg:OU
;;gg:\4@)+DdJ[P;Y=)LYUVEU#gB9Y@TN0\@,T@d0^P#,;dAN+MB>aIL^d_.001g
1@&14?RfY?JdPfR&DVObM#3M<@)O:\@#=R/.>7Q[C4.bW1R\[f^8fE;]A[F8X,SV
\Ta7(WHL90(CL-G_?YK=U3PC;CFM5K+6SfDXa;.6_A8L&Z[M=-6#SJX@W&(ENHf]
gC[:->8=^c;2-7PA;&A+07Y#B^H2gdIHc@6NGPaY:IYH-eXN<)B190T8TZ]>^^\Q
JWQR77gB706U&F\.aFfR/Wd(3F4+>JE[KFaNJ)(H+XPIGEYX)BGgC(.>O\F5+0P6
f;[3dJ/8\[BR=T:1Q)TdQ480FS;#e>a+FN2<5Z<(Y5:L>W?)e6)<IeINba?^QR=V
Gd<9)1[f7V2ZFJ^\&KK-G[7W]#1&D2PPNL#)K((M?N;OT,4De423.TFB,?HA2OK@
1c@FLOE]@9cFBT5c:HX>V6AWKZ#:X@g@NR.ZJ-8R[:CW8O3fEg;=>O7HZ^4MH<>(
eEU)W_ebYY@R:(b0_,VAI&3T3SGDQ[WG&SVg__-BdDLY5\1aa)6)]QJfN,@Z:I(]
E=RCLa[3d86N;FPWWIe-6;G#0.7E::))Z70gR,_1G58SX7+=/G<JPAL2X^A<A6b8
1RVb236N^HIQPfcVI);Ea[\CWY5U[6b3FU5.D\bUXW(9GH@JX+eSJD<@B6KT[]#N
4G:+A[B-X/9J+1@e0E.<<AF[,O@3fMCS#U1&e#Z(DQ@6)cW.f]?PZD7]F5596d;#
G/JI/9dfO7Z[;/.&0<++Xg5_S.?LWJW>A9+@Ob_;NQ8;^_4S99g2^Zf:.V6+VECR
\UXL(Ia3459PWc0[5?0>3#3VA5T:&1_&&3?K4P]MLRI?87XUPF0RT4I=ZM&>B,MF
.XBR>Zf\JGWGg#60g@.[I?9YgL+Sb#C,,)VW9(.6Z(d.DdVa&=<4[NYB-.^a)T)R
_ZP+OYA[Zd2+aJ3_E+SaQE,.dF);UYR,LJ&]Z4Ufa)e)[^K:W]e,(DD3F(e0\U+C
>g.g)^?5AC+L/AR[A<QAD7KY/H^5_\fb,.Q^N(Sb#ROWAY.AQ,B)c1Yb7Xe5U?Hd
bb)YAD4&YS7;3;V:WX\:)01B<#?=NbSFc0Z9E=0QDZVHc4.=9fRYVY\X-^4FgE/b
,U,@<X]b^1Le_RG#-_Q4TMD8+B=ZT9PG>V>Q^4#Z6b=I6Y#ZNPH\X]e_BdH#BIBT
[E5RHHSMc1^g61)Jb;Hb?_5GV,^aTE:2g6-d]C32P,_)CF8cMG^K<(2@bY77#HAb
_<NW5SC2:I[YV\_@Q5CK6GRI6Qf3MHKG3F5.,P8^\P@bX]c&VQCYEMgW:R>]_R]1
D84bU=OVA+PD[OP1J79_T2g=KLc[.Pbb^0fT-QG763G7U72K.cTYV0?IHV@<N([D
gK#J#UH<:N=+MZ(OI88bgJ2)Z)2DNZUTe4F=G9]V(.9KC],6Gc6P=I@N/<4,P\Gb
_NVC89)UZ\L^V8P=;FQQL<D^C21e\N0G>UbP41T:MdS=SH7)7+E)<QL)4,W&I1LT
_&4KLE-fc>cU)06I>V_F^HR9]\#Z+G.H-HZ)+EH8WZVMC++R=MXAgX[gbGQ>4,-9
.0a@D0P_g6d7CN0SG;c[2dCVZ8X(-TPHA,.EF]]:2+_OU>RBTI/FQZ8>a(/PODdW
)0XBP,JZ?[-R/[E_LC/H#.3:3M]D^+a4).9f?^f?e,OGbdEWFM@T4XI#d7YZ@YU+
eQ@86YIEG)^94KG5P/+D@>5\13DVKRFDC]B?]:M>_eUGT,=;eKHaXJ.J4BDK0YFR
1E831.R=S(\dW0eQ.H\J>M43+JO_dVT-L&g,[Z:9PFf2d1GfCaAH_[c??.KdgUC,
1FHV^c-<+V^N\_C4;Z^B@,BQH<;:Z-]Ec^QRQZV2YP0>TYFID3I;TLTO#g.N7aVK
Y?RRQcg>RFJD.6J(&4L[N0P3:6bQUP=K@FX3#,CcYBN6RS6GIJ0]\_\-Q0W0C-2A
;R9,d,@&HP:-XFBD7>(7g/F;.A.JQ0g\KM1/>RTb]S]B;gb00/0fZgCc?T4KQbC?
HGOJa;UQ^BEJ50DC7EZ(JKYT7ZSHU#XZB5C9b:Xa9gR+5O[I>,MI>]?2EAY8Y5XM
#>N&O[9[g=J)9,QcPHJV43VY?H2d(<A?7J)(A;D0[b=;.6>NVA[VE-0SS=L=X.a7
b.7A^d8M_;fVL?a?[_E4bGDWK6HN4^:O#YW(2eeUT;.dYY_g>;7SeIEd8LURWE)Q
YYgMGD9C_?,6GS_:LSM-U/S10/CG=9XB]QU)EX(C,0bd(BTOOJ@1e4GUU9#Ta5\^
gX)8><FFC/b.1O>/<QYC_<Wd>>4C).=cV&DS#(A6BF?8A5@IQQRH#-))3Ka@D1HB
:E5bKI?M&\.TI[GRd&)Q#dX:23_ATALXC6]WXQ-QfFM)YOP+cA8PL/&^b_RDK37J
-J\:9@fN,@?T5FILQb(gF?Z)J_[=a6#dZBN1cTXacG79GXD]b;d?3P@B4GZL&7#U
a2S.HSJ2IE:SY-RO06^;IUXLe:NW(aM<RM3Fbb7WC#QPF6CR07)(4VPF4VU.fe2K
TW)BWZHdWV.W\>fYM##^+=W0LG.CgRe>SE.T8P?Re^,e_).GEJQ]=)HWX.,>IbeM
;NKR<<_:G8]^S150/GbIA-#EA8#>DK^a_O1?4A:/+fg[HJV#,N[0EM\PDSODe/,c
bCY7K+?bH_C;e&O-&X(>Y#(KO09GQM)EJ6aO63?<G8e=W^V:+??3GC3[BK_@e(A7
1:S^\O-cKG&K>?OeN#JKQ;MgF,;_6EKY65f<+IBe90fggST-(Qe((Egf+AZ^X#&c
G(Vc^_E>db#A6IN5S15W2FS(3TdC?b)2TK:CL#Tg[LSYZTN(L).FBV;,S[RH3\TZ
0-;NVcd1283caJF+&F6-ea2XO6P-<bgcWGF+^CV4Y@ZWReGZW7AGLK=VR\2bK/U=
a_PfV(2X5(3f217F2NB#,U(Fe:2aG:d1J>Y8J>C&,KC;O.,<Z_,WZ?7T96/KQgfD
FSGTY4J?g>-5J7V6(/T7^9##PX]<-=?NX06J58VaM6VPGR)6UPF0PZb.@Tc9_CC(
ARIKUCD]97bd?Q]=e(N7H\NNNd3bXM_]H:I=674Y+G+CI5E)fDVL@HFYR]g529.T
)#4=#8)BQ4XZFHH.7>Y]A;#,RTMU-?/a;P;Y(EUN2a\?^[I.58-EE3LYKA;V/9[L
:E=F+E)C.2ERDd/<BK#d)\(_c0eRB/Mg)U8IHcZ=ADI8H?8)N(X;0e#egI)OI@[U
CMFFHg@5;g;,1HTW(HVHfLXI,[(1QF:=U6,d?6N;O9GB=9@QG>-#O[CM6/[AeMH#
RBTM0OEKdd]B:.#H@1?HTBN&4\OD6N-#@C8?a;VZBF;SIbd?D>PQ=UUE)XER4#LL
D>(#R86cPg24(C/B&<1T)0?=_)-JJ/GMRN<MSM85K(SV</,\f/(Bd2DF5?B/RJ9@
fVae:K9Gd6NE]3=[;B/5]_M.72B40OWcUC(6G1)F:8H[;0:>8Zb]9CJQ73HX\&PJ
.B.7g@(4>:#Q\XG@-9WPSc08gOg^6A>#W@CCF^3+5NBY(:,Vd<6Cc-./3_b=;[+V
]YWGBW-T2C1LCC]]?0^5Ze2_T(,:>6QcCNZO>L;2-Z2.16Y4=H793O>g6PU#6L5N
e45L<B.7bFRaR0<(#8^ZE4XM<d[SG,Q]d_:L/Z7gJeFeQ;<294A@-GYfU7g4E[M(
F/BUDS2EbgW5LF(J[[?2d,G?8-RT4PA?+.S4(I1L=ZNO;c+e+IR@I)aGN=2/OK4Y
6)83a<6EN0[,C/:)=1PCPUW:9U099U)edEO?MWfKF7;X2=;H\MK1:D&;&>fc6aa4
>OYBA692C8#\B&CNQ4bS6<5-I#75)73X+@K_]PeYJ]CGTg@_,O-XeU0O+UcO.].A
;1dX79Hg]-NR&N_(g9gK[\>RNS1C?J+[@ff.=M^=_/CQ?>P^:P9g>MbLMGNVH[24
O)TMYH>CH>O<MU.K71P]@HYTf2MTfLVVF1Jd1N.HfVP?T9Kec3-_>-_:.46I)^d9
GX?75PFdWNJ,=O[]WEf6bYJZg@+Da)F8=[cIS;^)VGFE4Zg</W>9X9/^RC9#BD=A
/@dgd5+:Ugd-W)AA)bBfeS[aPb\ERa7abQ1/D[FG?PVN-,WT8&WZa5,->&bWQT)0
Gc7H@EU:@,2YCE0=GfH0<gJ1ELIXBJ=5@a#>]-#dKX(/J1L9-VQ;O\+d1UOU<^P6
<GQ(>;WP)1-6dZ<GR3ZN7@&WJ<EG^:8]Fd+IS4@Z&VScMVPZ;DANQM).VL?A+_B)
(W]GYc8V+?__W2G(XV+UOY]H\+E-N-FC.Gf4EFe;,c1I(60(ggZaf4\0LDKQ\37,
PGR,D;_NMCJ_3d7H@V,\4R5P:HEA2WHBb\5dT7>J0?UZY5QMb8H-;O(\eV;d\K8&
/8Ge=Fb(Q^N:gf3+W)[+Z2/?BF;)Eg/N(3]agQ&2P5UUB6TEZf7g@dRJ-QU:4)a-
<.+4aSHW0&g(NYNBe3HR>W8V;(USJE0XHF@_H6S],5M\WV_CQEILR9:PGfF,Q(6#
5DZLU]U&1;OV2\UbZ/86U>+8#K#^O0\)/#e-eG3a?6ER<#FNX,6&2L]NZ7>Wf@Ya
gU,:ae@XMB+a:)5]]?bM<@X?0-4F?5:-=@WMXX+&g2a58[[8WU5faPZ/\]M0JK8A
[5aGU4,#HgSB@,;D>:De0J>ZZ3&Z/?>##4[PO-NJ)&JC<(P;7A([Rbd@C<D^\b^D
Y:<\G=X.1R30@R-W4Y>(b7,>fJ<T4;Gggaa;0E2@/bI>FIH1VH1fD]YZ6Pe@9#(5
?a(EL=dD3EZ#72F>GR3XO\NR[P_]):+WA?Z-a>#.XZB6P5/.aEN>DB=TCA+BE>+=
GMe_A\7]&dS&&ERHaa:R5REP@.ST?QJHV\#/I1^d.LVW2+H@/eS>TI?P?MeX_M;-
8ZK2Ea6EWNLR^e/MS8<VG&,H=5QB9HE96/9.1ZHGD#2^AAgL@f3bIPcC9&Y6@C[P
g=5A=QXaCIG=)>9_2YS1eU?OLc.,SR)=eS:,+5OeXYBUZ28gI\6c(VOJQ(g10AS[
ePG>2+7Y84DFWdPQJGb9&>e:D<6\:[3(2@6JK:cCX?D;bF\2[=LJO_GR&?V)C6@T
>0E@_DL9DSa)W&7K()=5+^(DGTCTY-g0EZ0UXB-[ZK)8H2PZe.dd=/d_Gae/(9IT
5_^\_#T:<B2\2[Z<+e_dIJ:-Dg)V:MD[gP5LZMcg>W3)OGa]1L(BCeWaQUI2d/X<
?-0I2PT^?^EbZ9<A:E/<>GGO@6eOO9bLOJ\IK:>=4LYX,_>#+-T0N;-aIa;(578G
S6d2&7I&=b-B)0g5>MIZGLV6&R&DTFaRgKa>9,<4XR2S/U9+W#5fU]&&f3<bdg2-
1^AKQX8a<<-AId&N02U2/-)6R_>P)M,H6E^f3)F[-a.-_E1LNVX?DR\XYED^KAaU
?/C8&IA[[58H;J23#7d,&TaIUV2V?Td_[/0C98PE5FD:,6LeF9WSPEI??7.<)g<[
fS>f;Vf82;,EXIQc]+(YS2M2YYBA37g@cW]/12D9^&T@M3)T?-<d?BZ?/Z;FIG1d
EJDgVO@Xg4Q(gCSDBHABdP08e&Uff,5JXRQ0RV6JQ9I,(8cO(+2^-XL:D#,;9502
<XRT&>3YQR6</EP=NL3;M:[Q#QHf/1M#V#3,F@X(5R-75adTd(F]OG#QVaLX:_]S
H+\NeJL/\-D_AL2bN\DU<4M26-;R+J0YZXBT=:g_8Dd^T+HIc><0egXZY<0BA@5>
O&&3Wc?&dg,Fe/d_M0gKL>0#WL0?ad78>KYTI?E\&(&UU_G=ZbW=_P^AOYTY7f3?
8+5/G_</eD2/N;cH5PXQa[GbO92H2#8D:R-^+@?>ONJGe(T-LZ_C6PdTQ7bCZ]Y>
@R?C&B?0g:KY3:I3a/CEHQN7,V;@M2P9UVdI_4C5?e:6G[NC)^47O<fO2ODTJXV=
\J+N:JL57?_G5fK16(PcO-QX)4MY?(TL9J-_9,.adK)dM)K9SHNC=\Kf<@QEV<=I
_=,OLJ7^0ZH<^35>FBI3(NQ:CN+JU)<Ua05IYCe]7/7EOa2JVS\a](5>.8D]W]QS
GRG4V&]YF6ADG)@QZW43XU<6eZ3dR?+d+9<327/Q]8f^DDVTg(GS?#/D+AQ[+?5F
_TXB\QXIc2=4PYUIdII@@>]YA6D)G?CEN8S?EOA3:N/?e^C6fB83>)5@Ce[Z4>3R
a]W\HKUR:<R2T_K4&M^Z+B@fLY,^,=VVP^?K8J3H1PVF&N\5R]__HMC8/,OJH5Gg
V_13F?5,9+Y9GE(]QV#0F&cfQEJ<eI-7dI=b3)\V6B&3I-&]=Xb5)4R#0<TP-gM(
N@Kb&?P3V=[Jbc@(@IAYUP<)Pc>dBU/&L.[_MB3A&<DZ?X[2VX/),=<3H?CKa;3J
UPZRb:Cb3[B#ZfaWM>;aVKRd[bVBXLNHD3:5ZEKH_6a),U&6?X/.=I0T/f:K6;>W
#[MDO_S5@7:LX5F^SgDT=O07L=G]FKE+UW^#7CNL,#W6a&\J#CM8BB5NI>?a8_FE
eL#XV:^)CKJeK1e2ZZM\Mg078$
`endprotected



/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_ahb_slave_addr_range extends `SVT_DATA_TYPE; 

/** @cond PRIVATE */
  /**
   * Starting address of address range.
   *
   */
  bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] start_addr;

  /**
   * Ending address of address range.
   */
  bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] end_addr;

  /**
   * The slave to which this address is associated.
   * <b>min val:</b> 1
   * <b>max val:</b> \`SVT_AHB_MAX_NUM_SLAVES
   */
  int slv_idx ;

  /**
   * If this address range overlaps with another slave and if
   * allow_slaves_with_overlapping_addr is set in
   * svt_ahb_system_configuration, it is specified in this array. User need
   * not specify it explicitly, this is set when the set_addr_range of the
   * svt_ahb_system_configuration is called and an overlapping address is
   * detected.
   */
  int overlapped_addr_slave_ports[];

  /** Address map for each select signal of the slave components. 
   * This member is initialized through method svt_ahb_system_configuration::set_hsel_addr_range.
   */
  svt_ahb_slave_multi_hsel_addr_range hsel_ranges[];

/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param log Instance name of the log. 
   */
`svt_vmm_data_new(svt_ahb_slave_addr_range)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new slave address range
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_slave_addr_range");
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted. Only
   * supported kind value is svt_data::COMPLETE, which results in comparisons of
   * the non-static configuration members. All other kind values result in a return
   * value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
   * Returns the size (in bytes) required by the byte_pack operation based on
   * the requested byte_size kind.
   *
   * @param kind This int indicates the type of byte_size being requested.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. based on the
   * requested byte_pack kind
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at
   * offset, based on the requested byte_unpack kind.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public configuration members of 
   * this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public configuration members of
   * this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive configuration fields in the object. The 
   * svt_pattern_data::name is set to the corresponding field name, the 
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the 
   * configuration fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  /** @cond PRIVATE */
  /**
    * Checks if the address range of this instance is specified as the address range 
    * of the given slave port. 
    * @param port_id The slave port number 
    * @return Returns 1 if the address range of this instance matches with that of port_id,
    *         else returns 0.
    */
  extern function bit is_slave_in_range(int port_id);

  /**
    * Returns a string with all the slave ports which have the address range of this 
    * instance
    */
  extern function string get_slave_ports_str();

  /** @endcond */

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_ahb_slave_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(slv_idx ,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(overlapped_addr_slave_ports,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_object(hsel_ranges, `SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_ahb_slave_addr_range)

endclass

// -----------------------------------------------------------------------------

`protected
;J4(B]SYH./cNWaBNQVCeUYVR6OL;JZKM4/GWdEVT4II^RM)IS4E2);:Y+egYERY
13dHf4[?[+2_3:V,W)]8eXHBg.BFI7&6\]^Z@K_V</)</dE4X&NF9Z5+JZ=[>S82
PZW5C[8/J[[C>GEJ<JDNL(>175UDDd3a@Y?G#>a&IU[K?>]K__Y+[aM_67SIRX@R
MZd+M5gK@?cbdW_-+>IF0W4_<VF]R3g6QYfY;#MA,O9UWf4fF9QV3^=&Z56@VPND
D-GeaBB=Y+WeC^X@;<XCddLTLN?O_WV;C)B11e,_>17;VFFEf=KY9=7]6^E43f\>
EZ:eJfFd>_9(7QIEV>#G71c7O\W.-d8,I?Y:82.Z2+O-BM1g.cef<\KaWTdT:8(Z
K=2bB74fT8.Id@[QScU#JY#O#6>E2:;QA<e560dO;+^BE3:M,3?,_G<?HV^3bU7K
91RbBH<J(YBN+0QSNeJ5LFQ(LEaZ>]OV_MC3T;cA1C8LX74(BR&f&XD(=&db_-;aQ$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
.?X_VJ.c@,#8OYIT6GT87+e=6QSa9)=5D:?2#9\\c)(Y1HITF3Y)4(Y0IF9\SU:Y
&LIM7c;VK(MVDOTC>d5WS^(0A:6[MQ_=>XGHaI[Xag47dNSPN_YT9RH#e\L&XIL;
<&]\R7+?V=SK3>#9Of??P=6C;Ga-))LITM,9Uc:KDVZ#Y.4TcB0-agYD^P;bNFTc
T#U@?6:^f[B2WAb(]J<+X5?Le\47GWc(&WOGFe.P329_ZTN:S+0FO?a:RH9(&SSe
E(J92(Z,SCJ;WS-)]5/cUFbf.f?PPg/V-1e)\SS)24K]P&9RZE=:b1)&QB4+(=AY
-JJ>GX3dI-?\2FXT2=35>7S?/;2RPUIS^[ZC&?fHGb9U+<E?F(22DMc5PIO[A-\N
bRG_\Ae8D_Y7,OO:08.?RS59V:a3I?&9UfN]aH((#5//dISZ=Ee;b92b[da4=aA8
/,#UKS,<=&AZS#>Q&U(OE+6.DPZfJ4QQR@?e4?BH?76_9b-b=]I_0PX42.b6C5\_
-3WF^.B+HfJd2fUV^[K\5.RdJ9A9<,WJ(T;JFf+\gVAD:A.AbS\aCM)\a/.A;^S1
I/ZHBgc#;g-SV;76K2#EG7(0W^PD?,).P:N@IO<a1ge>&/dWWbJ1:,T)0=LMb(M.
[#RaFXb9CJ,ES-)3UW^XO_:UK=?A?g;H):B<QV@[3QI)Cc4BR9B:\^<DX[N+99#P
=;a56SQ;EHVV65IO#cB<UIHX54RTFU/e9U(?.;BJ7AaW(<F1\Aa^X9F,=E2O9684
99I8D(2Z1IVTDR+V3#R[-M=QF)c)X;GK.e^A_C>8=IN)NBK?@YM.#/:fcM;OENM3
<ES93W(RGef)/,-E7;)gSFFc^\5>U.;JTN)EMK\1+>XAggUG2><J-[F5dfIQ@a2W
aaGZdf?:Dg5<&bRLV&/>-Te6O(A/U[TCDP9QN>VQ5cf5&M]#/9Ic+8dWd-S,WB)R
+FX-?LEMg7O/R?8I?)CI9<_()-<K]8#N.,8RUWV2:D(<XWe:P/1egBaDD6T-SY8^
QXJG:V&];D+JOQ\GFCK,c2A;ZIYP0)>2bNZE<=8)[Z(=;I#SU0OB2,Sb]ENI(Td(
e^_<4G5E4)4,-M3_+7G)45G.M;NGbRC6]-eNffc,64N37QY26#ZgWG4X\]B]GH&;
B7)@@(J(UHDVbK^\TQ<A]BcTLI-I2f+DXB1]4[<4;M^;>+,b>1#2E.c2D;?FK@U6
cXG1+#42L=9f(cRQ=,2?1JICLDgR>])KZ<R+I6A,<M21CHU@g8\[/S;G#9HTCR>7
Cf5<=<YI=b4f7BW>]7->=Y=KC9,.(;,>QZ0\c:d]+&VAJe=-E]>-b33BQ0(4]9U,
-@F-3;-ZOSe_APd2<AN5\56A^)U5gc:VOMQT@ZdOD<Cb:<A4ZZ]8).Z<#0Bf(HZ^
Y(0b7@D606Q:SJ[?ba]Y_2NGdbZP2=ROZ\T+3_a9NC((C.2(<Vb(K>_-DO33M,P]
3>>0A,gC2(g4N<#Xcd:YTd7;5+_:bfLF.;(PeBQLEa4KA<W/@SbJC9>?K4U61RPH
_G2;CTNb.eE@YVJd?)2>(]RF;QRDSNMCY+1G:d9b\PeLPNcb.&7IZ:Q&CXL6@PE7
#B)UNHRX4C3SD+C/GO/<J9J/TS[W)=>\BA)ESCZ]C9:B+M/);^d11M&[18_)K(V;
3-=TfOR@PW:d-21]6UG;5K&(#FR,M2.U0O>/dFG1//&::dV&K8-N@>4>ZI>J?ZDJ
^)DB^&P#(6\A8]DR9JE,)G76eZ#;_7JTK#/]^&G9Z7GM&BA-,58Z:1+aXAL?BJZ2
P;09fZ96MU\1cfCZ2?8E8AW#ITED]^H[64J[/cI/_F+ZGXgMNDM#,;9ZO0<Q29)L
b:LYe:[C/C^F_]-<>8+6&(4]O@ASg@LB0ZW)DPcdG5f->-TE[BFK6TH72J;8J#CP
S]X,GcA1.MDWA/(,2T/CJ.Kb71P-L;\1BG3WZ^3HWN(J&<N(A(2H&\\VB,7YWQS:
LY[7_>U4\390eZ,+EAW6I1A5AaYCIM=?d;dX-F11B?2JJ/09c#S-C7_dL.JH/=8F
D/O-7PIaM]/6b,32/F\4)69b-(:a-EFI4L0LA.GPIDDWcO0a00(8_=-cZN5\U@?J
SZMSLF^_B:,d_[14C68PT0Bf@U.f_gTbX/IJG:6R_;Y:UR22^M=/D8QP^;<2[CTf
X@8dT,REZH/eK:]4SD\2M#KI1V0Y7.Gb[cF/OU^eKN;G;1Q-.F.0@.<X2XZJ-\E_
?;P3RW##f,59T3fQ8:Qcg>BVPPEH6B]A5eGBKM<e::dB@NVNJINd3GORO-4.<GMX
?#]Gba]T?=4M/H)=(UPg1C;F(28O>,\:P&GO63^_cQ8e^;W&S>b=Y:SU(fgS[d&J
9G,1cWd<,;9,</5aST&.V[>_(FNcHKdQI]#Ka=MTF+/A_3:S6f]4/g&fRAe25)?c
11>O;W3Z.382+aOAVJ2]PbL[Vg>Q?LAJ#X=gC/e=>Gf)T7IYaO/M-Z&YN=FM6^.8
J/-EY?T[BF,Pa&0T<Z]P4H^B&ZH1c4UJST(L6A,K(2^K6,G:DB(V[TU:_?ORd@+(
C0Gb#f^K5DJ[,9NK61EK_/3R2C&d.c;>8#@I#&[^/SP2A/VA1@_Q0e\2YZDII:X+
B@9/LT<1>&^6>@gD==>Oc3[][A5.Y1f<]Eg[0>/_3W<HXcJ&4/3>#^cFUT5=IIdc
HJZ93LM5-G+c&7/EB7RZ?JfA(?>f#XBg;67X-b9ZAT+]&5IB3c>XY9<KaDMcP;V:
7)Ge>2L2^N#6A/W4^A;BP)=OW4G:W;.L]N/1RA+K,Q,07-Fff_H#\fM]GD,HQR,g
8Le-N]#JTP.T[LB=Q_K_PeXA(Q6?3Y#0VX/aEWeaSg2^,\:2ML:Jc=U/cP[?4C.9
8/,D\I</RV&W>Z#<I(d6aOZ&.D,4gROYfK2VAV;3,?N@WdT-M\^#0N56=&+EGb<e
YHGH^1LI#&V(??N=dQCf[8C0K\]R3#Hg3(FYG&/^E/X,OG1?=H<3:NEbG&N45<^N
2T2722VW#FdJc>R_@RP)U;>F+:g@=eW>#GNN,KVMH]IEIDf?K]CS+=/D-XK-U94L
#(_F=;4H1B>:fNSR-9NLI)(a_:0\L-ZA_?3<OG+c6f]aS:<2DaDE2<ZD4)P>TG(I
>H2TU>,7-(DD+<0PEVCE(NM@eM=XBV.4[_eW7]VCO+g&Z<FN/,TTX++F231JLR,)
KRD)-MZ]C3e>9^-]S-dg(HP+M7C.ZJE8]?R)-b4760=QWfFgG^\GM]VAN5](9ZH@
#J-7EEIIU.2b]NcG)OGE&&XOdCU80ESH>,-T#2IL1bIGN-?_;TH?=/Le#@\7KXQA
PX\5f)Sc#ML9J.YeO[6\,77B<D>bBF2W5&;KBLc(T[(d.R@NdTG)I@G[T+-QYB[7
RUEIf+D]DKZ\4FHDS-:BRO:,Y>g5gS>U.)KCEGI(06T?fWGQ@7V7/a=?PVGQNRd=
a6@M@6=I;NM4#>#IU=-=[;D]VWL6[U/V_C&OM9T#.f?;/K<@>adQAXf-;.;Y7e<L
9JZGbM7bD=5^.D\[]>[)2&Z[B2@9SCT3a7);eSUIV@JFW.P/C[E8H^KGKdM[?:S=
E91KbJBEK(F(UbAT4aV-5.3QU(Cf@11E4&-R\A_;RBQBd-;X-4-.E@#<(J5X4)QV
cUR:#X//KI82I)-FJ9ZK#\)0DM6(SRf=O_?1POfZfcN9-E+STc_[4^R^N3S&=@<F
df-((L(_.6+^29<+M886IR)R)30TJLdAJF9:B?f@NT_+I)KJ(Ag4cU<FNV>DKDc^
P:EJ@C/OT5L\A@Q#Zee0CNYg:DQ,DW3T3/[(@:D7\)bQE[,=LG#^Ud<_fK&\8-6;
JB19QdS5#(7=JZV9S1<@-[Xf9aI)54CTAS.>_<=<8,Z[\6UCTHQL9,H1cD4b)CbJ
[c#LM7M>D&TAa);;72GO)fCJbJ?@.:G)A999V?NUJg&X0+&P:f]/GXTa5GL4(a],
;dBEC)g5P[/YP73;<^+M]78IdG[(D\()USf.OA>]7FfY2UfAU15Y];Bfb2N7J(JC
JG0b&cX1.72P+fa[F+Cc1/X)c/>E33_&IJ\IXD@UG:eR<4DPfH2c06)J:LeC]b<K
:fcW.OW([?XG_]H=gXebAMQ5>+dOV[NggK]YY:]6/,^^6#;DA\7f9L8(-X<U(I)c
2HJFgX73aJX/30:FHG7C&]G@93G]P7M./^7I2CfT-6ca2)5(,.0>gCaDD4E357JX
6>X<J^D2VV;+[dT3B#OD&12.LD3Ac50O.KZg)JbQ)RdGVHFE&=.QXT?(P/JV)()S
HAg<(Of@M\08PDGcA\T8TM-C)NHC4C^_BO5GS]Lc=2I.52.LGE6[CA_//Cb#IEXU
YXM+IM0(JY?EgHO<QHfK/fAUMaN<6._gF-KD1,4QBTEEE_98:2e>&HAIY6-d>a_2
VL@^XMA14T8[J65ZE#B;aN.>@+>Fb9_Z??F54RN/.O0+@-Rg+9E;0A/HP1CNV=):
4(e?)K[DOc80(FS)@(([^I,IH[0(XUKNO^R(a.END897HB>b\g[-ZUF\3d)826bO
R6GRA(074#HM<D;.b30a7PPT>9EQ-P/77&1XDB_MQ0Z5&O.P1)g/[1@B@?[eOBP5
&OfUX[HGP.@\fIc;D.d5K3Sff<@#++FGa&712^6[QK^eJd^_AN^QTSR_Q>=PAI_/
?3:U-<DJg&Z?gP.K9?Q81H\MR:\V<D>(O]aZ[)H/V-UC@S_OTdd^.KJQfEHZ49&W
RP85g</a^>S12U.-R@;3G:;R+5IX]K^SPULPP:Z7X4dKK?G:K)U;)7AP+]>,AIf&
@#D^0L,7[HfZ>YQ?c;)[>E4TCfGc&b9]I#6_c78,/JeXC15J/HY?:[AWA^/PIO>V
;?0>M8,7feMUS1=-5:,(RBE>,JIc/A>/>.#FfUKU@?),d\T/F2S7gag^-]Q-Q1H8
C<4aQ4?H[VZfMK?SE:B\2P6..\ZdVQ337]b:AKYc:e<Gf2d58SQbKTa[XgJ_F^W@
_Qg(.)-GQFO:VV]&aU/a^D11YKPb-#B@22U4Y(B3M@=;7.>#,5S<Me,\0bbPTRd:
FZ6+^/U9b?+FQAW<[>[5ZJ[)OF@7T,O]LLV?JJ3e1\>Td,_Q>87GaG-?ZYSOF^<4
MCQDgD[,@.8U_.1DOW1YY]-OCMB9/:,7ED9P^K4Q\Q9dA5D36@cUFZ-[P4X)b,BT
0\UbO4.g&LP78OKbJ3XO19fXY?#(0c&&?HcfJ0]/E+U?H]AJ^KC(G,d^:,?6LM;?
ZT>2803f6#2/cHOVa\HA;)U/5.][<Q_?Z;P9@1OHPUB^LcHL84D@NIE?IK;Kf->E
9_9_cWA,a,J=T3?42(92b.P(c?FYfX;+d[F6(+E/X:YFD8I)0>6\@I5:-9Z<1#T5
EZ&BQ2D<&SPEg>6NW2fK<1SVXga6J1<fBdfBG7g8(7>T2(4_^gUI1G)g)3XW-1gU
4PPKa]-R&(C@IV&K(5#K(S-U91HV4(K[7LRB?=:XcY;H.gHbeD(eT;5+fCH2^cV\
/Y])g0]aAWgDSCCORF71JBRK)_.JTP#c-DYWOF&@Ta9Z8=AZ+/:+1GEfdOb)&Y@#
;@Q6R??=\VNV@ceg;fUC^L6?LAMDW&eD?:d<)2YE=EZ>6DQB;HcM\IB@#3@TPBM/
?=+.#J;ZNV4fG#KU<K>IFeB[FKO_0FT1TZZ[1I1N0Y;9bD#A88797)<1@3U\TZQ6
eI9f5S0?(a--<&(9LH3d.H6I]Df636X<,<AMb,@8GMLaWR3eZeQV5C<S+EJ<@^J_
(,.e4L^?,4CWcWbfPfO2(V=E@KgZ=c6I9V:6/>a5\30G?NRW)RAS?2;^+;b@=]cS
Re)N:Z_Vagg0OP<LE#PGbRIFDN.(A,5-H(?GfL>V<>fF-ZTEce\28J(?>+N&\7UM
SX-_cXYVF[S,T?1?3IO?76U^aIKQ#V,FCdg.:1Y)7?.Ef-F4>.3LBd2Qe1dRN#d,
;&^P>7,4a9):/4eF.PZF>04L+7(\_gT&O.b88AL[_QL7HE51+WW&OQg7LYT?2edM
<D:RSAUW+/@JC2+Mgb@ZP8J_:<->9<\EXJ8D)8^S<ZVKf03RC;3C3aN+2ad&&Gb0
T9]eXIZF0/X\e/_g60T26E:GfR8L+SQ&GY#3YEISGcReI_YIe[RC8R91UJ<Pg#@+
:5FVEGUf@gZ<0SY&&eUL@L71_5D[eMM#:E,8dL?\Y..T9;^2+LLWW<]BbZ<7RGSN
LfWW12D.@Kcbg9Ve1R5]?M(<ISXef+C&23P)4..)S#6E[]&K\4QJ@cPZ]^FLTd0G
-IMS]7eAL]9f[KLX6@&/RRX[MO?U^1U=LX2d#^H>HAaG=eJYN11\UA;@8^NQWJV0
H<HN+AFA=:69^#c5:DGR&AJ/X4cN(WDB:Va-C6[Q7eY9d[\Bf<dNe.D^N^4\WVaF
KY=GT#C]YVb5X[SBdT/1EO8O&V,UPL-2RT44Hd^gB<))>Q<]I(U,[NB9G7&A#N8D
B.R>&4d2JBBJ^+M0TfD-X?Za0D#V+\+GAY06@>,T4OEWN#M3dI<]]fAN:_]G/(R?
ZDJV6Sd8[L_=aWZ^D3^c@f=H4fQPPP@I:LdTMSIQeG[Ef+5F^.9&7L\@YD&gN5#3
b?9\1?ba(beTV-\]>03YWY:24g38IR#gL[1CI#270P_2XA#FL_#:d;<cCg8DJ/Gc
YW[g+FE8KG8+DDM)Y)2C<(ZG]KD7U-:J-YR#cG\DDAH#V9V]BK(B+0P>PY0\;]Lf
=7-da=J\_P/(YD:W9A]dXa^I=6b3Q(\<AS:70E&fg7C2:N@e.-RJ<8[@7fS2E3Ma
Lfbc[3,1f)C5_.9Q70NSMTNF.&K(XLH2@[7]FSK?0V.bL[E&RJ6+e.L=.Cf#-ePW
2RI=ITbI=TK6gBWDeE_BCJ@GcVBV)-8.[e-Qb6aGM<,OJ:3?(MQ5MDDaT0>Q=Le&
OYC^\NK/47[I66d5U@E+O)&^d5G/0a:F,O439GL75B0E#ag;d@Y6F._@bL@B__+2
=[gQMX@QZdDP0KTD9X,G86RT>ARA?,/?H]/PHV+SD=[9bK7A[^HXF]CTDd#T;-:g
T/.]+g;5INM9Na2ee\3P_7=?8@EQf@3/66dHHC+dAF2gDe5#TFAONFKL3Ad5d(C^
0V^DES.[MJ63I^7ZETc,PJGeUJeXR.@-],\46e0,;1GA5c98DU+IM8a2L.RL&5R8
K4E?Zg\Gg[[H=.[;V:\PE_g\?2_g;F@VQ@<)A15NNP^LXP?82U7ZR\CK:I),>G#\
F1#G.>DO3IT+2^X@JbJa[Ug?A2S1M3YDDZREOZ@)3Ze5cD-VS8N,J^X7^9?1VZ>^
]WXQ-.XfF^@07:SL>_fe35#4eIF=[XO]#^7TH;5OGb@9-@XK#^5NJU3_-_>EbWg1
+=@cIb<?;GLI2,)E.+Ye2&F@7fJ0#(9JPM,c(XaVT#,HgSVN3;J(&;dNM64(WJT>
+Z>HR+U1e?-gG[4T#3A83fVC/O>C.4>P[5bYG<_>-.01<QTRcRfRU_ZF?6Ha&DbH
&>O&:?#d=4E8;UY>ecOb<:EDI[A&[LA_:/ZM0.G35R\[QS20H-S3\_I\Y]MC5J9)
<?&7e8#1>1OD<(M_?gR1+39C4:RENgC=HY3#0BQFO1Z0YC5,4DK85Vf+SM/92I91
]#E]3>B?6V2\I=UE0Of\FG53E;C\C7-S,#ZVO=[_KD5=K&+H>)G+RO&Q3d+/G/Q@
4Ug+61I_E&PQ15.gac[^d0abT-a.R,U&O?<QB;W8V>cY\eT.]J?KC:Z^FMf4H+&4
04A<d3Da4a;<>aU.X;@F[7DOQ1\dSSAc<BDJ@8Y/;\OT8+W/O,b#_WE^aA&8;5[9
FM_+c:Jd?E?\UGNOI.2):3QTaK/83<d5\7U2HcLg8+DZORS@YA)b[ZN[PT3&g_N,
455/GL1[\_2PO=BJCW9Fg7V7U4df;D.>?JTGdMfa_bX;=.<D\A_?\.)^]<B.L#&(
]_SR7,[:fS+e>^=4cU=RfCN5+O[SSHQY<@G@K3O?Q_P83--LBd;^X<7I>a(WK)1a
5:(8714,_,;R;J-,2@(9,a95[e]IcT=KcFD..(\-=3[<L:A-Y\f+<(<9,;X>-dc=
WP+Q^2UF?>ZXBU_LK)LO[9GIg8CI?8^Q/9<1;:eY4?RG2dU7BPRS:d6J(0He(=F(
G?bXL+37]@PH-D4BfG?R9]9dV:L@-I=V4O6JJ/X6LTI&+]NMC4@ED1b#U_Fg<UV3
/AF.21ETVYO&)4-=_Z#[OFJ5><Q]07,JdX?bIFO=,&Q=^BGgNa#LP=W=MVICbH+=
?+CSBF3a3HX6T-I[S)a#e.XB;CeCaKZO9=eQCPFF8-&SVZFNM.1C?;RM#3a1&ZI7
-SJCOQJIX47b);=9Q?+4;\gXaUU?-6fA+5SXQX]0Jed=^-5V2Rb\1>#UabN[A@N8
=bY3<(5RQcBYO0TFV42Z4DKY\-W@Z+^JV^1CbM)cYQTTaK:#+].-:])g4[@#TdC5
9Uc3EWER^1+FdM>aR7]G3@;[g((0[@b7+Vf-0D5_VC9dM;AYBC?,];KJ8T@SRPf.
EHB:<a.#[N[J63#_HD8[Tc,W:_d0Hg>Q&fYV\B._6@YH;@-7]0)(WV0eMZ[;M6fS
_S0a/IYRfEQW8cAU[2)+MQ,M9d5.61:&AON6[\.55YU.@_],V^]YRC#(J9^B7MC&
4&be\D+>^2.OEde0EWP3;9UDVXDVe+G_-3Yf?S7:>K3NaJA,YA4N5M&<2)7E;B[T
E?0=UEF)Ve;EJR(5)EFW[0VSOM5T;;fPBR2c[V37WI^M0T@_SX)Nb.P.D]2>.ZKC
fT=W)696I3(\GO8\F7R#L>S0NVNKL7f.fG:_VU#Z3@#6;-./T.:XaW>-Z>6)NNZc
\Xe4]Q_X[T>SB?TG2-4GH>RP74)DfWU].K9W:JEP=5()#7ObNC@cJRL[C\XQg\Q3
H9U[JU#@RF;<0?RVf@(D1+M\eD/-AV/2IUDSf_;E:RQ-/e;N[,/:0fAQ:ST3N;..
BQT(RMAXA_\QXK<+4+/FQF]K?eRWG]F4;DV;W(G3WJ+J5S&EQDZcgOEPbf<RG?=R
19bECE<CFJ:=,E=d]<&MJ8ECVWcUH)TN\_FF-;8E+R(=K(=[&2g9D-X#,#e6?)<b
9NF(G3D-CZ:QT-;9>fWA7]YXTHe8(JI@@cfEXZVHU;eE_U^A2<dB2>(Z^(MgX,&U
(.?PC)bXQe1-R&YBLaUX^3I]#gRFWI3cFcIA3,;1>OL:bI1Og3MT4W(Z/Zd4_57N
aNX#QHaf&YB^A:S<>(XdDd>TFZ@QR]P4IUD7&LIV<F.GX.=Cf7KP7=0QX?d8Ae81
Hdc3<)K/OXKTA#R,KZW[,D7<Pfd)F9B8=#,0BdS^RE2E=:Ec3UX/-1?3GI8X]GY/
<dY9b_3_V;541.@7\7W94TG7N[&Z/9gH](A<J^0T_A3&A0-+\,?,4[:F[SK&;31]
W&fQ]8]Q0CS,:C<4WW;0R?4b@2C/[-:CYg/adW-9;L/XXR?M+X@;]Df8U(:=O=fZ
4.OU,SWefHKNCWGK&1:.VWR,4Te/YP^WZN,ZG+2abNQg/?>B^_dD,FT>SID]&V^K
?DHJD-W?D2]([c-,)/dLaK?IE^Yf?gD9]7Ga-;PYd<0#9d?LNB2>BfW:&A.6./A)
4Jb0#U,>ScLQM@a5]?&74I=B#[G;PD]B,@_(bVZXg]RG)cZ]<DA6LeHa6Q5=A>eR
8=1AO7\NBUA\N7.P.D)^)P(=^5^MH#O[6HXW7/,+59gIN;ZZ;8bD96CY]J+=::+T
LYR@LQYT1_:^&:/7FCNRC]KR&Y#CONR2[0^N74OIP32cB((=MR5V(MB@++d3a^Nf
K68=egX#.-T=NULd4E5#NOASZK=<WQ,+JVJ7&5HY:PI9Z<Ba;B1Q\JR\UOEWCZ(R
f5I.fdK=UKOAHb0V,L]@cQ?__a1JC,L&)?Zb;O)).M,0&D_HL.T7W&W@=fML<)=E
+-#MF7YDI)a?#cbZ0Ted,3Vg<c-5)(PR+=HcfAbOG7)=[CY)&N\>G9^NbUR^#aX2
\N84)_[74)ES=)W=O5Xe#/[>AJF<K3UQ5;:;V>/YT;-O/DXC:C4(03U1GW+++8;R
(^bN_R\T@8^N,9g]?VRG0<8=<ReUC:+eIgf6.HGPXgM)bXP#.I5Me=8A_-U-;Ng#
S-Xa\PZ[^;[I]:J2QAGFQ;-E\<0-FVN;H:VN+KaLMc(),R\W(##G)0\O7IaFMH9G
K=f0/?g,aA3SSN5X1Sd\K\TZcG@dgf1MN3_KK)CH?A78^C2JN1+(/(8[g+4]4cYR
4&3-6/:(.9Hc@VTcCcVLR2^EJQ+,eT+fU_A7:FC^C^N.\ZQF<<VXBKA^f7QIHc=K
PN+]Z0a2/_U)^cfacHPQ[SOP6AP^KA5_KC4LF\CU;L:4H[>P&V2?O9,PV,Pd4_JN
=FP<78M8G68))@VaXSO)d<P(S,(cbU&XV5PD\Q^&-O&);0@a=,6dgWMDCg,:5,M&
@WY5a>=^(HN^Z@Y2#LXb-OfB,KX0IV,C,<?2gP\NP@>P<8701Y@OEUY7EcU4B\(P
SS_A(;d2[QQ?=1I=_E1P^^Y&397cSC(H#PDPU..#X1&[B?IDegE48de,L[V8=VT1
<F<d7T:#]EU@NBD4ZLQ+SfF:JHM\FI^ERc&WLAN2cgS.N-c>Db:cEVJ0QBEK=I+9
_L7-c50+af7&KD&EeZ@XW7LN49N(]>^6O9T\[P[C@#7U#.W8GOYIc2.))WCDPg]5
RBD&GDQTEe8aRI/<]?c;_#8Z@9_R6T9[L]IeF7=M2\(ULN)D\]DMZ/21\X+OWYX3
QQfF=IeA:7U0C3a-8#=3?2aV03\L]VT]C_(BHL?Q9X8\Ad)R2gVMRcMUURRNd=2e
QU@4Y9-TA-2[#RMM8af<L\@b>;?H5ZY-^D-8Q^,UT(=;=\19V9;D6a)KGLQW#L3_
:6S>\J(4)#HbG5f>+DZ72R39fDBG12DS5EgD7[c1D]dR.U/OG7<[=LGOQX?>_A;/
E]EdLZX0@#<MJUW^HIG\C8M2O17EDEJ/cgf?]M.:JTeNV,UA][1c3Fdee;d0bQg#
bX8OZ8E.I1_aZ.dKC:E8L+HX:BYbXV7<^U1d=4;9Y7fXWG<3Q4;_U6UY;.7I[J(g
K23TOf-]fL5\<;AQG>]@P^E:a6\7M/_\@\T+I53]?.LN,1[]PRb@KN_IU4,b[+Cf
/=4,E.&DM(g4/f[ZX9[&-/@NH,512_eH=bEW^:0J4GA5=WaH)H+/Q0X/DP+D08<X
UL]d2KcN#YQ25XO7=T\BJ#CRLW.2=.Z.V7>d[O]T2@0><O3aJ>)Z,T&ESZUE\)FA
L:NGBWI#QFGQI)eS>Y,e\<f-/JJfUR()ga,=SW73O6P;?N;?P<@eM,STd(1^/JB\
f)HI+b<V:f0+C&gfOW,-LTTgYI2cYYW(<a03=[ZGFQB8GHXeHAd+Ma]8TdOZ^A,C
;5V#TC]Z=Q8ZMa(-#B0-Oe?+aO72SE3?C.S>&XB4^\8JLR,cPWOMD^#:A>g&dAfU
bP&R&=(^^MM0=0TLT6cIP&9_RdOICc7gZa0<49eR-ZQa0b?2H2J;=;I13F92e/;;
(6WJK0(UP>&PMG0:Z8S\GLbR[V4ZWCMI,&\PPRMPg#X7HT5d?WSQ#TCGUbgc;7;9
W\/6).@>5KUZM:,/;VQ6J=5^,<XIg/R-K?Z=,#7BIMUbL>@/.7K><C.+;5c?,1?#
N8LQe0fE&?6.=fZX58UG-gH5@=T2N,OGL+Ze]QKUSX+e_[MW9d8.-d&E:+19509)
-&SeHa1&#O1VEW5bb:?S[c\&RMGTU0^]>5:N<]KAFV#FC0gc_6c2aQ4g\KS+YA.I
9X7TMK3=_N4f4<@U>5ANWXN:2)MZACBG^a/GJ?L17&Gd,b<4(<C8<&g92YY.dbg/
12&.BO&<;>>O/M:>H/>OB)/=,6R],W=3S.4@Z&INF\M3Q^)Q7\fJVIN/aUKT:f#L
69IT23Q?IHRJRd_<VSW?GdEe1g+PH.(MG)39K3\>\AgRMFD:a]0dDCf,+Cc>NESD
BQR@,]c327f_Y&>I#M@M5LBX0)0#<TE.K,.B57EW<(Q0+:#J-_1Jd:,=,]=#7Fc.
F7J(BeVU/U1c&[[SdbB1<SH[^,B+Pg,)KRM8a7gK#=FCWED7(IM=7,9YH<ORc5<7
+&f0?__GY53?+>U(V+2/=6OF3K[QH)W8H4@bQLQbgGN3cRgZeRe6Cf_F\#7(_X0\
LY7PPZdS::_?^,;eD+ZV)1QM2\,Ke#9>O:#B0QPCgU,VI(EXJ.&-_QT8)[=gA#dA
A(W4^,a.CO<=7M&#@6+[#5#@0J1dY9].6R>]bFQQR?TEW/1@@NZc1S?f>E8OV^:/
B8]=#/9XFLO<>=S+Q-MdOT<[54FMQ5OQP0abZ6ZWE\)S<N4\ReF@?LXF,dAK[PWR
OIM=Xda+#?[IE\S(7=MZSXc8.KB_+WVcgUK\=Z,GM.KXT=BB?GVgfWK09d+)\B+T
La-WaHOKIOGe:RERLOXfSK_@cX3<E24c2K_=M+_@LVH^RF3ddg46VE?DT7+RP^JI
&N:?+]3LA3MKTa[1_a3[bLIW#XS:V+GLMH<YAVR^/=YBdS.6=dM)(W#9^M&E\FWW
W>fHD@0)]U.G1J8U#78V:_A^[gZXGa-#Jb1OBgM?bLUL&\9C4#^[#-([_FY48+/B
KJ2-_2L<=J/T?]GadC6N4JCBaF,c.FATGb8+=d+)&LS9Eg.R[1ebe[Vd],DcXHcH
IQ<L>T+M]O?3&@--YBB)U@7PVSFT:a>CQXF6_PdQJ&c]LX2BHN\2;e?<(PKNN5^#
2KMf]=Mg_B:S>]:DX=YO\N]?>73a\#JYIbc\Z0fE0Kc+=Da92dE0818IOd)HZ-2;
D0</BLU7,>6Q_Z9[\R=WZ?9Q4QNf]3aP\][16ZQRfRWZL1>IWJPY>&Q<>)\#DJT4
6^1U?1b1(.M>HJ56ScbKGI=L1I[g(/OFA19+5DJ\cDY^_\>N_(e3<:DK)QGR&1D;
Z/:D&KfZP_B.10+?\NKM/E<<O)+1:)41&CCNX0/?afa66B#L/O]NQ,T_=QVg1MQ8
H0(PYPZ7?/U&#MZ;e]W2D/AgU&OX#F_Z8#a-+.OX)KG05IC5f=2QbA\I@S+>f:)F
e6@(<>RD@XLE]-TIa]AGCV#H+A658f>>2;>V3[I)YcKf9SdQ<X+DdRB;f\V,2R0+
e&>OgP:;/UUBda9Z[,;B.\5;[eVGH>eENXIDA=e)[agI@?O,@12PBZFS5&G)cK5W
UDHS-RXKgf,g\&^73KQ.F,B^8GaM]?1a/eEaPNg_275Ra\d;/;B9d@=[X3>JC5_2
_@8YNa>gAA1R?9Ob08,;76NL-?@K+.<YB=QN3M.g2IBOE^B8UMV_3KdF;Ic&L.Z8
,_TOR:X?XbFNAJ23I#[OQHW#W2E]_R,P_EgaL#:?e]TWg=CQ1;b#9T[6BA/C:==.
EK]Q+(aT,Z8N/$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_ADDR_RANGE_SV
