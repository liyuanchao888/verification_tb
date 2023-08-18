//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_snoop_transaction_sequencer;
typedef class svt_chi_ic_snoop_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_snoop_transaction responses
 */
class svt_chi_ic_sn_snoop_transaction_sequencer extends svt_sequencer#(svt_chi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_ic_snoop_transaction observed);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1bB+4x9ZKkKAHxYwITU4LUCLbYs1NDFyISCCiYFzZQk670NRdqmJxlucqbVDWlsR
V5gUqrEMHjfQlTvchpd87hEnxCQJbiA27UVuGiBKn421q+kQSOMJGdwm5ALitBiQ
aA+yDBVmIztDK6rSVbZ9K1kkTyiQNQa04ExvBguE2hD4AWFpzKekPA==
//pragma protect end_key_block
//pragma protect digest_block
veTn64vFs7a3O2ZR3YdoDBND0io=
//pragma protect end_digest_block
//pragma protect data_block
AI5+jQVRhZgkLDso2rIekdUXlvP1fF9VsRwis/FB1Wjblx7TK+ZZolaJjxxA6Koc
cB6Eq1WY0MMLJMl4tQo/xXmRR7+3+MljLug3kGeJ7rxxjxOlhGoYANmVJ3gLDSSw
/9xteOK4EBcNUsT3g8wOCIrBPIBh4tky/yCoQVauwSOZVO96TzGn/vKF94gXEyHI
JzHxgl7X+IpIZGT4PtondNpQORH0DRcQFtP8PIezJREi1AfT1hCYIkAzRzyHtqbw
qOR/4mHYHQHBS/1ZPCnsb/HhGm+sDcQIuLWI7f0skB8u4HNnuMPjNRMzPwy95Q8E
5CVEhsQ187Jnl4bB8WPNFbvgS3qQ6Smc9yXmkvCL6pJQxxU9JBDzY5oyBAaiR1/9
6NY8iCxHVXr3dTyMt7+uV1YwXMHE75hW50bDzxqxiCdS3lnIufTFMRUi02kxkyrU
zwqZYK2UHxXEkSDaMn6N8AohsNe6H1LRgFOX8MLtxXoCpTgX9Cn0OmYEiTLF5GrV
t3yZIXvPoDqW5KFaa9NKFYSbgsluE/WC9wKCPkv6+AOq7OhkZhXJcM1AJJ2gHrUc
5eT9E0ei3GcmDZbzV0wG1fNKJ03gqsxPpj4yR9E2Q5IZHklO2ipr6Riusmdq1lWX
9SYeUuZzlM4odeYK75Qswy0W+ucjKbC7uPWmZ6yshgaUnhMRhffuMKtfkwFWvdAM
W60q41i9xTdR6g/5uvLQIw==
//pragma protect end_data_block
//pragma protect digest_block
9PNL5xsyisLglYd8dLH/c80ogFg=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_snoop_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_chi_ic_sn_snoop_transaction_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3rGsKuhTXsryvlH57qX6QZd5IIqtlOD3KXMDp3AUrgZh09LbVTjEo6CdqEPcNDW4
z4dEbgDiRZD+ULWb0Nst4gn5Rs4rJhqBfSutsD0RVOTMcV/qfT0sFMOZ9CbBS0tE
Bi2f6rB5pV/OWCOFUQKnO++gxSeizDpw2hkcFcB3xPpG13SMZIASmg==
//pragma protect end_key_block
//pragma protect digest_block
3hm56lnOkncQiRrRNZzb4qZxEns=
//pragma protect end_digest_block
//pragma protect data_block
cvA0WjPMe8+jIWy8vYy3Y0ZBv0FnyBdAQ60jA4unEzFCSr11lYZHIAZbSS/tSuP7
O7IQvMXuyuzXBRkhPsT5FTEexxFWTpL+e/F0TzZKkAd/FUBktHhBoeZe0l8HA0o0
4EXisUtlmJdc5WcapEGflU91P62KlS85tMgbC7nuyweDpogm45QO/+xEUA97GqsK
g+U69h2mXI0SXMus/dt5yzSsEreAhzBx4HCIu4wIsYoDGOwwPZ/78afjVpYpy2yN
w0+zPhyXlSu/S97eD9macQd6euE6OPaApvxzfhiE3E4DjVuif+E20ofPFIPG3zId
nIu61Lfd+jOz/DWiBb18rNUGod2NVHoRyZEmlgZyYpPDVIO5MjOjx/Hf3IaYzabr
QbLOI0b716xkeADj5uesJ2fz/WtDrsdDxnu7KVM+olsaU3vbAAQYmcu31BlTAWJa
RSURbW2nTcinHGXEwOxdSn5C9ccS2a1O3XAkIl53IdAIvSJa2rdAcQ84CN7ATvoj
DvLDqENx7trg6ToxmOtJ65qoMauJ61graUKGv5RUm5nUYw65HG0P+UGs9QYsr80J
DZoYZdOmRDuuH1UJT6qDFm84Wvda/ZX7U2qNk7QdjEx6fcne9gwO/FGRY2/ZP0AN
PskHPnabGyRW5id7jI5YoBRAyySQbjJz1rwA/qgi36HIwpMpfBMdwz6rHN90JyqI
4stgG99cEmti+L9A7XqVAIityFEwsitiirorjEqXT+fIUpMD1n9/vE/XiEldj63m
x4EiwknL6f/ecw4S37f7TjHoSwr8TTJL6mWmuF3GuJ3t5bb3dMq4/jB3IhrSh37v
zfZ0F/jgwih/NxmE1a3a9ZLCygKX2PnVgdXibea2Rw4do/OYDrmqMu6KHxNjw/70
y7hcO9Uq7Gvn0MqDx4fEoknTidNCvOxoPFFvsnd+4oQAAsXVu0BrxH1w5DcRDAzF
rqna5BlekTnWoYyD3jnUUbCsesvsW3iPmDzz7ALmQsB3L/J+FnOi0CbF7vBBcQZ0
s5LIk4IlDGshoJGUOh1gLy6nJ1zUML3O1a2NSTUDGqvEOHt65ZJ4KBQPA8PnMyT5
nlBrEmgqBE37C+96PwT9lo09G3Bc6UksLB6YlJOKEnwUfCLnCjA8B5alovRE5pZx
ZAojc8RDTWFiIumv4fDbKLLbPKx+u4RPr+QU4ihDVSw8V7s1iZaYXTs7ZMOy7h7z
vaOXc9GzDe4QshYtiRAdc2uAELsgx5j+eU2X9zSYbJNs8GIMzjIHRT+EJro2ztwY
8KMjzoxFpCmFRH+jC/G2EGYsDD4w3DqNruJX2QiFBl2MwCgUmcOtC347UH5kr5Sh
lHcDBljgZAzuNm+BuiauI2iV1KM1sxgGGT+OkjgfX3Aa9NVu00fd54u/UFpvSDCA
XseK9tmdLpATb/EqIO9TItGw0egMspxhXzbSpdN7aI0aYxGiOltlXH+Su/8CTy9R
1Cq8cP8KENYRHPpOlFDfG3EP5s+XYKOR8V0a5qjwM+umuqG7k9+Svk8v4aZAetxM
BsDHsHpWeRZL9A6G/MUn6WK6nop6X3UJqdd5uPjxOtDB34OfNrpQ8heQl1tarbcj
0vjyZkBgw6s0z5VKrWidba8W4AO2pAyd/cr6jBI750IuiDf87mAW0NWSOVSZanE2
FIvvZ5EI3lRk3duuR5BJfBbHdrAjwfX/vMiSQOg1wna6cHG7PBxFIG4yn4/7a/Zx
w1/M8V+/RHIDwcExa/OltjF2z1sPZyr39Bmt0cd/VH9l3DU4dfKshQmK9uCxsq/7
3o8WDWz3GaXdzQ5M34NyEDEpz1INthh8mWCLs/0YJW182hIYRT4HFmfhTXyde+hY
4H0hLKgc1PhnZr7mJkm3XuHO9BwXA3xi1/PxIe9IOsi3SxfNSwa442FxqDnOZpbX
isxN0ugI47N7/++CCeXp4v4qHOXp53kA9C22fRZw5Ys17P5D9S72qaSP0aL9WNwi
zUc2rbvLu86nlzBH1LoPxMxRNMEylzA1U3vrjqsEl2RSDsV8wO2Vooe3lRgepdkg
wluF2ZQ45vVodVV+QN7yDd0jm+zSiLOkqoltpbzyy1RgmvZMWQkJySJT1KY3IhwQ
Yf6L79OI7a2Ft0LZM2CZNXjQcdtYE3VtZnXcbu0y2hGOpE3bZJI5lMGZmPIrFeb0
IgIWbmbUaQpaxDZaA1UbcovKBYN9I/lpWHjPEjpu5UsjfG1SnCxaYuePhUldKb2u
Mno8G1i5dDa7U3iYg7LKpd4zc2simlTjHxD1kLI+vNCUKIMxHNvYRsWmFcLaDutk
Fx3LhnJk9xUQ7MTWtMSZsAkx3ioGISnW3X0A4kGJU76Z8VNiIVdLaoC1Y1tDC1Vv
6Rbm52kTLERzanZcMYcQBsfGbxeQJhMBnksiBZhUTvoUqxzzb5s+ZCmFeDZz5BCZ
IcWsyxV+8HfepAyFiAdKrHxqveg9mKb5ju5n4k24lC+eGCfxgavLFcOQdZ3ZoQvM
YlvQXAq/lckL/zvagDnhmwHYjNRp9qQtnr4CcWVKskKLJ46QeUiZjyF/HJXE2n3J
5SnpblMX6vHzcD3Lm4VyNxFpiKCuXZke1O1crIRxocGW21B/WncEW86uRnb0ZRS3
DWFU47V0qYUED6ndlkpKtR6RaHZGf6FbgoTl+BmSMbGUKZAxUetlyu+9hVS9+hs6
T0SLILC0QEpsg5Ps2GPSGbdS/nnFp/VjaF+3RsBBrhQNwyc+IrZOTZ/VOc+aIQzV
seLq1NbOk+kIkc/hIeR1+q4sPp2xhooRYK2TKACv8UyteBKpym6Kf/twtgdm3d48
bIvSR84XUxunmx4j9EF/eKJ85cnbcOK7mFuYeckEOyeogVwzaaMTf14V74tcm4BE
y70iECB8uWFoKbm8fPyI2RkoDJcQFDXIzbC7d/fnY0bWkGZkAtvLTY8jBsjEhZ+e
wu7rf+Lk8Xv/cyI/8RhH49wkFwecYoZDgud03x7ekc2eXDaXBCf8jwAw+kOggoWn
hSKinz+CaNsyTD6o9bQvVmsofl4JCP7DIJrl7OZ310cq0FhKAbdo88lWJXhS2R8C
/x1FcmCbWqRr8rxpk4TxliRH3aUm9Nw5f7vFjStWSuqrb0EC4HWL/VuN6agr7gl7
YZYjmJq7hdTjvcR1g6KxFAkW0FUILNA2Zg3LqdEIdoWZGmW5h4Vj/zvQRz9UFZN/
oBwE9N4veMbJBm7OF84A+DBYiyJHwHpEvPrn+z7uO3KkljK64gx6QDwAf7ii+0Jb
YI7bp6zs92bM+l5bijYnjaFWjeSHllPsnadi8SZcFcUXLeNXVdiZhv3EOWzhFB9B
weTT0BI5iHVbCiNxbppRAAxLrLRihq7nXkv5HhQZyHXnRvk5qfTPQbrVQarJ3VOz
R03MCFiW88NNb7iU0ZL7XMedeNIWx1Bhf7A+joTaBLGlhtw/flLIE8QXEmmqfS+G
aigcTOi4HW0D/Tw/HmhJKn1pSLyZUjvt5s+QJ1nUoa1ZekoYnO8VrqZNvGAcxbpW
t7V9qqHfseFxrA/9z0lEm/CdydmSzsURo9HqVlnmbZXrL7YD0YwcMxNenQSBHYGC

//pragma protect end_data_block
//pragma protect digest_block
iw0Ltgaj3aCtKQ8klJKabrp+asc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
