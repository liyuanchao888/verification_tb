
// =============================================================================
`ifndef GUARD_SVT_AXI_COV_SV
`define GUARD_SVT_AXI_COV_SV

/**
 * Class containing the coverage groups*/
typedef class svt_axi_cov_data;
class svt_axi_cov extends svt_axi_cov_data;

  /**Configuration object */
  svt_axi_port_configuration cfg;
  
  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

 
  /** 
   * Coverage group for covering the order of read and write barrier transactions within a barrier pair<br>
   * Bins:<br>
   * barrier_pair_rd_after_wr_seq - Read barrier transaction occurs after write barrier transaction<br> 
   * barrier_pair_wr_after_rd_seq - Write barrier transaction occurs after read barrier transaction<br> 
   * barrier_pair_simultaneous_rd_wr_seq - Read barrier and write barrier transactions occurs at same clock
   */
  covergroup trans_ace_barrier_pair_sequence @(barrier_pair_event);
    type_option.comment = "Coverage for Barrier Pair transcations";
    option.per_instance = 1;
    barrier_pair_sequence : coverpoint this.barrier_pair_sequence {
      bins barrier_pair_rd_after_wr_seq = {`SVT_AXI_BARRIER_PAIR_RD_AFTER_WR_PATTERN_SEQ};
      bins barrier_pair_wr_after_rd_seq = {`SVT_AXI_BARRIER_PAIR_WR_AFTER_RD_PATTERN_SEQ};
      bins barrier_pair_simultaneous_rd_wr_seq = {`SVT_AXI_BARRIER_PAIR_SIMULTAENOUS_RD_WR_PATTERN_SEQ};
    }
  endgroup
  
  /** 
   * Coverage group for covering locked transaction followed by exclusive transaction<br>
   * This will be covered when a locked read transaction followed by a
   * exclusive read transaction is fired. Applicable only when axi_interface_type is AXI3.
   * Bins:<br>
   * lock_followed_by_excl_seq - lock transaction followed by exclusive transaction<br> 
   */
  covergroup trans_lock_followed_by_excl_sequence @(locked_excl_event);
    type_option.comment = "Coverage for locked transaction followed by exclusive transaction";
    option.per_instance = 1;
    lock_followed_by_excl_sequence : coverpoint this.lock_followed_by_excl_sequence {
      bins lock_followed_by_excl_seq = {`SVT_AXI_LOCKED_FOLLOWED_BY_EXCL_XACT_SEQ};
    }
  endgroup

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_axi_cov instance.
   *
   * @param cfg Configuration handle.
   * @param name Instance name.
   * @param log VMM Log instance used for reporting.
    */
  extern function new(svt_axi_port_configuration cfg, 
                      string name = "",
                      vmm_log log = null
                      );
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_axi_cov instance.
   *
   * @param cfg Configuration handle.
   * @param name Instance name.
   */
  extern function new(svt_axi_port_configuration cfg, 
                      string name = "");
  
  /** SVT message macros route messages through this reference */
  protected `SVT_XVM(report_object) reporter;
`endif
 
endclass

// =============================================================================

`protected
b.UW<3G\6>K]IJCOJMJfN8:.Z/FB3XJ8\.Z#NA6@dZ+N.A,W1?3\&)#3,:DUe7Tg
SLROI/8L07[QT9^&g)cY&#7Lc&@63Mc<VJU.7]2=/GH@(F1VW#&PAJVJPKROX#]A
1W?S@C6FNbPKA7E#Q;;cGMT@FK1MU42Bf^N?_N=O(8+<QYJ^,I0[Cg_76P9M/e21
1R\J]#^R<9g0B1[)9]I677?@VT4eQUM?7_#2+<E4WU6>MXMHcRXLZ&0a_f(8V[G-
)UC[eXIH5bd:]KP01A_?WC4[]&Z_64USAbL-MT4W@?D)US\#>G_?\CEAY\R5YQUg
W:Y]f3SO0M<O1FdSWHTF_Q5f,SN1S?d^U^K[(eA_Z@R+^ScPfF(J:+()X.\2,gN&
c9\-0dS(8NNcd.-0HJg^:A4U2I=Jg_+HfO>Xgcb,YVCQJf;Gf0_R&KUGH3QBZg-3
(>Y6T:A9@H_BM<6R:2#_cV]d[.]]KY+HV50BCeG_/T9gR14b]/KLN&KT&=72)1\I
\^GM=858OO3?(aSM=+IEUH+[fge&eQ>MQ\T_,2;^bbL,K6,:WL..^gJ@(4A@M3-&
(@eAW;H=>URa^Y?A6,_\8[e#44X4b>?Z]]T27UU3]3(f.5cb,aZ-@UTQ8IN+a[R<
2-JN.b;-/6LXKcS^4D7##,fKG22ELZBe8gdZ8(=5b0I4ZJ;4eg7FAZM1ZQKEb;#,
C\GZ49QCB[=CGXacP=;[QL\88I_9HJ<,KL2^8VWgW26P7Q@2gQWT4?W&=a.PQ(<(
PTDF+>6]#bVODfbQF<3\J?,@fW;Se4G3CdG[N8gb.e[6LCGd?NPMcYGd,DMQBP96
Z5ZLIL,8/5c]Q)(N<ZTH3V>-:ddAJ]PCLf\LMRY74;]#cRL/@6-4&2<8e6)59G4P
3/M<1eUARbVQ2GOY[2\O6\AFGT]BHE,OgdF.PO2MG40J#48]4N0,/5&)[DW3/?EL
GAK,Z0ac03&V<(R]\QWQU)Vf1R#H;c_>V/bX=HJ.-0J(SPf.Pa#@[E@/#<,S;NEe
^04+SM)7>EJR+=@ZT_eDOMFe1HW1bfgWQIf:DE06USUP)K2SSef0E4F?F]Fa[K4:
7H/[K5;AbB:/;Z6QE&aUXD^=be3;F>>0d05WO/>9/<-:BW\#J<N8F1gdHUM6d;DO
EHU2,f_&X57Lc;8N2bcT8CFE<0:E-MC6AR07?OABZ:38K01=_fJQf#.]/K9X2KX-
L6)Lf,8,G:15DKJ2N_>1JgK1OaPIAN5HF-@UDFW/K>U0,9fO[0L(fC69)CD0^VJF
2O)3#S=?gdI5.$
`endprotected


`endif //GUARD_SVT_AXI_COV_SV
