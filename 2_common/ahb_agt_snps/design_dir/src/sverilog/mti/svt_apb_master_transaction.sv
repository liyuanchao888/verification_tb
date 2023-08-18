
`ifndef GUARD_SVT_APB_MASTER_TRANSACTION_SV
`define GUARD_SVT_APB_MASTER_TRANSACTION_SV

/**
 * This is the master transaction class which contains master specific
 * transaction class members, and constraints.
 *
 * The svt_transaction also contains a handle to configuration object of type
 * #svt_apb_system_configuration, which provides the configuration of the
 * port on which this transaction would be applied. The port configuration is
 * used during randomizing the transaction.
 */
class svt_apb_master_transaction extends svt_apb_transaction;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** A reference to the system configuration */
  svt_apb_system_configuration cfg;

  /**
   * Weight used to control distribution of shorter idles within transaction
   * generation.
   *
   * This controls the distribution of the number of idle cycles using the
   * #num_idle_cycles field
   */
  int SHORT_IDLE_CYCLES_wt = 9;


   /**
   * Weight used to control distribution of longer idles within transaction
   * generation.
   *
   * This controls the distribution of the number of idle cycles using the
   * #num_idle_cycles field
   */
  int LONG_IDLE_CYCLES_wt = 1;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NUBqZ6h4eleW4fAnHGThibjh+AamgyNPL/VlGFARJcNPwHQ8qp8MRAR4feveG8AZ
ksL3TyToMvUlJq4JtA/eM93eh7SNr6G0UKzHD+svgmF4Ffb+MqigOBekn/La1SuC
DSoAOp/xXzTrP1K6URi2mOW5fQ2XDMe/yn+UXn3AjLE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1150      )
gt1xMTczcidmHnzzmgWZWkWJ/E1hO1ltCozSOXJ98m+pGsm0HD3yRFVj6B6VS9EA
5h6j7UKeKmp6GrIGJ5ufTKoW41fCmBDdpCyH3EWfB6Dfs07dTrXisvZjarHagGUf
iI8bkY1lJUUl6G9g7kBsuj5IDmT7Av6/tcRwNd6RIbuAJKuEVNKRT1UJMrfJPwFB
99T1jUaDOFLk/lyTciiPGSqvntzGbIWJciQ3MCvLwWbTlHiB7a8Fvi8hQl1nK+ms
IEmH4jl9a1jkbBTl/nHNtLN6p3fPlGD8xJfcj92WgJalarTamiyYMMDvFQsKscH/
VUbo5ZoNVWTcxISPY3ejPnuh2f8uEArnGhquV26ho+E4h6dRq8YGEChF0rXVGzFw
Vt7YnrZSI2JdggttXNjOBNwa6Oeqovt+tb4WZ95q7ps/L4eiZfzhQIagiWUKI+v5
aYU53d1O53dIc9Ar0pkiLYuhr+4NNro7YwY/zt1/vxE9Yy/QShqN3eaLSS7SgpK8
+lr8lGPgOKMZdS+9ZpBXTe06UGqAK68Mtw2cxPTI0mVYSnyb+U69Gyppqtzz1Pln
WAuewVlXPv4UGe2CcPow+uymMEbZArkk3oLGiOinfiI6UxP3Gfs5KX+eil/gFpQD
lPuqW/XODJ5zhnvdCg15DijTZATysK7C93LmXmHdyuuUMBZJW2tcNmKcBi8ZvjUp
qqcVr1jLXr3kmzJkPPC2xN+OvkRaHyO/5SoSZRfLeGBXpBpgTzhN+USYUL66VAO1
ZKdzN52Df2MoB/fN7lvYt7+ns78pyzC67CrktblzcsYDbjfqP22MCEiahIDF+DGI
EZxQQlBL6cIuzxhTmX6ocrB0KkWNVduDvo8TmcgsUWDMHm5s3UUY4kvYUGpgR6T/
v7epjaRPKHYqE23nwUPk2FnckocAgpJvj9oGA5gX+iHLIinQlx6pWHX+h4A/FTGi
rXe27fb65R9qQWYPZt7jHwYKRXpkKdbaVqYUTiZ5N7GKCiIfflI3FYLNGkn9B7CL
De/ZH5kHN/B9zr9WNKGUxtRGrw+adoGf1VeZ7FjhW73UGYLbQuhbAdNV8GsTBGKw
YN3xVdfnym3fpwTswtqq9wqvfZbUPRZxtD1Tm+dtqwOtfAqN1n/GbHMxJKqA7Jtz
JjS6u/SYuRnuQdRZ5zR06V1oFjkwmZs0IKhXBIzRoo+J2itn2UgeQXtsg47U562A
RJ7/5c2eQoQBprVH4TFMfCJ/ULpZAq2HTuiCkxBngdAQfmhiGYErAtzsMs2Ht0Dk
HMl00eipbYSWpNISKv7dGn6aItUg9L+UiKHCWT9mcZNF2+IeA+nuhHwbbnbnAMhN
6Etif9lk4qzc5VJdKsX9VU1sWmqQ6GniQa1SmU2niAvFPaq+TjXHWeMdzxEzz6MZ
WTfNgAyaPqeioAs2Z5PchzTfL37nFS/hbAiicbaddX+xmgYMyZ0UUpfU+++Glibt
DYVeL1nTkemm6eAgKIYlN7E0zwInEknLXV57I74QR6HECrQZ3gRDZkpCLe/vSP6w
`pragma protect end_protected  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_master_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_master_transaction)
    `svt_field_int(SHORT_IDLE_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(LONG_IDLE_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_object(cfg,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_apb_master_transaction)


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
 //------------------------------------------------------------------------------ 
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
   
//---------------------------------------------------------------------------------
  /** This method returns a string indication unique identification value
    * for object .
    */
  extern virtual function string get_uid();
  
//--------------------------------------------------------------------------------
  /** Sets the configuration property */
  extern function void set_cfg(svt_apb_system_configuration cfg);

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
`endif

  /** Ensures that the configuration is valid */
  extern function void pre_randomize ();

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_master_transaction)
  `vmm_class_factory(svt_apb_master_transaction)
`endif
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oHuW50GWSqwNLw6e4ZhV3LUAcOi3lAemsxT9s+yvn44zBdRqOEYhWPHkynDrURLT
SO1jm9uL04Lp6E9u3o3Q/M9V97qIoWidwaRxSC+6DUJZEMBGmz1oPCcFEE62zGie
knpatsUGJUKjRSLJq1XYdbRIH3x+EuFStxXf603A6uI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1893      )
czJv5JmPWcF7kKlI1y25Z0QqcJPI2CRvHB9twSDTbaoGt5OHtY5rEQpGx/Di+Yyx
WmhcHUjBubdDuelTxDlMIyDgELf9yptRmyLk57qoPLpHcL3Nyap8YIYQh0zJsjlo
RRBgn5a3nliTzDZNX3olbkjh6dfVxCGHLfd9l0vFXs3fA5q2rBWW8vx3iDdC/qZO
DcLaAP3QNjzkPzMVJB+dk5LmHnF2xwDlKd+gnA4gjf18wAeiRpll94Wq6+NDh0aj
w2JmgNIAIW7n7MhKx5D1WJsr96kvJasC58VZe1BIB0tpjKupviO8VsHy0HR8OFK9
Q8RfhK0bA9kkTudKUnUrIVVIE0a0vXy/aA6GhHFhPbgvtVzHQzzFdvfyA0W1WDVs
rwfLMVfptyAhPYWVSPAeZu06DiBh8X0KtxhcS6VI6qXrhSZoFXldKw1ElmKobRHK
bZPiDi+oMd/F9q47enwJvtR+rIt32P9gGkx9VlRCvVy9g+jwLz0EcLI1WrURpXJH
l8kkIm2tTRqOJCAY8yi4DwtoSkUbOsRbocbjvUv3li38mIQV5Gh9op/B9J+T9wtS
I2+2+9t3FG5PwTszNfXF8pt3SzsQoqkjrQm3+N7S8+6BgbUhCxveFApJP+rx0aQ8
gEegjEQ0wX52TYK65XBCT9DCJgpT4Qj79euPNxee98ZHvngBOk5lk2lOpz4f39l7
WtBaXMeMG8Sakdh1nbfsexAFYMLR43fWzeYZCPLblYTHYc6uxVYK0TjIx3yNR6mY
4srARVS5gfVOtqF6sHMybDdyJlb6Rrp4OO7SzW1dFJc27DqvRn3vcBFsKskV5D0r
IsrlEhYM6S5J08OHjAvxbZ82IiGmjPVtYJ4h/N2ZYsE/j+TlzTuiNBRypWjS9sIL
KCKq8APWunj3O4XVzwd22HgEdTjJ9nfv0fo+GLgv1Z/4X4WgfE3NmWs+Co7EiOze
q2JmZEd+pfa3zlAI43AVK6K47ORw0EJMeZ/eAjiFscA=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
T4PbhBZfooBqmj6EG2jAO99vgBjSyc1n3ZHaqsAI0GxX/w8wAvKP1mUHRSbB8kGa
lRTjX7bXlLexCxZJKBlJLeHz7+mUSX5kgNBKnDEFquvUETHzkk9QE/j4waDrG/AB
BeLfgtJpOPnzBVoJoe3NGObdR4E/Kc4NvLPiVIIzq1Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2748      )
Cmz9G41qypugbRm+SqpBnHJTCG1mIBk2gDim8a7kqVqpNexU89G1CuaDcphlPBNV
gPY/RMob/lJC/wXiqEe5dik0TlHMC9GfUSqxrWk3KczpmpkoTRXizN/g5MoKKxe6
GZR8QtnkWpquhttWSq1dtckMoLmUFcFKIZaQ+wYf05o3Cy5SguWwmVSOD9tb6xHQ
9bRRJD9EGYR5OdJMnx+BX5XMQK7hHwozQY+vpdPR2i9bFOxQMCB1rHkqjgrdCzgn
3QhYQgfVXagOHcc5vVwt8JVaAuMsMJuw+zWBfdmSVkTFkDlMJ5agTeuEfwwoOuTy
uQxeCfQoxlq0xGOk88URNBEfQjhp8HNQkRWRV6ZIkeuRMLYwosE8JBr5zlwhkNTF
PjDvIM+K1f/paroJYWcfgkgYAY6pJzvJ9hs4Dn8lgbhcG/8bUTGcclF7r+IrSPh8
CUpw3xKQJqn057+PaK7P2skA26+YCZMkC1FFMoHoWtT3G8tL6rxQ8ZD70f8RWQdA
eWMSVyZQIESsyxTK6eSk2d+MqfNGGD0MjKrhTF+PcNDBXtfhdgN2720Uhd1R5PBU
jrW/zSrtUgGS3O4O5ah//r0ybCNDQHdsrdRytBoXcZj8oJYvXSC4iRENWahaDa1m
724/f4P/5hhmcvzzYvoA4BMlvM3WXF0bulEtbA9K86llvbX20Hs1yfJeXMUwCIKe
FHK4jXtjyQNyjyJhG5t3BsSP9UfwKJXHPz/2Mjm2rFRR0C6OUSX/Z0AUkwUYYTFn
xnN7quWXzyOepLe068uEISahUMEti/qCeWCACdwwWtrxlrMk30fNxhu+JmrZF3h0
1eXc9OJe5gzOZfvhwmYkMCLQ5S2+SyL7Q7kjOaq5/NU1eu0w86C1C8cGmuI0h7HD
mNzwxDUPgvEfFqq/nDfLG0d3tlNkQLa0/1QoZrUmE2A+6RxPIOz1Ya0cpeSwRyjw
7vQU0ifux24Ixje6LNUdACsTHRnlhCWqph+RYu3zRXEUhkR2Sj5+uMT54iegSi7e
orcbGK5HkkCvxRb/TJtXls3DCHJ5cWIHN4F3qkYSmL2fgZEuIcx6nwCO5kBw3i+r
cJyD56PM13YE3p2jaIXANsTThrpmZHNMgXhP5vxC/RjsmHXyfZexh9ZoYx+wFjle
`pragma protect end_protected
// ----------------------------------------------------------------------------
function void svt_apb_master_transaction::post_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
h0x8ng0qddIU8v+cqkvnIdQek4N/ioUxo2dteUoxaIiuqQOX9LAJ8fBknoEWQ91t
fbKCytAQvFWaRNkVChVuw/55y0Qxsc/MyKPexAnHmukcUeux6EDkVPaE7oS5vNLd
ovjwTxpz3Tr7YJoKP5jiNEkns8+7TgNlw+TVxx8/IuI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4068      )
Xv7cFALTF3crxjUQ2aFqEQB32eut9dg1RUUCPU124f0MSXrD3Dy2FScq3i/A+cEl
VNMxChK9XKZXJK7+fm+kIqyrmvbShVFDRyq5AnmNr+SucJ/k2Su2jzx/XvFCYcfI
RD+s4iWBUrnNvFR03ybwh52JCaEBnFNA42WPAkcqkWtRSOAGrGLXC/rAISeBduRC
kZWUdL1V3IlcKQInE+lt65/q7hDeB9fk8rUWkS94fgZ3YuZFgME7w44EEY9B1Qa1
opq+XciZZHHNgeRcgB+EXx1LK189nb5Wesf/XwhdUwl6k0EO9UZLrBKPv0oAuy6k
BhE+FURLj9hnwuo/c6KBVanjf9wiVmmBiYIqiglqZ4yysNdPQh2f2oWzjO7rJdZk
0jE6ZtA4u4am5WyQDiQQhgSgUkKZHYToNZE9eZtMcu2HefflTzeCIqIPVgF1rMmR
sF94SkE8IRVA+gyu8+50OYg97gfu+vOb4Xul3z/MaTDYmEb4i9MAz24JDJ8VEi7w
xy5e0ZEmx6DVMV1rE42iNqkNe+6jlpecfRf4sl7BHMBwnx/+3pTrIF/ZVbInBXWX
0tskvbwhqYt7REmu0aC+ql05OO+NaB6UvXDO2b0p4axDAO/n/e9cC+FwL4ALR9l4
I4oPqTJa8XECur+jChVBbqpMV2ycjR3iKzrUU0r1IPDrHJQHX9W2DEc4o6C95rn2
RlTP7Q6AQ/FXfl8heu46IDq9ycTK76daTzwo5MB9Xf73lgq2jviSYEFCVDXzYFI0
bPl37bCTu0lxhKbkSQyuqR6wP1QpOtkMu8fUjcFRmcQFFOl6fHPqNTxPORubb6Fc
KARDJUa1ZLmZIOjsh92we+YFcSfJgE1SjrkEgRKr/z3nwwN+cEurXyPX5BvF8ubz
3ruOyqu2ECS5Zgz9sWvhDiVRFU57GFnMBX2TG9a7Kr1S5hRBk7oLS5ZGt7IGPVP0
B4F4+dFqKJLKgxUMSVR7RutF4ru2SrKo+saXI7iaEQ6F0HVTpSF9NwkdF2B0VVWA
6kNMPKCqBWTYXDPED5evDrjjiwjypkf21cR3RfL62FOGPpY1nf5JVDbztLVqCNdt
dfeK+gl1LdIoOvUQzGGYe3R62I4M2b1o9gcuV0z9jlE9nW5BQLCxvdyB3VKYfkhb
yD/s+Vw/EFEChOt+rTVVhYGE9h6xUh18npQOtTitA/cmrCueENlQE9guAscf2J5E
/CVsUQLI18pOe3CatScbrAr+9ORAAFJFvmPiAvgGjTYhjlNfCzLveHHPEkG/WFvj
vanlYBqMH5nh7mdqwCYi1ra2MNURjJsRtOKqLEGsB8HzdaFMPTi2I4K2/SDH41Yg
JZvYwei2eb2qf/lONx9kbg3wFLqfPDbU5XWohPgIQtICMcrUbqSLZZzKqToDj281
4R/6yXbU30UOYn/doaIeGhTquhZ4b1IsdxMGetmQUmNtL6f85sGSwzQCImhKTPzy
GXU/mkJFzfvwnF70EdQ45tlmHtA2U54gBcazbdiLK1gO3ijhP1CYrJQpIp2xR9AE
qdcIIdoaZGPLD/QH/xA+PW3TaDlnFv4Zx1I8mJTi7YnBoFqVA7HYfiviV/NgA5tU
pPuItRBe+12xZdaWo0CQm7Fe3XjgVjjURHzA6GUpNx12vB/OpHHtfwrfcZi7Eaqv
V6CVIohvi2GIgRNaxPaHo8IG77Oc0koUOmlXCCidgANrbqx1cLTImwwF9Mjj36ww
t3ojUvGyCMqgP8uU5xRWiqlbwrlt4P3cPUGfWbGYhyY=
`pragma protect end_protected
endfunction
// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KviY6BRnPJHlN07T/h4rNCGUB0jNH1u1uTl2HAybxOW+H+9aCF+X4BS2qK+rpJ7U
WBGdsBXW9n6rV1q9I5+CWCYzw2QY8xvJSVKU7Y05SOSxsbapMiShC94FlHQFVnCw
EeyDRQ1zHPwnUQQR3qgAG5nDSOLEH2jArC2twa/lvYM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4850      )
+73hbcCKxGB649N28I0vRB67aGbeRseh1MXsJ2WKDZG05tpkiI8vXwuQDXgys8h1
NlKt3cUy/yNFrUncPK+UnXxPL3WmgwwWXq/FPQVWw+F+V/PatsihX2FJmqi0wfwY
Lvv1cr9Zk27zkcDF3DeQvqyy2O0kBAfHcOVVo5v2i4P9QD15y2rWTTl37CXHLjAi
ubyTWSNggH95+AgsqbUzX7IJ1x5ZXQKBudHqaoJMzTtxI2K5xnXuxx+4LwhAu+xb
xUGEvg+S2unyl2dZTcd7DOZ2WjYJwQcaLxCO1178bkVRMXFaTwYvVQYL003+Z9rO
XiXHFejXt02HWsMH1jMKh97Elyy/2QIlTjFhRTM8Wi02OwUcDzibAUvu+NdSNOVZ
rSLLVnMHfwzF7cjEDuBzXWigtX7/KtPtCteexpvq26tnzl5VBb2k4etwJnk1D+X/
yT5Vt8jaUqdpyjGnLnWU/cy3KTqJFMosEAU69AVPYDsSnVFZHaSRHhJN4sPpkYtr
os2kFIAk9nqInKWKF535LmVM+K1tYDfzPPrQ+Zj3IDwImGghq2RQryT2SfprfVBU
ngQJrtf515qPZNlBm8bHWDC8uo+UsW7Fs/kEw7jxjix7PMLP4636h+gtO0cUN1DT
VeagqY9QeEB5raViOFP2k+Hf1yIi6q3LIlhCGHmFqRJZ3bREcu8iBIoAQ7DBBKNC
QbfHyYv9dqLPpXMuklw1NFi3PlTag9TqRivWo2+ptPlIPBhsCe2q7P5ZPcXmemrY
03TpJ6QPV3YVsgu9wPVCNsmueZQKXM43Vo5zfjnAP88tdRV+kYIO5+3rHEdR96GO
RznCs5L5sqlEuw13pr5n1VyTyXPQyhWkA+YS0jpNP5xZzpvT/8uKvfidQ8QOQwtJ
oNJd9ua9tbV0NYQ+f4DcBjVd9ST3ptEo1k2s3JdJrMBqkoNubH4WxvvLXR/05w87
WlZieAbNBqnRtqBt7Jaq60f9XdTnP0HSQd10erOb2Vs47toY9VG5CZhzoiq4XLaM
ZxcJoBZA2iJd7y2VydmiUQ==
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OQDLIEP8F1A5ftNzrhulYvBvgWU8srQFzUMZs1DRyMlVWqhdKcO6D22Cw9TwFtbm
SpPvoqsQYsdsX9a5INIqgIpAmxAW1QjJGs2nuvmSp3Mj6XkU/I5ZkDZ3JodunBhu
9lzCuGzfDQ1AR35tS3zSzStpY2I54MHxz6I2aAJ+nzA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5120      )
oGJiikkq5mSlvphMi5OTYE0X0EXLTlfNI8Foe/dFMGWMgi9zco+o8jDV0wbKgg6s
4p3r8UpqAjgkqvR2xVct3D4OF/xzxgmZSWzUA/ef5r3sx9P5FgOWapcF3Z7lutHq
7Iwb9REOkZjShXmMl2SvIp3qmiMTd/jjblDA+DJqJfJph74kHwE0cS/IVmtHCBoy
38bPOhgx8v4ah5DaCZ3rS3nvgaXxhaqrcKWVPkrjGXErGqvDWy99NaMA3jgsDZkB
YSSeSP9DaamBciWyZvJwmWA1if6tzYK1mF64aEuwhuZGNmeMXO4WSd3roGOVYuB7
mC6Dd56HkHURf4SvWqIe62PbI6SO3283WMou9/trYaQ=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
P+lStr5LoFkI2QX1Fm7R2NG6ltNmxrq3v2DmyqQoZd0jAmzZWzN1rEkZMdOuDgyT
QcLlQ76PduJCFFz7V84ywTSFNdjCkbzASoZTBIPBTJLnryQMPV8gwdhQykL12Qyy
8LIvT6mLv9bymzA7eWUsonzxnCtOsMIqDMPUVDVvzVU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15456     )
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
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hSIlUfm7AatmjVj14jxkjnff5mU7O5ECI9C34xX3bMPLjL3ZSl+xCVGoqDm/7o3M
30MpLdf0rE0ZpirZM63MisTSsRSJUmEuY4sqXeyi9xM8opS4x593BQ/TRV6mI9Zx
QDABvhKRJucMbptFxrmcVAPmj58g8QC/lEmqz9zvg2Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15590     )
40yLOaeXFz1n4dpBOLewhQBYcek87ygPTBouBFY1m2dJaI+3+LYc02qym4OMWq3R
egHpmJ6e19IHpPLrwfNbAGQNPx5g/THh7HDpqgdieoXulZ25U82h7WwFUw2TmQFz
cZ5E7MD0g9gfpQPlbRcR8IXv1s9WVTdRIHgv1FxbLj9Jart1X0rz0o5fyL5mO1j8
`pragma protect end_protected    

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KjJHByx9EytpeQrT+A+DvpgxzkaEWVNdqnZmAgmhW7T5O46zZUDOxzvbkkuW8pxl
MALbNn5iDfmxxo2MG7qB1nP6x2d+7eLjY94WUEDCePaImEt6A+aFfQvIRnDPeqFz
FXSq+3M0d5kP4LicDWvn0IT2uJFpKUJZXBg3gswQc6M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17372     )
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
3Q+WF943CiUfIiou35QN/A==
`pragma protect end_protected
  
function void svt_apb_master_transaction::pre_randomize ();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ev06gllyQ1/A8t8Q/OhPhJhhhuSmnW/CI+6Cp/X58jQDjApxgbu/0vdby4RrucrX
vzgWGk3WV8W+dHoAbBa6qNa7yX+VUF1TdMlTxkOJWjCopgDUWvVGCFSGrvtLaYZH
5MUFCTDm8DXAKnJoOT3Ua5h3oQYrCwyCXidSfxMPsQU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17764     )
rQSkZMS8YP/jAtFDtwCO1vBWQWXTdHBVbivqQKHZfXMj2t95pEv76G8TA5R2yTjO
LHY5oOu1b0hINofEdJfA8IQy34gntLWM9nAja4rG40AejDfomP+De0zq6Ls/4S8H
LK2e+dGCIfLHIOidVARkmqTIepfDXcwbklZL5ELDtB3reQDvWQzsUY4an6iD+7Dt
zHU2s4j+D1RTPh3uarroe7J9RqSN1RZitE60XtsNVzig3D6kPJjmor9NGBMOozIt
MvjRJgK0B/mPheB7jv1c2fNsf4RmwD5Oa1onUb2zvJQIzTmhBylFrvWBCiN75zEd
1LXqTaFht1XBwZbcHRe63/xyieR6y3uxLe+W4clKzTZcXw1JUjsm1qvUiTsLJACN
LxzcJKJx/UrBFnfsDqHw/El/H0jPymvvu0o69/k/lAhrhseWgHt5cXv70MEJgPzK
/uDANsrRnkeNRxmiyDWh9La5zNxY1rnHndUrE68G0ACCq4j21BV955KWz/CG3C7I
DpaCiH468jmHVm0eHxJ1eg==
`pragma protect end_protected
  
endfunction: pre_randomize
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lPi7jf3PTnS06juUFs/ZtivwxvJKKLyiLoUesSqBbPp0uGQF6/GWif11pTEzD7Zf
J6p1GlGBu3p2WpGop0MfWDb4l5JDQ/GPxHiT/ViCNJ/cEEo7YXC67+8Tq5qkf+HM
Pkcr6aM3qRbmjeUID8yYj1JxwEQPgSNqhy4wOikDFa8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18591     )
fc81GI+b9f9fbTa/Uy1XBbpMEtNWMLOJQ58FW2ylzKjYByaI3oNtXhvTcnDe9SWS
GRoyQ1Zls3BOBfa+hwZZhQf9i2r6vuv7CPV5cr8yFQbT5hmRyWtRQ/gWEseZm1sZ
FPfcgiGKhm7usTguM9iu+7KYJzgZA+gZkAgGkhS0FTg8somEkpW4iS8MDl0MRTD8
bglZddvkb4f+6bLd8fjqTDpTavVlHo+L+oAdEYT7zoeN+x6nYKdXeBzVb8sqB3xe
tILOevdAEfneELl1SyhDl4jDF51qJDAO0G0NoyBQbfN2mioEAny9r9UPbxG5PV7Z
fCGtJmMET2cDrAQ0hs8Vt7Z/mhuDu6ZBN0foVwaBYwsD+VuiUPMqNZgewykUWiwr
v73GuUlc7DSEVG23H54v7EofmQPCzto5StWnsSPvYJn1120Jm8uioyvbUYU0NHEN
FdC4YSMkgEs+VKsMOuWVkKxeg9fk24HX6WLoPJbvF5qIxArvagQ/gxKpB9IOWdbg
yjRjkRwVXbvEn6meWUaO/HPiaEUN9fSsB3bIDKfsG9wOaGY+CGiRfeBYbeeycLgB
4guiioqbW1BPi4NZaAxbCBs+U780bODltRyhxe3NDNodt5EiLYSev3/4Sv/81niv
vbS/jStG/dQRUN49TfnqCkc0R3S4peEQnEj/3NqIwKebzpya2syUER8HROnXMynw
jOGUVWm0oAux264nJ0eZutJWiU/wIHceMBFL9P2X/WuZv+YwTMi6djIfq/RqRVJn
zmkk3s2Wtd1s7SBLhZJzazVEO4iHxTEZfXl0+ucTttqtNQes7vTI1jdVYpQR95kP
5zxL/um5IKI4Ls3kRRZs9g+W2d+9fdLoKgaXjSJRes6eWn8fugCmV5quYvZdVqRK
gtl5xN3cU1jlwhvTLs1UNk3VM/4EAdnpe1bTJLt5ahTC0ScNQQoAj3IjeP+7x305
Zs1hVay/rQEFt06z/t/j//xflRDH+GMc5Z0N93O8XH7Ub+Vy5VcmpCsCWUK/GXur
JLmPzl00i5R9JfoksP9nK+tFE+ahPMz8Hx8qEx2MYQkxfYJPMQXE/2Wm4ztoGofu
nU6pXFO0R7RwJJFjXAcT9w==
`pragma protect end_protected

`endif // GUARD_SVT_APB_MASTER_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Brmnml0qHFDv02xxMPTQ3ryGcnjnEZ45/gMymhSaPkVnUmkX8luY53ZZ05WU5vux
xFTRXznw4m3LWBsrLOItoKmSqrqe978qdAZmYgk8J5SokJ7Gw58qkNlHUfvH6BsM
S3RvztAQ2a/g43rSgE0WorkFDD6KOfo+DvKEUB2Acm4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18674     )
7cYzsQmNTg5xMQf2cyDa6iOBwqPc1T7pWZO/jXrGUQ9/1kRlvzkbUB7VgNqwI6Uf
wOHVg8j/CwPOVzYSHeZgPosH4tNz4RmvydY8Y5ZthTtuHVPN/rflAqvEMq2JaFoJ
`pragma protect end_protected
