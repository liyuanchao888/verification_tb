//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_SN_BASE CHI SN transaction response base sequence
 * Base sequence for all CHI SN transaction response sequences
 */
/** 
 * @grouphdr sequences CHI_SN_NULL CHI SN transaction null sequence
 * Null sequence for SN transaction
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_SN_MEM CHI SN transaction memory response sequences
 * CHI SN transaction memory response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_SN_BASE
 * svt_chi_sn_transaction_base_sequence: This is the base class for svt_chi_sn_transaction
 * sequences. All other svt_chi_sn_transaction sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_sn_transaction_base_sequence extends svt_sequence#(svt_chi_sn_transaction);

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_sn_transaction_sequencer) 

  /**
   * SN Agent virtual sequencer
   */
  svt_chi_sn_virtual_sequencer sn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /**
   * SN agent Memory
   */
  svt_chi_memory chi_sn_mem;
  
  /** 
   * Constructs a new svt_chi_sn_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_sn_transaction_base_sequence");

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_sn_virt_seqr();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();
  
  /**
   * Listen to the sequencer's analysis port for completed transaction
   */
  extern virtual task pre_start();

  /** Empty body method */
  virtual task body();
  endtask

  /**
   * Wait for a response request
   */
  extern task wait_for_response_request(output svt_chi_sn_transaction req);

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_chi_sn_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_chi_sn_transaction xact);
  
  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_transaction observed);
    
  endfunction

endclass // svt_chi_sn_transaction_base_sequence

/**
 * @groupname CHI_SN_MEM
 * Class svt_chi_sn_transaction_memory_sequence defines a reactive sequence that
 * a testbench may use to make use of CHI memory within the CHI SN agent. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_sn_transaction from the SN sequencer. It then:
 * - updates the response fields
 * - In case of WriteNoSnp*, updates the SN memory with data in the transaction
 * - IN case of ReadNoSnp, updates the data in the transaction with the data in SN memory
 * .
 * The updated transaction is provided to the SN protocol layer driver
 * within the SN agent. 
 * IN case of WriteNoSnp*, the data is updated into the memory only when the transaction
 * is complete successfully without any errors.
 */
// =============================================================================
class svt_chi_sn_transaction_memory_sequence extends svt_chi_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /* Port configuration obtained from the sequencer */
  svt_chi_node_configuration cfg;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_memory_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_memory_sequence");
  
  /** 
   * Executes the svt_chi_sn_transaction_memory_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_sn_transaction_memory_sequence

// =============================================================================
/**@cond PRIVATE */
/**
 * Class chi_sn_ram_response_sequence defines a reactive sequence that
 * a testbench may use to make a CHI SN agent behave like a RAM.
 * 
 * The sequence receives a response request of type
 * svt_chi_sn_transaction from the SN sequencer. It then
 * updates the response fields and provides it to the SN protocol layer driver
 * within the SN agent. 
 */

class chi_sn_ram_response_sequence extends svt_chi_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /* Port configuration obtained from the sequencer */
  svt_chi_node_configuration cfg;

  /** UVM Object Utility macro */
  `uvm_object_utils(chi_sn_ram_response_sequence)
  
  /** Class Constructor */
  function new(string name="chi_sn_ram_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    svt_configuration get_cfg;
    
    `uvm_info("body", "Entered ...", UVM_HIGH)

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_port_configuration class");
    end

    /** 
     * This method is defined in the svt_chi_sn_transaction_base_sequence.
     * It obtains the virtual sequencer sn_virt_seqr of type svt_chi_sn_virtual_sequencer 
     * from the configuration database and sets up the shared resources obtained from it: the response_request_port, shared_status, chi_sn_mem.
     * 
     **/ 
    get_sn_virt_seqr();

    /** This method is defined in the svt_chi_sn_transaction_base_sequence.
     * Used to sink the responses from the response queue.
     **/
    sink_responses();

    forever begin
      /**
       * Get the response request from the SN sequencer. The response request is
       * provided to the SN sequencer by the SN protocol layer monitor, through
       * TLM port.
       */
      wait_for_response_request(req_resp);
      `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

      /**
       * Set the SN response type.
       * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
       * o This makes the SN to transmit CompData message(s).
       * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
       * o This makes the SN to transmit CompDBIDResp message.
       */
      if (
          req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
          `ifdef SVT_CHI_ISSUE_C_ENABLE
            || req_resp.xact_type == svt_chi_sn_transaction::READNOSNPSEP
          `endif
         ) begin
        int unsigned size = 1 << req_resp.data_size;
        int unsigned align = req_resp.addr[5:0];
        req_resp.data = chi_sn_mem.read({req_resp.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00});
        `svt_xvm_debug("body", $sformatf("Read line at 0x%h: %h",
                                         {req_resp.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, req_resp.data));
        req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      end
      else if ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
               (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)) begin
        // Can only respond with "go ahead".
        // The write data will be provided by the monitor once the full transaction
        // has completed.
        req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;
      end

      `svt_xvm_debug("body", {"Response: ", req_resp.sprint()});

      $cast(req,req_resp);

      /**
       * send to driver
       */
      `uvm_info("body", $sformatf("Sending %0s response to transaction %0s", req_resp.xact_rsp_msg_type.name(), `SVT_CHI_PRINT_PREFIX(req_resp)), UVM_MEDIUM);
      `uvm_send(req)

    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask: body

  // Process WRITE data
  virtual function void write(svt_chi_transaction observed);
    if ((observed.xact_type == svt_chi_transaction::WRITENOSNPFULL) ||
        (observed.xact_type == svt_chi_transaction::WRITENOSNPPTL)) begin
      // Memory is 64-byte per address
      int unsigned size = 1 << observed.data_size;
      int unsigned align = observed.addr[5:0];
      void'(chi_sn_mem.write({observed.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, observed.data, observed.byte_enable));
      `svt_xvm_debug("body", $sformatf("Wrote line at 0x%h with %h (mask:%h)",
                                       {observed.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, observed.data,
                                       observed.byte_enable));
    end
  endfunction

endclass: chi_sn_ram_response_sequence


// =============================================================================
/** 
 * svt_chi_sn_transaction_random_sequence
 *
 * This sequence creates a random svt_chi_sn_transaction request.
 */
class svt_chi_sn_transaction_random_sequence extends svt_chi_sn_transaction_base_sequence; 
  
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_random_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_sn_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass
/** @endcond */

`protected
JTJ:DJ59C_+gaK;;AEO(d7Z6eZ\aHMZ[/@+4QOLfY2FK9O/PMEZ/+)#QJN=8dNK&
WQ>CJ0AG8S-7S&I@9^TTMFaJ;B\QU?\LKQA7#O==)+8W1]A9#QY86O=3A]P2H#b.
>aH]-:PGM,Uf<7EaMEEDV;6cKE;KDbYe>K+&cUR0.7Q\K>NE6.R:33MQG1BQ64JX
+FL\97++L11ge?(N2>g&<L4Db_./:6PDM:f5I:<9E.Zf\<RggRF5Da0UO^]H[3ROU$
`endprotected


//vcs_vip_protect
`protected
b&(6fDT1c[cRBS#6cQ+90-<DETOY#&cPNSJc6c/GPd[YOX1F&W[^((WaB9?cKJD7
5I(IF/Ua>AZNQX)Pg]3DZKEc9X31BE)YQ=)[Xf7]ee]()P1JR\5P,+AD)WE;[)CL
JNCdL#b)BQ+:\J4-cT9c-KA7,[4.<LJg[/agTc4.f^4<GTH^f7IeLJ9]:2=<T?KF
.];A5BF/-A4=<03R2YZRQ084?4PeQ3d<HKZg[8^T9.H1118[[aR0&=3W:E[LK)I:
5c;RXY7.K+:3UT8UeZ9II7N\U#?,/5FNB7#B3T;.Gad&Zd[NRRg,JL5dMH3-RN(S
(DZ+J#Cg31eYU/?YF6>]>N[&26L+ZS#_B>BK+;93C>SX/EQ./M,(Db/d0;.O<C0g
40+1UE-UPWH;XO59EX=8J?f#f+-[BIFfTR(#TOa]QL?QXWC]Q<OXaX/H#2DFda:N
O[]PD>SW.?]=K&J,:C;/83I32^O-/8XE]cd(ZBW=[B52GKCKF\PJQ.eX2Q^K2,dd
,g:b8Y5X8>^@F4)<X#fZDg8ZN0L^)DTga_bLeTY6-d;-0?(1I_5I-M^^#7QGTfVJ
4?O^^D;\SNK86I6b369]4U_MLSEX2Hf75^Nf+AB<\8EMWM0LDPeIIa^Q[A/c3Qf+
NV/3YGJ&J-]Y:Q1aY^F-aCRZCOccE0(YC<;_T-@P@KDRXTU6R30(?Kg/2Fa=;G^Q
2g]]dc.M;W-JV6#OR(VaR+bQHbI<4M98=,ID]QcV5</)+O.\b[Ag6Kf3fC+3aLZ4
a1J0#?Qa+F/N\0/N_6./5Xe1T.LdHbS1)OC;S,F<B+,?/-=X\.J<f@d1M;5^4WHB
&/_[OQeHebKRP63^MV[>3_\LW^HI]^-9Ac##Dc7@+..,Ma>2P0>S2H>7\;0aX4=N
eX<A1R(Y/bH6f.HFccUc/#T?-_3P=072-8M8FUgMW6[d+&J@3JdbJ5EB<QHe,N/4
[C6/Y-\(?)I/KUWV[YO)Y.A+^S7ES)C4IZH4<0Og(aN#cZ^2_Y[F#H9O8C]95>XL
3b10R.2F;dIebZ+g#Q&QO4?Ba-]YAI<RBVP3A/6DSfd[9W5(](E^S++Ic-\:Xg/N
T7/WW8FP5Z8).eEga2V0SEPXMX7?6/a7[3K@2JN\^-WbA<YM+G+9dG=GObW])OVT
8bO8-3c#J1>7[J:73<,-Jd;2MV&ZS9B_F1K1SCd9g=;7?TU(,V+CSa5U2QSDa[_K
5]D^BPEG2ZGBNTa+bF?)8B_8P/FQ?7R.OQ91T^_M\>6T][3.^)+76D]B&0fJ4&)@
9SG[GI[5;C@R0&.d:VU2L+,E6UQK@M9bfE<:85<Vb,Dd/.1QbHbH[P<RL-I1bKW5
A@HS./1J>>+M[fHJF4H6Z_@#ZdV()g-AS)>:K)F)NI3J]+U8)AL#A4f?SZ^9+XUO
;fHH-0B\OQ0e/#Ug/AFDLgKJY2T0IS0aY^N<0-:,gJA&dVQb+,8gc.I?A18,OV[R
?/&[Q7(MFOA+YXKZ#cZa,cQA77PQ<QY,S4:WYBM>#cC,ST\XI].T[aB1CA:[USXe
cB8W_dg27C2MKB(]d:gaF,WR]Y6\08K1bY^M&ZN:L\.bW7O4gTMXdQN+ED5OLIXd
(?_:d:_PBTD^<Z2.X67[_0VY-=?>OY26]U?LZ=N-CaV<J?<V9#I02JAW0V/7R=?>
@gT\f]ZF9Gb#?H;M<B@X&0[Bd.^5^]Q2eK9+H&DG7-I>/LgQ+(D511b06B[>VP:.
QG6fgW?2>4g#M;0aY3\aQ,,1W_LB<^Q4:2[L(:0]RJVg9=WULG)G^;>:7K@W^([,
/PQG6[AX=]TK/X&93^<TV:JWLX.6Sb>;Q?R=Q1H6;)5)XR0ecfEJFO^;>[\dW_AO
:Td);4QE?67+ARJ]>#cHeT@1@XV)<\Bc?OVSK+JWKW-CCf#0dEH,]<_0VPCOd)+F
f^gBMK9/)fK&N\4?fTJ0d#X=fK/_#.YMA-:a.bE\gI_SMT-]51N&[C=2/13Gd1)4
@,3(E-(TB>9U)&THB2dX43V]fU-U?Q@U&42e562WRGF\F15_#6-;/@N1,K05_MJY
b:33T#6,_I/0;I][(EBT?VWI41@RAf7ebL+:3OJU6cQD\b]6UGK#&2cg_&CO:>N/
F@MQ5Se=HHT7V;F;/=0]M/J9T,V[4B/P6Yg1##MFGbT(ZK)DRVZ;6JUcP&&XSM<\
#_R55#F7Df2IO5eUQS3T,E9g45=B=0]5+IM1<3c4Lg[<2/d(_-(.87K_4[0-NfLO
;e=cSI#c&C6bJI&>:,ZI2Bg2:=+48O16;@&/SP)LVH#8-eJQ/bMSY1B&;UM22=Q6
CFEJ6dgeT0-b3:MD[0QE=(@9]K=B3HCM52<NOV:M>)[b)^C^-G3PH22aZ3JOT+1d
[,KN<gI6S>?_c<[)gM[K;0]<<fa>?KS=7@YO8&g8G\KLSE,7d89gb_RWR;4DU(CP
LRc1-?:g8@/[-CcJ?QPM5QYcE6O<;7EZ-G^a:_5CPTY+C&ZKW,>/:bAC/]>0bd.O
8a6D>J8+9L2L9(X^69)A.?Yf6f_9L^CV_?RJ)Q<KF>a-P7A)^HB\_-LVG0_E^]R;
0)@\NEU([]W.cG&g(C]<K+?6OIaTOJ)5SL3e<>:@7UDTA8@#G#JI55Lbf9<_c(:;
XIZF[]0EdaZPdQL\L,_8.S+KC)&V.U1UVYQ)\PG@V(;>T85?B:F@ILRJOEZ-C23f
7-J<]APS#/R2U>52#KbV(1ZJ36^P6bQC(.<F#0BV.-UBW5?f4C4UX3M3>#dY@]F9
@;N#JX8\>BLaK/f=@BeD\a>?02_4\)QU;@dH,[V=8)b35NgR-@,IFL4LOKaW5a4=
&=_\.VRSM=+B>Se,=deO<:K>MDGJ,K4B\:&.O=#]U8@CAJC)@2LR8[+#7L#&^?>D
C/V@DbX8?=SF-J?[;OU&9&/LXUfL#cf4KLQ=;;##EURGCU6O0+-)_dO[;HJ2.4_:
,LTV7\80T=JY,7&\T<TGOHXfAR#-GY/LTEHO<7U)F8W<K^4Z/KB0(DeJXe7P1(;9
fg8].4:4QQLXPBK6daN@EBCMII23I1M^33R)C&P]<#CL,gU:>-6CN[H2_X^G8;S^
,3RgT<WM@9_O7LG=C4THfUed4LXY#(7;OQ98cA[K?:e7V[g#S[9gYR=-SgeO/C_-
@]R8JY2@M&CWe[GVFNQfK+c=[]-RQBEO--AODcbCJ^JQfb<_d7@X#U\EA^7UXX@\
I[?gQ#5/-7I1W-^M_DBS[(.D15\(@HX@7E#Rd=\IWaH^8b7=,2f)ORTb9&8>G?5G
b0RbA=/@C>QP3EWM3\VOcOb100#?UAR58WbNCYH4\XdM]7VdET>?Hc/0X6A]-KJ&
TC^W>L99(_WQ&_FOJT\;^=V[&bD]6G6A]AM02eG4]5SH:(XKc(Q)2>2<GA0M:X(I
dXF;_fdLV,Q(YRS[ZOSF&HZ6f5<<1TcO[87..EU&?:^O[^(^8[CfTZ13^a=P0T9#
+]UCC19<MIJ.f2QcFK9IgQAD[(R,_CX@UW250W#0GHg[+PX]ZF)Z3O/QZJ+eTF.a
-&ZFV1+SB/,5XF3IM:@:-Z-CI]\eO_I[<2Y?0_X^4gF6:\+^[E?0[9[)F0>+#Z4S
+^dRE05MDS&]?O33NM9TQD?3LG:>ANT;U7=&g]KM]:51d(f&/\;)cXd9X)@#@:Y@
Vb4-L@Oe6;bdfV#]_Xc35I,INYA-3ZPO26L,#Ke#C([)ZVSN7AEX<Q5-G/Q_Sa_4
HPMPeIUW&LNU0+KS5GQC:cC;e([:+CZYdbfDVHDfUI[&W.N&+2-eIW9:YXeQSLB7
O1Vd1ERT)E-N_)2JD5[@eR(KE:X:Q.21+4F^7(O?gLLZX@.&#gFga]^8[LCF-.eB
dJD_5KSQ^f3_LN9(3X:46,;&ZYd#WB\7^YGT-N4+3-)3/-UUdJ06eW=,cYNFV771
)D,V<SZY/RHcd4VX5CZCC>V6FIDJFWK2:;+=+<T9[N<8P>Ta2@;[]-&PcYK\bH=#
3ZV1/W(HA<b.BHWZIL#(f)/@(DeKa>RG)6KAVW+1_=#9+^#JgM@)d>g=+e&>2QWe
35<b29D<OB<MMdX03U+22SEc9fXM37caaK/Mg1:>WXU=?D(-I]cVFY5/a:HIb5@@
\QT1?;N.7@05_=M/B6eL_>R.Q&P1#;4Kg[G1NS\B](&^AO6-HA2#KE:/6bQKFa.;
<VOU3:?R+)@K+F:U3IN:=^;=a=,JJU/1f2@K@V;?GdO#9[E,c1]-]M_6^<QC9?3W
@0-]SF_/aVb5ZX?/0L8dAQ592BA46+K\T6@eF4LHF1MWf8L,9bLQSMIJ26=.U+A8
Cf65IJ#P+P:I9I+KR=<Ke/OgRYdDPBRLIaH3&/b5_gB@E=BQJb&>P8-5[]&\;be3
E(V?5Z:U(WQ-)7DfQ?N7eG-N-I1X3SV52)J+OR4abaR\Y^I:2]CaG/dBWY/<S=C1
Ug6P,,MS4WM/g?TJ4>XR,<-.d-)d;OX#X2ZAJIU)WY[^-^4+K1-4:FgF1#CH5gJO
04LC616M8Z?MV35S3=^C4&6B+eecG9F==$
`endprotected
 

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_memory_sequence::new(string name="svt_chi_sn_transaction_memory_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_memory_sequence::body();
  svt_configuration get_cfg;
  bit rand_resp_gen;
  `svt_xvm_debug("body", "Entered ...");

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_port_configuration class");
    end

  /** 
   * This method is defined in the svt_chi_sn_transaction_base_sequence.
   * It obtains the virtual sequencer sn_virt_seqr of type svt_chi_sn_virtual_sequencer 
   * from the configuration database and sets up the shared resources obtained from it: the response_request_port, shared_status, chi_sn_mem.
   * 
   **/ 
  get_sn_virt_seqr();

  /** This method is defined in the svt_chi_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  

  forever begin

    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);

    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (
        req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
        `ifdef SVT_CHI_ISSUE_C_ENABLE
          || req_resp.xact_type == svt_chi_sn_transaction::READNOSNPSEP
        `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      `ifdef SVT_CHI_ISSUE_B_ENABLE
        rand_resp_gen = $urandom_range(1,0);
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.data_source_enable == 1) begin
          req_resp.data_source = rand_resp_gen ? svt_chi_transaction::PREFETCHTGT_WAS_USEFUL:svt_chi_transaction::PREFETCHTGT_WAS_NOT_USEFUL;
        end
      `endif

      get_read_data_from_mem_to_transaction(req_resp);
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        req_resp.data_cbusy = new[req_resp.compute_num_dat_flits()];      
        foreach(req_resp.data_cbusy[i])
           req_resp.data_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
        if(req_resp.order_type != svt_chi_sn_transaction::NO_ORDERING_REQUIRED)begin
          req_resp.response_cbusy = new[1] (req_resp.response_cbusy);
          req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
        end
      `endif
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;      
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending RSP_MSG_COMPDATA with data 'h%0h, wysiwyg_data 'h%0h", req_resp.data,req_resp.wysiwyg_data)});


    end
    else if ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             `ifdef SVT_CHI_ISSUE_E_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) || 
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)) begin

      /* -----\/----- EXCLUDED -----\/-----
      if ($test$plusargs("gen_slv_data_err")) begin
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});             
         req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;
        req_resp.response_resp_err_status = svt_chi_transaction::DATA_ERROR;
        req_resp.suspend_response = 1;
      end
      else if ($test$plusargs("gen_slv_non_data_err")) begin 
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});     
        req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;       
        req_resp.response_resp_err_status = svt_chi_transaction::NON_DATA_ERROR;     
        req_resp.suspend_response = 1;   
      end
      else 
       -----/\----- EXCLUDED -----/\----- */
      begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.do_dwt)begin
          `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});     
          req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;
          req_resp.response_cbusy = new[2];      
          req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
          req_resp.response_cbusy[1] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
        end else
        `endif
        begin
          `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_COMPDBIDRESP "});     
          req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;
          `ifdef SVT_CHI_ISSUE_D_ENABLE
            req_resp.response_cbusy = new[1];      
            req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
          `endif
        end
      end
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    else if(req_resp.xact_type == svt_chi_transaction::CLEANINVALID || req_resp.xact_type == svt_chi_transaction::CLEANSHARED 
            || req_resp.xact_type == svt_chi_transaction::MAKEINVALID || req_resp.xact_type == svt_chi_transaction::CLEANSHAREDPERSIST)begin
      req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMP;
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        req_resp.response_cbusy = new[1];      
        req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
      `endif //issue_d_enable
    end
    `endif//issue_b_enable
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    else if(req_resp.xact_type == svt_chi_transaction::CLEANSHAREDPERSISTSEP)begin
      case($urandom_range(2,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPPERSIST;
            if(req_resp.src_id == req_resp.return_nid) begin
              req_resp.response_cbusy = new[1];
              req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
            end
            else begin
              req_resp.response_cbusy = new[2];
              foreach(req_resp.response_cbusy[i])
                req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
            end
          end
        1: begin
           req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP_PERSIST;
            req_resp.response_cbusy = new[2];
            foreach(req_resp.response_cbusy[i])
              req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
          end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_PERSIST_COMP;
           req_resp.response_cbusy = new[2];
           foreach(req_resp.response_cbusy[i])
             req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
         end
        default: `svt_error ("body", "Error occurred while Randomizing response. Value of $urandom_range is greater than 2");
      endcase
    end
    `endif //issue_d_enable

    /* -----\/----- EXCLUDED -----\/-----
    fork
      begin
        if ((req_resp.suspend_response == 1) &&
    (
     ($test$plusargs("gen_slv_non_data_err")) ||
     ($test$plusargs("gen_slv_data_err"))
    )
           ) begin
          wait (req_resp.data_status == svt_chi_transaction::ACCEPT);
          req_resp.suspend_response = 0;
        end
      end
    join_none
     -----/\----- EXCLUDED -----/\----- */
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});

    $cast(req,req_resp);


    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_send(req)

  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_random_sequence::new(string name="svt_chi_sn_transaction_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_random_sequence::body();
  /**
   * Remove responses from the response queue
   */
  sink_responses();

  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

    `svt_xvm_rand_send(req_resp)
  end
endtask
// =============================================================================
/** 
 * @groupname CHI_SN_NULL
 * svt_chi_sn_transaction_null_sequence
 *
 * This class creates a null sequence which can be associated with a sequencer but generates no traffic.
 */
class svt_chi_sn_transaction_null_sequence extends svt_chi_sn_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_null_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_null_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_null_sequence");

  /** 
   * Executes svt_chi_sn_transaction_null_sequence sequence. 
   */
  extern virtual task body();

endclass

// =============================================================================

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_null_sequence::new(string name = "svt_chi_sn_transaction_null_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_null_sequence:: body();
endtask

// =============================================================================

`endif // GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
