
`ifndef SVT_AXI_IC_SLAVE_TRANSACTION_SV
`define SVT_AXI_IC_SLAVE_TRANSACTION_SV

/**
 * svt_axi_ic_slave_transaction class is used by the slave ports of the
 * Interconnect component, to represent the transaction received on the
 * Interconnect Slave port from a master component. At the end of each
 * transaction on the Interconnect Slave port, the port monitor within the
 * Interconnect Slave port provides object of type svt_axi_ic_slave_transaction
 * from its analysis port, in active and passive mode.
 */
class svt_axi_ic_slave_transaction extends svt_axi_slave_transaction;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_ic_slave_transaction)
    local static vmm_log shared_log = new("svt_axi_ic_slave_transaction", "class" );
  `endif

  /** 
    * When the #axi_interface_type is AXI_ACE, svt_axi_ic_slave_transaction
    * represents a coherent transaction received from the master. In this case,
    * if snoop transactions were sent to other masters corresponding to this
    * coherent transaction, #assoc_snoop_xacts stores the associated snoop
    * transactions.
    */
  svt_axi_snoop_transaction assoc_snoop_xacts[$];

  /** 
    * If the transaction received on a interconnect slave port (from a external
    * master component) is routed to a external slave component,
    * #assoc_slave_port_xact stores the corresponding transaction sent to the
    * external slave.
    */
  svt_axi_master_transaction assoc_slave_port_xact;

/** @cond PRIVATE */
  /**
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating master. This field
    * indicates the parent transaction from which this transaction was split.
    */
  svt_axi_transaction assoc_parent_xact;

  /** 
    * If set transactions will be forcefully routed to a slave, 
    * irrespective of transaction type.
    */
  bit mainmemory_data_exception = 0;

  /**
    * If set, one port which should be snooped will not be snooped
    */
  bit snoop_routing_exception = 0;

  /**
    * If set, the response to a DVM operation/DVM Sync is sent
    * before a response is received from all snooped ports
    */
  bit dvm_response_timing_exception = 0;

  /** 
    * Indicates that a write to memory occured after the interconnect
    * performed a speculative read to memory on reception of a
    * transaction from a master. This means that the contents of memory
    * will have changed after the read was issued to memory and so the
    * interconnect will have to read the contents of memory again
    */
  bit is_memory_update_hazard = 0;

  // Triggered when the assoc_snoop_xacts queue is populated.
  event snoop_queue_populated;
/** @endcond */

/**
Utility methods definition of svt_axi_ic_slave_transaction class
*/



  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_ic_slave_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_ic_slave_transaction)
    `svt_field_queue_object(assoc_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_slave_port_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_parent_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int   (mainmemory_data_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (snoop_routing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (dvm_response_timing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (is_memory_update_hazard,`SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_axi_ic_slave_transaction)
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_ic_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_ic_slave_transaction);
`endif

  constraint reasonable_ic_slave_response {
    if(port_cfg.sys_cfg != null &&
       port_cfg.sys_cfg.posted_write_xacts_enable == 1) {
       bresp != DECERR;
       bresp != SLVERR;
    }
  }
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fmGb0hscNYy/3ZcgQ1DUPdP9DJBEBf9QKwgrkbx9DgkUCt8qGLYLjVriN8ROUBhw
yinmeA5u3W6C22H+9q6lmtVPkAlqbkqfJLvZHciJu322NhxfWZZfY9wdEYiB2jba
hHGM5QH49xpKvcoKov+Noxyfu9Oebpl38rh8sFhB1VJc+N9EFbpWsw==
//pragma protect end_key_block
//pragma protect digest_block
coMf/IZzIaE5rXaY0Ail0OqfmKw=
//pragma protect end_digest_block
//pragma protect data_block
FG8Vp7Bd6aLJ9QPlTXRK+/22Davqc638TRosNDELmLZxwbbkOcdyb+5Ss5MsWFqd
3E4kOSo+FhexoL1mPLamd3Kkht0E6WrTqsgP9IMe18w5dsoSaM+wzr8OaaMniDtb
axJQWWRuEUFZuFVR8jVIZHg6MHOm1sRF+6Sg3qRQOCoKMuX6x42WLXUfaaOXtQjm
/JD/Wl/f0j/aakf27EHGKJhb53VHgk7v+lIlvmXih0FJAHjKr20m+DXMmn/76Oho
nDrz11Mw6uphR0h/46+Bph5BEX/Cws+sGwtF74N+IhV3RzZ+bvr7KJdbpe7T6I+4
54iVnnnBZrBHWb4ss70kR0MHm7Bl+WbEYkQKObdigW5IOjxZovqVvXyloMkgNx2F
MuCm57QeuFDRSOFTapvKJCNS6QriZOxw7cR9ta5ZUwY3mwwYEBk5XFb89FnLM/xy
4SxTNshbcoklB+O7ke7358W8doiF/hQAxBxjmsNsc82WuYKCIo3DdrItsIKPZRXB
qj4NkK6xgOPh7TGit7mkqL47Iej3ZGOy/8BLuAxJcqa8zt5+P4pIEm3Lz7/eewRn
i7wd34K+Jsil5dnBPXt54YCmwvSn+BNlWN4flQ5gDsbb84KOEndk7PxJhc2ZRxtH
Eelyrs0Fs4UfOeEnj0DavhfrFBYALLCzjUs9bDEDLK0QJwweLVw/MGDRaAdTz6Vf
Wzmd45F/qE7GYAqnqxU8MyaKWgjV/WsH8bi8h/68OLrUV0gBLL4e8x5UzLn/6H76
b/N1oJlebBj+zoxJs5Ye35l+rlspCOznix4Euu7csOwWfi8Wrhy2FAsJUqe4mnmx
yhg9NYJBPk3VTTGrS+DJFbIuRfz63nOLz+uiZfsodcy4Rl4ShPTAR53y3ErbV374
swNSEIfEU2L1+rw2P5ewzhwl0VijMB2Vqq1bcPWVeuR0p2SejAvgH9RRnmQT36gB
s4TfPgmVDxou/ooBOKyI9qv+qW+dqD/PMsUB4kF83XDPW2cCKfJBKVT4AH/YqOYa
jc3Hg5ZYQJqkVGKI5kEsXeNX8r6lJ6erz8vkMdeNKagVPjU8gAhtPvGF7PuY4bTE
TlMo/nKHJeO9FqpbL3CJAXQSXpRTAKuns5XeRHS53mPRPfA+0XMnZRwMSaVJB3gn
3jURd7YcIYWxQ2IJeU12J+joLclHuHX6Jp8zbwNeWWrq/8qLjMAAFWT0QrrUK/Gx
l8Bc2THIvis/b/3nBO7a74FGA+LFQuCNGurdpBEyhLMrmLE/Y66qD+HI9pbtdchO
1HiVgFzRdsIak57now6jBugB3DIHAGZ9G+rKSM9ckt8=
//pragma protect end_data_block
//pragma protect digest_block
B7YrrypPcy5Q1ZwC+OOsS1iZvrg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DQMu69SDvuffauMO3wiyo9HUlZ+EAJ8DrNJw7poUHNqGXW2D3GkA1uTCuaAknQu5
xAtF0TobLm+QBDOZ1Tpl27TE3Rr1L58wTmvpjme+FKBMGRkF73wprdc+YmmPJ7J1
ZPdt1AXA1mpSVWXOLmb/KkvYCbfcQgeAZYVUBc/RC5AKLiZ2memxzw==
//pragma protect end_key_block
//pragma protect digest_block
O1gaFzKBEZMMpTZCdDxNkCZFGTM=
//pragma protect end_digest_block
//pragma protect data_block
EO94epYLHPlQi/tSIWIzqvB10fLOeBL5iSOQ2Hb6kKnRnjGRGfDDPPu37iZAmeis
TTZ4Zfhgky39/adKDVHmfbuDOlB96VRI2nA4+TsBclatsWRAH6cg52OlB2/WUgmd
FxPOkmOqSWDP1/Osv7vWJ6WaPPSKZP/gUU9u1Hg/ZEp8hAdGHwKZayMO9W/pToQ9
IMZrnF2taNi/DIXd8xa/mIh1aCTKhCvpFck5dfFD21bmi7IF6RjvW6lrebyTeMT7
UePTX/Fo6++rA0RiJYG8RehzPNoVBGOJ19V87O/sLY2ox48jbdKvMaeOFk1uZMSI
4W+CW+TkyzExFrdmYz4C/PSzZJg69hmWfavfvzt6B1SQs9cXDnlXFNFzsNq8k7Df
UxZlCgK4OD6A1jHIqSqQlA1US2yBsQrvAhigIUvvNtWkjbGepdWuc7LNJUIan6IS
BOI4Q+093Ei1l1/wnd+xjTc6v/WeKFg0kzgiFqqB149rbj0NWcI/UJmaxIqUOrg2
LSQJSoK8ZvbPRbzLBcRUFswfk62//6+J1F1GaaMpZ9UcFpP8okCXuqMBDb4aH38T
aOr6ECTFGRrX1BBGq4223wTRIRI2IxWxSZqH2BpF+cNzxkL+/qeGGI5LrZ/CH7f1
g1pc+SnK+Ochs7X+1SYsbsJFjnsOCxwyIU8uoaVjDtZSumUxt05/D1UnMquOAloR
64DRsFksRSSVBddQZQjFmtR3CReLvHSqyNPv+CTKx3JX+iUhBlerIv/7EpQSStqJ
kador1OKqs/97S+sqr5WP7aGNVRLqgOAwKPOjfYkGHHbonLPA+Rcwkuyjtw2iBKe
/eBbT4IpBz8kvhW5rOQ0cB21qqmI8bW6UL/GKgzSWpeWLnwQ2K/YqX7T9mU76Fgn
UPFB3ZFQT34ERVbGA+Levtw1nOjIghpi/fg93XdOP1vawWpYO63Y2Sr3BhgUWvvB
eFCkYVM9ahQUyFOCaEKIuhp6bH5jFT/5a68GVEK1BZdr7dZQ7fvZ+GhtlXnOXCHQ
XJI14qm/V6U6eG24+GtgpRRxTwHqpl+RvDb2CJwpxRXAPEVSz1/aKDH+gRaN0Xnq
KMntF+i53NMmq49dZicyOLiCgiSGaWS/2Lb9peh27rTQD11ek0glutUYiCgCDS6Z
ru6lmP9Z0804bJoMhuRHMA==
//pragma protect end_data_block
//pragma protect digest_block
kufmOqmbY4tqI+y4JEwE2dTn/ag=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_AXI_IC_SLAVE_TRANSACTION_SV
