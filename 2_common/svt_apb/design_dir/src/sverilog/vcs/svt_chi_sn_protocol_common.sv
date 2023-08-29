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

`ifndef GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV
`define GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Class that accomplishes the bulk of the RX processing for the CHI Protocol layer.
 * It implements the receive logic common to both active and passive modes, and it
 * contains the API needed for the transmit side that is common to both active and 
 * passive modes.
 */
class svt_chi_sn_protocol_common extends svt_chi_protocol_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  /** Typedefs for CHI Protocol signal interfaces */
`ifndef __SVDOC__
  typedef virtual svt_chi_sn_if svt_chi_sn_vif;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** CHI SN Protocol virtual interface */
`ifndef __SVDOC__
  protected svt_chi_sn_vif vif;
`endif

  /**
   * Associated component providing direct access when necessary.
   */
`ifdef SVT_VMM_TECHNOLOGY
  protected svt_xactor sn_proto;
`else
  protected `SVT_XVM(component) sn_proto;
`endif

  /**
   * Callback execution class supporting driver callbacks.
   */
  svt_chi_sn_protocol_cb_exec_common drv_cb_exec;

  /** Buffer for write transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction write_xact_buffer[$];

  /** Buffer for read transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction read_xact_buffer[$];

  /** Buffer for control transactions. Used when num_outstanding_xact is -1 in configuration */
  svt_chi_sn_transaction control_xact_buffer[$];


  /**
   * Next TX observed CHI SN Protocol Transaction. 
   * Updated by the driver in active mode OR the monitor in passive mode
   */
  protected svt_chi_sn_transaction tx_observed_xact = null;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /**
   * Next RX output CHI SN Protocol Transaction.
   */
  local svt_chi_sn_transaction rx_out_xact = null;

  /**
   * Next RX observed CHI SN Protocol Transaction.
   */
  local svt_chi_sn_transaction rx_observed_xact = null;


`ifdef SVT_VMM_TECHNOLOGY
  /** Factory used to create incoming CHI SN Protocol Transaction instances. */
  local svt_chi_sn_transaction xact_factory;
`endif

  //----------------------------------------------------------------------------
  // Public Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param sn_proto Component used for accessing its internal vmm_log messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, svt_xactor sn_proto);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param sn_proto Component used for accessing its internal `SVT_XVM(reporter) messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, `SVT_XVM(component) sn_proto);
`endif

  //----------------------------------------------------------------------------
  /** This method initiates the SN CHI Protocol Transaction recognition. */
  extern virtual task start();

  //----------------------------------------------------------------------------
  /** This method sets the clock period for active SN component */
  extern virtual task set_active_sn_clock_period();

  //----------------------------------------------------------------------------
  /** Used to determine the extended object is a driver or a monitor. */
  extern virtual function bit is_active();
    
  //----------------------------------------------------------------------------
  /** Sets the interface */
`ifndef __SVDOC__
   extern virtual function void set_vif(svt_chi_sn_vif vif);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Set the local CHI Protocol Transaction factory */
  extern function void set_xact_factory(svt_chi_sn_transaction f);
`endif
    
  //----------------------------------------------------------------------------
  /** Create a CHI SN Protocol Transaction object */
  extern function svt_chi_sn_transaction create_transaction();

  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_transaction proxy_create_transaction();
  
  //----------------------------------------------------------------------------
  /** Retrieve the RX outgoing CHI Protocol Transaction. */
  extern virtual task get_rx_out_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the RX observed CHI Protocol Transaction. */
  extern virtual task get_rx_observed_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the TX observed CHI Protocol Transaction. */
  extern virtual task get_tx_observed_xact(ref svt_chi_sn_transaction xact);

  //----------------------------------------------------------------------------
  /** Method to wait for Rx observed transactions: currently applicable only in SN active mode */
  extern virtual task wait_for_req(output svt_chi_transaction xact);
  
  /** This method waits for a clock */
  extern virtual task advance_clock();
  
  //----------------------------------------------------------------------------
  // Local Methods
  //----------------------------------------------------------------------------

  /** Method that invokes transaction start events */
  extern virtual task start_transaction(svt_chi_common_transaction common_xact);

  /** Method that invokes transaction end events */
  extern virtual task complete_transaction(svt_chi_common_transaction common_xact);
    
  /** Method that invokes the transaction_started cb_exec method */
  extern virtual task invoke_transaction_started_cb_exec(svt_chi_common_transaction xact);

  /** Method that invokes the transaction_ended cb_exec method */
  extern virtual task invoke_transaction_ended_cb_exec(svt_chi_common_transaction xact);

  /** Drives debug ports */
  extern virtual task drive_debug_port(svt_chi_common_transaction xact, string vc_id);

endclass

// =============================================================================
`protected
gVHCV8_6J_c57BW2Q)UTUUf<bGEF.]8gXPF57J078(L,:N_1dF_d2)RfS^SR/K@Q
cE[bI,Ndf3Q8DL3;a1Ia#ef[HJEBV+-g\_M=@U(88b[dR^_URM2:<#,[=4aPDdO<
[eMG\_@32.M,/:0PeQdPcRW11W@2[Yg0]]//?Se6(bM0g8<D677^1(Kf>P(>9CZ/
V,\M2W9D)P[LJPKK4XO9CH,3bII=ZF&YFKQEgY(X];53a\;7dYE<5BS=1+e_)<7^
QZJJbKN5<0Ae[?=F6V;d_^f/efCBJ^TgZJ:Z3T,WD]-GV#A+]?81U4Q(&@XKP:IN
Ad(eV)S#5:-R^64HJ_R?_^S_:3NLdV5Y@=.RFYEV+GaNdPD.=?7dY9K[QKGL1)VD
W2HDH#I?Te?OO9N\3^<&TR],b4IKR#YNXFHGO.40OOZWA]?-8_1LOd#_ffXJed@]
5a]?BRNK#c=ZNEL2&&Te2XGU-D\B.SS6FAcCe]<g^eS>^7KfaeMG)-d>O-N+cM58
[Y0A^1AHY)CcGb_1:/^OL2L.S?<K2:0A>g5-VeROAD4V<;9VLRU#)]&c8E-]G9eZ
#O=W7LTN5Y)BUg(#TIR?#Z[eS6b(\)db<$
`endprotected


//vcs_lic_vip_protect
  `protected
50E:8BPdQ2][^G]cHW]WHg;4.UZEgcE.1b;YKL]1)5>VJW>,0FDE.(Y\S=HP],Hb
QMBRSI#d[]Z:/g>7AD.@fQ:QI>M-YWJQ9CD&ZP_VSO?e0ZH1?E@3OXA)7d=]R?PF
4f+;gAG_(92+9a5DN72J2_M\]g5b.b&gPEX6QaTZUN1NZ2Ea+-?M9\dTZ6/+BfH?
Jc#^RJ:.@GdY4^++AB54^K\86IgYPIH9d?da/A7R3F.b<<YR[cKJ=J+VV6Dbe3;M
g47b19NB)_X@]<X3T89,]gH+cY<[[e<c+CZ[cJd6+:GRVE/+M<4d_S;eTC>6AHT)
AMUX(&,MM9EU#L^V[bZ_][d;TDd.P<4>Z0Cc)/W;SR#=4@a[3dKE[>]4A[W_A/6;
5.LN=?OE@f_G]A)WM#PJbJZ3?:8ZfE+68B-TI\UYP>^06C&A)CF(SB+aTZR0a&-c
;/@:@<A8E&86(1e7^_?K@F@Q)&IA@<S,dVS_F-+WDWM]1H6>W85T]:4)YFXSEd+(
3Id#)C6:591)C=]8[M6X.9F1:8g?c-]4:/Y,D:?(N&Ega]J?\eeXTNN/2D3M@ZW^
<Nc2H6T;f<V-#fVPEE=O/-4aMa4-+gId_\5Na;3YC(RT<MdgH]_bK/9-?D)>[IEW
EH;]LDR-ZeE-<@FP;54P@HD(>K?G]MSMOHR>CVReCPJ]WFQ4(c,G)E(S2N?.D79_
[1cY_/9?gW9)MT9Q1S-\:M1af/Gb=]59D[@08c(6g_7SG>)>_cfYb@X]3TA;dLYX
1\<WJ>-[=;Qf<>^R3WNHYVVM^eOA/OV910;DG)K.R]?OHK11N+gbdC7a@RLNVG+X
U<G5+R@QfH#3[],S65]OD(cg>E/^2G:8+Q8a3DN&ZMXW@+(2G@a98A37@]2E-GKX
A8N2R&B1D+T[c9(+DUUbc.G=@I4b](;:AZI?CGI3T#<):9e;)+V@3GFJ+[QdT2&A
)Y[XOA/?GL7VI[>+AWcW=#G?K@EfgYBS8K1(Vb6K;=;QNXBH5290eGL].#@/]D=R
T8EeX>:F_K>B]_H;RVS1E84(0J#/P3NPd.bYWU4A:YB4DX>,^SWRR>6@b4_8&b9D
,3UTC(>-dTaYTVI1O:G=ecUH#b95-[[b\?8&MKC5Ba(^[4YSA@799Y,_(FHP9?/[
WJ@3HG.O6MN>J0BZ_.C.<:3aT1EN_/PF250R:BR0#Y0,N@(4\g-:.XUI4QD380c9
)ZIFEW)V4@D-A]94[#OW#C0:Z@DcEg]7Z#8JX[,AV_@+WI9S\\PL?Q1_MPUDDN^H
M>Y2LHDX8?#cUL^4/U)#)=?\dCE1XSS\K,+JS+GLI[XBS\D6HZ+3E+REQOLC&Z;e
0(+4J;X_OE)-PEO#GO3gD\:AWcKO)<?S:dWeN=D3\cR\-,H;:(b))dP@C,G7aaR_
g48ICdV/dGJEWL>#KDGL6VZ&#fI#R1N2,+7UBGMM]XLH&1fAHGE9gU^[UIKdgE0W
3WQ@8&:RJ3P==>>X=7KdLWNB,R>=d]84B)DD.FDEI(E.HAW.00g\3;d)?3/NP:C?
2=aDQ<1N_-/:0?]@D<_1_H=OB5](d(,W3XGVZK)aDaD^?b:UNG,C8OG7-8?_<HZB
(9:>QHZ.<@:A:L,KQV)5C]R1@]@/,0AO&P9<S=&&OaI,Ra;_V0:8a1#(^)8:-[JB
0gfeOYPZ.V(+/aXP<ZTHK0@J]7\R^1DJ;-HaE#I7Y2:CU=472gcbH.Z6M;_C:,a7
./)6R;#8Q,LVb&DB</QO3(,,>D90XZRe\XW=D/3W(@dI?<TEb^6.]SaG,WFbKD\Y
1IIbGULSf96ZbaN<fe1<KZGE9C8.bH,/VVeBV3^;,21Z@47-5-7bcPd#>N0>)B<0
UDe9]0X>Jg3@^<4F&^Z2Ob_aTN.)79@]IZ4Y0\S1K1K6b64?eEKPaQCTEFHaS660
9-51@Z4PfHF?6T1._2U>b4U?-6eRNA>_32TY5#EZ<<)9c[)\M@Kb]Z4]N-JIOV3:
5OE(/B,7PIPJ@IKL;=FMNDZP8LNZX>)88BPQ5>dDb+)dGdCc]K267)AbTOB]N8R<
VL+?[:19DA[:A8RY[PJI+f2DG(YIUR4:P&FL&>,MB@Y1W7].bd8IN?].3@F2PB2Y
Ff?\HdQf/9Vg(;5C96B-EEX\@^X^V0W0CJB=T0F<2C09c<VSP8>WcZb=/a[GI)/0
Y1Z0L6-ag7.Sb^E36.BRBY&=TgD8JSXHgX7Z>;WEVF3>d8[.JS#O<aHN,,5JbA:b
9K\W,@B_]W?H2G4IOd<bWP8N0D2eU+FV_-<d:<5YTK])Tf0eWNIED<?_7P[63<@Z
T^C<GdBaJ1YF9];NSKW2[BKd9#Fb@6,V@2;VJf>3&,;9c[BJWR>T@C^^Y3N\PD=&
8S++(T=0[>#b;]?P2O^W1K0&P2dI7?S3P//:R1O<cHQ4W,JL^WQ4FaNJ=)&[bVQU
(;L:DC7RW),a>J0<J7_X;^FYK?4PP0=ab6N^gAFQPA6d_a@7M:F==44L@G.EB\VV
Yc_4@4cK>1@Ha,,F1\,=Jf2[^b4cUT;F_&;054Na:3THLB/AK1X,<Ng3\R@WR)fX
HE6&0IB7>BD=a[R)@EB(1^g_3EC8ZD-SY7G4_9]JC:\gBdT9;b&f,b<L5dbBBPQa
H-X+B=b@OZaBa2>#UH5=<H\=W3&FJS<8YDY0@ZHS12VDPOKc#RHdT[LaHO08]gVT
&92/6KM[@:?OUB<(C<L52aE^A-(&(M3bW^[SX>529,J;&B95>VX>/J=64bB+Y_ZR
d;:/R5YeR\D.Gb,bbXW&B?d8=HR3Q>ebc\-BK+-Vf@\7#^2I[GLeg+c1(4&_^3SI
-7Lg&I3G9EP;2&bZKfB3I)_;adD]K4=T6X(&Y;=C8_XLS84U&HIEW(:QXT?X23XJ
afRU?@RZFda_]31?K9e13X]E6+8J#T[0C^eK]2e[QP]@(<L-b5=HS.XM3=\fH#aC
SNcIR.^>a6b@.6Id\bNDJYYdZ4eD\/g7-QFbI45TQ.W<1\.IVM=VSd10(RJQVcS4
W@G0KCTTB8I/bVgB&O\4H\)S0A0I8ZYO+@MVO/.OQE>aWDe;V.IBAbcT=Y3];_J@
/^(\KP+YG>WUdI^<ZB?T+GXI.7G>#)VDK.e=a57JW0gKg&WJK;1[J;BD3X<R3C(:
3X__C@:e>9V>fW-?N,RV>_cTWIcR&8_GVHa,L;X^5g8)WI)QebV^<#LQ4]9@46b8
YS(T[eO&8UR&G6)5BG[6C@?#b9#(^-+[(F)/@4df57KRRXbIgH;.U1:;9R=[J7EX
-]E.[eM?^(+NXF0eA]\RD&d6>V=-I=DA^Abb6,8ce29ZV<2c]:Z_MU+M#\Eb7QJ-
L[(7>E.M?cW)>,Ef8a)@)3Of&>Z<YQ\eQJc#d33X[R+S+5_,?V]8(g5eS<7d2EMd
/LL^<[N/.F@)XX[T>ca.C(;W=J7FM14V4-QTF=B)9TZQ=/IB^9[)J#DZPTU<EVe(
T]F90<bd]V51#fcS6e@_bG_e9bNR[R7fOaSdHf.0b\HG1IVG0[[;>9A;T/cY;ZEA
a\e1:MER>@f=eI\,D\6bN1aeJb5]H]2K(?/BfIP^#X8;]1I#:VNKS.e;T=OG[K.Z
/a/V\O-=E0OT584_\R-E,UBV[JF7[_=1,WMg?a>4[[(P4^4^UJN&1](dF>,G9,IK
1cL-a@YH1ITf;GeN.fKLQSZFcYS,/f2WG7.IGRQgIU=-9d:+B4R-:Fe<2F/&V(@+
1GQU0#\#,X[3M=>R^IS_]T=\JFbXYD6[HHXS(L;\[B@;F-IfFe&T66&W_.f?XY&Y
.0PX7UdQO]Ld+)949UaQ?3W-Z4RD^E)X,=O;_?:38#I6d&Q/V]EE51/M+YP8CR@>
4@?IaW2G30;SF&VR4Q@8Ad3H\/7)GT,0d3_5Q><_N1X@/28]@0>_Z2\U/ROFaZH)
E3;7P#1BE?ZYPBbW/&-fW@gY^6:A-XEF/Nb?e]E:ZQM2-a>S([H-LW7^b[X5NRHQ
UU(;Z\-_XAI\:CL0#8CWB,/XRR(4G62FP#aR;g4_QU+5aSUEfX#H\Z3MV5M:Nd@F
)]B=3]I;)\(?3Q._:b7,W^9\<LS(D/JXZOP]<X,c)/EXMe>,.cE3#3W1db\]@\(d
gUDA=b4;CTW_-I<eYH?X_CgO]J>X0E1;FQ\7.-d:(cJ_6<3c5^X2^H2Y+g,F]5cb
5fcH(P9J)KB.80TaZNQ22g\d_04?IHO7/gKP_&KP<F)8+gXRaIDC?#4Z78a1@.KX
3MDB@C__2GPW08V@[^/D8(U/-@SJ+a/)eBG<;4O20g?,([\.[d)Sf8MQ>0)-Q)Z[
^<0)KBc9YD/=d-dV?@2M,.65[RU4?26[aM?dea.#NdY[BKO8:=R7Q\C_C.302efD
b@_^HW[ac_)a41=)#=9(VEDD(Z]21IT7H)=e]3>Df[YGLYLP-Ad5]_YFO/1ZN]_7
c[B/F?;RO2a_H8#BR/g7VadW[cH6#QTg@/3J\f4fGUJCBH0AdE8[@7QGLQD2gW5D
5]S5X2AY??<a-:26c;gCZ\VEGf0/HP-_77[EV=cYTLa8_f7.L>YR0)[6e,52DI:@
Y)AEdO;aI<L+8D\,F#0P&2UZ..CQe+0[8S-S#,0b^:I0+(LB4eLLFWALS\OCLZ2^
LVa0X[EI<--]@\SgF]A?@OLB.4BR.c+9bK7BW1IOE0,U3XeW1A-[S9R7T5#A#/8#
T4g\;^EL5578_BS?29K,GYASSI99,OZYJg8e=BT<\Y+V_N;eNFIMd/Ac]:cI-:cH
VQO/POcaeD/c-c_8HfaGdH?V<d:Je-b+3_T;gNG2LNd/^XC_ZOA4K9+]S[c7Q>17
>;QTE2M2[K#^\],^T^5EN<1O_BP@\XSg][dD@450Q>3XHdA6,X56YX@/UY9^XaUd
GQBMNRE:UYR6)S7D^>Q-VOS\+1N4:;>UNDU,X71.GVXQJacF]^:/cXee4<g1JRM[
O]d9KP.RSMW@KN+=:M>[DT#4N#<9I0-UZ8bX?/M=S-Y@Vf[_5bJGM&Q69c6QV54H
8;P.T@]8Sg<RU<D]V4eS4cQ@4B\0)9C-_\1.8XLY,69V,_gYHQ(d(R4B1XX]NA<8
[\-Eg4V)S/U/(KVRdeN<K<NS72Za;[_W)TQ,[A#Z,bf?Y1HQ0?24911BE@[_/X)W
AO]?bdIQ.<10U:]ZbG1a\DIL7WX2C0[C#MR-B:^d31cgCAG?MIL,\#,:754>&cP#
0;LOU;=@GWJbYN4b5c79F29+HaX5gNg&EKB:Bf&^EWcYfK\WTY?T^dKC=A;4LI:?
;/3[S;IGOY7BGS?f3[;66ICK9KSVX?]]9W309IK>C5USOFB-[9J52Jf+;2MJ5Me3
G[=1d:Z/QSI?0a-R_\A]Ff343-;Pf7&]5e]GXD?SV<GZ:-0\8UPC<g0TJfEB\:RM
9JL655VHC\gO0#gA>0=6DNg75?^c)P;D_.8.YK3.6eJ<-/=DEG.E9;([[#7_<0R,
IICNBN03S[Qf78[<JJZa40c)M9<?79TWZ^-4-,fBJ0(aBYU/ZHJG5<K8PM]^8Rd/
gO.D;&2dQ>7?X7W,UFg48<V2[Og@>E?fagA?Y8b8U\6-[>MGbT9B<R<A&f4QV<.S
(GQ:.UQ/P:GM6gd,PE)A.X@Z-^B-ON3dP>8R<,H(=2a0J/EX:7QP+DOR_c-EJOF^
@1\^/.3B5aEZ^&+Z?I+1KZ7;fN=Qg=\41VM0K<S0gOf7(@?^;V:\a23Mf;C_:9KI
NIF9D/+GVAV57U4IXVaQTZ;^#ER?eBIQ_>;FGa.C-D)\93J+WGP?Y;A71C8YW3].
eT7_-;>g_aP\<W=]=]&++([Mc39@PP/eW[(3QH_ZQ_Kc8H63/=053K7SaCE9W]Pd
5F@I:\>R,cU0TWI/XFN3^8^FN)7EY22-O63#OCVF-X)Y_cW#O>(WUVN@;W(@KbVJ
8CEVVDLdA\6?[QK1[_CUUeLQ@^^,dfdH.VA+9Bfgg-;f?QG8N.E[g/I>NA+@&Od)
<BW7c1X]\M9Ma/+8WGR2bXALYCKfD-E^3HX,2(=>KN/PNK?gJZ)G:]C0a^,<8^/3
e=I>]>O.P+VNdRA:B7e&]\:R#a-CRS3&0;WD9_F84e[(5@gA]5^>A?R?I^25fY?]
?LS_VQKP[\PI6Z)]VLSUF2G3f??7]4?).^+JL_?1Bc+LXL@6T^dZ9===@H\@0NHA
_Z8#B0g/E4aa6f3ZG+03Ta]H<OL^R(##RER^5:;BK5FTAI74-I(+7>_Q/H?_Z6O=
S)E(b^&LVfa&F62^;YA#_7[T@<d0FES6@:g9T?2cd/?C@B1f/:Y/3A#PJHSFF=GI
+>2BX>B4(,g)>7d2&e2b)bYLV1fG]-D-F1H4,cgPb[d,UH;=^0HTM375E7YE.5_g
AT]f4F+YdU@Z(VUD_6FFMB=WN?EabJ4,b)UGL7J[C.\^K9,)[ZANe@POg.-NU^dM
VE5-T;=A&5XK.>P&g>E-a,285V1ZX0W@8/=?7MQGcZF?9cNORM)5I]J,EYbJZAdL
P=,:3b1-c/>f(VdGUBID4ge5YQ@-1<b2RWc0Z1LGB7ZJ@J70H_=gND),H>))2)/P
\I+VF?MgR8,=[F)Ze)Q6-E3WKR3&J;^(bA=GONHT+B,c(>9+-JL/SAf-EZ:?D^&R
T\->1a,8b[L6](X:1XCf8@^eHS35a+W+6Q?^GNBZT-cgZIRaDP8M-2>;^3Y8N)^F
\JNU=GJ8:]fc@#P<f/,&;b^#3G/9;M)@^Y:Fd;EE6F)WYZDScO/PG,&V4/X<^:.#
,=EK@<)T>T5LC2;(-06G+1BZR(,eVeWC-#60J?Me_A#-[?+CA&D(@KFZ(/Cc\I=Y
N(]93ZTC<LQg(+PB5eBKEJ(a7NZRRX+IgDMXg^@O#6&#>\^/N8F0KX.#\RYID<]Z
I&]I@S:X5CS?c#86X-^E+RCbIQdTH32?<PIIE42\NS(9NgH1B9E;D/OGd;\cV^^B
db0(SS+@]C,b_P..]=Gdg62JAeJBA;2PGV841<B?ANdQbK,[Wed)ZLBJ;.84Y_aK
7RK&6(]MTH4+_ZOWW..8)<-DVR(S55.L;e#<b.FH5HQWge>-UK,e-Rd;c<NPZ,>L
VY(FT:bK;Z[3&5eK4T_LH=8RH=Eff&+64bFVI87#7XJE\)Xf0,D&;-6eLOLLP6f5
;=P9;C6N(eM._]dTX\E7Ubd,+Ie;Nd,?3EdV/c3I7,@0G/E)1W)F1Z#Xa,8NDP^3
H10;HXFN0HIdeP575UFY;#a#^X]0UL0b>5/9P:EG&Eaf78&c\M9,N27O3,(7CBG[
DBa8g)<,/M30d;W?9B[5OT5G&QeRS0\\\)35^1T&LW[J(fKaG(8OHb_L=QP_V@UR
8\(G)<[a3d_EaMI2J;2/d[[VDU\02a//GZPV5,CNZTG<7RDa?2\S2WCEKc79;WB:
,--RWJUC9b8)_3=BLG5b1YMN1.3N4[IW,AC1&9[g\#VQA^=XJH??HZ+E4/<<YK;D
<4bD@K-Q9.BMNXSbR=R[VU=>101GW),GG/&)NSW5ABI<LS[P:K-c^,/GT?JWN1:(
QN5bB+dH5D=UNS@8S<\PAgOR,2e])WfHH,5K8-R)Jf)4XdI;_3@FC=M=\K#Ld\Cf
e<IU^YTg)R06\f31VD4;]<E1gKKT0_f9U=d=3EKXBPa(b&N,K]cQ:FNJT\5NV>Cc
I[^--_<,cK5LV[c]ZA^S7dY;FKPbJRPR+L2U0L0.E((,AUL<@R2>(XcU<I(GOUGB
&P4;f@JMeMaY-X&.1B?:^YQS/ZSSDf/M]G,W@B0VX<^:\4&=#8OJ6-:\.f<B\]_O
L@<aU.BSMB#4+6)))EHW)94@e&T4=F1DY9TYXP[_:1IJ<4H6_O;\Tc]-P_O1RD;C
KD>^9N?\#=fEUH>NbJ=Z21M+3Fb4+5;V(Fd7fg)YaO8=Q/BJ4Z3XIU-ZTYHR_@X(
I)c<]QABO^-T[/Y/:[2B5S@?8[&Q2VTU:X_>#L6R13T6_K9N)ZU5[_729U)+D>;Q
V?\d49WVEdI3))C\0&e=,DeG3)NE,>XKKgHVLK8d5FX4HD<a,E@.5(LSZ2/FW,aV
)Y<E8V3YTSJ/Z8f@?bA80-=2Ec<[&KY2&.VeL4gZ4J2SS.1P\H+5OYU(8?:MB9Pf
V<70)A3.MTG83EPf]A,,?M@-A19fPEb)bOe(+H#-d(Z^/I[9?R].N2XGFHF4;TQ]
:G2YF-9@GQ535Wb-(FU_62UaN(X(7Y8J7]=/UOUZXX.PN\I)Z1NUAR&R+15-2_G2
ZKc04_JE7KVAG0c)#.G,]\ECQK;a)Y?.c<9LRgL)I14+-LSE;F;4T2(P_A-_e9[7
LGaX5M,.,ZGW00(ML74Zgb_2-7@K:Y&>W3/SUHP439W-BU7;YeX-.O?^7??5():N
e@W7O.X6CVG&F)9@)@N=S:SX)(E5.(3X0,[SY=QFbGfaGMbMR.-7KML;a^bG-B4D
a^PER1_4Fb8F_BHU&HAHgK+=#Z\9LP:<WJ)_\0A1+)<=>WEHgg:T-f18B<^@REEe
PWaZV,71cF__</4MQ;\Z=0OZP/Y3_\.W@<4V&8M-b-T_+5:g2&J2UK#D&UfQ^ISB
JK6YC-OdII@XNQ\D40NPe865^O>F;@d7FRI=Qd,O/\5H_>2I@W_;EXT(K:Ba.G2X
5V:-H8.W2O/-d.N3)<2[a?7=D5de7=C7>cY/3a3MUETRLNMP]8HU:@YR:2,Cca,;
O=_)e4RO,@HU@-_7e0O2[gAJ)2S5J&.N(6.,/H9&a11\,[]WI>QV+JKR>dX]ELL:
#<2G>OI63=PBVD#gSV)J3.f[:c8\>9)RWg(<CY+YTZ(LI2fBCg0e/,8IM43&(VaH
)DOCVHZ0Y?\I[DK[O(ga2YXYbMKAA:]DUX6(_V<aeEMB=/XWG6O>Pg=X)PBcHU#5
7]-<T^+M+X9B1=;AHMV-F@f-EG/d.(1WX5=,;Kc+5J(W#g)cP3@YQ.TC^EFH;1(9
J9AU;g)OeSMD]R:7AA[1/9,HegE)(<@e^=Ia(F#5AVg[IEf#<)B#-e\F^F(&;-9Q
[NC<Q0]U_Qg_;\IUP@[O>>MS&RS6&<EI4)218HSZc^<2dAB-,+01>)[S4/dV;AMJ
X-U\WEHI::VQKQO_]V+3E<W<9O3cC1=fY-J8cQLeK<gK<#>CD[HMH,d&\9[YF[V4
^5QV=-1?TQW@^OeNHe+g2<#b/BRDI[ZB0J_gZS.\XMac&V3_Z;^1G6,J=6\1;5A>
Za[=Q2[dRGO;gQ,LcR7&]E27C..=G/2e,XV1AB1H25;+3/<b4BbX+^U#+28:<eSH
HRa2RAW_60&:RCAI65NSdP[#W4W-Qb;):.6.4HZgB/_&5;7.H6a9[L)PL=E\4eWR
PUb2[#Fac<6SO)I3b)AE)=D1J/^I#IOM9dVV(fY4N9E58/8e(YS:XZP(>PB^7HLe
T@K^H&]1bJXS;&ZfLVefb.PZe?PN+SER--Y;561Q1P-CWCXb4+)S9AbaXXO[cAdH
[F\eNaa/]:a)XG[_XYNeEA<CA2\CJcR-PE?eZW-O:^O@62A#35@(?fY4IY>G&LG6
9M,[c6E=)C:ZOU6OA.AB@?3)((:8Fc]dMF]J,,K;dY;H+]2PG):424BPK,-g5K8\
4D8\<HX]c^&Rd4IKCH[TZ0-_4Y^WE3^ME18X;CXU9Rf@[<Y[_6VR=@)Q4RCa,I:H
/OQR2]?VJ:N=5YIR&+8^]-[MNe>BS#=4F;0e3R+V8&G:VY&8@H1[-JT>D9+K&[R8
W[RbGc,GP-2bY9d:4\AC+]CH+7)C==^LZ;Cf0XGEIRU#QE+U=c0^VXRdG.Z:,Y/b
N7JP)Z)X(G[[6JLFDJ]N)#db9;\@<_9PAU)-<=[8-<?J7bDUKI?b\.)IE\-]5_Jc
5GGfHIBG7/+IZMN3\[H\Qc.g<Lab^-MF)0\IW-(5T[A8JeX05f-2#]:IZD>(W6-^
6)5HJ-a-WDaXT)e3Nd09e)G=WgHbFX(-3<NE1#BQJD,;dC/7H6B6#S+<@d8NWN]-
,0Z,:I7K\FScNR:5Nb:P[T/^H[-_Z(bQKe])\DM^).)+M=EDbHDAY539.3;5ZGLE
<]\)G?WSN6_V[MIQ&fM(=#?>+TRf\XN(WMeZf-CLJIW+)7;-g,6^)bN/d(C:D:09
g2\NUG:W>#^,3b91RC8QE\M(WXA9KGfdXbKGG8H,.=ME+ee=N8&>RPQ-@NB(,d2;
78+ETgP;g3[7G.VRM2:-.2PW+LXJ=g6FWIEELJ#_FY70RgdA?7YT^?J2VdO9-,#G
/DM3_&S?[\W+L;PLXaQe8Cd2D9R.=SSO5H>NQIX4dga8[>T4K>ad()ePC&R;CG_Q
WBGI0D\/ZLL>O=Pc&d3_.<aD:@GVUH1WACZ>]a=g/?;GeO@F/B9J@<Z3:WK+#0BH
Wd.,#GYURgG>0$
`endprotected


`endif // GUARD_SVT_CHI_SN_PROTOCOL_COMMON_SV
