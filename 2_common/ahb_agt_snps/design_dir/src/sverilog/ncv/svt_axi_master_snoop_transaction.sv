
`ifndef GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_port_configuration;

/**
    The master snoop transaction class extends from the snoop transaction base
    class svt_axi_snoop_transaction. The master snoop transaction class contains
    the constraints for master specific members in the base transaction class.
    At the end of each transaction, the master VIP component provides object of
    type svt_axi_master_snoop_transaction from its analysis ports, in active and
    passive mode.
 */
class svt_axi_master_snoop_transaction extends svt_axi_snoop_transaction; 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_snoop_transaction)
  `endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_snoop_transaction", "class" );
  `endif

 
//vcs_vip_protect 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
yxRl/w7t6vmc68J16pnuMt52k164WF1U/qxj0ombjgGhVUFDeTzTAz0vC/t0DYlm
RU2e82DU/UnFMH4+paQ9nlNGZAy+1NRvoU6KvyQlMueVxzLd+dnT6zFMc72aOAvF
1izND7vlrIXQTj7OO/dgAzLjuGd/rozc5tUL2MZ8+3Jhgn4aHQkbvg==
//pragma protect end_key_block
//pragma protect digest_block
WKLWLsBTFcP6+jtFkE4YXO5s+as=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
OqWVuwH04XKIAaSBuOeJmL185rg=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_snoop_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_snoop_transaction)
  `svt_data_member_end(svt_axi_master_snoop_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * pre_randomize
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize
   */
  extern function void post_randomize ();

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
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

`ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_master_snoop_transaction.
   */
  extern virtual function vmm_data do_allocate ();
   
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


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
  extern virtual function svt_pattern allocate_pattern ();
  
  /** 
   * Does a basic validation of this transaction object 
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YpBn7ypv2vGBSMVxd4iPFQcGgMzWzghXmkLDXJ3CZEcn+ahpH75sdUr4vDOoOmdV
cJ81Oe7RPWrYebpbH0Awib3BpB3+rlVlt5oq+sGAmd9V9TfgIMsEnQhKWuSXIGnJ
9XX0BCiXJ7xapS/R21TAtRPRpj5UstO2/E2JNz8fnRGOXXOFGCJdBg==
//pragma protect end_key_block
//pragma protect digest_block
tdBR4DrFVTMiXinuBZ2stMy4yYc=
//pragma protect end_digest_block
//pragma protect data_block
hxZvZCtV6h3Gd0yapPV84r7f0soULpsldPZa5whCXiFumLCOIb5pDRjLEk9gInwF
CsK5kVRVbZMpqRpQcc+AG51kBwXlKpwp8OTt3YBx4zxnuehdq2Gz8QlyCat30+i3
09SshdLmVR7BcliTJ2cevKW9D/fnt8DdhwaUOW9I/J4KGgi9242MI4VnYSO3LyAL
rI9HQDKRIDOBZWwbk4mMPiUKIQKUJksEnKIWGvzkrBlL8umg7LTwvSi2Md1TB5Iu
7gZFtwul/Pb5kI/gD0eb46jlSi0SEpT+WRZGsFaA6y0S5uHZeG4/sIRT5ouyXcQx
WV17Mg0dsy+2l/gxuNIvmckZcVHKyGTg/DxthCfxOlJ3A1NZwwfXaQo3kshxUe+q

//pragma protect end_data_block
//pragma protect digest_block
+rmtq7Bm3LN0Aq5TXbMsRMdHrZU=
//pragma protect end_digest_block
//pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_snoop_transaction)      
   `endif   
endclass
     
// =============================================================================
/**
Utility methods definition of svt_axi_master_snoop_transaction class
*/

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
l3kX1t+OwgxPqQysSXt3tg3h7OzLYAgEu9LiK/kq0jLkTCY7FO/uMRpukwfSLlqc
9/tsG0mWIl9kw+6X08GIpcOuqrVkJRmKRKfDlmaNQcB+IZCdStcdTJSNB8WBkaHS
AAEMEVxj0bk/0G0NvWY1yve4J0ls8nGiFuSr/oqhhhRmouEH44ZnIQ==
//pragma protect end_key_block
//pragma protect digest_block
nIHnleYOIDuZOh6YBecFYA1FcFU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
fikRahxI2mh8Mj8s0Zr7nPhgHjs=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::pre_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UtPk7BGZ0NYoJtAl4Se4kLIgzAcyNTKNQ8+Ckd26CBN4ZpYKio8o8d4hzCKqqlv+
oaSS9/AAsJMXw8Pz1BZoIHt3UyC9fQY9KVQeijiAQnOutg6yPd2W6SDZ/2alZXYW
MC5Sf8pvj98DEjSM9xLt/JB+Qpb9fiz8A5+3DJIOQ3yvP9nvlfMygQ==
//pragma protect end_key_block
//pragma protect digest_block
mFxJE7e1AekyOMLkOJp3X0HHntg=
//pragma protect end_digest_block
//pragma protect data_block
+7gH2DCqvTBC2rGs2DcRyAVWXaFSvfTCkTGrxe1T8XSECE1/yeqSdzMLg8Gwnw9e
Poq4h4nZ938LZ64v9fqKVWkz4S50ki/nJeNW5yjUxr2ubcnUBJgOnT/6CR9z4/t0
GZO13liESOT9wTauBsxUB0w+aNnq4uiDSkM5ewGjnCwG347GFjFlSZ7sJCS0tZow
sGrHb6Gg3suCiztAKVUXOklSg90ec9zyNhl1oXLRj11L7QmS7q2HXWRpLikYkgKW
xXER8OAwEI+XNTdWZZTOdejFXEg32rTy85pGdvI9qy/JG1EeQKGolBQWEv1NbQwD
K7nQn80EbFwCfepc3kY/v3roJNUQYtzFYofv6v/5gdzpw28Rg35WNZCVm4bJJ4c8
o/xDNfSZ+vXCwKqCnXQpM3aDr0ow6GLOg7vmuUSTD3qc8Jl8ehbg0y6u9/UcrXwT
9XN/y1kHTglnEZ+5qtd3oF0dqphlCadY/xxTccRejdVHcFHJ+uOhUY/crZXxF30n
xWiPA7mMv4AP4EGJ5aORHKBTV+XFKlHtAnJhBu4aMCs=
//pragma protect end_data_block
//pragma protect digest_block
9JflgCtCHbPRb4RuPLvJz3G9b4c=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::post_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZOZSp8lQ03VVfSKi29gs8d/Vz+5MBc7GFsdAvJ9gvaorknnijT0iK+7iNJOvBrQ9
QfPrwAAtE7tKb6PoAmRBYxLCXBHLZUIU0n4DIarfmrj870Nk8MhezDk7GooHcNUw
789UpiGy/gKd0gel2dnnBu4nyvcbAfeSnBe4joPMRUB0DjtE1k/eHQ==
//pragma protect end_key_block
//pragma protect digest_block
JLAQQlKJ07izQEW9AIcJ+PPa9QY=
//pragma protect end_digest_block
//pragma protect data_block
4XwcD5Dc8gkmldygRJX1YH/1Zz1DfrvIQwuYPOy1Gn4+tv3S/EsqrgT8Fpb/tnHR
EwT0Pg82Jn0Ay1K1Wg741LxNyrrKXy1WYG61/HZSz4kYgT6WTRZ3Y1DcTqq9exY/
QHFxcPkva9r7h3QsqJHG92H5vQfjQZNVWW+Lp0rmHWbxT6kud92kkeyPY2LrYyg7
LAlYK8oVkjxd792f2vLDGgAYCBgWXrd3clHIPEqICD/nZF24q305uE60lEkm8qzl
C70wIuqgsHUKUn6YKBGU1HS78fxpvW1SWotZCxMm6orgouVuSuT8vg5t5sjcLYYg
NHuR1D2JUakf9Rz1rfVrX7fWkruzMKhWhx0W/zBnBmU7XISYAlyQSzYsdVc6NPR9

//pragma protect end_data_block
//pragma protect digest_block
zkprWa75o0dbwfHPbU4Mhd92fBQ=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IxPc03ZTyDq6V7q/ZyCbmnQuBtLqbWqpq7vBydCmZ3fLt9+ajwmtdaXNumgibYNv
f6ML+UMME6V21hgntBmQFruJcqFDG5+5mZKxGM4i3uJduYaN7ZpfcUavDDvGm0jN
3Zsx3fNaVBeODWKDgKaKqINbLq7jg31fSj1v26sMRp3WLhoga92mqQ==
//pragma protect end_key_block
//pragma protect digest_block
7rm4W0xhhhvUWVHT9BTPHYCDdVM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
mj4d0EGLki+83I3kxcjw47aNU/M=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fP4R+6trDhlq1yCdQKN1sPlKn7xUsb2adrLugmFtY2CBxuwjeM8vZf8P/8KDdP5I
NJSh2LSJWY6JGLVCOV5UqsV9/eilRvhSLg42bCqLI+SAJ0mZMZYcyV/XXMLTXvvD
8YFo+IVHVsYS5g8Mq2sBMw7F31lQbdE642w2butkdlOnokyz0ef9yw==
//pragma protect end_key_block
//pragma protect digest_block
N8yctjfXLq37Gfo0QFYAsZ0FZSs=
//pragma protect end_digest_block
//pragma protect data_block
dSbEtE3wpz85A6PLBEjD5lXDHlBF9hQbziiTF4t3OrzIUde+lB4ldFObUf0IJ/u6
ruIuHSru/Ne14JYU9tzM3SRnHxFsfH3e/i6DQ0dAdglyy9R3bupyoRg7824K4Non
KiHK0LkGmHn7lo9hq0hG5EtynCOLrzv8ky04VJjzcy6AGZKXBafnF4nVzHVsaIQA
q8GphOuGvllV4DbFEsdtEm/xt3OfELbsiHbaM771dXXIrf2MM+U1a8Dlj4Gfxy9/
Kf5D5IT94V4EuZlKpVqG+iPQFCMn9lpKr9mO3UWg1jKhLPkfvSMkYDgdAxk6UwgW
VwqVycD+xVGfklEeA1R+0Zua4s4o8D7OdbHJLja8VsXfoHJ60B77O/A8C139Vi+1
g9eM5I1DZJoNe6LnUt7XyjOv+DQR2suAcu+JSZ1lg064UN5anmgoFZ6efgA2c3wh
SPHoeTzuxPdSBlrJTTklTrVRHEvhDsKesbc61/E68yDJOxbOmQZsaWDYhAk5sWgf
PmKgresmkApCPpsEOEYwy+0JXZJJyAluYWT3KKyzKXJL8yRHrl5Y155sZDJYGtJ5
Niqvov50qRGhPGdESdGCmpC9HpUfytwO22hXSa/tPITm5Qpk7JyqYCUUXZxyI1Uw
efoTLIeVas6HhPrEu6IAl06FWLWpRJ59klHfO9B51XMeNzMmZ6SZd4dQ+TgiURD5
aO2ziZqogu5OU9TZ/ut/AM+xZYJGruPtK6P3wwsVMXnadOvMtosPsxeaBX78xrqI
YSNmmHtXk30vdLbM/f22WA==
//pragma protect end_data_block
//pragma protect digest_block
AHEnz+yw6yHWIORjA7OTHRlByHw=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
s+JBTdVmKpoPGnxffrU5rENdQx+UYsAIAoq1txmib6EZuNSQd6BzEywv4/Ngg+ky
wC+6MPZcJ6jQCIZE0lEGqouhf0vZJWB7pAIyKVVKyfuAHOdIfKgTbcYaFnWU/6au
plYYmw+qkqZb0+EwYdtLD2Lqer7dp1qhXbUvTwBwkxYsaLuR2hK2tA==
//pragma protect end_key_block
//pragma protect digest_block
EfLFD9pI3YGAK87ul70vFDedw4A=
//pragma protect end_digest_block
//pragma protect data_block
GSZIjq8N+jgZB21V0cQwhL1Crh4Ivrv6gBHZqx+4hHe/luP31CPtBC9pwPJZawpo
FYzUyOfc60oNaYUFbd45T1vsxgYPLWBhtOFoouZ4KE2dtuJmXU4VM88cdBjM/ryI
DQ8qKXeWyjBhG5oQ6XoXM4kQruquuSkUj4XD/ZKnw70Z4fDmdaDiC5cyIT+sl0+3
7OrbaPkLknQrtIMQIL8Y6/2SdPXxh5ZHlYkk068c2hVwEf0N2ooXy0Wnqn2Yi6Jm
O3Qay6mfmhibWuvpNVZyOaVt429XZS9IMEMZxgJbizD/mMRU6iz157olyobUWdVL
1G75gYJOAxpQ6gDVMEqNnAITy24R0VtJ3+EaOGjcveroN36kLawHtmxoqEIbEIsp
/u4YaSAmDXJP5YD8SalyLxqPRdFLT7hTB+G9W6nP5QMTHYOmKqPh30lOpf9qX9FM
EUrE3BZPyb+Mvht9F2XKX4KzpKz2EiZ0aFrPXKDxTKrFM7alZ45+m9A8/QI2UOs9
5FVedYrKJkzSGjvWNl5AeFjJNxPfXT549aButoOlicg5FhvNhIqUQHXnRjnIiUsV
JP9qayq2nPqowNwFCxAF+NrEjY4h79nolFwXca4Wuar6r27K22DQvTzgAAiWwpWD
7ELaQnBoEK2AVvJd+RSUXQGQhSu8eQq/fqaty20Y/6DL4icYMAyHbTQTUjOrUOCv
u4Ghs2efct2q/aKVF1THHzCSnxFZubNkiwoHRxuCyUW7gt7cZJV+ojUMM07KjGOC
9xVDdqCyEz+eduDrIkxFKfT2akjUzxVC8GEo8mCKiHASHOLzhrtHBjhVWP7A5UUX
qgnKcpXK8XWzg2zwTbDcWY1avaiGxGra3FC9vYimL2IVrBeTlfcHim40Uw9XOtLJ
uOb+UNjq5UHyBqP+NhcyK5br8+RSippNwKy/UIrrxtSO7feB9yqUwYWhwhn1dhR4
oqGwQwiHrVHyukKX3QJDMbEb4QQTWRTVl3VFYr60QUkDb7yIJS+6OUYcXBr8jAjY
cki8qgnYJVttyDPjXMr/rInVrtlNtP+uRZF+j7xOd2dR/1ZjdnYWCneB9v+z+EFO
XNveyVYgh/USKGVJPqn25mPCk9ZdEDt164Qeu9xQdy5C4G+y6JOb0EQbm31y3fhH
cgUE7vuCMz52ldTc5OZRU6Hq8iKKe+nOh+4oLXFFa5WXH+UhMH2F7x7HcJ95aoDq
WcEdrJxI4P3QBYUAUKfgm299Lf7LPYJSRWTW16UZrYfZ8s7sCsOCq+JwjPTigVIo
EFTD4XO4enQdFd+dMdTg2PpFI3sIpgEAHA8wzo5K5aLM5cYRTJDiO1mNZKCkmDWt
v6BR0a1KIj3HBpNrZGEVV1wg+UdyN0WiNdUcU/0sKc2qmpXmNe9kv7ctSYf2elje
mJ5V5NdcrzTjivm+9bwIWSRcjakzvygbNUZwHdLYUOP6aIAZbKhYprCFc4VP5ugx
DohfhYsqyLXchnLQOp9LkSXxJWyZrTf/SIvbtiXn9jeFRVQq57rImAi+CqUOvsmx
QyhnHfKinED+F/OFpGyt8Bk6LkJt/Nl6qpyhIj+pbvZRFlW2ZLSKcM2yWyFrxFaq
NNzObQsDad8aq1zsxjuKY3CvLf+JDUzb1U3Mag6W/crjOVy0sNXZ8Zqis4WwzqX5
AHFMsgnb0a7hiktO0RJYA5EvYNPQYPxZZkdGVXBtDcNtp1r+oA4VUnczjtrTx3Db
TsVh1hbK2OHLq5cHHRxmj0J0hPeGMJw+N054NGU1XJLtTxAQatdblqoZypRNCq9H
I1gb0CUmcRcC8CFR8C+VoBwBla7qb4JsWSXCYrL4yvSIWwWoHIzWgmHdOzeA64oi
DXnaVR48nHj+XnELPB0z/c8gKXF4jeN42/WdZoJFrA6IWnNn9XqoVyDE9QJ3l51h
ItCMX35wgQxYdmqSzabLdk7tT46VXqdnXXAF16Wlkbo/uv+cSIOUaatrvHfIiJnP
zXs+gIjDQiyiLyGF+foBFqtxMjBtA7SGFPX+kkQKJoB8/oZSiGa3G8YvcFgBePQg
fAL93+GYXEufc9gn4bzpAlZx4fFIHjpf0gf1+TSUTyEbol9bMN157VnRNYZjRkZM
IzGukejNdkowWR0vk6RXFMLMcoAic1jLritnynZBDhaFNjsT3n9vDGA04rQL8SCq
g/oJeSo9bf/H2t4JntVCNS1Gya/AJ18CTo+pWlOAQI4AbL1fzUKuCCVjrIsC9+bR
riVXiP3r3oCv1reHG2ItXULOojYQc2veVDtho31Didq5iAU1ikqECX25G3UsK1Oy
4+G0rjWl2N8h0lBZCeU9gbAKe8t4Aa5HaGCWN0aULiYJMKfvybsHZqzG2NmWxe37
tZufz4u17qdqc1e7qIGuMt6c4xCqopHfUOiWnyXDFGfR63canIHAOd46jmnuVNYW
9FNAuBoiJuDZ+OeNm5Zk5lZrP0wOt5ohN92ScCnimxcYw0Ksz6V6KtByDMhZdByx
Sl3WS15+VP/Fr0GIt0CsOfML9XxdHIlqXmDMW9p5Axu2wQyHq5qx+C2QNY4OoBXM
Wd24bjmA3Kji24vpiG5pb2cYdsKkXQnIyK5Y56DhEJUV6S+SiJ1o6xuA6FC4LiQP
sPN6qdI+VPKOqbBgoV1BK5nt+E/Zdc0vzUui+ZsC/uXNkC2W95SYBMNc0dyMmfPO
FkfHumnOKA5a/U8LDpPAnFckHeoJT5DRwepA3AQ3yBLRzxe8nVDemjXqOrZV3oD8
sY4S4KoLk7n9ldJLaE+tuPVPfKHSmbScZOODTXODpHAlj3VoRdTNJkvyJwE3okxI
jAbHBmsXouluoaDDRyiIf41hTO72z9BqCITYIfXPMkBxUnWFnON1lCzXntYxsEAI
ZmSvcN/3M6FFuAqdUH13KcnydXZtVGWa3XUnFWHt85zyqqt0X17lVjuL/yeHEWvR
0G2asYH2ICfRPRyxVPI3X5PMr69XgaDrNS4ml/4SfyBGeRK64QEshAdEPsVMLQAi
lA4emL26NLPTNU+E/thhYVdAux8OxCZOJ1L5irZCoHMRvr38EtrXvRj9Li2+m/js
+ipAyPwastKysvuegKAeRljKKCjVTv6fhtIysj4XzATmus62Bi9aC/3wUhM1fmFg
PxqFFHhNpJJ/JnpARBoODqSt4L8ktfW1YABZsrdzuNY0VEyVD6GC7yJL1fzzMgcE
nCYfRYaAlJPu2Mp7U16tGcJF1Dh/33XiFyLL0r5upcVjiTgw64LXrACsaL7/VM62
sUAxwBd540+ZCbnaLqVlfESOLVhPHnpvLfW5ELoXX3ws17PiDVEDdy6eWjMnnR5B
uNB4exbaadpAo6iuPORnfrwWW+f9jodRvMo/b85M8+H9LTu4BxnTIvIJlGlMdiWP
noewBcJsneZOWJzuGc9r0s5vh2L3ja9n8V74ec/mjLckaa9399DQ53gpkWPlwtlO
vHhX/cuvKPxM3R46LPtQZlh8P3Si08qiESWC1QARyH79sC0SP53hR4MMrqaqPopz
oZ4U9vxTh7G7qAgaIZHVdDv+oGDKpCC+0dliQvcuMWCt8o0ZhNPvVGBx9w/KOVdn
rSA2a62t6tb9igFfprhHmBtGSH0cPGkfDD2/TiTusFz3D7zYADLhOBwNCOr7MeMK
jskXmyutGww2r4VpZtmrA/ZCaNCdQWXg7ERGNIDZSYELudwU326yKXeqJPRfGQlH
FiGgGIPSOIRMNw79dD/OOPJjB9uJvFA7/Syt9Z8xAfYezdPddjd+vD4wTnVa+I8b
NTfQpr9sjzP8YCMF3tU1S4ndKj3pDyKYPJe6Sf3+XI3UbXql4dPa3Z/HS3o6Tzjr
i3qglY1k+Sj8LNGXlc9dUNLCd8D06T63vahDOf8sWpbjSewDJ4sLLL+8e8Vsu1Qb
MgbdiEuG98iXPQrST0XEQ4hBx0Q/1xSzzph+FT40H8+oGVxaiFCgHDehb52uR0xq
F8mMB+byM9cFyc5AusJnHMXlEEA11IM3oAcPFQuH5fKH32yh4fnv00xD/uv/UTrj
hvWGRJbUqJ4cagCUDTkT5EfACPkK44fmSgUCKGTz3RdBd0asEkq0v8WnbbenGS6M
IC+pHXmbWiVVafFxVoFD/+BsMIcH6fZS4JkqxL25GOUBCqI5Dv1tpngd+2spLMoG
f5xNjOdxmQknAB1BQiVLaba4P1Zb/3mz35BMfZa0PCwjekhNEIA0OsU9fWVJHQMQ
qoBE6X093XlbOvpmeTrkpRlTTiPMXaY409CR0a9VUB0kTljojR7Of7WSvFwdynJJ
rfX1XnmnG57F70DxVlLP5AXW+U3Sc+2iqcV2uTk3XpQeH2VgcYWFihkUNWwvoyda
aDI0o/EePiWlwcor7pDvzdrkFo76W+CRsMTIxd26tsX4SsBVKOF6EAWDf97MQaA4
a5hmXohh+OWVpTmt0/gEPNfmjaEWVDvsVNsaUtMckTiWsAClrPXrbboaSYx3/R+i
H4ykASIVUmo/Iwx0FZ7IdurSLmVPw/FxGFMzsq85zGAIuD2zLvVFlH1U3B6/Q/30
vJ+rTnPZCRxpUI2RtgGS1wkJYp4sGt08yIVQ5OkwUHZR6YzLSeaPGiiUJWbbzP80
bwmsLSRkNZUz3HckFrsVvOdVJrQxmJQQVGnX3pYN722Gan+w/hR1X0VpYQJP4umo
2mA1uwbjk5VLOGcRLvQwj9n+qyl1iS9RfJJ5orjWxCSXIU4JN61+bYddZUtypxS+
PD4K7SZUwJuPRq3NYUvIimWTplmSzBQbFnC5gIOPT+EQP4U32N/QYv4YX9aSzoGM
PlTXS5wltaniFlOs96cjzMfe5lC2ng9++AsF3k1jgKl5q7DPN/gE2H6bO3J/73Qa
DaOdRk0IJxztznqyb8E+fobadf/ocgM9iF+ej9m5oG0lBzCovVQA2rkqQmFCfuOe
2wNSZNUzm/fl+pyNlsSeug8yjIuQDXtO0m119+9v9ili9syY8W7WyfP3RvSLAGAw
HMEHV7wLQzzMJk87fGp+DrgxwDkqcrbhIYugL2Gwf5w73QNREp4X7ZI9B2UZZsu9
VG4s1SHhXj4YXg2Hi94ESS5dcLWUb2j69vzAqPTWwwbNwZPUEDIp21xyclS/zCsx
k0qCxpFQJ/LPMFlRQGWmPntVhixX3yg6cQu8w9k19nmfzucmOfD3SB3ivkFNhl+m
suX9AcI7rgf3MqYmFA3P2y1SXUn5rMXoDRTHCXvsX4KheNseiYWpujB6O4e9gOF6
WHeISpdqpgTYnANQn2+V0L3Ki4afRyJd4ZksqBm3ViEXcuButudXaiHNMrqgpacI
TSkLm66prCOL1v10zIntjXncCSUItztOY53mZ/fNYTjaD/LQPa7px1veqKLAaYlL
JobEEBdstaLa9KBcQcoo3UTQxqikZBvshdQy6Tb7dA3lcmESWVKVIpnKV0p4CetR
Jlxtmel0qQMKpn8fHDx74UvZ27AwQpvNnbU/e7pUKOAWqHrM7xwhQ4XjkgjbZrDD
od2LfVH6CReek9KCagSMc7z1RlbVRJgsefJdw2V6ub6oeEPA8qNCRh74xbbAnH3I
XRI0dcb5l+PDVrYTxfy+/n0zcfUaf1h+trQSP9MfWs4b97chbdGbHJ1MknOqGTGL
9+QFvdTFNbNI/RZRv9wObd7lcPP7Ctonm7bg5jFdrx3p+Vr3xDvNV1wM2ANphWFT
DPRvs/gQJ8DjoPTRyp/TlS5zK1NKDPNbMOxaCzM5Xp/QdzmfqA46L07hCu7cfixd
51qZRlVQ89H+VsktqPj1rgX5PNMy9obxNpAd9DSNIp6ZQEPYWFzXASj/Vm+qb4pj
Cp8VYcRBtdKcZ1zsFSNaXbh8PWLhjkIZI6c3C0NXUITA6FCq+VVZibNK9lyY9piQ
UcOphfckbJIOJrEXwSlYvyFL5wZJf821qVFJM2yS7T2BbApZUtw1opsO81Plqzz3
KX3QXjIX/bEXwPMsPqCUbaKlaCnGi/A1m3yZE/BTL87jO71I+RDU1GyPqckQCxKi
41/5AJZtSMwsBgVIgh71hzuVLENTTx4YwV4exBqRm4UZdlZ68+JHIcnWNbcdx4mY
KJaIy34VqdyACKrXbEtCNyVi/X2l9sWzALutMaYkuSYejsjUKSxJe8m/TtqHZMi5
NrTo9bxzlw3u6fUhBFPmKnn1ho5p+QTyi/vJecO9inIBcjvSNjfIHEPlDYDQ5jy3
jhQ1ZTAIzGkGMZdW81mnA6JRejIo+r83c9XpVT/TlGqxEjeWE7ROnJAVi1IBxi4y
zhDFD7UUzNcjnparghtKGmUpPf23ntUiWKJJYJg0HNkF+AlJqIa++TSXSuCek4iW
528sIkjxH0NtxdmkoliYGGfbh1t5gJRZXxOIAHTYc/88KxyaitbPZ21oVB2Pt1jU
JfVAFK3ssWfcU4YC5IELnoatEhEC6c0uxbhnb/AZ4wcnQJjEGPRHF1FCXUlISt3s
g4qbjUgxGZwiTcr1MlXjbj02gnCI0qjKNs5YEl1luH59mZ5bEiZJ/ZLNdMuEQhp+
gewbtm7NRmu3m/XyPRy8gaDtdaWYM9c3t5ogMH50pd7n9PhDFuQt04Sv1ZyimuVK
0khQulHVu/V4hroir2dhn83Z/iTZgEi1d8gK0A3RIFda+DFLbic/TD6NJ8bUMJ/G
uKBpvemMR+bBivuvkUw7ua6H/EW9S6o3nH+APQ6Kj5V8A7gVrMArA+MWf+MwFojU
LPQennZsHoFy9EyVL4XesdpDiEIiqhdoP/pZaz8lV/dKFHqctCkoDbcSLYFfx9eB
00fMz8bPpoUzXXSfZDZb55gN+JTLnps3RQhVXkVRK6jlsPbr/rAwbjf9tGlYfDDY
FVYgivRDFJYBw/3Tq1XHamg36hsT7X4UdSukxeBsS9zHpSgbkZmDLLmt/slelUhC
z2LlMvjwQDR9ggz2Aq2BnQy3q8kTrNWlEaSCKijHLfAiOr+4h/ATOvk3/I1LMCCI
5NNk0zWrjHZ70q/t4AINjRLG5bsT8zgQ3noPPsY//+vTjX9Bl6GZV3K2NmdJpDAU
qYYSSXwEzXJ/FmndjEpJ8ETVTrB8lZsBMLOigTBf+ViKbhp+ViZfN0sl4WZcvt9K
ID96+cFxLhOys9/rcd+WPXx8Rc/dRfPRd7brctYD7NdGb03mHdUT+P5Xf5x6TCO7
vVSsenZE5PulCbGDCOqxtXuLpRn/wIqSYompSAb+DcPiBTMpXFeTZZ+/pJzagQdA
7IR8lubd8N9JJbzeVIHR1MueiEOGDA3eQFy6IWQ/Aep2PX6tySlu/48DrHXPgdg9
/+rtkirN/PQkLPFbsQjrIB4NrpcwDZZJD7DCC3/P3MZvF5L4EE8HEKrmBwJtm99d
cMW3sJn6Gr1K05RA06ubnHyrXxfHtILwTMZCjJaftPkZqwNI1xq1EIkY3uLitKM6
FwksPVMogSLBPHeou0tDFlho9ElnfSWm2rL2ypMmuc+7+3iLUa0Wz0TRxJbs1VTR
rXoWY9HvKvzwSUD77+AMJyO/sxG1iQXXiQFdgLJK0LBmPRVLfsgnL4heuV0vsMzl
f5aTLEQG4jQNgrnwaetPvduUWBbkurcLmHwLdHqQBmh+aBCMHkal4TtrcUDJiUjr
JkmhoAXhhiC+enz0dsKJAhV6EFktQn93F7QZ5Clh56wLxivXiCzUwoUKhx1FXSu/
KUJoCE3kVLQHBeobFqGTcMMkB6/QBesZFREEOBmW5Ztr4l29HkLeGlCI1/qRjN6Y
skrhdGMvV2Mj7Rz17+le2oM2RY4Xe0BZ3nkt9D/+hDC2kuimR4X5R9vIEqVy7izT
aqr6ax5uTrt0BZt/QGtDoP/x+F2JM4mTgwDKNpDFEGm50s4KVZcthKqWoeaCbouZ
+pdtfaivThxpPWFOr1Y4Pr6ffqhd4r9MmPFo+SO2K/kYwQWd6gujzbYD5SSlo873
/Nxs0zEOuMzjtiBv+ByP+eW8VIzrPyrRwJhoF9bFaJKdZ1G2tkmihessJmPnFfwT
At9tTxbmbMcifEcZG3Vjj28AuFudMMq4cm47VOLmjXdZ3VMnjSjYTh61ujYqXKE4
g04AYUYmZ6p5O2YMvpc6BiDQIv1NN7o3oGZrCMBSNNQu5hl2cEbehjgSJOlAUwIF
YorXSsMq0pLVzMgN5GWVqMyP/NXgYzB/gjF3ULp86yBh2510e8qSMLPI86NGe9X5
SX2sfVEiY8BdnprjujNShqeApKchJFvLx1cEngZVbriOk10zdM7V789pdcuuYLNH
4o7g7tsN30k6qbIDl+bQK9+YE6oNVDTxg31/zrPP/6VMCewudoeZ30WS5XXTSJi1
h7CB7UzleAG2RBA3ZA1X5I6Zs/WkzqcvEfxp/0agAZDx6u46DB6MwOgD9oXq9PhW
dGyiBPZ8hfEjwp078B5TyzhevwShCzc7c3L5NnZoBkQmhCozvKxbPtOY7AgNQjwL
JzJkZvmjTo76IgSfe13o6eK4bKeP8ErN2ca90e/sG9yp1ebPmLOYPH6yQKUAhJSd
4NV50zyzvxvllxbSeVbhKC3jcNQn1jY3DwcHO1Xjm+4ePSCfEAPo2spV8sYa7ymF
L1oWZyfgTVHNfwlbEpQfIrIyF8egT2LqR/eWHEGsslc3CJ9OahRqTJcIbVqaevBp
CMSt1XElQMgc9fWbni1xy3Bi0GKaQ50kgQpVgzTaCJh/GZbjXZh7qjXkuCxz5a5W
Tk4wsML++IExtIsYWjX1gmfWf7RuZo/L2D+ijVe9cYAjnE/RM0C0iUxS/6FgFTPs
6+XJ40/IeeJM1xUMI2W0zXnioDZB4H63lsfjSbDdHkCQObp7iBcSkOQtB55R2ybA
OdiMg94EaCLiQrHUx/s8QTA1cUEPWubiXHKYyG1fwnq5KlqqHaWa7qXjWx98Aa94
cK+DzqYGc7hlLgpdRje9Xjj0Reib7UBnmRTPIHA6dQemsFNj6iG/j6njvgZxNTq9
m6GD/wQtAy1bGLqRv1HtALKGZSU65Mp7y0M9Y1sFFKZTLHh6FLn1UBzzr8JJdDj2
LR+isgHTMXzz4zC88JTo/ArZivy8A945Uwtdk7BIyhwoCbbACehlonBpkC1o9hKJ
lG8OCjwbpunjD0HgeRCINhsakd9Zn/qcjbxmkL9h6s+zPl27d9caTEd2cwgYEB8o
tCZyWbdnSaVCh6jcuBFFpvvJP4GVT2fqqf572RipZn7H0xr4G7DBGi9aaqPDbtAB
7MnUWVJi4GOLwlaF4lcmchQES/KpbUlwqW5cIGt8I1u+T46m/Wrzigb/KRx4Wjw+
pO87VCp8ure+Y78Nya+3Bv136K8pMra0EiC312wPxXb0ZCYmkdLSE61AGED0woSH
srF94z17J5P7EyNlz6W1HXBOGg216+lgjNjOadzkOHiZ5scGMY4qqv5iU4kFGS4X
18Cc9sW6UKnXurcKIUhjMTL3mLEuXTSdsEfhVpPqNrQU5KmEBeXfi4Q8+rlmhpo3
pnRwD+/rvTet0QFlH0ojqyzcoa/41XN/6VytAM3gApladG+kDcfzJGm2WhN1VK5v
J2uhzwJCNGS8DXMsI+bjdCUmb56TMw3q2MGY7Osd6gPpzbfvI0cKJAejCbzpqG/l
Fzzfai3TqHwOGsmh4hf9onzehGSuBtL8sZL7+TLow/glrpEy997wel1ak2ZAuLyg
0mY99BIK7pE0ephNW6o2yukEsYfze9gqPOSo+Hhh4xnEWU4mO6tLehHBc5FCM5yl
HjmAfXrwH+J8wMNW+ykcIIAkI6PfTXb2aYKlz+8Dsve8o5o7elXtmUUj86VDNJi4
SkNkPNOff0L1cwZ904KOPIw45qojOrdNf5Wuwjon89GDaFWnoHZcazBkspgTndaJ
QtjOotoAfOe13NgbetPTvF1iynr+ytIUeiu5pU4IIE3jedlUvBEX+tuXyKbVrxyv
se1ZqdPM3yo09duWm110ffsEkX9SANRTqZ9k/RV+8qb+leAx0zJlccSz5x5wGXRm
WKA0uKbieFlwag4+Hf46caj7/3zPc6aKAnyJA44Z22YcFUhY+S5535UC809L+Re5
KLXLLo+Qcbw9SAakuec3mY/EmAedpWx++tU/ZX/UJaYta2auFVZoP+lHFAsCCVqZ
V6wvDAOWEilTuF92k6w8nREotZMW7SfjUuFKnTzltw/zLz5nf+9OoIg4QvSnFKNZ
w+9iSCeiw2YowLKKuBZZi/A9ha39f2AyFy/lD4t7lNgrEsEnqhEWMmSPzWf3bD2n
NRpPXX4Ou+EHc4ZDwFL/tXnfDRHQItKJumeaK70X7nNR+iD9dyBDGi1X/8UvRyto
CnjCtDYJMDNof6PYiNelYmoBALHyMt+Wn3qsJgAgxL7phbZpoEQdQqd6ni4OXQ3d
qSIcwwb+KWl6tgqXmSUOfOb+KhqaFUorxlCRN3NiBLQQ6VemQSd/ERc2JhVq+v4o
M9f5RSn5auCc4tIBCsWF1TjBmQzG2A8OI5kaaJmp7b8D6tgLUfvdQK6MEYCX0ynN
42mU4Jd4P9CM4rCNERx6s98ZvvE0ipw4ua1kFwAmiJH1amSV+OsJqLHxbv+EMZKU
rUZj2PjuaY8GJz7YVaW8TDD336Vvkm8uFy7GbKvO0FbCg2JGfCAoz5bkwXyOJTaR
7eDQRZtnjTpMHlzKesKJe1MzFuC/TUqL2qMNcezu0/hBIXnl0nWk/wwWSPAdisGc
GehNmHJGvE3Lt1bMqqB+J64+oNhCdokduT0X4zfz4d+VQBeyVnekn4rov0lXv8DL
bB+dsTRc6htvKpqRI0IM+Ho5EpPuLU4TiX5cDV1WrCBjuGyAh4uqYa/Sr0+5fW70
GefvSoErluCBAllJiU8fEo1EfU9RvuEJffunr1SudQGaI6frIkcD1jemvBDXIpS2
H4rtBTTQiE193It3nC/Eu3NlLNq1dDdfhEUrV3LTMixM0YZs2p3l3JHozoYScELQ
riVw+9BoDsTxgaFvdcuhyVAza+O1xoeTEaQF2nU86JQCHw2nGMAvY8v5nQtOJvQU
dl5upuruRhKARhhF1wRLsg2QWS5m4Ao8+R9wsLyuxpof9kpRQ+0/L7c1MMkqUIzH
p322f0lxBe/AmGb8ARQziDbPkY3U37cJnpQsJNEKoV8TkwWypB/JHKiN8GCxUono
j8pkgJTtxlQ6H2jTUEZgS62be7uyfH3JkVPGipPHCTwf4SWifyoPQwgl/SlsTb6w
PuYYDj5mkwvCUis85aZebr7C2ESLUSE87s2LQ1WqVBbO52Qe3r4cztj5YFuN5zv+
KLw25eszsKozfYJuPzbLlLE6tuCsqhLtQfKoTufumOutGAdxly/RA1p4wmCf9qEH
abBwHueygdQdqQr3jOFwdtEsESrUS9HS8gmvB+3W/emskJI2qhIt7OFjzQJfZjFp
HwQ+1AWtMzslR4T6EdeHCW5UJ5WbBrfKdh+vrPacTCksume7AExETZJ+isMoK/Q9
fpoHrLSf8TTsno+MFLy0gaF51hE5xvAK3Q92KleCLWDaw6UluqRiq+ZC8UC5dZA9
WLZJTpC+CggqCyX5LICTN3iw1JYSW14gqhaWF+V/QrxXaLmAbUXaut6JTH962gkr
3+vbK2GSlejz/3UGEeUHEqjnnmMVxYk/1IgKdU8Xo7xp7pZo05Fglpu6zkrF3hAo
ZmHmSTZEItc0mzCt0NWiQny7V1Afyu6tVLronPwsnMXQPfeFEkS3zD9bR3QQDNBo
sCpUjSW+rmDZdZdzouWwxyP/tszZuUD0QxP+S1dkxis+Yo06X5jxIXD6BLeh5fj2
6/uPBnmhXLULC5tutnfvALRhwCS3y14IPEYUYxie02iJ3VCmifY0u54HU1Pu8JXs
Re1SkjK+XQD1f41UoHdHbpeA4jn13f0LONXJOERotWfYV3Vd2WjsnlPPp0nDzxYJ
zciRpB6z4GJVGs3D2vDbZqxePrTa3oJ0fliQKXGs7WQYlVy4+goB3sYcq82Ivc8I
foxlJn0TkKgdJv6jFZbXKs5+ZK2V71efkzn9mFtG0bBEAvhkFSLRDtjMeY2+uVY6
OcdVAyu219Zn5rOEvG34QbAqctcNmHpZ7Tae2J794uxHhMdQUUNCE2d8e42IRPzv
ZVgUhKDlDZwtg7VbE/RTGFRTOZaIkgpG0mI4lPix/6ndYjaFuPmg1YPukKO9t0ZN
bwmF/27E4dgc2BR+XedtwFD7IJBblRsIjOWrxuBbyvHD9sTiKmHwhbCJfyMQDPSH
eWIJ2pPdNG5t9M3huWqMugdfZy2IskvKmWvKKGmbt9JlRbY1yYcq6fmF1wCrI07p
xlp+FtGJEXiV056tFq2oWCsIBtHKa6NcATQPKpTBYSmMWFU2t3SG3s8aFc3Y078t
Y/g02LZ85qVvRhKxfFllPtYoQAZcxA7L2tlxD5uxf1vBsSxrg55XGvLyNvClkO8N
kywWrkzM6wutld7g/wNeXoRGYosg8o1v2PpdQ/yl2N6TfJ0DUEmFoPoME83CK8qn
AqohpzukgxJQkc0E8lNfl63mj2WWSLXSztXzlP/lTcALwc9+AwFzCUTok2gKil5k
6GS7Muvc0SNQ6v3JYNXX+z7uu7WL92WG4WgWdOITI/8Q72B48tTa+xGM361pB0KU
JZE6mXwuq/MW5vRvyQgYnsbuVUiSXLt4Gxc6fp20rDV+HSlEP31xEAu9urjwOFc6
FMkalMx4FObN5XeMpuSVf97YgSYg0cMHR49xiC35Ww4=
//pragma protect end_data_block
//pragma protect digest_block
mh2worlZ0YxzdyUCdExAu0kDquk=
//pragma protect end_digest_block
//pragma protect end_protected
     
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_input_port_type;
  `vmm_atomic_gen(svt_axi_master_snoop_transaction, "VMM (Atomic) Generator for svt_axi_master_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_master_snoop_transaction, "VMM (Scenario) Generator for svt_axi_master_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
