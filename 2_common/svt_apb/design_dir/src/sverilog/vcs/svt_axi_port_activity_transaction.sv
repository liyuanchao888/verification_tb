
`ifndef GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
`define GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV

`include "svt_axi_transaction.sv"
`include "svt_axi_defines.svi"


/**
 *  This class is used to capture the AXI transactions as seen on the bus.
 *  It also captures the timing and cycle information
 */


class svt_axi_port_activity_transaction extends svt_axi_transaction;

  /**
   *  Handle to port configuration class. Must be provided through the
   *  constructor. 
   */
  svt_axi_port_configuration port_cfg;


  /**
   *  Transaction id obtrained from the Bus.
   */
  int port_id;

  /**
   *   This variable stores the cycle information for address valid on read and
   *   write transactions
   */
  int addr_valid_assertion_cycle;

  /**
   *  This variable stores the cycle information for data valid on read and
   *  write transactions
   */

  int data_valid_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response valid on a write
   *  transaction
   */
  int write_resp_valid_assertion_cycle;

  /**
   *  This variable stores the timing information for address ready  on read and
   *  write transactions
   */
  int addr_ready_assertion_cycle;

  /**
   *  This variable stores the timing information for data ready  on read and
   *  write transactions
   */

  int data_ready_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response ready on a write
   *  transaction
   */

  int write_resp_ready_assertion_cycle;


  /**
   *   This variable stores the timing information for address valid on read and
   *   write transactions
   */

  real addr_valid_assertion_time;

  /**
   *  This variable stores the timing information for data valid on read and
   *  write transactions
   */

  real data_valid_assertion_time[];

  /**
   *  This variable stores the timing information for response valid on  write
   *  transactions
   */

  real write_resp_valid_assertion_time;

  /**
   *   This variable stores the timing information for address ready on read and
   *   write transactions
   */

  real addr_ready_assertion_time;


 /**
   *  This variable stores the timing information for data read on read and
   *  write transactions
   */

  real data_ready_assertion_time[];

 /**
   *  This variable stores the timing information for response ready on  write
   *  transactions
   */

  real write_resp_ready_assertion_time;



  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_port_activity_transaction", "class" );
  `endif

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `else
  `svt_vmm_data_new(svt_axi_port_activity_transaction)
    extern function new (vmm_log log = null);
  `endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_port_activity_transaction)

    `svt_field_object    (port_cfg,  `SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int       (port_id,                             `SVT_HEX | `SVT_ALL_ON)
    `svt_field_int       (addr_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_valid_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (addr_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_ready_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (addr_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_valid_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (addr_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_ready_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    
  `svt_data_member_end(svt_axi_port_activity_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[],
  input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
    extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------

  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
   extern virtual function svt_pattern allocate_pattern ();
   
  `protected
>XX+O.&AAaXC[f.CL8M=L&d#UOG93U:M0CG[8L;c;I_).C9X<5]12)@4KfQY;:RU
</][:<&8M\=C/$
`endprotected

  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_port_activity_transaction)      
  `endif  

endclass

// =============================================================================
/**
svt_axi_port_activity_transaction class utility methods definition
*/

`protected
)4?X^Ecb9N=f>[c8,UCFe)f2C@.K]GQc8TOKeD#5^1[;@]Df(U<S()9TJ)f/LFg-
#BWX?],XPYG_)>W@UZ)XF6M]\/^[N4GVTO+1\7K3/DGIO/H<e^Q:D<-C;a=g.G@=
&>TbR2@Sc,VA040g1#K,H(f,]9921OL9K2Oc::K5+6NH&QeaSY[YL4)N,.&D@Raf
@PGF<D&CG@JC)A/<KaH8CUfK+YFL#1N,@OY[W]:NF:;T_E+B@3F4L5^HV2C&EICG
5<<;P^2#(d3K[4XAB/J&2QRP^(?2fg0ObEULG662L&3EY.KbR+RJ,K6fJdM4.G4X
>.>TJ[-VJ?O=VM<OJ0YcC(:,fBC=H[GAY^_Mf#e(RRbR+0UOL2USW[\5.\Y@09=O
OOSeOP>VM40K7(@MX#d]]8EH7#;9I>RK+=)W2,6\BHP<9^\0cA8e&W/6VaeLL@5>
ON/APDD=NJ3Oc8N0SX3=P+:/6^ME?Yf]/7#@P]gT4aLTb#@QS.U3S7CS&95XBb#_
,2WBNfU?#Z:@Pa:Re()JT8\&ULJLPCcAU>g3ga1@e:)V+YOf?W[_(=_D?MGBa7??W$
`endprotected
  
  
  // -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
3Z21CYUJDR4AdPe:V\.<g9CYFT776E(Ge0(Eg6EC\:eE(6<J&2//((c-?#W3V3(N
S5SN+Q60S#fR3<TZW(M7,)N\M.>R\c,&\PaLI_KW@a]EQK,_JA&(?^]+6:M=A>,=
)T?G0d]eV^OPIUO@3Ld,O:6/NTM?0_dgO4[XL(HH]MMf-g<>aH8J<1=,/-P1.D()
Z/g_.V@P:73d>cd\6e-,_<>?-[I5-4#ERG&K,/D<C0bR_)T<@2]EZQ1QS\SH<M@L
8:?dKA7\1J(A-+Z?=W>/,.fJcHGPR/UEY&REJ+\.E3VD9>;ZCU<(O0d\49V;^_/Q
b7,\9QMNL#c7gb1Cb/aO_-JM4N95O++MOG?V(P9?S])97G=.YI9g/99;g=_&#YK<
ca:c;-79#/:BQ4G9T-cc5227U9X+\/-.W4^D/L/9Eg+ZfYAf<P6I>B9gd^+-0XaZ
OAddg_;Z?ZfU]/2)A6T3Q^a.#5VDJYBda&4IJZ<P,L<9X?7aWKVTb\7NK:D,&D#R
731#M8O[1KKc;]1SG\\,8DY=gf-K-Da[,CDd0bT;f;C<V:YQH)M@SL:E;0f?KF#f
#YcQJcO4E<6QZYB#gQWEdR;Y@/>0L&UBLA;KKR+]P/+CHR<A[/Z7)E/2J26DP#c4
?U^>f,6.3GP]+9<MAB.A?R96F?89e&75e4:fWG)4[^cWTFYLF0TMJJ.7EE1QKUd1
eEWZ^.CZBP=W31:CN3HJ3gXZY<Sa(17.Y,N2F5]T@Me16+Z4_3N;e(&D+9cKGS1Q
REK4DL?eG<WS/O:D]^1&K:>:(gIfd?SBDYKH7.M8=Z4c.66S(J:g0+TK(U8/4A_8
b1FY7O&2K^LZE:&BgL=-S(=Fb-<FDF6)#9GF?e,DI\<2cf&G[UU8(X2d<8G@cKJP
V>VEMCV7OEC(2b]CDgGPd4Ob:M6b-\=-7J5+FBHK2Q68[HY(#:_Gf3M3LHYR/3DZ
=;L,(GE1HH@e0)8YV]e(I0#dMIP@],NBfI2S;G9J9/9/;-QJ\.<Wfc-O:&(g>e2X
faNL>8/aF_ce)L>E,@G]2I.]F-HQCB\,5U5G<7P9N)(44fSX:dU?2LXD_3-C#\Gb
1U;C^M:+ZWN3f,+,UFSVfOL7UWF8>PDA.^W(5_Nc+EF[GaCNDS^RZNQ]EHYQ6D]_
X&8Ba1WZL^-L^R(9Z8OM+T+1T29S&Q&G:SN#1F&&\@&U>E^^TeLZAVbfP92X^A&c
(Qa27:EL\F@VBOg@80>KTJNK0-6f_7;/8g;+^@&J=09?PC.bGBXKSf?00&SDVQ9N
T_M/R:),5b#,:IA_K^YSU\A93A>d5aeDE[:NTaD0Qd.H-JL4K?c3O3DEfE#M0C7>
0JZ.R0Z[0Z;a=M@4B=HUZ2a-9I2a.e&)fHVS6K9J_(d0WL])bXP3#DR/0g3F#g;;
(L/1DLX25d4);9=#d4a_@LF9?Q28(6[g:6Z(&&7_[)(1(^db;cF&1F[7=W2C9F;Z
R\d0[25ROX#Xg?\2B/5>B#g>1L4NMQfN:X/+P<cZY:@@\B;,;[,0Cb.5)C4f)Y0B
UdU-,2E(gT3M6c1@[O0,eP#)+F4TB/XD>D+P1ag)UP8Ud&[LZ)[:[Q?H[?I17Y7M
H.=N_+1Ab4MV1D@LKUBg1O)9_G9cA,(8,bbN\>X+2FLQ@[T/B;5S(@BNdWT:5Iab
S)1ENdeJ2TcOX;VN4U/Fa5T6T-@^6K:[G@e3QNb:G;N?1,ALJY(TW=XVOg&8OIJJ
,QgD]#)-LKZFc>(B9:>TGUDBZ655FACY@_GX/ES);gN<,-EegR[.W^;ge[)\.VdP
U,XeFg>N&@R6d=^+IQ5]aDIV>,0FTXYRZ0a8MINc]1)GFM1#^@@6_XWU?TRO^=OI
XC\W4]H-d1^M_#UX)>Tec1T)BMg?BK79\fRG7+T4>Y)4IBeI,-,]C+f#+d1Gg9U@
-#/JbV?:FZ7QVe,]Ra=eUT3#)D^&eS3ZdTKK^ND8=BH2B^[T-UfMaM=E3=bdX=0D
T((T++_T;U12f[&0NfWF&RD+\+RZPfCcS1S,?IJY5+?g.QTX2fHg#ZU89bSKe^GF
3]<+AXV:QZRcW?Y1;gA;JM[TIW1\.dLQ&#a1A/acRc9/;J2TbX4+EATBJJ_SY._b
e0B7^IBZZ.R)2d&662S5L=DE/?B2-[49#6)A[US7/EDW:2&d>,1aEfZ6#SCE;55K
50A+RRC2K/cOPRTYG\3c)?TJG>.]Y);J;D4=#ARb+<8G98=g>g1F<SWRH]PGX1P\
d(=:>8@gGU/;2,K^?VD[KPCONEF?^2RF63:U+UJ-AA@Y,6R;^^\TYA+ZP5-fA3f\
[RGE6;O6ITUT&FU@eabP[>6:F#Z;JA&J.(B4J=@NW?7L#9UW5M7L?b&aRG/0OM9.
dIG-c(?G[eCVN+]BW=#)PW;W2(K4dDHPJ0#Yca(>e/E&/QXYRgA#F-)>C9fFcA>V
SAb2[9Z5ae/&_<0MML9f&cH,<V29\YKJ)#^0^M^N_5PAY3230=Y;+L<fTR3[2g1e
Yg4V6f_5\e/YY?B#OX8QOIKU[EEdDG4VBb]?7c_+:[&Cd0#(0cE1ZFfg=ZK4#Y/d
M-b,0#;Y;:^_Z=B3V+R6JJVMRGEDF9A3MGe8E6KJDPfaf&9fU;CHFDP#\@Z_8T22
aC/D_6ZeSXWY=Vf0@7ZGE(,ROO<;\^4WS7fN:JXg/3G<>RdUT_]aRJI+VY<<.fSY
&N;YC)B.M0XWTM7d3D?R<I]T.gL^.EdB#N:3HG8VYFB1,c6&4JZ6)ON=1J[LKRRP
G^2YF0d6;0:+#INP--SOU_/4+^&b6gVf@/F&+9O?A4aYB3bT3@7K-TI_R_R:A>dP
GL^6>b+4)c(NLfSYQdV\B>;ULg@B?B2OgM5#7,;5SZLK@bO0X3][GGggM5265<MA
eYFZ/BL?1AJ?=JJTO+)MV&cIV68;36+YcPE:(S4\QD_(B>f9ca;1JZHNFMVHf3\6
EUV/OZT<FBQ/UVg:_,bFHg3Fb,S,HG&^cB,:T\JaNZH9.C;RW(]cV27.GcP6eL(<
I+R-+Og;NId6OTSVE:>#^,><+QCK>_d(2ZK[WGfJ.L4X5YgVN<-V\1&0H)aP\.#\
\G:/X^DKIX_EZ[OS?H>X3KQ>3,POJe6&I(AR&EYB(\DWD/\0[2+bbNBB7X9aVN+0
OK\]R)Q8T1[_JfTI]@ReR5M9UF,;0<C>+(fb/4)-=TNb?IDHIYa@X=#/;^PV=Q&Z
&f<WD,e83,E0+NdWBW;_B+11Qd48<G51TPX?[c[R5\-fX(0ARI]+D@]/Z6G/e/CS
Q6L3K@5,[Q8_\+\;fI4=(XV[;4M1>KJ/A80gE6cAGa[_RX7<E-1+56Ag?H.PSHBQ
f9W&#NN>]:](>0()/,-Lg^4@G_E.e[T<X3BF<G[Fae22A0AV=.We^.L11cNFJGUM
8)9=#>6;4][R4<=4[7&F)Jb4+>5>?@7RHOP-\b4fL4KX4BIH/7-(2U1_?=06?]R@
<8QTNB4^C429DUY5M>,:5QSJDAZ=4b]?-7<c(0RQI^;JK08HdX73O#_PR5/F8VU0
=J]HagXSR+C0P\E2IMA^gAN@Z@M\cTb4MPQX@e6)D+-B+O=FC#RfLZJOBbE>F-OX
;J:U7=H>fYRaB2[-e(8d#N?200KK.F)<3.K@Jb<IR<<^-&Ne52X.?@6eG[Z&[IG_
T[Q^fZB1;]-?E5?OG,e,)/./9Q<f^\MRX#>&)^37=edHc@&0FKMXUH,]6?bE#(>g
@-/E&,QE4a[;Z10d]A_.XSOAa4MN/BB4R3cb6PcLC#b5^[(f=Bg:Eb;ZBKX1V#@B
=1Bd7_Ca9)CUbU<dMaUEL>bP7W>G;&=Y&88OC\9<0;M;C,PU02<\7Hd-8SFI+YW5
7U[WI?aU4?FZ6AT:&F(&bR&]7,EJBQBb]@6)LW/[],R\CX?b0)]2AW.,B:BfU&d&
V9gPd6.CG0R,-(9F3P-E)ZZBG=V&?RM1R?UT^7K0B<NQK,=,Db96Cc4IR(0E_;>^
J)H7]cN-#IE[eWd@&_aL#5#cB5?ZW^;27#];HZB@(?-4:Q][3Fg&6Ld6PQ_^9YQ-
2d)7LW9,D^A#6/7[X\B;TFeS+X)f>.8-7D]+eX0;09gX2>?a9:@6AH5.Z988L6@2
W2K88]:UfK\S4_ZZGT[\O4bJaD_N?&G=CbC[5=GR#S?TIL;+^3eOe_CJPYQa/WD6
(RKBA]YbFGeb\a#O])[VP1Lf7B33ebf<[)&I\CRQU/LDA[+[F+;57Q:,>143eY+N
a>SBE2:E&+\O?8@aT(-Lf20=),]L,5-\<P?eK^>W8F?R,VYObRV^#M2.W_Ig\)8G
I821F.-GCBUE+4]de>eE=9VN_720YNR(L-2[Y[TN4QgF2cD)I-4UaQ)9IKQ<gG^>
ZK#2+U3(#]BC0=;bdKH4S)&#ZS>Hd199aWVO>TD;77dTR(:HRfM0N.M?bE0_fE]B
(7JgRbN,dE8+9g+fXF/)[:<=9@K;bBMLd2@d#[<FJ\33F0G>>/\[UT29)3:fa&L=
W.6Q#^0T9PM5QDK?d:JfCA,?8ZcB4X/VB?LGTg366:#Z<Bg.<Lc-TgGE7:CM+V^M
#;VOCLaegK+Y&HT[Oefb2^ZHB:D/7Q9GVeGQ.(CC]@#>-g<<U5&,M8:(WP/7S39c
#^=<P626e;Qb8L;0OUIV.dG^1:[O/\&C:_<0<=;JOZ:.<UWE;Og+2Y[;&:]>2d>:
6GD(OEJ,d>g56).TcN9,76B3<OG.@WEaQ>HS41&LeQ\3V/?VX>6\KVU&=<_<JVMH
+4]023DMA+,[+8W@A&^=.1]G@E=\Jg5dI+WUMV07NU;@U_K,(#cJbGb.Z09VC;^^
6QFLU_T<S-gKcR5SX@(=:SbGU0EIRN0ec-HS)e-aOZS(^Y(&\K,.aN:663CMGSM8
3N;PFL#Qf9E(WZ::4=<cg(3?Q&DE:=CB3<7=OH;EeN[V4871D[&5#5^3?gfgg;X4
Z^^&^K_2Og5:=C?OKKDU:(LIU>;<W+D]YQ87LVeM<M9#d+cGWY(VY//:^ODZ_NIR
78=(S)dfO1UBbHgNO#)7LEUJ]@23XE5.RS4Ubd#g-bC.0K.1K]@96?&e,C0-c+01
@I:4e5O,&@RGb7?0H9IB0<]6Y[Z4BUc^HL>2Dd(a=F(2WHXQU7O34DV<XfHg(#K]
<L>58ZZ[9If,#CFG.T;D_=BB(dR;7_M>04F7S5E<=CM]A,ZRHX<;GER(G6Q.a6gW
cENMNSJ>XN.=58C_)G->:F\DTfZ,SKRA3>M7,KPM?b<KedggZ[&SbT;/0M(9]#4N
edAX+7f?(Md9H&PEFD<GJYIKFbR]+Pf]31bI8J=5JY0];Y_.OUO6;9Yd4D@X^C+F
PgH-3eD0fS8e9Y1?F@5(K[6=S7O,H[&,HQM;J;IFG(=-gP=JRgL]9HCOD0eC-?Vc
Nb#C8Q5/N[_/NUV)W4Z;7adG29_Q=CFU-F]>,QI;5J:_aW>8?H1@UW;1QW44>076
B_gT/Fd5\SV/85[4FX([bM8fE<fg.F21VZ+,db\(ZS#RIcV(&:#\_Z6K11ZZ:fJe
:@e_<ZZV3[>-/P_W?J;K1NO4-19E,S?ZM8]:L-I-),FQ1ASE48;XWH)g?3:=_:fe
=MNDCGPAN.5A0d^M^_?Q2)d=Q,aR.3S4BE@T<b/V3BDFaE;(G+>f]gIBVLbA#/@&
&2/-0Tg3QbW=CLW#>MQbN(G9EAT6<I2EN\@2_]UEU[VTdKW?)#I<0;_7&:8<a3I3
C\@eQ4WEG?Z]^9f5+L))JR8057?T4=>+F\GDI,[/D];B3BbbRS2)#)Qfb^&Sc6\)
UUYZM\_=K1W@JVK2-DVM@]UeCg8^e0:/-E/(8645d5I-II.0LS<,WX@^O49?2J2+
X-@#5<dJKc,_#e\G[F,FG07@_]fFBB)RD7<=:YESX.96>C9I=J-?[=RE.ATX]<eV
V_/5/0\U6\=O-2;a0J:IJT3I]M-Q2,TKIZ&Z&WbFJN_-A(ReFN=EFM/U,a81@3D>
e;DDOdZDegcf[?D0D5JWQF7ZZ;OIA09Ja2;[4E8,Q1IHOEP1dAb^0=O<U\b;J;MW
JRF7T=RPPbZIgeKQBYBV)c66UD=27GF>M-,K<#K,CM8e>>.#O.cfCH@EXWH?<ZP.
geMY>?&R2_DbL#bU8aE4Yg@DGD]NcJZ=A1bcT\b031-gG.Se?UH8/4fIW,Q&LU/_
CgJ,P.A]9>\eHC;a)\Y[3:[;8JU2N:8\JB[FQ;PQb(gF73\HUWE@ENV=R).-UZ-O
9)9V,54C4eFY4@5X)M9C05OacO]XceQgCQbEf.9/)FF?BU6gSKB7,fP3Qc[5.ZM>
_RUHSCC02Ne7UQ>L23>TIdVZScEAJYgd0X3U(^X0Yf/(Hg-591CNP7.B9TX:0Y(&
<dDSO^&SDI;.4L]\,739^_Me:PNT(>WdY:ZR5g+PBV67aM=EN6/A0;N0^V3/B#Z>
>a(,Q4.7>M8?+790<dVf+B=Q3UY5UODf0TOc\Y_ef^cc[Sd86TfTKN<HW>TIN<M3
gIdY&U2MMH:_+g;++0O^=&fV2:d]2R<HE+X/cRW?LKHca7;Q9;K_BJ)e(E]-N(Wa
KC40RY:,KMEb/:U9ZM_S^9Y=c]1F2PKU)K8f4ef[G?>N+CRHG;:&dbECN??-)_OQ
EMW\+NcXYQ[EYf]d>;^+5XQ,;5>8Lf[#Lf8cH])Q)04/[T>@[Y2bV&9E8506bD\F
LVAcYX.&>T7[NAMM@4\OF,?WWT<PL;\#4Q]g<1OG&?9W&(YQO<@Yf[,JFR7>VG\Q
B4_EUW79=.]45PW/F<fK[#K&KPY=H[-RN,UU[9#+TaZIM,PU[QM=&f&J+a;.J2A7
b<g_BdGAQ9P&VT^K\HIaNG7UO]CS=D6M._&Z6+Y&9UN.HHCH5-2/&K0_I+V(fDH4
>9=4aNS9+,FR1<#EKI-HSHXI3\N/M^.3DE9^6_&b)X8aWM-F8=&12-0BU4F5V]56
TZ][IL]\7dBf-:H_#LF<4-&#(<AY\C^a1E+&UJM(bg[F2dHESL4fF2G)Z5?4J0;T
.2U(Td/Q85J5FW:gfST-.TTV7^F1CJb08gFfDRG_6)A#KE(/218dQD>1A7B4Db2:
#;0WAg,NaADQ0P2bNNLNYA0U]CV:?/6,?M=ZEAN<;F@G]G:+U&7HQPE\BUGB;AF8
L//.KDJ38[I>L@>J#d4\I8a)5X)IXGH-T_8T/8cDCNVfF3Rg0N9Va@.;7#T?E.B7
REg#f#OJYe9IVHV<-aTPQ][NGY0F<<RS3Y?3<5C\S]RX8RaJBJD_=T.X,JFSNW\W
WIYbE&U77\a#,=[G#L#;7=(7,]7QW+J<O>WZ++AdV-S--)8H?Oc?U5d<IH)PB9E@
e<GUE((f@@FVe>7,\LV?dPKVM_Pf_UFM=dH>UV7&HUTBDNIV/K)K5-?E1#a9gWF/
f0XDEMV,<KO;5XBRQU9FJYP#GSMQ5N<0/[9?L]K^K\HS3JIgMB5&SG.^61Qa-J3B
IgUPVH0H_U,Y=NV+#b>fabSTHWHU#bcI;<(EY^I10SSgB[1Fe)1G+3^L1ARS,X?2
?)-E-\.K(?&X49?&)3;K,0HAcEI#:+#^-c)3PcY5-&WDY9KC9]ae8\T&JK>X:#0\
GgY]K\eA,ecbQQ\\(]3bF1OAHHUWX=WQNV820#UAaKV_72=GKQN/MNOM^HKA5A?@
-DESNg(RJA>TQ+BZ^]F5e,/<9_fZaa/@S&c9].KUT6WJIAY85__7\[6+Z=>#1dG<
_R?]DBQD.C42g.X9<RHESBe:Ha1T-7E7++=-F@9L^N+0O7WX-JM&L/TC]6>VW2YH
aMf)1Q70##.g4f@XbX2O&]^[1fc4X9LeIP-dP.IGZOK95Q8(VW\R?(=Vg,>Ae8J\
KEg:-V\@6@4^-7O5S_@QI1/JI/dQLG0KG76MD(GLgL:CID(9)#XAgLG#+\:>0aIF
\=^&&5QX,#6H.QGH3PMeJQKS;ZE+gRY2.HXY\:>7^GX^C+JB=D][+(&@/^d?4&fL
VXNCY/.0HAQ8K+9H-G:BFQ<GKFV4J:=9H,7[e1Kb-H\]_HB\T9R0TENP0-9-O8Zd
IU6ET2fO1&\449<^g4VE=UJc#HEJG/B@<^/C88,@G^44&BCeVR\0_+a1?;ZSb:4O
I\0.@\2?/TM?5)dVV\7Z=0c),X__I>dQ7DQ36_I8/1;#,[;5ZVD/G&_?V[deHf0&
42)PE46;Fd2ZS<SV[.cI2Y:fKQU_g.8P<fA=,gO<+@_LB[eU>?Edf-9TUKL<2K/6
b9_4B#:NB25RY&(]@7G+&b[JeP3CJ4a?.-cK_\CcGF75^,684]7R,6S:Ad\aY;CH
VX43^gLZ@R&NaAHDHUB+FPAX)AAXgGeE-C/aL0F(4D-Yc^B6aa\bH\PU:0VSP/a_
aH_g<XQ@@<Yc@WA86-:151e[QffaJS1+5TY]e\8b8HNPBNYH59^:/-f?VNb9gae-
#,IXDbHRM.DNYCE5Y@^)[9DA93Q.P,5QL1LM0<(DKG)@+D5\PG1gb22L^UV?9^27
5.0=CQ?4+ZMP]G(2d2\K2:a;#58U/7fIXFXIfK[_Zgg&V>?K?d=OZDEPY#]JcI1E
a3/Pa/1PQ,+WT.D=8JY<eG/ZI2YDIQ;W28:O8UWcdS?#.2E0(eS2GAKC,3#PG[>Q
^#/E3+8#/Z\g)YZBS14bgbcX<@N,_+ZL.Y^e3GRU8L1#^Y\e&KX>RO?OfLUg.=(/
R)MHA,5b5+2>KF4?T6=<fK:S3?C^V7TB,(-E&.L155Q133Z9&(UDcQ=dZO/\@X+A
a-MQ?/\X1eW[+C+f6=D55c[B?)^4Y5]FH0VaEaJSD<(N2bJ@>9\]-d.DZS4-+2b&
[:\P.E\+<IYGN,]Qb6?PaU#A[R:AR^<]GT8dfT/:3-?AI-cPP>W>&1V_)1>f/g1-
We-dNN&;&F=CJf5:N2WIDI&c,>.c8.Hf^-1W2P#+R\P@7OGSU:P314YT.@b7E<,d
]3&]LX,L.M.<ge6.L.J/LK@/D2-g1f:HK;QM,d[@WOO_8;E39ZBUR;e;a@&[8b<W
O<8L84RH?WVQCeH\\f+G<J]P>)NIg6J#_4_c:MU?2[).+@XVSJ]>2D6_7F2Le^KM
Lfb237,Q,Qd7[9H\/HI5OT8Wd:3T>UJ_^/-9O]<\Fe#ARTG&2fKIa?:VTBLb.gV:
<DeBfdW&_W/WIN[U^J9ITQ]6L;?#,E>8\1D,G-SEG43;EXETaU1\O1^17^,MD@I]
]P=;5e/@L2G@ZT&H(TcPcB\-Qe^/QD_/9Qba#1g\EJ;NR.P5B\V+aD2<2a7((G_T
26\\SR5ELNA:[H(4R9:f??]#9+-2,TG#[eRETTeI-.TdRG_MJZ+<27-Ff0)egL?>
_6V/5I9AbbaA@Tc<2Zd]+X?F=EQK1+V?;dU6^K:>G<ReJC^.B#(=TLP5=N:K5W:.
FF6<E9b(6_SUD)=RJ]0+50WMAW#^aY-a-_O+8>.F=V5b-^\)c6223Kf_IV,P5LdO
3HN<QZ^2f78Bb(/,@E7fMH8YYF-8H@\KVP.?83V2b?HS(&e>3EXJef,.bX1W5JG7
ZW3Yb^_FQGKC31DfbIOCEJH,QNIb1\bGd>&INTWK>AJ,U<UXI#YTV_6^3<?)Y9M/
H:01S_B3Oe#7QHT1f6P7DRVV#G;4PAfM-^QS\bWaN&L)b4H+9<f3Xadf=(FH6e;5
Uf=8LdG5c;J),T3[5?M5dBc6fgHT\FZR5a@HP1J(4+Y(5]IC8U1C)?c_e.W\g-gB
eGPgcH,_c(35-30LEQ8^eV0\_;@:E^7^EFIXY5X0XT9TX_>d_5KEDPE:/ED8[B,H
WJd2\7UXRT[YQXE)@b^1c:9JY+Y7^0ZBFZIF1cQRH&,Y[\8#0,VW4;b:=/20=ZcO
<TPZ3bHN@38GXaOP]b3HU/dM_HCfF0FbR5?_>Bc.>T+7#N^fVa>2DJ(O.&RXdW?/
/WXR1CNEb59=;/=>]-/C(_<4De:<fGH0&()?8gS<G#.-=S-bc-XH3_S5)PA]Kb=g
eR.dODLI=PW>],3IFUHZ.<31K+J,>,C5UJ[UgIFa=8KO_=MX;)^2.L.\^dHU2X)Z
0bDN).;OS3JJD^HM#_N2W-SW+BP6RST^?AZ=3,<1FIZBBge2=3Eb4P3VDFKcDV0Z
HKO?9,P0Z0C_#_2e#&9_WYH4)13/94]W(EESH<)g75?S[aD,BW(_d,c]>,<_UPUP
8.)S5J^7Sd9PN+R[_<[57gbP^)Q^-f(#^-Gb^XJ&[:7f^#,&cDNR5Y#b)TO7Xf@/
^._4ENB+FUH3F]/1JG&Ic(3L4[0,)F]5?.eA.Y=0VOFc:]OH]XZE>&dY@]g36<./
V/D_K7_&cbc@K_V=O?_E1>HAX:#NAL[ZLTX2>0>Bf^RbbF,WOXX7f@PWSU&RM=PA
(7SG\8>1W1KgE+[3\GBHb/F\(=C1Nf\A<3^(fEe6,QT=YWV(09.g]MggVe^ggF&F
C;2/[2>Q<JTbC:S,H:a.;Q0]?&adV2H=Q@-4\YV1?T0A[)OMf)01W^Mg):aA6TR6
-3E9F1I)WF_=VMaf0)-#^)P?233g0-[K/=>I3^g:[#X-T?O<P[AG,,RHKEE3JZg2
^Eb4)#_+Kbf@LJ_[=,8-ae78MGEL:/0ACLgXgWf^@@_(T#FK:a<@RJ5R#>F=M-^]
Y>;RQGB8L(3Y^cY3c(7PG:8-29]8e?SgFD8475O_E/]=)/J0][bHK1\5Z(=GK>I?
)a&Ue/RR2V),]MdV6;6RfQb1>D5E-P1KV(P2fHPV^VC=Oe.KRQBG]_8e@RD^)VU3
:M7GRcJ8K&_IQ#+a&1Mb4b]FWZZV[-Z&.G,?(QaL2TbVN+1eRW]Q>f_2_OG;3EZ>
&BC;.Y7,8<[WEL..?AX1JB+daQB)S58^BUb,&g1g6JW_7gSf1(]-?B7KF6EBB=1d
8Ud#+7.S=JE1Q^b/F<UD<Tf+eJ^Q9f9@HA7+)<gB,X5D0+g+?4UMN7GINL?ZD&c:
ASGX\B;WTA,<>9AD=J]OB/:Q/C8:3R)bRT5Rd5AEg;2JS[_L]?4BN]<39<SG&>Bb
E>KRe.RZ\]CdG(IC+<Z8X_PXQTIgO/,]MLG.FU9F3S?M3d>U=.H)(cea@/MM9M2d
R/L3H^N[JR>ZO#=X/c@U0D5RC&NaVbbf/8/I>HdK6/EF9[]AI\_=69M2Z&)FX@^\
&\Ra\<]f)f-a0S9W0P2P[OI^^#cCI=U59MHaP_;8<c1fB+95<B>6aO/DU9W-ST_D
g2XWfaWUBbY[J,Kc1T5W8P=,aI#+G\Bc2VUXP?X7PB\^IF8U[Q[F]WN-&S#d08]N
DcZTXSb9NeY\]@@P-L_.AV1]H9DB;Y\T9B#cI<S^dC#^?)I-JJ-NU\MDFF8E-H2X
-)f^63Dd8-;H#OY>[,Of1GaXFDIaF8eZDgJ1):7=aQW,BC9SZ^0AOPa4CEJP4(1[
7fJ^HNFO2C5W[A7XO-?<^+[+EH=8[[ZF2=0EYKc3WePW:JHCR#cY5E>(-,O@.+Z1
M>M;YD/@FX??ZbdW)[1gN9E6U(S_2R+#JcQZ@1eL)<b9c_HG;cUVK,S_9#NO1^^B
BVG(L4R+ScY7K/_9;I2??1<<R86)1NG00_d+=414._,e-^\aCNR?Z:5;c>U>B1IC
ZV5]DKJHU@8=N3J(B<NGHc@=dJ3?P7:4eF/(;eN=L.dUC3KeRB3-(IDV#SI7]&0V
TA^>4I0Dg0L6I4474(,5KdP>=5K9DRRP-5L1P5V^M-PX?/_O+Z\.X?2fT_dJ._IB
^0Y()QXdgXL._#=<-6F41[3&aa+R[5N@VWO8QX8d&4+B97X2bga<c3N]Pd7cH9EL
]g?4PBL?</dg[:>12-SaY17W52]RUI5/[-NXIXHB]IcdTaN[?\6#Q12R(P72Y.b2
&3EKYNDGIP?](-N&cd.KOC@?_?RUNSE3<N2^gRCDI4_#bZIQR<KP;IP.KM:__LTF
1=gT-HMN+M&^_g:3C=g&R7g?KeT5OC+47=RW2b5Sd]63,7]?T_f&e9d)-AA.<RgF
:E:NB>#7ZIMSJRGC3AS]@N7=CVH^_6S.aFV)W];KQ@fEaU7eXW]RFcZ,,:_fL/()
5@_RK&E.#NgDE8N]@fYJe3<]J.4fa5;\\1e,.W##:B-CI/M2(ZK_3C-]@M\6e5^Q
Tcbd8[L462G+]d45[CN57@.\G)CJOB8R1\f=?-LXN0V;PGO^J1-&>LD8FVA+IHLF
OA2<f<(H9R]K>S74H&U/?4^b8f)/&36I)]#_f#XQ+1F5@<:2\V#fT2bYIHAW]>68
)JdTR32I&AMZF([8]Y5Uc\(U6H)+WBF.7>]^?[Qbedf;YA9=6@Y7fX]9fC,OZ_<6
[G5<N&GJRadeP-L(Z23?eYE0YM.,>L(KAgV&_YVa0)d/5K_(T(RO6JX\3]S@>/:3
d,@cP/8&HT;.JgA.&/M(\=1#WT3a,_Qc-Y>GF_\M/-E^0d2dMLCC=Z4)c7b]Ke#G
5J270[CI)[>Q/\f;]L:2V0f#S9XV;a)-6fe3:@&FX&=&fHM8-K)ATD[Z_@aYfY[U
VRP7UB#90]eFN,F5J8dQ/Z^0U6PF,IZXXN:Y[0)aM+OUH&0Vg^TT@?V3A=TPbE&_
VcZ6GLS47U2O/>AZQ)],08+g/@D]J+;P8f.3&AQV2U^K@/H^KS=P?V#CEVN[6V(L
0B^CD#\9]0?BeW[LG-TeSMS2g:&6,.[J64dK,_a,IB95I]N1I)NNb<>?:7&d7fEE
;ZcMf.V8G0&PU8[5<2gZH<PZaZ#K9G>=AAW#V^G2V8)0_K/;&f;EWT+HYXZU49cN
7L(81E]MPMYC22HcW;,@6PeXOVb^4W:/9TW[6?ZfeGY:A\g;WFIQ4HYN_]SaVfIM
IE,RG9_3?^6(U2MWP[>NC9aI#Q7g4DV-3X2>Z8G&RX^E;^RI\[K(3@&-I5H#GGUQ
6:T(H8S4<CJMC\+0((X09X2GN[#IJ;Z,4;=[C/:X0938GT<FWACB\=cQ,P&LcK76
]:e\7_Q(5?H11Y64&df?@IAVbdb6F21W;VUWT@P.\_(ZfAXYY,g8B7:de8gG=U?J
K&e<-M^)9NPN5[J7<ZbG[N-L8TC\WC.eQ2?-HeF?/^_:]DXP3PDB;L1]U/V(Le=#
[</b.dMVfXB/(=D]T#5.]&7cfd1Hf)@VYL6;F\^X</[;g[)IL0e5.R?:/CWOSa+Q
&9ELU^-T(_6K==2(OH7^c9M)TG=AE-dfHO+]PEY:,I)6)<]KS)@deV9&XOg/3g>9
MW]95\=J5fULEc@@dHN_U0Z8]De6S>\M2LeO#WOGSQ\BRVJ9.RU=9.V,>0QNB@0;
^134,)-_GRXTSP\EL2+9EF@,ZP6W>]2faJY<8K8FPZEH>#Q4Z;MCT2^Od<V4&)&A
=Q#>?3WUg9EW;&<C&9>cC4dSSF#a^&/RRNb)?]G<NdX8dV0a&F0TSX+;L>>03/\A
W]5Y)+1a@3LJLeb-J?6N<ZFb];^1>7KdfS[/a9dG)7-9c@P\U,db)^.)W;;DQH?P
),L,\=:ZZMR1GD9eSD97Q]e5W=3#N>.PaT6eQOgDQXC)H;#g^#La=bg)fI05&W=X
=3<cQA#M^Ucc7g#?@8Je^ab/_T^WK3@R(^9C7O,+Hd?2PNL.H#&HT6S5W?C:MP&2
+3JLHgI8VG?VQ;RgPDC&PD6G6H6VMA#5bafgV.Uf^?^/Q[9N&(e98V7Q.UNBHK+F
(Z:<:@I[dZc3ZeOHVgZS-U07D1/1dJbKdM>ZYc0;#OY8SHFE@:?R_[-QEI^_e5BB
SLeCa\a/KLFOf3<KKD5V9P9+8Q.@>e5fRDM8OZX4[(fGgIb<d]Y@+\d(?9Z4<,,6
G_@P<B3(#Jf8HS?QaP3#Nd2DL@LERS#@9>X.RI=VZ]LE>^CR5+IC.d64UG8)QZY;
NUE?5;9ITT88#?_^[T^YJ]B4S2-=MX0)W6a2CO?RO3X0MCJ7?49L>(KFfTG/-+Gg
-:CG_@c[2-6]&b+bGAW4FSR(bGMBa/K&SV+\-08C1&[5,U.EN5gW<3EMBW/3(G#B
BVBG7Yc6@J39:)YI>b<T&gFUfO_R@8V4JE7=<KdLd+M9Ac:cAQ1[7.MOLMNC;+DX
A7(9Q<Rf7--\Z#E]0,THg9YP-?262f&O?f_LM;/+IRIVeEIc,Dga#L:D(,2+[OP[
C(LKd:;\FUN_/?<S6E\N][SgB#W_fN5;FAaXRW_9D+(5MJe([cQ7S;a0KDD+A894
/##O(:9PL^gB6I/1]K1CSc(8)6^ET@CX@$
`endprotected


`endif // GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
