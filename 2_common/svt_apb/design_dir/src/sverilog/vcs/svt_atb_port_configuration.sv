
`ifndef GUARD_SVT_ATB_PORT_CONFIGURATION_SV
`define GUARD_SVT_ATB_PORT_CONFIGURATION_SV

//`include "svt_atb_defines.svi"
typedef class svt_atb_system_configuration;

`protected
Y<bC931+#8A4?(fDEC;Q0#PaMO\QSEZ/X?78.EaHWMHB[?@VGe]3()>:MBYLR&P4
1;G8d-Y^4T)IKQG>&6[cR4Z./>_g)De<5XP:a1IA556/7/7g3Ne0L.N4.NC+SAD@
8eU^dP#7Q2S]3T:ASNY<IV]&=PRHKCM6@bJfJDVfXFgCZB?/50QG/X3AN,UcS]1?
JRA0DB//[9T>W<SVDX;1?,e;dCBSE+3_9eR\T:P@>;H=F>Q_/BL_M9>G\a+_E66C
H-[/fB4S4OUB#:0S)?RcS]6A7Q]Q6RV<^.T2Ta?/U8+=gN1>8gEc.\Ed&KGB7]<d
Z@^\TR0)<b@U30GW8>(HK)M(Nc0bbH/EU(M?c6MQR,9LK/=^gBN.125O[>Od4;RZ
O^JCc:B]Vf:M+gT,4D/>X\+a1^MEIPZQW^F_Jd2QE#ID&#-D?d@>CP?f9RB3AU1;
be,X4/f+&O+3e4@_@PZd(Me?TIEd8P5^f6,)ME\5;?^QC/Bd>F]S?VdP:1Pg</N\
FN3BMN8K[9J7H\ZU_.@OGM&X(+;>Nf\KP\J4)OL#<+F:&5YdFXH1e5\Z+0239e((
OX;3(;e5AX]<F)6L=Yg-bNPN;W_2[-;Ca2/86V=;IDUc7<cC1:PFCegZd>137T-/
DTD-&g<Q.I]AMT\_JIG^I7E22Za#J=6F9g&VJ0g4bBT2P=3M^8JSeN=@A_eT2F+U
1&^46Eef=-H/RM/[@3B#I4be0TS6.Tc&(RK2\(3U?Rc3BY#:WELT8DX2OGJZO2[D
::fBGSJM=]<BO,>dAOT;,a6,8_N7A-6=MZaIAJVSRI&Q4dVeQE#@^R^IZ\=_>#A2
>>>W_OG(IaI<VX]Q3X0.18SY)1@#?F</W#:@fcMN&A28ea,)5+g7L^W5=FAUCSJ5
5L1N:Of:)+B<,$
`endprotected



/**
    Port configuration class contains configuration information which is
    applicable to individual ATB master or slave components in the system component.
    Some of the important information provided by port configuration class is:
    - Active/Passive mode of the master/slave component 
    - Enable/disable protocol checks 
    - Enable/disable port level coverage 
    - Interface type (ATB1_0/ATB1_1)
    - Port configuration contains the virtual interface for the port
    .
  */
class svt_atb_port_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual ATB interface */
`ifndef __SVDOC__
  typedef virtual svt_atb_master_if ATB_MASTER_IF;
  typedef virtual svt_atb_slave_if ATB_SLAVE_IF;
`endif // __SVDOC__
  
  /**
    @grouphdr atb_generic_config Generic configuration parameters
    This group contains generic attributes which are used across all protocols
    */

  /**
    @grouphdr atb_config ATB configuration parameters
    This group contains attributes which are specific to ATB protocol
    */

  /**
    @grouphdr atb_timeout_config Timeout values for ATB
    This group contains attributes which are used to configure timeout values for ATB signals and transactions
    */

  /**
    @grouphdr atb_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable coverage and protocol checks
    */

  /**
    @grouphdr atb_signal_idle_value Signal idle value configuration parameters
    This group contains attributes which are used to configure idle values of signals (except "Ready" signals) when "Valid" is low.
    */

  /**
    @grouphdr atb_signal_width ATB signal width configuration parameters
    This group contains attributes which are used to configure signal width of ATB signals
    */

  `ifdef SVT_VMM_TECHNOLOGY
  /**
    @grouphdr atb_generator ATB generator configuration parameters
    This group contains attributes which are used to configure stimulus and response generators for ATB
    */

  `endif

  /**
    @grouphdr protocol_analyzer Protocol Analyzer configuration parameters
    This group contains attributes which are used to enable and disable XML file generation for Protocol Analyzer
    */

    /** @cond PRIVATE */
  /** xml_writer handle of the agent */
  svt_xml_writer xml_writer = null;
  /** @endcond */



  /**
    * Enumerated type to specify idle state of signals. 
    */
  typedef enum {
    INACTIVE_CHAN_LOW_VAL  = `SVT_ATB_INACTIVE_CHAN_LOW_VAL,    /**< Signal is
    driven to 0. For multi-bit signals each bit is driven to 0. */ 
    INACTIVE_CHAN_HIGH_VAL = `SVT_ATB_INACTIVE_CHAN_HIGH_VAL,   /**< Signal is
    driven to 1. For multi-bit signals each bit is driven to 1. */
    INACTIVE_CHAN_PREV_VAL = `SVT_ATB_INACTIVE_CHAN_PREV_VAL,   /**< Signal is
    driven to the previous value, ie, the value that it was driven to when the
    corresponding VALID signal was asserted. */
    INACTIVE_CHAN_X_VAL    = `SVT_ATB_INACTIVE_CHAN_X_VAL,      /**< Signal is
    driven to X. For multi-bit signals each bit is driven to X. */
    INACTIVE_CHAN_Z_VAL    = `SVT_ATB_INACTIVE_CHAN_Z_VAL,      /**< Signal is
    driven to Z. For multi-bit signals each bit is driven to Z. */
    INACTIVE_CHAN_RAND_VAL = `SVT_ATB_INACTIVE_CHAN_RAND_VAL    /**< Signal is
    driven to a random value. */
  } idle_val_enum;

  /** Enumerated types that identify the type of the ATB interface. */
  typedef enum {
    ATB1_0      = `SVT_ATB_INTERFACE_ATB1_0,
    ATB1_1      = `SVT_ATB_INTERFACE_ATB1_1
  } atb_interface_type_enum;

  /**
    * Enumerated typed for the port kind
    */
  typedef enum {
    ATB_MASTER = `SVT_ATB_MASTER,
    ATB_SLAVE  = `SVT_ATB_SLAVE
  } atb_port_kind_enum;


`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Enumerated type that defines the generator source for slave responses
   */
  //typedef enum { 
    //NO_SOURCE    = `SVT_ATB_NO_SOURCE,           /**< No internal source. This generator_type is used by master component. This specifies that no internal source should be used, and user is expected to drive the master driver input channel. */
    //ATOMIC_GEN   = `SVT_ATB_ATOMIC_GEN_SOURCE,   /**< Create an atomic generator. This generator_type is used by master component. This specifies the master component to use atomic generator. */
    //SCENARIO_GEN = `SVT_ATB_SCENARIO_GEN_SOURCE,  /**< Create a scenario generator. This generator_type is used by master component. This specifies the master component to use scenario generator. */
    //SIMPLE_RESPONSE_GEN = `SVT_ATB_SIMPLE_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_atb_slave_response_gen_simple_callback is automatically registered with the slave response generator. This callback generates random response. */
    //MEMORY_RESPONSE_GEN = `SVT_ATB_MEMORY_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_atb_slave_response_gen_memory_callback is automatically registered with the slave response generator. This callback generates random response. In addition, this callback also reads data from slave built-in memory for read transactions, and writes data into slave built-in memory for write transactions. */
    //USER_RESPONSE_GEN = `SVT_ATB_USER_RESPONSE_GEN_SOURCE /**< This generator_type is used by slave component. When this generator_type is specified, slave response callback is not automatically registered with the slave component. The user is expected to extend from svt_atb_slave_response_gen_callback, implement the generate_response callback method, and register the callback with the slave response generator. */
  //} generator_type_enum;

`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifndef __SVDOC__
  /** Port interface */
  ATB_MASTER_IF master_if;
  ATB_SLAVE_IF slave_if;
`endif

  /** 
    * @groupname atb_generic_config
    * Handle to system configuration
    */
  svt_atb_system_configuration sys_cfg;

  /** 
    * @groupname atb_generic_config
    * A unique ID assigned to the master/slave port corresponding
    * to this port configuration.
    */ 
  int port_id;

  /** Helper attribute for specifying solve order */
  local rand bit primary_props;


`ifdef SVT_VMM_TECHNOLOGY
  /** 
   * @groupname atb_generator
   * The source for the stimulus that is connected to the transactor.
   *
   * Configuration type: Static
   */
  //generator_type_enum generator_type = SCENARIO_GEN;

  /** 
    * @groupname atb_generic_config
    * The number of scenarios that the generators should create for each test
    * loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_scenarios = -1;

  /**
    * @groupname atb_generic_config
    * The number of instances that the generators should create for each test
    * loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_insts = -1;

`endif

`ifdef SVT_UVM_TECHNOLOGY
  /**
    * @groupname atb_generic_config
    * Specifies if the agent is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables sequencer, driver and
    * monitor in the the agent. 
    * - 0: Configures component in passive mode. Enables only the monitor in the agent.
    * - Configuration type: Static
    * .
    */
`elsif SVT_OVM_TECHNOLOGY
  /** 
    * @groupname atb_generic_config
    * Specifies if the agent is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables sequencer, driver and 
    * monitor in the the agent. 
    * - 0: Configures component in passive mode. Enables only the monitor in the agent.
    * - Configuration type: Static
    * .
    */
`else
  /**
    * @groupname atb_generic_config
    * Specifies if the group is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables driver, generator and
    * monitor in the group component. 
    * - 0: Configures component in passive mode. Enables only the monitor in the group component.
    * - Configuration type: Static
    * .
    */
`endif
  bit is_active = 1;

  /** 
    * @groupname atb_generic_config
    * The ATB master or slave component can be disabled or enabled by setting it
    * 0 or 1 respectively. This is only applicable if it is in ACTIVE mode i.e.
    * is_active == 1.  
    * Note: currently only active slave can be disabled, not yet supported for master.
    *
    * Configuration type: Static
    */
  bit atb_device_enable = 1;

  /** 
    * @groupname atb_generic_config
    * The ATB interface type that is being modelled. 
    * Configuration type: Static
    */
  rand atb_interface_type_enum atb_interface_type = ATB1_1;

  /**
    * @groupname atb_generic_config
    * Indicates whether this port is a master or a slave. User does not need to
    * configure this parameter. It is set by the VIP to reflect whether the port
    * represented by this configuration is of kind master or slave.
    */ 
  atb_port_kind_enum atb_port_kind = ATB_MASTER;

  /**
    * @groupname atb_timeout_config
    * A timer which is started when a transaction starts. If the transaction
    * does not complete by the set time, an error is repoted. The timer is
    * incremented by 1 every clock and is reset when the transaction ends. 
    * If set to 0, the timer is not started
    */
  int xact_inactivity_timeout = 0; 

  /**
    * @groupname atb_timeout_config
    * A timer starts as soon as atvalid assertion is observed and keeps
    * incrementing until atready is asserted.
    * If set to 0, the timer is not started
    */
  int atready_watchdog_timeout = 0;

  /**
    * @groupname atb_timeout_config
    * A timer starts as soon as afvalid assertion is observed and keeps
    * incrementing until afready is asserted.
    * If set to 0, the timer is not started
    */
  int afready_watchdog_timeout = 0;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** @cond PRIVATE */
  /** 
   * log_base_2 of \`SVT_ATB_MAX_DATA_WIDTH. 
   * Used only as a helper attribute to randomize data_width.
   *
   * This parameter is not required to be set by the user.
   */
  int log_base_2_max_data_width; 

  /** 
   * log_base_2 of \`SVT_ATB_MIN_DATA_WIDTH. 
   * Used only as a helper attribute to randomize data_width.
   *
   * This parameter is not required to be set by the user.
   */
  int log_base_2_min_data_width; 
 
  /**
    * Stores the log_base_2 of the desired data_width.
    * Used only as a helper attribute to randomize data_width.
    * This parameter is first randomized and the data_width
    * is constrained to its power of 2 value.
    * <b>type:</b> Static
    *
    * This parameter is not required to be set by the user.
    */
  rand int log_base_2_data_width;

  /** @endcond */

  /** 
    * @groupname atb_signal_width
    * Data width of this port in bits.
    *
    * Configuration type: Static
    */
  rand int unsigned data_width = `SVT_ATB_MAX_DATA_WIDTH;

  /**
    * @groupname atb_signal_width
    * If port is of kind ATB_MASTER:
    * This parameter defines the ID width of the master.
    * <br>
    * If port is of kind SLAVE:
    * This parameter defines the ID width of the slave. If an
    * interconnect is present, the ID width of the slave should
    * consider the maximum ID width of the masters in the system
    * and also consider additional bits required to represent
    * each master in the system.
    * <br>
    *
    * Configuration type: Static
    */
  rand int unsigned id_width  = `SVT_ATB_MAX_ID_WIDTH;

  /** 
    * @groupname atb_signal_width
    * Data width of Valid Data Bytes. If Databus is configured as byte-wide i.e. 8-bits
    * then there is no requirement to indicate valid data bytes in databus. For that case,
    * it should be set to 0.
    * data_valid_bytes_width = [log2(data_width) - 3]
    *
    * Configuration type: Static
    */
  rand int unsigned data_valid_bytes_width = `SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH;

  /** 
    * @groupname atb_generic_config
    * Indicates default value Master will drive to AFREADY signal
    * NOTE: currently NOT SUPPORTED
    */
  rand bit default_afready    = 1;  

  /** 
    * @groupname atb_generic_config
    * Indicates default value Slave will drive to ATREADY signal
    */
  rand bit default_atready    = 1;   

  /** 
    * @groupname atb_generic_config
    * This defines a limited bandwidth of slave indicating its data acceptance rate.
    * It is measured as number of databeat received per 100 atb clock cycles.
    * Example: if slave asserted atready with valid atvalid handshake for at least 60 times
    *          over 100 atb clocks i.e. 60 atb databeat received by slave over 100 cycles
    * while max_slave_data_receive_rate is configured as "50" then slave will de-assert "atready"
    * next cycle even though "default_atready" is high.
    *          Once data receive rate falls below this specified limit then slave will resume
    * asserting data_ready according to all other ready parameters like, ready delay etc. 
    * 
    */
  rand int unsigned max_slave_data_receive_rate = 90;   

  /** 
    * @groupname atb_generic_config
    * Enables Synchronization Request feature in Master or Slave.
    * This Feature has been optionally introduced in ATB_1.1 and
    * it has no affect for devices configured as ATB_1.0
    */
  rand bit synchronization_enable = 1; 

  /** 
    * @groupname atb_generic_config
    * Enables use of ATCLKEN signal in Master or Slave.
    * This Feature is optional in ATB_1.1
    */
  rand bit atclken_enable = 0; 

  /** 
    * @groupname atb_generic_config
    * Enables Flush Request support in Master or Slave.
    */
  rand bit flush_request_enable = 1; 

  /** 
    * @groupname atb_generic_config
    * 
    * Enables a separate port/export in the slave driver
    * (delayed_response_request_export) and sequencer
    * (delayed_response_request_port) through which the user can input response
    * data in a delayed manner.  When disabled all data and response
    * information related to a transaction must be given back to the driver
    * from the sequencer in the same timestamp as it receives a transaction
    * from the monitor.  When enabled, the user has flexibility to provide
    * response and data information at a later point in time through the
    * response port in the slave driver, although parameters related to the
    * delays to be applied for driving ATREADY, AFVALID and SYNCREQ signals need
    * to be provided in the same timestamp. 
    * Refer to the user guide for a detailed description of the usage of this
    * parameter.
    */ 
  bit enable_delayed_response_port = 0;

  /** 
    * @groupname atb_generic_config
    * If this parameter is set, ATB transaction phase level information is
    * printed in note verbosity.  Messages related to start & end of address,
    * data and response phases are printed.  If unset, ATB transaction phase
    * level information is printed only in debug verbosity.
    */ 
  bit display_xact_phase_messages = 0;

  /** @cond PRIVATE */
  /**
    * If this parameter is set, debug information is driven on the debug ports.
    * The transaction id as well as the transfer id corresponding to 
    * each beat is driven on the debug ports.
    *
    * This parameter is currently not supported.
    *
    * <b>type:</b> Static
    */
  bit use_debug_interface = 0; 
  /** @endcond */

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    * <b>type:</b> Dynamic 
    */
  bit protocol_checks_enable = 1;

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables toggle coverage.
    * Toggle Coverage gives us information on whether a bit
    * toggled from 0 to 1 and back from 1 to 0. This does not
    * indicate that every value of a multi-bit vector was seen, but
    * measures if individual bits of a multi-bit vector toggled.
    * This coverage gives information on whether a system is connected
    * properly or not.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit toggle_coverage_enable = 1;
  `else
  bit toggle_coverage_enable = 0;
  `endif

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables state coverage of signals.
    * State Coverage covers all possible states of a signal.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit state_coverage_enable = 1;
  `else
  bit state_coverage_enable = 0;
  `endif

  /**
    * Enables meta coverage of signals.
    * This covers second-order coverage data such as valid-ready
    * delays.
    * <br>
    * This parameter is not supported currently. The meta coverage is enabled
    * using port configuration parameter #transaction_coverage_enable.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit meta_coverage_enable = 1;
  `else
  bit meta_coverage_enable = 0;
  `endif

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables transaction level coverage. This parameter also enables delay
    * coverage. Delay coverage is coverage on various delays between valid & ready signals.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit transaction_coverage_enable = 1;
  `else
  bit transaction_coverage_enable = 0;
  `endif

  /** @cond PRIVATE */
  /** 
    * @groupname protocol_analyzer
    * Determines if XML generation is enabled.
    * <b>type:</b> Static
    */
  bit enable_xml_gen = 0;
  /** @endcond */
  
  /**
   * Determines in which format the file should write the transaction data.
   * The enum value svt_xml_writer::XML indicates XML format, 
   * svt_xml_writer::FSDB indicates FSDB format and 
   * svt_xml_writer::BOTH indicates both XML and FSDB formats.
   */
  svt_xml_writer::format_type_enum pa_format_type ;

  /** 
    * @groupname atb_signal_idle_value
    * When the VALID signal of the write address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum atb_chan_idle_val = INACTIVE_CHAN_PREV_VAL;

  
  //----------------------------------------------------------------------------
  /**
   *   post_randomize does the following
   */
  //extern function void post_randomize ();

`protected
]+D;0R]25Cb(^aGa3B+G&:549=fKePb#;b<P@F>9bQ\d(9_>dX:)/)@T5;YX[Z+c
IPONeK\_e/GJS-&OD@Cb\5;[;IS^9@;+DTe0_f0Q#FE/&+VIE6&NU=3]-3f?HYZ4U$
`endprotected


//vcs_vip_protect
`protected
-UO8^9[&IU\/;&?E@;(U.YQHAd+f52D=e]V/eLI1]HeUGO#_+Vf_,(CWXXUWNDF?
^<.gZ#]ICOW,K.4^Ebd1[XA_\^MfFCW;Af07=\U0]/G\?MOYeSMC>W>bU]KFeTc@
+HMea?@T\K=LUb?WA-PS<cPIc,ZA9,ZFV>YggJ>VCS5CC@AW(?49Y6F]<TY&CB7W
9CORPLWZL\M&d=<E4cX^bab4aH/T,L5\(c);CNQ3ZHR\15W8bb^,4Z74+YYE(e#g
f43F,MGN3NJA9Y(]aIb5bbLf;D,V@dD+)R;S,Ma@YFAB7&\@W@730g&NN>7Y?F6U
Q75BH2ZP4]WQH:F1V>3.-AHO[bVf0;NM6-Jd[4T>gW^_K5f=RVGCE-Q@@=Oga90I
GFA+Q4M&6[JNL<J/+9O27NW2:QSc3IF_aDFa8KU__<[(<=Z1T1SB-J\=3U^N)MC-
_E@^c7B11D3B\d+G+AC7880K-14=.1N+1\,13TR_TMV5UP3Jfe_X0J)>YSQbK2J^
+NS;OT#1ADED?DZ\d8a:>@8_=7ZRZ<\9@CaX>;S;F+:Mgg[TW.#+(6:X>a=B#HFD
8.@;[LJfO4@1(D6QSV5-Dc(f+]GP1LD3#C&HfU@VC>F,IFB_dN+[+9#FXZ>O8\LS
07GgHcd?A3BWK^/J;ZGFV3UU9)YHZVD^,d=WFdY#QB5WX[?QH??9H)gE;+GE6/_M
P@2V(Y7B0A0,Yg(4b6Wc@E+DQPQ.0:ede+C0(1Kg6[B)KHL#,1?WfI@[F(E?X:(G
;RPfXW2^8Pec85MU,>c;;_WPf@N2E-:1dTU7OPQ9U6P19GM73#5CgaF(66=(FEeD
A^L]fD-\XQ=^8P^]U:L/T?e)>e@g9aI(4I-<:6]K>.Ae)c+LXTO97fR+Q6+fK^6Z
1<FF#Ec8JX+H1-X>9@;D[LOG88[Rb3E>/a@_/Z>]9FHXTS^EV.\^g002/5X7Ua?7
C>G?5ZG(,NRSRF:NfJ6?F\a9V>BII9:5F\D^39D+T-\_=0S#B+G)TA5fF]PM4CIe
K[7VY.0S\R>c3O<^SL\dC2:]DU0BUa<M+b:D+b&_N>T-9-&O,)SUSS,,9L,P4fUO
38(J/7f2cSH&LO>&ggPJ1eM5DY?1SeHF54CEe,Q84e38T\@I2V?9PHDOgScRBITc
_QbS<5,#WeIJXb.<,,/a-b#\b&T3WB7II[a(-BGLaPJ3#ARL///Y2&]I(@a0F0AN
cf^d3-PO<]70XdH7+2[;@1Y+<<<RHXK/ZDXb/YM^a^5-8aDRJ,F([Ncg]2fCcQe1
<3&NX>G^K1YJYVQT=IQ_Y#T/>)7H7=MBN5cGWW40#WA&\7,PCE5A,_#5@[IQWZ=A
BHZ1IGX;CQ\[_2RIK=SM8KEA24BNDKJMG^=g6C]cZYC-?M(Y7(S_\QL)9=QP=;ab
MLdJLJB#,?VC+aR6+?HEbT.GIM&4g<gNJL\4Z4.4TDL=.DXOEQTE8,L7LYK3P]Y#
5]S[2Y)Z+5MbIXR&^e7MHF]F;<D6d3\BXB.CdPBA\]P5F[@O2:874bM,f3),V^3O
IWGRFB>D^HO)@f/c<;K&12_HA]P=5]X<9g1N[cE5FH<==&6[fW42B(\7?KO[D<?6
;JG[Td+48eW6I5<U3g+MfI-?7g(CRB)2Wc(g<&g1_XV7@IU1:V0TL-6Ha>V&;cQ]
-f4ITOEWE-,JMH(d[-30/g((LNVWe[9;2F6@HDO@T#95T8Z-FKV5?EK5>WX6Y>cO
e95C7dQH>&:B\C&>>T68L-[G@E+P-F-,T1>faBbUP[-CUfSVR&@R[D_aZ&7#ag\8
fF<dX&GFR?>GaTP74Z@D-V)fGTL)O])5Y&2P/=SDXHS:T6IL2+G1CHPWI^U5YW,6
MFf.G\T5G]3CaX[fJEVAdDTV1(Ye]G7[5?XA-d<b-LC>c22WC)H.M./?b.,ZMLD]
X,B>U7fe<[AZ<56>JOb(,a([@[bYBOOPd[6)<XN7IJLNYbP,95=Q]K7c-a/,M.Wg
F<K^(1CMEN+]\FVc);.<^20KK?)d<9_&JgW-RJ^8J:^VCDJZ6(IU^TFAKEECU7gb
7C^c=_eCMg[C&=P^OgcY]4F\\_W8O#^Y-48bBE(//3Idg\5TTKZ9_0NLaE3[aF2[
V3YEI]AW2,Y2GgOFYA10VfK6X<9#OdK?0N2U;E#J?1D0Z^:D\QLYAXM1.g(3YI#_
&+7b,^C3D/TUbB72/_X,b57C]8XYW)_,@R&K&DcE1g8]QZR6,O,?B7+##[@5dHDE
L@X=D.J_a,MKAWZWN2C0>S^-U6Qf@;=?06?c<I>NLS4RVCVF+M8:+46):2\C[R3>
6e)#CPFH=?PF\MbM,Td.6G:c&bd^-A3FI5MSLGFW&P@G+&Vc>>,?,@7#+#<_a8,2
:(NWJIK@20BD2FL=aPdF+Nd;7KT\[,@\\:<fU;(535\W_;4<#,+b6^\V+P:<;/Bd
=:^6W2JS?+ND]V__?6,b<dE/F)e,3d9b-VO=3R;,Y+\Z[5\Eg;-2#T>FFN>Q?7,3
AFXYFJSILbF7D;<EX--KTaSC3F)>ZaN1b.[\e+N[UTC_9?D/LG]6?RUY.7MVP.IH
.gKPegQ7OR&fQWEPgbCO&P4XK7P[#9F#NO#agXTRXBOS1bK>[[,LXcS;YCL98LZ.
DQc8K/)[-Df0.=[.Z4_,S-_Y\R>b388?:4^;?e.SXEZJLU4ZPL#+2YP0(-gg73g&
VEfNfSR-1#:6@eIffK\2.eGAadB@IPH;E=gf&-f;AfJOB/?V?:1.FeNVNW7]HL<\
@O.&-X]^,_IP#/Hdg[QLQ=Ha6:1UO_3JM,@RAJRAE)#C8OPcZ(NTB)^9#?W2-<49
?:2^<VTE3eEgeFEB,Y\D9D,E=>c,8L](?8P0#Z23[96>FAaMM/c&X,Y\)<<U@T:Y
HZH6Cc\F)bHJZ1e-_YO-cC612b5#B)&4-[4T=fE_(,,(.9OOVg2YZ^bZNAR@b;OD
XJ.9YNU;/M\HdP[GMO4./8>ZVAL420-PG&488Q>;JCL5=M5^V^>.GT(KGU25aD,3
?C@ZD)T:HPa1Q8b&N7E\5G=Y76,[^BT/8_N0O2.F7^MbK#&g36@BfD)PHd,]Y;cT
)VW.+XVC-4d0[E>3WBIGF^GQ:KYaQN^+SL9G@:,B::Q-G>[(J0)H>4R9)@\-J.gK
8A5#/BAJ?.#bUFf3==.a6bACJ,X7ZYD;PXc(:>-BMGKaYBDS.\65QK5aLCA:2WA>
DQe#:#T47^)-?L+BL,BPB07]eQ35ZgAg_J/)L@;c#WJQUPe\APNVLISb4dSDc5&\
8)B=(?H^F><)FY-U63_O-YZ9-5>cEfb&.a^(=YWXX>F5+R=4<=DB?#Fd,\\dN:d?
^fN^U#Ya4,O-\@f8O#INf-78Rcg/HJP&Y.,eAKPb7-ZX7/8]&U+BZ4aILX9#JM3^
dGfSXAP?#[5gdSN_.gA7C]8f6R+K>L;?.c:9=D-8aLIC@1RgBX5+ab0+[O;+a#:M
d,0^^_>0DCZg-$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_atb_port_configuration", ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_atb_port_configuration", ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`else
`svt_vmm_data_new(svt_atb_port_configuration)
  extern function new (vmm_log log = null, ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros
  // ***************************************************************************
  `svt_data_member_begin(svt_atb_port_configuration)
    `svt_field_object(  sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int   (  port_id,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
`ifdef SVT_VMM_TECHNOLOGY
    //`svt_field_enum  (generator_type_enum , generator_type                    ,`SVT_NOCOPY|`SVT_ALL_ON)
    //`svt_field_enum  (generator_type_enum , slave_generator_type                    ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int   (  stop_after_n_scenarios            ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (  stop_after_n_insts                ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
`endif
    `svt_field_int     (is_active         ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (atb_device_enable ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (atb_interface_type_enum    , atb_interface_type         ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum    (atb_port_kind_enum, atb_port_kind ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int     (xact_inactivity_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (atready_watchdog_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (afready_watchdog_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (log_base_2_data_width, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int     (data_width                 ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (id_width                   ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (data_valid_bytes_width     ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (max_slave_data_receive_rate,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (default_afready            , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (default_atready            , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (synchronization_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (atclken_enable             , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (flush_request_enable       , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (enable_delayed_response_port, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (display_xact_phase_messages, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (use_debug_interface        , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (protocol_checks_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (toggle_coverage_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (state_coverage_enable      , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (meta_coverage_enable       , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (transaction_coverage_enable, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (enable_xml_gen             ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (idle_val_enum, atb_chan_idle_val, `SVT_NOCOPY|`SVT_ALL_ON)
  `svt_data_member_end(svt_atb_port_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

  /**
   * Assigns a master interface to this configuration.
   *
   * @param master_if Interface for the ATB Port
   */
  extern function void set_master_if(ATB_MASTER_IF master_if);

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the ATB Port
   */
  extern function void set_slave_if(ATB_SLAVE_IF slave_if);

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
    * Does basic validation of the object contents.
    */
  extern virtual function bit do_is_valid ( bit silent = 1,int kind = RELEVANT);
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
  extern virtual function svt_pattern allocate_pattern();
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

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the ATB SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the ATB SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the ATB SVT
   * suite. This is checked against OVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the ATB SVT suite.
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
  `vmm_class_factory(svt_atb_port_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------

/**
Utility method definition for the svt_atb_port_configuration class

*/

`protected
=G18MCDVM=TM[=d-HEEMIe]L)D&eQ[=?XI-+Q8HH6ONA+,7]H?:f4)bVcF@1W&<f
RAAY+H1AHdT_&N61]e-AW\QG>>SGAGV950B+]bH?YdfKeS/D>Le;a3&Pe3IZWHQH
;ON0V.2LP,LEPZ^#7f_08Uf=FQV4M/@O?4.R;gI8dF.Q8X[T@\MfOK--^>?df-=?
MIb1?<4G[3=NI@A<61P[:4>@1N>HgN@XZ[MU04E3AH1(@RJ;N?[Eba8Z8[>AacZI
#B^)#95PBUXUd29G8PBXBU4#/+IGQ1fI_Y\P1^71&##?)(a+eY4ZA,BYM(K^\]/d
6UH>P+DXBK]W.CQD8.HVX^gS&DD1:-gB#T78UYfDN-aE5bWKKf@[J))=FC1R3WQ-
Ocg)>SY&dY=ER#fH?XL4BEgeI5))P2+JKT.XP922?:3QI;A9b:+U.[@a6PJ)ME\b
0c<A+g=Gd2S#Me8W,I1bK&+EdI-U\2)08GQ+=<3)M+LA[_H=61ULA7YHNdWE7A8g
]IH4,ZUgZcL<1Q^QdY?,C2+-W+-S1EOUdK]W6IQd1C/.B-C-f8Hc,SbbFW>ML)Y_
g2bb\8YAGZ/g2UObAN\S]Sb0Z-X7Z7]L8Ng)CfCVG0@9LW]_\\H9cabbf@\EZ/R6
\RZ4V5<L8cMHMIVQE9?6LR&6BUU-_d.(bMN/VJ\[_<1+.P(>HSbb;>./<f]LC8_S
1\&HXY:(A&be>J?A(_[6cH,HQI?=,;.@E+\KeZ,\S=2#?)M,&&^HAMFAK5;g31&c
K1:.e^Y-Z[Bf7N;-TedX8D<1aZ3/3(/gcM)CP8e7(GY9L/BBU&Q3Y)\3\\<C\>EL
d&-L+,FV0f8\Wb:V)+dgHD@M&>E6]g^-9YI51XE\>4D6Z?)-f^&#IZ[B_3c5P=[U
aP5P^QUEJWfU6?/TRd(23#FTF[+g@g;3ENbRR43G-U(P-;XI4JNXd2BUX_B^EIHE
DdB2D209NK&>(c]]^<e09eL]+4=E@5aFAZ]S_]SfWPe-]GU[gEB_(Z/SAX/VSO])
)f2b[WXc0QJV:)AE@gV+<9/S9=Oa-F52bC-5(/^3^(XNX7M\3?H-,3a)H&E47Q]+
9>JQ7d]C3(N::_JLR^aQ.@:>ZN1<E,6W<U[#e6gQIdd(#3A-FHOE9(8SD<VPY=;\
/P46JJd98d(::&8Lg_2DWE:K(X2[DaO,TR35d]T2I+=<cL5HWB-f9GX+=T-Ae8@J
@Z&T=2O&<;0cZQZDO1O_Eg1\TSOaR,4#FC4;V/:_Q@<3-]^C_]X4\L]f/c1:3#\2
#]DJBQF49M[?4_AcCSbcTZASK/RU-(UK1H(;\ID_FKO4&A:TSWWP6N4FZ:gHDXK3W$
`endprotected


//vcs_vip_protect
`protected
),SBMEWeV9K?Jc;_JCb<f;#RAVV7EH/2Q6NI#?P^;=X@O8V1/D457(MDR](=>2<6
/AAGC51]K>V]WSIP,M/_dJ:Q6@3)(FNZUP]LD?e5H-H-2MAaQRg/5\0N>=@RG=V_
1NA/3#;UTa;CWO(46WbZ;U<>/KF[KcS8-XIcbU3BJc?;+U9#]1TN6-:d8W<8SFQ\
XXL8-[<\P6E1?+58aRT+6ZTSD.55FTZAXRB,2aPTF7JAFg>Ma-PdM#AB.f@GWg]K
+)#F?H/KbE8DK&-4]A.D##)@^Dbe9gRIQP7abW=:-)4[2NW^/PFS/>#cYa/b.6AC
Qa_f2F<ZSO?27(I1/3\/JY?+CQ_2NeUES8,Y<]gZe7J]\3MgNF./9>YM:e5W5.9P
][B3\D3#88A(/K6T-;cOcM@8[gQ1WD9ZZ(:&?H3^2([V+TJ_1[=+QcT.Y)&e)Y>]
CCSABF_RI#&ca..NZ&\b#f]L8?.VE]aVS&^-8OLZ=]-62?2:UK/\X)DX^c/<J^I1
Q-.A.Gg=+[D]:X>VP=TENKbWF9V5Jb=E2\)Qc[O?V5VYd\)0gJ>@MX@W>ac^->1W
/.B?020fXG.GWPM(\P:&g-.]_XHGFZXbd\-PV1O78,Xb:VegRX.TF_Y7a85QdO+7
:^2Z_OV+3HeIFec(BN.8HX[<,O=UI>W-fD<FL+D9eQ2Pg,9/<IJJ)8(aYUSOOS,N
_S-Z,fTX(.I-3,H,ZIW:V0KI+2aNe5^X(fU:,:YcBS2BeW&BCVIJ^)8>GRM]+^.9
YUgTMf4&GV0g,?.-#cVUA8R&b(2PB)M.LM#VNM:[&FE](a.>Tag.0PM9U^:2Kb^b
08]=#e<?XA0fgV);b4/Wb,66BYec&E^8bX_dN#IEH:B^ULE^QY75g:RKd(@12EB6
S805dF19;(VF5A=D;b,EMZa0]MXUcg(CcN:RX_K<+Bc^[00SDDTCRZQE4F<,?M6-
S.(@7&8Qd[J.=;F:G>PY.BM81^CKX49M8W.Y]aY^#PbY-?dcGOaBaP^>WI1)STFZ
ZG_-.L[P,1F:UG2_B).L4D0(GeVe]_><CK3e6;86RNg#U4OHF/Sa^f\<e&5F/:<R
3PSdN#D#WWH/bP?f^?(8F7^Xa\Z2>>[AVf;0L;BY+8?H-Y\<647PV@JFg+;KgZaQ
H+]/1O>)#8^_F/\d^^:BYI(HB5I-:+\B()&SBT6_DIL\4:)YB-Y?RZG,F3(E\WIO
3WEELcBW.KJ=SE@6gL^_)1&7F2gI[5&NFQON5&\8DQcM[;e>+I0@:_;)26#=2A<E
I:T#CJ6V-2[@KL#?[Df2[89fa<4BMJIN,ZKd?AJO&1M6H)]P7^VQ@.O9JgcM<b>(
LGZOfF.>OBDS\[TPU_B.?SS]a=6e&E>G.b.Uc.f@\T+U]=?6MTL6\C#+BZ,85fPU
6&eP5KNdZ-[3IY12-+8YL(NT4/d4R^(+^C.M,;@fg(73g:8831_8PP95V::eX@1S
Y;c2K5Q<ZVG_)7@]K?Da#VL&@>@[\c2I^2JBHeVYcY3I=<bbU5J8<N&[#A\[KH8;
:gD56c1eDa(=5GWKRB\X\9H\_JDEc/YWT_KK(2\D_ROgfOFgE50[EU9-P9;[@bB5
&@AH6T6-4UJ:d>RDDSL,,PNN]2,0&);2g-Y=YC1DP/WGGg46C.[Y,[B80LE<W-EK
g5>G_<^R4QZC,H]JcTPY/]PYWF^>ADD)LLY@1+#E-GJ(KXffQPeD3>e+&LJC>dAR
N/N7DI6?^&O9BM?:I2QS?,e::W&#g[:6HNe?.Z9_@E1>eEL)>+4QM/ZfdWB_=QJY
:?#KW.0)X)^MD^364)79>T.Fd4##<Bg8fKTP=.BIBOQMB-g[M@,\-<WD.aeOWD@=
_G7@.KHPYaKHcFVS5Za<b,B8KT@VKBTLGfOS4,@c,U<X6<fH::/]B)KM:;5gB?I.
XGJGAS+EUQbcN<BJ8+8IYU>X]Q)>9JE7C?+E>ZS-A^@3_T&;NZbM,TaU75P99XEF
<cO2ZX_9UJ4PR0\d2g_F[0.,1+19(bL1Ee_^CZO2+>fWQZUS.,@L9=([b8-/S.P>
A>9_bMI\eIc7C:M:d;/F(KPS.AQLN[21,&3#g0V-220Ff>[]X2F05c_d8f#&/JN/
6-S:07.Q7^EJGR/=]2BHEfJ<P#7cK2Y.cZ\e4T9fTR(Ggc2K[R0KQ5=4Bb-dY9Ma
5eMZ76RH-]NMQH:=[68c=UMG,.V2+>J;8Q[PMAbBb(D4(J3>6]\;IF:S<J=O6Z+N
(93:W\R/_KRAH-dK9<J50QQ-4HgJY[@:<N#9/KYcZH8POd2J_7(L\1<)b=-TX7/E
Uf[AQ^QO=M;^[aR28OTD>6PFO/Wcf9^L:-)>\;I-O.[8K)W+=>a&3b;K/Y[g<=d]
bDQdFD)Xg@7(3c^+M([&1PaU62#7H^eaPUZRN[MF1F2QHb3bC16LQA\;C<9T&=QC
;29BNFb43KK3TeS^[P:4X-ZH1AK3Tc>KAfOM0+79a24F=4-,0<b65G19fC/?fad\
AIcS^3Lc]&.M&=EIfJ;YFVD)PFZd#&8H(X1#-\88T7Y>^_S:DDbY,N+cH.cPDX#L
C#6eR.B;&RV2\#H0203bc;<,#AIJ-b\,T?UZ6cK1&J-Y2U=Z?3cb9UG#(1AKE2>,
Da.-&6[R5&69,?;XV/DHFCF4HHIQUXe?f&LNfI]HB0N&F,U)7I4CWHeRT[PGPgS4
7D2f_L]cKd&ATMWA/P?cS7[P:KQ\7f&<T:,0NA#2.>c1V[655<HgV=c0B>D.W@/=
8Z]^dD;#GBCICEK5T>Zb>I9a_\-_,\Ob-?Cf^Hge2L[0-#DUAK.3YGg#;?&YVUU@
I@9209N4IKUN.Y@K_1\MQH8\\:MX0H0RJgE#J[Jb(T+Kc.KL3&a/1Y3S93L:@&/0
60I^1U&)0A3?SIN0gW)BBGUA)NJJ06B9EEQf/]/?:[V]Sf3(ARa=A(I0:4]c<2g2
[YOA)\TGSEc+KAb4<]GTA,/L]=?+,4K&J/#D(RH-H)QA:A1R&d3FBCC4_MD=9Se6
OEX0dSSg,CN-2#_B@Pf@QK9F[bRcc+J++0g(06a3H1?>&G0^PU7@BS8e(TgOUK&[
V-X=Q&:N<gED?AO>HC(#JT:Y^#^BB:AL[c?Qd0eJD18&d8YTf64E@22T+LAZAGfK
[UR^XFfEM/PKb<Rc6aD.T1_:;+.#=<ND;4>N\Qe-_Q3TQ)DUPV/\\\H_^4=c/RKJ
KE9;Db]_6[#5]_<Y3N<R8cCgU\1T/4[HAHW&Q4>d;Ad[CA(H=)^K@G>)TN9a//=_
B1@T7:A8IH):?YZ(-OM^Z>CLN8Yd^YQR4NT\@J>^fSeXKEaT-\),RaA;A6/PR<E+
[]YV.:VKbV&4eO7]S@O[f];N)<=;,b&_RU9VH9]DRUPH@3M3&Se]9G86Y)b@<.g)
S_2JfY5TXNPf,T8P@TP:_6E7OOF[CM)68]>bbBF?-5IURAX,F_4?PFAC7[TSF3J)
FZX5GLQ2<S2)#d2LA6K=#-X<-a/#I6RcRT59)HQd0g,\?];M0B1(9)1[;gb/Q[.B
)_A36(b).4L/eVSf;G?\?Ve@G\^@<+>f?6S-Gd;7QAA8@:(X:NN07NcJD+3JP<>]
A@6Y8_WA98#)>M#QI=BX,@&Y051-G)V)3@=3CST0W3T)+_C_1_01[687;DgO8;M5
1e1>fg-00P561\.7MIO2RYOY_HJW_&J,U;ERB)_24bXc4)6cR9ggCY2UZMASDDO2
-&S.gE#Q:)G[DEW>6D\GPV2+G\<^N./&_gPNXEET;0T0VKI6OU_=:.>He0ffV+Z(
McU,X90OcMDXTR0;13cX)UP0O+Oec.GL_G&70UC,DQ)OMaG+C20M;G8NDC@[MQ&V
HI7dF#=AZD&7(/,;M;8Z+#C2g=YZ2SJ1E=c<aEF?+?XaGgJN,;DdYb=CB@[bRKSC
FN]DfTPUT=8,O\(2\_/Zb4_F]f[^I<92AIWH&7?R/D9-5JS;P1:N6>4/CEY6^4);
X11e0_;2X<)^J.5I8XdeWFdJ=-OFK]@-a1]U)^eY9KO\>?#?1#IO:DFc2.)EHRW7
DO\_MF]1e3/GBO3-RK+b?6FE<<[B2=,9-aN:HIDKfdLQ@c^1E9L9<P7+\X-b3/(G
]6a10;-U?:]PDY<ZGOF6&^<L89:&P@S7Vd.M5-S&dQWF98(__&)BT0d71=aM;0^6
=9Q0g(@U.W<P7E_X>dJ&^)eK:(H:.@H.\:ET?7,CTZ6;N[&::IZC73R^ZUgF:HZX
6f>?S41&5,4\BI8^K/RH[U3Xc:NUO98HTOSJOM2_D7<1B>EFVUK@Y#XaeY8bge++
[(#,+TS8HKMEGf40=#S^OGTFC5ZG=L2C5WW1&(\\H3<<GV9R?P^D-:P0C^GWfC@5
Z[JP,S9bZb@g=190X[7H5D5[=#W@8V<>PKWdOa;([FU;]MBTDO,56-K:=S490.X&
6[aCV#O4HK#WIMG,E:1RM.g<(T?=,6;UU^-eO.H4KdTST@X.faJe&(\LNE/+Zc]G
.IB&10#WJ_9Q0I/1b?>F<-@/BZ]FSRfcg/8[#SKZZYe?2IZ;FVK:fNZMCU>L5>_P
3G4W;7?SP/JT8T8fBA<\5(][X:=S#Z1]3c(<AdY_&#&9beT/AYZ[6F-)JN42>RaI
21VCcBJ.L.,9cJPZ1XB&8QPaBK53@a1#GA8;)CPWVD8J;CUFC7;:\4?8C2G?L8+^
/>.W4FL3Z.e3;,3OVI:7AVQgH&WINJ4::SH.ZdeWPZV_c;gK#<]g>(>Z(JR.+WdN
5DY6JaL/<J8=VO.)44F:g(:L774c-?09O:9IBgU.-@aUM)XRJBYc?0\6a;)/aIP^
(]WYcG)>#De:5C4T2CWVcXRY[-dc5HH<X\2>,H4BR<E^P/DC?=N6J[K]_.Y+J1WA
&Xg+H=MX-:T:[,@<VbcMCKFVcWN9bI)&JgY4AO)QW?9GJ-V9DI=IbFYHB/>U;DbW
2,I5A=KA^FX2&P/\Tb9Q+2JRaDGLU[XIdQ(E[F@5be9<QEYRWCB1)UP[<T2=Obec
>0e#d/bOdb41dC/\OR.<VG9F)Ye>6(S7^W1EfDJW<==B\M>TFec0WETI)0&AcfOD
:DX-TY61Z6_/I.C>Yd;gSS[)TSQ)5AMSCB]SI[TRCAGZ)^c>#Y&,QE5C\TJT/R&B
K989fR#8B]^/NPcWLVDHMBc7@P\=d>fOBQ6[.d]g0>Q1G\R,IQ8T9g,C(QL2N@Nf
a7>MAHV;ORR9KMW_V6-T:##_T)bHS6PVWEReKN55aZ\JYee(f#HCLe0F1PO.c&L/
Nb1aH1T&#g8-Odb:;S=Z+DF_eGRF(8Hf,.LF?f@]M+d(X@@]X\Ea(>b<f[Bd#-(^
b?U75<aPcMc(N-A9TN)]:+d.fUBC2BF<;<V(4B1GY5#.gca]/OT^\VKMV4&aY5B.
<-RAO<XaJ9O_G/^7.:&7@-.D189B?IOO<(OeF(VPYf3:4aW,GD+78eE1?U)J_Z9U
X]9Y:EdI\21Ec)1.^VRC:Ue.Ig<3L:&V6-5R^J<b@5a]0TLVf]0cKbc#-YVMH^2V
]aH:#D;_SU0:(-JbRa?)b?(@52.U]?B5SBbB[18@a#90+4g\<Tge0E744T&N_2V<
IZ^dddF0EK)RI7eX/gfZ6442c6<gR:E=8DJ]\#_bX8MdK@/>TH1(3OVQ0#PM>2eF
&;Z(a#OAO>31S47VC1RH+65CBc/J2bbXM+QH>LWK:0e88aAIAFH9/e7U\7T9+M:/
aE4#<f[^GQb^ZY<;cO2#/UVHbK+CgCPCK3?Y(V./d-CG^S.g)]/&N)883K&7TR-9
);&<b/K/,.STS0KAeCDE^_F+V3J:/&&N\?WKQ7FgZ?We12,S83b#R<D,6c.S&);M
.C/=>T9?,&VZMNYZ_<0C[=01ZO0DO^4;\8U_+(0>WO2E7>0g]NF+,D])f;9gbFN9
6Q636e4W::2F@@=eEEM19BZDM7C0Q-?F_F<SR04[YG9,>PV_>1f-@(bBK334NOZ-
78Lf5I)fRc\?RaX75UQgK/BLAN&/+>,bX5g@+4@5/[CNcK:fc=(d9ffEV3B0;K24
.\10L14BH.38[=-WBET(^CVQ.3M7[J6fB0=TKN3R0Z28@-2=>8@Ga]<b@X;;b104
V#;)cEWc4BTdEKdJDH9M^PY7D>bVM1B:&](57(Cg2Z7101e_BXcG7=Ra#DCJaNB\
KYKM@U@59A[fd;f^#),_?CKDc2O.&NL-OI?A)SNd_A2X,8@-&VD2+\(0,]W0W.df
=1_Pa1?b8^^)/0-C(5O22AM3^6QIfPW/:2KV2M;N1cU&JY49HbQI.9M=[18X.c7]
D4HeZC=?9G&RN+&=>YV)>B7^@;G]:gTRE837,\>&W3G-:G7R6-(3??N:c81;>P)\
K.E\Q>4ge8L#7@.#U#IAIZ[M)b48-1[;Ea.db@\W?bg;?dDWL^<\aT49Lc[Y1)f6
B#H2+^0ZR1+&X,UL-6VRW@0[#g^64AFBb2(M-b@7>F@C[T,YB2;/WID3&=YK/aXQ
J4<N9Z3Z7BF\4==eK6R;da68f4&YJ:9:F0XUFMg(05CJ]JF;E+O\H2=Q-<(HZJP>
F3:7>G+^TAT,1EEgW7?4X;Q#?4ETPQVOZ::NcGD6S+gGY;M7F)MNd?U[13d2Q0La
A^FLaHJ?I;Cgb2O\&c_JSEG?PX)00@??IS.Z-8(8+1,cXPL\F]#\UOI@WMYJ8RPU
gJ>5Q_9A-;)7MVf[KOg:>.06Y8_0V74f^?VDE_FCW:.G=[^D=;3c^IC&<URgL;TT
6PL<\T6@Jfa?b;2.7<(V[6L-;ERX/V&E0AC2\@@9(b?]1I\5N],WdMa_+(GOC^Ue
XO6&(2(J^g1/b8NPQB&HT1/AU;e8a56;3H&/MQ12AQ1cgSE1(_-_+d@\.AVEY]9K
#,/Y;EUDeU(BR+DS2\?LTO)P[JC8?V>57/[c1NeN@K(_:W9<;F<VQ^V3b5FJ[++b
g?COP+\fS6G1?2^7I1_Jc10NY]K?cI-@?\+0>BK#4SFR(Z\\8S&\\faeS,<G#S5&
3RQL85UfagAeTf\+Y58LGGdc,4<[TF:K(c=e3CXeV.;?Q,O0/C0S58[K^DS207N1
&JNGfX&&@#H/:/^69feA)JZ5[85g\^XD9[+NFO:eH8IZ3X@#;b#:1663,?343[O2
>07SWTQXF?9;XOcH9P6VZ#P3<?;E0fC_#>1.ZYQ)J1+A2?;GS;@;B4RV8IA-XA.A
?AR40Z:701D,\RO[HJG_/ANZZO>dX0]X(A-\#Z/(g0#&MQ8df<a4E9e;I?,UQ#_?
5/JNZOg@A<_>=[1S<&bY-19)GV6UA]<[@1YVJfeM1MU:/E(9WEKJA>&JCGc<WD6?
=HJ6O?P.#YTe:^aS3/9B&LY,\d+E0,VI6N0=06>XABWY1F;ZF1<[,DFA&C12A9-X
>4c+R@bbSN38;])c0U8((TY?T9N395eLRX+L#BNLB^CHeCP2&(>.=TdF@^5-.aQ@
8HSUMLcS;1WJ\_Y/U&a5dSeHd6DS@OCbU.=HTABC800a&>Qa44)(3XPU=SV:B48Z
0(2^=5\7,a6(9^c+T,FGIEFS;4W@WL.MeD7LD=X=VgPMI]<Qfd4;]A7T4XfL(OcJ
T9L^#b))TaF42?1ZTY=#\?dg4bSB\_W_R8<Y;(=>#I>J-_@,Sff;5&HU,Z4[fO,N
X>K;3L+=0)&&dX6\OZ(2[L\4d)>?^6H7I;E-XX.2]L;<QU1e.7&#8Q4,_AS#]7T1
Qa\(T1NWcN&?=_JP\?\MXc7I._^X;Q0B^.CSMKdE&I>)NU4LW#&f_,Y#(4>9&F1O
4]+U:UERCaMUU.?E:e??.[7=\IZ-ZP\H;M7?6?.TW1Ob?C2CAXA>7<5V8\Jd67T@
7C6UFc_bC+.530-;>SdAL3#1g5EJ9HN;^C,TZE<-O#g/@g,_;0[+H+E&L>BgL,=\
)8F4@XXXXC]0=HH++YIA4:ZD3,1Q1d,+(QRT+3K-JF7\&?2fS47fe:/6A\\MY)3A
\?eB>?_dVM<TRH/LZd:5Fc(W8(0V2J[4+M6MERN;<+bZOR\3)+feceJ/EAaCQE>=
-0aBbb>)L-0T7Yce5f[)>^8V]e+C_QNT\+3+DSU8[1LU3[Y=8-]Q/_NgRO]416=;
/R/LE:WegFFHcf\XA3KTAVKYO\a9KBH;AB0UYHGWd>M@.(I#Z\b0&L^SE;DZd]WF
\^;]R[8@WO0JOd_20-&gdL)LN&Y)SO54);7A/NC-5Y,6ILd0,=-c?BLAf66-Y=dS
Z:]:1<\N3PIIU_V;\WJ(LBde9<&^R=,]A6D,<cZO)C</.>CK9a-&&=NP??FC0TAD
7Ic,UP5M)/Je1_7dZYIS;/KHagfNB/I1^[A8J=Le_NW0FZ,5Y#&B5a0V/VLNT(V7
e&4&D[G7:@,9a.Y0+]:R#[4g\(HB_fbE^Cd&>-0K=65=NU=Cb);Hc1,))E[6^C63
;Q=d@AN?fWRR3+4#5@WQf(.VG+]U2H4R+#P,,:^5O@Xa[1EPf>bU^6MB;Z9&P>J6
>M-]:US))0-YHDMIOW:/8T>U?\dLQ9_.TQ<_-ffbGZf]1Z>>79DHE31>.SU7dWQN
H]=]LJ7^/6(#]W&#BKB@,b5McA5;5U1>b]HX#_R#dFKV-NP>cH^:2N?[K4PUZ)@A
9I<U.RAY_5W7fba<<V+E&<J]\YcK5?.Q(64--+eAI;O4HecB_WWb^\YUF:L6HHGH
L\[DJ;c]-2@>-UD)P?JE0YD4c\4MV#:aC[CW+;;VORRLKG3c2IB4LEdRbb(ZJbeR
8_N_2c6a2(P(T=,N.922W=(HU[9]^,MR7BJ:,HLH>1H9SDG6Y<)D)cE_]TVW?>[I
_);7F8C+6HCIKAN-N6,C((B>]WOF0+4>?6ZSe4M3-LEg\+fOBK96aPVT0G+0T?KZ
e(eIa2e2G,BOc[156KNT;@8)eK72&Z415F9(^W_@?N8;)N6Z16f4FdNX<8C/IYZ+
QVA#9A^<J\5G4B,C?.Ec1(.CcKgN,^fZG#CW\bJ\[K0V9(=PM&YVaMac980N,/[W
PBZdJ7gGVS1;KOW?.I-OB9O6V16,[P3CbUBbSU9GX#;0CP8ECW/T/32PZ?Yb,;?e
O4+9QJbW?A3EJ]43,d&HP4>)PFd>6f;dEX?7Z?]O;b;a2M-;8]OIPY[8>@19IReA
#,IV?&-B7U=GM>aD=cI4<RN=DQLE,?3&G[/Oac\8EdU;[E5K/8>/>^d]0/()H,e(
fX\fTSX8?S0WRd]IZFIfd/;fV.(T.\+:.afO]3.8[PH2I9VT>M:)52f824g]0Ie1
]AYacPWeRRZG&3DAP?R+K=16B3\98;eaeQ#;SG1I#<9d]^XE7]Sf1D6I&@?]IHa&
NAe/c_[dH9&;YJUcb^COE(=<KCTXTO:96[A,Xc=\[>S)PIR/&=L=aYI(S>b@,36b
Y8/XKN5LDX1X^NGD;/#-ICEAOQ#U>#6[XG9I6PcOU@]6)cPA93S3B,I,;1EIM(A+
ERWIG8EQaP4^O)gBD:(VS-EFMIBL9H\MUU\cKcJW8)DP]9](7112^/5>MY9)C,^=
7WbDCU1[GPHV7FYg+[g]+=.6ULAg/8OX?4@\Q-6Q3[5O\/P6O7:)M/ZKdLNV=A3^
&I[^egEFa2dBgb1fJDCZ/C19_D3??#65,)Z--8,HeJXXYC5cUHe/]63C0L7K@(D(
GQ/U_/6A2#A)+,4BJKg^68DYMS/Y.>F#6g^1HdJ=OC.??>+N\9MW^#KL\5gYGEI[
YG[,>@]N_Q0Sgf+bCTZd]>(I0>R9]XWW)2U8b>JQ<XdLH[4<G.-(YbK(?@(,IQLb
;@gTa0(JOS])&MF)]_]).+V,2MQ7b63>]_5:Add_/cA>\[X@dF/F1GGO,:\f5f-R
QOI&G+^Xe4S<DSMX_4;QC.8N#V(c1OBV7?VY]8.ZcW(02MO^,&V/Ra;NSS<OZ+K1
7JBU#e@Z<,d[].1e_TBbG#79cKD1b?;I@J@Q/J:MFE78P@51W<W0cD67K];aZ+?d
I2/#3<D;AR=8gAc:<6^L1P7&,Q_f+cJ&C1?#b>g((41-6R#/LDM/Bfd<7Y75bZE<
\WbU3f-cJ<I07/I^X_F#g36YGE8P>;D,:VFZ=+;ZAKbOA7Xd68J@cJQ6f(VSDT7?
DHOaV40&-H[e06+68.(VU=9V]86J(Vg@OI3fTAeF4?QWYH3?-\I\cJHBTRUTNG]O
AbD>EP4BV>3]6BJ7)9fB[RKI.K@@I?#8>#4X\8;G9M&BLeBZ9@)X6ATMc@@^RdR2
QLZ^8:=<3B)Y)adVe:.?2ZM-;7J<24dJ0eF>K:PH4=0;C[@.,\,[bQe&CcM3PJOA
[JG5.g4T)I)ce,,_L1KJ2Y[>8CB&0&28cYVN:-,cWH==7b.FGSU\0cZB466Ac]+U
Y(?#0T-99;MO.T;?S/??Q=N6/1W/ZS<59V8D0&G[PMLETdW7OF,Cd4G=\Z.?D8W_
\K)2IB?<=J)2S>^-)T5NJ,Z1J:HUQ(+JZ\Hb3?[4SgF&]C)+S[J@c<@T;?AWQAVV
fX=WCa1Nc\3,>e2F\WBRa@AI@NP[f1)(?@W70M17fF]Wb+/1/#@aGCQ)\C4H_])9
P\HTb:818SY59)Gbf08#L>O/.-J@2(U_LS9fTMf/[TRcaEcLX?=/]YZ;ME-9K)a5
P/54ZUV<bUH>21@AK6fB)@>Ja^X+bb&J6\6R:MW4WXfG&]>/B//N]&#/4]TFMK2Q
6^b0FHa=3LI/^=1VV1YT<]45-S6?C<D+&=ZCH=/cF>c^JF][PEI;\eN@QF9@WV#>
cG+B69eZV)a/O5AR7WR^<CH,9XME[XEAe0[^\VK(BIT)&PCE_UUg>@_43PU1Yebb
;=gPLGDW<NXY#C]<X[A-O2fI(W&U#>(+M26DZe:Te8KK7//+gc?2LLP2[>gbCM#g
:W8EB8e^05UDDZ5Hfg?<D7TI&+SCW921?,PEWD1[BPfJN&[K]=Ke0]Vc_W-@TGd)
&,b/P>UZ(-M=d/SDLdK.D@IH6eSVMcPa:>R]Pb_HQ-KEGR/#;@V#c<Z@8W/1//FE
5.X:N:]MQJCKLQDU#c^bI64/1g4J[Dd/:\:J2ULLRA=b:)[FcO>I&e@8X7cEHDUS
:^g^.:]XS\cTeAMT-^;:Ng,#+T4.N25FV-U/^2A#8&LUcec>R-VE8PSf[K>.(32R
).3Y[4eYPVVQ6Lc;[)_V(V485Te-;06^E22;LJ5]P6)bH;3MW9S59I1E4eK#1\>U
/UO.V[a/(PE)KUY@(Q,Ra7=D3XfDDRa-GUTXG<ZUc.,0DM>)ZN7]#>bR,a:O2JRI
+HDIN\:S7S+9ZE=MX-5@90QG.gd@:^H\[-OTA^#JB;)7bQC]eQ(CQPWOXg^]2>\2
IXIID5UYZR30:SIWe9M:>-WA#d84BU:EbGIRdP@A;P2TX]\c045#P14b&&V7>a3@
V5d>8MgREaZPId&SHLY0_A_S>Kb;NH2Z,;]X]?WKUUdT[[:GH=K-9?\?6E2BJ9I?
b6c-cH&;JVeRRZEAM(;EMO_:+O(ZK8+>fCGG:bH3>71eBT3#Z^7/BH[D)=E0_?Y\
^NJR=?H=UZ&<ARUaV3@Nc]=/J.\eL@01BXX:6I^?A2[/7<Dd(.G40TKTc[GUR&1(
@b;,?eF8M#a/0.^02M3eU>g(2XB7^L6W?]IN4BJ&GcQ17d6465W2_WA@Z/<ZBM:P
g7(5?aCN#N(8LA8dYTQV-\FRES7WBCf7]0RM?fD#P_U@NB;DgI@SccbdMD3Xd@1V
/32IXG5;QY752eD)RUeg6BA>b:7]2NY,dCgIM799F=d0BZE4\g^Vd9g-6e3:FD3R
2L7O1=TC#O<[_REKb(GETP6^LREfCSUQ,;5PSP6DO5VD]+-g4ff_9,VD\CLI>D>Q
+1D(MGM[+AC\2/WUDSLZ_-Zd8QQ[_5.0+FT#.HbR>0U);4:^4BMZ);WL\MZf2@Dc
HfEgNNc-VS32QAG(1VH(#?G9JO4dTJ.8TF<XTNY,Z_@@]DSDFO\X(\7S,HAeD3+W
\FU;\5^F3g\LYGf&@[2G[]WHP>]_?C4R.fabPP9]N(0KWOLGKd]#E)9ZdKFSS-+/
JLK<BWRT\.^^?3C6:(KDL9:L8ZeMID\gCNLb8F)=0&VZV[=_2&9RcP,2+Xb.K>fO
V]4>P>N3;X\a.^Rb3.)7>DGXgR_.)0E]C+9BPcT54)a8021/\IT1<[8#7(-9d_1G
JfE?MZc[8I2M+bWK@JFeZYM(8L=1YCgP1Qf4f\0+[)ANJE.d:&f6;=NCMb:K@-<^
QD_D+G<:HW@Y,<7;19IT\N59Y]R#B;2.-2OJ<MP;0Y1([U6W25;Ab[ABNRV4[EAY
IWW(4TbUN(FbKNV-e,^eNQLRa[?SUTAH#U-WJ2SbO,-<IMCG<H<T?6[X@(25K31[
V8>f?Q4<1(6GH__+g#_9I8gXN_E1>D[9MV+D,;fN,J88O.OR[>/PN?1g^@9#_&9W
C8OR6+gH7bR\?D::XgAT6I(Vf39Nea7<2@U?-T.R2,#WH-&_MHMCY#.bO<Ld<+a\
\787):>3If/1:/bZ)(C@@c:Lc^7DN_A#-,/S.PS^EZ#-Q1OG7JZUSb&X&U>5Aa7>
Ag6Y=A?YBP>-@]\M89I&C0^;aKU69O)2/KfY-9,,1aJS:R84=;^4aFLM6@H>;ZQ_
>d8-[,OIE9Q0V:W]NDa@OBKK-6H9--/MD)^Q_RG,@2>\:[YT<<U8]&2D9WQA1\G;
MMEUId(Y0.7(ZVX?X-g6/:F.@)LBVA)U+Sfg)ZRA^D0a11,QG;M<VGg;+FM0f7[/
.1&??-be0,EHN6D[4U]C4e,/IM_6T<Y+f;?=0MC+_H+0R2C)_L1KPCC]&I)#dV6Q
@>>3F=)]3^L5LSMC8+IE7gPGg26A)I,)>9I)#bH@Ib@_AM:YN<dG&Ub4+Xc#/T=+
+EI;T?_L8A:#f6@Tge/<3/F.+<3OaF2OQ-;,55SHX:J-/]C9IAX#MQY=]GZ^c_[I
bLOUFgB@2RF1\cSda[Xc=db>dN\K5FH(Uf/169UELT1c=dbY66c8/cP)Pc7Rf&3G
#9M;54#VQAdX-Ne(#3.(bFR,dX4XZ]-Q<fZRGHS9g3aP3QQ,JcX4dfDXN27TO&fN
4(:(>KS)ZCUE)WTVEO37)JDa6,+c)=B\(5W]7R)G61^>KSeU@VMU:IG-Ld]<?]F<
K7J6;YZFe+Y\ISC=dR=LWMb6&[TeZ3a)c5V5)?CCZ:9C#TH@/B(bdeM-5.bZ#YMY
(9gP6<2cQ-]EU;[9J\QNB99Zd2JM4H0@Z&Ja0+[(W;@_H_1bAJB\:-e?I\WI@,<C
N112XeH1OaKW#_FO=9D09IcRFWdecO-#>RJ>Rd=Pcd)]LY@)Q4&+?<ISKSgL/QS_
+UHa0QfTRcD>[-JgM::NJ1:_&=5]O-e>;:R7Q0:;^X)f>65;;fWAOD\6?YDDTT^D
=?_U]:[5PgB0Y@\9._;9?.D=bL(EO?<fC9T1V[H5EDXa\:PM35(G(__QB-4PId_V
3\63Y#a:f=a9Xe_:#eO>8/+\RAeag3)1B-;D->9NPO:\T<B)N(aY&./C,@6Wbb3S
XL#XW#,V1+cN<B),H2]&X6&>;O5H^<5dJ8)7XQf?VA14N@D[VfDE;&#V(XD9FQ0b
LaWG_W]b&1/G;/7G6.]\8@LOe<PRb,GC.M4L@2:WAgeA]_J=H_b7YUgU,(C).74O
94g14DDf@IM6T4P6YUK1(?1:G34,13>=70Ca6PcIL3d7D1#T+K6>O-Gb_MVRL./b
V>_]Q7TcSbe=GH]KNBd+V6ccK,?RC=9aV[4fF?6DO?)(U2,N[(UNWKR+80_HB-E;
>9+]HU_]TLJQ;ZOL0Y7g2OC]RQ6-KA&/RH+[CY6GB5UK[LXg^:(,,Z\G+X2N,X@O
JX92aW(J&g2@;e;^4DNH)-ZJ+]&0=^,[1ca.1K8GUR<I6)gWFH)E5DOZ<F@1^=NM
P1K/XfCCCE#gY-J3NHL/#e&[7YHG4PT^16Z>E(0PA:S1).;fQUT:3?WKZ5)#36d1
61EDM36f8c/dBH3I#M2bU3d^([CZXZ_NOGN],I:,4K:=dM?J9O??<@91.Kb1C&#(
J@Y:KPD>Q:S]DOfVIf@872XaY9fF[bbfAWN]93.D;fbcQ6TYYADT6;O,cCXBbMQ;
UW=M((A8(NXNH\d,6<bS)OU8e/TZIF.?BA<1[E_#/FZOJeK5NgV0JZ7>8XSIb0@V
ag^:]/4OHUG#HaUUZ[dbH3,@KSX]\BN(PI_EeJ1#&VLb).<60>]7[]AGRJ^8C@XA
SJV43^AK7:JYI]+B<VF6\R&]M?,JV8e[I#I07<?RLEG?9X5U_FE]1R><bL+TJ]ZB
@EZOcCB-@/&.+Fc0R?O-b0XI?C^F8]6_?R>aO3NQ)3@\OG3Qa3cVfgc0,f6@73T?
-&Z\^&^<6bb(86ZZM>;AY-I3-D\c_^R_=:]g+Lb[aL5=R6Y3XVKaQEd)\NR60C:c
?YLO,2.OeE/1A(N,f&.a^Qg48,@5C8\2M+#_YK3L8QJM//^=aAB^gRX:+1HPM\<?
MF3G.Z/:IT#33_2fcU\BH/7-eJeIRbD6PLF])5><AH5YdN0X,FfTR/ZID=TC;9?e
F15(d;WXXf#&2e9#I;dS,aG+-N/8ZBa5-4>W9KIC#g.gZ[-W7QM2FJ].RGLd9\/9
QJ3:MR5P)c;RQEQZV/86#?-[2I33>41TU.Qcg6U<<>F4WKT.,E8OB4Ya)7Sf=._=
W.c)OL)IH5WJCJ/NVaT&I:K7T#F)@F)+PU=;5c@G<>d6]4Cb;ES-S.c;DAE>UYH)
-UZ#VabUV]gJKMcfaN5b(3a?C#M.&&@EIB-Q@^WXBZLD&L,O\2:ae()3.Ug^aZ?3
[OIS/@a@(+?5=8D/b8)a&PgLd.Z#QCHeOQ(V=dOD(BRPa)ISd6BFDRe;.ScXYgZ:
>[#^Fg0GdW9S:2Q(==K<SVT:L<g;08@32U7J5S#E8->V)PbKdKP6BST^L1IK:Z4O
Q8U^ZYcA:.73Y#7Y)VA/H>S6,TdHFN5((Q4A<M_QSOfK\=DB);0OWC.gHS:25OIE
[3QFd-AUTACKfA[0TdM;8DX@XV#fdO#DIf+0;6&5<G@e4CZV6a#&JQC#d2(dAZDE
Lc6WO5;(^+6E#DAV24>PU2C2E4WGRQ\Q(28#I>3]..-^O#S84S^&S5;UcbfL0DLb
Fb5J23AKKRg9_]eW_Ya)MXQ^E1.WR\7,=-C9KXRW9AB?Xe3DHY/PEG(U##7=9^9I
;V>8I#=_79Q9gAK.@e6PIYM[Bg>.dC5Aa,E2[a=-5/VYZC&,@^F#[)\1Va,GV)(P
]<O+FP?]AR=8]P]<U8HH7)cS9G5AMI1DP,2R?<[1A+Y#G/SJZY89e;\,E7XZE3Qg
89OM)F,dc2WO?+dS^^F16F@-:]c>B,TfHcF(;<M)R>TNaVL/Y]aV<c-1=L6J&g&U
>Sc9g5[OM^SV)1+JIN1&Z;ALf5EFb8g?J@>.gFg>#<=Ib4>G-Sf[.[<8,LHQ@@AN
#488KW6+9D.X4>;dZ2BDd_SA0NPL\=G4K:1I2=.^^5U1S9:<Cc[Y_HdEWc..b05,
FGbH;8dJeA0^.O\;HcSFU4_31VOJ\PJKA6f[X6,\_7_.:e?g/>N8&T:96=BW^JgA
XWbRN1d<)&21N=-b3-e5EKGIIV191ZF5=\PQQVD_-Id[]8MGc@5\#&MAF[@DQW<e
,S_(2I7>:G_XM\._54__VcG2=(gf@SD]5?f4Q=IEKHP_9L3=GL7OF1S^<YQ[Q1GV
NNb2gB8WfQ=)O>+LW2BXZbbS:g<&@2TQfE,PK;HF7a<\;LGbP#J3;MN>b)FVe>GY
N^7HcRTE40H>#E<11f.VN^(?(AY2[Y=,)7AF<S1[;#eg#7WG+<BA=6,E\2d562C4
7bM;G]]8d35J6P.\Q]S&0UVO@1E3.6>6JY0?;=L-=W0>&<[V:Y510f:;V5Q;()6#
FGFf9Wd9V0g(4aG+NaXKb)CQ#ZH<<c8T7fe7[Qb>1WXaOC8VecVH3QR16B\.LVIW
CbIe,[EG&SNP9SQM5^[,G]/e]#G#NOD49BMO3_J)Ja/1H=OB@>0#H6SOJKSTWSV#
7OeZ;Bb]MR0#d:9[0(GITd:fV\QO).0RY7ECE@P]17M:\HG3DTWD;YXVC+U<.LZb
ZSeU.:WDa9TdE?99HA<YI)2Z,g.-c4e]QEe@EKRP/KCG#@/N<7:FBK,C;Z\)79ad
bL]b.)JKeJ@f5VgGOH;Re@a/RN:+c)e.^F,C2.&0\X9/UJL]/@>d7GKBQL+9+PZE
\G4gSW3(9H/#MCKQO+J[2LgVR^5cEEBF^IIB@R#JQ()SW9ae#QPNIJ3=AWABfES0
=@,ae;<^V7>M,6N02_U9D^JJO-P2OD7\&9\6F>2I^O7b5WB1VE0]]?HW<F@GXNX&
P=g1#NM@c=bJU-VL#MXYD0T)X3>F;ZTXdS-43T-L7NXAOc;:B9=cF9L3E&fZKXK]
X6EW12&4LAG^A<<PG2.Q#Z^)dR?U(];)<34_EX:O8C;fdBT.dT6Q]DG78fdRM^=9
T12b@Tb+/>1_Uc0.<>:C0X_,d1WO0W-0K)2K(2@Y8L/ROf2^\&TXA6MIWdcHR_3+
1ZF#>7FM;PPa2_S^<;]W,bG,>^>M>?C3L-c;5=g_D9,1@5Y54;T#I.AL8X&ef+-&
,DWE9-XG\9P/GcOTZJ@;?\7_QZ@T9<T__H-[N,a-dOT;_a-;GAdgO7-(9_f#8G]f
0_W<.2X,]e7bbR?gL2Q=,KIg;Pa6+faVa#D<JKV()#WI1482,XN,3[<#82..G8BA
C7d]079N&U+X8R)H86?WNY&^7@/T&IN@AE4Xc82GK9(4,,2?4W6Y^2N0c5J9D;B]
NdB-/;LPcY@Qd@9:dE62C8cWW3g>e0ZF:>+L\1Q<2bQF:^RaI:KPeR5W[(aLg<])
f9U2f?QNCU1bLR+)B@-SY\8^0b1W&[=J>J8bO=JQ-+.Z13fX,=.V0_EP0MZI0c+=
<=.+N,FG.=:D+?_.(C&T@K>gL.>/1DYV#KFH415M/#:]-]JV5QgIYB5<aWF2?BfG
4]@Eg<O9D7IXaeW<=fK4RKZ8-N,<XTDUDE2L:615#6,^T+\YX69(??M5g;9D7@B_
dRb.]B5g^dFVPTY(9f#<L+TUcXO/MSRBQ^\RXWU>43T1V^EB2EJ2EX?134d66YOM
caH:>>-8-ZGG-71)d@^=A9+gIGJ>#TX>2VH-:C2RV;b?Y:M=KMa@H.@Cc=Fd]b5R
XZFb/dBX>X(8c:ZXMUY<XY(?V][GS?(K-S#/Q-eOQRD1A_<7)G1aCC4;e;E_Ta17
SG#,/R32L2fHG6#8>dB]b+_XJU,#CQX@Zb_I_6ObG)gUPN#LZ5.1Q:16d1?SCeL8
C\X_,,V0Z=;@2Cb.O3.BWU.5fO)?UeD[7N.=UVcBfS+e=b=MC0Q43V7g8:)X]N80
@FM4:g1Ga^3MQXdPT79;g#><K28+9e#_XCIaKKIbEGc)Y[&^VbXTeI=_Q&3C2^Ef
Y.9=A\W3)geIN:C_P5QB&HaDB/>A&4cS,_A\,R;+]fV;B&BC_D-@I6G/I^U[R&JQ
J4f-&K&dG[ZfT,Xe18[4H7-/QGKRA=)F#@^^KQ4(SP2@Sd;DWa@+EIPU:aQ7?O#-
g4LCC.P^LX1,)#f79^NI2c=<H):8;\9#(Dg1I)UMdM(fW5MTL(R,UDDgcX3LI)/N
(X<)?WSKD(1c=g>d-@PJ26bB-46ICXO&Zd4P1^_PIT5GV9L5eMNB_?U:@aGcYB?B
+e&_eRM6_;89cJ:3/Y;bg.b_T(AdaMH.0GfSTBX2be:\&,,g25:Q.KGf.JMYUEJ.
61&HO+HA.R^)F7:G?M+Qb7[#Tg65D[(dGZWB;b[?O9AB#=IX\D=>-G)\D;X:)#Zc
\TfV,#A39?\(da/XPM(P5/7^c,1FEM^[D^DZ2XCG-Z&6a35O/L+9L8&.C3YMK501
W<5W1GMN-/)aUfd/eK44(d9>\E^\9cUY3V?RVKIeeRJL<KW1G#PLJ,IWX[+>,T@d
N^Ec1LAB2g+V<=+3KTU)W.R\VLDPC+eJU7_(I>:_c[D\f;B]6DESBY<6K,O6U4d)
8L36<?F&82S@,Z6K+#Xc+9eW9#]K^dL;X^73V?LHUCa9DIKQ-@MeWX_RGKYb#AM6
&-\Z+Nf:F=fV.1J8@Q8E,O^FT3,^b(QW6KEY_)/ZF-DH;>b9C,,]MeT\AM>#@T#C
58),Dg.+C;B8(Q(9-JB5e(KLN3(SXJgc89ZY0GO7(H<WC3278F#(HQ\O@+C;?&QD
OTc>NWeQV3=_W;DV/A;=70O>K8J4Hc-WXZR0H-Q/E9B,c2caSgRRY),#B6WSOL(U
BRd>.YJ_e_K[/8IDQOQ=X(>5>g19;:S./47a_LOSH@f5HcL/UMZCF;<bQ-58-(TM
1BX(81;9_10:dRN-\U[DY8U[_Ra#Nf?1/WGT(A]-MU7KK9Acf)=Q=cX_8=9DJ?,)
NHPEH+MSe6C>VIZ:]\NF4@W.HGB=48S)NF5G--e&ARTf.I,Jc.L23^H^QPIZO9eL
,D)R?FPd8TgMaIW60&K+LEa8_80b4]ALD_;;4A7Ue;\YV0_/>\1b-@gZ<1IV<&7^
(NGAA(^f91=NWVIXZCf5>@4(\FU-52-WC.Z(1BOM:>ZO?(Y&MPF93d<(&=-0S<)9
77?8S,OALOa3+g;+R_[bIL0,0@,MPZSU+A;AH@@^Y5AP1AVdCf^T//YdUBO8AM,c
S8a[bcdANDC#>JS>6N&U_]&??X,R.OTXgWL#7>AA5J>B8e/@Cd^QbXH.H#ab@d_U
+O3JEXgH3e8@SROZ7K\9[fb(AN9WZ@c@^J3.6Pf)<3E.8LZSJYD9K;XbQUaO>Y;\
[Y_?C,:#3M@aI:,-fYZMKGQ8@aDK2>OKF(;X7F;U;g_53Fd)8VS,.TffLJJU-Xbc
OOK;,-RfC2I@e6P+8eHX[[282M?QJgbR=_=5+ECHbV2B+H9Z;O2e?M2(8NgEd4MD
W9NI^>APW1=H(2;2NP-VdN/JN;/72bVN]C1;7XO@Wg9(WS+QVTg<:]aQ&)PfAK<_
1]/gZ/A?5+DGYC3.LaaSF+O@(:cV?RLe0O7c_-:WO2KaW_N@d,TH60B/WV^KbHg2
S6@IJeMY#A^a:0[#<Oe+44@+L?TT[C^Y61V;Hd@9/4[3D<VS_9Q@#5S9P/(ff#<9
^>R\e>/):GbX/<R+VT8<OLPO1,Z=):#\LX-c6M62YZ86]61ASFD+b6g-X?L7A+IY
&H8-<&RL22/0O4dG-(;JEc_QCea6-M1B01XGK/0/QT2??83#]U8>J(B@L/T611;7
&^7W[?U,=JY:F]U2>de8B8C0<QcE&.bOc=J1c)]79W/S_S-6-HdZbb=++9F/?.4H
K/Y/>KY-#)L\7+]Q\/OD^1K)B[(-dc\6?#S7-<QT@)Zc7aE.OQ[B3cFHdKb?+,\_
Z31Jd=.dO)8T4XVK3#_O;S2@FEZ(HDC<5:E3GE-EG(FALNJ\cM,MI:c[06LO(R??
Z-CU(2F5=@=bTASY\@f;GWU7.)C5\>.^/=dT1Z-c.II9+9\]g9#[TF.QfXPf5DQ#
g-B@J,c)&CE&)JES[C?MO--/R@O>^-d.=EZ;G\<Q2^_^e>)a0R?aY6b#]XE-OH92
PH6<#a]I?gTC0I1W.1LUH\6T9f^[ZOc6a<SXIU-\[7DP&Y@:+HGY0RE;>f_I^K4W
gRSY<-@,cb\\6)BE0RaDP?#XeDIa0.7L^5eFHPg^,9\\ca).^3.YXCf\=g#bY<,8
DgRb4,052CRLJNVVdKe),],.@V:V-G-K3HFe[\)3:F^SLPPM5JMK>>&._YRBHQd-
:SaC16aM,A]:RK+F??DaAR-(^?A(51ZY,FKKbKC]c@FZ2ID7YM)::YX2>((>Q8>L
C;,)eAZV0bc&X?g80^f<M\OOL&O3bbRCI.\TeVO4.7,-5R#3VB:IdJd0NFa^g102
TCX51(ABWD./Qc/\>FV:165XRg7bW)VYG1^FI?76SI.^N_T.P;7FH\f^SH,N1)Ig
UO^gIC-d+=7?H)=D5_;KMVbX[U3[Z(fYAZ>UVU_QTdQE4?R@^Rg\fe,LPB9RdB7>
@+EF#1d2UL-2)6\#1d[#E;[^3bWPASN_d(LcX43P]-]E<SbZ7FZb)aYQeY^DeYTV
(b.a(IC(b^);3WB8I\B2;-@g8DJ_Q]&a[:.R+@PJ)fFKed3Y(EZ=^YHI_dbOYM]S
(?MD\aE<3[1MYUV^VKBRI(TeAeOD1<EQgEcZIZDRgL3UK]D]KW_5(A1J\[c.ZLX6
I&H6.6M&Se]@UA740<GJ[Cg/^/0fN@26Oea3N\1S>RW.)P[6)J:BbTX#VUF1(,?8
a)].AD/J,F-e0GKSc-8,ZT<:D9M3-e/6Oe9\@PQ?\dFE#YU:N,Qd<BROL00].Q)T
0F]b](QX#S[Ze,#WX732McD:48G<SU.Re_H>eZfeBWA5(N?9Y;DE:M.0B^E3Z7Y?
4dEO)6\I8:],,YA4f4SO]FJDRQ5M1W[ZDGCMgHA\K)7QG1YN)7ICd]^bT(YWK8-9
G1ZE_BC9P<CPf>,6#7/@8f.Eda3DcA>4FNX<6]_a-#ce^&f1ANFQ0#E\YQ8gYRb&
D13F)[\eTc;H4WA@-DHQ6F=Fe.D^B&2-3APb-fFPS<@gUP2,Q>PO@3(P\dTJFZ3/
5D/X\J/,>A)Q^f5ZX-??c21V>XgA0CGB-EWX[KWEC[OEGfF:-_N,>C<@ZDBR<(dN
9-+/eM2#&RICOfS_AI/ZeMD>JKHfXVUHO;aN+ge(9^YN4XZT([;.YaCZWR32M+-V
(U^5UGL6A)-2.g[5Q?=dODWT7AI]V\X=3GLE.[VH-#gUI:>[ea@.XR@N)4H4cBAA
8<Q6-e=ANaFf0L<26TJL]J(>)C?(+N68>A8_\31JSL&e9C]Ga@D-9LCSJA:Q)QFV
X9>HX9KV];<M&#@gL=I&Rb?)F/?T[9:=F.cc+;J[@82g>>/U14W?PW]-:T,?W8MW
OdJ)^C[X&[DOC4Ccb,.Ub\PFI5<C>eBfLK@06GMACTVW,eUC=I>6RH0HO>Z2)I6W
5Qa5X,&^@B:(F<E=DeX==NXU0H5O_E5aOKVG1B/V=#0WTUH[;VSZ&IV^Rad?D)67
\c8;_LX6[HY3G#NA7#cS?-R;a6fAc6)Q9OUD4C6UUcQ-\9E[P(?;RE]\JD9(P19c
>O4X3beSQJ=)D0_29Q5+#WC)\JTY@?Q=DWcZ9fYCaaO0XEd15Z&><cZd4c>[L&F9
E\<2KNBO4+4RJ<HbFAIMM@;+H)AAWJF.QQ[C38]DJY>,9FH5B^TQ0@+\2a5086<d
@?OYXA#T]24DIZLKM]JV/Me?XD63-e-ff-75Je,T7^cBg/-]FA:T6L[:d7F7;g]3
K7\FTXg6Kcb/&[Q7bG>]BHQE;MbDLYa1T-)Ne;TRC)46[,#,aE@1f=;[;(E<5:..
<LVERH)9B_@)[QFR3+\R)]\V?d+B-6@R6=\#OE6b.a2C-d^W,U8P6AVT+?[]UIP\
-489#SP:\24eKY22UN@_eU_aR@KfPV14NSOVgIJ>:[&MgW3JH_IIU06NK-,^5JGd
GKNG.7VX>60-?XIZ--?T+H0U)H&YY(5eK??F3)DZ2_KF>J]>c6T926&+(:Ha6YM.
J0+],dC+(-Be(T+\PT7+6&R)[PT?90R_-+FO?:eS._3..@+_SV\c_MKf32T4\S)8
CYV<g0F=Ie2F;gAc6,?&5^BMT\T2J@V6/#Nc5M0DC-RbKZHCA[[J&T-7cCeG-dgK
Kd1(7c@]^NPG-5dYY#HXdLW:gYCc,2]:H2X)\BT.ed]Ad32(T?JQX22.;&ULef)X
6RY54/a)gRLJ1XG0[9_2IOJY#e\(#6A3G:5IfLRWUK<^cIUP]8e2K>.ZA5,Y]Z;c
1I;0PY>2I,;VII7HELT(W[E[H;>X(Kc(;03YN7XI,d;R+^+>+5C#4I[HVeeRH1-G
N.BMQ0._;QYIf:aRV804A?LFAY1UPM<;O3cIN&LDU)a93E)3K@&bbgBZQ4dR<T\)
E\.RQ2Bf_90b7Sa4KX=42_5]^_IXX@HVH]TGCW@M>V^=;>fVKA5)\7MNLVR,,W0#
KdaegX@Z12>0VQRRQ/KDX,SJLI[Cb-f1X3H6)YgRaV#RMG]@I@K&cKHYR_)6/@:d
?YSH=(E8JQJK>&,I7Z3e2(N:d5::1DD_)_L5&<M/3WW^0=.U?HaK/I@?,C5,ELM9
U1O_&g]).:eOCV@8930;\;2Fgb52QW1aa:>Sd(;d<,_5VS1TY2RBI7IJ](739PQc
-NHNK[-)&gGO_VA]g;ZCMA0g__#I6NbCEP4,?cT(N&[8H68NgE]=e^EEa=+4[2f1
-E#RD+cXU)dHBH&7IEd(7cZd[Gg^@[+aJNag.7FBJJ[74F7\dfO_1#N=dPOa(4.^
6d1-[c&Y);+U:78#0FBW0D;C)f,(;>1,ZNI,MUGD3EOPd?81A/OPY]b3\\fFYWe^
H\a)(TODaU0K=H77aK5.7@Ya0YgI>B:-Nc6XD@?6719PJEQ6FC@b(GJ<W(3RF7V^
-&_7XJB>-b)=Bc72b:SIV9eL@Le10H0/UA>UDZ:;:,(+D&PZO)6Z=-YG=1H)Ge(H
UTd22TD/J<C/;AP6(B-FaL3\J3a5W+:^B;(\CS8SRcOI6N#&/XISR>,\KE]>-#P-
>9a7W@9I-U_\T>M4JQI]gP?=->dB(6ea+#LL\<Q9aZ^AU=+06I)CVfEL^Kc&8e9.
BJP+@0:H[e_+IX#&DB?U,QC^A98^TWe0.D&^-(+EYN9^e,cGHc1#3MB2\S3,=6EH
U;La1T7IS0I\=12@/YJ+I:^:.:?CQ^QJ47O__g7(aK6<7bf[@M8S6RCUI-88FOag
F^e/;_e@Z/=CJ9?1E5>a&;5KLSH2SV._ZJSZRHX_GcQg-KY):S9;A^2/]K3^CI,3
QVa#N#a4@g<8S[W<??3A<=dEMg4HD;BbNG(4()INX7/M?cCJg?6F66F1#R1Y+Z]R
aI2(@B<E7dHS?6c-THR?KE(\<db,CQST]b^Q(\X\?JRXg;#\H.R1+JCFR?_&6Ff&
g@.61/CHRWIcdK3X.g>0XePg/GL[SF(BaD?C\\?Te7P>g?\4@X[EQ2>8^Ya/7=+^
N1,F&2_Adf)252L2CeQ,\S)-:6BJ]>aFYJ<\LW(;MW5Ha@P=(C=02cB4G/)Bfa-6
@KNT)9UCaB(.\Q6T>3)U/IgZV@ZCG8BV4?b?ZaVRS?[Bf:H:6R,?&eIZ-.L]ZU+&
+e-I15e?++gRMTc?B\RP2O+>]9(M(3PBZD@<Y-#RM]PQfXZ1)68Y::)b7.W\@:#S
VBD:<S]]:Y>CSI60<cd&]dae-0C[IX_<;IJ>CH=#]I_1]>e>#HC2^9ELU;W6+A9\
W,HQb<2M[#PS[bdbDZ2K;/e_c-<FV5Z26a<UPJ;3Uec5cU@N@=<Qf<PRL_UZ0\6]
Z;f@eBb(:T+BR&Ff9_F63^>70a0=I&X;WVRL,a^^E49J=DT60VG\8#UL\^B.ALOd
ZQ0d;Hbg2ZgQCeYb]97<X[JVb2d)=g^G]NFJ@T/;E@&_AY8J[d:J-5QE8MPVQ)FJ
)<K=NdM@gDf+Zg/?V9;FfUO1.7B@Z9&6=/[NEeIHca?Ja=>gf;7TPF6e,-N@5EHX
Jf5eefS/3(.JF.,OF^>B1/2:L0B9SJIJ^AdZ_D-aCG#ZZ^IZ.cM(48aNO0WbF1fP
42PK]E>)GR?2.DI+KO+G)dQZ=0+^^&.VN2M7@8aEEPTM171I_7EJYgJ[X,g>Z1T1
<#RJ645#U;SU;507cRA:_A_>AcY-B\GIMKVH)>,U)HF,]F>6_(]05EW:O4:_H)^^
2]B\9(E5B2e4bT837a[ZMe>YX:cXT[=4HJTbX.)=#9?#f-HI(eJ^a)DCIWcOSL#[
#.4/DZ7/YHeN]W>d-K&YIc;>M6AM(\OEL645GT6?-R.21Z]F8X:N>H]C5NYBBAQD
gRL.-0Od(O#bY#QU./WPX33WG:5Q6I3X+4TJ-C]f_C82A=O(I5-g\<T7,?+Z@K]g
208NNKE,:Ig].C5ZUfV+GD[Q6C1(c0YKTQRH:-:/Y;J<T5XHM7H-ZB11gB.6Te?N
BHb)_cQ1@U:7HN@[/>I=eZ8P]]X>M73]0\_D8Z[L0([-0DN<P+A:fLH=CMf<2OGH
X3XAYSP_9SA#NN3cW=7CU/[S]c);<RRQe7Dg<M^6=T4Me<,2B1@DZ28_PC_5dfIY
;6P)O;MEe4N@G_,?V&KJeV5<F5cX#3\/RQ14OS_PX7F;PH#7.cD>I?DOPAVDODW-
&V9;Tf-f)HR\.AH84G:UPM8O<<6ggfA9C_G5M6_U>b5WcG/dZH/&N&/Z)3?^c7R/
^BbUS38+J=8[4#d-7_E1K1cgWPVG_K:ORW=(&<J>Z&<fFf4[>??FYPH6fZd@DbL_
/7LZ6^22<(LgK29BU3-Ub#&KUJb7T(5KOY[I.5&P)2&1\<Wae9Yb=BM.,VDBS^,0
T-/QS7eY?-3cQI?8\UF(eN:BXX=gCD3[5gK@8A(d,Y[&7@QeT,6;g@C=FH#g^2E9
gI+JDPHb3AFa)9d:P>A.+N2ZHcC4<-03Q/@5HZSXLUH6@X<f9@CPD?TK]N]>@61U
1_If2[5AcZ31CeX)bJ<BR.S[ZU&g^W+-<V3QQD/e=O(.ZI9d+8(YZR/=_)]=0+dB
D_S1EL/B\=JA)J/#+K/VRWagSBK7AcE24R1LeH;dY>SL5V2:D\OUJb_Q<[YT&_WU
SPa=ec^XUADGd]:?0,EK(B[.AaX9gL=@#/K<T:U0M]3NWQGNU(Pef6-\dT7+X9,#
])85PO6T@FD?MF5)&02BP?=Cg@M[I)NUOZe[AWK,]<5:]Q7&B+>J,&7eET1,E?b_
O_E3>=b\ZXWRX[8eTc>D)9@^4Gf>)\6f<W^c2>S3^VTCLM8/dF27)?(+ag-<<=[L
)YKbA#&W9>g#W>,F1OY0#^a5KdV&_,@LJ@a7CW?cTZD>g.T@<f]>DR3NCXA\9&;^
&11NG]E)HFaWL8RMUPbD@f><g2eTNVeH2BZ[CC,)HGJ+dL/X0R)P]IOAga=e8[[Y
b7f(BP0DbI[3)/fJN])9TH=a[JH)1<A[fa&=RJ/N9K:2cEKN:\6;RXH<C4OF8?EY
-MVVe6D&eCPDZC9L8b8,A68V0F?Dc)9QfgeUg8/.51R+6g:+H>X(BU/,O]6f62:C
E=F3F+NN(1c;<aT)93-PBB,:]@U\-UT,/(<A]\O=3#IOdU[AYW;J_YM6R89DF.e)
<URAa6<//4D5(W+QSEHJ);R5#RH(KVB02LTK9@OZ\HMb[0bF(N7GZ8I&4>G?3X99
MgJNQ.2N+K<>D1T@N@G(UM7f=&\>BV<S#S-Ee#ZMeP3f\)B]X41LN8V4JF=-7P_C
f]WOG6K9P?1Q+ccCP1eWGN9egXBc>gEYIY&TG+Y^:gTEO=G&IYG]aXXI?72DXT>9
f,D&BLL3#40Gf9,TI7[3G1)Q^V<QX)5K]A2\6J@+;BYKcHMHIYfG([N0A]PJ>4d,
<E?6<D)+W-4-QM4F4Vg/X?FG@L#?f[4d4[;C&,O;?7QMEL..X6=JC0Gc1?D.8H0.
MU;DeE)>fNSd,=gSJ^A7U2J,:OJcS]f-fE/S7?d/#E<?.^fMe#5D;I+da+eTO59J
Df5,?H[C==A?];fDLM^_PDTAcZe)75AcHAHE)O2.XTS:C6b1X4I/L\U/0cEAbf&#
8beVf<P:e&J/IAFK==A#1TUT8SC-?,/?Z7dN0LT@YK\0Y5QH#K7g[@&./2bL#.T-
6=KD4B+2(8I[.9>70D0GH/NcJXT7>4#PBUa4JW.ff(^bf-K\a6J1VbV<AaEZDKT)
/TX=fBT>)g7>CG_@fP:S\ENTX,(K\WXZSeC.d;N,)X&EC?GENg-E=.0W6K<=N0gM
R8IWE\^CR.-e(._CX-5V[LT#VPHcAR5ZZ;]ZfJ17bF7V<7b0X^d^+1_;,7S+N1g[
-_V+X(4DBY]R5&F7#58TS8Z]bNOMg?&F7HH2<(^3<eE>U]?T/9C#O=YeW6TU,J^C
?ZH=1I5a6#(a@7,ZbPJ6SD^9I:NN3[e0UV#BQf,F+8LJ0=7LF-I\>U2b:W:RVLS;
)1WLXbC_W@)?MXEQAD@TZ4K;,AQGFc^#CK;D,=S]/]\&WVFaS]c)7Q@O<Q4Cc,D.
3&B(XHF3\&;eD6\57T/H-Gba1[4fBHJ\J?3:>6eYfZ77g@c9TC5,-,-@K9Ka6M,Y
6A@+g8A_TTBaMb3bZ])OTWDg__aAM_X0b\Z>JU](W\bUD-YWH?b1e1GOSE#//6EN
SIZUFRg[10C5:2;aTNZ:\QcT2C8LI)XRT7+VPLReM:I\N3Y.Ma7M__7?;AI/1[f_
L/4F#=-VB#NfO_>AWD^S956W&<-7^1F)9[a@F4IK-DaG:T<>LLI/g#S,T/]90&Sb
:AcgY2fQCNFM)E@-2[HHfFUMCZ7<)\^3)cP?TVB=7;C.1H6d\_a]_(Z2\Dc<GE<U
_]2f@7>[@cZNJEbV/;18(K8R?7OE1FH=V3_]fdQCY[dY?1a0\Ec])0LMMEP1L?eL
O@Q+H>21UeY&6Y:PJ+#0/8)IC?FM:,S[4>SZ>#ZYFG/Re&5a#F@UI5LU(-BS;?e=
O8I3Zc7,IR@XNM0127AVTWc=J0O(H]3(;e/dcJ228SHHQOJ7AYM7?M^9bBY<DT-A
2CRDIC&d_I1fb;6d<69M)&G_e^V:C/[e>ZM@R)RYP^=302Ec5Z@@BO6JDB3G\Nf<
@&R^>TI[C9_,cM#Y,R&H.P>DG^56KZ?+dP1C\eFeX-c:U/M-(OZ4_3aMCdK?,I?e
8\+3:YC=6BQ&b/_-IX>V5#I0\]g-7f[3D;SN&Z0U0@@?\+CC_?QP]&TUc/#9L[DY
?\R3e;R6bSdE9H)c::5G^=3(350@,U+2)c<LMJ\P=.[CgL]6T.eBG5>4B2&CTDa1
<c]D[HWe>.O>W@e&69SVS\FBPX-.?gO^W2P;6)bMG;@:,Q8:=a5&199fB?W_QgJe
)Z/,=/<>()TCcN/Ug,QUBSAEg_6Dc&5NQ2YNIJF(.2^e6,C7-&(-4@He\)U4e8JL
XR<OO)/FegSFQPGF&135_gRLc)=YRB3&bOAe.[VHc4&;e;e-G8>PMQ@^<&gF#eNJ
N3;.6?4;#Y)A1^E9b4Zc[fV&7#&\G,6FBQBCZQ#Wcc,Tb=+,bI[8OP(JCVDXC6aT
:/W^\1Q)DJ=&:g]LPC^f[8^F.DWY=\YcIc]6YX=NZR@--)C+:f?_D5X.<gSECUXT
72E#^7HQ9@W33Z_M[L1Y0-)#Z+D[O7_-c4V/\AH9+BTEFC@@e<4=5@fQD;OJ[;GA
E&IS)O,,TE8/W)ZEBKV]R4^@M@@WC6WW4e]I1O7#_g_g2#ZUS)3,1_0a5REM6:^#
35C0L_TZ/#QL#HET0<:T91G6cPLEHQ/cHQ5LCP<;\K95c]g,=[Q<&ITJGb#=+.a2
:>&VZYWIKdZAV+BcQYMO.(J@F+C;#<G_:IL5P^3JNaV826Ue<_22.@\V61439F(A
SE[^8LbCJ:RD0KJWeMB^f=)(+@).6eY3cWRNbUWQ94QX#3W,8dGdX]R11T_c.Kb4
5Na#5E-5LJ:bSU)CQOf7W<cNRJKU7d]#F-#cU<N65[WV4Cc^.gD@Y/JW;Z-Z\7@?
IMS=O>?FeE8dSd2R5R][egaM4J(G]>]^@N@C1US,OG.GIQPQ>W2Yd;O>/Oa,Y-K1
UeE0L._2:E/Y3V4=Z+(OR6=2IgO<[2)N9[EEce<54bKB8F-c[]P1H.GK59\UaBcE
I&e2MI.ELT)A2Yd?>A_.1<@;)Q-#_M?B#AOMM_97F<_E^L:T6[f?<RX,;K]FNOf#
DYM_257#DEV_K?N_B40cNdEPLc2DR6D[6><MdESUV\2&W(PJFL@=KA3CGNQ5:+eN
(-.TY0^5M8e2P6R2=0,@N-JQSQLB#3,]F3fS3M9\4JGD2LDfSL#K:68M7?NW-MHS
DI06R:?::<WB:[V8]_5A,(=4FNM1Oe<J9R;J>M;CYYP4NC1=E^TMg3S7J(;-?K5f
c8JNZU8\>>6FP)(OK;ZV;a9_b-0SA_&-8V?3/)S.OUgMY/=CQ+6#)014>ECbg,-S
V.18_c2(R@UQ_TB<H[M[CeEPKB-4T)ed1:,DG+@?J-V<XWaVB?cb^@R49:Y#5NL3
00d<#\/HE8cY5U337?R,K-c-.LDX?RMH.AN\@4>04C-4S;Z\(E./E-9W:&WQ=+Vd
gLJ\88\dB[1DN>,(MCO/gZU96U=e8CXPSQce9ZQLgReWbM,83fX>,-Y23ZLdE)Ec
g6?7=]VRg@^]747@OX&[\=6)GRH_VgE/Y@:OdY60b^3I?B5HJaXccJXXQG1Aec,U
)<]>>gZf\]+=\\/@6TeCQT[O+=Y.K@MIQeSHV/<c),+fV.7[^)])dNDJQ40)=+.<
IJ\f.EG\+&3?VUVELSbABfD.Q417SL_/_6KT)-SgH0Z4\ZB0S8&Z1]4L@2:][MY>
b>dOc]Q>2d^[SL6&77AH:H8+X2CIVJ8V0.V)HF-]fBSD:gE??=PT&-4Z[B=f_QSO
X7OccQVH,&>S16bX<BU\RVMbbN&V]37[9+.4/2Y;T:_B>eP:7ADb3.4dU1JM5[T9
0B=JB67RE.A6RU2a?g+L,_<N,@MY#I^\#2X<3bPaPNBIDB^<64[WYGWD3]JdcOIM
O_(&DVPaDeZ#KE>WYP&]?HC?W@+XC,M54^]#c=Sf<2T]=ZE+KN:<&G^+J2#RV&?:
Q+DJc\_J=@);SBWaNcAe)aK)GHQZ6KK:4G8PYKd?CJN.^2F(,Xd@ODQY+b99_H#)
e\J=1,#M#)U>QB&D<#aF:]2;P6/_15c/c]Z5)#XV8#cNReDQ.@fVF\=Y@T<IYE,_
YG?WWKEAWC51c<NNLR&(4RI3c+O8W.SF>d<]c3\&De3OY>1UT-5?_#I^,N.6#.>J
<,L9VGZ)?7)@X0bBOf&Kg/^.;fM;RS=T4-RBdW[\2V<.(aKC9Y=fZYaNd=^VM@(3
N^#;DINOC3A+7FGO&+geFcB/?eg?Ve<6N]:d:P^:e[0=6bM\ZDG0N735]IT>e0c8
3V^+Q<RMK>Tg8aJRLgJ\BMMUIVZ2YL:Ac,P4g&U(?NA]\UFNF<28@485)XU<#923
[X:Q_Pg<DF;UGagc=LKd\/P7V+0Y-225Y,<LBfbQU_-G\ESK(7-gE].N-NF&:[0.
0#Y]EK>I39&g:X4Fg)542[B7WTX98B><9X.9]J;4?(7-3K61133b]<&]E:3AU+2U
_f@/1)J+HCO[JaG<M3e@g3\D=)R1J:36+XA[^Y=NOWe>L-)aZ8]>6g(aVQVdN,GJ
B6^.>2BA<#)#DP/QE0&WSXUA?C6N9)9SCf-WR9FDFNRc58:C7&[0G369=d5F@BX^
NN<Od)4b2S=@KTXW-&G-O)@^<+Ugb4O#.(6I=TJ?#ID:[6]U,bJT2BX6QZb._L_0
#4FV8DJ[Hc5),d+5;8O5K76_LX_O@0&8RF);Pe,VS,1e#Ae.UW1:H(#JW@.=R\K=
,X3;9L.(:e?YMbCJg&bW?-L5OU+E/,YC+#XP6X,3?_[:g6&>X<+DNXI)(3e]#X)J
B=,(&P/TP^f>F3MH=[+U;]TbYM[RNJ3&L9L3NX;#L)SGE;IIOVZFUbZ_>6S?:OSW
a,K]&6JH7=E:a/S]A:@H?fL3).=#UV=10YTVa[JU]?\7V_cL2KSP02@K#]8FNY->
<98-4,3)]U21AF:_@8PWY]VE0R9;1R0)DCP+>?Q>?(cXCG;eVe9#1cU#fQ<J@W7Y
G9B-^J#CQ2(@[SG@@62]</0X17Vg)gWA?@(&)>A8c0QQ7@_HO)_BO)S>0W[TI/V-
SH=YMcR:+A[6(WK3M=\9Jg(>4c(:LLA_=\^G(KQJG+8#0b-Y>b,2U<_H[YBRZ)5T
ILbX(.E)XW[#3?5aF7g4A[/U4K#(\GYY16[@8#:WS=7fbS]>D&8Qa1C(+9:_G4D+
H2.7J/PgSDM,.GBUBO]5AV.FTY2?4H)+#]7)^(7MP^bG6:24:Q;gBgVGD7XK\ZJ;
gRg^J:eFQPKK@/:^(a.EL_(ga:M:b#5C(=6,X,9.+7feRU_9a]A8WCZ:/:H32#T1
0OWGe3-AWDURO+e(F14cgFf6de4eYcb<+/74U8GUJ_;8b(H4G@G,eFRX[#VM?P]4
+N,_Z=b?ME[P27P,@BLfQ]]C?Y;GU?aYY_XbR;eGQg_=bC_=)KUZCRF0+8@/g+53
#&_984-B1U=1663&/,(??R.@.UHX79d-@O7EHgH))56+TI-83L(OUg@G?Dc2H;W<
e].e(^YBF+EC^7I/e.S3)4^/e=cZA&9XHKWL?+Df-,-<I;:\TDd@K>GL2>IF-]RT
\KWBW;-JC86<D:g]^(2Y?5/),SF6/df@>\(g#c<d/^3dUERZY68,+I7M/<Tef9A0
&:EUe[]T,be]2HCP./,ECK7_,DNf)@g=dONfD]N/>UefU9W>(&e8)?TJeEF^[ZIZ
=_DW=Ff@S.-Z8[3X;U1X2eQ-_7&C]=A-)[A-gJFNe66IA6dS6IIVRRUO-aC/A);>
LRFU5YKBbYZMH7Ufb:T;WJ<V(5<cQdY)(YH.@3-#M6;Sf\dPde)YRa_:CBYW3LcV
&WHZ<<1^-S48\CPX=YR4#]@_fH7J=0WR-OH\J,UNIR6BGQW]O[I3Mb53]7R:)Re.
P5)YJHV?<LIIQ;:HFRGDb=^:9DdM=;_F^V;UR@X+:(PMb3V;62XbJI\a-:O]FMf#
P/]3R,R:@R4><\UUcM^M(Hc,0Y<+VI,L-&@,^?Yfg4]R5><[6A?#\OMeaEA@7&6E
2Q3H8XaBOX>#ONJ0?_48N[L[6J?>b?</HFfU#?>E1(H6\J](Q2=VBBd7@SP]J-9W
A9e0CU]-eUOGWT1XHb_D.&b-]EV<Mf-/D8fc64>&#G:,#(ATO8)M&Z^0H/27OVg5
.03XKc(Ra@gfIZL:UQMFDc;:f,PdJ:?\#6QQbYQ1fT#(M\VeM97_H0A>O@P37)B+
65-AYfbE8.fD@+;6CU(JX#.aYc4&NLa^\]K;X-5KC8P^2,8@#PJ,H[+NOgD>5)?M
PKM8OO9Xd2CD7F]\QW,?+QQ)@#7-U.KZQS]4GRB\2).5SM@=\f]6,L>.L^;dQ1Ff
Rb6B>BLe<ga^\QfM-6P[-<@QVR7DOLf_O^.6+)D-bJ_DV.g1SeW3;eP.PL[<GSQE
)LHUEYP+3X?A_.R0?_]V?+I8CB.O11Mc_SM+9HTf^\f@51]FgYd8(S0\A1Z3XaUE
bDd33B8&S#H6DT+Q6H00PKV>f+4NX_XUVgHeZ^5AV=Y<T\>BG\Wf]dYQ-]0+(U=S
J0O,U2GK.8P_DIZ.L#Ed+#P&-H6-A,,dUaIc&B>X[4AZWFZGO=YX]3SU.2LXg6UW
3HceWJYUN2P=<TUNV51eN?+/\<IB.MH8Yg9WAdFLD)U@#HYE_7QTNG-QR](@[\&8
6WW&>C6bTJ&2SG_N21Ye#gd7VBIe.FCR>YdW2EXf5,RZ<[GaEgJRR5;^GgPId;?,
(-JWN9I>X/<3=:(XOI56I0Ce.3d][+e[^0T_[\;c]g^.e?G1P:\??NL=LX3a)<7b
#@[A5=V)O)2]N_Pcd4\C9(C923KJWdOX/f@Qd,g5UCXTC<K(;[&c/f2,5CMZ^#H/
&X1fKe^fC^K;OBRXP6?B0IfTcH#-SO;Yg_)V;YX_S1KV3gA1\c&F[,?^96W-PK)>
\1g&46^]?2c)OIgZ/S;MYZSbYNOR?^^SA9a613L+<@S]=?V]_gPLA,g&WD-BGDXJ
Z5]SY^;WgL;cgC1bd\B?S)4Ha[I-a#03-2JWFE8a#GcIb/Lc&4[-#J[IW#QHaB3N
O.ZF9GY)U?g=ZaK1Vb3;_g#C(aKAHDG6E4+_[S8X98=,6_Z4R79P/08KSF(L?1M)
2\,T\Qg557YZ0BB?4\L??Fb.a3[bO(0+VN1;W,LbN34B=]/NQ1@bd^eJdd-+0fU8
_5JNTd7(R=DV7_Qe9U]8Pc^6Sg0e(X;?g/_)Cfff,Ad82gc,=?ES](&\FUgf>e9A
;[Q81^+g2_.W:1;VCIY_\6[)LQ6,gNc75,.gZK1>7e(CY@G&K1Q_[F5^MRK0^fU1
1@&R;a6^LOM(Zc9Q&@1-;V&Zg5::LB6SF>C3L45Pe:OLDR^dEAUK=:WYD]@XC[.W
[3f0/-)WTB;(Z4TT/5A50eZBcXR/Lb>=?Q(O?fK\2TC>F2J@J.Z6Rc:D:OI;[RNV
<Vb&CN\>+GS/9E?cIFHMH-&f,L5W.0SR3<PYND37Ia-;)LJSc<]cBVg1V7PCe1HS
1TL7c5WK;\B3?g_/R?+)78cU<d]A^A13#/d0Q4JD@3HbAO_Y4g)Ag<19N?]3>(]b
Me2:>35^Xb1)L?7#+9M^V\;=YDV5SRUC;I0D/RY1g+<SD=H1N,M=8DR<b3]LU,+@
8JA6:LGf7_:MF4B,c.L;]e]TK4(C-:2dS,32#ZO/L<O0B+S=\6BQQ8WJ-OM8+bM7
9D\\MEAgL&96UIe&1c&_E?BFENaIE3?24A@Ae(U4IR>^GDGDaNfYbD,(#a_=]DRb
^PQ&6W8&3L[7J7Wf5MJ?PeIJ+feSU<+/,@94=IG,bXd+>,.J[A.^MZfHIUDgC)XJ
6+/,TY>VKIR9ecV:[^7WX(e.7J?VC3F:DONbOVb6<NdA##J_#219Db]<-#U2Y&Y+
[:7.[)I<5WKA=L&9bKM2b_4gS)0J0OI6d/ZfVc,65WOVODN2ZNP3WH\E[Zde=a8&
:3B/;7+J0AO@CRO1>QbB&>2K+BOZDHFbRCaCOKc^WSKAe.^Qf36J(@8;)--IROT7
bX89W<FQAR7X_EDf]XVYB<4GC:U6U,ZCW_PN;UBaNEGKL;E9#f^@a+5H,8CJJXM0
A.AWf>>e7I&_V7cB1N7PUeS;/L#<M7&:@dI(Y<XJ-[MGN<)O(D2;@ONaCL/C9f2/
V+O\:M@L4YUHQg^#X)GTJS]_Yg/_@Zf3/^RTBLK#MX108e,Qb7TLH[\T&J9,[(.L
],LFW1BN^F&V_c0\cS,.E+)#YT=YSO-2@C^#eda/ARH]J/KW@a\gG=^e1WF/<<-K
VNA4fbg3R_GPFc6]+SEG+R-<TZ5PUa3&^aba0\(@,M(fBZgZ4<S:PQIS>g:S95Z8
6(bH,gaK7D>1KK>8)Ec87?8B)<//PBdcYP0XQEX_&fILPO-<0)He1?=4(S595R=P
.eAfcdPVFTCba?GTNP_0(S^AI<J26-:57;WDa[IRJ3bdc&8@C?_J1DId1=^Y.3+W
SUdOD1>S5_HTUeOEH?WBH9.U].Q<XCcg)YfXJWR\=7#X+F?W86])DWfc[(SeYdIA
c:d&-^(D:V,8PY\9#A-NceR)X/]aQQdQH/:]a_B[4KTHXHTVfX(gFC8/_5RP.(gZ
Z^2abJ[<e/a@?9f]B-Laa66&Vec74I3e>ZZV@YK<50D\4V,HH:<2E6RdW.P6bN#Z
be8L<YHO(Ad&.eY>ULf;eZX=dfSQ\+?YQ,0RP@QP^Ie>_],+&IeX1QU4Z6P.6IFR
[J.?8WgU(IS;VI4.0b;EQ6<1CVCH,JDT.XON&G<MYL+fSY1G\<&X[^Af+G6W@E?]
MEXB;g+RRD<4N>B(REDJZMGH>5,&(^YDPFYLE<e35#;?,?Z4>JeAE/Y3=07g6E2Y
>.f#/33ES1e;>1bUSOM4gHHK^)JbWaI_@0SYI2MI-9+7.c[R3daUaANXJ7)0bLR#
O+OG4c+H1A0JbG^GSW^LQ?5bO2EZ2J(B0-YI5eTEc+Y;g+?+BGSfS;]OGQ6MMd)<
=Eg0f:4(=N5)[G,+5FF327_Xdb,=Hg80fVVS43::RN==7eC4Q.F\Y&ODO?Z<<e>7
C6Ye\aS4_W</BW/QC(e/_OB1b@>b\a=>CSCUTGLaDO3H+[B&2^1VdXIA^QD[MI62
e.@KU->]^KXXbFQ#HdEK)T@7([)@>(K5)]W7J22R5Ec&dP.YA9)Mbc3]#)AQCN0A
Y(CY;OcA^4NC)6C<d=@EG473C+02.E]C9-2ML2]9/:>PCW1P#IJ[_V<6[VR9#KT7
4/_?/8H3G-@=<NC(<:JX+F9<IK=-EK)J?Oa#O#G^8Z>>1?YHMNE]A:#2^C/c<f25
BSJL(8@)KaV;L[-17[&0=@f;UY7,-3Rgd>QLc8g]WIBZF3g4./8^Sg2dY;Dd@5A6
J292/c[N\S=UcEX]&+IV,P7NCH=2/[-aM8_&3XV_]I&8e_62G7f>>P7C=OM9PF;K
KfYNfGB?fS6@V)PRJW:ZC9C?7+J+6AV;<)bT1O5C-)<G+LK89O69e&GL2<4[HBFa
^VU5JA;-G>C/2\0L?H6^7M&MWI6X_0;g:09f>LPHBS?2[1J4^7JCS^a8>TSROCKd
NgaVOMD>e:ME.O/E7;,PHeW3O?c\/QBX(gJI,F++SJS=Hc]6R2@O(?/a6J@RV4?P
bIGS,85eYL84^?N+Yb@GfAT0FH92e-ALbZ>U=0G0L^40G>JGeD(eFe]#g=Y2,LB2
d)YVM4VL?8E+N^>(@gUe4Cg?J-1,HYNEKM&)Y:RdI1#3&c7O7\&9>CUU?D=?f.;E
I6B;[;KTBG<C&KdT1.c2B]dKO6)CTL]IQ]_-)A.R\FdIG12AL?=N#-Y_>@&60f17
YJ8#Tb0:#@VOZ5<OZB#@[OVg=Ed8:DK<1+ge84)YXPD#SOb]bB2->Q@Y3CD0LS3Q
6DeXGPJ^<G@J#ML^@J?&a#OEI1bD,?D1LBTC2g/3439+7&A#EFe0?Oe?4^2&NUL]
-A0BSbAa0f+bXT.T#K&ca/YdS9D.a1@XRaI)Z[Obe#Q^f(eN1O5^YT/UdVP2DS1V
^aN]G]M&WC)a@#P+&#80-=.1)]J-dXd^X0;LR^-;>)8]VN.8Q#gdY)N=Q5c7WV++
0RWC(NWXM--;7SMf;-a6=EEQ^P65.1-W<=UQC]9QYG@NNMUEYG^LW0J+9D5JI+gJ
gU\-^O1Y(E0PAWKNc5NA=PFZKC1NK_e6:f@LUV.CO>KQD1,G9f<.7eKZ(\S0@ZI5
D0d4NU-FMb9a)(<>)C_PGacF<)b+eO^b86=Z,--f+T_D_NfRJZSf?I\R1gAeB^35
FEE]O27[H,E?g4AH[8W<2bB8U-Va0>YD0d(==1[D]M_:dg>[9b2I-gH87YDT,=dA
>PU^8]@KAPb,bN2I]OW[OHK]^3\.EV/_TILQNL&L9SR;=a,;Od>3_6c[19Y[5AU4
F<<J8V125Q+:V0&&Y(;9;KR>V[DY)?M7^a03&04YeXO-C^MEO8cg/ED<FH5B))77
BYCB,@OG(.U^Ke\C01#/E[.g\GZJ+]8:C;IgMK]HJ6R@?O\P\0RSfeU]C6@YH9(0
3Q\:a&R&+8d177[8)06H2K=OCGf/P]EW9ZQZC<UA@@&IG+2/-6ZA52>T2ZUVVA=7
,X#?,7:#Q45#:>C8F6Xg5\HD>_aVS=.@,2YX8Z<+Fb57#10W<QEgDYH7QcG>8BSf
b9G0-8f,.aTIae_^._f<SH518b8P87<NF?>bb<[E_bbR3FRZ@<2S3@V\f)0&@)-M
7(BE_5EJaa#4U09Q?9?40bQc^&TP]<OB>OR?:KYRN]--I(/b.JNYYPJU;2_aOAY-
]D@3#6_1g]22OJLKTH.W(=BMdBa6OTO3@A&UfF@cU+9DGT@_bX)P<,F8ZY_W9F>+
78F).Ib^R]+AC#1EaPZ=#,0+g9EFS5?4J?&=/_]4Gff9[0a?-1KUcIKPQHZ=.,Q;
^IQ?I9eQ?@;+HNc)Ua,Q5T[.McG4BUZa\0BdKIPc<>FI1-3P&E]((.:b167J]XN+
X):NHRfIbe4<633L4<^4gZ093;4b&E-EFC1/(PScBINY81D\J2&]GEd,TZ08C(JT
[+/e,N<Y(MJE[O)d#eU8)(()P@#);-)I4caVE>D7^6TE57Va[aZ0?]1=D3aMP#1O
EaYL\_,[Vc4],?1T.42M/dMDD\F82;D<BZTf8XbT@@ZXOa>(Z>T;OX#ZH#MR_aU<
NTeg4&#<:U.FA\=L>#f.A:UTK.H=NI]S2QdTcR7KRI;MJIS?9)/1^567_&aNL27J
#W+00SbSc0:A?PYJT1b):(X[S1a2,NdY0H>\EMaB#<9Q38KPa)JZH(=2_E^]G@L+
\>L(9a3/5Id3ZT\/EX4DC8R=-DF1+c+;3+G[<((C<&IC0Wc?30#8C+\Tf](c-3^+
Y+M_A)-9WWF)Q]<8e?>.3<d<fX&WE&0&]<;4a?9]/+9O;;dgW2:K)JR#6SRE<gWe
X1/Ed)(@X_7H#Lbf^[8X)<^.c59HYK>_<.IMBW.47=:9+>-,?C17/B)9MWf(CRa5
1M0VJW(0#MHZKbbN7Z7NZ5O<\ca\#eS&<^b#7P?H0;SC0aL\g)T+Be1TJ9X<df&b
SW4O-OX9B6SQJ#_Q3WBF5?Y2EN.E?;;]#0M)LeGQSR8=J?JS/],VXL:T/HW#=X;2
,0_+2#R.+EO<6AOf,NT^g9]BK=8Y<NW:;\WF4=&Nb:1WK8@Q+[-#If/O4ITda/B/
]=L,Nd)Ia99FFIA/C.0^(-K)Tg-a4\-#VLB;^#+<KQ]eQ+,-:_?(8a=VWT\<BT06
WJ^LeNYZ.dE33O6M<S##[X2JY9BBG\cJLT>860-WeTJH/[544.0@bGNL?fQcNC-5
_SQN5THR9cV=1\PdXGYOE:B1<UI<0cAFYCJcVV,4RB<3T:;71^Z]5S^d]#d.UDO8
\=@Q&5bKLc^4,KU(f-+U2OT,ZQ8JR)[9^d\94M1fQ#M5^M1c3];VE.bR;?S;^b5a
WNVV1^QO0[<^G:]Gc:_Cd/#H0?cCO0&_R_(E5N/640HgY1AHU0.EF]8^/R]GC(#5
4):_K=3ZZK&aJ#D2be[IA[0BW:MM=/A&:&)dO+]JU5)<85<DFQEa5_(JKE>&-@f_
JMR?13[0:R#QI0/YcHJ_7aO?.(<+eC\cNF5Zd]ad<9D_I]H3.X_YI@.=BZ\+JAXE
e=/GLaXC&dJ.9L)<#A6GO#HK5;J[G-g]fH<Z0ITIRYRBaZ)<P6T[1b:eGQXBU)U:
5NE<bU&H,Ba+5L-fOOD_89\AI,OaYTF[AXXF;0Q@8,][UNP\GO05a1f5/);H\Tf)
8MAX&<;IfAK/3_F:=OfDf&IB=&+JO>UL.HUa^P;_K1SKa/e:c@L[?_CSHKBdE9(8
b>cD4N/,P,CY./XFXSVXK35R+WW;(a#^;&V5+JdS8Gf0.cHVXF<]YC9G4Zg[YIe8
BKYAC7/GU>d0c([5Z=JK1&W3^7RaNbVb^A_eEaN;7B..V,:=:.8RX,)L[I(9G:\9
H,96dXADA9gL=8[e\fcf<3fD2__J1]-18T;5,=O[f+JFaGPdJ=5-5cP9H0YG@IBH
:H6T^UKH6E\/&UC&UM=W89NZ6KLL7(b1G>AX@EL1JY#,J)>0<#>OZb<QR;U0WA\@
R=F5.eZ]eB9MUa=MT6gT\VJ/RT:2..9FUf=eJ)ULKM2;=cfNb.<(A6bDU38PLIIY
+9T/F-.C#7S_8K#YN\@\CW.:R5F3&ABKNXKFR5d:9L(cCX[M=B32H+b-PeT?-1T2
/V;5&TJ6,ZO5@Z-QPEUCR4O,&2@.aHTHJ#GZHFD(=.gL1(:URY?MN:G=8bEd+3(,
FFR=f6./](O-cgD2R=\Edfgf(RFNN_1GLFF]TX^aW0<&H?eWbLM?e+2OBKbc)1(J
(GC5)D9637]f,)3\)6OO=VFNC_X(8JRPAS7(BM5^::A044Q5DG8Ka0I3Q_W_FYJ:
;[@).,aOY,?ZE:NDS-0XAaeFQa,S1]7cR<g[88^XPM=8:/-EMggeU^b9T^>=PPS4
N)5#g726C_&Ja7^52#L3O@4@>(9)G^^)D7RQgJ>g[I[5@WYe1,PagL9I@3;g46F_
PfE.e.gZ&16B3O,^UIR^EOa?K_AReQb[J23[7Cc]QA,W3<^W4VC2TfD6+-4&A,,O
;.2_\3G#T02YOOXc<Yge,URbagU(TRGQ2AS#)fXLfK-ZV.Fd2OeI&ZA7&&TZ9A(<
4K##62/O#](RP0DZ_f6.dQ9QEN2gbT.J)S\eDP=QcOD9b?0/^&EfLZTZPX)>L39:
ZO4bdHM:R^HO7[^FE.TA-X7a;,3C:&O^b1TE6?dJVU^Q0B/T18J&+26[)J^^&aG\
MfDfC&+Q9=>58:,H-0,BDDFL8]eLD6eSa,d^2:)-6,TI[@B^>-DRAO:7NPKe&e8M
_)Hb4D-2KYI[:E,733aWHYeIOfPM8ZDIT0EL(2I?+YPAI&0=VEE48KCETUQ(9/J;
,=9DAcfc1]=CDf)Qf-SMKIcO:O>0ISdJBPHVY/9aS-W:5?[HfM//B&J3QdWaZJ]Q
Y>JcL0Q\F4]=,5f[P9b-P/XXNH[Va(@JM^SVC)EIWG3Q2YI1/XK(,C<Q9=<c?<[J
@WG\Z4QKHV;bGOOg[bCZ@9_SJA=ALe8&=E_O;FAH2,<B:4O6F._b?K8gFQ\>=S@/U$
`endprotected


`endif
