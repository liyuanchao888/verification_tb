
`ifndef GUARD_SVT_AMBA_PV_RESPONSE_SV
`define GUARD_SVT_AMBA_PV_RESPONSE_SV

`include "svt_axi_defines.svi"

typedef class svt_amba_pv_response;

/**
    Type corresponding to the amba_pv_response type.

     See <svt_amba_pv_extension>.
 */
 /** @cond PRIVATE */
class svt_amba_pv_response extends uvm_object;

  /** @cond PRIVATE */
  local svt_amba_pv::resp_t m_resp;
  local bit m_datatransfer = 0;
  local bit m_error = 0;
  local bit m_passdirty = 0;
  local bit m_isshared = 0;
  local bit m_wasunique = 0;
  /** @endcond */

  `uvm_object_utils_begin(svt_amba_pv_response)
    `uvm_field_enum(svt_amba_pv::resp_t, m_resp, UVM_ALL_ON)
    `uvm_field_int(m_datatransfer, UVM_ALL_ON)
    `uvm_field_int(m_error,        UVM_ALL_ON)
    `uvm_field_int(m_passdirty,    UVM_ALL_ON)
    `uvm_field_int(m_isshared,     UVM_ALL_ON)
    `uvm_field_int(m_wasunique,    UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "svt_amba_pv_response");

  /** Specify the response status */
  extern function void set_resp(svt_amba_pv::resp_t resp);

  /** Return the response status */
  extern function svt_amba_pv::resp_t get_resp();

  /** Return TRUE if the response is OKAY */
  extern function bit is_okay();

  /** Specify an OKAY response */
  extern function void set_okay();

  /** Return TRUE if the response is EXOKAY */
  extern function bit is_exokay();

  /** Specify an EXOKAY response */
  extern function void set_exokay();

  /** Return TRUE if the response is SLVERR */
  extern function bit is_slverr();

  /** Specify a SLVERR response */
  extern function void set_slverr();

  /** Return TRUE if the response is DECERR */
  extern function bit is_decerr();

  /** Specify a DECERR response */
  extern function void set_decerr();

  /** Return TRUE of the PassDirty attribute is set */
  extern function bit is_pass_dirty();

  /** Specify the PassDirty attribute. Defaults to 1 */
  extern function void set_pass_dirty(bit dirty = 1);

  /** Return TRUE of the Shared attribute is set */
  extern function bit is_shared();

  /** Specify the Shared attribute. Defaults to 1 */
  extern function void set_shared(bit shared = 1);

  /** Return TRUE of the DataTransfer attribute is set */
  extern function bit is_snoop_data_transfer();

  /** Specify the DataTransfer attribute. Defaults to 1 */
  extern function void set_snoop_data_transfer(bit xfer = 1);

  /** Return TRUE of the Error attribute is set */
  extern function bit is_snoop_error();

  /** Specify the Error attribute. Defaults to 1 */
  extern function void set_snoop_error(bit err = 1);

  /** Return TRUE of the WasUnique attribute is set */
  extern function bit is_snoop_was_unique();

  /** Specify the WasUnique attribute. Defaults to 1 */
  extern function void set_snoop_was_unique(bit was_unique = 1);

  /** Reset the properties of this class instance to their default values */
  extern function void reset();

endclass
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/5umyBpPM4e2bauZSwo8q13iOhz/VEDLpGAtoWFN+CpIflbrx+tqA6DWOlwM7R/P
XAnxNYv6BzO55vRQrrZdgV/bV86Q2Tn/DivaEgfmfmlQRkf12E8lDeLn7agSpyW8
GNkCSw0v4x043yHwT1VZN4kh0FDdYPnGJjoYqtf2TQu+0395tHIWIQ==
//pragma protect end_key_block
//pragma protect digest_block
fB2WP1+d3dmKodnG0MHkcNZMyV8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
uMvLZOMOtZN2t1jirWz5wp11t54=
//pragma protect end_digest_block
//pragma protect end_protected
      
  `endif // GUARD_SVT_AMBA_PV_RESPONSE_SV
