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

`ifndef GUARD_SVT_CHI_HN_ADDR_RANGE_SV
`define GUARD_SVT_CHI_HN_ADDR_RANGE_SV

`include "svt_chi_defines.svi"
  
/**
  * Defines a range of address identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_chi_hn_addr_range extends `SVT_DATA_TYPE; 

  /** @cond PRIVATE */
  /**
    * Starting address of address range.
    *
    */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr;

  /**
    * Ending address of address range.
    */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr;

  /**
    * The hn to which this address is associated.
    * <b>min val:</b> 0
    * <b>max val:</b> `SVT_CHI_MAX_NUM_HNS-1
    */
  int hn_idx;

  /**
    * If this address range overlaps with another hn and if
    * allow_hns_with_overlapping_addr is set in
    * svt_chi_system_configuration, it is specified in this array. User need
    * not specify it explicitly, this is set when the set_addr_range of the
    * svt_chi_system_configuration is called and an overlapping address is
    * detected.
    */
  int overlapped_addr_hn_nodes[];
 
   /** @endcond */

  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_hn_addr_range");
  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_hn_addr_range");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_chi_hn_addr_range)
  extern function new (vmm_log log = null);
`endif

  /*
   * Checks if the given address is within the address range
   * as defined by #start_addr and #end_addr of this class.
   * Returns 1 when chk_addr is within range, otherwise returns 0.
   * @param chk_addr Address to be checked. 
   */
  //extern function integer is_in_range(bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] chk_addr);

  /*
   * Checks if the address range of this class overlaps with the 
   * address range as specified by start_addr and end_addr 
   * provided by the function.
   * The function returns 1 if the addresses overlap. 
   * Otherwise it returns 0.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_overlap(
  //  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr);
    
  /*
   * Checks if the start and end address matches the member 
   * value of start_addr and end_addr. 
   * Returns 1 for a match, zero if there is no match.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_match(
  //  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  /**
    * Checks if the address range of this instance is specified as the address range 
    * of the given hn node. 
    * @param node_id The hn node number 
    * @return Returns 1 if the address range of this instance matches with that of node_id,
    *         else returns 0.
    */
  extern function bit is_hn_in_range(int node_id);

  /**
    * Returns a string with all the hn nodes which have the address range of this 
    * instance
    */
  extern function string get_hn_nodes_str();
  /** @endcond */

  //----------------------------------------------------------------------------


`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */

  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern do_allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_chi_hn_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(hn_idx ,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(overlapped_addr_hn_nodes,   `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_chi_hn_addr_range)

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JpRe9ElpgWGzhol+ha5bm14277TSTiZIxWEpS4tFQchQlHLIEAtMvfND0TsRViM+
yH4J0buacowOKa/yCloQBJG+7k2MM1XCsucWgaY9Qp0uAvr80FVPWkR/6+DYkpsJ
GtPkDUdh1A9TelYhrT4Lc21DyrZClZRZY1/0X3MTA14=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 614       )
fC3dwAJJjk2TjRtHKnC9zsZnjlpRgw++wKWIB6AMmVPvYHXnHJMcxyPgvGbtjZH8
FMfURcvREF2TXG8i4lt/pnYOK+7FRd3tOf56MiESkTpYlOQCJsW7abLAf6j5rTpa
YORjJhlrqe+3rck2Ux3bO/kmUiMTpJ7/hHPoOU9vwHYlRvQzr/nbv/39rPQ65WGE
R1X50akDxshc3oRH96mS4lED6t56SL4DaTgfUQ0OKqk+KBhTwoL5YWFH1VbAFbEP
QNXw7beaJFfCFNKjkRb7fbfHwCRrGnbBRcBxnsKmFkTZ23nkE37mhJhOWcA1bXq9
BG1E4JUIm3mdArtsxuPlbo9CsGHtogrG9itRgpmZwb2uvxtVhLYqF+ujNz3titEF
T+lwo29S4II6qoM1YhlnFTfduJGtqGurB+6YQm3T7B2gK38/GjI3hGcEM3Q0C5vl
37XQ+9OboTMVWky764RaSKbhy4cyXnR98noIQDA0lx0YFsdJThtZB4ndKsb/kvEo
Ht4lLPXOCiduN3hOXBiuYngYfSQwEjvIUSnNc9Qs7cOVA++7JS5t2nQPbXYBWUEx
gHKF8CQqwmzuRjGO8CpTrRLEv4nIx/rCNekglcuHnLhtscULelfW2jpwyN0PYBQG
GsdAbLNYx0GaSY6IrucjMTPe9dWTaC60dDcckUuExWKEd6dydTgho40qSDdFEv/V
hBIdxvKb+RvR2rurhz1rwKQ/AtsIa0ufoPzpezQiwAhzjquNbgZEpSsD6oArkheu
UQd6HXiRVYvMhq6p/7nkyJFmD8s25OeAb/MRrUfAn1I6a0PstcvVD6z4Co3YcKPE
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JuZSs/jq5CHbJG8lKIPDFHLyPZ7q2nefR3oUzmDxIDTR80gwRhb7kEYMFVm83dU/
KMKFJcIX07aDDs0AfiRYIHgiXmVinrsT1SKJY5RgCMlxzgBPc0utUQFiWdg1s6vt
iw768fy9Vkbkd2YGT+6/7NdKZA2nsNFYXDcDILKiwjM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11294     )
Pmi6GYMD+FwxYNo6ospWWF6YRQQugeJe94xyCFYV3srzxoSFUgRZfFDYJmB5nCkX
bBsJcWy6JEi9nuHqe7VTG7nriQ9ulM4iPBTmkUqp++ww6jWhlyAW50w9syQ8RkaR
hVsF2Cd0/PGXir2fkUgv9BoITH18ZTf/nBgxRPLm3WX3BrvE7bwjLfh33+D77F+b
pliQuPNN9LKJUR/h76hWqDqEgMjpaKR/7GdsOSgJFKhn7PTfk4jhqMeu3R4IRQfg
QOwGBEOZQ1x1+pyedwH57BJhhnRvAOEoo6mh/vMwmMQUjg7EYVJxU7Lx3riUmpti
VhKhVxnErxFFCK58Fd5GJCyeRlqzH3BsCw93aTleQP7zErr/7nb//xuODfz8PD1r
dmz5kBfVgaTwbZqE6vltvWn+JDikWBpO7dtuTDgN25LeEmpNFzkIl7i33Dl79WJO
wc55bsjx0GbAm/NLkKFsBsDaV0KcYqS3YpZLA027M1dUMXj2Z0/+VqaJbEPth1Ya
7TV6X+w8WJUN6r+bh55t1wM9VMZX8nrVVn6IkWiZbpl0CHo6iPjaF5lo2rQkU9q9
0r/myPXAT1ACx+vA4tsA1DE1CxMrb14q1wF/yQiOs5qlk8SnYj7SyLMweLNiA7E/
nEifdP//HPkjolGpAwWt2NoUgSJ6LDZIcPjSJDJS9PLz3CzXQ+xs40Xh4eHXz8St
HlraNWsXLYpPjjpf2TOMQOvIX6nY4vTU5+m9HzrGhLhBfPoL85ks/Ck8I7ogdg0d
hNIKVav6MCe6Pjhj6kdr1VQEiVjQ66ebbQKPcoSuuH+lz/MxVQmxrcKHjVdbwwAj
tHo3zazIwBi/eOIiH3ev/OPXgw5SJZ6ijkQNiXshttkdvu8SJk2Sbd5NKmj41CAO
UeD0igVSY/PBVS+wQhLhZ/n+frMyzn8358Gm0/TwqjlK6t5Qx/RNRCAlpL9fFYxZ
yLCUq6ELScrlwNe8N2o984bC5zTM6QiiUjVru6W09ryvJtvHSaeCV9Si8IhSfDXc
ipLsUogJuPSb0ajEn6J3oTxGTXPZVoRxkDhzj0Pvf+4zUDHY6OyD079wHmfSaYRO
CdUOKT6ePMahHZwgHOTyik7/WKSrL3rAlAg0HkqNqEPXj5UaMNkpUceWtlwVQEPc
4yCWZB4Z4ZrtuwiAswlzeB06tBREkkd/xHwq5kMuwSY1Nnnvenf7GhLC0NjjaMlX
/QHNxxW61Yexqd4mcFqxk6JvoTEkRredUvVCJBCftOiIjScG/Nb4Du8NrcfNwBdg
42wukgUlbIOimLI91OBs94gf7XU7AxC3uZWE9e5pS07+vbXygl1zl9/+0h3c9Ej9
6uFkzBigtmd3ldLetBnrYA8SQwjLH5giphq3qSDuheknyheFwhFDY5SKAdaWi9ts
N9IcWfBD3xFjOKZE54RtAnolUZvAwVPmP6fhoq0TJoE0Fzy9/xBhxdwxeufHAkXV
1B+g/hU9S061ji/GmvJTrjj9ovtBpWIWpgRR1dxvF1NytR2xGL0W+CM4ZJ5Jupt5
LQ0BlyKFf3EnVO/1yX+H7SMWKkX+Bcksj++1c4qm4jyTg85SNuaB24ChFJfeFbue
eDQ8Yk5Tl6eIXJJutvwty3mLCKiV4XwkeMtsvnhVagdnppccu5/9V2lRVudYxA5x
7AO3i9uH+Y3PSG9UoIt0EEsZxhqSCiihbigwAt1znxYsCPA7pGzpK5Nt0RxGD8MP
ZKd4wdryAcXVdCnqI+gQtXVOtRlhIq4J3xMu5Wb5jQbXz3++KjfuJLUvptEzV54p
o1uSpv7AAhkEAaRodLjSr8G51e+v8zhEgsdZOXoJC3RTWTEQBgnJHHdsKxF+MBmt
qPDf3TLVXJM9JAI3p2X+rvKj6NSuNH4Zh5CtrS14pAA30CldwpZtnnp23NOvPdnC
5K0TkACEEu/N8CwvAWrd77wCS5/lqo9pV2nH1SgHfSM9u3RUDc5x2skCPbZQJ7yD
EtZ7P3rGiBnSW9n3HnXe1D0o0sTicRolu6xkje24eI66qReKkWZNruUE6Dat2MgA
MGg0gmCk+kA46rnuuBmU7/7d+WtLzJCB2mgDZUPbeanXET/YJYTh5gnG2Z0SgO0L
hk6YOiaPv6pOvGT9nAosq+zg12S3folk4sM895ViwUc04vvNQb5WQdgWyVr1G+mh
nE4kifLwGdm/95pHwsCVqhGz+pEw1tqBzLT2268GFf6KdepfK9amUOWAlujkQhB0
dsHYbMa1/7yDnc9lgJuCuT2KyZPKOUhIVVAfN14LDvVDGjgNN3pmMp95f69hzZVR
ZYeetOwUwDTrLGHJkGurtta0hlFcxCTioeK+YJtHmLKgOHAW785V9/ORrdixs40w
SEAukBRa6nwgibZRDj0DPFuVr3PwtV/HQ6Zq08XvAsNbdJI259xU4I6dUDC/yYm3
B6GeBnlSohQCHGggU2Xl17+UxbIisa2tlS73MdI6S5QuM5Gzz3nbEw2eJQIUEH5c
JOpy9m961253eAHAXqh6tREwHa9fbSp65Z2yLAeIGtyhbuNjwT4eYKTu7EwP65ce
vVZXLoTve7kRNzXwo7qmwMlwYjeC3GncBGaXxnqq96moqRMBMaAWEBJVNnp69inp
dM2cwAepsdsRQeZjVMbySb8UZYUrN1Mx76Ljw+GDot7vluXsVAFZTJNDXgFFcwzJ
VtipLl1u25BYCP5orhnZwGvFDB4WR9buKuIsrp0+zxa39PnztrqFrU1lj7z+3vE/
jYdrAxtjXUu8wpiZF358ZZGl/14HsudqFVJPOyPqLSW4iATtu1pqIYl1IoXtEmSy
EaoN6fC12b+1TYu63E4AHHoofFL8hJyM6OeQUKXNiEnk6iN42yzjNAih7fNydJcp
GkBL57yPuSusab5QlO5JkXNVcTTudJp7QonsO15k9AjSNdir7GDMJWy9TqRi8/JG
Hvy8Hqe3oRejuTn/tawCns0EiTahW9qXU1yQ762ZQocqazCOW1/dgflbRdwOqndK
SEQSCGa0v3I8GlCg5EmgaeIJ7+qQnIYMaoE5XrmcJsnFeDMY9OQlLkc5fXdQH99U
fm55cD/DY5AbrzcmKvFIrxtkN0D7Ww8hZLCjBfTuZrZU2KbIdgi+ODTqKFfXvGJ6
qmE2h0Qs6SMhbU/SDexN1+/QMijt3Qhaj8Ag7fTTQt6PG/tLed4MQhj2q1rBso4J
g4rdsAaYWgtmoisSrATCY2r3cpESGLYBEddulh9kltNmtNTN/mehDSi7CAJc2V6v
05x5y2aVeLJrW4LJNJ/9dfVb0Ns5dKWjwqw4b7uQ/My/osse9venu+7uqBDll6rs
07PgT/hO42b0AlnoZF9Quet4vY3FT2Y2pqZXuYJ/ky1ubsv1An/DoY2a8Enoka1y
aVziTjwTtXptkIscCOn8icDE778EBK0jXboSiEWoHkYeE2O1lg1aTgUa7Gx4303+
qpmpaqJ9xb+oVtqnhbMg5ypkgYiVHS0+mOtwFHZ/lhNd7hqOv9A7+oNMykB3WzHP
G6U35N9cP/YznSb4L89HIh1sS+W+RV07rJ88NQLrVfrSGECyqqcqK1PdaIOWngeS
2bThtuNK2zJRXOqUG2Du7sVxzcAwWSLqoWFw4+v+qnsoE7StxdJn84EfO0HgV0bH
+sN4DBln2XoUG8lMGTEaYPpe/Apv1YFxROMYzRrKjvwsFzaR7BLxOOhL4ZU9XVgN
7M72fyZvPjDjpPDsOuotbKR+tR/eolcbKPagEN7WMsLSy9u560EgJ/ufpRjit4MQ
YcvJ5oW1EOjUjZi3+Bzgnuz8KpuAyzs8+eCJN3kI/jrjUrWVhII1caDDLHtvj1lM
btsx0+8ekaQpqXw/+o8DaGn0x2gR4nlMqK3CB2JDqSqynw2d94Rf4O9U0l7Udl5q
Hr4GiHh08vlFOjqgNMkkZBImbqw7uZ/b9LcZtkZgAG7x6H5L8w6WnAO6cA0Lc/UN
0boGsbnCz6O+UvmpJLQS7u4fCcfvghQauD7gQ1kv/jdHB8heQ3JzuQjTb88bE8pG
GmDGI53Rxbj/LVHIxBriaqwi8kSkQMW5JQly8gVCkaURspTxFCXfuGOVawHfZThJ
KIEkCGrZneBfR3xJvc5B5fNORiRDmWWQ5ijgYRKhjzbdI+4gmEmzQDgRdtLrURFb
PRqZwa8VKyLFLvG2J87j2HPOsiai5/YJ8LvVQJbWAhS4FhdhVGHHzsz57/obHjwH
2ad+eLYP3AK03lCDcS3B6IAxSMKl9ZIH720DG5e8JU3Dz4UWdKJ3Wef4JWYfWxqz
alxMCCkGouiztIQFQf7MIfgx/o4f5P5s9LGz5o8e0NDTrfUs8GQqviHQADo3UCjr
a+wq7zRJE2+Cn4FSWMczc5+tRehkqZUtcype16tH/f/7NEP5ZTuNtc1evHZJ2UtW
S8oQfUd8kU5duT6r/h0AQUqqOSFX2Lzxu3P5P1WTp9qgMurN+2TaBEjgN8/pmPRA
rIAthRomAzqXjVmHqSYbUxaBIGNqXe8Eok7DZredhgBfrBnQC/1sm9oYFM92ybnf
IQNxrn4hITCIjR+A1Da7YXvcbfkxy3hXLhdwv1acvt3zAwFuA2Os/Oh0iOLe4qx2
83MFT0yycjFWUXsKx5iHK7dg6PIhk2xPN6bfgJ9aiSxwKS1eRDv1+TlB1n5Xo0q9
qqV8WFnT7XU9V2JtQROvEs+lcZD1kKv3Xn6NX0AeOLU3Cx1OuhtJPHKaczF3+i0+
CEMmZWKo/fxHzSduer0TuQggnM1lNu/74lkgXfbFYugXIzWnNrJ5brxjdTZTZ0yf
zPmnLmU+wazGMkkIYYp12OK4xuYxxQuqGNjF1ck+VJqRiW3ORnKhiEiM6VNVWkrR
IIvX7EtBUpltFSUZbwVJfasF6BSEK6Qf/PDxmb1BWv23eQJKUqAKTiMNsX8dBX6h
kKaIAX8dj9s15egfIIdKGnUyDz1n4u0s/cedNTXLE/49lFmirniJHRMgOBNjN0YM
7u72oOaXtwuJSVISJ+swnP6PwknCxbvY+bcAKZymuPuCSgp9JHj/5jTa67GULWP8
2sIWdOI9lsFaRzSoqwnes8FrIE2gRq8p/muZ4C0X94GArYQKx7aPMKq5EijPHJbL
Tqa1+rbr4/zWH3khZKv45unSp9SdSPWI3XO57VD7q6C4jPWVoT/3wl3dBGhCmQOT
jk4ubw79GlFXRExeBm1q/bEWqZ23kW8bL0QI6hZxiUz48bhGVOS/gIIwBOC1vPG5
Cl4VoeJjjCrsdcTgGXpcdI6TWbOm2ejogn7jMqpXIDJovTFdyO/E7NnuXdgKULsU
F7IGb3neTKyd+HAkq2A8twmzKr6AYZqJs2/umWhID9Dn3RXOcl2uXdgf0vo9Rd/E
QIdip2LHrivSKfaRLKHQm5RckFipUVzl/xH7z2zhFzJmuzEIsOSOvZn2tTCkqeo2
dqSCpD9XxC96/PKti9Pcmu9NWEoSYshUMRMypPoGQahmkyfEaZS/xFSFH0eMiuY6
h2vxUTdEWhPgT9o+VGPqlApFLesC3n9SeCXSfbw4t+URcWmky+kYyBxcEc5DFyL6
ngqP/Q/ktcA+uSTBO9d9GcGNQ4SOr+imsvbvTEHkwmYGyqgXR8IzJgkzaEX6Nmk2
OW36iQluJixH06QQ5zkaaCNX2vfjvnqvHyL/+WRq8ZGT00+SaMCJFcVmOXIC0xXR
Y3lOPv+ppchTOzfOF5jK/KSJXGtXGZhHwYckiHBhzv+tDldUHwszDWoyAVNd3Ic2
mk9JDkFLWfqTdWOFgHZMI3evE1n4KQnoyC/gglETbh+1VKAoKFZG9BB4UcLyb+jU
Domjp2NzHPFxPtuQV3j1v0FxPSkOLBhtwBM+8VfmiT/a2rPDdwUS2lAmbFMw7JmY
wJYhhwWeJhnZ0aOQ7tV8K6k5VqZO7z9Pow0NrnkbDydtMXrLotaIEsb6dGefQaIy
9oNSzbTW6OX3PcTzwAmSaoUkjZ+gUsMBhf4sLZ3oOFDl4pEirJ6XQyZYpD0byRSY
LUqzfKKWTMjbutcvzSRCfp1Ot6G2jDLAZWSerTUZ4ZVTPTSOZVYJ3VN0zZcGP+gp
nI/Gq9ik3I+2Wp9Q+EosNFT9PI2LAssGESU+ybjyxD1VS3NCmB692fAjea8HkPP0
RswlbHu6VKGhfPBHTRwYddovT/RLgnLgCm8nKQ1DNZgiim6JFwEP2Jbru3K2ig59
6mcA4vjkThnVzGqLGZCdrc+4sk6XC0BSjDsDmqsKDSGItv8BQBk/l7y8EmMvyTAJ
sWEoOi0IHgJr0W0vAo4KZbshf562cpl7OFTbDHvR7io+6zaoUhGxaSJ4fFrNKOs4
8/hR/pZQzkaFuj0jwQ66oXonpNS14mfmblFbBAZ/duzWEHzcMhcieQTHjvtTcIJb
XvR28xpaYPmLK0ljC8zCHrpzcwNbvslNTtI6i+k5VyNdkUh60CIDh8x4iFN2ap7E
dwxnp6gaHLbRSNoP0q/v7GVys3/2vng/rqC3lmpGp73nkK1gJJe9MFzDteI2Gw/P
MtA4C4qsTwNEPzTV2WN8lbjB1q2q0XfdW13E+N0KihGu80OpyfdmrnKXdAVlHvdO
V+vBvsX9BUuT+tCaMKtarfWTTpJ18FRI9NcLVfFlk7tuRu90aV92llqooGfTZ1Ru
6XL73goCpQAHfId1XBsR4c83qhnqiD+JqbjNRTSyAk9aK3gQbFcwptisSXkczM0U
moQ7HYl3P8K7eJYl0TvikcskdVMIdHGJh7i9WhnubTkDrbRNxc3UlORl0vEUsWMT
PkfuKINE/UtB4x/9LDhiUQMewGDvi84BicaOknpATtvHU3cVJ5dX60LvDv92GilG
bl0b6UxrW2/+VwQmkQ7HK/rnYS3Yz5GEzrUctd0ESbUtQoe611vgCUf5WS2Mp50x
U/893IZqdiiIlZTHsFfAfrjgbeRWfFh/vxUHRFpnS1xdHBXEZ3KoS6ssZX6nGili
IYI55hRSDjePluVgnX+1DbKRzZeQzTO9f+rlBjC8GenBbvsIvTJYvI3WO1uDIhhF
bbw1eGRobB1S0plYdSSXn3PdcfE/hKOoBHIruH6Uppb9ruA11slWWqNfhup9WVRo
N9DJWsxfGrnEtAb9T2Is7GKTKukFzgEfzWm1Fo35ZOjFTR5tto6bmnaTYMXnQBxu
y9dRNxA/L1UF39YSuELq/fTWOs/tYCHm2oAWayj4nYFvZVnaqSA9yXVfc4Vqcldj
wIgnT3vNYsEp0ZdjIoFvu+g1Av5xrbWvhpfxkNN8trQASQqXpTYtJ7jkeBHXluiM
TqemPv20hmDLxmVDJDbwM15hPeln081VeHVnJAzJy6sag7Is0IhlWz1rpLGrcRaC
99D0OjNdapYUfEJlGcfMyLz/fTUgPYVfoK4vLmaezP0ohpgWKPfvTB+KCPRTAMOZ
1Xwzx08J306MMjaza5PUoHlFPtWglzBBAot+o73LSMZRBJ2uj+lyXU0FaqNW23ck
uMlj65Mqgp8r2mkE4LIahdOgiKgrBW1KoFj53IcKBQ/0Qq1W32yf1M6/W2FHgSr+
D2XezVirT3RvzcmqTAdVMmZ/3Fi7jk6V1PUKrsnqCKWh0thXsObW1Gx50O3u0pDL
T+RIPgYOZfn788Ha/D8XIAxxrg9eYSZcNnF4gXJ2K9QixBcdaLsvMcpWhXVggUhC
Wb4zPclrIO87UligvK9U9uVsa3ya6pg1HMWQjsght+2EXpMULKQUpzU2BFPvAUuT
NEa/nrTXfP/DSvrMMp7nwffZRKMvIP1pz72zLwXTifNrOGbBuRpHe1Wm5mTj2Wyg
0AHeL7TJQ3hF2d+6oS9iHf6CZ/JEpnluOfHG1T1xqwjEYxeHu6xQftpuNhbwI1vk
CjI3GJQjNvrwo3wiCkghNAkFUvIgl0YHNvdAiQsT4meCfwe+3z0ALDGwvWQ0/B7U
t2mXjSsfrUnLtBMMwk7e5d+hneGHbgfwkvcvl/zFjz+Jm7XDuhZU/UkVNg+RubgT
oR1LjntDAoO2lCBWPQGFdUJhittc4P8LhH8o18a7hl6L08Q0FZ/ssTY1Y7hYCs8r
uyZqn714BeFUOk7cB/14ykOLbAKIZGMxAIRQSClRy7koI2NPqwQnNXeUZk/wfCSs
o1HYhI1xhIKsz33axttYcSiQYV+4nNicz0LR9FhnDEXuNrEsAb1QXNBnEZmAnKkq
YxAgzI3bD16dLe5dG31tVnwzwBtJJjJonR5HdYPO2/27UoJzq0RIGx2QI+2UKuq/
i7nEJ7eaASOk7fi/PN90XK2fS3jem4xmUOzyYiqiv2b8M7F9IaVu6FqqbKUOK1io
Xi/SrzBkucId9+md7C37Lq3dY6nrx7LusXeLPu8GR7Zgwe7fL4RAk90kFkJZbWjE
kqql4GDGmhDwBuVbnO4FwVEeUTwMmTXitFFteMcaudCr3qH7V8suNEfWR/nyr77N
I6CmpQjiBkhGPyU75byCYq/tTW0frE0z96vxhTA2QhdvDqBCsUGit3l6IgwEFrGD
U0xxAF26kRnJJa8rRwVPDGK0I4VsPNhZqU6cJAH2E249+tYM+6UQyPRW8fHpI5iy
s4tmdng1MtTHhome+WrKJRUHk/5Y2iDGnMTuYbFeO6J6Qmcnv9TrlIg2zhUTKgRD
UxsyGdMV+ZvXS5S/o9jk71x6I482ekA3HcfJDzX0Ot1BWZVCzt6AW4nhbl4ooYZ/
qTH3bbYU+KmX/L4ZBlQ3C/ejz9z+HRXr/cdceEzsh7wiMSzH0QnvAPF1boygP7a1
+DpGuYyqLQob0dyh53P4FNsks2mSf3TzwE1gheuldnJxE465MmNprH6+Uz6nMSPn
REPPPoLUgGeeFcgVcVa7Y8ft9nzt9LZ37uWFZyOOybLlMwKH4s3L9q+RLVzLTJFc
ky1ILQWnMHQKffvSEQEVlWvOfqgcW+yndoaNbdx+bDcZ0CbiKJT0Qxqr1S0A7jV4
lz/HJRe/xITloFk+FkvvJc5R9OQjeYb5XeOPq3ikA240hfsN7j3FPgAhBgEblZnd
TkUbtYHIrfzVHg7nR+4Nwqk2xucoanatPat/pxovxFRr6jHy+2JV5gGRUG5oI/AC
50aZdb/w0eud+yG/n/6W8bjjeM+r8z47qw4fswdujQgE+ry3fmReLm6Jff3bHh0z
FCRXwIDgSG0HGE8i5LwJmwbmpIBqh/syNt8fz3IsyUES5lhGZJdM7cVxRnlzDwjm
n6+0i6mS5cHSy8N5wqP15W3wCdX1BYAiZbas+YqBwt68v5f4TgtyWtAS7lZCyfOw
tk504ECS1vgerCDIS1Ulwz8R85Vz+cZLGohivY9DkiXcpfRUNugSV8A1KFQEdpr9
HAJahmmoZxrK+jIbPGsOJaWKiO8WzmOtHBkIhb0/9pGwCvUfJCw/ZckZDcKpJ/I8
zYpXJc6qfIXpbgRijXl701rRzAEGV8bh31Zgkb1VoLlulyefJ/QQ0ECkt8FEV6PM
ikFPCm6Nx/zKZe73mNzMgWqGFclSlQzPqoRvDiHD8kW4SS1E/IpL7po8tRp0GPOy
EX0ZAFYLBYgtwtKgfyZpaTKAy2pXo8ug8aW9bGywKp5AYKbo1uNOWjpFljcFaJTN
7hvCwV0NxwNRZTPhe3bA9RoqAQf1GcOlk2zKeiquvHyoPkudyz6JVyY1BIBMILLG
TBSPRLEicEnDalRrRLOqeJG7zEKa3eWaGEMTrxYUvFk1vdWvCsKYnfFnwcGI2wTH
G7ewu4MUD6nSR5rwylhvGO8zVSJJKDaVlXosbiqfSqSrdzEkbOF2uOiUBB2/TsA0
wPs+M+H72dVJbqsi+cH9z9iQesCKODivmVQk98WQihU+yoELptcl2S6h248RDxR0
H/IkXApuKMI5DFU81u82xZOtUlsp0wqGyXyy4J+S3n0g+Y5TuL85bUd884rjgWw4
c5Ss+P89kyyb3AJK6vHhF15JLtdHjT2PUPLk5mXvmTFYZwKgNCTfqqKtBJ+eZvBM
Me4lxY9yDy19+aAOuP6+aERCar6CuTxaQLSUTU+KikZjHV6ION9cWbTKU5NdxtUT
2+f4XG88ll5ZIQkagTYkHnliTlB0G4+oEG01tt0jvHzM9LRyHxmyjBwbqOJZ9fg9
utxfAY7B2jtkCdC828FqcpXAceME+UBgBq609MYcxPA6xRd6E3ygaUBu6E9k8dUJ
jiRNvVsYwjOoQDBcLaNFey99/fX6fD1ra7USZx6XNuA7YcZYkB3MoPPR2r88ujne
qodthwObCpnYP6ys5jUCp8GIayBnLW/g/D+oUHOUv3yZJG/XUWccfjNthJvXYrPC
XDqgPW63hhIS8dTKIzvI5MBYeMfzJdXkCeFPMaUYUTa35/sDeK3BA6xL0TWM8h51
Oq6c3QbL7ADrMV9r4piHHkCjzsC/z3QVFsCq8zguCoJCXJFTw89treSKZ1Oep9L2
XX4TAYf8QjoeOOcWMa3EQH+gJJ0y8C/SehhWJUPqzygTbddYWD9LjZl0Z0bdiJHK
nG8p529X1D2dxR1fjCx+urZbCdohRt4QXbTttVS2XmKd+SjCvhpe0cyiqk4W5g03
fyQRmkZH8OPs6QDZ4ArszOdsKvoSY7jkZrsaoM0RtX4nWNdrDbPH6hjEYCYpM1lS
5ft1Fi+BXMLeNBmkFgFoeIQRhgO1xjL8DCm0tmn3pFFUwpz1RU/ewCRlX8+368Oj
hWysbD6XAG1Ld6a0Hh1eJ+OTmoqouReOxASaZ/XaWQLtSLxNVQZ5gAqmsZw/PSyl
TBr7WEligcIqcoy/EC/obJV1jbWchsFgdlwt7m+if1tb9neZuCCaKCtZ4WwfTmiA
7zQTHqgKMMrqGEXCf7KkvSVa8lBFJCJsxeGEsKGFhLo+Gq0o6E+oJ8SQ9nZVIdtf
SysdQENf9ZKfMc1APHP6U+ZRvf9BYV5TBWAp0xeiYmtum2Vxw7C8uxmruZHqMGR1
n0bQYTjjDPUFlEGiA1n93tpwNu8Qj8C6xym/UZ1jRkfkfWG5f814gsj3nfH1Mken
6P5J6wvLS0WjvvLNF4+yGG3eAe45hI/dsYsFp8mtyx/Lo87lt6C/GP9yhQIkwUQO
2978PmvVQJMaIkHFculpulYpCxwYDniOkH7WH4XP5ny/19eziR4qI7bJzMAo/FRq
1IkuW5EPdZsi7LzaLx11g1K9mPIhFdjjIhCLWJO80RudLQJgBwE4VxeQBCr2cNJm
6F4tj5m6HH/4FojBrgM7Jofd21BdpD81eQutY9Bzf7HBRz85ElQNKtlNxZZmoFMY
8sI6Ku8aVbRBpn0B9iK0ljfdZe1fJaXSNiYmvZu2DuR7A+A0fT2DnthKYg7Y91TW
eLGhXQItH/4l2+hqHsS/FvjO5gC2MEpNmed1qFS5bqsEHGRz7Wh4JPWgzA7yvjgI
seHXINzoxakpReQg/2RThtq1HrWP8xMoyaOqXFkFkFOGpv1oQyKKHKAYZjjqwqgw
Q/JpU41Qks4xamBlqA+rA7nLH4AhozKkRktLr93328/6oTaTX4DDSlPjP9l8+INW
0fYV0E0s30bzoGDLAf2C6OOu8TRXuRYadqQoiCaqltVOWMvk71g2s5hfeN9mmwqC
upohQCEkvEA1FayAieV5vERq7rAW8v+OKU79sJnI7EPmHpFixKhlLheoNUVgm8iW
5n4hvM900z8lMnbbpjdyhVPCEjpS7AUyebKy5WV1WPT8areg+o1botFEHAMAKsXG
wSI5fUf+6jfwC+HRwkzLM3Pu8cTPex2ZF7JbjV4zN/XRK3kJ1v9rPV3M0cZwOxzB
pF7WejyIU2/kPWEcrfrVDCOkeACbFXUyZqazOf7SzA5ED9E+QgLn3M72MrzVY8UU
JDQ0CZeD5pEcTfUJIUxk+0yN0X0oduIZQloVoCbKZ88J+8lFKSaWaGT6eimeWLSg
pec1fYDJAsue7D/yniz4Y+PQVDbT7zuyMPVGru1DyfVzGFYRe7+DWrmlHFc0fGD6
rd/3qWTyDWYiPS/OcmcpWIE45fFXG41pMf6R1VIS5ZvKe7DclZnJsSl8Bj3/End0
qJk/KFKTTd62QnHekXpqa3+D0N81YxkctRKp1OcrlFFoKuB9NTXgxFwrJirCG1mO
YjLpbWWUBi2JLXecMLUkjSo+V0WEb7batMDHViP++61I9CxsEklyJT5o42swoJ31
4z3VjsO/wlJccEO1LROUylsl8il05KiPQhgVTajJa4pdDp2AE8QBfOja3EswbXkq
Qrw/KK47EO0krukRN6DHyr1ZUr0q15+T+JjoYzZxemzAuD/PpHl57E/r5oI+qpnp
toYLe9IMxWnQoMheau2pkCes9u2VgSOumEN9vfulhaOYSfDlbXgQ28hum7Ewozjc
WaSBP9Jz+Ie2T/t5DxqX8CZawMJHErwXiz7/6pMUiVetrqinSmruqcpW1xO6R8dA
EeHogaW18wt3jcNpbY51SziQ1Qx86zEyoN+7FIKgKdJ3WZ/pVgNw+JyHhYGu47g4
ZxaXKmMQLUABd1aVv4KnV5K2ibHaWNadkAQ/S2CStCcTUBkGe6x1KJLVy1jzExfZ
a3UaWkS+eipOVPKYXVnZTkSb7CT2YBWlD/3xEz48M14RXAp9Hi+E2icPglYTB0+5
gW0D5haJHV7bKyEK0R2mLZJT+SISb2C4f0AaeN1pCkb3nj0OBtaTjXlHVnzLyqqT
rOhwZPPgFecLTB0S0UWOO/34zfr4JLGRMRWD5wE/VQJRYbAIiHzH5V3NzHPo4m2a
+T81cyyEXGeyLC/6HM1BNZEJu0+bT7VdlRPoLIQt96XCPFIjqtK5k1sdjBonrPN+
9139jWmhayhGBi/U1xiMrUqJ1IHs7Rc0nZig2WilOm6Zgs3qP88y7kOC1Lbp+gHz
ub6pzmTgAmfdA+w3SWEEbgQPE5nWEtVhiH8gMN4weJBHTFPawKjoVqBDdtcKRl9+
Mu8cSwnsZ4JHa4qJxemptcQnMpqa1VUuYzT4QeQL8WLIZpGl+Q+I6KDFtMpCE2cY
WWNYqe4goZKNv7nb7KxFbFyCQI7wgHnT4tjzOdo9jH2ZFYbLXQ8GCmI5OX4H69WR
sImo8EFupx0Tja/uRj11fDGSxEs1dPsKRpXjdkBT8J8XhZmnK5VM5jEOA15Yz8wb
ZXmt6s9bmRiLVtxfgJYwwS2AF02aFPKflMP2iI9R00IH6H/BMSPweeGwr/3x//cu
y4TNO5ZG3XbNXHh9qlD6BwGAsFmivE4rToWTRTdiRitlHXYtiuGvtH2iZ6TcoLyk
lsQDv/BPgB78xgfDYQwg+QPqzVqEXHcfltKThq2g0z8FCNkVU64SiW4i076SaGi4
6KNSx3P9aePLhGu1Iy/VaJlT5PXfMJ5gddo1syi6h2VzuQqEJ+JYqz1znWFLU7F5
72ZM+0YDy/NWBJZQEByCPawUAbq3fU6SZ1gwVzkxN9DjT28591PY+F4A6Rywvs/U
u4Q0zNCV7hlTru9W02Q8joZtZp2qGgturkhJYKFKfAWEM+KMSyP+Y528UvTXUKNG
5A4T9PJwJA9pskvLFlbLIXTE8pTkgmF+7a64oSgJPp7mZWSA4Kt8RDyiH4taWFz4
yvw1c93rqAD6efkDLBIpwKB4EcFik87SScmXuegaA6FJrSTwSjdYCom2BwlFBo4r
UM5FiyiDwXYG7E+dJKWgsm8yMss60p8hSwKgMm9sYlvsyUNjFv3NDHj7tSDuf/wQ
IpfbOsuXVWBfNYe+F3AMdWe5XmRdla3o+xmGKJD/LF6UeosZAhvlY0yKLeqIdCh5
ssWt5BEcFBw3dytxUgVhmH/rg2tBYTpUcOZXEyInNDDf7Qc21zV3WXKcVhsbmMom
CCza1zJu7Ku5iEU/ewmz5MWbaRN6d5QGkQ0wlzMnr8sHMPG9htwwBwSKjwRYvgMq
7G6pqydgqdabeFUT3H0olVhBtX3SDwO+hUjSU6jrKvZLgqfQFGcVqXj3fke0nBeK
pmEXpDKNOgG+Iip6L81To6ygMyR5yUC8cL59NtixvxmE4P61tafKecAjlk4Sx/UP
RAsEcpse30PE3bdBaM5ZB+mF/k83v0wnk6UIRhdcpS+zhzbjiW4XdOuXRIaTuRXT
SLncei8s+ZAtAcw9WraoZyK9UIKUwCFP/Ywydpbi/teEvzTETAUnFEk18JZp3I8K
HIGSlsSehRkCab8s1fodzsbymhBnXg3BnPBY7+gM2GgM9aVjzP08DVPo2C0IPh6z
9IeIFAKBWlv25nmBCuE7027/VzK6kyAqttKpUTkUKNw=
`pragma protect end_protected
`endif //  `ifndef GUARD_SVT_CHI_HN_ADDR_RANGE_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
O7mulFmljGCT8Opo8WNqYaXSCwo9/tSplUFE1hAGjwH1aUtsGP7Q1UHiuNmMnV1L
UGG1jcdSapsn6Xoh54xb3v2akyV31l70OJQS/u21h6CrVfiQ8RWwZwiv2uuaHMBC
HzOwJEI9SkS010DoRWdxkczE6oRJ7mtQfV4ukBYoJcc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11377     )
Y5CqJUhL6G6cQefzt6FkUezse8Z6rivt+OnKQb+qj2YxDXTs8TFxODrLr5kszphH
RCbcManpKjzTuUUgySl34oAMvQQqeFNFjoxioO0n9dNHj66fKJePzN6RwUtbh0WK
`pragma protect end_protected
