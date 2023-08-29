
`ifndef GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_axi_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed AXI configuration if provided on the constructor */
  svt_axi_port_configuration cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_axi_mem_address_mapper class.
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
  extern function new(size_t size, svt_axi_port_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_axi_port_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided AXI configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_axi_addr(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided AXI configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_dest_axi_addr(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] src_addr, int modes = 0);

endclass
/** @endcond */

`protected
/#QJ:1BYL#+.08-11#G-<671T)<59HJRA:BYP5[G:UW0ONZ]EB&S6)REBHIc,MW3
VRU=XGd40.a>f(40?Z-f<5Hd\.Ic^6cB=WFd=/EY67SFUVGFM>>VIE:KAc>O96Ig
FWeK0XM_bg/QXYfF#?e>Ug0L0OQSI/7d:62LRMKg7OX__+9LG45=M.HKg1=Eb/R;
YLd]&\@7g8&>?S0:=Ee06B_B3ML#KH=Q[F/SC86KNa;EdfC=4:_P9BH\F^Z,[&^3
1Z1OH?0R.PG()A4f]eRJ0V29N3:VNePHE,eBLDX=2g+-ZB.A5R\XgJF68HdgD=3#
acZ),))QU-#RKY77ECA>RR-3JU,4We\e9ST9dL6TFTaV[QWgf)NHDA_Q;e3-?E)a
718,HY7P;Zf;J;f4Hc4=6&\OC@HI)@U1,-eGJ=?K1E.K;Jc_OFe3Ea?R6P4\JbAH
U0JgKU#bPP#)gP^\7PG5^D>;@&HBGVTZ(NVaM;(<>F/USK+QH2??074C&4d<CgIf
bMLW7Q7DeF.TRT##<W5I4-8]9+N7F-VQ7bK78LT>KZaV&DTW&^>S<c:OSOU:0>:F
N2L)OV_G03D1LEMR-U<<]N224S]Y]W9EgdM=IME/GBFH:7M&/fIY(E8QF,EIbe)]
SZa>J=T&d5b_A]&/2Y?FZI_+^.+#8<CYUba>_PI&JWcbQG#6MG;IZ5@>Z/VM?2]H
U_7&MbMba\[,DGQXP=R>Q]8)U:CBg7?2M&_710#gDg7?_I)X)H&SUG[TYa:0U[Hd
F4BJ&G2=>-J>5e18IPF?QH8)7$
`endprotected


//------------------------------------------------------------------------------
//vcs_vip_protect
`protected
G:E];ab\@M_B3<U50ZAIR1S&?_eCU6<.SR\NGN@<9X&d@aD0D]B67(]E1^O^8?XI
9eE6.<Cd7=?b^YISTT8K(DLHBI=YcPQ2<aUP2@B,+c&eN.C/O+>#f/UP).^EbYT;
CM(O(H@2b#U<66;f.BX8J[F\dc@L=V&JMH(S?=Xg.AW39HC0V1Qf9P3<9RQg0#LD
cI0.,2PWc\WDcU4ZPT#YNIY)LG\&#K<0.J.Tc^H&(@DS@QE675YDEYbC/3<62^KC
8J]AcUV.90dagB0>-PXL^#Fc>:30W#)<Q.?/3eBBQ@UA7VU=R4@f.]0N:6H9T8g^
dE;W=Y_HC].N&0.]Pf>S#^[3H>dL)#Ca/O+LHYK8;BJE02KF<&]XGJJVMQG<FA/Y
R5X_:N#(OLKP9dRW\YDR.aObC^Z-OE2=?;fcSBP=(IK#9<bRUT>=cB9b/=-G1JS\
PAMeH)?DQZ[.ce.O,H7LW\ZL[]Q6#K_/(NP^;AACf;/P3.TCFOFc#\,)GOHS5)8N
gOQE#CCJ0BYGEC2TE=&[D/(#FU.7-D>b;G_aG+@eZeQP[539O>&EKN8bf9G1<5g0
3??W2C/.+Z)@.\LNP.,H-=WEU2gJ8-JaE#<FUc;e;YbZFV12d3_&J98SeKc>&UB,
996)/4ZW5M5DR(I@)VAIRA#O(_N94LL.GGUTF@FJ04B^=O5eS@MP:7EI(&JV#8>>
,8<>J62Q,1,3CTEDMI][WM)QdDH(CUGKZE43aV(34AbD75cGTJTdL/@V0Q#LM9+W
K@+6LCVR.+E6L.9@gW=JYb)/Q4^gC\Ee?K91#IIF@5<MH;)cFLePX.;.+@_,Ta>+
MYF6W&g8e\e:V&JM7_^,dQcO&^GO&3Q5NJQ\eC]0AQ6MY#UW&FfRXWW5+,V+LT,=
gQ7L:eY&3&G)a;,9=12<C[C@-_bW<;53\F\eHc8IAJIN[IVM/<=DX5P2XAKNdX6C
KM=e3U-IY6I#)0IbW&>aZL.XS/1MLF/cFL;2#;\D]ZE:/=LYG;O(\8NS>)g(Cd@g
K@S>/e4A.Rb11J/0=)UQ7,cId]+UB65,@<;1e6FCaA6)NGF>XgXGfZCG(R+&@1_:
aU=N)7)KPUS\\?UF+8.,,BU++eE(TJaLEB;.3^-e9-,\O,#(bNP@KS5]&8TK)69-
gP+4ELPB[NGQObHB:)cOKJKIg;#W#c#<P_KSP;)J^\>7X/E+7R?UF1MK+5EH>VL#
RKW/#aC#UYP=(&;:a7M/79UE2BFfMP<cGC.HLAAQI.TQg-HSf^F#;-P6#BVa]e[?
2)b0d;T],6D91@ZdBLgXee+4a)J0D_IV6J8,J3#DHIRXLGf1HO#9c=4F0#?:\H_M
86cQ9HO^bRIIGa\O.]?QP75aS+3=FdLd7De99DQ?NH61gEP,fdc]J#Za;+GH8+N,
bG4X:7A3gFcCXL.EQL8#DRVS67;6TLGF9HFN+,.?+KLO[(cX<<1[/P_6BZ,b8TV<
_>-NC]X,adIf3&+>6JD]?b.2[J:44#f#:/-:E52e^P/1PAKI.B1e9,TU+CS&PYKC
X40T6/G_G_GI#1ZV.Fa>AQ4Tc#O-7_L=M9E6b5eJ?M:8>9<ZFZ-/.PC-^D\S5)O<
;c\AI[\6VW61N.E+]c8;eC-U2T-7[9LG\>>U53N?\1<CTOggSc(B64c?F,ASe:-(
PdW&X\-C8QCJ<G8UPfUNPc.Od+0Zd+PeF0-SP(F)XLa&,6[IHRENY81Ta[AebSU.
(]0<S/AHMW(Ug#Za-&_^XE@;HB4,+>0ga+=DZVH6W/]QdgVHBgQ#>7gU_]g?@PeJ
?FCc5)S/W7D2F4+M:YQTc9D^()dK#FcH?Y2?c..gb8O7S1/VSf>/-FL+4&>P?2:E
<3#EJfOg[A7@8C(&G(#SZLF7):G_4EMcAEU8+NK0Ig>JFYDX1gR-L/1C[:^V-4@g
[-PcS8XNNGE@V00EUH,N^Jac8bd,[PdN,]g+=<Gd[UJfR>NN<96c)+IJ:;:4F)>L
^W2?/(DeZNK7&>2Ae)d(c([R)L\;NDRBEX;bVBQ2BD:bJ2BN&-+Z-V0GGO^+>-(1
N7W\L1TE;RH:V+Yb#:;H)b&#)VM/.6#5ZE(^D2LI8Ja2MX4M3d[<X4bG+D[43SUL
FA\aE._1/^D>KWI24D#:BcE[L8@2X,7156SJ/+4a4WFFf^3TBc&/g38aGLLH2+Gb
J\/JC7)N+)BAZGTgONK?=UI4OS@DGC,E[U87E=..Fg2RRAF60&2(8>b6,RK[QXOI
J_&2RZYLf[5./.LgKTFQg0a;J06,O92Q,[4WWHfg#e#KJ<>KGFg7QYJQ_#\>#IN+
&&-4R3:B/,<9f?1-g#AZUg^([;PI8UEPT&AaI8E/AdG(;b2HaR+U:f]EZV#AbJG[
SZWG>MeD/+:cbX5PR>1&P#TQ[++6LBU?W3?,H[OW0^BgKD&9PY-D]YfW(15.SU)O
(UKVR.b27K11F5D-PKL_RR1GEK&,Sb]P9EaZ8d>=X>b&;UEZVVZ\)RJ.BE_<YH)E
FRJ>0Q3d0F?VKJ[DEcIEFLBAcF;1BPH8f,B-6MWbecO08aae@/993KRF98:K^&+a
UECOD4/_OW07B#?c[ZB,]2/_37eTA_?CHaMW+f:^&[:4[]^\SSPE5V3a3V)cc+/e
V+GPPG.&Y5HJeSU28/H#.V[>>MU7N5?T<G),W9+&HD&(B0W]6R+X2Z;.Vf&>I]f1
KPJXePV\Z3L6R&_fL2FBZ[,_e;0]AO>..@TZJ78M3,,B_3PD7C8/\./)cB:]GR7X
+&J<3VE?4U@S1TV,IFX7-?gA)=8W[UL;fV4=e,HK]_.F5_#e^?TGPf&eMGNa=EJV
b#+IdH=9=ATMWR4fMA4;AG@MCLV:J_9SJA>8I6,J4:\^^1Z-FZIE(3SRDT]OZ7a[
b\:1KIAE9\1Oa>aGWV:ME5fP<[g48VX?fS0:\D1M&<_1#)7RJC/J7-^=,SaF7OR0
N9DPP]bCGR2QNf#=R^GV_A:[2P(0[+,+,65?WH9;W5J<?T2][f^(D6L.a[OA_W/K
Z#3LKL@YVFRBBf7V3fD2LKA:VD7+@HLY,[+8#^03FN&d.&8KK^JT#->S_2eHZbP-
C=A)/?Gg]LIK\)U&^-O[D(W[XRf7WK.Xf+&1/(CI(7LS_W]P-U)9ZEc<A,>NP4([
fdIX]4PZZ>cECCT<+H/]?f5G_b)=V<QB_(=UTM]8GK+LX;DS(2PZA@](\dF6G5Z-
077?=fY/:gKd5GCSKC=(NgM@fD5ZWF3KLU4_ggE7#QD?F8IdXaDbaTK-B;8ZT<f9
]:\\3UOB5HUC^7P0ST,1]S>&/[2[E[6N=61,0^=fa0;1/SV64bVTHY\+A1V@\9]\
-M.;5PG?d8O-DSCJf4e0AGQIU_2f6/Y]_])T#-NbV=2X=GU#Z^MYJ9-C:.[H@+6O
KB8FV1J=#25)>SL,.D7)PGQY+bIP@E]5,EVUR&AbNKYMc312GcXY#Pc]?d04@JWW
S6c=47#4TU:ZaQb<QW8/bV+/]#X?1F>E\.OQM&8/O^&fW;.TT\3CPCc]I$
`endprotected


`endif // GUARD_SVT_AXI_MEM_ADDRESS_MAPPER_SV
