
`ifndef GUARD_SVT_APB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_APB_SLAVE_TRANSACTION_SV

/**
 * This is the slave transaction class which contains slave specific transaction
 * class members, and constraints.
 *
 * The svt_transaction also contains a handle to configuration object of type
 * #svt_apb_slave_configuration, which provides the configuration of the slave
 * port on which this transaction would be applied. The port configuration is
 * used during randomizing the transaction.
 */
class svt_apb_slave_transaction extends svt_apb_transaction;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** A reference to the system configuration */
  svt_apb_slave_configuration cfg;

  /**
   * Weight used to control distribution of num_wait_cycles to 0 within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int ZERO_WAIT_CYCLES_wt = 7;

   /**
   * Weight used to control distribution of shorter waits within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int SHORT_WAIT_CYCLES_wt = 2;


   /**
   * Weight used to control distribution of longer waits within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int LONG_WAIT_CYCLES_wt = 1;

  /** @cond PRIVATE */
  /**
   * Indicates that the data read from apb_slave_mem contains X.
   */
  bit 			    read_data_contains_x;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
O8nmJ90AdOE0b4LrSyh7UVdIyW6zoJ5NV5LUZQRxiFCirB9OVolJ6qttsZaK4KVJ
itFkdlBz0v9BIPYjyFAUYMFX7crTtUxTyYforCbGFGhpqk09SU+7Ea6fEA9kcIG8
0YndnwARPjUswL0Qzq0AG2NOpDRA4nWZsXZ7RBnK7WR/WKJGrqX1BA==
//pragma protect end_key_block
//pragma protect digest_block
Aw/qQqj7vF+keBVezgKk5FCLWNQ=
//pragma protect end_digest_block
//pragma protect data_block
A3thjKFqLM2iYCAaB+sRXGCeTcCDjoqyO7GPEr5j1GBApO83brIttOq4IcEG7ydO
vrs4CRS5unCVDqzMXf2lsOXGyifPNthdV9wBB4OvxciRNCdR44o704HOtufJPDd9
HKR43Fu61YHTd39qLz1B/g2t2Im4YiJlrvhyFc31qH9MRfZBdW4YfSBckoQKuKXB
J/9o+zkteDk0sX4pXSIj8qxXlCg6JMBmSJPH/zxaZWfPyf6VnObCBqQZhWNXG5KL
gq3YrJkv47xreZbBY+DR6ZUBkjcKyiY8VDcoVP3u7DWsGJYFMb+8umnf2RMdo+UV
koC3OtWDDiJjoXWfc5yBwAOTitDiMuyYpI55YQRscYFQiBz8IpsjJZhmYfTarITp
cjl5G9QyIYkSYh0wvvGL8zBSkPFFt/VI41C6//N6v4J3r6ZgS/M1vsNSoMTBvEMz
l4TjFCnkcCY2bmJHOzHhaxeeLk75SJyZKxF49gUxx2jBqsVeW4Oj7t1GsPyoPVG9
AC1TCv4UhP5Uk2w4z1h5VNTtF+ZVe5EJLSNPhJ+ln3TIPebQVi1kX2HQySnL0OFd
WhWFqct5RiDdRjtpIbUAL82sBh6K77w4u7JqhrktNmgl47uZ9rA6JDsh/AaPWs78
tb/8jwhocD6ufO73ekCPzNXYAawTE8vAMeHcIxN9otYhAx3O9IlWDGRJJkCC5yYk
CPnoVZlR8kdvZ6JKlZJeWcm/2nfirFBhx4kKmS/TrbDSVrOc0TNPv2SWo+NJ+oGq
dBDTA/F6jQes4u6jL34B8UMkIwvOT2+S3GsrGcpOcqENJEUIEAXtwPcfiGxIKiew
xhgNp1bYZ7N6F/DrXPY0OQ5OH+RQVM6rb9rfDZey4zRg0nlYzKq559i1+Yw98Hdh
xtU06zgiosTPEhSQfhI7Mx0d5+vmdC0ssUYgIj1m/EyUe97+2l+0Z8UHpCVQ/h2y
sPdVc7s1uR72bixg3+iJp6G998qKA7rd/VpJQDXr39V3ZkL5JiTI5Y/ZDwaqQNra
2iBHa+ADfWLoVjJgPS4UePZRNIHS6ZFmbnwzXLS/IHCSkF1JMKqAVY94pQasR6M+
CVcCsptzIP5AVGbF4TmUF1PXe3KsZCJOAg6JmERFN+0kAYfNgB+dg+gch4QWGH/c
4IoGkK5W5l+2f3fjdH8oKj9lDVVsxAWq0SOP/geS/hg=
//pragma protect end_data_block
//pragma protect digest_block
u/jHXa50DQrwATQejIc2Hu3guc0=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_slave_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_slave_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_slave_transaction)
    `svt_field_int(ZERO_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(SHORT_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(LONG_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_object(cfg,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int(read_data_contains_x,  `SVT_ALL_ON | `SVT_HEX | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_apb_slave_transaction)


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
   * Method to control post_randomize
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);
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
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

 // -----------------------------------------------------------------------------
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
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

 //------------------------------------------------------------------------------
   /** This method returns a string indication unique identification value
   * for object .
   */
  extern virtual function string get_uid();
  
 // ---------------------------------------------------------------------------
  /** Sets the configuration property */
  extern function void set_cfg(svt_apb_slave_configuration cfg);
  
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

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

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
`endif 

  /** Ensures that the configuration is valid */
  extern function void pre_randomize ();

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_slave_transaction)
  `vmm_class_factory(svt_apb_slave_transaction)
`endif
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
B8pZHsbM2K0QYzrF1i32nXP1NklLZT3QialaOxA5Tf7WDK4XMNr4xEIw7uEyEnUK
DgLhZHmO3HW+In3a/hjaAyvzFZ9bJP1pkP3ly3KuzS/RyWIR9FNhcNoXpfiOTLFl
68OfPK11/123yHjPGTUSC9Q9+6fyyP7+JmDvpWTB9hcU94v/AE84YA==
//pragma protect end_key_block
//pragma protect digest_block
X0bPaY/kt8gLvTDmLggKMFXKNLw=
//pragma protect end_digest_block
//pragma protect data_block
ZY4UQfNoyq129PFkcsBwclgNblau5ehcSt8h2trRKEWlo7xX9TpulBySR2TIPtxu
P4HPqrHQ64urpGyRLPf6fPLFA/MPQq6lXDijcgG35L1o+ZJSUApjb+5L7Xwr7KJu
3tVTi9vayAUguOwC9JjLg8+01y3mMeO52/R/eOhYsv6VpDahSkp2KFm4yROZb5jo
J6IKFe0vLWeoNc647T/ehSXBHLSQFaBFkPKLOxxpR4xrYQFAMQ63zBwjltkHznFy
b3A+jjErWYGy52LysCPoWbYgcEe6JwncjqLHPf7MKzQhHc57rd+eeeuSjmfphghC
+gY/GjE3bv3LReW2YpkD9fcCwmIuWFkoG0Q9WGdbYXlYSA/eWymCZNK+bt8/yq0P
BlcBfk9Wx5+2Lu34JG+XMBXkN8mTP+U7J2rLRtWD0vDjv7EqPQ8fMASdPna54jOB
Y6eEZEYw3dcvx+ALihk+EcavHkjSRRAveAxLVo9EWMyH4RUtca78PohqRv7XzoC9
XB6JmQRZh6gW1SQM20sbS1BXcQ7m/kNmLRoPVQC2jCT9Acb8JFiqA/w7S79V/PIx
96uJHNGfWRPYWVNP6p2ghPhavw+eMjwo/E+ANRMO5YImD+5+iIUv6pAT5GrokjWt
T4p1uEVCZH1Qn3Mw27KYv7Rue6YAqU4Hns4Cm2IiIl4CwEl4W516i8gUrLC+LYKX
Hnd9LWSK6w5HwDKgBZHBG4vmLl4puIbpLB+DYJtoRh9e7tDzImVZtY4b2IaAeJDh
mqPz/gSp3SOzTKwKvc7c4v0R6KuLVJQQBd7LAOn2lrMDej02OfEhtf4jUxj3zhsH
abQgXfP2rfDG0/Gsejextbgn4qaIF2Omazqm03hEpMJpbxhTHQOfxDipwVOJAgGT
R1FG9h3xvPD316cuD5l8TYPJXCKlTnZe3LGPCtdpsn5gOiFPMTiR//PvxLQhQpBr
8HG5LTAZyWoL8xBvNVALsvQ6lw1uwwHp57neZtiB+nIutdsGb7Mi4glH0gGUHZmW
cQ6AibgpVLLYeEvU40nrFvkP2MjcCNucfCUJBM/DXVU=
//pragma protect end_data_block
//pragma protect digest_block
7p7yNS+E1jKUSKTGrGplaOnz1xg=
//pragma protect end_digest_block
//pragma protect end_protected
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tVYvoiTn7bTXWsn/Xm4ii2tgZPWsbP0kpUkhlnYMp3DpWoWallAKrmlBCqCEaVW7
qsrNXV54u2If7KivwGQKQFOHKlhYcUW/gh1ywjNRfuzHZ62nx6BGrMEK6hLPXK9a
QZCEDq02KV/Q4vfbw1wNrHkckuvWVHfzxMAQYOe8jswGl18OtUez+w==
//pragma protect end_key_block
//pragma protect digest_block
cxlq45alowP3AgFEVziksSahGz4=
//pragma protect end_digest_block
//pragma protect data_block
nYCUf6A7wBErxE5i+Nz6Hy0j1MO6IOOtR3xHY78WsAnVaV0Y85JKEamXMsVnptIq
QVcxy8GDpkvTdC20Rizx8WaY3VWqJ/rtfXbzzabCL9oAdxhYMpEuTKTWCd/j/ron
cv8BF0YB/hd7V3MMO90M2SHL+MGzjaW34ea7CkzF06aB2Qqr/3N5qTnGXjxi4k2I
ZtcFiF2vgZVgf038p0slLNuR7fHbNn/1K5GBJcQve3xXtTgmQ4CqFUkzSFDg8Y7/
p6kKvYeMFiNWtui9JoJ/pX1DH40b6opF6ulv0K3ZePl+AvJ3LzertDxo7sgFtPXG
v/PHTzQRGOZ3Qc2JYQFsL+skdvGWnBM7vJ40jcNF2XnuIhxZ8IwScnz6hE9LYbSE
W0cGZ7Kax5yeLU5/bT9KIy4nguBkCjg7hUtTYPOI4mTR9XtwZ+cZChAghrqiUTN6
536bXtaumKSm+3DqOKLzyp2aCIjt0A96U2IeU9MsqPjBWsllz8fDbqXyf7OeuTFw
pohsS3cIbtK9hzuH40RPJrrMhYkMUlky6c8Lsdq4L0uSjtjCYXINE/aLQfN+WpGF
4+c2OXOol7plGGAnD09x4FL36g4w9U7gR8Pv88M/D08U9c2/AwJU22QW59WmytrP
gTtUMUBI8ImMuKVa49ElsvXxkM5Z3qs6FsS+78r7JT06SoPy8DTn8nV3s6q8N4S8
+xWIWhl6gkDuDVvM5dfGPqqME4N77DKkQzqVn25ANVcKEpV0TPNb22XA+UZojZZi
YQxQyY30dkzFtdqg7HzkfQF2breBTy6CO+MXsYv2xEAjaWeYNKGhEAhpROVOESa4
w5xJ6Z7r9lEspW2WnCgOi7HxNIZAgYBMNjptPA16WW+VK924do69X1xqEfCb+Uq5
NbGP1jcIQP4PPosLYgAlXBd7huKyeXRVSDSpNIplgs2HajNzBSOQ2Zjqjmzl+WIL
aMihK1U9o5VLD04qcORmSg==
//pragma protect end_data_block
//pragma protect digest_block
Ohp+x0PgrXnK7j4i4J8y6SW+VZY=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_apb_slave_transaction::post_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
a+5tJb66H6XLWD18u2R2dRoqTIvim11sQEiq1O9vDvtldIsykwmE/8uKE8UjpYlM
fublNJF7ddKN8d2TZ41LK7nb/KrwLBIQWrFSBN2EUZ8WYAxfm7J2bnybvTHw0OmB
bO4+mh0CzA9ClMy4W+JpnOpeWLJOsXJaCKrB2GZmpIENx/1JzEL9ug==
//pragma protect end_key_block
//pragma protect digest_block
euHrAtVV8XqCMYrVOhrHy9hky8w=
//pragma protect end_digest_block
//pragma protect data_block
Y7qFXKMqiwfUcLA3rmZpZMYdlDnMty/o7zE75te8yHpMP6VTU+ceClEn+AZW8wH3
aswjw1/eXrAOtP4Npmhk/pHZbNt0z1isNb+j+D+9wIJKwo2rUYn5CmROVgTG0jd+
nqGFepAjNxqNdcO+ucMaZqn2JpjU12L0xsSsQ7X0Zu6LoRJ5+2XCCLfTBuVr79RU
Vq0oKQDf3Z5/mc9CgtdA1mO42jVu/osg8/xILBqnxEmR0pDGGLAg4PUzj26ex2V0
3FBR/Vll0JPDzsvLMFt/T6qTCEI4sHNRzw51pXCNwpHpKgMW173CfcxKTmQakLOm
YzZT4KYuZWp0OXq758PbLrFERggueFOgv8v+GQE0WQi6PHtNuqyWlTX2f4HR5rHz
5lLd/QGYroWKjHs5QlzQbI3JpGkZMcg0MUpB6QYBV3cSHaONJLHKlT4bcwc+UV+G
6FRb3dvBubBi0LahnDsxwWm/kgvmfVL8GrNogdtxsPWan/ikceBm5/LJ0mfMekIJ
kLqrMEIIXoOCCEYZxyw76az6SbA8F8HhdzZ5Td1yEo8WVctwtLW4MFl2JiOiI51m

//pragma protect end_data_block
//pragma protect digest_block
m9hggln3XNIS+MHZ1gtnToxptTU=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction
// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
G+pBx1mLokrtLG36itQaAvBTE/V1JIawwIFOgvtyTt30ukjdmpoSfQ1YyNNB5q9K
1SVGyELaKoiYBnLTdMOiTy3apPjEHQWi0QNGpV73ntC7qhm8Gu1RbVAGRfzHQJ8b
Ohg+NBQetsfQ91OIE8kqRryiDOWsTFI3rJcOWr60Tc06mUgFCNLaDw==
//pragma protect end_key_block
//pragma protect digest_block
tGPDSYX2thfC+pOuZWWZCsgCy1k=
//pragma protect end_digest_block
//pragma protect data_block
i6h73kxPgQRqpzEHFsJvXCIVxc3yUQYE1zGljg8MtSylrvyj1+dF4Ua1NU5M8OsT
1BqIZFWXoakF/WuxOZpm0xo6iInmNB/QfA21cWQpYUPxRQVC+xcG5yojwSJNwYec
nSXFcLPW0MUlG/YL89heSRP2yme1UIMEX0G/tldZ0KZ2uKCqiq8voKHdS4QtK5rr
WglB1Uw4mYPJ7j/QXfAj8WYaEHPPsCzp15SlS/Ftko+napGiTywAKfo3/qRvt8Cv
uvdJd7GTyFoTnu0JYNdrhquJERkWFMk0prtjAAkgG/rQbmgIK/+bVh4pHRFvWJJo
QCTtf/2ANZ1mPQLgFOhSnFL3zkIk1iyJgo4W9gClcoQe38d6QpWhAmGseWk1UYG5
hBTmLdj4PBizicHkKBy+KtcbIQDQItlUsAH5appi96tdUukhHQTIbcCCOtBF5Uwu
AEJmYgSMD4Ia7J8kW3Qg+zRvlN6V1SJQ1/TzuzkOVUfOs/JPtB2EQwb/mSDOrQJ5
lnkd1cobzEQBmJbOxqzCBtxHLlaZuZlEorGNB16OQDyQoTibiANOOeDzO/lFusME
iWPrwV+6mdVfqSlUQl29gn+ls6I1cxdY6GgxKtymlmjifVVkvqIvY+nB59qNTzeR
cOiLstWQXuu6kA6X3AH4lZoloeGfl7nF53GEDQhByvJcwLZaHYdgpGbchHjdGSK0
KBdtxEbHKSpLlqTlmgqwEVnyLfV2IgwgHiFNimKzmQnQPO3yolsHXumF/wRAQ5Wi
Yt55DtZdkTnKyLYxcNyI3HdhxIFfDavwVI84NANuMbzhzaWLTBZHqRNzihIpHvq4
zKGsBtwnWYpJ7qjkUrOe0x+4AtGRUjAtQVAavlabs3qk32DJGUpUqkEtNqEvnk1Y
vwCFed4xCOEFi1J82K5kzt5mppeztKHVUx62grYJQ1ACFUG3CzQaofysTZe4uID0
gXxM9huis7Fetsu44t00DO7NxyBSJ00KR8JAG38zPkH/lnkg3owCB8lxq5rrjiTg
F2tohU0sDXRqzgn5ni9TlMfmrR9rWh2adkbuicehpM7ukW7eYjWrz6o1cRxyKL/q
xqh7llQCKWoOTceoKpvdGRoN2eqlEETr3wnsbz4SiFu8phXDsByZOhj68/G+Oy0Z
ThXQxmPQLkdmZxFEg9cAvbKT1A+KjeE6yDIO8L3+EHlcgmqglL9DjKP2idtvdeu0
M3d8U6JAnYpoSbWGBpKYWfCjj90a3oU6CeSYQqDCKHMWjFXD0sNyK7bNIGNkz1OP
egh2JVBmx5kieOTh2Ti4+/jmXL/hvEPWS7H1VMfq3c3ZtumOB7seWrguDkfplc04
/wAK5aMvPpMdckN/YWoRLH7lOoMAISBoyRWlM5vbmkYpmKH+Mn2pgXUS5oR3LKoP
qhFtrd3ttFA4bNntNujKNw==
//pragma protect end_data_block
//pragma protect digest_block
J1ISzOpFhrkxhK0yU9we03XEoGM=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mEaz8trBKW+e3+M1cMowUrm/3R+NAohVRtk6N/nsyPuZwXmqoY5UulZFS970gUvl
zdu/HKxiTbvu8WJ2ZIk8CzA8ViAQsP6NmSJSradG9lt2e3hpnRQep1FPrSczW3C3
5n2a7QGkNgBcBO0xBC8hqFb9kDDz83PGYvDpnna+t1mZHvVEiP1Zsg==
//pragma protect end_key_block
//pragma protect digest_block
cg+JybdmrOx+3eMA5T7B/rEBecU=
//pragma protect end_digest_block
//pragma protect data_block
qoCTyguPuEeB/bfF30XBezjwdlmSKUnBrNrWCdwWBpLvuESOrXECfAJAhTIgDxFv
37LLwfh/76+Kosx3JQ6P6qhZG5nMKsXdQkvtU6wnPkTc6u4Gy2vf3Y0cHnX3t1IH
3DRG9ki2vLlNGNjA9rIaFXzY2lUU0ktAOr1PhJR3YSZtEHcRAPNbxB89YbfsoeXc
gottzWQaKWrnhjSljZ7N0YqnXBlYqjrAP14x8FwLXDKpGYN41VgxI7nXV6tq/gUM
XOmBEWfbWu3bL77caSf9T8UxYDo25o1hcdCwZGGlj5JUcV2oRCYhknkK4vZND/w0
cw1CgFQ+/uRoIrMcikNwjywLgD0b13QuddgBhKwGAvPDHoGbxDIAfKtW/WZrxQpI
5zhd8Dt3NMMl+1nJNVuaEBVRMbU0wIU0ghm6kVMOAPx8bXw/NCiWUHfxgPTB1GoU
Nb2TMfsEpRRrtbppMExZwzppdQBfja3FzP9rj4qC+SOz4hewxMgKHlpgSdoT0oHz
xDlu3MovmMSLMxqzZs7a5wOEkZ/CgPLE3D47vL+2F24KCfv6u4O7ADaB+TZE6HFe
YB89/mkNrBcfdhlVilUvWg==
//pragma protect end_data_block
//pragma protect digest_block
r+AUyM3LhjTtDO5c7r3BVZbSoRQ=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cGaALLSImCYcZCfjuj2yedXY1RPeLSLCmZcDhGC5yaUqQ9Fsc0ndnv+6B9yeeSbB
/HeTsESR+sR4P7okOgWaguzUk/pqHHZCECtVCRRe9pzwTvXYSAfsQJh2tXiiGBTy
wJn2duh7rSG6Mh2XC4bUa7M6vV0fBmy6PoopIor1PsgTaGfZV4V0tQ==
//pragma protect end_key_block
//pragma protect digest_block
AHuRh+QnE7JO/7JyE0Qsj5XoPh4=
//pragma protect end_digest_block
//pragma protect data_block
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
K7eNWHonzPVaLYIJb7iNJA==
//pragma protect end_data_block
//pragma protect digest_block
6dgZTZKwESo71QGtpaaaOZXD6R8=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SSeBT7MfNSvSEiuzZTVqDg6m5KF/RKV+8wqXP4JR4MQqcRupoUCp27wOPMemxdLG
Fg1D8+TbNNrHoEoJtWpoGa5gIF5Mcgnj443hMkYwwJgSIbzxNT35LeQjpIqwLdYN
HqTwNXptqkthTA8SsEmSbCxhEArCXGDWD+QXCjrQr/NahsISnmZbOg==
//pragma protect end_key_block
//pragma protect digest_block
nVjbT6Ep2YyO8ymc38yfECvfl68=
//pragma protect end_digest_block
//pragma protect data_block
CaCvp4qoIprFoYx4OlWLUhaCRzHtFOkZtNWb9AYHiADPtXHdbcThbZtkU+hPXvHT
AY5aUU11bIR2jUqG/D90dp06lHs+ar6hic4yjpyGB03fgwdRp4gwXrRVjjuuRv5t
wu7clQ9asIIHOyt6YRYpYGIttLR8VM794I5Zs53fdHjhM8hdFKXGnUiqpgGKZLzO
FEYG/IRLlS/vjUETcAAGPBNTFukP0ZxrmB1/+yy8scxPpS7cJwdttd3wVhPBY9/k
Y4EAH1uBY/+3fzLXxIhgHZPLHeRd9ValaTNoQuTHpOJCYfQbpksM2m7Xq0XXzudS
qu/FrZPc1gbcGkEFwvA2rQHAwZOAgfOOcB7IcNRFbCmnw5BL66EdAke6DNexFwqz
lXu7Th+fRjm9EJ2G8OpbN3ZRrj9Dk1UvU0xO/Bv+TIw=
//pragma protect end_data_block
//pragma protect digest_block
po8gdsD1tK+XNSCFLOZ2HwLPkig=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cgsNDI5TuqKpE6EcfO0+yj1ohgZrSDmtAsIPQ6gwK/35GrOpvPnZ8q49zlkdZa7A
49lGij35xFZC5EXmjR4orzWm+/XqJn3VAgw/3jBVAlrM59xcu47HFzpSzZXq8i/7
WHTCAyZRtIKO9wdcuEThFdcqCq1nzBKa3xZ6SENZN3FWKUfOJsVd1g==
//pragma protect end_key_block
//pragma protect digest_block
yaP5ZhSTUtvvjzTOjmkL8ftfbqQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
eTXw3ogZDEPbAQC7q5UsqfY6EM8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_TRANSACTION_SV
