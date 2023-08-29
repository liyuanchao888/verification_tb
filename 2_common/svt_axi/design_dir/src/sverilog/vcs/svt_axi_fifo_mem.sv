
`ifndef GUARD_SVT_AXI_FIFO_MEM_SV
`define GUARD_SVT_AXI_FIFO_MEM_SV

/** Add some customized logic to copy the actual memory elements */
`define SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COPY \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COPY) begin \
    svt_axi_fifo_mem_copy_hook(this.__vmm_rhs); \
  end \
`endif

/** Add some customized logic to compare the actual memory elements */
`define SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COMPARE \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COMPARE) begin \
    if (!svt_axi_fifo_mem_compare_hook(this.__vmm_rhs, this.__vmm_image)) begin \
      this.__vmm_status = 0; \
    end \
  end \
`endif

// ======================================================================
/**
 * This class is used to model a single FIFO. 
 *
 * An instance of this class represents a FIFO in a single address location. 
 *
 * Internally, the memory is modeled with a queue of elements.
 */
class svt_axi_fifo_mem extends `SVT_DATA_TYPE;

  /**
   * Convenience typedef for address properties
   */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr_t;

  /**
   * Convenience typedef for data properties
   */
  typedef bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data_t;

  /** Identifies the address of this FIFO. */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr = 0;

  /** Stores the effective data width, as defined by the configuration. */
  int data_width = 0;

/** @cond PRIVATE */

  /** Stores the effective address width, as defined by the configuration. */
  local int addr_wdth = 0;

  /** Stores log_base_2 of data width in bytes */
  local int log_base_2_data_width_bytes = 0;

  /**
    * A queue that models the FIFO
   */
  local data_t fifo_impl[$];

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log shared_log = new ( "svt_axi_fifo_mem", "class" );
`endif
  
/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_axi_fifo_mem)
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the FIFO is assigned an instance name, 
   * data width, and an address 
   *
   * @param log The log object.
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_width The data width of this memory.
   * 
   * @param addr The address of this FIFO.
   */
  extern function new(vmm_log log = null,
                      string suite_name = "",
                      int data_width = 32,
                      int addr = 0);
`else
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the FIFO is assigned an instance name, 
   * data width, and an address. 
   *
   * @param name Intance name for this memory object
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_width The data width of this memory.
   * 
   * @param addr The address of this FIFO.
   */
  extern function new(string name = "svt_transaction_inst",
                      string suite_name = "",
                      int data_width = 32,
                      int addr = 0);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_fifo_mem)
    `svt_field_int(               addr,            `SVT_ALL_ON|`SVT_HEX)
    `svt_field_int(               data_width,              `SVT_ALL_ON|`SVT_DEC)
    `SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COPY
    `SVT_AXI_FIFO_MEM_SHORTHAND_CUST_COMPARE
  `svt_data_member_end(svt_axi_fifo_mem)

  // ---------------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   *
   * @param index The index within the FIFO to be read. If -1 is provided, the element
   * in front of queue is read and popped out of the queue. If index is not -1, the element
   * at the given index is read, but is not popped out of the queue
   * 
   * @param data The data stored at the given index. If the index does not exist
   * or if the queue is empty, the data is not valid.

   * @return Returns 1 if the element at given index exists. If the index does not exist or if the queue is empty, returns 0.
   */
  extern virtual function bit read(int index = -1, output logic [`SVT_AXI_MAX_DATA_WIDTH-1:0] data);

  // ---------------------------------------------------------------------------
  /**
   * Stores a data word as the last element of the queue.
   *
   * @param data The data word to be stored.
   * 
   * @return Returns 1 if the write was successful, or 0 if it was not successful. 
   */
   extern virtual function bit write( bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data = 0);

  // ---------------------------------------------------------------------------
  /**
    * Returns the size of the FIFO
    *
    * @return Returns the number of elements in the FIFO
    */
  extern virtual function int get_fifo_size();
  // ---------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Override the default VMM allocate implementation */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /** Enable the VMM compare hook method */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated 'copy'
   * routine.
   * 
   * @param to Destination class for teh copy operation
   */
  extern function void svt_axi_fifo_mem_copy_hook(vmm_data to = null);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated
   * 'compare' routine.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   */
  extern virtual function bit svt_axi_fifo_mem_compare_hook(vmm_data to, output string diff);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to format a display of the memory contents.
   *
   * @param prefix Prefix appended to the display
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`else
  // ---------------------------------------------------------------------------
  /** Extend the display routine to display the memory contents */
  extern virtual function void do_print(`SVT_XVM(printer) printer);

  // ---------------------------------------------------------------------------
  /** Extend the copy routine to compare the memory contents */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  // ---------------------------------------------------------------------------
  /** Extend the compare routine to compare the memory contents */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  /** Added to support the svt_shorthand_psdisplay method */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  /** Added t support the svt_shorthand_psdisplay_method*/
  extern virtual function svt_pattern allocate_pattern();

/** @cond PRIVATE */

  // --------------------------------------------------------------------
  /**
   * Checks if the data is within 2^data_width. If not, the higher order bits are
   * masked out.
   * 
   * @param data Data that needs to be checked.
   * 
   * @param data_width Data width to be checked against
   * 
   * @return A bit that indicates if the data is within 2^data_width.
   */
  extern local function bit check_data(ref bit [`SVT_AXI_MAX_DATA_WIDTH-1:0] data, input int data_width);

/** @endcond */

// ======================================================================
endclass

`protected
a&R3.S#b5V7>+@QPVVNfU)8:RNY0L3T.#.f56?cUHdLYXPYFY28O-)[aS4HGB3HW
EcA:[EYg6^C:._IHT>Tb)2)6[ZIKFgW8d0[H28MD7)eOE2.^TB&,@.MXFYgc88Z,
G@Q9CWLG/MS-@=\(T&1Hg.KH@gfRcWQ;<))U[bAW=G/[4KbAH[_cUUN:0aMgNa2B
C._:Nc+gXW3G@0R;OI(8GT7HWBe,C&-g<D=8>?(=]LXL3S0H0gcZYXN(1H#DY@BC
^G_S7gdR^Y9]E#6AL@&e_9P_5\B[SF4.9XGaKLDHF/N3b>#0^8[^KLJYJ?BQ3FGP
a\FW13R#6-6Y#LYP@>]<Jf0(f08S#gL[3NP:?\ZHLOd\LIfP2OE\A?G)/_dGdLcZ
a1b9W-TaHbE/KU9:@@.1N5957f39?2cPH/;2+9cYIdf)DI^?g?+GQ3]D>.bZ5HH/
YK4=T(H@Q]7<ZMD-7Ic+e6]_5:FZVZV:[F:P+OP-I/?P5SQ>9&,P.NJ1ATS42_C-
,0/DR9;e_WP_5e6J]IE(UXf30_K2CP[WS9W/:5Cd(4B.Q:J[^53a#6<>Q@R2E[V@
7g::XXa9J3TAVbHOL^,R01S;MSX=F@93H6I^AB02c)7S)G-PN(Y+#)e5G+?@E-6e
^Q21JOJT=WHD^KC5SJeFJ/eQU9[A,GGK,MIdN9ag,,REg3e&2JfUfT#U1,FY@>#S
bG>2JLaBE[W/[LceBE22aSUQ?Z5E?_RTgMOK)>VG-3Q=4QS9<bF7D@X92LL8\[=>
-,LO0>Q,#P3^<\cUR&D>-&@OSe^6XE?N-NM[^LLA>QV-Ya)XO+\e>1WG;e=5Fb)[
ZDZS-UEBT+edTePJ7E>YYQFS^c[Eb.ZER&V@M3^4JgH=e8W[LacYgV5S9FH8C2H0
SE-[P0>P(b0_Q/(NC]88WQ&+G?>aRbVL+H,CW&I+Q4>=;O5G24#/M9=B^I2?9f8C
>g)INb3?:BdI;.KL>WR#T9P.327U1JB.@<C7432gI?(4R6E;CFPJ>gLQ)=Rfd^0a
@+.3LL;1=BS1&AOcYIBHGS#[JV1?]<RJC905&[Y=f3WK]5G37ODR^FLQN$
`endprotected


// ----------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
VY0@6e.V.7_22]U.GJQ(K#9R=0G.H@+#Q97@=XB_SG>\Z/?#AR@\/(^9fA?cIA83
Y_AKM=2S>Vd4&DLT3Y\[CfI85/Ncc:\H<I;^8#8Pg48DJ\KEcDRBG.]e;K6@Qe)M
#+e5Z<@=aNLd]d3d3,651KDT\PG)d4D^PU^I?fU-/fYH4cO#=IG)#,E#=[E2@(1-
E.aEf1(]T2d1Pd0ef^+6_FO9+.KEV@JcfY90<2caAT41O<^2]&:F/S,GZdBAIP_S
&Q5gcKgB#&b&E@/f7&+=J\3d>92SK=BC_R1Qd>XIU=N1Vb-(<52b;87:EQ&356P&
G6[(=@^D=]a\=+E6a1eb]K-^<Sgb>4/BJGET3Y;\Sb=]9_S;,T-;#bVB=7<Z]fCc
\MTe03G,T-LA.ST/]A@I:/KM20#bJK@FPV_3-#0FQ&-Z-D+,g:JKE5->]VdXAbcF
MZc@P?<^,Q@FE4DPE:#^Y(FQ7bfYLd?C#N2+7IHaD9E@=GUUSNC2TSVA=[3VC4/g
)SWGPS>5<^<F6/a^f[fGaG)&,SEM(<072e]Q8[J:T/CdH^19DZ\c6.Q[g?8WTdX:
8C)bX-5LAPV>//1E]NPLC_XKV(E[g@W0Z658LV3)&/a&b8Og54d/SW?CaSaY1M&,
97S/SWS7G/6E0AR;5EFY6-YX/H)Je1NU+\/LYVMJ]R7XBBJZc&W<\NT-VV\WL7Yd
a]4<5g7+3AR9A];1KY7248+E+B[OcI^c1a-VJ5-7fCNLMKg5?#X1^,^;;\cS0SA5
1bMRfE],15=DY&a=)EL3M3N/=_fF?&>Y:JEG<\;IAAIK-F0;cF+=MbKOa?>L[a/e
MaPJHdEIPeRa>a\)S5bPM_T,7>//X&:OM7aGZ5I;NTM0YRG[7_9]R@LeC)F0PMW4
ceHV@=1VB&?DbB7\9,3feaD@Jf2G1/CDaY/@g9WV)/IA_Pf1#:([(G5-[<^R/f;+
TgbGc9=bQ=10GbW17MQCIHETUKVe0aR-fBB3YIg49?1=EA+][QT^F12\XTM:4;aX
3-+ZeTH>9CO4F=<.5b4LK7-HWIdT(PSM-<+6ZVF<.;[,3S:/a<eR]2fP?Z12Cd?V
Z;>RE04+2#?8f4[I@F1>YR>8^XECJ6)OW?+U]=&(^(]dE&cb#T9)50--9X.RVW#V
L_8YD>?XC.MH(1?0;UT?=2Da=O=QgIG^?QJTR#4:(P(UB3=IW]cI4^?2Q_a@1ZHN
J7?F=U)E/&(;374:@:g-T\6fB<,(Z_a#-ZZ\EF<F;:L7M9;UZgLN\2JfG8CR4f6b
e,MB6>\[+2B[+<H-8,F(cC.L/AO#c^LE;NB.=AacB,F^d:-QXL+(VDeHDF0d/&BO
FR9=RH&V48N5He6+AK^W]6cS1DdG&9M[S_fU=)^ccOQQeJ@@Sb\0MG(:H+M^U,>0
]R7,gPJSG1EWHQUL[IE>4A,U9bZ.8Lg:IbSMeE?^R&VBH=.=2@?[:Fd[I:eGH@;T
(1P9C0eMF:CdD0:UO.&&0JPg[?DUa;/Z7#?9A5eW3CH,SFQ6-eFX0-?Gf>&[-(0/
9E+A<@X>&^a\g8V4fcZG2Ld3.1(I#TLY&+S\3=QeIKPHJB9>(CC0@17EEaS=B\RB
@7[,<C?-@TC^:JOg:.&bAI2Z]/(>7B#&5S()BNG^EUI142W5U5P;fT+MOa@?VX?I
G57B[;BIE1PPa#7.5d@=AU-Q,Ua)8&g]a)GeS(HNaIW<Q51:Xe?\\N0QY12GYg+@
;V0Sf,WgW2S:0\N@)Y;8?(ZX^PC7LJP[Kd4AX\6Qf,1aZSaL#EX2V.g@^SI7b;S:
KHK10L;GdMFO90d1;2682]:B-I2CdSD,]KMbTKS7N=KH]a5@[8^5;?IT78QfJLFM
.=TbB+E4.Fb/ZNG63.43(,@6=@JQ62JL<Gf7N:2F>-3#aIAf1@F^8IH:M4.+g(?f
3W-_E/PHAe:N\9SE+TLWWd52\J/LLZP\a:/4?>aMKa:CL^)NZFS;1E8..06PE<1.
dfT>U7=bZD@R.[EQ?cZAZY,F/_0+cGLU8>C(g2=?PfE^=0]1PHK/e)P:;.+85eeH
4ZT+[+=--<7OA)dH<LAPX_QI\#]0;M\MKR<K^_0dT&bN@H:81G/MUR=@<=K@PWT\
R/RD8K1V([2#Q\3<+I,f7)U<a9E(d[#aSA]SX4f&b?9-I7Y)gYKKNFG/egAHNdFI
7I=-^eVENP@aB_AC/2>0UbM6@d;dR>8N5+3&4R\:4Aa8gI^f+Jb(BeYO0Q8BWV2:
ZIAP@B0C@B,D71AO8WC4,9f[(W4@Y38JA0FG8@eadF;?QbGK1f-Md@;?7EQ@^aFL
4^+L>/4#VE9;NZ8=5YcL7df\G,E6Z3:&0VCWA1LCdUMRF7_a>LH@d9,-P.g4CU((
LGLO@;Z.fW&ZJPC:B<<1E^9^O&,OfR]S4<(\P.6:U-gLFEJ.;J+Xf_&ge-cSg.Yb
N>19KHQ^9a7E)6eEFLccN9g_0[PWG0_<83DM7._S+;GKefQTY=eeTP+.VDbB=-EK
U-E(Kb\^A.\@@:Pb/E,K:4B5H9URTFPXZZgf_4I9HPO)4L.A(:1-W))BGf7DUDXE
53G6fI7.1d[I67F6?P#I^]ETT0gY,2[-D9]/,I6g[AEEe_(5P+ZOR<#S6MH5#QdY
-D0+RAYARF2ERS4e5Od4bXRLD62[L0A&b[=IVCQ?\4d99>B?9PSWMEb(I,6GK18^
8&6;[+=a1P2HO\YI3>KIO7O=U+b,J^C]aN<bK#^[\9B=KF/\9AgbKG<M)KH=>W@Z
UdY-:R3].5)I>fQ@4?b519&7A]].9HD:O@=Nc,ZYG=J#X&L,R7.-K+(UdT\0].FW
eQPJ;\S4LF51@H,4C:@-Z;-\-+Y)dSI/#B<\VNVd3&VP1b/d/Z-)HFgK&A>YZDO&
N\I.GMbJKfV4\JLM<fg@_L+&-I,dd@GC,d)LA[R-OV[Q)1Md_DVT99f;VVC+,GOZ
;e^--b2U\5Rbc+<6=8;@J0RN<UP3MZ+<2@YeI&IEDg_1Df6Wg4(0)WBddL68H92Y
EWT]Y4S@4?3^&O>(Wf7=K5EA/#8VPR\-QZ00/e8M2+M=/&\b[1?X(a+c?:U>Q#dG
?[Q]42L=]d0DB)4S^ZE@-QP/G0_XFDY[T9S@_(#53\^JDX&\B2Q\PT-/V)F@BX/1
5URHG]f?Sd(Y2DRe@AQ=#Hf8[7?7+ae90B,P,]+-<?2O;cg3/5Wc?cI9DEf347KR
X/B;D[O@KM+Z<BJ:IYAI1IOPKd=Y+M9\;Jad@=-,&TMF;:(gZCJ^N-g5U8F1NVPG
80(A?EVHQ89T_H/C.Xa2_Y[Mf;^W0NG3>13[[=A7:N_MV^)]-;e\QATH?1+8/2?R
\ReGb=9dXF6-/?6T]G)=K;G7QC0E^D0d=PB3S8:(9Z#/A&V4Q043+P_KD5UY][V:
:E.H>KGDdb,)1ad<9.>F?DUPIQ]bRC#W@Oef/f,@.Q925a6.9RIMI7e]&bfGQFC?
9GY=V;&d\??/KdJ##,_V4=)SXcV,T<aX=Q_=NgP)R,82:W#P@5\4#-=#UAQH4\S?
J&eE.S4K0Z7-eM039f<D,H/bb5]9\b)K&Y,BJc&XR(E+c#AFd@UZLC0P<#4-YNGV
AWGD&RcN.d2R0-^4f5KSJa[[8&R:MXeg\6(a+;+?3Qg07;eLGZ=3_21+K@J7+WVN
HW@-8<&\2S9T8P7?bRAF\aK:^UZ^92IR&QVLS:\RN2,@^BWIK5a/@>W4M>-LULW6
QI?>?]DPd7PQEM4?(f:)PP[U&OA@EXZ4B-:X+D2dRTd)_8IR?UdB-e831PJ(,Nf<
9a)CB=H^J3F(b,AP(QCdUDX,OfXHF0XfD5U8#a-0,82RP1>C;cP8>U04BMAM@a[F
+TPC8eKSRNUS/H?JgQ5WK0:#b,F7CQ)JRbd-Dcb(I__7[J?/)F5Z^V1MaU#b)5gL
_(PA,N1A[L?]P+2#X5Pe?927JO7@QR/fLE/&3OE&VO/,g\#7=WbB(M9N:OY#CF+<
^0OF8Eg[P_eG@_?_UTe\g3]g^P,:248ZJZ_&2Se-+WJ&d^,aW5;9]Pe1;>g?4\QP
7KE1E>gY5ABX[]6;O]M/TR6SeXZE4K&3.\K,JLc8gJQN,ZMAE;DPa)M..(dN=dQ/
2?.D5M5#OcZ4;bP]gGGU.DKcYQGR2A_JJ=+7+T5(-WHF,&^J>bQ?AEgb3gW^Ba[T
E/Aaf<TTX-/3+F=B=[]V?4I0\L.K:GQ#S<96K8=<,aZ\+^AD(4QZd\_F9a93@@:_
^ROBb9D\1b._#J3IRP7Q^&[9X2GeG3NJNe@KJ2(bSYc4.43,3S#WdMCcCAY.=CV<
2UE^.==I8@UTc)->&fBKT#e_LZP4YJf^FV+VPYcL[Lb77;WQISCgA/2=_@eO:ecV
/0[Hbg245F7H]P?OdOeJgLVHPBC;JEfSdfR\UH/S2\C/IL(:C_DU[OYLG+TPN=+G
2UH@DCEAZ_c_/,f:Qa5\)IP#<]7?]OaW+eBSg_EZ8BZS>H-&cG2Q[cWdYD30>I1e
9XGPZb-/[0O:X=&K0<L5ID]b-#QC5J5<4P>8MGfX^dOKVQX>^JCCd2IgQRSOM/ET
00WYYZD>1H,XDJGO^&WMCG,HG?Q(U_-9f6NJOQ=JRYgDW<=GTCTELdW;1/B^K#=3
6KV^WEQU\F=&bJDNS0eZ70aG-P0QWeHP9gO36A-F.FGUZ:DGE6CP53:18E2W,e:+
YULAe8/,;^a,c41C-:H/&,JbH&Q3?e]<[CXd4E4Xe?D4@<0->9g_+&GYUR0-K2BH
OIA6U3>E68dKPf]?JSIa_3CT.S21;gDKTX3g2ca_=c+?XB2+;)CHP3E6NPV=DO0>
:6@9H(.MRL6QUF2H.JMF<;g,UZTD?DNOP-#1.W,:#HIZ8STPU0O2<KcO&W)eO/U)
>[f0_]A9TIVFF?QWHKUZe3f6D#::1:YbEW_&]^PUT;HF3bL7e[6W)U#G?&S(&@6N
+\e(Y3^bC[T#<41gY\@Of)BW4dRJU]<ba_KGLZE:?bdC_B5W@g-/<O(8[#HTKL8-
9AQaAL+^Ec>R4[@2RO.I8a)]#@_CdZW4_4TdA<]G[),A@a3@PY#4Me^\7JIFE-b^
V9S]aC670,Y@d&GRQRO&WNVJTWD1_@847UccZS<^9GH<ICd?ZECcf:@d33(OBJH]
/JZ.^521@gfQ,a&F8T,VS5K^DB-HF\AXaO02,TgF11CHQU=II6?WdQ.<(F?2e=/3
IeacUN8A0HP800LY]]Tcc:S?e2;PE;Y3Oc)P(B_:SG6aH9YZ/OY[_TQPeFWA=MW#
8\eO_EeEJWeR#_7[M()TE&95&L:3e:;?R7LLPL/Z;+/G\0I10ScVQc9\eW]FN,EU
L?;Q3b=BF(?)7P<&#f&12J,[g5a4(UVcdc&V1)E(7K6/5Z#AI?e-,I>6\H.b3=EH
4#U212&RXSbIaWDX;5F5bE5VJ6W@E)UfP9]Qe=U/E)RNJ)KZ_HM16HFJ:7F]bHg)
;MI#MfE4dg\&^NZ&V/FB+NZ5M9]#>:L?ad3^=&dQNZB@KR+gOTUeT?S3&)[PKE)P
9Be\WbQ1WMgZDe3YeGETKU4PdDGM>8[W37]Z>LMad<:4;OdNg3c6JIDS_.-XAd+K
>c/USd4XaMON@(YZ4CacE]ZN9.aT)/@K)ebX27VKbdCK8@D<Z</7F[-;0bbL_3Gb
ZG+)OH^@4D@,B3A-eB;_X5.BeUZ83?GJ;EEPK/cbB,1CJ0f?fH298RH:43O(FCJI
L6Y<P8J8WZeE3SCY\2G]Z5HC?QHKU8cLRTE/751Df7S(W7&+ZbY:G+)UA^54ZG+P
PMXZ+]Ka+XRf@):+d/3d==4<^97I+HYTS=TNf9_X++<\E;@]GO-8(97:Ca8A&g+D
.(9.<_/=Q<GK<DET<JM)(>)4AO-Hb/;Xb0^gOB3;-I7]PaFN#Zf2Yc1J)[L)DdEZ
[X&)?(UY>gP-&1?MaY\,9M8>fKJ]/UE0WKU,MZ?DAW=EU#5BVW9Pg151W[Cf/HW7
[SNf+[<,W2YPN4C+^06;V#2K^ZRH<Aadf?g#UXCU-HH_1?G1RYUBfS?5MF+AOBdI
8R4;BBANc3,-_(JNY[5Qa(aceCOT2[+(&RX/,^\TX,[e9<R:Y<^JQgP+E<+#Ze_#
1fONeS;eX54HF]V6fI+B81=:Z\5;GP-7e_Gf[-a/(bX,[<4cLK2#)W-[\a[(FV8B
)U)_(G<1,D8Jde[2G>Z=/GZZ1I4O3dS]MR,\^58^dfVF25_H&/aRV,+BT6?,VC)L
<7YT&;DF_ICJ3O,eOS\C]Wb2(YD_P:\7CXZ]5ZJ]TWX:BE\LSbbP2cMUc6U_S,d6
\;,1OR^>INaP8A<5Hf:IcUJ^G<EJ;+2a&?EG)KBgD:&MGXeP^U85?HPd3X8?ebS.
;,gbVUT;7f5UJXcH3P;OcDc3D\g?_5I+[cfA>L_b)WA>2G>_._-;I@e4EDa?6J,=
G5#Y5FUB7607HWHE.<.HVWNK4=C&\?CG4V:BQEI&3;0E:4O(T4JZ]g-eA]#P.V@S
(DgL\/UF5\X-)A73&RcNT]Sd3/Q7Q61HU5\P8]VV[YZVg-JUN<&d=9V3-R3#BD5Y
UKP:]<)RE(KNY^d_:=43(HH3)OH0U@R#9\W1+O[K^aCQI)Rf:9b-.a4KcOb5XU)8
GPLL\f0gJ+==#J47Z(I];_b[O;cMW&3\VbbLSUNg?KM0M]X8c0b3]CS)][(6&B4_
8J/5DX=05QS5IOVC-C]@4G#]^SYPMHEG9HaEAfOgc[;/^Wa4/6A2#DSggc?66aN[
.80dJ(G#b>[Zea3UaEAG(3Yf],(,RW_-XNe45,cN6&3(LBdM]&@>HQKB;/[U>X.@
_NCW]DVSU=8U@R9cGKQRC@P0@e<@02C9W7YQ1fL8CY_[Z<=T0:A0LMN&aCKW0)Tg
FU./9&C+E4O09dV.B1EUB&&f9\@_,QOQ6)SXA13.Z9d2URc:FR&d]f4BK07+W#6J
[DdOQ.@X5T<0^:>L;,d>#9R@eMeBCQbYdf;J=Wg7F<3RJIAA:X\CQ:dIBN/UR=e@
SPSc:D;cLSW2-4.&9&M/,2^.\J0T]X@L(Z&.[I)MeG9?6:6LddcdeR4CPINM:(X]
G8ATC+1d:Q&-.DRTXd0g^e)Df=7eV51KW\0+S]2^3=_Y/HG[95:KdY5Y#c)D;52F
RD1)QdS-0f]6b,,A.g4>Fc),01&[A<=PcIc3.Q_R]U(NGHCA[X12Q8ePWO>0&;2\
H(93=[.8((K_eMCLVZHc:[&P+=6b/DOKBXad0M62)F=5/MHU<B8<48YQ0<4H\K^#
@+e<YG]S;Cf-BC)6WOTb?MX\L@Q]-LGe@\3).Zd55[FNXTG_Zd]V0#8E-AK>45&.
Tf;DWdAdS>:?M3V\QagR8?)K]G;#AXKC1Kf869582RZ8)IGYJQ[._-?/b\&LTBH\
O8eOJ2e.FEM2C=8B[V3<d4=VJ;(YfdOEYKK(;MMD0(=PRX)X4,O8,41LZNQf^^Wc
0gU8EK_]1E[+<>VZIC7G-M(?eYM?]>gggN+OZR:S-PQbGb21?1M4bG>@+4@;?[:3
CB_SDgOYP0[TS]>IY\VRGg4D[O6L[=D?2HLQD-f84eN/#/UXPD17@S.3V]I8&+1<
G7..PNZJW+VVCT3HdX@6^3^RG,_930B7.Q[Y?;[_U\H[8>I6>8fRAK050Z(_2Q6^
LfN(Pa;d\X:YZO\T;^>XDB-U.O4c0d5QO8>H-K8O5T2QbUaJf(6VR29UD5SfH^Hb
S/RNMS(;c+-bg;d3MKeX_DZVTT9(8THFa1+gZ=OdD?^?)\-7HZ?EF-E)f1bN]](M
XS&:aFUR6PaD00d);fPF:JJ^fX-R]\^HOK.UWI@\KdfRKIEd)6I72>V#<RGHES&&
L),>Q(Fd@41(H?LS4M<=D>3GK;P9WY(&@TVQD.:e/U8&3VN/9-]bE<#QV>2aXe)4
V#H6D+U-<a]/O.R;d4X)0]/b(T=Tb\#]AOTaReN)fA5f5g_3IRS]dUY1]S+N2(a3
1d),QT<c11c(X@@^0ACS).H&YF2(EUL^CeVRBWU_[>KWE^:g:2G0ZQWO=/_]QPc9
M;P-R8M0@615T:(7#&FHC@a)c)gDSS#MTBTaG/(97U,(a0Af0OKJJd25SBO7QLMa
LSWZHKabN=cbBVSe4aK1+fUC(PT:D^Lb^<?&M_T&UG)+A-)I5FB1,Q2G>;D/3T@M
N/+:B1<F,+,V92>5Ga#Q?X#C,.W#:,eG(c.<V&4MgUY2gHd8Acf)DRLN=fVb(aOf
+^BgOe.B]X-+0f.Q@;gIbF7;IbaV_T87,Y6/VR+/I7=-JN1KfTX3.[8AB,XbROCR
(H6D2)[OO:2]bE86fF-d:<e4a,W<7aI?HSCGc^SGg<SbC(0A7>(@S=(SO,.+dM/9
+H-J.E#N:-=OIA18g&=9H39ZSC4B27C>[3IM53O&QJ=<0,Vc+VX+df(D;YX),VC-
1f;LCY:WX-6\cA(>7Y&8C=CRPHGP9(0&/&<a-4f+1W4;b.5bDEL^JCBTD12(5&\B
3\(C3RMB<#UgU]:,P?R3-dX3EOC]=Jc;:(6MKK:D)\^X60^OR+P?bd\VO1H<^WO1
9--V>?5Qe>d=JOP&1/-3DUS<+8/^]ZM6_\UYN52C?3P;C6(8.RX6A#N]?a7-/XWB
CCS^VWX6XQ,[=_+WJbc7dTGZK5_(2/_F9^5,M4bEb:)P_AO2?[35MGUf7&0+e:\K
J.^4eUV?Y.b<fIb,[IReA>Z3I;=S_A+8I>dY@#.7V8,4NH.<aGaa;>f90TB(=Mdf
D[E4:FN=OR#95Ued=LI?)d+70PC76/F1AJX1.(8RFAMdA;EDW0I7U#6/acg5S8V-
Ee&1O_b30+V;0:0SBDAIYORZ?^C\WDW;?[+8TJR20<M7B[^-B.;;DVa5BZD:g1g8
F#0N:4Y-JD6[QWDG2TC^CaW0HO:LNFI:N/<\bT5G/7=9Pa6PA[@P266Wa)QT6&dW
3A2d<1)6&C)/2D-W)BY;XZZX52#C039b\+IY#)P[8Z,5U8&-DgU6D?6b/Gg[..aB
S8@=NM/Ke_=N5_9Y;+-[?S(=<Eb+#E&9.Rg.;<bfQ#YHJI0OZb#)dedK>DOYDW#C
B,Xc#QO0CG(1A&J]=;XV<fC^AR7I1ZII,\XY;B^?,XcMF:.]0^&b8/EE6f_a6.HB
K&/Z]\.:,YJB<<dXfYSQAK12,/c&B4[K.Xf[92\=U)f4F(.W]<L]^VDE,d/2:,;b
W1JB@W2c?8f/L#c1)6eWJ/L69DGg4fWbA0H9Se#6#)3C(LYP>_[CC:[+HZOW7>U-
=4?>CRdR=]?aV[g\9_#);a/=<_M&cD;9c,M/KHQ4-TJc?+=.&N:d=ceNPd7=KU6M
CJYAeB6XKg1e]\QAQ8N6F2R]+aSSE\8&]?Qf0cGNI&@?Ka;;99G5e?N.#9;Lf2(;
T0SSDR\9d7UA&K.FK5&7KF9W3f(;T[6:B&L1<EWH.@?S2afQ1]eg-X27V(a,#BO)
BXBTF8bbMRI5N5SR)S&9]aF76T9cW]QKC_X94@0F@-3fHA+3PPa@0d\@.f+P?M];
..<1\H:2/:32M#@_Q;DC)>S:H3Ba1-)#dHA=_:?X4=S8YB>5#,/(C5Q@Q[08T9/2
_4Vb6G5.3XbG5P\W\LaLYONK[G?./7;O_g#K-O,&Z6XPC04IVN@#9#HO\@F-a-D0
XO/\&a+]23U[#CcV5RH:^QW6aT1+)RV7g\1?PKEKEd+bD6;@J+YfNgeQY\<Z-O]4
42U>7RdC_-bAb_:g(gM:0@T62JcZZ6=_DVJ^7I_c#7d=YX5J2[+c\B?dS8HL=404
0<fWB)N6e&2DVaB+<KfN3;dE.^e=5\/8DVfF/AWQ642P<Z6?FJ@0[M&8HfbJcQ9P
&LXY);7eSg-HO1.&aWa?IcPVe\&b6N#b5D7?:M67ea=c]Lf^_>dJO28(XEac\Dg>
_LDY)S]&F[</GdbYW=I[;Ea>CWE9/,C@\<dX:/_cXU:8?eAIKHS?bZOcHS=ANU@[
B9KYC^MW#3-8SF>]NEEgT5ARcWWCEca(U[e9gT=STB/Y>V-Bd4^5&X609aXPHd<Y
8BHEN)(&F4ORYYT<KB_Te5;V8JUgMRYJ\N@/+K7fa,B>^B^@2MH#5?R@7.E)K>>>
A/.?)8fQ1#XD=b3d?07EL8XYRQG]:g]ZX.Z1)Y]0_^1-<X,W\@Hf^7ISC/<8I5/#
KMED@a(;#&ceA#=K0G3Mc&E5,+8.<NT>TE)TH^ACBTKdf8d+>7Zg\E@\[N#S?P44
.MT]P5RY6HUC4g]N5CU-&B-N[0+GRPcSO]+[)#:=-+(W-EE]>?XSaOWf&O0e8#Yd
Fc/CMM_\]OB^=T&GF2;B99DBYJ=3WA0&E3/;?f&Y>K@>Rc3>eGJ^U388TK6Of#/H
-<C/c[X4.d07LBR2J^<=X<>#g1;](O6LK=QR&^;fFCBX9VFBOXPDfe88<>#D^HO[
QUC(D>:&a/W\OYXa28@M#LQf_SVXHAII99V)e;Q-54fB0><Bd@/[;YKZ52F?E\^B
3QP&QbC24^YMIES1;U(N-67#8ePg#a;bW#.22Kc20#V:/-;=YDP6g7aDK_eH=MX4
VDVEc:QHadf66)Z\NZ;:W0/2YJTAAM&R+(N&cCY#ED?K,(U:=B)8_cT3T51TJ^_eV$
`endprotected


`endif // GUARD_SVT_AXI_FIFO_MEM_SV
