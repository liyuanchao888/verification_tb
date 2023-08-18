
`ifndef GUARD_SVT_AHB_MASTER_TRANSACTION_SV
`define GUARD_SVT_AHB_MASTER_TRANSACTION_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_data_util.svi"
`endif

/**
 *  The master transaction class extends from the AHB transaction base class
 *  svt_ahb_transaction. The master transaction class contains the constraints
 *  for master specific members in the base transaction class.  At the end of
 *  each transaction, the master VIP component provides object of type
 *  svt_ahb_master_transaction from its analysis port and callbacks in active as
 *  well as in passive mode.
 */
class svt_ahb_master_transaction extends svt_ahb_transaction ;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Reference to master configuration
   */
  svt_ahb_master_configuration cfg;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
   * Number of Idle cycles to be issued for a IDLE transaction
   */
  rand int num_idle_cycles = 1;
  
  /** @cond PRIVATE */
  /**
   * This variable is applicable to a fixed-length burst. 
   * When the value is 1'b1, every transfer in the fixed-length burst 
   * will assert the request pin. When this value is 0, the request 
   * pin is only asserted for the first beat of the fixed-length burst. For INCR burst, 
   * the request pin is asserted for every transfer regardless of this value.
   */
  rand bit assert_req_on_each_beat = 1'b0;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Non-randomizable variables */
  // ---------------------------------------------------------------------------
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

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
q7Hpd5VWJE7KEDJnmSLQ+1J7aeSrIunpAsJBoMAyDsjJrFcKSiTQts2+EgK8N3n2
TG+iTGuoywfvmveure4qaJQlaqU8RKnxOmLzm05PKy6NFMXTD9YRa8EWF7fPqZIq
TNS0kXxxFp+ZaggI0oVdE7yCEo9w5I8+77ExfMZns93e2O4i4Oi9Mw==
//pragma protect end_key_block
//pragma protect digest_block
YZQVBGjG5+CU+C8L9aJCTnN/mrc=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
cl+qwrEbthAh3iXOrj2yNmZfhEU=
//pragma protect end_digest_block
//pragma protect end_protected


  // ****************************************************************************
  // Methods
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_master_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   */
  extern function new (string name = "svt_ahb_master_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_transaction)
    `svt_field_int(assert_req_on_each_beat, `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int(num_idle_cycles, `SVT_ALL_ON|`SVT_DEC|`SVT_NOCOMPARE)
  `svt_data_member_end(svt_ahb_master_transaction)

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
 extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);

 //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
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

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_ahb_master_transaction.
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
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, 
                                           input int array_ix, ref `SVT_DATA_TYPE data_obj);
  
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
  // ---------------------------------------------------------------------------

  /**
   * This method is used to drop the transaction if it crosses the slave address boundary
   *
   */
  extern virtual function void is_transaction_valid(bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] min_byte_addr,bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] max_byte_addr, output bit drop_xact);
  // ---------------------------------------------------------------------------
  /**
   * Called when rebuilding of a transaction is required
   * @param start_addr Starting address for the rebuild transaction
   */
  extern virtual function void rebuild_transaction(bit [`SVT_AHB_MAX_ADDR_WIDTH - 1 : 0] start_addr,
                                                   int beat_num,
                                                   bit ebt_due_to_loss_of_grant = 'b0,
                                                   bit rebuild_using_wrap_boundary_as_start_addr = 'b0,
                                                   output bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] wrap_boundary,
                                                   output beat_addr_wrt_wrap_boundary_enum addr_wrt_wrap_boundary,
                                                   input svt_ahb_transaction rebuild_xact);
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
 /** This method is used in appending the transaction count at the end of
  * object_type to get the a unique uid for each object that is getting
  * stored through PA 
  */
 extern virtual function void  set_pa_data( int beat_count, bit transaction, string parent_uid);
    
 //------------------------------------------------------------------------------------
 /** This method is used to clear the the object_type set in set_pa_data()
  * method to avoid any overriding of the object_type of bus activity and
  * transaction types
  */
 extern virtual function void clear_pa_data();

 //-----------------------------------------------------------------------------------  
   `ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_master_transaction)
  `vmm_class_factory(svt_ahb_master_transaction)
`endif
  
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0dQ8QPT1Y19vaQzI6DQDlLJ0r9PYjmFhMkkmUMeesTRHoEcKLElmlwkv5cEttl1i
INox2vY5c/wx1AaQEvQYsVi7X0dSZWquN6ddDzfw/M79k6Rx0iJNiIUjGAMzCHyM
LD8DlFpDkv2ZQ7rM9cQHE9xdfc7N9iakXH/KNaGoeKptA70aCUyx0Q==
//pragma protect end_key_block
//pragma protect digest_block
0Jzs1HjThqSVnZsxo5PPuZN8O1I=
//pragma protect end_digest_block
//pragma protect data_block
Qubkslyyy9DK/z4qZzoOpYeyrsSTP3tcVf/ACQ67+Sq1Ggswthn6Te94fWFsOXMx
seZQbRHVJWmF9dDjccRt56vDRY76Q5rI3cgKjgKKBCjG4a9KIGidw4RHR+7eg8Qq
I2V+NJhDKuJfKUqMMXU9H4JmLoY9+QpF9MvYVgYlJHQ8H5QjpkI5mbCfo+bcbVoB
frkV/oDA+SzZ8B5tRMbftW5B2UQ7IUX/Xpy8xyOrEeRcJsAyupvy8Wbe94aNlixv
CMb669TqU8b3H4H+k5uOfSFUM0XPr+RVtRXM7B9LbaqXkTlGS7OEBnzHokFiRlIc
pvAYgSSaFo1yghBSD9sDyZ4F4rWoCmv7h1K8Icc0hZNz2BXOU2iEGmD7th5BLh8S
Gq/4BjYyg/K0k9SzF0LGWf7QJYw85TsJfF61NBypq8V7EfdTP/WQvEU5VkTxpgdo
Knl0LFlkSscNjsgHBx/XavlG24ZYR35FCsEKSx69EAF3vggTLErfP/GNq5x7gJ5h
QONHqrpOmev2elETenHa/RKHj/fc2EL3Zyd/jR5P+IsvM9ylDwduVhVkQ9Qqc1Ky
fg0avInmVBUq1NaEpqM2Qw9IBfmsK5kLFJRLdnl6rt3zC7GOnMCGCNvsUla1yrzt
S+56ZdOagsjqkKO7mBXipfZqBJ4y45f3ZS7u32JTQgurWJB/VA/QfEYPOyQWQ9f+
csUtmELfQFUXG1mNKCprERt8ngmRRZwhC34v9qU5VOBx4q6XbC6264IDMboRq4Qx
uoKZ0I69vqw5Pi8UaR5E6vUw0XvCFJteXq/niRdR229FTmGRUh9wYsVzhGdQFDGO
OTvgmcjl2tnxgRY2AUrNShQQjI1eWuuVlpJ2c5wqfuqm7x5ZdEdpUvrrlOastk8S
Kn+s9BriQY9O5h7eDfPGJng3p2f3VB7nObIjgaibCWoRdWwYOuWYlUJPBVCjhQ30
QD7meyWTALpOYZ+prDSlqpltXelMnHNJPvO+gh7xXwcwaD67xBQ+pa4EmMyPQ/Eh
hVNR5do5g4DCpxqcLhcukvnIoyV+A5eIBLuZGRw/gEBJ5kUY1WDdZSoPGnmTysoC
N8TfkNHcGqNug3IjMz+AtXIFUnp++fO2pO+GttV9ccb/i5Q3GLdRNL366n3EIcW0
sxEoPDe0Nm/S6EqheZS4u+Os5+oewJ5H/htl49G269EvCjkswzLJr1PPTyBrD7cG
1n1vxiddLJSoGjb76SWkGvEXruR3uyiuPwLEYxwrFtBTNRxYNPCuy/wS65AblgD9
N4pJ+SCwoB22ZdhIpFQT/e1JYGYNTrt5rqnlx+fvNY5BA7NvqL21cKjJBte/Y6N8
/ffyBU2IItQ2Ed5iWZ3aLet1BL3t5DWxmOycFkdNpCnyoseN+IBZbSHrR4/okg4W
HVUmpY8dFHYeocWxps0nua30VYCqNf8Y2RCIbwprVcFFxnPmmR5s6w2zm6OnbTox
HQWnTKtJfN8HVMeXqbBlPx8EkWVEEg+fIVajn0N3jkT83Ja+plfIFAqPCiAlgxW9
WrKw5jmK5FSwQk7mTU7R7Y8d5TL+Sx6Mvn7/O2rzPgzut+v0vZF3ANNR3Kp8fw9r
bmMpbC4ra6Td7H4JdQqlcZMlUsMsGqD4q/ukfYCDHXI=
//pragma protect end_data_block
//pragma protect digest_block
f9YgXsruAsb++IDDUtkPx0I2gSM=
//pragma protect end_digest_block
//pragma protect end_protected
function void svt_ahb_master_transaction::pre_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BRbtTVtU1K82+yZa8X0oK3U4N6O0AmYQgaqu4ac+jewLkpzEFD505qu425ox7vK5
RKQnxMwYhc3iCd0PA8wIdQOrw+ZEQ3nga6ndbh6yqhm/1WDu4RduB6Beg/u3odzQ
Bjcq0fCzV35zbiCs7uqkpTPOpbmdeC4iIqn0X24DZoWmCcOqeC79uQ==
//pragma protect end_key_block
//pragma protect digest_block
Jg708u801jFAHFGHsql9farFPbs=
//pragma protect end_digest_block
//pragma protect data_block
UIV9DSvh0SsOt/PCCRs6aKClThJKFbPWicrQ9XdvJOHLsnw4j1buDnz48pDUney2
SQ6TEQYZ6wFw4i93t3vUCO23F4SHWjskNkXXo3CDYmZ8bxZwjCQP6C7tlVbaNTCH
6dYYjWD+1o71cHGBX9n0zvfxjQ7yFS3rjeE4r76bu5b5mNxvJ3VBpiy08/fRzjGP
W/X7QJazujqiQKcS5OcE1bMYepp07xT5/RmBqTlu1ImSiU/tIzSNXKHJJ3/dQs14
dk/iTUynn8CYDKGz+Xo2nnOJqrJpBOmL7spZdgXyOnYpE/PGjCXo5rhzoGIzOPgx
oW4ukDasJDeFzSEA6tH5AUF5FIY5/xL7+cv5Hn4TZAR5X2PQsZwJrQbhHMjsbd1o
h5jAvbafcHfEltf8pRQ8T19mjKR0OHRiJhhAsdgcy1tt8wGFPW/1KBaiT/b+hx7S
2DcZaRQdNXyL+SHQwXmDfikpCVljwSFw2o0+qDsy6Bf+fNmrgAaDH0dm7+RAVP3w
C8iKRIP70whHf192S5QQgz5/y+sMnQzJSFwfqoEphwGE0TJF99F7f6hl8XgDfgQu
NJGkkOdF020Cvf9KPeQNJohBjqDJsNHHLYm/kG14/lu098SfUbx/LSXMjtZgFI+g
M68bYWX38tXmRwR1n9psK5X2khGeb/OUPwBdfvpJTlgNRa4F/qeTXNLwlu31gmHp
y1C9rck/fuF1fkUNCrS3+rfPumrK7M96Ph07W8q8rsevk3TjKzHGiGpfb04E2p/w
YEn0dImkPKPrBRbX24NyPxj43lxQLCvUZT+mcVxFuvBxiS988FmUpG3T228cOqdv
H7wMMG43EfeqqoqfBjrt+7VWdG2Ee33j/HfXAS66uz9UpKSaYLeGmO6mZWX66ZUK
O4TaEDMHHzdxkKaxN9S+u3qXnLc9SZrhMEvILpuTRqsbthW+BStt5YaI49flNm/m
YhRElegsDcf+pR8Gg9pv+IZ+GF94Q+sv2q3wkMg46MZCNoHQs8Q+hwFpzv/BqqKu
nZZsUykIcxsrgtDT8zfj/hAyo7VTd8tfEoxxoQwez7cO2HeMtiYTm0/AUEobJ4pc

//pragma protect end_data_block
//pragma protect digest_block
HCgiefaJgqGGoi887uGVZUIvMPY=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VH+hJU8xiZmDeiPiJTKy6mGZC/v61uHub5JFn2hZeck2drMnbNE48igtSh5wFjiB
OF0Y8wm3Y/yMReZ6eOydgdgIaEUaaH+qAFwQq3SB01dbH2Uo0p6XDYGMh9bWgwcU
Bmg2cElcCqjPgdSkObG3UL3ru4JtPccPWGq26u9b6GQSq3Z/KuEH0w==
//pragma protect end_key_block
//pragma protect digest_block
GMnBowwuzEer7E0VMUmP7KdfFus=
//pragma protect end_digest_block
//pragma protect data_block
+HBq34KPAeNf3/pjatnR5eO/A3zgEUkKywNWrVRPbEaG4MBmKtpCPpwIhECsj4cf
McQ3sw3tdDl46wMXAAsjbXB14GfKJX66mqfK/gQ1Ufr3l0ApLWVB+rQVKq+bnNwK
yOBjDbBwPrxChKoW9F+lZejDaPKRybxJhcc3ZE0PkoNFwSxn8Jmbh0IreAKS2QtR
rUu1JOxg7M1qwM7hLEDJHialN9tqEp6C4/5/OpGGdspkemlgCOgh0BNI6iKjIViZ
+dx9hAwIFrutBlM6vqyOjicMPRplCXturlC5xSNcenmgErK7lTS6phoM9J8dUPMs
15V371qhzjG9oHVvon685/3fCYN8U8/bPxEZfzUksguqPeXnNwt7XpGvr46QgUNS
LjV7X6iqOwQvu6YwydDHDfvH5ifylTAC91Rb2Cdk0zSNFMkM4BesSR6QeGNTN+Mt
65Wqvrw2ZNMOXBD0yEolflVZ9f87AkPMN1G/6M8xTvYSweD8QVtJedISa08Jrfyt
zNE++nnFqt8tc/wPsszJ3jQzQQ2bsUtln7rPRFOLLGGaiBlr8g4aBWlDug6xuPN6
e48Dt6PPz+1gNmFYUPscQbpmwSU0QQ0D/HwDIK0Sl4xWWm5KLUORbA2FahVynwSC
2BjjZ4ZtxcDbFU410G1UT7nrl+Vg9kqMmcs5/BU18F34vWgkbSRlbLp89WXpwLDk
XFZi1adg2/ygOZ3rnxI42q0vkirxszKsHq+NVsLHJKXRq/XU0nuIFSEeMLyJEXSd
zhC/zdBbjLbzsCBRUQh8/SxOQmnKBWayvg+5y4Fph4ZlJvG5yGe+e6GZLYnOQuSZ
C7A+ui2O7cZdcAeO+MWxjDstZacYWMVe6Bpx9gV67CQpsHupCkQoIB9pYXs0MjR6
mDjErb5f7FpOJi7H4lnUhDJxWWgMO1u2bss2PvlVtNmq6f61+9g37yWGt4D0vcA3
VJOviosLfxQf1KY2Z2UoKSOFBvuE4rCUt8QgZrcEAI3BCZ2iph/i4Cy9+vr1npLX
3MUeQ5IypVDSDuvbXSkZD3HWaMVWCMO25mozsie1wnY/lmhw8rdTGlfnsvzBjnLn
usfK0FpaxYMO07qIv/Atw38e+0UG7qMJDfJqwIdP0qVqmSsIUbWNzWHmGt5DJqPI
wM5dTyUQaJLJZKZWheFDE9GpMrL2hWzCGbnAlK5+Z5zfyH9mwSqLRdlneuAhhGP9
pUVgSsaMtVf7VM2IM2TAiET+J5sKOeCFCY3cm541Vey0n+xSDc+f/jeQFEb/e29r
FIBDdL80uH4GQbsY9e08uT14CeaLjiylOlQzeSi0QaWNi94MEUWnn4V2dNHLcScs
++PdExI0ZxrpqoDfc2PynXF7ddcQxTpjoH4iJhRggqaH6At3e9wtaEWBYMHVPkb2
9Q+J9aeA0ppmZ6usMaBAG8DQXjQup8KO0VJD+zbq/7yJHA8wWDiQlKvJci0y+D0p
OW95+h8beLsw9EqL/u2fIWcgOsLQEtFryWo8z5bjMiKakNCAM70vEewaWFHSIjdg
4lN+5U+HJzUKjFHwV0oD1ypyFx7tmNJ+zIYinLGjiNd6BnF2RRwS4VWhONNHyQTw
vmSIOSEGNoZhW3/h623DqE1X3aJcaxevacRrcJ2QDBaNYsJg7tuBOoexlfDt0qxg
ymsw+E9h4b+753QFId8sEueQ+A0gHTXqdj4GyKLtQgWp4qZlqjzaVa+lRJEOzMdl
pXEydlhyA4eoX2n6SG4x5Wf4Mbodt6InL64Qaim7ZFeNOBCQRn2OzuLAxb99VL0O
pv68YT1I42Q+2SnP566rRgMhSrlpE3cH4rgiGKNXdiR2G+dPk6aUG+HnADqhA7Qw
m2UfLfKgV1s8HtclCCwrJKqe6bhpaH7vmtXeKVW0knXi+bIfTmMbUB9egEvI0XyU
26p5U6RNao8CZzu2R9Ehy+ZA7sgqfi0zZ14Q4GkF5CAOD+XL+a7jLmlRbhNX8KHO
VUdeGP4Fk0Zhsc+KQGJBduIJMzYIKmbZNu5w7IYB4/yEWb+rfvO8lcwlQ63VmWS6
VN6PaS2Zt8KacgQqFpp+T6O6XHXCkgeTLYnti2any2QeHT5Okcg+Y4XHi3T6eZ/3
w4sEqpduIKqXKQs1HiJmHKoUtHxleOx/AAOClcH3A7FMa5ftu7Wx0H+lm/qU6RO5
q8K6BHf6r7xML8LnqBDP6AuMzwFadI4IbKSySbSvpHvjjBeXdpQLBVv476gF+Jj9
e8KEx45ONrbg+DD1f9HPuctMkPWJ+m+lHT+rM3ZQCSldHPk0VOaxK4ZGz7gYI578
MRpFrmBw7WTiebVHkIDuqkCZEOYJ+cCPUPoR90DMQiFHpGdEcwSjPOwZ4vSSaTuL
G/cmVPrcdxf/GnOYjne5GgbHse9d6z71zsKWV3TSdyoCLTlekecSU3bm5MG00Rrj
28z+MdijMfN2JoJ73oMKmItSlA5IMIiQHwTRb96IEo3kFpuSPrJG34kzXwG/wGsQ
jn8fjb0qWiQHFu0RMCiJfRV9lrIRntJbde1agEiygStAGjVfTGMhvK6GlH1FJffC
CqAnTRQTRCHU0CyRpQIhJqiascBdzkY821/SGTMQxgyg8V7ozQC0+ft1PQ7BHz9q
8a2lhpXxuVkZFwiuh4PKa5X9jG/ehk1Ga6VP03zva2u3PDIrbmdqj6fYrUT6FaiT
i9ZiabQfo3Qdo6DLiuEnT3T9Ag4VJSOVMC1Mwl9MDlo2MLi2BMMk/0bqUKLnFWDn
UgKA09Wxk5VajaHM0y1N3HmRXjlbotUk2jrMiZ6j+vy3+m7cI/QvdoaTHTHUZVFT
KSSA+rj5JM0klXHhxVXfRPy4HNCDxRd7fY1pOrFnD+uHcQWTZm+IM7vrG9sERqPU
nNxjQnVFNa4OryNTbyXDolyGB5i1RHzPgQ8L4iIaUhNmwERPnfccKCf0ZqGWifvb
KYRMpH8RA2M4L98dZ4rAAVUP3vuU6PrtdxWMLuSxeLzKiQv8P4bkshQ+L/qVFU/O
bKouhoxWGTRK2l4K0ZGTGYQcmqoK87EevfR/feZ2b7e362kPapFdW/I8nopyhAum
HaqN/JImwBi8DRZQessLHHmF3RLeffOG9VHjgajREZqMZOq3Oj1gQ/UwqKQzlfFC
5ZnAzT5PXOjaW4n4UKqUY4G94JTr0Qi9et1RuJbc/NO6dpuR0SKbRf5UqpmIYmPU
H+10CvAz+AEmwBS7RVbDkwvVDgczPzrzjXNzbFpDeu9gjCdPDR+moLPmRSS/W0Gc
t+R7XDW7YZ4dPEEHH+dJcrs/VKye+xvELoh8pNC5BWfbIOiiaO0SeGjLPlxmSwrp
iz/jvKfuBTDvDJFW4YTWk4kIejSyhK13M3jCYFD0IfX+NVtugwDp2mesiymdHBCT
xg+4DVSpz0/uFICUiTyoBhkdT5eFOt0g4X4JfwronzZ3LRWeELKP+jD3weLHCOq6
FvtmhL2keyKO0UpEXFJM2K76P2QG8WcRNaNQ/GJSI1Ge6QD4ZeXW9nDegdGMfoC5
fRU0mCxBMuXyDLGJ2YUa4NQ/cU8In5+iJd+/o7df0XETdJIcBgWWrAiTsp+ycdEk
ANN4h3qE8eUVgzLoorRmu3D+OUVXXreipIPq6GzQiOMtT+5cwKDADSC9m1zbR5iG
gmfEneH4h6w6bYXfOe4jAEr2KwUF1azwR49ll++ZtHyMuMbiCu5Pojk/FSK4wmAg
2K0pJagRYSq/eiheI0h/eC8EA/5BVcZgZzcPkF6C2en4/ocji8ovnD/ABmBqXgbV
olZBvAcaSrkrI+rGrugAxJx4k6ZeINlP3ycElyyzoEHIPy24gioabDbQ1UdcVy24
ykaBGW0fSTa9p++dloNVtL2MKT7ijDsrFe089n6M4MhXSUS65OHFJ/KGm+vv/Ubr
8yrbW2jhGDzhLUdh4tf6kNgHqq633F5G6GkVwbR/z7GBMov/C542VEbzBXnMcuJn
bRfWf0k2gs2INRCzid0aMknL3eYPBBv8eUexcHz64fjCNoXbttQzWcMO2ctqOu2K
/7UI82PACSsjeeSo4fofVsMFaHLc6YEimv8/fO9Ub5lTZroPHLkVRayoqziW1baH
/j/AUDfGnohNiWQWpcNonXXeNedx5KPTwE6DxTFSwC79r9DEknhGUZiaPHF1IGlQ
PQT+Aqn3DZ4qiRK83o1Nxino1frr/+0rnV6T5FBRJyVqeeCOyRuWkqSbn8DsuoxX
nZ9OLqJIZ5MUQdvMutXodVuZb9JZ/3qrSPc4OVr241ls29pJtHMYygVsKhTndJK8
ynJWETSZ+Nz53PEjNffmzvMnFPqKPbEG0/ShLd6b5sbKeVqZrk9wuwuiiddNBR39
jpe9wvgScggSIMuhK6lw1He1luOhvrhtNo3s4ngLg8PZL6Zlnscd94alu++tULTF
BkVq1edWwufDwIWRVhQC869f5r+8wykOZvqyyfGd6i2RnPA3iSAs5ooig0aEpjK1
BpMC/W+P+4FcodAsQiImIMT6XFxfQpAaFugVjNizJiZme7OwgvzMnFXshTdK1x1c
XJh0kxZplWWYcPGRxk3j6yWJX2Ihn4of+bNuhGvBMHpGwwY79ef2ZRVHlAON20HY
l2sylkE6WHzlzDB+J1dUjO1TWTcBIP+Ahxr9gG2lnv7ZFSUpZEOCLxp24U1b8yMR
2VW3PKwFzXVOoyjP/U5NioUxVldJTCi0bD8zIvytpQOocL8LcF8+rSsr06uldOOO
YXZQu/PaCvCZD6GqilEa5Mxsbm0wpmgH7moygz87f+v8Cb1wX5Ra5KoXMAEOUI2x
8FobrzfbBDGGlDom9x/oVZeyypCRrrOM8KVQSi7ha+OGZQPyUYOXl71QQ6ada0aA
h3I/JUiB2HhzuC2CtvJKAuc7Hfv6xahoH/breBPAzFP22RJLLMJA+5EbEwAwgHdH
hFiZVxY13Pzsl7R4hp0skTiNFxuFpcmmdlC2HW4vGqtGFZRTtvTL3zzu2PTJNNAN
0ONjVAt+m4ch3vt6VSO6DofO/SHTyCgqxj4p4mJk59/yA2fz08RtfrzPDN3IroBw
06qIwrn4lcIwmi4ISlXLlwOuMF/frO/CaTMTwzaCbWfiA9+U4XGGw5+3Dt2fpY7j
qgx41M0VDGmjmSGzBKJ0eHihiknrULEJEPeBT+GaL47XhLYWymY+Fm91Lt6vzmMl
odplA7Uxb6ZgtKDQ9Y5fcn/0CMzLEwUf5prAXrZryMHTj8kcrOKxgTXOY7Nobzmx
B6WN4a6jbya3wydLN+qib7/geHGyu9WUgjJf4szYEkO2kGYUzScT2H1jwSd3MCND
RSJxur5GPR4LUwtB7W6fZ8FVmeu/HGTWSf4m00YFs+E+q1zLb4BAXW00b4n2Pgtq
2x8fLknHnSaiUu1ope+g9I7DZXruIdGvkwowClbJD7G78I30obkO1f8nEbT0b8/z
/tY9JuN7OY159sRta49O57Q4ShQCp7NOp/UvojZwlT3ZZXXAAkzEgraCgIQBcPle
kH5k2JeCAUTrUqEMUv6x1riZcysH2nhnXL2R19sXLZr8fPFHO/qq63Vn2MRAj4fo
hh3li1Jiy4winHzhJFysVGGwwTnN8tuKDNgEfk8rHG9KSAAfxI2xTrRlTXdTxdU3
eY98xpzQ6hSPdOmLo9T/c73PvTstDH+lU36vYa1Zhlkxdbn4Qf5ic4Q/aLzKl8Ho
lmHJuom0gLum/Yv05UfI/dbq/106GF5Z16B0imCZYFxEkoawkgVvEMkRm++8dQ1A
1tBNHx1SwJX6x5aTM8q+FuRcXhfXmj525pOzPKYDGNDdrxXC/oN8wiPYv19S5FxO
I7vQihIbrNlVnX7lctdHi3qxQ9ROFhaik0rjmUV1OcMCnoJ/10S40eo2oGIc3Wdd
34Ojk0T00d0XJzzZXQsXoVJrkWblouqxQ/7LuhRWPTultw9T1wKQKmc40fEY5ovh
zCiFNFDek77bmRZwXkAzF8XOjV0u42IXzX4g9Dy1RNk3vYu9EI9yA/snF3q2HLqg
oAMpHm+TFaxFF8eKIjAG1GCJFq5lP4ZKUlypAff4y/X9C8V7+4eSdOsT9AVl5J51
AxaTQ017s5ZDSC3bfOY5UzqJcVjLzhQHpyS7UJ0rMW3xOwxnrdejzG920DkEAagu
sALHkr2uaMZGrfyDHnXripU/visd5vXogHwmdxklE0uxWh9owde3j8XNxnhA6eqL
MTvjVYZnkCoCqOZvzKLyjip5VXbChnLuQM+wTCoMUV+z+qbkmw6u5CKB+yJ/64ip
VG72vI116t9g3GPpgvSkjW7HxqmcakWPwyUTAy3MwjIvZ07yWffur1YA8DY20ml9
LnpDbWWlqQryMKwrNV5EebwkjPRYycjCA73rvMNq7rIEoMnb54LBfM1SVQa3sBOq
Z2ViE6ZSvPsHeD5lgiSbHhsSGE/iWoa5AGqG8VPb4tIMnVzymuB2xRaTq3ve+qz2
j/qG7BZ27AOWmvqM0Nqc4I0gikRyOPdPx4q9naUI54m8CZ4BENcC4YscR+FlgngB
J0na0rxP9GpxrZ9EvjIZjCE+dCsPHwJraMv6qm3fZ3GqGUaQsE0Dzax+HJgx2Whg
2ZXvXTgmYEA17J3qWXqZLgKjvK8IscRZraB7tMDcjRlksAAAU4GQF9vK+Wi2kLgr
TiHCm8Or13OPprW0n0vnc5dbhEJjISjGQZacYio+YV/xLWLh9SxmKgZD48hrKJa+
qYjInuttJyFubMmCHhuzYsq1r6djwM9yT2PGK29f2s+Ybf9LdS8bnE4bciSDWlJu
u3yTj7xa1S1d9hsn8stNVAQSpDyXTAqlylWuoh76EXyCE7M24cP01LO7aBzAlh6I
JvqmgMrrCpol/NLwPoQVlCq3rSxqOZIjGeuCHXjNJfj9tdNkj4+SOVsiKd7/X1Lv
47YmisxQjR3qL7a4s3Hpd73MCE+d6jCc0iVrCjs1xIq362ABZaoZ9W4I3sCKRrGO
JBZaB4Y7qMjwHOR3Jk/wn00ghsGTG7xC8AHABYbAMfEo7UoecfFnao3kGnxy7azX
i1UBU3FWGfgfBiAyVrzw+C5QL1G7Ww6ei3aWisxAXLd0tm7BHtPCpvfl2y5Q+IBt
hv4Fs/y9PNn1V4pLSeDvwC2roktYNGSbXB2b1Cc0PWX58V4G1FZJKOvCrMUVOpx4
Ba5YGhYC2AdKDPyceP2qsZRrxu0VgnQDjetsyEzlodIpPNVem0kHUKN9b0tbU1v+
Ni+S7tN+I4ZzO+JQZY7O8JGf+3Zgj1wqQEwIweKsEYczmUyZawSlmSV/476VbRBr
0/yOiRADAj9dmRFLeJvpav0l+ciw/UDfo+bNbNk/h0AhrcNF0mjKRKOY356sbulo
yCZcJlH+iApkilHb1shY/JCBjbeDitOXE6bNBXES5GmmI4eJ2KmBiICnuq7n0mMR
2aHyjvcN5Lw5NzrHVDC6cOTdsrXM81AykXA+HeGaLkMBjwOKnqbCiz/wbzsNowaW
hoPJwY8BzRd7wEshOEyLf8xiKomaMpD9vw1ezZuNlsUzjhAUmH7L2RKn+fQ75Un8
CPoPoBrw3cTvd5+p8aiIC5H1ZHTEOBjO8bt5pIpjYLertglkP8P557UCbAtg/2hy
moZ46T1G1ERJOQ7dcXY+oMjzJO1A1lWsCRggyFlDY5A3+TwiO3jxRKiC4YSohhX/
nhIqqJArblEginypV4OJolJx8MBkJLxvuGWtD/roJmnKxK1hC7amTNU4zPE4/E/j
lyznpnp031xaWFvSuZt3o/TgFU7ELxcC652vluJTfNIMBMnUJWx6XUHD1BaqTBuj
Xrssa1cv85qoFQ+mqgXnrhPJjcXNzazXf4PA2LsSvLEuwFwXYgF+kj/bzQw3iTVf
RkxytbhiDIIdp9EpabHnWlcE8OEkJ2IHIenEGIi5IqxHUwslq1YbPElXemeMnDnz
iUPUrlZwbMfIYY0Eg03vuV64UUq5bh2U+ogUmPXAZ94g8ivvt8O8C4/E41wojeCu
CILqJavhlQqZen+7JdkwDfEoQd3z7QXuPJCqN7vQzvVccG1TXXoqXEMA07kGBo3W
9VCxXd8K55Pl3+JVfcpEeN07VoqVuNxntR60Nv2KsWuWW/uNfZKC0HwYZql/CVf1
2J41IDQD0U2A5mumm+3UXltfUUdOqBbgroXxQ4zngHcl6g6tKBlVpvXyba7Gpaw8
FwF+BwDC2LXOAsTqO3D1UXuBkCeBOyYsGi1UkoH8Q6UqY/t5apouWMTVE9Xl1SUw
4ur3msmNjvbX/1X04uwc/65JzDrVKaX07Biv2acVPHKxn415nXEBgHJ+0sNCfnBL
+kniIPvIeuiee73Y93siLq1Yr/wZRVKXdqejD3Pcbqg2A5ajK3wa8b4rxLLSxnKf
fh3P+ypS0x088LJ26hg/yyGr2H0mtLZrTALPw2m4i7ZfrTc0ZAi7DI5KF2ONN9Mu
2uc3RvNF8H0GaP3XxbHYaIpYGcenl41uSroc8RC6ljujFnEpj8nVao6Y9L6wp8GC
FzqS6BKWFp+8w4YVKKzfiZj2AUfAYmkISCwsLgHKzdqmsTmOZm7VQm5grFjmBj6+
+/LS5Vj1KHZ124QciVr9jCd5nsILDyH/mL3TxjZVfW8SO8VGcrTy9l349b4E2X2y
ff3HAl/P8EpHNKyrLVfOVaeWvvg01Ky7Bpcc0XvNfnRqO7igZXeCebCvnIT5V8uk
rHSEevA/0iTPKinq2Wy7/5cZY/GeGuusUMLQiBK5rzZhy2SDjh7Vl39rwJBvTXDe
pB1bxCqIDc1Ny3TzfLte55wVz+f1wK3cDYryIZz+Suinq3kimvgEPU/SOmh8tZ8p
Sc3WLJoQfrRpW4+SlKyXvIw9sUiNQDRs9V1nWtn95AP6RgQftRBlzAluMRiflvSM
5I45hry+LGbXIEXSIozZw4QmzPQ1f16S6BSb9qghjSQ/+OofueibSLmtXvrJYRRr
aPmqmlYy+0VPMo5VBBGgyaI5v+erGFX2W7cgBQn/JfeiKRQfYqZVDNubej6zhAPo
tnOvoWjs6ILgDqag59+zq8CfWTkJyAXOSLFtHJO5LxabTxCzQ20r8pdUZg5R10ti
4EHOmmTYvpSw3zSRzxBZk1adGLUS4e8D9nrZ1rUbJfNQePgaGJGHX4Zrc1WSxxTP
MBSsg5IBGOhOFTDoFogOm5c4udPvFPMMsKFtt+KqAHdMofEYpp6nKQVKVBwcuf7O
ToDtVr2y9TcwTt25ov3BuNzeOkXdT6t5uQprA79Sv5xLS09Q+m+HimyDI2K4GvBb
l+cLaRrjfYBhJFe/ABFYHdfdXPT7XK06Yoo6tO2GRYHuPmL+IunaZdYgTbl5VkJI
lZRcgBY6BD19xC+3/49GV8gTTcCPeEXj0sMYLE01lEoXvzcb24/Zv1cbtpg4XU+v
xoEf+2+9OVSQf3fBUknHgUrPdfKlTrtbTZnzqR7wkVMe1O72ACOc5q7qjkZGKxt2
x0LVuW4RXWrysFPNuDBn7s1w2RHZafuktX/68L6GRDVN/QaFRGo277bdqKXf9lYL
Ci04qd5qKBxligxy8U5EU89d4tv7tRftXECaVFlIpJVWxIkcCYaDjCpxOtgK9iFD
nNPMJxCLFPI/jwRZLyh9F3y8bjJ35S/K73uv1YxO7gyqdGRX0khexr4AupZ40Wa+
xyJC5jm4wTQc3l6fXnCwiUTlMYeiRwpdLUjP26wcsRG6L1vihJ8xrfGweSmuw6AK
VCM0t+85s702jgJLL13EuaZ6668G9PQIQE0Q82S+pc1+fQ/XZs0YVoa1ZythZsXF
p1RbVwdm/ksMZhz6D1yrJSW/N0A4+E/eU0/WEy7gUE7x+fGDiQ0aph9kU/lj8FYW
WwWiYxhJt5ok1h+DATFVeqyUoDXtK0h8yIUkSackaTHMzpvfg4ZOfggZUkgm66ZV
xpcKE4QvKG5e7aQ9RJkT8vDRRNh/mMiF09AL3v125OSm9WyutQ9jFpq41tATv5sz
Yzz4cb67NQqUAgtsnBb8aGf7Pd1t30NDTKfLpUgKwZIChJGXAvHpk8SDaiGMsXRI
6exkMtOmWHqUfHpbmNhdcrA+gDyxZ80wtdSnw+S7YgaWX99cAFP/gAjeDsYqVRfg
L7q3U4mYg6/NKCV/WMvcytAbq1MtuwaC9kL8Av1OeBDDVNjwVgDr8cgAt1txwq0O
YJwKJSowD2D6e2z4fKcbdIvPltbwnNK73PcliVpIx0/yZ7yQ4tbQArNz0sji0tB4
sKssfnCVT+n8lOQeOj7OQUqTSoiGa793MyrshHG6LXVlYixIzY8NOnVzoIwLZF3N
+QzZT2pSquKM9LI1QIj7JA2V/fgp0GQbMaGTUKINY87RVdDUOnF3h4Y7a2MPOBCi
q4jXuG+DnZHTaF5XYRtmaEBoexckCtRfXe9ljIwJLuUsvqtASb39wpTDY7gtW0AL
7o9L1DgH4epXKROtFswy8xAH7FUzFwc22GRHZ8bOqlLRGd33MkokiGiGgf0QrIQK
BpA5MVuVVAJenwSbs06DOtmOUb8F81s+5OcqjJmlhX+nL2uAjXEdwVfphO57nZyJ
onrD24d6Vy9s9CCj02FlcPihQDWqmYfLl/dRTyzFMdqiXw6cNeqLjCJI3/yxIVAa
IZiLg/PmoeWGytr2af/3ogeysLodfEreKvq61hrxqlsyqUCbz3AkAk6cpp5Ft6vA
tT2/7XFxuGaO+2EwQSHRbHXC1WNhazhCJW7kOqvAm7Miqj0CTbQpeuaKy0NIuDgR
u1btfwsKndBy7zGv1ch2XbqCmUcE20Tl5pU/UrsTue0Sv4S/FslnDAV/+xtkLLVT
MiVkQkpfoFeynrbj1xXRW68RUNC1nEkWynFbV8HKbmfA2gqNIzfoVD85ew0189jl
WKrTqT1d/X/rcMbpANmQ+w54kLvuf1wbRG3Ce9RYkwG3MRWR2frtf97FFc/KrKmh
M4LFREUJ5SjTLSAKBo9/PHITDRT6LDTOny2G/jubEI5EdcRAhhxB77PYbZ8uWqiH
taxOoiaVHuQOYY3AO0DbRe7nW9djzPpDYh2Cya67KNeJ/MPXBf2SN9AfJ3bSDlKX
S+rnHeLNQGd0Hkln0v7zxslstcsky+6Dop8x6zRmUxkOsaZTurw0lA8pFM89XbU4
Xi5dduuW4SRK8lRCzueJPBmbuM0vSjd66vVpaElgHYvJUmA4xLtgSBXCanfZhVlc
kUOTlV5f794ukyxvqLyMzqdRnDh4dOV/B7cbGaEmi0Vw6rHux0WtOssoAgvbiqbx
cLIhfJdUIu98StWXxeiXbHIhG8sZ3lpx158PH6CzLMcA/rJW0B8yaSWwhXg3mCzF
sUs6M2aYeGq/eyKD1ZpZEmbZh1+VeCCg1b3lnPi3VzX6grXfL25TJ+4Bc08p1rrm
ViIU9jAImYukpCQxOTj2a03gzqFQRx2keXMEeOP5EVcrulVFkDI12ptr1/LhAYTN
fh2U7XjyqCzFbBlqRGrtMiPcHElUC1ZSePQqsiLpp8Lhv4mLOhveQw4VkslFHOSl
yVMGBd6v6dHUlrjjh/vtJHkxbJ6rjaiR+CeibTGTXNxZR2k8YUnx5ceSjC2AxKDW
NgCfvdWMfPyqeC4j4pgt3BH1hbyLIsiMkXASJ2zANN9vpBKizrf5fYBDj7TbeYYz
sMooNiWgWPo6ShfZNlUmyEk5ECOIctuaSI9NsxVY/6F0sh9BO3e70KWyZdEYtvY2
7ZhO7Y7Tt6IhIJiz9G+rUk/mVOm648uOcx78CNhV/L7712alMcr2p+uY/Cj9AQaY
7g+aJOI953Z82ct9/NVL0oob+aqjKjrdSMn6mgGGQcwAEDyc21+g4bnleA/dyTKC
5xgMiC54ntzplD7wqJ16QjGCI67qMXnPEuxwho1c4hK2l59ri8PLf0VShwbsCM+e
HXk4zinTAmkCxjWaMBDDzRV3eXnOzM3F/lrC3x3meJSdv1wyIJ1hXNHJA4y2fna5
PqvEEiGdH76OkgflCdpGiXRGOOTKUgc0vNOyPOVv40DB7xh0iaBTdqCGpszL5wNO
luymAyGIJ7SS0zXz8ap4QAHA9eK5VI4zC/madPwxdzP98fvIuDa7/CyK+2SH5Y2G
/2Y0T8PjqCvOM8GEes2ATagf8M2PVT9yUsYf2dp9EH7B9g+Quc9FZVwplwbEhoku
nMLYsV2imZy0cvXGxAAZ7eN6PvI013S1o0Q7A3PYV9x3zyhjfpeiMYj13+lGO81U
K6I3mdq3sBXAA59fGy8/3BzMw+FZKf/UH8JxP1XlJXu4srOKS2eiG1xSHdeHWkxa
WnewcpL81YkmYWnxGtr9AhlROVTA0SmPYUj0jQAzthRso++fcz/s7ZA5rsq3b9aC
CnQ8ZDDuntEh3KPsiaXZ38WlL8ggkb6zXFE1vPqoHpCt5iXxtcX0pgI/bmv7ogX0
GkfAlshvAIrbSIOr8OYD8ONgcGQxthzTAnNWF+mvS4kEKb86WCZgsbKhXlqUeyTA
LuHPtUTRraPcUVkh2oTYS2tzzwfa8PvfLsppdXJusKzRATB8rrUCOyzoGpY39Htp
3qI2385kUUxhQguCYKskxzr8tGq+RC85Q6fvOwprDNy8kB1jK2NY5PxNNDfixFLA
yN7EQTllB+7vVW4T5brBYXYsd5QZ/Oney4XugVByR9bwEiX6Oq/vlRO/B8dDhwnX
/MbYZ8mAnXKp6e05+qK524gn8N3yOVYLWiOBj55B35YmXnT0BR3PXDg3pzBZCoQg
s5LBUlnntqCHsgBzqiXd1hhHf2YKYqJkB6UUuCzWmSQJYPdGdxwc4kzqfp5+GRf1
p/UMeEY1YpWpSNJ1CqnW1Fm95yH2OeNQCz1/GifHRCZRodOj89ih8XmM2wOgSn8h
7CNkqCIry4d4EUxskRvNfSmBDFX9sM1MdMHnfuyuDRC7vk4FmNENG8bV+ovFmits
XgRDZ3YLyFoCkXXfBS1TI6xIkZcHeZFA9nOh/FP50j68DXwO7OzbaRiSna/Uu9RQ
1SuZQqnITw/NkzBEUe1YgmuiUxTmx3MeLUXsuoDLG03eaTj2wWoO4DEddfISxlzC
VsQf8d0ZXYGogs88jnxNpHYcgBHEdRV0KyDpI6cMeZSxQbHpWu7l+y6Rz8ZzpPXO
zoH95Wt4Dxbu7KCTA7wMMhKRbQ/Q3B2D6R0ozcMSgaHDsPDoBviqcsN5Frq0AqYc
LLDi7HZQnR6FbQ8XpV8PnRbGTLT6E4i9IJbWduZFQ2ykdEVMNpi8lHhDjHwzFS8t
GRUc/K/RLkP7yno2Q5o5F5UEOUi7LlzHo+nC5+K27QxibR5yp9QRiSwnmY0ObUb+
lepfDZA7gy/0xaV4ZLWrVxt7vY8avVj4S6IxKe2viamzCWEspnSLR0L5Eh1L6dmv
t//PDrW5YG52DUMg4ylrNJrWAxMe/kXVWzof9stoOynu04jgMISSUHjWPrmBryM+
kCyTgWKAEiKDNRyftK6qcPnthDFhdkfcjX7sc6t56prOv8ypsnapQ2pGSzhE6hIa
U6eomYq8A0a17sbKDMX7rtQiOnrXhEbrO6Pf/53qSXkvxdkeNcOzSWZJvelEBO6k
Qs0EKm3M/IqENIhMjlTkWbsNlYlCoUYVxf+KbBe/x7DMOZHYP4xfstM8/FkhyHpN
w8r6J5vSd130y3kGlRQs4iCP4nYw72PAzp5ZUd1o2fzcd7L7K8eShxIuCfx02x4q
ytKJ8s4Hzep+bwBBCIT4kKPYNHsQohc1idPINhODSGqOjspN3us7Kf2xUg6ltebM
Aotb8Lwo9OzGQUDYXyFGrGzGyk8VWfuLuafcQZCErBWEfwWxx4YTWhizEVh7hBCw
XoBZWik54+f1iNtSajJgg21nVCWR3dsk9si2+d4yHF/WP3s20wz7QFG434IdMgqR
m9HFKIjFOtI8RAA27um4yDyE9M43cxbp3cPRb0JhQ1W+C5Me9Rwk2X2fdhGHFh6z
iG4lyKbjLd1zel9yJxpY1HZ2Mm8ymJMaPJC4bnD+Q5EOJ52H/48F7Sc0U+lHxs0Y
04ABC32cWbA/LYgKZVkjwOVmqC7AdQilYYhxaeJHqTXqiTwzlmB8/4gh5RW2ASWn
rn5jgU1z69lHjgCZ9XlfgOtB9d6JSekwdioaerz/4E2hDApbczAddu2blSmarXp+
QjmaPke3bLZlYBKYCZMp6JlLOU+jqhbLyJYrj1jPVORhIQ764HJfitPwc436eNI3
drKXdIaN6EgF22k2ktULkXrskWCiMDOi5LLmz7nu2zOEeuWl+XQg1o/VB8gE96oY
VjgsXZ8qtWVZMpEpI2lf/PVISzQ4gPilS3nYVGzROC/4IxhPlTnK8mZSOCb8ykhb
LLpXEtrH+oKIsYiunf9k0N9vln4d8Fn7lbb4KUFoCwWRPdhcqXvOOJJfN1kP6Zj2
XPO/1TEOn449VWVY6ODzGwuJEjim2eVVhgiu78+DvrhaK2Co38JPTwXLdPq9oMYf
E8aD21yToh2OqBRCyb4AM3hXowRC3HHdcGkabOME+DYfhcwjbWgt29CcavA8GjXR
njKJrSvCvwnytYQpNn8FpqZtOo7+IVI7Tg74CZzAToorJMPPJg0gRUyWrVPYg4H+
9GghlyyE8TTFBkr8ut+pyR+/fbyS34pgJLrO7E823vBwk85ilSe6IE0wIFYXgGjG
3bPmuNa8FqG3jOuRA8D2pboRX9/ufBU6y38/E2XCQrf3spJA7OimJCLgA+sP+Whn
rOtiVeMz9W1j7j4ckjUWFLwGDC384zjqYP36ms2ZrccY6ezN2NZGcdR92BkoiMbH
jzR98so0/1MqFOINwFvP6QB6iFHACLp8B5ochGWCtUxgqwqAwac/8I3rspihL3jz
bYDCEX4StJUCu9nlffGDVAvaA82I4ofA419QWUgsGLD1l7OMdDrENe7UQXzvlG9a
QWVzLg9mGBBO5yAy6LAEa+cE3XCGQr3oZtxuv5O/I2Kg3h+jrfAI5kR92oUjfnqy
9A7eti3YK58x1sGF5O0ob0tVjcA3/n+lsIq8EtFbT6emLKE95fr/pr67ekUn6nY8
E4bMy9BUDNeGnj3mjQo+iiGRPjPVtgygF8hoQleZASyCuS7B29y8bJwz5BXVrq6B
M9OpMbZSPoUw9MNk0vg9D93AHYM+r0ko8SZtR6O2QHI6Y+Ma5pE5wEhEBEB8kS3Z
ZfT+zcqYk/V/br+yFqhM0puNAU5slgAvkBemrID1QhT5h/AOIYn8RUoLxqozLNMs
3KiVI9cs8I1rnPyhtOYR4gOu3sFVS4OEDoUTGMVlbV95iMgWCbf6Qpe5utxJwE/o
fWW1CbffaNbhiqlTRPSYHKWuyO257MDjehmJf4EwNRvs4LE9IurKNg7Y+M6oOy9z
kW3YmUNxe4HQpeC6DqMlXQ3dF/6huop2sLnTaquFYLBjNrxq+ECWiGQlLa0ugJji
r8XfjnAPM8K6/Hu+3MDYMIcBC3gMD635P9U8DPK4D1QU8DIzcwoaZ2wpgBhxZfua
Ei6ohA5SyyBjNeqDCO6JUqDGuQM0I6V09xlyEhJMidc7W1dUXZtfCXINkWRoXwb9
oZ43TusnezJG5lLlsGTHPm1dbg3UrCKBSy07qk8qxhdqa6oE09Ylitxd8ObApZ+t
cdsTsRwnV2C9YKNBm5fW3yrCf/VefGRJbkg+r3Mc5/KvsdMvWEyISQcVwwiw4/W8
UdyPL8dQhy+JlymJOTq//0dyBIs0ySvrmflUk61VUReTwYq9ARNnipwrSxU2+uJL
/y1WP36a1ZFNOSbFw6mDLzTNNlzBk7i30uZOG/9ihL/fyxQegwiYVAa9kYDdWqWQ
8uzN2ktBi4MrtUwuR/O6Z+RIJmoUsKRhGyo4MdAbMmrQo90sYUhc+HIA4GqMk1iA
K+Y4dooBC+Y6G+toA1mMPWEDCmizleTdUUwID9kphWFinDqGqQkELbSJgyq1Y+zf
LYOrT+exL0xU+66+tSI1Y5FhOPiKl/QdMsixWl5Kc5HvYpYIIL26C3262dP+RGor
2QNlD5nTixjBGQxzPEomedAeqbSoRbX4PToraVZkHPWLYcDAjhf5OMBLAx41h0og
ExSG+27cFu33FjTamM7pl0FpHoEqerDChFv4vNM9rSL/wy6MV4J81rSEk0lJS1qh
1yr+wO/fFRbbvEh8J+zOh84+vwQ1uzsKeYhBlnP6jBKBnGdT+9Ln+bbU8hlU/sDQ
d/qCrMKPu8U4b2UuG/Au3PsLjV8a5Z+02kozPuH0pKxNoU6x3AVgNREMCjm4OIAc
J1YvdFoBWPd1CxYF/p806Uot86cI8hXC9C4MQIWS6OU2zbBOwg6+5SvL1jgog7fC
f0Yh06TVoWULuH0qQ2NdHMqs+uM7jicvhDzmZsTq7No+RjnmyrliKa12D2I/4a3o
W/ubmxij5S4UBsiUCosARTS34EtxOgtU5Qh4vrhtp0+nLcWtOPgi71Yv8GlpKtf0
GXqd2hbxPq5CceAKAMCv+rqE9LPsxzEUND1fDMZYKM9/+on/0FI+nymQhiYdnX3r
rFePz2e3QeLPQ1acIyFVg9tCzbUZ217ebd6VU20/t7vH0t1R7wD3QKvZuEl4I5MM
gipWQq4Wln6TGDkljDOYEcDl1OPE8GmXeOgK+UYbjYvksXPEOivK9kPOlS/Wdwr/
s/bm//EkMs5n4wbl4LwBGwelHyRw0KAzU58uwQsrd0f1EW5PxiyAJWqtY+nY0sML
Rw3MQWo0QBee5WyzZHhtpCA4FqAKobbzJsW9inONXNbSoZKx8Lp936W1GPiT2V4l
bbfM17jmagUnNGSgDVMv8cRSMi0NvEq4elftzB/XjlAgYAMMbQ5WNOtJC61e+yRC
4cFgzWO96oP9mz+GwmofnZ6drkzuExRaqUIKgEb6KV03G6cfpKAYhfPRFyR3goV4
GD6nJX7aSS9iolwRvKeetg0GvKiLxNoekReoE3EcnKi2A86xlHQ2vm0vyAIjo6nt
MXTSdab5dFPyf4+59hnANvi1vU/Af1zX97BX9tFN2GrS2AAQfm2ocZPqBPMbU2YQ
Mgc55PdQvwrtkeHjdUq1Vc/5M2qLQDP7UKrBpz3DQrVw6ZPSOtg7mp191y0ydew6
Iprj882cAUQmmQ4T8xaQjzyaLGk3pEZ2vWSfB0fr8Ce1HQv86Sk9Pu3qnL+nJUTU
JhZog1DCTq0uk9pF+BUataNY9GtTWa2nuj4P2KfeauGV6d1omYzfTxsqeSVxkpZM
WXkFHTGQtvDcX0q3fdF08A9Qy8REL2Doheu9CUAFJnTTCuW5ofVkplELUDJJeP4P
U28fCkMN4oMAOVpl99MIffSu+BhXgH/VELVl9D7fBLu5NUpD2qlCRIDQ7CYfAnip
+BcR3cHiUFgtw8yNct0ja4ZBJoUMrB4zItmHt3zJg7gXIkDkhI97mYs6jPRdN535
3hyVS3XDFl2Kqo8I6z9Meq8pfZ0zTBhmpUlO76mP+7TGx8ws/gFk7RH+JPaLCDsN
jcH5ivAa5cQXuqcMRsi+7/ZEPTpiQfQXLwsAAKLfsoBhJiVfBLgrQI9eAGXgPqa2
5Ab36smCnPCvkR2yqcTq44Urq/AlHg8ULFNgMA1PegaG8vZZhw0g/qVhmWfNEE46
R28T9BAVWjx1G9y5zaw1co/vACy+K+I0gD04EWxlVp++sB17uoiMgCX8vkFpEzIw
94KFbswS2cX0+X4r7DnAdzL/L6+5sIJeUHd/VpNgT+lequ3ri3yduUjLqbgYmQr/
3PEJrvwq2HNEFNHIOZ2OQlRlRLd2eAdp2tN0Z1OfmJjceSUcYemTtg5oKF0VCDIl
9S/L6ugaKaJH6sruBVpEybdpf+je3ymB9GisSUaYo4O7p7s6HSRcgn9jYOCgvIQd
6V1HH3jpnSKorojCnTSMvtusieEonRGsNEP+l3ePNZAsOraS7Cr6nBBjnsdB4Zev
4p3D6PWfsPZLDcPEQMglE0dNPuHHZAsYvbNTl4vBwn4TSimVL+o6rkhLTssdoTlL
Hmvn5nI4k7NByq2kJMK7BoofdxpMhkvyFhGVLcmKEfuroE8V4rAHVvYocDSrzOiJ
MFlug6eumdnak8tgbz2uKvq6J1W7jWEBwx+js6DK27s6V1dIwKUmySWPPQdQE92R
9Ijx1DZTyYAMQJlNgfmwdMA+/KQZ6zBSTuIdJzXNu6Rm1uN0vYxtjoU1+DcM5xXj
fFLP/GQma+Amj/8O9t7YlglQ+vp0nwqUFJPsYGX5CXAOe6X2a1r9DNy96uPj00UD
NbWH3OgzK4nd4Cm+sxDByYCRxpJkJpNxyAGHLe9IUqfFRCBsnbyOATgSPDqHs2Pw
N9qEh2HFfjHWcq3viRNgB5eRMsU8ZTV/HSiPd9oSlFZHIefBUJZEMl7d5c3B5LL1
/nYhISccLnmpbgkXpRbb0Qmt3mnD3ywcqFnTSHaUOaDIxtoRbCxY0juB4hExgM4A
5E+2O7lAcnWF55hq90iobSDhHS6T3rb4TfXgeB2Pziix6cuqPHlevNXb+ovmxVkG
AHlon+K754Md4yhXbb8ipsCASNcLHEtz1+iPHYct1ooDtuL00UYwSZG/bOZnIHi9
PYOYhnoZj1yo8jpAxQVpbtZjJ0rQ6esIRAOgMXnSV+zzML7s5Fro7a78tOfSCmn/
4pm3l07IzGDJaTmqx3swkbh5ZAanvkxvqR3tzOIiut6fXwoeMs39S9LbZcXwgBzP
lplHnvdr7itExXu4pGUiU2zn1+UQG4eFGIxwHiyNMkPd6aaJHb+72AIcdAKflxG+
sN0oBv8CtbInF/uZ95SCQhnYPFVhCHoWHn54hHVbQHRJxtEah3Vasj9ySbBZXESn
Nv8QCIdjoajkWKRzmRFSP/VNtZ21XQBXZzT3d6MgrKUnTW4euICDyz88MKitm/QC
m7GhB/p4y13HsN6C1jPXz8CDjGlLpZPitZIOby1dQ0pfxPZVC2zm5fH+9vR3yzoU
pYTbrTzRBpdg7XF4XmLIi4AnfiY5orVtXAphcWIdHZB9QAFV26FhTGgYE96x52Wc
9WD4m4138wRyMxVUT73Jy+Mz0ax3Qzs3YhGy70HYITzrz+CDxEDG+zZ30KkM0eyj
UH3iaFQxLBMXmLH8N4D33e7louJQ5UEN20l5CPFn1TG0tjhWSrt1gY/moZL7Gc2P
BwPe3vliQWVmxHsEiNbo0WhUnincE5i8uVESuiOl1j8QAdQYXPw03QFj7nCiIML4
vJdBDeDQJqTNCyZu2Zuath3ErYyQ4jm0s1BJeXsLA6DLL1Gd58CVxPXfqlfVG+pg
LoABVOfbKAZ8jpqJYl65d6ivJE+c6Qju+n+tCDDgDXkxdGdJcC32DtXv2HTR5iFo
G/dPZsuX9uj2EfsuqaUK724rHLBfVuhj9Vc/fA7t6ejiyZmAn52TmvS05u7MRa8A
SVrxVp+zF+ZgnEoYQ5nOUwqXoNZLF4BFUU+SR3hNgK3IH/AEN6bvsXbpS51HrZBd
mCDwzI1kxb7UAYOeyfU671RmImYIkERn0qVVgXp6ebLk8jZ2LxKKw+f7lEDNbEVt
jlFRkbDsMh/cANdSdmz6Lmh9bVS+yzhCJZle0KHSG8gkkaNQX4x7dq6p4oQ7K9Op
o0Fo0x6DpHgULdEMkFxdN4liov6e8locI3/tgmvhbGax3yB9Z83foWhxdYyt/EA8
SuRJmNCUXH11s/aPecZnD4dV1A/IrnV75lNOAH2C7aSSo4TBm++098fFG78x4OdJ
pgLoXVBMDADy3TsCaWCHu5+SGPvIOLUymMCBq3yRDRHuR4B5CKtuUirCOuYJ9Hik
6DmRTbNuU7xLQjAieSYbTspJcLuU9K7mZGj524RnQLYlilV6cCmPJPol2hvTT6jh
QsUOFUwVdHNznxKnaWu05FJb8kpFVBYHod3+KBwQOcNIXjBTTuV9ZQmnSfgsFKPl
v2cgXSamnKVSr220gq8aGt0DDDnPiay1JmAVAx0d/I/XorMh16h+F8yIYLnG18tL
GpSDhzSZuvXmdnIl1PTcLlRF1mYbK+HMt8i4I1nmUPLhAg9RhuBrP/Bb96Pl7sgf
Op2xZPWZWpdAUyRkJ0Wy+a6lIAf7cGNFBjHzHlzaeXaq7VVlOCGeSrtVs1d6mr0G
zaC5a/EpGTgIYB7YOe5mOd2Lum6k3sxTEy+jUDkOIrO+LduWzeSjyIZWy+1dn9R4
SGsMnGYAA6cuZ8lx9Rb7VlQzSHHnFKaI5lm2dVvDDfAVBuXIth04d/Dd+FgSgArl
Ud8Z+02DWwTBpWdYwc/otU6qhGLyxw4fV3x8JNTsainOR9CRN+uUENtL2KFVxsO0
qpDJN3/xutt02z078LTrNvv9zxvoriyJh60hVbN4oaZ8Kv/x68n9/C5b1+qes5XQ
nTFySjS+l8ejUFUwwrRzTjjOGppYXLUga+epvUUlSanZjpC2xZDsbsaizeM9mFYH
ioKTKcJvYK/yhGFDGXgjC6DtmnlcSWCkbsCJI5iRgLqDnVP/h81bQsUqEr7Fd4/4
ebG78SLM81iEZkuJn6TuDLrAO2ykFNBbHUmzlMjUX4Kulg6TAUyu3bXOlDpXZVmE
Ye1xdwrZg063gWsvRCYJB5tSOOP8u7Jgr950uoLXu4/Fq7JguMo/LI9jZtB/5ypE
2rPlLyXN5PP9B6nXTd+Coe8yWng5a/n22afeUUflvq0Aa/D1QPktNMFFccyD9Ta0
4wwtzzZprNqqXECobyuAbtA8MBNKwRtjliBQPdQoLs8k1CBs5HefLuZx11ZYo7x0
nX8aSctIU+41ByfzkYHto0YNg1HHQQGA0/B5QZxvy7GlCHP4uwvNE542jgDCGlA0
ZpNBb+aahP7gEqbSzSKwiRKGS6d0Fnphw+Fy0HZpTKfXTTA1e+1gmuhsQEAUiMbB
iEaDGWwIzVdDQyXi48QjKhBPoyIl49F5fgk3xIUKJqksnITAYUez4pphreAaGdaP
1XRcmlje/YzSolUxUMr3fNElaDyI74EnhCPbhzX4xwpkVKlVLfQOeR46dmKXXpdv
hnJajH98QRqRnvHTQhIPUDjHMCDxre/uAkq79pZvLzQDxHB0bObxBff6OHMinoOt
CNhDut6BQk3y9PfWK3IRVcX3R65keH2U8X7vkHM4wNX+GfZJ3sEBCoE2ZH3G4XYA
tpYyaFFf3Nfk66LULHHI4J0XJQCW1e4C7egFwOU23fwvYIhDVP3gY0k07tqWDAa0
X/11rfrR35ZY0MroeHEp+qXgomZ6M9naNGNov8/lWyziqYia1H4uCTScpWuRT79W
H9M+0LaKW5GvyHNIReX9Aw2iCN6Z0ls6QemggonEJoD75yVRLNHJkXRj8UfvxF1L
5jRrxQ4AO1DvwarxfsdOJtHFHBvrehioM1Gmb7JGC2NuGgGqYc34GDcuD3plXpoA
pG7TIoD0sTsOwI+dQb3ud22cjaw/F0yJe4h4FkTBOPwmJnFF6QyW92CPhlTk2SF/
hMjnPSFEEZYlgYTjVtYy56MbJIcuI7SAk/K9UGDkiD4QG8TRGWI8lxkHzixgCEUc
NcLaOOHXiCgMXLH2VVq+FTuS+mmx4J1VTzq/jNA2EWd2CptMQCK1ddKiiv158xIg
f5TAMAWo/kMAoCRDYHWMs8Q6Sf7ftzihxNR/vtR/Ghtik6Td7A1V23i26gRkuYia
lCzGInwX1tGlrzCi0lingdwq5LqP8jirqlaJiD3DHSr3hQrNrU9IpoAA3YBNUv2z
uYVW+j/wf/WO3Of1WlGQf9SGYUs9C7WxY6HjEi2uVnvhQ3L26L89Z48kHehRDp33
RHAmsoDyhlC1GaMkKqa6qRj28SbPmHmo/wEt6h1PxZxL7FQ2nV9J/l6TnK6Sfeyr
11PrJfDXK6wCzD4gXrmDf7K+ZmGkqSCz01QiSCIhvg/bhm1/7N5ALXc13PjQEIpE
IrkFTFh5/e+57YWP/J97KbxEhWnty91UYppg/p1hdES+cJPH6LkEBpe8w5LRoNo5
55UHndmbU4KbCGK5i/+SykzuGhk5TgVzibYM2fNV3GyZSPxe43w8pc1e8FYqvHV/
T53gVGa3lyoXcx97RFUWIXCFmtv7lcf+x2wX0iai0lGvvkADHkz4M+vdRPBc5GK0
75fNrA/PqV+KtESkYIsATaCD5t5n+EpaVAGa45xB4slxIAqy5Q+NgDhnAB3lw0A+
bfDseUOzOw016014uwmUZeAl5TVpBNgdHb0e9YSJcYeQUiuzlIhN2IifK0aDTNBl
YQI1D9q4ucPdNQaMVFAUcrq137XF4097bEO6AqYz07bmv37cjWQSHwTDH2FATJJG
HSejX+KSn1myB29u256mrQNCsgsOLiggHUWQV92WONIx/1JkeL+5ywMiUjUsTVN/
15z3EODb/qADgzYjeYsB6sw5NFGTw1EGfDQMm4nFPTMV+N3BgH4oAGn6vemuk3em
TIrn458tAsJTpctS+zi8Js3eEFepVn20ttd3fuI93wDWlxtogZYlPt4eyoy6sWxt
eqH3+xDF4ARyCjikkAHGT8nz+BNt/tf/FmBOp7gn/B27YuuQtVlHtnAH5S+9zI6x
GSJTmWXC5BbEn8HJ9kuG2ExvVK9OQ4sj5L4NMxKvzMti6ORgr0Pei3ojzmFxJkfI
zokiFXQRaOkXkN41F56BTOr1GplRu9fQCCPcs1dbKYB3FcA7sHtEhII5KITxKfsQ
Zlirjgs5Ji7ifbSp12ckh5n7v6MqfNcDttB9cTrXN13/ScMRqgPo5riIEyYvg8hM
DdItqGk9MK2nktLDudGHiKGUGZAgXc8KAsy3tgIN286/txUo8yj5tZL6TLXWb8xO
NjrW0p4yjN8knHIoLVZmU5AWGO25sbawowwSlGTS3WsZcKTDYBi1k3jhhgY2vvTn
2oEWxAEJRqDJxFGsA+2gLc665/OJqSitrtWQZuUkv12DKilT1N+KEaPzrB+oITHH
0/7XGDGdWe6qUPNvuVTdYbWYOVOa0DAfD6d31c0FTtvIPtG09CyQXZxIngaQ5c1v
GOywaqBhcgwB/ByhqkCFil3zk+jL33R2de89IY24DfcHzojXpDlGDcmC9c1GZ2f1
Nck7tWFQePvHAuLYeyngjWA06v2ut0S3YaJOqwfBCW0J8/wIVa3joEqzcwySpxq3
lWD61b6+Yv4EBB/sGrbbxnj4DbBpA+3F7jb5YyMJcORn9nHeYxgzUNVZNGVRyLcD
Jvq/CXRMTOQmV5OJLVQMs+KwrdPTcH4bBIGcod4R4JaqVlnrVEfy3bItN+ZYawQm
qAuVCExepOW7FT2yVsaf9Ac6lKjqVbw9VnsdfxQgeTYN4Me5d6s2ZO8kjY7IlZ0I
uqKLzoLAJdSrgBKp9tdrvS68iQoGvrLvDnWPeqvGr3LkFLVbIFchrurNClc3FeyG
JubVMpMYemHizwmKVMSY/s6U0kHkxDlWu2bgI4Q12MUTTg4IgcnnN0WwbU+l+PZA
d9yns9tRBfl6HpoTmozMQnlv8bvA5yX6ZfGCGzCLwgYdRj5r6GMm2x2Wdk+CgRwo
LRE2BWYFs3vcFF9psYE0BNhVUxQptqzDcwVP9hoWStcaaZvcE+FY9b6dYlFiH8ok
nch1TcBEf9eyRj0cLzs4EMXjWdP67PXSynF8A1GfWJUGdgZc9iKRdYrjG/BnAZ7l
hmK1rtVlhW7x9Wh9D/VEGao/6rwkwnrDZlzJmEJKiYm+XC1l1xZ9vYqgf2ZWQ8ew
kpqRSULDXJSWYNb6RIhvEvH/4sGNv0mibd28mphm0dV44Q1v43dR/CvjYe6Juh1C
34RzdcHQbdDUBu5PWNToIvDVNn0mJ5WkiMhRDegtEsKfdZF6b+i4ZETp6kG6zwj/
q5dJgYmKEeVi9IsacamE3NmnMk+YdYhj3h6J3hWeSZk97AzyIheOLu1oDfnjiwRF
eDjs/7Jtc9PCsjtGtj9iuJAHYkoAC6HkkIGny6sB1LBzK6+WJTeZD1wfo5FDmWkf
bEYo+BtIObDWfyPsyBmfCgMVuc7/xji4+Pqy2pkS3MY6nx8QNdJgQpC3hZFCfRge
3b3f1ST70pEfBP9UwOYte3DKbu2pbzgvajUqN/xGZBFLY6UiaV5p2IWSNT3VhJq9
TbtIAab890wvnCb3ecMyw5mi4MIANje3RWse82RWKB4/VxXqjKRA6grrjAsU46vn
zFSxM8Bx3TuAO1P4htyLLB750K3tISAwuz6t7sXQblJmEj4Bxtqx+Zqf1P15UwyT
k+1AZ1nuHx4zXnfta2eX94IA1dj/oGO6nS3qPM1cUMVXeZLVyTQMUZ3eQ9lRh+lf
rWAS+uixyOK/QLLkgX//uBvTm3dPPp4qVMzmtOBkvkbUgcvAkeXLMtp/TWVGwISr
b9Ox3y2a9HQmKK6VxG/1NZn67bytSLMYRKNZxnPxTOoiR6qNIrJticElRl/IInC5
L/DMgXrOgi/7wodrAMIMV82eETI9tiKmlQjzM4koDmwMtHFrRv/VtHy7G6JQVRz2
sch0sOsR6ftpV0mX7grHQluDJ1OELeIvQ2Svtx+8p235LVNmiZF2IKmeA6QRvxH6
laHmchonLyOkzfyJsbTVPfwE/NYr3/QcLgcw3mqHSkU+AWC1+/eUOLzY+/0jRKnJ
nRnPdYvqPu+m6Vv6HxFBnK4+4wljfoMgGSQ7EueQm6Ki8VIQIE9nshR5z2RJv0aA
x0aTgT3XjeOMHdgvAcYDEyqiHH2QgMthgUgPm2jPGQuBVhHL61o3ojVzC+psbI7E
P+uLkK60p5NtRUgl1eIPRyRD/WZj7Ddi/nCmHn0wqG4W3bIcY+Ewk8vdQ4WkQwjK
XBOaolNaa9+eXvChpgFKnA7gnBtVgflS+vyVG5BoHzyuvjWMUHkyBbeJBcozVMVZ
CDqXyjRhyidi7i7L0MJyo3waVI0JHF9gnSblTP8uba2j0nprHRj0eMLzU0CvWhlj
XGyjE7P3usGdsFaTlpgFgaUMzqz4PbRIB7MFUi+brj+3LP2V0uxvdObZrxtedqsK
fOwkpsKrbbIBMLeGDIBPZTBAv+BMTBRge4NBhcaU407pJbzuPJ3tkz16zucDxi+g
q0keHZfJH3NqO+EYY2jJiwv5atECrjffPXIPiwt5JWin8cOINUh0fapfOQnYgT94
FvGYSpdHrdbrWWH5mVvRQPTxWPKDYQopBUUhMjCps2qiOSWFvCSlSnH8nP4FxRVM
0fs8IcCqJ4wvNFQh9XDlO+YhLqWnehs9aVywuUveE6OdsYV/RkMj1DsEfPjuZIvO
VI53Ffsy224K2Lp1KX1cdrg5xpxvpDTfSxRwoAqmNDF/hRdy15qXVsb7a1pPOVtb
NJGcHEWPDXK7OMvtmzFfxwMmvF2pFUGjiLWWb2dH7xwWSlg9nRqKlrjSLTW9g2PW
ln1OXeVlo1VJW10k9eSBmVH3DuIeuViAKxvjkBWDVm5c7uKHE68TQ2YVzcsJMhes
2I5Dn/v+cPVwy506/JrnJ6N45luGQ0fy9qCNuYsngmvbs637I3EZutv0RzY9r9dl
78Visl8O3lLPkHRkBngxL2xxyauNI41aw1yWBmFfp8jvt/sXkp19Z9uHcH3cbVcU
ZKt2SA8qsNPEvWra2OeMjYnaH/SR5JFGKh+rlRq86I9lZ5qvEC+of38y/H3awEDN
s6d+VuKze3F5apjQnap7Wbw2Q7eIVj8VVVMQJzLTKkiXVGb9dg2reC14Uh9J5VXf
1XYul3u5h+ISi1tft3KzzZ64il7TANG5I9V1qtYK4OCLT4FXFM85p1lhMni78WNA
+GstUGh7Yf6uvbyoJ7+jdW8UHrKt3H4U4oe/H1OKa7dSM4yRoDqCEI4RbixPWKnq
NJqNItRQjjhAys97bDFZ3ui3LhoSdadpvQGFEXEqINGmtbLX8zUc7gd0IduT9rPz
s4BQa2rIKP0/U7Qj3HMF90RO/dzl/Rpkuo1iR9dZlB/nBnm/e6Ru/V01oK1ROAbq
bdsPobDcVdoVnJ5IYSnpJVpvS3tQxCjeL45w4QPar0r1S/HMJi6N9JE2saudsXbM
Lv+2shNkLWJhbLzug2BRJvn3oOcHCyUbVVkLqDt6XU3Ir4INSVOPsfnS2mCZ5a0w
TbDxZXzTEB/G916mDmXLpE5rYtNR0WK7fb/g71SuruTH9rsfkzWg8J0M0Fn0PMeJ
I5qC5UlkT6EEOTTN8vS0kLe/EBcyddX70lIO6REOTkAa7HXwffxtqS576S33/1uA
adufoJR0WtyxhE7nTmWEUe2XMBLY3O+zJYYg4qTncaaSjh00D7shSNo3piEiRxde
qW5WBfg43kPsnw6blwX/35WlE6Nr+ry80xeo49SgEQNyC3JgOBZnF4Ni6Ndl2MbR
Y2CBrd3H/Y91C9lqht+2zjRaXYBZ7Jx9H2t17nq/JxLkfSd+nvUyZDZckWDGjeND
eT7ilq1h4MMD+CCdHq7AxJfEzC/uDgIC3xcaMKdV7TcN0Tltahv2Mqft/H+8bU0o
LzSA4TwBGThS+wmT1GcZj2WxEfyr7LiTraU8a2DPtSImGeXxIGS2mN0kLoZyTM1+
hTQIXswwFJXZIngMOeG45Y4l692GJKu6ZUZmN95e9/xTaWrWGW7utH4r3cGBBAZ8
KlkMphvKrsBjLm5xA8Necpl5m554QZmAZFX+ERR7F/FQH6lZOsenBL2nVIb16FKJ
PjL+CcUTVA/BnSEf5srTWlfXbbqRnp0RTCW6LPobWSbxL7RmLKR6H1DOcTqQ0/28
iICX6m7DbTKZ3m8f5iMFRkBcxyN4YtM+qtDesllK7isLgEwEMuiMhuGjH2hjd+Bp
dDLLSH5CbjFFIvvnBdyRVzbzIu+VUiMW2qtSbKAbyJJJ1M4DXYaBlJy/m2N+oliB
6mXh8ZXGLz2A30KWR5/Kg87rQ66P1W27cI9JMcf4qIR76wfnvaaQ1CRuIBkPOmPp
FGS4HilQXBsjqR/hpHoPFgowh8gKzQez9IkkVgFR2a7AW22N8rWJ1p+TYrAlzmib
WXMJ3UPT5//GUgfjuMckJMB170DStAWg1djT0KERoui/yyXttO3zJbABEuLa0gb2
vOBFXdNuV2rPCsIat7hy5pkmUNuJdSMQbldOh6w5QwO/0rqaW24HM04hQo56AxVN
E145dMRSW8tgLo8o7zV31hh9nxkyES/qzEYqq5BT1iVyBha1h4WLHAoQogS5OGcu
qU9fGO1WLlS39SrSw3Y+lLQ8RYJg+hdKL9ODFx2eOdyB5Q1k6fTuioQHV7fQYfPW
JldUQZ9i3V40cVQDEPFveTU995Yuz10rifZ+AfgkSBOZh36Fq5iw+YCvlPbRgXOB
9gXAL0r+ZwnhxB05JpYVG6xgIRFxjc41v8kwNfs4by1SZqeQ40sUHXet9hk4R+8P
JciS5r35RS9YHqnsPpGX5/hs3EBzyYgXfKgYDedkY9LD65W9AZxyhRyTDY+y+Lp1
Jz5eT4jgPaPkTU8Xqy7/1jfmkNzKAxGkfElSXi6+THUTrmObbEzO6XHImwiop2fO
eitodN4+6tYXEnhE8rf15BEf64GxqQAJhuD+fF8sknrYCegwc4IaYUjNeOLJ5MK9
M+YgjQEXhSApkmolN160YAWxyTCpD3EtzQa4jhDyXvpsoNpnxTgJAw7sJOCK8EEY
wsAaNhqPbkA0KqkcnTYb5+vCoXAN4xMkfYT5fNStNAFMe/sDRjJspk6ELonmT9ib
808qoYN/Xnk0H/ci8fgUN65o2GZE/ugeTKu1tzx3w3ehZGJoeaQ1Tgn+fqlawDpk
oBf8hCF7i1tTsT9i+qRP9k+SWmaaIbyw/ct6pkMIO1Dn5RhBqPp7wp8u0WK5YIB6
i9wZ6CXcpZUwGYFqt6L99WGHyxFcJ4PfoCS/KhEgKuP1ZaoJ3mNQ5yvQRtwIQMlg
P84XNxL0arJCB2Ie4V0ke16ce9iDnRmfvTqs62gLaONObiTJZnV3zGWh/3PFHTI6
mV2Bb2TbOoYUdkabh9EF7zOcyVNQMa1GMvRkgGu5i90X8piH1faDgdySZkABL0mu
3swgGYDdKfvUxc4MhgYaaGthjHrmx+V6ZDRqLCKow4tqz0ia/+om+Mh0cB17uyzr
gxOkYVK3m+2Chugq8cBaJEkzUPtCpfi9nDeTql5kcipiYorpjGlY6h2hQB5ontg6
JfyxtDWm84iQ3TNfj5vf+LmhK4aZXgqc6r81ZsZmRV6YOnAesjU8fZ//RpJyJxHE
6jqDcrZqdGTZSUrp1+CW44nAJxFWmprfLJOdgqQULBuRXaGiV1el1KZ+Aff9dvxK
Q92bcq6lK7TcelJ9d08Po+V9MfTc5UjNWGh5uqPir7Pj86WNFj7ik9JG04c5p+Sj
2kRyM8l3nK1rYKItRakacfIm0PdtO4ZeotqZCImz7fMzFB/Vs/4pmg7573TJWz9y
Me+p6BYt7DAqkX3RvoDbtSx8KBvKioDC434kLtUnU18nn3uaLI3Yh0Aw//G8wU/F
Jxklz8Qv16ZUZzEUni4ycsQZa1zaeZZ5Pj7yV+OhrCv6dsHysWiKGSdGo/5YeVL1
V8VZajsrkslFvHa4DkMutMx38MYgLtwN0ICbuXKqcc2UAOGLjuOtw8cFA0qm3ttW
vVHfTx1OEwrP7BNQlCLYlmXOLa8fJH/UGJPhk5iMIamKwwEzjwaoy+4FW5icddxr
PC6Bmy/td9EbwCavYs86RjzyNPZoroYrZPkegKlAYxXZ4ck5MTncrpN8l2CVx9NE
dc0F/G5RaR5hfKKck53IJBY027iafgRceYzJT76tyWw0lTUo7NtmQI5T6rIQlwTT
tyTkNFOS95ysVK2m/2v2HrYfabAkDgWaWEPsQkOuTheqwxO4o3qLV4x5SDmOBdG3
GPdI0iKNK/2VM9KpT2knMB02f3Ljm+9bM4CmFJVwQAMDfl4Ut1jwh/67PjCSqlBd
hxmR9PRm43qFAcJOOD5QADHR6duxjExvIR0btFICsSIbZhyB/Id095mEczEpyIC/
zIh622GlKh0z1D3qNwsXCGRFZfDCsKasViTd8CspCPfCtobXIBu1gvc3JsV5iKhl
uMqPh6RqVjWVI2NmCR+UH9D5KoVFHmrqlNr7A6it+PPHPgfWPGylPLtPQdURoI75
bsIf81CQtn5DiWPA+ydU348FOze6YQsOyIMcAdsNFm3ZX58oDTQQx/lbpzGiudGI
AlqkyLZFLVkhh15Y5xxJaXy3pwxMA911XsTvWAZB3JsFOeNPzON8vk6XKdioc8wV
YfVK3E8inlPng/7cYn9BjmR+1c2oaj/aMYhWkRrdRAUAVqPwGqLwwqvlqYJ9+vhH
nh2p7j6mDgb4L3t43L5Y1PwYKMW2krgdzQxMr1vD7Wlqsz5++efVcmArqPz0cHpE
Mscmxi6ARjLNTLonZX4mAwY0WzL1e/HwFoZ0eFSXrbmFBzfX/5zDCxYypjCazHoB
6MaR4+EjJO6C6T+j0JFodV97a9tbzHl2xHPHKcIntd+/pikrRGf/CeP/nOihFy/7
ZSRvrXWpB7mV30T+rQAfQJX5172EJquk7A581FgWzqZO1BLS5eZAtGx6V4bxeZa7
aSkjn+EtWq1NBObhuo7hj/h/1cRUWZ+OK9NJUWXJdXZ+Him4cN1e0ghracm0H0Kv
n8hXQEchkM4XyEJi7ta1EMt94f4haEmEfa1KNhZFU6YeTuY374B4YQVNwVZjXLnj
ToKsMO7pkrpWT0mmje/uvAPQ0YhBVsNY02Tu2NIRDWth09na2wt4JjLDvqR+oEOV
82wjGor32jleplsaGq9yeNh3rZEbBxZtpaK9em37fv9zhIgfWr8xqPedCdCr4x0W
qTGySYjyNSvXXW1mQuTv4BHxKrTH76GfCfbKdOAYiJso0D66cPJHYPA1hPKf9pB4
LmRtt6414vuLspG9dtGdG65NTKBWi6lH1lFJ9uQOaXkj2nkYIVwzvZTDPtV0rUfC
0PgVqpWwGaGwQpLAidv1cJrsHzGxeb98cscSI9G7BwB2qjuUuDbI4806Xi2lzYgX
xccZ5YQb/QwaFruvVnNpKJtXtkgIj9vZlVK/4QJ+gL5q39J9j97gvhLyIH35YiZy
ej/rODa30UXrup++KGU0itM0SxErAtcEuVZ2KUXpPVxVrBJACr14fea4Qum3Oa0x
fZHRaB0gdbiBwOD6etmEtB9zID0GCGtEW045nR96lZrsThfzV7VUsHm0pixVPBKm
lqBNYQSDceyvVEoRTQ8yenIWaeAWwvqCpfyuBc8VXbXh446g/0qcrkRuxcOKae4p
5jg4PNLMiqKuD4QdTxnsWmnsUsksYLznjee8DLPAGEskG8OZi+ip2+RfeleMNUnL
xxVuSmCaAJMchlwY7g41Nrz/cKRW3iKl3KjC5t5mc4RjG4e+8tCAjCb4DNVgLvH2
+15D8SM5xvhz/ctfhmkDJ8oYM49fuMUlo3L+nJJUPBlnGnRKGrHUI6xErU6mxv+W
S4F1tOwLm7oWqISQ05untb0fHsZ3BYVlfZDR74q3RPGMhg8JKyTpUGLisHY0rO42
jFBLv0J5YKIV6rCNa3jFp5xVtl5eQFrlVmFRk98Uz8EWUW3gdwN2urZAlTVRkc8O
TZRoEzb57N1WOvDjveNvGCIcYOrYzIjYJ+qOid/AFExHb1u60k8eLNZMeaK1Ubcd
I/38xh2mkyjR/HE81FZdkA30Q6+f6IRQwbzu0mqUDzxMYhirLYKhmvYm5w7FMEky
tSi4dIS+b7euzfYHkIYS4Yf2zN+87Z9XsoCddgANlRkrTsq44P2UGJkM5kRxwpp9
p9ziitwX18ujh6pZ/6PsZeX7iaI1WFYr7gwGAxvJUUJSZuYIzjSb01zByqOBxjzv
NZIVJAp8S5GK9pM2Tl+X0INvuqxGY+l3MP+9LDWa0gigk7OgdVZd6q9wC1kE0Aps
KXrU1HaF6QuBjNPTImxAuEyLVvojj8mKKZUPTGzkgMcOeoMCcvrzVqlkQoYo8xt3
3mntJ5iulENcPp6M8Lt6Cqnqfv1JFkp7m3cSLrcWFavVt8oaFAx4LxQh3OBoU+Z4
7ZLuK9ZP0WXlxorPaNPkqOSuP55CpWDYZlz0Mk8BQf/rz4MeV8TWf0Jb0eadzUkH
dcwoY7hnJmT223grawUzOCvRIIbf+0xeSqRJCm+GCa82lVgsXvk8aoCvczBpNuYg
ZFXlxNlqn5PHVaQhILZ2iTikFXqgazgaePM4W/eJCHPKDpshYO/hzVXg/+OR1dNK
9lajvJzpqCLvgjz+w36+FbfiHImfRcEdiF/iAIFol13NdxAFAnSfL7X/OM9Ax8gM
q6sOepjNqJd6q7GtHQADjjIsvgRJ9hs4oMkxNCoPGPEHFnza+cPJM54vz6hMD49Q
oVIzzulISb9heUXunQC5hr9SoFeqF7ZpPo42ojE4vfkGfonn4SGIECOYyf+9OBwU
gx2SuGA2vSyObZ5Q9k/2hdGumE3zl5ByPh7JKVPMEvoxbWxBU/qD1k8xQzLUHITL
T2DcKQ04hNDJXLWXlzlc+kNhES9cta29m8pZIXk/Zko92W/xt8UMAkR+pzxn1z7S
51hlNoWIDjdkf/uKQkyFSZen9Tf3hEoYLPpXfeLOBzc9biC7MiEQHYfksNTJ71IP

//pragma protect end_data_block
//pragma protect digest_block
guNY8+Nv5zbeEUNI4ZTEwqNiE+k=
//pragma protect end_digest_block
//pragma protect end_protected
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PpatndKcXJD+aM7qLrqAm/bifBdlB3voDg+xeE3f+GQ1/LnYDCc/v/WF/lw5/+f/
aoYQqSRliXETPN+ZRIIto1DLQAOM4v8PBkXpI/a9wVe+MjZyDTPqlRX5uG5Awb3v
7SFR1tgig2j+Mvz4Dd6r9eVug7/tbCsHEiXNwbdFwRXFZKnijMvngA==
//pragma protect end_key_block
//pragma protect digest_block
ADJlWKdIA1W3u7ysiOb5LjF4PYY=
//pragma protect end_digest_block
//pragma protect data_block
CkgVwFz5kBwJkWLKXiWnVmu5cHjh1/v/3B0brHtT1rXnNh3dC5JvtX+LmHFhvLSi
0EAqnksSGF04xMBrVwTWZl/6Rcn9oQDiX7zcp1jfYK9/Ylv3Zyd69mOIDoWGbgzB
8EbB2NH+1MfzFcNJqpH4RIZWefqutH1eAZLNGSFb5t9O9Z04NP3bjx+7paBEmM9k
GS9xpCYZPQ+4VB139PCjXkRe5BiHWn5lkgHvMva/EvXMpWGcB6/o5suHYbXEnQRz
4yarDREWInWQSKv1F8mBhnUQQnmnRFgJWIvkS2/tAzkQiqSrzAcxFFI0DoFf6hME
ZjuvA2C4pjuWuigc9hIrgkXU3+UQbkZgtdgLWGOKlr+Z13I5ZmTYVPp0O8esJn5x
8COY6xSqjzMxTb97l6DkTnvEZCXP1RX+H9XvKKEHhEaK6k7M+EDQpluLtj9lCJjR
WJt+CN8QvwFi3uTg0Nm+tw==
//pragma protect end_data_block
//pragma protect digest_block
hcgsyNRt8b9CyA4G6edJTa2BMwI=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w333n9ftZ1WknOWfPXNWWFWqA8AO4l8QtrYaF+DYMM0V5jff2hWPdROauJUgFuz9
m+ff8/wr939Jw1zGz2tpPa8lA/sq8W+cDez7EYCFOHURXrW8mjN0yaU34l4G8FSq
4xOeXYgqCEiqh8UlWOfCZv4SZgdlXDcwo5hcg33sYHpaJWrEXWD9tA==
//pragma protect end_key_block
//pragma protect digest_block
+r8g+veWuTZ9t8Nxnj0S9CmKY/Q=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
nOb+pE+/Am9LTZvxNuBaETjCMQM=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6isCiPMV7ERMYYwq8b7WDRZXnYa/vTjsPqWwhuaIG1eEemJiQTX3VeBUDi+5kLuw
SysBvJV9f61+uyub/XecV9GnkVBZkEI3fhQr28+kgIzAo/FyYElD3288Swg/MO/Q
v+//ZFn4GCEqvyHhpLx2U0AWM14Yvsbd1JM6kuakKuo3fpPnrFJYWw==
//pragma protect end_key_block
//pragma protect digest_block
YTpnxhoUQVtCpSQbd1Av98qYtvI=
//pragma protect end_digest_block
//pragma protect data_block
74rzMBxtceqFvTZvlmLMaCcv+Qim9QgZshNh43jSARbSEyllweXtMXtegnFUyF3D
zZWWPBv4qFq0NXPnY0WzWeyhnP0KQ+lpXuluZkCdZZTgze5Uk3buVkbJuUeUMh4m
IlfXUTIVNo8iyespIlmM/D1n6ZANfs2+9IUnrzg5wGq0JL2LuImL27EP+NRowR4w
laDRRoKGZBvszGnycpeKgdJQgMip7GD8vRpTiH0n4H86ep5vWN4Qo2Kgy/A+0sPU
6UyJM/atbLP5JVR1kc+mWDN9uTaSN5wewZTVAZkMYXyVLaF34JVWDrAye9HnCmZ9
J84aDGmN1FeEFiPnz1DAZvdbvXZ+LLIkODU6KaXneCtMfNn2D3CO5MQe2jezANU3
/aPYi0QfQJ7+BvPu9vk1YcfUDSctq8+cEDw+0WCv1v70L5QS1CZz5pnDZ8aqtcgh
/IMtQWDNgY3EslcrhMV8Lg==
//pragma protect end_data_block
//pragma protect digest_block
1/fF7rYR1Wrl+9u0SlFWt9zD5JE=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
utLSwkMbbOxuvVSxrVJAM0ZV+Wcoq2Y20qJVAnWU4PHWv00zpfbQPCx5TE/j5ufk
UVv6FwQd6YcIdLy9HTq3MPRXxBIQiU1FG9feQGVydt1y0M30Q44xPYZR8frvKu+i
UtFZfiaVJK+7QMjkQXXCGbMH1zLfl+8IPAyHVDrSl/CEQ9rKhngR6w==
//pragma protect end_key_block
//pragma protect digest_block
hQx9cEWH7gFxklH2Gt8ust5QHfk=
//pragma protect end_digest_block
//pragma protect data_block
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
kGWH9i+GqYL53Ld4sHJpoA==
//pragma protect end_data_block
//pragma protect digest_block
6oiOU/+fnRqnnPilcZ8O5Ke4kSM=
//pragma protect end_digest_block
//pragma protect end_protected
    
`ifdef SVT_UVM_TECHNOLOGY
   typedef uvm_tlm_fifo#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
`elsif SVT_OVM_TECHNOLOGY
   typedef tlm_fifo#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
`elsif SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_ahb_master_transaction) svt_ahb_master_transaction_channel;
  typedef vmm_channel_typed#(svt_ahb_master_transaction) svt_ahb_master_input_port_type;
  `vmm_atomic_gen(svt_ahb_master_transaction, "VMM (Atomic) Generator for svt_ahb_master_transaction data objects")
  `vmm_scenario_gen(svt_ahb_master_transaction, "VMM (Scenario) Generator for svt_ahb_master_transaction data objects")
`endif 

`endif // GUARD_SVT_AHB_MASTER_TRANSACTION_SV
