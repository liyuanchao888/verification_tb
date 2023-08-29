//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCE_COLLECTION_SV

typedef class svt_chi_system_rn_coherent_transaction_base_virtual_sequence;
typedef class svt_chi_system_cacheline_initialization_virtual_sequence;
 
`ifndef SVT_EXCLUDE_VCAP
typedef class svt_chi_rn_agent;
`endif
//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_RN_BASE_RDM CHI RN transaction transaction random base sequence
 * Base sequence for all CHI RN transaction sequences
 */  
/** 
 * @grouphdr sequences CHI_RN_BASE CHI RN transaction transaction base sequence
 * Base sequence for all CHI RN transaction sequences
 * @groupref CHI_RN_BASE_RDM
 */

/** 
 * @grouphdr sequences CHI_RN_NULL CHI RN transaction null sequence
 * Null sequence for RN transaction
 */  
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_RN_DIRECTED CHI RN transaction directed sequences
 * Directed sequences for RN transaction
 */

/** 
 * @grouphdr sequences CHI_RN_COHERENT CHI RN transaction coherent sequences
 * Coherent sequences for RN transaction
 */
  
/** 
 * @grouphdr sequences CHI_RN_DVM CHI RN transaction DVM sequences
 * DVM sequences for RN transaction
 */
  
/** 
 * @grouphdr sequences CHI_RN_BARRIER CHI RN transaction BARRIER sequences
 * BARRIER sequences for RN transaction
 */ 

/** 
 * @grouphdr sequences CHI_RN_ORDERING CHI RN transaction ORDERING sequences
 * ORDERING sequences for RN transaction
 */ 

/** 
 * @grouphdr sequences CHI_RN_EXCLUSIVE CHI RN transaction Exclusive sequences
 * Exclusive sequences for RN transaction
 */ 

/** 
 * @grouphdr sequences CHI_RN CHI RN transaction sequences
 * CHI RN transaction sequences
 * @groupref CHI_RN_DIRECTED
 * @groupref CHI_RN_COHERENT
 * @groupref CHI_RN_DVM
 * @groupref CHI_RN_BARRIER
 * @groupref CHI_RN_ORDERING
 * @groupref CHI_RN_EXCLUSIVE
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================  
// =============================================================================

/** 
 * @groupname CHI_RN_BASE
 * svt_chi_rn_transaction_base_sequence: This is the base class for svt_chi_rn_transaction
 * sequences. All other svt_chi_rn_transaction sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] To generate a CHI RN Transaction targetting a specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 *
 * [2] To generate a CHI RN Transaction targetting a specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 */
class svt_chi_rn_transaction_base_sequence extends svt_sequence#(svt_chi_rn_transaction);

  typedef enum {
    DIRECTED_HN_NODE_IDX_RAND_TYPE = 0,
    DIRECTED_ADDR_RANGE_RAND_TYPE = 1,
    OPEN_RAND_TYPE = 2
  } hn_addr_rand_type_enum;
 
  /** Enum used in the DVM Sync sequence to determine the LPID values in the DVM requests */
  typedef enum bit[1:0] {
     RANDOM_LPID, 
     ALL_SYNC_NON_SYNC_WITH_SAME_LPID,
     SYNC_NON_SYNC_WITH_DIFF_LPID,
     NON_SYNC_WITH_DIFF_LPID_SYNC_TO_ONE_LPID
  } dvm_lpid_pattern_enum;

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length = 1;

  /**
    * Output transactions generated by the sequence
    */
  svt_chi_rn_transaction output_xacts[$];

  /** @cond PRIVATE */  
  /** Type of randomization required relative to HN Node Idx and Addr */
  rand hn_addr_rand_type_enum hn_addr_rand_type;
   
  /** HN Node Idx to which transactions need to be sent to.
    * Applicable only if hn_addr_rand_type is set to
    * DIRECTED_HN_NODE_IDX_RAND_TYPE Can be used by extended sequences to
    * generated traffic to a given hn_node_idx The extended sequence must use
    * this property to pass it to the svt_chi_rn_transaction::hn_node_idx
    * property of the transactions generated by it. The relationship between
    * hn_node_idx and addr if any must be given in a transaction class extended
    * from svt_chi_rn_transaction.
    */
  rand bit[`SVT_CHI_HN_NODE_IDX_WIDTH-1:0] seq_hn_node_idx;

  /** Min addr of transactions generated. Applicable only if hn_addr_rand_type is set
    * to DIRECTED_ADDR_RANGE_RAND_TYPE
    * Extended sequences may use this property to control the range of addresses
    * in the transactions it generates
    */
  rand bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] min_addr;

  /** Max addr of transactions generated. Applicable only if hn_addr_rand_type is set
    * to DIRECTED_ADDR_RANGE_RAND_TYPE
    * Extended sequences may use this property to control the range of addresses
    * in the transactions it generates
    */
  rand bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] max_addr;

`ifdef SVT_CHI_ISSUE_B_ENABLE

  /** Variable used to decide if requesting Node can be Snooped or not.
   *  This can be programmed using config DB.
   *  If not programmed, the request snoopme field in the generated transaction will be randomized
   */
  rand bit seq_snoopme = 0;

  /** Variable used to decide atomic_compare_data is same as memory data or not.
   *  This can be programmed using config DB.
   *  If not programmed, the request atomic_compare_data field in the generated transaction will be randomized
   *  Applicable for ATOMICCOMPARE transaction only.
   */
  rand bit seq_atomic_compare_data_same_as_mem_data = 0;

 /** Data value written to the memory through initialisation.
  *  Applicable for ATOMICCOMPARE transaction only.
  */
  bit [`SVT_CHI_MAX_DATA_WIDTH-1:0] mem_data_after_cache_intialisation = 64'h0;


  /** Variable used to decide the Endianness of the outbound NonCopyBack Write data sent in Atomic transactions.
   *  This can be programmed using config DB.
   *  If not programmed, the request enum field in the generated transaction will be randomized
   */
  rand svt_chi_common_transaction::endian_enum  seq_endian = svt_chi_common_transaction::LITTLE_ENDIAN;


`endif
  /** @endcond */

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer) 

  /** Node configuration obtained from the sequencer */
  svt_chi_node_configuration node_cfg;
   
  /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

  /**
   * RN-F cache
   */
  svt_axi_cache my_cache;
  
  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  semaphore exclusive_access_seq_sema;
  /** 
   * Constructs a new svt_chi_rn_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_rn_transaction_base_sequence");

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_rn_virt_seqr();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Empty body method */
  virtual task body();
    svt_configuration cfg;

    if (p_sequencer == null) begin
      `uvm_fatal("body", "Sequence is not running on a sequencer")
    end

    /** Obtain a handle to the rn node configuration */
    p_sequencer.get_cfg(cfg);
    if (cfg == null || !$cast(node_cfg, cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
    end
    
  endtask // body

  /** Pre_randomize method */
  function void pre_randomize();
    svt_configuration cfg;
     super.pre_randomize();

    if (p_sequencer != null && node_cfg == null) begin
      /** Obtain a handle to the rn node configuration */
      p_sequencer.get_cfg(cfg);
      if (cfg == null || !$cast(node_cfg, cfg)) begin
        `uvm_fatal("pre_randomize", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
    
  endfunction // pre_randomize


   
endclass


// =============================================================================

`protected
)V7Uf<2X:550>8NT#+7@4I^b.;B=X+&,H(FO&>Q)7]4[MU5@APK+,)7P#Y9^01ZT
XBS-.>@7Qf=Fe7e6(Pf1BdbP,54M4/dXG\>dcd9(2c@SWIB5NI#L/NeEda:09;2:
32?U9-\(KF,R1U^d(ZRNQ:2F3\dXb6L,]2UK3d7_;Tcd/+:=^_\:O3G?>AHK3L5O
ELc?[YIe75FIf0T8K6;?8Q>7]eS.W#&0f7PP9D<g<g_cW1?WXQIX,FB3BVCP?1=Y
Wa_EE?V]=a/\WE&@R[.9NG\gf#I9)(JV/?W--FG2]WR+D3&\HUDgVJT;O:d/OP[g
.+59(OSV>D^eG[D6gdLVNM\g6$
`endprotected


//vcs_vip_protect
`protected
?7KEG+TQ(=GM+&E4V&9cL8#f8G^d6Ib3f/TD_d]5TPd2aUG,&3=<6(Rd.MU6>Ge-
,=eADU<09WeRUN)3Rf,4N@2aA_/B0-^\g6KOXe<eVHcLN1?07)L2=\FX9R4A,,2B
bKU68:9N]/)+C=T.Y@bJ7.W1R:]C_fA7e9JUI)=^5/5a+D@12@;VUTA>dRZL20B/
P;Q<+_1d&6d-^T86YQ&(?FGFP06E@aVM8C?N2DbBR43FW0>+_=4O^1E^WR@NdRE/
MWZRV=-+]26_M5GZKVK#(;\11d>UbNUEdFXE9G@O2SVBT:9QEM_?S.^PUd]@U2PW
e:0c/=AQfSC1TM0BY,J7)T>_W1X9Ze5AM&=PH+5c]4?#)g72HN[g]@@(76(DFHUg
7<7(72H6RQXRW=5-R(eO+Dc<&Sf0SQfAe7B5NY:6aM8ZeBaYEEa?fBSX<+V&Zg#0
>RTL.<^8_J^2[MHK(d6K<X#:-7BG1KW=<G1M.a3\57MR2\HF<JP->ZLFbYXA6PEL
<[/b8K3W6a2L>+G[Z?1AY9b-VV0NdA=2M,^\@^ZD82>\S/GCU=UK-<][4>C^/6>b
Y_5-396T>.\(K.e&+XNCPUKB4XY[Q@/KE&cKVQN6Z4Y;^^=U@TJ2W;Z8C_gDJ<SC
fUa.NS\E9Y;M<(>_7Y=SZ.2+YV2IWIIN=F^0HQIe7C2T+.@+Y,ABB8gTEACDAU3=
GOGa;(_Uf+I(WIRM8cB,-ScefbQXb4-O:VVA==JTB427Qd+RVT+(V>LaX+=K>E5?
><+cN,-CIC;b^])Kf[6KEDEV+;d,J)T=(eL_d:NU?@]2:-Z.^@/FQ;J]0/RM4WaW
FV&AKX_U3VdRX1^+?U/Q,I9E5XC:WNB5?#28AP@W\+Md&@BUcAI[N[XH3+T]9^BA
>20K#)gC7EBf/MJP+]TP&P@RcRcBTL9\S^[W1;fAMPgY/:b2gY<>K[cATS/ZBFE\
FQaUXXc;5167]6N&HV>6OJJXX>G&bZeF?@EQ_bLWCe?8@QI2g.IfLL,#D@=Q_\]M
?f#PY6B24=:6M(VE_\3YY#\9MB9LNeB.G+TSUedLdfdMV?(?SD&8(]2JVaFa/E39
669+8ZX.HK;G7-;60#&+1c\Q_FNX4@^_T=e1DR\#VI\d>LaEP?fN2I/)TE@.RB[4
8U^92DG:8+HQ5C^Z4:PMcMH0OC7DF@K@+?8X7Db=?4PWV1<;R:#F(D=<[QY1R17D
J?VGUa0_=e0K.6#.S^P6&?8NT,bMLRYHd-#^U>,\1ZR)@bR<#2eN_[=2JYJAYECX
MX8ID[,)I)?V+Z]<B7C,^D#b\WWVRAU,V(-/f</-PA.G].NO6WK9]?53PKB7b0U9
4CJ2A5WB5B\6^g:3AA.T,N/6.1Z#FXV^#W+d(@^Z=.H=[H<6/f&,Fa@]d;O-J.J2
aGIF9@]MJgX;_=;QUQJZ7YP5WeN[eCQ(eFB?@cL<0FT6ZVCUf8-UI0T&7)a0?.66
7Q66.1C@WU:FYW-SJ6L<Y[=X/#G=bcg-)OQ8N2BE)#:=ZXH72/B>[6=Q?EDA;S(\
,f[dTeEU.\WeBJFG?b0^Z-?+)3-]cSY9I951@1/R=@FRJ(47IML8MJB10N)PBE&=
,BEMRRN9#K?2+5:BW67A7R18&N(HcHS#gJKP#a-.f7K[J4\fagOZ+]X&UN0-Z.0&
[fQ&I=fRQKM;7+--+Tf,(;V>92M6Q6V3_VYBYJ4a>V9#,CSM;YG1T/J\4H9c8b-2
R=\]I6]7RU.L9^YB?S)A5dYaJ3e/1E3X(NEV<1@Y-YPTZ8?Z[U6IKQHZ=N]^E+3f
T#RM5YFOYA+Ab,AJef+&JIDKRQdgL0ITd\):P?6YUgY0G16;DC-P<\85;M=]IegD
_VOPVg1=4F9AgI[#b6.?1cZD/JWAMR]bP.:/UPJI@H?6:PLBSS0ROGfZ\Z(YAQ=#
28P6MBTTRXf3&SIQTR1Ma9.5UT0?.gJN/E=,2M=0RJ#6[J&E8#8AaWDb+D\8d5WE
;/KD3gI:W-(c7-:B.E+[J^B=&F6U&NdDdT@GQc<a<5,_)&,DDO+26_4]W=DNe6O=
7?Y&0KC=.;R;3O;9gf16_\/7VLX]H9<3-c(<3Z[g79=,MaLASV7(CZ-L=:STYH(7
DbH5Id?B0AE3?5SLE^-cQH]FaVL9,.T/I.W(+dBBWEHV\Za79AY:(QIP+GF)R-L,
c-Y>eO#:4^?#FM6-:bCTbEN?B>AU+C+?MC8\5aZW.^>(Hdg?&-S>LX-eG2E5]fZb
b(WIA;=,IPSS]D[dC3E7-(9;KGKZW@V+Tf(YR8g8).J5OPXdf=U8Q]KP@/Q7L@U7
UL4XS5:3D1f-P01;)fGT1>>B#bJ-MXF&C;G:D7:>cY]AW>:+gURSF&(R.4)-R2TJ
YS,Sa7Y?]USY2W64#NXZg6=/]3;1-[-T6\dQ5CZD3P?=-9)bH7;:dP07WCRbLE\9
fAbNg.02T5K<QX]&f3#Je]I8Ed_aF/QEB0SAB#D5VN=X@+7eF@V?7;6EB\T=ec7IW$
`endprotected


// =============================================================================
/** 
 * @groupname CHI_RN_BASE_RDM
 * svt_chi_rn_transaction_random_sequence
 *
 * This sequence creates a random svt_chi_rn_transaction request.
 */
class svt_chi_rn_transaction_random_sequence extends svt_chi_rn_transaction_base_sequence; 
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_random_sequence) 
  
  /** Controls the number of random transactions that will be generated */
  rand int unsigned sequence_length = 5;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
  
  /** Controls whether to collect timing information for each FLIT Types
   * (REQ,DAT,SNP,RSP) */
  bit get_timing_info = 0;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 500;
  }

  /**
   * Constructs the svt_chi_rn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_random_sequence");

  /** This method is called if get_timing_info is set to 1.
  * It fetches timing information for all FLIT types*/
  extern function void get_flit_timing_info(svt_chi_rn_transaction xact); 

  /** 
   * Executes the svt_chi_rn_transaction_random_sequence sequence. 
   */
  extern virtual task body();

  /** 
   * Calls `svt_xvm_do_with to send the transction.  By default only the xact_type
   * is constrained, but extended sequences can override this method to add other
   * constraints.
   */
  extern virtual task send_random_transaction(svt_chi_rn_transaction req);

endclass

//------------------------------------------------------------------------------
function svt_chi_rn_transaction_random_sequence::new(string name = "svt_chi_rn_transaction_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
function void svt_chi_rn_transaction_random_sequence::get_flit_timing_info(svt_chi_rn_transaction xact);
  real req_flit_end_time;
  real snp_flit_end_time;
  realtime begin_time,end_time;
  real dat_flit_end_time[];
  real tx_rsp_flit_end_time_arr[];
  real rx_rsp_flit_end_time_arr[];
  svt_chi_common_transaction::dat_msg_type_enum dat_msg_arr[];
  svt_chi_common_transaction::rsp_msg_type_enum tx_rsp_msg_arr[];
  svt_chi_common_transaction::rsp_msg_type_enum rx_rsp_msg_arr[];
  begin_time = xact.get_begin_realtime();
  end_time = xact.get_end_realtime();
 
  if (xact.get_req_timing_info(req_flit_end_time)) begin
    if (req_flit_end_time <= 0) begin
      `svt_error("svt_chi_rn_transaction_random_sequence", "req_flit_end_time for REQ Flit cannot be less than or equal to 0");
    end
    else if ((req_flit_end_time < begin_time) || (req_flit_end_time >  end_time)) begin
      `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("req_flit_end_time for REQ Flit is %0t which does not lie between begin_time:%0t and end_time:%0t for this transaction",req_flit_end_time,begin_time,end_time));
    end
    else begin
      `svt_debug("svt_chi_rn_transaction_random_sequence", $sformatf("req_flit_end_time for REQ Flit is %0t", req_flit_end_time));
    end
  end
  if (xact.get_snp_timing_info(snp_flit_end_time)) begin
    if (snp_flit_end_time <= 0) begin
      `svt_error("svt_chi_rn_transaction_random_sequence", "snp_flit_end_time for SNP Flit cannot be less than or equal to 0");
    end
    else if ((snp_flit_end_time < begin_time) || (snp_flit_end_time >  end_time)) begin
      `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("snp_flit_end_time for SNP Flit is %0t which does not lie between begin_time:%0t and end_time:%0t for this transaction",snp_flit_end_time,begin_time,end_time));
    end
    else begin
      `svt_debug("svt_chi_rn_transaction_random_sequence", $sformatf("snp_flit_end_time for SNP Flit is %0t", snp_flit_end_time));
    end
  end        
  if (xact.get_dat_timing_info(dat_flit_end_time,dat_msg_arr)) begin
    foreach (dat_flit_end_time[i]) begin
      if (dat_flit_end_time[i] <= 0) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("dat_flit_end_time for DAT Flit type %0s is less than or equal to 0 which is illegal", dat_msg_arr[i].name()));
      end
      else if ((dat_flit_end_time[i] < begin_time) || (dat_flit_end_time[i] >  end_time)) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("dat_flit_end_time for DAT Flit type %0s is %0t which does not lie between begin_time:%0t and end_time:%0t for this transaction",dat_msg_arr[i].name(), dat_flit_end_time[i],begin_time,end_time));
      end
      else begin
        `svt_debug("svt_chi_rn_transaction_random_sequence", $sformatf("dat_flit_end_time for DAT Flit type %0s is %0t", dat_msg_arr[i].name(), dat_flit_end_time[i]));
      end
    end
  end
  if (xact.get_tx_rsp_timing_info(tx_rsp_flit_end_time_arr,tx_rsp_msg_arr,,1)) begin
    foreach (tx_rsp_flit_end_time_arr[i]) begin
      if (tx_rsp_flit_end_time_arr[i] <= 0) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("tx_rsp_flit_end_time for TX RSP Flit type %0s is less than or equal to 0 which is illegal", tx_rsp_msg_arr[i].name()));
      end
      else if ((tx_rsp_flit_end_time_arr[i] < begin_time) || (tx_rsp_flit_end_time_arr[i] >  end_time)) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("tx_rsp_flit_end_time for TX RSP Flit type %0s is %0t which does not lie between begin_time:%0t and end_time:%0t for this transaction",tx_rsp_msg_arr[i].name(), tx_rsp_flit_end_time_arr[i],begin_time,end_time));
      end
      else begin
        `svt_debug("svt_chi_rn_transaction_random_sequence", $sformatf("tx_rsp_flit_end_time_arr for TX RSP Flit type %0s is %0t",tx_rsp_msg_arr[i].name(),tx_rsp_flit_end_time_arr[i]));
      end
    end
  end
  if (xact.get_rx_rsp_timing_info(rx_rsp_flit_end_time_arr,rx_rsp_msg_arr,,1)) begin
    foreach (rx_rsp_flit_end_time_arr[i]) begin
      if (rx_rsp_flit_end_time_arr[i] <= 0) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("rx_rsp_flit_end_time for RX RSP Flit type %0s is less than or equal to 0 which is illegal", rx_rsp_msg_arr[i].name()));
      end
      else if ((rx_rsp_flit_end_time_arr[i] < begin_time) || (rx_rsp_flit_end_time_arr[i] >  end_time)) begin
        `svt_error("svt_chi_rn_transaction_random_sequence", $sformatf("rx_rsp_flit_end_time for RX RSP Flit type %0s is %0t which does not lie between begin_time:%0t and end_time:%0t for this transaction",rx_rsp_msg_arr[i].name(), rx_rsp_flit_end_time_arr[i],begin_time,end_time));
      end
      else begin
        `svt_debug("svt_chi_rn_transaction_random_sequence", $sformatf("rx_rsp_flit_end_time_arr for RX RSP Flit type %0s is %0t",rx_rsp_msg_arr[i].name(),rx_rsp_flit_end_time_arr[i]));
      end
    end
  end

  // Negative testing for get_rx_rsp_timing_info API
  if (xact.get_rx_rsp_timing_info(rx_rsp_flit_end_time_arr,rx_rsp_msg_arr,svt_chi_common_transaction::SNPRESP,0)) begin
    `svt_error("svt_chi_rn_transaction_random_sequence", "Unexpected return value of 1 from get_rx_rsp_timing_info() API for SNPRESP response type");
  end
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_random_sequence::body();
  svt_chi_rn_transaction req;
  int seq_len_status, xact_type_status, enable_non_blocking_status,get_timing_info_status;
  svt_chi_rn_transaction req_sent[$];
  
  super.body();
  
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
  get_timing_info_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "get_timing_info", get_timing_info);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
  get_timing_info_status = m_sequencer.get_config_int({get_type_name(), ".get_timing_info"}, get_timing_info);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));
  `svt_xvm_debug("body", $sformatf("get_timing_info is %b as a result of %0s.", get_timing_info, get_timing_info_status ? "the config DB" : "the default value"));

  if(enable_non_blocking)
    sink_responses();
  
  repeat(sequence_length) begin
    `svt_xvm_create(req);
    send_random_transaction(req);

    if (!enable_non_blocking) begin
      get_response(rsp);
      if (get_timing_info) begin
        // Call method to gather FLIT timing information
        get_flit_timing_info(req);
      end
    end
   else begin
      req_sent.push_back(req);
   end // else: !if(!enable_non_blocking)
  end

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
    end
    if (get_timing_info) begin
      foreach(req_sent[i]) begin
        // Call method to gather FLIT timing information
        get_flit_timing_info(req_sent[i]);
      end
    end // if (get_timing_info)
  end // if (enable_non_blocking)
endtask

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_random_sequence::send_random_transaction(svt_chi_rn_transaction req);
  `svt_xvm_rand_send(req);
endtask

// =============================================================================
/** 
 * @groupname CHI_RN_BASE_RDM
 * svt_chi_rn_transaction_xact_type_sequence
 *
 * This sequence creates a random svt_chi_rn_transaction request with control
 * over the xact_type field.
 */
class svt_chi_rn_transaction_xact_type_sequence extends svt_chi_rn_transaction_random_sequence;
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_xact_type_sequence) 

  /** Controls the transaction type of the generated transactions */
  rand svt_chi_common_transaction::xact_type_enum xact_type = svt_chi_common_transaction::READNOSNP;

  /**
   * Constructs the svt_chi_rn_transaction_random_txnid_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_xact_type_sequence");
  
  /** 
   * Executes the svt_chi_rn_transaction_random_txnid_sequence sequence. 
   */
  extern virtual task body();

  /** 
   * Calls `svt_xvm_do_with to send the transction.  Constrains both the xact_type
   * and the txn_id properties.
   */
  extern virtual task send_random_transaction(svt_chi_rn_transaction req);

endclass

//------------------------------------------------------------------------------
function svt_chi_rn_transaction_xact_type_sequence::new(string name = "svt_chi_rn_transaction_xact_type_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_xact_type_sequence::body();
  int xact_type_status;

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  xact_type_status = uvm_config_db#(svt_chi_common_transaction::xact_type_enum)::get(m_sequencer, get_type_name(), "xact_type", xact_type);
`else
  xact_type_status = m_sequencer.get_config_int({get_type_name(), ".xact_type"}, xact_type);
`endif
  `svt_xvm_debug("body", $sformatf("xact_type is %s as a result of %0s.", xact_type.name(), xact_type_status ? "the config DB" : "randomization"));

  super.body();
endtask

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_xact_type_sequence::send_random_transaction(svt_chi_rn_transaction req);
  `svt_xvm_rand_send_with(req, { xact_type == local::xact_type;});
endtask

// =============================================================================
/** 
 * @groupname CHI_RN_NULL
 * svt_chi_rn_transaction_null_sequence
 *
 * This class creates a null sequence which can be associated with a sequencer but generates no traffic.
 */
class svt_chi_rn_transaction_null_sequence extends svt_chi_rn_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_null_sequence) 
  
  /**
   * Constructs the svt_chi_rn_transaction_null_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_null_sequence");

  /** 
   * Executes svt_chi_rn_transaction_null_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_rn_transaction_null_sequence::new(string name = "svt_chi_rn_transaction_null_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_null_sequence:: body();
endtask

// =============================================================================

/** 
 * @groupname CHI_RN_COHERENT
 * svt_chi_rn_coherent_transaction_base_sequence
 */
class svt_chi_rn_coherent_transaction_base_sequence extends svt_chi_rn_transaction_base_sequence;
  
  typedef bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] addr_t;
  typedef bit snp_attr_is_snoopable_t;
  typedef bit mem_attr_allocate_hint_t;
  typedef bit is_non_secure_access_t;
  typedef bit allocate_in_cache_t;
  typedef svt_chi_common_transaction::snp_attr_snp_domain_type_enum snp_attr_snp_domain_type_t;
  typedef svt_chi_common_transaction::data_size_enum data_size_t; 
  typedef bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] data_t;
  typedef bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable_t; 

  /** This enum specifies the addressing mode that is used to determine how address is generated by the RN transaction sequence */
  typedef enum bit[3:0] {IGNORE_ADDRESSING_MODE,RANDOM_NONOVERLAPPED_ADDRESS, SEQUENTIAL_NONOVERLAPPED_ADDRESS,
                         RANDOM_OVERLAPPED_ADDRESS, SEQUENTIAL_OVERLAPPED_ADDRESS, RANDOM_ADDRESS_IN_RANGE, TARGET_HN_INDEX,
                         USER_DEFINED, RANDOM_ADDRESS} addressing_mode_enum;

  /** This enum is used to determine how address is generated for a transaction in the RN transaction sequence<br>
   *  - When addr_mode is set to TARGET_HN_INDEX, the address of the transaction is set to a random cacheline size aligned value which falls within the valid address range of the specified HN.<br>
   *  - When addr_mode is set to RANDOM_ADDRESS, the address of the transaction being generated is set to a random value within the system address range and is either aligned or unaligned to the cacheline size.<br>
   *  - When use_directed_addr is 1, then the addr_mode will not have any significance.<br>
   *  .
   */
  addressing_mode_enum addr_mode;

`protected
RN92/^K\.5/HZfg<g4O39E<A?^/&P=GU>:+BBGJ>aK0K:-:>\(Hb7)#WM,,>[7IQ
@d#,d?5>e6C/?/6O8aO0PM#@IJXH7A#J7<+OdU)SgRCG[OS&X8+@7E20JT@Ve@F2
]3f#A=3^1PC/+$
`endprotected


  /** defines start address of the supported address range of current RN */
  rand addr_t start_addr;

  /** defines end address of the supported address range of current RN */
  rand addr_t end_addr;

  
  /** defines the order_type field that is to be set in the transactions generated by this sequence*/
  rand svt_chi_transaction::order_type_enum seq_order_type;

  /** 
    * defines the data_size field that is to be set in the tranactions generated by this sequence
    * This is applicable only when use_seq_data_size is set to 1. It is required to ensure that this
    * is constrained from test such that data_size is valid for the given transaction type. 
    */ 
  rand svt_chi_common_transaction::data_size_enum seq_data_size;  

  /** Indicates that the seq_data_size should be used for data_size of the transactions generated by this sequence*/
  bit use_seq_data_size = 0; 

  /** Indicates that the seq_p_crd_return_on_retry_ack should be used for p_crd_return_on_retry_ack of the transactions generated by this sequence*/
  bit use_seq_p_crd_return_on_retry_ack = 0; 

  /** Indicates the p_crd_return_on_retry_ack of the transactions generated by this sequence*/
  rand bit seq_p_crd_return_on_retry_ack; 

  /** 
    * Indicates that the addresses provided in directed_addr_mailbox should be used
    * for the transactions generated by this sequence
    */
  rand bit use_directed_addr = 1;
 
  /**
    * Indicates that the NS bit provided in the directed_is_non_secure_access_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_non_secure_access = 1; 
 
  /**
    * Indicates that the Snoop attribute provided in the directed_snp_attr_is_snoopable_mailbox and directed_snp_attr_snp_domain_type_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_snp_attr = 1; 
 
  /**
    * Indicates that the Memory attributes provided in the directed_mem_attr_allocate_hint_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_mem_attr = 1; 

  /**
    * Indicates that the data_size provided in the directed_data_size_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_data_size = 0; 
 
  /**
    * Indicates that the data provided in the directed_data_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_data = 0; 

  /**
    * Indicates that the byte_enable provided in the directed_byte_enable_mailbox should 
    * be used for the transactions generated by this sequence. This is valid only when 
    * use_directed_addr is set to 1.  
    */ 
  bit use_directed_byte_enable = 0; 

  /**
    * Indicates that the allocate in cache attribute provided in directed_allocate_in_cache_mailbox should
    * be used for the CleanUnique transactions generated by the sequence. This is valid only when
    * use_directed_addr is set to 1.
    */
  bit use_directed_allocate_in_cache =0;

  /** 
    * Indicates whether unique txn_id should be generated for each
    * transaction.
    */  
  rand bit generate_unique_txn_id = 0;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** @cond PRIVATE */
  /** This can be useful to verify SLC invisible cache mode for CHI-B */
  bit perform_cacheinit_for_non_coherent_xacts = 0;
  /** @endcond */

 /** 
   * Static used to store the transactions used for cache initialisation for
   * atomic compare tranasactions. 
   */
 static svt_chi_rn_transaction rn_cacheline_ini_xacts[$];

 
 /** 
   * Transactions generated as used for cache initialisation for
   * atomic compare tranasactions are stored into cacheline_ini_xacts
   * with the help of this transaction handle. 
   */
  svt_chi_rn_transaction local_rn_xact;
`endif

  /**
    * Applicable if use_directed_addr is set.
    * A mailbox into which a user can put addresses to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no addresses are available in the mailbox for generating the required number of
    * transactions
    */
  mailbox #(addr_t) directed_addr_mailbox;

  /**
    * Applicable if use_directed_addr is set.
    * A mailbox into which a user can put snoop attribute is_snoopable to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no snoop attributes are available in the mailbox for generating the required number of
    * transactions
    */
  mailbox #(snp_attr_is_snoopable_t) directed_snp_attr_is_snoopable_mailbox;

  /**
    * Applicable if use_directed_addr is set.
    * A mailbox into which a user can put snoop attribute snoop domain type to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no snoop attributes are available in the mailbox for generating the required number of
    * transactions
    */
  mailbox #(snp_attr_snp_domain_type_t) directed_snp_attr_snp_domain_type_mailbox;

  /**
    * Applicable if use_directed_addr is set.
    * A mailbox into which a user can put memory attribute allocate hint to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no snoop attributes are available in the mailbox for generating the required number of
    * transactions
    */
  mailbox #(mem_attr_allocate_hint_t) directed_mem_attr_allocate_hint_mailbox;

  /**
    * Applicable if use_directed_addr is set.
    * A mailbox into which a user can put NS attribute to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no snoop attributes are available in the mailbox for generating the required number of
    * transactions
    */
  mailbox #(is_non_secure_access_t) directed_is_non_secure_access_mailbox;

  /**
    * Applicable if both use_directed_addr, and use_directed_data_size are set.
    * A mailbox into which a user can put data_size attribute to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no data_size attributes are available in the mailbox for generating the required number of
    * transactions. It is required to ensure that the elements in this mailbox are populated 
    * from test such that data_size is valid for the given transaction type.
    */
  mailbox #(data_size_t) directed_data_size_mailbox;

  /**
    * Applicable if both use_directed_addr, and use_directed_data are set.
    * A mailbox into which a user can put data attribute to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no data_size attributes are available in the mailbox for generating the required number of
    * transactions. 
    */
  mailbox #(data_t) directed_data_mailbox;

  /**
    * Applicable if both use_directed_addr, and use_directed_byte_enable are set.
    * A mailbox into which a user can put byte_enable attribute to which transactions have to be
    * generated. The sequence times out after the delay sepcified by #direct_addr_timeout 
    * if no data_size attributes are available in the mailbox for generating the required number of
    * transactions. It is required to ensure that the elements in this mailbox are populated 
    * from test such that byte_enable is valid for the given transaction attributes.
    */
  mailbox #(byte_enable_t) directed_byte_enable_mailbox;
 
  /**
    * Applicable if both use_directed_addr, and use_directed_allocate_in_cache are set.
    * A mailbox into which a user can put allocate_in_cache attribute to which transactions have to be
    * generated. The sequence times out after the delay specified by #direct_addr_timeout 
    * if no data_size attributes are available in the mailbox for generating the required number of
    * transactions. It is required to ensure that the elements in this mailbox are populated 
    * from test such that byte_enable is valid for the given transaction attributes.
    * It is only applicable for CleanUnique transactions.
    */
  mailbox #(allocate_in_cache_t) directed_allocate_in_cache_mailbox;

  /**
    * Applicable if use_directed_addr is set.  A timeout based on which the
    * sequence that waits for a directed address in directed_addr_mailbox times
    * out
    */
  real direct_addr_timeout=1000000;

  /**
    * A mailbox into which a reference of transactions generated by this sequence are put.
    * This can potentially be used by another process to take these transactions out
    * and use its parameters (such as address) for controlling another sequence or
    * populating another sequence's #directed_addr_mailbox
    */
  mailbox #(svt_chi_rn_transaction) output_xact_mailbox;

  /** 
   * If set the sequence will wait for transaction to finish before initiation next transaction
   */
  bit     blocking_mode = 0;
  
  /**
    * If set, initializes cachelines of caches of peer master for the address
    * of the transaction generated This is done before the transaction is sent
    * out. For a description of how cache initialization is done refer
    * documentation of svt_chi_cacheline_initialization
    */
  bit initialize_cachelines = 0;

  /**
    * If set, indicates that cacheline initialization is done for all the 
    * transactions that this sequence is going to send. 
    * when initialize_cachelines=0, this variable is set to 1 at the begining
    * of the sequence body. 
    * when initialize_cachelines=1, this variable is set to 1 after the 
    * svt_chi_cacheline_initialization sequence is run for all the transactions 
    * that this sequence is going to send.
    */
  bit initialize_cachelines_done = 0;

  /**
    * If set, forces cacheline initialization even though current state may be valid for chosen
    * transaction to be issued. When set to 0 then cacheline initialization sequence will not
    * force change of state if current state is valid for the chosen transaction
    */
  bit force_cache_initialization = 1;

  /** This is applicable when the svt_chi_cacheline_initialization sequence is started from this sequence
   *  When set to 1: 
   *  - The SD state randomization will be avoided in the function get_random_initial_cachestate of svt_chi_cacheline_initialization
   *  - writeclean_full, readshared xacts will be avoided from the svt_chi_cacheline_initialization sequence 
   *  .
   */
  bit bypass_cacheinit_sd_wrclean_rdshared = 0;  
  
  /** Flag to indicate if the cache line state is transitioned silently */
  bit bypass_silent_cache_line_state_transition = 0;

  /** To constrain the CMO and Atomic transactions memory attributes (Cacheable, EWA, Device) and SnpAttr to be same as that of other coherent transactions (Cacheable[1], EWA[1], Device[0], SnpAttr[1]) */
  bit use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics = 0;

  /** To constrain the transaction order_type based on the seq_order_type */
  bit use_seq_order_type = 1;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  bit program_poison_to_zero_cache_initialization = 0;
`endif  

  /** Active transaction queue */
  protected svt_chi_rn_transaction active_xacts[$];

  /** Active transaction queue */
  svt_chi_rn_transaction active_rn_xacts[$];
  static svt_chi_rn_transaction cache_active_rn_xacts[$];

  protected addr_t _previous_xact_addr = 0;
  
`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** Distribution weight for generation of WRITEEVICTOREVICT transactions */
  int unsigned writeevictorevict_wt = 0;
  /** Distribution weight for generation of WRITENOSNPZERO transactions */
  int unsigned writenosnpzero_wt = 0;
  /** Distribution weight for generation of WRITEUNIQUEZERO transactions */
  int unsigned writeuniquezero_wt = 0;
  /** Distribution weight for generation of MAKEREADUNIQUE transactions */
  int unsigned makereadunique_wt = 0;
  /** Distribution weight for generation of READPREFERUNIQUE transactions */
  int unsigned readpreferunique_wt = 0;
  /** Distribution weight for generation of WRITENOSNPFULL_CLEANSHARED transactions */
  int unsigned writenosnpfull_cleanshared_wt =0;
  /** Distribution weight for generation of WRITENOSNPFULL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writenosnpfull_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of WRITEUNIQUEFULL_CLEANSHARED transactions */
  int unsigned writeuniquefull_cleanshared_wt =0;
  /** Distribution weight for generation of WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writeuniquefull_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of WRITENOSNPFULL_CLEANINVALID transactions */
  int unsigned writenosnpfull_cleaninvalid_wt =0;
  /** Distribution weight for generation of WRITENOSNPPTL_CLEANINVALID transactions */
  int unsigned writenosnpptl_cleaninvalid_wt =0;
  /** Distribution weight for generation of WRITENOSNPPTL_CLEANSHARED transactions */
  int unsigned writenosnpptl_cleanshared_wt =0;
  /** Distribution weight for generation of WRITENOSNPPTL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writenosnpptl_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of WRITEUNIQUEPTL_CLEANSHARED transactions */
  int unsigned writeuniqueptl_cleanshared_wt =0;
  /** Distribution weight for generation of WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writeuniqueptl_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of WRITEBACKFULL_CLEANSHARED transactions */
  int unsigned writebackfull_cleanshared_wt =0;
  /** Distribution weight for generation of WRITEBACKFULL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writebackfull_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of WRITEBACKFULL_CLEANINVALID transactions */
  int unsigned writebackfull_cleaninvalid_wt =0;
  /** Distribution weight for generation of WRITECLEANFULL_CLEANSHARED transactions */
  int unsigned writecleanfull_cleanshared_wt =0;
  /** Distribution weight for generation of WRITECLEANFULL_CLEANSHAREDPERSISTSEP transactions */
  int unsigned writecleanfull_cleansharedpersistsep_wt =0;
  /** Distribution weight for generation of STASHONCESEPUNIQUE transaction */
  int unsigned stashoncesepunique_wt = 0;
  /** Distribution weight for generation of STASHONCESEPSHARED transaction */
  int unsigned stashoncesepshared_wt = 0;
`endif //issue_e_enable
  /** Distribution weight for generation of READNOSNOOP transactions */
  int unsigned readnosnp_wt = 0;
  /** Distribution weight for generation of READONCE transaction */
  int unsigned readonce_wt = 0;
  /** Distribution weight for generation of READCLEAN transaction */
  int unsigned readclean_wt = 0;
  `ifdef SVT_CHI_ISSUE_D_ENABLE
  /** Distribution weight for generation of CleanSharedPersistSep transaction */
  int unsigned cleansharedpersistsep_wt = 0;
  `endif  //issue_d_enable
`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** Distribution weight for generation of READSPEC transaction */
  int unsigned readspec_wt = 0;
  /** Distribution weight for generation of READNOTSHAREDDIRTY transaction */
  int unsigned readnotshareddirty_wt = 0;
  /** Distribution weight for generation of READONCECLEANINVALID transaction */
  int unsigned readoncecleaninvalid_wt = 0;
  /** Distribution weight for generation of READONCEMAKEINVALID transaction */
  int unsigned readoncemakeinvalid_wt = 0;
  /** Distribution weight for generation of CLEANSHAREDPERSIST transaction */
  int unsigned cleansharedpersist_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_ADD transaction */
  int unsigned atomicstore_add_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_CLR transaction */
  int unsigned atomicstore_clr_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_EOR transaction */
  int unsigned atomicstore_eor_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_SET transaction */
  int unsigned atomicstore_set_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_SMAX transaction */
  int unsigned atomicstore_smax_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_SMIN transaction */
  int unsigned atomicstore_smin_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_UMAX transaction */
  int unsigned atomicstore_umax_wt = 0;
  /** Distribution weight for generation of ATOMICSTORE_UMIN transaction */
  int unsigned atomicstore_umin_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_ADD transaction */
  int unsigned atomicload_add_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_CLR transaction */
  int unsigned atomicload_clr_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_EOR transaction */
  int unsigned atomicload_eor_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_SET transaction */
  int unsigned atomicload_set_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_SMAX transaction */
  int unsigned atomicload_smax_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_SMIN transaction */
  int unsigned atomicload_smin_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_UMAX transaction */
  int unsigned atomicload_umax_wt = 0;
  /** Distribution weight for generation of ATOMICLOAD_UMIN transaction */
  int unsigned atomicload_umin_wt = 0;
  /** Distribution weight for generation of ATOMICSWAP transaction */
  int unsigned atomicswap_wt = 0;
  /** Distribution weight for generation of ATOMICOMPARE transaction */
  int unsigned atomiccompare_wt = 0;
  /** Distribution weight for generation of PREFETCHTGT transaction */
  int unsigned prefetchtgt_wt = 0;
  /** Distribution weight for generation of WRITEUNIQUEFULLSTASH transaction */
  int unsigned writeuniquefullstash_wt = 0;
  /** Distribution weight for generation of WRITEUNIQUEPTLSTASH transaction */
  int unsigned writeuniqueptlstash_wt = 0;
  /** Distribution weight for generation of STASHONCEUNIQUE transaction */
  int unsigned stashonceunique_wt = 0;
  /** Distribution weight for generation of STASHONCESHARED transaction */
  int unsigned stashonceshared_wt = 0;
`endif
  /** Distribution weight for generation of READSHARED transaction */
  int unsigned readshared_wt = 0;
  /** Distribution weight for generation of READUNIQUE transaction */
  int unsigned readunique_wt = 0;
  /** Distribution weight for generation of CLEANUNIQUE transaction */
  int unsigned cleanunique_wt = 0;
  /** Distribution weight for generation of MAKEUNIQUE transaction */
  int unsigned makeunique_wt = 0;
  /** Distribution weight for generation of WRITEBACKFULL transaction */
  int unsigned writebackfull_wt = 0;
  /** Distribution weight for generation of WRITEBACKPTL transaction */
  int unsigned writebackptl_wt = 0;
  /** Distribution weight for generation of WRITEEVICTFULL transaction */
  int unsigned writeevictfull_wt = 0;
  /** Distribution weight for generation of WRITECLEANFULL transaction */
  int unsigned writecleanfull_wt = 0;
  /** Distribution weight for generation of WRITECLEANPTL transaction */
  int unsigned writecleanptl_wt = 0;
  /** Distribution weight for generation of EVICT transaction */
  int unsigned evict_wt = 0;
  /** Distribution weight for generation of WRITENOSNPFULL transaction */
  int unsigned writenosnpfull_wt = 0;
  /** Distribution weight for generation of WRITENOSNPPTL transaction */
  int unsigned writenosnpptl_wt = 0;
  /** Distribution weight for generation of WRITEUNIQUEFULL transaction */
  int unsigned writeuniquefull_wt = 0;
  /** Distribution weight for generation of WRITEUNIQUEPTL transaction */
  int unsigned writeuniqueptl_wt = 0;
  /** Distribution weight for generation of CLEANSHARED transaction */
  int unsigned cleanshared_wt = 0;
  /** Distribution weight for generation of CLEANINVALID transaction */
  int unsigned cleaninvalid_wt = 0;
  /** Distribution weight for generation of MAKEINVALID transaction */
  int unsigned makeinvalid_wt = 0;
  /** Distribution weight for generation of EOBARRIER transaction */
  int unsigned eobarrier_wt = 0;
  /** Distribution weight for generation of ECBARRIER transaction */
  int unsigned ecbarrier_wt = 0;
  /** Distribution weight for generation of DVMOP transaction */
  int unsigned dvmop_wt = 0;
  /** Distribution weight for generation of PCRDRETURN transaction */
  int unsigned pcrdreturn_wt = 0;
  /** Distribution weight for generation of REQLINKFLIT transaction */
  int unsigned reqlinkflit_wt = 0;
  
  constraint valid_start_and_end_address {
    start_addr <= end_addr;
  }

  constraint valid_order_type {
`ifdef SVT_CHI_ISSUE_E_ENABLE
    if(writeevictorevict_wt == 1)
      seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;
    else 
`endif 
      if(    (writeuniqueptl_wt == 1) || (writeuniquefull_wt == 1)
          `ifdef SVT_CHI_ISSUE_E_ENABLE
          || (writeuniquezero_wt == 1)
          || (writeuniquefull_cleanshared_wt == 1) || (writeuniquefull_cleansharedpersistsep_wt == 1)
          || (writeuniqueptl_cleanshared_wt == 1)  || (writeuniqueptl_cleansharedpersistsep_wt == 1)
          `endif
          || (readonce_wt == 1)
        ) seq_order_type != svt_chi_transaction::REQ_EP_ORDERING_REQUIRED;

`ifdef SVT_CHI_ISSUE_B_ENABLE
      else if(    readoncemakeinvalid_wt == 1 || readoncecleaninvalid_wt == 1
               || writeuniqueptlstash_wt == 1 || writeuniquefullstash_wt == 1
             ) seq_order_type != svt_chi_transaction::REQ_EP_ORDERING_REQUIRED;
`endif
      else if(    readnosnp_wt == 0
               && writenosnpfull_wt == 0 && writenosnpptl_wt == 0
               `ifdef SVT_CHI_ISSUE_E_ENABLE
               && writenosnpzero_wt == 0
               && (writenosnpfull_cleanshared_wt == 0) && (writenosnpfull_cleansharedpersistsep_wt == 0) && (writenosnpfull_cleaninvalid_wt == 0)
               && (writenosnpptl_cleanshared_wt == 0)  && (writenosnpptl_cleansharedpersistsep_wt == 0)  && (writenosnpptl_cleaninvalid_wt == 0)  
               `endif 
               `ifdef SVT_CHI_ISSUE_B_ENABLE
               && atomicstore_add_wt  == 0 && atomicload_add_wt  == 0
               && atomicstore_clr_wt  == 0 && atomicload_clr_wt  == 0
               && atomicstore_eor_wt  == 0 && atomicload_eor_wt  == 0
               && atomicstore_set_wt  == 0 && atomicload_set_wt  == 0
               && atomicstore_smax_wt == 0 && atomicload_smax_wt == 0
               && atomicstore_smin_wt == 0 && atomicload_smin_wt == 0
               && atomicstore_umax_wt == 0 && atomicload_umax_wt == 0
               && atomicstore_umin_wt == 0 && atomicload_umin_wt == 0
               && atomicswap_wt == 0 && atomiccompare_wt == 0
               `endif
             ) seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;

`ifdef SVT_CHI_ISSUE_B_ENABLE
    seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
`endif
  }

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_coherent_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer) 

  /**
   * Constructs the svt_chi_rn_coherent_transaction_base_sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_coherent_transaction_base_sequence");
  
  /** 
    * Get the transaction weightage from factory if set.
    */
  extern virtual task pre_body();

  /** 
   * Executes the svt_chi_rn_transaction_random_sequence sequence. 
   */
  extern virtual task body();
   
  /** Generates transactions based on sequence_length: 
   * If use_directed_addr is set, the directed address is fetched from the
   * direct_addr_mailbox. 
   * A callback, pre_rn_f_base_seq_item_randomize is issued where a user can
   * potentially provide a transaction. If the callback returns with a valid
   * transaction, it is sent out. Otherwise a transaction is randomized and sent
   * out.
   * If the initialize_cachelines property is set, an event is triggered in the parent
   * sequence so that the cachelines get initialized. Note that this needs to be
   * done in a parent (virtual) sequence because initialization of cachelines
   * involve multiple master sequencers. Once initialization is done the
   * transaction is sent out 
   */
  extern virtual task generate_transactions();
   
  /**
    * Gets addresses from directed_addr_mailbox. If an address is not already
    * available, this task waits for direct_addr_timeout before timing out.
    * Once the address is received, we check if it is feasible to send out a
    * transaction with that address based on the weights of transaction types
    * and the corresponding domain type for that address mentioned in the system
    * configuration. In addition to address, get memory attributes and snoop
    * attribues from directed_mem_attr_allocate_hint_mailbox, 
    * directed_snp_attr_is_snoopable_mailbox and directed_snp_attr_snp_domain_type_mailbox.
    * Also get NS bit from directed_is_non_secure_access_mailbox. Memory, Snoop and NS 
    * attributes will not be available if the use_directed_addr is set to 0
    */
  extern task get_directed_addr(
                         int xact_num,
                         output bit is_error,
                         output bit randomize_with_directed_addr, 
                         output bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr, 
                         output bit directed_snp_attr_is_snoopable,
                         output svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                         output bit directed_mem_attr_allocate_hint,
                         output bit directed_is_non_secure_access,
                         output bit directed_allocate_in_cache,
                         output svt_chi_common_transaction::data_size_enum directed_data_size,
                         output bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                         output bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable
                         );
   
  // Task that derived classes can override. Called just before an
  // item is sent. If derived class implementation passes master_xact as non-null,
  // that item is sent.
  extern virtual task pre_rn_f_base_seq_item_randomize(bit is_valid_addr, bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] my_addr, output svt_chi_rn_transaction rn_xact);

  /** Randomizes a single transaction based on the weights assigned.  If
   * randomized_with_directed_addr is set, the transaction is randomized with
   * the address specified in directed_addr. In addition to address, 
   * it is randomized with memory attributes, snoop attribues and NS bit specified in 
   * directed_mem_attr_allocate_hint, directed_snp_attr_is_snoopable, 
   * directed_snp_attr_snp_domain_type and directed_is_non_secure_access.
   * Memory, Snoop and NS attributes will not be used for randomization if the 
   * use_directed_addr is set to 0
   */
  extern virtual  task randomize_xact(svt_chi_rn_transaction           rn_xact,
                                      bit                              randomize_with_directed_addr, 
                                      bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr,
                                      bit                              directed_snp_attr_is_snoopable,
                                      svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                                      bit                              directed_mem_attr_allocate_hint,
                                      bit                              directed_is_non_secure_access,
                                      bit                              directed_allocate_in_cache,
                                      svt_chi_common_transaction::data_size_enum directed_data_size, 
                                      bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                                      bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable,
                                      output bit                       req_success,
                                      input  int                       sequence_index = 0,
                                      input  bit                       gen_uniq_txn_id = 0
                                    );

  /** Waits until all transactions in active_xacts queue have ended */
  extern virtual task wait_for_active_xacts_to_end();

  /** Used to sink the responses from the response queue. */
  extern virtual task sink_responses();

  /** 
   * Initialize cacheline for initiating RN-F node and peer RN-F nodes,such that the cache line state in initiating node 
   * is valid to send out the coherent transaction
   */
  extern virtual task initialize_cache(svt_chi_rn_transaction xact);
    
  /** Assigns a weight of 1 for the transaction type given in rn_xact_type */
  extern function void assign_xact_weights (svt_chi_common_transaction::xact_type_enum rn_xact_type);

  /** Sets the weights of all transaction types to 0 */ 
  extern function void disable_all_weights();

  /** Sets the weights of all transaction types to 1 */ 
  extern function void enable_all_weights();

endclass // svt_chi_rn_coherent_transaction_base_sequence

`protected
WA71J?2LVK(:TXB\9/fZVaA1&OQ+;>Acb-EfWCSGN-dcG6BRA(,a/)-^#23\6e+4
YE#c7.[PH+>:#db?I=a(;#[AI=D[GWG0G@Od;K[8J-GFc@<:_Q#8&=(LEb_/+EbQ
L#FTN#2&bPKQf-#H-KEOLddXM6T?HMIfZT=@Aac@ETNEefa>B]5Ta>Y6^U5^6)VY
W@^V2+I[01VN9_+A0@04PcZHRD:I(4Y/a3Ec)[g/\-+9Eb+NA[0WKL[P4>eTXP)[
LTN\eZHJ)Eab\1A>IfJB7_Zc&?MKU>gaN.R-?d.G82TcJaBKgFW?>,)]+/_/W]f>
935\_Jf=FBBH+=KU@aX8#cfDS_cBPMeJ[E^AfC-[L<SS16#L_4(/9<4M/KOKXaE5
=1FFC]MX_dJ94b;[\b.:aeG8_:FOG+d_K)ME/?T.6(2I>58]IDZ/FB[P1R(#gCe1
]W_IB)DVP=>fLNeP,.5e>VG\08NLFaCcZdD^,V5,9>@+Td9LFJ\eK0>)e2Z-@?-7
KGfB[T1Fd^PB.33\KD-DE6F^C++e]OP4KV)Y,XJg<224?J+YQDfSb\_OTOGZJ8CN
?b;c/WRW3-^^C#eQ9404J7@[]f<a>dQa<^E4T7FDW2FS3cF3RbaCd5NSM[+d-PWH
DfGB>8MMUgV;SF0[>I.GX_T[@;14&VgFUJT(+ZHJL#=\(.f]K@RZ(dW(S)Yd7(d;
G8IBJA1RT2gdIJUA(E?YBF/)2;2;]XMgFFL64W(JcVV]YZ5@IeRF-Pd940(]?B\-
cF),]+>=B]0ZKfGCZL52UE@/>2M(P>NAgF5RZ5#Y;4_&W:fU<F:\20c6#=<Mf[/H
<92a-2;b.]@Z0$
`endprotected
 
//------------------------------------------------------------------------------
task svt_chi_rn_coherent_transaction_base_sequence::pre_body();
  bit status;
  super.pre_body();

`ifdef SVT_UVM_TECHNOLOGY
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length );       
  status = uvm_config_db#(bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0])::get(null, get_full_name(), "start_addr", start_addr );       
  status = uvm_config_db#(bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0])::get(null, get_full_name(), "end_addr", end_addr );       
  status = uvm_config_db#(bit)::get(null, get_full_name(), "use_directed_addr", use_directed_addr );       
  status = uvm_config_db#(bit)::get(null, get_full_name(), "generate_unique_txn_id", generate_unique_txn_id);       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readnosnp_wt",readnosnp_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readonce_wt",readonce_wt );        
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readclean_wt",readclean_wt );       
`ifdef SVT_CHI_ISSUE_E_ENABLE
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeevictorevict_wt",writeevictorevict_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpzero_wt",writenosnpzero_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniquezero_wt",writeuniquezero_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "makereadunique_wt",makereadunique_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readpreferunique_wt",readpreferunique_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpfull_cleanshared_wt",writenosnpfull_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpfull_cleansharedpersistsep_wt",writenosnpfull_cleansharedpersistsep_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniquefull_cleanshared_wt",writeuniquefull_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniquefull_cleansharedpersistsep_wt",writeuniquefull_cleansharedpersistsep_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniqueptl_cleanshared_wt",writeuniqueptl_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniqueptl_cleansharedpersistsep_wt",writeuniqueptl_cleansharedpersistsep_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpfull_cleaninvalid_wt",writenosnpfull_cleaninvalid_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpptl_cleaninvalid_wt",writenosnpptl_cleaninvalid_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpptl_cleanshared_wt",writenosnpptl_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpptl_cleansharedpersistsep_wt",writenosnpptl_cleansharedpersistsep_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writebackfull_cleanshared_wt",writebackfull_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writebackfull_cleansharedpersistsep_wt",writebackfull_cleansharedpersistsep_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writebackfull_cleaninvalid_wt",writebackfull_cleaninvalid_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writecleanfull_cleanshared_wt",writecleanfull_cleanshared_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writecleanfull_cleansharedpersistsep_wt",writecleanfull_cleansharedpersistsep_wt ); 
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "stashoncesepunique_wt",stashoncesepunique_wt);  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "stashoncesepshared_wt",stashoncesepshared_wt);  
`endif  
`ifdef SVT_CHI_ISSUE_D_ENABLE
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "cleansharedpersistsep_wt",cleansharedpersistsep_wt );
`endif
`ifdef SVT_CHI_ISSUE_B_ENABLE
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readspec_wt",readspec_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readnotshareddirty_wt",readnotshareddirty_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readoncecleaninvalid_wt",readoncecleaninvalid_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readoncemakeinvalid_wt",readoncemakeinvalid_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "cleansharedpersist_wt",cleansharedpersist_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_add_wt",atomicstore_add_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_clr_wt",atomicstore_clr_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_eor_wt",atomicstore_eor_wt );     
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_set_wt",atomicstore_set_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_smax_wt",atomicstore_smax_wt );   
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_smin_wt",atomicstore_smin_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_umax_wt",atomicstore_umax_wt ); 
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicstore_umin_wt",atomicstore_umin_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_add_wt",atomicload_add_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_clr_wt",atomicload_clr_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_eor_wt",atomicload_eor_wt );     
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_set_wt",atomicload_set_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_smax_wt",atomicload_smax_wt );   
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_smin_wt",atomicload_smin_wt );
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_umax_wt",atomicload_umax_wt ); 
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicload_umin_wt",atomicload_umin_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomicswap_wt",atomicswap_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "atomiccompare_wt",atomiccompare_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "prefetchtgt_wt",prefetchtgt_wt);  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniquefullstash_wt",writeuniquefullstash_wt);  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniqueptlstash_wt",writeuniqueptlstash_wt);  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "stashonceunique_wt",stashonceunique_wt);  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "stashonceshared_wt",stashonceshared_wt);  
`endif
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readshared_wt",readshared_wt );      
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "readunique_wt",readunique_wt );      
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "cleanunique_wt",cleanunique_wt );     
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "makeunique_wt",makeunique_wt );      
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writebackfull_wt",writebackfull_wt );   
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writebackptl_wt",writebackptl_wt );    
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeevictfull_wt",writeevictfull_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writecleanfull_wt",writecleanfull_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writecleanptl_wt",writecleanptl_wt );   
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "evict_wt",evict_wt );           
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpfull_wt",writenosnpfull_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writenosnpptl_wt",writenosnpptl_wt );   
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniquefull_wt",writeuniquefull_wt ); 
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "writeuniqueptl_wt",writeuniqueptl_wt );  
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "cleanshared_wt",cleanshared_wt );     
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "cleaninvalid_wt",cleaninvalid_wt );    
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "makeinvalid_wt",makeinvalid_wt );     
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "eobarrier_wt",eobarrier_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "ecbarrier_wt",ecbarrier_wt );       
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "dvmop_wt",dvmop_wt );           
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "pcrdreturn_wt",pcrdreturn_wt );      
  status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "reqlinkflit_wt",reqlinkflit_wt );
  status = uvm_config_db#(bit)::get(m_sequencer, get_full_name(), "bypass_silent_cache_line_state_transition",bypass_silent_cache_line_state_transition );        
  status = uvm_config_db#(bit)::get(m_sequencer, get_full_name(), "use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics",use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics );        
  status = uvm_config_db#(bit)::get(m_sequencer, get_full_name(), "use_seq_order_type",use_seq_order_type );        
  status = uvm_config_db#(bit)::get(null, get_full_name(), "rn_seq_use_addr_mode_from_test",rn_seq_use_addr_mode_from_test);        
  if(rn_seq_use_addr_mode_from_test)
    status = uvm_config_db#(addressing_mode_enum)::get(null, get_full_name(), "addr_mode",addr_mode);        

`elsif SVT_OVM_TECHNOLOGY
  status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length );       
  status = m_sequencer.get_config_int({get_type_name(), ".start_addr"}, start_addr );       
  status = m_sequencer.get_config_int({get_type_name(), ".end_addr"}, end_addr );       
  status = m_sequencer.get_config_int({get_type_name(), ".use_directed_addr"}, use_directed_addr );       
  status = m_sequencer.get_config_int({get_type_name(), ".generate_unique_txn_id"}, generate_unique_txn_id);       
  status = m_sequencer.get_config_int({get_type_name(), ".readnosnp_wt"},readnosnp_wt );       
  status = m_sequencer.get_config_int({get_type_name(), ".readonce_wt"},readonce_wt );          
  status = m_sequencer.get_config_int({get_type_name(), ".readclean_wt"},readclean_wt );         
`ifdef SVT_CHI_ISSUE_E_ENABLE
  status = m_sequencer.get_config_int({get_type_name(), ".writeevictorevict_wt"},writeevictorevict_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpzero_wt"},writenosnpzero_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniquezero_wt"},writeuniquezero_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".makereadunique_wt"},makereadunique_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".readpreferunique_wt"},readpreferunique_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpfull_cleanshared_wt"},writenosnpfull_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpfull_cleansharedpersistsep_wt"},writenosnpfull_cleansharedpersistsep_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniquefull_cleanshared_wt"},writeuniquefull_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniquefull_cleansharedpersistsep_wt"},writeuniquefull_cleansharedpersistsep_wt );  
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniqueptl_cleanshared_wt"},writeuniqueptl_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniqueptl_cleansharedpersistsep_wt"},writeuniqueptl_cleansharedpersistsep_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpfull_cleaninvalid_wt"},writenosnpfull_cleaninvalid_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpptl_cleaninvalid_wt"},writenosnpptl_cleaninvalid_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpptl_cleanshared_wt"},writenosnpptl_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpptl_cleansharedpersistsep_wt"},writenosnpptl_cleansharedpersistsep_wt );  
  status = m_sequencer.get_config_int({get_type_name(), ".writebackfull_cleanshared_wt"},writebackfull_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writebackfull_cleansharedpersistsep_wt"},writebackfull_cleansharedpersistsep_wt );  
  status = m_sequencer.get_config_int({get_type_name(), ".writebackfull_cleaninvalid_wt"},writebackfull_cleaninvalid_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writecleanfull_cleanshared_wt"},writecleanfull_cleanshared_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".writecleanfull_cleansharedpersistsep_wt"},writecleanfull_cleansharedpersistsep_wt );
  status = m_sequencer.get_config_int({get_type_name(), ".stashoncesepunique_wt"},stashoncesepunique_wt);         
  status = m_sequencer.get_config_int({get_type_name(), ".stashoncesepshared_wt"},stashoncesepshared_wt);  
`endif
`ifdef SVT_CHI_ISSUE_D_ENABLE
  status = m_sequencer.get_config_int({get_type_name(), ".cleansharedpersistsep_wt"},cleansharedpersistsep_wt );
`endif
`ifdef SVT_CHI_ISSUE_B_ENABLE
  status = m_sequencer.get_config_int({get_type_name(), ".readspec_wt"},readspec_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".readnotshareddirty_wt"},readnotshareddirty_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".readoncecleaninvalid_wt"},readoncecleaninvalid_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".readoncemakeinvalid_wt"},readoncemakeinvalid_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".cleansharedpersist_wt"},cleansharedpersist_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_add_wt"},atomicstore_add_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_clr_wt"},atomicstore_clr_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_eor_wt"},atomicstore_eor_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_set_wt"},atomicstore_set_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_smax_wt"},atomicstore_smax_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_smin_wt"},atomicstore_smin_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_umax_wt"},atomicstore_umax_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicstore_umin_wt"},atomicstore_umin_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_add_wt"},atomicload_add_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_clr_wt"},atomicload_clr_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_eor_wt"},atomicload_eor_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_set_wt"},atomicload_set_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_smax_wt"},atomicload_smax_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_smin_wt"},atomicload_smin_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_umax_wt"},atomicload_umax_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicload_umin_wt"},atomicload_umin_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomicswap_wt"},atomicswap_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".atomiccompare_wt"},atomiccompare_wt );         
  status = m_sequencer.get_config_int({get_type_name(), ".prefetchtgt_wt"},prefetchtgt_wt);         
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniquefullstash_wt"},writeuniquefullstash_wt);         
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniqueptlstash_wt"},writeuniqueptlstash_wt);         
  status = m_sequencer.get_config_int({get_type_name(), ".stashonceunique_wt"},stashonceunique_wt);         
  status = m_sequencer.get_config_int({get_type_name(), ".stashonceshared_wt"},stashonceshared_wt);         
`endif
  status = m_sequencer.get_config_int({get_type_name(), ".readshared_wt"},readshared_wt );        
  status = m_sequencer.get_config_int({get_type_name(), ".readunique_wt"},readunique_wt );        
  status = m_sequencer.get_config_int({get_type_name(), ".cleanunique_wt"},cleanunique_wt );       
  status = m_sequencer.get_config_int({get_type_name(), ".makeunique_wt"},makeunique_wt );        
  status = m_sequencer.get_config_int({get_type_name(), ".writebackfull_wt"},writebackfull_wt );     
  status = m_sequencer.get_config_int({get_type_name(), ".writebackptl_wt"},writebackptl_wt );      
  status = m_sequencer.get_config_int({get_type_name(), ".writeevictfull_wt"},writeevictfull_wt );    
  status = m_sequencer.get_config_int({get_type_name(), ".writecleanfull_wt"},writecleanfull_wt );    
  status = m_sequencer.get_config_int({get_type_name(), ".writecleanptl_wt"},writecleanptl_wt );     
  status = m_sequencer.get_config_int({get_type_name(), ".evict_wt"},evict_wt );             
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpfull_wt"},writenosnpfull_wt );    
  status = m_sequencer.get_config_int({get_type_name(), ".writenosnpptl_wt"},writenosnpptl_wt );     
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniquefull_wt"},writeuniquefull_wt );   
  status = m_sequencer.get_config_int({get_type_name(), ".writeuniqueptl_wt"},writeuniqueptl_wt );    
  status = m_sequencer.get_config_int({get_type_name(), ".cleanshared_wt"},cleanshared_wt );       
  status = m_sequencer.get_config_int({get_type_name(), ".cleaninvalid_wt"},cleaninvalid_wt );      
  status = m_sequencer.get_config_int({get_type_name(), ".makeinvalid_wt"},makeinvalid_wt );     
  status = m_sequencer.get_config_int({get_type_name(), ".eobarrier_wt"},eobarrier_wt );       
  status = m_sequencer.get_config_int({get_type_name(), ".ecbarrier_wt"},ecbarrier_wt );       
  status = m_sequencer.get_config_int({get_type_name(), ".dvmop_wt"},dvmop_wt );           
  status = m_sequencer.get_config_int({get_type_name(), ".pcrdreturn_wt"},pcrdreturn_wt );      
  status = m_sequencer.get_config_int({get_type_name(), ".reqlinkflit_wt"},reqlinkflit_wt );      
  status = m_sequencer.get_config_int({get_type_name(), ".bypass_silent_cache_line_state_transition"},bypass_silent_cache_line_state_transition );      
  status = m_sequencer.get_config_int({get_type_name(), ".use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics"},use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics );      
  status = m_sequencer.get_config_int({get_type_name(), ".use_seq_order_type"},use_seq_order_type );      
`endif
endtask // pre_body

//------------------------------------------------------------------------------
task svt_chi_rn_coherent_transaction_base_sequence::body();
  super.body();
  generate_transactions();
endtask
    
//------------------------------------------------------------------------------
// Generates transactions based on sequence_length: 
// If use_directed_addr is set, the directed address is fetched from the
// direct_addr_mailbox. 
// A callback, pre_rn_f_base_seq_item_randomize is issued where a user can
// potentially provide a transaction. If the callback returns with a valid
// transaction, it is sent out. Otherwise a transaction is randomized and sent
// out.
// If the initialize_cachelines property is set, an event is triggered in the parent
// sequence so that the cachelines get initialized. Note that this needs to be
// done in a parent (virtual) sequence because initialization of cachelines
// involve multiple master sequencers. Once initialization is done the
// transaction is sent out 
task svt_chi_rn_coherent_transaction_base_sequence::generate_transactions();
  addr_t                  directed_addr;
  bit                     rand_success;
  svt_chi_rn_transaction  rn_xacts[$];

  `svt_xvm_debug("generate_transactions",$psprintf("Entering generate_transactions() task - sequence_length - %d", sequence_length));

  // Used to sink the responses from the response queue.
  sink_responses();
  if(initialize_cachelines == 0) begin
    initialize_cachelines_done = 1; 
  end 
  
  for(int i =0; i < sequence_length; i++) begin
    svt_chi_rn_transaction           rn_xact,atomic_rn_req, atomic_auto_read_req;
    bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr,rand_addr;
    bit                              is_error,randomize_with_directed_addr;
    bit                              directed_snp_attr_is_snoopable;
    svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type;
    bit                              directed_mem_attr_allocate_hint;
    bit                              directed_is_non_secure_access;
    bit                              directed_allocate_in_cache;
    svt_chi_common_transaction::data_size_enum directed_data_size; 
    bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data; 
    bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable; 

    if(use_directed_addr) begin
      `svt_xvm_debug("generate_transactions",$psprintf("Getting directed address for sequence %0s",this.get_full_name()));
      get_directed_addr((i+1),is_error,randomize_with_directed_addr,directed_addr,directed_snp_attr_is_snoopable, directed_snp_attr_snp_domain_type,directed_mem_attr_allocate_hint,directed_is_non_secure_access, directed_allocate_in_cache,directed_data_size, directed_data, directed_byte_enable);
      if (is_error)
        break;
    end

    //Callback
    pre_rn_f_base_seq_item_randomize(randomize_with_directed_addr, directed_addr, rn_xact);
    
    if(rn_xact == null) begin
`protected
H]1+E75QI>bSQ)G?aGKRe<@P_\EdU8[)Q.e4,aa7Y-@+E=PeUR2I7)0B)0PfgYd>
?4XRBC=7=)\S*$
`endprotected
 
      `svt_xvm_create_on(rn_xact, p_sequencer);
      `svt_debug("generate_transactions",$psprintf("rn_xact inst_id - %d (previous addr=0x%0x)", rn_xact.get_inst_id(), _previous_xact_addr));
      randomize_xact(rn_xact,randomize_with_directed_addr,directed_addr,directed_snp_attr_is_snoopable, directed_snp_attr_snp_domain_type, directed_mem_attr_allocate_hint, directed_is_non_secure_access,directed_allocate_in_cache, directed_data_size, directed_data, directed_byte_enable, rand_success, i,generate_unique_txn_id);
      ///** Poison **/
      //if(`SVT_CHI_POISON_INTERNAL_WIDTH_ENABLE == 1 && 
      //    node_cfg.poison_enable == 1
      //  )begin
      //  if(program_poison_to_zero_cache_initialization)
      //    rn_xact.poison = 'h0;
      //end 
    end
    else begin
      rand_success = 1;
    end

    if (!rand_success) begin
      `svt_xvm_error("generate_transactions","Randomization failure!!");
    end
    else begin
      `svt_xvm_debug("generate_transactions",$psprintf("Generated transaction %0d: %0s", i, `SVT_CHI_PRINT_PREFIX1(rn_xact)));

      if(initialize_cachelines) begin
        initialize_cache(rn_xact);
        rn_xacts.push_back(rn_xact);        
        foreach(rn_xacts[i])begin
          `svt_xvm_debug("generate_transactions", $sformatf("rn_xacts[%d].addr=%0h is %0s", i,rn_xacts[i].addr,rn_xacts[i].sprint()));
        end
      end
      else begin
        `svt_xvm_send(rn_xact);
        output_xact_mailbox.put(rn_xact);
        output_xacts.push_back(rn_xact);
        active_xacts.push_back(rn_xact);
        active_rn_xacts.push_back(rn_xact);
        if(blocking_mode) wait_for_active_xacts_to_end();

      end // else: !if(initialize_cachelines)
    end // else: !if(!rand_success)
  end // for (int i =0; j < sequence_length; i++)

  if(initialize_cachelines == 1) begin
    initialize_cachelines_done = 1; 
  end

  if(initialize_cachelines) begin

`ifdef SVT_CHI_ISSUE_B_ENABLE
    if(seq_atomic_compare_data_same_as_mem_data)begin
      foreach(rn_xacts[i])begin
        if(rn_xacts[i].xact_type == svt_chi_common_transaction::ATOMICCOMPARE)begin 
          logic [`SVT_CHI_MAX_DATA_WIDTH-1:0] temp_data;
          int a = 0;
          int start_idx;
          svt_chi_rn_transaction temp_local_rn_xact;

          if(rn_cacheline_ini_xacts.size()>0)begin
            temp_local_rn_xact = rn_cacheline_ini_xacts.pop_back();
            temp_data = temp_local_rn_xact.data;
          end

          rn_xacts[i].atomic_compare_data = 0;
          start_idx = rn_xacts[i].addr[5:0];

          for(int j = start_idx; j < (start_idx + rn_xacts[i].get_atomic_transaction_inbound_data_size_in_bytes()); j++) begin
            rn_xacts[i].atomic_compare_data[a*8+:8] = temp_data[j*8+:8];
            a++;
          end
          `svt_xvm_debug("generate_transactions",$sformatf("seq_atomic_compare_data_same_as_mem_data is programmed to 1 for the Transaction %0s hence the atomic_compare_data is programmed to %0h",`SVT_CHI_PRINT_PREFIX(rn_xacts[i]),rn_xacts[i].atomic_compare_data));
        end
      end//foreach(rn_xacts[i])
    end//if(seq_atomic_compare_data_same_as_mem_data)begin
`endif // `ifdef SVT_CHI_ISSUE_B_ENABLE

    foreach (rn_xacts[i]) begin
      `svt_xvm_send(rn_xacts[i]);
      output_xact_mailbox.put(rn_xacts[i]);
      output_xacts.push_back(rn_xacts[i]);
      active_xacts.push_back(rn_xacts[i]);
      active_rn_xacts.push_back(rn_xacts[i]);
      if(blocking_mode) wait_for_active_xacts_to_end();
    end
`ifdef SVT_CHI_ISSUE_B_ENABLE
    if(rn_cacheline_ini_xacts.size()>0)begin
      rn_cacheline_ini_xacts.delete();
    end
`endif
  end
  `svt_xvm_debug("generate_transactions","Exiting generate_transactions() task");
  
endtask // generate_transactions

//------------------------------------------------------------------------------
// Waits until all transactions in active_xacts queue have ended 
task svt_chi_rn_coherent_transaction_base_sequence::wait_for_active_xacts_to_end();
  `svt_debug("wait_for_active_xacts_to_end","Waiting for active transaction to end");
  foreach(active_xacts[i]) begin
    active_xacts[i].wait_end();
      if (active_xacts[i].req_status == svt_chi_transaction::RETRY) begin
        if (active_xacts[i].p_crd_return_on_retry_ack == 0) begin
          `svt_xvm_debug("svt_chi_rn_coherent_transaction_base_sequence", $sformatf({`SVT_CHI_PRINT_PREFIX(active_xacts[i]), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
          wait (active_xacts[i].req_status == svt_chi_transaction::ACTIVE);
        end
        else begin
          `svt_xvm_debug("svt_chi_rn_coherent_transaction_base_sequence", $sformatf({`SVT_CHI_PRINT_PREFIX(active_xacts[i]), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
        end
      end
    active_xacts[i].wait_end();
  end
  `svt_debug("wait_for_active_xacts_to_end","All active transaction ended");
endtask

// -----------------------------------------------------------------------------
// Used to sink the responses from the response queue. 
task svt_chi_rn_coherent_transaction_base_sequence::sink_responses();
  svt_chi_rn_transaction rsp;
  fork
  begin
    forever begin
      get_response(rsp);
    end
  end
  join_none
endtask

// -----------------------------------------------------------------------------
// Initialize cacheline for initiating RN-F node and peer RN-F nodes, such that the 
// cache line state in initiating node is valid to send out the coherent transaction.
task svt_chi_rn_coherent_transaction_base_sequence::initialize_cache(svt_chi_rn_transaction xact);
  `SVT_XVM(object) base_obj;
  /** Parent sequence of this sequence */
  svt_chi_system_rn_coherent_transaction_base_virtual_sequence parent_sequence;
  /** Cacheline initialization sequence */
  svt_chi_system_cacheline_initialization_virtual_sequence cacheline_init_seq; 
  
  base_obj = this.get_parent_sequence();
  if ((base_obj == null) || (!($cast(parent_sequence,base_obj)))) begin
    `svt_xvm_fatal("initialize_cache",$psprintf("Sequence from which this sequence (%0s) is called (that is parent sequence) should be of a type derived from svt_chi_system_rn_coherent_transaction_base_virtual_sequence for performing cacheline initialization",this.get_full_name));
  end
  parent_sequence.cacheline_init_sema.get();
  `svt_xvm_create_on(cacheline_init_seq, parent_sequence.get_sequencer());
  `svt_xvm_debug("body", $psprintf("bypass_silent_cache_line_state_transition value is %b in svt_chi_rn_coherent_transaction_base_sequence",bypass_silent_cache_line_state_transition));
  void'(cacheline_init_seq.randomize());
  cacheline_init_seq.bypass_silent_cache_line_state_transition = this.bypass_silent_cache_line_state_transition;
  cacheline_init_seq.rn_xact = xact;
  cacheline_init_seq.force_cache_initialization = this.force_cache_initialization;
  cacheline_init_seq.bypass_cacheinit_sd_wrclean_rdshared = this.bypass_cacheinit_sd_wrclean_rdshared;
`ifdef SVT_CHI_ISSUE_B_ENABLE  
  cacheline_init_seq.perform_cacheinit_for_non_coherent_xacts = perform_cacheinit_for_non_coherent_xacts;
  /** Poison **/
  if(`SVT_CHI_POISON_INTERNAL_WIDTH_ENABLE == 1 && 
      node_cfg.poison_enable == 1
    )begin
    cacheline_init_seq.program_poison_to_zero_cache_initialization = 1;
  end  
`endif  
  cacheline_init_seq.start(parent_sequence.get_sequencer());
`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** Copying the transactions used for cache_initialisation 
   *  to rn transactions base sequence
   */
  rn_cacheline_ini_xacts = cacheline_init_seq.cacheline_ini_xacts;
  foreach(rn_cacheline_ini_xacts[i])begin
    `svt_xvm_verbose("initialize_cache", $sformatf("rn_cacheline_ini_xacts[%d].addr=%0h data = %0h is %0s", i,rn_cacheline_ini_xacts[i].addr,rn_cacheline_ini_xacts[i].data,rn_cacheline_ini_xacts[i].sprint()));
  end 
`endif
  parent_sequence.cacheline_init_sema.put();
endtask // initialize_cache

// -----------------------------------------------------------------------------
// Assigns a weight of 1 for the transaction type given in rn_xact_type   
function void svt_chi_rn_coherent_transaction_base_sequence::assign_xact_weights(svt_chi_common_transaction::xact_type_enum rn_xact_type);
  case(rn_xact_type)
    svt_chi_common_transaction::READNOSNP       : readnosnp_wt       = 1;       
    svt_chi_common_transaction::READONCE        : readonce_wt        = 1;        
    svt_chi_common_transaction::READCLEAN       : readclean_wt       = 1;       
`ifdef SVT_CHI_ISSUE_E_ENABLE
    svt_chi_common_transaction::WRITEEVICTOREVICT    : writeevictorevict_wt  = 1;       
    svt_chi_common_transaction::WRITENOSNPZERO  : writenosnpzero_wt  = 1;       
    svt_chi_common_transaction::WRITEUNIQUEZERO : writeuniquezero_wt = 1;       
    svt_chi_common_transaction::MAKEREADUNIQUE  : makereadunique_wt = 1;       
    svt_chi_common_transaction::READPREFERUNIQUE  : readpreferunique_wt = 1;
    svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHARED : writenosnpfull_cleanshared_wt =1;
    svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP : writenosnpfull_cleansharedpersistsep_wt =1;
    svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHARED : writeuniquefull_cleanshared_wt =1;
    svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP : writeuniquefull_cleansharedpersistsep_wt =1;
    svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHARED : writeuniqueptl_cleanshared_wt =1;
    svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP : writeuniqueptl_cleansharedpersistsep_wt =1;
    svt_chi_common_transaction::WRITENOSNPFULL_CLEANINVALID : writenosnpfull_cleaninvalid_wt =1;
    svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHARED : writenosnpptl_cleanshared_wt =1;
    svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP : writenosnpptl_cleansharedpersistsep_wt =1;    
    svt_chi_common_transaction::WRITENOSNPPTL_CLEANINVALID : writenosnpptl_cleaninvalid_wt =1;
    svt_chi_common_transaction::WRITEBACKFULL_CLEANSHARED : writebackfull_cleanshared_wt =1;
    svt_chi_common_transaction::WRITEBACKFULL_CLEANSHAREDPERSISTSEP : writebackfull_cleansharedpersistsep_wt =1;    
    svt_chi_common_transaction::WRITEBACKFULL_CLEANINVALID : writebackfull_cleaninvalid_wt =1;
    svt_chi_common_transaction::WRITECLEANFULL_CLEANSHARED : writecleanfull_cleanshared_wt =1;
    svt_chi_common_transaction::WRITECLEANFULL_CLEANSHAREDPERSISTSEP : writecleanfull_cleansharedpersistsep_wt =1;
    svt_chi_common_transaction::STASHONCESEPUNIQUE      : stashoncesepunique_wt= 1;       
    svt_chi_common_transaction::STASHONCESEPSHARED      : stashoncesepshared_wt= 1;       
`endif
`ifdef SVT_CHI_ISSUE_D_ENABLE
    svt_chi_common_transaction::CLEANSHAREDPERSISTSEP : cleansharedpersistsep_wt =1;
`endif
`ifdef SVT_CHI_ISSUE_B_ENABLE
    svt_chi_common_transaction::READSPEC             : readspec_wt        = 1;       
    svt_chi_common_transaction::READNOTSHAREDDIRTY   : readnotshareddirty_wt = 1;       
    svt_chi_common_transaction::READONCECLEANINVALID : readoncecleaninvalid_wt = 1;       
    svt_chi_common_transaction::READONCEMAKEINVALID  : readoncemakeinvalid_wt = 1;       
    svt_chi_common_transaction::CLEANSHAREDPERSIST   : cleansharedpersist_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_ADD      : atomicstore_add_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_CLR      : atomicstore_clr_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_EOR      : atomicstore_eor_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_SET      : atomicstore_set_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_SMAX     : atomicstore_smax_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_SMIN     : atomicstore_smin_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_UMAX     : atomicstore_umax_wt = 1;       
    svt_chi_common_transaction::ATOMICSTORE_UMIN     : atomicstore_umin_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_ADD       : atomicload_add_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_CLR       : atomicload_clr_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_EOR       : atomicload_eor_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_SET       : atomicload_set_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_SMAX      : atomicload_smax_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_SMIN      : atomicload_smin_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_UMAX      : atomicload_umax_wt = 1;       
    svt_chi_common_transaction::ATOMICLOAD_UMIN      : atomicload_umin_wt = 1;       
    svt_chi_common_transaction::ATOMICSWAP           : atomicswap_wt = 1;       
    svt_chi_common_transaction::ATOMICCOMPARE        : atomiccompare_wt = 1;       
    svt_chi_common_transaction::PREFETCHTGT          : prefetchtgt_wt= 1;       
    svt_chi_common_transaction::WRITEUNIQUEFULLSTASH : writeuniquefullstash_wt= 1;       
    svt_chi_common_transaction::WRITEUNIQUEPTLSTASH  : writeuniqueptlstash_wt= 1;       
    svt_chi_common_transaction::STASHONCEUNIQUE      : stashonceunique_wt= 1;       
    svt_chi_common_transaction::STASHONCESHARED      : stashonceshared_wt= 1;       
`endif    
    svt_chi_common_transaction::READSHARED      : readshared_wt      = 1;      
    svt_chi_common_transaction::READUNIQUE      : readunique_wt      = 1;      
    svt_chi_common_transaction::CLEANUNIQUE     : cleanunique_wt     = 1;     
    svt_chi_common_transaction::MAKEUNIQUE      : makeunique_wt      = 1;      
    svt_chi_common_transaction::WRITEBACKFULL   : writebackfull_wt   = 1;   
    svt_chi_common_transaction::WRITEBACKPTL    : writebackptl_wt    = 1;    
    svt_chi_common_transaction::WRITEEVICTFULL  : writeevictfull_wt  = 1;  
    svt_chi_common_transaction::WRITECLEANFULL  : writecleanfull_wt  = 1;  
    svt_chi_common_transaction::WRITECLEANPTL   : writecleanptl_wt   = 1;   
    svt_chi_common_transaction::EVICT           : evict_wt           = 1;           
    svt_chi_common_transaction::WRITENOSNPFULL  : writenosnpfull_wt  = 1;  
    svt_chi_common_transaction::WRITENOSNPPTL   : writenosnpptl_wt   = 1;   
    svt_chi_common_transaction::WRITEUNIQUEFULL : writeuniquefull_wt = 1; 
    svt_chi_common_transaction::WRITEUNIQUEPTL  : writeuniqueptl_wt  = 1;  
    svt_chi_common_transaction::CLEANSHARED     : cleanshared_wt     = 1;     
    svt_chi_common_transaction::CLEANINVALID    : cleaninvalid_wt    = 1;    
    svt_chi_common_transaction::MAKEINVALID     : makeinvalid_wt     = 1;     
    svt_chi_common_transaction::EOBARRIER       : eobarrier_wt       = 1;       
    svt_chi_common_transaction::ECBARRIER       : ecbarrier_wt       = 1;       
    svt_chi_common_transaction::DVMOP           : dvmop_wt           = 1;           
    svt_chi_common_transaction::PCRDRETURN      : pcrdreturn_wt      = 1;      
    svt_chi_common_transaction::REQLINKFLIT     : reqlinkflit_wt     = 1;
  endcase // case (rn_xact_type)
endfunction // assign_xact_weights

//------------------------------------------------------------------------------
// Sets the weights of all transaction types to 0
function void svt_chi_rn_coherent_transaction_base_sequence::disable_all_weights();
    readnosnp_wt       = 0;       
    readonce_wt        = 0;        
    readclean_wt       = 0;       
`ifdef SVT_CHI_ISSUE_E_ENABLE
    writeevictorevict_wt  = 0;       
    writenosnpzero_wt  = 0;       
    writeuniquezero_wt = 0;       
    makereadunique_wt = 0;       
    readpreferunique_wt = 0;
    writenosnpfull_cleanshared_wt =0;
    writenosnpfull_cleansharedpersistsep_wt =0;
    writeuniquefull_cleanshared_wt =0;
    writeuniquefull_cleansharedpersistsep_wt =0;
    writeuniqueptl_cleanshared_wt =0;
    writeuniqueptl_cleansharedpersistsep_wt =0;
    writenosnpfull_cleaninvalid_wt =0;
    writenosnpptl_cleanshared_wt =0;
    writenosnpptl_cleansharedpersistsep_wt =0;    
    writenosnpptl_cleaninvalid_wt =0;
    writebackfull_cleaninvalid_wt =0;
    writebackfull_cleanshared_wt =0;
    writebackfull_cleansharedpersistsep_wt =0;  
    writecleanfull_cleanshared_wt =0;
    writecleanfull_cleansharedpersistsep_wt =0; 
    stashoncesepunique_wt = 0;       
    stashoncesepshared_wt = 0;       
`endif
`ifdef SVT_CHI_ISSUE_D_ENABLE
    cleansharedpersistsep_wt =0;
`endif
`ifdef SVT_CHI_ISSUE_B_ENABLE
    readspec_wt        = 0;       
    readnotshareddirty_wt = 0;       
    readoncecleaninvalid_wt = 0;       
    readoncemakeinvalid_wt = 0;       
    cleansharedpersist_wt = 0;       
    atomicstore_add_wt = 0;       
    atomicstore_clr_wt = 0;       
    atomicstore_eor_wt = 0;       
    atomicstore_set_wt = 0;       
    atomicstore_smax_wt = 0;       
    atomicstore_smin_wt = 0;       
    atomicstore_umax_wt = 0;       
    atomicstore_umin_wt = 0;       
    atomicload_add_wt = 0;       
    atomicload_clr_wt = 0;       
    atomicload_eor_wt = 0;       
    atomicload_set_wt = 0;       
    atomicload_smax_wt = 0;       
    atomicload_smin_wt = 0;       
    atomicload_umax_wt = 0;       
    atomicload_umin_wt = 0;       
    atomicswap_wt = 0;       
    atomiccompare_wt = 0;       
    prefetchtgt_wt = 0;       
    writeuniquefullstash_wt = 0;       
    writeuniqueptlstash_wt = 0;       
    stashonceunique_wt = 0;       
    stashonceshared_wt = 0;       
`endif
    readshared_wt      = 0;      
    readunique_wt      = 0;      
    cleanunique_wt     = 0;     
    makeunique_wt      = 0;      
    writebackfull_wt   = 0;   
    writebackptl_wt    = 0;    
    writeevictfull_wt  = 0;  
    writecleanfull_wt  = 0;  
    writecleanptl_wt   = 0;   
    evict_wt           = 0;           
    writenosnpfull_wt  = 0;  
    writenosnpptl_wt   = 0;   
    writeuniquefull_wt = 0; 
    writeuniqueptl_wt  = 0;  
    cleanshared_wt     = 0;     
    cleaninvalid_wt    = 0;    
    makeinvalid_wt     = 0;     
    eobarrier_wt       = 0;       
    ecbarrier_wt       = 0;       
    dvmop_wt           = 0;           
    pcrdreturn_wt      = 0;      
    reqlinkflit_wt     = 0;
endfunction // disable_all_weights

//------------------------------------------------------------------------------
// Sets the weights of all transaction types to 1
function void svt_chi_rn_coherent_transaction_base_sequence::enable_all_weights();
    readnosnp_wt       = 1;       
    readonce_wt        = 1;        
    readclean_wt       = 1;       
`ifdef SVT_CHI_ISSUE_E_ENABLE
    writeevictorevict_wt  = 1;       
    writenosnpzero_wt  = 1;       
    writeuniquezero_wt = 1;       
    makereadunique_wt = 1;       
    readpreferunique_wt = 1;
    writenosnpfull_cleanshared_wt =1;
    writenosnpfull_cleansharedpersistsep_wt =1;
    writeuniquefull_cleanshared_wt =1;
    writeuniquefull_cleansharedpersistsep_wt =1;
    writeuniqueptl_cleanshared_wt =1;
    writeuniqueptl_cleansharedpersistsep_wt =1;
    writenosnpfull_cleaninvalid_wt =1;
    writenosnpptl_cleanshared_wt =1;
    writenosnpptl_cleansharedpersistsep_wt =1;
    writenosnpptl_cleaninvalid_wt =1;
    writebackfull_cleanshared_wt =1;
    writebackfull_cleansharedpersistsep_wt =1;    
    writebackfull_cleaninvalid_wt =1;
    writecleanfull_cleanshared_wt =1;
    writecleanfull_cleansharedpersistsep_wt =1;
    stashoncesepunique_wt = 1;       
    stashoncesepshared_wt = 1;
`endif
`ifdef SVT_CHI_ISSUE_D_ENABLE
    cleansharedpersistsep_wt =1;
`endif

`ifdef SVT_CHI_ISSUE_B_ENABLE
    readspec_wt        = 1;       
    readnotshareddirty_wt = 1;       
    readoncecleaninvalid_wt = 1;       
    readoncemakeinvalid_wt = 1;       
    cleansharedpersist_wt = 1;       
    atomicstore_add_wt = 1;       
    atomicstore_clr_wt = 1;       
    atomicstore_eor_wt = 1;       
    atomicstore_set_wt = 1;       
    atomicstore_smax_wt = 1;       
    atomicstore_smin_wt = 1;       
    atomicstore_umax_wt = 1;       
    atomicstore_umin_wt = 1;       
    atomicload_add_wt = 1;       
    atomicload_clr_wt = 1;       
    atomicload_eor_wt = 1;       
    atomicload_set_wt = 1;       
    atomicload_smax_wt = 1;       
    atomicload_smin_wt = 1;       
    atomicload_umax_wt = 1;       
    atomicload_umin_wt = 1;       
    atomicswap_wt = 1;       
    atomiccompare_wt = 1;       
    prefetchtgt_wt = 1;       
    writeuniquefullstash_wt = 1;       
    writeuniqueptlstash_wt = 1;       
    stashonceunique_wt = 1;       
    stashonceshared_wt = 1;       
`endif
    readshared_wt      = 1;      
    readunique_wt      = 1;      
    cleanunique_wt     = 1;     
    makeunique_wt      = 1;      
    writebackfull_wt   = 1;   
    writebackptl_wt    = 1;    
    writeevictfull_wt  = 1;  
    writecleanfull_wt  = 1;  
    writecleanptl_wt   = 1;   
    evict_wt           = 1;           
    writenosnpfull_wt  = 1;  
    writenosnpptl_wt   = 1;   
    writeuniquefull_wt = 1; 
    writeuniqueptl_wt  = 1;  
    cleanshared_wt     = 1;     
    cleaninvalid_wt    = 1;    
    makeinvalid_wt     = 1;     
    eobarrier_wt       = 1;       
    ecbarrier_wt       = 1;       
    dvmop_wt           = 1;           
    pcrdreturn_wt      = 1;      
    reqlinkflit_wt     = 1;
endfunction // enable_all_weights

//------------------------------------------------------------------------------
// Gets addresses from directed_addr_mailbox. If an address is not already
// available, this task waits for direct_addr_timeout before timing out.
// Once the address is received, we check if it is feasible to send out a
// transaction with that address based on the weights of transaction types
// and the corresponding domain type for that address mentioned in the system
// configuration
// 
task svt_chi_rn_coherent_transaction_base_sequence::get_directed_addr(
                                                         int                                      xact_num,
                                                         output bit                               is_error,
                                                         output bit                               randomize_with_directed_addr, 
                                                         output bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr, 
                                                         output bit                               directed_snp_attr_is_snoopable, 
                                                         output svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                                                         output bit                               directed_mem_attr_allocate_hint,
                                                         output bit                               directed_is_non_secure_access,
                                                         output bit                               directed_allocate_in_cache,
                                                         output svt_chi_common_transaction::data_size_enum directed_data_size,
                                                         output bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                                                         output bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable
                                                         );
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0]                                                               _directed_addr;
  bit                                                                                             _directed_snp_attr_is_snoopable;
  svt_chi_common_transaction::snp_attr_snp_domain_type_enum                                       _directed_snp_attr_snp_domain_type;
  bit                                                                                             _directed_mem_attr_allocate_hint;
  bit                                                                                             _directed_is_non_secure_access;
  bit                                                                                             _directed_allocate_in_cache;
  svt_chi_common_transaction::data_size_enum                                                      _directed_data_size; 
  bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0]                                                             _directed_data;
  bit [(`SVT_CHI_MAX_BE_WIDTH-1):0]                                                               _directed_byte_enable;
  is_error = 0;
  randomize_with_directed_addr = 0;
  directed_addr = 0;
  `svt_debug("get_directed_addr", $sformatf("Displaying Values of attributes :- use_directed_snp_attr %0d use_directed_mem_attr %0d use_directed_non_secure_access %0d use_directed_allocate_in_cache %0b use_directed_data_size %0d use_directed_data %0d use_directed_byte_enable %0d",use_directed_snp_attr,use_directed_mem_attr,use_directed_non_secure_access,use_directed_allocate_in_cache,use_directed_data_size,use_directed_data,use_directed_byte_enable));
  fork
    begin
      fork
        begin
          directed_addr_mailbox.get(_directed_addr);
          if(use_directed_snp_attr == 1) begin
            directed_snp_attr_is_snoopable_mailbox.get(_directed_snp_attr_is_snoopable);
            `ifndef SVT_CHI_ISSUE_B_ENABLE
              directed_snp_attr_snp_domain_type_mailbox.get(_directed_snp_attr_snp_domain_type);
            `endif
          end
          if(use_directed_mem_attr == 1) begin
            directed_mem_attr_allocate_hint_mailbox.get(_directed_mem_attr_allocate_hint);
          end
          if(use_directed_non_secure_access == 1) begin
            directed_is_non_secure_access_mailbox.get(_directed_is_non_secure_access);
          end
          if(use_directed_allocate_in_cache ==1)begin
            directed_allocate_in_cache_mailbox.get(_directed_allocate_in_cache);
          end
          if(use_directed_data_size == 1) begin
            directed_data_size_mailbox.get(_directed_data_size);
          end
          if(use_directed_data == 1) begin
            directed_data_mailbox.get(_directed_data);
          end
          if(use_directed_byte_enable == 1) begin
            directed_byte_enable_mailbox.get(_directed_byte_enable);
          end
        end
        begin
          string error_string;
          #direct_addr_timeout;     
          error_string = $psprintf("Sequence %0s timed out waiting for a directed address to which a transaction should be generated.\n",this.get_full_name());
          error_string = {error_string, "Directed addresses should be provided in directed_addr_mailbox.\n"};
          error_string = {error_string,$psprintf("Currently received %0d directed addresses. Number of transaction to be generated(sequence_length) = %0d.\n", xact_num,sequence_length)};
          `svt_xvm_error("generate_transactions",$psprintf("%0s",error_string)); 
          is_error = 1;
        end
      join_any
      disable fork;
    end
  join
  
  if(!is_error) begin
    randomize_with_directed_addr = 1;
    directed_addr = _directed_addr;
    directed_snp_attr_is_snoopable = _directed_snp_attr_is_snoopable;
    `ifndef SVT_CHI_ISSUE_B_ENABLE
      directed_snp_attr_snp_domain_type = _directed_snp_attr_snp_domain_type;
    `endif
    directed_mem_attr_allocate_hint = _directed_mem_attr_allocate_hint;
    directed_is_non_secure_access = _directed_is_non_secure_access;
    directed_allocate_in_cache = _directed_allocate_in_cache;
    directed_data_size = _directed_data_size; 
    directed_data = _directed_data; 
    directed_byte_enable = _directed_byte_enable; 

`protected
;?+cPK[&gaHKYHfDBW&B<OdHUE&O^@[W/Zc?7XT;,.B(A\R^]B;7&)7-4Ee/4_K&
60JU>WeW1HB95?2><>;Z\1dH3$
`endprotected
 
  end
endtask 

// Task that derived classes can override. Called just before an
// item is sent. If derived class implementation passes master_xact as non-null,
// that item is sent.
task svt_chi_rn_coherent_transaction_base_sequence::pre_rn_f_base_seq_item_randomize(bit is_valid_addr, bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] my_addr, output svt_chi_rn_transaction rn_xact);
  rn_xact = null;
endtask


/** Randomizes a single transaction based on the weights assigned.  If
 * randomized_with_directed_addr is set, the transaction is randomized with
 * the address specified in directed_addr
 */
task svt_chi_rn_coherent_transaction_base_sequence::randomize_xact(svt_chi_rn_transaction           rn_xact,
                                                                   bit                              randomize_with_directed_addr, 
                                                                   bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr,
                                                                   bit                              directed_snp_attr_is_snoopable,
                                                                   svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                                                                   bit                              directed_mem_attr_allocate_hint,
                                                                   bit                              directed_is_non_secure_access,
                                                                   bit                              directed_allocate_in_cache,
                                                                   svt_chi_common_transaction::data_size_enum directed_data_size, 
                                                                   bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                                                                   bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable,
                                                                   output bit                       req_success,
                                                                   input  int                       sequence_index = 0,
                                                                   input  bit                       gen_uniq_txn_id = 0);
  bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] _end_addr_for_sequential_addr_mode = 0;
  
  // Get config from corresponding sequencer and assign it here.
  rn_xact.cfg      = node_cfg;

`ifdef SVT_CHI_ISSUE_E_ENABLE
  `svt_debug("randomize_xact",$psprintf("writeevictorevict_wt   = %d",writeevictorevict_wt  ));       
  `svt_debug("randomize_xact",$psprintf("writenosnpzero_wt   = %d",writenosnpzero_wt  ));       
  `svt_debug("randomize_xact",$psprintf("writeuniquezero_wt  = %d",writeuniquezero_wt ));       
  `svt_debug("randomize_xact",$psprintf("makereadunique_wt  = %d",makereadunique_wt ));       
  `svt_debug("randomize_xact",$psprintf("readpreferunique_wt  = %d",readpreferunique_wt ));
  `svt_debug("randomize_xact",$psprintf("writenosnpfull_cleanshared_wt  = %d",writenosnpfull_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writenosnpfull_cleansharedpersistsep_wt  = %d",writenosnpfull_cleansharedpersistsep_wt ));
  `svt_debug("randomize_xact",$psprintf("writeuniquefull_cleanshared_wt  = %d",writeuniquefull_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writeuniquefull_cleansharedpersistsep_wt  = %d",writeuniquefull_cleansharedpersistsep_wt ));
  `svt_debug("randomize_xact",$psprintf("writeuniqueptl_cleanshared_wt  = %d",writeuniqueptl_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writeuniqueptl_cleansharedpersistsep_wt  = %d",writeuniqueptl_cleansharedpersistsep_wt ));  
  `svt_debug("randomize_xact",$psprintf("writenosnpfull_cleaninvalid_wt  = %d",writenosnpfull_cleaninvalid_wt ));
  `svt_debug("randomize_xact",$psprintf("writenosnpptl_cleanshared_wt  = %d",writenosnpptl_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writenosnpptl_cleansharedpersistsep_wt  = %d",writenosnpptl_cleansharedpersistsep_wt ));  
  `svt_debug("randomize_xact",$psprintf("writenosnpptl_cleaninvalid_wt  = %d",writenosnpptl_cleaninvalid_wt ));
  `svt_debug("randomize_xact",$psprintf("writebackfull_cleaninvalid_wt  = %d",writebackfull_cleaninvalid_wt ));
  `svt_debug("randomize_xact",$psprintf("writebackfull_cleanshared_wt  = %d",writebackfull_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writebackfull_cleansharedpersistsep_wt  = %d",writebackfull_cleansharedpersistsep_wt )); 
  `svt_debug("randomize_xact",$psprintf("writcleanfull_cleanshared_wt  = %d",writecleanfull_cleanshared_wt ));
  `svt_debug("randomize_xact",$psprintf("writcleanfull_cleansharedpersistsep_wt  = %d",writecleanfull_cleansharedpersistsep_wt ));
  `svt_debug("randomize_xact",$psprintf("stashoncesepunique_wt        = %d",stashoncesepunique_wt      ));       
  `svt_debug("randomize_xact",$psprintf("stashoncesepshared_wt        = %d",stashoncesepshared_wt      ));       
`endif
`ifdef SVT_CHI_ISSUE_D_ENABLE
  `svt_debug("randomize_xact",$psprintf("cleansharedpersistsep_wt  = %d",cleansharedpersistsep_wt ));
`endif
  `svt_debug("randomize_xact",$psprintf("readnosnp_wt        = %d",readnosnp_wt       ));       
  `svt_debug("randomize_xact",$psprintf("readonce_wt         = %d",readonce_wt        ));        
  `svt_debug("randomize_xact",$psprintf("readclean_wt        = %d",readclean_wt       ));       
  `svt_debug("randomize_xact",$psprintf("gen_uniq_txn_id     = %d",gen_uniq_txn_id    ));       
`ifdef SVT_CHI_ISSUE_B_ENABLE
  `svt_debug("randomize_xact",$psprintf("readspec_wt               = %d",readspec_wt             ));       
  `svt_debug("randomize_xact",$psprintf("readnotshareddirty_wt     = %d",readnotshareddirty_wt   ));       
  `svt_debug("randomize_xact",$psprintf("readoncecleaninvalid_wt   = %d",readoncecleaninvalid_wt ));       
  `svt_debug("randomize_xact",$psprintf("readoncemakeinvalid_wt    = %d",readoncemakeinvalid_wt  ));       
  `svt_debug("randomize_xact",$psprintf("cleansharedpersist_wt     = %d",cleansharedpersist_wt   ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_add_wt        = %d",atomicstore_add_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_clr_wt        = %d",atomicstore_clr_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_eor_wt        = %d",atomicstore_eor_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_set_wt        = %d",atomicstore_set_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_smax_wt       = %d",atomicstore_smax_wt     ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_smin_wt       = %d",atomicstore_smin_wt     ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_umax_wt       = %d",atomicstore_umax_wt     ));       
  `svt_debug("randomize_xact",$psprintf("atomicstore_umin_wt       = %d",atomicstore_umin_wt     ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_add_wt         = %d",atomicload_add_wt       ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_clr_wt         = %d",atomicload_clr_wt       ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_eor_wt         = %d",atomicload_eor_wt       ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_set_wt         = %d",atomicload_set_wt       ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_smax_wt        = %d",atomicload_smax_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_smin_wt        = %d",atomicload_smin_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_umax_wt        = %d",atomicload_umax_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicload_umin_wt        = %d",atomicload_umin_wt      ));       
  `svt_debug("randomize_xact",$psprintf("atomicswap_wt             = %d",atomicswap_wt           ));       
  `svt_debug("randomize_xact",$psprintf("atomiccompare_wt          = %d",atomiccompare_wt        ));       
  `svt_debug("randomize_xact",$psprintf("prefetchtgt_wt            = %d",prefetchtgt_wt          ));       
  `svt_debug("randomize_xact",$psprintf("writeuniquefullstash_wt   = %d",writeuniquefullstash_wt ));       
  `svt_debug("randomize_xact",$psprintf("writeuniqueptlstash_wt    = %d",writeuniqueptlstash_wt  ));       
  `svt_debug("randomize_xact",$psprintf("stashonceunique_wt        = %d",stashonceunique_wt      ));       
  `svt_debug("randomize_xact",$psprintf("stashonceshared_wt        = %d",stashonceshared_wt      ));       
`endif
  `svt_debug("randomize_xact",$psprintf("readshared_wt       = %d",readshared_wt      ));      
  `svt_debug("randomize_xact",$psprintf("readunique_wt       = %d",readunique_wt      ));      
  `svt_debug("randomize_xact",$psprintf("cleanunique_wt      = %d",cleanunique_wt     ));     
  `svt_debug("randomize_xact",$psprintf("makeunique_wt       = %d",makeunique_wt      ));      
  `svt_debug("randomize_xact",$psprintf("writebackfull_wt    = %d",writebackfull_wt   ));   
  `svt_debug("randomize_xact",$psprintf("writebackptl_wt     = %d",writebackptl_wt    ));    
  `svt_debug("randomize_xact",$psprintf("writeevictfull_wt   = %d",writeevictfull_wt  ));  
  `svt_debug("randomize_xact",$psprintf("writecleanfull_wt   = %d",writecleanfull_wt  ));  
  `svt_debug("randomize_xact",$psprintf("writecleanptl_wt    = %d",writecleanptl_wt   ));   
  `svt_debug("randomize_xact",$psprintf("evict_wt            = %d",evict_wt           ));           
  `svt_debug("randomize_xact",$psprintf("writenosnpfull_wt   = %d",writenosnpfull_wt  ));  
  `svt_debug("randomize_xact",$psprintf("writenosnpptl_wt    = %d",writenosnpptl_wt   ));   
  `svt_debug("randomize_xact",$psprintf("writeuniquefull_wt  = %d",writeuniquefull_wt )); 
  `svt_debug("randomize_xact",$psprintf("writeuniqueptl_wt   = %d",writeuniqueptl_wt  ));  
  `svt_debug("randomize_xact",$psprintf("cleanshared_wt      = %d",cleanshared_wt     ));     
  `svt_debug("randomize_xact",$psprintf("cleaninvalid_wt     = %d",cleaninvalid_wt    ));    
  `svt_debug("randomize_xact",$psprintf("makeinvalid_wt      = %d",makeinvalid_wt     ));     
  `svt_debug("randomize_xact",$psprintf("eobarrier_wt        = %d",eobarrier_wt       ));       
  `svt_debug("randomize_xact",$psprintf("ecbarrier_wt        = %d",ecbarrier_wt       ));       
  `svt_debug("randomize_xact",$psprintf("dvmop_wt            = %d",dvmop_wt           ));           
  `svt_debug("randomize_xact",$psprintf("pcrdreturn_wt       = %d",pcrdreturn_wt      ));      
  `svt_debug("randomize_xact",$psprintf("reqlinkflit_wt      = %d",reqlinkflit_wt     ));

  
  _end_addr_for_sequential_addr_mode = (end_addr - ((sequence_length-1) * node_cfg.cache_line_size));
  req_success = rn_xact.randomize() with 
  { 
    if (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F) {
    xact_type dist {
                    svt_chi_common_transaction::READNOSNP       := readnosnp_wt,       
                    svt_chi_common_transaction::READONCE        := readonce_wt,        
                    svt_chi_common_transaction::READCLEAN       := readclean_wt,       
                    `ifdef SVT_CHI_ISSUE_B_ENABLE
                    svt_chi_common_transaction::READSPEC             := readspec_wt,       
                    svt_chi_common_transaction::READNOTSHAREDDIRTY   := readnotshareddirty_wt,       
                    svt_chi_common_transaction::READONCECLEANINVALID := readoncecleaninvalid_wt,       
                    svt_chi_common_transaction::READONCEMAKEINVALID  := readoncemakeinvalid_wt,       
                    svt_chi_common_transaction::CLEANSHAREDPERSIST   := cleansharedpersist_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_ADD      := atomicstore_add_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_CLR      := atomicstore_clr_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_EOR      := atomicstore_eor_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_SET      := atomicstore_set_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_SMAX     := atomicstore_smax_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_SMIN     := atomicstore_smin_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_UMAX     := atomicstore_umax_wt,       
                    svt_chi_common_transaction::ATOMICSTORE_UMIN     := atomicstore_umin_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_ADD       := atomicload_add_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_CLR       := atomicload_clr_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_EOR       := atomicload_eor_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_SET       := atomicload_set_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_SMAX      := atomicload_smax_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_SMIN      := atomicload_smin_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_UMAX      := atomicload_umax_wt,       
                    svt_chi_common_transaction::ATOMICLOAD_UMIN      := atomicload_umin_wt,       
                    svt_chi_common_transaction::ATOMICSWAP           := atomicswap_wt,       
                    svt_chi_common_transaction::ATOMICCOMPARE        := atomiccompare_wt,       
                    svt_chi_common_transaction::PREFETCHTGT          := prefetchtgt_wt,       
                    svt_chi_common_transaction::WRITEUNIQUEFULLSTASH := writeuniquefullstash_wt,       
                    svt_chi_common_transaction::WRITEUNIQUEPTLSTASH  := writeuniqueptlstash_wt,       
                    svt_chi_common_transaction::STASHONCEUNIQUE      := stashonceunique_wt,       
                    svt_chi_common_transaction::STASHONCESHARED      := stashonceshared_wt,       
                    `endif          //issue_b_enable
                    `ifdef SVT_CHI_ISSUE_D_ENABLE
                    svt_chi_common_transaction::CLEANSHAREDPERSISTSEP := cleansharedpersistsep_wt,
                    `endif //issue_d_enable
                    svt_chi_common_transaction::READSHARED      := readshared_wt,      
                    svt_chi_common_transaction::READUNIQUE      := readunique_wt,      
                    svt_chi_common_transaction::CLEANUNIQUE     := cleanunique_wt,     
                    svt_chi_common_transaction::MAKEUNIQUE      := makeunique_wt,      
                    svt_chi_common_transaction::WRITEBACKFULL   := writebackfull_wt,   
                    svt_chi_common_transaction::WRITEBACKPTL    := writebackptl_wt,    
                    svt_chi_common_transaction::WRITEEVICTFULL  := writeevictfull_wt,  
                    svt_chi_common_transaction::WRITECLEANFULL  := writecleanfull_wt,  
                    svt_chi_common_transaction::WRITECLEANPTL   := writecleanptl_wt,   
                    svt_chi_common_transaction::EVICT           := evict_wt,           
                    svt_chi_common_transaction::WRITENOSNPFULL  := writenosnpfull_wt,  
`ifdef SVT_CHI_ISSUE_E_ENABLE
                    svt_chi_common_transaction::WRITEEVICTOREVICT  := writeevictorevict_wt,  
                    svt_chi_common_transaction::WRITENOSNPZERO  := writenosnpzero_wt,  
                    svt_chi_common_transaction::WRITEUNIQUEZERO := writeuniquezero_wt,  
                    svt_chi_common_transaction::MAKEREADUNIQUE  := makereadunique_wt,  
                    svt_chi_common_transaction::READPREFERUNIQUE  := readpreferunique_wt,
                    svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHARED := writenosnpfull_cleanshared_wt,
                    svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP := writenosnpfull_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHARED := writeuniquefull_cleanshared_wt,
                    svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP := writeuniquefull_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP := writeuniqueptl_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHARED := writeuniqueptl_cleanshared_wt,
                    svt_chi_common_transaction::WRITENOSNPFULL_CLEANINVALID := writenosnpfull_cleaninvalid_wt,
                    svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHARED := writenosnpptl_cleanshared_wt,
                    svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP := writenosnpptl_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::WRITENOSNPPTL_CLEANINVALID := writenosnpptl_cleaninvalid_wt,
                    svt_chi_common_transaction::WRITEBACKFULL_CLEANSHARED := writebackfull_cleanshared_wt,
                    svt_chi_common_transaction::WRITEBACKFULL_CLEANSHAREDPERSISTSEP := writebackfull_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::WRITEBACKFULL_CLEANINVALID := writebackfull_cleaninvalid_wt,
                    svt_chi_common_transaction::WRITECLEANFULL_CLEANSHARED := writecleanfull_cleanshared_wt,
                    svt_chi_common_transaction::WRITECLEANFULL_CLEANSHAREDPERSISTSEP := writecleanfull_cleansharedpersistsep_wt,
                    svt_chi_common_transaction::STASHONCESEPUNIQUE      := stashoncesepunique_wt,       
                    svt_chi_common_transaction::STASHONCESEPSHARED      := stashoncesepshared_wt,       
`endif
                    svt_chi_common_transaction::WRITENOSNPPTL   := writenosnpptl_wt,   
                    svt_chi_common_transaction::WRITEUNIQUEFULL := writeuniquefull_wt, 
                    svt_chi_common_transaction::WRITEUNIQUEPTL  := writeuniqueptl_wt,  
                    svt_chi_common_transaction::CLEANSHARED     := cleanshared_wt,     
                    svt_chi_common_transaction::CLEANINVALID    := cleaninvalid_wt,    
                    svt_chi_common_transaction::MAKEINVALID     := makeinvalid_wt,     
                    svt_chi_common_transaction::EOBARRIER       := eobarrier_wt,       
                    svt_chi_common_transaction::ECBARRIER       := ecbarrier_wt,       
                    svt_chi_common_transaction::DVMOP           := dvmop_wt,           
                    svt_chi_common_transaction::PCRDRETURN      := pcrdreturn_wt,      
                    svt_chi_common_transaction::REQLINKFLIT     := reqlinkflit_wt      
                    };
    }
    else if (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_D) 
    {
      xact_type dist {
                      svt_chi_common_transaction::READNOSNP       := readnosnp_wt,       
                      svt_chi_common_transaction::READONCE        := readonce_wt,        
                      `ifdef SVT_CHI_ISSUE_B_ENABLE
                      svt_chi_common_transaction::READONCECLEANINVALID := readoncecleaninvalid_wt,       
                      svt_chi_common_transaction::READONCEMAKEINVALID  := readoncemakeinvalid_wt,       
                      svt_chi_common_transaction::CLEANSHAREDPERSIST   := cleansharedpersist_wt,       
                      svt_chi_common_transaction::PREFETCHTGT          := prefetchtgt_wt,       
                      svt_chi_common_transaction::WRITEUNIQUEFULLSTASH := writeuniquefullstash_wt,       
                      svt_chi_common_transaction::WRITEUNIQUEPTLSTASH  := writeuniqueptlstash_wt,       
                      svt_chi_common_transaction::STASHONCEUNIQUE      := stashonceunique_wt,       
                      svt_chi_common_transaction::STASHONCESHARED      := stashonceshared_wt,       
                      `endif     //issue_b_enable
                      `ifdef SVT_CHI_ISSUE_D_ENABLE
                      svt_chi_common_transaction::CLEANSHAREDPERSISTSEP := cleansharedpersistsep_wt,
                      `endif
`ifdef SVT_CHI_ISSUE_E_ENABLE
                      svt_chi_common_transaction::WRITENOSNPZERO  := writenosnpzero_wt,  
                      svt_chi_common_transaction::WRITEUNIQUEZERO := writeuniquezero_wt,  
                      svt_chi_common_transaction::MAKEREADUNIQUE  := makereadunique_wt,  
                      svt_chi_common_transaction::READPREFERUNIQUE  := readpreferunique_wt,
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHARED := writenosnpfull_cleanshared_wt,
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP := writenosnpfull_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHARED := writeuniquefull_cleanshared_wt,
                      svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP := writeuniquefull_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHARED := writeuniqueptl_cleanshared_wt,
                      svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP := writeuniqueptl_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANINVALID := writenosnpfull_cleaninvalid_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANINVALID := writenosnpptl_cleaninvalid_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP := writenosnpptl_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHARED := writenosnpptl_cleanshared_wt,
                      svt_chi_common_transaction::STASHONCESEPUNIQUE      := stashoncesepunique_wt,       
                      svt_chi_common_transaction::STASHONCESEPSHARED      := stashoncesepshared_wt,       
`endif
                      svt_chi_common_transaction::WRITENOSNPFULL  := writenosnpfull_wt,  
                      svt_chi_common_transaction::WRITENOSNPPTL   := writenosnpptl_wt,   
                      svt_chi_common_transaction::WRITEUNIQUEFULL := writeuniquefull_wt, 
                      svt_chi_common_transaction::WRITEUNIQUEPTL  := writeuniqueptl_wt,  
                      svt_chi_common_transaction::CLEANSHARED     := cleanshared_wt,     
                      svt_chi_common_transaction::CLEANINVALID    := cleaninvalid_wt,    
                      svt_chi_common_transaction::MAKEINVALID     := makeinvalid_wt,     
                      svt_chi_common_transaction::EOBARRIER       := eobarrier_wt,       
                      svt_chi_common_transaction::ECBARRIER       := ecbarrier_wt,       
                      svt_chi_common_transaction::DVMOP           := dvmop_wt,           
                      svt_chi_common_transaction::PCRDRETURN      := pcrdreturn_wt,      
                      svt_chi_common_transaction::REQLINKFLIT     := reqlinkflit_wt      
                      };
  
    }
    else if (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_I) 
    {
      xact_type dist {
                      svt_chi_common_transaction::READNOSNP       := readnosnp_wt,       
                      svt_chi_common_transaction::READONCE        := readonce_wt,        
                      `ifdef SVT_CHI_ISSUE_B_ENABLE
                      svt_chi_common_transaction::READONCECLEANINVALID := readoncecleaninvalid_wt,       
                      svt_chi_common_transaction::READONCEMAKEINVALID  := readoncemakeinvalid_wt,       
                      svt_chi_common_transaction::CLEANSHAREDPERSIST   := cleansharedpersist_wt,       
                      svt_chi_common_transaction::PREFETCHTGT          := prefetchtgt_wt,       
                      svt_chi_common_transaction::WRITEUNIQUEFULLSTASH := writeuniquefullstash_wt,       
                      svt_chi_common_transaction::WRITEUNIQUEPTLSTASH  := writeuniqueptlstash_wt,       
                      svt_chi_common_transaction::STASHONCEUNIQUE      := stashonceunique_wt,       
                      svt_chi_common_transaction::STASHONCESHARED      := stashonceshared_wt,       
                      `endif             //issue_b_enable
                      `ifdef SVT_CHI_ISSUE_D_ENABLE
                      svt_chi_common_transaction::CLEANSHAREDPERSISTSEP := cleansharedpersistsep_wt,
                      `endif
                      svt_chi_common_transaction::WRITENOSNPFULL  := writenosnpfull_wt,  
`ifdef SVT_CHI_ISSUE_E_ENABLE
                      svt_chi_common_transaction::WRITENOSNPZERO  := writenosnpzero_wt,  
                      svt_chi_common_transaction::WRITEUNIQUEZERO := writeuniquezero_wt, 
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHARED := writenosnpfull_cleanshared_wt,
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP := writenosnpfull_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHARED := writeuniquefull_cleanshared_wt,
                      svt_chi_common_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP := writeuniquefull_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHARED := writeuniqueptl_cleanshared_wt,
                      svt_chi_common_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP := writeuniqueptl_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::WRITENOSNPFULL_CLEANINVALID := writenosnpfull_cleaninvalid_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANINVALID := writenosnpptl_cleaninvalid_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHARED := writenosnpptl_cleanshared_wt,
                      svt_chi_common_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP := writenosnpptl_cleansharedpersistsep_wt,
                      svt_chi_common_transaction::STASHONCESEPUNIQUE      := stashoncesepunique_wt,       
                      svt_chi_common_transaction::STASHONCESEPSHARED      := stashoncesepshared_wt,       
`endif
                      svt_chi_common_transaction::WRITENOSNPPTL   := writenosnpptl_wt,   
                      svt_chi_common_transaction::WRITEUNIQUEFULL := writeuniquefull_wt, 
                      svt_chi_common_transaction::WRITEUNIQUEPTL  := writeuniqueptl_wt,  
                      svt_chi_common_transaction::CLEANSHARED     := cleanshared_wt,     
                      svt_chi_common_transaction::CLEANINVALID    := cleaninvalid_wt,    
                      svt_chi_common_transaction::MAKEINVALID     := makeinvalid_wt,     
                      svt_chi_common_transaction::EOBARRIER       := eobarrier_wt,       
                      svt_chi_common_transaction::ECBARRIER       := ecbarrier_wt,       
                      svt_chi_common_transaction::PCRDRETURN      := pcrdreturn_wt,      
                      svt_chi_common_transaction::REQLINKFLIT     := reqlinkflit_wt      
                      };
  
    }

    `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(seq_order_type == svt_chi_transaction::REQ_EP_ORDERING_REQUIRED && mem_attr_mem_type == svt_chi_transaction::NORMAL &&
       ((xact_type == svt_chi_transaction::ATOMICSTORE_ADD)  || (xact_type == svt_chi_transaction::ATOMICSTORE_CLR) ||
        (xact_type == svt_chi_transaction::ATOMICSTORE_EOR)  || (xact_type == svt_chi_transaction::ATOMICSTORE_SET) ||
        (xact_type == svt_chi_transaction::ATOMICSTORE_SMAX) || (xact_type == svt_chi_transaction::ATOMICSTORE_SMIN) ||
        (xact_type == svt_chi_transaction::ATOMICSTORE_UMAX) || (xact_type == svt_chi_transaction::ATOMICSTORE_UMIN) ||
        (xact_type == svt_chi_transaction::ATOMICLOAD_ADD)   || (xact_type == svt_chi_transaction::ATOMICLOAD_CLR) ||
        (xact_type == svt_chi_transaction::ATOMICLOAD_EOR)   || (xact_type == svt_chi_transaction::ATOMICLOAD_SET) ||
        (xact_type == svt_chi_transaction::ATOMICLOAD_SMAX)  || (xact_type == svt_chi_transaction::ATOMICLOAD_SMIN) ||
        (xact_type == svt_chi_transaction::ATOMICLOAD_UMAX)  || (xact_type == svt_chi_transaction::ATOMICLOAD_UMIN) ||
        (xact_type == svt_chi_transaction::ATOMICSWAP)       || (xact_type == svt_chi_transaction::ATOMICCOMPARE))) {
         order_type == REQ_ORDERING_REQUIRED;
       } else {
     `endif
       if (use_seq_order_type)
         order_type == seq_order_type;
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    }
    `endif

    if (use_coherent_xacts_mem_attr_snp_attr_for_cmo_atomics) {
      if (xact_type == svt_chi_transaction::CLEANSHARED || xact_type == svt_chi_transaction::CLEANINVALID  || 
          xact_type == svt_chi_transaction::MAKEINVALID 
          `ifdef SVT_CHI_ISSUE_B_ENABLE
           || xact_type == svt_chi_transaction::CLEANSHAREDPERSIST || 
          xact_type == svt_chi_transaction::ATOMICSTORE_ADD  || xact_type == svt_chi_transaction::ATOMICSTORE_CLR ||
          xact_type == svt_chi_transaction::ATOMICSTORE_EOR  || xact_type == svt_chi_transaction::ATOMICSTORE_SET ||
          xact_type == svt_chi_transaction::ATOMICSTORE_SMAX || xact_type == svt_chi_transaction::ATOMICSTORE_SMIN ||
          xact_type == svt_chi_transaction::ATOMICSTORE_UMAX || xact_type == svt_chi_transaction::ATOMICSTORE_UMIN ||
          xact_type == svt_chi_transaction::ATOMICLOAD_ADD   || xact_type == svt_chi_transaction::ATOMICLOAD_CLR ||
          xact_type == svt_chi_transaction::ATOMICLOAD_EOR   || xact_type == svt_chi_transaction::ATOMICLOAD_SET ||
          xact_type == svt_chi_transaction::ATOMICLOAD_SMAX  || xact_type == svt_chi_transaction::ATOMICLOAD_SMIN ||
          xact_type == svt_chi_transaction::ATOMICLOAD_UMAX  || xact_type == svt_chi_transaction::ATOMICLOAD_UMIN ||
          xact_type == svt_chi_transaction::ATOMICSWAP       || xact_type == svt_chi_transaction::ATOMICCOMPARE
          `endif
          `ifdef SVT_CHI_ISSUE_D_ENABLE
           || xact_type == svt_chi_transaction::CLEANSHAREDPERSISTSEP 
          `endif
         ){
           mem_attr_is_early_wr_ack_allowed == 1;
           mem_attr_is_cacheable == 1;
           mem_attr_mem_type == svt_chi_transaction::NORMAL;
           snp_attr_is_snoopable == 1;
      }
    }
    if(use_seq_data_size)
      data_size == seq_data_size; 
    if(use_seq_p_crd_return_on_retry_ack)
      p_crd_return_on_retry_ack == seq_p_crd_return_on_retry_ack; 
    if (gen_uniq_txn_id)
      txn_id ==  sequence_index % (2^`SVT_CHI_TXN_ID_WIDTH);
    // If directed address is enabled, that gets priority.
    // Otherwise, decided based on addr_mode. If addr_mode
    // is TARGET_HN_INDEX, no need to constrain the address,
    // but need to constrain the hn_node_index. Proceed 
    // further for other types of addr_mode based on the
    // intended functionality.
    if (randomize_with_directed_addr) {
      addr == directed_addr;
      if(xact_type == svt_chi_transaction::EVICT
         `ifdef SVT_CHI_ISSUE_B_ENABLE
         || xact_type == svt_chi_transaction::READONCEMAKEINVALID
         `endif
        ) {
        mem_attr_allocate_hint == 1'b0;
      }
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        else if(xact_type == svt_chi_transaction::WRITEEVICTFULL){
          mem_attr_allocate_hint == 1'b1;
        }
        else if(use_directed_mem_attr) {
          mem_attr_allocate_hint == directed_mem_attr_allocate_hint;
        }
      `else
        mem_attr_allocate_hint == directed_mem_attr_allocate_hint;
      `endif
      if(use_directed_non_secure_access) {
        is_non_secure_access == directed_is_non_secure_access;
      }
      if(use_directed_snp_attr) {
        `ifndef SVT_CHI_ISSUE_B_ENABLE
          if (directed_snp_attr_is_snoopable) {
              snp_attr_snp_domain_type == directed_snp_attr_snp_domain_type;
          }
         `else  //issue_b_enable
            if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B &&
               ((xact_type == svt_chi_transaction::ATOMICSTORE_ADD)  || (xact_type == svt_chi_transaction::ATOMICSTORE_CLR) ||
               (xact_type == svt_chi_transaction::ATOMICSTORE_EOR)  || (xact_type == svt_chi_transaction::ATOMICSTORE_SET) ||
               (xact_type == svt_chi_transaction::ATOMICSTORE_SMAX) || (xact_type == svt_chi_transaction::ATOMICSTORE_SMIN) ||
               (xact_type == svt_chi_transaction::ATOMICSTORE_UMAX) || (xact_type == svt_chi_transaction::ATOMICSTORE_UMIN) ||
               (xact_type == svt_chi_transaction::ATOMICLOAD_ADD)   || (xact_type == svt_chi_transaction::ATOMICLOAD_CLR) ||
               (xact_type == svt_chi_transaction::ATOMICLOAD_EOR)   || (xact_type == svt_chi_transaction::ATOMICLOAD_SET) ||
               (xact_type == svt_chi_transaction::ATOMICLOAD_SMAX)  || (xact_type == svt_chi_transaction::ATOMICLOAD_SMIN) ||
               (xact_type == svt_chi_transaction::ATOMICLOAD_UMAX)  || (xact_type == svt_chi_transaction::ATOMICLOAD_UMIN) ||
               (xact_type == svt_chi_transaction::ATOMICSWAP)       || (xact_type == svt_chi_transaction::ATOMICCOMPARE) ||
               (xact_type == svt_chi_transaction::CLEANSHARED)      || (xact_type == svt_chi_transaction::CLEANSHAREDPERSIST) ||
               (xact_type == svt_chi_transaction::CLEANINVALID)      || (xact_type == svt_chi_transaction::MAKEINVALID))
              ) {
              snp_attr_is_snoopable == directed_snp_attr_is_snoopable;
            }
            `ifdef SVT_CHI_ISSUE_D_ENABLE
            else if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D && node_cfg.cleansharedpersistsep_xact_enable && xact_type == svt_chi_transaction::CLEANSHAREDPERSISTSEP){
              snp_attr_is_snoopable == directed_snp_attr_is_snoopable;
            }
            `endif //issue_d_enable
         `endif //isssue_b_enable
      }
      if(use_directed_data_size){
        data_size == directed_data_size; 
      }
      if(use_directed_data){
        data == directed_data; 
      }
      if(use_directed_byte_enable){
        byte_enable == directed_byte_enable; 
      }
      if(use_directed_allocate_in_cache){
        if(xact_type == svt_chi_transaction::CLEANUNIQUE){
          allocate_in_cache == directed_allocate_in_cache;
        }
      }
    }
    else if (addr_mode == TARGET_HN_INDEX)
    {
      hn_node_idx == seq_hn_node_idx;
    }
    else  if ((addr_mode == SEQUENTIAL_OVERLAPPED_ADDRESS) ||
              (addr_mode == SEQUENTIAL_NONOVERLAPPED_ADDRESS)) 
    {
      if (sequence_index == 0)
        addr inside {[start_addr:_end_addr_for_sequential_addr_mode]};
      else
        addr == (_previous_xact_addr + node_cfg.cache_line_size);
    }
    else if (addr_mode == RANDOM_ADDRESS_IN_RANGE) { 
      addr inside {[start_addr:end_addr]};
    }
    else if (addr_mode != RANDOM_ADDRESS) {
      if (addr_mode != IGNORE_ADDRESSING_MODE) { 
          addr inside {[start_addr:end_addr]};
`protected
E28OL8Q7F]]Yb,aE+@gI?B_c,E=R@L=#8PZ]<WQA8YCC,R^.3LIa2)V[5b-Z3DGP
-/gBUCXI6Uc76;5@H,^:_._c4$
`endprotected
 
          addr[5:0] == 'h0;
      }
      else {
        addr[5:0] == 0;
      }
    }

  };

`ifdef SVT_CHI_ISSUE_B_ENABLE
  local_rn_xact=rn_xact;
  if((rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_ADD) ||
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_CLR) ||     
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_EOR) ||    
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_SET) ||     
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_SMAX) ||       
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_SMIN) ||      
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_UMAX) ||       
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSTORE_UMIN) ||      
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_ADD) ||  
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_CLR) ||    
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_EOR) ||    
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_SET) ||    
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_SMAX) ||      
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_SMIN) ||     
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_UMAX) ||      
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICLOAD_UMIN) ||     
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICSWAP) ||
     (rn_xact.xact_type == svt_chi_common_transaction::ATOMICCOMPARE))begin 
       rn_xact.snoopme = seq_snoopme;
       rn_xact.endian = seq_endian;
       `svt_xvm_debug("randomize_xact",$sformatf("seq_snoopme=%0d seq_endian=%s",seq_snoopme,seq_endian.name()));
  end
`endif

  if(req_success == 1)
     _previous_xact_addr = rn_xact.addr;

  `svt_debug("randomize_xact",$psprintf("req_success - %b", req_success));
  `svt_verbose("randomize_xact", rn_xact.sprint());
endtask // randomize_xact

// =============================================================================
/** 
 * @groupname CHI_RN_DVM
 * svt_chi_rn_transaction_dvm_write_semantic_sequence 
 *
 * This sequence creates a random DVM write semantic request with control
 * over the dvm_message_type field.
 * User can control the number of DVMOP write semantic transcations to
 * generate by constraining the dvm_write_semantic_length field from the test.
 */
class svt_chi_rn_transaction_dvm_write_semantic_sequence extends svt_chi_rn_transaction_random_sequence;

  /** @cond PRIVATE */  
  /** local field used to set DVM MESSAGE TYPE */
  rand svt_chi_common_transaction::dvm_message_type_enum dvm_message_type = svt_chi_common_transaction::DVM_MSG_TYPE_TLB_INVALIDATE;
   
  /** Controls the number of random DVM write semantic operations that 
   *  will be generated
   */
  rand int unsigned dvm_write_semantic_length;

  rand bit[(`SVT_CHI_LPID_WIDTH-1):0] req_lpid;

  rand bit use_seq_lpid = 0;

  event dvm_non_sync_xact_initiated;

  /** Constraint the dvm_message_type to a valid ranges */
  constraint valid_dvm_message_types {
    dvm_message_type inside { svt_chi_common_transaction::DVM_MSG_TYPE_TLB_INVALIDATE, 
                              svt_chi_common_transaction::DVM_MSG_TYPE_BTB_INVALIDATE, 
                              svt_chi_common_transaction::DVM_MSG_TYPE_PHY_ICACHE_INVALIDATE, 
                              svt_chi_common_transaction::DVM_MSG_TYPE_VIRT_ICACHE_INVALIDATE};
  }

  constraint valid_dvm_write_semantic_length { dvm_write_semantic_length inside {[1:5]};}

  /** @endcond */

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_dvm_write_semantic_sequence) 

  /**
   * Constructs the svt_chi_rn_transaction_dvm_write_semantic_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_dvm_write_semantic_sequence");
  
  /** 
   * Executes the svt_chi_rn_transaction_dvm_write_semantic_sequence sequence. 
   */
  extern virtual task body();

  /** 
   * Calls `svt_xvm_do_with to send the transction.  Constrains both the xact_type
   * and addr[13:11] bits which are used for DVM Message Field Encoding.
   */
  extern virtual task send_random_transaction(svt_chi_rn_transaction req);

  virtual task pre_start();
    int dvm_message_type_status;
    bit enable_non_blocking_status;
    int dvm_write_semantic_length_status;

    super.pre_start();
    /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    dvm_message_type_status = uvm_config_db#(svt_chi_common_transaction::dvm_message_type_enum)::get(m_sequencer, get_type_name(), "dvm_message_type", dvm_message_type);
    dvm_write_semantic_length_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "dvm_write_semantic_length", dvm_write_semantic_length);
    enable_non_blocking_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
    dvm_message_type_status = m_sequencer.get_config_int({get_type_name(), ".dvm_message_type"}, dvm_message_type);
    dvm_write_semantic_length_status = m_sequencer.get_config_int({get_type_name(), ".dvm_write_semantic_length"}, dvm_write_semantic_length);
    enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
    `svt_xvm_debug("body", $sformatf("enable_non_blocking is %0d as a result of %0s", enable_non_blocking, (enable_non_blocking_status? "config DB":"default setting")));
    `svt_xvm_debug("body", $sformatf("dvm_write_semantic_length is %0d as a result of %0s.", dvm_write_semantic_length, dvm_write_semantic_length_status? "the config DB" : "the random value"))
  endtask

endclass: svt_chi_rn_transaction_dvm_write_semantic_sequence

//------------------------------------------------------------------------------
function svt_chi_rn_transaction_dvm_write_semantic_sequence::new(string name = "svt_chi_rn_transaction_dvm_write_semantic_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_dvm_write_semantic_sequence::body();
  svt_chi_rn_transaction non_sync_req;
  svt_chi_rn_transaction dvm_write_xact[$];
  svt_configuration cfg;

  /** Obtain a handle to the rn node configuration */
  p_sequencer.get_cfg(cfg);
  if (cfg == null || !$cast(node_cfg, cfg)) begin
    `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
  end

  if(enable_non_blocking)
    sink_responses();

  repeat(dvm_write_semantic_length) begin
    if(use_seq_lpid) begin
      `svt_xvm_do_with(non_sync_req,{xact_type == svt_chi_common_transaction::DVMOP;addr[13:11] == dvm_message_type;addr[3] == 0; lpid == req_lpid;});
    end else begin
      `svt_xvm_do_with(non_sync_req,{xact_type == svt_chi_common_transaction::DVMOP;addr[13:11] == dvm_message_type;addr[3] == 0;});
    end

    if (!enable_non_blocking) begin
      get_response(rsp);
      if (get_timing_info) begin
        // Call method to gather FLIT timing information
        get_flit_timing_info(non_sync_req);
      end
    end
    else begin
      dvm_write_xact.push_back(non_sync_req);
    end // else: !if(!enable_non_blocking)
  end //repeat(dvm_write_semantic_length)

  fork
    -> dvm_non_sync_xact_initiated;
  join_none

  if (enable_non_blocking) begin
    foreach(dvm_write_xact[i]) begin
     automatic int j=i;
      dvm_write_xact[j].wait_end();
    end

    if (get_timing_info) begin
      foreach(dvm_write_xact[i]) begin
        // Call method to gather FLIT timing information
        get_flit_timing_info(dvm_write_xact[i]);
      end
    end // if (get_timing_info)
  end // if (enable_non_blocking)

endtask

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_dvm_write_semantic_sequence::send_random_transaction(svt_chi_rn_transaction req);
endtask

// =============================================================================
/** 
 * @groupname CHI_RN_DVM 
 * svt_chi_rn_transaction_dvm_sync_sequence 
 *
 * This sequence will use svt_chi_rn_transaction_dvm_write_semantic_sequence
 * to generate a random number of DVMOP write semantic transcations followed
 * by a DVMOP sync.
 */
class svt_chi_rn_transaction_dvm_sync_sequence extends svt_chi_rn_transaction_random_sequence;
  

  rand dvm_lpid_pattern_enum dvm_lpid_pattern;

  bit lpid_pattern_status;

  bit dvm_sync_data_phase_complete = 0;

  rand bit[(`SVT_CHI_LPID_WIDTH-1):0] dvm_lpid;
  
  /** Sub sequences initiated from this sequence */
  svt_chi_rn_transaction_dvm_write_semantic_sequence chi_rn_seq;
  svt_chi_rn_transaction_dvm_write_semantic_sequence chi_rn_seq_with_random_lpid;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_dvm_sync_sequence) 

  /**
   * Constructs the svt_chi_rn_transaction_dvm_sync_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_dvm_sync_sequence");
  
  /** 
   * Executes the svt_chi_rn_transaction_dvm_sync_sequence sequence. 
   */
  extern virtual task body();

  /** 
   * Calls `svt_xvm_do_with to send the transction.  Constrains both the xact_type
   * and addr[13:11] bits which are used for DVM Message Field Encoding.
   */
  extern virtual task send_random_transaction(svt_chi_rn_transaction req);


  virtual task pre_start();
    int seq_len_status;

    super.pre_start();
    /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  
  endtask
endclass: svt_chi_rn_transaction_dvm_sync_sequence

//------------------------------------------------------------------------------
function svt_chi_rn_transaction_dvm_sync_sequence::new(string name = "svt_chi_rn_transaction_dvm_sync_sequence");
  super.new(name);
endfunction


//------------------------------------------------------------------------------
task svt_chi_rn_transaction_dvm_sync_sequence::body();
  svt_chi_rn_transaction dvm_write_req;
  `ifdef SVT_UVM_TECHNOLOGY
      lpid_pattern_status = uvm_config_db#(dvm_lpid_pattern_enum)::get(m_sequencer, get_type_name(), "dvm_lpid_pattern", dvm_lpid_pattern);
  `else
      lpid_pattern_status   = m_sequencer.get_config_int({get_type_name(), ".dvm_lpid_pattern"}, dvm_lpid_pattern);
  `endif
  `svt_xvm_debug("body", $sformatf("dvm_lpid_pattern is %0s as a result of %0s.", dvm_lpid_pattern.name(), lpid_pattern_status ? "the config DB" : "randomization"));
  send_random_transaction (dvm_write_req);
endtask

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_dvm_sync_sequence::send_random_transaction(svt_chi_rn_transaction req);
  svt_chi_rn_transaction dvm_sync_req;
  svt_configuration cfg;
  /** Obtain a handle to the rn node configuration */
  p_sequencer.get_cfg(cfg);
  if (cfg == null || !$cast(node_cfg, cfg)) begin
    `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
  end

  fork
    begin
      /** Generate random number of DVMOP write semantic transaction */
      if(dvm_lpid_pattern == ALL_SYNC_NON_SYNC_WITH_SAME_LPID || dvm_lpid_pattern == NON_SYNC_WITH_DIFF_LPID_SYNC_TO_ONE_LPID) begin
        `svt_xvm_do_with(chi_rn_seq, {use_seq_lpid == 1;req_lpid == dvm_lpid;});
      end else if(dvm_lpid_pattern == SYNC_NON_SYNC_WITH_DIFF_LPID) begin
        `svt_xvm_do_with(chi_rn_seq, {use_seq_lpid == 1;req_lpid != dvm_lpid;});
      end else begin
        `svt_xvm_do(chi_rn_seq);
      end
      `svt_xvm_debug("body", $sformatf("Received Comp response for all the Outstanding Non-Sync transactions initiated"));
    end
    begin
      if(dvm_lpid_pattern == NON_SYNC_WITH_DIFF_LPID_SYNC_TO_ONE_LPID) begin
        `svt_xvm_do(chi_rn_seq_with_random_lpid);
      end
    end
    begin
      @chi_rn_seq.dvm_non_sync_xact_initiated;
      `svt_xvm_debug("body", $sformatf("chi_rn_seq.dvm_non_sync_xact_initiated triggered : all the Outstanding Non-Sync transactions initiated succesfuly"));
      /** Send a DVM Sync Operation to know when the DVM operation is complete 
       * in all peer RNs.
       */
      if(dvm_lpid_pattern == ALL_SYNC_NON_SYNC_WITH_SAME_LPID || dvm_lpid_pattern == SYNC_NON_SYNC_WITH_DIFF_LPID || dvm_lpid_pattern == NON_SYNC_WITH_DIFF_LPID_SYNC_TO_ONE_LPID) begin
        `svt_xvm_do_with(dvm_sync_req,{xact_type == svt_chi_common_transaction::DVMOP;addr[13:11] == svt_chi_common_transaction::DVM_MSG_TYPE_SYNC;addr[3] == 0; lpid == dvm_lpid;});
      end else begin
        `svt_xvm_do_with(dvm_sync_req,{xact_type == svt_chi_common_transaction::DVMOP;addr[13:11] == svt_chi_common_transaction::DVM_MSG_TYPE_SYNC;addr[3] == 0;});
      end
      `svt_xvm_debug("body", $sformatf("Sync transaction initiated succesfuly and waiting for the transaction to end"));

      wait(dvm_sync_req.data_status == svt_chi_transaction::ACCEPT);
      dvm_sync_data_phase_complete = 1;

      dvm_sync_req.wait_end();
      `svt_xvm_debug("body", $sformatf("Received Comp response : Sync transaction ended"));
    end
  join

endtask

// =============================================================================
/** 
 * @groupname CHI_RN_BARRIER
 * RN transaction EOBARRIER sequence
 */
class svt_chi_rn_eobarrier_sequence extends svt_chi_rn_coherent_transaction_base_sequence;
  `svt_xvm_object_utils(svt_chi_rn_eobarrier_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  function new(string name = "svt_chi_rn_eobarrier_sequence");
    super.new(name);
  endfunction // new

  virtual task body();
    svt_configuration cfg;

    `svt_xvm_debug("body","svt_chi_rn_eobarrier_sequence");

    if(node_cfg == null) begin
      /** Obtain a handle to the rn node configuration */
      p_sequencer.get_cfg(cfg);
      if (cfg == null || !$cast(node_cfg, cfg)) begin
        `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
    
    disable_all_weights();
    assign_xact_weights(svt_chi_common_transaction::EOBARRIER);
    generate_transactions();
    `svt_xvm_debug("body","exiting svt_chi_rn_eobarrier_sequence");
  endtask // body
  
endclass // svt_chi_rn_eobarrier_sequence

// =============================================================================
/** 
 * @groupname CHI_RN_BARRIER
 * RN transaction ECBARRIER sequence
 */  
class svt_chi_rn_ecbarrier_sequence extends svt_chi_rn_coherent_transaction_base_sequence;
  `svt_xvm_object_utils(svt_chi_rn_ecbarrier_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  function new(string name = "svt_chi_rn_ecbarrier_sequence");
    super.new(name);
  endfunction // new

  virtual task body();
    svt_configuration cfg;
    `svt_xvm_debug("body","svt_chi_rn_ecbarrier_sequence");
    if(node_cfg == null) begin
      /** Obtain a handle to the rn node configuration */
      p_sequencer.get_cfg(cfg);
      if (cfg == null || !$cast(node_cfg, cfg)) begin
        `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
    disable_all_weights();
    assign_xact_weights(svt_chi_common_transaction::ECBARRIER);
    generate_transactions();
    `svt_xvm_debug("body","exiting svt_chi_rn_ecbarrier_sequence");
  endtask // body
  
endclass // svt_chi_rn_ecbarrier_sequence

// =============================================================================
/** 
 * @groupname CHI_RN_ORDERING
 * RN transaction non-coherent transaction type sequence that exercises global observability
 * for pre-barrier transactions
 */
class svt_chi_rn_go_noncoherent_sequence extends svt_chi_rn_coherent_transaction_base_sequence;

  typedef bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] store_data_type;
  store_data_type store_data, directed_store_data;

  /** 
   * Indicates that the data provided in directed_data_mailbox should be used
   * for the transactions generated by this sequence
   */
  bit randomize_with_directed_data;

  /**
   * Applicable if randomize_with_directed_data is set.
   * A mailbox into which a user can put data to which transactions have to be
   * generated.
   */
  mailbox #(store_data_type) directed_data_mailbox;
  
  `svt_xvm_object_utils(svt_chi_rn_go_noncoherent_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  function new(string name = "svt_chi_rn_go_noncoherent_sequence");
    super.new(name);
    directed_data_mailbox=new();
  endfunction // new

 /** 
  * This sequence randomizes a single transaction based on the weights assigned.
  *  - If randomized_with_directed_addr is set, the transaction is randomized with
  *    the address specified in directed_addr
  *  - If randomized_with_directed_data is set, the transaction is randomized with
  *    the data specified in directed_store_data
  *  - If store_data is set, the transaction is randomized with
  *    the data specified in store_data
  *  .
  */
  virtual task randomize_xact(svt_chi_rn_transaction           rn_xact,
                              bit                              randomize_with_directed_addr, 
                              bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr,
                              bit                              directed_snp_attr_is_snoopable,
                              svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                              bit                              directed_mem_attr_allocate_hint,
                              bit                              directed_is_non_secure_access,
                              bit                              directed_allocate_in_cache,
                              svt_chi_common_transaction::data_size_enum directed_data_size, 
                              bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                              bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable,
                              output bit                       req_success,
                              input  int                       sequence_index = 0,
                              input  bit                       gen_uniq_txn_id = 0);
    
    `svt_debug("randomize_xact", "svt_chi_rn_go_noncoherent_sequence - Entered ");
    // Get config from corresponding sequencer and assign it here.
    rn_xact.cfg      = node_cfg;
    if (randomize_with_directed_data)begin
      void'(directed_data_mailbox.try_get(directed_store_data));
    end
    
    req_success = rn_xact.randomize() with 
    { 
    xact_type dist {
                    svt_chi_common_transaction::READNOSNP       := readnosnp_wt,       
                    svt_chi_common_transaction::WRITENOSNPFULL  := writenosnpfull_wt,  
                    svt_chi_common_transaction::WRITENOSNPPTL   := writenosnpptl_wt   
                    };
    
    if (randomize_with_directed_addr)  addr == directed_addr;
    `ifndef SVT_CHI_ISSUE_B_ENABLE
      if (randomize_with_directed_addr && directed_snp_attr_is_snoopable && use_directed_snp_attr)  snp_attr_snp_domain_type == directed_snp_attr_snp_domain_type;
    `endif
    if (randomize_with_directed_addr && use_directed_mem_attr)  mem_attr_allocate_hint == directed_mem_attr_allocate_hint;
    if (randomize_with_directed_addr && use_directed_non_secure_access)  is_non_secure_access == directed_is_non_secure_access;
    
    requires_go_before_barrier == 1;

    if(store_data != 0) data == store_data;
    if (randomize_with_directed_data)  data == directed_store_data;

    order_type == svt_chi_common_transaction::NO_ORDERING_REQUIRED;

    data_size  == SIZE_64BYTE;

    mem_attr_is_cacheable == 0;
    };
  
`protected
M,=DVTIb\ac&UT\RF,MQbCAN:4-8#-HfFaB+FR]I>:XC3:(CQL20/)U][1XC;[4[
?SYUbcR#P.E&.$
`endprotected
 
    rn_xact.addr[5:0] = 'h0;
    store_data = 'h0;
    `svt_debug("randomize_xact",$psprintf("svt_chi_rn_go_noncoherent_sequence req_success - %b \n%0s", req_success, rn_xact.sprint()));
  endtask // randomize_xact
  
  virtual task body();
    if((readnosnp_wt+writenosnpfull_wt+writenosnpptl_wt) == 0)
      `svt_fatal("body","Wight should be non zero value for atleast one Non-Coherent transaction (READNOSNP, WRITENOSNPPTL, WRITENOSNPFULL)");
    super.body();
  endtask // body

  virtual function svt_chi_rn_transaction get_xact_from_active_queue(int unsigned index);
    if(index > active_xacts.size())
      get_xact_from_active_queue = null;
    else
      get_xact_from_active_queue = active_xacts[index];
  endfunction // get_xact_from_active_queue
  
endclass

//====================================================================================
/** CHI RN transaction directed sequences */
//====================================================================================

/**
 * @groupname CHI_RN_DIRECTED
 * Abstract:
 * This class defines a sequence that sends Read type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - seq_suspend_wr_data: Control suspend_wr_data response from sequences 
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) seq_order_type:
 *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;<i>// No Ordering</i>
 *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;<i>// Request Ordering</i>
 *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;<i>// Request and End-Point Ordering</i>
 *        .
 *
 * &emsp; b) by_pass_read_data_check:
 *        - '0'   &emsp;<i>// Perform Read Data Integrity Check</i>
 *        - '1'   &emsp;<i>// Bypass Read Data Integrity Check</i>
 *        .
 *
 * &emsp; c) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate a CHI RN Read Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate a CHI RN Read Transaction targetting a specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 */

class svt_chi_rn_read_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Defines the byte enable */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable = 0;
  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id = 0;

  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;

  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 0;
  bit seq_exp_comp_ack_status;
  bit seq_suspend_comp_ack_status;
  
  bit enable_outstanding = 0;
  
  /** Flag used to bypass read data check */
  rand bit by_pass_read_data_check = 0;
  
  /** Order type for transaction  is no_ordering_required */
  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;

  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Controls using seq_is_non_secure_access or not */
  rand bit use_seq_is_non_secure_access;
  
  /** Local variables */
  int received_responses = 0;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_chi_transaction::xact_type_enum seq_xact_type;
  
  /** Handle to the read transaction sent out */
  svt_chi_rn_transaction read_tran;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }
  `endif

  constraint reasonable_coherent_load_xact_type {
`ifdef SVT_CHI_ISSUE_E_ENABLE
      seq_xact_type inside {
                          svt_chi_transaction::READSHARED, 
                          svt_chi_transaction::READONCE, 
                          svt_chi_transaction::READCLEAN, 
                          svt_chi_transaction::READUNIQUE,
                          svt_chi_transaction::READSPEC,
                          svt_chi_transaction::READNOTSHAREDDIRTY,
                          svt_chi_transaction::READPREFERUNIQUE,
                          svt_chi_transaction::READONCECLEANINVALID,
                          svt_chi_transaction::READONCEMAKEINVALID,
                          svt_chi_transaction::READNOSNP
                         };
`elsif SVT_CHI_ISSUE_B_ENABLE
    //Can't look at svt_chi_node_configuration::chi_spec_revision here as the node configuration handle is only obtained in the body()
    //The code which calls this sequence should ensure that the CHIE Read transaction types are selected only if the corresponding
    //node configuration has svt_chi_node_configuration::chi_spec_revision set to svt_chi_node_configuration::ISSUE_B
    //if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) {
      seq_xact_type inside {
                          svt_chi_transaction::READSHARED, 
                          svt_chi_transaction::READONCE, 
                          svt_chi_transaction::READCLEAN, 
                          svt_chi_transaction::READUNIQUE,
                          svt_chi_transaction::READSPEC,
                          svt_chi_transaction::READNOTSHAREDDIRTY,
                          svt_chi_transaction::READONCECLEANINVALID,
                          svt_chi_transaction::READONCEMAKEINVALID,
                          svt_chi_transaction::READNOSNP
                         };
    /*} else {
      seq_xact_type inside {
                          svt_chi_transaction::READSHARED, 
                          svt_chi_transaction::READONCE, 
                          svt_chi_transaction::READCLEAN, 
                          svt_chi_transaction::READUNIQUE,
                          svt_chi_transaction::READNOSNP,
                          svt_chi_transaction::CLEANUNIQUE
                         };
    }*/
 `else
      seq_xact_type inside {
                          svt_chi_transaction::READSHARED, 
                          svt_chi_transaction::READONCE, 
                          svt_chi_transaction::READCLEAN, 
                          svt_chi_transaction::READUNIQUE,
                          svt_chi_transaction::READNOSNP 
                         };
 `endif
  } 

  /** @endcond */
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_read_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="svt_chi_rn_read_type_transaction_directed_sequence"); 

  // -----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));
    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));
  endtask // pre_start
  
  // -----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
 
    `svt_xvm_debug("body", "Entered ...")

    if (enable_outstanding)
      track_responses();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();
    
    for(int i = 0; i < sequence_length; i++) begin
       
      /** Set up the write transaction */
      `svt_xvm_create(read_tran)
      read_tran.cfg = this.cfg;
      rand_success = read_tran.randomize() with {
        if(hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
          hn_node_idx == seq_hn_node_idx;
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
          addr >= min_addr;
          addr <= max_addr;
          `ifdef SVT_CHI_ISSUE_B_ENABLE
           if(xact_type == svt_chi_transaction::READONCEMAKEINVALID) {
             mem_attr_allocate_hint == 0;
           }
           else {    
             mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
           }
          `else
            mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          `endif
          seq_snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
        }
        
        p_crd_return_on_retry_ack ==  1'b0;
        xact_type == seq_xact_type;
        order_type == seq_order_type;
        txn_id == seq_txn_id;
        data_size == svt_chi_rn_transaction::SIZE_64BYTE;
        if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
       
        if (xact_type == svt_chi_transaction::CLEANUNIQUE){
          data == data_in_cache;
        }
      };

      `svt_xvm_debug("body", $sformatf("Sending CHI READ transaction %0s", `SVT_CHI_PRINT_PREFIX(read_tran)));
      `svt_xvm_verbose("body", $sformatf("Sending CHI READ transaction %0s", read_tran.sprint()));
      
      if(seq_exp_comp_ack_status)begin
        /** Expect CompAck field is optional for ReadOnce, ReadNoSnp, CleanShared, CleanInvalid, MakeInvalid in case of RN-I/RN-D */
        if ((cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0) &&
           ((cfg.chi_interface_type == svt_chi_node_configuration::RN_I) ||
            (cfg.chi_interface_type == svt_chi_node_configuration::RN_F) || 
            (cfg.chi_interface_type == svt_chi_node_configuration::RN_D)) 
           ) begin
          read_tran.exp_comp_ack=seq_exp_comp_ack;
        end 
      end
    
      if (read_tran.exp_comp_ack)begin
        read_tran.suspend_comp_ack = seq_suspend_comp_ack;
      end 
      
      `svt_xvm_verbose("body", $sformatf("CHI READ transaction %0s sent", read_tran.sprint()));

      /** Send the Read transaction */
      `svt_xvm_send(read_tran)
      output_xacts.push_back(read_tran);
      if (!enable_outstanding) begin
        get_response(rsp);
        // Exclude data checking for CLEANUNIQUE xact_type
        // Also for READSPEC in cases where data is not updated in the RN
        // cache
        if ((seq_xact_type != svt_chi_transaction::CLEANUNIQUE) 
            && (read_tran.is_error_response_received(0) == 0)
`ifdef SVT_CHI_ISSUE_B_ENABLE
            && (!((seq_xact_type == svt_chi_transaction::READSPEC) && 
                (read_tran.req_status == svt_chi_transaction::ACCEPT) && 
                (read_tran.data_status == svt_chi_transaction::INITIAL))
                )
`endif
           ) begin
          // Check READ DATA with data written in Cache 
          if(!by_pass_read_data_check) begin
            if (read_tran.data == data_in_cache) begin
              `svt_xvm_debug("body",{`SVT_CHI_PRINT_PREFIX(read_tran),$sformatf("DATA MATCH: Read data is same as data written to cache. Data = %0x", data_in_cache)});
            end
            else begin
              `svt_xvm_error("body",{`SVT_CHI_PRINT_PREFIX(read_tran),$sformatf("DATA MISMATCH: Read data did not match with data written in cache: GOLDEN DATA %x READ DATA %x",data_in_cache,read_tran.data)});
            end
          end
        end
      end
    end//seq_len

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  task track_responses();
    fork
    begin
      forever begin
        read_tran.wait_end();
        if (read_tran.req_status == svt_chi_transaction::RETRY) begin
          if (read_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(read_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (read_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(read_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(read_tran), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("load_directed_seq_received response. received_responses = %0d:\n",received_responses), read_tran.sprint()}));
          break;
        end
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_read_type_transaction_directed_sequence

function svt_chi_rn_read_type_transaction_directed_sequence::new(string name="svt_chi_rn_read_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction
          
//====================================================================================
/** CHI RN transaction Exclusive directed sequences */
//====================================================================================

/**
 * @groupname CHI_RN_EXCLUSIVE
 * Abstract:
 * This class defines a sequence for exclusive access support.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) seq_xact_type_excl:
 *        - svt_chi_rn_exclusive_access_sequence::RD      &emsp;&emsp;&emsp;<i>// LOAD</i>
 *        - svt_chi_rn_exclusive_access_sequence::WR      &emsp;&emsp;&emsp;<i>// STORE</i>
 *        - svt_chi_rn_exclusive_access_sequence::RD_WR   &emsp;<i>// LOAD followed by STORE</i>
 *        .
 *
 * &emsp; b) seq_order_type:
 *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;<i>// No Ordering</i>
 *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;<i>// Request Ordering</i>
 *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;<i>// Request and End-Point Ordering</i>
 *        .
 *
 * &emsp; c) by_pass_read_data_check:
 *        - '0'   &emsp;<i>// Perform Read Data Integrity Check</i>
 *        - '1'   &emsp;<i>// Bypass Read Data Integrity Check</i>
 *        .
 *
 * &emsp; d) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate Exclusive Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 *
 * &emsp; For NON-COHERENT Exclusive, the Load-Store pair <b>MUST</b> have same control signals that is memory and snoop attributes
 *     - seq_mem_attr_is_early_wr_ack_allowed  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_mem_type                 ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_is_cacheable             ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint            ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_snp_attr_is_snoopable             ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate Exclusive Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 * [4] Based on communication nodes, below sequence's properties <b>MUST</b> be programmed:
 * <br>&emsp; For RN-F Node and COHERENT Transaction
 * <br>&emsp; a) For any CHI ISSUE version:
 *        - seq_xact_type_read     !=      svt_chi_transaction::READNOSNP
 *        - !(seq_xact_type_write  inside  {svt_chi_transaction::WRITENOSNPPTL, svt_chi_transaction::WRITENOSNPFULL})
 *        .
 *
`ifdef SVT_CHI_ISSUE_B_ENABLE
 * &emsp; b) Additional Constraint for CHI ISSUE 'A':
 *        - seq_xact_type_read     !=      svt_chi_transaction::READNOTSHAREDDIRTY
 *        .
`endif
 *
`ifdef SVT_CHI_ISSUE_E_ENABLE
 * &emsp; c) Additional Constraint for CHI ISSUE 'D' or Lower:
 *        - seq_xact_type_read     !=      svt_chi_transaction::READPREFERUNIQUE
 *        - seq_xact_type_write    !=      svt_chi_transaction::MAKEREADUNIQUE
 *        .
`endif
 *
 *
 * &emsp; For RN-F Node and NON-COHERENT Transaction
 *     - seq_xact_type_read     ==      svt_chi_transaction::READNOSNP
 *     - seq_xact_type_write    inside  {svt_chi_transaction::WRITENOSNPPTL, svt_chi_transaction::WRITENOSNPFULL}
 *     .
 *
 *
 * &emsp; For RN-I or RN-D Node
 *     - seq_xact_type_read   ==      svt_chi_transaction::READNOSNP
 *     - seq_xact_type_write  inside  {svt_chi_transaction::WRITENOSNPPTL, svt_chi_transaction::WRITENOSNPFULL}
 *     .
 * <br>
 *
 *
 */

class svt_chi_rn_exclusive_access_sequence extends svt_chi_rn_transaction_base_sequence;
  
  /**
   * Control on type of exclusive transcations
   *  - RD : Exclusive Load
   *  - WR : Exclusive Store
   *  - RD_WR : Exclusive Load followed by Exclusive Store
   *  .
   */
  typedef enum {
    RD = 0,
    WR = 1,
    RD_WR = 2
  } seq_xact_type_enum;

  rand seq_xact_type_enum seq_xact_type_excl;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Defines the byte enable */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable = 0;
  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /**
   * This field defines the 'Early Write Acknowldege' field for the transaction.<br>
   * - Value of 1 indicates that Early Write Acknowledge is allowed
   * - Value of 0 indicates that Early Write Acknowledge is disallowed
   * . 
   */
  rand bit seq_mem_attr_is_early_wr_ack_allowed = 0;

  /** This field indictes the memory type associated with the transaction. */
  //rand bit seq_mem_attr_mem_type;
  rand svt_chi_transaction::mem_attr_mem_type_enum seq_mem_attr_mem_type = svt_chi_transaction::NORMAL;

  /**
   * This field defines the cacheable field of transaction.<br>
   * When set, it indicates a cacheable transaction for which the system cache, 
   * when present, must be looked up in servicing this transaction.
   */
  rand bit seq_mem_attr_is_cacheable = 0;

  /**
   * This field defines Allocate hint for the transaction.<br>
   * When set, it indicates that the transaction may allocate in the system cache, when present.
   */
  rand bit seq_mem_attr_allocate_hint = 0;

  /** This field defines if the transaction is snoopable or non-snoopable. */
  rand bit seq_snp_attr_is_snoopable = 0;

  /** This field defines the snoop domain of the transaction. */
  rand svt_chi_transaction::snp_attr_snp_domain_type_enum seq_snp_attr_snp_domain_type = svt_chi_transaction::INNER;

  /** This field defines the is non secure attribute of the transaction. */
  rand bit seq_is_non_secure_access = 0;

  /** This field determines if seq_is_non_secure_access is used to constrain transaction's is_non_secure_access field */
  rand bit use_seq_is_non_secure_access = 0;
  
  /** lpid */
  rand bit[(`SVT_CHI_LPID_WIDTH-1):0] seq_lpid = 0;
  
  /** data_size */
  rand bit[2:0] seq_data_size;
  
  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;
  
  /** Parameter that controls Suspend write */
  bit seq_suspend_wr_data = 0;

  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 0;
  
  bit enable_outstanding = 0;
  
  /** Flag used to bypass read data check */
  rand bit by_pass_read_data_check = 0;
  
  /** Order type for transaction  is no_ordering_required */
  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;

  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Local variables */
  int received_responses = 0;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_chi_transaction::xact_type_enum seq_xact_type_read;
  rand svt_chi_transaction::xact_type_enum seq_xact_type_write;
  
  /** Handle to the transaction sent out */
  svt_chi_rn_transaction transaction;

  /** Parameter that controls exclusive access bit of the transaction */
  bit seq_is_exclusive = 1;

  /** Parameter that controls the mapping of mem_attr from load to store*/
  bit bypass_mapping_of_attr = 0;

  /** Parameter that controls the p_crd_return_on_retry_ack for the load */
  bit p_crd_return_on_retry_ack_load = 0;

  /** Parameter that controls the p_crd_return_on_retry_ack for the store */
  bit p_crd_return_on_retry_ack_store = 0;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
  
  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }
  `endif

  constraint reasonable_xact_type_read {
    seq_xact_type_read inside {
                          svt_chi_transaction::READSHARED, 
                          svt_chi_transaction::READCLEAN, 
                          `ifdef SVT_CHI_ISSUE_B_ENABLE
                          svt_chi_transaction::READNOTSHAREDDIRTY,
                          `endif
                          `ifdef SVT_CHI_ISSUE_E_ENABLE
                          svt_chi_transaction::READPREFERUNIQUE,
                          `endif
                          svt_chi_transaction::READNOSNP
                         };
  }
  
  constraint valid_order_type_for_read_xact {
     if(seq_xact_type_read == svt_chi_transaction::READSHARED || 
        seq_xact_type_read == svt_chi_transaction::READCLEAN
        `ifdef SVT_CHI_ISSUE_B_ENABLE
         || seq_xact_type_read == svt_chi_transaction::READNOTSHAREDDIRTY
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
         || seq_xact_type_read == svt_chi_transaction::READPREFERUNIQUE
        `endif
       ) 
       {seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;}
  }

  constraint reasonable_xact_type_write {
    seq_xact_type_write inside {
                          svt_chi_transaction::CLEANUNIQUE,
                          `ifdef SVT_CHI_ISSUE_E_ENABLE
                          svt_chi_transaction::MAKEREADUNIQUE,
                          `endif
                          svt_chi_transaction::WRITENOSNPPTL,
                          svt_chi_transaction::WRITENOSNPFULL
                         };
  }
  
  constraint valid_order_type_for_write_xact {
     if(seq_xact_type_write == svt_chi_transaction::CLEANUNIQUE
        `ifdef SVT_CHI_ISSUE_E_ENABLE
         || seq_xact_type_write == svt_chi_transaction::MAKEREADUNIQUE
        `endif
       ) 
       {seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;}
  }
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_exclusive_access_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="svt_chi_rn_exclusive_access_sequence"); 

  // -----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    bit seq_suspend_comp_ack_status;
    bit seq_suspend_wr_data_status;
    bit seq_exp_comp_ack_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));
    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));
    seq_suspend_wr_data_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_wr_data", seq_suspend_wr_data);
    `svt_xvm_debug("body", $sformatf("seq_suspend_wr_data is %0d as a result of %0s", seq_suspend_wr_data, (seq_suspend_wr_data_status?"config DB":"default setting")));
  endtask // pre_start
  
  // -----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
    int start_idx, end_idx;
    //address of the preceding coherent read transaction
    bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] coherent_read_addr;
    //address of the preceding non coherent read transaction
    bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] readnosnp_addr;
    //data_size of the preceding non coherent read transaction
    bit [2:0] readnosnp_data_size;
    //parameters of the preceding non coherent read transaction
    bit readnosnp_mem_attr_is_early_wr_ack_allowed, readnosnp_mem_attr_mem_type, readnosnp_mem_attr_is_cacheable, readnosnp_mem_attr_allocate_hint, readnosnp_snp_attr_is_snoopable, readnosnp_snp_attr_snp_domain_type, readnosnp_is_non_secure_access;
    //used to bypass the bypass the data integrity check for the poisoned bytes
    bit by_pass_read_data_check_poisoned_bytes=0;
    
    `svt_xvm_debug("body", "Entered ...")

    if (enable_outstanding)
      track_responses();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    
    for(int i = 0; i < sequence_length; i++) begin
      case(seq_xact_type_excl)
        RD : begin   
          start_idx = 0;
          end_idx = 1;
        end
        WR : begin
          start_idx = 1;
          end_idx = 2;
        end
        RD_WR : begin
          start_idx = 0;
          end_idx = 2;
        end
      endcase

      for(int j = start_idx; j < end_idx; j++) begin
        exclusive_access_seq_sema.get();
        //if it is an exclusive store transaction and the sequence had issued an exclusive load in the previous iteration of the for loop
        //wait for the exclusive load to complete before issuing the exclusive store
        if(j && seq_xact_type_excl == svt_chi_rn_exclusive_access_sequence::RD_WR) begin
          output_xacts[0].wait_end();
          if (output_xacts[0].xact_type == svt_chi_transaction::READNOSNP && output_xacts[0].data_size != svt_chi_transaction::SIZE_64BYTE) begin
            seq_xact_type_write = svt_chi_transaction::WRITENOSNPPTL;
          end
        end
        /** Set up the transaction */
        `svt_xvm_create(transaction)
        transaction.cfg = this.cfg;
        rand_success = transaction.randomize() with {
          if(!j) {
            xact_type == seq_xact_type_read;
            if(p_crd_return_on_retry_ack_load)
              p_crd_return_on_retry_ack ==  1'b1;
            else
              p_crd_return_on_retry_ack ==  1'b0;
          }
          else {  
           xact_type == seq_xact_type_write;
            if(p_crd_return_on_retry_ack_store)
              p_crd_return_on_retry_ack ==  1'b1;
            else
              p_crd_return_on_retry_ack ==  1'b0;
          }


          if(hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE) {
            hn_node_idx == seq_hn_node_idx;
          }
          else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
              addr >= min_addr;
              addr <= max_addr;
              if (xact_type == svt_chi_transaction::READNOSNP) {
                mem_attr_is_early_wr_ack_allowed == seq_mem_attr_is_early_wr_ack_allowed; 
                mem_attr_mem_type                == seq_mem_attr_mem_type;
                mem_attr_is_cacheable            == seq_mem_attr_is_cacheable;
                mem_attr_allocate_hint           == seq_mem_attr_allocate_hint;
                snp_attr_is_snoopable            == seq_snp_attr_is_snoopable;
                snp_attr_snp_domain_type         == seq_snp_attr_snp_domain_type;
                if (use_seq_is_non_secure_access) is_non_secure_access             == seq_is_non_secure_access;
              }

          }

          order_type == seq_order_type;
          lpid       == seq_lpid;
          if(seq_is_exclusive)
            is_exclusive == 1;
          else
            is_exclusive == 0;
         
         // For non coherent transaction address, data_size, MemAttr and SnpAttr of the Exclusive store are same as that of Exclusive Load.
          if(xact_type == svt_chi_transaction::WRITENOSNPFULL || xact_type == svt_chi_transaction::WRITENOSNPPTL){
            if (seq_xact_type_excl == RD_WR) {
              mem_attr_is_early_wr_ack_allowed == readnosnp_mem_attr_is_early_wr_ack_allowed; 
              mem_attr_mem_type                == readnosnp_mem_attr_mem_type;
              mem_attr_is_cacheable            == readnosnp_mem_attr_is_cacheable;
              mem_attr_allocate_hint           == readnosnp_mem_attr_allocate_hint;
              snp_attr_is_snoopable            == readnosnp_snp_attr_is_snoopable;
              snp_attr_snp_domain_type         == readnosnp_snp_attr_snp_domain_type;
              is_non_secure_access             == readnosnp_is_non_secure_access;
              addr                             == readnosnp_addr;
              data_size                        == readnosnp_data_size;
            }
            else {
              if (seq_is_exclusive == 1 && bypass_mapping_of_attr == 0) {
                mem_attr_is_early_wr_ack_allowed == seq_mem_attr_is_early_wr_ack_allowed; 
                mem_attr_mem_type                == seq_mem_attr_mem_type;
                mem_attr_is_cacheable            == seq_mem_attr_is_cacheable;
                mem_attr_allocate_hint           == seq_mem_attr_allocate_hint;
                snp_attr_is_snoopable            == seq_snp_attr_is_snoopable;
                snp_attr_snp_domain_type         == seq_snp_attr_snp_domain_type;
                if (use_seq_is_non_secure_access) is_non_secure_access             == seq_is_non_secure_access;
                data_size                        == seq_data_size;
              }
              else {
                data_size == seq_data_size;
                if (use_seq_is_non_secure_access) is_non_secure_access             == seq_is_non_secure_access;
              }
            }
          }
          //Applicable only for coherent transaction when cache initialization is not done.
          else if((xact_type == svt_chi_transaction::CLEANUNIQUE
                  `ifdef SVT_CHI_ISSUE_E_ENABLE
                  || xact_type == svt_chi_transaction::MAKEREADUNIQUE
                  `endif
                  ) && hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE) {
              addr == coherent_read_addr;
          }
          
          /*if (!(xact_type == svt_chi_transaction::READNOSNP || xact_type == svt_chi_transaction::WRITENOSNPFULL || xact_type == svt_chi_transaction::WRITENOSNPPTL)){
            data_size == svt_chi_rn_transaction::SIZE_64BYTE;
          }*/

          if (xact_type == svt_chi_transaction::CLEANUNIQUE
              `ifdef SVT_CHI_ISSUE_E_ENABLE
              || xact_type == svt_chi_transaction::MAKEREADUNIQUE
              `endif
             ){
            data                             == data_in_cache;
            mem_attr_allocate_hint           == seq_mem_attr_allocate_hint;
            snp_attr_snp_domain_type         == seq_snp_attr_snp_domain_type;
            if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
          }

          if (xact_type == svt_chi_transaction::READCLEAN ||
              xact_type == svt_chi_transaction::READSHARED  
              `ifdef SVT_CHI_ISSUE_B_ENABLE
              || 
              (
               (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
               (xact_type == svt_chi_transaction::READNOTSHAREDDIRTY)
              )
              `endif
              `ifdef SVT_CHI_ISSUE_E_ENABLE
              || 
              (
               (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && 
               (xact_type == svt_chi_transaction::READPREFERUNIQUE)
              )
              `endif
             ) {
            mem_attr_allocate_hint           == seq_mem_attr_allocate_hint;
            snp_attr_snp_domain_type         == seq_snp_attr_snp_domain_type;
            if (use_seq_is_non_secure_access) is_non_secure_access             == seq_is_non_secure_access;
          }
        };
        
        `svt_xvm_debug("body", $sformatf("Randomization successful : %0d, Randomized transaction %0s", rand_success, `SVT_CHI_PRINT_PREFIX(transaction)));
   
        if(!j) begin
          // Parameters of Exclusive load are stored so that they can be assigned to following exclusive store for non coherent transcation.
          if (transaction.xact_type == svt_chi_transaction::READNOSNP && seq_xact_type_excl == RD_WR) begin
            readnosnp_mem_attr_is_early_wr_ack_allowed = transaction.mem_attr_is_early_wr_ack_allowed;
            readnosnp_mem_attr_mem_type                = transaction.mem_attr_mem_type;
            readnosnp_mem_attr_is_cacheable            = transaction.mem_attr_is_cacheable;
            readnosnp_mem_attr_allocate_hint           = transaction.mem_attr_allocate_hint;
            readnosnp_snp_attr_is_snoopable            = transaction.snp_attr_is_snoopable;
            readnosnp_snp_attr_snp_domain_type         = transaction.snp_attr_snp_domain_type;
            readnosnp_is_non_secure_access             = transaction.is_non_secure_access;
            readnosnp_addr                             = transaction.addr;
            readnosnp_data_size                        = transaction.data_size;
          end 

          // Address of Exclusive load is stored so that it can be assigned to following exclusive store for coherent transcation.
          else if((transaction.xact_type == svt_chi_transaction::READCLEAN || 
                   transaction.xact_type == svt_chi_transaction::READSHARED  
                   `ifdef SVT_CHI_ISSUE_B_ENABLE
                   || 
                   (
                    (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
                    (transaction.xact_type == svt_chi_transaction::READNOTSHAREDDIRTY)
                   )
                   `endif
                   `ifdef SVT_CHI_ISSUE_E_ENABLE
                   || 
                   (
                    (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && 
                    (transaction.xact_type == svt_chi_transaction::READPREFERUNIQUE)
                   )
                   `endif
                  ) && 
                  hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
                 ) begin
            coherent_read_addr = transaction.addr;
          end
          `svt_xvm_debug("body", $sformatf("xact_type is %0s, txn_id: %0d, lpid: %0d, addr: %0h", seq_xact_type_read, transaction.txn_id, transaction.lpid, transaction.addr));
        end
        else begin
          `svt_xvm_debug("body", $sformatf("xact_type is %0s, txn_id: %0d, lpid: %0d, addr: %0h", seq_xact_type_write, transaction.txn_id, transaction.lpid, transaction.addr));
        end

        `svt_xvm_debug("body", $sformatf("Sending CHI READ transaction %0s", `SVT_CHI_PRINT_PREFIX(transaction)));
      
        if ( (cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0) &&
             ((cfg.chi_interface_type == svt_chi_node_configuration::RN_I) ||
             (cfg.chi_interface_type == svt_chi_node_configuration::RN_D)) 
           ) begin
           transaction.exp_comp_ack=seq_exp_comp_ack;
        end  
    
        if (transaction.exp_comp_ack) begin
          transaction.suspend_comp_ack = seq_suspend_comp_ack;
        end 

        transaction.suspend_wr_data = seq_suspend_wr_data;
      
        /** Send the transaction */
        `svt_xvm_send(transaction)
        output_xacts.push_back(transaction);
        if (!enable_outstanding) begin
          get_response(rsp);
          // Exclude data checking for CLEANUNIQUE xact_type
          if (transaction.xact_type != svt_chi_transaction::CLEANUNIQUE
              `ifdef SVT_CHI_ISSUE_E_ENABLE
              && transaction.xact_type != svt_chi_transaction::MAKEREADUNIQUE
              `endif
              && (transaction.is_error_response_received(0) == 0)
             ) begin
            // Check READ DATA with data written in Cache 
            if(!by_pass_read_data_check) begin
              bit[7:0] transaction_data_as_byte_stream[];
              bit[7:0] data_in_cache_as_byte_stream[];
              transaction.pack_data_to_byte_stream(transaction.data,transaction_data_as_byte_stream);
              transaction.pack_data_to_byte_stream(data_in_cache,data_in_cache_as_byte_stream);
`ifdef SVT_CHI_ISSUE_B_ENABLE
  `ifdef SVT_CHI_POISON_WIDTH_ENABLE            
              if(!by_pass_read_data_check_poisoned_bytes) begin
                bit poison_mask_byte_stream[];
                    
                poison_mask_byte_stream = new[transaction_data_as_byte_stream.size()];
                /* Generating the mask to the poisned bytes */
                for(int i = 0; i < `SVT_CHI_MAX_POISON_WIDTH; i++)begin
                  for(int k=0;k<8;k++)begin
                     poison_mask_byte_stream[((i*8)+k)]= transaction.poison[i];
                  end
                end

                for (int x = (transaction_data_as_byte_stream.size()-1); x >= 0; x--) begin                  
                  /** Bypassing the datacheck for the poisoned bytes  */
                  if(poison_mask_byte_stream[x] != 1)begin
                    if (transaction_data_as_byte_stream[x] != data_in_cache_as_byte_stream[x]) begin
                      `svt_xvm_error("body",{`SVT_CHI_PRINT_PREFIX(transaction),$sformatf("DATA MISMATCH: Read data did not match with data written in cache: GOLDEN DATA %x READ DATA %x",data_in_cache,transaction.data)});
                      break;

                    end
                  end  
                  else begin
                  /** Bypassing the data comparition for the poison bytes */  
                     `svt_xvm_debug("body",{`SVT_CHI_PRINT_PREFIX(transaction),$sformatf("Bypassing the data comparision for bytes having poison value set to 1 and corresponding Cache data : 'h%0h Read data : 'h%0h",data_in_cache_as_byte_stream[x],transaction_data_as_byte_stream[x])});
                  end  
                end
              end //if(!by_pass_read_data_check_poisoned_bytes)
              else begin
  `endif                
`endif                
                if (transaction.data == data_in_cache) begin
                  `svt_xvm_debug("body",{`SVT_CHI_PRINT_PREFIX(transaction),$sformatf("DATA MATCH: Read data is same as data written to cache. Data = %0x", data_in_cache)});
                end
                else begin
                  `svt_xvm_error("body",{`SVT_CHI_PRINT_PREFIX(transaction),$sformatf("DATA MISMATCH: Read data did not match with data written in cache: GOLDEN DATA %x READ DATA %x",data_in_cache,transaction.data)});
                end
`ifdef SVT_CHI_ISSUE_B_ENABLE
  `ifdef SVT_CHI_POISON_WIDTH_ENABLE            
              end  
  `endif                
`endif                
            end//if(!by_pass_read_data_check) begin
          end//          if (transaction.xact_type != svt_chi_transaction::CLEANUNIQUE) begin
        end //        if (!enable_outstanding) begin
        exclusive_access_seq_sema.put();
      end //      for(int j = start_idx; j < end_idx; j++) begin
    end //sequence_length

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask

  task track_responses();
    fork
    begin
      forever begin
        transaction.wait_end();
        if (transaction.req_status == svt_chi_transaction::RETRY) begin
          if (transaction.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(transaction), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (transaction.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(transaction), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(transaction), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("load_directed_seq_received response. received_responses = %0d:\n",received_responses), transaction.sprint()}));
          break;
        end
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_exclusive_access_sequence

function svt_chi_rn_exclusive_access_sequence::new(string name="svt_chi_rn_exclusive_access_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
  //exclusive_access_seq_sema = new(1);
endfunction

//======================================================================================================================================================================================
/**
 * @groupname CHI_RN_DIRECTED 
 * Abstract:
 * This class defines a sequence that sends Write type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - seq_suspend_wr_data: Control suspend_wr_data response from sequences 
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) seq_order_type:
 *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;// No Ordering
 *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;// Request Ordering
 *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;// Request and End-Point Ordering
 *        .
 *
 * &emsp; b) use_seq_is_non_secure_access:
 *        - '0'   &emsp;// Do Not consider Secure/Non-Secure Address Space
 *        - '1'   &emsp;// Consider Secure/Non-Secure Address Space
 *        .
 * <br>
 *
 *
 * [2] To generate a CHI RN Write Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate a CHI RN Write Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 */

class svt_chi_rn_write_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;

  /** Transaction address */
  rand bit[(`SVT_CHI_MAX_ADDR_WIDTH-1):0] addr;

  /** Transaction ID */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id;

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** PGroupID ID */
  rand bit[(`SVT_CHI_PGROUPID_WIDTH-1):0] seq_pgroup_id;
  `endif

  /** Byte Enables */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable;
  
  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 0;

  /** Variable that controls suspend_wr_data response */
  bit seq_suspend_wr_data = 0;
  
  /** Variable that tells the status of the config_db of suspend_wr_data response */
  bit seq_suspend_wr_data_status = 0;
  
  /** Variable that controls suspend_compack response */
  bit suspend_compack = 0;

  bit seq_suspend_exp_comp_ack_status = 0;

  bit seq_exp_comp_ack_status = 0;

  svt_chi_node_configuration cfg;

  int received_responses = 0;

  svt_chi_rn_transaction write_tran;
   
  bit enable_outstanding = 0;

  rand svt_chi_transaction::xact_type_enum seq_xact_type;

  rand bit seq_copyback_req_order_enable = 0;
  
  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;
  
  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;
  rand bit use_seq_is_non_secure_access = 0;
 
  typedef enum {
    ATLEAST_ONE_DAT_FLIT_SENT = 0,
    LAST_DAT_FLIT_SENT = 1
  } seq_sel_data_flit_sent_enum;

  seq_sel_data_flit_sent_enum seq_select_data_flit_sent;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1023 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }
  `endif
 
  constraint reasonable_coherent_load_xact_type {

    `ifdef SVT_CHI_ISSUE_E_ENABLE
    if (node_cfg.cleansharedpersistsep_xact_enable == 0) {
      !(seq_xact_type inside {
                              svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP,
                              svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP,
                              svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP,
                              svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
                             });
    }
    `endif

    seq_xact_type inside {svt_chi_transaction::WRITEUNIQUEFULL, 
                          svt_chi_transaction::WRITEUNIQUEPTL,
                          `ifdef SVT_CHI_ISSUE_B_ENABLE
                          svt_chi_transaction::WRITEUNIQUEFULLSTASH,
                          svt_chi_transaction::WRITEUNIQUEPTLSTASH,
                          `endif
                          `ifdef SVT_CHI_ISSUE_E_ENABLE
                          svt_chi_transaction::WRITENOSNPZERO,
                          svt_chi_transaction::WRITEUNIQUEZERO,
                          svt_chi_transaction::WRITENOSNPFULL_CLEANSHARED,
                          svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP,
                          svt_chi_transaction::WRITENOSNPFULL_CLEANINVALID,
                          svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED,
                          svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP,
                          svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID,
                          svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHARED,
                          svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP,
                          svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED,
                          svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP,
                          `endif
                          svt_chi_transaction::WRITENOSNPFULL,
                          svt_chi_transaction::WRITENOSNPPTL};
  }

  constraint valid_order_type_for_write_xact {
     if(seq_xact_type == svt_chi_transaction::WRITEUNIQUEFULL || 
        seq_xact_type == svt_chi_transaction::WRITEUNIQUEPTL
        `ifdef SVT_CHI_ISSUE_E_ENABLE
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEZERO
        `endif
        `ifdef SVT_CHI_ISSUE_B_ENABLE
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEFULLSTASH
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEPTLSTASH
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHARED 
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED
         || seq_xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
        `endif
       ) 
       {seq_order_type != svt_chi_transaction::REQ_EP_ORDERING_REQUIRED;}
  }

  /** @endcond */

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_write_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  //-----------------------------------------------------------------------
  extern function new(string name="svt_chi_rn_write_type_transaction_directed_sequence"); 

  //-----------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    bit seq_exp_comp_ack_status;
    super.pre_start();
    raise_phase_objection();
    
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"randomization")));
    
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));
    
    seq_suspend_wr_data_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_wr_data", seq_suspend_wr_data);
    `svt_xvm_debug("body", $sformatf("seq_suspend_wr_data is %0d as a result of %0s", seq_suspend_wr_data, (seq_suspend_wr_data_status?"config DB":"randomization")));

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
  endtask
    
  //-----------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    
    `svt_xvm_debug("body", "Entered ...");
    
    if (enable_outstanding)
      track_responses();

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();

    for(int i = 0; i < sequence_length; i++) begin
      bit rand_success;
      
      /** Set up the write transaction */
      `uvm_create(write_tran)
      write_tran.cfg = this.cfg;
      rand_success = write_tran.randomize() with {
        xact_type == seq_xact_type;
        p_crd_return_on_retry_ack ==  1'b0;
        order_type == seq_order_type;
        txn_id == seq_txn_id;
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          pgroup_id == seq_pgroup_id;
        `endif
        if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
          hn_node_idx == seq_hn_node_idx;
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) 
        {
          addr >= min_addr;
          addr <= max_addr;
          mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
          if (xact_type == svt_chi_transaction::WRITEUNIQUEFULL || 
              xact_type == svt_chi_transaction::WRITEUNIQUEPTL
              `ifdef SVT_CHI_ISSUE_E_ENABLE
              || xact_type == svt_chi_transaction::WRITEUNIQUEZERO
              `endif
              `ifdef SVT_CHI_ISSUE_B_ENABLE
              || xact_type == svt_chi_transaction::WRITEUNIQUEFULLSTASH
              || xact_type == svt_chi_transaction::WRITEUNIQUEPTLSTASH
              `endif
              `ifdef SVT_CHI_ISSUE_E_ENABLE
              || xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHARED
              || xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP
              || xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED
              || xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
              `endif
             )
            snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
        }

        if (xact_type == svt_chi_transaction::WRITEUNIQUEFULL
            `ifdef SVT_CHI_ISSUE_B_ENABLE
            || xact_type == svt_chi_transaction::WRITEUNIQUEFULLSTASH
            `endif
            `ifdef SVT_CHI_ISSUE_E_ENABLE
            || xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHARED
            || xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP
            `endif
           ) 
          byte_enable == 64'hFFFF_FFFF_FFFF_FFFF;
        else if (xact_type == svt_chi_transaction::WRITENOSNPFULL  
          `ifdef SVT_CHI_ISSUE_E_ENABLE 
          || xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHARED
          || xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP
          || xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANINVALID
          `endif
          )
        {  
          byte_enable == ((1 << `SVT_CHI_MAX_BE_WIDTH)-1);
          data_size   == svt_chi_transaction::SIZE_64BYTE;
        }  
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        else if ((xact_type == svt_chi_transaction::WRITENOSNPZERO)
              || (xact_type == svt_chi_transaction::WRITEUNIQUEZERO ))
        {  
          byte_enable == 64'hFFFF_FFFF_FFFF_FFFF;
          data_size   == svt_chi_transaction::SIZE_64BYTE;
          data  == 'h0;
        }  
        `endif
        `ifdef SVT_CHI_ISSUE_B_ENABLE
          else if ((is_writedatacancel_used_for_write_xact) && 
                   ((xact_type == svt_chi_transaction::WRITEUNIQUEPTL
                    || xact_type == svt_chi_transaction::WRITEUNIQUEPTLSTASH
                    ) || 
                    ((xact_type == svt_chi_transaction::WRITENOSNPPTL) && (mem_attr_mem_type != DEVICE))
                    `ifdef SVT_CHI_ISSUE_E_ENABLE
                     || (xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED
                       || xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
                     ) ||
                     ((xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED || xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP || xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID) && (mem_attr_mem_type != DEVICE))
                    `endif
                   )
                  ){
            byte_enable  == 64'h0;
            data  == 'h0;
          }
          else if ((xact_type == svt_chi_transaction::WRITEUNIQUEPTL) || 
                   (xact_type == svt_chi_transaction::WRITEUNIQUEPTLSTASH) ||
                   (xact_type == svt_chi_transaction::WRITENOSNPPTL)
                   `ifdef SVT_CHI_ISSUE_E_ENABLE
                   || xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED
                   || xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
                   || xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED
                   || xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP
                   || xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID
                   `endif
                  ) 
            byte_enable  == 64'hAAAA_AAAA_AAAA_AAAA;
        `else
          else if ((xact_type == svt_chi_transaction::WRITEUNIQUEPTL) || 
                   (xact_type == svt_chi_transaction::WRITENOSNPPTL)
                  ) 
            byte_enable == 64'hAAAA_AAAA_AAAA_AAAA;

        `endif
      };
      
      if (write_tran.xact_type == svt_chi_rn_transaction::WRITENOSNPFULL 
        `ifdef SVT_CHI_ISSUE_E_ENABLE 
        ||write_tran.xact_type == svt_chi_rn_transaction::WRITENOSNPFULL_CLEANSHARED 
        ||write_tran.xact_type == svt_chi_rn_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP
        || write_tran.xact_type == svt_chi_rn_transaction::WRITENOSNPFULL_CLEANINVALID 
        `endif
        ) begin
        for (int j=0; j<8; j++)
          write_tran.data[64*j+:64] = 64'hdead_beef_feed_beef;
      end
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      else if ((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEZERO)||(write_tran.xact_type == svt_chi_transaction::WRITENOSNPZERO)) begin
          write_tran.data = 64'h0;
      end 
      `endif
      
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if ((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEZERO)||(write_tran.xact_type == svt_chi_transaction::WRITENOSNPZERO)) begin
         if(seq_suspend_wr_data) begin     
           `svt_error("body",$sformatf("seq_suspend_wr_data cannot be 1 for WRITEUNIQUEZERO and WRITENOSNPZERO, but it is set to 'd%d",seq_suspend_wr_data));
         end
        write_tran.suspend_wr_data = 0;
      end        
      else begin
        write_tran.suspend_wr_data = seq_suspend_wr_data;
      end        
     `else
        write_tran.suspend_wr_data = seq_suspend_wr_data;
     `endif

      /** Suspending the compack */
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if ((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEZERO)||(write_tran.xact_type == svt_chi_transaction::WRITENOSNPZERO)) begin
        if (suspend_compack) begin
           `svt_error("body",$sformatf("suspend_compack cannot be 1 for WRITEUNIQUEZERO and WRITENOSNPZERO, but it is set to 'd%d",suspend_compack));
        end        
        write_tran.exp_comp_ack = 0;
        write_tran.suspend_comp_ack = 0;
      end        
      else if(suspend_compack)begin
          write_tran.exp_comp_ack = seq_exp_comp_ack;
          write_tran.suspend_comp_ack = suspend_compack;
      end
     `else
      if(suspend_compack)begin
          write_tran.exp_comp_ack = seq_exp_comp_ack;
          write_tran.suspend_comp_ack = suspend_compack;
      end
     `endif

      /** Send the write transaction */
      `uvm_send(write_tran)
      output_xacts.push_back(write_tran);

      /** Resuming the suspended compack after wating for the last data flit
       * to transmitted onto the interface 
       */
      if(suspend_compack)begin
        `svt_note("body",$sformatf("Waiting for the req_status to be ACCEPT %s",write_tran.req_status.name()));
        `svt_debug("body",$sformatf("Waiting for the req_status to be ACCEPT"));
        if (write_tran.req_status != svt_chi_transaction::ACCEPT)
          wait (write_tran.req_status == svt_chi_transaction::ACCEPT);
        `svt_debug("body",$sformatf("Waiting for the req_status to be ACCEPT"));

        if((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEFULL)||
           ((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL ) 
         `ifdef SVT_CHI_ISSUE_B_ENABLE
           && (write_tran.is_writedatacancel_used_for_write_xact==0)
         `endif       
          )
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           || (write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHARED)
           || (write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP)
           || ((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED ||write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP ) && write_tran.is_writedatacancel_used_for_write_xact==0)
           `endif
           ) begin      
            `svt_debug("body",$sformatf("Waiting for the data_status to be ACCEPT"));
            if (write_tran.data_status != svt_chi_transaction::ACCEPT)
              wait (write_tran.data_status == svt_chi_transaction::ACCEPT);
            `svt_debug("body",$sformatf("Waiting for the data_status to be ACCEPT"));
            /** Waiting for the last data flit to transmitted onto the interface */
            if (seq_select_data_flit_sent == LAST_DAT_FLIT_SENT)
              write_tran.wait_end_last_implementation();
          
              /** Resuming the suspended Compack after the data flits are transmited onto the interface */
              `svt_debug("body",$sformatf("Resuming the suspended Compack after the data flits are transmited onto the interface"));
              write_tran.suspend_comp_ack = 0;
        end
        else if((write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL 
          `ifdef SVT_CHI_ISSUE_E_ENABLE
          || write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHARED
          || write_tran.xact_type == svt_chi_transaction::WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
          `endif
          ) 
         `ifdef SVT_CHI_ISSUE_B_ENABLE
           && (write_tran.is_writedatacancel_used_for_write_xact)
         `endif       
          ) begin
             /** Resuming the suspended Compack after the data flits are transmited onto the interface */
             `svt_debug("body",$sformatf("Resuming the suspended Compack after the data flits are transmited onto the interface"));
             write_tran.suspend_comp_ack = 0;
        end
        else begin
          `svt_error("body",$sformatf("suspended Compack is expected to be 0 but it is %0d ",write_tran.suspend_comp_ack));
        end        
      end
     
      if (!enable_outstanding)begin
        get_response(rsp);
      end  
    end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  //-----------------------------------------------------------------------
  virtual task post_body();
     
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  //-----------------------------------------------------------------------
  task track_responses();
    fork
    begin
      forever begin
        write_tran.wait_end();
        if(write_tran.req_status == svt_chi_transaction::RETRY) begin
          if (write_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(write_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (write_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(write_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(write_tran), $sformatf("transaction complete. received_responses = %0d",received_responses)}));
          `svt_xvm_debug("body", $sformatf({$sformatf("transaction complete. received_responses = %0d:\n",received_responses), write_tran.sprint()}));
          break;
        end  
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_write_type_transaction_directed_sequence

//-----------------------------------------------------------------------
function svt_chi_rn_write_type_transaction_directed_sequence::new(string name="svt_chi_rn_write_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction


/**
  * @groupname CHI_RN_DIRECTED
  * Abstract:
  * This class defines a sequence that sends CopyBack type transactions.
  * Execution phase: main_phase
  * Sequencer: RN agent sequencer
  *
  * This sequence also provides the following attributes which can be
  * controlled through config DB:
  * - sequence_length: Length of the sequence
  * - seq_suspend_wr_data: Control suspend_wr_data response from sequences 
  * - enable_outstanding: Control outstanding transactions from sequences 
  * .
  *
  *
  * <br><b>Usage Guidance::</b>
  * <br>======================================================================
  * <br>[1] General Controls
  * <br>&emsp; a) seq_order_type:
  *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;// No Ordering
  *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;// Request Ordering
  *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;// Request and End-Point Ordering
  *        .
  *
  * &emsp; b) use_seq_is_non_secure_access:
  *        - '0'   &emsp;// Do Not consider Secure/Non-Secure Address Space
  *        - '1'   &emsp;// Consider Secure/Non-Secure Address Space
  *        .
  *
  * &emsp; c) seq_copyback_req_order_enable:
  *        - '0'   &emsp;<i>// Do Not Enable Ordering</i>
  *        - '1'   &emsp;<i>// Enable Ordering</i>
  *        .
  * <br>
  *
  *
  * [2] To generate a CopyBack Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
  *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
  *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
  *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
  *     .
  * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
  * <br>
  *
  * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
  *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
  *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
  *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     .
  * <br>
  *
  *
  * [3] To generate a CopyBack Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
  *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
  *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
  *     .
  * <br>
  *
  *
  */

class svt_chi_rn_copyback_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;

  /** Transaction address */
  rand bit[(`SVT_CHI_MAX_ADDR_WIDTH-1):0] addr;

  /** Transaction ID */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id;

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** PGroupID ID */
  rand bit[(`SVT_CHI_PGROUPID_WIDTH-1):0] seq_pgroup_id;
  `endif

  /** Byte Enables */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable;

  svt_chi_node_configuration cfg;
  svt_chi_rn_transaction copyback_tran,makeunique_tran,writecleanfull_tran;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;
  rand bit use_seq_is_non_secure_access = 0;
  
  int received_responses = 0;
  
  /** Parameter that controls Suspend Wr Data bit of the transaction */
  bit seq_suspend_wr_data = 0; 

  rand bit seq_copyback_req_order_enable = 0;
  rand bit enable_outstanding = 0;

  rand svt_chi_transaction::xact_type_enum seq_xact_type;

  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;

  //-----------------------------------------------------------------------------  
  // Constraints
  //-----------------------------------------------------------------------------
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }
  `endif

  constraint reasonable_coherent_load_xact_type { 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) {
        if (node_cfg.cleansharedpersistsep_xact_enable == 0) {
          !(seq_xact_type inside {
                                  svt_chi_transaction::WRITEBACKFULL_CLEANSHAREDPERSISTSEP,
                                  svt_chi_transaction::WRITECLEANFULL_CLEANSHAREDPERSISTSEP
                                 });
        }

        seq_xact_type inside {
          svt_chi_transaction::WRITEBACKFULL, 
          svt_chi_transaction::WRITEBACKPTL, 
          svt_chi_transaction::WRITECLEANFULL, 
          svt_chi_transaction::WRITECLEANPTL,
          svt_chi_transaction::WRITEEVICTFULL,
          svt_chi_transaction::EVICT,
          svt_chi_transaction::WRITEBACKFULL_CLEANSHARED,
          svt_chi_transaction::WRITEBACKFULL_CLEANSHAREDPERSISTSEP,
          svt_chi_transaction::WRITEBACKFULL_CLEANINVALID,
          svt_chi_transaction::WRITECLEANFULL_CLEANSHARED,
          svt_chi_transaction::WRITECLEANFULL_CLEANSHAREDPERSISTSEP
         };
      }
      else {
      `endif
       seq_xact_type inside {
          svt_chi_transaction::WRITEBACKFULL, 
          svt_chi_transaction::WRITEBACKPTL, 
          svt_chi_transaction::WRITECLEANFULL, 
          svt_chi_transaction::WRITECLEANPTL,
          svt_chi_transaction::WRITEEVICTFULL,
          svt_chi_transaction::EVICT
         };
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      }
      `endif
      if (node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) {
        seq_xact_type != svt_chi_transaction::WRITECLEANPTL;
      }
  }
  /** @endcond */

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_copyback_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  //-----------------------------------------------------------------------------
  extern function new(string name="svt_chi_rn_copyback_type_transaction_directed_sequence"); 

  //-----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    bit seq_suspend_wr_data_status;
    super.pre_start();
    raise_phase_objection();
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_suspend_wr_data_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_wr_data", seq_suspend_wr_data);
    `svt_xvm_debug("body", $sformatf("seq_suspend_wr_data is %0d as a result of %0s", seq_suspend_wr_data, (seq_suspend_wr_data_status?"config DB":"default setting")));
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
  endtask
  
  //-----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success=0;

    `svt_xvm_debug("body", "Entered ...");
    
    if (enable_outstanding)
      track_responses();

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();

    for(int i = 0; i < sequence_length; i++) begin
      /** Creating and randomizing CopyBack transaction */
      `uvm_create(copyback_tran)
      copyback_tran.cfg = this.cfg;
      rand_success = copyback_tran.randomize() with {
                       xact_type == seq_xact_type;
                       txn_id == seq_txn_id;
                       `ifdef SVT_CHI_ISSUE_E_ENABLE
                         pgroup_id == seq_pgroup_id;
                       `endif
                       p_crd_return_on_retry_ack ==  1'b0;
                       order_type == seq_order_type;
                       copyback_req_order_enable == seq_copyback_req_order_enable;
                       if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
                         hn_node_idx == seq_hn_node_idx;
                       else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
                         addr >= min_addr;
                         addr <= max_addr;
                         if (seq_xact_type != svt_chi_transaction::EVICT 
                             `ifdef SVT_CHI_ISSUE_B_ENABLE
                             && seq_xact_type != svt_chi_transaction::WRITEEVICTFULL
                             `endif
                             )
                           mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
                         snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
                         if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
                       }
                     };

      if (cfg.chi_interface_type == svt_chi_node_configuration::RN_F)begin
        copyback_tran.suspend_wr_data = seq_suspend_wr_data;
      end  

      /** Firing the any CopyBack transactions from the below. 
       *    svt_chi_transaction::WRITEBACKFULL, 
       *    svt_chi_transaction::WRITEBACKPTL, 
       *    svt_chi_transaction::WRITECLEANFULL, 
       *    svt_chi_transaction::WRITECLEANPTL,
       *    svt_chi_transaction::WRITEEVICTFULL,
       *    svt_chi_transaction::EVICT 
       */
      `uvm_send(copyback_tran)
      output_xacts.push_back(copyback_tran);
      if (!enable_outstanding)
        get_response(rsp);
      
    end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  //-----------------------------------------------------------------------------
  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  //-----------------------------------------------------------------------------
  task track_responses();
    fork
    begin
      forever begin
        copyback_tran.wait_end();
        if (copyback_tran.req_status == svt_chi_transaction::RETRY) begin
          if (copyback_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(copyback_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (copyback_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(copyback_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(copyback_tran), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("received response. received_responses = %0d:\n",received_responses), copyback_tran.sprint()}));
          break;
        end
      end
    end
    join_none
  endtask

endclass: svt_chi_rn_copyback_type_transaction_directed_sequence

//-----------------------------------------------------------------------------
function svt_chi_rn_copyback_type_transaction_directed_sequence::new(string name="svt_chi_rn_copyback_type_transaction_directed_sequence");
  super.new(name);
  /** Set the response depth to -1, to accept infinite number of responses */
  this.set_response_queue_depth(-1);
endfunction

`ifdef SVT_CHI_ISSUE_E_ENABLE
/**
  * @groupname CHI_RN_DIRECTED
  * Abstract:
  * This class defines a sequence that sends WRITEEVICTOREVICT CopyBack type transaction.
  * Execution phase: main_phase
  * Sequencer: RN agent sequencer
  *
  * This sequence also provides the following attributes which can be
  * controlled through config DB:
  * - sequence_length: Length of the sequence
  * - seq_suspend_wr_data: Control to suspend_wr_data response from sequences is supported for these transactions.
  * - seq_suspend_comp_ack: Control suspend_comp_ack response from sequences is supported for these transactions.
  * - enable_outstanding: Control outstanding transactions from sequences 
  * .
  *
  *
  * <br><b>Usage Guidance::</b>
  * <br>======================================================================
  * <br>[1] General Controls
  * <br>&emsp; a) seq_order_type:
  *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;<i>// No Ordering</i>
  *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;<i>// Request Ordering</i>
  *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;<i>// Request and End-Point Ordering</i>
  *        .
  *
  * &emsp; b) use_seq_is_non_secure_access:
  *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
  *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
  *        .
  *
  * &emsp; c) seq_copyback_req_order_enable:
  *        - '0'   &emsp;<i>// Do Not Enable Ordering</i>
  *        - '1'   &emsp;<i>// Enable Ordering</i>
  *        .
  * <br>
  *
  *
  * [2] To generate a WRITEEVICTOREVICT CopyBack Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
  *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
  *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
  *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
  *     .
  * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
  * <br>
  *
  * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
  *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
  *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
  *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
  *     .
  * <br>
  *
  *
  * [3] To generate a WRITEEVICTOREVICT CopyBack Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
  *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
  *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
  *     .
  * <br>
  *
  */

class svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence extends svt_chi_rn_copyback_type_transaction_directed_sequence;

  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;

  /** Parameter that controls to program the xact_type to be sent by the RN */
  svt_chi_common_transaction::xact_type_enum user_defined_seq_xact_type = svt_chi_common_transaction::WRITEEVICTOREVICT;

  //-----------------------------------------------------------------------------  
  // Constraints
  //-----------------------------------------------------------------------------
  // order_type must be set to svt_chi_transaction::NO_ORDERING_REQUIRED for WRITEEVICTOREVICT transaction.
  constraint valid_order_type {
      seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;
  }

  // Overriding the parent class constraint to program the seq_xact_type to initiate WRITEEVICTOREVICT transaction.
  constraint reasonable_coherent_load_xact_type {
    seq_xact_type == svt_chi_transaction::WRITEEVICTOREVICT;
  }

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  //-----------------------------------------------------------------------------
  extern function new(string name="svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence"); 

  //-----------------------------------------------------------------------------
  virtual task pre_start();
    bit seq_suspend_comp_ack_status;
    super.pre_start();
    raise_phase_objection();
    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("pre_start", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));
  endtask

  //-----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success=0;
    bit user_defined_xact_type_status;

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  user_defined_xact_type_status = uvm_config_db#(svt_chi_common_transaction::xact_type_enum)::get(m_sequencer, get_type_name(), "user_defined_seq_xact_type", user_defined_seq_xact_type);
`else
  user_defined_xact_type_status = m_sequencer.get_config_int({get_type_name(), ".user_defined_seq_xact_type"}, user_defined_seq_xact_type);
`endif

  `svt_xvm_debug("body", $sformatf("user_defined_seq_xact_type is %s as a result of %0s.", user_defined_seq_xact_type.name(), user_defined_xact_type_status ? "the config DB" : "default"));
    `svt_xvm_debug("body", "Entered ...");
    
    if (enable_outstanding)
      track_responses();

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();

    for(int i = 0; i < sequence_length; i++) begin
      /** Creating and randomizing CopyBack transaction */
      `uvm_create(copyback_tran)
      copyback_tran.cfg = this.cfg;
      rand_success = copyback_tran.randomize() with {
                       if (user_defined_xact_type_status)
                       {
                         xact_type == user_defined_seq_xact_type;
                       }
                       else
                       {
                         xact_type == seq_xact_type;
                       }
                       txn_id == seq_txn_id;
                       p_crd_return_on_retry_ack ==  1'b0;
                       order_type == seq_order_type;
                       if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
                         hn_node_idx == seq_hn_node_idx;
                       else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
                         addr >= min_addr;
                         addr <= max_addr;
                         mem_attr_allocate_hint == 1;
                         snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
                       }
                     };

      copyback_tran.suspend_comp_ack = seq_suspend_comp_ack;
      copyback_tran.suspend_wr_data = seq_suspend_wr_data;

      // Firing the svt_chi_transaction::WRITEEVICTOREVICT CopyBack transaction. 
      `uvm_send(copyback_tran)
      output_xacts.push_back(copyback_tran);
      if (!enable_outstanding)
        get_response(rsp);
      
    end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

endclass: svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence

//-----------------------------------------------------------------------------
function svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence::new(string name="svt_chi_e_rn_writesoptionaldata_type_transaction_directed_sequence");
  super.new(name);
  /** Set the response depth to -1, to accept infinite number of responses */
  this.set_response_queue_depth(-1);
endfunction
`endif          

/**
 * @groupname CHI_RN_DIRECTED 
 * Abstract:
 * This class defines a sequence that sends CMO type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - seq_suspend_comp_ack: Control suspend_comp_ack response from sequences 
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate a CMO Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_snp_attr_is_snoopable     ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate a CMO Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 */

class svt_chi_rn_cmo_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Parameter that controls the enabling of transactions in non-blocking mode from the sequence */
  bit enable_outstanding = 0;

  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 0;
  
  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;

  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id = 0;
  
  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Local Variables */
  int received_responses = 0;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_chi_transaction::xact_type_enum seq_xact_type;

  /** Handle to the CMO transaction sent out */
  svt_chi_rn_transaction cmo_tran;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_snp_attr_is_snoopable = 0;
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;
  rand bit use_seq_is_non_secure_access = 0;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  constraint reasonable_coherent_load_xact_type {
    `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && node_cfg.cleansharedpersistsep_xact_enable ==1){
         seq_xact_type inside {
           svt_chi_transaction::CLEANSHAREDPERSIST, 
           svt_chi_transaction::STASHONCEUNIQUE, 
           svt_chi_transaction::STASHONCESHARED, 
           svt_chi_transaction::STASHONCESEPUNIQUE, 
           svt_chi_transaction::STASHONCESEPSHARED, 
           svt_chi_transaction::CLEANSHARED, 
           svt_chi_transaction::CLEANINVALID, 
           svt_chi_transaction::MAKEINVALID,
           svt_chi_transaction::CLEANSHAREDPERSISTSEP
         };
       }
       else if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && node_cfg.cleansharedpersistsep_xact_enable == 0){
         seq_xact_type inside {
           svt_chi_transaction::CLEANSHAREDPERSIST, 
           svt_chi_transaction::STASHONCEUNIQUE, 
           svt_chi_transaction::STASHONCESHARED, 
           svt_chi_transaction::STASHONCESEPUNIQUE, 
           svt_chi_transaction::STASHONCESEPSHARED, 
           svt_chi_transaction::CLEANSHARED, 
           svt_chi_transaction::CLEANINVALID, 
           svt_chi_transaction::MAKEINVALID
         };
       }
       else {
         seq_xact_type inside {
           svt_chi_transaction::CLEANSHAREDPERSIST, 
           svt_chi_transaction::STASHONCEUNIQUE, 
           svt_chi_transaction::STASHONCESHARED, 
           svt_chi_transaction::CLEANSHARED, 
           svt_chi_transaction::CLEANINVALID, 
           svt_chi_transaction::MAKEINVALID
         };
       }

    `elsif SVT_CHI_ISSUE_D_ENABLE
       if(node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D && node_cfg.cleansharedpersistsep_xact_enable ==1){
         seq_xact_type inside {
           svt_chi_transaction::CLEANSHAREDPERSIST, 
           svt_chi_transaction::STASHONCEUNIQUE, 
           svt_chi_transaction::STASHONCESHARED, 
           svt_chi_transaction::CLEANSHARED, 
           svt_chi_transaction::CLEANINVALID, 
           svt_chi_transaction::MAKEINVALID,
           svt_chi_transaction::CLEANSHAREDPERSISTSEP
         };
       }
       else {
         seq_xact_type inside {
           svt_chi_transaction::CLEANSHAREDPERSIST, 
           svt_chi_transaction::STASHONCEUNIQUE, 
           svt_chi_transaction::STASHONCESHARED, 
           svt_chi_transaction::CLEANSHARED, 
           svt_chi_transaction::CLEANINVALID, 
           svt_chi_transaction::MAKEINVALID
         };
       }
    `else //issue_d_enable else
      seq_xact_type inside {
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        svt_chi_transaction::CLEANSHAREDPERSIST, 
        svt_chi_transaction::STASHONCEUNIQUE, 
        svt_chi_transaction::STASHONCESHARED, 
        `endif
        svt_chi_transaction::CLEANSHARED, 
        svt_chi_transaction::CLEANINVALID, 
        svt_chi_transaction::MAKEINVALID
      };
    `endif //issue_d_enable_endif
  }
  /** @endcond */
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_cmo_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  //-----------------------------------------------------------------------------
  extern function new(string name="svt_chi_rn_cmo_type_transaction_directed_sequence"); 
 
  //-----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    bit seq_exp_comp_ack_status;
    bit seq_suspend_comp_ack_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));
    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));
  endtask
  
  //-----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
    
    `svt_xvm_debug("body", "Entered ...");
    
    if (enable_outstanding)
      track_responses();

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();
     
    for (int i = 0; i < sequence_length; i++) begin
      /** Set up the CMO transaction */
      `uvm_create(cmo_tran)
      cmo_tran.cfg = this.cfg;
      rand_success = cmo_tran.randomize() with {
        txn_id == seq_txn_id;
        xact_type             == seq_xact_type;
        p_crd_return_on_retry_ack ==  1'b0;
        if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
          hn_node_idx == seq_hn_node_idx;
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
          addr >= min_addr;
          addr <= max_addr;
          mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          snp_attr_is_snoopable == seq_snp_attr_is_snoopable;
          if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
          if (seq_snp_attr_is_snoopable)
            snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
        }
      };
      
      /** Expect CompAck field is optional for CHI Version 5.0 of CMO in case of RN-I/RN-D */
      if ((cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0) &&
           ((cfg.chi_interface_type == svt_chi_node_configuration::RN_I) ||
           (cfg.chi_interface_type == svt_chi_node_configuration::RN_D)) 
         ) begin
        cmo_tran.exp_comp_ack = seq_exp_comp_ack;
      end

      if (cmo_tran.exp_comp_ack) begin
        cmo_tran.suspend_comp_ack = seq_suspend_comp_ack;
      end

      `svt_xvm_debug("body", $sformatf("Sending CHI CMO transaction %0s", `SVT_CHI_PRINT_PREFIX(cmo_tran)));
      /** Send the CMO transaction */
      `uvm_send(cmo_tran)
      output_xacts.push_back(cmo_tran);
      if (!enable_outstanding) begin
        get_response(rsp);
      end
  end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  //-----------------------------------------------------------------------------
  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  //-----------------------------------------------------------------------------
  task track_responses();
    fork
    begin
      forever begin
        cmo_tran.wait_end();
        if (cmo_tran.req_status == svt_chi_transaction::RETRY) begin
          if (cmo_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(cmo_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (cmo_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(cmo_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(cmo_tran), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("received response. received_responses = %0d:\n",received_responses), cmo_tran.sprint()}));
          break;
        end
      end
    end
    join_none
  endtask

endclass: svt_chi_rn_cmo_type_transaction_directed_sequence

//-----------------------------------------------------------------------------
function svt_chi_rn_cmo_type_transaction_directed_sequence::new(string name="svt_chi_rn_cmo_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction
          

/**
 * @groupname CHI_RN_DIRECTED 
 * Abstract:
 * Sends MAKEUNIQUE transactions from an RN
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - seq_suspend_comp_ack: Control Suspend CompAck bit of the transaction
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate a MakeUnique Cache Initialization Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 *
 * [3] To generate a MakeUnique Cache Initialization Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * &emsp; If there is requirement to generate unique address, then additionaly below sequence's property to programmed as per below:
 *     - set_unique_addr_value  == 1 
 *     .
 * <br>
 *
 */

class svt_chi_rn_makeunique_cache_initialization_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;

  /** Transaction address */
  rand bit[(`SVT_CHI_MAX_ADDR_WIDTH-1):0] addr;
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id;
 
  rand bit set_unique_addr_value;

  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;
  
  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 0;

  svt_chi_rn_transaction write_tran;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;

  /** Controls propagating seq_is_no_secure_access to xact's is_non_secure_access field */
  rand bit use_seq_is_non_secure_access = 0;
  
  /** */
  svt_chi_node_configuration cfg;

  int received_responses = 0;
   
  bit enable_outstanding = 0;
  
  /** @endcond */

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_makeunique_cache_initialization_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  //-----------------------------------------------------------------------
  extern function new(string name="svt_chi_rn_makeunique_cache_initialization_directed_sequence"); 

  //-----------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit seq_exp_comp_ack_status;
    bit seq_suspend_comp_ack_status;
    bit enable_outstanding_status;
    super.pre_start();
    raise_phase_objection();
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));

    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
  endtask
  
  //-----------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    
    int txn_id = 0;
    `svt_xvm_debug("body", "Entered ...");

    if (enable_outstanding)
      track_responses();

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end

    for(int i = 0; i < sequence_length; i++) begin
      bit rand_success;

      /** Set up the write transaction */
      `uvm_create(write_tran)
      write_tran.cfg = this.cfg;
      rand_success = write_tran.randomize() with {
        xact_type == svt_chi_rn_transaction::MAKEUNIQUE;
        txn_id == seq_txn_id;
        p_crd_return_on_retry_ack ==  1'b0;
        data == data_in_cache;
        if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
        if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE) {
          hn_node_idx == seq_hn_node_idx;
          if(set_unique_addr_value) {
            unique {addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6]};
          }
        }
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
          addr >= min_addr;
          addr <= max_addr;
          mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
        }
      };
      
      write_tran.suspend_comp_ack = seq_suspend_comp_ack;
      /** Send the write transaction */
      `uvm_send(write_tran)
      `svt_xvm_debug("MAKEUNIQUE", $sformatf("xact_type after randomizing is %s ", write_tran.xact_type.name()));  
      output_xacts.push_back(write_tran);
      get_response(rsp);
    end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  //-----------------------------------------------------------------------
  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  //-----------------------------------------------------------------------
  task track_responses();
    fork
    begin
      forever begin
        get_response(rsp);
        received_responses++;
        `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(rsp), $sformatf("received response. received_responses = %0d",received_responses)}));
        `svt_xvm_verbose("body", $sformatf({$sformatf("received response. received_responses = %0d:\n",received_responses), rsp.sprint()}));
      end
    end
    join_none
  endtask

endclass: svt_chi_rn_makeunique_cache_initialization_directed_sequence

//-----------------------------------------------------------------------
function svt_chi_rn_makeunique_cache_initialization_directed_sequence::new(string name="svt_chi_rn_makeunique_cache_initialization_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction

/** @cond PRIVATE */  
/** 
 * svt_chi_rn_transaction_random_sequence
 *
 * This sequence creates a random svt_chi_rn_transaction request.
 */
class svt_chi_rn_transaction_auto_read_sequence extends svt_chi_rn_transaction_base_sequence; 
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_rn_transaction_auto_read_sequence) 
  
  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;

  /** 
   * Controls generating non-coherent reads for coherent write locations and coherent reads for 
   * non-coherent writes. Basically, snoopable reads will be used in place of non-snoopable and
   * vice versa in a cyclic manner for the number of iterations set. This needs to be set through
   * config DB. This must be 0 when svt_chi_node_configuration::enable_domain_based_addr_gen = 1.
   */
  int num_iterations_swap_snoopable_nonsnoopable_autoreads = 0;

  /**
   * When #num_iterations_swap_snoopable_nonsnoopable_autoreads is greater than 0, 
   * iteration, this flag alternates between 1 and 0 in cyclic manner. 
   */
  bit swap_snoopable_nonsnoopable_autoreads = 0;
  
  /**
   * Constructs the svt_chi_rn_transaction_auto_read_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_rn_transaction_auto_read_sequence");

  /** 
   * Executes the svt_chi_rn_transaction_auto_read_sequence sequence. 
   */
  extern virtual task body();
  extern virtual task post_body();
  extern virtual task pre_start();

  /** 
   * Calls `svt_xvm_do_with to send the transction.  By default only the xact_type
   * is constrained, but extended sequences can override this method to add other
   * constraints.
   */
  extern virtual task send_auto_read_transaction(svt_chi_rn_transaction write_req,svt_chi_rn_transaction read_req, int iteration = 0);

  /**
   * Sends a CleanInvalid CMO before sending the ReadOnce Auto read transaction 
   * to make sure that the cache line state is I before initiating the ReadOnce.
   */
  extern virtual task send_cmo_transaction(svt_chi_rn_transaction write_req,svt_chi_rn_transaction cmo_req);  
endclass
/** @endcond */
//------------------------------------------------------------------------------
function svt_chi_rn_transaction_auto_read_sequence::new(string name = "svt_chi_rn_transaction_auto_read_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_auto_read_sequence::pre_start();
  bit status;
  super.pre_start();
  raise_phase_objection();
`ifdef SVT_UVM_TECHNOLOGY
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "num_iterations_swap_snoopable_nonsnoopable_autoreads", num_iterations_swap_snoopable_nonsnoopable_autoreads);
`else
  status = m_sequencer.get_config_int({get_type_name(), ".num_iterations_swap_snoopable_nonsnoopable_autoreads"}, num_iterations_swap_snoopable_nonsnoopable_autoreads);
`endif
  `svt_xvm_debug("body", $sformatf("num_iterations_swap_snoopable_nonsnoopable_autoreads is %0d as a result of %0s.", num_iterations_swap_snoopable_nonsnoopable_autoreads, status ? "the config DB" : "the default value"));

endtask // pre_start
//------------------------------------------------------------------------------
task svt_chi_rn_transaction_auto_read_sequence::post_body();
  super.post_body();
  drop_phase_objection();
endtask
//------------------------------------------------------------------------------
task svt_chi_rn_transaction_auto_read_sequence::body();
  svt_chi_rn_transaction req;
  int enable_non_blocking_status;
  svt_chi_rn_transaction req_sent[$];
  
  super.body();
 
 `svt_xvm_debug("body", "Running sequence  svt_chi_rn_transaction_auto_read_sequence");
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  get_rn_virt_seqr();

  if ((node_cfg.enable_domain_based_addr_gen == 1) && 
      (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0)) begin
    num_iterations_swap_snoopable_nonsnoopable_autoreads = 0;
    `svt_xvm_debug("body", $sformatf("num_iterations_swap_snoopable_nonsnoopable_autoreads is set to %0d. As svt_chi_node_configuration::enable_domain_based_addr_gen = 1 for this RN, overwriting num_iterations_swap_snoopable_nonsnoopable_autoreads to 0.", num_iterations_swap_snoopable_nonsnoopable_autoreads));
  end

  
  if(enable_non_blocking)
    sink_responses();
  
  while (1) begin
    int i;


    svt_chi_rn_transaction write_req,read_req,cmo_req;
    
    if (p_sequencer.auto_read_get_port.try_get(write_req)) begin
      for (i=0; i<=num_iterations_swap_snoopable_nonsnoopable_autoreads; i++) begin
        bit send_auto_read = 1;
        bit send_cmo_before_auto_read = 1;

        if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
          if ((i%2) == 0)
            swap_snoopable_nonsnoopable_autoreads = 1;
          else if ((i%2) == 1)
            swap_snoopable_nonsnoopable_autoreads = 0;
        end
        else begin
          swap_snoopable_nonsnoopable_autoreads = 0;
        end
        
        `svt_xvm_debug("body",{`SVT_CHI_PRINT_PREFIX(write_req), "Received auto-read transaction in sequence"});
        `svt_xvm_create(read_req);
        read_req.cfg = write_req.cfg;
        
        // Send a CleanInvalid CMO to the same address of the write transaction
        // if :
        // - it's not a non-coherent Write
        // - the master is RN-F and the line is present in it's cache
        // This is neded as we will send ReadOnce
        // later, which needs the initial cache line state as I.
        if (
            (write_req.xact_type != svt_chi_transaction::WRITENOSNPFULL) &&
`ifdef SVT_CHI_ISSUE_E_ENABLE            
            ((node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && (write_req.xact_type != svt_chi_transaction::WRITENOSNPZERO && write_req.xact_type != svt_chi_transaction::WRITENOSNPFULL_CLEANSHARED && write_req.xact_type != svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP &&  write_req.xact_type != svt_chi_transaction::WRITENOSNPFULL_CLEANINVALID &&  write_req.xact_type != svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID &&  write_req.xact_type != svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED &&  write_req.xact_type != svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP)) &&
`endif
            (write_req.xact_type != svt_chi_transaction::WRITENOSNPPTL) &&
            (swap_snoopable_nonsnoopable_autoreads == 0)
          
            ) begin
          bit cache_line_addr_status = 0;
          bit is_unique = 0;
          bit is_clean = 0;
          
          if ((node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F) &&
              (my_cache != null)) 
            cache_line_addr_status = my_cache.get_status(write_req.get_aligned_addr_to_cache_line_size(1), is_unique, is_clean);


          // If the cache line initial state is I, no CMO needs to be sent.
          // If the cache line initial state is Dirty, no need to perform Read. So no CMO needs to be sent.
          if ((cache_line_addr_status == 0) ||
              (is_clean == 0)) begin
            send_cmo_before_auto_read = 0;
            if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
              `svt_xvm_debug("body", {$sformatf("auto-read sequence: iteration = %0d. swap_snoopable_nonsnoopable_autoreads = %0b. Corresponding to the address of the Write type request: ", i, swap_snoopable_nonsnoopable_autoreads),`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. No need to send CMO to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
            else begin
              `svt_xvm_debug("body", {"auto-read sequence: Corresponding to the address of the Write type request: ",`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. No need to send CMO to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
          end

          if ((cache_line_addr_status == 1) &&
              (is_clean == 0)) begin
            send_auto_read = 0;
            if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
              `svt_xvm_debug("body", {$sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. Corresponding to the address of the Write type request: ", i, swap_snoopable_nonsnoopable_autoreads),`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. No need to send Auto-read to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
            else begin
              `svt_xvm_debug("body", {"auto-read sequence: Corresponding to the address of the Write type request: ",`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. No need to send Auto-read to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
          end

          if (send_cmo_before_auto_read) begin
            if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
              `svt_xvm_debug("body", {$sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. Corresponding to the address of the Write type request: ", i, swap_snoopable_nonsnoopable_autoreads),`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. Need to send CMO to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
            else begin
              `svt_xvm_debug("body", {"auto-read sequence: Corresponding to the address of the Write type request: ",`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("Current cache line status: %0s cache line address status %0b. is_unique %0b. is_clean %0b. Need to send CMO to same address", node_cfg.chi_interface_type.name(), cache_line_addr_status, is_unique, is_clean)});
            end
            `svt_xvm_create(cmo_req);
            cmo_req.cfg = write_req.cfg;

            send_cmo_transaction(write_req,cmo_req);
            if (!enable_non_blocking) begin
              get_response(rsp);
              if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
                `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(cmo_req), $sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. CMO transaction before Auto-read transaction completed corresponding to %0s...", i, swap_snoopable_nonsnoopable_autoreads, `SVT_CHI_PRINT_PREFIX(write_req))});
              end
              else begin
                `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(cmo_req), $sformatf("auto-read sequence: CMO transaction before Auto-read transaction completed corresponding to %0s...", `SVT_CHI_PRINT_PREFIX(write_req))});
              end
            end
            else 
              req_sent.push_back(cmo_req);
          end
        end
        else begin
          if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
            `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(write_req), $sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. Not required to send CMO transaction before Auto-read transaction", i, swap_snoopable_nonsnoopable_autoreads)});
          end
          else begin
            `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(write_req), "auto-read sequence: Not required to send CMO transaction before Auto-read transaction"});
          end

        end

        if (send_auto_read) begin
          send_auto_read_transaction(write_req,read_req, i);

          if (!enable_non_blocking) begin
            get_response(rsp);
            if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
              `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(read_req), $sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. Auto-read transaction completed corresponding to %0s. ...", i, swap_snoopable_nonsnoopable_autoreads, `SVT_CHI_PRINT_PREFIX(write_req))});
            end
            else begin
              `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(read_req), $sformatf("Auto-read transaction completed corresponding to %0s. ...", `SVT_CHI_PRINT_PREFIX(write_req))});
            end
          end
          else 
            req_sent.push_back(read_req);
        end
        
      end // for (i=0; i<=enable_swap_snoopable_nonsnoopable_autoreads; i++)
    end // if (p_sequencer.auto_read_get_port.try_get(write_req))
    else
      break;
  end // while (1)
  

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_sent[i]), "transaction sent from Auto_read sequence completed..."});
    end
  end // if (enable_non_blocking)
  `svt_xvm_debug("body",{ "All auto-read transactions are complete"});
endtask

//------------------------------------------------------------------------------
task svt_chi_rn_transaction_auto_read_sequence::send_cmo_transaction(svt_chi_rn_transaction write_req, svt_chi_rn_transaction cmo_req);

  bit rand_success;
  rand_success = cmo_req.randomize() with {
    addr == write_req.addr;
    xact_type == svt_chi_rn_transaction::CLEANINVALID;
    p_crd_return_on_retry_ack == 0;
    is_non_secure_access == write_req.is_non_secure_access;
    mem_attr_allocate_hint == write_req.mem_attr_allocate_hint;
    mem_attr_is_cacheable == write_req.mem_attr_is_cacheable;
    snp_attr_snp_domain_type == write_req.snp_attr_snp_domain_type;
    snp_attr_is_snoopable == write_req.snp_attr_is_snoopable;
  };

  if (rand_success) begin
    `svt_xvm_send(cmo_req);
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(cmo_req), "Sent CMO transaction before auto-read transaction. Waiting for CMO to complete..."});
  end 
 
endtask // send_cmo_transaction
  
//------------------------------------------------------------------------------
task svt_chi_rn_transaction_auto_read_sequence::send_auto_read_transaction(svt_chi_rn_transaction write_req,svt_chi_rn_transaction read_req, int iteration = 0);
  bit rand_success, is_targeted_to_hn_f;
  int hn_idx = -1;
  `ifdef SVT_AMBA_MULTI_CHIP_SYSTEM_MONITOR_INTERNAL_ENABLE
  if(!write_req.cfg.sys_cfg.multi_chip_system_monitor_enable || (write_req.cfg.sys_cfg.get_extern_chip_ra_idx(write_req.addr)==-1))
  `endif
    hn_idx= write_req.cfg.sys_cfg.get_hn_idx(write_req.addr);
  if (hn_idx > 0) 
    is_targeted_to_hn_f = (write_req.cfg.sys_cfg.get_hn_interface_type(hn_idx) == svt_chi_address_configuration::HN_F);
  
  rand_success = read_req.randomize() with {
      // Following attributes can be forced with same values
      // as that of the write
      addr == write_req.addr;
      is_non_secure_access == write_req.is_non_secure_access;
      mem_attr_allocate_hint == write_req.mem_attr_allocate_hint;

      // Non exclusive type, no ordering, don't return credits on retry
      is_exclusive == 0;
      order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;
      p_crd_return_on_retry_ack == 0;

      if (swap_snoopable_nonsnoopable_autoreads == 0)
      {
        if (
             (write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE            
            ((node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && (write_req.xact_type == svt_chi_transaction::WRITENOSNPZERO ||  write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHARED ||  write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP || write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANINVALID || write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID ||  write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED ||  write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP)) ||
`endif
             (write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL) 
           )
          xact_type == svt_chi_transaction::READNOSNP;
        else
          xact_type == svt_chi_transaction::READONCE;
      }
      else
      {
        if (
             (write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE            
            ((node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && (write_req.xact_type == svt_chi_transaction::WRITENOSNPZERO || write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHARED || write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANSHAREDPERSISTSEP || write_req.xact_type == svt_chi_transaction::WRITENOSNPFULL_CLEANINVALID || write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANINVALID || write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHARED ||  write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL_CLEANSHAREDPERSISTSEP)) ||
`endif
             (write_req.xact_type == svt_chi_transaction::WRITENOSNPPTL) 
           )
        {
          if (is_targeted_to_hn_f == 1)
          {
            xact_type == svt_chi_transaction::READONCE;
          }
          else
          {
            xact_type == svt_chi_transaction::READNOSNP;
          }
        }               
        else
        { 
          xact_type == svt_chi_transaction::READNOSNP;
        }
      }                                     
    
      // READONCE is always 64 bytes. So, for ReadNosnp:
      // set data_size, mem_attr same as that of write.
      if (xact_type == svt_chi_transaction::READNOSNP)
      {
        data_size == write_req.data_size;
        mem_attr_mem_type == write_req.mem_attr_mem_type;
        if (swap_snoopable_nonsnoopable_autoreads == 0) 
        {        
          mem_attr_is_cacheable == write_req.mem_attr_is_cacheable;
          if (write_req.mem_attr_mem_type == svt_chi_transaction::NORMAL)
            mem_attr_is_early_wr_ack_allowed == write_req.mem_attr_is_early_wr_ack_allowed;
        }
      }
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(write_req.req_tag_op != svt_chi_transaction::TAG_INVALID) {
          req_tag_op == svt_chi_transaction::TAG_TRANSFER;
        }
      `endif

      // Propagate snoop domain for snoopable xacts (ReadOnce)
      if (write_req.snp_attr_is_snoopable &&
          (swap_snoopable_nonsnoopable_autoreads == 0))
      {
        snp_attr_snp_domain_type == write_req.snp_attr_snp_domain_type;
        snp_attr_is_snoopable == write_req.snp_attr_is_snoopable;
      }    

  };
  if (rand_success) begin
    `svt_xvm_send(read_req);
    if (num_iterations_swap_snoopable_nonsnoopable_autoreads > 0) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(read_req), $sformatf("auto-read sequence: iteration %0d: swap_snoopable_nonsnoopable_autoreads = %0b. Sent auto-read transaction corresponding to %0s. Waiting to complete...", iteration, swap_snoopable_nonsnoopable_autoreads, `SVT_CHI_PRINT_PREFIX(write_req))});
    end
    else begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(read_req), $sformatf("auto-read sequence: Sent auto-read transaction corresponding to %0s. Waiting to complete...", `SVT_CHI_PRINT_PREFIX(write_req))});
    end
  end
endtask

/**
 * Abstract:
 * chi_rn_barrier_directed_sequence is used by test to provide initiator
 * scenario information to the RN agent present in the System Env.
 * This class defines a sequence in which a CHI WRITE followed by a CHI READ
 * sequence is generated by assigning values to the transactions rather than
 * randomization, and then transmitted using `uvm_send.
 *
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */
`ifndef GUARD_CHI_RN_BARRIER_DIRECTED_SEQUENCE_SV
`define GUARD_CHI_RN_BARRIER_DIRECTED_SEQUENCE_SV

class chi_rn_barrier_directed_sequence extends svt_chi_rn_transaction_base_sequence;
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;
  bit enable_outstanding = 1;

  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] txn_id = 0;

  rand svt_chi_transaction::xact_type_enum xact_type;

  int received_responses = 0;
  /** Handle to the Barrier transaction sent out */
  svt_chi_rn_transaction barrier_tran;
  svt_chi_node_configuration cfg;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1023 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
      if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
        txn_id inside {[0:1023]};
      }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
      }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
      }
  }
  `endif

  /** Constrain the xact_type */
  constraint reasonable_barrier_xact_type {
    xact_type inside {svt_chi_transaction::EOBARRIER, 
                      svt_chi_transaction::ECBARRIER};
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(chi_rn_barrier_directed_sequence)

  /** Constructor */
  function new(string name="chi_rn_barrier_directed_sequence");
    super.new(name);
    //Set the response depth to -1, to accept infinite number of responses
    this.set_response_queue_depth(-1);
  endfunction

  /** pre_body */
  virtual task pre_body();
    raise_phase_objection();
  endtask:pre_body

  /** The body() task is the actual logic of the sequence */
  virtual task body();
    svt_configuration get_cfg;
    bit status;
    bit enable_outstanding_status;

   `uvm_info("body", "Entered....", UVM_HIGH);
    
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end

    enable_outstanding_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `uvm_info("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")), UVM_HIGH);
    
    /** Send Barrier Transactions */
    `uvm_create(barrier_tran)
    barrier_tran.cfg = this.cfg;
    barrier_tran.xact_type = xact_type;
    barrier_tran.txn_id = txn_id;
    barrier_tran.data_size = svt_chi_rn_transaction::SIZE_1BYTE;
    barrier_tran.addr = 0;
    barrier_tran.is_likely_shared = 1'b0;
    barrier_tran.p_crd_return_on_retry_ack =  1'b0;
    barrier_tran.order_type = svt_chi_rn_transaction::NO_ORDERING_REQUIRED;
    barrier_tran.mem_attr_allocate_hint = 1'b0;
    barrier_tran.mem_attr_is_cacheable = 1'b0;
    barrier_tran.mem_attr_mem_type = svt_chi_rn_transaction::NORMAL;
    barrier_tran.snp_attr_is_snoopable = 1'b0;
    barrier_tran.snp_attr_snp_domain_type = svt_chi_transaction::INNER;
    barrier_tran.is_exclusive = 1'b0;
    barrier_tran.exp_comp_ack = 1'b0;
    `uvm_info("body", {" Sending ", `SVT_CHI_PRINT_PREFIX(barrier_tran)} , UVM_HIGH);
    `uvm_send(barrier_tran)
    if(!enable_outstanding)
      get_response(rsp);
    else
      track_responses();

    `uvm_info("body", "Exiting...", UVM_HIGH);
  endtask:body
  
  /** post_body() task */
  virtual task post_body();
    if (enable_outstanding) 
      wait(received_responses == 1);
    drop_phase_objection();
  endtask:post_body

  task track_responses();
    fork
      begin
        `uvm_info("post_body", {"Waiting for all responses to be received", `SVT_CHI_PRINT_PREFIX(barrier_tran)}, UVM_HIGH);
        wait ((barrier_tran.req_status == svt_chi_transaction::ABORTED) ||
              (barrier_tran.req_status == svt_chi_transaction::ACCEPT));

        if (barrier_tran.req_status == svt_chi_transaction::ACCEPT) begin
          barrier_tran.wait_end();
        end
        `uvm_info("post_body", {"Received all responses. Dropping objections", `SVT_CHI_PRINT_PREFIX(barrier_tran)}, UVM_HIGH);

        received_responses = 1;
      end // fork begin
      join_none
  endtask // track_responses
  

endclass:chi_rn_barrier_directed_sequence

`endif // GUARD_CHI_RN_BARRIER_DIRECTED_SEQUENCE_SV  

/**
 * Abstract:
 * chi_rn_noncoherent_transaction_base_sequence defines a sequence through which
 * non coherent transactions can be sent.
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_CHI_RN_NONCOHERENT_TRANSACTION_BASE_SEQUENCE_SV
`define GUARD_CHI_RN_NONCOHERENT_TRANSACTION_BASE_SEQUENCE_SV

class chi_rn_noncoherent_transaction_base_sequence extends svt_chi_rn_coherent_transaction_base_sequence;
  rand int seq_req_order_stream_id = 0;
  `svt_xvm_object_utils(chi_rn_noncoherent_transaction_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  function new(string name = "chi_rn_directed_noncoherent_xact_sequence");
    super.new(name);
  endfunction // new


  virtual task body();
    svt_configuration cfg;

    `svt_xvm_debug("body","chi_rn_directed_noncoherent_xact_sequence");

    if(node_cfg == null) begin
      /** Obtain a handle to the rn node configuration */
      p_sequencer.get_cfg(cfg);
      if (cfg == null || !$cast(node_cfg, cfg)) begin
        `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
    if (seq_req_order_stream_id >= node_cfg.num_req_order_streams)
      seq_req_order_stream_id = $urandom_range(node_cfg.num_req_order_streams-1, 0);
    
    /*disable_all_weights();
    assign_xact_weights(xact_type);
    generate_transactions();*/
    super.body();
    `svt_xvm_debug("body","exiting chi_rn_directed_noncoherent_xact_sequence");
  endtask // body

/** Randomizes a single transaction based on the weights assigned.  If
 * randomized_with_directed_addr is set, the transaction is randomized with
 * the address specified in directed_addr
 */
task randomize_xact(svt_chi_rn_transaction           rn_xact,
                    bit                              randomize_with_directed_addr, 
                    bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] directed_addr,
                    bit                              directed_snp_attr_is_snoopable,
                    svt_chi_common_transaction::snp_attr_snp_domain_type_enum directed_snp_attr_snp_domain_type,
                    bit                              directed_mem_attr_allocate_hint,
                    bit                              directed_is_non_secure_access,
                    bit                              directed_allocate_in_cache,
                    svt_chi_common_transaction::data_size_enum directed_data_size, 
                    bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] directed_data,
                    bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] directed_byte_enable,
                    output bit                       req_success,
                    input  int                       sequence_index = 0,
                    input  bit                       gen_uniq_txn_id = 0);
  bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] _end_addr_for_sequential_addr_mode = 0;
  
  // Get config from corresponding sequencer and assign it here.
  rn_xact.cfg      = node_cfg;

  `svt_debug("randomize_xact",$psprintf("readnosnp_wt        = %d",readnosnp_wt       ));       
  `svt_debug("randomize_xact",$psprintf("writenosnpfull_wt   = %d",writenosnpfull_wt  ));  
  `svt_debug("randomize_xact",$psprintf("writenosnpptl_wt    = %d",writenosnpptl_wt   ));   
  
  _end_addr_for_sequential_addr_mode = (end_addr - ((sequence_length-1) * node_cfg.cache_line_size));
  req_success = rn_xact.randomize() with 
  { 
    xact_type dist {
                    svt_chi_common_transaction::READNOSNP       := readnosnp_wt,       
                    svt_chi_common_transaction::WRITENOSNPFULL  := writenosnpfull_wt,  
                    svt_chi_common_transaction::WRITENOSNPPTL   := writenosnpptl_wt   
                    };

    order_type == seq_order_type;

    req_order_stream_id == seq_req_order_stream_id;
   
    // If directed address is enabled, that gets priority.
    // Otherwise, decided based on addr_mode. If addr_mode
    // is TARGET_HN_INDEX, no need to constrain the address,
    // but need to constrain the hn_node_index. Proceed 
    // further for other types of addr_mode based on the
    // intended functionality.
    if (randomize_with_directed_addr) {
      addr == directed_addr;
      if(use_directed_mem_attr) {
        mem_attr_allocate_hint == directed_mem_attr_allocate_hint;
      }
      if(use_directed_non_secure_access) {
        is_non_secure_access == directed_is_non_secure_access;
      }
      `ifndef SVT_CHI_ISSUE_B_ENABLE
        if(directed_snp_attr_is_snoopable && use_directed_snp_attr) snp_attr_snp_domain_type == directed_snp_attr_snp_domain_type;
      `endif
    }
    else if (addr_mode == TARGET_HN_INDEX)
    {
      hn_node_idx == seq_hn_node_idx;
    }
    else  if ((addr_mode == SEQUENTIAL_OVERLAPPED_ADDRESS) ||
              (addr_mode == SEQUENTIAL_NONOVERLAPPED_ADDRESS)) 
    {
      if (sequence_index == 0)
        addr inside {[start_addr:_end_addr_for_sequential_addr_mode]};
      else
        addr == (_previous_xact_addr + node_cfg.cache_line_size);
    }
    else if (addr_mode == RANDOM_ADDRESS_IN_RANGE) { 
      addr inside {[start_addr:end_addr]};
    }
    else if (addr_mode != RANDOM_ADDRESS) {
      if (addr_mode != IGNORE_ADDRESSING_MODE) { 
        addr inside {[start_addr:end_addr]};
`protected
b8P)7UN<M;#ZGPeN726Y^NDc[HadaI@QF?IATY<L(M&(bEMcgYV6.)IO74R\ed89
KM<ePR,N=)ccA\WKPd.V>4Dc2$
`endprotected
 
        addr[5:0] == 'h0;
      }
      else { 
        addr[5:0] == 'h0;
      }
    }
  };

  if(req_success == 1)
     _previous_xact_addr = rn_xact.addr;

cache_active_rn_xacts.push_back(rn_xact);
  `svt_debug("randomize_xact",$psprintf("req_success - %b", req_success));
  `svt_verbose("randomize_xact", rn_xact.sprint());
endtask // randomize_xact
  
endclass // chi_rn_noncoherent_transaction_base_sequence

`endif //GUARD_CHI_RN_NONCOHERENT_TRANSACTION_BASE_SEQUENCE_SV

/**
 * Abstract:
 * chi_rn_directed_noncoherent_xact_sequence defines a sequence through which
 * non coherent transactions can be sent.
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_CHI_RN_DIRECTED_NONCOHERENT_XACT_SEQUENCE_SV
`define GUARD_CHI_RN_DIRECTED_NONCOHERENT_XACT_SEQUENCE_SV

class chi_rn_directed_noncoherent_xact_sequence extends svt_chi_rn_transaction_base_sequence;
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] txn_id = 0;

  bit enable_outstanding = 1;

  svt_chi_node_configuration cfg;

  int received_responses = 0;

  rand svt_chi_transaction::xact_type_enum xact_type;

  rand svt_chi_transaction::mem_attr_mem_type_enum mem_type;

  rand bit is_cacheable = 0;

  rand bit requires_go_before_barrier = 1;

  rand bit is_barrier_associated = 0;
  
  svt_chi_transaction associated_barrier_xact = null;

  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;
  
  rand int seq_req_order_stream_id = 0;
  
  /** Handle to the read transaction sent out */
  svt_chi_rn_transaction seq_xact;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1023 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
      if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
        txn_id inside {[0:1023]};
      }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
      }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
      if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
        txn_id inside {[0:255]};
      }
  }
  `endif

  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }
  `endif

  constraint reasonable_coherent_load_xact_type {
    xact_type inside {svt_chi_transaction::WRITENOSNPFULL, 
                      svt_chi_transaction::READNOSNP};
  }

  constraint reasonable_mem_type {
    mem_type inside {svt_chi_transaction::DEVICE, svt_chi_transaction::NORMAL};
 }

  /** UVM Object Utility macro */
  `uvm_object_utils(chi_rn_directed_noncoherent_xact_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="chi_rn_directed_noncoherent_xact_sequence"); 

  virtual task pre_body();
    raise_phase_objection();
  endtask

  virtual task body();
    svt_configuration get_cfg;
    bit status;
    bit enable_outstanding_status;
    
    `uvm_info("body", "Entered ...", UVM_HIGH)

    enable_outstanding_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `uvm_info("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")), UVM_HIGH);

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end

    if (seq_req_order_stream_id >= cfg.num_req_order_streams)
      seq_req_order_stream_id = $urandom_range(cfg.num_req_order_streams-1, 0);
    
    /** Set up the write transaction */
    `uvm_create(seq_xact)
    seq_xact.cfg = this.cfg;

    void'(seq_xact.randomize() with {
      txn_id == local::txn_id;
      xact_type  == local::xact_type;
      data_size == svt_chi_rn_transaction::SIZE_64BYTE;
      addr      == local::addr;
      snp_attr_is_snoopable == 1'b0;
      is_likely_shared == 1'b0;
      mem_attr_is_early_wr_ack_allowed == 1'b1;
      mem_attr_is_cacheable == is_cacheable;
      mem_attr_mem_type == mem_type;
      mem_attr_allocate_hint == 0;
      requires_go_before_barrier == local::requires_go_before_barrier;
      order_type == seq_order_type;
      req_order_stream_id == seq_req_order_stream_id;
    });


    /*seq_xact.cfg = this.cfg;
    seq_xact.txn_id = txn_id;
    seq_xact.xact_type  = xact_type;
    seq_xact.data_size = svt_chi_rn_transaction::SIZE_64BYTE;
    seq_xact.addr         = addr;
    seq_xact.exp_comp_ack = 1'b0;
    seq_xact.snp_attr_is_snoopable = 1'b0;
    seq_xact.is_likely_shared = 1'b0;
    seq_xact.mem_attr_is_early_wr_ack_allowed = 1'b1;
    seq_xact.mem_attr_is_cacheable = is_cacheable;
    seq_xact.mem_attr_mem_type = mem_type;
    seq_xact.mem_attr_allocate_hint = 0;
    seq_xact.requires_go_before_barrier = requires_go_before_barrier;
    if ((xact_type == svt_chi_transaction::READNOSNP) &&
        (cfg.chi_interface_type == svt_chi_node_configuration::RN_F)) begin
      seq_xact.exp_comp_ack = 1;
    end
    seq_xact.order_type = seq_order_type;
    seq_xact.req_order_stream_id = seq_req_order_stream_id;*/
    
    if (xact_type == svt_chi_rn_transaction::WRITENOSNPFULL) begin
      seq_xact.byte_enable = ((1 << `SVT_CHI_MAX_BE_WIDTH)-1);
      for (int j=0; j<8; j++)
        seq_xact.data[64*j+:64] = 64'hdead_beef_feed_beef;

      // Construct dat_rsvdc to accomodate for the number of Tx DAT
      // flits associated to this transaction and then setup the values.
      seq_xact.dat_rsvdc = new[seq_xact.compute_num_dat_flits()];
      foreach (seq_xact.dat_rsvdc[idx])
        seq_xact.dat_rsvdc[idx] = (idx+1);      
    end

    if (is_barrier_associated) begin
      seq_xact.associated_barrier_xact = associated_barrier_xact;
    end
    else begin
      seq_xact.associated_barrier_xact = null;
    end
    
    `uvm_info("body", {"Sending ", `SVT_CHI_PRINT_PREFIX(seq_xact), $sformatf("(mem_type = %0s, requires_go = %0b%0s)", mem_type.name(), requires_go_before_barrier, 
                                                                              (is_barrier_associated?{", associated_barrier_xact ", `SVT_CHI_PRINT_PREFIX(associated_barrier_xact)}:""))} , UVM_HIGH);
    /** Send the transaction */
    `uvm_send(seq_xact)
    if (!enable_outstanding) 
      get_response(rsp);
    else
      track_responses();

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask: body

   /** post_body() task */
  virtual task post_body();
    if (enable_outstanding) 
      wait(received_responses == 1);
    drop_phase_objection();
  endtask:post_body 

  task track_responses();
    fork
      begin
        `uvm_info("post_body", {"Waiting for all responses to be received", `SVT_CHI_PRINT_PREFIX(seq_xact)}, UVM_HIGH);
        wait ((seq_xact.req_status == svt_chi_transaction::ABORTED) ||
              (seq_xact.req_status == svt_chi_transaction::ACCEPT));

        if (seq_xact.req_status == svt_chi_transaction::ACCEPT) begin
          seq_xact.wait_end();
        end
        `uvm_info("post_body", {"Received all responses. Dropping objections", `SVT_CHI_PRINT_PREFIX(seq_xact)}, UVM_HIGH);

        received_responses = 1;
      end // fork begin
    join_none
  endtask // track_responses
  //   
endclass: chi_rn_directed_noncoherent_xact_sequence

function chi_rn_directed_noncoherent_xact_sequence::new(string name="chi_rn_directed_noncoherent_xact_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction

`ifdef SVT_CHI_ISSUE_B_ENABLE
//====================================================================================
/** CHI RN transaction directed sequences */
//====================================================================================

/**
 * @groupname CHI_RN_DIRECTED
 * Abstract:
 * This class defines a sequence that sends Atomic type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) seq_order_type:
 *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;<i>// No Ordering</i>
 *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;<i>// Request Ordering</i>
 *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;<i>// Request and End-Point Ordering</i>
 *        .
 *
 * &emsp; b) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate an Atomic Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate an Atomic Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 */

class svt_chi_rn_atomic_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Defines the byte enable */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable = 0;
  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /** Variable that controls suspend_wr_data response */
  bit seq_suspend_wr_data = 0;

  /** Variable that tells the status of the config_db of suspend_wr_data response */
  bit seq_suspend_wr_data_status = 0;

  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id = 0;

  bit enable_outstanding = 0;
  
  /** Order type for transaction  is no_ordering_required */
  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;
  rand bit use_seq_is_non_secure_access = 0;
  
  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Local variables */
  int received_responses = 0;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_chi_transaction::xact_type_enum seq_xact_type;
  
  /** Handle to the read transaction sent out */
  svt_chi_rn_transaction atomic_tran;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif
  
  constraint valid_order_type {
      seq_order_type != svt_chi_transaction::REQ_ACCEPTED;
  }

  constraint reasonable_atomic_xact_type {
    //node configuration has svt_chi_node_configuration::chi_spec_revision set to svt_chi_node_configuration::ISSUE_B
    //if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B)
      seq_xact_type inside {
                          svt_chi_common_transaction::ATOMICSTORE_ADD,
                          svt_chi_common_transaction::ATOMICSTORE_CLR,
                          svt_chi_common_transaction::ATOMICSTORE_EOR,
                          svt_chi_common_transaction::ATOMICSTORE_SET,
                          svt_chi_common_transaction::ATOMICSTORE_SMAX,
                          svt_chi_common_transaction::ATOMICSTORE_SMIN,
                          svt_chi_common_transaction::ATOMICSTORE_UMAX,
                          svt_chi_common_transaction::ATOMICSTORE_UMIN,
                          svt_chi_common_transaction::ATOMICLOAD_ADD,
                          svt_chi_common_transaction::ATOMICLOAD_CLR,
                          svt_chi_common_transaction::ATOMICLOAD_EOR,
                          svt_chi_common_transaction::ATOMICLOAD_SET,
                          svt_chi_common_transaction::ATOMICLOAD_SMAX,
                          svt_chi_common_transaction::ATOMICLOAD_SMIN,
                          svt_chi_common_transaction::ATOMICLOAD_UMAX,
                          svt_chi_common_transaction::ATOMICLOAD_UMIN,
                          svt_chi_common_transaction::ATOMICSWAP,
                          svt_chi_common_transaction::ATOMICCOMPARE
                         };
  } 

  /** @endcond */
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_atomic_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="svt_chi_rn_atomic_type_transaction_directed_sequence"); 

  // -----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_suspend_wr_data_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_wr_data", seq_suspend_wr_data);
    `svt_xvm_debug("body", $sformatf("seq_suspend_wr_data is %0d as a result of %0s", seq_suspend_wr_data, (seq_suspend_wr_data_status?"config DB":"randomization")));
  endtask // pre_start
  
  // -----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
 
    `svt_xvm_debug("body", "Entered ...")

    if (enable_outstanding)
      track_responses();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();
    
    `svt_xvm_debug("body", $sformatf("sequence_length = %0d and enable_outstanding is %0d",sequence_length, enable_outstanding));
    for(int i = 0; i < sequence_length; i++) begin
       
      /** Set up the write transaction */
      `svt_xvm_create(atomic_tran)
      atomic_tran.cfg = this.cfg;
      rand_success = atomic_tran.randomize() with {
        if(hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
          hn_node_idx == seq_hn_node_idx;
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
          addr >= min_addr;
          addr <= max_addr;
          mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          seq_snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
          if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
        }
        
        p_crd_return_on_retry_ack ==  1'b0;
        xact_type == seq_xact_type;
        snoopme == seq_snoopme;
        endian == seq_endian;
        order_type == seq_order_type;
        txn_id == seq_txn_id;
      };
      atomic_tran.suspend_wr_data = seq_suspend_wr_data;

      `svt_xvm_debug("body", $sformatf("Sending CHI ATOMIC transaction %0s", `SVT_CHI_PRINT_PREFIX(atomic_tran)));
      `svt_xvm_verbose("body", $sformatf("Sending CHI ATOMIC transaction %0s", atomic_tran.sprint()));

      /** Send the Read transaction */
      `svt_xvm_send(atomic_tran)
      output_xacts.push_back(atomic_tran);
      if (!enable_outstanding) begin
        get_response(rsp);
      end
    end//seq_len

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  task track_responses();
    fork
    begin
      forever begin
        atomic_tran.wait_end();
        if (atomic_tran.req_status == svt_chi_transaction::RETRY) begin
          if (atomic_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(atomic_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (atomic_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(atomic_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(atomic_tran), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("load_directed_seq_received response. received_responses = %0d:\n",received_responses), atomic_tran.sprint()}));
          break;
        end
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_atomic_type_transaction_directed_sequence

function svt_chi_rn_atomic_type_transaction_directed_sequence::new(string name="svt_chi_rn_atomic_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction

/**
 * @groupname CHI_RN_DIRECTED
 * Abstract:
 * This class defines a sequence that sends Prefetchtgt type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] To generate a PrefetchTgt Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 *
 * [2] To generate a PrefetchTgt Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate a PrefetchTgt Transaction targetting with respect to prior Write/Read Transaction's Address, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>Address of prior executed write or read transaction</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>Address of prior executed write or read transaction</i></font>
 *     .
 * <br>
 *
 *
 */
class svt_chi_rn_prefetchtgt_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Defines the byte enable */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable = 0;
  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id = 0;

  bit enable_outstanding = 0;
  
  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Local variables */
  int received_responses = 0;
  
  /** Handle to the prefetchtgt transaction sent out */
  svt_chi_rn_transaction prefetchtgt_tran;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
  
  /** @endcond */
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_prefetchtgt_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="svt_chi_rn_prefetchtgt_type_transaction_directed_sequence"); 

  // -----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
  endtask // pre_start
  
  // -----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
 
    `svt_xvm_debug("body", "Entered ...")

    if (enable_outstanding)
      track_responses();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();
    
    for(int i = 0; i < sequence_length; i++) begin
      /** Set up the Prefetchtgt transaction */
      `svt_xvm_create(prefetchtgt_tran)
      prefetchtgt_tran.cfg = this.cfg;
      rand_success = prefetchtgt_tran.randomize() with {
      addr >= min_addr;
      addr <= max_addr;              
      xact_type  == svt_chi_rn_transaction::PREFETCHTGT;
      txn_id     == seq_txn_id;
      };  
      `svt_xvm_debug("body", $sformatf("Sending CHI PREFETCH transaction %0s", `SVT_CHI_PRINT_PREFIX(prefetchtgt_tran)));
      `svt_xvm_verbose("body", $sformatf("Sending CHI PREFETCH transaction %0s", prefetchtgt_tran.sprint()));
      
      /** Send the Read transaction */
      `svt_xvm_send(prefetchtgt_tran)
      output_xacts.push_back(prefetchtgt_tran);
      if (!enable_outstanding) begin
        get_response(rsp);
      end
    end //seq_len

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  task track_responses();
    fork
    begin
      forever begin
        prefetchtgt_tran.wait_end();
        received_responses++;
        `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(prefetchtgt_tran), "transaction complete"}));
        `svt_xvm_verbose("body", $sformatf({$sformatf("load_directed_seq_received response. received_responses = %0d:\n",received_responses), prefetchtgt_tran.sprint()}));
        break;
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_prefetchtgt_type_transaction_directed_sequence

function svt_chi_rn_prefetchtgt_type_transaction_directed_sequence::new(string name="svt_chi_rn_prefetchtgt_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction
`endif // `ifdef SVT_CHI_ISSUE_B_ENABLE

`endif // GUARD_CHI_RN_DIRECTED_NONCOHERENT_XACT_SEQUENCE_SV

`ifdef SVT_CHI_ISSUE_E_ENABLE
/**
 * @groupname CHI_RN_DIRECTED
 * Abstract:
 * This class defines a sequence that sends MakeReadUnique type transactions.
 * Execution phase: main_phase
 * Sequencer: RN agent sequencer
 *
 * This sequence also provides the following attributes which can be
 * controlled through config DB:
 * - sequence_length: Length of the sequence
 * - seq_exp_comp_ack: Control Expect CompAck bit of the transaction from sequences
 * - enable_outstanding: Control outstanding transactions from sequences 
 * .
 *
 *
 * <br><b>Usage Guidance::</b>
 * <br>======================================================================
 * <br>[1] General Controls
 * <br>&emsp; a) seq_order_type:
 *        - svt_chi_transaction::NO_ORDERING_REQUIRED      &emsp;&emsp;&emsp;&emsp;<i>// No Ordering</i>
 *        - svt_chi_transaction::REQ_ORDERING_REQUIRED     &emsp;&emsp;&emsp;<i>// Request Ordering</i>
 *        - svt_chi_transaction::REQ_EP_ORDERING_REQUIRED  &emsp;<i>// Request and End-Point Ordering</i>
 *        .
 *
 * &emsp; b) by_pass_read_data_check:
 *        - '0'   &emsp;<i>// Perform Read Data Integrity Check</i>
 *        - '1'   &emsp;<i>// Bypass Read Data Integrity Check</i>
 *        .
 *
 * &emsp; c) use_seq_is_non_secure_access:
 *        - '0'   &emsp;<i>// Do Not consider Secure/Non-Secure Address Space</i>
 *        - '1'   &emsp;<i>// Consider Secure/Non-Secure Address Space</i>
 *        .
 * <br>
 *
 *
 * [2] To generate a MakeReadUnique Transaction targetting specific address range, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE
 *     - min_addr           ---->  <font color="#1A41A8"><i>To control the lower value for the range of address</i></font>
 *     - max_addr           ---->  <font color="#1A41A8"><i>To control the upper value for the range of address</i></font>
 *     .
 * &emsp; In case of targetting a specific address, <b><i>min_addr</i></b> and <b><i>max_addr</i></b> must be programmed to same value
 * <br>
 *
 * &emsp; If there are any prior transactions targetting a specific cache line, ensure subsequent transactions have same attributes wherever required
 *     - min_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - max_addr                      ---->  <font color="#1A41A8"><i>Address of prior executed transaction</i></font>
 *     - seq_snp_attr_snp_domain_type  ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_mem_attr_allocate_hint    ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     - seq_is_non_secure_access      ---->  <font color="#1A41A8"><i>Same property value from prior executed transaction</i></font>
 *     .
 * <br>
 *
 *
 * [3] To generate a MakeReadUnique Transaction targetting specific HN Node, the below sequence's properties <b>MUST</b> be programmed:
 *     - hn_addr_rand_type  ---->  svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE
 *     - seq_hn_node_idx    ---->  <font color="#1A41A8"><i>Targetted hn_node index</i></font>
 *     .
 * <br>
 *
 *
 */
class svt_chi_rn_makereadunique_type_transaction_directed_sequence extends svt_chi_rn_transaction_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** @cond PRIVATE */  
  /** Defines the byte enable */
  rand bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] byte_enable = 0;
  
  /** Stores the data written in Cache */
  rand bit [511:0]   data_in_cache;
  
  /** Transaction address */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0]   addr; 
  
  /** Transaction txn_id */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] seq_txn_id = 0;

  /** Parameter that controls Suspend CompAck bit of the transaction */
  bit seq_suspend_comp_ack = 0;

  /** Parameter that controls Expect CompAck bit of the transaction */
  bit seq_exp_comp_ack = 1;
  bit seq_exp_comp_ack_status;
  bit seq_suspend_comp_ack_status;
  
  bit enable_outstanding = 0;
  
  /** Flag used to bypass read data check */
  rand bit by_pass_read_data_check = 0;
  
  /** Order type for transaction  is no_ordering_required */
  rand svt_chi_transaction::order_type_enum seq_order_type = svt_chi_transaction::NO_ORDERING_REQUIRED;

  /** Parameter that controls the MemAttr and SnpAttr of the transaction */
  rand bit seq_mem_attr_allocate_hint = 0;
  rand bit seq_snp_attr_snp_domain_type = 0;
  rand bit seq_is_non_secure_access = 0;

  /** Handle to CHI Node configuration */
  svt_chi_node_configuration cfg;

  /** Controls using seq_is_non_secure_access or not */
  rand bit use_seq_is_non_secure_access;
  
  /** Local variables */
  int received_responses = 0;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_chi_transaction::xact_type_enum seq_xact_type;
  
  /** Handle to the read transaction sent out */
  svt_chi_rn_transaction makereadunique_tran;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (node_cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         seq_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (node_cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         seq_txn_id inside {[0:255]};
       }
  }
  `endif

  constraint valid_order_type {
      seq_order_type == svt_chi_transaction::NO_ORDERING_REQUIRED;
  }

  constraint reasonable_coherent_load_xact_type {
      seq_xact_type inside {svt_chi_transaction::MAKEREADUNIQUE};
  } 

  /** @endcond */
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_chi_rn_makereadunique_type_transaction_directed_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  extern function new(string name="svt_chi_rn_makereadunique_type_transaction_directed_sequence"); 

  // -----------------------------------------------------------------------------
  virtual task pre_start();
    bit status;
    bit enable_outstanding_status;
    super.pre_start();
    raise_phase_objection();
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));
    enable_outstanding_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_outstanding", enable_outstanding);
    `svt_xvm_debug("body", $sformatf("enable_outstanding is %0d as a result of %0s", enable_outstanding, (enable_outstanding_status?"config DB":"default setting")));
    seq_exp_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_exp_comp_ack", seq_exp_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_exp_comp_ack is %0d as a result of %0s", seq_exp_comp_ack, (seq_exp_comp_ack_status?"config DB":"default setting")));
    seq_suspend_comp_ack_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_suspend_comp_ack", seq_suspend_comp_ack);
    `svt_xvm_debug("body", $sformatf("seq_suspend_comp_ack is %0d as a result of %0s", seq_suspend_comp_ack, (seq_suspend_comp_ack_status?"config DB":"default setting")));
  endtask // pre_start
  
  // -----------------------------------------------------------------------------
  virtual task body();
    svt_configuration get_cfg;
    bit rand_success;
 
    `svt_xvm_debug("body", "Entered ...")

    if (enable_outstanding)
      track_responses();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end
    get_rn_virt_seqr();
    
    for(int i = 0; i < sequence_length; i++) begin
       
      /** Set up the write transaction */
      `svt_xvm_create(makereadunique_tran)
      makereadunique_tran.cfg = this.cfg;
      rand_success = makereadunique_tran.randomize() with {
        if(hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_HN_NODE_IDX_RAND_TYPE)
          hn_node_idx == seq_hn_node_idx;
        else if (hn_addr_rand_type == svt_chi_rn_transaction_base_sequence::DIRECTED_ADDR_RANGE_RAND_TYPE) {
          addr >= min_addr;
          addr <= max_addr;
          mem_attr_allocate_hint == seq_mem_attr_allocate_hint;
          seq_snp_attr_snp_domain_type == seq_snp_attr_snp_domain_type;
        }
        
        p_crd_return_on_retry_ack ==  1'b0;
        xact_type == seq_xact_type;
        order_type == seq_order_type;
        txn_id == seq_txn_id;
        data_size == svt_chi_rn_transaction::SIZE_64BYTE;
        if (use_seq_is_non_secure_access) is_non_secure_access == seq_is_non_secure_access;
       
      };

      `svt_xvm_debug("body", $sformatf("Sending CHI MAKEREADUNIQUE transaction %0s", `SVT_CHI_PRINT_PREFIX(makereadunique_tran)));
      `svt_xvm_verbose("body", $sformatf("Sending CHI MAKEREADUNIQUE transaction %0s", makereadunique_tran.sprint()));
      
      if (makereadunique_tran.exp_comp_ack)begin
        makereadunique_tran.suspend_comp_ack = seq_suspend_comp_ack;
      end 
      
      `svt_xvm_verbose("body", $sformatf("CHI MAKEREADUNIQUE transaction %0s sent", makereadunique_tran.sprint()));

      /** Send the Read transaction */
      `svt_xvm_send(makereadunique_tran)
      output_xacts.push_back(makereadunique_tran);
      if (!enable_outstanding) begin
        get_response(rsp);
        // Exclude data checking for CLEANUNIQUE xact_type
        // Also for READSPEC in cases where data is not updated in the RN
        // cache
        if ((seq_xact_type != svt_chi_transaction::CLEANUNIQUE) 
            && (makereadunique_tran.is_error_response_received(0) == 0)
`ifdef SVT_CHI_ISSUE_B_ENABLE
            && (!((seq_xact_type == svt_chi_transaction::READSPEC) && 
                (makereadunique_tran.req_status == svt_chi_transaction::ACCEPT) && 
                (makereadunique_tran.data_status == svt_chi_transaction::INITIAL))
                )
`endif
           ) begin
           // Check MAKEREADUNIQUE DATA with data written in Cache 
           if ((!by_pass_read_data_check) && (makereadunique_tran.has_data_transfer == 1) && (makereadunique_tran.allocate_in_cache == 0) && (makereadunique_tran.data_status == svt_chi_transaction::ACCEPT)) begin
             if (makereadunique_tran.makereadunique_read_data == data_in_cache) begin
               `svt_xvm_debug("body",{`SVT_CHI_PRINT_PREFIX(makereadunique_tran),$sformatf("DATA MATCH: Read data is same as data written to cache. Data = %0x", data_in_cache)});
             end
             else begin
               `svt_xvm_error("body",{`SVT_CHI_PRINT_PREFIX(makereadunique_tran),$sformatf("DATA MISMATCH: Read data did not match with data written in cache: GOLDEN DATA %x READ DATA %x",data_in_cache,makereadunique_tran.data)});
             end
           end
        end
      end
    end//seq_len

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual task post_body();
    if (enable_outstanding) begin
      `svt_xvm_debug("body", "Waiting for all responses to be received");
      wait (received_responses == sequence_length);
      `svt_xvm_debug("body", "Received all responses. Dropping objections");
    end
    drop_phase_objection();
  endtask

  task track_responses();
    fork
    begin
      forever begin
        makereadunique_tran.wait_end();
        if (makereadunique_tran.req_status == svt_chi_transaction::RETRY) begin
          if (makereadunique_tran.p_crd_return_on_retry_ack == 0) begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(makereadunique_tran), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
            wait (makereadunique_tran.req_status == svt_chi_transaction::ACTIVE);
          end
          else begin
            `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(makereadunique_tran), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
          end
        end
        else begin
          received_responses++;
          `svt_xvm_debug("body", $sformatf({`SVT_CHI_PRINT_PREFIX(makereadunique_tran), "transaction complete"}));
          `svt_xvm_verbose("body", $sformatf({$sformatf("load_directed_seq_received response. received_responses = %0d:\n",received_responses), makereadunique_tran.sprint()}));
          break;
        end
      end//forever
    end
    join_none
  endtask

endclass: svt_chi_rn_makereadunique_type_transaction_directed_sequence

function svt_chi_rn_makereadunique_type_transaction_directed_sequence::new(string name="svt_chi_rn_makereadunique_type_transaction_directed_sequence");
  super.new(name);
  //Set the response depth to -1, to accept infinite number of responses
  this.set_response_queue_depth(-1);
endfunction
`endif //SVT_CHI_ISSUE_E_ENABLE


`ifndef SVT_EXCLUDE_VCAP          
/** @cond PRIVATE */
/** 
 * This sequence executes the traffic profile in its m_traffic_profile property
 * 
 * The traffic profile is not randomized before being sent to the sequencer.
 */
class svt_chi_traffic_profile_profile_dispatch_seq extends svt_sequence;

  /** The traffic profile transaction to execute */
  svt_chi_traffic_profile_transaction m_traffic_profile;

  `svt_xvm_declare_p_sequencer(svt_chi_rn_traffic_profile_sequencer)

  `svt_xvm_object_utils_begin(svt_chi_traffic_profile_profile_dispatch_seq)
  `svt_field_object(m_traffic_profile, `SVT_XVM_ALL_ON, `SVT_HOW_REF)
  `svt_xvm_object_utils_end

  extern function new(string name="svt_chi_traffic_profile_profile_dispatch_seq");

  virtual task pre_body();
    raise_phase_objection();
  endtask

  virtual task body();
    `svt_xvm_send(m_traffic_profile);
  endtask: body

  virtual task post_body();
    drop_phase_objection();
  endtask

  virtual function bit is_applicable(svt_configuration cfg);
    return 0;
  endfunction : is_applicable
endclass 

`protected
9/OL,K(g&3Z+)]A?9@f+_:B>CP572:ZWR#fBSUbQ=eO\cFLfWN@f6)\TM(5Qc&G&
?ZXBf:QP23e75Q#E87[@2H68_+(&(D66U[X_))M2RRDP<VfdFRgbCeB(/L+;9?ED
U@=JR,@Pa,dZ#/4Y1CAeIHST_UBN3#9;UJgC2\>gU522W5d7e<Q0L1,SaMDb1BLF
d&AbR<U<c[?1>N5277-Xa3c[#&)0TNaf_UeF>Z5=]3I_cMPC3eUa3Neb@@MW4QR7
G1V-0U7@,ULa^2Nf]I<0QHc[4$
`endprotected


/**
 * This is a layering sequence that accepts transactions of type
 * svt_chi_traffic_profile_transaction and converts them to transactions
 * of type svt_chi_rn_transaction. There is a one to many relationship between
 * the traffic profile transaction and CHI protocol transactions, so one
 * traffic profile transaction may be converted to more than one CHI protocol
 * transactions. 
 * This sequence is not expected to be used directly by users. It is used internally
 * by the VIP when svt_chi_node_configuration::use_traffic_profile is set
 */
class svt_chi_rn_traffic_profile_sequence extends svt_chi_rn_transaction_base_sequence;
 
  `svt_xvm_object_utils(svt_chi_rn_traffic_profile_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_transaction_sequencer)

  /** Handle to the master agent */
  local  svt_chi_rn_agent my_agent;

  /** Semaphore for acess to sequencer */
  semaphore seqr_sema;

  /** Semaphore for acess to the active queue*/
  semaphore active_xact_queue_sema;

  /** Queue of active transactions */
  svt_chi_rn_transaction active_xact_queue[$];

  svt_chi_node_configuration cfg;

  /** Class Constructor */
  function new(string name="svt_chi_rn_traffic_profile_sequence");
    super.new(name);
    seqr_sema = new(1);
    active_xact_queue_sema = new(1);
  endfunction

  /** UVM sequence body task */ 
  virtual task body();
    `SVT_XVM(component)               my_component;

    /** Handles for configurations. */
    svt_configuration get_cfg;

    int traffic_profile_object_num = 0;
   
    super.body();

    my_component = p_sequencer.get_parent();
    void'($cast(my_agent,my_component)); 

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class");
    end

   
    // This is a forever loop. It is put in a fork-join_none because
    // the base class raises and drops objection in pre_body and post_body
    // So we must exit this sequence 
    fork
    begin
      forever begin
        svt_chi_traffic_profile_transaction chi_traffic_profile_xact;
        p_sequencer.traffic_profile_seq_item_port.get(chi_traffic_profile_xact);
        // Callback used to modify the contents of traffic profile
        `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,post_traffic_profile_seq_item_port_get(chi_traffic_profile_xact))
        if (chi_traffic_profile_xact.cfg == null)
          chi_traffic_profile_xact.cfg = this.cfg;

        if (chi_traffic_profile_xact.is_valid(0)) begin
          send_chi_traffic_profile(chi_traffic_profile_xact,traffic_profile_object_num);
        end
        else begin
          `svt_xvm_error("body", $sformatf("Received CHI traffic profile transaction is not a valid transaction. Xact: %0s", chi_traffic_profile_xact.`SVT_DATA_PSDISPLAY()));
        end
        traffic_profile_object_num++;
      end
    end
    join_none
  endtask

  /** Converts the received AXI traffic profile transaction to AXI protocol transactions
    * and sends it to the driver
    */
  task send_chi_traffic_profile(svt_chi_traffic_profile_transaction chi_traffic_profile_xact, int traffic_profile_object_num);

    /** Value of ID that will be assigned to the current transaction */
    bit[`SVT_CHI_TXN_ID_WIDTH-1:0] curr_id = '1;

    /** Last value of data used */
    bit[`SVT_CHI_MAX_DATA_WIDTH-1:0] last_data = '1;

    /** Value of data that will be assigned to the current transaction */
    bit[`SVT_CHI_MAX_DATA_WIDTH-1:0] curr_data[];

    /** Value of address that will be assigned to the current transaction */
    bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] curr_addr = '1;

    /** Base address of the current block of address if the pattern used is TWODIM*/
    bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] two_dim_base_addr = 0;

    /** Burst length of transactions generated */
    int num_transfers;

    /** Burst size of transactions generated */
    int chi_data_size;

    /** Handle to the FIFO rate control class for WRITE xacts */
    svt_chi_fifo_rate_control write_xact_fifo_rate_control;

    /** Handle to the FIFO rate control class for READ xacts*/
    svt_chi_fifo_rate_control read_xact_fifo_rate_control; 
 
    /*num_transfers = (chi_traffic_profile_xact.xact_size/8)/(cfg.flit_data_width/8);

    // This happens when xact_size is less than data_width
    if (num_transfers == 0) begin
      num_transfers = 1;
      data_size = cfg.log_base_2(chi_traffic_profile_xact.xact_size/8);
    end
    else
      data_size = cfg.log_base_2(cfg.data_width/8);
      */
    // TBD: Check this. During testing xact_size was changed to 512 bits
    // Need to check if xact_size is in bits or bytes. It should be in 
    // bytes
    chi_data_size = cfg.log_base_2(chi_traffic_profile_xact.xact_size/8);

    `svt_xvm_debug("send_chi_traffic_profile", $sformatf("Converting traffic profile transaction %0d (handle: %0d. profile_name: %0s. group_name: %0s) to AXI transactions. node_id: %0d.  data_width = %0d. xact_size: %0d. total_num_bytes: %0d. num_transfers = %0d %0s.", traffic_profile_object_num, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, chi_traffic_profile_xact.group_name, cfg.node_id, cfg.flit_data_width, chi_traffic_profile_xact.xact_size, chi_traffic_profile_xact.total_num_bytes, num_transfers , chi_traffic_profile_xact.`SVT_DATA_PSDISPLAY()));

    two_dim_base_addr = chi_traffic_profile_xact.base_addr;
    track_output_events(chi_traffic_profile_xact);

    if (chi_traffic_profile_xact.write_fifo_cfg != null) begin
      real rate_divisor = 1000/cfg.clock_period;
      write_xact_fifo_rate_control = new({chi_traffic_profile_xact.profile_name,":write_xact_fifo_rate_control"});
      write_xact_fifo_rate_control.rate_divisor = rate_divisor;
      write_xact_fifo_rate_control.fifo_cfg = chi_traffic_profile_xact.write_fifo_cfg;
      write_xact_fifo_rate_control.fifo_cfg.fifo_type = svt_fifo_rate_control_configuration::WRITE_TYPE_FIFO;
      write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle = chi_traffic_profile_xact.write_fifo_cfg.rate/rate_divisor;
      write_xact_fifo_rate_control.reset_all();
      write_xact_fifo_rate_control.chi_common = my_agent.prot.common;
      write_xact_fifo_rate_control.update_fifo_levels_every_clock();
      //track_fifo_underflow_and_overflow(write_xact_fifo_rate_control);
    end

    if (chi_traffic_profile_xact.read_fifo_cfg != null)  begin
      real rate_divisor = 1000/cfg.clock_period;
      read_xact_fifo_rate_control = new({chi_traffic_profile_xact.profile_name,":read_xact_fifo_rate_control"});
      read_xact_fifo_rate_control.rate_divisor = rate_divisor;
      read_xact_fifo_rate_control.fifo_cfg = chi_traffic_profile_xact.read_fifo_cfg;
      read_xact_fifo_rate_control.fifo_cfg.fifo_type = svt_fifo_rate_control_configuration::READ_TYPE_FIFO;
      read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle = chi_traffic_profile_xact.read_fifo_cfg.rate/rate_divisor;
      read_xact_fifo_rate_control.reset_all();
      read_xact_fifo_rate_control.chi_common = my_agent.prot.common;
      read_xact_fifo_rate_control.update_fifo_levels_every_clock();
      //track_fifo_underflow_and_overflow(read_xact_fifo_rate_control);
    end


    fork
    begin
      bit rand_result;
      svt_chi_rn_transaction chi_rn_xacts[$];
      int curr_num_bytes = 0;
      `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,pre_traffic_profile_to_protocol_xact_mapping(chi_traffic_profile_xact));
      while (curr_num_bytes < chi_traffic_profile_xact.total_num_bytes) begin : tag_while_bytes_remain
        svt_chi_rn_transaction chi_xact;
         seqr_sema.get();
        `svt_xvm_create(chi_xact);
        chi_xact.cfg = cfg;

        update_xact_addr(chi_xact,chi_traffic_profile_xact,curr_addr,two_dim_base_addr);
        update_xact_id(chi_xact,chi_traffic_profile_xact,curr_id);
        update_xact_data(chi_xact,chi_traffic_profile_xact,num_transfers,last_data,curr_data);

        rand_result = chi_xact.randomize() with
           { 


             if (chi_traffic_profile_xact.addr_gen_type == svt_chi_traffic_profile_transaction::RANDOM_ADDR) {
               chi_xact.addr inside {[chi_traffic_profile_xact.base_addr:(chi_traffic_profile_xact.base_addr + chi_traffic_profile_xact.addr_xrange - 1 - chi_traffic_profile_xact.xact_size/8)]};
             } else {
               chi_xact.addr == curr_addr;
             }

             if (chi_traffic_profile_xact.data_gen_type == svt_chi_traffic_profile_transaction::RANDOM) { 
               foreach (chi_xact.data[i])
                 chi_xact.data[i] inside {[chi_traffic_profile_xact.data_min:chi_traffic_profile_xact.data_max]};
             } else { 
               foreach (chi_xact.data[i])
                 chi_xact.data[i] == curr_data[i];
             }

             if (chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::FIXED) {
               chi_xact.txn_id == chi_traffic_profile_xact.txn_id_min;
             } else if ((chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::CYCLE) || (chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::UNIQUE)) {
                chi_xact.txn_id == curr_id;
             }

             if (chi_traffic_profile_xact.xact_gen_type == svt_chi_traffic_profile_transaction::FIXED) {
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITENOSNPFULL) -> (chi_xact.xact_type == svt_chi_transaction::WRITENOSNPFULL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITENOSNPPTL) -> (chi_xact.xact_type == svt_chi_transaction::WRITENOSNPPTL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITEUNIQUEFULL) -> (chi_xact.xact_type == svt_chi_transaction::WRITEUNIQUEFULL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITEUNIQUEPTL) -> (chi_xact.xact_type == svt_chi_transaction::WRITEUNIQUEPTL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::MAKEUNIQUE) -> (chi_xact.xact_type == svt_chi_transaction::MAKEUNIQUE);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::CLEANUNIQUE) -> (chi_xact.xact_type == svt_chi_transaction::CLEANUNIQUE);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::READUNIQUE) -> (chi_xact.xact_type == svt_chi_transaction::READUNIQUE);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::READNOSNP) -> (chi_xact.xact_type == svt_chi_transaction::READNOSNP);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::READSHARED) -> (chi_xact.xact_type == svt_chi_transaction::READSHARED);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::READCLEAN) -> (chi_xact.xact_type == svt_chi_transaction::READCLEAN);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::READONCE) -> (chi_xact.xact_type == svt_chi_transaction::READONCE);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITEBACKFULL) -> (chi_xact.xact_type == svt_chi_transaction::WRITEBACKFULL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITEBACKPTL) -> (chi_xact.xact_type == svt_chi_transaction::WRITEBACKPTL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITECLEANFULL) -> (chi_xact.xact_type == svt_chi_transaction::WRITECLEANFULL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITECLEANPTL) -> (chi_xact.xact_type == svt_chi_transaction::WRITECLEANPTL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::EVICT) -> (chi_xact.xact_type == svt_chi_transaction::EVICT);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::WRITEEVICTFULL) -> (chi_xact.xact_type == svt_chi_transaction::WRITEEVICTFULL);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::CLEANINVALID) -> (chi_xact.xact_type == svt_chi_transaction::CLEANINVALID);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::CLEANSHARED) -> (chi_xact.xact_type == svt_chi_transaction::CLEANSHARED);
                 (chi_traffic_profile_xact.xact_type == svt_chi_traffic_profile_transaction::MAKEINVALID) -> (chi_xact.xact_type == svt_chi_transaction::MAKEINVALID);
             }
             chi_xact.data_size == chi_data_size;
             if (chi_traffic_profile_xact.qos_gen_type == svt_chi_traffic_profile_transaction::FIXED)
               chi_xact.qos == chi_traffic_profile_xact.qos_min;
             else
               chi_xact.qos inside {[chi_traffic_profile_xact.qos_min:chi_traffic_profile_xact.qos_max]};
             if (chi_traffic_profile_xact.prot_gen_type == svt_chi_traffic_profile_transaction::FIXED) {
               if (chi_traffic_profile_xact.prot_type == svt_chi_traffic_profile_transaction::SECURE) 
                 chi_xact.is_non_secure_access == 0; 
               else 
                 chi_xact.is_non_secure_access == 1; 
             }
           };

         chi_xact.store_causal_ref(chi_traffic_profile_xact);
         `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,pre_traffic_profile_xact_send(chi_traffic_profile_xact,chi_xact));
         wait_for_fifo_fill_level(chi_traffic_profile_xact,chi_xact,write_xact_fifo_rate_control,read_xact_fifo_rate_control);
         `svt_xvm_debug("send_chi_traffic_profile",
         $sformatf("About to call svt_xvm_send. Converted traffic profile transaction %0d (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d profile_name: %0s group_name: %0s) to CHI transaction. Xact: %0s", 
         traffic_profile_object_num, chi_traffic_profile_xact.xact_size.name(), chi_traffic_profile_xact.base_addr, chi_traffic_profile_xact.total_num_bytes, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, chi_traffic_profile_xact.group_name, `SVT_CHI_PRINT_PREFIX(chi_xact)));
         `svt_xvm_send(chi_xact);
         `svt_xvm_debug("send_chi_traffic_profile",
         $sformatf("Converted traffic profile transaction %0d (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d profile_name: %0s group_name: %0s) to CHI transaction. Xact: %0s", 
         traffic_profile_object_num, chi_traffic_profile_xact.xact_size.name(), chi_traffic_profile_xact.base_addr, chi_traffic_profile_xact.total_num_bytes, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, chi_traffic_profile_xact.group_name, `SVT_CHI_PRINT_PREFIX(chi_xact)));
         active_xact_queue_sema.get();
         active_xact_queue.push_back(chi_xact);
         active_xact_queue_sema.put();
         track_transaction(chi_xact,chi_traffic_profile_xact,write_xact_fifo_rate_control,read_xact_fifo_rate_control);
         seqr_sema.put();
         // TBD: Check that byte count in CHI is same as data_size
         curr_num_bytes += chi_xact.get_data_size_in_bytes();
         update_current_byte_count(chi_xact,chi_traffic_profile_xact);
         chi_rn_xacts.push_back(chi_xact);
         `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,post_traffic_profile_xact_send(chi_traffic_profile_xact,chi_xact));

       end : tag_while_bytes_remain

       // reset values to defaults
       curr_addr = '1;
       last_data = '1;
       curr_id = '1;

       foreach (chi_rn_xacts[i]) begin
         // TBD: check with CHI team that wait_end works as expected.
         wait_end_with_retry(chi_rn_xacts[i]);
         `svt_xvm_debug("send_chi_traffic_profile", 
         $sformatf("Converted CHI transaction (%0d of %0d) has ended (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d). Xact: %0s", 
         traffic_profile_object_num, chi_rn_xacts.size(), chi_traffic_profile_xact.xact_size.name(), chi_traffic_profile_xact.base_addr, chi_traffic_profile_xact.total_num_bytes, chi_traffic_profile_xact, `SVT_CHI_PRINT_PREFIX(chi_rn_xacts[i])));
       end

      `svt_xvm_debug("send_chi_traffic_profile", $sformatf("Indicating end of traffic profile transaction %0d (handle: %0d profile_name: %0s group_name: %0s). node_id: %0d.  data_width = %0d. xact_size: %0d. total_num_bytes: %0d.", 
      traffic_profile_object_num, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, chi_traffic_profile_xact.group_name, cfg.node_id, cfg.flit_data_width, chi_traffic_profile_xact.xact_size, chi_traffic_profile_xact.total_num_bytes));
       chi_traffic_profile_xact.end_tr($realtime);
    end
    join_none
  endtask 

  /** Waits for transaction to end including any retried transaction */
  task wait_end_with_retry(svt_chi_rn_transaction xact);
    xact.wait_end();
    if (xact.req_status == svt_chi_transaction::RETRY) begin
      if (xact.p_crd_return_on_retry_ack == 0) begin
        `svt_xvm_debug("send_chi_traffic_profile", $sformatf({`SVT_CHI_PRINT_PREFIX(xact), "received retry response. p_crd_return_on_retry_ack = 0. continuing to wait for completion"}));
        wait (xact.req_status == svt_chi_transaction::ACTIVE);
      end
      else begin
        `svt_xvm_debug("send_chi_traffic_profile", $sformatf({`SVT_CHI_PRINT_PREFIX(xact), "received retry response. p_crd_return_on_retry_ack = 1. As request will be cancelled, not waiting for completion"}));
      end
      xact.wait_end();
    end
  endtask

  task wait_for_fifo_fill_level(svt_chi_traffic_profile_transaction chi_traffic_profile_xact, svt_chi_transaction xact, svt_chi_fifo_rate_control write_xact_fifo_rate_control, svt_chi_fifo_rate_control read_xact_fifo_rate_control);
    bit fifo_clk_flag = 0;
     // FIFO levels are incremented/decremented every clock. Wait for correct FIFO levels before proceeding
    if (xact.get_semantic() == `SVT_CHI_WRITE_TYPE_SEMANTIC &&
        chi_traffic_profile_xact.write_fifo_cfg != null &&
        xact.is_applicable_for_fifo_rate_control()) begin
      while (!write_xact_fifo_rate_control.check_fifo_fill_level(xact,.num_bytes(xact.compute_num_data_bytes()))) begin
        if (fifo_clk_flag == 0)
          `svt_note("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Profile: %0s. Waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
        fifo_clk_flag = 1;
        my_agent.prot.common.advance_clock(); 
      end
      `svt_note("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Profile: %0s. Done waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d) num_bytes(%0d)", chi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level,xact.compute_num_data_bytes())});   
    end
    else if (xact.get_semantic() == `SVT_CHI_READ_TYPE_SEMANTIC &&
        chi_traffic_profile_xact.read_fifo_cfg != null &&
        xact.is_applicable_for_fifo_rate_control()) begin
      while(!read_xact_fifo_rate_control.check_fifo_fill_level(xact,.num_bytes(xact.compute_num_data_bytes()))) begin
        if (fifo_clk_flag == 0)
          `svt_note("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Profile: %0s. Waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
        fifo_clk_flag = 1;
        my_agent.prot.common.advance_clock(); 
      end
      `svt_note("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Profile: %0s. Done waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
    end
  endtask

  /** Tracks the end of transaction */
  task track_transaction(svt_chi_rn_transaction xact, svt_chi_traffic_profile_transaction chi_traffic_profile_xact, svt_chi_fifo_rate_control write_xact_fifo_rate_control, svt_chi_fifo_rate_control read_xact_fifo_rate_control);
    int _xact_index[$];
    int _num_bytes;
    _num_bytes = xact.compute_num_data_bytes();
    if (xact.get_semantic() == `SVT_CHI_WRITE_TYPE_SEMANTIC &&
        chi_traffic_profile_xact.write_fifo_cfg != null &&
        xact.is_applicable_for_fifo_rate_control()) begin
      write_xact_fifo_rate_control.update_total_expected_fill_levels(xact,svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, _num_bytes);
      `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Post item send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
    end
    else if (xact.get_semantic() == `SVT_CHI_READ_TYPE_SEMANTIC &&
          chi_traffic_profile_xact.read_fifo_cfg != null &&
          xact.is_applicable_for_fifo_rate_control()) begin
      read_xact_fifo_rate_control.update_total_expected_fill_levels(xact,svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE,_num_bytes);
      `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_CHI_PRINT_PREFIX(xact), $sformatf("Post item send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
    end

    fork
    begin

      if (xact.get_semantic() == `SVT_CHI_WRITE_TYPE_SEMANTIC &&
          chi_traffic_profile_xact.write_fifo_cfg != null &&
          xact.is_applicable_for_fifo_rate_control()) begin
        wait (xact.data_status == svt_chi_transaction::ACCEPT);
        write_xact_fifo_rate_control.update_fifo_levels_on_data_xmit(xact,_num_bytes);
        write_xact_fifo_rate_control.update_total_expected_fill_levels(
                xact,svt_fifo_rate_control::FIFO_REMOVE_FROM_ACTIVE,_num_bytes
                );
        `svt_xvm_debug("track_transaction", {`SVT_CHI_PRINT_PREFIX1(xact), $sformatf("Post i/f send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
      end
      else if (xact.get_semantic() == `SVT_CHI_READ_TYPE_SEMANTIC &&
          chi_traffic_profile_xact.read_fifo_cfg != null &&
          xact.is_applicable_for_fifo_rate_control()) begin
        wait (xact.data_status == svt_chi_transaction::ACCEPT);
        read_xact_fifo_rate_control.update_fifo_levels_on_data_xmit(xact,_num_bytes);
        read_xact_fifo_rate_control.update_total_expected_fill_levels(
                xact,svt_fifo_rate_control::FIFO_REMOVE_FROM_ACTIVE,_num_bytes
                );
        `svt_xvm_debug("track_transaction", {`SVT_CHI_PRINT_PREFIX1(xact), $sformatf("Post i/f send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", chi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   

      end

      `svt_xvm_debug("track_transaction", 
      $sformatf("Waiting for AXI transaction to end(xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d. profile name: %0s) to AXI transaction. Xact: %0s", 
      chi_traffic_profile_xact.xact_size.name(), chi_traffic_profile_xact.base_addr, chi_traffic_profile_xact.total_num_bytes, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, `SVT_CHI_PRINT_PREFIX1(xact)));
      wait_end_with_retry(xact);
      active_xact_queue_sema.get();
      _xact_index = active_xact_queue.find_first_index with(item == xact);
      if (_xact_index.size()) begin
        active_xact_queue.delete(_xact_index[0]);
      end
      active_xact_queue_sema.put();
      `svt_xvm_debug("track_transaction", 
      $sformatf("Converted AXI transaction has ended (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d. profile name: %0s) to AXI transaction. Xact: %0s", 
      chi_traffic_profile_xact.xact_size.name(), chi_traffic_profile_xact.base_addr, chi_traffic_profile_xact.total_num_bytes, chi_traffic_profile_xact, chi_traffic_profile_xact.profile_name, `SVT_CHI_PRINT_PREFIX1(xact)));
    end
    join_none

  endtask


  /** Updates the ID to be assigned to the next transaction */
  task update_xact_id(svt_chi_rn_transaction xact,svt_chi_traffic_profile_transaction chi_traffic_profile_xact,ref bit[`SVT_CHI_TXN_ID_WIDTH-1:0] curr_id);
    svt_chi_rn_transaction _matching_xact[$];
    if ((chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::CYCLE) || (chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::UNIQUE)) begin
      if (curr_id == '1) begin
        curr_id = chi_traffic_profile_xact.txn_id_min;
      end
      else begin
        curr_id++;
        if (curr_id > chi_traffic_profile_xact.txn_id_max)
          curr_id = chi_traffic_profile_xact.txn_id_min; 
      end
    end
    if (chi_traffic_profile_xact.txn_id_gen_type == svt_chi_traffic_profile_transaction::UNIQUE) begin //tag_is_unique
      string id_str;
      bit[`SVT_CHI_TXN_ID_WIDTH-1:0] id_list[$], _matching_id[$];
      svt_chi_rn_transaction _matching_xact[$];
      active_xact_queue_sema.get();
      _matching_xact = active_xact_queue.find_first with (item.txn_id == curr_id);
      if (_matching_xact.size()) begin
        bit found_free_id = 0;
        while (!found_free_id) begin
          int _index = 0;
          for (int x = 0; x <= (chi_traffic_profile_xact.txn_id_max-chi_traffic_profile_xact.txn_id_min); x++) begin // tag_for_loop
            _index++;
            if ((curr_id + _index) > chi_traffic_profile_xact.txn_id_max) begin
              curr_id = chi_traffic_profile_xact.txn_id_min;
              _index = 0;
            end
            _matching_id = id_list.find_first with (item == (curr_id + _index));
            _matching_xact = active_xact_queue.find_first with (item.txn_id == (curr_id + _index));
            if (!_matching_xact.size()) begin
              curr_id = (curr_id + _index);
              found_free_id = 1;
              break;
            end
            _index++;
          end
          if (!found_free_id) begin
            int curr_active_queue_size;
            active_xact_queue_sema.put();
            curr_active_queue_size = active_xact_queue.size();
            if (curr_active_queue_size) begin
              `svt_xvm_debug("update_xact_id", $sformatf("Waiting for current active_xact_queue.size(%0d) to decrease. node_id: %0d. profile_name: %0s", 
                                          curr_active_queue_size, cfg.node_id, chi_traffic_profile_xact.profile_name));
              wait(active_xact_queue.size() < curr_active_queue_size);
              `svt_xvm_debug("update_xact_id", $sformatf("Current active_xact_queue.size(%0d) has decreased. node_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.node_id, chi_traffic_profile_xact.profile_name));
            end
            `svt_xvm_debug("update_xact_id", $sformatf("Getting sema. Current active_xact_queue.size(%0d) has decreased. node_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.node_id, chi_traffic_profile_xact.profile_name));
            active_xact_queue_sema.get();
            `svt_xvm_debug("update_xact_id", $sformatf("Got sema. Current active_xact_queue.size(%0d) has decreased. node_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.node_id, chi_traffic_profile_xact.profile_name));
          end
        end
      end
      active_xact_queue_sema.put();
    end //tag_is_unique
  endtask

  /** Updates the data to be assigned to the next transaction */
  task update_xact_data(svt_chi_rn_transaction xact, svt_chi_traffic_profile_transaction chi_traffic_profile_xact, int burst_length, ref bit[`SVT_CHI_MAX_DATA_WIDTH-1:0] last_data, ref bit[`SVT_CHI_MAX_DATA_WIDTH-1:0] curr_data[]);
    curr_data = new[burst_length];
    if (chi_traffic_profile_xact.data_gen_type == svt_chi_traffic_profile_transaction::FIXED) begin
      foreach (curr_data[i]) begin
        curr_data[i] = chi_traffic_profile_xact.data_min;
      end
    end
    else if (chi_traffic_profile_xact.data_gen_type == svt_chi_traffic_profile_transaction::CYCLE) begin
        
      foreach (curr_data[i]) begin
        if (last_data == '1) 
          last_data = chi_traffic_profile_xact.data_min;
        else
          last_data = last_data + xact.cfg.flit_data_width/8;
        if (last_data > chi_traffic_profile_xact.data_max)
          last_data = chi_traffic_profile_xact.data_min;
        curr_data[i] = last_data;
      end
    end
  endtask

  /** Updates the address to be assigned to the next transaction */
  task update_xact_addr(svt_chi_rn_transaction xact, svt_chi_traffic_profile_transaction chi_traffic_profile_xact, ref bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] curr_addr, ref bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] two_dim_base_addr);
    if (curr_addr == '1)
      curr_addr = chi_traffic_profile_xact.base_addr;
    else
      curr_addr = curr_addr + (chi_traffic_profile_xact.xact_size/8);

    if (chi_traffic_profile_xact.addr_gen_type == svt_chi_traffic_profile_transaction::SEQUENTIAL) begin
      if (
            ((curr_addr + chi_traffic_profile_xact.xact_size/8 - 1) >= chi_traffic_profile_xact.base_addr + chi_traffic_profile_xact.addr_xrange) 
         )
        curr_addr = chi_traffic_profile_xact.base_addr;
    end
    else if (chi_traffic_profile_xact.addr_gen_type == svt_chi_traffic_profile_transaction::TWODIM) begin
      if (
           (curr_addr + chi_traffic_profile_xact.xact_size/8 - 1) >= (chi_traffic_profile_xact.base_addr + chi_traffic_profile_xact.addr_twodim_yrange - chi_traffic_profile_xact.addr_twodim_stride + chi_traffic_profile_xact.addr_xrange) 
         ) begin
        curr_addr = chi_traffic_profile_xact.base_addr;
        two_dim_base_addr = chi_traffic_profile_xact.base_addr;
      end
      else if ((curr_addr + chi_traffic_profile_xact.xact_size/8 - 1) >= (two_dim_base_addr + chi_traffic_profile_xact.addr_xrange)) begin
        curr_addr = two_dim_base_addr + chi_traffic_profile_xact.addr_twodim_stride;
        two_dim_base_addr = curr_addr;
      end
    end

    if ((curr_addr + chi_traffic_profile_xact.xact_size/8) > ((1 << cfg.addr_width)-1)) 
      curr_addr = chi_traffic_profile_xact.base_addr;

    if ((curr_addr[11:0] > (`SVT_AXI_TRANSACTION_4K_ADDR_RANGE - chi_traffic_profile_xact.xact_size/8))) 
      curr_addr = chi_traffic_profile_xact.base_addr;
  endtask

  /** Tracks output events of the traffic profile transaction */
  task track_output_events(svt_chi_traffic_profile_transaction xact);
    foreach (xact.output_events[i]) begin
      if (xact.output_event_type[i] == svt_traffic_profile_transaction::FRAME_TIME)
        track_frame_time_output_event(xact,xact.output_events[i]);
      else if (xact.output_event_type[i] == svt_traffic_profile_transaction::FRAME_SIZE)
        track_frame_size_output_event(xact,xact.output_events[i]);
      else if(xact.output_event_type[i] == svt_traffic_profile_transaction::END_OF_PROFILE)
        track_end_of_profile_output_event(xact,xact.output_events[i]);
    end
  endtask

  /** Triggers an event when the specified time for frame time elapses */
  task track_frame_time_output_event(svt_chi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      // TBD: Task does not exist currently
      //my_agent.advance_clock(xact.frame_time);
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Triggers an event when the specified number of bytes given in frame_size is transmitted */
  task track_frame_size_output_event(svt_chi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      while (xact.current_xmit_byte_count <= xact.frame_size) begin
        int current_xmit_byte_count = xact.current_xmit_byte_count;
        wait(xact.current_xmit_byte_count > current_xmit_byte_count);
        `svt_xvm_debug("track_frame_size_output_event", $sformatf("current_xmit_byte_count = %0d", xact.current_xmit_byte_count));
      end
      `svt_xvm_debug("track_frame_size_output_event", $sformatf("triggering output event %s. xact.current_xmit_byte_count = %0d. xact.frame_size = %0d", output_event, xact.current_xmit_byte_count, xact.frame_size));
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Triggers an event when the end of profile is reached */
  task track_end_of_profile_output_event(svt_chi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      xact.wait_end();
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Updates the total number of bytes transmitted by the profile */
  task update_current_byte_count(svt_chi_rn_transaction xact, svt_chi_traffic_profile_transaction traffic_profile_xact);
    fork
    begin
      xact.wait_end();
      traffic_profile_xact.current_xmit_byte_count += xact.get_data_size_in_bytes();
    end
    join_none
  endtask

  task track_fifo_underflow_and_overflow(svt_chi_fifo_rate_control fifo_rate_control);
    if (fifo_rate_control != null) begin
      fork
      begin
        while (1) begin
          fifo_rate_control.wait_for_overflow();
          `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,detected_fifo_overflow(fifo_rate_control));
        end
      end
      begin
        while (1) begin
          fifo_rate_control.wait_for_underflow();
          `uvm_do_obj_callbacks(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback,this.p_sequencer,detected_fifo_underflow(fifo_rate_control));
        end
      end
      join_none
    end
  endtask


endclass: svt_chi_rn_traffic_profile_sequence

`endif //SVT_EXCLUDE_VCAP

`endif // GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCE_COLLECTION_SV


