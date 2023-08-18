
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
b310G1Z3l3W/cR7K9K681CcJvXIRA9x7W6UUg794JCbf7mKH5YBbMlMsv62wAbUT
djenaaq5qTgRnoY0PcmNogLbqhZ05D5oLtMBQbHnaCpcyGVAQmc1NuyaOF+SkDRn
mjs9xI8rnjzJTle8PODjl29mcpIT3/KtkXFrzT0oT9U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 570       )
/gmtiM4GjpL55H/Lby7RnvzXYVa0G3x2N8I3dqdP43UfdsX7Z/oG3Fa42ZHc1Awp
m+JdkfxSHRMd25mGCm6M2nCHmz+i65Wz4je3wXTCEqnI6KvkbIZfBSWUD+oYlX+w
TXV9MQf+9vsHYMDcaWr+G7mL3yO5i+Rnsm/KV/5698aMxy+TOVHOHN0A68iVQNiK
KQVKaHcytglutAG5bM3YfSU40ks1ovX1XrJUw7k7p0OCvyLss12L+U9q27pOk03C
XxX2eKq6MqE88vmLCxiK5hr3nRGMuUDwmILS5O3EJ7wNki4AbeCD3uD0WDPF9KTg
BnPR7UCWDowd6gx2IeSJeVIdC/l0jaNkl3QQEVcMFjq6d8c3yydlw7sUVxcuZNLh
YpC0Hq9x5Cbtlk1ZcG9AZSFQTbVLef7GJ0ot6/ApGFYhp7IQHJP7vmEA/gd0pJ2L
fqaZ8awJMKsh85by/EoCswr5srJMqRQKr3irDZDf5aJT+pQwTEtfVUTMBc57zA+p
3TITkGElpKC2WLQllmhNXH5cVToFasbP/tCFYaTidmu3dvo8Wn81PBCS5dciW76+
I0vTjaAl5FVadwQp8/sYZz+pkCgZGL+GbrDIkkZIAEziCRR0RjM1dimb6HUbAO1A
OFZE/mLD1JVj+WiyE46zXd6CQOHngpsR81NS6eYVJgfziYq+uAD5OciGPvblaBRP
idTQSNyHL60GSP4o6jFZwVUuVLvgjlV7rSmQensxrqjOVNFi70pm6lOsDnoJSDeD
`pragma protect end_protected 

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



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iIAcB32o30GOY7KBV2TuQdE+o6IQqZ/ApEdnEqnvxVb9F+AvcNXgrCUGTAk5esVC
sFpiJg2rRdqjwKpIku+XrrpWQkQTWq853HD/09uroANnWK8hOOx2UsDJZ3C5uWR3
hvN/Mnht53wNSI/V+207Lki5nwkg1aspeD3pOb1A6iw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1256      )
YfsgBGRMn0qcOVeEhy4b8RLZzR9zPcup7iFHmuW20TLFx/8UDdeH/vguY/JzEOLF
peQ5wlsETNLRcUSfCMslyE14eSSh9kmni40z8+7Uu3Y5oSAcck+WVSPWP3T9Lb12
PaOJd7ssvNw2eoyffzyHeJnihY+oZx06YHGQfZ9ARqHgC4c5AllFEDYVD+wAOASu
JNS6jvWNNsQoyvkIKfBU+XVOU+pNo/+xboC/NwvyyNjz+eHKeQYRY4+1VtClNKhQ
PmbSnN97cvcnhfehgBlbI4MzVCTK5fnCbOqB76+7iEHbhEWyJp/G4ucDe/zZwQ94
c73dj/GZRMKBDw/GJYYikxsiJ3XvAXYP8cjxZfDiobbv3lrmRxUvUeYU69Fj8B4s
DIVYaCssP+/1dfspG34A96mG7EFvej62Nc8ctbjXna/LdvhZBa5V3MOm2GtZ9FSA
oAite2H6yTakckzPDSWjw/bXllLI5eKrjpIsw023QRAskQf2gIN2FxYBa6U+e1V+
A+Ip0YdQJSJQtgw0J1lOqAulijXfgcPe4c0AWc6cZ5PA+qZljqVrqpdpnZEnFi7E
eYgs3jOtV22xA9ix26sjitf+ld+CCOMgrtWhASr8S4K68nH5cLyoIsPS/hXQSMtY
zQyE67vbQAVnkFAGrf+u6bq5ib9aXGQlPn/+8D56TQZhEESaNk30ILqXfAnWygCs
kkpH4eE4Zs1LV/snGH9i5rLoMG7YopgISS3FzZuq3CvOMLQ5VXyvW6Q9jtnPpViW
CiZsvsRTe1wkvuRBuZ3SavWdbA71o8ZsP27NCcnuAWeb9ZRTGQq29TG3fIqxG3bt
JAkVWvyfchHzYQktrsUcU6jV5+GjgFGxMw634+6cA3o4n0hmH147QDMSDV0WOtQz
EYkiGBYuL/AH0fglOVuiZA==
`pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_AHB_MASTER_REG_TRANSACTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
h/eBgPajYlNkePOd+zsXGW/X+e3+Giiw8SSQGU+VY4YT0zB4cM2y9cYGmcUmE1fR
qY2A2yV08oa6CpFtUJZx0O1amgUP4xiRykFPHuNfEZZfEljPR1MxsS3efUWe22M4
1k77IzRIkvydoZr+C7RcoIj2fPOEJGItPY0g1+lbEDg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1339      )
jFyFFvNSTPYO2hu4HVfYJ/X5cb+cNo0UJo5jVsNqkQSHTKV+REaD31vKEHWBGafR
GC0mmTf/FODVUis6bzOyTPiJK/fzQKIfUP8chIBWN4TvF92+lziAiO3lgRO0Lsrz
`pragma protect end_protected
