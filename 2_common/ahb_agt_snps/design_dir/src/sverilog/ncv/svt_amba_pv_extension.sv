
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sG+CVeIk+qwiTaGVZwOTDnCHLfK+luAFFqQ+DyjxGkCuqe6fXSXbVYx7UuDl6wF0
oUyt/7LauHC4//ssKvf9lwpG3bLqJKwgySbF+Ytp1z+IqmB8gDL7UvXf5DCWk6kE
PJoIUzAkYpubICxIU49dG/uzQ/1XxI21IlPsnEas1R6qH0JaB+8KrA==
//pragma protect end_key_block
//pragma protect digest_block
tFC0BYgh8PdVDEuBS3tt2OIWI+k=
//pragma protect end_digest_block
//pragma protect data_block
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
Sqq7fGb992F7thorw8ODRw==
//pragma protect end_data_block
//pragma protect digest_block
xequuMycDsTy6GQbfg2FYNTKYAM=
//pragma protect end_digest_block
//pragma protect end_protected
      
  `endif // GUARD_SVT_AMBA_PV_EXTENSION_SV
