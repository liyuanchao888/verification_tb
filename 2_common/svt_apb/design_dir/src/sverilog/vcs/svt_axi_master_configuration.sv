`ifndef GUARD_SVT_AXI_MASTER_CONFIGURATION_SV
`define GUARD_SVT_AXI_MASTER_CONFIGURATION_SV

/**
  * This class contains configuration details for the master.
  */
class svt_axi_master_configuration extends svt_axi_port_configuration;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
    * Default value of RREADY signal. 
    * <b>type:</b> Dynamic 
    */
  rand bit default_rready = 1;

  /** 
    * Default value of BREADY signal. 
    * <b>type:</b> Dynamic 
    */
  rand bit default_bready = 1;

  /** When the VALID signal of the write address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum write_addr_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** When the VALID signal of the write data channel is low, all other signals 
    * (except the READY signal) in that channel will take this value. 
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum write_data_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** When the VALID signal of the read address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum read_addr_chan_idle_val = INACTIVE_CHAN_LOW_VAL;

  /** If this parameter is set, the master checks for any outstanding 
    * transaction with an overlapping address before sending a transaction.
    * If there is any such outstanding transaction, the master will wait
    * for it to complete before sending a transaction.
    * <b>type:</b> Static 
    */
  rand bit addr_overlap_check_enable = 0;

  // **********************************************
  // Configuration parameters for STREAM interface
  // **********************************************

  /** Setting this parameter to 1, enables the generation of a
    * byte stream type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit byte_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * continuous aligned type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit continuous_aligned_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * continuous un-aligned type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit continuous_unaligned_stream_enable = 1;

  /** Setting this parameter to 1, enables the generation of a
    * a sparse type of data stream. 
    * Applicable only when svt_axi_port_configuration::axi_interface_type 
    * is AXI4_STREAM.
    * <b>type:</b> Static 
    */
  rand bit sparse_stream_enable = 1;

//vcs_vip_protect
`protected
S?f0>5=(W#MS3YLYOb[^1=D6:AKI8<L2B:9JPN2_cTeVEK6FT3OU3(FH-_A<UTUW
382MdIT-RE/g1C6UQG3aKUH/5TNSX)\BS3Bc>WKK5K#J#HI237eKG;RWU(W=d9)a
-U1V>Z((5J+,;EXU<f7Z#WH[Ngf0T-FA21#1Q->fXTYLV(e-.;X,E2f6W:M-Y#J,
,(_NPeI0<(J5RLcE.4Le.>6CKH+S/@1+#Aab-g-9_<U#Rb2U]Z&]M>24HALA?=^2
_0b?+@\[R&]TO8[-&HD0a_(0YKb6#EO/ZI1D0Pd)TOK@E)<O3)YE1.IHU=RAY\(=
&+KVUb_DQaQ@A;,\B^e=/Vf<X6=M.8LG[dMCP0?^-@TN&FSYPPYL]DE1/5I4;N]L
(S<_RY&fYff(cWf/8SK10b+?aRE<eF<>]^]?4+UO/Z5SQ-]U_4\f)<,(,CaZ+[Y?
XUF7B?DF)ZWW.;G]P(IJIG/ONa1A+NQ\>,OcC;QPDc,EHaPWV=U81MJ],<,>>OHG
)FL_\fF_;\?a\Z?:YV/g#=0/A(:@)BZ9P/T;3@Y8Q7UO>U=?]JL3:ICI?O,\VP?5
?S)RIc:7;3gO.X5&&LVSJ:>G;L,;;.]&,7K=e:A.^-gPfZKC+JKMMZR3R(-d:M#7
RU-Id@VOgWY+f^YTLQBAagLeUe9IZEQB.8LD\ZF:A)BAW9IE_bNaZYB928[ccf;D
bWC>]KQON]46&aM-\Qe/5E(7e,@@)0X-5.)_++cfVERFb[=I6N#0N;+L(DPg.G>V
[NX]#LUd6KSFFWBcDK32]Me]SObc_[#3UEGfOce2NJF>(95S^VfE?cD8dI[4+_2W
;)PC/V):1.U>(#Y7K^8^LH[Sg4+UVZJ/F,\:IL,(ae.B)C:Ke2PNK4G12eg]#H:d
R0XdR49a3.7AY^?f?/G-a,7<0;HTDNJC3@G>EU41<W>.>L]6Q9:gW/^aS8-@M-Ve
c6f#Fc-X.&AW1YX@P1088:/4X-#/7@[+W;&/5L+Z-^3@V6I+=;JO)-:V>+_V</<I
R-c>K#L;Z(PVZ#2R]NL+Z?^BX@RY@[LR63A14+LUV[Y3:Y::YITgIL4IF.#T:&&c
V_J]@0[Ib/]/@28fG[^4Z@/(FRGV+9NP[HMYXH#g]=X(7J42f0:083@P[/EeI]<S
TW=d5.[C(,eTUX)/,2_+I=FDBDW6D..#]bDeVD^IL#DKXFQ7NRC5-111R2E=Nd-P
.V>@4IU&Ue7.-O8Tc]NBEDfaVE_[UU15UX(FLYT6b3807T#6d,C\;F8XV\?dIK4&
E]\f\<9\=eB&G44FN4G6821Jg;M.)FUCZ-F2O#@VB8d#5IgC590UIOI@40@Uefa<
./\CQ=>XN]^4WZ7D>)U/e91c2C]G9TWZ@9L2T_[dML8<G3Y,R@5I@^32;/WNV5JM
L-0L)<O[TC8A>@KOOP<BbIU??&HN1@OeSU)<]5?2E]eW_N<(>@ITHJ;gUW]?:]56
WSdD/W\]L9#[70UWf=/fQ71a7]+)1O\F,(047.[Hb^=AG/HL7TVY)UD/DID;3[#,
b;7OF_?/bLaP>()6+&4H2D0\aO_cM-.dd@&ccGOU<\-YFSA,/NE95Ya^(5[3JP3N
fH5X6V:@7f)DGA4J;&Z#^31H+EK7EFCR1O;;g?3#E#A[aWEYQebR_D:#VKJHcF?X
9T2H1AXc+;,/T272I4R][31-X]85S+66<#Mg[[W)DN-@L:1I(HX,XOadEW,ESLa]
C_&#f3:MCD[PN4GG4?98[5;B;F+--B_F;a(<Jfd;,[J4.]FU0GR7R<\aV&874AND
;F]C[af2AZd.<3YgbD2TCX.1JTa9E]>\eIBPEFQ3URJT=VV@?S@.cN#TJf&0MN<H
)E^V1H1+4B]-W4cPg59+:7ASTK?TMUBU:40(=Ee2Xb)#:+f8I>G=-,-]IE#A-_-F
/@FI)PJ&H#L#WT3_H9.d<.LBT>,?_bT.:^XNTV^-\J+].&0c+W-/b]<S:?d]:6FK
f^1-F4ZFQSD[@2,YL8JP\3RC(dY.T8cD<24B_PXNR9]RWLZ,]?TAg8/6?]d?RFAf
C3OSQ1PO]\&#f@Uc;9Jb,&.9]X1B<_?W55.[+]E4M=T0V.QVcR&UX+-JK0--48g0
44C)e<HF5)-;,BVCU7@^;@Z:T]7H?Vb>\-3TP3F+>MFL0?O<^0?)@+]#UTBJ8.L>
DC1NVcLdfK:gdbO=c.C[4Bag42T\Q0Y^ZMG^<2PXHLcDHZ@5F,J\\J7(OX)A9/?N
fIbXGAV3HE<@<U__e0^7L1Z\7b\3Y-gIEWWYJb+RN-I\S-1FYJdI35XD/XTJJg-\
_<]ZAB5U94<d.W9:7>:15f^@+XDXd5U:/PB@aFJ/BW)QIZAgd]KZR>Ee2]W>_@Pb
.\H0Q#D=72=Q3W0eS)ZCI)<B&.aS;..BMI)/8CIZ&GE3:]+_,04_Y[6Cf1e:S>[=
NEg;.g;G4IET3V0=]M&D.J,6(0S9K&Nd&DU8f=U9?HaF_XWFIVQ>2=Qa_Q&&5OS3
E=c#M.[^B0-4,C73A=(EVeEBTIU3:;eB9:=)P?P;dC.UP?6ZZH0.1Vc)He.]<<)8
EHR(OZM9F5+,?IE04&F^8PXGFC85G8=99/cV_=#QK-E.@^g;8BUE^5H/<caK4L0_
YbC6HPWcX.E7WLD_)^g]OK3bYRW54BFURa[c/AO=@OMQIfELH.[-#Z7SK=G]W_5X
V@[Z<2-J(\2-7PL[877\I)g+-)1.3g]L3Z]HVYRDbKJQG^13f96TcSD3&5TfIMJ;
ZZ;e_AV[K2H(T&-I]_a4#gU-#eM0>eRUU,N#KPALU5T79^_XY\3)4J(?@/PaKe2.
4EJN&g88Z]fac-?Ec\Y-V?O0\:W.]ZIC&WB[RI+5;3T[c8Og))Pcf/=L+FCZa^a1
D==aQ9L5.6Z\MGLMLcP+Y\28Gg18CbBFD?W#<7=<_.Y,7UNS=[beF@:H2:H7e@;U
[Y]P_SG/P^&?UA;1=/TS@+ca@D=6IbRNMNQc7F>#7.-TFQ<dZ]T6b//74=Z_dB]V
>KNM+XcB(8-\-.c[@914;SI:Cf0d87B/S\:E6b:HDYQT1QS3J\/:4/9YJd>:2FCI
bK6g;]Z5;R>BBBR=eSN&5-D_GAa:>1)68e@0TI<F&]&b)ATXYW8#]2NcLHQbYb;f
.P:#Q/BA:D(2SWL4W9X-MJ&9.-O_A5G,ZJM\a;#A?FL<ga+\L:TC0X5W34MR_7A#
e7^-,TR(74]eBZG2G;]4]b&97$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate 
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_master_configuration");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate 
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_master_configuration");
`else
`svt_vmm_data_new(svt_axi_master_configuration)
  extern function new (vmm_log log = null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_master_configuration)

  `svt_data_member_end(svt_axi_master_configuration)

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
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static 
    * configuration members. All other kind values result in a return value of
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  // ---------------------------------------------------------------------------
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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);

`endif

  //----------------------------------------------------------------------------
  /** Used to turn static config param randomization on/off as a block. */
  extern virtual function int static_rand_mode ( bit on_off ); 
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /**
    * Method to turn reasonable constraints on/off as a block.
    */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /** Used to do a basic validation of this configuration object. */

  extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
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
  extern virtual function svt_pattern do_allocate_pattern();

endclass

// -----------------------------------------------------------------------------

/**
Utility methods definition of svt_axi_master_configuration class
*/


`protected
aWUS+U@<U#b.c/97GfeV<0]:g>7fJ:=DEZ2\=-_JS\H?P3d]X;\^6)^d.6\abdcU
9Z]AO9FgHbP5V&Y4)K8X\?E/Oe;)ZU+@XN6;FSQWW1?J.&U>8/bMHAFIDXd&S_\K
S=c?,F\M8EN^KFG?^0;bM0>4;&Rc(DC,8Vfd.e7MM<8R04bcgZ-93NVG^&Lf>O04
)[QZ[Jb4OIT;L.Eea<NS\BS-F#=3/(;2V\bIdDE,?OF7+8#f/:WdZXg<P?(CMd+B
),M3PH1->;0cA@G@aV9AD-Be.HQHfA;AR[39F;O2KW6&]?&QB;;fAg2OU[L4f6_3
+[H=gf6e6+HS06/g@8PQ7MZQ-L[L5Y7Fff\cF?7Q5(WK<MfQE@)0fFd@R@S:d5-L
2b1NSD-a9fZDSEO05YHY>+47gcO8a6DB^?M5&N-e>W2gA#G[@GZTQJC=P9>KTdP5
QN7>)/NfS]\-@RA1:&+^9c7U,7\Va=;e_\-aCURWC.-Y]0^QCH2)EFQ9:M&F5ZUW
9QE1,EQ@c-FFG#U+e<H-Q,Ce)EIPcNbe16JAFH;^b#VXAP-@,\ZfX-&J-#AFSUEM
dJ.OI]FT2/@5d02_8E_TDL13Y.?QX>EV.R7,c[Og-(b-?<]\Nb1BPHP+EY&.C9[a
KOXYIZS?b>T[YL^71\d[cA-T.FEC0^[g#+aR1&/(8b7V__A-=HM1PRP+L$
`endprotected


//------------------------------------------------------------------------------
//vcs_vip_protect
`protected
O1-#V?XV7/DBOCA9ad5)MK;5=K4dI53[;1AOP)<KJV4>GW<:,R?.5(V+?MS8JM6J
:.+-,aUAGGX4J\BY=-<++50.T4.+>RCeeUDZCQ5W(57UXI;&>D4C=e_bCaV@SZ8X
V?I0>\=ZO\@a,A9\_[6FB]68(Q]AO:^-93PF0cR?CS&dHH@GZ52F@AG5f</e-_4B
<-G&1<\.2>&B&P?[9@HO+)Y8I0A<[/\@.I9FZT_B^J<CLI&4YG,4GeO5R<<fe>98
3+I&dJ\./9D<S+IQ/#.][g?L&N>X&KB:_\^.EV+LHC)B]-.,P(dY,W3XCYe0b&@>
Qbb(Z:?Z1,EA>]O[(?(DPC2O-:BKF-f[E5JW;4T[gXDcMaLYS(fg6/NWZS3/22fY
2+g&2bFNF^E)I4JOVU2#4>[/K/3E9DLAASS>+.U<FTIR.:X4S-=68Xf0F6CCOYL#
?Q8M0(DCQ\]a(+&K#P<\;LRM0Lb/#\H5=-B9/JXZHQ8#U,d2Zb8G&[_E&Q2APE2M
MS^3S/#D-8&S/3,feL8MISM(GBRV/@XY8C[b)5b&+46I(WF>B)6Mf@ET_H1fHU6W
@7K5/3aXPG=P+P_SeeR\/UD^ggFdPB)D\;6\CRV9b+ZO_WAJI]R9O3<e(a[&(<Y5
/fS]@g;I\/.S?f);YL]BNa]N@BA><bM>Uca2]0D,2BB>S?+IE=Oe@>:Lb(]V8D:4
a,&7#<4d?I_,[_W1fbY=@g\?dXHg3fUV]TeNKCe0([X[0&)13f:,W>I7JYT&1K2?
gCWIIBFRM/(b0>,TAfVSWdOQEOND-c]\U(^^bHZ2V6;=51/MZV)O5,R41NLIJ5/0
E@Z<W#e@SSKX3R<WZ/<fd/W0Y<MQ#C./I_1DA.dc/74CZUD820&]71?1Wf\^a.ZF
J>H6]9JR]0X[5<SdLULg,3=d&a^ebE7FT2.8(RWYB/YENKK+^Kd/P=EL)XP6FRB1
LA[A=7(7DR@eMc7_65R[9aM,,SfbZE+a/<;?:QYCHDA-/[0f<6DUH<JL/aG7U;1F
EgARgY3E0W_M@>^WB^KHbf34PG[0SZ0He\M&MKCDd^dC\A4a6OONY@U74H@?>Z#G
5L?I^@S:6YBNZ&JAZ5EQ[&&;?9b:<^>,O46(ObE#d4<[=YM76d^d_IH=bU@3P[I]
8bL)\1AZaY/EWcKQ[CV\/?gJ]/BN1Y4]fgfU+\C5+#>?eNI^bWU)GJ+\Ha=g5U#E
][00CAe(a2GJ#(N75:c&\W0OK0N7W>3=L;6#Y,U@5(1dQ+c;70ZM3(2FRLK?/E:&
7b#(8D;X4a;-Re)?^Dc7(6]I\#<4f_UPe.+=N0B/FNRBYWFRSB0P@g/MKS[]Ee9R
a&\0;[UU>cX[.EQ34+4ZI\GE1HcMTBZ69][8F@YH[^9(6DRQc_4>dA)^T-8H;U;3
T@Z4ZI3(Z7GCf.4]JM@VJ5#9;6YTXG4f8;(M79Y>D<N;2fNRe3YKLS[V&3(S[&Gb
NY+#\:7I;>,,I)--6EFM_ZcS_UNQTJb,bebB7;M&_[D\,BFZ?e2,X\-QIEKQ^3CA
QfYeD?VIAIJWBg9N_+<-#B7PS:4fB0?NA]1f2e+HS;SVF[/.1e[R6MM((A-5bK99
FT@+3d+T(b(b3SC0&(/90L/UWWQPgO7C1CeKTY&@PJ=7P>EFS#&:IXO5cBcMV4/M
?6&P2A@aJ,@61Fdd(/6HSd_N>d(YLY<_;:ZVF=U@O<8ZBYRbO/83eR8C8MF,Dcc(
VJ#QAVE7N2>>3M=9<[9(_61VGbB?]XY_CKU9V9/))+/J7AfCTO=:cQdCH>M-6Y,+
D]/(UV5\NJdJG?bMfWN<F4acW5X7M>XP5Wg[@G+0g:;4aXVK.@IUQL2cR;W@OQI9
#a9<T&,5\ISd4PfR^BS+Ffff7fbY=VM#G9aRS;7)SEW2;NON\/LPLc<;^/\9f28Y
]e.,)M2Yg_62NJY]T1;E,+/0,-gT>^23VcV)35]W]cR,9LX6:617^@;Q-8=<75OB
I7&e66FcV&<d/a73.:V<C:)L[,U?;Y<bYfMN^K;G9&#A8@g(9G^b1DC.[5\((_QM
TI(@Z/P1MN^[>bU>^:,35P/=^EI@)-?3_[\_)+JAEDZE&:LEZQX0a^.d^KQZHc[0
K\<e<A4NS-gMgI#]41<\Z?_4^.7B5dW0[<H5bD_VJ>4H\N<(M3L]DU2E^=L&H9ZU
18?FaLeg(/7+G@2GU\MB+IMNBWgWfW+Ia4d3Z/b<H>+Aa;8Ace=aIP?YS>@<cS<:
.L1dU&1.R[Q,2G\+?A8=6:aP=05#P)f>B:3:7+_DJ.]V7A;ME7,\=NFAB>,:5>b5
S/=Nc9>3/M+b[LQDQJ(NWXC()3?@5YSM#P^TPZ>\2ZB=+VYA?[MYESg&/F+D17#V
gX>M>,(X08g.NGS.:_U,37]QYY_-d4BYPfY6a&gL>0&a)&YaORUCPc#YD5J;R)=@
)DcPN5K\&cPHPN,I#=6135Q^aDd>DSVN8?-SACI3E829RHJXg.?c1_TbP1P=(]Z2
Af=Z#8I=M1daP=]b4>YC6]&.GG(/712TPE:KeN83+-L/9R:JdeGPO\S3HX]<HY12
R&a[42]FA/aT69YYXG@4GUfCcLG&&W0EFL;_-&2:3GaA>ZU0<,^If;NZN\/-M08d
,e#-K<<3Y(Db[>BQYMg]CNZb_G1KAZWE5T1N8QBNdDO\7G5GF=B>A2N;M&bJ.:>/
Y[V2G])T.-N)Qa[]Z&BKB0(7>VAac=/NaL?,C@#8OM#\X942&9dYd:d@EP_?gO?1
7[FbJGUPJV&PVT+FS\^I=,f#BW;T&<ad\@Xg,LT7@__7AK^(S^@1fZc&QN8XaJV2
_Y<.,D<JdW4CH/f>cTV>?00PY;);GXZcH+g8:O^#gNGLIec>0P83f@N[f9_+e#\(
?G2[S1g;+]#O^7K/_;>QO^630KgB5P8[FS\&J+0FP,]QXU6>=L+\C+Gg8BJN]Z@1
Q)^+0&1B.Q+HF^N6GHL_VbQZPJ?:N]N[?=bcS#8:<gXOU=Z:H/0/C,[;M-EbeGW/
TWN4M00EY8#61DC^Ra_<ED&fd@G(>]Y67O8&g.=4:V)54cH4&c:Ud-Y-RefC8Y)/
KcH(_,I4VF:JdUZf,O(AJBZd5BULUI]gSQJF@@G+MVTI.V0T,;8G_XEaJ)2EW#29
bad=C:ggZ]\&R]1LT>Z]AL4KcT-KU4\g-M.a9/)&)\T42Y[e3J-aSWf=7NA[g2FB
[4400;b](/.QQDN^><PJ28(K)I:Q]I0JLKQb3R;QB1-L;87eeAZ?DM8@E][R+C0f
67dY_RQLOI<fYa4:TA;NPP[a+5(DFC^cBOF:K3[0);<e>L+HP<b]==E2f>[D30aZ
>bgXF7>gM<J7-C8;aH7[16E7I?XbG0X/4;[L5,@W]_RD4TRH8[Lg)ZK=IZBSbT>a
>S,.XfdLX;#/6AG4OTZ55REMFW7Fd53Mf.E0/W3=;;^aD_ON0:cK<N1.e0^V)aD]
]9:^e:<45HIH#&]fE;ZHaZ,gWO0]05X)Q+8R4bK6JK412.UFWWTbGCB,:U4@BC;_
3H,TC>>FG8TdO@I,.Vc.dK(eIF;8bS]5;)PdJDKgU4bX0UKd(>L;.8aHg^?CO[+)
3b:6+WVS-c4CA)_A4EU7P1](9QF3?a@,<IU=)-Ve?\04HI?EIbO,D0PQPF&e\6b9
-J8I-AHU6RZRD<Yd.U;M1Xgg]fR-EQ6G1a3f,::6,]U2NHYO<@G7GEXFQ6W_bBK6
+TJ3K9;887Y.H5##^e/?Q0TX9#T4H^=>W,-\:4Q:_+C</Ed,]#\ZV,@)J-PXNFY>
_=dR&7RS)=55R&G[LMZ;4ccI[DB3:?31]V-fEHU0NUg.V?gW)-4RcQFG3U]Vad,G
3+Z57=eK4O<&:[BB],G\O/Qc3f#:<&fNI_5#dEHd:BIaFcG3-KUbCCA8Q2__]CHd
c;HHWeV[0U)U5Z8<D(FGV>9gL,?(eBK--[KP<W:g;6eP+<T^TgDS;,MG#NHJK.R\
.H@W<R-A)g3CJ,.-#(863X[1HT6ZBYRc,@.B33g;e7UET-TAS-MBR.YQ12b0S=L6
7G>)0+FD2@cCRI&4&SOgE.VcRL-\d9MBU=CFED&ga1aR1_DSABdUH;[.LW1]eEO9
I.^;f>Y<+7@Q<edIIK8CNPPFJ5&DS9dCUXM)8\KD_cU2MO_VE,8;Z.dNYY,_YD0^
RB(f;MT(QbJZ9O()B[UFg:cIH&W^LPPDcP5NRegP4=E-IUf;.MA;H)CTOX^XR>GN
UR0<I-B)8Ye+1_<b3)1cB:GJNWPJ0eeG0Db?:@9U45&4,<TERQ7X/GF:O<-3c\G6
fUKN]P6/Z_Qb/-Z;I31D6>S\Xb=#<3C6_,6Z&:?1=7A&_4EI[G>bcVIX8M/#EE,P
Q?Y)f#eA7XJ)?Z2UO)<C-BL.S:J;O/U\B-C?IO-Q,]fG#F.0HNbFU#J-4;E2QPTR
X(?4+PF(>;E[\\fa21U:7[aEMFf+,I\4fK4D>RI3Zc\=\9eRW>,c3)4@[D&7V7&b
;\FgK/K0CDFFIK.UFZgW(b:\YOgFO^I^EbPC^>QI:b?>f<_@bJ.?SG_,\9VO@700
]fZTB/CUeW5<_W1dIZ^BV=@EHADVWJ:_ET4ADZ5Gde47-=(.:YM1KH0JbUV9f_5K
AE<gfN>M^.Ka@=^NJT3&1edP8Q10R9TWC8S3?cfNIXL<TP0KIGO&M.aRQOG:]DE3
8A-9g+-VSOR(-=S3Se6C,1d7T:7U3TL@^QJH3T6G_LDY8VKCK+VP(B9_,55aE)(-
D^K73-#&DOg?IYeG&ZH1/fE+?_:41)O?77I(5PCWU/>SWbY\f-HXeA>aFD+J1FOW
2GX/#=WL)R^3/VC?8B_#@1M&)dH;@^1UU#QLbZ\SMWFL/4,#_N#0((L1K?_(AI8[
PDQ?\+&@6.a?(a2PB1e1NZA980A>E\ZHO;R>gN3S81,1AXHIMBb3f&E(Ng11]C:M
LT\^K1b@bE@/GVW9(]:/TQAb6,0OQ(=;X\cUa-7/N9Q^;V.;;aX.F#5[1VIba\11
5NFM\?DdT16I_Q.0)SffAHHU;\,7A9SO/.#JQf(X>O0IMRSab3EIS)VSbFff)2-+
LTTL[W6S91g^1WM?KHdTK#9MBFe6[eUZ6OO0WQ7=VW?NMY^AT3KG=[[-JW@XGT(O
\2RG2IdE#3CM:8>-Nec43?Q\Y4V3X=_\^;.:U_VV5Rb#MMG5D8N]_dR<++>J>PE/
N+NGES-[T^]I73<aP[MIXg2),WU.c801gA_H^KH[,EJ3M6)?g7ILJ\SVeMC6CE-\
TT+FC;^9C<D=&,UP2gK_CMF/^e<)3:Zf20[QMEE]:Dga+&,E;B\;WaM<:eJZ<S&/
,II8O9dL\PfCZZ0CWUcg^ea#WL?V/MJ][EUQHG-R.5EN^=HPUW;HIBf^97d\YBL1
K,W;=_ER[7S1>2@KQ.L[K_B-;O]Vf#d3g_.:b?YAS7,S9)f^)#.OX4B4=WZ9-Gc\
3\9ZV2Y^:[]J^P+?-&>4af811,Q#X0_@OG?/OM1EULfNaMFaAd.6DMfX4(FEV=6g
U^S68)c-/7cO[6.HR5O=G4OX]I7_K))?\C,UF^T&HS0(.@3]4M<B_0A#AZ)4ed7]
-40.^D)3gAW,X2TU>6_-J+G052DD[d<70CL/DNX6VJb5C3/d#5A18&)9RX^36Lc?
]_3?J//J^ea49UB@7YRf[,;C&f5SK\Ob7ZN)R_,S7II81E54+8E2KI8d&JCK<GXU
+Eg<##=PCbMe0fQN+I=5CEf<ZdNe^d96KHAC4_6-8=)SV:/8c;=2W@e_>XB&<3A=
?<MU/HVT8?LAPEIaV.3>]2>eLG>#(KI;/^-ORR9D1/3J_IIS6]A.-:MdS;OL?)<C
Kaf3JW0f050b35ZJb#3BYG(1<XacDV8WNIZYW_2#>V.Q1=BGJ)K<M>\@W8_4AU(f
,JTYQHf::]UYbF=W)D>ee0D=c-CQ\NaTK^R2]#Ad7JXfHM=d.eFed1dECVB=VH)Q
B6_]bB361A]7W?cO46FN0c2HbDAD)2&.Rf@DE)&7]IZe2-(5K3@DBEddgAgB(W:X
>1V[)3P5)^W=NTSLMC;Y(6gE]);?X&H>],C3T,1-@.N3;A?6M(c)b9;X#7Ha[RES
[>a=)AFZ;O[gDXT>7[3K?/7NWQ6.V1V,3d=PC?>JSa=@O^(Z(+?6Ae]Q:gH0X2F&
d(/Cg,[<H78g9>7@-VN4C2D)7C?O-J+@fG#_HHG&]Cb5.]ZQ=I^._+4C=N08cd0<
=@DaHM#CM1]CA[DJRFeF(HO[,B(D9=+;TSLcMaZZM6#[,8B:2L8Vb1;/5)0^+K4.
+XRdf&&(>.d)P^N]8.Q99C8N1C_:Y0OA+7)6/A>I+E#b?DJC>b>?E1OCLZWD;.CP
<e9\R4VW\b?_];PYQ5?6H:NHQ;QU,<8GXPT23IYFJ22/1OG]0U\KLa[]S:=;15?D
Z4_@]B#YBZS_Y4dMG#(^]YgRaY5S75?(RA;Wd-P/=R\KX;gD2Bf]6X.2FVa?<LYU
^b@L&^F756Q?Ye-/b6>-TK/H_OFeL1L;++V=Ld,9aSX380a]W87+<G,Q@D&.3L^a
STgbPHMOJe;I<UbMLMe8EIE0=YUN2&dDP4X0UKW4/O_T89YfMUS->++c7&P=CcX6
OQRBX1#0WFLe@Cb:-bY416ba^K91fF0bGUP)H9J\&>0]JUQ#?\JTB6R1.da&17M5
a3D[]N5;)EB6(dCZ,^eNNV/(]6=A:JU,-@LDM&QF^<P(=^XC97d6d;cS:;>,=Xa)
Vdd+R-X;=cQEF0IRBX=I@#L=BHcM,f;):RYRN:5(DS_.YQX?2XA=)AP;(>RW1)SV
]]M@A6a83IBgO?0.ZE:LEJb:[\.>(.A>NAS59TbQ\1QL?M<LQZ6WaRVHD-2QUBML
Z^R#HONcdcC^bU/V1]+DL<N&&Zcf]d4&M:f(&SE,;1][OB@6\1R_NKd9Qff>X(gf
#/(Cd>^;;,ffQOSQK[DDB0=D1d4969,^OX[,O_^\7Q,M/^4UVCUWUA.cc54#=>b#
X0>=UV,5b)#g1PW0SG,P_d?B,6+M#0#4(4cKFFVB+g;S+R(:5+19=B@cUH9=A^;#
4XRN\3Jg&#aYcE6=(5dg&3EIVQ5O4HO]&86I5P.68)E;I6YK]/C);9cHZ/c(VP[Q
FE\=7+(04.\IQ>A=E&-:-_bQ4=P2Z>M6VAET?(BES,MNC=SFJFPQ_-Qa6^P_DQ#>
c9;eYCZ#P:O)<&4b_J\:W[_2/9?a9A]6=Nc#:9CW[f3BI:C&C\b#GC]75()2O02-
C,Z@KJMH8UMB2S<J3?Z[Q>1&#N<TLe_QMS=]/.XYfG27I,JI4J<EbTM55[e2><KW
Z-7Y>-W/cQ740K]MASJM+_R.GNOT:;N/A^La.OcF1f;/bZSG[W^3ME#>Y<//#-(L
:,8Sf?FPVgYVJ8-K.<FNIW(H[MW=1)6SXG?e@Kdc,gZYN(]H,KUWB-MB:gbI4H,7
B6VIE?DR<Ne96V-N-3FI2P1CgUe^0;??^e[7E#OeU^G\DM;;HdY5#XT\Y2MaGSgA
e+ZJ3c?2/E[&=(H9<7UB23H^@[3?8N,RP8_/?PJ3_=/_&885FGf:X4UI]&^,;@N^
c^fCR)L/TddVTQR0)Za):6A>1a[I&aQ@\SY[+Z;E;PD4CabM^aRd9<0gZU(]DGaJ
/J-c^g2WUE&&0-)J13B=32Y9<)d^,+HP+7JQ#AJMcOIS>_RJ&OD-VNL=a,eS0_#a
I<9BV&DHXF.<TI?G\WZ>SB4PG)^5P&&;(7;7EdLYSgDC-(5S8L5XD>[PAMeFML4#
..4X4;8@Y:GEL#](8Cf(ZMD1C-QN0Kd0^-2#;71f-85E&-O@1_UXEPXIM7X821gM
CGV.NR_&N0)7H13CWgCA?W5K#4_.H)+:Sg?+gbeES=8/3O?6/[928F</GY9WeJOe
U0<I.fc96;Z6Q#5;,g7D]7GbSGJF8@QI/=.d>b48[+ZPS:5R7=1S1_Ud4^J^AWM)
ef-+Pc&1FOGC]Y>:V\>X=&GTZ_>KC[>QE#0-<PJ&bJc?PB1Gc2JCVT#T]?QWYO9V
V@F;+4T3U_8;2Z3QAY\<AA9X2Z100QRaK91>G-)UX&)9;JZeERK.=a01#D+2HMbJ
;V43Jfb::;5<)caL[D68g((I@C8&c^IbfXg>[gW9)(@G<0L]JD=J76H7PG\C-)f7
a3b?[D4P2BI_Q,=FM415P]Lb?g<&?(c5SAJ1<0H3.S^gN)=^48PZ@/4:J^^aEUb)
fAGT^Dd+&?VDP@?XSMD7&6:M5cKYX5/+XIMg)9>[=,cEH3:#?_<+Rb7d60:d-:9_
e0f9P-</EO-J-7R<>WCV@J;E^]fQR/JCKWXefD)e?EFE?+/,UB<dfbES&RGE8E4+
^&#[U4E(6DM[2LS0L7J(KafMQGGE?NV3+6D)0_RB[;&^&M;D3)+3M3Af)3W6G;7L
a]).AWY6bJWEb&2TV6>SHR&(5H7g3/O70[B+O:00=)F9.(E0eWOV?VG.<.Y(=A.)
a.bg?R2a3\00@@7Ie4FQRd2,/H&:OUeZ-Og&>(g@@+GLg#4UMSO3K@H86g_eEYCb
6+):EJGZODA/Z62,fZT/,#_ODA\D>6f>F;UW-<b8g#W6P,+,O9W)e<a,G;SU_8IE
2M[.1RMM@eceJ7\PG9ZJ/.H7e=,F)N7C-:71JPEc^,J8bJP_6HY-M/PIG&I3EE2Y
ZZ_c.bN:d])2H^]FcVD)@a^;ZM0IDgIS^GcD&0^F/Z=&G7,/>U]1VO^\J),81\.D
EE7;=,DX/=TJ_^2&<^Da&63?>,Tg_[6Y:U5Me_)eMRQQ+aO,XQ[FHEPGT2<#+SNG
O,D>N^PDEO2B+Q)YcMG=cRYSEc#.(/8Uda0bVgaH,WceRC8GK=F5L84-U6#;e#1N
BJ0(7aI+97#8PM-ZW>>BSP(<-L@(ZVB;+fUL#^eF5/L@aZ<-[&DaEge2B8Ec4gDV
U6]6ac7>KdSRDE).C[FOA)O[&;(4F#.17#UR=VZ^BPeS2[E;]3@_BOD2fLb8<XOa
?3b.=EA6U5@JbW[4.Y0Y=(GdTIC5HULcO]0JQ7ZU5VG9VeEN.DP>aWeWcY07Z\GY
@7]cbZ=US9(I+355_+T4Qf-1#VH<;-)0Y.H4BHQQ;6_X?8SD=P64LGdK,?fO#,_9
PG-RO:@2P49MF6Hca3?#3;Q;?VSWC6\Z9Lf;)&b<O3bAB;9g8BT\V8fEXK=]._b]
CUSU(Y/N3:#TD\Rc42,_+9+^W\c<d<XH.5Q.4H&=Z4C2UE[e4a4/&K>\<.U4b7b.
^T_CEY,&63\Xf/9V^L[LXZF;1:@&#E?Pa2S?QXZ<Z2/K/Zf.#/bM]NQM4Y)G&]IR
F/D2/&RY[&>eYTXNL]FRVYScMWAVg@/WLa:Xff?KO),;M6Q9BQcafMJc9c-L+1Q3
PE+X]7KP])cRKE7ARZc7gCIOTSL_]C8JOe\AO,JKYLdENNBg[?NVP)QU6.g[4/)\
IaY7b3&M7<77\_3H&RVN^]]b+>JeSad?53?@_YHD2_W:_EE=<-Q_0]EN#0#N,_/D
WX1+b<WT.?3)gTA&1]83b+b80AaR)d?(:]3YFAEGe5-d,DgQYJ9ZFY2FCOeb\</.
J=B^.>60^Z6D8,406/&b:7f:0U1U<2Ha+e?V5./2C3Y4D=Qc2WdL@8)_E<(>QX19
(Dc<GJ\D0M8^<>KNR6F9,ZYO)>V/O(LOSR-/K-[,dGE(WSN+5SG2F6GS/7)CKd_Q
83KL0V_Cb0DXJ.1J.C#6E1^Y]\^:cWSA6_-VeBN9)Q_fI\@DMR-,ST8UaVTXTENE
;dQ9\9T/EQ3e9C9K(OZ;X/YGXb:YD8I7d7U5-@<<]^C)#SB^,-J]V6ODVePJa0?V
XdaW_;NE@8I:ZcNQAU[fSM,.3H;JK3(KX6-0)H2EW?A>Se@H:WcU-KFf+-N_E7G(
g(+46)]-6I(f4&R<7)9CVY;N<K3IH5Ca&K.E.2(;(>&OM\4\K,D7@.R7E8-G58OE
NM2XZ]V-M:_2,>O(PdGfL5.OZT8=/2dUe+[+6LQEQ9CaRWgD>ELHB8QPHV0@:=/g
@6H40=K/ZbZPS@WDa]N<Ne>GAV-5[.?0\SH7S6\7FJ-_eF63GG8]766B1<eeOD.3
g^MQ9C]]XHf=T=.Q4^>+Gc8&D+;Q2caL@,a?JD+ebM9:S(?f,X?:A?>^F_MU]bPU
9Q,F&c^X2)\XNS:6[^_S\U53<PBf\5dI6N408c[?,=2,GSJP#P=_QZJ;:eN8\0AE
-geRG:@X8GV2:&:7=O=T8[ZHYN3ScXP&)M>/;;7)38?=0DJ-1Nf]5U4SDSGJf<H<
f\Q=D8NgECOKONHHfbP#>Ue009@Z1\D6;>6VdP>Hg(>[J0EFOG<:Y)CLHC#+Ib?G
=W+K^^4II0XRU##>/45W,??^(<8+-S)9f(3[LD/;;8PDGUcY:YeP649T_LgDC?)M
fcK7ff^_]O2WX9N\3]&_Qg7\UE+&7R/&_N6H2.-\+KLe97Z>#4:aF,0DW1;/0(>D
K\B_V1O_Yb[:/A7Sd^T5HOWIGWMd)NK(&1FP\=?)8L=-ISSYH#If>/6N\14eYB_@
=b-K?V\FNFeNeJ#eT]4RKYc[9>;MDF.JYMU3dEdBa_d6G?Zd#4L_AW=+/HEd+]?X
bEJ]/.;0TS>PNL7>[>37F]@KTJPS^52.71;aF&\G[2(NVeR]G+311^A<(B6I368A
+TfFWU.RT(5@)>+T2J)4540VN86c#X&0Rd8[>IeZ\LNYZdY27c6N(E0PPV2JTSF-
)g<5-;gRIReR/,E+T6f)W=4)R0>K?F(d]=^4K0^Q_URVL=XgR<YZc)W3P7L@>B2L
D\;B(cTFQ<+MDGS&1#4H>]gf1<@;Z_R<,P8RB=A>CI5J]LT5]:e6_b(3a53BYOKd
\d(CDg(D]HQ:&)\JJ7.6?^R-L8#]390cHgS:8d4],_^7-5>Y)5+(>5]0X>15X4T:
>ZS3.S?-6,,Z)7P&6S#=>.bS,0YH;ZM>PC71MFfC/P-gD:bcDd(5a?:^QBfea>cA
:9EWM6[_F.NJ2);[1/cSNC5#<8&,ed6_IU_0YR7?,N#]e/V+/FW-cQ+6UHZ+Ya?_
;N1N\A6I=8LTNPQ8_]Z,6,N<N.@&[,HYD.dC(,O;I=8Agf,IPQB4Tb7112+>Qb=C
g9N2CH6I3a_6GS\,;4Ra\G+1TRME9I@Q(#EU]E89SRabH:]?&(W(MC4[=D<8,,DV
K;U4K+(+g:..LC(ZL/2g(T;.8=O=f,,Oeg_VEX9KV2b1APAA#f)8^2cSLM@;2Bg.
HHIb^4C=UH=1T;:.FP&8D7L^;4aZf;@?/J8WX.#eG(_B_W^+M+YXLP;^<VWcHJ2d
NL5VL.Q^B6=.A36KL8I;-L97R<ZC2\Q.;&a:<5,+6J[E]N5JF-/]EJ+SU35TQ8bS
1AF4<fY?</91[X)5\D3ET3&1,f^PJ@3H^6RW/IX8Q^O=TV:)9>GgF8:B?\AaSB/X
JJ\IZID_g_LW3_f04OO,MF[5LdMV/^4V^C^CWIYPZgB3\8=DN\8@FFcCg3\ZR:,K
<+7M4>()JY:O;b\:dICPXZ18=?8KV_d7;,#S6>T/c+81g<@c#M7+7bEZ@4>S:^FG
6O:[d9<P,O0OFU/(5f+>GOA2F1TY,7;V377BQCT(4[,+f/a\,I?EY7C/dX0:PWIc
__N4^gF(\DV^Le+>1+VCSYcOA:3fgWC,++G8MGCQMXJMcFA@BK?]0WE<RA=-1T8d
;eZ9Z1^<CdH(ZNQ<e)3ICQd2_B#P/Y#PcLYg&O_dI^E/^5AGg]V2dAZ#65Y?)2cJ
3=N^RA#XY9J9Q#1WcEa96W+dPX4\?&5JESPA.P;f&D-=RX(Q0YD\VA9-YAJEDSL0
V&.QHDV\B,9&7.(H20X5d(VL^1Z,69/@.4R5)HEL&Y9QbYA1HFQf4eeI+CHD>7DE
GM9LWI<E[Q(OLIeN:J,8=_[84PA)Z(dV-]=.6JX8^J;\1;Z5YSfUT#O(69?M0L[K
)S,6?0(d@Hg4JDE[<KTRe(Ag>H27d80^&=^PW^C0Jea9\_2cH\+<MJ=Q3U5]A8(W
LYXB&.Z-P:4.HG/?/D4:)]IS\d/Z&e73+d,NVNW1<&M@48d?_fgc2V(9e/#NN\SB
,[=a]E1T@\>]1>6SJ?Z:A/1J-4C5@<@09B7YEZ;#KQaJ7QS0]c@U=I)WKZb.,2CL
3/&YJ[T;ZSN/WJGF[8/fN&Mf)e?Q5FZ2=?9ZRSM5:[(,>R);6/),KV_KbJU>\^_5
0f[CG\GM9]_c5ZJYP3J_OM8<(1?7]Z9N>[[OZ:/SV6M6RG/e[&.U2QI#]-G8@>-Z
UBB?=1\7B(5.\(N#b\G8c,\+#\+9=)\N[<8;S)HPLE5C4fb_GSG<BL:2F9IQCEQG
)YVO=EaTNXO-KN&N6#OC1JV=,c.+5Gf#?O-S+A7[9eS65[Mc(J;:3CfCY(>248]H
R,FP\eDa.#4-B#Cd&QF>7H^GdH:CG;f7;K)^8HJ2M07A?6aJT)5PaY2Ee4=,adId
KHYD#b3/@LUJ__V;H&2IR13U34O[#A4_V<VPP>3B^C))YM9E]I1]/)\CB7]8S<;C
HN):C_4Q>SXd=@c8PfdX]H2COIXS0ga4;1SOR.LML<=]gTND(\^VSXJ^75@LOICM
G\4&c)8I)25BK##SEPd=[UDV#=\b57MQS^URK\3_LA:C(G714JKQ+1R]>VeT/=M,
Y;P=7:^N.UX=.NJRT3.-4?L)cT9CGc-+<L,]F>:W@Cd_FdTU2a-7b<.fL.DS?Q-U
YW4^+N]ZJgA7+M4O<EI>f,Wc?NaMB#dbH)@[IA]G1W,(-dP+]UVYUY]LH0>Kbf(F
;[0M5ZGUL/><&Y&MLEP\A<5:TYGA/cPGFD:5W_M&^.fUXa+7D_e\KV-Q,9_bc9<X
YD>=CZ3V>SSXfPA\\/S:f7XC^EcW<?aW88D+JGHS3O.73WdZe8#^-;>ZLRTJcPMS
=XGLfd&=TTWL6T1:,=9S\I3LNFC196/MR@?_5^1MCHG2,#L1]GWa8KEFabZ+MCeg
LCb_#A9RGQ-S,=[1XA=&)(b<(GF.9E?03);^2.N@M.Nc4<g2aG7+-66\>KL&(O?S
bXeY+\[I^@)eCJ2_GbCR&@<A]<MfOXGKbLc/P=OAaJ@,MSO,HWCP;AV6^XLUQ5O=
555fUSCUPHKQC4bY>eC),/f;dA+^f7SG9.X8?DUH;TFbA<@PaUOcL/FE1H[2QD,#
ab:,^ZcY(]YcMZ=^cU^YXBEa,P,;LcNFE86MO<aSSea<P04X#/4B/WAQUIWc8->6
/d#1LT1N+@^MC(F9UL>;ebP2;-A9D4M))0-I=e<.PVH[:&F&L=S.JWR\HM&6&6T_
O7)27AONNKYP?UN[9HGW-g_\f;8NV4LD?/Lf#B>X7UF\#U3^GIK+EAXWab^-),T\
@TJOJ_9d,]@8FbLaHC8X1S3F0QEUD+E.b#VeN;WFUOU>7@@fe)]2Z^fTKN7I-(_;
50fVE@10.\1e3QNX+CeT351T)&S3#@NT)G]>((2_@:AL8\\eAfX/Gb31IU3RbN3=
Se6ZFXH:)b/Y+g98_1:]f;>>^CU)HaAEECf]AHgU01FgLOI7gM:8&N_fYV@FgF<W
#(;>3Z#I=5aZCRP^9Q(,^DIUbQ:@>#FZ(HG(R&fU96Ng.d.9PN6>U]S\bDCI&JKa
ET+KI,I5TG]#8cMB,LD0\9)?,;.>J6V16MdY885>,eaK-:VD_:16gDdY4#BZ=X&S
e,.e#(?-T@L]K=fVPFQ/U7D\@@(Y7Q^Ma^=34U@37,(3:X9OM\K<C?Rd@b0Be&@c
1T\bZWeO;gb@#GDWg.MIL]MJ4P3IS>KDL.GVFCLc,&c5?ON(/=E.^[c;LbeZg3L/
W4M]?_ODE#HbX)cS+5JH.JOI7)PWd-R2D2DJK<C1/LJf&>F0C;&:<_H\N9YA#UC6
_P]1LKg=:ICUJYI8S]dc.,RU4NURZW_@)^QZc]?A=E=U-1PDdV=dQF8S7(J9[fZS
=NDTQ8d-1<CK\J?+A5WN/\AAKG?PC/cIa,?N(NR3,,^6Y/,L#F-.O]F2P+R77#4(
[f75FDCM8=A\f@E8+=GX0S(W9P4SOcQ>Z774.O<MI)RN\H@Je[M=/G^TV&2=,.ON
ZaH2X/d0(QS)4EM<35NWa99N)H,?3/UY@):1S)-\faB/R2VTA)G^f3(0;0)?P1B0
=@DJe/.TD;B7>0C##4V_\_V65RORJW?78OZ\5D1H(+fUQ]QP8+4eFO;8NIdIc\:?
-3HgG@WC>P)U6E4T<PGWUKXN^U?I@<Y\Q)<3ff@C&a;-PI#4MK6@(]c(Pd+4LU^W
,KY@3,aY2>9a8[3.D^?ZTRSD-O^AO/a9)HQTNc\EWCe?B2TT2&A73g+^ALR_EIK3
?7H(FR^Ng2X&RUF+RSMQ53H;VFGc?P;ILF?YW7)QfW7A=M/G,gc+C_dJ2@R]^OF3
-3B76V@-4:\DT_eJJVZ#[HG,XWS7#L[:9YSV^W9MJXBYUX/2+3^8E0E-,>2+5\^.
#&JI7,776U/@>Z0KW)SS&DR+2@F5V88g@5NO4d^&g]@4T+B[)Y4&/;IY.Va1K\BL
7Zf^]?T\65]Bb(YX,76VJg^5\+@Y.:e81&-f#\?83XS8Q;,.T(X(J#<SKa@/cVC?
eMX9[g4&9E0GSb]9I9bUJ[[]&0/N7TLgN5fUa_][COeIWg/Z:70[VSFJ)/D=d?>W
XC;^:W,3VA_U3T7/[ZXUP_/(\/=LVFa(SR&,)aIgYI5@\^&(?A;7)S0Pd?2](^Y@
X4=)@XF23=G+I?2)-.-60[0OO]^<XG.5HX6.Og2GX8g)F;H=IRPJ9cNEfDf\g,[]
/ENMJ>&65A(\Pb-//GE,-_+]<8>>>eaWDYTO\SV=HHTJD;<)fUU>IDQ2SbD+0Lf[
_H<(MZ_71&+GSEQ/[K\:98ULG7gP.b#^,:6^VJB+06:>J6d@4931]NYBH0PW@AV]
=W6DF-1f#a7<ZF3O=-Z.NK=,fFLQHc-&O426aQR5eHZDb+S\(Z@G1VOP6cb[FDNH
:D;R4=N[424Q<0DbWCGR+NPE6WI>[#c1F0g:.eD+_a6X;#R=PH/FVM2G)_-,c(LU
e_<=#6K9d-GIV^W=1K\:>D/Ig^+^7g9<fP<@RIWGH.?M&d_+Ra1T,:#\dDgTK^@J
]FX4LHE8E:[c/;JYX,/bDM98bV?g&,;2^;4fV+gS(+F(8bSL\JL74?Y^F7)&X:I9
PT0P6?OOMe&#Fd_C\D.;G^P^OS::\4U&;b0cXZF?A,N,UMQB^c5TJBHb5_cS;[GV
eWK;Jb^[D>P,AV^d6C;YH@fGGO<E<Dce<&RMXgCafG,DVb5F69S6W,U:T&YSF/WW
>1)I-#,b);c<7A42+EQK06?QCPIHJ4RBL;T>_d/T&/6&>ZH0X5Kd_7f-PUbZTVR5
P)+eP;=8DD/M-EG+A(QFS?29aV35,:e:AGcX#,\L5(dR>AD9(J)4XX,DV@LNB302
Lg\ee)aDdPE>1(K=ET7NQ],Ha-FeL3>O\9E[5OW_G@KHWEe,C]<18<Hd#U^R>-Q6
&CQb7LMZ7P35bO:E.&eE:JU?Q=Jb\@NfG4W\Q<;EG.37^V(W5g3>c=)2LI&-1SF=
,fBQSO^IUE6R[a<=2;0RTV5QXZ>GCBa^JF;,Qf<A;(gG.MR7X&aIf&6PZ:2d8EB?
7)3D8A@Q53TP>G[&6eQ\49P0-]HZ2[H@V37<O\<Tg#>\_fb7]8.O1?#aBRSP.<<6
F>AMf@_0dLf+H3;>2eI?/Rf@(JNeCb@DN(;P^3WH#PUNeM8MY(R3FDFL.JE+&aC9
HBcHY[Q<7<e@S0/@+6B5[Q[C,^a#ZP(.AZPDgZNb&;a[5:8#@KaT]CP^]dBfC05K
(_5e]/KJ2/gR#U#38PHL#ad:)-e+V^6UZ\?&KUd7V[7_D&\YfO_QX^;[72(O<6:.
>VJ8]\30NUg\3^?,N4EVOQ,XAV500Z25\B(P>1/CUC>UKCecNfVfIP65RY.G4L73
TK9K9S+[9//5Z4dRPC#d7LM,W/TI/F3g[8E:&ZD//8CgJ:/N(MgAHFc>AGM-\1-B
62:E>\9ZNE)@4#9Dc<WARQ6LJ;?KV=/,(95UPH,L_&6R8&3Og28]e<78YOdW\79Z
MN)CY(+HPP_7JG_+(KYC2-RIbE\+Acg<:,14KW&E9gP-ab0+?a3K8+HV+WOS&>K3
MRQ3[I&I/bdU(/18]D7_\N#3I,;E]1?ZMA,?M>Q[]&BW\;6TY#b^=E3]b+9VfgD6
WBP[M8;@19)7C]OG]2]S]Hfe206BKD@8MTaBbR7>^(NHF]];61+@>^>\5-9a0)5W
>;d49SGR#\T-4\#LJ.0SQ)NaI;cG?:Vc_GYS:#4f9:#dJdDIf[QK4SNbKT@YY-fG
^/1[;O18/\LBN6K^._?31O7DF],\\g2AP-X#EV+;REJKdS\+3,;]MbfBBFSN]U+2
Q]ZFW?cZ81V+JFK1CYR36#e6a-?fKGWOG]EQ/;N..Y8cTEJ8L6.9S/=:-A<3WE_&
(5A2PT5Q:gbP\#WTCV(eX+aFVcKRMYIHb,>eF=/7.7C=;Sa<W&UD8Y#aZ]K78c[G
R1aa/I.OJP;Y<B+.a>L_#gEaLNdYOWP\_R#0?3]Ogg<XF2/:_a5O?3VV]/W0T3Bd
OO;aZDH;AR-_AII.::Z(e)Y7eO3@IT7SXTDS9DFLaYFLJZ8I#A0COfE=/2CN+9+.
a>B(Hd.;VTg\Qg(Scf[1GV;/DfSFVgX&6CFQ@6[+)RY/7f/F5eL[FH)4HF.2&G6]
ZC;K#fZ^<1#G_(UP\MdM,3E5Ib_1O,+Q)5/YgeUMQD^=HFCDUS5Fe[SYZ,EB5QNJ
e,]8NGc.f#KcYfcT>;?1J5Wa4D^Q8TP;W@Fa/D+[dV)YX7237A&@4F9L;LE?2MLP
O2=X,,J>:\?J(CE&W([WU546HZN)IR0dN#Z.()7X0g9R^,eLW#W3\/O4A5)c3&0F
[;\1D\f_J/]^VgJg5Z6KH(;GH1:06?8T8=E+1,:^e;/R@-Vb7(FAF_0&MT=f>c7.
BZP(+7[@eM8]>3P=5?T.IS<g2eRb\._QTUBBJ8eW-GV\T5-gIK@.KVdLdD+(P_-J
e5E[8f>ZJ];[/GPgK/dgJ&+3[gcC1M>B2WQBE8_AVc_-?-5bJ4M:HGgH\7/Q()I<
6>V++I&(eG3dO:RP\,F&b-+EX<I1NaHLR/SPa8ae.A-0[.J4=/.]GQ7G@RU#efUI
#Z9TKbFf#eV#Eb9P4Ke45g?CF,WH3#cWc\d3aF8J=9b&:5UW8]:52UJ\D?e&c)Tg
I;:O0VW98:.fAg5J?Ld_W=N_8^S+B9=^f0fa)\#aHU:8Y9:M5,]P\G+QY[SK<@e;
PN&Db6eZVCFB2L\I?b8ICJI6SEH>\+TVNS,Z)I[]PSGA<P/Y]^c2Gb0#47TCNdL_
[[aZ(aX=-\f^F,#^dEaKD-Wg2BBT6cD;A87g5FF2LU/&(SIGNZ^FH)6+,8L_gT(8
C-VW2K/]7aQLTB0X:./QGJM,CGNV;HEXGGg8)Q>:HU]/1&]OLf9gg::>3W:SS)(C
]5c(B@6Ng_M_be?a-85Ja8(O2Jb[2VCe&[Y;>D5A=97b>E_N-dO0;148O-FEGbPB
IUHAYEa(B7eP-\Z/_1\-d&8;@e0<<U,OU7.)aY^F_.4-5aN5=6RMMaE,&YYNCC(_
L&U4;]Q;P2>E9>\f->R0NGC3U,_H=]QFI(<LY4gA#]g347GH.G56EJ/KVB;A9V2?
A=Z^QI_Pb9Q9S?]_F=YHG\L^S1-Gb,@__9A\U&c@()4]T7eMPEZHY>bH8.&/29c<
/L([.X+ac)D])SHI&\<7RD_3<c0&EBa=dMMK0=JWBfYgDYC-@SfT:N<;gIR+9&D7
PaC:4,2a.26@Y&J1]?6g@(bTL_X7#)9#cHJ(=>+NF/;J6CbRMPV-860&(AQJXFOb
NF65<N,P>R8#TSNbWH0NPA=>O>UT6GJF(SJL1ab8=FCfXQVQ5]KcW9g,@#KC@K>e
VEdR&UVZ/)SMF0f+e#M79Z57KEa<_ba)1b0.BN6UX3Ig8-]&(Ldc_/C0>M[C_AX8
7W?PFP5I7B^g/-F3#PRFE6Q10Jg@^_X90.DAZ5gK.8@826Z6]E?CEV)2_.d_1?XK
Bd53b-J:Ic\FFa=GB3H\GFa3(S6VZ-3A8U3,fcd_VL6Z6/CWHVcE\8;Y^M#;EFBg
c<V>Nag<aNEN[bTBDF^+3)TA##7<@5)2PMW(<-8bVgf7If1E]eXQ<SXK+F&cDg/(
#VA.>LED5fK@fD82@4:]AdFQ_Z8f9B.gHbK.@CbK4;[:9[(V&6U0H<SeB;6T-G7Z
;3P>#M:52,K\@=(/7@E#9S#)af<&dZV\LLS(IeOOGWP:XQGNb]B,4d366&O.;UOE
P:ICVSB+M5/CX#gH15g:6\;P8^OMWPN-&(d=a^^D=.D.Ha47SeJ;HVFf6K6G=XJ[
;_M[W[<N,GLGL;LYQfBL1&=Y?YefDPZ0)IR\]Sf&<CWW>:8b>3&(IMTC0?9@RZSJ
H\b]0PZfUK&=1\XcD.8R#&6;2CY^8A:301P[P2G83WFSTfD\HaL,Ya5dg5<>5^f6
d\XW/O,A=:G5WgPS=H[>(=2EXJYaB]4(9U#]BKSU(R^Y8,LR/H7H(RJ?BdF?DZWf
6\YW/X^,X>^39@U(5?FbKd4;8cVX(9U?0N;aP/3_MLA-@/(f&N(/YecRD75ZDBaE
,Y3U<c9[+2ce=S(+A[@>I,@HJYQ0F\T3LFG^4W4;0ZCaH@YSc78(;UTf_B]73KX#
Rg?7@NND?@)P4:E5O#483VbLMH2a0&&(BEAO/<?S40>V6?>TPaBGIH/I=H90<)>M
)7Sg^3?1@Z_Fe?\Tf?Z\VL7GI596,@#\9U@RLQP)XOOdb.T]95+[A@AQQPIVW?a7
LANE5_@I][6A2UB[B61Eb<M?43HB]MN7.f=];QS)IaSW]c::f&[-P4K<D33G6XGJ
E_g_8Q;OgFfV1YAg7PZ>F8IA]DcXUL/;WD3/g96OUHeLY#B0D3-fCV\9=^G;+I4R
DN+dH/07cbbad0c+2&e-cL^4e8G2P\Q0#VOEPR#Lg/9T6dKF6F@J?QVK_Af4&SVO
E4_eP[FH0=L2=&e=\F^:7/SU3OL/^GeXc&BaW?-L-0DS&T78<FK5OEb9d5;=[F@I
+a2/G,UQ=fP\2=D3-HGF,(;_U_:VAFN^9Gd]Pe5S1I0J8H<X2B).46PTg9DBMZ#+
,cZH=8SV)T.T<JDMR<M/RDRH:^B<3-]T7^56>W=.WW&8-1AWY1.AXK2YB9,fJ)#6
VW0cFLbV3\c6B,3&]9YP\TLA9YQMc&<WPB/^[/4HBHB[38H^HMH3BMAKP0Z2+2NN
[K]F;<M4(dE=P=:Z1=9[5BYHVV^1Q0MAT]&d9YeLf(8=/OX=J(0@A@F&4^WKB=>P
ecJL;#)/EcIY=Y?D=R(:Z#-I^1H8H+O>4Q@N<)2L(,A0?:VRK/YVKOZ;I]V_#4SV
3O;G0,FY_O/3#4c.BT^K@9?)QM\8JQ7]HUI+=SL;9(PE>3+Xdg9_D+Uc@U:CUfCb
@9M\5]S#;.5cg4@EA>R,8g-)^fW38d[IgIRL(T3G-F:fB<#[=bFUOF^ecKOZA<Sg
Fa#_.O#P+HF6O)AQ\IM84=AJ&=H6NM^@#>.0J+525S5>5,;eg/;QgXIXKI?PY.W^
N_L2]R\K[^RFLd:&#gBIRH-POa&])TYF_HZO+/U7[5+ABJTd&RBYVV)K5@\?:TS\
CdK>39;+=PE.IG<ABV67,-3__)f#cD\Y=cIW,YN+64B<O>Y4G&D.Oe&0#K;P>G9#
@TK>F-L9/U/A9>BX^1I-^POUG3&+H^e9Q_bL-e(5N&H(W&:eeFH#RF_-L+2<7FUW
WH@O9fa@-fJ6AYE-I..)^QU_;N+CbQ\;TRFTbVf-WMH\9Q^)6d4g+W/,5_=+L^Qe
dKSU;7c:]WR10@X>IWYS6dc;=F1#NT<M]a\49b5M&]eY#HA:HZJG0g^XN2/,?ZS?
C&FBdQCKcf[gAUOBDg7-MGCM(O-I5Vg=_M/O#59<YTDL.PdBKg=_SF_9P]AK1Q?X
Xa?OW]QHQ?RKJWB4.+7Zd=S7NB[KY;f=)N^A<e/D/X#=-I407U>+WeEf20)8[NV>
SP6C^AdODLAS+H\6K7d<#Z2?;Ie&O/ggK971Y/Fa[ACTJ]=WP<K?93+cEN6^.UP:
VLe=V2IBe7ZF>&,\L/0ObEgJEc1&TZ3JGO^L5F+]P;X0L^;MccZW4)UB]BUJN/eQ
]38KWA[C/e\0c0^AgEFg.\JLfVF48F@F4+S/@FgM#EDJ_6Ke_WTc\Cfc6V::Z0>d
S()XQJ)](;N0;MBH6Z&ZEZ:/6L?QW0&a/=F28OddPa(afQf.E^9eQ\a&b^B5:?I=
0?D:bd],>Y503c)I=79?DA,P9NbD__b8D50RD]M1I=VLGf,9dAPVOUUBSE)SG4JG
e2c6NCWf6#>0dKVfAL5g?-E9BI4(F4-]VdF9)g]@G<6]M?-.a914CN[8#@<T^XEb
S:70J4<aHdFF/PdQMb5e;/]63X(@F&VeF._?=&^.g(VDFP#SAa,N(5?O#^34[c:J
cDfZ;P;Nec\.]=Of3+G#Ef9g/<?8.g6f&&cd(eG6=AZNK#Ig@947?X7O4Ue/g^-=
,7Q5/b3MG^_#U_YDJILZ;8[\PETfBU+I6H5,\KW8@+@cOF/(-M6(@9OM\J]@(LYc
LE\#]=]FMMJXc(6:_@Q@5-ZW.=Q-f@:P1+0bJ/Gd.=N4/87e:fO_[IDSM1@X3B;C
B_OD?^[Gb/d-5d+TLP<>.B-;(,5/14G=VK&T3OR)NP;C;LK#=#-BC-bJf1fH[g:D
+bR8@cQ<Q395gPd<O\2,fcOL,(Q.?QN4geP)e)BIH<Jb\g@&;)f(XQ4da7a\:)E.
^]c.Y@^4U7G#QGT,2Xe@D868,LMSS00/L[;@53a9]0V=]SZd2K)ZG>dcR;TO31H;
.bO_LX35XVTG/45;bF:51I\35WHJ+)QY8,R#_<1QWQ?)AR)8<g&,W].0&UJZDeZ-
6J8TT(2H=KfA?d:;_JR\8YQXZO/]FJ#^DJ@HK3408gFIRFd+&N&YaXEAR<.9[JEP
:(?]-92X8,6aQ8DKe?D2GBBX.+;5TL-&4TZA#->KLBfGc23>V?a2-EgA>aL&C)[7
J0CE8J4;7>Jb\QRF])Z/AJe3)CA\C4AQJ8>RQgI&ZBW=5GFM9VNYB2#+=<#35561
EJ3#PD-ee^UJNH?ZBMgcfDFdQBI+V1_I\HE?Xf(f+B;W?W?KE68AKJM#,,?2H0/I
cF)<361ART,PfVf3bR6Lg@O&BS1I]b]1YDN=P)6gXCaP^9#[VB=)SEbJ9#V3cc]e
.HSK+A4cW(Wf36+T1P&;\=?7fb8LV=16I5H31;>/KY9@.ZD),f0R2@1:Z-)1#P+@
&27K;YDU4e/)eKKbYV@4#)SQ=B-5H)@GO85XI+0C<L5(E;>[B#;JB=>,XUeES>B<
N2?;D^._<WebK0/R#d<OBf^HR^@;+JR&20gOJ9KC+]cb:+UeSZZF8;UE5YY]S;I1
bc&Y.Q6N8\9BgR&Z8?G\5?7Y(Wb_A4]0]cb+(7&?#A#3FX3/Q\5HWfK,]R_VPeCP
?,Z&FfRAYcdZP;=^Tb>[eB3\Tg2>9&7@#E/O4)7,6?2g2X7R@#UW-8LQeUcA/4-4
_/dGC;#Y.bA:6LL.e@JcMBS8ELFJ[a^gC]Jc^eJCQa+]g5S/f]\XaNb>Xa2/6+E+
)EcWV477Y#[g_H@?@F\GA@;Z1N24;-UDa\&HbfZ_;[-cI3B+\EMD(2HYQWfBN\aS
ab\MSXS(>OEI,WcVF5=P]\X0:?=YZ@cH@Z:[^b6#1?<HUSCY,=P:P_,#dJ?5&I#c
O.e6C:;+&BT1XG907??QSQWeLSRE(5UB:&ZG&WM/U1E0Q3fL5ReO6,Q^dR41P=52
.bT_DQ::T[4QHebS+3K_UJ/1/#Nc[Q5_/DTHPN=[ETR2PHVF[S<=aVa18EVJE6gO
;_U,E/f+YTV&#N9\<f#f9W)ANU[SGf5Kf6C;C_eQ)7G1H9DP(e-/bE3TP<&-=12b
#e-&+\Y(N-M\^O2P6A][N)g:SdD7MO:=/FD[bU32BP+[Dda&MWJ9DZ=afg@J-[XF
W6AQ8#c@g(WbRY,@&-b_1?6?Ra#(=\2Y0[B==/?#KT>PN(-^EeGD>TVbYT)GH;.2
W3[U6@fHf@U(ba:Wa<C_CPI)I)Z]/_?+bS2WQ/dMJ^9b-IaA,EZ@B5E:fD@&?.dY
#RI4SS?/OR]f/a?B?/UV)HJWbMN\H:7BH?Z<?U>_MgODaDO.W<O)?&L,;4)S_c=3
DAVH#057(CXDGgU?EW1=Qg#(4=JW=H:18HVSa0&&VB?Pf>B]8-^C(:54JHeD2E<=
Vec#&1]d]d1CTC,ZQVa@HJB>K.>0ad[c1HGfH#O1U)5CYMICF,c=[^P,V@W:7a1D
B1D2Z7DL00+Z/)0eE)]YI.)?3HEDC,7GceTT@JVM;C9V);.fL4Og1&8(\9LNNe[S
NB<[[8@T6Q<^P+E@GR\S_A+7KXAKN&OA\Y7c5KCS40?YHgKZSCOeFFVTVgU+_DO,
H81AG>:T\HX2TSgE(-4HCDW:cK=RL9N,S_NBB1JT,A#^,2-5R+[O?@L(,Q?&D.Qf
&UEPALSaTLNIZ&GcQ>CG(S-AU:[FM/Y>05^fB7a9//B_(1R^.J^c^]ZV&e3?8R.W
(OVWBV23?8R?,1Q9@g6&0V(^1QgSBW^/;$
`endprotected


`endif
