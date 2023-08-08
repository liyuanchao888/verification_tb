
`ifndef GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_axi_defines.svi"

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_axi_system_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_axi_system_configuration handle as an argument, which is used
 * for shaping the coverage.
 */

class svt_axi_system_monitor_def_cov_callback extends svt_axi_system_monitor_def_cov_data_callback;
/** Virtual interface to use */
virtual svt_axi_master_if.svt_axi_monitor_modport axi_monitor_mp;
`ifndef SVT_AXI_EXCLUDE_AXI_SYSTEM_COVERAGE
  // ****************************************************************************
  // AXI4 Covergroups
  // ****************************************************************************
    int ix;

    int count_ace = 0 ;
    int count_ace_lite = 0;
    int count_interleave_port_ace = 0;

  /**
    * Covergroup: system_axi_master_to_slave_access
    *
    * Coverpoints:
    *
    * - provides coverage for master to slave accessibility. It tries to measure
    *   whether each axi master read from or write into every connected axi slaves
    *   in the system or not. This is captured as a unique master-slave access pair-id
    *   i.e. each master and slave pair is given an unique id represented as an 
    *   individual coverage bin. Following example describes how this pair-id can be
    *   decoded to which {master, slave} pair it belongs to, is given below.
    * 
    * - Example: system configuration:: num_masters = 3, num_slaves = 2 <br> 
    *   Total possible unique values of master_slave_pair_id {0..5} <br>
    *   <b> master_id = INT(master_slave_pair_id / num_slaves) [integer quotient] </b> <br>
    *   <b> slave_id  =    (master_slave_pair_id % num_slaves)  </b> <br>
    *   If coverage report shows id as 3 then master_id = INT(3/2) = 1, slave_id = (3%2) = 1 <br>
    *   So, the master-slave access pair, this particular bin has covered, is {master-1, slave-1} <br>
    * 
    * - master_to_slave_pair_id: Captures each master to slave access pair id value
    *   Ignore Bins : depending on the nature of system, user may not be interested in some
    *   master-slave pair accesses. User can do this in following two ways:
    *
    * - Example: system configuration:: num_masters = 3, num_slaves = 2 <br>
    *   Total possible unique values of master_slave_pair_id {0..5} <br>
    *   Master-Slave pairs to be ignored are {1,3,4}  <br>
    *
    * - User can do this in following two ways:
    *   - VIP Built-in IGNORE_BIN define: VIP provides following "define" macro
    *     <b> `IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id </b> <br>
    *     User can just define following callback hook to include the master-slave pair id values which should be ignored. <br>
    *     `define IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id ignore_bins <bin_name> = {1,[3:4]}; <br>
    *     NOTE: ignore bin name is completely user defined, VIP doesn't have any restriction for this.
    *   - user can override the covergroup by extending the callback class and re-defining this covergroup
    *   - user can disable this covergroup and define their own covergroup extending this coverage callback class
    *   .
    * .
    */
  covergroup system_axi_master_to_slave_access (int num_master, int num_slave);
    axi_master_to_slave_access : coverpoint master_to_slave_pair_id {
      bins master_to_slave_pair_id[] = {[0 : ((num_master*num_slave))-1]};
      `IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id
          
      option.at_least = `SVT_AXI_system_axi_master_to_slave_access_axi_master_to_slave_access_COV_OPTION_AT_LEAST_VAL;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_axi_master_to_slave_access_range
    *
    * Coverpoints:
    *
    * - provides coverage for master to slave accessibility. It tries to measure
    *   whether each axi master read from or write into every connected axi slaves
    *   in the system or not. This is captured as a unique master-slave access pair-id
    *   i.e. each master and slave pair is given an unique id represented as an 
    *   individual coverage bin. Following example describes how this pair-id can be
    *   decoded to which {master, slave} pair it belongs to, is given below.
    *  
    *   (num_master*num_slave)/6 should not be equal to zero are needed for this covergroup 
    * 
    * - Example: system configuration:: num_masters = 3, num_slaves = 2 <br> 
    *   Total possible unique values of master_slave_pair_id {0..5} <br>
    *   <b> master_id = INT(master_slave_pair_id / num_slaves) [integer quotient] </b> <br>
    *   <b> slave_id  =    (master_slave_pair_id % num_slaves)  </b> <br>
    *   If coverage report shows id as 3 then master_id = INT(3/2) = 1, slave_id = (3%2) = 1 <br>
    *   So, the master-slave access pair, this particular bin has covered, is {master-1, slave-1} <br>
    * 
    * - master_to_slave_pair_id: Captures each master to slave access pair id value
    *   Ignore Bins : depending on the nature of system, user may not be interested in some
    *   master-slave pair accesses. User can do this in following two ways:
    *
    * - Example: system configuration:: num_masters = 3, num_slaves = 2 <br>
    *   Total possible unique values of master_slave_pair_id {0..5} <br>
    *   Master-Slave pairs to be ignored are {1,3,4}  <br>
    *
    * - User can do this in following two ways:
    *   - VIP Built-in IGNORE_BIN define: VIP provides following "define" macro
    *     <b> `IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id </b> <br>
    *     User can just define following callback hook to include the master-slave pair id values which should be ignored. <br>
    *     `define IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id ignore_bins <bin_name> = {1,[3:4]}; <br>
    *     NOTE: ignore bin name is completely user defined, VIP doesn't have any restriction for this.
    *   - user can override the covergroup by extending the callback class and re-defining this covergroup
    *   - user can disable this covergroup and define their own covergroup extending this coverage callback class
    *   .
    * .
    */
  covergroup system_axi_master_to_slave_access_range (int num_master, int num_slave);
    axi_master_to_slave_access : coverpoint master_to_slave_pair_id {
      bins master_to_slave_pair_id_0[] = {[0 : ((num_master*num_slave)/6)-1]};
      bins master_to_slave_pair_id_1[] = {[((num_master*num_slave)/6):(2*((num_master*num_slave)/6))-1]};
      bins master_to_slave_pair_id_2[] = {[(2*((num_master*num_slave)/6)):(3*((num_master*num_slave)/6))-1]};
      bins master_to_slave_pair_id_3[] = {[(3*((num_master*num_slave)/6)):(4*((num_master*num_slave)/6))-1]};
      bins master_to_slave_pair_id_4[] = {[(4*((num_master*num_slave)/6)):(5*((num_master*num_slave)/6))-1]};
      bins master_to_slave_pair_id_5[] = {[(5*((num_master*num_slave)/6)):(6*((num_master*num_slave)/6))-2]};
      bins master_to_slave_pair_id_6[] = {[(6*((num_master*num_slave)/6))-1:(num_master*num_slave)-1]};
      `IGNORE_BINS_CG_system_axi_master_to_slave_access_CP_master_to_slave_pair_id
          
      option.at_least = `SVT_AXI_system_axi_master_to_slave_access_axi_master_to_slave_access_COV_OPTION_AT_LEAST_VAL;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_ace_concurrent_readunique_cleanunique
    *
    * Coverpoints:
    *
    * - ace_concurrent_readunique_cleanunique:  This is covered when multiple ACE masters
    *   concurrently(that are simultaneously active) initiate ReadUnique or CleanUnique transactions.
    *
    * Two or more ACE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; Section C1.3.4 
    *
    */
  covergroup system_ace_concurrent_readunique_cleanunique @(cov_sys_concurrent_readunique_cleanunique_sample_event);
    ace_concurrent_readunique_cleanunique: coverpoint concurrent_readunique_cleanunique {
      bins readunique_readunique = {16'h05_05};
      bins readunique_cleanunique = {16'h05_09,16'h09_05};
      bins cleanunique_cleannique = {16'h09_09};
    }
    option.per_instance = 1;
  endgroup

  covergroup system_interleaved_ace_concurrent_outstanding_same_id( int interleave_group_id );
    interleaved_ace_concurrent_outstanding_same_id: coverpoint concurrent_outstanding_group_id {
      bins concurrent_outstanding_same_id_group_id[] = {[0 :(interleave_group_id - 1)]};
          }
    option.per_instance = 1;
  endgroup


 /**
    * Covergroup: system_ace_concurrent_overlapping_coherent_xacts
    * The covergroup system_ace_concurrent_overlapping_coherent_xacts covers coherent transactions initiated from different ACE masters concurrently on the same address.
    * The covergroup needs atlease two ACE masters to be present in the system.
    * Coverpoints:
    *
    * - coherent_xact_on_ace_master_port:  This coverpoint covers svt_axi_transaction::coherent_xact_type transaction . All coherent transactions capable of generating snoop are bins of this coverpoint .
    * - coherent_xact_on_other_ace_master_port_in_system : This coverpoint covers svt_axi_transaction::coherent_xact_type transactions . All coherent transactions capable of generating snoop are bins of this coverpoint .
    * .
    *  Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; 
    */

 covergroup system_ace_concurrent_overlapping_coherent_xacts ;
        coherent_xact_on_ace_master_port: coverpoint coherent_xact_on_port1{
   bins coherent_readonce_xact            = {svt_axi_transaction::READONCE} ;
   bins coherent_readshared_xact          = {svt_axi_transaction::READSHARED};
   bins coherent_readclean_xact           = {svt_axi_transaction::READCLEAN};
   bins coherent_readnotshareddirty_xact  = {svt_axi_transaction::READNOTSHAREDDIRTY};
   bins coherent_readunique_xact          = {svt_axi_transaction::READUNIQUE};
   bins coherent_cleanunique_xact         = {svt_axi_transaction::CLEANUNIQUE};
   bins coherent_makeunique_xact          = {svt_axi_transaction::MAKEUNIQUE};
`ifdef ENABLE_ACE2_COVERAGE
   bins coherent_cleansharedpersist_xact         = {svt_axi_transaction::CLEANSHAREDPERSIST};
`endif
   bins coherent_cleanshared_xact         = {svt_axi_transaction::CLEANSHARED};
   bins coherent_cleaninvalid_xact        = {svt_axi_transaction::CLEANINVALID};
   bins coherent_makeinvalid_xact         = {svt_axi_transaction::MAKEINVALID};
   bins coherent_writeunique_xact         = {svt_axi_transaction::WRITEUNIQUE};
   bins coherent_writelineunique_xact     = {svt_axi_transaction::WRITELINEUNIQUE};
  }
         coherent_xact_on_other_ace_master_port_in_system : coverpoint coherent_xact_on_port2{
   bins coherent_readonce_xact            = {svt_axi_transaction::READONCE} ;
   bins coherent_readshared_xact          = {svt_axi_transaction::READSHARED};
   bins coherent_readclean_xact           = {svt_axi_transaction::READCLEAN};
   bins coherent_readnotshareddirty_xact  = {svt_axi_transaction::READNOTSHAREDDIRTY};
   bins coherent_readunique_xact          = {svt_axi_transaction::READUNIQUE};
   bins coherent_cleanunique_xact         = {svt_axi_transaction::CLEANUNIQUE};
   bins coherent_makeunique_xact          = {svt_axi_transaction::MAKEUNIQUE};
`ifdef ENABLE_ACE2_COVERAGE
   bins coherent_cleansharedpersist_xact         = {svt_axi_transaction::CLEANSHAREDPERSIST};
`endif
   bins coherent_cleanshared_xact         = {svt_axi_transaction::CLEANSHARED};
   bins coherent_cleaninvalid_xact        = {svt_axi_transaction::CLEANINVALID};
   bins coherent_makeinvalid_xact         = {svt_axi_transaction::MAKEINVALID};
   bins coherent_writeunique_xact         = {svt_axi_transaction::WRITEUNIQUE};
   bins coherent_writelineunique_xact     = {svt_axi_transaction::WRITELINEUNIQUE};
 }
    ace_concurrent_overlapping: cross coherent_xact_on_ace_master_port ,coherent_xact_on_other_ace_master_port_in_system  {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /** 
    * Covergroup: system_ace_coherent_and_snoop_association_recommended 
    * 
    * Coverpoints: 
    * 
    * - ace_coh_and_snp_association:  This is covered when the interconnect issues recommended 
    *   snoop transaction to the snooped masters, in response to the coherent  
    *   transaction received from the initiating master.  
    * . 
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; Table C6-1 
    * 
    */ 
  covergroup system_ace_coherent_and_snoop_association_recommended @(cov_sys_coh_and_snp_association_sample_event); 
    ace_coh_and_snp_association: coverpoint coh_and_snp_association { 
      bins readonce_coherent_to_readonce_snoop = {16'h01_00}; 
      bins readclean_coherent_to_readclean_snoop = {16'h03_02};  
      bins readnotshareddirty_coherent_to_readnotshareddirty_snoop = {16'h04_03}; 
      bins readshared_coherent_to_readshared_snoop = {16'h02_01}; 
      bins readunique_coherent_to_readunique_snoop = {16'h05_07}; 
      bins cleanunique_coherent_to_cleaninvalid_snoop = {16'h06_09}; 
      bins makeunique_coherent_to_makeinvalid_snoop = {16'h07_0d}; 
`ifdef ENABLE_ACE2_COVERAGE
   bins cleansharedpersist_coherent_to_cleanshared_snoop  = {16'h0a_08};
`endif
      bins cleanshared_coherent_to_cleanshared_snoop = {16'h08_08}; 
      bins cleaninvalid_coherent_to_cleaninvalid_snoop = {16'h09_09}; 
      bins makeinvalid_coherent_to_makeinvalid_snoop = {16'h0d_0d}; 
      bins writeunique_coherent_to_cleaninvalid_snoop = {16'h0f_09}; 
      bins writelineunique_coherent_to_makeinvalid_snoop = {16'h10_0d}; 
    } 
    option.per_instance = 1; 
  endgroup 
 
  /** 
    * Covergroup: system_ace_coherent_and_snoop_association_recommended_and_optional 
    * 
    * Coverpoints: 
    * 
    * - ace_coh_and_snp_association:  This is covered when the interconnect issues recommended 
    *   and optional snoop transaction to the snooped masters, in response to the coherent  
    *   transaction received from the initiating master.  
    * . 
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; Table C6-1 
    * 
    */ 
  covergroup system_ace_coherent_and_snoop_association_recommended_and_optional @(cov_sys_coh_and_snp_association_sample_event); 
    ace_coh_and_snp_association: coverpoint coh_and_snp_association { 
      bins readonce_coherent_to_readonce_snoop = {16'h01_00}; 
      bins readonce_coherent_to_readclean_snoop = {16'h01_02};  
      bins readonce_coherent_to_readnotshareddirty_snoop = {16'h01_03}; 
      bins readonce_coherent_to_readshared_snoop = {16'h01_01}; 
      bins readonce_coherent_to_readunique_snoop = {16'h01_07}; 
      bins readonce_coherent_to_cleaninvalid_snoop = {16'h01_09}; 
      bins readonce_coherent_to_cleanshared_snoop = {16'h01_08}; 
      bins readclean_coherent_to_readclean_snoop = {16'h03_02};  

      bins readclean_coherent_to_readnotshareddirty_snoop = {16'h03_03}; 
      bins readclean_coherent_to_readshared_snoop = {16'h03_01}; 
      bins readclean_coherent_to_readunique_snoop = {16'h03_07}; 
      bins readclean_coherent_to_cleaninvalid_snoop = {16'h03_09}; 
  
      bins readnotshareddirty_coherent_to_readclean_snoop = {16'h04_02}; 
      bins readnotshareddirty_coherent_to_readnotshareddirty_snoop = {16'h04_03}; 
      bins readnotshareddirty_coherent_to_readshared_snoop = {16'h04_01}; 
      bins readnotshareddirty_coherent_to_readunique_snoop = {16'h04_07}; 
      bins readnotshareddirty_coherent_to_cleaninvalid_snoop = {16'h04_09}; 
  
      bins readshared_coherent_to_readclean_snoop = {16'h02_02};  
      bins readshared_coherent_to_readnotshareddirty_snoop = {16'h02_03}; 
      bins readshared_coherent_to_readshared_snoop = {16'h02_01}; 
      bins readshared_coherent_to_readunique_snoop = {16'h02_07}; 
      bins readshared_coherent_to_cleaninvalid_snoop = {16'h02_09}; 
  
      bins readunique_coherent_to_readunique_snoop = {16'h05_07}; 
      bins readunique_coherent_to_cleaninvalid_snoop = {16'h05_09}; 
  
      bins cleanunique_coherent_to_readunique_snoop = {16'h06_07}; 
      bins cleanunique_coherent_to_cleaninvalid_snoop = {16'h06_09}; 
  
      bins makeunique_coherent_to_readunique_snoop = {16'h07_07}; 
      bins makeunique_coherent_to_cleaninvalid_snoop = {16'h07_09}; 

      bins makeunique_coherent_to_makeinvalid_snoop = {16'h07_0d};
 
`ifdef ENABLE_ACE2_COVERAGE
      bins cleansharedpersist_coherent_to_readunique_snoop = {16'h0a_07}; 
      bins cleansharedpersist_coherent_to_cleaninvalid_snoop = {16'h0a_09}; 
      bins cleansharedpersist_coherent_to_cleanshared_snoop = {16'h0a_08}; 

`endif
  
      bins cleanshared_coherent_to_readunique_snoop = {16'h08_07}; 
      bins cleanshared_coherent_to_cleaninvalid_snoop = {16'h08_09}; 
      bins cleanshared_coherent_to_cleanshared_snoop = {16'h08_08}; 
  
      bins cleaninvalid_coherent_to_readunique_snoop = {16'h09_07}; 
      bins cleaninvalid_coherent_to_cleaninvalid_snoop = {16'h09_09}; 
  
      bins makeinvalid_coherent_to_readunique_snoop = {16'h0d_07}; 
      bins makeinvalid_coherent_to_cleaninvalid_snoop = {16'h0d_09}; 
      bins makeinvalid_coherent_to_makeinvalid_snoop = {16'h0d_0d}; 
  
      bins writeunique_coherent_to_readunique_snoop = {16'h0f_07}; 
      bins writeunique_coherent_to_cleaninvalid_snoop = {16'h0f_09}; 
  
      bins writelineunique_coherent_to_readunique_snoop = {16'h10_07}; 
      bins writelineunique_coherent_to_cleaninvalid_snoop = {16'h10_09}; 
      bins writelineunique_coherent_to_makeinvalid_snoop = {16'h10_0d}; 
    } 
    option.per_instance = 1; 
  endgroup 
  
  /**
    * Covergroup: system_ace_dirty_data_write
    *
    * Coverpoints:
    *
    * - master_xact_of_ic_dirty_data_write:  This is covered when the interconnect issues a write
    * to the slave because dirty data was returned by one of the snoop responses and that
    * dirty data could not be returned to the master that initiated the original transaction 
    *
    * - ace_snoop_returns_data : This is covered only when one snoop returns a dirty data.
    * One or more ACE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 13.4 
    *
    */

  covergroup system_ace_dirty_data_write @(cov_sys_ic_dirty_data_write_sample_event);
    ace_dirty_data_write: 
    coverpoint master_xact_of_ic_dirty_data_write.coherent_xact_type {
      bins readonce_dirty_data_write = {svt_axi_transaction::READONCE};
      bins readclean_dirty_data_write = {svt_axi_transaction::READCLEAN};
      bins readnotshreaddirty_dirty_data_write = {svt_axi_transaction::READNOTSHAREDDIRTY};
      bins cleaninvalid_dirty_data_write = {svt_axi_transaction::CLEANINVALID};
`ifdef ENABLE_ACE2_COVERAGE
   bins coherent_cleansharedpersist_xact         = {svt_axi_transaction::CLEANSHAREDPERSIST};
`endif
      bins cleanshared_dirty_data_write = {svt_axi_transaction::CLEANSHARED};
      bins cleanunique_dirty_data_write = {svt_axi_transaction::CLEANUNIQUE};
      bins writeunique_dirty_data_write = {svt_axi_transaction::WRITEUNIQUE};
    }

    ace_snoop_returns_data: coverpoint only_one_snoop_returns_data {
      bins only_one_snoop_returns_data = {1};
    }

    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_ace_cross_cache_line_dirty_data_write
    *
    * Coverpoints:
    *
    * - ace_snoop_returns_data : This is covered only when one snoop returns a dirty data.
    * - wstrb_of_dirty_data : This will indicate whether the wstrb value of
    *   the dirty data is full cacheline or partial cacheline.
    * - ace_cross_cache_line_dirty_data_write:  This is covered under the following
    * conditions:
    *  - The interconnect may need to snoop multiple cachelines for a
    *  WRITEUNIQUE or READONCE transaction because it spans multiple cache
    *  lines.
    *  - Atleast one or more snoop transactions return dirty data.
    *  - The interconnect writes the dirty data of the snoop transactions to slave.
    * One or more ACE masters needed for this covergroup
    *  .
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 13.4 
    *
    */
  covergroup system_ace_cross_cache_line_dirty_data_write @(cov_sys_ic_cross_cache_line_data_write_sample_event);
    ace_cross_cache_line_dirty_data_write: 
    coverpoint master_xact_of_ic_dirty_data_write.coherent_xact_type {
      bins readonce_cross_cache_line_dirty_data_write = {svt_axi_transaction::READONCE};        
      bins writeunique_cross_cache_line_dirty_data_write = {svt_axi_transaction::WRITEUNIQUE};        
    }

    ace_snoop_returns_data: coverpoint only_one_snoop_returns_data {
      bins only_one_snoop_returns_data = {1};
    }

    wstrb_of_dirty_data : coverpoint cov_wstrb {
      bins partial_cacheline_wstrb = {0};
      bins full_cacheline_wstrb = {1};
    }

    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ace_snoop_and_memory_returns_data
    *
    * Coverpoints:
    *
    * - ace_snoop_and_memory_read_timing:  This cover point covers possible
    * relative timings of snoop generation by the interconnect with respect to
    * receiving speculative read data by the interconnect and bin snoop_returns_data_and_memory_not_returns_data 
    * covers if a transaction is found with snoop data transfer and without associated slave transaction. The 
    * various timings covered are:
    *  - snoop issued before the first read data beat is received through speculative read transaction
    *  - snoop issued after the last beat of read data is received through speculative read transaction
    *  - snoop issued while the read data is being received through speculative read transaction
    *  .
    * - ace_snoop_and_memory_returns_data_xact_type: Covers the various coherent
    * transaction types for which speculative read was issued. The transaction
    * types covered are READONCE, READCLEAN READNOSHAREDDIRTY, READUNIQUE and
    * READSHARED transactions
    *
    * At least two ACE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 6.5.1 
    *
    */
  covergroup system_ace_snoop_and_memory_returns_data;
    ace_snoop_and_memory_data_timing:
    coverpoint snoop_and_memory_read_timing {
      bins snoop_data_before_memory_data = {SNOOP_BEFORE_MEMORY_READ};
      bins snoop_data_along_with_memory_data = {SNOOP_ALONG_WITH_MEMORY_READ};
      bins snoop_data_after_memory_data = {SNOOP_AFTER_MEMORY_READ};
      bins snoop_returns_data_and_memory_not_returns_data = {SNOOP_RETURNS_DATA_AND_MEMORY_NOT_RETURNS_DATA};
    }

    ace_snoop_and_memory_returns_data_xact_type:
    coverpoint fully_correlated_master_xact.coherent_xact_type {
      bins readonce_snoop_and_memory_returns_data = {svt_axi_transaction::READONCE};
      bins readclean_snoop_and_memory_returns_data = {svt_axi_transaction::READCLEAN};
      bins readnotshreaddirty_snoop_and_memory_returns_data = {svt_axi_transaction::READNOTSHAREDDIRTY};
      bins readunique_snoop_and_memory_returns_data  = {svt_axi_transaction::READUNIQUE};
      bins readshared_snoop_and_memory_returns_data  = {svt_axi_transaction::READSHARED};
    }

    snoop_memory_timing_and_xact_cross : cross ace_snoop_and_memory_data_timing, ace_snoop_and_memory_returns_data_xact_type;
    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_ace_valid_read_channel_valid_overlap
    * 
    * This covergroup is cross coverage related to DVM and it will cover whenever ARVALID is 1,  ARREADY is 0, 
    * DVM outstanding on the read channel is reached at the DUT, ACVALID is 0 and ACREADY is 1
    *
    * Coverpoints:
    * - arvalid : Captures ARVALID ==1
    * - arready : Captures ARREADY == 1
    * - acvalid_val : Captures ACVALID =0
    * - acready : Captures ACREADY=1 
    * .
    * Cross coverpoints:
    *
    * - overlap_arvalid_arready_acvalid_acready_corss : Crosses coverpoints arvalid arready acvalid_val acready
    * .
    */
   covergroup system_ace_valid_read_channel_valid_overlap;
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_ARVALID_1
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_ARREADY_1
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_ACVALID_0
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_DVM_OVERLAP_COVER_ACREADY
    overlap_arvalid_arready_acvalid_acready_corss : cross  arvalid,arready,acvalid_val,acready {
    option.weight = 1;}
    option.per_instance = 1;
    endgroup
 
  /**
    * Covergroup: system_ace_valid_write_channel_valid_overlap
    *
    * This covergroup is cross coverage related to DVM and it will cover whenever AWVALID is 1, AWREADY is 0, 
    * DVM outstanding is reached, ACVALID=0 and ACREADY=1
    *
    * Coverpoints:
    * - awvalid : Captures AWVALID ==1
    * - awready : Captures AWREADY == 1
    * - acvalid_val : Captures ACVALID =0
    * - acready : Captures ACREADY=1
    * .
    * Cross coverpoints:
    *
    * - overlap_awvalid_awready_acvalid_acready_corss : Crosses coverpoints awvalid awready acvalid_val acready
    * .
    */
   covergroup system_ace_valid_write_channel_valid_overlap;
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_AWVALID_1
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_AWREADY_1
   `SVT_ACE_SYS_MONITOR_DEF_COV_UTIL_ACVALID_0
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_DVM_OVERLAP_COVER_ACREADY
   overlap_awvalid_awready_acvalid_acready_corss : cross awvalid,awready,acvalid_val,acready {
   option.weight = 1 ;}
   option.per_instance = 1;
   endgroup

   /**
    * Covergroup: system_ace_write_during_speculative_fetch
    *
    * Coverpoints:
    *
    * - ace_write_during_speculative_fetch:  This cover point covers the following condition: 
    * A master issues a read transaction. This results in interconnect
    * generating snoop transactions towards other masters within the domain.
    * The interconnect also generates speculative read transaction for this
    * location. Speculative transaction returns data while the snoop
    * transactions do not return data. The snoop transactions may not return
    * data, either because there is no entry in the snooped masters' caches or
    * a WRITEBACK/WRITECLEAN of dirty data is in progress. The interconnect now
    * detects that a write transaction (the WRITEBACK/WRITECLEAN which is in
    * progress) is received for the same address for which it did a speculative
    * fetch. In such situation, interconnect performs another read from main
    * memory, as originally received data from speculative read is now stale
    *
    * At least two ACE master needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 6.5.1
    *
    */
  covergroup system_ace_write_during_speculative_fetch @ (cov_sys_overlapped_write_xacts_during_speculative_fetch_sample_event);
    ace_write_during_speculative_fetch:
    coverpoint fully_correlated_master_xact.coherent_xact_type {
      bins overlapping_write_during_readonce = {svt_axi_transaction::READONCE};
      bins overlapping_write_during_readclean = {svt_axi_transaction::READCLEAN};
      bins overlapping_write_during_readnotshareddirty = {svt_axi_transaction::READNOTSHAREDDIRTY};
      bins overlapping_write_during_readunique = {svt_axi_transaction::READUNIQUE};
      bins overlapping_write_during_readshared = {svt_axi_transaction::READSHARED};
    }
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ace_xacts_with_high_priority_from_other_master_during_barrier
    *
    * Coverpoints:
    * - ace_xacts_with_high_priority_from_other_master_during_barrier:  
    * This cover point covers the following condition: When the interconnect
    * receives barrier from a master, then all other transactions launched by
    * other masters in that domain may be stalled. This cover point covers
    * condition where master issues transactions with non-zero QOS value. Then
    * another master issues a barrier transaction within the same domain.
    *
    * Two or more ACE/ACE_LITE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 8.1 
    *
    */
  covergroup system_ace_xacts_with_high_priority_from_other_master_during_barrier @ (cov_sys_barrier_during_active_xacts_on_other_port_sample_event);
    ace_xacts_with_high_priority_from_other_master_during_barrier: coverpoint is_xacts_from_other_master_during_barrier_covered {
      bins xacts_from_other_master_during_barrier = {1};
    }
    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_ace_barrier_response_with_outstanding_xacts
    *
    * Coverpoints:
    * - ace_completed_barrier_type: This is covered when there are outstanding
    * transactions in the queue of a master when the response to a barrier is
    * received. There are multiple ways in which an interconnect can handle
    * barriers. Some interconnects may send response to a barrier only after
    * all outstanding transactions are complete. Others may forward
    * the barrier downstream and wait for the response of the downstream
    * barrier before responding to the original barrier. In such a case there
    * could be outstanding transactions in the queue of the master when a
    * barrier response is received. This coverpoint covers the latter behaviour.
    *
    * One or more ACE/ACE_LITE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; C 8.3 
    */
  covergroup system_ace_barrier_response_with_outstanding_xacts @(cov_barrier_response_with_outstanding_xacts_sample_event);
    ace_completed_barrier_type : 
    coverpoint completed_barrier_xact.barrier_type {
      bins outstanding_xacts_during_memory_barrier = {svt_axi_transaction::MEMORY_BARRIER};
      bins outstanding_xacts_during_sync_barrier = {svt_axi_transaction::SYNC_BARRIER};
      ignore_bins ignore_barrier_type = {svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER,svt_axi_transaction::NORMAL_ACCESS_IGNORE_BARRIER};
    }
    option.per_instance = 1;
  endgroup

  /**
    * Covergroup: system_ace_store_overlapping_coherent_xact
    *
    * Coverpoints:
    *
    * - store_overlap_coh_xact:  This cover point has follwoing bins<br>
    *   overlap_readunique_readunique: This bin gets hit when two or more masters issue readunique coherent transactions to overlapping cacheline simultaneously.<br>
    *   overlap_cleanunique_cleanunique: This bin gets hit when two or more masters issue cleanunique coherent transactions to overlapping cacheline simultaneously.<br>
    *   overlap_makeunique_makeunique: This bin gets hit when two or more masters issue makeunique coherent transactions to overlapping cacheline simultaneously.<br>
    *
    * Two or more ACE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; Section C4.10
    *
    */
  covergroup system_ace_store_overlapping_coherent_xact @(cov_sys_overlap_coh_xact_sample_event);
    ace_store_overlap_coh_xact: coverpoint store_overlap_coh_xact {
      bins overlap_readunique_readunique = {16'h05_05};
      bins overlap_cleanunique_cleanunique = {16'h06_06};
      bins overlap_makeunique_makeunique = {16'h07_07};
    }
    option.per_instance = 1;
  endgroup
  
  /**
    * Covergroup: system_ace_no_cached_copy_overlapping_coherent_xact
    *
    * Coverpoints:
    *
    * - no_cached_copy_overlap_coh_xact:  This coverpoint has following bins<br>
    *   overlap_readonce_readonce: This bin gets hit when two or more masters issue readonce coherent transactions to overlapping cacheline simultaneously.<br>
    *   overlap_writeunique_writeunique: This bin gets hit when two or more masters issue writeunique coherent transactions to overlapping cacheline simultaneously.<br>
    *   overlap_writelineunique_writelineunique: This bin gets hit when two or more masters issue writelineunique coherent transactions to overlapping cacheline simultaneously.<br>
    *
    * Two or more ACE / ACE_LITE masters needed for this covergroup
    * .
    * Reference: AMBA AXI and ACE Protocol Specification: ARM IHI 0022E ID022613; Section C1.3.4
    *
    */
  covergroup system_ace_no_cached_copy_overlapping_coherent_xact @(cov_sys_no_cached_copy_overlap_coh_xact_sample_event);
    ace_no_cached_copy_overlap_coh_xact: coverpoint no_cached_copy_overlap_coh_xact {
      bins overlap_readonce_readonce = {16'h01_01};
      bins overlap_writeunique_writeunique = {16'h15_15};
      bins overlap_writelineunique_writelineunique = {16'h16_16};
    }
    option.per_instance = 1;
  endgroup

//----------------------------------------------------------------------------
  /**
   * Coverage sample event function.
   */
//
  extern virtual function void cov_sample_system_axi_master_to_slave_access();
  extern virtual function void cov_sample_system_ace_concurrent_overlapping_coherent_xacts();
  extern virtual function void cov_sample_system_ace_snoop_and_memory_returns_data();
  extern virtual function void cov_sample_system_interleaved_ace_concurrent_outstanding_same_id();
  extern virtual function void ace_valid_coherent_valid_read_or_write_channel_overlap();
`endif // SVT_AXI_EXCLUDE_AXI_SYSTEM_COVERAGE

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_axi_system_monitor_def_cov_callback instance 
    *
    * @param cfg A refernce to the AXI System Configuration instance.
    */

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_axi_system_configuration cfg, string name = "svt_axi_system_monitor_def_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_axi_system_configuration cfg, string name = "svt_axi_system_monitor_def_cov_callback");
`else
  extern function new(svt_axi_system_configuration cfg);
`endif

endclass

`protected
1GM=g(7-a@IbKNcf@OLE1dVW;=d]ABB:[8T9/56_E.:Pg;H:L,R@&)WM9T=1M18^
RLZ[EOXF\-a[>EA6I&/<X49P@Ne[>^3\+;(HE)^-6)Ee/B&T+CK6U;&W1/eKH1Ia
-c\PR^@5X0<RE8b2OP8-=^3E93W5B+a&9J#b2c#0X6a:)10:;65].RE,[J1CG>&E
:[^d,A>gXQ93(UWA^YVGI_cL&@7&SZ:H&AL:Ja@aY,dN,L+BI(0Z#bX.2f:(UW+L
-\@GWf19\UgLGLB0)&aAgCV^#,_>8^L<Z7-MGIb0N1&a^1LJMZ0JfgH-bQ#c?NEE
C/8,Iaf8g5)WfY@+O+4K,f&7d2:IIJED1-bd,::f=b9:0CC;N&;?K0SZ09Q<^>&d
@FD-_4Dg2V.eH;:1IH.f[-,JIJ[b?J^D0U:M&EAT[-VL/X>,MUUK^SO&d;TVDW.5
I(9SeaS[?IFEH7?CR>D@TOGM0I]e5C(fZc5K,\PB.ZPN21[>P<YM?@bD(UMMa=YA
94IfB2S:7FX?NB?^FJ,XYe/@3D?Z_\=?Cc[GPVEI(W5PR3O2)MX,;(E?#[\_J>Hf
_L\GS@:DgT>E12D7C)IHYU>NaDHQY&f_(DT4b&/WKBg<X^E55(GD)I8b0>,YAP#V
[K0J5Y[EB:J=J-cHFf>G:GTTLYN9M(0T9f9;FA1T\LKMdD).?#)/)^3(g__Y6b0#
)(=.(aBL/NK,(0W;+KP/_DSc[N,/@(W__WN,E@UV._D]b8EL90/?L<b?VVWC/92(
M;.FT=0e(4V2?FFTPGF.DXR1QJUH)F?6:,a0;e>1-6\GYVa1K6AKP1B\10J+8Rg<
Hd+E?[dDB#S@2L+ec.R7?>&^B;_e1>K8:20Ye9TCVc#R>#8-B)M;AOANBSUU6-RZ
>&.FS=^dGW3U=U;+00#S>I<XH[JWaYM#eEg5N-6#T7Ja;4^7MWU,QP]83#_E4M@d
5VC>-T&dLY6^B9:GJ32;X&bVb4,X94cZ,W>^(PZ8SC4/C[:R/FH/Ig4^DBXE9#.\
LEfQQV1Lcb>9a3HGZA_JSO;aK-gc:LfT;Fa?-.W)Z:3+dIW4:L28X217U?JF=U<_
FQP/G_8d#,1W&9QeCL?_R@-)2J>1^OS[cCeU&3N]gANNQ25gWA>ONBBbf?F<^C2-
fT6?5Z6S+Z\CG)>K)GV[9PXB,YD.f0))+,#8[@J+;:Y2aV)]@\>,f<^9/6Z-1N<2
eSZaI)6B.eL>MSPTZQa/XRdEY0F.NUT3IE.fM\S<AgJfI4?8:cG7CE,:gI)F)U0P
gTe0E6,[Md[DAM=GEf<U;/8Vg/4@]:)5DHSF=+-E8N:ZH]@Ec];&7Da4EL6RJ8:,
7W,N^d7()XS3=160BS7A3Te/OOK2@8-BM_e7;aC8TLTNKFQKB1EP(RZ6#D<.^KS0
(7N(@/[e@3;18dfO<8f-PCR-0#.G98;3L+YT<7>YK)^YB/RS9;0TPf@T.+A@9[_2
]4_IV.V]3VH1bAVTO8L^&<;)bAb\b4^[CM8J@#bAM1;BY:Ha<\V4:a>BCZV61/JJ
<6/d7HF[Q_3H(^_O:6F]T+OX?/(4L+R=BSRT=1#A&>KRZ;&9.M@9>D;ARW@2DYGE
<@<JOc/,>I5H\c94Vc8gF:LKQ=,SETWQdX;58F\OO\VN]G3IW0>2M9_L6D3AOgCb
YI11L[4;XYZ<GPUD;->278XDeb:\VMad_V<IcHc3P-I@&Jf3]0BX0;-1(+e4&]+K
FeB?<1f_#7C8V39/+^XIcZ2EO:G4KN=7C70K#6/a3_Q0+]E:=TOP+Fdf#2@PK_Y\
d01OfHR821RJ+9Z>DW4?Ue&YOC2eZ9@B52A(5ALKW+He6#XVRB<1[CW-=L?0:-(J
NP(VCTN7e5Y5^>QE0@LI8d7[C=HGb,@O8-@I_;<6)0+\M38>>V:a9[1+WXK,_5C2
N.YA6+9<@RPg>\A8)U9VIU1]J0Y4F3LH&+7OWD[1;90UYN\N8b/G(2_PS[;\PYRc
9RWPL9HU8)+50KF.V<CD_+8OX_O=2X6(#Z3/>,R.eLMP3Y@7HeMV7KRg02NdYSFU
WFER;^:FASF:A5WfOVE3=^174]Y/F0Q)WZQ\R#U;NAT>Y:e3W:U(MDQ?#].aAfWX
V#b,YYE.R:2)DK^DQ>e/;eD?XTYYW8I]\I6_4&aMc_;#[T]H:?:V0L@-/8/UU<GH
bRIP9ET]6O/I_fR>eU#=_4G6dQ<PcO5,^1ae,Fc.GMZ,:2N8gcg-=E[67@]]aB^)
7&H4f\W2LWP&&QY6BWdQa+._8-7M1PN,ZQeNDb8ZUW(XNb58Q4UDgM_PZ9a.#\<-
UC5KMJ\P\BSOG#?/I+758TgL>SG+e1T.:#e_<YG+L@FUg:_P?AOB)#f_@c)Rg(H&
YU3[gcM#(W/Z_+TF9Y0Z_],7QQ(McZYcbcVUE([PU=B\]&],\J-R6Y#FC?#4I&gM
5BZ8;ITB[T)1N#_I(,&]4G<\Je6)<Y>5(1BOI0ACdD\f6,4ZR75>ee)OWC.(35+>
UVMcT](L0D4+P>M([FYE_M@VX3R.\_K[87;];Q^/I]4#EVP3OIR7f5.H2Z4W_[N=
eB^CZ:@3SHQT>2d;N8:>@UJ5;\3LSaNH9=;5[:-a(BB)I4_EdVB:DS&<)fZUg]LU
BXc+7IBKceSg;9VeS6P#<:JVMTdF;W5H6.V6A&.PD3JLYUC@SaS9R-1VdB41KGGR
<EE=+@?9KU7MXBSA#]<Y+[bf#fa,X2.9YaeOSSIc)?3PaG/,>?L77IS,9a6]0#^,
aOLUQTIL?1O3TgC[g_5+X&PHTaXRL?2E&11&6K(X>g-EZPCg?aKF^(gga;+V(-ee
NMYGG21O2?g6Y)NPR1Bb-4ZQ3I=>:VBSRK63&E1T>]/IM[[/>7cMI[1[bR^K/&2F
@,bC&@/JQ14SWW^=?;>,[1U<db0f0H/cZ(JU=Mf=N6@>e[E[QN/+S9OHUMA_=J;L
-Ff[Y&1P<VU>M:O:IdIbL0KWE;4JTc(,UFZ/VN:a.62YDS&?;5>PG@b#-e+HN8(1
f79EB(8L4K2RINb,ZZWG_G-UQa>I7UGFF<fcGKC[3N?LZV/XbQHJY>f+58^,E\?D
e8ERYF2)^\)F14EN&:N.485(AKE<#SdYR2]0<Q>S[VIK&5_-98KGSYS)_94;RY#I
N:cLSgVO:?[+;;@L_L[CgZWf3BU_(#bS4fg2R/)@3)J<080;,^X1PgJG.X]@cF6L
GHWE^SGQJ17/DTa,01dFb<A3[cYWHH[<D&/\NCdFL,.-&OcgIIfa9_8DBM1A:B4)
1B^8\ML92BV?0QK&DT&#V\Lbfa-G((4b>VCJ[=GB[_.O[+(VT8X1+fE-Y80:HX98
@@.g7^I26FBD6+g[F[c4Sg+ZQ_64SP6)#TbR-9Y#(+[6L/1GH87:7DS;3c].IC1+
B=+B+++.K&&d894TT\WQK0d/FG2(IRNS9T>?+HcSO&GRX[.,f-CHM7Ma-Oc:ZPS=
D[S^^BOV(IQ9f0=]#fK<.EWR1XC6(B3c+Q(Jc,2D5TZI97CWZ7R#&9b>4Z,A+:&D
.2V[<eG-QDQ4N>(SFZM_Q(VW?<MaI+N05[.L>#UI(b4>YbRfXB@NRPFcV0SA_LfA
eG)VCdARZ7c5=L+^S&<Cd+g#642AQ&SW-M8DE:DfgZVGS27)H,dGHE2dS.0c)QR=
I:.4MOa>Fg:bR_.:b)[1T9-6XOUdQS]VSfgF[NQK-FHKWbd-[JNN;T+RJ:OB&7<&
?a2dD2X79E.WfgVOS5@KU9.^L51a>.aIMRJWD;^IQCDSEOO5S_@GE[0BeQXIbYS;
@9g5>3(+;0GcC)7R/H0(c8P7D:NIZ9?]C=Y7=daFC]<229CQ&^^Z\W_8bF3,=OSY
EaLG[CT[@<bN2WDDf<@#0)#05,A33YL5e??I2T5TI(B(.V:WLGRIR(FgdP]7,9DC
#BM49C0^N,aX\)O&WX5])8eLIUDM446>XBc)4],gR0_0#TQ6EX_FE>gQLOA2T^_K
^8HOE-^:L-D/;JXXb2RE^6B,407c&3@KX^FBS=5E>14>0^#CMO3Qe6</-8UJ60?6
WT06/TJZ(#CBV5PW6YI#^;&&/>LVaP#(:e:PT957)#TT^:9fHBVTOZBDXO&e)(,C
H,&IM@49A@M.b<^MK-1?:.aME>WTEZQ&e<F;M=fObfcOXLX1C#R4;U0?DAVEO[F_
e#b(I;+NK\Ad6c1]38:8eZ7V2eJRFOXLID@TaKDD0LT].YVd@M@:4\f\=J>IDe-)
deR8\XI5D-F<a#8eCa<fD1,N8@^_)YCe+/:\5A/,Qa[=P&4cP6AaPGFH\c(Q32;M
W#_Z9NbGE\Q+_M_bN8SB[<<<V/8N\dYDcGBK56;N30)<cQ;C.\NZecRSf((?a5#N
-ed&+fN_,KO05,LeO95)@g.R-UCP^52K]++LF?@^cI:X8C9M,J<Tc;#<?1RW9+XF
8&P\c0BF(9gGa?YM:0N=\->=6Ra+KCA(#:D^=5c_(MOJ8Ea@V\@JcX]33=I^-XY^
P&(Qc:NA8(.:I:C6=80D2ff0<EJVa,,I0<G/-(=Z+8g<:^E[f]TL+W<,W(F3>DNQ
V;I4.;TcRGW?]QDYfPKYgB/bE/X+fC&Fbc/MW)OaC+M(>Y7,72[D<P:)+?_cF(0W
J/@4=7a,A/,<T640^fS/7,MAZ]YH8;TgZ(PIX?1,#1^7g#e+#99^c5OP6#&Y\ge]
D9MRF_V2AS??705@g1=F.d?5^Z</N\X0N2_1BF)@g&^g9K.;1XVJ5a[A3@Z<YGg,
YVa3RKE<=-(&#(=?QY1Z]O2:<f.;1YgbXVe)/QE;I2N/U@T??;KYC>;MZ\G&Uc&>
&(J?b70DJH+&ZKeeMKBI,Q\F>+S/JVHeV1FER&4c;C@8gVI;OfOH]@76>/[fL3Z?
e2G)C##9\8QPD,VHH2H[?2(Y0:AY/1RD<eBA.=4]]gV(&OJYR9)3FbC,/ZXDX)_(
_N9J?MVGS+;9=[ZE9&.9.dE?QPPE+TT,=&?_dGIQ+WCcc:SSJ(c65]WFFEO<)a@<
UaA,N;NQ-+B,X2/8L^I/a<7Q5B/(<>Q^=ZH=S6g2_GeJ+15]0W&d72Z0<LgTTfD9
,M],B?L33,7D;,_[8Y&c2]PBP;^)aXgcT1O4dN+:YLTFA.\ATDT;]b;AXCQN5<R2
;F&E).ZEe^C0&4/6BR0E]e(2E).20SVCH]B0HXH4_QBGZ1DJ]e1W\I:MTEN@>ee^
gU6#LI?_VR=/S,TCGLO9>a>#UFe=cQ17]2SH&2#J/E<eWKWT^Ybf9X26\<>eQSR:
C.L4UdV>eAUYEV=+C57gD[>ZFLQ:XgWAafXaG\8?A_TR?@.65U)\Hd4KC=B\M\e3
HM)W[&H?]#R#4/c+\\CZ>>CWM#UP02@X^_edJAL_&Md])Q(gABb8/),,P]KPK9[L
#X8^2CNESZ=J[AG]&4BC(_]/.Pc0VHK-cJW&-=_#9F8Qg+\U?;XaGgdD(-?KC.;C
@]P^\G_Fe_+&]?B@Oaa:]O1G/MR@bK:M]0B96fefOCHb/^Q:J/6LCC=0U:^+D+/S
>[AWP,M:&dH_-WUg08Y+B0F;KF)OfbUg.[S:F3IF6?&MR\JZ]^+Z8_H5MGfAZSS(
_2X8b_Q^0,29bfF/I0+]\7Hc23<J<JR5TB+,E_&80[2]=b0UW:;UPR26[<7=dd:Q
2IU2b._B^H0Va;e8ADbZe\FKc0Ob88O05I:@P(:#JBJ>.H7aa6?G71eF\+G>ZcAI
KKWGKD@(d</Q<=TW=dQ:>Y-5bMEUZVUDJ7g7TDfA@3@B\FO4VYY(/NV).?GB>V^R
Lg/ZIXV96g>8TSc-N/#7W?W\@W#-QdcRGF@,X93g(Sa1UO2HS-B(A=,Y2J:g9Z-e
)(3a2\96IA_[AY@>I.NAT5AVT3<CUK::b2<aQ;d7V,:ZZ]fa<H7S;J7S<fJ@><_^
dY?=&7DS@IWD1>WQ2(@^OPB]+@KS5ZN</@R(OYbU,c#IW:S4&3Ba;T4b_4J43F]U
>\&SfHaZPEYFY?&P+#;.4F.L1[IK7SDb+0.:dMJ\-J3+QT_N:40BXdDV]38F/2JD
758eB3M@^[EJ7bWU,3?SSE3HfQYF>F-AR,U24V[4c@C_f3T?,Be82S.X3ESWdecd
VLCe<AH87:O5?Y]O=Ib&+.>CVN@I>GL<41A[Y6([?0:f(UAK\GPY7=a2_9D/C_P^
EWAIYE]-WTA-e#3,O\a5f;2?.M-+A?&#=eO)_03SJbBgP&Ac]]J&>XR)2M#S>;SA
+)L:<aSN^_/6HQVD6dTXGf?D7MbXAJZNSbB34]+FDL2CB];3W5E8]@1DN:ZJg2ec
FV.[J9K9^&C#MF5@Y8BSZcRGAe7=1&=+bO_:@JV[;4G:&+HP.58B6J14Hc[&BJ,_
PI3c,T-O<>0Z8af6;8R.^_W0,_H8\48,We?2_:Y7\JcIGZa2&;&L2^X[3cg\ABHL
X^<]c:@W;UVO0b@&+(Z8?\HF#<De>@3N31R.eO_+_,R?S\&4V=dH9NAH<Y-[YZJ6
(5?U96B,b=OL=RfAL9/R\YC@->ZZP0DL;U?Ig&UZ)^&\X9(2O)2S(Mg_^A&9OaZ]
+-&[2R9ac2FKg:GCc>/d)K:Y^3+#R[=&gfCOfNCE<[:38;D2)c0J,C54H.a^XEgE
NK#B^(L<WPXJ^?)F/QBb,LO:<]YPa41d4O5#]>aC.@68\Z)f^1_A59U/]+VGRGT0
9;)6[e[Q1c5S,?U:Mg[[4GNR,_Ya:\d+#BB<U@c4\.Y?X3?\SQ:#<baXDHP&_LL1
_Q]M1AeP?C/fKFI^49G\d;38,R,#+U#6Y@^QbP^gCTB[R/bMeKI\\]L2:O\W5e1E
2CE,MKL\2>&<6f5=E3;3]g\P,DgYPQSS2YC)F<&-Ngb7)X)QBL3PNW-aPfP5<5cV
DC,DUA)#gf&&:KV(c<>]KK],/I=Z-6EH>G4;-[+KJGNH^B0V3&EC/GP8d2;9]Rc8
G2@,AQIOaYEXA(3VE;_f=RY8P0C9#:>ePX@,cPMX78#RY^R;B+8JT973Z-S?4[PU
W:C[VOZ_,+=WbM398QG#S:.?Mc=JJd]@Wf?^^dC1?Y4\<OUb/W@=?&I_QL]d6E(S
7EB5P4,FP\aTDP(U63)V]#<>dbDc=gAQ&NH4DZgHJ4aI143BQf-F5O:W+O,PW-H&
Mb>-)I8a6)a[@Z,Dg[VDMe6aD4A4Kg\BI+8Z8TF9fE=50C5KReP<O<T[/Ud4ecc_
58M_-\,J?b,2HD(W>7aaJdY_22<^7dK2eU9X=d;?\B/;aD,ea35MYZ_Y+[G28)5?
HIAG8+CD<&<J-HZG6?d)c;G#ZDY>a,T1U]b2E5fLcU5\/g.N>FEHHE?cH<aD_\:)
daYbWRCA2C(.S9E1fE-#fC6HB,&5[NTID])#8HR(e7H^AWDM+55?CE-&D&+4H+^2
<DF4PXbbcZ+EQVST4bgLCa-b)R_<-XHKLY/U(.53RE[@393(+3b7+(D4[<F5+DCV
CefF[EXC1-&1Eb/[.JWg(aHDe_WB+e8:FgLg66g8&)3B=d.J3-S+.Z@_O=G+F(HQ
^O\Wf4XJ(B9SfS4BRZ)NH38a^Ofa=K98>&]d/7=eT&ZD;&1ARJ;(IY44gT3JQ3UV
12I4T^R8D/9d00>Z>c\VZ5&B;Ef[]\>SB^>1c.D-YW3T(e8=@ICOgIXBNL8]LB\/
.-&K^H&fLc[4.NeMG]Pg:R<dVBO_.ZK<]D#M+0SXA/XS5.:NFd52J87eLbWMQF5d
,bfAVY&B_<+5Z0NF\+bBRP+a33[@LNe1SUd5;aWW2,7FUGKAU_>bA+K^CBS[Tf6+
YBHI,]F]>M?Nf#^c[]^NIJO<7R^-MP\C0R1/b<9^^5PfddQ\(Odf-DeO;WTPUU42
ZHS9F,OC\3]XcM]X#8[Ne[)b#FU_CL,XOWCK,af73Z#B[SMHG1#_]^L95D0UX@5B
EgfW6/5?J,V:R#@31B,R\R;0@/X<T&::MH93<A-K_>aG]WJF)4:Ac0BPfC1S--E1
=c<_bKA#2^>A2E@1UTB-\70WBSS7[Z^OMPNG,95YU;V2V^XP]3J>6AY#1ZD2Yf<R
7>ONW)YYM8R-B2\^;@GT=+ES@IgTL4X8QGRQaNG,MD=\J8:ZTCHcIac8.;_VE5V2
E/dJdTN1OEN7Q92b-OUBAUNC5T0\+;gg]F10^>>,4,e<_-3^:K)cDGWOf;<cC:JU
8X8N7:T,X;Hb<gQC0J82KP(8G\NMa(R;MB8(a?_@7\Q_]Q5#RZbH+A:&T//RNZI3
Wb]3@9SMdC]KSIgGF/G0CKVAge3VF(UZI6LVY&9BHPW36]ECD2<^EeI3K)21f3>7
J[gYXS(JF3X6RL8:W4S-&<ZK\I?/M9aOU(14c8PKBY4a]KF@1@O/:FI[<KU,O3d8
W?MSF9]A9-,Lg.RDa,2EM64;b.7KbK6251BJSS9Q&27Z9GA.(b8aD^9bLf5=8K_P
3J\5HG2N>C-KOH8.JAbH2#aCY9-X(L:M(-77=G\DPK.K&PBHRf5MH+LP)+VJ=;bS
0B05YO]b2TXQbIJ-aSCf7c.#2b^9aP@ODgO,2^b^34P=^OEGR&eHCLP65]bS5,P7
f3RB=O<:EB09G7,3d33eeSKQ0F?5[C/CN6)5IC#+5]DY?_f^Nd0)7-NVX<DV6DXL
9G->KQ&\>&FKP,^[J=+9XA348SgH=b8:Yc]F8^?+AMb7L\T-CM1cGMZ/g<I#G,4X
ON1e/9(_:BgZ8IO0(1Pe#AI@1E3.N^4]K0;Z@--3=4e>g[+_f[G0U(g<,^J@CJS7
,HEB;@b5VL]g/XVcR+d6KfK;[Q^8fBN^eN1]X[M^MfVT.#N]N29LZ-^+39cD:88I
WXW1PP[YBeT:]-\\I9U2aKY.K;^GX;WP:$
`endprotected


`ifndef SVT_AXI_EXCLUDE_AXI_SYSTEM_COVERAGE
function void svt_axi_system_monitor_def_cov_callback::cov_sample_system_axi_master_to_slave_access();
  if(sys_cfg.system_axi_master_to_slave_access_enable) begin
    if ((sys_cfg.system_axi_master_to_slave_access == svt_axi_system_configuration::EXHAUSTIVE) || (sys_cfg.num_masters*sys_cfg.num_slaves < 16)) 
      system_axi_master_to_slave_access.sample();
    else if (sys_cfg.system_axi_master_to_slave_access == svt_axi_system_configuration::RANGE_ACCESS)  
      system_axi_master_to_slave_access_range.sample();
  end
endfunction

function void svt_axi_system_monitor_def_cov_callback::ace_valid_coherent_valid_read_or_write_channel_overlap();
  bit cov_write_flag;
  bit cov_read_flag;
  if(count_ace >= 1)begin
    if(axi_monitor_mp.axi_monitor_cb.arvalid == 1 && axi_monitor_mp.axi_monitor_cb.arready == 0)begin
     cov_read_flag = 1'b1;
    end  
   end
  if(count_ace_lite >= 1 && cov_read_flag == 1)begin 
    system_ace_valid_read_channel_valid_overlap.sample();
  end

  if(count_ace >= 1)  
   if(axi_monitor_mp.axi_monitor_cb.awvalid == 1 && axi_monitor_mp.axi_monitor_cb.awready == 0) begin
     cov_write_flag = 1'b1;  
   end
  if(count_ace_lite >= 1 && cov_write_flag == 1)begin
    system_ace_valid_write_channel_valid_overlap.sample();
  end
endfunction

function void svt_axi_system_monitor_def_cov_callback::cov_sample_system_interleaved_ace_concurrent_outstanding_same_id();
  if(count_interleave_port_ace>=2) begin
    if (sys_cfg.system_interleaved_ace_concurrent_outstanding_same_id_enable) 
      system_interleaved_ace_concurrent_outstanding_same_id.sample();
  end 
endfunction

function void svt_axi_system_monitor_def_cov_callback::cov_sample_system_ace_concurrent_overlapping_coherent_xacts();
  if(count_ace>=2) begin  
    system_ace_concurrent_overlapping_coherent_xacts.sample();
  end 
endfunction

function void svt_axi_system_monitor_def_cov_callback::cov_sample_system_ace_snoop_and_memory_returns_data();
  if(system_ace_snoop_and_memory_returns_data != null)
    system_ace_snoop_and_memory_returns_data.sample();
endfunction
`endif // SVT_AXI_EXCLUDE_AXI_SYSTEM_COVERAGE

`endif // GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV

