
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_ahb_slave_toggle_bit_cov ;

  bit signal_index;
  event sample_event;

  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_CREATE_CG
 
  /** Constructor */ 
  extern function new();

  /** To get the signal's bit position to be sampled and event to trigger the
    * covergroup
    */
  extern function void bit_cov(bit b_bit);

endclass

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from ahb slave monitor callback class.
  */
class svt_ahb_slave_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_ahb_slave_configuration cfg;

  MONITOR_MP ahb_monitor_mp;

  /** Dynamic array declaration of the single bit coverage class for hrdata signal. */
  svt_toggle_cov_bit hrdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hready signal. */
  svt_toggle_cov_bit hready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hready_in signal. */
  svt_toggle_cov_bit hready_in_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hresp signal. */
  svt_toggle_cov_bit hresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for haddr signal. */
  svt_toggle_cov_bit haddr_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hmastlock signal. */
  svt_toggle_cov_bit hmastlock_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hprot signal. */
  svt_toggle_cov_bit hprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsize signal. */
  svt_toggle_cov_bit hsize_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for htrans signal. */
  svt_toggle_cov_bit htrans_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwdata signal. */
  svt_toggle_cov_bit hwdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwrite signal. */
  svt_toggle_cov_bit hwrite_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsel signal. */
  svt_toggle_cov_bit hsel_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hmaster signal. */
  svt_toggle_cov_bit hmaster_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsplit signal. */
  svt_toggle_cov_bit hsplit_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hburst signal. */
  svt_toggle_cov_bit hburst_toggle_cov[];

  /** Constructor */ 
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_data_callbacks");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif

  /** Called when the address of each beat of a transaction is accepted by the slave.
    */
  extern virtual function void beat_started (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 

  /** Called when each beat data is accepted by the slave 
    */
  extern virtual function void beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 

  /** Called when wait cycles are getting driven during the transaction 
    */
  extern virtual function void sampled_signals_during_wait_cycles (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 


endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TRfjwwBPu96DoIAv/t3DAchYjy7uPf+JMmMlZ77dia+7Mxm1WjVyHgZA0ZCmXAEI
xGCl/70YDPBoRlsph2qmeaiAWD2gtXK+f2FiUCBusIroLhs3l/RGy40ByFauzUv1
uTk1iHk4e9PzpRx/kdBjq7JC61YtB3F0+Xbhnrj1fW89kCeYE2CdAA==
//pragma protect end_key_block
//pragma protect digest_block
WeBXbzdrZu4xWD/RJ+y034xUoxc=
//pragma protect end_digest_block
//pragma protect data_block
9LE64d2C7b5wiBnc4j6OsgaqnFjrhZOi9kOk6sQ30wD53hydHXlCVd4F7xDjois4
9wpjjWxz+BamG4SS5bJopgJYSrGzv6sdGeXdOAhDaDkkVg0RaZ/TEG7HsB+TQ68K
9DQ2m9ADWrR2VsskCSEy345/k2fBXhk+1hq+HVEQpzSN4ezwKx4wCSb1z85tfQFe
X1f491cm3KgIBzv9ugx4qCXII3BYHAp2ZZVyYmB1ijFKHQCtkbiM7ylglZcX1Ls9
v1W1wS9spDCxhY2VZKA2b6gzdB5lSSgcGHhCIkZ2nDO9EKSY2KE7rGFxeiF1rfS2
nfxLNNrh9FlSkKBnhAN4S/iQsokwzqHeY0IpR3Rk9CUw3hpGpEpCyKKZPubZyvEW
eWkC1BeymJBiwIK+h+w5inL93xdeKCOEISo13AZdd5vLkAbv0TzH4oGtyIIMb8xn
/Af5iKfG0h/2fuF7ZFN/L9KiSjJBSBxSCA1lZDcmsW51p/p0nioPaGKnb3fR9BwL
8+bGR1qxzjJ7yNSD3vp1ro+xVbJgWDpuAF5m+BiDicxHwYSAr2nV7RbVgcd5sZpw
4hbRq38zk7AjDjauj4ow/g==
//pragma protect end_data_block
//pragma protect digest_block
R7hpw2/f9NhpMIo0lSAdYEKQ9mo=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_ahb_slave_toggle_bit_cov::bit_cov(bit b_bit);

//    signal_index = b_bit;
//    ->sample_event;
/** Rewritten the above code  as following for better performance as per VCS R&D's suggestion */
         if (signal_index != b_bit)
         begin
             signal_index = b_bit;
             toggle_cov.sample();
         end
endfunction
  
//------------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hBIWLXw4OPGR8nZ2UA2J8g8zE3s8MPf4rGpJIZz77bubHck4ocjl7MTLvZXXo6L2
UkNA39S4IVPZKTGAvfjMbc58Ubn0dI8ntNlWaUltZuo1yNXZb7AL7FsUCjGE4Dj0
fgssuyy/wBemplH3FIP87LFj/IWHvrjRQMaWrqD9ckSF/2drFoBjmA==
//pragma protect end_key_block
//pragma protect digest_block
zqcnJohGccsln/GMcNSRC80wyEM=
//pragma protect end_digest_block
//pragma protect data_block
TAlnQ9CiagruVwoqfdrrSzzSrXHu/RYIOTPEphBriXL8krdsHt0sPjTxcIsenC01
sJJGkMzBdblmuaK4b0gD9td1dTXVXsTYI7u0Fh45hdiLrTE7h9hOmHd3wzrAqh2D
XmRD9AbCGUFTR94KUdgpNVIz4GJtt7AgfWS8yOOQsYsQZMTelFakN6jNkeGKKVSb
FPH9mA3A8fpiECyfl39dEQUR+OeXNMZrwyWBC1rNfI+PwT9dxTEUfEdIqUfWCQRQ
pVhjILQYuSqpo265cO0aHACFcL8wBLx8/KBNaQu4TMWTyr80mIsdBs4bYvqSA4cP
zOY8ehk4pbbbZz48tMHeBnuH/hblLR4WCnnL/Byk7okdQikNDIEJ0mWNCJiQ9gnY
DVJOFf9vNHUkOEAKUbDtpwVZT3odpt0nUUT91YB3hWMVA+1nGVY46ePEx6iI0TEr
pjfslgoO/I5yiScAMMlnp1BG04OsVY3Wv5jo8qxeRG7J7QJ31n1HuWpCNbS7s1Ws
Vw6JGq7G7vq0eWHtN0nIKh5a1SzxPTUb9XyqHrATUdCW3CvL6vq1RSzWM+EH7rtK
+6MxjBozd6C8usi9/hRZUrkkGEOtg/tCEGIegdKPO30vGntr2YZIusH86iIvqBCH
Y0435EDzWgpscMoIGSg7GI72TmveDM/sniqirXZZzzd4aeZWwpZyfVnEAuEMzawV
rXxOmM1Oep3AQBA+8FkoSu/Yvru2jNuOCQKmGDmOh+aG3J6KusXvClSLT3T5BjIv
2O/ZjG5Di3hqVgyA/9qrPKR4LthreK6oETFkaENHpQYKGU+yp2WIbf/U4E6xm7bw
MtNUy9XSQLxj1k1vSgkGVvbQzOxGEtxnQ8DRvlRHU7zmxfwN6raaT+tKnaxc+Xuc
jsWfPTKn6sRBEQUbINY0/wBuBw+rmpHVYpmQVoZp6Us773AFLli1khNCZaHglF6f
BTBJ99j+/qe1mkYf0d7z5YBOnddlRd3cu/+lmAkeGUykksy91tDUkguEd2N267nO
wu2Xl3W8i0g7hj20oUdQ1BID5QG6dHbM5Pnh+BrvRAu1aRdQQVMcho48nwrYsGrt
C2t0C6eG4C/ca1DRWQ1jFs1PKT+5yQJ7wZqi4Q+67z1bZbLfgXWwF7S0My+2ViYu
m7VHUI6Mn9PHUDmBcu5mS5GC14VFKBb0jB6CIXfGbQWSuyVC2CgSRn30q0mj72Cw
vuhqrs+gaCWPH1fihjnVRRjYpUZCvyF+0vFdKRYvS/A=
//pragma protect end_data_block
//pragma protect digest_block
xShQwX+pCrroj+9zKs177N/njXw=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::beat_started (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

//------------------------------------------------------------------------------
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

//------------------------------------------------------------------------------
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::sampled_signals_during_wait_cycles (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

`endif
