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

`ifndef GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_ic_rn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply TX Snp Flit to the driver. */
  svt_chi_flit_sequencer tx_snp_flit_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_ic_rn_virtual_sequencer)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_snp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_ic_rn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wcK0DmxvjJl5dZK8oZX8ZpPo26sqI7EGFUfkEb0YithguDLDxSmfoFdsj4xc6vm4
jPCK+v+I2tIwTrRHRKz6AjEnax2Kf1h2h98IR2Qrw33YNEAnbMxj22kzt8cKxjO1
zMEkujMip3J21IRjbEMSt1WvNysVDmDf1DybKHjM4eAFeFAIyMj69g==
//pragma protect end_key_block
//pragma protect digest_block
IYjR2aOjPkNMstwqn0cD/GHXzHY=
//pragma protect end_digest_block
//pragma protect data_block
C+CMNpuMQHHzOZkhqU7pW909Jaxtb3diDPUtzVQA+XMAhzpr73NXzhyNaLw1PFcT
/8P1dsrFPba8tDX6DYo+IoeDak7YBtgXHY7q2eh98dBr8LU0fXxBYiLh4Obw37YQ
zQ2v7pu9DBPMoqpU363bbXNGJTJ5inK/j+AhMWuy1Nh8Ut/+7HWV63KFqewO70vS
J+Zpp8EVmu/YSrOHatXCVio5N6nSR3BjsR3fuEslNmfpTEzGsRiKeBdp6cOxuKNd
srXiBiWFZUKn+3I8MysITaoNjhQ8g9dg7KmsJug444Qme6plr1mBYKcqZjgJpoIN
K+piDvatHhaxaq9RxWJE06RfdYLg5XGRhTC69SgVmsf3srvCdb2UOxNQ5ilvzTi6
ye3hE+VNRfLYnFoDqdzaoQafeRdcDVBDdqkWkwLjiSEg1Zsh4VLA784nPLGr+Spu
5tfEdMpDQYBf8Uy5bMaplKDuSzSQAkIOu4vWjnRV4j6r/tgUguatV7xxAHyk+E2K
LpWfLdsm56HYUyyiewWruTY9pNoT3FVg1l42bb9azRY71g6fUpZ97IktRwBUHcyL
v3eY2lmATDWaAh3cJdO57eNqzLFti31jgRvireIKZDMWHqt1/ujAgLWc2n7cfFNw
VtZAKBC9pC6Xc4WzWA8RJGUyzPWLhlCozVRMDFw7QEVgaaabWNigSjgx9nsUWoIU
R/BYt9/+L+YezkpKdfGOUfB0NVgtgGZlpLUuOELLr+c=
//pragma protect end_data_block
//pragma protect digest_block
b3Qc5BrwoNM5i+/g4LmD0Zf+gTg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1Vfa3ZZRPDpn7SwOdQNTiCY3EzZJqYtTK/lqmYojvNdfCf7+plcvHSe+dmJ74S4d
NMPRYRbh4l+RpE+X8h/xJeiTHTViRtvgIKg2J6I3nsPaThvWeyDBy8YssNeCuYsO
dd8qldk11P1G5V+HWI23RI0y0wd7pKNxRPC8CYwkedoqeKdlG65DKQ==
//pragma protect end_key_block
//pragma protect digest_block
+IzA8JxIslB7j/k5vhoyqWI4tLA=
//pragma protect end_digest_block
//pragma protect data_block
7dqKCNogzXbuRJVbhP9Tp/duoKYwPR4CQh5enJKIDYh4MlLy1W5LJRtpuG09xrMT
JebnYDNAPpzX+ZFtkhEcOnKb+W6vVjVgqKIePh949DkZKmCqHoelxTXyR821eWHk
NNXoRct0dYwzTwFJHQyqkeaj8jcKhfoyNf+5diZnsBXiGxfQIvwFEjDJzT82w/uj
0jxvOlgI4/W/Z21pAqYTnAOaf+ksubdB4s+w3eAtsvVrjibFPx7b1ovFZLVCg/mB
uGFK/CL3qlEcYKM5tWs08Goz0oPP9KU8TSp3q1rJEWOTnOVudsBjUbWBlmOdXdWL
PGzao8H92Z6scRuNC6TwyNArOW5VylWxDhJuEuBOpsjuHgOp4TIOrZZR2nba8pdz
dZnQSB66ZUJRgw64RGqrPif289GIOaWqiPgL9I5ZKpH2QaizCDDYEN9xLlnd48Sq
2AnJXPR8Y7bpjHz9SkGTFKWIV1Lj5BSanmhiElUld6iUnJuK0ah+BrWKn0kWx+Qi
tp5QmilYyxzeTJIwx4wSr64RepyOITeX8enh5ka2SyF84GZjV4dOlYxd5NmPL0Ap
3lju2pDhB9QVUheXIqA/W1QK1gqs8AK7TQcmyUwRf5Il1l4H80VN0C+qvUOK1pBO
hrAqn57WWCmu3WyO6yuo21aUg4eP4LOBvy/sr6naBRsFw6PZLAOKn+xVuR6J8EAP
de41reLFSEuPc7RLV3zroJJFFuTiJWUUlizcpPi1lQ4cOW3dVh1lzkIPS/0fM8aR
/lLSqh96mQYDtkw4B/nTcLTnBsT1fXBU9gqV+5eEP1lT4tLRNIZaF04J9actQ2DV
S44rTyEOVivAHviIn0jFebcm1AARLn0mdTKf7Mug++q54fXySxZl30cGQAaiEmXH
hBsdLwtDkuIPDm87KSzgz+2U21hDYuLlYMU4xOJpYT/cMw57K/kV6pl8LkoBMCcP
KidE8h1tfyJEJi+xPk9gp1pjbW2c5HjsJv5iB7oYvdy+k5sBs3MrioRqFfryVxQG
oxXgq1O5U817ShK3n/amIt/uxK6byKobO+ra6dz5Z2eJ6oH6dNQfZojyuhltN0aB
AZIgPv8sIL+zSukyrM96Ih30OE6zfawkdOOyTAaMqCdj93A8Cu1ccfogX/5xxIZL
+mlh0X9AVwC0RjE6ZmWMYlyP5+knnhuERotLwu4E5coFMnDf3kF8643pFKwBEHId
NbMNywGGbFbFqrKKntbMA6MNONbiAVspYsSjO+6eB/BVCQ0QSK31vZ6c0dEEnzgh
k3RnuFwxYKYaMjHJMRQXxHbIVRtvv5kFBOZaIh1prVRs3M43mWcKq2ilKjM04Ulw
QASsOsJQJj9STtgl/A4VsclmGa5WR3qSXNGBv/kbXu4VOyjs0LFeiU+zGHsYcDQi
Ft+0WxSf/aLpEK+fZ3tXdmecnevRMCxC32ceCRftKzzWfbDjwFsDFofhUmDCWWdo
UxoeerTsCeLmw9RqnzJY7G5QZLxnUbwWjaFdYwGHJUzpo5gDfWDN3Ragf0GsnGbO
ZEtvZ+BYOcLpSYn7iR7JUy1gv2TGPWEZumE3ERnsfsnxLPrVcSiioQWqkMWcM7Oh
HV5QAEltQQq3cYPcvj+mRwg5+RuL0t9JMUTZAuPwEuqTgMkXqYmBMHjx+Z6rwKqe
9OtvHne53Z/C5QBdnC7dZYVbZjCKz9ALn5e5fGLrfYmYrsTpMeFNXiCjKUksJ/S5
knk39gNLGgoK2eq+sgIlh/RQAnGfh0jc0YKFmEsWn9S3iyQvO4+xa9Y2V+w0Xh6p
nX2F8NkY3EhzPi6f0cjbZzb2YiBTREzS3Gx8kQkDZATNttE+wSZq9gcgWPIAXDwO
o0luFVN0opMpq1waAMKXI9652OZwZAQHD2XOJb2UE68aVng+mYSBrWY0Y0kH6eFm
BLf7F6CVncYK3+k2c6uW0n5Yq2gHWr4+TO5QY2bXYzJaOXjEKbiNiHJbzoO/ZBLL
f/f6kkSAuOkIMmr2oC9bidxbrL+PltNvKD+lgTtmlwhothcD0mbFjTWsnwRV9fSe
9Jpxy7TVcm6zvS8/8MamnZ9Q6Z+OBqjBdkzAy1o2l8cJLbDWg40KeON1N/MuWWUe
COZObrhcTbMNy0JwXw3N37jMr1dKnr0HNGY0PrM9ZMQG5k71vFgaC/IIZr9byEfz
YfU5XjeAQ527DUuOYI6H53YYETGHCYIXUS1WccGzZPwsYGvyfVFPxQkzJIoiK1q8
43uFerA1X1P5xpidroB3gsz69F2dc9kI0R5ofpL/KnbSbyrl4tY3n0jieGy2rRhn
ARV1vA5qmP6PdP0hhXUoOWBcAIXRxYj5FWvNFyPB6NnCmwCHKOVTyL384yjevuQ3
jYkOXGAT8/rz0lB/DWStMvkEsDZJnXB4PjeCodH4J0C4tdGW/D/dHZAwnYt7IB1/
YsRbTcsBnY2vKP8dm30yVGP2h+rrK2lNf2nRfTvKTIWIpV8a5dsiztwJ0HXWfUmz
wKR1iFsNqo2vdn6bJrlhZZyoBAVDI98RaT6MnWCQc3I0Xc8GWcPbN/iZlYVgW3dv
GfvAvvgmgawhXhtLs+XbG1ADo9TXz/VOeSsJ4jwQwftzhdc0c8QWKnfAurD9I1V6
UP1uN9dyQPtSj9cwFYmwMGfACANP6d9lSvfik/w/7Y8ahEkpcLubLMGt20Uejsnz
3gGjLNZ416lDdj7eMvlapbmZFWbI47NFQu1/LQrPtpmDKnlXoTy93x1AMIaOyUvo
edSbd1N1CPSPOxa8SaHddKBbm3iQMcymTu5KJeOIwvDtzuXcQjO2gCAi1jBtfR35
yeJNNpeqnxKkpr6EIlS/0bqc6fF6G0KHzPC7y8uWjbjejHs6PRq4lnf/z2+mKduK
Kygeb63Z7eXEyjKcdjzlHCcaiXkeMyrAIcK5uJqauQLRy2rJphtoDHfBxlVCp/0E
wQHM3ili3ozmHVeeOqY+RmsuTnckVCU8r/3PyGnCmPziSuR2xl6fCip88o/l3FpF
eCbiD901l0ns8GjQMvH/gEo8gfVuv4WMUyQZ86lHL3I=
//pragma protect end_data_block
//pragma protect digest_block
UL82pkg84+CFDTThxGVFDNb1/NQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
