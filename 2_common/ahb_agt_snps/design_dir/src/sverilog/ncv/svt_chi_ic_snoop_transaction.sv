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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Jlp6znVhgNk4Z9UTtxTajnWMVoifiozbNg6HrTH7r8/0MDsNbQxxc1FWjDO6iNRf
6rLfK4CqSVoE9OK5hIoYTUpaeq4XOmbR47GiT94umq6l2KriPugGEY2dLYpyQP3o
/syWu+Lwe9XvLg2iNgMalJdYwXDQ4fD6OOJF/xk6nrl8ai4le1SX5w==
//pragma protect end_key_block
//pragma protect digest_block
dhmoZ0CLuv/f2sy08N36T5DkeEI=
//pragma protect end_digest_block
//pragma protect data_block
k3vecVMjjfpaQ7NwAr4ubZUuFHrusYU4EsI+hV0ABCjEjMVgZT/HvYyOKxBZ8gjS
e1Vjp64HY9LAyF8P6xclhhPP848sTzThxWsOhr5AEY+Hhqrin2cdcOIvWqEs4BGf
mVp8feikFSRPzW5KEl4R72nE6vRiaEZb+tOoryq4Cpu1xwc/i9nnEAkWQ2/ikM43
Cm7D2VA38f7urlaGld8JID87qFrG1otIhl9QfF/DM6cKTcbamIm+J7ppaeLPD2Tq
tfmkgSUAL0KQqKb8FgmlbEf+OnlhfexVhsYc6+zTsC7zNe5QDuN80ex6TQIyHy3J
2PZVJ8EpEZm/aj+HBGXjW8mXG4pDk3vZbd5KRB/UL+a1CX8eXeGt3fhE4Y5doznY
v/e9yHtheaSq3yrCtAJN+//YuBCkvwVUyU54MRxrUT0=
//pragma protect end_data_block
//pragma protect digest_block
9O+35peyOREc1J5mWwsExIoCs2U=
//pragma protect end_digest_block
//pragma protect end_protected
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Aspmq1nvHAMYOtIWiMb0j44uTjEDsNcQGsJhHH94ce8qgIGG/ubPKS98GrTLbEMI
+lydaueQ45k+dmPuC8ngQUV4DFrMJQ/tw2V8mjI8L3OTxc194F5kqWzCw05iPFSm
bc6AfhAno4vlgCg3B91a3bw0c47vke+aSTtTbgW9V1QfCzs4Q/w/mA==
//pragma protect end_key_block
//pragma protect digest_block
eq/pgErKZqTUBdlFDzhbpeCs0Ec=
//pragma protect end_digest_block
//pragma protect data_block
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
WWT3H+p8StFpimNdqKrL0g==
//pragma protect end_data_block
//pragma protect digest_block
w5BxrgdgpF/Qgp9sIApQrVgrX8E=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::pre_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XsuoQUo6FkAu+a9NQwYhjTTx1YFE8+K2Xu2MgA9i5JudsJmbOYe6lAt8KTCFgi31
wSQU7YOyFQEIxuJOdf5iwRlGp+HKdw4UhDAFrT5pXU/zwdP+d7yDxUhYsgtex4is
PSOFPg700epAjo4WHNvmRgz+26fE2SZg+CwxOHt7zansgR4S8sg/zg==
//pragma protect end_key_block
//pragma protect digest_block
p3MlXPomdCaNYI7ghzIVXzYYPC4=
//pragma protect end_digest_block
//pragma protect data_block
/NvOxOP5YGZFzNk/NqWiHz5FmJfdiUgIz9DeFRHsOpICo/5aXN28zPONjf9DYjYw
+SoY0dxcoMna7PGoGauvzMIMbtAzkj4JyATxpXuGwqWJZ+aWxcUeu/oZxbDl15Nb
ystzQ/u/sUvDAlwiXTbri4QSCRbgMKJxPIic8TZUzC5uEAglhaUQLHYuMByvDUmb
5dElk8azb9MjxPgp8GNhwsNa28yAjFcUA/W0lGecpqOzjyXITf1UlM80N9+8CnyI
CIJCKW5MKvGTQ56qYeZwTcA5PjsvO490QjIrX4O2GM8JBGJq8b2i04RcDx0L9SvK
zblLS+xvHdh0zU2sKaJrbnzaExqvixkZijGsPQaJ6OeD7lrhj/CeEOxjIm8aVFWQ
JxlX8XJShXNbF9ZWiyDvbV1GOAgbtntGkJWD6250hyztQbPclgJ3AOmk1MUD9EOq
IStDSuZxgzNWVl1V1w53mCQTDwH8rljM2JOspGJGc4DxMNWNBk0nNeUjKBEjTxoC
nc3K3ISe6szAE2cDtD9Mp2WdnsIHxbYM6nhNOma9X3LwgT4kT9G2B90P9iD0xfkM
N4ycTaB8Bnbl1NSXku3rx0xsOzN0Q/C/zNWDhp2rgMzancX5CH2NMfWIEWG3Hbf6
buwNjm9UriL+gCacBjwXc+4RxlBiA1Kb3/yTi/3p6QD3s47JUiPkSlbD4GvTel/0
krLl+XqdGkzW8HFH6+n6534Ahy9RhIPgAmTYOG96sK0OEJiYSVviMzteaKMf+knp
9vJFdUXA4jxCE+OFXMxsIc5b/Yl8tCZz+Q4YhJr4jpL3kdMRppT+ba2XUO8MHaK4
HjFLJjkpCHaKZisc7hlaXa+GHgoiSreZXnysRRABsCO0YW/WnxLHV9cEklTOKTjy
POYTNOK13bsy0eIAYpzTvw==
//pragma protect end_data_block
//pragma protect digest_block
VZ2HLamX22px/6c+HZTpfiBs6hc=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_chi_ic_snoop_transaction::post_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
It+N+KEFybC5Q3Vu/lzvy0Vdi+/CV1IaPkfYaL20YpXd3jbSDCGOR93sjVs0YMVO
pDBbXj6UJPQ/MB2Sdvlxp+Dw5h3eGIalz0ha6Y7VGtxFjltaDEN/dROAZkoF+dHg
wkGcYK1u3HHdJNDfQDbNzrS7cUFlA3KpRb0D2qeb7C66VFKGBZxtGg==
//pragma protect end_key_block
//pragma protect digest_block
n7ACc3M77BxZRA9N9L2gKydJyzM=
//pragma protect end_digest_block
//pragma protect data_block
wTmc84h0Z4rj8XuGW6Rb5AikX2MpL26UEiN3S9/3pO2dZKNqQfwWoFJs8FgI+YaI
2YYG2RezIWK4oNbr+spnTd0ufPqCUBN1npA8bY8kjXbcNMB03EZOcP1ehMMTJ2EK
wNG6ISVeaFanC8f0ZI+kaRS8wMwrySOIxQzBz9B/xg2mQqcQIvb5aABBA/7PmESX
kwL5WAetQmS4B3akGzS+lyefkZcbUdJjVepZMTLffXXrd8ppnIooZ06pY1VzSMBd
+KDZd8j9Adnc0nzH30yZibr6XXFzavo4RbHPQN+wdcXbDMPEYFqByb6YCrnnIXNM
s/T82gEfaGHgCKYjRvc/z0KzU++k+NySdfgOd6AFOhAmIUAL16v7dBnvGbtaTRee
D1Jxs8rv7cWV7M1XkL7obGclFCOCjtXctr+NEV5M+31yVumO8ruVFYGB12acdIIh
43ecZDL9AgyQcH9Y7IGLs7RJjIJsObvxTRPIQplt7FyVlVHpaeYrbWTxWbJEu9Pl
ETCoA6TjTf6Mz089olw8Z9Exhqy7wfJoRBMr1VJewd/Yk+dcK9Ku0bWQRHGaDYOK
bz5yOFK+8qvLuMj8Qy6AqwluTyP6Bn90QDaSg87BxzxG4Y/A6f7jylme2y7kp73P
nDk5wGVtnP7kOfDS7HP16LzRr3CZBdRolnxDOcePSkcA831dcUArbH13Leu0kG6z
szNjmrxXPW/Q07/0ue4ErxDEfrtUnOGy8B826RRg/6N5AGt22KZsqfhP8DlLHNT0
j1iVFwxdQArY6QoJUqqpuJWKHjLCpBZ2x8dSa2jxp8Ug94F/Y2cbF9qLR/sX0ltQ
bmmWQMscVbhl3dDxAj+TyBnc5freQu3mVPN/FFeOjeLAfl5Cua/RwzHFig4wB8hZ
hAgh9Xxw2qrIGZSWlRLTYyr24nMK/eBt4KpHmG58Z26Dc9UXqELWNFrtUzSfp5pH
reHEk0+opeYQMa3fHC/yBOUVSESoluzDyG65Tnc5pxiDnoEzAdrHxx9/VocO/lsG
CXtimoC49Q71kvVIKg6CmHoUzl0tYDG636Nnx2Pn2mB2MKE/yiz/GX0XZhcrny1j
yfcz+oP+GPUhyYwJqq0Ep3lvLJl8qblTdvTlsJ8yGUiZ750Xifigp8/8uHFKvYAM
4C4SnXZeUNjBbA978AuNLY/mKQobqvC9L6dZPwXmCc9vDr1lnQHJlh3G+qcdy47e
Geo6wjP6DzH04rTdDVpi0tNmvfqF490YSaMEg1gWASYIW/qpSWrc4rV/9YIz4BaB
bjZOlnOkYeR+fsK7LW9ziOALukh1Qf4n54uejhBrBB6LY2IONWXgjKb4dIqG2bvG

//pragma protect end_data_block
//pragma protect digest_block
zrBkrvNMkTHXGgXTAMtjoNTjtvg=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CbvQyzKkSgATj79z8hfgk+TrphEnAa3AQeyFp4nPoycAHHXW09dzELTXicZPXejy
IT2JlUXsZbCN29fdC1WNVcmgWqMkODtpby0CSPDv8blKCBo8/w7d+43rLh95BJ9n
6Jwq7Erz/KFAgVJBQriSFVCgV9WRNYE4Dp0FSZ0u5qKMQN0cJLnr8Q==
//pragma protect end_key_block
//pragma protect digest_block
qz1M5Zo0trRaKcJUUhTxwzxn9hw=
//pragma protect end_digest_block
//pragma protect data_block
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
5h+fQPoN2NCUwe+O0x6rof+JU98ielcbx8YR/B31TdLAQUlPZqSnslLq7SzdvCwV
ICbN5d8h8xpHxCDhFYevmj4I3fnqaknJuGI34F78Ss9UbAWgXNcmAvxqPqXco6lw
NYW7ejZrecj/rtlXxCBQnuG7dt62NoXBN3SvxbqI+pBYkCyzy4DQ+TKB92lUR+gs
zWD4Fwd7IUcLOz/6A8qSJweEOUlRDFSemMaejckigfV+8N8qqCscdTmGBnOm7hXF
WZDW/E8ObDdexyxwj8jYhGgOAR3Qra3sXvlMkS9Fe/d0qA8tabKLXK7dGR27vtyh
vdrwtfRdJ1Ib1PTDL7yDu2DcG+z2aI32s9zh7StP+ZWY+XU6p0sc8mQQx/n5wFJD
f1uu0dEgAeSemp6Q13eXDVrbYzsmjPvyXvRrApZTvOj5kchtPNA6WLzUF5Tncnsb
1hGsf/kFW0psRg9847V86BTAJJtaKAo3n9eI+VEK5q4kkRvAQjW7aD65TPwC3FhZ
/e97E7p1rQffKAtYq/VO3TF/KIsh6XFkHUSM9XuZJmcAOA9DxUEaYYhx2HuqSVyO
ZWLaZ7ZGCxcj6vPVp1RKRfRD4+vas/oVairfFjet+Qy6BM9Kyq+Nnni33Rg+PV1z
fq6cLp64bvSV4tgtjjbBzh2uIQeU0l4Ln/rOi2gTRift0QVb/rgG9zxiDcml0UP/
pNHdn71GtDjM4JYyioQ9EYN70oxq45YHOpoCK80SdIS/DH5LF7Vw/bJaqukjQF+p
RfBYBVrhhqMhD8fTQlwu4vmsCm4WCByOUBeqSNVmCxFBV4sVIMMo0lavr1HhNMIr
FoI01D/yulrGT64vB1+wLUkwf5VcWjmxrujEG73llvXnVY6FNhMb7i7SoYQxFJGE
oeMj4crJ4pR5JbtnPE8PzsGGH43fYBoUub4J6APknFAA4Cla4E3gyK8W3bpHuhva
onL7tj+xE5TANP1Dp0hI6/vV5gxn2RglR7NteJkfizhbnGK5OdwZSP9eD6/6Yqnl
qJuVQWC0m7pi4dMYwUzp4sj0LmMM43ysN1tLPUiuw8P7+FhDh//TxyQJwQWP6wWK
cZmfndXCCga8NRDjPO7rjjrdtZSh4a12KUXhQc6YoMz7QvEWH44WiUyOUeW+jx3q
ovCNOZuZCaYWEXXLLkQ0GKQh4iLP6mYwMEBjcdMGAfpfaGnQlS9utWnhg5u3Zm5D
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
//pragma protect end_data_block
//pragma protect digest_block
+tKQ/1CcZK3mCHBXNqejJmtS7NI=
//pragma protect end_digest_block
//pragma protect end_protected
     
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
