
`ifndef GUARD_APB_MASTER_SEQUENCER_SV
`define GUARD_APB_MASTER_SEQUENCER_SV 

typedef class svt_apb_master_agent;
// =============================================================================
/**
 * This class is UVM/OVM Sequencer that provides stimulus for the
 * #svt_apb_master driver class. The #svt_apb_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_apb_master_sequencer extends svt_sequencer#(svt_apb_master_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_apb_system_configuration cfg;
/** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_apb_master_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
 extern function new (string name = "svt_apb_master_sequencer", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
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

endclass: svt_apb_master_sequencer

`protected
SWb#f4F@9SX.,1)#Vdg#/a]P#=dFIe:M0JSV</bJ.>#]0]YBb]K1-)7L+B3KE:+@
4VeG2dA@TOcc2H,,XB9aOFEa[[TNKVE,@VOS.;IZRE#_<VBD4R/89b(;b<e4Pd-V
637XET[25.Nge(V=?O+NZ/(f78GY\&F/Na\+eG1=BFHC]^MO,#8X91@?UW,3aEC)
M)@IaEaN8/3].:f507?\afGV1<[O3#3gA#6SI[21LC7a[RPMDS;Q^M(aR#_5<F2\
=b5f>:;R642@#-<MY1=>U_RXe4GT(.<X9C&KQ<9=/BCY=YT^(S>.0\d_3&N<(4>e
[2D#/)BTZB#_5K,&/e1))0^Gcc,0-\FN;$
`endprotected


//vcs_vip_protect
`protected
>GBFTG&bQ&B8CPd2629O#QUXGc2^)GV./+08ZMA;2ff5N.fAV;[S6(3YT8=+&_gW
U(;(T0Q[:<?9&J=ZD2eC_+EW=.26,3:gMG;=T3BYdESEU8KDV7g)W_>PTA#7b_-e
4e1:XRVgD<\M@(JZ5NOVa+bWXPN6X3^OcQ@^N;53Q1N.=,^\X(bE<\_/g7eOVDY[
4A\0M_30()]CKQOMI&(9Ib7],AE:AM<AJQU7eRO//ecMANF;6Db4d]\G_;,fE&^]
T21KEP0=9R5OI<aT2=1L<YJF3CM.><1[;;?&CL<EY1;G^#C/S;g7_AN>^5T6-]2;
19FMU952^[aPPB:dT(86X4=[L)\:3JDC[-N\gPf0;&?XR)\POTANRAS+_:[XKHdV
+L]:[V=5^>L&gFN5U+8N3(1g5U[PGQfL0AGP&;R.VRR&J[20RX5IMb<AW(??]01]
ZZTE9I[8;\P07PRRQ&KF3_.OSJ51+>)><FT&2TGFMfZ7[AeO(+9NJMLU5M@?IIX(
/6d_B[&NM,1E;E[D\_c<RY/QYTP&BdAg7UU)da:b-a3.A[6=f[C6?Bb-[33e)7^P
<,L\e5IVL4T[Nd6D8E_)D)&[7H5X.aX&2XeD:adB+32D)QXS_8eeR:WQ-1>?F>UF
H]L&S.-7HgGCdW@_c((]?U]^I()cEBS>[+UCP,J>dL3FNT0E@,A[@XK>6B#-NR1f
IP^)YgYPJ#DD\a3Y^IF1A9((&fHV>M[ceR_b,#JP?=8XWV1_6(X-aE]4G?5C(eL;
O^+N22bU66E65;Q\HM:LDJ-BA\.OUJ)[.f67P:Y6<Ic5@L.ZK@adHOV)eL&GgD3U
b6,#a?)/?SOK(@PdSCO[CCVHRSa9Hg5(->d@)>9CNLdMHLadO^TB9=eBVNeBB;f(
A11(D7P)9UQ(G:YG7&&:.9].=BX4\7R)>[><0dL[P-+;H3;J\92>))5^YLPAbfUH
4JD7/ZNA1?.4@)d2KYO4Jf3V[RU<XVIXTPQ@3(QH<^bga.E3Af5:#f):3#>LTaWC
AQ?0\EeWP:.<+g<Q]Y<>YH64>/EX+)NML3^_D<7,K6aCH1D:AdV:+See&NU?03FF
8-N^bOP69&=/Q^.Se9F/d@D+@1ID)VJB:SN&A:a]e&NJ[?=?M6=^UcA,MS]3(R4W
W;4#=XCCW5Nc4UR2];dQA^>b<MM(b^0)(UK:fg&PT_+-CNc^g(2S6OVg+fD1=cFb
BH/0/4OKI1eQc\aD7B>?Gc-DIK?8J(U7-I<R&M7#Oc6eB,2FEU#]B15/FK8X+8WA
Z6:EM^g?+#EW#(5YZTf/a=R>e>D0aeCH39;c/Y/Q)<0P.LcO;TB[53ER\O5&.2D<
-]IBE&WfUNJ]9E3YKf(6\L<0H5Sd\S9KJ]CB.#5C7L\;:XKQ+FLMb-IR<1H_39O(
[][7WK3:J4FQcRZNYPRZ<O_[R#S3-c?C<?BdB(+VCJ/3R&+7WI;<5\6Qf+6)N)JY
76V[GWAeg6_e:59\.2FEZg[_QcXW[7CAA7QR:bc(_V:3Wc^.5LO14&da=:F<)R=2
S5<Q[<KP8]5]Z)P\:.X#D.LQf5F\8,_<eLEK:GZ,:XfPPQ<cEI@<R8GGZFS.9F:_
#bA6Q[5dNKOSA0Q&JfWg&J@N[G9ZUHER]>CZ<Tf:V(U5+\VR?WaFJW,N0([Z/aSP
T&I,9]Vg\dV+U)7#OO#g#-5aD9^V9aTM0gQODBJ07g9#T+42D+:G?B&G#/04Mb,B
4WA^@9.NeZR<M(OYE[2gZ:2.U;B3M[6Ka(TBVBL\\57OVBUA(8F&cJOeILX6)Q5[
;B/@0ea[85V@0BU-#dW)=^M9W?AK\:b&0JN0RTb^=T2Z0DGdCYdNE7XB:ALSJ6LM
)0Gc(U0ZdDcK)e.0+B,[Ma]7HR9;_NXDX)D/-BF&YF@a/.#c78V?F6K?,8,T0>d?
SF3]S+>+OF)A(@,.ebPGNX_CCa2dK@;\^ABGY@USQ-@]aL,bOaa]5gf94;THBMEd
AA,7a>--(2OXU+IKgc0@9O1G^[]PS)]c14ASR)8GN2e\HI1REMO<B.B#\9@];H3I
G4g/1TAH2UW]0R,[.5BV9?Z9Y).7W,EUCLeI6Q7WJdL([D8@&FH<3MdOZD6BgI7.
d(BDWY_B^@^X,G=LL.-F[7SR4eAW\6[bYWPDa,DF+H?9;@Y_FN+,S^Ud743I)3\H
O02Z9U^Q@,J]aXKCQ@];C2\JK<7WS8B]7,4OXIfK7K:9[:f6T@OL@WV75L#^]L/=
fU]7gc1NR152:,2NBbTUUY0\CO\1/g2gN1a_A>(,4NbXeM40(MN@T9<A#2)CIcUc
KAG>4VgHB.^4_@^M[4RW<[_0.E9W&DBcEU2(MK(IEH3Af3ZfL3OLC^S3&aeJTGfH
@)KGF)eMRW,]:=1G),g&6O9ZfB,SZ=PgO:<A6T=0L>;AS0DJX]N#P7W#/aD<Q[(B
0;54LHHd>V3],$
`endprotected


`endif // GUARD_APB_MASTER_SEQUENCER_SV

