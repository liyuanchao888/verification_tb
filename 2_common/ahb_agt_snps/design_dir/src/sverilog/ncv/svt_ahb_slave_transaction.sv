
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4OTW6B/CtRodW+cLaoyo88F8nPfxYBeb2syw7/+mIA8/GhP0kFHBOFJjOhhJnAGM
CfergRmLT0PsdfmtTAj2N7Ym+yk5M5DcCRDplZPJ00nreyuYolbGOf/j4wbyiItR
gL0dbDDwh+n++CHlVKc5ZzOoyU256K+U8ze/7kg/7ozWfuVPvie5DQ==
//pragma protect end_key_block
//pragma protect digest_block
QAQBWge6qlDSFjV+32JbK7gt8uU=
//pragma protect end_digest_block
//pragma protect data_block
KYIxluvIPw5mlBQ6uZ7Vs3SQOAo7d5exTKC0A17p4BoVzLgx6lZUGveDu+jYlX/z
nXuHkMfWwTSf9UUTBDJtXayAnIGQb8+TK296JCx02ELFsjz7rUJJiPhnUfV3qNMz
SZehkyEVJMQ84bR8dhgxhS2ujDFdsfOoYQDLY/pikEo/1G6yzN3wGlv2zi+aJthu
pwePgKDeIBLnFb0pZTphR3Jf8VYB9gpb436kcIhMubTJBZLNwQlcOPIgG23ubC5/
xbeNa7qqai60MVive3f+RPJU0fNV6Mpbm1zKqDAK256WnXwwFtUDNAHgqyHhpDFJ
56VQkJRLKOUu+00m22dMTac04BWQ9ESDrmI8hICe/iBUJQALYh+jwpQ0ROmtDIZY
TudjzpyF5LJnmURV+6qiB3avHeyI5thzjRtEra1Mo/EUQ4GKB2GKM934xLUxtg2n
v9Prg5/PTEPcpWn1CZJaD71lPXJ6/ZkP3aOSaYZZXUiDnU2H9t+mkYL/vCmCdSI+
HzQJZ8nsnJsqOLxuWpjKsb9ymlx5SWpI7MoIxhwTcHDK9iYErLChMUqLoeoTewEG
Ex+EPxEpWP9a/IB7620gu2MnWoucEdz1lDK3znbyRfH8MYbjO0DUTH/Kib7t7gbQ
ocEx2fDaciwnkKUteUQGvLRHejSfpvB3HsKUqeRde8SVVEwbvJ+I90x6AplaX0Dx
DQ7BTQSvMgE0K83LpmDheQfld1bjqITcEXu9iwErBKPAmMpOcE+c5HjbratW4pfk
qspxQAnW+8+wW17TxiAsLpdh85CjcTLXyGax0aU4n6X+QCbJDGdPckMOgxPz+2AM
18z2SAcg4FUgnU5jGbGJLkBRp+5tWS9ZWxSvaUZqxtJYzCCugJedJEmvpCETA0w3
ZiaAriz+1FuIKX6/E1G8XCA5Z1YkEoOHpfusI7pDDBS8wWHqNqGyXC3/GjKbr469
EqKNUP0+Ckp/fRK91r/wnSg/DCmGhqF6B8UQB0PKnL9ntPpbejBlWH6ncBvFyOtT
IDk4cRiyCbbQCSkMjU7xKTOllhoQ59hXXTqCVVw/Z6NH+gyVYKdNU2X5o1NHTb5D
Nt8UNKu5iSr7zsW/lXC5c+xBiF/4DT0tVwIvslCR7lnFede4X+AWzhNMVWeAsJBg
JsPD/bnS3BhLwE7e+u+DGzu1JOV0biQ22dLJQn8afDnPcPon46SPHzX6qndQloFN
UzufqG0oZ+dTpG3/CwHQlvlZONOjxcZ36bKYQsMlJv4QN3/shYzOh1d+dkzQHtsY
tJqZyGfj7iPX7TVx1gYt0B1uzyKdTdovxHOfV3LrqJPUtX9O4kg2vMkth5OR6DUr
AYBJ1a8VCpQp56Dr/DFmx2R9NFeN7c3GjvHdvXOf2MZSV1nuBpEQ7uPF/6vLTh1u
PLMw+NVvOBFZdUNcTMpr/AezgAtRuUpj5uXkkbXB7R+Jb8hhU+khByHpslFqSCim

//pragma protect end_data_block
//pragma protect digest_block
D1gvWoaRRIS5gQkWLPuZLAdQSAU=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3VJddcj8FERtB4pTS+8wkmhvw8kAgpfyppSS00UutyhEmezxhQozn2oUEBJ8vITS
1kJKyL3+Yc8Co0zgZwLkndrMz3rYxo3Dc7E3dfxIzbrIaFX9YKsuPx3Jy7zEpwGJ
CaPiDKvMMJbXkNBmiGyU5zWrupuXAUEUJpbkQjQCzf6uvEH+1luyUA==
//pragma protect end_key_block
//pragma protect digest_block
xIxcMT2PM9lkoWZYpDNqH2XKuLU=
//pragma protect end_digest_block
//pragma protect data_block
xUfxvGLmo6PzBfIUwztCofXbnjzMrY8U57OJpQiijZGGpv/tLNM3vKq0GWIeU6MX
kXYtESpXmEzU5QvD80F/EzB2uoQ2PTQrh0/JRo66aS96w0tN6r26SyC6unjLi48u
pDC3oas6T9gO7TT4R5dfL/LcAWCrAvIMvMVLfBclWYJPIVlZ4Exf7Qb2snOOlcyB
FLZ7MmlBy6AN4t6dgcdWRg1JRIZvg6Ivx4C51xgT34qLCmzo9asFlCDNBUqIXZwL
ZXdi3yX8KzrTM2RXsZCk4z8upGWfGjs/uXkYMhk0Igh+zb9wDxRxbUa2a5mV8B+G
695AnQfzCMtR0FRPt2gePL/fJ8c8AvUdbBtwyzpO2jYfoe/lRB7Xh5m1uyN6U4VD
fPzYsXi0xSeUy/08e393VX7rHewEC25hajYBeuSGTPTLRyDLFYqaBYS+c+HF26kS
HvW+UtUpMbQsM8I5MUW9jv28J194iK6BfNOOvzzRHW+o06cXVrksLHTsNz14WytX
OiysM3xjOZcbBjzd5WCTepkdCqVL9fBpfWygoVfqFp74SLZ5OQjIOfKCeaOzKsd6
cQgWdBqEdz6LDcE79i8N/iaZHhDZ7foqb4U71q9Ngqn9brmMIeqCcLtbRfYlcnDW
WrVrdRh+zPoiyBqafN62g7YwC3esx4ey4AgryU2u/a2llejlZX/HBS3ZSVSy86Zq
Rblwg+jht6CZ8oGXcJuF7t5afLla8Os9ZH+aJ2MqM1LbxOF9ZSHhgpfE6LY1bgYy
YkY0Q/Mwh4TRj5D+P33AB/KEH2Je/AkqLRVuuSj/NfZRNoEJaB9tJBm5o8+W6T76
MXsQYB1bDBu+63VaktAwlthglGoutIWdP0NnSDatrdsoLSBdkCy4YKHeCKN2uNIA
xTDPvG0KUxmUxjgCMLSiMKirhY2NMdZBaD137AyqrBLeQ4DcrdaDET9T7EWzokRK
1NriLwpE2nTf0W27gGhwJKfIBP7HCjuyjMg8vQnQUbJed8cWxCw+T2Bat7z+88N0
cgR37hJuFif7HQ5Gy0lY/YcqRAUjy/uhaTnYhORhVpq2KQU6jKpY7LR+ejL/+5ew
fnxf2DlxiqUOuXNiRi7Xc9ureScSdVpnW1kDw+VCPZQBdpwF/MMPaqH3+JgyocI9
t5+1EVVVKG/1ArD3VPlgEASnRkBx9EzwUNKjHMXpC7Tk+uy0lk+q6OlnhWeuL3mz
JhVgi74MjAo90JfAWXy5cQ==
//pragma protect end_data_block
//pragma protect digest_block
ND9kOfSABX+8tVMbKF/F8U7B2ws=
//pragma protect end_digest_block
//pragma protect end_protected
function void svt_ahb_slave_transaction::pre_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5W+Bms69a5DPureXZqSiLRF10nTcbhcXtjct/U9DnX25uKf2vDjkgTmzreVex7sh
/7Cb/pZ6ynWbGDQPB0AKJ9dFiF9WlmSN/4T7B5JnTfecq1CdvO7iVSHcaUaPz+mr
zbar3g5hzRGfukHQe+me38uFY4RMjiZJNrE5uiHvkcLjaMPuAyoTZQ==
//pragma protect end_key_block
//pragma protect digest_block
LmerRyE42NXEHGON/+JGh46lO3o=
//pragma protect end_digest_block
//pragma protect data_block
9CwhpCKjCU2bFGx+HaAudP2zIkOWatbBxkMa5rYB1XxXojabIB0eGRHnX20Bqaem
T+OZzxTcJ7adYQ6B5ejnrBFV0Jb7LsLIUcd5jaGVXhL39261qn87LOOlpph3eGop
sziweQ93fEKBs7gPBVq3UiNbY6qGoWLkOtmq3ako+R0FLcIA9A2X2+CiyXcQcXjU
Oxb9JamWT8IC/2sdsdZasPdL8JbSdcRpbEb5KVrlmiwES+eHTWMO5rSOPWEME1dz
lDfqCg5XluOj+LTTArblNTgzo3nwbMkm4ybMVDg9qd/JN3PjAQCIcCHn84kNVrRk
HoNvcQacwL5r44ac0lh+gtZxhpXfOoTqM+zTmNv3H0MGfEJbDcv4CHNILy+WI7qi
RQccJwXZnHAtP8ZR6WR1xMBFJZ1alTvNcmk/Tv/Tugyuc6jGaXox1O+h2PG4zGUe
/vK6PNm0uI5jeAuNN5FzvSat1srsvIl95ME4h1gN9ovi+GClIEeIVpw462UtIH/G
Ps6Qzqd3BRPjYAlKd/Mr2WQfRF+YscYygTZRH0wG4wR6rYaQDdZGecs2nCNRB0Fp
hUSqRzwKrgiOuWR4BS6L9hybgi0UAJXGGM4I8WG/SwkqgzC0G6BSoElkkRPw9YGF

//pragma protect end_data_block
//pragma protect digest_block
08g+9MDaCL5r+V1ePanjG4HLOho=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XoNoQ1cWa0Aa66DYNfl0UoDcL1HedrICWTLkBarQjcXg0dcyPrzPFk8vmsfl82w5
fmY76kLYb7NnlfIKZxodM0pjnteV8DkfB6zi19NVhBXWr/oaW27Q3QsQ1dB03Ul0
YXODimgFGeLSjgf0dVis8KYhySxwIRqk0fO7984qpaCf1j+vE+Ib1A==
//pragma protect end_key_block
//pragma protect digest_block
Zl5GsbTrRgekOiTOYyTP5VwV0rM=
//pragma protect end_digest_block
//pragma protect data_block
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
4hy0J9wDlMMhTGUR3UfzRA==
//pragma protect end_data_block
//pragma protect digest_block
SPAvNbUVA5ysmfEXgGh9QJXd3Ns=
//pragma protect end_digest_block
//pragma protect end_protected
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_input_port_type;
  `vmm_atomic_gen(svt_ahb_slave_transaction, "VMM (Atomic) Generator for svt_ahb_slave_transaction data objects")
  `vmm_scenario_gen(svt_ahb_slave_transaction, "VMM (Scenario) Generator for svt_ahb_slave_transaction data objects")
`endif 

`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SV

