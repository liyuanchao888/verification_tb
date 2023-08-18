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

`ifndef GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
`define GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Class that accomplishes the bulk of the RX processing for the CHI Protocol layer.
 * It implements the receive logic common to both active and passive modes, and it
 * contains the API needed for the transmit side that is common to both active and 
 * passive modes.
 */
class svt_chi_rn_protocol_common extends svt_chi_protocol_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  /** Typedefs for CHI Protocol signal interfaces */
`ifndef __SVDOC__
  typedef virtual svt_chi_rn_if svt_chi_rn_vif;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * Associated component providing direct access when necessary.
   */
`ifdef SVT_VMM_TECHNOLOGY
  protected svt_xactor rn_proto;
`else
  protected `SVT_XVM(component) rn_proto;
`endif

  /**
   * Callback execution class supporting driver callbacks.
   */
  svt_chi_rn_protocol_cb_exec_common drv_cb_exec;

  /**
   * Next TX observed CHI RN Protocol Transaction. 
   * Updated by the driver in active mode OR the monitor in passive mode
   */
  protected svt_chi_rn_transaction tx_observed_xact = null;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /**
   * Next RX output CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_out_xact = null;

  /**
   * Next RX observed CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_observed_xact = null;

`ifdef SVT_VMM_TECHNOLOGY
  /** Factory used to create incoming CHI RN Protocol Transaction instances. */
  local svt_chi_rn_transaction xact_factory;

  /** Factory used to create incoming CHI RN Snoop Protocol Transaction instances. */
  local svt_chi_rn_snoop_transaction snp_xact_factory;
`endif

  protected event is_sampled;

  //----------------------------------------------------------------------------
  // Public Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal vmm_log messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, svt_xactor rn_proto);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal `SVT_XVM(reporter) messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, `SVT_XVM(component) rn_proto);
`endif

  //----------------------------------------------------------------------------
  /** This method initiates the RN CHI Protocol Transaction recognition. */
  extern virtual task start();

  //----------------------------------------------------------------------------
  /** Used to determine the extended object is a driver or a monitor. */
  extern virtual function bit is_active();
    
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Set the local CHI Protocol Transaction factory */
  extern function void set_xact_factory(svt_chi_rn_transaction f);
  extern function void set_snp_xact_factory(svt_chi_rn_snoop_transaction f);
`endif
    
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_transaction create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_transaction proxy_create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_snoop_transaction create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_snoop_transaction proxy_create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Retrieve the RX outgoing CHI Protocol Transaction. */
  extern virtual task get_rx_out_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the RX observed CHI Protocol Transaction. */
  extern virtual task get_rx_observed_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the TX observed CHI Protocol Transaction. */
  extern virtual task get_tx_observed_xact(ref svt_chi_rn_transaction xact);
  
  /** This method waits for a clock */
  extern virtual task advance_clock();

  //----------------------------------------------------------------------------
  // Local Methods
  //----------------------------------------------------------------------------

     /** Pre process transaction before adding to active queue */
  extern virtual task add_to_rn_active_pre_process(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Adds READs and WRITEs to separate buffers if separate outstanding
    * for READs and WRITEs are set
    */
  extern virtual task add_to_rn_buffer(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Loads transactions from read and write buffer and calls add_to_rn_active_pre_process */
  extern virtual task load_active_from_rn_buffer();
  //----------------------------------------------------------------------------
  
  /** Method that invokes the transaction_started cb_exec method */
  extern virtual task invoke_transaction_started_cb_exec(svt_chi_common_transaction xact);

  /** Method that invokes the transaction_ended cb_exec method */
  extern virtual task invoke_transaction_ended_cb_exec(svt_chi_common_transaction xact);

  /** Drives debug ports */
  extern virtual task drive_debug_port(svt_chi_common_transaction xact, string vc_id);

  /** Triggers is_sampled event */
  extern virtual task sample();

  /** Accept a TxRx Transaction and send it to the bus. */
  extern virtual task send_transaction(svt_chi_transaction in_xact);

  /** Updates the cache based on the snoop transaction received */
  extern virtual task post_snoop_cache_update(svt_chi_rn_snoop_transaction snoop_xact);

  /** Adds a snoop transaction to the active queue */
  extern virtual task add_to_rn_snp_active(svt_chi_rn_snoop_transaction snp_xact);

  /** Waits for a snoop transaction to be available in the snp_req_resp_mailbox */
  extern virtual task wait_for_snp_req(output svt_chi_rn_snoop_transaction snp_xact);

endclass

// =============================================================================
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Pplsr1An/oXNbk0NOLZZzextH0BDvfoPopLgHUd1kotJJ4Xn+z6khQKxQYtAvlEV
eVAL4IOMBqYqP1MqkVpG0/quvRMt9P1tklwNxtRzrcFPaDTx9fJJj2Vb9yXGb9sJ
TJ8Ryc3uUZpWx09Tsv/G3edIt6tyAfiKj+5fIlVPSAU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 639       )
r6KBkdMYlK7zgSTdYeyDRkk6ZWO7HCaqJVcMnuazcsB5bfAo4DaAaJyIOEcFJm0W
3hLZTDBQ7Z56LYoaiwNx5VHpxy/Bk4FnFaKZTFbeoJOzyHpGW6LansB9FDp6oclk
uoh5JNCyq60m16+AZ+oLYhIB6Yiltk34TWHuXO/B52zLnscose9Q5HMpNwT62aYP
kXefPz0qFdRpnneB/CCbmb9TDYO81YX/PvxPWvwdAX0/AQyUhE83HPa0kL3TIWI7
8JPZxpdu+8V3jHS+UmFEheqAGfo14uL/Mj0c7Cn8t11dSd46pqRyNZ8R039Nw0GO
8MsY7gi6kzAtctXZUjQy8Gt3GH0yK4WllZ6sfTvzNxux3R+GE2fL0+00aLm6PgUR
bo2MB7F+cbCwGBW0RjEIZwulAVLPOEwvlxuO94kD648W5t9zx13t4OoZm3PxXL73
x95HvXG7Zm+/HaNk52cnOrK2BHmUq+elFSlG9QNDY33//5dTGVTic7y1fjb78mHb
Clxf5tBTIzqiHWuUgzbenzH66mJ9vNuyW8Kn01WYo7M7b1QBRgOoJeQbNC0Zrwr9
Vn2oIDmq0Nh8oDnExGEjDuEqG3FUQ7Fox/HY+Bil6fowT38M+R+C0+dIszw2nKh8
5ipIwCx+xmtx3NtVCZB7VFxAfHFagLR2Pyx4rCG5i5mNuJes30uCUp/k0EQJu/zi
MrXCsRCD9Z9z+BoaUIRaH2RZlhNRijo2lgsECQ5gPvq6zw7BAziUfGQAaCcaHwba
oXxinYcdGTl75tfhjBBuQSiiriL3jbhcU5WtC5dLQbJqals9I5WHVhXLDvDiyQsr
+rMQYIEwq8SoCdVABNTYFw==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VAcOKMOVL2C/TmE+U7NMXIy7BPkyo0BcZUaSTktDgDIsAGJahIAzXYJzfQxR3win
jVajZPOlQ/ehLt6buZRToGgtrnYzowvEN37v7zAUhNWeD2uMeZqLHZUn0IxZ3gfF
rL6qnv+pEampLYZiHQgDsO64ABJADxo85ooywGarTJ8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6579      )
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Y6E8ZhyXuLkHcYQ5PY400/1rY7gjJi1VyPAh5gPMlDtuyB7tLEZP9KSJI7AX2aaB
W/hprA51bh/GigcTKSOAkKvKEckFSqE7uIxZvvEmJKIa68xta4Oo/KSHRIupXnK0
pIo4j8qx3N/EpAKRFp25/v+c7ZJPtMANjUgZMIvHKIg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6866      )
y/U1mIXxZLZXjBG1bFdhFKz8qFEc+oupbxQOVrtJQD2SCIlFuoEQdHp8UTHofRg5
yBq9Wgs7DYLFEJSq1SPw1DH7QPMMM69TTr9uMhzctOhzOpD/qUBLuRqokAVD5nU0
akdgLGQRKbUHJ6ZL/URItTlDHLN+jYIxGrQwBb9aNBFzbilNV+Kg8HfBsAptFlzJ
T11myI2Swz/9wJARDke7zKpbassyODECcnDfyGX/nBYtsRugUsQ1uDJT+oPkiY14
aiPtLTC2jVmwtFO1rVrMbI9T7PzvvnKDFYoqEN84PgU8piWRBcSp/Bq/hCjaSeUd
F7QGsL746qaOa1QkQ/yU5VWPlgZAHPFf/+P4G/2Q6g65N2yLB6YjILQoMJSNQkwl
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RhDMGrsF/ZeR9zyepxXaEMzp85jmWXNdl9cqtYPWPVUuohVhrOGbMHWnDOP+zbbS
rMwlhpjLdUrciUgKJWAbrPlgn9guqCMoBVLHtF/L9fIAGWf/TVgyOLzm+YTfOAvQ
ZeE9Bo84ofK3rHZpLsUd4NwCdmVADfPMpy6UsoODLHQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8648      )
6gLNubD9b0nI+oap5hctKUQHjPUGJknyvd1T3UxqPtjgr5zTPSEmGtOAOkL72Plq
jiVuV5rMzgQ68I4Ikv2118taYwuvYTJLOEA0nyZycl/ZKGKOUiCx2kdElWmxol4c
koPxacBLakhZX/IhX1Dc6S4DRr9u9J50wfk0GvP76If8dBUfF+5yuUwXQcXmnb3f
BmXgXs5+JH86DQgRVqsgHxkpHl0SOImH7eqIlQu+zq4DEGrjeLevGZ2ayBsjPrUG
3520u/g9ytGDbeEHcNJVWE46TU49T2LT5LOTBHgakQ6RUPdNFesMjDvHLuahkCAN
y9oIulKJ0ScOTrwENSOQQuPA5aNhg9K/vMusx5Vm1zlj1FURz+jyKB4SYem/QeqZ
fRkUVYHlppFi/jlC3tJXtCCmCo1lgV6Ta5gF0u7Hbqw6OABrWnIECo53nSeOJUIo
slyNt6w9WuNfjUFv8vMCIJ5CTv6YYpmq4k4nB/nx/WD9Ty8JXjWwJYjXbKmkJa5U
mDm2DJI5+fWUtCA9sMikzES4inL8e0iKRAJlXu1qDEsV4moOcDrv3A+YEdDZFBz7
kCeAhpMneGSeOPInriDKzxAL7d9zSIwlW+roMaMLF4d1PO8NFiaYLywluobLhvK0
t+Jp2tOLawHEQDmBsdJPeAUB0OBOtWJrDaXbY9zP2Fyd4b2E76CQJ2GpY319WZyr
zdW6fPLIE7HOxzMj06is+pFnFFCBB60lHMK90Tnjqyf1TnOnzIRGvjOxQx1BejDJ
2AzsOVvEel3qKCSPJ82wZTw9EXNB2b3ylk95WNZocfJJJrqGjjjdh3dZjCY4QjQR
HFSchOG6DJVUQmtWML0XpqJ16++CYJkpGSedduf6f2WkWZ0ilwZyrqQpzaRftwsi
G8Z8teWZHv0wazZpXC5XE5EpNGiEzxQ/fth62DrYbyRtoBnCNlRzjAT3o0JkL4H8
o5sIfyr3IQFkHIa/2VCb4eWRLGQJ2egQfgY7i8EbDgzHlQ/NWmcUxF5r4iHMYzLT
RxsltNCbqKmIMAZu8zcWLP1x1pBAcTIQ1qPjfySX6Sn8O7lLKEjaoCgU5Bk2O2lF
NYKyP5Pl/nr4oyI2S2PPdP5NguJqDvh5yVqG5o/TPLWKs6M+QJw1mcTfcs0UHunm
ccb56egxtg0MnWMfHm++6eZijHNOYrVhLf3gujlZknWm7jZX+XW1uGTOV0qtuKhF
9FpDpMyHZGixpMnCBDH6MjuSWkmfY4/dKhrZGoH1c/35Mqr1KKD5LcwCakMiDmIc
yOi1koqu0iIyF6Q8V0n+fXO6oUFGULuLWm0VhElWK3ImeecMdQK3RkKx1m8uikGh
pb56ofrQ6OB0hDDYH8VOe/6PCGD8R3qXhqXKi+/hXQhhkqkYTt1dVqAcZDcR3doi
pxoui9dLG2orE3XvTzZOTTZNJhI4R3VKn5g0VnNf1jFYKPOMOgzb3LS2rFtPD+CP
byTzzX0IOmor7EYIcOyBmjeNFefwQTI0KsBOZU3UVz3UwFXPjvsQe4JCB1ccmaUx
VEPGidVlIX6ST8BfeBF9veZ/SOwHlTa3Z5o9nxxq+/hwvfxng5ToZMxXoyOoAq94
ehyt06P1JWjVwXvu5AhCbei5BGXP/zOGFLK8NlHHOSqcU9nRr+M+rLn71yI7/V97
uQZ3gMaJ1qeXDFynRHHS1Y6ybm5oCUGmekW07wRwbmD9nR6LDpKVC7lEwIEJuinp
rTvP9o9GwLLGyPx9+u+RCjiyz02QL7dptDhDORe7WP6fGtzjguvO/MXr++x+p9Gy
fj943PIjsQwzp/Bl+fmWx80IrosWcJeiBdG+blY0SJQeHMUbOIjaXs6maZ/XyQFC
joorh4iH6l2qz/YVPEM1pSlu1e9WUr9CvpiAyNZmQlAf4mlDPu87OFK8uj9QjvPf
GulnzRo0a5GJdCf6ONvLc6e1f1uzpqT8st3FpzQZtfkZ6ERNnmwvhWNNU2k7QUEy
zxyHAH5Z3iwsMDBElfy6/hDJZ7v9nA/l+dpQKhF87tM0TywCOSdvyZwEK3V6V1+0
fiJNAOQZ7Vl2FkP28gLiuZZRmDQoALPJImIygD7cQ5pimpWAOwzCHxfXz6LRwkaA
+iafeURWmxJG1W9E1Y1SKbjxFSY9g5MoWocvKuXzJve/nhtmuCaQYZ6Bhn3WTLHg
s1g9h2i/RYhTwyitWMEs9F35/EA482VpL97b4cpKHmOLu9YF/gDkMVO/Y3Uj7kN0
JqNuq8h9P+M5L10mfjnP+FDpLR4Tv73Ez5evCITxPkmMA5XjLBq9N0ChgaCtrKml
SKMOkYLzVJjVXGroF1xP3GoukpQkNBtBVAChMo996C6lTG/jTB6aSMmLscFwUNP0
+UxlEgvNxvdrSys0kdm1vQ==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gU8mwNX2YB3+T6OO1YWS4v20d0Qfkwf1/1gyIUu7ntYiqmy15IFCfiouNIF3mYeK
OVNbALiu+IbZjyYeHTp9QBisBqh8Z9N+FRvEWSsJIvpOHG3oPkIu4GMGAM2/2Cyg
G/P009uCnGrLAg35oX4CF0NIjlJta+tkjCnxdiXoybM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8931      )
C7PxsrgrMVGYrRaVHvyoYpPHaJm50UBpuOeZ6FCltASYGP51oftsJZqRUqniVPGc
ekJRESaPhMEHsYHHecYCUV/wGPB7BXCyETjGnR+HJ8R0UizArBnRE6qDYk1KcEAy
rIPlTkQ/+U+n14CamNxp7mCv/9pdHKoW7XygKYeiWXreFtLp153iMVX8QIOQGEyn
GdhJynps608RSCs/iKFbN0MqJbXHZw7QK5GxXa1fo+YKEEQKYe9l2kfC2Y5aAVnN
CnsBucFkmhjNgy5i5AnInsSxiRpUaIYVI+BcK3nNh++NNFteLnhClvNr2pHVrtBo
vjtxEDgIlANJSUrBuRBs2iifprBdruF9R5oYPUPESFJrWlUjrd/xWUH1rrYiEhFd
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WEBLbCOX31RmeoboT+yT/YEDAViqAsy+taAV8rWTtZ8pujZSd/Tdg5QWCexjLUW/
qkPtwalXcD+X6CDH1qtvQShjluZXNjO3gI9nu58ssWOFLSujLfOlcVuCEJzDj36e
WauFx8LReX62jJxyzcmXoKEK22/5NH+TOpQF7E2pnTM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10662     )
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
BKhqCTjNZGixdEv+aODe5Q==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XQUQ5sQO0HEa6mmvHlCgu+6ltEvSK9rzRqBzYFB1issomCB+olqJ8wY25Hn9gL0E
pJWcecoeAy1PruGJZ4FnXW/pnsJbAyJXuc2jZ5+ao+l1UDNABzqYSMO8II+A4bQX
gs7HE8p3HmWpqh3Ernnxp8B6zMIZoyILN1qRxlTXhkE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10745     )
3q3+BxGhIDXuy+nyUFuyR2xC5zMB0U/k9o6hkkmPoerCoVavR0hw0WYsCbB5rkpB
1vaP0Q/RB/yTjgnJ7cuCwZKqqneeexHpu3V1WH3yP4yyzNol0b9/Gzi4LquVszIx
`pragma protect end_protected
