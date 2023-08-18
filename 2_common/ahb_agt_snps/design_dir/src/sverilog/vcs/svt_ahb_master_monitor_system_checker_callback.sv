`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV


// =============================================================================
/**
 * The svt_ahb_master_monitor_system_checker_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */
class svt_ahb_master_monitor_system_checker_callback extends svt_ahb_master_monitor_callback;

  svt_ahb_master_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from master to IC */
  svt_ahb_master_transaction_channel ahb_master_transaction_fifo;
  /** Channel through which checker gets transactions initiated from master to IC - Used by AMBA System Monitor */
  svt_ahb_master_transaction_channel amba_ahb_master_transaction_fifo;
  `endif

`protected
R>,CRJ9.]<GY9O_FBBP,M]KVG]?_](ac3\G9De?45aW_6]@3_\>2,)GC)?a&NCUL
/3fCQ,0)4C[d5:f]A7.AKU4IGHX\):F&\S,EJCQCKGJA;<TLQ:Wfa-R-a@W)F+6L
0&TNML93.BT-:=8;Y;AQLJZBNQ<QcHSGWa._:E#aGIOR]:(8HRG^E586VU./gP7_
a7;P7fXc8O&?3A,5=a^8]3:[A+3[(cFQGCSLaFOZ4_#WG4F^6#@N3TRS\>3#O(CQ
OPIY)a&TX3347DONG^]Z0c(91(QT0-YfE9Ma0>ZE[-]Z,0&)5?.T9G(KO?4WI66:
S@IKCJ7UO2J-KUR<@<YR,c6W[LU]J;N]^BII>Fg+D\H9a30)06L_?gJAA1dNO@3Q
aPV+-;Pg7Tdg@=e2HgOH.S.9-,ZW(@UTLb5G;2(]MA?1^5;M2&O1H,F,\d\:\/23
2<d_Y?1#b>@d+C9aMS3a]R9.CLK,_Z9BQKJD>#UBO)EaJUQOTC=_e/W<46(AOL,Z
#W=TIB=DI4?c]#@<[cNE[Q?P&d:O,[34bG#^MU:#A>[#cE9QR+PHQ@>/XRP\3YTS
@8+Q[-NZ?fLETcXF9Y0>=?#CXUK0#(T8<b06\98K(Q#-]>3RQTdJR#&cK?4Z@0M.
c,TIfL/7+ePE+$
`endprotected
  

//vcs_vip_protect
`protected
18MQIRYFT,F=?3:S:?3ICPE6g4M/RXFN;3]FO483LXCeMMaJ_L3,+(E^6H[(\(CF
C34P5_C(P+-LDTXHEGaF_W39OEACY#/<FA,K:[URPWdQA;Of[C<a+A4^>?g,QaU/
HK^fN(&1QN^\Q8H^S]7?F(-?8+BB.+IGaS+_dQ98aNX<+d<,1H3AW7PX^Kd:6,<L
LJdf.b2Ne1g^.5W()>^.IA9E&:V8CCILd,.WZOJ\f(9TV_gX4R<5Z92(/H(6JCT6
3@^)MgC;d6TWW7U\SBAV#Y\ca0M?<P9O70P@P#6A4,A^@QP>1MGaW@_]3.&E6T;#
_,e0=/Q5=)aMJ@([^C9[L/U^F[N.NUd,W)3Z]aPa?^UJG)H&9(EF@86[J^LVNXAD
0)\8@=R7-\;_TJG6&(RG6W4f2;6MHDC2PG[3XXc+UUN)Wb-.565fL9&)<N9.2\F8
-.cC-K4>:gYE@W4)G,+4WN)+R1C)ZX(4-9Y&=ZKA2^JcQQR&E_7,,MPWXb?RNL+D
6Nc1HIJ_9OTTW0YM6@f(RBCF]TYR>4<VdEA(,F<YEJOBRaU<VWI-F/]4Qf41WAb2
:]g./[W0/XZVE@2L#F-?BMH[R+1<PXK7:BC=bc:^3aRR1S+,(ZX<Ua72I3LEcf_b
<+0FEHHK=K\B:JFX>-U8[2c]FE-H\E#Z^>></M<+J&[&]fYVX7J>CQ\G6DSIRCYV
LW,<T-V.MEHL=[7Hb6;UF?3Tc9.QXI_I]5&4eOH2;]VOVAcC,cOUeB_M&MVeJW0(
TJ\/GJK?9G7KXa+e=)/[JS1:M1:1+MQ(2^6.&Td=P[J</PS006P&FWL(,=CZ8CI_
FE:WZI9EG&?JOb_.4EK0@<[^JBJO.W\MV14R&#2F6e_;C-Hf(8_]Z8M+TVXOgDM]
UXDEdVU&969N=5^@2^E=(H1=:2M.WH4]QIH])fgIX3V9?+E/^AGdDaGV;PW##dGO
XTfXBDY^T.CY>:-AL@J.GN\<K147b@Eg)<Vf/91U4CA,L+1LJPF?A_Ob:,-+KORK
B6XZ4TGSEG1geP-JFQ8gZMO6D(FV^?<EABR]Wb.g1]P)g-_8VGH,C/^Z1Ib=(f6B
@Z<gg@YHT2KgTW;:3)TQ&O?cF=(+M2:LF#._(cH[dOdV@M8UHfa@V=4N<<NJ:Z,G
5F#d:6:]KD_?JMXgcFQGW8LW+OXMY-,B>>\g.RL7^@J5M.[^cP[]V,-gd1<W?dQ_
EYE]eeP(\TV,JYPX#B/:&&5OY,]4C?P[4/T+6eH3/P=LCeSc8QAL(7T@OF[VH#N4
@H/Gc^OE/I.H-(WLU7M4(/J(WLf=]?QHbKcCQ;]5KUQ7PAf3JW^62JL+\\QU3a>^
]U&&XAYf7XAF)Mf4P<c09/BCED>C?2SgPI4XS@QH<W[D1Sb84-GK8&/=+L4_HP+Y
Y;,F=dfgOKRZ@XaefNUWWId/?&..d4LG?_]W0JKU@)U=N_7U8;5B_N.4a:T6b>Y?
7d@L+dH5F_>COM=DGE.7c)7FM,C)J8-)-+MJ6A-^FDb_fc9A5;_C516++[c0M>3P
>/^5N=9b^WWJ<(>&6G:3>T?XSeY-Z5b/7eDEge:9[-X<TJIVA&ACfFDcc+?D;DL7
fc(UB&P;AePEDA0/cJ@<N8WV6g_&2,#8#d:@dSG>\VP5Q2<\fUXB=HFC3U:KDQ-\
/35;Ac,Y\MUe6?,9J-T2O<cEVP.,g-[2]<fXJdI\d<(WfW@4BSgCB>dNF<LTIO=T
O4[bY7JIYdNJfW)([=.0;PdcggG<cV2UIDW/@5,@H;HN0WC.#:d(?ND3S\FPM-.B
QQ\EG,QC_G(:SQKAYTF=V_RYZYR#/8@#(ISYOKA;4YgP>KHa2)@D,HJRT(ZY929K
gYSG?/=bZS>;O_AF>;SJDO5#I41A&?XfK8Z;A6,N=Kd7->^#]3fRQ)P#CJ=>9(I0
T)\@9f=,<EOe;QS_CZQ^4C7Q[,,N)Da_KEAR;)/XE+IP[RQJ6W<.;J_aCe[\,QH\
8>KO8Tf09EC49UPD.OQf2@\)A\3>[BCX&@WfaR4H7Nf^CX5?M3MAAYP=HBL4ZKP)
Gb?,b7KE-2K)3d#:N^OFe^d3f76aaYgXc;bV:X&0bS]?8?OfGG+A&[+99Q#9c.)e
9[:K?CR,HND9;d&^57,0V7c(:+#(LN.J?N)[QffN\(a=/d0M.&2]C3/U3_+WEC.?
#.3#A[3(?a#Z3Y+)H+C0fHc(7$
`endprotected

endclass : svt_ahb_master_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
