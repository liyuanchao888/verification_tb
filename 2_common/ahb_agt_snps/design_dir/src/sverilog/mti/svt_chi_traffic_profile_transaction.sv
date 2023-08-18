
`ifndef GUARD_SVT_CHI_TRAFFIC_PROFILE_TRANSACTION_SV
`define GUARD_SVT_CHI_TRAFFIC_PROFILE_TRANSACTION_SV
/**
  * This class models a traffic profile for an CHI component
  */
class svt_chi_traffic_profile_transaction extends svt_traffic_profile_transaction;

  /** Enumerated type for transaction type */
  typedef enum bit[4:0] {
        WRITENOSNPFULL,
        WRITENOSNPPTL,
        WRITEUNIQUEFULL,
        WRITEUNIQUEPTL,
        MAKEUNIQUE,
        CLEANUNIQUE,
        READUNIQUE,
        READNOSNP,
        READSHARED,
        READCLEAN,
        READONCE,
        WRITEBACKFULL,
        WRITEBACKPTL,
        WRITECLEANFULL,
        WRITECLEANPTL,
        EVICT,
        WRITEEVICTFULL,
        CLEANINVALID,
        CLEANSHARED,
        MAKEINVALID
  } xact_type_enum;

  /** Enumerated type for protection type */
   typedef enum {
    SECURE,
    NON_SECURE
  } prot_type_enum;

  /** Enumerated type for transaction action */
   typedef enum {
    STORE, /**< WRITENOSNPFULL,WRITENOSNPPTL, WRITEUNIQUEFULL, WRITEUNIQUEPTL, MAKEUNIQUE, CLEANUNIQUE, READUNIQUE */
    LOAD, /**< READNOSNOOP,READSHARED,READCLEAN,READONCE,READUNIQUE */
    MEM_UPDATE, /**< WRITEBACKFULL, WRITEBACKPTL, WRITECLEANFULL, WRITECLEANPTL */
    CACHE_EVICT, /**< EVICT, WRITEEVICTFULL */
    CMO /**< CLEANINVALID,MAKEINVALID,CLEANSHARED */
  } xact_action_enum;

  typedef enum bit [(`SVT_CHI_ORDER_WIDTH-1):0] {
    NO_ORDERING_REQUIRED        = `SVT_CHI_NO_ORDERING_REQUIRED,         /**<: No ordering required */
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    REQ_ACCEPTED                = `SVT_CHI_REQUEST_ACCEPTED,             /**<: Request Accepted */
    `endif
    REQ_ORDERING_REQUIRED       = `SVT_CHI_REQ_ORDERING_REQUIRED,        /**<: Request ordering required */
    REQ_EP_ORDERING_REQUIRED    = `SVT_CHI_REQ_EP_ORDERING_REQUIRED      /**<: Both request and endopoint ordering required */ 
  } order_type_enum;

  typedef enum {
    BYTE_ENABLE_ALL,
    BYTE_ENABLE_RANDOM
  } byte_enable_gen_type_enum;

  /** Indicates if the transaction type to be generated corresponding to the
   * transaction action given in xact_action is random or fixed. If fixed, the
   * value given in xact_type_fixed is used */
  rand attr_val_type_enum xact_gen_type = RANDOM;

  /** Indicates the fixed value of CHI transaction to be generated if 
    * xact_type is FIXED */
  rand xact_type_enum xact_type = WRITENOSNPFULL;

  /** Indicates if this profile is for a store/load/Cache maintenance transaction to/from memory/cache */
  rand xact_action_enum xact_action = STORE;

  /** Indicates whether fixed or random prot_type is to be used for transactions */
  rand attr_val_type_enum prot_gen_type = FIXED;

  /** Applicable if prot_type is set to FIXED. 
   * The fixed value of prot_type to be generated */
  rand prot_type_enum prot_type = SECURE;

  /** Indicates whether fixed, cycle or unique ids should be generated 
   * If set to fixed, a single ID value as specified in txn_id_min is used.
   * If set to cycle, a range of ID values is cycled through from txn_id_min to
   * txn_id_max.  If set to unique, a range of ID values is cycled through from
   * txn_id_min to txn_id_max with the additional constraint that an ID value is
   * not reused if the transaction is in progress. The next available ID will be
   * used. 
   */
  rand attr_val_type_enum txn_id_gen_type = RANDOM;

  /** The lower bound of ID value to be used .
    */
  rand bit[`SVT_CHI_TXN_ID_WIDTH-1:0] txn_id_min = 0;

  /** The upper bound of ID value to be used .
    */
  rand bit[`SVT_CHI_TXN_ID_WIDTH-1:0] txn_id_max = (1 << `SVT_CHI_TXN_ID_WIDTH)-1;

  /** Indicates whether fixed or random qos is to be used for transactions 
    * If set to fixed, the value in qos_min is used.
    * If set to random, the a random value between qos_min and qos_max */
  rand attr_val_type_enum qos_gen_type = RANDOM;

  /** The minimum value of QOS to be used
    * Applicable only if qos is set to fixed 
    */
  rand bit[`SVT_AXI_QOS_WIDTH - 1:0] qos_min = 0;

  /** The maximum value of QOS to be used
    * Applicable only if qos is set to fixed 
    */
  rand bit[`SVT_AXI_QOS_WIDTH - 1:0] qos_max = (1 << `SVT_AXI_QOS_WIDTH)-1;

  /**
   * This field defines the Reserved Value defined by the user for Protocol Request VC Flit. <br>
   * Any value can be driven on this field.<br>
   * This field is not applicable when svt_chi_node_configuration::req_flit_rsvdc_width is set to zero.
   */
  rand bit [(`SVT_CHI_REQ_RSVDC_WIDTH-1):0] req_rsvdc = 0;

  /**
   * This field defines the Reserved Value defined by the user for Protocol Dat VC Flit. <br>
   * Any value can be driven on this field.<br>
   */
  rand bit [(`SVT_CHI_REQ_RSVDC_WIDTH-1):0] dat_rsvdc = 0;

  /** Indicates whether fixed or random cache_type is to be used for transactions  
    * Fixed mem_attr_gen_type can be used only if xact_gen_type is also FIXED
    * because the value of mem_attr is tied to the xact_type */
  rand attr_val_type_enum mem_attr_gen_type = FIXED;

  /** The fixed value of MemAttr[3:0] when mem_attr_gen_type is FIXED. 
    * The values map to CHI MemAttr Attribute. 
    */
  rand bit[3:0] mem_attr = 4'b0010; //Normal, non-cacheable, non-bufferable

  /**
   * This field defines Likely Shared attribute.<br>
   * When set to 1, this field indicates that the requested data is likely 
   * to be shared by other RNs within the system.
   * Applicable only if xact_gen_type is also FIXED.
   */
  rand bit likely_shared = 0;

  /** Indicates whether fixed or random field is to be generated for 'order' field 
    * Fixed can be used only if xact_gen_type is also FIXED
    * because the value of 'order' is tied to the xact_type */
  rand attr_val_type_enum order_gen_type = FIXED;

  /** This field defines ordering requirements for a transaction. */
  rand order_type_enum order = NO_ORDERING_REQUIRED;

  /**
   * This field defines the Logical Processor ID. This is used in conjunction with 
   * the src_id field to uniquely identify the logical processor that generated the request.
   */
  rand bit [(`SVT_CHI_LPID_WIDTH-1):0] lpid = 0;

  /**
   * Applicable only if xact_gen_type is FIXED
   * This field defines the exclusive bit of:
   * - The Transaction (svt_chi_transaction::xact_type) AND
   * - The Request flit (svt_chi_flit::flit_type = svt_chi_flit:REQ)
   * .
   *
   * Value of 0 indicates that the corresponding transaction is a normal transaction.<br>
   * Value of 1 indicates that the corresponding transaction is an exclusive type transaction.<br> 
   *
   * The Exclusive bit must only be used with the following transactions: 
   * - ReadShared
   * - ReadClean
   * - CleanUnique
   * - ReadNoSnp
   * - WriteNoSnp
   * .
   */
  rand bit exclusive = 0;

  /**
    * Indicates the generation type for byte_enable.
    * If set to ENABLE_ALL, all bytes are enabled.
    * If set to RANDOM, random bytes are enabled
    */
  rand byte_enable_gen_type_enum byte_enable_gen_type;


  /** @cond PRIVATE */
  /**
    * Currently not supported.
    * Applicable only if xact_gen_type is FIXED
    * This field defines the Expect CompAck bit of the transaction.<br>
    * When set to 0, it indicates that the transaction will not include a CompAck, 
    * so the receiver of the transaction is not required to wait for CompAck.<br>
    * When set to 1, it indicates that the transaction will include a CompAck, 
    * so the receiver of the transaction is required to wait for CompAck.
    */
  rand bit exp_comp_ack = 1;

  /** 
    * Enables FIFO based rate control.  A FIFO is modelled in the layering
    * sequence that converts this traffic transaction to protocol level
    * transactions. Note that with this option, each traffic transaction has a
    * corresponding FIFO modelled for it. If component level control is
    * required where a FIFO needs to be modelled for all transactions passing
    * through a master/slave,
    * svt_chi_node_configuration::use_fifo_based_rate_control and
    * corresponding parameters must be used. For example, if normal write
    * transactions and device type write transactions are abstracted in two
    * traffic transactions, and if a different rate is required for normal and
    * device transactions, this parameter must be used. However, if the same rate
    * is required for all write transactions for the component, the parameter
    * in svt_chi_node_configuration::use_fifo_based_rate_control should be
    * used. 
    * This parameter is currently not supported.
    */
  //rand bit use_fifo_based_rate_control = 0;
  /** @endcond */

  /**
   * Indicates the total number of bytes of this transaction
   * that has been received or transmitted on the CHI interface
   */
  int current_xmit_byte_count = 0;

  /** Handle to the port configuration */
  svt_chi_node_configuration cfg;

  /** log_base_2 of data width in bytes */
  local int log_base_2_data_width_in_bytes;

  /** log_base_2 of xact_size */
  local rand int log_base_2_xact_size;

  /** log_base_2 of addr_xrange */
  local rand int log_base_2_addr_xrange;

  /** log_base_2 of difference between addr_twodim_stride and addr_xrange */ 
  local rand int log_base_2_addr_twoaddr_xrange_multi_factor;

  /** log_base_2 of all addr_twodim_strides upto the penultimate block */
  local rand int log_base_2_addr_twodim_yrange_multi_factor;

  /** log_base_2 of base addr */
  local rand int log_base_2_base_addr;

  /** Constraints for data related parameters */
  constraint valid_data {
    if (xact_size >= cfg.flit_data_width) {
      data_min <= (1 << cfg.flit_data_width)-1;
      data_max <= (1 << cfg.flit_data_width)-1;
    } else {
      data_min <= (1 << xact_size)-1;
      data_max <= (1 << xact_size)-1;
    }
    data_max > data_min;
  }

  /** Constraints for address related parameters */
  constraint valid_addr {
    base_addr <= (1 << cfg.addr_width) - 1;
    addr_xrange <= (1 << cfg.addr_width) - 1;
    (1 << log_base_2_addr_xrange) > xact_size;
    addr_twodim_stride <= (1 << cfg.addr_width) - 1;
    addr_twodim_yrange <= (1 << cfg.addr_width) - 1;
    // Difficult to support TWODIM in a generic manner if addr_width < 32. Most systems
    // will have atleast 32-bit addressing if TWODIM addressing pattern is required.
    if (cfg.addr_width < 32)
      addr_gen_type != TWODIM; 
  }

  /** Constraints for xact_action */
  constraint valid_xact_action {
    if (cfg.chi_interface_type == svt_chi_node_configuration::RN_I) {
      xact_action inside {STORE,LOAD,CMO};
    } else if (cfg.chi_interface_type != svt_chi_node_configuration::RN_F) {
      xact_action inside {STORE,LOAD};
    }
  }

  /** Constraints for QOS related parameters */
  constraint valid_qos_val {
    qos_max >= qos_min;
    if (qos_gen_type == FIXED)
      qos_min == qos_max;
    qos_min <= (1 << `SVT_AXI_QOS_WIDTH)-1;  
    qos_max <= (1 << `SVT_AXI_QOS_WIDTH)-1;
  }


  /** Constraints for valid transaction types */
  constraint valid_xact_type {
    if (cfg.chi_interface_type == svt_chi_node_configuration::RN_F) { 
      if (xact_action == STORE)
        xact_type inside {WRITENOSNPFULL,WRITENOSNPPTL, WRITEUNIQUEFULL,WRITEUNIQUEPTL,MAKEUNIQUE,CLEANUNIQUE,READUNIQUE};
      else if (xact_action == LOAD)
        xact_type inside {READNOSNP,READSHARED,READCLEAN,READONCE,READUNIQUE};
      else if (xact_action == MEM_UPDATE)
        xact_type inside {WRITEBACKFULL,WRITEBACKPTL,WRITECLEANFULL,WRITECLEANPTL};
      else if (xact_action == svt_chi_traffic_profile_transaction::CACHE_EVICT)
        xact_type inside {EVICT,WRITEEVICTFULL};
      else if (xact_action == CMO)
        xact_type inside {CLEANINVALID,CLEANSHARED,MAKEINVALID};
    } else if (cfg.chi_interface_type == svt_chi_node_configuration::RN_I) { 
      if (xact_action == STORE)
        xact_type inside {WRITENOSNPFULL,WRITENOSNPPTL,WRITEUNIQUEFULL,WRITEUNIQUEPTL};
      else if (xact_action == LOAD)
        xact_type inside {READNOSNP,READONCE};
      else if (xact_action == CMO)
        xact_type inside {CLEANINVALID,CLEANSHARED,MAKEINVALID};
    } 
  }

  /** Reasonable constraint for address */
  constraint reasonable_addr {
    log_base_2_base_addr inside {[0:10]};
    // 4K to 1 MB xrange
    log_base_2_addr_xrange inside {[4:20]};
    addr_xrange == (1 << log_base_2_addr_xrange);
    base_addr == (1 << log_base_2_base_addr);
    log_base_2_base_addr + log_base_2_addr_xrange <= cfg.addr_width;
    if (addr_gen_type == TWODIM) {
      base_addr + addr_xrange <= (1 << cfg.addr_width) - 1; 
      base_addr + addr_twodim_stride <= (1 << cfg.addr_width) - 1;
      base_addr + addr_twodim_yrange <= (1 << cfg.addr_width) - 1;
      // This is the log_base_2 of addr_twodim_stride. We want it to be such that atleast 4
      // strides can be taken before reaching addr_twodim_yrange
      log_base_2_addr_xrange + log_base_2_addr_twoaddr_xrange_multi_factor <=  cfg.addr_width - 4;
      // This is the log_base_2 of addr_twodim_yrange. It should be <= addr_width
      log_base_2_addr_xrange + log_base_2_addr_twoaddr_xrange_multi_factor + log_base_2_addr_twodim_yrange_multi_factor <= cfg.addr_width;
      addr_twodim_stride == (1 << (log_base_2_addr_twoaddr_xrange_multi_factor+log_base_2_addr_xrange)); 
      addr_twodim_yrange == (1 << (log_base_2_addr_twodim_yrange_multi_factor+log_base_2_addr_xrange+log_base_2_addr_twoaddr_xrange_multi_factor));
    }
  }

  /** Reasonable constraint for base_addr */
  constraint reasonable_base_addr {
    // Adding this constraint so that there are a few 
    // transactions that can be generated without crossing
    // 4K boundary.      
    base_addr[7:0] == 'h0;
  }

  /** Reasonable constraint for cach_type related parameters */
  constraint reasonable_cache_type_val {
    // If xact_gen_type is RANDOM, then mem_attr_gen_type should be RANDOM too.
    // If xact_gen_type is FIXED, then mem_attr_gen_type is FIXED too.
    mem_attr_gen_type == xact_gen_type; 
    if (mem_attr_gen_type == FIXED) {
      if (xact_type inside {WRITENOSNPFULL,READNOSNP, WRITENOSNPPTL}) { // Device or normal
        mem_attr inside {[4'b0000:4'b0011]};
      } else {
        mem_attr inside {[4'b0010:4'b0011]};
      }
    } 
  }

  /** Resonable constraint for xact_size */
  constraint reasonable_xact_size {
    // Restrict total number of bytes transferred to a max of
    // data_width_in_bytes * 16 (where 16 is max burst length in AXI3).
    // We extend the max burst length of 16 to non-AXI3 interfaces also
    // mainly so that one transaction does not hog the interface
    // Consider a data_width of 16 bytes. log_base_2_data_width_in_bytes is 4.
    // xact_size may have values (16, 32, 64, 128, 256).
    xact_size == (1 << log_base_2_xact_size);
    log_base_2_xact_size inside {[log_base_2_data_width_in_bytes:(log_base_2_data_width_in_bytes+4)]};
  }

  /** Class Constructor */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(string name ="svt_chi_traffic_profile_transaction");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(string name ="svt_chi_traffic_profile_transaction");
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_chi_traffic_profile_transaction)
`endif
  extern function new(vmm_log log=null, svt_chi_node_configuration port_cfg_handle = null);
`endif

  `svt_data_member_begin(svt_chi_traffic_profile_transaction)
  `svt_data_member_end(svt_chi_traffic_profile_transaction)

  //----------------------------------------------------------------------------
  /** Gets the configuration handle prior to randomization */
  extern function void pre_randomize();
  
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  //----------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

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
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the fields to get only the fields to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

 // ---------------------------------------------------------------------------- 
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

 // ---------------------------------------------------------------------------- 
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

 // ----------------------------------------------------------------------------

  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

//-----------------------------------------------------------------------------------
/**
  * This method is used to set object_type for bus_activity when
  * bus_activity is getting started on the bus .
  * This method is used by pa writer class in generating XML/FSDB 
  */
  extern function void  set_pa_data(string typ = "" ,string channel  ="");
 
//-----------------------------------------------------------------------------------
  /**
  * This method is used to  delate  object_type for bus_activity when bus _activity 
  * ends on the bus .
  * This methid is used by pa writer class  in generating XML/FSDB 
  */
  extern function void clear_pa_data();
  
//------------------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

//------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  // TBD: Implement when PA is supported
  //extern virtual function string get_uid();

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_traffic_profile_transaction)
    `vmm_class_factory(svt_chi_traffic_profile_transaction)
  `endif
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nxFTXswc8DmPg2jUinj+/vuhRJM6g1msOozsOCH8ETKJwzqWOPAsNDWKzBE0HWzE
hq4YooIQnqh5EcIQXWFvlHhnC+zEUklCq1pUOLr781TCtsNhbyPwlLMW+268LFOV
vuf4I3TdCyCVacnx7Kt90oPgG5Ap17shxlRJwfjtqNY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33479     )
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
`pragma protect end_protected
`endif //GUARD_SVT_CHI_TRAFFIC_PROFILE_TRANSACTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fCQIGq81tPDP8HpsbwM65iLrosFyai4OP9pf7wEW3VBPyyksZ//ClXb5tTBI7rKs
Ov3gMJX7MUsoElUKWS4EH+QnQP0TyAv5I26mhd0hvbGBehLJt3hWPQcpT6O7WEEz
BSWxqTOE5YIZglLJu9TtEmqRIiFRhxoXkWhBVK4rlEM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33562     )
p5e/VZOHktF0z8w4IlD+dnLenootphohiI724tN2EfkLQDoxgE4fAs5FBu5FZWav
2IR7V51lasqadpefHIcLBcJmstWuR8Si4VcstXe7Bm9foHwPsGVXZ0tdRacmAJ43
`pragma protect end_protected
