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

`ifndef GUARD_SVT_CHI_LINK_SERVICE_SV
`define GUARD_SVT_CHI_LINK_SERVICE_SV 

// =============================================================================
/**
 * This class is a service transaction class. Service request classes are used
 * to describe the events external to the normal protocol transaction and data
 * flow but those which the protocol is designed to handle. This service
 * transaction class supports following services:
 * - link activation/deactivation
 * .
 */
class svt_chi_link_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * Enumerated type for link layer service request types
   */
  typedef enum  {
    DEACTIVATE, /**<: Force the link layer to deactivate.  Ignored if the link is already deactive.  */
    ACTIVATE, /**<: Force the link layer to activate. Ignored if the link is already active.   */
    SUSPEND_REQ_LCRD, /**<: Force the link layer receiver to suspend the transmission of REQ L-credits. Applicable only for SN. Not yet supported for SN. */
    RESUME_REQ_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended REQ L-credits. Applicable only for SN. */
    SUSPEND_SNP_LCRD, /**<: Force the link layer receiver to suspend the transmission of REQ L-credits. Applicable only for RN-F, RN-D. */
    RESUME_SNP_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended REQ L-credits. Applicable only for RN-F, RN-D. */
    SUSPEND_RSP_LCRD, /**<: Force the link layer receiver to suspend the transmission of RSP L-credits. Applicable only for RN. */
    RESUME_RSP_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended RSP L-credits. Applicable only for RN. */
    SUSPEND_DAT_LCRD, /**<: Force the link layer receiver to suspend the transmission of DAT L-credits. Applicable only for RN, SN. Not yet supported for SN. */
    RESUME_DAT_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended DAT L-credits. Applicable only for RN, SN. Not yet supported for SN. */
    SUSPEND_ALL_LCRD, /**<: Force the link layer receiver to suspend the transmission of L-credits on all virtual channels. In case of RN SNP,RSP and DAT channels and in case of SN REQ and DAT channels. Not yet supported for SN. */
    RESUME_ALL_LCRD /**<: Force the link layer receiver to suspend the transmission of already suspended L-credits on all virtual channels. In case of RN SNP,RSP and DAT channels and in case of SN REQ and DAT channels. Applicable only for RN, SN. Not yet supported for SN. */
  } service_type_enum;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  /** 
   * Weight that controls generating Link activation and deactivation service requests through randomization.
   * Generating Link activation and deactivation service requests through randomization is enabled by default, 
   * through this attribute's default setting. 
   */
  int unsigned LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;

  /** 
   * Weight that controls suspending and resuming LCRDs through randomization.
   * Generating LCRDs suspend and resume service requests through randomization is disabled by default, through
   * this attribute's default setting.
   */
  int unsigned LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * Type of link layer service to perform.
   * - When randomized, the service_type is controlled through the weights
   *   #LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, #LCRD_SUSPEND_RESUME_SERVICE_wt.
   * - When both these weights are set to zero, there is no weighted distribution
   *   applied by this class constraints on service_type, and this causes all the
   *   possible valid service_type settings to be generated through randomization.
   * - Also refer to the documentation of the enumerated data type.
   * .
   * */
  rand service_type_enum service_type;

  /** 
  * When this flag is set ACTIVATE service request completes when TX state
  * machine reaches RUN state and RX state machine reaches ACTIVATE state. 
  * When this flag is zero ACTIVATE service request completes when TX state
  * machine reaches RUN state and RX state machine reaches RUN state. 
  */
  rand bit allow_deact_in_tx_run_rx_act = 1'b0;

  /** 
  * When this flag is set DEACTIVATE service request allows the link active
  * state machine to move from TX_STOP RX_DEACT to TX_ACT RX_STOP based on the
  * dealys provided instead of reaching the TX_STOP RX_STOP state.
  */
  rand bit allow_act_in_tx_stop_rx_deact = 1'b0;

  /**
   * Number of cycles that the link layer auto-activation feature is suppressed when
   * the link layer is deactivated due to a service request.  This will ensure that
   * the link will be deactive for at least this many cycles following a deactivation
   * service request.
   *
   * Note:
   * While in the deactive state, the link layer can be forced back to the active
   * state using another service request before this minimum time has expired.
   */
  rand int min_cycles_in_deactive = 0;

  //----------------------------------------------------------------------------
  // Protected Data Prioperties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges which insure that the Link Service settings are supported
   * by the Link components.
   */
  constraint valid_ranges {
    min_cycles_in_deactive >= 0;
  }

  /** 
   * Valid ranges constraint for service_type.
   */

  constraint valid_ranges_service_type {
    if (
        (LINK_ACTIVATE_DEACTIVATE_SERVICE_wt > 0) 
        ||
        (LCRD_SUSPEND_RESUME_SERVICE_wt > 0)
       )
    {
      service_type dist {
                           DEACTIVATE       := LINK_ACTIVATE_DEACTIVATE_SERVICE_wt,
                           ACTIVATE         := LINK_ACTIVATE_DEACTIVATE_SERVICE_wt,
                           SUSPEND_REQ_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_REQ_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_SNP_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_SNP_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_RSP_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_RSP_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_DAT_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_DAT_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_ALL_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_ALL_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt
                         };
    }
  }

  /** 
   * Valid ranges constraint for SUSPEND/RESUME_*_LCRD service_type requsts, 
   * based on node type & interface type.
   */
  constraint valid_ranges_suspend_resume_lcrd_service_types {
    if (cfg.chi_node_type == svt_chi_node_configuration::SN)
    {
      !(service_type inside{SUSPEND_RSP_LCRD, RESUME_RSP_LCRD, SUSPEND_SNP_LCRD,  RESUME_SNP_LCRD});
    }
    else if (cfg.chi_node_type == svt_chi_node_configuration::RN)
    {
      !(service_type inside{SUSPEND_REQ_LCRD, RESUME_REQ_LCRD});
      if (cfg.chi_interface_type == svt_chi_node_configuration::RN_I)
      {
        !(service_type inside{SUSPEND_SNP_LCRD, RESUME_SNP_LCRD});
      }
    }                                                        
    else if (cfg.chi_node_type == svt_chi_node_configuration::HN)
    {
      !(service_type inside{SUSPEND_SNP_LCRD, RESUME_SNP_LCRD});
      if (cfg.chi_interface_type == svt_chi_node_configuration::SN_F || cfg.chi_interface_type == svt_chi_node_configuration::SN_I)
      {
        !(service_type inside{SUSPEND_REQ_LCRD, RESUME_REQ_LCRD});
      }
    }                                                        

  }

  /**
   * Keeps the minumum number of cycles in deactive to a reaonsable value.
   */
  constraint reasonable_min_cycles_in_deactive {
    min_cycles_in_deactive inside {[0:`SVT_CHI_MAX_MIN_CYCLES_IN_DEACTIVE]};
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_link_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_chi_link_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_link_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_link_service)
  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

  /**
   * Post randomize implementation of the class: prints the psdisplay_concise().
   */
  extern function void post_randomize();

  //----------------------------------------------------------------------------
  /** Method to turn reasonable constraints on/off as a block. */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging.  */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_link_service.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();
  
  //----------------------------------------------------------------------------
  /**
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_link_service)
  `vmm_class_factory(svt_chi_link_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_link_service)
`vmm_atomic_gen(svt_chi_link_service, "VMM (Atomic) Generator for svt_chi_link_service data objects")
`vmm_scenario_gen(svt_chi_link_service, "VMM (Scenario) Generator for svt_chi_link_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_link_service)
`else
// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_chi_link_service, svt_chi_node_configuration)
`endif

// =============================================================================

`protected
<1-:JV;4(EXR8AeDbC3c?UU,CV.RV#fJ#d91If;D(+.<EQY:::Jb2)>]^\ZgNWGS
>Nb,JLbJL+afLEADa>Tg\e79HQ9PVWabR0UH8DG#DA)ED;,18Tfg6/XF4DSg_@GV
:\>SJ6WE9a[@>I5:=,(eeb8]3>@>D[<cG:JIMVJc0daJLID(fHg0MFde)b]LUSO(
ROfR/dYPg>O?d0AO8^?WdY>KD^\=,T8AgeRMd6IXD@]Wb4NCQ\GKVCPQ(dLO9E<Q
\;aXLN4/?B]TCK[6[IMUSf\W-364ESO(L(D.#/75Q29^F[UHW,AQC+/G?=O8\/</
Q\FY_:I89@W@@;GRPB^E=;<GQda;E&RF[=IRD4S#AE6_8?=>PFILB00,M&<.aKWI
Y2S?ICe]WQO0XDZ7#QT4Kb4ab:(&P<4-VE548=>CE-TV&V\_d+8[\<>SAHgG1S&S
JCORJTV7SFTX;>AXcEd5J8a-\#,NK:PMN/1HTQeWGT=>MHeT,)f/WdMXJ11@2c@\
JVa/@QS+Y1Wg6gNJ0USE9PN0QbX6,9@U-DI^Ta>C487U+:DH/[HZAdfK;AWS>#^3
]?ET6DC3FI86cWc0+LT=]e7>RbP:WZ=;NMX=I57&,13?8Pb+59N-/VL(<HLdH;ZI
Q2gY<>@.@a7T=IU,VBHF-]9Wcdg.;Bd)4[Q?43I^NL97/0;[+Yd@I3:a73Z7M-V5
\3I8H.EUZ_NJ+,3NPB_5dV3H:^Q-dI/IHA&9?4OW0JL9g:/?Tac/VX7N[AeBP@8V
SH5\6BQOB8aFF/K@DdCEF)(DJ.B9>H9(-R>DRE-^L<69C$
`endprotected


  
//------------------------------------------------------------------------------
function void svt_chi_link_service::pre_randomize();
`protected
T:;cUDVEM)E(I/f;FJ()#=@SeV/PCOGf+E;XEC&74/Z/@cKQ;7H?))?C<a#D\b5[
F0MF3.,+fQRP#F1&gG39GC((?UM,D+#,ZO/L_36+gF4L;_2ROFF0FHDZ.FB?]?Ab
c[;Ugc+2?G/?d]0_R)YZX,]UW274Z^K3:>=?RMD_987,[1[d<H_-:^A@]&daK&\(
NL8(7SK1B.NbP3V@DaFA[T8K,OA1?WPeZ^-\?2HN19U\=Ef7Q=@^M_/KWYWa2\X[
@NY/3BgG^KgN12)DN/B2,\Rc+M(5S33B_0O2V-7F^^WIED/VYHdMF,Z-IJP(fIA-
P_1_3XS0SaAfENQD7(-eQ1W:\@CL3[;#Hb3XIQ<a[&1^U,MJ6Ef#I)0IcDQ),)C6
#;6D52(#)U6@NW:YAU\)fgL_EF];fCD<0.S;G&^E(0]^SRZPZZ8:^+QZO>g2(a1M
\E>a10\<A_M_Z&#[ceg\;#Z9FQ&4,0&P,7-E)cVe76];<F.6dX2-)[3J]d2/U5/P
NMQaa#CM@.SdB/0KJ)&\>Ra)[2(=;KF2aNXL__.C_/3cW-X1T+?TffDe&M1IM[R-
@MHD@/EJ?J7WcG(O&U71TDNV>.:LAB^(;$
`endprotected

endfunction // pre_randomize

//------------------------------------------------------------------------------
function void svt_chi_link_service::post_randomize();
  `svt_debug("post_randomize", psdisplay_concise());
endfunction // post_randomize
  
//vcs_vip_protect
`protected
Gdd_EQ&S6ZISccBT:2IJDK?[+)g&/FM@_#F8T<@Fd//_V@7D#Y@R)(8;eWA[+9e2
)A>[Y-b4P857ZQG)LL3&O-BZd3LSL-aVQJbE+beWe:WSYK:B]MO@6N;59a@3KEbL
YC:<;119=74B1Iac0/]8Q0FfLSDEd>Q2A5[;=d/d\7K29U6#g.CR4K?ScA#U1582
DD35EbP,?/Zb77ga:3@Ife,d=1_g;>O3VM):8U/49.f_M;@08I@27HIH\afE5KV&
SgD4QW6INSdH:D+JI>=:>_#9Z7c73;E<Y\L;+_.bKB6G>a+ZTOVHR=]LLUV1K,V=
4WS_\)V3PVL8ST_ZOc)<[]gQ=<4+Y3/3PR@QQQTbBAMG0=F_J/e.GR.gNG_2JEG2
AP7#?2OM[\.[AcMc2,):EMbGXBJ9:8JARBPWQ=Q,HL9D_>Eg_b=_b<[@V7e>OY+5
)#^U@fET&PN(,\[ZO7,KW9\1b@d5XWMc>V?7-#4ZAg\f-ULc#ITA/\DJ^9TSYLeV
V5.-AK7&6)T7WL7?70L#2L;V++R+I5EX?7BQ[[S+b.aEH_,:Ra=:Q=^WI[@7YCG4
T@/Vc+\FI&]JL>-K2L+PCN13cY2^S<(TW5PO5D<fVD8/a(Qc5K=.TcDFAd3_HH5S
^EJf]f0&;&ZE31@bgB^8;W_VFZN4#=f:]EJ<R,W0fdI<4>6BaRW0O8QYV6_?=CM&
R#E]:L/e3GR#-FI&g//FaC3=.5;50)01Y;5.cO>,Qce7VH3eHC,PC2bgJG]ILS)+
I]>?AfS#QM;,bVG7DCX73a,^H_E<,:-@)OTWYS-.>?R@PQJN=/BI3g#HK;O9&7ZC
W+D-DD(eE0XMK&IL(MDNb#1Gg3&CM<@7.@\&;IPE9^@AfLb3HgY.Db^<H+9Q#O??
&[6XLOK?bXXSaV7AE;8c6)d<+b=1<.<[\+6g/ZX2I_M4a\fb8Y_QCeGBOC>=BNFF
1B\GD-S)3]b/GO].=7#F=4Z+G)@3RU9UAG2ObV9P5:JQd]U@MP3J8-XDCP7R_9TP
e<[G.5ZYF#AaAf,\;G(b8G0RSbM#+7.2&ab^N(+S>aOB0?IIa2/YZ=;eSCU=<9YZ
(4d5-+?g6CKQ>;7_K/E_bgKY7c)fSe9,<9J6<U+QW.FDLUJU6X)@\Q)70N[CUJU_
5)gS:KJ<b/NSa[QA\=8<HT<faU(UQgU?VAH,7Q<SPS._Q,:+efRU=3fLcJMH_YWD
GBI,53:4B/PJTa@SNg_FFB1QD;M-7[8<C[XYX45XcY,5MHDE7+SFf4QA>UNMFY)g
&HbY:[FDdS8>cHT<O=N<:G=:)F64eP5Mg.ZJEZ\DV?b5^?b8DPPGW7;3@[VH61UY
f<<//b<P7\-38g&22^,OfAB,@:;,dGPK0_L1,;aDgOAMIQTgJc.?ME/;1_7ZH]08
:5XY?6aad:U9BK;aeJd9Y^<5f9b/U7SQE2CW2M-afWB&;&AK.CV#a:H7J)73ANM,
W9L5-64FHbU\]U;)H)(eMdcG?2XK/Vg>8<?^2V9I,A/6]N]FeOV68/)&W(EC<9+[
?A_M?S(;VUG6V#)Vf.B.L1GRcK0SfV)PCVdT<#gJPCK?H[E\cJ_7aa_e7<AC/aF@
a8D#S93:b:[ZZO^#S29=R(,0:NRW&_dN^1983ab<:W?XKSUP9(^>ZQdRVWO-e1N:
&[X-0^6HZNFW00@(H6T#[CgdR[_bEbD+N/:fGW/WH5;/I5:TYGX^(^#1]K?8@0C&
QcBPS3&]Y_-FHA3)Q[Jg92O602eY_b^8,.?^bQ5I>ab07ebDE\??G[W/eHVF[9K6
eT[#89gT@fc>=F<1(J\]WDU?RFUT\1fTLI>Z-Zb1g_:G7LObU]8:\0SD7&?X>[c.
-OM)]X:D1AgH7U?R#;L,SK35I1aW^;88.Q:WT@W;(Pg6_IXU=B;?]&,9-C&-0TA3
;E/O[I&Ca6DH4+;WM#XRICQRDXOb>=_QTZ9)0-eD=dd0)<5OAO(,ANg=IH@gS[@^
?&>.=>4]I_<,F1ER&,6dFY.d+R#Af1YdE@1G^/6&:bJL)[f1U<;?<]6LGJ3eO(9@
FWD99/>+-fO.]^>01U\UfL\A<U,dgXBEJ;[MWC.BeOfY7R7)Y+=^/^>O1+M5<8N8
/?5^@[9BJ?g\Q>H@fT+_5/0:eBW(>N8A4HTG\V#8>Q#)EB4C7:O_&KT1T[42/L[^
/GI38S^.JMDeaYbEZ:E,OTY_J6V\,E>Q7(;.Fb=^F2;.RO0-fW.P#V?ZMU67ba@W
LGPR,0e^AOKA7))THN<TZ)Z,#-:T9f?16W439N1S>bZF.H>;QNS8;-fOGW3b3)P?
H2d?fR>g]ZCA1&5S43ge:ad4ZX2?JQE@6eg7??J_/aU]I(].JeY_ECDIVKWg[.N:
#R=&([2CA5VW5WSRQ@NSca.b;X4=A#W5GJU[B@-=<+MebE(<(DCZVD=J9XQM,A+-
];6H/@2g)GFKHa&8D,06;,(NN[cI9HZ1\ZB3UIX-Z<=Vc04e:f8(2-#B3]X<Z=X8
I83^,:AOga\FOE^8BBPV8GK6&=E^2WYALcg\Hg]9K0AgXf2L5K-:2fAaCJ&A=59\
/UPDD0=EPR7K3S=O\FC]I)U^bVM6TReJ:RV:\-_<Z<)ZZ@1FY-BUUE4>7I8#WA+N
OaQ1JP<5FN)LGcCY_E->ZJf<2<QF]RMOW5\YJ)(J88HAU0(gMe-R_L_B<U#N7;.g
RUeK\aV;#041@,])&48a(X9_GT/:,OT=5gVT>_TFb3K^Y]+W/RB9FY7NaC-[6)B2
&-BLSfgC8<\V0<1\)e<F,,VI57G@?e-Cada]QSdZ9;\D:NTH:P9M1(P?fK#0)E_3
RB[@CHS2;9?RT&bRI&;@QZZ@BGEgVH,;XYcdO6)2D&7>?_EI)IBEOM86e0M6fPKR
MHUM4ARdB?>57S=Z>Pd6R0Pg9CZSAG?>9?U\f\OW5Z3fJVGX]=d=NGD+)Y3EYS9d
\Je,;&)631VTc8)6ZX(->=BSM,)cF7PC)UA9c9aU@VAI,fMNJf]f(Jg3,E::+eIR
.:1YI#>+#dEA(TN3V^XG^JaD/0JN7#fE3F=D6@F]ZdI#_#7E7,KPfCD>>0_2Lb)Z
W:546T=d0V>-/;2e[cWC-U+=GG46gLI3\8+&R:A2U7;1]W[GHQQ:KAK+g1[31J7^
[51HD8eZb.5S773U2K8(GVWeeY7J;YN6>9d4<Qc=B^#33R8U1G.YUV98)W3M<V]G
Kb;;\U_YD\+&f9.7XeL2,1+>[OcGTT6M;MW:9.,D+HZ(2G)23gL_<3eU]cb,/8Ma
,K,Z3H0Z?fMLSWN>FTbDG1ATZ?\O1KU)F2B)^.W<_]_(<bSA#@D>#>FZTf/+[:GB
M::L6DVL=OCO?b]/;.<<-5&^U2II<X[T^7(R/T134-[/<dCR]_(dBVbgId0YDB6]
\;UQ5B2OFc6J7f4P3cT?@RPS3F=O<F3NQ\V;Z(?44XNJ2&KOK1UNQ>_4bGP8T:dR
cGJ[D1bC>Q)9&aHK]FI+-P>_).FY4ER_/(59#-4e+._6_.V:DQ#YFM^bD)b^AL</
A[]^VcET<)[E_<&9L60DAR4_6_G1bN)fZdS55e^,X3S#aD/:F6K(/Y]c4ZW3]edF
,DfX.9+GC5a7W<1PGNCgJT6b(G5U2d>Vg[R#,[YP[A,WS5R6:QH4)bF/S+gKEA_B
IJ6L9d)UD><7.LA2adDc(Kc2L,O]QL(+QS+,dLWSgSG0QQ?e:LJL3JQ?KP^BW>\&
,A[G#LB_L<<XIZNSMD2\IT[I>eXdIbGASLD/?L#W^)&3bf4179E5-<_(KO#N,IAK
^Z<X\T5f5#EgNdNO)XfU#Tg\gP5aOLVg)VPTMV-aW.aR,3C8&fXQ:MVE3cK4+93U
4&519_V5gNK6bdMCHC8,M9C@@=:VD#,L1bcNcQ>EAZ(>+SFTRec:3)67DXI8ZFFf
0,3?e79aQ4/f:DZ:L>HT^#1)K^b:H4H4TFKe_1e9385CbX8=L-e30f/(63+eB+)]
FAbH\-R]<JdGI]Y]e9ORJ5E<<>-eX.[[Fa4F([IY]aXGe8=C?;X3aC5bVTYb>3GZ
aCX>EF5>@?.A_b4RPII-G^+HA>a?OBZP(TW,@,Kd2:>VJ/d+@+gKKK]WP2HeBT)0
fDfU/VI<16<76<3M4(bbPSd5Ud=T.\>O:Ic9/f7VH#/_3+_7[@[B?^7J8&UM_B_.
\JU3Vd]K0YHJ<N2NIE<EIZd(SdRR^Q.Q-<1GC4Y/QEY,3H9(DHe;<1Y97_2/Y\)T
LdV&/=I(ZbY1FEWME575[0E1)FX2#78Q;\,KH#c2.Q+6Lf04F&gf-<(fJbD2?&UW
We&6dNQdB(IK7O;cM.7L<;cU,)Y<LcZ@2I&S\RA@6cU])21AYc=?d7I&g6=\907&
=0:O4(I4_BHBZ\30egB/)@=A]U0cZVVA_@H)?VG8SWb/7WN@;=;N;#KZ4a)H61+4
aXM]A3?L(#LY9gF6KU]](b8DTa+M:55?<;/MNB4+#1[KT>9)0QZ1_P\^H(I7XQ?]
Y]3gTdd:>]P:\P92_C6&c\B\cVJ_I=RI@]3R5+QLLU8EBT#LB.UGG=4bL6>_(KfL
OP(XDUedU=T4#A8Yb_1G8MPSUA<L2f_&XQ(,e?e3,_ASeV-\()2Z668>M;fR8UE/
]]E?JMb9KD0V2]gXS1)dB&X9&J;W#QA.I1?8e>1A8@_cR.&Q#<bSRK0DUS2YR<@N
DO20&]/WV2D1ae3/Y<9CX3X:.gf5d4I:KCKOfZ(0Y_O72?N(JCG=?;&;_V7\#1@-
A,=;[:Q#TT[L2[LfI&]-Y,,@cFH#5+4V[@e.3bV@ZaGW/KdP=bgN^+TF<fOV=][G
-I8Q,d3KV=##a-/GbEVc91M9J2:e:G;(J5DZ_3>>dQceI#=ZUG/ed&<bR90(O09c
._>cQ\<68_g41^OSS7dV@=TZASJ&MfOJ-FN2:;Z=GY5+DVVM_f#@=f..=O,HMCfE
8.VUX9I_/ReWUP2+dW[d\RdHE7Q]LFdI1:,EL.YZ:V^4SI2C)^P?QXAc<0]D^VIX
PI5OFL)cNPZ8;T2O^G1JN9[Y0]/Xa^e,\##<7D5IgF?C-\3@^^/dJT4J<+HAM]Ta
6=M[N+547[=gg7d]=P1D4dF4@(J[a+8LQb][>PPdF4Og3b[0a]-+Z/a#;OF]N_AT
;G[<\3C8de8SD);F-BRNDV4H1aWfE=FKH#^EdC7(85BQ3-H@&]+WS:.cMKQ.[K]#
=.&91.TJW4<c<,d\>U]X;YWI8:LQ7G1E^\ET1g0.\e4;BfQX[f(dF0]?9J.O>d<2
SgWaaP<M+,WAF3)MJ8AW?P#M;/HLG+Z.GL/Bg[b[9ATH=Yb1dg_GQfO4@/F3:\7;
4T8G;2TKO(<SQAE/_e_<A1-.Yc13P(Sb2O#U:7gZWM;J)T&_-X/#dIa+=6^a1gbX
I95Y#]JOdYcI,,IPC3Od@M+(&1\f9O]KVAf),fPbVD_(CA&bICXS7(?K#gbX\+&;
V;b5F)^;4+C?aWTaGAHZMX?FAQ2@:1MHL).4PS/df1aXPC/JO=4>LQ/?K-aWQ-YS
Q6S)?;M3D3Z77eX@?DT7HePK1^NX2ISAZYc9_MNfO^_H,7XWO5LNVH\.@<a9.62(
H,E5B@1G;f=Y>@I_6__/DA+d@1O5RdGMR6>E=f@)N:BGSK_c\6X]\/fUP;5D:8GK
AD-D4bAS1]A+R<2^I6Bc),O7GCRa:FeU9DO-bXWe;A]<0GO[D&CYVS)\U<=Y:MaV
GXE<O;#N+O:[^b;&T->&VWgD[&WWX>JIK.G6)X[;];OO+O9.Y;RKF,-=BPGV\gMO
1YYCN4=A1^E>f4H/9S.Ke,6/M_U/Q2X.3[PMH+OLQQP=B^DCTdAFeQgd]aZ]=0?Q
^85V9;>ODG[]VbH5dOc58fW2TQ.-+(5/.aITZc1L\f@:;O+-.(^AT[g^@?0gR(b/
/_3<cZd2M:fC9X@;]UH[52Jf,cZJf88E#c\@=LG#BC.F1.dg1Y,6G6T9LdF3R(FG
4ff/Kg>\?ML=^7[BA0\02N<7(c)WXf0MIE./&4Xe.GC,,c2A5J=dZ=(_2YB;=(B2
,cLG[g<O[^;MQb<IeCH_&>A2]6+U,_c6g50.?GgW4Q0a7-/^bb>7HH@N_\<&9N^9
@4^8VW@4;N+\T6b@6TFK)Rd2cXJS<)B]GF5Ab^FfQQ@N>#(ABQ7081<5=KM.f:_2
AgDBa.BL)a=#W,OH8_C[Y+?88G0@40R;#Kcc>K]L_6RT;APcL.M:6<a297X\ONHT
\;)(:\MB.BdVT2S3I-TUT#]G@&CbGIEdMI2?7,ZbT39/ZKg.;gb>KA5J<A1B#,9K
N3QVJ;3],];7\^0BfG]dfEWd5P8[V1e68W,&<+I<.1Z]4VE]^Y@2HV,<<GdRef.S
Me7)#OW.=aUJ\0WXL\D6JD^-Aae3179eX]bTHPH#Ge^7O]DXT1,<M_>UG#T(YX=-
ZU^KANWBOg.&E<E;(G[d_)9bV;;:;LI49^>72.aQTgL9b&Q#HZ<BL[I)08/X)CO3
97b>+B2Zf50e:fcKD<9&KYTA>DWE<8TVeCf5gc9Ed9_]+0(UXP+NL_S,OC:,N-fe
eQ^LZa+G9^ZY-/Fae[<MaOD(CH3\gI?<E:IA1Y;0e3dfJWHZ0(MJO?1OZ9a:])Fc
]O^I@YeZO84:E[YO]LHg&9N\3WF91ZfKWQ6ENeMP?b64M4R?+b1.5b;3M)<NR#]G
,]:Jc=:>B30BF2=B&/,1R]WJf[&d#M+aGfM?[>Q\/S&dG.\@7UBT3B.]<I?=UMd3
cP@^P0:U?C\MGMOL_G6D?QM9>3QH/\)&5RTPdZ:+eSU=9=F^6I-a3EBPF+8e+LDE
QJ7EgacVT3W=FQ:F<E;_FLXBHJ;c?MAa8)H#H71KHS/gE17bDCY:;>&RAf(a:,=X
)=B]C<S;c\e+/A-9TJL/,Z]:GPb=S:/bW[MH8e\.:HCF;D68-S]Q;VcA:MN>R#gZ
JgQg-_C/B]Me_a=DDK9d76;N9^IM<cH:?.bADfS;=0#P5^d.@(d2&/L98RK+H.8a
dFb@QZ_0<EO2H:NgE9_8ZT4THY;Oe]-9\aA+FbX)aRI;=ZG_a7/[e92d?R(/3/PO
b,K9IZT9629g#LD85TW/V/=PaIFMY_//@=7\.0D]=5Q4f4CIf)(?9a1;H;fF/Jg7
MP8\<gKLPgb+6(C+B055.:9QSWCW_DD@P[M4,&SVBR+\21^KIB&>f]e0D2g.@UJ<
B(_7/(HSX:4^^8\DD#5VV;3P>99-80/GHZ>3[P1.&/4,#V/A96HAK#7GST0#E8X=
XF;0Z=_dgK>f.JdXI&Ic/^b1Ue-cgD5F\DXXH#I8b.95]D?Zg01U^S..MGdEQC2]
S8G1G).9_O(KYPY2\OE\M:6LVSM6cMceP_(>8H19G45S:EG+=<9;G<X5U[)([LH0
b[CY/H29K76Z^fLB/^1:(UZ,>f^Fc@(<6/(]ZeJLC@\/XDgZ2J5ZY4T6_Z04J++(
#9ZJ(EAU+A?[Z7/e)567@f5RGM_b]<RBQ^0/OLee=(JE4Ie4/\Z51CEU1VW<Fgg#
Vf4CNT?;L#;K6VM.g,,]]//ANU@?G4Re#[6eS<I]Ie13aCN0X.W@5/:_5b3G);8Y
dKG46,[3VP5G-FN0YHR7fdF?6XD9H(+NR^9d4P^eI#5ec4JO+Xd[Z5X=O&^C#=f(
ME1WIERF>&<L2DE[MGBSR2,L>T9RD.E#g>0=O[d1BZD/+?9/(_@?4[2eOC2McU/\
)>>:5SL?HWX6&+2>C=g7_WdX0Y:R/BFC578LC]Z<(L[F-P+F>=CW4TKQ_SF\LNRL
]Oa-OK3N_\3W]Xb-QUb0Q1ENeOK3#)7gd9d_/4D8XU:([7ca><;2BQT\(VF5Y_XG
BB7/E;3=b.<<dGgO/&G/_RE_3G>UWGH,8^:--#QK:6G,2VcL2.VT#0-(c2.NG&KY
C,N6=2b,5>+[+^</#2I,@U]a09/;6[1@c_^BP;HY,5#)RX/Mf:)OOQgD@D7I>;)M
@\;-UTWAC5H=106.CbbSHXJAF=F\c5&:ZR1_aZHLF1.aDWgG1]@(7b_]X#0C<SY+
L>RM[?MLLF^JR8?S#&FF43Ef-58<KYFDO>3/dR)>00dA>dga((^@>1-S]4XE?TDK
\\9&7F(@54WDC0/U?30,W,M609O5>B()#O(1CTKA066Ma^<abc:B--[&Z\\c#>R@
G8fKRF<bIO]](JcZ-0F8-(WTPDNUIS/ea7afM@SG(=(=726)41CW.G?H:gW4=cef
\7A<EL/LWE@>@M9:K]A/1-Se2B:f:75FgbLLI.=CK;#M-g.?TW(.JD83)\cMNOH-
SP0U2NFe6J;TXD3S-dec12I3CcRER-9[;A4J,b5a194:E>D^#Xd/DM.Ic]/@PAO1
J8>511aO3LHWf^&;XF\[KX;/0.7-a&OVd2--_Lg,ASaP=5--5\;4NJf4cY+S?_QK
K_Jf>E_ZH;YQ4)cV\XW#YS(CGR]NP_KDEL0Q(S:EME^/2>RT;=3QN^H=R@2Y/2W]
7DAfNHg@I21MEIUU[&O(7G&+322793Z/T#G6]W1==Ef=LQB+5):/eRJG1f:H,fe\
L-67C=NZCSd\IXO70NO&1;d([?.cO]=(8+9C7M-1I,U[,ZQgc43Dec:A;QKK(448
<QE1c0^FWN6+M,HL5Of1V=YJXL[O\41BZ:F=JQ0J]cU=:d_<>12:g04@@cB,?;HU
1;\?T7BY)]b(c505PYA+\AHZU[bXA\Kd)+41MV)OH\V1gd37K+1DCFO92X_)+VU<
FW)a9&>XJIV1NI>7\4+Y)/BD4?D=QG.)-1F3+76L8g>2W_KeVXJFLVg^:L><<NdS
K<4..ISd5FO:gf#/[P=M:H]IGSDCR^8<-ZN\fL]RK<K.f2^>X7AZ]:LAQ7-F?M:8
#Bg]be(&>BEH;AAI1_YKS6&c^<aC^Mf)=g^U-H)QbID[d;5HQ(Y=I_We4LJbYL_V
@_4_WF#LEDQVc4eJN.6dFHJJN;9/eGT^F/Y+5BN3,gANJ5P.VQ32GQV7Q,6O;HMW
7>f^J7cC00^ef#e+8WJ_I21I)Q_02+H4E;48Nb)1W<gR5W_,gP0c@,e,Qb,@4Xb;
MOR43CPYT8IdR@JD[S@07_A=X(6^3HLg98B&5MG7#.6PE2:5cdePRRU+c?1V/^0a
STQ9B1:MaL/HKBK1C?@c2D(W#Y(AVS0)#7L<cGVRfD]bE#\WMCDS4TD8?UF?:\f&
/?0-QL?g,4JU5R;.&E4J?9eJ1dNb,YHMG\g60F&ME\G9K6d#Zd#E:WX#2O=Q?9CF
;T3[XN)]#78K;KWB55C+UWE74#@?fa[JY;9UHVF]]NLLKD:&<A1CbT:=H47^d+YY
C0A,41VO:@H)P]?>5L3F7@@H<aE_)bXFQfO4X+f:)N-VXM\O4/9AIOT.,50MC2#;
=Q>:>H8K+H1<P\V8=2/0SD/R_Y;4I@_#0<TW#>C5\ec:WA4H+RTf>H=@g=#WVW(\
(S)0360WDU4dBZ\ARS[Q7XM@&K]SJHc(.S>G_U((9f6H-4d)c8<aafQAS-D=CYP2
?N3N3#2F3G<VGI5JAFN?@5P?cPSfM(_R+@EV\OgcDf6G\E-bUDH2WE]f&L,P@4L3
Z;d^HJKe3U_)]-c^A=G(Z]<(\4WH2A@W)gWV)3,)@JX=ET)A4GgH>T9&Q<@c<WNE
cLIO5b>?GK\[K.9SA:P-TT#A>2)d5;;aHc\XPGK)[4CVEA.a1G6RL-.@N8@UI8J(
&E?03:G>+D_VDP=9MJd61?]E=>NK7G(Z+(fWEB\a+EHFHJZ8fNH.:&<f+8eUG&9+
FY;3O[Y#c6=&?cC72&@2+<f\Y_fXHMG=B(]TP]gA\e.4,WES-/da1D9&MO3HX_CL
\[]Y6+#CA0#9J<FUEWc8?RF@^#,OfN)YCR5CA89TK_BI&Se>Q.ZMZ4S<P@MRJ?=;
Sd3/Le..&7Q\c_9,^g03(KMDg8\6Q^BX\UCT^(<f0<,d76_=>cdb7:EYA^;g[PTO
DUV6A\M<&d8)/J+1A+fZWM/V^7U>C/:eIBK6]#O[0(b#\>&PJ4b&2L</d:FYGR[4
ZJRLFG&J3AN]L;I2CMT#TJS59X\++ZSN/#S0\JM7&5Xg+P-W]ba-JUcZ5;HedBeA
[W=MVN1<O..20M=F9fVGX5C2;NYM:(C2X;.e.&C6\DA/cF_d-]e&R-8_\K\aBYMF
WBQLWAN-AceD^:5R6\V8]5^A)0gb(D>2fM.VfQ+?.M?>>[[+>Gd+I#CLENO//DGF
&[@?]OGKL[3#]@/+(6U7&aCH5-?,LL?SIedg<V@7OcVcBC..+cWZ67X=ecVT&6Y6
^[BQ[?<@)X9>K&b1e/G:a6A&0)SGfJg^Z/W4Nb<KMM_912#6B;6-?\eTG]DH9B/U
Xc8E0EI-P>7baGJ:[Q<\Oc/&Q]FH:Y(LL@YJQ-ZEOM@J]96)>T+GcM1M;O,H9OL7
ZLa)^R5@\7GM+M247-E#?JY#[R22ED<EYV/fW.c[);^;5A:^cNNA1]1?=6R5E,O[
dJ28OX^FKPXT,TK=34_J0d#f#^?b4D5I>.J=F(34@7daDTHAG4ELY_N1RX28JfLe
f]Xd)?UIQ+5DH2SUWIOUc<T__\O9P8W2L-)OV@=d\=3&(Y4ZcP9].:DacVV0^@-(
Q(4+eVLPBV;SeW^IH8_4#?0c.HD2X,D(=1WHOJ;GN=dG+K^)YEFGN,V;;@_>G.YJ
N#gVW.-4JG=8g>P7\7cQ\)>=>]bGSXd?8cF6d=aV5c>S3XKLDJ_NG\\:\UEOFL)R
AIbJR+P=da]9eYZ2O[G(#\c_&<3a@fEe3R5CfU90\I.T<aO2ZJa]d^MDP:YBL#3U
8Q?@\a))7::1Xg,L&(ZaVcV[>_1fT5^e45c:?D:gZK>1d.SDY5[EeO6C=INR#H^<
EK&)XBP_g\5W4+RXP38\c/N?C4RS#Ab[N>;^&4=1T=R73@23VM2H8Q/D1UN)=D^e
M][ZJJX4&V.e)#B:II9EAe:(;HBgHVd,Oa^0P03;/6;R@&(,\D-/P[[Q3.5A.WUW
Ne9O74J+K:B#_fU72)O#SgZFb@4)PT7K(gV@LJP4HQOW3A(gG:OOHJR?,_&0#)CU
f[:8--.UZO1(gOWM+\0K,ZFO,<&3<eI+cXV&X\?4^(fcBLa8Kb(:83[JZD&[4.E0
a=4A<WC>458XCfKKg=O0O[&;dKK>RLFI)4GP17]gadZbAP8:\2P(V1[X)&V4eO#d
QEF\:R;4\;1:1^Q5OFbgQ\\cIG[Q7cFa\O7XQc/XC)^5I0P2=35;2.Oc1CA#2M5.
Gb[M&2#N:eK;D@HU9)^,49Vb\M&/?:1]#1F9:FR<4dE4(^9]QL29WPF83ML\4e<J
Z1P545T4+RE?LJP+81Ddd#\/#fH@VJac)@MGag>(9406LQ-&LCS];#dc/&M\/F2=
IP(40g9:0Q?.ceKZE]e2b&;Z\8OEPI&YS72R2C,US^+<fHfFdDb2GgKR1JBc&d-5
U<0\Ig?>O1FM3_JIAYSBSBH,CIE0O:XJ?P28AI6K763SYg1P]4G-+SEYWa/P6MDE
?DM8XK7@^JD>FaR,\DSXV3Kee0[V]1N^fK=ND^D9Z_U82@eMWN8gdQ6>[2/<9E5X
+HSLb@]:D1#7D6PdLY2U8^d3f<<=GA/]7b)#0e?@>1NKWBG6H)BO5Qc_KUWSeLET
GN0G9CW/O=B0PZ+e&=;8V:76T.\2FG-cJO_R=#aM=V20\45UH@5#)^M1TLXS#b&F
3g^DP]7OC@@OIH>b8;FCG-E#S4]W<Bf+U(\#gIJfeL0[R,:X38Z,_RPJREKTJaXN
[e3AEeI3(@/K&Q+Ugc-Xb(NM-EXc)<cgc[M/4MG(JVbfG)dV\E<Uc=fZ;W)J_RMb
b>#\ODB5GaG)RR.Q<4:AMOWFDD?2LD_8?T&Nc?-:V6MUH1.ea#:?SHQa01+NeBI&
7C(;TPGA]Ig7E^SbdQMOKW=I+3)H@<,S^+<?,@,=[Lc#Dd68+M6We5>dWYb8+>fU
2f/8-..g_UBHKTfJ)9HaE3MBR,A&+#.KXZDSMcEbD=L,I)H-OeZW;\J:_VWQ_adX
DYWV/TV,gFINDCE_7&YBe,?MX1g:=/Mg)]4G\)TS(LfHG7@4D_U866@K+E6K#d&8
dUK0Z^CV]0G&\:/:Gf:X30+(W@cXTUH7S+,S\X#]A9_-2GC#[8<?0Z1D(>A2(&L3
NcY+_.0<TGS6Pg#UfPDIee1((-EJ]H:34UBEDd9S5aU^^a6U:bf2]VdX2Se+;c6f
Z\(6]##42)6cUI;2.0g4<91WED=/c0KT:3HdQR5cV^9[B(LB]RCBZQ>#[A9:FO\K
FNKO4fV7K:@HC]5a#DObF14)cA74CI0]I^-deE&eX^^ZUbb6&T4PPIUO#OT;dQ,F
9H@XH\0I4cTZHAY4YA25CQd4UKU?>EPe1ET@e]YbcacfPf2gLNb?cEd;OMV8>cZ4
\CG#OI0BbPYUIYB&c0FVE0XV00W3D2A_Y)JK<g7N(Gg0_=)a#\=Z(J0fa/^d:eee
]aJ/e[Sg=;0EVPO,L..0,)/\-MR_RW#T(C2a<E_KM9@X.Fd7BLB/g8,.-1egg]+1
Vb[-_Z&C.?>@TWb]#\K8@B6c5+UG-.#)Y#L=,UBO=d&;>^2MfgV?/-KUX#8&eWd0
ZeG?/d,-0gOWWe:R05b4:SA6P4eJf6_K1^?KATcKZV6c5?dVGB2<cFAR:If.f2[+
f0DR9CXBHWgQ#@K#(^5RSU_D74+7W3<f5[?F0]N;/0?dH-A#1<2V8(HGVVM9./[C
Z12I8b<BZfME#FK-385[0<QK-BcPR94C-H75<L_\]c-;cg_A)][-S0\3]]8]FY=B
QZG5)-2/_O_/GbR9QbUQVCdE3)T7]GFDAXBM]fI:64;>d/Q[OD9aF/L]-R+K<4X5
_>R=F;9KQ28DH3HLaYM5:_e.OR^T4J<bFQ1?b2HM/:_>S-6S.efJWNDAaK)[X1HL
2X^?&+_A?O3<Y:./a:EcVLV4.M?MENRcC@COCaa,//8aG1QB=@4GNAZ0MDHJH\=,
?=NCVSVIg?>:8W)T+BHA7=EPJZ)P8F3J#NX6)=)[-#Rf9D(T5;KC9cC]K:.0AVT(
XZQ98MXaKQdC4U8=I4dHE?-Od:)TbRIG9d41055:0^_Gg3=)Z=2&_EC3g=#B5370
HV<H)f3,HgZObMB;D3_EgGRR)DYDYUKP/bIe@X]0D+Z[@0^HXPd.[DOG56eN0N.-
37ER4XHEe;B#Lb08c:e:\ERH#1&S&g?I+2Jbg)S(C3H\#8bQfT;8U(1&/g+A[F<G
L>7;[)[9YJN+d?;cR?#R/FG87C8DG8(W=BABJ18)XI_/TYYZ>LP9E^UZ-ACVWgd[
LdWIRG&[G@6]Gg@NK(JC1CNC.8J@Ka#cJMI=O8.M&WP;KfIc>^3Zb>&6Ee6A4a3S
8?>g)#c0,Y;Y9GTK:Z2g(13=AZ,Q/e@SM^^S&8KXF,eWcMI8LM)M000P8R=_a+O0
(>\2C9YG>=HKOX6XGdU?X.M0W3A56DX4cLBbC/B:04V.>b07d09ZaJ?TTXJKgUE#
U;V(=Pd#Se(8W+O2TIW?NFKE\D+g@;,2.,d/4@#Jdgf.;<(8[J<R]I;D2WDT]DV&
IIDTIcfHT\S7>9UJ?PHVRWUH)TW21UBN]GFO&<L[.62Z9]O+NaZ>H@\TI6KPS+@+
9;>@=>TK<WU<4W^:8<2-ADdggX_E5-fLaSV)9fT]#&[A)^VaIK(7SI7Zc:,9YUK_
SKc:\&H([IgH0c8_5&,Q=YT3W(6g]^THFUESg#9O8]]RRR8KX-UdW,+Q?\PbL\?A
X]J2[EVS,260C,(&>:8]6FU3[;4Q+9LG3+9NY);?I+=_M@=O)(/OZ_=M]7#b6VXO
<.;I9._WL8.ZD,f0OF@WWcc37YH_J5DO4AB=9YLa(E.c//,[:6g3ObadIOVZRA5P
&fY-41cPfRZ4ZZR,H7(QQ\9XL+D0G7eEZM9/TTMT\RWC/<WHQ9IffH_=.ceaA-90
a_a/UYIN+.16T#LGS:JW^V(d:JDK6F;11bQ&YKDV&\C1+]+H^e0bE3T@66<Z>FA1
YL/fET5_eQG_a9-d-?01][\,/6X+TRKU_91JRT]B:;@<>C8@V\Y2]6G#57^32Y92
21Xg5fgE?23M[&2?<GH0Y^[<Y46:)3C+XL:VUA=RVA=O6a]cTEdSBL968^J;SBR[
Pcc[1__)6cg0]K99+b7K]a8e)F1D/4aX6K;N@G.30TZ<J[?(]##@JG7b6Y9]FBAP
WZ+E==6V0=2B@ELURK<A\cCCPGJ(:.,53?)Z,OT9,QPQ-+&2_7](S7bG7@dY2G60
MTVT?VCMcaWO0DTEZ/F#a>9H:&CFIEfCW-MbK+HN(f@;a]LcYQ9+b#f@DVQ34dFP
YXD[MfX&D(M(Y<-R\Yb5Y&8a)LET[+a<Ze8>gf1FWb_?5VJWc?#E-4,1@::-8J\-
&GVdA+YOFFHWQ4gN_=b:/L4_;c&MMaR?D=EZAK3SU=D5b?;Qb38J.UBa3eL@WPM)
<-]_)9LDA3R5dM=G&71)VB]-Y:;QZNV7ZD>#=SI+C6M^&JeL3f=0Lbg)NI=g??0T
O9@\S;\\],SMJWM:MFfVX\&X]f8K_[/D[UH9W:\K)@\GS9];<I5/AaOfT#K=VG?(
3d0;c7\PVR4J&VD=]d-5S&0/(+[bdXT[2-U&&_D3.d8IXKUN>>GDV[DRU&Q#GZZ)
7>4)W[N\)(\:?9,O?SCJ5W;OX;SUVdTG1gG9>b9WeQ#39ZPCRgNL9[dHdY\U?W8#
CE=FA<-ED,SNZNBH_DGP4cfgI,)8#9U;RfS0U@dddE5K.C_E2IN7F77fA2<Ba]<^
?Ka47.E78LW=6Z\_ULFd?(O)F&R:c>)a]eWOZMbYFf/.OK5I7@)KTJg,c):a\UQ;
)GJ)RdZ60QeJL0<Ib?[b>U>_cY^JccT8Ng)/A\1FC);d)BaTY[A7(Nb,WdeIB2Y)
]/@LCb/WbB3<eg_M=6?g[UH?[QCR\IaHV?Fe0/Q<@(J+,<UGGZ.-&ZY8eTTe_:6H
MXMGMTG:bKYb_gA]M-^LB^UfQUB.;TcD4=TH9YJYG/+OdRdbPd_E5S9@S[Q@QEXD
:.+(A)/O^EPDP#>9Rg5E1Zagd^.O4d\YC7<6e0\.(J2X)/6/ZK6d9NK\JWU_[&BE
g1aAYVW:eAd6I^\37]dCfBUcgO2O8/0/XO7#)BP7ABH=)1:/)3.;.8YUU^c<AR&&
5@8QTcY:F,_)=/@K9?U8Y-G+7)+6J8>MJ3eVb=XD@AG@ESM;Wb3dPJQZRSNP@-cZ
6?7:_Y,ReLZd&c[e&AS_CL&-Ue>D022^Jc=+@J+VI;S-L7>YbN;F>Jg.^W.+aUa[
dDB>;GZ9WRXX[fDRUNRD(=+F_G=&TQR9G3cR<+>ASPM4RP(7.LIdZOFgQH4\:1:I
WX;X+Y@F,DW1B@QA2F+1[c;T-E,)caJEEdf4O3JAQY[J#DM#K>M9_6WIG)bcDFGH
?=JF9PgKBVa.D,+0c/5bgKA<8+cgIIKN#QR7<OWNCFZ.2T+E0VJV-;[a^,]^e,#B
4S^TRMQA>@S#+@b=,4OHK6bJ3b0[6S1[Hde0QRIa]3T/UE5HSABg2&_&X=I(@QZY
e:JTBM0P2F<.e0(;[ABN=<d0E=CKYD>5=S[,.g8#3.YJK9B,R(GQG<9IbII7UIX+
:[[Y,SG+RDYT5@[aaLN^B9:A85@H.>Nf_<?4a3[?^/UJV\3:PR0OP-7S./GdPN(>
.X>dRO[)0[?Qd[S@>?_M-KXDE\3,P3U@\U>Z/0CX&/6SF-S;T\RPE@G2ML(>a^(P
<H_)WYF/]3WV(=NV-e;B0&./,dW^#6WXPgK48IE<0(C@2<\\c?Tf+2377^<a.)Y5
NQQ);U;YTN2B#_W;JDJ+0\X:<.SS4@H51^@R;98<R[NU2P/]RACQaF8_AYMJ1/+@
/5TZO^/J(N-QQ+<Mb/.Hd[;8P6RR;E^TNF@C-YDETD9]ebId7ab)XJg0cW@/\^eY
9BU-Y4JJ;Nb-ANYG5]D/QeM/0Fb/(TCYW:5_fU9ET-@]TUg8ZA9JWL[gbTQG7We<
HDQ1^TM(53=/>6<+[]RDL_CIcT<I73Jg_>?/Q]ea:YBM4@)dOXP791CY4#Q]6MSV
?UR<15SZ&F.fOC&0N\BVR^<0P]]XdYc&64RI.R8\[0KK>,B4GD+J5H+==1J/@,_>
[_;a\E^9[/_,Ef&C&2b[[^824K@22TXPAC7-I1=K(c92cb<8Md;WDBL\a??>4/5/
80F<8>[5S#J?:=IY?;U+ZKC)JVc=?QA7U<PLFI2/4:E5LdKA8aWI+6A+YPc7\G<;
BBA^8c+L:A#<b5E7dT50fE7]3a55FB,_NW>=4_EgC^)6&d^H4L>3f6=C&DOCA)gf
Z-BT4/+D++Cdf_:]&BI=5H0^6Ya<N/d\g]BPJa_F<R_._dNXXH+[\=bL6L7+.6f9
H]W\DEb?I>Y+\Af7HMA&^0^3UC<4a\=W8UZIM9A4]H:Ed_^UBAN=+?64b;&3Iaaa
P.S\/?8Cb3;1O(&X66+SR>M&VZNHA@RAG2VB+<CfL64AK+FS.[TY+0+>G:EZ5</C
/16-+JG?#3fV/FYD)8IWdccZMNAAWbaZ7II]/fT(-dKY.LMeLAOBa7-0cP7E4[GH
1:)TbH[VQBVZ]]OHHWMc4[M2PE>?9U#0eYgU[#e)7&]5_Q[U=\6d&6FC\D[S]d@:
(#79C[+I6L6Ib[,B=_:&Y)daM,Sf[MRG:L4&SEeS1<I&3<N8;/UMT.:3a=^Q7ET3
UB>OTE?-g1T(WUO<KO?Q#4=PfdN<+M9F]?_YKI?/XVeO#7M23N\K&\^c7eaR[;(O
:A)ReB#/VCQBg(AbcR:]8G@\3Z86G:2P:#OMb<QYQ:2#Qb](]+d_))Y(6W\:8\<b
G.bNc4&YS5g=@);X?IHH)MYD-(C;EfJ.@PI[1(CWWE79DCVLDZZUF]T56FPBTRR:
_cCD^#MU7F7=2M^[@QeLc@\5ROC+H4,OUS+D-.-fPd0)IKfVGDEfYEVA]4I?\,_<
a3X\9F=#ZU]XgYTH0ZUG9>8/;E&^>DT3[bHYZTGSHR\e[<-K3D<\Ga/2?NP+OL,6
Uf4W8?0A+SQ)KGFY0a^0AaGOL)7gCTJ5[?g2QB[[,@HT3U]\7RUOAE@\KT,:SW.9
8Qb+04aec=V0LMI?ZL/:O0E@5YU8+P;HLSQCTC5K9557W=<#@/19GA4bV\Zb5&&^
P;AELC>f1]KD&Y:<T.O)\Q^A-_7EZ[edR5I1V#CPDK7AaI/eC3?,.#U34\Nf#B,H
DIe[WT,:QRIcAPb&JV6<U)&H;Y0bM^L/gD3UO-_D(2[[(86TZ&GII#\Rb62EV_be
HW)XGXX-)#D-:RP=,bT&QK=TCAJHQZEeGLg7XX)d]\K)CbBKfG@V#WUCf1KbGbQP
H<8b,F>,YF@M<9<P6H[NA>dUJeEE<?FFJ5Pc_/.:-BO\7bP:/.gDc+YDC<PG^Vg6
3?D/C=Ef]F_VK#W#JF8P98SSDVHPcSEfgBRP)JPY4GTS?3I+cWU#f\2YX?9\e[RD
5V9M?-U4P?bd_F&P<X[=.V\]e4A<9>+38W0:C:VIYMcEA#0D3D[O8WYMI^<b5(L0
L5F+eU9:.);85+K4-0I>@2HgId6>1?NHE]DN,-Ec8U(,+V_KWWV[KXRC,/31)R^(
FeP>BG&W>KL4MN2:Mg)gSR>UD\8>?@[b8C.==R=#FFRUT/ED=bE;6A\e2X4(FbO^
=B]&V=ZUXTX&-^6H9WcE_4eF73Y1BK6b]>6YbY/XQM3^Z4PX72TS<01AQXLBB4RE
H\@TXCV^()C(5DaI>W#3S9d#5ADeCfXK(3T&R(?NeWG^>A_Fd2d/3#,7[@UWUTIJ
_M0?M(KaXVL1Z0:G@J>FDAH^@Nd_,e+-6Z0[:)PRe-K(7^ISE?#QPU9XG.>)\V1M
gI>\-1[;3U?Oc#(@f#J.1P:L8]K<MY/0YSgARQJY.0f;d<N(?19N7[c;/KIa1#/6
?CIFTLMS92V#J0^O=0]3^:^)H_L4FV:,g\]FGQ^KJ\?_)5F,<Nb8+5#AW/X8QMGa
=FQBd/ER7U9J3ZcM_f1B[R>Vd4_H0JCOGfS_b<G2F-8-5V?.])_dO6:T6#9ef7PL
=E^9>D#R/L5Z8g1B,eA>^bNL0O@Y=8NVG67,^55XPJ5&[e,g?G-2X4gHa<Y;X(Bf
,P8F4X:-]H_@]LMN3+I.g3MR0PBCR]9<6_Nd[Z_S/EL7.52e&\P>1+d=Q(B+d/V@
:35P8(3e(&X<;@g/YdGXd#5LeOg-EgWJW(HWRY;,VQR?+4&NR]3YU77Z7;0XSfH<
;\]#[O1F6gF^NLg@QS4P7f?U2HDe[EBXMU=.J>fI[_Q7,54/+GfXZ;Q.&>JKZ<Rd
<QT=Pd[0I8eC)O(.@_S.Yg8f_e<:R3VRQ5+(\USP5RcQUK:=1+I_EMYc&aU.=6F<
@L\6LFCg.>7g0+Sf5CDU6e-@9[U>)R(\.VS8)#2,((3ab(+H<S^9e-)Tb#Eb0YNN
A>(4W5cfRfXKJ4>(XUaEOJ[#VQTe_2gOJ[4R<L?+FV,.a#R:40-a\LCOU7+1;EKC
fDGb_X+,_fNfLFdG>B?:V:P]A+XHLK)KH/O(^<&>YNf(_>8@._9A63eR<AgAKVQT
^C\ZFF/]Z7Lg+I)87I\:G];e-Le+]Obgf#83A4,#T/A82X+S)bN\cGb\-VMD8P=/
dPX#ad#ZFCf;F]OI_W@&bSW429]3[G+;N2FURZ^&5UKc^XZ?-b+BH)1ET0)]YI=9
99GU:TXWETc:D2FYfG0/0Xf,[?V[7D<1?BOf^#V)<Ee6PcMJ7_-0,FZE35d9Jg=&
f8=QP/H3Z_88VHY3R<W)Lg2AeB4@eUT/BRJ6b[0Z<)L?2V&Q)RC9)[Z6B?4N9-cY
QODL\e]E.bBL2(24PS-bW,c3>_Z/4F4cVOL^QQOYRd]U05N0=Q[)3IVdF^6=PKO_
810N:BC\I,@URgD@b6O\../[;VDJ7OdA(AG8Y?&1>M2CRO\,Q;B@OR.43&?QDW76
:\BZ1@U;(bC^f^HF4TE[T)4]HZZN>JV\T\=CU/g0:.JM]5YcB:S/<Pf8.MEFZ=cE
;Ra(c\)^-Qc-6[EBcd@C0Rf:8a34H0T0??fA<M([(:\EdJeB7U[a0:(NMIR.^JQP
W&I>W^2)Gf8[[)WeVVN3K_.;#PI<e0MX-1f<@G?0F;V,bb2NR,#.I]1#MT343]=.
7A7X9)D<+abNY/+L)+[<XXKXWI>?R-.0T8D&55:XdOcb7IH:&M<7ZF5=>)d+C[NU
:H]f_UeU-9I^X[6?\;:N(F<C/,edI&?@QD1fE.7BZb[P0>O,FUI6Bc5@@MKG);O:
2D1K]?g_HN0[FBC1MGHg&X,D@4=bNYLIPGXSQGU5fg-789=3bK5cQ/-@Yb_C;)YO
S6Y8L;4)JZHE30\-DYYQ?07X/[HW3&H@L5d+a,DMX7GEG-@,G<Ed[7E+/+\T26D.
6MQf1+F&^1IGS_-[_8D3OH7de>f>VDEdQbgL+>.=0a4-<SZ+.<Q1\SBL2N4UQB;:
4]ed7G3M0a->[8O;TS[&_6P>f[@CfL_-HH^L@eN3(B]:)4(/7f#Z-UMATN=E@,5<
]5-0SE^O52b#<_XETRXR,eR=]]7G=e<IDJ@+Q2+cB<UJ>+_#-+M3XV@I:gaEb4.)
:T^,L#\D<Z\S0KaZ3aM\BQ[#Y,_e?>baQB@GDG]\6P1_&-H(CP&3,YEIO46:D\N=
FB6Z5FPSO=g-fO5?^8KB(cUOf:J(819S#SH&P@8X[U80)N)Dd/>:T5L3HC;/RdZ8
^NL@edgUb(#4;=;47I?;TRO.Q^XL,;1PW5BQd:c@TD9ce+UN9-)19@XW5cF:0-3-
K>fcPa17da92+H#S</=4ZJ:R)51=[>WLWeMb>d2<]Y5&)D.(XUXdc\]:Q5Y+b-<_
-\Sf<\6e1\XeM@E?Rddf9P^a#3ND(Y+]AIK&KW,&(Y_7+W2[B#EIaHYd57V25)O7
X,YbNHEY_U<gE1HgZJRGZMV\d:X_MB9?9P)7:OXF#Y#3Fa_5OTX4240bcN-\Ig9,
@@JJ(7>[7d/?#F<:(4^5H/FH(LF50OQ2U16PUH_e\)<-dZ3G8OEFf_ON\NP0[Y8,
^Q=8W.T0U:.=,Oc=e7KVJ0U_;.(OB-46P116G;-3Q0@Y,+Tbb&TgS<UF9HOD?KQS
IAF&FM0#:XFS_)@=<=G^=M@VT>:>4.)_7?gJ-;0fA[<UQfV/3(:9fUdC.BH?fb\_
+/05:GeC7@&Q<[MD;b[B4@e/;(&W(gF.0XA(^ERD1IMC;dT?;?GU9_E2H20N;_]Y
45LBZ=.Q/Y1B5J-2YC\NWL\D(J],:0?/ReZX1:MR2B]a@K,XG^/+NLaf3&ZL;FFb
)Z;]XKNdX+PYbX-2/3c;:J_L_-0E_2IJ)GIA#9ccA>He/;H2>@YEXSYP5eT^CPM4
[fS2bPb.AO5XPJf?@+KS<HVdXI@&SV/(N+d=,EU0/ZDRecO;MO=8bANA_^f<d-K)
Xe#f\EQJI]G170e/&=fe\f:Y@d1BQfQT,[8PM:<_2eT\N2e7O\8+_GI@+9BT.(/D
HLO?eH9.f9LP+-[(,aZ1Oe+>g=TLLYW#JRa(XfQTBP&_#L)MfIeT#0B##T0XeAb0
#ZMN[c,[;(?+^W5YO2aUR1;BA2dE0UU_c5.5E#]HPe9UB&H3=LP+T+&+(:Q(+#CS
edF4I^)U-//#H-b&T,M6.]&Q3N,H^7Y-N\I,>YQdH7#Y-M6^BH\=DQd>.YDA3#U_
F:9@ZaJIf8OU73T>[W5QK^@eQLdaZWCC7,CXOTUH?BY)JNaFJV#A@PTe5E7C6U1[
_IXWF=EO(/&#F)@6:&baG@42R^cZ>?2;:;+ZePfg]V-2P6@;:Q][7beXK1P@,31U
P(I:0]FE;a_)K/b@246DUG&?EU8&<4_0QPFY3T-+Z2=5\2g\#[1[VFAM:9]D?@E;
NQVGCS:3\+:d/d2EM1I4HP>C7a&:2(27\CQMdIAdQ+X7,]W0cMS[9UO+.YV25;/:
#UWI=gC\5?MF#<W6FXSM5=WaZW[2NDcAE00L2T=7Y>S.58]C0gW1TOL_O\FE@eb,
+&A@W8V-^&55GJI9J4\EP?[B12QE7dE[1SRaMTM0Q;9+BfgLK33EX4Q:W\2QUdM?
_9KQV00TS8_[SQQ2\QO-OG@MfR5]P6]B)IRB_J)2W3edI[C5a@PCDdTc-f_SKAPC
XKW?1MBX,:T]e(4=cfa_=e[9^2U4S/B8]_geg4_.[^C(?[N;\a5;K?>B2bObCBIS
b5^AS0?QO#XU^PI4M9L\@?Z=96b:dfUgaQQ(Y.cIFJG8[Mg^0D.BH01?T6>Y=/3N
U=g6[E;[b0NZ7QC]XJG9>N2_[?^6FYTag0MA_4+=-GRO44,W,F0OK\JQC1@Z0&]Q
1R8FZ9O5PFf97S]6]J146U(<;;\BN@GaI@YIW?b88_AD7]Z1f2\+;_aSS/H^9Gf(
B65>K#:gZg(&?C/>)QAg1>-=K[H>>.c=AA?1d\?K?Vd]KA+>#<#gR7KA]LSJ>5.B
:OG<?7+XNa2?_(Q+P7WS=NRX\C-);S)Q>Fe+]ZgG:9I;,NV&dD09LFBcbG?[[3KS
fPIfS);&dW5P\9[H\V^+.3b4V/<?gJ==BJ]95T8L\+7cSNJ=^54[cQ<=0DJTAb,I
3:dPB0f^CcW19?]+J3-bOfF_He1\OfD#L@,WF/?GXPGcE$
`endprotected


`endif // GUARD_SVT_CHI_LINK_SERVICE_SV
