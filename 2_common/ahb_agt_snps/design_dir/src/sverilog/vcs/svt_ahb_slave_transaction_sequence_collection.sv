
`ifndef GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
typedef class svt_ahb_slave_agent;

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other svt_ahb_slave sequences
 * in the collection extend from this base sequence.
 */
class svt_ahb_slave_transaction_base_sequence extends svt_sequence#(svt_ahb_slave_transaction);

  /* Port configuration obtained from the sequencer */
  svt_ahb_slave_configuration cfg;

  `svt_xvm_object_utils(svt_ahb_slave_transaction_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  /** Constructor */
  extern function new(string name="svt_ahb_slave_transaction_base_sequence");

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_ahb_slave_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_ahb_slave_transaction xact);

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  extern virtual task body();


endclass: svt_ahb_slave_transaction_base_sequence

// -----------------------------------------------------------------------------
`protected
cVZFW@#;J8A8UT00X=T+NQXCTe0XAF=Ng+?^KeA#K<)bD&5A\F]S))S7;G)a[IQQ
>e-1ea5LN&LcI5O\ScUJ[?;2VUX=#QDM?,1.VUR(Dc,Hc=d8OH0[aLa8LBR?/dVE
gNUOI/9,)_1=LI2MIge7]I9bJ4V<VK]1W:].X/K+E6e-=I@&SU3B:WK>LU/-]U>M
^[Qf&DAC-0[DU@\9CI[4:=0bJ3FS@#G^SbUe(8J]34GFW].;3]D,>>Afb,M),>.T
5,G^R0/7cgE?P20?==BZ\3@WD;QDdBa1X5]^fcAcAXL3?Z+7Y7+2[3Zg)FB70fX\
#-aEW)@g^,^&&.15Z&VELV)/gCE]02_ZL^=7caD_^B&cI.A7X)-.L#e];>(<W29H
:)XX>dP?B/D)f4,F6Mb)BX;Ke@;e?Bf#^3U/VcT-6FU+/67ZL9IY.5XX:gC(_4Sa
5eaR:14S\a0OX8870WX-0GV+1A;A:@A&BZ1Lf(HLI.ER.L9cSR^K^6+7+41.a+(U
ZY(#&H5SWCZ\.3,W2V>N1d1AINE]M?GC6_Z+R6g\dZQ._/;fEO0)WQ4K79LJc1K_
>HZU0DJJ^/+C./-8T?cV8=&>c6+5d9/IQ@LE&)7YG5UKN207ad<8gONafRDJP]J4
/gHF);BU#7=>We5(Z5HSR9T,WC5,Ac@.5_Xd^ZJ/LM^]Dd+N-CE3R&:7(MX4C7Kb
5a&\L?I2RSS.=4241:W2@]<(@@LGR/VYIG//VE##4Ue4D=SRC_,dI1(&@-);d5H_
:B/OV?<R[a6GA=bV6V7d9/V#[5-GD?90N:W#XJM21R3RY&<>PLg+H<#M.<N]L49>
C[MJg:UdK#Nb\D:\+GU0<\O6O(.+cEfN1XJB8cHGP16LD=F>&A+OB+)c-c2dX6L[
9=1Lb>_I[3Y65<5e+-D1MDY_=K4B11CabLgQ@U^FGY)=L&/QT\H/fG9EO7KP@JCc
>9^(W4MF0+?VT-_;50J8bJ?1YZ#(;bYAP3VI;:Ua@?F3NENOALA0UKXA/-8BPCYe
FXgD4,,X?\L6KV-Bf2>bTW)GMg5TW4IH2Gg?&,A2MQR5>baF=F;OI\-46+ZN(USV
HF;c_c:9JSD0ESV6Vg1ZXNGFcCT8P7(=6AU>[fW^.7&KMRADb-&>YfV#277ReOH3
7BGbV)2^8SK>dI0TA2U[K&ZDaY-/g>]E>RBMQ.M5EW98=f5<\Rg,6UVe=L<O\d^-
814O<E;)FO0QPCK^I9J:+G]D@1H?&f?@__Cb&_WKaGB)U9:ES9FM.MVD0#NUBH9M
D],4L[-CcCHAV6C-MLL[g9GIDTadO]C0>3BA(dG5AIfe2.@FK^NM+6M&/,@_/5c=
10KSH2-V96P76+KL2bG4:O@UWWH>DGdWa3Z7@]EX>@.](EBIGX#+<>+:.b?[2=g;
^LM\fTa-f.[ZXY.&-df0LA[R6M>Mb>2]_#4>/gNAL5F-?bZbIFTY4&E3.D3-3VR_
.C9_R#GZ\Q.c47\ca5:g8Eb@_RO1DB;L&[eAXV_AAHG7>7F[GC:[1QP]##+BJU8?
e32Se+0]C749f+G1J:e4DB0^2B?KE^Sa-Q(5+TZT(D(fL0+CPWge0+9V-OLSO+.D
V-?2YHR_6WFK\-/RQ[+VHCD0._<A+]f]XGEL8H<LHB7ZY/SceCcZH1R9A6]d.d\D
H=]f6K1dL2Ue^\;9QZGU9#5#D+a/.@?W0NKY;LWMKPFHL735=+SMQ&D0@IFb8_39
O[S4<K)9dH;ac;S35Q0@JHGF2FRILMOP,<ZRP54?d1?gX]cF3MFgWM:09.b6d@G=
aggYP#(:9[H<NW^S#YJ,P[I-_GHgXTf7^9L_HW&\]c+X+ZRcFQEY-+GN6(])&KdG
<:2[6?H]@W]B0O#YO)^<43R)0)+_8d@<JJ1+]:>VbI-X+B71cfNIMP54CbA1;=.E
J>cXce1&P;PH4#Y><Q/\843&&W=ZM]I#K+F7N2(\\2:X+d9B1)eY,b)KD<#^/C<;
;GOY\:f:d-EKT2Xe>26:H>@,<\_I+(9=ba92.F-G&:Qb)>?RdfILJ8)Q3ZZ?.,N3
=3._+[H:LA@&G_9U^g7[/B&\L-\>S->V=4BdX5]?\(1eV]c74b?A5N1e/VZFEe3@
8:-RSP\N&HN\E>VAJVCVg+0T<]L>9)N@aE22V@HKU&GB)66IZ;,Se-f./=3KEX\P
KeKAAFIY4HbB#HRIfN1GB4I?(gDIW^F?L:H3H;d+P#J.Hd(cY(Z7acR+dZIB\bWg
[46S<L24T3(>2e;KM&A5a?KdVSfQK+A]5,C+8]U6XSA#@+W4eYMF3J)&&=:@8F,M
g,f;==39b6F>LA64HG\ZALM(BKc7Q(+2@MMbQ8ODba+OeRD69/9[Z^<aMUgNB&POV$
`endprotected


/**
 * Abstract:
 * Class ahb_slave_memory_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction 
 * from slave sequencer. The sequence class then randomizes the response with
 * OKAY response and provides it to the slave driver within the slave agent. 
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 *
 * Execution phase: main_phase
 * Sequencer: Slave agent sequencer
 */
class ahb_slave_memory_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction req_resp;

  /** Zero wait cycles weight */
  int unsigned ZERO_WAIT_CYCLES_wt = 100;
  
  /** Median wait cycles weight */
  int unsigned MEDIAN_WAIT_CYCLES_wt = 0;
  
  /** Max wait cycles weight */
  int unsigned MAX_WAIT_CYCLES_wt = 0;

  /** XVM Object Utility macro */
  `svt_xvm_object_utils_begin(ahb_slave_memory_response_sequence)
    `svt_xvm_field_int(ZERO_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MEDIAN_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MAX_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  /** Class Constructor */
  function new(string name="ahb_slave_memory_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    integer status;
    svt_configuration get_cfg;

    // bits if set decides the num_wait_cycles distribution
    bit status_ZERO_WAIT_CYCLES_wt;
    bit status_MEDIAN_WAIT_CYCLES_wt;
    bit status_MAX_WAIT_CYCLES_wt;

    `svt_xvm_note("body", "Entered ...");

`ifdef SVT_UVM_TECHNOLOGY
    status_ZERO_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ZERO_WAIT_CYCLES_wt", ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MEDIAN_WAIT_CYCLES_wt", MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MAX_WAIT_CYCLES_wt", MAX_WAIT_CYCLES_wt);
`else
    status_ZERO_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".ZERO_WAIT_CYCLES_wt"}, ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MEDIAN_WAIT_CYCLES_wt"}, MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MAX_WAIT_CYCLES_wt"}, MAX_WAIT_CYCLES_wt);
`endif

   `svt_xvm_debug("body", $sformatf("ZERO_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", ZERO_WAIT_CYCLES_wt, status_ZERO_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
   `svt_xvm_debug("body", $sformatf("MEDIAN_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MEDIAN_WAIT_CYCLES_wt, status_MEDIAN_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
   `svt_xvm_debug("body", $sformatf("MAX_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MAX_WAIT_CYCLES_wt, status_MAX_WAIT_CYCLES_wt ? "the config DB" : "the default value"));

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_ahb_port_configuration class");
    end

    forever begin
      /**
       * Get the response request from the slave sequencer. The response request is
       * provided to the slave sequencer by the slave port monitor, through
       * TLM port.
       */
      p_sequencer.response_request_port.peek(req_resp);

      /**
       * Randomize the response and delays
       */
      status=req_resp.randomize with {
        num_wait_cycles  dist {0:=ZERO_WAIT_CYCLES_wt,[1:5]:=MEDIAN_WAIT_CYCLES_wt,[6:16]:=MAX_WAIT_CYCLES_wt};
        response_type == svt_ahb_slave_transaction::OKAY;
       };
       if(!status)
        `svt_xvm_fatal("body","Unable to randomize a response");

      /**
       * If write transaction, write data into slave built-in memory, else get
       * data from slave built-in memory
       */
      if(req_resp.xact_type == svt_ahb_slave_transaction::WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end
      else begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);

      /**
       * send to driver
       */
      `svt_xvm_send(req)

    end

    `svt_xvm_note("body", "Exiting...");
  endtask: body

endclass: ahb_slave_memory_response_sequence

/**
 * Abstract:
 * class svt_ahb_slave_controlled_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction
 * from slave sequencer. The sequence class then randomizes the response with 
 * constraints and provides it to the slave driver within the slave agent.
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 */
class svt_ahb_slave_controlled_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Beat number value **/
  int unsigned beat_no_val = 0;

  /** Okay response weight. */
  int unsigned OKAY_wt = 25;

  /** ExOkay response weight. */
  int unsigned ERROR_wt = 25;

  /** Slverr response weight. */
  int unsigned SPLIT_wt = 25;

  /** Decerr response weight. */
  int unsigned RETRY_wt = 25;


  function new(string name="svt_ahb_slave_controlled_response_sequence");
    super.new(name);
  endfunction

  /** UVM Object Utility macro */
  `svt_xvm_object_utils_begin(svt_ahb_slave_controlled_response_sequence)
    `svt_xvm_field_int(beat_no_val, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
   `SVT_XVM(object) my_parent;
    integer status;
    bit status_beat;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
     `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    /** fork off a thread to pull the responses out of response queue **/
    sink_responses();
    
    /** Gets the user provided beatno val wts. */
`ifdef SVT_UVM_TECHNOLOGY
    status_beat     = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "beat_no_val",beat_no_val );
    status_OKAY_wt  = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
`else
    status_beat     = m_sequencer.get_config_int({get_type_name(), ".beat_no_val"}, beat_no_val);
    status_OKAY_wt  = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
`endif
    `svt_xvm_note("body", $sformatf("beat_no_val is 'd%0d as a result of %0s.", beat_no_val, status_beat ? "the config DB" : "randomization"));
    `svt_xvm_note("body", $sformatf("OKAY_wt  is 'd%0d as a result of %0s.", OKAY_wt,  status_OKAY_wt  ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));

    forever begin
      p_sequencer.response_request_port.peek(req);
      
     status = req.randomize with {
		  //Inserting ERROR during the first beat
		  if(burst_type == svt_ahb_transaction::SINGLE){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR during the any user defined beat
		  else if((burst_type == svt_ahb_transaction::INCR4) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR during the any user defined beat
		  else if((burst_type == svt_ahb_transaction::INCR8) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::INCR16) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP4) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP8) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP16) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  else if((burst_type == svt_ahb_transaction::INCR) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }else
		  	response_type == svt_ahb_transaction::OKAY;
     };
     if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_controlled_response_sequence

/**
 * Abstract:
 * class svt_ahb_slave_controlled_split_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction
 * from slave sequencer. The sequence class then randomizes the response with 
 * constraints and provides it to the slave driver within the slave agent.
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 */
class svt_ahb_slave_controlled_split_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Okay response weight. */
  int unsigned OKAY_wt = 25;

  /** Error response weight. */
  int unsigned ERROR_wt = 25;

  /** Split response weight. */
  int unsigned SPLIT_wt = 25;

  /** Retry response weight. */
  int unsigned RETRY_wt = 25;
  
  /** Number of cycles before the slave asserts HSPILT signal*/
  int unsigned seq_num_split_cycles = 0;

  function new(string name="svt_ahb_slave_controlled_split_response_sequence");
    super.new(name);
  endfunction

  /** UVM Object Utility macro */
  `svt_xvm_object_utils_begin(svt_ahb_slave_controlled_split_response_sequence)
    `svt_xvm_field_int(seq_num_split_cycles, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
   `SVT_XVM(object) my_parent;
    integer status;
    bit status_num_split_cycles;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
     `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    /** fork off a thread to pull the responses out of response queue **/
    sink_responses();
    
    /** Gets the user provided beatno val wts. */
`ifdef SVT_UVM_TECHNOLOGY
    status_OKAY_wt  = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
    status_num_split_cycles = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "seq_num_split_cycles", seq_num_split_cycles);
`else
    status_OKAY_wt  = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
    status_num_split_cycles = m_sequencer.get_config_int({get_type_name(), ".seq_num_split_cycles"}, seq_num_split_cycles);
`endif
    `svt_xvm_note("body", $sformatf("OKAY_wt  is 'd%0d as a result of %0s.", OKAY_wt,  status_OKAY_wt  ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("seq_num_split_cycles is 'd%0d as a result of %0s.", seq_num_split_cycles, status_num_split_cycles ? "the config DB" : "the default value"));

    forever begin
      p_sequencer.response_request_port.peek(req);
      
     status = req.randomize with {
		  //Inserting ERROR during the first beat
		  if(burst_type == svt_ahb_transaction::SINGLE){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the third beat
		  else if((burst_type == svt_ahb_transaction::INCR4) && (current_data_beat_num == 2)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the seventh beat
		  else if((burst_type == svt_ahb_transaction::INCR8) && (current_data_beat_num == 6)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the fifteenth beat
		  else if((burst_type == svt_ahb_transaction::INCR16) && (current_data_beat_num == 14)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the third beat
		  else if((burst_type == svt_ahb_transaction::WRAP4) && (current_data_beat_num == 2)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the seventh beat
		  else if((burst_type == svt_ahb_transaction::WRAP8) && (current_data_beat_num == 6)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the fifteenth beat
		  else if((burst_type == svt_ahb_transaction::WRAP16) && (current_data_beat_num == 14)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  else if((burst_type == svt_ahb_transaction::INCR) && (current_data_beat_num == 3)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
      else {
		  	response_type == svt_ahb_transaction::OKAY;
			  num_split_cycles == 0;
      }
     };
     if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_controlled_split_response_sequence

// =============================================================================
/** 
 *  This sequence generates random svt_ahb_slave transactions.
 */
class svt_ahb_slave_transaction_random_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_random_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_random_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);

      `svt_xvm_rand_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_random_sequence

// =============================================================================
/** 
 *  This sequence generates distributed random svt_ahb_slave transactions.
 */
class svt_ahb_slave_transaction_distributed_random_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction req_resp;

  /** Okay response weight. */
  int unsigned OKAY_wt = 50;

  /** ERROR response weight. */
  int unsigned ERROR_wt = 50;

  /** Zero wait cycles weight */
  int unsigned ZERO_WAIT_CYCLES_wt = 30;
  
  /** Zero wait cycles weight */
  int unsigned MEDIAN_WAIT_CYCLES_wt = 15;
  
  /** Zero wait cycles weight */
  int unsigned MAX_WAIT_CYCLES_wt = 10;

  function new(string name="svt_ahb_slave_transaction_distributed_random_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils_begin(svt_ahb_slave_transaction_distributed_random_sequence)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ZERO_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MEDIAN_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MAX_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //`SVT_XVM(object) my_parent;
    integer status;
    
    svt_configuration get_cfg;
	  
    //Declare status variables
	  bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_ZERO_WAIT_CYCLES_wt;
    bit status_MEDIAN_WAIT_CYCLES_wt;
    bit status_MAX_WAIT_CYCLES_wt;
    
    `svt_xvm_note("body", "Entered ...");

    //fork off a thread to pull the responses out of response queue
    sink_responses();

/** Get the user response weigths. */
`ifdef SVT_UVM_TECHNOLOGY
    status_OKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_ZERO_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ZERO_WAIT_CYCLES_wt", ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MEDIAN_WAIT_CYCLES_wt", MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MAX_WAIT_CYCLES_wt", MAX_WAIT_CYCLES_wt);
`else
    status_OKAY_wt = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_ZERO_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".ZERO_WAIT_CYCLES_wt"}, ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MEDIAN_WAIT_CYCLES_wt"}, MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MAX_WAIT_CYCLES_wt"}, MAX_WAIT_CYCLES_wt);
`endif
    `svt_xvm_debug("body", $sformatf("OKAY_wt is 'd%0d as a result of %0s.", OKAY_wt, status_OKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ZERO_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", ZERO_WAIT_CYCLES_wt, status_ZERO_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("MEDIAN_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MEDIAN_WAIT_CYCLES_wt, status_MEDIAN_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("MAX_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MAX_WAIT_CYCLES_wt, status_MAX_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body","Executing sequence svt_ahb_slave_transaction_distributed_random_sequence")

    forever begin
      p_sequencer.response_request_port.peek(req_resp);
      
      status = req_resp.randomize with {
        response_type    dist {svt_ahb_transaction::OKAY:=OKAY_wt,svt_ahb_transaction::ERROR:=ERROR_wt};
	      num_wait_cycles  dist {0:=ZERO_WAIT_CYCLES_wt,[1:5]:=MEDIAN_WAIT_CYCLES_wt,[6:16]:=MAX_WAIT_CYCLES_wt};
	    };
     
      if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");
    
      if(req_resp.xact_type == svt_ahb_slave_transaction::WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end
      else if(req_resp.xact_type == svt_ahb_slave_transaction::READ)begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);
      
      /**
       * send to driver
       */
      `svt_xvm_send(req)
    
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_distributed_random_sequence

// =============================================================================
/** 
 *  This sequence generates OKAY responses.
 */
class svt_ahb_slave_transaction_okay_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_okay_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_okay_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::OKAY;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_okay_sequence

// =============================================================================
/** 
 *  This sequence generates ERROR responses.
 */
class svt_ahb_slave_transaction_error_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_error_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_error_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::ERROR;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_error_sequence

// =============================================================================
/** 
 *  This sequence generates SPLIT responses.
 */
class svt_ahb_slave_transaction_split_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_split_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_split_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::SPLIT;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_split_sequence

// =============================================================================
/** 
 *  This sequence generates RETRY responses.
 */
class svt_ahb_slave_transaction_retry_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_retry_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_retry_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::RETRY;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_retry_sequence

// =============================================================================
/**
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights such that the sum of all the weights is 100.
 * Also the sequence provides additional level of control interms of maximum
 * number of non-OKAY responses to be allowed on per full AHB transaction.
 * The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_ahb_slave_transaction_memory_sequence extends svt_ahb_slave_transaction_base_sequence;
  
  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Controls the number of wait cycles: zero or a random value */
  bit zero_num_wait_cycles = 0;
  
  /** OKAY response weight. */
  int unsigned OKAY_wt = 100;

  /** ERROR response weight. */
  int unsigned ERROR_wt = 0;

  /** SPLIT response weight. */
  int unsigned SPLIT_wt = 0;

  /** RETRY response weight. */
  int unsigned RETRY_wt = 0;

  /** 
   * This variable controls the maximum number of times a SPLIT 
   * responses that can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on SPLIT_wt set.
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * .
   */
  int allowed_split_count_per_xact = -1;
  /** 
   * This variable controls the maximum number of times a RETRY 
   * responses that can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on RETRY_wt set.
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * .
   */
  int allowed_retry_count_per_xact = -1;
  
  /** 
   * This variable controls the maximum number of times an ERROR 
   * response can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on ERROR_wt set
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * - The counter for error response with value of > 1 really
   *   matters only when the error response policy is set to 
   *   CONTINUE_ON_ERROR.
   * .
   */
  int allowed_error_count_per_xact = -1;

  /** @cond PRIVATE */
  /** READ ONLY: Used to track observed non-OKAY response counts */
  protected int observed_split_count_for_current_xact = 0;
  protected int observed_retry_count_for_current_xact = 0;
  protected int observed_error_count_for_current_xact = 0;
  protected bit new_xact = 0;
  
  /** READ ONLY: Used to track the rebuilds */
  protected svt_ahb_transaction::response_type_enum prev_resp = svt_ahb_transaction::OKAY;
  /** @endcond */
  
  function new(string name="svt_ahb_slave_transaction_memory_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils_begin(svt_ahb_slave_transaction_memory_sequence)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(zero_num_wait_cycles, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
    `SVT_XVM(object) my_parent;
    integer status;
    bit status_zero_num_wait_cycles;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;
    bit status_allowed_split_count_per_xact;
    bit status_allowed_retry_count_per_xact;
    bit status_allowed_error_count_per_xact;

    int local_OKAY_wt, local_ERROR_wt, local_SPLIT_wt, local_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
      `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    /** Get the user response weigths. */
`ifdef SVT_UVM_TECHNOLOGY
    status_zero_num_wait_cycles = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "zero_num_wait_cycles", zero_num_wait_cycles);
    status_OKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
    status_allowed_split_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_split_count_per_xact", allowed_split_count_per_xact);
    status_allowed_retry_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_retry_count_per_xact", allowed_retry_count_per_xact);
    status_allowed_error_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_error_count_per_xact", allowed_error_count_per_xact);

`else
    status_zero_num_wait_cycles = m_sequencer.get_config_int({get_type_name(), ".zero_num_wait_cycles"}, zero_num_wait_cycles);
    status_OKAY_wt = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
    status_allowed_split_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_split_count_per_xact"}, allowed_split_count_per_xact);
    status_allowed_retry_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_retry_count_per_xact"}, allowed_retry_count_per_xact);
    status_allowed_error_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_error_count_per_xact"}, allowed_error_count_per_xact);
`endif // !`ifdef SVT_UVM_TECHNOLOGY
    
    `svt_xvm_debug("body", $sformatf("zero_num_wait_cycles is 'b%0b as a result of %0s.", zero_num_wait_cycles, status_zero_num_wait_cycles ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("OKAY_wt is 'd%0d as a result of %0s.", OKAY_wt, status_OKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));

    `svt_xvm_debug("body", $sformatf("allowed_split_count_per_xact is 'd%0d as a result of %0s.", allowed_split_count_per_xact, status_allowed_split_count_per_xact ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("allowed_retry_count_per_xact is 'd%0d as a result of %0s.", allowed_retry_count_per_xact, status_allowed_retry_count_per_xact ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("allowed_error_count_per_xact is 'd%0d as a result of %0s.", allowed_error_count_per_xact, status_allowed_error_count_per_xact ? "the config DB" : "the default value"));

    
    `svt_xvm_debug("body","Executing sequence svt_ahb_slave_transaction_memory_sequence");

    forever begin
      // Initialize local wts with orignal wts
      local_OKAY_wt= OKAY_wt;
      local_ERROR_wt = ERROR_wt;
      local_SPLIT_wt = SPLIT_wt;
      local_RETRY_wt = RETRY_wt;
      
      /** Gets the request from monitor. */
      p_sequencer.response_request_port.peek(req);

      // Reset observed counts for non-OKAY response types to zero
      if(req.trans_type == svt_ahb_transaction::NSEQ) begin
        new_xact = 1;
        if ((allowed_retry_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::RETRY)) observed_retry_count_for_current_xact = 0;
        if ((allowed_split_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::SPLIT)) observed_split_count_for_current_xact = 0;
        if ((allowed_error_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::ERROR)) observed_error_count_for_current_xact = 0;
      end
      else begin
        new_xact = 0;
      end 

      if ((req.burst_type == svt_ahb_transaction::WRAP4) ||
          (req.burst_type == svt_ahb_transaction::WRAP8) ||
          (req.burst_type == svt_ahb_transaction::WRAP16)) begin
        local_SPLIT_wt = 0;
        local_RETRY_wt = 0;
        `svt_xvm_debug("body", "Updating SPLIT_wt to 0, RETRY_wt to 0 as rebuilds with burst_type of wrap is not supported.");
      end
      else begin
        // Setup the final wts for non-OKAY response types based on allowed onon-OKAY response count per xact
        if ((allowed_split_count_per_xact >= 0) && (observed_split_count_for_current_xact >= allowed_split_count_per_xact)) begin
          `svt_xvm_debug("body", $sformatf("Updating SPLIT_wt to 0 as observed_split_count_for_current_xact 'd%0d is greater than or equal to allowed_split_count_per_xact 'd%0d.", observed_split_count_for_current_xact, allowed_split_count_per_xact));
          local_SPLIT_wt = 0;
        end
        if ((allowed_retry_count_per_xact >= 0) && (observed_retry_count_for_current_xact >= allowed_retry_count_per_xact)) begin
          `svt_xvm_debug("body", $sformatf("Updating RETRY_wt to 0 as observed_retry_count_for_current_xact 'd%0d is greater than or equal to allowed_retry_count_per_xact 'd%0d.", observed_retry_count_for_current_xact, allowed_retry_count_per_xact));
          local_RETRY_wt = 0;
        end
      end // else: !if((req.burst_type == svt_ahb_transaction::WRAP4) ||...
      
      if ((allowed_error_count_per_xact >= 0) && (observed_error_count_for_current_xact >= allowed_error_count_per_xact)) begin
        `svt_xvm_debug("body", $sformatf("Updating ERROR_wt to 0 as observed_error_count_for_current_xact 'd%0d is greater than or equal to allowed_error_count_per_xact 'd%0d.", observed_error_count_for_current_xact, allowed_error_count_per_xact));
        local_ERROR_wt = 0;
      end

      // Now setup final wt for OKAY response based on non-OKAY response wts
      local_OKAY_wt = (100 - local_SPLIT_wt - local_RETRY_wt - local_ERROR_wt);
      
      `svt_xvm_debug("body", $sformatf("Weights to be used for randomizing response type: OKAY_wt: 'd%0d. ERROR_wt: 'd%0d. RETRY_wt: 'd%0d. SPLIT_wt: 'd%0d", local_OKAY_wt, local_ERROR_wt, local_RETRY_wt, local_SPLIT_wt)); 
      
      status = req.randomize with {
        response_type dist {svt_ahb_transaction::OKAY:=local_OKAY_wt,
                            svt_ahb_transaction::ERROR:=local_ERROR_wt,
                            svt_ahb_transaction::SPLIT:=local_SPLIT_wt,
                            svt_ahb_transaction::RETRY:=local_RETRY_wt};
			    if (zero_num_wait_cycles) { 
			      num_wait_cycles == 0;
                            }
			    else {
			      num_wait_cycles inside {[0:16]};
			    }
      };

      process_post_response_request_xact_randomize(req);

      if(!status) begin
        `svt_xvm_fatal("body", "Randomization of slave response failed");
      end
      else begin 
        prev_resp = req.response_type;
        
        if ((allowed_split_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::SPLIT)) begin
          observed_split_count_for_current_xact++;
        end
        else if ((allowed_retry_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::RETRY)) begin
          observed_retry_count_for_current_xact++;
        end
        else if ((allowed_error_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::ERROR)) begin
          observed_error_count_for_current_xact++;
        end
      end

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  /** 
   * This method is used for programming the slave responses
   * For example:
   *  #- suspends the response of a transaction in process
   */
  virtual task process_post_response_request_xact_randomize(svt_ahb_slave_transaction xact_req);
  endtask: process_post_response_request_xact_randomize

endclass: svt_ahb_slave_transaction_memory_sequence
`ifdef SVT_UVM_TECHNOLOGY
// =============================================================================
/**
 * This sequence is used as Reactive seuqnce which translates slave transactions into
 * corresponding AMBA-PV extended TLM Generic Payload Transactions and forwards it via
 * the resp_socket socket for fulfillment by an AMBA-PV Slave.
 * The response returned by the socket is then sent back to the driver.
 *
 * Automatically configured as the run_phase default sequence for every instance of
 * the svt_ahb_slave_sequencer if the use_pv_socket property in the port configuration is TRUE
 */

class svt_ahb_slave_tlm_response_sequence extends svt_ahb_slave_transaction_base_sequence;
  /* Port configuration obtained from the sequencer */
  svt_ahb_slave_configuration cfg;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent agent;
  extern function new(string name="svt_ahb_slave_tlm_response_sequence");
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)
  `svt_xvm_object_utils(svt_ahb_slave_tlm_response_sequence)

  extern task pre_body();
  extern virtual task body();
  
  extern virtual task process_read_request(svt_ahb_slave_transaction req,
                                           uvm_tlm_generic_payload   gp,
                                           svt_amba_pv_extension     pv);

  extern virtual task process_write_request(uvm_tlm_generic_payload   gp,
                                           svt_ahb_slave_transaction req);
endclass:svt_ahb_slave_tlm_response_sequence
//--------------------------------------------------------------------------------------
`protected
&fH?2V9X.VDEL0+^W(?-ZVeETZ,C7bD,10c,)&DUdRLZ=C&B>J6K/)DET\D\Ea2Y
>JV=9BYO6M)cdD^WD0H)\bLf[NSa(2QS^UN.cX^dE[B]A0bK:.B@)?e\&&\1g\RB
eOAc_VCNLU3VCGF&#AE8F<(:;D:>ed<@QH4>=f7X;N7;Z)/Y7ZeS^L_eS)gK&7H/
OV[2.K82F=KA(aB-OWO3K.X(fbDAC0JXY?ePG\]HF+WL#6=S:1C7F1.<U/R&T#V.
&4S(=bBCNTQDOV,O/_EB0PKE/[K\81#8H^<Mg1O&0dET<K&62O&4fWGIC#\;<QJ4
e?G,ZaHR0MO5&V=23baF^VQ3:PM@,>Z\UT=f6@?7d>YMY(-B\]JU2==>Db9=cM1@
^@Ebfg#,7EF06,=T?f/8dM-M8]3+]&IgO<.;GA;]0.O7g@(:4[bTJI_-H<0P@9O_
QG?\NG-fX(O?5Qg&g]gg??80PR_W48(A<HQ_@I_3OS<fG]2:JY5W7JCJY6Qd?27+
7=-6X^24ca?THa5L1H\8B2C<)2NT<B05G>d?2Q=@N^a)+&7:/PE0I_d?Z_\7W)9-
WBLAM\[V.3/=BbaM_JaW^;=&Z/6R<\24DAPDBS,GO=>LOTJ4+/d2UcLY1_cgBU[0
&SB=add?Z&@#X(O,_?;F4aZ:e^H9&&DQ?YCSJTJ\9J(?[775<A0YdI;;XH@OC@\Z
GS1F\V;_eGO(C3e=OQ_>=SAH\J/.AH2:;6eZ:3=[MM.8L^.A2^_[67\;9;C3SQ8]
4I(EJ?,a+.JGX72Cb(4UNG-LP\4OabWgP[1P8]_6g+A<-\Z&eUQ<Z/(aV8aO;KI0
YZRNPNEbZdQH8[?9\#@02#WW9&d3:5TcPQ11F.Oa,@f_^7TDMf];CcYQ)@f5#E1E
@1H^&_Y])QD/#ZLJ7[,YXUMKWCMGWGK\_WBEPe+_F^NQG)RGR5fXHK04LW5dEf&O
^X4@dPe=cC#O:c\9/W=-+0f,Q4M@O./ZY1C3@^Qc@d[4Cb[G[7U]@JY:7dJH9[cc
P5E@gL1/(1OL3,@S6L,TDO:1]NO;I:)?(1:W)?d_[Sg69QRc\K,16Tg^bA)S>J3R
@U(2&/ZT);64f0IcCJ?[Z8;Z:QZX]WZ1\L.8(I268T>4(b\9c/7VbcJY@Y[Lcb[-
.4fLL]TC:#,^W0D<7_(d1ME9;DLa?R)&f84XeJ8TVgI@.fP[^+4eMSP6FCRK:c.5
77Q3YBJUd,6;#<eNMXGZRP0B]f3]A/d8We0MSK2/ECRgAG\cV8Od6ZXU6TebCg?Z
[9M=;Z.@KDW[JXL]d<XLM.KL2P8/7@E+P+YUJ/OZFeGY[7]CdE:,S\9d\aTSSb7=
?=&TJ\0?C&XUfUH.<V>Z\>F^4Vb9^<4E0G7MP@R<CLS,-KRBKPR^K?PTQ[d6VaEL
<QIF(O/gCAIZQ_^IF?3d+I20W)ZWYQZe8.b=LbTaW+#ae6eY=,TAEA0\CP?FWLgX
?FA1U7Z+JL\\N2M]1dV&e#S3Na?5D&MB,E2NO7326,)?^7D?N(>/BIbHc1-F@eFE
L-5C2gcJbP/W\-fR3S<&g/beACK^J]&-L8HF&XNA;TAd[AbUWLV+[<MZgP+NJ_5R
^>@D2_e+<aQL?@1)a36,)#Z3O:#SHSSb+X9N_K_3c:_OD-fK1Uc+>I;TPR^0)ABJ
2ZJb]CMgeC-E8QbMOCN#TUZfF+=,U(@3ELE_K>LE&I0R]CT[JGgR,3FL?J/.X\VA
[5e4^WNXX#8R22D;cO_^M9f36&D:UWSbMVA;9,UM]0SZSF^eY+-(8_PA9N5P^,NQ
e>cJH;T7((R=/^M5(T]>Bgf19;?W4FHg9P2:e^2T,RY8AQc&Y>U_-b0^JSLccg_b
Ha_(20JXQ[[91dIcH@LU9g#bQI?Da=QU^901_Z7^_E7O#A]6a;Y^)>T27L8HQYA,
-Y91c8TKMXeW2&F:]R0FOQ-NDW.T<^/C23c+U=3<NP81cPB.b_fLAY502aWCE5-=
,:MI_cEI4FcD_b@[2aD@b0eGOE3a=A)&=/fd\,>W:O)ceP0FAD,H6+-23Dg=_/Pc
#H=a1/?C_T@3#OfBAPQE[/;9f<9[\EJ6/La@JH2<A=IRNQe@M8>@MZA5UX=67Og_
F+DZ@CY51UY>W0HZYB6Vb>9eY=,IS>=8I/LNa]1@024RS?N#^@/RBCY&[Gf)R/Ig
M)b[F61]?#cd#B3VS9Q1.7+X62U9cRc/+:dc&ScN(4^Z4EPb/fCJaeVC1J7MB-S0
Y662df1:74640]#;.,EEOgf0+Z=f(#,9_EYc1+F<S8Z39+(0f=]gY<bW]PV2&/3a
<f_+(XUQ7:Y<>\,e+WP59UKcC/cU(;:e4JEH/g36ed(Z\N;#=WWb<-[:Z64bNKLc
DU1CO_RWa4P\D71JQY)]J(+1COUYO]RRH=D>6b1#-IT7E1>SQMLE5f5OgV_//\;G
S\4L>Oa&d:#EPVHOVOZO[O)L[S9OT)U==fEc6REM>)Q5)/)9+)?.b3=eE7F^WW9V
c+LX]_CZ;Z54>XbAD?]GS:@8fX.X/LH.&)3YV7PVfBZ7KJb:e.2:[60_\c-<MIZ8
L=WH==MZecVR6[F]E;:>Re;^McU3-b/b;Z-ZdPGRJcW:4.[b<A-@CeNB<K/KAe/3
]#]e7CMHLM8[_6RMO2ARS6;QL#1YAb5O?.9COgJT6D>8(N9X9?\#273+JTSB/6<Y
ec3FUG<7LM?Z[9O&e43gPOGTfHbVV3OC+X9@E+AB=&UCe=6HA?AZAZ2@H5;YEX8A
T+AA\McESIgMTc(H0Q#U.Ae/9Z[.N/:3BZ=]NXWFT8L[aEM2<Qd1]/CUJXKgc>S7
]43=M_[:83W4QYII[>]LS:/e3<+<52Sc46<_CM&>MQKNPU3SJ\5+;XaA,-;e+OR#
?UG0BIZ3V?WddQ4I]RH(Zg5SQ\Wb)bBXR82]G86K4Pa-^,9]SL7ga?cTO7=_COf;
g#E3MGc2+d9UJ,7.+S6TPXe5c+C78-KKf3K0<YFfQK6K9)^@)X_I#f4XH+f\4G//
@RW.gILZU;+5ZF:<08;e)N)fEUe9fKWS+#2R:b9EcISf)CB8)F#e(YVKdWI;5K0c
CY)N6/7O0,2]0@D6#6-BJ+=B;Wgf_QDH.+:c3Y@)A2f.<2#^[WFLc1[P.LWGH4F=
-@Y)Y^ab(],+/,07Eg/S+Cg><;TGDN;&\QL081B-GY)QgI=PeJA+c]V1Q^JZ9+KI
>,VcL\1Mc.N9V;(J^.0#SCM[N^8I@Y[cQaUB(AKSbI3ZP[@G(ST+3O/6>]-WWQ\^
^-6Lgbd4CG//00\JbYO2eWE0TDcACc.daR1.C6,H?B]LCd=6F.gS.[6;cZ?ZS]T3
L)8-JbBI[CRQ5?13:\H08-<8#/b<@#=DgHG_RTCbC80bBe>>I>2=82XMag^BN@ZK
-?&f>cLSd/,=MOdW<)dAaY.,15IR#5gf1/E^1N_9DU>I)E2]dC>,)\1aAH@E.=+L
175P:4ZW6A(JP\fZT<b/9+4543DT,MH[YRTZYYfUZ\-6;&6(YUN\Pe4F7,)YE38B
^N>KEVI2S0J23BNBLA\A:P>-/NAd6=K59cSfEYF=I08M(^5?(/&EB;bHcTaJ(M&/
+^NP2JK]W(OSfT.@beQFNAdBe7LVF3cH9fObgTNM(&O[5-3;2MA5;^DEO[)AgeU^
?7Y3]9-)I/XAJQ@ef04Lebe-ag?CY_QKZfTTR=Fg5[Z/W;MV(@]#WMBbb8+[g2..
X^\]L<(GKIPRdGF67;5\+>K@/:,[HQ7e22Y/;#W2=JCd<0^BP9\YI7.8@[LYQTe0
6H>AJ.[1@Mbc95FWFHH^NI6cVg_8;SN34Y;FSX#I1,RKPNPfJSFZQW.d2DUS52gR
^;=2;Y[#\#YD+MJA0[Q;#gD=WZD6f5;6V8gG1c@#WGI05<.Na]OMV2BbKNVZ(H+<
^R@W7.(\M1(IYDCHMYc>L-#D0dI]CgOe9X^G?be?bAO0+16#Pd^R&b-E1#>ZDc)[
)gJV_]4BJOD.\aAL8K^=gK/W#gL=KF0KFS0\>VeW5J;)M_@)b=XPWS/>.&A(g_N<
09LS(_4RZ<(YC^HD6]N(@IT0a@HXNW)W80IIb\IJOA@D?#]N;e,AUE9KHM@]^75=
A(J3c5]LbX<\^9d1,LGg^/GZ^E3fF3g/_4.[M-]7@KO[V=D#B7OD7?01c@QR.LM+
H)c#f)WeFU#Jgce&M/5QZH,0c,]XUN7P1[)A]\AA>7E=Q;1Be^PM/b2WEP.6fL.)
B([K5bb1L?+dgXL171GT:..]/ZT9XUA>>UKB=LDO>P:L+&QE)2aS2:2<AFGM#.Ha
39H>dGJG+/RTC4)e87PFWO6=HSb;FW?_NL?2;Q\g//TcCN91HR+36>4YI.ZfR8BA
G9WZC+J:9BRGMY9U?a<1]faeKNgMI&-.-6+0U(M&CI1Z&bXgI4?D1T51B,90XZ.g
^XVJL8S4#LP&20+DQM3(-1Q(K8T#_JbQ\3XTaXQRB4?G^+M=>f=RV-974U0G\:.X
cd8</dd9\_BBRN=6T?.fF.MPaRGRGP#a)gDZg]:&2Y2_^K:W&:+342^X&7d9]LR-
a>/0SHRGb@c,MH/DOX1OIU1<_=8^)5W[[B6Ma&](cYDKJ3O#]-XMHgQ,9gfGd6G+
F@ePIR#YWH-,/[0DVA5[<PG&@\=TL?<f=TJ7-CU5:N03g[V[08LB;ZH60,C7G/EJ
PK6^#X&6dfM+EY4>\UaOOEJ)64V0S7E4VS#g2W,R?Y4@RJ<HUX>K(0-^&<O:YFff
M9S3a&0Lef[IU46S^/GXgbK#+2O)EC5AY9&2WP;RU38=,bN084[+-8.e/1=Ke<^I
cE+]CJV[2(^PN;DWF=]V:gQN2O<X>Jg?K(Z+[^1&02/2\Bg5,QV]A_eY?@GU/](+
c)RcL0QBVf0+7-AK9W>TXL=0gR4G5_H[<cg,gd8IIUD6XD6+(2ASXg9Z+8;7AU6]
0b/Kg5cQ=T4)0W_T#3^52Jg4;H:^g.GdRU1+JXbbTg1UZ/[X?Z^ce/MJ4eRFK16<
,0][;.1DMNbJ[aECLGdT+_;L#E+fg];g&>7Rg5_FD9K9NI4W#c,<fNeTgKg5BCO7
=R(ZE4M2g,6/b.D@&^Q,&Q>9T]DMQ63b\-L2W;QMNPJG&_SCELGEQH+bUgU5^U3g
(&.3+^f_1,&B&_c83YC?SPV[7ZQQ_SF)U]#7\-_Kf^aS?-K@F#=JJ]WP[TI2V[SN
.aP^(0P:YELH77,d=?FB9/+M-XBS>#,0ZEQ4BGW=KeK^OM78[faEb_Q+4fFBTBGg
7d2G[D^Y0V:gSgD0e1Eae.?-,8@G6ZJO>\<Nc>N_#YDW@2X\F/?:])46F120T7ff
XN&6c(2=5G&XTG>LfO@8J@)@^P@0#2ZFXW/PC,3;c=f<V?>=335RIag@#)g9]@L[
=?^H09e>&c,_V?N-c_3YV3(M2Q4WMfNP0;CF=G\F+JQF)Z6dFF+;<@3YJT8;d\52
,cII=aZ@RdVfQXES-YQH0ZJaPFC?TRJUT.)&I\FQVU_==CVT[;FZR)LI5:JAbP+,
g\[-;F]Rd=b/C>U3HK^W#ZE7+/.)W-2a/0_-[-DDQ;BU^TUR)CbJM3=/\f+aY][<
MKL^EUd=9a/e#\ZaP-:&2d3V#@S#E\#R4CcaHP]/+c^5-.ScK-b1WD]JHP>JYL6\
RTQZTT]CgU#<946W&SQ9FOVA#S2D+BFY]1(e>d2&<=QV/,5dYUJN-O3ceL67W-\B
14:GE3Ng-?CIA6baSa2g^==(FFJ;I=^DBH0SbJ@GJfa#SBL)WbPb\1@&/\-B>.5g
4T?Y_bU6d-PPMHV73B1U#?[\E\D_RE\)S6d)EDfJU4MQDWe9;_W?,#)^KVEW,?M.
=-5=9=bJG(E9eB_Z)4GWNK_IK[c2Yb)3V;HSNDFK]8&;=J>\[cORL6QQf:EG,05a
1N8D??#06JE+YfJW9:M).Y=,]G1Ld?SEHA)T(?3B0LSRE/a[.&.S6ICO11f_QHU<
;,QGCMgZ?J2P[.>fCcY>7:N)H)[XN([dcY@&7B[c1P-/?E)RP-1NG=G#A_15:b8V
.H@C2A@g/T/>(WD8>IN@_8C)g,-Q.WWa8-Jg7<Ff:=ASZKS-6V\])J,d,Z]M8-BQ
DA.:&<-Eb>dQe4VfP8,fTe>IUPJVbG)3K&R;QKG@&SQA@O0UR^134I;/0^ONM&4P
@D23Z44FYNX-/:WMRFbE(AK(VC(gbK6@ZGK(dD1WJB[#<D;e^X]1JDK(#K(AGE]J
Q((WgM.1<A]T?Z8K3B-dY68^cQG.D&_4@8OC5FMaP(>/d2A::+E@.@N[fE#TfZ5@
eARIKV0fEZbX?Q8EGc<0_@R@XA(Jc#YY>Y4FC_C?EZc;+701PL^;I5V9-e0T)Z@[
)I8442<HQAOUc&\+WHX)-#)@Hc1[&48ZDOfB[Kb[eX[fVa>T\&fK4?5bX^d7W?Af
bdB\AMW7[PAE96^]7P00;@4d85g4(#H^KI_Zc&<(VZE[/AY)MIbRL=O8.CC>#X^,
J_D,,J/H8D7&0XOX3]ZS1W8@DQ-1-FMe,/P:L:a1=d3aC=+^&-FT+;KfeUHPS+IE
&+OZ:FCfeC1_ZG-^ZU-A9fK8#Jce.)UbU]KGOQ)bP5#gY3eb+ffDU\_,:=KGVb:3
@Jf7&O_EL:.H75e]9[\2e.>#9TMX]de-:MHJZKV+ZN=;ZB)?^G.I8f72.-OZ,6?N
@]#71d>R5)3MSX^VAB>0W]G),HbUYfG_\DbVMU;((WePYX\G&cf\e;GXVQbd)&d\
)CI8dY/T=)NG4WU&YXZW;E^)YT.Q)ADO=ffV-2Y62Q>5(>-9VFM@+0c,U-PAW86C
9HQI,6DJ[U57g1_N\4Y]E1C=.EQFE,fNbY6,a_Me(2cCQ[4#9:g_-g2.WV+]bSg:
6(HPea5JZ]9e,:@e9S4g)R]Lad4gRfC8WZ\[MfT/KNK37RSc8;=E7.Vag4Re+\Q(
L#KIDZ]ba)S@Db5f/B0>_9CB:GYG.KH5IJ@?dHDQM?CNcRU?R3ZCFcg66]]Q/C+<
A?fQ(MM>UW2@+$
`endprotected

`endif

// =============================================================================

/**
  AHB VIP provides a pre-defined sequence library
  svt_ahb_slave_transaction_sequence_library, which can hold the AHB
  sequences. The library by default has no registered sequences. You are
  expected to call
  svt_ahb_slave_transaction_sequence_library::populate_library() method to
  populate the sequence library with svt_ahb_slave sequences provided with the VIP. The
  system configuration is provided to the populate_library() method as an
  argument. Based on the configuration, appropriate sequences are added to
  the sequence library.  You can then load the sequence library in the sequencer
  within the svt_ahb_slave agent.

  The user can also add user-defined sequences to this sequence library using
  appropriate UVM methods.
 */
class svt_ahb_slave_transaction_sequence_library extends svt_sequence_library#(svt_ahb_slave_transaction);
  `svt_xvm_object_utils(svt_ahb_slave_transaction_sequence_library)

  //Required to allow new_item() to have access to the parent sequencer
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  //Removes all registered sequences from this library
  extern function void remove_all_sequences();

  /**
    Populates the library with all sequences as defined in this class

    @param cfg User is expected to pass a port configuration to this argument.
    Based on the port configuration, this method adds the appropriate sequences
    from the svt_ahb_slave sequence collection to the svt_ahb_slave sequence library.
    */
  extern function int unsigned populate_library(svt_configuration cfg);

  extern function new (string name="svt_ahb_slave_transaction_sequence_library");
endclass

//-----------------------------------------------------------------------
`protected
1A(#\NQ#KGT43#fPKLQg=^,+H2M@)MK[W&?7T^7AWO:TIfb,?,=F1)g.5KKV4KAZ
]g23#U:[YUIaJ@H2K4I:4_0DK16]W9E>THe?#78<[HK96-b&H&CN?;/UYd;b#gAb
;#2VL8edE:AC\]YB=2aQTgJ.XDH0]#[X:FU^.CHFS(aT3->#c],)]&eP2-\_&M?9
(bcUVX23<?bdVQB\C1Z/<A&07_(TNFNb:Wf7FX8NYO-,@e]DdD.HB.P7,GQ[Db>,
,e,Y.O,]>TTXZeWLSECb&6fTVPMVFe/RCCPY1KA@?J-TN-5]>,LB?FO0Yc7@>+O3
^UR8SW=OUX;D;=b)L>=(<8?P.ZGEJ5NfZHd8L)bAd0SQ()4.dE8OL<IK1d(&cF)b
g3dbXeZ8<Cd@.S0H.XK422D6O_\HR@,a?THW@EDE7U,JH1SI/48SHLG8VU?;O69e
LVH:/>060d1(;-7F6<V;Q-dUcG8;Be49;N5+6a7>bI76=\;e,dQWLG7e7DQ\JH&J
GeOK0#M5FMVA502=H25_^Vc9T6?Nc/W_(N;QL?5MD+;Zb..Pe8B;OL-+^O>#T.VR
D7K6SRd,)R_-F45N4WD=41]TG0Y<V<\4>.WQ#3)RB(U1U+P8R;38VOg)_20B&R1.
,5ZU(71A-B^YP_2[@J@b-\bT3S6\I)T43<?JB.dcFU5VTY?G_4=<QC)d]-;a9:>I
\K>1[8g.?0S9FS=]PG=UC=,R.?7(O/RJ@fULSOQ8,<0;L^1RbcdaCUJ=+H.JK<G_
O;+:U?eHa>##^V.##9eDEg(8D7W.TdNaMeR\T,5I(]WO3P&O]Z6T2:36eX.B=G+[
NYFdS4?PCSCOb]I)^\9N8cQAZ\Wd6e#d,A_K3OE1]B,VJZIBD[La53bHJ61<K2)4
.RW8KYZbfAc)1#;E9H1gdD=ff4<#(G.U\[T_NFbPHJgOCYX]G[R@g\VbDZM0LX?6
C65E^ORLD25LdbQ@Y/M_I(/eH4=bg)EF?2aLK>Z^J.FYCT&aRA_1Z#8S7dTgZW4@
:O0UK19I9^27c.c>V47VW4<5[eAVK4NWIN2XDP_2X3c>f<F0WX10]e&d98&)DVQ)
R3TV@@2XZ(,&SPM()2:Fedd[H)BSG4/_d:7GcNDgB6@cf?P#0Z=F(-1>6?+FT6fI
OEQD\1NC?O^+R;FJL#5SWd;Z/2UJ3W0b>&SK(\H9L_P]2IYDU(S^,94\bZM-JZ]F
Y/#0)7UVZY)T[T5]L&U^ePIEfUL)d(J+CUX?&@^MgEEH+]ED@c_A&3bd3I&UK_X]
136d=[2^/9BNc+Ng;D6BL<D1SN;D?[2D5YbTIeJIXa,#d#&G/F,A5TWZZSdJI[E_
JH>WIJK<g/OL1064]-EGa[HFK,bLE5Y3IWgZKUdJZ=81]aT2;Ma:IfS0LcD0]^.^
+.WfB;XH>DG#(Q3\_JffC],@[KO]L)30><W0ZX][3XD&,W?5=Y@;g,=54HDW9VJY
b6YUKV;,K7Jb8VFD]G65+:EK.-1CK#O5Rg@^aJdC&M5W,#gESBfW1K^MQOD=AV/3
C/:^-=[/U5^P747?U(:?;0<geWcU;V^c.6.P8JO2L^eVM0ZN5B1@C[G@-4NM@e->
BZ[AJP:7<894HeX@_5QCdHP_a^C^3W/?EF<P?W+3afI1#6-aLN^gMaeS]C<@Fe27
4\TdX&./;M.UCM]<I&WZ-gGH?RG,)LI>DY/XCBA4L+UT;CM&Ef9R+=81)RKQHVM0
O@YR1PAa9\V\L]M]NO-d];GH1$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
