
`ifndef GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_port_configuration;

/**
    svt_axi_ic_snoop_transaction class extends from the snoop transaction base
    class svt_axi_snoop_transaction. This class represents the snoop transaction
    at the interconnect slave ports, which are connected to the external master
    components. At the end of each snoop transaction on the Interconnect Slave
    port, the port monitor within the Interconnect Slave port provides object of
    type svt_axi_ic_snoop_transaction from its analysis port, in active and
    passive mode.
 */
class svt_axi_ic_snoop_transaction extends svt_axi_snoop_transaction;

  local int log_base_2_snoop_data_width;
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_ic_snoop_transaction)
  `endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_ic_snoop_transaction", "class" );
  `endif

 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  // **************************************************************************
  //       Valid Ranges Constraints
  // **************************************************************************

  /*

    Mainly covers the valid ranges with signals enabled for AXI_ACE. 
  */

  constraint ic_snoop_transaction_valid_ranges {

    solve snoop_xact_type before snoop_burst_length;
    solve snoop_burst_length before cdready_delay;

    // Address is within limits specified by 
    snoop_addr <= ((1 << `SVT_AXI_ACE_SNOOP_ADDR_WIDTH) - 1);
    
    // The snoop address, ACADDR, must to be aligned to the data transfer size, 
    // which is determined by the width of the snoop data bus in bytes
    if (snoop_xact_type != DVMMESSAGE) {
      snoop_addr == (snoop_addr >> log_base_2_snoop_data_width) << log_base_2_snoop_data_width;
    }
 
  
    if (snoop_xact_type == DVMCOMPLETE) {
      snoop_addr == 0;
      snoop_resp_datatransfer == 0;
      snoop_resp_error == 0;
      snoop_resp_passdirty == 0;
      snoop_resp_isshared == 0;
      snoop_resp_wasunique == 0;
    }

    if (snoop_xact_type == DVMMESSAGE && is_part_of_multipart_dvm_sequence==1'b0) {
      snoop_addr[1] == 1'b0;
      snoop_addr[3:2] != 2'b11;
    // D13.3.7 TLB Invalidate operations in DVM v8.4  (AMBA® AXI and ACE Protocol SpecificationARM IHI 0022H)
    if (!(port_cfg.sys_cfg.dvm_version == svt_axi_system_configuration::DVMV8_4 && snoop_addr[14:12]==3'b000 && snoop_addr[0] ==1'b1)) {
      snoop_addr[7] == 1'b0; }
    }

    if (snoop_xact_type == DVMMESSAGE && snoop_addr[14:12] == 3'h4) {
      snoop_resp_datatransfer == 0;
      snoop_resp_error == 0;
      snoop_resp_passdirty == 0;
      snoop_resp_isshared == 0;
      snoop_resp_wasunique == 0;
    }

    cdready_delay.size() == snoop_burst_length;

    (snoop_burst_length << log_base_2_snoop_data_width) == port_cfg.cache_line_size;

    if (port_cfg.dvm_enable != 1) {
      snoop_xact_type != DVMMESSAGE;
      snoop_xact_type != DVMCOMPLETE;
    }
    
  }

  // **************************************************************************
  //       Reasonable  Constraints
  // **************************************************************************
   constraint reasonable_no_multi_part_dvm {
    if (port_cfg.dvm_enable && (snoop_xact_type == DVMMESSAGE) && is_part_of_multipart_dvm_sequence==1'b0) 
         snoop_addr[0]==1'b0;
   }
  
  // ****************************************************************************
  //       Delay Reasonable Constraints
  // ****************************************************************************

  constraint reasonable_delays {
    acvalid_delay >= 0;
    acvalid_delay < 10;
    acwakeup_assert_delay >= `SVT_AXI_MIN_ACWAKEUP_ASSERT_DELAY;
    acwakeup_assert_delay <  `SVT_AXI_MAX_ACWAKEUP_ASSERT_DELAY;
    acwakeup_deassert_delay >= `SVT_AXI_MIN_ACWAKEUP_DEASSERT_DELAY;
    acwakeup_deassert_delay <  `SVT_AXI_MAX_ACWAKEUP_DEASSERT_DELAY;
    foreach (cdready_delay[i]) {
      cdready_delay[i] >= 0;
      cdready_delay[i] < 10;
    }
    crready_delay >= 0;
    crready_delay < 10;
  }
    
  constraint zero_delay {
    if (port_cfg.zero_delay_enable == 1) {
      acvalid_delay == 0;
      crready_delay == 0;
      foreach(cdready_delay[i]) {
        cdready_delay[i] ==0;
      }
    }
  }

`ifdef SVT_AXI_IC_SNOOP_TRANSACTION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, "test_constraintsX" constraints are not enabled in
   * svt_axi_ic_snoop_transaction. A test can enable them by defining the following macro
   * during the compile:
   *   SVT_AXI_IC_SNOOP_TRANSACTION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif


  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_ic_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_ic_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

  `else
  `svt_vmm_data_new(svt_axi_ic_snoop_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  `endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_ic_snoop_transaction)
  `svt_data_member_end(svt_axi_ic_snoop_transaction)


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
   * pre_randomize does the following
   * TBD
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize does the following
   * TBD
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

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

`ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_ic_snoop_transaction.
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
  
  /** 
   * Does a basic validation of this transaction object 
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M3pS06jQEPgzU+13aVP+MUWmHBE05SvFTGEJPGsmMV6ndQSqz80dVYNc30B7u4Sq
Q/jHnktVKlmW7Ol7hQq6pTCQblLeA6LQQA2uFVDUtilH/miEfTI2qpebiN+VjibG
vbbaEZR+EP8Iyw2DIi0U4Mtc2TpGYKvQPprlAhqleCA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 120       )
7lqtfaH0T+4LC4nYer71TgMccZJJry5DXJtexGbdWdXiDUzyrRdBmDsghYyD9qLN
Vhai5n7Q5jwhgkLg04xM2pfuysH4fs6XIFjAGes90CnFj1/f612iCr3zgSwqd5eG
JnVIWp0ku1hc64cOGGmKtlqTz8ADfMwHca//ucswQv0=
`pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_ic_snoop_transaction)      
  `endif 
endclass

/**
Utility methods definition of svt_axi_ic_snoop_transaction class
*/


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hAnfKO1R0YLbK1m5gYPmK7zmI7wjW9B6q53hh+0m3qokmveBg8a78hfMb3wCmZeE
aTuM2Pn1kl80Nl5Xp65ptWSs7hSeq0lTyVxwV9CvTXJeIIDCPznVgJSDJZZLyQxD
tpVESn4Cgc87KPA4sdYphJw54/8u37/23Ceo33wfeRc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1374      )
Adj98dZtGmu+9KHwfY+0HfZEzrmCx7bfnKknQu87cldOXudKqfIM/tsUwQeq6kru
HxTZtX8qinpnhk+Dm5VASgixvVtj5BZ7LkLAXIRAHBaNA7TlPyN5i2+eRVRXHa2/
nbVYx8uUcJvD+DnUg/s2dWMiUXmvugCfKze8s1+NtM/02CcXzayc6jXILXAXw6F0
JMOo0lqCVK0rg3W/KyHQ5rEBM/j83Uc+NohMu1o6SY6JvJVowXEvS7aDHyfTf9IV
huWJMl7LuWk8KEr40hVDIsnFSbyrVZ/HcnKxRUNJeLKjHjOp9TAPujNwppfq8IkV
FMf6Q/OUH5VQfbpxFNKAS9WeT4HJG5SxmF3suPu/p+zMq+h9BstxRaVHgKLvgVZb
oQHU8EH8EuBvjkwe5ehAIFCcF7wGv+z8bOL26K4t1W6RMUzQ1E/LjU+9fv7AJM2f
Ghq75zrG+oaAlRYHNAlJc6cVuOSuF0Axmzm8NNhaGPq6aC8kNFxGqqrn/g7cBi7J
J6pzixGc8sYomEOeHWUM8BMyFJuSPOWG0HkG518h0VcouCrW4j2DF5UamJlyBKnF
REyf9Tm+dGI/83QD+BbiVJhnCwMqiTJ4av6aebHQRd+phIANgrAuk2XKHNHEcmbi
tBDFB497lwnMTSWhSsY9yAtvuRug/sEyD+sYcK8firJVfItR+WOe+Mg15k+QbsEW
azrTbDVMmkwrKGThQT/fFudxl3X7nkQZGIUWT7NGfpRZfzFX9X0j0qHPjooWPS8y
oMsvS4tMTrt7KUXrhAuKGcCF0Brmp+SS0VRQEghfmRVEiG0CCLnG8udZkeSyDsMC
MaVXipcQ1Ob0MkRnVSLqLUD6Ob1wcy6/j9rf2NZLyH58oLYfDaXTpLvfXgPiXLDo
eUFb2oIQHfeoyEMMR4zHkbKVWUbHGa2FY2xmKfVW+L1iZwm6eXOi4ENVYJPKxAxm
U/qZg6wJv9/d2x89yeXL/izXXHMXZLGfl8AYcueRy2Lu2XxAvAvV+w2Ury1ney62
a/1VzSwWHXY0m1aOGy8kAhY+EwMBJeJbVY08WDTpniJvRnjVdK/M5ncP1Fg4gYlw
pjKYVDPr+/yiyOiJ9JXejKkvSFHw5XnUMKiAZy6fSDc3I6w5CQ4YUTXDJ6vUuabP
o58W5E10HJL2L+kMoFa05Rm7Icw4if09OV1i0XwA1KOlzmIuyCqWQcHwglCNaeTD
nSZuSQ2X4czsL441Fi0qxbJ4KkdmpKme77ndck1jGXbsnO/s1Gx++klV+xUhHpv3
kyUypsu0yWx5IzKX73klE/jav4iW4HioCNlONh9fBvhakiWASQnR/ymey4ddIgIY
CXXtB8dVtrZJwjOnz9SADEu8S9Hz5MEVO7dcOMFtKSdH17r83E8peuvukKq/dZdQ
AyDOGDeyX7nIPxU/bV6elyvBOiqGHBUkXU3tV6g1yYaAFJHft8c5FSxM+Jg/uK92
WKzTJGjaXIhR5qH1ZML201K9RpMX4BctdoV+eJ53ujRTfFeMwsnQbXZiftjDWn2M
f/WcExlBiEVRNmLu47eosLSDrdrkq1/n/XH47NxH+AnzN0GBHzf9noOKhit4Okrg
eO9w5j2SifDB8vILj8waZK/POcloFfO8zsCVIo/Sx6za2aG+RZ27C+mKOEaV3BxV
Jb1+dqMhplXM6gIvv6NPwg==
`pragma protect end_protected
    
// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::pre_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nOU964Za5ytE/u39tEq4UCYsXudCcjTsKmp4NvmeNOZOZwSun2Zri8lW4Feh+N9u
jK/UtAc7UpecyvwfgA2b1s3te6TiajqRQHKQZEXe9Q5VtjY/X/YxWg0wsmwCk5Fr
7eX38oqKiTd5ofyUz2Z2tIaopb1zZSgeCh0tfGkvUk0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1773      )
VXtSVsY7+w24yPz9zfDS4osqXlUx1QU2MxEidFw487t3fXaVXiHPXcsMtf/HSSH/
tX2fWFERJO0VZ6jjsSqP9FKxXtiToXnVa9TKapd5/SpQUeZNcy9kslBbvx1J1X09
kxKsw3aOMh3Spj25jNZzW7z2d8ZwGAyGwpTzbBTq1ahml1wuO+PkTPfi80OSSRLa
K+NzRHSOazqlX3+Y/D53PJPWTHPu0e1QEzSe8ECqa9QfIOeWmvEU01lSN5idA6Se
doTa8OLKaeCat5qeQaaRWIXcna/Bv8k6tdDdLTzJ8SIvAi+63vnMdukDWby5PYAJ
Ri8F6so2z5+kJJpNJ6kmzqAuz+JcE6YNXV5kv1618v3V019fh5JPg3zwe9yVZfGV
yim29aNmkZBakpnTD4ZQZzGAAJBkvjTLoSJdINnQPRrTYaeYJc3MCaM7Y/RoG7W0
6iaiVBS4EPWMhNWuQ9RQp3aexEk/ZvjlAid+ZJTSkQ2Xs4Y5UDrO8Q/M3C0gYKWC
cSsXJGDOme4ZGyTFGNSIBg==
`pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::post_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BCKGLz6xgQkRKDxDKzjMsLR5wpGQLhYPz5UpnJcp4vtdBr03dAn0Oe8OStlAjUGB
xjw5lR8PdMgaBzwJ3hoihJzTxuBn8JLc0oqYDWx+ElHow+UpgRYVIBBokLhDCndp
VRNKtEMb0UuHeqB2EZX6kBNQjU411A/l9tJH3D2uZ8Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1882      )
JP/VYxynsa4oXW3E7NdOa5tlPOR/1tA0NjVxmiatl7jzUS5tp7IoT6zyfz7BBpC+
sboS4G9IJ7NVUe1ABZNvwL4HM7y0z6wOfIns98cuXzHh9bvLwQbCROVM3w9QwsGh
xTSKc0I9hMJlCv4btYEHGA==
`pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JgL491rPJYNUKyaZgmwkyqSsK8iEel9sW6nF5jC/8NR6ZWicyVZQqtLxiQ7wPJU0
asciDznrB1784Zn5zVPKZ7ag61kpWfTboMVri2Z9b/k57914igfo9hdBtkQykc2K
n9GOvcluOUmO2vW7MxTOMHvZb/OBzpl0DT+4jFSrn/0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12195     )
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
`pragma protect end_protected
     
`ifdef SVT_UVM_TECHNOLOGY
   typedef uvm_tlm_fifo#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
`elsif SVT_OVM_TECHNOLOGY
   typedef tlm_fifo#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
`elsif SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
  `vmm_atomic_gen(svt_axi_ic_snoop_transaction, "VMM (Atomic) Generator for svt_axi_ic_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_ic_snoop_transaction, "VMM (Scenario) Generator for svt_axi_ic_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ECXwg8qeopHXoBgZZ4w3TMx62HbptBgtp7FhpXhSFxlY/9Bx2OyT1aoxWLr7sXOZ
qQ9qJO4wwIAGUwnbvdr2td0Ftvhh/UbDNpldXV2RrAWW1GZDNsfS5GMTHz4KhzPC
Gw92azIEFLQeGGfj4sHE3UeV/LLYNR91MHv2ZdXJORo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12278     )
CKWAT0o+BCh3FIlenAZpph2qNjF1pTP8ZNt1KWvYBenVqFYua+Uu2exHojnKftrr
dLic6tpvwvCV7qlIkxmwg28NseQNQXwEVaWMBAaAaBRHYMmx8bzFTLDgwQB3fxLY
`pragma protect end_protected
