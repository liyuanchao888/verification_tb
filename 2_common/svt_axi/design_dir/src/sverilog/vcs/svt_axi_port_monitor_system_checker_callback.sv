`ifndef GUARD_SVT_AXI_PORT_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AXI_PORT_MONITOR_SYSTEM_CHECKER_CALLBACK_SV

// =============================================================================
/**
 * The svt_axi_port_monitor_system_checker_callback class is extended from the
 * #svt_axi_port_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_axi_port_monitor_system_checker_callback extends svt_axi_port_monitor_callback;

  svt_axi_port_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_axi_transaction are put */ 
  uvm_tlm_fifo#(svt_axi_transaction)  axi_transaction_fifo;

  /** Fifo into which transactions of type svt_axi_transaction are put - for consumption of AMBA system monitor */ 
  uvm_tlm_fifo#(svt_axi_transaction)  amba_axi_transaction_fifo;

  /** Fifo into which snoop transactions are put */ 
  uvm_tlm_fifo#(svt_axi_snoop_transaction)  axi_snoop_transaction_fifo;

  /** FIFO into which transactions from the interconnect scheduler are put */
  uvm_tlm_fifo#(svt_axi_transaction) axi_ic_scheduler_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_axi_transaction are put */ 
  tlm_fifo#(svt_axi_transaction)  axi_transaction_fifo;

  /** Fifo into which transactions of type svt_axi_transaction are put - for consumption of AMBA system monitor*/ 
  tlm_fifo#(svt_axi_transaction)  amba_axi_transaction_fifo;

  /** Fifo into which snoop transactions are put */ 
  tlm_fifo#(svt_axi_snoop_transaction)  axi_snoop_transaction_fifo;

  /** FIFO into which transactions from the interconnect scheduler are put */
  tlm_fifo#(svt_axi_transaction) axi_ic_scheduler_transaction_fifo;
  `else

  vmm_log log;

  /** Channel through which checker gets transactions initiated from master to IC */
  svt_axi_transaction_channel axi_transaction_fifo;

  /** Channel through which checker gets transactions initiated from master to IC - for consumption of AMBA system monitor*/
  svt_axi_transaction_channel amba_axi_transaction_fifo;

  /** Channel through which checker gets transactions initiated from IC to slave */
  svt_axi_snoop_transaction_channel axi_snoop_transaction_fifo;

  /** Channel through which checker gets transactions initiated from IC scheduler port */
  svt_axi_transaction_channel axi_ic_scheduler_transaction_fifo;

  `endif

`protected
JN0EML_IXQI@YB&GeKAb@S7L<;XISf;<dC4;>V4&.E;(]SaUD+;/5)&EP>N_S78-
;ASLZ?7d/F^/[FM]Y)OLG85+#2Ve:E];Rb5=#T#);cY.AHH/A?[Q6Mc\0D0QT8X-
We_NVE>>Ac3;3;:W1:McGW;MbgKYMSS4;(ZUa17#Z,AP[8Z&D4?+RDJBT,I<:b74
LA:e:>Q2]L1gbA@0.=9#/<+V8D#18BH>)@\_:f53;N@\&:3,GJ\EP9J/d3JHKOfe
QF\R;OZTEHOVa0c:561^+CC40?Z[Mb,:6bXD2G<1J+C7Z?>3(g>^J)?DWf?_=g?a
2M?S;WL^3RDbI24)?S0+D_0N.D5Ed\g@55^45O/>6C)G?M^BG8T+133S#;Yaf7\H
&aR@X(f-f3aZ9fUX+e0dU3FKT_C@eOT-@2SQIJ3Ec22&+8\YM;_#.F/-2I:4M(,a
KYKOe6@GO.:5?[[84;_d]&ZN72Z8Z_J#\<cF(=3IM\.9[g4D^441]QO-8M:HC^0c
1HGW/+TZ7.Lb=++00:4D>3UXdf-P=)CEV;HM/fE5Yb+:BZ-f_NfP5NDU3L_QIQZZ
>X/50AS[>XaP?b-)/]\Q)7A2:3G_U,;588#14UTS,8I#O.78]URdgcWSPYISAg53
;O7[\9)<JVZY8SJ&<NbIC;Y+bQU#;#3K^g#S.EVGQE[PD=+TCQ.X4(1?L>OI5MPN
.4,Kb00XFKD>-?RZ0IHYgc>3+0;8(-[&23ff=NX[8=;CK/99H9b6[Y2c-K94GO29
Lc-bE6^?(-(bdN0:<S5Eb:/=6P0\L_X(,#aGF8E>_H)_Y2O]V2;Q609S^UV,.1eK
F2O#aaIG6X<:KM_1)KG&KDdE0cb<E^H/dN77.I]]>?Y\Y49g7?^[#GK=S/:DKB))
Z]0:)a?I1^-TbGH1<4:R.)aW+OA5),.M:>(,EI5Q:F<9ATL3,:dDWJXa<]X&NNVe
^&[a?8e^MeaJ.:4P=K;TULU\e?CBPf;D.1.9_gTOJ5f_LIR8_e,d\RWa[>X@QJY7
ZN;;H_)1;E=d<SP2dZQ+bJX&d9,T22d,Q1TBA()g?\>]X9dUcgMfQ-Re>WOTD\P3
9-0DBAc@V@VFES&\RK)76b7bBQ@4^BaR-F?5F\TL_L-VE6g^AADd_Z^7<AR^Z2?N
XFBW7H/AL0AGB&)JcQ2;DO2K>fI9C0S7/<:+(BO>J:?e+^W5\S5I9:T&JN4H4GCb
0:--35ZBG)23<(.bMNF?5_Sd>:BcRK#[)LS;4QaW;\ZIV5;P^\0NL</EUY),AQH>
DZJg,F@?]9PCbKMS&V&J?)g#,+Ya0Q06#[7+E/EQHBMX5#U@dJO,L5CJOGaae,A,
WUCI16O#5BY?>:F)?NA4PABF.>42Jgg]&73OD@M4Y#X;E]2dg?QVK[,gPP@0g;?A
.?P;U#?OF+HWKGQ(1I=2ASM7&IJ:^AbKQEZLR@d7[RPHY8,.2P<FXc24gHHY/Y;1
_06LfYK7Bf/FB&I?1BQE[X3aM3B\&f_Q/66M3Md<>(;C1R],8Rfc(S6DADT>+WX^
H?B[SM3WMD5DCgQNJHBL#I]9G]2#[Kf0M2I_5ac8dR5,6(.,.eA94[ZEI7Dg/bER
.@6)D/MT9RR;E,-ESVO/=f_3\.A\4MXg5U#WeU\)bf+ITc-[1?E(0HY(eAJN6XVE
],6O.Jc-+A31/,31QZ0g1geTa[=,KH>8FdI.N5gLSG;].6eV6G8Y^AXW)SA50U/O
RDW#E9+=EG_1Q=a>fQ/K</Hg^PNd[MM>-<#_82fAd8F]IR+3B5f;?cgUYN1^?JA?
WfQVW<&J@DXZ9P.0UN<Jf6_g.#CJ]BHWZ9(eI1FaQZ5&EWNT6d&?X;d\fANA7?VY
,BCOC4&_E3MU:^J&-C,\=Hacg1OdT[g)=&,9AcT,c51^T?g3\#U+3BO>+Xb]UDSX
3AcW\>JEV/7V8D:4K]8D5M1b2XQ\#<JK1/&DN9(#\YMIBdc+Y^Q5?@R@0GTFTPX0
c<Z^YYE;;N?XKA2WPWNg;1Y4g7<fU&bEV3#,-?#63QO-^Ia+L]MZHLTB[Qc^A=>d
^.6^3Q&>^Ac]f^d3_C,eZF.A31b8J^9[[X;&?NO-T9[W>P1AT=Y))8J+1V@=,g8Z
NYC/X\33Y;We@BUQ@)2aZ8Ic:6T)F7M^_O)aLLUWQ=W[3)&\&_<WYP^THTGa677V
98gQE2[=6&205N,e;]FUK])O3e1e\\Ab6WBe\M2JQG-B09^<EWCWWK/Re@,^CeF:
L&?>YC+X@b/2CZWbX@2]F5H3;Dg?TF,]ZBPf&EN,PK<6,>)^G=#Z#9)E=bCUB(G.
WG\)d@JD&SW04PB3^7SHFG6?(MT.N+5WG<G_[./@(:;L7YJ/4W>U,SeWC.D@7aN)
2Y]CA6>fb;.C(^L2-d=VVVgYWFNB2a)C).BZET?g--g]cZ7FRaWWRX2,BK+@SZ?(
@<6CK4:5.YB:FU\:Pg?U3V]e7W8IU1?BDIf#3.?TZO<R/NcHY&I,,c4@ID:YA1R>
#7UE8I3+Sc8J:)_a#aKG<Y>eG)Y-;W[JBKDY:^:53;ZM-^[e:T=7)=/\V9=fcYZM
_(>O;&+B&NQYbAIc1P4ICPbfIC22=XgWB?,[<Sac6(EXJYG486C1[,VTg2f>_AS;
CSP>Eg1Q1OM7.HG)-C3+N-EF;G])/5Q2,fO<b^MZTCQdG2@7+S5797_,[;MIfdK]
daUH+B15&WBJH].e.KZAeLA_c@cZe2K6F7;Yb(28]6[\##4M05;AB)4.\<=eMaS3
42I_9;P(M\Md3GN_D8CIO-PQEAS(;R\(=/TP+PYAFW0-/K8&QB76)&52IcDCO[79
b(HGIBbPAL<e4N0daa^UH4G&01cd6K-@:C<^cRa#FLaW7[.DE0J_>5[d]V9P^[WT
(dC6^:W5#1?6NY;-D<+AgRR[UNT6D=b2-HB0.9H00<g;1]fB(UTP7DX21?W>L_IM
FH2EY82>b5(F0PMBEU,.GL+Qf3FGA+-QRe)BL<_ad6JZ(XC2@fG^1E?>:EUaDU?[
+\80/_Q?EKJT_>:6XYYIW8C]DIAKH6_.O9&HK;:&TJ_c5LFR3Q5d:+Y[]M4?Md=2
H.UA0AL3J.EZe>D_>?<D3Mc1Sa)VTG:MINee_NY\G47dM/5ZVU\)b-S[O/dZ;g^L
W8a+NSE>JQ;fgTEb,G2bOdY+6?CGf.ZTAUXW\XH,SI,039/M)K=W.=9HeZ+Ja\NP
T1:8:_-gI9Z3b(C[eLc&BRQ1&U+RV\?/L>[b2d?PYM+&8AJL[]XP]TE<Dd-+c:XB
HdWG>S\2BN3bG6C]3:KUO37L2QaIGO6e2,N/0,d[C1]Vb?^DL@cU/fa:=DHL[5QK
J)8G;8IK1#-]6TH@.9C:&WEQMUG>e2)HC;H:bYba\1BN&&a6YLZDf/[R7Y6?<Ma0
HcbXb._RM>K6=JHB:5;0bdO\dF>T&O^S^V4eHYGASa8[WHJDcEV_.FYaV6+e]PGA
LaaWA==O(/Yc/)=6@<7VEV5N,0\K1_J^[1<69+MJ+0bXV[e;;>CV3bF6Q#_451&I
ad5e>?RcNH;e\Wf3V7#3TBNXebO3;Fe3PY-D(7XUV1[Dc\.Nd8+X)O4G#8TL)N0/
Le0@])eF&W1)+=+<d3R6Xe>/>:Ja0PUf,@LS=DN;[53]XdM5Q&S-G6#7[C_PIL6<
,/(#,XQ61b)0Rc0/O?HJf+>#+-e35)Y^8<&1ZT=]MbH^<Q5Qe4JTH/SVL3J4SN?g
+G-^5[9U3X@AWX;F8;8D;IA,IUY+<;<CX?g-Q.G9cP-7HP.9>_\Q?8NA?-;DB4YN
-41b?HG0\[dcF9X&59LQ-C[21[GKcU[4V2V9ga\aQg69E@///J9(9BcY1<KPW-3V
V([?_T:)76#0e/?O:=)f.+O=1JVF,=^G8_9Q7?&(=c7#R<U0^7G[=H/T]J33bDAC
-_.H[)ADA+d?8TU?0gN)(;<M=P^KSdd7?6N)6W++DcWVOB=#58B+S>@Ne4T0T/CT
HJIgK6:>Ba[ca,@K@JI+XERf0(7R>WJT9JQ>G^c&D7^cAJ\3OC4KV^?NZ[@CfEbV
XfM;MKa=^I0S9gF<c^UWE#;Q+4OO@Tbe<_XID?T7f4CB:T85?;<<)9(?^B8dB>[Q
+#)<7f-1[K\LTMD:<ZMfRCY^WUQ)G5/c[-EdH@EWEZP+W,^\.]E0aL<ddO]B&KKV
1HD58dbFOO5GL[<\E<=+NWAgF>cKUd6d:beI24c9R-[>V15CR@&J4.O0@^[-T)IP
<8HN@;c7-KWH2g7.ccF[PO_L+R9J4_:G.H7>5Z50RCPR:cbX+23_Ca/Y2HBV.?F:
=.,X_6K6X+&<)bDHE9Cc4_NgQcbZCXHf&EJRZJZGfE&\K&5A^QW+-Z(<2)/S@bdS
MI/>E8YSfL512e(SeGSR=bX6?EK366g,UN@V&MSHf13(G@W/(Ae.8Wc&K]0K@W]Y
R^1B-2M5GEZ+X:4G(4#@91;cHdC)-]H54?_YcCLEH-_\Pa=a6g:[@b#6AA9@OUF#
Eef<#U_U3&aZ2S5DII=+<cfdH4?L1O?P\;b5[e7;AI#V=W[ddT^-K_JJ5:F<dX&A
SEIgf@@Y@<US[MOB2Fd]ZE>JJXM(RO,-56VT2)9+6L6Y;/1U;Y<:0.H/D3WU,)TV
;&gb@47PN5K[O.1+R,Y;+\I@&0c,;;ZHZT9;NH5E(CY?KDTWE;^OWdSR_0PJAJ.@
K[BU0YL@HY\[:?,b-])3E-;]f#b?<(RR3N@Rc,6PXE1?FO8QSDLSM1J(W@9]F>1J
9:,,a;BLgP8VHb3ObXA_:GKFNIf--(K/<9;/GW[BIe77ULU<NUQ\>7N3:IX1<=36
L\+8>bU+>0F7P1A&Ed@9JBKF4$
`endprotected


endclass : svt_axi_port_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AXI_PORT_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
