
`ifndef GUARD_SVT_AXI_INTERCONNECT_CONFIGURATION_SV
`define GUARD_SVT_AXI_INTERCONNECT_CONFIGURATION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_system_configuration;

/**
  * Interconnect configuration class contains configuration information
  * for the interconnect component. It has a handle to the system configuration.
  * In addition, this class contains configuration for number of master and
  * slave ports of the interconnect component, and the respective configuration
  * for these master & slave ports.
  */

class svt_axi_interconnect_configuration extends svt_configuration;

  /** Custom type definition for virtual AXI interface */
`ifndef __SVDOC__
  typedef virtual svt_axi_if AXI_IF;
`endif // __SVDOC__

  /** @cond PRIVATE */
  /** 
    * Enumerated types that identify the conversion type for
    * AXI4 to AXI4_LITE
    */
  typedef enum {
    SIMPLE_CONVERSION_WITH_PROTECTION = `SVT_AXI_SIMPLE_CONVERSION_WITH_PROTECTION,
    FULL_PROTECTION                   = `SVT_AXI_FULL_PROTECTION
  } axi4_lite_conversion_enum;
  /** @endcond */

`ifndef __SVDOC__
  /** Modport providing system view of the bus */
  AXI_IF axi_ic_if;
`endif

  /** Handle to the system configuration object */
  svt_axi_system_configuration sys_cfg;

  /** 
    * The number of master ports in the interconnect. 
    * These master ports connect to the slaves in the system:
    * - Min value: 1
    * - Max value: \`SVT_AXI_MAX_NUM_MASTERS
    * - Configuration type: Static
    * .
    */
  rand int num_ic_master_ports;

  /** 
    * The number of slave ports in the interconnect.
    * These slave ports connect to the masters in the system:
    * - Min value: 1
    * - Max value: \`SVT_AXI_MAX_NUM_SLAVES
    * - Configuration type: Static\
    * .
    */
  rand int num_ic_slave_ports;

  /** Array holding the configuration of all the master ports in the interconnect
    * that are connected to the slaves in the system.
    * Size of the array is equal to svt_axi_interconnect_configuration::num_ic_master_ports.
    * @size_control svt_axi_interconnect_configuration::num_ic_master_ports
   */
  rand svt_axi_port_configuration master_cfg[];


  /** Array holding the configuration of all the slave ports in the interconnect
    * that are connected to the masters in the system.
    * Size of the array is equal to svt_axi_interconnect_configuration::num_ic_slave_ports.
    * @size_control svt_axi_interconnect_configuration::num_ic_slave_ports
    */
  rand svt_axi_port_configuration slave_cfg[];

  /** Indicates if barriers received need to be sent downstream, 
      if slaves support it.
      When set to 1 and barrier is enabled in the downstream slave 
      (svt_axi_port_configuration::barrier_enable is 1), barriers are forwarded 
      downstream and all transactions received after the barrier are blocked 
      until a response from the barrier is received.
      When set to 0, the interconnect does not forward barriers downstream.
      When a barrier is received, it blocks all transactions after the
      barrier until transactions before the barrier are completed.
    */
  rand bit forward_barriers = 0;

  /** 
    * Indicates if cache maintenance transactions (CLEANINVALID, CLEANSHARED
    * and MAKEINVALID) received by the interconnect need to be sent to
    * downstream ACE-LITE slaves. 
    * When set to 1, cache maintenance transactions are forwarded downstream
    * provided the AxCache values indicate that downstream caches must be
    * accessed (writethrough and writeback)
    * When set to 0, cache maintenance transactions are not forwarded
    * downstream.
    */
  rand bit forward_cache_maintenance_transactions = 0;

  /**
    * @groupname ace5_config
    * Indicates if de-allocating transactions (READONCECLEANINVALID
    * and READONCEMAKEINVALID) received by the interconnect need to be sent to
    * downstream ACE-LITE slaves. 
    * When set to 1, de-allocating transactions are forwarded downstream
    * provided the AxCache values indicate that downstream caches must be
    * accessed (writethrough and writeback)
    * When set to 0,  de-allocating transactions are not forwarded
    * downstream.
    * Applicable only for ACE5
    */
  rand bit forward_deallocating_transactions = 0;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Specifies if the agent is an active or passive component. 
    * Supported values are:
    * 1: Enables driver and monitor in the the agent. 
    * 0: Enables only the monitor in the agent.
    * <b>type:</b> Static 
    */
  `elsif SVT_OVM_TECHNOLOGY
  /** Specifies if the agent is an active or passive component. 
    * Supported values are:
    * 1: Enables driver and monitor in the the agent. 
    * 0: Enables only the monitor in the agent.
    * <b>type:</b> Static 
    */
  `else
  /** Specifies if the subenv is an active or passive component.
    * Supported values are:
    * 1: Enables driver and the monitor in the the agent. 
    * 0: Enables only the monitor in the subenv.
    * <b>type:</b> Static 
    */
`endif
  bit is_active = 1;

  /** @cond PRIVATE */
  /**
    * The AXI specification defines several conversion and
    * protection mechanisms to connect an AXI4 master to an
    * AXI4-Lite Slave. The interconnect uses the following
    * methods to connect such a system:
    * 1. Full Conversion: This converts all forms of AXI
    * transactions to AXI4 transactions. This is currently
    * not supported by the VIP.  
    * 2. Simple conversion with protection: This propogates
    * transactions that require simple conversion such as
    * discarding of AWLOCK and ARLOCK or AWCACHE and ARCACHE,
    * but suppresses and error reports transactions that
    * require a more complex task, like burst length or
    * data width conversion. Set this parameter to
    * SIMPLE_CONVERSION_WITH_PROTECTION to acheive this functionality.
    * 3. Full protection: This supresses and generates an error
    * for every transaction that does not fall within the AXI4
    * Lite subset. Set this parameter to FULL_PROTECTION to 
    * acheive this behaviour.  
    * <b>type:</b> Static 
    */
  rand axi4_lite_conversion_enum axi4_lite_conversion_type = SIMPLE_CONVERSION_WITH_PROTECTION; 
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ***************************************************************************
  // Constraints
  // ***************************************************************************
  constraint solve_order {
`ifndef SVT_MULTI_SIM_SOLVE_BEFORE_ARRAY
    solve num_ic_master_ports before master_cfg.size();
    solve num_ic_slave_ports before slave_cfg.size();
`endif
  }

  constraint valid_ranges {
    num_ic_master_ports > 0;
    num_ic_slave_ports > 0;
    num_ic_master_ports <= `SVT_AXI_MAX_NUM_MASTERS;
    num_ic_slave_ports <= `SVT_AXI_MAX_NUM_SLAVES;
    master_cfg.size() == num_ic_master_ports;
    slave_cfg.size() == num_ic_slave_ports;
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j])
        master_cfg[i].use_separate_rd_wr_chan_id_width == slave_cfg[j].use_separate_rd_wr_chan_id_width;
    }
    foreach (master_cfg[i]) {
      master_cfg[i].axi_interface_type != svt_axi_port_configuration::AXI_ACE;
    }
  }

`ifdef SVT_AXI_UNIT_TEST_ENABLE_CONSTRAINTS
 constraint unit_tests {
  num_ic_master_ports == 16;
  num_ic_slave_ports == 16;
  }
`endif

`ifdef SVT_AXI_INTERCONNECT_CONFIGURATION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, "test_constraintsX" constraints are not enabled in
   * svt_axi_interconnect_configuration. A test can enable them by defining the following
   * macro during the compile:
   *   SVT_AXI_INTERCONNECT_CONFIGURATION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_interconnect_configuration");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_interconnect_configuration");
`else
`svt_vmm_data_new(svt_axi_interconnect_configuration)
  extern function new (vmm_log log = null);
`endif

  /**
   * Assigns a system interface to this configuration.
   *
   * @param axi_ic_if Interface for the AXI system
   */
  extern function void set_ic_if(AXI_IF axi_ic_if);

  /**
    * Allocates the master and slave configurations before a user sets the
    * parameters.  This function is to be called if (and before) the user sets
    * the configuration parameters by setting each parameter individually and
    * not by randomizing the system configuration. 
    */
  extern function void create_sub_cfgs(int num_ic_master_ports = 1, int num_ic_slave_ports = 1);

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_interconnect_configuration)
    `svt_field_object   (sys_cfg                  ,                           `SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
        `svt_field_array_object(master_cfg              ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(slave_cfg               ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
      `svt_data_member_end(svt_axi_interconnect_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------
  /**
    * Checks for a valid system configuration handle before randomizing. 
    */
  extern function void pre_randomize();
  //----------------------------------------------------------------------------
  /**
    * Sets the array sizes of the port-specific variables. 
    * 
    */
  extern function void set_array_dimensions(int num_ic_master_ports = 1, int num_ic_slave_ports = 1);

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
  /** Used to turn static config param randomization on/off as a block. */
  extern virtual function int static_rand_mode ( bit on_off ); 
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /**
    * Method to turn reasonable constraints on/off as a block.
    */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /** Used to do a basic validation of this configuration object. */

  extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);
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
  extern virtual function svt_pattern  do_allocate_pattern();
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
  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_interconnect_configuration)
  `vmm_class_factory(svt_axi_interconnect_configuration)
`endif
  
endclass

// -----------------------------------------------------------------------------

/**
Utility methods definition of svt_axi_interconnect_configuration class
*/



`protected
G#8-[=L2R<&Q)?;[WF^MM.KTS.T/eYNd4NZPP^6NY68_[X#NO?#A0)AGR7^<9]e_
6HF/5W3@1J?fKGDNP&RP9MCW:<HE[HcZ]WC10)+Ug__Z@@CQ2.\98](T7NOb9^QP
21?V&MG/^;BB#DU:Oe4J=YUO,68@Z?=\&/A.F,a+:R(V;-SN5IPQe75Yc9\9S\0#
M6b?^QV76TEEZLF-==FIfMGU>3a+UN.4R:/UgH9@\JK=&dK-9Y,OD0ZRZcg)4U];
S@XGX>FR@&7NgB941<-NTFZ2-=,+6)]VMCGIfOGP7dd+4dX0PAW_)E=W8\27>U))
c4_Z_S](0f6C_&c,F6T5_=d&B0cPICG,;3MLJeB.UQVe0>E58Lad7=55K5R>Gg9Y
@8I)DR:>W:?7/OQ?KA)V_\BVf6/Yd01Y2CF2.0:Yd.H[BK9LKDdETX7X5dD^B(A\
3-8.1PJ[VX6YUZ_1VH/cbd/W&DI]&D_3-3K1K_RBRKD.OX#=2[2(1A7:4VW>+FPR
bdEBZ88F.DKG.KKT1#(BSR#4>5E0+\)&<;dJeZe#=e:X9L\519ZSeJdK/\:33,_S
95PAW;HHA=?C&KSVg963SS\4]g3,7AM\a/<RF7I>NgY#L=<HJU3g:L+Z9_eB0+J6
=M<\V;LX&>3(Sc-f3H3GI0cd/O5DNL^#E6FfKd-94C]JQB>U;(Gb99E8gfN71Q[T
,B=d0\)]C:41&?-#?7ZHX76@>dUET?SgZ[[:[]=@P<)(\-Y#L^#dNXf<Q]/[g\2U
^<@<(Eg)cWeY-J.JDf1,]:6Z,aIG)3d\U&F)Q?QCe?&)DN7K/Y(R4P\,>J\<)Yb+
LLN]=WEOSFV1X7T&PNQd=@6Z4$
`endprotected


//vcs_vip_protect
`protected
4X4g->L#5;XcZ170eWE#9,XW1]KXRgg1EF6(GY+cdPX]TBVA19)33(]@0<M]O3PK
:@:P/-LPceeQ\1&6GS)V5b+U.Lc_#:f?+ZCD<dI7D;O>g+D6[]QWfd=d]:I>6>(G
bcD#[_bGK?D8O@O7g/UVR_67#DDbCZ8ZC>I-.5:5<)XEBYgU3QR<L<>_09ZZ:L-K
,N&TWLV>S/_8_8aW]PPQ,YGI9JNHDd(U3AMNcbb4HOD=O2Dd[-KQDC#E#VgK0TaR
Z^2PCBUU75??NWR41C\Zb/>Ge@,<491TRTQ,ABCDE(VQO-c?F<,b9Z_,(/:f.@52
,INNSWQE,Vf4>7O=Y]\_53>XL5[82R<Ec4W&b#)-aMGMQa+D3d:75bD)3:66.BKN
KgJA32^,N7RXaZLJ^LfJ-(.JDfF_LZ:9d=>3fcA91X]e2K/(P_9RfTPdN^#W.;^U
bgSfHRBIFa6Q)TW[:6BI=@7ba1Ecca+EQe0&KPCP<:57-CW[K=Ua(3KbL^[?BUUJ
O,@[bG/20WA><eT4TaE_L6I(7(2IWHE[,B#W)UaM(La8-3[#]B3be(S7:>QV81&>
=#]>6M,aZ++<S,@01.DG>,bVK93C88d^R,8H4MRaYAe8G0GF0:RbUCKEU5d-#,da
b][8Y84FGXgACfO7-:BU&_e9Ve:adF+-(dL8E7\TRea6/\<;/b;?6&L202]#O9^V
UDAbb:V_e>][,?4:dfNYI]K+Rf);LBJG.C>[^CI0(:8)aM7d1aI-;?B01-:?LSV0
gRIK3Q;T\[EZ[-6B5UQZMI\@Y_(+3#.#OS977aSa>6>Z/_9+B/@DDJK//=)T?6YT
Y57,-R&Oa#-BSN#5=JOLFJ+6aF]EJLU)@Ra(G]aAU;#0-/cN90Z\/HC5.K+1T6^0
@P^#]PC\JF(@X.(1FEPg8KVf,@2B^[A6CZ+<=b4_6O6+/2JY4]Y0/I)QcH.,>K32
D?/gHW<?J+eZ31#,LH^/PUKE-4A6MRD>QAUU-.VDC^UdFf2Nf>T9L[==1VfM+c3(
Z[2QcB\<&^:C>1YE+>_Q7)[?W:9aB3.+P+:NYD_@S0e^R_f8U/?R_7+E8GV-QO-;
T7-/38eeJ1;AaaK1cCOe-:(A;Gbb9^(1-9FYG()E8&1A#M_M.3NQ?F]TV73>>8ZO
..42/-OSeT2D<DF2?@d.c<W>XFNLCFKR]<JR>E(CZ.A\HI(@[EUE6_:VDSKJ#6(<
SI1Ud]^MF=AS7G7PA#ffEC<d^.G;G05U/b&#+U=F8O,W&4a7)(FBB7[[Z24(?-0@
W>_D#R?@S2Nd7A((2QN3E6SLP>6,>^3\TKA/FG=_5N-OWE\S^_PODN]LV@;Eg0MD
Pg]5\E:cfP(40YaOMAUSC)-]_KO>6K^e/4HVf]7eeabeX,TO.g9WCOeS+-R6CA=E
K<[S]>^?+YN=CDPW&.\H>2X)?NM3GcLB=_;P)7a^PBf2)S/0WE8.-32OW9V]Ua9]
=#H]0g<C_IS@WLI=JBc4Rf7c<6]DTcgCGE-QKc6LSDWb47/H+dV6NDfJ+F7af<#P
6ELCT[Ee9JC/GdM9CE<Kd)_=_AKcJ8(SS,3f6)77G-F^:]VI;7Xc(FGTF]/f-5DW
eT6fWT7gA.[I,_GZW2f4c6dQ.R:PgHJ47(B8PSU(\CL\2dLA/O?U2HY+S?@Tab+2
#X,,7CKM0T,T4cO?cI@KX#IZX?a&D3R;&^=:Z5YC:RBUC)7;eI0C24FH;gb1X54#
14NAYRdAPPB,+:[QHePB1]J7QEE-)MO,2D;I_Y\1V9+eb=<X]b,YI&T[IT^8,;CC
<U/e?4\C-D52PeE/O+L5IC]>RfV7Z6-U?()37ECfDT/Q?CG9Jf1>TNQGbB5eNQP6
D3bU)Ab=0G+5AG)>^)TZLUBfd>8D@@U2Q.(/7W0<Ne4=:3Q]RY=)ZJ\I0J1/3S9#
D,c\e9]JDdYR3-T]NgJDH?RPAD9d[8#:OUe858XFgK;RO:5W>Q+=1WTFP\^[ZO/V
eEO36#2&R:(?aJOYGVdSf=c&+^\]DCKRSMPeO_aJTDG:Iaa/5<8?@/DNObc(_H:3
Vf\g]\O>CJfOVYF2c/gYYO14#OZY@0ZR@DF0E\-d>^-::6W7^<\?A[1,UP^JaC4#
T4RFQ2BbaZI3f0cT?3;GaP;:V?a1eDFPPLUJ-dfPN)4WaAP_aPDg?H^JZW8Qg[DZ
4Z83CN#BO?I1K+\>^9]Cf(A.b-HKg,a/@[6L-2cJGEb9#(()7E(>@e=9>J)/R;OT
[A]HIJ2d64_gUZH>.,LcHFS/9(QaRY-Ff&U\9E[&@/?),U0V3S8B)cUVc?\^c;#,
bA73c:PHa4VT\UW9:-BTW23W[)4KZXLD(Zc]_GDC9<d^2Ab9YeUU<:#K>XOH1;+d
C<YOL&[CMCO=2>-8UB9^;);3EOF(QB\XD2;Ta&;HB(Q+\b[>@[W?=<3PH&2f.C,_
6O(3+3?=Mg/VB</.C;>HIEb^PKdcbGeJ72C?/)Ie+FPT4&2@FZc>][F<1<b-ZWD^
f#bH@JZ0MDDPD7cdE7Y:X^]9G]2(PGWOEa@U;P#R/g7;?5.YW5SdEf^DX>(,.b+X
B2a-;2BGP7Wd_b81@6P&HK[g865M=]J_U2V&?DF&8)PP#B_/If6TZ#/X[BdAR#)5
LT_)#]S);a)TPTV<:B>O.<B@RIUTX5DOOWO7G&\/#^EO+CPB\MJ4b8B@XcDM&8@(
IH1I;d1VR8503ca@IO2;,MS//>QSGZ++6@+3/+K\-<XR0]a-S&;bHY#PFM/QTd9#
>=9T30H)Lf#WVD+3EIafB87Wf/gW/ED^2Le><\UCC)\K7XefJ>XFV>DZ]B<5;?<F
A+g884]g31^]K,@;Hfe7&1.T036JRWW?LY)6C@9eUBDfB@62)+-B:<e+1FaW57bQ
]bLb0TaK7:,N9M#DI&@E4IJVg7&1EOR]I7_JT;3gL2L3=c;0KA])#:F<<;5G1S)+
+AaO,T=a&;;O)D8\G-SKDW?(1Q7>66G^TO(N\&F#71f?6>FR43N#\9Q8@6Z6^6QR
f>:R78U<Q,cK)27.fW&WV-&8[7M0OeT-fL.Q+ET:DW-4OO]QVgF/;.<=<P>cYa]K
GFE[G>&UO6gHKdXK[7&IK/cCY3TJINJ;R4C?8&<6fA6#gc=LY_c,a\K+^SQ\+(4M
[M.0VOeTB)Z6Q1gEadH^gW56f^X5^4E46D.Z#98MYeL8D&B_BaL6^5Q>Je5VP5>@
e45dS#&)D7@8AE)F)&K7DG_HWfZ&I0=KC?,5MLbb@[9P^1]g.](]?ZSbKPQ+D/dL
/#+-[/dXLM-1;c4aDgV?LD>_fSA0da]F6CM==VG]G3e_A^078=[W+dRRU-\7H<C-
edP\5e8=/T7-2dL)N8d7aN9?=8<bS>,U2UaM?^R(]dAF];a&+<YFff,P6.SAbJ)X
V2[OGDOA;&]/@g-R:_1W>5f;VLa)RMeJ6>BI@e(3\9YaXdA[7AT=6BQA&Be\bHIT
=(0TVFgU]\0&.EN,ZH>K[<AQa@N;;WFGa.B@PJTKIGT+@;HO?K=Sa\\6&a+Wd^SA
[,SNea;eSRC;[1#U7(6c\Be,8_=V]Y]4LF/fa=#04#[O9e<]?.J+/C>8CR,E#aZ2
)@,W9d.PO5Q9+69A>0Z_fe)Q],W(TEbX3U,1/F/BWE/\FGb=XcHGPcKa6bRR=:aE
NDRe^N8UVP/eH5e-X<62(X>]Y\3J/\HU(?S6?H,^QY[N@L9,[82JW-\JM?]B2b:[
NW:\LSTfU)SX2b<JPUc)D3L(CY^C+[dD9OBU,SD[2WJAN=H>X+O:b.Z:<:8(A0=:
0I(;Z6a@2IBbL_8;8IfMLN,0C8bAf/c[FMPG.^D67Y0?4c1#7I[:ON@D@/<].?<1
e5?SaY6A,?AK)A8PgQ6]TZ)dCRa=FU8[50S@8]@c=TL_BNe>-)OT(\C1eATZ>-<G
WH&\J73Q2^cZd:Lg(P)_e-24UWQ]C(a?ZOH/IaEI7S&4DCQ.G5OS:0A6IYJ.BO-_
CB_;QKa2@^^4D]TffK/(+#AIT-,6\.S8ZV-CDMAB[Ba_d39JbWXK?VK+a,P:9GdS
.@P/ZPg?BLCRfP-HJSL7HW0O]1\f.JHZ#+A:e,KgVc<(S-#&NY>H4@?\4YS4f.L\
62+;]b)D0_8<@b(dGU:IA&g77VW)#@B.a?7;<c9+/&3,66d>/D-Cf@HQ<I4]Z;19
]YL>2Eg,/\VV7F\-H6a>4@.[L1#?1]B<TK?O79?:d3W-D[d-6J8R>OfHPKATSBT8
&<daFKFFK;MJD@,-KLVE4\QW1<#N5#@WVGYFYgQ:a:-S]U=C1W-1P6JFH?K1K<8g
I0[A0&M9W<(:MDO^S?A&?\UB7a4&ZYKW1SNA</a89TJ(df=T5E@F:Q=cd^/WJ:Z2
+e0J2AJc;M&:GS&TL,(+AFgW0E9E,cc0DN07M6N,MScE_P4NU:@<>WZOW4QYHI_3
_c/7DRWPBO?,+]O5^_]GaRX:W>[ED[F5V:T=Q(MY=4^_BJG1&0_Lg#4(VcKD]K[F
5gbYPK4BZ)D6CYUX0Ab^ea@U.M:XP#Y_PKc=RID5QZ5fE=#_HJLSG9(RfH7aWK)e
<\J1bS:Y?SA;2bGK8&L-69\2)fHTFEXJ#K.JT,RBFJ>#3),?fNP;eD83H)Y?U#[A
<X.1b355fZ3-Y^D?YA:^+B3)\=S5FSQII.bc:0[a&S#=&A/Vgf1)>A<)GX7^Ee-g
M_.1QfZ6Q;H1X(#e<D9.B[V3K[F/3QZ9Va=b3Fg,dZ.f8UgL,cY.WO#GX?<:/VR)
+[_b<(TI=^1[D+,6:?;33(8Cf#MJW+43&;4/M0MU1a1<MIWU5V<3N_S7LVOJ>W0[
[_/25^^?)@:N,MQ]c0J@.TNBNDYC#:gNAB)I4T>?V@TGA5^P9PZY-&0?>:U_1S9J
&U]^L[TDd(V&BcV>#.\,56X:TCZ^cQD5I4S@)1SEO(C/SYO<eb1J@3H1F686:&EG
XX(^D_XI6;R78R9\CH876=KEUMLd@b+RI0\@5d\\>?X,^F=L^R)KVBUJN0OMP15=
UF>d#CX[eSeBSPX9_0@\>16H&(#IS#J(RL:6?Q^O:<8B[)O\F@UffKJD_D1a@S2T
K,+Z68)VX(M1L@GA_4RG-F1I6b6PP+aN)WV@XN3O=^^]2.Rg#:B/.M(E6UT6fQTd
]2+@353;]I9(Yg#GCL=^ab>Q;2IgMENbIaK01a9PUD5Z+Rg4@bJ>J1L-IHP6EG=V
+YA@C4gV1;[7D,PgUD\H:>]CN0A\D@EI1ae0(_5eg.U/aZ-4e3SWD)D]Ra/#dgSX
#:HVb/8Z3V3STB5fDTJ]M(8Q)G.E;,8C7=TDATH]+A7a=2-@DAVWG@7<9UKfG(Db
.1ZM@Nc8TbC_CL+EW_O.3@UKKV&N<@]a^[eC3gRB7K_\7IMW6.0bSIL5R1;f+K\U
3BQY8,W]6QCHOg5;,CCRY703\XY:/0[gLZ//D#MQJ(aZ:-#b3EX-.:OHG;;RW\g(
f>E;AWF34UOXeV)6\X5R7IO-OP\(aZEUQO/=64@W@dU(39:9=B[JNagfSYIH6X>5
55)_LEAIRUHX.5+.G(74XVDWPBF1@Q;V09)MPb><a;&dX+<Td1eTXaRZJaf(cQ>=
9.1QcgN?Y\[Sg/&+\/6UT0VfI=/6E&S&adCA,[fC88MB3AWL,0I4<bQ8;=083#7;
^S1MQ.(:9Ig_2RXRaH[.M3_NZ31,,8.I<M.TK;-g)-6RY12XSW6_K^>UP#,(-6(A
T/LD1NK<.IOHI.B9?FU3GHC5eBBL9GV4Q+-N[.fEb5dS[.7SJ#8FKA4/F>G,^\I8
6WKL>cJAY:T);[]Q^QU/&GAR]VA^5G;>L5^2GXY6Ge;:L9Q/P3E2C\9Q^aL4B#U\
c>0^R+<J6-S)SfDZc7Z&)MbB,7GXUH+I\/<F(#[ARfVG813TFRJ:KG28fbPea1/6
?:D][d<OLKL[39ET/;I-gC(K1OT\C+54/-6Y;M>YF6,[SEI.1R&Kc>?:;#SX54+]
4Rf(7&7_EN^_F43I)d<Ud-1/?E-eD]#)E32\/X-SWXHWEWJ+V^\Q1UG1<XMTX[a-
+E\:Z;+QI@V2+,dJbA_9:\\DL0=g?JW2UC8XJ/8R84QQY/3E9=aM9#&?YPaO(4V;
eD11F=dKO?=8>F=-/76;<71/^O/V@C3M+ZIaV0YTDC#;ceD9FDDJQVd,cc54Zb\d
a@bX06[HVY536C]L^&&GfCW+eF-<_TE4PFXd)Of853[+O8]B-E@-(=D]LCBY(0:O
WORVdPK@dD^0TEOJN3)-:.5Bg#.)/N[O828F31VV?5EMP3/:?PFHcG[dB_,A7\AX
^Ygb7(@Jf5L=FC/DY[9dLgN_NB]9;TbK(O5,/\I1N7,bWM-W6Tf<D8G];9b\0CbA
?I)3(KEYYcXTIO43KOFG><<7a)Y2d^.dO0d=^]NRa?S/g:Hcd-gV0A]7dN6PEQaC
&I[R,cE<XQSQ[=ffA2Yb5KRP\7+<cO5A#-Qg3TTPH;_&HaU9bc->4<08Q^aS)e<c
#O)e_+N9O@H<?B9&deeBd88BR]Lb0f0^Yg5.=O_d+YN-CUY3Q-ZL[#^;S?V8W,#]
DC,G=W+>G0-Ga_fYdJA[]J8/_H#-T>CC[NH[e3PE[NX:^D;CH+^(]T1GL<Jc8<fI
?g[-&=#/39fQTK2->UQ_CARTZA7-)T8e+F?DGF9^O];f\.=a,P=<d:_)KN>>D84\
+WM<QH]\QM#0FH-K6JJN=[2NV,W2]WK\1CDJ99,:RQDReT/G2:P(M&0&;O:LZS:>
e,7.7]1F)A&5WU8EcE7UM3]Xa&ZcKW.HF<9GXUY&,#M&DC+LX7L0+XH@G<7=Cd2@
aN=3YcZWX9V3X[PQA@4>/0+g?9/&S?4IfM[Ge\R8DNEKe8S]Hg:a1aMKIV(X[3LR
F0dZO\4@U[7dOSJD]02]-^:DT,4^Kd_J[0[TWZFaE&0K)L=cC\<U<1XT,?4MT&V0
VI\)=+Z/R90bSLbF_#(NQZdb)C@=2=BEdfF9Odg,US5D@_)^c,A?cK7X@:dI^-,F
[Q(SF)-++\3/Q15PB.d4a9)CA1B]6_9fGE@H;eROY)?VL<IQI[eK9T2I7B<2GNG<
#ZcF_,<G;b6B<F6;(NdPGPLMYSMX45;Z=5\A]M>f7[T-7538XE?_7DQV#=d5MT>E
=)U.B2S>XKR7E&bQVAKK=92I+>Z2)(J@<MJ[TUC:N[EIe,[>Na=4U[/3._[#fG?3
6X9G1EA5#3DD5,U:FgKQH;eW;a/f0fT3IN8KaWeHK+d,QU6)O/Ha1YZ1f#bfSaS=
(2-D\[aJ>0_CS;7>+7;B_JA);^O3<_8b&@;4>#?GXYC?83P?3^J>-XJ_f,/3/6TN
A+I2WGL-FI7AB\+[3[bIF&.V7KP/)TU;c)]/\3)3JN88\9,AE2]&5K,2fCJ:6:GY
,fce@>#M0=FLfM:bc+C5)d..HWdK\Y8TAEaFE.S?VW3&RG-;1L,YHMP(U3W=.+&<
LJ<gZSb1CS3UQ+gIfa3=IYDMN)H+ab@(;I&N5,U;)JOCdc8VGZOHS^EX-/?2I)GM
T((+>.CcQGZOMLEWEPI:3V-[W;[8UCf)N:(6BNYe-JcdQKfa2d;,DN.F0McM^QCO
<1O+E]#fF11M.Q^D;IW.6PW+a,SZ]bLC]eU)2X<PC5gMSbP)\0Ld-Jc)8^b:Pg@(
R]+G5PW)0=HgY5=L?238E=ga#g/ER(/Ecde8Xa#.<2[WOVPJ,O0W0>_T)PN-Med1
R(CJfPPOF-ge>O-gWFP<[&=>EIHW/\4>EU3-;#=(WR&O&3X>CKVJ59AN..FDP#:]
C6;T_62:PQ9)EcK#3SJW87OfBBWX/HI>,(e6,f)B#<H@_\HdKgb#<G+X9?&;G+50
1Ic/]edV5Rd)F=P5VRA0M=#LI=RaL,A1JZ7O>3(T3PH;0YADND8U_U]6;.DW6Tg<
:.ePP<17?6B3J([b<\/>2WO3444+FN[:TXTYJPP(OT=M/,Naa\\OL5[46>eJW_DT
\H[d#6ef6FYGMEQS#[0F\bd>4^/0VLB&U0=Z4G]0D);Bd_VCY/RN\Fg\A@:=)>UI
B^3+.#&1WSQW/)b[E^9Ad6L2ONMeSMGU0dD9G&SB\C]P:-4217S8Q<&TR7Fc)GbE
+-(T#cZ:Pg6^)X[JY5F\@OJZg^S(QSa;WQI]@WJQ:QXNCM&Q902b>d_baJC,8D#W
JCd.B0U25QBG1gA1;=:f18PL2QT?Q.GY(I1KKOQK\1>CecFT[A;[HC31DR);f#dR
O<&7]D0a\c/e4&C\R>3,OERA_(3N_#MN>BY9R=:Pf\9&R^(=^ff]C:YE_3f7\E.6
XW8>Z,P+Q#Lc-8&(Y+&QU^X,3HL4a6CRMIT/Gd9VWR3ba<XcP>1Qd[6d(XP0&K>5
BA.?>a]9(&];10MTPWPFJDfQ>Sf9.7cIZV((2L7NeSR5b1AG2P@5&Lb2G^JNU])\
a0=XO6b_CGcMV7K/-YS]N9O<df[J?_?K;<,^O)YYa)5:+B.5&]+XT820A+U>&JQ=
>Mce@D9>+P/;^<+2;#B4b:5U1M?<N0;e7[+Vf>fJbUYacJCI3=Q+UX7A-_L,RG@?
GFJf:c@DE;5fPgF5EL+NEdC74_2L20?_8.D1c)7LX=-\#N=>GU0-cLBPdOF(7bVE
+b?+MVM?GCTZ\_KR/8^8W/B7&-c4F0:NIPFP9dc(H897@5d_#K4P_E/V#__&gaXL
JgQ];)<F-\I6R#@9D/bSOJ?Je(Nggf58CK)BJ]@##)V3>@O8A4Y+Q7N,1@QI]E=:
BL^caaKRSg>)2f5/[:DEE0_B9RIM@;LG>729,N(SKD=C3&fQ77?cb6ZKYb.TJcf_
XcKd5M?QRCb^RVM#&cdTdW=@L7_&JJg4YYUG#]e,P,A/;f5S<_LC(8:3-WEVA0;9
-U;.N3B0#8DM.W8FNG]V/4E=C8M99ESS#;=)PW<V+H0OYR0b&(;]5c_dIDJR)6+Z
I4VB7bJ[^;^VHOe7FKC0))aX+^/d<cKb@HXG#?B(8Z4@+IFZ<:)#)0Sg8#Q?JCb?
RU^Z<AI?&)3?X8d1N5>2[ERESRQg9_W(OYR8ZMHVAf9^@P0NKaTZgV]8e66.(_H]
ZQ\=dQVN;K2;/dBBb)-/dD91a-5L]f#LG>-QVLQ)_RfcRUcNU/60^ULeEfL,DeV)
@DZC]I.NXg.;QBb)PMZHO.@&8a)C/\R:J>&.f+,&N-IcX?;a&G/:d>YLdZZ&I#b;
H528P=CMU@C0;KV^d:5YJ,YK3M;+1-1dU15\1fOY:IfPI]<^B+@IcggXBLA_g]73
8Z).&+##aU[4gMfeL24S]_eGIB_0I.8dSQBaLI3>0\/MbOQ9UJ6LRVb2[4.UCA+K
@#5^gEcJ;?;OKV5=T09B&AJ;@>,FOA@+W#[1B([)[=//efF&_,6)<2E+\Bd>#<RF
KTP:YYad)DCadF&AHe5+NR:bEgT/5T3OSQKYW1#^.7N/V3SH&,XIgD&#+fHH9B1,
f7.^NS><8#UI8X-1O0,a?;G[=gLfMTIC_LC,<d=a):8eC2I(1FDB9McD53aKB[.@
+@WH6XB@XJK2Na3G+@F4T1(GN_14U;N4:ad^9&],7CQ6=AgJ7B9d@O#(<cc0\.>]
E.?c\7^>a9+)X)QU^g9E1d;HF0OV#VKF5PY/>1#P8NVf>/e7Sd(MJI200=AMW.\G
8L(+H1WLSR=>XNBEK_U;+&=T=b_[af3XRH:7-@F4+]D((4,/;,Q(^__afH@1=XH?
[fcW\NQ^QPW0(1?_\)RK<gF?NA\WaDD1-U?/L2SHU^LY);Y>ZTJEH7.9ZE@#fK>O
1YQOPO97=G,cZG@9^AAH27f@P>8RH>^6LFD=66BX;)U.9C_^EX-^#D2#P_:]N:R4
Q\51N.AFG#[;Q0S9EGW9C>_:7/f\=]Od&J).cGP+[3K3M5AS,fO9c\F=]3f/I]@D
g,VYCG6D)YL0Y#+DMPa3W0=\G-a;Y:L7C0403Ma:F?b\NR>[NWdg:Vc);(TgYY_e
(95fdA^78X@J?d&&F[4DKJG3HdN,+ZW4a^C-e^VX?[[bW;WAMLLdVD]@7c-UG,C^
F848Z8Z1/M1\b79;YHK<?e49>SHI5Z<^K7IaK?O#bfO53^cJK#fKGXX6>>(EA0\X
)d0Ag\LRE4I).G8PUL6/Bf0.\1WL1J[.WUR#7=/1)^=04,6GEL5Hc-M^]R[;9:cQ
8/&K5CI=VP;;8f8YLO?/5Nd6]YN3^(:^b;MgF>-R+e//:(-LZFY5S_Gb<:E)WUgd
5)R]K9=M@4(^:I(@3L\KO,/d:6SgL_KZD@+U>9U4T>5(KCK#.>dd>6B,([KWWdQM
E?dbET8O#5#.BA=&cQ6a=CBXOAgJLa6K<]^@.f052=aV&T+3XT20>9\T^1T;O\H=
-4^;)A)e[]E3U9^N1XA?<63R=U]@K2D,_PE0)a]&ZVLIdIMXOc]LcJY[_gIC?T,?
1;ELM6<Y],RU?]E[Sf>C)eC4Z86R1T0cUaBFMT&2>F+8.-H<_-##JN7>[Y1<:)&@
Z.?K-A+DK-=eFYNa-W+[C7]((;\SPecB4G5A;>gSg>SWPO605gD2UXVd)\U6d->.
?:>NKaPT0M@O,7Vf+#1OCY9N+1M\<OM\de1CJJ/@1f,.#Y)HbR3FBfSYbWUZ_AKG
(8^M)CLQO#PXN?E^CN&0ZU[G-S,eLgG_d#Z7^U_;V0M>W>[\-BO8G61MI2?.D+UI
O:&MLQ/NH)d.e6T6;XM3NYC(a]]g-;D?F?XWY4Fg[6Ab]M7(D)C=JY2cR\JQ7ROM
Z]AYQ(Q5@TH&3F\EB:eObeEU<HE[:^TH>V;MQ4F)B&L7/QaXLS,3M2)cb4[WE?J,
gHAZXT0/=>P1QROMR^(AVB=>8Vc1&Q[E11cHKY>AMOV8.U?9Va,\QQ_E=OH4\\gN
eHHA7[P2g/Y-f\+d19@JJRQ<c#(O5HU@NDae7gdaQKg@.b-J43N5AaE#egJ=(X,V
:fLRZ^G/UaAC0&:WFT50;;?4:e:4V;RD4KX1UV+;d37;\:UIF[LD/O39KIgH7HMC
b10=B/FT2#-O2QOO)DK?C4?>J2//OGCXDe>5Z@82Vfc+[XH+a7E0_/gQI+6)F5de
S?CVc756+<Nf^7G)RH7I0bQOC.SS1NL^]R=PL-.38XTRf1M,F9SOL088^UaZE\RP
;I:(LCBZI3bE+CPLA<MS2(Y0/^.gPPOeYJ(1R;^bQbFM<.#5=WE-bM^U?fP3\J)@
C6F[:E,aC)L&Y7A66BY:bAce?-U(2S:LMG1O;NE3Z(F3#PS8_MG/[YD)6\SWVg><
:IbdZ/Y1EBJ60O3^^bJ.C@aN\3?8HGF+[9]6C3b_BM1BMadTMf=@&,0Eb<KL6H0R
SDBFfZK(Be,C]3b[(B//98VWa;T+^XA>=fT)>cA]T8G&\Q@/<_&Y..cGE1S8Iff)
4E<EOD;5E=@)ac(V@=eX#Sa32UW^Q&;:4]D8SBceI_1+Z(,c7L^2O+3dDa^D,#Ne
L+aY&eU^XB3XX:aA4PD(FdW4b?3MQP];8_fP1Cc2U5_PSf?H>#Y(+g7HK8C-(d,e
,\1;ccdM6K)X>LcD40CfG5FdXH2-DfW&\d80_1S:#3E6_EaR?<@36-G]/.A-a19@
9\FRc[<9c7;5JZ^RC\0O)1A+7,-f\977B_gI=M@.[M7PU?bC3(3<2IF?DUOA&W&N
OMZXebX754#Lf;OBd90L?LK69A0F7MN4FeHF23VVYOI.EBM_MA8K(2R#?;DI^^1S
[L=^G5Y4;;a81.SQ&1O9NUb,1^8P)MfGa[]d5JT4&3ZgC)9#W#92:HWPfHHMBdMD
A\.C)@I?P]D0EbU<9Y^^4c0Oc5U-H;]XCRPfX7:e9MU\1^_H:A7WHfY:]gRQIfK+
D61E/(]IK?6Ae5B8Ve=AZUIVN9Xf+404(&\YG.ULKfa?eDb5];N[XRD1?:Jd/6SY
-<FGB]NIV7IA5L/IK+H:D&6;c>b.2GI\5&;B[\+d3G7CH7c(LB/O((J/-cZQD@SD
-ReD]NCeSI34(YfYS-\]&P+N?e#&LC=#GFZMDb9FKB?eHbC6I]3)_=C]L;\E[eOb
-g[C&X=^K2CX0/\>]6H+=UA2=efK^#OQa2d7\_]fbfLL<0@g/,\T:5^eT0_\<MZB
F,a9RE2\RZOD4<d:>N0T</H<_gdGTd;S=6.:dHc=9.NE(b\5B2IXTV_GCX?f-2GL
-RK@0,RBc;6^20QJXGeN>6-V)bZ:V#2;;.ceBA(e?U]K7g:Ag5LMd_=3&,J@@E/Q
d4I4D:?Q#,MH]^bNLT;T2>9JYNWfU>QJa3>LJEdTd-I/g6/d^7-6@K#5AHT;d>XE
7^[N_4\I_V@<^MJ9Q<a-37L8<P/Q#4++VC47Wc_Q6@/F[.4J8CY-C2AeM>42bJ5a
,HVH5@OcWN?K[])P8#G3bB(9g?T>6I/cb+6@;UId77R9AGVP8ZDf5-TMeAW;?.3-
2@??V?a?&]7[a3K5J^J7\PF_a5b=JA1^L(Ce/+,dH9eNQcdA<+=G1a?=bb4H8H16
CBM>aJ.0MV9(NHE?_@/#IHTbLE-gBJbXfS(YD8)T\b=JI0f:GDgI#?TB2X:F/7F1
^KXPXMF>SH+IMGC@V^J#-V)(DN_d^LYA?T&#[9d9B(0LHOXX4ZDe&4L<cKbP4P6O
JN9OTR#daT?S8;SW2cX\fd2Y[eDdaI<4T,VW3V/+(GR4a8RT8/I5(BP:@V(+AAC6
d9J>P,+F<(B@KT(#[A)3>Q=NYI#Q5IH_]120YKRSQ9,?&L/H&1K9:M7C\B3JTHI9
a.T-GUOH/3,V.O-/]&g0R;UZcH@M-fY_+MMEE#TODRXD[&a3C,Ag5]R]\cCCQ>\)
<M[,Y<V0NNg9D1dU_92]L\#&VI]S>O\?TbE/+6SE^F]ZN>[(ZF+gOOMOBeZL>IIb
<((,S5AM]aCd^baKc5Gf=LLCKKT<c]U=+bc_V,T_UVDB(dT9S=YGd-DPTTLP4beK
P:QG,N]1a/U;CXA+Cadf@7N3>c\1#eQHE?eE23]6/H2=Ea/Bg,];EY4Z1TVf7b\B
>4+;,:F0(P;^ZR?[5WX;gS)_GFB:J0U7JcZ&WdH:+I+,7C4EXcEHdK/SX8MM&7IS
;&=&+HVX;.Z_RA,GQfNc5;?_0]7P..Sd@<S-M^=J4\20I4X4,d2L#eY)[f^;Z-Y]
A(6B+ZYA];X[KeGaC6H])MIKT,6E^R2C+f?SC(0>0HUDdL6SXVfa^:<M/E2[_J/9
++<B&SKV^UB<TQ;?,4\_H;]PEEP^]<^eGed?Y_U328+(Q.WQ;<)3/X?28dS=HY:5
VWMO2<2]LRcb^CQ:E3Vb[1>((JbQZB2Kc7De[P[/WH+)a@aa8CX]K7dBMWIc+#LR
F&]>+_KBB,P8WYc_]KIH>EN@W0L0G69;YG<ee5^,\V,Y\9O?]a(LMLQ6N0MER8:9
aT.Q+5D.6ZAZ0<?E16a)-N23UdaHDQ3B[/4N<=5d0:6EWbZ<9:?#F0K\@URM<^SQ
7[T5>L&2^)\1+19@gg5fDH0;F@2<T;2;1G\>/cJD#TWLED[d;@RPR(\aE/\&DA^8
2cH[^CM^@1DVgK.F.e>a0L(,cV82A#FN\:6F_C_]O6K7+cfT71:bD,R]@=Q]DA2_
JK&Tf(CfeM]P8TcH2.1c7I<(&Db()[A6@MHZ\f>->^K>:SfcKQMKJC[f^Z.fePP1
(gf;^R]YcUKdNQg8[6Ig@GZ@63^)_FMfBN:X6&_ZG4Ef5SING&;6<&;2^2=+TF>W
c&]:PDU[TT31d5S8O1;AV<TAe?C+5KXGT374Tdc12ab6df3AQYQ0XJ,dM;cbR\Z(
B5K>-1gb5Ia4AX&Xf?H3MXG.SggR5U,:03S=3K#gA#PK0dYLB+?V(a2<-<K2DGDD
B/M1?R)2aU5:@f,C0>8=JC+S^[IgcFHG8X[94Ag76K0+;[KId7,:0c?[F-#@SLgF
QN_>R+OW&aE4b_D>VL8C0Y(<GKg#2U5(O.cc1e/L;KNNYH7Q8e7.QL&\4dF1)^M-
e-48,_]P/Ff,=TX9,3f<RZ>94=.DXFJ[g&XcNDY,c4R0R-X:C[a1@a#VZ9OZ(ICb
IZUQ>c?Cb0?4E\N>5\fRd4<Z-H@-g[)7aBf8\\VIXa;U;QMC-B_3)5F5,gVfO6W=
F].b(.-UcE_0WREGO(-0.R@0KFC>Ced4=:@-a]_B&AA:_6:O3eACFU9J/=fQJc6&
9](XE(>]Df9de7fOE0d?FEE)gK_2YE-)U+>8C+]B_,1?VTZBb.83RE\KU7<a6D:J
)@5\,>H]/XAAXO^W]^TSabeN2c:_9+A5NVT3W8NL1A;GW:^9JO:g@5=D]44b(_)X
+M:0#_>T2X?S+>8@)#I(F#2,^#02S.&^K8DZ/B(L12^S>^HL=aWWE>;/&/]Uc/?)
FC5gV.ARC:E5GX>/2OALcTE:5@bH[dc;f(P>PX^QX/,bbE]A^_7D0H1AO=Q?f(6e
c_?bO8=N@7EVgf.)F@:BVAOf^Vg/&A00WQ#aGCKUcPQ/gW/1,JC?:>]_H]Pb(g[G
KXd.d>F7SQ,;03d&#5BJ8)[QVTEOS7BK9=IM#_@8/4@Q,bE=<Qd>YZZFU(>B3;8X
L_NH8WJefH-RefDK3fL#LVLdP8>DR.8YMXP+ZRBS/2eVS]K\3AI_WFIPP@EU4,c_
f&RU&LYNbPTOWcNRc@2:18_I>E1)GP/Y>C5KUd29IKTbZ<eM2#c1-)2W4[.\IZ+]
2O\U9;6ddL.\-ZDYG8W,(&?RD_M+.:JXQ73.<5FL9cb\4LDcDL>7,bAe2=>S3>dH
K@WeQT>/M@D,6_/\->4:<aJ;Ed.Vg?0@JD=F(@YN/LW:@EJFQ+F2T2[f488@a:]S
cO6(+a&G(FBC;/E9L_;,CMQIO,c>a#=6WHL@L,WaU4BLVP#U[9bXRO;P78VKe#1e
c,9;=NSCc[Q)c<aP[R\H;V9C7KaET\0@TNaJ[FUBW_TK)-&K)I0]]+Z4cQ0F;1a8
1RB[D[D[d,[R0Ja1CWK6?7WHBcZ_BNVP869)&YRL=7]80UT,X[^0aZ^FF)UV+#&d
-]<VJ@C077\W@F/CP+.N_=7A1gVZ<a&KK9C[bRb//LJ_ZU/4[RYQS3VSZS,N>IZ4
M+DT+bKI6gOFQfLRc&1B64QRR=R35:?RKDB30eW>L&ZJgZb+WdRYN3aaa:4<3:KG
Z4YRe7?Z21?\GeT6Le,dO?__O+GQ/=WDQV3=#=9a8bD(_90\^..0b6#/KPARBA_R
=P87.BdDDIafEOUd7)d(P6]gD]g<G;MQ+]YIH3Cd0#SK<gYWaReEc,R@AP0H3DBC
bVg56(&<de]S,.;M[4&WV-a_Z+TFc-X5\AVT_+WKS[@+d;7Q^Q\2aX[UOH42V<P2
+Yc1PY_bD7KZ_YMWW,)Z34bL6aKC4NKbg\CX?.7=U51C?8)0B[T02Z&XK_FdH7KU
YM-X63_5dNO38/^[JW-PRU6\=\1P/.dM]^0;D]1F\ZW1.g?GcW.FcD9+c-MY4RPQ
_>W&,Z7OE\KCISTb+#JY#aE\_I>f2?DJ+C0E(.G?a]0M?_+HO0c0_d];AG0.#<6O
EIQ?.3a7>#[J99OLf.VQgI^2J_7DZ91TCRNEd\XX-#.^/38fD^AE=ME_W.H0EJY1
/Q+FL/GT3feaC[G?)<Z7<S=H&&Q,/;=C@;^2U7;gBaHPHJS:1E_)-81e=Z)cB0Ff
;#,856.1_G6J]Ob6M3QG:N#X+A_Xb2>ed[XLS\YU2L\LY_[_R8(\M)P)=-^19^72
)Wb(e4D#F6M3L=4&+/E_,+?<V3V]IJ6geJ.=<ZLED@#LU533Q),#bAJU?g7DI,bF
,9ONF>&T7W#L;F.NTM.c:8TTH6DPOU0SCK^<#F4GO6[/)>AbDT1/gHdQM,)[BD+5
QLK[g6.9?dK=3+92Q:R9/,<c_^ZB;eJ;?d33D30H=YOWCKAcce_=)2GI_>DA#C7S
5;L+N.J/7eB10LQ=62GL-&\C,<L38K:&U?bMXK@^&,V3)=AJ&8JETAZgC;JMA-58
B1@2C/b#DT?3(G8A3I^29;M45Z18b:?@eV:^00-dEX=X97.aFaOC>fT4+_)b82bU
FU&Ia:+fS)Gf3-fM5KOS5S@X#_V/<MDOP6^VfP>Z3O;1-\cY1^#AP^=bS09?Q?BK
MC-:>#HX2LH0HMZ#&3@]>0Ye)F,ZEg-.6:5YKJ5gfc8>?Z<M)1K=X&IHB4A:B6BI
.1\/)a]S4c99bFTPc2K2+9QdK?/WC@YKF361YZg(IR.1NSN))5_Ya@8[22U-POMY
(1)]:\BJ<ga>fe<OT&eB^;NEZ1Z;Fa&f/45FP5R_c+N?&SV3+G0^E4QCDYId[-ed
X,+:bA(bT(S(TcTF0d#eCUMN@2-9>-I00(;aU:Xg<9eR37O/OXd.ODEBB70K:d6U
e+/V@^VO#V>\Gf<@BFg1[^D5g1/fNTYeeLK5I,&OFF->?2fCN3&/6V[.YB/deGXb
[_c<?9aR\g8M,-F+\P.U8-MeED+YSHLBH3a<COED\).]NS_AMBeCFOdT>K>,HVNV
#P&].;&g[e-M.8WEb0@^b<D5C)Z,6+#3@+K)&dHaPCgA]RZ.;RX\QT(,e9R?4WgK
OK8&HASNe8X4S1><H;M0\JGABaNWN+Z_;3fDXg#EWTMH]-E6d7Y/R?McEb(N,cHM
.eB.\6HOPcQS<&eb0aJGN)<1JcRcMd/28&Fc.^+PWX)5:FICN9MfAOg,RJ?TG,37
V+Lb-PV#XO<QWQ1X5FOH43IYOb@IHSBfZaN^J0<g^P+[A+f-e:#)+[JUR90V[B3Z
\-2]T5K(K#)GOE:(/7Ye)e+2_2GZ/A<9/0.02FXY0g6fMaMA_,F)C>;W;AQ=cYfG
PEZ[?>Z^(W,@T48gdbIaaeZH;W@:-=f3Gg9<.G1)^(EHL06]>_67TD5cM9/?#ED\
7Y9;CIWfN3UQ?TFD72.:IMCc.S@BU9SM.[cH4#7/S^PT,Va^YDL^MO_cDa&F,_YI
K7Sga4JWT6G:8\0J_0D]A,,+>8e5<d(SH7bVc=1e#g+?#3b<\e1S5>e@V??^BcTR
4(23RRDVL),77RC:;BH)VX]R2^>G6UQ/OHQ,4IV9Xc#-E6HEe/[T<_DaU;Q5=@WK
1E^8.RGc&M],P3+<);ZS/VXR^14]Q7+DN#^?[Q:J6,&LU-B09H8eCP_<(O/UNScR
OQ4BTOJf@Z86ZW>0#,eTZ77\d)gA6cJ;\GdOH-\b.@1PM?cF9KKVR>(V=J^9WQWN
A[3.<<7603c^::#O<=EeY84[/5.V0X2PMad6AWEQ.e2_&_^53dA;ZX8d@<\YX_7N
K+VDGC#5c5/Z<4_0<^ZK0=C8P;2^Qe806Kg2TOC=H?S.f1[7Y#-/b++/663/N4(G
TIHW^K[=)#Sbd9<:J^)V7IZQ0S^(cLP0B0;WfgT1NaV\I27>91b+>L.NMIJdJ9[1
H#QF\BM)aV08]WA>,+O>Z8KV[B>8^]cCCH8)[BRP@:K9;/I7A_-/#22d?]ISUc_0
5YE/[3H20S[@8WQ_dS/5)^T&XB_\E_4Ea=Z_-A1?d1e(MN<d^6=Gg)bgFNG^YQ@-
KU8Ge\N<\8c.)Vc^bEbT7b26+9gD4c)d2CP\R6edG]^>(5g4XI^T8CGEU#)(93Z7
__7I-IQ@)O8NY:_=^VX+[L,]&##FaUO_9-0WNb,;@7O>@=)E4\+K=FR8D736/f,,
Vg1P?N&3Nf<b?96O:WZ>:[BT;:HcFD6UH@+.TRVS&R4&f)Dc9QO1.MNRI2#U22dN
5b8?MMLTG7aH@H]?A)O6+Z&X\fZSJ,+bR=UBNUPRbN6MK4KX>/.;>>CPaW0B<))8
E+2Cg-9H[@FUVVcZ_SeTIT_YM/(ca-ZJ_1<N73b(PP052P<c@PYS)69<d1fIV>Ke
9ZT&6&c4d1;c64G0Y&Ug:<192HWIJ4LS<\))&E>MSZU)DSeW?0fZG#IK@ZZc,bDd
SN[59P8#cY[4(EJJe&\g&:<FR(D8)T#2ae+fa,C\:9dAWa/X@NR^,aQ2QSV_/K)R
,Q+[XYAJGXWL+MO.O3WY(P]6?dTBI,9MM->e1OV_O27,beZQ:c-GZ?:GdW(?V_;B
(JBEfTSe:Db2<76603NUOH[F[\WUf\LCY49/C9CY<G+CHda-K&8?LN0EYdA6>.J<
D;Aa4W^H6f\-MB&#cMYcEETU8c+10-^5YKc+O1@NKPJW^0+INa0?Va-8(7&,V8Y,
,,0gdT/T^?SI2DOAZeT_..6_[[KA]_b3M62e^0EGYY\OL]?6aD]dN\T?MFOX@4)E
OK<CEd>>&:Y&<2#AO@C##BZM4Vg+KT;G\=D]V3PfMX8[4U4d19NM=He:5D(e#+=4
XH0F<_PZP(DBBO.fYPfXNY,];0@.&4AI9?L(F+C;NK<[XaC?f?66S[-4dCdV,<QU
e3PbYVT#LGB7WZfBa<cP71HJBN?HZ0E<)HC+8gI]U8JGV/dXV0&)f7\]QZA-/0EL
708I#6/H:U(LPPFJ:2--.&1JP3.&NdNOTR:6V@C;GdZ^Z7CQ7bIagAd_cb-Y>S,A
T)HDBAYfd\>7WRK/COdXg+ILLG_7eF;V(4-MJ02bS-4.+L#b[FJHKHK9^H-H+^IT
W[>S+cgOfVDe:0614AKE2]gP1@K)AF>G:>E)1\1A@&1\g?5Y4f>X.CZ8U\N,VR#1
+?504A_XC5+=:BYE89[L.LGEV)d,J^LF/Ee/2UT&8\dWB=f00X5>\T&8XB,e#5A)
9WCFQ?YSXFWAT;C]=J//d4:;H38KK)2+a&NdF101/<3I,5G\Dd.7(RPBHLL/LVc&
N=BAT,LWHTgfg>9FQ_49OJ3YOMeT5ZGF(6(U0.8^JW5;B#YcM;WS+T5@LLEX@GIB
_]:5G;=H,aN>]fG>#1\Q_P68Je6?-LLJI71e/-XfH_\8eO/4Oe.6Aa9[ag/ZeLKa
[<G>Pb-03)P[,V&W..d>T\fMQD-aDNE#?I6+A+RZ1HMb5HX4U?3XYEX+(dT<e3S8
0F<3&DL9=3DdHIW-14M,^WGT;9S[)#4S7bK@M<0dN(01Y7R>I>WW7)]<2T&5N+EY
O<Y7,.S7d<R@QbA#4/F^]M&,>[4(0T:E/72^B2>#.?1?8B\)2DP+T.[RBG?a6NNJ
48P4b5:PP(P1S+;GC2W_VX/d0(@X>-CSW?JD)@<WZD0#FZ)&B=74Od?RT7]VfZ)_
PH__L,;g0d1U[V/>6HS^3Z5XJ>A9CJ9TY08Q7C;YD1C\G]AbKCIf?]>6IDKN/\R>
-7I?_U.EL.:Z7,,HTGS-?Ue2(?4(?2g.&RYX+3YRXe;4?Sf6fXN4F+F;-Y5BeAXd
+W:e(T:RTG(OM1a5A?VLEMDL:@LN<dd59/6>GM)H<?LOTB@a,4g>.W_)2]HfSDVW
^DD+G/)1WMG8D@?U?B^VMcbO&V\DA50RI8YMVJK4B7bJPeT,gINb6TXJ7+86+1aE
3H?b<[L@B3-Md;Xf_>;f;7d\Z+08Je1@#QXTC]BEG[D.F\>L@:#_/J?BNXI^HM3,
C_a2L2WeKA.Y=Eb[aNC]8eg1X12FSA\+YR@;WE]aTA_],TODc;:I1I:,\D<?B0f^
6DGF=)g-J=>?N/Kf]b5<S+B;V_T_>I:SB8<O._[4H[);/PYZ_1(cB++a\(#A(&<?
3C6=P_B\4b4LbBXDX.&M?.^LHSb\\_=3+9Ec1JEI&7#F)cL55)7EIFG750-MKObA
KFK,bF3X;WdVSP6]H9.Ibf2[72/=W<S8O6-Q^<(;S1Yg]H^DDB1?86/Z[EZ21f9T
B9\Ae-QV_B[U5P@;S:=6E;DP.<e[1eN[8<Y0&L87##NL_38CJ9gYR<<[/A(X&4P-
fBHSb[ZN\#V8R4.H&AW.]Za_YHVS#.G.8Z51,[b>U@WIV.LC8_H8R:T(3=b-#CQU
(KG3J6)dfQ0,A_C)@3X5813[;3aLDZcBdU?H?e0[B&[P(Q[\_1a3[+JE<g86][,P
2(.SG6/<0-K<N+1\CH6e4Cf/4#^WDX>(XM..F1bV]Y&T;//<\47HXb>3_/#,K8HJ
XY]G=1[</WU,/J+>8U^0CZeP8((;e316.(fg.N+_1F6Xa(W4N+_)aJR5+1.K>S-7
D.PVE?^[Ud]d[cY[cDO53\Y_ZaffA9eKd0C+DQJ4ZG[W[#YegC0U=cHNO3?F9[&E
KOgB_/?B5A#)FMW_ILAH4AWZM^dVc7\N5c>+DIPY/A6+4f(/4cGa1gWA)gB^2fQT
Le6A@aCeeXSG3/L<JRd+X<\MI(\8X608f+6T/D2Lc;g?50R4.0dd7GSVEP4H]LYe
C2V#BWcF\XKW,&bF=.+6\6:eS2F8YGV6OM:b\Kg;fI;(Y,B/9J>5fgP(=d236N_e
O:34YV]CYE>;Bf-(K3,=^Wb;fC6SF-XF=R8a?AXE\b#QSGB)A>5^-./>3aL8AaeN
9LfHSY/Z[Q_0E][TfDQBC1Kg<dg?7=T&9E80:;\;4U6LN[G2b1cCN-@N^C9]Q&U;
Zd[5;,M@;[SV-Y?FUb)\A;0HQ?HQZP6bf#IXe-ELgTOWJRR]<DUP#Q;WfEe2?ANG
2g;g3M@2P++X\fPVRUIS[6JC&507/A/H9?WY2QdW^W=W1eCM_:0)F9U=2-^J-cQ&
V4X,\K0JO:+_VVO3(dY<9dgg8K^P=G4N&NP.:UgS9]43[\^HX6P,XZ.OM2,b6Y>a
e#S-:&>())/aLc]2.R/CC_G(40a]g;1<[;YKeJ5QG;)3=7/g@\eZb2J&F;g,(#Q#
QBc;=aB,TLLcW)5->\3ENIC0JSU\2ZS.XG]+<H0QH^e0:E44J+bJ)f/T7g?>Y,HL
7C4-?HcIYWA:JPbSXHgffS&b]25BOXZ&QEI>1VH2C8#ZQ0\98AbLcLWRIW-;XJ/S
772XAM;>4XPeCF0NR=MGM8Q_N3H7KfIZ9/@T,N]N@3XZg:cJ./G+.-1Y)T;#bYRU
+^JTSHc/=VG0&SQ3SCW(b<T:-X7CANS/2,@V6+/XUW9bK6Y.C9.)^ggOGBYJJ_R0
Kb^<Y7\-WWe:\f?abNb5].Ge+1QC-<4A?M8dDH8JF^+D,_P#+VcCHO=FMWf;UD&=
eJ82)T^Z)c<?^,<.IZN)=JW<VD^2WSb\=.\#Y>XMgLV4_/,BV0+3ZDX<URbc^Q&e
5X[IdH6B(SJK\H3X_Y6d[?bb<.DP:;g,b_XQEH0Ig3QKX3/TQMAL9:PH([SLH48F
A:)><WG&c2>5OE:B/.6,J^XdJ\f@e/G]L]1S#g;CL+57S/&Y.8\TCQ9=R)PeG/d]
P1M0[Sf]9DIf@eWP>#ePcF5DDOE]6<&7a,/b.Sg9UGCTG\^MV1b7cLMg146+I=ZZ
U^e7g&5dd5&W3;UUMQgYQBV5K[4VLCXBIGN<AX-=40\A8a0G+gWC[a.INHOY-F>@
F2A?0c(cC-5G(.c?]6=^;[&LBN-f,<H0\7+DP1Q5^QV?Ag_.2Y0N1KEbO:5[Ra3<
-+GWE@W=bE[,a&&5,Mc(2X8Of31]eN3W;8HO>^^LGA1AfVe/54]_U[RIb<EP^2dG
T98:>KT9+DUg8(O0V,e@eINfc-]K0D&.;Yf)Fff)BPY/S)gN3/7>Bf9Sd&65P54J
9Wb+L3:_?:=J9D6WE2TU61,.^>e1@LT33?a)RSDDDT3a_TK>-.4(G92\g=;QVB&D
Q@J6F0,/]@SB8W]Y=dg[92M9AX37Ec(bXD+XJ@_e3K3+_)D:c5C+S0XfRD3WUbJ8
3E94GIMCSN<JfWMG5IaQ2-UX?N6CCIS/g#QH\PI/R>J,O2@[WVF,DFI,f0@@+F;Q
J^<^L6N(/O4/V#bN-@be@>RYb]F&OCD3UN2\[AAVg=4cfY8?fN94@3JQN3L\OSD;
D;ME39))F9;@PR3/;S0WJVE;a-E)23_>2?UM?2M@\@f;PRaLIJZW]c^DM7A^RB@;
R9g\a-V4)d?5_2S01QQI==KJFD;N7-K8b6:+KTP,(RJ,@[8+d1XNUd2(K^U6^YGY
GX9LZRL>6WKe/[V(E/&)?e4RR&6RVW>8.X7N6.VJ0Q_[]#HT[?W.3C=#@O^bf[aX
<##;4g<U5L<M(\dW5UJG1U9[TKR4=S-Zc0.f:;JOR<E87B/e2G@P9O.6&)5OA7U2
@M6^Y6b=<e6NA^fdbO6)<\DcRI;ZbI+Kd,;_c8#dLM#\eMe,-f&_;,MOVNI;KdVR
N<(E2Sb;NZ/C:aGN.7^7)X\[2^?7I]I1Sd.\K;\a_IJ;Ec&.fM.e7_Z)J;4U\]2F
N)84e65+Z_T>L/37(0/^51NSI\9\eMWVe<:Xe@HEEfO&EdIZ/dY9\(X+0JN#dR5@
4RU/TWQIADa:7(339Q^eK^#A.UXU;W3TF/af/JGYM@?OZ#GJA+<U]1<_gRTTUAUP
.V#(WBFRX)3g_\976+73OB:3fG9M&N@QL88FBbSX_4[9CX8/a5g;2QXf+3?9Vf,Z
&I/a)&gd@KYV?bV+8UgZ:+ZBd^==aa+SKC3]KDMWK0TCC34+[-<-Wa#+@G623.10
b\PNW\0cLCD#&Y2NNBdf_6?:XfZ#7\/Y0J67_.2/GI(dQM.6FaP6d(a4cC1d963,
GAT^&GC];J2#)3L2FI,[dRRYA4[f]PMW]gb,D+J#BJf?TI+Pf.UG.G@cCf+A;ZeT
-^:(9CQ[d3CFTM>[^EM75^2=^6^3UK],Db@^@Y6AL1dLf<_ZUQ(Wd#H3KDK>FfYH
ea9L1;20\U@Q;SW356Y]0,a]&9Z0,ZMUXC>.XeW/f:9(c_BgYXGBb99\D9c,C);G
b=&HcSKMI^X(@&9V=\@M-Y;Qc95L+P8)U,#a&<@VQ]9d&R+8F[X[8X;&-]<6J.MN
eVJ2W73[Y]Tb_ac+\<7SW87/K?3HA]@&\eTH.2IEgP]F8d=OIJ>TZ[X+E-U-QcRc
X0<RJ]g73>J&9Y&T8dOVUg^0=8YW^)Te/Y1>2^/MJ@Qf]6ZLZ@0bcKP\HR_)VG4D
>L)=Q(0J^Hf<@AIH9\I5&JZ+O?95A6CKI.R#/>NEO4gV>JdC@FRHPMg3:@a4I6Yg
&[C<)Qa,XE+)RY?56RYJT?3HGbKD1;<e^Q+9]@b?0^Oc&GM[A:H?^)/eSD4BYXBQ
eJ:0>>bS@_6OWU>ebRE5Bc8J<(:Z.\IY,3PV0ZQHT3Y1^T1N3G?E7-Q,0Ygg77PY
,9HReO911<OD9SX:=/A\0J(]G[&6#C83JBVXb)+TU8>FF7bR9>:5/KG<XG331?5M
5FJ)bMKc6YHVUJ6?eU[+@JG(gG77(H]Z(QC?9-<]7N>aD84DaELAGf+4YN(47JJI
Ke9BKGR=_<7SVW2H5=Y)Xf+R88F3V=:EgUA3_5]NKGS7TTN[P.]?\d7LLZK?XC[U
eP2OSL-\AO]^ZKDgV4J;K?K./beYGUQO?c[W[<]/_+U6LafaL7LS@gR)(5_CDM1B
B-HeZG8C#VEF0K8=R-2^YB3:6aU-H3Z0@357f?M_O##a04Q70[BW/:cFRR>Z8:5G
=#_53f)IBdBVG?0#3^d3)[FB><OJ;DXQ4RaF_8&bNL1&O)#5,KC\?UO4^@]f6R0C
Kf[S#1KO([d?@+>.7QSJE4)d8FFL?,9ICJMfPMW@_O?O-bIV@aR\1_(#(]30Z>MQ
^L-WJU,8CEISA]]EcFe=Fc4]64:>(LF4L\3U:-SFV]cQa7^C=Ze@8#UXgE:TLN(5
T:Q?J#2L008#bEMH_8U,^,YLcO6#^0b.NH4,,NRATU<gW(Oc,MM_bGK,0F-;:b>6
X7JK69GDOU=1K/GI,,/I3N2/-E,+8B.T>U;A?gQ8C670+gf0&6fSL&8_+-KV]715
_f&U#=&]SN:M]4C0776<CV72#_gG-=VHb1@(\VR>]Z_4=fW9GeEHM;(P6.;H-CWO
/8[#-)?Q-8RV:MXeYg/3RJDYZ?@^@.4[[gMUGN=?8eHUEP?d:9U:FZ8d9,YMfZ[_
BTU-/#95gQ?N&8ED>QM:^0cRO)#G9Lg2f3EUA+=cYGa&]7\P\5/HGfA(OePL_@W>
/E5,>aQ3^,5YI)gcX^2>X:8ZJ;fEI8^d)(f3+,?>b.)>Y3&]dU?AeR#4J9c1B)AQ
Y4aW@/->5.6c(^bf>4BN5R(06ZGH6a^&G^V_b_S)46@BDAcN@I<[+97OKbIZgZWd
,B<=c)cS>PG7##\8YGZS=RMZ9F8#O/8f+Z,3=JW7^29/OUC^e5AE66U&Bac[7cII
^8\8TVJ?B#.:_11T6D56[1YS<OM_e5?D^Q&&[_@ff3V1(a@X3H.KW:<e>^ZbYPL9
B;4=<Yb8@;1I;T[a:ESf;dA[RLVc(\EaJ_74\YZO=)I@g?e^cA,C<BQ+KANO7(/[
0W2dc3>a<AVH\/#3S1=@S#=,3fV?]++L1KUEf&c9UZ;&Z4)@FC/8^D>4A/9=VgS_
F1CRe[R6O6.9OJ]+?<,?T3RLKPC=Zb>V,5,#M^@GfG[@>R[W57EaP;d\#3@]Dfe:
KUN0LPFS1AEK0YS_-^K]a:dG3#QdW.VOILA;K[\BE8)GN[XEZ=-4E1P8+(&c-R3Q
/dde9<EKKOO>6c/63Cd;RJO?Uc=d/J;a+1K(&6MW6&cg]^0eXEJ_9[IWeCWALCa2
^-RgEcJ_6S2]Y7F,aRKZ]ZP;&eQSUPQNLV;Z\We(G:@&8#_L?.8)Jc0OGb0PeaK6
OZT.?.I+N,I]XLN@#WIC8(A?1(c.\01+aT_4e;&C-JB32VRfY_V.+][31>g1;=Dd
O,JL6I._IH/80<P3ER=gTDN#d0MHG_G.+ZRRW2G9&PGHQ^NHT#PX_/P+JM,=R^N3
Q<Sb9T26EG7N0?d-2[2E\Q7EV@e9:2T=3:ZZVTG78^cJ=DJ&;:EI10RW2KAN0ge.
,TPd,T=Lb[E_E02C2f7WA3TNI3?H3@:VWC#<fRR4-NMDg7M\gQ__)^ZL^-C2g5fS
/;fISQ(/?MQ#?bDT4;I>4.C2;\)Y-+;EE.GQ:=Bg0;[ZE,0;1/A0eFV72Ic)(eA=
0.2UG\.^U^#<]RH_b,^KGWD5g,4WYN-K-C[4Ac=V=K<L=;QK_,2AcLeZK<N.+6BY
A32Z^YW?CBe\5I(P&KZ],Ud?[EB0I-IS9UI;,?WHV:Hd-@?gNF7^[Z;R>LXSDb>^
EQ7b_HMLX^g4bARQf;gYbE\+W^Q5Y5@eET?Jf@)gE>b0e#5:X/M5a,38-BF&N(QR
PCV,<\6)<=bT\2UQ6)3f<XNJPB0KYZ6S(Bb#,)_\U)?/N=H]e@eDV=Q,6aXa^+aY
^.;W#f:De-N8GT-.=R(c7N<5M8g6DV.JU+)X-.36\:R7CYF^O7J4F8V0,&QJ8:;Z
?)#3ZaAUfL+a0cLQ11#LUd^3JK]b:HT)D=;7De:@5=MNCU[CB;C#M6-(^d\NdC<E
]4L.0>CaP\<9TW_AU-N2CaKZ:OS[TTFPOaI@\6B3@NE>XSeUGTOdH=;@B]@>TG0+
M@H,C:L\^N(4dc>0[b(IOU-]3T/-ZAec>#F4,Cf^&>+&4DfU#]4:-.(#HNBaQL@A
;8^ZM4S>5NR\6(#J9Y]AfUKN?8Y9DK.6<:Ic8454@;>Ea&#;BPGP3Sg/XBKg+V63
)HQ8FV+E\11-W\f:M7-Y0LO;OgF#;A_A\7M4SX-4)3Rg8bXVUNPMB6&+:(>[ZF[U
9JAQ[O(^f_P6?c_):8YD(SRb=/3JK0=4gPC#9KX399DYZQ<e.J_ZY,GN<;Ha;7bL
5bPSC-^;?:BS=PbK&cbF2L)1=>c6P>4SB,gde[&)ZYF64BdLbG(SEH.:(E[?&@(e
X2)L9_c<+:a^-C24;J8>QaY1f68+B&:T]HSX^L#9JWG\+>P0H9,:PS_5R4b)/RE8
/3S/)3>f>0cVI[_4[MB1\OA8)PT^ZQN(V;I,HTG6DI-M)&8dY+@AJIX4,BK02QC/
VRfITMba,H8MGg@H)FfM(GN6&FFM_9/;5LAPQeVLe:eON;W<cK:Z2\WMH?(VSaIf
(Y(?F\2_B2cNL3FK>XU=+IQF4]1^^IM_)2fH[fM923NMU(K:eO^7R+08JQD(EJbY
>-,aAfU,6agOT/>8R_SMBQ/f)CNC09E\f]3)R.-:,KE)P?;=]_;<KcP9cD\W0^T^
Q_dcd73R>_FPd@A.K969SUL\LB=LJGeK]VKdf_H-14V8PHG[O_(;Sd1@a&ZSZb@+
cff]J_Z]g-6(-51b@\-QT9>Q@@T_b]DW_4Xb]B[AG5:85V@P(F;.46E.Ue=a#ZAE
\a=UHOac3#S^A,KSY(IUcM1Ca+>GYf+1[]0f4gR>P_]I14b=YVd\V.6a(BIac94;
(J-\IY.7JXd([Ad7R[:-.9&?430YO^\3c[Y3@g?]Jcee;N5@RNO1OX0FFU:GFV9L
2AOF0)FT]9^(6;=T8aN=#-QU3JR_7+\7L.IA3L.@^@4?&;_FM1#EAd37O[CcGcPZ
K8+M]>+V3^C/Q?1Ta>NcJ@]81fF@PA+08Z=H^C/a<_;6&8Qgf-bW-NHOA#&UU=#C
&35@dKWWND=^PPHZSd;?Jf\F-5bHG-Ef.J,(L-fE,a6H0RJM6+f,S_/]VSVFW3E]
FgYO,XYf+CUWEA)J_3_e.Udb=<Q/<IAT/_-eN/TKbF\7[:;61_/\ReK0FBD[Kfa)
:Q]G&HU&(ZR(]E?:8VGG;FVSJ^&7,=:[bVO81PP@3]DG2GD>6Aea>g9e]bG[;0/4
d2]]#V9FWPb(O.0@cC39A9+LOG<KLSN9YRa#]HY7QTIg+:^RQPXa]G<DX^<5.U)2
;5Q-^4Q(+Q1GO8O1GSVG#:7<AXgc8@L9IL^L0gSd]MR&;=V?HbR3afa(S(COAGS[
0B8=1(8(^KFV2eaSQPAfa4-W=;26EDB8<L9V-Zb;^e]M7-/(D^=S[DP70e>8DW-F
RU;(dNb/\FFcBPeN.g;P^N#,XC_VP_\BOQ69d@e5Ta0/6#4=U^D:NI5#_CcC@^07
dG)]\;<M#P@4B.H2:T\[^b5aL^7\6ggb[&Z7=;FdIE(73;<&:GGc8E_GFGMWX?Xb
5L+@11J-8)8Pc4d#fWOb@?W[cK-a\O#+<[FEIFHLF4-9S?P8@4<W\C:[OHO@YeC7
gDGGX+#8A/A2eI6#b@>2Z_c=aP3YC+AKO\I]dG;8(&7D0S6([:^1C6HN:,8DB:H/
^2Z6(R#SP53BW>ffZ=BG]P9;g77J@.Me;/IRV:T069Ydg#?_aP^7KU2+ZNKd0Pc_
=a2fPX;^e:AgM)Y6Pd.5)C+0?HK:_;B@#EEGa\_48H40.dY]6P[9]J&Q66&YA@T6
KITSVd?45Z1a>T.?+dEJ-91P]7Y^VfedJc64]FZEdF.=Kc[>8A/<:^F/fUYG?;I(
;fYQO\aYO<#aJ+,7_Z8X=]Ze8eag@58[6a.DcF]#O^1D.aL5==;DJcM\95)#J2[^
9_N13-MXC5V^g/)a6B)^AeD?068UOc?M5Y>@7SNF#<B:V<_D)AG#U6T^[TWC^.2,
STe(5IQ_S9S^-bdUF:&L#3SU_)X??JB<dHQ_/CCc8DD6P&VQd-1)1F:O+:4[.:5T
)M1=L1FWWC#Z)5dSZWV7H,G1;WR37YdfW/ZXB_1aPgYYO:.<gBe8<(,R7gcSIFWO
(_YCO(JU9#,V#c=DbaWD-R)Q,K6QNX61O.1T6E+(05SG:T;,H.8+V,,>V;-//O)K
6GGEaB9QO8U<:>KU/54P2#:ac)31R(UYKH#UN4e]A_QB-Q9?eQ-eI^;X]-D^;@TT
dI<5V8e@(C1X:PJC-Ib3Ea&=WUJJ_:\?3DF-,X?da4BccU_afI_B51MKPO5f-A6@
afML\W;3]RG=S#/dIHA?SF<AFZQVG>[?:@B4^A:gDB#+F9G_<0D1YJe=R0KAI\2.
;0PAUK.-J(>g&.NHF(GRS;683+S8I<M?;796PbZG9b+#e7^I?>XW_NV[TA]VW2?e
WT-;FW;6-8I55(MG0E#[_:IgJE#4\^X5O=7J9OGgAdUT2PFgfY;a76]RD&K?NPFb
KcgR63O:;&7]\?JHN1\64HS<(J7X,L2?[E.#AK^D.?/&)I>J;JF5?]V^dEd,7+7N
#Ff>>]>.F+RD55O2@UXG_D<:?6a9Y#bUS[ZF9UULF(KSK^A6+OgC&/G,VgTY6@Ea
ObH:CN[RVba9a57T=(PO9-&3:_-AE7@@<ZY7P\3C4CXEEKC5488_0g1IL<XQS5Qe
NLfE>)MY(^-W0F>YE:aM2JTNIH?;XM76X=:dY\)N?J5R/@.d2gc2^[-R6+\]cXbT
2,CD_3d?A&AeBLJ=RZ34Be8G(:T?,#V[I6_.KSFJ:eYCg+U^Ic:_RVO/:2_C[>@S
Q;;15>PC?::7?0f^L1X?cfCWJb37394YUcTK))^6S7UE-c&[dXXe(@Zf/bR(@3OG
Q?8#[\96K[.+@NbPJL(?NUN<7[K3b\RRG]A5f1M[/R_-&8K5CN96DKaD47H6R-^?
9^1A:27ISD<-0O7K7]W0;W;.40O>+G.8,d[gH5@LQ<EO?YL#]QRBTcc6aQ7(HA+Y
@Q&&J(;OOX64C.[9b[d-O&3)\C4=1@4K:5OIE#W1<+V5H,ASbIaQQ1N6IRJMIMSI
d,LRS.GA1^HDAY4W)?gEd1;VBd4Q</-,F++^Qg.9N4bDP46cMI-B]OV,:(29U91V
d4.H5+E8ASZfAXG[G9H?E]&AT1AOe9XTZ\#E)IAI4eW7?c=HVL0U4]5BSP5<H0Pa
(=R,IW14[/54&c8#[V[Z](b(c+EMX,KdV1(S-^^>e\PF1EMQU>/VD4TL_9P+Ma26
J7DYUH]_R]eHac<d?(5\\]B)\XZJ/a89L.\KDEd#,,UN8UR,,(LR+9&F&ag9HW]_
8VKD5L3TL&3:M0ga#/MX;RSA9@?W-Qd)&>G0K8dZW+DRUb>Q[Y^&?GC59#]60AUG
>DS.2C=;5=bc\8\<=P#I=Q2R7]#Bg_TK;SK>/Ta&C+MGf>Gd,+,]c-#T3D(7)&4I
Zde[_.T_Lb<IX-_#AKU<A_]?bPEbe5_)#d3RgI6cSQK)C^eSUJL2^f)_E+J_YFI8
Y_J]5Y3IEAbTfM^J[MKD^1EL>0NaXL0C1K6Bf_?7)JcQ\TKE6dPN#:UPVIX+85AC
BbBdI8<^,[,2<0]0[gf.JL2/Y^bR(T0DB-,K3WA+[(fedg+J,&9LEWJ9c<+7Kaa7
AY<K.-U>fcD>EO3\FC2_7_JRb>V;.GJI9RS=/<3b7aZ-EJBO49aY7.fK])N&Tb?=
L?Yb0a.6dGXVaWY:CFTGYTH?W]R1c>+Y[U7d?7UT_^/3\)EQ]^?^WD1-1>_5IS<d
E<=6c2ZM;16NN@[#ZbVRWY6=gL39TKQHZY++BF/I[61IRNE(<eg<YD=5F=Ac8NX[
g8J,C<WV/S5[+_7^Nd\_+);0?+UC&92Z4G_]UOKFf/<,H[LLDH53D.MOc[S/,6X[
:]A5WAX^/@?:8Mg+7+,MLVDF/<Q+4D9(JYP0J4<96.WbdU4\6=Yb65UPELH>C>C\
>KX^1\9UE&fZF)FbDRf:#cE@_6.)@4Q28;ZT\L&TJ?-FWSWB1G1NMQ[XT22\E9>&
dXS.Y@PT73XW&c9GFZ1+EDaPMJEG]f:7PBF2WX>GPdT#8Z?M#Z@)2(/Y@f\Xc?IT
KSWR#gFYKGROf(C2&J97fD_[H:&^a/F0^)5MFXWJfT=QP6Z6[EU_[)=_MX^/3[1R
C/Je2B2S:@e5WQ+P&#M+[@N29+4S6EFd+eSG)E[DXUVAcYb0[g=P7#=+465#Z)6S
T++3#&T[S,4fR,EgN_g.6I)B.>/2)5aa_3c,)+SOS<:[I_K:V:26(&4=V+N&\5Lf
R5H14FL,MJ3da8f?N7:a94K/7G?A:J9Q&(e@C(=E5+LN]34;_.38&A=QgQ,ObLe=
==\?R60_dWW=defF1B[:E1M7;^cMM=-NE[<,TS],ILYOY>-O+BNY/IT_>7e)4;FV
D=_/W4R_AEA>D>-#YFZa:_;S0WQC=4WfFHWe\Va/<BM6^0X:Be>OCdE-#Q]LV[^<
2f36_<5LT3aJ1fLX<<CJfA&X3W8&AZU)MTZ1].W2=LGU-VK0MTNF3Wg9c+;=UKB5
E1PG:J?VR?<=fN@8/_S(/a@R5QTOE:ZREZ-JaMK9Y:K;K/cWI9AFJ5)e+U;,CORA
5.9\WUIATHVB@J#ea/S)[<BL@U5^P\gcZeH<1&^\35422Q_@?-(K=gM.aeN?)\)0
g#L-a27\3E52?H19^7T7Y=A:L,<T[c,Bg<MS/c<35dNI4A0:7U0S^]TM/F;Z2(Oa
T7VLXc===;^QH1ZUD\)fT<bWNVcY<9TeS\/=HLC1W-R82SaHL9YMT4,\RdG)7WG8
]&(_Nc524c?A8R#gG#(MDH4DeV_H8VdC+/M><f^_E?<2dP[#g>Zd7GL(K<(Y32P(
1^+dNg(?^6KT\55HIX-59bbI-#?CfIS<V=aS?50ZR:<^ga(]FcTeVGK^.S&8YIe:
D_^_K6W-ac/>.PG2?d8R7KN(dE\.\.7;AcA45.dR^]B18K/52.R\Yb/XOYTT)e7_
Ve36gYc8VebVMCI>b_M1#:]EbTR)2:UBEW8NBP)B2C6Ud;U)?6\^U(3>FI,M84DP
e&CJE-4#f0H/31?EB,)YEO@SY]PO2WFXF<1V^\X<&)-d+TLO8a2_&0=9@J.9KN\X
):?K5#GE]@.B((EXbe-+TVb&UYNXfc=X-2\8^H_gA-1BU8a8<-,V<<<YW^gJfHc?
7OHd&CYYC.:V?Lg3,CWg0D^QJ?bZ[U)0#GBg>=\X:JAV<>WY-cQB_<7J.6Y_)=.H
,A^d+P1FPBI>M?8_DIVRN7-ZLO42?=5K<Jf5VDO9a:.Aad\1WQ7.]6D[F3:dPU\X
:eX[@gFSI,>L0PH#:Xa/)W?0^<XRVKGF=d#L.c<@W52+7=X[ACKL:DE9GH.36H,O
(155E0]=O(3U,;(=U/]YOIF[W,&UEd>NJ?aLJ@Q>@@aaPfW=dHA.)f<9)BKdaeQ,
eM;2-4d)HfUVIQ9&>-)OB9H)7Q3QEeJ)H9(R(IZ_<d)cR6&:S?X2eC4#Ucb\SG6\
BW]HMDAVaGe(9f6(cK&.8-.6GNd_E#=[09:O:KRHTdI5>c_5X+Fb?]f5KR\\61>I
#&LA=D.4f&<9O-&D8/1C(g3;a\>D#-E-N78<KP-Nc28+KKC-NOI>V5Sb0JW^8(RT
OcNT4:7P;R]<[QRfbJXe;0c+/M8YQDL^OGa=gKd_Q4AN3-@_.&A);&2Q=5WJ-1.:
#B],JJ4@:DACF#8&EW^EDRI#[<:.Wb5)D]5-b82MO0/+^YMf&,T=[OIS9+T3E&Bc
#7A0\0+1QY5@<>21>#,WMfJA;ffgS,A7ZTgc.NLZ8/Cf<J:3QQ?(DaY9T0G-PH#a
e7#(B.LW^=NC^I=OPI?=L]c1^94T,8H/C=>1-G_K1:74ZDRBLeH2TbY9O$
`endprotected


`endif
