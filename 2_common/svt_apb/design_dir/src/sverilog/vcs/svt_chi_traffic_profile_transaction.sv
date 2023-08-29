
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

`protected
2CQ(TK8DcDTcdFO1)]b8e&3f:ef?eF1A5<B6NF/155T>(#JgGNfA1)CdTU7^8e:)
.<7eTMEg#S.N^eS=+[[4]GDPa[cIO]P9[aCKM&(?02[MaIWd.HEJY;\J.g@M;YFf
42AS&e#g=F=Y8;0R/,d-&2TF2<1cQVP8dDWVO5(gQGXW\Z0:N+D(R?eZFV(7@@H3
2?LB7O#=.BVN(bDZ=c]-^J/5K(\FF@LFC9eJ>3QX/EV6]B,gG=:8O_T#H6;c75/8
2Ib^DG[)[#&f#0F2I;<A7-UH#(R/3K>a9?.3a>BGgADHO+SK3I+ZSdAgI(JcGA2B
RF[YR1GBV<KFW8;<g9XA=?W;::08Y.Hf+?FEFC1[K<AVC/#0?c5JLC\A]4772(g5
aWS,\)]E^NAaf)PLB)(0/(FBcc>(<,Zf<Y(R0^W01O.3?@H)?--Ne\e18H=CS4c_
FVcOKAPO0e&NZa]041F]P=?IZ0?Ya;51;&e,>DB(<-7PPMD_F?DS6O\_NX&);.)4
+X2Cf92.H0dZee8^&<AH@#Nf\[>3;5PP/cVTP\E<?KFb\HL34G+PD3X2,0?NH0)@
H>:4:9O=HV:<Vg[WY(L>JV>UG;(--</<;RH^/C=W2I>T[@HZaPTWEbOSNC:E=RIT
0N2GO]TRONbN&E6(JOMI&1\X],GP>;&&+D^<eT#=ZdH8Pd>aF62.CZ/3dK.KcA_Y
<U9@MNK2A?B831H>[E(QgNLeUY(#NZ;VW2X+Wd@Rd=e\3;V>)#?;EJBYNc1.]BYL
MWc2PZc7a)VMXcH?\HK=&JeXQ.d1ffP(RAb8Fdc4REc(^68XaOU7B^+Q\NI[?NLH
Bf-@09/X7KcZgQ&=KACP&24HN->3]FCPc7R,W#J\e/Fbc3ISTSTM>PEC.K>HV3HW
R+QS08@a8a-\\J82b_T<1:gJQ7K5&Da031=9]W-8Y<\I@e^&de/Q&@W:0gUVSf^4
X[-I/b#g>e7R&C9a@I[E-AQ5OQ:K<?N2+_K-D3&+18bH/T.+N@X9Ea&9,7<20U\:
e<^8ea3(,36[&bcHIH2:RaB2-aU&46=/^H6cT\Y;N?B#TWEH:MLYU/[:CSZ>6A(^
2gL\+a5#R.ITCMKJaQX?7LLM5bT-cQA;dK>WHQRbe1ZLP8+UA7?-Z57[QKMJbZYe
EGgc)8CHd>8:Mb^S_P-N#G(IFUB[(?/eg8A]H9+KbQ]PY<X>;36E^36?BCTgeBR.
S?VHbVR7eRD&[#NFVfOaOLf^\;=Uc5P+g0GAg?fL7cZE-_<Igd72Yf\#+BD(ZQV+
)[MN2;Kc(^Z;4Z^]\K^5C#45>)ge>\-WYTD3:>_ePLZI;T)0BUOTWM73Y0aR9KA+
RX-:dV+V/S#a=bdACZE&P#YGE=>/b<_LCIEbe;WL)82>/@V24O>7K/LWHc^7Y^WG
P](3cYK<RW6KSORPf_?A-[5cC1.X,]#)T^RcS>X.7-b,>4#dHR6Zg2T@FZWTL>B.
#9SG4EPBeCf&]>fTabc]b4]8SfPN].0GCE;BVC):#N-ETC48g;>QT3XV6/=D0S4d
SUD].@OAH;-DF1(G7b/e<dg[4#:C&dCB).4)KQNfYH-44G@@/RPAA(F)_gYJb=N]
V:caFK5\.bPBg\IEBH-ZFC.[C]@=[U6:N2TYb]IdDE?g+N,G<KBL7Tg]YY6-8]73
S[7cE@#c5-X,Q2b,+6D]SI1I^&7R<PENVLJ+[GRbW(/?:VN][d/4bCG6=dJaJV^D
\?.ddaW)E:=P4e&G-]S@>R=]8FMY^f)\4M8gKC.9/-96^PG1d(bd3SWa3bPR6PVb
g#1F;>cZ:]?ZW;fH)403[GEEN>-.2f6I8>/E4_/33HePW;D:+T=RMHIRT7J9<M=[
fWU_H(+e;3^2+^A0>>d_EH/UeEM2?YQe/b&E4A))Qa\GCbGOI7XUS1)cCIZR\TY8
#F84+/Ic=Y>Y2_5e3,V\/@J(J1KQ&BTe]0V^1.ZKb3/[W>BHHEE8&3N()KdA)RcV
c.ZL).2e4A+4W>G5;7M[)Z3dcOJ?f-3-G3HM(]g[#[e3>a&0ZA3AN)2LQ0gGFXUZ
6V<;=fdE[BDOJIEK@1WJ+=Mb6JD.[>Ia2[X#^LL+/_=?b>A(UUAI3a6D?=aJ;Q3Z
3PYe8e4HcIX<3\gJLFc?cIZ14eb@X@PY-72:JKF;8D).1LXJ1L2d(#=\F1_+IG7,
D8F02#0M5?8,O_aLN>_0(fCd2SfPgIbAZ_,FF&?E\#LY(Rf#E:[9P&#0&#5F-+bc
0V@8CKa<?ZRR&2cF;ceTN6J)H5)^SUFIT:V3LW?Pb)VC6O0;\[[(&@:-22D,(0c9
>GOIT]T6QPSP,Q3:>80J7FK,2c+1a^+VBJeVbRA5eefXT/-8^?D\D@]S4.N:7>54
/^Z<VFgABf>6UZZ1_4[VKUb58VDeLI3PDa0BR&G\S_NS+(WLb#F->VAefE(Z+PO]
NNM(B8-YCefVJ7R]T8;FE#1M\Y1N2LW-(cE6NY<AJ2S3V;CRKI_RbQA6^@[N^]f4
5+TA#?4Y;cT5KC>\ca?.Ma7a;9Q)bLMb2P+T/]+]-?)IgJ?\Y[]F[@ED^Zd,\(@(
BaAIIf[VfLHB#Y?D=LEf#faW+-;D9P/AJ(R^)_O0.P-OdR6[I>X?4[Y<POcME<S;
3NK@VOZcfV,?e51@ZZfeD(9Z(CDLC>QFOfRB3FG+V<IX4P\]ED+\[5cGY77dL,ff
-A.=4]527dgQaS0H>LK?QbFD=XS_VCP<B=90T3.P&/C;d/RXOS>cLR8)e<J0CD6P
)@#77VQ&f=I/\JZ556J0+UFBJED42a37JfX.McP4[;)LL3)C7cg[bXFBcCbT\7[\
T?XWf<cIX&#Q.4aI?=K);]H&2#)U)DM[Xf:J:CFXI+aBWbLedR0SH.Ib_&FJFF]U
VEH5+NPE>+4/VBT67Q5K09<RB;.XQ2GU:MU7OYA276cfdT/V\L9,;=80]16(-0]K
QX_=_/EcdNEf:@.e;XC^=?KK\J,N9+a;Z97B31\FO9V[EQVf&9X8?I^;&2;Pg0.?
9UVL=(+T#LLT6/;)YLN4B)If^2g0c<1EB)Rb=V>F<^)MP27<VHW52<eBDaA+:9+7
:ICE\5G.:QdaEaOWedbg;M@VYZ;#3ES)L<HN9ST-^(AD[FfgZ-7ZA\gA^Z3QH@]9
T6E+W4;?PA0@XL)5?+,1RH:+BNR_J78&\7b=G<0UPgJ<C8NRI,+84M7[-SKE:2MU
)NR1g_21_ES6N8FTB@-<MGI0TO0O\VVOE>E;C6FD0ed5G>F2FcNg,cW]gcGTIC?c
\MTUHF-2\-AG<C0f?W_6>P4UUQP_]&0;e^?-W<KRW:cQZL7cc8JZYPWTP3&73^dU
0RT#+9/g6TMeGZ66-9<3aUO@(GI/LA&VAJY?^3GMDXgWV0CE,gd>ASQ7_f\TITS\
+IGD5C#&;MX2W=F]T^.?)fA:WW]QW_JF5+2F_3KSHRACb2UXE)=G?R:P\Z1XGb^F
;9UQKPO;1N-cJW+<a&&;]S=AA,F7^MJQBJX_F_Q.=5M=a,UH-X\VPE,244Cd=9:D
R<+=]/AC6YRcHX>Hc_.0bH,#)C\))NgId-0P#NO=3d-J@-S[5TFLf:^1K;XHdQUD
618VeYH5L>_T9T>G>fL]X;-\YI8@P\GFI,JMT32XW<a+&YGVI0^[RY[=a,SIN[cc
K:J7b?fFK@]gM\FNEP1fMa.R&/)>16fJ=<OUK2-M3G,Y#:12EcfB[B3?d/EIYD[K
TE4_?+<C=47R,d;(T-S,^SM=,Q(d;AQ?U::DI\fd_73PQ,B<9_Vf_ILU\]?A9VI?
^0=:,_?V-Kc527g\GE568UQO=N4Pbf;,D+HP\8bO<^.#U&W\B^2#()<0/EKeaE]1
B36=Z&K/8[^X@FA_]5-;97d(#Z6gacIM_dNRD73=07EH0D76bGW:e@7A7#eKE>Q:
)ER+RGC[Ff5AQ9++&fMRGR>/S2eVT+>4Y#TZ6+P:N-aWJV-Q^ON;7-.N9gY+c7M&
>Q]14?JN4ZS\2\?P3XQ\2ET8OW>,DK:HJ9UBD>A^D2eNO33N.F-@WN/2Xb+R[d=]
?M8?P,RA<;a7:g/&>E9;#C_71LeSTR&_RF1KDFRA;O4<Xfe<(4:YW2TY)M0-<5KY
;TAK&CK)D6fc(7XT\G)D/2IH6@FH[:S<R85ROBRc^]:./=e/gEZ=-M?7SeHA\5Y3
128db_;2=MR5?N-bE+VCYdB@@:cF9Cef^ND^+e,dYb+D<g.A1Zf]K@WCg19F40d2
]>I51T2HbN_).)^(+#e&+4?\FK-=J?)[<^Ef-?R1?^-Q95LAP00U[^1YRH8:@)0Z
.:(DO,+:<gDICYQX&?&X1GN1[,CNM_Zc=K:3#?aG?2U908RR\085CTaUH.NW0g.#
-7_#,>4A(,V6CJIg0H(EM&S3>,K,B..]9]CK3dR3IN/PR[>;IZY/.>W\/B=dF)_E
IBIe)NTVHb6f\V6R])QH#D5)ZDIHVHd@)gUId^0e(Qg_O)(PMeX[+-Pg&X[55M4B
TMPC/457SN:T-]bC6d<\/]c&5g+F;_6,a3P+KIB46,&F?P.]57_SFINfaHB&)<:J
;_N4YJ58e(g+Wce4>0c813c0+[<eS2:I0U+f&ScT8f,\b@(_C;/1W_Y7TX/bWgc4
]-S]N_RV1/F#I\6]XB.-B=cJ3<8JA#0c64KI:NIW>1F<-;]AA@#U7A/e\(K:LfY(
D6M+P@030ZWcHI_&KZ(SGaGgHT#?#8MW;FD^@_f1fG3N+QJ9E#PRaf7#F<VHE:32
Q)Gg-T]0/W?^9g+686a1O6,N#><WcAD33T#V\)V__UM/a8[]B/&-H2\MaJ0#B&Le
0J1&Q3K/VQ05NUEcO_I==R,@W#/>+[QJP,-34RB)ZE2.7_^Q3I@2:=0X&#C>F;__
>WM(0Ab9M[@7bNI>F>5Z/COaa\/85X1=91O2RNBIP>N,3?>[NWT.QZTU(,1GTZSQ
4IZRO/#f)-[TQ(d]<OM\KQY^#UZQ>?SWGQZ@#f60B46SeLZO(N_dVCCTaW\G@g<M
+I\D:]J8_AdY?XQUe[KV+#1BO22+b0/bX,5Q<3cdR4YeOA]1@ONH7,;g\b1KAcXF
=H;6RKS1AROc_58<c]LPGIMI/5TM#A:]51dO_[F;fd+]5+Z;S[U]<]S.gXKENG]H
aDI@?LE3MOH<J98;NN?:@N,QF,[d>WKe5.)\RN[1(XI2aSKeKRDD5&[@)O/F)BW+
P+(@W_=X[aQ@F^G6>)Lc2>7[4SO=H3PO>EPENOQ1:H5R&BNUTIB-6E<P#e8-[FK1
KSS\/N^\>+/;3DFgEFZ3AX.F#._ZM^LS9fFfQ@Z+dO6>6YY_bI)G_2S#L/EFL@[H
A+/9@VYbY70=C=57gO)UKQeT])OJ>((B0d3RLT3Q8Tad&#,[<]F:F]BPX>_@V8(,
<?Mg,_IPP[#1Y8g=W]eCPI<b#Q_(JYUV@K4c[VB[ZGc2V+?L<Q#N)I_H.(_IN9.G
:RKR/]#V1IfDUDWGHR&;<,4A-VFAcH+a9Y+)=dIH(S\8G2-3P3Y86Q4aSR88:Uaa
\39:Ef2Sd0,4:8KJIZS+AV>SQRJRRM2e-,Oc_@<HD)7^-Hd,I[YHU90H8D_N9-a5
,0Xf6O;98Md\7NYA)>CEJ9R::YRFf0:SCR&/GY1J6.Cb/1gAIg1=U_VW=N0.1\1#
V^S7CE\3P0E]g/]&+gA>R,UKZEQH8GF8C9&PJ[\8+<:IF:GP58A(BI6PJRV_Pc:-
;KE5F>ebS.Eb+@cNI@c>Sf44JQVNe,?T5P=Pa7V8O:d2_S<PT<Qb^)E7+QI4SEF+
GC\8,NG9&c+7PWFCN_S&3J[7Z0O-0GP\UA3OdPY&H8Bc,[;[/[CD^6)ZgNb]H20Y
;.-a=+[H(M(&D(gJ;.&+3@g=7<2.Kd;:R6fN#U6#JOg>ZMGC>OS8=-5T>W?[3VLS
[Z?ZV//_W@P]=[]GJ7XL@9dSfCO(W6<(76LL:4L.R9/X<./c7YWN,_]L6@R6Vd8?
&ITK;77;_0\,[MMbRF5T?Mbe53LL/Nb4(MTXPQL&Ff-5Ia&>W@2?,2),fY\N5(ZT
XdD-A1E<Y<4dTT+LcZ8bLb)HfT^UCE7U2CL7C_Xd>L+Mgd:7?V(G1-8UU\OJT?<1
8^aM&>d22<CYVLWcI/[J2<@BE;Ga&9R]&\4P;^]QC-IUfVd54?e);D(XNBMPA9+@
=@E.6-DU391(OBdg>TBC6J]c#YG)=VI;9&>ba20VIIVdX-ZSS:X<#?-+SAX,#^<e
A[(U:0KY]J>U#B(\cE4FYHY,g:aKH[6[f9^2C:=.,)466-45XF^#P.>OE8J.BLD3
F^(/G/S59a-7McMC3@&3[0;7T,Y^J)DG3KeL.-PS8]VUgWJZRZ?R46YeZB4K;a:N
WO#)5)Z]X.d4U,dUN-8B91Q3BVN^M38TcK9?.b4RBS&=#SfT)SRG3V8N_363H<^G
f4U]X^U@S.J1L\;Bfgg8-T]/8IC^2:TT][FAGc644(fLRDNPR?E@7N3Cf^75a2Rf
T-(R7XgOG^15QPVI3E1\SNZHPFFA=CF9<(48=S@QWI0H)d.U\HYgOdBM_7Ac6XdM
c(N60D;gN8G)8R[++WNV^I(LB]IL45P0fDBIV4Bf9+^)#ZG#1Z)Z(7c?&TDK3U)Z
IaS@.cZd>IKV9c=GbE)E+a/A1]SY5<(,FS3:U33?0Q3Q0^BW]93R3KB>6HY.>&<T
+A;_JIR4+_@H+RV/d=JZACYG9S64LQ(dfFVf>K>XGFQf03Q?Ge5eQIVV2]IICZI/
MfNKaE/&L#C\524SUI1K)Q7A4)[fK3:O24U]UD&g&BBH9@Z#bTGU:bJ=;=VN9f#I
gHdbH9_f#>#,CG8RM>AOd[Q8>c#T_ddSEVdFCaVTV53;IWD:+RE^#3aRgK;>a/KI
,cH/IK_VF6#&M>+bBI?,LZ=<C>ZIS^V&G0J#V^?Ff0U#Z3d5WHg/W?&ML/FFY)]/
7I_COIL6,\M:Y[N53/B0-8=;O#DN^//-5aZ-^M?c=0J9^Y13ZE-\_a]Ed#dA-M,f
-14/Fa8Hg5-]Hd8X\C41fZFIdS3EQYe2G4F39=?_IJS?f[=TgA;Vb+L5,2c49-NU
</U,Q2RIY=d^:NCT[I2F_&U=#QLHW^A&S7LSQ7(T&LNF?CfTEWD8I2S)@\)Jc338
M=26;]-e_;[?JL99+O1FBfGY6L/O.VQZdA09C?^V5K-KP8V]X>WA>cRK2LXV7bJ?
2R8PLG,80]-W&:88+J0;AT+8KU\H7YR(M4V5Z)[?7D0,g,5K^X,_4U1-EAF00FB;
-e&9(G/_Qede,:aB\,M6>Q5g&TP=3&_/6WHK&ZI&9+#IdGA>U<c)BCXQM14Ia8I)
XTJVH]X-W2I0Q]QL5ISbb.UI0E.,.QfYNbea3;[(UgN0)]FcAg_#W^cTE\bMO1GK
a8FRQS?5a-94VPOI8=9OX#M_/bAY9EVWCV=gFEZ9c@0cW+9#BLD_>VJOL5=?EUa(
O..C3V1HB@SA#@QMbcZ9/PSEVFeb[LR82)b6-S:4(@dR,7R\[^VXEYVBA>+4;AL1
?FQIRM1SPa/30FEES2,,9^g[&2J)I(8BfH1+XY^D&I:(W#_S,;P^O?F.R?<G))@/
VM<J71KPNf3.NACMOW@/CBOYe<@eI_d;@T+?2BOf^HF]\XXY@U7fYGW=TE#P\>0@
(e&R4JVH#1I>-LN?O7&GDY1Z\_.,O-R_&-]8=?+[#DTCFUPD]>,TbEJQOOe@1&P6
M3&;7eH?I][HJQ<F.M[&edBGf7-7,_I\3)G@_NBORgH@f69E7^(f]<bV4(EERZeO
M)#T,:SB3fYKS7VC[VRg9LPJK?,TVT.V_OIcHQEJ34\1QRdDM7M>ETagYLcUUd\/
+30>&?0g7IA+gPf-;H2DG6ZK:bd8(.F_P:NVS8V(477G:<g4[gfKP].[G:fEHF2/
g[G]AY?W55c18F1KD3&Y_+6=M5TfEf3@#8\fP->O)M7MV>d&eH:<NSWeFD#[6)RJ
[&I7-03KKZL0aNI+C^&:b40.#Vb\5FOdGdD?-adIB:?GDI4&K12Y67b(dIcN?3SW
]N)?7bDBN-U:]F]>(S(2MI&cfeT[0^(^@X3=FO/G2ZbXL[TY\f2/U?)RG/g7(98L
(+0?X>^TO18QH.<=5aO#4GIBRL5V[R8N(U5dFDJVF.fWKe82;44I>ZYc7,]LB[E3
^JX7](2G[Y,g0dXGg^.Q#Jd8g.+34aeZNQd-Y68K)ee+6I<NMFGGUGeMaACZZ29^
2\+^/=\0IKcCQC/HTab&836^ecg?\LKeA#(W]T39dOCS<@:0\639I9K82I0+OWOg
:#;W7SeG7gXJLJR.M_6U<:c>cSgEU@JJN7-VIC+AT,4Sc.e7gK^PKaB?PKS>Z[W-
IFF/)\0.8>I5b)97&E7.>:@Q.;dT\GT-E9d^_3PV1@A@@#39G3&WJ46FR(WbS4>2
a4E^G:27:#.:=-Q-]<=0R[>SdHa^H):@/F)SVAGA/[]b\#+c5XLDFUW0g-S.:QSN
W-+C@.Q1FAE(-)Q[O=abg/-[.?^K]U\J9P[;GGNC5WgGbSEWDKcJP[-:P&6;fC/>
g4fN\HG>F]>)F@g^^-M5[,_)1VM9M#>fLCD_P.G[(^#JM2;#IT3&L,B[f7b:G0ZV
SeXFDS.S^H<gN=Q,4>d0GQ(C.A>b2[<PeUfFWFdP(EG@\CK<aDX:=.2LGf0Q1S/M
E1c05(;3-YIA#3f,+<H+E^4:XQ7OS-^b&:B]cfPY/PL;6W6L@[XcU=&=#8g>gR5^
5,B8f[;3X_B_VK-DSRWOV-Ic6CWB@V5^0<1a0X(_1CFDQY8HD81.Qeb_\]B6]1I?
(9(Hb+]c@R37H^RO3BGJ-:<OWHXL^H49-)O,>7fM;W/#>[OgFJbYUd>+R9GH2)Tf
JJdAVgZ9O+(^ODTB#>5YaN2>#/?J3f58T:O5KA2#F&_7)]D_G^ea_TOI;RC6SA/D
<Na4c-/\:eS[cYUU_9cB#2F1>WFW\H\<^c^gTV:<[gf;QIEK73H1LY2I8ID6?WA5
>@8>F[8)UK;GJg@0cb-)G&37YeN8H,26Oca,WCZ\+X76JfdQ#aU5EW.1JM0&,WOI
Y8M:K7LZ@OX683KEa&_e88e7I;98I--P,H,2_G[+0-R@U=Xe@PP&DRSO,5(#XY9N
cB#RYGO1S:HIO;YdA,]#)CZ9&EK3J+WTU(&_L+\(#:KZJ#(Lb#23\X+_KZ^[-RF+
,2HA4WI;dTf+)Ba[G^M.aAI[&:EE[0?H+:0S)R?cZKB\L0C<BGbA\S[Y(D61)7b[
CF(8Z]5e[.I)A?/gTe(:VGVf5gKUcX,?&/FPWH;XZ>N8Q1H1BVF#)+WO\fb93.]X
U6c:)-Ed2KMVUa9>Z)dbdED:_C/>>CQ9>TT?dN0Ce9Qf(Od(S^[ME?f5e[3N.\NI
VCf;<b<Q,0Z.-(>6RT.);dD8(O4?6X=^-N_Y?X=8VUWYOE1(V3>@:<R[41[?K4e/
Ng3TW6,<]C2QXeI\b9,PT/MM55eMX3OY<15/6:aeB/dJ9UI@Q6)abYC6N7RUI\.(
9IRE8LHUMP0SC4C[TC&dL^/]JeW:\FKOee,(X-#(C8N0+7L_BS<Ke0C[)B>.7+Vg
FSI[UCdc[@,a7B#f^Ycfd+9XUeYF/[TZ0c^&\W\X/((TWZ:6OMD;,3CMLed@41-9
_D@d=a4#b3a)08cGaW=@U/gMQ\HD,WT)AR8Q),912/8V9gBT=D?&LILBD6NJUZ^0
WHCa)+(E:^G5[^UAQ+6_U<P8SWIV@J37RPWYcdcT-YGJRT368\1JPQ,7-2R1O;_G
NMKe1+(IPaaR3fA?N6MMU6IX2-f_AWDY3G1=/=,Z0Jd^OG=H889[HV=g_MMQ(g?W
@)G>G]W^f(DH-F1g3,eJ:TA=aAM7SY)O^Hb,5O=B>^C18S:;WE_&g)X2bJ-dD>GV
TWUMf&Z658dZ^O.QENPH2:M60>JQ_E74Ta?<NaG4Y(7XCJ/gL7]?NJ<2O.)/?]\a
6VEJ86WLZe>@Y7]0I14bLN^CSaGC0B6NLJ2O:\PeSF=ZSZ)A)GL?^XY[e>^B2H3<
JET;MNb26:583;0.g]8XF8NR::Sc#K\a9.3J\OCfdHP3<RT1T8V(ZIgV2/@+N<[U
3]R/WV#9]KS?+ZCS47Z,+8GU73S8D7[cA=E?W/,B79[He_RLTUU7=VT6W2:NSIZY
@J75-)IET^P5PRQ:6R2&TQ9:_[B:T?@Le7?N#-QZ9R/YP6Ld5+##HR-gSgDfV5b/
cP_ebQ[@7J1B_c^SSdEXC0Ze9O4/_EO(^X\)U72N)[:YI,0AEHbNbI/Td6?aG8AP
</a(W?Q55_<;Z[DJ6W>ICNXeBF.]UV1<4(GCL4<;H)<6ZIc5bbR30Rg6LJ;BRWL3
.GEPG3=RBV/]N3_fG])ONRQB956:,F5IP090:B2RLW02.>KUQMb57Zb.<d+X0FDY
4Q]b=fTB7..^:B/,78J2PQ#HBX]VSP13Kc>.IePJQ1#PQM51MZ<KG+fBADJ>M#f8
9T?d0:#Z9+V2^>9&];^,PYX#,e54:,dZ(U6Q/IWCU?&+d0CTNKR5-C?G=UFBDE@Z
9^36VK-1DVJV]QVgb-3XZ,cDEOHHQg4b[&:7>>1?J;\6RF;cUd9RPEYOAMR7daYG
;33]_CTM+S5Xf=:a3d59N@H2:SYV[:49:-GNAUg:c?cT@)_K:HJD7NFT9H1bKZ<@
7]\CFQeH?;W>=CYc03[aeAI0Y-8e(Ie9g>^MQ+ES?;1T-G+K&Q-bO6KHJT_#HG0[
_]db&>XM9FW@BYgE;Qd6#QdQCJXJZ:#NFL?A)4V:ICSf1-2[OSL_QRa?MWWb<;Ec
-Z)=]@2]/eW\4eS83_66=9aW[Zbd2RNNPM.^DS16R@;5>9_^;=TMV7_OQ1=7D(Vc
#O9<]NMP+bE7/HcT-Z?/bMJgR9HF2gBAH,K]P,2OL744J=Md4FXX6MR;/df\5aO=
K^YS8E6<8C<J@3bH79<GL@D^1625?_OT3S+D9TVX-7ab[C._e&R8Ve8U6Y7D,[DJ
A17HZ[C(IeIK30TVHaH9FEW04.=(K>68JaPF_S-BGETHNa?7R.PH&Y</NBHFR/CG
RHC\YR=HQHTc2^\B??eH7aYYDSHW4dI0N[@&6N,>H:C/gE:+dEY5J;3E#.<&8NIV
6L4<;-E/^K+\KJKFd-bMecgFGJK@/McD&d-5)(NaT;_<gPG\\/R#6XE5d35X@7A1
b3U8Q7C9D1\N(S:(cF;P,?KQHg&dPV:<,cW^e0ALQ<9+\&.8N96YTHJ04Sg1Wf+]
G,63F6H9J<O/R)Kc=BT1NI.T9BPSVd\\:4aa5M9-#+EFWX(<TV3g#/,_V>dOVV@:
^U.9R;PCFc15PW\#^_aLOI.WPE6G3+<GI/eC,<W__cM8ZeN69);;4IbF[bfeIaLB
2+RT^DMK>7:;Z#W.NMIHN<3^G\adE_,<B/OR&_#F:fGFV]HSM2]1UB6H/3Q]PVM]
#:0K@6Z):FF9,BZ7HGOA0&C2H3>,Mf9a,;==,;5<[KL2(W?H]_.)<HZ\K0@P_,C^
=_DUAV=#VgDUeWcQ6<+Y;@@>,Y1e&b)>c1YJ<g)d&VaG53E>=ZW8P(/I2_)bI=_B
a;HNK?eO=@DG0<ZC5-c^JbX,A-TWQ\^10,<T/;/NEg6D][,H?:Ld?KR.1;[7;&V4
_K]FPU;B8D2-ffP=D/)P0IALa]^Q7eQ>a66M51e_0NMeIDPf/gfT&c8Q<\8M;;a7
/g?;SPbdf9APBa,T&WJ.-5Y[@&d3^C<),8R0U_Y44/OM[^-]N+ZKLGD7)K^eOF,H
IX3@8MYU7/#a&:W5II=LQ01XU@Be>;T#4A>JGTJ[.>RH39).LH,TfB7A_#]B^UE\
JNJ7TA<e^+POg=B;P,8YXX8,LWb5CU_bJ+V^(WDF(B^/gL_e;Q9N@?c;J5D>K?R+
X8e/-5,YA=YXdGTG3^ASI1/G/HP8Ub?DM4&WcXaQ#?cSS\N[K.7f]91?N^\IdY2_
)H[6gRe--0:GA?K-(f_E;G=aK#_@J\6IQ)<GYe)N\6X&\)b\.cL&a#M?W-2[4V^@
_^^XQS)5d<bg=;5N/#7OVUR;IcIC7RdE3N@NfPIg&4g>^;a/G[F<#_,9[.Z5Z:/a
&EbbU]MTaU>:6S@[?b@X(gaZ&_<C1V=E)-(\[>QAOfS\T\g9_gcd?f]>fLYF<CYI
Y=ZP];>U?Y1:/F0BLO]8(YgC>@/ddXOMG_-gNQ]?:_<96b[B#+#F4XSA[U/PXMFT
NX/1edc51@79IJT\,D(a#SO)3SF.C2G1<3aG-C.6d274&^<20@b,?6\)F:V@<TI:
d><GJB&W&2+&5gZ.A)aBA18&3T4+4f21ONVbC9@Xe/Y1K6.C9],.N&-PcZ=3CA@M
KF/:S+g2]GL8+O9GUNR]NdB^M?_DIPaNa8+[2XJfV1WN#d4?@(VAS-</-8KJ8-U:
CI:CddO1MMD-D=-CO2&<fcAad626,M3F64a@e[I96\3fFHN+0YI#-3A?=MPW.D_)
61e&6P#DJSRKOf6L;P9C9\,:AMBD_EJ>?9M6NL;C>5.:B8H429df69QB^ad8FHQ,
4,]P5@E0#//EaYT\98+/K_WBXM0dLV+K9&D?O#NCQ;FUKT].4N01N[8GP1Pd=Q6Y
#O(8K)U9]J.]Z,:g>VX9A)-I=1[Q6BLeA+5/g0+&=;3T;^HEHeW=BQ5YV<//)HDY
_CaYKL5WIJ3^U+]#)8>LPgA2>,L55N,BDWP=CGS4+37Q73eg57L8Z\IbM;X(>D29
/2.L#CD)ZQ9BP/8Xa&d+,P1TfJ;;bL;TU+G8>&G[=2VIM_2T691M##;DZ1#HG+cY
J(eP=?.[@eI5P#VQ1Y,P7MPE=.-S;>;T(F9#CETdb+&5+7d0K9\SS,[JC;SfK@92
f-:KP]eQ@[NB:\=R.NGAW#^=D0Q6YC<(_BUP1<g7ebL^/@3T>QU,<F+F:<V+OfJ/
59Ue>FTWQ2PM.3A;GVIFVbd<:VNFIFg^b=e-MEF>^Cg/gQ+?SeIg7^7&A43QBaaV
&5f]5TWX]M)d@=&f4761K\C&WebaDF;>O,D;L(LBKZMHBV?P97)/T(#+b??ITI5;
H08EXN\@-0(6Y<fQ+c>W]XN>_]b?AWRJ>\G]@CG=WCCX;NDS5gJ/V:R6XgT/ebM]
H[:.H-;(I+B21U<L-2:RBS]58-F\RVfc9[EDRYCe#aN<(d9SF2\A=:?DCWTJPTQM
=d0.V,WZ</3M<JH6Ge^9@G&BQ0<8KMg;Z2f?&M8OM+7W:Jb=KFHKU+P1Xc;X3-#<
-:L,1NN4Q=BJAXG/+45Ke<<aR:aR;>aK+G)6M;IZ,-D+N]gH6F<4^,d6#^0.c/YV
f^K98J>Ofa3E=aX)G[^0O;S0CI_.cGXK.M+16=N46Y?MJ0DZLB@U0AY_D,MBREL=
K+gDeLYD>=Wf,WdBRZM(0?HZRf_1eQ\FLfDU0-__MR0LO9<eNS&HF.(4Q..:6UC&
EJSH.<TML-PSY+F&O,Gb&bLM][8]CPG]F][_8W2UJ/-8eY=IJ/#&Y//2RHUQ.d83
#LcCBGSX>:(3b)d(D?-g3O<&TWGJ1Q>^RQDVKHcgTM1+R5d-O:SB@cV-FPDbd#VH
.?IUcHRC0O0I;9-Ff&dK2_(&II1;X8W23/VTcPVgecA9CeQ<;LR7JHW&[:EbBYO<
,SUdK2[dOEDXgZE==O&VJ-XLPPE;I.NC;6=@^e;&3GeV.1XLH.fSQAOP\WOP2(dR
;GTBVW#O,I/>Mc9BII1(-NU<)LB_JE_-Nbg2eU#6B2B>2</Q,8I9CJWKOY:\;/_@
6R8JFW-G8\F74QCQLd<&K2/DfZa2e3_64ZWd3,+;S3XaY]<)+DF4eGFcQDI,e/;_
Z[ZMP0YJ,FW24QaSYdg0ZdVT2U6T4&:97Q&L-7KN;()U52CTA^.@]KN#I;ef)\IO
)+M^;+[N#4bcZIHa_IMY#R/B6Z+XU^(YM+=FggdIRCL)@(0gCOaF<cT;.AFVSO2F
SAM\CVSc0(R>=R4U4O;WfGbe9caH)>.WPC@_@Q#IXb&PcC).&QZf];.bNe8[6J3a
[I)H_1:]-KcH:FQ<<@OJMB=4-FZ9^);3>;&HH/B8J6/@(XgK6H#QJTTVW^@L^NZL
bS]YCbA-I@bX50RTJ.I)4(C/bYQ./d]&YI[g=ZeJE5O2d@ICF>;6-S6JFVU6>D]?
R,FT1?+2Q/_A,HB:K4bCL@K,I?JEE4]ELb=S6&:93JN4Q_E7S&:2>-6f#.;ZNb/V
&QM@<Y[/cI5?L,\?g[3ZfeR94]1?_,@OCdFYR-_8J,1SI+Ca/:Q?#-J7FRQ>/V2?
J(.PT0R3fKL^BNDNc^9D20;VU,-_+aEQ:;c.cGcOKURQNYd8dQM7.O=_UFXPPNOE
)+B:QFWF\-Z#J_=..K73bP9U-g[QPRbKe#CPbeaF)HT=g7.VGe/=a^B[^-E8C@4<
[I4cGIL1F1c7a(gBX2,dNO@>6ScD=fB.PIf7CN^\O.Y83g=B7eL[OPKD>)9<O&D2
4#X8GQd[LO69d?[Ma@V9<b)d\WQ+.2AZ_5V#4HFV4KZUV\[\&b4d.00_K_K0^4BF
K8VA3R@;FNU8_BWAV&Z6R);F0]:;:KabQ\-YY?6La9.b.G<95\]L+OfI9Kc07eVA
;XWF3YJ=[.66VO:XNVG.B6#f@_aA.BIG;71Q2Yg9@(OBa&K70eP;]&g<=&)J:b-P
021O;Y]Z]#b)>IT8Jg_)19aGfHFB32Tc76Q9_Q+284PUdD)HNCGTT,8?d&YV<\8>
Ad,[cQ3#QG@HKWO55_-IeC-d5_[C,Q^\)Z_1V/&Vb)+]U42IUYaTF0\P5YJZ=Ke6
C#QTF_eOJ7L)Pd^T=41Y,-(S>5I,8JC);(71]RU21&Y/:T?68?QXA,E.)RD6+E)-
7&\4c^0&HR=6]QXHL\6#U0NN-@W&CM3\.IQ?=g<W_a5eHT>R8[2)5?4]FL:=Za^_
5VE)8K+U[=@(6W60B:CI_FLba+\H+M2[JTb<P?Y=93eZ.,@G;09?,Y+C7VHHVP/1
c]KYAJ=Ze;6FNZS?&Z@M6+Te3)&EHE^^W6]-U.J>X]2K&GY&D3U,8O^EYLE9C:g,
#,6EPXV@^C__Hacg&e4PNS<3C8P=c#e5CI;8^)-.)O;/&IcV7A1f1UZFAa1AN_DD
(DU@VYSgg2G5d5AQBF[AdNeURH172Ge)b0P17#fbd7,&c<)d.&44<5.:X6UY(J_a
D+[Wf;^+8O.1D2KF6[aQQA9A7e_A.3?.2D/5P3BA1Jc5eQ,8T-,7[[&]2YR->,-2
X+CMR3fN_K7@Z5-,gMd0QbCXV#)75=#e71^=35-M\3NV3fX>=L8Z@9?+BPT3@N<9
[K<[L.1U;15/S1CdL&5^bVZ3+#cCd/;^G(-GDXad7VXaJGc,8&2+1EE[EB.//gOE
e#><]@/-=3>50WcfN8#XR&P_S=1&ae):T3d=A.@NUAFLf^eDcf]Y5D:EF]LgbC?4
<^AK^_4gJ>?4-49[U8\2(>LUaMKUNKaLT8>NcK)O]H4)>>K]M;LKT@CRaHf_9S-E
602(da((K?)&<F=e<7Q2Ac@I(DLXFe/d\&,8(7P_Kgd]PC-VM-Q+Y5.6.T21(N-R
&:g4J=:/(Ug?A4aK/]]APdM)V\UI^a8^J(H/4N@:aXJ\G(+D:QM9SI(=\=#<6X];
KOZO^(<+F3:/)U:HeU<M7b-B=46d&eXOIaQVJL/VM=Wc:VR3N8U;?QE]9BW<@e)Z
7][Q8-=;V=&#<WSe1A+<fY6M^/F]G2eb5>=6JA4_V^,RJdWYB1egJW<ANf5[LGf+
/=?S(>YZIWS<QXQBJ.]LJ_/(40N<ce?#\,(^cXL=DgTL2WQ4e6bR4dfeYJLR@8Xa
V(T7Bb;1^N<d&2;K)d@?>M(=P;0_]L1]9AM)c?8@^X[H.J_=,M\8.EGD&Z\0;_dU
@ZZ,M;4GbI\O-#1VZ6DHN\bcDGa9PYXI&c0-RB4G)Z(:[+SaEH(+5>XW5<e(_GJ:
DYag_6>UabLfe/JTVb#S)2e>fNdCCS_V&&Z?K=GH>f7=KPe>S@GYB#<9I(#M:VTL
5bW_0R]X+\GSgQZAL21(4&:G<+dI?TBb?5TI&M<-\Ug?S30C.deJKg.94(.R9AO<
:Q)E-b_NH_16RRU4A?I5fUOH8fY&?9Z?QgVK0-U._JMCagTV;E1WbP9;SES05@A:
D95VX/MFS.;7I2F4\.8Kd15FC;cZ4?P[WaS(W(+0IU3R<;DPZ,L=.fII)=C]&4fP
ZRE)]&F9&PaV78,,S]-AR.?(BY]BNaB:fHJb<TY:W6ZS+LS#\b)d)#?U9CNJ?X_-
<Ig2A9d@J#[IPBT6e.V1YK9.Wg0GDaU&RfI?-C_G;0L65Ib+TL<aNHBe59[RSYbD
M+-\NaW[A,F_N/1T=01+2&Ee<<a?ZUaCQ3Db7YGeaS7_2UCdb>NQ&[Q9TZa]E-&S
P/f=eR:SLJSIN8;J3#VHa?)+-6CgX#-Y7EgNGA7ddAd5b&WET:2b=a-APUF-<3aG
HQGBf@aQ2,>TLXZ^P:;]V3VT@E)Q&3BJKS4:X02Yaba&H;68HX>&_;@80]STUI\(
S@/Q[CCd:P7F\FaB;F:ZgG;;KU52]D;J9537VM9BWQU/YF(K,LH.H.Qb(1SDED#Q
C/1#Rd;?(.0ZVV\cTa?W#fE6Ia:?\E^4B]dNWKQgPVQWTG;a89#BN4J>:DAJcQT=
#2-O-8XEVG0QgV^d8;00\+[:OC/&GKO3d6[B@;+/=#1=E46N,V>Uf.75c_(:L.D>
aYEW\[IH/\6&;I>S[#917(#J\0<:SK](\@CE?4BUIcPQ-5(Y9[SOJ#3K3L3R^H14
(>Ye(#-H6.b7Fff]#I,Kg>4W#WZ,I=+>bg=/FFH9+T_BJN4EH?R7W>7:41]9B@J=
b_[M4BJSFa/b@9X-EX.9.ZUH;I:X_Ze77J55P:cV8K\aDCZ8[.;&.-#1#2FYZ\J&
A7AE1ML1+0UJS=:;BB(X&KQ:e;O#2faS4?9<D66UL5RN/[(D4S6BA@&#b):3S.X_
Xb?:bA0/PUS-d:2R(?DO8JV^A1bF(b@OQadNA88T=6SJ7T\_4bWgZ<,-_:.\6<c-
L.-9N9ARb#d>NG^Q_?]C<3]74-VRg(:fE570[5[=&](TZRMQ2Y.OSV5XOd.84/EM
@S3(5HV?SbQebLgfVJV-WVG9g=C;6I]E>_c?NeWbJCUdObf<M50IKXJ=\K(KfM#W
-4RLd0UQO1,&8R+6FDDHFbBG=2T(8_X^SW\//^HL#cWfSaQF50Y7837TI:4A=a6A
3H@<NW)3<GAC]L1/8=<Ia)W]ALO)WBF]N.>B,@V+4a&9>5;3>3W97;,4\f;b^UGQ
d8Db&cKc29@F(+1[5&f)&65[[fJe+]>aL3L)cDQAME:6O2cg2&A;+L_YKRU9aX0<
LU&\(PS/GdPOX#O[+^.A#Q3B14aJQ),XWG(X@J\E)A.8@>#.ZA/F,DB-ITC\P?f-
(f2D(^6&9(g5f+H@f>bE])Xe,4X,^HIa486TS_b0VGLd/b<NX6_dQ[@29Uf)I&^f
L3&A:]#-<:JU;MZ6M=JG8ea[2.9ZNbEb/f3[9C#@R5[08=M/Q<Z0=W;IF;;6A(B3
NPI7CHN^)YKVOa#WVdY2BSbd,BU69>)EcL+1eFG:<<XN8T@OCdf7WMd83HZ.(FX?
D7fGXb3egF:[O>RI@FL)>(8\(_1<c8aP,9^KfH1AQdBBA2LIeaRBT<T#KDeEAE-W
HG+b5CA8Xe.HU8Z8GcII2>QNeY>77G@)8LX@DH4a)a8&a2HSd-S_K#UJHS.8YQTf
6_+?<<cdO-E=A]L8:>)_LQSP]\XdOCI.M#KYf)fWPUIS.MbZAbgOaXH5;=^W\<cW
HM6(LUJ&GTP&K6-DI=B2(2S;MXSLP0QW]VcA#&>Na1@C,fYHbf6+O[ZD;-HUMXH6
Ocg&D6KaTJ_G2^C4F5?a=(d\5/O@-g\O#>]^f_>LcODX.YPd:+OS6W8EQPZUS0^9
/3)YK@#.bf=8g;P.e6f]>>2+)dOQ5OJPe7Y]9.(9#3BGg;]LO6EUF6.S@#1\dB-D
4PD-3MC\Y+#XL<3Q1@]HX5=0bU9@QPIL7c5Hc?;?PIVL:DVa>1Q[_Q9Jg@?aL=M^
32:]SUVCN\G5?AFWPD-[7#YV^9Y4A9DK=a,F^<WR.O,,KCV4^Z(3-\D/V#E1QKe_
bQ,=4(,Y,C<?g09U+X]^;e?5T(4fX#QP0]<d9A^7?\g1(B41&D2P4B3]NKMe5ARg
&Y#R11P[g>8]JcPX^&O[9,e7E?2-_OeKP?D:E@AP[X&T3H6E-/6^-[eD#c);])(;
/=_4=[WOM@cNJ7=_O:\c;#Q2=P[gK69GKAF8EI(b&,F(6QJC_3<W3TfHK4<RCYT9
@+fAL5Sf>I/SAR,O)<:#_ORO-&@Za#9B.BZ1=1Y5R6YT6F=;X076SNfXBLWJBVKE
KO((:XD(fc<A:XG8D9^<9404]/,4:ADEP3^?M^F73]>H<Tf7b2^Q/=\PM8NHbB&7
DBCDS8S\/70e:T)>@KaUJ1IJ?T&Y0a(^6g_>WR?Y(2B/QJWgHX<aM;fgS5]O#TKP
VcBEf^b29^5<UgR^E,KD0\.(V[K[8@@8La_9O2WUGQ:=@?[,,_42^GGc3SX\,?d@
RWX(13gJX2dZg_DV7=><R&KBDYG,N==U&4Z5eX@-PE5R95V]+95B.a/a]AIgOc>9
P)@X7D&&4XA9H^LM@gAYZ1]K8E4K,\78KE2OSCZc^gK0OPSO/?AJ,;[J>#.O)QE0
dU-22&+K-/19g&W#,F5NU<2H^CU_9@g7TZO(/K?[^eMV&+D8V[:CBQ4OHEVC9[[4
b.1,J^R<]aZ2M88OTHR.NQI3g\G/F\0)AI88fe1PL:gGA:b<YCC4ETaAZFR?B?Qe
536#>g^FP,fKNCL?CH5L70U_,;_ONJB?K5KL:VNa/+&Z(PZ7&1<&bL:@K.@@,G(Q
@+#OI9WG5?M6\9EcI@FO4a[VM:gcBBG#dPZM[7,LK_\HXa78ZM93UGF]@6LUD^W#
2dg<5JaS1>aD___1+dSUXC_1OLJD6#)b7.AG1+5=C:E0g0F+?DfE=SSQIXA_2.0<
P1-/(:\5V?=U?<R8Ad<3a\R5;13:;,A=52O_6/]D0YFMZ1;.H8KSZ_dHbIf#/J:^
4HS[EVJ-N9D09T/X2\ZSOV_c/I/&23\#g.PE;9J#(^IE1?))2eH.K(GUd4-8Z,9)
YbIXg3LcO(ea>&>N0,BB@SGC[=;\=W,:HXHZ8SV-;e;BP85bCcb2S>YF0eC6MWW#
b-+f60EEO(5FG&Kc^HPT1\>A6.;3,)O:-S+O(N;N?<5R4Hf45@T;/V[:1dPD8G(#
a<SWeBa;&LFOHg2Xf-;dfQ\LV(Ib82WUS6c/6E@KKZ6/eW>.HML[:B>2CKgPeN@.
2E3IKR]F)X5M<>)1#@W8<Q34NE70X1457^/Sd4?bWD,L/5\Y2D:E@a+.P^4b=],1
E)Hf#A,FcXaMPN(gWB/;^MMBfZK</7.5XFF2)=N:f\-<eK?D.QWbXQZ7:2G[.Yf#
d;<LUW_;V6#f9J8Bf20-QHZ33UUTff:fQ3I(43CL.CND7b)ObPdBd(Ueb]87d[[2
3Z(/.9Z>2<K>(#(+/VUadF82UUe1P,fFE3E5R>Yf>C.7,b\M&JH)+4OfSeI]:84M
P[6EgTHd;F>TP\>MNRI6_baXRGC+&++T<HQW1YIdPSY[H5f[)c#fWR)PEdOI@\/Z
B<gVI<><e4BgaI23/fV)1(A01=K^&T]TP(J3Y]Lc;gQS/U3S+dM<(QeV0C4@>>79
S[0+ZLP\VB,NQ)<U2.?WRU)]YI-HPX[N;X3>[=#M+1QXNbL#^U\PN<(cJ7/W#YWO
?J5T.XZbK:.WTEKTH=Za[^Pc-G9XJe;7^_PH3\8_ND35NGQNeGG&N;-2-d9=K5bK
@V6?;A;?I)2d>^G06?Y#JC]G4ISgN.NJ2R)]UfV1B2fS^6_R0_WOYPDPHU;9[=D/
OaF2LL6Y>]-UD+_BK.F9ACLH5)GJ4fg#0gdQbL3PLV:-=3QP:J&,].#=/+,-7FP_
AQ#8OA[_#I4R5N-@K[H_&MCFcA:JdYW<+6E4D=#=SVV&Wg/UcP8O5<7E.LX(.[/;
&NF<_XZ3a9K5&2+]V+J4CG;8/2ZbRCK7a^GG@e)93I-/JI+ZRNIBBMC]FR.W4QE0
aQ:#OIFd?a,_Ce=U@aW@P<fPLBA>V).:F_2HOA8IJWIDX:\gMR&DM&-O\J4K]\YN
a8\E[NA:d^+>?@Z)cG(4g,W-#f.\UH[175aB>H\K>#aLe.A0B8cO@1\bb9NBT<7Q
0HM\@@dJISR+dF\UObQZK8Cd3(F?:;.>]?H=16(_.B=94G.<07Q(QSWA][<DN[/0
Z@fG(KM)U\9PaY<aLfMPIZWAQ2H<.+,X(bAWcaHD-N2F?-aV+g#6VV)BA_0gbb=M
A;2e4Ce8^R#[>N;K#UP\TD(61Ja#RTIcHL?>g_G2O\5/Q)IS\OGH3bgT52PHK?8O
b\\eE\HX50^gf+TgQf-J2NN>.IS:1(^YCfJ8)XP^_.]6EaYP)3bI#9e@7@ZcVc,D
,QR&MB],X#fO[OOMDS)40;_f<>UA4Z<<a#,1D21-HH0GgXM78[VM4g=ULgf+Z)UG
Rc2KJ)HPH/N9g[Bc6ATfGTQG+W/3(KD&G1=+J2155_1a.I.>9V&fAFDW&KT+(f2:
N[=gAJdbSb>62N:7\H[gK7EUQ@RVUZ<6RH3JR]6PAaE[eIA4?6?VZM7VRU4GgEgL
9;F1=eGQ8H.8f6JJ.J\Pb(Tc;e&&R#CR5HRC&e,gK6D>e@CfAC.8=5_G9Y\D?S5]
?7O3YD=Q=1?0&c@e=gg7E#]Q/[.L[\6V3]=/JYP#W1<N2.L72QN^=/J;.cPV1:+(
SG]DO+HK_IUFFCZ[SLaV?1^&Sd?EeF+A=&QME1=2=OZTI[^=]6:(3+5bRe\GO2FA
]8-,T6L?fP1^gA;)KK23#C_;;XMf@0DP&)e&8cW<>b,>,M4H4I=U?X=aY.QHU1?E
ANE05W>H3OML\e,)\.+CP[G:YW(8ggeA[FPe2_ZH5JXeKJZEP+(V66Vd^KJ8Y3<e
-^#(ME?V.a(b0-?(:9+S5GRF422CQ03KU5:eH-0g3ENbPT=-&T\GT?QI64;#6dHK
E^3(7]XXXGZ?4U4OH[\(L.5-NYP[?<[:I(fQFZ5BAK9>a0;?O<-O2Y7gT.R^S:bX
3)(_F^?F)G0g:fU@#0X5WL)aJ.3Fc2:5df)Oag1M8&HG^AY:Wa#1CUfaZD[_0d1K
:ca0eS&-)PG^@CZN)B5(=1F5JA=Bd2\Dd>K_9;c3#bD4B/@#gaJ6_^0+[(QYU>=1
eVO4973DV\;HGGP-A#7R^abC5TWLV:H2bRZF^O^UVYM-4a?Je93I]efd_;YVYLdV
LgL58Q59c6L2@QVEXMNd.);Tcgd@Q1[OeEG:=A3E]a;B,e>HL2f(/X\NbBI>&IJO
64R1U,_+F/N,@BRY=6agXF6>7:\\YU40>:4MAO[-Va42VLR)RQ#V+^<LI^[Q&KL\
D<DY,7S,WZDf2WFR-CP.#+5+MO,3g_8T(8ERb^.:E+WNU)QU[Ta=1XP_7TR(8cK#
,WTFSDJDc52>^B-P;a@Mf/J0>+f\d]eORcW7EJ2eG-@UF#gbBSN12Ja5J+E&Gd&d
6cWP#PWU?WW1fQeX(EVZ9+.3+IMb7JQ472>6IXDQT[EdA2](-dL?eaLR)^)T1F]3
:.B;.O\G#=7.cM:bY?+Y?_H-ZS7OW=/,F3^)DG^dR7;@X_564Jb[0:AF7]MJ#=]W
LAYZ2d-BAXNRBf[W-,9,DV<dQU(\N8R8S1PR4eA_>5@A=\8DgPfXbeWR?)98)aC)
Wd#eTNN7b8Z4McQ1RY3Yb\gF))YV1HH.F6f+<\)Y2.+,4A#:<:_OTI&--9_<[//-
ZT5McCecL4f2\ULJMZWNa8UD#4e&\;dd^fg_3<>[H(R=f#MHbXf6fW><;f:0/?af
ZGBe>)4<L@:.Wae.O,ePB78P]D9NRfbF1<GQTLA],Ig4UE.H@=D+bP-KDWS@AA&&
c4/,.d7c+>+C[\&H[aY0JWG_egV_,Y[R+<?B?MD>EO.SOVTg@>I1^FCdHUS4TR3;
HUcL8:IP=C4&aO^2e0g0Oa<S-+QBC22<B-fY1>EJ&.7W<K-#L;+a-P:1V/?J,Ic+
?Bf=]219PeLUP)Ve5IFAZ+[+J=I<6)OJ195/E>_T>\d7+<7Df[Y:2-@aaDLX\)97
UaaGZ4c/O9NYF_-B0/W32<=RABL>6PgR;G>Rg^I.V0b/&/KBb<M8TO@8F&]eW@]f
8&,^;LM:OIaLWO72K:_^;<=5Ia,0RDM5)aUAfPFTae<L@fdB.U1TO_[&>_c>G\^/
;2KVG#@?>YR/O:)fbMW9?#D[FF[>42&f?\#dHf@V\XQAFa,,X84P[5)LV&ZD9/Sa
DPSZF1@16W7ae,:Q-fXL8/MKgZg[B)bFH23OO[?Y]0_X,FT;7cAJT0-9GUYOUUGC
,SJN218Z;#>JfL^IVeJE^F^N?d8=/:AJKG?(CZDY86[(&FB94#]eN2Fd/&]+4-X3
UL9+.:=[WL5aR7E_&KcANfaN#/UC,Pc#NaMIR4QdRD6S@=IR_SNCH/6XMKd5[H[,
]ULQ4?3>^?RNPMY6RGMLEP6KW_+AALTS_8dNPA(Q:DA/S&_]SOM=;a==>:@^H<bM
d[9#VcQNJ5O=FgIHeA56Bd?ccEV7=W.R5N\L?Z:<)4YJAG1TNAP16[^11VdH=M7+
-=>V[.\2+(J>Gacaga/Lb?[^C2:dg;+0DI@VeU=e=@/<3D5d+>DBeE)YN]g<:^W;
gN?+U-9Y&SfQ#)Mb_:[-?g>WHAdJQP#)W>g3Ue0_7gGC\aJa3DOLg)^Y]EE48]6Q
>aO2A9@O=@C15PKU@U]#4JeH&.#9=9TPgKP_;eBVQA/9NcUS9[EE[(cJ7LTLK<5/
bMTg.I(4A>@H?2,F05F-UG.<g>-L0./_(9DbAAH9f6(Y]J6_/=,(GH-@A,K[g=Ha
EVV:HW9OZ8ASMM,3P(2B<#42MEPO;SQL5Y;Ta=.8g1fgCPEYY9T9K9.)>K(_L9L_
FBJD4JO<#@,d)G387f+/+9GW#MARIMgN][3M^_T;\WVTC@\M]VIS/NA>U?PIFP@&
Z]V\-;Q3e5#:9JZ9NLY&.5.dSD/20/a?Y6</+2[[1ObKM?:L-1GOe>QCgYV82XG;
;42PG1\?\aS3MT+I2QdgG\<MJ1F<OG\:)&N6eZBTO1;6.CD^:DTBI>S,T;ePL-O^
IY3=_?15TDI+-)7QJMY5JWd_2.=d<.4[dXR0e>V1gZ6)U0M^-\-9>\X4SZJN\0,d
>VPDWbTCGYe=.--,VM,((G8<E.?1B<e#4=2Q[TPSH<]8_PQSAN](IH/&RUPgEE@I
F91\V]._UY&#M9bKd5/G869R&OQQQII/-),SZ(\&P;[)6(=R12<5<8A;:MJ[g9\e
9BEg>=G<=6d@>?2A9[YP?=e7:egV<XYdc6g);E74)XYA(X6,>)b#d<L[\]DfB69e
\9,175X)JBZ[WN51b8F[^SWZ5?[Rdb=;gW/R69B3/E)>?8fF>&;FK+#/d9V]8IX:
J3X8B,.,^f&:8gQf+OP&\&)FT<C3OC@D8Xe_<;^[5EOG/O?L&F6f(NV,=/ACf3PY
aG<CW^QZ=@BIBU[K6Qd?ARCLEPOIN=](+M>J)T)^fV7d8&Qefc/>J>0G+7VHZ+J^
\I2_#W+e?]T(L1APG[1A5AI2RD0V8@/6?,4YE,0XDXGK/\H,966@bKbAfK:C,^<;
E@L+SJQM/0:GZfF-,gEA;.PKd#JP\ECc=CE8&J</VJR6IfWWdS7RdGPHM)@,P\Fd
YHF+>;g:D:d#JfbLQRZ^&?F,a2;FPJHF:#eO+O?+G8f?Q+#;QK7),-YQ&+@Y((b3
QdX_)[8LAT@A40I\S^EG:/-V;)<#PS<d;NKO:7YTG(&43d<b03AN>Mfa^93?4YX<
NDWe0ZPS[a73Ub3QY<(E7R<Q8Xa/1#>]#F0^R@g?IDXB2=N34dFA:f,O01MA@1GI
,\=GI@]53aF&Yd((I1bE)T)cS/0L]OTF7^a#[]8:2a(/QD6&=QJ&/->d,3ZR]ZHZ
+7PPK(A1(L;0FV8])6_X@Y=#84//4DBMVHW1604(g\TAg\WT(6VXUe#+<VfUa.ME
NWRZP/.M\U.;CfKIF^M<9.=6H8SZ4G/CXG3RU(OSIOb&GV,D[Zd/VJ+(QHYBVaK/
J58+ERPPDTcf9)];Ff:R4Q1IB2#5,E@6>6d5=_Q\AH]A>;9R5cI0=^JL1<Z?=[WN
>B#Hc&P0NH/I2_YcYSaC,^/3LOfb]6<T;5DGKI/3V@aP03ZB9N)a@Y034--GR3bg
0F8XRL/d/W>V84?8ZF=>X=@O?L\;6V6>b58E[W\]>&.a@eO0_5\ZH7UX^XPF6^2A
NN<f1#Qe^,N+GI8+^9UT^35bC=<]N_PT+.DBBDaQNLPR21TfI4b<cWA,I?c^b_b;
aN#&X(:J:3OfI__L5=+P,:3LYd7?(ddQbLJ0+F_:3_T7AU(WPdI2FH0+XIKG@?JU
Z0e]YU=c(@1\3ND6f7gH;+g/7,-S&(B-SKDJEY4eB:--f_YLg;PVT[2OI\J=0aX1
(ARX6&;UZ>dG<-&=,[[1(KF\,d#^Ee4UR-N)@c3aFPSL(5A;([3cd9_eHTU(#ecS
KTCT1:-_KccC&P_S+.OO,DU,<0)VFVE^5eS-F&SbFM?[U3?M]._+=JOP<3>CH^dL
\&?H@DECbTP4@H\1]45R@C8QB6N+#BSA.76OBcd\ZQV=fg>4;Ja+^c>6@[HXAIR&
=g/4]@+BRb.,Y;B?)6-6:CfVfPQ0+T_>;A[F7[3)&O;EDRRLXE[5F?gW(AH][6)F
0JQ&U]d?@MQ^LL82+XXDFXaT<CQ,.-ABc67[C\@:[.L0=>[3AgEf,,<#LADJ3HdI
[PgASOI/C\S/=Y7JL&746g+GAIV_eL.710_BM52f<.:SS.HdT_NJN:<5YL;cMe[A
4eF<C=ANHNTG_=B4?Z&/4cNY3XUb:<YG:7@OLDG5H=9>.]KEZB[<a8]S8ANF2a6U
R--(B<#IAdM0g1:B=&dd3F=F75OGS66f-_5W\SaY?>1_B^MN1_JaC[LFeKZ5Jf)F
=^F6^H+6@g;f5AH.\WD_OAP_[A?KU/]/d]4bXAC6EbO-CM:6^G1NWR[OYb3Y+X;^
YdQ;9U]a<=4;O:HPS+0N<fRL9\XSB2PX.9-0(_I=:a)64L]a74c#,^f=G#RNfQ3e
d_geBK-Wa[[YJX83KPN]CgF(VYX#GI4#Pec5[@93RA@eDMY@UJaHFWP[S>#Hc-57
>8U;;MQL84#3ZLCf.Rd7:#WK3^+X4UVMg+A8faZ<;JQ#Cf9Be]23a,<[E-aBSLT8
?4-Y\I?_++G+BUCWKdVb)aU>:,RDEgY+Z&2d^e\fT?+4XZ:H.8#MXN>B0Ge&CN8W
F>87VE7Yg4:=235Fc1Kd\K4<RX8L3BHb)U;OPLc?_K#(5O<63EPbD^--0aTL2UWJ
)=U+d=<0]PgeW]c<TP+a=/A?E1g[S-g3LMeI?AbDCW9PgJ0PAM/J+O6B0EI.E@_+
X&N8/N59A?O1A]B<V2_YEI:P_d-_=8[[3&L^N=6T=X&K+X0&G]ABe.BF]J9B\2,T
cW3\?HY8bFWg>:J@1:aP5=-<NY6^F6TC9P/@\FcH]4)@C]2PYPL1QTdSI(;+-f\^
fKJ]c?>3P9CeR2OFKZ85>=c:ZK,YPXY/e]MF-DVWgbM(fDd[/7gbBX?Q:\[9GFcT
.F=SQ/I0X_e[[7N4_.aP\#9S]#6FH+.1O.SR6YDE)D#6/0H<=Od\(>/+bW\VJGU/
8g[]\N7.MS@P_b\-C&4<PaV/F7aK<LGHe_AdBC\Y5.M):?.],2aQH0Dg?@(+RC_2
J-BE#M4YC1I^4--9BCa>Y3<\.OO2a_W.PdFc94#=_RGZ3BYJQ=bdF)/(f06R[UT5
?0R0McG/,g/Od67>?#[.):B-fB@7R.8d=Mg.e\=H5C/)9&NgA7LJ:I?Wa0W4L,2C
>1_YPe@a,U?Z&BG[P(LU\2;5E53JJW/9K8g45Sb>BA0->4Z4@Gbb8\9X:5J_d3JR
Cfe6SDE2dfe,O=LS?@PSe^I&/\V13D^5TcHTQ_YJ>+)K;D1:=FK6TY/LdD(XFHEL
g_X+69b0Z28L60A>P[Q/0(MI2g,U2D-9N]Z7bG@5J&?6SK);Tg,.gU6X3<G7O3K/
e<);DYaGf0&2H/\,L8)UJ>7,QM&g]V7-B=9X-Re44Y6O\\bc.Z[KGV>A./Ug>I4E
92NfN[WX]OB];:@E#V18^3HHI_@8b/XBSe<BPE-#^KH-H;BDK?5EQUKI7JUU32R#
A?K>1@&6d,\SNY0Xd.DD2>K-3C9?JXZWWW0N][D70:(g/FVG2UB2I\F?V&?gN_NI
c\PN)@CdYK.8XF?0IQ3[;/bIT#=X^<1TcYT?g#F[IX.--5J-9IF>&c\D,D<_/4SQ
)f?).U/J89c&I=b\6KfB3Le(IERMG3(2-FR<C\V,N&:P++R;+feWC)DF>bVT;MI_
KG+1G.?Y5T@OA7MVW@,L/6cfL;K/&(eMe?e(VKOODQ4SY45cBJOK7/f-RQVWGZ[\
7@)0@N(8UX8P<(#2T[04d_&S9I)+7MDE_&ORV?)YVRZ&TT)#YZ6RM]bcC,SOE:gQ
;LV6e/H]];Q)fYJ,>c29@-aYG&/OMSbQd(C/=Za.W;#+N(/G):LLLHG(]4TJXKI<
/8-TH3NP+D4@:X3LN[62(Bba^N#X^:-]NcSZ?(&RbAIQI?B\LEQg>.75W:5FfZ<9
E9M;?6\eI1.=-WZN4:#YA:_1agS[5e4)C6HC,8>=3QeEd=JY5N/C6TCB<)bI.AT@
Dd7gLdF-8F8+FWR.\PHS;7&SBU=31f^..?<RWaX-6b=^WYbL).dPD5R-\:J;;,3P
H<1fUeNYIJ>aX[H5/1]3Ab(4?2+;DAI(H0@&V\?C37J(Ng;2ENTK5Hg4?@V9]I6O
QA(;5[;4[a<3GWA36AS3b+S2+B@PNSaXHW+,SK1:dI9>3.C8bG;J9eB9)/^W0F;X
AI&LG1FDZ?LG2+;.B+6G1S]4J8fYZ.PQ-f\KXM_6)Zc?;(45(;)++cd7e+K?^9^.
G?)T)F^=dT4H#N?2((YaS5\.cM6X+^?[X]&@+c&e8a?](_;0MF9M>P:e@Q<JB?Jb
VD5:D58FLMP[8C3WW-AG5c_NS:,B[O8cNf801GNQNIXg?0Uf\]-c(4f03U4f1SUH
U8_>3KLe&+dV;F67<\=.d634SC3S/fbMMC<Z/>4FPBMCL@RFE/IDUQ3:EA^N/=^[
]dE[_9T<KESR2e?0XNcfQJf[+89L_,UT7U[[^RD9R<0QdZ(/SSJEM?T03\OTBY&J
M/D)+1JIaWa:-;UD_PSc?gcKE]22Q35Kfb#<#^<PMBg-fQ2C2e=<R=T9#YK6F1QY
T9H5fL.7^3</JZcJ6AJFMELNK?)4d,]eH[;2R;/(ZVD7gb97>0B_F#6)6,L^C1ZN
6.#gCQ?=AUJJZE-cMc-CI-&dcPa=<gPV7AR-;K4MKL>SbZ6\P:2HVE##]_Y@+:R\
;9Z\VVSI(V9MKH3.c0RdRFOcD(dHKM76g-@B/K.5E0+I-(?dO6b,XdMd9PE^OX?(
)ed.VQeWd4O(2gdO:[5ee@KK4EJ911C(YZ&F>O&B?S#)72A#,B)H3=\J>4X)?(([
aW5QfND8_3S^\99;f@eTTYK+g9-Id^35&BWTD;ZDH;TK:E/;DY+DN:&Kb8C;+Xb-
T\Ma9f:dKE\EZD>RdVIE(BTPAD=W/c@HFG@0=N)>Q\->V;489d3)>)]L<b:EZZ1/
8G>^(;A:1&2UH(1g(1[Z55IP38F#,XPH,Hde(SF>WEQRAB3M]B/8_O3b/?Bd&0BY
;8:15Y44B\4Z5E]F\>[2Q4/Z1?fSK:(>S7@a(b9CV.aCK5Y_@+Z:>Ab=a;dJ^c(#
Q_L^)+U7L5M_EC?2Mg/HPeHP^H>]Ec[dSS_8)G+\7ZWXLd>BeJ9-QPcK>DW#a?g;
4D:P>?8I:&IgGWO)#eFg8LSTR0WI0NHJJ0[eF-85&\&=7ZF=#LQ_U<bO(c57D/GS
)@MJB5SXYO-Td0cgY.gM+^DQ5V_#5]G3Xg[\WbS>c0WUa(\EDNM4/E:=1G.Q5LYW
P0aLB9+.0ZYgZLdgb(JE4;;S@T54KfYP(?_Db6-c+^=.TR[GWED^AQPQTce+U<V;
>IHO>I_RTdLd]>0W\Oe4#AD(2Q7PA7M28N>A4aS[)B&N@aT#=5dUO)HLf4AHVS#&
aGb?D[)DaH<7RHXRJXKIX\)-&Z&6UNXKa.>C8gB_^=EaVM:_ZIF?C6E<cSLdS?<S
H4HTf1VbT=\GA[f?cBSb#56^?b3S\_SK\Ag21PD\I,:TUCdBHVD>bYDTc5MBY\fX
:dI>agOJ_dgZfFXE1>P5-#Ve?>@dY8K]53TBJ;YW.f@XVR4M#eP/CN7N<BJFFS5?
(9OYJaM^KZa72LJ9>8_4/dbc7f#B8K6._V^HW1CQD?;/P>bC>4Of#1-&/BEI9d]_
#c[+L)[.Rg1AN.Q:MYQ?D]/>T0ZK8=)[#aBQgO4U3O2N,LG[.CPa<_D\<^,e::S6
JC9+:^3^5EFBbNR=S>bGLA];QD>4@#M#Lb9aY7D_WN?e7K^_&[KVXIX-5YH9@/U_
F>Cae.g5IEb[LW.H#I.,c>Fg)WLS3Vb[1-g@ORf\;0RcJ^edWHU#JCdPfM/IS]Ac
(P;7^Rd#^5LE5K2H\EQ_\;g=ORQ8DU?,dfWFS1[>cRZL(c@TWM70e=CE,>RE;&HX
O+H9OUY=<M/5X_^U\KPT[>Rf1V0RCg;#AW:00<&.K]LZ&K[SHH^OC4KNZZ0QOK-]
cM7@OQc=X=W\+]8V-?^O4IO\V_&debgL0/X^Z_9Z5:>E&dHAPZ^)C64+&K0EU8.R
.\8\d8dHdZ]4=8c<X[2K(M@I0?\#1#F6DAH9Xd;HCbdUCI&FM+.=DD#6ea&ZFJJH
1F/BaU0\4Re:>M&F-EW,A-?-6]@dMTWM0cPB21]Q>V/V-eRO;)6)T;bAG>;@^5#+
Xa>NdLUB(D@FXPaZP]S#J2I/@4SR?TAI-8\4JZe0NW_C0U^FBgL;P7,WE=UJ:&9=
bZ?:]-\R;Z2cGY9RY@0+SQ.8_8]]A#Q13[f)N=/OW<I@2H_?LSFC6/-b-AF\72fY
G2]gF^V79^.[MCU,-4S@M/5>+B:P7fF(:gTa,FOGCF?.GfYe(@e13N<FfI-_H2ER
DCD;MAQ,c84PKT+UaR6;[Q)VXd:dWdX:/?H+G]=<=@GI,OTW9^5_V@,W],>A)5g;
473LfVML^cdN/QafQ](<60Cc9^)6f+9P,0N;G#eM@Hc-7(I1=f7/X@E+EWSH@:0B
:F^\CS)^5NQD]bRBCRc#/U/=:FDQ8\ITA&N:X^cP(X7A(SfgLA7^?dYQ25#&U1B;
Ha#&Mc^N)7N_Z9)E&7Z41>HV&+ZT\4MQBZ4OW^3WP&1I_:^-\03)/PN_aeg,eUD;
S?@+U?HKY+J,JU&LbAP^KL)@d2Z&Ua/<MJDYS^:(#S=>g_a/VP75WDa8VCG5JgHD
4^2<-TS>RVMb()Z1>@;N#Z<)JPS\Nb?WY;/7af<6>3Q46-:;<;gKQ9XW^V/GTN6Y
KAdc?+SUe1HLg;/?FU4O3<dQ1+[H2c9GVN5Z;R\&VfWX6\Q=_#4VN<3]WNV.1H+P
1(FdETO3WfW@O(RWGaOS<dXXb]9GbD[O=OY9?eM\1Z5b:6L\NS,@5@>C6).]UUAL
U<;B,C(@+)4BD/gWS<F3e=@(FSC[S;]C.McECIKX=YeH+8O<H_Ob^B5D2\3\C5a&
2.??#/Z,3BDS2A:+UV5AD,@EYY-R5PY:G(/[99bR/UfJW>+92VT>-:M\#dX&-cIN
eSF@d=D5X.[-?WT#+a\6SH\/#2e.KT=REd74LVIa(CK#K[]4E&E7C+c+1_fP4.b&
9;fcC@)fD6WTP.);e@6RXV@GSg&-SL6];G/XG9;ZR\UQe&>3gb=9Ig.13WC#.33U
8N0A)S/0#M#LaWf3DJ_d(T3G-B@-6L63:Q[gZg819Ob+.2HH;Q^JV;E5,fU](a19
#(^H8+UbfA;O#L,?:+12:/+_8[^4??bX[4WMNI(c:=gZPOI>>35O5Z[F<6W?\J&W
/_NeRP5aaa>T+HcMPNPD0>aNZQMZe,Q[ZY@XPHPCH\FO#,>4L>4JOOeE^@9_Zd2>
;b9\N@8>;#c,@KKU&UgO?\9b(KUF?_cfT/A3cS)8]b>BB5f>U;6&#3/5I</(e5:I
\C[4WI[+LI;>61e2MTVJKXb..W))^2[4Z79R2]0?7cQHDEZUQ)R7dHFQTCdEG.:&
&f.;/c0+?^Z?]?V#)_EQ\YgEFA6QaE:#FE?1d2B]:Y?U?AS0a+#@4+_&Gd,E6+P3
eI-7[=#A(g3Lg.cI^=[Xg@B?[XNVMYN/GSVd-<7.@D>e>ZD>#/EPRQ5-.4\JSYIC
S#<A.AeQf-H&fSJ-\=2MUB;W:T,Ff6gD_>D951:V,L-1LMfW[7&abKLFSDOMA#6M
,JcQ?,T6Aae0-K1IfdJK_,C.X)&c1+>F#2eJV<8\)]2ZEM_RSf_HV-/NaEK:H@6c
60PRBGWC?K^_-^]MQ#1]&BEKKN8?BI0P3E2<_=XcY&S8;V6G=WC<S?.YgG=+M)gQ
A)Oc]VO8S&I<_4Q1^M2@eEC#0D@:8>CY85S7_/eTN)SCI)R\Z73W_0^=SG@.8eK5
A7UfAG1#E/.UEB6cZ(:9>54\1V..EaT/EWJSK8Fb0#Q?T>SYW6ZVWL:G;g#6?&Vg
,JI>P1gG>E9dQWC734T,D-<P3C;aHK7P;-20?GO?JVMa@[3LT6]B\f13X_d<T3^2
YeY:DBI_5FU2/83OSf-8:I?bIB/J_?BUVTXK3W<bT<A1NfcN6\[NS(R-]E:G0MdZ
@Dcg/X,eDI<9a.^5B)7(W>[1)G;df2[ab_R5\c+CRVB/+bf1/(MBR,YXGI\dFLT)
Y,P>f-F/C.N[BTB0T:d;)C-\2J(?;K[^I>HRLdPHT>(H<Qggf0L++-,-_Y;:=M#1
5g)L?YfFZRR2R;OBQH0Z,SZHV15F2RT]W-181V.>N:&5OfO2+E.Y,Xf:^QWL_C;.
bcfR?(N@CKE1/AZ(=21+3CfC?]?A8N2<C4<ScLM<##FH<e:<DX^>W1&3ggMGU=51
eE4V71AFW.GUTAQ=K//#Qe>&JL)L\4T=DBJ[YQd&c+DZT&,fFRKO;S,:\4NBB5Vf
BU_ObGQU]Me9[2:&U&ROb#\IS.e,DW6YgX(DP_GN6AMb^]VK>+B76?1_F=<,MECW
)L_caOSXNB]PV0#>aO(M>HRMd)^bdcXX>?ZIgT3#D7,/-[/&CG6C./NC(1A7OFT/
.(49G-6X\cQ/]H4e;[FXBfC)2+@X/IFHM2J-B+_cg+O@QJKc</JdGDV,?V>d&;Ag
LeV90C9YF<D6F9H-T2EWIEb:;SK/,RGG9GEZV^43H+6=))39,.5VA,AN8B]B0EbT
7#S>,Y;Vd<D3P?HR9K3Z=H91;7d>GJF6dZVNQ:AEfN8QVBD4S=&#FN7ADbL\eY:P
?M+Bc.CX?-N6Ze9PH=@>#VQ,UZMR,]FZ;a8;2f5J;G=FD?QdcaTX.[<JV4d)>F&4
N5Q3&4Af8#+3]LU]WXU^8(I;ZJ9MF:AJc+R4:[G3d\VHC2aaWVbROX&Og>HA&cCI
&XIBO.25Pfg032[]RcHQF-L<\e20Z58\T@>B7WQMG=;NH)gH_d-Y,b)7A;X-6Zg[
/X?DOf4G?_?A7c,@Vc@K)edIVDCE90FK8:@ZP8HE&Ib^K]FG74S4a\g?]<WCLfF,
;1+^f3?MK_<R+^dFLXc^WWf]BP;9,K)WGW8[f8357Fb>N8,9;VSX8XR<55#/M[_2
]IVUZ7cg,IIV/G58;=bc>JSgGJ[0LFAAMC.A,)-T(>ZMg,c5/Yc;:QYabI)5A3S\
9d+5]R=D6ec856;Y_E]+PV@7]\6V8>/IHb&M7eXAKRNRbBXH(>&T-,9^.2:(^Ge-
[O33gX5e1+7@SGJc^(bZ[1d][XJZDDMbW\QNOI@>&>cFb99Nc;c#a#QD6PU(e?7N
F=01aLAc,XX<T2eOe8XC<+X+8VaDC9B<20YeP@f.4<3P./@J/f-0U8#0-WJB?;Aa
MJ[\D;6#GN+DL48YZJ9;ADC3K6O:(DAPX3GFJ;#=EWXEURa.d>APV:Q)a2:/9e0@
gcf@N6QL9?2+7H34:(#\QHT4P:V=B(;)-[HJM((8R\=LdSNNHbfJG3a;Uf>ATE^Y
cG>VL177>PDA9^PK7a]1>\F2<IBfN&YG/AJK[PTOB=-0^MbfAA5TeeT76DWC)NL[
36CFb:.,UZ(D5VFD0J7bFV]+Y:_?NXGNXO^ac^O-aFX6T5(]d\^WVSWM41f<0-gT
W7ORM0S&Z3GO6b8VO>))^939(U60-Y-)?<;LCGYNd)c&355=V08=U](Y-#gOCT#H
.+e06C6I9E@NSED):F;<DPTDQcINIEG>K[W(eRQR1TZH3fEC#63/S0G_K8U7OT<6
.6efB>D;5ZfV9=7KC;P3-78F@W&.UNOM+#N)XVHcT^@E>+E4C5\R]K3?-(;4>,BE
G;L^6ddd<DfSE4E@\H=9:V=ZKYO/Gc0gR8HILT<:IU/]Q5\))e&2[F5MZ)J/eUZB
Lf=;7P(0A)-.1Q1e?5KeXgM8(2G):;IQ=Q7KKS3[3./a6a1?f(AfVJCf:f35@c0S
\U,)a#?DSNg-f?Ld]AP@58[SMEaWW\:?8.3N1JgY@TW,566U(@P+@H(fV#4D._[S
RH7O>&/8E\R&P-:B_d>TL;b9;4eZd6;0fU#Va@TD=d?4[+&\F=Ue)Ug/+QeSSVeB
9FAX6O[S@Xa7DS--Z-T6XQ1PSg)b;CO8D@U:O(;^&>[^J8=R_<4JTF4I)\Fd97NB
8?6K#Y?KJJPMN3F@R54d523=]J[&#S\ONH\QM\@O(Z;Z0KOZ30>M7aaQbbC#LMPe
53e,cL6X9e;^bX>/<^);gF3&@2Z6PBO33Mf(8HJI>)6Jd;+bK+VQS<IZ48M>;,Ce
5)PDG>a0)=.aA(.^Y6H-fMXTef[&[5#8\KR87?LK<RCPZF_])#I9b-Zed)_/XT=d
(/POW8YDQ@@#L_Qf]W=\g_Mb;HZBd8LY&](+P8cX&0T7],D)De^>[CeDaL&Y91;8
YS^H+C]<-AS)RZ@\CPdWeB8(XNHPO&O;H/7d]eF@M7P-9fF<#Sg3Jf8gC\>07&e[
\SJ;c6adOGD09T8KAWKM,<,dgeT7ZZ\4f1SVf=Fg<R@5@Md#>.afZ=RU_Ne2^&P;
AWE/BN(W2-00/N5\5W+D\QJNg5XJSPK;GgH=IZEe2e^E8bIc=,7-9S^#3]V#REEa
345M>gNQPA.TZE78a/0bZP5-DMNMB5PM.b@\>XEE@K2-Md94^cKF/3B1U,^7]Of2
D/#9UT;4;V4K)Bb.NfW^e28K?]5<MY-8A#OLM96M]Q.6&;.E1cWA<6Lb7L&W\F\U
TA_:G5.K-HU#S^Xf(e#fe.2)1Wc0\4g#0<KG86<LF\X#WHgP9+IbQDLbQCD@U+-:
JHOd+&V_P\]:b8_NF+.#O8H^;G&S\f3.UbG?O9BaX5<P[YX?Ye\5Y:e:2J<G;#f@
1/&_2U2a4_Tb:GI\(1XKVaX8,;:YI?;Xb^K31K0W:\eD:f?[>8?RT7B<]?RbI_Yd
a6#31ZVbeRD+H4WW--OeGA_<C91a(?72/AE@#a;.L<eP1511ZN,6B0TP@6gE^-],
gUa^^(2XJ/-3F<,49S8f#\G,(f+B60[O)?BYN[DAVSbGb40<]T.G]5FO[B600XL(
IO.WRfJTPf>I),2CX3#0^(WI=FE&T_Y0=R(b/KKM#SQHEf,DM8LS;.9Ad@c?CZTD
6PE1YL#+/>&dDC.<:TZM=;cKAT#&DUHVOI:A;]A+8<D]V4@fZ,]MfSOC.bE?OAN\
]#(AJ[F4-9S/4WaeV-CEJ^;7#1b7/Ad?>9>ZJd3&_-)]RR>Ye3bI=fA02E-MF0F1
\(+])YLI-5+-AGeJ7Y\F)SLND?W3@e3Ef?cCIE,,,>(.bG,H;I]V/Z3WB;MV2IcD
f1-gf\TY)G&53&7+&T4ZXIbV4D_\g1@7d61eDLY>c<HW<#CO+[P2EbIW_=c[IJ6c
?(dfLX?;)/7d=DASH),f:,:#ETU=+b=I>4V[WB)IGQ\Wd&GP@&VECXKW-K0fc3_&
35UEL6JHL(#Eb-AZJ+a0ccGZTPEBQQD;eNV)B:2IUFNT1CXX?.H+:\SceV;a6eVg
E54IACYH7&YIbF^#\ESd\BaAY_b8O[]@T4.b>E6C:7V:2f[CHA+Q-ea-68X?^F;?
:e1bd#Ig2#H0+.P:DJBKXE0OT/J59[2F]\)7I4\I6C\JAM?>[0G,@R1Y#UAEZ+Y>
P/-IZ?4(a_@CW^>CAT3bOV\B^^ce774?HP:LR;M6Z,O?ULU5=3:+P;TKBU(X7aF[
6?_3_P^\0\:,Y9JN=SWE0_4S1e=]?_gYO1F^c-_:?=L_;gD4_>D[EK+0P,>@8M,K
@9QQP/.^O;+bAMFX11K9.:V^:H@722F7>ME[9>ab-5)\-9VE@E=b@-<T[#F->0N5
0(U.\d;/#2QbL87FF^&5#K]&(SS9=ZE3316b,Ve<e_PaU4b(DRL0F;:9U\=(7,M)
5Ib;fMXXS1[[2G_gL9A4\N80eGL9/W?[PE1cBFceY;f(<aJS-KV1fc(M,g[a^H0>
S.#0#Ng-RNC;af1<KOY<?/#1afMU:^@FgB>HN,RCR5HWOE)+R#723^GIW7QZ8\B#
)4NBPTb\:H0gJ.<Z3HEW:(/[GYa]5;Y9aHbH<,>X>+9W4FbP-T10,,ULH]&a4/G_
9:.\6S/5XaZ^aPAcL&dYM<I67W3<_B27T-\A+/L-e==_T4dW12b&[66R[T+)ZJ[d
+?dLdcdD1FDICK[(JQA?U?TT^UY-Z^BKE]?&3R[<G^K&6?5VOX_8RfC?O[(Z<9B&
Bf4D6<DWH(X()#f&:PaF\>MAR#cON03cKaH(RN\T[S@(R;ZRfZT5VPd]XB(,G-^E
,VQ?aUa@Qd]Z(L(K5(Kc8DFG+UNA9IWKVEHT+QfO9A9>;S:Q]\SW0B?cf;.ARHVF
N>QE8ba708@+[_CE-TfHe^?YP[:B+G+ZZP)J?ZGFgJO&9eJdF/+#OUMB>c+CD+NT
FU^A02DA9^A<4W0.M0-L[&2a(?WSCS6=NDG8Hc3ONP9K,6Q>)b0]f][7/9XKKI0E
FX6T4E>)AR)F415,=8=d-DRN\QegSSJIX)F@UUfJZ)YRQG&eN_@UYN_NOK6F6d?R
MA+,Ib\VCT?.a\LQYORea5]ECW.?bGO,a]Y+<Cfb5M87&5\T9,2C^EJ_8Jc&#W4T
Ec5PfE8<L\a,S?1(geEVf/[aVH2BC).4):a#?&f0If=;L&MaY,,;Gb723J:\?(J]
f5J_\GX,?/#eW15F:5NOB0-1[4E8CP9F_=&I5;T)K0S+&INDUTNYL,Cd3-_A6\c\
8H^:I19[Y<Y)ee9X8E94deMK(gB_71Id6,/\B7b;,:<<](Y&C5/gQI#G=UW3\R.C
+SS&H\JUNg?EBVHD9?-(U8P8;LIPN?)9NDHJ=X+HS9g2-JQGZgRfB=@b<:?0A196
Tg<VZJSB(CD(+bT92J[L\_/Z#5+Gf<UV)Y\f/C632;(:]GJd8-UdN&9\cT0/YPTY
&-f9D[)CLGI(aBSd\UER6OB0V8b(Hb2Jf.c,4gL,+?6,Z=R_Z#])<;<^:^N/Ge?V
NcXI]Ab@OOGfH?&J/PS7\=:E50C>6>;WCc?_(.U34@cc4>E0+C]aSU\=gB1<)A?>
=4/+R4Da+Vd6:0^9)E:ef\<dbefNb8\]C(/5eeM\Y_KGQ?]74PIX/a;ZKEG]LMUc
TEE(]#EPI;bH@^^b(_ST_d7&W<cO+1e<SdAaFeKN^=Qe#Jf)c&J+-,0^AXe)WG,O
)CV(dc#@gEV(c+L.\A?c:V>^dJ7dM.N8[gCK^:deI<S[OBMT/adJggP#VTI:>20#
046QZU=S:<EZCIF9@1Z5d+?.M]8>[4-cYgXeW/#+7d6E@3D#:MC)D(G4QHM;/84e
IgJIVbV?E\EW-_E[30.4,eEb/A+M:9-I?P864[Y\V]>6Q9([aMFKS2_9CV<=G0Ea
PM.EP]Lc8=T7^_PZ\AVP>\GG,XPCNWaNYH,T+N[L_a,0Z)B2.RVI>T\8_UYbAeJ5
8Tf1\4A:@<]HJC3VJ:>6]D9WZ[OMUAB02E^4=E1Ze:2@I))I:Ggb>+\8L$
`endprotected

`endif //GUARD_SVT_CHI_TRAFFIC_PROFILE_TRANSACTION_SV

