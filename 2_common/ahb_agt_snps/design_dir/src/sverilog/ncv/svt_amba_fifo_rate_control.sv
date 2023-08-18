//=======================================================================
// COPYRIGHT (C) 2020 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL
`define GUARD_SVT_AMBA_FIFO_RATE_CONTROL
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_amba_fifo_rate_control extends svt_fifo_rate_control;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************


  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /** Timer for dynamic rate control interval */
  svt_timer dynamic_rate_control_interval_timer;

  /** Divisor to arrive at rate in bytes per cycle */
  real rate_divisor = 1;

  /** Rate at which write fifo fills up in bytes per cycle */
  real write_rate_in_bytes_per_cycle = 1;

  /** Rate at which read fifo drains in bytes per cycle */
  real read_rate_in_bytes_per_cycle = 1;

  /** The current fill level of the FIFO */
  real amba_fifo_curr_fill_level = 0;

  /** The total expected fill level */
  real amba_total_expected_fill_level = 0;

  /** Current value of the interval to be used in timer if dynamic rate is used */
  local real curr_dynamic_rate_interval;

  /** Current total read bytes */
  local real curr_total_read_bytes;

  /** Current total write bytes */
  local real curr_total_write_bytes;

  /** Current value of index of dynamic_rate that is being processed */
  local int curr_rate_idx;

  /** Flag that indicates if dynamic rate timer is stopped */
  local bit is_dynamic_rate_timer_stopped = 0;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bLeISP3zlvP2XFZvlSDS/tPJWQdCF48J5CTsqkB+gXUQhm51+/RKRB9/cBhUwn5e
phSkuN0TEvM/m2gT2yTHs3ZpJUtIuf7LtMb6ctuM/jIfvOD4NSi04PrcXmgFcTi6
Ii9q98fTEzSi+eaFRA74cbQp8Y9Oyu29xcx2OuouFmfJg8ZrY0GXdA==
//pragma protect end_key_block
//pragma protect digest_block
Bh0U4C7Kj6f2fLxVEW4I6wcTW/o=
//pragma protect end_digest_block
//pragma protect data_block
N3iOsn9pGharB+z7sVHEl9Fy5DiXqkheMMi1Dj8l+pDIRsB0e3ISAfOIcQjAwKGA
aeD7OzmbX9JuiW1hH3yh1na57pdyfTbzKCb825D0Z7jO+fi3Y+Pxs1glMKHPA0Oa
PFvwboBlTE7oJ0d3Uf4AjQyfYgDKFPMNQAHUPiSSMzCXKzRcKf6Lro/wehqcuoFD
3PAvFdmuRtGlKcn9eCFlXwsgHOlOlPXOMrCC+eEt61cddNkOzOtSqIKPB6rgW/jf
53vuAWICRoRZE0qbaCL2xCRuwHorJ9yefGdaRmgxcRImj2ilVcV9D8VvEXqtxrFk
IgHj+BkdSIhI3L9eOTK+w7Y+63yXoD265aTAC0CikNj/+q3sY+wQLQ2a/WMggwNK
ftTUOQgRxK/Q12fEMPLS8QEvUpg0VtuA8uG15e8RNkSVj0+AxWftRzyRrW+fJ0AV
d90DqpUgh5jNvLj1ZJTuQ3Jl3/v42B4MrSR80e739gTdJ+02MxxofNmu32o8wU08
7lC2yvnI6xClW92eoMLlTsfhnERrYyLdMjVQD4zOdCA=
//pragma protect end_data_block
//pragma protect digest_block
n9TAGSNBi0fhuO1UGGtOrgijNes=
//pragma protect end_digest_block
//pragma protect end_protected
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_amba_fifo_rate_control)
`endif
 //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_amba_fifo_rate_control");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
  
  /** Top level task to control FIFO fill levels every clock */
  extern task update_fifo_levels_every_clock();

  /** Updates fifo levels every clock */
  extern task start_fifo_update_every_clock(svt_amba_fifo_rate_control_configuration amba_fifo_cfg);

  /** Updates total expected fill level */
  extern virtual task update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);

  /** Checks if a transaction can be sent based on fifo levels */
  extern virtual function bit check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact,
                                     int num_bytes
        );

  /** Stops dynamic rate timer */
  extern virtual task stop_dynamic_rate_timer();

  /** Sets flag for dynamic rate timer to restart */
  extern virtual task restart_dynamic_rate_timer();

 /**
   * Decrements FIFO levels by num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param num_bytes Number of bytes to be decremented from the current FIFO level.
   */
 extern virtual task update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);

 /** Resets the current fill level */
 extern function void reset_curr_fill_level();

 /** Resets current and expected fill level and semaphore*/
 extern function void reset_all();

 /** Waits for FIFO overflow event */
 extern task wait_for_overflow();

 /** Waits for FIFO underflow event */
 extern task wait_for_underflow();

 /** Waits for reset to be done */
 extern virtual task wait_for_reset_done();

 /** Steps one clock */
 extern virtual task step_protocol_clock();

 /** Wait until reset transition is observed */
 extern virtual task wait_reset_transition_observed();

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_amba_fifo_rate_control)
  `svt_data_member_end(svt_amba_fifo_rate_control)
`endif

endclass

//-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  function svt_amba_fifo_rate_control::new(string name ="svt_amba_fifo_rate_control");
    super.new(name, "");
`elsif SVT_OVM_TECHNOLOGY
  function svt_amba_fifo_rate_control:: new(string name ="svt_amba_fifo_rate_control");
    super.new(name, "");
`else
  function svt_amba_fifo_rate_control::new(vmm_log log = null);
    static vmm_log slog = new("svt_amba_fifo_rate_control", "class");
    super.new((log == null) ? slog: log,"");
`endif
    fifo_sema = new(1);
    dynamic_rate_control_interval_timer=new("","dynamic_rate_control_interval_timer");
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xOZ0geoYe2N1771T2M0D6QuWDDL+FKeN/z5fFAWyvQDlY1tZS4x8qztxEv5pKikg
FHyWm+Vcxq2LTJddr2hvsVwPMdt57VO0kf44a8Axi/k34p4svtJq8qL7XpVHVQoT
7N2pCYldlBGoNeIGKVXpB6oUY/wrriZLu2u5cyaVxDLVqhOWBE0DNg==
//pragma protect end_key_block
//pragma protect digest_block
rrhuu7fUZJPk+pIvPsMEix5Ns+c=
//pragma protect end_digest_block
//pragma protect data_block
UUsiLOjacNSfjjfMrw5KbZDG3imM7zCNIorjCHp2/3NQTkb5Js+4U1P0bDWCbCKh
UqPp8yCvqUbauou/U+P+m/tlwD/WVwl7oRtm/haACVqCs02UQmiuzYoqzof9mw5e
X3CSfhV7j1NrJzC2BxPbwgESuvhu9yIvgqcwteQu+JscbfFnoFhI/Lb1KfyluDt+
bSjGUsMdiNfTGJvgDmCYZ4F0ktYw+EY93Kp1Mt457QvFcnViPvJE3PXZtQXgb0wy
Ja35oObe215cKTOTyj2ynZhbb5OVkr1xAXTlzJmgs+SXJ10eCbFP0bV46LN3jefN
zcS0ibsp8FhthtzK/bRo+9nEWOKUm2khywoprgDekQkuH7OyiHG1WbDXtWtVlo9A
002SVy31ifpy4/JtgyXenMBY7veUPjHtXXaI37EvGQsbOzok8bHGLPBZsccB0AK3

//pragma protect end_data_block
//pragma protect digest_block
oyIqMe8oSFAjntvz1btP1hGqGYg=
//pragma protect end_digest_block
//pragma protect end_protected

  endfunction: new

//-----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::update_fifo_levels_every_clock();
  svt_amba_fifo_rate_control_configuration amba_fifo_cfg;
  if ($cast(amba_fifo_cfg,fifo_cfg)) begin
    `svt_note("update_fifo_levels_every_clock", $sformatf("Type of fifo_cfg is svt_amba_fifo_rate_control_configuration. dynamic_rate[0]=%0d", amba_fifo_cfg.dynamic_rate[0]));
  end
  else begin
    `svt_error("update_fifo_levels_every_clock", "Type of fifo_cfg is not svt_amba_fifo_rate_control_configuration");
  end

  fork
  begin
    wait_reset_transition_observed();
    while (1) begin
      if (amba_fifo_cfg.dynamic_rate.size() > curr_rate_idx) begin
        if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::READ_TYPE_FIFO) 
          read_rate_in_bytes_per_cycle = amba_fifo_cfg.dynamic_rate[curr_rate_idx]/rate_divisor;
        else 
          write_rate_in_bytes_per_cycle = amba_fifo_cfg.dynamic_rate[curr_rate_idx]/rate_divisor;
        curr_dynamic_rate_interval = amba_fifo_cfg.dynamic_rate_interval[curr_rate_idx];
      end
      else begin
        if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::READ_TYPE_FIFO) 
          read_rate_in_bytes_per_cycle = amba_fifo_cfg.rate/rate_divisor;
        else 
          write_rate_in_bytes_per_cycle = amba_fifo_cfg.rate/rate_divisor;
      end
      start_fifo_update_every_clock(amba_fifo_cfg);
    end
  end
  join_none
endtask
//-----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::start_fifo_update_every_clock(svt_amba_fifo_rate_control_configuration amba_fifo_cfg);
  bit timeout_flag = 0;
  fork
  begin
    fork
    begin
      `svt_debug("start_fifo_update_every_clock", $sformatf("Starting fifo update for index %0d with rate of %0d and interval value of %0f. fifo_type = %0s. write_rate_in_bytes_per_cycle=%0f. read_rate_in_bytes_per_cycle= %0f", curr_rate_idx, amba_fifo_cfg.dynamic_rate[curr_rate_idx], amba_fifo_cfg.dynamic_rate_interval[curr_rate_idx], fifo_cfg.fifo_type.name(), write_rate_in_bytes_per_cycle, read_rate_in_bytes_per_cycle));
      while (1) begin
        if (timeout_flag == 1) begin
          timeout_flag = 0;
          curr_rate_idx++;
          if (curr_rate_idx < amba_fifo_cfg.dynamic_rate.size()) begin
            `svt_debug("start_fifo_update_every_clock", $sformatf("The interval for the last entry of dynamic_rate[%0d] has expired. Parameters for this interval are as follows: curr_total_read_bytes=%0f. curr_total_write_bytes=%0f", curr_rate_idx, curr_total_read_bytes, curr_total_write_bytes));
            curr_total_write_bytes = 0;
            curr_total_read_bytes = 0;
            break;
          end
          else begin
            `svt_debug("start_fifo_update_every_clock", $sformatf("The interval for the last entry of dynamic_rate[%0d] has expired. Continuing with the same value of dynamic rate till end of simulation", curr_rate_idx));
          end
        end
        wait_for_reset_done();
        step_protocol_clock();
        //wait(axi_common.is_reset == 1'b0);
        //axi_common.step_monitor_clock();
        fifo_sema.get();
        if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::READ_TYPE_FIFO) begin
          if (this.amba_fifo_curr_fill_level > read_rate_in_bytes_per_cycle) begin
            this.amba_fifo_curr_fill_level =  this.amba_fifo_curr_fill_level - read_rate_in_bytes_per_cycle;
            curr_total_read_bytes += read_rate_in_bytes_per_cycle;
          end
          else begin
            this.amba_fifo_curr_fill_level = 0;
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nn/FI1p6e4BWbAfk6F7LzJXQb0tTZbVWGE3U06e9JXa1Nv8wOIyEWyvHns7nUMNb
kroM7JLnWCeoB5TGQl5VYvKJ+agTKmD4w/IxeTghmWgm3QejRRtAxCy3Ngcdgblo
nKdJVT4XxwtrA00sjxWO8Ikgt1n27ojQQxom06XLiJNlpzr/dOaXdA==
//pragma protect end_key_block
//pragma protect digest_block
nF6JRygZVAxz7+Y2w8SueBK6AGU=
//pragma protect end_digest_block
//pragma protect data_block
Gf+BcH3gHyuabuai/0QumWbReYvtxG0FPnCxe24Y4BpWnfahn4SLc+QowhduRNa7
7Uv2uEJEPkkzpoqyz8t3Qxitpg9g+1SqL8tj6yGMFNVmEYK4aO0D3KJKe50aRNvD
bwN08KKjo00zEZdaQnyX0Kw0mEved8rjGeRktA+ngRdsGsUeGsAM7Ddd6szzibg9
unbDMLO766JYj7IeoZj+HLX5hzavETKVQkycY+AWNSr3UYHx7YNJ5+3TeRz7xpNd
KaKKdnuJuL5hhlKWPbPQgo8DFsBAHdwl0JEXyI/fHLIOd07b36APbQRB6WLZ1Uqe
buIIx4WsOaQTsKsVJqRRvBFNeknW5HJeme+ja5njzNmxLuuvS/9P2wTPoC/xL/xt
zyb4plKPutlFf6Cvouk88Q==
//pragma protect end_data_block
//pragma protect digest_block
qClDhCzW7y7WLx78hoPQPFAds6M=
//pragma protect end_digest_block
//pragma protect end_protected
          end
        end
        else begin
          real next_fill_level = this.amba_fifo_curr_fill_level + write_rate_in_bytes_per_cycle;
          if (next_fill_level < fifo_cfg.full_level) begin
            this.amba_fifo_curr_fill_level = next_fill_level;
            curr_total_write_bytes += write_rate_in_bytes_per_cycle;
          end
          else begin
            this.amba_fifo_curr_fill_level = fifo_cfg.full_level;
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rKOOgQf7cPanKh96k1+nGe3sP3G2uUV2KPRuMu/2R9bNNj2M6n8jkttoorsUur72
4zd5w5RGM+kO6XTuzMZFdJw0bQPLazHPG6+KTbW/ayadiTM+rYFgx+6F27bOYEBA
pyDW8guU5Otk4NHyK4Pmze49w8CBlu29KBR31bHC+/+Q+eOrL1bSpA==
//pragma protect end_key_block
//pragma protect digest_block
pd0qKxleg3vGiUrZXL6pwOcOIxg=
//pragma protect end_digest_block
//pragma protect data_block
TklYMrBUB2KpWAjgxK8KR686EcdHRsfdhWdHSApmFzyI9/wGM2YYtHU0552ydP9a
Yzm0/V8RrfPGRHwj5+N9HYxaMbm7p8sZ8oUeh+3u5KeGLmSEthJrWJbUuxFw4ysX
vV0t5ZbgvKBRbTA/j3HWMe0Ie8socM0pfZW50OuvDPatZMXBmJzJV4efqpHHDnd3
jUh4lCffKs/Lf3NNZrYah0O9NHmaVMmfCv0ow8pYG+QFXpy7yrBhfpJmDfo9SPZt
7tKZG54ftqGRxRaVgdox5VbWLXwlZc+LfaK3Vnd7mwfkd5Yg5K/EC1H4jJRpVCSk
r1qMIhNVap//nkLP0ModtslQJprgddV5UJFriiTR8Xt8RQMBRetxTTl787gP1iY4
N8y0ZrLQ1/gYXcocRwxPag==
//pragma protect end_data_block
//pragma protect digest_block
QhC2+Db7vqL8lbo74Lmw7LrPs2g=
//pragma protect end_digest_block
//pragma protect end_protected
          end
        end
        fifo_sema.put();
      end
    end
    begin
      if (amba_fifo_cfg.dynamic_rate.size()) begin
        bit is_timeout;
        while (!timeout_flag) begin
          if (is_dynamic_rate_timer_stopped) begin
            `svt_debug("start_fifo_update_every_clock", $sformatf("Dynamic rate control timer for index %0d is suspended. Waiting for it to be restarted", curr_rate_idx));
            wait (is_dynamic_rate_timer_stopped == 0);
            `svt_debug("start_fifo_update_every_clock", $sformatf("Dynamic rate control timer for index %0d is being restarted.", curr_rate_idx));
          end
          dynamic_rate_control_interval_timer.start_infinite_timer(curr_dynamic_rate_interval, "dynamic_rate_control_interval_timer");
          dynamic_rate_control_interval_timer.wait_for_timeout(is_timeout);
          if (is_timeout && !is_dynamic_rate_timer_stopped)
            timeout_flag = 1;
        end
        // Wait for threads to exit in the main thread once timeout_flag is set
        wait(0);
      end
      else
        wait(0);
    end
    join_any
    disable fork;
  end
  join
endtask
//-----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::stop_dynamic_rate_timer();
  `svt_note("stop_dynamic_rate_timer", "Stopping dynamic rate timer"); 
  dynamic_rate_control_interval_timer.stop_timer();
  is_dynamic_rate_timer_stopped = 1;
endtask
//-----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::restart_dynamic_rate_timer();
  `svt_note("restart_dynamic_rate_timer", "Restarting dynamic rate timer"); 
  is_dynamic_rate_timer_stopped = 0;
endtask
//-----------------------------------------------------------------------------
function bit svt_amba_fifo_rate_control::check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact,
                                                           int num_bytes
        );
  check_fifo_fill_level = 1;
  if (num_bytes > fifo_cfg.full_level) begin
    `svt_error("check_and_wait_for_fifo_levels", $sformatf("Total number of bytes in this transaction (%0d) is greater than the configured full level of the fifo (cfg.full_level = %0d). Please set a higher value of svt_fifo_rate_control_configuratoin::full_level to accomodate all the bytes in  the transaction", num_bytes, fifo_cfg.full_level));
  end

  // For a WRITE_TYPE_FIFO, there must be sufficient bytes in the FIFO to send the
  // num_bytes given by the transaction
  if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::WRITE_TYPE_FIFO) begin
    if (amba_fifo_curr_fill_level >= (amba_total_expected_fill_level+num_bytes))
      check_fifo_fill_level = 1;
    else
      check_fifo_fill_level = 0;
  end

  // For a READ_TYPE_FIFO, there must be enough space in the FIFO to accomodate
  // the num_bytes returned by the data in the transaction
  else begin
    if ( 
         (fifo_cfg.full_level >= (amba_total_expected_fill_level + num_bytes)) &&
         (amba_fifo_curr_fill_level <= (fifo_cfg.full_level - (amba_total_expected_fill_level + num_bytes)))
       )
      check_fifo_fill_level = 1;
    else
      check_fifo_fill_level = 0;
  end
  `svt_verbose("check_fifo_fill_level",$sformatf("check_fifo_fill_level=%b. full_level=%0f. amba_fifo_curr_fill_level = %0f. amba_total_expected_fill_level = %0f. num_bytes = %0d. read_rate_in_bytes_per_cycle=%0f. write_rate_in_bytes_per_cycle=%0f. rate in MBPS=%0f", check_fifo_fill_level, fifo_cfg.full_level, amba_fifo_curr_fill_level, amba_total_expected_fill_level, num_bytes, read_rate_in_bytes_per_cycle, write_rate_in_bytes_per_cycle, fifo_cfg.rate)); 
endfunction

//-----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);
  fifo_sema.get();
  if (mode == svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE)
    amba_total_expected_fill_level = amba_total_expected_fill_level + num_bytes; 
  else if (mode == svt_fifo_rate_control::FIFO_REMOVE_FROM_ACTIVE)
    amba_total_expected_fill_level = amba_total_expected_fill_level - num_bytes;
  fifo_sema.put();
endtask

// -----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);
  real curr_level;

  fifo_sema.get();
  if (fifo_cfg.fifo_type == svt_fifo_rate_control_configuration::WRITE_TYPE_FIFO) begin
    curr_level = amba_fifo_curr_fill_level - num_bytes;
    if (curr_level > 0)
      amba_fifo_curr_fill_level = curr_level;
    else
      amba_fifo_curr_fill_level = 0;
  end
  else begin
    curr_level = amba_fifo_curr_fill_level + num_bytes;
    if (curr_level > fifo_cfg.full_level)
      amba_fifo_curr_fill_level = fifo_cfg.full_level;
    else
      amba_fifo_curr_fill_level = curr_level;
  end
  fifo_sema.put();
endtask

// -----------------------------------------------------------------------------
function void svt_amba_fifo_rate_control::reset_curr_fill_level();
  super.reset_curr_fill_level();
  if (fifo_cfg.start_up_level == svt_fifo_rate_control_configuration::FIFO_EMPTY_ON_START)
     amba_fifo_curr_fill_level = 0;
  else
     amba_fifo_curr_fill_level = fifo_cfg.full_level;
endfunction

// -----------------------------------------------------------------------------
function void svt_amba_fifo_rate_control::reset_all();
  super.reset_all();
  reset_curr_fill_level();
  amba_total_expected_fill_level = 0;
endfunction

// -----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::wait_for_overflow();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
svJkBiplLkV2TQgDcwav7d9LH1D93v0Il3f6SNXm38KsuKiykKATr1llVxci2DGv
X14vHK5VmEocfQ+yqbAKLoWut/IaJ12KQNEoFWjgtdJn0FuBdR+nmWZMH60+wU+W
mU21bz7DUGEIcSA2kh/c/SKw645FZrvhNEUxMhhQFTNX5alGxNZ5Dw==
//pragma protect end_key_block
//pragma protect digest_block
Bs7IUKQlO2SzoXalRQDNd5HZ/j0=
//pragma protect end_digest_block
//pragma protect data_block
YbW8MCBC3sZxBXfObzR33so9SmWpFdRwQHDQoGMbpQ3AfSzMs0LJTSRQGXGkqi+d
DeW6IIAI0HBU+pzkkjZodu+EYkrsBLaL3U5fExRCa3Y2Bw+JJzfJ9Qf5fR2lpuqk
HCHD6cGryvw9y4Fn35QtWGogpBmjOvMJW5lEC8A0eQ5Y/2oC4jL2MQX8oL9paMlp
RIQ2CqcbKHrS7EpadbbjzDm7kGxo0nkuLycKGjOVycusxvzZWslWhAmTW1q2gV6Q
aEIi6Cn/lhAm6QrpeuaJNVPw49CH2OGFDH9c1wGvtMFlT4KrPh3tYQrgoFofPDbT
gvncJsFgg7kaipOT/p9m6p+THCfI6v1gwyRfK/qHYhJl/KtSSnYsQfq5NOhRJ6s8

//pragma protect end_data_block
//pragma protect digest_block
Hb9Ee/3pE5OLaVKG0qx/b5Ez7bg=
//pragma protect end_digest_block
//pragma protect end_protected
endtask

// -----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::wait_for_underflow();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4TsyYNeIbx/XIRyFVuXow4FxhWxTcBdhIBvmEDnMgQMFJ4HDs8CQhEuLf2+8srS4
aPBdlmzOO2bn1H6H+s5tcRrp50gmnUF61bVdrpcmJWAwTBa0p0DbJwpJ96MPpVf9
AtGNL2DZMStcR5nmRihY95CsS+5cljNuiDyaCjNPt9fUDp+CneKxDA==
//pragma protect end_key_block
//pragma protect digest_block
OHy95/ixr1KXte1svGqsOLR9qj4=
//pragma protect end_digest_block
//pragma protect data_block
e3qPgIT35aSSBQKCScDESsf7DDGmyI1wg6eaFRT0p8IAlRknarFdN4HOgNSJiQso
8nHQolBjU052HJug9beFdp2DxVK6wvqphvJcqPstOzgbVh4HVkrS0tOPm2oU99C4
BcKB+M6gIhlzZownmur9iRtunV8/EUdqFYM0A8ZhWZe+L496yOBhQHhBzpM5zjHE
hg7xmEVWoA6fe299WjDjUuj9mIcI0FEG/nVp/6JSRh2CSNmJigkrXkwGAHw86hyn
0NOZHroaMZatkeVKJBKtvZpdbozQe6I115QMXBvXbI6yD+VbSR3WlVNyZlugAzZ3
K7K1/fEwXNFtXVanQblJJn8QwlrohnqP3YX6rSVECRRkZwEzOXoNeFELA6PwUvUu

//pragma protect end_data_block
//pragma protect digest_block
M1gpxs0fJPr4LK4fL+WLTZHB3vk=
//pragma protect end_digest_block
//pragma protect end_protected
endtask

// -----------------------------------------------------------------------------
/** Waits for reset to be done */
task svt_amba_fifo_rate_control::wait_for_reset_done();
`svt_fatal("wait_for_reset_done", "Must be implemented in an extended class");
endtask

// -----------------------------------------------------------------------------
/** Steps one clock */
task svt_amba_fifo_rate_control::step_protocol_clock();
`svt_fatal("step_protocol_clock", "Must be implemented in an extended class");
endtask

// -----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::wait_reset_transition_observed();
`svt_fatal("wait_reset_transition_observed", "Must be implemented in an extended class");
endtask
// -----------------------------------------------------------------------------




`endif



