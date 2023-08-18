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

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_snoop_transaction;
typedef class svt_chi_snoop_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_snoop_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_snoop_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_snoop_transaction_exception_list instance.
 */
`define SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_snoop_transaction_exception_list exception list.
 */
class svt_chi_snoop_transaction_exception_list extends svt_exception_list#(svt_chi_snoop_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_snoop_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_snoop_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_snoop_transaction_exception_list", svt_chi_snoop_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_snoop_transaction_exception_list)
  `svt_data_member_end(svt_chi_snoop_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_snoop_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_snoop_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_snoop_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_snoop_transaction_exception_list)
  `vmm_class_factory(svt_chi_snoop_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
go23qvzxwhoNVxUuHf3+AEshiMvdbl31P8MX140nyRuu1lxc4oEcgaxUcpI92Cs1
eiPsUOO96ZGlel5PTqsQwa0EPiNGrNdGViHbXYzVZrhfCIVG5fYjrpwTek64o1yK
SChWJF2+5tkMeeEVKRYfbk6mNdEJZX+eJWoV3zXjksY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1060      )
WUHV5TrQCsRfUESQwhIVbg7LX4cRsKSLUxUoVnV3UkcW1ho2T/b6ESHzSFXoGp8c
50dOfRoxnt04JOWyOpFPdz1i5a5FgYoFMH9VZ8nDqhS2gNgI6SXqCoLxfybBK+ae
QFG5TS2yR7RZkL48IFR8qCBlfX4mVvXNp/8AuIxC8iEnMpBtvl5/yVhKogxmrDn8
HgTgRia+mf3hi5bgb1oPGQxkKAvh4QGN0k+4YWBfeSnhEZMXky46v/hKBK2Yn6vl
iamAYvgItY8igMhnhGO9p7aq1HFMH7Nlsb3x3zRzbdnFNrvf4UasmirSdqT898N7
2qXgo9lErxbpSdLrZWXnXmSUP5lAwiBu75mlqNLzrzDzc5bK4VYL107mlyVhsIZm
yiXsGV8muMBv8tMu6KHh38aIkHY3DoxSX9VbgP8z4O5S4uyThwL2iMi88dYUMfI1
54RPMRPGDXSMz59vFaatBaf02F2cwQ7lQqDa22+UyxopIMuCiZ+2AjDGUM7P8Xli
sVVgA8WJtsW69r88WQrlrEmjHz8uR56MH25cGoOSYi3SrBBMzhnDmBKbxKU0kORF
vzmrln1zAqIdsRIUcEPlbUcsuyeywJpvJwAbMkv14ROeLgYtZInteDTSfjpFYyUP
+7d6TzqoA8sh3lTHncjvdfehmiz46975JZ/AKIydZshy6YtI6fsIVYt6CsZW9uxM
Lncl8eD1wxibIWbq8vzhYcWKBY3NcxAizZw9HgHbYnnksxK5DvfjoQjGjeAbRj1x
AGqj7boQJHD4yRDEZCsJszUy+kEQanuVOmmsLWTiu+VniXjRf4ZuWyIRqpDvP1HU
FlJPg3c3mfBszWGT4VW3d1OyXj6fr+sP+B6l7f/QwfCNnSYQY0sE9pg3LlFXUECJ
MDrzNOKUr9iuP7fhvAqj5WJ78HpqrDSpOiLaERsF9gTqFCg74tvXAJ7rjlGmYaXi
82JH1B9/QCS6eiJmGscWWu/o3HLuEKfq07QDZf+BdTojNy2Icwow0HUJZBm1oq1+
8ajd6g5hUV9ssVrUEDQh9/5/YqZtUSq4hdXklORh6wmUSEo58933r4s2rxIJM8+i
wd9tglFG9AAF2DkcEcdTc7XxYFmjNBh6PgxUwlW8HT6bLq8FJytBgRgsV7JTpXbt
A2lmLrr65sCFnloJnfhMfYhBz/rPatPX8ua+vade0B1u0k45WYqhS3eXXWvaoVIh
qynQiZmRjrM5wffk4s6VFFhTqXoNmM2J1U2pivL5zDXxvMx1vpqB/p3zJdMw5KT4
+OKHNNG5CoVBmMAo1vBH2q5piFlfIa9ro4id6UyrU5aZgSVVQekDrpkZ0/g46Cp/
GXdzwKQeThrzgQbpFtwFoRA2b1Ysdwk4RM7QzESO1IxAAP83pVN9swo1wwY6vLx3
FSBZFuykG4yJEkGAWl7IhQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gu0jBcATaRvFbnahBJXKu394nR6O9BJ41DObk7achObVVAOYXUiYwLxINh5JIWuI
jTmhjix+IdKYBocklek3sf2/mJD2v116/G3aR4i8Gm1WQa9vqj3uhn3xosc3yziy
I89mQHTcNZSdi1wUTeZb6P69aOr477f4U8ssKcrUrQE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9090      )
L4YjpNa/97IXtpqfZmJlHA5OnqltSMY7tPO862bGIgfV8FBYarGZDhVcFJTnsU70
fEj1NtoTguhETjW/pQEQuGw+ElRR8jlDjyKaOnMWA3+eccrR3p34XS4FUZHCtLbm
bj2NhltntrwiyMvvXuT8atLKF39K5NC1v4TViC0uML94c3ohsIX26aH4zo5x6LUf
+y+12aYIb0O7A/SMgIKLc30GYnJjqpaZcc6KBsioN4hplbsN/dLLcrFnQnv0Q2Sc
nHmC1J4+nAcVXh4k4n+CRC1iPySnTxz71EQW4N1JWJLL5BrkNb0yDmynU+LSe6eW
RbzfTm3eqUbjgNabonIVgbCohnpNf+T3rM5GIjUG8NgYg77ruNtToIQbUXS7G36B
Dd5G8ZkOuDZJUJwdRCmBodMR5nVkJGxVXaApyBU2Ls2yY1OJ4zs8+ebDk7iMMakS
40e4+nTThQ8ELbwD41cRM0+wvLB9FVFjZUaBcGid+ZHUF9gbFB9sV50YOqwxlvyt
toGMyZ2sbKDPtH9SOi2GlsBVTTftMRglgnDfQw21wWbiWlnZHr9DXWN5MA+3Bve2
xj1YAjspvsShOx5LOmhtwFyzN3re7Bo9XMjwGCbKnHcoCkL+G8fcenTObG7WFvLo
+CjLzPAqu9ypzfaN1DQbxe59Dzzi3Lkp3E52hgkErOZYhTRm1LoUMQlIFqpHCHHN
8IvFM4xd9OnXEmZfDzVtk+EzcF6Rwf3b7uvCSZPbA94ppY4oUyJA2eTnImCbEL+Z
h5+R31Z95zDANx7CDTXHs+drYNuFWJND5KY6wpleKP9SgeImUYu7gUrvkopozHAA
cRaBoxnF7WHV6cGDgZpS9d7H2Rb8AG+O9T2Vz1z320ZUqfctcLTZRh9bAGDuA8yh
eA0LuJqWpWsHXLqc7PtPVfaIUbi3D5B9OZO3FQuV8zyDCub7+UwXzW8TRqYpwLIe
9yBKmgoIrr8QRvIYmTp/KgAdx14fTCyzIDea+c4jLezJINYjbG8/LwgoLolOMJ48
IOszyNKuokQ0EY+xHvHlo7nrjnXRvLf7v3/Brgu/dHtyHRZ1avqBw/GewprPPa5i
iDXUwfRmLsOJG5S4SDBI/zfq7zH0O14Rcc2JNHqxYOkqo+Svle0utJ008YlqutNE
zITbyndHm+upgY9vluZ86onqmEuh5Ctp+3k97nckvo23T+LAUY98dq17YdmShUgx
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
gkKoSsl1KSq8APIi4mocXQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
op9x9v3euYadRje8H/cLWZBMTMIFl+33lmAGrjWDkk113Fuv0A2vlsNlsOL78eG/
wtOM2OQa/rhKTSWBCoLn+bNtMJPPRGCnDDZPrQqydZ2PJbGK1bbT4E16otPrzYy7
XlFDC2JJt0xGDlhlDHuNBM5x8AujisDiGhI0TW2uIds=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9173      )
YmWU/dripRvdVkWIlbqhWc8Cd+XViWkezI8oKrrL+JOlTrq9GWpkN0XbM74CY8yt
rUGbaX67uR/83FvmHkI5LD6qfEYnERd1mi5zyHkNpSMuCzFYGtVNHnObeAqx1t0l
`pragma protect end_protected
