
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F2VAlcyI5vmPC4vjlAYLx1/Ts7QFCUyVnRAm3K9NDnKq1DLc/FCdm7zNWl3Dz5+a
xApv7x9vGA3fDR5kpAOz30RQBwh+qN+EqhW11rzC2n2jx/DgEhh9HJVthIJDCEC7
V2zkWvvP5BWT4HCw4yqF32G+Lx3HyE98GjJqwLzxF8Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
rxa9qfQfX1qW0FZnRelr5VAn8OQL5SplaR3WPfUNETOBbdFo5yPzKLjlEH8aLbKo
MHdip9gSoVKuvd3XRPmwnTsRmy/Co4HfdWrp6IjsAnuErSxeQRE0lGpmPvTeHqhd
P3nqPVGJrQ5lDBundOYXSgHgua3WJUgxtrupO3emsuHwVuzO9Kr2r/ODALGdxr2e
E6+V5nkNVa4whPfyNx9sJSPhzSV/GMNtymkY1TugKMwr7dnhp8JSbZ3iMFgPULhC
ht9lTFQ8sizfcXBhnJ8QEwa/pNiI559eAvUGf9oMyaFx6W6osTl23/Z4J7tGHoR6
60/G4hr5f/kUfKOLCip51WxdWv8Cm8ruJzj6q5f+37YWAQBV+5f556AD6hX4pQoh
Qmvjw6sh3hf+QNjAsmluWV57R0FixgMzvel7FXu9KmwL/URtI4lcA37n9NhcpISF
xS7WPzMmt+qzQtDbFEVhHMyjoIR/MztplApp7YEozPgBVoUFSxBvy7FZgWO498vE
aZftas/BlsA+UwyPmxCI1TToARlUmM/hykOuTmETgNO/Ds/jM2gTZSxA42Zwr3AU
RPp+Kk3Azw0oF6QLA2TkHVcsPRb9cHCGQmRwhuhFjKIg4Fk3LvfvNHCxJZSthLKa
TKzF8UmlsuHzJbqWlBkn8TRakU3NPgRcayANb1XBalXL7Mr/PlKrjpdalsM159AC
O7IkPDyTqHlfAV2FQ8Jg7o/R1yOOD/qEJUrF+/oBHGHAca4TLvrODChpQ2gZ0VP6
9ktJoJbqg13rSirv8qecnUB5ceqNz1+PCKK40w8u6oGf6kg+4heNdAUXuBvSDv4L
0VLAWkID5WosTJpsn5ofP5Bh2/tv6Vo5n4Q+ee/jMe6mGhcRAWQC+cgEt2FjCYyn
eQOQaeRRv8ZI5J2FXO6j8rSwEl5zYUy2fKU0nciZLc+G39ILO1sUG3MTES7vV2OM
2Ou5Bewnrah7GnBip26BmWdi1TH3SliEQGfF3ZiVNJS2Asv0YhTOKdfY/lS7Rqgz
WB7wj95J/oYKl3LnYrKPSw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N4OgRvr4XcFQc1fZ/q9yytBwqWmvAsUlHkBp7OeBtL2RYwU3SLtD23enHO3LsSWi
J9ac5k0sjjU5+1PKidBaTNbtrwb+LQv1TjkJev5PBIQvhnOCjBCzUECnZrBEoiS1
7zleBQwSq/EnxQ9uu1YejzdfN1Ld+J9H39T7uwPYCvc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8762      )
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
`pragma protect end_protected

`endif // SVT_AXI_SYSTEM_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TcSV/tk9wkNurnsGjoL8jkLJ+WyUALq2+x4pEch8quzVHDDcLGa2l8rthYhnbFvv
vfPzqUDckadLGv23SiesedSr2pE14wYIssUE6f9pStEERhUk8fikeIOjOgu+oIJ1
1E2SPqjdcGLX/7v93gKJ7oB1Uyt5IR8ouChRuYaMCwc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8845      )
KC5leFQLwmkYX9OjU/ExWNSch+iz7a75CGQ1/s2Ay5uvn3hIJ0oo7kuf7tL/BpqF
dfotFmLGuNMB1dtgjHNrjtpAkpZtqJql0AL5Ndc8zJl4N0EL8G73HFShh3myZiDi
`pragma protect end_protected
