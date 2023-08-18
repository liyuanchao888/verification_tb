
`ifndef GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_apb_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_apb_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_apb_mem_system_backdoor)
  `svt_data_member_end(svt_apb_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek and poke) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();

endclass: svt_apb_mem_system_backdoor
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Yk9SbtLvamQSzpoWj6MW/0pGJOsQ7S8PR0aktpH7fAFAxsl7Ctyo29hwYI7LdBRP
Nd8wNPGx9ZkuKvVY1PP4p5ai1i8cBSSR29H0i0tVUKXoZwuBXIdMRdGXiAshIC5B
oBKwMtcVvxAI8U0MEvZPejZY5p5y/HofK1oqZia/RHs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 866       )
YjB5N6myiElbZDEWWdUfYP/S8e8t3MCGhw9Bhg9NpBHZJgE8Hr8liPvSAp74AYaV
/tMqQ2RW2uHsI/JaK5toBoFZbaXqDRfi35uPSDB0Q9uNSr2WuC84GcESwxHGbSU/
NPjnmUUtSAsX+kzsDYFanitZdMyn1tAa1C1xWy3XFJ3BVUVOPfbqs08+bsn/05MM
wvWCD2bI9oD/pxbzOtdIFY1dqgUiPMMfMw3riVYbv98qS/+XT+aHJdY4Ec1Po/wl
aZXaSyqxXkCRCmod6ZUmZ3PHuyfhqxv6XtSLi6aTGQQNODs1NupSTbMLRorEQVXD
6mF/QiLl7UpJ1sr+P02RgEEzmok24UZw1BWzeSd9GtiLOLoI5pXqtN/WBExp2jfX
1M7CoSL7AgF/qbUiec5VjQoKGGzet+nggSFgQeS3xEKO9Hglk7mwjSrsmymaTbDv
kcKluOMQiL6Wohn/6bl5ITisRhQ2PSKNeEamat1extoofwCsUFfO0qd+OWFrwhJh
VGcnNnyjw4il/flYSadSb4Vs5LSt2ll57xmtBuEmvyKt8eP78Szz+I6uUuFmpBtz
g38YvKeL70kGXmjlvX1u7WQ5U8BbMKo1o/Bobo7JbTr3Zo3I15+nZ+UzwHy4FPd2
W4RL/T3diHXtJw/ZVtCuulzCug0jFHtuBsTnoruqxApECxQUZSK9eHaPcJ5d6wKz
Ao/RnZfwJgIwlH8Rkkm2URlGeBIhwVgxmjZAFJEWkpPDwA+I5sCRkG0KDHx+BQJP
0PxlRstGzybBKqsdJDiyKkrL5m0+SW6xCARk1Z8YyqOEXXoy+OdKKLs/5NcCmIqR
tVmfYrNfx8UVlrM8MJK8Lkg6zHVaCst83UU+sIxgGDerZmJrAPHhWgx90p2eRsEa
SwGo//5GKmE9lEjHBMn1hsFsVDQpxHQ0wAq76v/2uLm7/HV/0PcQrpOjQQwVE4VG
wwoRBdrweIncVH0rbmjpa6dVtrZFPGwGTHEXqsgSHmMqMjQWnzR4N0GJDpOKFlzC
2FAUwnYY1vCmcM/84mmEu2P6FW6UFzHxVzPhv6f156Qh3EPv5VbodY8FicFShWVN
M3zOhpjGwcxtKPvzXvwuTHAsZnmLBvXBfKrENsKdP+RNF3vnzDTZbPwkz8OYxyca
+qa1XGUJ73nxMRlOLZoMzg==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MTzZomxN/mQ9qzaMZ8Bc31YAWHB3OL0bBDGjRY5Oj0TvVPyU6V6xv6tKClx7Wjsq
2R5miKsOUEkcHUNbXZLK+HGlXp+2HpH5zI/4yUZH08o6nMhJ+0vAWFyRB0PWho1S
ONsAfpU2yUgJSlDE2/chtsOs77s6qtLLS/lPNkq0o7U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6469      )
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
`pragma protect end_protected



`endif // GUARD_SVT_APB_MEM_SYSTEM_BACKDOOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FmQzk3rc7xqOycDy3PvPfCrIm0ZiKzPYzPo7nDNKAk86Xk1gF06Q8gFBIfzUYV1g
VtNgiSiy4k5CUMe+Naifkpx9e4WLIyd02GhuP8IYQpbLTakFFL52uKDbfUZ7sYRH
AUIBLFAja9KwyI4Cbs2UvAHFBukh5/JExrkFKsB9kbU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6552      )
c8B759KPM8KCqouVEONXVKA5nSECOnD2IPKwOF4ky1152tde+BIlTaVsReKxnEwy
GYqMT7EC+FQehozehS/iH2ThBhWM+WAlMI68UkCHvM0h3/0BfMlL3KjJxUv1wUgi
`pragma protect end_protected
