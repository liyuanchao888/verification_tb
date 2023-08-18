//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2019 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SV
`define GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SV

`include "svt_chi_defines.svi"

  /**
   * svt_chi_ic_snoop_transaction class extends from the snoop transaction base
   * class svt_chi_snoop_transaction. This class represents the snoop transaction
   * at the interconnect RN connected ports, which are connected to the external RN
   * components.
   * <br> 
   * #addr field of the svt_chi_ic_snoop_transaction in Full slave mode should be protocol 
   * compliant for the SNPDvmOp.
   */
class svt_chi_ic_snoop_transaction extends svt_chi_snoop_transaction;

`ifdef SVT_CHI_ISSUE_C_ENABLE
  /**
   * Defines RespSepData and DataSepResp generation policy for Read requests from ICN Full Slave VIP. <br>
   */
  typedef enum {
    RESPSEPDATA_BEFORE_DATASEPRESP = 0, /**<: DATASEPRESP DAT flits will be initiated after RESPSEPDATA RSP flit is complete. */
    RESPSEPDATA_DURING_DATASEPRESP = 1, /**<: RESPSEPDATA DAT flits will be initiated after first DATASEPRESP flit is complete. */
    RESPSEPDATA_AFTER_DATASEPRESP = 2 /**<: RESPSEPDATA DAT flits will be initiated after all the DATASEPRESP flit is complete. */
  } respsepdata_policy_enum;
`endif

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_ic_snoop_transaction)
`endif

  
`ifdef SVT_CHI_ISSUE_C_ENABLE
  
  /** This field defines the respsepdata policy for Snoops involving DataPull. 
    * Applicable only for Stash type Snoop transactions involving for ISSUE_C or later and when data_pull_is_respsepdata_datasepresp_flow_used is set to 1.
    */
  rand respsepdata_policy_enum data_pull_respsepdata_policy = RESPSEPDATA_BEFORE_DATASEPRESP;
  
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  local int log_base_2_snoop_data_width;

  `ifdef SVT_CHI_ISSUE_B_ENABLE
    local bit is_dct_used;
    local bit is_stash_used;
    local bit is_stash_data_pull_used;
  `endif
 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  // **************************************************************************
  //       Valid Ranges Constraints
  // **************************************************************************

  // Mainly covers the valid ranges with signals enabled for CHI_ACE. 
  constraint ic_snoop_transaction_valid_ranges {
    `ifdef SVT_CHI_ISSUE_E_ENABLE
     /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
      if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
        txn_id inside {[0:1023]};
        fwd_txn_id inside {[0:1023]};
      }
     /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      else if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
        fwd_txn_id inside {[0:255]};
      }
    `elsif SVT_CHI_ISSUE_D_ENABLE
     /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
        fwd_txn_id inside {[0:255]};
      }
    `endif

    `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A) {
      !(snp_req_msg_type inside {SNPONCEFWD, SNPCLEANFWD, SNPUNIQUEFWD, SNPSHAREDFWD, SNPNOTSHAREDDIRTYFWD,
                                 `ifdef SVT_CHI_ISSUE_E_ENABLE
                                 SNPPREFERUNIQUEFWD, 
                                 `endif
                                 SNPUNIQUESTASH, SNPMAKEINVALIDSTASH, SNPSTASHUNIQUE, SNPSTASHSHARED});
    }
    else {
      if (is_dct_used == 0) {
        !(snp_req_msg_type inside {SNPONCEFWD, SNPCLEANFWD, SNPUNIQUEFWD, 
                                   `ifdef SVT_CHI_ISSUE_E_ENABLE
                                   SNPPREFERUNIQUEFWD, 
                                   `endif
                                   SNPSHAREDFWD, SNPNOTSHAREDDIRTYFWD});
      }
      if (is_stash_used == 0) {
        !(snp_req_msg_type inside {SNPUNIQUESTASH, SNPMAKEINVALIDSTASH, SNPSTASHUNIQUE, SNPSTASHSHARED});
      }
      if(is_stash_data_pull_used == 0) {
        do_not_data_pull == 1;
      }
    }
    `endif

    if (snp_req_msg_type != SNPDVMOP) {
     // addr[2:0] are reserved and should be zero.
     addr[2:0] == 3'b0;
    }
    else if (cfg.sys_cfg.ic_cfg != null) { 
      if (cfg.sys_cfg.ic_cfg.num_sn_connected_nodes == 0) {
        // Constraints related to addr field for DVM Operation.
        // addr[2:0] are reserved and should be zero for DVM.
        addr[2:0] == 3'b0;

        // The values 3'b101-3'b111 on DVM message type field in DVM Request
        // Payload  is reserved.
        addr[13:11] inside  {[3'b000:3'b100]};
        addr[10:9] inside  {[2'b00:2'b11]};
        addr[39:38] inside  {[2'b00:2'b11]};
        addr[8:7] inside  {2'b00,2'b10,2'b11};
        addr[6] inside  {1'b0,1'b1};
        addr[5] inside  {1'b0,1'b1};
        addr[4] inside  {1'b0,1'b1};
        addr[40] inside  {1'b0,1'b1};

        /** TLB constraints */
        //TLB Invalidate not supported operations. 
        if (addr[13:11] == 3'b000) {
          // Guest OS/Hypervisor = Both not supported.
          addr[10:9] inside  {[2'b01:2'b11]};

          // NS/S = Both not supported.
          if(addr[10:9] == 2'b10){
            `ifdef SVT_CHI_ISSUE_E_ENABLE
              if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
                addr[8:7] inside  {2'b10,2'b11,2'b01};
              }
              else {
            addr[8:7] inside  {2'b10,2'b11};
          }  
            `else
              addr[8:7] inside  {2'b10,2'b11};
            `endif
          }  
          // Hypervisor TLB Invalidate should be NON-SECURE only.
          else if(addr[10:9] == 2'b11){
            `ifdef SVT_CHI_ISSUE_E_ENABLE
              if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
                addr[8:7] inside  {2'b10,2'b11};
              }
              else {
            addr[8:7] == 2'b11;
          }
            `else
              addr[8:7] == 2'b11;
            `endif
          }
          // EL3 TLB Invalidate should be SECURE only.
          else if(addr[10:9] == 2'b01){
            addr[8:7] == 2'b10;
          }  
        }

        if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b10)) {
          `ifdef SVT_CHI_ISSUE_E_ENABLE
            if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
              addr[6:4] inside {3'b000,3'b001,3'b100,3'b101,3'b010,3'b110,3'b011,3'b111};
              if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101) && (addr[6:4] != 3'b011) && (addr[6:4] != 3'b111)){
                addr[40] == 1'b0;
              }  
              if((addr[6:4] != 3'b011)){
                addr[39:38] == 2'b00;
              }
              else {
                addr[39:38] inside {2'b00,2'b10};
              }
            }
            else {
              addr[6:4] inside {3'b000,3'b001,3'b100,3'b101};
              if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101)){
                addr[40] == 1'b0;
              }  
              addr[39:38] == 2'b00;
            }
          `else
          addr[6:4] inside {3'b000,3'b001,3'b100,3'b101};
            if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101)){
            addr[40] == 1'b0;
          }  
          addr[39:38] == 2'b00;
          `endif
        }
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
            if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b01)) {
              addr[6:4] == 3'b011;
              addr[39:38] == 2'b10;
            }
        }
        `endif

        if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b11) && (addr[8:7] == 2'b11)) {
          `ifdef SVT_CHI_ISSUE_B_ENABLE
            if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_1){
              addr[6:4] inside {3'b000,3'b001,3'b100,3'b101}; 
            }
            else {
              addr[6:4] inside {3'b000,3'b001}; 
            }
          `else
            addr[6:4] inside {3'b000,3'b001}; 
          `endif
          if(addr[6:4] == 3'b000 
            `ifdef SVT_CHI_ISSUE_B_ENABLE
             || addr[6:4] == 3'b100
            `endif
            ){
            addr[40] == 1'b0;
          }
          addr[39:38] == 2'b00;
        }
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
            if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b11) && (addr[8:7] == 2'b10)) {
              addr[6:4] inside {3'b000,3'b101,3'b001,3'b100}; 
              if(addr[6:4] == 3'b000 || addr[6:4] == 3'b100) {
                addr[40] == 1'b0;
              }
              addr[39:38] == 2'b00;
            }
          }
        `endif

        if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b01) && (addr[8:7] == 2'b10)) {
          addr[6:4] inside {3'b000,3'b001};
          if(addr[6:4] != 3'b001){
            addr[40] == 1'b0;
          }
          addr[39:38] == 2'b00;
        }

        if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b11)) {
          addr[6:4] inside {3'b000,3'b010,3'b011,3'b110,3'b111};
          if((addr[6:4] != 3'b011) && (addr[6:4] != 3'b111)){
            addr[40] == 1'b0;
          }  

          if (addr[6:4] == 3'b010) {
            addr[39:38] inside {2'b00, 2'b01};
          }
          else if (addr[6:4] == 3'b011){
            addr[39:38] inside {2'b00, 2'b10};
            addr[40] inside {1'b0,1'b1};
          }  
          else {
            addr[39:38] == 2'b00;
          }
        }

        // Branch Predictor Invalidate applies to all Guest OS and Hypervisor,
        // applies to Secure and Non-Secure. 
        if (addr[13:11] == 3'b001) {
          addr[40] == 1'b0;
          addr[39:38] == 2'b00;
          addr[10:9] == 2'b00;
          addr[8:7] == 2'b00;
          //ASID,VMID valid field restrictions.
          addr[6] == 1'b0;
          addr[5] == 1'b0;
        }

        /** Phy Icache Invalidate constraints */
        // Phy Icache Invalidate applies to all Guest OS and Hypervisor.
        if (addr[13:11] == 3'b010) {
          addr[40] == 1'b0;
          addr[39:38] == 2'b00;
          addr[10:9] == 2'b00;
          addr[8:7] inside  {2'b10,2'b11};
          addr[6:4] inside  {3'b000,3'b001,3'b111};
        }

        /** Virtual Icache Invalidate constraints */
        // Virtual Icache Invalidate applies to all Guest OS and Hypervisor.
        if (addr[13:11] == 3'b011) {
          addr[40] == 1'b0;
          addr[39:38] == 2'b00;
          addr[10:9] inside  {2'b00,2'b10,2'b11};

          if(addr[10:9] == 2'b00){
            addr[8:4] inside  {5'b00000,5'b11000};
          }  
          else if(addr[10:9] == 2'b10){
              `ifdef SVT_CHI_ISSUE_E_ENABLE
                if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
                  addr[8:4] inside {5'b10101,5'b10010,5'b10111,5'b11010,5'b11111};
                }
                else {
            addr[8:4] inside  {5'b10101,5'b11010,5'b11111};
          }
              `else
                addr[8:4] inside  {5'b10101,5'b11010,5'b11111};
              `endif
          }
          else {
            `ifdef SVT_CHI_ISSUE_B_ENABLE
              if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_1) {
                addr[8:4] inside {5'b11001, 5'b11101};
              }
              else {
                addr[8:4] inside {5'b11001};
              }
            `else
              addr[8:4] inside {5'b11001};
            `endif
          } 
        }

        /**  DVM Sync operation constraints */
        // DVM Sync operation applies to all Guest OS and Hypervisor,
        // applies to Secure and Non-Secure. 
        if (addr[13:11] == 3'b100) {
          addr[40] == 1'b0;
          addr[39:38] == 2'b00;
          addr[10:9] == 2'b00;
          addr[8:7] == 2'b00;
          addr[5] == 1'b0;
          addr[6] == 1'b0;
          addr[4] == 1'b0;
        }
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          if(cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_E || cfg.dvm_version_support < svt_chi_node_configuration::DVM_v8_4) {
            dvm_range == 0;
          }
          else if (addr[13:11] != 3'b000 ||  addr[4] != 1'b1) {
            dvm_range == 0;
          }
          if(dvm_range == 0) {
            dvm_scale == 0;
            dvm_num == 0;
            if(addr[4] == 0 || addr[13:11] != 3'b0) {
              dvm_ttl == 0;
              dvm_tg == 0;
            }
            else {
              if(dvm_tg == 2'b00) {
                dvm_ttl == 0;
              }
            }
          } 
          else {
            dvm_tg inside {2'b01, 2'b10, 2'b11};
            if(dvm_tg == 2'b10) {
              data[11:10] == 0;
            }
            else if (dvm_tg == 2'b11) {
              data[13:10] == 0;
            }
          }
        `endif
      }
    }
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(
      (snp_req_msg_type == SNPUNIQUEFWD) ||
      (snp_req_msg_type == SNPUNIQUE) ||
      (snp_req_msg_type == SNPCLEANSHARED) ||
      (snp_req_msg_type == SNPCLEANINVALID) ||
      (snp_req_msg_type == SNPMAKEINVALID) 
      ){
        do_not_go_to_sd == 1;
      }
    if(
      (snp_req_msg_type == SNPONCEFWD) ||
      (snp_req_msg_type == SNPUNIQUEFWD) ||
      (snp_req_msg_type == SNPCLEANSHARED) ||
      (snp_req_msg_type == SNPCLEANINVALID) || 
      (snp_req_msg_type == SNPMAKEINVALID) 
      ){
        ret_to_src == 0;
      }
    // VIP does not support ret_to_src == 1 for any transaction 
    if(
      (snp_req_msg_type != SNPONCEFWD) &&
      (snp_req_msg_type != SNPSHAREDFWD) &&
      (snp_req_msg_type != SNPCLEANFWD) &&
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      (snp_req_msg_type != SNPPREFERUNIQUEFWD) &&
      `endif
      (snp_req_msg_type != SNPNOTSHAREDDIRTYFWD) &&
      (snp_req_msg_type != SNPUNIQUEFWD)
    ){
        ret_to_src == 0;
    }

    if(
       (snp_req_msg_type == SNPONCEFWD) ||
       (snp_req_msg_type == SNPCLEANFWD) ||
       (snp_req_msg_type == SNPSHAREDFWD) ||
       (snp_req_msg_type == SNPUNIQUEFWD) ||
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (snp_req_msg_type == SNPPREFERUNIQUEFWD) || 
       `endif
       (snp_req_msg_type == SNPNOTSHAREDDIRTYFWD)
      ) {
       fwd_nid != src_id;
     } else{
       fwd_nid == 0;
     }

  `endif
    !(snp_req_msg_type inside {SNPLINKFLIT}); 

    if (snp_req_msg_type == SNPDVMOP) {
      is_non_secure_access == 0;
  `ifdef SVT_CHI_ISSUE_B_ENABLE
      do_not_go_to_sd == 0;
      ret_to_src == 0;
  `endif
    }
  }  
   
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    constraint valid_data_pull_tag_op {
        data_pull_tag_op inside {TAG_TRANSFER, TAG_UPDATE, TAG_INVALID};
    }
  `endif
   
  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_data_pull_resp_ranges {
    if(snp_req_msg_type == SNPSTASHUNIQUE || snp_req_msg_type == SNPUNIQUESTASH || snp_req_msg_type == SNPMAKEINVALIDSTASH || snp_req_msg_type == SNPSTASHSHARED) {
      `ifdef SVT_CHI_ISSUE_C_ENABLE
      if(cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_C){
        data_pull_is_respsepdata_datasepresp_flow_used == 0;
      }
      `endif
      pulled_read_data_resp_err_status.size() == `SVT_CHI_CACHE_LINE_SIZE/(cfg.flit_data_width/8);
      pulled_read_data_rsvdc.size() == `SVT_CHI_CACHE_LINE_SIZE/(cfg.flit_data_width/8);
      `ifdef SVT_CHI_ISSUE_D_ENABLE
      pulled_data_cbusy.size() == `SVT_CHI_CACHE_LINE_SIZE/(cfg.flit_data_width/8);
      `endif
      foreach(pulled_read_data_resp_err_status[i]){
       pulled_read_data_resp_err_status[i] inside {NORMAL_OKAY,NON_DATA_ERROR,DATA_ERROR};
      }
     data_pull_response_resp_err_status inside {NORMAL_OKAY,NON_DATA_ERROR};
    }
    else {
      pulled_read_data_resp_err_status.size() == 0;
      pulled_read_data_rsvdc.size() == 0;
      `ifdef SVT_CHI_ISSUE_D_ENABLE
      pulled_data_cbusy.size() == 0;
      `endif
    }
    if(snp_req_msg_type == SNPSTASHUNIQUE || snp_req_msg_type == SNPUNIQUESTASH || snp_req_msg_type == SNPMAKEINVALIDSTASH) {
      data_pull_resp_final_state inside {UC, UD};
      if(data_pull_resp_final_state == UD) {
        data_pull_resp_pass_dirty == 1;
      }
      else {
        data_pull_resp_pass_dirty == 0;
      }
    } 
    else if(snp_req_msg_type == SNPSTASHSHARED) {
      data_pull_resp_final_state inside {UC, UD, SC};
      if(data_pull_resp_final_state == UD) {
        data_pull_resp_pass_dirty == 1;
      }
      else {
        data_pull_resp_pass_dirty == 0;
      }
    }
  }
  `endif
     
  //} **************************************************************************
  //       Reasonable  Constraints
  // **************************************************************************
   `ifdef SVT_CHI_ISSUE_D_ENABLE
   constraint reasonable_mpam_ranges {
      if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) {
        if(cfg.enable_mpam) {
          if(snp_req_msg_type == SNPDVMOP) {
            mpam_partid == 0;
            mpam_perfmongroup == 0;
            mpam_ns == 0;
          }                                                                                                                                             
          else if((snp_req_msg_type != SNPSTASHSHARED && snp_req_msg_type != SNPSTASHUNIQUE && snp_req_msg_type != SNPUNIQUESTASH && snp_req_msg_type != SNPMAKEINVALIDSTASH)){
            mpam_partid == 0;
            mpam_perfmongroup == 0 ;
            mpam_ns == is_non_secure_access;
          }
          else if(snp_req_msg_type == SNPSTASHSHARED || snp_req_msg_type == SNPSTASHUNIQUE || snp_req_msg_type == SNPUNIQUESTASH || snp_req_msg_type == SNPMAKEINVALIDSTASH) {
            (is_non_secure_access ==0) -> (mpam_ns ==0);
          }
        }
        else { // if enable_mpam =0
          mpam_partid == 0;
          mpam_perfmongroup == 0;
          mpam_ns == 0;
        }
    }
   }
    `endif

    /** 
     * snp_rsp_isshared is not appilcable for ICN and must be set to 0. 
     * but it is applicalbe to active RN node and must be set to 1 for 
     * SNPQUERY snoop tranasction so that RN can use this incombination 
     * with resp_pass_dirty, snp_rsp_datatransfer to determine the kind
     * of response that must be send for SNPQUERY snoop transaction.
     * For remaining snoop transactions it must be set to 0.
     */
   constraint reasonable_snp_rsp_isshared {
    `ifdef SVT_CHI_ISSUE_E_ENABLE
      if (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) {
        if (snp_req_msg_type != SNPQUERY){
           snp_rsp_isshared == 0;
        }
      }  
      else {
           snp_rsp_isshared == 0;
      }
    `else 
      snp_rsp_isshared == 0;
    `endif             
   }  

  // ****************************************************************************
  //       Delay Reasonable Constraints
  // ****************************************************************************
  /** @cond PRIVATE */
  constraint reasonable_delays {
  }
  /** @endcond */
`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_chi_ic_snoop_transaction");

`else
 `svt_vmm_data_new(svt_chi_ic_snoop_transaction)
  extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_chi_ic_snoop_transaction)
  `svt_data_member_end(svt_chi_ic_snoop_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * check if the cfg handle is null
   */
  extern function void pre_randomize();

  //----------------------------------------------------------------------------
`protected
5U\1/NN=T?I9D.MRbQUCW.M;?DF/(183=8@g1FJMc9=P)aL#eY_M-)>ER^f1]8,V
8M;^0J[bd2f9-$
`endprotected

  extern function void post_randomize();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer Policy class
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

`ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_ic_snoop_transaction.
   */
  extern virtual function vmm_data do_allocate();
   
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  
  /** 
   * Does a basic validation of this transaction object 
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

    /** @endcond */
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_chi_ic_snoop_transaction)      
`endif   
endclass

`protected
EGL0a#XCZRc[a[<=G@LLS]UBKbRR2Z]gU6Se3@d)V.d\_WgbGG-V2)Y;Q\1#JAgM
^KXZR@=P&bgJaVT++KK1N6YfIdZW0c/Lf&GP&f5SUW1/957LFOZc<0Ef2XN5C,@8
;1H];8^[=&0K:?@BG)7K0Eb8d)4E>D-)(BC<]<#PS,Ug>-UBH219^a9<C@..HI+P
\EB>N:\b6LL[,(;.O#@81YU0C+ggG]@^I?X9TQY4Q4=5/RL@6gg3dZ\_B0Lc9@@^
+ga_>_2e(-3]U>:a^)TQZZXGYU+0E\B@G/g)^9JR_[6014T)2X)6&F2f4-A@S>R9
,06/cF?Q/;Y_]@Mg27[995V]b5ZbEQ:[VO)@)._.^09,P2g..Jc]bX_a_Y@Q]cA+
:V70KW/U_A2.U]de0F)d8T.)&/UBWGX,gb@1:/1S:R=XEfVL+8+16M\gEEI[/PQZ
.:cKH@18Z1TDZXP9NGED.ERQN,57?VPSY/XbR[G[UgAcN;)O,LUT4.+-:Q&V:B6+
MD8^[O#ea-I)&P6Z4VIf[/2f5La/D,Zd4gZ)[7],VD3+X)gD<C/53f6>H77(9]5N
+#cJaB<L4gcVL+Sa340<b/O/-RA+W;^U_TIT-YTb_Y;>PZ@A-&J?]4A+B@W^#>3a
(9QUWB6K<_,^)0@/#4WB>bFJ^O.?.H,9&>KEb)#_.M.Q]SSI0^<SK;DJ1f@(c4/M
BG);YPL?f@SdPS,#g3G;]B(/HOKf54^c#;@GFDX4_.G]:<A]MZ)]eC<TLaA(#LKZ
=FP^+8=>R4eaJLg]9#2QD_U1IG,M0Cc4d@B:3O78NLgXe..G2_^]KO0O)b>fU>dF
7Y.6aURLIT6(I#=L\45DX8+?9e^\Lb<cVPH58-S)NQUE/J?)DBBOJBHfQbM<6]4]
AU(_;N>/JSVDGWX[07?I^(c-5HX?T6^(BeXRM/OR/VJMN;[@RM7S]#VCV+d[TW)K
40+3L/BE2=Fb\#J]X8OA7M3<L:&AD@a+XbD9e.d:\a/YUdC9-E8[I+[_^SaNfYe2
#4O1/EbR]QT:TgTBLA)U/9BLM8WO<ScNa<L<&JUCFX3J.FYJ_SAK:JK^B,ID.\\8
JF/Y.RD4I;_#f50B?A.^U5eLTGb0TA9dBZEWV>V.KeAIccg8-^2a]/F/-]LBL-MH
^2S4_G55_CW12=62_0@X/cUWbRO9<V<3_d9eN409M(^G9KT@[:LZ(EU:DHc_g.Q+
C@d.RU3E21R0&.0E>/AC(8Y;Zda;F4RH]/DbI69J&]\9_J42HE>U6A&@>A48->f\
O]M_c(9#379&0<GI?Dd<G+#_=2e5U:SCIDX(.ae>a?Zf?.YK3[]/fZIGTP3^QRY_
I/R-2GY7<#-c7LV,89C.\Q77;H]ZX>^EO_e>&Za3J,c=e_NIZQ6PI./+<AYT20J(
U#.,<TV2_(:Z83>&_PW?GDQ3W<XH3&_YcB=]-9SC^4;[>Q\f1.@7Pd0+?2AJ?cQ@
;RG^;GYBDL7A?(X0RWa2@OX_Z9KQY4\H-3W\K(-S3UUb)HGPJe\a<GQgH(eU.#X?
F9\:H;Z[39Ag@Y)]6&N;MHT[-O,.,@LDA[3MOd0&T31IA+3c#=#@[_2/LdZ5L,7Y
C_fNeL#XPAZ9.4d<B=WY_fcg6>g2JZ8.^G>)X8M4S(Ma?8H\Yf-[@WXB;&1,SY@[
J7)?2/CCG#(NWBP1dNV0N;L.Y-K?[5.3UW>]e9aXG.(L-K5NM-A(-W<&VRM&?dZH
a3G)5=E#&O-WS-/P2CT];EAXgfJEFR0]]+LV_:K2F(I.-P>EFF,H?1M;@R077/&4
cdCQb)H3B,ML6##g:ES9DfEe0&Dd/(#WYIed-3;<))b?=JKT<NcMceSYY#gN4-Vd
-T;U-<(eW130]=B:=UBR35SJc3G-V5CHKHZQZ]_ARU04&W]SO]?<V8:QaD=S/bG)
E8,/ZZ29W)7FZ+4;TR-#de=^W@=<aeg,g]:1LU0D>[,SV2bf]Ha6#OR>=;4Jde3#
PWI=&T)e,XQE/Z_ed2#^V_?B771MVS;ZT&:BZeNE.#V@3]D4+X/,a@W;6S;+fF(K
a@-J=P\;UN@cA,6I[a=?VQbbg(VUXMJR;Mc/G=?+(4V=BE[Vb9.GGC-E2Y,:bRXaR$
`endprotected

// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::pre_randomize();
`protected
FWKK)TAKW@.V,A8R\B=13bN:>&;8C)Z)]<O3d3g1XWL>;Wf#NU.A2),]\@F2XI@W
FG.\/Me5-]O4d-MZ]YT#(6(We(V00H4DM35/^BEOfO\BHJQV&HP6dHXLB41;fQ+Z
&U9YOLWTCSK:Ke6b)Z0fDBVN;];H3e+6E)E6RKdGPTGY<),2dXHX@TUCcU-UC5CH
CO)R3d35RUcgT\1Ze[U5UfKACO^c#K21HYKXZ=4&d+OV#]g#Q=3G=<+G\W?\ef+M
&P0NR.aDeWKW;(cC<Wa^QSIdY9AL78XDQbXYJQQaI@KdUSU]E&UDW\eZP7<FO9gU
RCO@1R,Y3W3O_5KR/.E2.KRbBb12O5ROGc2&]O+fX+RX.gK.GJL(GaI@18EDLKQW
#E6bR:)[>(I)(Ia?UN8:B].I0OeIS.8SgH#O=e6fCe-AE4>A1aUP[H>6<4KS8EK[
)9LY6T<RC:M75A9ICIfONaLc]bTE]K6-0TGOE0U&MYUW^64e^Mc))&RE?HL#C]DT
eHVH=bcN;9NJeM,,-JW.C)cE6AOUWVHG>$
`endprotected

endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::post_randomize();
`protected
)?N2(UeEdS;C:7aA:@P3_AMCI.M.GT:2RHSP0Q4g:@K\;WGdWV7f-)>?[(Uf;4.J
e78U5S5EJ(#?7BLe?8P&-[:Y=b7^2R<gd>3P?b=RHSI;JUA76?f0,9EH=+37Z>_?
4]+P@HFK>AgO:.4G7a?__W,aB\[6EH,HIE@;&40Y)FgNe@(PVVV_Q)X_4f-4\]N<
gO84CDee+JEa]^4PYD/(JAf4Df9H7[^+6.L,VGKHf9b:4MS8WOVFFK+@aR.F0feQ
5IPFDbE=96)^f/_Y:PaaUR9?Y#I[:7c:/XQ:_J3eASKa5@X+;9c;ITI.?KX_d#\Y
Dc8&U4JSdAdC.=98(gbY;>)1^==9Y<90/4f\&R-CTBdPVWNBOS-?L,1_(&B+F[H@
8g?Y;IHO0)P?8+F-cX7M#+@I2WM9XTN&.RZ+K)5Y.HdRf\WO&NfDa<U?WJ93+E?G
PV_9JId(L?@+eSVI)I?,c+0;\d;JX<-CK2HHNb>&-IeA_?),PTNdJHMX?OgPNg3?
c68.>A_;39EfP<58IS4N=L?NS=S]C4fWaU+BIB]1/fg)40#MM8MV.V)db9G(8<R4
F:/&2c4UH-ZKC3YJ[<&gSR4Mf)TW7@^Pd0<]HbQW2PA4b=;N;\:a.0)dM$
`endprotected

endfunction: post_randomize

//vcs_vip_protect
`protected
b]Q4Ze/,PF(-^D(91D?97[X:GLfAR&MVG@LCC?WI1bVV?4f]1g>\6(;bOXV83)I)
ea+3EJf9F_d1P\-57^WZAgf43WSd#TU?d[A.f7,G;8]3H&gYCH7gS/T.a[9/T;^A
a.SadOZW&9QZ0NS0XE769^UTHN&X0VL43#P,94N@C;5W[^\7#VY/c0P3.g.<bb7-
NXYfXd;BS7eT3@,F9:[&NN-S]Ded&U&UN>#&#+0<_;::bQ)MJV\#e5O.>gJ27O/1
BP2A3@O\1(>.HOQ:d7If.;I:[^W4^dBD;NT;M31&I3V=7IA(OgL;N->Y/HEG&L46
;8EH2cX_SYfU7Y2YMee;CXNg(a^P1-E7KLD&76B_P6,X@P@aBJ-Q9QT/XZ>@Ab_]
g:.G_YLKA7>^+bH?L)YPURLUN4>W7&a5EbL#&8(<7-F>H^B(3Z#OA:G.R5>M>CF[
&3Q^3Z[-?#dF>F9)1NXJ>W9d;9\HM+#LBJ9/;,V2;1^6f4GY1OSW]\4->&e).-)d
)^\4VJc&G\E_WCGgb_WHWCXDbRf?,BKB@fPB8R-ggAGe:WQ:X;a32\abCeVC6<AV
,8DQRb^MY=c0NUf&;,82MEf@(a?C)c?O(c#<N_c>W&&=Q4RO:dT(<SB+Sd&aO?bS
H];9TL/C;G4IHdgb/g(dY/?MMQ>#9f?0]0D\f^&8)#BQC3NQQ,bSGN#Mc48AE95A
=VJN.5cR2^;.ANZSPc4)P&Wb2-GWC6#]Jc\Z<#N9I-1b,&8FO/54\KK><_WD@dHQ
V0b:Sg]b4OGc&[8HN>UEIWg#AGCT5._3Rgb(#Hg:,G&O1b<QW+&@69&HGMb#2=&_
DGgE56M/.633]TY0^O#b\=__,a3OaURIFBFb#ZdHTZ\F:_4DEb?HbC-CN_Z#O_:[
H+H-GF/bd4fc-C=&)?<[,f5JU0bP3?Tb@R-A-b2+PL&R;+1MOS:6^?[M18Z0<d]I
R;X.677_<.K==Fg+6[c-T.HU/-F()YWDI.HGa6XBIAY9615;=W(MHR]VK8)JQE+5
5H^\fQT&^K08O-=/=(?KF[&<d^E58L],D_B4XO8KDNAJO2F_YHDVMB<#4:9>7;GL
E@gWB7;BX4bcTK>&G[);C2(g6#>BW3WQfQ#,TM98GdE,3.e:X(f:H-6-&[Kag(@U
:PX_E[[Jg0ZQ6-O^K/,-\\A1fEF@WRd]FM+CU3E-^:#3?;4/R4&cV>D6K371_K\3
;Zca&-b8C3ZPGTER@@PGL8N_>5R[aD9C__CZ0,.W.\;RP.&IgAK#&#^K52@L+ENb
GT:HGE:B,TdB\N[NdK0&TT,L>eN8\gE):X>4e)/#T15:\b),JGT>WXOOOIL#fZ-S
M#0_4@He=SEG#RX2F(ZLZM43_SQ_,+)2?C^^BOLP&B:-^W60OFgBD=1g>-5FQW:&
-;1<0-/GK:,[JPFI+O8&--4WM]4,H#O\\WgJ2F1(g]ACOH=Ae#4/ZX1_3gG[Q2&^
W81]ZR<Fd\BH3T(;&4Sg9W>;16d:Mb,0IRA\4dQV[V\_9^80Ceg;);WZX,2GS+g3
CbP_[.I:Lg.,Tc.AA&O-N-\(ZY462Y,fbJ#CIf[,)+M\cEVK;Kc2D@Ud;D;V;\FY
B9V[]T4\=:O=gQ.:X-1<_N_f:HQLJ<3(.Ng2B1Q5].41(V8OTM9<fRaIC^LNKdCa
17L?9/0a_GJEfX@Z]&QXFZf&]AM62G)a#Q/>5GI;_SYTXCG-.#G+>[?W7=J#XgM)
7+bF(B)dIS9V=T&7_.6XgaY79=.YWeJH+dF#fJaHa,C8?&Q1(O2ZYRNXGZGZN?U5
&O\F0DGPTK8K[10:NXJb4X:eO@B?L1(9)XDOB5RW.g67ScGaM:-ZB=4ba@8-+Qg[
V19/73<7VO)<(4J?+:YI11O62BgZR^EXE\&#6f^/=/Z4gZ]/IdAH5#7OVcJGEBf[
IdJc,dIHeHG771E6RMWWY#NBdDI58@PQX]afgU9T<B_BIfP]B]\152-VV_A0EHOY
8()YR&KDBN.Q;\92G9UWN[R]R])]\dBYU@D@&8ROK(]Q;O16EY[VdHBX>HR8CQ4=
&)OdXVG4?Z?^P6Be4O(e379B[\b0G,51WbI>MK\eC&:9HQ4edIXgLQ9YT]R@B5\C
P0-@TDV9^,Mf#Ie+XI_>VZ]<.[H^QMX:D]TP:M^FT0bA.>@_N(L@#Z?b[P+eJ9fT
?dFCF/Y[F^_VG5>RSJG.K]J=7IEIa)O>-3C>Eb.VR)b#@3]C9;@QL1<8d.3cNPLf
/EgBgNUTgPK<BC_/dX]447@XY@SNHN_E;#7=H2Q-3R#J&F]b5_?43gR\C=B00:N+
L::,\M[\MB;;&7TP)#8ZFD2R>9I8?cU7+7QFO)5EBJT1fGR(d.8)TA,7eKE#ASI+
>\1[Hac(Z4U+e=2T0Q]<,[QX,e\2-BVEBZH/9O>Q,c[R<d<@#&C5=9+79_g2d--?
c+g\e&e?/_;_c4Jd67:@PWA]];S[a5=g093:TJAbWf@&\J4J(?2gH0(B)[a72a28
@T,PdMGX>AUJaMg_P7VZT8YI2_M):)d(2eJ;_4cVUHYcTW@9K4OA:?5J(I?<VPLV
YXD-,aO7<d?7^[92)WR3@+cHL[:^:@/:f^K;3T(7(U2<FW,c]g-A_CW2/DLMM9W_
cI]L-O_Z&PZYQHGM-)K:KLNLV\L#GA8)OQXaU#-X<)/bbPQ,4I4Ia.W;,=+([)0H
EeWM87]3EKb3P^F34?35a]NF0VK7g-UR_W(\NIBO#e^aBNdW7YC]FLZ3]&W;ZPR5
A>Y?eQ(Vd+F?\IF0J[cLV6W6;_e?]GdW()2d@MQU-4E4@/B;W]F@H_[ZO]FR/^?]
aW9?JUIA&WER_1+>KK0Q.AbH=3>R.&cXc)FTKST>VIe=^:D1.b)K(\7Z5M/bMeH=
ORbV8QKDX^GKJfG@2AC=5<g[F0]W8[<8bJA525F&^0P._Q\W,?&8?V6@C&;+g25+
8\HPJ:?@CIOAA9_6:IW)#4\[L2)9#PC4F5AY_92P+Qd5D/^WAa:QZ+YU@2]=,O@[
_dL)Sb;;-Ld#6b2ISaD9]S8N\>Pa/H8F=71cTeW,A3:BR.DTDBF#(0W047=3NAOH
):D+7^fO7,3#C0/3eC_SX(KLV?T#H=SOBGd8NS<<X[^B-3[TW9E6dTZMEJdDJ:#G
=#U/S[?U2BP>>_N\g\W5TTBG3@ZQBTS_Z9c^Pf&D=9c1[DYCNAcO#1TVf&(_bKdI
/^QVIQ/O?XR2&>ea<JNH12_&9GETTB6SN5UC634\H6>0>[/TAUON#)<>9aY6>Ze.
W^PeDRJ/T(2=\38S,]aL8[=SB#O?49e;/?-+I-32FggB0A9^8XM-eI,g;((C:?J>
c8DHAefXE/??=E:BP21UJ9M\U17OG89]cP#>44Q35@a30ONDA4#WQZEHFN;a7@OL
V49AF7H+]L4/EU^5QBUU+ReEF#B(_4-dRP>.NJbUMA<6@(6deFb9><[1<Ef;C+40
.W.?N4\X6MP]>9J9c3WPb,4;C]4QAI-&+af6W(YaVWC4^46DCg7T<4\[DW/.;LgJ
NH:+R)B^^R:C4G@(D6]2/Q;#[6W^O#aL>=8Y^\)-^&@FNLR^<7KgZXX8C#GX#EQ\
D7gc8J^@AJB\VS\.>P\8U3@<XA+ME^I:Laa5#]5.-6I78eXKN[QOc^cRZf<)fF:F
C(9LCJ(@AOVPSJX>Z(K<3AC(36H24./JXTRTN;S\.gNR0b<K,D+2^2C8,UdEPZA@
Q&Y9HcdZNYC,-ZKdD4-NdC4DgEBUYd3)&Wd19>N,97FL?_TN=0=T&0(NN7G:?#G^
TLD\[G75YL+)0:6;fgDHB&U;NCeWJOd_QLRfGbM9B(Jcf/>\>I(aKNdE>YZH]I@0
+fI,+T-AKY]Cd[M]I+bSb[)M;OQP0+2X_0W=+-1c/A:T)TYd-QYRDB7&0TbYYdca
(3gPKU9]6<[#.:ID39gT\5PO=]a?M7;Q,2>b<#/+gP/M#gV(59dbV-+896C;=;X.
M3EYZR\T[1#Z<\4XKO0\I[&/b?@aZ8]&g2A/.BVU2PDXX0J+LA9cBC<IgQ?XE<d-
,^ZM.F>;a13?HV/3e)U(C<J7P=ZC(YB6@I\5M?Zb32<E_A@,Yf1R?)UCXUC0ef4E
4fFG>EDG562M1e8BfEEb&c@).(d0:XNC&:UP>1S/&cFA\:\&BG/fgQRDaf++72B@
YWd#.^Jc#/P8L^?JG?,)96</:+fGHe4<&a6N;&&I##HVCG1Y@T+9@b_9]ddde/bX
fJPM3KS.X.J1@,0H)BD6=ceCBcZOMEc>VD&S<#+AP#D\QAfG><^0JS_]7<KY4^a>
J^2>WLLT/7\FI3,YP.?-8fE+Cff;XG?B/86OHQ?CD8-[6Od1g[J\D^HO#A^-[1/L
,1Q_KDL.@:_G3-4XP)g[(GTM;ZL+CSWVX=geFHE67SbU;5f@2;RILJ]PKJK0Y6X-
<6#dTNGaEF+Vf[JQ6EV:7.Ff-(#H/>I)LWZI_P#WUcP&-&9b/(TOWcIN.ZgRf8QN
B^I64NO&^W((L=\EgQP=6<07Wd4L5@K9:>eFM=CA)^6e?KQ:UDUR^>bG9K\CWbLB
;-,6MaY(.B96Z:@7-W;7[NPCP94YZ/J<WHNf5[Y-2W<;X>F<TYaf9>HQ7;ZHE3X7
MUMT@1d]6NFTU9(>8#ORBM>P4fU&QK:VXcS,-#X=VVKMZQOJ?R4CWB5I^Z(3>?U+
M9(;b@[KdBg9>F,]c5YA8#<]5FQ[eP-a[<VIb]Fe36cbK[H^TOO#Q3GAFGBeU#-;
D9I2<4V#15.+fXIR&gT?9T^e#9+CgD1c+B6a^-G^G:W:7_K+=:VCKaBg&=UUfSQE
M>MHcDc3-T-\F33=7gZ9MY547A8/7^,LafOA/d]If7CGQ64DE)/GJ55I2fb[2f^^
-EI;O.?(BSQ@D-DXO647b21_J9ZT]ZN>AY8<:K6<T,X,F2:PM4UJV0O,:fH<.Bb0
Jef>2)+NX(c/#d8ed3OE_OMd11d,X)gCg;Vg7ANL@#.H9&#:ff]:JQZ_^?K=f:5A
D+aKGXIXbO&Ia59L4CCG@\8M2+aVY_2IaK_,XaIf-[/#029\:;PAVS9J1Udd;3F#
B6dGf1C2Ff]/@Yc>8//0MRH6:E8_^ECL6cXfK>K2OS:WT:HeB<6W5^VML;0,@?/e
]@FgRc9XbaeO9;_PPHW#+U@]8[B:F70\fc=dSRPE.ZKM7AT]R=FeW+.GJ0(6[HF3
;GQR)2c>E?-W+b_3+>,I\X^=bYYeTTZg/&PMQ\N,3JK#5J;<ZVISOZfY?=#V^+MF
88]&CCc5d](8XJJe1(,5d0CR,(@9AKIeG)N^5Z#@aNKM<I-\7=QQS4O/OL6IV/N^
\<\<5PS#?2]a.4<Q^#F\1WRF+d1NDZM1_M?:T2LA\<M:6IBbL1/..bEFM-S9C_N6
&TK7-2181fOc8>KB<_?gT3IT--L:_/87>K\RL;Ag-UU3fL,HCX\07H-?=I#/g5\J
Q<I;OOKXIeQ_XZFF]>;&8e_\Z9>ad=.4?S]8>.V.-TG9HXC=;>4dW3735UGG8D([
eW?e+ADg1UN?>MN:6QQaJHdFOcXAM>.FP(O:W6.H(0#NF-];NR9fSY=_]LT^J?U\
-5+CRI9=753fGJ7f-KOR2fHA2O.\[cM:QDG<?AX(LX(BTS@S-:c:7:I8I;8.-;;K
\^L?[bg)H0/TB?OcA&UC_/:F(-APD4P2/cL1XX=0=BPb/I17MFA4=LQ8L>:M>3VZ
(6?ZP_dZ2RO&Jg.Tc)(_[0Z=(>-d>7(BE[7D(6^Zd1=HLAH:HFA1f4ZP22L_Q+_:
QWeIU[N0DRGbQfQJ3PL_>@5f/F^OWbUW]acOMac>QLIb2J)ce<)P0_/V1QfUWbZA
S#]L3gIeNdJ3:VaXb(W9L@0_YF,==ST:[ZQI/-B&b>>bN#;P:eH6gY37a@J@bU,4
@FYM&g;4R@&>Zd<Y2#R+D.4^8K51?U\gDgc-B_e99D<g9Q20J#<)1^a7323E\EHb
X<B7Rc<7bLKAA+AHg1\R#TG[<P1?AJV2B5MdFR-1LDXa5f0EE>9&/R+PI5Kc&262
@d1SGL,fSf#)29RR9.1:(U,3dbWN9L=-\)Q+4;.W#DaKS3B:N)?a_@&G.66+>cG;
)dU\<50XU)Lf_:C,F-(ZKJAE1P/geK9@10=a4J,TcZg7NC.,&<UBA8Q_D;;WP;bE
6MHIa&II\&K3C,#4W?>MTJA^eUF2FFF\#1Af3Q.UHE(WI=CW<6=TF,PJ=?1LJ1X2
Nbe#6O(5+bTKV@CR1@M3ASH\5&9H<&Z5T6?c4O_OG8f.IK5W_IQb6Ta+(;[=Gf)I
O[7^95GX4./-\Wa-#R.+]2G?3B,GN3?cbDUM]M5;-X@>V^>>@5Kac&P&MWBA,c(J
3RI)&IKb/BE;@Nd8Y.AY#2DRI<(bR@==R;/(C)71TYfY[ZB>ge>.U?Q_\=_CJ1Ob
N0f^Lb/F&E^MP89VJH(])RA=G/P2NETV<NTSDSE6GWMZ(N#(:a4GaRCL?)0AMCEX
NS7<BI-G_4]&.3T@U/Z,cI/2e^:bg.]B8Z#>_b6D^&6_;.>G5P37_7g7+8=^+(IA
.G(aMP(I@F=^(EV&8^WW4/UN1#[V+?P]C4?ga4S(;&S7E\a<QdS?6JV>9dQMW./>
NMAZ5#QKJd(\^5K#ISN;T&QJQR(74d=]AF^5P0CZ:\3:C&N?76aTW5Q4bf1EDdHJ
\3(GS3]>g5?>aZ>3D7DK&WY@ZPRNgSTVX:-X.5&^K;0]I;9&;4AH.I3E91[U8JL1
4,T]df6JZ\^[0?FfR/&?/H0&Wc26^XY5NB;.Q@2EC5T6:BJa-O4\HOO1^.Db42G)
N+_67X_AVVT<:D>.Gb2d:CLb9gg2LUYc)Q8eXA]JW\e1PSg0@<:+-#M0B8C=-(]R
:2a.@UIK?2cY+gW&_7a45a-^VG(@]S2[9aK,#HW<1+B\RV)N&>1WT=5,?CUX6U0/
GH98;Pe0W?1SL]^.L/Lb0L[e73RO>c-c)QH:A5CVK1+QQZaK1<_76C-A8eI#=@<O
Vd#P:e\4X2]U63NOU<d,M8JKE&[)SD+93,IZB[\VFK/\97#E,20G0fg9ZfGSHc7H
9<J]/1]GHK/cSa8Gee[D.>#0Je242=+g)D>JCFN9Q1LYJ=]BDE>+ST;E1Sd-B4@W
&E2GIcL0<S&FcUT)/0ND^C<IbM^<B@D4P@e/-([V)f?1K>4TD@E[7GNK,I#>[0BZ
1<HWR7E@]]L4gIH#b(fNbg;I(\6ZBXJ.dW?EA;CYdZ/+^M]@P3(b&c4ZOB/K&AL.
ZBBD&51_>/H;F>#6dc^OUNGF^B[7;gD,7C];\>>J4OW2M8&[(Y)FMJ4+/cU_IFS<
+]8Ve#R0gEU9Cd7=&[;3-&]PK7bdJC?PY6NF4M(Z9c.aE8ZdTA0RJUccR;#I^15\
)WO&<#6MO;L][aA\/JSZ5KHINTGDVH0Z@/ZBGcFYR.0]S]W[5b+7KY-[I3f4FU8A
\g)bb\9=_[1NN?O)-3>Z@3J]1F=D6;9KH+9GbPcIf21.R)f0FDY7_4-^RO<1NdT?
^DJ@^9+cVR90f[>A.c^.]P<QD,eZXQCbV[CB6-7)#Bd;4N+TTDT8D<fZ,:S9>dUT
.MIVF)3Z\I[b8T9UeY>+&d5Qe0?ZS>1VG]R:CDP,WeJ)e/I#1ZC5O,3BSHV-K/CW
G/R]=f()[:P0AD-EI91[DATI<;L]c-NPd)#]:9E9,0EQBUb#9.TKQ21Q\D:8B/-5
b8+910:g&Zg_/U3).4.]BdRf>7J_=g1dQB8CDe[GWB4.@/BcRNe/AA?P/7S@X2Xe
PYE3MV6.RM@P6&_@2)B[aNL=d2@C-]&N/YSQT<2L5E57)cf:#(/E5IaN60#7c\]6
M_X,d&1b_8D1e\50P,(,H\--aBNT5.VP(^<6TO+QNFO-Y/\O1CKA8TES3>V>2dG>
_]>1HEaL+@X,6],<WcN3+\5X6/DI6b+CQ2Ba:P5A]Q@^?9J3Afd=HfNZbGB1V5>7
(NDW9RL>LS6UF#=gWW/]^?HgfU8G;gN<D01D[7.\fSGfXZX2d]3>f&bK88I/BJ#H
^cCI3;9_N\X+;3^fU<RGXZU)/G[UW,Y52MIb6C(=K;+I>S@T8;C7AW>,188cU]W@
VTg4J<dY&2I3]LJLea^(56O=>LDd4EGBD.\_;Hdf3caCO<(C]TYG<Ig14Z[\Ac0?
@YB^^PBfD8d5X)[.SX#^V2;&Oe3G=.bD5:dO9WJ]MBXNM_af)/T0V@4E<7UQRH(8
))]S_Ob53BHM_Z-ffDDK]B..BI=&b,gL]&e.b>TSJ0&Y6(ePbGXCa3)E45AZ.C(,
1MMEe>eg5^,ZZMS-8;D6c0T(6<;.[[YD#)OJgP4Z4@6J\A:0FJTeN,_0KB[.98\/
C)+)&T]_:E+3Z>(A9d-I\.&Og512#U.b^9YL7?Ve5PWR[HV0Pc,J/Y/TJ39O4Ye?
TL=.]/^-FQY?/AP.^_/A6O?2EMd,2E6#1XBJ[JDA^AIV38SVM_#J[8abFG.H3a@3
Q5F(6?C9=JLd^XR-#X?<_b&9^F>RZ,1O9M^+PPMdC];)9GCSFCeB^ZS199?[]?Ae
/EQUSXR5e&\#C#W1GLFc:9[T.HSM9>#g4WR?D.;9X+f+]D;5(Q3A24X4@\;6I#BU
-/b\-=Y06P>Xe]LEFGc;[N##@HaJeRIUTb^\4,=cWgRQY.0=/@DVX6G,+EcE:bN,
0E3(Md.,E:HL,dQJ\@)Q+dGVVOK:Y.]].XSg9;D29PD\EGT+SNLE(K6)PW>CV)IX
dQYG7DZ&(5Ja?U@25f?D56dW-AY_I2\O@5DYUTL-79?NTT8]X3OA;?@,1UVE:RM:
;<(fV@2F@HX/RWLDC>QIIBf:#8[RUYaV_2B(,VJgcD=AAPLa:2=(6OHZN.)dPY^]
W0IY33J_F?+TYC=M5U2.fcI[Q=8O^E)W:N0c)&H(4gR.V^X<?ITCJKDE5H+@c.Uf
WgJFMQ0CO\f9Y/K8Kc,K#UGT3=UE:/]H\aWdbVQ&/Q/R_IMJ[0DI\>9]Z=..\b\6
IV?:(TFbGc7Uf/?W7Y<f0-d#-^DQ-@E2+CWDcUO[?dQA/WR;WY.WQSeg_1SA_EN+
;118;91#M@8>93E3C,:ED]PH8JNPH(,>NG1MYc<Of>c7e#bRa88HNRdf017.M&Yf
:FI=ZAS6Y@IBC@>PQ<9Y>6;3TG6QRVbQLAQ2@1O;<d6DcMR7W53U^@:<:Id,8?F5
N(#ae[XE]3;;+1C_A+AO[#9PbJE@^fI@HEHF8f?>-,C/^]0V@XbWJ\(.H/:Hd2Qc
Vf#4Y/c15;OQ:1D2MJR6\;S)8W(aF0^WRg?)@BI-IM[RRQ&M_?P+H<&.\?R3(O<V
<HT(/=ZD17bZHUeCM^<:8<#TY&=?F7c4QV==D]VW-S\bR_BX]7eS;aD,QR<]X:2U
)]O.,g+,Y61C-O\))OAEM.+<Yd==8.UD&UX:0Y&0#)TRA31_96(G4H-AcO+SF3A\
6#&<eNLCI@^SR@Q8IS]fH3KDX]K[-Ec1\]^2WaJ_TI^F(VIa9fGH;>4QT+Z+65gS
=Y(61TT[;C)KX+Ub[EHaR^^-F765?10d-0?;3@S\6/&&>+?V-R9ZY^=[015ZZFJH
J=W9^04VHV[;(2HZCMZaY1UH57)7(>=/K5H7fWZUMb?&I[BWMYU4\,;4aQMULOP7
?fNe>RZ\L;_ZM/28#1;)T)TJ<IN;:7\5Q)]+BGPbZ(Y#Oe^V&XPc2NOH.43Y(P5^
\C(J_&N8\R@NOI+O-=g98\#7]P(TU0CJZ4(3-3.QD7fDJebbVW6-5V9UZU;B</f5
Ja[I&)B4Y2]<3c;E6;f+V=Fa\3UFF5<c&1Xe107QNGS8@HNS]?13PBH]3WI1K5bQ
\#CI#XS\bOER35XPb_IPfZ2)@^dU^?dc0:(RLL?.T.T&53-<CUBA,,\LNVCKV6E9
R./BS)GT;Sg[&bO(G-5[C1HN.?9H.Hg]KYHId^4K6BEB=MWG7=gCZJU[I7e@A4_8
ba0C5cQ#A-S_U>T@R:d<PdJ#:[2OO/+53/0SXC.H3,CA7.N:0)S6;+c@;53-UP?Q
Z?=:b:a5[J]\1:1[bUN;&TLAf4Jd+5AbBg9XHX\<0_L7c^gA@7#5c5]Qf);98@I+
ASU]6Q(ZRN?(GU/QFNf?dX=/F;I)0U#I+>I9/&UHRdGQD/5[Q>2+3HAf8UTMZaD?
20Y/R7:TS(c90E)K?]W+NEgLL2B8&O9KK_B5J6PVYYWUgg]P8W3=6\Z\>:7,H8?+
fQ5H5=S1Q9W8=4_HP9,;EUc(+E-DM8/QNB-HE,Y,)_2KJK8ZdMc.BMa]H_I=?T+J
:2,ES^N+H.<8ZCc,VC0b?QH#T,BR2b<Z45UK\J49<J5/7egWL]W[=GLVE^X_e8[d
[LYKK/(-6SGEeH-N:eC<U3.#S6/eJUHa&-XgXY4W(KQ-<O^?PB>+CCe[e<@6/-G0
g)-bF#/[X_U_aB[/[Mg<gb9&7R[1QW]9J<?V2F);M(A&_C]9b0=AeAMg\3X_IM,9
R\af@-P6IO=XKJB3b6SOSfXFQPd(.T)F31SeK4g8gdY<TP5.-9DA]JVIfD[OUIeU
0ST55;328g2@G&O?MUf.KUS68D;7MB407?1=GD3LK3GPdZMaI?[QNQ#(-B^>dM0R
L2<UCF?WHJHXRG]ZF^S9[F8ecH0YOR+(Q40I?;TX_=e_P\[8.//:#9M<-2(=9OM3
J8Q@QI_AO+=2NN;D=VGQR(d)387)T)F-I.O&3)3YbM_]GFSJbLG56A:;ZXN@#_:L
>(b-CX#OYG.S@e0bc<?Pb(b;:0;\:c[UKQ=9\]bRL+REGTg,E?dP,&RRRF.XGE)T
d=J[K,8?^0b3>X4L([4]aJ.a>3/K^/3=<+0I,RYZ4BTUN#]_Z]XW..Jf)Ag4W1W^
67S&<Ca3V&_OLVQ(/b[HMQ3G_\B?a_Ne=J8W[XCDYDf5I[/KFI3JTPf9.TdQO<Lb
^3H<CH>ZIbX&R6@Zc(5IUb9f10J3<V#-LF8MGWZD:[A<cGPOE/fBc&gaR8XW[BbB
9RRV#_/c\#YH4TSTD,(aS_)TZS?)9fK3C;#0(N7bY8F;df&;e_g]_F[U+XXA,[cR
&D<McQ&=.&9:6Q?e^/D/9>\?#Yb[_@XOO1Zg5@N0-;()>#34(96gI^+,TR9/Wd,M
47HTAI-<Q9@JE8I#2A>b:6JH9Jc@5<=3da:/f[O=JY1QA?,XUYH)ET];<6[34\+c
MKNU_AHK6/[7ON.-5I&AV(>ZCgSd>S4QNeSf]S^ZaCT91TYZ3K)DY/CU0O8=J&2&
I)Mc^OM0UNX25NT<0f8L\Pb4+/B6gWWK7;0f2+=Y#@[1Q:7/YPS7RX2TZYXJ_cPO
+_L>WSX0D]T5A&/g@.B33-X&Q-9UgM?DMM5C>6fJ8QccAJ(03\JXLW7(dO&,cBA4
[gK:;AKB/4B<2U@c843Z(A6bMbA@b0U_g-:(6E51Y:3)I^KLI+)7ZJEbM9[Z36Cg
@.XZUM4dDZZ9522JA1aDXd;+]HU=,ZJUReOOADXaG^d6)2K:.-S2@Z^eP<gR(3WI
#K?DVcH^^X3a5aGdDYbfP>&d&1Z\B.FCg/:?>GMDS:X=I0;gM]-143V>7@X]]:@9
a7J1SF#U:\/eIaV^KOM4]=9WZJaA^R4Y#;5>8cJK<SY_G/Ng4M<5>>Yb;K)Z3Y1]
dL5BdIM@<;[)FF81Z;YLIaTQ0X\Z0O,07(J\UX5#2X=\I:DAG6VA(4>4&XHZ10UN
;I#\b?e]1-5>JN8MD(@1VK#OKC]S?Bg],LKIbaTDC(ZD2W2AB3^AHV-6bb6]-XTI
X:].=+b.Jc3;LI/AHK?L(Cf;aWe_(\0IZaY18e2(>B589.Y,48&&?=F#Z@E)V9e=
)?L4N?,8VA<.Z1;+9T(9.66RJ.a@Z)3fa.I(-8_d5ZGWH3ebBA7LNY[SfCd7][,0
MeUc,96XB\1+EVGN-X3CY=;MOT>&,[A(P:F]70f:4)\1WN0?6RKe(RMBJCMe_W;.
d5R0ceWY#(KgVLT;aVL2Xg&J7)B<C1WAW1f.XIGfF:OF@+A/254f5gS?>H:^,6V_
OPLb1RIFbB@+f+3SQgBF=geY[>4cR6A7@&LHNe+T/QT8D8L4B@2.D]6LYJ530W3,
,,2Z/786LF-S-2+[J<K)f\Q.AR4^X)>8eQDM1_Pa/0[&7cH&CX5AZBBC</IB0gT4
2:@fD-e;P_GHPd^L:7\V::eEYL4W,CVQ+U0]E7c@A;dP&I@aY<N7:57Z2B^EA0+d
daMQF_AS?2Db_bc<JTDNFYgY#I[aZ^85cVKW,2R3>&AWFeIe2g.)\59+&R(XQQUR
Fbb#?4?AF/e8N@R&1=KG@L5dA553FdGN&THF/ed;+b;7=cbO.g57B?8E&aN:B3S9
LN9,0@#278:=Te5a&@.]@b(EF^6,=f.5O)=GI<_^e-aO=U+>bEZ^W^66ADVLQ(@9
4\7C=bBZ@VXWQK;\ONSLQ(W(P2aL=W&c4);-V@K5>.NP)dDBHa2M>EOCH62.U(=?
@9F;<Da5f;e)T4e7<OHP_gI2HMV,gJeI933\bBZNaH=LHN@M^@#0QMFMGJZ:\Z5Q
W.LF47X.:?@<LQ?<J:3ceD@b]:9)SJ>A_5GB&JTLU^4V=28gaEb/GU_&:3LfCEU1
2AVH4b32&#6J2\VU)#,E6F\6)E3P30/649_L?]_D408^5cNE#&D-R:6B=c7RC[<G
I&1Fb6#HWX=?Fad>:3ffW.TF8P47X=PUFHF;\I=FG9M+&:cBM4Rd^fP<U^e1TM&X
R=96d6RVYE8=9&+.T30I@:\(eV@U?,2DQ;6&B#B]d1ZY9dB_J5_V6e74MULREP.T
NL\EZV2??6O93JZ[:7>VcXJ)0,6^P2_]V#_C_C;XGQc54W\3@.L>E-5FTC>Fe+Ea
>-gN&><+D,)(R4=0LROWRObCJUMSgd&P^NZag?<69R6&6^IU>-bKJ8d@J_BOSA>?
1;V9d+]b^Jb/&?d2fG0D-WaKE<H;/IG<AWMf69O@I>4SYQERO?g]]^eYF0_d+N5&
/#NSA_.\22<YH)Ecb#HOE=JSH5a)J<\d._Zc.M;?6Ga]_O+b5:4V/9d1c95\W1cN
6MF@,H@QY@6K/@-JBSDAM\M-ga:CS+2;TL6BR-RDc2(W-[<7Qc]bV+M0[1->bDEU
\0I_?];YLMI^N3HXG_?,N:DV<KUU^1#5^)AW\c2J.5/AHZ7(Kc-Q<)QEAR0:>?>K
9a.:7TK3PMJPZPN@\,&:B9a1K#^f3]\AdGFg\-,d=JBgKBHO,V7Y^0>3+P)QTHf.
>Gd:)CX&#;3,Ge+4Y8DHH?ZK,XI,BPL?I+A[I#G35CX(g)6]aJ:d;\5@^6V+\)AV
__ECW3>L=-JFQ7<3)2P0C[Y-),(eV]RN=aW;)HP<&67Z0gaJ=.SIT4H0J_&/XH4A
L.efLW,)@4eLM]8+#6;b1@,aa07:S5g/;XE)6S\\dWCS(Tc<1=X6.8/,g:D(#9R)
^5=1V07W)8[^.4SB:3H9E+7/C0ULaT8FJ<:+A=TU^0DC6_#;BFF8RWgIW\OKM&/f
b,<S2K].dI)K7QYeF;[3I4?TH,.<?_P\5ST:@I-;,1;:UPMae^@U^ab7U=F<2X^/
X7T5ABWbJ0UJ@W/);V>2@Y6B()9]WMfN7B<59/b=\c3F)/[&OSNK72X2Z5BBOZ^2
gG^QNY)Wg;\+geM6ce7#YWI2]I[VT^YHI@<HPGZ(56\1H&:D]RWR6^_?[U0\)2bE
>(F=_aT+]4>+fRHZ7CFG2ecYJE8YHN@aUEEA_WJPKBaBWHCdI:O8ZcHYDb^9a.Mg
#U<g(Z,[^S#)HTR#:E33b_AMLBS87WA_=Mf<#HX]dMT\C]2<10L6ADWRO0[/6b3g
PA-24V4>5#eD64AFMWg6Nc2\;G,CEQ)&P]XQO<M=NA5_,b>CI&=#KIKa7gVF+6]4
Y):g_/-(JU#ELc,S[)MGM7RNXYF(::[P(d63E>[D@W]TcJYSCS:F]KPZ7E+P_LE3
5LBO5GB@JVSW@[:NHDM=<c>B.WcPLXVa@QH/P>b996>8gUb[X\g#L)?eYgIdMTY?
b#LbV;;S^7f8G5,U([51ObR4)dDBO74+)>b-1d78+_R[XaGW]A7+3](#0LYZ><>)
JZg/Oa)M/d/F^cKNZ/\FA7640;\\H4CfaDO5\c&9-)I@5-0_[Bea8.=;7dQOP];A
>K(64FI<,^3DVB^Pe+:6DfD.HT4=dT70+f.AS;#>&Te=cA^QUR0K.dLF>:BX)EYR
JVRS:b&U[+#Tg7N_-^f+28?]]42WCgT^3+e^\@\HAQV=S8e8d)cBf7^46AW]QD.O
Y^\g\^VP\b_TF2+<NcPS64DJ^)(_X3OUe&<bePHaa]7?fVIQ:P&_>,/<,=Q5?S:T
/X56fcXV62&dPJ516X,6\8(Ue\1E7B@g4/KKHOXc.36OS:B+=BAgWV3K_,K3OU53
7<R9]cFM61:6D2NG4I?D@>[Q:>12dRg^CeD-^SGABL&A;AaB,=GQQ4YJO<a3ES>Y
@)R22G_.N?_MZ//SMa4NZcK\6,X@0d=7JW_fNF(Y.&/+gOXB:?9IN&e1/d0YE[PX
WI-O2W3_LaP&a,P@R/I]=\X7VBc,03/K(ZdN/[]3gBL6c0^[S=ESK,(Lg4]/4/&6
5U1C>c_P7Q.R-O6P=]56fS9,T0D\-B0BA:bUY9-Z0f(WZ54SCD,CB;]HOXIB)<g)
6JVX,CXBZE+EO]Y@7X<+7[eC>D_>@]/TUY]afGb<Oa\L(R[C+C-9<I@7)LI91H\>
51Q61C=fS8[T@A:8KO?(We;EIPYHU]?Q;Z)_^NH87fVD8e^-(+C3dZ9^;;JTCBZ_
c<g-+-))H:9:.]+Ta4G(TLFC772B;80D6cJ7a0#CNcB&R?e@;fNP@YSL&a([fDA5
#BCO<b&8])Zd6?^[[>Y3CFPS)SF6]_@-CIY-cD(VMKfG&,A/D:VKA\cV<fZG0?Q[
EBC38TB^(We2H),-7&6\><PDe<ZRYBN9=^(I/+1-X7Ha^)56JL\QU^/1\N&6@DMB
dX7=Q[=#-R52L8fZ=?0cTH9)CMY<>73[4779)\R6ZCMGd+>UVIfg+P4==eP04]MO
(3He;IY.g?_+)G0e-:Z_R9A4?_+K98Xb#^S^4AR?JELW0RQ>Z^WK)H;5F3X7UNNK
UUTWAH>C#VW,/fc:@f6dR@QPXPV[#+Qf]\g0gDC3Wf?@e=^;W:A+;_JUFTN1ea^C
=PN55M#OEIcP@E/D]X,5G?g[IW5,;JF)FS?N#N#B85926-[aeE6)@#0EcQA/@b7U
)_?XLP<#g#/RO/07\G;SUgU/<&2?+_KQUJ^1WKbR;8_<GHQ0/J@KD]#XDSS^[9TE
Geb1dGZ?Wf1FW)PT^O200+^QX_:H6,E((KGcGG=d5C:-.G;2.]<_XdfQP/\8?a:e
5KUQSN@1NAIb6d^(&Qdd3XD@:^ID2[B;BYb8f3\Y=MMZ41?GHEF2/3TF0O4+cV[E
=./>^C_/:A?+;9LHAS<RDC?HMaPG[4B0Fb.?T_MVg)1ZT(R:VW._NP&Y,^UE76=Z
,eSN<R]MX^<44-FO7b6#?OPg4_\]bC>?LVeHZM(5@d(H,T-<15J.CCVfGG=M\N)J
=FYS&I-^&O78g_=1_KX\R^VX/.YX/D#JA2J.D,;9[:V]Q5[LFJJ.N(<0-C-HL)..
EV>Q6ZI7W1YeG-cA=b31c8N;3RH=KYK:4X6a<9VV2P9306=@>M6@d\I9aKD6dEUX
[ROS[3RI#Ka<J1&B?EZ5\/Mf2Od/([X/e2cM,S0>A,FG:X9Y/Kf_MY5.3K<8f<\-
@6QeQF+[2L94RR.SL9)_bgL[f(?.a(S9?FcJXYG3&UZK,,,e:dAF_W5JP0WELH+B
A(GW/Cb?]I4bP#a4G3.[S+T^BBLeZ(NXg6F?7BfTH=1Y=Z;<g(L,[SFL+aIGXMMd
ZZ?M&aA^-AVf@KacVMI<e-LO1XOUUP@8IcKG>[aV+(N&/9GP3I.I/UUb]HC3NC@L
VD<__(P)RQ?G0GHQOQ(]@b/#B\aY6\Z84SIA8#(fHe7HZ?&;NOSSgc)(GefH82.3
LX5U):)OdK@.Y_9\MW\\PR3H.28/dU<W]&082^Ja)#>#2P77Gf?EM)d.#=&f,=bO
Tb2([GcaDLBf\dbDBRW>SK=Z&dW&MH\O89:9SVAXHgbP=;8>ZQg7D_8_EU=/])N[
MNdHP[@.-eT0)0\)[,e^WTa-YZZ=HdCc\3JX^G4S,,7(Q9[399bM7a860&LY=5OA
2_A]aHNeH^X.XG_:MOb;R52Y/L0OQg.[,EO)++]#E<AN_<g>O+CeTNe\MRL3]-M_
UBDD1RI1R4R]Y?9/(XGP3R=K=VKF#Y;57/&FF+,&+39R41X+N-c9-bDQT6)?D^?M
8XZZW..e2,GSY8,B@]eIMW4+M_Ge9Z0c.[+@JgC<O/X0gd&30Y<_bZbG8=O#c;#?
UdDe.LN121eA#,_Mf)YYf+DSFB?+[De.G)G0c2<.CZDY]+Z?dX=W,(A_:BFM)PFa
?W67@aE+H^E]\dA;00Bg7fQfdV^=-GN7g+4V86=WQ+ID[=3(:gTC[Pg7TH^,;dg0
,G@+6W7ZDN6]^=?J##@V,.f6cAIMH5;dc:>IOD>^(8Gdd&P11T1.V.\eCO-dU(K8
\b#1#7eGgCI<3@=Q<cg=.Zf;2gP58#_Ab0(?bb;-?>PW@NQA-&;:\:L?_6\gVA@c
Q_Mf-&:W,^LVFQAW>D-4g0G&Ca4L)@Z+=-R]E_3e)WTAQ/PKO72UA[DH5+5?/f,B
C:>Ff61S+02CQ@70AKO__=L3Te_Lb[]U_C[P0,SN>I@Z=Aa,R==+Bc-7RBUOM[Bc
TQ6#/=17cM^gU4c6WV4U5dSHV7+-/#bY.M5cd.51LII1O@gg3+XRGCI^)>10)Q&6
GO_Y8&UV,6G&]2ffTY=(bC#O/U)X73UI^Cf#49b26)[I;fe:9AOcYC0L/C]^Jg_U
\)OP,b>4)WS;3RdI?R@O_#VXMC9LLAZB?#2@,Z@L79B(S)H^ED_#-^-T&]f7DSR.
^:<YABE--73g>I]9Z2Sf?@\EJc\OQN)g_\PQHQBa]UBXTV>#d;^8gdfZ7_]4)BH0
9\Q3EbdM&NTWQWV<.H9M3VWg4ER@eBNS;b^PA1P;:E;S7TcD_aW0.Ac+VM61H_7V
K[&ADS^TM+a-ITGPc<6,)LEM4&1LXc=dI@+_REA<M^JF,UV\R?a2/9.\1#>.W(P:
ABcG//Y5A<;NO)M;@GHGbC(&;4QS&eRD8XANf=Y.G9.D(d75g+JA2e?];?#^2_f@
?KT<\b:33A(XORCY)T<?5BHE40FIK[FA1+&.<EBEf=g(5N9&V?I]a[0@K-L]K:SX
MSb/O<+P),9GSCAR[#]6YNTOI1NQZ]B@1JY,Dee828?:9,ICU,K;c&C3D@eFgaL6
0U5-M7M+\25IE7>M(-RJ<J-/=gHX]d50,HN6gQLSA8PDX=?==L\6.VdL>/SX)Fd8
&@TF6DUHW.\V?W[M.[#.U^?[Ed<1JQe4GO9(6:.[U1=SI-V#S;b38b-RFP5?a+RG
G0-I1_eI.KM,f&>+_=+YQ6f\Y76:R-KU2&4X0-IKc-C.f\_/&1F]:2feMETSa#Ad
e\M@6]/^XAE+&VDO2R:EIM/M>OJOHM@9eVb_LSRX\Q3FHZ,4TX#(cYf@LFL#[L,G
;M0dG-.=g[f/,1^K\TN)9@HPb:0E#;,b)ISZPMGJ5K;Z9CCCP,+U[14QCD-9Y4NQ
:a7.7MUJAMaW#.E\,Q1;fF57MVD,JbJ/X]7&.PVRU1)H_FC3Gf;1c4LA=(HRG-D-
)_MR?^VDHF;/\5-]58+cVR+HDRa0O:5-0K&&\[MCa2;ITMW>QQP+W>?U1_D@&g@Q
a#1>_FN37G&?>K1L)U4YL6)9RXUbaG19Cg#=34A;71IL=CV9EU;K(#S3]EdTP23G
ZK3,e@(]UPUBL/+:H.@?b]=M<,?FdDNSJ7@F[&9FK5]I3,HK4M^8R[_+1<L/+Ga+
=K,GCXN6VXN27?K/WAY3b7AUY7.EL=YMTD.\+<;,(0.V\,?626OJMd&BEPgMFROG
9R9XA7(S;(M5aGb#3\R^cMHcGE-,5KHMg[.^+]9(QRC.e=8FJ4_0,Y5UgNYY0Ef<
&&2I2C8NbTC7=JMJNV5L1:eAV]EISI>>7^dg&GbO9YP@M>RA36>YB5<4O+ec#P)U
2a)06Y(GHdg#TK3WR1)P?2TbGL8+)F\,<a]&&\0)DSKO>A7_;O(7F]8=T@4U]TbV
=CF8EXVbQ08P>fE+0ZgT=/.2;R03SfT,@8_45]7]IM/8F,I:&Od3_F#7b)1#J,c?
N9U1-1NUQ_^:^-e#TMV\D,H\^H(57eUX+S:BRC<bTEW[XAgAI^WY@:C3R;4Q.]&Y
8=#Id6cBagM&b(de=@U4B2/KL_W]6Q2>&?PfXc9+@A_,dZIL;LMNa^S?2UW@:=Ef
T9+??RR#QdRA-L&:OY4GgdL6\CDW??:,R+OPMI=C&OgdL6;S:8+,&0>EO6c(8##\
1e1Kc87\1W0(/O[;DXKE.BNCET[/;c5g\0-CWASNVdf&I=5d^D]EUPcFd<JI8G[Y
=PLg+I;ITc+N9IW5Y8&&-MT-9R<df+RXM;/03VgJ(_:Za3M<:H\K&A-WbPKX,-+#
6:.\J4L5/L47YUR2:2GO#P:[=[#R8f[R.C@]1YHD@B\@HZOM<b<<9#1dEVFSg1(1
JWfR]</a5D,6+6S@Q59Fe-U>P[37MR8ZdU\K=JOBUe[37/Lad0_;0F7/U.3K=DN-
:;,8c]<[S/\-0J0E.]UU<\>2PRCDUE.9Q+UE@(<[5Q30NM[^D)=N6((:]F>[3S2B
fDWG^A@\<cgTMA;4RJ9CG;)T^)@4JP5?&(PP-_&N<E4XM&\\T)9R>V(W#_]IJFa4
fWFSeU:^+5F6K9;A8#dHd]Qa.\.Cc6#1;V0I]N.<+Y797J(5BV?egfZNE:cJJ(O7
;0=0_Ie2KW[:#@b:5aV6;VSH[8c:gLIGIGJ7fT3c0C,G2FJ?^_?c&(U0B_>R-S&A
J10c;I;]Y,)S\^ZHf?VeD<;M57T/>A>&)@)GbL7C#^3J>X[9:ZY1T2]1K>cF,22J
ReY@8<MGC+XeN:36,3Z:XZ\gHT#dI>^(_6b9XGB?[X4ZgTgLSba]F+:#@-5K)<-K
U_??T9V).+?/Ce(J3\PdR_PU1WP_E\cB0d-1eL,]E5D5DDA,RJ5]VE3,\[Z^XaNg
+]_5K1g9.62LHO/@VN@83Ma_WYUEM=e-_N[;/3(/LE5d1cV6cP&S\Y:[=B()^Z<J
/?#]T?V8IZ7V_EJ^\9M)SZHb[XGNUY1B)?YT0e>2W0U@(2T0F+2Z5][>D&M8.:B8
]/0dBTNdY@X@E=B?NV1E@[EDWPS4V4WXP5W5@2G;c</=D@X?&X^9I1ab(,^2\Y&#
3f(Ab&8P#T3Ed[@JWN+=J_Wa9eYd-?QcC(,JUO/e<f4FA@AFC]Qd;:T\a2WXU[/)
U@;@)ge4R7da9bGUH5YM(G:S)e(QS;];I6^5CSOV7Xe>&FTADbD6:a+YeI-S#VDX
W[MOZAZUI&PZIN)eYb(S<D_,2U@4-:O5c]@VE(D>N&S/<aOb10aO/MKK-(=Q&VNd
.X0M:HIVX98da6<W;V:XZgD=S4):JXFDPOf5OW8Y)^B3]URG5(4#@^J,^70Qg;1M
5V)^5J@fa=K,dIU47459C0MR?.>W,9)@8Z)U_EQ]]f&-N9B6=,M4554HeU6c83DW
5+35VDc>1-A:,Qd.a+&DMFD5L_MWcgbD53(5Kef?bgP_7#(\5Z<;5c?@cMdcgI,:
(YUU?4MgI?)RMC,>/L0?(MJ[4IE6I@10,A<./4gLN82FIP2=Q,3]e^Q[+S;?EL]-
LT96[T4:K._MH]\S(b/?SX]Qe9\[LJNM8SYZ-)85HKRE#Pe(1;X<2=(F<?cV;SeS
)VeH2DOF([9QLTdCC>Ag#G>9XGZ[7V01RHe<T8S1TOG=MgQgS,7&+Y;a2#_Q/9M,
(D;?Y[]C13=9QafU_@?2U.\,[Q.CeB4^\MZ@>4TPPfBb+e-RT,0U+(+=X3QJG+=A
_(]OQ+[ZJ5DHX9VD3.+#cg0#.QJ,c4#Z=Y&e\CgA&+=\9aV)f4.VFYC6>KQ[HOf8
/Kf@0R>^fK+]3M+SEE?&<JN0cW,1[W1>OIJ2SBbTR^6-14K>_;&<F64(&NP;Lb32
-^YcQ5,0(_D#K7)dF+QN09[V<5aPNgF2Pg/RT2b\UBgZgS?5g@]<M.V:e+J::@UL
=bQ&\SN4)-AL=VV@^/c^?<J)J:J\^a?Z3U</H0/#^&4.5[YUX:)MHLe5#VL(f(Df
>N/K+<71e^FcG.0H,,R+#WY.U,Ee6FB)4]_=9/E6^.U:a\AJ2K92K1N:KLABa[..
9AKUBAM(Od-PQ/LA9bg9,f_0A,M=\V6P/Q^g1QCQ_8,GCOJ+N^3gL26WK.UAW^)W
S7XD:TDW2XC#-19=US/N-3QC^/a5U[81\BUBUCJC(Z&e^3?RO9&J,?4CTNW\R&gM
Se.JNFP.9F-[@YJ^Xe-ME\,LB+W,Gc3dbTLQ?OHCJc[d.1P8@#Vb8LL,-IK3RH&a
I.]Bd?G[QD]8c22Jae/(WW[L6PXA.eLLf#ZbOGCOWb[#\0G@L?#cX?.AYa0=Ib)R
Z)+\MeF.>gI.FU5(#=e0.:+@FRZ[D09NWGY0CHV2X];K.VNK0@fQa2B]^YQe;-3E
3>DT\SVIdJ1GY?:Q3g[E22K79.adS<-P[Z8[)U./FWG?VAP1;2a[2=(+R.CQaHE+
-c]L0<^@ONBH13/E;9E/@dS8Yd9A]K];1fJ@f-IZF0-b#XV]cD^FXf:.2Ia^XSBF
PSa-[c.^.7A^^@TGS\K.)&;Q1f2UePJ5HS&@^+OfG&_<GD^Qa^XUE)Q&I&S0F93N
B>BLLJ(,;Q>B@6dC#GOZC,+fWZCaQ?<@8K3QPY)AcQ0g;M4dVa9=(78N.79OIUdg
5Q54<Q;]W1IS<1W29>b)-Kb@b9+R2>O.W6f)L,YS?>eL+,G^6A3,6G]?UM+[D=Xe
5MeY8QGZO3SBd\Yf[Eb#bU&?6:8JG/C7^9DaN7=K1X#K[:8H1Z[5eg/:5f[e;\bG
=Re_E>XU1a,1P<-+AQ9]W0:4B8>C/T2>/SNdgQPA\>\g>R_g)?K2(J>6GQIf[Cbe
38BOX7P0JT7O\Zd27dd<FFF,\H@>DfIZN0&dK\Q:)IF-.9[/ceO0<b+&K^[M_/G(
bd8#dH<b&7A?8]>50N4c)NTS90=90(@GIRPS#HK&=AaOGU&C#[Z+<#Wd:TZ,NT5.
AVU];T]4V572SNeDA8XL^12W6K[RB9EcU=K^<CeFe3cfFd09^I&ZGAEfbEcJ(/3/
cT>Y1FV\K#:UJM?BDC91TA0JE7PbXW;@-4cd&T4<:gD=NE:LICK[#UfI?8aIJMHM
W_/a]SZe[,^N\:_]dGUM8M.&ZSAIQR\(77ZGNMS=405fX-1DYeB&1<RSMg[#FTB\
L+E.1MCc5QI2_beP=g,<J+DA&#-]T(>3LPCc_U4?dMWgBDb8G0&2J[[6/E9E6Vga
/:/GGP0/,+5XUHR_7)??aU;#-NZQAU)B>?S[389f@GK1bGO_/W56aRP,D8@;#cXc
75Z7@^?WGaH,?W:^&F0(I?O]UMc0USS[<^BO-_,;SY.5.F2fZN35OX^,145QRXH2
Oa76+EJNA@/fQ1+7P#81YZACB^2.S>6I:SVaad,MbI4VD@(QDWW9>15?X+K703TW
Y4)V\.[LNBUJ;bQ+&V1MB:R#RaYeS9K<6ZS</YQ#B^8B@I2M@@]?<?5NFIef,+5_
_JS?K:1QMTcXcM4b5\T0OO73:#Q=A:;0+DXfA++]QL>&/H/QdKXYdd.KI[Mb3KK[
]RWcZ280UII4;#>CONSee:HD4+>Jb+/CUZUDGW7fW>L[?X+ALW)1<Q:a<fH9(4@T
H[9++YgWJ7TM^>YgLV,87>2TP]7UT-N^5/,Z?#2)X>@3<_GaRJ-&42H&Q#P\GZ-T
CFfe.;444(@#6L\C=\C/e<a\Ea4ea.WH7\K[SSR3T-B>JOY\gH/[#ebZ_I:QcFYD
KI+0K7L1@d\2>Bb@4#\TY#WN)66L+_LO9^Yb@053/4L><6R)#AZ7KV;a5<-NdS?I
=eY#gR>1a?-#_(#.aQJ7Sd_3O)Y]G6Y;)OK0)U,bTcKg2,Z]=1H+J;/>#[.G0aZc
=++4/B5NfR,^[5N0IDVZQ:QYZeP0:/.;X<V/W0UT]@/8E:aAG/>WUU=0<;>]CG@-
YU>)LS.LIY@;f?a9R8N&?bO1LK,?<EEdAR\4a@GD(=9E@2M=T]U_MD^;MU@W[3].
C:)[_e4DFC.Y)#?9dff,Z>BTGQ;,84#/0B3GJ)#gVD+I&H#6c=6e7NfL:+R?:eWb
eH&&\2d/cgBI4A>KHXJGL[7N8>e.MS#YC.=YUUE^,D^57/T@IJXH0@2)Vg,0;Sd)
-Z,L-1/N4WDY\I_PS(F6K=9A.,VKTF1(a(YUF@[C+,.I5E0YG5@)1#ADZ5QAb<T:
HW[P#0bKAT95SB^C7NL3FK:,;7L?1=_G0[IfXPPR1TPKR[Z-<Cf+=9B,JF,+g_6X
LeGL(dPH&R\/6#H=3N^Ga>g.VM@PWXRQN(Ld287:T+IR@g>3>&:FZ<>ZdJ]:):@F
^]-QI0-EU=)GbfUPFB07&NWOO1^:,,R7K:8S@UE8F,b.GZPe.(R5:gG+94?^<QU-
eRaD-J+^>9V;.[:<S<+93=^(.d5e,EEPRg/5eTcgS&@]G=8>O_<)JXQ1JQ(MAK)L
&:&&Le^G[@TUa>ff#:NcORN.)BfXH8+,bSPOPDXV<>41C;EZJL7D@.EGUEabVFO+
=\P+>d8Z\=[I)3d4&TZ<KS4F+K7d0bJ;LW/V#1^D:4,E)9d;8LKTC7\8A9L31;H6
]4)2A(_+5#WTXNP5^_D;-ZJaNFC).89D<J;ITX6YWa4_<C;5bIK5H90d:YffeIfB
+BRN<\PQ=TQN;:DKI6WdK.?BD(3A+MW4/@2V5[78.17K48.aZc7OMT6V<XUeF;dN
XgS&4P)/FVUL,1gWbM<ePJUdCcN)B)AaPH[GKQ<=EV\XH68^@BD9QdD>]HV(1]=O
VARKV.F<K8ZMNJ]g^Z(LG>;X]f&@K3bL)7@1_E1OGBF;@5B^P[VcP>-M&5SM3fPI
>[edBa\S0?SQ+;CQ3C9>\#EE,0eM<2K0/7QS1IKJQd?cLb6fA,f<dB>XfHV:5ZN4
<O=F@JZB_P<E_<.NKbO17J;YSg3L0c(1VY?[3K)dK48M\DY+.@EePE[8Lf(;H\:^
T?8=b:.:R)e;B^Y9F;1DFSO-M^\B/-&4=80b_-:X,-2765L#T]?.Q.IH[K?]DQV8
69X,EVXP@R<]d(@UIUSUV-B..]P@>1P.;R^/:TE:;,^;O5\,^&8a)7.cd(eY>VMa
RL;eTS@P^&OUW:dGIfBM#\H<g81NaNHd&[&TY.D]Z1I2>:\BD=YFP_@?K:N/)ULC
H,#..5UB7Va\YMXN-2VZ;-IC#LS<Je?^c.Ebb&Dc)BUU-afH#RNdRb0c5Q[=DIW-
UL>LC9?SS8ID&=J]SCY7L>LC4gZ_+]_S8BD4GB^WH@fdNSTQ:C@^8V:+P6=H:eRY
P_0aK_<1?47A)<GdDKf6\+TS\PTWCbUUA(N7BY]fF;YGJRI-fBaM)N/T4]a0Kf1Q
H)[?d]J><;VccfK,gP^(C-fgGYc8?ARQ:fbWf=gbYg[b>a_#ZBA[?EZZf(?g=I7)
,Ua]D/^J1WYTS[&cD:B:?UBIc,_RgH&N5>CK((C:V_USOL:ZY(DTDc&]<3]I+_[#
.Q&,:2ZCPba^@I)H12#YL9=G11f46-E,:gU(Tc0CbX?E@>8[QgN>[CHaUTMKe=Va
/-AV8=TVR8[Q/)g\7?+HA/37e:U^,ZP(W.^&N7RTE3-gWYH&M0(g&&TR<:6A=@QO
Se2Va>X._5)RD[ILF1_O1=EcAReN.&?I(L.5T:a^AK.g+a0Q^02#_HL<MR^2>AG@
WaZ83A8ZM@FSWH1e;L@P<37A6R(7S_LY6SXUC#&SZZc_ZMWTZ26N+Bc7]?V#F]Eg
/[G_=D]He.&H/e](^VUIdg^<I5;0P5ac;@#KSFbT^5H^0@D-6>6RD/;J[VMS7-Eg
94f@IC3<U>f[3;VIaR@bK^NHAZ)4+Wb+3CR].S.(Ca4RW<5);()H9,]BDW5P>BLQ
OH96(^8-&PY2/[Lf8ET(e:daUY[GA[BW>XgBH)dcUUL/gJY)\>@(f-e_9OeQ;U:9
7O2ZbY#6H+X^Vff?;SCW/7\OJ/[4CT6ALNB_I_ea(.d.T(GXEA]&@X>2H(+S]Q/I
?D:W\@LG24;JVR2NZ+VIYG&5+UeUWI2TLO6)U=cgdJU=B+[6XB;+3V+,ED]RSNQ+
_LZf\d32gYV9.LBV-4Z>TL&9DY;\WT.8NH]IH4TA>ZSafUP_IVD>G2O>@AfF2T_I
OfOXd7KI=#b8@:IU7.7dTR-/XgZ:C[bM//;ZG(6+3XKBE6<L?],0<<@2LW_7aU0G
L?V,gB9[01@55;)2(-QEXE^H\TZ9Uf5R6f/19#gV?TS-TD(3O-bCLF_\dC2_>BOH
S4&YdT4B@FF&a0c;)a[(R-d]=WY)A,DO4_=+K3,W?VbLcJ&ZNJ-)E8R[XT^ed4VF
,:Fa&Pc18WC[(A9&]Y(SA#^eOY/@F<\\\Mf5HZf84(2AE/>PZ3Z,)gfO+]I>^1F_
KDGRG?fI]&763...OK9YP7\Nc(af-&SU>]L6Z2gRaTQYC8U->fW)+SSJZIf+4N\^
YN.dFeU-.,_g<#\([\W_L;(f68+\e]^51CRFBGaSC^a(gN?ed74/Q:YSGV(QcdA-
+KON10D1Dg1f:?Z9Sd0dY]L?)OQIfFD(Q6]T0f9.4V,0Q@G)d+?OX5-P6HE/\:1U
U@US;e-DFG]=(#-/]/C@cB2La)83&4LgP@SSd1=7XS9K/#F>PD_5QHX#>DC=LP+1
I?+K?efH/QQ9?2L&29I/8XMLH^4-DS)>@D7\R@IV^+(;KAUNFeE8UU[5USQ6BCN2
XS7RLLHP5#XOH+)Q.d1:D+>M&GBI]Y^GU8c5(1SC3RF0f96&M7&)?\N8SLU\09?G
(5VDZHFUDbMBB#EfUZ[><QgP#=<6b4\;A5:FZ)=>a=0&[@aJYd;_X7@g,IX]BDGP
3D?L52(S\/R-]36U+:dZ2aPO_U=QE,IY(8OHHI/(48\1/N7>d8(c<W1YY7HdaE)8
cg>/1[FcX/O:7RQBXM;1.;1d?8<KR+c3b8f:WMb^?LUfSUG[fT9DN-23WO4(CMT(
<MO?bJ3IP>9?Pe\S+#=/bF9Y26Nb6[T-QP,BaZdN^_>feKb5&O#P?0JO5-R].VT9
D:>S_6RWadX+R5QEG?/D;PM(f,Ng9HLJ^?A3;D@@>g(BA/Kc2Z#e^#OKcY(WJNKV
XN.J1D\gKJ/d/(V@Z+SXEIBM4-L^T63[YF@(7?(S?-N&>:GP8VdA(Le#ILHHC__4
)HN-QG(#@=A^eZKf#^SG?H^5(Qg@cd;KE8+RYCBeB;>GH)H=1JM;]G-HR?T5GRR(
^-a2V.ZJ7\KYY>6Jg/NY@PLf(+X&SB,G[K_7#-.5/b8KNK,C/?FAO<3#BE(1b(6g
:36+=DU3b3Q1D^M\(g_(VWd5_X\Oc&?]+f5J.?Q<ca#V_Z:a[d3C._-X(SG->U6W
7=R6[Y20CM]LW5;gKF4?YWJ/fB(\X4^H_2,VD31#2X,AV2N4\GEI3778T^Z@_7g<
15.)Z_WX]6U9_7@DZ3;&gZ/T:.UA(AAF7^-cRRc-dBIZYa>]cNKUb.T=V.eCPX^(
2C0K_U(7<Z:aL-=>ULD-EC@4cSQBA7g7E>RUC.9@HB\:[S-AR6-0Ice01gWDMP\<
IfCM8(U1V#<]=>(K(OA;bYA[8()NSS:B^ETZI-YGf3-M7=(OB,TbOS&M-3T3;d:H
)4&.0e^=NgD5?=><6eINP<ZZ36RS5KX4_RA#fIPP)eFEEQNO16adgDV75K.&343e
W5_<Hd[8TD?-P(4?(]bb/d&0aNPBNfR^2:4b3L/Q//U4_;@fE^S0ea+eCebU^]0C
/U]\=1\VJUaeM02[+cK__\Kb,V]+_)56,eMQVcAYe\b+^c#3aW[<;T2NDCg/a6TJ
>Q9N[#UG1]@74NX/(Z-g2Y6J&]GI&9#\N/^]QA13V5aO=)aDM?C-f4RZ\=a9)1<)
;-<9SdZXDL#EcR]gJd[7#^<T2IV0>ZFZBV7Ag@?HSb:98PBDCE4,OL<0[gPG+T1_
8UQU45Ce6=]Jb?:c\[M)e+6IP+3(F:RVY&I(=[X.AZ\OUZ)d7]0>)#>OT(]6-44<
I60+e<O_2)U&UZaWLDD6K(LIEJRGO^^U]N1_XC9;@D8@WA2>Y)8fLW=]R.\437<Q
R)c\_8_8KEY,aDXT0GYHQ05RH;#5JIDECg_;JFbT?/Q@JJ10WX:S0O1L<F0^R=4B
9B^RG?OY3GKM=C[EDJTTT&3?(.575bO^YPa-eN5\e2N).B8YB0Jc;/9KP:ZHJ(#2
Gb\()V[WcYQPCW_Ld8(ZFf#c]^:3b.-U=ZZY<<Y?75c<e?<^0Y,R^,P+aEf656Bd
S.;@V;/.03H_^6XFY_-M&\Pdc,L1&](D;bG-IQcg=\aDX#6^ALBBWH#HFU]I/dX[
1Kd(9CdNbJa1+G[:=a.>X:(=;,KCQLMN1;]A&<,;PQ7R83JeBg,0]P2Ya2:,]TL\
IY)S.[BKT#SaO^Td/g3dB7QI-fC=IAP+&J#8__OX]J0f79QY(fQLaP?e4GC6J(W#
D#^e#ON;NL[>KD-)\e/-DH(+U7Z=BaLbHBZBd8@0c=6&CFFP_TMV[6ORTI@_P4]2
/1_;f<X0=0[:;eAIAH1A./OLM+>HN>JZT+NSMdeG0a>[Z(FJGY4,(4ab]]AL&WP:
P-?CA(6&Y/[gIX;1PY05(/#e6W?0Jb2W,BN?bQ05._.ZeKU96/AS+T?\Ka?:NR-X
bWd/VcFeF]0bXAQ=_)\\MbbO)9H)R6MO,+E>KeL\AJ&a4\Y-e+IK&)WbAY-F73A\
B@S6-9a6@E@>.QaEeY[M<5WB//LW4/,&e30,Cb\^61.@LfP\I4V[2J6RfN)Z=97\
W->8GPeJA6a&K&6If6Z?8_7M]CRdbXH8#Z&aXgY)M4MSGQDK(?ZD=_L[@,DJ1YMC
#Xf>IXPV^@RBb19>V0RM[LC]e-&@f:EJN4#ge>Y5a1PA\Ta<P:0cb^7]NWRPICd8
Xd13ef(X.#Bf4IfFI:=NGKS@R<8CdLX\/T]3Y\^9KFR+WAQ]H7=>dI)ceD=?R+R#
(gPVML^AVgAg;ORIP#X[??\bIf2>OAD&Y17R0Sg]+80&<+E_A;b//@B3_4_MOM+U
T,^B&?U_)UIS,QDWFf8(_DXZe+>==LC0XK4<0cCCbbKV.)g(F3A(E7TQf[VSSO(C
(6Ee/EO=8EK-GR>aX9Ofb+(&aJLM1RbR,_:T7C<A&W&MGAVG&Ic&#IM#A^I(a6g@
EX#)X)N#0G51W(_+^E&_Z():c+WBeK?^<Ob3Q=[fPBMY;D8)TW6PX)+.EVL/Y.[G
H;ESZFb\A3IP@RA>egI+_S7TAFdMJaPZVeN[FJ^Ae^e,6^M7=Ib2dV.S&_AbNW<O
5+/I>Qb_P3@K/KIV6b6,+697ZOM76PA&<Ld0:d<>+&+GS<BDc#B&Wbd@WAcGWFJ4
XFO@AC+7H<AeUI^V;1+2MY>^-DAZ;gDb#9\SW:<L.::4<+gN4ZX<Q+ggP<@Q[=:R
=VP3R-)D.DPLbB<D/.XbN]c.bI^UU;5AMU&FCgLI(;@(2/IfRDIcW(#fET1-RdFB
M>:)OBV=)C&20#[Q=ND19)-A:IW4bc05/E<&^B]FU;3;UWPMY;S6).:C<U]Wc&T/
_6D_N3f^<)TJMRe<#++MS(G<d&V#dU23Y2[O_]LV[;O13#dB,V9DN4XG>RBK&[^F
PP81;]]77ZB<<)JaZB6aZC1EG[T^XgKPW)[F8YA5;_\)LU:LBfGc&>.RUEdVGa-W
<?\deBHAF1DX]_AQ4Y[RD+BF?P7NA0><HLaW7GXS2b[[PMbZ7-LQNERJ6cH9VM\9
C+efQAD?92N6E5JMCaN-Ue7:2J._JWd<b^&#7EF^X6O_KB/?;VbK7IT-V=70gV5O
>bDVKd-gW6<AR_VT03\3(e&6@#[V8+Ug142B08LV6MB5H82L=C+Wa1V],@;>]B7f
75F>9FcR49_\Zde,VGM:4f-#g0c(WC(8b13ZeC;ONA#UH[/X\VbF&D@LBSb@@cWF
,D[8OA<fgM_0YAaaX&+(.97gBF&ZEaSMX0>Q:?^DYPa[(7=e6&6&Y66fBJZ_5=^O
Mege#B:F/Dc#I&Yd6KH8f6VA?7F5K8O#D\5IU5<9g^c4FIEBDJgWZ&Ve)e@?.K_S
e8C=Re1-BV&XHIO_AUcAICg28.CH23B?/X\^=99;#aFVZ^g#?#85d/<=)6D+<?cB
8JPX)fU(+WN=#UEF>5)S0JdZXc;(6PU0gG)WR\\QTWgX(G]58Z>PG52WPOc^V.HG
/1_D@#e:eCfIdcaG^)RM0dLUc,IKLWZf>-(V=PJM/VFS/aPTY;0eJ1DY_e_E/cUd
IPU=YF-^=T:WX?Gf2,g2&a;3Ng&.G-g4T8g>,A;egb)R6X<5PB1cA&LP<66>WVNb
I9N-MgU^PS8LbG(>-Fe.@fAUT23fY8XIESQ(@PgU[2JK)c#80(K:bP:eW3KED7=<
3IK-.,c88@?2R(60VL_bWf+-.5T-T7><baE>+/7C^X;b&.c[U<[QFSLNTgTcNHO1
8;L1^Z:Sa.=^GRbN[&>.gV1ce,X7=O3PH+/CJ+X_Ge2B>-+Z&FNHR/L<U4M-;_\+
8W#:7I1(6ZZ>DY#DQC:_G9.->VDU7YGdKX4S]M_W1JDAR-86LB[Y/f+&H]\=gOT4
DDV@X>(0;5ZY;Ec/),9\^\a?c90HF.F#@a4=Z#gR/33b^T:\d67Z9a<:cJd<V]gF
f?\SEE22(1@KY_V[I&/^&VcaFFA5J^G8+/+(8-/99V?Cg[U6Q4c:R+4E\HB/\UIe
R^VP(cKD[5TQAR:),-;;]#e/4T.0be,F[b=AS/QSNUR9BJ[RZ&c4)4#af]OSVb)+
50O8G[EP33\\U7GPL5H73.JZ,f#-fW8??33&7\BKI[&/Q8MLUJ_7bg^O?L6KDFK#
9ZL//;7-TJ:K:=gJ1W^MIZcAgCSU):KAZ]FZN8>>JJ;NX>]]Q1X3Y/LHY@0GJL(Y
ATX/FGd:\^.EMbL,dY_V?0[YQL6QN4+?L0546:g+0)_I8#1d>;4=;&#EH7V^/^bR
19ZRK\CTIMUYNUA,3PPSCBg4?/B-/I:[WN=@e2#&G0P@;c,:aPKGcXAFSM53:IXM
<e[T@E8Q6D:,O2]S@a6TR,Ke0c&6W&R=b>gT]>>=[A/)6JUM:F(2HVHgXE:BBa96
W9:O)-^/<E;YYBEC.QBb]EY:GAVIB(:O9+Y7+7=N;94c1[=I^?;M@(&bCI(:Z72_
><g/P0)\U9A[BMPKVU/?9-59Z-@]>IY7(I3-JANTg)>FO1S;gD=\G3V0a.cS1GE7
T,>\dVOCP?5;9BMC&M7LY[^#Y[8a/X[)/#M863IeL35Y8/@@WEJ;V/;>H5=7_3<4
EW6QA?d1DQ#Yg<4]T)4I9c:84(MKg>gb_M<VS2:-8+:H\FK,b[SRdI<e#@3)QP_4
SZ4T4TDb)7gdP]L._+c#&+B@[5@Y4GA]U(SS>UbG:]#,d&SV2.&<aO8T-NH.BCNb
d)LG9@H/DI)0IAe^@UME;aL<W+GeKZb>>T@:Y&a,42c=(B35O-#U1+R,./1<gE/Y
LK]K^(4ZQU@>>+[;,CBN+L]P9?,bXO[BV><QNb@IYP6<EZ(B^4RO82[)c_CY1ZO0
)O[OYeI2bFSUJPXYg8?2dWM+OLHAB\F<KO#^?VM+,dSRDKX;;c\):JaV?=ZEOW9^
C-[T_8D2Q+gL[6((DYVZY>XDAC&<bFD7VRAU<e6=dbe32OKIQ;3Kc)G4&N9&S/@R
-8WaC-G(;T8eEO;BU+WEBR&UBK)[/\:a1cYS;>Wa1?WPMaES4@N/]R-AMSBa+\R2
@))N7<&BOWI&^6AY4LdHU;@IW8;BE\M+aY6)ORY[SdTcY2:&[c+_OJe1+EVHge<^
_\e5=a40T/A>J;X0c4>R5<;-R8NZ)P^DD=7TRTXT]d9-9,/D,J?454b\DF8BR=44
3Q#IE<:RJ]MB<]^:[HJKReN(##U3K-,#Zd>]=4)AEZ0]Fddg#1ag^[V[6GQZ@MPV
_.0?35+0J]@L_-HY,-2U47^-UAV2ZYR^L\ISR>6\EO<2GNNP&;7dT_X[58cAXG-U
HIZRGOR14)6]+fN6;@2I6_:&Qbd)FJb2QRL&:#3FK@-VbT<?g#C.Ac-7]MF<XOAB
EB7&Bbe<]5,gUTc<geX=ZUOaFg09?d8L+[,\dX=Lb7ULZ(+R,I3HIL#5aGc+H0&g
;:7AU+PJ)Q-RD])4C7Tb\^RH]:3)e3U\UQ2&)04DWJ9EXPN(HdC&W3f0#7SGU/7B
CY,S.GET2-RaWTD(;B0fU:@0=-:UN2JXffQ9OD6;M#dPgacNB)KRbOU2>Mc:?cHf
MN\[B]?OcXJI[][GOIc]4.2&U9]6Q\>Xa1e#g19E<=8JgYSGWcFEL^bDG(6/JV^F
[;LZBMDF2X4:[F)>3->4O,<a=[>7aA]#6:ALF4+Q<X5=9LG[BVR9,fG/4MB/#c[/
J5;FGPNgGZ)[U1HX5Q\QB.=13)8E<SOe(Hg10WD.#5.XN4Ug#J1QKLaX1=Ke-W+C
Ref^fAL#<&9)d]NBL,;-H<B/b?&6NFW-QTD-3gT>/RV;)3?ZeODE=40=GVTAd@3<
WgJ(,NFc,N/I(_(e:F7dA\eB35ZZRc.P)1Rd2(6]7S,F;C(8g>@ZN-G_FV?-6UgK
b[8OPeBg]0CF3EV6O)E=gKV@0F.<Q?P5,RDW7)g,[COWfDaA.]]9S^2XU3Q3LUJL
#.0N#&&gRF2\U]8(e781\1\a8XA:^&BBQ1(NgE>g:.g>eAc&=cAPe9M0&<PcOH<.
FH223BL5#)fA4/?bbAPDM@6a<STB+H_JJ[]EC##9I8MR7^g.-g?,+_W#2d(]@fJA
=gM?ZS>3]PJKAGW;P#B&aR,>OC4&(Uf37M+>\H3(XdXN+MgI85-<9\K?We\+^?K6
gH.,W+?I\7#^[V501?LM4WS=WL21,eW#64;?[]2]1.b(J_aAU2DH^+3CN4E@+PRL
Q^3T^#Y3ae9O#bBGU@I;-,QgO#8@-82/=-6&:APd&05)e\=L7V7.W,LGa(@-U4BE
5:^.:RX=BW<8I6SZTa:ddP17</8G5UaN:X;bP+\V&]-2L+B\YN7b2b4.bDF?VFfB
;&KA);ddc?(G,8YbdQ6LQK3]\F;_2+8O@;KdR1&N>)ePDQ7UZCCJ4H8cb82PR@,S
D2GO=T1F<(aH\g(#L]J500QP1XB[REA:Ead)[fE<>V0aXI-YPM&4UAb]1aAJ]3P5
WV;)RfBAc3,W]ZHRe;&ZG4S>7&;_GDfQf;>E>1OYG?=_UbKU3X7-c)[7TS=IY8c,
dOV,a(CT6J&+_OQfN^Qa)0EDW@KVeLJ(3cCF4+9P=);b@\GK5G5\M#NfA&]AX__(
7LYSK9+OU2[aFMJQWbI_RI)fE\&2fDTSPg:_b]b/=aT#CW,2<g9F,8WZ)/T0?OVc
U/)4(X_GP#OW,/;CNZU-fJ?,7R8;>5;+[M<aR6U=-:FGCb3acNAZ4<MB47S+KI90
e+caTaGXH)d[7-J7e0GWbJ/TOJ(a#,3fTSDVZH<+?ECA[>]8/L@ICH4KTY:K_a7H
L1E?1]YABRQWQe=QV9QS,83Lcc8d(ZD\(YF_QO]Q=JAINL@:-0#H&^XYX,gGM3gb
_)]d0UA.4ATL19U[Z=R^IgU)OC@g/bM2G#>f15AL^^(a:[ScE]9&d3_H9<c0Q0L/
065Ng8\NQO(2LB:RfQ(H8I/.CZEO?31XUE)X?>=CADdFP-,</NbLIMQ0IP]0^Z0:
Q.:dV_-\E0UG3+ZOWcXeaT_A][fH(+RT:N6D0f_--YS-9=cEFf4J:bY2?S^?JYWQ
QM9+YfD0-^AB5IGJ=:<K>FdZ&,HG7fH0=J[<E,O]#VYJLIT4^)G]#-GKX?3\H#.[
?c3O7Kag<58e1-8<#UJ>^^/FJ;TO0RRcO#TZUYX(DPCSEVC\Z71a5W6>\:O(De7.
\fFbE(#HU2+7^?PCM@RS3VZ--R#e:?YfG:01&,1D3-9P)?0#1:G0Z6?)390g?+4W
HQS3H<B6g86DbL,H<.)T^L\9T\;K(^KaNO]8K4>,[Vb[-N,IQE:XA.?8I:FW+CIb
[P2Z:G>7\9>SJ97U8JJf2U\JGQ?=T]J-C3F9Yc\F)=c;Sa>_Wa_S+fBRa+7:9Wc1
1/eS<-^f3F)03;G8beH_6QX<-a1A0]R]cT5T,YDA&51g;1BKP5W]IcIY5ASJI\Y0
0_Q5>W)W#<\IZN48(b\-:9gME-;TN6&N-SK7G-NgKJfMZ./ceFH[-f3P4[)8H#7_
QXfT[?BJW#GE?4YbZ998P:+YE^:g.fU<J9PS4VWd&516KQPD624e42#VO>DFYJSe
,OUc=)&IFB8]HJGXT=/-)QD/b?D&?(fU?A2XHFb@4&e1;WE:X8?):=O4cD[)cFFN
8\/aXY&dB,eeeUK=#-8dF^I2gI7RT#)V6)d0X,b+;KaLd[2?1We)38][JQ73OU]]
POUP)a6GN^G;C0]F>Z/d6e3DJ,RW;&-D[3A83>8FX1WY:cf48Ba53?WPe)6#H-7[
:)8[I3bQe/b:#OgJX.Kd;@3A#W-MW/=VfZ7]=?gT_/B]0P.]VQAN@)F&C#gWGD8J
W&8Q0Z@/66d/>4U,-CEP5>MOCdV11CZUIKTDMT@A0c>/HMG4JXZ@TA[.WQP,8F7X
Oc)e8\g5XTAN05P30/+\\)&/C&LVP<<3LKK-cBEGJ:(70\<=.>/@S\JX9;X4,d,T
JAdVMGPI+84UF6d211cE_IA90YEZ,PYB5,ZH#X51-,/RV\GegL&S?^W+RPY6AOM2
<A0(aN?FfDV\MG.]H</6R@.a73>bfDDbC<(LT^Tgg&;eF=R4>O1BL>F+AVV[W0,B
ED1(Q7H_?#LDGA9C+e<g+[DGWe&c?1XGEO=5_DFE:D?J78(,()<ZOHf^R.77-X0-
ZI3&KB9Y8@?9/)SbS0GT&[>0T^1<f_3c-<]ATV81PZCBOLeDE2^B&Y:3c&4dWeAG
@Yc5Q6]DFGXG?D1^a^+3P5#>H05c#3-&<H<e@F?AfZ<.TP1<fe&_+:SG3eLV548/
O?5dHX-+=g\B(3eM)GR7@cFM.>TYY+>31XNOc:d5?_/0@eaD7e<(;79>B;N/>1FR
b.\=9g?/8a.)-7ZDd8Z^V>CN75\X=,EL.>c2bWWW#&F98C-E;JcQaLVE8:ADgGB0
?d/AJ,&d2W=Y;JN0AS56:MBd\PRH#B_01KM62ESGJA?GZ(&Y2AH/4YPU)128+TY2
<T&NgT5;(#e\L4\U8_?a+]4K/QB+.WH[CQD(TO0L2c(Z3&BBU[d-M6\[0CcMS>1G
^=CM7H=(UBY#5U2\8\d722Y06/ZUDR_:#NX.0Y46?4]X0A)bC&_0[P^HOc>XQZRX
<<\:2^c#I@Y=C&S;XO.NGX^#K6U1+SgE<)A[U@A@:D7De28cWT6eX8[?K,\PT6V?
I6dIXd]=2T):84_LbeTS#1L-A\G+60IGa^4ZX]BVC5A91T3E\EDG>W27.f_[0VMJ
RL8DVV14daF?c3NHfOOUIV&H/L+gR]]N,+8NC>MKO&YfT>b]O(R1FHB^c>@GJ(R&
#gE]>#Ja@8--YJd+<8+9,>1K+@GAOM72Ucf5B[GJLbfL].9B:DA?R.D@1B6I[Ted
MF07CH.WJd^3(b8:VXGcQ>G[W2QB-RH<8O/WbB9TJ_1S=]:b(B,#22#<;\8^8PM_
:2\2fc)V[.<S^+9V/6TfL_.>R>--2QD>_:)Z/T=g93L0LX/e<S5]b\F6^g#]a^Ke
[FBb_6feWL09S4(f71^88+S5.0a\g,+@d8.CK#GN]S:I#C.=HR/64[&7dcV,ANJI
;Q5)Vc^MDE7PBX9SBDcR979>I.LJ6\_Y06+GdJ.9KDQJJaD;\9:a[E>3OQ+2=d]/
A[FK[D0[@?<Mbe)1dE8?\>3aeJ96(ILPB4b5b08(a5#?46fM[AC9?;,J4FV1RI>d
SM,P:4GB#E0(>0O=80^5O)9X[59)Q]eEc-7-G@aYE(+4N57I2T@,[b6+6e/ZXUaF
#9[L)+S4A#_VVWDR;KJ-GTH,=bgD,G0PG\T9G\gM8]]a\bf+?Bg\&P1XMP+D<faJ
R.KR_Fg<OOa=E&JJ7)E9LF:7NT\M#R;ASd7PE=KR=0U<7T:(5F67>6X<>:9-Tc]=
Q=(1ac;(V7gWXG--8W\e=U87[7(#T(Q.K4TYY:@6@#dKPQ7C<_R&I;/[S[H=:)2P
f1;Jd8)cPH0<gM&XUS8P97]>E:Q=)1QgcWUaE:GO^.^G<(F&UV##ebN+T-)-NO)1
U,79L#ZG+gGA.:FXaGeR,ZE.EH;Ga@BULID=Ag/FAH:IdIa?S(f2#G<T\LdR&>24
[J^Lagb4<c=\7bf/.#^XQVTg;Yd\:68\O=O5,M8>XW#WA]F7)15e(7ggNY(.0Z<@
)TeOQ-FUQ2)-WAYB?KR1(];Z@d+N2aV/Sg>M6?N.U;)F=IA+;,eC.c)QSUb#8L=:
.-_,c9@Y7O3cT-BLOTgENb??CA+)#+,(GbbXF6JDT8a&T1E<[6FBK_8FZ)_9ZKZP
]6CeTc[D>dB:GQ/??3WWB-=\;91)7]<];L@&8b0+a.cLR\=81d+:D6Jb0&1KA\.G
D^;V27I02YYb#1VJ)G9aRc0@&e;=Y)>cLX.DERYCE[F>\XLNP+6d9],T)4>:?NMU
E.[?#7QKK7?A7_MN,T)+YE)1g.;:FUTMM]fSF5;Q\U_dMUH+&AAY<dT[Y5+1\/]I
Ug_5U0=2LRO?D68gLS&T748QN5[L@-]3U-Y1.>M73c><Xa?>CLb9(2,J.)DT5+0b
#/]TI[VcS=\27>@WN^3<P8FL#QYK^\X5.304ZO6_TdEPO>SG\6;6Y#(AV-=6WGB&
S03]ATgRgN#/<N.?f/8gH-S=TT5GV<g3<S4>8:f^4P>3_f=(5DeKFTXX=:H(>OT4
_/T5KbR[Z#.^Z>0NWK+A].aH_TB4<MG7\9H\_FYdFXKS\U,dOaV^1-R+G+TM8B<J
Vc<T5@1\R@(X+gQ^_g>Z2DXQA-]LN>bF(MWLL]bd<YK;WV^32&Q#8#c<-8Lc61>-
gP5+Mb2E26Y\9B6eN_X8QKV(GIb-MA-ObO3RXa=,OZb(_>1::-f<Qc^WUY-[5TMA
+5e3,H_ZGV/TbZfUT5^:R(b,[XI#e,3d<N<-S#0KX5L6H>=91GY]:9RYMaT^,@:5
KIBe.cXI-WcM7(E\aQAdgJc-f_fP+Bf\527ZP0\5K/HEM/..PUW>=Yg2GUNDD76E
X-,IR7M,bZ^:2IDb;Ib)FgHR).@BE\:NJ4N-Q[E>?bL#[:MNEB4Dg3&/SKF#E<O]
SQ]^>NGCed22[C;CFD]-L>]bG4A1E>.^e^G6b91a6QASYTPB^9#N=Be#?/E6)5Lc
-7&Q\+YJ758GDe.G38D^0ZRa/6&3\EZ-b8[<\MXBeDd]GO0U1O8WOT8T+H0WRI9]
VK;)@&=(]OKOd^af5PaE..MCfaM<0EaJQX/;VVEDY_C#(CcOV4_\I:?TfI^_W/MP
#)ZA=cZ5J7_QDef;J@?I=:(D]7:&FIJ7L.I=&@JAWf0Z>H<.29]R<CZ&eY[<K6+&
&5b:9XPG[,7ULcZF1?-:NL/_T&-UC\.UOQaWbBag)Jeb@@1:8=],>^69[0)^g97G
VbGV\26MXHO)JUXP)<UQC>R]1e5Z=++B5b0LF3e6<ZC:6>#)CL3UT7aZ<,3D7JfV
SJ32^Sc+P+BG#7JM?_,<]?M)E;c[X^WRF3;PbJ;XXH(QO9(&gbG+^SUU.&D).gOI
I;aJ(fMA5aUfUYLTL]Q8I=O9/,bQNKN#RVe-/:L.Eb:_NEWg,7\-WL[=-MbeNU:Z
7?HKHGgIZc#P.f(VL,)[b\?T+]0MgZeKg0;/_KD&ADT0II(_A)beA<fGBVC[I3ZZ
Z;,ed09ZZ;8]IB[Ee+9P_:IY((:J<YP8LcILS@5/_cV4_1A<9.+bNP-6QA=5<[G5
R4EYH#QICTaFdeN)Q7CZ@f=IML>bB<@9Fcb+fI8.PE(I/gP#;Gd=]3W/QVZSP#SC
(dSD^]I_AE\W@R_9b1JU;S=HbFaaaK2OIdD?&R-DfMVKMTcUE>@QUF5,LBTU_NG:
+aDJR.@OHdQ0S_)9Yc=MdC)eZ,\D\K6e+@A_D26_&]a2O[9cMU)S.6/+H7^^H3-c
WQ^d[f)^R-8?./YS)]4]C@@UZ-(TS6(c,GFHD&ZSC-gGZDKN?=g,>AfAeZc,gBR#
B6VD4C,Z[ZCGE09Y=UU.d1OgI,12&FV))e9/d/Y(7\L[=M-IC3RfAUUC0+1d6O>H
KAWc5:(1XH5<CPI2);8>F>MTDGfA[4)f\Z3\dZS?UeC^E(^bE#FP1+5f@9:-M;f.
Y=]6TL\=,0Nf8SKETB.R#Q-9/C?2JYA[[BV0TCLYef<8_,(Pegb;<8O=AOcS9C7V
>b(g>TU88.L[?6SYafE4R&B_0>@C_N1:,FRa?UCU>Rc\Hb1F9G[a1T-K]_(L5PcL
J2[I]AX,Y5ZT]gR:@(V52G)a&bX:c?,<+TPaI_:1-dBVE@Q9Y1QE?2T/;Ba#+fD&
,d\H5G=NWNZZ=/f>89A>U\f8NU;ZNd--UI_f)-_\/2R=&X9>L;UYY451+]YS.cg)
fQJ4?VY4@YXBa2H.>^>K)B;3b2->?&a+/W&:7:6:6YR_02W8UL-;AFfWf+E<b71H
?@66L:E>HW5/>06-dSW(@AN:4PIDFK_+8HbWTWf[bBJ2ELSR^5e]b8,;Od4-I8MW
;FNSf[]_<A^3JFG.PIHXC)N0KfK&(>UYcE=55BVUSG1?;9L@L]DLTGfL40E5NeX?
3ad_JMZX+)Z&_Ff@KN8+_,<C(S>KLQ\b<NT^QgAa)@COfQYN,)J<8DLb4b5Q6=#P
1]LZNL8>W6C?/8ZN2aH#7ZMbIN+6MD=X>I6^P8-XV&XO&fJOd9GMgM@f.:^U)5X^
G0-8J@^[fA^]TI_bA4BOfHD\CAF8=V>fWT&TNVJ+MKgQ))5^EUJUX:N[,eg-MEbO
2?:KaA>##D\QId(3IQW[e7f2[X]J#2b_[2]BeebeG_QJALFSc;PCR4ODb7HFG(38
IJ1<2^e>JAA[Ceg2Y8f7^<BS4RBT;SZ2=7#<?OJR[AY6I<:A^\:B1+3WTW:Q^GB;
B/eQUaM=4F/8G<#Y1eDZ)7Df&=b,f-=Ya[8BOOI]PIeZ:+5P\G<1J6&:T#b,(T/H
@5JZIB2<F.P@<HI<C8@\V-+8f\>=#:fK0(-3;MRL@@GfJd-,OML1:H7X7aA#fX54
Z(PbOAT>=5:O#LBG7W,?Ca-0/L7We2[+9@RLHSI7+WHO:\Pd_TH/[<IE8f#48\dR
7R;@,\OO3NR5?;O#_#]^KCDD;a@[-MRVF^WJ-L=__PT4BHANM#;]2bB695EEI[W6
.;:f.//OPS^MY3,g^LR:W?GZQ[4I9;I+<84Q.dT/)]/.KeK==cX8TFRKR+N#/#;]
(M1QA.0OPJ?6&0EK,ZaM5\RfE.Q6gLR.[ZO3WRI\W8\g[C(KC-F,APEN(QM((^2e
PZT\-;BC:&;dEaYg-5f&eVN^c\B8O/G?8)bcC3<S4#a@SWAF-?2LT-bT4A]-Kg)c
0X7g?JPbg&8J-T1=[DDV]JJS9WNT]D35eU@,?:Qeeg<Q:b2R99PL]R8QBK4f1Ve[
\#Q1)K_f\G_2BPALS0/a(EW]-&bAC]gFKW/2V++9.LDgbUK?[,05:-&RQ-QT1fU:
B/(dX,CG#H/@fA/L,V-AVG_OP9Xd9/H</H=;[<VXTZ^SaMIMf5+gTL<d)N^^M4_[
6)/bH2cDP/eOWQ28]3ee?SNc7fOL-XeA.RI7V#cB69RbXJcHd7ZcPI680@T+cc;Z
XEQCDA.Vd2Ze>[5T--a-IX&4X/e@Wa>>SHNU@W7@A[0JBN?U4W8U1X:Ad2YZ3=0U
#,G9,d>Q^)C,.c/W+._J6/&@TUK<BT9a@(97QL).IEV0++#g&L=PCd-M<e;acCU>
.@L2K.E>4)BUBV6JDMGHK.A=\&CfU1F\3.)D7f@TRX(E+<2E\ZJ(:aH1=1ABf?59
L[,1D@W+VN9CJC:2e)ORD],O/(:gOWa<G4Bb=)(5R.Z-X)b)J[fQF3KF=?B(;3Ia
;e@KfXJLb)/&^(CZBSIV/X_=+GJb^b4Z[@@[bY.VK-6EY32D=52Ef(W3EMC;Me(U
_/.GXJRK^=^]]3?=V9FWf>D49]-I..OV@+CCF1XC2I?-a]c:D)LPA5N^FHDe]7Mb
(@gU<cP=]<aa:S\[9>AaL-BJO6,WM7:R4;g^b/Ne^RHafZ3=L7ZEe4Y7IMQK0#^_
1?a]Z?Z]HPf@C=OB\J71>VHA41-YZ#X,]MD22>)LH1<CHUS]7-KC^-:fN4;F_NPU
<]JLF3Sd[W@<71+JL]a?W:Dbd#=H>F0RXW#PT?_JEgOLP[07?WV&5Ea4=a2GCA&J
L>7Scg1IJB920LMa7AHH]N.ILQ\X110aDYJWD;AS#U0M5.P88498cVP+?S@O=ee3
EQ]659Ad=)45&3HKU1RXcVa@410^;TXaGZTdCP/S/cIXgO5WH\9//5VPQKM[Y_?(
H5aS^3#?UdGGBT8B^7M@f1]S4&C?0&G.:8&Ugd3e525_5CSgNEE&_b,37&#HZg7H
(5J_4Q/Y1OYP1&SeE^J57<C\QTEHJ#N^\<;Fg]])a([IM<:2&TZ0Y(a(g^(6_RI;
_SXQ@,<)C8:5DXI]9e]HRg.fYC5S4HG+DY0X3O[&bBV&:EBbY/?4LF7,8TCd)W2g
N=M(T#N_J,PCKK?f4(/.QBDX&BY:X=DJ7H2B07PU>U[g4R)57eEA_7LY(Me)36Y9
Af9DVIMA]:eO1gU=^FQa28P@(3T=E)Fc3W\bI^TdDdCA\N[5c9HM1;C?GSeC(7)2
>eYf+aVKL=.^18@_Y=0c:d]H\XDC&a><&QXO:5BUZf]O:9+160]gVS)^aP\\0Qf6
01LdP.\(YM_>;XY\e1<[6IaD8YH?Pf2-L(;T]N07F&ESW:-9b5KEc]S3K]/0(<3[
,BWJ-;#;fP[8@=OE_-TB>OHT41RD<TcOGBY5D004:aO+fK0c+,1aO?cH&,3@6#>f
<A;&Ne9RHbd]?NH-ZP+DB[]KDJ8</MH;>SfZ\6b);W#OYc8de<<_-_4:C.(dSAG5
dQXg5EVe_Zd>^^>/+((:OMfa@GdBeCU>ZdKO7,]73+:L?3]CCAA[>NJ\d2J5[Y@?
0E5PY^6Nc(G)1ZXYUK<eU+7R,PLF#dcfNE,67RG+Q_>><CSJ2:IZ3YdB4G;a3)J+
RRb[-=+1.TZ0,_g>Fe1@O4.f2UU[EV&REc7::6B2[aLa827PLWS=J7=[6=\^++YY
+gN)6R0-#e3:9fMW#V#f8;;B@f.,M<,11IRE(4H<P-CWST6,GF0N\ZMQVgZ=^7-,
#cUG-DZVfU0RQ=Aga;bQ;bZd&?cM0Q<J\+Y+&9e>D^5L0L:XXV0C?^F3QbR-I_J:
.MG5YU-&;]dPW<WWc4,.<FW17CCff2-H8].dOcV.^GXI4:PBCO=e.+Q6:6gF2H8^
U)M,P36&<eVSBU9[VTC_QNg1_QTE0F<FMP0#fZ@?,XGab0H?=-@P4J;?H^WD38WG
<24FEZ=X>LE/K,3OKFG[3>ZOM#)#D/McgL&H4[4HZG,)^[)c>&<C)7WH#57R2S[3
+D1]YO\3U#G/11;6P)L4W>N29bNJIPe[94(70b)Q=+\>W02g+(a6<L@OgI++=2\H
+U>^I.9=[+]04LW)f2J_G3VO]DJ[-N_aKZ1;GgYI?^E9FM.76C.c@D6f[-@O91-4
8CSSMg.JAQ?NaE7=E8)\A@LR6/IN+Z4@VMYUc(&-_WRZ^_U>?9/f@#GKLf,JG9K=
>=.KDbd2[1FGVR+/ZSA5H<ZEMSbVF]HX3,2LZ]07g1+R8)XCYIbN)TdP^5d>E_,K
L+Dg.H)Wc3F[cOGL^cWN6WE3cPc2F5+XY@.LY1#c8bQ\]JfVJL2TW-VLg<[+g(]P
?)XF2OBW@8JU.OZVV3E?471Dg\:f2]FY:RI.MJ,H:P.?WQ.(@/D6)L=[gG8D+1JE
JKcZ2&^a>8&LgaW=eSd/)P]+\Nb#ZL[T5[f@CgPbgS]99AeUJ&+GH\Y5C&3N<f\C
Y?dM?]\Y8MX^AEeDfA@\e4M=FN#W;KR_gDHfJc=\gDIaP=ZJYX2:R):J([fCT2TK
:]=&@U/Be/TJBaH5a<5H.NUZAYMH05=6)1-1/5X)>G:PQ0dCY&E&SOXH@V/Y5d4b
N=5,cBL?:-+cfO.C7(Q&HYggANV&3=JIQeVA@ZIKN9-JdB<(,>3Kb&&K7W.f<:)I
[S7(N<;C/O,8VFX_81OAJ0KReKN[e-5g8/cMXJOK08Rg),H?=4H4P=_N>(5a[^,#
cPKTO<3SP=ZO8W_2O85:(+;,WII3e#67[;P0XQAP2U3M]3c<_G97Xgf9_&/F&a<L
6R?[0BS=.5)91JH[J-YZNd/.UcVQO<K6M2E.55G@]\YV,H7\?GRM=Jcd>BfLL[53
X.1\8S,&F+TI]c4&>RW6+8EIDE:N&P\a[?O_0J?KU-<Z8^U1-#:ReD+V^NHcJ2/3
DeK;9>E=\/gKTO7#]\c1N]K@C(F@)f/Y<[Leg)NcWWGZ==O9<;)dDZO6Z:R4BSbQ
:JYUMfFLTd<e2@g602X[H9)__I<0O.g?#_JD.5?T:S98<D6cUR(E@bT3=,;=LTZI
DBQ&_T=-Q\(;(^-b:D\H@LYDb^(A5f0fE9PKWW++90aa,T;\VebT4P0^YD=ODb9V
0Hg;EIfRB4.JF0)[IQ-XaX8MT61BbQ^VX0T)0L<]8X,B<BZeLI8DA,I(E7GX36@6
(Heb;)F=)3P?UY?a]SD7[^MaP],(HdB^Of63:2+7&I0TC7-Z#MC&L/]K+<YF/.SL
IPXR>XX^3fHf#Ke^7c383D6a6WQ0a48B1)Md]9WaV&X[VE],@S4[(].)Lb+?M+O(
M)REXL.4^LK-4d=,]8=CFPLKJfVN#GKHUOeKWFgTBd+0afa3LG1&P\,HCG6XU,WK
AENbE;bC&P_K.EC+bMdXYYc;7<M;a)Gd_)+,HUXN(Q#7d;.Q:65+eL:]619SS;;f
/=[;#[Ha,JX=6&+.a/C:DA&6I@S8N_F81S)1]3]5EXRA,YA&,AeFHQW7CE+)<D9e
dQdUbAd@,f?6HOLE<0faVL#P@#DH)@O.[U5DY7D]F[YUJD,^WHfGCJE<(c-JIYEX
>NdLdW+M)JAMc5;AL6<66Hd02E79aKHF?]9Pd4\=4gA9aRLVM1)(&:SG\6B5:N8&
QKMKd+K(+KP;^8C](XA7G/#Z1_954319-A09=?WB11MOMda@RJ[Vg+\KJ?\JM71T
GAPfPB5+Q_fNaYeTeVD@E<B3<>@T)[Q.(VH4G<UTeVGSB)/G+1OFNA?#]#+H(T^:
N]_O^/C<);7aR23UO)X+][+c)_</,4/PGC>^:?93JXeND^@:L(N)>YfS2=MB].W(
>=;,fgU>P@4f@TJ).ea(1G_B63f8D8Z=Pg7XD1Ma+0H3Mde@6OCOC:Y;Q\(GDP@-
/8F8QZ\3.AN>7&3,CQ2S4Mdg/F3REE9Td@2cDKBRg^WcAd37^&8;>FFJ1U[b=C9R
Xg@\5(dFJIdI.FP8L(K_d=XbER51#DSddJ\J1A.F2dF4MH#\^DVfJAabX8PBSV:#
49g/ORaR#W)ZL)6VfJ)BD>NFJbQ+DJ9C:J@Z.^:0OYY44Ia@A^8dMV_2PIMLXP69
[Q1adS@@6X@g2/)Le)]b.1?<RSF^BS7GaLZY0f1X9#?;YU11/b:M>C+6XOZaNBDE
)\AWeF=F;OV73.SJ=Z3;f&J_^cR/VQOQWL4LV,0,#@M)NC+3W-)5VU,.G&0KCFW?
1d\W)B40WV8-7&KT3Q^J1d:I])?bb)PP4_2eNIW#30P5::1:g_fW;>EQ/71S1Q<R
(\:59b[H-)66GKPQeTLCARVg+NB7.]Df6E_HeYWS-<]_JJ0d8VTPMOZV16CO-5<G
(?a3gO3770bca2YDG8UI3[)a[=,bS^D^7SVPYTR^RCdOY\3F8b11+^E@_?W#=TI<
?FeQ6,[DN.5H[TH538,Md]BW8&QA\KTgDUU9SS6c.eEK/N,F07E&JM2Ta,f-:6UL
fCd9RaANYREXWLZe97F@Ug733;fY\R.^62;[US<]<^[5M7CF@TH&GP1Y998AU>[0
.10[7HfE(V:O/CA[2L.)3&QR1;AW8:9,Y2SXT@Hd0,6NDfLL\D@[\cP0LagIL#&W
ecf6YJa(ST#[bIIAWHQ5(,C]XN?#:AcA?M7Y2c^9#egET9+LX]QcAROLRZ?V2-;L
1^AR(ae,bQU</V[&;c,7?ALIG8Cb7O,FOD+F>]Y/2+AR-]^C.Kac6\5<S&Q7=f3H
TG(UUR=_Y+8bRL^2I=?deS0L7G0//<A?P.Z>Q?<]R:aZMc&JQ2O-U7gBS?T6S7[<
HcbX9[<;B.PLFg0?8@6^DW_<O6R^/JV.;Ja[YMMI:</c4^G2F_ZId&5DX)BG9ceL
)AEAL^P12Qe8B<>,D;]51RQFK@0_:@bW)?X:\22M,gcA-.-NT5+;2C+I[N2dTLa+
T0H[(L?AF#8bVE_<bYD\9E)F@IfAQIgDF<E1ZE:[b)5NKVSR.@J867C?]2c\]MG]
CIAG/&G>L[C9.03L7<O)d+&dg1HZF>HVE6Z><bf?aEgKB8/[]/.PYIHDXVfc?-^A
P=LC.E5^e;E,[B(YZ=N/Kg#/TKOS6GDK4V_OgYU2?)D6DB5>T4^XYbaK8FCb\1+,
Q8PBD1EPZGAFbYX_aC?[-L_ULG;WC85HNHYg3#YO\;[/1EG1<)_E@\MUFXYZ#XTZ
.K1J.42I=F>6#eEU2.GgOP^5WE0CBc;Ef_Qc4DOgg+L[UOa0M,BX0Y3E1Ng(4YTE
OWfB6660c,b0ZH3,0E#M:?8:&;c9a1E7S>F(dbC-8cB@1)@Oca-B\,\&P7<&M;dW
-K<,9MYa#M4MTL=gJ46PF]OK/BT+L[VWReK_8aBJ119RJ5]UO>@)1C6M>?V<IU(X
[A2)<P^BM&5b;6aKY=A,]WNA9;PaN(A@&^dB;Q=JM9>@_?+9Q6QA0c0f4[]?3cLC
d5=IYA-720A7YV6d=QU0GJ01CFCR[;?N\MM7P/E6A:WA.XfgGXLRg3F;T2V[XfMN
dD6VB32=#]1gF;(Q<ac=+S5/b_PC2-]FNeP(c)()Y=>\>[[9I+5#\[SL0ICFBH&I
gI2WL10=\I&LO,;\+TH4BR.Xg7?K:)b?e??2Lfc>ecdP/6+bG8:EZ=?E:P6IGIER
HYBPT24a2VaKK92-6;?KVa^./Oe&7a#B4bU)E7d(F:E/J?gW\H,6SJ-G@1e6e?cH
L\S+4a_TO4WaUc\J:]Q]]:3ET7C>A3/38X\R&<e+;PX)BSZgX^0HS/-beb/0.5+d
Nc\#\ZUJ:B]NG-3]&<Rgc[&=4@76:Q_7_(JKSM1\e):K6;^=_6KCd/-eHL?AJYQ=
R>J7?Q]Z>YU1E;=5LGQE[f=QRA#]CWURHY=gZBcF?3=N3:H&;@U,L&d=\XH.BNG6
\,?+PIKa/bID(]GU+\S2Wc)dSX)cW7ZO]O=OO+Y^gT]J&8L\9ceI)G?(5&D]2NgM
[QSI@+\W>8N=8:a&Of/NgTH^4/Y#0.JOTK>Ja0:\QI3#cLgT16=bHaO0N2a,fedT
;FE[&a(TE3-f>C\&<\(B?#?>FZbeeJ0DRbC+.P)^VLN0-<g=I;(CcT.Yb0/+H:X>
S:<.<Ef6F7WXT.E(KfK[F(96M+44:4.QKH(eJWPd?c9I/\WgU&Y,DbR7>094:Sc/
#V\C61I0TK>f>4O/6QIF^);9M5SL8Eb1OOM>99VV/Kd&>UBWWdE@?5-4aR3:X5J?
NNCS]9I0HH>G]V6JQ0&CKNAMSbfc)P6@FeH(=Y_J<\@I:Z.&N^c]S.M_/.K,@48B
-\Fg^bQS^@UJbHY[IC9T;Id+a(FJ3&3,eX6.X0b/0OBd,IAKRWJ9P6]NN#4]<S&(
5+:+VH^0a?OH3@([_MgW6?R[M?c51+F94UA^&+e1#?OY9VVP?710P3@cQ&2EU+HD
=JAP[E.7V&YGRPLS6d,0T@B#=eEgc6M4ag4.7bSNMZQR44/.-3N[RACP/1+U5D#=
9?9_INN5C7f-<FG)5&4BKa<O&QNFTV,#Zdc6&ZC6U,@VA/aV8bB8Eb&#bOb\&>gH
HM[f&&L^^Fe0(4<;0TY;-F0PGAS:+HQ>6412TK3E.:Na3G0=QT?AW<4=I0B[+c7^
4dHU_:b@(9JcH:+b#.>IgE;_?[eTRR^V#e6SE-TK7U(CdM#GI0M(W:8>0ZAK8Y^Q
#TJcYe?6>(g8-^0>0gU=9?INC[UW]aK@YPC@PaL\QK0.WSAU<T<d+.2A/<DUZJLS
+b<SX#E@,0EQRFT(A/MC>.W[gBQ35F]PLORTB_S)ZPZKQX)\X?0>X1.SVHH@b5P,
Y64>e+JL(OaU(A.F-1Be3aG0:F]5HA:;,g<X+Z2A479QT\(#;.+\K-+HY>&4X,_[
B._B4b(3I9eJP2</DTbTHK_,B49(R&#;Pb1LRRD4K[ZC=8OK@:MMWGVHeZ-.FVgG
Q&+ENN-.VJ8V^ZA^Pb.:2]R_B_-Q15Ab73(-#^7:\-1,#^AL]9UX[?9=S9K-=;V6
#;I]?DVC[)/JdU:1X5>0e@8V#bfH+M(D:1A:Db9J.#fV@<GAY[8&CG?,dC;U4H/a
bdD?aPETF7\YX9FX^#La,9T8>-WTT\#CEGE=]H^A\,9[gT]Xd7S\7PEF\^.5YaJ;
=4NMN-/THXAMfTf&e\UN3b.+,K,BQ38HVX&D\@CE=/47IZI(eUWL1;RgdLE1_1bc
OT@HP(08-SJ[L?8XR.VC.8H:;8Cd&:YG?XGRP>-5Xd5e).F47EYHDbI_=K-BC,\Y
F5V8,?B2LEUEGG-,X1L+#P)BUcRV)B/T+\0]3B4fgbDcKB;P#NEID(5R^bK]e3_E
?A+c=(NPLaJ.&+XZfQNYUIKJ7<UT@KK8K-SC(S7(R[LX:HB0C7dP8B021##44^1[
FX@\]f@+.Y&3R?36W(.+@IRT>#NX/_TB0[THW:I[FHOg8=OF]W&XE[JDTB4X^57a
;[OfT6L1a(\>(bH&7H&05O^Ea&948S_P@EEV9^0>O#aB\HMRO1_NX+)5NK.7Qf_9
KPA[PQ/O0G+^T=PJaWd0<?C[QAZTR7P02B6K<QCA0@d?@+@FVZggW-=8-3D)/bH[
34VbQ8A)<eI@?)-X^>aD^9+K_;^B#V]3:_HUHS^e&3>e\?II8\CI#e.]DOdDa^1b
I#S-F0#]S-_c.U3W-9=:#X=,?Q:2H4=9E2M)6&_?TIRMJ&OEC7XC=c^N]V;EDRJf
cGS+T@bE@Gf8cKMA@;A1,P[RIYIH))?D]W&J2bQT0b_Te/Q:/L@KZ8g(+YC)f^NY
&0cTOWWDVJbbZb0/=cQe&^>eS);TB8MU3Xc5Y+ALQb24((g30]05UBaK-5V@N5\7
HRUc+,,Y=V>1@XBG+0F/59&)NLQ:2E?f/&K&2f&B3I:GEMK.OF3JVKT@WG+_XE;-
L0/W_<CRAJY/-S2@LHS,4e&LYSQ5Xa:AVN0U(#0W_8LK#=/De\)g]fBa<RCP85a\
8_9F>:)^aWM(0GeI;I7agS<b:^C8LR>CTXS]86a0O7\5+-2V>[@K-_dJ?[PECZZ0
.3=0RZY(][:I?6:>6Dd[)[,82JBJcZPA/SQPdEN8\b[YC5T2,c-PC1@@abfD2(NG
\c7SLI/.I,=]./.)Xf1,=3.#+aUgB<<M:XPLF7bgJ[W[C8V=FT+Eb79PaL;cGXVI
10QEH.K+RQYPc>)4(W49AB<XQUL3HQ8JS4cI8TJR[0aeMYCSK@_-LOIE_S8^Z11N
6<d8VQN3()KAWVATC>AYIM+gB==1?S/4>MZH#6P1Ad9N6Se5;Qg47DeYY62RAK9d
&Y5]X[N89KP6JDSQg)Y^bITQ5Y4;813>f_;,L-QfQ1^WZ\PHV0c:aa:8>IX[HZ^Z
?A.Jf&^KD\VRUBf:50]X^DO:Jd0I>QUYD=.&c0QN43F)^<A@XY,W4.4b;NHC5:AB
W5?)5KWYM3KA:8:)MZ-d9AJb6T,_N2e]P\gX#TSG.J3)P-[#A#GYf2#gSRC0Ff7I
/F?FH#Y)Ha#2R(/(fOd]0.-.?-E.8YCNZ)A:fC)^/])SLS<Rd)Bc/,Jf/9N,de6#
FQ-JcQ.K+5E?+)A9,I;A2JU0XCH>YKL6:d<CWH:#H:@]3^gM#S8#TM&]TWS.-<eY
K_W.F-4bPTI_?ZB]b4(O\^.G-PJM-Na)P_XgM9U=#>64P#Z>aP-LI\]f;V7]^TeW
W/5NH6+aX87f@d2?;SYE;U:#7(W^+/fP^4TJZ==#AGO6W=346>U9-NM53WB:.=^:
2<B+.642_2-,4<7E[bB70+FJ8+-W7(6a-UISbUIM6BgV7F8/UJfCf=-H&<()0]Jc
JO8e568EL4+AO;QHHWY)#1RDf_,d6D_eGYRIFS)3AZ2H,X#T9f4#:J^;)VJ@K.F0
cP^3;MWEd[bZX,Fg2Ldcc<:&U0(O,TD_\K]UZK;SKSM41cc67&]O9V-@\Z1),gLe
^:AaVI&6O(7V/Q75XcX2>HT.E1fK(CBD)[Pb-MBL#9WQU\0(3Fc58,2e<#/J+Z-T
Y>W#Lc3()K30@6?@]].<\C.4-fDBB)?[X,T#(ZL[dFe1FF+8AFLW>c(I(2+1AeXN
7XFDAN\;2gR1_+d72a+0aOG<]IZ1;EFd/T^>aY[SSK#]0?d(NKH:#-+:/(^Le:+)
YI?7aQ&N>^SdB3WGg/S^9>/UBJZQ,H35:@Sd@U8^?a7=H?;ZBFX:L.4V(;JH(b#-
=c&#e,R6Pg&-f7[Z8W[1@M-A6X37D_&8T:FB+VV-4b&()fWW?R@J]G\;R/I^7bU)
)PH]H=H8Z/9(-^7Ue9;^6>g=?UfNVG@)Bb:_+U@HM?0=W(5BXH88Q2E+B,C\I937
6aWHC06D5Ug>5,E]5<bO6^HEd#T7\^G/A/()V8^P72?8K#7.d\;gEL)9V\S)TAfC
STa[ULdQKO(X(IPc&B@3KYKE0T-3]JMd)_E@5:49Mg<5;[?5Y.XQgJ@[ODFf/#),
)B0b\@#?8EY?#P7B,O\H.eaM/IZH18OXM-2(=40,PFO_CQgGfb<BQC@OUX<AGCgE
RL_\^<E&bJRVWD46-]PgK8H4a)@X@1B<4;]K[H.MTXDHY1DNMNN.Pg((.gQ[#:R6
6EEc060-@)6+eKIVXL[&RAXa[<DB#-,/@/<Oe99Kg)>,ZL0@11B+,,B7L[)0IUW^
eVW?([C-2SWHSR0B[]A:L8HcGGSLBTI4XF1R052NeWdEX5Q^L61THde\<_=0M;A9
KGA82SVS_SJI7QYR>V@efI<R;);FG2?BX-UJY#+]:UA<@.g@IKF)9-FEDNX,E@6[
TO]8[8fFC-VK@WVQ7Y+S=EP(,ae#G,>6&[;PdP-^MfL-091CGP2L[@CULFeJFd0?
-D@?@H_d.1?Y\DCL\N:I.&7BUE;?P::>>B2FO42X:=5-)3-bJE4Vf\>YbQNBFe_W
L;-JK@<2E>c,Z<>79;DN856JdBLRfT=>?#0V\EI&TO7ETM8EF1X.B9Bg?R+LFVac
#6Dd#T_UPHa&,G^XJLMI<Lc^7>0>ff@\<c0ZT-fb??Xe+I);&.7U1QeW_[3g\f_2
Hc4CeQD^9UY][D.7WBFL=6UXM\U8Z<e(HU/Ne(BV+;KI1Y-[J1eHg4c&c:YLT\&)
eN)M8:>^DR&;HHS9)P^0:NQZN,#gD8I[7P9#:eNUKe#9]/N5/+0DLFP,+bC?P=NQ
O4d4_LQ^=[QZb_W5C7,=7(W3EV@e3FcU[E(e^V(:6EF,C)5M/=RR^F/0QU@K&3Yd
YT=]E6W?NF=/_g94G:PUX_@UG1/M/YRNLb#0M=>AXYF3A?,X);@I/3\\=d.SPH#d
?M9?_/FI.P.#8f886=FK?^BRW/TA7,V^UN6G&19ea366F^Z.);H817]#&ZPB2PP<
+57MAgV=a)X2gB\?<3.:AR:TDAb283b_(QTSN4fIRJ))2.AUAT?]KNGT&::27OE[
(FaT>ZWR6ZXa#B]DbH/U&43NSCOa^),VT-Y@a[3fG7Z4/Z9>.V<a^]7;_,Y6\5[E
bM46,108Of,PE7XgV.)I_77>X@]01LdL)A]d[Y9KUR#Z8G@WU[c0,-U)gcd<113/
P_+[U?2Z9[LT,Cb>3[.?:#LT&cXV84V2Z8KEbEaPQ&75DGL1BA+VGS7LRaX[.]UN
IfE@+^O+OJE[cF^MA96HDQd[Q]AfO?/J-cOI1=\<47B40[<I2FN>M9C9);J&bPZ#
7&6887P1d5(6ee4:XTUD.<W<,JD+SS^7N:([?d3#U#_R[H\4.H1^:36\;d=<fJ19
VP:FPgA;>:XB.Xc:X/5,<X<QD/)O:^=Q6b5ZL32FKNO8HF+IBdQ2P=-bAIbV&=4F
&KZBOPS;BH6aQRX8CS_ZOa4I/CB,15b/^3I;T36g^<^e2E9E4dd^/FHF-=fd+W6+
G+18bdggaFRE4F<XMYD_5AP9F-MLG5OAJTQIUK:=OgM.;;6EBWJ;^DAa>5BeJ_[+
PFIZ,PGM6?YS[=?&Z#a655+2PcNaABg)^dBGM-2<1e4W[3,cD=C1&7@)R=?MJNdF
HCc\?.c\U3T(BX8a;0:Z:\J;UUdVX.ZU57HR1a-M55(_OVW2?+J?\^O:42>\QO+@
6cZf;SF9]8;T;<048.A&Te.EP63=I\V/UX&^DN\ce.EAb6gX)73IGEP+_.fH1]];
X:BPA=\S1V^X+7BSJFa,Y)@/Ka/)2aAg+^.b:FJPB.P3[aOcGFIC]+2SD74X>O\Z
PCDPUW:2L7Oe0RIMf01O:.E)<^f,Z5[)57d3X1bO]6ea)^P.KI,,A5Z,=LTg(^.J
92YB]YY_HU9[W\)7S\\\,3NUCR^UdQPg>P?<UUG@.b/8\IN)6^a6b7+ZA\_TLW@e
ZZ)(=A9-c>7=YWC9;0cSCH8gQ3/BM@F5H)0@afa?SNS,?:F7<dE@#GFK4K-ENW&>
M=/FfD7;7+Q[B_G7S+E2DOD=Xe9OVNWLdFAV12<6/?[7VVH<CQ3OPB.dX#7-Zed_
>Ta?8PJ(A8]WN;^Y]5JG6Cg/7L,01:4g<I_dC)1.R+ZW3ZS.(7-T2=Cc#X?C(.a?
.d4LAFUfLdO<T2U\R_-&SR+ZV-Ke?@-d(#YgDHKIgL_d8+P@D1f@NTNXf(4FND^_
bPbE;((e/TgRX3Kf1dWA)L-##R;1:M5>Y5IU=C8P4LE9Db3ROH5<fWJRR6Q<RH>b
BS:L^^OYCNPXde]D/10#,=?Z5c/9aWd^J3D:bER?^c5XP+Z12N]Ea6G?3#05?()>
KCL0\be/)GXQ?;eU#()1geaA)fMB)4b@?bJc5Zg=[WK7T;ZcHM85ePVR/9&</1+9
ggc<WQ-D>.QY4<7C1(XOF\BGZPP0F(A][[]XS@Y,)\\YTH4;XScZ.HE_^.CGN^U<
^FS_c2O,[W/670,LY_>-P8ZR[B=MXHD=>F]B+Z>OAVE])NY7YJ[cO>W_JD_WF8(A
@10d.aaAaKf[EU(D3aU.0QCY.Y\SeAV68)+&R)>)YIU#8^G+b:T@T+)&WWF789Z@
K#,XM[Qd089<g)IIJBRW+U^_ESI+2g])\Hc7Wg,^g01J@S@bZ6/N,=+5P9ZA9c8W
9EL/Ta>IU9^,N.U#:IN^Sc?RQ(1\&+IO3(#:fODTf_^4KCLST;P;,M89;P175H&^
g]NRc^RA]JC3BceXYd4ZO>(P:V18+KJVUG+CV])P:b@MZZ^]F;g.6&CM_C<M7^-@
ReZT9QU;Ca46aEV\H/2X7G5=1RB5M:M1,bL-4P+,,&T&+ESf8:455b3/5:N#a_Q7
<#->@]JaU<6Y3^f[/OG\bJfe9^)33W5c>^6-.GQJeANg<2eK-XE<9?NL/84^WB;E
=/3[Y6N63#a5:WSF\S<cP^\?/[RSR\J10?--#FFW6ZR]]JTUJ]<L#dAFbXEE5(DH
a8dX2ML&[A]6e\Cd^1U14+.FQ9+0bgW2CLACcH9I-7:fR,7D_9=SNY6Da^][D@Ca
U.9W/^L(]ac?Q?#BEeCfH_ACEF64[Z9??Z(6W-d2G0EJU?P@/KJ9,gH<ADLEd8MK
VW;BCDNW\@bb(F+:)XX4E#g,:e+22RVU+T=S5[;g-NC<e4Rd5MFW_DfP2@f<RIg<
V__#,R63^[#QTgMKEDM<d05f/NA5(CL\&EXNfRHN5_XT-Zb@6cKRR7S&O5bbS^\L
S<Y>c+8SI#I;2C42YEE>a6,bZ9GeX,gaJSX:0<06]TZX@4.N1E7H&f46RQWAB^<X
W3\/c,:2(Z);<M0O,bA4+cdO#[UY_B+?6IQ_)YFJa6J[::2==&#=E>f&]86W#>11
>K#XdB=V]FQ=Qc6:9ECPe<+<A:eOf#+:(UU/O1>UFa-/5UbX#YZXa]GT4).@L129
J>OUTX\LFc&Qe[R#Oa&F1F:_J5eKF(MB\P(5df56138S4>XJ1T028F/8bGefJ?@V
/e(ET0b@D#F3:d^#JL7:IPP4RWYQG9c-GG-^E5KB2#O??=&#1+6,Ca&c<g<48)&Q
O=VIV>a7\B6g/;S5dF&<=b(fN)Ze/7GM(LFW3VSKWeV[VYf6A7c1FR#(LVCOJKEF
CIF>E<J5JRH(;X0]RJW(X8:T<fEOS\;_<U??PaB_L5Sb@4N7ec?Y3]]<@UWTDV4+
86AEQFL<BZZe3Z=YP1]N>eB9fc<UVT,+J_=9-K\/4956)93XVGZ/H1S]O&7X]b@T
_;N.DX.SZ;/QQbY&<[^2N2[E+XXN_RV-M8N-BD=;PeG_eHQ-#Q8+X\GVEPA.,Q7W
VVXJ7\<.6b30U=P?C^2H,[T]8@E=#YANC56>ESTK@)[>F3a(,0a1H-@V=W9TD5>3
Z\C5)#fgge<SV@7K#D<&]a+;JDJe]B(7TM5W6@+^P-YBC0Re[]=&1PPNc)U+O(W4
\4RH7PIcb\V&L:M7]ZU;LW,1PK__a?OA=65).+=\f;S,MdGTDC-O?D?,]:&/gb,E
96OFaSFP>gf8FT<1F(9aIE?VM+/a<U:MYMNOe5cVd,@2)eW^=CJZ#Y,;<36?5_2V
X;13CcXN/+\/<.,UI0bMC.]QRC3c>fK,#.gZTXVge>bZCg[>O.@f5?aJ^@3,4LM-
T]Pbc]7U,79M(E6W,3)97PEPb=6dF?&6<CCF;EM_5TN1DRLF5H[CR^H5S89F0\TE
693(@&->27N6F?/K?gUMdRQX<:,C<dUbPP_&@@8\W/?@B52g\^ETVLE&[Z&]2d\F
K#bdIEd_bP)\2E6=\HOZ0>W=-;;4/G/RO]P;YM;+76H,?Y[BMTOR>]ccXSROOH?g
^X2HA_.I6VP1ZPB;bEKX1\^3\(d<EG^D[TQQ/P#-e^WZW4O8c-a;Fd+LA(QHAVSF
7F4M+_B>b+bJYaW3TQWSBd;/gY4D1T@>DA4MWCLC>Td)bf:@?<;b?]6\acS[<Kd<
G(3d]29ScS&HA3,X7@/2\MHbJV:)@a_OB9J)+Db::EZNc+:E&8FR6^]eBAW^\dVL
A6F]WC6A49BLGgfJL@4RT]&ZVF^^T3A6(3V19+CTY51Mg_\B?f2gO&;A5Q8HRJW1
a8=A6CNZ3JK;/^LgZB7Y_ER0e<P>J8+5CT-42OEY7,9WGN/S3_d6)d+R>f+;B1Ud
84B>L&f&I;(c-L)\)L22<gD+FK/?[:55]W1Y<7#G6E8]92^6Db<7F2+a<H94MR.T
cN_Q,+=Ab(FT(5(g#PYSGJ^beMER.CAgNZF)5K+)T;[3\O?4BYLeaZZN5Q6+M?37
D=VB._)0fRT^M,QA@VS)GIF<bGAPXZbDYTS^;K#dW:?4X)0EKZ.[Y@>cF0X8IHHP
DB;fU=b/W-Y]8D>AR45=V/I<PE,cZSI3_LTHVHFAM,W?G&H?WRL.),&O2)R1G/)H
J8,(U5[/@\dc9gZ)JAgGd)A]E:-/V9aFZJd-@/K0G2ef6/\J>M0Z,REDYC0^>2+T
+PLPaFV@,OI/)Da3fG32:M^M[F4bF,RXf+W]UH(91/>2fVYG+W>5=V;DWNZD/gCF
BdVP&9>](4_bWeOD:+F347I]HQ1ZFMG2Kg5UW_0G6P@c#<WZ0c]DZcQNO[^19T;c
3\QfDEZYXU27J@O48]\7gbOA)EGRW2,2VHVM]Qf<bF5=^bW?QX>1&#T_DbXK(5I1
L9g;_2daO9T&Q@e,>Sgcg)f+2V0]K^e+<Se]4GV\LDLc,eOg3C.#0M>R:8=a[TGg
Y,AF98T1:4LNPJ2)a9]PRB4/<Z_;<aKA+-4\6UDH>)B,Q-4AM=cPXU+cE2823OJT
M7D9>HbZ0U(&SP;HKf88.9DH[2,]2&9eH6?=&+=-RgZ>Ya.gB2S0D/8B_>c77K0I
&]FO\aZ5>5F=##BH/EJT&R3_^bI[WOf/Ve/0NQP#-Dg&6c:@:13?PHKT6J.e#AdR
J:OQN3#QfKVQ6/P@-9ZE5N<X)V0gO3MNT#I_MR@T8R2R/f.DO3G&>)1I2N-1[=]-
?3MBbSMG4K]>YJK\509@/LP.C&47;55aUb]XR,L2O\8Bg89a>dA7<9Wg=5/,N^06
SE^I^&Q#+JNdRLJ?_3VU/K/EbYKTHJAP=>7R_;Q\0dcV3PgUO@[E,G[X/8B=c><]
&;FPS,WB,gLc(:(N_GASW(0+]]Z-#);4Z2AHc/[;0/f92g)=U[HTH1>KdW^]KfG3
+FY1F0K?Dg3/I-01P4H_C7V@DK4P;_@/\Q2?/Q)#@e.4(R;81_#TH.H.0/aCbAd9
NI;;0F(PO;4E]7;1&M)?S1C[J)XME.7K3,Y0E]9FV8N^eC[PG9_\Dgb>Q=@Tb_F&
6:;AD^RfDBVb)QQ??9K_H(#,O9=Y4D8L-_08B&/:a\.^2a,Nd9J2-(KL6,]_N.:c
d5=H4:[6?0F63:c7b<FBQ>5eRJKgM6<.4e^]R]KI0aTAc),IC-_c1gOCbF4N[=6J
.JR6\DNA[T;P-5=U7#G6])HFL0/U\OQMQ<<5Jg&??PZT-3#dH+EEMFGSPU181a&]
@,5096(]+J6,_2fDJMcHW&a9UFD//]HI7+K+^PU7_+4W.W\^9bHX[W8?;1J(Cae:
A_I4WYTRZ4.JL/-T3N2>,1a/VA?D,UUU\TI1--@PRMF2^1gO^=^Ud)#NG7V@,:S5
2XI,N6I23HX@<8K5RT/\SEBcYc\Jf>9Yb>W.O?,(.O@+K+.8#((_dc[PNVYP2:[U
,8\VHE?5.B^-Q7[E@f[XU:BddCQF6>><U7KF3/FQXSCg<_J_HP#GHf)cg3d7>PE#
(a4K,COQDf74MUK;T&541_T>)fJg(TY_QQ>A@9-]9.4BB[P)3.X[#KLUTfXg4F2F
?#a#GE+3Q==/[]9IdX;+0D7^<X<]QY+N>D-&/b9S;Y]1ZDZK_EHBK@b>BQ)dH3FR
N08UZdDD:cB(FX_PbU2+b@bEJY^[&)R[58a?+4S8@:Wd)])#<@_8S&+e+=^L.JgF
]d\39?_c[G9&:N,fKA>NE]#aO.eF6dD=VfQG9Hce;9&0:.[BH<b38@S+1LTHSNB:
KbbKH;KCW;>+JbH/W-P#YRH@B-E(VeE)#RF59L<&Z1(bDKX^^bUd\YF42#)07g@N
cZ&3:>bO,9)dd521f>JQ_e=QJQ<D)M<+.5MW[0]ZMKK^9?1SS[fIOPQYN#APHVI9
<HZEWL)@^J0;U59P&Ef8</d.ZU6QfDdb9H8SX9R-3KV\Cd+SFEUP8+)&P-bWE&dX
ST.GZB=PYOceJ@6OR(AXYB0Mg.=XLOM7<_YA@(H^83K_41:0NdSCEg@aMIG8^\YI
=6)P6MYFaN^gCGegQ9YN]8B<;L_IaV6(S6[MfT3DUI_-b,L7Ufdf5)bK/=U>(0\E
RI,gH9Rg4?21AD.NRb3YW?=B&Z#d)_6fLKgRCM^JO0XF\b0S@.fI<0Z;I13c6KQ(
U/?PF>E(e.DTGd0U]e?DFL03.>bDJ3&5=_75ZI4Z/EKX.\##IEX&<DLF@Z9-BR0C
SV@e;GNb9O0=G_N3XG.GfD(ABJ,4M3E<4N_=8#c[\B-:.6dQ<1WMBRKS6S[+.6OH
<1cLg]46NS,24;a=]F:Fc[/@E7fHEc]KISA?EL+[VKcO9b61cK#Fa1\LD?0>^Y_@
ELO/Xe[@(-:bFN:Xa<HJZ]Pd34&(G;HfcY)N1KKD^Z=W.^1NYb^F,K=aYHNZOX4D
GU],TY)R/efZ<;=WLPI9Pa]4WD]M9[Veb]Dg1H]4bMV0T;G.++d4^1=NTD5LU]b@
a+OgV7R]4P#?T3VL[[dfE?J;8K][]DSdIY2JWU2<8L\Y_;:M;adHBS(KV:NX8P#A
7g9?W1#2\FOdg<g(QN#CO;cHcJWN]OI<3<7,@Ke&ebEYSRQ1TS&g>S4OEFN-g<^E
(&fEe-8W9KB32/8;=FI7IPG.Ze>M;EgW8YSQU;g(.VM_ZZ3O0,N0-[f=c>BLSb.T
9Rf5XDBU1FK3<9FPgU@#e0&gcHbZ?8fN>O&0gJ>9=B?aC&)dP5:b(BfLc?@@,XBP
fF/X6&PUgO?N/73\VD_W.^aX+,?I\P&V^4U?b.]_B84R@gJ0d/;S[FE\]6c?<ZTe
M4J8AJMW2X/:S#^LVc<egB_,6&0?.H5g<75+_,<XEB3B?MfK@5g1UIMZJd&,(1<)
EK0K4<N9?^>/S,g<6dSEe[\.=.F^U/LD;@g<5]+7gX5X]Y4C.FC+6/=UPadd7)]c
IWf=aQDL@X4e;RGYg^a):F)c?ef_eO/X:<Z1\W5?]CeL3?9R9ZZBCCOGYR&aY.3_
Z]_V5IagO32:[)[OAR-#FdM98KD35-^T2;N^]f<Wb[dXN?1ca9YeY?1LO?N9Q(TG
1aY(@a50O4<f1EUU-<2JN[H#^W/E-#)12EGW8O\T;g)K[H10N-JG#>\_-VP2Za>F
[1G/;_S&.JS7-WPdQX6,6M\1LPQX,QU((60(^BT,b)/GOB0e\D?S-4?JdZTN.HE[
(<MN-G<Jg4E(3_/Zb.VB3P61CJI\?,L-YJA&>GFIKeeN+]WUaW>8D3]=3P=;^B/D
YJ#M:I-C6&#D3KO04._&CWPFI^f@eeD(T2FbEdb?>9,M@LbI)R;FMbgg9aGTDCM=
_d:IbfC^SNdfPU;KMS/fI-Cd(R2/9_HQFbEcQR]5_Z:C;FY8Y##M;Q(?gJQ+MC_I
/1(_1bYH:QLM7H?^SR@.?^STB23aO,WQIfB;F?B/5>0a+.9ZD&M[-?Y3GYJ\b]dH
]K3=Q.3RC3PT1+)D^JGM)Cf_JN6b4dV96JR-8[1ICe7d01UXA5DN?c1ce>9K7]b[
0d42US[G]#Ce/(d\\@b:8,:R.Cb/aAPW0TNCf(=6J3b(;@YZUPY?8)G#UGET:>25
+[J:18O,TFeJE:HdSXMK+Z;-J6JS4Jf7ec]#PJ0#2,Cb/-FLF2WQ9IgU/H78[_KM
[?:0]eO<./FIY_^G1\0PN\\2,]E+GS\+RR)-6[QTJ<d\1UBPa]RfLf,.3?0Cf?Rg
[I:ZAFD(>X9D/^#0B-ES#=Qg2g0]@W:?G0e^;L]6K6EL=e92OC:XA20?M<VZ?[.6
QYg1T2)_-_DF>e?K-8306=SEfR<]e2O=@272(^83V8E7YfIUAL0We57d)O^H;Y_e
>]G5ZRbd:^;f@DgLVaUS:aQY)Jc;f)Q&FC(91SP=DP;K--N<[CW)Z2LYMOHCH[A>
fE<=C_caNCd>bWa<QSRP/R4A+ZAe1Fb)1;=dKQ<9P1UC9B>->+@Z,1d:KPIJE4XE
WX?#3/.X;=P2LDQT/HWM2R,B<OC6VAZFZD.-G7Y>\L]cJ#E.C#+b5^1f]MA,/HP_
8>dM&gNCN[BV4KYG]AL=9XdH7Reg>@Q\0YLXeDGC^Q1baGR^WcPJ:N6ME/86L91^
K7.@_<#^#A<@\0\;/3F&97SH;JJ+UEGL+Y0aOBXA6A<eR@g2dDMKMYJEK/T3443:
EXB:B7;D]6JN<SaDg<Zc&H34S9\)(bU_U[I@NI>(K^U8DC/@[Pe<+\f:3]MC;F-^
PWT<9R>gY76BB:eW1Q@(L7/0CK+E@&a=--^cM_N11>4V0@^Pg=OQ4-JNFCFCAAA-
dRJ4L/&d[75O/TPg+K@NWaWE720:2QEK0:@HT-;cL)S?E7Q[>e7+&YW:Q]E3eHf#
BTb@#OVZTKS)YbE#.d-8VE6DZLGDG4BeKP0ZV#9QTb)fJbV1=,LC/ZfFPfd]A?7]
<\8cLJW#3J_[911aA(IDUXJ]b7RR8F-/;FR&_64]?fYa7WIMB+R.7,JKSI+D[:Y_
50Z8>#7LU);KNLTJ+&=4f:3IbN3IdY&,3[#?&S.BLG&-[SF-N-ccIRgUYF2;RaO+
O,:M8WO//KIR<=(,J]</9+)K#=TTXCN7]+DW)I_:e0Q@JENJ2/X\WH]T\M4fSc&c
MFbBU0U@1<0O?#b0O9>62ff2#FH=UB?S9A<ebD4S3.,^9TeX#aWe;=<>/,P?_.OL
QI:+87a<J#H^&IO#MNZba^1-^=2D12\OaUQMC;?CGXNHMSb?ZUCV5U5&4b#7([J>
40dTbP5&7>f1)Ya<)@9TKXFUKKJ+5;2S]F\O^3B#MS[cK45QT^]((P\:,(5P+2HU
(##fDeg4PWOO\NHGeI=QHLeP)C+]MN0#1E8==g4#;-B](_17[S-,ICCT(&^NTNWZ
4MW.JG[RP5gOY02cVc(LX]JCPA0;1?IDXHR=)g+1P(26_D]<07VeZ=B&B<.2,<@J
_F;W+P;:Uf.-f93T\8S8BK+K4.#Jc#7gZN&E&8^CIVA&<Y9dTQ0AZdDD.Ab5@d?C
K[M96M7N(AIJU(QZ6O-MIM\cH4gGf#=JU(Tf9I[;P1<WZAgT8Q70R&#d//b)bY(@
#I74TF(PdWPER_K/Gcc)EaRfY41M?[17GRd)aFaXB.&fb9R)MJd?(.6^8H._&;.C
DAeG4#59#C#8fM]NWK4JROA3NICQN9gWGdaP@:/U[TLFfFZEabe^_SR-CAQ[^bM]
@f]I<CO]Z80WVcaYZ\b]>5IIW(T4-#.SZBEX?W-0/PF^[OP<MO<Kd[0[ReBX4/c_
^=\1BdRH0:H./[?>g,(a5EL/20NU-aa4a>?Pgabg1ba>Tb6\C5XOc]@Yab0gfCVD
8SRUYL-XVP=KFDPZMDLN&g[)N;(X_TL8HIQ4/G(OI)E5_;d>[A4-1?ccW/aa-MZF
a]T[W5HbR3)EC=T^^P;+51dI2a3G2N8VZZgO40e_6;<(82MegXFCN9G=E:@C(0CU
I=V#^G4=S:R86>(WA-,MKIS#SNB\,D3XeebY:;[62P1HSE3DKLg;WC<U;#YJ1]MI
Zf.<gOAF-#g_>Z:B<:EYLRO[dOg,A9JI<&5bb]]g]H^GOM>-8cW]9B4,W+5/S(C3
8.9ILNC=H&Yef]J?.L>XM3BH64dKa4PP)T2X[^-XC+Y];-+gK29OTAL?1e?VF@]+
XWK;BKOH;IT&-\HO;Q_-(W@L,Q@UMIX[\,)=PY9a<MGUHI[^O>LB2SFTFIXg\-]U
-(8OH/_=?P#&]DU6R84;V?+-b;\E+\UNNd_BB]I&#2:)V@7D)9D(CZbZ5UTV]e/)
V;)SE#KW-D?e5XO:)F8FV>O9@V4IPS>2aI.:B.V?YM9^XF5ATMIcQE9ZM&AJ60fZ
fL<D>#3e>DP#HF>L^EVSGbE&5?(Vc:?0caN3:a^MH<5LX3C>^<=]OW,afX()]JcL
HR=<baaLXA?7<LWa)@BRIg459JKRCMgT@TFNK4:Y4+E9/:fDF^O39JAMe4@c4TE(
-c)c8MS?.c\\AS4[M3cOfH9:KBV<VJcO1F)SfZdeGXJTW-BND61+OEK.MYcL@?<?
5Lg&#Y;_H.L0@_G+@.b<TPJ\\B??INR]Nd<CR4a1V[>b^SWCM@?S:5.-B<UG^C5#
WVVA.V#ACdWK=^[TUM-aJ)8M(](JZ5PM:>3EYga/Q8,.Q#^K8bW1,GE4Q3,?/DI>
SJM-[M5AOc9?6.IBT&EJI^.DT=N01DPC,<O@fV5MFF\]Pgg:8PV-)GG1L,(K3HU\
bUD2JGW2>CB\+dGO1Q3Gg;g-d_[/F[)E,^U7Q_]e3J0AC/,9R22A]2;TYMICM^HT
5g[6B)VPT#&0/G#>H-5Dge1[g]a4BL7\=8f?&49R]gIQ/_^\dGHTO=.J;W=Y=QC@
E=.OK/;/QE>;16IK=G\324WN1HT.BC5^EG(CQ^N135JL_cg>^-#GQ1<fT-DGN4Q#
?#BF]3?Jf[G7IOX.U#4-A6)gMNO\GC301ZWQ/LCI),[Y<(@7VA\@BD_3VNXEM)QS
#51&U8(6cWH^H@16Wd@YTHScN,JP+UKd>d0Lf&;-IMWHJLZ)/24#X-EB(gK=E+9/
O=2#I4M=.,bfE:=OYg>NY?2(LN1:ceF<TXbBNB>&2L894cO/;g+f4YF0^&Z3=P@<
H??M<-B^E,7=A\ROOXQ(Q9K/.SgR.QZ=K^N2RF#;bP[M(/TcR=aCFS:UUK_4ZE2&
gP<&LfJV.JE9CJ;AIeA4_P;HdYLJ5A?2e6=X<=ReW6gHf<(eB[@37^\:)Mg.4KYf
eA9Zc(KP710aR]GgI_DBbf>A+=^J\FdD[YL1[6GH(Re>/2f^4A8RUK#069-6<]B=
+M1c&/-K5__6&7a>;OYU0;9f-AU8M<.Q()<Kg@bMNaGTZ-+YDR]>=WIMaU<PFg5D
bE;c_N]SKWUf&UQUC&E-?1PLCCf<8Q;3T2/eG_D1+:+.a78.,]>9V5Ag<Cfa/0AR
I,;,c-DeBT@>V6GEA1eB1fe<\VC5KaLdEPeGFc20J7cHR6@X?&9MT2+?EI);#d#g
cA)1<BTC]SaJ\=OLfR\dRc\4UD4KNLIN^cLfY:\,LV?Nb(@V>ZYKYVK@;f4\M\30
_f_50SS>[JD.=a&6Vccf6<YCD-[RI_RNECLV:/fC\[&N2M0#D7[]7I.cZ472_@S3
fcKD9Q0LUEAI1&a\5G=\?)F:0)#?b,(6#\SY\;UHdL)_0@.d,e5O#X>3aOD3KCMF
^X14\,NTP(86Z_c_)(3#fT?DKIBB(>a)XT1LVO\J^5E()29MZ0?NJ;gBSO[8W78e
P80RMbG=FXc:R\;=)8+^PHO?0<KfYaK+J2MaB<>/LW5OUfZ;QX617<E^Y>Z8+#,E
Zc0c#KMbYef[gEWDB7;M+P.7E\+F#CU\f7:aMW(\R0D&2K&ML:De9<O6eMa\DL>c
5Xc,cZ6d;7,)\SLf&0S-,LV4\C/I1a.<L@gZdLM(+GUJ+#BJRT0Xe;->:I#=2@(?
V.WdJV=4X7dI7e85_]a64K5H9Td;,ZJ[\27:;Q]52EOa/I^6491)c4-GaL6A43_c
G0?U=],.51E4(0F#1-.\.<ORP(D3[BK3b\5Ia+8SQH91<,[1OP1@B>dE.\eKdKCc
&S(.d\?Z:F,cI>4[HOLUG--U]eE[6NDKLBGaa8.L4f]]6bb;NTU-0BZ?#O^_JS=>
[B7FIWXFd\Z59=JHL6_YI?6KW<BTN\5CG^(2.NZPOMcg\V^PF548[P^7E/V,2R5V
S>EFe+R@V^F38V,)GD^Oa&Me[J_9ZQX6SC3,Y0b,bL/?XY7Z)O[C.aMb780L?9_V
ISXS(A]M5UdY^5^Of/F4S_.:3KQW;/8:XO[R0R0TLQYeS#:E:cI8V2;1CJ1,21>W
9ESX4\YK+IG=G\4&Xd_2)OP)G:.WAcYN>ILSA=&,/fS7=BX1@J>=</(gZBGZFedg
>OG(_.6Wb5A\eOeP)QM#_:]W\a,\HP#0?8&IQ@WZ(E1,67_RbdY[)cR,:5G><e^d
60XRFJ#XD2@8HDagWYCU;QMc\R&<;,,=/8BUW4OW7/c(>TAS<)&S7W:DN84(1F?F
B7PV,JMebJ;.E;.H/=<<^\&3_gPQbG0V)7\H11@FQFc,8F@=[G&gYI]aHV_,fE2d
>Jb/O)UOcg[IN#^ea/PL#aLSBd2)A=6+\2#)Rd40KDF9)W8f36BT;Y7PODL6[cZe
P#4>KSEc_JN,V<.[eN#T6DWLIE]=^#?747YAQc0C0-:^[HU#<?MP]GXCCf?9?W:V
4WB8DBNQ_HYcf#;J1#0283@6^@P1IUZ^J5>\:W^:-7(JV/U?ZBQ695:==93TG\O)
7Q8[ZK5#0+9AU-3W?f<AS/5],GVSE1H).A.1-+S//=AOEcV<\6d\XcX(5TeH_RWF
dV5<=(O=;#)DDC2682<1M8,B-.F^-bfD:5bL32WQf?aDa73@S?,/cT.I_#=/(C24
SE1#)=cCJfG:WS8;](gJ5<X9e2SH/IF3J<,e+]LT.8LCdMYX4<4OK/;aee4g<4N?
,9P6Xb[aBKB8RUO[7c.9\g:J&cfdg=>1ZaeHK^3OQ#7C4MO_-@>NYANBRP@6HETI
Cb,@_5MW^2eP4gW-(1K)57TE:???GH.BgLN7V&XL[?9/VB1?Q\dT+Ob4^@bQQUOa
dN?).RYSSL1Z(O)cY6ZG&H1I.\LFag_O,_\>WKYRWRW/_NL=g+g>LOXH.3=5d7XN
5I@L2/8TSFM8._6=)cZFJEN/2JS,T^1&;;YRb/S-/RCcgZfH[8U[;g7T6SNX_C;]
27)RGZaaG#0;J+H:T?\eH;SE=1AZG^?aK]A=/O<V#OR6M)e9=9aI\WJb3&JHMa@;
Z96&@UJeGAEE2PCC\d:5(4=:=.BN\g<fY,--5HULDSK6/5##Fe7gd\WaLKdUZ+&e
VUVR:V#C0=[g7=GSRe0#L9QJG.Q&DUa<G+G>P]7MU&#4;-LBaX2/07\8C\,A9WJe
WR-RNB=AJ^F1Na#(#IKI]]FFU18d)N/7VS/OORE=7Y7&f#AfF_bM.F@TS43#F;&G
.GE0@B2&3.+M6_TF4^C3?>eb-H^SPNQ/C=VZWOe1O.:>35@,PNg)>N/=H>A[@Z.8
T<Kf+<PP4:Vdd3>bOEC#6@WE;O5Y]cgU=>(,ZD51.1@Q;B]a(/=H6,XV1OdIB2@D
cC/J,TBF&Y5Ce09MJb69[ffK;2#bNU&.[+[YEY6&1((7(UHYCd]6WV^(f^M\e[FV
-<EOQDXTcQ2A,OY:81UM;e?Y2N7WUOSHDa7W3DJMZP6USFHWSgC2,#130_N-NRV&
MJ],JI0W0M2YVQZ//Ld(eeVVQ.H^:9CS:Rd#X5D8#Xa_aDYN==S)=04+a\Z/_284
XYMD#6YFOb^gU7@TXg&a\RHM_#BIM2LFE3-5.?M1PCZ52eR/=,T(FLge4XC,Q2L?
G.fTC8,Y]>0b1d_gW;e?cQg)1VeXa7fJV0(AUCD56/P(OVf#??0(I\5J,1F+@,ba
W/eg-RKP)W7fKS+:BQ5<5X-2U<d_M9T)bR/4E1fF[g9OcTU=U37W0X5bO6RCEae^
1Tbe@7B)O1GNH[bYODbWNBEK#I)aLC)0WJNR.&OL&N]VW2_d<[R>(99TBEC)SUQH
aLH\d;7MC;6=7,_QZU_,2V-7B9?:2=SV[RZ=U<4(eU<bMNIVN];+A88R9Y[a51?^
CINXO]/b&K<(27-BXX5H63(6R=FD;[YJ?/f5&)fPS[,D62gg]>K1R51S7^33-]JV
50LN<]d0-3Q:E=R_@>eDK#f/<9_-dB6Ra42_.4]\]DH).YMS/gTE_a>JG=K/_g<K
HCZ08-.,H^+:5YLGdaB?FKee;b/8aLgTPC-03N@?),=b\/W8RM8]5S_^d8C4D#S;
79/W]LF>DF@_GB:(bBT(gaWVe<eH5RXO0L3EN&SL0)M3H4=da[S7g094b:f@?VH.
EX0NZKH[Z;4I(<M6WVWI1R3dMUB&&5D#-e\9=D9G=UYDFE]TABd</#BY(YeLYf+K
RUGg[2)5-I:;&]ESR,Y^-G^>WI8<7W+C[Ue.TTE9HY(0>Q=Q>856;d6J.U(VTD-f
<I@.J2CO;DAA<g>F,\P+?2[]67:T[BBD1.(O^-YOH4OQUP\=Z\DC,5c/,1H2=<T7
LG>#-84dJM]DKCA/E@B;W#8,5e)RP.1&3B445eV+XDU17U\@@dU_D@c.2TBdIcU5
R^Y=9:b9:-+C^0&LLWBB;U@4O9#2U#;d2TOO0(_5.bPZ^/52OD)Q#Y:MX[CD3S,8
6[B/A4@H<]BTI\=]]a0d1\Lgc^ET?T:_cc[BZEBJC??SAO[@e>6JOc]0JXVA@)Qd
PF&.KE[JBa^Pg9RR?O(D(XfSM(VWdg-BVYB3.I<bXD#//a&99M5J>DNgHB9U>.#4
EdD(;_+b5J>.1ccf3-P_5J/X.FE8:#8I&eFa<&>bd:N@?ADR;.6^/:HJ\EQECUP=
PFWd3VDJ<PYM,bB90E#LZ49>0ccb>P#]9#QT-9L>(XD:L-KBbS#A2DPN,3P1AF+d
JLa-0g>]DB;_QDa=BD].@b;EEB,CJ6,D703<dC:@)-^KEG;5g1C7V7ePgL?&+Sc4
XRKZEff(RP-DcgMI7M4V)C(WF>G4IET\?)5VebbKSAgV/;6TH<C,ML]K,I:R_B@5
Z-T5,5_K685=L4&Ag>^J#fO72/A-T7I>+M53;>GMI;]8L<H.;5SP/L3(MFHTM533
V:N35=F=;R.5<.cf@J8HeJX]4ORVDQCbRUEQ#.2R[.&f7P24/f/NY17KSS:0)Ne:
-b@ZT3D))VE.>K/A\7c(6JF5aEJSKRKF2;^e9FDPd+TQHN+TJ\&BH_LC3+S><-7O
OUJOB7C/Y:U8fY.]Q_^:E+&QU^2HE&#;??J@54QfB\cEWaQ0LM?\XdFQ<C:2E2[.
<5W_^DQ:cb,/D3D.[@HC3W\^,M#T[X#]gJNP)O,)..<QWUJ@.MFLD^G,_H@/&V1O
T?+9__:d_KR@gHH)PLcf547O1DcCe&FVDD>g9)PZ2U3C)B=(g;:/YYL@Va/D&.Of
+EA.]eOJLdZ.L5:&D3RADE,].OUQ>J;TO3f5f79+W^PQ]W^bT=#cPa^G37MM[.4S
SF;+^8G]UI+7>)+aXW#K2]f?H_MZI7E3)\M).WU>fND]P_HDU3P4\#-c3&AIg5<@
/F1316Accg2E;X0]1Q4@&ZfGDa5Bg[X#X4Ve5EbH-HE\NX_M0Z=_.RQ8eF&a:&b6
.^==5MX<\)?#R7#)H]BA/3T^+;905=EWU@;)KK)VaFPI4,9?b9>c:JHZgCU^B82V
M<f=^Q80GcgCCD2123/XTT@<>&3\##B./R<[5L78Pa5(7H0YH>R&-7P;gOAZGW,M
eXZ<ECPIe9#:Rf4dCD)7;c@P#Ve+^T4,<3G<&OcP#6)FJdE[..4FdDaDcI(MFB-9
3aMF>7McQ.[a+gG+9CdZNM9J#c>5bbV@7ATdH]64]c6JO<ef?.(IBNZ0UH/[Bg]\
1dFb1L2c_V(EY>98gB+7-gZ[Q71C>@JV3++H&&.McaYX#^P\TI0fQgYfVD9S2)KE
^A4cPb<TFUBK.\R>7-aBbB.R8JLR#(WTd4ETP^W0JE:PEH8B_VB-3DA,\fS9+&JD
0UVb.S#YaG.@1G?C@S/dM4c28_C=7HV,HJV+E[KV,GeI/DN?:8,FUZ9<&H@IE[<U
#E_=#,2[/N)W18E:5JGMcef7gA_b15\UIaKVC<eW\>:&W]B0&&@.5Y[N^2P^9#Be
K0TPRgXZ3E.;Q<-g[]AHD&Z/beAE0_5^cFU&V:3\#3S](E\X@dYLW4)IZ>gJM]TL
RA^(=XJPND=K&,NEDg0gV@J;5VUV4EfEDV296=e(a5McMK(cW,a2DGff[CP5gaX<
8Z+AT=3Z3b=SU_,La0^Z&L7;QJ28K:^e2C<=8HNd#(&&Ke>]2ARMdULaV-&KG,c8
]DPU=/<&ZVC@JA+R5N485SSEO8M#dN_b(6IN.E40,5;S\IMP]Q94D4O5J?EG8RY+
63f(A\]<K<@8>E<De-5_1?++F.CQ27W>#?QDV5M\KS,,ce^96=^,CK_+#XZa>O+1
8g0JV6TT6)2GM<UQ3=?M[cAcEY.^.6d=\CFSJf#AVa;_I&4MK5+PE5K(&O)X2N^\
M_R2N64Yc-E(=S;O@Zg?HQe^OB#/aWGbSP75?D+3MS)RgKI,CGL9R40O/JZ?57Rd
D=B(bfN^D\U1G6:1]4.A^:G)B)YHBLCcN=-F[H]#1e=E8G<d,KXE^A&RD<-_2NZM
K5c70(MSKDeOSWCZ0/50VZ:0H4H2WSP.f#M0VO5BR/S5ZF#LAdXM[9#[f8Qd[([?
7BEJ8=A0BSJIC?=C0NS8)_7Q?GO)NHA\N.D4C#&d,_;7a7U-+;PKH9c2;E-TJ)N(
eBEO,HG-RB^:HQ.PYDfbVQ?4).>+e8CVN1[=M6b>KQ]YMVU9BVP;DXF3EEO)DGgL
TK([;Ug0]1d0Yc\8RSXA>5G.EB1>Eb2,#X:a>H0;<7_]aM^RGJWa35^.&RI-<>2T
882F8+^C]?[bc[13T?(BY?8\SBMVU:)OWG=GS;)-[K=5/#Rb-.NSF^fYf+eQ^J^C
IH,5B0)2SeIZ\#g<^TA@/1NfEc,WAB<GCX4(H^YNeQ\N7&&S=;\O@d=]YcI98d=e
2D]()88;+dO;L/ZA[17-W2H-de&b3;:?2g4Vfb6F0C2A+e.QLWg#7aFS4KQX[W.E
\aG?=4+Y?J3Q4ce]\0\XLJee.BU3GcW9X@ePadH/GK)UQ^bO\cD(P8FQ1bZT?>1W
P,II:,e.A6M/EW9B&1>)O^N)06?ZLH=H/64]gI\(;c<aWNX.ER<I:LaWD17W#[R/
=c8=<74XD)Ga9@T-T_WN_aUIAO66>MX1LUCc3P^QAL:F622ORTV8J]a]X_.LfJU<
D[JcbW-)PWU51GYO[2C+\L2+YE^<Z@SM>0aV4WcbS5KP]A4808FZQ1NFQOO2A\aL
U?.+#RL:3OgCOecG8.3_2\/ZW<::4=QVfI2EA2#+/DEab:U)MU[;@K.Xbf2+I-6Y
,DGKCUe&7E+aaCI-7G>]+@MZ+<K&UJeN,-Z^b:)gF9+R#DHRL^e_^4fF0@bDYD?W
I3;KfJ]6G<SA3gYKeRd-?_Y3c^f5>b,^(8=9H[cQ@ZPH:>B9PX^RAGON9^6PYg.L
[-391MW#S37efU5G)\3^9[QWD24BNZ)RC]KA3^_A+92O8g@S7?=-JAXX8BWeQ5RV
#Y@&>;?_ZD:;,bE,VIbVT4?WD(f>VQdM+b(a@R#/ODXe+U,-=V9U>-FVRMUA_D+S
fLM7g<;45eJW^\D>9X<:G=<6Ja)VZ:CcOB8g74\S#-K9FGd],[WfZK[8fec(=N?0
BD<U&1-91K_]O<^(#^D1bEbQQQ:-J7QOD7X&1B:F#-]6S]8TI[?QC[3Y2GC:,BdC
CMT7=dAHMQXH-1LbRWb)9e;5>PEGg9E^.QAIMM_P3dZ)U.OG3.=BYI>\<J.KDRB^
6<].Jf=5Z3;:T\-EgbBE/TS=:[SU7(EJ:\]C<J;V<Y(+\)/OO5J(9K[-H^97NHaK
gWKQL#;;H00G<B?Q)?OE3S,\Gf6&J;[M,R4^K^&8We7(2[BaH^C>8?<+JJ3SD-+Z
9c7^08eS><<@/c6Z.N7MSCE-,YC12cUX>;G60WJ6XE7PY;_bKb8K.UL-a-3OY31]
g:[6MOC\I3YXYa&MRP/,5d\M/HF\5Deb_L&H<Of5Kg)T7Y8_>5VFQ-)/&&J6f\S5
JZY>BgUaRdQXS<1e<f96P4O8Pb[EWI\S<VdKBCN&\XHe7\ZS0_25Q9H@C9QXE]g2
Y,2S/EEE8,#(bKSRc>#R=#gC13<BX:Fd(Z,T^g</Y#4>6B9XbGa<6XeM7f2^b/TD
_=H_d#]#;Dd9E]PG.aJN]\#T9E&?GH[J>8Y9)+SA^&g(]Qdc7[>8=KREb]V87UXQ
?FQQaQZ7XfIB38PVF^eWD6PL\aaXEJ,<UIII?MR2@^:6H\59,PN6Ja:GS@J]BZ,D
aZ,C\;,\d>^+fCJLGcbC3Ya[,<+;2VB:KBcfCWG2)6)(=J>Tc:,Z7@^6WV&6AAQ=
L/)ZNa+5Ad?G<H:)@(T79&IXf(acHcVPMD,fUP)d^<5c0OMXNH>O-KR7a,?MYed9
,4^VgRNJPd\24Q,OTPCb_7@3B[4WV7#6)]Bf1RCfL+>T:MQY>GG]F.K6]=]@f?2&
D][fT2e65BY4&Wc^W+@9N:YM:6JXHaPa8AXJHB3Z9\U9V4&45b@G\HTWI:@AP&g+
VNP>+AeEPL5Z?b,a0[d\V23F,fY4YOG8HD,fVJSd8(\Bg.X]@YV/@CF9)bLZL8\?
\_P),,CLAO3UU8M-[2H](Og(AKJM7gMBRO1g951cVaJLY52]LUI^2,e387a>7;I7
Da3_e]-]&#B5B35,JUY4I;\RC+Z\F_/XW=ER+5NQ/:N,X?M4dELDT8G?c?TC-#92
Kc+KSXE.DO[)fLS4/\g&7>F_B+MRVA.HMWJ<_&\O;;X-I[K9+3>DRT&4@:b5C0RB
ae,-DH=#?5P(?aSgO@3,5T1TK^4[KCXYcKCbA,ZeT;7GdUITY-Z@f&c>J[+L52](
TZ27f99DXcFdTBG3T5D+Cb7/+/O+V8Z2&O3b:SdC&/dD0(HFV(R@)#MLQ]TFZW;0
@B8?FA):;(WE_:6:.@De1PFZfAa58HgK?B#]W/LM\AH:;1^>-.K,^;]dLNF(MT>W
d?4Fe1e:4/+QJUVOM)[A=ZCMGJ6F&FC?.=#6F[4;TI-T=F07CK[:A4C5R9]F(Fdb
YK)3e#?><]3.gTcN#\0Se:1Z.?_b:B4@Rc9N](?G47LWU2M0)&BGL#CQM+S>16C]
a&)5N0L\_<1g#SW:-8<)3MP9WQXA\WO05-590_TN?/PY:#-DKAO:?782;YNP]0Fg
T&P8#2f/]-[3WV[@A686Mb-&B63T,I#7++GJ7+NYNCVTe@@BX8,/J1-EV3]_5dPB
2@F\K4A.V;P91M4S3^f_/e6.^0O@1&Y-0XQ.\;\OWaB>ZED,B3=HZO[b,^2<;[UH
T;T0XT5?UKM1JWg;K&P8ZT3cZW:9<e/0RPb_8V;3^e/f.OaM]S+.A<8LH6&3:6J#
cRTfa=\\C_[)A>)a==H6R@=ZX@dG1+8HfYGR@EaRF@]^0R_^9^=f4@=6)U,=0[SW
)/F:SSF5S9V9ZRB6Z/=PI)fQe.cBb];:#@&LGfDPW-EKR@>9/5[UQ[LAT2P5#d(>
-37]+\9W<?c0XNPBfB(N=NU+BU5OdJV]\3)dZ>#=-4/f7A,J((b:cU]P?C<AD8;c
Y04dEWJ>.@/8VBT0B[(=61J>114X+67Ie)A-6W@0>[.^MGb<M#W]6aU;>U@)YcV,
2:.#EOffE9KFd2>\74/1@VZ+;_T4+:W25@]^L8OD4)^=NMgb2XH:AP5QaZ0KEJXH
]Vc]gB^2].5d0#(W<7#/Rf<#RN\J/8Gc4(cV@EPNbVQMd>&cHJ:@GFYK&Mca0_1I
PUUA7d=H1GX8K)dN1T#,,I&b9>TR)ABGaL?(c@bS+C_)[=I^a.A[#?LMUW;+T-+9
>H@L0YB#2)@gA.L)8HA3NS=O+&9:e+?U8_fURI@LfOH/\6;,XKb0G30N8eg3:SE9
+ZKLdF<VF8_M;fgT=+O;)LE9B&5QDHZ51\fZUcG7GPd:9?]TJJg_-g@/g;OA.-U:
TY97.U=UO;8-11QXSGQI^#DfFT+ab^]SK3&5XWV)?0+G/HWf+1@GK0JST=4a[WdY
LfZRSY97BYe:VQe3NCXYcWSQDUe<-V_>#M6T30<-Q0g;<g:VS8BC)XRX#5F,[bJ=
Kc9.7,/R4,M;g2<8:+D[XP69\aJF,=\ee<8c(B2QD<1(3\/8(T>eG8N0A(d28JQY
:5Ba]@/I=.)<(P<N^?dL_Q5ZVE=[2FK71,#LHgUd-:]UXd8BT>(RW?[_RSJ:R#+D
a(V]V]N-/+Y1.IE>MePg>R5X?9T8UXDVPI]JX.A\cGW59)]NDf;R9:=QBWLVQ1<I
S/7)A]R[L_,dN>.GB4^g=YM6.D9.N/O0VY&U&E\SgTg#BA;@&J2V3F@J;E<:D&I9
EE[#AZ5F@f;A/)HU.;9]VD<&L3XQ>cF>IU\.1-^=N?B[8F6Ig+(@gHeE):=a,fd)
7IZEP/C),QU^BG#6KA[FF,c&IgB/@/dV;/65S(6,G_>bZYSAS2;3;-.=\RVF2M8S
.A((C=A>=b9-@e+QAV7L@T#Q[QFQgU6L@bE9_&-G2Y/E@N3B;NI.PA&?;aFUA.;M
.b@<E#/>Vb2?Z;L.#>;bR366-EfUZ-dD^)S)50N+e3dEJ.(aMZ_KHA9eW#0I(L>7
?-,JAF<D:+JKH,X7BJKVD:L&c&c&S=CVMR2V[((cU(3F/)b18@_LfX/0@7D39#=W
41WV+P:A5VBdDK-MQeLS^W>.KgSVKG#Z=7BL3FTU0<_HcF@2TL=&;?fee6]40;@;
a+CJ^<LIF,[]Z:Df+SQBA?P\2SEd^J=:)HW5<.aDG;05/34NPW9OYI&4Q@]:QUI[
;W<:@+A6YB_:[3+67^f+Q5;g@7d>LJ.32M&.+6UfLMYM<<9<<<FKTUC:G,PT][Df
dEeVM,f-UZ)-OMWT\gUK\VSb37U<_(<FfS2\&7RTNd;/ca9a2-Uf7/=:dI7Vc<#,
<-TX[bD_XM7ZXc\:b=b7UUT0d@0feOcEeHI#-OLDb1BII5YU[LERP-YUIQg4cF6Y
G;3UR^MHd]G.[U>0Db6?4679>@[88#^FU5<9,@O?aVG25?CYY<PL&+4BC#HB@?Y7
Hg1?UXR8P=Z44@YY:DP?+E.Ac55GaUa)Q&OJ9K:e[d6RH1M5NZd)3IeH#1GeHSJg
,HOVf8\M,II>LRfJX[60NQ0>O\1+@@@91:W+>CK&>0S89LR3->:68I;K)JR,d2>P
ZF\f<GaRO?AW[MUJf>4Qcc,[#.ERIe5(R7Y9@8ff\GQ;_?FT#[OA-8,0G&N:347-
G=RZCf9Ge2EA/L7bD;-+T2_P6IP>YZVUWWCWHS:SOf>Y418MC+V<;_:4P[JUFQH\
I3C&J+LMKSYf&dMM-/U;2ON308c,C-c-S@7]DN6aA@K21bWC=EFP1-G)A6(WG2HT
N;AU0QG1e,+ML006,U/?6cGOb;P\98Y_V8/2TU>e:(]#)X&HSXa>7\W1&g<>F?SU
YMT;@Oe66cQ][L:W]95J34:\O#ZUf<d#1OD20b@_UT<fXIY7WQHQFYgL75DD5#@c
c;J=345.3)=#2.LWGFY;3cObF6&/E8^YJU5;8EIg#:=+aC#57527@T_>fg.a\3d.
-,@ZP,DFX?A<0WQ0?&3Z/gTIHF&_1ZO\)04J,Y4J7](RWJ-]USAH??&S(1f7M3F_
aQF0N&Cg<0<O/+U/VA)92eS5<M-=MN(J/FEW7^1?[/]#ZHS^-WCN:g\Wf^e?J-+9
PXc/NDKHa<,F2)C<f&/@?>Q:5E[946/?_NUW:+F<>8@LG;g&FR?)g_=,NOU7F]B:
+cA,).&CBcI3b:?B;-K)OX92@SONNKI3OH=0P7U]CC,1>7-8<S8GS^eF]Y20<J_7
ZP@d@(D.J&@]RM)^J^\6fO.A9G;_2N+^<d>?;-1)).;M[,OV@I5ET(6[J<Z+Ddd4
3C<F+WQLBKDM-)HTG?@V2O&f&c)(L)fU0]K:6@TJ;0F6L<(V0NXM_Y.62dDVUN0(
L/ON=LAZ_N#We(bMW;>\f+fRGTN&ZMH\GU\_6PcMU/#b80:9dZ9>#24<BFD,3\6[
ESY-(J5>D8R:61]-V5aOOIB3-]4CBJC23UJR.^V>_1aa+K7]QST)A1[L+>8J7YBR
@GE^XFBY^BGVTe[:U&6=7/RJ2MYDJABaTPgg9U80aO;0(-FW@A,8Cf@eP]P2N_aI
REU@WZa1]:NX13g+CL+YJBE#.^BIB0Z[NJgP.KJU_MS_g.F_dE&A8Q.,N>/_LAD@
259D4,/c<KUOg5[HB;<;d+X0E[e-TWRLK7(2MOI7.1W=)VA)f64?6fTKB>][H[RI
J/.]E;0Q8=L@Q\8--.cE9d1UZbaeX8QHa9cJ,C1ED0_6;2SJ.McPD\CgBJ<42X)W
/3eF9A]8EC?]W5Z1GeNGf#+2=e943(4R=<6^+F]V^K.J8XZ(#3P=7^H[?Cc-1084
c:ND&]UN<[.65Cc>SFQa5^_QIQD?QG=+WFaeOO)[5LLVbG86L2,CP@g(S+:A;]T_
V0BYa+DSP)P3,6RR:(,/_Q.H;?C09G>4fAe_P(8XS=NEXK8NM_RIK?5Pa=&VYQ:6
0J50DV)OZe-LM2^bQQ.Xa1)7S8UT.,??AH\>C^96KL8H7\f-a&(CT><E<9S.eVOX
b@,8Q,05PDZdEM;5DJ1Q+,OW)5cN4NZQ^FGS?c+Eb]/80QZS?:C\/J9\&6C54,SN
ac;S/)-401C=T+[S2)TS/,P&cQ)9G7,BP)<RLc)7G6=F>aUKCcRWGIX)M5+)/P9Z
4_:29&#Ie&D3:Va0ePLAN&#E?GH@c09+6JRL]c1L=YCW>_LF3XQK&#1+Y)1AXWgb
=Y]#^_](F95NBPZIHc[>M&X2A)KT:2;0a=C8^NW1.K3+-Zg>#:T)?Y.&ATP6X/\?
Y,N--D+;a8XSIT_#),c[/(8\b+[M89#YBG6fG\c/T2OF0ID]C+)^.FfbS&+=#<1F
eR+V;MMIK3=#90I.1KU05=26T83bS5NB5[LR1<?LU<K[SB]I]11fCIbM1IS9^N9-
9Z.A2G:7FEgG4fXRVUdP9KX3X8?=XDJNe<04MFG5H)+0f/8I6Ta@\D.FW.5[W/0A
P=?2NCL;KKVed\]K?U3X/@FOLP^a^b#a\6HAOc+(UHB?cY>5+K<bWD;cBc\,1AF9
YZ-E+.IOAbafG?LL@XV66:_F>M@66-6I/a5JVAFZKF\PNK]_G27:9)gDW?OF2R=G
BEM)4M=9ADeK0\_26)Y5:/#D^(:QO#9R&Z61KC:A/bc8/=^F\>(:c+SbM63H6?bd
Cd#=JE@R3;AIJ_a9L154::,Vfc-@#TG?S4G8H^SG1+52#R7G(PZW:[gH3P(+d):D
2b.S\aUYQ//>R=R,P+ORQ.:EWAa7N\a(KNJ)KV/+,#&,=#bfd1]7HJ]_,?0a.Lg+
a4^.aPOOVQG<B6_1.:fYL;AV8,9G.7.G<-0/Z,5OKEG[dE913a?99J>1N:0X>\G\
M2JG0&LSQ3e.ROZ,:&P#>)K9@fEKE7AB&aFRGVe@g(MM,YVEfQD9BC;/.[OVAH&I
OIYP+SGdW)_##aL]T>gcM;SUa01S[SD-+)L;JCW<[10>Ue[4X(C<W8[7>O\J],G3
g2DbQLQ@>K<M\(X4ZV\9.9]3c0B[JY=,IRP&:?E.c49Ef_B^XDQ+ZH.SXXf8EBIL
780ITe=O;QdBY<,VA^M]c]bTgI2F\ZP+XYKBF5/Hc(Wa1HdPHFIbWdDO7@?8>f97
d\?.3.T=eH5NSXZQGD0FJ&A:[P_g=H\7U^9?&a22Z)Za/_dbHF1H1&6AQ[M5\Y#&
?M&3efYR>cH1b+76aYY[9IYJ5GU9<8Nb?/JFZP+8X<ZK:/?-?X3g)WA^&/aN56+H
1fJQ<eBA;g?78Q59JB^2HJ2)+8B?]85ZU-,4a#Y+LE^FYKZRG>T-#]5EP32Y&5UU
_),210K1BF85#-P-GN>[/P>gI8A]-(N?@e7.W&YBgXAOK:K;:X.dB)+AKJ@0N43Q
1.Xde3DKK/R/Q^B2<W/3XHUTBQ6J)ONQJJa,+?<L1K?++VBGZ;;2a2CZW^6f:)gA
e4e66,gHXS^L<Ne?NN4e+ScLg+Q((D8d5M[35d=:3Fc>aZJJ:E(YeDfb;>^+-\R>
AXZL,_cEfJfdg.gBOA&:RPZ-HI4L^E&#Z61>a6<cf/\R;NIXUI>-\dL0D[Sa@9,M
RLC:Ug<(,:Ia0dg:Zbg;:IQQCG-a,7+>IN;[MAG@/@=)8;2(;^=/M\5;?dVE@aN+
Y1011QSTK8cBe0F4bc@SW=TP?V\RE>TPNa_)WT/A?LWB;YSSFXMTOKJCRSLETWO?
Y7KMb@fc)bN\2+7YRLCPQ4+RJg+F#MDM?@V#&Z0CXS2N:FFKdWe1P(#C>+4OZJ,,
T#60:aRM0WPO4;S8?ZPMcEbbdG40O)6A.,&X\UK-c90cc.:SOEW=Z>AXV1OI3(UP
IV^GAAHIN)ab)OJdF+HM:TSaOd8L,M04Zb>QQ17D8.@9_V@01FL^BALg0-[g&;+3
2E9KS&HaH8T+&;<T=CW?34UWT/L-H>2/.;6a6)G:UTC?4QNWZRDO\-9^dHPDTg2d
,+f]W<]e@[UL2d)<IQdNRG.CET)7c2e^=;\B;KI?OFcAS\g)CRJ?c(/\?5],C;46
V[=@6>.8G>fPP=J4f^65M8VYM(O-?c#+_F,?JI[=V7;AOANO>:f)&>3C=T9EGEI=
H#.+R:\DW)DK+)]IeZSQNBNg\ZNDCA0?gTBLg:<27;R;^><gaTAMQ6U=HX-/CgCR
S6.(#QM=(cXaRd\7eT(YV3D6>2.FdU60=DK67P+aN#D:dbJ9=XEdED]<#==W]GV(
3GT7Y<3ZOV)AMbGL>?cYZ)AGEVg_09Q@SW<--+/R9NcXYPMIJQdYC?/+/gQ[>[2:
_AbW8E.c:&M_4[RL5BRYM9WTWa;>BFVHBA]8[PgT-ETd8?ce4UNa00TG(U4IUca?
?EO[5bO/HMB-=P,a6IT5M_76e\_DV,RRS.N)S[/PQd@g1GP01F=e]=+IDc]:(A,C
0QE=>_8De##9GY.F+7d[B6dEH/B]1#GK<4&^,F]9HP[K1K^_3)B\Q>4AR5B&X<6d
RefNcE63PGGO+A&[HL7?64EcWN2M61c8R#_b>NV<_(-PUHTAb/0;CB9Y0_:BJ-A_
&RFVDW8X<L>B5;9Z8U;6XE9/1bM3S05bFTUdfbG)=RZ,1b>]=8>aUc?W<ISLJL4A
0&?-2.&X4gL(gb;\U/--&_)aH4UT^]f<SZY9C5CaBX)]cZa?)76@COL,b+@EZFMa
??#^3SG(ee8Pe;-GEDAdI5X^T-[N2g>gcQ_BcV+Y.gZg4?AbEEBTIg88#734#X5Z
7FSPfe9G^Af@FHO#5DCS8.@/CD:\D&&gT[-QE=B3]3M:0Bg,VX/3cS&Y5a<3@?IH
M,;QOCb,:G2S1GaU(10W07J/)1T#>_c/0<6LN-[=[R4H9^+6;4HJ\\bK2W>+G@#F
V[59\<OJ1ZNeD5DM.+X8]9:eL^50Y:N827TUTc_Z)^g25W&>P6QY)8#4QZDKf_^Y
bVPS4)fM^@Ie#?BTQJEK#O=7Ub91<S.DCOa=+ca4BI?<D25VAW78F:A8OGA?^eED
)R,NeH\PHc&A;gHOA_,dFf@d]P978ZY)T5eKM<YQ[=Z.,L,fDM>80\P:2<+^I.7d
TCEf1F]Ja]ZMR0A0D;E&Z=,Lg0;\HUfXY&NAe86L0Nd9]aOPLP9aHM^[;XCMEWA#
dYaZ6fQC4.eXIJc5OP4T8DN5;GT<;4_g\CGbJD?0GN<T<5KSf7E=ZB+,acV;X0V6
gS1<^,6EG9A6g<OTIGdgH>;W-(UGG6fLZ#LFGe,L5R=^D,;>[24c1FOSD)G&,]4A
.2DaKMXE&@8W@.=07P<dQMIE&.?#-@W;9&KECE&fZ1H\XN<2.<[\Vb6>LNVf/?J)
U@:fXeA\]>WAbC0EgPc[=MHPTE&?1]I2R1VRK7CX3&V6g,0-)Le,2_\e=b;Z,^3.
B+D[g3a2c\C:=baXIVQ]P6#Z1(F1LXfOA:9d^cH/D:JcE1&7&Wa#MSHM:]KV\g&1
:0M6F?Q@8?X:DX>0aP^A9_I,9ILT-B(9]UCEL^NXg>f>L]3\9BA@YW\.HR<9&LEb
R:+:?X#X>KS_8LX0TE_>4KdY3/S]I63G>QI@K+\?&C3J54_[Ke6ZGH^.X<cKbYf4
QaJN?/DdRYVK;7<YKXHGA#QD:\CgIf#Y@YYW>TdA-:C250F+#dfH+Q-?e=.(e&>1
:5>Z4+K-9LNPd@@D)C7U-/-P-/22COP_)YT@BQ68V67#;d[_0X86W2F/P6--&E+;
QRcLF=H1,ca1RSeIM/bL)30M#YL5HG)1<Le/M^5[d0F#?>@O<LM<K93H+N>Rd4Y<
0K2><6K+^?3KW&E_1c?e7F.(HD/?=78(.\;W4P5B@XR(P+.cQdVK[/NE<@cVM(><
09-37.UaKP(dNgQS#fLVTe,[7(0g<ZU3.CE3f,4eR1P@L.dQYMWc]=3AQ)TV9@_H
@VZT2EB,FGM=^<]338,T=R<,HG?A@8/)\P2[1&=H-)(1.H+f2ZCDA?MJ=;4WKFUg
KV5#[T#X:Uc<S=fRHB@QLf_A+>P9ee#ZXea)NXf-M\>@0+WQAPY>L8dJQ0B^R5bS
#F9;H7BWX?NTf\/]SV_#e5b1eS/WRZPM,a?B?5G,CQ27C@2QP/-8V95@X\CT_e.S
&;/QSdVGR^aU2^3ZUVPGSA_5PW<CI/;-:$
`endprotected

     
`ifdef SVT_UVM_TECHNOLOGY
   typedef uvm_tlm_fifo#(svt_chi_ic_snoop_transaction) svt_chi_ic_snoop_input_port_type;
`elsif SVT_OVM_TECHNOLOGY
   typedef tlm_fifo#(svt_chi_ic_snoop_transaction) svt_chi_ic_snoop_input_port_type;
`elsif SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_chi_ic_snoop_transaction) svt_chi_ic_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_chi_ic_snoop_transaction) svt_chi_ic_snoop_input_port_type;
  `vmm_atomic_gen(svt_chi_ic_snoop_transaction, "VMM (Atomic) Generator for svt_chi_ic_snoop_transaction data objects")
  `vmm_scenario_gen(svt_chi_ic_snoop_transaction, "VMM (Scenario) Generator for svt_chi_ic_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SV
