//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef SVT_CHI_IC_RN_TRANSACTION_SV
`define SVT_CHI_IC_RN_TRANSACTION_SV

/** @cond PRIVATE */
/**
 * svt_chi_ic_rn_transaction class is used by the RN ports of the
 * Interconnect component, to represent the transaction sent on the
 * Interconnect RN port to an SN component. At the end of each
 * transaction on the Interconnect RN port, the port monitor within the
 * Interconnect RN port provides object of type svt_chi_ic_rn_transaction
 * from its analysis port, in active and passive mode.
 */
class svt_chi_ic_rn_transaction extends svt_chi_rn_transaction;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_ic_rn_transaction)
  `endif


/**
Utility methods definition of svt_chi_ic_rn_transaction class
*/


//vcs_vip_protect
`protected
X?F[C]9a,H^J5^1L?0W[:I4^F,^N,HQXS[+&D3>LM@DP?/EX7?\+)(<2N]CaQQd,
J=;Eee0c8Q?DXK5fc#I)L:[PS@2BOI9K.9WKYO9/VfK6@><:])2Q2N^)b1,/Q[Z.
)Ib=H.KYT<Bd2a/#YXb4.^NCH9Y\TN[8a]LHRL4adJX+P[SbbI3eXAQ,SKXBG-.]
^RS&Cf)CeAX6/Ke-gSE;(<KD3C7@@\ORgbFC-D&[e(ZS=(bDd[T618-a<;D2(G;0
6c909/8-d(C7Q?817>I?INeLF.J)4B[[@aFCY#RSPN9N#Q)J1FfNPg7:UeC#[KA9
4EYPW59aD#N3[S:05P;Fe40.AYQR/;?/_e\]Sb-I&UdAJ03E?@cL6a5-+:#NIGg]
d.-bXgg+80D:XHF)bO0WI=cdc(TLSP7W[06Ne]@/VLZ6:?d\IIYP=D?9+SS;]eBb
_Fg@]6WGJ4C&Z10]d2O0IV&DJ7[Y@A)eSVJ9ePgV3:e:_4BCg_)F&Ja8B@4Q;H][
PU]gd4T:H<C8]+,27Y.LTYWF4[S86,(f0S\=KNT2_eBSFF/_RZ(Y5UPIX2)1(G@M
eNR&_\[#[R2?FE:8L@P^Fb0G7fb^OX2<0B7Oe+.0a(QPB9.&^HKR_:;<JQ_W8@CQ
ZA(/9402&6D27]:HH<@30BKY-,R;N7dK64I)7T9,\1[BHbM>48B3a5J8(#Ze1X0C
=7B:LZQEK6KbgMO&33,(RO:gL]U,C)\)8V6(BR8C(ZRV)X<3WAI]N7X&W,^Da.G5
7&]9Tf-ERFXg1;OC<Y7MLbc3(HVfYae,Gb)A8XUASdOHRS0W=K1_.756bD<46FZ8
f<6MWEQ[c1[gB;ADHb==\]c36$
`endprotected



  //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_chi_ic_rn_transaction_inst");
`else
  `svt_vmm_data_new(svt_chi_ic_rn_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
  
  `endif

  `svt_data_member_begin(svt_chi_ic_rn_transaction)
  `svt_data_member_end(svt_chi_ic_rn_transaction)

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging. */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /** Allocates a new object of type svt_chi_ic_rn_transaction. */
  extern virtual function vmm_data do_allocate();

  `vmm_class_factory(svt_chi_ic_rn_transaction);
`endif
endclass
/** @endcond */

`protected
6&0?FP8_N#\Nc^Dc(B]cNJ+=]>[[F?,.MHbIZAKE)E,+A^M-W=b.0)YOUB3Cd=TE
NW_GeEV(<6>(0D@T7WB6Xf2IP0N71c&)<,eG0:,E4?/0TS:gKAV-2CP0\7_(1F;/
(\5/[?EE@J9SBH/K&9M>]Z(c8Nfgb5ceYT+JF\\=T,T4@^F[)gUWL>ZQ^R0J1.b[
dOAX5B15DK.ef0U-?K:=Bd6_5G.^7WEM0MBYN115bH+,bBfIJb,?>2RXa\?V&6FW
1d82Z=0O6_:7;K_,7@ca\d+1+7LNR;S,BTB\RL?If.c(,7a/8#O7O#H6FD_.D<Wg
BZW/@OC=P[#NUcM6>++&JC-NW=;C.C5?HJa+Cf5C8P92P)E(]5T3<25gJ+1bAFZ;
XX&>PNMR5JOdV9?/6W-@JZ-N6$
`endprotected


//vcs_vip_protect
`protected
23KgVEc-5;e69+<XAGWYYb.#,]g[KgFL#N_W@)4DFF;)G1e;8Fg\7(].=e<^EV6c
]VWMIdSXI#/91D6WFc1C^.0G<\-b;c5+617NB4a=eX4LS7G,c)SP?_Ke9bf?<Tg7
XQ#E46EO/Va+>aHKc3a4-:;VZ0,S\G62=TYRZa]6d^>@2XO_SXC;J[(J>MMXYI>=
gY#)H_&@fY#8(T(>A5[dX:CM<9OHSCM=d#_V@9S=(a^U@#Ab&;T#3dW4+TY#I8CT
^Y?RA&<?.B;3e<9HB/JGa2,Ed)[2)7X(MB4>fGgVg97#.Be448W\>-3/8=d-fQ8H
?]>.)F8YJ\DR?J^e5QXcWFUa1DS/Jd+5.>b1R^CaK=-a1He]FC1TR?6P2^Zb[7N5
8VOGS=8-e>Leb79aEQM49Q+N^Y47Lb:HT2V)\B0\g5@8.<O8=(X4)NJ=[,0C\0)N
2)\cEUL+<Q/Tb9UJ&9LFC._@TG6b(LQIXH?f^(5VEW9gX2&CaQa.dd8a6aLM,@HU
;J>d?JQFFd+B2]D]HNVV&1/4cQ)0[@/A<CFP-aJX@-]:M]A_<^;>fQDeBZP0J_Bg
^cA3BKc^,e^CIIe[)5N<=-B,&MCDBUb=7=5P0EZ9PORg@@d,B+Jc_b>Se4Vf3T@4
C]Z7g];R/RM&,U9Wc-MN+QQTSMg-(GE<#8HR]J_4\>3FIMW6[&d-^^1[#F3Y)J8V
7^?Dc[J=H&fF(F\8UG48&eOcb3[M(F,V1FI[(IO=CgY4bf>]=-H+P=_OCA]>B^V8
d3376dfF+K&AJWP>FbU@&RTgD-:FadWcdbMVa@gL7Z\)CBAgM?5Fg-\RF65<?c7-
.1g@b6c9D4.S1?Ya8N22@JLAcY&_S^M-+\#:HQX3Xa-ZT/PY&=PI<KIZYIBO5=ZK
:M0[9@):T7)S,$
`endprotected


`endif // SVT_CHI_IC_RN_TRANSACTION_SV
