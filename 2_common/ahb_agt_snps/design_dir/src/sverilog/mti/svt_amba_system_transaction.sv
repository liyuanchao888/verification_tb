
`ifndef SVT_AMBA_SYSTEM_TRANSACTION_SV
`define SVT_AMBA_SYSTEM_TRANSACTION_SV

/** @cond PRIVATE */
/**
 */
class svt_amba_system_transaction extends svt_axi_system_transaction;

  /** Enumeration for type of interface */
  typedef enum {
    AXI = 0,
    AHB = 1,
    APB = 2
  } protocol_type_enum;

  /** The protocol represented by upstream_xact */
  protocol_type_enum upstream_protocol_type = AXI;

  /** The protocol represented by downstream_xact */
  protocol_type_enum downstream_protocol_type = AXI;


  /** Handle to the upstream transaction represented by this system transaction */
  `SVT_TRANSACTION_TYPE upstream_xact; 

  /** Handle to the downstream transactions represented by this system transaction */
  `SVT_TRANSACTION_TYPE downstream_xacts[$];
  
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_amba_system_transaction)
  `endif

  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_amba_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_amba_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_amba_system_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_system_configuration sys_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_amba_system_transaction)
  `svt_field_enum(protocol_type_enum, upstream_protocol_type, `SVT_ALL_ON)  
  `svt_field_enum(protocol_type_enum, downstream_protocol_type, `SVT_ALL_ON)  
  `svt_field_object(upstream_xact,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_field_queue_object(downstream_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_field_queue_object(partial_associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)  
  `svt_data_member_end(svt_amba_system_transaction)
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_amba_system_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_amba_system_transaction);
`endif
endclass
/** @endcond */


// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pO7Jn3gRUYmE0/3liz1/Lc/Eba865oI2dxht4FoBixQtSEtH0HqsrQQYC6wjdWLM
8NFS3cE9daxYfcRLe77JlVeufwm0jVWXAJuEt8U20JseMV6QE/Lrn0Gv0xPla205
70Qc4W32gnAOkoGtzGXuoh9lX7FdbpC4Cfk0WzVgr0o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 681       )
PXZtXHTY9AHp4pB/CC1uo9UWtPnQizZjmc/LE4nAMdiREti3/HLLDzBqwKqaQdqH
k01vg8vGAaidvbOb4IlWkaBx8l3anZcZLoElGYwwloCWO1z1+w3zfR/8mL/6wfKb
/LP5oniWZ8fOtJIpH6YzUfi98UvESYyJ7jFZrK2vgrKK/BnDeyVdkdkCUg7Kokxd
LD2+IE69byU2vqjnqRa7dbJigpib8ceb6ptjocYZmFc7kpIBfBMahVVTVWZHKX0b
ivj+R6BLMd7nkNYO4QYKUhBJrzBtbKwxFanFbSt+Y13/NnL0kKnLFUC+SZ45vWYB
GjRLSffjJ3l/n2K3QY5T505kfRkoHld3sYZVc1xpr1GQIJ1/EhtZ2ZUvDY0ChIDU
hTIZPdbyfI/rGRFZ2Fot7LRy02BcebY1j/5WhSxG9sGb606ersNg2Z2lvnsrZpvW
pXYdTiCEtoVeyuBXEPEZ/DsU+alNDbTo1CfhEC6mmnL9sS98g2QQdAuiciIZS3w+
wFy+AhIbiyrz/mX6ISTHjnyFr3ke0ftLo5OqHsCyJzi86a6McBbEfn2tUknnOP8a
pwYqEF5go44E1v/5mg4f0EqQD5eLMTbfsEgRCnV59zXeXskvbPD+478JQREsDBwr
lonpNpIvdJXxkLD6BuqLn62NXas0v5LERbNsxEgtPWwaYOgg5Kcd131rc5STikHO
gr+S7o+hr0AHa/hHQ3SyU+sMzEYkagmoxMkkuCj5IqQ7YLySJ43SGzqtMWEmawor
E0mfHup1CrZFrd/SPJX0VHnp0/iV2lcCuvVmYPnJQh62v2TUcrdRHVLQDDy3mWEd
GZ31sAfi9QhHjZog4VBNk7sLkvh91eWbyqK94XgeV6x8WOdBZBxGNR5XrUGfuOfS
a4aWapAskJoxF+pmm9h2Lg==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IvY7Rn1D0VdR2vgeKn04pob49+V1OpW1yfevGGhOxEFo8jMngIzebllMlIhoH+5A
XyYgYgNsCYswhvY1pZR+u26OeWQ0/kZKxXPKnobxSbDbtXdPg02lLmN/jWZuurOO
2qzLBi5RAmajqGpYsXVSoJPgHFgC+r5dfyHpfoKuEMo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1380      )
SQATypDMNgiJnPFPrYnHC6JgqeYLlrCJTx02OZoOeKVcNKa/WBaE/l+Mh9YiJ953
cQY1CoDszrDZV5dLrmop8LLxVTjJDi1JV12iJOrDZM8vgEIp1lIply9m37JmVRGG
Er0BVOxo2Eo10yq87mjIpxLd05SJlUxlZ3PKQQmsvGVG8W1DmK833Sz1xS47tMbt
qRWZQpJxo3F3//4T0+xNn6jGApB0hVU5FOSiLhCJp3MxZiHDcYjojh/Id72d3g/u
32OjGxv0SLuSKclOER/nbUOCZNJ7Ihx1k6jydOFVjRD0P2U57l3MGrzXncTyux4e
uKQgCa94GCIjIIarLwypIbGbGfrpAWLx5T2VINlRKvlyLMYjn23t22SmNML2m+Vt
canS1Kd2Y4Ui7WLnwEqCc1NC/mUgNvkoyuwTHJqOnA5IYEX9yvgiajn5UnpV75l2
LOptm6lRAIhwmEyPVzbHfVuT5Dz1L1qSpveFaXndkfSEKvytvGfG+57IBUmFgetX
ZduYizLUE1EqOWn+66RvqsfAEkYu8npnXuROcDIDDVtqDQKSOdOYPpUV9dUODUbY
em4RmFIa/KUuTGi4jn6XXztuZLeG3duzLdSnLlObuNFsSkxjJ8HS5Gx6LxfaiFUq
9mo4cnnrXKmRm4lrcC+s0S4BPt0t74lxIaLdQnAEeJGWun32Mw7tPvBeOQxd9X3h
dTRnGsLVK9OWuur6y8eb5w6hj4mVJXhO79f7lnU6WI5LsmPqR1NI2pCB/Vg5wwZ7
UDZJGqZqGqUb2WxH5zsPYhNEWpsQBjnsOKQJL0yqQBtCKwR60jEDwf8OvU7TKdKk
JSb6BJisdjVoBsotG0DS2sGMnzA/JMOiETlPGf13VUQLW8qUrYTw5/SBqvpzaS1Z
9U8k4Uqy0tNl3gaspTQ44m8mJeKYxj9t5iw0Y7zQNtw=
`pragma protect end_protected

`endif // SVT_AMBA_SYSTEM_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aq4qLHNcRy3Uy9f/YnVbWTeQvhaxyRxkQs47R58SVHUWEmmDFNyRqJbkxfbIPvdG
onaoqDlAO5gjVOCD46BaQQJjlzDOXSQGj4LFPdHym3+2XieVFW65pwFVFctCo1x7
O6zMvIxnmGYdGvq+c1oPuaG4uOMBPZy/0DXVz3h1jBA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1463      )
nzc2hJKKd7kv3ippk0CjNd7vyjP9TcZI0PwEthg1z2aduGAVI1ukfIWoZlFFYwM+
TE65vtIpc+SzZsmlzCh6+C0oCzJ4v1C/juuVX9huJCXeDkj0R4WxmAwbuzeY2wvX
`pragma protect end_protected
