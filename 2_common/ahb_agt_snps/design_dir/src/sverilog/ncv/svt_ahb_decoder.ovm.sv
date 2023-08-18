
`ifndef GUARD_SVT_AHB_DECODER_UVM_SV
`define GUARD_SVT_AHB_DECODER_UVM_SV

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5O2iJ0XnYO7e68mR9DueltG2QO6nb8bAzoKSoUScTMjLkTDU3a8Q9yUpeJ2K/rOE
xrbUJ/uIY+EOJISHc8Bzk3t52CW7yveB628ir/S7qT7jucJeGW+/CCvrIxbj+BLK
a8g8RgFuf77JDWP/Vy9UrbRtZAo/v4Qw5GsAAdpzRuO4SFpOGDD4Rw==
//pragma protect end_key_block
//pragma protect digest_block
2rnoAat/ZxVfNZ4i2/mFkU+oQHY=
//pragma protect end_digest_block
//pragma protect data_block
nmYORMzUcmoP3xK+6+ekIKcghSv6JlAzMCRyt6IZFSFCPOwp1LU/0tGIreCzqDRC
NpXmtbvSwR6AgzCZ4zzBFB1Dt4NmYlSWdfD7mfbouNmYEmzDwSEDYSztodHsrNeo
vUDkoLTBmUrxcbbO3ue666+Ndl8csyd0HCcY8NC6WMiJbm+jobovUmyz9qLnzDy9
WemhEI/pOMpC736+OJ/UWUH/vDMQ9rkQ6G0XRui1qIxyWmhbi7pQcDi1X0ccKnxv
Cd6Cr4bTf+5HtWMyL/qn17iC6SJEwJri5VlKNrZnj3ZRw7zPJJsOy1CEjmrJ0j+R
3NQAkj3OT+mUnYQZjATyv3/ilHBkC/QfVZ4K3jYnAYOQwKclQMh5JHsm2qHaYhbM
B+T1eGC8N7lWcgWZWvuayvNdzHeX4aB/2dPwaKTsVoVBaFuecztfedR8+J2vjKVb
GjvEttVWdD6JmpokFLRjzdAzvb+AOao/6gJ5DzMOu1FrNkma7i4JdcAqxcPjJW9R
u5SNsdh7JBuitN+T643W/3E15nS6C5cq2WeSV5ZhBRxpqzjlB2oGbUVoXzAWrmFC
pkdzM1IuvBlZrogiuad8xNYqF6csg7WTKWsQVGb91+cwBTWHCw54+z356/W1QZBM
fogll7rLNjqgN/SJ5OKkg+Vr1Gr2y3HSeGNYaidM+HL9EPGtyackAkc8IOyWsAEq
roFSI80xY92LgfC+lsnCf3gRj800xV3c1nM34ZIPRVI=
//pragma protect end_data_block
//pragma protect digest_block
GbWeOi/b3LJU4riCe0s+YAdcMkA=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/** This class implements an AHB DECODER component. */
class svt_ahb_decoder extends svt_component;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EqWU6EwITPxNg2Nf0lKrrexJsWwCccIVcCxjP3uKxUoVFOQGDrV8cgk8+9RAgr+U
MgY05a+M/rLHnC7F1nyWon17DFD7LDemhmPZGonKV5I2WZBKUGrl5OPjz5pIr06p
F/12bVwiWaLuv/Jq4z7p9OZywlckXAGxL4i6BgulzD9fh49tu9qHWA==
//pragma protect end_key_block
//pragma protect digest_block
a2lHBeg5I7Zf8EGu5pC01ggs0aI=
//pragma protect end_digest_block
//pragma protect data_block
zkY0ANmd2bp7n72PBw0xiEElVL2/LteuG2doQZtUqoTaHVY0oTCN+ytCbuSaa3HE
3Ftrou5ssj+je2NRb7frJfDXeNQrEeG+LyCKaX8N2l1q73GIB5wMgEiUhP1EhYrH
5oM/zM7XQmcIUWbu44zll4Q9IJ1Vx2UgZ9M9X7pSjWwhWjFG/hZuENCd8M0+q3Y1
JpngpMBemZzgDpkTLV2jpBxT6Unk/JxADBTg9QG+WM+BMWMJC5BklSIGX/tPTMLI
MTF98vU1MhO67KlzMjihidgeuv3vu0cVFbboeII1AHityG4EfewDSlwyD8MSa+0q
PGwz7o6l7Nzr/s8aT/DedWCZx2z1VZi/M3DFccaQc4YXcCagfyDXd/JEOXKVFy/f
+8yv6Vqf9QRrbiTV2E8DH+yuvJuUJbezFwj25MltbIPsvsZ5ms0/iCoACiAWRrx+
kJfe/9pAAygzPTUyQ+nko4DAK4rcX7GkhL5Q/ga1pA4iECtJhMTDRdq3vu7A9yQA

//pragma protect end_data_block
//pragma protect digest_block
91JV28J6/lu8HRsV1KzqFkDwi/0=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of DECODER components */
  protected svt_ahb_decoder_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_bus_configuration cfg;

  /** Transaction counter */
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JoJi+dBhXHkH+4u9m87x8/HNpSJ03Qj1bnJo+S6UJXtX82ygIi1mYEDGMJvgUrAa
LwOHQY0j7lVg86pDPbNNE8nHkCqM/T8ttjtyAtoxjvALZa0KjYHnYiiNq5nunBlV
tfJMo8GuKF88uMnmCD7qJZ+8PAjFoX9U9soi3UmyKdKomd194bjhww==
//pragma protect end_key_block
//pragma protect digest_block
Jt080hVYhMB9HQO8gGSPlxt9fuY=
//pragma protect end_digest_block
//pragma protect data_block
DqvPYLRSm9YqyJt9QP3pl3e79U9GDV4oKFFtEyr3rxgw5p4IStCsBB0O5F3fgiNB
gyndocnmaw/w459uU3Wa+MLyOYuwFEBSyB8/WFWiEK15d8UXHxhLIkJSHwQleizK
KaNkJd20zYokVSuM3rId75b1Qb5ja2oHFguhiFoJXEzqh6bjhbjp3i9kpWJdJhqa
YEw7eT1zGR1hFG4UAnV0FbZrESUoL2ptn0bab6096GfaSQ1uqieGCIN8WVe9BKIM
tn++RuF/pLtZe/6OeRHWL4zoIHWjKirZ/nndT0mwwnZhygJpzDAE11GqRbda9+rs
C0Af5+95hqE/ztPEKeTdTG/Pxt68bYnBk+vYZEzExrHlcrN/qAG2yMU1amaQxJd9
x0bW7g7rSCza3eZfoQy9MNbd/VRs7rU9TUv5xJG9TeS4HUsU0N+qmStxRyP4CiBo

//pragma protect end_data_block
//pragma protect digest_block
uMPrqJivTtcjtHqwVaiKxNVLe+k=
//pragma protect end_digest_block
//pragma protect end_protected
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_decoder)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
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

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------


  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_decoder_common common);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
W6cwgGmeFB3UTg/28Z3pzkFELYCN+AD61+t/MxqEm6eblF/4ED1LX0uVYTW1cROP
9BE84Ym5ZFudwU9xnsjEAC8vMx5rOZkwuyavw5s+lSCkaKERu03MB1jTivHzIvMn
hUdOzaA29brkX1X69kbSu8K7BnX1Lrr56fneqfDRh9qdalSBrbvkuQ==
//pragma protect end_key_block
//pragma protect digest_block
3uG625znOJx1uPbXwb7mHrRnIxI=
//pragma protect end_digest_block
//pragma protect data_block
zqSlQtGVlkXA6X7iPeX3b3rdmbTO+obdGXarsQyG7zz5zxDArnNBtSk1VrRXyqFD
GcXFo8c3FvumZsWqJbgQTMw94HY6qnCGWtWvSgMsdL075fyOjI4qL+7lVsZI+mn9
GXtxKDgOG392xHP64NWb+f45mt4JrgNSiMauNjPbdxkAkd1rUdxTd9jnCIG6NTDE
57lyJ7Q+hXF6068BqmchKWwGvWx7UegzjDLJ14SgIo9UW9dKe7zSFghugqFoakoO
la+7UAo5Es16l0J0o9l/0FWnjvgIdfFmC11ZMtYSs3w8a9Elj7V4Mxr+m6en3QZO
FKuYUm7aHpkAxGAv8Cr9hjfsKwo3iYdd6XALv26S4v0sIP6k7LBd/rar21B2vMbJ

//pragma protect end_data_block
//pragma protect digest_block
RUNRZjhTj9lLT6E3lX32mLKuSeA=
//pragma protect end_digest_block
//pragma protect end_protected

/** @endcond */

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8AvxBNtB3FH/tmx3OPq2h2nOFIXiOfByUyrrlmx7y1tx9Rauqc7tqTcJUE6ue259
i741etHzSJrhe8RG3hX3vzHb78j75DI5TZEVm0c0844Dh9HouN/YDOY3oTUMFIIN
f63nU3qW5i4kuWpAZWyEV1B0iK5wUgmbJFu8Q46DQODA47JL4UEE7A==
//pragma protect end_key_block
//pragma protect digest_block
Vwwidwh4Wxr6wZIXDFz26PfDVJ0=
//pragma protect end_digest_block
//pragma protect data_block
+dJDxtHI2W3p0FTUEk9YBIuTMIGb0FKmQOV6qwI9PyxEitaLLsdJx1+Uavgla7UT
uT6LYUe9bSMSm6vBlLSh+0+h5HyC6X3xXtQzw/wcTsaklpzCouGxEUODm70I/L69
DHLUC2qSUfqfDE3PoyOfS2smAHT6HeMoy6k65Gih727G+nG1iSWq6DuV0ntmAotl
Tsi5d718UHl8a+aFi8ll5CAE8CTpRmuSEtAtfbRgaJADwgiszLm/ju2dPVaTGGvN
aQqhib4jzPJPfwC4RYRCkS3kEkTQo3RRX7NaSdo/Up2NFnWtwQYF2xxXdz8IPsQf
GN4TPXLBRG+Il89f4edIXa+MnuF+sYs31DBw7pvfrjxig/4VKcO3fA7bwSdca8EW
shMFAIwK23Omdp68UtjHfrMg2h+CPEhr/fllgVPbJRUt4aj14YTzlk/8o712S/xA
ion06V/bryLy2q6E3TM1AQnhtiDeVP8G2YlBWgryFNkwgbuLyzsDX7HE+RvgrYcX
u5ajH/1SiDCTvRS8G/2uWiFoikE6gpKOScMm6L+01q+u8vbv+uc7G0fSJst6Odmt
y5v8GbHeLME5AGFEfpHkd92lh9BKRJmdqV2xVavgwRo8ClO4b0LjUUaNwg0AJkQ+
rmpNaMDiu/mKkYuQMEyIEDm4BVfXXC2gJmYyWdeoAKxgxHC374Tdnj1dp0jz3kYc
rHM0mlNg42pDbYVcTIn7bC+rmFhsW4JMK8iiramKfRh2IWc2kss/0EkLI0DK0DHK
hSX5d/Y/fBSvzj/pUjyFTqgOx2wWhlvlhvn3GIG/IKRPD1MPEnqtguqYelNAXK8q
oVYQdOOyDvzMsRgZeUlnkg==
//pragma protect end_data_block
//pragma protect digest_block
mIfbp23ZxcWT9qoz12LE/nQRXjw=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xTY2c58gsxV1Lg7nTj86RK112ZW9l3ZcycHAHofcgcQDdd0pkAQgOo2DkFu05M2o
Hv/wRV1Q25oJprqbjCVyRJXJt2Xp4YPWWVA7IbTCzpR46cWxwO7cfuuMe5hdDwZT
Ma22aZ00jPqFE336MY3wDrKGZRM1yYeQbEGNj+I6roOJbxWJ8CjW1w==
//pragma protect end_key_block
//pragma protect digest_block
AwAFQCTuc0oBFC9CPXLKdRUZ8h0=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
9w5wd5nmbq8XkSLEFjJ/KxtZV8k=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hHddE9SJSIh9JFCej5eiaTpU0X06BUGMuOKeCk8+FtGRVD5v+qT24NbMoOGUT2hX
YrRe8m+8sRumAqH5k9KUyzVQJsqHhUDgOX/e9sdwhaFgMqk4iRT1lTinw1JAVyd2
4n3fNzRHSoofLVAOVmmEnrTs2SWJlXu3WZqKRwLtOtpeCvZ8FPD9Mg==
//pragma protect end_key_block
//pragma protect digest_block
p3Z3MVm9YQfz/JDnENbf3ucDjiI=
//pragma protect end_digest_block
//pragma protect data_block
y9O+U0cW2PIXIThT9QIU5UuZLHH+2oslQx3Ud18dPvhz3gdFojJMk07lx9zCeqhe
Ni6D8kp+ZOztpVlTiYXgsHb7kIda4HsRX7knU3A93ycNhMM4qQ5jjiVwQ4y++s3m
lR50CF+HAAjdnV+IONmsBSZM51N1u1Fm/xppZdlzMpZUtNZe/8nbU2LJC2eHtx+6
pIvMOSm3GOJCfOpxHi5rUSSAfPeJL2Qzuf6Xdck3qHMfgQ2QHY4GMV0j7CCmSgCK
5feCRYSaVem42LxZ62cfBhJLgXRjZHUZOK3q7I3L/E06/UAfQq5JzZi/A8PZeROe
t9VSzO7TwrbvrMNaPPu3U9jveR/0ybHvmX5ekHj8LIMM+dvbccbdC1k0ZEREnHEo
htaQL6bwFC7fqPo5bxtF3g==
//pragma protect end_data_block
//pragma protect digest_block
w7CFkUuqJGKJawRUCRumfiAiFGY=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2xDjxT4CIYKUnoZI2ngktJ8QU14Slt0B//rpDv0xPuXPrAMu1SADqJe4TOm9QrTx
otKfjyJ0r5bVf8u6Yxg+2ZmfOZfAZIAkvKfhknWzfp16+1VSB/06iN3ffGaiO5MH
iwp4Les0F3abj9jbpTg6DDHMsns5MQcYVHKOA0ABsRkInXaMWkYcZQ==
//pragma protect end_key_block
//pragma protect digest_block
t9W/2wOt3ZT9xqUquo5lQC330Mw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
TIn67fTcnwDkmCRqbMLDepDSA4I=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kt9r1oayz49+tLNrgx84hsMgaDZWWgbSuxTXCAo+3coClBHNB8lgqARiAS23L/d4
Eg/IwXeAWybiQI45Kqwfp3W9GDvlqFeinltpBQ7966qCp80d6wkjZ9DTXfezXsui
nR13mXXBJAG0PqCEsvI+aUwLK0EQfhcqSF7r1RtNQp1lFpTeLMdhqA==
//pragma protect end_key_block
//pragma protect digest_block
0vefR8wHrog1y4x2DKwdKjFYcK8=
//pragma protect end_digest_block
//pragma protect data_block
vRwGGd4pfULvDHWtUvlEppQyLXQdt1lvFFxRC9CfkXqNjsIbvZNoFY8i1itbg9KI
Zns9qF79yER4vP7JX9y1x+nHEHnwdne3qPzFq3+taYx9o+P4MbXyv16Pq726rqyV
ruGxkEaGi5MFtxq0AuOAL9BbvUFwb5F+acT5KWwqesB1zcyifVsN7N4dZP+qjNkF
BugsnI2i/PPqJmakPLz6eFAd9V6bcD7eRoMOUpVessJLTh/+djMH3mJIGyu133nC
2tqlO7UGfq4JXgtrUzpma1zgfTsyFmUnQwPmQcPY8rBrDVEx/9funnE532O2uBV2
Y8jFZlxdqaDfLtzVO4dSK0Cj/L8NZXjfdZQpjqbfUC0ENsJ0ZUzUTkuDlKRTsaaB
DRqCQuvmQGoGJX+7lyds3w==
//pragma protect end_data_block
//pragma protect digest_block
bpxWRqrpe4nT02v6WwIbszaBagw=
//pragma protect end_digest_block
//pragma protect end_protected



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
x2heiHYthYE3KTE5UuXsH4SsUj/JYk4sxb0lg3rjz+9kbHYC+2zYQbYNOGoz+4YS
sWZRDGVzuSrjsX6g/1rolBHagh9ouTT44/tpsvHc9YPjJHbfpCT8bSK/YjnjngNR
D3S5iiiM2I+nACEylU7+Lv9/bPFifz/0CjLOqz3DXJUSXQjFNnu8vQ==
//pragma protect end_key_block
//pragma protect digest_block
3gqLx52hZ0T30yl+gZ3qCeVF86A=
//pragma protect end_digest_block
//pragma protect data_block
kV3gHmaJtAHphUOmCth89uQYQ2OV+0Ag3euO4/3BV2k5GgKYYO7v1LMWBdRAiSjM
beJGpHOSYXtpdWLtQWVO/uuVOEXMPSWVoHx4gmf4l5MWsvGALQFaiilIQMQ+CJzk
NF+uII8uqj1myFGoI1LybieJO4yywVhQsC1SuSeKokru27QQiwo6MErcwXWxysnm
0YieocR7MtyyNS9NLmjt2Cm2l25dzlA0WL7OsJfsp1IqKs9AL0HANXungcGaxRNu
O89DRA5gFjONbfz8rSfCmPcZ9hlhuxPZb9y8CzlG5zcFedmVG/zloYJlxwk0nmnH
AXCIwW/mEwjQrUOsKz6SH9GuVKp46zXnAPizN8rrv7bQw43fPXXs9POYhEewK9iX
kkJZ32/KIcZ8b01iVg44qqxFs4nUjDUrxvjCXssNKha8c9Ea6rybt90IzLLHewg/
1gRFQ2GWH3iaAWUvSLAn/DGFd7rJnxTnkLMd/aM3gVVZTKkmgdxsWg7DSJ1JOeSd
lf95jImMnO2mctsR8dgs2w==
//pragma protect end_data_block
//pragma protect digest_block
Kw0K+NCRyhhlrdKqjKBsQSo3J8M=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jhtRvybhAa5UCxykhrQ3a56xhU07w3rP6nLN77XiA3hPVlf9ZiFHgRymmjX6cPxj
7i3829pT0972RtsUuDuoduxQg/C3Uo/Wf2qaaRJMoENUAO8XCYFPHm7ZwCDnfHlR
3kPfTtxh8vVdq63EdcqBksEDHb58OnpSP5+ZFNVGVsk8rDzC4a/2jA==
//pragma protect end_key_block
//pragma protect digest_block
3/lAmjJMDKGJo8Dha+E9WbdZpgM=
//pragma protect end_digest_block
//pragma protect data_block
bglLdnO/IR/UMqmUuR0WjziTdxyievyrWondwAiox0aOs1C4zj87tuUGL7u3Ala5
mx+sP3drIJt9CQywyIneHlq1/heXmzmBDd5uQSb0m7ICHYR3NrJukH7JFxGf4Dp0
GS7wui2rihiurwK3bEV5tzgDcMO0hU9JMRck/h6s2sDrdi3Bk0c+xckTh+8x9CNQ
BHCXpq9rKpT3+8MzaI37BbsciIaIUI+p0Rurwtp/dkZ7bCZ1UyrgXYmOq5jstxl0
voIDrJc7nKhduom2yLjYylAed+e7NcQH8ETv/2yKFPktLObfPipHc0Bkzc789UMd
1V7bkt6RHQOe+vw6mtNk0g+eu7hq2jozYfMVyRWFhR2tSvdDp01VnPU/qbNvs6mf
AHBIr8Piv1zuWRsQfStPdA==
//pragma protect end_data_block
//pragma protect digest_block
O7/3AZt52PRhXxH6xyACVkJ/E5g=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YBPaErit/0dz754vn7cpisg2hXUmNCKQMTT9rddoE9+wOxkrWk/9DsYq65zkGkOi
IjTuSDyqD6GZyTUmJmxHd5CFz9Qvo5C3JIZfD+GSJbb8twcUOpQIPGlyL20NZBA3
Xt3DZnINGufMGCCHIS33L5SZO7ZlO2e90rYByBJLLOaFSA4W3dOt5g==
//pragma protect end_key_block
//pragma protect digest_block
TzPKDkVgd3bjKoEHMJpOr2CBp+c=
//pragma protect end_digest_block
//pragma protect data_block
cubVKh3NRp28wOjZWb6K9c6Wl5MLdLTJhXHmT/3EVoB1S487DQGGCDnbyVUei+vU
4VEuG+tnIis0L/gvEpvssD4zhOFq0L9riyv2d/w/MlngJnyMd6sf3I5rg843VLIe
HQt1jiR658DDzyqECnWECWsVmPBnhYKv6FAzyQUX6wcZWx7MPWgtyaUPnjtbt7N+
q5unweVL+r6jQ0U8sttEdI7EH3yeDGZ7QBOftOtNZojeARI0lUKftNBJ1eVhHl+p
TUyHT/q8QDdYhk8dpEnUvQDha+spHeQ0N02N72hXoN6U533EfeiB/LHokBKcQ9JT
NexPP0xJf2eCpP7Vg3VmTnnW3/EieWfDsI10TnNNm5ZMndUYK3miOQnkq0hzKB2g
vpOYGE5MemUGLOEluSABNQ==
//pragma protect end_data_block
//pragma protect digest_block
no+t6lONY6HTOxJUKjlV8MNJh3I=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
j5HkjKngN15PJQh2JCK16Og9HsZIWveixcs6yrcQxqj+dGXncF4CxkX8SrucgmW/
nmkWE7Md+ykrW3A7aWCijQ9u9poJQAjIz6b1YlM86RR2AmXDRLH76LyGnz23nVmU
fh2SnlbKF2ZqOC9iLGoAI7VW3xW+rT/DPek3Z3SoFLBkVZ4o5/Qhng==
//pragma protect end_key_block
//pragma protect digest_block
CyhrIk0Tm0bNKLm0CQIlRbe+rUE=
//pragma protect end_digest_block
//pragma protect data_block
z2Gn7h6th0wKUFWXGQH/XWc2nvRZElZmb/dw9/Omb0kXjjpWsEhRcnqSwJtGhzXW
vW/ZRAGvq9alPGhhjukoDMp0QdkhzgeyXSdG7ua+d90ldBnrlbIYLok9BLOGaCGn
a777nG4FpHpwy3zT01gr9WyqNgAJUpUy+WxAaaHYxJPS3kyT3a0UkDUt36YE1ett
JEbUzYfw9pnSzj2UohKUVQOk3cMtJuCTOds9egcj0m0+/snmHzX45UZ2PRHVcuee
W2eh/OfJvmqnnfHVw/CfcUll20v3AvNsj16M5q5ECeWJ6EYpSHUHNANlAlb9jbe6
Z1fuk+IIyInEUs3rVZo7RU3atZDNAEjRV0y8+UIBP3Qtm8bihTDNh1pEE5Q3yQPU

//pragma protect end_data_block
//pragma protect digest_block
o2YG3VS9V2T2HJmBsN8VdhnUJBs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_DECODER_UVM_SV





