
`ifndef GUARD_SVT_AHB_MASTER_CONFIGURATION_SV
`define GUARD_SVT_AHB_MASTER_CONFIGURATION_SV

typedef class svt_ahb_system_configuration;

/**
 * Master configuration class contains configuration information which is applicable to
 * individual AHB master components in the system component.
*/
class svt_ahb_master_configuration extends svt_ahb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_ahb_master_if AHB_MASTER_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  AHB_MASTER_IF master_if;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** 
   * Enumerated types that tells the burst type used by the master to rebuild 
   * burst in case of early burst termination. 
   */
   typedef enum {
     REBUILD_BURST_TYPE_SINGLE = `SVT_AHB_CONFIGURATION_REBUILD_BURST_TYPE_SINGLE, /**< Master will rebuild the burst using single bursts in case of an early burst termination. */
     REBUILD_BURST_TYPE_INCR   = `SVT_AHB_CONFIGURATION_REBUILD_BURST_TYPE_INCR /**< Master will rebuild the burst using incr bursts in case of an early burst termination. */
  } rebuild_burst_type_enum;


  // ****************************************************************************
  // Public Data 
  // ****************************************************************************
   /** A reference to the system configuration */
   svt_ahb_system_configuration sys_cfg;


  //----------------------------------------------------------------------------
  // Randomizable variables
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /**
   * Maximum number of times a command can be retried if the Slave response indicates 
   * the command was not successful. The maximum number of retries includes both RETRY 
   * and SPLIT responses.  A value of negative one (-1) indicates infinite number of
   * retries.
   */
  rand int max_retries = -1;
  
  /**
   * When true, the AHB Master drives a "Z" on address and control ports until it
   * receives a Bus Grant (HGRANT) signal. This is used to test that the multiplexer 
   * does not get new values too early. When false, the correct address is driven on 
   * the bus before getting HGRANT.
   */
  rand bit drive_z_before_grant = 0;
  
  /**
   * When true, the Master is forced to ignore wait states for BUSY transfers. Once 
   * BUSY is in an address phase, the following data phase of the transfer is skipped. 
   * If the response for the previous transfer triggers a burst rebuild, the BUSY that  
   * has not made address phase will be continued. When false (default), the BUSY 
   * transfer is just like a normal transfer, which needs to finish both address phase 
   * and data phase.
   */
  rand bit busy_ignore_waits = 0;
  /** @endcond */
  

  /**
   * Defines the burst type used by the master to rebuild burst in case of early burst
   * termination.  This configuration parameter support the following values:
   * - REBUILD_BURST_TYPE_SINGLE 
   * - REBUILD_BURST_TYPE_INCR (default)
   * .
   */
  rand rebuild_burst_type_enum rebuild_burst_type = REBUILD_BURST_TYPE_INCR;

  /**
   * When set to 1, the active master asserts hbusreq for one cycle after the
   * bus ownership is granted to master in the followig scenario:
   * - Master has a fixed length burst or INCR burst with 1 beat transfer to initiate
   * - Bus owhership is assigned to the master at the same time (hbusreq and hgrant
   *   are sampled as asserted together)
   * .
   * Configuration type: Static <br>
   * When set to 0, the active master does not assert hbusreq in above scenario. <br>
   * <br>
   * Note that this is not a protocol requirement on either the master or the arbiter
   * such that the hbusreq is asserted for one more clock after bus ownership is granted.
   * However, some arbiters may be overly restrictive and expect the master to assert
   * hbusreq even after the master is already granted the bus ownership. In such cases,
   * setting this attribute to 1 will ensure that the master satisfies the arbiter 
   * requirement on this aspect.
   * 
   */
  rand bit assert_hbusreq_for_one_cycle_after_bus_ownership_granted = 0;

  /**
   * When set to 1, active master will autonomously drive beat_bstrb to valid values
   * When set to 0, active master will drive beat_bstrb to value specified by the user
   * Applicable for active AHBv6 master only.
   * Currently applicable for AHBv6 master driving unaligned address.
   * If user is configuring master to  issue unaligned transfer as a combination of multiple aligned transfers through sequence 
   * then user needs to set beat_bstrb and hunalign manually and set this variable to 0.
   *
   */
  bit generate_hbstrb_and_hunalign =0;

  /** @cond PRIVATE */
  /**
   * - Description: When set to 1, active master in full AHB mode drive address and
   *   control signals along with assertion of hbusreq
   * - Applicable only for active master(svt_ahb_master_configuration::is_active = 1) in
   *   full AHB mode (svt_ahb_system_configuration::ahb_lite = 0)
   * - Value of this attribute is ignored in all other cases
   * - Configuration type: Static 
   * - This is currently Unsupported
   * .
   */
  rand bit drive_addr_ctrl_signals_along_with_busreq_assertion = 0;
  /** @endcond */
  
  /**
   * This configuration attribute is used to achieve following scenario<br>
   *  Hburst >> SINGLE       ANY_VALID_BURST_TYPE<br>
   *  Htrans >> NSEQ1  IDLE  NSEQ2<br>
   *  Haddr  >> ADDR1  0000  ADDR2<br>
   *  Hready >> HIGH   LOW   HIGH<br>
   *  Hresp  >> OKAY   ERR   ERR<br>
   * In order to drive IDLE during first cycle of ERROR response, one of following sequence has to be driven<br>
   * - Wait for each transaction to complete in each back2back 
   *    svt_ahb_transaction.burst_type = svt_ahb_transaction::SINGLE transactions<br>
   * - Drive svt_ahb_transaction.xact_type = svt_ahb_transaction::IDLE_XACT
   *   between two transactions for which first transaction was SINGLE, without wait states
   *  Also make sure svt_ahb_master_transaction::num_idle_cycles=0<br>
   * This configuration attribute is applicable only under following setting<br>
   * - svt_ahb_system_configuration::error_response_policy is set to CONTINUE_ON_ERROR<br>
   * - svt_ahb_transaction::burst_type(for first transaction) = svt_ahb_transaction::SINGLE<br>
   * When set to 1, the active master drives new transaction during
   * second cycle of ERROR response. The address phase
   * of the next transaction (NSEQ) commences during this second cycle of ERROR
   * response when HREADY is high<br>
   * By default the value is set to 0<br>
   * Known issue: As the new transaction is driven in the second cycle of ERROR response, the transaction is put on analysis port
   * by active master in the second cycle itself. Hence scoreboard issues needs to be taken care
   * .
   */
  bit nseq_in_second_cycle_error_response_for_single_burst = 0;

   /**
   * This configuration attribute is currently applicable for passive master only.
   * It is used for the scenario in which the behaviour of design is analogus to both the AHB-VIP's error_response_policy ABORT_ON_ERROR and 
   * CONTINUE_ON_ERROR in a single simulation.
   * Example: Like if error_response_policy in passive master VIP is set to ABORT_ON_ERROR, the design trasmits NSEQ in second cycle of error, thereby continuing with the current transaction
   *        : Like if error_response_policy in passive VIP VIP is set to CONTINUE_ON_ERROR, the design transmits IDLE in second cycle of error, thereby aborting the current transaction.
   * Active master VIP doesnot behaves in this dual manner in single simulation.
   * User needs to set this variable for the passive_master VIP, if their master behavior is identical to as mentioned above.
   * Set the master_error_policy to CONTINUE_ON_ERROR along with this variable.
   * Example Scenario:
   * CLOCK:    1           2            3
   * HBURST: SINGLE   ANY_VALID_BURST  
   * HTRANS: NSEQ          NSEQ        IDLE
   * HRESP : OKAY          ERROR       ERROR
   * .
   */
  bit allow_both_continue_and_abort_on_error_resp_policy = 0;

  /** Enables the UVM REG feature of the AHB agent.  
   * <b>type:</b> Static 
   */
  bit uvm_reg_enable = 0;

//vcs_vip_protect
`protected
378P8S]YN&Md0bIUf1HH,d?7Mf/R(++,OA1F4FHN.0?YX2)4YNU?5()::63Z<V/1
05H8,V[3&36S-Rc)VB0H7QYS+YA9T[@CFD1Z#NaX9/\6FI#EAZ2@REIa<UF[_]5E
S0cM[IeR@D:=cCF0A#/WLMVHa.X_Ac-cPVNMO<)T7SKH7[+Of>.KD(GQNFGRg)S@
E+A-?TN\+fA#IA349DfN)1f4,4\A+c^^B+^EL71+Y_gZ[ST,a>3M+<ZBHV?/&2GA
2FO#aFdZAIW?AKCb-gJ^?e@EQP)<dC:bHLK@<-?CCCA[9-4C^P@=Y8+H7@88dWA>
Qc);Y2YV@2Ja-G)O?\&f2CNf++6HR/+ALKbK=MFZGSFWNd6bZUe8HC:4YIC5HT^H
Q_@,S383JFI:(]ZBg4:)-EgN&DWR=A-8IYSH^5N98^8)dNcPS\R0IC(?RZC43,Y&
]]=1(N/Q/B/6.=&B35JS4+NT9&E42]D/7O\MD4_R,MD(N=+]X0]NPU\30X9IcV#T
,3)UR\FPaPgb4B_FC34[+]N(eIAQeI(_SPBgSJ#T68gPK-I#=]X:S/Z1?\ZDU249
R5K=FZA[:+;Qd?eXU]@SHW3G0GX:(>Mebg,.+V#+GeL<JXY/eSNW6+H9aNWXTNV(
OV@.PW=\R09JT0AB0C,9abJ_<fV=ZOA:V.7cXJ_bB\G-T15DSY.;-1V(6CX,&SWA
8c4+fS_=U9OBF?U3@K\a6M),+HegIQM\8;Y9UXR@Lg7d/K&V,7^D^GcB97bfZ=11
&(3B(FZ1b4-9USb&^BS>C)Q/.AZ&V]+18Ca,6P7EIMT4G,bU@\<YQ(SB(XcT]9&(
,#F0?+1)+e+4Z/]JWg]TCT#Rf5?81[(@>3IL+gPPH1Lg,N_I]CN<:OI@<JYd9X6Q
G_49JPYa_3#^I0Ce5(IE7P7(a35b8Ib6BR90T)=8fFcQ?41UCW4AA_7I3F.J/SQc
:a-9T=+#[^Y]<S9D85M#Z.VN3L3A]^+?=YX@+,5HMH\?a]SK<[3\2;7U(:16]7LZ
ZK(?AN?EP^8R2=)1OI]OZMdD9<>49QRS9Y60E,4=O?(U5R3ee[3-1e8=J.LTEc;;
B\a.^0+<)LB3b=+=b6c_2OgbU(C&;[E6_&T[@<BJ8C(.57[I[_g?51B0+GJd72<Y
@KS+(WW__B16HcRX0E9QHc2:>Z&M+GL\29IT+VcN3K=d:5UX_598/ZY(8^-STMVV
Q6I,TL8c^IGaP,EHN/BbU^YBROaXeeTd2?8T:(a#0ZKeAUCg]-@Y?,dW#+#eM>ee
+AF;\G:F).6e5e,[4[0D+=#>L:BZ@O.FMT(YQ&EV(K+d1@@)G58PP-.K3U1B=6,#
4a\#MS_EBZKVKd3QHE/_(HTX,CYP+V]JZM-C-9\\<U,gY2Cg.PS5-+Re=,1Ec^J^
Q/dK-AaL-fQYYW7MREb<Q11B9?@bP\E;(O0DMb[b-E59L@(H1;B<gNRL^M<_I6Z4
3-/02<253E3>BJYcL4EJdgQ0QH_c:df6cL-=RB0ES,6M.]\1K6?E07H\e57X3H&1
6]O,_7QAB+^T?+CRG+4PQXYNGP][\@+]]+,:?Fc<e\YR>L1DZ/7Fc2Ybb\T3_68g
D:#&[-f9K)VX#+(63WG[\aSF=\Y<0+]<LJd@D.]ZB;a36>^S_bY6407W?EeOKS/Z
[f&KNPa\fL1(dPdYTB)@H/b<aSM&4APF/4R<?IS6^Z,F670M7XX4AAX)R6.@,cWf
6-GbeUNd1^SUX,fK:]U(UG<>IK8O)X,b)4Led1MWa([&BNCU0CH36G>c8NAWG&>H
J-3;O\R]_]CU4OAIg/H-76S:F<N_9+g?<Z_g(L(:E:EEQaR/HL;4,#\S[3<9OZ4g
@0B?)-dRD2F&@4]C?9)EK&a9F9GGdXL^BK.WE01:VW#LC/a/YP>(AUe9D3ab0=0Y
N)?(@@K-E5>9^;La]O&[O5,I;#A_gVJOO=Y>CM?.#]G+#H0-JPZ&J)e2=\dQ2g>O
/)R0c_&bM?bb?IJ;W_D=&B?&e.4CMXCGg,b7fOH#CED#<GL,.Z6?LH3a;WL.dZ7A
3VR):YXNfZAHGJOMM4^0+=Y=F8^F#NPbXYITQA2M8Y4ZO/FJYK\=C+4;fJ4(K<A.
G\Gd(Z12Q3LHU<WEI]/7F(R6(C91CW<fPI879LQ<X/2J0#]UCd/A&C3V/\Lc0,(2
]Y[]<VOK^,L:Wa/<BF&GFNca;\da0Xb7DD]>LZ8a-=fB.#F_O?Q]5,F1/&GJRRBT
Og^H2+7\O>(b;@N;#:LG.OIC2I<VYe,Ig/+b_MVVO:;VB-:;.cdecBI2D(cV7c8^
dOb6;<?(Xb13f<B[(7(R@31^PR.NU_3,HCT_&\7#]g;,/eQ1K\R>0HdffM&5(9[G
1)TMY-N0GOOON]97dI/W]QLCIRc[9L?J-K?ga^dK03a<#.M2NE>:BgXZ08JUFO(W
VK-+/b:<U];8:<WGGSG<BO#N.LPOFPL+[=<NK8LN,27\:@;^A+L(S58ETMZ&?)^S
Q[4)5Q\aDEKK2?MOYMT?^c-PY9<#-]ZTHXb3I7BgFZC9O+I;YNQ&f7&QF1(b1SXd
#(;=QN_^53Z--6>22ANQPIcY):bTbaVP9$
`endprotected
  

 
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_master_configuration)
  extern function new (vmm_log log = null, AHB_MASTER_IF master_if = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_master_configuration", AHB_MASTER_IF master_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    
    `svt_field_int (max_retries,                                 `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (drive_z_before_grant,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (assert_hbusreq_for_one_cycle_after_bus_ownership_granted,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (generate_hbstrb_and_hunalign,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (drive_addr_ctrl_signals_along_with_busreq_assertion,                        `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (nseq_in_second_cycle_error_response_for_single_burst,    `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (allow_both_continue_and_abort_on_error_resp_policy,    `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (busy_ignore_waits,                           `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(rebuild_burst_type_enum, rebuild_burst_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int (uvm_reg_enable,                              `SVT_NOCOPY|`SVT_ALL_ON)
    
  `svt_data_member_end(svt_ahb_master_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  /** @endcond */

  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /**
   * Assigns a master interface to this configuration.
   *
   * @param master_if Interface for the AHB Port
   */
  extern function void set_master_if(AHB_MASTER_IF master_if);

  /** @cond PRIVATE */
`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  //----------------------------------------------------------------------------
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
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
  
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();
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
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  /** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_master_configuration)
  `vmm_class_factory(svt_ahb_master_configuration)
`endif
endclass

`protected
6(b32GbPB@dCY/ecFT+e41acO/G+0#(-,257Scb<:,Xg31YR\@//4)2acc^dS#f^
&Ae4);Y;(7cTKW?,ba]J?XJCORC=@+2H2\VQ+)RNFX.M4W=_4LMB+\SW4-K-H.34
E)][(VT.AZC:9E^13F&Q-Z4_8RUTE:J,f,KL^G\0>c9ES/&85(0Ta1\ZdVXS1O62
dT?)2-cPU2gQSC?Ffd(=57;ACSZWf1?E6U)W?QN):g](MNR8-1W8YH]E.ZR5+a1F
J@(@#Y:UW?]0N))KDXfIS)f]J_VMPDaD^3Ddb^J7_IIL+HEE@aN;@J)&L2G<4&H,
=Y.@4SScNH_/2[=#,,_6LCMb=J.@:)L)N1KX,Rg&X^b/9@bd6O&X^M0cD0BO+X(U
]W80GW@d\RGQfgU7.AcISQ9eK3+Dc30]-Vbg9fGE0TP2f=6dHR_fM/gO-aYWPRK2
U#I;(9cJ9G986;c=HLJM>QR6eDY@WBG?5.E/,7fC\:XPG/V_aDXSGaHAH@,ZJY5?
CK7Y)3<BLebK#:RH([N]3Z<#.N>GW6QG.+^PeJK87g+;bb.CX2\SL>K@G(V/-7L#
)6M75MYDQaL;:X<OU_[59)3H\.4I?==b)OAeY<;=^O(BL@:(8)<VT#b/.@]f<ZIE
JOR?EVDf3W<9Zdbe/4EXDR?WMC<GA,U6&b6\>)bYaXRAQ.J7EdI:AJD<D><5F>2.U$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
7CZA_8>BZQDI?0)C0E-:#[AUd:fX=7fa./aW3,XUfaXE\>Tdd?KN-(A\5G\a4XP:
T>PX^.7LaD]fAaIeTRQA10?YIf_WZM9UC1?8EORQY&g6^^5GSJS2CSa-Q\9>d+6_
B;TN+,85+e=(:Z.06,1YEg(7E+UG)9ZEZ><KHfK8b,LgMIF:Y4Hd24#MMDcVKG1W
>AK.0,+UBPNP&2QY(]5f1[Q@AU433UH@>U0[QB/VCQYEF4J.T=@KP>B[5GJ91;D=
:?FQM[1[R.0/4G7A3eCLId_Z]3BdI7#G#gH#\&(6a<&JS+D(((_^V.I7FW@b<JAW
R/5CS(<)&N[XC@U]cRW[>/@K94cJ8E1-Y5>g,aT77;MFZ3[:0)YIZeYNM9&N,I=E
^BQa6DW1(]]=,b=WG+3>B\BIPW<.S=[:V(93Y>I:J/T<IQG>SK6[[MX]WA&G-&32
b8E&Md^LF[>eREO1HY1CELD?7QHWUS_S574WM6X\WK[I9)^g,:5&;V&A3]/LPZNN
U>_,H]<+e@Z)ZVa>YNDS\B8/[#1TH=(SQ>0(W95@^g3^,^J7:d3+V@=.\.KNDDOU
24VMK19S,7+Y).#/<,C?X@-?1b/I.M^+RCQ=G7#d@.:VS2Ce:7a_&G?IAHgN30G)
X6</cBbe[aaRV[<SW7@?a)USZHb9?0=-UR(f/W&59YV.A-aOF_6(,2.[Q&H\7dE-
EOL^U45_8b5BJP]9e9L0c4fW6g2Ze4>\<Z(:QMVHF)a.Rg,]e@UU#Mf/8d[</L1H
A^:YM+A1:D6ZUCP2B1?F,12e[De,D/OP;1QQ190CL+S61096B2?fE=(\=Q3;V^ZQ
T=GA?@ZJW.gX7bRW]G@)V]C_JCK,3;>3G)N4N1W@)WA3MHWR@KXK<:+?Tb\650B#
.5ZGcfUa?-H(&6+Y[ARA+d#ZIJ0XV^=3/D:PM/b-Qg9gT?fXWD.)\BfXQ^OPK[^?
4W,?^C?LTfCf\OUR<35L;RD_<XFXI/I)S>TIQ5Mf?>g--IcDJE)H\=ND779+4NA4
P>G-W=b?^dN&D4^)7]b2Z:&AG(V4SA=1IeJeO)=A->K,@/81<&A:)6M5C5)6AaH<
a+<dc\U^E=.<Ba6K=-XCgHDRH7T#+.g[B^.&FSWUPD[JLG#MgB68E&4ON;\;8eH^
:2\.2[d)N-KJ,2Y[-E0QJX+&OEL8E/P[F^5/,&M>Q->,<d,bI.[M,3fDA.1b?YHP
HXM(9#=G\;2FJ;S-2dPe])B4\BEWG)McQ[+^ZG86ZU>Y,J69M3Rf3^.9_I@FUA3\
0eWB0\/C0S.M:/QATaGTfIFYI>5b#@CcMeIM37a3@TK.,PDJB[GP<&]bALMO7Q)b
I-<13c<NOO?B^[+&7McfEB-R@<(TG8eF(V_-aNQA5KQM065#VcU-(AQ>8bYfH2YN
#-SLQ[.S=(D+]WC->615a=P,)163VL2c3H0B9eFPd2Xd\GPfGMBOd.B\P6[\UFXV
_7R^F]Qc=JT8T5N5bcMLI<IU5f-5eB+7,,DV7#=M&2YRFH=_@/M(f4HY+BKd0fdH
#5D_B[CQ?445(GF=7A8dWeG\+.HF+3E8\^J.YEN4G=;>^HVGZ8=?^TJP1IL=28EA
EQe-G)TM+KDfMSB6,=TRNS]fHI>(]VH_IEWZ@fU:/WQEB#_EJ@8\V=B,11MP2g,S
A9+d2\--S?EbZ82XS;O[:^NIX]2,>T@PU^&U:3@_Ra?.IDMGf5]Z1_)07X5U90AW
U;M,QH184./;K8;CQE,19HL2AZ>O3.?d5BK8C0[1X=N4BQIXgfa6R_\Z&B7C7>cV
(_.A(]@#=(+66Z&F#IC+,aC\^SKOB5VUF4ddM&&MEVNG1>/NbO..D1(W^@YVHP)b
[AI-;-6@ZIV:VZfe6CA;38=3;bN,\]+5GWM:6IRY,KM[G+6Y_V1LY,,JYU/S4Q][
?1T4(ZHe[I83=(RFP41.WfHR23R_Y6T1YQC1B#K1f#:b4+]]SNDKL#OCE;P35635
C:5RI0XC9I1+_#8bKI,gAA&eO@C/R]g#Jaaf+.Z,E>8R.25g-e@15eFLPQ]Vc^1]
.FL[5(d(18gEc3X7.g_5+.E?e8:Zf+XA\dJ>7EG,_I.+0.P\\NG5A9170TM+^>#a
-T-_IgJ@Bc:Rc9W1DMd7]fJTV2/feLeb(^Lb4UD3^GK#(^JW.R3Dd5Fb8K]O-W:_
4Z)X-XcGbLX\G#0RE\L2MX#gZ380GYB62=;+&ALXWQNf=UYEW_d3_Je(AC7T^7.Q
?QP,L15JX)]>[c5d,b]RdUaYeSXgB^X-3cLWUTX=1a#KX\G9/C41E=XQ8D70AV<F
(D/H9UV_F>3=PVE8#8Pd//T-+::LB+.8LDa1&+U,@9(dW>_c2M0Y&?.K8Za5HaEG
,0JI@3D+[)A98])3/dE>/MC(IfI:ecNB=EBBfTE3gBNH.MN.aI8<(;b,:O#JSY62
bYXZY,.X7RZfY]Je>CH51,f29G]EX3S3aB+V](e85VE]Z776VgOAP(-CB,a)<RHV
Hf]R5+<F5PKD/B8Q;1-0VR[]+KHRV4<DdO;eCbY@/>^J)^cWf.bAe[7_=TB]^?)1
=g2bUQP.1_Q07\edTWDH6Y;(MP0)8(@eXVYa\=KaL(e+O>](K4VV_?-JOGab1.#V
?(2\:DbIP9aKY(TL;.SUBF\)KcgCIU2/7/UG>K1S^Ag3;(49V[2bX?R]Q#_MO[./
e9aB5<[/8:YRD#CA>D8FGeI-,@;-62K,8PC+U\/C+-EK,75[POb(A&-f-aHb>/Q_
>,B#dKe5,S2<[\aWP2HMX(SEY4LGS]HX)0NTW0,/+PYT?G4#1dM_@SD0#G1aB(C;
@:5_BGL[)PSK;0>^eGFa/Y+&Vc,S(]X38UH_(M)S[/BX02DX-d5^)cCC4?,<M\=U
NU]7>,F8C2+Y,G<Cf_@H>E&Pb0RUPIZc^^JDIOPa8J:]1S3>A)-WJ_DC^>@9c[/T
gO^4AFR[DH1c?X(:eV3L]GJWC9(BcFVN4>?e^Bg:7T=b&3;3K#;I\EgGOHZ0.6gg
_&WD)(XQZ<cbcZY_6A>TGQ@Mfa6:T9I@HREK0,=?eLL73.L?;;48Nf.Q6f?UPF]Y
&AdMAH<M6UOFUNW7;b,8.,D3g<]-&bGeHDba#7S8?+^LL8@<Pgf:YEE6L2&VYYb9
V2R.b9M&UCAQC>+Q;<;b\A9:J(?V1Y0Kg.TVGFI?S^35>)+^IC_a^dS9>aWRA)H7
SYXeP<),/OP4V>\OR(J<VD9;Z2+MU,Rd>..aWQ@O4-A,.Of.QA(A46f>20DPS@5Z
DDW0,D:,@(6R91FeKW@<ZAV-8M1U?HU\DdcCc<S.>BT,H\=D&MLAA16Q>[P,B2>Y
4YHC:ID-:.1@3badP>]_fKN83,_=5N0[DOH8--aOOG0?K_-DV?]C]CY,HZ6PS1[?
A<2\EdL9ACaBcK&_(LZ]HYfe2LcO2YF#8Zf:PAB6ae2IKPD28NPBNgZQIbI3;Ea>
Dc>3ZJ:-4)M#f,gBf6DD&7cF^(WY>D-:7c5?A.J&EOG\TVFReS;TDg=@6]\4J4bU
C-;[F\B_,4YNN.B:Q)&_LbCE_d_I:?F5WL&;U[-TT;&H8]Q38]]ZRSEIAL1.cHNK
HefYGDERDd@_#3b8+e.E/,LWE9JIDQ=NJE.NB0a4.83@ST,.CG#+/R0Z6E>+>9,P
&&bfQDB4DBB#>PX65T@PW9cfSE]U.<gE4M^HA>>@T=<U9b^UYcL)g+M-C7/9<A]B
\9Ce6bd/KYE0VX^W0V?J@?[e6=B78aZ6IfN<9VfWV&IXFV8=aCL=1dTa(5-]/_DN
=,fFeBEHebOHDP61I_9M@f1dI:TTJa>@a/@DaB2@4A>28?Q\0@G1[H32]OAQ<_2.
G=:^+QE4_5=ISK[Q3Cf]/YLV8^65.#9C4(?P4&6US9Sg?(1&M?A<=S3>RV)_a-3(
WX-N6cBTB99(OUReWNfRJ0>XI2dBBgS1G@:.UcIU:8c;9Q/2(=,=_YMBJ8(TN2S1
SeFAP3FHaZN8ZE]b>@5.3H@KeUeb_VA6cPG,Fa<?5LT-#-(fD0aEAf=DE??EK;U)
[9GEHM(FdX<e<A]&>[GI<U0P2bV>AZT@D/;&,?#Ma#LR:E)H@f?(^eR,fP^KKa>Z
7B_b45X:N;)ICa+KNaZ@dNgR85G[Hd(@Zd:Y3Jc=(\;-J;7+M9ZR)#X5.DLH^JLW
FeOS4DV>,&^U94[O;4,IQ^GJfKgS<CbU7AOdM(T-FIZOfF]4MgL8)]>13Y1L3-Q_
MJFOf1H,@2LLR/9AKRZ;<eF6Hf/NM939D\[_T?.a8\#S7HMV1c\/Q9XM,d>M;_&Q
7.W?UD0.PM/&^e[]5dTKR[d,O/2UD59\ee1\&=?dKeA\N_9?1TDc>[MLT.>NZ8GU
TbBQP]\a(RcQ3=C3^ID>V,R=baJCdQfU_=;\WaA0aP1<-6IQ-&cV;M8UE_7b+X>:
)NH^[QV^b)gR(b:?DOZC_Ka-^a-Jg5N6Ya)_-E&=NOC<>e<bD13Xg,V.A)92E>e[
UO;O,1#ZPBEP4Y+3]IDTPN,\UMNV?g21cO\K_H[GL7.fG?::c4KY9ZaCDL.U&@Sc
BfZU0<\W;B5C&dAV=S[<N[O+:-,g>-K7TU7RC,R0(<;@\3QZ+V5_@9AJ1UPNga8+
LC12I?SL/RR[gED/MKW85@&8\DLb1/:bFL;EO/]8O=SO&V<@74D/##447RAR^SH6
a87[?:TMWFK#@1YOT;H_EI?.(#K?F(c5_EHHL,AT>beTPJ67NJNY9RI/f,Rg^0??
OPXb<&fH96]O.RgdDX+e)E&+C1<>#M9)+a@eI,bWQd-d/aZ\S5^O#KF^M>A3ZAU6
^:76)7Z9ZYbA=bIF3TUL^0[:AbB@S4K=:M@0g6Bb/L#CSBA;H(.67eG]f7F=ZV@P
\VeQMTL=]OIHc3Md81H#S#&GOS9.QZ(P5VV[S1.D>F&Y9ZLU+d_eP3IgeDH;K2Q4
IJ]85L^+4FOH&U-(,cMASc-&4O5(G[B)KLa=#+8#ITB\+Wc?42bJ:YQT9^gH7:5G
.,dMCI_Z:;MIW[>.a+A&A5cJ3GCS,\AEdS1_6]>&,cd9HbOA(_.EB>[>)94ggJ^G
Wa2V&@VgcG-T/[Z;_2QS=W7AJSIAB7ZK);>4A;]ABM&?)&PT=/.JTQ\YK5&6Q9[2
A2gCX+.3?3_g-(CfVP@bc\0K/V#;f(DT=_LdW+PE2)WG+c6VfP(f((N\DL3gK]ZT
a+<A;0c5G?bVdV:&S[X,([d04\@-1W8[5TP(8G)V,\4\ULBS3OG54?7Ye0D;,EY+
GE(Ka,&PRJTF)@DC0,ZPfdIL/Qf<CI=FX9,KMO([QcM;U;dLSB_@XPNaT[,L.?>c
PN34+8X0R8M/;fYSC;]0cB+cgPA.2MU0MB>[5R9?=9g5c&=:eHegO3DDVV_BHRZX
f?5,4C[;^,9CW)d58_209V0CdL.:FfC#IcXO/((?YBTY6K-_,I4BUR^KW5R(0_II
#7KHEfQ@545J8CM99].;S/U6:+6&K<&T4)Vd^]]4,?N+9^RObFL?A-UZGLI?:E(?
@VKPf3)&96827X9/>Z+O0=WS@Da]c^gNe(&FE38>.A>3NCYU:-VdS3))@=.B+MGa
86(A@/>GI-G^_S\XP8gEF[BXFEd1ID2[>39c50SGAVD\-f2<Sf8b:X1dQaEa9OA@
aNKc:QS7(L\V-__@dc\eA=R&H81[@1T0+[##Y:Qa?c&5]g-0P&TQ\#Q^T0g.b>HZ
?dW#)?cbdIgS]EKO1[R[:-gNH_A&^If@&a&-SCNb0X4[d<-90UaTbF5ZO@#bCTd>
_Q)XU0?LJ5ODGM\DM1)BC/e4FMe:O4fabTJG:a[Bd:La9]G>8a:2Z8\KdR9H:,<B
)L?^/)R(1gSFQaV7,7WB=QbHRH85==XHEA4RW:Z]>IZL=:J97J4N?W+6?c<c[M73
8G\?8>[&d&:=@L43665cRK^]M-X7SbM(<V@;7@[FH1F)0>TC+D(^Z\&3RU+.7A?V
?Qe(NFXZc/9ZTBQRTLI->d[^c1.IfH0#I^GD3W[A2#4e<]:4JNX4O7W#_>04I7_M
5R(9.K.HI03FcCIeUV#[CD/dEU]fL0>-2L.eB<Y:gLH:fXJe4]LY/TcP/^5gB0Wa
gc<D7&-3b?KF([bLB2R?((0,M2]C5C165@80Sc]U./@/7QB@U?6;#84#RR@XD\e+
K>7ZESTSB=@S[AP0cgX0A???ZQC4MEQLDcQLWKeU+7BI[:O-MTcUM\9N\=O^2M8W
NE</BLWJ\Z^]3B4S#2d-H4RNVfbFdYBR3K7MU]INSU_5&.GIMHfGCdDX5d9Ae5.P
@D,f\3#)?WE[(_=Z.IF[V=<-6:b)U5NaaC\ZRH;R.:V:<\D66M&71Hg</?VMFfEF
ZHN5J[K6A9^+b1JGM]#CC?NJ5\D0RgPQ.dbc7]7>#OePQfH=GEOT(1DHB/?R,N_H
,Gf=DJ7UTB\67>Tc3XJ51Z4@I\.-EcSLLDNWDS)@Q#I27QeHa@12P885.Sgg9@RE
-/WNE3e/KQ[KAOW2AG?;&O8a;aSa/[4.B-/_9a2&3PD)<D<NXC]YaE(@2W>7+d:O
#M@1:a>6YT7<e5^Z=BK+2;1\:2[#,afH?AM_9AG?gA2ZDO0NO_[V2A?]VIba]UWT
EO7^dg1&bGF5#;<A\7d;4MH+0F3RA:Q;<S1MZf0bdMdU,]Y+5cM^NRS?H:OF@7LS
1\#6X#D7Y1Z7BQJ8ONZ8>gELY&&?C;bA+#WC?K8Ya=\K]-efYD2a^g\+8FG<EDL3
gXF[@WW@d@GO9<>3KL53>Yf6:QTP1X5FP#GO7_#4Yd\gN@8a8Yb5M1F:(1C)TO=X
FMT\_99<TZ,0RfWd<TUOEGQ-<5XN:^-];POV76)4]GRAAXCT:a>Pbc8GXaL]^I)N
6XFN(DIDf\PNB+]L[Tc2b5W&07^,SWg1#Ca/gg9e1d9_J9L^V2#P76BRI?P=NeK_
D:0W&XUQ&UJ]415D^.M:6<aEd28(7[dD.X>?Q3O2Vg&8#fdZ:;fIQW_A(&GXM9N-
O\>EDN,(.YC6L1Lc<;W6#fSFWbCRB<eb?][=MY26YCgY;aT+cb@Y.>M)51NQGLDM
g^c(_-TW8=eA)5=LYV2K8Y3,DO[L=E23JaRX_,?0,4^;GVNg5#;Ib7W^EBL>gV7@
)J/KYE2AIA4QAe:ZNDKSR#4X/WcaUCDBU,VB?D2C[OZ_[_(L3Y_3Ia>CGO6O2BDK
,d7e)&+-H@=TJ?P-9;L1VY1UAH/7e(-U=-_<Y=/U^]@3g.2?P,:&<AU?eaV0[SDa
Ad2?Q4OA8(#L0K9#L5\NJL)]:2GD48<#.ec;FLGBTHKaO,bT^M,(A1ggW<ED,FNG
e4+c;Z&?Q0E2WGFC1HHVT8-7g((6&c;Zf=/8LY\_#M9.<U8YYIK\+S/0:e/PGEF2
W(1+;7X44O2Oa0^eYP7e&:fB&2cFTLS_&McG]B]TEF@#E#(5?#QBbER/=Lf0,:IG
QW.Qg0/I7N5e0I+>:IX7gVN:2fGA/7K>@[GfIBF\d[<>gWC5:<XVDGa+;OQA>S5d
UFP-TDGL<0L#H2c/W>f,);>_=@eUQYY;bMEN8PU5I8+X4NK4W7E+A-W),Zg8J:@-
)T:]5O)ESgK3&)2A1IO:V6/aB-PORN]I(KQ-(5d>.Kc81L?=\c@[a-/0&9(6?[_Q
HKU].c),IdgcRUFU3dQ.+85)LBG-HF\@O=_d(d5Y;b.+=ae9Z:4PBRaPDeT57_#3
TZYF\.&dRaFXD8.b>d<V9W:31989]X9&2._]BfXI1dBBPeTK9N/SfYVQ(/?Tf=U=
4;c,SR4-eeDD&g(Y:W2;]VQ:9Sd>d?-2+J-DJW(6+(=?(+.0?BY.5RK7D+)M#XSO
La7a[?H.?U9UQ+)JREJQB;9,Gg&6b6Od/MDQY.0#gG8,D#]471f4X3T,aBP?CTAL
6UDe(/6:KH_G:ZcAE/YGa2);3dGY7IaIGA)/DALfcbC;OE@[V;3-9+@eXTF-3.#Z
[_=#[7<2GSI#&J9dc:KH[\&O&Qg.KTDQI=Q(QDLa0ZM].QV8gYKcAE@BOgc.DZ]a
VA4(FCNWZTD4OL[:?+&V:C@UHO\6Qg[HLH0Y:?KW9W3c?5<8UJe?<f\K81JfVGI<
TA_.0TcL9:9UEUc(c9YfT)OdS0096cc</S^[a#4OcZM&g#.WKIBW5R)H5IWP]#LE
N7)#9d?[F(bd-<a1;KY^PD=-G@?,6&=;&A0-&LHQ1+9#(K0U7:7g7;K0-H_IQeL6
H\F3<a-U:d<GT(_2ZS/@KM2g-[-_GM.S?:IM[VR3UI3D:_-MI<(D]K/Q+R=C2fbV
\)BADJe6;JDE_OO?SPGcC/d12&B55aB1^2W@a0I6g6#fcY)JVT/L7bOSFLY895b;
V6;4N4&HD>[-M0KUbA-UVI4R?gWeJ?1Tb]WINH5\TL:Z6N.&@9[Nf?EPO6aBe/OJ
.4Ja?]=\Df,<O/.)<0gJdKP<E-S_3W:aJRDddZ3>Y,W6QK)-^.fJCbIVG1_NEHLe
3(8)5(66O)48]FO,L]Gg-.YM,M2<gDD]b?e.L:+E&3ZegaSKJ\W029@5d+:D;3SC
54Wd.&Gb7Z?VY9bTKd14B&gWH#&R-f,WCM(6Ja\8KR/=DV]9+\;8#A7;N&Vb:RE0
cZRGX,=&POdMY8;G[-]QK:#cb/M-?BN=gM]bR1U@]AO_1UC#?S0#N+2UL0=OPFId
5PGPL>P6W#g7U,M,,^IB^^)K6X<VLVVAO(]cC^+<2PI5Rb(O/=1H-&]5GX4^H,_-
=H0HP9\4DTb?1FZ0?PJI+D/FCIV3OL(-??]Oe_f@)PAfY.1GQR_8Q)&EU;>b]\:d
;gY)8=-N5]9UKNA80@QA-:LcKVAR([6><+K6/75P=TVDe4)<IJO.a8?NFd847Q@L
Q+^<X4Nc-[PH.]0ebfGUJF?@^UYQgS)ZB2U-J+RMZe^XH&>79H8d0S2c@8VZ=.Nf
KV,^9FfQ[Bg84ASgYT[X>+]SAAf\];PDQ#VN.0=OY=^1Z-f4cB8\V8I@IWDTSP[M
51<ZAL_S7f/\XB]\-KdK;Y(U)@?Pfd0B#8IZc@(K+9<<NYbg=dR0GU:XcAb;a#.7
OISdL/g[/4Vd@8b/:,bMe=T#EADWTS5HK=HC_PXDX@2O>@5_],W0LN/C7gbf)bed
(Z)8R:N=P3J)6,G.P7(6cL=T(QOP@-d5C_9fBd2@gSUGE3a<d)_PR@NL6-LD,0,1
GOWG#,,FU-0RFOM;KaLKR3C)aLT5(T&#D87c1W?B(b>Z^J]d_;VR@:\?;R<[\5J@
--66W;F884._>&LCLX9Y?6;]XPD4aJDJ>DGW)L6BMA;NX9De_7.9?#.Q8088d+O+
]^BP/6S2M81<+RUGA^XO]AWN<L\>cG.O@X^(b_NV0[VDgC+G7>SI17_GLW;[JcfM
Z>6B#HR9#QRPgIge];;+g?T;AB>:A2d40]LD@0W<[8]HRX8D16[:D#,A\L+&<#^A
&.^6G3K],9e^CMX7V&7:f)N2M7gA85ZB9[K6d6)LGGTe,<Q&M#e&^<\,7XZUe^RU
g4A@4Ng+;gbE6N\>.D^fSG\9GRH(=Ee310Dg)D#S<:eFV-AU>aB1/.f0T?b(2c4=
_4^#O-E.8E];H5;Ef,Z^9UBYRXNWYWS5PREZ)T4VaNU49f=LT7D0[F,<TC]F,C/d
1dOUIdA;OV9M1#KL.SAH[Lg?NfZ;HCF+Z3(-7_[-=e#]?-g1cJ^9]ga^J#RX_,^0
ZLXfJXWVe:+\E7CSLRXag/W@UWCQ41D)fY8]PT&U7UH0JB/5&8<&EXZFQ,MV4/YA
#I<M+RL8IaVf:+\U+H85CM(R>VP(OS0=HA<[;Z9#)F;XF@Z6Yg^?\^R7F;&dd7gZ
>)^ODBA]fF:#b0HeMUW\f/E^J[:&W#=)VAd_2V9/19W@ADNg]2C3YLEON7[Ba]fb
g;Q,#_VZdWZ/K4DRLg:/6cfWTMe8e0A,(C?(AM01W_PLU?gJ_M?I2]&EZ)#3_D^0
-&@YRYP:Y9=Mb&<9Q7T\-^8G+L-B4Q=]#>)=5\/Vb.#H7[334E)T+QC+YJ@F,PVd
+b8gXZI-T.243+E]NIY=6UFK5CNSdK9GJJdSW[,6BaKH3J(\E1=YgILUe?IRI:<G
=UAFc[X\@^>,9b]b=O(>4JJcO&E5R_2c.:-<3:>-X66]L.;e0<7]IC16[/=OL&Xd
A]LK(IR]=(B7>=2+(A/7\BI^GgS\P0c2VHL3@F@O&6O],#HJZ&#HOKOdPdbVH<]-
>]&Je2UXAD)1GGIYP_-PdVBM;GZ42M3HRMc@K@]Gc\?&.OKF8>La>I-,?U;/:H3)
U?2?gAeB2]0XQFZbS/UQa3PdN\>\Y0ZR=3TU75G<XO4LXMG8V5+8E,>6FQ;AIa=&
E.,/1D.RPda&\J7HDd)2()6;,a^5Z;_B>QQ]gd1baY],S:,)QG_7QbU)(0=@,Id#
YL&?.Qe:QM2O17M,V[DacBaT&PV;/Y1=@ELCgO+ce+&HWR:#2S:)C@.#S7R2U\fR
UKVETO28d+gZRgA\C7LI?UK9BF&AJ)^DD^KB42^1BAf;5^7fSN]aI1c:gG#W<84C
U\JQ0+@?C+PA.9R2:/P,Ic-ED7?Yc(W&b;T9:4I=I^\T?8_&7)2OAS9c3eF1@LT[
0>QGg,C)8f4:;>]a/PNVM6[2\V5R<K@D^g.QMb)>:R=CAR:df#9O]B?Z7KEb#C:@
>LZYDIPQ/G+0E[^IQT&P/WOJdcaL2bE5AZ;@_LA#VXffgR^]bTOQ6J7#^0]\9[F,
(c^#-;g5HR8Y.B:I\JdC>g\>7a#/@?^c:W9)0;3Q7[F(3L.31K>T6_QbAPT-K>>E
[@F)8WP[5I>GS+c)6LODO;HYF.cX:=M\Kc<;FZD5MWgfD<DK.GdC_E,\+4E5U7N9
d&g>XEg[e_+YdMMJQ#aY7,]CTHAb2YV>RKG2RP6@&L=X+99&U>9_0Bc=+XO?Ig&J
g)DgT7b-8ZGWaTf6QKA&-^c1J/L0,)La11cIRaKCKc(Y.A6UW]dH5agCZ;5<@OWA
ZYDaBd9TF#=L(9S+b,g:(]&E7RfLA4:OTf+RL,a,&BIL@b]O9[?7>b75-MZdY<.1
KFfM35ZYdV)cBgc-5=4:8;TK1Oe#06X>NWO?eJDU\#)DXPGa56+4A2V0=D84Q=;>
45HVg+^XM,EBa;Rd<TW9O&g(YCI&ZTGNPIB:_3(g[QIE?]g)4^bC@]dW:U1Dg=S(
:J9f]#-:JW#O4E2#G^4M@_^;&H>+K\fN8I/B/08BI7aQI\ga]6?-=]Y+SSGE.-@C
Qc^TF?\,^HZaRB:@80E1IQg^Y.)f^_HI9.?Gda6W-eME9(T;Uf1VLD#1[:<a<T)g
>_&>eD-4#\&3E1SLJc=Y/]Fg/3/^EL#QKKbPbQOILO2gB?RLe2>,_C&R5+6RB?)+
J##/]OFgBUUfg\gT\^,&5OXeE<)gY0)>,G@0\G_AYYB/f:H[a,JF=NIOCgI6VfT7
G:3;\g.@+eU:[O=^=U7[[:H0LEM2E.+b5CD&/.[HQ6&TMY?MaCD<;LRC;I2A5DTX
;#XH3X::K/2RM\4DHUVD,defNZI3GGQ?aOA^T2JGD^@0.O-[ce)M1^6]?M^A?7IL
E4M+:]2J5)]d1U&UF8E?L>[GVU:UP0fPUF-FdP:VWQ[&&4g/P:MNAae7E:9,^31M
[<Te92,\XBH#+g]DMag92R0MGYU)aA#H1gd]DAa1OgKg4)<EUdPZ6W73Sc<Sdg)#
Mb>V0b0W>2=e;_>[,Qba38N,Q=4_FS8/V6M?&1a:0IeK_=/Tg)MUW4^[ZX/J4[fK
M?EB2]4cBeW7EZb2]DR;X(<gHOa9(65I]a1[,9?WFR,1GLXBDb2ed_=:c>Ue@J9/
;Y\50=>T5ELD&KDPLWZg1=C1.SW<2^(]SfR/\K3R,36gNC>N@a3\B)_d1I,I5M0#
4-ZU+4=M00\fL?E?,Eg?/I>=S/)+D,eCI2)I#Nd5#a+fB/O:473W-5aOLbY8/@@D
AVTD2(JWSU.ScK(6d>Z?eRb[F:F?8+23,0d@)#a2K^S6e,e93\2;_#XQFe@52\AS
-E90EEMZ=8eI8a.cYNUNS6Wf;^Z/fE[ZIaRc]C&_bF.LFdbe@67aY1O<&XO?27d.
G)\L7FPHfEVRGbF/9IHMf#J92gDNKZYBJ2gC]OAR=d;;0e6.:2JLPIJTf^Nb+:E+
+#F)8=;?32e[R>G(7P[\P1@L<c>YP27U+;77@?W-=;=c(S&Z34ME=W@V+;7)A^0G
(KQ?bLU=MCG\7b#(a.EQ-46a/33Zd(JY\TV]d]N_^S<,aI.E+8^U46Q:M1K+Q)cG
XX+<O\J60:6<J90<F?^4M7ZH(^9(RBeZ.UK<R[]CV8ZK@74\R&40-XGP]cdG<_:9
2HH+H,WIP>Y1Re?#&+^DSTS#P5\CgXV6bCdWEOBAI45;-Ya,fPQW2BbRbae138I,
[a?M48#eaBWgdPY8N63#;&N,D^L<Z,,VcX/00a9@M)G2.2T7(>@RS:Y)7aLLa2ED
H<OI;e)\]f\6/7ZD7-TeNKS,FSU#Q])c-1OPJP^S?V^UJF,<^VH>Mdge,C:eM(0/
]4c6.Z4:74F^bS&YV3B7@fITa)52.MK#;)KEa>A(+_dS1X4IT<8B_Pg/U0^fb+<e
9=c#EHTASA-cIEX62&#&XD8LGe_>Bc7?VO>_Z#E[L]cEI:_fK20HAF?T:+TB0DIe
KENSb.^DN?/.:PE/_aV@AL2W=GMP5d-A0#e\<WAfM8e]J6)#P#0.GQb->]>MVFMa
R/DNIJcf.cHd\)2MKb0S?:fQ8Ge-^DG^][(T]eJG1,R-Q[4GdDddKP(IcFXFRYTK
RDa[2L&Q,aNW>YOfJXc[DVH+1_S@CgWB2.XX];1Z;.7Q(1=?80FSEU/?R7+Xa\:/
@&?OPMV]9O;X&0W@J@Ab3U6QMS_+6MC=V0aA=QDg9<D;ZV7-;XO=OWBZMB6.\RIG
R^835fGG>][>=7;X5:2RSV-dC1f@Y_XLB_0MFTB8U\;60=DCFQ+>Z3GK^2N?R)RO
g+eP\94Q,C-PG.MT6U^P&U+/10<bH^/&,#UD.#R99_>H#Ma(ZZ3F/Kge(5W8[9eN
XVg_VL1-QAg53:ZRcUPK=H54>\UU@cGCH)fS/?[F)=B+M[CB^,_H&G&Lg;/MECAf
I8^9+\B]35>Z4EXL64&+GA<(JF#A;MMOTHeGT)&81IGda<<4Bc;YHT1=2+46YOL7
Y;P.[62SPJKC<CD3?&c.Y-48[_5gGd=ffH2/MgPXadQ\PXAJET9P](#f^-&YFUY2
T)+^dF5TLXgC\FWIA.daA(L]g8YM_3GcN+G=,3Pa>^E=+,.W9RLd_14Z+dS_:CV:
4LU,D]LD3[CgFI-H6C(XZ9-T:6Q&).^JDH=\LNYeM5gb:DYD97Q.?a_af[KEE=L2
,F;Xc#?;+\E@LcXB#9TG405aEPe3Ha@0XZbS<@=F7V;7IM6@E@O&3LLBOVWNXTbI
A:F^;0^@.-/,V5DE80.OZJS6,@Bdg81DJQcO]Jb3&10?<7Gd]Z6;UVV#Gef#Se.?
;CMe&:_^5_,MX)dUBV588[;S1=TL33UafVI60)_P3FCa(T+6[gBZA^WM(1B45(ZM
ZOP?ge8T<g0A7]H[#AbfKWdF)Kg##J+Ua::)PG8IW:-MIQ-KE4K#NXMMM9UJ8fHW
AAD@J[HAHQ3(T9VC509,[E=/>JFUe6]Of^&18Z8.B7bA8+Jg?QZ6R&D6@4U@]&f[
^156GT9Vc-.>c:7EYKBTC]E&[Y.J<EaI=^cd?QDgJSbJCBS:@[-)E\B4ZB7DNfTJ
aA-JG9a&CO97Vcg9W>2P;TEZ)f<8#=^[,f90:5=d:M;ZJBacf:)H#<\=)+W-O\7F
)Ug,B4WW=b5(6T+B7>a^D@5W>-M>^,&18.6bE135=aF@9b12[Q&41gc_,D4X/9g6
1J[X0F,L;T^P(D+5\Cb0R/^TK#Q[aVE5K^O-5#Y.b:KHdDVRU4&eGS_Q/49@[cW]
YU\@Y+HY8#efeVa+^L>Rce52LLRLV_J_CX+X?3PQ?1P3&G\)(TEgUM2eZ4e;[Z+Y
75e@AHgI_C\/UZbN&E7/(@gTa#O_E,9>KCJ5I24bc[>(RgQ>f>VWOMTa=cQLE?Ra
7=>WN&\:)bdTdNJBg?Y34Y@7ODJ.\ZXUg+Q#1]NWTESg,_UQF;9>,3BI(b@d:?>M
b69ZZ9=(X;bYSNEXTXc+;7X_S2E2464U:TMJ?Q,^cgARELZ=)S0Y6F(&Be\VYOVA
+4YP<_--O6M9ReJYV1bBQf1gOe(<=@;&^Y1dIU[YX,JN<d#0KX47;,d0)&>Q;3?@
F.K@=BPX+71041Dd_5BfAB0Dd5Wc)^KSIM,72aR?ZgW,.(HX=TBegB7)RQ6W#CA5
PUXU)I0WZO;TZM2f(#@7OZ?F2^:H8/R+[gE84b=#gJLI6f(0f_327[:>7\SN<R>=
BH2#Tgc[7?:>7EL6VV0I.1>.:fZ@5INZdXL2O4KDc\TDG(9>X.&]de]HA(=W&IN?
X?@ge1&7T5V+P0+8@>N]/83R>BTVY(B_^BA7LCB-<Nb9-B(Q22c-N7-E8ACJ?ce@
RM(RT=2S?P.0>-OIFOEG:1BURfX=XZ6PaC]M^3H^Z;E\PU325&7P+0YJ(5cJE2A&
RaZFB+K6gC=afJ_,&WHE/4SgMT4NIBF(gZ20cJC6+5(1)25.;<A&0].[d3]MU[RX
eL[M3#M<LFTaX0QIK)]0cSK3C5QT,4YAA7E/\I5YXG:XRF,GRXD&=V&/TWLOQ5V:
82\LDE?Eg<(&XA[SJY48N<\:]F=\4J5B_WPRgS6B\S.-<QS,@N,d,Ba<QZH]3HG8
8&Q:+IMM2cXfe_CU3L.U#bUZXMT[/_83YW47gM\(3]KL-FP7+9V2\?K&09Ae>ETC
)aH<=-&-PL<ebPK>;@U<FDa1WT7eFNG1Q&UV3BVa8+&J3PW<b:)5>f?4aSV)ge8_
5CLA<IcJM;UD0#-NdO/J.cNg-E:+I9bEZ4R9O64Q=-ZV//K)FV+V[##Q.U?]eZ\=
Y78K#HFSV_?._\,EMXCGgf.PN04J.<4DY\+VEbFdZ)dcCg.&bg1OYb^FT_/cZ5AV
+a9&-OTM:K2C;P0>QbZN1e4:ZKC5FWZ#IWKMAE49=)MGFNBO_^aK[DO[Q:MB01,?
SZP^&WXN8&V<E;6Q;FafTN8:K8R?NcB=aT]D&01-3FW^LQ1/?YXO]E_3ON6L7[fD
.FD;8<eE5[J?IMIF.:7H5S&T:<.RJKS,0_Y1f<HQe_#7\MJI520b3P8J^0]H=(2]
-YP268_98FJ6-UXME6:F=>41W>F(cU)3HDNJE/,CaPI1>,;R,]CWC2N<]@O-XV]a
()b<^ILO,B39ZAZ_Y.P)CEKd<bRL.,[#-6(&++4\TaYQHPbP3c&@,YMR_(:RHHC=
10;O,e.NbTN2eQ\Qba4cfebGEcMF/VcBBR3SX\0Ya=;7N_#QVeZ1N/#]d6-Z>1U0
2QNS2B6I#7<C)2RSHC]51+Y=d[G\.JEfaGFbC2NL)E)cD>[FZ_bS:f16<;YBa?cf
Y+<RHXAOAd+5)Rf@S./TEg9C0]UIP\NB[>^8_c)Pd7/=VbG7gB:5[XJ#]V/OF&9G
.=B6GgBJg30R5<M^E:VKO[U(&H>Z<GHRS#1<\OAGcc]RaY>b1_d#U7SLE7KHWHR:
XT/AKI\O>?(HINT?SIO6YQG]E?Q,8)0LF2RYeNQRHS30c\aSA^6_8>]P,;?](gIA
f(bH5<MfFYDAa8.8c]aZI_:>&G_E..gH/@f#)Y5X;4G>H^g0_?NA+T46gI+N>,LS
.;-?F#+K&JB)_.dE]B^3#;#NbLL&5@^DFb@7URNL#.]RO=C3RB#e\IQZMTdU,KBe
\VW&)\XD>aX<GfD6FgYC>8JC-<,9_A;Cg#01)2[e]WdJFGI>D9@-TVe,M+.P/;4E
L&07@FL3QY]<Z.5W^RbD7QHL9g)T1^CeL,dHJ5g3,GKTPRXcT3E(@\Me&V4+[:U#
F0EF0SX1OF^MDc/:b:A]c3=QRROUQ@<A^+3Ee?/1ZPeV>QaQ29ScE[W\VM8@_T/^
U7+KUCX&2PRKSF.?CQ[PD[G2_IJS-JR_;^6Z9TY1HCd5H:&_d.4DYKd1_4JBNS:2
?+CQZ3Bce;NUY9W]2]LVG09Cf9;QX1&3SfVW.C864OS(QUb+XfP)&:L:R@@T#;ON
J9AXO<?APc3.\Sf/3O1dYI6c7C;)bdMfWB]bK1BDSc#]>ETZ(A)]7LT6F4;R[ND@
4DE-#-Z4Wcf6@aJDef-&ETG8VXEcH<YI.]M<]/)MVF#TTP9_CZ=-EE[(<c?b^e5e
IQfEGH-VcMILY2Z=&#:\/9L28.,BQCJ[7g:f16bC3N\;e(L56cbLSS&b3d&>>-cX
Ie7WcSgTe5HbVD+06f\K[C09RH<K:(EB/(e4<VIW>JD@;;Y+MY8C153eRA8Wc:8Y
;@R5@L2a73@@gGf^eEB+d?0ZE[^P(_G:MASb<&F]V1OTT4S9#UI_OfJ\AC02QQ4O
/KD8\IH[Wdc[,08_Y3P]46R\_D8H9KIU#e3272ZN\ACe/@a9)gY5c^;UWMS8\6+Z
CU,0Pfb(.;3Y&_gc.ZacC9O31P8D/>_?YAQSXD)JfZg45PFXb9=TO.DUC+=5.:6]
YSPD;_IJd^2,9>/XY.WM(9a:SN)eG.U21&.LDD#?+Z?]>FI#,JBH#Y,MM#.?8)0L
cR?cCNK0X[&B,Uc67JIfcfRN1ce<S1_N2@fGg/]2SAa6f6ND:/:EfDQ/L978(>K#
N=VU,IXF#W/A,b\QeOR?QQ?Eb:@_GU(@b\5GQ3NEfP#KH9RZ.CRUGadY)ILgFG>8
c.YY3B]+6R6B5=B=P4357Y4cR?,6:Z2g-XF;&GF[@1/?3HSLOfV/[AOB6]I9PCON
JXU]Fc14+M2.d+_BY/O_ScOY5;f^IIAf/GZP=eP+OOgL-D#Y]0Ma_/661G_NU4D\
^.==-V?[0\&8-SS8[b]-,a7\QLX^)A?aXd<B1GB,[H]XLJF-:a;^bN^.L;OdT:6J
(]9W5#2UFbT;X79)SM,5#?ZbH-.ac/9VH7PVV:e>VCM>4f:0FY1LK764EQ,>MH(#
C.CZFQ&C5)0P=dd[1.CDJ1[4MEf??6QWf1V(.ZEL67V82^D#cBZTT3MT@aa.IF2a
FXKRWTcbH,-K]T\=)26QRXUFXX?8:cSQXec6WYKY@L2I.B.=^\bL(eSZU\;3:KJT
7BKD;H>]3XWQc;I#>K:=6RUWX/EJ/G-dH[#cP&(RV9SQHSZ>U)G+\0aYcd9>dTL?
>?4@\EB4OE1L\^J0TL=&FXH^<PMW+J40GV3dM5DA?0DSO+c1:/-1f@A:\FK2.a,f
I/TF6RNAW9<;3][Hc?WS4eQC;@U]>GLAU:G@+K^XIXVXF5A3DP_BU=c1ZHHF-fPD
QL6d,UV,&6L73VX3b4@V2c,9VNB8)cGP)_JVB00,+/1S[a]YHfbH@LV09_(b1Cec
#\(^[:/I^Ff)g59+N?Z121-3K>.47CE(=ZJ_38bNNP?<<?BgZL\ZG2F0UIT6<D:N
]_dD]HGPLKVR.1KAa&>@X4d\c&&#=I[84YAH3GOE:2BT#?:2-Q5G7I>;IJ>bI(]A
Q<X&4@3^E.J_V81EdDBD]_aX/Yb9gK-JG]@EMEK-g<OPI=5Ve;UN0DW(^UN2736-
T-2I.<,JW>P4U[[eUa#8LeT@<_^Hc9SV;F?a_1SL1aJAW8__O.2;/HgR\(eU7[CM
@RK;A2bbL+?;VHbT/]>R5,1SXH9W-a>.bLC3fX4QL4U\E]AS+D8,Q3g:BPaeOFFa
B;QDH/Mf:CSG1[:d<B0a3+a#V^cW;F3G&7f6XLGPE)ZG-b0+.9\8I7a4P/.<]VeZ
?^W&=Q@;=<NO<.0NK0JfF8K-RWAedA;0E8Wggfb&?=WeegEPB?K(_DHc<K8J3&N6
.e3>CQ;JcEBN+ed\P<^A,>XdCgYOHW@c7J;YP6FP/I^IP1eKTU[gI)dR__;C#L#U
A9HF^S]??Ya<?L0LG0_8PZ_:1C0<_/e8b)KFCL/VCOb-WYIYPIYX&C-J?>WG-<&a
g+e5>HJJc2@_+P;;?8Qg5G0@E-L/Q4-3Q2\Ze0&S13:I>fJ71K.FJPC>=f?&c]/<
<&_1/Ue<M8PN\IV_-VA4Da/eMN@GE4_[-T&UH5KV7PeN)eF<R6L/&8]-eL[>QIR3
X1<1Uc[Y,3c;b.HSFLf7JH9GdO]aH<_:HgGWaDT4#[J+b-\=M9+<87dV7UL;6PE)
4XJ?+E&4O[Df[f(42J,,Z-=,aE2/aOGRI\;0fE1NLE5;W?B1&+A&\N-_U9U7#\B=
K55Jg3[bN1U/6I@L9IS?\A4RE)Sa,OLQE59E_:#g_GP2Yd0J1DEVSS+BR5U.VH^d
=e\)/<\OC8S7?&f9)53<1@B+KC+==CG060(>@0[\5-+AR(NZ21b3</HX@-]3-]?[
c[1@6F\&VYgRJUM(e;GI2O&aIM3Zg7&33P,=T5,+NZ]T]E<,PNU9^A+W2HgYW7ZS
)Xg@N/@4Y73LD\NKD6;/)SD<^@R&?[?5G/#D(A+(a.1O-e9JMH]+;)1+CSYJNQJg
.#U?.J(EUe1@V9()g6&\/CebFDKTXZ;I]ZN(F>2CU0<FV+<a4;MT[TTLF_C<&.,?
\I;]SGF1:M:))1:124b#1.R45?Q/8>;2\9\2)3ZL?9;-=U,aYS),4_VH+C-R;=OO
P+WFC),T1SB8T3_,],=?5_Cb-aeOfa_cc\&74.56gFeM\E8QaG^eNA6;)Ug7T=()
4+-E7L1We]5ECN,8&#]Vc(/H^HDCbTU;AU>G&D;T1(VK_+8FD[Z=e[E6(BDNBV2>
fZ>(EU>^DY)Z9OP]=?&K9CK?g827D2SLM6\dE36_FN[QQ>1ZP&G&D&-:f3(XT>KK
UVc@^9d/RFZbL[25A58V]?-YX]&eE^.]#4XeA49WG--<<2VPGeSM]5</7H0R@gSb
2+SEIe&eCD>]QKDN(Zb75;S9G_gZ_b8MD1<S)REN-5Ib;EDN<^H/Vg\BGdZMV^,8
AJgcQ0f1DZ49+&Kc0cbV2--X.S_?#A+f><&U<@XWbL0\KYfV^2,>Q/1;PK?55F]D
K2XA<cN77WC39fZE@;>B0.EO?UC[MG((dTII#D]<95cT/SV?T\6QNgKYLK#ZA;1f
JK<B604g)DbUY\XZ4N-)>dN;Q\eFQ)]MH_]ZD3Bb6-e\B/Y2Xb(N:8e;WW.dQ+/g
VF,Q:PS1bgI6U5/N<:a+X+&]Jde(+)E]76ad+L\[CALF.@RIT5(?V/Ya3cO]aX(E
c&Q]&,S=^J_,Z.LdaSJDEdeQ/>BEL.OaV7Lg5)7@R_P9&\MOe:<dGZ:G0N7GF,)=
#F+fcTQPAaYK/P4E_aFK&;DJ93fY;(2b>BQ?Y,S>4/+QLNQ)&cE(D-]U9ZJ&F2?O
:e8@KT2b2b]AK&CM=6@IddcD_AASS=f@;_C@6N>eI-=,E7;g]LX4f,QGWX-#[4##
HN4?QBDeX:E0Md0\V.X(.,L9KU60/YUL,?73VSQ#H[f^[[35H=K79-1HN4KMV5O@
49S-(6ag8HCE&KObQP.>0aFK#_CCR94C_>;N<#NFVXJ=fTA\?_=QE++3PJXEMYU+
f-BJQ9<^D]2ZH;0QB+U[[LSKS,#@FZC&76T.G5(48E/(S@)f]6B)HWUA>BZ>##BO
deCgLa3RBWA4RbL;GDaI#-g5_M42^YcYPPK,,[(XT7B0Qa<6aNRTX13^ACY3.UM,
6RS]dAW,4?<5C6<D=D]JU^T.DQ>L7H_\(0@;,_Ub7)6;>[(A:V>2>HP?7HT&[ZP]
R?JU(Q/6\?Q(Eb0N@L1Jbd28C;]]WL0VJZeF?I29S,EZbZ(_;N;Y,KJaBVeL<4d9
+L/.2<]H-/L/BU08YMMZ<dO:_6OeJ=[UFYd#BDf>N\=dVbaS;f)7LKZTRGZGf:ED
5P&B)OSB0,b6f-gCa_bM5bXS&ZE+,EDNB7U1+S)<fSRE=<-\dWCDKKRPI#.&XfCN
1AH,Z8ITZO,NUf@9E8P\/5FOGCa[P4a^S)Wc^\P@G>PgV/1H]I4dCUVZDK4W_?LF
OMK^14U#<=OU_HKZ>],,F^>K2(?PBFMafY&23+bF4>Z8=R[B2DaR0IL/1@G^4ReJ
\C2(I;+?LD4ELJWX-A@b0OA5-cA==>5JObVO(P48H(a<FD@f@T-Y,Y9D)QAG1+;:
IJNP.3KAP>dCA,1(V+R:a:TKMa#E9@d+,eNE7G.DbHKYU6E4)9TQH9gFLNQeQ1T.
Ie+Z(]QVAB.6;1Q5)/N-,&I]9;TF:9@8f7?YF_L6U?,ddaB4BcSL;b8GW=#3e>7C
fY<2dAR.=cFDI9(gD;?[DNWVD\EIN3YgJQf><_aeKbRI>E>P2_H=7cS9ePge]eHV
P@E<X/ddD77XS00(K&W3a?BSQ>>K;g,]:Z\+K2Ea9LH3RL#,<gTIO/LX8FV,UAbS
D3G];C^dcJI+TdY70gW./OWFY02CSgFfMb:MBAcN]4PT#G)=FV6<DK-1DUUDd@@7
D[7M,N_bf&PAbBFf9_Kb+gaUHRI=P?:]1J6BUKa[UC263a@&4@Wb?J-YE120\^[_
=b>RN_Qb87I?&&U6W,NYbX@?[-2QBO,KB5SReTR4<>[8Z<EDg@11>Og-CC7(R\I2
BF&R178dFY[?=X[,+D3<gCVK<^5)8e3N_1,,6;@?T][4C1G4:<-b)<AfF]eV0W/=
E32R[f@G,P\?FF+1d^/_Y7gCP<MWFL1/Qf=O5>.RL^T^.)T/<OdgNc7g)T#f5[=f
(H^A;<?A(LI1(E2dV_8)e0LYTD/D)FTG/SKUdcC=:FJFMR1,T^FDJH-P9NS(G^>\
d___&23ee=5O2YEd0f/,L&UBOO_#19[H]_:d1^\]&@d?b9f=5A@D,WK0?;EG6d0F
3DA[_IS_,Nd3^6d\@:K<4R-FF->(TM0cNI/Ma.gK4T>[gb)PU;:[6N,4d(Q\[9]@
B7QA@5Z+XD\>A8IU5CHG0_L&LLVZ#7MOBA)U;1Z)@\.(P;J8VDO\M0b5<M8?8B):
V0_<+R_7#c#EbPMW\OH4-dZETXI&GM1e2U.E<W,R\F<V8QTTc]J+F>[77>JQK];[
FcEMV_M^-8Z(^(;@DK5WNNZ2UYI6(,QP?A]:8K?Q9e[@EIE#=8&D3[bQB&Vc8GZf
9V3760g^a+g<PM/23[:<.6R7^IN:TJ\M&+PF63MEDfRg=7+]6dG^#?4RfP]V)@e8
0cL,Hc#6WP(ZbF.08gQgIAQ@a-82CD4AH4VDVL<X1&F>@9OG#OE^<<IG)Y+;MaZC
GG]HM)Y\gb&;X5WggC7X0Nf-<MG^MUH1f51;<6IX(dI^1:+V)X6a?3P5JfR/AE_4
(+XAScY0;FMbB;:gWT/^[,3S;6IT=a3;#eSU+O7(.OL];N51SV<1c8];LAWfRDa]
aI+I^5SCA&eH^MLR9,1aM2\P/,2Y>9:GgNHTb(U+_00U=IbX&.bB(^268ST)7[de
^D^aU:L5\XA#4X@4[8)5SSJO^,[A;7Jd.RH,9WaH\F3Iaf@8[.\7T644<RXJUN44
2Q@X?<AD[34<#cG89M0H4Xf:PJ&WAM,JWK5;e4E+]WQ6)?U5E8ACKT6E7EW?6+Z<
LQYUV&T\LSMN@]Ne]=BKDf1O==Kac5SSXe9=#ZeMD7][,?fM)<TG^Z/ac7)C(R8?
MUV<:)eE#:\-&2?2]S2E90+cU:6g[KHFDYQD6G06^)7Z\;PMS/[dR8521VS1ES,6
^H229H+K_EH&(U:T>[@Sg@F)c6\Y^[IET@0)URMGLYb7U-WLQPL5e<d<PB]<X-KD
RZYFc)9&3[LQ-<aJGA].F\3f3G//04>aaG_A&(.bPLL:TAF>\aIbb+d+gUZf&RGF
B/O2LCGb_MYJ\BK-,JKWAEfY;<(D+:3_9CbQ8TfbYBO&gAX-WJ:I63gcP^7W8c9)
Zc.A^7TMM0T/K(B:Q_1/54Ig/gaIHe@[O29Z9Xf,4>\^W)];0\H]ecR&cg2FS/Oc
&Z<S7UNRZ1c.K7(PZWZ[>#3A#F[M>KY3OW;-[[9@a2;U7QRI>8^I:DR:C^50_86.
QC7/=HVB9#WGE6<Y\e;&1@e<7)?VN0WL-TB#5<(01-YC=Ef(+ESBR,b1PEE(C,Ce
1<b09I5dEZ^8.O]<GSM0eDP^UVS3]^CIWW<06WJbR(B3bbbd6=H^6c:gU9,1#M:V
6a)4NA2g5(G5HP(Z=I?S=JJ]d7^PNXNaAb5N=fC1.MY=<VIIO<H=gLUS?AYY=_fI
,G,^;H(./d5_e8+f=W8cJH3O\,1,G/81E?\MJ+]O;33aG[[=-gLfM_0VLWNOY1+L
-/XO.G5FPE35IITgYVP\caAI-EVA7>_:0]:)^2S.A(=SA1M3gG:SNbabEX;F9\P7
]@(Y\UESW+A&#[[3b<eG,_SOgRYY1/f9@6T0HWV>fKRRTF5<E;;SSc0)#dXc.^7P
I;6;A8AGd2d[+C=8J#5_>?VSa8Tc.95_==>d6?EEG02gR,PRb#2f9#,G9LGX?C@_
1B):;VMBLFa:F-(@>U>IK7QZ0EZg#)S:dS+7P5T-(C?3dGg?:BWB/ZbbA6)OM^FW
)LdJ/-4Z+K3-0T:;37>0)=^2U2?@[WKS@c<TAS1Q.(Y&?Fdb44^K@0CaHKYL7UdI
V9&QMaC5F2T>/2JDcWSPL_-&6NN.gI(,JZ:H#)KBU@NJ5#Kf:QX\R.Gb@Dd.F)23
LaNE?\-#<:5g^Z-\58V#+gAK2D5)^T)GDAH+5g9M+RHbF_:EcA<5aa3R-.?edA@U
A3a50WE1GPO#dJ(\4Zd7,/;:J1.HZ,_^/[7:.@<bc#7)8+V6(fLa5a[cP&Z8#A6F
>[@J9ggHLXgb.f3YJ#bJ1=G/&VGEI=.0>X.U+egWMA/UR[MBcZ([Y2@(H3+ZT,1O
88+3@M9]=J5-f^aI<QcNC]X+SDZZG@]MZ)H\+Ga)QBV?RZ,LFK/bG692cW;K>H_]
DD7cBT.c+(37D&HJZ^_Z2<BbbUK=E:YD6,;-W[+N;[H5JED88Z<N6RaBJ3PA[cgC
4<N,.2<2R]B^aR^&X)a_9^ee;E3/<;1=(1#3[1\KZIdf&2D&Leb;]8^Ba-@QN2P5
.ETe-]+^Y<Y+fG1_O8=^WV6c5;&RH@YL7fP7C_[^H[&WHK-V0bdKBF84RWRbDdMg
N>E9<MPa=MAb^X:[O0(GcIV0b#GHTY,Z_eS.E?QH1YR_<Oc??PF#53F+H).#8L/#
)J3dWG(2<R8F3XCd+/YQT5Y2>45d18<=0S6DF>NMfRRT/6#YYG/^E9A>GF>J4#.=
5DYI<JUgb=fWf;KN2J[0e[YXSdcf]ZfQ7E?^+QKK^RZ1f>f_E8(C1I\S&=@R0b9L
0GPVQ,b0HJY-A]N(^O,A[F(,VG#;F=90=(KUJOKMGN(&^=gFD+QS/D7+?\,@E,Z?
;_X<I&EF7Z)@GE70#Y2?N\S(#&(YJXXKOP6:8<UI(:e77<gZa+:BI^.X3e#6+7b>
+Pd4AZQ?[eO5YRW<3f^(JJ1cfH^=Y;cPKUFJJ=/+_F<S>c)&TS)?Q6<P.A7ZE=P)
aF5dgb.AC#G?=eG#8<f#1HXVL4<C^=8f3g960_7B5NPHfCMR8:.#@#/UF6P\=M\D
GL1U09QUTfHFUX1;D9E&TL_E64DCJGXUNY0;S\KI&g&A7U[@GTRDb#Q=ecf8D_>A
]0KQIfS/V8;/49VKY@U,_]>RXaC0,g5/0#06N6)@]7J@->Nf.SDN@gA>4L[ZPPg5
+8[^=e5:aX:@O/U)T:X?E4.V@A)fC5EU.O6UGg[+GYKB:V1eXXA>W6efVC;<[@de
U7XHPAA@3M.+:;;dE?;^MU/AdNYWOCU:D0O5BE0RS3=12QGeJL=@9EFORa3:bcb9
:=GXF;?,Z+=eRG..=.ACNY2VG:>+K#.87IE;7B8RRcgJ,B;g^,GT;&:@3G(^VXVE
Mf>,f^)2dKbAQM[1Z+;FQDg&dC\#1M5J@KC4fM4ZK[?E0=GF8[J5g9#c^L\KY^Kc
,H4c?3#\0+;ALP50577>Cda&#Of^+Q6L+>I+5<IadNNC,7DE(@=,2+9\gcN4=cA4
??fg_I5POc5d7+eH_@Fd-<5[KVS>^caZC9&^MKFL1\T<RH^K2@N)D=B>Q]_R\,2B
D9CEUIg:UdHF[<#ZJK6eLU_Bc/NB^a(&+g.]5NcRWK=cc[=ZOBIKLHAcXb54+J&8
fYXPTd2R@2A321>#fO(&U?QY(,ZLY5XDVUB7\R]4\03;&;PJ0g9fN8#8dEgV0:E4
;W@^FKIXNdRY<875?KAUJ53AgR(;FOec[_T8/R0;+Ed\5163U<\R]M&=#-57EU&g
LA>D_16&K2^^^B#,EK77e>GbPLWN\,dQ@>(gf8ZD4.g=BS4_G4Vab_X;b-3(@)GO
J6PYC)3>?dH6I\6_[3/4+(QL:a#(I^3N2EC7@>?K/^(^f0@\FFV?cD?DJ#1V#(9L
S\RPQ#OSScbYK5-=?AE0KCQL5$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_CONFIGURATION_SV
