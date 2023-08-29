
`ifndef GUARD_SVT_APB_SLAVE_AGENT_SV
`define GUARD_SVT_APB_SLAVE_AGENT_SV

// =============================================================================
/** The slave agent encapsulates slave sequencer, slave driver, and system
 * monitor. The slave agent can be configured to operate in active mode and
 * passive mode. The user can provide APB sequences to the slave sequencer.
 * The slave agent is configured using system configuration
 * #svt_apb_slave_configuration. The system configuration should be provided to
 * the slave agent in the build phase of the test.  Within the slave agent,
 * the slave driver gets sequences from the slave sequencer. The slave
 * driver then drives the APB transactions on the APB port. The slave driver
 * and system monitor components within slave agent call callback methods at
 * various phases of execution of the APB transaction. After the APB
 * transaction on the bus is complete, the completed sequence item is provided
 * to the analysis port of port monitor, which can be used by the testbench.
 */
class svt_apb_slave_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_apb_slave_if svt_apb_slave_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** APB Slave virtual interface */
  svt_apb_slave_vif vif;

  /** APB Slave Driver */
  svt_apb_slave driver;

  /** APB System Monitor */
  svt_apb_slave_monitor monitor; 

  /** APB Slave Sequencer */
  svt_apb_slave_sequencer sequencer;

  /** A reference to the slave memory 
   *
   *  Only applicable if the svt_apb_slave_memory_sequence sequence is used
   */ 
  svt_apb_memory apb_slave_mem;

  /** APB External Slave Index */ 
  int apb_external_port_id = -1;

  /** APB External Slave Agent Configuration */ 
  svt_apb_slave_configuration apb_external_port_cfg; 

  /** Callback which implements transaction reporting and tracing */
  svt_apb_slave_monitor_transaction_report_callback xact_report_cb;

  /** Reference to the system wide sequence item report. */
  svt_sequence_item_report sys_seq_item_report;

/** @cond PRIVATE */
  /** APB slave coverage callback handle*/
  svt_apb_slave_monitor_def_cov_callback slave_trans_cov_cb;

  /** APB Signal coverage callbacks */
  svt_apb_slave_monitor_def_toggle_cov_callback #(virtual svt_apb_slave_if.svt_apb_monitor_modport) slave_toggle_cov_cb;
  svt_apb_slave_monitor_def_state_cov_callback #(virtual svt_apb_slave_if.svt_apb_monitor_modport)  slave_state_cov_cb;

  /** Callback which implements XML generation for Protocol Analyzer */
  svt_apb_slave_monitor_pa_writer_callback slave_xml_writer_cb;
  
  /** Writer used in callbacks to generate XML/FSDB output for pa */
  protected svt_xml_writer xml_writer = null;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  /** APB Master Monitor Callback Instance for System Checker */
  svt_apb_slave_monitor_system_checker_callback system_checker_cb;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg; 

  /** Address mapper for this slave component */
  local svt_apb_mem_address_mapper mem_addr_mapper;
/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_slave_agent)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components if configured as an
   * active component.
   * Costructs the #monitor component if configured as active or passive component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer TLM ports if configured as a UVM_ACTIVE
   * component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Extract Phase
   * Close out the XML file if it is enabled
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

/** @cond PRIVATE */
  /**
   * Obtain the address mapper for this slave
   */
  extern function svt_apb_mem_address_mapper get_mem_address_mapper();

  /** Gets the name of this agent */
  extern function string get_requester_name();

/** @endcond */

  extern function svt_mem_backdoor_base get_mem_backdoor();

  /**
   * Function to set the port configuration and port index for an external agent. 
   */
  extern function set_external_agents_props(input int port_idx= -1, input svt_apb_slave_configuration port_cfg);

endclass

`protected
;<OC[g->\(X892DMO[>KNTSM9UWdHbRNR0O,)G7.e8FK3P.>T</L-)L=@M>R\/+<
\V/fc>@:7g50(I>:aLR/><GV.5Cad#gC?EO#TH;XA:Le3=WSD;LM2J:A.6dQ#TQW
KKAdJDg2B(Y;B7C8LW-eCUN&[/\4^cg3g+@BI^=45\:ZIQMd9C)abKM,;2GE7U;d
2M2A#OGAF6.XX(@JL[,HSIV&#G6B<L(8YD&/;;=?aU>&5&YCg6(@P:GE1cb(@6#Q
9]0@-I0#J:L6>Db80&RKagfW]63NMbI;g+g;=/?9Y/Q&B$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
eX#ANDH<F/d;(97IE>FA7E^+_POEOIO(]]3>PG9A-[#LP-5g-5dB6(gWL:=6dSY,
TE7XC91<O+3cCS/HZ&.,>\OIV>+JJ1A8dC#CdUYVC0ag(\2O_C[.HBN7VV=[_RId
D9/\T)0CLbK?P;dXCMW0QA6(?=>S3OS/K:<)+a#GO_2SGY:2E7?4Z_I34\;L]+H8
LU]7+FHCFO,#>ZFP8M5d7\08A7O7cQ+AQ)Z<HgEKeM>?0SEU8Q9F)&BTQGNX38GK
-bbNL7+9g9PSEC/SM.)V(_&K5+2>2(EaTdWI@XH5=P(^g91[NS9e8?PN,(<<40;-
LF^IWGELZ?^]G;7K)(=&72J>;/1Z15e.3:C:6;JX@4+9>7;dT>&OeZ\O0Q=KZZ#e
>5D_O^:+da6Ea^<])E43[,F^J<Z&;N#M\C4SXcZ3(_eg[e6=KJc6ZM,F>XYP71\O
U+HU5\IXGMWFO8AJd6)W5+TU//:?#M3a/aV?PcSP]9ba=g:Lf;SgS/GQ=&TPS:)I
@YD5@-Y.EM[aX6d0U2YNS9ZAeK0ZK10?0PV?V[LJTP:83(?/2E?&:-a)RZFS+HYP
#NNM99S2G5(RGfJN4g^4OEWI]2eGU&cXKX8Y_T3V/,(PZ5cT+]8X92.H^6MF3\&&
QUK,OVRC_=TReI18R;AQK=A3UTZagO]79_,)dIc+?&^X7[fVH2:NHG-]/+U:ffFf
)d_8K=-95\1AH_H[7FcVV-7dGS2BR6(/K3X=^)1?Qa3K]M@0@9_&A.R:Ye19Se8(
B2--=/gP8Z9E;X7Q\R6Y0>33+1;MN@;S:@>DVCe3IZG=d?G#aP<B,4]OYCUUJ8N1
=T/a8EO6d=VQ>95U<&(=0c6+WD?XF^\g7?Ie#.cOWRH3Q^BCDTe#E,?H+Z4;BJST
&A_24[W1C7eHB-J,X5,GadS-g1@VgHY[KNR+J9W,.)^e4\6d,02^T7X#S9VEFC_7
fg^M?f6d>#f5cDD3fSR8RME:B01QH?fTHHD#+]3/)W??@If-TMcUV:5W(8IE4OBG
1KDAIS8:S9I-()c7eCc]QH/Y5.R;9=;#Y&ga7f^SZ@;CY#+)3]0;[D_ZO_EFcPK\
_g\-^CI,BK6_N4-TX6=<9\g_@?LGW[.YfQ\#0J8:fOc[a^<f+XM<dfEa\J:N1&Bc
9f;+(Y[L+WXDWR?6[b0Q,3ODIJ(Jaa2G?BFOgU+&TFf-2Sb:XXI@=6PJ=YFE;#0O
cd..#I6BOUG3d5Sd21F5d\Q5KE=.V(K60.7SV,2R+?QDF+gGA@fRTX&;NE&\C3DP
I[c[8fYL#C=YN(1G;N9/[/Wg;0][>E_=80B](K6dZV3g4aCH->_-V_E9;[2bHa=H
-NFB8HG[HR8JF5EIR^fL>JNOB@C\OLU1>#?fQg&a\:-&Bf.1,==?X9(LL700H)7W
7@QaYIK7P295::/:99HCHSB.W;6TA>a,NMXBIMdSbPKBM6e:;b+88^G#X4>YJFSX
9I.g[g(MM]NRP)5,ad+0b#_DVC9C5g8-IeW]RDCE)CEB(F>Bc<GDGGSE<d:UeJ=V
+.>5]4Zf[HS[,(5Y.9;6WcafGJ]-e&[3F7X&=YY:a5;W2U+Q@[DZc<c@&8D+?;OH
8Y7O-56J;3?8F?3=QeUYb@Cf4ZeULIA3N?W1JVN??9ad.V__Q>-?\1)I4#X\cgd,
=M\:>9=@.IVJJO2O;EM=:+SI@>fFEbUAdT]B=fHPg\1AM-[)d)0?<^@J1+K6C<Kc
bJ[EQNUXc>7CY6OP9DYeQL;Ja#(VKLTC-SfJbI3MdI=]TBRgMfC#XcD<8(-HTG>c
cN@KARO0]^TJB2AJ)1O+aPNM;bZf>HYT^QJ00@^^O5?0E1-SU]2:<T4R(KT,4>P6
N<(efc(6baVRDGBB^;:XU)H^,J=c\(LI>SUeXTF@Qb+Yd;\1g/5ULH)SDgY<62-Q
X\31QG)ORF=Pb9G0fF\.JREI:C7L>4:\C>J<G_12I^8O>Z,F-[3d86+RX\6/Z88S
C,;9LXAK[SJ.2]FFO39.e>MQN^=]Y0BRS<UA=IS+MRLH/O2=dME8>G>e<?2#X5L/
e&<6>5P<O15#<)^LH09?d69:K054\F5Ic-^2GQ@aH5AG_Q9I:Q.)45V:c;QHZgL)
Cg3\#UIP(DO:N<G@/HbB.<@-e4UcA#I#T_MJ<ZC-WgS2,HWJgT#P(LI9,)95^L,e
RYD&I<c)dc(a\@Q44^V5(#/([ZW@f6Z=M1G2SD)IF(7\(#)NBPB;C+gY>I&8QJE&
+F2P@XI=E368B4?/./3=[VH7CIY&TR4C:ZA?&D=PO0dSWN8VDH?+MX^WRRd5Q]V1
a:61I@]4T:T?AKDF1;^00=Q?RXS^Z]\Q=c]9WA,XfgNF[4&eFTd=27[6I.<f5-R<
Qa7HEdV^4-?I+AaZ<3N\=?bJIP;N8;-18Dc_YYgQCR783U:2I[fYb\F<1R7P]+Zd
P<W_N;>NJ5eM6G?,c]VZA^I,gTB[E[KUZADV-=S]f&&^[A7)?a8T6)@B3#Z#b3af
(5R.\@0)QHHXVc]8HKIc82(6[EBO@H&Wdf0\_)./@a.N[ZUDVd.SdJBLI<,.C&?J
RE+L5#3S-ZS=b?cQG__&Y,&K=+3E#&d=L=N1N6M3@3.8V=U;e_00PS)#a^/:/Aa,
0[^3,PdbUJTO>2]3LWR(,)@)YWK2T33fR-<c1TaI0YP]AV-88;N#gE8C.Vd8+;#F
bOGf#aPf\K,,E1)T[&HS(WE.;FQ,(JW2BCbg(O#cVdIXUb7;gH^UWLM,Ug:YK5cC
:6eB<8_Wd_,BD@#gECGZ)8_g=#eUYF(GPGH&R;8OSNUbBcN6?B(J_<ZJf^adgc3d
.5]G54dW)#N_:d:UFQ8Yf.I4663V)22.H#WMQ(2>7BY@>3(Qa572])WO7QME@)?@
&OE;GWF=O,^AYQKW9D5_g1:?_F,N=OIK&a#^2@J.D&gL8WPYAY1ZI36E>@096ZTX
4-6(M2JYa3=Bb.EY16-G[6Rg3GA:_=G5g/P9XF1I1d_3A]d5#/_fYJEd9-PA>JPI
1_OC++b&A:P#b-3LSWO2VSY-O=V.[Q/dXO)S75&2E4:>+)GR/<59ET0+8/63)]d@
FDW_H=.&Z_+?<8c,//K[G#7/d.a4DKU.)H,M?ILdJ/ITX:4(J3#aQ?JX)MNAbK7F
H:[:9R]e+eYbR4291LRJ9gaH5+d4LD,9g.gD40@3/^dTYA4>S-fc#\=57?e&gdPH
be-^&&Z]R5S<<=5B8Nd#/,Y4JXM<75;A[Yfb5BL3+cMa;JL@^Rb#&TRVNL?MgK82
5OeHAC/2]BT?@af74:PV6/FWc=KO:20b7S<48OUPCU]R=TQ7K_WJH9YIf3?c[C/)
]48H:dV_4PcFQ[>T#a#IPAE2[98G6@\d8T,[6GATc6c]#Y/aUU3Y&+IG2&4VT.6Y
:T3BNO3-BGY<3(-?f_:\Rd(;#B[]+R[GQ:XRKM[U+cA=@TYF#77^]9NKR=TO_YSX
#(RYJ^<GR@]J3F@#PB=>H>A(D?L:7X(EVMCE^0//R8eS>8]H]5Cf6Wa)e_OANTS;
JQ+:F]RY5YRS8C2c(:H]GDG1MU-/VU7S3]=;&#[.J:P0R_FbTd=A_eEM/1)XX^2<
ZZ1,K(d?5AGDH]:_U4f-IB.+)N4\^)IK=0.@D9TfM69;Dd/13/QfB#,&^G;&9J9B
?96a+M>4Z)S1=N3A#;6F<aBEW12-UI<fe\VCbR3>O\PaOa#^;G44aLeWT@2MK@8)
\:dP1ZOPF7K3(V-6bQA@LX]U-_:6\Da5RBAg07IX-gPM1=b.XE3>4QN,UUGc=]TZ
G6M8QKd.H;^S3CFTV2JXW;=WH\AYS4I;?U.21GC8>??Cc0PF5W6dC:RM[68[=@.#
^72VBU^9MEb/<];B2dJI]L0R_XAg+BD]Z8L0NM2<_[cGA4b^/@9^ffaM+YA[QRQ:
b)4c^)_QOR83VE#69;5QG]UC5),5B_WgP4/#V-.,6cVY@=5:Xb4TI0SBZ^^]Z)g/
>MWU6/11W@B/7_8AHb5f2,\14[I1J6K\9_[DL.EA/1F(dJd^&,_W<YQ;cE7,FO7I
^YC3IW5Ig-]NCDc_/e[NYITNT4PNWHQ4X<<2K]&AYfO[?(Se3aN7_eONfL#VRCG<
Z+ZMW_2S+_gO]MRKU2H).OL9a]5\_MRRJQLeHVNC+-=<(9WMO&U5Y0C;VN]&S3#8
)?FB8ag(T@&TP9M3#9QF9VH)f+-9U/\\(CK5=;A3SI9Z]O</JR4,cAY;_d\T?,T3
TM,_,U1S.;3VI([M7;4,eY/=d?Y1B[6SG6dW>QY)Y_#[4/MTB_/N[cSZ8]D7X/f>
^]N^TB,>2PaO]3cYP.e@(MaL[03()_2#2_[3FKKgf2:K@;(B\6,-0UFSSI7#EbcL
E7V5d^.0XV8c:#>_7,QI+.c984O0UceR,X2[2:BH2#P^R>4XF=K8F_X9[_OG(.:>
&R/<Hf-^]NcRI/(8597R2M[7@IY=CV_-:L-TI>a-NW=a^QRa84<&M<gKbTYbC7[F
D93gKe&]F54BO9C[P_X=,0Ua<+\YBBGXOJNVH/W.Uf;dJbFQ+-EaG\S9&@ZB?[<g
BK?EQRW_=NMe/a\;N6A_1R#cMUE?.@?,4>U=I:H=d-JUX_K.J+f[VbAfdT<G=YS;
4CJ-SdG\T#:YgCgOD3fc=M^[^=WMcMT5?c)0RK&LZOF/-DB0?F/+eJJ5SBR8^cH0
#S.R^dd8/A,fdADB-2<>AbYeR4ZFB#]^,^/I^9T2D34c0IQ1>&gPC_VH+R@/?]U[
(/Q@L>+,(BaeLZ7Y.Z]X+MY[afbaK00NR_-[WZ>=d2&IEA]E(&I+aZ=1^[S/&a99
/M]7QNKE?KGED=OAISAFcQ6L?X.QS0HG<T/=QMI;M)_E@\<Bd^DR6(OAA4YgHMK5
C=8T4-<HNdgI>K28)OPe@4/0d_F^A,d;,:U0^6@=E^T384fc9++>Cg_/44GBJ9YS
/6O2I[<G,)eOWK)0:4[g--c/.#OE8-\P(HU)]<6;;54R,,_E0X+;(Ka)5W<C&g9K
7XG:0G3Z_SG4D.2I4DRTP6TOMZBJ[A3)\8Fd?)EdT)C\K[0JGW94.5B4=3S2]2;=
W<KH7/L.Z4[&?>0Sd:@E2)N\#ZTB9)c(=(;fV<N;)g+,C=bAFQCE@eRFa4?K84#0
f+[Ad5DW8;A/(KTNQaWc<RIFG,a<79_24J.&X&#4BaXJRa\:L_1&2,06UdN94/?a
J-]g#^;Dd0Qf@-008J:VfK_5dQP+M_d9R7R9/;bfG696fg]&bbIFX@/,W6egTA9e
<+BC@gV=YgX=+3QH^L&\\4@e=fdM\(f_1(&G4DaeN,5J8YF5+&]J)(IY51VDCO<6
<_eab+Z[72G<g-[g^\J+JBG8FW)V,cO@&=(?)cYc@agZ(SUKM?#]K7WdX@)Kaa9[
-46cLfSO6_M]eWaW4&2^;A<=,[0Y6,RB6=0cC8P>:D//G73NS6?egT?BQPM+JaG,
K3/50;9354L?WP2>?L-_aS\IH,Y\TVM[c>_gD9^eLI9L#d3g@XW0)He_Re8ObPg?
^<EUd1(-&,d@eFU2J]VJ_b.a29CF1V]5FL9.&QPDX19\@M_d@JMOWOW,4&B6LPa4
b4eZZ9CW9ZZ:f\JYZ<gdPfDKU-8TSeeFL2]RI];-K=O78>ZV#N7IEK-KI2gJbW47
#P7cP;I^5ETg^F4RIR@d^gWK>:ULFV/3:QF=fN<8XH_>bF=+NQ(SZ>FU&W/)I7T^
:A+1/ZCIaDBQHd4GP+9UQ-Kf_XVQg:J\)UWLO(YS,[13XZ]RI0=?dcC1A^QVd_PI
3;>&FY.23Q+fS/GV2?A=&&.5KK<@R&He>)-A1C5:G,(fS8FBgJWRW:4JZQ(+&\[f
d.]NKb<XD56<?&>E&0@)PQ&6())<aK&,\YW+=PbN-8U,[0HWX=)<[\4bHd4b>)E^
/+REPEOM-7,?;FWfHE+\D3B6=K>2baIETQ\L(:b7\HCQcTCb.fQ]RJS78g25VZJK
_IJ<352cFG0U+)=KH1;&f?K<f/_RKU\CgMaH.KU@S50F-S.NE<e^[:P0[RZ[BUc-
+]<bSf#C@fZ2.=cE0H&D9<J]Y-BWI2gX:2U.X7>FXO=YU@X3^M-cHCc_cUDYb=5d
6>ZFTa0VeH\dKI)?BFY6@\:):;=dCW8;>T@GS=T[c?;C;/YX+G=/[^Y[KZD-BR&N
)5)=0,&g&cX\MQ#CI?XC-Z+RT:fFbIdQP=U>MQ+RV:@2KT&O(3aD<0O0:5^3gOP<
G<cW_0^TZ\Y<#HBIgfB,V)S<AIY(GZe^_05ZXf[^V3A]+D[PA(EHF7YO_3>9A\I/
+:]#&X\0;><cWE->fDJ_;87gedB2)\K,X#e_.gM<JRR.F1NI/(f]@B>B214[8;-P
L1Xe48H800/,VGZ;dKE<ON.6DQR>E<S(3+(ZRXQU^QeA@,fUR_+C3Z?UTb:c;CL#
K@F#3fHYZQA6>b\cLCbU0ddJg&]@\#UC(cC08Mff?^)7X2.,eZ?/^SN\,c-N/=#F
>[_94=@Z/;f7P@BVfgcQDBRe8-N5+ZN3SK3)cI;W/>?&CVY774gG^]17UPQ0O;TC
_#RQCe]K;U13BKPPc\EDcM<3+YG+I&JUR^F^=X<Q,0ZZb;OCX<G\DfB6IMM[,RC(
CZ>7g4]]AU(8cb4U7KKM6/S1L+IJgc/U:QY5JW]Fc<aUU3,.MN;f;K(QfCY^fG,S
804,C:O#DKYPeC#1]>QHb&JT2X6N;4-_dVGZ[&=M7\F,dU^:/_JUVIHB=X2Z)_6E
^_>EF.:H=EUSL^THeJY;?+=YH/QCE=&C,FS?ee7QL4333J;EeYT<1AVdNN5c,..P
feO^)(.cBb3/e=ZQJ?Rgdf\)J7]1)e6UXZbS;X:]07[3cIL.1[BaV^Fg<OV_HV5>
W@K,;C+YM#c+dH)_^VUL60L_X)>TT[C5[CZK>AIf8>P+fJ:=#GbJYf+gc^_IaGe-
6ZQU5##>6KG5CTKMa@PVfGCWF@@SaH8-2_c[Mb#:bIVA.d#(083Lb+@fKYJ=SaCB
@a6Y>M4?_EfWbZAO^YBZcBScGJR\R:8<P]#Z</KX8.B(]]=B:0.M&OEgcb9U&C)7
T;_[[KOL>dS;9f7.O1Y,gdAQT+W;J0N<NWI.7.TbC=HZ.TO/#N_fU2Vb=HFeYPA[
f0aA[P7S8T.)H);ScCA/M8Z6]BU3SZ8)0AXRf:17M?C<Veb[-#I[P^He+\=:S>81
Y\NWB>@.3WUPHPQBHge?G:SbbFf&,M7:DLD<HY/]d2897)N&:<eC5YLY)(W<W9Da
PgBJg9#Z:C-@I)e9L4/XaT8+\)U@N9F0.c3#[[+TZ/WK@:N#@X?L_aJJ)=Icb+\L
NIR7(43IATM:K[c)12UOfN:8C9^bZ4RbC>J_/a-9gd+]W5eD(VP4DN83:BPdd]@8
K+J+GUJA8XbT_>0M-J=Ig/RE4MeH(W3<DG1.CYc-b[0ae[[89Z8MQ:WRg;H<@C2c
_Of^0I^U23(16>=b7JUQ0c,gJ&35S/f/Z&@K+4/dY>:gdfK0INBTDY27GDFWYT/<
-RcRg)3?#0M:a9?E61@;9IF>.E6LJ+Q2KKPU.JVR@7\IRXTb_1F/cR2XVNA+8Ia7
:>[VS.a[;X)aZ=\V=\#+)5e/X/7==7_#<N,ac)U_9F:Xc6[L3cZT(26>V.OJB#]R
^V;TM91S/SC3+R\6-cB3.]CUe+NG,KP8(O=d]e[E98K?ZfJ_S^_J37&GSY;T[4(Q
\#H-I^5bJ4PT#<HXBS,FWaH>8+9_4e=;45K^Be[MS2NGCZg-Y(;&-a4d?9&[c-LT
UCc8][E.G(3A3Pd.#bV6@>F<Y^^3S\CNWe,(BV&(V[1JDL^89V[Q3KP[0/AWIR]]
PS;\;<e&9J\\B=>D6DF.//cAI-ZNL05BI+d:^[P[W9NEWMbb1VB7N@5MC;(LKP3a
gX+&Z#7M_;bJ&8;WX[9Wa)M@+bKD/R_)E5MVgSF:->3OdF,,(;3JV544=^;UNF/A
(LC9/8[B\Y#YX@NR+,>)((GEGMAe_aeIRRf_\L93C&7TW3TPfeD9IMF?GEg41(CQ
X41+4N78&L[[E3#^d,g)N:>Zd4I<?+@[#^b&:K@4f_SX;SF,8f@5b0,7T@50S/b_
7ES=P,0?ZNXTeZ:P0EfJHf-P]?CG;M9KF=Q=.;VPJ65VOTO(MaY?SP1RfV=6&Q?J
T]E/AR_1?da)1YR4CVIGLE=SFKAGa^f0QG<N;MK0XEF\--HZ_B0L[XF1YC?=B1g]
M@>2MHeCB)(B\cNK?NCf]c3-PdP)H]R_&PJFI-/85-AU.RK_(+UM\cg./Gf.M]T6
5ZW&f/:VRd:C24:EG:eTd4Q@&5\EUf:+Y;V3FgggC2V24<6DQ,HQ.:KV(/c,8b]U
P\_..ET73:eJ,X2NC+.9^Maf6@0d+5Ld.ZUCM#d@Le/7LWaJCPI6@bd>R)::-Sf9
176J5-PO3\OGM59aJ&S#_?3RW^N5CX;BXHed<;<IO3>BJ6-Ab@^MSEW;/.Y;GL5]
/MV^4QZ=(FQJ:PY?#];(ODP:]2XSD-&34g=6b[Hg5YK[0;.2-H.Y9;C)8^67;]Ud
?W_/SgV(N2Ne#>)N5aG4D>H+O_af[MZ:\<ceZSRbZL:6UeQ)@E?1:T7UBG=b6bBY
=G=^)517AP+1+)b(gV:9O4P9_XUbTd17<@g9EH@N2W:+Y,A[=_d06OY1bTE0Ce76
?>2K(\c+4aJ,=(/<,4ZL[\e9dZ#22423Fc\QLO]0BK@Z_,TEMdKDHQL.Pc55IDgG
=Z^BP](#U&YN#CWVB5.>LadVDE)bO,OUCQTK<H14CL]JI82Cf:ME)Z1]J&D=1=WD
.D2E(>=GPM21f7FTa^EW9f#[<KCGaJ7Hd0)d-/C0OgRO.?[8738gIed0gK0Sec8?
/6H(]JYbcg/a8bAPB9P+8geYE3U\SSD4-Xe&-O7=IN0RC=-39fcFSf&6c7(@PS=X
M>e)J)T]_O3fAH6GW)GcDJU[?ZY76A_4QX.3G=dKc_[MRIY8(/FWJ54@;e+^X]L+
KFHBB(+@M68#YFb1LSI7X.(93PIcH0Y.U:g?C?f/a(@7MO8Y_egAF\IB1Z>_5/G\
T,V&faQ2OX<I7e;cV3YO(-LR-(K>W=IbXNJ&.1W9[<#H]Bf)I#X@fH\0(5H<4)fd
ge;(X>OZ/6=0Q?J4@O.7:5c&fSId)#0G/EbUS5I&^O;KaL>;@U@_RI>GXVA^R/<7
+;)d[>#.H^Q4H<])abdN,P7<D]D7DeO5eG.L/ZP@Wg9KdM1Tf6/7+=I?QCTg8\9E
XgAW=]/]bCCd^66fb/e,YH/Fee)b:7B_Y29cVfaX22QFZ88_e2bFKBR;;8[=[A+I
VGG5cBR],dDF@][6[(I])I6E>10cA5KMINS[?\Z/JRLLPVfH2[#:8?^P^]H-]Z.H
_E7AL3Y#6^C#4VaN)W9SVd77+<@P[]J)93Q7;+D[H5MU[Kd])OcGS17[Of+cBcb/
.?d0g,8g3d&T91DU5G5<bN>9EE8Ya..Y#9A0C?=.38EAI@#\68(_L#E]Jb>d\Md7
EG)/SXX>-+Ac0HSa.[P59dFG.(LbC8T6JT))DFZKeQ?a7X=6#CGR[));-2OT^0f4
f<]YbGE^e/I-0T1bfRZ[(caV>JN>Z6?;ef?SJ,\9aYFJHUB,I9?Qe&U=I:(^?#92
78CJ^43V)@LH?P^:0=.4^<K9Z84XNeIV:a9GTbc?[YJ5HOZ9::cbb,\^aMfF6eWT
.=3Dd/8#5c27dDP?IH#-QSGGENTIBJ]JcC9MYV\geBZ\VA^C6C]KP[=c?X<^271^
_Nf84a1.X]T?+<ggYOfV:XbJIW(S>;B3bf<0D/]g(F5:A@S+9IO,F7&+.(;)9cLQ
>R+7HQS\CSb)_c:L.-R+d(R?DB(c&b_^3\+A(:fV#BTE?e@KWSG-+(Q;(WXVA8da
?dM+FQW6G2Wf36DQ5V\SNdSS#a23gd,+&A?H&1R:,1<)_OcML)^50C@&VT7fV6K4
Dc76=5J249]^A<YXLL2AGR4R7_.4\d-5Y(W2Ya08Rd=70]HCC:@R(7KE3_d-6FNH
[b\?;50>B+K?.Y@;4Ra@(,7J,IfYVDbF58HE??HPOTJRJ^aX1G[bA:g7B?(C(E/S
8CA9.J@fF)A;@K8V?G]B0^_=#X(g/RI#]eR)1F+KM[(9D[1/T(50N2O7)UMI5=J>
(THA]O.F/=Z87HV(g:Y9X(ATE<YT86NbNa57eYA_/cA>]bO0/)3I9@H?M[@_M/X4
06>/=:7;^AKYG#D4P\f)+#HU6]beY?&R2.TQH=H4RXR4GgdF6SHIU19M.U-QJ6@+
=),<LcP\4<>D3G8deXFe)SDV+QeOL2+3KUHNTK>^WIBGQ94O3R_F\TAf^eTY:HLX
R6,_?-L>?QaZK#c70QgX2+5=X(eg])I)?Z7-:?_RLB3c1^L)\2:2T//ge_4SN)1_
+LYd7L6KdbS@&]8.YKD(N,HKDD)M6=K80[9VF-H6d-Vg/eX-BLW+N(C],\fVWVW5
PJ43+0I4b3FMf#.b7Mf.YgX,eN40OP\JI:)^.P<_f4_<3Reg^3aJQ-I.9eg#X(=Q
f&T17?BO,,])#IfA;-Cb[g3+6\38@/)gaaX)E<BC/@@?=H50da34gL;F3R,Y^fAW
L:O+^LUWR.VfMb)BF(T3d7CNK000EVf&g^c3AC.#-#+2()CY;,T)28JOR[N[V&Zd
H#M4[9YNK5=2CO@Mg:)&:[Fd87CLaW+EaDf6F4MfL89afI[Dc]N[8g\0)GfB?)<2
)Q/d--d0-0#IdR2?0[U(-Bab9R;CEf5UNURBgFA@,+I/:Jf1;d_Q6?7=5eR^5L57
&-)L+XF-NH-8B:ZS27ZMbOA7[Y1Ib^IE)MG,K5bT&EaZS6NbPY?G?4_L3e3@NQ@6
WRbQ7ZT9._A1ALVD<0S1eM\FMY5.fH2&GZ(KfZL3#M,G]//Od1X,cI0;N>aWa^OT
O+T>4Xcge0W;,8D1>Wge7=9\M/ba>H/BF<B6SdFL(2AWCcS=CC3:JDWa^b]X_ND)
gT</&O[ZTE+HGYG6I+_LKTOX=4)&NCY1D-@b<gQDON5P(b#eX<NRUOPXge[]./Q(
1416RD9GbA0Xg;fW8EU_=:@9Ie,cB)dP[K#R;]16=Gf>_H7HA1Pd3LP?Q&ES@(]_
dF2+Uc=W:XP&46M]OdQ;^UQJNXAU(7-4[6_&3[HJ17:S>&\a]b8J=>U_B\GR5@e?
-_#ATNV#^PE/WER,C4?J):]d7<^a^(T-KXZ.Q2T&C;7@?P^ge&@:1X8T56@<6_aJ
>UdU8J^P:&b\46\>[+1/B+\RH#\[:47>1,TW[dCU=IRSEXHR2[(Ff48fb\ZNB+,A
9T6KZ0)6JM0SM6=[f?[7LfT?Oef?J;dOX1TJ5C7TV/&@[)]c<\24DO[;S;&H]>_J
3SPd6R_JZFUc^5^PbWXXXWI1[B&FS@MedS>3f9B^:@(aCAHHJU<a6.WK+VMQ&#^]
/eET8?HLYY:3DQ.g1KCPK[gd@aR.D2BN4:c#O9N9R6g;g4K=(1YMIB?D(&^5FZaO
4ed2NYH1gKF[3(\fG>3<bDbMe9I695_X,D)9OET]^63c/G](EdXTa/Jf,eg6KVa-
A0I;d841IX41U+c8dN,Ga]3g>7F7GC43R=#aFV+16.4KeND;.-/)<13UJ3W;UYAJ
3?aO0\EY;<752.<UMV&T=TKI9SE]:ZV\a9>WU4V&;7NSgYI[>C:QF78;^2f.YQ,,
C^c;gP:=.OK<CA@e&K&5J=^\N3E4bSRWCZM6>SJ7A2F09=K5b.12:U6Se7>XF(5U
XdIB-F2VQL6U[\E^O9B:05+PO\gG0ED/9?@27_g1(df,8UH6>#&)PKX07?(Q^W[U
#f46dYQ#L2RcP)WFMS)N9+QB(R92(()&U2Q)_KX=Z>F9-.AGHa1>P4JI1U]WI@UA
\CREP<CB@gTFdD=>#:5G;aVV]eXI?Hg6.K]I>eS1Aa19ZD:1dcR<c6&5FcLREgM4
S=..L?D6VD3A/<X:eT[\O493#\3J?R)N&8+.f(JV(M&<^>1_FE/C)5>Y6U2g0C#.
a1)af1\JgKeDQR\7Ye[J9)BUQ8@;B/Z2@G2g7B00-C60^(a?5NFFF-#7\TF)9JXP
>&K4cW/L/Lc1Ng/D#67IgLHG:UQ3T)[c<^PO,?13c_KRRdgB/V4)eXXSO]B<,KT5
Le[X]K@a>&;OaDJTW40];T=E;NN.Md3gMGK>5;>F?5?[?Q?Vf#8J)8GP._RI\Z28
S,>]M<;d>0-:T@8)b0G&)[X3S.E9^,<f7_\C@Q.6;PG=,3C.;+/A?H:D2b(.EGb0
)LZae70VJf8PFf-[0=N=HB?7&A0Fb@W#=?0a7J;G-_a6X;KEZ=9TFUKCW^KA]PUX
2<#M>UB8C+II0M1U;8;ad&Ybb2EV]QQRWG-dM/Yda_OLdI),76/R1-]?W_eZEb^e
Se2a:0>=B4Q7JAO@#0&J:;?4F?dZ&@\R?HV#10?-4S@a=L9NV7dF&D3M<OD(DNYV
J4EF]U.>d>KJ)2g2;PXLd[3DdJ>>b;gb>)e]H5,OIOS;1R6._>BP36K,Jb:dE.;&
V[bXf)cCe/7KB&?JC+<d^&+UUeXTDDE2;Ie.EBAgLSM[+3/2\IVTceTXDc=;#,f2
8)@+O0Xd]?I,?KMW_L]L&?A+d9[A=-BP(_XG:DMC?YEY,a;^5-LY5O(]3[Y_aZ//
6A/&J/9H<V63V1bDE@11QL;D-EdL9-MR>VGH:M9XKRLE3Y+1Gb-M6EGL.[5B9^9>
D+Q<GSS<g51N_N?AF\31dL)/OG4D8VF+,O=B\(\g]U#[Zaaf:KBe=2U>RO=+a8GD
-\[]/3UfI5).-:a<83D9&[e03_:b)/&A^&-SO&J:d92AF-_ZC+Wc_+D)=B5N<UW<
8Oc82fD6YV_>IW::f7I#?e#2O4fMdSLCSVN]/4_HQ7\L/XGbMeEF(96I\\d178P#
SGJg7R#W2JLW:]KNbeV(6QH@V3RT2160_5ZDb(:43R+[a0-#4AG\AV?L)DH78[WG
K&/,cYc.APU]E^V>bB-&9U>SEEF__C_cDGQ.cB+?]0?=8<C(GQcc=:9c8_Fcg0e4
ND=4=,dK:]VCBB^c61H)2/a;P0eA;67&C1MGeDG4IGLG[/g4-[3;JI2OBOE\@eJW
2Q^\#a6?=@D_Z-SWGH/LV;+DU1ca>[cWO7+8ac8QfZXE<ZPD6cKMb).[[IN49fc,
W^H=#>W>+;f8aY7,H&J\X[g0ZXW_4\Ng/Se_Zf^Bb[A&gcb5b(;#79;HD^UeG)8I
&T98F9T,B\(gV;7.HP_;/-Z5@IU7PRF:^N7200bfDge2G#2)-=N.5/^QEZ21Ga(W
L0+#8N-DP1N3AZ[C]]ZbTN_>Wa]O1Q,UFIIfNSC]#O&JR?]2c_35V^^7H,XP4P+)
TLJ_fO:559K=-Q++F7J([@GR7T56]b<>dP.WD;cYd@4N?,ZbUITJgT_KB0Z?SNBP
DbV-3?/H?e9c3?(T#)\M90HXgS^L<+3/&&^__\G81?LIGJ9_M(#5[:LV0MGPBbD>
ad^[9\OXNK008?]E8H82#@U@K3M>CRZ1VRYF_=#V>>=Mg2I<LL)7#WW@U8BVV=,2
?.7/W>/+Sc=M<35H.OVV/=:g81_;<Mdd=aYYC@KT6:d0Q@<\D\5Ka.2H]<IY.#:7
@WTPH8=NG?)@-Tc].@D:)f888A-2-\8,^_8.W/2)MfB[a<_YCU;-I8FRE:PHc2LT
a3;LZN^8AL_@C9-3X:6,H6JT>M+<K6L3H56/.9MQ6f3Fc5e721adfD^H;N)#Y;3J
)2)K+T^HOc4cZ/[_U.9H\fQL>X5X1N)Db^/;P:X[S.(g.?ZB7dEa;g=eT5Y5c16)
1SAAg>/D#J90cL2UBT4LQTB@X>UU3SAJGK?U&J?4^>-<c0c)QH5F=]-6EN69R=.1
Z^(&53M\f52T(fd4A?(fQUa-a33,ad>J>E\#T])N:O[geDHecf8Y)a/^Re8TU>MM
_ZRe16Cb++7I3OfA;SK]QBBg)g)/7A10_303RJ-NTREPBC93AC11[L[9@Hg3J-7Z
C5=)\<@fG[(KV45(>F0K3D,AJb=eSc72/2::A]Zf];D+Le@9@b0.SHBKCK+]A&H)
_SVg4?4TWUO(>TXc_4[Rb\NDVQHVcgR1KF-F&1Dee_-PbX<AD+L\GVLPA)?D\__c
RMc_fN;G72V[f]BU_#c1T(fT[N67eH8;0\U&MH_g/YRZ?(E3dbZ#5D:IZ8f;e_8?
3TRe>L=_fD0O/=H9_\IC;ReN2&1?R,JGS&f09U3dOUTFMX[Ob98FP16UO=SBg)<>
F#BMWXB1DY7IXbaORMa,U1QO+ZM,CF=+8GGP)=d_24SgF;K>C13D[+e]@#AB1VG7
@91X.0f,cI0bM+@4\(?07J9]MOeJKAWMT02gVXY5P18FJgNY^9a@9>-+AEQ1]c(F
e)^d(WQYE-CE1Y-(.<d?MWe@UC=68S@cF(abVHN3J).UR8TAX^9]DJ7>cY-,(/:]
f)e^H2W0MA1H8.1A3=g1PH[)eJ[WES<95(QbA/JGgKS&_031@&CD>)TO:B-/g(-H
:I5;##1\L.c@efM7S2B9G/U:RdONMYCPI&YBfb+P^RePH+SYW:RK)_+9@d+@.1;2
J[cA5b?0+W21+&=,^5M\?6Sa\M86&,0IY7G]I>-@LS/R7M6I><SYN/\\&3T9.P5[
:JC\X5JIN4=?L?Na[]V)b(@B?XB(B]MNeaF&ZM5#6M1I<R;B;)WH6\JQa=a(6UI=
.&7\39cNJ_<gX]CC1W4Lf#L=L6bMLNKD_CVKdXOTCC+I+XJGN)R4ANM(IVEIU9DB
PafQad\aP.e&eHf/46ROF0ZC/81?:A.#R6X(^]V+@C0;D0(_+<S.aR+]aB#<3F3Y
HdIZZU&d#-WXW&=[7RZF^KB\MAY<6,e8fJG26F79&<8OC/6f.J5).f-1-fOFI02V
I?9[AcR.?\D6CY#NYc;)BGIYf]OU=)]b@QUMC@d=IZ=,HSJ;CJ7EFLNACDQ3:aaB
J@-RN:5g7Q/g]Wd8dAQ\7L@ac7GER59YZCFU0GH;N=F3?51#SFdgXC3.W5DEe,eI
HN47=>UQV\;>)PWY8]T)RGTg6gg2EW/_\90Af][/Of6@,G1Q_Q+V])0_.Te@fH^V
2>c)&b1::XY#H2@Q[C=?QRdO2?I(ILM1A<I0:NS#N37TO4C84MO1M_5NHHO4DD1J
_8f9H4dYJFYd)7Tg8-,CZ#^fWRf=6N[DR+_VXd618.]dEBP/7WKDZ25<@<_;Z[[V
87[3SLIEO<G4T89=0O9^U+IQ+CV+DX(RFPcW.X=_##BBX3?>U=_^VV[.-E8M,^a4
]]O[-eF-EM3a<T[RLV9E5=104:<CR(L73&[V;cSU97?g5\DRAEQ#B00d:Y?_5E4H
fSC1PM5beI4a,NcX+aIOFOcU=EeJaG\RFP=^/bVX2I5&53UMFVT&EER5IZ4J=g+T
c<^SaH7R&C_bQJ6=K\)E1QI6;DP0,cLYCSO^U:MP-V?1>WD2&?1EfP\>UXY5H7:7
_H;5J6@D5FHI#edb_g9XUaQ\I6K;ABS0fca1C8\LJ2[&\I9?<>PR=1Hb?6,_:@T,
W,Z:T7X5Vg0G;&W3L_IHM4C<]7VJW465L/-PMe71>BFL;1cL-]S:d=f)&DH(4#Q]
P.\>)X-Lf4<@WKLKdYV:D:)5ITdQ^X(]5d5Aa[JY,\EggIg(b3<7E)V?:6\Ee73D
B=;I]65^aRJ40(HCSWX\\aF8L>KAQ@4a2_MU\W_<QN0AeYOf=#@QgLSXM[AP&<C(
\Z5?V-69PS1Yf)G2//=+2_DR57fB;GOe[Kg;[#CbeATM@^WYC<_?K6_82Y#Z@P@]
M\dD.ARBQKO4Jc=[F6:[G_CM^DWN(N>ZOXOBMKE1@2II/M/]9(C+ObBYBLXCBPFU
;@B;BR-_C:>eL>/^/338B^(O=IKQXZO-KN;@d/CJD4)&?9bUc]5R&\2(P]N]Q)Kd
T?)2/:,UB<R5<?M?3>0bIfVIOOP=D4:a&ef/UGd:PQE1eDSX:]HCA?M;6=V;>O[8
f+aEdZY+XED_J-+)TGdb6W,]8&fN\4G<?A8.f]+ONg+bfBOI\Ca8eFY2MGJLYf0O
S_]4/\[CH>BX_<XSA?#4U\8W;b_(c>X^TefC3VY</ce^X@:7L?DL2PW_SSO8ILPG
W]ecMH#4e3a;>1C);c1&(J(:D<@5RS0-&K1#2X8QGcMPT[+b>+J737bg_d8>50dZ
YZSA>E1EQ[;1#.(2FB+WOB]39\6;3UN+aXB5TGR_TVVgAg-W,H[A_0C1Z^,<#VW:
(U58acHC7H6b@e4AJ]Td4O1:QH#I97_Cg)8b[>VYXBR(.:4(P4>e26[]C_>B\AO8
A2&+A^CO1+CRQX,Q[H,/E?QPI>U^?2f[9FTBZSF^c]_3^2/)c6HAJUT_NbR_dM_Y
aM8PP&dOL#N6ZKK^T.(/c1A_aMP&BH9A74Jf1.IebSZHU0f?^(QSTQ)P?gg6;,VU
d8>TSS)e3\_R\J[.99O;]-4<2)]@c63UQ38WBH@f9DS\[eF<fS(+<U>.5SW#D@FF
U3SOOG6XOg[JWZ_[PF5N6D&d6B184JRBX@#OX,@=)YXO^K:/Y]Zg2KKMf<L+1bL5
E,E7Z;P4_2g#43VbMeSS+,73>/HSP6eB=]+A59b.;9I07R0EPF?RAIVeZ_R?PJOQ
&H]B8)03B,eZL[-?_K)8F_],8;0?Q?25L=PIB[NM)7N(R<3+@0<BC-D^0YHV;B.E
U-B,5+N(S-+N9.aN_Z1Va-JB&cJS\9D4TW:3HW<C7,L+\0Q\63F<]+KN2UUW/Z0G
QA#W/G&d3FV8PKZ]3H;BCFc;6aY9E)USE0<E?SSE87A+SLaQFCFEcE>]3J+XTd\e
\(I3M7(+D5GZ0P7)AA:=&Df5UEHU2D_\?I.]E466WG-7TQ;c2)aHD82__^<eDb+H
XPKc7<5R_38:#d<9;8WcHE7\U?c[DNU-cK&B6]E:2&8IM24ZS=TYLDcV>eZ).<4<
0<+c)?8@/[WMHHWZP/3NX5BA^.TUQ:JW]3_V?&8YT)V;[NXC#B6:UX08;X>H.[ZS
Z^bR]_5YN/]D:<=TRV?CTNAU68C=d5c1;c[NSUV?23LT+\cZ#?TJ0beM:-1f2a1_
VG0SIB(a0KX:T75+_I,^T)A(49=2aBF;&RV<X@+g5BgdDCKXV6Ie(?.Ke5-+VAC0
T^P?@LA41Hd9UXS3-+X?;XYD+bO7)9P52YGRcJ.4GC@W-Y+;-?ce?bf7-E:/bf:a
Nff_\ZX5QD8Gc)Y8f+:G-&TR;XNIRB8c9fWf.K84:Nb).^[&/bYdgTP>=:Tb__f,
/5IcP#ML;gKAJCN4ETLL()a12N385A?G=Q7@ROC0K0ERG8.7B=g@\.aC34/F/57,
;[H2\J2/9a,>97X+4+2GfU]9IeJ^Y3]g^&FaDD(@9F@(+I3(+H_B.5.:X_NbGO9-S$
`endprotected

`protected
L#QG<242<Y&D&I7U,a)R8g]53X<c[7.cCf@7K3,(.7=6aeN0aH+C0)O:M<G:4eF.
PE?G?09E49(D,$
`endprotected

//vcs_lic_vip_protect
  `protected
CcegV_@#dS6_47Mbg6\RDPVOZcaT;fG;H7ZZ>HW8@Nd&a5e3.a-\.(0aP8>VFceC
)aW^_BB51G&2Te:(&+ST)>;EDF-bYK7JD,INb<bgc3<C7BWF,PY6A#D4,8&&\,IL
GL:^EC:XcX00[WbeF<7L,=I/0H/8ZY^eP7>.JUg-\&=]gR835WSe_af9PbIL))LB
,?E\=?;WP#I\6I>W&@ICS8-^-/IGND.2T07?\0f3M9#R#7b=8(eBRUX&)=<E<dG]
RYJV;2/Ya62@7#:Cf0-E\[63XL9FV19ZLLZ/Z[:^/UH[NRZ74XX&VP\:9T?EN0S3
c?CYTA:B?R@N/Qd@CWaKaSHEJaAD,,FcPFV#EECOc^PXT+g,0H?.=9V^X,fVO4ED
J#cSE&X0PPe5.++9>P9+D2H),4&SYS>T+[f1;@:]\CRc3PK9@LAI:6GU&VBDNG=J
/L(?RXbVT+A@)^1S/9@eP=-]\dW2]JdMCg.)=a^[.62S>FJAUFM>0HMXOB<Q;O.b
ZVMf#GV3V2CF8_XBE+GV4F8b]A<?)FV;/fXI4aTU3<WdKZXQ&AP1GVM@TPFCMc1\
VE/ZHGKXP5IR#CR,82715DG.+?\>PdW_:Z^gL9[1U>7IaNXK13LPF2Ag0NN9,36&
c>b[9:0\L6(ZUIJGDK3d2fC&]E3GA3;CB+a<>J1R4J?7FA/3DR9T2X^6?1T(d]Tb
>M1OdQ]HDSJ<6P-^ZbCJS,LEgF(DS]:Y]UR-C43F4@MW#?ga95G\Q;:YaB,-5H:^
1AH/3X+0J=V_(d251R_+QXaA<[5Qfa5Q>5\G)GLM)X6N1.7+aXK(SW0,53YRWM2)
eMb#9>7eL&)cN>V58L=;E:_J^1WbdCQE:[a:W,b\7<__YFEZ=W0d<2D6V2+gVWSG
@4PU+U?4N&XNG4\3Cg^Q=TeWU31/aN0)c?-7ME^3HSKL5db5\X<?&91^-&@[F93:
JD7;C4Q&STZWeW#Z9CZ]^KZ7;\8R;ZHg?0;#>X\be1J17.,K^g?GDMaB8:(:1f@V
4BQf727aQ+T@:PMUfe^+D:GKBDC1F&B9\A9YW/#/1eU\LQgG\L6^RRZ<+2(>P<X/
;X..(DU[SIaRH@&);7-D[fXNQbP=&]6N1W0DX9DUAeO)/P0HYd1HCf[?\cLJ\+V@
M8J0Q?HcaI1W<@TYbG-WC8>\b\.0[/SC=J3XIF#5,)VcG-T1AaYe(=0TXT)=0Cc-
#gKA.?52]:VS\F;AY]</&?P/b>HC:#O=@ATd:f#@ZBY,VR])U>,9TDS@P:J1M_)^
:S=^g8H9TMXN78O4[#BFgeTCgH2DP2/EdPL:&S^8=?eF@ZYaLcGX[6:.,W@TKf8F
^>g,Y12/##FJJ9e_&)KZO7A/#E)N(#ILT0&&ECLd.C+;N6X#^E+9[\E]&DaMU^5:
7C/_<OZ396Q(H-fEe&)QC4dV+,0(U<P6]A1:S4&;@6;.1);;)J\E?@b4f7YCU-G#
JAJM13K:29R,c(B@U+d8]-DS&<(7]Z@85IgVWQJM:K,[K42K=./2^RP&RJG/>>8F
F5<aSWaS0I\X-PeQ:dND1aT>35W<LXYg5NC-I0HP_GfEC<^LV=4R+d]K7)].Q]FN
=Ma<+45&B_:U+-AY7X6N2gH6?C80D)P:U<bDSgW7^8SCC3,Be04#90DU>;>ICV6\
]^(5Qfg<76_EWW8Rb\>&&79Q./KQAbN<8HLfb#IZPQ&W3=E:=1F+?D>89&6&M92;
T^,N22g5H&)a=2=&/&\8&OEcA[[b8gNS+?F\8-2Q_,6JEC=7>4<?bL,PfQ<,<aS<
1(5X)YI=dI,QL^f6::5.>5@K1TcQBD=R:$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_AGENT_SV

