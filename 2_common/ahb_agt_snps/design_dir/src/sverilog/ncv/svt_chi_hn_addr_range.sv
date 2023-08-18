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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
R2c74ryTY+juAuTyA943arxmixS4Kx+3tE1ychYlqHv6BVrmoiHR7CpJ5qbDE9MR
YUvS+4imsGxwjoLAzlEtCqKTttHJqReghlLUbClgztOK4tkar2sSmPKZ9OV+RQAL
Mk+BYh1NFhiEGIHz9WO88Me/HvkaOZulMR57XJt1J7sEKb7uj7s3AQ==
//pragma protect end_key_block
//pragma protect digest_block
84leUmHgbHWxqMYj+q3H2YyV0XE=
//pragma protect end_digest_block
//pragma protect data_block
VzNNQLrDz4xYFb86xtaz1IZhTmCDtm2jTsHgpKjSRCUxThdc678V+gidXHYqhuBV
C8chmzP1UySlE7neyPyWoHj390ujc7eN19uTVLWnVD27YxbULh+Z2s49BKFWRmr8
TQa5MZcggcmnz2a7+t1oBLrMJvuOUqHcETfY8Wq8D5l2RxYF8d8a5nmHvWjh1GQh
0nbYVi4vK1WdnMVeg4NuUgEq9DKrS2gv+FzYnsSYh+LlWiltW8OC/RB2r7W7yLUJ
PE93DQVcuH+ZlVUpDLHlifPt3xfOZ+TdiOzfWf6sg+sd84f6x5vA5QAjNbsBHk6D
IaeYWC/6l4sHMK7T9/l5jOl5CvUnMNu+nFFEIkItcDSEBn3IyFhm5g6+7ZWhpHXM
t3Q5h8DfNORCeXfXrupdt3Ey08czMrHR1N/eQUoytlik5xHkaTcNFU9EvFOJ3d6t
YPwXqRsYoVKAFj708RLM55dBfX1tDoxNzzoLZHsqyjd1ezuQWbEjuYFdnqe2VrEh
EW3FARUaKTYh9L3UDsET2JeVZ2Ar7ewceZsNugpFgSjXSeYUcjZR9kiG6Da3eeso
liwh9C3CJYTSEOwJ1A7WD2k3gx7mqjCk1xj6F079y373cageGPA6oNz7UO3/ZeBe
Lk+759HldnlzX+M5u6rVydSWuUWuF8gkxDi6hsih66YmDL12GHSNfbZJh7snCrA6
jtKPE2P5Yma80/kwgGNeZ25gNJRFnkychScg4BjG5wv+FjYTMhSRhhF7+OhJyBHd
FEi74N1421apsVO8LdFWG1gl99Ltr1eluOziUZ7k/CnGm7J+aTdFIvz9ByDU6MAI
mHvgmRhhOrtMcUZFEhr/Gwf+PIUI41BC4MQnqaayRB/8VIBaTargsqF53vV1jL0L
6Im733qtmCunqWVms2vGJPoJ8iKyW++UfuqZMXuw2tt041HE2yQSP5JN++neTHiI
KnEYdqf0S3FeBJhjactQf7TgT8EitCo15zErcpawJJd9PT0+KQCzDhRVqgopdqTV
S2ZfIB3PcxTnULC6QxQB2Q==
//pragma protect end_data_block
//pragma protect digest_block
cDVbBsjrf9hI72vA0URvzI2RbC4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+JntoPglnUKMuD7ws7gZFvdoQExyDMdSOe1eh8uO+vc9w7464e/YurDBBpFr2aSU
4HHyW4Ep83REgPSAsJAhUo9Yc24a5RrWZ2jBJ2oxCZO0X/dM1IX32tIVHYeUNifV
H+eFvNWDDFHjLMX0SWoR8JV9w0JD6oafMghQ9EbabTLjmQom0Er7QQ==
//pragma protect end_key_block
//pragma protect digest_block
UkCXnXpqcTdgotW9OIC8e/mwwlo=
//pragma protect end_digest_block
//pragma protect data_block
t8nDfej7eWq2KnDKkjQ0aE4iX6ObtcwT1rTM87QgxBT3WDAmKp4s4DEwoZ/EWH7g
fYyVohd5INUPZa+5HExEyt9ees1pxuKg6NeDgDz94vJMxLEHu2Mof4wYuhfVPhYf
WHcmjbmIbfPW0/KXjpyLlW6UWffc4k/VC9k49UiBWDZQ6FN5A3YrRMjjf65Pc+fY
+9EFX54ArUIpOqTrOapQXSVjzsmlg59b0kWgm7UMVrMGmQmBhGKFh1DvIyz+5EBL
S9lzZAnmfwArS5j1Y4IZp+U3AgluxeciElW0HhzNlDSV34C3fFY5aM+Zy+Cd3DLW
R+h0cSHRyvCdCK566634bZz80Pi+Y11BkV/fDl+PG7M8jJm6Ff8HZ3cInQ9W3t6y
4kNcmw3faY9uapHiD3hDFK8gPFjIQIFrpDKjyXOyeFfPadD234H8/BBrI49vNmmw
mMrrnijX1+hxSUQV7PEBriJ1bLkFxFyuy5iZNrRBkmcu8kJCY+/CkamaluND/cII
fTmUrGnQJZ4imw0yYN4qlxDFjxi90rMWEgubxLRyLZeAnWOdqwt6PrgFDseV2vw4
qUS4M4CMHBKJw/e5fMSQDHyJNCkJ6QpRTyV+S0ounEgcsQxHVPK9jSGrIAQ6Lb3S
hzXzIXlA4Wwwk2caa2ik/4+03J1+B8gX3ca50iI+QfhV6VKpmStKa/b6D7iDp8iv
/sz12ifbA20p9x6caHq8ic0ndN6WqdRBEbesiOzJw52efjP3K8UIcc5SiZWpoASN
HTFjaRZD1jydvyGABiNjILlX9Ng5wRwBirkBKClubFkFitVcJitjh7UN0Ok/PKTP
IRNbSIdCl0nIlvVdmQFIvf5b7g88RgYs1eV/pe23W/c7X0eKjfR/bSbq9aOygi8Y
Jq79r2teAuK1EjCYZ8jnpPq1+HKhUgOFDWvNopoA3Xa2KaQTg7Hv5s/W+Mw/Jao5
uzNn6J8Qw31byQVCMJ1cF4NnJWBPLzQjLAf1s6xGvDiHXkLJiqpHSJgITi8ryexh
XD5tPdOx383Oibxs6o1LFmhVMylbaGFK6SSmNyzimfMh5JNBcVtr/H+rEIrc/sCX
fkVRHUMmI44iAHzGHmrHKI6CNt+2zIgKoo4VedoH8dzhHe4w+s6SIS+nHlVknVq+
Qwxr0TSGrgPb5Vb9OinOPCT3/JnNLdgPk8irGtiLXXmWtL/f/KiW/RAa4eZe69Sw
SzayIKtugr9+pEvQ3IWXD6nmpse93HOENkEZR8drH0IBfIIcxL9r0njEErxjeP+F
+YbrHfuomHjvrxd3eTHVBz4X7jmQfDbffsrDOVZ9nuxFgWBdXLChPPpCC5gAvZBS
KrU6IbtKJ5fpQJ9jgraHHYtFABBARmWxY+0JsUZhF5YoSl+30Oft4gCEBSt2mawW
w0MXxfBUsZKxQ4kWqciQGKVDzio2z0uAd+Vz+mk2vahsCCv9J3FE2xGKEyylb98u
Z9SUD8Qj4GXONfej4yENojmC06WtP1YLr1r6g3VeUZfmwDW3kScxutn+HQ6igN4t
acM1Y/NoVnUHJ1AHguU+mM2YbNBOCk5/yHtYK8lQ9Big041ip9rvp0cO9tkNBMR3
CtgVuX4NWXKVnpwc9xL0cufUz0jBoot0KgnbhUFVcuoL6TsSRah1YX7LtmDhBzx/
TZz+U5Q7iE00rrcm/J6xb4VrIMjyfl9zoSjLiECQynpLMTsw4ladrZsR5HmP10aO
YacilpJPdB4+33Y267xv9A7srlQJ5rqNAVkpV3RBGscPpbeZOnhmaBTJ+7Jp+1oG
Nv1SONudUFW379VRaD0qGC0wBX+vEY8mwugHb6NvalOZ8KkT/EnnyELgf0hTbnCc
Z7S8+xQJE/rVGlyFkE6TODWtLtk8Oa4qbOEB2TzGGlPyYOcDF9/H7NYEkc0cozvw
Qw9Z7L9sNCcpr0qRxlK6pwyyf+BlaEJa6BJtrELOMm2Ip3/6hyqMQWAhapm5tRJa
4N1AyRLuEW61tYD/zoANmtdDBS37/Ab0msHzAAIjVpkPeOu8Dfq5nCw+AsyKan1P
EnAPaqTc83s8rWUqnHWAKPhL8TYghGuauoyLk/torDZrdF0bheKc3BwXzJVyusVE
T1+lrcbm0sjmVcJ8GgBQBdDwTYKfEnI8/4b96fbtEziPAb2NlztKvXBjPfSQPWSa
cZtjfm1T/HoOrzLqUFD7oyot977aGcSky5KbXVZriqHmQRP36meeJguq967VkFdk
MBqCI5AXEJn9EPnQu5xMBB/lTpPjrPuzOfAw6R0zIr2bOpMP61gy8lwmj0e+22eO
jRAIVWTAP/YI1MUT1DJtBM5clzE88+M2HUy3Dl1GlLToOGhoBRamgX1xDYFElNml
Cb2KxvnDpm0TiNrn5UThR8aXhWZvJHsP4hAap/jcrNhccDAJT8k5nnGrgx4BNcAK
0En72wuLl1iac0daNTp4Xk0YIlS8S8Sfnb29VzrOvAl2Y/7t89+IF33/qCb0n1ah
dXuVXnx981nd9xWNqZ3LSo6sbt7fvT5YJLZ7lLXBs5ilC6+cYqDHmNJjdnlIC43F
Ju0f0jb6NjSbno4NZFCHdTNLakG9xTYUnQQzhnUyPLmztWzTlpv7MvHPdC3vMuag
D2krIPlRPEG4nBjIU/mqJaY1iMfcK32ufX2q9nxrT8ndCnykRlMb6JTO6vLf/APJ
u5/0Fnap2MEL8D5ItuWTbyi6r91+oIi7fMomFzGq070TOzTLpOoJ3I/qs+BDwoVV
DrBnkr4+rjk7XjbijsvsytT7OMwBK2RZYQsf2alwfdNfEsbCkxxwLjG2zuMTHZDo
pfhpthtOdb8iQJBF4oA9vMYwGBEtnyMh0Nib3GZUB8YLqA7+kapoQe70ro3R8wcO
T24W5xR8oY8n4hKw3jvmd6S5cZ+bWQgG8Lu91zYJebtuPLELxJql+djrJiei347a
xnnvyBXuxdaEHgYVco5lth3goxLSg2DTx20OJIE79qB8oqCNQWztjzfRKkI1DhnX
UlzKWy8x4AqM9XdZEuWAZLrytRN/+xp8Gh3rJ1EzlQF/yriSwJTLY+MzSh7SGWRz
oiRScqKsLXyFjG2Gl8wXkavQqNK/JDN0+V5IbytO0bUAWFlL0G75i2RuB2Tta2Fh
Z1ztmLI5bjqu2zy8WDNnFsSRIYNLwCPP1SNTgYOx5Pygt1BWDCTh+7duUQcFgdc3
9W9DkadfYKREWkjJw/+lvHua5odeH+itcAl2QLp27tCngGS6QmhP3Dokt1jcH4CH
nSn13TKEYYLEUZk1HuKuW5k7stkmsNRcRDGy6oQx2M/Kb/VzDNcNPiK7V7kgtOhM
SBxO0BNO9zrxik+CghYv+eDP1MyocaUDBkbU024ONEGPXhx42BrsB40EU46iVami
A1EqcaXd7tV0sF/aFRU1nnmQyAVa37npCQlqdbsdiMa//MfFKwyfjSLun6VvPfuS
m8x5DxP0ikZyVI2Qo7uWw9rGTX3hzBzKiAI6jIvIkl1vfINrQJKU5KM4mKZPDzNU
JkLRgAJIbRgXrjOm8s92UbI6+r4MPG06l98kafnArfBGglg02lpjUNjXEg+3UK8o
wmSAH0ZdZApvZTfU+vzEfMRn+vEB0Lt59cT0aXl3R9LcuNxQ9oxQKwG7jt1T8249
RYAE5sBC4LsHq6j58yz/PEn/k7XA/Y5pE5u4sxpIhGYtIeV3h4bpKD2CWLbyxI8l
pyCC10WBAUD9Khe+nVUDIsckemtu5Fu5OVveHD9g0RH3cciAeWnWqHpm8dBgkOxu
wtxX37qqUtvsogaAPTt4qjG95k2FKMnwBl/lprXNv5R3I4S7/6hxw9lnYnS1ayCM
pGFaQNGtvQcxd7x2u56+yOeviypT8h0Hz7Eldt3OPPmj6vO9IcDRwqLT9DnEvctN
KzzWQWzvavELr6F3rSY02nslO7vtmzYBt2QNJO3769AKQTHAjbNElZdIgI+DQ3Tg
zAONrFE/MSLqHNBRqH3k4g0StnEXRYs5upMBKE9KP2TzrwG6USomwi1Ja4dvx9/l
vmXjEVSDYZJdTDyVyJ/ZwWFuFy8obvGr1n/rtaBmZhjk+/B/EHwak2WZXChv112x
KCW4M0udR1Qwp9Em6Z6i6WhKgYW0Q4A1+51tknG9QaPYFdjXXcUDGLFKY/FMl6LI
yIUKcpg+2dGrHrHXQ5FJYOS+42O38wht9xeRGnuA2uQzN69S6X1YRNa/hqRlFiKF
pQAzbeRX2/SKGrinyZLy9dha+4Br++707mFw3mZoK9HwKyiHF00BbzqVv9yx/GeW
RIIwFAYaGCnDdjgEXB9AZkQ7r41bh50+D48FsfEn+QrKst5kVqkgy4BD695Pje/x
CUg3zKVkIWhKTMl6jMu054oOuAWYaQi9PWks6qcVLDkRoFUVBFJvZOhgLUKVzEdB
nwht7MRls2UWPmkw8Vi2CShOE0BlgMn372BRZs9fqCQBN01xkxPhvCCKL+DZ4m/z
7d58z9xeQvX3/FVZKb9Ml7KpP5j/ArhN38ZtDvzL0KQ2KMJ2r42ZqRo3i0MXXbap
QVo7Urs5PU6M2vGATch2rdhfnlTNE9t8xUWMN6RQQmyqcPQ148MQ4ZcL4kt+T7Y5
mtDEyJGgxvwUsU4A2xXENCpWRyx04q4giSYLD7aYdrqEWnvDyio0fy32f2j4xBDH
Fio8clTg33xiBXndeDzSbG5mr3sQsIopr4oRxmlNL/OUqXOSxCjLu1v0ZyqO3EJ3
5vAHdydw/y5LibLgmZVF3J0mwLlnumHbt1KbSrx0UjEHmxgOyZFba8NwYIqvVP/P
nymTDBD264WUTXnjXCuR+HAHcTDgvamRmEzplWn7E6NLrBho/0291xHDv3wuNzlI
ZCb711I1/CdnY4M7M9JVgdnVLS69og9K6XWgmJctyqlVeLhFZ0sFj9M5tBSyRaXG
/3jtfpcxQ+7faS9oPJQDgVoVJwL3eSnXGG5jNvNTwIkWPtNytkhz82e9OmFTXSoU
EvbRbYUHI1l7n1qLyD/ycOikY1HHRqpNqpuGz25uxbyAl1hdqGZPgMJSPUQOrRzt
W0FPwuC7e5jETT/mXL98Mm3MwRiocIY/RuzxCLFyAEMIgVXkgcxx3mBZgVzla75u
Nidy9yNPgE5TKiLFvkxznRabbAFUwrTDSB0YyQFH2wGDcupeAoEDH5KcmZoL5ycL
ZRdGJuIQAZE66zGNfLb72LOmdhRWWFBoniQ3ZUJTNQaJImCtgjvcZWApubLBLImQ
5n/vNdk4BpOB7IeI1IxCCy/W1nqb3i0p3ofMcVGJms4gDjloCA86Jhj/oS/x/gg0
QBiI0GEVWbi+lnyMePdN7HQgJ9N+KQ42X2RFNHmD3h66nY7RIsYOvOHv9Mkj9dNF
Z8RSYvEdyLzc3csn1qoIJHFlTkSu9SUz872s7sRCJnVj9sXHKp2a00G6FYbObN2x
NU2LzH5wq3YEYWeo2xF1Wwmd/YQsLexk/nJ/Ih5EieTbeU4SFppK32LSmv6XeriE
bKoBOv6y2Q9YADMkin1Ig8ly0JmfYweOIIrdiDY4TMRpOS0UfpgSQdbrdb6ZkzBJ
9db4kT0eHJVD49Y/s+ybWomnBQIbOvQHfja5FQzMNOKwsknhAlarN1o5aaPACGIE
Yi3YjFRlsum/UNnzp1RHE9vern43wVU3eBSppB9ZbzLK7J/vfUe53kAbhtaQ+eSb
01Dn7ASKkBBtLRH4ENVDkXJVcjgVZtTOp2IlKvbuhsbmu2x3bX24vI01edg8jxUy
OY3WruIzZwD7z4BvTwwPahe5kvgqKsb1V3MAmaW4oZGx+0sAdchXyXfFYTr+bYaM
0Cuml3nEj7pCgbyp1g9c2WBN7mdAODDIVK/heHwYDjkD8CZzozuDDY8Slbs2OEKS
gjE1J8n81E9suCkeUyliFzyEFmHoEiAo/JBCmU3TmCFsTQ8TEJn2MymuJlY92/LH
FWi6q8jrzYypEVmUi7vzKYB+Tx/gJDJtRjeR0+TOFH0RT+4476nVFI7wCxRjr00E
JKgpFE6Ko2NZANBtVUSKdbC/ARPWwFt5V2mauZgBBxyO4IU1R80hw4VgU+pq5dTD
lSLMjCDGnNDf2Ql+IQ3Rj8EK03RIcaVa/1A7CUn5YMY9c7W6dSuak9kPtlT9IU6J
RvkxWRkC4cIrF6iS2ZnZNSYjFOT6PvRvmaZtXy/ZlMR32Y3GhyU9Ief13xV1QRYD
ei+H3f01VxSpA4JX5rzlFzcGKIzQg0HQlfdhDbHBRi1h4kstBMjU0PTBLp3ZVQFa
UPzVQNvNPGXudwmtmb6DJWO+m6j/8BoPA6pIysC8p+a+4L4KusuJ6UKayBipcU27
3wNewXMdPCcOsuGsgwkbrhuWQb8ft+8gjaTZvR0dESj2k0FjMeMxcqRN3Fhe5n+e
rzXqzLln5RIvq53S4Juz6OK4ICuNPueleQ2wwv6fpGlyGunVgyRDrqdmn7i7CqYD
Vc9gzt1OPlJVkR+n6HXH7276j+ayJ4qjbT4Wt+5x3KvsISgGnXcK6PlZ62ejEaAC
g2OW+jWPjtyp7JNuLE+YEECMHywAHJ38JBjwzRSimRmR1fVg2bJBTo2rkj5XkYu7
nR07l2mcq6YIpJi3XsLAL9Pf5s9sZdynwJ5sMZ6MOZgrYMHJJn0oOtQj/DCxINq9
PFv0CWTvz+QDL4asNtSSFb6aUp9ewLpprh6LOvASRI/zMXd+V16A8pqjo6i7UdIl
TCGadiQnclTf/YwtuAYSN68ePLDu1nhjiSlWknLqPh8iM3bxTUcGy8nxH4FzJqlp
ssFmNzdU45XDb2HF0oLK5cgU0zE5qEw/jzoDYsGlH/XlYmInNSccpaQcNBIvcZHX
UU/QU/IaeRGFTuAvVGS9tUwuA9TZou08S0dyn2r7IoY1Rv6QvFAouaCoIWfxfV0A
ERXqMkuwlL5VZ8aQ9oZEwfUv4NCDMdHtXZuOl77TZ9/qx7xTbFdcrNKzNPBGfl++
FD9Hk+O5b7q7IQG6BuJ9R3rIVhV2f/0MmTr2/rRowZys+8FG/HJFsgvWD8fo0FBg
FCV4naivHS+Cnya9/ZU2hquR75rIGlj2MM/WEeitglRHusC1Cx0pgErdfNGVHbCO
y/x4WF7SvyFDxIah0HymCucqiqI3mU9nH83zUWWD5uYfWtXQRz9ahRVGIdaaDD2b
QvCJ0+aGF3uX/TgdOMVaKdw/TmnhiBWm7q5yEmxZGRXzF3+8+DpSjCD2rWzlJ1qv
FK8bPcCv9ohgobc7XcB1rrSJ8K7wAonWp6Wapg3AAbqzkTCpIuAB2RM57LSPYVhN
zxNm+6alTVijve6Kkyjy6blcQpshPU2aOPXPT7xyi43xkGXT026o8d4FZM7cPgO+
H1EWPbB+QD0LbWRWxyYwObMaMHactFDJg4deTqe6fSCFCqRQ6UxttMAQAy57OQ/Y
doNu4VPGYjIm8ZIme0kFFJ7cNpFeVupxxTmoO+FVweLtfr4knLuGcqXUwVOIQEvG
MIimi6ahRGuqVHxFs/A4UnWiToJP4RpdSKTqlLFu6VvcyMK+B/L3P3Ke0ibH8vbr
zGcBMySuClPW9MP2271d4mJ1ogTj8OF0fnoD7rARa1mkpTCDqXVZjtksHaU5T+uh
LvCvqnaP6gYqhkWy0O07oAzY7A8ShSnCIwLzxZ4qSEbWc5v3uEsmL8M4NdkOcMgv
5b85DPkuOe1geJ1e0NxXcykemqG/MwUdB+2zsLgOcpWQUkWK/SrcWKtktxPO+sGy
IHWiE0CIerCD8L4UV0QTLU/V0carjS7ur/spGm+PuviPNOfyBM8rKjv+5oVRq221
WJJ6kW5T/26w5/0X/hrj58cZDxe4hX11DbyQ0dq92lbRDuBb2ELnJYKGFRtnS8ah
CnNkt1Zm3IF5os8RefyLcaQ/A+/LOnWhAlfcSpTyKP6K1LNHPvwkHyjBMMla7gkT
pnl1CeT9D+3sPLHxpQlRALGNDsDSFGhhFd8oMh5JYdmN+TuE3l8Tro1zNaNSRRZ5
l6kSGApoacB9YQJNkVsV82bRa9FFgJ+n3uM5tWLYT7E8MegMJ7O9oLpa+A9ixBH2
mTPa0sj7kYOSqfPFNRYzQZw00xP8r/jD7KykaCjLjnjs42TFPhValBOFlFAo0/+2
F6G3YEkvRLOMWXtXDh08wK2GamBRETly06Jk/LQBc4q0/uqshCdpuzo5jdScLbyi
jNJrNlBV+JEwDo4VCc7hh7ss/6s5E/FSV41ws9NbEnXt2gT1+iKwRZctDD1xxTvF
0cICuQcXl2YcP36kmKbM1LygRvtkflDWljf9FDXCpUyhwbT1bVkOZynbgwcRJZmY
rzV45uQw106QMx9eUm+rTMihgeRcgSeTq/7lXzlMguc7PWVfrow3jPAdFtIOmm46
RKi6EP/XJ2GOEDA4WytKSt2qHK+skDcf4+D2Hmadf69dOLoCQ3Q3AL9y1fM7ZrqM
aK4W8jJUlru4Ecu2AcH4UXmTH+Wey1RfpNcoskQ8b4zgoRWWplsuONPCsHJ2hrBU
DzO2XlXnONgX+1ydSZ1GTHMZqjAES5u5r0QEmBcBTFhmNwjYkIefwfXm9VoKagT/
QuFujQP66y2Ydmb2+jZE0IqUY30Ru9wVxP6aCQDsjSfmttWLhwsBtjEdkbMi1Yde
/pWKcQCV89w74IEDZDRCMY+8X0ISQITHkg4NGEolw5AliXHU8ZZv3CbpbI7rXelh
X8kxQFbVV8q6F8cHB0PdvXymDh6Zfcf8WYTwKCU/e4RGv7LC90amn7Dxf0h4MNNv
J90J0eoiWKnPcsyAXajEy0h2k/55gYMkWgVLDCh+AYAXIoAEiyZGP18QD+s/KmUk
YJT5XiLyFm6cTc6JedHDVBc4ifvNeQ+nJqfXMd93BezI23QucDKCtLwWsKJ8VSE2
+nEiGC63Dc+ziPGmSl1qmvgD3hCBO21OVjDWimgje/JA5YL8u8yuAr2rFMnGs49H
n6NkcQHGwoi3VRI6UfY0lKzNC5iWlI2SIRdH7osHLjG3s2XKOajftkFy81IcAtiR
qmUd5deXpYAlZ0mCL3d/JuKfjEuFgA1NMFwiv5W008FjYiIblIQx2lKuIBX8/e5s
4oaA4hHohAY1jxLLuUqyqXJ8jw7grU1d3adDfbuLZoKzHGeMp+DUfpNOyk1PzPyn
hPeHsGyH60LgLNM9SmaLOHN0RHyZC6xEfoc/Az5qVlWxUOR/WAWEi1U1Sj+cfb5Z
pfx9TREz0w0X3J1rWAW6xUhzNyMWF5WjytucutT4S8AznHhR9PsbYHw7qsEFTl6s
Bwb6DzXBJ8PHmxtkfiLuHFTPq0jrL0mc0IAP3GHdBpZi9EClxWY34G1wPwEUwWpC
yNAnP6eI4fVSu1ZmpMMNPi9/GypLN0iYi6yn855lABojiuUDRNXymWD4/Wel6MdB
xlTX7zAIfnBNFNTwxEMXzOjdIGMzN1KWUu6qefAsFuDBsn729qT8YhaT4viPclBO
QyATYwqwO4c9zbl5wmlH5Tnyw3nAQ+nsvBdZRdAp8AOQCj/oHdDhqkKBDbWcsumo
v23zeTHzXRD1qW6YjCB+2hIu1mdSJkLjV0q1tlHv1s1GyZXOfgLONPCE4I/Z8wMd
9GA8S7ne8ksP7W46B0FyvXl2rhtmi7bk09gNb3n9ewk/lQt0WDwD+W61Kxl14Q0x
9TPP6wlXtX9UbJXuKiGFG2HXxScBe8KopetnAuJ46PYNB3giKk42400DHg0Fx//7
VQf7u4MyCmyAV11cGMmB1qNrYRAvEWk9l2KhHizfT6aqVCxGpQs9dZ+KPVrWcxzu
tOYDh2PFn8WJz4Id+S9ivk4cBKSEUeT+HEit72DZCdAB2f+rtg8/s+/JME/2E5ix
Byvr1lc1uTk1HsN0h6MsTRWO6YbPcLsmmG68LgfKgZebD+sL0CuSJB3IXV+9E2Sx
4nO8vbsViMdPnT6lGCqNtpRjeNEikcaxp9yMTCf0eBvvAFYu2M89PBwlhd1mvg3n
7DrGM5Q3kcAjuH2og/x/FpmKJil6jbuENeLd3W7YiyuOdGoRTJUX7+AMz0+4bPpS
SQxBK2x6RyKR3/mq7AXzTR6ywoLn+m8ViwtdEFtIpHO5e2ZhSPjc2ut/EGxpAlT+
+pk4zRLcZJY6qYcFyHfnY15J6h6ok69Eq9aeuq0qepkn7igKpmtUZD3MzlvaR9E0
4B4JoIWY+xGFcAHq9qFTawxVXsUsWWcFRBrDeH3SdIyDaLiXUvqsKz+VtILv6TM4
G7bAZlwJvBvjofYPQIaYBN7IPTQv/H+tSfO7+G2wAKtEac9xWylgefwBK67CByCe
i4ml5TpcwoQkW/uJVuJg2AseTy+PDQWfEXK99sxly3wpgv51b46JUVN+K9u/hCXR
Y+l9rlOT9EytlRpf3mEsLkHEOC09z0Wi+787wOKoNsBUj0tYrNB4j7sUBDNPFRy+
VgOyeYUzkGi6/zEzRCMYskmGxS/tFGdLd/QxcAkqVGKWnvj+C95FzMMl5w9ENm5Z
szvzosBqby4DUsSqJjgU8JWZDB0yXBdymQ886Rup3LaHikjMsO1en9jSkVllOC4d
dlUNTRlAuqP5Oy89rpYF2wDHEGWJV1oVwAyhgHQCvoMlvvQeBaoUp73X5HIvpHYb
cWNfod6d7b/7rFa2zA81Jumcpx2b0uUML0jITHoRe+Hs0NHX0IV2TjsScjaO93pz
XASqyYW5k/vjizV37ewHObnMufYqby+99PxieTPJLbd4wjCyNDj3W4I2fQBcicWO
DEp4bSDKuXYW+FtdUVmoQEB/e/My4g4CggxIc6sCX9ozhta7wKj1+0ljytiClXAs
QgqHuAEmgVCyNNU/wxvqNHOeWjnHCl5RxUkRrSDV6KxKdOK6JGMAG6TRiAEN9v1c
akwA8BG7SQlmr61Dd9/JjRw560ccotxB8IIVK+4mPmiZX9MELxkQ1GjAigALR57T
+50W0zsuv6JNpUP2++HYipt342XgJzhByjbXuPKpAkeq0w+2KymtuhT6WAvu3J3T
wxz4JJylVqlC9rjgI3cnVbRTNyUCsfLegJQn1bRwz9EVi7SQu6y07hMmKiLd643P
UKNf5keMCakBIkaP1Xy/jKgnwhY+ngw1MvHccmnMpYwEKqMVPhvUOp18ck3hgL5D
d2p1aqF0i5LQ1HQiUYet9hZBSI0CkYMBEDBVibxeYUoXj1zUCiptXTpB9rQLwH6/
dQVj/x/K7MzhPcTqY6EPw2C9jn3rCR1HjDiAgyrahlKJzDa9mG9Zito3TM8EuoE2
WY5gdeUBryOcFes2h46oL5jo4BGp/a7GRJUByi+jXRGSBUP5Q4I1dqAgUcsb+ZNm
9hkcbOPBHmVhTxWMobraodxcUGaJVmgF8gryBdYCh0hEjSAyGb5EVVA+aWlw+IPN
4f8x+f4/0QYtZpqua5iMfjltONB5T91DO1lcaWKqMeLW34UGp3Qcal1N6jDeHnWk
4EjsExOdYtxGVOoj4N36aGGpDQ6NKlZjot0g4ka9x9ILFXbGxRg55vQ/9S1WrIw4
82nx9r5vHEGGgrlH8w1xb6n6zMAP1shZQGa7vEvkjCFVbdOE08jI/8gis0vTiJ97
MDVvVrUIvq2mwAeu4/L9X9Di6KPui/wqLfAF04vZ3x/IRJbhfOqFonTf2wm1+RBf
y+aL2lLeRCG1zj66OAptYJkCJN2KtDJbFpqzt+kcoK/+M2uX2D1xD6x2Kg4/uvSI
YiWF+R215HKm50hJanIwNwMpt7X3Bhp/PEK3Igy6TgJ//CpxAL/1AhpX+tfDX7Ea
Y6i44elFdRBFLUUERHBM+4WxuVzvtPnmBNd67MsYgyUoIW9RzOGZWS68Apz6HJ3c
qg5bRonHpD9KJWajD7OhqpQL4XAJrONyTu2Rxbno5uvRtVTAd0KMl+IG8HoHPavN
hMZ9GlopA7zeyZUSVc41RUmIdCqa3fPcjR1YbklYNjgV9sZ/VAl6QmPr6N9h8yzr
+6WwqQWPDhrJA+MwpwH5H/bF8v1LSpLSUK4C7pT6GjoHjkssNk7sQl1fJLYEMy33
jWweNKqQvRKihjEAuL4SKYrCUJLvQU1hSyk6e6T9DD+ppJzXXAw77GDrzxSjtD32
gsJua3i/HuYsVEKxsdvZEzcIDvxXtbuqJJ0bFD2Pd/Kd3hNhKO23SYc8WS9NpGPU
CpM3092idU4fYN4tZOhYG7tQWNJjX0yKCeKLmp3UsjTfiouEX/SQHrTPh/onmcV6
sciGooxWGMkShPZozxBZZBMs/A4C9/I8HLLUS5Qr08geG3uVnxMyIUA8oAl9EqHG
O5u+Y+XZGWNS22gK+4CJEyI5a3Lmz80sYIieYu5kpFlDQtiYNtsXJXncXO3oJOBT
wpU9jc3Dn2ipzdHX4XKzBrr1ojoPmnyyvMWcqLJ/kfuRPVrdlNedjz0z/kGhy+pN
24hHSWg0YIYt00N9iH/viAqTQpQaPPuQApTjWHuCnJkmDh46IUDeMmdI9xBORTXS
t9lRldzoF1KQ8XL41dK7IRtwIeo5pYhH70m/e3aHa2tgMSESLFuwwhal/2GOTfKi
cEZA+px1Pym8b+HheEbuVd/IjBUcyJDEChMeA5o0KocOvl9HzBGJCJWyrcvodSXM
JMgDBweLu+hyfzi4lgnY7vADD4DTPRK59NN/UzAcfKmF+7/wF68wqPpivw+E2W9J
FUivFjywGxjFJbvkqzK+X5o5JksURrpZLkhJ1J7gl5Jodb4fE6YGYzNDzKeTI5wl
5NnnrByiA32m/NvBZqeq7WXN3/kSVGYyo3r0Ckli9Iur9EzRtaIxTfYawUbzH7j4
22uW/HSFx+m7MtBEjn4BRZezOefCw8q1qkMe6/toKARrnDelOMs3/Aiwuhbwb3MC
wt2dpk4HNYAau0FSU7ZeYM3GXVNraqP1QJIRwKjtqSPPoaKN6tvsrvbY3FN38yWK
S23+JFrtPwIUZjdVOTiBJcxDfeW6CuFiv+lz134NgTbOsjAmlcYOj2mu280AWmz9
8GBjyvd8qVKtvQy/N82KojaDWmGc9unPSnqNNBZQOeTmEefWbtGgLLw58ITQfk3m
trIFwuaxs4oPWg/xH7HYQSZj81Dn4/R7qqZfFCV1OvC05a+a6JUSvWkGl6QiXsp5
Oz3Ot1awl+WcNN7bX/skVyrO5D9W2vX4qtvPR3CwZ5lGM0fEQmPzkk+fIGIChcIm
nsbw7jnes0pPagrxJWfoQfUerv1BLc6RyqwZ7fRs+DYjr6iMLbd0eX3w4j311+9Q
oKf1UAcblJw74RojRo/x622zlx5uE2ROPfMvewpuXp6Qrq8pNfv8PauWuB8TRLH3
EFQMTZsvPZBjZsFd7SwbS2Y7Kka15rtsNz1JkJ/DtfNeosqwo8g7jteXYekjFAs/
Ok8LG7hP/b6hhQ7XRtu3SGCkwc0OpwCLPPvLewfd5C0Z58/ACfyjVE9CC/vTUAV1
tm69glVIfiRfnEAf4vEubDCORTTkThlgSjTpC6U1BbUqQayDMUJbErvY7YFd6/No
2hJP5zoAAx62SF08czmKXKrDdiK0EixaPT1WF3mj6nPIAT0OP7z9Sx/Mw9m5/1U7
0qL6j9mO36ocRSSry7SHisCbQiCSs/hoj6wzYT5FNSO5zhYojNQDGYvQSVJdx89z
CEe809gRuvwf/1iSKuLiuGFMIDFkuOLSjUKuKVg/amFfvVerz2JJJ960jDC9ypLS
z5djpEgs1zSkCjf+gYcYRVLy+/3kH1bQZ1hciQKFfJ60H+SYMneM/p9Iuzb3VKUy
hNsojVcir9iQLCr9pXhhZXkYbvn7GtLQ5xF6a+sG5xCceEZZ0xq1D5deCQeTpK1K
I0qV8toyyO78VKrSuJaRDjcsl67w73UkJbqty4GDldy67R0oQdL4C9kk3acXqhVa
iunjC3HMuPzwKfFrjh5gz4lZQzWPVKtbBqhjabwo/HWyMXfBwSF4pK7iDtIa5vtH
KiDw9uwKXQj32QD26AbyB5Aa9B8N5cJZZmi0qMB21nciR8pGdmJQtU9ILoBXxjYm
w0n5zSkAJINZSCXspXh4OHY93nsQKjANKlPambWoW2HrJLUdeOwDZ6yQ8Eguczr1
e2xKlbzXbmXv9GFfBqU7LQG04M+afY4SBP+wKhWKRRTePePkmjubsMMWmdKIBCwN
XSY1rHhrJ8UfhLkyZJ5ApiBOgoFGnOC0DHQLwPdfR/9njLjydEEHWmQTynjbAowx
b1z5RFN1hmODLeicMg8LqXB8Wj3ussIxYVxEPztZtnse3fZH0HvAlYJcSP6O8DR0
jCkHUUitLMfVDZr2pr9uvJ6la8sM/f5HoX0F94SCBwCDMGZkhwGUYLvyKqZGrxty
VMMJ7LKy2b3C69aCE5oTe8LvFgJTxBkfEMWobwIPKqyo31avwR4TYPRA66tyCIte
ZqZZBnkiisfocIWNbONNEDhWRzHWh8SCYZv7MwZpC8FlNQ/L9/a2r+tnv63HOKDY

//pragma protect end_data_block
//pragma protect digest_block
u3jSZIWHMPkEyvTqOrvlmCY/3nk=
//pragma protect end_digest_block
//pragma protect end_protected
`endif //  `ifndef GUARD_SVT_CHI_HN_ADDR_RANGE_SV

