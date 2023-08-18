//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_SNP_BASE CHI Snoop transaction response base sequence
 * Base sequence for all CHI Snoop transaction response sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_SNP CHI Snoop transaction response sequences
 * CHI Snoop transaction response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================

/** 
 * @groupname CHI_SNP_BASE
 * svt_chi_snoop_transaction_base_sequence: This is the base class for svt_chi_snoop_transaction
 * sequences. All other svt_chi_snoop_transaction sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_snoop_transaction_base_sequence extends svt_sequence#(svt_chi_rn_snoop_transaction);

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_snoop_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_rn_snoop_transaction_sequencer) 

 /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

 /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

 /**
   * RN cache for this agent
   */
  svt_axi_cache rn_cache;

  /**
   * CHI RN node configuration
   */
  svt_chi_node_configuration rn_cfg;
  
  /** 
   * Constructs a new svt_chi_snoop_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_snoop_transaction_base_sequence");

 /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it:
   * - shared status 
   * - RN cache
   * - RN node configuration 
   * .
   * It is required to call this method at the begining of body() implementation.
   */
  extern function void get_rn_virt_seqr();


 /**
  * Wait for a snoop request
  */
  extern virtual task wait_for_snoop_request(output svt_chi_rn_snoop_transaction req);


`ifndef __SVDOC__
 /**
  * Empty task so that base class implementation that raises
  * objection is not called. Objections should not be raised in reactive sequences
  */
  task pre_body();
  endtask

 /**
  * Empty task so that base class implementation that drops
  * objection is not called. Objections should not be raised in reactive sequences
  */
  task post_body();
  endtask
`endif

endclass

/** 
 * @groupname CHI_SNP
 * svt_chi_rn_snoop_response_sequence: 
 * - Provide a coherent response based on the local cache in the RN instance.
 * - This is the default snoop response sequence registered by active RN agent.
 * - Class svt_chi_rn_snoop_response_sequence defines a sequence class that 
 *   the testbench uses to provide snoop response to the RN agent present in 
 *   the System agent.
 * - Execution phase: main_phase
 * - Sequencer: RN agent snoop sequencer
 * - The basis for setting up the snoop response based on snoop request type is as per 
 *   ARM-IHI0050A 5.0: 4.7.5 Table 4-11
 * - Following are the attributes of the snoop resonse that are set accordingly, based
 *   on the Snp Request type:  ARM-IHI0050A 5.0: 4.7.5 Table 4-11
 *   - svt_chi_snoop_transaction::snp_rsp_isshared 
 *   - svt_chi_snoop_transaction::snp_rsp_datatransfer 
 *   - svt_chi_common_transaction::resp_pass_dirty
 *   .
 * .
 *  <br>
 *   snp_rsp_datatransfer  Data includes <br>
 *    0                    no <br>
 *    1                    yes <br>
 *  <br>
 *   resp_pass_dirty       PD <br>
 *    0                    no <br>
 *    1                    yes <br>
 *  <br>
 *   snp_rsp_isshared      final_state <br>
 *    0                    I <br>
 *    1                    anything other than I <br>
 *  <br>
 * 
 * Wherever there are more than one possible values for setting of these response
 * attributes, the response attribute values are set randomly.
 */

class svt_chi_rn_snoop_response_sequence extends svt_chi_snoop_transaction_base_sequence;
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_snoop_response_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_rn_snoop_transaction_sequencer) 

  /** 
   * Constructs a new svt_chi_rn_snoop_response_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_rn_snoop_response_sequence");

  extern task body();

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KRWeURRwK7x8OlwjrRxcwKcmZGqmyNupHzYhOjsM4VHdeeN9cG8D8o/n98pbE9rO
MviGbv7B+MadBRAZUJp8L0ZNspsqa6euJdf05I0LzhdMnSjWAsp2JZOFx8m7rDBg
4CCOWQxbFZ5VlFlC+g1wJKr75VTPC3l2se0kgCkIalg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 446       )
shy2dRqpMdWwtx5AhXNV8SQhIgvneu9Z3hv1/KfZBlbXljCIw04/12jBr6PKZBlN
ucdwYQytYxhUd6EAskyLgtbfM1k5Hrs/7iGBmXwKEyTUZsZY9X76ljv5kp0ZwDfD
RVarXrBSKhD7YOpV0dLcenlYWUElxVyLDCtQ10ihkLqUTfhHDrlf7G53rK8w0kB4
i3k8UOkIa77qDTH1JnkRpj7K2x7FPth0wXegRxt7f6akVfQdf++YcFIKU+cb/X9o
9ThL9/oh4VDkaQ7/gZu8TlDfFtrdIboXk97gpksSbbDvhspfZilCyA/5M4PcP70D
h84gWwNpjf36Y12yCRMOBbMzgOqu3+uf/iD/cNXEX5G1g3k3eCGeZ2gZmPXhTdjU
OELD6f2bOF+4fxzZDSQvXc7ih0p+jLucG1WGY1itfLLk0D2D6sXzLzoON/k027I4
rFDiIY+UkVlN33KG7rPiYHwvuYKODt9Y27gjIvH6ZihPhll5SaCuP/a1KMKyXEW+
fozJgDNHy4H5P17JkcwnTxpHSgeYvLS8gZBgJUtWIMXe1MTo1SPX7OVkiYR9ysSm
tvTh2sN30/ih3Mqk+KtCxw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
A+MGaRqGtgdEv3+E+xfJ3EXIysuEuHx20iGK2ZKb5D+DnZ3iXM4Tff00iKNIWIpl
TqSvWHgtSLgGIT60Rhfw6tta/lyAPMUI89zSSGkviN4au0jBRtDqJQ0fVLGB4UFp
pdKFF6bUCcRlkRFSsLMyy/TXhuz7CVzq+ogxRzf1Qfo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2291      )
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
`pragma protect end_protected

// =============================================================================

//------------------------------------------------------------------------------
function svt_chi_rn_snoop_response_sequence::new(string name="svt_chi_rn_snoop_response_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_snoop_response_sequence::body();
  `svt_xvm_debug("body", "Entering...");

  if (p_sequencer == null) begin
    `svt_fatal("body", "The svt_chi_rn_snoop_response_sequence sequence was not started on a sequencer");
    return;
  end
  
  get_rn_virt_seqr();

  forever begin
    bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] aligned_addr;
    bit is_unique, is_clean, read_status;
    longint index,age;
    bit[7:0] data[];
    bit byte_enable[];
    `ifdef SVT_CHI_ISSUE_B_ENABLE  
       bit snp_cache_poison[];
       bit snp_cache_fwded_poison[];
       string snp_cache_fwded_poison_str = "";
       bit fwded_poison_rcvd_flag;
    `endif   
    data = new[`SVT_CHI_CACHE_LINE_SIZE];
    byte_enable = new[`SVT_CHI_CACHE_LINE_SIZE];
    
    wait_for_snoop_request(req);
    aligned_addr = req.cacheline_addr(1);
    if (rn_cfg.chi_interface_type == svt_chi_node_configuration::RN_F)  
      read_status = rn_cache.read_line_by_addr(aligned_addr,index,data,byte_enable,is_unique,is_clean,age);
    
    for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE; j++) begin
      req.byte_enable[j] = byte_enable[j];
    end
    void'(req.randomize()); 

    if (req.snp_rsp_datatransfer) begin
       for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE; j++) begin
         // If clean, then all bytes are valid, if dirty it can be
         // that only some bytes are valid (ie, UDP state)
         if (!is_clean) begin
           req.byte_enable[j] = byte_enable[j];
           `ifdef SVT_CHI_ISSUE_B_ENABLE
             if(byte_enable[j] == 0)
               req.data[8*j+:8] = 0;
             else
           `endif
             req.data[8*j+:8] = data[j];
         end else begin
           req.byte_enable[j] = 1'b1;
           req.data[8*j+:8] = data[j];
         end
       end
       `ifdef SVT_CHI_ISSUE_E_ENABLE
         if (rn_cfg.chi_interface_type == svt_chi_node_configuration::RN_F && rn_cfg.mem_tagging_enable) begin
           if(read_status)begin
             if(req.data_tag_op == svt_chi_snoop_transaction::TAG_TRANSFER || req.data_tag_op == svt_chi_snoop_transaction::TAG_UPDATE) begin
               bit[(`SVT_CHI_NUM_BITS_IN_TAG - 1):0] cache_tag[];
               bit cache_tag_update[];
               bit is_tag_invalid, is_tag_clean;
               string tag_str;
               void'(rn_cache.get_tag(aligned_addr, cache_tag, cache_tag_update, is_tag_invalid, is_tag_clean, tag_str));
               if(is_tag_invalid == 0) begin
                 for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE/16; j++) begin
                   req.tag[j*`SVT_CHI_CACHE_LINE_SIZE/16 +: `SVT_CHI_NUM_BITS_IN_TAG] = cache_tag[j];
                 end
                 if(req.is_dct_used) begin
                   for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE/16; j++) begin
                     req.fwded_tag[j*`SVT_CHI_CACHE_LINE_SIZE/16 +: `SVT_CHI_NUM_BITS_IN_TAG] = cache_tag[j];
                   end
                 end
                 if(req.data_tag_op == svt_chi_snoop_transaction::TAG_UPDATE) begin
                   for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE/16; j++) begin
                     req.tag_update[j] = cache_tag_update[j];
                   end
                 end else begin
                   req.tag_update = 0;
                 end
               end else begin
                 req.tag = 0;
                 req.tag_update = 0;
               end
             end
           end
         end
       `endif  

       `ifdef SVT_CHI_ISSUE_B_ENABLE  
         if (rn_cfg.chi_interface_type == svt_chi_node_configuration::RN_F) begin
           if(read_status)begin
             bit snp_cache_datacheck[];
             string snp_cache_poison_str = "";
             string snp_cache_datacheck_str = "";
             bit poison_rcvd_flag;
             bit datacheck_rcvd_flag;

             /** Poison **/
             if(`SVT_CHI_POISON_INTERNAL_WIDTH_ENABLE == 1 && rn_cfg.poison_enable == 1)begin      
               snp_cache_poison = new[`SVT_CHI_CACHE_LINE_SIZE/8];
               if(!rn_cache.is_poison_enabled())begin
                 `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("poison is not enabled in the cache. Calling set_poison_enable method of the cache ")});        
                 rn_cache.set_poison_enable(1);
               end
               if(rn_cache.is_poison_enabled())begin
                 poison_rcvd_flag = rn_cache.get_poison(aligned_addr,snp_cache_poison,snp_cache_poison_str);
                 `svt_debug("svt_chi_rn_snoop_response_sequence",{`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Address =%0h holds a poisned data with snp_cache_poison_str = %0s  ", aligned_addr, snp_cache_poison_str)});
                 for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE/8; j++) begin
                   req.poison[j] = snp_cache_poison[j];
                 end 
               end 
             end  
           end
         end
       `endif  
    end

    `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(req.is_dct_used) begin
       for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE; j++) begin
         req.fwded_compdata[8*j+:8] = data[j];
       end
       /** Poison **/
       if(`SVT_CHI_POISON_INTERNAL_WIDTH_ENABLE == 1 && rn_cfg.poison_enable == 1)begin   
         snp_cache_fwded_poison = new[`SVT_CHI_CACHE_LINE_SIZE/8];
         if(!rn_cache.is_poison_enabled())begin
           `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("poison is not enabled in the cache. Calling set_poison_enable method of the cache ")});        
           rn_cache.set_poison_enable(1);
         end
         if(rn_cache.is_poison_enabled())begin
           fwded_poison_rcvd_flag = rn_cache.get_poison(aligned_addr,snp_cache_fwded_poison,snp_cache_fwded_poison_str);
           for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE/8; j++) begin
             req.poison[j] = snp_cache_fwded_poison[j];
           end
         end
       end  
    end
    `endif
    
    begin
      string rsp_details, data_details;
      rsp_details = $sformatf("Response: isshared = %0b. datatransfer = %0b. passdirty = %0b. ", req.snp_rsp_isshared, req.snp_rsp_datatransfer, req.resp_pass_dirty);
      data_details = req.snp_rsp_datatransfer?"":$sformatf("data = 'h%0h. dat_rsvdc.size = %0d", req.data, req.dat_rsvdc.size());
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), rsp_details, data_details});        
    end
    
    `svt_xvm_send(req)
  end

  `svt_xvm_debug("body", "Exiting...")
endtask: body



//----------------------------------------------------------------------------------
/**
 * @groupname CHI_SNP
 * Abstract: <br>
 * Class svt_chi_rn_directed_snoop_response_sequence defines a sequence class that 
 * the testbench uses to provide snoop response to the RN agent present in 
 * the System agent. <br>
 * The sequence receives a response object of type 
 * svt_chi_rn_snoop_transaction from RN snoop sequencer. The sequence class then 
 * sets up the snoop response attributes and provides it to the RN driver 
 * within the RN agent. 
 * <br>
 * Execution phase: main_phase <br>
 * Sequencer: RN agent snoop sequencer <br>
 *  <br>
 * The basis for setting up the snoop response based on snoop request type is as 
 * per "Table 6-2 Snooped cache response to snoop requests" of CHI Specification. <br>
 *  <br>
 * The handle to Cache of the RN agent is retrieved from the RN agent and following 
 * method is invoked to read the cache line corresponding to the received snoop
 * request address: read_line_by_addr(req_resp.addr,index,data,byte_enable,is_unique,is_clean,age). <br> 
 * Then the output values from the above method is_unique, is_clean are used to know the
 * state of the cacheline. <br>
 * The state of cache line is used to setup the snoop response attributes based on 
 * the following information: <br>
 *   is_unique is_clean  init_state  read_status <br>
 *     0        0         I           0 <br>
 *     0        0         SD          1 <br>
 *     0        1         SC          1 <br>
 *     1        0         UD          1 <br>
 *     1        1         UC          1 <br>
 *  <br>
 *   datatransfer  Data includes <br>
 *    0            no <br>
 *    1            yes <br>
 *  <br>
 *   passdirty     PD <br>
 *    0            no <br>
 *    1            yes <br>
 *  <br>
 *   isshared      final_state <br>
 *    0            I <br>
 *    1            anything other than I <br>
 *  <br>
 * Following are the attributes of the snoop resonse that are set accordingly, based
 * on the Snp Request type: 
 * - svt_chi_snoop_transaction::snp_rsp_isshared 
 * - svt_chi_snoop_transaction::snp_rsp_datatransfer 
 * - svt_chi_common_transaction::resp_pass_dirty
 * .
 * 
 * Wherever there are more than one possible values for setting of these response
 * attributes, the response attribute values are set randomly.
 */

class svt_chi_rn_directed_snoop_response_sequence extends svt_chi_snoop_transaction_base_sequence;
  /* Response request from the RN snoop sequencer */
  svt_chi_rn_snoop_transaction req_resp;

  /* Handle to RN configuration object obtained from the sequencer */
  svt_chi_node_configuration cfg;

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_directed_snoop_response_sequence)
  
  /** Class Constructor */
  function new(string name="svt_chi_rn_directed_snoop_response_sequence");
    super.new(name);
    
  endfunction

  virtual task body();
    `svt_xvm_debug("body", "Entered ...");

    get_rn_virt_seqr();

    forever begin
      bit [`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] aligned_addr;
      bit is_unique, is_clean, read_status;
      longint index,age;
      bit[7:0] data[];
      bit byte_enable[];
      data = new[`SVT_CHI_CACHE_LINE_SIZE];
      byte_enable = new[`SVT_CHI_CACHE_LINE_SIZE];
      /**
       * Get the response request from the rn snoop sequencer. The response request is
       * provided to the rn snoop sequencer by the rn driver, through
       * TLM port.
       */
      wait_for_snoop_request(req_resp);
      aligned_addr=req_resp.cacheline_addr(1); 
      read_status = rn_cache.read_line_by_addr(aligned_addr,index,data,byte_enable,is_unique,is_clean,age);

      if (read_status) begin
        case (req_resp.snp_req_msg_type)
          svt_chi_snoop_transaction::SNPSHARED, svt_chi_snoop_transaction::SNPCLEAN
            `ifdef SVT_CHI_ISSUE_B_ENABLE
            , svt_chi_snoop_transaction::SNPNOTSHAREDDIRTY 
            `endif
            : begin

            case ({is_unique,is_clean}) 
              2'b00,
              2'b10: begin
                req_resp.snp_rsp_isshared = 1;
                req_resp.snp_rsp_datatransfer = 1;
                req_resp.resp_pass_dirty = $urandom_range(1,0);
              end
              2'b11: begin
                req_resp.snp_rsp_isshared = 1;
                req_resp.snp_rsp_datatransfer = 1;
              end
            endcase // case ({is_unique,is_clean})
          end
          svt_chi_snoop_transaction::SNPONCE: begin
            case ({is_unique,is_clean}) 
              2'b00,
              2'b10: begin
                req_resp.snp_rsp_isshared = 1;
                req_resp.snp_rsp_datatransfer = 1;
                req_resp.resp_pass_dirty = $urandom_range(1,0);
              end
              2'b11: begin
                req_resp.snp_rsp_isshared = 1;
                // Spec says Yes/No for Data. So made it random.
                req_resp.snp_rsp_datatransfer = $urandom_range(1,0);
              end
            endcase // case ({is_unique,is_clean})
          end
          svt_chi_snoop_transaction::SNPUNIQUE: begin
            if (is_clean) begin
              if (is_unique) begin
                req_resp.snp_rsp_datatransfer = 1;
              end
            end
            else begin
              req_resp.resp_pass_dirty = 1;
              req_resp.snp_rsp_datatransfer = 1;
            end
          end
          svt_chi_snoop_transaction::SNPCLEANSHARED: begin
            req_resp.snp_rsp_isshared = 1;
            if (!is_clean) begin
              req_resp.snp_rsp_datatransfer = 1;
              req_resp.resp_pass_dirty = 1;
            end
          end
          svt_chi_snoop_transaction::SNPCLEANINVALID: begin
            if (!is_clean) begin
              req_resp.snp_rsp_datatransfer = 1;
              req_resp.resp_pass_dirty = 1;
            end
          end
        endcase // case (req_resp.snp_req_msg_type)
        
        if (req_resp.snp_rsp_datatransfer) begin
          for (int j=0; j<`SVT_CHI_CACHE_LINE_SIZE; j++) begin
            req_resp.data[8*j+:8] = data[j];
            // If clean, then all bytes are valid, if dirty it can be
            // that only some bytes are valid (ie, UDP state)
            if (!is_clean)
              req_resp.byte_enable[j] = byte_enable[j];
            else
              req_resp.byte_enable[j] = 1'b1;
          end

          req_resp.dat_rsvdc = new[req_resp.compute_num_dat_flits()];
          foreach (req_resp.dat_rsvdc[idx])
            req_resp.dat_rsvdc[idx] = (idx+1);          
          `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req_resp),$sformatf("populating data %0x from cache",req_resp.data)});
        end

      end // if (read_status)

      begin
        string rsp_details, data_details;
        rsp_details = $sformatf("Response: isshared = %0b. datatransfer = %0b. passdirty = %0b. ", req_resp.snp_rsp_isshared, req_resp.snp_rsp_datatransfer, req_resp.resp_pass_dirty);
        data_details = req_resp.snp_rsp_datatransfer?"":$sformatf("data = 'h%0h. dat_rsvdc.size = %0d", req_resp.data, req_resp.dat_rsvdc.size());
        `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req_resp), rsp_details, data_details});        
      end

      $cast(req,req_resp);

      /**
       * send to driver
       */
      `svt_xvm_send(req)

      
    end

    `svt_xvm_debug("body", "Exiting...")
  endtask: body

endclass: svt_chi_rn_directed_snoop_response_sequence

// =============================================================================

`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
P6EGet5OSyR88l1NcteXRP3auZi7L7wGPKtajPBEUzZVDGKzwud5rh8qPG6W4SlI
oA1rBh5G2B2QD06YdOpJ9i2Lp/gsjr3H6+733jFfOK3SqIiHb/mH/KDFdk0pTU58
DFoFO3zYJt6SQ23VwAHtIQYgNbU15/H98KThGT0GUPU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2374      )
6y4dUZIWgCw368J4QvCgPNKYgqrb96DbPzmFtzGfvCuJYE7TN3CPqYT8DeJ//4f/
qbZdOdCC3ZkrxGhz32/eqZPCsNql2H7BAmN9DqH1TRcUwXzl7EDeij8cB6qj/yf8
`pragma protect end_protected
