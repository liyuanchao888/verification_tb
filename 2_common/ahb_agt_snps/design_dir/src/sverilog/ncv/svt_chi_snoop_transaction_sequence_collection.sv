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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CMAguDiu2JKgpT9DJqL4LoAst9r7rzMY3qPtYIXjFvTiRvXRS7rBqJm4E9B3rcq+
vRC5pxyC+j7+ROvY7R+Tab58MecIpR0HntEIDV225FFXaHNugFS3cva64+2K0hNf
T+pG4geLn+7xhaUykL2y/nJEcmsdjay1WhtD3bL3wYGmRr2bDOH5zQ==
//pragma protect end_key_block
//pragma protect digest_block
F3mU1+ZpmRXVn8d0sj/F3ybL5NY=
//pragma protect end_digest_block
//pragma protect data_block
GpF96nlOb2MHUL6H2ee6pMJnPSwAlDjMfckZUOVTsQoyGeCSZQCRS2izq1Kybspz
PHFMTBcJvBJcjQD5IhfzzvK4Du0KJyjLRbR9LqSkrvgmfJVG67EJ9qk6FQ6apr3/
l6/FRTWyDBWc1fzKTt+/ZZ63tNCyfxxhc4bL17sKWrqr55xvIA7P6wGAlYG4j3US
EzTzDW3m4chjMCpCQ7WhSQ+h1bzx8IFxZW9JmjRXr/XjVd1VJjsgOQrLJ4wP83Lx
UPZw9hZj/WgKrGM/NwiWExa+m4BBkRweZyAuFUDlLgmqSn3cSdj9birY1ACD44UP
LlNJ6xisAZFNwkIttUDRO4l68MwD9DR1hLrP8uTeEbQ5z+F6RpPEvxranNNyh788
yj+kGDTF8TI/dVtbLt8P6Tr26cS1l4mwXRp/r7VQ6un3/7EA4tbRS/SdkgUKgNuI
g2pEKrqOu91UbJ4jyH4x6wnDcwnfBJvgO9t3aktpbPWWVk2tJ2DNJbRhClIIh+y0
axXP311clBZFqcFRntby9rbAQqdt89gcHGAuJTpuFb2VSgSxbTQNEUTuVWJxhFZ9
Rz/39cO1Xx/QzXYhjMY8yU8sQwduuewcx58ScSJDuFZtU/BCJQcJjyKSoagtg+3X
1EWj7VoynqP37lU7BOqMVvCQxrDEMVAQHjdJcRpxvnHJZLu/gCjEj+JEwNg3m4ka
ZCdVIeL8rS9pDNp1ZVM6FSlGGS7kfW4y8C3x+/r7yyhclhUrcCbpSMKo0SICt/T/
BLkOKXsgrixPH4xsMhyP0Zrw+cdeL4kUrWXSj5/6VW8q6kE5kHZpSreF0b6Fdx36

//pragma protect end_data_block
//pragma protect digest_block
981MRNZw/mRhhbsVZJBqSGuV5T4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rQmFUA7uxgbXp2abCNkDaqhUf+TGPG7UWepPTRaUhiXmyOsEIz5S54Q9LXRH5kBT
3P5s4yWQzQyu9BhvQa+exezv3qEDpmk0r0O7LoO9pzHonvCwkwCcFq+JOeJDKkxS
M3ysk8h4sl3Q1ML+Vn4kR4zM2rtliC/rhAYXSYbnjJWldTXWFuzAgQ==
//pragma protect end_key_block
//pragma protect digest_block
dAUwPyTS0KOsxHNQIO+yTA9M/1g=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
KF1/sQ/NSFborp1Q0aEPEr78nUI=
//pragma protect end_digest_block
//pragma protect end_protected

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

