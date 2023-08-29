
`ifndef GUARD_AXI_IC_SLAVE_SEQUENCER_SV
`define GUARD_AXI_IC_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
typedef class svt_axi_ic_slave_agent;
typedef class svt_axi_interconnect_env;
class svt_axi_ic_slave_sequencer extends svt_axi_slave_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Fifo into which the IC Sequence pushes randomized transactions for the
      interconnect to consume */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_tlm_fifo#(svt_axi_ic_slave_transaction)  ic_xact_fifo;
`elsif SVT_OVM_TECHNOLOGY
  tlm_fifo#(svt_axi_ic_slave_transaction)  ic_xact_fifo;
`endif


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;

  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_ic_slave_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
 extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_axi_ic_slave_sequencer

`protected
XL76/Z=Y>=/b?7H5T^dPJA2Pf/<EA1DN<bTU[A9RQeDf^V397dT>4)>>X14;#XME
a8X:KS@NgAX?0H>.4cSKKL4B(9?BG/9JbcLI3KLS_Ta,]+aZf^gH+K/Lf\/O)8#M
Idd_G[>5Q;C,+4Ne==1eI3Ha_RQ0H:_5#>2,&._2W;6#HCP?4g-UfY)CJ/e;PFTQ
CTa(A8GMWBFJFG&^P/SW3M_<;dNOHJZ7>048Y;6#]-.)R&,CPcSB7-/8K+6>F;Q9
JRR#@<Se4aF.d<=f)WDJTG](NEUDNAC8R8O/=-Ofd@(<Q(7C5(Y]6YFg:^<.DLG[
bEP6Gg;KK.<4+Z?[)XQ[5eDefC6NS6_LXg-eg\.9Od.;-[49)V0SS5@E<PH&H28\
,aV]64FJ-_<efFU.XNCf(J<E&5+]3XGV(H;b4Q/3Ga(;D$
`endprotected


// -----------------------------------------------------------------------------
// vcs_vip_protect
`protected
3\_8V1fH=7da:/017Z,ETW6FRN8M;E5b<[=.6.,SII7/1:>b,3964(Y&3GK.\c:<
I?(M,,4D--FUUe+P2\A:C<8f43+SeC>1811f\6-QU.>H=K5BR2HfQH8+\M@CAD+Z
X[>]DSO/8R/]Z33EV.FE3H<PIF>NII.UJ<)W224=ECT7?.OR?#EO?W6Z7O.Z.e)L
6;<JWCMc71>Z60a8//HRVTe>R)g+ZF\T<4H68A7gF?CB2B^78e5@EGAe#?9D-=&f
EaIc8\_EQ\:YVgR-;18(e]gbEWDJ+3E+<6)&d(L;g/CcMA.Y<KQK=81S?PJTT1A7
D5R&MO)/8^;P&=>FdT3KK+aI4PG2>KQ33d3AP=TEe419(39EY[P=L?CL.HQ>E:CA
fR/=UE8)bbbWPNXg13+:[FEIg2:?O4.(9TZ=R3.\PW>I+fgK/b-MVRT4e6RQA7\?
L7LK4T8T]-=I/=K-.\+^Q>/cO6;DYP51WSD]..1H#47HB-S[7WDgY6bgVfDdRLcF
[H5RaZ^PW+C:LRSA&I7?&QJW_.c>:AG;HKC:7@BW1LVY.@cebS&J[/G_Ia>?Lc\W
6_PY\WbTCPT.R7[F_gC1\,8JbRV\N1;6ePIa0Kg=KUV5;+C8:DPB=f]9:7dGce+[
c)XN.4#_cEN3,0D)DS)?HGELTD6/@ebQE(4\A/fET60^_F6R<ARHcLd:g]<S@VY#
OMF3^_0JTA70@Kee.5:K]AIS&3BSC+),@ME>cE:M9.ZCfBD&8.dJW@CHE6fgG&VB
(&aU2]/1/THUHfY56P.ZWL;W=gP?)YBP.C53FUUOF3BV)OE^V^^5#W@8,__LE^JI
+:,TNNM[.IHFI9,D4KK<M)O.FNZD3Ee2G_D?6SJ0]5Me&^N446FU^.Q=@&DgBdAg
gQ>H#b<<BT1SRJ5aKB_>]5AFbOf2F(gK#Y?X_R]75/C&FQQB\:JB96K49H>T90UM
NT2aPP\.<bbLN>J86<[SRR;Ta^\80?DJ86bCJ8XJT#TJ&?/P(QO=&+@-\DVC\:C#
[Pd,5FPagF=]>M++Z(b1F6;8)R?ZCPO/88BS:V2R>0=HRe+-U]ZJJ:;5)G?W@J&4
;Q)99Q:)I74Za+f<AJ:K@a]0=WOb^SZ9X0=W^a6HQbeR&SNQ4J#b3R8<,Eb&@EBD
[TD&/MPc<8(RNWH/6a-+g:Qe-Ld&R]\d>e2OVf)NSRU\?>5)0Q_A:GM^)M,>\,#d
E;0a>Z.+Ed/GBHM)=fE]0I)<b/d4f#F51UISF\L4<4R_A(8U@4J?g4PR7B,DaI9@
1(>d5-.,X8IVK,G<ALTXL1f44WB:G..578^a.G3<a)3Bgc>TL3HMVB2L8a5/Le->
]JQ?dY\f0\RU6^V,-3W:bH-L@:TSH5LYG;@\YE&35<G?<>/Z<52#<2?T7UKIXcTW
B&J<Kb+<Z=RVM#V_3]BX81_[-HZG,))Uc&[=YaZMFIQ+LA5=O6F\)FN(F\.AgTMJ
CTX#E<FS[EU04a[<ccTXQbZS6AM4J8)<YKSCd=9SG(),1WdPUARU<[&R8g9NLOJM
0G<1;/;IDOJ/EYYe=@(d7CQYI-e^I+B(TNEc<dM9SJWRe0Of6_/CNaAA0FdX\c8F
Jd:87:JMNLaG?^\]1bP5a?A[Ce>1J1F;R,DCb.#RQC(D[@;EAKZK:9a<-f+De&DJ
1/&EN[(MXQ;XdeeCVN-OB\;?V[LC/G:@PPY&7.+]>,^EUd\HeJ8dM?f[N&E>K>#7
BCQ3=W+TKW@9G7^S1H5WEXeEg6Q9K<cdE[daVS[)>D5+gDM5SdI6Pb)FcIND9ES#
]fee18f/bFa[?>55;],gHBB1G.#,D8.1Fe\AMOK4W,cH@S>S7BV;7AM#(32N;W_;
b9T8Y#H(gM>OVd.44-8K,5_0b;UaST)8+-[1U;HWH-DeT/FA\.eV>0NGAbb6]Adf
fYO87H3.1=YgNFDE10-RDF#b,/6WNB6WWFR,C,:7/L;S-(Q>Q?7>eI9F],?)/>-a
\/K1X&?I9aQ/aT_UU;EY_6>#2E>B@J6S9JFV:3RZNBTY>)N[=]J[bcZ\:3(I]UHc
<^+#3P./463[234Eg@dAf3]P.NWUU&GP0:7W\CUT:MfJXP69dC\UP8L2#CV9]\2O
3D22_P.[@,.\4JfPBUfCSCZa,aXPgcY1SBcc15W;VBd#<MZGF]E(?:TgB1a6,,:=
DT\gGcVXg#cO&W))SB<+5B]<L(C3?&46d9VO<V_:9,6=:cI<VKb.L/./;Ff/#?ZY
LB+E)>3/GFJ4g6,Ib./@P.6bgZSJ)?WK#G)CZ(<I#=&1ZeS?cZ.RRKbGa9UAJ:#_
Qg#/b/FC>MAQ-J.L#=E)^Vf#EM4c]4O3g0T,QK([@M>)TK8S#TL]e/BS./]aZRL8
XE1bJ<BY)R)FRHf)=8U?cU:T0fHcF]bW&d?+LMLO?gH=gI(0X@BB,8E?5[TdX\0P
g(6MNa(F-.9Re9c70:N>E-:/MZ+FbJX;)gDL]YDea[AM/4+5:Q6?/7g\)WW/.>]\
\8&F9SbCY+X/Vb;BX[)9?+N3.YZPUHad&F^Q5?<9Vbg(B1MY^(72LK6IdZ5XAF=a
Te2K/6Pd4OA(d;+CEA/MfGDX;3J<:D,R9YSE3V(MGNK];V]5DC,AL>=f4ag7YD7,
fEK;0W-[^#7E\R->b5<)<6?G@L#YG\a@;,+[2E3UVCZ\.:88Og\R98KPfJNZ8E,d
-=J]4[KQ+]88#;^JNFLHaWFaIUH>.]_A5]8@=>d8c@JN=]NcF2AXI7TLdeSaB.g,
YG_MVQ2CIb+)Y_L]0DC6Z\BA&7/e@c34>T,?IEW,\BXJW)\:-INOW]^UU</M&5-.
bNDG<e),5_8A5SK/L)?LF)U7_S16A65I0N(VYSBdBCMJ.fG=KMV,Z5B7ODE+DQ+D
]#U<baJRSf832\(KGAY_5)@.=G[fX/Jd6eTeCZPCcD9XY@L-bV8]Kd^dR?A[;\F>
2g^O/P=G^L84:B&fgP+Z,_T@_&(1DOe-&[C9I,.(@X8baM_LAO\#Hf&.Y\[)CcZU
SC-6LdM,[d.:&;a.SK].)O23KF6.?U4N[:c@&&<BJ.?U6(R8W+&VXSK7V_A\W54A
YTaN-\LX,Ebd,c0#aMc+UBe/UA/5@L1^)edX#(1FKBS:LEX,\#2L8EK7P$
`endprotected


`endif // GUARD_AXI_IC_SLAVE_SEQUENCER_SV
