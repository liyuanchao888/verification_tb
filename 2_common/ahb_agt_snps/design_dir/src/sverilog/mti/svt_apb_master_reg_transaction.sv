
`ifndef GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


/**
    The master reg transaction class extends from the APB master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_apb_master_reg_transaction extends svt_apb_master_transaction;  

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_apb_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_apb_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GIhl3VKuKcuDctJDyNa8CXaGE4SIdtJjbYgChcdL+4AMaDnHh0zbgAJrdgLFsZqb
ZfkvBnv38x9VkFkMMGx9OE8i9nNPDf2Z+90jZ3V1yXtZgrnJSqKmnPph3gE2v6AS
aCMTfifn3fBQdP4CCI5pxMX356zMWED7iO14KhAgtPM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 620       )
EX0sq3ggNm2GsvH6ZQMEZBT2Cj1XttgxPwmL7MhcfLaTEHKMNupVu9weSp0iq/OU
vCSLZOvg5OymBnyvGRY9nXt4C1iF0vwfKW7z+h/e4Kp6J2foevSd5toBO/VU4iAy
0CtqP0TQyUp5CsP4BqrgNp8qyqQTkZLVV8yGE31RGv5DHAPNLX7awh28iPwqVJHV
S/FvzvWt+3BOSYjRfZHo6f2uqRoUO5vX/LUHiumvk4sGlZz8FJfxFPbt+GTONFUX
01yybt4HKtRW/CdnoKTNi005pNYHibFbAtq84UlhAKgenX1Rue+Z/VTUES46hnN/
hgzOWLVnR8/uRvCmDgepoJeA3c4EMBs//pO1dh1Q9eCIR+KHlhYn2U8thtk9Jj82
2E7FCwImyVwapuXSFDzkP+jA8xYPMWC2X2QKqn1UIJjPwAQFwJ6wbgNX73PtLvx6
AAWPuLR6Tq+p+SfLN4U7e5s3ArbWKEf8FECCNS91ZbjiOwcz33iV+1D8qQadpIl8
WPK22JAQaMSRxH4gTRpp9rPE9jsLLeL40w+GAfsEBVm7DFuiDL/bWWy9lKVi5lGp
7wlkSY5XMY6/HYUcrDDVqwm1fuj1MinnEDkd9mcL56fUB1BwVZz9TNt59d/+M0I6
I9cQymN9I55AxHsZujU03HV3iqq8Ei19S/WbDQkY6up8+J6zTdf2kL/9hTH+ByFb
raCataQNGKSyqvk+6Q3Ss920x2blzyOaTP7dK6zqwSmsx8qhaUP8zihtRYEjln/8
57CNXVMoptIa4TMuW6ideYB7VxMhLrtB9ACrwKmyzhnV7CSUNDMVlCHLirmMrUUd
`pragma protect end_protected     
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c0Kixml0ZHMORPXxIQZ67a6CWBHwFHXlbPhBYiwcAv52D1fCDlOBGGtq3SEvz1Kw
6mlwXROOv9EfWrXDWiC+I/HOaYiDSssD2ltInSYUKOv7icN3xjkamasGqCIL0myG
TkNwd3ezwWLNJHi9pCPrJX/NNTfDfO8JufZpALpTb4w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 801       )
jut+EsjUztGUSd4FB/D/+zYehug5UNjGKCN3UTlFKNZ2Slg431rzLEGkxvY1E7QV
1f0zFogVWiedBRzeD4cyCKRICLOPaN+cZFA9W4VuKP+QrxU6iPkZNJK86PdoTj06
RkjPg1ZRey7AAgxxWzkV19wZFxq5blZSmDlk1hP8iSAw1zv1iibG+mjsptizmJEC
j23KWX4JtqcXaXmHLg5r5z7HxiV6n+8cRd1uCUSpJxsf4ZoDQ3a4hApDmLLgpbiY
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FAyNB81JYN01wDGNQC5Xe1LT9rrkF1P2kB6g495+m0yW9+RfN4eg62VH4BWnz5wS
XhRpxma5TbZnkMhiiI7hQdD2aoOz9sNaGqdhrUk+xhzwTV6PN2qz1iW64f4lab5n
XvFQfycOapmY//q2kk0Grcd1FKzbhYTkmcLgc7/ygD4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 893       )
Uo82gp/V+FZYopOOM3AJb3TC2bXXN+JtRIw6EnAfQwEfxZlr6uoB6EFzHZsY9m55
JpgHmDUKSFc+E9dd1I6G80OH0CqhJHT/NIHiNcbfez8qP5qBY7t+zTKyZ7P5quVF
`pragma protect end_protected 

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`else
  `svt_vmm_data_new(svt_apb_master_reg_transaction)
    extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_apb_master_reg_transaction)
  `svt_data_member_end(svt_apb_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_apb_master_reg_transaction)      
`endif   
endclass



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YOSDPiPciKGSTKFF4H2Zf7IFkRYI8ZKc8AVW2Nn15doXAW3kk2MPPJTXFm9s8npi
MUNgGHHkGuvwpRb0q+dJF6X5lufSH2Y3L3BYfsCdXIBD34jz/w7FYlc/wP8+rgFT
G53ivMrfVLioL3EYGXLIOEExvYMcC9+Rl0KgDjXkYtQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1579      )
ZqAy+rGN3oFdB73rvy5qAEn6RJ72+jXlm9xW5Spxqefy3kViV7yDZmTk9mEkkIAG
d7SkcwJs4MRJAein0mKElQtTFfwXVISkJjpd5w6D2EsGgM3UOQwkFsq1xvuYsdz2
yF1oAp6P9AqsbcvdHrf7B4PMp1+oCGcP3M5IOzoVxc7sqs4crAXg1K9gPGv1lMR8
6AQ84cHyTg2iT1aSpCXjA8L5fvQ7//ATDixZaIzt/KWdaBP/PUr0MealN/uZ9i0m
EZhreeQRuNoNjj74dKxhoYUfOoTYLEGg5QSEwHE44obskVCPcMpB32zuCJnpLcjl
qHTHQTb6oMJLHle0Aq2PlNi4emk5/xahsoKU9Uk6JLik5X2YwoutU2vjIjnfcr2x
VX+QxE3N4Pk9ad5m6yrECEVePAaDsTZnY8hgeZ/L4hj8t0eetef+u0axsp1SMivY
fn0bAjvv0GwyCDZ4O4RDZo/eZ3y3zNmw/+VkEVCiHeLuBldECmTdSzYk4NrC8qM9
0oGWKxS71ph57H7rsf+e74gWTg3K9adPpLw2jVaOWbUjcyL7/BTg6wR1Cb+Hqrkx
jpT4rAmcOMDrCho8cepXDpYyq1RfP5wwZ1jDlktAUgh07r9GRkBDo8B78pimGR1L
xI8uzSo3uUQBvrevIPK2T3qyvfWZESTavuhExLTt36U2z4LKqzUisVVJp5HwWIVG
5S6gZu1ifjxm/zuWKaVr5rPR3fsh+NJZ8xCEZrs0ppvVeXyGiwTuoFSydw1UkSGG
9QuHqfj0vbZLs0L3PrqKstI3SUwyL9zKXl1fJquxbNzGR91EIc0+OGeTsKCxsiqs
OQThhQrBYdFNX74p857L9Hib5xo+zuTPiU7JbkSw0G6+6nYCCo4PqGmXZ7s5BF0Y
jrD4buqwFzOQ4HgQSOFa1g==
`pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e/+6/GgpQ9MFuvC8NicCPccJg+aFlAPZPJ5fwuKpr4DFFVETkDt6CnTwo0rQCXpW
mPe0UNxi3JP3UgQAggES4lb+vuBXDx05Cynp/tNgc0T3irZjYF3Nj2/8Yg7gsL4P
jaJ+Nu7sXEVVUDuR57vqDwEoRKiWG+yMKuSBDZb69vA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1662      )
72fNfGwKBlwzk3T2cch0urIJ+Esg0u5RguD0jyBV2Tsb58yXHwgemcnlGTIUTPjf
SdeF6p+w2lndsAukkiyoAiqkie/yej42FmFBF9TSEvGMMn95oZHNiX5rcbByUF5U
`pragma protect end_protected
