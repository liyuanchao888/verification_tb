
`ifndef GUARD_SVT_ATB_CHECKER_SV
`define GUARD_SVT_ATB_CHECKER_SV


class svt_atb_checker extends svt_err_check;

`protected
PB;06[b<,]_&H&ZFKVX@9LL)b\c=PWA9eB=,L;5A#Y\-I<<Md.aO&)P)\A>XQZb<
)faA16YId]T&,$
`endprotected



  local svt_atb_port_configuration cfg;

/** @cond PRIVATE */
`protected
<,)e(.F/I3dcGC20cZde2d60d51UKD.<LEFR;48K0GWEY4&]bB:N5)aVV?SQR<O_
fYg\B@URA[)c,$
`endprotected

  local string group_name = "";

  local string sub_group_name = "";

  /** Instance name */
  local string inst_name;

  /** String used in macros */
  local string macro_str = "";

  /** SVT Error Check Class passed in through the monitor */
  /** Last sampled value of reset */
  logic previous_reset = 1;

  local logic prev_atvalid = 0;
  local logic prev_afvalid = 0;
  local logic prev_afready = 0;
  local logic prev_atready = 0;
  local logic[`SVT_ATB_MAX_ID_WIDTH-1:0] prev_atid    = 0;
  local logic[`SVT_ATB_MAX_DATA_WIDTH-1:0] prev_atdata  = 0;
  local logic[`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] prev_atbytes = 0;
/** @endcond */


  //--------------------------------------------------------------
  /** Checks that ATID is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atid_when_atvalid_high_check;

  /** Checks that ATREADY is not X or Z */
  svt_err_check_stats signal_valid_atready_when_atvalid_high_check;

  /** Checks that ATDATA is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atdata_when_atvalid_high_check;

  /** Checks that ATBYTES is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atbytes_when_atvalid_high_check;

  /** Checks that AFREADY is not X or Z */
  svt_err_check_stats signal_valid_afready_when_afvalid_high_check;

  //--------------------------------------------------------------
  /** Checks that ATID is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atid_when_atvalid_high_check;

  /** Checks that ATDATA is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atdata_when_atvalid_high_check;

  /** Checks that ATBYTES is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atbytes_when_atvalid_high_check;
  //--------------------------------------------------------------

  //--------------------------------------------------------------
  // Checks that need to be executed externally (by monitor).
  //--------------------------------------------------------------
  /** Checks that ATVALID is not X or Z */
  svt_err_check_stats signal_valid_atvalid_check;

  /** Checks that AFVALID is not X or Z */
  svt_err_check_stats signal_valid_afvalid_check;

  /** Checks that SYNCREQ is not X or Z */
  svt_err_check_stats signal_valid_syncreq_check;

  /** Checks if atvalid was interrupted before atready got asserted */
  svt_err_check_stats atvalid_interrupted_check;

  /** Checks if afvalid was interrupted before afready got asserted */
  svt_err_check_stats afvalid_interrupted_check;

  //--------------------------------------------------------------
  /** Checks if atvalid is low when reset is active */
  svt_err_check_stats atvalid_low_when_reset_is_active_check;

  /** Checks if afvalid is low when reset is active */
  svt_err_check_stats afvalid_low_when_reset_is_active_check;

  /** Checks if syncreq is low when reset is active */
  svt_err_check_stats syncreq_low_when_reset_is_active_check;
  //--------------------------------------------------------------

  /** Checks if atid driven on bus with reserved valud */
  svt_err_check_stats atid_reserved_val_check;

  /** Checks if atdata driven on bus is valid for corresponding atid */
  svt_err_check_stats atdata_valid_val_check;

  //* Checks if atbytes driven on bus is valid for corresponding atid */
  //svt_err_check_stats atbytes_valid_val_check;


/** @cond PRIVATE */
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM report server passed in through the constructor */
  uvm_report_object reporter;
`elsif SVT_OVM_TECHNOLOGY
  /** OVM report server passed in through the constructor */
  ovm_report_object reporter;
`else
  /** VMM message service passed in through the constructor*/
  vmm_log  log;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   *
   * @param reporter UVM report object used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   *
   */
  extern function new (string name, svt_atb_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   *
   * @param reporter OVM report object used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   *
   */
  extern function new (string name, svt_atb_port_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   *
   * @param log VMM log instance used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new (string name, svt_atb_port_configuration cfg, vmm_log log = null);
`endif

  /**
    * checks valid ATB data signals and if those signals are stable when atvalid remains asserted
    */
  extern function void perform_atb_data_chan_signal_level_checks(
                logic observed_atvalid, logic [`SVT_ATB_MAX_ID_WIDTH-1:0] observed_atid,
                logic [`SVT_ATB_MAX_DATA_WIDTH-1:0] observed_atdata,
                logic [`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] observed_atbytes,
                logic observed_atready, output bit is_atid_valid,
                output bit is_atdata_valid, output bit is_atbytes_valid, output bit is_wready);

  /**
    * checks reset value of signals driven by slave i.e. afvalid and syncreq remain low during reset
    */
  extern function void perform_slave_reset_checks(logic observed_afvalid, logic observed_syncreq);

  /**
    * checks reset value of signals driven by master i.e. atvalid remains low during reset
    */
  extern function void perform_master_reset_checks( logic observed_atvalid);

  /** resets internal variables */
  extern function void reset_internal_variables();

  /**
    * checks if all valid and ready signals and syncreq signal have logic level either 0 or 1
    */
  extern function void valid_signal_check(logic observed_atvalid, logic observed_atready, logic observed_afvalid, logic observed_afready, logic observed_syncreq);

  extern virtual function void set_default_pass_effect(svt_err_check_stats::fail_effect_enum default_pass_effect);

  /** update delayed atb signals in atb_checker */
  extern function void update_delayed_atb_signals( logic observed_atvalid, logic [`SVT_ATB_MAX_ID_WIDTH-1:0] observed_atid, logic [`SVT_ATB_MAX_DATA_WIDTH-1:0] observed_atdata, logic [`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] observed_atbytes, logic observed_atready, logic observed_afvalid, logic observed_afready);

  //extern function void register_err_checks(bit en = 1'b1);

endclass
/** @endcond */

//----------------------------------------------------------------

`protected
EDWN\SYG5\@K_,bZ+PA\U#-dRMAB>2O</#ef:I:N1@\gZUZJBe/Z7);:GYbR@M[W
PJPG?dT(ea3T\PcWCLL0<=SLedDDK^8\G=ORN/,[]97(bI=caD))TESB8^&_]0Y;
D^d?KE8,bfd??^]f.W?Z1=gWPMT;9dLA.)^YU)(F:AIDTS1QMb?7[?&OPeB-5-32
eeEM5KBQ;U\<)N3;HRC30[AFf.M(L9:IUfLbKYg:Q/M77GgOE\EDbg/G_A[>&G1\
[B[&_3Y83(6BA^J>SXEPeI,0CVU_G54?T,aW+e8@,<(@f\Rg05^I=b4\VdK#R-FF
=f73^f#G?[09afB7O>(eP1UL&:_-YOfW\&1d,ME=Gb07YUM1Z.TJC_IIcB7&GG_4
7cJaNG;>FC257@;E68HC?bNP:TLG/MQJ\4(D+&88e+4X=<D4SWR=_XaO^V;G1aXO
/9;Y@>-G&PWTOaV,W+CJH+;1IfLK5YdJQ<;ec[gTNfbX0dZ@C_\H2U>O,?8XR)BS
.E(f9\e4gMZ;HcGK32;VXYZE_fRUTcH\A2Be6/_).K&9#&B7&C==9<Se83O5P#e[
bC0T4T6/OS0/NU?0CcT#\bQ?.-#ULL\TCM.HUf?.62E3R^4OPE&IEFc0c4J]&L(,
/=J5B_7Oc#Y0cfA.BALTJ<E^Zga3@d+(O[7K3<d?XX?T^&:2gTb\-K(ZX:<5HMAM
.WHRK3BE,CFa8(/^[.5g2?X,7g.;AAGYFMD9#2d_>HfLBDU8@1U2LF5PbR<J+)>5
M.JFS#DMB\>N=Z/gCUBS3P>Y?7AJWA3&M,7eJET6I3/1[RWd@DfQE8:Q#F9[U(;e
=?0YO+.0H(.a9_I2PXC&gd]0IR]7;;]a\YVUZ/6Y?W\,<[c.[,cX[NIf>R+LIEM8
a/O(9FDU:_HKcEEZ\G=JN]IT61B<1ITeCB;8-_cZ&XJ-N7+Wc:e/7<KE&bbE-@;e
)J7>3,L2N,AbB2-V[,W9;LVW5JTYPB@0/A;O_<#>;f\TA@^&Q;65?6bZ^&=GK+bH
U2/IOQ5fYSVW0UcD]1N7Pc_,fZTSL84W/=_/<GUJGe9^9//)#-c=#89YAH+T48KN
[7.3;g@9X(cB54PE\IXU0ba4Ua?UK;-+]fTEA)5P>F#:b^7)Oa1g58)#KGMBS6E0
./L.9#N=:YW&R+J0H<N=d2KcX1Pa\3MC;EZ,]D@Bga,Q[5gUM[F;Vg4JJQfJ.97[
=&474Vb[)W0&\5S>BAKHe(;TH,(N5]QOdE;(eH<(TB#e-9;4NZE+AH4=JQM33C0W
/M_H)((7QFW6SDV86U4&RS,C1/0J0A@We@[UC1fC,.c:A4\Ad^2UBMF:MT=.X0,2
beFMK,[8?4IZ>F@Q>Gg\XDOQDg2d1>[eU_JCBDX.(<0YRNNWC;P7U&VTMXa,@8<Z
\dG[39K#gVEQX06f9T_ENHgD<R0e<)F-+6A/C.NX24>=()g-OB>XWOGL64B2gN(+
\X(U#5Zb0e<aIY^-HKOZM_c&KM&83.EAAIOOR:\)3J.eAN5aQX.HRf^4\?;)3?_-
6FZFb4H_MH4SbWJ#?Xe[A<Z\>R?\#:D(bG/?d2FW5gd/#):4??,EdO31C_DQ=8)T
?>>7LCO:a:45D<WDcb.^>PVe^(3H6NbRD>K/J\<B#<CB.K&K6[3_QH>&f@_J>KAb
Z-83(<g@6:)a+6EP5W/-^AN.EO-AM6ZY45=[YfFJF<=1f8;AbZa>UIH-4+b8+N1(
BK]3ReV5H,_X<.=+8Y4T)GdLMX4+9C#FSZ<<2I(acCRHc:U7cNTe/@;3;>AK]]UM
#G)JA^/V-MbPR.XI1@G,?>/_2_[If2^7:+JNY)42R8Q#1XIG0DF@V4bb&fJ2-Fe6
Le3(0[_FG,3bLQd>NI49C=.C:1-,6;+\-T7^AK2\SSS^+7>9/]d:RV/YN_IU)>3)
BK5X2F+(/5aLD[[408KNKSQ5X?Tf<JCaRS,P0aUN\/@e4WJ&F(NM4<a8D/,Z1_Q\
B?LP7e9J_BUKZ#Rb]1GOaXR7G^aQJU2^6D?T7Tb=S/,gUCM>R(H&7+9ZXF@/[V5/
g/V3^3I#eFZ@4KJ0Ue-@5(,I7<5^]@A3S8(K5.W0\SZ436V1e?,M.Z4f8&efI0L>
2]UQ;O-/ge4PQXJU:Md@?;,UT-ADTXV7RDde;UC_O2)7FX89DM9X3aUZB10-Y9ea
Z@\L^95)W2U1a(.6HeGSR(eA:Ce;YM74[MJc-dC.Z52^I<3OB.N,WcaE17LH/LFS
B5KG)MQN:_[R&\V5gQQ03&H3K#N_CbVPS2dC3P7_O/]VYZP,fKTTR/=1BO8U>CYB
@FYMXgUd#&_:U)Xg0<WRIS&W-eHM^B_2DGe+-^:C:5/5C<2DNaffg#4MN8cE#;4#
2NA0>LaW4_(,KH<-\+D0)3,4_cZ=;9>9P?)UI=X8^PI842B]g[FdaTZ=&0\T4BPK
+J[_Q:M+0<aB0#d0fFV\3J5<c2O_fB4B;Y<93;5&8UG4=^29QaZY)9Ge:V_QW?LV
\Rf2XNJ3=a<aSA??2G1Hc9.a3KZS^E3:D^MZS>bLQF>Q:eOP&OUG6IDFLDSAeJ7K
5Ffe^gA_P4U/[<R6,WQB3.TP#;fZ+<OP3<\HRZRU-U7=FFTb@O[/:G8Z4\WW>aAW
3U5_/&@B[(:8Z@&3F(VE6,D#[?L<]TKIJ\Z?N^^A<<0(bD@U:^;^E1+X&IBRH7:5
<AI#d)3266@T^M(./aD<-EZ)PCB.9,W[R7KdAG>e&53;].,-aVM4@>c33&B]Tgc7
X](Pd&\HK.ZA]XX1b/De9T8e8B@,T5&PWe]dOTB3(IeAc-8L)7#.X).P[:dgWK@;
J/X#@1>CF#H@bgE#Z:eUW#8)Y8Q66AF>)Rc\&LgRf-(@P<(WbQM[H]JU]HV/9=U&
;DMSe_1FWVQEBFLZa);(I[=9<J^3WYH,gN+1Q;cOXIdH0BV;=V>(@.\:Kg6\N7]f
gdOLgQ19I)N]75A,e8)I#V777>X<NgS#cgaG_]LI+gg=>/D=5?96^^1gL+;@a@VN
P.+^B2I.E9g+Vg70B@1_WN=8McIB>:HLP?K@PRBY<1ISKJ\fMbgEQDTMJTQ;5dPS
H@WLa]M=#59f^6I)..#G5G4OF,9ZK9G.Y]XXFBHJQYBC-FgO/cM6QSM.?fd+8/b]
U#W,0O]4Ud[ZQ3S(:b0]F3&4:>ZX1e)?V0X6C?5BYC;e]8_31FYXH#XA(]7A,\=9
WM\@E<\4-8J1).8-2EK?.@<B3MJ.aI6Z/O4C1/+-S&6e=BU+Aa-25+WLf5g+(384
VH(=d4T3.dB]&c<](_1_;+6,gg_b;g-b#_I0&1gFX^(RS^#3P[DbdRZ;:O=K,G:;
bA>P#=]TA5;@))(R2B@=<NU5(#4.XL]<]Q+[.54#5aYcJ,>>QY:FB,5gOR;K/YNZ
>4c+ecP+7\YC6>.K9\_Q<2#f&YYHI6A]_GKLODUC)7K@a[F,_L_D[8dIMc&W(/MV
&GgW-+:XFeKC[OOI4fC.J4d/R2,]b8f<4e-8(NC<N\3&S+N/bBEd<[4T8J8G;=FL
#+LI2MaG_eTdAM&EH_LAXSa2JD9>UB2[,;.28F]&QW].Z81CBNW)ZB9<GV5GUXc.
UePW^9P+2H7S&G.R4aS==5K_R^[84EFQX+&X94Uc&.I50?HBI8<8I=)G<PLHH20?
X<B^MWD+Bce@^fT1W)W0B?];bFM.3fD]8XEKD.F>:(FadTB,3C0OG\7T9]_V;4#E
VLFQY&_4QR9)9I@H4/#P5C[6N8cEN#(DA5;NVKd>FKZ&dUZ)7JRX2gDaBFS44NG[
R]GU(#dZUC@8+7\B?&6Q-ORIYCb;e6a:KZB\)N<R2f-,2F^O<-Hc(GG/T1)a9B)<
/5(83F#:D0I-+AW2K;CF<W2[8eR++A\SQ&8LL]6d4a;^/gId5;=#fL+gMBNFS[Xf
DX^#b\W6+ON_8F3_+eGS^C\S]_fK7D57<9\\Jc)B4P^XLeXB0RSRI>N2ALeQU.>J
\[f(f//9;/(gdJ].e(YL@b/5e-cWTNAGa6_@Cd<&.,J\eICV4>2YA,,4[3La=F:F
:T-Hc]E>Q1fCC(G,VN>V?H^=.Ae3;U(4P[76\3Xd=EN0Md(H/YTbTg,9329-BU>W
8LNSg..:/DM\&FdVMgePJV<W3XSV.CCXSgQT55N+UZQ:]494.=:d.PeW(DGV7Beb
SK4g7I(O]&I+e@FeJ0AdYEDUX]0/Y^H(CZ<.@@aKXb<=VCS4/TI1EL@0g)UJgG>9
__1)FQPYbJY7f4P.,d]@7]IMUQ9:D7-J6XX7-<-^Z:)\eZ7S]c^,7<KdF1-X/a7g
JXG\;;TGeXLY@JXNb9L3H((FaEX@TXH?6dXN(9bf6-@.4@.c#1KO<\O&I4-PL@A@
(WcBS+^7R6H(HH4&5R9eNDS5#0KMQZ[e8AZ8O9+1O8g;98D?/41++M7#ffG0(?4e
YZ0aG;(;e-T;3CY?1gNJb6N/O9TP;d?T/,9Q=T0R,KDF?S0bYQA>I631;Tb^-(O2
FN@JH>+&Ua5K;Q9fCOZ=9H1W\SU&X@VA?3#RZdT+;20<U(?L:9C<S&1F7,89G-)R
2&bZ;:9(PW6FC]SFU?#/8F[:5DJXfOSO>R26BP)7Xc>E]VCBK>ZdKQ.TD->=#<aY
\deQ9_e=SeBMYB#(0QD-2Bg4NO97(4EA-0VQU#Q&AC1FF_:0g^[XB]97=;Z5/ARf
e+C<\4/+EW_OC\D2BCLJ>Z,gAYW[,?D#+>1((1D6@<,LbOSg^>U<;f^L3V-+I6;3
Na=J/NbFD0Jc,KU:UHL7@]I<A#7I98L.T&23(95A:Lfe)UIZMT[9IE&U=)gO+DGX
E@Q>VB:4fR>B#KTg_)5XFA&Y?B;ACKH3NH-4,A,dV:I/+.;+XN:0VRK&S<ME-48N
G_ZL1VB1-VKbU^B/Df&5Og&T.:c?SC+#b1Se3UK3F6/AM,M/?g/JPDQcD3#LM&BG
^5aHR,L/JYbM^;.BY3Y^I#2\S[_Af_+GBA\@1B^/5T>X;Ge(>d9;ZAD,Z)cB[W,L
[YeLD-ZZ2b:fe(>JTV+H2GB3,A=O0>MTdLJ7DK/UU:b;TROCH\[6(W:7XOgPNQU6
@<aZ]JS2T^1^-e:>6OHZ)3.6TV\?.\_H.:\7[MV_4(M6c3@;MPW4f=V&MI<;P9HO
^R#27g9dDZN0M[,/YY#0<WS2S47FbH(aFG\S]C<\?O<FARXaF<()]5_/ER^1b9&R
cL]O]aJG-Ab41^-Z0\]-g:=U,eGHI:6_NBg)>-Z.<fed^MYPB\a)6_RJ[C+]?Wd/
A^</ULSRMD@&\@[/B4Ng\NF#)IIW.46C\AecU03=)YU49_F(.=/YX62.H.B:a_F>
1?JIe):I^.gbf8V+7IRLN0OD&YUa^L)3+?G]I54V72Hc@2UCQU3QNR4;&)?UI6bI
=XPD.[SQV<;]LLADSBQcX-B-ag0f8S)-:7<1#4eF]cNA-=Z@Rc&S#ZWfSEQ;SMZa
S+Id;2e864f0S1JCV=X?BQ8F_g,fg.-<FB6#4d6-P>5LR[LZP1_Jf7EUP]/WF6K^
Ufd>CHe6<cA=\[8G>_6[-O3#\SQ98PDW&Y4YT#+,;fFG@d6VSV:PR.1dE0c?SI4=
SeD9^=8f^aH[,O^<^V/5d,2[#S]fW[1R0HUG140@NVY4g7N;U).5KKde_@+68H[N
[R.D<K3\b[I,80T79HbF@a=]O;CLKP7aLP07]4+g91:[XI\)ecP:-J1A41P(OH(U
:5FPTB9YE^:dLcLSfb>+7gBfGW7@)SF&gZC941;O6<1Gb5QSfRCZ2-7_+N&-JV-a
G>.KWKPYTE,<a/11N1AQD[;#+;S2+gKdSF]bA7T8\cfT@PFACZTDg=]<OTe&/9K1
?IP<F-F),DS,=\R98L&B_S>_4cL;Z5C4&gW_4bQRgW98:).X:6AJ&TLYgN_D@f:c
6)HH0\A?[\ecNKZFT/?]2aZX.S=58bOR3@P5:O.129c,gE.;X@#4GGAW@a_f>g.&
AJ&1UBQYA3[\@X8SBNG>]0I@^EX2WQ=OLc1D3]50C,72aD/f>1PU)SJFNc-F:(BG
+_F.HRd?7,81PZ3ZK0M+WcW4b5/5M?L-QCVT0WgFM]P7>71ec4+=_:,](XZDW0gP
[#e/cDTb&HT+#2,1EW&f2Sb:WA+#S3b)bE[9Z,fe2//?10]aH_H1,bB[RRNKHRI0
9?#B)-A)Z<W.3bea>DOd]Z>I+:_-@GYL(+V_CNF)V;0C/MJJ92&/():N@G)d2_:G
6<:&.d=B(@XbLR]\70MfgD(/cGb61(B93,b2+DE?F>J8UEVP0D,Z?F]V[>/XQSQE
;:H^=6)T&dX5&gIT(_(3\b#8(1@2<89;E+g.07PG#Y_d@X58S>EfbM9_ODgH+HR4
/g]W2g:&A.N;F@;SL,HEX24/XFbeT@</<[662;->1_QgCU/A[]I3McK;?4V-A=HO
&BI73f)VbUK7EZ5USOV=WPb;@R90:<8?.?8./X^7gT8:A7a^+=S6H#CA&_E,)A#1
I\(K5egc]R8;)];@2<0F5,Lc\@^C>V<S1U;c?Mc36&UAbV,1-+6CDSJ&52V6P[<G
aN8T719dB4@5S38)>CYB5>9^Z6VFEJbHJ+]OM.7#:0U5d4.c6cM\#bePebRZeZ;K
IIBHIBdZ0bc.XUdI3P2:H^E5fa?AK;dK\&Y6e-_fDT&X@Y5O5-/@9W[\<(a\9&:O
+?O>8_>=ee])86G[/faIO(BfRVdd_E8>(c5(BYEAH\Cd05^7g8:?K,8\NYgW[NaE
HT+/NB_g?T4B-@EX^V])-V0QA3?<:;A-5+g8L=d)eB=#C?SRFS_E?[Bb60gC.389
9_5UJ7LA=6@Z9-[@^M-/DN:^)&,MWV5F&M9F?HI0XM[3@Y?Fe=2LFM-I#Qb@;SWN
XOSGC@K=Q#2Db[W165gR2E[D)VLSU#1^9Wa&X]9Me\/7^<N<^XW,]1T],RHWEB61
6_/]4S\R[:#+55K_W:RP/,IJ[dSA.>4,T0JZ(cBJ-#LLT8,eCJ0b/F)>Ee&fBLR2
Q:C/R=Q.D/?,PYCD>0/]\3[ZE0#\H-I4<db0\2?(Z[e0NA8.;1ePMM\SUb?.eBNd
7UAc,+?-c(G503Q;Y>?N+NWASEU:2\:;C2IL0fYbD[>e114-V4G)dF[CfLJe9b;]
T@:69H<2>d-&AVa:Mgc9B<79(T2g@NB#)Na8UObA1SP&PET;d#68C/cLNQ)T-PB/
&M#Y[A]PR>EBHBee,JWRFMB6VX.UTD38dg/,D#?H@DRVX[(41Ibe@N3\G;e6]WI)
eX[fH.#43)20]Y(JB5(;9,dA^=<TE-00U[.gELJ-GA\W@0.d6_;NA1:GP.PD9(2O
M2#0X0Q/#U(OE4EfegPeJ.gJL9e#e>@^-cY3ZE@&J>DA\O&E;MIe=<)[.D(M31I3
K\9\A(YAUMg\UIM/-O?8=a)QCe.>5>+C:&WDf6O@Mb<)CKAMKYCJTJ.+_GKHZC64
K@40QTG2#4,+9=)][==WLL=dMPLBZWgA=YJDVBEQ;Ve_366fBP&Q+>#Y?]2Q6F&RR$
`endprotected

//vcs_lic_vip_protect
  `protected
97(1K\2=D;QTH5ceMZ:QE6QDc#-S@:,f4L]aU6BTSe9fS;:OIDUb7(8aSB+3N+8]
ZIREe?&(UfV[S:Y4#NIf44_;CJH?^H6g.&>AH[&e633>0<NS0O<#WWgBKMPXH5PD
[)OFE1.6-TA^3W:_]71_TcgS3FTgO9BeG^47++M)KE9=gcU4L&Ng.0/M^E?4Q5bJ
eA-NEE,Cb.?14VX[FR)^B+59XW_G<&Z)U-?[b?L&DG]3U?a.EGa[]#9D]V-fB7G]
:,88MRZ=)TF(TNN>VKE6RPBVDC,IG-aVTEfU<SFAYD#D_UQ8G;)6/U6>6^#B-#5D
\C6YEI<Hf#cXE=f^V2+A]^T5_MKVD+V>4HUA@^:58-/gT,d+^XX72/_FN^@/8)NN
>TT<06(VFLZ00a=V^J))d+HScAQUg[1(@_6LAZAV1K676X-gZQ7D+1DLV_AXN\Ma
7.VePJ,aO99Y&C,4.72OOLFD7=K9?cJBgaOIcH)NOP3Je=DbdcIH,[X?;P89-2B4
;HM\:1E9J)bf3gXGLQU2H:W927XWbVaD?][)9E^5R9EZC=+609/-,ZEHHLd9XB4\
OSOI,\EQ=(Y[4RBU3)];b;X,9)7KMIS)<:-:>P-c]CY+a8V.?<B47Z)<3VP@?=TJ
e.NK98#EeW4KW^;R<Gb+F@Z>dV)UQHBU8[GAd^UcP.>T?^RK;FQ5<LT#gb)1W34<
e.-LUf[A831/NJ-eQJeJZ]5c?;b0#\D9a_U]eRN>8&#0A_=KJ^.2:=+Wb\SKJ3?a
^M,7Q/O]\\Mb(BaDMOR:S@44f-9ULPbNB+NF9..M0M_8U:_V8IE?/OC5D1VaXggd
AH:c7#3?E@TFJ<g&E;@&4P=@g#4UR5?YSfa0R\27LBT#[>SKMNRaB,0>.88[RS.,
;:>N\NbFc?d(Og=T1.M-)?DeF@GW<#[@Y#>_e^DQ<GH#\]0)66#J_Z>2S@T-DOBK
IYSS0&8-M5KM>@TXD-&G[/a?\T0O1T?NM[S7>aQ).TgMW3.VK<B#C/QK#SQ3(gAF
);46TIYP,7N1<2RD,:@GY4OP&EE:\AOMD)6fN2H96TNVDI:3f8;gV9JL]@E1U37g
QJY@MKG67YX8Ef6YeS,.L+_P_W8>?eHQeB5d(KU-HZHf[IU@1M0Nb&cEfd[Q0@Ud
2XUdJMb@6HZ<<X7O7MEV&,1L2Ofg.[d?JW<ER8>GdCOMJg6<dA5DS),gS(_aDHZF
71S1+J#YD6F(=BL1XRcZ#J;RU=ATD@a2/P0]gJ/<_a]7_7;?,O><=]Z,6I]3G:d#
&+E@64.CdSdH4S[\b3=K)N)]ODO+dXCG7eT6KC2g..0>,TgBceK\@FPJCR((fR^)
0IQGF=A\dW:]2.f1#?d6GTTN)JFO+,KS7,VST#<?=LR:QS?BD5=5&3VM^M^Ge&S_
II^af,;>3cKT(T(UZXYcJ@b.>#SG5D.N+ED2HVOKQ<ZYX^N1R83@\FLN=O1STY#0
>K0([GG;0PUSK^aPWD[A2L[R/R,]a,9aQeQdgRQ8&=@6L[45LV8MXEYVPg)<7FZT
V7+D?aKQLT.2&1KV-1VG.,5L9^S-dM1@V=])WeL:J)^6WNM(1Vb@/0?[:<LZ&GgK
_]W\AKRWHE+&NL8-,;?ZJHT>F-YHEGKCPVgY9@2N(1NX#[3B8J481W+=;)MNYb0b
MZ^d=fEdZ<C=,)cNc?P,1+@AcggJE.fe<eaV1>=DS=aEb=F8.YFH7)O1gH<E@Od#
:#525S-3b7P06ICNg#gOM6V;+UOWb&BG#O+S@]&a#8MC,IGXZ[R]eBacB>.E@Wb3
0OZ1f+EGR:7ZXM.FU<^g3\=,4N9/NEX-HDB;.C)52Se(Qb7=L(>@.c2=-YcG:2J1
9O/#T]I[O&DWf.B[I;/?[EMVX>]+_<[BT[+/d2=R@B?@(>PT]TSNSHeN<NIHEY<F
AMM:YBZ>9<FZ92V7+PXUYQdH39]KGHMM#+g4dHZ,f^2eBG-D@CMY;BD_@;:3?:CZ
B4&9AGVZMLUOKTR2ZeIIT@>\cW@=,,F&Of<)LJ8E@ZK)XVSE]ZD&8#K>DB^1UKCb
f(K-VfdB?GJA>&7UYd^UMFDcOG=8#QY-]:=-20b#7/OSB6H#\&cLA-(g)9F#VWS3
1Ob[=K,U:PE\P:eCVANK0X[-Wg\aE9Y^8UOJ<>,,)(Hdc1[([g0fV_9<+50Z#Y7e
^+c:+>^)LQ>g=b1@MYOdU#[W0X0<d,VbKcPB\OO,DM?#BJBNP>R?DR:a0D-T::eT
g_@d_10RX3)KY.eWTd8V0RCI<_82gOGR2]\IgGO+3CEZIB8ZRb^E986#JIecYU74
<8]@(8/MOC(5COPWI#OUX+;)gH^E)A2H^e/,bGH<@D^V>?US5S;gO36D(&<@e4;5
dP,,RKY4U/#JE[+RGQ6\d.Aa)(\H\2=RRCCdHMV@^VCGUZVM[8Z)Y]2M&LE\0VH9
#c-K1,U1?c97DYFLHgT(f[W8[OMB\@8ec:#&.&?=gbQ:;AY)T[@e&(Y-+(@FU4DB
OV=&ad>F^\O.Q#4_T0db__[[2@-XK,E[M\5&YCEF;g]eBOC-;cf.J0.V7-/BFL:B
Ca08e4QUW&a]B?@/0/2<3(LP;_TMP.GO7QTF^cZ^_<-5.aL1CS^M=X/HX#W9GJMH
e&OL=Wd1CA;FBQ=CLf./gEd@[A?B=9JL629F,XIc08H7U\4R^Se43@[FR)@8:.UA
V,,LYeYJ>I2=>T^<5:VQ][Ob6:5AX-a,\\(WQDT5MCb/9[,VOSQJ(g5\PfaFYX7e
7CV3M+b,785FVG.OD[5cS[Y+7OAA\H((8NAFX_3B3B,9Y<&JRJ\RW2EFd.U^e6BO
0]&TcMR^JC202c+1cf/M&LPVPHJ?HR;+&V1HU.I3Wd/G0(O>D<VQ<<BWL2]c?-cb
cX]W6=EW@8R3GI)JdE8eA^4I.9-WJ>P;[H_A[=>b#0a7;2&M>+.PQYWQAK]cUE9<
75EE+#7(#[?-7QQY8,^)]W-05T?+I#d3HddZFET?(3_.;fW@,MM9S3d\8(V-Q&&&
P^G5]<fF,[gZ(3;BYQ/W<BDM)5bA4PRLBg+@0c7JQOPOdY9\@5e#IadXJ?YgcE9+
\^7_R3eG#bIOH;HXAPe5HBR6(>7VXN&].0A0S/GcS\_JGa<Z@7VJgcFc6Nb,d3<H
D6g+dG,@IR3T9T0SVb#8QTKT6d-;DWY]cQ\L(KBI=9<@WH\_^.CW9WVf^D4H@RK1
P03AODGaL3++a0A2V.]N^?G(>)GeF?S05@?5:LN^I-S@SCD>K.^7+bbAU-2-PHQ1
A(=A9\+5Z,C,FC67^M&6LND]3RW+V8Y&S:MKHLL4YIQJEZ7Wd,Vbc(3THPFgYeRY
6NY]F#9/^=G;?g#>RM_]G9UVb_&_]b1<OQ]&C/0(1&dKL516XH7RRBG;BfQBO@+4
BgB8eVLI:Gd/4(HE][_IC,6[D?^ZN_DG8UX@2W[eN7TE4[J#2Na\3F4IL]7@6dQe
afW65Ue(N;6V()E679NC)[#e,1PH[84KBKf<@_+V6DbS\b1[IW9J52\<+/#7)aJF
De0OIMcHf\V570XCPWb>GNFUd4HW84dOUH,NL&=L]M&L&?/;ZP59N16cgc<Rd\Z@
(bW1BdIQRc?1W)RRCH(a]L/C)O@?P_3/UeRcE/C#0=DUKX8^g6^BDg.FG^e.&;I=
YAC,/\L.,#e#f5_QCd5a@6_=>+WgN4&ARH=L8=\DbD87(d2AXE@3<53S636RbG7B
V88Y>2e8Sa,-J;P34f:Y^Cg@:YQ_I+f1_aS[[ZL,Y,JCC4YAQGa<,>EB3_5#C1-6
I\)Yde+[feRb^,284Rb425ReLc0RU0a@dD#JPVADIGdB2;7LV9CYJG\fX_+3QBXW
D6X?MRPSb@d,CCIF+M);8UMM]07b-.3Y+D\2gD?()GJWKDQ#C4?;T33VL6[f\JX&
DCN8P_fIYNgC)O:O-AXZdD:G/K]CaIHK6U_URI4bN.OC+7[PISQ;>ZT-0>6TU/MP
f_K#&,,((3e&0_MK1K-]FNc1G]_RL3&;O6HN,cSD78]0=62AS3EP:)?C2M>;7@d8
L?X?Tb_OSgda0C8EJU(PX.^2(;Ec1UdG5>?3;C=;].cPJI/XX/@ga>X8URO?4dH:
/>/WPYQgADK;_2W7YA?f=08J4JWPAb19YA;^]R:LV)>04GX/OYN.e5T8Ka3UH7?f
,7M:E1;Ad6&TRH?\@,&):3SUX,97e,1[.-=Wc)_#\dNN1M@4^2#]<BSF=NM=WL@L
#2_M]ETBA6DI/feY2J],8G^g,&<J6Y.B57H)S)/WO0;-dLBM338.aR\;bELc#U(A
IKAYG.4L28:OQE#]?gfRL1IN-Y6[PT/5@\AN&QO?+BXWC_N6Q0LQ]F,b[+6VZ/1c
MCP&QO#1/?^ce50NH)_dPUP=D(:RgM8U-&QJD/bX1;WX&MeDT5Ja45H(5@SA#N=+
Q0c^CR(0e588024[4EHe9Y.)SNPGW.8;W;U?[0a4#If6H^XI(^PV8?>7/Y(OE0LD
HQ\1(#7E28b#GO-M3U-L\KLBO6-[-V<W4RYCXX-aE,X.#OTC&D)FCX\@W:b_AH:N
W.49^S/c=2)Zc#\\?PgYeA4C@Q[[J&=N9LUZO+HPXg-NAfd_#4(#Jg56Y/5EU2&T
@^34Q.Vb3>faa6F1(2+>V>SV]d,\g]Tb9,;G\)-^Tga\=8-[L.).TYOa2VX#184Y
g?G^c+T:?H2\H9UJ3H\7NK/_+AH<QA72C0NAe#HYb:4]Q(g09#CdI@<:MYD8_HN-
=N/]PEDT)dV>A]#M.)5\Z\.[Y-=/d#/\,4ONb#^8Ub(EJ6-@daNP(KPYJA88&H<2
[eU21J1-E6O(2bb@@\fbQLdV=4A:/MU#f.W@a81]LaD0.&1ZELS1U<#\8EULC=6O
fA&T@YOK08V.<Nbf7OX.bEe7JN]^E1Z5]b(2V1228e1<J]BO,)0TV\fa_EV&31D\
d3T,PON[XH[Ca)FFa;/O^AOV_BO6_d4-_?2-;#bRJV,[7N&Oe\9X]3NUg#]96g(9
+M,d7[(7CN4b[:93,F6)GOd1R^[&dgJS5VO2.&GObUIX88+FC6)H.>/D86@Z.#aM
?BB0U(XKIFIIJ;HZU0/7Y1:B,N8K>)WME;EbIeJV(G96V\K#8H(5I6:Aag9&5:]H
F1F6EFdQf]QCVcc1Y=R;[U(ccE79:AD/TMGgU1=Q\@=J,GY:_a([)dRG9SX+7BAO
K.84H]Sa,00;J46DHZVdYOI0d(beJ<:D:H]^EOB3KfG:cF8fI,TVJ^(=,8f^FKdU
.OeN9@1f;]OAI9/c+;UA,\9#FCRI_#V)c[HO96<=<^/VX,2g@S(e4?DS,,NVS4A_
EW65_</OY^XB61g=2(Cc:eX[Q15Ua=LcbR[\.N_0eU+1;8#JA?GaO\aQNBPK@fCW
A_8X#H0VK[+I,aM_d-KNX\=<W\WHJ1<I)4S6RA2Z6]8AGER4e,6#\8/8/S4f;X&f
SP&NP\aX^TLU(F=_JE0:=P-_VS.31;e\S[2SNJa-gJI->F_Q@Z93ZDUYQTW?6\=4
K)FeF)\T@I:/1DWg@7=8&)RO7?F<+X(^X_IA4A?.;E+XZb1M&ee7HeU.gED6EbXU
gM=9+WL_>WE-&=8<F?(HBNgIeWNX+W)g0P2<VOeHJbW4CGK?cEKa4MHPJ-_7TS7?
/K97NP42X>4@a?GgUAVPE)gd>(DS)e47L^CSF6QE7(B5]>c[VG:BE4-/P=9AO>GD
81^?5QAb>?MIH>9(_Q[84g@&BeZ6WNZH+BRD6Uf2Sc/\L;JgFZYIQ0UO)20[a_F@
O.Q;1Q\HHQOQ+64O.\>:fBd+3\Ud+c06EL,6.H(RYbDB(?\&eTMXKA;Q8SZJg.Zf
N]+)9Q,b_84V]F4P4EO0CgZB\<KG]V/6,B2SI.(-)R:&R)^TJSG/5+)>C960?X)&
OcMQ2874G;B+a6V3VU#5=4,:4.S_MC9C8?_.W/S:_ESEeR0e59[W@X=.(@6F<DW/
[.).RK#eRS#feKD@AT^>6-GZP2d_bEZO7gF+V]>MRXe\3L^NTQL9>B@UMTC@&0N)
)UP,I33R7]gMb6De4WL>HX,fF/<JI^4;:)(V:&IWSBdY;W6Z[Ja4>Y7UF36#MS=Y
_]50dY6a+TN2Z0S+Ob@>0?T(N[]N:#79X71F#C8E(8H7?O?LXH7G\_TEA^@E3UYV
5/)4cOCS7<>c&WC]-<Q)6>?IQWfLX-2f3VYCB/RG]SR:61LIF4fJ3Z1.c3deMDU&
#N[XLa^@J9.(bCRO+<D/fa#_gREe6WK>FMf;&4Pb+0>>_[[E6O=I0b?0)H/A:)QA
dg\6ML-?=4:/Wa\<0]N)W<;fNWO,:gc92@4a5\2?1/-Y37TYXKM6<_SQ0;M8@ZaX
V:Y7UB,a<4dTcT-TM.J8TO]e;Ha4JF/(.2TN)VR\M\d5HA^W&5W+]R(]f<g5=5P_
?6F>^(;aLgE47CbfP&=WF337Kd[-dP_UKaI)4WL01]PU\/+RZ)5.,N;?]BOY&d^7
#I[/[^P^)0&?R[6M6.M#+WXTaNSK3.d0O=b_@&WR4J91WBK@S/5I1fTES8:,XDCb
V3C^TF,F_2(F\H->b>7Zb7?)#?DM,c.SF[]ZJ>](4RI,]9fF?HcC]U4#(a=[2Va(
0=f9NdQ0;Ua>790W_6F7Y^]4BVHNE\9M_.Z:_M22H0OM1P97+3#)5-deNee/J0J7
#c\T[@)O>QG:E#H0:3a2O5N4g26<@g-KEb_].SW.I+Z0,D-:B0,2B3MK&T..2#Fd
=c4N2UXU2&(+/HBOCE;L<<^(OS1#>AN7M44BN?,;ZCXB9(00=+RE>W]E7,G.dA[-
DV&HZUW-MZ.+2JMSIJS#-^GQIJUALSH@^Egfg0TVdR<^GB:[3?DC;MQ17P\4)e(#
;O;<3:04efceFYcCEfU:](2ae[[[HTIG31^U6agTLH<^JH.HH=0[?F;70H,OAGWS
BF[T_(=R<>eC(2D=,1e3.X4K9U0/3RV28gHe-<b+U4M;:@JeS(1/P>69ge9RdFS9
-.)]<4T^<&Y<N5+C9@K=:F9[A#G:De733-V5OFdF3Kg^T[ME\&6-;g6EBXQ=8e8U
H,TNB^C)2c<VSZMQ[KWeHSHAf:a6XITX>,UU?E.H\PD.JZg+:NVBC+]g8bcgeDH8
N)L9gfL>)LR5Hb;U(O(CcNPcW-3T]SPFRUU.3?P4YOS<1,6eP7Cbf,^D=#M;_]@V
e,X&85FQXaYNCZ?7WMN1cC?Z#.gI\8.\N;+4f_G-.+e4b7NW4@M-TLLPQ7L2Jc:5
W;I@1de2N]bBN9cf&c8GdNY7/fH1c5L/Z<^F<b3;^QVMR1OCKR#aID4S7K4A]M.X
.:^^ZY5,>,ME_gfG#;[-gd&UP:8g3Z81ReMCJ+(+BG;08B=6IU:1-\c-9;]Q8(Ia
G,XaL30LTB0B@?6C6FPU.=206GReF<^WI)TB2d9LfP,Z,?cVT?>>=I<DSBZIOc3(
<D0IE3J+bM>:a?&Y0;&d#6M?<G_VD&[;YLL2YF[TL\fBd_QE4Y1>&5<IbB/ZZgNM
97f3+6D;_V8L[YYQ_FHfbS<PP,W93V4IZP76WO66db3;^6B^</I9TEAAT^^/_.EH
3:-f1?:QAEK9:HV>OB)7K^DLER4[44,=+=L=>J@gSP=AZ.>EN#P-5:>H(BD?ggH/
?1LXa3/B9&TG4JK52_N09fPA&@VB723:JcgdS8@Zff(,4QK@Of68Q7QSWH4H)UHH
Te^:<0JEPUd],[X+6?bXHD15KITOc;&P2cKE:X.?:2))A+NIL[^fF9^FW.2F<Ff4
EAe9\N11Q(_XNZL(+A,23S[0dZaaUD;QU&:+E61d\1;#)((BT?=QYdA&GRL2d/4I
0:2=Ya;W=CEcd=_(;V1WJ\T\ad_d7(;44+T)ELQ)(0>#R,ca4__4TT7LE(e11DL(
KI635CH0-?gEO]#<10E/V0S5]8e(C==(O/dU>A)[)M-L,P?XC,0.e??9L;?+5g].
T<FPI+OKgA&M-2IC6#T--#OFbQI?X9WSHddfP/(:.1+_EdHf[PD^89ac4X<H;Z)[
>[RZA#69CdG8(,#9UgRQ1N&0+fg(9I]:[XTBV[W^T9.2,,,R,Y3:MM>1-1MY;3<;
\Mb?<^N_WY8)_HPZ[873T8X+?1IZ0K@?-LfORDJR2SKUAB_F;EfT/,38\JDX(GFV
:#N,D[a11.#UQ6/]R41Q=DN^[[Hf(Z?SU9)L[c?[2HA)ZO?OA][5a.5cDNZ33Rd0
;Se2bAO;47KM8KX_4eDbWb#FGY55]RI>JU-+0:VE+\0R^].d>UEA:&1&d?W30CKI
2d/g#O3dY.R9(9SP>Ca4]F<SG_9;ZF/4)8FPC[Q(QVMFC06aJ=EEf1<58Fe&YK->
7A2WfEL^3RQZL.fBF-&WDY5<W\]72dYF=5-?=[)1ES2_#/dP4Y.,W)A074@CLB2(
P1_bgJ\>,=9&_8[?N:OV&N&-_0,Y(E)8B4aCEH\Z=?]b\/6N)Q_D6-=QCVTUc2OM
^P#4AR(B1W<71#d7&CS#E<2<0_0fdUZJ?X^/JLY&(F04DGP4YF)>ORd3aO92C=ZX
E9\MF@M.X/Q;_e+=P\gP>Ja2\&,RRS8H=P_W.eQM3S7Q6AaYgDEgHH5,e([gVff8
U+-1T0JXDeK89Q^==9>\>TC8EH(B0)^T-[VR23(g^8CN=IHeEG(gS1,bR,Rf;@/E
DE((DW]&V:HD(B+JYU[7YD[2;a1Y7/fCAHR1ELK&K6EfbfDWF)dW5IO/(O4;b7P=
e(Md^EH.TA^2BHE,cL@RDa:+A34CT].PM+;[#Y8Aa(OB,ZFBOFLRP#801I+ME\&6
Z;_6?H5V^:5X-X2D^Pf.f1/c0UV50K@eMG3-bWQRf:D>?dgX-L=dJ<T&JRO2G\,9
&TH2=8D/X_U5X5FJf[<[5PO+WGdg[H0)O(6XUdE,TSgBdHG9EWd,XQ24IE5<YKVd
,JQb=V4I284YK+<ab-aN8FgQ=S05MW0eD<4F(8<<>+81\?/[41Sg/f_H]+f=-O7g
BVD^)f2T#\fKR#XY=C4=K;9.@=3aGafB:J2=0&>S@H_BL@,W(+_1;3+KCcKI5VFd
Z=-_T([BYMe>=e]P9Td@V0I3ZL1IU,0D]:acJaP,?9V?f<ECEN44NS#WNJKfR\eL
9W.>LDV)&SQ7cf7YU(789aZ]>(:=87Ja5XM#@]=aO;NYf;_W:8.A@B&&5M\O=M1_
Ub8_5&bD0NGXTV?>?5@\)DELAFe)KAYAKXF.VZEEa39U+?+.(^>+WEcX_b]27.\K
#BNJT2Oe7N(A49.,]I3?I^>FRNQQ+;V&?C8:0Q.)TRFQ[=AFV7XWOTI>SP88+B-=
@\GBJf@d4;^P=0MFIHdU0;E8A8b>VV;^7<FD1W)(UKff?e_Z;+J104O1dI\FAKW(
N2LVe.^fYRI@69WfUa[J_923ITU7K6V0=[\K>g/#P#MINJMB@^fP2IH7[WF@\6@G
?X2<\WL]F[[_f>+0aT#:N=)I.PX_?IK;.?UUNGB7Qd9CCH0d.Z?V9=;e<eP1d,-\
8cfY<;-V@NW&(3;5M[?UQ-=LEf8;WEUHPYJ5(4WNTcO1)=b2eHX6a._AD_@Q5/+g
;&G+Y#gb)4,STJGTb_b34ZLd\^,1d2(VF=QQSJE0a&^.>M2[TR4HS@7YLU?96FB9
AK/=MF_16=FF[],L:<CTE<I6]Z^LGK3\^N?Y\Ec#KB3J:9O(@@g>L5fW]P-58X60
9d#.FA2GWc>:bAZ08F9J3F4;H+STEZS^,(+;\NU7d+6QEM06PGGYUA0SJa96EH8P
&,4<c.EeTTdLfbaUJDOc)X0\O^Cf^5fE8:bL-6-/Aa=3YgG^\J#O_P2CC_De\aER
ZfZ]^:R0]f+a,2e77CSK^HAcE/@:88<-[_D#Y_V]Y9+XI545^c?Da/g7a5ZINXTH
@J?ZKWE?S-_Y\3](9E^=IaGAHgNHEH00HM@WcaQZQX\V]Y4ff&U]L]^3-8F#a-a&
9UHL:+[aY\P]JFF4MGN2=A^fYPbAY8;\1G5Vd72#5)1ASBed/H:?U?72VD7gJ:ec
MT#/O>46/AOW<9@.H9Rd/[G],4E(9[WW,^V_3N9bEbWI?XLG25RS5GKf)B1?/=U@
^f/3T9-USILH(H?-ZPVbS7e#>C_-R(<=>$
`endprotected


`endif

