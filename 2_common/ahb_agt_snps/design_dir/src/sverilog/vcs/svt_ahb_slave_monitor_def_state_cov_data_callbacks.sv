
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

`protected
-&>3PN]UB:V@QHQZaY&-?H_:cYRZ.AW#@G^=MM+5R^\L6WZaT7_^1)(&5BY+^E9b
.K4<dTIcI0AP-^_:\I7bG<J;QN2f<MZ.ZE29^JP,>)>SZg7FcIbBQQ;=X(F)+CMW
.f-PGTA4V4FM(@bX1P550?g#[[B,CbZ2V?eP(;X@WFEUKGf1\+HFLe:#-LLSb_QP
DdEPL]ONI7M8g?,+?9E3GM(8Xd8eLJ9b\R>?X[8[+VD\XRNDX+08)15He-.9+.O8
-aG(&O2FWaHT7E]+d#JJ[V)BL).bDKC>D3[.PUNHK@UNO9fVdfCdA[LMT@)5[?B@
2?,@[RFe=LZ)1Ia+R;Ee5CV6SM@P+BK:>827XCW9+bMX&H&M0cZR_5GZHKGc&L[C
)]BKLb)>LFdaHJH&/Qc9M0J1T_QG6XHV5bID4Z+E==F+JYag+BQRCE;V=I[_B-[U
#cY7D)3f,VfHKBM,B52FJ[<b>@T8QWI1ec4,G+&2NZ8,I<KKPP5AJ^FI/)4D6a;6
VLd_a/XI_2UI_GJdS.JL5>,Q@AK+Q3E4EC^[L<GfeVc(;.C-CQ>Q\D9KSKXe)CBY
1_SO4.Z1ULB143IfN=R54\36E_,Z&<e[ce,/1L1FBW.fT<LfbaRV.Z2I/g910^NW
:UO^TAc7aM0?V^U<.b0V;B,gVD.</b2N)OZ78.d>(U/V7SLWU@9VKN1Ig:3J9X][
bPLf[AET/(b7<WT\/4c&[9J46c<9KeAAR<45B0@?.BI7f4NcZU/8A^-fAU,^)SDT
F,]QB);[5gYeT@6Z-1G6NS[TfYL-Z&IYVO1acO#B.[,b1OB+dg5#6D@<(2OGb,5.R$
`endprotected


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

