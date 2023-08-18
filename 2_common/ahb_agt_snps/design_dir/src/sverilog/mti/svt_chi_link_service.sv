//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_LINK_SERVICE_SV
`define GUARD_SVT_CHI_LINK_SERVICE_SV 

// =============================================================================
/**
 * This class is a service transaction class. Service request classes are used
 * to describe the events external to the normal protocol transaction and data
 * flow but those which the protocol is designed to handle. This service
 * transaction class supports following services:
 * - link activation/deactivation
 * .
 */
class svt_chi_link_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * Enumerated type for link layer service request types
   */
  typedef enum  {
    DEACTIVATE, /**<: Force the link layer to deactivate.  Ignored if the link is already deactive.  */
    ACTIVATE, /**<: Force the link layer to activate. Ignored if the link is already active.   */
    SUSPEND_REQ_LCRD, /**<: Force the link layer receiver to suspend the transmission of REQ L-credits. Applicable only for SN. Not yet supported for SN. */
    RESUME_REQ_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended REQ L-credits. Applicable only for SN. */
    SUSPEND_SNP_LCRD, /**<: Force the link layer receiver to suspend the transmission of REQ L-credits. Applicable only for RN-F, RN-D. */
    RESUME_SNP_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended REQ L-credits. Applicable only for RN-F, RN-D. */
    SUSPEND_RSP_LCRD, /**<: Force the link layer receiver to suspend the transmission of RSP L-credits. Applicable only for RN. */
    RESUME_RSP_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended RSP L-credits. Applicable only for RN. */
    SUSPEND_DAT_LCRD, /**<: Force the link layer receiver to suspend the transmission of DAT L-credits. Applicable only for RN, SN. Not yet supported for SN. */
    RESUME_DAT_LCRD, /**<: Force the link layer receiver to suspend the transmission of already suspended DAT L-credits. Applicable only for RN, SN. Not yet supported for SN. */
    SUSPEND_ALL_LCRD, /**<: Force the link layer receiver to suspend the transmission of L-credits on all virtual channels. In case of RN SNP,RSP and DAT channels and in case of SN REQ and DAT channels. Not yet supported for SN. */
    RESUME_ALL_LCRD /**<: Force the link layer receiver to suspend the transmission of already suspended L-credits on all virtual channels. In case of RN SNP,RSP and DAT channels and in case of SN REQ and DAT channels. Applicable only for RN, SN. Not yet supported for SN. */
  } service_type_enum;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  /** 
   * Weight that controls generating Link activation and deactivation service requests through randomization.
   * Generating Link activation and deactivation service requests through randomization is enabled by default, 
   * through this attribute's default setting. 
   */
  int unsigned LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;

  /** 
   * Weight that controls suspending and resuming LCRDs through randomization.
   * Generating LCRDs suspend and resume service requests through randomization is disabled by default, through
   * this attribute's default setting.
   */
  int unsigned LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * Type of link layer service to perform.
   * - When randomized, the service_type is controlled through the weights
   *   #LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, #LCRD_SUSPEND_RESUME_SERVICE_wt.
   * - When both these weights are set to zero, there is no weighted distribution
   *   applied by this class constraints on service_type, and this causes all the
   *   possible valid service_type settings to be generated through randomization.
   * - Also refer to the documentation of the enumerated data type.
   * .
   * */
  rand service_type_enum service_type;

  /** 
  * When this flag is set ACTIVATE service request completes when TX state
  * machine reaches RUN state and RX state machine reaches ACTIVATE state. 
  * When this flag is zero ACTIVATE service request completes when TX state
  * machine reaches RUN state and RX state machine reaches RUN state. 
  */
  rand bit allow_deact_in_tx_run_rx_act = 1'b0;

  /** 
  * When this flag is set DEACTIVATE service request allows the link active
  * state machine to move from TX_STOP RX_DEACT to TX_ACT RX_STOP based on the
  * dealys provided instead of reaching the TX_STOP RX_STOP state.
  */
  rand bit allow_act_in_tx_stop_rx_deact = 1'b0;

  /**
   * Number of cycles that the link layer auto-activation feature is suppressed when
   * the link layer is deactivated due to a service request.  This will ensure that
   * the link will be deactive for at least this many cycles following a deactivation
   * service request.
   *
   * Note:
   * While in the deactive state, the link layer can be forced back to the active
   * state using another service request before this minimum time has expired.
   */
  rand int min_cycles_in_deactive = 0;

  //----------------------------------------------------------------------------
  // Protected Data Prioperties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges which insure that the Link Service settings are supported
   * by the Link components.
   */
  constraint valid_ranges {
    min_cycles_in_deactive >= 0;
  }

  /** 
   * Valid ranges constraint for service_type.
   */

  constraint valid_ranges_service_type {
    if (
        (LINK_ACTIVATE_DEACTIVATE_SERVICE_wt > 0) 
        ||
        (LCRD_SUSPEND_RESUME_SERVICE_wt > 0)
       )
    {
      service_type dist {
                           DEACTIVATE       := LINK_ACTIVATE_DEACTIVATE_SERVICE_wt,
                           ACTIVATE         := LINK_ACTIVATE_DEACTIVATE_SERVICE_wt,
                           SUSPEND_REQ_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_REQ_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_SNP_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_SNP_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_RSP_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_RSP_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_DAT_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_DAT_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           SUSPEND_ALL_LCRD := LCRD_SUSPEND_RESUME_SERVICE_wt,
                           RESUME_ALL_LCRD  := LCRD_SUSPEND_RESUME_SERVICE_wt
                         };
    }
  }

  /** 
   * Valid ranges constraint for SUSPEND/RESUME_*_LCRD service_type requsts, 
   * based on node type & interface type.
   */
  constraint valid_ranges_suspend_resume_lcrd_service_types {
    if (cfg.chi_node_type == svt_chi_node_configuration::SN)
    {
      !(service_type inside{SUSPEND_RSP_LCRD, RESUME_RSP_LCRD, SUSPEND_SNP_LCRD,  RESUME_SNP_LCRD});
    }
    else if (cfg.chi_node_type == svt_chi_node_configuration::RN)
    {
      !(service_type inside{SUSPEND_REQ_LCRD, RESUME_REQ_LCRD});
      if (cfg.chi_interface_type == svt_chi_node_configuration::RN_I)
      {
        !(service_type inside{SUSPEND_SNP_LCRD, RESUME_SNP_LCRD});
      }
    }                                                        
    else if (cfg.chi_node_type == svt_chi_node_configuration::HN)
    {
      !(service_type inside{SUSPEND_SNP_LCRD, RESUME_SNP_LCRD});
      if (cfg.chi_interface_type == svt_chi_node_configuration::SN_F || cfg.chi_interface_type == svt_chi_node_configuration::SN_I)
      {
        !(service_type inside{SUSPEND_REQ_LCRD, RESUME_REQ_LCRD});
      }
    }                                                        

  }

  /**
   * Keeps the minumum number of cycles in deactive to a reaonsable value.
   */
  constraint reasonable_min_cycles_in_deactive {
    min_cycles_in_deactive inside {[0:`SVT_CHI_MAX_MIN_CYCLES_IN_DEACTIVE]};
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_link_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_chi_link_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_link_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_link_service)
  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

  /**
   * Post randomize implementation of the class: prints the psdisplay_concise().
   */
  extern function void post_randomize();

  //----------------------------------------------------------------------------
  /** Method to turn reasonable constraints on/off as a block. */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging.  */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_link_service.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();
  
  //----------------------------------------------------------------------------
  /**
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_link_service)
  `vmm_class_factory(svt_chi_link_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_link_service)
`vmm_atomic_gen(svt_chi_link_service, "VMM (Atomic) Generator for svt_chi_link_service data objects")
`vmm_scenario_gen(svt_chi_link_service, "VMM (Scenario) Generator for svt_chi_link_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_link_service)
`else
// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_chi_link_service, svt_chi_node_configuration)
`endif

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TTMHJpavfwGBk9GSxBwAKOJ0Y5xzJzfd6soNASvdkmjcuOvbL1kv5ogFmXto7CgN
Nkqi96CK+ZyuNlYlUKSNDCFQJcLqIz4oCJfi1n0dt7FYBBf4u2Ftn5fIgXcbpQhn
xE9ar2A8S2B8T48ck20O0TvFWRUhSQ0YxrRJdrI1aWs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 924       )
k4LZ0Ak1HaH45mIZkWgNH97i1JfpkGTKRn1/zlq/FNe+dz00qiE3shvfo/gcaJ1K
8KA9DHUYXarNTIqRL6vW5TCnpWxQScpRDL2MWpfm1Oflc1KuAaV8NrBiUlXwTSR3
+kfDk0GPIFWwjxg0KLUuHQb4nXXHEvigF5JZiSDV4q6jWewiJ78mBpp2IeQDwVO1
M9AuaTMr/Clj6GnpbRIcbTNKn2FuYzYK28xcLLk/adXqUTYPR2k6qC+Gw4n4ujvP
h7F7onOT+DX+AWVZKX0Sfgght/CPB+0KnZ6bzbnXL4AAlMOjUCnc3hk4DZTKARiv
1XwX+3gqOcdDZU86WapIQRLSJYDQq6V2wXUf02bydD9RLwaWq7ndqj6x2jjTadmA
2a8Hh0ol3uoJSx0tpcJ7y1t1YPwFqFGdn5oayI7XlArd1aT2RdCQ3/akOhENXnul
PPOWNyvvSdpVBwH5/ee9CZAMmJ+/DMx6hKtNTMqPNK5UL8pdtOlHNV4PWXzz6cB5
SFnz4NUz40Yulfx0z90LI+pQgJnpqlnFt5H8r/dBi45g/r7F4CV/BszVCwb5nvSI
JKqpbN5SmTGVyLqwQr3DaTigGcmZde4UyFRnN1nF0n1u7aU3XtUvQWfFlSBhHy5X
yldDavACeZ5+oINhyaUuOCGQ95l0t9WEx4EXXI+GsNb4oB/sMRiLHNZdIp8h/4Vd
DGxS/iKezH0J974GtAPOycyXxhsM2sojE3r5nJNH8BmcU/14gWCoQErBvujP42WW
OFvqziFVVGUmJ+169fwCaxf7dKLrKBXfy3x28xvqSQMmhTaJ5V0jHUWC6svOKg7N
T697ee1Vzp+WD52lx3vArVuqja+3JLW+LB6doJNOEGvbaoqYFuJJYe/MHzBeDsq/
9Ytc3DZUhGWrqiE166H6P4P/gzt4/X7fV206/g2EnAruPEi5O114VvlqAf8Vm5tV
WnieT/lA3VzH6MtE/ceGpE4y1Jd8C4aKzkfFaPEaPEInCP0e5cIhY/gQI08b5lyT
HUTAomXrxUer/xIejZ+bXLNcl06oKhbJD8eDUkRnNEh+Wv9qYKyTC6GKgvclHx5b
R0v6h6k/6HGphX7LJ17updAhdP9fu5SAB0TxB5LBPhvXzupIesIeowoXXD9Nkp1y
V7fg5LEHS13IK+e3sVpkKxiwZYejcVs9jeK/Y5KEFnyW+fz9fwd4vpJoz7mUhJuq
a6jemZ1Hbx8e+XYGr1XAKg==
`pragma protect end_protected

  
//------------------------------------------------------------------------------
function void svt_chi_link_service::pre_randomize();
`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lqYT6IHI6/wFJMjY+T7xgGoarfvsU9x7JlXMPk4d4JKM8dliv0xPpCtBQ76+DNRL
P/2iA/sIj67Kb18/kO3VSyIB3p4mgNbfbq27ss+K3N1jsKFhKABh+/QEhdbW2Jgv
+kFHk/3N9zGSxHOnKLVJQXliYBr12U96RMmyzRtMVq0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1551      )
XigiXFA1IK2+00rZ2vpRbvHsnoJP15HDlXsjw89oGXiumNmOxhgTb6mOrQnuiit6
98wSCK+hS9KV8uLBEltWsKkTHU5Rf3P9dzx/ih3Oo+LhXxFT8w0BXBjl09SsfGsc
avB0VReCCTHp1bKjHUjQ7tGbcpgHwj+r/HGNGlUIeuZ5ivDdxM1FdNtgmqLDP1sE
+Kvlq7q8pFMHpdc6Wtx0ABj/q+CNTCD7Wbo0Z2C6KFPlAezojacZW7Q4f0hJVYJf
Ea11HdF1ZeJ9LuMf7FI0Qx32ojZHrXcd9za7MpA7JfFSaA4UN+8NZT6vBKU8v+hR
rWIgRqyY2gpcDoHPjQCsr5E4YdHUYu7UPMwWzZ/wIh9ieM+H76M6h2NTw0WB4pKs
nHPxP2UrZUBO6spAnSfQe1zO96JDRoJbJ2kc8K8TdCEqZuHTR8Y5z2FJvl1ItwUa
uUYAh+kw1QyJtAc7BiKXiboB079pHyQSYC2RaqWhyvISm/l2Xi9+Lh0gk/3jY0h9
xEbB5F9gkfae9DhI5XykUL9gkUHVQVWOUQcGqeD1Wu1Mk2E2/oMeFP7EYkJajfgr
hmUQpLwMiM/1rrkro32nO9uIL0+8QkuatqNEL8g81h6n7oT4qzKAsjKDDn0ytgks
mEkJkLyNvApJaqzdv84GmnWtUHGAO36xVbR18j+AASqlCjoj99j3/nQ85ZmiE2Cq
+qIT6uY5wX1uOUDz3yDLMsQlU32Iq0jWItJiGSLoXaHuKdC2ltzp6ppr8ntXwIoh
Z/DpLGnFsVd0ira4bjXK/89Zb1gBbAHAEXp/w67+zEUmi43tsh5aN8EfN8Su3UOj
F6DI0g82yGgLJotj4Xf7VA==
`pragma protect end_protected
endfunction // pre_randomize

//------------------------------------------------------------------------------
function void svt_chi_link_service::post_randomize();
  `svt_debug("post_randomize", psdisplay_concise());
endfunction // post_randomize
  
//vcs_vip_protect
`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IBkA3erdoiQeJq8BW4pe6p9xOp/iaRyNUaWeYkIq46dvxvjK0+QBKQ9mgs2yO0o7
GP/7Ij1YUvVJrej1+Xk0ngPedfj4mAIBdIW4oXP1E/BqIa5wNDVpwVtl+wryXunh
b+OOHTWrdTKk+8BMe/Cp5z7DyVWSST2XOyTt98tFDRM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17740     )
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
rMwk3+zcmNquwH073y+9Ng==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_LINK_SERVICE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
m4vjA3A+I11JNCUj37I5PPLGc59XzqqLT8QQRFfL0QiOIQSx6c3kRSvkBnXUV9kY
UVq+pUzgcYhC/kaI9DqpV0h3iJAxrp+8uqGFnmHyFI4dDLulAI+SZXeYgYql9l+3
FpGEkgukGUL7g4ovczaHOO6JNa1snFyULf+UmPBxzSo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17823     )
ZRKkiIjyuAiNfCzcE1NWGnfuNGqkFIAsZJvumnQrcE0RgF9FHgi498LMWhNQ2TnM
h6POTg/kcx0DSqhhYNM9Nv9tgQuLiHus8QOaxM0mfABnGxkn8+4fmmhARAQkPZbx
`pragma protect end_protected
