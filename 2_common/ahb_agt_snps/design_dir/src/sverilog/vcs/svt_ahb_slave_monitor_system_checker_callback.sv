
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
// =============================================================================
/**
 * The svt_ahb_slave_monitor_system_checker_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_ahb_slave_monitor_system_checker_callback extends svt_ahb_slave_monitor_callback;

  svt_ahb_slave_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from slave to bus */
  svt_ahb_transaction_channel ahb_slave_transaction_fifo;
  /** Channel through which checker gets transactions initiated from slave to bus - Used by AMBA System Monitor */
  svt_ahb_transaction_channel amba_ahb_slave_transaction_fifo;
  `endif

  // -----------------------------------------------------------------------------
`protected
<.ceO9\cYB_f3&.GEE.>W+>R=bX2Q/(.;a^0^?#^+6_32#.^/7\/7)7G8&TMS?Wc
e2Xa4;a=RP-_aG@E.)2?.<(EI#3C&3GaLgZYQ.3dB+@AL/c>.FUY:30d:RS#UDf\
):bc?>;#:S^C,6J[>^LS.dL5@L1T.#c^fKY1\HgIT8_S#\-YWL@8),Xf)KFZHV>Z
3KbQffA.1X_eUQ]@_9_AL5&<XRG#6EM>8\@RD]]S?Bb^&-/bge35#QRHI;C&;K+)
#9.2^QESRfNK/;2E:4:\Y#0BAY(@g3XYZSaaabdMX<<<]17Y0[6(?d/,C87-E[MP
E-\>IPQ9,EZ3g4Z67RRZDe67?L?7/:bN0;&ZPX:28C)CEKN_1H-5=Rd5BBg/P+P7
?:,1B)#R\P,W8YFB82ecB4#GSZ;LF3aL0&YX13bcJ>60dN;=+&2IcNN+#)^B242e
2EU@VHK@7/eKKRZ].W6.9bGCI?fV\AXJYI(@D(?S&e@IcM_QR#AR7e/^GM/9_2?A
<QEVA/+P.R0ddT=17JEPg>L-d)d\f-]^OPGH?]&-G#EgMYb@Z[TA0V@I&0\JfAU+
V4[U_5B6Kda[;[P<U1;M;>\^abbJKR8?.&Q_8g+aO4?^V2_4H2R^9P5Q__L]HX4JV$
`endprotected
  

  // -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
N<93^2(S@CeIf@g@+65GTc:UC#_b[9B17XC]<=[LA9B<<<T<#a/52(NL@F\YNeX&
[[SAQI8gBe@U?-;BZ\a-:CYSO29A#G\85K>0TPH0EGSeK&1#]KOfZa=)(N94OUG3
1<7USbcWYgX_@-Y2NU^[M;G>&KP@5/eRcB5.&bX64:MQ0gMRPQA_/H_/\&PD(EA,
XGOASSJ9NfY=I_??4b[QJTUL6.W3NbD./EOBB67_QNM6+,)&P@XVXY<_?MSGY2Yf
fdN-ZF?R9#X>FK796F[d>bL_fg;gG9G(e:6cA8^;1#:J@0#K>5,NCXUQ:FBYgW:O
T;9AGe;R9GCV)Uc^\dU_Q99232#UT?ICfJ-Q>Y<3JTQ>AG3(:S^13]-&MPDH9UJ#
].#-A4M@a(TVM(If-cXQ5Z(,D,)_dJB;ad\6EPRTN<gOLKEX]aMFK\2S(5_BBZJE
K0;g+0VLWF0AI34H;d7P5fQACfc[5_F_YY>CJV-CgMcfS34]VAa<S88OT>eN4_2B
U;c^FgVg>9JYYbOIH)/=<@P[f++R3#ETT3Lg:TL_fTT#J;&K00_T)QCDHMa?XP7S
J_fL&S\<<<PJ0B3?_,D7YI.WdKPVQ-5C,T>G>dd8()/[J,;D2>05#E[-[1b5I8>L
04,W6?M-B08^@C9T;[/[a+Ea=S?#?+>,F.FE<4:^?^-aaF/.3GM]Z2X>]gYWXP5G
9/6:6CRH0CQPQHJC]-g8]BI4PW7(@SUEHY2B6^VP91_52aK/33Pb;4dA0:DbNL(H
G;O70,H.+SGVLF2dd(22ITZ>_=P..0\A;_@G=CZU=-3G?)Wd+[N/.6\Uf)^9673M
[.&KH(MQG(T)81D+&,><Y3bQS&^D&0@]\G]D964YBOPdANbC6RMZ?YUaR.da:_O(
8R2Pcc(Ed;&FWI>S;TaI&&:gIAP,M@5_=\EeaLVZDVe/gWFc?].=P[]HJXEPV3#c
)Z;OSgOIK+2Ke,[L:6&Rde-KcJ;#b;6II-N;SHNW<0YZIe8c/4GQ5=7TdCMWFWWd
7+FY7VDV9YaIQ@E\0H6If^1<Vd]cV?AG<EgHZSYBD;,UQA&D#ECKO3.BI94>\[a?
_RF>/VVa4fO-La_/dUXaY?e9/Y6&(8He]M8=:Z?]dK+7KDAR06&:2C#3S50M<NR)
PQ3S2Xb=_^014MCIeQI/\dc;5Kcf7&BD;@G?FS.S<2e.U]f_(<S+HGb@^:W[Y3Se
NRMMPY\eG?00F(+>^Q;HH<Y=:\a1@a#&/,_98FKFgD0<5QO-UKVK(DYC>YTU3/-<
:X)4DcBfQH2[Ye0P46VMa1XS63A4),PRR/;G.VR0.c0+2GNY#7+048_[+IK:C\AQ
WK(g\81N.L</._[U.)7A]UB:MS#dL)8]SaaZ^SI@3@?]7ge]C8JXbd,/[a3J0&P>
)+PH0Ib(b88_Y8B&]AZWI1?G-eD#8GfDE/&3UR;(H4XQP2))IgA42+,/N$
`endprotected
  


  // -----------------------------------------------------------------------------

endclass : svt_ahb_slave_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
