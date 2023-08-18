
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FKntIpv9RPrCG6OFLRnAllE2H2CbIwoGpy18VuhM5xRi7uQGitSLBl56TRDR4Vki
CHXKvTAPNG+3dXL5euXMI9NXrazYVSOudZ0reN4PizQSGNPCVaCL5K97iq2P3Q3t
+SETr2NPeDPC8OTz/5pD7S3BphqRbAdb25mLb2s0EAXxXwZZVsRjmg==
//pragma protect end_key_block
//pragma protect digest_block
jNvb7YCgYMAt9cpfvGwhXZEX/v0=
//pragma protect end_digest_block
//pragma protect data_block
pbmbM89r9WWWxMcQwQbylSodcMIWCvvd0MYyIU/NytXMZRztC6Jl9sb6G2k5gMuY
BX3DJDkPJfWgAvvgvNgIe63ppRdNZaj9/xsQelX6dJ0T4G0tpGZggzqhZXGYfHEM
ugimNEGkfS3DupKswL+Jfn6Oi7Rtm+NKeLwRjgkC/J7C9/NDHAihckjb3mrFfW1l
gvFnxws9kR/K0MSYjUMYWzdiwd/Y29YHngtZ4J5jVIjpYvXtMGO/8c2bEaK6+FSb
yju3UTFDTkBmIIpEM24aAAewrprvoHxdRqJmtQNo15Oh74RUSh14lyP6BBOeWbFq
DvBtOZF6wP2wN0r/ukSED6c8WxE6zkERyzdSfuRDlNlA/w9tjNEyvwSkQj1mOLCt
Gtcr1Xg7Lb3glyvhPBIS6bpJC+SrQOWT7CWpwNYUxIG6Qgd+xLL7BAyk9SxXomcl
u1KTbhbrzUgDIW90481eLjaod4oexNczSAUnhilu4aAYdzvzoidZYMOOvEVo8llS
rLD3r0T96c0Bc7reN02f9VACtTRlJNQ5VjWnaSX8Mw1L6XZAEBSWH30cgPk7m5Hw
GgV3kwr2LILammqa/RoC2SiMK3gtgL9MPEdQ+LXuHkkuLLmiObHCYc4OxvSS7AHr
36wy8VtBDxXJ5W2793y2ZZGC2PNP7SDsTeMcvQzmVqZdmn+tWJANYo5M6RjbVR6b
JpRfWeFHuWuBMnljdxXrWtJQsy/w+kWl9qPcM14jsCPHQlt3TUVjRpqxdej3bct+
tbx1vj4BI2lPdjSX4CsidZ4q3EwNJ2LCAemTIL184V+b7VIuUWpDY17D8PJ0eRnr
NB+SYwc+C9FWKmjfEbtqkEjVaD4SzyBQc8l4Sf1VwIPMuF+Ezj9AVUC5tZ8GcDKJ
UuxuCXFC0FEn0sGMfPPD2Z6f4MDs3vNOf3NrYCUU1EisM7bCJnmicfItyIVDMRV4
rvm9LRwLbu3EXw5184SM2KcehjEMXdAwlC27PRwqRm4A8Bk+rMQuVyb+9CpUEe+9
QpVCrOgoAc9QS+KBZyzTmdXIftXY3P3u7MwG0m7XglVsJPxbACnXg3gSRQexy4N5
YkDcnLmvvJUEwH+uBqAnAnWL/vvnXogqRHuCpT0Qy/Y=
//pragma protect end_data_block
//pragma protect digest_block
MFuQvSY9ipU9MCk4/HYzeV1iPA8=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MXvpkbm61L6rViU8vJz3T1ahNoTNpFd5YLTSOIFXZR8j4eXVf//memMxfNBQn8g4
iaxniiN6riFs15qIt6dsUpiaHszbg4+1iDUqEiQo4260Fof3iGLi9gxXB/+CtV4p
CCzO8c41LJOEvCaTE3hIbhIRLJBosmTT1sZPfnzhwxRdWgIb6A+xsA==
//pragma protect end_key_block
//pragma protect digest_block
bxP3MVlFB57h0J7cpg/RH9Uducc=
//pragma protect end_digest_block
//pragma protect data_block
RW4mwo009y/QVF+Akxgk+TxCIUE+9KoixJiEsr1Os9Af/XCsewYJRw81MBSciuyv
2FGNKZo4RktGvvFNasQm530R1inoDFOSfi0DsqpWdz2JfEs2HpRp2agQREahO0T3
3aaWi1gWFRDg/tg301at8KTTgQyXw25VQ4GVBSPjTm2qsOSd0bE++CFAlYEQxqgf
D98nAlJWfNqK9OyYdk6NYdwVVsCkqrHnoN4WBmhYeYE9zx0ryAgI8inuB/x3wgop
AcdpjY6PQQwrYG92ev/y28Y2rNBhIS/4R8a1QTFe7L9JOpsdW0JxvlIFzvmZPM4L
+Y7cyZ2/7yjBn/jagZD1PgG34CL7jrH425dFXUA4RBpg1Q3UsFuNCamQfx4976Wv
0ozqgobYPzVoqkISmxjSahZkUC/zC59J0l/TzWzLo8FG0EM4KJq4p/617YaehGdR
EnYYipLbrEvFUrc7ZrRg8eN7usjKiCOvmDuhbskQQabycbsw3GHF1zV5eoY5BCmF
E3szwbLMP7KGnycVNDme/tWYXAagp7YETrsmYrXf8Wh5j33opjJx8lH8m08VuXrh
8WRfwJ2DLGprzjKDmXJoG4WRlRfg+POEpAT3Sdw6bEsdWh/k5UIjF3Y73O/Dmfmg
2C5eITukYT9qujwF32FP8P5MPyZXMJYHDXUoInFP65QcAIAPesWQfTPlbyvmGXIt
mkdPWXRyeSK5rMHHlNdaxrN+IxdBWGNBwQG6T7bHu5XUH2fVLDPHPR0xB/oUrEul
2nmViCm2GFUnGRUAZHPqFXXmxJf9QBpxeAl+M0QQJ68Lb5gHC+8GRMqbVpxessM2
WlHV5zpiDEOQPE5Zngy3uZvutrkbVzMJXox9UPNfJiMnZikK1tEL2zDQWbRbahEs
c3qChmdSqNygeRl6n0tKoeUm8lYZTfFNqJuxWFcH5fqIjdaGevUSZbf9soNSFnDt
0kOSkc/PhyyxbygyJkb49iNnhGXDtLkQDsIe+Eg5FkJ20WpTn9qeAREvd/tSdX8E
q0hfuSQCvbxZHfq5vOyVoCbuf/jlH49efTAYOGbL/hlJKQAk22Sfud93WewKl/i1
QjAPfZ7TkeniDzTLB3BEKMFZVzg0xyDLTS876aJEe2sr7pZrO4c31RzBFGEs/HOA

//pragma protect end_data_block
//pragma protect digest_block
ftiV+pB4SZ6tW3IfU8KmJSlqV5g=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_AMBA_SYSTEM_TRANSACTION_SV
