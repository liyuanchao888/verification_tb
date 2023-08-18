
`ifndef GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
`define GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV

`include "svt_axi_transaction.sv"
`include "svt_axi_defines.svi"


/**
 *  This class is used to capture the AXI transactions as seen on the bus.
 *  It also captures the timing and cycle information
 */


class svt_axi_port_activity_transaction extends svt_axi_transaction;

  /**
   *  Handle to port configuration class. Must be provided through the
   *  constructor. 
   */
  svt_axi_port_configuration port_cfg;


  /**
   *  Transaction id obtrained from the Bus.
   */
  int port_id;

  /**
   *   This variable stores the cycle information for address valid on read and
   *   write transactions
   */
  int addr_valid_assertion_cycle;

  /**
   *  This variable stores the cycle information for data valid on read and
   *  write transactions
   */

  int data_valid_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response valid on a write
   *  transaction
   */
  int write_resp_valid_assertion_cycle;

  /**
   *  This variable stores the timing information for address ready  on read and
   *  write transactions
   */
  int addr_ready_assertion_cycle;

  /**
   *  This variable stores the timing information for data ready  on read and
   *  write transactions
   */

  int data_ready_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response ready on a write
   *  transaction
   */

  int write_resp_ready_assertion_cycle;


  /**
   *   This variable stores the timing information for address valid on read and
   *   write transactions
   */

  real addr_valid_assertion_time;

  /**
   *  This variable stores the timing information for data valid on read and
   *  write transactions
   */

  real data_valid_assertion_time[];

  /**
   *  This variable stores the timing information for response valid on  write
   *  transactions
   */

  real write_resp_valid_assertion_time;

  /**
   *   This variable stores the timing information for address ready on read and
   *   write transactions
   */

  real addr_ready_assertion_time;


 /**
   *  This variable stores the timing information for data read on read and
   *  write transactions
   */

  real data_ready_assertion_time[];

 /**
   *  This variable stores the timing information for response ready on  write
   *  transactions
   */

  real write_resp_ready_assertion_time;



  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_port_activity_transaction", "class" );
  `endif

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `else
  `svt_vmm_data_new(svt_axi_port_activity_transaction)
    extern function new (vmm_log log = null);
  `endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_port_activity_transaction)

    `svt_field_object    (port_cfg,  `SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int       (port_id,                             `SVT_HEX | `SVT_ALL_ON)
    `svt_field_int       (addr_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_valid_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (addr_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_ready_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (addr_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_valid_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (addr_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_ready_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    
  `svt_data_member_end(svt_axi_port_activity_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[],
  input int unsigned offset = 0, input int kind = -1);
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
    extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


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
   
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZLmTfwhAdVNI2JhkBWRIl0/mzhZSRvMBxleLL4B6eQI/yvIJ33ltJ5dknUDz7fvq
EHk9LkRM1tUl7s7YnYOF1ilCQTrn15tpL/sd8K7FZKCPTZZW2adSQDnvY2lAZSDg
wLHwMZnQca7a/ZZ2lhsCqSiU0+WOrN6M4bIZWClzSWnOBvBM9kiISQ==
//pragma protect end_key_block
//pragma protect digest_block
KyIBouAabJMRsrgCWrSBopwxBuM=
//pragma protect end_digest_block
//pragma protect data_block
EFnN5dRnCsE9g5UfCRYf3Ie1xdb1WfNmWCiBLvzesrLKVLZNxFLeYxxNCC/cW5KI
AOeUyfbvFQCQNkskRgGuxJR4UymPQoTyG6K14gbApHMQlw5Z9tfAXvuwpNp4L20e
PTFUqEFW0ur2MZlFxawKFJOvWuLBCA9cKPwCFNLO0MdU6mRoBYndAeOOHu2scRE3
0TYdF8+4oBOWiuYURHbrbpDfDhvdNXP/DPiRBNe8HVw61Lo7klPGbKXL5yMnuK75
3QVTxYfKSd4aLvJC8nVeVFgngLq5QZSDy0tujWc/FTZEli4rj3Jmo7uCFYwMKqsm
GP2TRrmZkK6ADluAQWug+inw5BnM5Pcu3HLQTUiMnrGiTtMDHI37NnVT0sdWL8AP

//pragma protect end_data_block
//pragma protect digest_block
kuQjxVFICB5iqDkLN79tWZowfiI=
//pragma protect end_digest_block
//pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_port_activity_transaction)      
  `endif  

endclass

// =============================================================================
/**
svt_axi_port_activity_transaction class utility methods definition
*/

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
U8aMurfD0ecljetxb+qDF9qD9AhQZdwYpA02Z/t88jNzc6BAaKXTuF53TFhvL5VC
SOGa8vowxgTpIWn0+8PbBAxLtW3w8Nq4uL61/FGufvE+12crxViXJS0RivDfA3R9
J4aruD6ecX5m7gsKA/YZ2guWa9bfkkCUJGNLNhUERVkLq8a2EiUd0w==
//pragma protect end_key_block
//pragma protect digest_block
0LFfzXGrugH3CeEN4jMLfITpVGY=
//pragma protect end_digest_block
//pragma protect data_block
cd4e1luDoDdxbL0mJh8gxNadvrMLkfse6+a6QU6JVdkD/oAOEA2SiD5Tz38p1xba
wZjV9E7e2MkOPWxM4l9g6Fw/334/+hDDI7CUM5aQ7hYfAE0YKpqCWl+wazwQhefN
GZtQINT4n+rT+XNEuPDYnAHCcnSsFv1+Q3uX9XBPQfjfaSHLilJWGR5NlU/mvw6Q
Nq3kVWWFKBLWxKXtm1JEmCxMVavRRiqZ1ShCvB5eR8KUCPjEeHz39FRFdBg6tWk4
BHdoArYtxe2noWyPb4YGIg6IvHcEmXatAzCkx2mCncsYVAieJif5NRzt66MqXifc
MCz3zhBEBXa8ha67Fj0TZLe+yi5pCHFnihK8GCuHFFkAdiJxrSuNk5qbyuPcsvee
KmrMfYRvVu4wo7JMqryxIIyMlzFHAMR8r2affD6zNAw/YO+R7GkA87FzAF4RLEgG
F109v2ssnyEXjnzDcrmhEBW70WiA4oIggmhOAtjy1MI/xvVjYKl9t5iwKbZYQaVl
KmXx5nPcGIAGGNw/7XJbuGN2d25FKUNhT+TJVITaRvMabVbxdmfZ8ObZ+B9PKebM
+mRmcu0tFmlY6y4ftuVbX1HQnlvgGv9XT267TwMI2K6aoKS1EFC289YFiDU7yXsl
XP9HuM9MlH1iqrN/76ZVqamlf7KxhcQvVTAQgdAEGwwmkMFMWRUXaRzjJFj6fZhZ
akAnkfhG3abhyEAVEBmtBeXKnpMfUCWpwJtMC+4JteVL6qBSbyZkUAn+qFYB/mJg
Py6V/KpIzon5MWaG9hBiYsO39uxJ5LxRsZYnhdFj8MfmB6F9jwZic5oxMKZs5IyX
I2LJz+IUBQGIfIs8outF0PJhTqJPyNBeati97zuadMQ4JHgRVo+XE0Xw2U5Xo7mt
baoM+uJAvs8araZHLw2pdUIs8DKvNJX6KLyRki1xr6DUNxdXE/tQNXWj61vKD/Lz

//pragma protect end_data_block
//pragma protect digest_block
SUWcB+I4cMkVTAKtYIUHzzgxvaw=
//pragma protect end_digest_block
//pragma protect end_protected
  
  // -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OV23FL5MVewzGUjgHlLsgMqp4uq6WIR+ghMX5cOet1Kf3VlbgRjZ+CsDzC5W4svP
L8HNEiAkwbqj+dv1svO+yBdwsgXmOTVHjhARLiQfaVEHI0z3RL+lwjbecOL6lfox
UT/ZdSQk0d97rA60ZTfDqlKI/VCTfSctm7I3btb5Gj/GfvG1FShPGQ==
//pragma protect end_key_block
//pragma protect digest_block
BNUS4JSTRRI/CPOBg5bxwLuXVYg=
//pragma protect end_digest_block
//pragma protect data_block
/vByGXxMZMlJbVk6oE629mxBpJp41mOxQgC773l6ZKFLzYXfJOIVNDuKUChT59W9
DAPQ39t7Ix8mg9qnDpXteGTfRY14Q0dVHwxZZdBjDyE1VLNLwZczE/d+oz8KnmND
onojCdY8D1IqoQ1lJNu8sfeSGaDJzJkcgSPfEQhm6UgDz5QIx/YXtHaI+W1982fA
rhTGGUwsIP94u+BY5+uXsCRngblg7lKhrbr/nlwhHA8dtR3D0R8htzz/mlrhGWEd
ANNVpZLeLzACBeDlb/8jLoEPoF7SKIL40+MItizv0omZ86TevTglwaOgD/5QHlfr
I0aLcm5/1n47xrVDEhIpjguGjlKL5JRvDfzQK/I6hyoRjX+1/E7R3ep73masqaZg
Lc/KDKOVbjiAYtLaaLSlblLcU2WTjDGhhQP4iDryz2UNx3SlSUeeJzshLYspugZ8
VeZOo8tMWVQJ5WDsoalhDCIsbi6zvSNP/8P/TLTUKbirw21R39DDgJlfdHNJTmHO
iAnv5COUXUXh71j3RNj+ZrHKRH4xbKoFTBUG2Z8ncbVwXLewwYbPP3OEf+r4K6WL
pXWM8pH113+T/PN5oznBQcys0KzuehGvbX9FhWlb7XEEItAnVOhg8bswgpl4wHlj
NWQkkgH1Jq1BUGNaUoap+oFD3IfJSkhGkrBMiHvfdO3e0fy3e46YaE4r+hn3mU/9
kdkM23M6ohjiVcHnTINJ88IUl93fWqobXXYNCMMBmZ8PtA+z0uRzCoUBs6n2f/bs
zVg3qnbuPVQO4rvp2i+p4sSn2vCH966BLLdYYwOzK5dsqx9JbW/rtGwy/9p0Br8a
wdagQfcWfZBOMV4sw60pSKfumlRy9+tWCUWyV7jusOhCCNJrNetbYUqvm9Jx1dSs
vSzgs/g6Hy29NhaZToWDDPibarsM7vSexnS7LExKVsixpU7wBrvLRsuWfxNMF5P9
0JY0FMO/l4vnsL811XAPvUt2Ons8Co2sHu089TMmBElhW44i8LQxryyFnw5eoGhe
P9iZbKXUE+rEF179/KkA/AabeA+dw37s8Mk3FCkZHaEWWGOsOKd7DDF/WJKlnAmd
MoDDwe1SuMK3617Rgf6vG6MUUPNJeo5KQFwRAep1ssYhyUYjKF7E54l3Dv5pJVCh
tircxlO3Cc4cFP7x5RXn4/nC5EpqxB4IusHfI9zzY+nt6x+V4Cf3tCnp9U1t5ZM3
6e8eSc0EdTmnSWSh985eZ7FC/Zk2+O+7TeLUaZlthvQYSsCJkPc5bGkRbWtsZx2D
UElg1xxUktVSiNkHMRUNG5OJ1gSBh2lxbg2Gwz7xa0APM9CgYEiWtgxsK08KMMQc
SC/lcI2kvx9ghmVHybq56Ym6GnSvLRS/0gg22fQJyGznJkggiDyfjWkUjzANH1Zf
Yq74w7zQU3C7xfs1/UshmMsP3R2RdUDx1XdugoCWgS91dKyhU/LnNN/dOu9BGpMp
rzKRSCYl7ibdVsZdZQaFxQu3TS+xtYCR04qm+D2x1kdSkK3sok19IReSQS0pABje
FtJwMLM6Vd9Jbk49A1805jvfhHQi2CqORihE7NJIsMiSkWhX56VKFKnOSi9x6pHr
zoBygq2nWDaICvTwNo/jlD7zF9yemVWIqrZFEAa1KphYYGQHpo+b0XA0mjR5vClU
Y04t5aXx3upeUJA4ew7L+Urnf4HpAOWtYdHz3qyB46KybbWpwgfQtSMMoWxpIK+w
REltkUBPBg7/e+mHZqCufBFAbMeTTYmbWcnPZpn+Czmix4FrKlCs+hPYwoq/T6Rk
4J1r+7h2qzkgktR8BX/JW9jRleMIcOO1UCCE4P80HM/kFuFdDJsagExNnF6ck4y/
PNERaYjpaZ3QPAIdGvLKSxk8Kp9GMy5gxEps6MbKc3WEpnrl24ZhfuZ75r/rLI+b
h3mFSOSzjrwTwKp7X9X3Rz4kzdiO6zgxjRav9t08WuHL6ohbfX6vEQxiZsNDcRG2
YfkCpoiWAFFT7s11BzBdzsEu85m16tJ7xHHMPCyJx+dMBDrMKhiMrq/tci+Jpec1
5xAUqUZQ6bytWGZREv2TVovMUhqeitBL88LviqNHOnXFTqlqH1Rb9YfmQffXVl9E
K+5Ft4UfCa9a6gr6eLVEisOEmCGDnRICXVmseegh8r/gT7/iAG+Ah6VsSFPqeMTE
6Y+LsrGhVfX+27lQsD7K/ey478Ri+GEMYDX8j1ckecSnz/m6a+A8d+78eEOhwBhc
MsjWFQQPryHwQu8W+1HdtA4nPTqzAVzP8iukdiUYE6eOVl6HVsUcObuR4pgX+vwN
QidfZB7pMpi1n8TfhDlh9q4M4Go6foJJiwE2Wa3q8fNKV9dgzp52NWxJkgIWnQAs
QuwV52nxej9o8BFWsfXKuRJV1l8IccxfDzGdJFwsLPv82yJGG2nD8+DPSMSkHcLV
xlV7+B1fgvwaCGylRFJAkMJe4c6gyzlnOq0boHkp0a+IiCwgs8mji4iDK+L2w3nk
PlVwLSx6en+SCPIRRul56mJqFQc8YBU9xBI14N/VvufubuqkRAn3RSLJnb1VelTh
QmETO/qFZVa7XUjbPkjqcwDuP50D25wrb4XA71Uzeyict7h/3qoj3OpvQUsoYjTl
6aHrzfSOYBqtcyrXQKozYmPtRtsJXHI7ymT9n4G9lJmT4PPqYIcJ+2R9A9SbL5UG
rzqwzFtq8kvZnzIwTJP/60YkfG0ueYMd7rOjJ4w9i6IvG8o0u22tHyJI9mn+4/rl
mHC1EcmdnnCtB4D4pw+KT84y/xg22dZQ7jmwAoifDeABVM014BeB7/+298t54CZp
aFDov9UpQNEoYyWb8U7DLRwkcIJpHqCeTdUW95xHvTjJ79+lMpvD76a+MGaRIrCv
MlEKB1qIKD4mRyeFpy42L6P0NbMHKMSqm0dvJYlBeAaRrER+VvCHpeGDu2af4913
tZepVfoYMWGl0WQckkI91JmkDDFZU90l86JTeRr3wXYOyVa2vsuYEt30kSEbJyFv
5bYGZaj3aj1sNvYPBbeBvY72n16HOmtl2B98XipoFHUO8ZzkDEbLI5yMDms9l8Ba
ZQcKYq0wUdKqSaeh6oFJaF13kDn93i0d5e6hKC9nRK1jSS9pfwL0G2FC41s1RkNl
sipudjbYpnvhGSVSTKxOIqa+riIwUbh1oDz25gQnL7ToiXOX2N5gi85hF8Jo6rCg
Jfd7w2EHRJQBBDiflo9f0Go1++eZdXL3DiU5h7PUKAJEn4nHXOqtg1tL7oXxa16z
4r3kwGo1a29GOQo3Gz/FpVp5B07ayzNIMFs2uNCPgVv2kuUM9kq6TKOxQYBNLKzL
qJwPpadji+3fOWVkbdsucegseDlHcdHf6kZKLW21Ln0b2LCVuSPXTl7bBqMCCiYW
tL/7BM5sZOH2xOiHcNNsm9QejkMq3vaA1bPpT8G2MzSGJtMqoxaqxPIs2b3ITbU6
dOevoot9Y+mhGIG9HCSOvzNTsNDHzkbvpc2agC97TzUPE6/ePtUCe1YaeLuOb/hx
IUY+4kBvWO33iUigv03XlMCbVyt4wK9ygt6TY68CSpK1yOEgRUv1aw3dM6L26Sud
iDG3AwSvZpjKInWHxphYziQecaPxx+K2Mkhzw/7It4qt1mP4mN8Ov8VS9VJARIuX
FIlr2A9aHSji5VBfn2Lcq6u8ygza8t9sY6EOXmnF9iQ38MgJvDuNA27TFgoVAkV3
em0wJFiJ/q5lyp5mxGkp7aOiBYYc2afQRQWM1dpyJvt2tDvOK9qW6xwV+5k9dMrS
RbTVFOSIAgm/scKhDsSltESSEElR4p5S1tHAkw9JP+z2bkkce26Two25PcYFVBKe
2Ye4+i34nYY8gV4jYT7svg/harAX6GUKft9xsddZnnwzY1Z9G+EoYjheNKBphrJ9
g5USmPjujvImkmA8uwY+YaNutO7XmCGVG2u0PF9q0+1ImSLDJbN6iA8h9MsOu4qn
FipHT6o/QVF1BV06zAp3Bs5m/C4EdYk4QxKCIqdIzvUVdnLusz1cZ0Q+e6IHdJmk
eC/XQLkF3oamF+fxT5LccNdM9qLTPF1495Ypw/NTDJZ5rwEIf8pKnMwkR/NfBnOQ
9AZfEieuUg2dBhmvBcU0bfioAzfp0FxPXNw5XbVYAs6XO5sAxrMEOfhsgX6LSuJr
0XCQ7y0Yxaq7XY4/hBNC+unBvLBYRAhnZ55FVaLUgllj2rhIq5pcNb3LVNeEr5CM
/7Nw/fdvP+hNnjyyzYQQhUsCfP4kTeXwtxgihpCo0gwiuEfjE8PUzdAO6ssifvFa
oCfO0NpUQuISRzXaYKxK/BYSHvUkp1dtUK+lW9AdIkfMLWUbQ+O0YAfYXaGsFlax
HQTfdQpke40mrfIvubHDluW+Xw1b1GDFgxbo4Eql8zjgutCwAvZGu3fBbqgAkdvB
V5giZJwSjKo4sczCfxsns148mCXFhF4ApG3kCUzfiXL0rW+aDdTpuiR17rzhBwwY
l1hUXK0dtpwu2lwf4oZLVm5FccIzXmJbFVDYlbt/V9Vj83aSQSp98KCxn56CGACV
/H6CkgI9TICB/wCwx+TEtLuDPpDa/dg7F5ksifNkVvKWTsBK5+RTK1VKOy52G44R
w4ojvgGrxJk+FYJkUP61n0x584v7cIP1Kq1o8rlDYCF624jCLg2GVoSUjmcDQaoK
J28m+8wT7a22kL+AQQ0izLQvawd4Nw3+AMj1kIreZHAfLWPdrH8UyNKCgWmCFtoS
ACWmd/Nmd0XW8285EI6sxhd9j1eNkahplo/7VUir1TSNoBgK2PjIbvoc4pxtev9y
szIdyxmV2YBBEhj/xZxvi8F2rxsc6+kkQuVNAutXP6H+744FyDFnbOsxDQUTF8sI
Ab95aZ3JZVkQ6Yx6j8bp5YVojPeAeUx8xg7TdB6w1E4oO8BMNYuHzzqyaHh67Gf0
X3LbX7O00l5cJf8yBPNpLL4uQGCwiwqh5UT8LxiG04BE+5tgDXG4PnSQC6iiJUYg
aVnTEZpP3h1PAVUVczDHQI0J4xBr/2sFgRXOQMYrKTxB+e7x9URQ0J8IzdlKHSD8
WrDGioLRlbINh8aYzzhtABkWJXAiSVfVtTMT7Q1QM9xJlVx7GzkkcUvD2n4M1WG9
T1d5CoC8PL0N0F/OX2G4Cz1ZWTJRWP3J7iIgLPCIy7PmI/pvgmtI2DRcddiGy584
+ksMp4VfI3VphUn/C+VqAzHnXXyJoVE+ezM9y096swJRGhuO/puV9E1ZpvTdVWYS
b1JzrQpXzLTb59h3Z0oE7QBuSjeNcShha399f14a3ITWbCzAKfOngt2GQDK3c+nE
y6C2z+BuZZMiVH0uXpwGBSy2Xif2B763eolV2UotsWF7W2cuQ09XFB9XZhuOrN4l
RHHM0E5ciiAOXJO3Atebxm+1ECfr7ozvdD5ktW6bEJ/hOVPdgWZa5WW9fb1rPt0Y
FEYPhPJdRlK3dqpeTaJCBBOl7Cz3OppXOmXa7UxNjKnDpUL9sG5HW39OS2JmWpwC
CZ+QAeCUWUrbyB7Y1yRSvpngomEuWW/i1axuqkJBnEYSrpHFNm17SMgDEWIo8Wj0
ShAys7WRQR9tVyM1Oa89Yr3AC02K3sbDWBypEkxpSThgDkfv4HYl6GhvW3OJ4vs2
W76bFEdHKFp03CtNxxyMIXqIMc3Or/Mri88vIDUW7FNeUKtsljZABMBB8nDcAylh
51+x19iOnKDsd82PO1l1lcMKS3G0ruCfvMLpcz0178TB7itMFy+WQetzCzhklHHA
4QKQrvCHqk1vOcTN/SD4jADojiElWhUf7uBFDOvqXTw8HK7Y4sxPrNagNz9M3OGV
4OYdWqS+Kj1wyDdOcyTD/7ZU4Twej00GWTVHgGYf1r5T9TGrS9FN2qYtHYds5fIw
w5vsqZki452Jftz8y/9egbbCnLt2fq/AvmYUheEg4G1j/ytJWTFL5UuZZEk+WKYf
6ISUcejhSzgWL7OXBYsAwoSupnG8B08dtW9zBo6sEmMmzqBkf1pyYE9bsUoVu8vD
DH+GMVhUFD7/mTvfUFTd5nhd9t61o6mGwye/DSKFZS2e/XS/YZXE0UDQ9qEQb6f0
WDXi8+GPqNsOULH+S/2ZSd8TuiaYNSwGLssoLW9frwBmUmNzma5C09y0WhyxtV7q
E3DOeh31cXaUH54VmdrmzImiKuS9dr7GTTGWF4SzNcrN/vyIHtAyR73KXnjE6f0R
MwQRZi5XqOhCa8Wk5QInTDkYT7ztM+/cpVqjAIq5gmoOMeU+0RNa0jIKKqSLLT9r
CWJFTcAdWF4Ev9kDpNMH1uNT9dNQhpI0UZ7mR6QTv5ek3w/JmnjkH5Gi1hDjIGMl
papdEC4NCFaNwlJNjO2KTgmRwCQBijvHzXwNEgIOCtuLCNXTGitGhrQuNapE+QYJ
87H6BYOjPMD9uDBsIYRgC4ifDlSZ7H9sX8S5EMOd0GsFgMtKaeAMeu85ydf6Utaa
id47JxUVCEQrObwwWXwLneO3RtCdn4hi2ibDYX1W2CqvNBTXsMOgdJ4KB05BdV84
9jQUGbslTbgLSLDRC5GaGqgwSCdWiPKGVRSTdO1RAdt+lRnPHQ+4iYCXECSe7gtj
ISsNdHtHh41bXHmlSlxq0P6+LDWkJBWBbzBmsBLD/TU++owRyeTT6jWs1vuNK7Wh
K7dZVVDuG6O3keZDfl8oELqcfMMVDrxwTyz/psJ123yBvLYr03kw7k15dTziEsz0
sl6/nJCLB//nLrnzCHlt2CyTCMg84RJnjZrOesrO67E0KD6cLFxALJPYqPI/dPQc
NCUhtzxOEaZaG30jC/BsMVTNVM1NQIUTzcGYYhvuVraFclBSE1vmGZ6mLQLaCKK6
gtgt/6ECS+fQVfB8EP9XNMU1X9YtzZZz1m5vrXxYBrb91nAkE/7ajXq5R0DrGzvB
rFOSEBONg668uk6a3V+LlRzBF/eKnmKdFqDsaKcZJcWPi6V4e2QNC0De7Zb+QzsY
MQHOrjbVH1FT3wdfeNslZPqle+v0YbnPN5qeYhFBGWQ6AK1HVMlkFbojaoHBM3/e
CnAQAH2n+9XvlQrUDDP4VZ19kaJghfNTr361SIXBq3qR55adb6OzaY/y+wGpJW64
7HhSOLqIAoFDFIvxLO6Nu8WPiP/X7buMjcK7hPqsp9iikNf0MRx6U41oXPp7zc23
xa3A+PXyWHnuzmqvjDIfwZctX3rPkNONhUtW37GrM9fLMmpVzWudeyxsRhsRtwpi
/Mm/MFxfayEpJhgQzXUA/8q/Nv5su7VHRWccw+/ZzU2sEK3ADavfWGQaFoTuNUBq
aN0kdhIJ+oTuq0TKPU5jAw25VSpftnSn+mF4fJeBlhrJxZR+ayeZapBBLtIxvKpl
scfG4U2Ng5WixkGGNfoKTF5tCwkM4znJKJFMiAGzUw1aKl7lvec2WECW6zB5BhUb
m4MkfrF5JM+f/lMhXM8NRPNkuIBMtpUjTp9pxhF0B3UjYHuuOvuDjbProOdGwFgj
lDM0Y41a2ekk7svdw3SQjle+LGHvOK//2ophpwPOhVJt1yuF0urEDmHJqKdy0ud7
5hn/LYq5UYAWsqlHRNcYeH8PGe5orvRoWPJZeunaD9Z71TPLwfCPSouiJlE4MkFA
EFSymoaIKyMS9vspp+xEC4/RiIuRNjyMu4dT+bSoIbWdbTIkDrBW9oEPCR8tNROv
gWeejnINU2DCW4AwD532odCyrIg1vSy6joUoRZySAo1ZO6LCYaDFAXORzD7W4IMf
f9I8N5tTE6AbmDG9DMq6U/oJgOv5Vn0T2bhEU2uisFmD61GIv9+ga0K+9S+UPRMN
Ho+yw/JLn+N9mJP3rXZ0N2KNNR3fKRTLwp4/Zv81g1amdImaOX+l4tMiZuRLAFbX
KCGNeOmk2x+f2L89Htax15rzD3LgxbRhIH7q//V6fmslzoBwhFjbkhLyASjmMxvH
96bLJAKbj9a74yfhIwRqa9rUOHWa1GcQhDXCQZhOIa7AqeMR2ASW2vVFmK0f1edc
aLaSTPL6MRCfv+kz+gktcQMGx3I3QqwCUMo3oZ51nXkR35EDgqs1YnaH1DviOUVH
TxxUy1j0tszeZ+TH27h8XI8coICD02xmLkhZI4Rl2mDMKNTDkB7INfdOz29l+jtu
iYawN0MDO8drqm5stgVF52FFDeWSsAI1B5+wBR5haRj2y1Vzn00jpf2j6nuCGjgg
O4FL8RMl8tY8/6Ml+/kiEn/gWimwX+y94lqRDQStpNJrRSwWz4Aad6AMFTTn8NpS
ql1h1ubIa8T/mUlUjIwFWMXtDQ5jBa6KDCap00xm//Bs4lKjF/vuiSZ4nDxFf8pf
PbCi7I0W8LoBMSXHKWtJrl0QZ/ewPk9/JrRU9ZWPGizsQx7zmHv1HC5rmhMkrUMW
s0YWpE4mWmGbhyEXKcEH6E2R7U/WvpWPVktXpSAjf5k16T0B1NKL5N73QIjv5sXt
BznYrruCMf8EmOtqaYrHOTMPml6lSyU3cssC2wtDG4JRAXteNgT30PL/+1xRJl7f
8NxkO3M5BM/9+9dZuxiBcOVzLUI1lE8f25irSympOV0nYV2Ftfp2NlVubQqhKrA5
a1SPrA23ZJrxzs5AloYeaF1Mpho0C+o89t4voEeekJBPqOd3NsDntyIVKhd7NPxr
FCSMLBC+Gs5lj1Vwls2oj6QJMsGVc8mmA5FRCnJ8FC01y5sQpploS0hwWtQVvkS7
Ol+qc0GRiBhIhL7+otoL2KT4kR/rFjHq6XftGkQAhWhB/4b1Ouw7F26Z3mMaeuPd
JhAYydYGqyklkBlxqZyooZQ8zr05v0J9iKme20s94HWFSM53dQoe72z07sxQ7d5t
n19A1bcGA9EcnT7xmTHyqdHRPiNG23Zs+sXcreQUyZBlTgJK/IVi9O15iI7yXzDP
2C1VnrSiT5lBZxdwUGkSpRpSacS0QbM8vXsXpA9zk7KpsVsDa2cpZfQiz5SWymFw
IP2vgWT/+aw3+lj87W8zGTYABhP2npvfdiyNljEKolmUpk4c9E+zCdQfAtSbKWh3
j2fXk4FAJDS6kEBEah5uwS1olJqw+nuj6Nje+uP5R9EgP4KJBfABIKkWB2TPN54g
9yzyU7XVeVV4xcsqQxMjNTYnSIZks9CNeZx23P+iWgqk/Av1OLzDuY8xI2XRJNkO
IBHwiZqGHoubBGJVT199v2FqR0Sm4cdBKyrWPSJETBHByDM252HyKkSX3JpLTbOw
8RLYzfdTdu9jw/0dPVY7IDRSqd3Z+nzTKCCWlek0vVLzUdyB4kfneoz2nmHjCjIb
Y5UvurqZ1kL+s0Z80qa+mOQeA+OX32gpe98D+wmKGloOBe+oQYgiqB2DRJEpwnYO
ta+nTKAX0OgESv6vbMUqMnI+33Evsu/jkhEVhQnDb/rJDLJehCy+crl4GpY4I8EX
mqMUC2/kKMW+OUhQZrhXZ+PVauw0Mj7cTajwnGuAVWuvbveQnlqNdTCygWd6uJNC
yeWuQiVbPnNFzARZuDYKRFQD2smeKGqGNTFaiwSCyQmZ2ubgMs52NBPJc6NAzFAb
jayYU00ZwBVOaf+V9NRjl052LQgXUbNOrTdrIUk6Or/k3EZeGTk3cLb5TIngEKds
coCRKw0lxaWfwB0bn/7zCybmjNMIwZaZgzcL1HR/NS0IL8gjyBHUE1IEio7mTU5h
jwgkE7yMpcigIuJ1mKFL6kmIf0ypE2ybUnBNE5MCWVsnaoioQbdxc8Ze+FvZ1GZo
p9dtIQiX5mVInVqR2SxPKKeGV4HJZ/hmo+XeKuZxYKlen3ufPD3uKlGGall/PZ2F
e3OEBPZzzO62sgo650QkAzzAnXUgaJqWsZSHpFB5pq3/MsV7VqIQrlyYrx0pLUmK
ALJAiJi/vkrJreWWLIpskEXoc5tNI4dEDPDkzoQFa2ZTUfAkjYq9pOpNCsWaowkO
pete9smJeD8GA/OBjWTjC2rmiBQRAJNepo+LZRpjLEnvVBPwHIDQzTlihkDR8pfm
IF5qB3Gz3gm7T9PJY2TS+RnKwZ0SetsAgANnF8JaOH2I6JZJi0vZQuwuXrqvJWd4
bGM/9i2vBGNJ2GJHL8ZtT1iB2UKNgOk2zkST3xGi4RanAYZhpZi7i7qk/oh8ukRT
cvn7VHZn0RD95/XctW94RjqMG4qgg2rIftHPthUTgmgvz5zvfLHNqkKQyM2AIO4C
hIXSD0yvaCucrUto/ghCj9r/jRMc1fyHweUtDNHbZC6Z16drTiHValXCIsuri5Yq
zNmlJjsDRTbWosAmAjpXfvyMcsBxtBp+zlwwXaefwWSZUXA0ZcNbss6ZGpku+L+4
GzS4FnvnZXviNefQ/xO6q6zSuHZR68r+Z26P1GKOR+VWYLEASuox+NMIa4VXbkM1
+zLBDJg/zTu3BNZnf0u7YfA/1RHCa63uEn6KxFx+SlrDbScYMlvwwxl5jm1eqYz9
cesGBwMGdi5rFyYHWEMfoLkgJU/JUxfvGH+AVK3yo1EyCDz0zh93cLKPlrsaOn1C
zHz+DE3WIy9MACNcOfi8CKydr/VWP5x47fHIET67rVj03iqIInq8z9SHt5eFvymj
rLO32HGk+1xs2+D5vmeiWTKc9pmOVouxUBlP/erilcEwxa0oTZrBeMv8R3+SOfqW
7b2JbPAq65FVw16/jHQYhHCJf6EHIbzRns1vxIMVFlmQRvSXp0vDjs6GHdyDk9QD
OjfezogIvcagt3iT/f4BUCSrUihP0Rj7T6iqzyewvRMPXuqehgwG/PKWNDS0PCrH
VStQMm1RPae+Sw2uaMhcgLcQhn22fxPdt/ze+hd1sy+z+8i/b3I1EACWl/vZ0mWt
xbj6Emr16CXVlrX9h0jHZ/oUjGX1p3tG5aEKbdwrIHZlntWjD77kLGsKDR7dcIQ8
TImGT+aKZ25INCES8/mbDCt1h7inY+MhlbmZSC2C1DCcG1QVFuMFf6sXiy0iHD9X
zYLOp8OT1qb38C75NyGY/bnAxr6Yx6zCM3FS5EWfhq5E08YlbF53YVeXUoJmNJn8
WoeTi1eutlOhYWIz34ryurDF+634zTTp+oOMNY6eEoRt/qfsoWz2tb9jP7kqlb/a
HWsm/htX/Nl/fdfYGPjvsDm2Dkqawc0AXLOmnnuLhmEF2rVj13mANF9f7yYegZG7
0Uvw9rpYiPrJCxSq2T7A5bWUHr024xryw2QJqW58RLlPqD5IixE30E+wMNa7cXJG
Te8VQoblEGelYB5lfz7mOwy/viLJExZEj53QrWeTyY+W1SAb7bKAYqvtSIk18Hjc
+AWDNzZu1kdhmUe8havZ+6i46D7YCdUpV9jcB4sXUlMA8n518YQ0SnVXpwXj4uMZ
1aHcXuKwPsbVtNg0LgTXeymIxKke5OMaZq1FQchQqSUygdk4AeOFOF6XaFE2RtDw
ICgS0Va8HBO5yhox/8Uxi5AllGCGfUAUVUdTVm3hiMO2EcDE3uEnqr1zdFBBF8aY
yvXg9pPuEsj0KQPD9+1aQmHqI9XS04kuzdd86kXprhR5l0AKvqj9RlDEcZY0ODrM
rMfRA5yeLuFuO85ul+pLX6gJTd7eJWxHT6dgAixFQjnkU7kRHU8p6cEWZjPgGxDW
Jy//LQv9Gwy6mL/m8AQHWhGK2wW9aTVD+OIzOsbLn68ta2hpWBZbJDS1oCYf8Y3+
Jhad0bd7+9pFJLURMMJarNday1wkQdf+hotte8ih8Dp0K+r7qvwMNQluZzKxkb68
Ae0cPsYl8njzdSBlyi4xtwjn+8Hf1KiTKdLIcZshSX6HmhareHFKh/tqhSUNpXLn
VX/aSHHLuJYNtm2Q/isvXw8VNdbP6S0znQIsv59gVRgq2AxIHGZcKFyiSf9uXSn0
j4xXA+uJWyduezysCyFHhgSgDM9CVja7FJcorBDJMvLWP2bn9+JtfIXRKz8/u/YO
DgG+IYYW/OAzWW/qeuQuVAeYTA9CP58fw3TFszvOpITmYjHY6XGoSY2gi14enXzO
qWqemfv+vv4rUTNoxDIxEApdFN4SxSbVxxFjNMepA47i4OEJaIFVvea7LrS4BakL
nFtdDWuuEO2V8z2zZ1oyMXp1/P+ErOjZT3vGwztSLxxhVS+/4K4/LNA3/WZXaeFV
SLoMW/40ZJVsYi184CvOGU2DfaJwqhzDo40Cr+qQFll7DCJoRonUReiTGHvttk27
hOr3rkFj/gw4PVam/vSAT4TcOhEHNsJA5SWqPjqWIjp4euqR6IwLiVFm855vx0hY
6/44UL6ddlSl5xrasRL2OTz7zvFYFlUbJPupWTy7ZgmnCVyTSQ+5R11eOSeVyRKy
LwwiOFcc2FwH+ibqQw+kf+UYC/LOZeOw0QdeCbp6aqNXJ+ZQGJgd1meH9nQ/7g/q
jFNpjm+VQzn5HIh5rgFtxsdGTkjGfMpq1Jj+QuvAdn3gBQ8oKE4MniNx8VPKX8Io
yADChdHl2hm8eLiUrWLSaAuOk1wrYSwVU5yGYd0vJG2CJ5nFbdmjGWFvOYB5bpsJ
MJzw8kZXI9Nn11U3Dfq5qFckW/cpvKWjvdQ7bRztHFszEp/Hc+LiGQQgQxnyqerp
PmR60A4s96Tmz2a1Qz8bq2mqYqK1vw3AdCFVpjiioge62wh6wlw3jPqSWHNQMv9V
CbXN0Jh/doNbNv1dInzxr8MwbU6UNI44rfG0fRBhkYgFWBeeytPq6zqHSHMzZbcc
d1wjaFODLMyFRhE0kTGh8RGE6BLCCO+c3xClwCuI/3F/3HfuxqK85Rrvc97ZLKe6
Jt8OQY+T0GpjQSiGjEsqQwEdAaM3nZpSQ3LGPXew7Qy4g74AFVJ02y4UaRhThZof
3PefvyOrY13Slz8F+W968HQFTOrDA8AG/zlkSlMQNZwxo0drEAa7VPP3roOjeCTs
GRuJyJfU18HBIS/nHGGqeD2dyMbuHdUmkzS381YEl7zIzG0Xzm+RvO2/rLgGqYEE
lCKNSlEOIQkznZrha14C3FZp/fpSin55Qe347M7y0yG5NmS4xBbymgaOQsX+M7Xi
+wcJmO7Y0MfNmDUhA/5vlJrb0qaTBY/aBVgHtmwj3YaxvFDO4qjFn5+rQQoMzjDO
BAP2bIwJ1tXZb1i4WOm3LXgj52A7XmkNi72bdQ81unNE9/4oLZwbewoVanAZdgEz
mYgCJddFq8har9Hkoddhj2SiRtvmgqtHtwrUuO0pIlCqIdUCKPGUi0id3Ba20jD/
fpJxdXs9jrps/1ManQ0sJXHMcGLotPMDMkT46tNfgf7hVlzDlECFGPBuIsghdH9x
LkqPoPKSxof6ZS6XTu1/6ersj9T4UNwOEisuw6gon6N1LgH4tiUiiEB7rTHnvM+y
sn2phOxLai0MR1hOsD+2dR12WFtkEosMeztCFG8qCL05dw+98mWIJFg0Y3P8swOP
KLddBlJdD0SDBpskklgej4yCUIAfq1b9v8zvaJdlamnTmedI4TBcZN51cCPJI25s
Jz8306gJXvBpXuF9ES1KLRSy4SIs0gvn1NcCuPLmdIOkMdR69lsbq8RyA10ST946
S1/37msNV2yhEHv8K+Crcql1IfiSJCTdJ8yRo+IuDxyqR+34n5T+FmPgM4X7XkEa
mBaALfGWfdr/OnWWsKSqe09n8xbcbBHrDOoPcxCpXgHI46q+kT1MHlxGi6gADEnS
1Q8Se43KY8A+Zp569sOd3Tzf1TxClYuEVSzfglCjCLGE2do71eGqO3AWusjezBuE
wkrZkDSJUdosVZLelmlvdxEje2f4cgQ1YGmeMhOq0tvSIKEmJAUu9P/T1y1/CABI
E/ofvCLG32m4zDl6JSqiU4jz274VJLfpS3sM47fLBWuieLxLk8FM1z5PHJ+zvcvd
mjL+8X+Q7Ze8Z4jLwiOOMl6lqVat7g0MssjNfePk6TTEYNHgDlII+m0B+w0WkBug
Ocn3fmae87/HdlocHCfoaeFXaZIXdRVqgm7KiLcIQ9T2Gr80BZhehM7rZDEznW2j
tJlsdgPhn5zxOo0H4yitUq4b/Qg03doL3oKzMWnklpUyLRRIqGA75CYVwa8UNxeU
ozoYHF0MIyvZ2oD7TkIKPKz3oOf0FwZDQq6+fSDifWjBjphqf9UG4Txx6bnU3iSd
zIRrWf9Nvx1iIMhWg5sTerIp3bBgKto9wVqXFNVcPWy3PubGtuLkKIJArJCQov2c
YqhW0RaojCmeXKIpMHVcNTJUHW9K1m4Mwt+iEDC+EW8vuCU6pdsl26XEJgHYOstw
+ltQakTYp+XlHNu9LEmoJ5ilKztZ+ZfeCz94iTzfBrNZ2D5W/eGg27+PFJJ3VWjT
YKMiaOAbgeJSpscFOjxwmqQSTnw5sGsPGte0XZVAY5yf9yn8B2vtds5PF3s6KD6b
OQeIZXbGWLjQewCh0fDV6LNgyc46LJTlKW6DvRLUBtE=
//pragma protect end_data_block
//pragma protect digest_block
a6WaDMUqYwnlNKG1Iab1OWAaf9E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
