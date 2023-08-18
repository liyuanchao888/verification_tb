
`ifndef GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_port_configuration;

/**
    The master snoop transaction class extends from the snoop transaction base
    class svt_axi_snoop_transaction. The master snoop transaction class contains
    the constraints for master specific members in the base transaction class.
    At the end of each transaction, the master VIP component provides object of
    type svt_axi_master_snoop_transaction from its analysis ports, in active and
    passive mode.
 */
class svt_axi_master_snoop_transaction extends svt_axi_snoop_transaction; 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_snoop_transaction)
  `endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_snoop_transaction", "class" );
  `endif

 
//vcs_vip_protect 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Jo19xKlR7sT0BcpSnyQWmoEbnPNPutoUJb3mdLQb4NwfBzpy62YhxrwZCdKQrWth
AtDzgIqfqu9zaCfa7VpWvUKQ1UDJEF7GudPY9GtMVpkbBw9S2ov7K44u975fTftU
TAGEVf2gK6OUgZDKEqs+qaXp9Wd2JWR6NX6j9dsPN1c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9505      )
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
nxnloHyoVCFMKTC4V/+F9g==
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_snoop_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_snoop_transaction)
  `svt_data_member_end(svt_axi_master_snoop_transaction)


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
   * pre_randomize
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize
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
   * Allocates a new object of type svt_axi_master_snoop_transaction.
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
i38ZJmRb06Zn6Q2rGwu4ASXYFDd5kFaxPtlk9XcalS9ngvR/+J+TsIE7jRwEKzA4
XTbyMSax2vAuXW6Pmadfxzsdt/mHdbeHdLKooHirgZdS5YMBjN3R3CrzYuZnjj+3
/FnVQrE+6x5M5EmCwKefx1sGQaRUotFaVhYDzc0SjbE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9625      )
7qUznZyYqOavqj9nvOWE7UaYZcKO6xz6TpF0xA0kYxUpdYY5h7k3H0ur374cCnjF
IKJLmMewMLwlon7Amskhf0O/zDDPH9EVa3VwZmM/0WXtu1tpNpcjkY+bVIQ930P9
MUR91VWQdjO85PUrqeW40F+VdkR0uTXFgwEL4hw97tw=
`pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_snoop_transaction)      
   `endif   
endclass
     
// =============================================================================
/**
Utility methods definition of svt_axi_master_snoop_transaction class
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PxfWtO9Jwy5j/JNsOUcQLULkROE0Rg4jf2zS6FVp+xTfGu0XG+BHPKVBCgGnFUpc
wK34x86QxWiNfHtcGrpPLcdTtVXGgoCT3j2XYIXqxgAwGkHqkXWWQkX9jodpTzAb
ibVaClua7G1TJW5a+6jAgx1rFp3TAUEBR66XLsStrSY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11232     )
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
`pragma protect end_protected    
// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::pre_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G3tCG/vNEh6JOIgJNbY5+zrtzZbV+jtiYlc3FyWfFZUa8gD3q4ZBUlprW/mUYtMt
P2esVxM23t8Mcuwj2Ppfu1ML1W8zeMLcT0jaXOtTvi8kcTd1X3XbM+NCzMOlma6/
4FnIK5i2E7MRNa5LEGB5xk5qKQrJd855VpmbiYwBhno=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11480     )
v1Kf0++prazITIPTPgvXsAFzcf1A9iG21b+4DVY+F6DR3s0ZzzL/2rQ4Nucpc14G
yaGKs3y55MVRgZz6Fkh+o55Zgt52FXPlh2QORIzooJJmrznQVmhZOZoHMChg1Gvq
KYotapMFnK6Pwj5hv1wWkkbAjsNA7XwPYQyv7sHvOdCVgpZSJKv6TzdH9OAERmG6
gIHgeK5vDPll2vrf5WTEzCsLkuEr64DmruhBOkJ9P572TtYRdaqP0jWxgKwcBQ+5
P86am0494QEQmYeS+YuXnzbr2IorA3Fx+VG+REyJsFUER2L2jnBZWFNOuZ9jpqWm
Z+75b9xPd3/KZwFJKpULRQ==
`pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_master_snoop_transaction::post_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mr2gk+RR7Xh8X2CSZunG44jH0RI8mWOVRNWd/VAhuVQWCUkqD59vUj6s9zKtJ8Jp
tlzzLK3lDMZeiHqMUW3bahtzEdK8zYKPNWnc2qzjhKiSG5qOy9urxQeG7836W47a
3TkJIagoOCzEYWpaCcbwXbFWuLifeqx+JhgrxM4yfhc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11589     )
c//rQ1zO7kCsRtcbk4g0l1T/QNuNH4b7e/kcaMYeBanyZdXuifipXnI7l12TPiyu
U2Zdq+x/j7TgCPqhw1HN2Ag9kFJKXG7cqn2J5/UQyXYgVjpTkt9iS9Fi4BF3xmg/
Ewl0/ZWsvLTNaYPy9q+dlQ==
`pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZbbAdWfHLoTxFgeif9/Aek9wLbQ2aWobdEsCA1IFJ0iWdtNdcwrq5Vl4W+cwk9OZ
48aX4AOT+qsqw+B/SkeGQjfGeuUroWAmIO0BXb8QW9LDhn2FGTJdyp/ouy/kb2am
dL/VFqzUN/Uv9+n/XRag2r8KiD4bfZEmBuNEYq72ooc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22742     )
fXMC4EjqHXFfDlwN7Hk+0dPCmlr3E8g1/TvQPMg3gwk0+pDckzgIXoaIWGNgV9Nk
2LEjC0+PLjtTtOISzDky4liR5Rlc6yPl1PLb9xAHIHaWeQ90yrxWiDNM69zsRI4L
hyUdtVTo6RA9c98PMW3O6hqM8iHRAsTtwN4yEZ5ofG6JkEYsfmRUuz/oNuyTjm8T
XkNjs7DWnc2kifHgthaSY0Zpt3rWTP69NtHO6R9WaLDbRk5xcblx1Y/tZkEj5tlt
eycCz3TkGYMBwzv3sUHLY41CvVJmexhOG0WwVyBYTC77L5R4daL6uPyq5afpYukv
SWLIlpMqdY4qTmZqLA73f6lW2bUhgw95KOd2ik0o6+o3X/QPU+f3+f5ZMIkXTXRh
C6ubnQ9P/K2RJgt/tsUHSwFTfyS8ao9gwykFan4j9l+xVASwTFnwPXosHKp07DzS
ERCMRso3eqmfJXE7K6PTiAnjffNi6RHA9lraadmN263dOJZT+tsTj4zz+z6HyKDy
x59uOlQ0Yit+yZ3/oL6FuRB6yaGWUoea7LCyquki4uI9KTcrhOyC/QkzoRc1w2oQ
8tHiyR9YWUYIY9DuJrbPT613k/oyUcv3SZYpQ6SYdkfctW0Qk71bAf91A3IyPstl
bt6DrNTRNQvWXLh0OJcVitBi6NGg9oVT6ORoxbmZ5SXZshjQt+HkSRQt7xb22b+7
/d3H54XNJzt+BznU4Zh0DddmBTwm1w0f8g4NrG3ytq4+O3KpnLmzKTpf4nahbMaz
DwGvQqUTy4cGgaHQJxicgkFBInXd0SRb0PRc9D4thTHdzzkV1oqclQYzBHpHWZlh
2HvEWYUU7cLSEnsf9kiUwBujh3PDmAMdfFsG4HfDRhY4w2JhDlFEcClRsaazk06w
arNwoJlGgtCHjBjg/zLvVRMZ5OWFr1D6hWEugD0MtJvEW6rDYxy/V4x30M+tUwCl
RgF2ExxniLydzy7NAdXiC4/1Cq4wlLq87zz1ve2Vat4Vp5bJfFIc1MeTb7C5JL4k
9IL08a9Oia+GPjx5KZO0oCL2yH0Xs3L0ZpAAf3lba0ZPUj75scDn+Glr1iGAVUj+
M9vT+I9/X2S4lHPXSHcbUawY92I0XLFZImO2XKiyo0TZJ88jjHwwpELmTCXyxVgK
jXM9LJ4oKp0dnKUXda2rTPfUlcz3kFa8wxLH6tFE7L1tF0E2KC3Xd6RQJBNuzs1C
5AbwbGbKCh1Xnyq0IHWWoPLev4T5uX9jtfAWvA9u9+PyhVn58+v1CHmSHZRlWMwz
94eLubgkX66R/fKgQbrBCJdWFNvLjGWvAY+AkqX7K+CD+GsMH4p0y6AXzKCMpAXy
FC3Bu5nige8vHKVEwoFyJRjqrj2hWOMu0amVlpbLzO5T02wNkY2VyNoBOW+EE1Lh
rEAHhiCb76ZV6s/g4hVBchJPJKKen7vg69dfLfOfo9rfPsXjX4Z07VkIuhJObTR+
PhhINaJOUKK7UdyDqPc5/d1Eq62SlFY8GMGgxZTOqulMp4X6XVYEg+DqA0Zh+xxo
9/8DU8/1oJExLDq/phUE0fYZQN+WPcWjQaL4emUPrsGydDoA9s0t+hRyzUZ3HR0p
igxXQ57ZZwAzRS3TyX8hwdn2S+EHSabwRTi95O79O6mjEhwM4gRvWQ4vg5MKwPpa
ZpM1rn/kwMSm07R4iMSXvRk3iMjDy1uFSSegXlVIQH0COwUHHn8uM+X/0lmqVOvb
tbfZrA1L673dK6rHtl62DpglAQv2SuR7vJj+Vvw6o6fAmp1xPef24zbTWbLjsMBC
3vTDDqxjiNgcx7h3CsAvBDM3Wdlx50InQRFzDAbn/6mcC+77VwtfSuh5Lkw/yTYg
chYnvS9si59rffuHk70QW9sWaoSuVJwsqyWrEIjFm1b4R9h/QBZGS4NiXe0p+kmo
zz09/nles7xwl4hrf2SAvI3Cg1EGQQp4eNL8mMP4JOCY7Co4xO2lxP3vUuUohWJC
LitUCe/OrdFzrXjyh183+tIVXhcrrkvKJP1qtwaBkhK2YFRns+48xvPX41e17AMg
TyoC9pUo+92dyKS01j3aV5rQOiEBJB48ewd+Crr8k7lS0AYGpvhLtXpGN4F258e8
jOs32LYHqywAGX4xWhNHuBVHf+ZhFqhWX50lLdwt7/T/UqJPlpQp4XolmCz3tWr2
q9NPLUZIae8r9Rf0onXUt37wXSGUxtaoYpxBGATnKqQPc2Ef5caTJ7uc1KRcXmzG
0iiXUvhSBefc6zh5qykfkdgZQDlcqcu/kuIALXNwPd7BsUh/1UdhL876llJJwxhH
vj4RRKY8TmsZiorxGa2jZ+s7hAChktK4BMV1Y2UUXzt6J5N0hg7cajO0OSut6sWl
88Axz7ghTCiDJbe/8PY+s207sNRDBaMpyzUw5Xjv6muPS/dj0cqrTl+UFwSPD+wL
TqgAu0tw9U13NY9uS2pjhZ3Nfy6kznhF7o+qk6Hvwh9EMbdL0DYfc6r/DlMJHVzS
UcS4Y6fXeVbJBaobWmDvfzMgAaa/8a6c1OOKFV4BDe9c57hEJbTPNhVFYv3d/I08
ZMyLpcBjWKJ+Q7LFvoE9OIQvDlETwZx0ReIUHGjUOY7OlUq+75WeRIrdkujxlVsw
Sy9Hog4O7YrevohGgPfbGJtOoA3L+LgUZqSzqmzI5onLUHFzdiOsSklTqrd87G+u
ali6k/r+PEhPVxphUgGN/gvs4Tk6fCtBxRDdQV3+BeH2Ioi5mkaVzNAPxAN0CFf7
Iq7ZdkJkuwzTvXLMrrKoXbXr3uQecUMfqy4Fofea7Xa42H+mJWjDBcH2GSmwAeG7
GZ+QKkxCJfQ7v53AHF4WgQyLzlpX0SA9O7mebxs8DP+/ilubOLv/yORz+/mVH2m9
8A9np4w1xlL/WQSa5fHEhf6Y1as6ECbRMFzNLPPCT5ei3DETXmfQj++6UsIVtt3O
+eoaCpEgGt+6cEvqWBzg8Ll3/rgC7ycNEx5qu1KhSqvA2SnpeYUfZQSWYAAoGTz1
3YVw29/qB3Nl5T9AbTrd1eICVPuXPg4I0Cge8SdRg98f2aghRKvm23ohAeLiCSoZ
OMr95qoL7Ci4hl8WJM/ETWb2jR/e0K7V2G35i77DmkUd9lbjl+CLkCsD5FDT6ARw
xO1HRh5Rm3a6xCITfSiyVIq8w6k8bFRzuD5H/+540KvcpBTlqr2U+2QxW9sCXyhi
M1cm2Fswsj/RPEOIRy/vx9DXWdIKzkT1s9bl2PFeUtLWqCUQ5nMN2TCRRer+RbD4
p9QpcdgDva1ARtV5s1Lq6Oekeq7+Sej9XiJ+iMLzoD9EI+dUnnVwjd4P0o/gBuTf
3xqFqrzOPBTQ3HvxcvWxKiG1hiUq7ZYNn1UbC+sHC0hIprDxqFZ7y8gzulUCnxOS
F3pA0y70d8OLibPrBwnQ06SMZ/T6Y/FRjjHmDTE9Rv4voJN6wk7j1uKrKg64kJXZ
SPbH0EQ6/T7+rZTfXeVK7C17rMmHKLDst2BcEMvkwkBvg3xg2HAAjxZ4Dr6tQLBn
kil173RKjnls6S7D+ctECVHGfASGYybiFThbueA99vaZrTdSicdHU5pNCGLhS1MQ
FabGQ34nc8XkZDuYfYR2yy5UEkTIqlq7AWn8Ul8P9KJhdIgbBfUyZMx2ndPlqVJp
CPafmU7ilj19NG4MttO8J1QS0cSPW+J/6pmLECFGrAWZnh2l+BrU+JT22pB0m5HH
bmE+z0mb2kxxdyz+k/AjDB7oVKZqbjJcJKKg8zgmUhWdAwPJBmoPH+tLiuoYIIg0
hJ9rk8YczX1n7p8Lpb31sA76Ssdvf0FfsU1zk3L4FNF7jG/Y1lFoH0gW98wTXBE9
HpmSJj2ViZkZ5HyflLBKOO42gw8kLwKcACwzub4eAV2cHc48gqlYkF4jRVYWru3V
2LGll2aZ2YbCtr9htm5bFzWmcY6LfKcAe96a1FEDIjQUYXe2WpHnlGlqhqX7cYt2
I1zWDBqoIkvZeR//68LypauEVeNga9Zz5j0XJOnNtfL2XXtWy7FBsUB/5Y8T9vHh
j+Ou5OS9Yg4IhwD75ApTV3cWcHOYD+sl2W7iYyEWCOn6tJhcl4MaPFlJpXYLuRKL
x1kJA6nA5ZoYqtO9LLoDNNoToqGKHDHlK+WDVRaz1GE+WiQOa0hzeM3R6f3Qj4mR
cNJjfvypcUMpd4Y2IsMwbmoDu2d89ECNO0Kl+ObJ62drIInzyAhRfJ4AX6KYfbtA
U1ScMo976G2mvSqnXtvoF1E0tW58YH98L3aOoCElJu5uB5AuR2vEfSlgvjzN+SDu
7yf4O4j2qTe5jiJPB3u8+cjA8ce3S7W0ZiagjvT4Tb5msu55IXzH2G9UFDeVWLTB
cqEMt39bmv69vPfFxde+tnAMqA/IxbZqgl07Rh0JiOXUyXwtWszC9sN64DWfjgrb
ymLg/nUqCwwDQMwo/9avsCZdCBjd5oAgO016NmDASshZHQ/3TuJsMTUH2grvrAV2
pZvCaVXZ4Z/XdJsPztm1pGW/Ba14kIuR2eV7slQkgb19IMJzw+w3M7uEp4Bgnc29
lgFocxS/8QQzlCf2wLRoRoh3btsgy3FhDda2obzsPW4NXHzZ469j2NWtCDZFrN+y
bkk0gk9wYFvygzD2KkVlTcD1jKS2176fNHHS8JnTXHkVBagCVgnf6rILNZbbDY81
fyVxLaG2RgEFtMPbP03YPmlRuRuSPeoz0QdxO2EZyArzOY2Kmw4Cn9dsB9hEbawE
FRwEUzyAGOqYUa07AHblSRLysx5oQ7VSwEisyOeyqnEixgIIlh6vyurgnOvFaiU4
q1y+Qgeq7RK5R6IdTQ88/GSEaS6CCgE46SnPHVeSwqP/19O4X6Rb6dKko0EFvb8M
RGbqjHj+az2v5GdHfkIguxpAbvqC9h3h4zPFOFXEWmSJHVfnlo8DyZmpl4JN6SMJ
J7kuz2TtkqTjYueFoB3z7RcazIKCgMuMq4ADpsYyBlNxTo7FsRpYY3rn1oVcamfF
+p9x8wNTNoNYMVLaEvtAulp2njME1lm0B9APvw35gsv4iUQSrNP4jqJBX2UwMfQL
n/flfJxeN0whtCGv19rGn4umUqw6fr3+tnKP/9tRXsoFNFuIw+hFbugkGfvaUQzu
j7xU+5uOOXleWohNd9e6Ap4Ccdjx2Q4jIGZsJN3AZdwwjLk1sjKZyGk+rMhHRq0S
yjpTK0UI8Pmc1649Nr1kj3ZKiplmmGqCaY+w4CiZxlM95Uw4CEe2iYtWfs5A1spu
s3sboTdG1XCasYUZtIQE5e2otZgWDuXyjS+QGlzEM9taQ/gUYw8i15mOBcaueiuk
nXNoBjtmmCcIgSkMzDJ0VRnu4PgzA3S7gVelhDz2e+fnhWbsXrhqtqMQGeAk27gL
M6HlDU3MSQINoOFqU0AMgQ0+seyyViHZU8w1kJzzuj3OD2Frwa46RfSQE9C/Gx9f
Uuut1wRhrr9eFzRO065dxG3N8Y45VIuKDqwNFzJIkK3BZr9Yf4z4tRgq/oERrRS+
367uRqkb8dJQ8Ark4WlyeOdtI+g8kGgF83xDxRKZrOXuPTbQjlpKXGGLgrLUYp2B
2xxh9sf6sLCLO6QPX0ecgRgdBFxPm1fhM1YO9LgLFClxbQLKKhtNv+hpkSbH8a4j
v6bTXJf/A+VR4nREFIlGptku/W7HTVRjyn1v9BeLNNxZ8qTs2d6DHfg2YPe3HT6P
jmm2OPy5K33D7tCa/RETSWmrwdwVlOdfW+sz8zkFmaLqkuj7NhNaQQVM8+alD8X2
1H3tfiXc7vDaSX56lFxMFKP1zpD4VJ0FP9zzvd77M3xpygpFt+EUs/aFxOmJFMHl
WCfNYFy776mvjUfnnu9CveNfjeooMkH8DYuxm8gAkT3fnJxEb6BuO9YAlX0r31O/
OKgFkk2yr8TgrJmd4xiHnYFfQEE+8fTCxAUhlliyjLPUlO1zARM5Rewb8GULvOQk
JReYqoK0K3PFvLbsB2uFwARKHruzVd7R9YLes21AWXiZtQgDb6MP1R4XkpSMJxKT
qgi3zP9i3h9eoKQODKvaRtmMmuKtkW/LuE4Lvym7HB8Qg2byFN850ZZ8gTZHw19g
E+Ph6DUM6UOioH5mXSt0GMtDf0z/cROkLWxM2bjGjhhCN2BjgcDq+4n1D9oymjTZ
le3AH8/O3ydxXkcMhI+8bOV07ChC5vimSiX2zxHkmon/ebOiKO6NlSQaB+87Mp7q
GWoxLA39GfhYTFzpqDD2BV3z9pyRm6EXYtzK3VysEIlfZSaLKigCsOpw9Kr3EH0a
gJjdI8H0FhogXdRuz/VpGMvJWxBx0ba+tmoB84PRpG4So1YvNJL7Md1E21sa05Vs
LTuTEIw94PETL7NW81nd1Qm8ci3fNdll3TrFgSDCBtdlvM3kzrds7BTWlWwbnT2E
p2ad+fJp6I2soJiUPHi/XSyqHaaQ4iqnftT07dP9K+ssoknk+LtYAjEcrO5NFWcO
QU9hFtzbh1B9zxm1Nm1gce8NTxdKi6hEVbtfIq5+4V4kig4hH/FcjvUH2+W/mZ7k
ruMs/BGDEFsu2zyM9S1X1Ux7sDnGJObegIbel1pbtD8LiZbFiEKJwJPCc1Ot+Lgv
mRdDeSxw8XswRbY0c0Bxi3QkQ6nXt6f+QyDGImZxmgw8wWxoBi1MVJCTDtvxAmsQ
zM4AHXQX113upUh1fxbMsL2OJ9kAQg6mmTgFEBf8xVbnixmDnfb54C/d/g/76W0W
kZuOeo4VM6ch0JsYasc/eA3PIs5abcqVOAYn4z0cOoOlxHPy2lt/mom3xf4z2wS1
+Ysz8y0hnyWV9DCldB7ggDC27iVqzt2cwfh17zpAjNfFnDjc+E/64YUH94ioitJz
WMQV+dScZwudVaXRJ5y9eXNepwJQZJLWei41Z6EdVIrVMj1cCO8RbdDbbWCZ9ivM
ykC/iX/PQqLNc4iNMla1aWlXLR8apdPxLqJT9n9eS3SqAypxHoYg5QkV9Ijd1HeR
MpFLhaAhxQ8jthZldfGnetGtLTBxOeYESgv6t9Tkft/+Aad/sPd9PLBzV73VSF2c
g6M9/mxGRavq/tjqY9aIddV6eEEn8kYdA00j8MBETor8Ulo+hhrb9htguppsJgnr
otdenCd5MUkNSIvf8PhFfkcGrcDLyjdY/4ozU6cIvozwaVeF3NoQhagpdC9wF8If
uMXkqlWE4GqsXkOuXa04ZA0NwdA8cc8+NDXrwHgaQ6XAejou01e0Jfyd0FEqZgDE
qpUMTjrr48bbP+PCcdphxoXAn60XdP1VUK4XYETHGgN4TLXo7O4+j/dKWBXftGUx
vj4FPTb6U3QuWmf5BNF/bbVQBXuUKKkfnVMLAcHH3DU0wf2nvtvu8cC3X1vg3e3R
YhOyinL8PKHgdIB7CMwQf0MSmd1ZfksarevWbBx/tAd52J+x6Udyz4NDxNe473B0
armuU/ZHdgzuK2n+qas08hFsKzWx/FlMG80bDUpGF5sbS8xnF+1eWEQrFtlLfXeT
LGay7NG8CCifEKwp/AFM4+XON0gOqb/RFUWLC8cvt0xfvf5JldelOrRkOF2PTTVs
e4rplAwGrbQ6f76QeqO6qROdLWaqYoFUVgmj8wDXryKK2yxn4VP8AICW4JKxAwDi
r3ADODQjUzdzLRbxGXJsQMo7XUaUH2fDPVIsOgAs8Nk2J2QcTBWRMUK79owLxvKE
M9cTC+bK0fSuQUW5c12zz45xqLKdsTgG2CzBUH0yAEqcVkUbw/3BLcmnMCSL5YjZ
Q6ib7PvyZ8a1oFj0hHHNuSAbkxjX0Zx8isXS6JUOa0SKW1aAvDC+kUfNiwvTR7mf
KF0YD7JewdqB32MFVq+j6A8sW8FfbftqwYKmYw/wD/PYuxHRUXaG6eT3P8MqwUSw
JJ8XEN/brTTtx2BUUpUqCBBrav/2K1qc+trDJ7ulZ04+loMnrX2iv0zF7iADil9Y
SUtt9S4FNqZgnNxlNmLLJlKilvQBQ2KyeqLwX11TxC5wbMFmkVNWaWtRd6I5pcxJ
1DrsyhwuqaL86HS9gPPFU83bN2UKnDNY7emPNtvgbtBWSAyFLQeYzizNTKlMeBiW
nSjLHWIk2tZ7kf9rBCAxbat1vSXJN3s4lcmGnkvQvQQMwipSsuQDn4jwCtsFJcq+
Mlz6J9ZWCvjupk8b+dOjWRb0Az22gH7aYFX4wSpOFoHOv4VNasV/sJURaA9CmPiZ
9NJrOTdDC4xSiHw5CGIKyxKTcD9QoTIfLcM8U4Wlnf/SpMqOj8mbJY4rZ3RsaKNt
NJOzdYS2x6c0zUuHsvws6AmGNIY51kwDaciK/uWdsZxVlvMCH+vzpgfgJ5geMPVp
s4KygFsjxmfYBW9Dpl7Iizc8kxT92QNohXLd0stzYlaiZSWj+C6j/WpQ8qtnXy6d
WzyLJ8Bs8lxvg/OHx5Ex0fdLcemPBQxW9tyiwzjZ4RqLpTZw6U64km8XEcho1F7v
LT/xZb9sdkx7FKfSot1F5FlMjKjkhceYfPYSH6cnWQfJ2VvDcvINz7EmVJem0x9o
pphUaUYs3urlKc88HMda4Pp1ZF7c/PqwMysvvL/DlkzRCBTX8kGI4I9TSDDFX3ST
Z3Apm1XgdsKGxVdffzh4ul5pQLcKP31DEzruOpeXLOC65hBxxC7KJzK0woeRYlPp
tgsIG+ySaibqp1iS2hem2/jFRu2GzYf9NBjyGqXwMNV2l5q7yvsTWkKZAfZJPLFf
qrm3BZjKlGD10s0MSkDP+tc11ryouxJ9Mk40bFBN1x55LKCzj0Isynua4u8tpS9W
GD6cBuUYUAeI16XLMjJ1tfd+ylI8ugwi5hn4k2xIiHKP2LMOQ9dtEkkrg8My9hZ3
2m2BGCqR+PBS+QhiIYCr8CQCQXRXhzwPAd9UfufAReK/Wofl4KmvpX94AGZbXOD4
pNfXNzmm8D4GY4oaOhe2WO7lxNftpkziclMR7BT8vOn7xN1FQaMEx2BmqvoN+Ut5
LX1E5NNvTaknzWgvj8LmrI1BZ98h2jyM7i1175VOkUBgQHUqeiPDcAkmxb8Eyq+d
pXh+Rwo6KZ5gMS6oIlNKagc5JJHm4gotWScZ588d8YSyPPQMrbsmyW+ngYYRPOFE
Kn5VZAHGQFwkA4ErIJ6hpU3dbQxCg+X3KcgoI98A62h3wE2arkJTryMhp87hSLia
vwMCndNgBYGIQcO3m7eEOPyXYchpXVJJlGX/u2iZwFnELW9ePtfdifHlAwc5p7L2
wyPhY6PWI2f0CtzY7p04vCqyhpPeIt4y4dhr8PQKTOg8LFhFHa3n/w5I+kXguPOT
a4gV21V1fr6QXat+ssU11wu8mRdbcw6giIOst+XnoNk6AfOwGgUaYy42whx8prkB
GltPfxZargvPXUR2OUWEUFH18Tr2M58dicWdrosOY532YK3ehMVRuFBQSDqRPqDv
419U46PkpPsVPbi7Z+ftsy4uZDnnlEtFORNLSxCPGvKXNupLauGlaMIiVYkyNy8W
AAJ2kE72GQ+1tqdhHeENouQfyiw1KqmvAgPHXuEhg0ShvWmdyrjfzzZV7XGqXzPg
zywLO3YF6N88nUPAy6/nrbOQOC8jA/3x9WsG3RUlH2VZl+4LEm9lKiPF1a/ShGuX
2u9aX4s2uMv/NAqUm0ouzkqNN88kEask3bnSP4zgzroOb7YJrSsXDN1MR5iQsVvU
mFN058frvLZhbU7TrRGUqwZllBvnxnGAjYvhEmaa4IrLUPzzTAGMuS3xdLdOMk5k
BaBYBPkKZ5wNwEpi2dj8y+C8DlT6pp4zqyxvN080mOA6k0WiGpJ5Vv2ZcO5RTI3F
vThlDiXQDoEcoiP2j0KCeMiicBCPvKIg3uRF8rAcjB0GU+Z8SRJT9RRA+sDW5EZi
h0ny4v6I30l6xjAVOzvO4AhWr85Fv57nahjvfLx/atTRIJajo9pL9dcl43eGjn3e
1Z2fTe7Y/PKugV1CZiHUDirKQjrQf8x5qQqUv6+5eQum0yQfHAXewCt7bouznUkT
7EZ1bAq4Sk/AOzmje4WgBSha/7xiMOTH2CBFu/Yup4jmBR2V/sepCJIgKqEHEh0p
mfIrhSw4T1UiHE/gYtapKJUrQjGI7/x6maU8atU/dX6O0W5BJgc+iFxAiOvVkmJz
yJqsRefytGejoSV0DRjJGkMQGyAg4EWMQ9H91GMZHQoDllHZBYsAMiRi62mZU4CE
y1gMx1g/ZBUtfNJPCC8YMsqjZcQDndT7FBswLFl+a/oa9zOuA3GFKjXKlQkSXT8r
uw62Ri3B0S+wEZKarM6LaiJZthrDOKQFByMr/UCeq1yTI4EsIXjOsrasE6E4J/NN
FRzzqVOsBaulySzml2KPxAhcgKpSJDOPYiMo4mxuglNw06YQhpQfMRTEKV0LSXk7
RcpZrsyH73cEZhKfphy0Uqv2RanXeStxFdQ0ryvzG6DYyTq51GUThElpXa39MqHv
K6d101Y0eA1WY5zEAwWhBVDuvXLtq2kWhbuc0YqXqodPxeUXCEA8sASUk4URtOPM
WQNt8/mV31YnisCloV5VCqRZv6KaDF88qtxxc/++xyGAKaSQnSEHgj09q47ws84+
GzarY0wcj0AAKkh3DVzcqDg0W+p++77CzSOzPUQ9UHc4efOZ8r/TRSgwww4OodMr
aRQ1PApj3pW5dRqkgsZ6Am0pGPIux+8Z+NwE+UWgGi2KMk0Hu9paPnnAp0RFO1SS
JvMQq8otPFsFojvXda5O2xPKPNDBTBMpr1CINzGnWX9LT1nYIwdQByS4Zp9A236I
MJrUpQDgTf34AwK7ciF6DHrnhptn/NS60wo4nxivI7EkLrJ9ms4i+ypzXPBMbN6/
fUL4GCbt5b8+2m8yGCVP+TB6+KBTBP/PdxkDyDPsI97o5TkCqeKfIwqxJ2BM4+NB
NW0EEwDV2YpG/IeqOFI2ZxAJGxXN2j5AH5lOsLHh7FgNATwo7kFJfv3N/HXrV7Z0
inbx8i4Loauhbc7Qjt4X0ETCLxsInEIPR0pjGE1P7Ao/ZTXP0dDFk41DS3LbyPuN
MDqVwhDEwFug2JcxYIQQvVcH7/KvdZwt6IA7/pHb8XCahh/LJ/2nlF/mSOfnXwd6
fAEEGBQzqg1fW/ZfnQ7Vp6hw9cWAOAWR5qNv3YOcEyIqI/QxZa52hQa41161TGGC
unBzSFkKS488YQuNPh3XPl43U1tkGxUC8UmAEqCEFbvrpAG8qSDTulgA0C1IQHCU
PxNah5JYVv743A9MXePFIWXhSr4GE2ovuO6tH4EEWwBlZmUdUJtIZCbugKun4mNj
Tu68cofv9ZqV9qWt4GbrRN3vjtlwaiPAU2SnCxIJYeIz2BZ3rnqv8o6xMj+sZB3i
84+Ri/4X/CB1puOE4hBGdSLa0CMaeBfxDzfNXFDBfODT/rxVx7fgxsFczP9rcNqG
BcRhAKLonP0lwb8HH5jWyS7E0lzGNkUZIoaEZbLAyqc5gn4822drt+pz5OAcCkim
MWVnjbuIsZY6hd6mQE5I82yyvUzBIjtyK9f/qUvUjis6d1aGVOgV0HI+8herm2a8
AqNmCqgLxoaC0LiBNdqtiK6/klF29WRHqb2A6Bo9XkdUjC7LUhdcEBer/CJkQrx6
vFvz40uzV6PmMz7cwc0xI94FM431fxmiYbSLp/im0oPjkhSXfE4f1ZNlw/wUL+d8
SgkI7nwWrotVDCc5ejWi1QLW+vn7fyrLv9lcyfmabFt3bwyfVDD3TbNyBHOmzQcQ
p+MoTrWKe+x1Qt1qUn5ybGLPFTEKbO+JMG0spNJGeDxDCTU7ToO+dPA/hLImeemO
FbKeiHbKECaDyWx2jJmlF2DFtLWrO3ZFR2noCRKUHIZdGbZKuNxOIJtDjRIl+8fO
NEc2hc9QlFDkAEjizGkD7r3yE6Hd6gCEDlrz+YKVNUV1FffkJ3k2yeZIdRihXlwY
nwlpfbx1gqqJLLbPGFjSymHIbISJeZ4LjDGiB/hUBo2RwZEBWCdrBu7iXF3FXBAY
cxoK2cvSXtBscL/p7AEMeaKqeF/dx+CSCk0CiklRolidJk7uRql68ggLSDjJ6Bh8
PmOpsXnQVt+s43d/VXXpuQFVL5LNV95na2PctuLk4om1hslEELEwav7Ziv+nSQnY
/ul76WoYjCHm6iH25DyibP9pfUjL/utarP4nXkN4Jv5Z06kkJK01GyZqxfZKTUIM
Y91buUjaeIuIHlCfyuxzGp+ig4qwYknqO6/J36XoALTSLVPTgUOfm2q7MLpuUGIr
KRVSrcH3Rt4OeqQT2KV5IyWtGGZYMIhWtFINqbc7jRWWlzoaqCzIwUujfqH2LuOb
TLYYSiAxWAm4YE+VqlG4IHtosLBLMuBblkV5dojnyS8PaU3GD7cT48fjEVhNfc3J
P6syq+4/wpqN2zZ3KYJJMWLSlIgKe2kOpX8WnYYzP0w9eaylnybdEeACyXjdekaq
ivi7IsRaQjy2bR7woY+gOKyLenyBXQ7l1sYtemoY0qIbQqqLCKE2lslHR9bxgZo7
5xy7QGau3GXHZ9hkyWLtm4MzHzsgrldK4SLOmejiVuFwyIpvzP6Q0LnBT6AOiJCt
iU4BTct/i77dPk05qObzEgl55ItC33FyCZfiMiAlLlg5i8yvB/YOjqUJcEHxAeHz
ytXafrEqX1jHtQCLG8SFU6l6+1iDeZPXkeQMKmBYh8TT+bAFPpjzlz4lCJYdOMHb
KMXXiarzhy4KaXhAX4YtM+NFJ/sNd+MIhSPFBsKnf47f9+0lBsvl1cNnjA9r1eO2
V8bucepViexa8qcwanYZzgFlHtxHdPF9d75xEForgN2SN+6/vnu2TCQaNOuPoFBG
8uZhdC1f1xli+NsElXu0GAHW5e/wBskt+WbFsHpDAHEx5IXpA5ymTkFJsq0HlBDM
7gMkxuuZPjktjX2+yITwqOFQnw2VHqgmbjuSricYwtVO5dVqGLPVS7rGdkpU1pfG
ATwsekFClgKfiv/GNNM9AUoTqoe9bMd+SvoRZ+wAfclAsLZg3s7nd8DVl0bGGiM9
gqtdHhzDQqjseG50f41v9qp7gFC7EcZe/lPu6iHTiwdHdc9bhYLA5h8La1kAOAOm
pgC379fsR7ZELytb2uOxt63jdkKfq9ugDrNoFM9Od9yKKNvbwxSDpyFIuNyDyR3o
/bLjRn69uYXf3KDOHfwWqcFTRn5mr0zsKmlIVgGY/jl0nIVGqFwjv2oLJmi2+RNx
pygP7gnxB4Lsn8amrXknw6thS6MNyHr+1PrP8N/ooXGGktoCoF8vdEqIhdB+lXeH
w8QTwZLeAN8y/ImFO8vcSMDbjm/pEU4mJl7/dTEK0uRybLAJfH991n+YYdTKuARa
5+mt1a6I/CICEVFXTJcMkqtCDx8lZajRFhgJ8VsYpgp+b6c6xQBtkKLblkL7ZJxM
dTOo/QUwUNZ2TXnKJBUxp+gvNQ7f6Z3uA1g295D1OMcTGrebEeBcHMhXBrivsOmR
8qJshppyNcrRG04HsBjHiviWHQsuT86qVaKbtcKpaDw19bKgs9r9X3C7DaVTKVeV
nqPr+paM82MMNpmEpmSkK9EV5QUX2pgUY89buJILY3bANvejz+2yztpL3W/B5zV+
lbotAJ8ztIqRbhSTF92mlabIrY1bdIGdkAzdzxLI2+6ZCV8XZeJ1oDGbozRzJ2xi
aOEoURBghlqqvs3E0dHUP+YoLROo2PyoL+9Y5viPPPRA9LYzlzHbzwDIIPTqsfaK
/gR41KlBwmdkM6nrR8uDz0cEJmFqJQXhBgSIfc3nxCwLLZLnHDwGLL2CrvfnMFpC
iJwKlyfwW5ri+oK3RvI8B6BXSHjmFvHYvrI+RSQGw82d+rPQn7qdon4SNP2GZcw4
AH/RWHh2pbbG3Y+uMcFxtBd/6y/rVRTGQ+itLwwWv9CNDCfxWlBJ3DMaTfzRrnye
C3wp3qMfYCg5NXiHO3p3HHzVKuLegvmLF2ZBFyUH9JmT69tU26MazKQsl+50/myd
JfKE9lCt2/K+CPGV8Gr9UI5oNdi6TJLHY3T/yhql0DEKqZC+0GtqI/1wvVoiVTt6
xqZnyNnwPDsfzSjNmM4eFvqDe/8IMt+nOlpiKV5RJwkIHQdTpFkmz/IrUiErc82b
BUBbc2C/zx+9+PEqfxd1ivdGl68wIVq7NbQj0CkQbAZTI/+rF+Te0ccLTAYn+yl4
l6qUmHByUMa38BqJGfD9P5bKCGLjiauYufhHofq8gp+Y4gndcFwbxhoX/Th/c7VN
qvz5rD4B7FGZ5Fbf9AwFAHXaR2tT6+oC5p3Jvofdvpmco4r++oZcN5qgBDRdCFAa
+X03HRQA3eYimLWWEvNhtkQ0/u9S4vb83+mEpAh2R5UlWUiLSEMleowl+L4kLhHN
UDEhTEhxFkzvUJfM7RD0vST4w1JwgfRwG6UX3fXlIc0I5oJ7f4mHpyX+yGyxvO1C
nHPWvqZspflOC6CiKohrUlgCiNtaoqb+Ks1dpQCk2ZdL5bIhgtUKKFEEKEM7ptSb
zrsOxJGW8hkDKXdPcFn7XvHwbcnU/jiYgp9DjcAC8ER16S8GrKPmNQjjdHSBP+Ak
C+rDgn2DYMyQ0mtlHTTeExhymj8UjmexKqegct4Dtw+mcI0lyx5pAViDmVYUNsIP
0rrVzYz9sXN5WMNV9XDVrFQYRI43XLnxppuvneXkKLuO6S5nuOTzMosVbCqMequu
WywYXZf7l2mLc7keUC5atJSGI/3/DFGqCzcYE/yBX8/meSp2uA3KQORQh2wy0o3t
AkXt7nFrCdkBYlUT8nVzCqvdYoyWlOC9IHhEKsdCrGwErQxcrwt69A9nv4RBq0nV
fK1JyhIdZ2Ve33MfhFWE2fePVurlXBHCuEi729S//2piW9n2m2kRP2Ibb1dpRjio
SEPbIvUhOassqg+SDvcLEW7Ze4UciwnIvOZuzySECBg=
`pragma protect end_protected            
`pragma protect begin_protected            
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ivo9CN4JJ8cElvGfBGbGJzk5XmYnLhyoCHtmyEcxJrNO9C58lkbtylKc4OyZqHdJ
J/yOomBTa10Q4apowTP3gtN56tFO7lcWBCYNYgW7d/i8TMvhNepk96FNCFTA+XmB
IaCyUV166fhJ2zWjHUBWxgshe8THy1hv46OZ2aJLqQo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23164     )
ZzSJJfygcYnEVvTrz7YCXGyk36bc6ZlaNgPtU7aXKtwZ/hNoarRkjM9IQfdl/HV6
wNmArpTsu5dENTcZry2yPVUymabCThCmANrXudAsNbyjSLNoAl3TcGhfFkIxw157
1ZhFeTV2mNn/pcalHaXR8I3yRWhbPETFopfK13TyvKwIBuyaGRL8PpIKgEmBUhAa
6WaZrJFKXpgbj2nwgooNqYW+LD+N8epu7k8JzuUMSISe+bBq5KCg1HXQrDOP7rhz
Jp59lZsPPfJSRbPGDJc8uND7YL86UoRX1iDtZFnxtlWnqkIhze7fVAtjaATeCo+q
CmyILTWRqSs8SP9JJoMKzGqu4jRy2K8V4F5bC3KPf1fzet5gMyUG1D97WLWwiTHn
a6uHwt30r3EAc5wpHiFNwEofA57aw2zifA9PNhsrO1wiclxIDijKjgGT/+1LMY0j
dezlyaA4g79NbQbR7/6qtDUdKwt3CvVhFB6djT8XMfYtiSdPPMD7EXGxJJYC55z1
SUSjegevgfZgOMegD3x8jxkG1TdwU6SEai/+k4Gda6HaAAWMOYIRbdxfXIN5jcYw
`pragma protect end_protected            
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MxWTGc7WAmw/hQ3QWQIGJtmS7BcqlLoFCLIArLshLNecZ5ZAIF/A1o+qBbTakkDj
SG2RHpPjyk/mibD9ZI3uQ3pYfba5r5ZuP3PDP805YXyTAqQ/CGA6kBG9/IByCQGF
4aOsSq1/SOPhoqSw0pWD+QjxX5hyoPaqL54exy9gRUg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 32531     )
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
V4362oJjfJpdU7KhWXdRLg==
`pragma protect end_protected
     
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_axi_master_snoop_transaction) svt_axi_master_snoop_input_port_type;
  `vmm_atomic_gen(svt_axi_master_snoop_transaction, "VMM (Atomic) Generator for svt_axi_master_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_master_snoop_transaction, "VMM (Scenario) Generator for svt_axi_master_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_AXI_MASTER_SNOOP_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MLnwAto7GU8Aokr2mWJ5GUujQiFSA7fDFBTmXKBz+w7FFK9q/KAEeXXUzaNR3mPO
dxR1WRqantNNeus9Mw1YrTpGZS5nLZE1wbnfEsPgPLuLbKxOkPKEED6Vz157759A
PJXDtaKN8Gfyxk/TfZoGJHzM0F0HU2oHmeK1i09L4bU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 32614     )
0CeArQXWx7PJ+dji6tqf2IoOrWiZz5tRJATi7j+Z+caLLfR527raCm6XRufxH3U4
HpFEoT6DzH15mn3JifPztMgfIMXBe7+JRbFl2BU2HTiZWX52BDoPAeKX8T+tKsE1
`pragma protect end_protected
