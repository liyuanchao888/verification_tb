
`ifndef GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
`define GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_ahb_system_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /* AHB Master sequencer */
  svt_ahb_master_transaction_sequencer master_sequencer[];

  /* AHB Slave sequencer */
  svt_ahb_slave_sequencer slave_sequencer[];

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_ahb_system_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_system_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  extern function new(string name="svt_ahb_system_sequencer", `SVT_XVM(component) parent=null);

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
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_ahb_system_sequencer

`protected
1B3PHOAcaa,Y2T__+C/BUP7Y6c::>9/;1Z6(Lc4DUf92g,?R+CY+))F=;L#C6fGR
^A/1HPD@bcg^QIT68B(P]6]?WIgXAb7C^:g^fET]b2?dB[61<_T[9QE9V@2]b?F[
aOT_B7LPRY8OYU;BFTOf_fT1T^4H8X+[SMJ7CfZ&I_170T.><:a_0Q(W]fP4dD0>
WI)EU-M63K2-Bf)E@-Q5<2PCY:3=QM:e:L?7(c]CGX;<M<WZ32@f=22>:I>\fg@2
e88:KcG#B+d:0VV_&JM2_>SJeHP/Y/FI@N<c)Qa<\69E8RMbR->Ue&W^+g2\407L
S^MP9/J-_a):C?S\>7(GS?]9<TNO:P&\:$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
  `protected
[(#B8^+:I=.9L<?DQW<CeJ/2Z(-daEYBJZ>9/6<X5_>3/D^>9_,P)(UO?JCbQdd&
/GH9).,T?X>UPD<6dcAYcC+S9JJ>aD&b=fZX3)&bWF)L5d6T+/=.DU>H94[N(ea4
3B?M5S<Q?O=@bdD(=U]NKbDJ,:OXX\B)]W-7DX<a&IbOb,G:6=XG0^SZZ^BO862(
#)5]H0:#Q/UC5B-842gGQ1F#:G9_>gN+X/adAa783Ag>Cd]Y(<G-L)UBf+WX)8^e
IX[T_YYR\W[X<dOA4+8]8cX9NIF66g\b<P;V&Fd[7A+-JdAaB_QP1JJ?3;bS-cNd
SC)J.5G.aZQ43+eBCA5/#8]FV7.TB;T5KD[<?(B3VbfbLJ9?CKOA0f?K@3;/Xb=1
G-CQ8)=W[29D3CD^+DaTV6)Bc<8XCAgH&MKRU<1Z3I80B)K9O]+\cS[ZC&84G6:[
H\.Xfd@OA&@[SZNeVcM&baF)b0E9@+]HM.6@-<QP0K)Z(7HK52SINRe=Tb<KDI0<
G]O@dR4VU_c=aMGUT>D]0&J(5OR_@HQMed0+TN7#fT&NXIOCVJ+D9I-M4MK.@6gI
W4CG4/Z@YVaDHP#SNFM;PB&\XRg\ULYSK#\cLZ0W.^>?H(SF_/#;83(=.MBQS&Ud
KcBV2B^aP,ZPe@GJ,-RTPg@SB&(NG#JU)4E:;:/@ET_:LJ3.4S,&\<,&f0-8UXI]
(e:,H=A^EG<,2@W?6SAO:DAY(bW3IP&^/B]R?ePdMP_Y3fgTBDf.Xc@]JfI></>V
P\.b+CaX\1AP]6BK42+_H:+JcF)+P,0@2T216[N9bYSb83<^=KO_M3SNU>fg8YS5
JAV]EW\7+WDb65b\]A.D+1OI-1Ca64V0=DUFNbSVE07K[1Za+B_W#)5aa.QM@Z&Z
.eDb&;(R>e:\8CP/AYWYXDf-?=6TB&S9IP#gQ&V7<bZO<E_ZW;MQ[Wf23HK<&?WL
PQ]I=?/9b[9LRKV1PA8LYDN92NSXS\bX71IIT\+0>JM7-8W8)G==4\WK,3b;X+)H
KUC_7/Cfdc+6eFgJ>;ZZPM:LK&eT/2E:=c(GDbB#>5Pc?Q,=1:-.Xef?1U5ZR7G3
BNKY9C;@9KOJ5,^G(]DDb/@;95M1\T>]e9P-+YF<c0#)<#_<3cc/<d<2+7>Y-c]^
B]fI_L8MY=0(Q6^?PB&b=Z:>ZWF<4#_TE9NJK1b_1#Z&]PL6_^2<NP[3Z6,dK9MP
I#+ZTHBcA)R(+$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
