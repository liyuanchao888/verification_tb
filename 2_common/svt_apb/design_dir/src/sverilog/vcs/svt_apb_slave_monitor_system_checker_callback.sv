`ifndef GUARD_SVT_APB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV

// =============================================================================
/**
 * The svt_apb_slave_monitor_system_checker_callback class is extended from the
 * #svt_apb_slave_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_apb_slave_monitor_system_checker_callback extends svt_apb_slave_monitor_callback;

   svt_apb_configuration cfg;

`ifdef SVT_UVM_TECHNOLOGY
   /** Fifo into which transactions of type svt_apb_slave_transaction are put */ 
   uvm_tlm_fifo#(svt_apb_slave_transaction) apb_slave_transaction_fifo;

   /** Fifo into which transactions of type svt_apb_slave_transaction are put - Used by AMBA System Monitor */ 
   uvm_tlm_fifo#(svt_apb_slave_transaction) amba_apb_slave_transaction_fifo;

`elsif SVT_OVM_TECHNOLOGY
   /** Fifo into which transactions of type svt_apb_slave_transaction are put */ 
   tlm_fifo#(svt_apb_slave_transaction) apb_slave_transaction_fifo;

   /** Fifo into which transactions of type svt_apb_slave_transaction are put - Used by AMBA System Monitor */ 
   tlm_fifo#(svt_apb_slave_transaction) amba_apb_slave_transaction_fifo;

`else
   vmm_log log;
   /** Channel through which checker gets transactions initiated from slave to IC */
   svt_apb_slave_transaction_channel apb_slave_transaction_fifo;

   /** Channel through which checker gets transactions initiated from slave to IC - Used by AMBA System Monitor */
   svt_apb_slave_transaction_channel amba_apb_slave_transaction_fifo;
`endif

   // -----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
   extern function new(svt_apb_configuration cfg,string name = "svt_apb_slave_monitor_system_checker_callback");
`else
   extern function new(svt_apb_configuration cfg,vmm_log log = null);
`endif

   // -----------------------------------------------------------------------------
   extern function void setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);


endclass : svt_apb_slave_monitor_system_checker_callback


`protected
>8[A=)Qd?a;[L@=+Pc2PPfOZ#>-X])2L-ZcII\.8[PBH\@R^e4]93)NAG:HJ8bG2
CA[ZY595=Z2PIP=O6:RPNF.=GS33TFK088A87D@NU#3@U[13PJV3d\C0ff3gK3Rf
EVH^(d:@K(d9^IZ.1HJbSG/#[._YTd]g>#bcNR=Wc.-&U_/-c8cVSZ/.9cZ<]b2/
L_:b<X3,D,[GA:CX_KaA<0&L1EL8GXKEWA;O(NKLHEI&6VO\@HX:(AMPXLPN\Z-&
4G[I>GV=4X?,=NS9Q_KNf#]V.4;SH=.LN/11/82FM:KcS0L7J8FVe@,fG-_a#?RR
[5?d,0G/Y:Q]gWafGa7d7G)X1LFJ3AM=J@U1PaV@O^+?]QEC+fY_fM2cM,)_;O]O
D704HYW4fH+C99+KR_,dLcW[6-^HWQ^X>c._c,0-^I8UAK&SO3OU\J&a8P,QPS]g
O<7g+aJ[B)XTAP9BKQ8g4@Ga9]bF\G>APTS><Y;d_T-MAQZD@_UVZ7PK5PQgE+3,
4>UEGNU^ZVMJY.8?]L7HRJT/6V^+_U:5/=U94HGI1d#.(PTT5)@YOdP&QG+2Q8F_
5?(D,?Bb;DIB&:QH0&S#)EPJ[Z.H;/b7>,O.8@NI/e.W^6QB-9N:7#d]P,8XWD2e
^aTVHO^-1aM5<bL2MK/[FeC0VN]RAJ0EG@dTR^H[T41-fA&Ic3d>..V9(J0Z:;(0
3\+TDJR97SM>5TY.Z]C[)cZgGNVLa(C[9AJEPTg[5=K^=dG_YUUKf(=<Y>JG#QA?
[g;=/(XKI6g/FOdF7;?f1L<bRG[]F9fL)C(+?Da4]DRPF>Q[Wg52=L@R6B)9g&;/
X;O4GD8/-,?/-$
`endprotected


// -----------------------------------------------------------------------------

//vcs_vip_protect
`protected
f25Z\TO,)eg:1HC@CW+?VdKI2YgW3\6=V4G]EW@<b_]@GOTIA<9=3(dfR-S)_CPK
bWE:<SH(7?@+^OAE1/@YJfL[Y0PLc+20PFNRYb[S[85V#Gg1@1c5P5[bC)?T.<KF
-7bNSBT^(I]/,cCIC&FQ1TU/N7&F7dQHbfd1ET0KPXF+@&X@_#0P5F66NVSWXK:T
Z6^4]cDdW.a2>:/b1fYfd+\NTYN5+A4)D5BDVT:\fg+G->6NGT+?W2NCNg[T.?]7
[VH\bc9#R5>Z1V_EYADfPeZ@PZX2C@\aQ&+Xe2=fR2@->_e99[X7976:/PT5]D=0
HF:RIRWOS/JJ:I7KdQ+OZ6d_RLJ(1CM6J;_Z=8^<FVEgQVGa/ee;1J(#GYW]/S)B
9HQ5SDc6QHJ>]YP-a->e&e2/JKb@-XK;(8ab_#6dG9<O,FXY6aY>?Rc&1O-G/RaB
)[cda5a+#RG-D>BAK0F6D>(;A7a899Y1;;7&Q);DR;0ULXW+KOY5dC^+Y03YDA\_
4[HRIY/.QZY@IX<;;Od9P#D\CBOHTK+5[Q1WEf:\QQa@:VBH5e5\KBf#d@a6,aX#
0f4;7XLafb&))41c,4._c[N[^-QDPNGVAB+7S=/#:OU30^N,2#+^VD2_b6W1<;U;
6RY)I]H@PVCR_f&0\b@RQCZ7a<TTN8\?TD?+)4OR,BSPX,T5I/]-V1L\WI^a=.AI
J,?M6XgB>FO68eaLR6S+O<b,15@<H,K6-J6Y+HCD7g?4c)E@V9JUA>>F0BY;]b^e
e<4QX;/Md\[O;9dS2,+UN,C(>]dPMBRgKbb(MLP1Y]VH6KeA3g4,YM>3&W>-?g#C
681.Q-N?[VSe-cg,Q8dGAa)a3aa2bIE/=723-YY)I@SY^f0fNL4dVddH@gdKB)_6
R,W[\6Y;/.N@C)LJ1I;2N;TF?_0AY;[\a=.f768,H:93X\fQdAUCJ->-\Hc>X:O\
D-UXIUO7bB<c]eSJ3b3b9#UXgP9<fV<PE8>@7Y3KM\?bLFQ+g2Y^F:fB3QQ6LR1^
gG]#_,>9e:_C,3L^]SH^@USM9c,<cLceedUUA<\?J?#V2MABVf7EQGGWLACe>L?T
>dV(9_?Y0HG_/E303bVXaHgRTK^LV6R]V?><8[^P<\JE)7+?HS.1a/.EUW/M\d4D
^X.U^O8^9ce@68F06eQ#XFG;33(X+.g;H?_U/Y0Q^#Y_O=#CL:9@e+M4F1c,@N#A
<.aI0J@eLBLE@g03efLe<;S4IE8dU4>fa:Gd&dA#9HN]8I):<gLC.YaMC2I]feDD
UQ87D1[FdRA8^7;?faOY1SZ4EN8>--2E<ZP=8Q/-Z#Y#V/9922THb04Ze2b=ecK>
gM:^N(KG25Je\3Tba1Kg/1VfY<7>bVB=C[=L]AaDTLf8CGOCQabLY:M.U22[QMGK
8Je^,=3H^ILD+D(@2.=ZG7U88Z3.#N.5.0/K(@>b8VX0=NB96,YHUW1=UB@5QDZU
Q/c_^3R)FY4X0Q&2VI_G55E]4K?d-<@bB4&B-5A.a_f2[U<9?KX3LY=1Sb>eT206
_/PIH92<Lg=d6.5dU0BREc^V^?>&a(CD>cD_C3E8J_75=>T<fb-EB[gL+99,]+=\
NT8-D@SG2g[WQ[S.D[dDW0^^0-S\D[[-;4<(2E-,,bc.e9Hg?JGec[c^7S_(K940
d2c[@K9\+P0WTW<7YTG/=8XGEM;VFFJ3]6_O;.ZJYC>.)K-P1&aE(X,Q.-#B-gLE
+dAL<AbbV8/FU>,W42Q&caHg+>?fJ,fEXPMU#QBJWZb\TVf-I]IOF,a@_HL>eT/V
3AVZ_fL+a&TTAHf>(I3:Af3(b<S#d3<.YV4_@>ZIP23+\:&,=,7&XfZ/,1)8,QAT
We&5DAeCS0<R2/AOS+Q<Ya)WP=80D)E]5-V^YJTe3LO5?E/@9bGVX\Z/K$
`endprotected

`endif // GUARD_SVT_APB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
