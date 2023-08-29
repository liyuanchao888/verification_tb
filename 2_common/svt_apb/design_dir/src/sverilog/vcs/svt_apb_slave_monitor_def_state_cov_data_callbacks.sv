
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_apb_slave_monitor_def_state_cov_data_callbacks#(type MONITOR_MP=virtual svt_apb_slave_if.svt_apb_monitor_modport) extends svt_apb_slave_monitor_callback;

  /** Configuration object for this transactor. */
  svt_apb_slave_configuration cfg;

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
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_slave_monitor_def_state_cov_data_callbacks");
`endif

  /**
   * Called when the setup phase is detected.  This is used to sample slave signals
   */
  extern function void setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  /** Called when the transaction is completed.  This is used to sample slave signals */
  extern function void pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);
endclass

`protected
HA;6]U>Ea&f_O3g:<4,9+)L\O^M(KD[4Y@OEH2XH^.LJ0d3^a8>#,)8[A3D^XCDA
-?bZ#cd=@VXRHLNQ62dO=67M/:e\S?GC6GI?V6Ug7SF:?BZM?e;4W+3.<>8H;,AP
:S2B4IT9WIUaKUJ[>:BH+P2^L&_<4L6^C-45E.NKUZ)d1/@d7J@94G#A:G_26##g
5@7XD+/,R8F#67S4HV4HB)8);L-OgCL#A80=_D+];M5;NQ<9=.?YPP-;=c3J1WLH
:#ZA0XUe3J5&/FD7?g/7J)fc2I;V;bT8NC6+6WH[;:HBF=+PRN6Z+=f.Y@=W_T+S
U.QgLLL(D+TJ?b=IOIZRHJg,<+EaSCdD6D8IJbX;;#]C#]7_:Y-DUNF_[+HH4db?
7cd=?ffbM3\.VFP4a9[f.Qg]9JQI>AFe/A@YLWfdOR;FC_-9+cV=.;U;dGK[EM1F
75Q7-.U#6\B4KSa53?U9@\_EPY.9Ub+A,b@<LOV4&,EW_O]R&2B<>G(5f5UH1Q1Z
A#YbT9]gcEDF#+,Wg&IAWdYa<CNP9O5A[9+VX+^5<Z@7T4T)H4^\4eHCEDBD#cQb
_ZZVLeFGAZA45I)NIZM1W4P[SF=IfI6OVH>Me,\XTVg@3/[gK+5K]V<SD^MY\9C_
fO.^\Y5;,3#b59FcULB\KaZ7VMd[>778.?/D0ZC+XLH@A$
`endprotected


//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_state_cov_data_callbacks::setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);
  ->master_sample_event;

  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    ->master_write_sample_event;
  end

  if (cfg.sys_cfg.apb4_enable) begin
    ->master_apb4_sample_event;
  end
endfunction

//------------------------------------------------------------------------------
function void svt_apb_slave_monitor_def_state_cov_data_callbacks::pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);
  ->slave_sample_event;

  if (xact.xact_type == svt_apb_transaction::READ) begin
    ->slave_read_sample_event;
  end
endfunction


`endif

