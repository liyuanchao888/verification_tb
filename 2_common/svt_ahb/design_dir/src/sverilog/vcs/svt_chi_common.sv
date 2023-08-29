//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_COMMON_SV
`define GUARD_SVT_CHI_COMMON_SV

/** @cond PRIVATE */
`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
// =============================================================================
/**
 * Base class for all common files for the AMBA CHI VIP.
 */
class svt_chi_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
`protected
>>.GS/a13[)gIM:SZYVRK1T(=6HH-eO_\3=#46+a[d/-VLg9]-Nf)),BF2]/<[f[
#d.GW?4;C?Gg,$
`endprotected

  
  /** Event triggered when input signals are sampled */
  protected event is_sampled;

  /** Configuration of this node */
  svt_chi_node_configuration cfg;

  /** Indicates if reset is in progress */
  bit is_reset = 1;


`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;
`else       
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;
`endif

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param xactor transactor instance
   */
  extern function new(svt_chi_node_configuration cfg,svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param reporter UVM Report Object associated with this compnent
   */
  extern function new(svt_chi_node_configuration cfg,`SVT_XVM(report_object) reporter);
`endif

  /** Waits for link layer to be in active state while reset is also not active */
  extern virtual task wait_for_link_active_state();
  
  /** Constructs a "friendly" name for an XML file. */
  extern virtual function string create_xml_name( string xml_name );
  
endclass

// =============================================================================
`protected
<.2HG_QN_V>6>)I9=bEY-HdJ5_C)Agb-#A+cdG^#-;T[)=C4P4X6().fDdfCbUF?
2NGE@Yc2[+TL8]bgQSGf=:NeaOYd4Z8NNL33W\?,bJC9LZdV#8GHfLcN3Ld3/DF;
g_D8;gacG.cK]R;>5JT0RL;A)S@?V/8fFg;AV@9[F8&7TKEQ<PHf82BV@e^RW<\4
&+1HZ9\&:XTPHb>LK#\\4fe=_SQA#T\aV&WB-7<X(fIc5>-]JL2FDABQL&Vb:C(d
UNdOV2f&Kg_/6NZYH34O.RgMHRV=.VS_]>G8DU&JU]]QbO=[Z\Aa_^.UJ)G-3QI+
1@g/f(ZYBVHV7DVWcFMaT-G(L0KRHFcV;R3=TRKE9CDE^]==N4-=I8K\+/IJ,FK#
6;D#W<W8[Yf#VgF<gTP:JWFD8AF;&DKf4952P:1QE,U=a\0IB573AD@F<5TA6&^b
)UY=E<WS6[(4;T1:P47#2J/O3G:B+RL;JMeD_M/;;Oe4EdU;(N,Fc034W0BbbVUB
=L+D6e#B#EH=dBY4/L-ZFe7E(JEef>JOaKCbDJc=9HT?-1>_@V\]CT8@H+1Wb80Y
)ZUc]M-?LUDK8fV&Q]1=FeL64A@?K0A:9OgM8ML8YI3bG6?5[ZB>9;4[/:+7e8f&
6#:If?A6LOWK-$
`endprotected


//vcs_lic_vip_protect
  `protected
D^PH)7GOB]DW074N9/F6>2&1e<G67Z1;?X.9Q3[XHIPTW(P@\45I-(]9I<dWZI-Y
MV7_,Z3a.e\WX/4,fM61[:<PWXT?B]FJ70[H@&=&A3b]S]C@)+8WO5&0P/9U@_.?
PDA?7[7F[YP1Z^<71W+35Q.P:L8]7W5/W[&R#Z\J1a]CZ85gONO/aJ&N+LD8+8LH
TW.OB@>,D?D\1Q67JDQ][4==ZgTRS2::12d:5NEU@2@8A,<EZbeg[+c.IWV.MW\K
T7AP_@Ke\b]M/276eMG-1aXRH;:g:0S6M,/JgCJ+Y[(HYS,MV6/2\C=T=K0=DQeW
Hcb3#Rc/,fMg<P@+>bP21^W&:_7,&NbM8(]O<VEIb^F3?;3729)-g7RI0XdF,R\S
-+=\G>O/0X>BOG2aLRG<ELSeb]FN[L61T^MIX0S1A&7DR2g-M.7eeS.@/S>P>9#T
0Z1(U_H[U^&?dNW>_U>/GY=D-Z?Pf_?RQ+6Q@a-8GVYE2<?2>P;Q;^F,<.3P6T_K
2TB1:D2H,85G9U-Y=4,=C\6.I^W&<F+AJKHP<PXbBa5<g(GK3J5]I_a[0VHf7cIQ
ed4+<MMWd.Vd8^&g_UV78)-aG;YX5L=R_\Y?TM1:7.4:O7CC/ccBM]dNP?;_,-:Y
Y\gDb2IWd2WEEQWT8B+)=:);^.-+D1;G/)5-g@T)@=)]>4d:8\]JTbMQFR^F=U([
a<J95_JgcHc#bV^1(O8gg856^CG^4/MVH3?3bVc6176MZ<SQQLOO5E?1V8=W?+1)
37Y&<&aXON<#/$
`endprotected


`endif // GUARD_SVT_CHI_COMMON_SV
