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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XU1dOWl0aUBm+EcdIBnF2A/pq46PrRE7J/6+ehivRiPXngpDJeMll5LOD9W9rtVM
MGwlvb1JsgPZHJI5Q9dcoCmzBZHGzRBHJoijy3fSPYD8WoirMo/YPLJTeqsPRLsF
ZE+XN48LQztDRZSlfk2Jj5dfiMpYBMTq7rGsxbr6GiM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 143       )
6J86QLmURqosKHLOwEXH1O+M/ACQ32kVh0DeLNHsdRry0kDyFvn2stImpfKuI15P
s92t/vh0aInzEe2uKf9tTP3JIEbkTkN17kYFEkhvp8cdRo8H7fpG0Rboee8jIzN8
vyD4riUnZxtpc/vusZmpQxYl8zXBtNbEBbsFjswWkG5yHuWtVqIPxCUbT4FV0veP
`pragma protect end_protected
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FOBfdLRzdKVeznzoOuzIYwd8WdzQ2IcXZo6UUP/Ck9ZkrICKq1n6QxvqdUNXakRy
XcHR4Ouce1SJ169rcOPlfgUQk7K3EdmBPb2lz5a3gmHIQJeAH+bAluXFqYnYglKT
La7JGNmlL/j9rNUhg6VD43gFYTCHAF70nvNTfwSSoOU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2050      )
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
`pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::pre_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G+QfFbtnOm3srdmxxuJ/9cMBP2FHv8WG0Nkqt+bwUvLy3v0v0bqHB6SJesD+ZUOL
8wcrd213K8g3j9+oKchHd+3iDT6pbN2ZiljAK/yJbVL9mS52quufs5+TaRJI3RnK
UCJtGx2Eojdy8MuhEFKtUPUM4RXep78ocUKKBEZUCGI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2559      )
+ShZmHcv5w433NGjcb6IUExCr/7U9pWuKM8NwKF9epua7a6MY0bmVSYhy/mlHjx6
aMY4ZthYAM2qCWCg43wqldQ3WqgOYqDIV7A1cdPmszfb3VoyU68vqtxA0rSweLpv
Tl+bCojT/uo61rq3uWOlqucHdum5SWmoR1ERvHXjA/niFNjjU5jipMkPh+QmQqN6
b6CKsbz1w+2Y3PFkTVSmX2/cRvM4SrqCWAnbz/3dvOH1YFkbTmUS6Kf1HqngPfHT
gwZLCaPF6Uigms2qqG18bBdyMi8x6Puai2WQK0ui68tP7JUjlR+q0Etf6ITnVi4u
cSjHstCmZppVnlnACQLWX3AKFHx9AlKeO8FxAry8yv2f5/h8p61uNvETT9p8DXet
tusUeIRAdtjVcR0Z6GodwYA/e2DDVvdyR9ALK5YglDlmiyTtJoyBFJgqWHPfQFMW
0zML43U0X1DA7vB3/J1EpSHr6PbLhnDBIVCe5c0ARnQMTtkw4UBYg2IZ77kdlHXs
AXnj4eURbvrvh4Z+Wzq1n19BsF+JZVZCz85Ci03/Qm5uitdF/yc5PqSQqMeyUh2V
mCzotE/DCUZ2lNCFmRICtmn/zHjRb9/Oc1FzjqM3Rf4YIke3lHPjRRkK+PEHJ0gK
TgXywKVVhHt3s6cqbIKPl+6gVgy0JYOMcCFifh23L3o=
`pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::post_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M+gdXQre4W7YsoZSqwNDsKfFSrdkLnDNyME8tnyDHr88+XsdWFu8scv2efXVP1Ok
hMc4Q1IvYxWtGA9Pz0Crrl+hfMfVMXXyYr9etPqmDNQ2dFjwPg8QKxxE4QDbdEdu
+CsYAsyJpphDz4QsGQmFpo4oz5troaFbtkb9Bu0n/kI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3392      )
PE0K5m/d/Ps2JfWIObbcVJeKxXc+LOKKU1676JTH4qHkBbJzh0C1uR4eZ3dJFO+U
Css5kmm50yg2694fDmYr9SPZB7tFrz4mvht+zj1HglhSxEZwAvmXXDk4U6CGZuO0
DLHZABZJ2cS7rCMFMV9bjl/fIE+zVYuNfy4AddsMnw1rirH7hBBESSEiMxfhAySk
/d/7cGkdvcEYXR5N/0yVHWktAAlmvHag+LwIB8OVS4BRNZNgjDU0mVHOFJLyEpB/
lG/ewUEldomkS0sDXUJSLOaognZVByOm3Q/bq6FXZ8kZdejVLBlv0FXOQS4M98XJ
AlUCVm8VcmCsss1SDg6DESiFuul4W9lqKqhnHkocjM2J+HoCixYCmW8fRSqF1K0q
jflEHWdwvXUNHqEps/7/dfXbbm7PDraY/nvC4WvUmGEjypth9upup08/dIiw5ap8
pEC9TooLINPH7H9w9Qxi3nHsifdWyLUFjL17DIl6I1DaQfokP6ZEGEZkwR10Femz
X+HCwKO2KTVl+oba6qyiOl6vKLrE9FFpkxJ9/JydWjmL+AdLnRdvnuezYV3sVHsW
JTLL14kDkdEF07jDXT2wyUZUTZ1n/G2a6YyKCohCgh7W4HS5aJd9GI7kOhdg7sz0
kzG8By2o/E6BF+U1sZIF0wS2f+szmeC8gabW7xxhqApIV6YK+84mJSmvij+ru2LJ
5lTq3OUASDL8X8NPPXmVaF/0g/eBA54oeQjRMutrqvNeY3ZlFXL5PVFWCNWBZOK8
2c1XlbORN8onhl3HLgETHGAX/hjn9tXSHUrN0QiohPs2kvPF8qda9/Mm8yFWTQsy
GPMnPKu7OeabrSHAz3hB40y3hPY5CDNnbGQKNEXh9B1rgE204HQ3ZRVozQUXzOFV
c2nDA8e1B0JCx0HoC4nk5jBQidLZl+tGAKvZBLKAMGbizFvAcgrNOr7HCJv0/zEy
QZjqouDk8ikvAR7W5x5o/dyDSFVqVJHLjr6mHHBY+Bx9xeSKWLffB4MtbHTNRRgH
upS0bMulNnMJWYRNVPIgxMkcdzce0817QDoNk7MUieyW/teyKp16J9ggsZusjSRB
FzwBRw1vPFrYOdjvGJ6LLSsp8hru6ZybgwPWqEraC5U=
`pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e7jbEt+Z3dxzJ+vERzNAMNCAQ0wl+gtDbvXsChb6LRDeXVrLK5CzbphvH3QtyYbx
1nhLzqAaT8IDXPO8LgfgLoGAqpovG8FL4KUF1mLO5cPmirRaLMQyuLskGBdf/G58
6ph03DkMQ/KOIU6tI2ff05VXv1kZrxNQFrkbr1rLICc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 58740     )
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
+RGv+6/iOvsUh/E1BAO3jQ==
`pragma protect end_protected
     
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
P30loWeBUICcSiU0LXWut5VCisZHQZd3rEcGJTEiM+Yh2Q/X+X3xOth0RJVVb/da
a9YxPEuxMQm07gJcFGTDlBWMBiNEN6tuxzIlSssE2lfA0SuuPKGci+JsQsZGloR7
F0fNDnSpuuD4Eb6m9PuO3mlM4Ktnxr/Hu/VYjChgfC8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 58823     )
Ngn6E++7FZbC7Fpec/80pV/A0MeIllddDEWDRNksQNnAZTxngF53c1XSbmkfYc6M
62NiwHkjkQgXyWMCPSnB32Owj0mbRg/PwARG17ETuhotNFUOSlx6+cUEubHuxEgA
`pragma protect end_protected
