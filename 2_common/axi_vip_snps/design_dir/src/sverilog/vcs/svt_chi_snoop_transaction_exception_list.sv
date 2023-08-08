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

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_snoop_transaction;
typedef class svt_chi_snoop_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_snoop_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_snoop_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_snoop_transaction_exception_list instance.
 */
`define SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_snoop_transaction_exception_list exception list.
 */
class svt_chi_snoop_transaction_exception_list extends svt_exception_list#(svt_chi_snoop_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_snoop_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_snoop_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_snoop_transaction_exception_list", svt_chi_snoop_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_snoop_transaction_exception_list)
  `svt_data_member_end(svt_chi_snoop_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_snoop_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_snoop_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_snoop_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_snoop_transaction_exception_list)
  `vmm_class_factory(svt_chi_snoop_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
QB-=Gga<:^8A=20g)][)P[8,cUF#EE@STg(?8]JfK6],#-HW/6@F2)L8G4@&353:
/\U+GX:/EdHc[@J<bKOVJe)X&5T1.?)4g2eJWC+@-F<U;2,H(e94A:gZ>+dJ#]OR
QdLL)9V5_)CP[MYZ]3ZUS[>)_ZMfUYZXc\bO&3a)?/d7aRP7:(T[LAB86Qd@PFI#
R(B#:[W9V=J;CEa2R7D5J2J2L/ESX9=2/F3T4&K-IJYO,,Ra[JRM5gYC?gP)b>75
N?61DZeX]DBTNETU>B86A:HfSD<HK37EH>:4>TT[3:7QIC[Y5G47Y;X?B3B8J/?:
b&>P;8eL8\-,Nd@OCG=TDZ:F.&OUR/3:0=gQLF&#])bX,XgRZ:.[&g(]bB2[,.RN
T>M<KWAN=J42D<I?+JQ,##M,0ObZR662VP;7;0/AN3f.7AA#QK4&/9R.HMO#1F_T
?71R#aP9B4&-,GWEV5?XYe#TLTcUg=PRMK.5?G4[AH;_-Fe]CQPGG];PEVQ?\J.?
V\3WJF7?:(L/fC32?7KM;&D05K3,Ma7HX64ERD\I(=NP+.Gf)[[VM;ZY5d>HPL)>
)?dC<X8[5G+LV#d/\ABe/L>/4+PdME(JJQD#?&:bK^JITUVT37U3cQG4&a>XH_6:
ICb2?^/Q]VF.J?c\\G,M_C/G0D8]F=84N1,<0XQ:Y,GbYK>/fK^7WNOc??_V,-8P
f#X)[aF,5c;=e])3P^aC+9C)UA0I58[-H^[85-&(/L-[_a#R:M^N1Wc^EB6CKOS#
;/,QD6037<f6^#C6K1^Y23^NI-<dK3,8PKJU:<ee,Z+?<W2YgSUNJJL=OF6We9N3
:AX-F#KSO.Wc+-aRCKDXgP^3H;d<4IP(dIE/g):dHFZcUOSad5PD9GRHGcCD2Q-b
7OfOe)L,#.Q[W6L.b6aK^2N9I\UV@O2N96NDFF[2deT.cGdQSYDO.-NLa--:7^]+
:^9=2HY+\bPUZS+-5/,_D3HW9C1GDC.BBGO:Kb<K5Y?2&)=gg^I<84E;\]V6]0gg
OZ2-c?-I23;d.ELG1Dg9V<:6P\a\UEaVHH\H;eIP-\I,Q6]Pg-AeS.)9c>B1d9YS
C#WF;=H7XL[X<XPV-bX9:XNGX2HHKF7&L=Ec0252\9_1B3()f?>G/DRg[AVM@]<:
,-82(2FfFYHO:0Y7T2CDUGfNRW<:dfBG>$
`endprotected


//vcs_vip_protect
`protected
W\N1T7^AJKL0H11Qc/?#QTE6NN9PaVF5DfRNF(^YN:9+0/MQ-N7+((1Bda8Y=Yd5
S+)9(J@2CI3deMZA?DW@bOBGUSL?Qg&M.;6O=8\=LGf\gB0KD3V#@bgN6Z#-\&e1
K-\]c3W4@8V,HU<O8DZGcK+IA;9CPcEN^A461XC.8&O@+28EBS;UU44]UBPSgg1R
>KAWZ;4MaF\;0G9BbVcX#U958_gaX.4B0e(B[d2]\CBB6:E&=YVJ4edB3gT/;\5^
;9ETX[^=WK8aSQ7PD#?f)Q4[GcM^:T_)BXEZF;R^1cBPP<YGE,H(XT+&Fb/b=FIA
QL&YO,8:#G;<9SbaS(E)]QaWQI?@GKBY>^3;BC43]c3.2Q,&@HU;?^c>b#N4.aN.
SCg9#?9O-^O,F)V]A:XP08?:P6Ga0@A65;H#]TN0D_VF>C6TQ.c<>RZ\@VZK\@.c
:dbK_K-@XGB@^A@^2PF&6ecfTX=#>QRGN#T@OH[04N4WC1GGe@-5/fJ^UAgP^KF\
NSX1Eb)K/W?GA2#Ae3+-@cNF_&O-[Ac/fV7;G=gKH^3TH;1A8e6(>66bMHNV7d::
JK^2aV?-(YY/7IOK]+Y1RG/&Q2e3dY#YW0EI9&-D-bTT,Y&[Wb^fUbb8c/C&\Dc7
,]d/;R[EMH8#E=151-6PR841^Z(Cg4#a8XCe8AG.D5;6DO]Xag-4^-B5SDC;_dRe
)9S=Qd_#-Lg7eHI[@e)cD9[12PVKMT>:.P.K\X4-&4U:&;;HF?OEeT=^Y8M_-eLC
/V:3:JKI-(QFO[-FGaF(dc);1+O)<>Y9;6@T6.LfK(B(M>]E_37+9Na)PMWL+C)Q
F+Q&A,T-2G:PCdLX@MQ(0a@WSZL#DRC3;M)QNC<&Yc5G,SROc2Yf)5\U-[,0G@))
RWf8(Z2^7C5A_-S38SQL0D1C2[20S=+R,L=YeD<c;-P62.gH&D_O_?O-Ia[a:<75
W\e[+1\d)M19f7@;gZME:P.;PP1.D^CDSAK>^\Q6^J>gJSS[PSIV0997IXX5YW>\
-+eJ7(@]C//RJCbY[+gaYFA00&I1^YAc(B:)9[&::B5.LF((<HN_FVcbCLgdP3Q1
>27K0&HB3#?C-L9#2e?)#Kb+3=BW[4d^P)&T+_U0Kd5Taa4,S<D[3M;PNS#Ha08;
N=]TXV@)BI>I]/L4P:]R&C@/:YNMI);8Ze^5>6J]b9\J#&-S_U&?<,&J>3HcHbX0
LU?8X-I^=]J-5BUW-9\XY]B#3A2@#A=O8faNcXRgH9YH.gAGIT/-U/#A^eIf(,[Q
[U4=(,KRdUYX<<:f1=85_e0+MO;H@-ZVA]J7[Sg\YZ:PX1F3B/DKaPgfKcL>#NcK
?4&cEPNBQ,[2,W/,WOMXN2,>FbG--]R+7MCQ(+R_6E]b,@>&_cAc^F4;S7Q5P/Q9
6e+]LMSMe/5ESL7:IZ<)QZ>&Y<?Y1^JYMM872YB8K_8+O\])1_H<bbW#.<;35KPN
7(@0GP/,N@@XQRa9?L#GN4)Ic4EeQ?8:(S=3J+4U5PQU,<-TMW=-OK5994(MU348
^Q-=1ffgF\g+\OBC52b@26(V698;AEg/K:/b:PA<KL)_LMF^,Q(HPgS8d232:19R
_1M7C4aV^6M^<Ef7^7@JPA&2Hg@5J-]3EV\b(O8d\g\gE_2eag)A2TX&^RR6NP[>
SL:&_TIOZ8#c[]/gNgcWF0?>]fcJC)cGd4KAeU534JPeH\XAIb2e[1=Kd)WFAGZH
S\Q?+XNLJ50;4^OFVKg5+T0,gWVbeVdEM30Ia\OZ9]A.W.3B53F)-g<e.eMWSOa<
8,aGNZUEg0bPBK;^4c_EgNYGVZ)b[8ScHTMf\_BRN>.K2K/],dJ;1OG8&_ac4f4>
ZaB6C]Ke+OD4F=XEJ3/Q0G,^IY?:M6<=f@e?_>M[2JQD8:CMb4WDe/4Nb^+BY3?+
5JN5ZH&NXYUGZ+gMU(D@Y4CGY/<Y8^(aK@e=X87CG#J/Zg=W6D63bSH:1XWN_NA&
THHeHKM0HK^Z5aB1]<Tf+QO2YKQ2J18>#Y:EVaT1a3F6NR=Cd9?THD?TI<(XN,45
IRU#,+8=M=>BE_)fXM\gKRcFTa=+7=557(2A51G<&H7C\FZ\(:>+RFQY1bA,>RXf
PE7Yb0Uc\Y5[:;:f<XL8#Dc2FgfV^B:LAH8&8.?Q9Y>[,gM6FC.@H\:+ZbIfGS@D
D28Ie2G+XeIB#CD+\0K7_][5[=1:[A(M\NLfR7:J-W]426IPEXdf^)-TU7M6f>G@
-6=f9R_fZddZFNUZYg1]b;([=<Ee?<gT)3=E/QcHY<BC(7dSKYG17]11UR<&N,S7
92]@V27cY9_SZ=_Ie:fe^>X7_4-8NEI;58CBB42eV=d,&ESW?8B4I<PR6]4<f+Tf
4:g<-<^2=R-PeFYg\F-;#1F>(758SNZ7F0WRDd19?X;E._D]V;5H7&S91bJ;YKH-
G.7TW7[Neebe:2^[.74M7I5QDC#Oa5KXOEWTYP])]JSESY/->8dY(cA/O.[VJ\7.
(H59<-O4_[4cJ#XC(GS1]3Mfb55GKR<8>.DOM4eL6Y)cHP^53W1bPQfH;#YMH\_X
=34#XJOUVK>-.CGE35e;+[&I6H8.?aeT(4F\O8GdS0[7=8+_F.C.gOXB=A(52gI:
_]Vd;OGAP1Uf+K0e,>H3c0W0g7_Z#S;(^6;g/S](Q(W@Gc:^/b^c,J:#X6.X>e7[
>:Sb8L>GT63=Ob,9_DHN;?Ic,LK6cJ,LG[H7X9/16]6;g>bg6QbIF^MX-@a@@#Q3
+2TeS&Y,R\^e>Qc+V&C1F#\KUdJ2B/]L4=Z@;.DM?MSHM:J#KAN&L>DFac/[(PX)
F/DO4dTNTc(g,H;C)^De<B8BgFI\=-ae/G;f(WJLVVRB(X[=;=DO#KNYF@F\4?HI
1+[@>gU830MNOX>ZV#--(5&B/[4P^L_8)_MWR88(VY@M0J[F^O2QF#^X<2FIG_Mc
ECd<+CSUePFQ9cP+^>b6P6B]8]P?J(7ZGH_LW2@5>UH.580XD5[?-O,?X#D9>)D[
59,#M6XgF<XE_41,F2gFOWM6FdDg8.L-\B24AKcUWP1#OZRaX44U7AE-&#Mg[O2O
_@ZF1K-O.9+[1\cRG?.b7AJ#W[=LFW\1:H-a[?e-44<K90D4R,<9SZF?1Id-20KN
TXZ@;=]1?Nd7?/+=FKG_VQ#B3-Y&D3+J5))U&6HVH1cCNNZ(E@_7eO^(I.:)e-M;
B]GIR7L<A+J(P&)@GI^.=IdR/(>a-:VFSC:ZWEKM[7KU?XfY-Wd^&ATbF.H(__)d
V/aWLWK@M\WO/H?+DLFg/GNK24/)PT-](e2H7TRP\e3LDXB[U?JaEF=fR?CdW0[H
fJ/C61gXa7U5@V3D)^\?6\W1gPF(8eAENR8A37Sg.4CeFD5eQ[(XY0UN7E:9:M(:
OCN#<2G[M[g&W,+_/GB50gYd-:OS5>DPAZ,d6^CN=P2#S(.O3Z>^_]\-(0Z)91GI
C>C6VT=]97/.cL_I\V?L8-@8+dedAW/H@J:Y(W4XF)JTFYJQ5d_T-QQCJf7T;;6U
PJ0#EAV^Y5Xf-R?GN@>=\Sa_VW+7V:RDM=/R:7Xg?2GNZP3CGV4(N8V6S#-C/(a?
FbO9564,fSd&GJK8XEd.<JZ(;.AW/\76O5X61Qe>]O,E3QT&M6X5Q)VNVAa[b/MS
59VfR4R5g7UIbO^@R502,<LZTbH):PUMJ-WPVR.g?D)>]]gS)a5Y7KP>4LVA]4&0
Qf[-IHSg6^TF\],MSEWA9dd;W8Fb(2)?_B(MCW=5T?8,&3/C(gEISD8-:BPfDaS&
]36;S_L]R69)\C&PI&IE&dd:,43-U2+G@UeK01R.OG-eH,ZTIYU-bC.],gf:g2E4
SF0)e]-T@OLg-VR.MT8@>N3T64L?J20IDZ1e7E>#6a+#9N70f2IWRC[b5g)47?0f
b(IR:Ne?f2eE8c>M^#Ge&fDYa9Y-FZdQK_.W.?C0AC;).2.S<SFJITQQZdOLD(T(
RCKKB;eRb6fG1?=:,>bQ:[cPe6V/PT];OZ74I[&a\7>1Q\;B-^4g60aA)d-D7>UQ
[N9-ccQ=]K6e-)DKO82IRDf3?8-eX,fd?9P9ZE]ac#,cAT:1366:,2Z=5P)HI:OF
P]BeA:bTP^Ed@XY#I&cg\a,S>T@4ASL-MTRg]K01H;5#0K>.b,>f][5128@0gNJF
e^2O@^N&607LN\JH+Q_d=eg<AD9,[X:f3AY(J?Ua\G)>dcB1UQMeA970O1&:b,Oa
#5Q2S9a^&4<12L[ZbgY6-f#b1B-60]@Wf3;7&9(V\_^W6:HFRL\3<N:,(A4CZaD-
T4DWG6VbSf&D8MG4#2NP(fJ&;UD<NL[(WbNaJE^E(F<\#G865H5ERLUeWcJ<2cVF
+9Le1=).MAAfEVe)UJ3bdMe5L7dL1>1=U(;P,WDdb.\?A47bB),[B.<5::EZ,>RN
>?)=;<cdTS\]\:X,H+3ZJcR?-,<;eURO^5^E5H7]CWg<3YbR8&dU)=^/=a4M+b72
98N1(\#^9<#bMID(,SW&Q/#aNA]:=Y0LA@IaO?ZQMRMLC9TfBf5)J95F.S@GJF_?
A+D^TZ+TbSaaLT(OA[.E@,;4O(\O<;_4+J#Z/<RCGa,Y,+BS9V3IF]FccUR,R;,b
=JZ+0CBJQE<IdOYWRe62P-+gKB]V7L-KC0JU04)A4-81M?H&]D@;gAAQ:b[0gEJf
DA>ECG&acGQ?TUZN63?2J@I<Zc3;5Z.R(4:AWYZc345e,Bc>029:IA3&5.[fGU9.
8gG\BQW>8f/5NP0dP[G)6g>e(SZLV=S9\[16Z(;9+SGJE\E-g_L0)_WG:gRJ:AAN
)0F:^6R2-FQZD7e=M0JFQ,,bQ+&F:J=O<Z8\YK^QX(Kg]9G?O6-\7/51@K5HKX_g
edOR]cL+f;.\H2V(BS3.JN:N,/7FfKQ>,?+ZHG+A:_,IM5U)gH)R@>3L>56<RA&#
:V:51_9#E3^0d))J)H.gGEYb4<e^JN/-JWbU;-0b1G)F8G@XK5I59]G)=aaSC;c;
#bD7#PdZ)84JOYMHLd2^\?0I98NGL]VJ?J],S3HU-25HFfXBT4YaH^;8)M[IT(VL
N6L@PC6R+6W=J[S;U^?]2\L@K?^I::[NFHN5ECI^/\5f]Z-/+;e^D_U?@7REbb93
&)R(:6RPVZe6&+E:COX4MIW]F<BQbg/7;G-d4UHR.AgDM\IT2dAUS)[6+0AM0^.;
,9S#gG[_,gcX\/(Sc7b(eS1H;O0Y]a6IT1)d7)e:8(Zg:&7[P]@0_VdX2F_592V+
28cM+^C?CJ(=]dSU&(1B/cC^R/N\P.OJPORC8,U@a:C5=Yf2]MGW=PQ+3=3RO2-R
cA1YLJ+_4H;BZ?;#BM\LJ2.Adf:)R>a-EZ_NEECB,6792YAW>()GUY,0^gL]A=CJ
DafS6HLc6DQA8[SC+X6._f,;>8g]54J2K[+5cQN5e:fR1cA3TNPd8XLQY?V85Bc@
BMV)G[LV7f^R079g1\T056b;4;8(I:OHb@8RcbK+M.1K#d5H33C)2W.dN,ZKg@#&
^+X^\7B+.L/>W^B6@7HdX8GNSCZ\C\-0dT_]CbM1Y3^#O]Cca@EZAS#CU8IB20F@
gON[ffD)DgZ=Za>9cT(@T.:Va;R<-@42c.T&V.8+FdLecE<F,.SJ_:;85gAC&YGd
UMF^?T6c8+JE)Q#gER]Y9-b=H7cD@CBI@1;Z;@VMb0,QLD<C6+P.G,:4)IfgCJa[
P]^+Q)KR]R_<:7L\KYQ<X5EF)(89>aE]8_<d.T-:/T^1>edDPSBSJJSX90U2\[KG
7^<dV@?]RV0L35V/:TW9A[=UWHfWb,FHIB3R9E,K:HYNVUWF^9I_XNMgDNUML,4,
-_(6YHJU3g&U.PF+Y?ZWO2:<B,NX#8X@YW:YFL\P4W2G41\VI>._OH4b@4#\[^E5
BKC]/;7^\USYHE[@_?D+>>^SRW9e)&Y>UJ,BK3d?RD+G>(?@Kfaa?N]Z]L7QCXD[
KIX=]\-WMU\KA3?]=.a;=]UZMH,H,=C8(>;?gcdXge4dFg._XL0a[,\DE\6W1C,(
V)[8fK9<XeJ.9G40PX=d.;.Mg-E.F:7/IP&e0V_?@Q[RZ]bbIBT<-=@E1dAZ+JSD
e-Ua>7L#IJME9+IA@b/aUZ@=W/WR4V3>].X)IbPL\>I#[e8I/=3/F)^)(T&,RZGV
(6_GS(>7HY[W:L7/QdN8XC_[.JA#5)3&57b,FG.#WA)J(RQ&,RM0K_N_/IHGb;U@
FKg&EI.O?MDW+Y>LDD+[dC,0YOdDR4a9IF?<cRO8^.1QT_/,WZF,3aWYF0#C,Dg6
)GS8_)X.\7f4O:d=4#bO.6JZK++f]9NE8RC_&IVdc7=6Q5M^3.FV,YO:GIZ)NdK^
NC^6/8MR09ZD@+8bCG6-IfZ\S26SMbGKZEL^]bK/DKTK,L/PdTMK:HV]g>6>e,Ae
c9\-&]_>-#EA,+M?8)6X(ZZJfR]9NcTZN;S<CQg;L#a/X\R3K(Id^_>\5GD/)PDO
B+LZ?NX<+bPC.AL0F_=0+J[&R^5WSg<W0G\Nb<=0,B)N.0:&2M<B([X(XIb:d2N4
0Xee/X6K2cR58cOF1:)TeDSgLBQA70^48KG3#[OVE&/V1CV\f)Pc^c&&G&[b+T3(
a,e[EN(WW>2X,/.II[P(Y_cQD2Z<,=STIZga+cNdE(R\[^P8K90AFN?UFYM0O>B3
VAS+F?3(/EPRL3_Feg&;IKTD+FAQd:2#HTdM/(<8C+4CI3P/>3e\YeaP]PcE.I79
bIYU5/.[LPBK7TT<>V)66cGC0<9B?<3MHd3\/#A0).aA6KJa.;f0QE<6-ef_D[f0
?<ZCd?X=P(\,=K1bC(>bA9#O^d-R,E;1[JJ+M4g\];+_:LUFD5KIVXWG_6e@B+ZS
EETg&NcbNPI2UfY>=Z<3If-/0^1602]-D3^8QIb+:)_PL)f:/V3#\G2JUNNGI7W9
(GE=Ag(]]a4,@gZI(\UV+7Q7@1+8,]U1DNX9TNH1(>H+MfXR@Zg:8WJ)eF&8Z:G_
cf;YJU)[._b?-+2+;,8+DBfdCCY:>547EZba-UJ0BRT(+>;f-N:2&LMI[g7^ffE1
QY[b9cUcIPW(DHLX<Mf=9B,43Y7N@>&_d;Xa[@MZ.4_=7.@PB8\CE>B#G.6O06gN
M?-XSM;a+>.+U.Vc3V(aZ6IRQKEFcfeOdL:bBgd;-6e6CSUBCVE&2dM:188^WF^L
;I8O_ARMA_QX2^D_(AP5:O#3B#g1F9>9^^P?.L/0EI/?>f-@[9Z.2c4FbBOE.=@]
#@9;>AB6WO?<6YWf/A^c8]aZ7Ga38<,UdN;#;:1(L)RCO,g[B?WWcUa:XZ#(cP7g
_I?I]8]>16?IbJ-R9QK6YSB\?;0BA[Z4BI)>B9XUPO#DI2/Pf)H+/4#L#MAPXIg8
XC:F-9#Xf1X&E(efaC;WDQ9O1CHFR[[\#9e+d82Y9_-2R_dHT>[P8c-MGG@96R3I
=2XMM[<N>Kb9;VD.a#(fWS(3dNa]-.2VBV^BF\SC3fRa7B5@7#A,0H[gaYVH-4[-
V>Fb[J)<EFG1a?A9aJ;,fR/39,F<gIV[]dJIZJ[;8^g[-E8(]g1,+]N)cH7MWM<K
@D2.G3<\ePR4aG0e>@f^YX9P-)aQW_L\]fANeeR^E^4a-0Wd[d)SG+WJ,Me99Re?
O@U;QSS_/QV;@ON6<+IS0^QSIJNGC6dXY)7,&)08Q?_4.;>0;E12^\-U-O\53e@Z
WOX\O+\<6VcIVJaQPTBcEBS@86)=E?,3/9=.TJV[6LZSed7_SDA)baQC<_(,\SXK
.FJJcf@Xbe(DdW/,@O_^ZJ:VXb-E[W?>RY)J0dC^IX.5CA]^WMTR1,/9UW@,GSfZ
M#>I/_eZLIbg&THN765KW@7[0B/_,[CHM/c;_0dAcP\]OTU)G,b7VE0=XL_DL&VH
7)LZX=M\V<.1=S_Q+;cL#983L,ATYdKedSY#D#dA/6/OX=O-5+)@SSeOW4D?/eb;
]#d1fSMR62W7b=HBAGZ[:5AFV.CIJXT6Q)g,N8&(dOeML=dQcKd/PW@XSf&+)AHY
Z.N1.BHe\e0WZNV[I;)(UE2(K[,b^^^DO@I-\RbQA=F3Q,0?47+X?.[MCcE/,4[^
RFF6YbWa[HH^&EJ<]2<;f4JIcIVEbQKGeN(ZE;H]c(aNa]f-2>IfG.B6PR(UPKV0
LO[4g138+9AFSDV(6:[ZU.M/7@#(>.W\=>g?]M)>cgI07).XFSD#Z^4[IYeVUG9Y
cD&\J7V6Va@G1:b7[1b/>./#;f.RI9+=>cQ=.I0[@.B/VEU\BVFCFD+;&ZZ..a-.
^;S_;1Xe_?FfeB63AU?I[_gb=efB,6?@V+84\@1>JSeY)@&MR,;dH]:93;GZGJUD
;[[_]Sa-HLScdgQPHQW_9]+6eM5MT&YW#;Y^&+(M.QIP4/COM@E2eTSHKP5OJgMR
XY=>BCW>1e;c;O\03&#\5]]c?6HF<7a?TL6W[fO#AbC:XQf]H=1.0d]0KP:>Dg]a
&>\GA&=bPM)6V[6<F?e82VA<UI5J?H<[0d[#&R<e:d^?6FeG[fCV(#bN=B5>1/B9
E9&FQ_bL513EKXU7AEaD+9e09E^2QA8aMWN-6Q8.RN37XF.5fY6WZU6=I;L3cgaF
C1/8_V&f.7,CZVDLD<bD._?8(Se2a2C#(JCGWV0=UJ=_1YEP6RaTE54NPTAWeI[_
cC_#V:O#1BbWM:eK0\(C(X2@Wf[771BPX@OQ)3&NF&fX1UA0F+:KP4S)f/T.QC]2
+JI:B9g2N8aYND/AO/\\4cf3_\.4@cBcdL/E+9P4545Zg9Q+P@feZXDNWPEX1F/@
gG.1R1J&.^Y@Z;Q]Q,1JKR6DVX/VeLOR)d.J&eG\bcORMZU4BfX,g/CYOCcReS#/
YT,RMA&efb+V9S#D&NgD7dB@3LJ)f>^e9.OQ?A2&8ELfW(Wb)A6M7-?-Sf>_Z>Z8
>&6/^OEc?(.0E&c]#,_EGFQ[3E=OR]EF_LOSC:Og0W2,?BS&8f/8?E9_94V6A6T@
>5--7H2]R/=a6345PeaV.F&FN6aHKA.89PQ?=K:52UOe>2Q#Y<027HRB&EI4_cOJ
\2_^@PIBAgGT8UKMO6_(XV,]FgTgA^5MRC<AOF&ZWca]D5,HD>0<6-Y@2&&I<0X?
0X9&)<@aU?<;eC71gN4N.@7-N)8[&1NGNcE(R)Af:MBCU>&gQJ=e^O\HM/b1#gFK
ES\I(gb5Q>;E.CTgCSI;&#RCcIGf+P016Dg.?C:AZB:K0+gM7TG,[a#2(+cO/5/L
WWLE)baV@L9PE\\c_WDd?WLa9B?gGJ]FCVBWZ=+DHWc9JL7M3S6#5SCCR\3DdH#2
(12#\]c6FSbE?VPQ(Sb3aa5e_a,<4O>1ag?W-(+fJ](3>G_]8HaA0,3V>YB\N]XR
&gDGa-\g.VZ1Z,Yd3@A(ad9]A^-O:XMd1-aOVA7>gH@+9+b5d87I6A[051.J7>.E
QF:D[+b,+^H+[#f_YKd7KcU_Xda6PeV^8;=KaIJUE.5(RW+6b&AF119g_7.D65J.
X?Wce0XQO-KU;T[X:#UU8)7<T&GOO/4MGJ.bIR<fRH+e4SD9+1Q(P@5,g.gF#Y=I
QXKc7/]KHa)Qa>8Uc80KFUC[T;.YU45]70TZ?gEM//_?X1@4&IgZ>V;FbdR694+=
c4ND=Z7>1\6eTKX;]E]g:9/CH+DN[Ke4VD/Qd39d2^(:QfMf\7H\2P]/_<b)#2ec
2WZaD.3ULAKJI;IY,?,P(AGRO.:&QRT4<BEW4^N93?bVGPS?Y_3CG.725(c>9+>O
gad/b4WY<BT-K<eNZ>g[^A9P_0#^R8-RTGV@Na7@&9Q_4]2@[9Ib.R?CU<&[96LL
/V^Z&R5Z:aTIH\3E[3SWO3\#C+]c]>_NC[17U)53>>ee7+-6MVeH1U1OX.XeX+@K
\5Fgcf4K7Z&\<W4-Q,>XJg6>K4Y:;Y]TbHYAY,JC2J4M&DFH8G:UZKY.NJ?^[R#U
fH37V/C-ZC,I\91KZ@E4]6A8QR?M+M3-6b5+HUDLe^L=/&&-Pf5Q-X2/0RD4eY5A
\O61=1XM>.;WSTXI>A9^@X.QOc@6H]H_D]EfLV:?#@gT8<L#.+f9(NU6MRCK5R19
(^@7GE0FK_eCRf58-^1),C:MaRF^7_&G6-1,D43XT:L1U(Q+Ic3M8;;bN\,2Wdg1
&dJRRSF#e?&<7)1XE6[4Z/6<T=NZ,:K-(2I9X/cUO06eC];+N#74B+IRF8R&H^PC
2(M1gRR?C\bD02IATD;]&0Z(]#07-V8WH(G<cd4K.dK/S]^2;f[>UKP[^1dR2)YQ
/[R<EJ@f8e,_[6(EdPOW16-X>dKM<YKP08^?3f9@d,]gf-6MX--[H.WSF3a4)YPJ
FB\&3IXW]O3c?B>)(1/&OF)8W^=^<4(H3F96T8VF7;SU\>0K9J3Q@L>5B]OcI&Xc
F6AR&9<=K[BAI86_(^L1Y0D:+^QEC\//P4+3#<PCeEf=SBKD3<<Xc<9gV4FOf==#
d(P)a\=SgXecf\V4GJ4B:<N3E^YMJd@HNVN2/dc&@a9OBf_gWZ;D<e;.A]I/._Bc
ZPY+86+aC;8gYSB^>&T^#ZgW_V7eZ556[]PQYVBUL7+)B04:c)S^O:DM&UHWQF1X
;e/=-LT)<4P8IgSI^bf<BM6_4;^H4R=HJE73CP/21d.[>H:^[0=5:^e6(L1<b4WV
:S)OJ2ZbSgSLF1b1;E64=#H@U3]>F[,fbG90LXGgAD[[D$
`endprotected


`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
