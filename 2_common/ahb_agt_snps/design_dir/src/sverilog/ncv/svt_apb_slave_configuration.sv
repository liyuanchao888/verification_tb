
`ifndef GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_APB_SLAVE_CONFIGURATION_SV

typedef class svt_apb_system_configuration;

/**
 * Slave configuration class contains configuration information which is applicable to
 * individual APB slave components in the system component. Some of the important
 * information provided by port configuration class is:
 *   - Active/Passive mode of the slave component 
 *   - Enable/disable protocol checks 
 *   - Enable/disable port level coverage 
 *   - Virtual interface for the slave
 *   .
*/
class svt_apb_slave_configuration extends svt_apb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_apb_slave_if APB_SLAVE_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  APB_SLAVE_IF slave_if;
`endif

   /** A reference to the system configuration */
   svt_apb_system_configuration sys_cfg;

  /** Value identifies which slave index this slave is in the system
   * <b>type:</b> Static
   */
  int slave_id;
   
  /** 
   * Enables the internal memory of the slave.
   * Write data is written into the internal memory and read data is driven based on
   * the contents of the memory. The read and write into this memory is
   * performed by sequence svt_apb_slave_memory_sequence provided with VIP.
   *
   * <b>type:</b> Static
   */
  bit mem_enable = 1;

 /** 
  * Passive slave memory needs to be aware of the backdoor writes to memory.
  * Setting this configuration allows passive slave memory to be updated according to
  * PRDATA seen in the transaction coming from the slave. 
  *
  * <b>type:</b> Static
  */
 bit memory_update_for_read_xact_enable =1;


  /**
   * A timer which is started when a transaction starts. The timeout value is
   * specified in terms of time units. If the transaction does not complete by
   * the set time, an error is repoted. The timer is incremented by 1 every time
   * unit and is reset when the transaction ends.  If set to 0, the timer is not
   * started.
   */
  int slave_xact_inactivity_timeout = 0; 

  /** 
   * Sets the Default value of PREADY signal.
   * <b>type:</b> Static
   */
  bit default_pready = 0;
  
  /**
    * @groupname apb_coverage_protocol_checks
    * Enables positive or negative protocol checks coverage.
    * When set to '1', enables positive protocol checks coverage.
    * When set to '0', enables negative protocol checks coverage.
    * <b>type:</b> Static 
    */
  bit pass_check_cov = 1;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pgp8hSIFpnNHxkbjoyGUsKqNHK7igRwvL4npgvWrt9Rw17OO1Y337ynBiRXZfZ5x
FMgLTlr5OIr5lBBAMUMXDhLXWFQPfJ0dCBodgWzaD9Ukq/aPF0ZofdHLf4NIduuX
86ghMRRNd0jC4DdXS6nNckk8cswJ26YiezGDwV2HFX+FHCbJCyoAOA==
//pragma protect end_key_block
//pragma protect digest_block
MeHytYiUvpwcSh81FkSWxgqk79U=
//pragma protect end_digest_block
//pragma protect data_block
axSHFCywm24OoPjuHfzEjDiSoGjzcvutphUqGJHpIs4QT9IJ5bqiYomqaj/ZLGXk
ahUmOrUlymQXKVnhbDyI3WlPnnig5PHagLN0WwKEieVC/NzwPQRHzM7Ymt75oWB6
gF7FDpxQH3OZWi3MiurXSj7eg3t7ZZyqL/9cGynTVWmO8NluVplOuSWrdGUWum3Y
9zGIrUtmwrAr6EHubUsnQnSi5JSQJsMyFAtZvyBMXMqlz2xnNLK0rXXIPoA7+thG
lgp7zttMGD2F9IVa3rQlEU0J04X3iyrzlZ0FF9PAwtIXy8JC6tGH0o//NwX8iOhh
aI5UYySNPwHOmaE5Tsn0i63k+CkTHRtDbYsAbJiqWk9e0pf9ZqhWwMTthQpy0w+V

//pragma protect end_data_block
//pragma protect digest_block
8jnIwSgFje55iSyM2itxxfgtRv4=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_slave_configuration)
  extern function new (vmm_log log = null, APB_SLAVE_IF slave_if = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_slave_configuration", APB_SLAVE_IF slave_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_slave_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int(slave_id, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(mem_enable, `SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(memory_update_for_read_xact_enable , `SVT_ALL_ON|`SVT_BIN)    
    `svt_field_int(slave_xact_inactivity_timeout, `SVT_ALL_ON|`SVT_NOCOPY)
    `svt_field_int(default_pready, `SVT_ALL_ON|`SVT_BIN)
  `svt_data_member_end(svt_apb_slave_configuration)


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
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the APB Port
   */
  extern function void set_slave_if(APB_SLAVE_IF slave_if);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /** Extend the copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

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

  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_slave_configuration)
  `vmm_class_factory(svt_apb_slave_configuration)
`endif
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mF4A3ZXj4aeSygcfBBnZP3RwCh4ehRNd7OTFQs9TTuHNFdfwwouWxcr+gRxYVjz7
WlzV0PD3tSVxvFAtaK9G9Uhy8X3WXAjpV8Vr20gGZSbYrZwz7C6t8WKqwp0iyNL7
fIIekOUvQfy1sdpU8rwtUsvY/YiQE5DAiQaTK9iHT1Wcs+476oJ5Jw==
//pragma protect end_key_block
//pragma protect digest_block
VWQCq4YX6o8oAyGchvdT4IZcMfE=
//pragma protect end_digest_block
//pragma protect data_block
fe7IDAOTx/vjZKt3NO4uM3Wk3ugURIIao0eH3exuFHjYEJkeGYwn0vdhvZuq/Pr9
R+ktlqPvmmUSBSwq0Bz5gozIaZyIrWZI4Y2dY5Jcz/nD0yoQr/ZR5bKXnFHmvBPN
eC/gILEapET/WdpbAqAEke6w6rcENonDC/O8i0Iv/zt8GIoU9NqlEXM4bRhc/W9B
J8k/FtDJahI5nVt7Yb7+1qPH+f7Q9tsZZqcthRXC5psZ7iUJDmFS6ewhnk/LKmfD
6DiQ2mBqVtT15wo7DddK9lZYjATikpqzmx+NTy4UUXClnqKC+JwH2m1R6vocSGiz
u16aS3AWiyKP+DUEB8fxTzaj7LabKbc84jXvUf0bUK0YeQSrXFYoH/SuxmwrtkQs
gRuDUJ6yObsTgmHXj5e+cIUqpj2TwJ9ZkCICyZtX0tVP5DCziYSZwg79mCsfu1A6
bUl3rWczd50eC/GwceYzs4bYbOUGSTiS3vWSYwsNqFm4zng3qSwRam/9sN2OpiTw
iLzIehkfsTgEQIbas/PQKjemcW4AKyC80vgQl+ywqlodZFN2HGCdX3oUt4nY+UI+
FARU8g9lKDl/foNh2EhG1MYBZWsHOnzQWDDJsQSuAMqPzHuaGd0HU9Xe9DxgDsbw
PFLH3/qlGIFt98CcKJtFqp5YiaAIQGqFLmO9RmkJltRBhlOtZB5azcErdwM39IPW
BYGrkhCY/vJaUnwFN37QyQLgjYSc1leNzwVOaGhY/vT2DVWErb6F8jF5trcSkLzB
P55BVHjy6+llZs1Jq66AC5v81iMhllKulZln5zhBy/RFwMd6wtE+AnkTf4+zBlmD
f0LZCLTtTqxyoBXlVvR/fcHFWPugIoQ8yL49rhSge6bYp/NPcRAbsNyrnYysIfJ5
H73NNtVsejRiswX1bLdNTRRz7nDn61ehgb0DmOyQ0109JcJ3M3hrFPA/U9PxsmRC
y6ikJRLqcq6Kl3B3C0FAuK2aoDi/GboyQqEX3JexPDXW4kkjsr+tm/xyjos1VC0J

//pragma protect end_data_block
//pragma protect digest_block
K5i+BS/GQEx48L9LL2MdDSQvcy8=
//pragma protect end_digest_block
//pragma protect end_protected
  
//vcs_vip_protect  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tzXo8EbD9yjURdIOfnWFEFvP9iWzAtIADvTTY7pE99VDjTTZSKaY58qFcPqtAhkK
tTk9LkarIWLPdzKNlR2ddub2GVBdTpvm2qD89wqF9Bx5y0YCEsCemEmbo3+sKxCJ
IMvX+pk5Ngwlq/USfUaai9+ciQxFpA/2LWMYIg6V/7IyMpvbGFvjMw==
//pragma protect end_key_block
//pragma protect digest_block
QvKKeiptfvSEOVYm+Xt6m8qFmcY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
R7PENch19BtDlP15ohItDl+vRPs=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ouu1UoXI1Y2XqC4ejGwbb9p/InPEke0XqCSUtlRjv8bo2MINsCZ6drH0h2xANPCC
CqYNuxX1I4LucFTIpRmZNj6FXm9T5NLky0lOdS0/Ohb3h6k5U2G4Tb4H60Mm9bq0
yz4HSBHVB2VN6YpxEgBtiyDHzxZceMUeEa+pdeNC1jhg/2YO+HUS9Q==
//pragma protect end_key_block
//pragma protect digest_block
dEo6mQMKdbon/oPewmbv1S100g8=
//pragma protect end_digest_block
//pragma protect data_block
yZ5X2+OPkFJ1amU9aqiYjdbQDIuFYX85QuPeNyBYHNFRQEVr1YqJYWw9A2UQBydh
Vo/42qplvWwoWAtRq74+tT3xCoxcVW2HEYi9q1gbyr4kHw+ighBBBmkPZQPTRSL8
TialOqEZJ4UFbQ2KU0Z2aMQZ03VuD/q22wfttuRlLg4R6g1Q2NNSH4iw423mYFlM
ZUjHnzD+SpEciT3QywgifZdhmSMHf8Bdg1iyBmps95mO5f1R5xzHO0n8jTCk+UD/
djbWPUWjV6+QpLfMvcbNN2lkdBz+z4HDwfO6ASvesjsNf/SIGr10mV7lCQyQ/pB1
ajcwvgvLwLTa7ffoIPyCADAYd1BXF+Vfy2wyJqGx+S+nW//sDzYELUkx/ST3PUHl
DZ8xGZvuQULj7/8zXvFFOOyLp1qfKFR331DSl81/5Gb7SHpBijZIvEpA/USChx9s
O4IgQxfxRXbFtDM2nJr4ewmi7HJU5ItJpxfZkxBJgu/j7UWUGYtnfzBGVuHpmeJ9
HrgRIbpiO7GWBWyv53mrTz7VGxdK7EpHkbI1m25AVvJk70qIPApzLffJZr1Blci0
ST/3U+f5CYymlYkPITgr9g==
//pragma protect end_data_block
//pragma protect digest_block
molOEvKbmuoCt5VfCLp+0VyWSBk=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Z5pqJ8Ktev109GmJXDXSZfD7zkLsfXR+Y7TzZa17ThYhSbsWxlMYe8RGeV1zTTOL
eJ0Nsm9xBjXUQo/phXYXhixMTcs7YNXAo9NgnqXbECxgK0zyx+ZugNw+Zg1yCTTf
6tvYAfbg1Io7eTSMJekIgxTV+3GiJ6tIQsUcRqT7b18nmaRxkViimQ==
//pragma protect end_key_block
//pragma protect digest_block
voA0RwNPco1rz2VmLt6ovbCLzqY=
//pragma protect end_digest_block
//pragma protect data_block
PFZRyq4XunYvscimXm+gfWJc1YNO6B+3eWvO5AZweSm/Ca9RWQKL8L+Y76j0/LMH
4pw3Xl0KXSp8dHX70jA8c870aL6y7NnLMhTStq/Tnp9poeklw81y0dG5Vk/QKaGm
L1P/WuztfTCCxbVog85ebhPT10tuZWpm0mSmc5fLxmVE1EzBYpfipS2oc602uV1w
w0TZa7cLLhus6XuDdVLlqRo2RZ3V40B1bd21VoprdyCzIH222rYSZzihiKR1RrKX
SGXa3+btDR3iZDZGxfiftlsqVkPFWB7KI8OLBXLhRmSaR3xGgi+BWwLIBLf4507H
BC0Tuw6IHJPh34Tx/DOfGALHGzJu751ZgTlHW23Z6iWYv+yRbqtcg2eAlSUerC14
oy8RaujysECUpvL3QFWVrjMgjWv9z73sy7YelEn06nDqBZZESHKkGST8skR+pBqe
srcBod7D/tU+56Ox+rsUER4A+A1KuqOP66gUtFqGKzb8Z5SsLBojwTM5zGx7B8et
XSjgmFmVX1ywfaXvmVOKJLyMJ+t0mDQtWGn+LPGc4dZ1EOzyRT85PbRCrGYT8k7u
dxKO5paqHjUHXEyIcW3rveNPJMsxJY6UP4DUMhV7+f0G/+9hea7B9rJObtg+z20x
nJnKxp+0gIRkYxCeLmy0h6n7WRoWjbx0sU4vozAJX4+d5/4G92Oh99hkEvi493UK
whY+MAQPg2rGZTIVPUYi6XkJ6MYNSRmOjMo2FfIo20qYL+NpPgP3UjE1zyJ4KCpk
vXANVbKjOtVqfnqtgeyD1XAW1J6uTVyuVljMUegbyimKLNad4yLUUDm5LQy1FAdO
Ik4KAZ9BcuCFiQ+4VMvtU8nNKJM5MLkVHNZOu/k5qBTsWwO0a5GJZq4sF9eEj4xQ
bF1HXpki5O/vc2ylvfx7mnVB/foaR8ZMBuAEdjFxsJzEYmjC6q7Szc+VnoPQ00d3
c/HMBRrzx7ojF1nMiNBfLIJ58A79uobyRjqtjnRtrWVpeYsSMvc0bHCRIX8hsUpt
X2qlugZ/pYzIpKs6brWoypNpeYfNA5vqdSyx74qtrywCak3GWEAS+xWOvT5JCubK
DMF0oxah2rK+RjYbqO/qoxh74B7xXgZ320ARux01wIqWe2c2yzl3eOq2BQa4pbzv
lLZpy5bNXg02yqixyn83ZCTnP2XMiKs8lMo01A8zUtpK4tjt3PnoZUVOO7zVnzR7
W74Ot1LlHuz3ty3nfj+h9kETaAC3CjOMvpct82HPZlne4cZGOEUWpu89wRzLupku
vBcB3mWN6tSSgLZc00C7o8XyNRWb40fAgONADWoEz8+CuRdq+zd2D0oSsfQEwUTO
sHZG9jscVhGXf2E67oLH8ef9bVzjlv912p5maKdMuXFUoXuQOXfgSQ12QyAjVGrO
rEKNpAVMTy87RpnJOnqmnpE5/l1fE+eSoJKhrgYBgHGzRCx2bN0Y3+bA1ndTNDqa
ew3hLkhQXWxF+pUG6r0iBruETawoVZplMDg7Nsb+4CVT0Ixyxxiq1hEUAAsLn8JW
EzBy+hOLv0XuQTCVTNqgCJJ7oRVMFUWezPeZuukUiTNsIr5YVeh75x8eNNoyKskO
r/AYc+ZfwiXIrfuQhhcW63ZPbXqmXNdm7UsAkONYRLK/cwWQyd1fHFDZgWrm34mS
RvPbTuqQJYsWH4hyVWXo/0OLpfiHRxXJ66uDkOqVaUC1X+IPbMLJVTED3tSokV1P
rLiUM0inr/oUy66e2mgCLuauM8V5L2O5Qwk8Bs+OQe4pMJezYnUEtLsQDcRR/U74
LouzLkagM5u8ndnhxSDhBxS8eG3/S6oikwYgtEvwHfUOLtbMJ807onsNYQD95syg
Y1bn6ANC4Vct1Oowj8YOHg2dMYyloztGpm3x4z8nWJE=
//pragma protect end_data_block
//pragma protect digest_block
HZ1qUNZLMrTCQLnSOj8eVKeBO+c=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
