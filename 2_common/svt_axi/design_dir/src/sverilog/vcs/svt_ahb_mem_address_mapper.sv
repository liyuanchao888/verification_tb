
`ifndef GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_ahb_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed slave configuration if provided on the constructor */
  svt_ahb_slave_configuration slave_cfg;

  /** Strongly typed master configuration if provided on the constructor */
  svt_ahb_master_configuration master_cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_address_mapper class.
   *
   * @param size Size of the address range (must be set to the size of the address
   *   space for this component)
   *
   * @param cfg Configuration object associated with the component for this mapper.
   * 
   * @param log||reporter Used to report messages.
   *
   * @param name Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(size_t size, svt_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided AHB configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided AHB configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

endclass
/** @endcond */

`protected
UL&L;9Dd:IXL&IAO>e]^^R)^(CaNILU>@[4#WJ_O7S8[5\+:)a+g.)E[,UAQ_K,P
:Jf26:Q@b_X?)Q.O[&;^,)N1_T.K0f?,\?M27Q-g/cO?-f9PZR)=aY5<S^7dA0N_
I6Q6f5dPd_.HeFeX5JBMH=CCNA(JU=6]^:LT)OV@E7&;3ZW?PU&Z2<P35-]CPM+Q
_bTAf+d</^:+^RG=_:9MG-9_;HQJ_S1JNJ\?A/Jbda;Gf:OIE&fe952A<0ZO&FTW
cEGG7N1PL;X#9SZNQ@MFP[/MB]<VKI;#SRPc46:]I&@Yf,&)Y;^dCQM)SeFY@Lf?
))B)Y01b[A+2])-^U.ZX4QeD<.3G0cWbU]L3e/7LE/EA5VKNR\edM>T-YCD+/#>R
QVe5-dFMDQ\03OT/98+5&.:IH#3(>SM3<cY7\Z=X]RF,VP)5H<2db;2-I#H84;3)
RA5ITUAbOQ@K\.P[9I#KXJG3&O8Q#NCTWBNc<]\8#b/=&gMcFFO#Z@#\CDR+bPG2
7X2F>/MfOgbD,g1a2W^6]3;OO1(7UR_SS[LW+U0VNE_ORNcZF6JR6bD[D4Dge+ZX
#AS-/;6HY03;6)E/JJLA2MHP;-HHf<A(S6.HT^6SP=f6=b?K)S1J0b;-=L83>USb
]6?e-aY1U<g)g5c02b?:JZ#NG7>L-DSQ1\3aaRS]#5W20Y3,B<>9RHfQUE^WbTO0
,4VDeC,CZNG5[#JK\&(4d?1adY=@BEQPT&=AXCa]Y(0[Be/bL&Qc;PCKESP<cTFO
3c(c2[/B[DP#HJNN^(>/(N^DIc:279=QH:>d1Cc8OYDcS4JS1BT6A#IT0\QK8gd:
c)J@1a]PR@MeeX2TEE(PAH=<YC.=^23&_P=+53FgaPLUF)(+fQcb2LMbFRE\3W&F
ZY]@B-&SL-Z#4-GK8I.:U^AD0WS3N6?(8LRbfM@JJ8/,+d[>;\L2dJ2Df5V\P:,0
E6(N_=FPE[0>7c.+.G1c_5[a1JM/>H;AB8K/2]3QQOCW@()UJRcd=Z]QJ#c]Ga3S
P-IKK7#1HUK/4A/?U>g3F1@RT?A(@,<G[&K.\2P10,YVA2BZX1QWI:G-AM/N.ER6
<W2aJXEfgCQKUe=_F<FP6]@R6$
`endprotected


//------------------------------------------------------------------------------
//vcs_vip_protect
`protected
15:0Q.3E+IV@;4?8MZ)ca>,^.EMZT#S7[R@OT;bSBc_CN4&76._?&(Y<58J=K3a@
,>TQ1#)K\?<eS1G:31EZ7B+)^G7MagUY<K5+[XHT3-KEI\#Q<YNI.df1<_9dS[+L
015).V2L8\;><20-0A(^@6PUU3P:A8d]0[S1B556_(VQI;XX#;S+5SM\B0H>d?9#
fKHb4aQ\\=MLN<CIBY(9E.2CS:D)L76(\bD2TGf9OI[G:^@\F#_c=\g&bB#D6\)]
D_)-/]2e4K3NA3QX3&QF1c^&C1c;AM-]fcIB7YL?QV:dAP3G2^GGYJS<LP)AagSN
+Gc4IT/(34;HOHefSg),I?]C;7\bH@<XDc@-]WPSYL>#DQOPF8D@J&gX&NU8gLgG
#b>K?eJ]3V/6C#cO@<)F?2f<N5Q,HY)Y[[-7[.c(WB9db=;MZA[<BDd9QX9@9L[X
MMMIM8a1YH01-f@]TZ=OP:[CF><\2Xeb,&e8]U.FSYL3\89HD3?2\KBM\4NHFXN)
#1,W9P&=&>O(N<AP(5)9S7]G:aCNAN;5fD_<35@A7LcT/XJ)PD3R/:A0:5=FZFEc
Qa.f>HZ>Q7@)XCKF]+\9_;J-3e:PFfP@15]^G7WVQ1RO_bf82H_/.];M4YecQc0E
-CILT78I69gCgQV(cV[IL@=N/gWYW8F87B&/\=1QLJW&+gOW&8IT5WI8?LQ3)146
>U+7/@7-D]<cR:^#PNbE8#/9KHKdHY(>gK));8H\_MV2DJKEbT\9&JKJ,=,E/#&a
OWYdLEQd^Y1b252V=)UTW.EBV,\Oa/ZAS:;c7ATC77X\OTe6-LZ+,W?TWgeJ)RV=
?LNJ+3I<G64?eGY+,d4eP&6)JH1Y>K2,[1Td&B?Y<SP(.QK;T32?8HC]A(^HTUcR
[E.]4g[5b5/0V+?:4<>#5FHO?dgg144@7=7Z-S?77I5?_(B:1GdEV&Z-GM(YR-K&
3XLYG:B.1ZGY&R;RM#aZ+YH0A4TRV7V8TPX74IEPO:[\X@KCMF?>b/^G;_07\S&I
+-E#/LeXWHA3cSW?^K._(^)3V5g>=#b]Xf[IKEZ0I+/c:PgVa#6E(=G::c+.O.SW
;K[#U1cYHM#4B4FO.:,B=f/]7^_N7c/,Yg<c_BYR4D[6UDL9bWM9)M7/RW1#WI9(
>Kf>d(+3US1+06+YXAKc6FAY]Ug;D-gJ>[5Z8M98IM.38F<B[BPF1=Z@C7HVSKag
@7J^<?KF#X3Z[@]T>W6@bV6S/X>+V;8,N;eZY&0&J+Kf\+2^1Q(Xb4NOBN;SBdE>
V;MLe,c^+9.e&L5WeH,A4ORKd8W_S;aCeQ>O.6F[M];,HX9bVH@S(.MNEMOH&A:I
aEa0J)1[8Af7Nc<+:UE8^[9V4.dV?53Y+]V(-1ZU@B?Sb:)bQJ=,eY.?0Xcbd.PG
=Vg,H4=I@CX-+XG8#S5e-MLXD>N1YZPfW\T]H;bO_+7c<TM38RGHPZQeaHW1d7&@
f1Vb?UE85;-WEQ5Z).cJA64GT.\J??/Z<NUQ3\:/;_dYUA.&^X8N</]f.?3.B/T_
=^FYMYBgL),aZJaLE.+L[d_B>/a/K@-C2)/-A6H=^NB-#685^YaFg7D9LD4[<eC;
4=TU[#39;_3-G^(U(V:baYOQ0/S<)(.QbTE:_KcR0.F.,3^\N\U@^WF1699XK00^
9#>7^Y.K&4a-EaX.b69)/RfJXBg-T;_^4.^4dE)6DeB3M&A_7H)I,.]PU]OJ?VAG
^X8-;PH-CX@3W/:E/EdQ9IQ19R@b9;>S2UdG[<Ib[Z^B=&NA-2<C&TAF=.0=D9WI
Y6/(X9g?b,W:5FXRLDWPP502XPfE]H7d1Kg_6)&ED0&ZaL;IP#a5)A<K,7a-H)FI
SSV/;^@aS#PN&<U@DPc@2Y<<^XQa3[a-_&S>Wf[+dP&N)<L[..5G.ZZYJag^,C##
X]=R9IW+4A?5XafJF[46_0F:0+cdK6>B+.7Z,_0LVS&cedWDPBCMEKdFe9Q,MO^@
]8EYQ[OVc6FWQ@IK94g.2JJCXO@d6gYL?K[8fEbNHcNZVLK.B49OgB/_LDL_Y?61
&ZBGH^1M1/<c9<G;&&+24/@3c5FTLJCFJ;WTCZ3B<NCNe],QE8Z8?>=aD/TLW-<@
_R;WIC/E=><Bc(Z:?YOZPMTOCG;5S3McfHf]X(X3BMdE(6HbJIG#ZVB=/(=Ve:Z)
bPfIJ9c4VGXQP9T0FLJGA7_I+E[2cK/IBSNI9I1Lg#C5H;@=fbE/7</C#MZ2>Y<^
5)+cE,dUN)@Gg3<#2T]G/AR3B0-6Cdc[d)Og;;NVNa2E]84D4QV?Oc+8T>72e869
WY=DB)DD0H9S<R.AH9=K7]:^EI]D#]OT,Y]P)XACF@]WC(DX9ALT4F8bbBOYCJ^a
Bdb.-f2M<O&VQc;7_I,]+3H]I,GI-PGC/+\&C1I0G##dI?NK:]F01#O1M5BUe@Rf
PE#6bPA:\9GU2VL[0,I5XY#g<f&@]WZ4CGH.e,G\<GF])L8]BM(43fPXLFXJH8P_
ZbL\aG7R/I7<27(TT1^LE^K)cJ,&4b41X1f76S=1D@()\\0CF9#DGdBbJN-3T>?I
_g?3:U(4d:F6HCP[SWJ9MF>T0J=^JbJ,(._+MILLf1D)Z_-BZXJ2-IA3>;PbXOf/
=T?CG]eK@QddD5BE/V(T\T,_bO1(QAAN7&LIYX=fagCWWe=4R0,aGYCe:MK<@fU#
1d^\;]fP?T=AWC;<SJgIH67P_XWYB38>1\M5f_KMWZ]3JC?JT;Hgc)\Z0SBdOfgB
dXbB[-9B,G@JQ?a^#2G7c8GI+0Mg/-<PdLe;F;G]?WJ([8+aCNS/TbH@7b@JZR&?
C496?P;C,^0QR;?;N<adY9+bH4]R3b8-.RX@AA/DG+E3P.@V>S=O+B23:,/&;SF\
e5]#d3A.L>TFAJ]Od4R7VE\B_A4&>2W2:&D:Vg9GIBc7fJQ(\K,T+D^LUMK.J5LG
bA&2bSg4Z=/dIA85.2e)EJKV7[4>C5/bI:>J>db+a(OC4V+OY=7MANUa9fKWc:J4
,4Y.^Y3T\b-RXBWY[aFCOO&9,Z=.H.CZGY-EDSa66NE\KY#)8_Dc0ZGd?-1;.e48
a[,RXT/<WX.&2TEQ.H_c7AFN,<.QIF\bLIR5#8EN91^-Q6/^[fX=@VGdL$
`endprotected


`endif // GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
