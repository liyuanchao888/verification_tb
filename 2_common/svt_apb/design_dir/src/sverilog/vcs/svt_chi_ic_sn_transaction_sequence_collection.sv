//--------------------------------------------------------------------------
// COPYRIGHT (C) 2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_IC_SN_BASE CHI IC SN transaction response base sequence
 * Base sequence for all CHI IC SN transaction response sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_IC_SN_MEM CHI IC SN transaction memory response sequences
 * CHI IC SN transaction memory response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_IC_SN_BASE
 * svt_chi_ic_sn_transaction_base_sequence: This is the base class for svt_chi_ic_sn_transaction
 * sequences. All other svt_chi_ic_sn_transaction sequences are extended from this sequence.
 * svt_chi_ic_sn_transaction sequences will be used by CHI ICN VIP component.
 * CHI IC SN XACT sequencer and the Interconnect driver will be using it.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_ic_sn_transaction_base_sequence extends svt_sequence#(svt_chi_ic_sn_transaction);

  /** @cond PRIVATE */
  /**
   *  Control to enable/disable mimicking ideal slave mode
   */
  bit ideal_slave_mode = 1'b0;

  /**
   *  Control to enable/diable retry responses
   */
  bit enable_retry = 1'b0;

  /**
   *  Control to enable/diable outstanding retry responses
   */
  bit enable_outstanding_retry = 1'b0;

  /**
   * Controls the is_retry distribution weight
   */
  int is_retry_zero_val_weight = 1;
  
  /** 
   * Control to enable/disable random response generation
   */
  bit send_random_response = 1'b1;
  /** @endcond */
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_ic_sn_transaction_sequencer) 

  /** 
   * Constructs a new svt_chi_ic_sn_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_ic_sn_transaction_base_sequence");

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();
  
  /**
   * Listen to the sequencer's analysis port for completed transaction
   */
  extern virtual task pre_start();

  /** Empty body method */
  virtual task body();
  endtask

  /**
   * Wait for a response request
   */
  extern task wait_for_response_request(output svt_chi_ic_sn_transaction req);

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_chi_ic_sn_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_chi_ic_sn_transaction xact);

`ifdef SVT_CHI_ISSUE_D_ENABLE
`protected
JN7=1H\7dS>ce#)U\RL,<<+KE<8C+/5CKHFAG=V,NG/U;PXN1</C2)Lb&T6E7WIH
)L(Q/+\-8gD_TJU1BD./efU:Qf7D<&/:V?],HW)EaG=LZb88T<BZG?BW(RTgJ^.)
63M0JbIQECaI/RNe?ZYa?G;ca>dC2c/;6fa[OOB5CaTT#WHg(0HKcSX/@?@]6_>:
ZE[<XBCWL(>N\L^9JZAY_?;c6$
`endprotected

`endif

  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_transaction observed);
    
  endfunction

endclass // svt_chi_ic_sn_transaction_base_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_transaction_memory_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_transaction_memory_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_transaction_memory_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_transaction_memory_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_transaction_memory_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_sn_transaction_memory_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_suspend_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_suspend_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_suspend_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_suspend_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_suspend_response_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_suspend_response_resume_after_delay_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_suspend_response_resume_after_delay_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_suspend_response_resume_after_delay_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_suspend_response_resume_after_delay_sequence

// =============================================================================
class svt_chi_ic_sn_read_data_interleave_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_read_data_interleave_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_read_data_interleave_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_read_data_interleave_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_read_data_interleave_response_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence extends svt_chi_ic_sn_suspend_response_sequence;

  /*  Total number of DVM transaction recieved */
  static int total_dvm_txns_recieved = 0;

  /**
    * Output transactions generated by the sequence
    */
  svt_chi_ic_sn_transaction dvm_reqs_received[$];


  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence

// =============================================================================
class svt_chi_ic_sn_reordering_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_reordering_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_reordering_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_reordering_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_reordering_response_sequence
`protected
\TEG,W;CW?CBCIX0WM61CEa/)De[6>c>:8OLfU=->5E5R(>?G#Gb))afECF5JLc-
4ZH]/2Z)9d^Tb)KE>78FK4+&4@.R9fH+<.X5IdI0]MDJX>RBW0aFLLJaLC2F/1Zc
Qbe(,g3G@g(O.20e3GD]d,^\9Q=]ZJ_U7DMA@7Cf+1AQ)B;gHLC#2DQPfHNIf2Y0
6#CC>\+<BIT,EEQX7(EIE9.:WF(0R./-0-O-;T6e-IMITf9675JGLTLfT2cIg_e-
IB9BKWC2R[&,+$
`endprotected

//vcs_vip_protect
`protected
0#-Z^Og-c4.LJAPaOF]Gf?YY@3R2SBd&2A?HYLcC;RSG=K235-f(&(<(Q.Y\9N0M
cceEDNHc^fXR#[0L[Y#]:)_1B7:8E#^BH1<eUTI#CC@TfVc.geUL@;Z5TS<a1D])
+<03DN9J(E\^cb.dK@.FD=K>ZOF3T&aNWNM:BT4W.E_a)_H_11gcGXa7b[9SQ=M^
;K)d^_.IfT3f,(/6^a^]T5:Q(fHKM\#KbcTE/M7VQ;^>&Z&DVE,(e.G2U<IXIX?1
5E;Z8UC,_>(8CR_M4X9<1QV2=+IJ[)A@.AfHDF0JI.SOYRQ)1Se0^]HRP@;B[3V^
HRfY>.]2(V/>@YPG<)Ja.F=Wa_E2^C9^FYB););.\):W&^1XAB_V_CHA@L9\5->P
bBGNIW[Ag\bKK/5B^+CBdVNg2WZ34)2-=eQ10Ta+e;QaU\(=cb0QMfg3(D+S]4Q2
Y>B1aadYWg_(O^+(<OWW:Kd^PKG173=BfZ2]H#S@gPf<=2FVY9:+(TeFTe3?9X:-
<0SFe,J/9S1&.=F[FdYJ=-2ReD?X,=7Z<bM=ggGT:@Fb51J/-UXTM1^M-f-=b8B=
_K=:B?(e..N\KS7a9f@D7=>I>P.^+[VRN1>9N/-DVbM>/J[adSeQgc-U)MfU18\=
64g8IY-aV8VS@f]Qf:TWMTP>5#6@@ZRVCH,NDBUJg;F100B\&a]E#/fM1@.;[9gS
7...Y#?YG4QSBQaBQb2IC^EM=JcMGVYT[-8&Uf,P?#5M,K0V3QUNUg0Y9?^UO(UB
SM3cVO@TSG:NZ2G,7RL41a-VLCGa0+UcL2GZV:(G2A=@AM.=QO8_Y8>dKMVFN-(a
.)BS61>J;e+/.Y2Q[d,T--c;BDGX4W^RRYDDA#(beV@SC4KYZ&gTXg_-c6;H9-09
OQ]51(1gYefZAPT>g8FWNV]OO]Xb]B(W.D[>[WW-dDLTbI(DU+1K],QHGI,4=C,S
5F/^PLJ9/K.d.<D87\T#X<1//(,3[IR\(7;9>#T_1/(R#RH&;7U8E=:V9/7ESY^N
N?7aT\5N[.:OE:VP96)gXa.aM&8ZY/6g)TRK2U>I=Od[gHLOOb^c#H5Hc4MKX+83
L:B)F#LMa4@@Nb:K1LX/UMeTGQ;5G/?///LeP.):)9F2^,(\Lag_Z2I(H[09M)a7
<>.>-G,MMe(6D36Q#T23GO(>I2Of2)QBO=EP?AS+&BSQc,gCV28W(TYf6216TbXB
2a704_3WJPfPN&HBUHTC+]8[61g9-4_H?A[]TV<?:IZH7MO1XQ?3d[S58a<P:A3D
]SO^XQ/;@dQ[Y7=U\+]Ueg?(M-D.<fSNg2Ac.R;9e>_JJ&b5O2cVXE/g1:PeG@_M
6]QR]4<:D;bK,>ABKUCDAA=5)RaSbQZ,5?O5M<ENgHS5?QDc-a)cbe5&f)QFBCEG
MbL:IWE#JS/W0:Y6(E?W^>T.c/-2&=:5]5F60KHO?4VM;#U7^TJQR9H,04H;IJ,N
Ve#@4WQE7_K1H2cZ<aT/f;Q;gQ<+O@_aeN;f0\>6\2:7;Z3OdgGS3-F)cTT39)gg
ecRW_WS[0@/daRJX,WWfW+ULbe5):3--U(:?:3:X:)K?[ENHI1>a)X;PL7<Fg]FM
BW__8=BOJSA.,>A-aUTN6\P9e8KPGK]_KTQ>8YF9UPS50=N34_3HTC8WPCW=E,MK
5cb134.:>5#7&4V-12Y/0g(K=9A(7?BL<X,V.ab)fXSfF9DPe96H6ID?U57H5_&K
</207<+6Edc]/P:C3VACTB75=T8C)S@:ARF=.Oa2+]E6Udb>,B:UAYeTZ\O=RMO5
EYO7;N9/;L3P?MJ;ALJ<EL43,#[&9eS_;EB2ga?<7KHO.^)?aEdX##T7T-g>+2bK
f0^+-I2YE@f^/]YCQfc+/5^QX32C675d2C(.R\(RZZfJ^H6K,/O5;dDOF[##]CNH
dcST,\CPaAPL1+I=gZZ3&f_R5M6->8SR\?(=LI6T2).CG\BPX:#adL<_QDb8Q;/]
d2@05VH7EM?]4Af\+&6\=@=gUF>)H=J)A<U]MaN^1=TL7T.NIISGI=Ne@U6g+G(3
bZ8,_>U+S;]d61@SB8gP9,SLQ0=7AW_\=JRf_,+7GH7.0,,E8dg#JU1JCO0\>R04
+b^c:0C2OFK\VFEO@3O,HH[>GRCRE_9c5)./Ne&)6H7]2.U.U1=aR0,e9N1cQUEQ
Gb\5\4Ne\1?/U&Cf+QOFe=&c.^=e4JJX3(3HCGZ0aBc_2QTe.O4^\\?LJ7MGNG1g
1aH@9a:gX,JdFO8OTL9#G_^M?dX=\5N1<^?5,<9f+L@Ge[A0:Ndb1P4]^7:[>CQA
_:7F0eN#DcGLG9f[;##;?a2\-XMHC?Rc30=\JJH0.;f.&/bV=&@:0cP&2B(_BUPU
.>b#5KZV#W@1^MCX)+=2c1N4(QQcFND72PO@V?M^DCD-Q.;a1<4U6S[2N2DOWL7S
#>0<]?VbbWc_\S?]BF]H9aZDC9AH8b2Qc8,B\O6Z&)\VG:Q?O2DGf_0#L6E7B\dU
I1K;g?524X/fYSg8.YF7\49ZUD3X#[MGN3>DXR2C^IF5RM#&a7[Y];LafXd+.EOd
4TEf.1g:,75T^\KaNgZAS5V-eB80-[05V&AJE9Lc2QAab/7W7OaBf,@^7cL=;(?5
9=(Y&C0CO6\18SEaeY;]3\a9GAY(<8bMd+9[c>-2_A&V-3Z=J5eYc)XM[/ZA/PD&
YA;N^7^OO7.dWaAK,+M[/.aC=P,^:\(9>WAW4,5,KQ;RHOANN+)WbFO<_>NW)EEK
W/+1O#S(IA1.ZK.DYBCLbP2cNQ8N?&PeV>=G<SX>?IIZW5R<X5c@V/0FaTKH65G(
.+Q/3^V>b]34?3B97F\Eb8G,1PIL(0J&D-gD@aD:AL>L-9DQcR32f^d/4^U4S7b>
C?,#VY,1Q>g8&GHEAP)8dKKNPNS&M<&VEUH.4\<9DY;J=b1U>>&f0X;0;U&)]SeY
J_Dd1,4b]GRaQ(Gf4(;>dUF@X;+6,/?P5f.YJPBLRSI\7/L5?0S8P^,e5?Z0K)(J
/^BZ_7X4-9#D\[^8Sfd2W)d6+4]SMI1[CEaaTfaeeG::@V^\bM7;8\^BT:WVI8=I
(eL[SBT3:QQ\0BDI2^?fCR(CEZea>U0X>d651GC=YS-.U4RdEZ^\5GO>6GaNL;.=
eV7A\eCXf+KY4-F,+8:FA3[H<#JcE72NC?_8;c5B#=Pe0<RO9@2B1Hf.62],\f8I
94PO?^R;]KPCK#[a9V08c2HS[_M;bVODA^XagZ4Z<4-<1LTf6cG.8\M@O<VO7g?6
,6G0?\42SC7AWD6CIQfQA86)Z?3T=D@]>\_09XQC2)&WS2?GVZ_YQM=ONKddHJ.U
b+@#@MB:AD)T.12/7&32_UTIRVe[c<.;MMGJ^JBe)f+?bD(Z9a^WdP;<OQGO^6Yf
DVBG7MgAZ4HS/8BN4GR^IYBIZ.0W.:,[//XUNMO8A8>,+T?RRAf7eL@4.e,B&60<
_[cTPAQYFZ/U/,G,_(O[P>S/HPLAHEXSSa2K;F8_@Cg#@KZ/_.FR?b6f+[::I[g@
X&?9U_,4SDNNA5RAg,4(c@DM?/](X_^gO/#H)Q]d\:M5.1FHP,B:M8H^NKKeXE[R
YQLB013(4QaTZ@;3\73[dHc7WV59O)/^^[+C7BJ8CMY)M7QDcZe2^>7IgfB,f8?B
_92bc,Fg2,UU4OWa(9/e:A_PS.[?D8:[1)V#?Gc\(U[#GeT?Nf3I:ffVRYU&?R#(
:5;fDAPM0\:.cXRN+CJb.&KBG)J4Ha^/IT(dX&K#Q8Z(P6KT9W>,E]HRBHE1b(YL
TKQ)&?IK45?3DJT)L7a-P^5d/DP_9JeeM],XZP+Ee::cG#[1EP&_86>/=A,KL2,U
2J#d,6>).XadC5DP/f4\I7O]-J_1S^-Y3K-;65]LP@Pe6E34TKH@[R2P1K:\?U:6
X?]655bbS9^4KGDI@aTEC1&P?0JE3_;Q2/L<72@SO^?3@4BX_]7VZ]@cd]<7>Ag;
g5N9?LA@C,(CaC<OPXF=CJ_MO#GC+g=ZIHdY6A2FB>_6D(,T^)L/b\.#+PbbZJa(
--<b1\:Q7#]4L9_746Te.AW0HHU(_26&KIA\J?EY:IH.U(J4A0&,_b#HI#FYWKON
a6;Wd??:7O8]S;SdJ_<^B<CO7/5C(AS)<WOOQ&/H,N#a(^NId2AI;G3)5[:C2c/D
9Ca721/KTWe.GM[DKRP_.D_TR=3a]R;>4UTZQa?D]^A\S/JJS1&3?_HKbL5^P@4_
SCW_\]R+OYR1-_/V<U(16=a<ZXOfT394a([EE5=SbQdV\bP_Z^ZgLN4R#8+O(_=8
9AV95#6\SK,5_^BYT(eS&Y3[0S_.D=[>GZ=NO4@O:.,@c2QOaO_K<6dF[_Z?;dW3
;A4O58X1I9M+8=XOgURWX54K:A[Q?GUS]9V\c5/3L_HBQG/d@_>Fegg7_<QYZ_?[
=gSg.D^\6dIZ[<.eUL)@M>W57QgJ.<[e)G2MaFVXK)K,N#a^aO9G;YNWdUE?TQ>?
\SN?[Z86S<86=J6=(XdMEG\fKL9D_BB.[KI(S=@QW5VQ:940Z><AZ?H-G7EP10PE
.5PWX0G>5XNHfURPRRW<)O^R]_cNDI:I^#F=>]fRc@^_,=C>TLS=M40dSWP9e)Q:
]DO.I+P(c4D#O\B#,a=G5(G6L..?a.DZ]FIX&&UBS)(^NK4_F)#[2;Z;4>1IRZ9Q
\_-U3>C3[)8B4]B1#dTG?6@_HI37<A=c8_7-?&VQY:Q4#OaE;VFXI.6-3U6_[=RY
Kc9G]24>CIM^LB_3Q(U:Z>[C]6g\L6<@Lb:F@[a:G#JPb<c:=,[H0^e0Y4K+>L\f
:R+-3f>?#P7)^S.7ID4NU(9D+/1;51dF0SGK/ED0+76/1-;]c+OE0>H01_F&S<JN
K1cWOR>SgEULe>]VR1^C=HA-ZZV9c_6F-J@6P>E0MW0FEF-8>W@N\e&N#HIV.Kd+
@0CHPO[M1Y[^BZ_^91dKU,T2,T>C,:5cI#H5]a[MgMf]<)N@0,@JSX8d31.OH#;R
b19)N02S?34:41S&UN^<2ZXbG->Af6Gb]Y<aL=+A:F8(,L(2-]D/#G>_[GSY5;_[
GAcA=,]TQT?d=d4#],26\E:Y5bOZU?L@--8H<[;AT=U6TNPDS-94)\MJV.R(R&#C
=SC2Q?;aCPb#e5;AHa7^4:94\&()^+M(@dUYWgcKLJTfa^B)E^H-&I^9+O^0,:BS
3H]KJLLG<(__J,gd;c;U\Z@I</^RKV:Q)\<1Z&/N<GMA]AY-(ea>ge:ZH].W6d4S
77_&aIPRa\,_WZeE?5f4HKPE>+[CFN=B[b4Y?P8GCa(/#3+M/PJZGN;,U.OJ1),a
E<e_.M3RTJ+d7@Ef.V)S0?R\C0<<0gNYAHC-c.R92OPOg92XYIc=LOCWY@D=WeB1
8&6LH(/DR1&IHg5QF::XIQI=J8N5EHa:49223\-S[I88d;Y:Z<ZBV>W1ULI=1KO0
=NA4==FeI3Ba9eFC>T^4a3Hf8c+#;8YGO3-X&fT/3UY9KS]V=4-6Z14c[5IX0;Q\
_<59A5I,Y+>:eg89IVN@ZR(\Y&X[=8Vc]P(X,b7#?X&-BSW>TOJ8>X7?>-/W-QQX
I523a[0RSf)YIG.:30b#ME#&2.T)ZI^dNcea1G+@24V?R4KL9^(A?3gJa<APF(59
H_[[P6BF5;F#A=(_;)@@UB6Q&TO+=&O#J[6].c_Eg+ELH.H,G:NAb_g+,_2B4[9:
^\U1b(D^dZ1@Z:P3E.0U?N_NSQ4,d+B7@;5:(IA,9>O/>+.UG;;FJe/=GW<RRDXD
(bY3P]O_QS7.e,O8G=EH@,e&M74O9(^58Q\dd4.(d+,/G7W[QUT91.(BD&,K82]S
P&d;A):J#06;UR<(XE@ND_]c9-363IQXKXS_JV[,EKEGB6dL>(=WOLILU52Y#YKF
GM(U(.GK-4(/Fd6<SRY7KJJ06U+7RZ0?\KOE#^@QfA>QABC8YRfHQfO&;)ZGLCXA
eOccA@;]bTCfaQT/<5Ka5d2;;&)@_9a>b]P^^/RaO:Z<O2RJ1adbPTZ,:99ZJD0E
;0O^KCL2;B/6+e?^Qf&Y[WBJTc\f94K)=Zdb\W?#@\;W42AYEfFOIa;8G]#77H=P
;bR5[&?Pb37bF;G_BL6[:a<DQdCI^g2=VG=4?P=&7\C-3:=B.RA5L0d<Ld@K(:#E
XLa@HM&/)U<+>^G0=)>d_)gW#.>W3KPU9YIXBTSOND>=;^NaY@1]5.4M00\^S)=2
8+/4a0?Q(/;K^+(:Fd;S=3PdZ\;.]0T/[?dBTTaJSWL,RfQV_bRPe#Q9]^#VGC=X
IWO&(7M0,R00M()4Q@cHLQeO8Y(VLa+@[7ZDVQ>T=JX=c_V3?^NTG70CO6Q,DCaZ
Y0^:)+ea&<^gB=/+ebKcgURHH0;V)VD;?+N>8be-X5+/+L?b59Ra1Z[4=O3E_Zac
SfG/0KU/^QR<cK>>F1+/;]T=>Ld5E2_E48VG_Z4f\7A@7>ER^,&V[Lc=2S:/H1+;
CC[2^VM3/J(^U.YS]:e5.@[QIY_5:S=OY5<YbF<7Nf(aD:;VD\ZXZ()T1@KLc33e
4.Q1g)3Ug,YXI^#^?=Hf3Da3&=2:RBYcG8@LU.@L68M@-B4.8U+EH?aK&?_;<aI.
&#a=eOX^Z2UT/0/@+&G7d1f-+dKC&GO@Ae=]8N47J6:4(@0+6[+PL;RIL<^><,Ja
X14E?/?aY6W>e]]?0YL8J)RW?G?^)])[>LB).FLP;:AC^3[C:9&EW/ER9aOb[5@[
-4f9335MZ9>]1fK]_P3.8P1?Wb_]1\<AH2[43SDSQO:aQ-03;AgRP[cR_3-D:f.g
b>J\a(7IQf/#/(D?Kc]&G4BS^F\]F<K7)H2FAUbc+bX3b4<P/T=?3:CbBI\Y;&RG
^/K4f0Xb)ED.gX</Z09;624D5I;^6N]MC\_;QSg>+8YTVBGA3aSN:W+bTe&I:)R7
&c/45TPMX)gYU+6fc0RONV^.^.G<V]Oc=K-BAL0-5EX5)7)\&,824F8I]GW57#D3
ZYOODS:)e,M97#/Y<3,@gYDa<,Y3P=f3P[Y]]2J[CWL,ZLeA):)&+=,5TL#SB5Og
AX;OYU;Bf\/4ZAJZ(HPYK8VM6+GKgA::[6P_VV[Y3G9SR/2WdE2YAc]<&M^_VPc5
Z#_\+BI2NK[e_3#0A>:a&6I;HLdC-O22HPUZV@MGO>]=_PG/Ff,gU;3#UGgHA\2-
/G+WX5J@?QEaf3MR1Kd.cddH=RG(71e3R9B8U(K>IX_KG&(4CY;ONPfX9Kf\I/?g
]SLF3Z=\6.6IcgHX7:F#/<#-F@aDPG=/51X^bGbe.?CI(<?B;;WdA:N@MIddY:F7
I:X1[I==<gU0#CQ/:;S;K<&bD[F+LUd.c;Zd@[1.7fJ8MQK[Wa1YQPcbR\ERHJ5#
\D=GSb@+THK0=5XZP9+:=(U/]#KC-4?0T3<I#>10eCdg1O,AY2\4E\6484?bF3&<
5=)NO/><YIA=>?:eE68MD(1?:)CD[]TD#>4.E[=-BfHB=c[/ETS23MSWf>K#3]K]
]Q2WL,L.]d(YP=CC>WFB[^G/CX(6XG,,+S^>>OZ4O:/fS3J6L2]NdcY+fBe3R9bV
K\:,D(FX8LHH__.LX+Q:BJG)#U9NIL])[IA,,bFKW:/^UMgFaG:BDAHV\P^WJ6QY
TUL??T3f58AUW:#Q0NFJQ7a1gg>\-c)XJR_XOED2E.EU&^GMC<Ke\\@JZ)M+X)KA
d\F.;K)@aEHXQ6:WTVLI3<<X7c,X)P,HQ]HRVU[F7T.<fB5LD[T#^9XNUR_eF:[F
a&J=DDJ9NQXe5WH4Te390\/[OPY#Pb62=L9(\L^Ub>&UQJ<HOVP(E9DL_KJ58[SL
R]HN<>97TPNW7LQ<OV4gO8GZUF<D(V0I^E\U@L/B+I(.1/8:OL(MT#B,#eX+M?@G
e7\X-A-7^]&V9<W=?&C[?ba.dTgZ\bU=b17A2[G-ZBS)(?/<TXcNM>gAUg)XcagT
T8VB2/Zf_TIN1/g;cI&f3J&E@\63BNU=fFG8(HJdMLZ0cQR<V5PT+4#\8)KQR#MB
63fGI_JC(P+8M(fTX(M=7OT^:Z,/LS8<&57_:=Q-WSKT\=4NSX[&R5e(f.+K6\/V
BD;8LBG_]5>_eOfX#+WeYZ)eVPQJV.5>ELB3V#GB7/c;WA)NGMN-b2N+V1=?4UYL
bP5@^HRTKZBVbB9G5?@P.EBL8K7]4K#50PMUAG+BK./@L@(XY2CLfVRS4K5&)[9T
F&TSQ<A9;/KaZL>Q44GFb#QfgaDPGB\A><UKKW=/41)bR\UVHK1\cbLJbDJR/TdA
ZV-K;A[5?QEgTY@F=O^<XGRQ9,\9GZG;>E.5#^dE-e3,fECY#B3/@?.\OLFBF7X=
[QTYP6>EDbe8(\<SaX]Q#Hb(NH#XYd;dT=e0J[H>b;=NKV<G&\H#A@f,F,MTOa,d
5BQW&UMV/2#G=KRf@2P3YK=]FUY5Bc;085-T81P5B5[YDbf,ecMJRTQXZ]1N8=^4
J;G:fZUIVRab6-BS7W3XaRWb[ZCA,?fJQ3(UgeB0^1@KA.WeQ-S6M9R7Y>DbU?FT
&_&aV;A>WKVDX)<cVFc[SJH32(F1&&=HGd88-0W(AG,,9E;TO_MS0@-YN4T\OU\B
>MN:2,.DbaJ])D(]8eV&AROc)BC+P\8ER1W<e&U#]+,)gOf<T_S_4N:f[3[TKR2V
(WE?;.&N<J)I8fRL[aC8b&1H;B:VZeL>b=N^.5N_+^?e8AQADA4cMAH?ROH=U:M.
]](f;E\8<EfIC7Z^Q]4MB0<W.5U^:[aCW,8=Ee;eN0Jd+3Q]5c/F1GN3e1,MCbSD
V?KWPcJE(T/YNT3O4C#]8e>UGe15E+_e[:^01^VSXA&1<_bU@KdIgD\+J4E3AQVS
FQ,@:R=7XfA<=(M)#1NV8\J^3RZ^b(A=#T+XWYLV@S;<UU:V8J9cQGfVV2J#IIY2
VgMD-(=)TaMH0XH8-)(=c+f3V2#^V5PSe6?eB4?GN7cE#=Se:^ag;c,I]XV;gO-T
#Q#>,Q?/QP&KCT[gJdZ0@gH[KSW&UD1N[&O,LS>/R/:_CCAgIGPBgRVTWDMe6FP?
XU(_6_8f(OaS]4^/cd?+H<QK:69V7MXH?E-2_@baX@CZ4?F=5YR6<9d:I+U<d05a
5A9/UHL-HW]Z:Tg[:=]2UD1=@?#c5P>Mf>b?2;<dL,_^&T,DMbg(SD1Y-_WY9K3Y
\[3g:a&Jg7^&2dBJ/;+/BA]ecS[>QN/bI_,MB)O9:,9(?;PM=FJJA_\GWIDHT&&^
C>GVZF<CYQTZ7E]0e??>+Q<W?OKg/YBG3DXJ7Pb:0>B+[/W5QRU&PS0,(+)V1V7I
GRHe90BCYS4AH4PBDJ9\\;WaN60MVI0)Wfa7\SO68Zb9=DI<]7-&1MO(ELJCG6RT
e:=:8I+/g@#/&Ia,?&>?:C(Ra3TS>@]T9U<_Og:=4W2-[bVA/OgNE(@BS@gF_ZC)
CM?2:MG_0CB36C/-<,FTAYO3<.?RL4a[\@&E_ECbWRe1_>PUX2>TOR,6B-HX2XA9
b7&U/&51Qg=&dO2?K(G[@I3gIX7+M44Y/D#>]UQ,Zf+SWG8dS<e/]FM8R4=bYa^S
/#T4:1URMLYCgCH]11QH(DN@UJ&I4(84R<Yeb,TJAM):)UAUMSQB&Ea_5X-]2&XF
8E^&IS,^N<]^JVaI9D92U?_[BSMVbPIBfO7_(;DD@Z[=fBV,f:=ETQ:eL8SgD)5U
P+5WZVTQ]+M=M/>WU>E#2^O(MU[0ZUU(Z?B[[Y2]&I_#eCZ>.<@/^5)]U]P#A>:6
MRcN)cd5-5RI\R92OdJCM<I)#&O#[@;+ZTVgIUE>64;b&+RNL7V?0d7YSH_/V>=K
Cb1fJ3U7T;O:ZFKEUDB;@^^O=d@e;Y=EGgdaMfeff;ge2Eg=ZEXa?07PV=):3-X8
O2?E>?;54P)-W1K/-d:^W7d?;U:M._>.CN6HgbJ-V^+R6YDg?K=TC@gYWZZV?Qa5
MWb#1cH44ABVUfL0TH\GVDNST1&a;?GQVd5+26T+d9g=_cg1L44=.@MBfd3I8AP&
.]0Eg<T_;,L\7?YgJ<<.\eJa?6DdU+P1_,]E2_,3c,>EO][dV&ff-Kb_Cbe8=:7Z
;M<M#VaZ&Y[Z?O4^^I5#a8541;B@aG28B1V_J+URH:9,<):2-?D7g_af-WC:1_#&
.gIMJ.,2d1fMZD1?M)-5TLc@J-_<10bANEJ/)2_1<U9M<D\a+WW9#.-2cD,gEBNO
YI?^CRT0IO.C5^)_?L:F;VT&B;7e(^VY:B:?^_Z#H_U+[P:>::aQ4+@_CRY:O8cO
LGe9,g7.f2WA&(46fO0ENG;[:D7e(a]^EAP7/>.(Y-/Y@.+MXS(#]]aDcJ84U+DE
4^Hg.3):6^(;T5=HZ6cfVOZaOAV282F6^EW0XbCS]9LU1==_^,>0+TPQ/YcO:MIg
J]XN@3BUdD?=D(IC^7H1YTF[8M,0>O/:e0DP_1[B)>.6ag3eA7fQc0S>Z2CRBS39
Ug:,,OTWO)R;54-S.:LRCOI^1W#I0BCPBP@/.5F92FdGbXO@2fJVA7X6L=7_8T8W
_^EAJ^OFLI);f<Zag1+QZ?(YI6ICHJcfLJJ<:Od(@CD03>#CYf2.D7dR78-&Ka9V
MAM);O2dMC/^@X]^c]KHVFeE1NWX?+R@cGO;g(,4S#X?-X#BP#WF=ba;8<fD815J
Ac3F3>e2,;4MDDTW(__;d/FQX/,F_8^JGRI;Y=(=G=E)@=^Z7V)PX1I&f97a11KX
S7bgN_XUCBN1MJCQ5JV5?UA+5(<V2d-A_S?1R)DS7f79N_A(\HPXX-.;M>a+J+1;
?9ID@HF:B?P.Z5dJIf=a5?+-M_e>5E,bdS2IN5432ec=.U[R)2g>>55E:NMc@&Kb
DK^V,EBfFc(gY&.OCHKaPD&IVYMQ,bV=;.N#M)RHMKgXYeBP21Ke5fE(4X(e,^=A
bd9WaI9M]B\[4GI9P.E@E./RPVRX#KE)_6F,;TOQGLfHCH^&D?d:A/\Q^(&ZPZb3
0L]MCS.ZDX-a<4+(N,-=eF+C_OXbHE@2XZJK]0Xa>FM@,86dA=BSK4NRH^5/I,EF
+D58L92,fYTbU,V8eI_>:\SLWT?DbM>HeZ[F.CN^8J^,K),1OD^4f^Y>(OLV-])>
VCdb1Tga^L+)(AcHE]R#2gW[c#=#AdX#>C8T^e8W[F-SFF9YU=GMS/;I4N[N;URD
F89G3Da&b&5<]<6b@aF=L((:+\JQB?Y83L;7B\Ka9K.OAA[eD,]L:#dMU^B26dde
4QP#=((3>IIO2-8-QgH?@7-P-T-R8/[G?/VZCB30@LJ\CS8&^8d>48\J,KLO)8#@
W[^NR+7]D><<N@E=XDaN4&N2Vb<-9K#3PW4_#&+#/AM2Y=G]=,S-+J?-b5UXfe)2
>82)Eg;VYQ4U)WbR>XW/X8S,dC#A#6_[e[<L;0PJ;fK#<ER5Ue9BdXAA>J:SU#@)
Tg(].d6)>=)\[JAg/F)4bVPacb8,IFL5^I7b5;>dD\X4(J9):W&0f2+EefB(#AXK
gIdLda]</8;_eG;][9g.H42(ab@b+aRNd7Xf^eRWATBO>H#^@2#77C:+^/=CP@cY
Z2J/MW7R[X8E6LRN<Y>f89[dU&K_^;9C<[,R&a.g>AcZ[d4(U9NU#F@>&2C5(D77
HgNYA7F8JD]@<;DB0\C,X]RZb@<faBC2a\?^A/R[:D2.aZ/J1_;eQ-O^<BdQfKNf
=G:U0]dYb,^0Q5:OZ@<U+dQT(>g.YcS[TSK6]06Ib6f-Sg8^fd8P26-TQ)7^MC=P
CAd.c<(U/cE4S&[Q;]A;WJQQ[LQRf=Y[\(FMJe7T4G\?Q;&.-e#ZAWccXD@X/49/
<,fH6KC+BI]f8Fb1)8_gH=]ca4=IZ&.<b;?4dBg?7dNc12\[PHBD8g<9c0ZUX1Me
Q9UVX#2E5&dZ,,U.03dH=]+Qd03^#+9?WI>_daC,J:_;S?72Q=N8A\?dPC6;U6DX
?4ZY+L<+[:S]N3M\9eD3UWQ-XG<IUMY,2b&a,)0F^B_2VTLBTCdGG?2^-87a<ZB]
D;T;^:-F789SWM<Q\BN#?bB(J=J9PG[T&&T8O_E0Q/1fE_H-W^Q^/9-CU#FZHD^S
P:V5OaddL.C7<@[=RG#2H[Z[TXeVAE5-,T:5XH_]-2?/-_>EE3b;E>Q2ca38B=+5
dGW.Ga+NU<X0b43))ebT[[cD^BP41JM+FF#XPDAdBf1CRQ-#Y:I&]Z]9Ce.@4P6c
[].-)fVATZC=:g40]L]WaW)8=FI^@724::<>F=JA0-]bND]1<_RbAUEZMW3[dBE9
EH(>ZA@JMGU.<73:8\OENVdKeV6bG^7G3Tb#4H\>Aa(;]SU4=@_9MVB?<\#(;-5H
U[-0\I5\QO-dDFF8_V0G,(=0C(6HS0V#9BMbaTgY5=_IeY/a^U4Zg=&:8I_4WXP,
H?gM);?Q6)?8KAgbE,>^;cD^NH@fDU4:DDM),AR]35Bb-,5J1H33eIYR\[1WD;>:
7SdGKJD-;LN1N]R=5L)&4W-EcZNP@bXEHS6Ma,XG94:X&H_<JT6),BUd)Xb(\ZK=
I))+H=K9eQLe909HR#U59-\QX(JU&P\[/3b6f45<@Y/,RT1g3B8R(K+2gHgOD?4f
I0AOUWBHY,]d9,gO(ME^KFTBb0VT&J8XPT,7LgO)a##4gHc;>,:5f@6Y2#.ZJUPH
3aV1/ag=#WQ5Zg]QS[&S87^;@PWQDLCgf(F.f.b]-cR1dRNQG>BF_V#_ITdEWbS4
,GL)X]4.ea5[KN7J,1-K(VLYR2>LP;/,^6HbA(NCcRV05U5LLWZbAMS)?;=\=@7,
#D4OO3#\dc/7_dH1^XSA4DF:,OcSH(d::IS=dG]0OIRH+@#eL+W3CI0dIJ:8E1<X
[cg&S7TV>VHf&C0\+E+4;IDeF]d)WTc^8_D9W(aZ.>@LI182[f-)0Q_ZXD#3\4SW
2(XdF2_&\f[&3K6F[BKL,57?-/MX[-L50R&\<>3-)T5A&7a3.:/=IMC9D(E+=G(D
2DF(]WVOVI)=HM0XH9)I[\_3+JCE^>:XfgB(aO_W&-GgW-BC:]=bbfH37R0A,-:T
EFdE44G9CO4[U<2_?We]=ZNH+JC,_RJDYbZXH.5_-C+TeQ_9G,TI]A#28G)^UA)c
fHRW(KBM15[/<:bgS^X^-(1@EHP0(=-1ZWFJ501X(,BP,XT+J]#dBIZDf;IHME6C
<7PW2)-\6_1f@C>fC>+EZ):[e>38Rc1IgRM@B[Y??e75;U\26XK0>HI[#:K3e/CO
3XF?;8e]a6;2Hf6L_=e^fRWJF^Nc],/_FH2TaY:c1b[WUfCDM\LLG+=,EN_YA.]_
XJHfMTCf\E6,7IFC-AgM?/)W@51300/G.IgZ+aW:\&XJX.T/8G.IX(SIG+V+-(G_
F<-FGZ]SEMK@A=f;Y-B7Ib4])14=[;G;S=OA,BYe>S2;,SUN[ABe\4DN?A1cIWV7
.V5^VCUIC<UJP>3U8MbLcE>&A,GJ8HJS6]/Ca?,?CY;16dJ&0XZM1P@[6gX3_)ac
7819BQ?Q4EWJ0^gJdf6OQL\;gV3+-Xb0Y(a[TSE4]7SFQL?R@Z/IcO)RKe#FT8[6
f(>F6]@0:;;22d>J7H?1QC7<[cYWAP3L&R0f-A0X@g81O^U8G<UKbJb?1^H#eS1]
62K22_YgP3eF49S?[P2N\g1,^33&2WREe?24+,XJaF(-6?BLB:FHKLIR7eeA9^)W
-8_7V3FJW]H;A4WN8C#Lb]D5[eAG#UGCO_E7B)5VU7B].NbATN3DUB=P=7VJU?R^
RS[U+OC4cZg.#8dA25]<OG^e7:\4gL@9-H6<<<ZS3SKdaea?,O6D@/F#-F+1/@9-
/F=_<H0aG,LO\/2)f917+:3)E&/Ma9Yf_g5b5\Mc8M3D,Fd4V7WNJa.=He6YKTH=
gVRBD^L>TPV,HE+QES7,<YKVWHdSdG5JZPd@\T<RgKWfHFFCD&GXQ/+QEHMHdR)B
1)Qcf>d]_bA<3DT5eB<X@O\>E2@HQ.aM=5dLg>bPfDU_&84A<>DdS?S3&P<O+X-\
<b<8TJ2a33>KT&:4aeLA9cXFDYW#.3):Ec>72_ZLWVLTSMCE_+#KbF3QRUL&a+gT
&PZM=^.b4K+@.E\^-O7(MaKWNddFXcS_N4747CST3=@)/MC/[9OL=^.X,7cg-MR;
Ec\E=_43MAec4+.#)N0V9D&3<C:Z+G(C=HgS89AZ7=B]DG/M9b2/8?BAZg&WegNQ
VcN]aE/SF:7R@c4#8AFWO[L2)<EC8egJ__/1_>F:)+O>/R0/84V[?f24VG.0@;08
U&M?+RN@<^_)LQ#URIG\Z)U.Y[Md8PO[Vd4aC/=?(W8;^5JSTV._&<N<]3Z(=FfI
7Sa7EM:PLGI;#Yg>Qcc_Pb=/(g?d1g13B\ac(AWTG_GCcNYS49DW-J5.=eOOAF),
Q5?@(.gF&J)IZ3+^@KY?OYV&7[^Le@<Z]SaHMO=>3+;&:W-41>3g2WL8-#0F[]f^
P+cEKSM2J?U&aCR3Ra9I]_70FXAGH0\M/)WD3XJ_E7/XY?)(=2,FC4P_>A/-B\B;
feQ<Id9CKGe-c@#2,3DCVHJ[8/e22/.?6cUC._fTF<M5<ET9IZ3]0g0Z_EX?;;H=
VJQ^fDKKGN/709^>?F;M?=^BcVZb/>QL:-7g1V=HVP[5B$
`endprotected

//------------------------------------------------------------------------------
function svt_chi_ic_sn_transaction_memory_sequence::new(string name="svt_chi_ic_sn_transaction_memory_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_transaction_memory_sequence::body();
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});
    
    // Setting is_respsepdata_datasepresp_flow_used.
    // is_respsepdata_datasepresp_flow_used can be set to 1 only if the spec revision is set ISSUE_C or latter
    // RESPSEPDATA is not expected for Ordered Read transactions whose ExpCompAck is set to 0
    // Exclusive reads other than ReadPreferUnique and MakeReadUnique must not use separate Comp and Data response
    `ifdef SVT_CHI_ISSUE_C_ENABLE
     if (req_resp.get_xact_category() == svt_chi_sn_transaction::READ) begin
      case ($urandom_range(1,0))
        0: begin
          req_resp.is_respsepdata_datasepresp_flow_used = 0;
        end
        1: begin
          if((req_resp.is_ordered_read_xact() && req_resp.exp_comp_ack == 0) || req_resp.cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B || 
              (
               req_resp.is_exclusive == 1
              `ifdef SVT_CHI_ISSUE_E_ENABLE
               && (req_resp.xact_type != svt_chi_transaction::MAKEREADUNIQUE && req_resp.xact_type != svt_chi_transaction::READPREFERUNIQUE)
              `endif
              )
            )begin
            req_resp.is_respsepdata_datasepresp_flow_used = 0;
          end
          else begin
            req_resp.is_respsepdata_datasepresp_flow_used = 1;
          end
        end
      endcase
      //Setting respsepdata_policy, applicable only when is_respsepdata_datasepresp_flow_used is set to 1.
      if(req_resp.is_respsepdata_datasepresp_flow_used == 1)begin
        case ($urandom_range(2,0))
          0: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_BEFORE_DATASEPRESP;
          end
          1: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_DURING_DATASEPRESP;
          end
          2: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_AFTER_DATASEPRESP;
          end
        endcase
      end
     end
    `endif

    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)
        
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif       
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             || (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH)
             || (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_ADD)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_CLR)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_EOR)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SET)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SMAX)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SMIN)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_UMAX)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_UMIN)
             `endif                                       
           ) begin
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
             case ($urandom_range(4,0)) 
                0: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                  rsp_mssg_type = "COMP";
                end
                1: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                  rsp_mssg_type = "DBIDRESP";
                end
                2: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                  rsp_mssg_type = "COMPDBIDRESP";
                end
                3: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
                  rsp_mssg_type = "DBIDRESPORD";
                end
                4: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                  rsp_mssg_type = "NOT_PROGRAMMED";
                end
             endcase
           end
           else
           `endif
           begin
              case ($urandom_range(3,0)) 
                0: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                  rsp_mssg_type = "COMP";
                end
                1: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                  rsp_mssg_type = "DBIDRESP";
                end
                2: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                  rsp_mssg_type = "COMPDBIDRESP";
                end
                3: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                  rsp_mssg_type = "NOT_PROGRAMMED";
                end
              endcase
           end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_ADD) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_CLR) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_EOR) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SET) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SMAX) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SMIN) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_UMAX) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_UMIN) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSWAP) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICCOMPARE)
           ) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(4,0)) 
            0: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_WITH_COMPDATA";
            end
            1: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_BEFORE_COMPDATA";
            end
            2: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_AFTER_COMPDATA";
            end             
            3: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESPORD_BEFORE_COMPDATA";
            end
            4: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESPORD_AFTER_COMPDATA";
            end
          endcase
      end
      else
      `endif //issue_e_enable
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_WITH_COMPDATA";
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_BEFORE_COMPDATA";
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_AFTER_COMPDATA";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
   `endif                                       
   `ifdef SVT_CHI_ISSUE_E_ENABLE
    else if (req_resp.xact_type == svt_chi_sn_transaction::MAKEREADUNIQUE) begin
      case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;              
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;              
          rsp_mssg_type = "COMPDATA";
        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase  
    end        
    else if ((req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)&&(req_resp.xact_type == svt_chi_sn_transaction::WRITEEVICTOREVICT)) begin
      case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;              
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;              
          rsp_mssg_type = "COMPDBIDRESP";

        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase  
    end        


    // programming the Final state for MAKEREADUNIQUE transaction
    if(req_resp.xact_type == svt_chi_sn_transaction::MAKEREADUNIQUE) begin
      case ($urandom_range(1,0)) 
        0: begin
          req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
        end
        1: begin
          req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
        end
      endcase
    end
   `endif
       
   if(req_resp.xact_type == svt_chi_sn_transaction::READCLEAN) begin
     case ($urandom_range(1,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::READUNIQUE) begin
     case ($urandom_range(1,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::READSHARED) begin
     case ($urandom_range(3,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
       2: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SD;
       end
       3: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHARED) begin
     case ($urandom_range(2,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       2: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     if(req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
         end
       endcase
     end
     
     `ifdef SVT_CHI_ISSUE_E_ENABLE
     /** Resp field of a Comp and CompDBIDResp response is inapplicable and must be set to zero for WRITEEVICTOREVICT */
     if (req_resp.xact_type == svt_chi_sn_transaction::WRITEEVICTOREVICT) begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
     end    
     else if(req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
         end
       endcase
     end
     `endif

     
     if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHAREDPERSIST) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
       endcase
     end
   `endif

   `ifdef SVT_CHI_ISSUE_D_ENABLE
     if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHAREDPERSISTSEP) begin
       randcase
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end 
       endcase
      
       randcase
        3: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPPERSIST;
        2: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP_PERSIST;
        1: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_PERSIST_COMP;
      endcase
     end
   `endif

    // Control to generate directed retry response
    if (enable_retry) begin
      req_resp.IS_RETRY_wt = is_retry_zero_val_weight;
      if ((req_resp.is_dyn_p_crd == 1) &&
          (req_resp.enable_interleave == 0) &&
          (req_resp.cfg.rsp_flit_reordering_depth == 1)) begin
        bit is_retry_resp = $urandom_range(1,0);

        if(enable_outstanding_retry)
          is_retry_resp = 1;

        if (is_retry_resp) begin
          req_resp.is_p_crd_grant_before_retry_ack = $urandom_range(1,0);

          if(enable_outstanding_retry) begin
            send_random_response = 0;
            req_resp.is_p_crd_grant_before_retry_ack = 0;
            req_resp.req_to_retryack_flit_delay = 0;
            req_resp.req_to_pcreditgrant_flit_delay = 0;
            req_resp.retryack_to_pcreditgrant_flit_delay = 10000;
          end

          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_RETRYACK;
          rsp_mssg_type = "RETRYACK";
`ifdef SVT_CHI_ISSUE_B_ENABLE
          if (req_resp.cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A) begin
            req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(3,0));
          end
          else if (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) begin
            req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(15,0));
          end
`else          
          req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(3,0));
`endif          
          `svt_xvm_debug("body_retry_resp", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending with %0s response with p_crd_type %0s, is_p_crd_grant_before_retry_ack = %0b enable_outstanding_retry = %d  req_resp.req_to_retryack_flit_delay = %0d req_resp.req_to_pcreditgrant_flit_delay=%d ",rsp_mssg_type, req_resp.p_crd_type.name(), req_resp.is_p_crd_grant_before_retry_ack,enable_outstanding_retry,req_resp.req_to_retryack_flit_delay,req_resp.req_to_pcreditgrant_flit_delay)});
        end
      end // if ((req_resp.is_dyn_p_crd == 1) &&...
    end

    $cast(req,req_resp);

    /**
     * send to driver
     */
    
    if (send_random_response == 0) begin
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        create_and_set_random_values_in_cbusy_fields(req);
      `endif
      `svt_xvm_send(req);
    end
    else begin
      `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                             if (enable_retry == 0)
                             {
                                 is_retry == 0;
                             }
                            }
                           );
    end

    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_suspend_response_sequence::new(string name="svt_chi_ic_sn_suspend_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});
    if(req_resp.is_suspend_response_supported()) begin
      total_req_received++;
    end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)

        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif       
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
             case ($urandom_range(4,0)) 
               0: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                 rsp_mssg_type = "COMP";
               end
               1: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                 rsp_mssg_type = "DBIDRESP";
               end
               2: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                 rsp_mssg_type = "COMPDBIDRESP";
               end
               3: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
                 rsp_mssg_type = "DBIDRESPORD";
               end
               4: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                 rsp_mssg_type = "NOT_PROGRAMMED";
               end
             endcase
           end
           else
           `endif
           begin
             case ($urandom_range(3,0)) 
               0: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                 rsp_mssg_type = "COMP";
               end
               1: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                 rsp_mssg_type = "DBIDRESP";
               end
               2: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                 rsp_mssg_type = "COMPDBIDRESP";
               end
               3: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                 rsp_mssg_type = "NOT_PROGRAMMED";
               end
             endcase
           end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end else if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

   if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
    if(req.is_dvm_sync() == 1) begin
       `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});          
       req.suspend_response = 1'b1;    
       resume_transaction(req);           
     end
   end
   else begin

     if (
          req_resp.is_suspend_response_supported() &&
          (
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
           `ifdef SVT_CHI_ISSUE_E_ENABLE
            (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
           `endif
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
          )
        ) begin
       if (total_req_received == 1) begin
         `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
         req.suspend_response = 1'b1;
         resume_transaction(req);
       end
     end

     if (total_req_received == 5) begin
       fork 
         begin
           virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
           repeat(10000) @(ic_rn_vif.sn_cb);
           resume_response_for_first_xact = 1;
         end
       join_none
     end    
   end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      if(ic_sn_xact.is_dvm_sync() == 1) begin
        wait (ic_sn_xact.data_status == svt_chi_transaction::ACCEPT);
        #10000ns;
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end else begin
        wait (resume_response_for_first_xact == 1);
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end
    end
  join_none
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::new(string name="svt_chi_ic_sn_suspend_response_resume_after_delay_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});
    total_req_received++;
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)

        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif                
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)  begin
         case ($urandom_range(4,0)) 
           0: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
             rsp_mssg_type = "COMP";
           end
           1: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
             rsp_mssg_type = "DBIDRESP";
           end
           2: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
             rsp_mssg_type = "COMPDBIDRESP";
           end
           3: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
             rsp_mssg_type = "DBIDRESPORD";
           end
           4: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
             rsp_mssg_type = "NOT_PROGRAMMED";
           end
         endcase
       end
       else
      `endif
       begin
         case ($urandom_range(3,0)) 
           0: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
             rsp_mssg_type = "COMP";
           end
           1: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
             rsp_mssg_type = "DBIDRESP";
           end
           2: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
             rsp_mssg_type = "COMPDBIDRESP";
           end
           3: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
             rsp_mssg_type = "NOT_PROGRAMMED";
           end
         endcase
       end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end else if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

  if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
      req.suspend_response = 1'b1;
      resume_transaction(req);
   end
   else begin

     if (
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
          `ifdef SVT_CHI_ISSUE_E_ENABLE
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
          `endif
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
        ) begin
       if (total_req_received == 1) begin
         `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
         req.suspend_response = 1'b1;
         resume_transaction(req);
       end
     end

     if (total_req_received == 5) begin
       fork 
         begin
           virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
           repeat(1000) @(ic_rn_vif.sn_cb);
           resume_response_for_first_xact = 1;
         end
       join_none
     end    
   end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      if(ic_sn_xact.xact_type == svt_chi_transaction::DVMOP)
        wait (ic_sn_xact.data_status == svt_chi_transaction::ACCEPT);
      #20000ns;
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
      /*end else begin
        wait (resume_response_for_first_xact == 1);
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end*/
    end
  join_none
endtask


//------------------------------------------------------------------------------
function svt_chi_ic_sn_read_data_interleave_response_sequence::new(string name="svt_chi_ic_sn_read_data_interleave_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_read_data_interleave_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});
    if ((req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) ||
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY)
         || (req_resp.is_atomicop_xact() == 1)
       `endif    
       `ifdef SVT_CHI_ISSUE_E_ENABLE
         || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE)
       `endif    
       ) begin 
      total_req_received++;
    end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP 
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      rsp_mssg_type = "COMPDATA";
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)
        
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif                
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
        case ($urandom_range(3,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
            rsp_mssg_type = "DBIDRESPORD";
          end
          3: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      else
      `endif
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE    
      else if (req_resp.is_atomicop_xact() == 1 && req_resp.atomic_transaction_type == svt_chi_transaction::STORE) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
           case ($urandom_range(3,0)) 
             0: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
               rsp_mssg_type = "COMP";
             end
             1: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
               rsp_mssg_type = "DBIDRESP";
             end
             2: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
               rsp_mssg_type = "DBIDRESPORD";
             end
             3: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
               rsp_mssg_type = "COMPDBIDRESP";
            end 
          endcase
        end
        else
        `endif
        begin
          case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end 
          endcase
        end
        req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      end else if(req_resp.is_atomicop_xact() == 1) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin 
            case ($urandom_range(4,0)) 
              0: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
              end
              1: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
              end
              2: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
              end
              3: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
              end
              4: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
              end
            endcase
          end
          else
        `endif
          begin
          case ($urandom_range(2,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          endcase
        end
      end
    `endif    
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

    if ((req.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) ||
       `endif
          (req.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
          (req.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
          `ifdef SVT_CHI_ISSUE_B_ENABLE
            || (req.is_atomicop_xact() == 1)
          `endif
       ) begin
      if (
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
           `endif
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
           `ifdef SVT_CHI_ISSUE_B_ENABLE    
            || (req.is_atomicop_xact() == 1 && req.atomic_transaction_type != svt_chi_transaction::STORE &&
                ((req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA)
                 `ifdef SVT_CHI_ISSUE_E_ENABLE
                  ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA)
                 `endif
                )
               )
           `endif    
         ) begin
        if (total_req_received < 11) begin
          `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
          req.suspend_response = 1'b1;
          // Enable read data interleaving for suspended transactions.
          if(req.order_type == svt_chi_transaction::NO_ORDERING_REQUIRED)
            req.enable_interleave = 1'b1;
          resume_transaction(req);
        end
      end
      req.xact_rsp_msg_type.rand_mode(0);
      req.order_type.rand_mode(0);

      if (total_req_received == 10) begin
        fork 
          begin
            virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
            repeat(10) @(ic_rn_vif.sn_cb);
            resume_response_for_first_xact = 1;
          end
        join_none
      end    
    end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                            }
                           );
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_read_data_interleave_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      wait (resume_response_for_first_xact == 1);
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
    end
  join_none
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_reordering_response_sequence::new(string name="svt_chi_ic_sn_reordering_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_reordering_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});
    if ((req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
        ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
        ((req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif         
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         ||    
         (req_resp.is_atomicop_xact() == 1)
       `endif    
       ) begin 
          total_req_received++;
     end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      rsp_mssg_type = "COMPDATA";
      req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif   
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
        case ($urandom_range(3,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
          3: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
            rsp_mssg_type = "DBIDRESPORD";
          end
        endcase
      end
      else
      `endif
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE    
      else if (req_resp.is_atomicop_xact() == 1 && req_resp.atomic_transaction_type == svt_chi_transaction::STORE) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(3,0)) 
            0: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
              rsp_mssg_type = "COMP";
            end
            1: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
              rsp_mssg_type = "DBIDRESP";
            end
            2: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
              rsp_mssg_type = "COMPDBIDRESP";
            end 
            3: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
              rsp_mssg_type = "DBIDRESPORD";
            end
          endcase
        end
        else
        `endif
        begin
        case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
          rsp_mssg_type = "DBIDRESP";
        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
          rsp_mssg_type = "COMPDBIDRESP";
        end 
        endcase
        end
        req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      end else if(req_resp.is_atomicop_xact() == 1) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(4,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          3: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
          end
          4: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
          end
          endcase
        end
        else
        `endif
        begin
          case ($urandom_range(3,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          endcase
       end
      end
    `endif    
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

  if ((req.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) ||
       `endif
        (req.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
        (req.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
        `ifdef SVT_CHI_ISSUE_B_ENABLE
          || (req.is_atomicop_xact() == 1)
        `endif
     ) begin 
    if (
         (req.xact_rsp_msg_type != svt_chi_sn_transaction::RSP_MSG_COMP) &&
         (req.xact_rsp_msg_type != svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP)
        `ifdef SVT_CHI_ISSUE_B_ENABLE
         && (req.is_atomicop_xact() == 0 || req.atomic_transaction_type == svt_chi_sn_transaction::STORE ||
             (req.atomic_compdata_order_policy != svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA 
             `ifdef SVT_CHI_ISSUE_E_ENABLE
               && req.atomic_compdata_order_policy != svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA
             `endif 
             )
            )
        `endif
       ) begin
      if (total_req_received < 11) begin
        req.suspend_response = 1'b1;
        resume_transaction(req);
      end
    end
    req.xact_rsp_msg_type.rand_mode(0);

    if (total_req_received == 10) begin
      fork 
        begin
          virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
          repeat(10) @(ic_rn_vif.sn_cb);
          resume_response_for_first_xact = 1;
        end
      join_none
    end    
  end
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                            }
                           );
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_reordering_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      wait (resume_response_for_first_xact == 1);
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
    end
  join_none
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence::new(string name="svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  


  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

    if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

   if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
     if(req.is_dvm_sync() == 0)begin
       req.suspend_response = 1'b1;
       dvm_reqs_received.push_back(req);
       total_dvm_txns_recieved++;
       if(total_dvm_txns_recieved == 256)begin
         foreach(dvm_reqs_received[i])begin
           dvm_reqs_received[i].suspend_response = 0;
         end 
         total_dvm_txns_recieved=0;
       end        
     end
     else if(req.is_dvm_sync() == 1)begin
       #10000ns;
       dvm_reqs_received.delete();
     end        
   end

    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask


`endif // GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
