
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_ahb_slave_monitor_def_state_cov_data_callbacks extends svt_ahb_slave_monitor_callback;

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
  extern function new(svt_ahb_slave_configuration cfg, string name = "svt_ahb_slave_monitor_def_state_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, string name = "svt_ahb_slave_monitor_def_state_cov_data_callbacks");
`else
  extern function new(svt_ahb_slave_configuration cfg);
`endif

  /** Called when the address of each beat of a transaction is accepted by the slave.
    */
  extern virtual function void beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
L//8XTZhRdGrFJ6QfJdJ/C6U3r84lNSAMejyvZTfC3BEM/PdZ9uX1XaiI3AZ9xV4
ta0r1a1RCS8Ow9B0vxPSz3o0sLAl9F7v02zOqmWmnFBhsfjwy/AqfpZRJIFlcPxT
n4/oJ+foEAQRDOTtdmXbqMVH0Yi5HKWTOWo6m9hToa2mq9mHBBO+3A==
//pragma protect end_key_block
//pragma protect digest_block
EIlKL8gR1AaJZDFS3Tkrnp2+3hg=
//pragma protect end_digest_block
//pragma protect data_block
tauPGT2J9/u9PXwdI0w30NllfgqtZW17HLGDHfq+BzjW8y1DpKRwBNy/CjSHnPDd
rx89hhkgFANK/vUc5rvmoEg8tiK4o8FnRhNF3ggCEz2Uk+bfclCRZZpyI7q2N6Xu
NaQ66cbYF8b/jTqYDwlVAj9dYIM8XJsxOtGfCI7g7FlUTv6dMw5j4/y7jJ/JhdsF
6fNy6N6PprhELNMv5VbPFbjKB2iz0ZfRDMzE2tk7CTaIj9EUgUglEWumvX8PHkHl
Hxn4WKDrpw29UD6KtQmI2sNJwP9vxeFqoBZeLW6MQYYZovp84KbB0yJyThfPtJ1b
/q5DDKxOCa/vQLVe+gaZBlTa/ubC6Q+MCJ5kz66I+elzzNVT9oFu4SNeBIN84ZkA
vT5MSYElcY7nknaObCXlpc4/0vUcMWkselHXC/2RASikrcGNRzR4IOTImvc87Kzf
MUW15G3FGifdAHK1jwowamgU2t73Pe6lJwQPxWdR16uUYa7zJ6Sg1J71DbQDOeVw
sy1orS9toPdvJCVpAL/6nLHjoavtMviIA4fu0wj2B6ngDEdQrKwZcp6aScSw12dh
y3f3Px1ePc+Oc3qfOJvobtsreb207OyHN2KsWs30fWXeqUTkKl8o0ekFPyNbLskO
xE/GFWMFpMx2+b1+zF3AU+GVpMnTHqMGxrYbrNLi++xLHTlPH7MLxTjQdTtLhTa0
MAk5r6wBWBup47dPmfqmFwWWHACgdldqhQqWY1E7q9aLYvxJLHS1piX7i/15mGr6
Rd9DiwpbXZ/6vrYHWaQ17OvNXg9JNEL0aNbSWqszKRQst4CZIrOV0p9tzjeiCdGw
pXs0uc5B7wcOPtLq0GsnllOiFaaaqcrl3Xpy//WlicM/0W/qhUkfOwTr4zQr9dij
FqfpH9+LSuH+ZpvgQ/hB7SGdOG+xNOOlKOhArnzb9EPNShkiAXSazDWNlAdmBQii
cVdpH/kMEkZ2+x1kY4Xr2OPqeLiGbLYvrA4FcsMWc71Ahv85FgQe1CE9e+Wz28p8
eNZRBIG/Hhk0vgFtIWsc+QBqedi+upnZPwy/EOTyzklBE6baEVKrkVfRQq6BKyKz
5FEwqRGhxc36KW9VlQI5FZjsqcI4FcU/kMipaH3fsBzzgcpVpBPlGc0CvGN53mcb
p8w201DHaT4c+J30XLAc/YJmysoKiCFGPd+hoDprydZLbNTRV7fBiBD/wjDvocjN

//pragma protect end_data_block
//pragma protect digest_block
yHsABbOQxtoHcok86Ky3Q362R+o=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_ahb_slave_monitor_def_state_cov_data_callbacks::beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
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

