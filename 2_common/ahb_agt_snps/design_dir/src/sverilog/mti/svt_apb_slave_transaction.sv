
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jwsc/2S8NUu9tAD2XmHZJ44YrgdRULrlsRI+dX+JTJFHRaBldePJ2y1wwN+o55V1
lw3sFmLA4gfiasUOamltjH66IcMp/PM06VeXNTGS4x3kr4e4ujoAk+TAzU6oEJq3
ZOjkPaqW4MZvJbc89nH5+2OWKRNTGT2owcjsLZuVwUA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 720       )
sexC/v3E37C0wenENNQqSz0L2H02OZyG+6dwd3RAPnsuwH5CWUBVZNX/ruIjlt0H
cvOeqYz9pm5bjf8pMqaeM6XZ2MIVE1J2dUZpMkZw7X91EQamd5Ke/AzdXE0AzVnH
Au17TT39aPq4ySG2ZUN/gVlRpabhwv7TJ3+ehT0T7XavzpK+ZY1GOtiH0AlIUBqA
atnrcRl9qfu7Nd92zyza2NCgNnxWlsibxFyPjP1Q/IkODeTxfYIgrvfCygM/aRMj
ePICT/ZWL5GtF/CopJKS8ZEvTdf9nJt5IExsR/XCM67SsRJIdaBZf4Io41e5OfrM
FEleJx4vsA5LjqE1bkByCBmOCJdV369FOJWkvIiuHWn3nX3/ewKWaVAbya3RSAnI
/FHMuDLBp+gmZw0GWTPYU0eFa5F2IrDRyRG4yJwT+TthouXEQ3UStyFf8G3S+FEs
cFiERsVsxWY7osX81cCoPxh0/SC4vG7FY3Fs1IYUt1hiDvaMwL5yHtRHXi7XvcJQ
4I01KzbqGUeVgnI4ecMkioAkbkYG7hUl+DdCbfwHyo7UtzcNsUEanHhVKpsQgwy+
gXmeppzm9bQ19P0oH2w9K3uBwH6HkEFNjYxQrZ7GYF0GKhiClSQhQJ8ZbjScqX/i
M+hWIHv47rCLT/SD1v3Zaqg+Dbhe3J0yfPR4uWgAXTCszNkdd+AJ2JwS2BNOa1NX
sET75YMTFIB2M3Lj+5zZ1jYJtvyubo7FceRZWAieRX2Jp/yxFjV55EvgcDPqUCQO
jA+AfVn2cmLkEgYtHvIbmb5rI42Kk6RzDKcM+YEzqshg92x5tby5JYYUCbAUKT/m
19cVrK98eWDxQBRHaSyQsqvH4EEAjOEz0ZvupUthes95bLg7+z9ArhMx4qAc6dX0
CskB6pH3MvxN0pR5ZN10mz+JJzP0KqHXHAH9H4nEWCypaL8uAiVJXjRPqHJOglgZ
TDCy0PNdq2GaCXM2PjhfiQ==
`pragma protect end_protected  

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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IQ2+6B+Ly7TFP7W922t9QwNAA+X4+9QAkp0ZTfLxPCucgsNCS2vCR2fWx7n5he0I
5uebqHnK5mI26jFPZa7u4aT4CH2ztXNe/A5I2JPkWXehjTqTonF+Av4rRfeItriP
SEPaRHhT7rStX4OtyPodXbhJzHIANO69J42GLQ6Qqmk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1349      )
WMqxNNREnWDN6PZNyBJft3+2ZnOPbAJtL4TbaYdbs13X11lDDbz67XFmyDU72fkw
GD2t7Tc477kSNKxSC33UZCt6GZ5xzIBkjktYCv6vQ8EOjUJSLhXHzmMUXkiNvM63
wBOT/ZTv0iwC9j11fI96hQ+lYEOidzNrb/LQzIdmQy3hcHXtDjKq9XYoaVK7scWx
TzM0RXtz3pUNBsL4FeHE2WD9emH/yAO7R9/xyw/Ev4FoRQFl0HqlhWo9V0eY6oa8
nqCIwjRLO2Qe4VPzIbG5DBCcgjSiMIPOZk9b0B0/rdmpC3UqlfpESZEKW8AyK0Pq
iwxeKFIERdGV5APV/WCFxjNLEHztwnjnE1/pmo8S8Wtrp76o2DOtCb3RnCRPGUDr
JH4QpIfjIGNn9SayPXPc5aC0DGFlatsuzY6kit2NUDzMp86WOg8tCXi9wVpaBwVY
dX9ApLOyYO8PcKISf+lkzLrNwy8gGg/0K9XcQgOp6++kdxLbOF06r4SH0xTS7cDN
ODKttcxcBSA+54umXq1ri/WbRoVot23xDFU7V2GYhN9rsfzg+FjY7zKZP2kHGiij
Ot8NKZ2ffntTByvwmx1J2p4QHGyVxMpy8YXCxqNDDM7tOiL1+K0kIRpZbOtbMpzg
fY242EIY0KM9GCPx6H/kpfwBfldoL63xj+LbRSunwShU0zfxNG3cWWBS8dIcd0+O
gBKCO+vszwhVt9CWhU3VTzmBHPy+EbdKkrnTyaLTCGto5yF3UyW2QPs129a+gDNO
x827FclkOA4ppAiDd8m5qsT9VC10m5TSg6he/PsekI3oJh4QvfWgUlwoMqXB8ceu
rLI18+2GrKwilpjGdZQCrw==
`pragma protect end_protected
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LrLDWZmNgUnVwyO2zmQYZtf0SY8PVYMYcSttHEl7IVKQFczgQ6gRSYAD040yivGI
QQrX4PIRVF30g43D/Y89I16o1ONX5mC6/oBOqbRN20fkai8Grsy9hwrUfk3Aenc4
QhuCeg3aABXKipwUqFxKVVUsm3n3RsLD9G0PXNdPed0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1915      )
P0uTgXNctyoFhRXI97a985+OKj5e5ct9/Umtr8P/ASroQdyjOgicYzf/BheRAeWF
IB+ZAYhoc2qEg1jeS3u7yYxeZ0phEsh/ow4plWFVz4wnE54/XtfVBwIlGCdeiskj
7FngarPyuwwsvYc+D2WInJq8HS4JctbKogq7/cmn+B7jHh/QZ2yuDc+faCI/pcQB
goDZyDIjH2C9KTDegWhFT08BJK1eCp8dzwgzmJh9SKIjToLTYVOiZw78nPHR1tjt
CnJ3pt/bkVM79Ovp+XiD75sx2gl9gU5ivudkq5ZGRhUBChAm+nLI+Axj6O5ehI54
BqycPJmk72dx6BcfVKY1FEwWl663d1dHf9j1nt1vlqMK8ip5essuj8ZfTO/Zpvk7
fF+5DBMmFeOmtzbQOgAjQ9h2BPTCOsR9sEzddGdfcF3CvHRj++VuypuQJ6b6uJ0E
0bJQlEbUkCSJcE5QFeGfe25ixR9jJcndnava972po9RTF/dstbEjARjJqjz8lGOh
6b/+dg1xU+o45TWOKxUDOCklaTSV7UrxH//upXXmXiu/2V+SeH0QptGaQZYZX9/3
SiTF2gecfM1HDogobO+ypr1oSlq2pckZn6JxNOQfNbcD/CfAy9/LW3qryZphxNwX
HnpyKv/fx7Om+WUKyTs9fSvpBbcgu56ChfmOajsK5ZTa+aYLDGaQCehpfEyEiw52
9Tgwyw4i+tzUMoJk5RYZxaFXtdz5GS0XmhrH1sbf6RK0dUD/Xiy1Oq73K8CgIeF2
`pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_apb_slave_transaction::post_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cgUi0HOooQgVDdac5hODMTiUmECyZG1FVIJXpDOWz8PqI5O0kZlYGoeES/OJIklt
1qPxLhA+8fZbXbEPgHsdtIAxcOuFHOzdB2Kp+vXsUhPncjhXAUEFCKNk5qdFHOQi
MgxjYnPBcNVWPYV6entLx/QWY5/ii+JJdRnrJXkjAQw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2177      )
Cd9bbekOcH4sTnKI61eSz76+J/WOb4lKL38f3Ek0P12OtspK/PyCakGgPTHh3pd5
ReWp1/Mucrw7ybjEHXF5xPCokmFCJ+SYb7WuOu0tw+eih6oj6mygoXkL0nX+2hhA
NLmCIZN/jPpKMVfbchl+Obn9nRyukiu4EF41CajkXNbSQkT7RechtN/riYKBqpHb
DrJhGp0x3uNLBPurkJ2Gt40LBONVfEXtv7Tp3CTHUAPqtlCIrpzMShOQR9GwYoGt
6Yc3WToE8rZ8h6Vz755nHvtajw3gi7V+OwHonT69ZNrvYpK6xQOnA5SigPhdHOvH
ymZeF5YaXCiZRqPN6vsjriywVQ6uCG45+PVuo2gEj+A=
`pragma protect end_protected
endfunction
// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R4+X9JhyNvCq+rK50N7phG+4/OEZhWFFL1Cu+/h6vW6pQCoHr2d8sk6uE1NNppFq
L0X3hzEKqlPbmE//QHVLSYkVxPbe2PUXzpP3BB1l5yZ9eIncpa6NLn1y4tyjGZS2
ctULLvMF4Qan3oi3hLlXc6vnqVxvmXO15Sx7HVUgdB0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3072      )
5OJqC1Q4Pmnmk8jBhiKq10X6fCNotCAGLzvA36zzBNwsLxNkVNHk/SP9bP7Pj+Yl
s+hZgtm/dizwlTjDDTjIsWtOLNpalCUwSUOqucDMk5jWnad5FvDPdQjK8N+RL5jC
iw4nio3Arj+TbH0cmTKlwcSypPbTkodohE1LGlmhwloFEWICVolBklbugd7iJvhM
DbIHwCr1lUuVyHQGswOOtmlLhnHOo9FqxpQModpB3sQtoWHmd6agd/DpOrPfrDUg
JsFL38+srBXU+O3xMWbv+uwC2n/0K2dQBxq2jkZzBwMHE5+E0pvxM2wxwkcmcFOa
V11ukeaTG9HD0GkXpcOlKJYVOJVS2Q+Y5Kb1jTo/8QgAv7tj9nXF84Sw8+5J8ZRs
pRuaU9RDHQKx+MOq+shK0kHujodicn5XEX6mRwub3sTd2AmT7mJo9BgVQWnP2wit
VIa3pUHDIA/YTSDluAjCUQI9Ot+N18IG+bJhJ6uNY47nuCqm1ITRbVZ8k70/gk/W
UGfVw2j7kvCvGijEE0x3kZuksXIeqCJEl/n/gS7nJcrXR9zY26y535qAbwEYHk8C
k7Gf3EqFES+bHjlg0PMf/Zvu2RRSvCEPajp63dW5IBQB77mXiyqHPU5Ec0sfg6Wh
oHIWfcFarIvdudZSxo+LVobtnIn6ISi/eLk4+kY18g3LLdOzLm6ZfQLzM80DKjmb
jlisV3MBi+02P61VCwBml5OeUHRsw/pa0muuqA2fWdY4y2JcLrv5xPmHSkT2qkw9
TnYTdc/V9GvFAG2aHa9Z+XHBFyEQz91wDaZI3NJdkrF8t5wCPm3bt6fxWLb31gju
it+vFQk5jBDxmMjD4TKkwfgtEhlf4eZhLuaH69xdphTAHu6MJTwvMLBiO/V+COWr
4qMEcV7fiWGERzQUt7S2fI5jy1G8HC2SjmvbpaDjmkeJJ7BoIQUtInFWxNGks5Ek
2ssTv0EnggCL3unMsQ+7ZtYfjwKTEZNxxCKHug2eZeguABXMlPey9vlywalkuQbS
JidX9BE9OpHIm3y6THLkzpebvtKQdxUdoAICxRFu+poY0lGvG4ebcBtuc23gEx1E
/+1u1CufXRC0wwtlHf9xiXSWq2dno1Sd9uoIcM18jddxYIsbviDSc6HOrThgM5dl
/98hK7w2rqjFgE7WA4Dp6AzEH0KPFFRNZT7/LuwdUf8=
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JJpft1RX6KHM4VODQUKkKI5cM5X2JEX1zz0L/ztg82T1d222zNFWIfCtZxuNtSqZ
5RTK2TgU0IgFt+esYf/GWK9PSb0HkNSOQzLxVLEZ2iZV4zQlsX4N4mgqJ10BkDNV
f1zfaoPhSso7HjV9MKEPKn4tK6WcS6xCv42fvPp+zco=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3342      )
YVHIRFmFoFYop7lXTrCtj7DpzN2TY5kLiWXwfjQjwk+Vz1ImukZaKp6uSgKtJzja
HA3Wxw+ADAgNtLZRTeLAqu6fwDAmAtbDcaIRvyM/vTJ5X5ihtwD4PPCreBULk2x5
OOny1mscysya5s3bMIcnZgfjtMA1D2AEnAyv0EjpyUpX76e0yzp2VXd66kguWQvw
7e+7aTmV2JoLC8hXVOlA9vY/6+S0zKboHMKpe8t0HslEJ4EenTwpqXOweXnrleov
s2mV6NQX1l72uVRkwoEpyixpRTTicaC7Mj/I7J+oKI2u2NMqlrZg+EWw2FDim1vw
RajMmmfk3DFWH+70sUshtOvpSNSTrKMr3tgTPnIsmGg=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CT3lpVWGarFRnSfvXVIlUk5L8We0SRAftiif8KohxF7irBMrl2l4UWDIJm+G7P6E
ecV5CF1eRf/fb7KgmOrqc5wf8lA6OQbvHiHj+uhSX0jBeh9dTTENZ1gFjXCoIcH5
LKC2Wsl6CTokRhNrf/LPsBw+yDfoVaNHuq/sutGFFT8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12072     )
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
`pragma protect end_protected    

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
P6oBfKG1+CVB4CDHqHjIXreeZlcKEbdumr31+pyEdZtVpMWzyfdm6dFEku6Cy0ZJ
0y+sz7vWtDw1BJtWzAX8Zxm92tyYT8LlFBSccINj7t5MX2UjJM7NL5Ytffd4Zdm4
D+3/pWORAPEinUqMmgUTdGKHXgd3Lbj4mnf5ezX4ppg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12214     )
56knKgBZOc6bWHpoax12QAANC+7r0C2dgDajfCnZ1n1ho+MfmDYq6m5At9uwdUBp
LKkQqhaZ9tye78S0EbEn6fHqfOz6y2HNXe2fGBNX55iMeDQjnxC/9DUkf5XU1iej
AGm3DVZAk/5VIK9BPsa43q2umMI0BXYwmBBRfhWbuN/iCfQeW6lyC1CYR88Wdsls
`pragma protect end_protected    

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S2Pqd1yhYVsaXWDLfsGn/rncNpGrYnwEQSPxPWZfW5BXceGQPrurdEZZVPnGYxd1
tHZOGqLGxdNM0qfqtTEjoO+GX9T0qvbAf96fSqXQM5NTe8LkxMr/g8G9FexgaoGv
Ym16pwyCAtaHy+i144E21FVTkCdgCEsStHTHfK8CNeQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15215     )
XwO7chkaGD1iFEDUh6/gnNXUpeYSAyREa4lmNu4VwiAgTVHh/DyhinfH5goVOI1D
jb2JLHwpxUj+m8orSlxIZs9XAy5iUUp/Kj6rdzRZi1/U/4s0vXI2N3oRpnwJaZCx
Cgp54T/oubyRyMu8M3UxPiDh0je2FIhqpaPkq27oJpCFpxZF9DNTrQKWqvz6x9Uk
oIy9ibgHO5lkxaeLq/Hkx1tEE1pKJ9C4TVU2zPqe+hPY24rKw+QGkm24FKckWWER
NGvM3v9Mu6XKHhJKmN40yRy0xS+4iL5FCVjCZCGXCKwzBWU8Bt1SHxGCbTv5WiSP
uLX58X/YNh84MNXGtqJeWpuyMLaX/4TX6KljnXlRN13toSsGMjsjhqOZa0I2k0Rd
6u+9NHHrU3xjxtY1TqMWN7cR+bDLEx85z6VBX4WWpvidbkgbLsSXTxc13RLToxj2
ug90naFva1qrpuxUQEpKbSPpMelgPAr9gFU+TopB0ru7TAnOs/v5/YH2Fd4bjLn7
Gr7CAfS6nn7nF6KeNEod80PEZ4aDtyYZO4fQJfmVMYmEmby6z+gJs6SImB5fXRSb
1ms/L+zkBUQmFmer9UGuwA3j74c/FKPFCpdJo1CXiS5fjsXh6pwwM4Ev2d0aQ+pS
GOc6PVTi8eDqf1/9xxgDWVhGrYe+xw72VqYKD9KYRnHYnCFwg01ZuI7W5WhI4z/p
tjWFQxDJDn0QRc6Ck+ZoaRt11Gf+wbGD5fShbMQGGt3r90qVBAg8Ifz0kP8tT4+Q
lfkU5v18Ev0eie9MFy6uayyDq+/+MbwNONEy06UeYfC14c+jajKYbnGG+ZrXnl9V
aoq/eD4pmwVD/OnR4lxgUV7SFotLwaL87irnD9lVugTOozml2RM94xJSr5+x9oAu
YBBdtSoS7r4wdqq6KTQE9akIh1UYUxZpXlw924vd2C8Q9KNNx+7ocCYizpexXH+v
KMENVRGiocAf4fkjMUp0PL7bhecw7237bo1p9TUx+XY/k1wLTtl/+LzD1emV7Sbz
hVawf1s4NzysgB6S6Z5TrU7hc914kCMvqlb8czWucN1HYcz25RRq8MpU+F/+ZGpM
XVF0m7XugLpH2vtYTmsAlREq+VAEB9REJkUysmYmLVdJQzMzAZefEhbpNX35pVr6
Q1o+GjpCZboAm994IK1XCUVBqMRAh9XdkwBnT+H2A1Oo3+SGXShA8bGM8lOujuIk
oqiiPyiClBPtBhF7bFVVe3nssgeRUawySF90rYCV1KOaANSMQ++hz6YB0GYtF1fu
N2LacLoJSDTWfRJC7WeFZoK+eE0z47wNpAkiUgnFupitaDq0CFUK4Sb91xFNDSM3
OvtP12h6evRkHydybqRbu2v1aUIojPvU9jZz9wFcfuSmU4709Q5gJ3WEeLm+zyr0
SiUz8Si/77BxgDjXqBC5RtUAL5TPHXk5rHHS9Ch+Ajb++aTrJeQ15RVTh3INlkOU
NU2v0Ax6EIJtO0VqAOIKaPCfySpDI3GMpKaT2SytUJdNvaBXEPyrjnijya0Kky8T
AIRDk0TFhIIDJoQqLv+XJDzl7svAgF3RPzbnmiwPfFepP5J/bkCNxje0HJENi1ef
LjLyEwt7tDBCrf/YCAFSD1mmLx8fJh1uacE0aL3tGesJwGLxudEtgbwEmSzDpEXh
d/lqrjOutlVipp0YqMeaIkH9561AGCOSMait5Kp/vtBkNfKnjwKZVMbDH4J4sIfA
9k0UzmaPfp7Jfs3lc4O3+HfTAkPrrEoCUATa0B77xj8o4u+vPihG31YE9bcKidAx
URvjEEYW9Odgif49oZPua3aQrZBqjsZPMGf2bAIXxc6HsSww6wr2JIMuu3ZOjaIQ
7Ty/qzknukVeXWTc+zw+x3gnG/Hx0PpZvP/Xssu6X+nBqLqLtsFawGbQbBgKrkC/
oCnxKDlnXPE7uEUZZia6T/PSXCdRDRdoWiUvhOsz27U2dwCL0wwAt612L0qjLSRZ
v3h0uT/oxINJPjlo7oSiS8Z8fjMmsWVfKUZ5FtLwZDeNU1lgue9XUx2Zz6xhXahn
NWkF0FlFEdyQMmg6j5jiY6VyHkdZw5VGxEiZbf0DHRspJCk0JvnEiuyreIdAPrqg
i7UwGK2jBk6dbfaFRHuKR6l+nuNWPwd1GKnp9FvUNrkt2raxBoXXqPFhU/Vqtrtd
tx5IPmX7JEm8iZIaSM3kA54e51BnKIylNV0wVHu/k90j8METp5X1TYg6CRZ1kMGP
pFTHEEvJArST+D1yXy4xUOEqJGiLd/GRPqrn5eqPE/c8jxhlPc8C0+/eNDBlrx3p
WCUezKQyeYQlvApnjIBcSlpkRlRbK1DnOzZLOoMTSOZ7M19S8MUXplFRAtUkNgsY
JB9wlDy34J/m8UCAOoBnkQlPP6I2VxnnFiDMuY+8GQaQAF+6QXdXJTDUkzNM18Tj
aH6UfNxgZEDugO4KTYudLGYUe/xNvAR0e2yqDGRtW7Kxp83WYHurL+zUuWXTGgA8
H81JJP3NKsFI+CAqOlac4W0fuSIg1HZq8zFsL1oWdFA1qxSd3mkOvqsjNUdVSETS
x1UtTpgwIANtly/3fWY3S3FLPR7PHBidrPYPuMVlyFDiYZwb9wV03gYMjkBVAeUN
NuepLzgFWqTnpB0VFCvF8PYbTIbOb6PuVucZsEFiZe6XFkJT7ZLECjPB2tQH0jvt
90+4swlFuWCEpaQ0NQxTSDgyAcaA+CDaQfOPs2bv7MdleZPvzC3Kk0GbCapmoc+6
PTmbtCgCMnc+j8E36vBFYTPGyjKLiNSx1pm6EpRhsTC5OhtRiyMmn585SrhMcf+j
UgLYBQibWf/nsY6YNdOUzPz7rjTii0EBYDjkp5ZAjDM9keR8ilIZDaUwdaVgRi7L
AbLxpb4NaOOlsRS8hqvweByUOhuHHxfRi7MWFshMyRhEn9cO4sH1lDEECTC2CZFL
flLh0PpVu8efLLZqZDqv3nEbGGQgw4G7ieJ8n+DcUw38whNYgMkw39k5tv7/8bGW
BRMsEWrnVnoXGglgq+iFh7wIU/Ouhg896zaihMPcw+tpc2D8YbEpok7GRmdkfsm2
tbHUZtGHVqXNmFCI2Dm5K8vh0+bWbTlmM1PRVdumJFOU7TVOsiHzPorlrLfWa9gl
xMkDj1zF6ud6dccR8Ao92Tl/pPGJPDxzKjGvjtwYoFK/DAQhVSjmWstZRZJKIH6W
WfRCUsJZZBottrtITsvCLgsDIuSDglMxXnO2vvogg0VSP0+H1Ka1G6frE49dX2Gf
Wy8wPK80wdK/06c0j7u75x+iVpuaAvgJepqbbL6tcRDIua6ShpDDI0fkXfSChUbO
haaQztDqjxtoR35BjkEEy2LCk1MIt2mu++/9i3T1s+JcKsDEtx8BViqgYUYJBqDz
81QdaUW0a0zcEMKV1nLv7DCQ6dV+HFU11xyjhOmG1c7xmCIcGjIOLPXHOWY0202N
pJ82TkCcuU2Q/cOcj7X2WbX+8Pn1AtCW5GPi3Dz0yiHI8F/OFDFK4ezLHoLi5YU0
An47iSD7SrDXg+Dzp98pHafECvhhIHVUMH3dRY3KdeG2JxGswWX6e5K0taCot6h6
SzTfvKQfeU7RgLVnUfmLCI4RRimImEox3U/WQzPhp/3UjqbBNZKBEZEI3JhMlMjW
2PQTMQnWKRtXQpOlPHwPmYUQS39JXoes2NPzGqhk6frhJqIZ9CQKyYiwSRO60FeP
pZZRtsxVWf7RtG5VY30YZfMyj/HdFi+Uq91KjUeA+7i4ockfoLM/vCit/iwgvj+w
KM+MAWGXVankMrH05AGj2LGFNRTcw17HDyuFgfWJa3HUj6vI29G5qacqn3d+tJFR
JGJDNEsbt+qOBXvc+Phyir9BF+thsr9rBHHB74DwhlYaHs5QcTdx69rz1RMsCCAR
E7hOJsiWoV+XHgiumIOGLaIs6WbTddyu+kR3EVjUez3bbF2+jhG3rHndyaeBTv+t
/vhXQ9clKw7vvUAn4TRih6HEXjoJ+bBDpOU0oAL8cvQ=
`pragma protect end_protected

`endif // GUARD_SVT_APB_SLAVE_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NfG3lhOX4WBzI2WHzP+ax52Fd4wYfhutUqoTtT9I6HeJ6XoyYzPS0qC/6AHPy0rB
lR7i1MtexU/1t3+yZ/42pcil9j0l/NT2RFZ/qihS+wWAdaHCR2xg71vk9LJJSkwL
+p+UecjUvJ3it97yk/U4ILv/zKzGB3RfgCN/M8y9Sfc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15298     )
8DpIxxLYq4HpU27/ZvbY8Z6HlamEMdc8Oz9BgXeFzikrZoqAeUc0IxIqKxqvBieO
atiQQVTydcACalyBsub9LQNAFNwHtPFZDcgVfeAGAo9aggsNg582ogP/vV1mkGsc
`pragma protect end_protected
