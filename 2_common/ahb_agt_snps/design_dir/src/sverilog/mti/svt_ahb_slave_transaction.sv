
`ifndef GUARD_SVT_AHB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_AHB_SLAVE_TRANSACTION_SV

/**
 *  The slave transaction class extends from the AHB transaction base class
 *  svt_ahb_transaction. The slave transaction class contains  slave specific
 *  members and constraints for members relevant to slave.
 *  svt_ahb_slave_transaction is used for below purposes:
 *  - Specifying slave response to the slave driver
 *  - Slave provides object of type svt_ahb_slave_transaction from its analysis
 *  port at the end of transaction
 *  - Slave provides object of type svt_ahb_slave_transaction as an argument to
 *  all the slave callback methods
 *  .
 */
class svt_ahb_slave_transaction extends svt_ahb_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_slave_transaction)
  `vmm_class_factory(svt_ahb_slave_transaction)
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The port configuration corresponding to this transaction
   */
  svt_ahb_slave_configuration cfg;
  
 /**
  * Local String variable to store the transaction object type for Protocol Analyzer
  */ 
  local string object_typ;

 /**
  * Local integer variable to store the current beat number which is 
  * used to created unique id required for Protocol Analyzer
  */ 

  local int beat_count_num = -1 ;

 /**
  * Local String variable store transaction uid which is associated to beat transactions,
  * required forfor Protocol Analyzer
  */ 
  local string parent_uid = "";

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
   * Number of wait cycles that the slave inserted. <b> 
   * This member needs to be programmed while providing slave response to the slave driver.
   */
  rand int num_wait_cycles = 0;

  /**
   * Number of cycles before the slave asserts HSPILT signal.<b>
   * When 0, HSPLIT is asserted on the clokc edge following the first split response and 
   * is deasserted on the clock edge after the second split response<b>
   * When > 0, delays the split assertion by sepcified number of clocks after the first split response cycle.
   * Default : 0 <b>
   */ 
  rand int num_split_cycles = 0;  

  /**
   * The data_huser used to return information from the slave during READ
   * transactions. This member needs to be programmed while providing slave
   * response to the slave driver.
   */
  rand bit [`SVT_AHB_MAX_DATA_USER_WIDTH - 1:0] beat_data_huser;
  
  //----------------------------------------------------------------------------
  /** Non-randomizable variables */
  // ---------------------------------------------------------------------------
  /**
   * This member indicates which bus master is performing the current transaction.
   */
  bit [`SVT_AHB_HMASTER_PORT_WIDTH-1:0] hmaster;

  /**
  * This member indicates that the testbench would like to suspend response
  * for a READ/WRITE transaction until this bit is reset.  
  * The transaction's response/data will not be sent until this bit is reset. 
  * Once the data is available, the testbench can populate response fields 
  * and reset this bit, upon which the slave driver will send the 
  * response/data of this transaction.
  *
  * Applicable for ACTIVE SLAVE only.
  */
  bit suspend_response = 0;

  /**
   * This member indicates which HSEL index is selected for specific slave during the 
   * transactions.This member is populated by VIP in the object provided by slave 
   * at the end of the transaction, in active & passive mode. 
   */
   bit hsel[];
   
  /**
   * This variable is used to program the data to be read by the master, from the slave during READ
   * transactions. This member needs to be programmed in slave sequence for
   * each beat while providing slave response to the slave driver.
   * The usage of this variable is not supported in callbacks.
   */
  rand bit [`SVT_AHB_MAX_DATA_WIDTH - 1:0] beat_data;

  /** @cond PRIVATE */ 
  /**
   * Indicates that the data read from svt_mem contains X.
   */
  bit read_data_contains_x;
  /** @endcond */

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QtZZhDEfLKBcwSCQi2cRobOuhiWbAlSN6U0+O2HnT38o2xApFYp73eXGQtyiIZKG
89EW2Uile5uD7DJofsF4+QfksSvvqnxUrJlTX9Dh9eCD9skFZoEsRR49m4Yzt7M9
yZjR32pivlxZxKKWG66TX/CKbXwQX1u2XNBqqS/9gB8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 932       )
OZltlEOK768fN3quIWwOQ4t0vQwrDzT+cAuuY7zwhmYK4f7LxP5YEgKYR/KFX5Np
Gz6JStgq593dspuXotp1BILm/Tj01HwlM4g6P8FrFPP0/5a78C9SSNI/Fqf6PJBv
vlSHNm+RRD+vcPpvsKTrlrFdDNaUKoHTWqMD4SJDQl+zrrFfeRDlbQY8MNyTLO2F
XPXGwOIEa6iIQnDERb59YTYO1+3UaLft8BITjoKG5NqpUc3i8EY4MLI4qxJpKnvm
hf5i4p6z6Xy+YbRXoZ4OEGfy3ASlwVgy4Ci9UfIMWCiccLi1BDUi68C4hJF+eEC1
8d2whiCsP+FfSgts3n1n3KYJR7wcTl+S/kbnOQJpozNVMPdGk4W+dOitP3dghvWY
6NPeoZXa36DcNFs+7fjMG+UuAORIexEXSwWveLWtejmnPlwB2/s3AaQZ6cOTiTsB
enkqU/omztF44It2vy+cAJscKT8QfgbaQneFaaF/pAagSZZX9WZgIyTXMcz5hyn3
b/WXJGKWM5cGSm4kyy7U/v8AikYJj3FO+sPBtHi/NTy7pJ+vUe8eGbT1tCzPpPtl
YIOb5C7zlIv0JbmHAUdUYUOV9X46NjrIveF7IQIrZk56XEpwQBT0gIk0I92vyCQs
+V8E9dzabxwyXKCL1uLcfvyCyQayMD2k++rGHwRHpQwrMIPAl1e6yJ4vnLQJNroC
/eBjY6N3QF2GAkfAT3xIwtFEU/nIQaSM1IzGsoigqEeVyjFuC5JpZ3N1AD6l4CnZ
2Bq0LeKLAUAniipMPKtBHnzcwohJ9J9F3vQW04YKdWh87muBRwByEHoewAROZZmo
KpGw0sTPShBrRsm0h6Vq/I7tX2R/OqLZMNM7KHVUkI1gzbr0vMo+mVh4NinH12VM
rZgHWidl1ptzX/DgF6YQuQM9psFPM2A9LVL6LW6RoxQRf/tDgb2Metd7Dw9NX4X+
C+wanWHuyqsrkQ3x866AXb6DaPhWRSDPg/ocyH35jqgRt4J0+dtb1CdaLEvLzwb5
HwqcphHD7s8nM1yrZ86R+w/quNi2WHmvP/MFaCohVLOEHOgMJzDRx1UmSkX/Mi4C
2mA02yV5I1rK/WCpJC4W9ag4kYH31pCySK0ZcHZLemfFbKbc+pgiErKgWHNRNfVc
/HzIITyBpPRJmSfpZJE8f3Zw4WHdnDPzALNZFPFQT60QsP7dpeMJqvUiSH907UX0
0Rch1C4qObRDPEQdm1xjtSmsz+PLQQWtyBTHWMbLNYs=
`pragma protect end_protected  

  // ****************************************************************************
  // Methods
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_slave_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_slave_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_ahb_slave_transaction)
    `svt_field_int        (beat_data        ,     `SVT_ALL_ON | `SVT_HEX)
    `svt_field_int        (beat_data_huser  ,     `SVT_ALL_ON | `SVT_HEX)
    `svt_field_int        (hmaster          ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (num_split_cycles ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (num_wait_cycles  ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (suspend_response ,     `SVT_ALL_ON | `SVT_BIN)
    `svt_field_int        (read_data_contains_x,  `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (hsel       ,  `SVT_ALL_ON | `SVT_HEX | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_ahb_slave_transaction)

 //----------------------------------------------------------------------------
 /**
  * Check the configuration, and if the configuration isn't valid then
  * attempt to obtain it from the sequencer before attempting to randomize the 
  * transaction.
  */
 extern function void pre_randomize ();  
  
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_class_name ();

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. 
   
   * @param silent If 1, no messages are issued by this method. If 0, error
   * messages are issued by this method.  
   * @param kind Supported kind values are `SVT_DATA_TYPE::RELEVANT and
   * `SVT_TRANSACTION_TYPE::COMPLETE. If kind is set to
   * `SVT_DATA_TYPE::RELEVANT, this method performs validity checks only on
   * relevant fields. Typically, these fields represent the physical attributes
   * of the protocol. If kind is set to `SVT_TRANSACTION_TYPE::COMPLETE, this
   * method performs validity checks on all fields of the class. 
   */
  extern virtual function bit do_is_valid ( bit silent = 1, int kind = -1 );

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object rhs), `SVT_XVM(comparer) comparer);
`else
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
   * Allocates a new object of type svt_ahb_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * svt_data::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size ( int kind = -1 );
 
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
  extern virtual function int unsigned do_byte_pack ( ref logic [7:0] bytes[],
                                                      input int unsigned offset = 0,
                                                      input int kind = -1 );
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
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[],
                                                        input int unsigned    offset = 0,
                                                        input int             len    = -1,
                                                        input int             kind   = -1 );
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val ( string           prop_name, 
                                             ref bit [1023:0] prop_val, 
                                             input int        array_ix, 
                                             ref              `SVT_DATA_TYPE data_obj);
  
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

   // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
 extern virtual function svt_pattern allocate_xml_pattern();

  // -------------------------------------------------------------------------------
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
 extern virtual function svt_pa_object_data get_pa_obj_data(string uid="", string typ="", string parent_uid="", string channel="");

 //------------------------------------------------------------------------------------
 /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
 extern virtual function string get_uid();

 //------------------------------------------------------------------------------------
 /** This method is used in setting the correct object_type for the object
  * to be written in PA to get  a unique uid for each object that is getting
  * written through PA writer class 
  */
    extern virtual function void  set_pa_data ( int beat_count, bit transaction, string parent_uid );
    
//------------------------------------------------------------------------------------
 /** This method is used to clear the the object_type set in set_pa_data()
  * method to avoid any overriding of the object_type of bus activity and
  * transaction types
  */
   extern virtual function void clear_pa_data();

endclass: svt_ahb_slave_transaction

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XnxYoO/qtawsm952AxcTww02jaO8RPZuoa2Tkt6/5B8/+pswSyg6BH8kbnGJTFOx
JVB2xAays0yZIrruMLIKe/iwp0OahBUnprbgx1a93pxXHK2VLFZoJZH29M0A56X5
jrTdzlT615Fs6a7GIMLSHCm/Odv9ZgtHdLTG2ZZXGzU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1684      )
md9D9F8rf4wML6nhEQCMjrKMaXD0kjDc976HkFMPsT3QbbDBPz2PTNx4nrq8q97E
xRABHdTR/JKksKZGdeqy4JA/znUAHlCvI9K8oZps96swaOoUQkNhNH+6qZReuVlF
7yFdm7cpsx6CGRSpldU9sfwj8Da7wkIzNmg74hPHrGcCpgVR0ttTM9IJAcGkgnyF
43GggOjlw0SrN1AL/gXL/BoPh5Ph0U0Hr6ovVTnhmKMbOb7sc2I8vxjPE/9dR7Nz
gEIbUPwcb8je3KSTAxo794aXQukYDIfN/c1Xr/xfKVhnr/iLHK/XUqH0PLeRuVvu
Yok8rvZrSRec/iCJGj+gwGMpEDQd521fj0kmO75CiYcLGtaeRYSDHJ+ZIr8YggJx
nnGnM2Tzle8pY1Fb/tayI7RorbWi+k8ELZomc54srhL5L5NqPzVVUERTroVUxztW
GgX9tHfHjtujz2q+vgwkAhCtA/FfwzG9o+WsJo/ZyYmFXUUsQ4iZZWLTYEKcJQOk
Ovh1zuGZ/bAIc692uIa12MwRG6dksqJccn9LzddubkCXF8MAtsvr8kXZlX/wtR1x
q2HIKZxNF5cC1PcN+JB/JPqYkYW0BMvXAUh7YSKoEfCzpFNjEwdnLOQUwuweG6F5
84M0P2E6YxlGV3nWaNyWGeKAarmLhgeXT0qXpFbeSYaiFIoCioDx18JpN+u2nwei
+6RfLjlEMvPFDrfRcwl7GElrevfRGtXU2D/75L1WqBoo1QpKLCQasRjiag86Pip8
pR3PMfFHwuy6LytrkODherUcIrc7NIRv9F4rkdlj/xs1fHRpGP8kiAp2bdjEq8Nw
/ZdxIzjD8yGDei7wCqLae2+9QuOemEr42djmJ/rpwMob7Q6HBK/qxKRoc3xI3VjZ
RyvatkaLgg2o9JV4x4/mc3fmkAMCgRFr1fDX7kmgj1S523qbUWgjV9HF++BtiIpd
QAA62wF7LzJ3OrPSCpmj4Db4GBeZquMuPCkRFRd/zUXZnhvx/PSElTmqWtZJCzFA
`pragma protect end_protected
function void svt_ahb_slave_transaction::pre_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oRQT9rOdKe3Iex7TJChjzJAo83dRCZErQesg6amJrYsGQYoIuRdXiaJWFpmaObfk
It4JOX8P01zyR6uzP/6rmMfy1BXiT7PI8TsvJa3ItWWinfUUfVMJhYNeDFyI4u6C
+F+o7vvVAqyxKTyIp6kYheGE9F6wCiMSmLYfF+CAawg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1984      )
zybz+8fYWPiT1e7JCh5brTyMMO/ZWbNqSR1SdDu/f/IJJ0NZxKpM0J0J2pNu99oE
QQR/0Ooowl3a+ZlQ/8OPqP/Tres2c82LlAJw7G+yLhaAGyLpI0DZmitDwZOoGR+n
UvhjtebhgpSn2Fw9cxZHRdpiQawVYeeDGj5kdrMd+xwi5wNn+uOonBQC1JEc6gxy
xwQwfGZNsX7cMl6TgE2YWZaWtKr1kgZ9i+dGYJarRS+Jk4CcqtCuJ2jmQF7nYy6I
yLc0U5XN5f089RjxIZloizSTtXAiGdLJ9ryybT2iBsES6sdgqJB7kHQYwGGFQLdq
j7JVKmMQ2G03JkqtszbhuR2+qMw5A97BXNA4AUZH53SrFsPXsaGljT8KgLxOSCKo
+ImgOadmOAOwswEJbcme8w==
`pragma protect end_protected
endfunction: pre_randomize
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Il4g1dLlbIE8t1vlUgtEEKHhvtBjYJI3qYK5wvHPSn05SMvOznwEevAUv8l4lTnT
9QKHlB04tBLtg+xHWgJnKOkyuwuZ+NmwNci6p9zNyoBj7rhqv1R44kqay+J13eQR
y2sgC7S88x92T3YUJmGdfxHtiSfXq3sY3YzSCc+ezn4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20794     )
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
`pragma protect end_protected
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_input_port_type;
  `vmm_atomic_gen(svt_ahb_slave_transaction, "VMM (Atomic) Generator for svt_ahb_slave_transaction data objects")
  `vmm_scenario_gen(svt_ahb_slave_transaction, "VMM (Scenario) Generator for svt_ahb_slave_transaction data objects")
`endif 

`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TNczqLg6aYx2/Jlkyf6IFaRlZW2VBWjNxiZXeuuS3EDEOJa2ndLB9b9n50CWvvU0
ssS7g3h1C1Hfh454OTd2/o+65qoWh4TrYvi7Zej5xWFbIbDAfTitrq6/QyX9RlWC
11ebgbVRDjxD8jrs/3TIbSA7++o0D6c7qrrjdYPbshU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20877     )
WAvTQ6LQuyLpxCUPO2jfW3EBsywoLw6iYRK6tuhaOb/5bO48wNwU1fT9UjefF4Dy
GuANVjheC2NDJytvqaJKCEfBgPhVtX9/+NyMej5BZ2IJDUh4y4KRea4ooNoRJPmE
`pragma protect end_protected
