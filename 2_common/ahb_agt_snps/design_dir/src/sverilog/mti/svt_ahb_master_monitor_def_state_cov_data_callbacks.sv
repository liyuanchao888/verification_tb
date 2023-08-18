
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YtjFhobb4nzRUpvNKpfOrM2F3YxfqN75bpHhZLtiLxoWHf/jPZgFMDkARiPBhYFg
RgqZPfJAX5ht37Gh7bDBceu2j3MmiVqHEHrxT/3822Eka4w96vbr8Elz1RyoKpB8
YLXKhXIAf2jSL55ekv7Phdr/XQ3sRqRKvYmwW8zjg9s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 740       )
9zBLFtg11+2u24gcAuVHieJddBM1XRcvZvE0ClGLUl+OzLDxDnkpuevABDW4uwRX
/K0cNQMrdZKUZYwH82PY5XkrUuUi9BDNkJna6+EHoIhHjHBRfouGTP9SWYTn46Id
nDYd2zz39kxX7l1epdlUz0b2kKr0lKTT/TvZLXMhdAFwd7gwu8rUosKAuvm2VBVN
9u3euNRVb0qmBl8or2Wp8x+oFJhtJSjV6WK8Ck4uEtqI23xmNbxB7cgCsvXMP0P/
PW4GfszE1LxMngGvyrg9NhFMhdB6g/Ty66zHdrRa3LV26EA7+9g567z5ShmBz9JO
/OXNT5SIux4XJ0zhNYV/yFuJfTc8YvH7NfHfd8hsUG119xnJB1pQ6ofMHY3ZBTMX
zp5wHTKQU74dqILPd4pXwobgx66junL/QXc9SgTC5EQ0gf11OxDv8v6IoXjNZHps
RG/JP8DoqyZih7CRTtVBBSQ4zmRQr32Tc17yljKP27pXcXtgm6kYmrq6lXPn7AtT
SFYpn80cOfSL3nTxECG6NW0UY3+n7lrGIzsBnq+MDc7SDxghzNJyhyx/gPLlgFTp
N7zL0kdDh/6UMnYPU9ffdov3yAVI4/WyPWhNE7THrelb9bujIDt3/45BzbAtZz+K
aOfHY/jQ2vtITa+ogkyDCGvxGljgY9wD6GCtrn/kZ7nV3IaddNb0cips+dCa0KWC
WTXK+E94AfC2DidUqz7Y3fxq8WZcjQzghs9QADOc+p/bQq+xompFyrQ0fh0xsSDy
clnlQ8LZhcERzt2yOe56Y5JshRDYWyVGUCnnPVM0+mJAnKjQMvEUCGZHXWmFRqaf
OVsvftCjr6nuFCkzpUiKUxNKifDnC2N5/YEeV64oIdTN/tPUDr+cee0e595/UDi6
+I3gWD05qfjZtbXPjx9rVWyemP06i1u061rmm6JR+vcRm+zHpk6ICjiex9L70lN6
YL3Dog6L+eh0k58+VbcTedDuiHd7yaUqHEhNySLKQNY=
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DDeWLTkiGb23GeDTWEAqTFgpMle8JCKLq5Xvxia1OrVEpsAdBDu5Tl/UQPXhxnLB
ie1lV1oRSxXT/UQ7UwLdvs0S46Kf/qSHISu2RldlNlQHLYaehmwYwYf49bLmkZjm
GZrZuJzsV2GZdc+Rh+geQY9ibhLHO/Pby7cVia2v0P8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 823       )
zcURKORjSUo/3KNc5jpdGMuc0X2w9xQqdJKrnlBMy8kNOXPxqoauP8yXZPdtQ5ep
9ZWMURNUaqEI0fy2BGIN6aP2vRPMxXeFwXhsyvuCplfvaZQkegN7zj0OuKDQGPTV
`pragma protect end_protected
