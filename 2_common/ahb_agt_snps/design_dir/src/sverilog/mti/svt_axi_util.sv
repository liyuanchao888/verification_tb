
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

`pragma protect begin_protected 
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ORdCe8/VGTngnGBX6nZrm/rQwNYuru6+mtB1tAv8ZS4xQWqT5yrUXg4SbJ4fgPah
aucJ7GShA0uG8+0O5MUdk3gkEe57X8T0mJB4GJuEApZdKbrRYXqrH9doVdU9ZyCR
G7jbYHalaPevwT0SCYyjYxCr04zSC9ePnyDEZvL+SKE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1198      )
UGI5qgJQJ/4nEKYaq/V886X5boQn8tNY983YiqzeeS/9NivT9x8TCAtmOU/9TXZQ
4aB8GuNUMviTS6su7dCcRYFx1JsE9H1Z1Q/weZVlUkwpT+H46WF9ieOixVk6e6I5
Su4WRkC681eBVd39rJltPVmPwZy0f41NJkOzwt0zXKVBjJ0yZBQFCJ29Xm+w+Gji
Tl1QJYr9tSWyNnBjqua7ti7zzMkVXmJEd79zAlD0mqJpYOYV+SVkByFu6KHJr3Xu
jJp2TizxGPYzUX3iQkNF7FaeptTAdbnPvFZ5eg/LnLiZqSeDaXeBIzDelYtci2mk
ObFn63dqPD6s4/rOXB1Bl58ZmXXbAF6w5iMQrjMmIYp8espJOIrfqR8H8sIrcrcn
VC6dyHYC/+K2P84+a9y7Qlgc8wTfLn/eOlznSdngDMip5NZYEWCtz2xVmw9sRLTr
LwbL1rXvDg9IY0p9U6vPg6J65+YtxNDvN5RP4Wb600NRaO66FoBd1r96wAEnu9Ox
dr58/3CvJe/LWtQeZhMr+veIGvqTLTVvZn8fMpY4Hr5kaSLZ7iPPuAGp3UDSjBAp
zniH2/3/FQ4Ts3q7gXWC1joEN89jxjdsfOEtTfe7NlYxyCTkwiMcY80EMXCsv7pJ
lb3a1Fu3pI7aimclPF+optmaqwdGsD5xWSchhrBqiJ3pkH/8h4a3IMti7RuJWjC6
qeT5DUiM7oOjlixHaP7KGJ3Hs88vAMjOHwATGX2o/twXE0UnsURzlbn9x8eM5acA
+omFd5HGqdt2wQVmotekfYLkeAkIivwdanXllFp20qvHgJwtl06t2Xwopd0VYpZP
hl3z2FTIam/06OxPKiFLN6ykztTm7RgtHZACB1aMgsF1DIiruzgeNX90MSxGkjoC
jNIwXO5Qc1r2ra7r5vjAVImf1mRdRZ7rGzTmvGApolrSCfFzSoM7oEo5NYFTkY0P
v5R6ytTGpI3fkEGBLGPn2JudQOIGg49PaSaaM+TIi3HGG9PYffGThs2UmPa2g9tb
aF7G4UhNWTZlU0Mxg12jYjdxm8n/TVYy5GUajr8dACDHR59PbqQW3U0yn0/hwKov
3OO47VXaGVzaWm5sOCM3QtnDQQngrYcTN8MPsObIhv/XE41ig5iHk339mPgm0XL5
pLkPJN+obXlCkQ53/ICqLYpaMC/fekSPV88Ek2fwGH06bGtuAjt6hf6KDacw1903
4UMEEHqEl2c+Sg6QhvVj3JW3i7D61bb2S3JzUnkg9Fm+nu9fY44fc9Q4DXQT1YF8
GORQpbZtKJs+GUoEBragsERllVgBwxbd6ON3nFzBvBRfX9Tg5UoPdLVM8BnqfQJK
9+nTOaS2hn/fEnCpCJfDVE6YiyHE+02W0xV2lWu1DUh5Jx48gonK1RTncW6c+I8w
MdkOKx13SdIKg1LIOVYQr1Z6BiuFjWnwjlng2YDEVvGfi8qwlfdUwM0VgZTL1Snp
mVUvSghHRrgMauwAmCW3loDzSCWqdXHmfLSTc/QBIekemgUxqM2HSPWz0TkTwsoN
n2UWTMmMB7jeKpgXOWMo8dLZJYMRV3qoeU5zaC+JICy6K6zPZC2FT49xi1kHTl8t
`pragma protect end_protected

  //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eLS3h+TLnsR5SjUsox5gbBYOZ3ohTr4jO3TgTqFajANyFUxObKtaDaErjo/XTpdU
WSVOoOrJ+UGxT5Jf/QRyqtZ8v0/I/ySMKLg1sitIuq7+K2iWjkws34UbcIGvCenj
7YfgGalwFzNLU2kDyql0PunrIFyKM8gQMdRnyiU6bdM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7048      )
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
`pragma protect end_protected
`pragma protect begin_protected       
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oBkKbxOIsoK1orXPvx70hDdee8/7HlBxncRPuV4Ul+Dsi68Ve9feVqFSy2kOwm2v
46c9mQppgAeFDKXC9OKKeL+In55Mfl0/lVEFCcLDKeuZRtGVp2dcVo2WO2HxGJT7
5BvTPm72R9U7MepEyPojDeYYMjcdUd6Kl4lB5ngFSyg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7232      )
kvZ+BAvukX4j0XQH5JpifQoRAt4Ur5H48w14d3ULKs7pXA7CfGbi+jk+DGSXmxGF
2GeV+r/TS5PjLMbbCpiiT9nRrDsdgpiobQiqCfToiogg+IkKbY9L2t4j1EO3+oUj
c/CPfhonDtvW8xBO3/nTd248aPmWbFFTU4yWRhzFKMn5vbJeTBl4OKlbRDL6Tzf2
3usC24jtJHk0YFpjCKaBc7YXeNdOGJx8imKkfALuMzBXoEdDhlj8N6wrXjcdfDhl
`pragma protect end_protected       
           //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e2ShOpRnLtJKcKYAKe9xrNgatcGpvOfTbxEUVSen9+00qovdcHp4wizub2hjSpnb
yBsOaxMxLwKgnZaoAIMHtcXdqYvch/UcNuick48yfMV8QAzpPiwG4G7wIjtdaL2A
czvS5Mfiqhc8MjzWo9ft8BGiiR5aNqtOvO1V4mE7gjg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9040      )
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
`pragma protect end_protected
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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VKRyqjAlM7qf+6rBS4NEg1smOdZXfy4va3vKZPXH16C+ges7favnGIFJNPNJNDxm
9/UbgQaumM3uypqt4QrmGbPDwyxqu4u8v257WCvf18eIkAnA6bjDM4rUcLA/SoiL
pPAFO+SLKvZWkDlHzTWKRKJdHjKQovSPciMqdbDPgpA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10714     )
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
`pragma protect end_protected

 

  // -----------------------------------------------------------------------------
  //                                EXCLUSIVE PROCESSING BEGIN
  // -----------------------------------------------------------------------------

  /** returns a single unique number from xact ID and ADDRESS */
  extern function bit[(`SVT_AXI_MAX_ADDR_WIDTH + `SVT_AXI_MAX_ID_WIDTH - 1) : 0] get_uniq_num_from_id_addr(svt_axi_transaction xact);

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZrpLNJuUwW7Hv7OoQFfCP/9570Fu3xUDjDW7eZe6PDvYmCZz7HcpHEYOjuXUhOr9
l0MQ7FVFXKcabj7/82ml2mmqxOFMLcDKzXGUz5pBaMrwSpP4cd71CbgcIiKpq87m
vorJjKtAeU0mvM+JkAQO2cDrw+I83myqP4UJWDGD9eU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11244     )
fi2MY4ZyYgPqo/IpqYroTxo33zPHv+plY2Yn3RooGdVo87QjAFu2yMg6cyPb+Eel
hMd5wp57JaRwpRKQuGc1Tt+34J3zwT4nkRD4gFEKb6xNMYQsAkImxOljX5jKNRav
ZI38s+oJGV78KkMw0nR8SXsJl5kkgBgvvneVja41CQkl8UE9G87dJbyIqywjbkC4
hYN01PnLOAiMj1BvAZLbBK1kGtog8KADzxMsXO6iO1lxiZeAmWbxUT7H23qu8VNt
8dpXLeVlsFlRntH/IZ3lOTk607Iu66+ky4n5BtGXRcqBADGE6/nsnbCI3cedlaeP
xkHQXkAhQawzF4uLWOt9qjE3UX9kWn61Qtpk5e80gmw4e1ZxoWZFYYbCjpyjU0pf
Q+Uw6dtO4HjhLuzvsl8dIaDRom82jsSo3a99r3Dtk+L10VxOemfL6N1s66CYJ4BP
O1KuCetPOh/bCs3cqKUuvqhTHiNqsOII8AIZ8Yv7mNhZmO0amy7QMVS923/qHktQ
noYBi8bou/4UNzLp8pZJJUJyF6pfuyMhhIZlRcKrXlXHNDvGCu8Pun2ncWqLEO1x
dgT84Ee5897SIsr/3l3NFlYgcA5YBgeF0Olw2zxc7xLpgJ9zwXoi3GbdDFs46xhD
qY0ORfNpbzfkkcfZeT2vjYZKQv3DgktxPYJh/JaH/wixsbc9KA393RkQ9wI9KSkY
U0qqi+r5ZjcqeTRb7fHmWg==
`pragma protect end_protected


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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B7qoXytoKJYeuCotmmH5ZX9T+JZNasQ/XZ9J/eeNwMlxNgbgTDyEyv/bDBDt2ZcM
AQkcspbZAl5388DcdADU4udDtvTMeRWIZdvNWRKNMvYXOwIvELFmeE4y1SlhaHsX
FAS/jF5LhbksgSyUWaTq7Zt0PIwU01EMgWckqc1OGMQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35212     )
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
mUCq79GVeJu57aQrxlaByW8ozN03ABGeG2hLR8JfqRFgGYKTjt2K9HSuZIl0D9GL
k2FYZw5a1vWdr/JtkQnOfLpwIZfNPE0wpJRWgrNodq50oumiuS/SHlC+PT1mcSeL
n+m5A0eVy6QPxnS8tqDLN2CsC7ZdBzai6bbLbaOW2IZDVZMtyvvAYg3nD0C2jzLU
4t1jly0TuJp5Q6/urpFhjJHLmuI5fYTHsI+X6XU4ptszA8Xvw/zh3WvmsxYv2Rl3
WchJh2XxryAQSVm3ZmFYAcv4m+cr9gZ3IDywGPEX8SQY6V31v5NtMxY5RnY0kt5j
jjovl27WM3y05qg3xTd9LUDJrieDWepQf6Ad9cqb60hDfNig+mfxnOtph6cthI9W
RusHu+rs41NifLMyjhKvqjtHU/C00nn7EHjoQaQ8EFUUm/bq6IulvaonkeI2Yqxt
wrLGl8jkZ5kodOUJkWF19NINmXZqAHJI5dzR43C7vdJUPeoMIGDwi+tznCoay/OP
KYCN5+bic3BbnZ75LwjqIZr/7wqEaZThAqf88/V+HEO0QiaJyWvMztC3eQrFqNbE
LkdhQbgd8VletclNHwNs4u4Hs1A49xyEpejQQqNIvp9+k3mpEewA6NFBWCFWR8IM
FOxe2Kc8m6OLcI/a4JKshL0RUyEgNY+31l5mHmu24E36TUx0k7jTAjZk48nR+Dzb
Z+IaR3a00SXllEb9lup6DqqBz8ipcXAR1WOn5Xsx3lg6HdBmXJI5WOC2lxhIZpP9
GiMqJ+J34Ygiv2yX3Gv0A/OF+ZCvnhmf1WixF82idXME2DtSra/hy34PNY1cgzdi
S2t/bfxwGcb/K+68E7Nj+NcF4wuCA+5VjMCceTQ1oDl8ZhLAoQExr7rtPnd8MOnD
uQZUAf8xkIHSAiWRV1wFpJ5UDDYdYx/n83FMnkrCW5Xea1tfgTyHmRGARWefkP9u
ZBWQoLSDMLRGxHlBq/P6OApVv0OTbV5iBrlnucSYf7aRK2i9MMSGmRLzaDpCUiAo
pc1gg4cGWA51lMzc5KrgvzhRHJ9yoS/2CgZffNtQv2IkW+ld919CRVTlpXUd9mYI
vI44Pkmn6nU9OMZHfaqJssoaOEah4KtiGbHg8gnngW6HDJAL31vB+Rn39zs3XusU
TejXmA7pAhd16df1nYJ+YkX+dMD/YJ0rH9Zw2+THD9OG72zywLxr87TIxFPsNYbK
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
`pragma protect end_protected
`pragma protect begin_protected                   
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F9y3fK0HNhmADSn+1QS3TrFw+cq6KP8ji/uEDNYfOCvRyCAhfR683oaAK5CeAXSz
Vvm8T77COvTUEI2TAO5j6GXF8GXy+ze7+Vko/GuUH81AJLupRamI2v+VnxPzGmrh
sK4l1WVR1w6unISRQT9j4EaN3NbpqYXFr2KGZ2DtJew=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35566     )
VrQMcGSlJ/fQOx3FlBtfz9LoHd2BgkkWpkHB78nqr7S+Cvy0drql09ld7M26fvTG
kOk2sTWuyH2b0LSDZBMkHk8vhi1f6FjTaBhIJpC814HViI4vgYVG9VjslWdY4vuK
4FJl6ZKop75pOlde1zJIT5B/i23jwln9etUaEQjPa/b5k/LOxqdd43gU+AOPqV2D
F2YFyOY03n7GeE8xzXs+jXLZnA0mX8rDtoeAClD2GKDe+/DXXfktC3L1P53avvfn
G3B2+dezkP3jM1ihy3V3x+K18Q/VQxkGoFkf4rvRqzinhKRizuevjP+rFwP2mttE
LS3d8ykDpn/TWLBpjd2MalKGDQUmEjyUHNpJfXJx32d3REl5+dAyJc0LgPZhGEGB
8jjZSZ5X6Er6kIUXWu4ytoE++dSlwMby8YpuClLUmyef7y4yF8fCb3k5+zGQ2K6a
QeDhEiJmajGTRtrLujfZjE+ZkqTUIwiOqyqOZnWyHD8=
`pragma protect end_protected                   
                   //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
h33SdU+LhQSFsdIRgXnHy8Hor5zud8HuI9eiK/wmUaIpag7//BziLkzLok1av5Nm
1BwB4L/WFIsIViBReS7CnzpXyYJsPPT8mDbuv7AwTNbOEo8/DVSBJU1Lxg9/5ee2
H4PJKT+zYg228mSsuHLEENH2DNTrV2yXS9KHHTyoFJM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 52331     )
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
gTg1WsvyUZ2EVKOKVKoe2Q==
`pragma protect end_protected
`pragma protect begin_protected       
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GmdpC8Uj3X07+Z+QH8Tim4SW8lLYffA/irnxk+uyuoffkS+Sbk3f0d/EQzJbUJZI
r21ubiKyet3LdWnGTk+OvxijNhyepWmfNpRkHgeh0NhdgVmyJ5UxnMlwhOG1uXUR
GZmkcPpSGnqL7Hy5amDYC6ZsweyjO+NBBxANyWfLBR8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 53013     )
yfT4MO50IftLBoZZjr/fpm4t3btfB315qDVnJjG6DyTXM/wayK5xFI6Wbr6L7AmP
qo0WKYLk6/s6c0x8mqilbfL1CHwh6aTZl0MVhJne8bjm80KzfqKYqc8diu04blm+
/xvmLxiJScK1EXpuJrHupyxgPAO+88/5laBYkKKWF4KxRPuJ9nWF8rJ/CRXcln2R
SQDGKK1weArSurjH2y3Ep/DIu7xJiuVZ9n7YzinTNAGHtkq+gkv2FN21jqKh1klw
gHSnn6qjvGYhQeDJlmBQLDX+KhHJI3o9UYPfQOt470cSg1gT5N9fR+AnWTVhaPoF
hZI+tUbzsPeNUoKExzPiEATO1sP4sEoEfgN0jwUA21Wh1LeB4kgntlV/1ncrGkAd
T2mdHXWH6pRDPQPdA3lk2byIu1oNIbw72lI501F/CUSsI/AETZ8Xfl8t0W8oih/1
H/yMIC874eOxxO9yoKKEpS79OzPsrjGKA3GFlKYRuCm2xziRizFllJ/5zQMBiPU5
GET5MQryrQk788HNOsxyTWIVA4ytaPkw1H2YC5n/Gi8tPnFUe/W7RCKG4mtARcm7
/zFxdQ0eMYwMySBpL4pRTCWR3znl+Y4g6LMv7SHwNoPqfUmPu55Lb3FP0+T2qwLu
sxlwcPrOUH8G7BrNwMlXgQyuF5B6zQeDy8o7AkbXk4RhMJ5M0z5bgHJybIYkA/m8
2xQeu3A1yOWORIjJy/eDdZvsXEF8d9DSGJB3QUt0sXBaxnMJ6cPSSj2vk7H+DMGi
x+QKIstfqtwH37vt3WSz3ZiM6ejFdwbsXIOZC/jMKZu84w3/2HWx2gu3NxRoyRS+
zz+a4KO15ePWlxbztWRtwV54qjLxm/gKvzOz4GHUlsiwE4dvGr6RREUdhYT9Ws32
AMJEQ7Vz2tMuKQXJRc5tVg==
`pragma protect end_protected       
       //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oPSYfUEUdsJqKnEBJ2nLj2FLAZqsinolLUj+jUSUF9yfdfR4x4uunEKAtXbF9zX0
mI879P2qv8mTAILrIu5mN9/0VzTjw0HD3ymsNQe3hm8UH26faP5OIu2tEYlanlyT
93/BYlKYrgPW5+51FJxxjmBdOQ6GJ46xzXIoKotzAbw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 64905     )
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
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JAF4GSvd+BCqZLE3zkm7qvqFN7ogXu5fik8DqFZOsq3ov0VYyIDCYcA4i/aZ1DVG
WpL2q8qnuXFYTV935EL4IzsgKlQUDh5ZH9xa/CHbMK7/RNNCzboeRCrtGx83JJQ8
KuuBufTmCm9dj/+0Ki3R1kzc3EHk1YVTi/CpPGLEnQM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 64988     )
v+AMndtgab6FB0FiHyXSoLkZUXvfxVO42IvunqjD0LqbBN8UhMTz2AJl7bezPZel
JNO5vokG4bZqwIxerL/s98M1mMevCaNPstDe/fZH+HWndHiEcaXzqkDmT3GePQIm
`pragma protect end_protected
