
`ifndef GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV

/** @cond PRIVATE */
class svt_ahb_mem_address_mapper extends svt_mem_address_mapper;

  /** Strongly typed slave configuration if provided on the constructor */
  svt_ahb_slave_configuration slave_cfg;

  /** Strongly typed master configuration if provided on the constructor */
  svt_ahb_master_configuration master_cfg;

  /** Requester name needed for the complex memory map calls */
  string requester_name;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_ahb_mem_address_mapper class.
   *
   * @param size Size of the address range (must be set to the size of the address
   *   space for this component)
   *
   * @param cfg Configuration object associated with the component for this mapper.
   * 
   * @param log||reporter Used to report messages.
   *
   * @param name Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(size_t size, svt_configuration cfg, string requester_name, vmm_log log, string name);
`else
  extern function new(size_t size, svt_configuration cfg, string requester_name, `SVT_XVM(report_object) reporter, string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * Utilizes the provided AHB configuration objects to determine if the source
   * address is contained.
   * 
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * Utilizes the provided AHB configuration objects to convert the supplied
   * source address (either a master address or a global address) into the
   * destination address (either a global address or a slave address).
   * 
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_ahb_addr(svt_mem_addr_t src_addr, int modes = 0);

endclass
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sS6v62VPTXBHuGHaLRyKRyCtwtnUcLmSCywL/xdRUFiY/ddzwvyq8CfzSEX7s1rP
Y4asFMh+TgnHgGkSXY3x+AU7C/cWFXR7ORvb6sKNo8FAO0ZAobLVAI4G2EqSlhQ2
FnwD9XJ619nLW1R1bwqlPBXjpEr1ITBrfSkPWsFZpHdTGFv5hb3kHw==
//pragma protect end_key_block
//pragma protect digest_block
80ukKw0+mbaHCiQq+5TJcH81MDQ=
//pragma protect end_digest_block
//pragma protect data_block
Mnaf/kCPP3wa3g1CCk5UnW5c0O8A8ylO1MXUkS41ZYWNoIhjO+fbkX8R3MtHbq6W
nlmTLmhz9ms5bxl6O2g/ps5QC9BUv96rIpSjFsr//cq30W4I0hDVl3nfdDPqoQkA
OffHTedcYGWzkBMQw05roD+qwh7tfyN48KM8mMWg4lvxZTRVO4Y1xSYjqp7CfUck
m+8Hu1dgUg3AoWNNUlyFvSkARNbctEygGm+t501m9XTdo7rsUA/bGtlZEmRYT2Jt
VodBaQwNg/9HBggZhrumnD0Aa7z/9hvlUVNg+55d9g51u+8h0cgLmXZdNFZKLonV
3DBTHZBBSd+SWYtxIUIvXJn3HizPgDTWJiz3UUXCTzB0/ATV4/CDNVeGX/dWuZQ8
TOtP1sErmV2A3W1Zr51H/fZS1lhO/bzaXVg+kH659AJQVE5FVbvzinF8Brbt2Tic
RvUAujGrBr7AaJJlMwO5lhbGfz3Yw93VzkkPwJwlueKV8tTQHyW9BQLuL2E+zzOx
wk6FAX93wDFs2/rjgdHKWs0w2utF+UQsMFb1CFRCHsW7mqfOkJrocnJsFo2YfHJE
dK69PMM7eDZ54lK93wupaHbYJCEhQvWJZ2HZAlFLCN9jYaCYwufbfqtd6gSWwzbX
ZEClG/ZQ4H19nPm3noW05wJWLt4ejFhWqeA7VId3dCxaHQ4yMy7LYadez4di2cBu
LM+73dwqaiXxRZondcwcCmCOCcqG4Ui6Be5fq9C5qKICOiFgK5hrNWnu2PAQMOCp
UWtoe5gUQz5VHHdb4enZm5mh0fLylM/2TH30tvKEl7Km3dKTG8Jn3QMHpuoUafkg
w1yf49vioQffxEVyfzKNfWqK384PnvIhqT+/g2zRhCUrWokwZOvqKH+r9v/9qhan
8RiKhuqS+uD1Yj3HSqN5m9xFHg2hAO6BVF54Tq9jiGWRwTgIK9Y58w38LS8AnO1l
GQGeJsiLsIkRZ0mS9dLA7j6TkFSOl997VmcXZy2+uT04rPdLxDEbYSBlkb2DHnJe
ZVo+R1ks0hM4jX/qw7EgCIXbLc1hMyj7WboKXwgAP52fivrcFp2C3ZcX1OUzreeq
f6GkrdnqBQTggZw2G2B5dpq87ZVZKgaGB2Y+CxFoQnYRiR6ArQmAc27oCZ0CA/lS
ElxLT2LRpA2i06Q6c8Y7yKXe/9cVv3U8mw9OhJWfHYF+sm+jmAUi7PeA5TxhzJfe
aNKPtncWXfeN56ClEmvfyM2GTsSj3mQiw7rivLTKg/89dpi2sEw3+8K3Te9QfTvk
aZWMs0Jr+Dr7oUQ2EAXUwoafbhNSMnr9x7IiYZBcQb1esHRzBNlRHMrZV9PaOHrU
c/c1Isl3/uG68R933RK+gg2ZeDu6C8yPAUxtRiKHoSCNepxtyudQwzXRLBSXr/xN
1LjGFSqKWjuW2ZNSyK21dmcrgaBA4nru3Xju7S8Ok+hibMhFr2my7z7C3BhQ3TNA
KXDUwDUeVY+91tJQVHFA0KfMHiOX0J0tR3Sc0XCx9RlztcZFguL7DIzLrTUBT6Ba
CrveP9gGs5ZVSm/EA5X/MlJwr4YXTSa1p42qbQAW3A0WE6/nfi47QpYlC3tdQsGh

//pragma protect end_data_block
//pragma protect digest_block
OLo2yP7C2wwLV2EmYiRI2S6e+ck=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
txfLUvaz2CUWeSTbOb1/ENwD2n66FIfmZSw9JWZYnUYGm7v4+e01q3fafxqTNlSW
xyh9/gJhVIPaRr24En15NS5+LBDa/5iwaID/tKFeyho61JXhwenkPq+1+27W3qAx
sW5IPIVQnLkZ0UIPIUIRjlwMkQPjXeJmJJAV32aG8fvC04wfVNukew==
//pragma protect end_key_block
//pragma protect digest_block
eJTQYcu5MvLIyDlopL4Fim4ueHQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
8SJ1ZfcjlxvE9du61J36zR9+sog=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MEM_ADDRESS_MAPPER_SV
