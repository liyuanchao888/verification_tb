
`ifndef GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV
`define GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV

typedef class svt_axi_system_configuration;

`protected
)Q<G33aVW@bH;9ZNWUTR4cK_7c\g_a]Za[S#6B\1TFd)eJ9&BX(e-).#W(ZLASU0
OW&\_:C][)75a42DgMCPB\U;IS4,[=(\_R1XbggJW)K?3FK;J99_?)RO&:CLe:_>
\@d6-LO&g?H/.GKX/LS:F,0=9^O_<+@QW-@/dWO+7d#FLF1,=bGUeaN4/=TDC2PC
UdT6H0LD<dg=NeV7_F4GJP=ZU6E:(Vd1#W(AC(V[H(e,R]JdgQe2#@L0:O?(INL/
KfP_]F0M4O?1LCfSZ?@(fV,ZQP2>])L4TKT;M.N+.g^b.RZX.(Q>:<+K_e+&HKgT
a]fa4&&SI=+I[#fH85@;;F<8eXAL0aXQ1)eO24XU^P/7FNf/e=EL>,YCb8BO(XT@
^@JOC0;c-HXMg6G=_0Q:gIVbeM5@MFW6QGK&RVET_>MALV4,;@E,aH\c0K#59[N1
:WT_ZQLQX])bODc^9Z9NV:[6b[aZVK/P)S3b7O(Ca#Y^E-5/fdSP>?a)V?>7a^5C
g8d76HXOPLD6ZMO7J>;d=+eDLX]YUO>SYNSb+<X)_.d@PKT\+L>3X9>S-2KcCYbK
M_/2/6b(QL19;#@FFQ7f#F9^5)CMTa&ePb?C[A\0H[4MVG<SB6RSPS#XY7V8I2Z<
)7:D4GKF5#-eA(feO9/2[A?UTS,:I#(2?9-_W#RGcMVZ17fPbMMM\ad];VX,1O=1
_,PX4=VgRZU6DZ@BfLbYEec;0[]?IA5:C@@F]4NA7^OBC)VPSBVBVE=BK&LDgZE?
V,#E,9O8Ic&<2.ffE-d@Hc<f1<P8OL;.G0\?@(NFf=.Y3Hf-^WR=UV@M#R_JKbCD
3gE&.I4JZ)Z[7XEURRC]-O3>7J=L0OA7E2FL1C_bSHM0\TVCUG053:,23.3GM4E.
-Zg:NHDU:[9[.$
`endprotected


/**
    Port configuration class contains configuration information which is
    applicable to individual AXI low power master interface in the system.
    Some of the important information provided by port configuration class is:
    - Active/Passive mode of the low power component 
    - Enable/disable protocol checks 
    - Port configuration contains the virtual interface for the port
    .
  */
class svt_axi_lp_port_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual AXI low power interface */
`ifndef __SVDOC__
  typedef virtual svt_axi_lp_if AXI_LP_IF;
`endif // __SVDOC__

/**
    * Enumerated type to specify the initiator of low power handshake. 
    */
  typedef enum  {
    PERIPHERAL=0, 
    CLOCK_CONTROLLER=1,
    BOTH=2 //Don't care 
  } lp_initiator_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifndef __SVDOC__
  /** Port interface */
  AXI_LP_IF lp_if;
`endif

  /** 
    * Handle to system configuration
    */
  svt_axi_system_configuration sys_cfg;

  /** 
    * Handle to system configuration
    */
  lp_initiator_type_enum lp_initiator_type;

  /** 
    * A unique ID assigned to the axi low power port corresponding
    * to this port configuration.
    */ 
  int port_id;

  /** 
    * Indicates the active/passive mode of the agent. 
    * Only passive mode is supported currently.
    */ 
  bit is_active=0;

  /**
    * A timer starts as soon as cactive assertion is observed and keeps
    * incrementing until csysreq is asserted.
    * If set to 0, the timer is not started
    */
  real lp_entry_active_req_watchdog_timeout = 0; 

  /**
    * A timer starts as soon as csysreq assertion is observed and keeps
    * incrementing until csysack is asserted.
    * If set to 0, the timer is not started
    */
  real lp_entry_req_ack_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as cactive deassertion is observed and keeps
    * incrementing until csysreq is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_prp_active_req_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as csysreq deassertion is observed and keeps
    * incrementing until csysack is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_prp_req_ack_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as csysreq deassertion is observed and keeps
    * incrementing until cactive is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_ctrl_req_active_watchdog_timeout = 0; 
  
  /**
    * A timer starts as soon as cactive deassertion is observed and keeps
    * incrementing until csysack is deasserted.
    * If set to 0, the timer is not started
    */
  real lp_exit_ctrl_active_ack_watchdog_timeout = 0; 

  /**
    * A timer that specifies the max time difference between 
    * deassertion of cactive and starting of clock.
    */
  real lp_exit_prp_active_clk_delay; 
  
  /**
    * A timer that specifies the max time difference between 
    * deassertion of csysreq and starting of clock.
    */
  real lp_exit_ctrl_req_clk_delay; 

  /**
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    */
  bit protocol_checks_enable = 1;

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_axi_lp_port_configuration", AXI_LP_IF lp_if=null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_axi_lp_port_configuration", AXI_LP_IF lp_if=null);
`else
`svt_vmm_data_new(svt_axi_lp_port_configuration)
  extern function new (vmm_log log = null, AXI_LP_IF lp_if=null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_lp_port_configuration)
    `svt_field_object  (sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
      
  `svt_data_member_end(svt_axi_lp_port_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

   /**
   * Assigns a master low power interface to this configuration.
   *
   * @param lp_if Interface for the AXI LP Port
   */
  extern function void set_lp_if(AXI_LP_IF lp_if);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(uvm_object rhs);

`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the OVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(ovm_object rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif
  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */
  extern virtual function svt_pattern do_allocate_pattern();
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
    * Does basic validation of the object contents.
    */
  extern virtual function bit do_is_valid ( bit silent = 1,int kind = RELEVANT);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI LP SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI LP SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI LP SVT
   * suite. This is checked against OVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI LP SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif

  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum value for range check done do_is_valid().
   * The max value will either be the MAX macro value or parameter value if 
   * paramterized interface is used.
   */
  extern virtual function int get_max_val(string width_name = "empty");

/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_lp_port_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------
/**
Utility method definition for the svt_axi_lp_port_configuration class
*/

`protected
W+f;8+5#a&KD52V8+;5+G>H3;<B(PC\.Q:[#b^FM&g;?//[UD6>@,)aZ:>4e.BJE
A3cZI16;LL/4O)?DHS;L=6MfOU;KFYAfW(UF@0P@ADCG[17S1UKF,,544GUg08QW
5J/AgEb^J93-H@RPbRR,a6Ua8X66_c[K=?65^B(WSX\>G]e_<Dc9VfJORJ.S^Q,1
K8J,X1d\W:R(F0=RF>>Zda5_T:.9NNS+Wc4E88;,dWe;4#DL3LC(_26T(-07dZb)
6UF:Va>_bbgO176HRWRTMBB&SKdG#\(gMa(D>;6?)+Q9#UC[]EU>=>V6(U0-eGZO
Q13I[.PRH<O3E\\g(SF9\ZN89F3MI<JR5]+#3.(6=aBe50V^6UA-W^XHQ#N8N7<S
L;0_Nfd]26VM@@_[c.8.O1/6U06&eL69;A5XXX,WEMO+O@>RdU1X3VFWFWN07e-1
(Q5ZHB8Y&^+_f)=18QFWb#O^b79R(UBK7[P81[5E@NFWR25,EXVfg05b_&6g:)CG
0JW-?SKJE/d;;H4NDZ^TI#3fd3.MWZe4]ggR_)B90BKQ/YRAFZ7)dVC_W]O<Z0O0
<;KZLa37WU7YX8a<#BX#g7F;6Z?bcSV?H.,e:gKgW00S->?D[.D7?b2;Ve088&@&
]Mg3b,PL=FGg6&[ZB?e<L@/5X(caCb8E7+S9MNGZ0))g&9(-<5V2Q9YdGc]U@>8U
PWGNL3fOMB,DRUaF9?eb5ZAd-CR#-Y<)&8&XUT.3&+3:W2);6LE;_fG5S4TO.Xe7
dELS(d>RgRd^4ZGE-#UQMTUZ^X@fgQ2^M>8\>Q@7DY82I9I@LKgR[N5PHXC+\cQg
N2Y53(OcC&C(E,@&b]#K#RW.V4b/S0QbJ94?+]8Z>X4,?\H9a5PU]^?17?TF[DZb
7U(>/)eV2&)K)E>)?8^4N6/=PY12H^(.@Mc0O[a6d1[?RYZLB;ff>]?I0e0ER<B?
A)AF(J[g-^+&N@O)E0E3<@LP:g?:K5\7NP,XbMgSS08X999QZFY^.(?IJ$
`endprotected


//vcs_vip_protect
`protected
1OYZLC7<NP0F,K@d[0>ba=8@[+c/7/)(K_?4B]XUO:U.Df:V_?2H3(.PU45f(/J6
Y3(&2d;1MX4#UNQB4\Z>dVe<88_+W_c3YLEG7#b,#VAOeS,)5caF/\a5bId(8R1.
MUM..5J6gZ[T=0?.(.#B7J)=T;FH#TUBUVYZR];/^I1<8Tb[].LL22=XC/dZT,+H
,2Qe9TH-d2J@T<(dM/QR+O[3054Hb.B7g#HcYIe3&V+VgL/cQ-&_f0-PT]/[I:EB
;LGI-J;c[Db>ZNG.G0BS^&J;gA;<feF#,6\3)E\ARf/C/GK94_5fe:VXBF+4>:RQ
4?->H)<2)T)bXUZV>WB1QG6]Wf0Nb?Ne\:_\Ua6=(OgJcQfPd/DQSFcYE3]C6M7+
Ld^H5C).VQ+?^@9(H_?;AE4@,:1LIQ8Z3_0\&Z-Z]P,-d]_df&[@5bNc3bTHQ?T@
61_gW==9:C=\\2YSY)E#U&&Ide/-.UFf/MDK(N&],+[8;aP6MYTGQ/@9@-1C6C+-
TG2cR9&8:>H5U=eXc)WN13/K<a8==53\U_HWb:e,&9eC.aa535G6BaccM(5eRWHK
@]ggdV.)-&fDLcFJ/>];/E)U#N-T&e42aU@dBK_1I;O(P-a.-dL(-Q@8(D_.&HLU
[^-AV+NAK>C8Qa<:fUeC?CU9G8@(VS[WeaPL#J6/0>HOcaB<^(:b:DM/R5D:WfEJ
0_[V:Gg0(Vb@L8Y.N:U40C(@:;0?/,0:1B..U.8,/H523U-JEED3X&D51GFW@8^A
8=,Va73:f8#^(cRE[?BTcK#IPX6B>#9#YA2FTB6XEg8L?\^D0\T\cF[DFBL9&0^e
T;ebE_--\46L2.;BO9b9=-fKEM[AC0<IYJ15Sc24#6J(?JaEZ=gRQ_MPEV\SK8#8
.F662a>2-)DN+CTM(Z\d2.FVOM&NY.bd9egOF9^PR:X991FV51d,^#^ZV(Fc3C0:
I\//\_-7OQ^9UcS\gIcg:/;[;S&I5ASU;=:G.MB@^+O8?6T,A:Z9?CU]+&6&_:CW
][d,?KGURgbR>7#@7YXKQRKg^Z2G-d.?T>MM;dU(I3-acC>_30aTRX1>0WABEWb\
:_MR.;GgMC;2aNHaHQ8)JV7ONe=0XYBP@cb2#1R,PKGO\3aTJQZ3-2BU8Uc8N.J#
3INZ+I9eV;L[S>,9)fa7g0OJ^IUd#0XJ1P7/N1;EH:=IXE,5-NZa_6L8F]T69[E0
WEaHL(^FfMH>T=(:(a.e^g+M8OdP[:BCOAU97LbYD]gJK?>2gcI=-gU\)#Y@^\A9
J\J9gLE]fK#:?/.YY6]1TZI<&@-(^f-<6MCI>SO<d_fGARd:R:LcG)@?K+XWf-ZV
:T,)BU8]f87]U,C_M.F\QC4MMH_YFYYGb+8J\2]2QRgIg,-Tg2DY1[/6gI(3(_[/
^14>UKW;GgJ<0V@S;fEaR1H-J^,dU2&E(Y(cQNSI/a-f0(&Q^;9>C4Y06L=_a^AO
\\#TgY2eYU9dB_S.^YNcA99?9B.RaAa]dI40W9cZ5Oc;7PS^8NXBc2gH.ZbAIf[D
:7/(F@=^6ZGN?3d@WCLQ7cCS3K;:JX(5c6)RN#E.QdXZcH,CW(=M(?d44-=WV<&X
7U:.a/Z:D:;54XW2)UK+eVf0_N8&U?G@Vd,/D]2Jc]>]DcG&=EDH5de@I;:U9c[2
SPFSHB+P=A8d(CYUB49^H(Nf<dP4G@MfaVD0H1SY&2Y(La>HVg_E7_OAZeR[_4J>
e2e,/]N9Z)g[@J7(<51)O)2,A#<=)FE/8H?F,LaP287&>+>,5a9F/:P:MBV&?6a?
]V^#[Hf&c6QY1d3?E[1:LFS;KMTZY#Q[&M;A;M6Y\.2CGaU01T7a.+M^W-?@I30K
8_(McM.XWc0RYJ4D_3#8NCUBRIF;B79-UR/ca3)?<]LM-/22C=W1]Y;@C]M:K,#R
;F]aC.\56KD<G0W/3e1dHOa1VST,?,OR\GaM_],SY+Z:P>.94d0+2YZ?)CWV<)^Q
bY42@<Y]T<](b]>,N]0OFWgTOa>PeMQ\-dY7@PD/+B)YS44)@21Z8,2?;@U:U#P<
\<DZ@f03d#)G0U0\AZ#SbFJDdEL5]g@]()3Ybg]#PbcB)B?eFA9,AL4V@=S\11?;
.>^LM6;B9C_H9e,;bCYg@D^;LWW/,RK@:R\C=]H.5<.cbKKW/2TV3DT^aVT+(9J@
f0=Y3aOEQCCMO(^P/PFK97)ZCZ9I[W)-=_Z9aSdcY(#<EJ2D]7?R0fT]8Vc<U<?Y
<D,_<G81T=L^25=+g9g\==6ORK95Z15TcW0+A.fT(PW4MM69Y?U[^2[>dDNGMRU>
0aG-d7KA\K3FN1+A4,]4Z[9bH=CP\K>1G_V?ZR<<35WOWU&eaGHd;P&#-_Wf3M)\
K.H,4YWCe@/437Of^2YcRH8V+3M+G)R#EGY;G)R9SYbUMWV62IZJG08L&W[.Od64
]G2)HWXc?Wa;/:adOPdBN..,#g3ECN64+MLT>FRAL5K,+F>)]T^JeNSJS-Z.^cML
;#;V(8-@8WM4.4g\SX2TbS1R;F3?_Z@QM7.4F;&KXMP.EV(X0Q@Lf:?ZESMbG&KT
T(\,52N#9(XOKJF#PZ11RU\USW\;&H:5=11L-723][?8<)M/W,3<5G?C2^E)eYeA
),EQV\>HQ[]Z[D00I(+F/Q:UXD4.:;RB</2CB,^9R2gS(JVX-K+ON6[O+D=aEE^6
OPF<EC][XX5_JJ=V#1GgC^J22Fe9a?<DY\[(B3YFT^\7e#cVFc#>F\+<[DJSS:5:
O0N_F+4&912A]bUeJ;V-=;:W3ID,EPS9/)#d,/<JEF>;gNHK)I4\7RHTdU<6_Yg9
A;14.56U:>8DFfBSY7J&H?G87C#d2?5\U0\@S,9];GS1@]<N(?-#C#b@;8E_WEJR
,UN\&D[O;Sa\H<>E1(CYAXY??5.g8DSG4-gAHG^9.+ARZ[A@=5F24C=T8_DF?L]Z
4.#6;<7HbAAQ?]20GDDaaG18Z[,=3S9G_O)1?O.Kb^.Hf+-Z)Ua(HF@4Z.=-XL7D
T3..8RSMD=.T]JK:7g1&L]Ne:fU0@#7AG73cE\SFEb,e0a2UdO\FM)8E=<.c,ZC\
63=COC_cL=1T,LeCZR4L2U&g810SB:T&QF1F9]RR^\.Sf597cZUb@D[_c:@A/)CA
+W/)L)#8adE7S;,V:V_c^,+N&C6gE9A8574@X><7E6.Udcc+M+&AM=<IJ,P,C84I
#CTZ#6<ZeUf]&56aV.Xfg7NZH(X3TY3TK]?S61?]@GZfSg&b)d88(0<SQ5#1Zfb_
dJU:IRB(][BM0^L^G)WJ8AE+XW.+?)Md018@e=:;L22.O2Z#aS?&C?WWYK@OG9,Y
UQ<>F)S:A2Ggg#?9)WG=J&FR-0NXe1X+?.af]aG1]c+H5:;C9=,/<HdG#Eg9,<<K
)<W(&-c&GVKa]eP.[bUOA4D-GXQOQa3L1HZ#U0S#,<2TZ@8f?BZ,P3/D.(&_]9N;
_0Md_2:?f.;<[QIF3QB-bc(>G]YWF;&MZ:6?\ABb^gcR]@1<aH#)SC@Gf01QLf(X
f12Y)HREGc=#27d<7](7QCA>-NSYT8ee[W=J(?@gWdM^.^,QV?H-/7(,89b3Cfcc
CY;9_7XP-F>K2L8&+17dSG\:BC-0K652A21J8TD4//ZEV\\<-Z<GU-(>,)1deA4P
;K-KP,;/a#YHO\2V^79NP^9;A/,=7+:-fV;WE3Q)H4@Hg8>YR9FG]&WdV&PX4\5O
LZ;WVMNcQgSI?<b;ZEO:#\4D_7X(+5W&J(H11f@KYa@6P4d(.G+>V=[\2B<Y)VfI
Pb>5JF,/\bG7?5&W5ZOA00E^;Z5&\K.YO<5M9^1MR>eGSPX9F=Q>BMKcJI;]XR<\
_d]LIS9>&Pd,9---H.S<fW\WNV8Z]QO-T4D:URYRAR,OFT#H.Hb(@R4-^)R5,)9@
H:HHfBe7R7>8QN[9gK^A@KB28.&,RY&=X?_aGU1]&A3Y=WUII2ZJ)DbRO]aN6c9Z
QMPL&XYV))DU?g9U430Rf^Qf6cGMC(R^[^1f/<Bc:;\A.cH.0<@ZELH<YD\RV0ZB
C-O]C_C2gZ-Q\Ab;B_E^DAWVfBYbH^KaF9&NI?Y7dF^H[aOLI=[.5U7U#1)PHc5F
gBJ3@?X0ZS.@2b6M#+dXG4Y?.#L.P:X)\S=+7DIQ6.6:F35[5Q2W(2,e4AG0OY_6
c1Uf4]2HZW)aPe08H819a(-),MYIa0ZbZQIU?R:JV.b\)U#L@+P(5C+0U+ZHOSdf
GJ;QV?07-Lb^1^?_,#@6c<KFOR-HDc_5+FLeF7.MTGHLLDPBI2F2\2gXU#XVKQB#
LgAO:[fR.DFa\>Yd5P6-<&[)7D]=+1UMU1\dUK(AYZ<]=F]c-+P^VPTWW(?[0DP6
U?^QeGFEL9HKcU7TeBbdS5;\UDZFfYAedS<V/)I->V+:&7eR(HJa_(IQ^#dZH[G;
#@K66UW3/?14([;99Wd?0YS+81SD[Te>_D_3[SKB#W#a[1Q^7G:6Ad?/I=H:,S>X
:#4D:JJKV9;VVW=He5]DV004V9K)[>A]]?dT))1:HQO5/\XW&Q6V2HA)JRVNLI@B
>]ZDQ&/=B^>(V.U=U4bKN@X;DEGHSHYg4UG?+[SKe64Z+1RggRG=Jf,A.-DcNX=5
\TM;:E_JW.bVIUYc:HH4E_Y#A=ZJ85FT<T(c&g+RLZP4)b<8ZEOd8BATH:6S2Z.d
#F<\ASb,aWE&14)B/>Y;gXJ6[A#:SdbT7TVP\:]=1U6??@V#J7F+^@G8>f\7^CY2
f67L4fSY\O^MdW?O-b57[W6#>@27-1WKM=OB<&cOE<FUW/IG^fbBUJB]F)TVCMMR
3R9=^1W@YD(A.XQ8RDb04AT.@.-b7:?]:f4_Zb:Y]M+[ZXC.=Q8g425RH2R^<AM(
LP7R0a;01g#F#F2e<V8@\.6P.Qd33R;L-9I659FV<S@aHR.&S@A;K+3b6NBM[Y0e
^N(]^aIGZ6D@b)_TRP-d:OcYT5C>Pb/=g.FHRTVD9(&M2>1&f73S5)45e@8NJ]9A
bXdeEJO]D7#fM=dJPO-B,FL3-CJHJVL./NZ2YR2da&]X9>bWG.fBb-+C9;=,[2JQ
GRfeU-]Z;<LT3C>5Tf;YKY1_TW)+K\-ORGd2J9KHaGJ>1b]I+BO6g7_][8C),LN\
>,.\Q1>PIZSG9@(dLX-V9CFX)a1\I8=@#8YU#>]L=-SA]YV6@GdB-W:(U+[55[&:
,.D:D)#Ue/WGa3P>D(EZR&DGE5Re-R2YZMf4/F,[KOBg-3MQ9M)-ZaBH5dfCW:00
<&8\GAUNDPYg<]YgL\6[cVNP2CUX=N-bRTM#d5.fRLU:VM)FY):7aRWHaJ[1VUN6
YN<SB@A(@RDf)2KP_)&YZITc&NcMU<g)=^<BL]bX3:[2>WMga;Le<fB6)C2c/X>d
XN?ZcL>OU:fGX(41geILO:F>X>896AS]I\M]7V+[:_.=c#;-FJP+4.Ra]0d2F;]7
2PT2aa6,g0@.SUdfbQC:[&YK=87YX<O&g&AZ7#YWaPI@P,c]X(1I6g2U4>MGaabJ
V5#;0U7ca?T7K@D++LV\UH_[dPK^IH>a31X#NB:X68-RE7[S1Z?aS&E6A>=J+HY;
_K_2QZ3U6Q8.^1V.\Z;_)YU-IC\bcfa#c(WGAaL^S1YKCZY/;VS.&0=OWWfZ,I:9
TaPPg3>cM-F)C\RgC5RTJGe:75A>@L2e@D8BG;K-WcFO-#QC.MUOX:57+b5&KG&Q
_^#4-/^6?g9\G8YHE9e6Bb(OEX&U/UG_.:/dNU::5Vc(2<5RV4eR]BKaU@g)6Fc(
dbUNZLG8.2IE(9>W(1bMG\[8[^83.gWM9bM#MLfG<M)GE)_fg:R.b3Od25F@6,\d
N^F@^MgA?J6M8g^]#e8dbc<11?(@X9TA-Z7>U7;F]2cUWQ5e.VIQ[W8MW5GQ?2f1
O?=dNWeJ22f/CR6GOCZ64GbYMI=1VQfFJ6@XN0dg+KG8#5),&]gS;8g]7Y,->8DX
CJB5.]-/U>O)-VZ?\OO_Q>XEa]0.;Y6OYQCD8^P&OK64fc3W>KZW>?<WTX:)QO)4
U?YJ.14:9?1U7/D,Nb^OAXPI07ad++(f/^PBQ>91\D5&5)P.1&WZXFMYG3_&W+N=
A&@6):Wag4-L>#+@,bg8N0>)4g^:8FBe+K^P83K/O=WOVfc0ZJSe_Xce5#L8+KEA
9L?F6U]a+PKE>E)T)Oe8JM1b/bC.Q>8OLRAGdZ#9AK82G:P\>V)BV)d/5#dHGO2-
2F1BEF>\/^.-dLf2)NH+J6,:IHX6\D/12L9@C04(D\__-1MO?aF9e;P,-dT[E12+
HZF0_1cDRQ;9gg6M9P3:M0b\9B&L6IHBD(+]O9:NJYO0e[6;c9AQ;);VZ@SANJ7e
)d)Te^Y9RB&/XM-gL:e+HY?RIPfe,-@V6CSG/?W8O8<B_FIVB5/e[TeRPaLT5QN#
WT7-:@><QR:YU>bD(Ce,MK9LDb&PKCS)GE:DTQZ\.01<\IQQ(WVJ1Jc7bKb_b^b2
e:./C0ac/[9NIPg1fB0BS<FYDOP;feO;TBaMHGY#6OH63cJJ/O5g&.+IZYM[I(PY
&6:6G8W1^e&a:7KM1,\Q]SX4D;BO0.MH_OI(2@H@8GMQK?P?I#RCQFg.+SA[c#7d
M4LQVSU+]eL7Y:KM?[R134)R2]X,^cQ[K-TILOeffNNC7X,V1DV=C>G=5?.\;?VF
<K2)+a6R4,J7NUbO66gZS>WNZXJ7ZN,9G.__BfJ(N;g^c31,64[W1.UILCX-T?Aa
Q9c[W.:&V(P5J1Lc;<1c+,SK:K03O,.\CFE4FIf5C2<U=B2<M.YS&>+\[<DTd@].
A7:e>Y?W4N2]\[JT+O@0._B6_@@Q..D-?@1CI:/TT3g)9c8P7H/?9,]:fQEU>f?3
P?RWW,2fSKD-8I<PX@WI[=+I\dXM_Y<>a5:8[H#P.<X7f_-=Oa;7+#5<<;>#+@f#
AHaK/S&WSTFA;/H/Z6Q,J?XO(:7T^&Z9ZG@2+Zd?U5\EWb3:::YA/30:G7VFO&f@
MeD;BI0Ef@(&?_=gaN.+I@cZ3d\#FK]0HWMceCb^8[YD,\E:6IS4LO2GV@2D#65P
QQFISg:V46C.WG;eRY:^g7Q5]I)-YLb\1(IUXJ37:G)6#;OGIFaB2I88[d;[(US=
Me=bA(W]JX,B5-RJW&?>E\RP>1egCVgRW<^6,(2AM.G3.=Z\:RcN3[Q3fODP2;E3
)YRgRIaeKM5-J[NI:Y4Ud,0_;_RH2VQ24H]-T:HI@bCK/4ff\=6WSdO#A^P3U>US
aX_JGf]ZF?,G^Q1L\/8@,ag\:f0+T1W?;6KGT<F#ecIAEV);<7Z2e<UNdeMaGRgC
TA8:dUY[ND57<&Vb9Z]cX>^[O\#;+_A0)DTA&Y+>#(39H=1eC\XR_5HN6&?R))QC
Ff]:K-gR==._DNVd,0eJF5<\F,dZaBQ>BRZ1\J[CDfGB#;We?XI)>AY5d(GQeLU1
])aI8)Ed8RO#gcNZR,c19E5?7EDQV2?;\85VBP+48(-g=L4[>T^&,(+E5M+WF2:D
ASeX]]N,DSDG0WRLDIH2BV?HaSS@\0F#[D+fE_-&^27G<35ZFMc:?[#f_A=T,V-L
W3XQ<H(X[L5VS8=#F)^XN8Q,0[FKG:Sfe0[EB(DWgEac(WVUe(9JR]?RbG&ScfCJ
TN6;_]N^NREIP;P#RA?FGE;\5;-ETBK2DDa:=PFJBD?6XSfZGJaD>L)8]/Y^H65b
&P#Ja#,FM>FK8HOHWK(PX@IPI^N)#_6EWZe&(0aJ)U2I>8gGHH\EM7eL,UHTRI.X
?2+XGKeg(..Mc49CaV[32Sf[eT:YLX^)CV;4>;BN;4DP7\+=?3DX2]<,X-UZ7GOY
=FP8+_785-:I4&G6]DR#+F33MA]fK5Y^>fg76#><J\Z3SdQW1(5[dZQ7/9ZWX]AH
9)P,-N:9AbBeS[>db?ggO3.cXSbLU)H1Y;g^>RA1-D/LS)B_&4EXE6EYF?LN;YR8
(Z31L<^9af_CF7;^\9.48OLBV-8A&ZW5T-+DJI83CFOB8R&B>dH-;3&ZNMU2fR3a
X8P1MFN1ANA2(5PRR[CgAMT13LT8<FAEX[G^[Z-DQF;+E=Q:R#A9&PH^<@QX\5S6
\00YY+?Vb(QQW)@36A37LTJQ4B)-IC??=Jaa8=11&8LdH+KSB54&MO#G_9>Hed=(
W#Y6L;3WHAHa0DHH,B^I\f&ZS0W[Bdb:@Ae?Pe#Sb=]A_eZb_NfgV<T]>>^3^;LJ
-07@P<:^eG8A70>PF,QK<,dM<U[-aVM2:8H_B8/_;1?NYY_F\b?U,DR9E(N2?XNM
;\EEGDC2[8V(aO2WA?fZGRO(@W58KN(HS77+1VFf;+)K9LB.ZGSMY80K7VcA>OI-
ZfOV=VBQ2/:3e3Ud0<WO#d&V1/CTNT0IQ]:69,JX=^G)2N:?<F\Vag9c-cgOB4^Y
-X4bH>OGgD2UANI_3[0FbT[ZB=)073>&.fNVaZ.<<;?-ANMJ29CEBGT8F5ZeEU?W
,<@,A:YTELG0<]3WLU0/5/T__,AgC^2>:RCe?C+R^-Gg8GAf\g)E3#^J?E:.#0Yg
G,COf^&5@M7?(6ZG(O5>.K)Q@ZECB-Zd0J[7&W2F]fE8=AfMQTBYDTcg,;^8W,U<
=X.KTMd+IB@PQB2(53L0?239M[dTQfC/eCAR_1fbRgN8TSJCgXGI;0,-dcO?Q?@I
Y>/f,)-=+-BN:?M>\9Of^YZW8:Q]#_?CHO+WPDR(OZ3cF]=6a]X[7YK/(4:g@@>8
L;]+\4[O>5?0H>G@76>(]Q@MXV4<LV+BRM5;J,RXC;e]d_gPT7b)aW2HNRCOSZb3
GE@dA2:>S^-:U8#_+R3\)P2e<+d5gfg<0QFJ9VLKe;)C3;FSTBOY+E/4>f455e-J
Qe\,@(PJ<XHRRTOMY()9YCH082LMNdNF@([:9XXEJT+3)YO@28STY+15g4M5>[^4
0OU0BC7U(PgL=ZdNd,),f0NJOBM#6#)08S(B?A?dJfXDGWcYP_D#bCAdKG#,#MU1
.^CQ=GcI.gV(G>H4]b4OX-6RCWLO?<G3P0a>a-4)+,CI.ZUC&?R(WUb&MJ,BeJZ2
=,JLaB#g=1[<Mc(\Y_#R5KF/5(22<2/<P3(;HK)0_Ha?YA,8[BNNLST22a==c@9T
5PFQKS@+UL3;OJ<V,+ZT+NA(TGbMeO_MDP<5^P9RNYFc=GG?gRFZafeBNAV1@/8;
B3>W@1EP[dIK6cTS3885MdG]H2C/O;_+REX4U&-]Y/OIF93RF<@;c(-\_H>+A9@X
UQc[::>K&R3WfVKG4Nb89AZ3S&_7ba7IEJc9d>TQ[0P9d5f9I;^K=cNN-C&L0g?-
A7<\B):W?Ba9<fECcKL2cc.7]\B1XP95KO)C?P=<01_9+62c<FK][6R6W/EZD6H.
>CC]?IQY]AJ;7R62aTL.V_.4Y_e5TcUK=0J)Y=D^b:K#9Z+^U0b);CZe/89-.=J1
c+R>S/4^KQ;M)gH?cF6If/?<Ic6Q<cVCT53@\GJ?56Q//;Z[7=0M+ZMOT#+H8[,]
c?e\a>LB7E5eE/W](>E4C>1ef4,U?PZZ=dC-69,2\OUN:28M.W6C)fc5TX.L-eO5
e+S>,Jf3-/K^@3D,T_#B(I5.-[\K7OP9RfUUO75_3aMXd)@:;=Ig41e5>CEbNKKa
+B:DYV-e-0O1X9\F4X]56VTCRHfJMVKH5K[BR]2<Qg^-=J7.Og4.Ia;?TW&V0fN\
1)J,I0O_,dGH]eQ7T7H8)2Rdf_JX=E.e8LI/:0[GH9G\G,>,AJM-FNe0BLaTA(B_
]S^W82@-VEI.RL00AK[_9GS+aK3deHA:RPX;I#8U6=ZgY-^T&c9GQ@ag:_B_1UDJ
84LM6-9<38:4e<c<-AB/7>^ZS?)OJ;&bW:->)_Y.XO91QI_J)[B\:D4EV3EX]S)E
9]3=a>3IR+KOSTS2H4P=2)795\0(?8#fOQ97VI994eZ<3WW,/g/E6=2FI37G1DOg
c)d]A,^N_bWcI@B9g_\GY+3\F1TU3T#;+>1QJ&b;C2Y,8(=,a;9@B[f:=;^4+C.)
#YOQXQ-)CMO&KT^L&1TNK.0\<71X4#.;4Re,&DH<]A_RFYAC9KUEN-fNHe[;4;^1
\+,1YY)>HLJg,=gF@[M]S2g=VHbU)CS@egd7\<,8CAT\dC#Z:WEcER2Tcb0(YJ7^
+M=4GSea31#>Y-),RJFQ+@R(XZ1?UZM1T^C5FQF5eI/U=[_8FNAYPLRI-=(NSJ2A
E1()fN[BHC7MT5Wg>BAN4_TV4=aec59b:dERQ^aJAF=[J=FeU3[X\5=VS,SSKGW[
C6UAS7<R8DN7Fb;H11@=IP]+J6C9=?#EW+ZX@g8g86;d8+4@S&CP113#NN#=H:E,
=,7G@3L\KY>,X:/Rc&[13d.BCYV;5_AgIEOgO=0Y?eIBXNe]T2IK58dO=3L;SC)=
D@8E))7>JdGDV7_]Ee0]SIFU?g(Lc1(L[KBb_-fC?_6<g)H,(6accaW+S/IeF#Ya
c5(AI6cF?&QD#8^G:Y#B/)g92@=32+KP7,#_+f0-b)8K.6]>)eX7](5^=[RQVA;K
BdeQ8S]R/O?BU]<E1@=E;Bf-@1ZE@4FebWc4X)\dD]K=^LD5G@Y-J>YIOVbFDS^+
CD@dL&))8T+E=d5]Fdc<JFAND6A#3>,E=dYCgeWLPBMJQgRWUK4YA=A)YPZ>a\Q7
N8^CK)TYL;M/X9AI<41e=)+G]K4,;FIDUIYYAXK6);.L4-SACC>f=cJXXEa,aZ18
6/T]d]V)>7gT,-XJ]e>;J^/7E9)BOTB:TTTc)-F9)agK(C>>;\fd-LV[6g#<NcBg
K]]:-QF3.#IaBYG9K9f/LcY>6EQQ/-;)=dDYYED=;aL\\#=LVNI<SMNFM]RNdKJY
;c@PALLGS&gggPRP7-I8HK@FB)Sa9BIGS)bL_0fId(@<\Z_CFN:4-<7\;AR:>PYL
N2d[]3a7Z-86N:&?53e;\)3_\YDgK+H#LL3+_ZWQWe#dfRZG=TAG.<K]cO/H0=)Y
9&>Z79P2)(L;cUKR^7VBdA+84T@Uba-Cb@M7:-<.=><R2=(U-a_O8;J@SD=0_B/F
5D\QUY;R5eY0\.]#KFQNO?8ZgGUB0JI>?eU&FPf_4dMb\>#N5VCY5U5e3dDZeDQK
CK6(YNDJM/;J1M[6.LU;S_:ZJ^PUUQ,E9Ka8HN(d:>612,O,X?E#3)HGHWBD.\==
?/da+Q9RM@NNW5bIG\3;7-G0C\7Q.A]V.fCLX8V225()<2S5KPTTE]EEGWI7CS7^
V+I2:IF)[(5E81X3;(Y[&N>3gJ#U,1[WL<<A(AF&QF&g&S@WQV9cMHG7_^V,S?cA
KLe,>853(]/@>RJES<P3HFOIP/Y>eZI#7/8Bdf^6VXAO-+=W(D4LP1/=Sa@,Qc3?
97PN+3bS)T>L(\g6d[c0fNP0cL_GH_c^(:AC>())@G6aJ=^S(F63R\PdBWJ[,33R
1Pa3[?LX+5./J_g9/MV/?MHBQ8:g:WYdO1PVHMe0fP-/>NK\9<.=@J\Z,OV;gbAe
E::Cg<G;/5,#A)JGa>=X[N3LZBGJcWY;g^-L)@X3UT#T_Lf+K9.<X>e(GeRI._/)
#]AAcIM]AfDR3Q&]_EEF6b)NBNf9Z;45I->TU&][8c/H?O8O-][.d8]G0O4S_SJ;
BAF]:a7BYOY62,DN.]c@0LKX@dD1ZB6?O_S-DbRMB8@/&J15=#eZYXE#<7H9YF3R
fSeR#7M-EU&;]\SgXYG/,]ba&.&_g#/ZPDP76;fe)_6JRfcg#dd2f?();6bK+\b:
>2F5@?G((LTVY,g>HF33We&e+fMB^:K(+B2DeXVWT1^5OP<;7I/&8Ve1aA^4X:6b
L=+a@g(G<aa2T[\1ICUN:Tc&42T,:\(D0)NX^;84aQ;BI/9c.E.=17X;R.7RD0?e
NA=>T,]dA<.E1e_HV>QR]:^A+(f9043+1<R6g[MHFECTd:B0&T\7_TG6(MF+#.W&
.EOd([]9[I7<c?K:[<./TXeVWa?<K^A7&?aA01M9LK-1>G0_Ne^EV,15eZ0E5Uc4
Tf?K,@gG[cXEF/-Ef7JTe)?#E\SAUg,48MZ@3:#H\86STeb8A2Dd&]K2Q<.BI^6T
L=[;a:cT#.P_26:+RJ_][-1@68XRJ&M.NW4H/f)]J83K)[I=:Q:U=g^_N-V8Sf^2
0&Q@.AX1XS6:&98.bAFg7],gK&<^c-CI,SfG.HKH7WC&85#H2&AaRDWHceE]7QMG
&6Bb6N&J&QV=cUPF6E-KT[9VH@TA=4=(L28IA+\?IEENNOXH<g.]T[6;:UF9YLPb
,:KNFU.@<668J=\&<#,H0Kf7H8[KFWaY27U;f<Qeg[RITfc+c&U05X2QLLXO=MXF
8WgJ9e\5Y9=T/d.D5@EM0LN40?TN]Z-4/,/;::d,><0aC4I[J7I=BIZQVQS]aK7^
P2J,;fS:Z]HS:PRe^^cJ@/;N2;@5[1P\bfaW+]?Z.964bE26<?+>cGd;>++Y36[L
=NX)7f2/KcJV9/0+)P).dfSYNS.g9cYN9,7HPJX2<WWGPUb+:RW^gIbXFU=#1FAc
Cc=:8GX(18<Q^9_[fECc#Q79-)VOR<2gNVV]7W.(?-IcI33HG=V.UagA^@#dQ.N8
RJ(MTWDc\7_WUI/.)6dQdKX<e:W-AC[66[@b./T)1^.CT#2^GR]4]?bL_>M\+66V
BX1MHQPdJ+HT(0.1GgM3XFaJ;J2,UHGVYV/a1g61N@XXI#L2,\af;SD>bbZ#\WKT
CVRIK7.+REMG#ME#MU,d#KPS:U(K=N6<LGC<d.O5bfe=6/)+0/I;3C/:VJN98&X;
M5YI9C7VEGec[fAA:,)[,Z7)\?U)R8Z#Z2<U-24^/0ec:651#,7ddaS@Q/47HVOY
:JH9\4R44.@>,K1aTF&HAXWTeE-PS3H(gR>KHaa+DU0(N+&.;@;;<#?OC2_#TN/V
aM>:#QVR>H1aWPG4(&2?_EUHJ1QO8PIc>eIDUY-Q4/54&8BC>LGZ8C6:R/M>^1N+
379[Ed)1aE>gT.@MEb\TY.M8^K,G,I4,c@=Oe@09N_=5+9F-)5:;NE,1A2INXC;^
L>5THG[e)@bK(H1;UTM>GdR/&a\[fJW0a:<=(89??L,XS5](R+Q@0,fM]JEZ#48I
4GN4N&&3I,E)/AQY_GMG^+7RdV8NA]8^>b?DMP9d4=O,IPSVga=F+0b)[HZ0f#^D
ZG5,2-PB^5&J3[38QD(F8X^c^K;)HICOO<>N#F\/([L7^K&>FST6OddMM+Q)4@:E
GM34I;H@]DeYQ6EN1WDM:OZBT@(6F:W1J3P(57CcYP/b0)5<2#5fE_HbZ0+YUYNe
[&-1J91XI7?gZ(cBI#488HdS8cZ#89Q1U4XZa\a]>#A;;1PJ)7?R^MPJ?J:ICeSa
B@c<BH2FeB\:C(LBZJ15[U[;-e2_AO?HJg/Q2+#XaKUd(HV]ZIJ/J=Cd^)XXO:ST
RcN-L.L&&9+dH_gU(0>?/;LC>95QQ2=##29,Bf?T34N6\-Z3Y6c^,]F9C2+dRPQS
(1Q/\Y,21W:6IdEaEdEQK]T-3ZRL9K2ZP@:=RPM62MD?\29>5MC91D2M>I@_UUN2
&JEPAOH\/XIBAGf)M)WC7;)<:3B2^PW3?DQP;9G\gKHZ&R,4D(\3QK-_NXEd&_;>
\HZVX3U?S1,UBZ^a7ec2PP-9>Ke2SBUeD#CBEX[Z/5g))>F9L)TSWOJJVSCXdc#Y
O7]V/d47?WU6.G.B>9OLQ51d&N_f/>PIe^W)Y?#<;P6ZDG7(S03(D9:f7;K-,+FT
&(]=?JPc3&)8J;./BH+=KY8O&]502B_4B9G:ZED2I.3dMJS[7)E\\&ABC]\78NF&
\B?2MJ#P^QN+T.d>_DFQA2VF#&Y7cbJ5<YJO9Vf62f4=5\GC#B-d4#]\N>E6@502
B_(]P2O<[:Y?Oe]^#3=D5E^7,=P6;@6bd.3)EgV0#Rd1X38fg49A42__Bac#-M/_
VJZG3^,(T)0[f3A.O0U+OP#c\-N=\Q73<:>G;I:EAQIbgP)f1K)EG]E7R;RB2#F4
O3JcW=4SOM4&EW_Zf:M[48H\9TD5<,5?>(R>0g:&QR6eA4S,@\W?.[bbc[dJeL1\
=fQ_NQ;RL[F2&L0B.0C26:=VUEeBc44]ET,Sfac7g(/F0dJBP^.9TH51I_ZcVbH5
.:cNN)MdcVfK&6Y](,RE)IdC(7W>,7F[?d9He.ZAMBR5G\9BeD:FHC[<Q>84I\8G
BVRFNfCP]g>[98O<O4IdJ/8@>8SU]Q;^b2_#3IF,[QRU^.VP]0</XH#fX)&A:SSc
UC8^^b\T>1J&Yd)M)]T5+Ub>IZ05K]=D<1[>=QA;fUAF&RFg1,aXNXX6,[1Xc]9,
f5J)S\;QK3(8dF>FF;J@O4fW]J#09._:<HL,O.bXa_^P2c\Y3A5=JQc/WD.+9B6D
A3]<DIKS\EH[dOg2_-b1:R>^Z7We[2>Y1P_70&7U/D4[Y<W<eU?PFC,NSZaZ:(EC
0J::<EN1VGKQAT_B#f5OA7e+&HP2N_d?PDQMHG><#cB.7GI7]BW@:F>2\:J4V??Y
300ZFBNbc7.d#G5.9Z9Rg@RJAWEIL_cbGg0aZZK<5WY+,AWGKdPS=ZI)RCJR9K8W
cFYW6BL-Pe&=aS[A\Jb2Z&B5:<44Z]&f/=Wb/e9YbQN>H[9K1#ZFZ8M7A;@-#L^U
Zg9Va[3-=6=/-<G1<R1X,g7=U1<RG9gGB.T<Nd0P9--=4N-)G/V=-&CQ?XgH+^@(
4,ZT1fGDI-O^25TAPb?cgUMXId0LXU[OEAH]@O#D6BfJgLK9,7:,Q_KKCRT^(AP_
4A20]a\S\e9OK#(=V,8f[>AAdV:V#-6^;2Qcg;59U1>=N\N=.T)N^M7b1PP?^PV-
-QT>L_STI2^8FBDa<HT;.&88YVDf@/P6-d&UM:Y<)<5R?5;5gTH9EUP<[eGbZR9@
CQR=Ac8/cJ6ZbTRLGgAcEdQQT9IOF^a-HLdbe#LgZIF,edFb45#FI(BEL_ACH(eg
CZ\UN-Z.?d#?@84g0QZB,GWZ5eVM?b:ME+&d8Wc7bFBPDX.)12GcN29T1PI&AJD\
_+fC>GZJWW>_eg[a[c?e7TZT8#/g.[Sgg6[Z4&8.51,C3Gb4Z>RTO.:8Q5OOPRbR
5Vf3PUVF,)d/Z7KP3g6A-[A7feMbGK4BVRIKH?>K<YZAT=N2X#@LX?<4_ZNWW1[?
43a(UC>G&G8cfA^@L:d29158=a3d-88+ASWD6&&dI=H#&-Xc>T:Tb7-&V,&OS47K
@Ie75ANG]7R_b:7,JN(PRD(/]?(_1e[ZEP6.TB7#a=S6QfO0b_d2HTFDBLc7>WHZ
<^/]Q;9<BXTd&>0,YPJ1BSI(+EcY^DIM7JNV_QHP/+L_^NQ16C:Q&59[C0H^;KfX
LU(-VH<.AS_3df3HO7<[^&:]9RN^f0e>8>HfP^Z/@<;T[RDX&U/D3S,b^>5fQ7M8
b^Z/V-+a=ZVO(MV(Y1[:6Q>TJH,5g^2(O,WFW4^U\M&W-H7Z(ELK\US[9L@H1TV^
6U+^L7GO-FU><aQ4=;R]G>ZT3+)@CD5@8KZW8L\G<[aeKKS>:BUD50@J>Se,#5#X
>?ED/gNg&&.@:FF<bWVd1^F.CNG@DR<[1J2Y[RSDSZDE.&LEJF_7KaQSE5\ZU6DV
#((\gQg[[(bVJ0#01.ea9XIc/Y1;PW#=,d6W?04V9SJLKfDaM0YXc<,PW1^Of8^+
>b[AROVV1NG2?&AQ<OBKK6/1.HASH9E;QL1F#cAC:eHXYE_9e(AWFMBX)KEL,,W4
1dPX>:Ybe9,.\YIZON@bNF[fV))M^.X]XKeG&>MgAI<X@:g.V(N,#(HbBDO88XA_
:I1>S@I(D(;-&S3GM&?FWMI)/5?.JeNY[6f#4^I+JAU-.3f4XE<VP5#)P:)JgE^V
):A=7a<c^MXGFd]-F(I:d+8#Dd]TTg4^6E#X.,)2g2CA0YE42#KYM+f70;9,WNY(
:[&+R&^7+>_TL(G@4GJD=0D=+W290)(KZGfQfZ_QX3^RW4SE)TGe.#5afegW1dY\
;fgU90HR,dM&<YNA=S7BbZNb+CY2U-#VTT@c[bc8Q/Z4_O[SQE#<9.WVQc^N5TgN
5C2>>LO4/g;#K\S&JDgXL=^SUL.2-A0a4f6AC>^ZIKK@ee+d.:KPM.O>Fc+a79W.
2d1L<?^#31I9S^;eefLfK6GI1eD2IZ^-)b@76bA6#Z33.gX&MB506#JEDU@UCKgY
)N]6A(KKf?g:CfJ?90V3>bU[+WK[R;52^@W?dUSDKJTBfH?_7S&E#2=4<D27SB=2
;\EYBR6T@JQeQYZ=TUZVR5(Fbf&A2X89a7&^=T]FIAXXO1+X]XV\&&]P&K<Y8Adg
8)=bGNWYE=66Q08>YR7cF6Pg.B@U3L4@d#g0<;I_M3WXG^6?eUcP@fQc8\SHTFEL
JM?RJ)2-U(_\gQ=J+,Q1;KIBgGNC/<a?.#]^199Y<f;g]0#&^L\#.9+O&X#,a9_?
8Da;S5D[:/BNe3(ESH:X^(?H5B.?MU:aTJ)V>Q)>&.TE^W2+PIU=(Ac;L;b(7&1b
;R_.X-3:+\W6+W&a1NbR^(61T^R?\(W=DcI+RM&Lb#AS[YaFEG(-[1.YHHPAIIEX
D2-EGU8\Oa&I492.NJaUdY4RZ#T5KQCaPe>ANRGYbCHX?dgUMHGD>?J\[KRSc6NX
XEdXbKJ@4OIX7WG:]4W)LL_4TNaZ)CY@]?&L2W+[)^gV&a<<.2[KPI3)R=9KXdFX
R(Q-Da8D;R(g452GB-@1Y<+GY10a+;]W8e^L=96D[(K&c;AU+7R-0__Q2ZS57[Q4
f\b\3:5W3Aag&C2BE[^SaZ@7DM&(deD=Da72^>e<bS]BIHJZ36743<D[Y\7KCH4R
<Z:0837<\SI^cPSD7AB>?fJ<:Sa@5OK=O6,<T]TgRf<]M<71K\EL5]RN)J-;3W3J
^MG,UO.b<Y+TO3#C,^1JC,D08I<94PCBJJc-.ZOB2dbMUaAXZ51+ScBc>_g]E^S4
=[FE((4]eN<B[LYdf9,/GSON=0B9O)4N?M7[V.Ca2+Y70^@W]/.EC]W@1[ac-EWM
_<LV-JJ](L]>&AYCJE#&DTR]Ve[3ZHTF:KgI8J9[)D^:53U(IF5_;P>LZPa>V)NY
\IbWLR+fIK47COJBc<=C1<E?EA@)e:.)RW#cBRfILQ3V;b[Bdc^>:+3J;B?_A+:[
K734JS:L.8OO^5fH(cAJdV9-bH-E:UZ844<eAeAN:Z[#TJ9+@PcH/,NdY?STJ2U^
FBE9,TTHG4e1VMRZNX/&f@#6-,2-K28<MY7=YS07B@P:#LRD;22EF,&dLWOX?)@@
aG2TG@R,8^9V8L9gR+>GbeCc/SH3>6;(K1Y:^,Z3E6T[5(+HO]f-8)@AdZDPZ=AO
CR_]N^H=e-]5I.@>_L0D8ICC6YCI&7(T9P,=/F(JO62<1BgL&Sf&_4gc,TKIRQ+4
bP2B,^F^;F@Df,FF6^IVg=WU6V-a25[dX.f\Pe;fb-&3EcK93LG#f4V\Q.PD_5bO
?>(gMJ_IT(I+gAD?V0K?fXS&.ITf.ebcPJF^K.2V;_9[\5]&-64T5Vd^BG;VU4I]
7R:#DQD.##5EWVXaGA53]IRSaME)e@2L&[LVa-d;0#eVGdBU90\33[b?[,O.Z;68
(?ZI1)49Y#,,FUL2W(IPO,;^J/7Ae(CR]4^b0a#ZO9P3a:EJ#)]##cL[)F0R.RU;
fdg_:8_A)fTCI=>4O1FP>E[N8XXV5@AX=)HQM);6&R=GLGGKdg25J)TEHO/GBX=Z
H:bHNL&e&)?eM#,R2)Q=2O.Z+a(?a4c1.C8V-.U):18@S-:6;A^^;[3@/;-VNAPH
/;5^W#F/M6=Q^X_N#6-@0WM09]IT#&T>LQ,\-:FaYgQfAc#L4+aF^D9/:9fPXF3U
V,Fg;Rc?bTYHUgZbT\^M,S,>#OJM[#+MfF^Xg8OG_9aNfPbG.)F&E<M0IVHSQG?g
RDcNHG&WZ-e69XNaX)K+^V9^MWcP4CW#^&<a>-N>a,/6fM^Sa;EHTC7@bX2S+^C;
E;0MgYY+#_[MW5gQ-M<N_,c)VHLMSC5/C>eE+Z(L:Fg:[^cf6CSPP29]f1ITIUZ-
4&0cC:)JM.MBOf+/cgDXU2/Y9NdQ(KDXS[K2J=6C^e?3TXYa&4gXO/YX0Dd<J2Z-
ScR?HIc2T5bRYK3KQIN+c(4QbT1@M:R<c?(YVWNa&I.A]G3WQfQ]75\,S,MULDd&
Q1M)R6d;]3P+fER_YCGTS.#)P-C.dHT&HHQ.(cN=?Q?KF5gQX0F0J.ANK7f66.QL
Q-]\0.=_XS]g:95bTR?WaPNLb,<@\IJ4LTRQCZMb/66+,?=M@JUM#_Q/+5cCN(X6
4&fSU2b/5bJ7E_cP[?NL9I7#=QfD<;V;Q4]54?aVF=GKTKE#6X8ONXGL6-T./J=a
6fELbC19Cf<DZVPKD&)fWGG+XR@VbA3>F(cLB5KDCeG0(/K:BY:J>)Ge<CfL/354
@FA^bObPN\Oc/BCH2<dOda7I@4B3C[4^X)3;Z_;?8C<:=N7DNG&3[XA5T20-5b4X
2+R\,c6S<]]ZY+/Q5+NKU7IMR#WYR+HUTN0cN79aFO8-0>N3a6UAJ]f5BD)S?L.^
,X<f#e_9a:<P^FA5aED\KI@IOdgMAQ2DSGL0f=Xd]?PaUN=dU9MJ-)J1cHdg:He,
4KU[^[?+&KY\c2.cd2\(]@L18P)^<CQMJ&ES@N)ZUIW[]De,UP;\+>/#[9A<6BF;
\DE^N2&7NYILTWa:S=f@R;?=G8(^3dQGeQ5&(2>?064.=f80IdH\#BX-9bgTKXe1
F&B;Y^KCP.\fI.2B7,^E>>9?ESf_=d2B-Q?:\g92W/@,f6O5;1WaBE;J>F_U_AP8
DbRMOfJe21/-gF]^_QK\VbX#@=.&])c+/3EJ5QRfbXMBD-PN4=9=,9ON\@4PJJCc
S3@<g3,ReQNN2c__+d0R6HCXHAYNAfdMOGUMG0/#HJb25<9>0+e-V(:9G_S]a6Qb
L4a67aIU,CK:,S;5ceB&PBdDZD,=PT[UZ;?I3>OVG+ZEa)=a^,\_H3;[QHe:aM1^
Y+(2C4(WP,EK=K5C?/E7NebP30XUD>YW8O9?YRHC#;X9N-C59HJ<_IQ-<L?MSN>A
5UM\^^+dFHQ/g=1N65WS3EW/NcfA<RBU:>=R.F5W-gY[Ma^L,M)U_QQBXH)aDCUO
F\.4M-:\0bd^)X7>=A6?Me^badW).+KT0XAd1b&G]-OGOc3R3BKYd\7AFTTGH>8M
VW>);#,0#DB4M<RBMTHCb)==gCV/Z</@bB?;[5?>:?.=&d]g_Y]#N)R8:PW94)DV
;Fc[_&(]gAYMF5[GPLD08Yd_QF(#\,G67-4H/c)9?PNB)<A66O4&1_24R3R=^Y9Z
.IU-DI>:]UbKG1Y65b:G;NX.H?3_F:CB.=>A:ZX/<QRG#H>&7-0.,aab6(8&[(U.
;+AAL;B^6A3JF^,&?AZ&e#K^7HaY=XeeN-F3SHQEPN^gQ/[QY-\6WN(GDPfeQDJ-
N,[--^?ASHg-W0K/bWTFUa\a8N5[b?8ECb<M+6,RA;^Z^CFPGLHSg=V.eb>7=DR4
4-M,?(FHW-Ta0eL2a/_;D2,V/[QGMRA]4#Ra@fb3\Bg6L0Y:ZI#[d>;\3LBgPC](
V5],IW[=+GAH8<gXB(J&/3F>7=]e_DgW60#I<=U1:7(SJJ]B<fTV<QWNgJbFIR,&
?CD-f^<7T,JJPdgL@aS8-4.I;N#,?;.gAee#b-]OWL^RIAGd8O.JeIZ\R_SFP\fV
\)aXA;3XI^M.-5_:g&C@19.AN7?cZM:.?V@_S2cceRf1#/;@NYD;1O]V&^8X4BgW
8::HR]P@(>Gc^aQ4-<S.ZBSJ&34Z4a.ALW?>eE6:5H<gOQ0=G&KF87PP<OW\\L]]
?ePJ(AY-4MNOLU92IH/g-5FL^2T2MB1WGg[F^YZ4=:R2Xd=L?_8AY_:3RO0F3:\D
)-IK,A-0[,#-4P_:d\:2(\O1d(A5F]H(IZWXZ+([[F9g3^LQ&(]W@-OGfS8+ZcP5
4^)/3bP,gE20-c^T;6d#QTbQNMgG_geO/#.b6:eZX^e\\A18[,+dKI0:Y&PWU.#4
U@WY1)IJ,aJ1A-K\\#J,EV[O6+T.A2b9[SVI7(eI[&?F0d-)G:8E6M<S#_?:\S03
?W#)<SDVBcU/e(E?E4T6cK,Q;(6A3X.EC@TE.=bQTP&MZ/+SOa+c2):^RT_8Zg1<
0PVR511]OH&4C8R1ANWI&8S?5,\RCLHUZ6QJX8G-?E(/5Yegg]J2_05?/#FeIgBg
>C+))00A>PEb3]g)UNU&=N)Fg4.F/^](c8)VM=N=4&6PX<.C:0534_S,\4Z4#W]#
A;.-Ge9[TU>JYY>U?<Fe;-;.=^U6]/;ecb-F34b+=&&O^b5g1+6W[^@@P]^f474D
T_?6##d2_Qad]-D7NLB<@bO7+bBI->RP0A2S&BWP<HT55b?d(UX>H&.O_K8K#7<=
>XQeQ;a.OED5I;aIJB2d+4@J.3K&B;BVecSD&KgG-FQ>LXW-T6ULQW)=DL,#+=LR
]GX_K<X4eC7=XE8V/[=#g\7O1@a0#>6=fGR^76_FN]>Ief=@/e.=SI(KK(aKgD9H
\4X25/[ZAOJMLXN911Z6#RfZeYQU;OZ2/#<.3c3.E/ENY=7&_&KSQ)LMI_<+GHQ.
H2fH&MW\bX0H2#?2V?FfBgge77Vb@[P+R@#:TN+f0@Ia5Z+-DF<)WN>N38F,Z[^G
NQ/6D8<\R;M^=gJY9N;TggRL?#3KA8^6;XbV.Z5E^cd1)F?T6NY,5=FUA:&92R/,
>60[NN1M_.G_+\RTb7MbN6(#KB#R_CMJcP3C84L8PTB.KS+-A>7N:[#5d_4KaNZG
H//D;,e.+[CgdJF@M&XE@3<2>M]LXd\egG4]a]Rf6?2GdJNH)&6]G#=2Q35ADU)7
N5H:TB5N)U&-,b@)dH9<a=/UGad;fB4GB8^J2KWHdZY:AW&BSO#GF>&/.TP.@+f5
UJgI2_NaTH>a2_^RE,+&&^7bRTbN31&&P:ZWTKO?VX^2(LV#AVTHX\XZeC1-M,E[
ZUN0?,>FBA7aO?b4dSgb#-W32XT_UFF9fI+UbM:C3<,[LH^>RLD3I+fg9NZ?T\A\
AO;K_+=W^_TQ-.APD[MXb,BA>/O#G&-E@;eO2RZ2B6MS,ZQ4LVJ+6SF7dMGQCH@V
EZ<(=G][0&IWTU@&HXR\7>RbIT5=VB#2-BV-:.K:#)RP[UAObMe:AT5VE@Y30agE
_LTddEX7O-+[)BdZ23EF>2^5:Y.KO3M)\.AOT//&L/AcO8.cAbf2fb2e=Qeb:I\g
E>_5;NCSZ8K(P=NBac7c4XH.[XgYaO,E?[):ASJ3WbgJ&=NE(A9bUP31@#BeBLa/
2SOEV)]//Ib<F=P(FBF,cRB@6DW,O7egSC4F?AT13aBQacQJ:JNGY>1FZ7<=,#-+
4E<QH&YYGJ:/^QWRSfcMC6cMdVZ,9DaM[Q6TD=edXX?UT[FBLZ?5e1#b90D2-U7?
]6Y:9LFG,ORS0MTe;ME/Df<#SP[F=Ra5O#Q8@Z)+74RbKa<Q.V+_Nd5Ldf#3dZ_P
37PY]@#I^c/;CJQO951./XQ6<78=#=2AOV>&Nfc6;.[>dS\21Ma[O(1JGT;A.M5:
5/=gU4^(_b=IXD#cR6Dcb(-N/[?O(cK2Zb&ZX>V?g<^]<,/S20c1O9aW^JHWZHgX
JCOY#bF+T6e]EERPFIcM+[Sc(LLLKV;I:#,]V;T.W8e4FM4TGb873)JGg.EN2=T@
DBP>f6>bb8b5+af2GD8KWC4FDW>TRW+/6]2OO/:1-1aLYU1>9d+IPXdf9\CNC;=[
7<+e^#C\KUPYBC&:dYXK@;<cbgT;Z9WH9a8<Q)DYfD1a]O:7.A_0@KU;ESR]WbJK
f-cD=[ZMXUNK.>+R<AFN1Q>THZH-4]V-Y=TAHG.TJf.0+,e<a0eD;I0/G_ALD_?U
C7+.@3LQ9_&5,.F,5Z<dZ>ITCd<+VYECe?I<d(&X)GZD>N4RCCY#_KY>-8&/R;(Z
P@]O5XZ]I,7)TMC;;YXQ&41ZE3<JS21-JLe1>T,:F(T#1FEP0ET=H/_/.^g;./;^
D8f[?<W:@E@>V1a0K:F#KG</O:B_UG,YC6Cga\a.WW;\Q8,ZXKKKX0R8/dJ\CVXa
f,>>Z,[Cc09gC2UA:B5dd2#FCP_DY2HW[TP[_?;Dcb66=L/cUfK?@_.Q#8BJ_(NE
WP]M;ecO^->W]MK[.LUb^Qf?<IT-a1T@#N=9M[SB>GGQ0-VP5+gO1:E)@I,0FWZN
JR#K1^TK:,;/T^>f,?eHC(2KXOW=ae8d3SZVg37F?\V_b:>-[EETHI^B,\&DX(PB
,EVc,Og2E_W;,TYID./NB\ad&a:),[A]2.Z2)?2Te,IQ05(VHc5F5-B9[7?g>e3+
2I4P,S1I&L+dB;C2dL>.@-JQWC/__QIEH3eBag:U=-BK+NW)#/1;30SWG&DeHWAe
R&EHWB=AU7S7SH=;Y:HYg+eSHZ1f;OAXP(=3,:+GU=f)OV>XUE#e<;_5@bHUQQ1/
1<:VKRg=PBXO(;d.a(SWZ^Bd(\^SeSF.OD3ZM\?@ZV4776HR:[bYO.Z3,_7F/<@C
LT/BB<)#&e@V0]D/2D3L+Jb^3>J#PZX,TFd0EfK@G443N/?EYALKLc9dTc1&<?JC
PB1BI^)4_>,1CI):c.g6Q2DcW[g0XgcXIc)H6C]?<&_IAG=gZc&?S]F.XP^\OdaL
^XBJZFFGO7+HN1]KD&N;K:_dOFEAM_g=0VCPRV<eIDa8Q=bTR@//gbPUE&<@C92e
d.IG/(PIIEfZF\-@\[:5QR>,R^D\IFAg:)80]eTZP\D2;TRT:8]DYE/Ua(-IZNcH
fC3S-F5]AMV63#.b;O#48N2XFWB=X==N,g2\PRX9VXFU@M)f?A9C\I^NQUQP;6?D
KfQEDbS6L+5MMdGF8Xed&_@7^28O.0X(9TUb/\E51LfPXgY<CaI^+fNd^aD1KW-X
C(Rb[-V)E@@&5X\,W<2XZ<T+NTb5<LJQ0S3&cQX[E>K=-P<,PR-M]Q[@#_]6Zf2b
VEM6]JTdJdbQ;aIRGI)V0:79?&1dN4+RC>FK/?]\5aXc]f6.G7?C+[K#H+O5KSgB
J2eg-KR6+T:NFePDLRKUAg\fF)DL-_W5]CdZ0P@J1S[g)eYGRT88:K1_TXcR@-<=
1;U)[ER^a:;O=LBX+J3(KVecdGg=EL8-=27#V5@3^#/1?NMP<E;5.4N_3YBJK_.?
cOdRJgRW?7R>)?&5[&F#1OA^1A7F-d5@5Jf+YKS8O\3C@[N3bB0I.\Z6AOeVD4b_
fgW378affVJATE\DWG#baZ?T0W)2C<\VPOaC^Aeb#]?-BE0[gXCR^<(;-c,:J4T_
4UVBA89,0RPca(-_G^;gH/ZGaQaQXL2@@$
`endprotected


`endif //GUARD_SVT_AXI_LP_PORT_CONFIGURATION_SV 
