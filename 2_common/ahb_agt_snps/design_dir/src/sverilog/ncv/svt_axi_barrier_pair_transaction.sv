
`ifndef GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV
`define GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_transaction;

/**
    This is a transaction type which contains handles to to base transaction
    object of type #svt_axi_transaction     
 */
class svt_axi_barrier_pair_transaction extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_barrier_pair_transaction)
`endif
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /** Variable that holds the object_id of this transaction */
  int object_id = -1;

  /** Variable to indicate that matching transactions in barrier pair are
   * associated 
   */
  int is_paired = -1;

  /**
   * Write Barrier transaction.
   * When this handle is null, it indicates that WRITEBARRIER in the
   * barrier-pair transaction has not yet arrived.
   * When non-null, corresponding WRITEBARRIER has arrived and is paired.
   */
  svt_axi_transaction  write_barrier;

  /**
   * Read Barrier transaction.
   * When this handle is null, it indicates that READBARRIER in the
   * barrier-pair transaction has not yet arrived.
   * When non-null, corresponding READBARRIER has arrived and is paired.
   */
  svt_axi_transaction  read_barrier;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_barrier_pair_transaction", "class" );
`endif

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_barrier_pair_transaction_inst");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_barrier_pair_transaction_inst");
`else
  `svt_vmm_data_new(svt_axi_barrier_pair_transaction)
  extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_axi_barrier_pair_transaction)
    `svt_field_object(write_barrier,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_object(read_barrier,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int   (object_id,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (is_paired,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_axi_barrier_pair_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_master_transaction.
   */
  extern virtual function vmm_data do_allocate ();
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();
  
  // ---------------------------------------------------------------------------
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
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);
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

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_barrier_pair_transaction)
`endif
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
l1WtpyWBcdFToSBmAlyyLUeG6iLSzRAMj+e6SIxRPu9casJjbipE9wB1t/IVFYCS
42jlwxWRg+q+CX/5my9ehVWRgfhF61BXF5Y7dJ7OYO5i3KfSnJU0joax74clPynk
wGNKQpclB5ujZ1QUJ7C73wonkAvd8EhuD9RnR2EOh1cbshfULb4g/Q==
//pragma protect end_key_block
//pragma protect digest_block
hEzA0vmMPjU1iafIhlS0gZF1QV4=
//pragma protect end_digest_block
//pragma protect data_block
8c9bQaYs6IKwSbroAzgSk2HHqznKdxDnqAzPYb3t6tHfXpcWoGporxr4c+9o0PgN
/GdjNSay6D40ActDa1RWx5dK/vEFM+e7gtdV5UQR08uLgYl9ebdE7mrI+Yo04iDd
9jetCst4cg8TYuDLiMMtB2uV8uEbsStF9g1qTPI7cCItEDxqtDBNnKIooJ2pOsK4
p4K7uCpVIyIZmtP5njzftninjdw4YOIkSHxGDpRLSeSwrZJUrJdPNaTkQs6EHlyB
ZHRFCcZ2+JjJ2tuIan0eBPnh2DpahGIgnWOCgmcAGgBEW8sy3GCApjwgmyc8FdyZ
EqtIJi1SBtZez2ZHfYzpUB0oVva4/8Cbp3ApHrGSNI/xePr7U9S8iUa5wbVKVw3r
j0nAeR9EjJE9cYz8PPoa5MKZK29V+I9Vhwh/cZBHgrztztFg6YJ6wLezD7kFuIim
Aom3NgQb9ijFXsZ/sl75VQZPVX2kwLPhOByQ2lD5DcTO3vCzb+X5O6N3NKsh93Yx
qJzW+t4x0vtka7UKKK7O2scYKZmrYbaKJK8NJcEytehc3xn55AbwsG2zSoNkcRSN
x7zwTxBpjvD8Wnp8qcIhcCJicbSQJ69OcY4wJEaudQXxGK3plmGqE5dP92PCSi0y
rAqsC2rpU4UhOniOohQE+vGjA5ztzwAoUoohjU8Gd9b+eynCKQ/v2lj0QDhUyTiG
M6t4XLOAN2P2mfxEpZowsUUN5wv8UTwH8ZLkAtDaKeq0mWGOI2cTebWgYLQsYQKt
7NxGwUk++gTDR1+NwhJlTkv1dbZvI41ul8gmfefUiuFz3ZMEJ9910ZPj9UsXK2hm
P+fXR4mjIU9xkqm+Nc/rUr1j0nE2GO4Z8WOwBQmTHCYON0lwc5IL1UsndPwW88Rf
bKh0IW/crfzhDAF7hEeTzCpgpfbFT1eWGt94BdqVCd3KydVDEkInA8X4mV0i+oyt
BP39FP3ExC81GFCRn2KrLYO0pOZdsAl2pFn8febqFtZRYsCLp0hugC28KWLnQoMB
MGN+r2+M2aWrtxPz9znEbbmD0QU+kIVLCKkp0vtZbqzcZOfvZJNEWOUAPvvlVgx3
HqI3HCqK74bbyuB07WdmFA4MY9anL7DiUO2y6i50T0fY5jqyzREHecQgQgiscJSF
LubkaUG1mSKyKDl1Xk/zUf1fEul3pPr8oUEGN9xYLJg4/EspvqKXWNOtB4OrzpiL
RpuUeyw4MrhGDCmN8+T6ZcB+mxWyb62Z1up9ePyQM951SmnR2YiEzMk1c3g298pY
ADOqu84VQGzCkGimcZUadQ==
//pragma protect end_data_block
//pragma protect digest_block
zwSFswhBe7wBGL0VEYUqjGTh3FE=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5HrDG7IfF2SPSsNA7/tJ3dtY7y+lgpPwhAGQcDdqVZNIBUeM9UxP1LRItageSohy
uuNj+klEJbk7rIsB9h0D6qCzFFjFCzMH8IuuBxgXSxlB8XoG6vrfbQaJcDymYFXF
gfCbMIlYczxUD9uWsKd/fqufRr62BWad+Yru20DHd81Q/KJ0Q+YxHQ==
//pragma protect end_key_block
//pragma protect digest_block
X5BqtqCjophXrUnjIw9B0VdaBHE=
//pragma protect end_digest_block
//pragma protect data_block
uBJjQYhi2IuocqMkfkbNI9YlsTWJC/9o7mkDOnlwAvwpIRJYslKDIAiLOnY0GHFh
0YiTwvxTvJ1HkxOOMmwzLrDihToyl9+uvzRQUJWtdlDQxoQ0KNASgdDc5Gi3UIA2
d3lsl3XLDC9nKpWfgeSOSF705QPzI42ocwf+SOC/G+Qi86Jk6Kpm+KyVQM7HBiVA
KKUSXieQqA5DyMTzw6ehOTeNsTILkr1CGCDV7RvMR/5e42ossYCMX05uk5OQiBHu
eCmYY1H1Q6EkrzthQBmiCiY/TO8tGvtjWjZd+P3oAkq6/rVM5cUZJ2MVnb8b5x/m
yacdhzseH2iwa/JdzlKn0VvGAmPjYLWVxj3t48J7bkhP66wv0rm2IzW8fsm/uVck
KHK2odIF2NChU+Tw4Y5sz+Wdfw3/3sG0i3LNu/cT6NRC1jDA6s8c2cURILdbS+D2
MVkqQvfdDFZwgSkQCazUwufveojXSEETwYI8g7mSt9TeB4xLRO0YnYHws18Wd5Jp
ALsFBV2PSA414neUmUIuVOvAw8IZLCTtuvHIgr3/nKE=
//pragma protect end_data_block
//pragma protect digest_block
2Gid4/g2NLtiRVCp8wRJztnDIjY=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/9PNljmaCOKdy+r13JXF1vPDN+jslLA5NWJxNf+4AROvu+69K96Df7I2SgIH2ppY
0CpQuu9IAE/O8I1Alaakor+gd6AFQjsAZRfC1GC/e477YdLD+brJ5MuETsnTYsqn
xvaKDrgcsOUe0UF9ilQopVlKllEyG83lOibJoOBVjooCtwkW0cc/xg==
//pragma protect end_key_block
//pragma protect digest_block
/mVNcGRl1EyD031AjQwFZBG3ipQ=
//pragma protect end_digest_block
//pragma protect data_block
nyPTYJsuGPpJAh8GnZvMJ7TFYLB9axaYCBgLmcuyYeIOLGfMFQVPvCMDO+vSJ+tI
L9y3fTD6DbL0Ebv83T4dPNzv8y3V4dmdeG/y93O5oK4XcLmsZExH50U4D7cLhOrD
+unOF+03Gyl2EpXW+xic1/EAyyxNacbz18gzM/95QIWE+cYTsFKtP60uCt4BhW73
5Cz9n00OupfVyyMXmjBgDp60qMdUR0AGrRMRnJ+SpHxm7iNxgKUdjSw5YDWq4X6/
eAA/w5v2ItTi1UGsuPSvfSdGJiBu+9VcM/HzXpB/rQKKUq9YEGYkpzlwRp9LwLvE
eTF1osx0fJhBX/i3A+4yn6lvyHUJY8odvfus8u7xocyr34x/ZPb/osdZNcGEe4eP
tz/QwG999rSYoC1VNlsMqkiyCj/I0LwOb9Ntqdvngk4JF1EwwnxcpzbtGpAly10M
sm0PbA+xitef58fz5ry1zcK2ZQcH0iZEn9PqN9xFwn4=
//pragma protect end_data_block
//pragma protect digest_block
KaRn6YcZZfpUxbgGQUWTnI4q1Is=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SKkarlBGNqgrYWgROo8ikeUO1tb8NkRD8M6qjvIIVsuEd1orIThY7MQqqeg44NYQ
Ixz8Svkukue00dYs8nsASnfw5rKLr0zEQoa8Nb7V6hRjTlEiTbSZZDLhTckIq2wW
0hruq7sY4hQ5cBwWWYjI7QiPaxxEo5+H4BvW2wVb6Tugpr9L2fxLyQ==
//pragma protect end_key_block
//pragma protect digest_block
x4JX5PAa7RgYp0KtTcIu45V2+mE=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
aF2si4d6aUsQXkrU2TRNyvSnYBc=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_channel;
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_transaction_channel;
  `vmm_atomic_gen(svt_axi_barrier_pair_transaction, "VMM (Atomic) Generator for svt_axi_barrier_pair_transaction data objects")
  `vmm_scenario_gen(svt_axi_barrier_pair_transaction, "VMM (Scenario) Generator for svt_axi_barrier_pair_transaction data objects")
`endif
  `endif // GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV
