
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Cm9IkOMSCy/rUq5S5nnPAS6lSQin3hpC904oIEiyYiUChz9YZfMW95O+cPz0cOsu
lGmdeJG+UHUwfuUP0OrZRysNtSdUHenip8vi3OVLBQDagQyK5cuhzbFLPgQdyA5r
sN48TIP+p6HkaWqrDuBn4XNUfXxd/sJ5QrnX9K3RRlZsh7i4Mm0VzA==
//pragma protect end_key_block
//pragma protect digest_block
//r3x6mwQJA/5kn3rbLt4cT3VhE=
//pragma protect end_digest_block
//pragma protect data_block
0lBtFat2xFk1UOdLBO5ecBNEESSRmJwkWM2E/oJzuXhQ9zklHq9RvZn8bUtjQujC
v/xvQFt5eGWH/dslxXqxtWS7XLQH07vx0hn3e1rGpEUSVpPxIrvFWROpsndwVny/
714IvAt1vhNSHf2qRcpd0bbbJBwmWJPaHj5z2u3xPbgnqWj1s7sv3an8WFad7L9K
D/uGFGmtsx/SLCMh4WbOWXIkZc6zqdtc7McGDYpRsBeqPFIIcDNHcNQm3pb5mkUF
A0+uUAJR9HHXdTPAo4nG3ECLFKuXGj6cZHhh8Z1NFLOs7b8nVLUeSpgrziNFhvGj
AMjwlNYBa1BcarnrVAgK7lvzL6OkxFwcPmTFwJp1amLepaVUoqlBCQhz0lIstL7q

//pragma protect end_data_block
//pragma protect digest_block
96RvBX7e+ey59AZ8hGuO/uPzgnw=
//pragma protect end_digest_block
//pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_ic_snoop_transaction)      
  `endif 
endclass

/**
Utility methods definition of svt_axi_ic_snoop_transaction class
*/


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YHGbABBl/YvCiNAGSvud3d4sB6Q4W3wwUR+3s10Q3hiDUmRnGMz/YvTclYz091MH
+1bizFSJanSm79ahnHjRCU2BojuiAltdWCj7fnbE+iAwkRuv4BYnOYvhEAj18Po9
9928ATaoEAhqSIt27KEoyByZX63qarxwM2NvpX4xtTqsB5+Ioh0XlQ==
//pragma protect end_key_block
//pragma protect digest_block
Z9T9e11kT1fiCuBG6Jy9LLIAb6M=
//pragma protect end_digest_block
//pragma protect data_block
zkFWl2zS7EW5s8JV6x8MvoKQ7l2VYYt06SAsDuISsrWbzis0HSAeXNx+HL5fGRaB
MSbNgdcda/16zaqt3W16itjTqFRSV9Nn3tforUXn/64DcrvYkXka3l8NkMIG9gbx
qwoSE1zkiw9Klq+kZWxbDndhmpmlcGxWCQvdx6wOpa1Q0dP3d8331ubvwgz1KW7h
RlQxn0M5OGRgDgRGgrVGISt3azIRnt9JYw4X1uGn7eiuF7ZL7FHCGddiIbM7h/1s
7ouI8bRUkK9PizZ/JnL1rS4+rJV3EuPK0/hwlZlR9t4RT6J72NU50wX2m0L9ZiSH
qhay82O9Klx4EL3Ld8s9cab8A+vYDCzsyLsbeKvgTBtZL5jaew5xvvZKhN4KQUd3
Yk+M8yy/n+mfm6rm/b+uqr4U5EeQ6Ts05X3ogd/C3sWuBklz7Dp7dhkdCqNZqoWC
CeQX1OGfNFvJmqJDGM7hd42Hpex1Tq+flx4KlCIkEJPMYhNQxwXglm3WQZ0mUdXJ
YsrShuSUnIf5DGwpVwOu+nxK6bNNRjMuHYgTMvhKNboSZWkz/3g/tUsLXsJGUBVe
zmBV39OH1+U//IwsKh4s9MYDWWBNDQQtzlIBaDFi2uEUEMEPDySIhNF1lY0RA8Pc
FoDd6/GrKirFMFfPNdMCMwKbQeNUBYDrDx7XPK39A/t9FUQVw5dRoOLhTKQQduep
2OxZ9cvqnUT4tPg3Yg+3v6Is+/ZUxh7uS3nB/qgYURi6pItaKSC42bTHhA042YnO
FOQaTm3TlzjGpX7dBnh+LIFB9uVAwWGamEi9965jOXXxnI8/7VHT4C9OdAI+Y/uK
HZeSSA5U42+8dxxq64O5qGVtHoCRwz10wAic/sF1f52rh6YSXlfGHjc6hxIjtseZ
UkYaX+chq1amXyq/ZqXaG7LwJQaC6pBti8uF9Sd5OzL6BD/os0EbBjAuu6cE2/Me
KfIVPQ5efTdY1OQGbyz+66nbTeXvzPZGFz6F5evqxwXLzq0QsLbpI5VwTXch1gej
fPDjiHgiJJqOkxo8LV9B+bg26++bSnlreSKku+1gnxh+B1HbEyuNTRKYWBXlz9kw
II5k6UG7dWEP0jAZFOerClylfvxzUqPrWTdBCcFnIFDZXUwVKuKphRd1ova42B7d
dyWB2AaKvlamYdpYyR1bZT9S/7o2WO0nI0pWHAFui46/5HC/u6V4jKyUtByT6+0R
jno0nYcBs1+YZxhGzJhMCuGMF7BfouOcfEW5neJ2IGJ1ClDK/gFebod/HYvcLRR2
uCq3vmDp5kme7t++HOY6WU3tptvsXFihLLKxG81bagNA/Xcz8gc8Ja7HAw7kbP+Q
LVsuEcbCYRgK43ngDzuYN0VZ9ONHiVhQvrvawayOdaR+ScTv9cFOlQJ7woAVa5qR
9VOjGFmcLw8xizEMZVyw24gbzKeG9f/4j2TPtTdJajsn/WWF7Cof16TqElj1GBay
2CT1vAu+CfCJV8BFQL+nBbsFAklmVhOocDIfHY4lOVQPhW8AtBItAHbPruJbLjM5
MqPEpVAk3aSHXuzhO56e2wSSk6uQvum2uWzJwlxdgqsp13aZdzRa8T8X19j8PKpp
Cj+5dhTkQSWfSm78mnGZiarfksmF76U+pKcMvDd56SZz26O/Kf9e3umTZF9GhFMi
QCFELqEHvojLdctRUfP8JR/J0YpSsnAcJnX3IkffRuDSZNZxP3tXgMIXyjny/4ZM
vl4cbyXpYVQhg1E9IZVtxsAdA15yN/Ea8ORjs14F/Xc8VVzem5Pj01++CWei/JYi
+V531VHrNLMDYMtJeBDS+6uLm+ddEV+s4TDb0Lj5B895K2TpPIeYvrEjLMocx+n0
YrKugdcAILejX5mmGc4Sxh/7GhDaoqKuVFIht+i4JEM=
//pragma protect end_data_block
//pragma protect digest_block
zVo6J8gT5J9LzbibiZjiyUxgVCE=
//pragma protect end_digest_block
//pragma protect end_protected
    
// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::pre_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Klw7gu2OcA7Si4n3/HMhMgl9fyeKC21YXuesSw1NABVZ34u4ekTHsnbPHo+IU3+1
EC6Zie/i8ceBuOfze4DWPDHFAzunHDrYZ5/pKSJavBzLThMtj8En6XG0bG1uMT/6
CVgVo9mIDj2Ejxm6LjxNzIXJRKMOcIM9qxxk/+59Xke9+nLFLQDbjQ==
//pragma protect end_key_block
//pragma protect digest_block
x+ZeQUF799Fseqm6IOtXYkgzMR4=
//pragma protect end_digest_block
//pragma protect data_block
ww7HuO/fRzfvyDG8G22ZDF4whiWLOHyPuJoEH6AmH82Z6LgLvH3G+vuW7OqIu3GC
iq1alU7DRfmzrgXyGdmOrFyH6R9XegUBGedmbitYdR0jcrvhpi/eGvjCLIWSbop5
5ZWCBw3t2/LCj32J3XTvjok3lVIlHRpUJxHXgeZfX8uHfdXTPo8nBm+jF8zPNSI5
Xg5mnDpmKq9O6tChRCNarSRpWyyh0Zm6hD3l07lm3J3oWWhUsYkgMcXXjo01WR+y
zxQLnBJVRratomLr3fybL9AvAY14qEp6tHXZ6hKe5BF7vgqyXqi8UUpr0Sdtjvga
yAVuCNW1f4fXDZukN6BR3UP2cLiWbEABnSv7sZC7Of18rRISjT4AY/wLMUaMtQTg
ghS2sKTQWtDdD3oPkzbL+SQZLi6u1KWYAVQjdA83r/ndZTn27hh3dY0sGkmPTwW+
2VZUisPoWlhVWqZXwQpt8mfhiZ703N+2B3tCiJHE1SVS5lHSO4JRxdwyv2aylZIW
leJfzH3+0XO19jqu+VRJIuWkJl8juBn84b1LI+IGYY6xxDIrCa/+6Q1kDtZgPWLm
BMo4FIsg6f8ZrL3Fwo8BS35jtD/KZ/Mt73tpMM8CUDLSejxae8qYjkaCpcqBIUsO
+SRRelXX/DIN/+UjO2/DzeaarCUR0kjpcrEVdRGN2iJzeayAwtO3h0myy7crhlvs
xEClUoUff3jbbQBKw5I7f0JZDTFAFKi0EPd4Hm1vEm8iWqViRGLh6fjQh3eMSdEM

//pragma protect end_data_block
//pragma protect digest_block
CEYoFSS/oBG8QtumKxwi1bBhDXI=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::post_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
vVpwDP076fMB1FF7mPOFaYu7KL2OpDaQJTQ5ydF1JbJ6hho+e6Q5hEJoiN8+ZHbm
ke/FjnueHtJKXK0n91V/cnOe5cdLq1NAuNYrwwdpoq68qX1Uu+M8R+Ghl09eUL1e
ikxcSFq8pofiPrttGpXHw8Z0pTImjR1nY51qoOcqdDN4kNvc7fMIwA==
//pragma protect end_key_block
//pragma protect digest_block
MlvIukZhiH6fxO0t3OdFhR1LRqI=
//pragma protect end_digest_block
//pragma protect data_block
VWcKzmJUf+WHQwSVjI47YkX4wBeASln0BAwJMo4b+Tgmi0+ZtJJZhrMTfpfRmzoy
vbH6ctMrwWysyD4UK8bM4ucZYAn36IlXgn13Jb2JCikjw6XQL695x0A5IUHVHUjx
FV+5aP2CwNwnqUs05tmnchMEXVLgyXJAReFZsi2CoaA1ZfaznJsHh4JBAno6YjEr
ArbHaLVd/59tOX+Paho67LM8CEBPo3pyphZCyEeb90N+hjKv3GZgTTkrDuQ2uG+M
c81aSGB+30yriRdS5yKFlEyHr/9tLoKjkXAxtET9vUADGpgpVL0LP0JLrbKUAkhZ
lU2DCnvxer2xN0Zzs8xJsN7wHPMJIqv6tQBKVMPIShN4Dda5B0LriFJMmxDJX53q

//pragma protect end_data_block
//pragma protect digest_block
rwL6xW/JbOS+la8WxeyNNlQiEgw=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
a/T1BuT+5RhGEWO92UD8bkY5LAc3RGlluvF1aVCCFMpW3k9trrIIgX3GV1LhdlEC
/2LeK2ElmV5TYqLJa5onk9YKuR73nicX43LsVvE48PbIZnR+cGbyslP051mjzK9n
HJ4JE9RWEL9oEYUMdLHWPunHMVI9yh8PP4krFcP+7Pq6AOwdnhT1nQ==
//pragma protect end_key_block
//pragma protect digest_block
ZOqiehpv1RHnE7Gnv/v27OayfyM=
//pragma protect end_digest_block
//pragma protect data_block
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
W32PHXBbth7odLzPLshD2Q==
//pragma protect end_data_block
//pragma protect digest_block
lUtSwKT145wnBBYmXBCrC2p00Oc=
//pragma protect end_digest_block
//pragma protect end_protected
     
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
