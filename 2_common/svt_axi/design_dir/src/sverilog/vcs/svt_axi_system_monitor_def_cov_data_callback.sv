
`ifndef GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV

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

class svt_axi_system_monitor_def_cov_data_callback extends svt_axi_system_monitor_callback;

  typedef enum bit[2:0] {
    SNOOP_WITHOUT_MEMORY_READ = 3'b000,
    SNOOP_BEFORE_MEMORY_READ = 3'b001,
    SNOOP_ALONG_WITH_MEMORY_READ = 3'b010,
    SNOOP_AFTER_MEMORY_READ = 3'b011,
    SNOOP_RETURNS_DATA_AND_MEMORY_NOT_RETURNS_DATA = 3'b100
  } snoop_and_memory_read_timing_enum;

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
  } two_port_overlapping_write_enum;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Configuration object for shaping the coverage. */
  svt_axi_system_configuration sys_cfg;

  /** Event used to trigger the master port covergroups for sampling */
  // event cov_sys_master_port_sample_event;

  /** Event used to trigger the master port covergroups for sampling */
  event cov_sys_slave_port_sample_event;

 
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through new_slave_transaction_recieved callback method. */
  protected svt_axi_transaction cov_item;

  /** Variable that indicates if this coverage callback is used by internal VIP coverage definitions
    * or by an external user-defined coverage definition
    */
  protected bit is_default_cov;

  /** Snoop transaction Coverpoint variable used to hold the received transaction through new_snoop_transaction_received callback method. */
  protected svt_axi_snoop_transaction cov_snoop_item;

  /** Coverpoint variable used to hold the targeted memory address */
  protected int master_to_slave_pair_id;
  //protected bit[(`SVT_AXI_MAX_NUM_SLAVES * `SVT_AXI_MAX_NUM_MASTERS) - 1 : 0] master_to_slave_pair_id;


  /** Coverpoint variable used to store the concurrent readunique/cleanunique access */
  protected int concurrent_readunique_cleanunique;

  /** Coverpoint variable used to store the concurrent xacts with same AxID in a interleaved group */
  protected int concurrent_outstanding_group_id;

  /** Queue to store the coherent xact issued from initiating master */
  protected svt_axi_transaction  outstanding_xact_queue[$];

  /** Queue to store the system xacts */
  protected svt_axi_system_transaction  outstanding_sys_xact_queue[$]; 

  /** Queue to store the readunique and cleanunique outstanding xacts */
  protected svt_axi_transaction  readunique_cleanunique_outstanding_queue[$]; 

  protected semaphore outstanding_xact_queue_sema;
 
  /** Queue to store the snooped xact issued from interconnect */
  protected svt_axi_snoop_transaction  snoop_outstanding_xact_queue[$]; 

  /** Event used to trigger the concurrent_readunique_cleanunique covergroups for sampling */
  event cov_sys_concurrent_readunique_cleanunique_sample_event;

  /** Event used to trigger the coh_and_snp_association covergroups for sampling */
  event cov_sys_coh_and_snp_association_sample_event;

  /** Coverpoint variable use to hold the value of coherent_xact_type for covergroup system_ace_concurrent_overlapping_coherent_xacts  */
  protected svt_axi_transaction::coherent_xact_type_enum coherent_xact_on_port1;

  /** Coverpoint variable use to hold the value of coherent_xact_type for covergroup system_ace_concurrent_overlapping_coherent_xacts */
  protected svt_axi_transaction::coherent_xact_type_enum coherent_xact_on_port2;


  /** Coverpoint variable used to store the coherent and transaction association */
  protected int         coh_and_snp_association;//MSB--coherent,LSB--snoop

  /** Coverpoint variable used to store the master transaction received in
   * interconnect_generated_dirty_data_write_detected callback */ 
  protected svt_axi_transaction master_xact_of_ic_dirty_data_write;

  protected snoop_and_memory_read_timing_enum snoop_and_memory_read_timing = SNOOP_WITHOUT_MEMORY_READ;

  /** Coverpoint variable used to indicate if only one snoop returns dirty data */
  protected bit only_one_snoop_returns_data = 0;

  /** Coverpoint variable used to indicate if received data has full or partial cache line data*/
  protected bit cov_wstrb = 0;

  /** Event used to trigger dirty_data_write covergroups */
  event cov_sys_ic_dirty_data_write_sample_event;

  /** Event used to trigger dirty data write for cross cache line access */
  event cov_sys_ic_cross_cache_line_data_write_sample_event;
  
  /** Coverpoint variable used to store the master transaction received in
    * master_xact_fully_associated_to_slave_xacts callback
    */
  svt_axi_transaction fully_correlated_master_xact;

  /** 
    * Event that indicates that a write to overlapping address when snoop did not return
    * data is received
    */
  event cov_sys_overlapped_write_xacts_during_speculative_fetch_sample_event;

  /** Event that is used to cover system_ace_xacts_with_high_priority_from_other_master_during_barrier group */
  event cov_sys_barrier_during_active_xacts_on_other_port_sample_event;

  /** Event used to trigger the system_ace_store_overlapping_coherent_xact covergroups for sampling */
  event cov_sys_overlap_coh_xact_sample_event;
  
  /** Coverpoint variable used to store the overlapping coherent transaction */
  protected int store_overlap_coh_xact;
  
  /** Event used to trigger the system_ace_no_cached_copy_overlapping_coherent_xact covergroups for sampling */
  event cov_sys_no_cached_copy_overlap_coh_xact_sample_event;
  
  /** Coverpoint variable used to store the overlapping coherent transaction */
  protected int no_cached_copy_overlap_coh_xact;
 
  /** Indicates if an xact from other master when barrier is in progress is detected */
  bit is_xacts_from_other_master_during_barrier_covered = 0;

  /** Valid pairs of transactions for interface pairs 
    * This array will be sized by (num_masters)*(num_masters). 
    * This is because each master needs to be paired with (num_masters-1) masters
    * Each index corresponds to the write transaction pair seen between masters
    * Master 1: index/(num_masters). Master 2: index%(num_masters)
    * For example: let us say there are 5 masters, index 7 is for a write transaction
    * overlap seen between master 1: 1 and master 2: 2
    */
  two_port_overlapping_write_enum write_pairs[];

  /** The last write transaction received */
  protected svt_axi_transaction last_write_xact;

  /** List of write transaction whose address phase is in progress. 
    * Gets assigned in new_master_transaction_received
    */
  protected svt_axi_transaction addr_phase_active_write_xacts[$];

  /** Event that is used to cover system_ace_barrier_response_with_outstanding_xacts */
  event cov_barrier_response_with_outstanding_xacts_sample_event;

  /** Property used by system_ace_barrier_response_with_outstanding_xacts */
  svt_axi_transaction completed_barrier_xact;
  
  /** Semaphore to access sys_xact_queue */
  protected semaphore sys_xact_queue_sema;

  /** Queue of system transactions */
  svt_axi_system_transaction sys_xact_queue[$];
  
  /** Queue of system transactions with speculative reads */
  svt_axi_system_transaction sys_speculative_read_queue[$];

  /** Queues for holding the back to back transactions with specific id */
  svt_axi_system_transaction coherent_outstanding_q1[$];
  svt_axi_system_transaction coherent_outstanding_q2[$];
  svt_axi_system_transaction coherent_t1_q[$];
  svt_axi_system_transaction coherent_t2_q[$];
  
  /** Array of queues for holding all masters transactions with specific interleaved group id */
  protected svt_axi_transaction interleaved_group_id_array[][$];

  /** Queues for holding all masters interleaved group id */
  protected int interleaved_group_id_queue[$];

  /** Queues for holding the interleaved unique group id */
  protected int interleave_unique_group_id[$];
    
  /** Associative array of queues for holding all masters port id with specific interleaved unique group id */
  protected int interleaved_port_id[int][$];

  /** 
    * Queue for holding the associated snoop transactions of a first
    * transaction in back to back transactions with specific id 
    */
  svt_axi_snoop_transaction snoop_t1_xacts[$];

  /** Event used to cover system_downstream_xact_response_before_barrier_response */
  event cov_sys_downstream_xact_response_before_barrier_response;

  /** 
    * Number of times that we see transaction response being received downstream before barrier response 
    */
  protected int num_downstream_xact_response_before_barrier_response = 0;

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log = new( "svt_axi_system_monitor_def_cov_data_callback", "CLASS" );
`endif

`ifdef SVT_VMM_TECHNOLOGY
  vmm_object base_obj;
  svt_axi_system_group my_system_env; 
`else
  `SVT_XVM(component) my_component;
  svt_axi_system_env my_system_env;
`endif
  /** 
    * Called after the system monitor associates snoop transactions to
    * a coherent transaction 
    * @param coherent_xact A reference to the coherent data descriptor object of interest.
    * @param snoop_xacts  A queue of all associated snoop transactions
    */
  extern virtual function void post_coherent_and_snoop_transaction_association(svt_axi_system_monitor system_monitor,svt_axi_transaction coherent_xact,svt_axi_snoop_transaction snoop_xacts[$]);

  /** 
    * Called after the system monitor associates snoop transactions to
    * a coherent transaction 
    * @param sys_xact A reference to the system transaction descriptor object of interest.
    */
  extern virtual function void post_system_xact_association_with_snoop(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);

    /**
   * Called after the system monitor detects that a write transaction
   * initiated by the interconnect corresponds to a write of dirty data returned
   * by a snoop transaction
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param sys_xact A reference to the system transaction descriptor object of interest.
   * @param slave_xact A reference to the slave transaction descriptor object which was detected as a dirty data write.
   */
  extern virtual function void interconnect_generated_dirty_data_write_detected(svt_axi_system_monitor system_monitor, svt_axi_system_transaction sys_xact, svt_axi_transaction slave_xact);

 /**
   * Called after the system monitor correlates all the bytes of a master
   * transaction to corresponding slave transactions
   * @param sys_xact A reference to the system transaction descriptor object of intereset
   */
  extern virtual function void master_xact_fully_associated_to_slave_xacts(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);

 /** Covers covergroup system_ace_valid_read_channel_valid_overlap when arvalid is high and arready is low
   * and covers covergroup system_ace_valid_write_channel_valid_overlap whenever awvalid is high and awready is low.
   */
  extern virtual function void ace_valid_coherent_valid_read_or_write_channel_overlap();
  /**
    * TBD
    * Gets a
    */
  extern function bit get_concurrent_write_pairs(int port1, int port2, output svt_axi_transaction::coherent_xact_type_enum port1_xact_type, output svt_axi_transaction::coherent_xact_type_enum port2_xact_type);

  /** Covers barrier_during_active_xacts_on_other_port covergroup */
  extern function void  cover_barrier_during_active_xacts_on_other_port(svt_axi_transaction xact);

  /** Covers system_ace_concurrent_overlapping_coherent_xacts  covergroup */
  extern function void cover_concurrent_overlapping_coherent_xact_on_different_port (svt_axi_transaction xact);

  /** Covers system_interleaved_ace_concurrent_outstanding_same_id covergroup */
  extern function void system_interleave_ace_concurrent_outstanding_same_id_xacts();

  /** Covers overlapping write transactions covergroup */
  extern function void cover_overlapping_write_xacts(svt_axi_transaction xact);

  /** Covers barrier response when there are outstanding transactions on same port */
  extern function void cover_barrier_response_with_outstanding_xacts_on_same_port(svt_axi_transaction xact);

  /** 
    * Called when a new transaction initiated by multiple masters issue a transaction 
    * @param xact A reference to the data descriptor object of interest.
    * @param sys_xact A reference to the system xact data descriptor object of interest.
    */
  extern virtual function void new_system_transaction_started(svt_axi_system_monitor system_monitor, svt_axi_system_transaction sys_xact,svt_axi_transaction xact);
  
  /** 
    * Processes a system transaction which has speculative read found without
    * any associated slave transaction and with snoop data transfer
    * @param sys_xact A reference to the system xact data descriptor object of interest.
    */
  extern virtual function void cov_sample_system_snoop_and_memory_returns_data(svt_axi_system_monitor system_monitor, svt_axi_system_transaction sys_xact);

  /** Processes transactions for barrier related ordering */
  extern virtual function void process_xact_for_barrier(svt_axi_system_transaction sys_xact,svt_axi_transaction xact);

  /** Adds transaction to active queue */
  extern function void add_to_active_queue(svt_axi_transaction xact);

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_axi_system_monitor_def_cov_data_callback instance 
    *
    * @param cfg A refernce to the AXI System Configuration instance.
    */

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_axi_system_configuration cfg, string name = "svt_axi_system_monitor_def_cov_data_callback",bit is_default_cov = 0);
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_axi_system_configuration cfg, string name = "svt_axi_system_monitor_def_cov_data_callback",bit is_default_cov = 0);
`else
  extern function new(svt_axi_system_configuration cfg,bit is_default_cov = 0);
`endif

 //----------------------------------------------------------------------------
 /**
   * Calls built-in sample function for system_axi_master_to_slave_access
   * covergroup in order to collect coverage for covergoup system_axi_master_to_slave_access
   */
  
  extern virtual function void cov_sample_system_axi_master_to_slave_access();

 /**
   * Calls built-in sample function for system_ace_concurrent_overlapping_coherent_xacts
   * covergroup in order to collect coverage for covergroup system_ace_concurrent_overlapping_coherent_xacts
   */
  
  extern virtual function void cov_sample_system_ace_concurrent_overlapping_coherent_xacts();

  extern virtual function void cov_sample_system_interleaved_ace_concurrent_outstanding_same_id();

 /**
   * Calls built-in sample function for system_ace_snoop_and_memory_returns_data
   * covergroup in order to collect coverage for covergroup system_ace_snoop_and_memory_returns_data
   */

  extern virtual function void cov_sample_system_ace_snoop_and_memory_returns_data();

   /** 
    * Called when a new transaction initiated by a master is observed on the port 
    *   provides coverage for master to slave accessibility. It tries to measure
    *   whether each axi master read from or write into every connected axi slaves
    *   in the system or not. This is captured as a unique master-slave access pair-id
    *   i.e. each master and slave pair is given an unique id represented as an 
    *   individual coverage bin. Following example describes how this pair-id can be
    *   decoded to which {master, slave} pair it belongs to, is given below.
    * -
    * - Ex: system configuration:: num_masters = 3, num_slaves = 2  
    *   Total possible unique values of master_slave_pair_id {0..5}
    *   master_to_slave_pair_id = (master_id * num_slaves) + slave_id;
    *   master_id = INT(master_slave_pair_id / num_slaves) [integer quotient]
    *   slave_id  =    (master_slave_pair_id % num_slaves) 
    *   If coverage report shows id as 3 then master_id = INT(3/2) = 1, slave_id = (3%2) = 1
    *   So, the master-slave access pair, this particular bin has covered, is {master-1, slave-1}
    * .
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual function void new_master_transaction_received(svt_axi_system_monitor system_monitor, svt_axi_transaction xact);

  /** 
    * Called when a new snoop transaction initiated by an interconnect is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  //extern virtual function void new_snoop_transaction_received(svt_axi_system_monitor system_monitor,svt_axi_snoop_transaction xact);

  /** 
    * Called when a new transaction initiated by an interconnect to a slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  //extern virtual function void new_slave_transaction_received(svt_axi_system_monitor system_monitor,svt_axi_transaction xact);

  /** 
    * Called after the system monitor associates snoop transactions to
    * a coherent transaction 
    * @param coherent_xact A reference to the coherent data descriptor object of interest.
    * @param snoop_xacts  A queue of all associated snoop transactions
    */
  //extern virtual function void post_coherent_and_snoop_transaction_association(svt_axi_system_monitor system_monitor,svt_axi_transaction coherent_xact,svt_axi_snoop_transaction snoop_xacts[$]);
endclass

`protected
;F;;+<Y4f8>DK9f@O8?I:.H,7;S,/,4MA(1-:TJd#_f3CF24MYTP,)S)]Rb@c3g^
9(aU^9Wb):G,C)L9RB=e=AJ@5f<93OV)Q9(;2D?eXZRL0;^D#+YFVVX_f\7GV[ZJ
>@)22RV]URZ1F64YBYg<W1Rg[Y@9I&ATND81MH:W:,.(]A:<;)cZA@ZEfWY941ES
SEc_VCC/U2XRaWFcP>VA@.HKC9=/GP<[Y(1C9H.OW?ULd0O2?Z[SR7gMCL2/UHGG
ScK(+IAUD58O)+]L3cYNRUO<dRe:_5[J;d6f7@L4X.UL)],LH<Dbe[cSW-52e]P_
?S+I.@AT6d9O)=__a@3:=+YUM;IeFc2#M\c-0VLFTWfK9Q;g0AHQec?2>2BHAVLU
#fAO1T:YHGNUT9OdM).+7X(H-UO:+PT,JgX#Cc@?C73JO<a+=AWB;)@O@ce0/3:Z
eg,?N0Y^G.2[^WK,D&KMZCPXP?_KCBS72CI3M?V\/_=fU]fQAc0-OFc-)1\<>@]a
TO[fG2P4+[_c\fb7E1)^@/XYFB0UA?\N\\64SJT9dF,;+XP<SJTC8OI../QBZY:4
;EU8aO66?.(^=.XZ1+d5XEefKe=0[#59[CGJHf.+8=I^JJGYb:b\.0R39+M(2-]X
[@Ve;@0Q@BJ83eY?;TUI\9DIYF=>(EE8AR=;[\eagd_3\GMB178f_NOJc[>Q\dDI
-:MH;]a587H9A-M,N)YC0K_W0QF:dH;KW/_R+D^\S.E_?aQZb?_>Gd]L@a30,E^K
^W172F/1Qf9c2W&1IO/1[S?RN(<b6C=(4^8YK<DeaJ05=&RE_0+#dP,M8SQ?HSG6
<)Ug)g&?^O8+;E+)&1+NZEL^;\0I,PX3^ZMP;SOT+&<?(^LW#9Y[(GVbdU-dWJ[/
N2/COe^Q3G&c)HMDWS]P3.b=CcJg^F=WWSCgYZT^-P4,bT\=,J6Ma>E:a(Y4MU/N
.6Y7KG(OUgFLgOC.HBE:fCHaVLPFRK4Ac_.?OWQEW_T<4d34R<4/0T6Z)-Z6;(H\
#1#JeA^;V#+#V(YISTd0>0Ib2TUFIe(V<c7Z^UX(b/(/2Bc8.2NY3;=SG]QUcPQ+
f<P,1#_9Q:;7,e+VI+9FJ;+>3A#ZI+#>_;gVU9e,/F)(X5L=FJC=Y_AJ7d3>ML?c
4Q&/R;)=T=A[b3OC3;;b]0YUHVfeG8B8P&\I81/@@@.9)))0]4J4a.B43XM?Yge<
2bBeU:8_=]B.)OG,e1><CEHKN..Z1HRXM24FJQ590RS/4fN:dN7O1R=F/C\-R_b7
E,D+6R)#QH3Q6BJNIR][6Qb-]]I3efMXDR;,F<#[,dH>SQRbXN^eKSTEHWFQ?CQ@
;5&g,PK\_;H)FSCF8@#4A(P?6CO>c?HfPM9=O+/C,P++;6OREO-:.^^1>:Z4QB5I
,<Z6]A7Of.4,DYG^]D-YQ:K?H9CE?c\YJ@.USDL6B=DZAG9?#G#0=_-D8SGPc6;Z
^,Z?YQTfDb1cNMRT926UIG5.XI=Uc7b/g<X9?FM5U2eLeeN5?7e^?Z(R][#;-(FT
^>MGXSBJ[cLP0R=WH(YaJdZEMHXH?;a.AFO/T[<7T=NEc,D,eKd0?Z&>3K\<]M2M
Q-LNeP\K;U-AWa;2/A3@]V^[6^7\_,7OE(]BV4>f,fZ#=Z92H\0+eM[e/Ha60Q5R
N98HATAS0W/OWL2T#CF(fO=<:V_]D(KPZ6\4;3Pb=e7<#=[D8_1D:ODaA:MFG(H(
37P[V-eORAdA:>BU5,XASaNMZ=O04M4J4-4][:]X000;FT?WIPC+Yb\JVF#adD?f
@>CWb?7AKA:N?E45SCe>[T<NTPSdGH@P_X/.WM7=gVLN/HZg.H\.3R9^5#_7RdWT
K>6@//KM;aa0&4JC4g15XW1=OE:4ZU5fPaAC16B]C?5L)VWd\DW^N[GC\IRIROJA
7(_UDcP3cCLPGNGYJ@g1()^c:9a]@\YU4^SZ\/,-DI9ggg)beA3179[1Fb_^V]BK
<)<)<b^C&[aR-IcJKaY-CP/c-,IS7?R9bC[)EIUIT&HgB$
`endprotected


// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::new_master_transaction_received(svt_axi_system_monitor system_monitor,svt_axi_transaction xact);
  bit is_reg_addr;
  int range_matched, dest_slave_port_id = 0;
  bit [`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] translated_addr;
  semaphore readunique_cleanunique_outstanding_queue_sema = new(1);

  if (!is_default_cov)
    return;

  if(my_system_env == null) begin
`ifndef SVT_VMM_TECHNOLOGY
    my_component = system_monitor.get_parent();
    if (!$cast(my_system_env,my_component)) begin
      `svt_fatal("new_master_transaction_received", "Expected parent of system_monitor to be of type svt_axi_system_env, but it is not");
    end
`else
    base_obj = system_monitor.get_parent();
    if (!$cast(my_system_env,base_obj)) begin
      `svt_fatal("new_master_transaction_received", "Expected parent of system_monitor to be of type svt_axi_system_group, but it is not");
    end
`endif 
  end

  cov_item = xact;

  if (xact == null) begin
    `svt_error("new_master_transaction_received",("xact  is NULL, which should not have been the case"));
  end
  else begin
`ifdef SVT_AXI_DISPLAY_SYS_MON_CALLBACK_MESSAGES 
    `svt_amba_debug("new_master_transaction_received",{`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("New transaction received. outstanding_xact_queue.size() = 'd%0d",outstanding_xact_queue.size())});
`endif    
  end

  if (!is_default_cov) begin
    cover_overlapping_write_xacts(xact); 
    add_to_active_queue(xact);
    return;
  end


  cover_concurrent_overlapping_coherent_xact_on_different_port(xact);
  cover_barrier_during_active_xacts_on_other_port(xact);
  cover_barrier_response_with_outstanding_xacts_on_same_port(xact);
  ace_valid_coherent_valid_read_or_write_channel_overlap;
  //search if there is any concurrent readunique/cleanunique
  fork
    begin
      if (xact != null)
        wait(xact.addr_status==svt_axi_transaction::ACCEPT);
      concurrent_readunique_cleanunique=0;
      if((xact != null) && (xact.xact_type == svt_axi_transaction::COHERENT) && 
         (xact.coherent_xact_type == svt_axi_transaction::READUNIQUE)) begin
        readunique_cleanunique_outstanding_queue_sema.get();
        foreach(readunique_cleanunique_outstanding_queue[i])begin
`protected
Z]?d\g(@XUX^Ib)?G__[823K9O)e+R:OURcJN)/ID#ZBEg3[:@gN-)@DU;7<+.BE
gQb\FSG>;9AS&^>G48Xd>F/SbHI;<cZE?$
`endprotected

          if((readunique_cleanunique_outstanding_queue[i] != null) /*&& (readunique_cleanunique_outstanding_queue[i].addr_ready_assertion_time==xact.addr_ready_assertion_time) */ && 
             (readunique_cleanunique_outstanding_queue[i].xact_type == svt_axi_transaction::COHERENT)) begin
            //concurrent readunique_readunique
            if(readunique_cleanunique_outstanding_queue[i].coherent_xact_type == svt_axi_transaction::READUNIQUE) begin
              concurrent_readunique_cleanunique={8'd5,8'd5};
              ->cov_sys_concurrent_readunique_cleanunique_sample_event;
              `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
                if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                my_system_env.master[readunique_cleanunique_outstanding_queue[i].port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                end
              `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              break;
            end
            //concurrent readunique_cleanunique
            if(readunique_cleanunique_outstanding_queue[i].coherent_xact_type == svt_axi_transaction::CLEANUNIQUE)begin
              concurrent_readunique_cleanunique={8'd5,8'd9};
              ->cov_sys_concurrent_readunique_cleanunique_sample_event;
              `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
                if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                my_system_env.master[readunique_cleanunique_outstanding_queue[i].port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                end
              `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              break;
            end
          end
        end//foreach
        readunique_cleanunique_outstanding_queue.push_back(xact);
        readunique_cleanunique_outstanding_queue_sema.put();

      end // if (xact.xact_type == svt_axi_transaction:: COHERENT &&...
      // VK begins
      // can be else if
      // VK ends
      else if((xact != null) && (xact.xact_type == svt_axi_transaction::COHERENT) && 
              (xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE)) begin
        readunique_cleanunique_outstanding_queue_sema.get();
`protected
@+Z99JPJ1g-RfT;XU53-[gMS:.T0MIOH\ebW_9g/1W6-2T,;b?(64)+=7<7Hf?6,
S:9T\+d^UZ6^DI^^>fYO>3O(Y\65@LN9;$
`endprotected

        foreach(readunique_cleanunique_outstanding_queue[i])begin
          if((readunique_cleanunique_outstanding_queue[i] != null) /*&& (readunique_cleanunique_outstanding_queue[i].addr_ready_assertion_time==xact.addr_ready_assertion_time) */&& 
             (readunique_cleanunique_outstanding_queue[i].xact_type == svt_axi_transaction:: COHERENT)) begin
            //concurrent cleanunique_readunique
            if(readunique_cleanunique_outstanding_queue[i].coherent_xact_type == svt_axi_transaction::READUNIQUE) begin
              concurrent_readunique_cleanunique={8'd9,8'd5};
              ->cov_sys_concurrent_readunique_cleanunique_sample_event;
              `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
                if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                my_system_env.master[readunique_cleanunique_outstanding_queue[i].port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                end
              `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              break;
            end
            //concurrent cleanunique_cleanunique
            if(readunique_cleanunique_outstanding_queue[i].coherent_xact_type == svt_axi_transaction::CLEANUNIQUE)begin
              concurrent_readunique_cleanunique={8'd9,8'd9};
              ->cov_sys_concurrent_readunique_cleanunique_sample_event;
              `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
                if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                my_system_env.master[readunique_cleanunique_outstanding_queue[i].port_cfg.port_id].ace_concurrent_readunique_cleanunique_cov_sample(concurrent_readunique_cleanunique);
                end
              `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              break;
            end
          end
        end//foreach
        readunique_cleanunique_outstanding_queue.push_back(xact);
        readunique_cleanunique_outstanding_queue_sema.put();
      end
    end
  join_none

  foreach (readunique_cleanunique_outstanding_queue[i]) begin
    if ((readunique_cleanunique_outstanding_queue[i] != null) && (readunique_cleanunique_outstanding_queue[i].port_cfg == null)) begin
      `svt_error("new_master_transaction_received",{`SVT_AXI_PRINT_PREFIX1(readunique_cleanunique_outstanding_queue[i]), $sformatf("Port cfg is NULL for index 'd%0d. readunique_cleanunique_outstanding_queue.size() = 'd%0d",i,readunique_cleanunique_outstanding_queue.size())});
    end
  end
  //when it complete, delete that xact
  fork
    begin
      if (xact != null)
        wait(xact.ack_status==svt_axi_transaction::ACCEPT);
      readunique_cleanunique_outstanding_queue_sema.get();
      foreach(readunique_cleanunique_outstanding_queue[i]) begin
        if((readunique_cleanunique_outstanding_queue[i] != null) && (readunique_cleanunique_outstanding_queue[i] == xact)) begin
          readunique_cleanunique_outstanding_queue.delete(i);
        end 
      end
      readunique_cleanunique_outstanding_queue_sema.put();
    end
  join_none

  add_to_active_queue(xact);
  system_interleave_ace_concurrent_outstanding_same_id_xacts();

  if(!(xact.xact_type == svt_axi_transaction:: COHERENT && (
       (xact.coherent_xact_type == svt_axi_transaction:: DVMCOMPLETE) || 
       (xact.coherent_xact_type == svt_axi_transaction:: DVMMESSAGE) || 
       (xact.coherent_xact_type == svt_axi_transaction:: READBARRIER) ||
       (xact.coherent_xact_type == svt_axi_transaction:: WRITEBARRIER) || 
       (xact.coherent_xact_type == svt_axi_transaction:: EVICT) )
      )) begin
    if(sys_cfg.enable_complex_memory_map==1) begin 
      int slave_port_ids[$];
      bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] trans_addr;
      bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr;
      bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] trans_addr_temp;
      bit [`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attrib;
      bit [`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode;
      bit ignore_unmapped_addr = 1;
      bit is_register_addr_space;
      string requester_name;
      bit status;
      requester_name = my_system_env.master[xact.port_cfg.port_id].get_requester_name();
      addr_attrib = (xact.addr >> xact.port_cfg.addr_width);
      mem_mode = {xact.get_transmitted_channel() == svt_axi_transaction::WRITE ? 1'b1 : 1'b0, addr_attrib[0]};

      // Callback to be used to calulate the global address from the master address where some 
      // transactions properties are required for it. This calculation is done using this xact in  
      // 'get_dest_global_addr_from_master_addr()' method of system configuration class.
      // The calculated global address then used to get associating slave address
      system_monitor.pre_routing_calculations_cb_exec(xact);
      status = sys_cfg.get_dest_global_addr_from_master_addr(
        xact.port_cfg.port_id,
        xact.addr,
        mem_mode,
        requester_name,
        ignore_unmapped_addr,
        is_register_addr_space,
        trans_addr,
        xact);
        trans_addr_temp = xact.get_tagged_addr(1,trans_addr);
        trans_addr = trans_addr_temp;
      if (!status) begin
        `svt_error("new_master_transaction_received", $sformatf("Unable to determine the global address from the master address. master id: 'd%0d, master addr: 'h%0x, mem_mode: 'b%b, requester_name: %s", xact.port_cfg.port_id, xact.addr, mem_mode, requester_name));
        return;
      end

      status = sys_cfg.get_dest_slave_addr_from_global_addr(
        trans_addr,
        mem_mode,
        requester_name,
        ignore_unmapped_addr,
        is_register_addr_space,
        slave_port_ids,
        slave_addr,
        xact);
      if (!status) begin
        `svt_error("new_master_transaction_received", $sformatf("Unable to determine the slave address from the global address. master id: 'd%0d, global addr: 'h%0x, mem_mode: 'b%b, requester_name: %s", xact.port_cfg.port_id, trans_addr, mem_mode, requester_name));
        return;
      end
      foreach(slave_port_ids[i]) begin
        master_to_slave_pair_id = (xact.port_cfg.port_id * sys_cfg.num_slaves) + slave_port_ids[i];
        cov_sample_system_axi_master_to_slave_access();
      end 
    end else begin
      translated_addr = sys_cfg.translate_address(xact.addr);
      sys_cfg.get_slave_route_port(translated_addr, dest_slave_port_id, range_matched, is_reg_addr, 0, xact.port_cfg.port_id);
      master_to_slave_pair_id = (xact.port_cfg.port_id * sys_cfg.num_slaves) + dest_slave_port_id;
      // VK begins
      // may be a useful debug msg? no need to have "cov_data-"
      // VK ends
      //`svt_amba_debug("cov_data-new_master_transaction_received", $sformatf("Transaction received for master('d%0d)-to-slave('d%0d) = 'h%0x",xact.port_cfg.port_id, dest_slave_port_id, master_to_slave_pair_id));
      // ->cov_sys_master_port_sample_event;
      cov_sample_system_axi_master_to_slave_access();
      // Cover overlapped ports also. Note that this is optimistic because it will cover all slave ports with overlapping addresses even though the transaction may have been routed only to one of them. But with current architecture this is what can be done.
      if ((range_matched != -1) && sys_cfg.allow_slaves_with_overlapping_addr &&
         sys_cfg.slave_addr_ranges[range_matched].overlapped_addr_slave_ports.size()) begin
         foreach (sys_cfg.slave_addr_ranges[range_matched].overlapped_addr_slave_ports[i]) begin
           master_to_slave_pair_id = ((xact.port_cfg.port_id * sys_cfg.num_slaves) + sys_cfg.slave_addr_ranges[range_matched].overlapped_addr_slave_ports[i]);
           // ->cov_sys_master_port_sample_event;
           cov_sample_system_axi_master_to_slave_access();
         end
      end
    end
  end  
endfunction // new_master_transaction_received
 
function void svt_axi_system_monitor_def_cov_data_callback::cov_sample_system_axi_master_to_slave_access();
endfunction

function void svt_axi_system_monitor_def_cov_data_callback::cov_sample_system_ace_concurrent_overlapping_coherent_xacts();
endfunction

function void svt_axi_system_monitor_def_cov_data_callback::cov_sample_system_interleaved_ace_concurrent_outstanding_same_id();
endfunction

function void svt_axi_system_monitor_def_cov_data_callback::cov_sample_system_ace_snoop_and_memory_returns_data();
endfunction
// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::add_to_active_queue(svt_axi_transaction xact);

  outstanding_xact_queue.push_back(xact);

  fork
  begin
    int _my_xact_index[$];


    xact.wait_end();
    outstanding_xact_queue_sema.get();
    _my_xact_index = outstanding_xact_queue.find_first_index with (item == xact);
    if (_my_xact_index.size()) begin
      outstanding_xact_queue.delete(_my_xact_index[0]);
      //`svt_amba_debug("new_master_transaction_received",{`SVT_AXI_PRINT_PREFIX1(xact),"Transaction ended; deleting from outstanding_xact_queue"});
    end
    outstanding_xact_queue_sema.put();
  end
  join_none
endfunction
// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::post_coherent_and_snoop_transaction_association(svt_axi_system_monitor system_monitor,svt_axi_transaction coherent_xact,svt_axi_snoop_transaction snoop_xacts[$]);
`ifdef SVT_VMM_TECHNOLOGY
  vmm_object base_obj;
  svt_axi_system_group my_system_env; 
`else
  `SVT_XVM(component) my_component;
  svt_axi_system_env my_system_env;
`endif

  if (!is_default_cov)
    return;

`ifndef SVT_VMM_TECHNOLOGY
  my_component = system_monitor.get_parent();
  if (!$cast(my_system_env,my_component)) begin
    `svt_fatal("post_coherent_and_snoop_transaction_association", "Expected parent of system_monitor to be of type svt_axi_system_env, but it is not");
  end
`else
  base_obj = system_monitor.get_parent();
  if (!$cast(my_system_env,base_obj)) begin
    `svt_fatal("post_coherent_and_snoop_transaction_association", "Expected parent of system_monitor to be of type svt_axi_system_group, but it is not");
  end
`endif
  
  // check the association between coherent xcats and snoop xacts
  // also consider the optional snoop transactions defined in ACE spec, table C6-1 
  if(snoop_xacts.size>0) begin
    foreach(snoop_xacts[i]) begin
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::READONCE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READONCE:coh_and_snp_association= {8'd1,8'd0};//READONCE->READONCE
          svt_axi_snoop_transaction::READCLEAN:coh_and_snp_association= {8'd1,8'd2};//READONCE->READCLEAN
          svt_axi_snoop_transaction::READNOTSHAREDDIRTY:coh_and_snp_association= {8'd1,8'd3};//READONCE->READNOTSHAREDDIRTY
          svt_axi_snoop_transaction::READSHARED:coh_and_snp_association= {8'd1,8'd1};//READONCE->READSHARED
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd1,8'd7};//READONCE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd1,8'd9};//READONCE->CLEANINVALID
          svt_axi_snoop_transaction::CLEANSHARED:coh_and_snp_association= {8'd1,8'd8};//READONCE->CLEANSHARED
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::READCLEAN)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READCLEAN:coh_and_snp_association= {8'd3,8'd2};//READCLEAN->READCLEAN
          svt_axi_snoop_transaction::READNOTSHAREDDIRTY:coh_and_snp_association= {8'd3,8'd3};//READCLEAN->READNOTSHAREDDIRTY
          svt_axi_snoop_transaction::READSHARED:coh_and_snp_association= {8'd3,8'd1};//READCLEAN->READSHARED
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd3,8'd7};//READCLEAN->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd3,8'd9};//READCLEAN->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::READNOTSHAREDDIRTY)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READCLEAN:coh_and_snp_association= {8'd4,8'd2};//READNOTSHAREDDIRTY->READCLEAN
          svt_axi_snoop_transaction::READNOTSHAREDDIRTY:coh_and_snp_association= {8'd4,8'd3};//READNOTSHAREDDIRTY->READNOTSHAREDDIRTY
          svt_axi_snoop_transaction::READSHARED:coh_and_snp_association= {8'd4,8'd1};//READNOTSHAREDDIRTY->READSHARED
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd4,8'd7};//READNOTSHAREDDIRTY->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd4,8'd9};//READNOTSHAREDDIRTY->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::READSHARED)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READCLEAN:coh_and_snp_association= {8'd2,8'd2};//READSHARED->READCLEAN
          svt_axi_snoop_transaction::READNOTSHAREDDIRTY:coh_and_snp_association= {8'd2,8'd3};//READSHARED->READNOTSHAREDDIRTY
          svt_axi_snoop_transaction::READSHARED:coh_and_snp_association= {8'd2,8'd1};//READSHARED->READSHARED
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd2,8'd7};//READSHARED->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd2,8'd9};//READSHARED->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::READUNIQUE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd5,8'd7};//READUNIQUE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd5,8'd9};//READUNIQUE->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::CLEANUNIQUE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd6,8'd7};//CLEANUNIQUE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd6,8'd9};//CLEANUNIQUE->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::MAKEUNIQUE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd7,8'd7};//MAKEUNIQUE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd7,8'd9};//MAKEUNIQUE->CLEANINVALID
          svt_axi_snoop_transaction::MAKEINVALID:coh_and_snp_association= {8'd7,8'd13};//MAKEUNIQUE->MAKEINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::CLEANSHARED)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd8,8'd7};//CLEANSHARED->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd8,8'd9};//CLEANSHARED->CLEANINVALID
          svt_axi_snoop_transaction::CLEANSHARED:coh_and_snp_association= {8'd8,8'd8};//CLEANSHARED->CLEANSHARED
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
`ifdef ENABLE_ACE2_COVERAGE
     if(coherent_xact.coherent_xact_type==svt_axi_transaction::CLEANSHAREDPERSIST)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd10,8'd7};//CLEANSHAREDPERSIST->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd10,8'd9};//CLEANSHAREDPERSIST->CLEANINVALID
          svt_axi_snoop_transaction::CLEANSHARED:coh_and_snp_association= {8'd10,8'd8};//CLEANSHAREDPERSIST->CLEANSHARED
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
`endif
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::CLEANINVALID)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd9,8'd7};//CLEANINVALID->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd9,8'd9};//CLEANINVALID->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::MAKEINVALID)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd13,8'd7};//MAKEINVALID->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd13,8'd9};//MAKEINVALID->CLEANINVALID
          svt_axi_snoop_transaction::MAKEINVALID:coh_and_snp_association= {8'd13,8'd13};//MAKEINVALID->MAKEINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::WRITEUNIQUE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd15,8'd7};//WRITEUNIQUE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd15,8'd9};//WRITEUNIQUE->CLEANINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      if(coherent_xact.coherent_xact_type==svt_axi_transaction::WRITELINEUNIQUE)begin
        case(snoop_xacts[i].snoop_xact_type)//coherent->snoop, table C6-1
          svt_axi_snoop_transaction::READUNIQUE:coh_and_snp_association= {8'd16,8'd7};//WRITELINEUNIQUE->READUNIQUE
          svt_axi_snoop_transaction::CLEANINVALID:coh_and_snp_association= {8'd16,8'd9};//WRITELINEUNIQUE->CLEANINVALID
          svt_axi_snoop_transaction::MAKEINVALID:coh_and_snp_association= {8'd16,8'd13};//WRITELINEUNIQUE->MAKEINVALID
        endcase
        ->cov_sys_coh_and_snp_association_sample_event;
      end
      `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        if (my_system_env != null) begin
          my_system_env.master[coherent_xact.port_cfg.port_id].coherent_and_snoop_association_cov_sample(coh_and_snp_association);
          // For trans_master_ace_lite_coherent_and_ace_snoop_response_association
          // covergroup, coherent transaction should be initiated from ACE-Lite
          // master.
          if (coherent_xact.port_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) begin
            // Call
            // ace_lite_coherent_and_ace_snoop_response_association_cov_sample
            // method for each of ACE-Master which are snooped because of this
            // coherent transaction from ACE-Lite Master.
            foreach (snoop_xacts[i]) begin
              if (my_system_env.master[snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb != null) begin
                my_system_env.master[snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb.ace_lite_coherent_and_ace_snoop_response_association_cov_sample(coherent_xact,snoop_xacts);
              end
            end
          end
           // For trans_master_ace_coherent_and_ace_snoop_response_association
          // covergroup, coherent transaction should be initiated from ACE
          // master.
          if (coherent_xact.port_cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) begin
            // Call
            // ace_coherent_and_ace_snoop_response_association_cov_sample
            // method for each of ACE-Master which are snooped because of this
            // coherent transaction from ACEMaster.
            foreach (snoop_xacts[i]) begin
              if (my_system_env.master[snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb != null) begin
                my_system_env.master[snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb.ace_coherent_and_ace_snoop_response_association_cov_sample(coherent_xact,snoop_xacts);
              end
            end
          end
        end
      `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
    end
  end
endfunction // post_coherent_and_snoop_transaction_association

// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::post_system_xact_association_with_snoop(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);
int _sys_xact_idx2[$];
svt_axi_system_transaction back_to_back_xact_t1, back_to_back_xact_t2;

`ifdef SVT_VMM_TECHNOLOGY
  vmm_object base_obj;
  svt_axi_system_group my_system_env; 
`else
  `SVT_XVM(component) my_component;
  svt_axi_system_env my_system_env;
`endif

  if (!is_default_cov)
    return;

`ifndef SVT_VMM_TECHNOLOGY
  my_component = system_monitor.get_parent();
  if (!$cast(my_system_env,my_component)) begin
    `svt_fatal("post_coherent_and_snoop_transaction_association", "Expected parent of system_monitor to be of type svt_axi_system_env, but it is not");
  end
`else
  base_obj = system_monitor.get_parent();
  if (!$cast(my_system_env,base_obj)) begin
    `svt_fatal("post_coherent_and_snoop_transaction_association", "Expected parent of system_monitor to be of type svt_axi_system_group, but it is not");
  end
`endif
  
  if(sys_xact.master_xact.port_cfg.trans_master_ace_lite_coherent_and_ace_snoop_response_association_back_to_back_xact_with_specific_id_enable
      && sys_xact.master_xact.port_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) begin 

    _sys_xact_idx2 = coherent_outstanding_q2.find_first_index with (item.master_xact == sys_xact.master_xact);
    if(_sys_xact_idx2.size() > 0) begin
      back_to_back_xact_t1 = coherent_outstanding_q1[_sys_xact_idx2[0]];
      back_to_back_xact_t2 = coherent_outstanding_q2[_sys_xact_idx2[0]];
      // Call
      // ace_lite_coherent_ace_snoop_response_association_with_specific_id
      // method for each of ACE-Master which are snooped because of this
      // back to back coherent transaction from ACE-Lite Master.
      foreach(back_to_back_xact_t2.associated_snoop_xacts[i]) begin
      `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        if (my_system_env.master[back_to_back_xact_t2.associated_snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb != null) begin
          my_system_env.master[back_to_back_xact_t2.associated_snoop_xacts[i].port_cfg.port_id].master_trans_cov_cb.ace_lite_coherent_and_ace_snoop_response_association_with_specific_id(back_to_back_xact_t1,back_to_back_xact_t2);
        end
       `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      end
      coherent_outstanding_q1.delete(_sys_xact_idx2[0]);
      coherent_outstanding_q2.delete(_sys_xact_idx2[0]);
    end
  end

endfunction // post_system_xact_association_with_snoop

// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::interconnect_generated_dirty_data_write_detected(svt_axi_system_monitor system_monitor, svt_axi_system_transaction sys_xact, svt_axi_transaction slave_xact);

  if (!is_default_cov)
    return;
  master_xact_of_ic_dirty_data_write = sys_xact.master_xact;
  if (sys_xact.ic_generated_dirty_data_writes.size() == 1) begin
    cov_wstrb = sys_xact.ic_generated_dirty_data_writes[0].is_full_cacheline(sys_xact.master_xact.port_cfg.cache_line_size);
  end

  // TBD: Move to svt_amba_debug
  //`svt_amba_debug("interconnect_generated_dirty_data_write_detected", $sformatf("Detected interconnect generated write. Master xact: %0s. Slave xact: %0s",`SVT_AXI_PRINT_PREFIX1(sys_xact.master_xact),`SVT_AXI_PRINT_PREFIX1(slave_xact)));
  if (sys_xact.ic_generated_dirty_data_writes.size() == 1)
    only_one_snoop_returns_data = 1;
  ->cov_sys_ic_dirty_data_write_sample_event;
  `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
  if (my_system_env != null) begin
    my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_dirty_data_write_sample(sys_xact.master_xact);
    my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_dirty_data_write_one_ace_acelite_sample(sys_xact.master_xact);
  end
  `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE

  if (
       (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READONCE) ||
       (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) 
     ) begin
    if (sys_xact.ic_generated_dirty_data_writes.size() >= 1) begin
      ->cov_sys_ic_cross_cache_line_data_write_sample_event;
      `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      if (my_system_env != null) begin
        my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_cross_cache_line_dirty_data_write_sample(sys_xact.master_xact);
      end
      `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
    end
  end
  only_one_snoop_returns_data = 0;

endfunction

function void svt_axi_system_monitor_def_cov_data_callback::master_xact_fully_associated_to_slave_xacts(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);
  int _sys_xact_idx[$];
  fully_correlated_master_xact = sys_xact.master_xact;
  if (!is_default_cov)
    return;
  //`svt_amba_debug("master_xact_fully_associated_to_slave_xacts", $sformatf("Master xact: %0s.",`SVT_AXI_PRINT_PREFIX1(sys_xact.master_xact)));

  if (
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READONCE) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READSHARED) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READCLEAN) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE) 
     ) begin : tag_read_xacts
    svt_axi_transaction _slave_read_xacts[$];
    _slave_read_xacts = sys_xact.assoc_slave_xacts.find with (item.transmitted_channel == svt_axi_transaction::READ);
    if (sys_xact.last_coherent_write_to_addr.size() && 
        !sys_xact.has_snoop_data_transfer() && _slave_read_xacts.size()) begin
`protected
CCM\&XW5.,,8@?,7RFZ]XLf);<#>P<BA+QVPH0-_45<_D5,^c#@@&)7^9XUQHL9O
?b=+U[46K]7@,Y1=?X:R8Kf)7$
`endprotected

      ->cov_sys_overlapped_write_xacts_during_speculative_fetch_sample_event;
      `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        if (my_system_env != null) begin
          my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_write_during_speculative_fetch_sample(sys_xact.master_xact);
        end
      `endif
    end
    _sys_xact_idx = sys_speculative_read_queue.find_index() with (item == sys_xact);
    if (_sys_xact_idx.size()) begin
      sys_speculative_read_queue.delete(_sys_xact_idx[0]);
    end  
  end : tag_read_xacts
endfunction

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::ace_valid_coherent_valid_read_or_write_channel_overlap( );
endfunction
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
function void  svt_axi_system_monitor_def_cov_data_callback::cover_concurrent_overlapping_coherent_xact_on_different_port(svt_axi_transaction xact);

  svt_axi_transaction coherent_transactions_on_other_master_queue[$];
  coherent_transactions_on_other_master_queue = outstanding_xact_queue.find with
    (
      (item.port_cfg.port_id !=xact.port_cfg.port_id) && 
      ( (item.port_cfg.port_interleaving_enable == 0) ||  
        ((item.port_cfg.port_interleaving_enable == 1) && (item.port_cfg.port_interleaving_group_id != xact.port_cfg.port_interleaving_group_id))
      )
    );
  if((xact.xact_type == svt_axi_transaction::COHERENT)&&(xact!=null)) begin
    foreach(coherent_transactions_on_other_master_queue[i]) begin
      if((coherent_transactions_on_other_master_queue[i]!=null) ) begin
        if(coherent_transactions_on_other_master_queue[i].is_address_overlap(xact.get_min_byte_address(),xact.get_max_byte_address(),0,1)) begin
          coherent_xact_on_port1 = coherent_transactions_on_other_master_queue[i].coherent_xact_type;
          coherent_xact_on_port2 = xact.coherent_xact_type ;
          cov_sample_system_ace_concurrent_overlapping_coherent_xacts();
        `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          if (my_system_env != null) begin 
            my_system_env.master[coherent_transactions_on_other_master_queue[i].port_cfg.port_id].trans_master_ace_concurrent_overlapping_coherent_xacts_sample(coherent_xact_on_port1, coherent_xact_on_port2);
            my_system_env.master[xact.port_cfg.port_id].trans_master_ace_concurrent_overlapping_coherent_xacts_sample(coherent_xact_on_port1, coherent_xact_on_port2);
          end
        `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        end
      end
    end
  end
endfunction

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
/** 
 * This function samples concurrent outstanding transactions with same AxID from all masters in each interleaved group.  
 * Example: if interleaved group id as 2 and 4 . Master 1, Master2 belongs to interleaved group id 2 ,
 * Master 3, Master 4 belongs to interleaved group id 4. when Master 1 and Master 2 send concurrent transactions with same
 * AxID, then the bin should hit. 
 */

function void  svt_axi_system_monitor_def_cov_data_callback::system_interleave_ace_concurrent_outstanding_same_id_xacts();
  
  svt_axi_transaction interleaved_same_id_queue[int][$];
  int group_master_id[$];
  int port_id_queue[int][$];
  svt_axi_transaction first_same_id;

  foreach(interleave_unique_group_id[i]) begin
    interleaved_group_id_array[i] = outstanding_xact_queue.find(item) with(
      (item.port_cfg.port_interleaving_enable == 1) && 
      (item.port_cfg.port_interleaving_group_id == interleave_unique_group_id[i])
     );
  end

  //Collect concurrent same id transctions in each interleaved group id 
  foreach(interleaved_group_id_array[i]) begin
    for(int j = 0; j< interleaved_group_id_array[i].size();j++) begin
      first_same_id = interleaved_group_id_array[i].pop_front();
      interleaved_same_id_queue[i].push_back(first_same_id);
      for(int k=0;k<(interleaved_group_id_array[i].size());k++) begin
        if (first_same_id.id == interleaved_group_id_array[i][k].id) begin
          interleaved_same_id_queue[i].push_back(interleaved_group_id_array[i][k]);
          interleaved_group_id_array[i].delete(k);
        end 
      end
      //Checking same id transactions from all masters in each interleaved group id
      foreach(interleaved_port_id[ii]) begin
        for (int jj = 0; jj < interleaved_port_id[ii].size();jj++) begin
          foreach(interleaved_same_id_queue[kk]) begin
            if (interleaved_same_id_queue[kk].size() != 0) begin
              for(int ll = 0; ll < interleaved_same_id_queue[kk].size(); ll++) begin
                if (interleaved_port_id[ii][jj] == interleaved_same_id_queue[kk][ll].port_cfg.port_id) begin
                  port_id_queue[ii].push_back(interleaved_same_id_queue[kk][ll].port_cfg.port_id);
                end
              end
            end 
          end 
        end
        group_master_id = port_id_queue[ii].unique();
        if (interleaved_port_id[ii].size() == group_master_id.size()) begin
          concurrent_outstanding_group_id = ii;
          cov_sample_system_interleaved_ace_concurrent_outstanding_same_id();
        end
        port_id_queue[ii].delete();
        group_master_id.delete();
      end
      interleaved_same_id_queue[i].delete();
    end 
  end  
endfunction

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

function void  svt_axi_system_monitor_def_cov_data_callback::cover_barrier_during_active_xacts_on_other_port(svt_axi_transaction xact);
  svt_axi_transaction _active_barrier_on_other_master[$];
  if (!is_default_cov)
    return;

  foreach (outstanding_xact_queue[i]) begin
    if ((outstanding_xact_queue[i] != null) && (outstanding_xact_queue[i].port_cfg == null)) begin
      `svt_error("cover_barrier_during_active_xacts_on_other_port",{`SVT_AXI_PRINT_PREFIX1(outstanding_xact_queue[i]), $sformatf("Port cfg is NULL for index 'd%0d. outstanding_xact_queue.size() = 'd%0d",i,outstanding_xact_queue.size())});
    end
  end

  // If this transaction has a non-zero priority, then trigger event
  // Search if there are active barriers on other masters
   _active_barrier_on_other_master = outstanding_xact_queue.find with (
           (item.port_cfg.port_id != xact.port_cfg.port_id) &&
           (item.domain_type == xact.domain_type) &&
           (
             (
               (xact.coherent_xact_type != svt_axi_transaction::WRITEBARRIER) &&
               (xact.coherent_xact_type != svt_axi_transaction::READBARRIER) &&
               (xact.qos != 0) &&
               (
                 (item.coherent_xact_type == svt_axi_transaction::WRITEBARRIER) ||
                 (item.coherent_xact_type == svt_axi_transaction::READBARRIER) 
               ) 
             ) ||
             (
               (
                 (xact.coherent_xact_type == svt_axi_transaction::WRITEBARRIER) ||
                 (xact.coherent_xact_type == svt_axi_transaction::READBARRIER) 
               ) &&
               (item.coherent_xact_type != svt_axi_transaction::WRITEBARRIER) &&
               (item.coherent_xact_type != svt_axi_transaction::READBARRIER) &&
               (item.qos != 0) 
             ) 
           )
  );
  is_xacts_from_other_master_during_barrier_covered = 0;
  if (_active_barrier_on_other_master.size()) begin
    is_xacts_from_other_master_during_barrier_covered = 1;
    ->cov_sys_barrier_during_active_xacts_on_other_port_sample_event;
    `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      if (my_system_env != null) begin 
        foreach(_active_barrier_on_other_master[i])
          my_system_env.master[_active_barrier_on_other_master[i].port_cfg.port_id].trans_master_ace_xacts_with_high_priority_from_other_master_during_barrier_sample(is_xacts_from_other_master_during_barrier_covered);
      end
    `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
  end
endfunction


function void svt_axi_system_monitor_def_cov_data_callback::cover_barrier_response_with_outstanding_xacts_on_same_port(svt_axi_transaction xact);
  svt_axi_transaction _active_xacts_on_same_port[$];
  if (!is_default_cov)
    return;
  if ( 
       (xact != null) &&
       ((xact.coherent_xact_type == svt_axi_transaction::WRITEBARRIER) ||
       (xact.coherent_xact_type == svt_axi_transaction::READBARRIER))
     ) begin
    fork
    begin
      xact.wait_end();
      _active_xacts_on_same_port = outstanding_xact_queue.find with (
            (
              (item.coherent_xact_type != svt_axi_transaction::WRITEBARRIER) && 
              (item.coherent_xact_type != svt_axi_transaction::READBARRIER) 
            ) &&
            (item.port_cfg.port_id == xact.port_cfg.port_id) 
          );
      if (_active_xacts_on_same_port.size()) begin
        completed_barrier_xact = xact;
        ->cov_barrier_response_with_outstanding_xacts_sample_event;
        `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        if (my_system_env != null) begin 
          my_system_env.master[xact.port_cfg.port_id].trans_master_ace_barrier_response_with_outstanding_xacts_sample(completed_barrier_xact);
        end
        `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      end
    end
    join_none
  end
endfunction

//-----------------------------------------------------------------------------------------------------
//################################# LOGIC USED BY EXTERNAL COVERGROUP DEFINITIONS #####################
//-----------------------------------------------------------------------------------------------------
function bit svt_axi_system_monitor_def_cov_data_callback::get_concurrent_write_pairs(int port1, int port2, output svt_axi_transaction::coherent_xact_type_enum port1_xact_type, output svt_axi_transaction::coherent_xact_type_enum port2_xact_type);
  int search_port_id = -1;
  get_concurrent_write_pairs = 1;
  if ((last_write_xact != null) && addr_phase_active_write_xacts.size())begin
    if (last_write_xact.port_cfg.port_id == port1)
      search_port_id = port2;
    else if (last_write_xact.port_cfg.port_id == port2)
      search_port_id = port1;
    else
      get_concurrent_write_pairs = 0;
    if (search_port_id != -1) begin
      svt_axi_transaction _overlap_write_in_port[$];
      _overlap_write_in_port = addr_phase_active_write_xacts.find with (item.port_cfg.port_id == search_port_id);
      if (_overlap_write_in_port.size()) begin
        if (_overlap_write_in_port[0].port_cfg.port_id == port1) begin
          port1_xact_type = _overlap_write_in_port[0].coherent_xact_type;
          port2_xact_type = last_write_xact.coherent_xact_type;
        end
        else begin
          port1_xact_type = last_write_xact.coherent_xact_type;
          port2_xact_type = _overlap_write_in_port[0].coherent_xact_type;
        end
      end
      else
        get_concurrent_write_pairs = 0;
    end
  end
  else begin
    get_concurrent_write_pairs = 0;
  end
endfunction

function void svt_axi_system_monitor_def_cov_data_callback::cover_overlapping_write_xacts(svt_axi_transaction xact);
  if (
       (xact.xact_type == svt_axi_transaction::COHERENT) &&
       (
         (xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP) ||
         (xact.coherent_xact_type == svt_axi_transaction::WRITEBACK) ||
         (xact.coherent_xact_type == svt_axi_transaction::WRITECLEAN) ||
         (xact.coherent_xact_type == svt_axi_transaction::WRITEEVICT) ||
         (xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) ||
         (xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE) 
       ) 
     ) begin
    last_write_xact = xact;    
    addr_phase_active_write_xacts = outstanding_xact_queue.find with (
                                 /*(item.addr_status == svt_axi_transaction::INITIAL) &&
                                 (item.xact_type == svt_axi_transaction::COHERENT) && */
                                 (
                                    (item.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP) ||
                                    (item.coherent_xact_type == svt_axi_transaction::WRITEBACK) ||
                                    (item.coherent_xact_type == svt_axi_transaction::WRITECLEAN) ||
                                    (item.coherent_xact_type == svt_axi_transaction::WRITEEVICT) ||
                                    (item.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) ||
                                    (item.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE) 
                                 )
            );
  end
  else
    last_write_xact = null;
endfunction
//-----------------------------------------------------------------------------------------------------

function void svt_axi_system_monitor_def_cov_data_callback::process_xact_for_barrier(svt_axi_system_transaction sys_xact,svt_axi_transaction xact);
  int _sys_xact_idx[$];
  bit is_early_response = 0;
  bit found_ordered_downstream_xact = 0;
  fork
  begin
    sys_xact_queue_sema.get();
    sys_xact_queue.push_back(sys_xact);
    sys_xact_queue_sema.put();
    xact.wait_end();
    sys_xact_queue_sema.get();
    _sys_xact_idx = sys_xact_queue.find_index() with (item.master_xact == xact);
    if (
         (_sys_xact_idx.size) &&   
         (xact.coherent_xact_type == svt_axi_transaction::WRITEBARRIER) ||
         (xact.coherent_xact_type == svt_axi_transaction::READBARRIER)
       ) begin : tag_is_barrier
      svt_axi_system_transaction _sys_write_xact_same_port[$];
      // Check if all WRITENOSNOOP and READNOSNOOP transactions from this port
      // and sent before the barrier have been forwarded to the slave and responses
      // have been received
      foreach (sys_xact_queue[i]) begin : tag_foreach_sys_xact
        if (sys_xact_queue[i].master_xact == xact)
          break;
        if (is_early_response)
          break;
        if (
             (
               (sys_xact_queue[i].master_xact.coherent_xact_type == svt_axi_transaction::READNOSNOOP) ||
               (sys_xact_queue[i].master_xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP) 
             ) &&
             (sys_xact_queue[i].master_xact.transmitted_channel == xact.transmitted_channel) &&
             (sys_xact_queue[i].master_xact.port_cfg.port_id == xact.port_cfg.port_id)
           ) begin
          if (sys_xact.is_xact_fully_mapped) begin
            foreach (sys_xact.assoc_slave_xacts[i]) begin : tag_foreach_slave_xacts
              if (xact.get_end_time() < sys_xact.assoc_slave_xacts[i].get_end_time()) begin
                is_early_response = 1;
                break;
              end
            end : tag_foreach_slave_xacts
            found_ordered_downstream_xact = 1;
          end
          else begin
            is_early_response = 1;
            break;
          end
        end
      end : tag_foreach_sys_xact
      if (!is_early_response && found_ordered_downstream_xact) begin
        // Sample covergroup
        num_downstream_xact_response_before_barrier_response++;
        ->cov_sys_downstream_xact_response_before_barrier_response;
      end
    end : tag_is_barrier
    if (_sys_xact_idx.size())
      sys_xact_queue.delete(_sys_xact_idx[0]);
    sys_xact_queue_sema.put();
  end
  join_none
endfunction
//-----------------------------------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::new_system_transaction_started(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact,svt_axi_transaction xact);
  int queue_size,before_queue_size;
  int _sys_xact_idx[$];
  svt_axi_system_transaction _active_queue_before_curr_xact[$];
  int same_id_in_xact = 0;
  svt_axi_system_transaction t1_sys_xact;
  svt_axi_system_transaction _back_to_back_xact_q[$];
  svt_axi_system_transaction temp_coherent_xact_t1,temp_coherent_xact_t2;
  real master_xact_start_time,slave_start_time,slave_end_time;
  fully_correlated_master_xact = sys_xact.master_xact;
  
  outstanding_sys_xact_queue.push_back(sys_xact);

  fork
  begin
    int _my_sys_xact_index[$];
    t1_sys_xact = sys_xact;
    
    if(t1_sys_xact.master_xact.port_cfg.trans_master_ace_lite_coherent_and_ace_snoop_response_association_back_to_back_xact_with_specific_id_enable
      && t1_sys_xact.master_xact.port_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) begin
      _back_to_back_xact_q = outstanding_sys_xact_queue.find with (item.master_xact.port_cfg.port_id == t1_sys_xact.master_xact.port_cfg.port_id &&
                                                                   item.master_xact.transmitted_channel == svt_axi_transaction::WRITE);
      if(_back_to_back_xact_q.size() > 1) begin 
        if(_back_to_back_xact_q[$].master_xact.id == _back_to_back_xact_q[$ - 1].master_xact.id)  begin
          temp_coherent_xact_t1 = _back_to_back_xact_q[$ - 1];
          temp_coherent_xact_t2 = _back_to_back_xact_q[$];
          same_id_in_xact = 1;
        end
      end

      if(same_id_in_xact) begin
        coherent_outstanding_q1.push_back(temp_coherent_xact_t1);
        coherent_outstanding_q2.push_back(temp_coherent_xact_t2);
      end
    end

    sys_xact.master_xact.wait_end();

    if (
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READONCE) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READSHARED) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READCLEAN) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY) ||
        (sys_xact.master_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE) 
     ) begin : tag_read_xacts
      svt_axi_transaction _slave_read_xacts[$];
      sys_speculative_read_queue.push_back(sys_xact);
      
      _slave_read_xacts = sys_xact.assoc_slave_xacts.find with (item.transmitted_channel == svt_axi_transaction::READ);
      if (sys_xact.has_snoop_data_transfer())  begin : tag_has_snoop_data
        if (_slave_read_xacts.size())  begin : tag_has_snoop_and_memory_data
          real snoop_start_time, snoop_end_time;
          snoop_start_time = 0;
          snoop_end_time = 0;
          // For snoop transtions, we check which snoop ended first. Obviously, this will be 
          // used by the interconnect to service a read transaction. The snoop start time and
          // end time used for checking if the times overlap with that of the memory read will
          // be corresponding to this transaction
          foreach (sys_xact.associated_snoop_xacts[i]) begin
            if (sys_xact.associated_snoop_xacts[i].snoop_resp_datatransfer) begin
              if ( 
                    (snoop_end_time == 0) || 
                    (sys_xact.associated_snoop_xacts[i].get_end_time() < snoop_end_time)
                 )begin
                svt_axi_snoop_transaction _snoop_xact = sys_xact.associated_snoop_xacts[i];
                snoop_start_time = _snoop_xact.snoop_data_valid_assertion_time[0];
                snoop_end_time =  _snoop_xact.snoop_data_valid_assertion_time[_snoop_xact.snoop_data_valid_assertion_time.size()-1];
              end
            end
          end
          slave_start_time = 0;
          slave_end_time = 0;
          // For slave transactions, there could be multiple slave transactions. For example,
          // if the data width is smaller or if the interconnect chose to send multiple smaller
          // transactions. So for the purposes of detecting overlaps in time between snoop and memory
          // transactions, the start time is the time corresponding to the transaction that ended first
          // and the end time is the time corresponding to the transaction that ended last
          foreach (_slave_read_xacts[i]) begin
            if ( 
                  (slave_start_time == 0) || 
                  (_slave_read_xacts[i].get_begin_time() < slave_start_time)
               )
              slave_start_time = _slave_read_xacts[i].data_valid_assertion_time[0];
            if ( 
                  (slave_end_time == 0) || 
                  (_slave_read_xacts[i].get_end_time() > slave_end_time)
               )
              slave_end_time = _slave_read_xacts[i].data_valid_assertion_time[_slave_read_xacts[i].data_valid_assertion_time.size()-1];
          end

          if (
               (snoop_start_time != 0) && (snoop_end_time != 0) &&
               (slave_start_time != 0) && (slave_end_time != 0)
             ) begin
            // Snoop data started and ended before slave data started
            if ((snoop_start_time < slave_start_time) && (snoop_end_time < slave_start_time))
              snoop_and_memory_read_timing = SNOOP_BEFORE_MEMORY_READ;
            // Snoop data started after all slave data was received
            else if (snoop_start_time > slave_end_time)
              snoop_and_memory_read_timing = SNOOP_AFTER_MEMORY_READ;
            // Overlap in timing of snoop and memory
            else
              snoop_and_memory_read_timing = SNOOP_ALONG_WITH_MEMORY_READ;
          end
          else
            snoop_and_memory_read_timing = SNOOP_WITHOUT_MEMORY_READ;
        end : tag_has_snoop_and_memory_data
        
        cov_sample_system_ace_snoop_and_memory_returns_data();
        `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
        if (my_system_env != null) begin
          my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_snoop_and_memory_returns_data_sample(snoop_and_memory_read_timing , sys_xact.master_xact);
        end
        `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      end : tag_has_snoop_data
    end : tag_read_xacts

    _my_sys_xact_index = outstanding_sys_xact_queue.find_first_index with (item.master_xact == sys_xact.master_xact);
    if (_my_sys_xact_index.size()) begin
      outstanding_sys_xact_queue.delete(_my_sys_xact_index[0]);
    end
  end
  join_none

  // This processing is for
  // system_ace_downstream_xact_response_before_barrier_response which is
  // currently not enabled because we are not seeing this behaviour in CCI-400
  // and therefore we are not sure if this is a valid covergroup
  //process_xact_for_barrier(sys_xact,xact);
  
  _active_queue_before_curr_xact = sys_xact.xacts_started_before_curr_xact_queue.find with (
                                   (item.master_xact.xact_type == svt_axi_transaction::COHERENT) &&
                                   (item.master_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE  ||
                                    item.master_xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE ||
                                    item.master_xact.coherent_xact_type == svt_axi_transaction::READONCE ||
                                    item.master_xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE ||
                                    item.master_xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE ||
                                    item.master_xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE)
                                  ); 
  before_queue_size = _active_queue_before_curr_xact.size();
  if((before_queue_size) && (!_active_queue_before_curr_xact[before_queue_size-1].master_xact.is_address_overlap(xact.get_min_byte_address(),xact.get_max_byte_address()))) begin
    _active_queue_before_curr_xact.delete(before_queue_size-1);
  end
  while (before_queue_size) begin
    before_queue_size--;
  end
  queue_size = _active_queue_before_curr_xact.size();
  
  if(_active_queue_before_curr_xact.size()) begin
    for(int i=0; i< queue_size; i++) begin
      case (xact.coherent_xact_type)
        svt_axi_transaction::READUNIQUE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE) begin
            store_overlap_coh_xact = {8'h05, 8'h05};
            ->cov_sys_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
        svt_axi_transaction::CLEANUNIQUE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE) begin
            store_overlap_coh_xact = {8'h06, 8'h06};
            ->cov_sys_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
        svt_axi_transaction::MAKEUNIQUE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE) begin
            store_overlap_coh_xact = {8'h07, 8'h07};
            ->cov_sys_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_store_overlapping_coherent_xact_sample(store_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
        svt_axi_transaction::READONCE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::READONCE) begin
            no_cached_copy_overlap_coh_xact = {8'h01, 8'h01};
            ->cov_sys_no_cached_copy_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
        svt_axi_transaction::WRITEUNIQUE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) begin
            no_cached_copy_overlap_coh_xact = {8'h15, 8'h15};
            ->cov_sys_no_cached_copy_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
        svt_axi_transaction::WRITELINEUNIQUE: begin
          if(_active_queue_before_curr_xact[i].master_xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE) begin
            no_cached_copy_overlap_coh_xact = {8'h16, 8'h16};
            ->cov_sys_no_cached_copy_overlap_coh_xact_sample_event;
            `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
              if (my_system_env != null) begin
                my_system_env.master[xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
                my_system_env.master[_active_queue_before_curr_xact[i].master_xact.port_cfg.port_id].trans_master_ace_no_cached_copy_overlapping_coherent_xact_sample(no_cached_copy_overlap_coh_xact);
              end
            `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
          end
        end
      endcase
    end
  end
endfunction // new_system_transaction_started
// -----------------------------------------------------------------------------
function void svt_axi_system_monitor_def_cov_data_callback::cov_sample_system_snoop_and_memory_returns_data(svt_axi_system_monitor system_monitor,svt_axi_system_transaction sys_xact);
  svt_axi_transaction _slave_read_xacts[$];
  fully_correlated_master_xact = sys_xact.master_xact;
  
  _slave_read_xacts = sys_xact.assoc_slave_xacts.find with (item.transmitted_channel == svt_axi_transaction::READ);
  if (sys_xact.has_snoop_data_transfer())  begin : tag_has_snoop_data
    if (!_slave_read_xacts.size())  begin : tag_has_snoop_and_memory_data
      snoop_and_memory_read_timing = SNOOP_RETURNS_DATA_AND_MEMORY_NOT_RETURNS_DATA;
    end : tag_has_snoop_and_memory_data
    
    cov_sample_system_ace_snoop_and_memory_returns_data();
    `ifndef SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
      if (my_system_env != null) begin
        my_system_env.master[sys_xact.master_xact.port_cfg.port_id].trans_master_ace_snoop_and_memory_returns_data_sample(snoop_and_memory_read_timing , sys_xact.master_xact);
      end
    `endif // SVT_AXI_EXCLUDE_AXI_PORT_COVERAGE
  end : tag_has_snoop_data
endfunction // cov_sample_system_snoop_and_memory_returns_data

`endif // GUARD_SVT_AXI_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV

