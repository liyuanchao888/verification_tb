
`ifndef GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_amba_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_amba_mem_system_backdoor)
  `svt_data_member_end(svt_amba_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

endclass: svt_amba_mem_system_backdoor
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4scu5GqLvFG9hmw8os4wxp5qErUYMSVddTx+d5FMOAWfCC4GOME56fDl5cjFnU1r
SUXUfstvu3XYiy8w7HpolCbcroR618HZziXbfYZO6D8dzUj4O/0DxPyRNQhTbv1z
3LL8Q1HD2UW9FAkC7tcs9+7gQ7wgos88Vw/KEd1TBi0Hbd8VnjoU/w==
//pragma protect end_key_block
//pragma protect digest_block
pKU6+kUQvBikao7jexAnTOx37R4=
//pragma protect end_digest_block
//pragma protect data_block
gyZsDqKxvVSlR6lzOR0wiMHhmXcnhfRq1NHQYjY2nGOEDKityOAVSFaKfHG87yG6
ZRme4EixVbiAXBW+PkTTTQsgkuXM5lgKJzfkvm3AwHmoVLqIhMaaqOPIPYupcgXv
2uNS2nwWiIC4LAtJf1i8RI/RBL0mYPH0doomeL9ndyMtxW/6S1j6fQGpqt0hRd6j
cYUx6uYOwZkTqcdoN6/qG3XwjpNDE+PKeevoKPLEIgFLFA9jPq+jFqhvzftFaxvO
AMrUbAEJtaTbFJRxlPGc9zSwd572BgasB8XpoDaQRP6uW0Kh4utz9S4py+Z9eauX
hs6Vt5XaUteCZdCM8LkfJfPlxtngklbbOOqdWfIWMjpk8fRqYluvy3j4myMbezTm
5a1cUyayOUmenE4vI+2PpvV/Ex8bPT9oJtva65HK68GDuWHoSuctY0u2Uszma2Dd
rinCICgE4/L162tllOCiZ9N3eiUmVf7LY2i6i3i4SYEVYP7k468/X6oJMxd6BpRD
PgLXAj7ecRsPkkboQiylkb8zzHW+AXb45883077Zr7nBpTbZI9La6r7AH2Wk8pnc
n6G7nACbc5rME+Jop73eTS0o5vIM5FjNuQu0j9ntuFtOdBfWL3IHT+DktzHZ1Vme
jDsOZOXJEC8SP2yTCmVcaqBkPnjgrPMWOZ1asBlJcwgJO0DIA1pE4wiZlwvmFiWa
gnd9tRBbS2f5EWVNYauA5Jd64xb8u2w7SmK3jdWia/fY4UekezQvHLCbtwDN7ONa
zZ2lKMZiKTKkvt3HNu0EIKQvoj4V8saRysiOoZH6QfhRUs0ijim7GX6tnt3FzYqj
aM/8TeRvvb/2OvqxNU8G8ScHnxBKz4/8Q3Vs6m46/f0t0pteTRSx4TkdK53okbVJ
NbJtLayOBgtDTd7LslJ/58aIdxYUYSwH9FI3aBw4P9r3fwLyTX/8ldA40e9Zo/aZ
GFbL3Tdog5e776hLvoYTxlEbwHgofojF+BeTKHtTzAavRUo/tcrAwr30noI+GbEP
8dczuYBEnR+GZJ2LlDje9svroRkspFY4YtP6vYDEEGMtY5UU4v86BwuMUe66aETD
AyJ3Cft5+AeVVjgoUVLL05q9UDh9YJOP2Ai3wFK/YZ62g5kgE8XeY95SUMDFK8XE
luQI+EsEMW1OJ/Pn581nvAve7VEu9h9H5G1gq4lWIwOnfdg6t5bN9kywHPQ2Ns7G
jBjzWH4hMhyhSuqL9a4pkmgFPNx9dI1ZhtyYyD7eBREnMCYrY+kGTBMKOqpRxvRv
j9gV3G8vaIa0/wZodeWN/Hh0RbYNcNhhpI1urvPixWXwU6WW963pgT3ABB02pt6y
WlloTRguUQT8axVl+kPVzqSF2rSOxG7VwYo3f5wqfS4=
//pragma protect end_data_block
//pragma protect digest_block
ruoW+W4QoyFccuq2EOykBWo0Tgs=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bzDhglZGNblFKRfa/S4+HSsr9PEJlseVmeCnvR87OQpA6Zlaqmg2NE8vr/mwIHR1
dYp8uhGYQpAM1uZDJk93//zbWm3/bzIMHcuQpRdEc/+H8LPs3h2o8weOv2xRTo3W
Gu/Ck3nSzX2FXNkjYY5nqkEtxW/lf8xA+p8w64PK58nhnqsy+Q01Iw==
//pragma protect end_key_block
//pragma protect digest_block
UAadi7qMjRhGFKtRivJHHmyvwmM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
kZBBgVKIVjZzYzyS5OZse5U2vfY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
