
`ifndef GUARD_SVT_AHB_SLAVE_UVM_SV
`define GUARD_SVT_AHB_SLAVE_UVM_SV

typedef class svt_ahb_slave;
typedef class svt_ahb_slave_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`endif

// =============================================================================
/**
 * This class is Driver that implements an AHB SLAVE component.
 */

class svt_ahb_slave extends svt_driver #(svt_ahb_slave_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave, svt_ahb_slave_callback)
  /** @cond PRIVATE */
  uvm_blocking_put_port #(svt_ahb_slave_transaction) vlog_cmd_put_port;
  /** @endcond */
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of SLAVE components */
  protected svt_ahb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;
  /** @endcond */

  //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
V6ppekPq82pseBB1s8EcJl0h+EtTqQGJ6F4Y8rXlK99hoN+2uAMKbuPcPlugvouX
6rGtValJn1EnH803a0MuKbi3IL+Hj62OT8cFBJWq4yEwsXcSZFgk5EtHpRTgnFiX
s73ad+c81bHIsQUpp8Y0/JXWwY3e+VPo3mC6DvCeMGwvFauCRqaRVg==
//pragma protect end_key_block
//pragma protect digest_block
VSaSq8AmR96+9756YXlp4Rv9lU8=
//pragma protect end_digest_block
//pragma protect data_block
Gmlypv3vjyaD8ev+I+YZG5RW6rnWhiaOprmg9Fa/We2Lh34B8rqwy7h862T8hkPg
oUwvHJUcIcNyauczR+/hY77ofsBXMdkWziW9hv6lyUolb8yJ+CpcRoWE02KBPuy+
BfEiKeU6OjrsvSZYfn9rcvjX3ssDKvySIqiFHpWch/wNUqigwroDuQcoihnwZ6gr
rymM62FOV1hlChnhbl/da7iLPRUQVg15DiLuiC7RY7ExVIg83giykDkpa+mwwFcd
fttl2ETtHZBapdfWELhh3kcexPTYPkD33MJFThrW3EqIBeDI3OvUvoqHq/t0sthK
2cFS4JpZpMHNyf/HiGIpMTRJ9/8O+937iHeAwbHakra4HNrwKJNmzBXLlX4FxVE8
Yx6zWBb5FsFghZPjNlzsTQVLhAsz5ETe5B0aFTBTC9gzuAH/gLWmls2Gh6JIOYa8
Bbu622O9I0h9rfYIGH7aBr//Key6bp4uX3CxaRZY7zZCeu4mbPZwLtOmTEjOC9m5
th806smhyRFX90FVZhkvohxkoOExgdeO/v2+anO9ZUGQNrtiiYu4lNpVziTwUvVt
cqRLBc6a5m828LFw1P04bWm+gCQRAZ9gOvOcDlg6f4m3K0lA3GSCEy0sVaRe17T0
IqpqwE73JKRkHxSazwpgULSJr2G4yiOV8Ctji6xYFF0SYKoXp11Hmq8FVp72ZTJu
Id9EVhpr1FaFkk27xdbyKNxm872DChAIb+fSvDagk+HyUsLE+ufn/ltz8tc7MTRQ
m2W0lNVv9FiU30eRIZ9kLePZt8PUOkENDmKXnCXUN7dlTehewMCns3slWBGFMvNC
94AovCQfj5H9ZRuETvymnD1BU9baiG31eQhEEerRDORfoLqsLnPTJLr111vkcIAj
/VP4I0n9F8dwLzDPBcbiDFDhTV7rgaBO9twsQezuh2vV18zyu0vXpEXrW5/ZxRut
9Rv/EP+Budg3ObBTdr3SsCEI57h7RWtbWXw5Il5l4JlmUioJz9LCiy+jer/iOzL5
mpiHeK+FYFc04sFYicReoK+XkKsetNs/7Qm1EPLM18bKcV9COjTam1/qK8sijrSy
rVyFpSRg0CuXWf8kNwFlJyV3nX7TGWbQixuWOIIcgTYQhrabltvdcnUSff2PTIzZ
pdw+1ZK4bvBfzVfM+txebxonx3l2Ar2vel15XQTYiMMDTC6wsEbseHw5zxV8UuCE

//pragma protect end_data_block
//pragma protect digest_block
pHrhYHcyqf482YvlegGQiI7nUt8=
//pragma protect end_digest_block
//pragma protect end_protected
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * End of Elaboration Phase
   * Disables automatic item recording if the feature is available
   */
  extern virtual function void end_of_elaboration_phase (uvm_phase phase);
`endif
  
  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern protected task consume_from_seq_item_port(uvm_phase phase);
`else
  extern protected task consume_from_seq_item_port(svt_phase phase);
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_active_common common);

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_slave_transaction xact);

/** @endcond */

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pcwQ0pX6eZ3UOvfzg/RwbD6FyEMqZnHcCYSwTY1N7QE79jo6GFc2G/pGnfVj2Xs5
hgJqS7Z58qtgkMBNMGWBz2v5BRHxIpJIWXAg6NyU5jS09dqw4msOafZd5nLCrCOW
te+c0ekf0RHyjda33QhkQTebEKCorXhKzNgkxsL+voqnIn8R6SMaYA==
//pragma protect end_key_block
//pragma protect digest_block
v4ZuXvldAXbymhet/zFqbjVgJI0=
//pragma protect end_digest_block
//pragma protect data_block
jfZn6vOWidE1sXRhZFmfadF7RW5Rq1Y/8EXkUJ7R2+cvY3kNBEgvPrqopCCQdqfO
i0V6Ynf/0G0n8KkgCtAQfFVTrze53Qz0xVFb085gOClRLvpHqNgcjf3q4bp3a8uT
TKREJ25NaiYHJ/LfHruw3olRo80DRmyHo0jrC1Ex88eF6M2W7tUl6/Zz2tjfstsY
7U9HAucZaJwu0U0+hIey/9eRRLSWoidZKhvqScoUGpv5C1wN0GbugjwO56rKsCGF
daIDhGtKQayTKyDIgwA/i/lmttfm/ETS1JwzjKxqxkEpyhiG8jUWiz1NDL34ezf5
DNNhrxL8h8C51Bqd9tEWEtTnfAApavle9t7KwsxsM2JtFM24g1QdCS0s2RwZWC0q
mdl8HgigH0t5BibU/NgGu6pl3hABx6UARn3VPzBnU9uv9aw2hzRT9RfQ0euF6heh
dv3P6aIU82zCGhXD5y+lN4hebstAbhLB8Q0k5aYYVdKV6wXdHmWHW7iAOA7jDKCc
KqdNc/jfh4K6199TpR1VK/SictzeA43VTB33YUzBzVE=
//pragma protect end_data_block
//pragma protect digest_block
T5ur9UcTXkmgf5nFpspchgSDnvg=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PKZzqYipXa5GxOAJBy+M/930gJLLYrxsjooq6K9LdDRS25Ww9G2yGp79ZlCVfSU5
rRTEKgym4dqTJwEVo/aMiIBXSqOFWYvda21gTI0hxCzYasm6ujUtsr4EagtTO00K
re3pvudbIPiQJRKtDGrzMi30EqypeGQP+UyA3N+gm9f4AQctzaaSpA==
//pragma protect end_key_block
//pragma protect digest_block
yNr3vxZ9RsYW8F7f4liRJGGAxzQ=
//pragma protect end_digest_block
//pragma protect data_block
6c8FYPoQ8LImTDK3+wbmgxIndrUT841Z5Fi09sMjLM749niu4Z12Ns9tz5BRvqNk
ExKy/keZ0pQ4mJ154uHBUHAA82rf8v48sLe22Kn8Cd9NPQlWytL8Kn1fIgNcgE5W
RO4SYoBFKdm4d7Im2XeolRa4JA/hqx6i9MUCoVN1ySpYkHmfuTD35fkzdFxHWV9c
5X28AMPqxvNziK0X5coX1RLToCOGK6sZhmvwR33/4UmI3x1ErB8vETPNMijIeE3r
cvNAqznXRtk6xt/gUtYmlDs70m4LTcGrL7Nx80ujlMOC9kHCyEF9o2OP1igxzQMf
E1inmZaf26gV94l3+fXCVMPPaYh0kdTi32jeIhrcISJtlzPBLfyrp5jIg3DyEAOf
RyNI27PWlfVBN1cA7T6D0ChVNMubpA3I6BUAyKowvpzzCPxb76AVIL2C3EE7a1eW
v/t6J97WhSOPJSvcKmrP64lNxZS6biT7QxdqEuVJFNvV+IaEEg3399Z9KAA4KRPL
2iPzhZsBcln6ZGEnyAZMxQ9PAMKWvGRXQv/NM0iIlOUSC2S1+rk2Ld8VewTGWdGR
a34DjFgg8XGOXvsqR5gSVY2dKZMyFO1v8CKaj5osEe2l9yEluUXgqJztKeSlGkq5
JN2nkvdiAfq80syeHJLaa/9X95Qsd6muC1I+BMVO3ef+n8bPRSAyFlji0NIycu3I
qi2bHOE7CpxEZoN6KApAGPDAoemzqlq/UNuwZsWj+UPThga4krRNDfdP0lKNk5KL
XC71pcgi0JcHIySpv8uCyA==
//pragma protect end_data_block
//pragma protect digest_block
9BMzfL4T51Hzm1rvXsGpfx6l3SQ=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+YpcdpPjG6nUhxog/rR59zcadT9LAV2J0DCNl3x4qOEj0Y69tE2VaWOA1g1B5emy
3k8PrCgJb87IT7vnxvF3UW7IzWK9xJe1A1+VInWD2lZvXEBt5GcK5SqcQATHT8+M
xYzheMHRfHMNDf9OLbm45j1lteVGkPGlgGYldhakoRqqpVLP88szYw==
//pragma protect end_key_block
//pragma protect digest_block
abm6dj5tbOyfpGrHKX5Ke7MvgKg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
XeFe6newomNDHtVp3hE9ZoQ8c+0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





