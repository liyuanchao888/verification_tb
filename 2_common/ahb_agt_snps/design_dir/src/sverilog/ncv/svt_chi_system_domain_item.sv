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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
slqYP9lUTN+G3YWvKuNT9LcLpHdKtyRoZyzBcDTCOYnP9l3rTrzBSjTymDtIgTC+
5rmikDTut2VUH29ZSptSJxIO/lUYww093M2hGBOCj5vXVJVfRKeskHA8mX5goiNJ
Ybe9arn/a6Rl/Rlsbw/nxHBR6p/8Njro1qeMNm8Es2okxd+KoQulWw==
//pragma protect end_key_block
//pragma protect digest_block
DYAmaWSJSuJj4gdOQJBs9y/1nxk=
//pragma protect end_digest_block
//pragma protect data_block
lcRvg4es0Ar+Qg3gniidhxXx0fYs0ZBQ3ErFZQuinUdsVUjbqfWaxsFxNpEV3VZd
ASBCpR+hMky3vAK0V0+00xtJUEP1ceRa1hVqj7Q9TW3g83kpFaODWb78oXClosMa
gLZ5A5TOPoArhPtcJci7hghpbmKd0Oc4ah5F2Ft/XP1mS94ALxUnimNQ2bxd8Fxg
/DeosYoUKf8AnRmbTISHcDeVShIbe4T/cgF4vPT3oV0yWF/3+BZBl8wl+U3JVpSy
6g8gdA/EYUJLwzRIT7lxE92qnwb9QWCXlCXUfMSaIgE/naUYvl5jZtHCmdyqQwZO
piPTnpOrrHGplDbLqw0uudHTlkheBrOIVQW913JSQmL+XYWJQRgPHaS/Ybv08kZ9
I4WeeG+OSHCQws0+E6V04b1LWItFl5DuRUR2Dml7nmMHJMDfeEDoRVBubFa4ZbH9
WEd5gP4Wqrmc2Ic7tGwGiFxMw/YS4MZbrwl2T+l0ZHYBCVmyJ8hgLQVuRywz3VDl
QUB6iFfjSvW1DsPKZOUK+igEuOMQvq2rgWSGjaPD6H/MLIiUIunX98CneV3Jf7Af
+HS8vvy5rmaWAFe1ZAcQa+GAjMK4gUGKtXw2aH+g7+oxCGbKabWsDXPmikVomEIS
lZA9b3hHRjjXXE0chENKnC1m1zOfbHYCubyvD8JkrFtsDdNbYx3slJkKrkroekkM
ZFe3Z+K0DPd1ImEz08PmIqaztP9D4z8ANxKjo/ezp2Ftb2fwnywzRwLjyBFdRrsO
ShduZm3LZddIkP9b3Mzn43S4ujALoS7nfRT/LE+M/D7mHqXQ6GQGfiA/jUDXs8gC
aYJECWQlj7JtIXSSTK2l2e8VuWbR06iaVZSvNH1KFVsRJJ1mcDDpNhnEkov+jH0a
XQTFPGCuy0FaQwOA6013lHzf5ngZsUYw27ShnKI1OHfeYX76uMGUO0yV+wdO3wfU
CK1JMcFGGyItqc5teCeMKQ==
//pragma protect end_data_block
//pragma protect digest_block
BPdlxuYZW/HEMFaK+cX/GXt3zqg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RpOc570JQVTYJ3CcnM+fU1zvKiOlLIE1EiGwBVVlc9gLKKy1Jwj/qdsFpUFN3sCW
msRLzEqH/O6CF0IHXv4d1o/hrXprw/kDnEw3iULR3j1Zy+L5yc4HcFfEa/zqldhr
5AcmAw4+huHZcbdUejs0QB+DpXmDWGTeD1fEGNd8WGkub20maBulxw==
//pragma protect end_key_block
//pragma protect digest_block
xaMi5Pcxu6UYfOxCqRAzJezFHpU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
vJIpwaiURpx6PuB9FxmVDmsFnds=
//pragma protect end_digest_block
//pragma protect end_protected
`endif //  `ifndef GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV
  
  
