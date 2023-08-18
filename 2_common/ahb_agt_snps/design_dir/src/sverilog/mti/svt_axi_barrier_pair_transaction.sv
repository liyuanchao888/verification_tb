
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DL/Iw3vNGtPpwNoeQ9yOVsInAUGk1QWP/B9haQCKqNBeWXo93trcXcQFDadyRWuG
Dt4G2PwAun8pjVQ5CwEhZKQ5lBTPlIaiIzxBl6ch2uQrqMkAdt4WiP42Txd3ZpaI
hFtcnQVv9WwgQz9SaIOltE5gAKnIf2PDKDbC7HASoxM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 801       )
liFWKbK3aWddSek38CVF4C4REUjnvUNzrsqlpTgC4ImeeVmRTc6prcR0DXgBaHjH
JyWN+jHzT3NnLiELY6fxc6Vjn/KUuFaVBL5xJxDRzpt/WR48Bd+HVlshQqIFOnlD
XurRPb4wTNfaR8liUtR1Ic0s/D62/TSl3y1H1KNVzPpeCt0FdRxVErm2eiQ5SHTm
mxqgnrpYM0hulyY86P7G8MygHv3smsBs8AFLrybes143bS2VI7LF3nasgxmUrgNe
cYBsnETsZz2j8K9rT13Ats/5g00cUIWo/QYiukgY2sxvJ1yl/vXJy/2gd4FBx1Bo
rtJko+NXjdOvWpMiweO4UsoWRJHarj5x4YOs/MOuG/ec4VZu2jthwQTd0VNxmvgO
Zsdn5K6GaNURIbTZli4lTDLfMNwt/58DH9WR3TGSoC6EiNp1tDmaVgQxZ1+jtTir
wg166dpKlgK8XE9NKlbipAcNOaBoAVFIM9A+bCrI6pUMcyJGBjT0PRerWmEHHSGZ
/Qii7oPHK3hzfuOzr2yrCyTrj4EjNaTWcMofuUn1tzl7CbgDFnMMERvc/Z9RRpXr
BcAlcxo0oL1rAQjnf4DpoxhEbwcqTTedq/+ZdFIFHptUrX4slxLrF7KZIscv5kik
VFo+jq4YFhOahB0SgouWQRLFZ5UTelzaADk5Z+Z9M3ZANCv8OzJfohI6rvty3Iao
ICbuXMFvYj05TJjNmtncYVDw+A79ja7xvWQN3mhw1UXHYG7Mddjp3vdrgVpuqpRC
tRYelr7sDOTyFV67wMKGqzOqXDcbPlPVnJOSyRw5U7ol0MprF7G48TOL+qCR0dNe
bB1IJ73XsvHdHlEgbDooGPdaQQe9vSt++DY5sirTHPAzKev3DMaef76VY6FFUP7j
N2FGbH1Nr+ytgmpesVPNnHbugC9p4bRb333d82/YWKekfuyc8trdeoDavPa2vZGL
ZmZY2N5lakMR+gxqqHEZu4vC3HullCWTqJcuJ5Z7TYOtRsK2EWrxDKCPyI1ybQVK
Ymie0QKZN/ELnUITKjaxArGUH6YTnWp6QFHZOVzWfjUyLjwAiKKP6qAkzx7tKEZJ
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QDT/I/Ep6B9PakoxiUuDcJVheuZ12YWjhxyVG57N3Jfh3PJt5oGnru0xPpPa2su+
ZQO4ETofuRoemlWOYsPc/n5EL4x+o4BFR2JhTKIqzzl+yGpIiO/Fy9XfPv9v6Ld4
SCrVAlmEvJD1HNcm/bmQ+6igfMyW02OXGP9kVt4pjWA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1046      )
WqZbNTPJP0f58JyJqOCI2kmC1nrV9wrNyfe2rQ81jfAw/Zzo9vYmIz9jUCFEbFlv
kl3QMnbnoyxjcA5e9Yi6IH0O6Y4F1Zfp8ArBk6z12bbWI9siU0w8IgLMlY+W/Spu
CkVvcABtgSCiwsm7MHzt7YKQQw0JFAbv4cKhrXJe/G++rpZrRs1SQH+Z57vXMZhn
+NpwFzj/FcBVFis3wF5rWRu1uYWvkccaHY9fU6/Bm9dORkWlkbtKVSCaDUBvICbM
hN2lTM4FzV9JSediHapkKR0hUvQ+EV2s6biKiGaWzAOiD2HHndunZqx8kptGgoJK
F8tMyeZsei4bk+OujsQFAg==
`pragma protect end_protected
// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
a3/+WXbJ2JED2cUdiBojs+9o61KXlUzrdscz9Q7IJ8cCCRc0VgGRSMvHXX0AMNse
pICZSeOJyUb8xY1xcA3dkAHRx9qjtsNoL7gXLrsCK2HoQ6uSdKilCSx04tMU3qkK
1Z8GwkPAIf4Iqs6YzpU1xNYZNH7jjbxBsOj1BoDB5uo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1235      )
5KC6jAuFkB/FvWf8/so34E4pQzXiJqOw51hAgE8SDWYnxhg20ukWOWVQSwfCpxDR
QmRAzU0Lyrt+BBinluy+WXxEucG97m+lscmXC4eJBYkY6eozBB+GGTTPTTPqnnhv
QlJpSsmpO1e4lPAfY7dlTp7FFQyOiDGhJ9fwAecOs6pLxK/3DcuYdcS1SE5B2jhh
D4Kc5gJTqvBF3IZ4QGlLJZvavbMLvwGpeqr3udbDXeXLF0GhrlxP2uP0tDgn0bxH
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gc03Jq6j7RAVjfNC5q7RTQNgGrYkj56COe37WGSdhLwJvIxlyvLGHvru1nHFYFPz
TmjD9xRhuXG9jly28Ip6MPT5+HAISGfxBzsX2pYPwrgQpJHS04N6dW8vchdIZ+Vr
ucTLlnsXFreUHAD9DsWZ7eilOUShLD2FDTzrZV15N/8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6954      )
+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
qIa8WqOOlyv/rfY/7OiNNw==
`pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_channel;
  typedef vmm_channel_typed#(svt_axi_barrier_pair_transaction) svt_axi_barrier_pair_transaction_channel;
  `vmm_atomic_gen(svt_axi_barrier_pair_transaction, "VMM (Atomic) Generator for svt_axi_barrier_pair_transaction data objects")
  `vmm_scenario_gen(svt_axi_barrier_pair_transaction, "VMM (Scenario) Generator for svt_axi_barrier_pair_transaction data objects")
`endif
  `endif // GUARD_SVT_AXI_BARRIER_PAIR_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BOAarWpr28uMdDmJlyy0qooWS/XpePlsw+eH7ClTsRbysXQ5AoWzGVM9JmQtmuMd
15K9gSWY3OeL2dNC+K3DyUNv+p7cZDqTYYo1EacIG5bvinEqD2B/4TsUx05um/+8
+Hi25exwP925sjZe2+AZtIP8dUBQZwP/7jRB2sz2Mf8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7037      )
6nhH0+Y+xsrFDCA//Bv6fxBMtzsDzZ1jJDF+asB9mQzqC0ltTAftC4rrEGiWKSKe
TfVnngvCPiigQDZzvRSivpkI9cyGxVFJHlrK7BgSlRU3NIqhYwTKpM9i+56K8F4B
`pragma protect end_protected
