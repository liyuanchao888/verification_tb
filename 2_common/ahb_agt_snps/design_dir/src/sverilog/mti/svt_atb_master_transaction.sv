
`ifndef GUARD_SVT_ATB_MASTER_TRANSACTION_SV
`define GUARD_SVT_ATB_MASTER_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    This is the base transaction type which contains all the physical
    attributes of the transaction like id, data, burst length,
    etc. It also provides the timing information of the transaction to the
    master & slave transactors, that is, delays for valid and ready signals
    with respect to some reference events. 
    
    The svt_atb_master_transaction also contains a handle to configuration object of
    type #svt_atb_port_configuration, which provides the configuration of the
    port on which this transaction would be applied. The port configuration is
    used during randomizing the transaction.
 */
class svt_atb_master_transaction extends svt_atb_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_atb_master_transaction)
`endif


  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_atb_master_transaction", "class" );
`endif

  /** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;

  /** local variable to help in randomization */
  local rand bit primary_prop;
  //local rand bit force_zero_data_valid_delay;
  /** @endcond */
 
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aF8V1eSXSRqajqAFi6ehMDXugQWG5JyQWgEK42L+TDJRAEd+2EhC3BsWOE/HFjYl
gO0VJ17V8qyUkRrp3/g7GoHMwTIBwO3KWHRwwgamQZnRrCn7teK0kqWQl2UkhD9A
z3u1wblX+rsbd0gLIn+pL17zXUop+ooyo1VS8VmYLZ0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4378      )
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
e5IZHkO0R3qwecXToHFjUg==
`pragma protect end_protected  

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_atb_master_transaction)
  `svt_data_member_end(svt_atb_master_transaction)


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

`ifndef INCA
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
`else
`endif
`endif
  

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

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
  //------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  extern virtual function string get_uid();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  /** Sets the configuration property */
  extern function void set_cfg(svt_atb_port_configuration cfg);
  // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique iden/get_uid
   * tification value for object. If not 
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
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

  //------------------------------------------------------------------------------------

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
   * Does a basic validation of this transaction object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
    * packes randomized data bytes into dataword same widht as physical databus
    */
  extern function void post_randomize();

  /** @cond PRIVATE */

  /** Turns-off randomization for all ATB parameters */
  extern virtual function void set_atb_randmode(bit on_off=0);

  /** @endcond */


                      

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_atb_master_transaction)
`endif
endclass
/**
Transaction Class Macros definition  and utility methods definition
*/

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IioPR9p+Ri3fOUdVZDJyRd4bOj0u27MrhL5wXXkixiH/sPZriHraxDufkFVy5wlg
MgBAdmoPH0ha5D84ynj4PWzYdk+KVuLBhPGrTuEfB7vazFzjCBZemLtP58kwvKTG
K/iBni/imOuTAZc5/aOKGATjkY5VjPqwM/qXaS4sjj0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5270      )
lPgRIkvZBfMaaafPqtmjRvAg4KPcQLIq/xCSwa9JwFNuvJzWBgYqYgnpI72twfHW
5wEdsRCZtwHh/tODo3PlG0WcG03TfaKV3M+Zb/E6BEMPPY3sTDFZARhTUipcFhIs
Cn7n8SNe8YAV/gSoMgz19uuuOeZtyi/4RYnEfK+ttmBjNOySzFV2cZ0qtLUU/SOZ
nFk6SOv/NSj2pSr81BFr3rDI7XT91jkWDQR5KqR/5lJ3OQPYULorNOJXjuQITPic
b0EeErg58P3bcEgF6zJ6MFTSIJ3IeTh4WNhsiwh8Q6Fe48WCtECeMZmpPag4oIRh
pKTiSjoPSEi/b+ZMdpt0VIdxSWNENbdYMv9oW6a9rBZdM+W5t5xsmiU/wae/eVY6
Eps0tNStFd8dv5XuqlrYILf+1TRB5kJfnkKmn5dTyhKP4mJaBDakj31eEyhMMy4c
WvDuc9SrwaaID0smsB/62kgkMffsu/nZVh4jsGTXPn1cZrmsxz/Nyu5kPWBA3MHn
zspORppYtnupydNkyQiWKUkwJmJdFNW739iH8M147etyil+33DmH0RvTJcmsuADk
MUkq9EjzZ+DSbpwYl0VihZvTUzso9HCduCS/4BAdVSedwnscsvd8XNLqVsQFVgwJ
q3baq+nJd8s34642rxjg9l0lMMmgkZc5kf5nvurTzhXOUIRJl4m1GskLRmSQrMSD
PHbV6STbp+DdzgLY2+lq4bg9NBmdQ2EFQBcS56+nDW2Mze9R05Bwbm0aNP5vlntq
9K9AYmJysocT9lFTf8XALLROWBPAha+9vqaKJ0r9ApbeKvMHKKGROM45SOqE8B7k
P9eyHt+Yx9RHWgIurpSSeEVTRa9qsdcDH30i+mm4ZXm19Yx1MCjRqFEuqoY0/whi
ae42CKO8gtBx7KvHwIMgOyOGzGjwWTGKWxCXC8pWc9vbXSJ54Ii5JXiDNxB8+wNs
U9B5mx8sG7wAGSJERysa3u5q9LFqHxWGd3jgb1mRuI39EXtiZwzVK0V1cmjAUZco
B71Ji6D9ItpMo2FUfnL5wC+oKM4KkUbx29hwJmhdVQqP8Wn1ycBhmw2OaMVWoNie
N7NfTTHsCnB93d9Wbalfanfg6XR6dauzenFiNgx7GnMTPQZRkU4/oaDk7EPVPg9y
Weg0mz+CT6Dqfa31DLQPwFBD8C6LCnNsFxSC5LFcVxE=
`pragma protect end_protected  

 
  // -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CJaOrZ9DRCKf4Ke3RTu5pxpTemqYAgMcdVv0clakjIDb1ZAMBC94KbY7KFxE4yEr
wwfb1YXVjhoQS5k7fXjx+WCyZ8pgY4Y1Rf9C2u09JeAQx//SpF19TPH/Yz+J5U/t
D+ZGDC6DC6NMbbZyf0IgVnBW3NntHaFVo/Bm2zy69VA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6121      )
SI3ELFOlSQbJe17BaiILZU4HIcjIXVxxJZP1AKrDfbep0cGKNJ4DIHWvba47tM5f
KqrODuSYBcpu5cF73XNoyQuUgO63EWyein24yq+RrGwgoEFemmCXfzL7NqYF92zr
JZN6d7BiIVGjJ2nHK1YS9kIKPDD+pPTK4W0nUhcvsxRqXYIPsxLLtYvlwXGsPhUR
hGhwFcUhJ+/SVyNRUepIAcV4tOR8eWQ6eEmhoWv53iV9O2IExW6fLZLTCBFchYJR
K0F10Hn8FMohweuaTpGfrT0NxOBiIG8ZFp67DVHoF0nKyRUU2jslYLEgZFwrNWDU
UtMs6+OfANSEEslytezjyYfqM7kwS/hWAHHonhcntBkauXcpFBVKVLlm01pT6Puq
4Fo5NrV5htraMkEuQMf6YuyLYC7+9EYL/1xIqRm21SjNmGgu8TcwCZ0V0nOk0dCA
vpqnHW8mG5Nj7HBOtjpXh2QEq+4KeZ0OI1Hgvwrw4wktFFeGPYXh49BmW6aGcj5Y
XFQOMhO/3hZjcYGLLzugQtsJ+P/G9bpQ4XSpVifJCxWAkVyDphGtgF0y+fCiaeEP
iMydlPjr9UB2CifasOOY4JiRpJ7etLt5WZq7TGgM1rgDMngAs09Q3JiVFaFCNe65
VWItghlyWyLDvdVaL5KG1gTwZLzNTP+ZBNudsFbbGozhRLkyzDt3DImQQcuuHAdq
BPGO9tp9PdSLv1ZgvvwzpZDCMOT//5daaV0ubWeJ/CWkiEHwTLbed3mnKC0Tzbxo
hUy27nLHzN9/ecLpwOyvKwRIoo0yTsZHky6blvap/BV4ZwomTamFJsgSe7vlYOg8
T0t4GZErOvJJ91YkLa6arWUt+lJD/HVc5NVjMr1ZCEaHJAOWwf3TguGlNoNkcnx9
pzgt3NHoWSOc+HJnXjFw5EBCav5Qr47ylKaehPTWaytIOZcjH9q6pZQJG0a/Gla7
5ij10urhPzTVjwvUK+r2Whb9kqTMO0nKZqFiMZilaUSNj477F05KPmgJqtV6HaZ1
/ve46wuIKiwaTWVJ91+wRaabKVZtvzD7oRMqNEwEzQUoX8I3O81WtlEk4uVkPlz+
NTBXSjPeScTuSh4DIizw0Lh7Nq59+y6MQFeIcyfpcBkcRquPrlhNngZK7DqhAo90
`pragma protect end_protected  
 
  // -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J2QnITWmPNw4Z9SOmF06dRldycwTBDjNomo4ru7F3a7d6RnqZTa04Lhq/gq4HIrO
r0k2nYeQBAAciyotanuiQi6LafdcqV79mHbRYIHfWZ5s/UY2fWpuVmt9MU//qaR5
IXqb9RbTkxbiU3zvN8yqA3VyLnpoEbYSZVRRsizuZvc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23156     )
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gRB8ndcUphfDKNx65gsbvu7lQw5AQZuM+xAGCD3Dx119FKlKcJGUMDiOEVy6FZkM
Y6T8KPdgeKsNRpuhSVJnscnmlJsxA1aZn0wMPkC8524N9q5xOHLbdKHAZeAUW7tM
nrlK8OkUxQDGaRCWtmgm2cjKPFzJ9ihLPzQyYIxbNYk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23358     )
tjxKCnSmAADAQ5dl/ZZnyP5bWqX22CCbf6dfTjuMgpgPDCacaL412SYvi6hvwow1
iOXhpnKlIDLq/Lty2IL7dkOqeoKjrgyujTS8kPgV7R1AJsUuUzHYZqwX0rvJtDiJ
aYVKM2d4QNPmZJMOP8M13Btz75aAmSRrp6VQpXe+rIBXkhtdx0iB67p9zNSObRGu
lsUZK0dNA1/0lz5pZC4U+SI8FlMRjuU1sYfA+Ac7zJkIb7U/JcCPGiiI8QUprq3g
yLBB2ZVQxFpspeBBRLUF7Q==
`pragma protect end_protected    

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gGunXWnJd3pMTZEioTdJh5QL7zZUCE32dDfONfnzQxhR+skPPcqP9m27f5I5jCnE
gyuFrdaZ9Onf3pKZwwU1jrcrdPg7/Za+swYiITrIZRJb8rRBfyYxRoNomI7Au+YG
Ze/kMT5ZP6AVpPgbreP0Rn/2RoZCuZwpLAZ6A8TChq8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25209     )
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
`pragma protect end_protected
  `endif // GUARD_SVT_ATB_MASTER_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dj63WWfQGMv1EuyCcFOSrXrS7o+gQFFSm+M00rRMpxxpVc3RrQh6juu9syTaTx2m
waoOXU59UctIv+krugrOTsjxCp++uIijzTHXg+2opCmg14bA9p80X/rPYug/oP+z
76imdxYACVverMqDtOoG+QfiuB9OEtiWCOetHcvzh7o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25292     )
qtrBAKk2bDo/kJtZkxR87/MPxk+hZZvEcWUO7LwZLJTa4DBo3y3tRrm4GwlxHTR3
wuQ6eIWJoZc2tsvJiCOZBj99so9NgKvwzfrKfsoWbg68s6bnHJGjsqMa5Po2R46T
`pragma protect end_protected
