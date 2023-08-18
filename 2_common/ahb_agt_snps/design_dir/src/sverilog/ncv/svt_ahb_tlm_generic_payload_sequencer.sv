
`ifndef GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV
`define GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV

typedef class svt_ahb_master_agent;
// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_transaction_sequencer class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the svt_ahb_master_transaction_sequencer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_tlm_generic_payload_sequencer extends svt_sequencer#(uvm_tlm_generic_payload);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_configuration cfg;
  /** @endcond */


  // UVM Field Macros
  // ****************************************************************************
  `uvm_component_utils_begin(svt_ahb_tlm_generic_payload_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */

endclass: svt_ahb_tlm_generic_payload_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qNAaOsgxj0S+efcXLoAi99VdHUJHQi5+KHgqS3Ic+emgaJLj6e0kLbyIrWAXMYu8
sxiuZqLy1ngpeGz0SNbXTi32HIuW35pd/+WntGqRIqlQgbvLvojsL9tqWTcXDPyG
nNKfmaVBovLbBMbtEdvKqmSqvHpW2N9H7l+y8uLhrimMlpdKlt2mow==
//pragma protect end_key_block
//pragma protect digest_block
cA/lac1QUJTXfTQSPsrJdJHVJ1E=
//pragma protect end_digest_block
//pragma protect data_block
cu9HzZ5kv8Qdkr0u1UPn4hyJbPqgukOegEkxjjWA4dUCCeDw4qt1u4uKOcAlFZvG
v6O+qt/R0wsT2GZexDbdBMQ9EdFQnGY8yUWm1tMYZkXhE6CgEwg3WPhz6Q9SQs7S
FggLy88eOf+QvGvpgetG6l5dJE+3j2nkGxRkTNi5nHWpS9scxPwav4FBGmhHzC+G
mfDt7ckqNvNKxAIwdOMTS+QdRYObfmHnFKgakiIJ/shW5NoxfVD9+tYC683aTdNY
LGXQbsnivVB9LF9v65R5AAlhHzeRBen+/n28xc4W0uNXVXMS+Gc+NHff4qOb8I/T
4/00LiA3PHT5OzTFIFX+QoIGXqlxE0u76s3+QskPh7Dzm9Ws6OsQfS2fPSGvor5C
clMGAqD/jqq1fTXmsWKmLrnkRP1RMlKFzLVl3usder3HVt+oC3v8qvY84mr++8Aw
yD2ygVgZf2UwWSqXvCl03HuhpdNL7wKneeANHIYjZ5KyLqLRaZ1px1+zpDUI78c5
7xDX6+VSAgkGZtwwJSb80WjzeCfnblRYMCb20oqTQH0TTVgIrQQJQx4cT52s2uJs
J32YvkOShc+sOUqcPW8QAq5xHaR4zKyds6m63/d4dNZq8Zp/Mn3qFyu6BwxOlP12
oUa7Non2tyHEvX9PY4OptSHc/tZx5seoA/hJviLfenE7Iq6ra5T6rQjj9D3suCLH
7hQigxXYnKBvlbF3Mx7pANn3wgcvGfHcnZVvNnOmRvHI4wsmoIztR6SPdQpjmtTG
qNWdCJoTFRHAKtD8FKRiWK4dND6A9Jb+h9ZR1qvgZ0X462uI2G2yXZt/N7IryVnT
WC92XBfigI7A/XSp2rUS+HG/D18O+exm8yGn1wmDlaZ/0HcEI8aygDsJKxFl9KJl
Xd5+hFBB59Weqf+rUR0eDbkdImTv6ANCHHhePuv05oQVctK7BjhA/17m8FiIfhwB
zFpo9rOn6tLG6bT4dXVJLc4GBBALoYt6LqV1mB7qiQmiqwzyZQ/+bnq4O2YVRjWj
/j68YRSLvAhm+iogsjqCnEI89nwkbmYncd4U+WrEKWE=
//pragma protect end_data_block
//pragma protect digest_block
u/7wrk559LsBiAYdiglNE+0nI0g=
//pragma protect end_digest_block
//pragma protect end_protected

`endif 

