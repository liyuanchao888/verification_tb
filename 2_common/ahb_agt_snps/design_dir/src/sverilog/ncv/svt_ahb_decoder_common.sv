
`ifndef GUARD_SVT_AHB_DECODER_COMMON_SV
`define GUARD_SVT_AHB_DECODER_COMMON_SV

`include "svt_ahb_defines.svi"

typedef class svt_ahb_decoder;
typedef class svt_ahb_system_env;

/** @cond PRIVATE */
  
class svt_ahb_decoder_common;

`ifndef __SVDOC__
  typedef virtual svt_ahb_if.svt_ahb_bus_modport AHB_IF_BUS_MP;
  typedef virtual svt_ahb_if.svt_ahb_debug_modport AHB_IF_BUS_DBG_MP;
  typedef virtual svt_ahb_if.svt_ahb_monitor_modport AHB_IF_BUS_MON_MP;
  typedef virtual svt_ahb_master_if.svt_ahb_bus_modport AHB_MASTER_IF_BUS_MP;
  typedef virtual svt_ahb_slave_if.svt_ahb_bus_modport AHB_SLAVE_IF_BUS_MP;
  protected AHB_IF_BUS_MP ahb_if_bus_mp;
  protected AHB_IF_BUS_DBG_MP ahb_if_bus_dbg_mp;
  protected AHB_IF_BUS_MON_MP ahb_if_bus_mon_mp;
  protected AHB_MASTER_IF_BUS_MP master_if_bus_mp[*];
  protected AHB_SLAVE_IF_BUS_MP slave_if_bus_mp[*];
`endif  
  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_decoder decoder;
  

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
//  svt_ahb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Flag which indicats that the address phase is active.
   */
  protected bit address_phase_active = 0;

  /**
   * Flag which indicats that the data phase is active.
   */
  protected bit data_phase_active;

  /** Event that is triggered when the reset event is detected */
  protected event reset_asserted;

  /** Flag that indicates that a reset condition is currently asserted. */
  protected bit reset_active = 1;

  /** Flag that indicates that at least one reset event has been observed. */
  protected bit first_reset_observed = 0;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
q5Tfro6FfD8jMDWagYyRai6GBKvStqzillECYG5HIlsuB2ye4e/AbHb9CeyDrYn3
TWOCCKnf+WYhQYwwG04VUf81DpbGxaPYEsXikeAZACLavFAuGnqK77lVdTXvOiiR
NUKjvYrHQVXy/MASSy3wZVvTOZeFnBTYRP8/O7txrlpu3kNm8TYmpA==
//pragma protect end_key_block
//pragma protect digest_block
+G0vjloDTx84oBB5bj7yZKUXhk0=
//pragma protect end_digest_block
//pragma protect data_block
rBfmVs7YMUvqQc3Ulncgne7ZQJs0GFgjGA3NbbVSBePz3gDpzO2yF2FHMwCNIiWO
fMziNULO/yZdOUMQgt6FRu0LZ7qUkpVG+1E8oBC2em3ErxDFpATmSbMynCZEM8Wg
5TxPybzeIqmkrx5PatVL61n68CclmiBDHR1SZ9dyoZDgjPKJMcB7aG0e69umXBLm
HES1Ypc2VxOtVUudCjR7klcfhtt31tf7NivHmWRE4Q91h/wj+2TBBpi8i7Y7aBnm
xDf5gyI1IN/y7jLhQn5nBcKDzS1zYe7eHbSnGKgk4YoFtNCmUY2K9YzgYilYtSAz
mEvSV9q8lg4xU6AePAyclLV7/4+B2p6CvU0Si/OIXq0CuNrOi37lamR27uzh7drY

//pragma protect end_data_block
//pragma protect digest_block
n/tWlCbnVK633UUQVN6cQiostBI=
//pragma protect end_digest_block
//pragma protect end_protected
  /** Flag that indicates that the dummy master is granted */
  protected bit default_slave_selected = 0;

  protected bit activate_default_slave = 0;
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IMUv5Ubuk/U3N5aocjVh/g2Wb2/sga1HCNtZU8pP1Ca3phicukuy0/VqDAUAS0Tq
fjcS7KpJKfr0ql0D4xF4Qt03weRqnwwZFwQP7OjPjv+PeOJHwtpTHprz8Z1v4DUX
wrqEb2yyn4m/ML0+Q56lwzBly5uqfGVm8zHHkAGV4b7k68YpiCcZpg==
//pragma protect end_key_block
//pragma protect digest_block
QNxKjBnsaOwzZVqCiJcOQjKdOJM=
//pragma protect end_digest_block
//pragma protect data_block
YrBFNHjNPaog127egs7MtIAz9gKumbUBz7y1hX1E3DT9XRCv+lmOAJf6RgKwq8VB
bfWhKTAI5c9WlsA6qlYBNX3RUMhYYX1GIY9KIyIoeIgNIKvj1Op/S7hNZHKeBuLX
21g8u7bqkCf8aqttd71seDi5N+ojpP6LiVrU9V7fYWINJ0INY11kTwhMRhnkvzyz
aRqjtivjk7wJvl1gqy7EW7gwXglFZ9VGkSV2jFsfkZg3o6nyn7ZZ1HDrK/e9tYIP
5M0kEf0fLVT9qVyJeei3ChXKzS/UUTEch21FSPdgdbV+zPUz0BnRpyMPTCJZldUX
JoY3XX5pyXvZ0XbibW54tRHKFSuegWAxN1Z7ThZUXodZ19pMKQQRarh0ztap5zUl

//pragma protect end_data_block
//pragma protect digest_block
3oYWeYFVqE8tIZJ1o5AvMuoYmRE=
//pragma protect end_digest_block
//pragma protect end_protected
  /** Get the address range index matched in the address range map */
  protected int addr_range_matched = -1;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6IendGP6vvCQoKa+q/aOVqytikP2X8QbWg31Tt71vYKdq7h5gfw7qSN2zVLLLbb8
jeXuoqWPsBzg6NbkPimgqsrF+pxjn0NqgzpPDZFXRwk+JFCBvya/DKNgZZM/AQCv
t7IIqkFUeEtY/YABQDVlvyvzwaDnYSfuRhmzucn7wbUTb2BCL9A6OA==
//pragma protect end_key_block
//pragma protect digest_block
xoQpUzaXAIuJCL4PWjmDrH3vAks=
//pragma protect end_digest_block
//pragma protect data_block
pfws9OpUnLJCd+oBGVUYmrM1FXSw+ZsHmajVBtwl7hV91IaswNuq9Kqd5zdp9ag4
v+LHX24t6fzB4bzlEDk5sSUd22NiXNFqrzo/bmdpispY9HlIIEeq6w25qtc6S/gG
pzKFkuOdrZzHKMxmm4JCWFhq7lD7yQBSBfMk1W/IhYpSmUBth0hmFST7nfZgF1gG
rEAr/wRzM1l573RzZEJml0XfbL0tOe9vZb3Xx/HbddyX7AOMVHHC6oBO2YjyPuct
q4FK4v9ptanZO/aoKzUNxRsY+JRsxgMKDIrNuJBLGnowVLP+7RXRGw+V8FdAcNKi
Ck9NeSbuUtgCcyuOCdneAc+lEPOv2g9ghrPBr+wtTeOptt5BM9E0aPJbLudIR/uc

//pragma protect end_data_block
//pragma protect digest_block
BIOu7q94TpBizKGTvvVlC7Iyjjc=
//pragma protect end_digest_block
//pragma protect end_protected
  /** Current address range is part of register space or not */
  protected bit register_address_space_selected = 0;
  
  /** Controls response muxing */
  protected bit continue_response_muxing = 0;

  /** Event for slave selection */
  protected event slave_selected;

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************
  /** Configuration */
  local svt_ahb_bus_configuration bus_cfg;
  
  /** BUS info */
  local svt_ahb_bus_status bus_status;
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_ahb_bus_configuration cfg, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter report object used for messaging
   */
  extern function new (svt_ahb_bus_configuration cfg, `SVT_XVM(report_object) reporter, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the reset signal */
  extern virtual task sample_common_phase_signals(); 
  
  /**
   * Method that is called when reset is detected to allow components to clean up
   * internal flags.
   */
  extern virtual task update_on_reset();

  /** Method that implements dummy master functionality */
  extern virtual task select_default_slave();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Drive default values to control signals */
  extern virtual task drive_default_control_values();

  /** Drive default values to data signals */
  extern virtual task drive_default_data_values();

  /** Slave selection logic: address decoding*/
  extern virtual task select_slave();

  /** Check validity of address, control info */
  extern virtual task check_validity_of_addr_ctrl_info();

  /** Identify Response mux select line */
  extern virtual task identify_response_mux_slave_index();
  
  /** Pass on response from selected slave to all masters */
  extern virtual task multiplex_response_info_to_masters();

  /** Pass on read data from selected slave to all masters */
  extern virtual task multiplex_read_data_to_masters();
    
  /** Drive write data to all slaves */
  extern virtual task drive_read_data(logic [1023:0] read_data);  
endclass


//----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ksMqTuKgpWcmVmSLoX7kHNHevH7xBHuvybMe/SPWpXwvWSoqoqxrvte510S7/CfN
JeZQtmD//Me4ShIZwWbpukv5KXpIjdoBdUaJLF62syXXaulpu2AwoCgJdpK5USV4
FxFMF9cKxRL+gUefpi/XGIExIFC6tmx5B0Yt4LayhszokzNfCMh0Ag==
//pragma protect end_key_block
//pragma protect digest_block
p7BvzZqz9CiFMsnESiJ1T7ADbic=
//pragma protect end_digest_block
//pragma protect data_block
vwo5v9YWT4/DTorGI/XyUt/txQYk+TmvuKc7YauR996JTrkUT6ZdaClxYq4BBY8a
c8O/ChMX5znSQuTSCrzEZCWnp95nWrk8j3Zq8YBZkoCmOdX+7+98RbJg7mpWWWe2
Z416XSygza4434QKbyDVSC/2hdmbRe3ZUOgA2U4Ux66Gqs670lKUhuUeIWo1EOS9
JMnS0lfZP3QodbmjKN70Iss0FFbJ1GiwvKFRZusPm+iOnGiYkYVF+SWWobidJ1KN
EE17+15Sk4Qs3dheYexI+PwZzxxGCdf5XxOxaE0RGdCLR73Fu7gi51Y9uDX2XooI
Sk68QQmsE3+VUFf6jCIw3MzFsLG9p2Rj857UhmFDT+QK4ZMlzVqc/AvotEPM21c5
hdFUqz7tly2DmcTFkmk/+ZHoTcdHjU3+0w0TDN9k7ghAgoJGl3NKZmADcylWpvat
kCpgTDo8lqvjyFC3nVKitQysLa49t+VBF+7ozW5rEDDpS2SYPluAt7KYdHYXi3eQ
rbTujKQj7KWIviOqJryXpzzBv+RdWUcjjwRzWhXeI8OsUicvM6EcXVqoCtPAfOTt
0ewGTHpcS2pX4rE8vjlYD0xeSru/kzL7ieO7XCFIWkc8ueddE6CTc4Z5wC/JOagz
mypKmXQb3vvuKPn/6Dh5FZeuCIOoWaBW6U5Wd1T2jefyR1m5D0PLdoAu1o2E+6aB
URHFidxgS57iq0eJiIE1PcCz/xZXjVQDHUWIWTprAx/vs5Hf6rJsVHrr/gd1zVZQ
aAKp3SodAT4zlhJfpNuGIawHuOfBc7qx3ABvh13iJYQIZVyFPBLoyH84JbXtHKKM
lLwWgUTKI278TJyMKuCAbcFtvx5H1/PXZfHDoCuAjcdo4on6M2YJI07zsgIS1RRO
97SRmbzuILpKZPabMg7aw3Gcs0Juuxvp5pxWKevE28c1bGwFk+2o7eWzUrkQtj+s
1DR+BtPeXcWy1SKetDy/CbWtCi/oe/CJE/PuQjhUyx8=
//pragma protect end_data_block
//pragma protect digest_block
zpqK7zgOpoxh3ZUr7/094GOnwg4=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/SOORFmEy+YcUtReiU6H7kyvpQhxBRRCRqBgplGoJd0srLNmrzNJ3rBFaiRQqkJa
ltF3GjtNdxQrgT7EFJ0fXcgcV8dpj9c0/QFw4aP7citzCWbbFQgKw7XAVwFfyQDo
hhzjybfQ2YdTc0BwWdmxN7m/44PRD4nFIKznJDasxenKAxZUJPNKVQ==
//pragma protect end_key_block
//pragma protect digest_block
X4a/rzgMf1X5l0UAmA92+WNqEpw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
P4bSavtcsassXj3O7cgZEUj7PCw=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lm+1n9hjpjS2fRkEPB7lQaVZumpNNjb6hbu7GZnoMLf4r3TE7/RQRpiFAnkHjb4X
dOXGOUZBz6sbip9r5l/2tUhFWZHWj+0MvZ94O2wBOSCzEtdn1VmirXN6SIi5PeYV
RdUtyMBY2OGpGc3hYvOEyiuVvX7J0MrOy2V4JsDybJuGZ0lpF7wY4A==
//pragma protect end_key_block
//pragma protect digest_block
5f5495Y7u/U7owe25LIZA94jADo=
//pragma protect end_digest_block
//pragma protect data_block
Bw2MAjb8BAGP0SQJkbRkuVI3CcAfDiT4EcDZWV5wdXbvZHdhrsThc8UKki7gZVvb
w8/etLmTQHR+jmTy8YzpDFckf1wRducwCz0yzx0zscTF8mjNJo9JrWcsFlV6hmio
+ofHYuLauFPvIvZfwg7B4OOzz1dtN1NkpaMwgKcxA13cTobFaAOMjeYYu8MliKWa
sgVmaqZXFxJCAPPe47F1OdOmdr6tdvDC3zFyZy/MrK3euSLO/b+4ClMVDVissm0b
8cG8FQL4lSJtWZWeikjzgvJJWTF39+KAbfFe4IdrJ8a5vBLnIhPr89GOMIuD1e/3
mLaYQmNuaFVA8gDc8QffrTaEtUq0tpMWYEWRjsBPsVDoyl2U38TC8wai1fXkFxIJ
C2/zbPIrzNS1DKZE/ZcWjtMZpsFOTb9e6/qGAhSqzx6o4W5qdRd1RX02KFTiV3dS

//pragma protect end_data_block
//pragma protect digest_block
6k/s0pYc669CFIcAkiZNiDzHtTc=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1HrulwQOdir7N9a9kyyriRPw4ZGiZQMpy/4O1OV4DTsfcDKs24dV+GpbPGrDZN7B
zbIPTzXl57TM3AzyzFMYfDC2h4oSHeEnpgKC68aP+5XDSXSSNaOARuH1cikJ1uW3
/qG3z7mV4sLH2zz7w1KKWcOwuEb8bYqHv1Sb+WukxvfoQRV3kziHxA==
//pragma protect end_key_block
//pragma protect digest_block
RaGGowYqwjvziEuuDsn/2UtS7bI=
//pragma protect end_digest_block
//pragma protect data_block
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
wd+7qk1HFj8OvTQxJJWMIA==
//pragma protect end_data_block
//pragma protect digest_block
Fw/OBXoFVTNPpVEAH2MP9geYfMo=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JfFzgDgYxAUMj73N9gVgZkUbCVZVUGZAOxPB3dQh5OvYeLHDkqplI7jodcBQX3/o
KOHbF+taFcUYc4C5vARaL18PD7eJNqXSZWd2rV3m9Jw+zbmlJCK42d8RAGS9hb9S
8+Aspm55nMyXeA8mhOJ6f7E3tXyfQ731sldWSC3n71T38W5X4Q47jQ==
//pragma protect end_key_block
//pragma protect digest_block
VeTh2MKgnqm6skxildMOcjnWP2Q=
//pragma protect end_digest_block
//pragma protect data_block
qrQvmHNJCxGIVmqNiLUYaIiyIojZJQIuzgB8dTOYSiTIC4xr/MAGL/YQZxwA+yZw
s4wl7e+WNBBxTqWd8oze3LEsCqMvdeskjpq0hoNReU816M5/NnT0kcG52cEEf16+
uKV8LL4r9x+hDff6L+Bsl9tPKq31Xy4sSxxZ8MKnSEyw7XeIIJAvZZoQk98h+O7M
rNO8SVtIv9svap9Njbe5GXwdjR++w2zACv3QRPoIQV85kC2qyd/zA4jW3OYV0zvY
N0BzeI6PBvFkMvIqHw0IRuNsX4hOI3PSS67LQa3T42vun7NcbOcCwUqQJ/2tfxrK
a6cFv3EM0uVBHVD6WZ/NTVbywjlgm3iLvt6JQbRupcLg0yUahTVK8/hWOxGLZ19B
FhYdpyIfT0P/3lAoLgwpgXx8iPogdsEWix2IE2BRzv/VXJ4Jlbi4Wifx+y4pryp9
4Sar2PW4h4SNFkXKCt33+ITtJhEzTkxyq9zw7RblaWOkQcEoRe5UNWRtrL/G5zIx
3B5pxyC8Cte6up/nCgzzMPik8lcH426wxPqBiYBlFnc=
//pragma protect end_data_block
//pragma protect digest_block
KbRxgpmmNKDn+PIS9YBGuZTUGFw=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IGBgylsBsUePBcDUIycsRM6qXV8x3a7Ynx8moj+xdLQD66BegFI+uaFTh9MYfdVC
/2k2/kvld8Q8VJE5uHNgSp3Vvk/Ci4WVtfrNYZzsj3Mp37RknG1XYCnCX8t7ZeI8
qT+wgrojtBAagMl5KO2/Ys2zuRfvCDBOniITAjgQUjrZc+u/AoRnnw==
//pragma protect end_key_block
//pragma protect digest_block
JbNe1QKXWgxbdJetqWYHNTI7Nkk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
iN/o8IY2zb+t/Iz9FBBNtxPPzSY=
//pragma protect end_digest_block
//pragma protect end_protected
`endif
