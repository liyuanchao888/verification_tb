
`ifndef SVT_AXI_SYSTEM_TRANSACTION_SV
`define SVT_AXI_SYSTEM_TRANSACTION_SV

/**
  * This class encapsulates system level information pertaining to a transaction.
  * System level information includes a master transaction and associated snoop and slave transactions.
  */
typedef class svt_axi_system_transaction;

class svt_axi_system_transaction extends `SVT_TRANSACTION_TYPE;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_system_transaction)
    local static vmm_log shared_log = new("svt_axi_system_transaction", "class" );
  `endif

  /** @cond PRIVATE */
  typedef enum {
    WRITENOSNOOP_WRITENOSNOOP = 0, //all
    WRITENOSNOOP_WRITEBACK = 1, //ace_lite-ace
    WRITENOSNOOP_WRITECLEAN = 2,
    WRITENOSNOOP_WRITEEVICT = 3,
    WRITENOSNOOP_WRITEUNIQUE = 4,
    WRITENOSNOOP_WRITELINEUNIQUE = 5,
    WRITEBACK_WRITEBACK = 6,
    WRITEBACK_WRITENOSNOOP = 7,
    WRITEBACK_WRITECLEAN = 8,
    WRITEBACK_WRITEEVICT = 9,
    WRITEBACK_WRITEUNIQUE = 10,
    WRITEBACK_WRITELINEUNIQUE = 11,
    WRITECLEAN_WRITECLEAN = 12,
    WRITECLEAN_WRITENOSNOOP =13,
    WRITECLEAN_WRITEBACK = 14,
    WRITECLEAN_WRITEEVICT = 15,
    WRITECLEAN_WRITEUNIQUE = 16,
    WRITECLEAN_WRITELINEUNIQUE = 17,
    WRITEEVICT_WRITEEVICT = 18,
    WRITEEVICT_WRITENOSNOOP = 19,
    WRITEEVICT_WRITEBACK = 20,
    WRITEEVICT_WRITECLEAN = 21,
    WRITEEVICT_WRITEUNIQUE = 22,
    WRITEEVICT_WRITELINEUNIQUE = 23,
    WRITEUNIQUE_WRITEUNIQUE = 24,
    WRITEUNIQUE_WRITENOSNOOP = 25,
    WRITEUNIQUE_WRITEBACK = 26,
    WRITEUNIQUE_WRITECLEAN = 27,
    WRITEUNIQUE_WRITEEVICT = 28,
    WRITEUNIQUE_WRITELINEUNIQUE = 29,
    WRITELINEUNIQUE_WRITELINEUNIQUE = 30,
    WRITELINEUNIQUE_WRITENOSNOOP = 31,
    WRITELINEUNIQUE_WRITEBACK = 32,
    WRITELINEUNIQUE_WRITECLEAN = 33,
    WRITELINEUNIQUE_WRITEEVICT = 34,
    WRITELINEUNIQUE_WRITEUNIQUE = 35
  } sys_xact_two_port_overlapping_write_enum;

  typedef enum {
    INVALID,
    VALID,
    UNIQUE_CLEAN,
    UNIQUE_DIRTY,
    SHARED_CLEAN,
    SHARED_DIRTY
  } sys_xact_initial_cacheline_state_enum;

   /** The typedef of max address bit type*/
  typedef bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] bit_max_addr;
  /** @endcond */
 

   /** The system configuration handle */
  svt_axi_system_configuration sys_cfg;

  /** Handle to transaction received from a master port */
  svt_axi_transaction master_xact;

  /** 
    * When the axi_interface_type is AXI_ACE, #master_xact
    * represents a coherent transaction received from the master. In this case,
    * if snoop transactions were sent to other masters corresponding to this
    * coherent transaction, #associated_snoop_xacts stores the associated snoop
    * transactions.
    */
  svt_axi_snoop_transaction associated_snoop_xacts[$];

  /**
    * The slave transaction(s) corresponding to #master_xact.
    */
  svt_axi_transaction assoc_slave_xacts[$];

  /**
    * The potential slave transaction(s) corresponding to #master_xact.
    */
  svt_axi_transaction potential_assoc_slave_xacts[$];
 
  /**
    * The slave transaction associated to master partial write transaction 
    */
  svt_axi_transaction slave_write_assoc_to_master_partial_write;

  /**
    * Slave transactions that started after this xact and has addr
    * overlap
    */
  svt_axi_transaction addr_overlap_slave_xacts_started_after_curr_xact_queue[$];

  /**
    * Indicates if there is a one-to-one mapping between #master_xact and 
    * #assoc_slave_xacts
    */
  bit has_one_to_one_mapping = 0;

  /**
    * list of port_id of slave to which this transaction is expected to be routed
    * based on the address map either as a whole or splitted into multiple transacitons
   */ 
  int exp_slave_port_id[$];

  /**
    * port_id of the slave transaction(s) corresponding to the master transaction.
    * By default this is empty, indicating that no slave transaction has been 
    * associated yet. Once any one slave transaction has been associated to a master
    * transaction, this value gets updated to the port_id of that slave transaction.
    */

    //* It doesn't get updated after that because we don't expect a single master
    //* transaction to target multiple slaves.
  int slave_port_id[$];

  
  /**
    * Applicable only when case complex memory map is enabled. If the address of the 
    * master transaction targets the register address space of
    * a component, this field must be set.
    */
  bit is_register_addr_space;

  /**
    * Indicates if expected_snoop_addr and expected_snoop_filter_addr fields
    * are updated
    */
  bit is_addr_info_updated = 0;

  /**
    * Applicable only when complex memory map is enabled. 
    * This represents the Output address at the slave.
    */  
   bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr;  


  /**
    * If axi_interface_type is AXI_ACE and #master_xact is a DVM Sync
    * transaction, this variable represents all the dvm operations
    * associated with it
    */
  svt_axi_transaction associated_read_chan_dvm_operation_xacts[$];

  /**
    * If axi_interface_type is AXI_ACE and #master_xact is a DVM Sync
    * transaction, this variable represents all the dvm complete 
    * transactions sent from the read channel. 
    */
  svt_axi_transaction associated_read_chan_dvm_complete_xacts[$];

  /**
    * If axi_interface_type is AXI_ACE and #master_xact is a DVM Sync
    * transaction, this variable represents the dvm complete 
    * transaction sent from the snoop channel. 
    */
  svt_axi_snoop_transaction associated_snoop_chan_dvm_complete_xact;

  /**
    * If axi_interface_type is AXI_ACE, this variable represents
    * the snoop addresses expected to be sent on each port for #master_xact
    * Currently used only for READONCE and WRITEUNIQUE transaction because
    * these can span across multiple cache lines
    */
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] expected_snoop_addr[$];

  /**
    * If axi_interface_type is AXI_ACE, this variable represents
    * the addresses expected to be updated in snoop filter for #master_xact
    */
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] expected_snoop_filter_addr[$];

  /**
    * Writes initiated by interconnect to write dirty data returned
    * by snoops to main memory. This is required when dirty data cannot
    * be returned to initiating master
    */
  svt_axi_transaction ic_generated_dirty_data_writes[$];
  
  /**
    * List of address for which error is reported.
    * This field can be used in pre_system_check_execute callback to find out the address
    * for which error is being reported and take corresponding action
    */
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] error_addr[$];

  /**
    * List of ports for which error is reported.
    * This field can be used in pre_system_check_execute callback to find out the address
    * for which error is being reported and take corresponding action
    */
  int error_ports[$];

  /** @cond PRIVATE */
  /**
    * This array gives the handle to the transaction(s) that appear at the
    * slave corresponding to #master_xact. There is a slave transacton handle
    * corresponding to each byte that is transferred in #master_xact, indicating
    * which slave transaction corresponds to the given byte. Index 0
    * corresponds to the min. address of #master_xact and index 1 corresponds to
    * max. address. Applicable only when has_one_to_one_mapping is unset.
    */
  svt_axi_transaction byte_wise_slave_xact_handle[];

  /**
    * This array indicates whether a given byte of the #master_xact has been
    * mapped to a corresponding slave transaction
    */
  bit byte_wise_mapping_status[];
 
 /**
    * Indicates if dynamic association of coherent transaction and 
    * snoop transaction is done or not. 
    */
  bit is_dynamic_snoop_type_set = 0;


  /**
    * Indicates if this transaction is non-modifiable, which means,
    * there is a one-to-one mapping between master and slave transaction
    */
  bit is_non_modifiable = 0;

  /** 
    * Sticky flag that indicates that snoop association can
    * be started for this transaction
    */
  bit start_snoop_association_flag = 0;

  /**
    * Indicates if all bytes of the #master_xact have been mapped to slave
    * transaction(s).
    */
  bit is_xact_fully_mapped = 0;

  /**
    * Expected number of dirty data bytes that should be written to memory
    */
  int expected_num_dirty_bytes = 0;

  /**
    * Current number of dirty data write bytes
    */
  int curr_num_dirty_data_write = 0;

  /** 
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation is within range of master_xact
    */
  bit is_slave_xact_in_addr_range[svt_axi_transaction];

  /** 
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation start addr is same as that of master_xact
    */
  bit is_slave_xact_start_addr_matches[svt_axi_transaction];

  /** 
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation is within expected time range of master_xact
    */
  bit is_slave_xact_in_time_range[svt_axi_transaction]; 

  /** 
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation is expected based on whether snoops were sent for that address
    */
  bit is_slave_xact_expected[svt_axi_transaction]; 

  /** 
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation matches id_based_correlation with this master 
    */
  bit is_id_based_correlation_match[svt_axi_transaction]; 

  /**
    * Temporary variable used to indicate if a slave xact being considered for
    * for correlation has an exact one-to-one mapping with master_xact
    */
  bit is_slave_xact_one_to_one_mapping[svt_axi_transaction];

  /**
    * Temporary variable used to store the priority based on data_valid_assertion_time
    */
  int data_valid_time_order_pri[svt_axi_transaction];

  /**
    * Used by the interconnect
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating master. This field
    * indicates the split transactions of such a transaction.
    */
  svt_axi_ic_slave_transaction assoc_split_xacts[$];

  /**
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating master. This field
    * indicates the parent transaction from which this transaction was split.
    */
  svt_axi_ic_slave_transaction assoc_parent_xact;

  /** Internal queue to store transactions which are already in-progress when current
    * master transaction started */
  svt_axi_system_transaction xacts_started_before_curr_xact_queue[$];

  /** Internal queue to store coherent transacions issued by masters while current master
    * transaction is in progress */
  svt_axi_system_transaction xacts_started_after_curr_xact_queue[$];

  /** Internal queue of snoop transactions which are in progress while current master transaction is in progress */
  svt_axi_snoop_transaction snoop_xacts_started_before_curr_xact_queue[$];

  /** Internal queue of snoop transactions which started after current master transaction started */
  svt_axi_snoop_transaction snoop_xacts_started_after_curr_xact_queue[$];

  /** 
    * Usually, the system monitor associates a snoop to coherent when the response to
    * the coherent is received. However, in some circumstances, when two ports have sent
    * transactions to the same address and one of the ports involved is an ACE-LITE port,
    * transaction sequencing(the coherent whose snoop is sent first, gets the response first)
    * may not be maintained. In such cases, the System Monitor collects partial association
    * information. This is stored here.
    */
  svt_axi_snoop_transaction partial_associated_snoop_xacts[$];

  /**
    * Stores coherent transactions because of which a second snooping of ports may 
    * be done. This may be required if a store to a cachline happens after snooping
    * a port and before sending a response back to the original transactions that
    * requested the information. This typically happens if the original transaction
    * is from an ACE-LITE port (say READONCE) and targets multiple cachelines, some
    * of which are present in the peer caches and others which are not. By the time,
    * all peer caches are snooped and data is retreived from memory, a second snoop
    * may be required.
    */
  svt_axi_transaction coh_stores_subsequent_to_first_snoop[$];

  /**
    * This represents a second snoop that may have been sent under certain scenarios:
    * 1. If there are transactions in #coh_stores_subsequent_to_first_snoop, this
    * variable represents the snoops that were sent to retreive the data stored
    * in the caches. 
    * 2. Some interconnects may snoop a port a second time for a WRAP transaction whose address is not aligned to the cacheline size. Basically, this represents a second snoop that may have
    * been sent.
    */
  svt_axi_snoop_transaction associated_second_snoop_to_same_port[$];

  /**
    * An array where each element stores a string representing snoop data
    */ 
  string snoop_data_str[];

  /**
    * An array where each element stores a string representing snoop data
    * of a second snoop which may be sent to a port due to an intervening
    * store
    */ 
  string second_snoop_data_str[];

  /** String representing data in transaction */
  string coh_data_str;

  /** String representing contents in memory for locations corresponding to 
    * this transaction
    */
  string mem_contents_str;

  /** Indicates if association of snoop to coherent is done */
  bit is_snoop_association_done = 0;

  /** 
    * Records previous writeback/writeclean transactions that are in progress
    * while this transaction was started
    */
  svt_axi_transaction last_coherent_write_to_addr[$];

  /**
    * An array which bytes of this transaction had a previous write in 
    * progress
    */
  bit last_write_to_addr_bit_map[];

  /** Flag that indicates that relevant checks on this transaction are done */
  bit all_checks_complete = 0;

  /** Tgis indicates the dynamic snoop type that needs to be mapped to coherent type at run time */
  svt_axi_snoop_transaction::snoop_xact_type_enum dynamic_snoop_type;

  //string inital_cacheline_state = "INVALID";
  sys_xact_initial_cacheline_state_enum initial_cacheline_state[bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]];


  /** String that stores the initial cacheline contents */
  string initial_cache_line_contents;

  /** String that stores the  prefinal cacheline contents */
  string  prefinal_cache_line_state;

  /** String that stores the final cacheline contents */
  string final_cache_line_contents;

  /** 
    * Snoop filter status for each of the master ports when this
    * transaction started 
    */ 
  bit snoop_filter[][bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]];

  /**
    * Array indicating if a master port is expected to be snooped
    * based on snoop filter status for a given address
    */
  bit is_expected_snooped_port[][bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]];

  /**
    * Slaves to which CMOs must be forwarded
    */
  int slaves_to_forward_cmos[$];

  /**
    * In a cache line multiple address are there, out of that particular 
    * error address will be stored in this associative array along with debug message string.
    * Currently it's used only for READONCE transaction because
    * these can span across multiple cache lines
    */
  string error_addr_and_debug_msg_string[bit_max_addr];

  /** @endcond */



  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_system_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_system_configuration sys_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_system_transaction)
    `svt_field_object(sys_cfg,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(master_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(partial_associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(coh_stores_subsequent_to_first_snoop,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_second_snoop_to_same_port,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_read_chan_dvm_operation_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_read_chan_dvm_complete_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(assoc_split_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_parent_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(associated_snoop_chan_dvm_complete_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_int(expected_snoop_addr,`SVT_ALL_ON)
  `svt_data_member_end(svt_axi_system_transaction)

 /** 
   * This function associates the snoop transaction with coherent transaction
   * dynamically at the run time The user can set the snoop type at the run time
   * by making use of pre_coherent_and_snoop_transaction_association callback By
   * default the value of is_dynamic_snoop_type_set is 0 , so to enable dynamic
   * mapping this function sets this value to 1 
   * @param dynamic_snoop_type The snoop transaction type corresponding to the master transaction
   */
  extern function void set_snoop_type_for_coherent_transaction(svt_axi_snoop_transaction::snoop_xact_type_enum dynamic_snoop_type);

  /**
    * Indicates if more than one slave transaction and snoop transaction are correlated with
    * this master transaction
    */
  extern function bit has_multiple_correlated_xacts(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr, bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  extern function string get_byte_wise_mapping_status_str();

  /** Returns 1 if any snoop returned dirty data */
  extern function bit is_snoop_data_dirty();

  /** Returns 1 if any of the transactions in associated_second_snoop_to_same_port has dirty data */
  extern function bit is_second_snoop_data_dirty();

  /** Gets number of snoop transactions that returned passdirty */
  extern function int get_num_snoop_passdirty_xacts(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);

  /** Gets the number of slave transactions associated with a dirty data write by interconnect */
  extern function int get_num_slave_dirty_data_xacts(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);

  /** Returns 1 if any associated snoop has data transfer */
  extern function bit has_snoop_data_transfer();

  /** Sets initial state of the cacheline(s) targeted by master_xact transaction.
    * Primary usage is to set INVALID or VALID state. However, other states like
    * UNIQUE_CLEAN, UNIQUE_DIRTY, SHARED_CLEAN, SHARED_DIRTY can also be assigned, if needed.
    *
    * By default, this method sets initial cacheline state only if snoop filter is enabled in any peer master.
    * Hoever, if skip_if_no_snoop_filter_is_enabled argument is passed as '0' then
    * it sets initial cacheline state irrespective whether any peer master has snoop filter
    * enabled or not.
    */
  extern function void set_initial_cacheline_state(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                           svt_axi_system_transaction::sys_xact_initial_cacheline_state_enum cacheline_state = INVALID,
                           bit skip_if_no_snoop_filter_is_enabled=1);

  /** Returns 1 if initial cacheline state for the specified address is VALID */
  extern function bit is_initial_cacheline_in_valid_state(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);

  /** Returns 1 if initial cacheline state for the specified address is INVALID */
  extern function bit is_initial_cacheline_in_invalid_state(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);


  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_system_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_system_transaction);
`endif
  /** @endcond */
endclass


// -----------------------------------------------------------------------------
`protected
[N95XIWYGM?+bD68Ra5?:Hf32BfDgFM/=L/V0,3)<gJK;@?;27YC/)PeJQI2Y()0
BC-U6O5O(V(TV@O:++JA4;F&=_UV.^^N]=Z+WbcP+dfWOUc[S-T^ISHedZAHff=C
VU<49TA5f;]D2Og0?.b7;^OX)J6W],F:NRQ#H4.>US;AYc8G+E@HA+WBBW&\SCDa
^F.U>DS/##H&a]H>6>4F[N(3BB1@RK4<,>/E420PNKYB4[(eDEHgcg-^Y+?T\e7f
+VG;MO0KTJ1AJ:6:eK9F,TBaffG,8BJZ;),^de-2.D+.@ODbTWEg?7(T)0>ffYNa
c,^3<).XZX.(0[-F)d+1LZS1eD_KZQ-VGQW3b4<BgYJ_cF5B:c5/A1W69Ac[3S4T
FQY<[>8R3,HUa6TcR/.<+H[TBU&YHOdDTL^TU9P7[.3;TMaDD^@9E#FP+H)Y7B+B
M9O/F94PED8ZO_45HH(BDBXA+Z)b)b,eDE[QW)<aT>@PfO]ZEf0<XVg;3F>_UVJf
A7Pa^OA1M&bTe/;b(/[N6f6Zb:?/3Q[U:0c50W]M3(EI6?/&T21X.d^CRc):,9OA
Bf-(1QT>6e9U@/:P6Ra#0a0R?+_8^2gO^gB40)6A3,dP#ULM6>WZ+ZA;V]5g<2=e
3bH6c_&f[,IcO_8e491+e/>-73d_RI0,I\_)VPg+6Tb#+;.@=\C\A]22]<R:<GF_
0HEZ98EB0bS\F[-WL5,&?4SR)2gg64DTVcYICNGa8VQcUEdS5NEUD^8#(EY,cZO.
57fgY??+??1WWWcGCfB34.;UVU1aYQ.>I[3b+E)(Nb(3+F^N2b6,,,5LSZXWD>?^
&<GQN0OaG1P+3gUIX_bRG9]d:-N]@RI7_d#,Ug7Z-b:.16S;JbRCRM^^>H8;KY(\
II]]Md1+bTAdV&<5UD\X1[C=#569&U/A\fXP5G-fML:MK;KQX3K_a^HQ;F5gd3?#
D>3?G-TDSU\D@3E#Q\1)A=C=7$
`endprotected


//vcs_vip_protect
`protected
fc-NgQDJ&XDY.DGd.EF.&L94<LO@c;(gB8QH^BQH(K]dI<&<gceK7(LTcg(23-LB
Z#fF5.>2J4RKV(E0P<(#S7WdX.D.+1+@F^4^?V^=IJB(8P8MO)U5M8H/7(@Y6]O:
FWP43OK/NODHN<@[a=5I=IG,9KLIT=)3&f.WZYScNII(JB7,]e;d;eef@;?51WJI
WM=8Xf4b&9(K?>#@M=_ZAYXB<)XY<-5DK,f[Q_+4:I)Yb,@;)-OZT^8<WX.eaKBR
6E,FB25bO1MO=#gEV?_g<>QD9FCFB>RcbAS@9E95D/:YX9<f5N7RO_:(d/X@@;;^
3a_FSBUF:Ve:#/P<57?BE7c_BBQN)GA0XbSE8(82a0d=CW:1BMR/b-L.>/3A@9P9
<_S,aGg^(eB(:bBU[+W1K/-#edb3YM7FIJ]3M>K^06HW&V;+6f//2.VbKKgR2L]L
1XBZD:I,M7+8]-/D]BO=cT:3Zg6NIDVfP)+D334/Yde,&L;]MEgdVL?S_R[UQ7.+
A(CaX+N,<.,-U#+6KXVJ4Q-SfZ,=0SW[C9)?_&N(@[TE,8fSU&-Q45H=.JQ\)4&/
5>VE[eGUR\OLR/8WVY4a_cZ&MMCT6+-VQ<^HF/=L/4?5Z?^I5CIOc<IaP&YKI)T7
+?>)=4+Y-0,gE\:Ne247PE2PMHC=?B4gHC^dKgUFX3_\D9UDO2JW(7S4RXf8\Q3J
18YU=&C53VP]6.\K5.@O3NeE&E918.(.<+7P[QZ@/6=:gV4LIYgPd=?0B(?adTL0
&)FP[@Q44cHCJ)T9f&396K(:+(H,7&1f8[_:O8.PAeHDA-ZG#?\7bX<d(aCAB,a7
(RE>a@\48BVVSHaGGKI96._[UDN&cA+:@@I+</b0-A7f&a8>f5CZ=SKG,W1WS:D[
)1g\cUE6Ye)S/:#.ZD3L[GO[UaKM@Z=CLHU=8IAFDJ>LGKE)b)X=T_Y2?Zg9J[:6
\4[DVZX5f61Y\.=;<.c]VS=RJY-((150J<?LHYWTd@_XU([Af23_D?@f.@L&A7Xf
gU=)QJI]SFY4I_9Ub-82+Q<?ePBVS?R/&@+ZYWEQCA:E^AW4b=LRTF&.fY=F_O3f
O=4dI[L0N&N?<T^D(a#Z\,<QP52(7/C>5[UMOc;HH:6L2Y-_RdDe&_?VF1aAJUHD
TTg(:-e,b;g>Y:]Zd\]Da,3DFV=.S[cN+?,F#g#?OG=c@JVHPfO(1/a:d:.baYd;
fJZ?^ZMA1F,M+,Y9MH;g0(#6=f1LR^#DWg>U33?161_@VYOO1YWBL9JNS8L:[aQe
][)9O1dIRB#ZX(([]=9>UH539I)b.8.Z5#O3/W0eKAA#BdT,T3@>QU\8aUM[FaPR
+/;3gIMND,DY)T^FX59<a?TfWICa[+&66N6+FSZ5V+1M&B<BXNO;=<5E#2LM/N@2
<d:S72;6TPJ[<\D\O&&Ve,d[\UBe[[2CYCb6Yc3R2Y&gS,WYSV8ZS_<&A9G/1]D8
2OH]5^K4@+R0BbR]\ga.g+,.#;J=dG>-^N:XZQ<D_;(0fRCX9f)Ge5=]R3M,6<ZX
KXf0b(N>MV47=X&6dK;8J.3c9ZIc5C0Wd1a=ZGfgMGMV:)KL,.0+??1)T=24^,Jg
^c_.>^Z=>P8D1^W]Y4d?+>=87&Df6\R5[\,F)LAU>BS=?\#J?Hc:\RcGZBgUg@UJ
#BPMc_ET.SZ[I2MCCMY0;GC&5DTV1-7.KNO4X>9cfc@WW>4&;W+>U..=/c<6.;2S
EabV)^d]);RR1\a/1^b&dH7g9dB?P0[2RD,K+R5);:N)SAMgg\J6VMdQ]10VNLa;
9IKT1PdE@K1:?TL2OdJ4L(+f0GYM5E_+V)YJ0J]ab.6G<6L,A-VPf?)cAXCU=b-d
=\K3##;:>+X4G3?XQ],#UL0KcD.PGV^EYF.7(</CJ3f97;4XR>9:<2Q.4X#OD;_Y
41RfMI3F.Z]HO2JJf#=U3GDHI6I3MHgJA#3gXd;D)G:-1],??DR@AW\Q3MU[M(EM
]=[;@;Xd[/gOf7[DKFN1^Y=WLO>^&Rfe,L.MDEVfd1YNMDY/_AT]W@#eN7>NN?;?
+/HQZN-/70D6Q]bG&R^H?U5.9F=K<g]VY-UeT:5\7c7_0D8.R@OP+(?(f7,_HF2/
L6=BG&/50cMH5M/\Y5)ZcD]:ACHf8DC2(PV>4137?Efdd\cL]E4f^<CDFL7V92/(
Hg>=6Z?\N:\Hg>c<I=Z7gcXZ(3Jd3M66+I(&CQC^E,9JKB(^ffCQ228QX)10=?\_
=O@ITe^4S+^8>YY6/NO94f+S4a)B]6-FaY6FSO:SbNI++G=g1KCY:.OLdc&GdFM_
3.NX30+J7IGJOdf\A:MQ2F8e068_Sf;PDGN_6/X<B4[2@dOV(O&OaGK\g+>8F@X7
O,cDZ_#O):gZE\@X:TH;a^WWK2NP=0+,R1SVN7,-)IYP3@15O&C@;)S40+Kc[D;,
#.E7_(94;O&;C_WLPOL)=0[9Wg/O3NJ5=R9,Z^T5KI?.-LPgS/G-<=a9\6/0E;a4
c(8##G)15RA2f?W)UcG?840/8288E6^95ECF6fRO[J22C&.)caF7XOdA<>Ef<MCJ
=d#f,SQJ@K\U(61KSVJFJ5-/[XQ:]c=@_S,Wg)FL(P17OQ;J=[gGc9,;3BEg3[0G
4>&@:F0\Z,R)D,60ea&VLXSSKU>E\V[_X_0,?.cJF^.fEKc0Fg=OWRf<VBP-=3[M
IA/=5I<N9=H,F4WHH2L(TgZ._R+8<<IMaN^<)J368F7&6DP.\M/c6e@K;H1:>)F.
5\+VS_H>4IH3_YdT78Z_Y0CB#4TdC7#eHXDE<+1S_aP-0#GTF83_@)EUS?_I.aCP
NW[/F.,#X:-7;ZR;VT,@aH#07SW)&d+3b3H2@O0_caY+Z6U&d=-LV)g^0EGS?L@7
MNLc.ObIbP?0)Q>[[C@a\H\.egK0W_Je.I6)I>(T:IUdSWOg<.Ce7KWM=JZ\^6@&
?g#C+1F.>;ER:K\IDLZ[bNReT])<-^)3]M_^7&2M#T(X(0ONME7QKd9/&)LPgKF9
;_DQ_.&2X\0\FY_K:;f]gB_G?8a>OQd&.XaF>d?,Z[8aE?f++JJR&d]SRDH2@dgB
LKLL&>Q5@,)B#F\MW^3[[CfIUXM[_OO?2I(\NE1/OP=8ge^R?A^U+gVMT#&=;J9@
^Sg1=NgRQ1A>CCWPM17L6Ja>T5ADF14@FO)NZQ/([d_^<BH3VId#TK]5@(LJcKK2
Rf5d52,-=Bc9J7\d#VH=X^XN56_Zagd#(KE=OI4KG9;aaK?5eF,&+HR-Pg_3A[4)
b;#,&REX<cNI=GO4.Z\V4^R?@[Y;XD7\)>W?IF2GT4/#?_)cbBUBXYQ:P9T/X(Ec
?^AdE:;S\]2&#4HFHOQ,=W[d71ga]e,=fN9[F-b+).GCRUbgUAS,Zf9HG.IT([D&
^:+1>P+3&#M:C/W5/FSf_@8/6V)V4cG5_7T1T?e/9U@&\.gY)_BbfacC8XF-U3Bc
D&PE()+<]<DSJ2g[A<;8CbXW_7GC5+^=5KO,0F0W]=02Ba;4RZHY,c2W/YS-0,Id
[,1MH1b7KUKfc5&\-Y^:9T6-eQP)b-E7>:8/e(<5RY@_Nc+GUfD&ARbEOVLDKT;-
W9faAL=0;2HND_A:>RHQ-=c)3a16^>0/gW6OG>4ZdGE/4baYT9Hc5BNQNYP_4TdV
GY@/B91#T-=X0SG__R<<PB0aA?+7JD4:gZ]AM\)X]KF(+;2D#-K;ZT-6Sd4E2M1I
4G7\c#d:?7EF>Hg&J\.C=SOK8-FTYX>XV5N#T07b<@bV=2]J(Nb7P,ZKYV_E6.P(
&>DKP,7.5;D=R?Lc:b4E/6GCBL3>/CY;D)_@=[4M-QO?07)9SG7&K#4H)F4ZREY@
3M>S^_D]VZcPK9#4MY19SR8G\D8(01U:LZJD>&5VT4[.Ke0R(=7(OdJ0T^J31(H9
6Ta\3=9cD#cRU:-AcFe6g_2gU.<SAM=QK-fMFd#DP-S3Ma]>U?&&ZEA,fT9MKTgf
2UQ\RHSS7bB+0>6=WMS.g=Y_B^Bd^@7dc7(CMWMKf8eCT1U>)0\U@1=,#>_NaLLG
8eAP);Z,[IVfGBV7S;O@eXH3QcR-:<T\OA^eF[Y;^7>EYA^N)[^8MF3_[gZESJQQ
5&Q/GA^W\OCL[#IdT=TQaJC(=g]F2;-WV,J+&IgJ\#C-cVa@L<#=gN[YL@Y(87b>
4548T?N0SLZX1DR(=KfO4E@b,DFec8BRf86EG6+\FfL.?;XGHB:f0IVXG@Z8(9Yf
HF&Y@GX7?2<:;5HdP9QLQVF9KE6@:1c2C-:8@ZfDb&c3,KKND^:6=T1M49+H?1.^
UL[RP&_T44;I@bI<2OZcV9cL@X\UXa[H]^]TC-PFb.Oa]40#_^[RE62g[^e\]4(8
OF90Z(@^aDR)O967K<5Q7Z>;QSQDG-B9#:K-RWK@=dA-)A?]7S[d_f118&d?]D:+
/9JD>BW=f&LGERdLEC;ZAYM;8dc)dN[#b+(UH):YNCGL2fW(NPM(YB8>6LN9gK)O
b=Pc&cX<2A3MC:U557PSHWJ)LagE@J5PG+efQ8ZWSEEF3+<@<J(;--,eD+<7?XM.
;US,:V.??=e[HZ?eO5O6_)[33>.TL(@R64?AY(A[W9F,)^;XCaX,Q.OI7f4XbO@]
DAP2WZVE@c.:eG-G9W278X>2P^2,(^g@]d3f9Vg[].S3gb9@YOO)\C/Se?C]6,.R
@:BKQ[:B?g@&_QR3-a[[WRIEN)IAQ8\R#)5&&2d@EBe.E#FC-7V1@1AB5FI^:)(2
BK<J>,,K-=<:AIRU[P;)\(L,e?TW,LHBD>>OVReSBF0-X0<X&\:A&:R3P2dc(MUM
TMO23gb5?BV.-.?-__&:S0,c[Y(:S-+LSc:NJE+fd^G#NDG.LM^I+9fJNb8LK<5-
]:B<VXRcIBa_a;fH7V/74+2:Tb\ARHddWb2;\K:6WRHMaE0b^ET#]OK2g0@HS?60
DR)LW/?<^,XM^O]e)UC(RbM_3/DU0+/Td;H-G:6V,TG4/H@d?9A:fAYU:Y-DET2G
f3NA]K==d@@I&C_/F-;-T[VBKT_]=NKEf(_@0Y38dPL?B>3N_([0aY\SPDDQN=3O
1AMB/Z,^U0965P^/DAX9GI\;;73G;F/KFAR[DP/aa^BDJ>0=/bKC\ZU7)]DMeJgH
GX@[X]aYdXdDR._C&:dEGd5PN8UMRN]6EN0S5R/V((#COfH#)5g3/J2g>X<9EYH<
_(V9U)c..ZKC]>.C@dC<f5Ka@@=OIXG7K9#e7F<1_1d\DYIEB7fY>ISX.ff[1I[b
,0>Y:YB?-\<+NMa^=+KGfb8#;)aaE:C+@<=YEW\PC&CeE\a__);?RaX-0)P:+VMK
KTda83beXJCT(&N2_eEIX\P6_(Sc;DVb;VRN)HN<IICCZISW7UbMQ1\c6K7>ZK^L
MT/RS3>ZF=PXY7V&3&;4JVbYTJ5/:.F,>J)#A1cMB;B(>YJ1R231\EAX.ZfL?5AC
[&BJ-6S>:(/Tc<S>eg)WNP_Z_1ZBZe9IJX)ZB75R^[?[Y#Q+OZQac-DVFGBB#PV3
0P:Q:TZ^dGFd+g4CRWa(28=7)IZP-P^I)a]XL&=MB?J^>>=>7A/<]cMQ>47#7WKR
c]-O[cCHR^KR]#dX>+DL&A#a]8MM9N0b&A6bPCaXYbZ,YfZ<Y]668_WI+6@?Y&>-
]Z>_#1W<\Z(cN3OL>=C<N92BR17J)J0IX\.BEB>ePaVA@2YWE#--(ESCbDKPNOYI
;c_P2UU+Sd:)QINGP,F6^&5BLZXKKNI1BZ,(_FgO6,Z:ZcKM5+F^)fL(P43@UT6#
bI4[4d:bgL-OfWW@()QZ[8B).L#dgY,6USN/EBLUHOT.&eW&.V_&^5KbOLCC1]M&
QKJd<EZ/[75+7.6J?)gPeZEaSV3Q=IV\\V_&)g=/Ta7/#GO=J]f]7SW:?)1NE&PU
6377Q)Fa?6P825++N;-+D>g\T#eY;-aG4R.^g1Eggf3958J8Q=b?RH:E-E2;S^42
L&Sg#B+-1c(2E(]64ccf=NOSOfBA_]<_VaS?#0^01c@-/,0M,WSKEC[NbA.S[;F_
a5UfB=[^?KRK[[48X1D=U;83#+a3\.KA^7A8.?C.NUOWX[Ve\T(\CM4+4PLA3T)K
a)4]D6D\+FT8Z.b)7CM)SGG9?.CM8YV2Z>=@,D9[^HfW^:(/E6a>CdR.g(?<5G2#
(4B/aQ+cAV:?./\7g\0KS?8f+6dQ0a#^BY;fXH-.c?4(@[&IV[WVI4J@)8OcK54H
_WWWM]P+4M>.GRWC[^,^JG82T>&IKS38,Ub:Pe8_\^_1U?MGC>g\Sg5f6AZ3?<0b
-.WTDE9e941P<S.YH=d3/WCbQP(F@PPVJYKX&]V6FS3CIO#AgLTH/A]P7f3ZN)5.
-F,70XA(66RbPT>,BE8?(KOWD/JfS_-[A2J,/O;XUA@/[b@:BZAOK8+^\&SV7RX^
=<\=K-KRaNP],MbP^+G<;.SQ3]c1c1cJ;>4VUJJNG_A().I(D5G;JO#(#IAFG96Z
I,;&?+GR^<gELAA8F1]B+8=>M3;KFd#Q7ZY.0SD31M9GA<3#GYYXN6:6C@U<Q4G7
FQV&=Zb-eZH:\HJR?aQH)52HdDHfJ-37<:CN5-]K449fW)Q@?IaR?KHCdMM]bbON
U).N#,e9<VK)-@SVW2)LaF9U]U2P-5AL:W(^d1(,)/X=-CC1W^F_0_:e8W]eQ6N?
NXeBJ.^ORXK#e2&77B6SUH&@L7-4e7SO]L_b?NF7M)?I>X#1V)6MU7b0@91f0gZ(
-F<X\]=_67YC&LUW>X\Bc)aQC?Og#1@3(CLcA-6E+#PQ^a;SU:&D#fYPbD(HHUL9
638@DL(,DNdLZ@Z-Ma-Ff9G+^]F+D]#Z#ZKLR8=gD;ZZe35/^,M[b<5]GVAYAaR,
#2g08f:J&aDHFATED+@&\T.QFDML)TF;S\<ZNd6W4.]F:U;fWVg#F6YKdJI7UL+E
?P-Y:AfXLR@URaRHU_P7;<P]gK]+6NO_2,EcJ^2_6gMK8MT)(,b&_8fNQg_@L2HG
6BSFH9eHBDWV^23L6B5MEYd/A)/Z:c?VKJ@Y_7BAEaZ5LU;D=dbaL&0Xd@SXM<,/
#.[\W\_ZWS/a4gW\EUDNJae[4H2RW]E?FTC3Zg:8F53<BQCVO4BQD9CQ7LT+J\gT
1\&62IG)D&YH[P)O0X;[-P86JWfdE;WVHUC-d>\VM#[@?;.6c:=E+C/GB/L-;D&Q
8B>SCdWgeUL8FdUCa?_Z4+L9>/570M-TOTE44[6ARDfZ8\_>_b2EN2]5LWRWGO9T
?HV>;]_O6<(.\>E[6+b^<(3d-&5TeGK&N?c3BU?eI2YO^FLWKX]>84]Fa##W[VR=
,NK0Bd07=D^TK5E=+&R>=TZB^=43c@8@O2X;C](Z-._Ja0TEC[3\+4]<f+GN<68M
_3>P[3Sc<(KK[7G=FWDPD:8Gf.(9JeIK+5SM92F@,K/<\f8;(+;>?(O&[EdCO-gP
T_S5GDeff0DFc#_9QOH7-==[FH[#,,<VD\#H=Kb4)g5\<dL@_I2<;)cK6(BPg(#V
W.7J_>[G64-4,9IP6-+;2Z_]OWQSG;[J+WV5M668><F<+d8/>>EJTeI(Kb()QS?R
//EU]&<68:6f=\aaVUS@8,IdE@O9L]fKbMF62S6Q]Wb&Wc&?,5WMBAcV:_27W>d-
XgKVYXN&ZSbO01ZOQDG:JPG=-F(P0N#LdRJNJ9__Q-<33?/FC4RSH-72F6dV:#Id
EI<3,@TSO\cKRb3bL>KA_G99/2RR]K;;._#fL(Z^0OHgaD.M/HW5_N0+=fTbV-Bb
&DP_]_g7O[g:+74JC^XGJHR\L@5@IFYKB-dRA;)WLUWb18e^1-K71gQ2C-EZ0CW\
40[^d.ML+?9X+aef]Jg#a;Y7H?a:OObcGD=GGeFJ7=U:)7a4#2R_g=UL<-dbQJO9
O9\Je_BYN]E7ad+dLG7Ze2(Y]OX]8]4d#C@CDGMTKbdAVf<@Z6__8L:0e0/O/[_\
JY9@BJbDJ&[WT[K^Obd>A_/F>1S/8\QJ?N5X/0J9H_4K8SF5gS@BPbR+Mf^7PQH.
aW^Lg?XdFTS>IA2BI.fKXWc=GH8fP&03(DZ/GYI_7X<32Eb]>S>7&@AH>b:5]JM?
3JNdaJL<OcgQHO#K]bJN1G@d0LB<D40VJTG.I8Q.G^N)_A^J3:J4_:8MR/f^N^O[
H\d)E_[SQ])a1Z0--S+O0cTQb?OcGK0U@/Ze/4O&)Bb)@]-L:2bV=;LK,U(TS>XM
BZC\(VS:NJW\7UbcM@VR2Z/aC^RD>@0b;(g__&Z0TaJe9<BZ1R_e0N;a?e&\OW+X
2AY6;R,/8B)UfPXP^Sb.gL2:&-Vg0f7bN\\@Yd;\H)dX,&4Q,+M]G])@#&9TX4G^
E9a,X8R,4c?7SGNfO_D?Vb,],(?9]ZUJWF&O;6FKZKK-OJb.YLa#><\I2EE>dU>]
T)54B8Ig[]SacU.La=-/F[U/HQ:bCLf2/^b9]5^=Jd8>?/]STB1YXF6QDT=^WE_&
6DcU--Wf;Q)7IIUTNX,dRMM36JT<b#[TB9/;&[4HHI^^78a\J7c??+H69,G,b5Q9
1dd^L[0\;@G=3.V>;[M#U5:VgdKfC_4f0>.#^cQ<b_(ZT/b0D0_/bD&KD46E3/c@
4Y^2O3EX&3DK?</@PIMPSgbeP0b&H+,A_RTM;W_YY6J]0Z7Y-MLV@ZPA2K>M3B/e
dR@a.VX_.(>M,:3IOEP#65_1P&dg>SY<bH7SB+N&>ScA8PV<C[bZ1G?6cNW2_[.D
11G#K4f=6;+0G(=2&1>YE?^-:(D8(7\(9TT4eCg3BKYBMQ8Q\ROPVBP^^\))2TR]
:UYEL^ZdP]SDEL:(>gJAQ(A_F53QIYa_.LOcL@1TUI/&183GL;<:<)&P.NX=.;40
@II3:7UL3K_3\^PMI=IA/ER+)a5L<8@T0aF\C2a6De;#K-b;C7-1O,&XX0ID7B=G
ZFV1gaV3J6E:W+I5Z]OJQ9&>[b#4U\c=ec3bg.=G>/c)+Gb\M.T<81[]bK9X-Yb.
QJUY[L@;B,ZL1H;FWX+03[15.>)+;ZX[<;>1-SN.,L(?;[GRN\+NA<TKF1B<(N_N
.Y,ee,BgN78N_6N;^,3/Q#bD/81F5:/c>&\;D^AM:>NecZQU?K;WT0DXg5D29>c<
\X]X=Q:ZFS]?DW<<LYd5=f/PP^JWe(YSZ.-gWA>[Na-4B3ebJ:@Z60JVB/\4GOJ_
eL0:V2#68a?>a5Sda8I.6-AFdYg#<M>fg71?J3B<3-65I_G5Dgc?CK/?.dU=eVHH
R/H3VQ>d60DB<[X2D;LN0dA9d9X(<^,=2\0FS71S/EDBVW_7(CA8M&RNaK8(\8,C
&R\6LN<,AN[R^cN))gCa7X6H3WL2>+LW+<#T\e_S>MXf0LKB=Z/(=\5T8&J2,HGK
3V&]gT+3-N7Z/3&d5b7,OQ<AQV&:a4Y>]TVfBc:.)fdCTGWO8VdNXb7\FEFcN5bY
f8[6R>PH;8>2W/2-CCaET]0EL8gTNY-CEOA2Y]/#XX5@N_D0X.da<c?ZbLV;J7[S
D3d8UU5A^^<f?CSI[EJa6cTUSMLaZ,^H..<8\/YHU?@D(I<WUG60&Y8#M)ebbO4.
eW#[#CcM4J5&N?;bS,Y@G;\4S-8cHS#dK_eA^E;_g=VX9LTB,g34\5f9<Z1/9K4?
_GL<8C83X)I(94T;&gHeLDYcPIFY3JK_EB.a;aKg3g5^KSK[622fJW--)EZ0N9>I
MKXUdb^e04cReMeEf,&MNdSS[Z0Og[11T6>6.BXP&f>P^cN2M,>3JPg;f,J1YbcZ
QJOJ;J)1cO0)Q-VSb:&<5S,-3:<3:L9B:=.>^T9W8\b=b3@(d2aO(_W2V<g8X92U
X:KYLMP.&3CMU7MQ78;AdAWZX&^;7CYe@UL.4V[C;BM^fAG1U5,M#Y;TfbfNX\QJ
\=b<27J?Q+9^QET.(C37,/DBT&3/gLY)TG##:)T>][_1TW/3662UIATW;4D&@TYE
SgX^@2/fWbZ[d3O>8:,dERBWO>P1\Ke5D@VeVgT4=OS85CO;2ATXT03:/B1VF?,/
7;CGT:PAMbJD#P-RN.17d7+;Aa1U)?,Y+eS4],YECNYRDGTM1L_9OB@D,&Y;-L8g
.I(BMcOgcWBdX5bE)I\#B62E06KX88P9/GFDH1TZ6X.VW]7@/M+8gQ-LY49,=FZP
?T4b&(S3;Sa,NRQaI(NDTRX@3#WQD?4(9RO_P,QUQ,Y_V\APKV96P_?8ScJ:bZ.B
K_>>c5TI2feTBIKHK)2?]@WgY]0D9)7LN?FHe?7+VMST2DfE&PUfcQUJA:F&8S9,
N=3.ON-/<()?aT?9HJU_)Z#:(725Y^]>B0:G,H/>PQ]UYW4-32Q0>G2MF7+L(@2K
5N0^05ZI,6NX=&T,[8J&e35Yf6K-060eCFT<HKB59?=G,SUL=eADPGfQ>IK1-_FT
bNP:^9.T?2#5bG)K(L)]]TJY8@cP6O@]U2IS]&F.#=1#F;_OTG6g@3R>Vc90e5MG
L1T_XB[3,F8G#E8>cCIbJ_Q4U=__cY21M3E@49(;.5KcW,C55#b;9D5Ug#6.J=GF
+7-\@6-F]3]Vc@.M\[UH_f8[WJX)-Sc\C5(ZD<.bgT/,WZN7Zf[._:][AJ8?cGX.
8YS&<C3L@K/ERK&ZCX?^<[cNWb/2>AbNQEVg7T0X>gYZ7JFTLYe+OL][O$
`endprotected


`endif // SVT_AXI_SYSTEM_TRANSACTION_SV
