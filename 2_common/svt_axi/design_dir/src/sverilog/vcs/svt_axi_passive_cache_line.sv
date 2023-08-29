
`ifndef GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
`define GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV

`include "svt_axi_common_defines.svi"

/** @cond PRIVATE */
// ======================================================================
/**
 * This class is used to represent a single cache line.
 * It is intended to be used to create a sparse array of stored cache line data,
 * with each element of the array representing a full cache line in the cache.
 * The object is initilized with, and stores the information about the index,
 * the address associated with this cache line, the corresponding data and the 
 * status of the cache line.
 */
class svt_axi_passive_cache_line ; //extends svt_axi_cache_line;

  /** typedef for data properties */
  typedef bit [7:0] data_t;

  /** typedef for address properties */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH - 1:0] addr_t;

  /** enum type for passive cache state */
  typedef enum { 
      UC       = 0,
      SC       = 1, 
      UD       = 2, 
      SD       = 3, 
      UCUD     = 4, 
      SCSD     = 5, 
      UCSCUDSD = 6,
      INVALID  = 7
  } passive_state_enum;

  /** Identifies the index corresponding to this cache line */
  local int index;
  
  /** The width of each cache line in bits */
  local int cache_line_size = 32;

  /** Identifies the address assoicated with this cache line. */
  local addr_t addr;

  /** The data word stored in this cache line. */
  local data_t data[];

  /** 
   *  Dirty flag corresponding to each data byte is stored in this array. 
   *  Purpose of this flag is to indicate which bytes in the cache-line were
   *  written into and made dirty.
   */
  local bit       dirty_byte[];

  /** 
    * In passive mode exact state of a cacheline is not always measurable or observable
    * This can be inferred from a coherent event i.e. coherent transaction receiving 
    * response from interconnect or snoop response received from the snooped master for
    * a specific snoop request from interconnect. However, in some cases a response may
    * not have enough information to infer exact state of the cacheline. Instead, possible
    * legal states of the cacheline is inferred from those events.
    * 
    * Due to this reason a passive cache needs more number of states to describe coherency
    * status of a cacheline. 
    * UC, SC, UD, SD are defined non-ambiguous states and all other states represent 
    * ambiguousness of present state of the cacheline.
    *
    * NOTE: currently passive cache supports only expected or recommended states of AMBA
    * AXI_ACE specification.
    */
  local passive_state_enum state;

  /** indicates age of current cacheline in terms of its most recent access */
  local longint unsigned age;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log log = new ( "svt_axi_passive_cache_line", "class" );
`elsif SVT_UVM_TECHNOLOGY
  uvm_report_object reporter = new ( "svt_axi_passive_cache_line" );
`else
  ovm_report_object reporter;
`endif

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of this class.
   * 
   * @param index Identifies the index of this cache line. 
   *
   * @param addr Identifies the initial address associated with this cache line.
   *
   * @param init_data Sets the stored data to a default initial value.
   *
   * @param init_state Initiallizes current cacheline with specified cache state
   *
   */
  extern function new(
                     `ifdef SVT_VMM_TECHNOLOGY
                      vmm_log log,
                      `endif
                      int index,
                      int cache_line_size,
                      addr_t addr,
                      data_t init_data[] = {},
                      bit init_dirty_byte[] = {},
                      passive_state_enum init_state = UC
                     );

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored in this cacheline.
   */
  extern virtual function bit read(output data_t rdata[]);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data to be stored in this cache line.
   *
   * @param addr The address associated with this cache line.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data corresponding to
   * that bit position. This enables partial writes into a cache line
   * 
   */
  extern virtual function bit write(data_t data[],
                                    addr_t addr,
                                    bit byteen[] 
                                    );

  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function void set_status(passive_state_enum new_state);
  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function passive_state_enum get_status();
  // --------------------------------------------------------------------
  /** Overwrites the dirty byte flags stored in this cacheline with the value passed by user */
  extern virtual function bit set_dirty_byte_flags(input bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
    * Overwrites all the the dirty byte flags stored in this cacheline with
    * the same value passed in argument.
    */
  extern virtual function bit set_line_dirty_status(input bit dirty_flag);

  // --------------------------------------------------------------------
  /** Returns the value of the dirty byte flags stored in this cacheline.  */
  extern virtual function bit get_dirty_byte_flags(output bit dirty_byte[]);

  // --------------------------------------------------------------------
  /** Returns '1' if cache line is in dirty state */
  extern virtual function bit is_dirty();

  // --------------------------------------------------------------------
  /** Returns index corresponding to this cacheline */
  extern virtual function int get_index();

  // --------------------------------------------------------------------
  /** Returns age of this cacheline */
  extern virtual function longint unsigned get_age();

  /** Updates age for to this cacheline */
  extern virtual function void set_age(longint unsigned age);

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this cache line object to a string which reports the
   * Index, Address, Data, Shared/Dirty and Clean/Unique Status, Age and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_cache_line_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this cache line without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_cache_line_value_str(string prefix = "");

// =============================================================================
endclass
/** @endcond */

`protected
SLBAV4M.eB.0Dg^XeHc2#+LFEUeQ2Bc;-g7EB\WLYdRGFMAIaZH_,):;R8Y5\A]Z
B6TSJ])STa;7=_,=;J_MIIQRQ>-STIcH<(,X#WOTMF88)7K3Z=X&1)N;a.L5daNO
4#/Z@9J<U^E;G>8>.0+C(833\cDcL0,T?:H=G=G0D&<,,X_V?CCNJ2L.@3.gBV06
ZdXcXQT>&5F[HSCdG8,f)9YXQ0)Dac+_NQJ,,UBAM?Q3;+KRY2]Q?9,H/+D6:>3J
[NO:@=D=aX[9DX7SN8F108DY)Zd->-S65UX@VL#?DX;SJHYN0D6#ebDT-/<\.:#L
^TSg4TUCX07YUg_6&@[.V:/cX(X,09EQXA/3)G1ONX7-M(KJB>aI-XQV\4+#d:RO
K6EQ&C)FFXQ^;8-cU^USd>&Zd88Pg]AW+3711__&TH9#g/MVZX?Eg[TB:]T&F;cO
Lc.5Xa\T?8D[V,.c>29&5/=b.#aBXTTIIL66CM&PA1\;4JK9Y:0C#.FKA@cEQYe+
GT^:<MN<]:a&cg;@FU4Q+FOd0ITG7MM,B;D3U&;.K3gV<G&AI5A77TcPD=RDe6)1
O6LQ#d7Q6D0Z[FW[0@b/CW8,8+0@CBV-fc069G^<2?C76M+Q^5BPY,4NLLV(b9FK
=df74DBARQH[9?)[#AM@Y,gG\MPdPOT)VQAD.NQ2RW+RO#V:K^b/O5/9TD@<.3/L
TZM+FVCD99e:R>F\+Pa1?(#Ob(\33/KL57E>O56VJ]cAR&XFMDZU/O_d46_W7Jec
D:E:;YH<GL>&fH36<\F@\GK\(CF<7D?PTPK(9YC+TcNC]J2W3N6Yd81O/]WJ9YV6
0.<bNNe3>TfV3WZ<AX&Aa0,=gcJ[UB4,e7Ce</-We2K]W-\FeOI?.b\5T+FQW8HG
a:&BFcE:3^/.WE9f\g_/,9,b6bR&,e#[77,(=URZL1fW(,W)/eIEQ1R]K(Rf7M^<
Md/\YQYNN7AU^XS+A&W.a+:MAXFT^<8[S3E/YZ063YRV+3L;9W)8eF(195+AV#9[
HUOA&0.3?0ZW,DX;B]N\0MbCf;E-NXI<cESJ#)CEPX]CR)9dVM/HFC^>/&_)]+J5
[e_HNGYe@UVSggM;6AWfE#Zb&KO1TJLDS6].62D=7E9#[Zeg4:YH?^;\fQ\PJJCW
1GdRCSIAJ37POCC3WJD1B^RY.,@N71X>\T;)D^e5fR8-A[W@K[9H#KXB]WL?f68S
&9<NK,UJFH4=YRZeI4Pa7+NM?[d8dGB9Zd78aeDEO&]>6X<\BbO6(F0(PeZ\5AD:
.XT_g+X\#9e#-0&d4g3gP9R5L0WDL.1PW[HO+@H\cF5<S\1L<?TL4+AB>Ua>KL-:
LIPY5JGQ#2W:<\76-27&1HGC:;O=Pe/Z)d]6G.B@C]3Z]bGd3#SSCJg<3(VMdO3T
DR2_Z4_F?ZW@:O>5+[P2O_T?7OBYZS]8Y@f+RB6WC6G<WWbJN7K5#ZBB6bHBRP+C
W3BT;1gX.aULN^NWMeR=B=A_,B\V-/KNHIcP?B_TQ7bTRM#g:;.a[:aHU5=4SJ6>
[&[-61<dfdDRA4H4X847>38PTL=#:Fb7KbQTP2cadXK=P4&a()1+\^Nc6FCW#UdS
&d1(ZO30S+3>MD)3a,_ZPYHab>CZ7TBZI8676K/1)_EUdJ^RI^2CY9SRQ3FgKM6T
F/C8S+d#EZE6EE[Z/3<2G0+R_ORI#60Y9<e-g.XcIRYaB#K5,9]5KV?D=U+^^F\S
Z\?>B(,0V/C1H\4d;5PK=RMSO0c#1bO1@^4LEY.1d,I&(>4:L]:-46P,G5+1&K=]
ZAbbKS.ZWAK4N9a\/U>:U(J1)(SI(CWXBT#N,:7bV/?V;NG<)VDd7dKF3WEHRa#\
.8]-?>Q@(g31[4NZ:D@<d?:@>N^&N0]ULT[=&Zf9JGRF(?K):H[f;<?0TV9OegX,
bLD5Y,C.62,39)aDWV_[_WM:+N0XeYbCf.YBZ@aDQ::9cEeLV^_@XIQ+5<=.QV1G
Mcf@OI(b0Bc=)QX^McWg,OKY59f4-2FD5A@TX+<A+1IP9/95LAJDPdE:aQ:0>99Z
44O+9G9-_V-?LE3FeN-bcFV4(ID<+..AcSea5NBGV1VMbU&_Wbe[b+A7XE75@;)g
]O12QDKdW5D.b_FK-?HVUEMTB3)VSIVG98U:[OJ/Ug07@<3)PDY.L/H7a0OX-QU@
;>Z&C:DXT<[.@486>9U[c:8A,6dM5Mb)d^:gIfY#J,Z(0Q)GR0SSB\N8\,&G6(#K
FO?\3YR2&._94-;_N+CgXRSS-a3MIK8\=$
`endprotected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
_X0F8E&d\OX#[5VOCZQWSD#GL+9Z0HY+VZ([2gBP?YA\789MY+R<3(URJPH<+?c3
I1E^Vc#[0Z/YJTd(@Q2;;e>&OaWE=+H//\TT_0)=fW<C1BEf<ZGbF50PPIEA\::0
FT]1fCbXKIM.GTR=U/KN#@YOS,HeC>PBNfgfW=DKd3^fVL[,a9ZcKdfeO1HG]>g]
]1Q?6?-Y^>[6fd/D5(7ADb10AaQ@JdB8_,I^7R@T^)@31,VXfW]1)]QETK3?#I\_
Af;2X&SHSS5.b>)@eMg:Y_bF3E4@Z&NT&MbB-@QgE0<^86FU,RN[a4(Yg18gfHeg
[8_-C,\TOKd_<<MK.0;?;K21PDY.6[(\Z@R?FWI5V7X]_bLAA1IC-GW.]ID1-B-g
(5&KO1:.]Y>-7O,?]U,A/<BJ_OH90#CE(7T-N)#>b;EU+_8eR3@S7(P/.^)gDT<D
^K[7cZVHOcPK5f)=dCf)4DcN,S/T=L<ZVFWe7##0KO;fPYV7.O0.R=E^KCQCA^I=
##UG^^4g3@N_+@/B([LYX9R2#Q\E@MA>aRQ&Jb1[T?K341Oge9N4R8gg:,7&N+CL
XbD;2D>.Z)GeP>+7O3d5=,]PARW.]W?d<>,8638VLA@Z3>93^W2UPYT0N+e+HWYN
4)dYH@OJOBU]Fd=4UGaV0T.0[a[CNf.^fDOK:2G;&D?+]4<M(#6)]\,4L.+T(NH3
GS[TR)3JIZE=01BF2J&OZD#^^PdZT)9TQ#e;+=L3P^T]<0]Ad/AZO,/L?02RPRXG
.cF_>7VP:F)>Bag6&VKcSW.[\CR@J4NHY,.N)8(gc6T?\g/,KBJc/J3RLUO1&QO;
,8[<?d)64[Wa,KD[6]gWG#?W;5.;gXSa.PJ>)U&VBOcU&1_+M@SZe:D6<;\>97[8
dB17=:g?b;I6S]@>K1#a<W&,-,UW?&a#OS5N-\J)_GE^cTf.(MBZSbeU&U^FQ^gP
-\45GVA>gMSKJDg/gUG][&O3=GX0gSIIH#AfD-aL)S?-Y@=L^6KZ3I:H&NE?5]^+
V2c)W4@>4^A)N:8:MA/2WI]2;d-^91XOSTGc3-O312Y,?gW6Eaa4F1V3+AHg\F=O
T#R=^)]=M,A8WN@WP^.S_KQQ//g<]^,1I\G66HHGIYN1@#O/:X.U/WYG:6Z=Q5,\
==5<L/WRWdNP:g3Y4HPgN@)(/H<a=fKGP;[g2e5CWG#C=MV[V47d]DZ><;.66VH)
9:;b?cI885-CG4&AD11-]&J,K.1=\W6<P[EaVfe@Q<&QbAU&^JXL^eDaDLbP/8)X
_X335\gT<5W35C-(eZ3Y4RV7Z^/60gSF,IR7YYHOK42aA9H,P8,SE)0gL6#_YE:f
R0K/a5]gZ(B5;,-5EMV2P6CM&9E<#aSM2YXgEY@L]ZWT\><QcNfgF>W&c>I@N@[c
S],5)E[G-JC7gY_]XJSf^\O0@cEZ1GYUSgf;M4fRb8PCe)IBTgE;3#_D0/7Q6?Ka
L.>CL\7QT5&^Q,3>cA2&+>YTR+#:OLS^NY;d8E;c[_PCGabA/@QGS7Q&=+&RY<6/
?BA+@SQ6-Y>gS54cK\(/_[e(:Q:HYK+US1d^+K\a/2XT2<F@/M,V:4Uf5/6e^)6>
5D6g+Z]XPHZ[+6?_W5=1P29HENGCC>\QL<T(E@^XO7C,7@.NVVYDXV#ggK3YM[1Y
T#69/dcNd8/7Wg@_B?(a]0U3BgWQ2f>JTJ@D5-KMD\Kc5WbZ<;;E,FOKPb1)NME.
FV8+McUO2NWV,]TZfB<gW>A+?S8[[ZD@S&4,3&.WD;?\XVQS:9J>F,(#1ZF/+5J_
+<IW=\bg<W<@FSV3XWX\)H(/^\CKgDeIfK^L^ZE+FKH>E3Z<RYIH6.a_Se2M_:-F
OcDFHTcEa#e;G>F/(RZU-^[3KdCMP;]B02AX,VRQ(?V:fW?]e:U?P^0f9KT6XYWg
&SNBODa.HSa;&;<G]T?.2U)-#GMIQ=d.gLF8+S@5G.OcOCKSFgINRYPLg63IJ9+)
7@M2AZRAF;3>R_DbS\QCe[Z:LdJN3dE,?c.;HP#W+1D5a0_1T,&\.0gX@IKG#2M^
CbS<-7@TJS=IGDgK(?:8U(3<X#=+cO)/CRBBSZ^>PT6M9C<2@K[^Y[)[5QObX0>#
dEF,YNNcY?W;^<U5[SXQ@I#@F/(d/8ab<Pe7BTG?+(P#d^20;;.8>=I?X_d]:K&4
:&JB#T#,HKH1ZcJ1.?Z#)XS&64Z?A_EUP<Z@DPb]\bY+G;^-];&X7T--6a[[9?&=
bFLU4/XDd^AQ>6;SO6ARJ&+D&J)4O4I-aEdGJ+WTQEG7=bbAQ>B@P-Z<MZZQ0Vd<
^\DN5=a#,GY5\9XPMgebf1X]JJPA=SF@Hd_f.Ka8]c9P-gENf1-PbcK>BTRN2P_6
dYWUY+bIR?EM.b7,(;1?C_c8BTC2,U_5=DQHfEOZ:cWO@MF-^HEeD^P2&K,6\BPV
.LE6KWM&P@D;E_?XQK;N7#E=4]#X6V2#bIG;a_KNKOR4N[B8T],LdVZH3,Z+GP==
E)XYaHY52ab.NDN=XIcc.0Vg4e_,4S1CRH=LSef2I=DW]9G?P&Q)^9<+YY\XR=K;
Hgf>5;6C9S+C7QUU-[P>>4J<.g6fF/VFYY0WF-F>B3dL72)C+>7;_H>(-8gL[P&W
-P\.V9bZ9,e0W[<9@5M]@95G-6#YH\G\R@V/KaTA_5c=[H,bDePA?THT:U_70K>Y
7(E.,S8FcCO-fTD#gU[6G)JcO(MVE?ZRPMM?3,3YHOIXEV0>6fF<b)JcbA/A,R3#
baD&.]I3gF+\Ib3O=(bE#ZfG5R:1,XfBaJJ4dY(?&EcEM1:(+#HD<3-CdPDGgW?O
.W2=+^DZ,LG(017N/KU;8,)aRQR2(4_\aPggcfKTDV,C)RM#aYUgM_7gPa3Yg=@g
K;I,29?J3Af16&U^<C\F>ggU/?)CWWXSU#Y?TEJ=&^;O6B/9/N=gA5DAFf[3[9+X
]PHJS-8EUWC(f^Q+G=24<(XK>;&>:@]_-G:\cF#[@d_HdQd0^MC?cF>=A-&VRGQZ
)-VdM=WHJGNEBQ#-RA3?-K@ECI[JRA0\A;7>FOQ_^V9\5V<)]fGM&b89ba5VcCJ,
_EG6^7-,7FfeIUASCVc6@M5C-C].Bd0#OdX,Ad>NGbW-\G@\Xe)+I-eDC:<C37R0
1M;7dO+CQI5?)+/+cPIX_Y,Pg>dPWT2>f+U&1+WBfQU-<Q9:M]/BIH4)DQ_Pc_33
41EO4TWC4]d>Wg-X6A?8&B].>I<2g&\=E\]&g-:7(8ZG.2MD+;:d]bfMBMe7Q-VF
#_6d1_O68:,f6IQ#H&[3)9cFCT]:,.D]^5H.0^]VWDW:@D)dHSX:&+,(=aeV(@QZ
#1@>e]e+WRWIX5TfB5;+/4K)P=913\c-7E+cg-BQfg5J&>.62WA#5OZ/[dfQd3e/
BZgV25L=gQF^-QMEfX2gG:K]^#Z0P(R\S9[?Z[#0LS^FB@,YGY,XR(:K.\T.FJCf
[Z4F8M,)/+E//AW<e;P^Z^XYIXcIA^I-fYE3e.67,OGBSP#89X>aF7^Be2_Wc9:D
8DI;_#&(Q@<:OTDS#39#SRBY(QRc/#W/)ELJ)c9D6T0^/.Lc]T/#Z=C]^6BSLE^M
X\/#PH?@:g<]QB\P;G.8KXB]^]R+_F0,^ZbG8#ST4ecI<ILGKB=@VXSL,75P9c7/
LA-H6(dMHWcbMa7LXOM<RD55BS4L(#.8\)ST,]gD?2/[[UCf?5<g__AGJ.8]G:=2
7[1c?UGTFKLNP-GG0)&_=,N)AS9JV3(/dFe6<FTX2OHabJ.,#IdPAG]\+T19JA(3
X>PcX15YOYNC:KRDAbdbF)TC^Fg,8Z]a?9S+441(TQPQRTQB)[fU7=e[TBS_)d>=
[SW4#Y\ReGL244Eg<^.f--3LaK_8g(9)/0&GY>_ea9E1S,1e593O:>d6#J\=^ZfD
F?;:F^4/4a@RJBG,#D(<aG\;WJ3Q7QFR:e^4AS):,1fGAc3ec?4&XYaY,bNfPFYV
[[bJ0=Q14\(1ZR]CWPegJ2K#VEb;Z9)<8L:[?DP:]/>\W.-bMHQJEUB@<)\0HE<,
7-CG>cD]XeDcPF?Sb=60BK,VMX64Jc8]@@79N_?V4^G\&R3O?<+<I/d/OFA1RLgA
R&-_8aILEfT[^eXC[QY<@K4f9ER4(.e0gUSDWa8gV>S2.=-EGUOPSFdc_Rfe]K_6
Q=^E^=L<)fDT0,(R&8R-.7[N=M1fZ+E_52GYSYNS>]^T780(:c(N##QfB:,AEV<H
,S20W?[bEBAP6K,5T2]B(T?:ILT,[a+-^1?I1CFN7&J5_?K/=4._a-N:M-4F3[83
g;V/eJOe_8,dYOD&?1,@/f3M(2bSTRRTaJQV?I;e?XI_&J42DH[-(NVY5@L#gK8(
FS;2,CQ8W&cGHe[cTN)HIb/F>1&(#>eCZLV5V0FdWT:K\gLMMX[4^eSPNIECTHFG
6@9Tb=</399?(IRL47fa(/,,8YM(bLDd^e:I4YIM_0ccdT>.P[9R=+HcEOE)I]D1
W6af5g@WDMc9X)Oe8,R.>D;DAF6aOGD_FedP1H/1TC>eJK4Bc0/J-^IB:a,XX3DL
cgDWeV^Q&&fK((c,L5([\IBBWd7T^9=DGX)+2YK3efAF.#=R:EgZ&F=EFCBg+PYS
<X:/9H>X3<7+b<STXO;K@Q-KYP<aPL>Z1,f^@UDDF4Bb)I9:8T&(E,5D=G7MV[@a
<cBYg2+J6FSJCVeW(>]_d1/XOSe;dIB9@5R(_JLO=L.W#:(3G?[I[31CdH7-g:B?
Y45O4U_8a\[5D4d9E@FNbCCW/@F[edfQF/GSfV=0g@Q(a,RUL22?\@06c.G50X68
ISeRBQI0?_&.-G/&.@bAf>H(Y2dQC#TRTD.E-bL+/BSF42>1J^D3g-c?-MW@]5-9
FMJc>XYER]X:8#R.\T2YG.]VbZ\2<(@1c2HY4d1c&)^&d4R;6DYQ9-.4B_.bF6Lf
RbYc2V_\96:GAc\5X,53NC3FN-UZPP&_\CJ4I(H_7(U\KcH4-;:b]K&Ma1_\QP,C
YD+37[#52LR/44XEa,-^A4Z@QF1EDHD5Mc]:.]L<4Ff:X0=e:;6OOc#^Y3AUAZKB
2H1B_\a\&3\MMN\cDTd-Kfd6##9_-Q>WFJ+\D:M0+HF)Z>Se99Z7cU4V?1EORAbd
#I,B_;7T):\A):aXg?OV,Ec6G?E7S3J61IL)8F\DN<\9/ZfCAAH+4V-.+/R]F;XT
/225NS)_QQ^9S6VCPHGFM5dfDDEM21GaVA?8AaM7gfC7N0fgN3?4Ac[T(_G]_/]6
ODg#P.@?XcEO):&5\Y)HZ&RR\O?[E-?KKVFC(d-c;6bQK7bWDb3PV-33^cF6_-R&
ae4RB?W_JZ-US;a#VUUMdR?-Jd2#\>(^QP@;AGV1_gF__/J2)VCVH4Sac>e;d@4d
JA?S,-WI;.YVJbD8F7f+Ec1f-gd,91,Q4<QC3g874aWCF3:LX._Mb2J5&d#@(_1H
HWTQ:d47_4+#U=FMVZE[cN6W0_>+S/bNH^eLY^CDA2D+1F-M190/;#0KTS3B3NP>
K.4.:XY-b_^U>1[D=84FJaYRK4UCU376J8c++P-A;X-_-LG1f?[I-C1b0:@N/KF^
HUT[DH8<\2C);Y;BN4V_8F[26D8TX<FX3;G0F[@JAdV>9L?Wa_7Z,,S>0J2CM>35
Y_-C+)N.7C=QYHPF@#WJX]?DARdKAJ/#,.ObOCgdIW&.FbCV2,0gdU]-UN6.AJ;F
J-VeIP(L8E-T>.]-,U(QNG6>-Waf-@[WfA<R[A4;-NR3VdNdC#)e.W:R@9K3:7fb
0I2W-5(Pg2^.1</5]2_#RRDbaW=>M/_8XSfTF52gaGTYBH5Z?FGg^^:RJ$
`endprotected


`endif // GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
