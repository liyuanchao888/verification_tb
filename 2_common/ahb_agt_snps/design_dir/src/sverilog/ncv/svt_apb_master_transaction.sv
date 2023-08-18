
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MLK8vbVC+2nEInG2dNooxXX3P0oK7qgfIlJcpPWCRpM+QFqD4TwtdmE6s/+Flp8M
pIhVPrcPiw2BcApbJETFuZ5wCno9Q38jhKgUSpDG7uDpc/Hj346PlKaKzSuProuO
MzIQQtd2p83t96ZRfuiriqhjzQVuytYM4Iyc8lB/wN6ud2VWgaceMA==
//pragma protect end_key_block
//pragma protect digest_block
AFLPnkAw+16e079Zk7Q9H8tslbk=
//pragma protect end_digest_block
//pragma protect data_block
m5xFKwq9tYMlpmyNgKrHNO8keFxLmJJVeLmlWYsrnhoH6mMtSBHtZvzKXRxVtxPB
KurP9hDfBFy4FqbdhWUnNFtOtbFQjegaHxnaOmN3LPzb97zRWwbgaj5m/OtmfNZ3
VMP3u0xV8we6fX465MKxA9IO09IPXukKB3+EvlqVqnMxf/l723RG5Bh9zdsGgcm2
u6PFdwzvJl4+54XMPBYY5li6ih6pPK5rfatQIthob12oj0ksjWNtX4MNkmDIjqOf
N6EyUI9vAMw30NCQLnkQ/ihEloF5iys3g9aHQWyBCucH350vqhFAqTEDxnFyYyEZ
qplNmd8EAzhSkKEFrbwhvisNGFVLyhGkZWx4t03AkbI+8i4JacwWHqlPWbGXBVim
xFbvJMLIHSsiL5biqvjvCoWlIs1ZQz8Kx/dYqPWdEPs393z2KvuBy77eC7RAz9T7
qLO1lzI30hQAsv7L9M9v6QPHnl6fSn8lA69MIY2bYqV394x02vGzt0i10fyU5Ak/
zaTUs1Zv5lZzfUuZExTBtkqa0hiCsK+EX4VdJ468xMMvgI8RV/X+r3qE+KV3Ad1T
wP4KwzQxg5WMWCjBU3aQ94sdxuUvpOmU4FnxLi3gKkeXe9s0Y9m4aB/YWW8EA2Di
2RPQQGSsAdMtg6266+Br5vUN8JOa7CAtm/qRpZhgJdhuJtjOW+P0P+8DBB41k8Qr
b4fXFiN6OB4D0oVwpLNFWWeV+pUyHMkBljAHPxiktfcCRVbPOWyqPF/cFdOJYUbo
f5hTJFWUen9NBVilJMtfRbsAmp/SbUThUu2C8yIgHOw9UKN8Dpd1jkQV3QiLdXtu
evPR9zG5+0EKNh/+EB1AiUeSbrH/zcBEi9M7O4ahDmSdYPetJgqeNAjYIAKA5/Fa
hyAokdPVUWflKfXGh9LJi/g1SBEQIrQPE/+PDFB10EZyTJo+yPN5vq9y7IYai9/8
MemZxXhe0IzT4G5YrZ+CypDM///vKYXKdDJ5C+RchJiBSCYud7UjIQtQB3SJQQP3
WDvHOpNvCY/Wiw9BQu9IN3403fgb7tlJxGpxEJhysIENK9YYm6UkTzKGiBAxyMIv
GLTQk5iQtvYuerBEz8EFIGj0207h7OMJxQdkIBnlqk1NI68bqVvbXyV793A1qP9k
QgIFHFoKM78PrxEw+LEcTRoPxgJJAmtOudvZRwaoFn/0aliVn2eogNkxQPqaaCit
nY3Pr4ZZ6j2SphNwhG3SeQQGSguC+R/Q/I1wloi1WRoV223Ga+16lCnKp3NgUOXN
MxTgr/c+Q4NvMuVfSlJjY26G2S/2NWdbEt+FdY+w4Dt+Soi4lxuH/APAr0iLyvy4
1dPths21ZlSwA0YJBG4io6BUk/HfxykHMR8KNa9WgdLWtn8I77g8gaWkL4MOR0ab
rQvqg0e3amWaIhYfiddkpiqdjcPQw4e9hXBQ1DYKZJA58UzUdxMaT8h6J8AvuIkK
GqMJChjfbaP/e6qbGeAnsyft2GS2PgBOBk2uxrK6Gw85aCVv/3eNcvDIlrv3+zkN
Pe5VQZdNNycmIrERghQyo8OzJ2Ac/V2xNN4m3M6ca6QnjBL6T2d12Y9iYwCcYsgO
EZvyOTsPGv3ZuNk4511gZ7oWSmVu099HtCOl/0lB8u6MZOVh7YZ7Pl7dEFL1zsdw
neKaH0v/Zlc7oANsi+dL8PXiDip+ET7x0fWCwOMkmUCstmr0WQq8DE4D7RMMqXH3
qGITGpzOgApnI6sNDb7zRQLXAG6TAiLZOWw11FxoDEw=
//pragma protect end_data_block
//pragma protect digest_block
174GI8ewonoSuvu7wEfnAXKTzs0=
//pragma protect end_digest_block
//pragma protect end_protected

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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7/4tJt+pev6zIlPjxJo9eztMvw1yLS5NnTffLu86dXiKgnR8jf3l+6IrytHphZlz
7wxVOlHTF0h+edFrGAQB8OA6XbxibErTNVykv9Xth1YefCdlMaydVn0/ZS5eDbG7
4bWAYOl1zbikuqJ5jXUVKQ7jJ4FqfQjyJsRjXcUES50cwPUTzMXxjw==
//pragma protect end_key_block
//pragma protect digest_block
Vejc+9pgQUdWAlnLTO8lDtvm8GA=
//pragma protect end_digest_block
//pragma protect data_block
VTFSUEsG29D8s/86onY5R7C1Lu85wics9zq1M2RYQRz2ziK+YOi6XhKEEBGubS2w
V9/GpcP4e/943t0EHqglp3TGjmFpurnlQknuK/HHfj6GKNxjJUTwIEomKiLQJycl
r0tyDZC98WA4h4TJ/Eqg/aBf4dQAjeTHDS3D7azubAFUwQPnt0Q4myCl/H7T97RV
VgcoCRPgsNj9bgUUxfB5HP3oxKMy/zWu3+vGzBS3kLcLPjX4fsK44yRGA+Y8IdeW
yljuo/3ip8gUvLG2HfAnaAFAi2c4jAV58JYYtOMYHUqLNqlTICSIiAKPOdITcAt4
7ZKQ8E3X4mLRjVHV21iE9R5EfiR73RCn1dNoB7eSgXQbq8/gPARWwUQECeJ+u//S
YR2IUsf+6/W1wiyCT0GDGeK3XV2OClJEYF68VmQ7MUjwaSjWi4tqQ7iKhQWaMGAL
23pwXlpCgAyHJbjwRnWknfacQAHEVsuKa0wy8ozBdffx7hyZJVHxPSWTcACjaHI/
hqauFXES4DYbbiuUoSq4UIP6phXdILtRvm7zzmMvcGVFb4YTak3t23GeaosdIdUM
1PWde8PB7q5NeB4CGacv2p+6tzDpViVOLq0Af1A03dTzW3s/puRDNJvsrigs+kbs
xiASkruz8vl7poDemqhe6AzcH71CdtnHqgqRCJyLi7cbdTauPu1i4vm7xp1HL+Q9
CVnY85tEbo0j+SqCcm1FFVEndx+88dAn+LkZ2SQVDZofqZ9PimW9w2l/yidWCAX/
gvOKM9fL1JZzvynKjULNpApLQcRFY36+Vu0/eowIXqTXxpIl3EhbyZlV6Xupm87H
QNY9SBekQsn//T9instwRvVMXDrAHHPpved9x7FcTX6v9JF0eEKhd0PXEq5K/yBc
1mtfklyrzC+2a6lTNK0cpH48f8uNWZGCRiMzBOzsUs7g1MB0rTJ/r+PP0sXvTOxH
l11DAAofjj+ROQORsm9LTY/J2KBdy/ceufk0OosbtJ0Xckv0/AnAS0QdhWV8Ye2V
2DlKSuyQ46DpLVHY3dluFfaP8oX8Wha7HmYsmOpzRcynmrEPk7+vaAPStD4seJLo
zHsp3vdWaHtJU7zcNsc5Ka60qmzIscuiDH1csp7prhuQ6TT2CqfmHOY/A9POTtgk
4JyoNBUqaUDEDO9K0dYb27Q8sQHdU7aQegorqDNyiGpD4hxXdDlE0dCtqeILuUNo

//pragma protect end_data_block
//pragma protect digest_block
HDYyxsO7t9pU6fsKrJgPGVn5zsU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XfutmZ/D5bPWBckZw2JauZbJKJY1AcP4lnUZi2HHEHPmpbt7ACYv6RcY+7EiCw3R
uwItjlwIfLWjYWOHpGv52u7Yg/Uen7bKLBbqK+Ju3ZKJFUlgELRnNsGJDd/OUt6y
1xybGuSqJfl2oWPa2BsD1fyNTuwHeDk1kjaaLfh2TFAhAqv4+KDRZA==
//pragma protect end_key_block
//pragma protect digest_block
rGOCgDKOw0DhYDsrrB7mc3RGcz8=
//pragma protect end_digest_block
//pragma protect data_block
fxRwXGKipQaZ2z51fE87j6fUwuSxKExqz/OiDLkr/gLBvQ8OPZiT8YJhPpQ2CB5X
nW1FexmmMrQ48r+94BoSaZF9IyKkTHf2Bz5tyRCmy049TFJSczVj9LrBPTw9b5Ml
FWO7edtzPZ7qtPAsEl3pTgbMeyL9h8+XHO3XIU9+7gRfV2az4gRo1XgFQo3LGPzK
rtf9yDDQ5vKMpkNFHc3RwnIYr2O3AMnhu1QWjNf7tg7EwUlgNYAag1OXrg9/fmRb
i/jd84E+xeDvyQ1Tn9TSD4VdhPwR17n1zD6Xqdwa+n8zrc/5747k53ybZ7PNf2mj
7l55fJ8hgep4DKsGevvAZNRO5aNXXwpMCLkosyM7AXoIXL/AIlTDWFtq0xKpq3r/
LvUrrsXjR6Aja/sGSewf57j5fny/eSxbt9ovE54KAyV+HmHmwI6FF8NBYo5qG1zR
Kr2Yt4sg3H+OoVWfyuGpy1OcpBJZeZt8NVYWxwftNuQ8kZr1toLXYaEwMKLCbaNd
dNlgraZC9HG9NrH/fovDVkbT49zC5E2FCBIvYNHrjVNcfUo6ZRaNQTrHV0rZSX9A
d11BQGXF1r4avzkeir4bB6uX3UoQiBjJ+vNsI79+HiV7YG/aFqvXjiykZYl0gVaZ
ydRbjlqo/nJlCE4EKOTQUsZ2un29siLt9o3QoW28y/lchYQe8dAc6NdA6M8c8kot
fCx2MJ+4Y0Wm0x8cPt7UOwG/1tWiBVs82ej1kenM1skn5+x7UZCkpGN69dZdS2Ry
sfJoCnh0lcHPLLEay9cD7gVUJ6CZRJfwn/UjquvoIKCYT7m/oFq6ZE0P0dCNSahb
Nbrm7BnZZcA3Y7kqw5BffhMF65Gw14sfmMhgblE6q42lL7SIoGXIk3+JrndquH/y
0Al35YbeDDc+m2Z0D15zmwIvT6XHbSgRwa7QoMTP6c5FqGfidGTf98tdux3klikY
zX26hqTGAFFFTKXlYyPvnD42lXVCkee/H50qEtssPzkZNLPSYjdnfSnSOPpFhM41
q9FvyBGUAGDATEIw6hoCvZD5G7Llujl3JgggSToB5EFjZZ4OkErba0bV1E3z+MYy
UMa+IZtEVhGU6E5ow+p+LJVFJQJ7zwoNfMeve/GqxcZz3DoVOYyH78YUpPHZe/BP
o3NLCY//SnOrS9HCTEQSsbqfKkHAkPtywpxX+4drJpdSfo4M6UJTsxg15qyAarYD
d8wP8v7Gl+jZIWhKiWhO78DwTDi5Lk7iv4BwNOz3aokA+2Tt8Js3JmUfIi6gasnc
j4UcoxIlYHpspenF4P/OijgJ8SV2d+7gFrx4lI5DKK+XenLTcencGw5zxYXRPAN3
kRWNJ7S4PXsifzmZMDjYng==
//pragma protect end_data_block
//pragma protect digest_block
PK54KHMHrjbS4CQ+WHYXzPMtDi8=
//pragma protect end_digest_block
//pragma protect end_protected
// ----------------------------------------------------------------------------
function void svt_apb_master_transaction::post_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ucw9jFeMCfTdq7JMtqI9jBdhOLy9FofXnLoWKLttRfJpUTvzkuyyMDwKjCm7g2ZT
rKr9Li3kGquwrPV6HWqAvyC+LtLsuXOmTbz7W78rsWcqMnez0roSL5fx+AcEoTOW
TsnaSgrYTgDtC6lNnUh+LDH8wsjzSpbZjwg7FyVxRElZYBQGZaAJxA==
//pragma protect end_key_block
//pragma protect digest_block
oxhmku7/K4wpEIrnoYj/lZjczZY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Tg7QTjA9qwZd2nThfU0E8pHrGFw=
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
12lmkxGuoQRxVPZosISjq9Ab6ymzJPJ6ai8pIsuIMabhTYFGUCELkU5kjhjAlK8h
BB7HR3cEDwwTk1j6rXo4qK6qoso13eoRrjs3MDWbCHXrl3GwR7Hf8PZ2Qq5mPbiN
779vElyndGRlNiEvFPcqBT0Y0GFzXED0rd/ZFzIYIT7Cfvjf2dGzuQ==
//pragma protect end_key_block
//pragma protect digest_block
Aw3OOHZmaq3qON5BNZk2KaggywA=
//pragma protect end_digest_block
//pragma protect data_block
+pnbx8hjEnrlvVOPLPyJ0WxpPVCQ/DGPFQxQCcs6mT5+vwjMgXG+pZyNUwgUQuvg
uOnYgyNQd2lY9KHkuPDwOznLcLLALx9KuKGq2q1Cp+zXMWf8l+dw67aKJRxl0s/a
NpbLFBK9i41wyW7QUiNhiMrc7lkE5YDNtMKrZU4o7JncZkuy2laTCx8iG3uSeE0I
X+luZobLCVGd6WxXGFTNCPoowLKTbgVTnJeCeOIR416Knr6Z9EgRpVZQ6+DYUcId
878Xy0nsW1kWwx0Q4LIymtTWRZAovVYAyaZI76FFPH4egwg6xoXUigP8iTp57wdq
6vHUVrr/oCzLRd4vGvA9p4yxOFhgZQ1U45+CHnJI1AHQ7Qk0aYuRu0CyUvNp+eTp
RuFTEaX1keg5qIAqIVfh82Ws5F4PN0B7Mw0qCbvicDb+gkkV66yjnEBUyQp81dKL
JwDbhsYLLbfq/sXJKxO05TyGOpgjgIXzQzSq0lKqtaQoJxqeX6adPrBAbMQOjgMA
796I5PxqkeS7Y/QMHe+uXUNEvoodAMsUO8UKruXoiHd9D2NE4QlbmkeSQB4nvq9h
053kfa8qWyTHIOybZtVVvade2FMQnAqc0QCGAzfSTK5p1zBXxT279f/2ZNhtUxiu
IN6/X/k8oh4EV6bNq/P30v6NMTRDPY+hGXl5Lvi3Vi5o9a6TqC/+IyF27YAnnXE3
EjIauhmSWv9lruzbGrPFuNI1d7UP8p+WVK0Bb4SNeTb2C7ASM3psKZtgcpv6vIi4
yGv/9hdB5HyY8UgSTZN5xf8uOrsO6AAmnljq+rPyvYcoW5n76IwPi7gN99zv7vVn
IMm5xlDigzjzD0MDGbOPOZcF8epX8Nem4AAaU6vQYsBNpjQWARGtIz7+6AyWQ3Dg
PYUakFa0M4+vfBOoG2arnS4Y4tbIFL8fYzmzjIANiY8wy2Bbnzw1cTOLVxxqOZMI
0i9Ck8xX2xAoNdB00jrjk6qqx7VDj8aVsa685Du6WFPAmuF97N7hvjdPy0Vf/PF6
0W+DKORYHWdomkfkyXc2gYbgmvD1Rd/XwZ46cLVefM3yAhd9GLIJkOX1uRVoj1G+
GHkBwjuiygf6t+sd3cf/XEaIJKSYWkMMiFkyf8GwploOcswpR+MV3YwOHoJWQJmh
20hhFOBK+B2tZ2yhs8pXRBPahxu16thaORLK3x3yVARr1WhJTM6YZMwXC+wLExKF
rhaHumE+a2DA5E/Y9ZNuzg/YXR59nXvFmACQm9p1XBjf7DGTX6Wpe13Xs238qy2g

//pragma protect end_data_block
//pragma protect digest_block
nx4il8xDEqaiA/AO/SjXMpZ4lns=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bW2VFYX9zJ8IEf/y+7yNEcMejCRibEuPXq80A3JPkI4AMUrm6Vg9JGp2bpK8lQOS
sUbAyJ8Iy6gIZPWJ9M79cqmn/fD5TcD7AgT/SfOeFANGtlQNt4ljuRgu1Vh/CE19
WjyEUVTI9Qb7TFhlH8DAYXHXKhQxceKeGpqqpL03omOv+VMMP7NvwA==
//pragma protect end_key_block
//pragma protect digest_block
K1pL3v0CrC3WoqnNNU3Ns8w/964=
//pragma protect end_digest_block
//pragma protect data_block
1aBU3vtp6LFbxodshBMiVX4R+grpMI5kqW0SViKwFaEKikM+AiwfYbSWsyr0RnaZ
qSJnMQEwWl3RPaXATAZcJHm7GTI7zV9ncrDwoyeNVV3u+V4U011ClMkk4fLfB6Ss
itfOK7A8q01LmJdJRtML0ptfAh8ZhjaaSj4aCkQmRMbZ0B8vyUNDoNaMiCdFs2gB
XDsukVE/JevdgPZyrpXPYbS9E02WYmVb6PiHhK5/5DkMUwsGqYxqjWEuYkBnbLlt
cz6Wo6WaF2eIls0Py5IhBKDhcK2PdtLOtyDZWCTpZIU5+0PzfFsvxb0xT/KVtd5h
t5R2v3qAN7NgIm7CjgDnIwAcgSWBOG98CYKCtLlJXcv1Za4D6XV0nSuvGkxBKkQ3
n0x/Dg7oamidAu4GxqQLSetdkXx01vJ8y1xE0mQ3HDPjLOIHy59hHTbRwcz9qcdN
v7nUbSiambhAuqIxlb3aTE7rzIU9Hinnkr+W78WWHy7UITbqxc3zxJSpX2OAvBMt
nZk/Z/XS2+4RwlbmUhvg/vF55ABvKs5rTlVR3Qp6Q5H5eX4xrK6z9qTzkb99V1xA
3KO2BD1z4zRW5zy+sBRT5g==
//pragma protect end_data_block
//pragma protect digest_block
f89n63KQ/FKBp5avr2I97UiOBN4=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5U/oF0ICIvm6Hb3q+1p7fSka1uvXthKv5jYycVmF0Om+Dr1CXF/7zBMwUwLz2o9w
lPaqnhOHM3IZhsKfAdn+s8QrtYiKGW5Iu5kYuSN9sQRAvtU7bD3USrlXtPhruJsB
p4difYhZDegDvcEw4UpAobsFEcbCgnpT1wjceTj2WOtUk9YaeuBJuQ==
//pragma protect end_key_block
//pragma protect digest_block
TG2aHTyZBBa1TW6ZB1o3yOKbriU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
fIaMKAhgG3rrjfz/HUprCSGqt7o=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RGK7FJS4ONZWq57W/KzMyyoj00IdpYLhqmVhvYLRJqP7hJsDv5x7KyYtAP03fbFQ
NY3JjC+0CJWpS/f8dWuj89GSo4QQXRjx2EVOjQsZ0fNllUKc0Px2lelHIisgP8bs
43+6W/pTgr/XKfz7c/FsthuZAquYUx1dP0+nZphok3kqxX1UIWTvJA==
//pragma protect end_key_block
//pragma protect digest_block
mrgX9S1c51fjIAYipF5F35NxJPk=
//pragma protect end_digest_block
//pragma protect data_block
f2V+71RSp5Tsxn2BLPLKjPGplaIqAdUKRbmLC9bwHdhzzSdJvOxeauJJnfEquvo4
98HhJn3PynNi67yCQa6nGYttGz0GGxcBHCROe9HDgL+7iaAcbnRr9jqnR9b7BWY1
EOLSwrwCrAhk6Uagi4cg+YQvqHSDwIq2DBBfd3OrOFuFwvxjmLVju7TusyxxSRgS
ugCTf9N86O5KcI1N1cURjJFBtYn+I3SZkt8mMCJX9pb2yeOqFKqGReYWm2tymIlr
whaJQ/z5GLqahe0xVQk0RgY300McgLlScv8DU+mR4JFiCEtB1JAXimReDNSsTcM0
c7AdpCHhZOY9B0bF1htG+0q6uFfE5iG8jzIdYWCWxmSL173fXfVOcvpNOURFyyPX
WPRQBEGfR0400GBVFo8Q8w==
//pragma protect end_data_block
//pragma protect digest_block
G+mvsuzGdzbFLDubjEotfQ35h/0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pVpVg2cw/HdNJMTUFVHLIUzhsl4TpT3KG2YNZ/vvxmjmgNClY+nRvyxQ3v8G80o9
uE3g2PHeC9IrKDtirLHje3l08M+lkFyB04y3p7BrPACcJmcMpR9IDnu9fwIz/Jsx
3eBYpN5cyxDls4ip77pkjvcKp4voKt+aJQ59vXsTQg8MR+Ucz1mDUw==
//pragma protect end_key_block
//pragma protect digest_block
suAklpeSoKVDKy2ABOrx/ZF++aw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
TTj/KC7AOKjyGoWLZkoiG9Spu6Q=
//pragma protect end_digest_block
//pragma protect end_protected
  
function void svt_apb_master_transaction::pre_randomize ();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZLbWmjCGDrxAydQ7J4Q9/I0z2nzp+ajxfOyfx1wGMn3vGcpzbqXAxoX9mvatcc02
ltkyCkTmlHAzBeXuzoFCqu/KjBQ913nUPG2/Nn8WVo4Kswsr3iAkxsfb8/Bk9zVd
6maACHRIoVNzLKazzo+a9hKCv4zs1Ph9IvYulyth1v1KAfhsC4U7LQ==
//pragma protect end_key_block
//pragma protect digest_block
HsDcN9KWReGsVnBQ2hAYK7dF//4=
//pragma protect end_digest_block
//pragma protect data_block
a4APzm7Y7qV4Cs3Wv+OgiwZGq9l4CLEmezdVAwK+fjBy7EGwnVImEc1PvVfKr9rA
3ghNl0BF302rbFCqR/MgWl/HhcxDpxUspT/c6kTk8UkgURHq2rTB+PhNZFdBwJGG
uv9xysHVXmxHZoCeMbzGQo2sDVlf7nIsNv14MBUFaKJV24JjalBzHo16cQLxLLOC
zUYTsLlbOOPO7c4Mlr9yi2NNia3rxwL+Fv7JIIW7qlcoDPCzygg/0syFreJS8OV2
i19stirLLvLSU64RnzBmuG5agmOumL9ibD7BNSrawZ22owp1NXDE2DLl4xw77RHv
85i/yjNsMuFcR/YUgnN6/0XISesBUU9rP922BYOPJ08omf2NHLeSZcYABXzhrF3t
E26gEBXjFrf9HGaCiOaLY3zT38KiVl42AhX1lt1LLA9A2R66lDCF9vVI00r+NQLO
Zl4KP4BU9F1BB/40gUpPyzT2GKZ3fmGQyAbJCzbfFDGN0BfvkhTdKgyiAX0ibVNB
WWTHNCJGXyoK5BumfQxhC53SRBGTd0UACZeYktPdlPBetK/Fotez4yRjb2GTBBvG
GMG/ghvHv7jVMIf7D0QkM3W+lKz6PwSseFqkN7WQksd6IUDz5ghKfQlhRhvPlZGX
doEkczsgi6nKdpAmscn7JOINil947emuNyxy1YRJX5Klmqnh5HaGyA8Qnem40TWc
A6D1mLoUzmX54s48vnMNyRWdH+WcizHIyOmjHaKaUug=
//pragma protect end_data_block
//pragma protect digest_block
Dm4Irc8dzHS+maF4HnVrjDRMKIE=
//pragma protect end_digest_block
//pragma protect end_protected
  
endfunction: pre_randomize
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w6o73H1jrRTOHSl6qCh6TKhaeSboHUY2fSKIH9lWbTpZTBodqN0PIWgHzyxTv4OD
VizUGEVyH12zL988N6q+wcAR89RawvdP7AciC7gJGyRbdFriQs7ly6DosuIppHtM
kMe4zIsKI2v638rirGLhTofQLevlBXpNK5ykZYTpFH6qckRTg2AK8Q==
//pragma protect end_key_block
//pragma protect digest_block
l5qgM46Pf28c73f1mas+rI/MTQ4=
//pragma protect end_digest_block
//pragma protect data_block
y6/qxvfngaA9G3YqTt1z1yLVNwU+TVzAv7BCwcOK8ztyIOtDSS1i9IyLvyTwlWS/
NOo9xxdKdlL5rZg8MAY2ZSBSO9d8/EnmTjwWM4ekG8n4OQO+YfTa+5mZrv2C6cwW
IjOa8MtPW9smdub0sspDea6uqZfFydeD3d2F2heLG0xxlaBzk9aQ4wQnjoVHwgvR
KWY8nY3Zjrrh9J0h8SHO2Ue57iLS2yHBcyeg4ZrU4BglYYAKU85tVjmR9yOwRboa
TZ06QMMn5KKtFHHNg9XumSxslJsAxTzNo+F9/OPYNvJXbgd5xIttYZ2gBtWdYzOB
B7JKxXFUZzK9AqL4YU1eUAt+5BUNGPOHRSVZPocdbzydACcVIrMKkwJEVmpQJ0Oe
6t2ZUBjFtvxd6vf1OBGV6ExzVd8yFBTff6aWPmH7jnbua90Y1nIPm4ADlz/zktnK
0Olfor+mnGpSpJgoFPguvbOYKUTUR49r040DMNh10zzhjpm7UGp84F44TM7731XS
JJQGBCOQXi2b5CZ4/FKuqvHiKXg8iHK4L4LSboGGEwBrmcJDV+UgaXBevklGGln0
QfEO2cY6Cr874tYLxS75552r/6DtLImyzqQblt/XcwtkXkCzSCxuD32MUI8iLVDs
IKQ3Aoj0juHdKB+1QdvEER6cbvKwSrJjLyGCEQV6V+n2kOeARGKy7Ly16ZJf75bG
Wh+5W5m5Msj00WP4mO+4Du350Lc6qBY6oMCaLUp1X3+KS0T3fLKE/o4XZMsYlw/r
eoWTt6awBx6xj1S3GdYAbxxeZik1wjbLLwRr6+9yMlGsXysRm1ZhKxeIJ/wM2QF3
nfEkd6u0N6ZNsvGaZzyBXCKKusOYEeq4DPMviuQjVappbZcdFoTPcONHTr3IX9uo
N33i+CEMuPgYZyo2RxrtPSHVrA9coOGDjxRQuMqHUjxHLvpOQKa+nuVtDW16+Hq9
OQod8YtawsOEmBX3f7Ppn1JF8NXMjr3iccSv3EsxYOzfdiXHawAE8XF2yp2/tue9
IDFElk5eW2jrNciuBrU6FX34YHlX4rlhMIjc7N/3yIDLTBwxtOOj2u2RRPg9nyd/
SpvwSOh8fTgvqVCe//b0CYZdG/fa/VJRXdE/CzYK+qjYbqtL2HM+e1BjuhQN76aU
QAkR7ZPN2lMG7wM7R6ivrRXewzN5W9tVLxVd6iChWAC4ON13Xb0zYrRJ5j8WpWJW
nBDKlY1fmqnJstK9jjoAowdxGiA75LoMgvkD5AlpoZpFABkGsjtRCONdIiX2XCmp
WI678gUgjfwH/0OjJKNYQDVKFHaNTIBoLxgyejisf0c=
//pragma protect end_data_block
//pragma protect digest_block
ca2eBJYrS+HWoNfMpcomeabuZiQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_MASTER_TRANSACTION_SV
