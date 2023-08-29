
`ifndef GUARD_SVT_APB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV

// =============================================================================
/**
 * The svt_apb_master_monitor_system_checker_callback class is extended from the
 * #svt_apb_master_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_apb_master_monitor_system_checker_callback extends svt_apb_master_monitor_callback;

  svt_apb_configuration cfg;

`ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_apb_master_transaction are put */ 
  uvm_tlm_fifo#(svt_apb_master_transaction) apb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_apb_master_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_apb_master_transaction) amba_apb_master_transaction_fifo;

`elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_apb_master_transaction are put */ 
  tlm_fifo#(svt_apb_master_transaction) apb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_apb_master_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_apb_master_transaction) amba_apb_master_transaction_fifo;

`else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from master to IC */
  svt_apb_master_transaction_channel apb_master_transaction_fifo;

  /** Channel through which checker gets transactions initiated from master to IC - Used by AMBA System Monitor */
  svt_apb_master_transaction_channel amba_apb_master_transaction_fifo;
`endif
   
  // -----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_configuration cfg,string name = "svt_apb_master_monitor_system_checker_callback");
`else
  extern function new(svt_apb_configuration cfg,vmm_log log = null);
`endif

  // -----------------------------------------------------------------------------
  extern function void setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);

endclass : svt_apb_master_monitor_system_checker_callback

`protected
9_[VF<UT&I?4JVa6-+G:?;D_T+Y_aI-/48)5Gg5)F>7W_f2QW>Ab))H+#?JJ5R]e
,[G+MU4+6HW9-4Vbab\\g&9=D-RDBT28.PeDVQM#89,K?Y+Q#3_CQ_<X285=/7OQ
e:NW4b[_]2O)J,Je;/.)6XT(+PF-.9GO^PM>436_45KHdZ4#NX1E>4].VN3M?<RZ
fL?QTV,GD[:Se2H6SXfH.:W#K=M>Z7VPc4Vc)FU2:gS,b1IP\-_a+0gRRGWVR;6?
9[<AMXO84L]+0W0?G:H)KQBNE:aL-bG5LFQL?0_fDGTB^?P^d6CZ/[29R)2\CfeJ
056E<S-Cc,Q:^f\28=UP[Q(2?LI7E^HcLf_-.C6Te3FMT:YI4aG0AY#L8R8DbU2?
bI(c6JeMgF[>cDM7?=9]I0ZTC_:F^,S6D9XRP([J)3D#/UJAF^K\@\&5P.YNb/G;
bgBNaa&<OAH29Rd(X^XLARAf5PRe_6=;X8=f03#@:#Sa?)9S.^J=ZK6T1cKKE]M1
=P;B(4B[VV7/-b_8[R;+W>NNI==E@C9(DD:(,(5Z0fHa01[8&R7::PgB\MJIgXFH
\456PVLcIUAN\L&b)ZaR6MV94B90<D46aOW4+/B6fKE14A+H:I<dCVZ4D\Hc>99/
gPN@P9(M6Df/2&6(PKAB-YI69#;-JFW\g92GZ/9f(3D^&)\?6J\d23J,9DY\C+RD
?&O9K.0MX];g#O-LB.L:F=C[\S]Vd1D&Vc(<D/T3?]G6UI00P#?AR0;FY+a@;)E&
JALWLf13a)GQTLK24MWIc7OKY5QNXKMN]f4dZ17YY0J]?C#63D/K1,eZ//Y=E,:6
5d.5?dQf;Z/cGQ8?QdT\cUOK3$
`endprotected


// -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
C3?X@G>CP,7]6QO):ReaP?^P6g\AX/fa+3>BQSf8+PZ+EL\0ME),7(aVNeKR_^bG
]-g+\Za#Y5aYQWYFc_)Xb_F?0X5A(@IQ;C,<B,)J^LO>Y,.>81E?Y,<_R@)M=H2N
g?]J?8+PN.+Q0gM<.]-c4[3O>e-W7C#]0f^=<AdTN:Q05;:..GAPDWZg2MMf2\)I
38)0-FE/R^b,6JCa)g1V9^2&XZaD;Ea7/];]<2&Q^9N>8OP1&4,^e9B4.b0&1==B
7JDDG5-fI^44P2=]:2]ED)U<:YM29VXE&497S?Nfe]C)B3#_A=1G5F\GE<E4=#@#
4PffgSE^FcH400d]cefGNX]F)KF#8X^P(^.G7dPJ^/)LfgR;CH[MCf2Q5MSFH<@W
3=ZGWEX85c>GW7O@)eU=@HGD9:gAO@dQ3g[TeR\9aZ:^X:5I0KO_R.TReFYOS:H_
ad=]89+J^BS@1QWP9EPX;).KgRK&dT7&6bH7BK545Bg_&#Td[=g77aS^KA9fUBZ+
,&QW?Q3.PW?(L]3E#VEOM-]^D^0Oe,-cLH16=(,BV/DTT)?X4AVP4]KWJ#/VNY-8
>69>6-d<K#FAF:?3>[gJA1N]dP[X=\L5&_a2:AU2_RRN9eF/9,L1Ea)T(087KCEE
G]]=_,HXNeT5SW#+_2OJN&;GH3^a#0:(4V.JW](BA=U\M59&W9];3KR[R1FIa,:=
=^SL@-\R<),I#U7U+H-2(85\NP_fPFbMQF62+FKSRECX_4Z5.FgM9/#@>,Z^1W)b
4M[;1bSV1X-CTMfRgA2dA50Q?JfC0]Q(76@V[Z+Xf>4Q5KPZN?Cb_E=<be8f9BQ0
Z_U&D8?7SeG_f@8H[-^2_Gc_V\GTURD/?G]4cMI5S)WPF0faYBL,CG/:fI8/I9<?
7&GRG]bPMdJ1U2&.:KbT4=KWWU+[#DMC_4?X]GYP7/5g2=?47(6^\;cBK6W(YcGf
F)efJ9+.gTAdCBKJKXORF>b9QO=YM[^::\[AE9Sg(VOOdH#H1dYUICfIOPV_e0PX
;gbf(NPHM8SP88RNc[9e4,]<#@QD?3#DR=.d/Y-&8,ZJdW<DI#W4GL<0Z0fAWbIf
_]IV7I\<@]R)#<E5A5[YZOPQIfW9f6,\44@d=390fe#^7=Mf<fKMU8V8eP?2NfeC
Ze4g50:8&5?Y?H+3d9Le-NE0bO5P;eG@4?=A..:,RQ7We1g-EL,Na\,LTSQ<<C2R
,cg41VHJX#CTS<IO71\g8&a9>6U#+@RAf2bCY\@IAP^c=\35O6Obef.;2,7FD<fV
ZOg0cg0\ZARdZ\,?2+R0\ZRc,3B=H9?eL;OO]/P7dT)3JY/I2OD7TD&H<7b)II>I
/D9eYB1EZEe5N92DIDG:0bZJMO.F,\GB2QT9Jb,2K@4;D15?gWH/]8_39Y^,6+?/
aVH3+d3[B<eb8\NgDgB(6;&Q6#S315<2g203OHAQXI/F87+LbYfDJc9^Tga&1,L6
K&e-_X4J-(AD83:Y^9JcS;IB4LXCf<UFD(1UW27J&QK&#ce\7^^Z<3)[IK6f/T]f
GM)V)8MSO3H>#1+=[LV+4MX2CeR;P0HA)WA<_c3P,Ge?1R?3)@G&CEG56L8/&H8I
E.#YRS_UP@Z(_7R6ZT0MLF)cfc.W4QH;<O3H/=#eSC/b9)&7_SJ)(KN]_5E[3QWe
98F-3Q^:3Da;M5PU=Q=(QKS@=S.Q@_=;47L:HOKM4H6&?>Kc^G\P2M8^H&4d9WOV
)\dW<@6,Q&RHF?4cc@KCe]SaVa9;TCN-.]&JHOT5G_9bEA)@,1HaIaW23GRYSX4B
Xff\1PWDPGET\\,NfGZYO3D3E_U.5=5WgEeH:/?23T,K7R.2I?e1De][WY-8,<S&
9eBSbdCP61PZb5U=-0Sf;NK4B(g^(,5DT&PA?EU9;5=28FZX.<(&OY5-/+2C9[EC
CB4RZ_S^>Y7g5P)/^+bRL\1W.2Z\45EVT3^/4fH\aR[g?E-J;W3@3]XA2=I<VLe1
3-eW<Q;:E;=FVLeN6Q,FA7XK1)R;T4a2F3+W\K,X@#T5&W2HYgT)NK4.>VW,QFbc
Eg&]E<SP<[P7GN1<R(L0LLaZK0A[T@,R&?42E6dS6/>S[WJF@FBH,VSfWZ-+F5Z<
K#C)XXC/8L-70$
`endprotected

`endif // GUARD_SVT_APB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
