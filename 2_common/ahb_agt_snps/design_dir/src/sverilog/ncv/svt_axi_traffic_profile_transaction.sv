
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GAZlah23cdEj0NzvNMeN98wI007UtTcRTWy47YBVqa/bYfGSsnAl55TS6bNuFlpQ
CJA8hnPytr4cTqS0tfjyQwT05mEs7PE0xc4cIW/qtJcYDvgBFwzQQqZ5ddEs7Zks
86/STJwWYzmWJ3B16ZprkVLuppgEVkFKXd2y53d7aEQUB7LVP49Kgw==
//pragma protect end_key_block
//pragma protect digest_block
BYRtgXVvzlLqFufJMZh9/+RlU1s=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
kH7T56JRSJC5qEjH/I/BDo6AmoM=
//pragma protect end_digest_block
//pragma protect end_protected
`endif //GUARD_SVT_AXI_TRAFFIC_PROFILE_TRANSACTION_SV

