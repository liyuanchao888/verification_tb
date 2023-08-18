
`ifndef GUARD_SVT_AXI_TRAFFIC_PROFILE_TRANSACTION_SV
`define GUARD_SVT_AXI_TRAFFIC_PROFILE_TRANSACTION_SV
/**
  * This class models a traffic profile for an AXI component
  */
class svt_axi_traffic_profile_transaction extends svt_traffic_profile_transaction;

  /** Enumerated type for transaction type */
  typedef enum bit[4:0] {
        WRITENOSNOOP,
        WRITEUNIQUE,
        WRITELINEUNIQUE,
        MAKEUNIQUE,
        CLEANUNIQUE,
        READUNIQUE,
        READNOSNOOP,
        READSHARED,
        READCLEAN,
        READNOTSHAREDDIRTY,
        READONCE,
        WRITEBACK,
        WRITECLEAN,
        EVICT,
        WRITEEVICT,
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
    STORE, /**< WRITENOSNOOP, WRITEUNIQUE, WRITELINEUNIQUE, MAKEUNIQUE, CLEANUNIQUE, READUNIQUE */
    LOAD, /**< READNOSNOOP,READSHARED,READCLEAN,READNOTSHAREDDIRTY,READONCE,READUNIQUE */
    MEM_UPDATE, /**< WRITEBACK, WRITECLEAN */
    CACHE_EVICT, /**< EVICT, WRITEEVICT */
    CMO /**< CLEANINVALID,MAKEINVALID,CLEANSHARED */
  } xact_action_enum;


  /** Indicates if the transaction type to be generated corresponding to the
   * transaction action given in xact_action is random or fixed. If fixed, the
   * value given in xact_type_fixed is used */
  rand attr_val_type_enum xact_gen_type = RANDOM;

  /** Indicates the fixed value of AXI transaction to be generated if 
    * xact_type is FIXED */
  rand xact_type_enum xact_type = WRITENOSNOOP;

  /** Indicates if this profile is for a store/load/Cache maintenance transaction to/from memory/cache */
  rand xact_action_enum xact_action = STORE;

  /** Indicates whether fixed or random cache_type is to be used for transactions  
    * Fixed cache_gen_type can be used only if xact_gen_type is also FIXED
    * because the value of cache_type is tied to the xact_type */
  rand attr_val_type_enum cache_gen_type = FIXED;

  /** The minimum value of cache_gen_type. 
    * The values map to AXI cache_type signal. 
    * Only values from 4'b0000 to 4'b0011 are supported from the sequence. 
    * If a different value is to be generated, the reasonable_cache_gen_type_val must
    * be switched off */
  rand bit[3:0] cache_type_min = 4'b0010; //Normal, non-cacheable, non-bufferable

  /** The maximum value of cache_type. 
    * The values map to AXI cache_type signal. 
    * Only values from 4'b0000 to 4'b0011 are supported from the sequence. 
    * If a different value is to be generated, the reasonable_cache_type_val must
    * be switched off */
  rand bit[3:0] cache_type_max = 4'b0010; //Normal, non-cacheable, non-bufferable

  /** Indicates whether fixed or random prot_type is to be used for transactions */
  rand attr_val_type_enum prot_gen_type = FIXED;

  /** Applicable if prot_type is set to FIXED. 
   * The fixed value of prot_type to be generated */
  rand prot_type_enum prot_type_fixed = SECURE;

  /** Indicates whether fixed, cycle or unique ids should be generated 
   * If set to fixed, a single ID value as specified in id_min is used.
   * If set to cycle, a range of ID values is cycled through from id_min to
   * id_max.  If set to unique, a range of ID values is cycled through from
   * id_min to id_max with the additional constraint that an ID value is
   * not reused if the transaction is in progress. The next available ID will be
   * used. 
   */
  rand attr_val_type_enum id_gen_type = RANDOM;

  /** The lower bound of ID value to be used .
    */
  rand bit[`SVT_AXI_MAX_ID_WIDTH-1:0] id_min = 0;

  /** The upper bound of ID value to be used .
    */
  rand bit[`SVT_AXI_MAX_ID_WIDTH-1:0] id_max = (1 << `SVT_AXI_MAX_ID_WIDTH)-1;

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

  /** Read address valid to next read address valid delay
    * If set to fixed, the value in artv_min is used.
    * If set to random, a random value between artv_min 
    * artv_max is used
    */
  rand attr_val_type_enum artv = FIXED;

  /** Minimum value of read address valid to next read address valid */
  rand int artv_min = 1;

  /** Maximum value of read address valid to next read address valid */
  rand int artv_max = 1;

  /** Write address valid to next write address valid delay
    * If set to fixed, the value in artv_min is used.
    * If set to random, a random value between artv_min 
    * artv_max is used
    */
  rand attr_val_type_enum awtv = FIXED;

  /** Minimum value of write address valid to next write address valid */
  rand int awtv_min = 1;

  /** Maximum value of write address valid to next write address valid */
  rand int awtv_max = 1;

  /** Minimum value of read data valid to same beat ready */
  rand int rbr = 0;

  /** Minimum value of read last data handshake to acknowledge */
  rand int rla = 1;

  /** Minimum value of transaction start to write address valid */
  rand int awv = 1;

  /** Minimum value of write data handshake to next beat valid */
  rand int wbv = 1;

  /** Minimum value of write response valid to ready */
  rand int br = 0;

  /** Minimum value of write response handshake to acknowledge */
  rand int ba = 1;

  /** @cond PRIVATE */
  /** 
    * Enables FIFO based rate control.  A FIFO is modelled in the layering
    * sequence that converts this traffic transaction to protocol level
    * transactions. Note that with this option, each traffic transaction has a
    * corresponding FIFO modelled for it. If component level control is
    * required where a FIFO needs to be modelled for all transactions passing
    * through a master/slave,
    * svt_axi_port_configuration::use_fifo_based_rate_control and
    * corresponding parameters must be used. For example, if normal write
    * transactions and device type write transactions are abstracted in two
    * traffic transactions, and if a different rate is required for normal and
    * device transactions, this parameter must be used. However, if the same rate
    * is required for all write transactions for the component, the parameter
    * in svt_axi_port_configuration::use_fifo_based_rate_control should be
    * used. 
    * This parameter is currently not supported.
    */
  rand bit use_fifo_based_rate_control = 0;
  /** @endcond */

  /** A traffic profile transaction is mapped to multiple AXI transactions in a layering sequence. 
   *  If this bit is set to 1, further processing to map traffic profile
   *  transaction to multiple AXI transactions will be suspended until it is unset by user
   *  Default value is 0.
   */
  bit suspend_xact=0;

  /**
    * Number of times this traffic profile transaction must be 
    * transmitted. The layering sequence will map and transmit the
    * traffic profile based on the value set in this attribute.
    * This value can be set in post_traffic_profile_seq_item_port_get
    * callback
    */
  int num_repeat = 0;

  /**
    * If num_repeat is not 0, this indicates the current repeat count.
    * That is, this indicates the nth time the traffic profile is being
    * repeated. The value is 0 for the first time it is sent. 
    */
  int curr_repeat_count = 0;

  /**
   * Indicates the total number of bytes of this transaction
   * that has been received or transmitted on the AXI interface
   */
  int current_xmit_byte_count = 0;

  /** Handle to the port configuration */
  svt_axi_port_configuration cfg;

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
    if (xact_size >= cfg.data_width) {
      data_min <= (1 << cfg.data_width)-1;
      data_max <= (1 << cfg.data_width)-1;
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
    if (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) {
      xact_action inside {STORE,LOAD,CMO};
    } else if (cfg.axi_interface_type != svt_axi_port_configuration::AXI_ACE) {
      xact_action inside {STORE,LOAD};
    }
  }

  /** Constraints for ID related parameters */
  constraint valid_id_val {
    id_max >= id_min; 
    if (id_gen_type == FIXED) {
      id_min == id_max;
    }
    if (cfg.use_separate_rd_wr_chan_id_width == 0) {
     id_min <= ((1 << cfg.id_width) - 1);
     id_max <= ((1 << cfg.id_width) - 1);
     // The min and max are chosen based on the higher value of
     //write_chan_id_width and read_chan_id_width. However, during
     // generaton of xact we ensure that only valid values of id
     // are generated based on the transaction type generated
    } else {
      if (cfg.write_chan_id_width > cfg.read_chan_id_width) {
        id_min <= ((1 << cfg.write_chan_id_width) - 1);
        id_max <= ((1 << cfg.write_chan_id_width) - 1);
      } else {
        id_min <= ((1 << cfg.read_chan_id_width) - 1);
        id_max <= ((1 << cfg.read_chan_id_width) - 1);
      }
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

  /** Constraints for artv related parameters */
  constraint valid_artv_val {
    artv_max >= artv_min;
    artv_min > 0;
    artv_min <= `SVT_AXI_MAX_ADDR_VALID_DELAY;
    artv_max > 0;
    artv_max <= `SVT_AXI_MAX_ADDR_VALID_DELAY;
    if (artv == FIXED)
      artv_max == artv_min;
  }

  /** Constraints for awtv related parameters */
  constraint valid_awtv_val {
    awtv_max >= awtv_min;
    awtv_min > 0;
    awtv_min <= `SVT_AXI_MAX_ADDR_VALID_DELAY;
    awtv_max > 0;
    awtv_max <= `SVT_AXI_MAX_ADDR_VALID_DELAY;
    if (awtv == FIXED)
      awtv_max == awtv_min;
  }

  /** Constraints for read data valid to same beat ready */
  constraint valid_rbr_val {
    rbr >= 0;
    rbr <= `SVT_AXI_MAX_RVALID_DELAY;
  }

  /** Constraints for read last data handshake to acknowledge */
  constraint valid_rla_val {
    rla >= 0;
    rla <= `SVT_AXI_MAX_RACK_DELAY;
  }

  /** Constraints for write response handshake to acknowledge */
  constraint valid_ba_val {
    ba >= 0;
    ba <= `SVT_AXI_MAX_RACK_DELAY;
  }

  /** Constraints for write response handshake to acknowledge */
  constraint valid_awv_val {
    awv >= 0;
    awv <= `SVT_AXI_MAX_ADDR_VALID_DELAY;
  }
 
  /** Constraints for write data handshake to next beat valid */
  constraint valid_wbv_val {
    wbv >= 0;
    wbv <= `SVT_AXI_MAX_WVALID_DELAY;
  }

  /** Constraints for write response valid to ready */
  constraint valid_br_val {
    br >= `SVT_AXI_MIN_WRITE_RESP_DELAY;
    br <= `SVT_AXI_MAX_WRITE_RESP_DELAY;
  }

  /** Constraints for valid transaction types */
  constraint valid_xact_type {
    if (cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) { 
      if (xact_action == STORE)
        xact_type inside {WRITENOSNOOP,WRITEUNIQUE,WRITELINEUNIQUE,MAKEUNIQUE,CLEANUNIQUE,READUNIQUE};
      else if (xact_action == LOAD)
        xact_type inside {READNOSNOOP,READSHARED,READCLEAN,READNOTSHAREDDIRTY,READONCE,READUNIQUE};
      else if (xact_action == MEM_UPDATE)
        xact_type inside {WRITEBACK,WRITECLEAN};
      else if (xact_action == svt_axi_traffic_profile_transaction::CACHE_EVICT)
        xact_type inside {EVICT,WRITEEVICT};
      else if (xact_action == CMO)
        xact_type inside {CLEANINVALID,CLEANSHARED,MAKEINVALID};
    } else if (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) { 
      if (xact_action == STORE)
        xact_type inside {WRITENOSNOOP,WRITEUNIQUE,WRITELINEUNIQUE};
      else if (xact_action == LOAD)
        xact_type inside {READNOSNOOP,READONCE};
      else if (xact_action == CMO)
        xact_type inside {CLEANINVALID,CLEANSHARED,MAKEINVALID};
    } else {
      if (xact_action == STORE)
        xact_type == WRITENOSNOOP;
      else if (xact_action == LOAD)
        xact_type == READNOSNOOP;
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

  /** Since traffic profiles are typically for testing performance,
   * have a constraint to keep delays at its minimum
   * Reasonable constraint for awtv */
  constraint reasonable_awtv_max_throughput {
    awtv_min == 1;
    awtv_max == 1;
  }

  /** Reasonable constraint for awtv */
  constraint reasonable_artv_max_throughput {
    artv_min == 1;
    artv_max == 1;
  }

  /** Reasonable constraint for rla */
  constraint reasonable_rla_max_throughput {
    rla == 1;
  }

  /** Reasonable constraint for ba */
  constraint reasonable_ba_max_throughput {
    ba == 1;
  }

  /** Reasonable constraint for awv */
  constraint reasonable_awv_max_throughput {
    awv == 1;
  }

  /** Reasonable constraint for wbv */
  constraint reasonable_wbv_max_throughput {
    wbv == 1;
  }

  /** Reasonable constraint for br */
  constraint reasonable_br_max_throughput {
    br == 0;
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
    cache_type_max >= cache_type_min;    
    // If xact_gen_type is RANDOM, then cache_gen_type should be RANDOM too.
    // If xact_gen_type is FIXED, then cache_gen_type is FIXED too.
    cache_gen_type == xact_gen_type; 
    if (cache_gen_type == FIXED) {
      cache_type_min == cache_type_max;
      if (xact_type inside {WRITENOSNOOP,READNOSNOOP}) { // Device or normal
        cache_type_min inside {[4'b0000:4'b0011]};
      } else {
        cache_type_min inside {[4'b0010:4'b0011]};
      }
    } else {
      if (xact_type inside {WRITENOSNOOP,READNOSNOOP}) { // Device or normal
        cache_type_min == 4'b0000;
        cache_type_max == 4'b0011;
      } else { // Normal memory
        cache_type_min == 4'b0010;
        cache_type_max == 4'b0011;
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
  extern function new(string name ="svt_axi_traffic_profile_transaction");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(string name ="svt_axi_traffic_profile_transaction");
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_traffic_profile_transaction)
`endif
  extern function new(vmm_log log=null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  `svt_data_member_begin(svt_axi_traffic_profile_transaction)
  `svt_data_member_end(svt_axi_traffic_profile_transaction)

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
    `vmm_typename(svt_axi_traffic_profile_transaction)
    `vmm_class_factory(svt_axi_traffic_profile_transaction)
  `endif
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mzPXNDvww4fJpeoJbe6XMvC06t4Ckz4GHWIrMOF2F/tj8r4/NFE8aSrPc7bdLBT0
ILEfYqJuvh3xshBmMwTtG0axzwtzE3Du5E6ciICQQq/MpVlZ2aMGhYlmsOYzgG+c
L+HeReACD8USCzffBDdZD6DsDTz6K4o4XG+ghS0GXK8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 41300     )
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
`pragma protect end_protected
`endif //GUARD_SVT_AXI_TRAFFIC_PROFILE_TRANSACTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SyeSYRafXOxAzXLhw7yKXI1kBqhgTRFkNdKlGvDaQNAT8gSOT4MVv6Lwh4gQ8Q0U
F9Xpvi4jQ1ps/aYvn48dlKib34ClmUQa1OH8/Cbr8Gi3x7XO6R0GIPBz8HpHyoWb
+nKFdBJRIaTtFjz8mxEpw2EHji/8VHo9l8vPxKGKaZg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 41383     )
yZkyTtt2BAWkmQtRM5wWP1v/yddkHMwm78E/E2LaXAP4ewyJgx+jzy4m58E2A0PP
dFOZafmJAioZK7UWuxE+UpV/SF/rxQSHqBJhSnK0lmNvBiR7ArD/3QASHIhyp6RW
`pragma protect end_protected
