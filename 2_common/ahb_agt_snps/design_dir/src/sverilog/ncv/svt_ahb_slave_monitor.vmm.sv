
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SV
  `define GUARD_SVT_AHB_SLAVE_MONITOR_SV

// =============================================================================
/**
 * This class is VMM Transactor that implements AHB Slave monitor transactor.
 */
typedef class svt_ahb_slave_monitor_callback;
  
class svt_ahb_slave_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port that makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) item_observed_port;
  
  /** Analysis port that broadcasts response requests to the slave response 
   *  generator #svt_ahb_slave_response_gen
   */
  vmm_tlm_analysis_port#(svt_ahb_slave_monitor, svt_ahb_slave_transaction) response_request_port;

  
  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  /** @cond PRIVATE */   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Common features of AHB Slave components */
  protected svt_ahb_slave_common common;
  
  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;

  /** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;
    
  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_ahb_slave_configuration cfg, vmm_object parent = null);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Stops performance monitoring */
  extern virtual protected task shutdown_ph();

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  
  /** @cond PRIVATE */
  extern virtual protected task reset_ph();  
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  
  /** Method to set common */
  extern virtual function void set_common(svt_ahb_slave_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_slave_transaction xact);

  //---------------------------------------------------------------------------
  /**
   * Called when hready_in needs to be sampled.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when hready_in needs to be sampled. 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `vmm_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the sink_response_request_xact method needed for #response_request_imp.
   * This sink_response_request_xact method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the sink_response_request_xact method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   */
  extern task sink_response_request_xact();
  /** @endcond */
  
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
piMkGTrF2Wtraif2M+9SxRKVGRG6GxQ+Z8emgSeQIu7SZPmu6AzGRbT8Lzvh1tIq
Yvv1EKpXTZTIAROe9v1WtOjFP68koGgRPXHrgjdTRjg9NxeYg+LuqbNk8n13cKR5
q9NZ3ATJVMvob7SNh5jD7uw7S+ZsvD0gpJ74f7yDsMlsZRkioyBNnQ==
//pragma protect end_key_block
//pragma protect digest_block
zlxEQdOXPxOU0dONnD4z4q22AHk=
//pragma protect end_digest_block
//pragma protect data_block
Ra6bf11sAqrg5lQhsdklNAvypCKqR4UTc/QNUdulxnJBfHPTa2EC+VusNsFzXrvw
IPnpyiKKx22kFAr88O9gqNq9D1GZycVJE6MNS/GT0dsRDF5Pg4G2Ksgsha7uhhiD
beea41SfSzjDHAuiaeL9AGrR4aMDrPnMPwIdTyiiTgKydoBL2JFpDtu96IgC7Q2X
w5Usfz0r7y25AeoXybVTighFDm47tBiH9TU33bVo6lcBpy9GNf0e6Glf8pG2Hy4G
ErUNUXsS59sbQ+JC2vOz2ZszwC/GByEBKwohKQq98T/7Er5/sz79J+6pCU1jUeC0
zQr4KADlElLGtme10S0ChyoDEExKtk919UEDYneHmUze9pFEW8zC1WVsYQg+N2LW
0OT7PGnyNhyZhEOX3MGFnS7jXQSZvQKN0FJdxPvyk+pB4zNdw9C7mufoaxXQJ3er
jueuz7332H8+8FBzLu+8di+VAu5DsIJLljjHxer3Xbwqvj2R95eoVDy0TEjh/1Vp
QJJaGQpKev0I4NkfBt3IRyOPqpVp67a+eWS6FHjmhF4sDjc1RlWYjoCM5xg3qC0W

//pragma protect end_data_block
//pragma protect digest_block
S/Low/sdF/f+xuzhiyas2KhU5NM=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xHoLXL7jioSBSSVfUfGvtUlmwDMOxbR9SpcIOH1DCb3hhC76dTf0/X7BMvVpA27X
ApKdyy6CJJxc/bhfr1TaBqSoA3ioXgu/z3GZtoJDQyaNDKgZ1y6l4ZgM74qfMunh
KpLucSel7xdwWxYXhGrVgLcfIK7vkw8Xfut7I/K4dju3CRGroWesUA==
//pragma protect end_key_block
//pragma protect digest_block
5BV0dyzO23IfJBOvpsG9ljgoIvc=
//pragma protect end_digest_block
//pragma protect data_block
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
6eS6kewT6GfPh5gkGswDWQ==
//pragma protect end_data_block
//pragma protect digest_block
Jr4BgY9iEeRs9Sg2U6AOAzWIpDU=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
t+gqsFlTLm4gTi4o0k6VlNG9UktQbcRYz9YyFFDHKhHISoFHkC5FBQrSOAz37X1u
qGjGK8YqY86RbMAT+fRnZuEz9Id1wnG+ZQMCBNVdP6C9H7dA5f3LLPzod6hxx+xV
8YTyx9grEtGRgQqYSs3UnaUoyOnMryg127IX3gZlxDkKO+wAWLTLug==
//pragma protect end_key_block
//pragma protect digest_block
UrUx6hQMb7N+wmwsFpFRnizwRT4=
//pragma protect end_digest_block
//pragma protect data_block
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
uPf6NaI0oM3WV5g5g1jBVg==
//pragma protect end_data_block
//pragma protect digest_block
2GhmzNS6bBe+XKZEWljeSnOTAV4=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SHdK1YlqaVo3/lQKSO9HDuEMtXpPmc19IVcfq89H3K6wG1jO5cIufGoUu1FFY0hQ
Kq0WErS3ce8DhraaPlECOKefffog3JE9VJytDEyJM3nszQFlSB05KH/s/r8PMyo8
nppy6VTqNdqTLwGw6rVwy6rFl7YghNLm00fcEN/MsQWDH72E8e+HVA==
//pragma protect end_key_block
//pragma protect digest_block
g0g7j77Ff8aVRCi445fzuBBgGZk=
//pragma protect end_digest_block
//pragma protect data_block
WqYA3LUKyOvWVb9Ooj7VvtKtTJPrnY6sPaC+JoSrKyaim4TU7PmKNciC0PAQaHL1
5dYYrd7blsRwPiCuVOp0sK1MWgmF1zquJnc4+PQS6rLi2xrbjHnFy1VDnnTyoSS8
qyqShgPetqIBN788TampCa7brFDG0cXhrWVe4FEkemMsCjVxal6kkFd27uYAGw3d
Z7BLT8KiXTom8MJK1TsVxWmqQ4LZbqOqcsX3QLTHda3bMAdDgOGA3HDQvsdTHjtH
R2/QqeaxoAOqTm33c1jy8fJRIi/QHj//cy6+ajmsmyqMhHBNySZmDDmu7EOkfpmq
WI5HLgBSuKcQu+B/dUHlW8u2bl9iW2N3jqO/wwWtw9TxPXNkzrmJia/gvLvM22n5

//pragma protect end_data_block
//pragma protect digest_block
TEvGf6wZYmR9u5Uv2b3yJwqFYf4=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w7lqr50z12bvPtDfR4+v8D23GUjo5f6xZUmBusj8hkIsZbPAlfSrmtwOK04Hx94h
zWFVL3rQ7Wj5SR88r0xcGHJ/vaDM4A2JTEpzMg8OJYhCvejZT/qL9U+1tyB8pb0t
yYTmG6U8pEdudYlLI0Fnu9wLDqY8QDanky4e/SpF2b1j8NfhYpYONA==
//pragma protect end_key_block
//pragma protect digest_block
OXIannLTJxIbS8KNHiNYoacrOfk=
//pragma protect end_digest_block
//pragma protect data_block
vI1PBTeOaicglyrath6J7W6TPGK3qWmf8lU6uMjZPd/qaKEnTioCq/bT8MJgcyEI
2x8nYAQGpCzGjkddjW5yrOsiuN15fvRfqOZ6V4TYxroD0+ogoHuk2qKDj1W2j9dY
VoA0/4VttEm+0pUfbfhRRfXs4CXTwIKauWbr3U+IK8f3meLjHuKpSroZ/RgV5AtS
tBqAj6iJ54RZN8FBWagLOQtgc6bb5ZqmBPhNZQ+hoLkkJCn15zddF0EeZnCSirjI
h9r/Hsrf17jgHLH8742RXONo3KNX84/GqDZj2Gx7/uKYGHV524/SSokLD4NXtMhj
CeYJ2xwldGm0fzEJDl1ir5AOlWYrqIauDU4z4JmVwEYfaexeqPezyLETw4QBzXOK
7yoCPglR93mB1PxLDnjymq4AfAOxFZoKC4lqbZ2t/kBNEYveDe8r6II5ZhuESWmY
Om/TgldTJNZ3EAej5/fNaZuaWjntLhMcFlpQq/AhBDCJQFYOwv5YFCewu3Ks8ZKW
UiA+gjuiDykEJ3PHozDarXxW2xZQRbiPHgsOVSjRoAlmwSJdZ954SSM5kfuLWA6d
XX/0HQXpdwx40eBfka5MHjTvrK2/fMKlvy2SZaajpfHjLMezuB9Gj+1LCVWuenUT
dsS1y7DI7Jal+ItmTu/VtOpE0rcWqVfritFGWpPI5qNGhvT5nzltjCsOVyT+MO4x
fFQESOU2ode2ThH5fElvrNGsiI3XJg60+WqbMnBJYWT/Y2fB063cvBuLtcRI5RGq
QteBmAiWYBK9UUYW1uGP+JXna5sSvpXYqu3kX3rO6Tswmu8wb4GVf+PRa2NjNLvq
B/xBWiJBcjonaozXo7nze+KLE+UFPvymnoARPoZXA+DEg2EQIrb1YF0/SS3z9s1/
0DH9Y3qgo16gXWUow+aOBThIX0sNJL3g3NWhjfiDOsOgizdeT+Vpj/RgDTQfp1cF
CkvZ91sFXomUotwTGa2PU0XDNzlVYxPmZtLCyweM7Wq3ZInxGRcnZOTHzvw+rYOU
OPZMVsusZqFESMZq3LXk3BxGVIqgVz9wWULz+AJIrrB6qTLqA3haxX69OxDekkXO
p+9YTkNirdIUmHGP8d6ssI6/sa1rg1hsnf1wvVWhfINOemI+MRalGPYAM/qFkScB
ZoNdvmKYSYVOLO08Ec8n+RxaToGbHTYbo5mwkusUd2hDZ/Ua5tToFPKu2x4mDlLc
TvUEM6GSGyDgvK+ooA6W1T8BjVi6D12To7QlA5Rn7/HgHQMbYBLr8XkYUWgNHhxq
h7Hyogd3BfxoW8kU2tzcF/Oe1BGYErjvZb1bX4wxxp6B8IrwgM/Y0Z6M2x4JDz6q
vBLM1IZgzsqAKxKLN5PWyUj8ezfwUHgkkUJFrPKjKBvx+FFfWjrSr4McEgZGOiG/
SD80Ke2xnjD2CtPeiG99bpzsqR1XbTB0DMw164dIdEYonNp5DNd4XMaCPyZG4bEr
20UOt4PeWPTf3JRpwUBjaPQOQhWNSZm2DuFJb4eTGKMBI40HXVQc//ztZK4duGmf
7HCoK5Alr5k14Rf5BL3mbzU5lJ+hC5cgJnEQom183Mt461+N0aClw1mTiEnYlb5L
TafemgBcU9MJEEnWi9VX8T79/p0pxIvm+pdKjvlMu1mrJWabPfjiuIMYzxSqrZPI
8jn7CULUYr6/6XuK4nZzTSEqapy+wjMu7qvivqRMkVknm71pGDlmhhVvLxgnlAmq
PWlFzD9Y6bElrFmq/zVRdxqTYERKXRzrMWN6L1zo6mpC8fWTOVloTUZqpA2w9vos
ne98k+5eUaTn9wtX+fxBtgb3GM5tZxl1uj2pw4iBnU9at/sXojP5/UbZZvHp3eC3
zkokw/Dzi/Qs+VAmymEBOm2lFMTqxaonZ8NG6pUesjX1BKdn+fVwQNcwsv50qV5O
chOi0Oa0eZTEEMHBu95L1YxIX15jK3GerdE5C4F9x+g1qBkwm5C35PhpSjkyQVqq
I+YO6R/ZbeH1wqyAHl54+D6FwXKfG+EVy3txqh/Fpm2VIpA/vJYtsjdk1zfULDhx
z4eVCPUXaaU+vZENzrfyAS3EN3wF1lf22LiOzqlRoMRu/zMv2VttgOpxwgYdS/5x
NfCbLwRkLkQDcbYpTp4vLLOYgxza2dw/oOOA4hukcsLUjpJAfXzcbGKii8Yiyoq9
eTvswHutrcvW6gHEuJE3M2DQy+HRTrNn/CJxZa2bwhL+FYG7kLaro1NAKTkVAoI2
lNcQgZtN5T5M/Tv+mfyWQ6zehTpAq41dq5HjVvBmbctA5RrCETGPdjjBP+eF7JMG
g6LBkdlxNQK9B4SEbuU4Pb+5qTKBcGDr3bUVwYFfhzx5qvzNxF4KanxyDNTKetT1
pBIPaS5JYOVNuGaVHeGWRRyoM8PKjBhe6a29YC69wtxhHj5SFc7lIWah+gQ9kN2C
evxFgVSpDU7PU0XASdQec0tyQEDnwjqtAO/jVLRmghhmiz0kGgbZZGAgyyEzH7qC
l2NY3sBK3HlInXNz9wBMSrBKHW3tuX8RKrRAOwtMblb+XQTgp+uyOWeS6unWTn2v
TbBOEWMlTACuOVos2i0grMZyXFBrrWEUfZrdwmAqgeL+qFK/oa0M53RuB6MERpDl
Dz/bhmLMI6Nqgf6XJCHCckdpuBLOA1uluUnRgFOZ9JE8HlbW2GECQ6mtp+enw2Qq
ctl6o5KTAvdgww9zq4/RWkn8c4u+hykUN17lC47bYP+4BFtfpP5jcjmfsCv2Voer
LyRher9RPkzrwbtNzkPV3kTIvFrbmaHwruSMNgG6kZhawPvBZdO4Xgp1NR38krh5
mshRuG+jm+IYCwxTYmTIQvM1RdXhCeEGP9CDJP2MTYVgcvBkJGdFFTj38cju+JrK
UsMD6TfKs4pLc4wwsgnbuDq81hHbkMcSlm9G6UekI6YfeXF8nSZrorSXPMmRtsme
Bo2bynPn18RqUPJ0+xLXhQ6FCNbkGVbnC/Yd7nrHBIoyQQ349rQ7Cb0i6y5HfCAf
B5Rd+7VrAx/yKGWh8M9n8FDMmgwHX0x3IoUx56dovcYI/OclK9exSlJyu7I6cL2l
xLgGJdWSip5UQ94dI0Gl4/3eW8bKVu1FYypMXTPIRpptXP3s6meilosjvlGSyk0L
4GLt8AnOC4+mShOgC9AuJJ+OCXDbyd0vBpNZjPb+srsxGPcPcbqo6j2weCFz/HOC
O9kHuweCBOa2DAS/v2tkG5Nl4aB9UNdqGarpxDo5u/cDRXt4ZBc3/eGRQ9Jbwolg
/Xsuo8dFRuRrShaNhSwf/wdDrgOwJrxbFICGcsgMR7oReAurDsskWTOcwUiYa6Vz
F0fTg8b2gBX9Ry2+JpiA2NPq63hMMZGAhcuaxDV1Drnt0I+3Sp+QWh5PUYXgq8cg
wklNnjo9qu8NPMba4zQgRDfR/pN1lI2h8IL62RIhcz+NxOIzU20EyrCxUjTs4EwS
VA11qD9w+tJiuL0zPkRCEnKYePLU4+UrgLnAyY7xXHt6KcZiAVnrl4cEiGUAwYCs
dx5KsWloSryhYJ3hdXip4g+tLXC4Ru2xxvbyBjhdYO6pEyqkE5MiLNlu2TPR2yt1
NVxXFYDZ3lV77lKCPB1n5PH7Jf8JB//R3T0sw8nlsg8ctvz33fXyrdsNWc4gLeTn
8EkmlruZoJ1FoEzF8nv4J5ulJnNPwrYE9oVOE2ehsWvkLBgpGToFoAAJJcATK9ZP
AudKSTjl57jC4364cYEZHE3hicQxuZ6tJ83wDeRRXHGzQD7KPWSBcRk8qsp2GZuM
ClpjqDH8fI6/HuxeA1YT2xdt2p3FW4KaWnP8BBJilJBgnuDD/TtuVsjLKny+YkqX
poavgk2nrkT8/3ctJK1gnDgX1LBbpZ9MH5/05pzkQHm/iBAtmVjKxPhfJSDBzzsJ
mzGitO5V3CG4X1fAlNpoZ0Ljs4kkTnodyvaf7wb8KFVeSL9Uu1hUAtgpa9TIDJ5u
bfMsf/t+S/DgrcVcHcWsaV5uFYY+QEOlxQA4TsDSOkwSwUWODsY+V/rPMPDgtFK5
WV7u6dnZHewpqTvqgvQIIPetb2+cowXBB/Gqb5J8ByLbXOlzGNWkJe8OExX5etIZ
jY8MTzc0MsQxUKAAfQSlSd4c45JLCjMBHiNX9Hx6SjP015niM4h2jtqqdwl+ZnRp
LR1cB9XEe+eG0mlOoDZHSXCU3zJPn+s9Dp7/iBsTzBEZYxcVitFq9oQ/+l/0urbh
tjY2AbumTpTQ8c42WJ4p1DBEY3E8f6Rfev/h3m0f1CyM0zMdeuGodGp80qDlLLf5
uFpgJvlnsjUc+p22vHsl7+P1ZI3HXl++TJtck2UtRbGv2tqUsnn1ttg5tTFx59HU
IZUUQ/OpNa9YkGH3H9Rur8gwpBQ5+CK/VqaC6ofBPYXBPutW5J1phB61TZCiVD5u
sNbT7v0xxWKPKTKXO6EZapYizZGkvx0hsCrN3hjDfDlh2vRkB0NBJ4+72VMOJNx5
0Dk7IM8Ga4AJ+qoN/Ok6Ds5DgAFpaz6gFz0vYW2UfQccAAPl/4+pFeVw4WKNJXcs
rUpiXJpS3y+JsVcRIcKHzcSHbOwRHzjRlGC15gmMizavdKHD0RbZ07pk07Dq+r7i
18N+sSGUAjgwtEpX0Bd/28G3K8BupAO6S2SNvPODvr095/oLfd41/wfZMu1k5GKI
zJ1DGwMBEdGIfwkgZevPP3N9bk4uyQ0cysg/YvD/Bo0tJWokcOcJRXATx1Gw8o7u
6u+y1/YMZgVaT4K4MHjyzbjBjc0n4VhwYpMIqomHDf91fiZKImOGsvtL2X/z22wg
jDvUA/0qp+q3U4h+y5So08a5ezOYViTJ55bjkzRVVSzwJRovxVMa3w/7hlERHo9C
7P06tUwJ587vIF1aeFkdsaGjj5zQ9reyFbOfobqxpVwZN3jtPFfJLIGl3ImMOJVr
a0OkQeFVaQSkWnde4YSJjItK12GYQ8u7I71U+zZd1hKULK85d/3jYWhYakthraVx
zOUCstwnn7II/3ZCky4sY5d3rlB/ntoT0ztSzVdcN3WEvXHM4L1Mfjq33wKw1f9Y
98M4ePkcHb8B5XZAWpP1S2nsgTvqRHBY2pmwg55Vb8ZatlmoYf7tub+Fhucjkcyb
4o4XqcNBP4rtJo0B2j9DR3Q2mkvu6J2UYpQpisKua/0Htool3JEzeZq/vWMhTz0q
f5qImC3yCMIJTCho0ozY9Oq7uXxxfLV3aUErdyMZ0JdwoL1301gWlqmuvrAZKh8r
Sti78jnUdtepn9VuLC8pD9R/ffKTrTVEieGNO3aQCLItUhO1Zxb1T+l9jOTbL+U/
c0ZRJDGHEtMnrBi1A0AjnM2ODacXmdloPqeL6dhNW3bmIITwi3vKyg+NOJeHcUUc
irxuR8lfGa1Oix97LW0ETIcZmgKOQSHEIsLnKqixEOr0V6TPG/bCmgWQ3KOYGEoL
Ywu8ILI+ly6O+/xY0vzXxe1u3IaJ0fiNY4zA0GO6eofAw5atmkUJuOePAL6XSZse
7HORcZCHyS3hiBx4Y0gtI1+GpixIGnABepdaIaM0XHM4rtj3FRbZ7YxZlJCLDqVB
peJ4GdO3fWIzFOhooXgVf8QwPcpzvbMLgs6hPxGPNSnm19CKxwyPWSblGqzfr4bF
vExQMqN4an9Pj6qeX8N7+RwwtbuekiDbtuBC0dny8Yc4cY3ga3DcZg8cYghhO3CB
Wg9D9Mzn5B6s9yog3qi6KoXdQzUFatdECn+ucXwud6nLc0TByICjMdcD1GAI4WKQ
C6LMjsEBIIVxGOWSm8bxqORD9yO2mmfTTdPfv1XwNu3ehwQpAHWbftpqCkAves/h
QyNWki4SpyCn4GPYX60KKiZkB5FBak8hzYjhRXYmjMWt07hOihEeM71p7MWhcIQw
ZR0SkPDix9W5SEGGqBYAUg9EC47nXIBx3cidFQkZPhV+uiELUqIiFsZ3uRvp5+L3
O6TtYBgsANDkHZ/ASI/LTowOMPMLo9S1SOGpT8RnocgSzHGcuO12pXnQbZYiedho
NSTgRa0iaU+zEsMQVPIYSch/zitGqufWtIDIJ0cfQifkJLqlFSzPKez4xTqCfdE3
uMZFWW67uNkM1zs2vOS9lN7f7Pon/rk7cOtE79IHcqL21NlwGmMQRwTKQVUHbSwf
VKaHjZQtHbSWuhNX4w6NdEeWCN674/NmV08bzcE5Y2wWTJOJTMm/hPAVX+DJfeDc
YWkdTnvkJL8ZlQgTrl9AaLeWb+nJU72LVesmCktZbMEmKzgCUPoKInbfJdjJcIl2
fahEsDPmcj/oJe8UJjyA5GeOjW/Yn4pJzxxXa9qesq2oB9Cam/vaQwrmrPOgLaH6
TblLEwlSih1UOhEmnGRW7Tw9yioulOjQye3U+JcCEjm9OX6HB+OZmg8p04s69MTx
0wAQvqxIfsKSRNuf6c8sdR0HQ128OOFW4UDdR+HH30jDy4orypkczzA+1y9J0Ayw
bzHKVSP2ne0606+oixorBCuBhXY7Bm3Y1NbJmwNSSI2dN0LkOTv1P6iu2tyU8ISS
xy6oZ88qJY3hbwtFBOBE302+yAygRIJmvoHTe3qwPQmrzfZ4GafeQlNEf/MdIEKn
t0TwTICLAxasAjE6i5mRCRBd0jB4rKOGX2Dxy4KYVSM7lHX2Psv4jES35cDhIMLv
HzeVkJqsyeoNhSFnFhsXi8Vy2XWOWXLKpVlw2FLN+vGl3oLbTLq/CdMBHU6lZYS7
bRR1y27Ev9N3weuElz3gaQYzoddK9/+keF8rf698hNQUck3NfmNwSUWcyRIoQNI6
l76jZyv/O8yviLr38cWqkP7A7np24bkWLhxb2MFKXagfSxGnzcbAGQbjNnSdFlaX
J1nMJL/mU3Aq92m3wleItYS4rK1YEk+pAcYUDwC/9Om8F/q8cYe2pwcYmo5jl7ub
7DpsTwOf7oudhLxdulL6nbCzTRCuQAe7m4fpuixzqJ44xaCMg9eYywlkZrm5x7+e
5nAkLIJFB1Yd0u9hxmbxfhSQV3ZqZKLwWy6KgptXUtMzjgdW3nBQmCDworJCgihi
eerQUzVuoxoa7l0fiGFccibH0QvNv1us6YU8gh2hn1ErUdlkpOnq9GyWv8JmMzoA
fdMG+f0kq2cH3Z6oUaNiuno2LdGuvZX+jVeorbNES+baIEoE+svdEhR118EUi9rN
/UDFQ3jKBncUZU0apzO+nb266fDj/9C+4mIOforgoNSPlISfb29MkN6e5DCYwiY1
XPTjoDsQkFIXKn8vtUSAdXnvdHUgtDIr6IwP/0xbqYdt7XoeEcz+HOvFDxNQ3vDj
IjltkQgwSzGzNNANyOfjK6+KdkbGjLaiKebmB+rJ38hHPsZav7jW847PS+MIb6wz
gYwQEaaHe4aKVOtbHG6cCbRJgBhjVLTJsqjMcVtwlQU2vaqE2LLEhdLwa28W6OnZ
vcJmDIGHgg5VcFsC6EwUsi9upE08C4J3tj7Kl8jnA/2MpzRu1b8ejxyLqhLKGe/N
WxfzIE4+KVmv1zA+0+RxOv1VprX2ei7O5wc03Jh9zcpv69mG90LrF0KAXVz9UPvi
l4wSaWUAdWp0svYVJNVSfmEvScbqs+pKidzkallVBMUcouPSUYgLbDQm6odCYFYG
2HTM27hOMTEpkFJ35pej9HeuslkXcNHsWXAmN/q315zT+e719cPfd6R1Q+i7q57Z
Y8oPVGvUGIH3c+xttVAL4Owwo9NGc4GmAtUZvI7G0ORBiUOkoETaEAQiqqj4M6E9
lgndue6J63IK0OBRAyakKZ2YBZy6jOJ0r+RdulT9Hl5tY3o0UvtfXChVrvhyF/fQ
+u/LPhrdobm0n1wAbU4ySdnoS027cMZkg+XldN6nWHUab66gzsM9ntpsCG4oG55o
8LbM6JHzSb2DdlITPrrEDRzsEseEhRgCOhOA6wJJUxIXwbPlZyzksHNzN3ArERVi
v+aBZAaUwkZ5+tpf2Q+hzygqcD3WS2EVH4y48tWLgD2v4GirC7Qk96ziRPaGWNp0
1efCvsK6+3yPEZ1r4ETMuC3hBtzevTFPea5npufnJYqR6ifrMlmsRMFlV/vmJtI6
Trh3fluRuEgZ6rc3jY5F6lohCJ7AArFtcsL8c2byArUsT+E7ef634aODEqTKklVu
YONnnQVsWaSb25+XInuP9KKl+IiS5YtNr8jIsLpYrGd7RueDp31+5RbpppDuPu5E
Oq6RJ6ksptJQnXEvAoMRNYF2XC1uZnB1jmO4C6935aKoN/Zw9os7oVif976BretP
W1ebeGqV3Wy3oLu99doWcv97Tlb4Ul+EwGFVOGOqLu1s54RIre8lkJSxC+fuYHvt
cowkeciCw9cKybTmFHc+7jOLxpOTMBWHotl18hPYKZ6ZJCGXAKJVU0h1Z5btZmgl
zJxQrqGXKAFfJgZnRHkEgi22l0olt71dhEZaKHraQa9EOq739axyMtqT/5htOh5Q
QSBwdKyb9rFXx94fIfDipp1CHUcjum7h5P1sHz0oFUouyYNqd/O3/Xx6nPisGbbS
GrZ5YwQpYEUX1nxJtZj0wava5hgX7nLoeCHr/+L0RGEA8DPWmR3+q8Xo/vWzIw1P
tgY5JLr/so6CsMahB8l9fo/VqGrnoEdMKutqKXaZI1EwcrdifIkiruY/W2EhYsqR
5M+TTjLF8J29TQdCYW1KB2849DpLXiDhpQ15Mqv2Fl2XxWi4CZ450ENyaeIlMKVb
je1a1kEO/8yibaUk72SfNTxm6RuJ4pGssurDrnR3ruZoL6Zp9kKwqZGBMxBwi/Oo
USogQcHpODIv1O9cQEBjc7gW6fcVLLOJ3CGp8bvhT/aYTVelS6QVg7BCFA176wQx
uR0prpJkHXSR0vkqOg0f325y6+Ev73OGYgQ+nozvGbphQFD+3EBgiasSdfX8G+dP
2f8No9Zn7S3S8/3wMtunwA8uzJWbDgkzEaRGjo7E6d0l7XbJ7XnqQvXBKoc7tHO5
AMcC0k3O8sHTiSMgiV6CS83RXg3XTj/5mmueoWR3j10YVqHQLhwqyxjdqIENGTRK
F1UFhI9PnbNH0oc/pOIA7iXgVMOB5KvV0KA5XohUqHDo0E3h5XIEBtE697WBPCT5
Wm4j31pEmN2sS/0lsV3xNI1evWxysxVMeUFncQ7IJAgXEZ87ZdgX4pPB+JO/7UqB
yrhVjTm3VN31GupTKGjHyPxX+dA8AYspC+NpI7TveKG2IIKaZffL+UR8ippneJMF
X3KQdW7qeYQS3D7zWHt3+JPsipTRRUQXm5wOXUc431jy0FFTVf9fMHhPT6HsIw5p
2GD9eO6ZOfUSR5Dxdzaa6j7E2DEdPTi93KpearQl6J8t+pLHE7YepSy1aMq4dLdh
KgmMNoN+NnCRBGAnG8QeFmII7ts52nxzb+yuCHcDy/7B8XoeUlrCsVw3VOGk7gPD
zjipmxBuTKnSOkBUFF9+qhriZfqCn6rDL4vi2pYguO8ADFh0/V4fEJY8SON6eb/m
OGCTe61WaYLeTddUxY2HQU0c0ayToAc5lpdJ/GureaBHWGNU/PohS5MGbVoPR3R0
5/gVVFr23UG9isTkGyGPyx/A0TO/m7mpI7cBmn4EDtdsd/FrWMtkDNuF77wSH3zl
NtMhni586lx8lqTKsC0HJPCUjdrnIPfWiciCVLyU76rwohw1TxSDxWGHNSM4R4Gl
R7sOsH3+A/M4fLbaTyqiZw4e3nRkPUFspLye/G/QHCWpzLlp06CaPy96Ll8KNXgT
mF43W4X6KXV2sbX0GDU5fC87+smfsPlRDX02WjR1aPEGgbKLy83BN36G4mm0ULq5
KP+uT1gXa6+ZaRTpfteWP3nz0bbnzMfZJ5KTFRo+XXN2Rs5jZzpH6le855ojgErC
3QrLpHGNnmzkfaHfJikcUf7BNy8du57D4o4XQWbz/ARnEn5L/8hph6S3GS46nFae
yXWMV/Aoe5pkL1uePZKkH/ka0sHY/bPmIqVTOkbxifnXj3Wx/5BHkiCWjeXhqfX5
LGOKXazwexx/qyScM7FSao0a3k8gGiyJNQqC5uy2LoMZMBSQOThCa6guOPavV8Ou
298Vi3awHjsEwSLugM9ctjCgYiHoPva4aIGi+gvIj0bAC6E7byHbiBXY1YYWMMl+
C0MvbvhGIG/fPIfbCAHm13SMm7ox/ZZf99zeOzecRRQQUvmyNGNP3X6C7wt0MfM9
CUquVjY0n0h9AZdeg7tU0OrvdK1Ju/LmRI9y0BtQMkOl54jba3dJvhFZ7FWZWxRp
sor2w9penhezdqFUpD3Xy6Fyblosf7lHcuQOpIkfAU2PSeCGg5Ne1pLsELirMjKt
DSPcg2SMqeepcf7acI1b0I7xrxu2kSwtUDjfqtyBAXwo7S9N64buj/LVTfk8Q5rd
fgVCoTUo5n70hfBN8hIdJ+tu6uLCfiq8Zk8r14GgPkzZddvuugdE6/YRa84QukH1
XgNSaFGIfBfMrLj5fCm1+095O0LQVQNC5W9PvOVTCxDCxFHnr/YJug4Tdp8hEPTO
x4HXP0AoiaC0zizdNYBja5pZOKuwJr6e9ljXTFBXYcdChLMCZ01bxse8WW36xx+N
8qjZDLACYo5lubSuyfpUDef5Buz5onmugX5UzFvUVh0Lo9ZKEIl0+1n8BGJ21cbJ
bJ510WnJNASJ57HFA7l1DpUEZPrJSi47rOrxBAQdN0k+q/9yokefxaBvSV+qn5eP
drEY+kkpXbgOOBKBv5M/DrwTdSRiSRCgI3P1kIeSZqrGkcugVBXvsduTdoKPTzHr
q2/uBGk736TEBAa/Tcq60aVsuhtTkVsgRRUcOSldZvrDJWY/U5INdBmKyK+yQLeP
cwnsBVO8udfTeCiRi65SgNNqINeSL7ZUGow1+2vzf/svQKqbo7spZP0SXdTo6eUK
zZrE9x3ooQ8oF3s0c7irjSohNkjUtEO4FmpXiP8zxQi005u1jozm02QberPyzp3u
9h7RO4gH+Cek8aeMU5fFOmmNFYaQHalQf5Z4Tmthi5Tgx7w8xP68CcoxmIXDmxQF
FjFlbQVPGiuZailbERD199lV2NUG3u4dCMxSnaLgPzZ4/7pvONo63xjgCXmvpvK0
f+1puoi5WpKkZGdnIF8fPhr6kflfC8HXQGTPv7hJc9rJ7xOskQomveo89HL/0h+D
we5QnnURP1E8dfkwP9aLs0MGularQtmuxNAFIQzP1gcfVTqfC5NbdS4AgcGBgwFZ
qlglfj8UTsnz29xKGcTLxTidJVSo8suNEeRkTnXdWbA=
//pragma protect end_data_block
//pragma protect digest_block
CXumAFylK1ONrkgGX7Cp+FejESc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SV
