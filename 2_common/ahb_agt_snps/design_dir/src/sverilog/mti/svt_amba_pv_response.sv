
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EADvp86PtWVHJOlsTV4Iu1xq+j7133/7sShIfRlqcppUG15C77cDpejIG2X9EoGg
dxnE8BfwxmQIhGSI7+/2mZrBRp3BS6NF1IbRIBnifjrOcu4LIQ3tWVNeELAQVE9Y
nSuCYQF78Wijt/xhj/6Of7KO6YYn9S5KZAlf9xuWydQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4220      )
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
`pragma protect end_protected
      
  `endif // GUARD_SVT_AMBA_PV_RESPONSE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Bk6cRl2wCQl4trdrUXY6tbQ+IQemUYrsyKZk8cJUkh90/HJVwM22bumbynoSgAjz
McHLfSvAB6jx7xPseAzA8IIVqUWfiTwi3cAKaJnsozSDng7wJO4cw6Um3Kvlt4W/
pxEbp/N1e3+XiHhz2P4K3lbc3bJOvj3+tUvJUtVDHPs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4303      )
vXcN73prNw53MpJ0QOp0EIY44oUH2L0UKneBbCpjJ6hvLm7aKtRh5H34gr2FxLa2
ToV4G4Db3Mvb4NbP+/qze+9ILsUmtay7VqQpqKcVyfl1s8xYAbIRav5DVqjzS919
`pragma protect end_protected
