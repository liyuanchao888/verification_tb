
`ifndef GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV


/**
    The master reg transaction class extends from the AHB master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_ahb_master_reg_transaction extends svt_ahb_master_transaction;  

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_ahb_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_ahb_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xzYpy7Q4eE7PG0wsWxnbBLBWianBTXvjuq2ljO3gnz2ip7fFp7NgaLvcE5+zlkcK
fRzAY6P+2tTDBU7rs2pmMQUTN4Yt4BoKJOJnzIiVXjhqAh9hLikxf5FpZwZ7hnBt
fkdL64auvpMHbvHX+Cf8ZqrqTigUcGgEwA7L9+ceGTpaKQAnTQrR5A==
//pragma protect end_key_block
//pragma protect digest_block
XQBFYzQE4WvCArtdKeLJpOMqE2E=
//pragma protect end_digest_block
//pragma protect data_block
KLRLH6R8pIoF/DAeTaKpFhgyu+RNyk/FKKYp9ygsDdmVEdrLeS57P8bsh+tR79RH
L+FdFN1dkeAyqP+HSsdpvcjrOY38D6yeFBujkFaG7SAgooo3vCRQsFu7sOvooqVs
REyTo9xlGdtu/Wc95DwqdaMhQufwbz6NM8VLTQucBHl9NjqfNcNzHkEoE89NP69O
W7xSg4jkuN4cIX+hw+OSmqRQ/YHNV3n3uQXfiGbOpa0HDZP8MJJdZQkQR/J1wKaV
ikJWIyu+RqTJ/MGsgsKYUa07T2B7v++jdTRq+d1+6/I/S97mbYKW9klzY3GL7J0v
aEhyAl4aAcb5MAZhje3DK+GJK5qke/GzyhTRKBVv1gMkNkX0xfSw+YDkwOhzBTBX
YdBXfGpGV0PpGvU6oJZywueEu6jCso3Z07CRyEX0HhuSOtNQp52s3aPTIVx4ot2J
KEjMJ9txvNSjxtqEUvbL3StUPqUvLprPst5bRO5BSf3XVxJdoPRfPj0yI6yuGLl2
nDORPLbup3cvhOnG44QnRFOzLkRAQjLZGXU/jwZf9TlHHXcmEra9p1wnqjfKJ7cY
yL8FvzxMz87i5hiLO+sjsq5C0kpTLsyAlh7Q3dQfMQFr5BSUNlM4b0xtLRk4xBQM
qdVWZmMvGLRVcsnI7ho6n1OBs8yKIQ7WRMwj+Q5gyS7ZwEE5Ae8HS/y78aEITfWA
VaM9ASt2wgDFu68b8d7fYXphwzPJyrW9reLrx+r6xHT4VC8V9wOwUL49MgOOOEpG
HIRWA3yDe8LDbCa4PKgwquIhRLY/fkyKUXsfFdDwMi/fC5aZLO8Iw3LTE4BWkTJ8
IQgWYm2Nv3fofx3dSRV0iCdm4Dg4e+f+3/irXlbcrpEEZD3wcbqn96t+pb7FYx63
E/WP32y6g+lo1fV3N89CEBkJbYHYCF808f5wXnejwhy1UZn9g0/yKUprC2536bUu
tbKxMc9YkMgk05UdxmbrDw==
//pragma protect end_data_block
//pragma protect digest_block
MsDjUQtzyC5Ui90pu68Hl77/jdA=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_master_reg_transaction");

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_master_reg_transaction");

`else
  `svt_vmm_data_new(svt_ahb_master_reg_transaction)
    extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_ahb_master_reg_transaction)
  `svt_data_member_end(svt_ahb_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_ahb_master_reg_transaction)      
`endif   
endclass



//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
v4jLsqXvE2CWKIr32o6WmOVDvIInXvqrwOG0zhjhj2cZ7ZGVbZm3KEfpFWdLhdfQ
/GQrSsuc0vb00KQWsaqrfR3U4InbCOIPCWf0h6mOeu0LRjyx82RIGvA6IUa97t//
WY0+DVGIzwKWQ9TdnZMt3J/M2XKaISBotXj+bM6JguDMmcszxtMhUw==
//pragma protect end_key_block
//pragma protect digest_block
5YW2JDnLn5hensSRdzkwVZAzKxo=
//pragma protect end_digest_block
//pragma protect data_block
dyCpWT3Ua8Sjj1VbLEwcw3tdWlOPbCWtRW35J0Ph6dgYgvawNrOKcMQ/+P45+gPI
Y4zXekF8ZNr5sfi6Ffp/f2mD6kCy295w3/ty061Gn8p1cCmsfFN8pVgAzTnUa6cG
7jtP7dD7Acq6jJXruS5gqm9eQkmM0SyrgB4jDzbj8KmIrvuiIMIu6jKdQcx4rIAI
FllXVR4A27d+cW+igHmGFrKzwoY5mr5dDaYRjmGWjvVhOxHn2vZdcwEoqdH7L3Mi
LdrFEzADCxjJvUNtwBww7R5Y/bMs+Atw71SUs42xeeMMztqIjh/Piskkziz16zEZ
IFKX9M3lMl2xnz6qZ4vEl4vpGucTBCNi8t5brlFRU+XeEd2LIjax6CoCzgf2KyOl
2GZqq4UrSLkjZWLM4gAe9onB2pfDVvHPJBj9DzdxTww7Bv92wMpC67YS/a8GSLes
azVm9cXLAkzMLPBfGnb8tti+Ppmbpcrc4nRveqVg+jQssMKUQwCVs/VwhJdU8cLr
VuuMchCX/LQV6FKUjL9/IjNT3uYutRdGE5Av5a+E2RkvHbxITPXS69btDgKgRBaa
K0Z25wrdighWBWif0R4esM9Vr7baIL8L6LlJgpwKxwcCJBlhVSXRYwgzSVfEExEy
VUo00Gs0sgMSH5QwAg2EJdXkfpLBIfMcE9G6tPerkbdnKfkHdoJaX1XtUHWXP14R
HWvdCALemKeO/wKqU0YgVS1FRt/gGP+kNxyuZA3rO+P7/ju2wcp8wM8LMXNxaO0q
zwDSk/WN+QmIsWur5Uig1fJdztd72i1lTHH2dBxLAQCO/0IHC6KMyU1oVYSLbmfD
aT/nAX3SzGQA0C2P6M7qXDUgVbrCjv+i/hQ8RBrU3PHJ+h9k2zfJjXLMpt/WZlmT
AucNl8MVihghvP23xcPZNTu62YaEYNsalaWcMEAZ5IjmbixpGAFsrcUuF1+ybLAU
Gw6glbOJGY7OI2dSUOzSBV+EbkNA+AsWVC0rKGNHSqVPVZ5P0nfX9sOnDvR6gtSX
nX9PMe+1D157lWW+d2/0yMoOoQGubTdn59/1axpeWB/X7OIVCcHVorTxkqmSgjZL
OdnahkmhfZPGype9KlS4sVWfSZtFOsaRYvF1qgNitj59knA+xqdAe83XvMLEOcL+

//pragma protect end_data_block
//pragma protect digest_block
XANsH6JoaqsoJ7yWhXwLt7aPH3s=
//pragma protect end_digest_block
//pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV

