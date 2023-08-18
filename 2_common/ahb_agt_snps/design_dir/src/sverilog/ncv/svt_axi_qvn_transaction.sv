
`ifndef SVT_AXI_QVN_TRANSACTION
`define SVT_AXI_QVN_TRANSACTION

/**
 * svt_axi_qvn_transaction class is used to represent a QVN transaction 
 * received from a master component to a slave component. At the end of each
 * transaction, the slave port monitor will construct qvn request transaction class 
 * and populate them. 
 */
class svt_axi_qvn_transaction extends svt_axi_slave_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_qvn_transaction)
  local static vmm_log shared_log = new("svt_axi_qvn_transaction", "class" );
`endif
 
  /**
    @grouphdr qvn_parameters Generic QVN configuration parameters
    This group contains generic QVN attributes which are used for QVN transactions
    */

  /**
    @grouphdr qvn_delays QVN delay configuration parameters
    This group contains attributes which are used for configuring the delays between valid and ready for QVN channels
    */


  /**
   *  Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ_ADDR      = `SVT_AXI_QVN_TRANSACTION_TYPE_READ_ADDR,
    WRITE_ADDR     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_ADDR,
    WRITE_DATA     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_DATA
  } qvn_xact_type_enum;
  
  /**
    * @groupname qvn_delays
    * Used for introducing delay between QVN token request and grant; not valid when v*awready_token_grant_mode==1
    */
  rand int unsigned valid_to_ready_token_delay;
  //rand int unsigned vwvalidvnx_to_vwready_token_delay   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  //rand int unsigned varvalidvnx_to_varready_token_delay [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];

  /**
    * @groupname qvn_parameters
    * Address VNx QoS signals
    */
  rand logic [3:0] token_req_qos;
  /*rand logic [3:0] vawqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  rand logic [3:0] varqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];*/

  /**
    * @groupname qvn_parameters
    * Represents the qvn transaction type.
    * Following are the possible transaction types:
    * - READ ADDR  : Represent a READ ADDR transaction. 
    * - WRITE ADDR : Represents a WRITE ADDR transaction.
    * - WRITE DATA : Represents a WRITE DATA transaction.
    * .
    */
  rand qvn_xact_type_enum qvn_xact_type = WRITE_ADDR;


//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
orpHemCBonaCOxWVBDFhVZ/HsfAq7RBHJd/dYMAnT0PucuvriV3cxyhUgxOmTD5C
S+e5xdwTFZPC9+M/SYqhgrZ4XZV+z4tJVPh55yN+HU0f8C2dkOih+8iB7jJR0cby
F+h43v0hyFvl6wiA9pE9AEhUCvZvrwli84I8zDrV9Wu/uaWAEZbzbA==
//pragma protect end_key_block
//pragma protect digest_block
NILgyXvU67+jvPAlB70J9QXujFU=
//pragma protect end_digest_block
//pragma protect data_block
Gpw58b4VSbPJah6xu7Jjc3FCD6cJs06DS6CCUgz/SVGlcts2tUpqcaxXz4xWAszI
tTM8XY4uMZ/tG83I1i59sqHi6c7UWVVw4ATUTenGT0cWdD+dR6OtzbWfANtFkx05
QhPbRe3p5bpA6g8srL7QuwzTnBFnHEMqZZaeAI6Wnhc3vmMuy/7BWnC3aWY/eVrQ
LYS6iMFknFBdQYNwrcfNdUP3n4cPg3cpCfp8LDJkE58zqvJJ2kU/j6FdecgLnGdO
GTCPS8cknf1CgaTxOirKH7ipj/4F2uSUGYnmL4SwPZrmtzuVeNS+xVxcrUfPcxxl
b6lmx7Fq5dcIdCUWIlogCdTxyTErYrmIAPLlE5XVdD3kV3CMTMCO0TPezejK0GUP
ZJu9w7Q25KS1EjTMNXrRlw5f8FrsLZv55Q+v4hozG+EnyTRm5g+GXhdOHqORQ26/
JWXLhQQ+cKTw7Z89KscS+LhqQJ1JsBsU1oIrc+gVneel4k5HHS0c08D8AtZeCClx
BPfwyDkGvH2HTQoWIUroY6v3wN9IzS9gVsfh4YcUrA+rXQCfIC9iZRVcRgGwYrWD
JBD+towzmWHlb2KQu6v2k7FQgIQKZWl0drswSBxFE6UTJiTZ9ItSYwOC5F9VWhZi
YV8Co1IPzRiV8K0QTiJaR/BYu11+9YW8ofeuumAJVFTVSnA0WVJ5wvHRiW3Lex5c
u9yquCNWaIxfuWmxalr7XH63jfgKPTLntu8+IMfQg2iKuUqiyr4saZXB67k+vpb6
1j90DZ5vln79svtaRXyHu46SDJMALAQHSIRIEH7MuBgG346qKBocKK+eXPVGfsT+
JtXuRFo4c5LDevavSLV/rNcZsHKv6SHV+AyFIXp5U7Y8nXjloyj6WJvwvwQtMN7G
fb6Guhi9AbXGWG7uKDLfcDsncpBpHSeroh8ESUzPFm2eXpl70MsvonHOUMVKvSs2
81b6ZtKTacPsRqGEFI5ObNgK1cruDK1MfUSFlO5OosUyXtzzSfwHUKb3HDqKHS+n
pvExKd5PEyOJYknbbiz+VuVh+L57DLT3tHzW8qakT3YL/LTypGu4PnoX5hCNn83m
n4SyQY3fsOlIyb4aP2NfSZleZyAc7WBlGHlZuBfq8aCpPalVVpympEWQNEe19B0H
AShTgXFUFOfnHupTixuRjrKz9YJ//asIH7yIMCBPOLQrWNDZcbwIrYQxuiQaynY1
+CSSPmKJJpMpisKSxA+L17MHgsm1/u33z96lQEwTThBvhnpgvIg/NNKciFY1b9p7
NXNLiCx8dwQxcTt10Vt8uAK4VctCVBPcma2rfa6/WM/MNrsY68TsssalOfKo2zTt
My9Xeavt/AWSd0gJpv5tmeYha2+ScGvGVgEKEMuOw7kKJZ9tA/t8oymIpEERPTfy
kHQZCniNSs4VMPQwjgI/or2qI3HdEFPMBiv5BUkU/YLL5KeIMXaLHQKuzKp3P3FE
6G4Z+ooA9iJZyHMEozRBcg==
//pragma protect end_data_block
//pragma protect digest_block
Us/ViuOKo9w+1LCUtfVWGrstYNg=
//pragma protect end_digest_block
//pragma protect end_protected


  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_qvn_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_qvn_transaction)
    /*`svt_field_sarray_int (vawvalidvnx_to_vawready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varvalidvnx_to_varready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (vwvalidvnx_to_vwready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
    `svt_field_int (valid_to_ready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_enum (qvn_xact_type_enum, qvn_xact_type,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_int (token_req_qos,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    /*`svt_field_sarray_int (vawqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
  `svt_data_member_end(svt_axi_qvn_transaction)

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

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  
  extern function void pre_randomize ();
  extern function void post_randomize ();
  extern virtual function string display (string pfx="");
  extern virtual function void set_rand_mode (int en=0, string mode="disable_all");

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`endif
  
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_qvn_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_qvn_transaction);
`endif
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ihjp/wwMVc1bYDe++1+m8H5Dihmx4LhtXypwQ0eUBCmVkKyhIBFGWNoYbpc/rHCR
35pfnXJ9naMTLEti2G20GbxQiYrlCy7h9hSK2BlZFUHKnZiAAiv2/uJ8BKI6IeaY
+ewisQ2rKSTYmgabwNsA+JDMiyqpWzZRitHgRryb2xgPEEtrKNJG/A==
//pragma protect end_key_block
//pragma protect digest_block
gqfMtv+zyAK0/pTcIu5X4cIISGg=
//pragma protect end_digest_block
//pragma protect data_block
ynWeh6ZgTug9B/uNLFtbVz/eBPYPqZY4aU18aJ0KNtJZ8zQImKioaEVjyfpsWl44
jrfQd6DRpt95lYoKgAwchJ1lt7eny/FxDCdgUZHaQqwX5qbdADVz3jExEHviphoF
wcfNRXYeADabM79Q6hnuQ83hjtuzdhOnML1O0+5g/oTl8PRYZj4iNwzumfTSnVif
uz7+ndbYcB3mZkt1lCQRZVqdx36IKAzX2YCBcXvq/UXlVUF0CYnIzsd17jKIplh7
jn5H3Fwx+m9twQK8l9FONdZFPXHTpOkswtBJ0Ccui1McrpRCbTv9XpMnHi2o3ToQ
ztHCED2Ec51mJgrP2whsb6/EXVs+sEqwH2VqaIQtAEorF9+03PL9lh3cxKXa2t4N
Z03SmjeegoaJZAYvEmQBDxEwVhgN0u1dI5ouMZY+K8bJlAWdNaG7xGimEtlTsPl3
TuntublAYlvAPorfBLxHrg+VvsI3DUllhfrf924Rg5j5FQOuRrF98xur9bx2uPAD
2emPZeeRLrmGriNGbghWE2sft4cZQnIfkpVAubBAayGmaG1ztrP5ah/9vn2vAXZI
qI/PpBC7ndk3tbHOHk7YA6xv/PT5Cq7IkFCtXyb3yLm/gra4MALfVBLm5RB25wWZ
kDJc8u4nPx+98nTIC+A78Q1CjnBzMVtL8lA0n7k7kH9hN2OV+jJgNtMUjTLurniH
pHctJB2CGH5LK1KLKHJkNoGpu37rGtzGGQWMkfLjd0eK9fOYv1FFt9EzmfvuR6xW
YpFxtVKN3xTpuecRcPSkS3I+OpMMyJfeDCKQQCm2FpzYwLpp5m+JcNMRLaYBhGjf
Lg3iguIWEZ5uumZV/YzZNEtGdBYDN5MaUW0RGHSm55UtAGRmM2AUFE3qReWe7BK0
IS1+OOvgVEio5Wn1Eim775aoGXlsWvXlJJzQ6ggV0fsgfwZ332gvl3olMKCkK82z
O5A0p1oVLvZdOKYeH4xkiJiy0lsO8c4NMRhrWSIOJSxJBQLcHOjalX8qhgQml6K9
x5SH7XefCE4OF/cLq+CaRbqrsUQ19ZVp7R5FgYmXyzWNKr9yA3tkow7b0QXte0Gr
lFwPQ3fiMT56J91XT6kvB/bLyjBhe8WWMtQJ/93eP4VnqVOZsxeL2475EtgEALKu
jqOgnJmDK7fO9ckjXRaaKn763HNHem4PxaoSfOPSNOGLQJkEmYsaBrL2LSQqTpad
JcjAlJ7/GqerI3R7QbYp6ELnXTXjLX6+c7wr7ksZ5ASXD7Nh9j8+QwNy+dQzcHbt

//pragma protect end_data_block
//pragma protect digest_block
Z0PDTn8wsWw93vSHeDDSMH2wG80=
//pragma protect end_digest_block
//pragma protect end_protected

// vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+FzOcewAuFjzgKBiF8zeApgt/BbsdewHHN08ou9ctTspXzedE5rjB5NKJTsYFxcP
FMV6YrOS0IduubGfOBMa0/3NgkckQJIvg35/i+IAr0N3og0GTP/qw73mGydAKcql
0kDdcbxG7Th9rEuSZRlRBhqt9yAjs5Z3VvS/uFxgYjvXcA6xNSmUuQ==
//pragma protect end_key_block
//pragma protect digest_block
zzK9Pc38wAqBsdXXsQfi+1qqbvg=
//pragma protect end_digest_block
//pragma protect data_block
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
HUxus3DbGB1ySEn4AicUVw==
//pragma protect end_data_block
//pragma protect digest_block
pF+vBidmCdRGKFg0yqtDiYXTZgE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_AXI_QVN_TRANSACTION
