
`ifndef GUARD_SVT_APB_SYSTEM_SEQUENCER_SV
`define GUARD_SVT_APB_SYSTEM_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM/OVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_apb_system_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /* APB Master sequencer */
  svt_apb_master_sequencer master_sequencer;

  /* APB Slave sequencer */
  svt_apb_slave_sequencer slave_sequencer[];

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_apb_system_configuration cfg;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_apb_system_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  extern function new(string name="svt_apb_system_sequencer", `SVT_XVM(component) parent=null);

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

endclass: svt_apb_system_sequencer

`protected
NdAIBfBKcETRXWYNHd.A;=&@KW,G]&8,1@Z/)5^]68JGIEMU,_@S,)F#JaCeD:Vg
.FZDWEa,_>RO[;U+cg-?U8P/f4E5D][5b@J3ZPELRYAga1Y0eP)WgF-\PANa<[62
A[:&N^;BC3cRT[5CUU4H91;X/BD0;Yc,X(Y#K>)UJ/=KUR>>;Qa3[/VG,KJ+VG4_
6S\EFP6X1KM_&T\D_9\ZTJ#+PM+FI[=6eW28Z7>,E[cXWIK#?N\LBJ37\/6R/;A4
(SK[Pf>[Dgc://fBRSaMDW/S_6dAQMD&7=Zf+gfU9Ae;[RJg>8,gX=RU3(]=8;F]
Pf:-5BV(PTc3\I8c7U6+T\/S6$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
dZ+RD=>,K]H,I;+bR0:#71C[CT-Ia[A(OS;A;PM0JO]\@U^_Bb2S((_e3af6<Y/R
+FGDF+>fbUQO)[<)S4WH3a747H5]&>6ePaO_gIc[)8e_VA35M/[;T+VPbcV\AC.Z
B-J:J-FeV4JG61/S:H97GRU[&7SCFAdARWQ(ZS&b6T,\9Sa<dAAHC8T8YWRI=G2a
AP?BD+HF6T>U\L]JS1+4R[W)27:]1[eY+QOJ-8aK_d.DZ7C2gV;PI8..[8DH0HXF
:DC@D70a,FEQd6P)=LgW6CU(YR61K@XOe8(>1IYRL-9@Hfc5S7EDI<eHT8TGc-?d
OeNS@fOJXVc[&X4T[Fd;DGc=(DDPBQ#+U8J2=93e&5)#>[CM3HNQY,=,DINK.(ga
^>,6GYNB-]6I+RB&6X.926gJGaZ4_O?K3X3.NE2.9C0;29\]>EC\cWDP,\1TKP)#
)@V^=1a\M?/PKfER5:V<<Fb(65a+?@D,2.5&X#QfaK^[I>dELbEc5V72,/a_[ITE
&Nd=gSO@C9MG3V42;Q-/?L_8O8c0c1gS0AEfbPC\(Y9:&-0ENYD^?^-D+M_?f-W.
d3,c3;3RD7G?F/2^;.IWGgN==A1)dTFdVabC]XKYK8]7350/EU\a?9WGQI\P\?R=
_BIW/W\(;Td3dV)&ZTM8?(fMVZ@_]Q);>10f@]bGdeR,?OW.O,>JNO.:cd3Va8_@
-(KReb&I[;5FG=S9>JeK;]]FX6LBM6)86bFY,,@]<?;M>+=2b4WH/bWFN)0_Y4gT
cW]F9fL3:aFgM_&3.O\#b)Yg1H#g?)QO>EQFUAeTFT>KC#gKZ@Z.4_ce<OJg53_X
5\V&>G[#6bOF?K<+.9GE#EA;+<P087c06IS\SQ:.3OO-+>,^DY.(RMI=aU3&[JY9
4Gb:;?PF]>-L]P^H/GPc)8;:S2IRDD^IZ(-Yf1E02MN,9FLLRY?G5JH?SEYC0L:4
Ufg[T59O5I@91)E7:QA0253)?dKbCe1.^:<+,S8@CB6Rf5U;&#R(\H94Y99Q:b3<
()7^?+D<\#&LAFR2;DH?VY#X+#47[SP-K,M<I4>Y[]H]fC39GE(133[7QDI8J?9A
ga4P(Y>=#]=TdR4?]1N/XYSV>A;55V4\(cAX@U#XE&;f=+R:?6^+=(INY7\=Fg4#
,E=Ag0Q73bb)b[ZY(]L25,(54ASb1>e+WB;Pe=FEb@WJR8\=)-==gb[T-LOcJZ32
T29;_P,0-K#(KMG-0XF+B=b3FD=L@^cPTUQ&K@RFCH5POZWC@/40X-O+b[P+S@(Y
4PRg^7HDC[QC3eJ60^H;@:<]aZ>T)eVKK1\8L/<V7U_]<,[9VG-XKYNPZKC1I8eC
]TUdH@F52/E8UNCdbLd?F6\0KIO\e4/T+aXL\)IDCVR]A$
`endprotected


`endif // GUARD_SVT_APB_SYSTEM_SEQUENCER_SV
