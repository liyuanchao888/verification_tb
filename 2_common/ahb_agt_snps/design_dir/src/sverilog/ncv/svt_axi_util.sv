
`ifndef GUARD_SVT_AXI_UTIL_SV
`define GUARD_SVT_AXI_UTIL_SV

`include "svt_axi_defines.svi"


typedef class svt_axi_checker;

 /** @cond PRIVATE */

class qvn_token_pool;

  local int token_id;        // provides each tokena a unique id during its lifetime
  local int token[$];        // queue to store tokens with specific ids
  local int qos[$];          // queue to store QOS values with which current token was granted
  local int grant_cycle[$];  // queue to store cycle number at which current token was granted
  local bit enable_token_expiry_on_usage_limit = 0;  // enables token removal if not used in time
  local int count_token_requests_pending_for_grant;  // 

  local int clock_period;
  local string vn_node_name;
  local bit is_parent_slv;
  local int max_outstanding_token;
  local int last_token_req_qos_val = 0;
  
  semaphore token_request_access_sema;  // gives access to token request channel to only 1 process
  semaphore token_queue_access_sema;    // gives access to token pool properties to only 1 process
  svt_timer token_usage_timer_queue[$]; // queue to store timer handles of current available tokens
  svt_timer token_ready_timer;

  svt_axi_checker axi_checker;

  `ifdef SVT_UVM_TECHNOLOGY
    uvm_report_object reporter;
  `elsif SVT_OVM_TECHNOLOGY
    ovm_report_object reporter;
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename( qvn_token_pool )
  `endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log log = new("qvn_token_pool", "class" );
  `endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
f3CX424m4Fk5aOuL6W+7JAR40lcI1ak4+oI2XG8zkCtxKzxaP2C9pspgooRXH1WB
3vQbio42NLdhdx+BXt4mFSKp17TLnuOjGboPrFhvTvXR7lKSDt6R3SkjJiuE0flD
ZJcxSz7qQOddaF7kSsDtwLxPe2XBohD5v1xyNnSzE4+B4E1t2ObO2w==
//pragma protect end_key_block
//pragma protect digest_block
5UiqBbsTiRbWdJVrs3xF5iFqi64=
//pragma protect end_digest_block
//pragma protect data_block
ULoezJ+qN7cikb1/phSBY9ILi5uosuijJYSmuUZtQQL05lfuAg2hIKfDCzSfz+Kf
qObGop98OSJJT7Ksgqmxm2SB2hIkz9NZtyV1VVIjJVc8wcBlVhCqV3l2a2gX7Maa
YOeNxlXKNrF+7t83VYjye/1jIeQNHwTyPTiLSyWsZ4iRswV28uRX5PYEKi2Avmay
5YCV94tsZboblJHI9gCW/lcO91reMH9G9IN/owokMJvBBuWWV0DYsaOTalp2d8Sc
kmMELphFWHeBTzGul37w8tpQZFT2Gs2kyIaN2URJL2XnOyFGC9qtAEJPuT7I5j8k
CHW+ZqyJzKb1BGXZL65K/1YoZ61hIRpt9pDA6MbzWekbKqkJBs8Hm26KPqoFFyTZ
8ALh8X9J6JvZvlEPMQBRbOQYhR7BtlyrFny23LQac+zBobsRG25zJSUFXdOcJumb
WDIWgr8oZ5C/xp0zfhGCa78fIZCWJ76atrbTpw6JEb3X5n/my/BhGnMtCVYOhLbf
ilTgqOKNadQKC8yr2FnD6Ihf1wiZa2tK6192HCEpg1s7XvJGGCAaLMy1r9oDaWC7
omG9ZEJz7px2xvJJ+y9HW2StCt+iuxCKon5WnhFM4PzwB8kQf26UEQSiwnClSS21
7UgeIyGu/WLZ81IwRwFyhDGh4RgUNZ/EWL//wgFtZBptvHkDvc0NnMZYdnTo61DT
rrdu9YF4EVoYC48UJMvak2XHFoIrIyvMNHGePRkh78joR2NJ31k77Phcr1ierUNj
LWdSb6oOgwAEeB7nX4NvPqoOeg3vsBS5lPO/8QXoxWTYk7+OzilPiOgMTVA0JiAN
t7/zImytRb34dmSa2MdhvwoxX+a/yu97POfGcXUXxVJnOQmAnYwkHNQKgkBQgV+m
N2ltSZlNkZE3ZZw9jF/pO1kdw3UMYgk20f+4e59FCxw8zYeYVChhNFxT+Io2jDnk
F07nKHdXLKrr/MYwxEVaLCCQEfQBo0Arm+r6AfoSBlVAqO0whBQKHp5c3a8zXD57
7ZRhSBtk2Z/H7D7tbhU5ZSDkEvCwohP7AvZ1gRB7CeZdxBZOwXPfmgX8X/sN0VPn
bN3WiZIGGOnVvXNGTluJf6H8AnDgcZapetn89d5ONm0gUv2pnIkWuguOD75tL0bP
ih2pfJm1PYEGzMhYQoF+b7MPd7CxJctL9YIgCzj1ghsTnBKUfdkmjYdkZmri4mOk
kNjNJZE4aiVXuGRE3xSETW9ykSkIu+QLbj5TawlPjWYVwU0eUk4DONq/w0RPPoIM
2DVVe2rrVhwTIIE4hJJIIvCsMDANcqzz2tLsLlE1Z2ArZOFzvDTz3hkrzSfYmwtk
jtxvcY94jV0D5HIeEc36hl9mQMPpOCiKEa/wMglVX6VI7UPWHm2CCeXez8bRY5Z/
6dbZCrq+UYX5XKYrtoi7wJlQ3nv29GWAOKNhv6Tpzv1D1BODrnDc2Y/o4CQCEYYk
fCpP3hAai2m0v5ZPj9D3S+3HN5croaaBibqc0/F9vkKmsc/h7NsQ0zul+KiyQ0uo
NS1NWTF6/oUARnIrgyqrQyT8j9KPKCsde/ipiT/Nl5lY7HoQlcfZOpDP4J9tnCnU
v8S4s3yvvQTQWrfrUkEjnAxM2AAZuxR72F9oUReD9TxzokJRcbr6Eizs2Jykj7LH
vk80nKLA9tmjykpuU2IeRtnqHyhHJ1s0yH4JoOVy/ZV75Lugk0ABAmGDqP4uu1Zk
giU8S23VaemZjAGn1G2hcNkJq1MdvfA4jooefCfeQISSi/mId6xmtsePo6GH+CXe
gb0l8l6Fq5MC1Dp+Z2+sJIqZcyD3rXtFBMpa6Bp0r+c=
//pragma protect end_data_block
//pragma protect digest_block
Ndmxj0vju6FW8zoF2bZ+UkXYTcs=
//pragma protect end_digest_block
//pragma protect end_protected

  //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
A6JRKZ0wfxo8HWeXEmw7//QVVxBTFBQmnIi2fpwqEsI8THKzLy6KpT17OXcXFLGn
l3dbu96cUEkdCQpJ1NohUy7gBj63zQMmSIlIAr1QPgWG1vUt8pHy1NKD9EGOFP6S
D4aP95WpZMHgs115MIxoQ56thMdQGLm4uQaTYsDQS2JvHirJ1zIiZQ==
//pragma protect end_key_block
//pragma protect digest_block
OTh67znkYLL0JOD+rMg7NNhF78w=
//pragma protect end_digest_block
//pragma protect data_block
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
IdSd1+ATXkPYPOzQmdQUHw==
//pragma protect end_data_block
//pragma protect digest_block
z/5mdwxyzQXkgECOMdOgRvZzLyY=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IfEHEP4THGhHa1MHDREdUAi2GeiwVR4bL/HUDgYI5VcKd79XBmDTKiyBzwodEIum
+y5Dlebqjst7vBai/Q3D+QOpmvobBMeJ3vuQc+KMc6dWVDt+uw67lofsg6sFprBS
94/L8ZNabfcj0CK5N0DmnsyUfmMG1Ja0dSyAUuxaLX3RZsgDPKECDA==
//pragma protect end_key_block
//pragma protect digest_block
zrMJXSjRky5UFwS3+ZcL8mNZEqc=
//pragma protect end_digest_block
//pragma protect data_block
eKqQkW38Vn85yrFwRPKj6V4+hQzIlyOa3K/I9w0dmxOEeia53nuYwmA0juz0EUJM
YnuG0lYp1Y5p+28liu0Mkp/lX953xYdkfhQPb8hq2b6bKO1F/miq1fRtcelgPrkT
hryk+J3C+dBOxiZr+n3npL/KkloBCcyoczqveJpD0gJHbuwyZqvNLqPpQ9BLs90+
YVJpkVFVS5dTSpyV1CrXAdpMuPrRek2fzGcqtEKwjsMBydGCWY7JGZPwQBjPFmSd
SsbtKiik9K0TYWtjNaKOznFM8YvdG9OSW0STf8IxsrSdzRdtFYD8zIFj1MgQmqRz
Mi9Zq4F0gjnSWLuYfNk0jWHlHgrDErKzsPMQ98D+2RwkIeEnLquhsphvygegXMw/
uo2uEx9KRzkMUjL/fTuq1loxOVMTwAf4co98CYLvVli+eBqpgd+yrFygHSiV7ouh
5ZBrqAZ+O18F0HlY/DOAcQ==
//pragma protect end_data_block
//pragma protect digest_block
plMWcEaoUZjTiGf8s2uDp03fQP0=
//pragma protect end_digest_block
//pragma protect end_protected
           //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pC7M67t+00AipDz0Szdc0NBsPbs9ogrh/ujOTSHvhEHZDUqwub34KxYeOex26G5V
2+I9oQcMZk74yOfDJ6q+8cc+B5coDJM72ybmBLxzsceJGvsI/SdFQfZEKhJcLXcG
V4O6DLr452Q/ILv+M0kJ4vDy2c1cJ4snNbQnoaAOCIZpIBWrVBga/w==
//pragma protect end_key_block
//pragma protect digest_block
CDKoRA3YuJ5qknBkJbq6auZ8nNc=
//pragma protect end_digest_block
//pragma protect data_block
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
+w2WoMYO/GE++HxVjYG5TQ==
//pragma protect end_data_block
//pragma protect digest_block
4dui9KfxAIdVCnw7+9beM58PBdw=
//pragma protect end_digest_block
//pragma protect end_protected
endclass  //qvn_token_pool
  /** @endcond */



/*
  * Exclusive Master Monitor::
  * Each Master in an AXI based system that permits to carry out Exclusive Transactions, must implement
  * a Monitor which observes all incoming Read/Load and Write/Store operations and track the state of 
  * Exclusive sequence, Master has setup for a particular Address unit or Coherent granularity for ACE systems.
  * Once it detects that it is broken by other master or by itself, it disallows any further Exclusive
  * Write / Store to be successful, until a fresh set-up is re-established through new Exclusive Read / Load.
  *
  * =======================   
  * Exclusive Access Rules:   
  * =======================   
  *  - Exclusive Load registrars and starts Exclusive Access Sequence
  *     o check exclusive access Monitor status, if failed then reset monitor
  *     o if SNOOP transaction is received by the master for same address then reset monitor
  *         ? does it apply for any snoop transaction to same address or only those snoop which will cause cacheline eviction
  *         ? if it invalidates or indicates another master performing a store
  *     o when current exclusive load completes, check for response. If NOT(EXOKAY) then reset monitor
  *     ? should secure/non-secure attribute i.e. ARPROT[1] uniquify each Address or in other words, two Exclusive Load / Store
  *          operation configured as secured and unsercured, should be treated as part of two seperate Exclusive Sequence ??
  *
  *  - Another Exclusive Load for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {same-ID, same-ADDRESS}  =>  no effect
  *     o same-Master :: {same-ID, diff-ADDRESS}  =>  reset monitor with new address
  *     o same-Master :: {diff-ID, diff-ADDRESS}  =>  set monitor (one address monitor per ID, N number of ID supported per master)
  *     o same-Master :: {diff-ID, same-ADDRESS}  =>  set monitor for this ID, existing monitor for same ADDRESS from other ID remains set
  *     o diff-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *     o diff-Master :: {Mismatch in control signals like AxDOMAIN, AxPROT etc. w.r.t. transaction issued by other Master} => reset monitor ??
  *
  *  - Another non-exclusive Load for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *     o diff-Master :: {any-ID,  any-ADDRESS}   =>  no effect ??
  *
  *
  *  - Exclusive Store completes an existing Exclusive Sequence
  *     o However, ACE supports continuing further exclusive store to same address      [configuration:: ace_exclusive_continue_post_store_sequence]
  *     o check exclusive access Monitor status, if sequence exists and monitor is set then Store PASSES otherwise, reset monitor and mark FAILED
  *             - no existing Exclusive Sequence for this Address i.e. no prior Exclusive Load  =>  reset monitor, FAIL
  *             - no existing Exclusive Sequence for this Address, address was reset            =>  reset monitor, FAIL
  *     o if SNOOP transaction is received by the master for same address then reset monitor, mark Store FAIL
  *             -  if current transaction is not chosen by interconnect over another master due to overlapped transactions then also it'll receive snoop
  *             .
  *     o when current exclusive store completes, check for response. If NOT(EXOKAY) then reset monitor
  *             - if any of the propagated snoop response is erroneous then Store Fails, reset monitor
  *             .
  *     o once RACK is received, check if monitor is still set, otherwise Store FAILS   [exclusive sequence monitor to be deleted only after RACK]
  *
  *  - Another Exclusive Store for below scenarios, received by a Master before current Exclusive Sequence is complete:
  *     o same-Master :: {same-ID, same-ADDRESS}  =>  no effect, PASS
  *     o same-Master :: {same-ID, diff-ADDRESS}  =>  reset monitor, delete seq, FAIL  [ monitor > 1  =>  no effect on current addr until limit reched]
  *     o same-Master :: {diff-ID, diff-ADDRESS}  =>  no effect on current address monitor
  *     o same-Master :: {diff-ID, same-ADDRESS}  =>  reset monitor, delete seq, FAIL  
  *     o diff-Master :: {any-ID,  same-ADDRESS}  =>  reset monitor, delete seq, FAIL  [ snoop will be received so FAILED ]
  *     o diff-Master :: {any-ID,  diff-ADDRESS}  =>  no effect ??
  *     o diff-Master :: {Mismatch in control signals like AxDOMAIN, AxPROT etc. w.r.t. transaction issued by other Master} => reset monitor ??
  *
  *  - Another non-exclusive Store received by a Master before current Exclusive Sequence is complete:
  *     o  any-Master :: {any-ID, same-ADDRESS}  =>  reset monitor
  *     o  any-Master :: {any-ID, diff-ADDRESS}  =>  no effect
  *     o same-Master :: {cacheline evicted   }  =>  reset monitor   [EVICT transaction]
  *
  *  - Stop Exclusive Coherent Transaction Propagation:
  *     o exclusive sequence monitor is reset when Exclusive Store arrives
  *             - various reasons: load error, address reset by another load, reset due to store, snoop received to same address
  *             -                  other master issued txn, cacheline evicted, not scheduled for overlapped transactions
  *             .
  *     o snoop is received to same address as current exclusive store 
  *     o if it is known that, it will Fail as soon as current exclusive store arrives  [ Ex: monitor reset, no corresponding exclusive sequence ]
  *
  *  - Configurability for each Master:
  *     o ace_exclusive_continue_post_store_sequence   =>   address monitor continues to remain set after last successful Exclusive Store until reset
  *     o ace_exclusive_sequence_starts_w_first_store  =>   exclusive sequence can be started with first exclusive store post reset or Unique CL state
  *     o ace_exclusive_num_id_bits_supported          =>   number of transaction ID bits used to identify unique exclusive access by each Master 
  *     o ace_exclusive_num_addr_bits_supported        =>   number of transaction ADDRESS bits used to identify unique exclusive access by each Master 
  *     o ace_exclusive_reset_monitor_on_load_from_diff_id  =>   if a master sends exclusive load to monitored address with different id then reset it
  *
  *  - Secure / non-Secure Exclusive Access can progress indipendently => use different ID to ensure indipendent progress in AXI Interconnect
  *  - Snoop to current master resets monitor, (same no. of address bits used to check snoop overlap)
  *  .
  */

/*
  * ===============================
  * ACE Master Exclusive Monitor ::
  * ===============================
  * Master implements a master exclusive monitor, that is used to monitor the location used by an Exclusive
  * sequence. This master exclusive monitor is used to determine if another master could have performed a 
  * store to the location during the Exclusive sequence, by monitoring the snoop transaction it receives.
  * When the master performs an Exclusive Load, the master exclusive monitor is set. The master exclusive
  * monitor is reset when a snoop transaction is observed that indicates another master could perform a store
  * to the location.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * ACE Master Exclusive Monitor Rules:
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  - Exclusive sequence is started once a Exclusive Load (RDS, RDC) or Exclusive Store (CLU)
  *  - If master does not hold the cache line then it must load it using ReadClean or ReadShared
  *  - If Exclusive accesses are not supported then it will receive OKAY response
  *
  *  - Reset monitor if snoop txn is received to same cacheline (invalidation) for possible store by other master
  *  - Reset monitor if same cacheline results into invalidation either by coherent txn or snoop request ?
  *
  *  ? Does a prefetch resets monitor i.e. Ex-Load followed by a Load
  *  ? Does a write by other master WU/WLU reset monitor since current master will receive snoop invalidation
  *  ? Does a write by other master WB/WC/WE/EV reset monitor ? 
  *  ? Does a write by current master WU/WLU/WC reset monitor ?
  *  ? Does a write by current master WB/WE/EV reset monitor since it evicts cacheline in current master ?
  *  ? Even though WrNoSnoop shouldn't have been received to same location but, if it does then would master or
  *    PoS monitor reset it ?
  *  ? PoS monitor starts exclusive sequence with Exclusive Store once it fails i.e. not as soon as it is received
  *    unlike exclusive load transactions. Is the same true for master monitor as well ?
  *
  *  - CHECK: A master must not permit an Exclusive Store transaction to be in progress at the same time as
  *           any transaction that registers that it is performing an Exclusive sequence. The master must 
  *           wait for any such transaction to complete before issuing an Exclusive Store transaction.
  *
  *  - CHECK: If monitor is reset then master must not issue an Exclusive Store.
  *           This prevents issuing a txn that will eventually fail and unnecessarily invalidate other copies
  *  .
  */

/*
  * ======================================
  * PoS Exclusive Monitor (interconnect)::
  * ======================================
  * ACE Coherent Interconnect maintains an exclusive access monitor for each point of serialization or PoS.
  * The interconnect can pass or fail an Exclusive Store transaction. A pass indicates that the transaction
  * has been propagated to other cacheable masters, but it does not indicate whether the Exclusive Store 
  * passes or fails. A fail indicates that the transaction has not been propagated to other masters and 
  * therefore the Exclusive Store cannot pass.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * PoS Exclusive Monitor Rules:
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  - Exclusive sequence is started once a Exclusive Load (RDS, RDC) or 
  *  - Exclusive sequence is started once a Exclusive Store (CLU) txn is failed
  *  - Master must register start of Exclusive sequence for its Ex-Store transaction to be successful
  *  - If no successful Ex-Store from other master once exclusive sequence started then Ex-Store should PASS
  *
  *  - Once Ex-Store transaction from one master passes, registered attempts of all other masters is reset
  *  - non-Exclusive transaction has no affect
  *  - Ensures that Ex-Store txn from a master is successful if that master could not have received a snoop
  *       transaction related to an Ex-Store from another master after it issued its own Ex-Store txn
  *
  *  - Exclusive sequence is not stopped once a Exclusive Store (CLU) txn is successful
  *  - Other masters can only register a new Exclusive sequence after RACK for the Ex-store that passed.
  *  - From reset, first master to perform an Ex-Store transaction can be successful, but not required
  *  .
  */

typedef class svt_axi_transaction;
typedef class svt_axi_system_transaction;
typedef class svt_axi_port_configuration;
typedef class svt_axi_checker;

class svt_axi_exclusive_monitor;
 
 string           inst_name = "";
 svt_axi_port_configuration cfg;
 svt_axi_checker  axi_checker;

 /** Variable that stores the exclusive write transaction count */
 int excl_access_cnt = 0;

 /** expected exclusive read response */
 svt_axi_transaction::resp_type_enum expected_excl_rresp[*];

 /** expected exclusive write response */
 svt_axi_transaction::resp_type_enum expected_excl_bresp[*];

 /** flag for received exclusive load transaction error */
 protected bit excl_load_error;

 /** flag for received exclusive store transaction error */
 protected bit excl_store_error;

 /** Internal queue to buffer the incomming exclusive load transactions */
 svt_axi_transaction exclusive_load_queue[$];

 /** Internal queue to buffer the current exclusive load due to reset of 
   * address by incoming exclusive load transactions */
 svt_axi_transaction exclusive_load_reset_queue[$];

 /** It sets ID to 1 if exclusive access at any monitored load location
   * is failed due to current normal store transaction to same address */
 protected bit excl_fail[*];

 /**
   * Indicates if an exclusive access is expected to fail because of
   * snoop invalidation
   */
 protected bit snoop_excl_fail[*];

 /** * It sets ID to 1 when matching exclusive store transaction has been received */ 
 protected bit matching_excl_store_id[*];

 /** Indicate phase between a successful Exclusive Store response and its corresponding RACK
   * during which period another master can't start a new exclusive sequence
   */
 protected bit successful_exclusive_store_ack_pending = 0;

 /** Tracks in-progress exclusive store transactions yet to receive ACK for specific cacheline */
 protected bit successful_exclusive_store_ack_pending_for_cl[*];

 /** Semaphore that controls access of exclusive_load_queue during read
  * operation. */
 semaphore exclusive_access_sema;

 /** Semaphore that controls access of exclusive_load_queue during write
  * operation. */
 //protected semaphore exclusive_write_sema;
  
 /** Timer used to track exclusive write transaction followed by exclusive read */
 //svt_timer excl_read_write_timer[*];

 event sys_xact_assoc_snoop_update_done[svt_axi_system_transaction];

 protected bit no_exclusive_sequence_started = 1;

 /** specifies the type of exclusive monitor i.e.
   * Exclusive Monitor at PoS of Interconnect or inside Master
   */
 string monitor_type = "pos_monitor";
 bit    part_id = 0;
 bit    part_addr = 0;
 bit    secure_mon = 0;


  `ifdef SVT_UVM_TECHNOLOGY
    uvm_report_object reporter;
  `elsif SVT_OVM_TECHNOLOGY
    ovm_report_object reporter;
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename( svt_axi_exclusive_monitor )
  `endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log log = new("svt_axi_exclusive_monitor", "class" );
  `endif


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YOwYZUnB13ZC8QLRaIaCxZw29CU4qRxS7PiCr0E9SzlERCjpz1ORdMaXCavS8ypd
T47JIV+bS5kIhFrI72ij/LWGt3HEg5JKF74Iq2MA7HqAPLv3h7URyDZ4ZggFj2nI
r+C05zQKF+gcxWYFcjYfZAO4QErWXfDx8+t6Os1YEfW458IBEAPh5Q==
//pragma protect end_key_block
//pragma protect digest_block
Ih+UQdz6r8anKsn4zZIQl6RS+1g=
//pragma protect end_digest_block
//pragma protect data_block
+MVtAhHv8papIlWyI9v7IXzNs2WimEFZd3COXGmmCl7WMc+hIttKUPOqqTv1hmQF
5qBD/LGJQ8wiP1kFi0OxOC6NH6IGh7BucFjqYWAtcfc3QwdA7hD2GVMuWDKLUPGO
S/e3dlEnGFaGHu128A+hhG78OjcOfA9yTQilmamU5dEIzS+0tW3c8NwiDBT2QAU6
HdON5kgkdzTjR9nS/TsH3U3s/kqleKtd5t5w6SteBE7uujVUcYuLp528RRAksCsC
/O8BSDT9YNo6B6i/uqyIuEYxzqem5W1Gb5OJ4Z9FdVrTg/Iuw39g7zn2v+3tE20P
trrn+InVDSXNnx0QaJeO965b+ooVSgw03SsiM4ud2XpxyaINhxBkfcm7jjaJMw7y
UgW9lQK+Y6fqroKF1zJGVQ4Xp8okrzomWH77/TU0vnuIf1aAh3nJiXLabKs61OsN
0cAFRd3kVcyzhPs6qq7yvfdk1auwdohHEtdmjWNvoH8U5uk3ggr3/F4KwT45vy5q
h7ObAZ1LrR7z+vzuB4R9p2DrpxL22/XWA4440j8rhyoTXZ5gVWnW9cdFDvPL8FJe
S6c8Gn1tDKeAfqzuZguhmuCeEhK3vO61WaHVUlzcdxwRPGUXF8ALyzoqunXlofqe
TEM96zlCrMjfxdjeeJgneTP3xRAZgW569jOIM+/D4U75X4jmPMDXtqrPkxCmg2D6
i9GexJ1nn+03sPFmLTpC7WOilzHVKxSq3HUa3y9/NWqUrxITavZcZpPrVoRRfdm+
k3qO9PH9GUmIeUGwZDwzF90QiAvHnpAEPyxTF9UDauGR3S2xLrvNINeh9SHVD8JN
5LbYfKfxv037WTBfi9Sx1V/i7hlZt6dV7RQbOeqJ+Ax+MceCcRFZn2KSGVsL2d7A
e6iVsCEkoUyVQyV9DdOLBXrDdGL5fVRIopf5Au0MLUWSZlTfQU+1uekQlklVfxgN
teD/xCTjvkZKcr3M3Lt6tET3kjaOpn4i0lixPbgBZ2bAiuo49lB7xDaahmiShcUQ
JXkkN42/Qra+sBw4ZF+cwIk01NEzhOx1XEUWuKu1l7ROeR/e7FxpRJ1y2GTv8xW9
BfnxiM9ACNNaR+NXPHt+YpeffkPwkcZGDL6ksmuXXGherkR3YGN+L9/ovhCvZbr5
pDiLYMjH3LE9WaSBlhL3m7W8oo9zTBGDb0a4fiuwerdyjDIEYB2g90OvPX5pLumq
ytIhKKRUo+VEiy0yt77Dcaquwh5Sz8gWUHPIjTyrnPaRkfex+0zo2DeIuR2psVUF
cpylT+rmbaDQCZutP5jRobd4UnBjT+SFR0SzkpmMWow2jZUqlPvhnr/F0fRUAsq7
rv7iBRqb37uu3sBBhf1ceEhBiVLZw4M2pUk6lqbdv7Mi9Rhr5bts5jkNgJakDitk
t0dgPEQR2pS2QD/4EaFdeWTTdCLzoBWzvV6itgOJyaoxgqiu/cKa6NJMrl2ZqLCq
zUCy1jLCWoGDWHu9K3hl8zx0UP2DYPBlxhOYXoN8JZRqJ8LcMwClmKoHGCPfYv4D
cJeOD78prATy0dIwGU+ia3JlcdSlUUnEUD1Cx95mVeVuc0h6M/i6kudJWY8Fyse8
Q/CSUJcVKOsNcUk0YdL4+FkJo+9bVWTZMdQ9WPxPZHOC78N0XgYMl3cEzMxYnd/s
fmIpBVmDT0LSdfa6CUUraA3x3iTvDq5/7kPfb5Plu6P97xbxAuljUp6T0MYdsQKC
CF5Llencr7DxcfqjckBYiSFdxR8+iSYdh1mZ+kzdKGf+KTMLZlEbphKufkOUBa9a
WD8TJk9j/IeRmkE3RtrNQqlRpKzRSzHAajZOQ1JS9x5JXIH7LG9U6PoXu0Ml1yd7
yS31DVP0BGkbdk/exQeSTRPOhEfmt27HyU+V4M+PMVrGva33OmDSe47Rn485d2VJ
hlditqHY0w/hqS1/18Z2PIDOfIVR6hZtTQQgpdr6WAbo5QUkgsqdkbL04aWPG/Nm
OjCgBbSA2SlBottcXdi5/ZXfl1+qIcgqoD3eLZciUDvwBz6nWjveCGxn1UPT7HbL
I94oQO9UOWlS5UtNGQJr/Hir+esVmXxCTXGiqloyu2IsvpyFYaPl71uj1oczBTPa
T6bKKPM73ihTN5g9jXVYpHiQ/1doMqnJO4j0XduPNO72AfGlCSGS1LDo2PRt0kbB
2EfgvEcXE0+stZ47VWhM09bQKKZlbjgSvlscefX3Lnb9RN/A/J6kPYgFDwrtnjAb
DZlTX3bDqseJ6HJ7d7bUMByrggxUvw77GktBfEmnTPMmq55viMIdcP9lNFAQrIhU
h5jKg4g7LlnB64qCwOSKa5nCge8x+iPPGWvZP/BRete6LVEWI3W2f0t1XMCTAEPT
JbdXain/ucb6Nc3BNJNcQoPEc3/nWk14OAxxietN4kB7avWwZfXYPS7h/3zztGVu
06/vXW+C3S8U/CzkptLHoQ==
//pragma protect end_data_block
//pragma protect digest_block
tU0TaJ3CLdaRGDru+EkprHwV3Jo=
//pragma protect end_digest_block
//pragma protect end_protected

 

  // -----------------------------------------------------------------------------
  //                                EXCLUSIVE PROCESSING BEGIN
  // -----------------------------------------------------------------------------

  /** returns a single unique number from xact ID and ADDRESS */
  extern function bit[(`SVT_AXI_MAX_ADDR_WIDTH + `SVT_AXI_MAX_ID_WIDTH - 1) : 0] get_uniq_num_from_id_addr(svt_axi_transaction xact);

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Xuya3SAhrbs6sFg2P+K8HQ9vODqa0vkYibqQgzTVINZuke6vo/J9CQbltrsuOFG+
YFZqlCDikj/AYvpXBKL5LQ5RTussdZXld41D3tbrt/4PK9XMnjoLOyT5Ckqh6lYy
pO1DFjuBq/pSjxG2T/IM5G0VSuWJhtuFOVhIR7De3wc0xqg/y6sAjQ==
//pragma protect end_key_block
//pragma protect digest_block
djdJXeFlDfSdQHRnRPFFX8cxN1o=
//pragma protect end_digest_block
//pragma protect data_block
AF7OyVXqiwC5qLnE/eVu3f307sWsY3sJmLG0yXGGpuxiPY/g+/Gxu6y4yAYGgt/e
nuuyHlc3A5A9UTEnA+9T5OZSx8Ulx+Ir/ohRB9QTRpngQ/vCwmkDEYU0HboJ8Bs1
lJQ4QpuBD6fOZN4I45tqZg842m3nKenl9ODrUq79HWoFmg2750am8fu9vtvZP5m8
UiudmuB0Btfr27PzJsW7Nj9XN0tJHwwymZIzwOd8EFIRTZhyOI1wx9HVdurEP1Mg
nff5S9T2kz1KgEiPVtp/cAcNwEC1lBfm/Q1IZi4UxZizqD1EBcj+FoyalC+Mvf+d
wZ9rd/gmx+D8FfFjvAtMMzTyT7JRxtfd/Cxqayn+EWF3VbctTXj5JWd1VHEb+cO6
4vucuLuc2e9yGIee89CWgKZtMoLQ97AoFN2ZkkJwJw8Olk9LGWTSsWgh/crf5G+T
nBEAmGto3a7xaYtlHlwCUQg3yGIRRaFhsKnNWD+kGGkQPv+W4rP9v9KQtru9FGtw
HhG5BF2DG+0csvDTTSjbldbgLnI2UlBoalZNF7kqdX2lzcpSn7j/zqZoYvcIBRc8
ahVOLaxdDuevoeizJWgw3on9SDMHOrRRzkjzYMJiYQSAxBSKJwBxNdFSweNmatj6
4j794756kVh2X9JBV/TuQ81hqParzcSYVbiowC7PuPC+tEWMssuwVryKmTEqR2Ax
MNEmzm7nAcueDY+xNc3pkvXTvwZe4CuOU5k7MDMNrURLex7xqsugqH4Zs2tjkMlj
h7U1Fe6vHnyoytHhZhTMW0gRvmk1OcGoGBEIz6BN2duLMxfM1wyOUzRmN2hLA+oK
WZD8n5zlNDttJb5KGnBAXc60aA4InoE7d0L5JClbx83VMTupAy2Hy17g8ytFtIwC
ZpRZo5OwMbu75SdlQR99K57yVJadmsgr1YHtbI+8yfA=
//pragma protect end_data_block
//pragma protect digest_block
fJYj524naXEpI4OtJ09e5pEYG7k=
//pragma protect end_digest_block
//pragma protect end_protected


  /** It checks the transaction with the same ID stored in the queue */
  extern virtual function void check_exclusive_sameid(svt_axi_transaction xact);

    /** Pushes the transaction into exclusive load queue after all the data beats
    * of exclusive load transaction is received
    */
  extern virtual task push_exclusive_load_transactions(svt_axi_transaction xact, string kind="", svt_axi_system_transaction sys_xact=null);

  /** function that compares the expected and configured RRESP for exclusive
   * load transactions */
  extern virtual function void perform_exclusive_load_resp_checks(svt_axi_transaction excl_resp_xact, string kind="");
  extern virtual function void perform_exclusive_store_resp_checks(svt_axi_transaction excl_resp_xact, string kind="");

  /** It returns 1 if transaction with AWID = ARID exist in the exclusive_load_queue queue */
  extern virtual function bit get_exclusive_load_index(input logic [`SVT_AXI_MAX_ID_WIDTH - 1 : 0] axid, 
                                                       logic [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                                       bit secure,
                                                       output int ex_rd_idx);
  

  /** It monitors memory location for exclusive access */
  extern virtual function void check_exclusive_memory(svt_axi_transaction current_xact, bit is_snoop_xact = 0);
  
  /** It monitors the response for exclusive store transaction */
  extern virtual function bit process_exclusive_store_response(svt_axi_transaction excl_resp_xact, input bit excl_store_error, string kind="", svt_axi_system_transaction sys_xact=null, bit only_check_excl_status=0);

  extern virtual task process_exclusive_load_response(svt_axi_transaction excl_resp_xact, input bit excl_load_error, string kind="", svt_axi_system_transaction sys_xact=null);

  extern virtual task check_exclusive_snoop_overlap(svt_axi_snoop_transaction snoop_xact);

  /** 
    * Checks if Exclusive Address Monitor Set for Exclusive Store transaction,
    * that is, CleanUnique Transaction.  It returns 1 if it detects Exclusive
    * Monitor is not set, that is, received Exclusive Store Failed.
    */
  extern virtual function bit is_exclusive_store_failed(svt_axi_transaction xact, svt_axi_system_transaction sys_xact);

  /**
    * Checks if an incoming Load or Store Transactions (Coherent/Non-Coherent)
    * maintains memory attribute of all currently active exclusive transactions 
    * for a specific address. 
    * Attributes that it checks are - Shareablity AxDOMAIN, Cacheability AxCACHE
    * This means if a location that is currently monitored for exclusive sequence
    * then all other transactions to this location from all masters should match
    * the Shareability and Cacheability attributes that have been already set for
    * that location.
    *
    */
  extern virtual task check_exclusive_sw_protocol_error(svt_axi_transaction xact, bit shareability_mismatch=0, bit cacheability_mismatch=0, bit use_semaphore=1);

  /**
    * Updates pending ack status flag for current transaction. Once called it sets
    * successful_exclusive_store_ack_pending flag high and wait for RACK/WACK to be
    * asserted by the same master. Once acknowledged i.e. RACK or WACK is asserted
    * then it resets the flag and returns.
    * Typically this method will be called after receiving response in order to mark
    * the phase between response and acknowledgement.
    */
  extern virtual task update_exclusive_store_ack_status(svt_axi_transaction xact, string kind="");

  /** resets flag no_exclusive_sequence_started to 0 indicating that at least one master has started exclusive sequence.
      any interconnect model or system_monitor should call this task for all exclusive monitor when it observes any one
      master has started exclusive sequence.
    */
  extern virtual task reset_no_exclusive_sequence_started(int mode = 0);

  /** returns current value of no_exclusive_sequence_started flag that indicates at least one master has started exclusive sequence */
  extern virtual function bit get_no_exclusive_sequence_started(int mode = 0);

  /** sets value to exclusive access flag */
  extern virtual function void set_pending_successful_exclusive_store_ack(bit[`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] addr, bit val);

  /** gets value of exclusive access flag */
  extern virtual function bit get_pending_successful_exclusive_store_ack(bit[`SVT_AXI_MAX_ADDR_WIDTH - 1 : 0] addr);
  // -----------------------------------------------------------------------------

endclass // svt_axi_exclusive_monitor



/**
  * Checks if an incoming Read or Write Transactions (Coherent/Non-Coherent)
  * maintains memory attribute of all currently active exclusive transactions 
  * for a specific address. 
  * Attributes that it checks are - Shareablity AxDOMAIN, Cacheability AxCACHE
  * This means if a location that is currently monitored for exclusive sequence
  * then all other transactions to this location from all masters should match
  * the Shareability and Cacheability attributes that have been already set for
  * that location.
  *
  */
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
LV+KL1BuUT0HrmUyBEXfdFXXKX9j6+dWLWr47w27IeMIvsp8l19exJvSvwjy8CgG
crq7qwY1T8YMoeNmu7AY9yd/mDkNDoMx/eK7YqDBktFkKo7yHj/mUnrpiMZ2UtT0
Ux9a0r1BzqOqwwqnli3ONKqVXdgDNIQMEQe1n59abTTnbwt6hkuB1A==
//pragma protect end_key_block
//pragma protect digest_block
UekLBEHUgACXCluEXpsSz+P0toQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
LXacKEGaurovIPfcIdbV8wm+u8M=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+F6mGa+s+bA7m6wZg5MEEft7cv371Rl1EP17ldQ0G2fs3ltdTFs3QLtwDrf9fKDi
ouJN81d1MtvBKC6OWc0AYtEXm01d6NTYXpJ2T2UEPUWXVv16bqaP2+6tWJPLJQbL
RxoDJvKEHMg5RnPfKd/Wu5DuYNKudIBUkbj3AzI1WWPVDoKd9QklEw==
//pragma protect end_key_block
//pragma protect digest_block
FzqI9k1YQEH3WBznyZx5xyhTGrE=
//pragma protect end_digest_block
//pragma protect data_block
lhYBLo+wveXsHvLhmwMeX2O24j9qJ2gNe+czHlHIU2lNtu/FfkJBHRv5sEOgDA0h
RdrZ/WOdgjEnYRW7NDniZJVT0jfXlAGFKaemrPYHzDo02/CxKF2rjjWDa3WSOG04
ITPqXeOzOmC2/oHpo3Ev56FSOvyMtdfFY8+qloXcVPcTHuIigmX3UL4MuvtMpIFY
/klg3kumbu1ADp/bvV1yE5LtrcFdzhMBlinYdfv4m/uqiLNa0kgUIGseN+6XwZ0v
1Mfxrnd1FAag+fHlImJbxMBzpmnZA0ftAwfG+WcXHqk9Zb9VgPMyCOLh8ZrRoSLJ
3SqbDP8AQhHGXor5lkY5s3sAtwVHHIqn5RxAxDNmo50c1g09X5LrLXyCPV6sWLf1
ii8ij96s7Qd44aY29hHHJDkePtasaDywZJkPStXVZoWF+ufdZ49SvlUuOd33/3h9
q/eZyq6b722QY6CWRNttKmAhst+dnCQN6zl/tx436mnqe5Jz/w2D5BOiHzE+FEgL
yG8/yL/YE1xlVs6TXKKXDlyupzY6xGPtuJ23CcHVcZaXvr1yRHEyqCulXyGnmtjb
XdmRf7UrFbfdxZRngmmaTQz/PSjI9OCR38uLL11QYhXt1HMV49uWkSvURyAT6r83
ud/fNiZbbT02o6hZjDob0JzTNp742Rnkm0kTG1OPSg+zptfK5R2psG6BIzKXb2Ki

//pragma protect end_data_block
//pragma protect digest_block
1W6Z5HMKnEv2824F7aPyZa0qEi8=
//pragma protect end_digest_block
//pragma protect end_protected
                   //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CpV9RrZjZrvYqBZM9FJxJttlVjeqgZC3wayCIxiRWRZkxTly4v7xHeO1aGExafnw
h5I5zS8yihHsJ67N2i1pR5LwvD7uKeu/lSy+ol+vmJp5t6uBcfZ3YfbRqHpPhPiq
4xJ+Rp3wUSe2D2bPPBtBxkiFqU8jBtlGXpoC4c2bcsw37Gn9gH9gzQ==
//pragma protect end_key_block
//pragma protect digest_block
Tcmrw1xShJh6E6iQjkkiNcLv9wg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
aLUUKKda/o8FIbDOSwwgJf/IPQw=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IQ2zyQM7UXYFOQU84GURcp9ySOxBZarBknC3RrSAYWi+E74Rys2Ztd3pFgAJ08Y9
w6bLxZCLoThn2w7UU3TAFA8LnBrU8Dn1fcYrcfC3vOPeQPGfGd43bWhfNQrVzxLK
M8dQSw+bWqVPmHBPuYnE/mKyZH/0XGspnB+mTpovcDijkcjfTbcApg==
//pragma protect end_key_block
//pragma protect digest_block
jgCvDennpt2DnFDuZ+athistjBw=
//pragma protect end_digest_block
//pragma protect data_block
74ktNbXH/ViHr4SKK7CCN+V9Tcl15UZ4guvCVrjuEjgaP8zWt+QjVqQ6QbLS0YoM
Mh+f7ohW6unHGDqkhuwiY8kdBftBK44lCYllIplXLqc+bZF+Om85RYw5IXJ3vW2e
YUzFU1g761BxxCUshIPza02Hnzf5itekzgxToqF7imZwcbjsg7S+pday2JVZwk78
G/jjMBGTXuE0SikMGZUsUq1jb90io+tXyuW+mDaqv0dzronsAM1N7McVRAwpHU0Y
dupA4O71Jv4fllxIHFKUv3i6RRTKFOai/qSqzRVwzUmH6ThzZOStBkuzNdxddrzk
IJwE8oe36FqoaaLuTB2Eb3lz7jz2y21mDPVvOMEVLD4syjWUxQSzVAnXMgo98YZO
Q4ScCsE9fMn3lnI+pzWQX/0D1wEv6pIJH4wiFW7AA+YUGFIldfBcxKyX0VeEb8Rw
j9ro7UFybk4BxCi+FCdG99KuTjyURg6gDfNSjriwzf738LMIz6YodkTIiStQdRe3
rwM/tuywGe3sskBFyV0s903vEF4RLQDeAA8PY4CIPqbJzpA1kh6dmFXhkinqkQLk
ll/Rn0gi4Vu7ZN0bB3B2uOl9biQ4tcmHOwVl5VMAtKB0RIzezgJFiXvuDl6ssCJf
uaqquPWaQkqcAg/IEy5zgBS8NJBLZBBAgKyGLk9P8VEC+GIJ7pR1kaaSC8LfPXdj
7yycPYYQngv8/G9DjIVXIUSumCcvkgqzmG9kVF2dd1E9SpAHjpanwLhf+dq7cAAh
aj0FIErILwBI+TcMuhoZzS2SGPWxz9hzC4roll7L3bazLxqbJJZpJKWIsNM+OE5G
ziAeOrlxXTPfW+VE3dCgnKDRMDC57XG1PzU1O9Hf8+LaQ1u6O12tH12woIDaywpY
irowXIubBQ2aZHTZOhHtc7I+byYzSlSDFHzEWKRxWc6EqmIAScA9mEZjZc+oVpx0
45OkeeFCiB3wR9fVIvcmNhVjCEFFCTbpiEKr5vov5AXePf5oCD/zT5LH34lc6z2h
zafdNApHD29V41+PEvKBNWiCJAUNReluo8mTdUKZYWh8ocPznu48IBeg2Q11WJgE
fQ10gaG7DuaDkhYDu93ryfJZrefHjUXbb86wlIZJ6AQ=
//pragma protect end_data_block
//pragma protect digest_block
N9aoInrrTHe/vUJe82WmVaANVoo=
//pragma protect end_digest_block
//pragma protect end_protected
       //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XZ9kbpjOaLKiAVoDshR/yszeFsXOAgYiAx1OiSK2WJI4+BUkrEMuXY7JZLEUL5EN
pP4oq/zB1TFoNe6dk8snZWrsANz6aoBfOnPJOOreF9vgSKG6NSdp+jMnh4B9ug3Z
JiiJx3a1gApV9xa+dDDCdWPhhGxus/kJkaSDJ/fEg3/rkaeLcoEPQg==
//pragma protect end_key_block
//pragma protect digest_block
GxvBz1ZhBAl7Auzri/iCyCVHYa0=
//pragma protect end_digest_block
//pragma protect data_block
68hQZQlKL6/EQfLKz/bc9DIVs0PNfzMTnGOt2XJogdlZTIGzsU8+ueZxPSoLKzUz
1Z1440J6s67i/oOYvzu6I/HoxdZcYmfzsvd1idufhBuA1Br1DjB+SM1rsRzxY2rq
QgUL70NLon3Wy4yYTARswKL0XOEDDd3S8H6orYNTcgu7oMgGxj1WDw8wUd19SQzW
qZyzntzWQAb7YrRzh/QQphQNhx6SEz/nv9XWN8MAB37OsSJnNtIf6qQ48TXyS8Tl
ojAnNhDBXdSdd6Cr4yx2CANgx9puowhQojhGM8jTrF8DXC09YGqe7GHPA11urwH1
bRvkD4ZoTefS7dy0AQFF81f5ybJp6eHkE/walSMU1LidmMhAkrtbCf/YnJe+p6ID
3E3o/TT0IW9cyEUsQKYCyOO7iyGSYBMc+RPfngz0kVtGuGti2qqADq4TNYuHpgsP
vOIkkPMcoTk8DlsJ5zfbmYA3m7Tlinlm3E/v8muFBb0PaeWVDiR5sYB3iCQ3uICp
ScTGgpR1i/CXyZ2tlDIKO/BB8L1OePUd0bOE6+pZll7h8JVcI1t6wfZH6cnlWElj
7ZqN8xJJNRj9t+8JtfJweNdjsvrS/Ma4e3r1fl5Y5XdJEgh1cEoYFS1p1rz2reXq
IefEMO4gs4YaD8uWBXV/4xeQETKmIeIEZuuMR24k+ds1DduMTmyyR0est9vhiCJt
ocOhDh91Oe7EDTVqH6CT21XMREZD1NiZhQQaSL8B1qnvVM/LBTwM64yAJSEMJXOJ
8tZ0TUcrsSTklk1Az3am5FqleligiNlaGqw9nmsqx56xC3lyBMBYCmmP4st6AjhS
/Vwwg+u/JRMyuKeIctIY1vHtdlNuHC8Dy6jyCdx3tZ55iQzdWDu+YpbBxod2mUa6
A1zJ5btRRweLLs5cPPk21C6ygtPg8g0JgKExPPDfY22W69ynCIx3T8anwzPDwgwU
V1x0gfQZnLCnoPr2wI4mNrSRYvoI7Zloy297/2tIxYq6fCauFTB/V7gre/dDUSif
2GWe06dOUV6IJFK1o3EjU2ituqauKMLHbTEWmIZM/bnvQT/gXr2qve+0HfWHaFXn
Jp9l4HvMqlH2VZ9jlDtsrILiWp2aCpFyuSdwNFYdDOOb8q6LSbDP1lPJvEk4rtPd
JxHgLBqpNNhtkX5KlSH3Xap38XCuE7qORjN2b3Jf5H3iSsS130hQTXibPkr3fomc
UxezaQvmYIutIsLqsIxFYpa/sutRdR0o+emWXAMCC9rWFgemnu4sLtl/ygl/Gkxs
BA+zK21WADefeR7Nvm92tlr752I6O8lokUrlbOv/l1ii2kSlJX9Wcr8XYsFjV+on
gM7z2QTj/3cKLEE26K3b2LpUrAzvtth0GSgsgHI96/zfYCrqFZfZSEWgIMAMUDST
8UU4LYRr0TH7+Tqc4cn6Mji3qNFvjCcmqQ2YNLjvUrKnFv0CFzhgH66dDHfhj1MR
zYmrrK4Tl4S16SvjlTY2xfHuvN8Tkqf0lbpZ3/gDAqVxRlTdngYZNIMXSeucn4L2
b/QzyKdqsloktd9meuMXl7lM0QeyF07/ShuNp734D2zDPDZ9oGoF+BEBb6iqkiXx
IdEuDfVzJFtLwLhREeeXtAHwSxER67mAzIpHNb0IPreZh3h+Xu/3nyFzYDlz7kRO
u9Ld+uvx3n6UPbzTMEuPswcCjjCO2Ev3HUZiE4SvbBweqx1s/e3i/Ju3zE8lvS6t
YyR1eH6CIJIRmHdT+pCgCrIq+WLVchKbmm542WXM1GHQtTgjPhJqZrbGQiPIYFix
iEpy0IjyJ4WhdfB7rW4meqtwtVt/N8LzD4oFpjE8cZ++/wWpjOdBZ5kV289nKuG/
rrnb5luzbSo/qcaNKuEnX+UnVDSg5ElzbgKLP+ZPuZkDhETuiDlCuXalYK2YXpxN
jkwkovF9uNSlWlqoaTTFTlceUrCCIqPVom03UFdicKcceFGqJ0CBfKjF9QmLu0uB
O40VGMxgwXstDDjf/FukPauIGDynrYzqTcaO1BBHd5j/XLUmfpI9U7INyCtpXkv9
zjfpfWROa4jr6KQuzrHfSmUt/aQ8ezWp0mnJyOw2ZWQ+6sT3zPaQRiHqDX2trNEO
eEHMVNovqbpWqdKh6vp3msV5Xgl3CCO9akPsdvBqdM6zmUFdzsR6geqAxFub6gEq
PfE0w+HFYp8v0TiEe3nUNXTdcGIej6BsktMRjgSqXgEQJSzBP2AyyU+BUjyuJLoz
VmG5n4sK7Gk7ydUDVUlVQeDj9F9Y8bniqQ2EKwXFYBjFk4/22O2J2Yst6vFUDf9x
dmMAK5HKn+8TqehV7cwsV+7OvkNDPuVKq8UqMs9Vyor7fiHfrEn8qokHqCiQIYue
3UmE2qAnnzAut37+TzYjNBsTWDzeSPMqqTY0ORGRxgOkMfa0u8/sbtKbsMUEyn0t
8NV8YYxWbU7yNCK+Mmtk29jCxxWYvGIw6Z30wX8WT/P2jTi3ssyQtWHA6uqTZBIJ
pfMQRv/M8zqAEvT6YqJDUE8lcPf/yJyA18HGeddc5G7ITABdhBbNcLltymDnZv6L
BFKk5VNvWHAS8TRYk79nH6K6lhukAS1PNJxcCBK0EHSvdEkh3Es0juMpsuaR169o
q5+NTRL99WoT6rihr4ht0rXZGj9nunzYpqZ6nBscTyk5hkHfhwZ2naMEm5rfNhAA
j05Tw4lmSxE3ySKCVVm7UoWUiG/ZjVAryXmauxaLNdmKNv6+m38nnkGoTG08cjys
FuoaAo+qI6Rsc9dgONJHYMzl/oPKmfQOEpaJso+9z9srwcM1hPGINYPmD5XDMXIM
3LMnwh1JfOLxQQCbu2eWjKoTDgO4cCoA/dXYmazIC1ztSPa6AvDLsNg+Iw2aLF2B
EvWEHExf9Ns1no+yhU9rGdIJFQSBioDgqRi0kON1rXTEOO1bPfS59NsthYUWzfd0
QGnlUgSRr8nuXUlfl8hhU1Rnf3BEamXp/xPBMJz/OwIf8HUPs/aPLOBQjOzwvM4+
jEmJnMIv9EsSIt4mbIbuTMQlSgYFUikSpA8QRe8CAsdQx0PoM01v5dJmF91rplrB
daSCtGX2S93UoNC3FQDOXOVOMCdLbWPQYGWfPAC1SBtNtina4ZvcePc2fDcRmxze
F9YCWxyFycMsHRTQ4YlbFw3WFi0umcFc/lH+O6G5oqMBxs6YmQ70vLHDguuJsDpX
HNLXulFZn+BjknMyIH3GPKgXBjK7vbD1at5g63pqIHdUd3VDdRZdWtHoqTIEoGFM
QTqrmfQXoWI6t8mGUBlWjwcQfprbeUVWO0m/7W/jFoNE2H2/xZPojXq9/Y/AxAcJ
KlBSZtjcb9AmYIr67nTf3Am0U+Tgti2ygkeEBgQGNURRH+Acc1b0s2PzkviEoLHn
z4E82bWH9QZMizXuQF/2isTj3NAzDYkOCEfV7nx4UsIG+7iIkRWbsCD9u2/HcGCD
aAayQew/iHo5AzEiCPPaGacaTB80eEe9WtOYTldkaEN4ZnjUSZ+Q3CPxP1txKNja
1Mp+n2nd9bZmd1BlMTxpDMPk0YbjYXUG5K40I1Nn4wTzYaViYO/Z5koOGxpxXipU
goJno3W4xu9uxlqYvbu6/1xaH4yvhTRxLLvGGPL35zGImNYkxmtmk2BibVX3Q9yy
BwasNW+o0MbNNRTHttU7Kj0QK2/MECqiZPB13uXA4aaUgEtVHx1HX5xFoy1EUy/f
tpyMMAs3Ja2CMRefbBWAXQVtNXnxXlnKsIgiqRgNuiJG6R1YNuMQlLXqbFbpw0wG
6TP6LOgaetZr1uGAKoxT62bgtEUTlQkmvVu0tzk0Tba/JH0viwe1cCsCcCtZrtJl
ddLV64EzpffbWhh5fRtqWXwy+c7FRF1tBAXWiHz2swtbhDaUAZ2DuHDEf/wk93D2
fJi2O5wx0WM+9CUF2WGv5smB6l8i0dufvVwMveoIafXFhFUbq1ItR0gslfhhwVHN
v6dWGX6sJZy4Ot0NW5uR8HPIwrZyQA+n6VBLXc1Pl400xf2wAtjnB8QyN7NA/uWj
jy7PNTKO2JnUEryABUyeJNxSbd+UX+GtOiZV8D7OOFKgkcjUpELmly0nhUwctNCx
3chjZ7jyZdYR/NlOkb1N81XBoHq9B4E8lKjebLFOP+3/sxac0VESGyumIdhsWc0e
mzlAMfeM2KqAo5S09fh2GUgq7KIBEcrxJeXBt4EIVJFFLYwMja2CxPjKBGe1u72l
R/0dkkiL/JR5LHg/QMUFvUua5guQe1Fp3yCNxMtghvTYzOts/YOop6pTIBhopP5Z
vvWG3cVt1cdnSudX86ReTXXw43rdCzFX1Kpj3N80st2bbPDrICVBugEQG3LjGnAI
54/mIjKiKPwzSDONwh0NhATWlD3Wkd/E7vijuRZZwAeZHpl3N19MN/6FWsBrmnz0
eGHZjTqFnRaGIkd3xZweo7QLdouGxs6t2dQ/9qcVQO7KmQ6SgBhlLsqnKczQm84e
IR/Pg1zWCETAdfuTwj872ElOvGS2sOEimhn2Pa36RJa8fjJ3PmqGt41UO4Oc0d6t
lw7mLOO51NwzwerFYTqLMADM0umaPjVWGPlcUCbTfugSyJV01jTq6JtiWJ2oOegD
IsVqcDSNV7TiRV9wtF+wOY62qT1CAqqFv2MQFb8kEE18Nmctm10TArVn9n39vBP4
D37mzOouej6ZVus9fwo5snsxrxAEp2f2zX0rD8idLfM2gr5XRoW+LonTr4dgXs+h
KU6nsrDNa8Mo5KMKcFFVoyBy1whsf0U9dMMWw2ditU1nWGy20/i6vHTFxQEoQhzt
83J6XjajAEzr1xpB3PEAfCcjAxhoJ/fQDYloc5gW+abrbPCSLPGVz3BsrvfxNnGW
vaozADY8wzKhxS5yq60ATukVDnA55xPwuLiOvOInLpo6hOZTCSJKAJw9zXeY0Nxb
EPwRGHTeH1vPwY2pQujP5rzZIa27hI7nMTCZrfht/yDTZtHlwSRWSIoxgPG14AP4
f7E91qqsWOKrie/b8W6ofBbtoy10HYpxe7sUmfCLCBFKkL+a/Gh7zaFq0a54iPIq
h0Pj1dSZAbg5iuCPu+8fWSp52q5ULiAZvBqU+xngPwIvW3rg/Oe+sXgu3kFN7f1+
NYOYLknSl3gB4tnClA5AdqGwK1ZJnPTtTv0PVpzgiN/Fk+gnOFAvSFF6smobMk6a
21mNX9guUjnNorQVNnZT+RDy2BsRvy6K4UvRRrg4g5VLwz0X/1jmlKiK97a/Bz3p
OXszMj8ckhsYrtDbaAEDStpGuk5lkYUVzdBjmaJVB63JgEa1Uy/o4QWdiuFBaNw4
S5DisPA3ahJsj75AbZ8YXtOTH9a4FHqlB5cG0sbYcYfwYUYAXQiCxyDUkGxCsvzm
7k+eYriDV3FL1lBF1rDk+LLn3mFPUhXdNw1AmZJZa7d3phYXZjOBveXgB6a2VBkA
TW7P7lmoHmSwuWc5Ss1pX3YZNAE+qR3obMntPCGBUs1CFRiwgjZ7FiccB9KI6dTv
5DvIORJLZD+rsDCdhyQHNIgVQv9BTc10ffc6VnHYu3KMseA2rsf99WU0k7bYplfp
sBc+/10XRwbeyZlzcWinS2rJcIIfr+XWiQRiXzVd7Q5cheX/8SFHzyYWKhbsato/
40/bf+VtU08ZU0U23tzJHpetQ2W5KZ2ppqFXmykY/8uv/9QupNUHWWXsXvtTq/Fh
bkb9WgYmeBycjKPk/SVCHlvZSlpRevBHg69Gp4NhYCjX4qnTnEy/+e+WK190G7sC
x4By2BN/t49WYkpgBsJDxhY66PFhXPU2qOFqJx3ulYZGeSpjcdslqgsnKf+Ti6dw
/cIcEbiS0Licm/ysBreI8Jss4SGWm/SWHfvbzGKjaQ6TiHh9u9/Vo1pzk+IQV8N7
TBS4/AVXKOiXVKfZO9FxtxITnSkqNhcH0ROg6s1NEDIjD1m3InA5Nv3lyFUbwJdB
d7Epe53Co5QiXHO/m6Nh+bA9x+egK8Pw2r32ZVcCJonTAVcscYDzwcMkcuiqD4Tr
bFwt14aC9cb6JXjg7fRarBan6UOgkG5A3TM5kM1RZZWhAhoCdJX3RdnjO4y5p20V
yC9yhjm8e2gyqtvAmFad2+rDw2UMOrVQZCSkTQAfMId7KrvFZXvrVLFkORTqaz01
UiOKvl9UYXuaJ1mh711IoOm7FlXzZDnuh3w0Qy7IHe2Un0RK5JIMvfpC0rLUYb2E
TXrpSClADWxn8wh1onGtA4/BZFO9chlZMEH7/I3vy1fKIse+IVOG8P2M4D3UacnN
7Wu4QptUMbue+SwP08ld1cZPalmwhsp9ZtKNYhwHo+5F3UG7LDaOuQ7hmUEhCM0p
2iEHOArOusqgkHpBpNyDERTb61pCIQpj4cU+MpctUT2fkFnnrkegVy1JxJ7LFXw6
g+iNfHn1zR1zL+12XysGMqu/OENxsvpvpUdOc+vm6tIzz/1y47U5bWoiqlYltfIV
Ilx15oPfhA2sY+IqsRD1EqcF1sDS6feV2Evqx+ArkWd6jZxNwafas8dJxhTykK9G
U+8PfwctQwXOc48yoSl1Ph6NOcYCjrYmKXT9FHXVipk4AMKOkbPC4nklmZwjXR9c
kFvZ94Aj67gPIotqVPd/tqk6YCRXT9llacMJ1B7HzthmmyJ19+1Z1DxCiILabVy3
Ss87H/dMP17oji6RaOqSsZ9SByRHOgU9A7zpPY2X+96jSgGqbC+HIkICfvpQdMwM
5IN3CaM4a4XV4ImqVMyVPs7TFLwdUGrCszmYS4W4bsRgFXuYMasvB0zXYDmm+RdK
kYDtNtJoDPfokywEEXmVzcF9ErB+sMs3EWnAPl4so3dvcc04vyvcE5CN+6/+SjE3
sgvvoMC1XY+TpWunyF9faWXCvASSyxwyQziXy3fyl90z1djd2YBO2Lfm5Yfw+osI
rVvH1DokqqVkRO24JN0QTGx+xw4XAnu7/gkJJRRK6Z2Mj/dCAVEsgSm8KXh5ML15
QLqKRpyMCS07xZUaJepdJ2Ky+tj3acz8kQu92rZmfYfB1VipW/TI+F4tllny6qyK
AG+vawFMfvvbvuPGpAzBQ27/1j+5ia/j3CrCjfg1ZUO7Z5lk35NAho5MRER8+O+S
JNKV+K8ZZ+wdzPXnXQf36Ywh7wD0FhiuGzc0R87Ez2cm+a1OLWCpjY/UyaKPON3Y
DH6FKP+Ots3uqnKhiTZUnk1NxknKhWU7W9P/dj/pvSG8kQk4xuhgeDtcySrEEXb2
wSNUBR83qrqr1zAnIPhpMUMlMFiuJYzEVSpzA4rAvE5GqxP92HadyMwubx0b7Xpe
kmKvTSbzVBKsSuV7n9y7w017hdPXBhsuJyOVkdgPLOLwJnP/Xr/SmgdH5pvDJu3I
5pAjD102LM/cOtEsJH+uLEw5bOsY2j7TWvwlzYPk3jsxsvDVpWmbvA9sGYi31ykV
Qoavf9whXFlb1i3GAIzIBZOeT4K5dXtPzdNULBMXo6UoRZopNvpK1NSQ5B04qjOS
BsDU6vkjT8G4jk1SPh+0wb1EVsWormakRrA0o7cyzLVQ34hfhR09JC+KyOb6cS4R
GoKznHfnYiiKDxrAGdtIvBOeCRc/JlB5a9DMOtqXUkMSE35ppzpnDX7XoW1mLiB/
ZRnGVmWSOLqfZoqdOcMZBQ6krezNtOp4AbkRIaSWdYPmoU5kH6o7iaTnEiK3SzKU
9s2nmL8K7QX4H30GvGfoEZzHNQyHkKDrY59ai296kn6kKUyrqhWR5uJycPrZ+/aG
GK3yQQdzd3Zyai+R3hXaWrhBYYEpvODJHnB1mduxS03K58lOiGU538JQC/pzl4Hw
48N/udMd2ioYbuT/oEApoLdN+SxdSZRdzdaZQvFnhbE3nhD1QHc45NySmU4dwYBp
zlUBeghALDr89unvj0fCMK5PaEdJzkMdeKkuAgVSAf7akjenzM0ZdsATxbnUHNZ0
9RDZ4srPn5seZIGC6HjwB89i6tju1/iUA/R187Rp3twZQ/3dz//ib+BC5eLhv/2s
kuKtN95B6o2+Bc3KGzqY67d6ZUIELTpiExo1EagtZ5wSgmekURZBbrX8dw6h6GXE
mB4nfJKoiPZKFi56xV8IFNvjrChd83D9all15UjERIujrhN0HeLEel740yE9avQH
Ayj3jTr6bJLmScsha0i9YMOTVgPBNOWQY9pHtgW8NmRKvGKcWjAPsD7FefyaowdW
aM7TkTfZhrAjzTGUV8c6IzRhR5iipzWXlIOIAGZWvbsQGXWJtNH86H29vyodbLBe
1pvmE0fgXeUERTCT+l399OK/GgKZz2hA/qipsFgloytH0FEyBOOOgrGLI/AytKkz
UF+i6yFae9RP9VYZNI/2KXSumcwVETWAVMucQwmHGQZk8DrJNkE8yY4xdH9d9EBB
NEkNFlp+MR8WufH12dBe+Br87QU00ba7f5xcaYJg27/ig0e7ZlMKQK9j8Ibp9tPG
Fjg9zT4zwb1Ue/268PTNS1qfsCuERiiG2NBBAaZixobIwx8V3QsmdMYQ5TzHQ9NP
DlE/4BDdQ0Z8DFjmSUrUeR+IR3BdOJ4NHCTzOdjD7rXjDH8fInPUtfCUCb39WI3g
475YNCr6a8d0pB9TF5eLoKtMz62bfWBZMm1tMgmJpeNNeyJ6nCYaxEj5Mjsf7hI+
P4aDkwfz1SrI8UWoTVGjXjCTr4rpQ0Qd+KYajpfCplGmxUURxTm/dcP9ZYk3vWxM
ETP5BeJlrcKEO/hpzo2WaHmke24ffxP3s4pgtIkKZ7lAvLsVY/3JtsBUwjpG3txr
bjihu+IXBkb8BhDAwNVkA8jrMCHMS0xqiSen77GBxqFVULv6xzXAMHz7zpI0gRWD
Um6PPw0Jb/KpGxE1WFU+tgJYihpRd7wV2dUEZAVNJah3njcipJelyuKiK6Exay0G
H8bDO3xggsLBLER5cQxDcK4Dwr+c3tC/ZuOPXRDMrNUQi0nuB2gMUIibW05SAsRI
0N0XBtYnaRMjhop2ULVX4W5k4wz6WhkAeannhVzf0XEYj0mxi8FPNX1HRpkEK2RB
6QjAPd4+vtzwbNVp14G+sXYKeHgXLYJVzVnCTUtO1mnpeUlJOE5+P+pZa8wmoV3u
/slxZAjmjVzYSFKdx+sZwhQIppYQjt8UwKbC0XeTMW5N9mYHl6CEW7zkqFKBbU/n
9+G2waQcyxsZJY1jcXWWfHGk1mmZ2Wb6J9+oBTlvMyB/jX6Dc0F8iXyW0+JXvAby
d6ax9vPgIaGG0zZqrOmp2c8EH6yxDK2iuqyRWnYQSw0EBvhhh1qkQ98nLyKEQBSL
yJa4g49qCB5HATneByRoaKPGtv6dxvOl0+yaBFjwcSiYSqk1X8o4qqVaEVWxgJhw
SlZ01oESMHPJRdAekYgPO7vMavgiWTJd2oWRWcNn1yVveDRGWb1Snh3nHfPCuzFa
Zibsd6qJb+pKOY5HhcrlplrsaCpl2YFeety77nPPG0JIGfiWnc6NfP3swvicBoY4
w/xvr095JHwSGxFH5w+2e7CJxP8W1HDoLQGIIV+Re7/F6FItyrjJMGMo2KOI2+rs
vFgpcCm2iQNmsFcRsdIikXZDZBnB8+5ypCvEKT3yE98YMBUaFRgmsbOolSnPue3K
11dAMWY+9DDkXbTWrrA280ggTwAH9hd1cC2eG6eb6kOAMs/RPv9K4swbPXgPpCsO
lrZMY0bg11SESRbdUUBIeO2eK4wS8zXNctSYcHVnGj29Iy7sl/j0Y/Vt0USjxggA
OnG2oCu1VToUxoCoAEG+oBWU9ThmLyz8nUIgLIX6rZidllwOUfXM9AGlRqVFQptn
Ine4qxW5JaQcL4us8ZPyQf6e+5bLGqqQfncM/6t84d7ylSYQxPIquA37S5FYWE51
kQYFSfXhO/LLlAB9fK8NNmwW+fiHYv9zDtmo/o4XUM98qCnhrN2JBP1djK8Yc3Ma
R2TZEp8Atjih5V3rJidHpUhZMxlUN5Tq9tXfMm9o6Cia0xcxUxpjooKZcjMgxEtP
9Bj1zM5kCoYcsl84R6e71v753UdQcP8OZ1fGyncrU/qDe4sOyBgfS3un6dHxxqpf
YxSdnhKpADpSVq4Eada1mMWDfw9jmwUjH5PZVE/1/k5eYlpagCJ5t3Lo9urARyWS
jvOzHxdQrSdo2v7wAby+1WhdkQ5BMBPkUy/KK2/D0nndNRTNe+uVheNngcmHt9yc
TYGbkhZI32pDgVYXRBbBB4Uv1u9/tAaQDrm4D53KoZZ9LXz4fqbX9x+Raur9OY9S
RaTjuXarMF0kwNs165bpQNsgwWtwAqBfFfexlfNSy8OXdKqbNjxN0U1poCIPrcaE
CzlKATXPypTlp6bpDa3mIgyRsZkGXPd0PNs9S0ep0nwoXC471sc/Nvk/Uj4vSxbo
BJ2ZhUnESwrMQNWjRwFsI1sfez3r6xbwoKid9bvtuyRRtoTYbdK8ewyfITUafrdV
CvWwLsdypDOdojtYWPd8QtOL+GRd6xFjFEn7CeMJP/d66SWMlaMMN+QF5LngCOeY
+Dpp83aINKVeO7kpK2BN3uogWCydJ88KnHZjq3pEYx4CxmkysaJEMS7sGPSXYYvL
jQSJXUJgHsz2CodP5jdiJHYEFwQIsvNI56G2Pr49Ni/ZMaOkEiI704oM1ZLpWeB/
pfFzgmsKBr9hUKmaUveKMOIOyEkUAEzEPbKssWbTVIRyGNcYfoKw+fcwXRznyOYs
E5aj91lVKFVBmfyIh2+oF/JHNZ8c66hPB8NksiP8unkNi47nN+Cweh2Z8yvOsx3M
anEF94+u8CrEceVSDg+sByBgQe5EDEFNCBe3y0TDwe7JkzyQ+jRER9lWEj9ynxDs
GSKQw0N1dhd/UgVCW79LgXf1qXpFEJ0HUCbXZn37ior5IuYWenet2i37JuwUupda
LaVBDMom/fAvw8zxMfbFUQ6o+HR87zeTLjVptqq2xJ5a4HQUrKyRRdVvYDS31Kbi
A6U0SArEOlbMDh/iwFlkDErfts/DG/1ukK0J6FTMDpEnccWE8f7GgzNK50au2Gvc
aORI5UT0QTzV7bZcsAocWp+D7B1AZsoYIieyb88JrL2tgjhwdSj9I3mDpu0awq8x
jFauYPztTyo9G2GSSAKSF+42mQJH1G2zbZ4L1p/1izk0/OubbySQJlTplYw+xmBb
ouvHjS1GUqYjYNvMfXQp5Ydu+4U3Nnp5kngGXNqc/8T38v4nMnt6NMfp1LSiXOgM
KoanLdJqUiHRs919UylQVvGD9DvzOZEqsWdBEgNHyVrQGJa1nyU0sEs3CgKRb4t+
3OQh34LqsqJh2pYCfqkAX2hVb05Dh7pWBmIlJ4yZi/aiK4FECyUukHnaGPyQ201X
jUVtzb18OoSfXOQgTOQZWPFmi1S5KkzpjaqluL9KZRizGK7EzyJUxlxQrKY6s/ZQ
GQ3PWsSF3+P36kOVMwTcDcLbo62qcpbNRl01WwcyDtnI/fP7QQguYt83C1nrNCef
7Bwh8RKIWJSWKi9+du2LhbP9lV7brpwwZu5SmttIv5OsfwAy9N9/37WyS6yZHqA3
5tgPXZnX0X2e2E9lvAFGSnh4PVS3UICWvxEQXrfUWFfl0CV8I0hnGjmoD/AdDw9J
uaI/g8uByfahvXhtN9C3bcqpT0nIjPhylSpFo3KyG/eidmjiq+NFXHLUeUYWuxQY
mHr680J1EQtDtYgFQ7yVlCBN7nJhGaPY+OgCMQvrn98f1qm3kl4KTVdVJaDsq9gx
03nNUqlcXhC3e5A2bVbx2GE4gF8UbC4M6DJ1oSPkkz5qFlOczoegss1oE9eKk3gp
Zr7HMNPprvyprhLKL5+oMp7kn3ur7S5GOl8e5v8+eX1oiYpBBEQG4J4dg/MSKXoP
EhGerwZEqzoTpbTzecCYPO0WcJjxl70uJjEnmLWShnfF3aFDgacATCbyvItsfj1M
EI9DAgBFA26h+QpoHOgBUG8DWdwAZV8HrZdiGywjCzjEm+JSeykbUH8XCjA7eNmI
gDkHbsO7TcfuGLxMKflVeG0Td/gMee7HQSfZsT8HbKy0rwsNBfXAE+2twEZiw3ll
o8oakZoFSGSR0Xqjcm+qFri4a8FAohxHEV65jMubYf3rj1Q1TUa0MzAPLWJL6IxE
nJLmQBY1YiKqWRNH4KKgpHwL2TL51jWc8QIpb5UGLUiGFdrQmq38bnG/HhBAsnhl
Nf09989P1rUjzLaQnhTdm5/mRh4i+YHxXu9jhCr86EN8TRRB9NVkFYBtrLArkxwj
CFpBn0mDhynHKRalm870O93I/oqKOL3OAfdQcPPBJ1IU/ni+V5M9HOH4WwgxpqFj
yJzoOJaC0n5pQe5pHeKNjiwdIavOVCW5r4JGpkrs+huUe7NOKchcwFkL6oh7QS9Z
yblcqImHl3YWsQMCLNMz7mvNiZE/mtpGUXdteHgrP6DE3OA45NJAvwAXRYiI/Irs
USms2A7MtgyH2hVU8XiQ4iykxD0kOCjRxMFERwEiBatcRoXjHlyhCyqN9pKB3Fpl
p4aOP6UDb2fLFFRUEvWALvpQaMKtUb6bS0f/pT86tvO9KeTY3jOvr21Abub2Mi0Q
3rikn+XNInR0XKlVaa/W+ruxNOosKIPhc+hlZxDaNhrIRBOBY/HBE7n4uPcSbCAc
Y8IPisD067fPNkw+bexpEgni8z28pEATKxzZLWLJPwh8HPhbR0TZxJmYSvF6/JBC
MksW6C0zfRHO7V6nqDRSYy2wahoDglnMXWd/hz3JM6+V5EM6rZJ/MLGx4kf1H6EL
1S8UI4KjjKgKnNpqqad8es5PTPPEhd1gbcm/nAW5Ji+sml4zFL1yHE5s2cD44B7w
kWfVvkmYkgQ6R2QfUiI9XaLEwoc5SuYFo4F/mbOpTy+gaE5E6h/UKKEqBoWZWZmA
Rp+WU7xKvLH6wBx1uRjyvTcBCN2dlJ4PKVMWL2RYjk3cn3s6N7HsthmZ/EHnoB8E
dZ64uNAwFy4qd9eL4CIOfqxeVSiSeU1Z2SLo1f7cIo9+bd3uBVbaODuYIdXHul0p
pakGnO8SyycCxugEpN0cFz2yNxRj3/Mu3YAGB+/INEZTiUEM/W7gKzSTLLZg2rZu
//zEBMb2vEgZe9dX8gzN8zT2YBl17yD7bNafSCwMRdKRF6k9ZD1o2rYCvE/c8hzN
JzMsodoXa1IEm34auKTzIHvevylmfg5mWV8oRlZi2goRGuzDbKX8//KPk8+2wLOV
oyK3V5NZxv/HzIPiOH41O2p/fom5P3L4uHw//kBAn+13IZcxVAfjjOg3ciQa7p6z
zbu/x14VHAe7kaugpzBwzCElATkwKV6yb51VKzZmgiBsmlJji9/MjQz/bq/6JXwR
fA1Zh/72LLqTS2jWxybzd28KRJ6IOtQLP5pvL62B7vACdhA6OwL8pu9RbJ/9g0HV
94LEcSxGhuylDcq59lCZVSshKVjqTDvdbV6SgqqUUVEKc3kNfpQHH1HOZy6N02Qm
0BDMBPKVOzTtBRD7vCrTlP0uvaBvAwaqWhxtmB3tgKPM6eJzHRmVsHMavwfHNXs/
i2xjP0hgeApABC06rDq78y5qXIfSI/OZPHAcsJfGxu/n4D5rK+z9KiA66c+dKGhV
6RUZvgsVtMcc7SKcCDgl+NYAKp2v+45ie0RJC351Bkrff60k+7wUPuX+YtvD8b3f
n2im9YojZ+2bvSXCAWRvMDRJmyol8u8CHJvA2DC7kXwlcwb5mj9P7wccigznMtEZ
yU/ue5o0cT72fhtIbQX49Bq1szqrpKosqyc9y5aw0GprSpSQ5AEJrZhxnibQmW/t
4jWQ+xq8o68TzEaAyMGHr3EkMTD+9NvQhBYo2yVjttZk+6s3qbtr2LRFRN3Zk3VX
Sj115bkQJ06eQWHswgXf9L1PlTXCeTgbzX8V/YPeiNEXnPw3KI0IedSE056jxMWT
lQy5d+qVSkSmF2rnLVSPrOrG0RxWo0e8VZfXjpMpozhGozG85ucFEAyestN9rSMg
LET5Wd/8Guuw9mG59b6q4axApZYpupMOSoJvP6nghLnqmZERa3mK9Ur6lMqiZIz9
09DdZ1ak5DtaLnaohnGKqlEXex5Vlg1SmcEQAAY1MvWjxtpjz0D5EskBX+dQ6l7d
umTjbR4yjdOKa7Bz3zXPfZ0P2RzpQB1le9HGaK4L8ZXqqebVlI3RDmDqdvGNQ986
loxDA38JSNEkeoAku95Bv75iprqzi+uRHZyf3DnDaCeV1tKVPfo7xWMf7LyyU19r
ZmRAJUTGoZHOQyZT/l/VQqCT50JPA0c2EIwPeb4+m4Wk7EE0hyZrnMEa0i4pYHX2
ySp6yi7Odk3EUhkAwHYiEh9JljBWW+/13vKoMs5R0gCM9bXanaP1nY+ZnJwWLnCE
lQUJtv/x9dbFxNElZNXoZ0F0kzxjU+gpFVkN+WLny2o7gNo60annd/ZpOKdHaSjZ
plBQScyJa8vhH6Bu4OLeG1RrfIDzBSxe6MP2VqKMGO44G+Z1/Qor1STcye7Q2DI1
NUjCB4muqVOh6FEH5jZHc44YH3lKXCfCkoU4DIkTD+ljjNLhEbOaWyiRzbb+ey9j
V84/po3sunVwzui16Wh72+Z0v6F0PgSI22wJC6LQo9tZvPudkqzA4s7h6GSgyg9R
Qndz+1all82nhy4qheUNHzPq5v3r+BK91eaUSHQx4tWWizvEmLuhaDLNOhmYk7ln
rgOlmv6HVJK2vdpvL1b8ak946BzWLQazupyFtIrG4skzhE3awHIiNCyPwS4xtic/
hL5B7dzxFCa1QhZBCQ6FCLti8HR+mrxNJGg1Eaoe91mjHZIWpT2LkDPm9RQK2QBD
Vjvx+SrOCzj9vnXsYXfnVXld1DblLkJAH/yHkIJwgGT2OrYcFouRxkVWZiCQBRvZ
/ul/u171AKouLomv03VnK+m3CJkC/IhNMkczar/gBELoKYU8/YvfeMKCBIp5Qzn7
MSns4nw+D5awpUqueZ3Oydr20cuSlw80V6GZzQOM9XlJow22TF4NUw5dqCpq2VTp
ao5uzZzftlEOdCfbdCqkkstk8Iz27nNerfvm6XmddjQMHVWIvektHolIG7/jDnxF
4CcV54wFwgSkqXRSW8AAg07uQpv449lYxAjKMVBACqJAzItIo22J/gcFEuYrxuJi
5SrCEj3WijccE+pcBh7l1q16lUiKMGFf9JO7TjTq0vxmeV/0Dw05a/vkCoECf44G
PrIffLlPZ4PwOftyocjbWwoJj2tyHgGWNw9PUio9SzqwUXV9UjWUX1xTiqP9duz+
L7e8DvFNoBGD8yfIKeYLTvn9I9VB5DubUhek6NskRgu1F0/J+4DV29yHvQ43IDCc
0gHAQ9C1mz+CB/uNyycXolazngtLm3oByFJ05DtFZNG9G1Ai64Csz69Camp+bOuX
TiWvMBSMXv993pe0EbgHyJgeaSfyWyagzspOotKsMcFIb3NyhECyLDHI9crZ6NA+
Xssud/5Lg6Oz+VOiO5HQ72+d6bdDoXBz78pZvjijDnh4tNOEVmKIFmQ5kUCvMlDj
W2bxWyFR6QEKNGlClDrnm8mm6Pvc9oHgouXioREaZYDbSX1cId8pRDIH/DAxhMLZ
vQzxvZiFbjdrvxPJByzm82wSlYdVGiP6yBoRFqygRvHm0WuPIkKRm7gTUobr0Jzd
zZwNuWr3NcrhXaJmhECAzf4M4pYKL52SdTHInRatTqOKk6/GriCv5PUhJBwVmyjM
VaHam+/WBc8/HS3W2rx4bEMsi7sm0SHZyDVNm5TZ01s4lUxh6T4mbo+AYELlhjXU
b3/LFTdmkzIxgM1ahw5oDBo+1ZycCjTfiHlgspa6i5eT/QLinLLTEnWkpjUF/LKK
MGTfq0/fSMyG9AAzYD8ULlDJIqAblUSvzStyTm9Khtm2atM3ij2yFhQs5+v2O4rY
VIKRHFXZxGD9HC+UzdIDVSAEsYctF4I1A/C999VvhjVptq1KluqeIrjp0G2uISj4
KX7CiPmd7T+L8b03wGo6G1GW5or5EWMED1mS6DmsT112ee0EOnEzjJpYYKHrEeNX
8OV6k9JW2s1BN8TdRyigwNo69uvsNys4kLQRciOHBxQslaXu2XrPaceme6NIj4Kp
JG54AUv+k3eQjEv2se0Hhw==
//pragma protect end_data_block
//pragma protect digest_block
a1HzLlyRuxYXOIkl/MVkVNwlffM=
//pragma protect end_digest_block
//pragma protect end_protected

 /** @cond PRIVATE */
class svt_axi_smart_queue_2d #(type T = int, type K = int);
  T sq[$];
  T ha[K];

  function T get_random_entry(int offset=0);
    if(sq.size() > offset )
        return(sq[ $urandom_range((sq.size()-1-offset), 0) ]);
    else
        return(-1);
  endfunction
endclass

  /** @endcond */

`endif
