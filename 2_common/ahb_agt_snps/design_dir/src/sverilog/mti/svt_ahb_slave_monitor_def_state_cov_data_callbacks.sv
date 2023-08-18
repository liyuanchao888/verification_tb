
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R8Ul1K9xUsrhXe13go+yfuyxPBsrwxpknWgBfAQJ/oULeya9vBXtrvY+8BvNl3N0
rfE/UiTy6jLUvP2CUbJk8NZbtgwB2iMZxOkT2q1MVbrZ2GX+X5QACjTt3QVVH3UT
0aWy7Q7qUUhe+yVH8SOaYX+Sf8g/XR6XP05rklYezrw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 732       )
v5fYlX8JqXqb8eyonHrwEVscGAsPodTcGmXE1hU7fWLVU6YeFGm91jmHdXFDSE4c
PjxxjApyrMeqdpIg0ZcV0VT17aKf9icsLanWwEXQnfDNOnNDlnGbaC1acJaL2TnY
//UYioDZQPmxWdGEPzEQCIAV0KJkGo7CqYMGWb0XBMwsHQnvhhGI0r2fO+NGI9bu
UGLYBmMthS3wuEzM4qOwaDEn8z+79bUXEqzKD1A9aHPXk8hHjl3FfWhsxhBVJaer
srUuwKyXmUB/XBbwmXMRWkxzyiqmBayJuM7vKEPqD1jayj7tXtuSlH6nQV2hOFqx
kcwLvzKeRr72TXbQNhATAJKZ6kE1q+h56hmmhDPyUCOxmobMATLIoHpKzcnS37so
9a1PGc16UZsfhFWAETxmSdUc9kV703duaeMPkEU7H+LoS7k5H63i5MGXVhus2Emb
DFCetF/Eqn7Q45mjfl1at+v4pWGzD171R1Fuk6pAWizojiCJqWtW5OflGNB7gqag
ltX+iqk5RssegBsrlA5TzycUh/VR9/GDr6JD3WPWqptYvcDjkZc0bCL3nYIfU9gZ
PtZmE5m+UDjt1aKo5F70TXnvqEhDk/VqPlmbIxJz4iw0FiwyOKrs1CAQsR+xlQfw
qVDu8bTzFqJLuXTKu6IMtMnprlocSm5ppEPSXxMKo6xQdlCzPcaB8tZyUHklWvUj
v3+UZ+WpjiU0UROAw/Yzxo4IygpvtI0RuAbHM7SSTo5G/v8K3ip5bqKHkTTh9rDe
D5u1Kujf4NFFVIZ+cBQjXtjhyFG33x2V2msohHNNcxw2kCvVtxNTgQX1jjdGMFPP
894cZeA9jkx4TsdhDWlv/zM5v73sdr2qUKaK/8Sgqo3lZihkIuvvnHreWF+cgFLq
4wLLXfBaOXB0+OEZH46jMQOzWO+x6rNsUC+VpDSldIIPwVpGQ6XQc3S96oK5e0iS
pP9s2dK5QDwmHbIe8R/6ig==
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CYi1j5YO2d8l/JyR3t7RKBLRhRyUPez61lFZVnTnmYj1CUlH3/zABmWFHPELV5DP
xToduINEqKg+FokEzB4dNmjV7KoI3ID3SlGxIa8PyCVlAklilTrTyyRGZf1xR044
WqkEYTCiRg9dCGm6RM+BoYv8rh/69xfNQC3jENS3PcU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 815       )
axJ94mhTiFO+HV6Zzrm/IAo20yGmmLZmYdaLzEJAmwbpeOBJnnogvgkpWhP9BIJ0
FAmu4BR7JgSqLDCWgZoIApT8Nlhu2cImd7lleox8PQQXUYy1RlGZNGPlxTfzj3eB
`pragma protect end_protected
