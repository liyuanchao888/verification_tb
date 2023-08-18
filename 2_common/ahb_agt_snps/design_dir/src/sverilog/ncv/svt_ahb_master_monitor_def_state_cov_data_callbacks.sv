
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_ahb_master_monitor_def_state_cov_data_callbacks extends svt_ahb_master_monitor_callback;

  /** Events to trigger the signals's state covergroups */

  /** event for triggering the sampling of AHB signals that do not change for each beat of burst 
   * This event is triggered inside beat_ended callback only for the first beat, instead 
   * of triggering inside transaction_ended callback. The reason is sometimes vip inserts 
   * IDLE cycle at end of burst, and we will miss the actual burst_type etc..
   */ 
  event xact_ended_event;
  /** event for triggering the sampling of AHB signals that change for each beat of burst */ 
  event beat_ended_event;
  /** event for triggering the sampling of hrdata */
  event hrdata_event;
  /** event for triggering the sampling of hwdata */ 
  event hwdata_event;

  string s_inst_name; 

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, string name = "svt_ahb_master_monitor_def_state_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, string name = "svt_ahb_master_monitor_def_state_cov_data_callbacks");
`else
  extern function new(svt_ahb_master_configuration cfg);
`endif

  /** Called when each beat data is accepted by the slave
    */
  extern virtual function void beat_ended (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact); 

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KxFa4PzJjRdoxfMv/OdLT0GA/kBjBOk0AO0GfuyzgNj1+J1IMPNBQMdUXDCz23dG
GuhM349QTAqjr+FNCl6fnzCcbjP3votokFngmm36FgJmR0ybsikJzrofBTEuGHzT
oqWOuqxqXvynxbFx4viME3eTdU3A+7O8G98Qxc0hbzl/pPLKPHW92Q==
//pragma protect end_key_block
//pragma protect digest_block
AuXY1+EuGgO3JvLbSUsBL+BIQaY=
//pragma protect end_digest_block
//pragma protect data_block
l1gVNzwd9ElB6AvbbfEoI9UWjQgauPkqyBTG6xObz6ZyOZW62ty+SxgpjEdhinkj
vT0gLgaQoqlBDp/HlDDJPNGas8CpVNmKmPJktBt3zAy+hs2xN6WD1/+MRhwlEvox
yXxuXnR6pxTPSNBPuTOY5eHQFklftd49nA+kxLKpnhRo5DsjrIDmqJwlBoBGZlZL
Z5A0o/geMKHt7+3769TRYz124F9RhhGxxU7FmNGxKpdansvdEg0Hu8JbfpEfXf3o
oQH1mbp14jSyhAZ62nOker3ppSOU5nPjpipxlgRm2rlbquj5KftqtECGq5GJ4uEh
7RIEGnDCUqJ2jrhcZlOW6hlQrnhGb1dLGMLsLs3FdS114ayF3mNcXzAegk9yQnFQ
mOy7rXnfDRMiK84fctSu9g8UxTQVtFdIsRrDBiMet9f6oXRLuadJOSEjrs5nqNm4
JbEiADVJsVSvUln64oI7sm8JCsUEqPBFtBMewXSaA9UOrBZGYefNhIU5KfJkrZ8O
gQcdZvPCiytAyFasTUvuRpN1B24urItQi1GYnYgBV4lF7cjenXbYLoDRkVUBXNQl
fzvE0cusqga6HIaGjPYRZgMI6pZKBOeUv6nLXFznHsXUEtBDu6Emsj+L/vKQbI8U
yejo2ZWSutaXmViJalKJnQ7Lv08NRPj5YAo6tSYEjDExcFxVAFzZEh1njKLVE32A
UZKnv7R5jNZr6fCTvOmRi+g15tbd0T/xkA28EaT/IBePwr4ERIhKN1xVjB+mKVii
cjIaX1hVZs3eyeet8uyUurZ7FgWaBgOWlEs5RRkuHVkyJS/Skqo8DO1/ncbeQ+0b
3GkhgsnOSUKaf9ECCepxMzHPdsVm34WBH3u4yGEpjJU2R0iqG7m49ybKvweZAhq4
cGkDYrq3Pa4JhV1avSEMk7WfdMAypPULabQYg+o9SUDNatocWmbtO74f/lyrqJpP
AMPvswmX7WTeDCN8Ut61cEhZ+VLKB8oDGXz0E4JDWUABmJr5JMWzf6067bNkl07P
e2JgMGkyiBc7UFsEmzhck6kmXavzRwvobcrzIDq+OD/ehC/hUce4Ob6jJPlksBG+
modVynVTCBo7n2+YI5XM/n0+Rl3PJ1PPxGkoj7pdfiH3v+k+5960D8nSbFHeWBmo
rc69Zy0IdFz3GYNBTO4QUwljB/wmd1v/WPfx9U/N0nFwpYGHTO4s43k1IrzezIST

//pragma protect end_data_block
//pragma protect digest_block
oOjZektkiA6fLhPNmJAK3b5EvmI=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_ahb_master_monitor_def_state_cov_data_callbacks::beat_ended (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
  if(xact.current_data_beat_num==0) begin 
    ->xact_ended_event;
  end   
  ->beat_ended_event;
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    ->hrdata_event;
  end   
  if(xact.xact_type==svt_ahb_transaction::WRITE) begin 
    ->hwdata_event; 
  end   
endfunction


`endif

