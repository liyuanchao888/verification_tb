
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
E1BeGhFh1mLwZJeJL/8wblaBSi4/LcryZMd2sKJ6Xl4Nr6jz3FNnTsotebMgmHPE
ohHThHRPoxCXj5q7CPBPi8OmvNuBLZQ/ZdBLYTHPQBK1lB7ZdhA/sHxtFPByEwzJ
ElzDZehJ9wH2+U/7e1SvxZvKCLKeTry5tEV0d/niWhlGbsVdx1CLGA==
//pragma protect end_key_block
//pragma protect digest_block
73r7Z4jXZf9CFqArE9DtP/G+TJk=
//pragma protect end_digest_block
//pragma protect data_block
zgl8Nf32yg/0/ZbxpGBOu6LDXcR86C8lrJzk5/lDss9KxqfNxBH8caoFUzDEsYXE
ruUgwODbG12z/5yG71shAVJf4sCP86RmeheeKuWAX1C3tI3cnKAsYJrudiI58a30
YjH1+FbxPQvkMWcID7wkSxAWJjoQTjHMTpRJjW7w6XaMSxNXKlo9nUYpxc96yClR
eCI1Nxb3vMQH6Ixv6esusyN4Au0ucgQFpQiK3ff94hdmYdN8H6+WW6H9pP3JBv0x
F+fzv+QDhk/hhbMuIZl7BVH5kpHkNQreSWf4y/NgfiMcj9dfjbejO0gCvRl5zR6x
53o9VZOSZqRH9v/omVrW5E8S47GeDDSkPXW9ye5wcRIwGQ8tezhaz3/4/yJ8KKXU
aFuIQtQpdFMRFN4T3oFT9krnhazar1OUeqDwD+bowmjLLkceUbSjXfSoSh01LMbC
pLm8F3cctXaHHXkBPdXxeKf5f77pOgQEdDO8jpCrj5doELq+YlI0MlwCQ03/sPO2
ArhXku6GSA8tsmgmxph2xhJeLvxoP4kLDRVGYpDhz77kkOn5fY/F+glQvI46j8Aa
+5gUpTvf7ijY3x+nVsZdFDV9VmGcRbw6n4+JikOl1i0IXYTqq5g/0H7U4cpIfhkp
TE9XTyllXfCeSH/kmIeiNbGH64++RVRfcR+EfDsC+R26snKImJN5l/OvGmjTWTim
QrHVqjrXoR+pbZgwh/Ay+l5fSL0I9fFa4g+475no0egHJiYJs090HhuYRFvXTpkJ
OVtEpob+mWrrXZqDIYy9euW0+rcr0HGJo7SbahFqdRRgDQEaT3iASvfPp7lZblOv
7J/b2BK8kgjhJDh7PrZkG/3Bw0G+1q4EF/Ivi4xcDz96qYhzrW/BKF7wNuux3BqW
deoBqP2UjBGc4MMIRJbx47YYS489giLHwHAs+Y2tJaMd2LPh226N0PC5XmNnZh4n
ZLjuMsHk6EInVUhpwYgYeBe8rVQD9GMWOEICGq5p9lK+GnKd2+zP4v/yxF+2YYND
WjcpNXlWPMLCGQT6iY2+yI7z4eT0BaT8YKNxxaLWNEu288DdV3QDrwq+M9p9zpPa
GK8l1CR15gNNNsMygAk6sWi/9Pcu8m1ZmR+wP/ECQPhxiwBoDLqtbWmkeAw2ZJz+
5qZkQt+/scSL+cn7AdgLiGwIftGcLl3G/aytLfo+OXYbOjp0l2mzpXYFOYBam0fA
XJJoCq6/l6HSdHTKJLbo5iz6Ex691546K/wbvh1OQ9c=
//pragma protect end_data_block
//pragma protect digest_block
4xPMejHxIQ/Io3dBUxviEU3AE2Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JJAMcozxOr3CiQdSsbvUYTsrJpTXIXgsFn3ihDghCIylYdjfHhvdF0If1BxXqnIR
0VdHZU1mlvTtO/jnyB2FjfjqTf683PiURTlHLzklQEu52V2DbS/YiGzMTGqm8PEt
IKbIBd2V3E6O6Jky81k/YHtSM8mCQS7JpaOtv4iv+M7u6JE5scSWZQ==
//pragma protect end_key_block
//pragma protect digest_block
JPpnv5TxCiIcurdw6U7/AWA/uRg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
1BULJh8QgumPXMTEybvf45VJjTI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_AXI_SYSTEM_TRANSACTION_SV
