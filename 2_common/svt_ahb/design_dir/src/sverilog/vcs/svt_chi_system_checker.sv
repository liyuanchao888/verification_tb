//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_CHECKER_SV
`define GUARD_SVT_CHI_SYSTEM_CHECKER_SV



`protected
_aNEEa.5RdHaWB.&(_VO39f-0d,3L9+dX+X9A,&X92\ZZW620Ye^6)A1&[8^9BH]
9?K8IP]e_HSKg<?\cZ2RU9))8=DG+F5f9=<Kb7P,\5PdR0@Nd&PADVSWQ6L[<#_U
=W8W7W#<^f0,O?]aK_IEFOc]A&[g]+3&Rg\FcO_&A9];?^MOWGcHfg7#G8]-8=U,
#?DFK>_e6P1F#>:^12R>X3fCS&;:VGBeW]DTb:UYG(<,G&Hg:cRE7^ED?;-ddF@?
VTB7L_CSV/dOI7C(AE-:gGT68PAFRPQR@?VG_=_8[DIe.52CEEYA(O/U8GD^XUe3
IE2e=SPLL].0Acd@2Qg:..KN66SBRQ[-8-X3C:UL=W,O)^5e(Z=LN7O\P3XfG[#;
cGV0bM0Wfb)/;VXBe-##KD#9BGbK(c&gEGI@-3?fUVA&10PP:?Ec\Eg59R61RY1L
)g?I02]P)M&K+YW@>9dbG5fP0X0AddCA0VVH.e^A&a5T-\TIZ6O,)A^7D-4bL<-F
OM/1BR-_D26<H,_/00I=K[L2/B@XHH;E;f/b6A^S3&M:@Tg&=KCXc-::E2JDRXJ+
-a#gLY]URbLEa38:BD.D=<-GSP&K1Ya\89IOE?VW#)0[CK&7UP8_^X;3b[f[F3)L
M=afSK,.HUCI>&A>LB^K3f#<2ZXET.MZ_A9g.;+#TTgX#:K[#)&VdF3J6\Y:7f9>
VEc2]4@KLHM3Q6(M[a@/@aPHN])6+aT5/)1:F]KaQLXKDFb)EU/AN+bHYg9gW7K8
Z?AQ6?.^USBg0Y#;@21AR8;/-f0BLILJX;EZHF7U3YE^6N[O#Bc(SNfWZK]N7GU[
I8d;:+Ya8?g?gT2;3e)OA3.6(U#Kfe)c30@&@+K\+;=bRCM&F-M\e8B0g?3>+=-f
cgfC\a?E0d=0)>ggD0.Y\9LD@S\5d2[dc>Z0)NFL>@(:9fW1<NL#eZB0N$
`endprotected



class svt_chi_system_checker extends svt_err_check;

  local svt_chi_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
  /** Checks that the address of a snoop transaction must match one of the outstanding coherent transactions */
  svt_err_check_stats snoop_addr_matches_coherent_addr_check;

  /** Checks that the snoop transaction type corresponds to the coherent transaction type of initiating master */
  svt_err_check_stats coherent_snoop_type_match_check;

  /** Checks that the port on which snoop transaction is received corresponds to the domain indicated in coherent transaction of initiating master */
  svt_err_check_stats coherent_snoop_domain_match_check;

  /** Checks that a snoop is not sent to the initiating master */ 
  svt_err_check_stats snoop_not_sent_to_initiating_master_check;

  /** Checks that READNOSNOOP,WRITENOSNOOP,WRITEBACK,WRITECLEAN and EVICT do not cause a snoop of cached masters */
  svt_err_check_stats coherent_xact_with_no_snoop_check;

  /** Checks that the response to a coherent transaction is not started before sufficient information from snooped masters are obtained */
  svt_err_check_stats coherent_resp_start_conditions_check;

  /** Checks that the IsShared response to initiating master is correct */
  svt_err_check_stats coherent_resp_isshared_check;

  /** Checks that the PassDirty response to initiating master is correct */
  svt_err_check_stats coherent_resp_passdirty_check;

  /** Checks that no two responses to a snoop transaction have the WasUnique(CRRESP[4]) bit asserted */
  svt_err_check_stats snoop_resp_wasunique_check;

  /** Checks that no two responses to a snoop transaction have the PassDirty(CRRESP[2]) bit asserted */
  svt_err_check_stats snoop_resp_passdirty_check;

  /** Checks that data returned from all snoop transactions are consistent */
  svt_err_check_stats snoop_data_consistency_check;

  /** Checks that data returned to initiating master matches the data received from snoop transaction */
  svt_err_check_stats coherent_and_snoop_data_match_check;

  /** Checks that if two masters access the same cache line, one master is sequenced after the other */
  svt_err_check_stats overlapping_addr_sequencing_check;

  /** 
    * Checks that no two masters have the same cacheline in unique state 
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats no_two_cachelines_in_unique_state_check;

  /** 
    * Checks that no two masters have the same cacheline in dirty state 
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats no_two_cachelines_in_dirty_state_check;

  /** 
    * Checks that if all cachelines are clean, the data in cacheline is consistent
    * with data in memory
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats cacheline_and_memory_coherency_check;

  /**
    * Checks that if all cachelines are clean, the data in cacheline is
    * consistent with data in memory. This check is done on a per
    * transaction basis at the end of each coherent transaction.
    * Note that in some implementations a transaction to the memory
    * could still be in the interconnect's buffer in which case this
    * check would fail. Hence this check is issued as a warning, rather
    * than an error.
    * This check is not performed if the agents connected to the interfaces
    * are configured to work in passive mode.
    */
  svt_err_check_stats cacheline_and_memory_coherency_check_per_xact;

  /**
    * Checks that a transaction is routed correctly to a slave port
    * based on address
    */
  svt_err_check_stats slave_transaction_routing_check;

  /**
    * Checks that data in transaction is consistent with data in memory when the
    * transaction completes. This checks that a WRITE transaction issued by a
    * master is written to memory correctly. Similarly, it checks that a READ
    * transaction fetches the correct data from memory.  The check assumes that
    * a transaction issued by a master completes only after response is received
    * from the slave to which that transaction was routed. It also assums that
    * there is no other transaction that accesses an overlapping address during
    * the period that the response is issed by the slave and the transaction
    * completes in the master that issued the transaction.  In ACE, this check
    * is issued only when the snoop has not returned any data and data is
    * fetched from memory or when data is written to memory. 
    */
  svt_err_check_stats data_integrity_check;

  /**
    * Checks that a component must have only one outstanding DVM Sync
    * transaction. A component must receive a DVM Complete transaction before it
    * issues another DVM Sync transaction 
    */
  svt_err_check_stats master_outstanding_dvm_sync_check;

  /**
    * Checks that a DVM Complete is received on the snoop channel only if the
    * port has sent a DVM Sync on the read channel
    */
  svt_err_check_stats interconnect_dvm_complete_dvm_sync_association_check;

  /**
    * Checks that interconnect sends a dvm operation on the snoop address channel of all
    * participating components when it receives a dvm operation transaction from
    * a component.
    */
  svt_err_check_stats interconnect_dvm_operation_snoop_transaction_association_check;

  /**
    * Checks that interconnect sends a dvm sync on the snoop address channel of
    * all participating components when it receives a dvm sync transaction from
    * a component
    */
  svt_err_check_stats interconnect_dvm_sync_snoop_transaction_association_check;

  /**
    * Checks that the interconnect collects the acknowledgements to DVM  sent on
    * snoop channel and responds to original DVM Sync. This check ensures that
    * this acknowledgement is sent only after all snoop responses are received.
    */
  svt_err_check_stats interconnect_dvm_response_timing_check;

  /**
    * Checks that a DVM Complete on the read address channel is issued after the
    * handshake of the associated DVM Sync on the snoop address channel of the
    * same master
    */
  svt_err_check_stats master_dvm_complete_issue_check;

  /**
    * Checks that the interconnect issues a DVM complete to the master that
    * issued the DVM Sync only after it receives a DVM Complete from each
    * participating master.
    */
  svt_err_check_stats interconnect_dvm_complete_issue_check;

  /**
    * Checks that the interconnect sends correct DVM resposne of a DVM transaction
    * correctly based on the following:
    * The interconnect component gathers all responses from all the DVM snoops and responds to the
    * originator as follows:
    * if any of DVM snoops had a ERROR response , interconnect sends a ERROR response to the originating 
    * DVM transaction else the interconnect sends the NORMAL response
    */
  svt_err_check_stats valid_dvm_response_from_interconnect_check;

  /** 
    * Checks that no data is transferred for a DVM transaction
    */
  svt_err_check_stats master_dvm_no_data_transfer_check;

  /**
    * System monitor should ensure that each slave responds with DECERR if 
    * any transaction is routed to it with an address range that is not visible to it    
    */
  svt_err_check_stats no_slave_respond_with_decerr_check;

/**
    * System monitor should ensure that an ACE master interface must not issue more than 256 outstanding barrier transactions
    */
  svt_err_check_stats outstanding_master_barrier_transaction_check;

  `ifdef CCI400_CHECKS_ENABLED
  //-------------------------------------------------------------
  /** Checks that no snoop transaction is sent when snoop is disabled */
  svt_err_check_stats cci400_snoop_disabled_check;
  
  /** Checks that no dvm transaction is sent when dvm is disabled */
  svt_err_check_stats cci400_dvm_disabled_check;
  
  /** Checks that barrier transactions are transmitted/terminated on master 
    * interfaces based on Control Override Register
    */
  svt_err_check_stats cci400_barrier_termination_check;
  
  /** Check that speculative fetch does not occur when disabled */
  svt_err_check_stats cci400_speculative_fetch_disabled_check;
  
  /** For WU and WLU transactions, the CCI-400 generates a snoop, CleanInvalid or 
    * MakeInvalid, followed by a WriteNoSnoop transaction. If an error response is
    * received for either of these transactions, the original write is responded to with an error
    */
  svt_err_check_stats cci400_write_unique_error_resp_check;
  
  /** Check that outstanding transactions at CCI-400 slave ports is as per the Max OT Registers */
  svt_err_check_stats cci400_max_ot_check;
  
  /** Check that there is no activity on slave i/f within 3 clock cycles after RESETn deasserted */
  svt_err_check_stats cci400_no_activity_within_3_clk_after_reset_check;
  
  `endif
  // END OF CCI400 CHECKS
  //-------------------------------------------------------------



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
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_chi_system_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   * 
   * @param reporter OVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_chi_system_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param log VMM log instance used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  
   */
  extern function new (string name, svt_chi_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------

`protected
E;@?&T<;9QPRe\[TCMdPQ\9e,Z/fb\^>>eQNU[&.OP=9Q.bd+[B&6)GY7W+UO?_e
-23Sg;0.W?f89MGDK0>JP^5_0\fb^9Gg-R\L=I&HB-.6gYX6Og:G+[04^<E?.FYQ
62cb]VH811[R[B[XT[<A,_N,7.00D@Af]Ng[[A:f:\,PW)5=(K4(eCJG:90DYE:R
,68gCeQGDZR#=dF?TOA.LcIPgPEgMbY4OPJIJd>IZD6>66]0C2;X)C.95f</2WeW
_?eFAA?+IOGL?EZRKT?33-b5Ab\VAS3;->WY>C]&_88bM;_QXcO^eNDM6P6ee6:e
aK>E)#bgNBHQ0&NPSB)OEP-01b=YfK<^E=_@Oa1XGO5bJB>TWFBWedZ@1UI9fD+I
)D<=HcWb-W:1ZADeVb#fF5AB/Z4OeXe0E59=a,P;S.H8e0PBbEK]P/AHS(8a7(W3
EeL,?fcOUG=LU7Q)fVe1:-gA#D5T/eQf.68f#WN7:Yg;D6^f6:Q?&97cIcS&+7).
(73;V5JK2dW8dE)V,Cd6bNEc3=JgI&IDR7Rd+2_(_C06OP0/a@f44g5&d)M8&TZF
=cPb2KN9?0&A,;>7QMJ[EDMAFWf5MQ435-BOH)M3E.<VN.G#;O/I57:N#3]+;?dL
EUFB8?Y_>BW6W<FHG/E-U2U_;#b:T_1VPK&d>CA(Bc]JXEe-Y(^J1)5N<0>LYge=
bd^_O31YGVS9W#-A(W8A?cg;SYcUd#g,<YP>Dd-C981(Qd85K2\0f/cXVS[gGFBX
2+NFGS2+-^DE#)H1\6</+=_;H+<=FWXJ]F.G]:Zf.:0XPJMRd7NEAB>KEEWONcT\
QT#A].9&]a/@/^@&]C><Y>NS52N26LF4K^=A#HN#fK[f.OD4bDC&):X00P+&8YeC
7[5(/7D9?2]LI;RaVUe&B7:VT2^c<9=Q>NfVbF5LfI5845&fGM\1_,-ZATS[-R\e
HaB5?K58Z:/^+Y)?:DO.F:6/O6QH4DR9GB^)KZORb&11GTF(?+5(^R]QDA3.66E2
KN-DHCE,[_^-?8@68=QZY@0I7-^A3cAdA/5TZ^(NPWXUTCPY=)HM1EP+I)>dEPQL
_XCC-[(6-RS+?KFNQ[+Od.N4gP^F3/AUcKR/Y#DY6_H);?E989G^UcBS/+T1<?4G
D=XMBf=AfS:D>H6KTK1__3HF+0=)7;<\B))2a1R)T,XGV6IF)6+W8:DYCT@=_VdM
N[/2R6Q&OV,2GJRIE=IWBON&M?&X6>RZ2QQ#810>^=S04SII5D<:S9]fI)RWIdQG
4bAKKReA\>?.&4?=RCCGgL-]LO8[3RT>YYMH@<@F0>#W-[<>7b]c4e8Ub)VKKO6\
\/&.:e6?]LMeYHgX4[GQ>d]Q@Ya\R2fa-dKI9DWK(&E<\ggc4:TgFAgcH<.9OGIa
+)]-g12MOKg8]b+QMZ:d?e:9a)J9D).FX;Y7(DgG@@dd&;<MgRN(#5;T#E(;D.ZN
a2IP8DX(8aHR)&7-+&Q?IX2/GHJFf>TI#BJ=>I<5\GL/K+I9SYaP/A89L7<K0^)?
FAHPG.75XC:O+3WJNIb-:UdOL20J))_Z(Q5dg).&BUB/ENI>a?<EP^EP8E&QL[RW
6R[N&I9+IOY@[1g,.Nd2[0g&RgLgcB<=EG]P[e(?BW+;Y)dEB2NI4<AM=JTfQQK/
.[cfF:&dHSb^5O6DQ.]0JZ5cB7?acTdR)A&3E38;VNW?JFU92R,R@22)b#_5+2cd
^_107F/_3a4RIE,/Y)0[+7_F-+H+J6_dI1KAL+OJ0L>PMI5>8]\K+URSP]#,-A]?
dQ=C:0JS^Q-.K5e9EH8+IF.4FE1[SLL8SSQ5UCG/268(dObF<YED?R?7B\2];]98
)W,ODW=T[Z/3BGEb+:;BL[<@LbabTFL.TDP@cQ5NN>I/5#QTJ?A5^HQZ10[R^?b@
6:;4G55,/SW-fZUVId)2dZ0?#GK=/YSK8egCB><8(gE9X7B[9MOJ6K&681S.^QJg
c4XfNc=YDT>&TM<E\)g(3]4FH5H?YN5ANeWFWKT\<QKO]PC>/R\H>-J=0(/]g+#0
Y9TUK<9;e:HD1::_B5D,#e=@3f_6YEL_&FSZZCaKGZbHIXFbM,(OW\>_g:ZbdY0e
NfK^6[dZB#dCa<a[94N.g_[:43#@XH9eWTVeQRSBd0b&ZY9+KgL)5VC+_?9GI/W\
c&+2E25\S21_/=D;:7:=Q[ALHMG]O8WJC<>_?+2\X3E2LHE^&YWF#[YG#acB^-e4
S\f]gGb=b_:L\FLWHV[Ub9a_S[-,2I(Pa5_YL-Y8d]<C#Q.7)PN/+EQ-1&^6]-WP
O<M\@OHOXP7?V0/;-C&eBdVE=O+-H#N#f^eE[U[:,Y6Q>8^T90TR<G<6d&=1&YH8
,+)V3H6LgTKEU9cA@gc5&)E35R\3I5QY[W5(dM?3//@A&B-KVT8WGfWPD&XNRM^B
?_2RV-1&;C:D-KIHfB@R(B-J^@(aG]AUd2_<?599Xc2VFXITdJR@M,dI[US4@ad(
OW&SXSTJ,>L8#?0#]);dF0V3-EMf>_e8C=aaJN;H]3:eNE:].57-.@Vc;+1Ueg+<
2+M,VEN.<aO)JeS,\J8&&>E8DXT&HC.g6>dQ88@P2[G+>KR:)dI?UU8Sa&4H<gKA
-f)efP?D_J9RGO<])ZA_4P/,TH]5ac9FJC]3_5-@)XOB:efWd>8X-N_O(7;a6ge,
Wa7?7:UJ)HG)g.Sc)():#II[gKJ6c:2-P]<+(J)=3-(P(+9=AI;b#>-,&&f0_W0f
9PdQDJ]J<:OH<>YNZ)CeXgMIL<:@/#(1Af_YR<JA9LGc6AD^a+P58gHJN\G/9aAW
I.3[Z\;R=^V1MdKZ,cRQ,QBeB#J.0(Z[5AB-.c,KbOf^]CSbMEHf28UMD<7US=59
<3\d#D<8AGBf71Z:1VF=PBS;-H+GGM?:.3890:O,/N5S4.-0/S4F7TN^>A8gPE^U
8cQF(W#D\/UQ3OM[ae?NUJD0MJ@acB1<\I\YgL_e[@61PI@=Z&,(KXb#]:cMU&=0
O+EJb6Q9MbT#Y>.H;Q3gdU2F7UD3OX#@SAJS2AR_HCMGJIcT@_P5Tf<gAg>3e;^&
HbYaS+Bb;L@4X#_^5;4PRW4H[?;a2g],ZS).;AHI1CS:_,K3(B<Lg)X<aZ+c++Kc
MaLABUC4WZ>Ga^DY(M=b_QdB=(1+ICb940g#H<<#YUL5CPaAF;/FDO#5F7<.C[]4
9WQZT.9\Q2P0b?;\&.d591?RW3-5gY.4_&&?<4-=f^7?@3LX3N].DF.NDfP\]W0,
9UUbB]Q0g.9Y,<5?T+1XQVM_Ab<HQVJ,VP8G-G&/[Z>T?HHgeHOd;<L8K9/1/EBd
1W;&[Fg4)BUT/UO4@8_7UHACJ=M6f7ZT:Q7JA/#9B2.U?g:.3XD8Q.G9<K)6Q7a.
UH8.;Pa<,N)-4L\6,LBC(-_V(ZbW2ba>[;b<QF8HW;6YQZb9Pc)3DHSUJ[f^RY8Q
(G]89#9Y.U5BLMUIL5W=C5NZ+UQ>;C;-DL;0W92=6]?NJ8);<K-0\8:;Z]-@baZN
.TG&TP:J9M[PS>T@EaO3D8d_d;>D+=WH?JH;.3?\F<9fVCP\PC9bN13,8D;SXKL#
/.SML,FJ.Q3\OX/3G7&EQD&:/6]CM]V03),fG:bR\9SaMFR7/YeUTS>&d<MU:NVf
O8HGGFO?GV=68V:;P=-d0+RDV[U^[TKK\PVZS58^K4d4&BF<&[^X/VeTKZSMW=W6
cc^)&H[MDK,U3(bdM/,UET:H.A?eFaT63\@)&I&CeKVF5<DST-]4MC()-3M<9@Gd
Oea/.gQ4b@O)g;/#K>^;H)J(gg/-:gT1@OOb5+gV4X74//;>R^<c^.a<.&GL#ID@
.H;(cab_2aK8EXT_V[ME40D1cY22eIS&QU@]38e1/g7?2NG[NOIZGXaKJWIaeX=C
PHT3b\eA[@.S,OVA6DZJ99((0R0-,W:[H_Q6dG+[f)LYP)?3<c/^9Z/0J.C8E/DX
<5@PN&5__df:e(^b\HB)O-:=##2VFKU-]8c,WI7V&<R;L025->>_28?c(,E+C9G7
4QTLR@6,W?.f@)OM,SJ,f?+(7?(GM\>BGGB80BLH7D,dEMe2U(\@@IV82^E,8J):
SH-]L\LIXZa<<>_?S[=-V4YVaYF/9)W/Y\K5BBY/&QV6e8\YZI<=33>fB2/3^<64
:bSa.4Z?2P9BbR,\)^gR6I_F:LZ38II7YEL\f1\F_-(&JP:E[&)=65I/V6cdI1NB
f2fZOVB_<2ZWUH^C-?/J9O<e?:egJ-;(5E_[g\Y:YLfFH_/]7DO=VYb+#I>K-QSQ
<BULOHOc34:O.\=>MfO=GBZJJa#cITGNH(SKGK6A&gF<M/H1.OCM+O<?T5E#EXUJ
B#QZc\,R[C2,[Y8F-^cL]bGFMX.dBF#5KTT<5QQ5/cB>F?)D9NZPHS&fcLSNDg8T
<\A]S\6U/c]F.]a4AXUF;A(#J1S-0W\W4Bb:298-3.JR:HVZ;UWDOa+VP\QfcZG(
TdX]?0ZbdR/@4YRBV\[0JY.T[fQJ(aMS:8dd5da32>U.7f+M8=\U,UaS7=g]2(<^
QeD9NE#g58#<[(+7[be#2<T7=36.>=XA78FPZ>09&9W_2VIbWAA1+E9fS#;>)#96
Gd6C)Q)8)O,QYXJ6UgQ&(<ee10C&_WN2Q@YW2A7ddZHSD.^WF>\aWUHI2/7T##JP
^eg8fO)]L/112acV3P\T/c_R7S,7[-2:BNK(O9bC327KU1^V]C@:N/#9X]#O_V6A
])T0(E8)#-(SMHd>W)3#<(,c2X=^CTZa<(S1R2,@6Z2KYc\3O(A;+WR4R:KN?RBT
F;ba2S-&1bKG5Z&YMa(60I;2c\O4;b5AfJ/]+J:gL?)=>Y:NfC\2ERZ8H<X#]N6T
XfIPX7.2T>B+QG-T26ZSd^b[@UE1aJTY@A]M.b>1P^0cP;=?AL-,_BCNIML:9Z4b
ZX5TgE?N+FU_JIN/dSO]7)1O/bZU?#fS61#63V-cHBeF,FWgV=WY\F\BTQ7eJ4NJ
/NB([fE([BH/Q1BPJY\FQZ<d96,_b3)C<TS3(SgFaVN&<6U4>><^LE2:S(^\6MN<
@,9)S\J;<?,R2\))C)S,:7@5D\U[E10@JL-^;O]:->)JK[(K:2SQ_a#cSHI_^L@9
LG8/E<XOI03c,M:B9b0O(dIJ#6]MBfHaIPT//c/ZVQ[ESCLW=7He0Dg0@_.0DW\B
/JR>,7IQg7V28J)cSRNJ8OS_cL=&LCIKcaQ@0e9.)[.^][NS6:(@Y)#V4.eVWU,P
T=+\P)?\CINP[7g1=O/IS70?&LRfdS\DP6@U?b0f1E>5a/Qa->8P62gCG[ZJ5MO(
+)V(#O)JcdQE]A6Pe-;YG@L56SgDDHY<@1)P,G_gEN@cRGLPPLTDDPX3e>Z@,H>:
LR64_X03D/8LHV^]UV9_OH/3-Z-I&Zbb+V+,KbOAAXAgVg/[&1ef+bHP#A@WK;8+
BUAaE]=P):5db>7cD>a/60f,8MHQc?L5_SQ,&/bA+/e6AC;O6?RVSQd+^;FFD+QN
D=b2#7_C;CeAYEc=N7[^G:;JCDXG(eTe<#0RcSO&eF/K.2FVMCVRb5-DI=CI)dX.
+deZTb(6D[9_(#U].LOR&#/aWdf?#&.=,R3e?KUET:#-g_?0JQeYSSd60HdAZURZ
-[?gB?SF,S8b1?3S=QY_5BeEOR11,VQbT6W60:K?.QfC9;9fS-2Gb)H,=UCJL2_U
L?G6JAI(09/\K&CbK1NB<QN^4OfH]C(EOW>FL5LbK7?Z(eVWX.V9PKJKNf4KPIG-
VfUdgVQ-bceOHTODOP&X4fcc7+EC+6]2K6==TDba3(GEY&,GFc8C-<L5;8S7KNNW
)9FG<01\,G,CX>:X+0W//62#GBdf5_0SQ5>Ag[EZAX8g_QKXAP2(FbK(]Ue(YP0e
NY>47;g\25IW?9PWQ:;[2SJf.B>6;cc/MI]S1]5SFdKN>GDCd]FNYHf#:LR3ZBFB
5/K+7R;@@05/O9VGCJMFT=V-3T-1:JEK#?(.I].8OU4Kg)OB@^=2]IG1#A?;1]fa
Ab-#9:.+Nb<XC?DK=.O,UU;WAHbfRL66)MQE)MXF+bfB.1R]MfE6[dF86CS4dGC)
fREPFf^5D=6,@8?2(,(8^^[NE]WB;aJ/YcIJ8[X+\XH=a_O]^)FW>:POEH/W^W+<
RNC5].&F<)1cIY[+I,DfeUWT3T0>Rf0IU;OHca;./EA^Z#OI7M8JQMC;H#LE=Z<:
CSUaYec8^Ud_FI_5OY1RQX=b&dHEf?97</+c2gd@GI[2J+eeg1SE+D1bcg;4fP&@
cOF6+.-LGa0?@ZN./7414I+f(=^_)#-(A2/TDFFUb78PX>;7CX;1?342a\<bVf\_
g6NX817c_bWcLXc?SBF.Egb8B8YKb?:(YU+bYL:=T\,=ABT6?6WY2+-P6N<YXb05
43&g(3K)]7L_b2f,CP9CRY<Wgc0KK3X48Mf2bUHSaWf#;K1M&6I?:OASK<0L]WX6
d:BJ@fZV(KA-:=#?+;ZgeC6-S4@\Hf>bG_:^IXg/:HE@--=-GIT<1?WM,@-VbJ#=
MB<N=6+1f=GQP:?H/[QVXTGG/gE_6<C7=JJ-/S0A^@,JU[N10>FaaEI<./I8-^;X
ZMH3>LF7344.UQe,]feE6@/CZXIV]D79H7DENPREg4cPH.2^7F[278d7OK=aadeC
Y.XSKB=3R1NP3T0J9SG#(K[.I^d9F\-?<)]U91Y6PMA;VYe>aT4@e+#OYdHBP;e2
.gVQ_ga#\OC]G<P,E0c1F>D4SLR=SC__)Na;R=6L2-_ACH<#M_ISX/,d9IbLQ]g;
b8<;TIb]03+2_Oe+@XBUOJGAM+,SOE70^L+S\V;8#NDbYNf@[8^eO[g;+9\XXC^a
g+@a[C?eIJOG@47JV#6AACH7_Qa7(R&Sdb2[1GMG/;S;e+8[B=-F=&O?_ZeAS+a<
>a6A2BT.e/7YK8)0SaDCNY5+?)E5f(VVEb6@C.A.@b\^5#]]H4B^Y+KZM+<6Zb.(
XVDfW<T<7(ZG5bd9-XU&83+#P6UL:@8G?aL2cUIV5_/-C@,UAC(B>MT3c8K_F]P.
IG41:A_MO,X]&J\bc)d0L.GTP@P<Z1QNOIP\G>PA/b=KfMR-4#5\C/d^b?42VX8,
Z9\f(F69f2JP^IBI@OT5B1Fb7eR6Ugb&5Ag)eZd)bGc>DUSZ^c<Q3C_#O6^0IAUc
=Ac9]R[=WaJ,Y>YbEg6bX(EKe.cU,c1,_6A#MHYY7?==2#ZE7]S9X]89NPc[]9@<
#C&JO-eB)a>EeM\)X?Y?Y#+dXZ43=>=9=,-(HMD2+^_Q=G_+]IE7CU#J=a]-01IA
U><U1FU[A?,11ca+3E6eZNF2D,/0/OCB=e&E7=N\;>=^(37),I/VD7Q=V6CBe(MA
eEbcZ9.2N,_0>Y^]3(77:P32(-4,XI+]GPAR][[/SL0R^;,63_QE^Od-,Fd1\]6Y
\_5a_Z?#&//?Z/=RMYPP7K:cQ+^:#SH?Pg&>[O/#QVe=(I58_E14^OS<LJNg5[<@
g(Q;]:c]:a9/6S.NWe<2a?2X4>ADCH+c0QB+BFZ94VLFXc\#16MdPR3^P1eAL@JW
_8[?[A-ATb2YR9,WWC_@O;+a<:;A]cDFC8J_9M0g^/?^DQ<@?EB)6#1c<M]JIL8[
GaC+R15YA//-X1gI_5K&F,F14V@:,FgM_L0/AbegfT-[P>RSb9>Y)F#<N5bGbLYL
M9.6AU;E&=772CS;Q5W1@Kf+;BN?Lf39VICPH#(2HPP36BKBCB3D>U:B4[O3FbRI
da[PTT<QIgHYEXAa?56>;53-/ON@?F7._R=6TE0L6T/7XdW?;69a7N:)K[:/S\fH
&DA1MGd;7L1]^aFZef(V#\0-d1<4_B:bda?=\^^\EeNI;HF6^DJ,W:F?&(W34b./
4#R>Hf+@KGPM#?GCI#2\\W9J7,U7>dE>X9A)af6b2W@Z)fKQ/>(DUF(]e7]dJK66
I5D=D#F[dOC^?D4:OUUO12,_3Q3fDcAE/.\Jb1a,WNN/3A61CMII_,5fc-&I&-AF
fN(J]WYW/#99\LE0dL[DBE)T^C@E.dPG>2/^8K+#,;6URW(9,=H^[d&K,JXV#WGd
2XX)5]0[Vg/G)?6SMPba,7U>0/X2KSa-L>\aS(8QaH\N<a:5+C635UB6;TeM2LS8
a9MZ-gY0L1S^_#BSb&N7ITYgI\KO,+Q=R(/c^9#68VQF;ZH30g+dJZc)Y)S3X0S0
AVXS<Y,6/U^cQZE\=Od\XWJ>;>F[Z,4SL4[L>?X(##AG3PZ<gaI4O<+?UbbZ[N#N
eVEP8;(-DW_&Z-70J5/U3K#B.MIM\P3Q[cYS^aGT#;PWc#1,_EeEAgBbb5>8L<>@
0J3+QbLa^NRSQdA[?)<YY74.MWM[?.\GE\<,_KSTBE602cN@?a5/L@R,CYQ9DB&+
VA0R4O6gP+,Ne,ZI,U.A:@8f=ML^503N\LQM][VCc]O60-X.:f]9Y#J2T,@LQd3:
L.GE\GZ5f(O@J<]V+6a49^\4@A45E_Z1BV91T^>)B3;.3MK^C[_N/.e\&?5Ab&E]
7)W4JH73<=b/^aQW#WHKfcS();fYYFR5,GaV0E]8^I^Y_aRN2#?O<\,5(1#X@W7@
?CQEOUQg;LU))D.:eW7>)cFH)PT5,Q2J<H#_)Q66B[#M#8-La2:FAZ1Z&3U9XS05
cg1F]]0)>-I:Y2+GBTI^-/&\H+G.Y>3E@FT,F(VC]1@PRC-.ZaPH1O2,eg=YI-TF
#;-e7+)+R8UXYf=G04N;<W-E-FB)8O\33)Q#/U+=e#a<UMNHUg:LX01-W<.+YLg4
S4XdfgOYQ<HHdSYZ_DU\NH5@REB7ROS>4_0^50ZNEfJ@^NKK3WE92BD4D#c>NL4f
FU;bN4[2C=(I4<TZ.ZfebPeNDESNY3;=8g06E[32)MT:0#W-^&51F(TS+2=&J@HT
ScG\]6dd-DfY6X6?)1P)@(g?4R9CC/);T_/I3aZ(TZf1Z?I7O-dSJ#Lg<aR4B,(:
6#N?U;3OZU:bM#,E8C+?G=_HA&WBYO&T.SQ\9MF_5(H<gDY8G^9f-^g.e,E1CS+M
53W6[S]<^T^U--+g,)f,bYW?W92B#U(#1\4a3[Ea=LHA@R_;VHC.BOeA)],Hg?1R
=\DHN;.H=OXEFf075.GF[T\b>ULXM(G?gHD7FNQ(W:9[J7;#C/BRc>7:A,#5;NM=
&7&#@@d7,,W/+1g+,4cU+LJIL^->S4.F=[SF)MD9dTSe4M)3)+39.@X:Z82,?\/E
2PQ.C+R<E;SN2WM(\aVYbD&_S;_#3?&f0?92b+^+[c.8d,.F#[b^f&E>Q?/dJ=@C
GE2.1@)NOB[.-g=E)e.];5S3Y7g&\M?KcGcU5>B5UX[DW#-UXf#bAFdD[[a4P+0L
KKR#R@7H\M/1/BB0HW[N05B5W4BZ+>G@55_H+ZQ68CID=Z8UDVMWVU6UV<:E[H\Y
/XPXSI&:)8E._N/=U+M50H?KC<+5d499I(L;FY)?+P7NUbX2c;XKN)9AeY:[dXa6
&KH=??M?V/+36g\6_^Q+2=Jf/4D?IA7DI3S.EJ0P<@-b_K/H6dLEHZ)KHU@#]KK4
=;_f0#@9J3I>bP,25=Yg8Oe#XQLL7,2_3Xc)3+X[:X,3B#=RI^J]^3KOS&9Y1@+U
)==W46XX(_(HL@V6c-VH<\X8a<_>3&+5655;PNEe;GW3dAT/^7U78:NSLD_Ra>S)
QM8fC7EY7/b?9.MWI?C185>@eU0<?/^Ef@abR7fd]=>TLGAe6?XfBf2@A2O_=X9a
>-+L5Z4H,??R]AJ/+ad#?#]_U1^=VAaV8bVAf3S48bfA/[<bP\Nd@PYP?OM+feAT
KXK6(JTF].BA(&R&-KNUU=b=/]&,TEU@eMD=e+Kf:,Z=JI7-^A?Xgf\B.YZFKP3I
VfV>b++?3G(+3;-8B,GX:?Z-1]F64ZS24(F[5,Z6^+fQ3IMPa(G;6WTX(eG@[bA)
;R5.+#M=^.MSV.0V&01THDJI&;,/);7Wd6d3],d-Bc#4Wb#FEQH;ZKQMD)<6UE6Y
P6>C\K>/OaE:&;0J=/bA-=R>)MV(.9IH_6?HDe(TTC,QY[QYMA:L5TU.5,Y4<=L=
E\O[aUg5d<7aEB-f1XO/>8YH8fO7(C]?(C(;TL5XD^<FK7;aIH=:W^b#UOa6Bb=K
U\7>Z/>F8N<5W5;fUUSU_TH]P,NGDC0dY)?4&C+=T5PRX-@:fUe87DKKXI[9RW/^
#<&bc@B3K2NKODa+&VHRd_SS4F[Y]98c8C<d_9;H=Sg2G+F3R=(X3^.7/g@JT<GS
/BNPT8JPE2S>UJ7a)bS_W.NFF#LWd=EN7fGBH6\d,\>cDaZ-H&dPN8H#2^I(Lb^-
9R,MG?>=c8@f(LLY2:bgZd.7M^Z@(2+>S2J)42ARW]TdHXVe@V_MWKg.c1/d\LS1
=J[1ELG2E>@c7.2bd5BG/WR)1;FMbO;D9:@I;?d<\8N(FZaL#XY]2N?V@D\JOVHN
Z6.[a?=^2]DH_e751H^+YeYI5,\[SUI&A&d6?FcNO9LWNN([7@).;Q@MP[3?B+N,
_I.N)]fTeQ73e)A(>@WU/S-3):Y&@<ZTJ118PU)@:,W:f/5,>Z/-]\,VXF,T,WXL
fI@99;.&.7W3TTS+U3Pd:3G#2@+Pd,;OV2RMY=Od=C1e.D#IJQ6@Cd;]/9T<8f/^
4eNCY7-4+eb7&.TV?[<+T5=[)0EEe0T4NI0-;0+SI^C7ZRdN72I&>\MQY<&^2#DI
4ND[[VbgOSFC>E)5MZU.ScM.L[C-MI,IDTU\GfG]8P^V&SEg8GNI&7;KX3K)WcdD
VS:XRH[W04R]I6dOPS,S.[K_^..g2D?>BU\URRVa5F/ba[<QB^UZg^08Z?LbB25L
,_W#AA>YX401WH)?0<K0Z+7/ZfM/Ia/0LV-S7C>]g6I\5(>.6,\H3FFXN[gBH6_TT$
`endprotected


`endif

