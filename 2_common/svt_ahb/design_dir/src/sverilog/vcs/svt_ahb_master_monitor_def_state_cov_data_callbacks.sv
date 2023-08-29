
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

`protected
1N2ZW51fd=WVMK(EOKN_H;F+),&_FTV#T]I>E=ZOU3LQa5P-OIOH1)fKO\J1/S\N
L4-/e99S(.]7+@3a)fd6TMW;X\Z.(QSTZS8+(PTfL1(<2N\ebR&CDOMQ;OF,P-2^
D980,N)KAS5,>M3WF9C;W\P^RbA;F;DW\9PWO<E+.)A+]7WKL-?ZQC,^CENc5Ne5
_LD5ALZL2S<_\BEJ,_+\ag+4d,8F?H4WFEJZRfNYC=bG,JCRgW)V?IM9=NGGT;gU
^Q6[&MTH#^eA6EfG&EZ8=>1>MY:g+SIVQ^HM<_WEf,C+.731_&D_C1.@K^Z@,aX&
6e47K5HXg@S:D<47]=K8Q>_^F86bT,KTPe]L_^]b;fZQ6aLK5H(#g&:4>J+-&2:2
^Ze8/2X(-Y6=f_XWBMN;8S+GM)HKH\Rc89,)Z32EEI6VD(2#d=SJgKV8cG_\/5[G
VG@L\)FEAcT)/GT,XW,0>eb)[DL9\C;g8O:cUKS+:YO6:4->HP^,0J>\7(NDQW>2
OY.X0\Bd;W=2GYEW)6=A-,4(\D-2_,;)[,_)CA4S,R3S6R3KU+)M40.(6D5T5?,A
fTB@P/0>(>I1Z08a^(Xa(AQA&c+UY.2.68@;<9@WI9F/CO>X@YEcB;?475)e-LE;
7FV6T#O8=gR0S(8]aIZC2^=J<FVE_1/ON(XRg=FfLZf<DQ0DHXGe#O__L<[7g#\-
KP;6<(<+;>)[RBI>.&,:&dO9SV>>8W>/529X3e170,MRZ&aCJH;d.b\ZeHf=]YdP
84bb+TPR6;SB=EQHZWf4L5+Fdef^JTc?B2)_cH^5Wa7;ec-P(7?4^(@-K[2cI-)Z
ABUF_5@?:HEB*$
`endprotected


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

