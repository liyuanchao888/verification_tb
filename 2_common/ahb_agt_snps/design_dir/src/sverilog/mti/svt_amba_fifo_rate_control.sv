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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hz0Mok7wR82+zNDBrFNKvvlo0wi2sRz7ACTbUxyqRYPg81BW/SgJuxc0AtMh/PBQ
K69vExVtO6DP6/SleJa0wiVAMV8NDOCUUeYwdadlbL5mL3V96hjeDTs2LbphyzuU
dQ+uhabQ7IwVoxUODYplpZ7JEpu6yLNzboMps9XyrfM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 250       )
TtshNfuv52g+Zlb+MOg8XO9IsFwDmlYuyocOV6banyiFkMcZq21yKPkn93YgXFpD
rD++FPCfNpmlzt0mMknwkJ5vC/G9VZp1/yWg6M5HdW2wommsZAGlr3hQgoNTDBPe
M9eZFiELaaZybl3oOUYwDcXq/aOjORZQ9HaY7c4V7wfe96fvb3SvnNALwMd1u+Jn
3Q/uxtpKUevF0AwLJXOgJYhV78upheORsBgbjfC57oP9onlq1uC+y1iKkV98xJVO
aaS0HYW93BG1GG3SRIyvafxgxt3Cod/UV3ebJAPkeFmySNeiWxL886w7jOZ91tVu
UT/+kvKPqqJQtc0pPrU/bw==
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DSA0xY+/vXUy6GU27AQoj7b1yGUNonvZ4Qd5cRLdE4tAjMrvxA5awikL37zmIeUk
rIoQJ3SNXxG6HX5dbD+AvJb67TVSrdagTzqXSOI+pmXd4EFrnvnz0fzXQ8vlL9oq
bYFTWnk80oaqWqFilN8UnarDLHIkWFAu200kQb3vmpU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 416       )
lb5UoQBEmt28hjeygsO91eOq6+QoFdVmMRPFcnI4EuimHWIJ2MQ8X5XS94/iy7Dz
Tuk83likQAqIUQwiWMRYpokSwDaPu8M/beGE56ujzbS9UYRyJLjx8WyWQ7wA78Fz
V8/odaVNRVkzpvgCziSNz5zvOC+b2Avky7opFIqS2ZjDewl1jclQ7BMfgAzISSf5
IEWiTWFdKeD+NZVCtb++cE2MXal8gbhukhSLQ52dqtY=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SvvD3bQFqS/PibPnqtjpcgl3cNGfMM6hDIcUYv4ZnMsdw1nauAQLPxil1YYhGWeJ
e8lKAUkkOKbBwUQVZ7tWLlEtIo+i7mev770Yv+SvMZm0cgMGHxF8nq5sAr+1e52T
5agRFn0COHfI8pw9+sTScS0KwNFoOP2XrEI+jOWhezU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 553       )
Z6jjZF9E6/QfX50l2fagUaY+li+Xg6+yH0zLqZR5mpPS8kbSre7FTibkgk0UXRz8
zAHWbhsbrWYp7UGs4KmfHUdjV1equ/HjwhFxvk0acUpyBmtcbNIz+XIfBf32VQTq
d7UXPC0FewZVP6EEy8uUJdk/V/q2Ysqt8DEzUnD5TzJXD8owM693fGHq/dD5M35Z
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
I+ZkeStKeo2GiuIS4o78s+hlR4cRkPXcFbpVXB11Je5qaHTbYvzQEb2r5AAp8m+9
mOiA+/aZniMZg8arPJOA7gxJiEyWIEA7Iz+pYC1dMpf2uNHEHEXrEbFSS8p1D76i
4Cx+2wadZCh1Oj0ZbtLEE+WpuDDvdqnbWHSxSTL/fnQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 689       )
baTiwvfjHtzp9taV9hxGm6th4HP9kiAvzuK3BlZFCk8zSGgFcpvTO0J0AgvDghaZ
DUiUt7U/JIRoxRce/sZCJTcGFGrOhFZNJZk3EFinxyd9qjanSR2M+sZa2U/OYIM/
ACq6ljwVnZCu+cI63Ga0gPcCLLcVoJAzPtkvyY3QHd/QPvXMg26nmwqYpR82SVmb
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JQvuiSInp4S1jHeu1f2AIpmbA7XELQCdKZjiPXz+wW+7E5AcFE19rCg2xLoL0ExQ
5onO4sWqIJLjFdZjhiq4m9W0q02nBsdNkjeidxCz5GTFVxkd845OS+jOBiiM8Xdb
oX/tFaib/Q6xVTepA2alJZA+cBFWK8GJ+SAJYk7QCOI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 811       )
+ibZmwLAtlspBtVvmmXDHyYvPck4hBSYM/hIau37zEFNIuMUBAYgNPOPGw7Tv+LG
t7gLnBp26cXQ4FoBuTpf9pvnSersdVz5UBaNjFQo6HyDBGHE1nmZg9ODp3iEQvvj
z/cRropFI3tz2VpVsiZjDH40aXrnocY/fxjGPAHKFNM=
`pragma protect end_protected
endtask

// -----------------------------------------------------------------------------
task svt_amba_fifo_rate_control::wait_for_underflow();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Y+4dQOiVnFcCMjeLkq2l2Cw3n11hKYp31T3WjJ1J6SnvPpSFghl5IOeRRy1rjpe/
DfYyhdOTIv8d62ZudMmerSSy95KukxSJ/Z8zN01TWTDwiDi+YuvdmP5h75RWS3Ke
00ANgwxH4gEl2K9zc89BUZ4I2MHq74znmknheUtlfoY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 934       )
9EjCSioHJWmtaolueEFyuWhvJZAfvT6DXhCLuljAD128+TUtnROEVY20wQTDJFwH
2Xc/u+nnfYUe0gcLJcwy4VtaFaHhCqHVFbM2eCJwZtipz759yzr/gxkYK/wyd1yr
AEJ5HXDKx24HEOopBNugXKLBY/hXOYAsXr13ysAaUqo=
`pragma protect end_protected
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



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kTXIa/k90NGteX+ehaU4YyBJ+jDBVC7Hlm7xNsTv5geNy+Svk0Ip1mdxeW4rXIcZ
zKtLkVSzu0vx/Op9/1WpgzPkZUJ43jvmVL8rRfb+4LhfLlwaU/nw1YynZZJR8jZR
WVeybX3ih/r5wFYmgCNodxz6Ma/dx7/Ss4fYsCk4xXE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1017      )
CxyeDPUcsIVT+RV+QpK+aM0KN+336tG4Hzy7ksNUL1Ai2525izpO2zmHrOhXkXir
svCQ8q2EVIgLYICE4id56YUkwFeg8X6cgX49tLyX6QHj3i9rXl8DC+ADUMc0rAsy
`pragma protect end_protected
