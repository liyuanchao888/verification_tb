`ifndef GUARD_SVT_AXI_IC_MASTER_SEQUENCE_SV
`define GUARD_SVT_AXI_IC_MASTER_SEQUENCE_SV

/** @cond PRIVATE */
// =============================================================================
// =============================================================================
/**
 * This sequence generates requests to external slave. This sequence
 * gets the request sequence item from ic master sequencer, randomizes the
 * request, and provides the randomized request to the ic master driver.
 * 
 * This sequence runs forever, and so is not registered with the master sequence
 * library.
 */
class svt_axi_ic_master_sequence extends svt_sequence #(`SVT_AXI_MASTER_TRANSACTION_TYPE);

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  function new(string name="svt_axi_ic_master_sequence");
`protected
YM3U/7,QILP>,=a#3Y84DYaCYgHb@MYXR(@?6&e1]E3ZV#1H#UN-+)7NOg(]+3XW
&HJFQTB[5[f0_</dc?TWc9M04:;>?NP:(K?d6dD+)@NZB$
`endprotected

    set_response_queue_depth(-1);
  endfunction

  `svt_xvm_object_utils(svt_axi_ic_master_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_ic_master_sequencer)

  virtual task body();
    int rsp_cnt = 0;
    //semaphore rsp_sema = new();

    // Fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      `SVT_AXI_MASTER_TRANSACTION_TYPE ic_master_xact;
      `svt_xvm_verbose("body",$sformatf("getting request from req_port rsp_cnt='d%0d", rsp_cnt));
      p_sequencer.req_port.get(req);
        // Fork off a thread to pull the responses out of response queue
        //fork begin rsp_sema.get(); get_response(rsp); rsp_cnt++; rsp_sema.put(); end join_none

      if (!($cast(ic_master_xact,req))) begin
        `svt_xvm_error("body",{`SVT_AXI_PRINT_PREFIX1(req),$psprintf("Expected transaction of type `SVT_AXI_MASTER_TRANSACTION_TYPE, but received one of of type %0s",req.get_class_name())});  
      end
      else begin
        `svt_xvm_send(ic_master_xact);
        `svt_amba_debug("body",{"After randomization", ic_master_xact.`SVT_DATA_PSDISPLAY("")});
      end
    end
  endtask: body

endclass: svt_axi_ic_master_sequence
/** @endcond */

// =============================================================================
task svt_axi_ic_master_sequence::sink_responses();
  `SVT_AXI_MASTER_TRANSACTION_TYPE rsp;
  fork
  begin
    forever begin
      get_response(rsp);
    end
  end
  join_none
endtask

// =============================================================================
`protected
Y@_Y7cL+IB#?[N><>X[RWK5IGTfCa@-R4g,Q5\6@MKEDZZ8J)S+#5)1.(Daa<-D.
(^[MdHcQY?Z?*$
`endprotected


`endif // GUARD_SVT_AXI_IC_MASTER_SEQUENCE_SV
