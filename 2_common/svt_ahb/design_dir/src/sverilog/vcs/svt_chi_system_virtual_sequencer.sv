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

`ifndef GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_chi_system_virtual_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /* CHI RN Virtual sequencer */
  svt_chi_rn_virtual_sequencer rn_virt_seqr[];

  /* CHI SN sequencer */
  svt_chi_sn_virtual_sequencer sn_virt_seqr[];

`ifndef SVT_AMBA_EXCLUDE_AXI_IN_CHI_SYS_ENV
  /* AXI Master sequencer */
  svt_axi_master_sequencer master_seqr[];

  /* AXI Slave sequencer */
  svt_axi_slave_sequencer slave_seqr[];
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_chi_system_configuration cfg;

  /** status object for this sequencer. */
  svt_chi_system_status status_obj;

  // ****************************************************************************
  // Shorthand Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_chi_system_virtual_sequencer)

  extern function new(string name="svt_chi_system_virtual_sequencer", uvm_component parent=null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Pre-sizes the sequencer references
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_status_obj(ref svt_status status_obj);

endclass: svt_chi_system_virtual_sequencer

`protected
];=3KG8EQ;<cb#Oc)BKd[HgIKAJMcRNU6BD_5=c3_G&g:#DI,S>f3).-Y<GOD8fN
+Y]T6834Td3@E3_.^UT&CN;aaA79T#PR#TG@R8Z:UXQ(F&Ra[?gbG0M/0;HKHGA=
SN;N<a<YPI>]T-@IP]M5_AZRIODb0V8P+7P4.HKeffI92S-G[B^:OeE3QYYc&@EH
CS1YQXF#eeB7gHG,Y[O.gDNDS+]>&M5:=;</fGb5-?J9bNXK&ZJ7O4AXT_Q896#/
MV1M;X8;G&H-O]MJO:L.Oc/.=>X=BA.DC5-;OUS2ab9NU<:R8e:Ae;^T_fC7bId&
D8VGB0P+]M(D<X(Y2Bg0@:f&&^eUaY8\<$
`endprotected


//vcs_vip_protect
`protected
;VQT)857;1H13cW-J.6=2ePc=F/2=dH7Y(]V3O-T950J1<\C:,LL+(35+79C4K4+
.4_[Rg9F&HZP+7MSIE4JM(04?)/Z^\:]DE<_TVL;L6.TdN)0V13ZX:Fea4gNUL(4
^HEF0X(VMD6@NE^-;aXg?f+b;@G-BgTZD.43X]6@(M&@[YEE/V5e^(=&+,Zb[OF)
^.K:AE.KYH-:N=Te#[(bZ=4BW,QH0((BXYG8.(2bR296&TM?N2NI<dQDTBJG(:bJ
3VX68\EeR6b5KEe>;#<B.Y.[eR0BcLV.E>I?LMKV6]cHX3JYU@f-0O+KPgNe,SdG
D0b4+_]UCO9IH-e,gK.@6PfKCdJeDQ/<>?+#YVG2fS]YK#G?K@2_5b)V/5c0AP]8
E3#8[^8_aQNFDYH:-+bW/L<9@ga)#UOT)a9FD@Lf-M1I]I\<5@DZ&?Y6ST@L3Ub/
YLRY22JVI0QQW)?,#:5Q[LW&bGA^&LMWQEJA^9cK]>>,cVd/bdP#2Z9?33eV4(IT
)Fb/SQ@AV&ZT@>SB#B\-1O>f3KK1MT#(.d(Y^Q?-=\3K-ET?+6PG-U.?YX:?cL5O
9?KD3MMB+LW_/6AN70([L7\OKEG=(:R9V#&Ecf;O,.YCAY>+\^cXBVU6df-a(5MQ
(cbMLe0.\EG\.NMc<T7[>OYRCUc86)(CIIb&8+(.0QG9,+8eMSIdYR)b//:Y5&)S
>=DV;QK6&+M4VDBIW5A?3]&;Z3+)-GCGA8QH#&GK_P+UGB;U16GJO((\_d_3D3:T
?O4VWAWJX(.\SfC95R2.BJ07G-XY_P>4=eMb.WQA.EW#&W6eB<&<O-@F/7E8H][d
(>X0RW+YZ=,[;;Q_VQO)-e?6E]Gg(MMV+82W7Jc99,BI=[.>8)+B>>e8?N+.>P7C
eP4]XC,Q1Sfd3,eHf-g?VBWP=@,PG5Z9K516?fTfa(>2eW&8W4TTD8@Y+IXGVV&F
Ed=Q_A(G5C0;Z47[cFTXBY7M@Me\5,E;5I4(<7Z<)210J)L9[C4H:]]D?P)2CXb:
[/gdc<fG]G[)Ne>GD17>4&C(e66NO?A7K:\7Je1Ga0PR.S+c:OKT1BeO:D86HJZ2
,1D5EDH#EK_K0V\bc4XF?]52Q+V[DgbY+dU+Z993SSgZP_-UX\OeX3J.^.]E#]W8
DSO-2JIL91.HMH>#8Y/)1C#RMFKYOc:\.:H?2bafcc/K4@?E?4U38;BLGDH5,K-+
1J9N5,QZ^:AI?5WgU:9a&-]O37:Ad:-ZeJgZQH]bd?<83</:W2bbGVF4fD26BWB,
JV[W&,O8BRK?5/;BX-NeIFQ-geGc=9.ST&VPH59#JP#\ZLIc>KN4T_+\-D[da)6;
L@W^_CI/?P&CD;cPG#>#>?#>=agON(,7bZCe].P\;b2:;@<T:<2S,-GffII4K<D=
@5B>F6W9S\fU;LC/9H@^\+gfX<J9,H:G_J3LHd1:<;;\;I8B]8Ka9S3)+@Mf<^2;
&CO:F@&_[aU\:V?fb6.;;^,SOLW6KKL8(7fE)8.JB[X?W4#+M6PMQe\<DK:cTPF-
gD4K^K(3<GY@/P#00<G\9D_7,HC3AgR)(&)gLP@W0,&f8[?b8?DNCQ)=66LZ+,(+
/.,e6A>G;?gVN;9.#Sd??N(LI1(6D)CTcM01#@^RI-GV:SbEaKS,5;3^RU0MR1.7
KSI0e<eScOQZ)UK1g:1D=a6N?UG\/ZXaEKZdcK^VO_AYV9TN,K^D0>3fNT>WXR6,
X5DMSBTM\]gA&3V7MZZ2UBLP:c]dLN,W0#J3(4;IL5D+P=YFW_0]8#fB-+eVL_N5
S74&[SMafgBAWSWAeK243_3aNJI:N)A:]:g.&c<Z:.<g(5EWFI3f-+.IV@.+]6D0
30db3TU_D_NS-+TW.?gKe?WP7DV:X+H>]g:BIH^Z=f/DPJ9Q^d?a+=M0-@(FGNGM
YN_B._E-I[Z4Aa\O[:L#G;fVT03?:FFZ1#<7/,-2?J1;OIc7A1@[0GCZFc^Xd&AW
)a_?2Hc4C1=BNOD7596d)5>UD-HY.T@)3]7LJ>.S\X-ARWf=,[-M+)<W:]#:WV70
&5IVbL1>NGLcT_PJRC?,X3SR>UEC8I[PJP8KLW.?fJNQX2[QDNEE2)@UE\2M_7D5
LJ8)#_(Y1M4WCD7_YBa+aT4gN>6[P<D4;$
`endprotected


`endif // GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
