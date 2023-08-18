
`ifndef GUARD_SVT_AMBA_PV_EXTENSION_SV
`define GUARD_SVT_AMBA_PV_EXTENSION_SV

`include "svt_axi_defines.svi"


/**
 * Container class for enum declarations
 */
class svt_amba_pv;

  /** Barrier types */
  typedef enum bit [1:0] {
    NORMAL_ACCESS_RESPECT_BARRIER = `SVT_AXI_NORMAL_ACCESS_RESPECT_BARRIER,
    MEMORY_BARRIER                = `SVT_AXI_MEMORY_BARRIER,
    NORMAL_ACCESS_IGNORE_BARRIER  = `SVT_AXI_NORMAL_ACCESS_IGNORE_BARRIER,
    SYNC_BARRIER                  = `SVT_AXI_SYNC_BARRIER
  } bar_t;

  /** Burst types */
  typedef enum bit[1:0] {
    FIXED = `SVT_AXI_TRANSACTION_BURST_FIXED,
    INCR =  `SVT_AXI_TRANSACTION_BURST_INCR,
    WRAP =  `SVT_AXI_TRANSACTION_BURST_WRAP
  } burst_t;

  /** Domain types */
  typedef enum bit [1:0] {
    NONSHAREABLE      = `SVT_AXI_DOMAIN_TYPE_NONSHAREABLE,
    INNERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_INNERSHAREABLE,
    OUTERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_OUTERSHAREABLE,
    SYSTEMSHAREABLE   = `SVT_AXI_DOMAIN_TYPE_SYSTEMSHAREABLE
  } domain_t;


  /** DVM Message types */
  typedef enum bit [2:0] {
    TLB_INVALIDATE                        = 'h0, /**< TLB invalidate */
    BRANCH_PREDICTOR_INVALIDATE           = 'h1, /**< Branch predictor invalidate */
    PHYSICAL_INSTRUCTION_CACHE_INVALIDATE = 'h2, /**< Physical instruction cache invalidate */
    VIRTUAL_INSTRUCTION_CACHE_INVALIDATE  = 'h3, /**< Virtual instruction cache invalidate */
    SYNC                                  = 'h4, /**< Synchronisation message */
    HINT                                  = 'h6  /**< Reserved message type for future Hint messages */
  } dvm_message_t;
  

  /** DVM OS type */
  typedef enum bit [1:0] {
    HYPERVISOR_OR_GUEST = 'h0, /**< Transaction applies to hypervisor and all Guest OS*/
    GUEST               = 'h2, /**< Transaction applies to Guest OS */
    HYPERVISOR          = 'h3  /**< Transaction applies to hypervisor */
  } dvm_os_t;

  /** DVM Security type */
  typedef enum bit [1:0] {
    AMBA_PV_SECURE_AND_NON_SECURE = 'h0, /**< Transaction applies to Secure and Non-secure */
    AMBA_PV_SECURE_ONLY           = 'h2, /**< Transaction applies to Secure only */
    AMBA_PV_NON_SECURE_ONLY       = 'h3  /**< Transaction applies to Non-secure only */
  } dvm_security_t;
  
  /** Response type */
  typedef enum bit [1:0] {
    OKAY    = `SVT_AXI_OKAY_RESPONSE,
    EXOKAY  = `SVT_AXI_EXOKAY_RESPONSE,
    SLVERR = `SVT_AXI_SLVERR_RESPONSE,
    DECERR  = `SVT_AXI_DECERR_RESPONSE
  } resp_t;

endclass


typedef class svt_amba_pv_response;

/**
    TLM 2.0 Generic Payload extension class used to model AXI transactions
    using a LT coding style. It corresponds to the ARM amba_pv_extension class.
    See the ARM AMBA-PV Extensions to OSCI TLM 2.0 Reference Manual for detailed
    documentation.
 
    It is not designed to be used directly (for example, it is not randomizable).
    Rather, it is used to interface an AMBA-PV component to the corresponding
    SVT VIP.
 
    Does not support user-defined attributes.
 
  */

class svt_amba_pv_extension extends uvm_tlm_extension#(svt_amba_pv_extension);

  /**
   * Methods from the amba_pv_extension class.
   */

  /** @cond PRIVATE */
  local int unsigned          m_length;
  local int unsigned          m_size;
  local svt_amba_pv::burst_t  m_burst;
  local svt_amba_pv_response  m_response;
  local svt_amba_pv_response  m_response_array[];
  local bit                   m_response_array_complete;
  /** @endcond */

  /** Specify the number of transfer beats of the burst */
  extern function void set_length(int unsigned length);

  /** Get the number of transfer beats in the burst */
  extern function int unsigned get_length();

  /** Specify the number of bytes in a transfer beat */
  extern function void set_size(int unsigned size);

  /** Get the number of bytes in a transfer beat */
  extern function int unsigned get_size();

  /** Specify the type of burst */
  extern function void set_burst(svt_amba_pv::burst_t burst);

  /** Get the type of burst */
  extern function svt_amba_pv::burst_t get_burst();

  /** Specify the overall response status */
  extern function void set_resp(svt_amba_pv::resp_t resp);

  /** Get the overall response status */
  extern function svt_amba_pv::resp_t get_resp();

  /** Return TRUE if the overall response is OKAY */
  extern function bit is_okay();

  /** Specify an OKAY overall response */
  extern function void set_okay();

  /** Return TRUE if the overall response is EXOKAY */
  extern function bit is_exokay();

  /** Specify an EXOKAY overall response */
  extern function void set_exokay();

  /** Return TRUE if the overall response is SLVERR */
  extern function bit is_slverr();

  /** Specify a SLVERR overall response */
  extern function void set_slverr();

  /** Return TRUE if the overall response is DECERR */
  extern function bit is_decerr();

  /** Specify a DECERR overall response */
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

  /** Get the overall response descritpor */
  extern function svt_amba_pv_response get_response();

  /** Set the response descriptor for the individual transfer beats */
  extern function void set_response_array(ref svt_amba_pv_response from_array[]);

  /** Get the response descriptor for each individual transfer beats */
  extern function void get_response_array(ref svt_amba_pv_response to_array[]);

  /** Indicate that there is a response descriptor for each transfer beat */
  extern function void set_response_array_complete(bit complete = 1);

  /** Return TRUE if there is a response descriptor for each transfer beat */
  extern function bit is_response_array_complete();

  /** Reset the properties of this class instance to their default values */
  extern function void reset();

  /**
   * Methods (that would have been inherited) from the amba_pv_control class.
   */

  /** @cond PRIVATE */
  local int unsigned m_id;
  local bit m_privileged;
  local bit m_non_secure;
  local bit m_instruction;
  local bit m_exclusive;
  local bit m_locked;
  local bit m_bufferable;
  local bit m_read_allocate;
  local bit m_allocate;
  local bit m_write_allocate;
  local bit m_modifiable;
  local int unsigned m_qos;
  local int unsigned m_region;
  local int unsigned m_user;
  local bit [3:0] m_snoop;
  local svt_amba_pv::domain_t m_domain;
  local svt_amba_pv::bar_t m_bar;
  /** @endcond */

  /** Specify the tranasction ID */
  extern function void set_id (int unsigned id);

  /** Get the transaction ID */
  extern function int unsigned get_id ();

  /** Specify the value of the PRIVILEGED attribute */
  extern function void set_privileged (bit priv = 1);

  /** Return TRUE if the PRIVILEGED attribute is set */
  extern function bit is_privileged ();

  /** Specify the value of the NONSECURE attribute */
  extern function void set_non_secure (bit nonsec = 1);

  /** Return TRUE if the NONSECURE attribute is set */
  extern function bit is_non_secure ();

  /** Specify the value of the INSTRUCTION attribute */
  extern function void set_instruction (bit instr = 1);

  /** Return TRUE if the INSTRUCTION attribute is set */
  extern function bit is_instruction ();

  /** Specify the value of the EXCLUSIVE attribute */
  extern function void set_exclusive (bit excl = 1);

  /** Return TRUE if the EXCLUSIVE attribute is set */
  extern function bit is_exclusive ();

  /** Specify the value of the LOCKED attribute */
  extern function void set_locked (bit locked = 1);

  /** Return TRUE if the LOCKED attribute is set */
  extern function bit is_locked ();

  /** Specify the value of the BUFFERABLE attribute */
  extern function void set_bufferable (bit buff = 1);

  /** Return TRUE if the BUFFERABLE attribute is set */
  extern function bit is_bufferable ();

  /** Specify the value of the CACHEABLE attribute */
  extern function void set_cacheable (bit cache = 1);

  /** Return TRUE if the CACHEABLE attribute is set */
  extern function bit is_cacheable ();

  /** Specify the value of the READ_ALLOC attribute */
  extern function void set_read_allocate (bit alloc = 1);

  /** Return TRUE if the READ_ALLOC attribute is set */
  extern function bit is_read_allocate ();

  /** Specify the value of the WRITE_ALLOC attribute */
  extern function void set_write_allocate (bit alloc = 1);

  /** Return TRUE if the WRITE_ALLOC attribute is set */
  extern function bit is_write_allocate ();

  /** Specify the value of the MODIFIABLE attribute */
  extern function void set_modifiable(bit mod = 1);

  /** Return TRUE if the MODIFIABLE attribute is set */
  extern function bit is_modifiable();

  `ifdef SVT_AHB_V6_ENABLE
  /** If AHB_V6 is enabled, then specify the value of ALLOCATE (HPROT[4]) attribute */
  extern function void set_allocate(bit allocate =1);

  /** If AHB_V6 is enabled, then return TRUE if ALLOCATE(HPROT[4]) attribute is set */
  extern function bit is_allocate();
  `endif

  /** Specify the value of the OTHER_ALLOC attribute on READ transactions */
  extern function void set_read_other_allocate(bit alloc = 1);

  /** Return TRUE if the OTHER_ALLOC attribute on READ transaction is set */
  extern function bit is_read_other_allocate();

  /** Specify the value of the OTHER_ALLOC attribute on WRITE transactions */
  extern function void set_write_other_allocate(bit alloc = 1);

  /** Return TRUE if the OTHER_ALLOC attribute on WRITE transaction is set */
  extern function bit is_write_other_allocate();

  /** Specify the value of the Quality of Service attribute */
  extern function void set_qos(int unsigned qos);

  /** Return the value of the Qualitify of service attribute */
  extern function int unsigned get_qos();

  /** Specify the region ID */
  extern function void set_region(int unsigned region);

  /** Return the region ID */
  extern function int unsigned get_region();

  /** Specify a user-interpreted value */
  extern function void set_user(int unsigned user);

  /** Return the user-interpreted value */
  extern function int unsigned get_user();

  /** Specify the AxSNOOP value for the transaction */
  extern function void set_snoop(bit [3:0] AxSNOOP);

  /** Return the AxSNOOP value */
  extern function bit [3:0] get_snoop();

  /** Specify the type of the domain */
  extern function void set_domain(svt_amba_pv::domain_t domain);

  /** Return the type of the domain */
  extern function svt_amba_pv::domain_t get_domain();

  /** Specify the barrier type */
  extern function void set_bar(svt_amba_pv::bar_t bar);

  /* Get the barrier type */
  extern function svt_amba_pv::bar_t get_bar();

  /**
   * Methods (that would have been inherited) from the amba_pv_dvm class.
   */

  /** @cond PRIVATE */
  local int unsigned m_dvm_transaction;
  local longint unsigned m_dvm_additional_address;
  local bit m_dvm_completion;
  /** @endcond */

  /** Specify the DVM transaction opcode */
  extern function void set_dvm_transaction(int unsigned trans);

  /** Get the DVM transaction opcode */
  extern function int unsigned get_dvm_transaction();

  /** Set the additional address in the DVM opcode */
  extern function void set_dvm_additional_address(longint unsigned addr);

  /** Return TRUE if the DVM opcode indicates that an additional address is present */
  extern function bit is_dvm_additional_address_set();

  /** Return the DVM additional address if present */
  extern function longint unsigned get_dvm_additional_address();

  /** Set the VMID in the DVM transaction opcode */
  extern function void set_dvm_vmid(int unsigned vmid);

  /** Return TRUE if the DVM opcode indicates that an VMID is present */
  extern function bit is_dvm_vmid_set();

  /** Return the VMID if present in the DVM opcode */
  extern function int unsigned get_dvm_vmid();

  /** Set the ASID in the DVM transaction opcode */
  extern function void set_dvm_asid(int unsigned asid);

  /** Return TRUE if the DVM opcode indicates that an ASID is present */
  extern function bit is_dvm_asid_set();

  /** Return the ASID if present in the DVM opcode */
  extern function int unsigned get_dvm_asid();

  /** Set the virtual index in the DVM transaction opcode */
  extern function void set_dvm_virtual_index(int unsigned vidx);

  /** Return TRUE if the DVM opcode indicates that a virtual index is present */
  extern function bit is_dvm_virtual_index_set();

  /** Return the virtual index if present in the DVM opcode */
  extern function int unsigned get_dvm_virtual_index();

  /** Set the Completion bit in the DVM transaction opcode */
  extern function void set_dvm_completion(bit compl = 1);

  /** Return TRUE if the DVM opcode indicates that the Competion bit is set */
  extern function bit is_dvm_completion_set();

  /** Set the DVM message type in the DVM transaction opcode */
  extern function void set_dvm_message_type(svt_amba_pv::dvm_message_t msg);

  /** Return the DVM message type in the DVM opcode */
  extern function svt_amba_pv::dvm_message_t get_dvm_message_type();

  /** Set the OS in the DVM transaction opcode */
  extern function void set_dvm_os(svt_amba_pv::dvm_os_t os);

  /** Return the DVM OS in the DVM opcode */
  extern function svt_amba_pv::dvm_os_t get_dvm_os();

  /** Set the security type in the DVM transaction opcode */
  extern function void set_dvm_security(svt_amba_pv::dvm_security_t sec);

  /** Return the DVM security type in the DVM opcode */
  extern function svt_amba_pv::dvm_security_t get_dvm_security();

  `uvm_object_utils_begin(svt_amba_pv_extension)
    `uvm_field_int(m_length,                   UVM_ALL_ON)
    `uvm_field_int(m_size,                     UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::burst_t, m_burst, UVM_ALL_ON)
    `uvm_field_object(m_response,              UVM_ALL_ON)
    `uvm_field_array_object(m_response_array,  UVM_ALL_ON)
    `uvm_field_int(m_response_array_complete,  UVM_ALL_ON)

    `uvm_field_int(m_id,                       UVM_ALL_ON)
    `uvm_field_int(m_privileged,               UVM_ALL_ON)
    `uvm_field_int(m_non_secure,               UVM_ALL_ON)
    `uvm_field_int(m_instruction,              UVM_ALL_ON)
    `uvm_field_int(m_exclusive,                UVM_ALL_ON)
    `uvm_field_int(m_locked,                   UVM_ALL_ON)
    `uvm_field_int(m_bufferable,               UVM_ALL_ON)
    `uvm_field_int(m_read_allocate,            UVM_ALL_ON)
    `uvm_field_int(m_allocate,            UVM_ALL_ON)
    `uvm_field_int(m_write_allocate,           UVM_ALL_ON)
    `uvm_field_int(m_modifiable,               UVM_ALL_ON)
    `uvm_field_int(m_qos,                      UVM_ALL_ON)
    `uvm_field_int(m_region,                   UVM_ALL_ON)
    `uvm_field_int(m_user,                     UVM_ALL_ON)
    `uvm_field_int(m_snoop,                    UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::domain_t, m_domain, UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::bar_t, m_bar,   UVM_ALL_ON)

    `uvm_field_int(m_dvm_transaction,        UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(m_dvm_additional_address, UVM_ALL_ON)
    `uvm_field_int(m_dvm_completion,         UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "svt_amba_pv_extension");


  /** @cond PRIVATE */

  /*
   * Constants used to abstract the setting/masking of bits in the DVM opcode.
   */
  local const int unsigned VMID_MASK              = 'hFF;
  local const int unsigned VMID_LSB               = 24;
  local const int unsigned VMID_SET               = 1<<6;
  local const int unsigned ASID_MASK              = 'hFF;
  local const int unsigned ASID_LSB               = 16;
  local const int unsigned ASID_SET               = 1<<5;
  local const int unsigned VIRTUAL_INDEX_MASK     = 'hFFFF;
  local const int unsigned VIRTUAL_INDEX_LSB      = 16;
  local const int unsigned VIRTUAL_INDEX_SET      = (1<<6) | (1<<5);
  local const int unsigned TYPE_MASK              = 'h7;
  local const int unsigned TYPE_LSB               = 12;
  local const int unsigned OS_MASK                = 'h3;
  local const int unsigned OS_LSB                 = 10;
  local const int unsigned SECURITY_MASK          = 'h3;
  local const int unsigned SECURITY_LSB           = 8;
  local const int unsigned ADDITIONAL_ADDRESS_SET = 1<<0;
  /** @endcond */

endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RftuGbmUJnfBKcsFJSs7ZMX6vcGgj05BfsVAuWQmKZ7rF1gbwJIioItj7J8daNnb
L8ci5CTkFk+0JrhY814V1V55Pvt2apuMRUQSLgwAsFxQqtMTHflOZ4+DHaM8Aizg
4RSRzn62QshOhJ1vE1VOtIS6UqV0DWiLNIEI9q5O5sU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20052     )
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
`pragma protect end_protected
      
  `endif // GUARD_SVT_AMBA_PV_EXTENSION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SQloe7unjp9Y6w7aKFlPCd4wk5rKzPSvaakLmlGVIivsCEcD5bDxDfoYePMUeDpu
CIs/udMzQe5KXu8VKyI7nc7pAA+MTKGh2P2JYc8Tx1Ah+DKvHx1KrLV3DLgxuTVH
AWH6Y2H4ULgpYSFX4x4P2U0Rx2sl1m+76JpKmkvUQ6Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20135     )
vOi5v8f9rPftoAgVqJeEqq1MU+eBiFPxitPVaT5zGBg2OWurUpz7losNEtYtqs2V
YVVkygNMq/T6ZjPrKJJOiw9UZ0X9GH5p2QdUKsUiwOwVQ1zx7LnSAOWO63boh1Wq
`pragma protect end_protected
