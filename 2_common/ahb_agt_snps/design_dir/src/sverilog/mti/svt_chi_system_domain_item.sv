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

`ifndef GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV
`define GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV

`include "svt_chi_defines.svi"

`ifndef __SVDOC__
//Update once these methods are added to the system config
/**
  * Defines a system domain map. 
  * Applicable when svt_chi_node_configuration::chi_node_type = RN is used in
  * any of the nodes.
  * Each System domain type (non-snoopable, inner-snoopable, outer-snoopable)
  * is represented by an instance of this class. There can be multiple address
  * ranges for a single domain, but no address range should overlap. 
  * For example if RN0 and RN1 are in the inner domain and share the 
  * addresses (0x00-0xFF and 0x200-0x2FF), the following apply:
  * domain_type     = svt_chi_system_domain_item::INNERSNOOPABLE
  * start_addr[0]   = 0x00
  * end_addr[0]     = 0xFF
  * start_addr[1]   = 0x200
  * end_addr[1]     = 0x2FF
  * domain_idx      = <user defined unique integer idx>
  * request_node_indices[] = {0,1};
  * The following utility methods are provided in svt_chi_system_configuration
  * to define and set the above variables
  * svt_chi_system_configuration::create_new_domain();
  * svt_chi_system_configuration::set_addr_for_domain();
  */
`endif
class svt_chi_system_domain_item extends `SVT_DATA_TYPE; 

  /**
   * Enum to represent levels of shareability domains.
   */
  typedef enum bit [1:0] {
    NONSNOOPABLE      = `SVT_CHI_DOMAIN_TYPE_NONSNOOPABLE,
    INNERSNOOPABLE    = `SVT_CHI_DOMAIN_TYPE_INNERSNOOPABLE,
    OUTERSNOOPABLE    = `SVT_CHI_DOMAIN_TYPE_OUTERSNOOPABLE,
    SNOOPABLE         = `SVT_CHI_DOMAIN_TYPE_SNOOPABLE
  } system_domain_type_enum;

  /**
    * The domain type corresponding to this instance
    */
  system_domain_type_enum            domain_type;

  /** 
    * A unique integer id for this domain. If there are multiple  entries
    * (eg: multiple start_addr, end_addr entries) for the same domain,
    * this variable identifies which domain these entries refer to.
    */
  int                                domain_idx;

  /** Starting addresses of shareability address range. */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0]   start_addr[];

  /** Ending addresses of shareability address range */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0]   end_addr[];

  /**
    * The node_id of RNs belonging to this domain.
    * The node_id should be equal to the node_id of one of the RNs
    */
  int                                request_node_indices[];

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_system_domain_item");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_chi_system_domain_item");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_chi_system_domain_item)
  extern function new (vmm_log log = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_UVM_TECHNOLOGY
`elsif SVT_OVM_TECHNOLOGY
`else
  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */

  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_chi_system_domain_item)
    `svt_field_enum(system_domain_type_enum,domain_type,`SVT_ALL_ON)
    `svt_field_int(domain_idx,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_array_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_array_int(request_node_indices,  `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_chi_system_domain_item)

endclass

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QdFLRO1H7go9dBxFV3AqcEwhqk3Qr2wJ3ZMYvnKLHdGD3tlE7yxx2JvUrFlhYLqZ
UY0Da3JudQjxMFFPX6p0n1Mr+4i/vKitHutqhqez05LEtexY1W5KmIiRSJp1vht9
+w+9qksVthcXEp2jcbY1vW4dxHF2lwlFAnLkqb/fVk8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 563       )
kp9yHmGhWpHWQ2+HSKqQXMiGSUIsyGd7K+3mBsNgP7GCIDMaGrQg/xwkq80oqMge
igQUpO+47D6CHRdjORa1m4hU2NJmSy73zqQPS2IjStRoU7PEvHRS81LKnu4GGRAj
Wug7tU/iUWVNAx23U1ZeNlcT5haaOvW8HL51bBZRKDo4zWil48D/nlpmoaiFqIxD
kF41vMLyEj2aXIOGBYbWf9Pjz7anWXw0fw0+FoaiQdSQg2zPgGVxsBWFDQrWXyNV
odn3wUnK68d7sr5OJEixLC06V2hJSkchSRxHg8Y59agMbO3Vvr5Lil90wVkNws1B
e8otOlU3gRKR6eVml/MfNpYwXesDE2fE3QehWaV3/+MJdKRgo6vJ+BOXL9bFUGWH
8EmlQG6WnxjFwbD7o7fGlGXSvI7bHW0rhlQcNiYKcKTROI1qQoyudJ/6DiHkEzo2
djGLksIaKoaPylzIimzH9y9r3HVixanxVHpc9J+7xN4B7T+1D+G2EZ6+a3495Oa2
P3+Wz4UwB0TOna+4reI/PnjfA8IpBOGsgovM1OpGoxhcrz1hnitjZiudifV7lrJI
KwyX/vlo3ULBDfEUw+UMtx/Ecrl3lt7A3FWvRI5nzOe/EPlhaK/gbdXkVRJ6hHbg
sJS0T0WXUSoZkVMEf25yVYAn/Lx7wVOe3UDGKFDzajRVtTHmpEdC8IJLpLczNhtG
X0IPMrQfALM+jzTIB+ZREKMHLl5HQKXiWmiiTS/pmv3EAoH1a1Yzp1J9nPtzmWFJ
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
a5Cmze7iT4PrYxJ7reSpKk+wvDCnEdd3ICWugfanMJ0Guiz2MS5i8RxR/277M1Uw
xw6acEXJ2hyqNxFvg0s6CLZLMO//pS3llywNth87ZVcEHMezzbDVZqfhteQj2knT
RGAgIk0bkVBeBKbji05BQ3BoMfRHZa1ae11mYIFg8eo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9323      )
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
`pragma protect end_protected
`endif //  `ifndef GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV
  
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S1xTY6Lpq9IKhMUuMHNUWrHL5fmbAL3ETwxMTWute6qIhdIUcRsXmEuy7IoRlC+V
Tw++2nKM+xmEIhfmeXeVUgtmUl/gqWV8+PnM8+/B9l2ysQ8/y22YLFfPCysr9lsI
JreAT3EaS71NhxN74kHcF3w1X06ml4DhNrtMzynMYaI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9406      )
8QsMnOsxBvV+i/jRelp/tq6leAFaJA4E/hbc2sgslHfu8d5JlWWEZKRaqdc2scDB
NCSf5XUuuDsEodHk/ZIc5dWMBCKlKcfxNGB/GDLkGQvAYmRrT9YZXyMUmrsQUOqj
`pragma protect end_protected
