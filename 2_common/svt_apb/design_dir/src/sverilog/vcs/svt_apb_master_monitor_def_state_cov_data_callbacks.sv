
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_apb_master_monitor_def_state_cov_data_callbacks#(type MONITOR_MP=virtual svt_apb_if.svt_apb_monitor_modport) extends svt_apb_master_monitor_callback;

  /** Configuration object for this transactor. */
  svt_apb_system_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP apb_monitor_mp;

  /** Event to trigger coverage of master controlled signals */
  event master_sample_event;

  /** Event to trigger coverage of master controlled write signals */
  event master_write_sample_event;

  /** Event to trigger coverage of master controlled apb4 signals */
  event master_apb4_sample_event;

  /** Event to trigger coverage of slave controlled signals */
  event slave_sample_event;

  /** Event to trigger coverage of slave controlled read signals */
  event slave_read_sample_event;


`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_system_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_master_monitor_def_state_cov_data_callbacks");
`endif

  /**
   * Called when the setup phase is detected.  This is used to sample master signals
   */
  extern function void setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);

  /** Called when the transaction is completed.  This is used to sample slave signals */
  extern function void pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);
endclass

`protected
^Gg28ecQ6C8d4&c?&E]SS>;Q/\Kd:>@UU..g..H?2<D+?&O.fV8?3)EdB,bY]V9,
E66aPM)D@P1f_#_)&f+98,H2YG5A\gQ2efVW0OgH)S+b/COG/KW&S,bdY_CJRNM5
?M>DGHBS@H5J\<:CE)\5DcOV=-ae^&,L4,T:8?><AU.4W_gD[9?W]MTK6N#<YNRT
DF^:K&FgPJ1ST8;C7(W8dO:O@6?M,Rf&)aF+a)<SNf9RA7a][_Na[Vc4W>Ve4TS5
DcaS,Xc3W.U(?_3#5L:V;64U.0)\,Ec#5Y_;Me\:&.Y;9+68d_S+\895I2HWRc=5
(-PL7#C^#239H=4/Q<1)M(4\8^H:^dbgT_\[K,,a.-+K.L;Ja_^\0&SEPfW=6-48
SK=RbMJXFe#;,VGRP#LB8&0@fTLS2.Z.K_>]7W,HG2@GW2A5<]^68>>HT(6D4(1F
:T0[>5Bg(OAB<<(?0ZV&bAe]2]373GJ9a@J..(0Mf[:.IABEL<>R8eZP6?YBI6MN
J3_Y\e;B[aNL=4D^(IE4OgUQ;B(,Yf.R-57L^SQ]>#Qb,Ic[;<XE466+.F.>]NFR
QScG2@,WNDSZ&6]cK1>/>VG6]RO@L,bC^Z<8T#F4]Y^VbT2BM+(@.MF7#.4:R33=
;&cW@]PYH\-+Xg34c3S57V;.f8B64UQ=QKIXc3F2Y\XVD$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_state_cov_data_callbacks::setup_phase(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  ->master_sample_event;

  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    ->master_write_sample_event;
  end

  if (cfg.apb4_enable) begin
    ->master_apb4_sample_event;
  end
endfunction

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_state_cov_data_callbacks::pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);
  ->slave_sample_event;

  if (xact.xact_type == svt_apb_transaction::READ) begin
    ->slave_read_sample_event;
  end
endfunction


`endif

