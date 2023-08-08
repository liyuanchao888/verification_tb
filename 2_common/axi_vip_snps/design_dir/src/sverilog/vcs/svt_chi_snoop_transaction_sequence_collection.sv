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

`protected
^EP>/b1Y9A6[fY^&0e\L8U>D9SUT&4.gAG3d1ZF.Q7FZ>Q^d8D?R2)-cGL&VJ/X,
#PYB1SFEI3Mb.<55eF+;#[=6cVB0:FaPS^SJN?_\48:9LWK,J?E?Hg)&YM0PcG7C
_<c+YeLJL7YN(,F7Y90?6.Ra=9J(U9a@<?H1O:fT)6H0GKb3NeXS[4@a-;WK,cQf
X9dE:g:>TMeEE-VC\df8AFUEH80..;gIR@\(B&\C@HDU+M>ZCG)a.[7AdbK9W+60
AV6@<<Y5]:dT:MU4ZdR4/eK@AI\OafMd=\8V3[M5g4OS(:M]O3]fSTE[9O5>\.](
e=YIfP>>#+4&P]03/T[e?K=ZR@f,X0]]>$
`endprotected


//vcs_vip_protect
`protected
J[feT3)IG\](a1]F-7,.4Ue76?TKdC5P)>ZR(-#AI0W?D(_U4UVd4(g63468;:b6
^(0\WOG4Jd3aQ?bUOe.)8^?/38JceJL4G\#Y=-Q&C0DFI-S#+[S.CbcBJ3KG+:U-
\B<;K.E(3@)3RX_AfOBZ=e60[0QOH7\NcO8W&TJ.AA+P/fF82^c.F>Ye]^)6FQTR
c_F5@KP4CEK9[_UZd2=1a^0.VZFBV2QgDe+G?SO]T+0FQ=1-PCN2(J@&W)]C_^7c
=\KYJM0OP&E1gN\-3DAB_P7FNL74=gd&,@;Y&GLZV0bKFO-4D#S^YNI_6PadML?E
?[9S7(^,6,8Ga4S0Ad8L1-Nb^,7,9MfULe#6(&(S.f]fZG[GdD\S8a(&ID>f4LY/
.BJ22Z[Vg4SANLX6aBW?/fL_aIGQDNQCNdf6QAGZbD90ER@.V42Ka^Z)>_B>RE/&
PBQ;SgHaC-M>76,ZeH36H#S[,QBR=e&U<+4)7M_SWJ7-V[XT:Q49e)WD7?VfN4bX
6LGgR;A5A2::B5.O5)?I3gAS1,a<HM8^?fgD(G,QLDXJ^dY#>#JA9/685W?V<_\2
d2+H8)2_BZGMBF2=eDK]F6Z0.PV5XZ9b(8D[CK-J4.,Q3DIdQ4\<-BF,Y7?R(_7A
^SeQag-?1Ge:Fg5b-OX=E+Dd51F0[P2@KfFG?CYSL&SEF4LFH<SD@=;N^\.X&3b6
=ZC7)YgGLCJEV,cDNF]&PF0UX:C^;,\Y5TgeVe<d7eI+;KFSP_9cC(GKdYRK[2UD
U7dZW[3Ja#3IE?TTS1[.+;MH0g+L2X4888BH;X?);<8-ME<.G?d9aAa-b4ebA\fI
]c+eg\Q_89b)E-Kf+:IRC<ecXf[(R+]>SG9Q_1VX.G,Q(+>_WgG5+>BXccI/=<BX
PMdfZV>0cC=3baN.II@_O@C-XE#;/]MJTc@7He;a;?E:&N;8XQGg&7IF/=Xa0N8=
/3a=]FeTXb;ZFY^6bG+G8ZQ7R?[-3^/ZfL&NJ)X.7@[S@V2F=YM0Ua#VH((d,(M)
32ag9b]=4^Q?MKU,[V0_MY#D(A(LW:4K8;R82J]V&f&F[;J17TKX5HL(^L8A2M),
:633V)O>_;c#UPV1)_GT-)R^:W1DP>Fb,EYA#0RYL-G5;;ga,WQ2D&GW7:>GP3E)
cdeSL:-;V528b]1c+Q5S>PPLF@C(Q>\,bT[>A5M]=;eEOMWI6A#7/MgV0Rg>/^O>
&M/(HDFDZ-XMUG?)3a,,PbfCL11+3)A11]Cc?-]JX#b1;@2BL-@1,IMP11R;YJXC
B,I#07>MGCTf(LR2;E_bNATFXXD/bL1c@b1Va5F1WSZ[E9Ae5U.9._@(>7#QgDQ2
JdSJ[g=982\&6BO]6:(2_@04\,,NVRO=E#I>:CgH4NXfd.DXaA9BZH@1c-B^Q__g
PJA(.Pa[e^2c0=,##<1=O+Sa2?_g)3&Q:SGX6Eed)[Pcg;a1@(;]8,JR),&FF302
QVL4>(^F+Z11e=E>LJa@?4&UX)C94Ue#MCS+1M2I-O)/KK7X59D<+-0LL_bY\9#;
-R229CKG5PSRRC^ZPT\04F:cb65(,Oc?]07S(;@Y<)fgW>(X@/[<4=eQOPfX_Naa
@IS_&KDdO581VEa5ZD?[R^d2:2(Y-LB;)A0.N?8/4dL9J^<9\R39518N1>=<##P^
F3(J(-aUS30Ide(M(EK3V0VGMDG;0:e5VFT7TK:=)3:A,1N&BKaX7eR&4)QX+35:
-(KI/=aN&e3E7UDGH]B]3_5UJ:FZ?74Qg_13/(40N8#NXO77+YWAaK@c=1.1RcU,
Tc9fg^&<(WVfL-<7e.OL(NFV(6M81X?W;aBg])Q;<R;>ZR/]P166CZY33eV;C>BY
ITYXUN#T)Sa5Y6;U=\@b4GHC:)[(L+7#+9M0219Ag+KX_#]7Cb\)S@4;E&0;bRHZ
.8Ud--N&@YBfN8/I99]bY+8J3KI350LPCOg0eBDU\B][9K[GNfW[9^INMb;TT)_0
+-./e,-8RACYfg2eX]]1dNZ5U:>F6P6>Qf-J>6IDLc^S>^59K[E1c;VT]:&SD/O?
0S\W-/G:b?=-53UfgOL#eEgN]:]A+#7U<+3^5K)E@5F?a9ZIa)ZOA3X&ARg2.gLf
e&9c&6,QAJ\Ie/VTIIS[FF1/(O?U3?42\ZDPHW7ZfZ59>QX3YCgIb-CJ@M-#3,1g
g453e.2+4=4C+W[]E06&-Fe;7?+?c+YI^NOd;Udb;^J)+2IZ_<TeKb4FdBBV^A(1
c>=;E?bS.7Z1OX;0NZ2E&+/df8Z.6.G6BedXeUSOUO?:J6B:),bQZ[SGL7,JM1T<
cWa.M8N6<g+H1>N+D.0>ZRDf?/PD:5&JHIca92P-2<(X_-f.\2HA:+c9aJaG_1X:
2E8adQ_e#^WMC4)L@+bd>Q&_VUR\[FF7[g64G8_7SV/K3QPbA6<aZDc9K$
`endprotected


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

