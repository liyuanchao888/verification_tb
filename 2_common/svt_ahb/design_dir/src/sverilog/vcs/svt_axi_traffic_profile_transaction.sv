
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

`protected
UHGAH?fHVP9HC25NCSM<\COCNTe;,J)Ib(Tag71c6<(6H)]C<G^#2)/7^<Z[,P5C
C&.e:E-VU+Qg^1D3/<SF]I09RWCF^Lg&+\=&,CR[QL))K+G#;G:0&8)QN32?eKS?
-e;UT>N:68\QV;9cQZ:4>L3(cY4DdJ4K-f:8S-(4f74ABHUcE@@&Y3bTWFHMYXB=
[Wab>eQ]8:/79I]\B(=4:GBB0T-P=VF1,WT987R@F3=#V,EOOU3Y6FXAD@]EaTNR
6T3eEOR]aUXdY3,dH3>^NVe.;R427E1)_1U,HL>1AUZfN[DC,SYEdA:O^Ec?7J/I
ST6UHJ7NgJ&OD]g2\[^0#819gA[K]&LEBYe4[([&XV)QCd=Q;=[]=,3C4760>(Ze
[3[9Z@eSL(&0e?[ACFTVA/;2D8gF9M^b;aGd)BPLfJ<?Ac+dE5B<N60PCW=;UIAO
FWYK_KdW#<W0,1J/Y#YV/S#F@K11#0PWIR4^S1bMA7>MHRCgS9FcSCbebGVE4COP
0Dd&4e-g-:g&A(^((DPdbZ.O/S0?e.EC[Y6b\Bd09SV)1;<+X@bJD4P=B1QF.O65
c)]Y_F(PdJ]]B]KR?b0T6FUcV#e?S:2_RDd89F=#TI.>^+9UD:eBZZ9=f[6+\dCe
Tg]dPV>F6HSHARdETEH^4#[CR(.AH8>518KM99^4IWLcd)/,H&8H+#Ib34PXEB[<
HTSf@R:F:D_d,S_A>&Ke0C=3U&(1\L5;G+T@;:\-.#GZ#>\2XEc]]Q=@7:,5<a^U
SUaW/)#<FBcSLR)ObP/?Y(;&53gdg#XDKE(cb6\7&SC@40_[3W^;bFT4e^M?_?QV
gIX/E755_SX-]#_VK)7XPXPM1I<9EAJ88X3,@CY0J/1gT5GZCPMY9AZNPV1.]JMS
<RZ?BARe?NcJbc+NAZ?ANLZ?VS+]R^>d.;WNbP-Q>Ce&g7<7[OOfG:=;:VD^FI56
\9@9<KN[,QG&04gIegT2^e&2<,T()C52^#Yde.BeHE(bZ@O1YPbSV/776a#N/N:d
D8;2g+M1=F>DB1Q\@b(,UR_QA8aF?87]-:VH6I^5cG5D0,Cg(\,K;M+H>?L]>c^a
f(9+f05USTW#5_#\^fU==PY)A<W]X/48)X.D:S_JF<OB=be1,O36CX:?\]E_)S>?
]+YZ[OYeDd2:WM.SRSTQ,R9)BZRB.?6R.E)0gEQ.84LI.7EN<=&XN\#(HX<Y?+4G
<AFX1J>\<&a@IC@0e/04:](P_65eR0VT\8KWgdRT)5NC^PG_F-8ANAOI7YX8B5gV
c/JHV4;V&[5gGb\:J:#84>=&e-&5@\0ZMQ8SI-fP,BR9[@Y/M3b1bbLIEXW7fI6T
-;-C[OM:^fbXRd<QF_a>9U5I(WDcH9)ZBbWe<?[,DYOd,3OUD_<)BG7WAcd\5YX.
J1#5cR]a8H3,MbS;^c?H;d/TY8g6IcTLbIYB8LTC30c>B<FNXF7@HZ:WU-eWL;VX
=9FL/Yf5M]OQVOd;gf;^J54^CYKE\])@(+FcB(Mc)?Q2H@PJ6QY=X__BQd/?[>?6
Rb[>/8<R^b272IO?K@@V0<K>/DKL7:5_NVJUQS7-2Z+fVGKLG?LMbU4T^F?E2NbX
OGJ[MGR>W?@=NX+KfF3M?RGLB]BE9&0H1^e<&875F#7+[0>AVF17OGf:>RQ5AHM^
\2KIagOe7JKBA?WKE#W?,Z0ZP0\EUKKQ[[9&FfX/JO+ZKN>_f>^gB7-5)3XdJIG,
76@TTDCf4:NTM<E.V;UR=dHZTUD>OZBDQ/:X92Jbg)eR/8<F3FDe.K[=>PbZ;>3Q
?[N]2,3#>Q[52S(9Abbf\Z.:Cf(+MU,3fb<5P;EFY=T=(a/CC-B5@W>9]5#J+;<P
#[+128L[Y2<]dD-1_eU&eA5c\:YScE0e6T&^H720YDPXZZ-RcJ4gK4DKg.(YF]7=
W<(A2=FA>7_>SeS)RDNgQ&A?:1ILaSV@260XD72PbR)RB]gT+P)7fZd]B]+:FVTI
fH7>.[NHS4:<ZCZ#a3#WIAMBdN_Ne4aA@9.ZMDb?@^WYed1&#3(P/eD(UfQ7b]TJ
aAT;=Qc0JT_8M=WMWKOc1?C6P.Q^G:W_8NG=cIAR,R.C-?,RaIJ[/S?E8gTT1Q4Q
0-ZT-#0/3,b;>#CDUY#3:.(CPSZfaF/OPbF->8V/3fQW(O<?bf.GGA4O2b)_4T<?
WN0ZMU8c3T\b\VfgQ7Y8@>:;1Nc2N88W@F97>T3DEFVO,bP\I5a/@gbcYF45.^CQ
U@9#V(4]C&CF2W@?9()EDd8_63^2-9XE@(7JTg<KTAM2=8^:Ufb@dV,2+cE:ATGI
(]W,cW<fC4OKOL./OEF/J9X-2L&CV\]\=U-);_IHY3CReS7=K-ffY50d@R:8G/U:
@>/@TNT3&_7]_d5+U>_F],FWY5@H:0N:c@:?:DP4Y[J>gA>:4eDNg+H-fX5dF)8)
^6:gCJ)AGYGLAA,D00AO,BCG6OLDURff?;a<=^P1R&MB;FOKWT5Na>TF^MTIZDNR
<B2YGX:AD@g?3?6a)1cOA[=L=/&KF1RcdQ\g^2;>RGH8.V(6./U9@1EA4#=9UO..
VF/OKI(Yb77_FTSVA2<=ABNPVI09/&7L>Ge7]G8=2gL:Vd[#EH.T,3H4-3I?@cB@
@bX:gD&=>ZWIR217S-(1=GPC7NB8g4MbgDd;@96b_MWQ&e.T:ZZDEUGbM:I\JbFC
0Ld=X7H+7PR,(FG3-28fUEQ8B.b>fND?aEGIFOVg6ZDU_P(#_.7^e@-+SOC\b4FE
.HKTDK3<P\HG2>8a)[-A>J[EgCY9=;R].EJ7Kbb^ENEK37\S0S3T]e4bO7<IZ,VU
GT9=\3U&7QU\BK15/>;YD\I,FX@LQ)IR_f9U2SJU0X_&8@<28+(0HK;g]Yb4cKg;
FE>f/(#.d16U7+CdX)W.Z9/MJ28#8JRKPg=38VdEd@ON:6+\^TT.,5Y7AL>PF+>U
>fc(([L6CHge&Ce[=9F9UM.GD#.2;Qe[5SR6e\CDg/=((,#<D?<3DD0eF(-;DWbO
77Tg3I+B.[HWBX@eAILT+We3EW8(#?b,_4-APPfP_E+W(QcFP[_Q/MO5^6JE56P9
2()SEOG480b8f]:b7\X+OGUEHDa)0_9B.=CccX#@\_C)8.EB&,:)e=P7L7RCX?2H
-](LGcI20Xb<<K8/QYC;1]<a3T)_=CN5C_10ZA&E2PHM1_R52.4LNaSLf1D-N-:U
[_RPZBZ,EE3_2fA&52AR(YD_,QD;cG?9K^W3-6H)YWBA2P(8VZc(NMRMT^NNHS/F
10^4CT8.XDgdK(<RDH+^?MZ:LE^QEACaKTX-dQK5L5e6X#BW442:#@1EZ4S)_C>f
&[.OF5XA8;S,c;1Q?W-#;6:Y],)LP3IaFGg8&L8^L-D;1WMXS0M0ZHVaAgB;91QH
?D(,\MQ@-6&,(?U3=#dZd]R-]?NB-6fA;=5Rfb,dB_?V:4OI5JdF:34:Z68(?K#Z
b#U>JXbQf1Ya<<e@LZCaQBPMXfVg79:LD=1eb^G<EH4E7ESE1bN)/3V_g-(Fc+XG
<X#:5KT)?TGOg\Af#:cgME+/@N^K)6P2(-4F1F_+GFC5.T6Yed(EK0f-N8EXed:^
(g+@.@VB-1Gaec,P18X<BF8S7bKWZ<DH\f&C@.F#K+8Y#DJc5f1G8J=L3\IfgA<)
.8^L-LUR^BAb3/6O+X3L_&#>)QfZRb\bNW6YbEM-Dd6V;[\WVaHS+9G,^]HWS=V]
Le?6(2H]D;\X-BJ\>a-WaBA?XBB-ba0N@PA(NF+MY1Q]aM7IYc/RX2dXBeUU@KAY
AIBbM[Z-25JH<7I;N+b3:-?(TW&YI?:=N/?W^)<b^T#a##dB&2[(JQeF(TJY;9,g
(MR_C97?7A/8EEcNB?#e4=NE]5=:f;;53+6PaY(MQNSWR#9JaYfF4PUYB>/a8f->
;0=cO4H._ad(VC;M)]@X4B@\Kc_Ka:F1JOL<@Bge_a[bT/a\[1EZ@RLa1@F\KgW#
DZc=GfE.d2fe0G(2+2b]c/E_W8IQa2)2G:@bG>_@cQR9&7[ROIR^bD#5b&CL+KIA
=1\Z._UCfUE]JKMRF(Z:K8_d<@c\#_)Wd4]eN^UBZ07eSOD3[7a-[6WW1=Z>HT>0
CF,c:4Y,gJ6.W0Eaab1[ZCd-\[=Ed+^]/eZ(+B>DW@Fg._(P#Wc>dY?YHX&IM=<^
[M&^EII;a)D]E/P)GM6bY;9NTd(P10e?e,=#C)/Q&KeQgZ][OJR:LV]1Q\0^TTN:
X:7MT7(.YZVK6cbNbCTP,<;_3.5\;KWL,EG@PI4g5H=??9bH=FO[=#WPF;Ad9;1L
Xf_5+J)dJ/J-^\GFFG)04geP5_gS[U[BPeKMcW#?M>[INYQ</,/c;?eW^b=HOMIN
,4[NOQ#Xb3>bT3VCO)^@\K,4\e2CTYV>NeAeeB\<W-cgZ=+f#BY6E<N)aE_LKXQ)
\RY&R\WF-<YH,^I\4\3cS8:]#2Lc@T=Z>\=UK^e=T7<=VL1<SB+CHHWFcbdF9EeM
M/(LPN0L:,/g2QB9LD^T]E^U7^S&_6A>B-CGW5U_QHf/L5YT2Y_@(T;=>,0>IN=.
TE9PgF)++OQH,C3LNfa2Hf\#\<2T-FNMKc[1VX&P,YdfD]EFK#6=T^XI(<IAg+7B
?RaV7;7PY(@WLZ@>Q-d7.^;:E:>a1/S>18GG#9\adEVG2^#/ZX>O:EL-5Q/If)^_
;(6.X_R/U=?.K,ba(Mb?-<]QDT;W5I+4#DGN^/;MM2(,\\GKBS(f3GaPNEDQC=#@
N\^YY1S[=dBYcN_H3b.9:T0M^:a_;bW-P<?gN5\Ub01N\571I:b[8P_YWbf+Ydc=
L0F#>;8CX<72T/4I@X@dUf.YW<\]PD^F9&PP&PLGCgad-LI0.QQ29F_UDZZU6W@b
111d.(^L^#0D43H;\ZR?<<4VOCR(USVMXN[CIQZPZJEW0--bU#YZV>Z&Z5e5T\,F
aW?=bX?MOY11^=XT@@V,c>FY5U;6Ud,RA6d?=Me+CCF&BH/&_/M,SP7^)WbFJ1L.
P^VRRM.WG:NPc_9,P&--Q95.-M&@LWZ0,=K+B:LD^aOb,/bS.Te9RSEd;BRZb:X#
JFb=DY+3E+&aHI.dWP:5+(MA8CTeaXXF:;DP##]:M;_Z&K)#(fMAHCY;D<(K:^;(
bS^.bF]0e4],d.>:)TCH)W7O/+R4e?31g(=35S&Q(A17CJKQ=f+-gVT5fQd&aSYU
cQM:53?Bb2f5V(5GE5[g20[(^FT)WJ\OXTPF,L?Z0ZY2fGPI7Me<HU;:1?1-]:9+
Q)A43>dSUYK,0US\??2Y_S8C>beDR/)RS;F1-+]]1SVO]3)KFLV]F]>bT#._/+HG
3RX;Id81b1^\gK_V)AH/NU/<Uf/=JBB14?>Z)SJM#Rc22d3HY-A+b#_=c><bc:AT
44LcWYQX6-<J/>RTX_)6WFWDWSdO5g4U8#)<SB-cI_0K7#e628K8P(^Cg(L-c9@K
cAIe<Y3N=]SUQFS6)@+UUVC4dF_3,N6K:ILQ)d_B(fPa9.9d/S#LP5YeN9O:>cY=
A<M+?2e+:;MU>#3.<ND#aWd<-WdT_/gaY>Q1EA1REU\a<1(9^\8BfANRUV@21UZR
S)73EK+1;OTF&<H;MK\^>9CH;7PILR\f4O8XbaK0[3ATcXC\E5PW]6CU:>OFNBF@
_U0e;(I?Gc>aGN=I8&[;?Cd[bR7E[0RR-f<_NOM(W41;9[FM2YD?;T@?3IEJ96\#
5QO<5#\EY30eR>af&De21S]0EZbUV]d\C&ECa?^4RA=9SSd+1<B)F[I1/XYFQ?+\
A#eM.9YH?39f-5?[<+a\9QY2aAOeB&g7I/;#]a[.B?M-&8+c.N/ZP^M[HE0M?c,I
fF_]YefO@P=1Jc<LQ_L^X3QdWUS9&1](M0LHWSg04:aZOIf5EW2b[a8N^30MS.]C
9Y3]JRF6/9ZL)OS>>8++G=dX31\77#EBd:eag5.[Bd37FE,]dQR&aNT^N&e.ZCd<
MPR_BY#Z/PL8;=RI\9THfZXHfg0DLcc.5,7O/^4eRM+@\N/]DT[F&50?b?F>dTGE
-J[[DBT9bSCVV:15fgf3RU/g,PN\?)6O^EWD[,dQd[IcD<XTV#BV/PV:(aGHO;)L
U@BX^JE94E+F2d5JJEJ,OEM)e@\;Q1.+bUBIUVeWYB5)aN?-QN=XM3,VIJNW1-=H
-M7\5T@6.)Pb5eaPIU8.RM=5G<:9N&9R;&75+2_T<4^+6F^^fGTL>(:8.4Tag\<U
eQY22OT#D_^O@L[O3+V/;V;4[b_W6RU8.7SEC6/MGRM8W8cPB5J=D=bDJ\V@-^&D
KE;RJHY?dfR@H+FgQJf6MdAL31/2ge2e0?Raf2,H,UeDVNE]Hb-g[10/L/<f>)UU
B.0XD.gg32AVFD1#;^eV-@f7MOP4GT<T2G1SDFcQ+I+OWFaBabTA^@9Yb5VL3SUU
4J9.-fDc1M<].6Cc0:,@U(Z4KZP1#gCGPOKZ@)S\75(OJ&#a[d<A50M\K.H&(J]O
+IQOG277;\aM<:?XE?8aY^:TBI2_[bG+1[(CQD3H\bcgCT2.OQ:,.\f/a@3PcXL.
PC+N4T/OM>6Je#O^]]UDD7VY=Y0#f+?NO/340MNR1Q(;0]D<H8)[/&/bI5FY/U0&
^RKgdD\22XF.R]:QQ^F9\+J8>Cc8/Zd82NKGO,fCaC#KJC0&e()deR82FT[J;QD#
EVcXR_L1IS?bTdLI(UK-IEa^V--.5LN7(?c9Ze1(Ub.#JIW&LV-(ZI6(&0W/7:J1
FXG7V04gXf?HVG[2C;9#IS>S-@&?SS^g.fXQCO?5(RcL5X;c/8a+N_53_0_9d;,K
I1c,?I&C<9_W]5e.g\FWU#5UeKN)TP@P\d.7CG](5P[FA6D29L1>de),Xe&Eb/@I
Ng=e&eRX,.()L6<V>e[f^>N)QX;8JK>H=&Q[51ReAASFJ=2eF.A/L:78MV3VJ1L_
[7B73O0.3;OL]4NYCgb(M73(bWe#2-Fb/g),9>Cc&9eNOg.KMKbP/&)WAZ+LB8Wb
YUX&(YE1T=F@aB1F(.da<WM3WG]AG7O(?;Tc@3:cfYKZfc8b<-MA#6MbPS=U2W9A
D&-_DL\aZP\&#/BQfbR->.CKKBK[Dd(#c(2IB^_O#TeZ534695\\P0-dMO]X?4H;
;A9Fc:E>O?QE.?f4B,Vg@cb&[VP),DbKY3MGfRcaR8d0L_#NLI9\^,O^U[B-JH_C
<DK>>SXcSYE\IU;Ne4@/GL>GCe)EW>NfB]/QOC>W-,8eP_)+<JK9gc/A1N^7N&T\
[2a/?S#f,@E6#-&g:O[J(.eFR?a<F41aaaCL((W6?C??L?JGILaUF,)E(=)2@0+;
=4Y@B(b7C=f^A+30MFA:5]POAUcc/ED8]e<_(3-?B8?I?>JW,3G06D,34eCX[>C5
)2^T1f;<9DgNV</:7Y2C89)\+1eeV;KP=A_,@_T_eXeVF4,+FWL8JWV82RR0DD78
.VDg&-eL62T\b@2.=Q;W.[,_D&A#&,8YYO&4cK+=:<&8KR;S_SLZ++W9QPg@4U.,
Ig6B[_4cPIS#9<b+E:Q:Ra09T3V#9+GG8IB/;#I^(9^LW:F1,CXEeDd2-&&M4bZg
^Z3TGOL9V_Z9@TZBNI-g/9QST5YO2dH;R+<O8J^IdP]&0[<T/b?/K;ge,Z&+L2b9
,Cc=7JE]PB47A8U6&/C9;&=QX?&@WIE(g,N7SaK5D7D.H(9/Jc6X-O-[:gD-9.L@
.B&]IA[-RRJJSeC&dJ-]MePY\PJSDA3DE71POb[^K3LJ/?T(>2Z65>#9J:M9V<,4
_P>V+\6^26fg-J[WYS-8:?BUHJ6\AGM/XB\DHD#V,BfRcEgRY-]-A.[QSE87D?SX
;OZWI9QRHRZ+FdFMSFLWGZZK=.#T=^_@F?./IXT6VJD^Ag0,aQ3WSc-\>5T>IFB/
DW)(5;O/69X-f:XG^Ta(-1^.ATEdeRCe+X/ZV+H4CS^^#9LIf?Q]HY(?,ZZcJ0>F
_\(S,JHV.5T13?a[@L>g3,b6BO6JGG_Yg[4K9bf[#Ya82+;U,4D(>UERF^dNVZ2F
&CW;+&>b/eXM-^M][Z[HK_TF1H]=/<cA/\0g1];-FONA5X<Ue/bDD<,-.JD]ZD7;
b@7HHcU>VTCT8#\.2=cbJ&JVHX.e7b5\b:1RQRT.EDf(V19<&b>\^S=,];-4NBOR
I#1@?^De+8^@TeIG/9O2SAcNC^]F^6.ZXQ>I^e3IDfSWea^0M,c=[\1g5K2;C>cA
T9_W)Ef7,O])1P4.g1?JLEFd8>L+F4(IP>)gJ[?4BC@cf@aPUX,WL5d2F:b-b=O8
c9OFNHW@&Gf/+-f[2\aTS:OW\OU5A45+2LAKMa[:gaX<<=a.[cVBI@MBF0XWS1:R
dE:BH.MF3NdTf:4]gNJ^/Rc>DfKaX5g-,+@L.LQU1Bb(E(+&=&9XUeZ>fE&Z2#<Y
[KBN7cXKaC?A:,&8eKIW6/2IH(;L+KJ[ReG70/(]a;7dKc\V+3MQ/fLZK[A,04b>
g&FZKKN:2^UB35)g9C:IPM3[?16\_bB]aL#\6KQQZeB.[5VM(9RUbBSDFY0b]gUd
8a4VgJVH=P4)>8+3WHK14)U\_^R]&d9@8C45PS0A0Y#=^AAd0&Q?6E9==R?9&2ed
QQaS7FWZ7K;9g+)5#5I].MZX@>Z+1QVfAb6:=Re=c/VIQc.CUH2,/D10f8@\^;[D
ZWb&X8+Vc=::]28UV2:D2HcKS:K)\-Z_a7)NG)6.aX2^Bd?KTfdG,2SY.;I9)M?1
BaS[QVWW1>G(=:=<6<B)//5b)f\V74^YB(]2#D-67)T^>(SSd3\<d5-N:9N:/+?Z
@Ag?W+YYb^(:\_#If>&g)Tef3M]M2F@E>8]H+c<5X?_\]?ZV677QC.KZb;NYgN=[
^-V6&>O+,TWYZQeL]]=RPXRaMg1/JQQ1e;[dUgbY+)ID6CJ#.-4g/9ZFa,^>M3eS
YNZVDCAZ.:_XD@>H@IG@1D,+5BgCEE;f8>^HX8WY/5G9bF.@#833Jb[)R@WENC.G
WMgdFF9gG>@#5RN4+78\^?#=bg:SPPIKb>@\X2\gL+7[NPC.g.@@A\5L+.0e(.>,
JgB]d<g5+?Y@/3A7F83A\aA5YTHdO2F\X#[^L.QXXZ(Z6<9eg;V0MdU\Jg9f)ALf
gEA7Wag#W&OZ0+UFGQEC4[H,..;_B-(QcK4Z@#K:R<0=A(De.^5\>e?WN63G_92O
GWYB:/<Vb:SDfg03B-VE0]C#.^_]5[Y\UCWcED10+6Q&\GO]AGc48CNbL.O)<AW;
QD9PR3L#gGgfL,AeeP_TMU^=/2C+]g;;A8+4b<I7F>1bF9FcE)c]:YFYS-9^^13J
F=V@F?IZ/f[g00F;fUW&[L(HJ21C[U(c]+FCJSQ>M-1Y0DV6Z4Sec=C1^+[f9^cI
O\d?OXO#\B7Y4EHUI?N]7BGc@QK=\]c5dX\E<?GZ8XP?4G9,XS4Add/56VSD6DLI
f35MS]eD3)0H5Y<2g+FWM(_4e=]d(Xe;C=CX,/^1ILM\>Ue]LQ;eZ/;A.O^,G\5N
[/bY?>IA])Je2[GS3;-dSYH;ZC&D\TN1T]D<@5Ob2DEHJ:[2a1K<OJ3>f317&9S:
;@]He#2)&J>SN6NZ\<Kd1-PN-LGUa+9&g&>gMOg<;6ec6L1BL,DG+<I:#V7_-f4d
2))ZHaVM;S9P#Hg9_4SfMUS4gbN7(d03DadKB)?)f;Hb;(7,S2Y.Aag]>4;7]/aQ
_P7^LXWM_]HbT0-\e>P<\__<D\>W/FaJ(7:(N5(FJZPZ3bV2YX756D1D-@X:eIE7
-Je;>.NG5c2QJ91+NTM3#fX.52cd]e:B7\0UCd>CE8WC@&3C0V28TJAZU)RM]cZN
(69XL+7&924<0-9(;/F,XJCLE/#H=L(/KN/IQ^\VVO\Y[DdTb]VUd]a\)dXX;c[E
-\#eVefR+Y8-OBCCeac?-4-^#5HeP6>1A6&>[JaFQ9K1HO\H5g;;F\L1,T\/\Pg[
N#>[FSE)UGb8g]b81D.C,fVR;8Nb,J1Q9+6^Z&ICTN/.dC3A(Q.@_NG2^S]b;<;4
6P]S\T12=;d2L_f/4G]CgWXS@VH_b)M@?^EZ>&>_H=<DWBQc:(MQ0Ta^[0@3beN]
;IG+(#L9f83MLN)@#.=43,MA9[4PR_6#eA2@Z14BOB3M1:M6]?eYf)0L,0XQ-0T]
?)\]?JPP331/&LNE0a-K(WG+J_&7d>NO-8@DF_?dd5D7&Ldc,@#(L@O(T7_g]:BJ
]6[0>,_c5:XBX5JIgfXHN)\FJ])O@I9NZ4K60VGIO><L?eR17c-CfTO4V,aXJ1fR
>^0JbX]T3KM7C8B?[ZQY8M@P;NK@0RGTF1eT.UY3_c1+B]TCSP5)5dSa.UZ#2CC3
NSG;SU\#gXTYdUJAL>U1_RBEE)P+gF<K^(4,dd4C<^cBBTPe;T2E3A6MK-2ce8?G
Z<-b+B]\4cVAfL4+)GgX<-3NafcT1>4UeJcFJHTV,d;1Zf)/^+0#.,-N\4=aS2^@
D#>Z+eG@4<5^e3W6HSNX>2,b8bWO;JXTg5NU5K/][[.C06&Rb&YKC@6TF6AP6DC/
9SECEFWW9M?cCCJF8OJ=98],=<&f.@T4BM]^RT[)APUNf3Q5d9,/EcEcAV3)H./O
5,d]Z>^E<=GG5URbA5P,W3Z60YZ^/BaG\H9d.DNHVg62W>?C<?=c:E1H#c7WObFf
C^B#GA5a<eTB89f5V]eJ.8:feB>4\=d@Wg38Q=c)2@?BW^YdI[)D,)5&a>fdCSg+
OD>3Z#bS#,P;\SS]adHVca,-M/8DW?Wd_[TC54FU.H,39UXd-L0C9M5/D16d(3)I
de(BO,0PV8<F:g2=08P:;+_A-4,EN9X4L2R?3LT=;aUL(P__)[7OJQ)d6#GKT[F)
S7>baI[,W)24N>/#cD/B(-RY>e&U0a;\2ONC_=]G-QJB:PP/5TS5a7]186Me??RL
(7#F]Z(4^@NH]DLb;GK+_b2ScacS?9bX&<B8/#\I[4F8gQXD[\Xa-8\PD3;dYV&B
CLdX8PUSOKOQ<RLRNG0EaK+##8O.WEQZ<cdB>M(Id1[gC]D[c-+HDb1^aHOUBaaP
cAg\-\A?6XAcR4ULAcb.I]5dc_55fI5L(V2FFgK4-a&c1/+J&4U7^S]Nd7&^XM&\
O)WPT51&J6N>C=d(7CYF95fO/\Ge0cMQ7=6-7cX9_ND[V0(@cHCLW]gS@I[D;E8/
/2_37SV;\7b.TF?dL];?NNKReF&Fg]_BI,[UA3.;,\@;USHa0,8ZdGSf9@\>HL@H
<^EGBSU0d7K]e9P.AA.7cB#]F^/;YE->Id;2X9<367E;E<=a:+W8NbUXXFOa,0,e
W>]J(21.bV?Y#4_g66K[b#.>[a,?]N>?\^UWc5+b6K\.5GQX4fZP&Fe_,ZbdEN1T
OI8(>(dIf.AO1I4#<2SNg(3QH6Y0dW)ce0__Aaa26De5ZYWO6.VLOP6-c0c[W66d
W0JDKKSG6e;4C2A^b)5bbGcFgf>L@XXD1geOfZ2G<52<S&ZP)JRa:@>?9IS6UHA.
C#21CCM@Z2N?N\b9PZ\Q3RYIU5K5dQ-_7a(@Gg7^.YLRA96FDARY?;;POX&Y]b/@
,=@g54J#cR2/[V5=b<(=\:O2gWJL&ODa28]XfDc[NC?aN;PD\P3,0)PC5(=R451L
F_O5UHFcb&>I(,JVe9EOTZTgG2SGOV@^A5_d2Z.N;7C6UcBX2GTe)<E/V>Qe3W>d
0cZTA??+fJ03BV54_;IH4H_&6I[3[/X,0c<b;ZK;;MP6.Ec4>9?L2>[gY\\B6BQM
WP3@(gODV;^#+U-^#+I7/DP)E,?,VN;QATM))4<f9\&A5@g+2]_b;SN/CEV(#]H:
=XTb0E:0,S02H]\NP7RJ8GbK_XV?=fFN8G3ZPI?)YFM]_2DG&MJb?gBX]+5Me^32
OIE@ABTEGf+e7,ABG6/T3?LG0?,R#bJ+8G/7_V44C)JK(@GH-([[HaAMLeX,\ZZ5
CfJ^\BAe>R#\Oc1AG+#O&7/KS^V4GBZBaB,+<\?)+d,1>c4bgQ[Q8d/&6^\(TGa_
V1VG+NTJcXPX^322G8I7&)[53eNWFb4D_#R5dG?FEcbAXb.CLb(+E@f4PAHLH(.a
[&X+,PR+SVV.(UfD\d<R_L7,1]9L(KE:cF7N;8U_+f,T[/fQB(/eTc>/].7_b<9=
U94PR-HS,C^E-g^dX\6e1&<L5OYHJg\6b</0Y(+If#gbT#OXE[19KV5HS>#6MS<C
(Z5EGZJ);&]^_-6TWD\JWWKS)cZS&fBP?VI@DU9Fd?BY5^)?DJbG=LQ]cW9HeV1)
I>:^RM32:e=fOPATB2JGR,/XC66b\AOYcPCH-P8JM&@]5NeLQbLSKS>eTf-,V86I
cZ@VB?7CS8[5+;_e@Zb;T8G[=OWOFMR9#>dYAa4EG&9ANON\6IZI-dc.2M4G_#&\
dKGX5?<b@Y3;<=/W),)H1b=]g:caGC(a0(M+SCfMJaN6H;g\8d>(:O^D3FJ5]MO-
b9FM@FZZ9^2dTLD4bcG:ENSL_(A_d-N_6]8dB5fUM_5e^)L&EBMD(0&]_OPG]<I#
R#)VL.P\4#-]ad)JM5D>74V7)NO9/b09C]:Z;[NPYI_Q(HE^7Q.]<gF6FA6&\>:,
>DL+XMAX_9ZIH#?G0A[/H[8JV>7]Fd./5NR^P+<HbU>bJ4&F1JH(&7HVHN<^P+CF
RVU,Se9O4I[Ud6&K8;gKN19bg.Y&,@c4)V00+VY:OXXPU.ID?_5:TF+@6?O_QRS<
]FIMb(NUgZ6ZPZ9,2)E7c#0W7VR#M1F)=L.>PV4MOX))BW95Sg)f9B:A):NDg&CG
0LGK_=TKLfa=R8bPDW0W/(G^FgK7N=g9^L+#1L:K0J9OY@?-N<gY)d-0dZOKQWSY
Wda7QcDZ8=6F2=G>bdd.:=_G+;OL\DMUB<UNH;LCW;R3:,gaAQ<@DPF<@E49HXVI
c5QQBK)N2@L.OA\-bF\5R3>W(S=XE)1CWZ+QK1DGga6L1P\K/3<+O&HJQW(-AZ=f
4@C>T&(#J+7)1dK&IUMHK[\>VF_F]aZ44_BEeR[(I6-eG63XL7bS&[I#M7T7;0c&
6THBSWHDCX?Y4SS>dA62Ge=gP@-Cff?U0E2:[@1&H1f:f_7+dWD^:eR+G_<AH;3U
d@V-(^b7dAJYg=K+DW?@S3e^SJ:gH_42ZZ1\:;g^S?VM-)Sd)SC(>E4dUM^8+C^#
g2#4)T4E_I\dVG_7U5g/#I7Af(&YI.OGT0AB)0_,R-Q8J(XJJD>Yc+0AY;0\T/86
\;&?O>>g9RXVdF:5+RO3,1<)GPM\5GE?BU-]F]?0#c9_1EM5#PHOC&PcHZZ?O^d(
I.\P)4[HB58,]OZ#FLI.4ZVTE9GD209JbR8EIA5SGX&,D@:+CeP==U^VEcOJ=+LA
6<46H6D?g8c1aJ>&Q&_bF/c;?/AW^T#LJGI.18FE6SEbNAFI#E;/#>3.T)f<IW8Q
:eQ\_J_2=,a(X?)XPT[:9#gNeaW/IWN&)<c>:Sf6IXF;^QX&^02X;&eDCW>GP:/X
K4QWf/D.O,)BJd8HGSEYW3<1RM3ZX+=2KC98__;UA?AQS#5JXVMY)7[A<L,9/S\J
&5D(&fK1HK:e#@BPO.1DQK@D2ZWcT;P+J469\X4=Z_O\=H=,?2UBZR&a[+IK?+[0
Y6VA>33;./4[/]X)YbcZA6:<(#I_0[M>Def(Y#Hg>9Q<E9/J(02^#JFLP\Hg&UI&
>JWZG-B4V)FB((5\-&XAG-geDQA+aIHFXD^CSJVfD1b0^W9>+dJSA2N[(WVa7AW1
fFT+3#,)G_,G//MPC[3c<=TdX=f^I67;5L=3E6[0f.8]:T26#3(M[_UKXPV3D?#9
24D&Y0KPD_&VIV;E7WE2.\D/4P0]A)SeTBG(H[7]ZZ#,3_U)80TaRKd[d=E9PBZR
QG6[b_?KVF6VJ722O)HJ@B<;HCAd5W&Kfe;aBT,K:H+I14KBZL__IXE&6N09g<]M
-D_Z,2.>7F/QMD?B?-QF.\\\9-W?TK0=6JD:M^PAcKROOB?\[5Q^^U3W?O^C[LB3
ee0FN1[f(Q7bcH5,]@2)S2/#.(S#G8fQZa9Q\Y-FcV^Q9\PV6BML+T4^MI</)U6R
N^]8UWXe=;);S5K6@K/fRDSN)6O#]9_T8D)B3F^.PAAfH>.[bg#cJ<66LPW,41;I
b9UATSeEET3ZAG?L?NIC)fe18#G<3@LYT9VE5\+KCZUd;S&I]6Q;6<J/RPXX:8YD
JgQ@/bT677bgW/XG1Q4>FC69651S].a:)N4T]Y.9K;OcP<HAQL;2AK/f?W;Q[c]0
,ON&0J&PNEV@=PHdT4][PbZ)-U\G6@Q#_0Y_f0=TRI?95c_[^H-3/LVb3^7-(P>)
)&&VHUC+KeeCS1;A@e-a8\F-JU1gC&B,g>9[R_caRC\I#@PfLCVU3V,Q5>=D).2^
^+^dB:G+(\FWd-J:FL:Db?KE+V+)].Xa<HKH(\O?&6B+2]6Z&MUHIadO.f3&9IA@
D;e((4O&.CIX[\;#W\O.4e9>PK+SX5E=Z#YFTDL+S)c?8G^&ES7g\a^fFO0,RKAP
e[C4CFBa20()UW7BS;^Y.TACK:(+G1:H5U9A+FdDdKJRDGQReWN1,9><VYe)66e@
1)I)cY5I+cEM:]dY^C\B8HV95Q.EA.1N_P_#_B0gEV_5\OE(L[\H^TI5(VcBC>9(
]8B2]\2(Y_@a#FK(1U4RHVB2[;_6]aQLVNPCXcaP9T45VH/&+eSYPE>SBL)#QL_f
HSEQYW^I@SVWL)9Cf4(>Yfd(YHU=fOU55V&gLFTFO,A?b=0dAMTM7Hf;d<gJ3a4<
.S#F:TKVN7WG3[UY/[XK;GQLK]W)>e1&1eG([[>+Ff+EZ[\/9?dG-:aT=(ZcA\S_
V9Z].RJ_LITE6JCOEQT_0e=6;O.^)TFI#AS6<;N-2[LJOTA,Q[A3P#+R83-)+@Sd
4LPRJYM9_B\(-PPR9AN\SE54fH2OKR&+Y/SOKAKXRRL]#AfRTONU7A8(Z:Ma(.:Y
/XP#FPI:TFT/<bgc/ZS\QX#RdOC:C85F2E:JS#\NBVLQ@R5Tabe&9c(K0V-YeU@L
9MfIZW12+H4E7MEO[-=C?D]E@cbY7_EQFMT_?>65.OKM,X/Gg.)VZPP=#NNf6<cN
6;F8N:0>AKNfXBO(NRHHFMCfGg)SIaJ<X4Z6XTQ2A,Z3eRaXZ(RbVdX#g(IYE-[E
T(@P.9QY]4Ob#Rg6(8@W\M?7-e+APP-OA5VW+W4/f0Z-_>](ZI,7XfaSQMQ:+_]]
-#<>/8Hc-6ZMfEf>D6E2IE<JCIC88CP-Qdfc>GU\?JWV8e>?<5f=gKB-E0JW-I/3
Q@T7/AfaP<23_4ad;UQQg986;c-f_+7R\),#b3RU_A[EWL0EGC>+,581(,^RGRX<
fQ<<^C0>d(BOFIcQ?/HP?>e?[TH8eF]M-@I9EX2:MJ4eV46Y5aHN,@HYd=-;842V
\^ab1L\QJI>6YYF)J[,A<aOZ9FC0918GY&?-WP,HEIE-Nf23K+=,21>3->YVaF-D
=NW5L\4#+C.8gEGJUO]T_4^-dcSHd7LV)/D->G1d6<?,)[DKW=H5<4J3-b^T_?aW
FSD7a0B933]T=KYW2[ATdNHYbd+M[UI@\JW#dfHc[Rb?B=DG_WfOT>-fP@TfD52X
TLQc;aBMF9<>D+579aKA,NJcd.@Z6ZYPJ[BDDQZ5#T]7\S\;>T&_+C-]d;V_a(&e
_V4W/?AU/Z19H#0#UK>S?eddWbU>Y5.MUP])\c<4;N0A]+\6F,.LB-=SOUOLc6EE
<9Ja]bPDQG-,E@W&>_]Zd:f?R=I]1^c7S96Xd8\LBbE0UV:R7MOP5H6EM1&&^@03
2(8)V4,B#+bFH7(H2dKA:>(6U4>eZdRE(PVH-JRc1:)0Z=K>S]:RH,&\/g=6_C:)
\=@Z)16?8.fM<S<bF:,Y1FGEfb+(HN7@<A,[3XJc=ZC2.\\8.3@;9G?P-a+([aG:
\^.MR7c@PgZb7:B6TRC>N8YIGK5NL;WFO^#e^9[,>.#>1YR7P#J<fY2.G7(#R)N:
KNX_=G9YO:A:G)f=T/D4S7\=X7>JX9S-KI^/=Y]]W9+Z9P_7V13/Ne])YYM7E(>I
e4&U1/MZeAU1GL:DGdFQO191)#4&W#1f3@FPJPY=FG.S:X=Qd]+C85\QC<8[7B)&
E)=:YUJeS(<;7,,@Ed9:\E.K)_KQg5W:9\&2_W,):J/dN&-@2:HcBUA3,SSQLB78
3Had\RfUc/5HLP[N49U5>HH_geP,DKF[_JT<U)=UD2-25UV6BT+_#eG:M9__KeQE
5?X9aB>I7D?GK-+6M:O&:KE)OOFQ@HLX4@2B,4HT^GZZ?]S<7LJ=.Q.7E.(g8/LP
d+5YI8N-;gT)=_LOO8O/M@.a(VD0@+&[&K,f1,=BH<BZN]+6CcA@a-c3Ub>J3YQK
Ac-KZ.GTR?bPDZ7egIG0,(fafEDD1D)8;T/eOWRG=BBCgd;KDggD>_]U3g]2MFU&
gJ]QRKOeB;C(b,SAPFEO>=;S4\@AAHZ<5aSO>MV#0);c+N/I]]0S-c:.0gL_^QB_
9TC?5bW<HfSbWX<@248V<QF.F;VCQ]&Sc[NF3F4DR+^Q-9FJ?@W>-EAZG[FWBYVL
-2/EER_e]AVN=?6YFSaTZY.,M_Ac4][+H+VQ/Nf/,3]\TeF8^FU<OXDX,BEL]CMK
I@.BHPgN-c8;6(IG#?]UH\Wf5be0)#HNT)Kb94F8--GDbG2D>\>EQF<EfV?0#^T)
Y+G2e@=L,XO1cN/gE2JO>BMa?Q^b-R5LV+S6UIO:7X-YEP3G/V?_<X&^LQVEcW&<
BCL^g707)>HMQ\>YB_fU?&;0NS=ETWaTB6WP^ZAOGH&)&dV1A\WdHB68481FA9+7
U+=:L9X6GSI^/-L.YAaYL_eQOSE3][Wa+SQM;YGfR0X\R>=\AS/L59A\+N2Q#B_@
fd&8,8BgOJ81^SPbM^?c)Y^8?a,<<H,d>?-cfZNY(XJfg[IOJ_81Y\++@541,g=D
FUaXdQ#g?4(O:cfP;48B1TIIg5B430XZ_6YaE/]J^1D]DBHI5_=535a?f1AdU=.C
E:03B.59F^bAQ6J?F(50c.@MCW+\(./?29D3:M=STBVPD<(RdO56b;eMSJ647:S^
V-QFd&EO9fG_J7^56M.4-ANgJQcOeAQ<GE]S@6eNL>dT.c4=9[[=Z.H/LZ#=U\,@
:>>&A@L6ZfJQ:g7S6/=A&DR)be.;D<RZV/SUdT,B_R&?^TZ3M)P&..EO4A]e[]E(
Z;4eIP&0RP]X]dg?F0@)(QIcEbE6X##]KAYZ?P_4RX,gD9I4b4T/A2XK[G7K42&M
6gNG6A0SS5)_CJ6]1Z7(C/19RSEc-c#=BP6GWXOOU3b]e-CVZ2[RC:XB2\D/K==_
9_\ZJSBM=9/W>TO-BE\#>;\X?@G;9@79,Y6EI;5Q]+(SZ&04R4PG]aL6^+U5Z=@U
cEFU>=3QAJ)-L46cK-R5_)deaFJg;,XI:4[:)52L161_:[5cY,^VIf_Jfe0DFdaf
<?5_K:[VQP3c#S,&U.7+Te8O7(DYRQcD\^aV)>H4R:c_6[>H8VN=82a2?bc/,HUN
@[:I>9H[8#WbQRf<g2DAR_P^PNXg4?TDQ:2DRSET7<>RY,L-E&/7EK=(g5(_6LFD
cJ/gWd_cD0SF+HE8W?d[EDdS&/9\I6eF>6P(19g6::caGgSc6CX^7gNBYbQE^G\F
3PM]ccX/2cR0b[DE2S8N<Aa]9,I0TG/[>Y1K6?IZ3>O;Vg[YU(,P2SHCI1?U(FZc
^Td3?A<T/\LcNb8:M(:VaY9D):K2gT?^A<=K4RTScI)@P^</?O.HR_8C2ObD>7A.
a]_WV8-1D[Be8b8QeS3fO\:K#^CJWIA;V)\6LO>]T#^W_;@A<:9W+67a^&gHb/[6
8T^V#fURE6eSb(6^W9>ZYOO=HN\QT4cYYYMS9C])ZbSIc_H2KNa+V_05R<3)M42M
aH2WGN6G-a];GPf5.ETUVM3>e/VR>6I[]/Q1T,B^TEU_3.N6#U77F@J<J0&+QC3_
c<_,:&DcKf<NU2_eIEALdX]OI,,270&LHYK.3T5eP>T<5=T8+?]f(A79--]@(Ef1
AcgZP(//f>(6b=WEPV4>G7gcbC(@&/BX(56U\&+0(a).#e)B2L,&3.b;<.VK>R_8
_ZL?UB_>SI,UL8E,V-]149,::VIdgg)V2CJ/]TgT\dY9DIed-FG@0@E+B[++H1d3
KM03L=2H-DdK[V+.=;]edAd7<3_HLI74.fgK</I<N+2(&(?2g#PG]^HV;JIYB@<A
D\Z1PPe8@V(1#\2e4S6(_C1Z2N-#RRW.P_-^cTJg6\2P]1aVY\>8V5+^MdgP7-BW
Fdb(/S8e?#L1O27e)INY4LSeI?:;Z1LE]MCN0b:HZC@YM2-(=WDFP)6ECF9#8I3_
cCX40J<Y2YD76ZKA?2[W/b6aBc=ZXO#598/(@aS1<IXO91^eRCdCcVD9_58<0YT.
fYO-EL&X&LG1JJgc6BT,<J:Oca.d7@?UQd[WO5T&VHVg_FDB-Z)G,e#@9G1>RFB_
M7N)9aQgP\3LJF47F<L)10K-;FB/-;;U/CEE4BGLBbZ&:RgUVf?6-+?Ja[^-I=)a
871^5/9><XYR.>(4\Y249Ka&]3OX6WeNAZ@JP2E8TVR]JcSW:>/Ja9<,];O?Z(,Y
IM-_EeY94,8SRZe@53H)cb3X_Q0PBJ/0#[_<Yd.ET>0J.=5@0Z<f0MVZMUKaV]/^
XQf5HE8_JPPMGH=VJO^7TaJ^IeY&_@O))(<eHBaX1UP:-aOPV(gFM4J1Wef7,Y9T
E6AB-N&BLf4J#X?2bMX#^IM/+b#gQe@PGL88gZ.a=C[Fb>>[),&>,Y:\[YANG\\2
]8ObSL8c6(CLb+QFaU,gSBUM>565MFQ,3=(RKD+2C5cbBG18@Oe(@Y=0[E]41:S6
OG[IO//Zd?LFPT-E\OB:G/S]^KP58DbcFdW+ZH260#?X2S>NBRC:LD9+L63K0_L3
FA-=b+F.]F6TbB;f)I)5B.-6<Of1<\L1;1[(.EB(-gFKG(LUWBT\6LCHLLg&b6X5
N#CU;7a+?L-X&#d0:ebHK,Y4VbDVF4>+g6(S#3a-/Y:c,H[T^+HSg0TG1dLeI4P5
9^<UdSJbCILAO=T#QFUW<,CLa.CBd:1ZO-\V6>^&XaMQ_ASLL84QK:WZEdJV=fLW
==AaRe5NQL_5/M(A,;LG;>.U^+4.1.)P29eJQE;7MPf>CUL1HBdbfXaJSDP9=2cM
D\OdKZ4O=,Jf\Q[&0=GdJEIG?-RMTJ8T;/.E-e#>#;g.^Gb7CBNN16A[JZa39Kef
PaGO<<aR;Q6Cda2PM\.abQ8C<1c>WVTL0&UZ]M=17[=&=UR0A&1XE\6Y(6)3([;[
A)X;VNO&;Q[FX9XA/3e:DS4KO9\VaQ8c>XLV:U4GedOe(H]c2H2b#OEJ]VfI)O>W
GX@/-X]Ng?cc56Y>HQ2GP-3AY355:R&>Y@/C8U2EBLC8,VZIL2LM@K3:0d#?H@4]
W7JV)=gM7S;-TM^M50JfAI-I3>JKf2GQ.MgZ6KMNMc0LS;SYU6-g&:3H)0GG]N1d
09Z+@g_7gZ?ZM^4e&TO:SNNG2cX2,;OP6EEK;Ua>e>QM[I?H4]<U>D)/JP7a)UO9
?PFZ2YGb]PFG?VJKCT&LdJ?OBaQPBN@W>\37IG06&Fg[#4,Z;&DSY+O?TXZ.&eK_
U;\f-;MGLI\>5E]FNUMeH.EgEBZ;_V57Wc]AR.b#S0Q88GWfQ#AZU5PG5P6CIb6]
>Q#_/P(?Z9ES.UPgMbP[(cb-NYG5RE]L\=7Og;Gg;?g@^?C79I,W[SY4Y@&I.T8D
aPQ#Qc)4N>ZP([1KT<\.0TDIU:BS>:-WR;Fg:&>FA:16XYT0ZN=62Se0_bE@NF6=
E&]+_LYO\=965U&?;HM5IF05W&MQ(b3NPdD)F=#O\D=Z4g2FEgDN3(O29=:eQ\X/
Mbg3Y),(Le2SLZ;;>/W5b^eeg7[9YIBA=AfQ1O6c_18Z2U+15c#EWfed>0:-B<\]
94f48N0>5]Sa^K_N]c7LID4a[#)18]1?&IJH=OOeY;]X/^1I.K8CRT;dGU9ZGP\#
;XA.e<&?4a(8I_RQg#G81&]+7RZfV698/OQ#Z//)69bV^b=AR9&\N.2ON9Y]ePTd
=\@4b(cL^.0f.Tb]88]Y>OK<^;F05,S8IP/,PDV[^[&7GLK><,ELW2<LLYSB0Fe@
PE?U4d)fULJ=g7S+Q]COBN)<6-:01+&GU?;&BZK31YO2g2RQX&J+7AKU)38,]VZ3
TYa@X=G>@+L7>#_8dX8=\I,BNU33e[_(^ZID:?ecA?:e;e_Z_a00Y7(@OPEY<b[A
HdeJ7E,J@6+C^ZD1b7]29[8V7KH?2c05\SXIAVM\+E?ED(F.52W&33#;?X5V,e@5
OVI3VeRM+RHOS\FO&<_A_8=W#R=QJb-E#;].AKISG4&<.DS@0cW#C<_@?EGI\<PO
\1&#N3_)\W\JZID#dF;PE[^;\C6@=Y+J;JL\E&UX^M5TA/3-3HYNN5TL-7f1IOP>
ZV,+N7,3?(S<6AP^QO2^81a\?UN6]HGJd55<HR>4-2?J/@\XCJUd:-a^:[V=5aC?
G#adeVb:Yb1#A)X52K;+?:75g)gJ4,ED=]::J6B3]5F2NO<0.?L6)JY#,8R6RRQd
Vf.VdARcFM39ObdZKG<G&J(N=X.6/GPWHEN_61FcQcTT<H/:Q@OXZ.=b2Gf9)D=X
BX>;ZE0VZ9Y;_DE1^BcdM5G9,TCTM@99>&@)&G<QD43LE</5:<:SAU2&Cb-I6LCO
gW;@>\[T=>a.9D;-[fH)H&=<FL_[OPc77Y&(Ka0BT@S=1#W0,(G2Z>YbI\7VQ>Af
?,N2NNB75KCV_-VWPG6=VM6,7X^Q^:#RHN>=5),Ka_8_C;Y3N]E<1SX\(@=NO-9M
SSLC[S9OZD>:HO2+@C[N&1@,)[3K8G)aZ9?cGF:7dQ9F4WK=C+@M=AJPJB#/BUaR
McI4#18[#V7(6=fZS@=4:MADI3,Z.DN1,@fS4/-Da?ZRD:f<;+[Y(\JF#3__Y?T:
)SO0E;Bbd-D7Q7A6G2VPH2,TVVLY8M3S-NQW=EUbFZG8.V<LR\6D)H-c0D5<:BA]
CO(Wa<_TC,]PR+1<=UT_0SHVdW93ZMfX:I+,+4S&P\S]D3a?<@O;;@YcXJ1=S.c@
W\K\0/7&#0YgPb=b(@Z9E0W&HY@)(Y1F>H,86GVMF-<EfKb5.J>76@.b3eQPF;L1
?+EV?]<>R5ZN.T0(H^a\2SN<YIJg?=g-0aD+DdRZ_7.-HR2FZ5^Xc_BTYDe+^f=&
cbYdCFI#+.EY#^\ZQ5(I)c[Z]<4?)0>Y<JC/L9T<Zc2/MKWJ#M>?=P-^1MGB<G\K
?Q\;IY?DB>(0+O:/P2.g58&2YF0Ve4I:ZRfMeD;fcOK)(R:0M8[JT.TN\ZKJg9;5
SHEP]]\BDcMb:L,5R<#8)RO6Hd2G;1=D<Fb<<=RM2DJM<88[6.VFDDO-B]1<)OL+
c:><P&aC&E(&0<6GIOVfD5PP6[;NK6R@5:87[[:fc-1DS=KA0D^+^Y->cAQ53F-D
Z+K&:UDN.=.\^WO83-fe&L:5CP:fK>]B>),9K&-UfRO>M04P=gPL[K(>g@AQDeM(
OTW#^6OB=;-9;UK+HO@b?_?#T[PAbc/(LT00SU??F>5EG],4_P_)C@Ae5:8RebB>
)VcZ;3VH.=/&ZJA4LM8IW1^F\P=A_3KcXX+3ZU958\OM7K(.W<1_M2Nc/IGJS+<U
]gSLeN=gfKBRP;.TRC1SM>Z;+.]M(AFS6H5.>5-ZK4VDHC0a,,L2>89N/7M[8:09
R^@<JdDd,0;GcVDQA&GcP+f4gTZ?(>X)]XK:2NNIPE(TAL&6fKB]>J]e6F+2[^.&
\NdH6V>H:EO)ZYa:&P:[C4O<1QBK;]7AJV0+,CITa(8L0@eIWIRMb+DQICNBT6Pe
MX8S-]M<U/H<(efUEgcRaQZT,6MDeZ+K3+^=[Q._Jab/:;BdFOPHW=[.W@/;/@/A
L=[[A56\VG(=FREd_e2XDL[d2Vb:&6]FS7EF^Q0Z0^^cLOb>D0M^R&c3]G(/0,B[
#W,DM/406-Y@LD4N5.HHYf74X-4ODNOKGV@5baPMWSTGW2b5(;.b3d_fWPaM5,,Z
H1T_AN0WIA-;=_X9H/Ye^Z&&ddFJ\5\5.g=._F3eST#Ac6<+1JS3LPZ[P5U;(0.C
A76HaGURS:ccXbLcJ-F01C0B9Tf0=&)fD5cF:a93&/@&Q64UGPY]X),Q5bX9,.(P
<LXT?Nd>0+@eD?E#6(c)(&a?829N9R@b-.GM-]Y<OT0g9_SSKWgW)ZEBLc.W4J?)
.7aYTbIP]/0YULea]]H@P(V9D<R0ANLCGN2\2@0aLIKPCF7;0:GHbZ,b#+aM]F:_
-e2^_JEca[[&1\&31faA2NcWJO0=M(GYY0M2cV(eK0C(SA?#GYJYaf_58Fg:\e(g
R=ZJ(8bZOV.PE]VPGYbgK/X]QM#HbHgZM1RB>D8ge?NO+.WQDc24-6C;-ccKJF#[
X[fKXYKZ.HCL^3(P)A,1G^]#-g>,^?<8I>MKe)>[(WPR9L8;ZfZ,G^K+_QdHAL@?
V1D)KL;ML@)0GL?VHO+PO#@.[3QRF4MJRL@#CM.DLbaT5^^6[NUIeUaSaOO4?+G9
&L7e,5eN9PUTEUgQ-HZ9[;2^02MAA2A(2I>1\g(2S&3GEY.8+4D.D=#Me?(Z.HIR
[,CA(S^(E<=LTPAccLbN>:6CHT3+Q(=)MW,[QgZ8;-&&_[,a\(#E:\T#WFRSKG/?
PGAaPP=\.9KJFL34D5_&L<.:5=<>Pa,WG@.9RgO7:5ddU13&4IZ^Q0LeO=54Q\Hg
A>Ad>\R=DO^L6UD;2DHM2^X,PCY+GB8K9A5dL+T)g-(eaBe=SI4#Sb_)M8/S:)#=
;>+Q4YPCb9OFc]]M(:B@@:c70b)>^B4??[B:8UQa3dU-H.7YP^-;U,c][:Q8KTBM
3cY+M0QeWKN^JH4]-,fLGWRe?A))fTI,MDF)TT3X+B@__+@#+P19e]f/LfA>CW6U
]_>T[R,H,LAX9PVFcZBPD3:>1S-DANT)N=6bP]?QeKB&;g3)=^DDgfE<7.+)=D#?
LZUWM(>[DN@Vg,RE&\7Ie0DPJ]2<&]&3I_9K?N5RPIT&S_3c;,]LOZ=_S0FUKS26
]K[@+:^_d[4_Cf]\cV3f=^HgM]87G7JX<g2DTLC2NQg>/XRQ0@#,W)^8A>7B)ZKW
5]=fW1H#0ZeRO@\BC67:MJ4BAY)]8#)P<@Y5Ab_,\fOO[ST2HH[)Q9_aQH\64@Kf
Ad:-;MX,HUPd3N,J76VV8.[gDe6_a0QHC(9QN=T7@)3SZT?O2_PK=ccafe5dU<W7
)QSJ&NWZE)d3TX2<G>2B6XM(A.S@@KTDZ9e1g#<#HN9B68]<?gW<1>8N(T5<9\IO
6-fG+adO,ePV@>b1ACWGY6/X9BD:2B]C@bN5-/BT)6JMfB)<GB<-<B3)/5LJ@d4W
[QU6aY,],M(L8-98586;HU6VcEOL<F1gFCN+)XJ#8#;97]-W.d]:8;NV0MBZ&PZ0
GR8O.NJYXZ^8RMLM.6?_(^cXYbd>HUUB4N^4])7KNZ)EKd_gf8dE5_.-K=4BeU3W
#MYPGO&#P)^/+S-P_-+6LQ@[CgQ\GA235Z9P4&K5109B]QS:AJ>\YSe8=Xf6G/R(
T<[7K<R?BM=M/6XU;F9L+8M;/A&d:8QC?f.98-^0/-]g-<.?-^Q80>TIA]0[_XYF
b9-,:(>c.L5RV)4-Ub#WYPWCPZ1:LR71G^WHJ4.BHbfVUAB6bDaY?-bOIH-HAfHU
^RNPU_BeKD^=?_?U0Ga#8N@abb7SbDU_@FVd;GM@.F=<Lg3BDRJ6[HQRL;I#NB3C
\:1<TggH#&0#[OAT+?/0.-J/^0,fL_9R=L&FY)@fFg8HL<<NPYP0G5R5VH]_cEUO
088NJ_)Ig?Tb6F+.&J<?9ZbBK?V(UK>NRG\CJ)fC&#g=MV.>_DXX<8,2(]2gI\_[
.+VX&dULCU35^<#NfVZGG14X>L4EV?B/+d1_TJ5]UV>10gW,&FN.I)2L83>(=[5/
;)4Scc0Ic]LNZ>)0139A1d-OF+dDK5WY@VUZ;^&-)Y\&3+BBB4]],BV82X-#-KSR
JK(c>Oa7b_^;-SXFWO/QW>5g/3dM9>E4XXFVQf-HbVJ;P;f)e)KeH@=0\;9aFM79
5>#)=II0Ee;>S^)7/a9Q08Dc,8JW<I3U=/3#b.aY_.ED/)]fE62O>W_@-IZFDE[H
1SKK0.,</KG1VSE04DGXIT(AI6;3R#[DMZQ7,a+168QC:3L^Y]bB(\5[&[@gO7e,
VZYGJ6=VS6QBCS)Ged0fCL4NHTgd8&8QQd4M<50;TY\:YWP0+JLI9H^IKg=[ATQ8
Zd)WJ2L)46KE59E,OabSP(5OPd_Q6GJ-2W0O+TS.-UGXge8La5)/BTRP5H29O,[0
Eb?01cZSH1=b7>5c\,BF.5_\@7@)+T5P-S_Pe^I^HT1PCOY;5NGe6LT=+f,?W44M
.<T^TKF;G_6#G+/IWbc1La\/&F;,cDA\?A+#/F-.2?&#/b86F#e/6I6+4V&7+\,L
)GTK.WG,]a^S:_VcA;)4MM=;9,>5_9>fWF/2d@fDXT>a3?_V<(M6]64JfcfGS9?=
.N8C)\.N71E>0I+,Lf&]MgQ](ZNTYOg-6=?DWNHW5.5:WBPc;fOS\QAI)DZd>_Qe
_S3];Fa==N1WQBV29?:6?&Y)&Te(85M>8f[>dSCOV2IK5S9M&4SK6MFA)Cd/3].D
(#,<EVLMKMC=AgO4/\95LJ(H)?Qa68UXM4J\38A;QIMC9HIL41E]](=:N\KGM271
\?R5T.W=Dc;U4PX<HN3NS<C]>M6d7]C<DA.(RcCH,cBW];RIL_&Z9(b^9E1HLU6Z
1<\cK&a7;[03Ba3_0A@3Ee/WPK_=/KORL]4-&G(I;TVg:/5[O-B#^@3bJ^L\A6DM
TM?G;CP>>6G3JNC\I3V50[6\QYCHIY-CO<fH<@H\.W8HbZWa[X\O?O5Z3RF\gCU\
FOG#4dAW7d;^OM@\I3GVYSWSK)OT]:eHC?5,0gW(@C6Y.2:ScYg8VL0:]DEeARB?
VE(QLaIa/HGEXe3X,9V.8WUG]#Rg,Hd&5G72143P56NJ@02[Ee:I;OCWd\HWQQFK
D:c?K_(L+H^\RKC@,C\/(J:-P6_<4T)).]6dOYY3Hf/_H>L<Ec++fL(f03-;M(VE
Y#NP9K><cO1TMbA+gSAGg,WLJYeO+<],cCg_9X4^ZWfO9].c#(g)=AfRAN7eQ7b@
0RX[fWL=(KcI]Q1bcbXHY^(_:d_:f//I_1=8DK\ZB\#1c(AO6-CEZJR)F5=VFgaX
A7UM9\)bB-Te-(-4(&d1@,7Nd00)1M/f=4B:6R85XALI\HPG1Tg9)ZZ\e8#KfV<Z
+[VX)X&(SA4&EF]\1BV(T93(RZ@,?@YBM3-D5:<I-X#L+eU_/U,W?AE^8?_cT\3_
Lb12E\70GIaa@.D43>RATa7Z8LG]I]JfOHeF8\3Y9ZV9QOL:g,5N\1BIW,Xf&9Qg
UgB#[K(>?Q/g80#_#C41O4Y6U<3]\6-[^9Sf8eD0,YUHe9DJ49TPRXQS.@?a7819
_B[@-=&427F6:;^1?TgQI2-R:[Hdd+U+?>Q#MIg3J0BT?W0VX]-dF>N=>b6DJJ\<
#0J3=AYc4bYWLNX-R(VIdcd.TOO#0U/8B?+M)U_P0fX[D/>#T;3RYTEDR_&C9)M:
_P0FWSVK4?O=5=e2GR+cg/H)E4&?9H\7Me(]0egWH>03A:3V^4OV5GWe^8L^WI8]
DeLU@W3BF-F1;4ZH]U93Bf3LIbV-Q\E;[[R07/b^6MIPLXcIQ7IT77I-CEae26aa
\10WOZV,TC:[?P,F+:/aDTbT3NQ>_e@Q(9aAfaQ^81N@6IHH29Y@cV9L3/Qf7e6T
Zd)<@Z_Q^YWW:9RI98YI8cWOFeQbK>c38\[^SP:^8R5EfDaa;2O3O=1T&6VB(\dA
E)V]Kc_cM+<5H/D^E[H.A-\[)C8X??:D.=ZORb-4A18DDd(:;Y:(cT,)\;VX:73U
C0?E2&=X5@P0\&2]&9YC9WM\M,EE43,?#2ELeA3:(4f(8DdUM7RDDY#,;5Uc16eG
a<#^SREZZ=-L&3a#R2<Y/CeOMCC\M-6(#2BK7D=64QBCC1K2[c-,PZT1+fL;1-??
90YfTa[bRYd3fYC#cX7(93aF[_7RGcW;4DKV/d;7M@]_(J,:DFGcW+Q/UJ:L9]&Q
/4Ha)8>T1g2cVf9b2b5cZd37Y?P@2T2O^C1,]+ZJW7\2^:Yb?HCb,,+QAgCVf;.(
XT([bT#P[C8\N6[5>#K_P:gLQ3cg#f\XEdD[989dBEQ9;71ce1#M_f3D@/]/XHJ1
g\4/1?Z1Ld_58Q:eA[U&dOAc]<LT\R:a&acI]):Y1AbH>BM=:QaQb2S8HOeR@06e
DH]Wb06A#0X]U17\ZD:W]:21RBFf2bEO/T]AVV0)6<b,g,Q:\<N;&8Y92UcIEe1I
9,7Sa?WD@:S3Ce25F(MCGLfAM3A+6D/O+M2\b[495&]/PaWG3/[@LAF^07SCS[8B
M@g/E=;8b)P:F-H>fZB&ZgQ70f0GEJLg2(WS0(HX9ILT&/R7T[=WJf+3U6F/RS-[
@@:UYd7RE>/SY6MKGfS(P:<7^I@dg.H8ZNUZ>AHWAc=L0M#GUe]<@A1D-.,bHSE&
TYL87c^Ge^5S++3O4I&?]=cM_(L8/1FB.fZcXD+<\WN=@SYW76OH+Q)LFG?<4EZb
9dJ4>V@K#78SFZZ\J5J;3,?6E>9Fg\AgUA3.fYReNdQN,@TMILW33MVCCSI_XO[>
Tb^/b&-Z>\dT@c@^J8=B_X6A]2d&3a[\SI&B465c77#7YGAWMGXN34X8R\bP854/
1)GIV8a:M6gL+c1.KB>d]1M.NG=a/X^AD>/faIeF_[/\H,UI;]GAXT00:<-<UCc@
#dfQ3<;122-5;NaB.)IMS686@gPC:Ne,E:?5&[MO7KHVHc<<?2I7Rdd==#ZCG5(?
)I?3[FLMDN]_42GT;]W;K(^U@UJE_<W/>V&-QYSZ#L-ZYLXZ&I[+.\YLb)MQa;06
_((Y)fYA\Re;KVbMa5K4Y<-SW.::\W]2_a4>8-/N;].bZVX::>2<&W[(=+_(c(^#
3TCS.E2dL<7/@SG/:B<.D:H>XXYFI1:5]JfLW1ZaUDDE+0e,;>ARd959J&XL/I.Y
1Q-)L<MOAD+UB[@g?DMACK95DaJX>FJ&/a9Ae\Pf4d/@<VQDZa,gg,F;H?H+_.=b
3L]VVYb47/e#V<@;)]OD0e4#7[\c993D>@#d0I]c6G;_7R4PO-I)(@CcT-Le<Vbg
.V+DP([MaS&LF2^X:I2B63NdU)STc0eC\gUf=3SA@QPEc=13a1de=Tb7O0STKe3>
2NXL4@\^Q6]f(I3&UJb\2@\E7#HS3PdX#dgCaS2\.-.e2Y^>V_JKffQE>,PD^7C_
RXH\+R:@8W/0CKXFGZNGeDfDB(GO[6A_FI:8/M^BT>?cDYF>+;Wc:OeGO/?\?Y,d
W8gEIXg:ADBC<;FI/_4Z549L8V7MdQ3TbS4IOV5e@\]-R(Z=I&W6A[D3<:VJ6\:a
^:=,e]d,BG7F@T1L-7b=^3D>f-afY[C(P9JY4[fGJT5YTb4HT2?7[f.NTQMFAFP7
L#bJQ\<OG<HM&TGCX(a9IeITG/\CB5\N/L4_[SSOWN_E8=(ZTR-K>d(E]]>6&/3F
<N+#UdK(120ME<f^Oc&8PSTT9cK+gT/1\)AJ/d3K-cfD_Ga[D#XCRP4SL]eNSZBU
25+3Q<92SWg:UXP=]Q]<0.-<A0_/N#6\>RH84^QT=;a6Ha\B>.;ZFEF.\K=X3&.O
UTY[U+VRCKD41c)e[0AD7L2:cUNX^.P\M))E6dI(GYYC_.C4a=K]_[_)4T;@KaSc
]2=W^?CC(0Fg/SVATP3g3g6IMc4OI2TN>@/JJc.:PL2YMK2F>1d^UV9E?/MG#HAF
1[(Rc-/Q?d,KI61U)Q3a[fM&3N&32#E@;X)WG3C)a5dP1Y)13[=HZCb(7gWcX@H@
fC2;6\e+8QL?TE>Jc8<f>GM0eMSZWW<YQ#O6EUST,(&_5gS3&H)76_1\IQ\)>]Df
VCbA>>15OBM\Ae<.@O8\YOQ>ZPR@#cY@XC4D+FYI@N.2?X9@^#<0)+W1(7M]<Vf+
>5d<2M.8fG5D[.+35+[#HEA(T=>=NT^_(?50&#QSFNGg=W@2(^_CdM<L</H,,W3A
EBY,OF0OfVUBT;I+Ge81Lg28P^c<&.f5Z;]99c_fZC3+DcC\TC2IFg9H/WecW(?C
@7Gd.1J@W?W0]e;PXBVLY,NRbP24UKfaLZ93P/??91H>g#H[Z+\1dGI,S5ZO;+S_
(a>L@a8]<T^&ZO<fQD=fX?>-M&C?-#9JA##b(c+cV>K#>M:]+WW^&ZJ7Z9V9@L9[
b1g)F?GJI=]Q11AG/)JL3:5R5?&4ZXXFV(][Y^.6;#aJ#B840e?B.PY0c87G=RK@
4g_.,]/1AVMDU?K])H,0:W?S&aA5=74M=:10G\g\fNfHJa/L7\9PSIAQcUABI(DZ
:M^N[eLWIORaO@WJ#10OcY@ZX@9((;&dXKcNf&0EGLIKdVK;AO4,^NH0DK28RQF\
M0f8D0AMd;?F>CO7U4H<:_5PLQ6KN4g^feD+Cd_5>>EaD:EG^RGK)4;[0J>E3G,:
+,=Y:4(Wb?:SVc[MFe(F;F,WaIa2B+>1Y3/T=[eVb;E9-(D:fM5W=&/_V2b79GM:
5585a-H3/E[1Z<32KcLd)Ef=&SgF=3aeEN+5\9CB<[Ae[IH/R.K997367-AVZ6_,
-J[#)KUP^(N]e4Wg#]P]&F)4SB)IIV\cE-D7AR#=-b,-/f;C[4:IBZQU@ce(U#gK
Z19=.B]9XP9&cGVe(+)2aP#VO?Y)1c7K8<3_Y?1&BKFBQL_#:5E?OScdB\ETZ;_K
c\K>Z8Y8#[ESWN?52eAcFN-+Y;OX=5BRb974Ng&6X2CVc)=C;T,K1E(B-QfJ17>H
\9_g5>Ud&R[2+09<@X1<Z.ND>X<;TC_OKeDBRf3T(75T/;<_G@(Dcf=WAIMJfA@^
&?&4OHOF@.YJDFUd5FOQ#2?RPf<6PY=W2&L6XT.]8O?&?G#fNd1cM9T^,=8cU;65
VIS9S3L.URE^Bg02H-X06OYL\C9TZ=FD1??+H;JRDZYEF.T,NAM_Q5P9OgFQ[FX:
M7\d?Jg:gYO,Q09(+;J8JP@]Jdc=L/1.2M2Q1.C6N@c)Be(2R5<;7Z1L56E-7GV/
@1+:],Q9WT+SNd)&OEFPA]]dBRU,3XNPLS&Y]5?1Y+4T=^<D32X+50L5>VgU3=KT
AOUS[@;JA+AJJ6IG[I@cO4/N>Z.X.cK\C<,Se6DS8T4=CA9O7;5Z9^/B:1(H=fQ:
.CdEM@^6K)HQFGW@Agb:Pf[,QNOBWQY;Z_R/fU@+7SMNKI[a?e+;NC\G#TCIL=a5
bf3cJLeN<AK7AYQW)M\;)(g[>U18\<L2\=,fA>.BKc50E6Yg?23Q1^:SL(K3Z_-V
P/7EO2d)##R&\W[?HB0ZYaCAYV81aI-2?>NfLc#^MKJ]38T46>KW(eO.+ON[MJ^-
TBCb8#4aP=4b-8-5-bE9K[Yf41FM6L\^PZVR<.P[464)8&bN?4[N]:=HLN(IeM0N
^[,[7A>Ka]VKL\->:f\]>X;7H,V@,LHUE>4a>6ZIGH:D:I>STT3I:S#M-+-N6\]-
WDO6,5-/e)#+C_+2+(c1K3RB)B4E(H-^>[=I.M6<L@H=IP>@X73]\b4/[I@,Q\cd
]/\A>E.UQAF)AV3G@MX5T4O5FRF[KMbSQ>JIL:>_8/38_6MOFQQZLHEDXg8TX:S/
77,]R:a667&XN3EJ&V^YNTON/[CcI+,E?K(D.7N-94aF;c>_d,:&QELaGgJdHHW^
F-cA#=)-/KF8cXg11]JMEUI6JXFdKdY(BV&,CK877E(0Y<CaKSJP83RF>I2JA\DQ
/Ga#Y&?/_RB-VLAc[:]JXY>:G+X&Xg_f-1W)A>Ic910e5(68]+Z/==ZG2XGTE@[,
9Beb]U]g]PFVdEU@.^Z=-H@b]-ab?3^^Qf7N@ZI?eJ#/6D+BR#>]I(^H]E>V1Fe-
U3Y7,.N,+b40Y[WAVQ(>9JSI#U1aRgB4^<U(Ib7FU09LKTP^+QWR1_R9FS9NTBN4
;]5;#3^5>H,I2C7J[f^,F,E87I38g7(ace,)BMTaFGEHS5KZ\=.__5TZd?^=PU2C
?e;1-IbXdDWPS>C-0F4;Z34F-22CbNJJ_W)JNK44=0MX;:6&FU2+6?R5P:H,X)e3
:DTUc;7]2PRf6L^BW_fefd5b8XCP(KK>Q8F6)1?3#B)UGZP\G>\R>O@VMAU]8&Pf
d>5#Y<B\R2-+e+1H[83B@K4^,0bZ3K^b&+4#AXeZ?>d\gW1U-;7L7GZMUF/2JW+O
M\>FWC,e[>U7IMFbSD)4UbJ@TECER,5D8Sdb<]cGA4=Q\@/PgB9)dTd98Ob0?]8K
F?3X/\&D]Xe=f9E^MY65YDN3D^V<a1SP@K&DL&95bBH)1@2<F+E5YIY;,\&f.+U?
c:#M@3T:\LLN[^eFD3HO4aIC.;_HPF?0ZN\)a:a^Fa4O41E.<WN:_E.,PT83)1cR
S;b>IOKS&P;KK=-S:;4N;]g]K-Z00OGbbJP?TEGQZcG=/DD0fLc//N3G]fW5NDRD
g[A51@;Zc_=@YgS5E/:,4T\egOH4XWPdgQFQBJDTYSN.L0#-.-OdPHfQfA]3T<5@
.76:^0Y=&4&U4:cXbMKd,2Af8R<KVLP0QFbg-W8<=(PWR]B/4gaIJf:JC2G;ZI\-
UJ(JV6:O3I0XEcGZ:O]I/5)L49fN>06T3^GbdD&4Y?J\TgeD>[\&HVQ_b^_Jc-V]
^?PIVE.5N+&]Pe?a8Va)I>^S:KTC1FGR1XU_=T/>#:7Ygf-6:=,?/I^d0FU2T#@3
79gJ+R@1/4D<A;IL+Q^bQ_\RQE[Q/1C7cW4GgH?ESg<H=([VC\gK?=SE,C[[c8CJ
?bbI76-7aX0PD\MLRc5ND9&(27e#MT/,.M55DGCZb@NA,6,K9MCR2--e_.8YG.\e
XPS@VcUIWe,(MXK5#<f/@&SRQ#^g#VDD5[K&R6+8TgO2MNS&?K#Ac,\?8f[,9bO>
Cb/(VHYFD3)0OID)A2W+KLR2Pa@U&W,M=#34bFC-DJ?:V;@82)Q_IRW/-\1@AWCc
TgfdaD1)E.KLFNEAQd-T>V8f_YT78VRf6BKCHfFU6d;-T)JQ([R(=Y8bHA-#BPK1
L&O_XF^&D;g,&X;>_C;\Be,<Z9X<_]][\I2V@P5/fAbb,-DTF#^bRXH69g_I()XA
/;^#bA__NT3NY:TIUa#S0S3TJY<2AdU785aUS13SB^40[&?ac?>>+L)JJ+(?:;[d
\.6MD:LN;gQ\O6J8XIE099SBaSMZ7(EfS(\Gf^eQ1fQK;]K1S>9J-HOE-c_e-)f\
B[S?JXQ3LR\WOGK.FF0c(B?MaW;F3;ZZPE5cG9T,D):T([-+>91-YV]:#Nb&.-#g
32g68M#6FKVW2B\);0)+cb,LfJ]BD2S-OB>EQcRX21eHF-#AN0OLUMS>@X_:e+O#
8<T&7fEa>c\=690R12(B:4SQb/>P=3/7/F:(=5D)YRWA(5-6G&BU[<NbQ-+JA9E8
>XX0-3Z@>6YCH#G6+<3ZSd/)@gSL8W_877)^S=4>MWdK&Jd[GXcW(-7G/?PJ?E5#
-5NPUgEJgg\2IM14(ID=+D:#PO5,_cPOMQ1Y>bG]b2;G45\O_\9_>10-CKT.-GRI
J/NF3+[_M)e-T.&,IbCT6DR[9QZ&YaOSPSLPHg.E+8f#>3fg^<>K8\N@dWQS\Z0Q
:TRTEZZgA;B0_eJd@CP,:dRC:Y.WK[+C]AZ)Q<\5f3,cF,I<c+44#:=02.;.Y+8P
#C/V,Yg=?)FO47GFa&)E5MW3MS7QL^<PKU<RAU]aC(8a[eB+<-gFYbcF7PS8+W(f
(OT87SDR)G(cN7Od[I=<Y9S3I#bR\X.@)e8Ze&Gf&3aQ6^H4+@QVAC91X]2;HcF>
FTTDE?VZH7ZPFBd1#YBT)0#@c].FKbC^@cM=B5bJIQ&8f1+7=)K+eO5#G=ba#;R7
A-XL?ZA_.b5#A09&Q1(E.\QHAe8,)VfQUY<YPHN1a&ST&Te-X>>XDKN/FPNJHf03
c&0S[G#X(<E\)>0ZIP^bfc4,1RO9@WGX7,BOZf4?RXSHc3G\W0)MMb14(afH1[8F
D1YT3:eC23G08=&<Z2L:Ef76_AO#>=814NP4)K\V.3;A[c;2B&c:B.329\0&#T-,
F0;@WK&<B]-Df7-9(Gc^(;_e7Af;,0CdgF9L/K>V4;C1ID,=0;?MYUB_7H#9J_cP
OQ3;->fOR/9X)]OS/EA5D^SGLBPOLMUT7?g1.CKME#Y;I5^H[56<c9Q-IFgG&T3P
B9ZE&Ge;FL,c2XV>^-a-f-cZQYWe9BL\c[\6OY6U^C15:YaB>[Y&=XQ4LT+HSEJM
R6N)<^.0?Cg0Zf98,^YZ.X]V:f:.CXM4#ZB-I6KO1@-BA)^HaK@\,d,Pg#8H2.J_
J5=0_MCM;c9#>VgDcP31-9AE5U-@I@TLfB+B])VQKeEHBgYGd5MQSX8-,II-?2Le
b>PZd/g5a^(MN7UM];a7SaI:TG[fQI<[RZcNb)/4S-NLXFf.L:8WF9.U4]QYKLUf
FBM95dg(/BJVI)3^#N3N<B53PHe5WDLRGKXKJ3?.?g8dbK?@--.?/H6.ZN,@c7J7
MBNPI&c[XH4N2S;LRg-B#)1b=IUO^_1LF/7Id2>#KA41Jf/HI-4@@]+.601_]1ec
&eKX<dO29H&^MB0D#)4\d5&a8S33ME[B:C\X7+bX_7Q28WBCIaaU@^2W0SgM-F,[
[fEK=0:N);.8#AN8N5d_R+K,EU]]ELd&N2G^-=SZ4O^1bc]fC4UYOBB39,:@1a4;
;/W<a^=?Sd^eaUP@BV)XD3W2=AJdJ+VCAC.[PJUD(FJ>1#:#1;Ja#V(/BA7^Q:#Y
X&U&[0]GA^\a^(@<[&ODLW@8JFOR@J_b:6>ZIHbUbZGUM+8<AI\DgX^I:=M?e+2^
Y#]I0AQWOS6WL?Z>3LC+cbSb9Na?(^47A\[7^G@;VC6-dc()>]5F9YAe-e8O^D32
<1<#+M#D31J4S7:_RbdT[/:\gC-+bF8V].Y=2,N8W?E9AKdL.0b3eH>@dCC2T:@K
:D<MM3H7eF[^?6Y51J5?@4OPLHHPM]->?eRXb[)=VL3bS/C\5Qd60KNR>N^UK+K8
]OW1H@@8Z9=721/O:#3=S<MV8Z?:e@]<EY(b3E2.?5;R.RV^6G.10:d<C=QRGL^O
a@MY7Bg0CYO0S#TQ(/P91N.(C5>?ab-&),#1JNX)gDWO31PJ8E0Q\5<=D-Kg71R>
OFf@P8_Z&&,5?56e1aG7FSHMfB7DaG-#[WQ(F)H;IcEA\@C^;N\.Ige.G8)Acab#
dXSC#&#KLe<Eb(LJ@#;CV+aBCSZRf&FS95.7,cO9Q@8c2bDNA9g.HfNf5ENa@VRe
gJ^#.\ZB5IFQJ>IU3MMYMc3,aGVMO7.QOde<QV1P>-K49U4U:9R.bB\BH,_3M?U_
[FU5gBcX:e1D)g89gbE@_4RV1WV>XV(0W7R&.TJS6G+3d6X>&e0MS,5g0-gJ4EV7
6S(HAc[H>EaKIQ2gWa>]<HT6IXWXRGIEL>;KN+3SCd:@>b_[I-\>Hd,N9,7)<4D]
dHcA3b[A0T7HfD:^S2]d&a&+b0>U#B_IcP&[BPT8eO,@Re]H[b(,,=4dWeE1,TA,
VMe>gD(2NV?\OC26+]DXDOd#edSLfU@_cZX-U(d5>KY^#G72b3H[P?4Sa4f.(8/I
=]KGP<7-.fZDJOda>e2cb.6QgTe@c8NT_KI.1BeBJFec2bF2>X2A&d4Z[E(C?\L<
J@NC0,+44),#=WEXbAO;EAOCc_9Q^]Kd[Q@C]M^PH:CU)-K)-_cIU9XI6dE:0RE]
+6\SH0),WfY99b-R<gSA(-&F3Ec#(H-baIBdQW:6US_&?f44cWLJ7)+=K7/NdPdC
2(74>B]5T]\QdW;6L6LWQN8J(>V-8Z<=eZ73B-&2#+.bCZZS3Y+V3Td9@\Z./E@Y
^]A)U-C5dA+G/c:f+>=Fd/QM\QV>89RBTNOZC(&5]M3D1Dd-.,P^3c_(/e#QPJRa
,K(ISJb,9Ad99,g&_,G-_;a]#/;8C/1IJ.U;bSSTTM^>Xe)&QfM=F<3.]YLLD=_=
-a.NLDSQc<eFK_7\9@UT\ES(<&XV.NG;I6:8a>-F83ZQeWR;Cc6b#,fKK7P?AFf[
15-F1[4^OZ?_D]5ETD/:5ced9C3-WL.9K+S;R(gQRVAZ7@1>JGY/g>./5bVFC.?A
)Cf.1N-W[XX1F-&\K.UKBY[L^#]<faM=#UdGINa]gG4JGNXPd:_c@Fa/gCF&Q3ab
>R/OE[W1e&B91_^7WC;=;.]#2]@WIU^)5<3=fKg2<9bV?Z;_0F<FW5fRNA[MD;-f
<X3)C(X_LAXgdI5JQdEZ(3Z=&a6e3@Q3FIMWGQPPY5E?YKf0SeKL/Y1;3J8Y2\;G
A33EH_^3H_VBYb;7IcbfLWH5_--0,=a2/F1e=8T22^adKb(bCY.=W-)O&fIfXQg1
LA^>(UO#(@3c>64J,>a<ULS5F8@JQV[FCfUVS=e#a(@P&M1@14TS@73/??KS)5+W
&T+D\ATG6JNFb4A5X/U+@d(DRD<LLaY67XT0fEK<ZM#)/0X;-S355NJbFI3WV<AZ
Jad-#6>EHBg-5XBU@PPLGI^NKdZVHZ9-5D<^BbMQ3/_;K+ED+f<SJG\21N?bUCA=
bX=_[1+Z,2eHOb8IQb.2]DBMB@>a?@c0c+BOB8^IQ2e.82)B9VcJWYKDOWCFK#+0
:@&BFP?XWA9>1?(O7+>7)@XA/FBM6Uaa;AZ,/VcE[SLGH<K@Z;CL#_CC7?EHU(>d
MaJGAgI1a,+GbT0U]QTb=,.VY5^NacEBg8ZC)J)8B7J^#dAc(51@A?39\KMb(WQK
VL+6<GYZR^+cG0/:,aH2U<eV/CO32K.Q+26=\;A;Q-[ZdQXPegG<^_gcLWEg1;WZ
2f5T8_U@>V:8\LU&(]320B33N8DKef#SP,ScDa/FU2JgT2b+6PZW0</PT[)N+RO_
&-/Z#RdTVQ#FD^T&&3YRX#g:)aSA<^=A##U,;HY86LbS.Y5ENQ3a:a[N]+B;GF=A
KT4GK5X:Z4HQ6dT>\KY&S]/EfS52LN1R5,fHTC8@LgX:d6@4J;<f)e(_T?61\?.=
Nea^STZ29/UGIdb4PKLKc<4&V=0H-1QgOW>06B9JTG(SCf-TJ&R;^7Y<D\H]L?I5
gf.aI#LQ^=MBCVgJC/AH;M]42HM?bDPa3<?T&Re0RB,(ZdTJ=LU=Ub5V^-:LdcFA
44DU?+E_E>IL#W2,/bNTa]C3S\S]EUZU2\caB(1>@=95S8UUDQJ4DFM?QMHX0(_Y
T(2?S52<;WZda^OY?A?DYB6\8)dc&MI7?]<#G\47^KP,HAO#<WeNQF.P)V&XdgDF
5T8SFVI]VYfeI7YAN/V=IQ;7a#,[3]62@XEH?6c_:2_4M<e<041ZBfT7eSMNd23O
9#c,L++1GL&HUS.6NZGIEd8U49\H=/d]QBEcfa-C;MUNLB0Q1R\DS3R9KLLG\,7_
XUgO;1;f5.GK6;QA)4aEf&AB5<F+@WJY^LLB4OPTH&)RW-Q^)-6AO^d?W.G4_M4_
/SFM@,Ga<=[_#/8HP@,O@N471&GE,\UbA4T(f5D\AM4?0Fc[540]>O)],\@dBR9&
N-Pb9(^dIID/@gD[&A/FL(>\KY#4K961,:45.7GD19L=:MDLW--1Qa0]3HgNcL[=
(G=Ja\9HYDB1L_bQ(U^3b_#dbN3bZGK2/EN40=)Z/d7>dR2D)VXM,>[T>YbPN?L[
>8#C)SZ\S;F&:VT)bU,DLcZ?ZJC=S#YMaFP8CgG([H55>+V:b121dY3b(>Q.R7)/
87MIC0R#375K];eGdR0L&@=UKKdGI><F/^:?BbZQK>X:W5S91O[UeLgbc(AO4]J-
=HHL;[ER\]]&XRXL?NA9,^eCIe298&bNY28B(-a3;J2#U0+3IPM1FJ:8U5(4OWE5
]=7@#?=\]X805-DAWPA([\>2bRA]@<f+R=_8daTaK._>)7RUJN)]IR794F3>L/(B
HXPMS>SN86?V/()<,,UH4I^D8-Z4dE,8U9T,\?YcL7)KG4VJT^Ggc\A+<&VVNCQG
1<J+90QYK[T30.^2_]L=/6TW3g3g74-dN68=-PO<dP/VHdWgB+cCgf(@3K4Q?-eA
<:43E,FfA:f8VcB<EGSa788bARYH#CR;W@ge>dZ4X#2,EbBD)ZIM[Q(VGc.cH#[_
5:OGY95C(E0VEd<3(#a4g7+.NLUdd2AC&6)#QU&#e-,O,W4=EMF-S.QQ4-1D.T@(
OKgOJ\R>P832ZS=;M]-C_QPS:df0KX.O3](]B(:S8bK-F&/^1M1Od]9C+g(#Y\BF
VC(<\_c.E062-/1[XKY9-8A?-8\2U)0c[b^bbW;gAEM+][HVR(TK[=@G=UQ#3U+R
SEU.4X&/)@IDfVf/S;c6IGb._a5)5C]E_7Dc1UfKP?HF(&)42VUXT239dI#)(>VJ
_J,D/1#648#<U8IT/,IN=[4f8MAXI)d\dKa.+LKOZ8AbAV;5QFe.QD,G-4XEK9d]
IFI4PL-3TbD8XRUZQYI5,debUP7e[a8@-8]S1U[OcO4@NcAWR^b3^aVAD>A-7FPa
eO8.8+^ZN6,2(#:bTW4^f#]dXI)A1b&OEEIN7JfL(6G)/#<GR;d86C8KCa\.UPRN
7e,6WcK9&]<eRe/^:7XB_O?U@W8f[RC;F<H[FQ8P^#P@+6W)S)5@9XB^96[_/_W1
CbO(aabW>CY310aCSd.44^g__YL1\Ug?JZJBRSPF(6:_d\8d,JQXg^H+VQRg@TX&
f.^/KU56#/JB>C#//JATF7X>1-CG&--c3=HX7>PPVL1Vg0,KL64S<\XKJ8UGK:_(
b^O;3g/OI7G-Z#NF4QC]cf7>)GSW\A@d\UNKf?b)9;@N_4OMT.NQea=HQ:KYT^6+
_K<EJ57,<Y(M(=CG,cafc(?VH8ae]=fK?0J82QQH)WI+cV=A+YEG,_d+Z,6SW2be
3D0@+Z2^dF=4Y@^Q6M8S/O1:YY:1L5-S@c>,6X1eO1YNB7+@=,(O5e[:)ZSF;0-\
.NJP__1>5U1-TDR9L5\e5Lb4A4C#1.L,Y69,;+gTc/f2&9g/9+D:QRAZ,Y])H#)7
VCE0T\>R+D[@RG1RdID0L9HJOgY:IBe/1NX9O]5A.gVY6I.Qc9RdDZ.L=YKXcAZ8
=@68<J07?XZ6A#<J>;4Tf3g(B9S7]Z>f4Pa4f;[V&>AA_b>LdM:8+bD@OO5,UR,Q
J)&3+^R>L5GRV#+T4=5&W]H_2Q.D_=,Mb9EY-JG-b./<e_aL4(Z@b@f+CQ[B:Aa-
EO:+&7PMPALI5V_Y?SV-H/e,LURd@UZEA4Nc_:4BgaFK/5?,DN(8Lb/L=MD80.f=
_(#5X<&&e-c,^YUVUTLS_RXYSNB@W\&Zd9AaN&33U4f^(eL?DJOU.A(YZPeWd][I
bYZ7BGZ>eY_9/_fEZQg5^4U=BRT&0>Y1E#(Ug0a\Q#Vg9QOO2eM[5_J;XQ9a[_&R
XY9TJA;Ba<+]8_36E7f#a0I\K/3f-+7DCCY]KK.MD?Eb5W&.#BOI,G:?8JdGC7Ie
aaB&e@gB9QJ&&\cPV6&R@^cUG(O(KCI(,NSO];K4P/A[_7c\bdFO7IO:X:17GPec
[RR.F4?cO7X0NL6\&:BIZ_OJ:W]3fT?MO.<-^83JMJH;)D9\g@b[=(fG40^5)10_
TT,3E^>Qdb(<.;>_H[3SSC0EQ/dXDC_;1<F;6YVR#gdL8>/E:Y_Q-S/:=7VNBge9
eMRTQ.@7=&G(3B_d0?;M671-8eK=I?C371.b&cTDBC4-fDc5J/TWEeD6P>@<U4U-
O+4#WWD@&?X0f:IC^0_SBF[f0MMEJE4XCI4X9)OVS,TL4=(a<TFZC@X3<)Ge#T&N
K\U>U,=7ZEY)N6YTZ7>f/-B/(1QOV:=/DcWVLAO:WZ2]?eAV@,7YdJWVR^dJAB<^
N4c1L(M_(D+)P?eJ?NOO.V>_7^c7FM^LC>0&5c/M?X(X--J]WG]L.^G=5/3WdYUV
031^b_]UT;6IdO69>7\)E.Q>NG1c)L.4MZ8@=Ha,[L:YS<1)B,JY\LI(P+&fbPeR
D\3G=db22\f08G,G?b3/L?D#^R8JgEK?L^gEWYfY#H)S&J[>bV)YFT95Qc(R_FYH
^H^eZP#O.3N=YT8OWK1R@>3#15gb6dT5+XY1U.Pb->:WLU.@O0DdgVPXTae:ZTLE
6B@3]PW=ggW9Uf.G)SM:V[TT:C+;Y/B]TV0b4XQcLKV.X-Cd1=HCM0&,d=T;,V46
HU63)7Ze3JV:^HWK,6TQVFD@C(I+fI.7:M5W:^Y.]R8S(S2RIJ1</0@XQU6MZb>=
MG^)[2a9T9WFQS^\DKLf^,]8LZ^[PXN-J1.L=/B>WQ#<_T&4>=2:9(]#SY8cQ@8X
>FcDTA(O(0ND(IZ<CY9]34,[/gU9=,Ub,;;HV.Q8[K8T7UI^]#AY9@PdKbMO<T,9
aLM[5-MR/^fJfNN(-fKNEORe?[ZOFR4Ce+#2I/7;1](T):(ba-R-IaG\JCZZ.aKM
@gJXa;bL\G#6WKVcZFGc5S4b-PYRYG/1V.,@;=BeFBE3VWD?+P&(4,:45EROV<?.
229(KE..V\.7L+6HU(G=^c6+92-@-b]e3K&HW&U(b@5\Y_-=4611@-T\M/1(J0.W
H-D-9<aV;8S2ML9][,U68+9=f9B4a0HP5\N2=9,6g#L)(S9d0IDWc;F^P20>2J,4
b,1g=;NLGS[(,GJN0&N0ZC0QNDT?&@7O<<OF,VgC>#_YDZ6V8c<Ke_)#>QA&^8RF
.RTfdbRL,H?O[A(RB3MRJF2QGA2O4+B,.,-OTDDM)I>@=dL__PI8GPT_.;,O;B4C
eeCQ?(<SU[&dg8NMZd9.7CH(bX4UM_^T8+gf<3fe[RIfRNDBb8Q=6GODW4f1)gGE
OM?2c.<7V:f5PF9E3WBXb&J6>(]d:f5/bO#V#=W5J;b.PHOZ6JF_VJWO0W68cQa,
<CAZBUcFBFO1;Q5V(.3R:M83_dG9_)QA^/7,W^@R/fVX&/gBKeN.J(4T=7Pc+J=[
>?=]ag9QA87^a@66W]JeQE+Yb6@6g4HHTDIQAb]20=,->dTH)^a)aF1F1a@EX0I&
O7e,R.b7BT,DQ<S6=,a7[Vc+W0IO(3b&RHQLKg<e.V7Q+bVd2O>4:S\FGKeX[B+E
/K:@JgX-HSFE]@d5QN>>4GSeU]O[5[>2UC5]HQEO:SY]L4?I=g,VZ/5g2=][G(_V
@-,cW)??KJGU&N&2W-5Qf#0;EU9TN+WZYS=W_bKD4_F3D]7eCg<.MH8&8)Q_+&+X
)a84V3/1OBPR8,^&03+4N[dVg#>QY3.OX9.dAa(\/@)ZE5FKQYSS6SfYQ6O:R^.C
>H0-S);ebZN8X+>1[b)X03bLKKW3PX795R@TC0DWF4+^6QUZ-f_d#ZNd6:D)=:g7
CfX+U+-O5L9S9N4LDKOW0(K\>R?^dANe:VV4@g6L17^A2Y]TS22ME7dHHL+,a=&#
8cO;Na82=WFTJ?X(M8).HcWG:CWG\LYR7NL;].4HGT#<dZPORLR&0\#cJ17@XY59
5[,Q^X9/b\Oc68KC,MT9Z4AJBgT4QR(:S43F^24MOW5LFEK.@g[S_YHS>Y.6(G8@
+1<ecV-K_L]>LC@-MW&&/Dg>/EFX?DTC(T(\@3>I4=V2:<?0gYCVdQ;574I]R-/G
97AaZ-cJM,2g+N)Q7daZgD)5b\V7V9dXL]bNMH;?CC?e_;dZA.e_KAR>M);PdFBe
_S08OOSKW+\F@BeZ(QJ]^^GJ3<ZA18>]AU=^a-d_>e>a^;fT7,XEJ@SLE<B-#EDW
Z.OPYV?/&&-03)_\4Q/N8.19U?TbO;^7^Y&0J/X=KY>c=TU1#&^BD=0/e0NQ@LH0
UHICM@2<R\42ADD?:Q#=Q-[UU(2#87A^NEd^]64H85=/SS;125OUGYbedab/P?RF
#>]0(VP)DfH?4;:ANS\C#b>KMJM708S.-8YG\_Q[T6b6AU#A5&/5]A)U763#G-+S
;F4A386_A_1_N\P^X-V>;1?[TX>f-FG4BLeZ^O6W#[HZ,QA4V[>f[02[gTIZ,-03
.Q(Y&[9O02>@HW#K67\\Y<+CA])]cE=G35>.G>R6\A#=b:F2F().]S2aX7IMRP\:
Z0MRR@7g>Tb@7A?R/RP@?9G<c8#d5bI5ZHb39_N.<3>/fcZ-CIGWQ-g^c125UeM<
S]eLJ+b1HZ(RdPC=Q,J;,-:cIU3.R2Ufb.8N[7Z5_e+4fNQ<_U\N0STT,WD@_eD\
#I@/=[(HgFT8V;,1d-2781/TI)\Ae3DQ3>6c<QAV36IWTD>_b[#4CH66N?dPF(]Q
G\>&G7P,;HY^=aX&+e/cS_4AJaTO+Sc&661I1_5#[BWPA:b6VWY>E/K)S@WZ]O;/
PZK1SY@09D+0Ne+J4=3V12]0Gg8LQPRSZ?\>\\<ZOO=LR=C9LANJa6AJS&/FNQ;]
\@]a1>FE?CSObeg_aS97?P8/SVEX(8af_PbEC^+VBQ&;HcNS1gSHA_:J?>GeIQ.W
8,&8b<X>N-^RZ4B^A1K4EM+=O9Cg7UeeVPWT^PG_4dKHTZY^IMTA=Ta8Ic34&>-U
&QAa+P/7g97-_/eaT[@-^X=cTE-3,Y]GBb-X2;9=-4=@c&(P(5#&.U&7NQ1YDGC6
&VNPVS,?YV4AXIZg[@LeE/F^<AGC\CDJYOFbII-N?/JA[>33)8c9-\M>^J2&Y_<S
#V93)R>=GL[:Fb+f]<GAA+A1G;P[^#,IIe\L+e&9d8?7Q(H7.#;.A5>-GTQ/XR>]
D64CY?(G<+)\7]IE:&EA^>1Y3RMY,H6H+T/aa>c4[UNe=C<baL3KW3be?KQ/]0]U
WeP+VD@V-L?1F=E)&=V\BAD8=IWDC\U;33-g8Fb5fF?FV4FV??X6cFaa9HYGX:[W
OC/.)?J+T4cQRJ8De9gTC_J\-SE5>D+@1(Hb4M+(JbEgNR]1/.W?QdY:RaTY>1R8
=?][0UaJJaON\]A>Oe;84c<]f/YF:]0&=O:B<+c[S^:bU,fXV,(9IR(=W#Q@=^XV
Ed8\9(2[Pd\-=G:CHAGd9&0T3KfS=VV5:/:=R:\.C]4__b=RP7>L)Ya<HU6AD\DN
b&P.aNR^VI/QbMaQ<8AD3,d41:[)T\a_XfHE9;4bR92A-f/dO0?JOCG0JAX0NSU3
4?-A&F;<TIgPD9D]c_4JYgG^08^\X9174X;.Ec=88g;>]A:X#YH??7.W:QMZ71Q@
C679]SAPKIGNcVe[d\2YH9Ea>M:1\ZNOSQ@eIZYH<4+H+.eUg[LKJ.\U)<=2EI54
F5I\1CKQ-2?YKG6UM4_/FZf(+6Y/]+F7gJI/]Na7^\544=U79c=\fAKG6]5\f[]d
(GIff,gLQ8Qg5#XUaTY@VA_+37La2C=>S9_3=X\<&QdUE]W=TADK/E]_W/74W?^0
+=Lc\MG]M97#W\3/[GE(RWYfEP.(&8H5LX?VWRTF(#K##,J#_E6@VgY0?<Q&ZagP
-4R&+DS+@]_/(_O)CT1Fa&;5G=],ba2/e,1QIg^FX2[6[B98g9d&\BSAf#G<._PX
dT1&Ed<#\]R54VU:7V@@\Q8W\FfYJ]8CLKK>2<@XK-(+g,I:cR__2_+E>&[0.+:E
\B?CcO\I^\K:4<;P5OVT;eE^<P,d-(QFSTLW4EGe?^8gBG,B4DC44eG31Fe5J^:&
bdVa2I]e]1g\#a6EUL9+>77P\8UTEBb6)#3&2#XI5TH86/d8e3W:D6^CXBU)DE\4
2.;&47(BXQL,T#\eXKJO;:dE=a[YQ^G&ILO4?2g02cDN=+XM-WgeFI_X\]Q_,[P8
FXaORN0KHZ<687-I&&?cRc>=^HIg\?A/Q1a/C]VLDOH.(^cM4H=5d3:>MLEDE7P&
YTF^KW(0FOO5FYCa#6/>7cGR[F[Ub<BE6b#&dARd>IfXH_QC)(C\)STJ.H;a@YF@
0RaYO1f)aN^6XLb,E.QG[RR8TFGQRPQA(aaS4H_=DZ@c/O=NH.+BE#W?PIKHV&P=
A5/D4UH8VRRJd_-5P[V0@PTc4\5J/a(dF@fe^MT+W)Q3@[A@=;:_;=a2IE)+2(IQ
6U@_,EDfCGC2\gb/bRD=(^WY4I:-aFVca=>V4JGWAC]Fg2ZaI_^.&9B6)K/]aO,B
/50.,D^=Q?]gVa;D)7gGH5NbU758O@J24e/&3d;OYC75Lef-)H;M#a&40V^QQD>b
EFQEeYM;C=<Y>fS6JV=I.PGfg[[bSE<RY0OFCf8:M]583NfNWcP9SW_f74]6F^6Y
f^.H@[+/QM0Nd@GLJ6CL/[DHV>KRd7;TU[RN9=,cRSEMETO,)9DFMCZ/8\)/fE:g
BA/[UHO(>D:RbB,B66]EScH5_XaZCT85\X]N9[OZ&.^&f^>\7>URFFIFN(f<Q19\
4bc-8e&9J#.JEMHVYU^V4UW00MFSdX?Ldf5Ne9LM=:@\+2#+Q(9TUVRd(.:[YJM#
3AM)KHcQWN;&@H78(W-K2Ng-R#=\=1]IOP4U>@[GMJ?WA^[WQ<2CJNIV9FIYe05e
?I_:)=>+HV^;:&;8<W=dSK@43ZbUP[3g1b2[(9Q]H@1G<]:CQ?U[aMR;6KfGd79Y
VP>5J]+f6W6IX=810.:9&+E7XD,X=TQ:[IHS+<a/4PfYc8F+Rf7e-WfAW-:[KQK[
NX\>^V8ES8(RE/3IB@K+NPIPX#I>=Gf5cL[;^30NO\+Re9#aC8:^WdS^#e&[4KPU
bM..:AYID4CcO<;2^aLg:K+S&GG]YU>>f=DLIW-SUa0+:;_3YM:56C;HN+\H)D4T
<_?:2MS5@e(=L1#5@D^H[I(Y]+N,-VBCO\220S>BSd#gTNE@=dS8\9a@bG9)]A@7
JA&-XYbS:gCYgcU9Ab8:0QGePBfSK9fY-gcOSM^^#I#4?<GA_\N/bS<R&Z#:</#Z
:-(<V[[&>+-1/#7#)b^,,e/e.J([7>g=L_A/XJHCTVD-X/fe?NQ/^/9LU@;>+1_H
[#eLW>A80PW^M@P]e?@-6Mb^XD(,cR5N)@AHW/?fU,M3L?C=6\X;+L=@58#8Lag:
)Nd)P0K;4gRR/=QG.7(.XGJRYR9S]KZX42JVaDW:&,<JV[PZ+/B8_);B^.#<ZU]:
ec6&(?D?IO&2U1NPH.Y3C9BT0ecGYX7Y52FM]Z983._9C)fR.:?L@>6R[NcLUgaG
Jdb=>&Yb8^6L=eUK7/(>g2LR]:3b38M#V^:.fgKf/.d5R2DQ44Z8)KD=dU>Y8AA.
&2KZfE3,)E,YDIT)<]g]JE]\b,e.I2<4\SQHI]Tf.(30_Z4\=d#<R)A9CNge9ebg
>_JcQQ]F5F^<8^b.>dPCY@d^07]7,W?DGb^,26U3W?].H//]e1E]bA==\MQ-@M?B
d)((JPeMG;2+O?&YOQ,eV-.]SO=C(5YCHbK3Ve2KGeS6H?Bb&SIaLL&BfbR(NC7?
fH@Hfc]OBW4O\;(f2_Ie\MU>JeO^JZ=F0LfRVS<^49DdKDR+f,RO_R2bCf0[C@[_
2T=),?3I>T5:1aD;&\O^T3KD[@ULN1Y<W.K28,3f/0:0J3dAR<[Z,EI)Ce78S9XS
fY8+3cUdBcWK4XJfG>F.[1)BD0B[&EJf39b\f?KDXYa9gM3>.AUg0OCLK;a+g9Z:
PT>[-S,bAAdKd>R^9,\0PA7-bg_3^eTTb(TW:7<#N];cDa,:Y.]S;5N-DScKePX9
GW,V0CAdXWWZC?5Hea+aZU&4\[b0ROC\<@FLZI9>IT\:K\)M:G-;<IKXC?gHY2@6
P426#N[<XVa(U.L_:9VR\TW<Pg=+UO:GYdEe66VE7X3)946S0>RS[fOb,HO>=b>9
^JO@g4-c1d1O/7TASR.cHD#L>D5#g;b[S\F9)0.Z/?W=,MKCeL)3H52B(251PS=+
[PK=:7/Gg6^=I/Z7L0/@-QRX0LCCb;:?JV7d<746aEQ\69GV>]Kd/SYXV1WWT0(9
_6-:][J5Ha#ZCQP</(]JZb,Y0)/OW?&MGS4^0)88XDR8Y]DQ7O)7<W)cYVSGf\4B
5B<O4)XV(aQCDLL=_4GHc\0NeVCG/cH9;NWZ/B)?>,;VCdG2+WfGYK]Pg_)=fA1D
^I]+SHOIdTME6;EB459F2Jg[<ICBQ?a]_H4@3,HBI><.JW>\N\SU#XRIO95XSE9[
AS)>J57(Q9+2S>#=E:87.3RL>=3cOF]2FQC[\g/7&gP+]<[d3&:)R\X,a3Y_N@e-
9IA;6-\/^D)8<feb&2-:F.93EZf?8LdZSCKT81TS_e.2?Q(5eY6J?b.(7>GdaP^9
1g((PQdDBP?(3B2_T[C6f)1+\+#<@g:0Te7I77T6PW=_6>gE]GbQRD1e/)Y<W&C5
\JOYMCKWO-4Ra.JSJ4JS<X#]L-VMa^WEOfJ1&&eJ#G\a[C7&/\BKXP(32cOg\K>Z
?@3@2MK,[O^Q3H1)EHS0SbO,D__F,T.^FKHJDcZVY]V30+JU546I&/CKWYUa0?M_
e-<X,2Wc,:T?Bc=c<],Q)/-g_Yb_9LGWF_[1:1;\/OFO1H:<)@<+)0Y8#R@OB2;X
fY_E@[Ucf8H\+_M-PB0P8F\?d]2XXNG\SAJ)M]6(0Q]1;(0H)e<<0F.Y2CHG6_:e
M5K.g9@RUX8[NNFK8F22/4YHg:OZ/#M_UL;S.Of?P#Z6OAdO\6DKXV>c<cc>&f96
K3215>NP9HdD3\9Rc&:^gLTF-FY=Keb6=c7DOWZ9EJFa/>8W57Je/4)Z_,Y;Ffbb
<g_=N<@R=RDC8Q:K5C8A_.CHD?U07=c3fR07@OFS1Z7XSL1FR0<KWJ+>J-bd2\(S
gR_(?P?WKC(6OSOWPFV<d7cY.GC#14M2EN;N<R6XfEZYIcg=>R=D[5ebG3RHN[5_
XgXCfBK26;GJNe@N;+V:^M/A?E22XaK8<N(+>078;V?(bAW8HS53Tcg35E22BFU>
]4XIR#?\Q8@PZ8?^YB^;SW[;-dC:_6Xa,CH1/D)VUWJG)E=8WP3)L5@LQ?8JOHE\
O5B]@#8=(+K214/SRL;d:0aELX(F^U3H\M^24OQII#L_]Ve<[/X^HHa,b79&\][H
9e[7S^B4fBU&,N1^X\RZNJM/3BU2B@RI2FL[MJfE8]RX5_;Oa&^YVT>bM;IE5b2<
>F7[QD+<<6;F&MBOcLJ02N:CdO-Y13d(B)+L8\4:5G-UeX#<S-g)c&^\cZF&/P4\
SORC&8KY2)RQHU)U?=+;7-35.]_^Hf[MPcK8M<[:,AD9EP4XTB=8A.JZ]0PD1ZJA
fW3=d8RGYW/QB,?+5#-EPI5GV<9\18AIg)0<c06g/f4;8M2\NN,d\[44c^bCX&E?
:HT2+.a<LCUJ9E]?D,GdY#Z?SY2MVBWf-+2DBDB_/I^.Z[LH.VMP9([TDPU)c:\6
Q=#.[&eD^\GXd0]Q7E20Z<.eE,>(Z<D[H[_7L#?/).eb7XU-ZNV#A3ccJV+@=K<5
G[&^GV+AI#1VF?Q<Ecc6efLPI>#,#SR1g]MUJVTVGdA9)@U@JOL6P56:^->c?e]8
41LQE>VR[D4M-]Le:=>50(RKTY2\@][HVe96Z22cX?Oa2fV@EXaN/KJ0X@J10D-1
1SO-;QXaA1E9a(Y7,Ue9Rc/[W=Re6a9(Ba\_>DcL;8VaB[GgMF/\V+;bXEZH,2NU
UZ@O-<AggH.91c7Q^DW)B6AcSV?>\M+E0JZdeBSEfAcbO9D_5;;-CbW)CRc3G30:
IHa_XU,Ke]4(F3bLP@[a)7^5U#XKBLG9X^Zed&Q[Dd85C>?e>HHDVMI#XddBR4@;
?YZR-@;a.]a?+0c9@DA71L>Aa@&BFeST-+94/WKA^fERCIaHDI32@D8@,[WZ5F(.
3CN]B?]Sa_[&A1\S]O^P9dP6K+HV0A;g0],[ZF&FN?=7X]A#L<H3.)]3d.>AEb&.
I)4),4\a8G?6^W_RRNJQ7Y=;PAY]C9:A38@X1g[02K4M7ZUf#IIY25RQ].8N^gMH
#H2Ff2..\66/#Ec^A_3Fe4]V\HN5;RfT]G&N)3]b9HMZ<]I+==5PfEI#(W0>0&),
]C@)Q7W/(SQ<M@^bF+:P,F)SdKc>;V0AQ1B2Xd).SEdA\MJ96?/d7.TVLGJX9/C;
Oc;Y#Kg,#cV86WaW1>S(3a2]DFaJ0P<gc^@(1D#I7JS^R8;K8O5#LB\/+JE/3b<F
#](XeFEOR+7M::,)eY2O/e[J5&)PG9+_IZJY,Q[18cN<M#:a&[e-?3ee.R417H&0
CbEZQ7>I\RN,Z#G0\FW-?JP;b,Q]W057c#2?I7/^.JZefB;QUF##V0a=LcS\Z:K9
HdZ(TRDQWP:5P^B1cV_O7XKR)3L#b&T#WXC/NJ3P=/5_H8>e,/<1HLdbBUR9_:30
a0]a4ES7MSUc;b[86A8.XaAdYT.4\>YI[7XV-KL<&Vc@T;T^GBF^:f>/fa55=(G#
Y/L)Te3J;QE8f+:O.3&?ZI<D]IE7_WZXJQ4&;R?dI(>R6(JcYO@^gd](;61?WY73
@:)^T,/afQQB-1+H@YG-V[.KgYLTJ;P+f6QH=DX_OM_VDJ5eC-]S<6WgT_0_.T7^
c.K.KG@;4Y(dA9?W)FV]0H&=3;NF.=RZH?[SJ23^7^[L=MM)CN8OJ]M>EX>&/(S/
/)^gZJ;QE-<GG<MAYbE>)(NB5aIF&e5ZFaRLgXG;^abE&gBN:a&K3E[7&EPf+Nf:
.A\RHEQ&eGN/-/UGT=:<H5JBDb]MY=RgD\E\S[&7\2R#bC5J8;MF^K[^J51Vc&].
8Z8E6TLMSgJ,.H#Z9MO1)beJ7<aC8#)UM>CP\U.a@?MgO<Bd>&W7Mb8..dS(Wb,:
IeHbJRX(YeZ^#.K<O_&ATc+gCJT<(7Z42Y/@PFM/EW<9/HN[_T[dg.L&/CJI&Yc&
+U7cd8E\4P:g-d5^&_KDNG3^Qa.G;?V]#R9]:#&;fM6R[>9FUJM,MbV[@GF9gf\=
-/e?_(dNFTC=H:@1UV:GadcCW1>cga,G0(.A5M;8+P@65[#DB8D&#ONGF<PSNaY7
b<O[J68&TVdH4bK;O@?SFcR@a292ZG=Y-J\I@0\ZMZ)<51:+:-fbc9g,PMJTbD6A
F7fAI5D?IGO^-JG2]GQfd_,(]\;b6QaW?@g+VG=L3K&gB\_N+173&GQZ@G]LQ22W
19]EFBG)S(.ZI8Jg[\[,&f28&-EC4gF>VcS8beeG\@XE^C<Z<_[a1Q[=ZAUKH81:
LR7^3O<ZRbSO71C/W3:#6R/SdHW6]?P997#:SP[2a8Yb4ERfbMJc-(\FC+VQ?7d#
<)Oea89#VJHOTYA3_G,SPN]0=HTcFN-6>cdTPFOHaEDG=]/M]O=f2<B(gbR>>8H:
5f3RU#I)fC&#c-L28__P<<C1]Dfb((78?2REa?ZK-IMBDP8]IfUNWV-bCbUaI-CW
9T.MW+FLL>^U;]bWGbVPA7Q1US;60/DPDY.-8/QNTM5<+KX)#&#M9_S<bgL]8bVE
E7_1c\Q9V-JF[_BRNLS+G6cMOQ;T-J)N4HV#&7.=80+3?-_AB;/=OB>+ADY&<dH\
:FX6BP(DDS-Bg5&D<RZ\]-GcaXIY_MKK.5UGS8S+_>WG]+_(F,Q,VeS)aOYR-T<a
dO&gLMX9(g)W;AgfC)A)M@gKK<L+NLdLOP?b7T]KR4UgYDGace8dNW+604-#&I?e
?:I=bC15Yc^E+6(e+agU\Q5@eV\IY,b6__;;OCWS1.N2K(W453d>6cK#_4E9T/B_
Fa;00501JbT(g\),0#3U&eHR0Hb:c(,aCfHB5VUIDV#<QB?6.]6PQC,[.S:7B_EB
:91F3&c4=7(_:N3,caS<GfdOVcM_@#3ZFO#,g^8<LSGI20edV33R1GPJ0:G/CdeT
H3W-W.f<.Lc8AVccCaQ7KD;J8;VaTR5>b#b-Q:GIL:VNg]).4O,S13CL@/R.)7T/
a[.fc8BM9,Y0QGK37b/K-3^9M+2ZMc0E>Kg2ZB5/E.JMZK@E,/FXNc,_H:S#aDQI
/ddE00?@g0KJEB#a1K?YUKJPAXS;7SUDeeK=9;9cOJ@95aPLcPB,O>HF:>1\=_UV
]6GRdBbE\.(2GLW:@b=/.7WV0[VQWN9Ne>:b5:eV#=c0>/MMHE^;:g\>9/2L7f8Q
&(a4S:H0f66/WNd)dN;/(b4XU7+gF:c1T2,FR.=NW<I&CP93Wb/S98?WEC800,K)
N\F/Yc0+FPNg7(,5L2U+eSKZZb/2Z9)a.]BaD]I,+/RZ;8QS_P<KF3BM)N/JT)C=
\-eDMc[+Q)I[c(T\I2L,)?@GQe?3\K84C@SKB,eV=(D05@04,f14^Wg&ZY\&@<J>
,OfD]Z#g>T5+gfG4cf.PVIIdbS&FOf;\Q@NMY?V5HHgP=cTd_,b.#AT\062cTL[R
KQADKa));(O]WT2Gc/PT_Gag#8Y2);],)a_[F;,KJ/E&4W9-5)^9G^:RV>PID=<X
TP&.;JZ?e\?d3X;Pe6E4-53(<AfN;Y+XEJ,bO_FB&_B5ZMEF<=&cYK5:S=Ec1[O]
G<S^-T]6:7F/34K,&\\GcE3HW=^<8/^5JFbO/4Be.=/e10JgdfK)WR2GU>-X12QS
cRDV-+1ZCT-/TLQF&LEN@C<G>9YfAXZe\BQVP<=6SFT;N:e/B=?O1A+/?dV,?gYC
fUa&U]2LFUaNXL=-D#HP+X)(c(81+AHQGI,A71EZMIb,V3.7<RSgGY=XG?O88<gL
:9,e7g0VGeX1WMdR2:#61@QESFM^b(,EbMUg[\T16^BQ3WT^X[KfdGb_QL<gR,M,
SHE44I@>T?LZ&QPG>(TGa>QE3$
`endprotected

`endif //GUARD_SVT_AXI_TRAFFIC_PROFILE_TRANSACTION_SV

