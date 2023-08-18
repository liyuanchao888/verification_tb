
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uZSfR5F9WG6G9bedHmCVvveGIP2bI64guPW1cZishGmEXkfPrB4JRzGSBf4I3eLF
0oIg2jFVPdlUCqiCkxHVimnzz/pzJfdn+XXL/+zN2cVpYPSbjn8Tpii+OYZ5S1CD
S7F1Lw164akvu6vILwHH2rowqzfo7Tk2N4Eraexg2jrmpf/S035aXw==
//pragma protect end_key_block
//pragma protect digest_block
hs5L29uZa5tJuuNsAWe43lZMTGc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
RpWvPYw2ATiGaMtXHMRMJElS/do=
//pragma protect end_digest_block
//pragma protect end_protected
`endif //GUARD_SVT_CHI_TRAFFIC_PROFILE_TRANSACTION_SV

