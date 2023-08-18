//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_rn_transaction;
 /** 
  * AMBA CHI RN Transaction Exception
 */
// =============================================================================

class svt_chi_rn_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_rn_transaction xact = null;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the exception settings are supported
   * by the chi components.
   */
  constraint valid_ranges {
  // vb_preserve TMPL_TAG1
  // Add user constraints here
  // vb_preserve end
  }

  /**
   * For exceptions the reasonable constraints are limited to distributions
   * designed to improve the value of the exceptions generated over the course
   * of a simulation.
   *
   * Reasonable constraints may be disabled by the testbench. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG2
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_transaction_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param name Instance name of the exception.
   */
  extern function new(string name = "svt_chi_rn_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_rn_transaction_exception)



  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_transaction_exception.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE compare.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision(svt_exception test_exception);

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_transaction_exception)
  `vmm_class_factory(svt_chi_rn_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pyPVv+hEEBX5eDCfaEBhYvMLiuAbB2ESgkhiTjetJXSrTkODKfD5w3wIa/4GD8vx
/e5ZOcfxTqTpJHy9iISx/4TyQwPr12T9Yya2ylyx1nWPVqFMsG3WfTq10hha13CB
RwJH9BISHQLhJ3CdPo8Nc7S2sH613VibFpRe0mMfyWA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
x9H/N4z8TnlOqOf97h/076FPb+VKHL3fjngx4QKtc2g/wKz63MyQyGVoxql0H+Pg
dB/1rWss5z38o26T8f2I9gL1naGGvkudFP8ocG0As5xfCCaEjqZQ0UPneLhHDkiz
6CBAm2gtbNbSk3ZdeJuEHMeHaOFxTc+iMztXjXncJQuexxZf7WdzsX6Liy245oV0
yTuAgIMPWDNIXN3qSHluDIkMiQGJE/hy1vwRIu2O8LkT3qzUFgJbkJBRG6Q5ULyc
Mqpr+sb036b0BZ6xtHbnRTnCCw/r9rK/zTD4Ff9BANCU6wfiN4UAs4PMCGF6uwPW
GDscmOXE3qpJgd6ZdetaAlWpAbUPLcSZIzFpE7WzgMQU5JmraEfi8uU+Jb95z51C
fUShs40rxAxz8YYm/CR2V+fMHIiYR5fP2HWJDmr2CrVmOEbTenlZd5IcSKfgZRkQ
/ZfAdL6SzPpSZ3l6Z+H+Xn7KpvKubJuhWzvVSkwqk+Bxk5CaBIuf/bfGssOEwBtk
u92Kth2Rx2nNyKePWwuNZ3NYlpG8+rpaepSRrq11am0taMiTBYPMflbISZQ+docY
jGKpMJ3y1orCg0sRBKE89EI+C6CSOnRwL9cjU5rv14angxu0vgZiRgbSFxdmyJ0x
jd1SZ9FdNYyOLqxRrjg20ORNo6ppz0XZ4GpULgbTys3iuQY/ZNsHK1L9FQvLjoUb
khcRDgGjN9IDshzu9bHr0tCYG3QXHkLD29/2lFYq1bpHMkJXQrx0R67qcmHlVafv
2DEyjhxV3Af5VFX9qMbHZR/gYs6bke4Y1VUY673lZk88Zw2wbkFuB8EO9XaPmWBY
gt7qaXJqIaE+lNolWfKddg==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R0SlK6jKq2L5nq2dwtVm22jQ9bAt9tE4HigNQisEAcyfqBd9pA+1GEQHkukG+4W5
Na1MgMpvgg09HoMCuuDMGY/+J9QL9lvjyrSipCnf+FHw5zdgl1fuSZSB5ongX+ng
akVQI9+iOhkdlJY2QvH6YoHCnYXoJIZmeorxzqpDISY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1018      )
uJ1F62CCsO9BFKPNxH+gR289p16KWsSgQSbJMjDXWxs44dVH950O2O4jvI4UPsMi
1lWs1n3CYnAaoxXC8FeKeOUp6iaFkdy7abCU5wYfk5nNXbu7JdoapAYmMQ4OXGZ1
0qU+/7QW6GLsq/Dso53MHnwDrokGggaMTY/5fZUN5/KfDzPX0EG+EPS+prSAXKZI
wLHbEa6wxLMIo1NqtuZN9dKoGZWHR9b5aDEBRH1CM1P6ROX2dWhTQzM9LuZ0oR7a
ISyzz8dPxnNkHyXs5r+onq0qneiL/jpA+sOcOf4z1V/2bB1ltnAI6GvedX6ulP8j
WPKFA6lhAmg8rdRGbh/2nd/hL8gYiAATEV6NtK3P6Tig8LiJSj7g1o388njPBy9b
h0USX+xixalGb2s75hcKo5r5Nln6EEJ71AUYBPlIWSORNDLauNIiz/k6j+lgKWtj
KVEzp1bDhgEEVc4HwKZw4sz+7K3u+EuYDn1s5O17m+G0P2cVah8kmSdOyNwda8Bv
Zjt6ZvZiojpXVaAZLZS2Fg==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SZ6DBN874NNRX/t2G1h/1b+TrW9ziDOXuzz/5h4jnCPv2V6heiwCwu+3BdnvmLSp
urIZR0JOkHZyW/N0jkfAX+vEduXKss3qwYyCal0g66uF4I86UCtn+gDxiTJDBLgW
Y2bAPBJN58gniiydWOUy/GhhMGducJHDnsJ6Msni58A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2953      )
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
h5lSqBUe7fxHBC5ljhTYmw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fan0WVPbhrB81QWrjwi3lf9zVgihkeyZyApMzr1vk4xkk9cktfzV0T0Mc8lrs/hE
172v3a0tEcaNp/ov0FyJHPo8VcMVigHAUtPzfGVdw/vLlhaRX9rHUEJy2O9jtIKy
kLfPSsYH6v04CPZqiUTQDS27TIqHRoxHv0I4nAX42sw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13027     )
+mHvCRvrJSUs89u9CzBAz0rYDRCMDjSLmxiATH2INUL6IB/6LV/nKSL8sW/MXG3f
mEhUkPfvNAJYik9Fyse4sxz8tbFWJXnDbQdeYwhmTSc01+egqDNE8u9yoYQMisPp
epMLqiw2m0Ajizq8U5Bq6UqzmvxaCQ3nKzkYnFHJJzeeLH20gbkTmNCiy1KCsVgs
N3yezyHTh6bvc4cxXs25W+HrbhReGE5eajZydCwI8CSbIq1WTRozL6C0BEUV2MN5
hLy0psQ4RG2s8JwJpXnR/2+tvTMIhutjNeR0DkX4bQ6SYKEQvQj2RXiXGgqvHf+e
vE4D0fZofJ3K1nBwWOQidbFsv9zgCa243gfV1uPxO6K5YgQVzK29/tC7YMCOCGq/
xB+0ghjRCQ1w34ECKZXA6bJb/H73UuHp/frvOJvwhr/WGJJWXwhS6G53BuerfOzn
QnnTwhobIUhFR4ptrW7nDPTIURcQmq7n8g0DY3/l/7opf8WzdLADckGusXHIDkVQ
iioweeWQTwo12rO8dXur4ghzZHpInMCcDCDvtrMr0f11svEqtzvNUh9utc/0ozSe
oHt6+y34VXdy6fyohhzC90YRnzMdPcjXlhbSJkkSNWscLqkkVJJQtMERtlKM9bra
dQL4+MnEJkF5r6fOhq0xKguBx5rpCQq4IQqLKK942gWD/ayTb7nsmwpyMzVi1owH
A+FzijB1byVCisvrINTEODZk2GOuDfkji0SN3RULbbTSWfvDJYn60T752ZWFKSf2
Zpz6sBr9llyYLUoB9EQDfQoM1z9STHR5XFlo+apRSHG35DUjyJ45D1gAMG96QqJU
sndUozNU0zVeTIOe1js00zEDMl5yl0h2WIzoljyBU4Ugc9XEXTlsVekby+MAoNuy
3XcR9xEd4R5b0JtPJ13qT1V5x7CLBTWrYifVPgWbqYCAknGqsP2Tq4Dra705dbeQ
R0ijH5vb2tmCC8IWSuwOz7S+I+EHCadyQCyONxX8d0moIWjVv3vcFrujo9aC5Y2+
IaAyc8mngEBHR+rty8Mb3v5W9k8VN146IyfsOdrGXXZkikN4fgm7Hz+Lt41BjjP5
IcJwmRsDOK3JYRZrxNHhjKsbt1xMiHIJ9TiqbSS+jxIWAIcMF08HLjpbQJcMp7v9
FSPNKfcQfa903gQCQ9AvqlTGiRHAwwvfaLdpFzoEdDA/SCVEIserFj+xoqSrlduf
0IK1hoN45A26upq0ZZDuzIDdsK3Sl7kMOwOA6rshFLT+42F03IbJ8KOoppsICCn3
PAMkVWSWsK04aTNGbmOJZlHKv3MjeFpiz+vhCcw0tF9P8ktCdj3ZM9dtOCBpAdK9
8vKisfAbCICtcZsj0OWD4exP3S7qe56nvv6+JELiyDXtwlQBoGT/6bOdPLoDEnTZ
0uuKR3g0PNclQEBmTWFenTkaGlpo4JP5MO4bkNr01m5I9qEiLtU41LMFjuPyVcwS
gxTZ0kpkmjzom+eWS7kU/Uu8Z0I0SP1O+6qb67HnaQ5WVedi0r/bRaT83S+ZwqAR
T1qkao5UiRYxTR8rtW0CWRHKprrNSE1S+dkm0isPfMgR1yEpzf7QCSuXOQEohJqh
3SzTH+DrTgUH++ErqKA+bOCXZ/FMUylecVFv2mo+JI7PC//zbeAIn/JXZ6i3YHiV
2lYuVdcHSj7wWHBOdk9Hv2MroXbixbgPa00qEmmOhwJfl+Ftq2/tC0i2QT4L+Ugr
OVBrqv8EmwQISOzbA0EtWL6kuqs3UOQx30AVtYOxHtIxwhhKWUqgMjZEQT8xLsyk
8oVP6WHNEk8XWEyX8iFOEKBjVKF7XUuuMfpNE+drurVfxuIg+D20If2t24rl126X
WAKjQDvLF12p/nPh0pmDmu78i+hsqyaudv5IpPDA+bwK0OEfcdEihKBOnJo6fwHp
4oz9h1w9utE1N7VqugXSsc3NF1WPfSQoXFojDOKffmTKXBGnvY7mirtETR4BdajK
DtBd47dtkn6rsLrauuZmUhibPWz/xT+ef8mLPoX4J0qRf2Nk2AgZxRkosGiFZFEh
yW7tn86ggX1At79FlM5xdjhSRZUVynvxvUq/ruVsVltkhAhZQaLCTeaJeJnZoU3W
IuHHcpT6jQ6LLPoNUmuaabBVmDWcXX8OqTKe0FuEhZd/1KdpB8YelkmVizCHQ38U
iCcYZTYByLnCedT6v2ApK5uJNsK//JI573i+en3sJJ8yH2FWzmRnm8zFlypKRBMG
ed4LYbcsqKNE9ypK4B2WAz1by0ncSV24KwP6BeohcrlEJu2DvfFo4nFmBPwR2+x2
UMT4pBETAL1d2PHhM54eur3v8VW4YuFw4FxTYD6jYgtMts+JGvMSJMD+CgKM/bNS
IZ1GU+c3NO14fqeLLZ4Vya8X5CqrlAcjtq6ZbkzA3qRTmHzxT0XHkhwDM4EfTjsI
Q1gJgVKgzXsZEfiR0sYYzPgJ/+nyVKbMca3SSNCWT9ULNwEHA2UHUQKeU9q+1E5A
4I/dEE2Ie5utvnQMeoRgCmzyvVJ38JmYYBppIM0N5I3GhGHbH2D04eZy9hv42AoJ
3UfW4inNcAj8wqMnAXmwOgmA2JZVtS0IsJyvC+xriiwm/9S+WloA+MjWQuz5GDMl
PF/W8hbq8OpZItcJxDysCszZMihxCOeIyOLVas941to3woTcqHZ46vGsMPlf0HK9
/qs30ojcF/aEIAj6Xh5KYqVyhjSs/eNCOBP6g/JWkMsZrzX7RVQk4gKK4Yp+k3+8
IYk9TJIYJHVlyUaShSqfGc8e1WRwmsUJS1IcZOAq7rCSjBa9ayfiXkWlYn55QkU7
9F6iBLcwpV5ToPVZqBOQomDgmTLQZBtMy/4kGHnhpL5Z/oXqF6GyOai6UTgZn8t2
wn9guRrnaZ/IvKpi1r945kwyy7Iw9LRoNedW8iXEbYH5cWrx0xCwRM3stotKFhBA
enzwoeDh3MSD4aEJaKXlyRmgClg1ZdxqTaA1oik+nUQGD+XyEhLIwk0ubQPIhFpU
D8NCwuT+KAwimPTsu3e/dlW4hbwAfFL1DybxViW8n7q6n4pB8TXkJhtdncTZTr+B
KjsG28KpDfWUnMf0zq5AKtp3GVlTQQOkkr2+L4hATDXZAbwIyqQ101Uslv5pJTpj
ivcNcNNB55s5mI/N7Tx9SNyYv9ABWKRXgaT8NVVbW2bMollnIE5Zi4UhAGEc07zi
T+4VVvhv+oUkMI1ZD4r9kknFX2baeXOYx6L9XXs/Y26wadAEDHlT4Mzy4Ys0vayY
LUaPmU3p2/KFzlM+fLPOFlP8428TXwDyzCW9dzFPAvaLKl5aiIDz0D865NHBXjnH
FlV4smPSfYDa1qFwpw61+iHJll9EJEcdE0pAo9oJwVg4zHXIPgmFiSi8uSwHfBIc
YmQctaQnu4NmEx8pfTmhVFltMcDS6UCBlQoQJykfNmDtL1pgrxwb0eqRlbgYJHM/
l/Rnq4EhsXF8tSqps3f4+RQeJHuHhgDzzjT/GxueItW3YZAi+Y0NnCupX4cmEAdV
1J3ziygkNPj5GMKOZLxLCsxc8NoSUeoSkvcrJqJ53JPoWr1dQB0zSsnDvOKpYxkQ
OjnzL8fKWaCoDE8bH8WswMYr44uH5saS8oGgSgmvvUVojxbULgEWO5cB7J1D90pN
XH2vlBkF3JNX0llZcO0LNR7GWL4hC5jIY60zPRa0mV2QfPCWn3gEjfsv7L0l/tzO
GQcWcoXsc8o9jBENinqqWzkwtHDyu5IcVjOx2mfO78TJvTvQcFkPwsbM79d9qKgt
FuRIc6KDvwm6MIhtLzB0gJWFfavBaEnqwiIG2a8U/Xlmvq4yPNwO4Byol+MWIFos
I7hZKjl1dmdN563POAsGogmESYPVoukDukaJxLJVhyAw4p8qz1PZKdzs9DnyY1Ew
/qGq9wJpzsqyiWu4CGNOZE4NTV3Y/gG/vfQG0S6neDNmubMg14okZ7RTBnM0a/n4
gho4UzJss0JdzZgW/IPhKKmWgi/cv+P6Uz8kQ2BYcJZY23TGbUsIZS0WLcbY/opt
PqymkSpR+vbH9lvETWoR05d55uFsRDEbMG4I8LJQjOg6TwFQBwx2NePAkvybALbv
de9PBfupYuKJR/bQD/sa0d/yjM4SvimQAMl3s2Qdc2U5oSRx/YWG8r2rCnw5IuWQ
r4Js3L9BudNmJpK6Lh8lyfkv5jy4zyYKRsQfF6nxqujgLst884Z2fecsktzknZf5
tcr+t0WLbAKlmyZCykLj7utcwmZNi6Msb/mF325CC+g9KtDXsYBYjzqOSxlQdVtC
yni9Q8KUDuQ4qzz+zQRJQ/ajbtFJt4u3/iM86wjEWOjqccWfs/wKK1ZvvvqzyZwh
nE19vlRymjeqiLyqx1TyWfEA1QtfDaPdmTcyNcMfYn6B3lao3xK02lLDDRyRe3kW
H9ZuQhxLiABr1C7vos0r8S7lk7Pga5jI2SjUo7gphrj9fbU3Q1uKyltAx8ZtxC04
Wrp6U8cU7I2g/ULkV+Ip8Y6iZiXMDH54esl1Vt0MPS5gkJ1+2ad7ezD//WPMZbuk
6iz/7prNbIkDZ5OchHsov8qf9urbQt9sU1KuW5m/K+102a4USzMEtnXlEVFecJEX
EIo2QXkYc5gStacuGSwaEC4tAZ67JWEzh48pmL7TecpDDBEg3B3EJ4QKLm0EMZ7x
UY7/6IBmO5jGGRtpgpSTRNLKq47ojJr5EV20TlehF0LIq5EK7fpyuTPWsi1piQhx
tai1ryrlidHGLPrOUH5Y4chVWlOPGib2fBP3DjXzqBB9DYuraJNfeC0MmCxy5KMS
DAwm6+Kf0WccXICURyScSktgU02Go6tWve+qyDAoEVgXegiRoGpvZD4sNKy/ELc6
T9Vq3fVO1KHmPxA3rrppuOJB0mJQmfKunUjZM8GHP15ngMTcIT4oyv3oq3f7kURQ
++80EgNAYzUkQvDu5kfgoQpVQZWpUN5ytzEfz2mUMCtWmCsdFeYrA2Rk/C8GQwvy
gvRBfEKCGzJJYc+vek/JR0Icp9pzRJ/x9X4+V5zj9KpOOD2TDT4ePeJZatmIN6He
P0BN6IbKInvOiMp7L6dFh+p1Udx4pOx0cvvTbJ04GD3w9qS9JDWswyz647d8XkRu
DvFyapjihXpgVnPYqq8xOsVOlB4FP1aid+iS9o7FQUW4XbfTAAAQ/oQljH9Y1cdR
nWDLiM1HHQfu+i+76nHAAlu/7BdJo98/FnF00x+10VFROv4rGS2+APC1kGkyKswc
Xo+M1ER8PFtun43NnQ2AyYz1dWNB28l+6diN/66CjGmdiUmG/BfJfTK9hlEtK8D5
Uqw4ZzLGAuteMje0ObTdWoqUsPuLl/IG7cHkBkyCO0uwPBrtUWuDuJHRlZfQOw6o
jbybaEZBqGxvKob0/hKbGxmFfxpxlCvA5DFAShsgZYoyooQJxNPvVN+5L/7+8ukH
LWFbA7MgB9VLa2bDotSYToLzvya1C39zfWEGJDQmE/X1EeLq2+6etWjYpfuRiOV5
7MB9kwiJN/4TUYABeKJ381j0xaRIagqU7tNfm942P6IFYzfRAFrIEg9KWpFHjvRZ
AjUFCLIgDd4jHcg1ryYfzyP7jAmjih7r+msXJcGd5VuWgxJyvjxHYy/YCc3t0bjd
f48Cd8vWbfM2rt9hEYEFG8lEBKHvPHIjX82gSGuDoly6trPnsFSu1gdSTYJ7s1qB
oY4mebulAB0DvhXG2isiC/wE+p6el2UXb79lM9BHVU2KbV5VUdgEjv6zxVlS7q7h
GZuJTJanKoItop5LLqwWhAwXBRMazaIMm7z61Mly+7ZJdzbnj6gMKOmcdEXFzfXE
mHNMyIcE3xyK/9pVgIoF2iSh1cfTcoGCgCpLn9I0vSs/KnuXxhcrOBZHa8BlU89z
hKThEPOLuYgw9IQMSoDjuKKUYZ4G6XqsZ2QlzUfxEnXNXZjpeQUgLxr2uwVvsmdQ
C9E8DrjSlbEkE4+/bAAiOkLU60kOfrNaAfquWu2BHvM5JW/8OjNsXuxltahtSuwJ
iun6foyVtX2ZI7DE3OrMQ8IQRDMCBcG43HMHkYadko97zE76IRRi5/9ZywC/IZj4
8rBdl28H73DxWYzMpBlOOPRV5vKGWEDx7ekcGF/DMeFqtwM6+EdgDw3PH474PbZt
A071g8hOHQQdTUMO4fP9Lsjb+8HhHuh5LSfIIGF8QalxFjXrIrp9Tqlf62gcYYhr
t2tpI4V5I2aq2cyZyrN+VibZMTjwo1KAMThN2bawJRINENeny0Ir8lBejlkfDlfV
Fuz80wNJuc6wbbWC2wB0dlduXNZDTmRM/5gB9/D0G1bdFqpJ1l57aQCq7PtP++jQ
Nfqzw0NCi+mL8yIky1vT7xZLKaK11b/qK3Ld2AQNZi3vvMqnXA49aksZocAm80oe
ljz0hxzOXhvbRLmTD2c4BwF5Td+3z+G08rJEiqvJPM0eTmgHPhsW6bWO36Sb6oId
rdsPYo6NcQsLD3BC9UlVyGf8L99HoUBs9jq/oXFQrVn8t+y5AF4EotDDSXGeKQFy
baS6kCaRnmhb25D2iRQgvQZmkEege9hkpYCZfObCHWtVEVmRQrHX5/RM9xeG/W4b
Eb3Ehd+G4S4hHHqE/uwQHzw8/McJrwcwdMhLB0ShheWQUgiw+mttd5NmNzuBbG1N
oSJ2P4PeZFBVhlvjzj7MZ4yM0w5JtynMo45l/vjUXox1XHt8sQTPtcSim9PVPK/8
dWbyY8uJD/tz29yXdXJmjeCG2hBsj2ufMcyV2IDfyF7crRB5+KZlcF9IqxXlrcT9
kHGKE9O9HCGc8Hafui6AIFXiHZ0ufC1UiEnEahF1yoZOeQrKocyAcdcyA6N4yg96
mxOFMCM9VDrgUkoRSP3ay8BMrzDIXetBa2ucV/cNpzEzqjVc3CPl5hI2PgdiKPSv
RC7bGIMj4uecVvRd2zBQHGjBnYwNv6vPcnwXXfKsQVMb65v9sdXNUL9dc98Jx96M
5lyIN+9dTzp0qXFTwyCFt8KTsM9xQxnjJs8QEnM78luKIHG5GkSlFJkhaE+S6ydC
GDhjiMy2sAyulGRj8IyZ7nTw9+6Pso/tNQam3uvRzLCCynz6VWBDggBS1+r1WeZI
I9PeF8o1rVeMXWRidaVTFiIg5dI6rSqyyG4oA0U01GsB31gIwUvgfJykMGZ1meMY
jxHg1q47yifEtO6z7ao8TX0xbwJD4/AepvgQ72t5SvOtrkqhuD3MyTQ9z28WISgi
wLMmUdYsQ+8b+Q0MqFcC940W2XCnTQadF9ODZOdA6MxioB47qOEetfaNHG8c9zZr
VggW89aE7tl9h1wHYYEGeCIB8/nrb/LJjfa5uNHk7ujTmbzZ9/g20sCJ4xDTOQTJ
N0scw4SauNo4fo3NMGqgqGV+7PELhapUoMfz6Uu86uA84TNpIW0ufm8FdGL1L5Og
eArJmTownKOB8U/LjNIw51f+IHvswMz1Gw5fl2bLM7sJTyrEomhRzxcXZF1TBby0
XqajZfDNFrpZvHJX3i9U8vW+QFhDvLYg+TXKgnfLCSgFnzspJFVnPXhcPyVsf6Fb
GQ6vGXwxK+StEQIf/+4GrKgcTPm78lZ9+zPJqKiuTFbio0gSdRbfMpNQBFvs4Ea8
Ww25JgSgBAaTHUksfxmLu8HEDtlxOZ5PZOcYZ2rBK0DmHtHXgyyNsH8LNeL3PuVa
lcVGXPXb1VmIZQCDdJzCJtRwmVwyvBppNnqEkENfkR3oXComZXnhIoO6D2ZC/D5N
MFsqK8KVisGagUx837cvFaK6/nhY6QLl2dfJghlYDxsVXI42EZqLk7/lkYnUDVJS
bvEYCH9a4w1bUo8TphtHfLwDjeSi11bl68L0GpgjzP5zhPMPLg9oO1qZHp7eDyrO
l9k2nIwmskO9eZtQjQ5SJpxJ5LASv418F+pPpVSYc0xDUHbygwSQN2VPYr7i4r6n
bO56yqWe5zBjhZd2QElh9kpEHRJXhYW2ha6w91G0QHIqKbBZ+2n+XX0LOjs83u2k
sXXR7M4XtGFGVdkVQI/1AoT2+eUqh1RKpr00jrpyRD91VE2aFfZ6tgT6CwUvpTld
tWplRtDSGAV+70ZWFw/+Nkcv1zyuSWu5dciCGAtFL3UbFbDhD1qtkrzJU3jTsXy8
96LSs9tc+gi4lOZfnpjUXk3wQ49fU9CBcl6nqksYtRr5MtM7AVWx+AuBIrZqtk5b
8A0o+XK77efm1puWnK+qBd7tdmXjkLgIuB/nTfQGotgq/ge/73le8YpdZZOcSPJf
9TJd6pFdrQtX2fYE1eue1z68CgBwBoSEof/+4fhO5SK1VzCDnU9vuJMJFAcfhzC0
CeZE/Dv91DVOJgwa45AvLnMvdUsl7Pb5X1qAIC9sHKk4ZVrj8NeIbjpifeDPedJY
28HS5HI62zeezOgVEZcvPmcxpU2GuSJb8g2s3d+EVp2WcvomiS3JLfRaz5xS6t74
c4vvyjRtSHNNsuUFxBRXybmt1XXKk2aY6chhdkV7pJskAymhQHcs7VnUDk3af31M
zKJ8KlGPrZBi28cgzJttJcvHs3EZTbTOY/DxADRqAo3Qy6noiF9GSwkVIYG1uafy
+hIWV2YUqQjakzcqG/ZFTNk2vqHeuD3O4b4K9QW6vKC5wpHhmn0o42sXft8Q8L+n
aS0/QeM+kuNFLX3ZDJI4iXbSJL82etPT9NEVmJDYdD0GtPdorbkVL5KdTVhsbNbq
AlNNVKdtFPM1vI2QDKd+1v/B7VzuCDw2/y+DkUVW4LDvYABEl9E+xWfvo0U8PlMW
wxuw/gjzRGxywDcgSzvcW12V/F/CjXoviZUek40ZTr9ga98Iff4VZeeFfoT2TJNS
/W7/+74WVyuwS4NFIfxn1uO5/ln9Pu/tIctxWEDSTC8p5mye5miinxVJQLK2eNhE
jgQZIjYDFwaN025DOI9qWmMiR1FKGCfBeErMwFR3E79MQ5Ybf9namyEIVKhsQmn/
DHTvKVbvuN5aNBHIcz6yBguO8y9wsQ8mVRk5mEq/a8K7WhguTygwrc4AWaYhspBn
SDe1gqBCDJ5ydQzeCBeksUPI3qpQOBS+3FgeU+0RrwcTyAPCO0GyaC742RNJY3Qz
CyDL16/sH09vp5bDD0o4TTFHXnZsRfMi5chtGawUKFoieweL87UVnC1x3iTIoUNz
welFGZAK0TgeUD0NPDWG4cxQpozL1Yj8Jd0FgruKQWR7ADl2DQ26HUaXohWlVIHX
/Sg7kCqJ708iFkJHWl9XiOEe9glpZvd0vAhTZGXLr3HEU1yryQa73LwmmhfX5M8j
juClsqKbqDM5IzHkC8ZbG6LOG5defBDwi+uKku0mnpMDWLLZP6HNjqVyfp/MLZm3
5pvS9v7sOd1FTnKomiXUzg7ARKGKT6xcSGacy3Ay/s5yu5zRaV+EY/7CBnpp0YNL
uoZKqRO4orPjrrb/DaJ2y457l2PaxyHJNP2Z6ui3rcyvGgu9Rt95BCS0vG55gc3I
ryoJiTpHmi8CBoU99wZBJ9AaTmM9F/g7mo4ebKYVrSk+CukKLl1oXm59gYzUVUAr
0g404jEWGCyVS6Tyur+MoLzuXO6ocY7VtKZ7BieT+hljy321GdOZUkVkT67Cyd+1
9LSUmpbuhajI5KMDjrfVXiQkpFRQNi3cbfp8S6J98XrmRU/cyPRpdrcCVN6pOPrQ
ozyMGPHmryvlCBmX/bBEqZg87vi3lxMnZa3BppI1LDKagKbxMyzwkTP8JbSTEyLo
BRSjCXI4a95X86GFdLDQcBvq63kvVr/VWL6C7DrsNxkcwDo5gGZcIlc4pw/Qzy+n
3jdkbYasjw7f6YC2Rpffyx1/jnOMA8kX7sSZbptrfnH1Er6lc702RSTGTfl8hYVv
G0Xp7eJi1SIoxvziWbcywvr/I7M3+gnSoAA3mqQGZ+p0rWTxMTV3JB12f0HDkfzS
9374sY5o6P6wqEQ6A+eowuLq71ubSBzw3aQvu/ZXXCPRSZT7sT+IqOPhVtklzmKz
9sDCzb8bPJEtuj4dSujW0g9suPYj0S9YMAGCYMEWTXi7ECMhF8vNE2yTVRjRMdS4
kkUP6jv7wAK+6V3/Ixt9AvHVzZfzcx1Q/m9soDV+EVQ+QuJf+9NwTOCMgsPdv3QZ
7cDikKcd37I15UM4S/7z3GRHkgE3KTGUuT3mDumaJelb47VwF1P3mWAHDBl5UDES
AHFhOZ35R5NdVallhCEOQE4RFzCOuV6C+qX8caxP/VnzJPJIiVqSHsyQMnwoBpHS
bDK7tfMvxbYmvrm79YwHZswBeSsQSro4Q17Ma0JIQ88BiyJwfd62LvgGG9KjoClZ
ytg3aNDCRVw9GkR6Yhknpy06+PIMR5luxAMVrKqJz+6bA5p5wWFS5oVrXhi660Gc
sfTi4d7SIDYoLKyRuVJaNTKE+gE77+lSTG20exLuTzz/C9CSHbKgTQ76ZyWQO1sO
/P6tb3n4Qs1H3QEGH1X3JUWj4Ra9HX+jG9tKzGhriUBma6Q76NA81E9dMRtxtsHz
H4WyKS6A+kzNAee4+ZTTNxLL5WZtAIx3J0iFjfAj+po+Gv4umB02i5EOU/ccVPbU
GOTsFT/9q0TFqV6XSp5h6nYo2tQhBH9POCjQpYEByKFJ/BtP5QHRNYfKdXS+ueHz
9Hsp6C84/YKrYeYVtrlFC5LZw9BhITchk3ZQF8Rey86NGxduDTdqCSbLw3AWu26O
ePEmPSyO1w+UIcSRlZuSMDRcr9Voi91ifeyqLYom2UURjr5kMuSurod3CkmL2QSJ
d73jtuJvMTlDEeP2bCsrH8XtUuQXLbQkGj49MM59TqVjC8fVyngP3KhQeTmh8KFp
Hb4KTGVm4NQ0VNEneGwLwu+aaXEr+m9RxwG5fu9uk/p4rNcjFUAPNzi47fKfeC+f
/MC8t0+AX3P/ICjtbuzRJdnkzrGJ1vH8CIbtB+O1RwSs7Lf/Qnvq49dcFT1QugHt
IuzASUBUVgwuOeJg0QWCqbGyfwyvLiqhNDwJ7mc9Q4FVs19k293KASE1BGZhHDgL
FTZoNwFTEX7mt5hkEis9z5cz0Y+G3JAhdei5UeJysJ408DVARP8yDfhAiiDItVr3
xXPS4hvBLgezWfk/TKhTbeEXJuGjunLewoQPdz1/nq42xPJVswtiHyLgqnbRi786
kwxlrs1Y9hR2JeWEUnG2kPPOUlqJm4eTkXZd61DPnjCFobn0NSKzQXTzfJgidZOP
SC694zkTgZXV1F6YiGg92CDvNyWu17kfhGdxVjcP+7rDqz2GxRcHqy9U3OQ5VM90
+aNvyAmVxtax0lufYnVZlCjg1HtJXO2n9bYVX8B1ITNtiGJAUtWsP5VRS0Sacj1m
Sf4ybruIXVvadLomMhehdKwT9vbdbEz0aO8MfsWJzyjJLHYEDIAvN9QjF33cWUeo
aiZSUxNd9p5BCei3pplQQ8jr7+Pce5sGa7Glu7NFFib4LJrNFooDZ/kWY9wQ/wSW
SU2EdmKDPIb+AHhkxbRUYyWQV6N7wCjU+OZe+3VaC+PTyCKmyotj2b418scDZKjy
632VbNJVOe30tstA4ogVKjPwapo+TEPC8nUuWIeikRQaJ39/wBW/WHTFgt88xMiE
LZOxhm4eSGOyvfzY52J4sTO5hyI/fvEKm6bLvPo0uSwrd/YOPmkVHI+vqZiNpoPJ
2uNG2BkD21Ph6q+O815EB5j3LObRkrMS1zJTy/wc5lpgVRJENcDHGeKtCI/38h4w
s8kkQjJ8T9csFEyqzANk7cCD0TgDtkoAqbQc3VI2nshlYYHnZFEhAHRPYNb5xL8t
zYnzDXU//v1dAMtD6Qc5wLFWjbH2REUdCZSQVflBzWeZkaG/6lSV+BUIU2Erqgtr
Ztl8zcOL7xnESdY5dafLFTZnSTr4kqB+7lW8Hmas4WrmmtR5nAsOFBbw4A35z0eK
FQgouabOT3S07W5VMSIlcEtmlokOcssTYafAzwjsFzArdWkv4hxw3tEUNM2ujc2i
d4J+34nW6ZEeVtsgtgkEKJPjT4PzXKtrrh/nZb40raw93YP5+J8TEQyvTyxY4fMP
gw0tOUUpH5TY8kE6j8K5IVFdvnoUtq6/FwQFKZ4j9tFw5EwNtyyAn/5EH/7OaxNU
5El6GCDh5mFQPsX5C/y+cQ1TBCYEEz2fjUs+b5WHHlH3Tma83NdzPzqeK2+kcVXJ
vMV71ITIbMhrQxD92xvnSzWuIc507qV2U1EXQ+Byi2K4qkvECnssYeJ4+FoGVK42
qfe1YciLLwwn5Zt1AVH/1XrwdV/gQ0BSyc59O/+vVs9y2Zm3jCXdpYkD/AC4OAG5
2jWZAGw/aZiTVMkWW2NOan3N2CV2RUFwPaoYLhqislq13s+GrOGQAj/iQNgQY726
UUKiZmwif4xBhCNUZCa/Bl9IN6/1XzVZfonwTg57Mnrr4PfjzJTwYGY+/C1Lh8zT
1k7C1lebHMSUem68i7OdnxPrxnvnA886gqZaszGjKGCbsGdYgQERZOwBaepqd1GZ
JETspKcg7EiqWht4V3MCExJi4zqbNPdz+ZB9tS63T4D/95IltHMQEVmXKPkIxU8A
czY/5bUmDxSfbR8KDuirCxAenC3C7OdWyTsC45dm/C8B5oRlLjL/Y5cH5nyr6Zca
67EnfLGzcD5iRG1yHjEfOJZ7AS8bUMWUV5VEIDXI5cMM9ZvjxsN9LC8pzeV2HVSq
dRVs2eoo04/mdj/AbcLvtQCqMCnK3zQtqfqOKV4tGYoZeEYes9xXg4iTolZCNQfh
me7z+h0sZrSplvFrqURzmD6A9D2VycwvpP8SXVryIv0m9BFmWkv3GE16fCYlJp5O
DXGJ4Xf8SsJcoHtGomMH2KmBkQOsm6rM3gt7Wjmz+WgvrkXWm4+vK306V3NmgVeQ
4udT9OLKsSwRMsF5mLS+wq20jh29On10+KStSEA0r4ai3cZ8oHfb+IVx0F9ja+pI
aJcoGUOsfGngstUAS2m/NDQulKCEpWGhXRmqtUo/OHXP1msCr0uSyK9NyKVQ4BLk
UTgD1q8LwDN4a+GbL0JJOsmyeb4lSSWmc8rmdgXDaU6aDfTu4UjHiZ/RmAMgBw63
h4kKQ3FAaGsdrkNGHzz94wRbd0/JE5Z87PJmWGUNar4U0GdI4A6Cq9Ui2vGnmf6q
PU25ETQnXzPUHl91DH6QZh8o3AgFPVKB3QSzFGb4U/IAuO2LRgSyRQ7c82IhR2qw
RORGl40XcqHKf/vn0UhoXdUvabfBhB4Y0fzIOXff5yfeVdBppVZuJUoP+Ml2DNid
znnOgwzZcbBGlkGZRsDgp5oahNZ91TyCXgz+W+wwrWAVNpgWX7i1lnSx0BDPF5sb
qFwd8wYXfyek/JDLafjisg2NSJwUbweZ3CMbRBhs2wdjDNGyFrPhCh4AFm2OLjhN
FyxfMOpPrK90TS7GzfsjnNNQNFZc2+lhX9hJcP9Llu7N6N9WpNeDuApq9sbBVtCz
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JglyaBRR9+0yA1sGvu3xhv0N1XVC38Rv3fqjgl7jIBs7RSi2ifPtG1C6pOpgRpxK
GDI1GbbaOn8NaUvfYwAyolvtyyf9/UI7XPpimUs3b4CxKHT5rxrREHHglzV0MSMl
0qdWicErmLqqoWixz5vEy67Fz5foT1qGX1cCa5fGrmc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13110     )
CTayAkjse+lfstUioyH9Vi4MZp1rKbbpM7VTZs0ft+eHL+IcI4788nNS1SR9jnQv
I8hwyBpwMeEw4k74QwDIiG8bz+tJDTIzIW5kU1PKhuse2or/XeEsHvpwFPWsY8eu
`pragma protect end_protected
