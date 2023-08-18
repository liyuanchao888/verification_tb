
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_system_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_system_configuration handle as an argument, which is used
 * for shaping the coverage.
 */

class svt_ahb_system_monitor_def_cov_callback extends svt_ahb_system_monitor_def_cov_data_callback;

  // ****************************************************************************
  // AHB System level Covergroups
  // ****************************************************************************
   /**
    * Covergroup: system_ahb_all_masters_grant 
    *
    * Coverpoints:
    * - ahb_all_masters_grant: This coverpoint covers the bus grant asserted
    *   AHB Bus that indicates which master has access to the bus.
    *   This coverpoint ensures that  the bus grant is given to 
    *   all the master connected on the bus
    * .
    *
    */
  covergroup system_ahb_all_masters_grant @(cov_sys_hgrant_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_GRANT
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_all_masters_busreq 
    *
    * Coverpoints:
    * - ahb_all_masters_busreq: This coverpoint covers the bus request asserted by the
    *   AHB Master for acquiring the bus to fire the AHB transactions.This covepoint will
    *   ensure that all Masters have requested for the bus at least once. 
    * .
    *
    */
  covergroup system_ahb_all_masters_busreq @(cov_sys_hbusreq_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_BUSREQ
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_cross_all_masters_busreq_grant 
    *
    * Coverpoints:
    * - ahb_all_masters_busreq: This coverpoint covers the bus request asserted by the
    *   AHB Master for acquiring the bus to fire the AHB transactions.This covepoint will
    *   ensure that all Masters have requested for the bus at least once. 
    *   
    * - ahb_all_masters_grant: This coverpoint covers the bus grant asserted
    *   AHB Bus that indicates which master has access to the bus.
    *   This coverpoint ensures that  the bus grant is given to 
    *   all the master connected on the bus
    *
    * - ahb_cross_all_masters_busreq_grant: This is cross coverpoint of bus request and 
    *   bus grant.This coverpoint will verify which master is requesting the bus and 
    *   which master is getting the access of bus
    * .
    *
    */
  covergroup system_ahb_cross_all_masters_busreq_grant @(cov_sys_cross_hbusreq_hgrant_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_BUSREQ
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_GRANT
    ahb_cross_all_masters_busreq_grant : cross ahb_all_masters_busreq, ahb_all_masters_grant {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup  

   /**
    * Covergroup: system_ahb_all_slaves_selected 
    *
    * Coverpoints:
    * - ahb_all_slaves_hsel: This coverpoint covers that all AHB slaves in the system
    *   have been selected at least once and all transactions have been run on each 
    *   selected slave.
    * .
    *
    */
  covergroup system_ahb_all_slaves_selected @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_SLAVES_SELECTED
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_two_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_two_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[1])
    *   happens in sequence in two slaves environment. Both slave 0 and
    *   slave 1 should not be configured as default slave to hit this
    *   covergroup. This covergroup will only be constructed if there are
    *   2 slaves in a system. In order to hit this covergroup both slave 0
    *   and slave 1 should not be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_two_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_TWO_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_four_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_four_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[3])
    *   happens in sequence in four slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   4 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_four_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_FOUR_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_eight_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_eight_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[7])
    *   happens in sequence in eight slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   8 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_eight_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_EIGHT_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_sixteen_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_sixteen_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[15])
    *   happens in sequence in sixteen slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   16 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_sixteen_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_SIXTEEN_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup  

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_ahb_system_monitor_def_cov_callback instance 
    *
    * @param cfg A refernce to the AHB System Configuration instance.
    */

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_callback");
`else
  extern function new(svt_ahb_system_configuration cfg);
`endif

endclass

`protected
bH+)G2O.J>;VPUPDQgN[aNMc-X&\c2fG)<#?ZT&SZV@JN:T#M@F+2)).,E(UK7O9
36Y^Z\_He^(NY7T^Z6I9F<-NK[W6-[QLM-IX#0T;FDS3N3\4&<Sef80L>d)EV>LK
XHMJA\-\?);?eZ&cCMR(PJ&:bN:]R9M<&T(ZdNQfTaEd)P_]?2/D5Z,Ueb)L:8,X
B_E+HX1I(DS9^DcaQT3PUN?A2Kc.),Z=&:>fL.bS.R6egP;dFPZ>E,Z1)GXHNLba
bcY.AE7O1L],;dVd\K8T5f?>PWKbXZdaURJ^XRH9C=O07aaUUSaZ.HeU###ZAX6S
B(;\eV^2^5Q5/b3/g(dd]T7Z.-QQK>0,IFM8:OXe0Q@bL]La+0OX:e/M;A3OcEAg
2da[K[5?EOd+gYYXV#;4FC2=b68U9R(g5H[S]@2#(_=I\D?Gc/0/g[OJD@@6X9Ig
^R/Hd7E+IW@&3NEDaO^,:(4NH5:EFC^06567P?#6S3-#IYL+\U2b^VX+,KV,3<VG
Y0U9Y626geeIPN0bWU880U60A4MUHBY0K-U&Q]B]LJZYE]a9#7?D_RK)U2X29)\9
0f=Bc-HR_::KB;VaGHaf?dX.OO.Ne)5eQVWFI:E01@XJ-,FT2X/<fHA-&UCHKB4\
2f+_BFS)B,>+#gb5.N(ECgZ@g(SW\8D&6eG#X,fCd+M#Mee?a/S-[56cMN[Wg=J2
dK=6AD@QJKT&H/G(2PG:5,.2+>-bbA^XXDG:8(dJ&>7X1]cT\7)2>e)\[1<[H5c]
P]W=e,/?XR=^22IgV07b#(?LPG<)K[>28RWYDWE(=6R^_g@N^^P[SgHG_OB3KMIF
M?PAY(&X/&/aa(#a[XWJ1WMQ-=JAAW4X2AeA2#5c?RaC>FgLA>\I#Y40@>\H;+\3
4C4fN#gg:0\H=^?g/\3OSJRH+FAS\5Ffg_7aV_@OJTZCC->cJ:0M/=:bBFe977XT
\?@8Xf3\O6>#cL<DL)O<I.-=FZP7.5AQa;EdNb7H3VDQZQ=8MV7Qd81[<;NV<MMN
>P>6a],eNIPAWW4bEY8fB)M5I<9?FVXY[V-#_T0c8^/W?GR?F3/4S2CA<3V6<1C[
W\#78<0P4\/OTTT]).GE+ZBEfAZQP^e>H>8G0--JBNW)+=1bgV;M61X?Q:1C3c?\
9-YOU9^-R(&X^?6\@aA61ddc&afMPI3Mc[&@L>Q1DcUab#Za_]dVQW3)c,[#Z5=&
,4_aRQA9Z<U?V/HR7e>]@V5-<KHaYE91:bR<D)5f(99,AF\[cQgR_)CdFU\.aFF>
3N5,5eJ,[^WS6TeF?URQ&C0,)d.HWNc9:SN?1/<S:9-6=]]fXREU8YZXC6]c1D2a
@ceIVec#ec+10#Q>Sb;JCc_Y=0a,=(K[]^I+T>OV_DUB.R;CAGGC_(+9-/W91EZB
a2^)NU(-_>W>46ScCbSG>_1Q7>+eRJ@T?=P7OT,X<<1@8\5N32?QYf?49Eg[AK:_
#MZKbOS,TMC1A8^daNY64KXb(W3N:gd<.SZ\NR@\\5W8G7]PSK_gNgUJQ.;3+7G)
=[8Oc2;IP[Oa7(28<3a)e-D.gVMI43#51&#/Y\7c8OcNbccE0d8+891aBb=\N@Uf
O,1;WcA<e&5]9\=DTK<66N01f8T_J7D82535,1UaIfBb,]<=?NHNZ?:I;:)#T1:\
S.R?598QIGATIM6G106,.<\?7O1E51ENZfb,.M(09C8A,G+.REV7()RFW.L<BMCP
;[W+PCbdDGS3Y26R1b]?L3.@F<7TU41]9cO#KI>8YHO\#:3ST>=A:G9gR_H/e#Uf
dcHfUO;c^NW&/L17R)/)E5R<:Mbff40JYZA\0gFX_U#SC?VdY,E[^Mc;a?-eF^+Z
VGa;A\V).TW]>3S.g[,d8MIE[;N4O8N=IeX^RLae5B822.UaDU;^XDd[DIX<AIAM
8;Q5IH->=-=G>40KTP3Y=NUc^;cbZ<_4EJc;<=WEQ<=/gTVTXUPaM4Q4;0^UH0II
4KBR))QR@,4[PfA&2;&=Yc[/7ZIK1]JUOWU,U/3Yb)gWE1K29f=K3]+31>=1EE;g
D[NA/&[V[KP#.eL(3M2a+56GGU\E,-]V5QYf6KA,<dQf)N;6OW.GK-HK]@O8&OJ-
b)-O?Q:T/DWTV/RZ>-c&Q<d;JIN/1CBb(SJK,QB>^UGc#ZU\fI]Y6^6O;c&QU\^<
N;0EV1f;D[PTH9>N9]-7,f+LE@?>YcTP=MP-P=+?NRS3KGKJ+3\4Z4F__fC=_174
6OQ#g3M8T7_=FQ5HEIZJABQ,Ib5)DdB)[1DV[#BFD7SaAWFLaBg9^)+3K[4/)Iaa
&cgHa)1,?_&_JBYP<(?[bVTG]S>c;>+O8T<c]P,Y?:Q,c(1=3N?6eA>XeE6d5f[:
U&;CN5#3L#AME4,Jaa:M_4e,]U=ZLWFCJZ8EK6U9#,P,88HG:+CJfV?]=EIF&QW7
F]d?[7QP)&\]&.2;,O06QT2\)V^<dY3^3:]>d5G#g_AUV.)_>S>Z.#&bW=\PMRe\
TP\1PJ1M3S\(T6>ZeG,._d_.QaJ#BJgf7J(3^U9f#7:=E/8;=;:VLa?>PHXf;M8M
WSM=?_1PW5M(0$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
