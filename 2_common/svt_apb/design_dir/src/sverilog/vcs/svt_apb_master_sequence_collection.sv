`ifndef GUARD_SVT_APB_MASTER_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_APB_MASTER_SEQUENCE_COLLECTION_SV

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other master sequences
 * in the collection extend from this base sequence.
 */
class svt_apb_master_base_sequence extends svt_sequence#(svt_apb_master_transaction);

  /* Port configuration obtained from the sequencer */
  svt_apb_system_configuration cfg;

  `svt_xvm_object_utils(svt_apb_master_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)

  extern function new(string name="svt_apb_master_base_sequence");

  /** Routes messages through the parent sequencer and raises an objection */
  virtual task pre_body();
    raise_phase_objection();
  endtask

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  virtual task body();
    svt_configuration get_cfg;
    `svt_xvm_debug("body", {"Executing ", (is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"});
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_apb_system_configuration class");
    end
  endtask: body

  /** Drop objection */
  virtual task post_body();
    drop_phase_objection();
  endtask: post_body

endclass: svt_apb_master_base_sequence

// =============================================================================
/** 
 *  This sequence generates random master transactions.
 */
class svt_apb_master_random_sequence extends svt_apb_master_base_sequence;

  /** Number of Transactions in a sequence. */
  int unsigned sequence_length = 10;
 
  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)

  `svt_xvm_object_utils_begin(svt_apb_master_random_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_apb_master_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();
    /** Gets the user sequence_length. */
   
`ifdef SVT_UVM_TECHNOLOGY
   void'(uvm_config_db #(int unsigned)::get(m_sequencer,
                                            get_type_name(),
                                            "sequence_length",
                                            sequence_length) );

`else
  void'(m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length));
`endif

    `svt_xvm_debug("body", $psprintf("Sequence name: svt_apb_master_random_sequence, sequence_length='d%0d", sequence_length));

    for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_random_sequence


// =============================================================================
/** 
 *  This sequence generates alternate write and read transactions for all
 *  existing slaves. The min, mid and max data values are written and
 *  read for each slave .
 */
class svt_apb_master_blocking_write_read_all_slave_data_sequence extends svt_apb_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)
  
  `svt_xvm_object_utils(svt_apb_master_blocking_write_read_all_slave_data_sequence)
  
  function new(string name="svt_apb_master_blocking_write_read_all_slave_data_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    super.body();
    
    //sequence for prdata traversal
    for(int i = 0; i < cfg.num_slaves; i++) begin
      bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] lo_addr;
      bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] hi_addr;
      if (!cfg.get_slave_addr_range(i, lo_addr, hi_addr))
        `svt_xvm_warning("body", $sformatf("Unable to obtain an address range for slave index 'd%0d", i));
      
      //Generates WR/RD transaction with minimum data value
      `svt_xvm_do_with(req,
        {
          this.xact_type == svt_apb_transaction :: WRITE;
          address inside {[lo_addr : hi_addr]};
          this.data=='d0;
        }) 
     
      //wait for transaction to complete
      get_response(rsp);
     
      // Turn off rand_mode of the address so that we read from the same location
      req.address.rand_mode(0);
      
      // Setup the read transaction with other variables randomized
      if(!req.randomize() with {this.xact_type == svt_apb_transaction :: READ; })
        `svt_xvm_error("svt_apb_master_blocking_write_read_all_slave_data_sequence", "randomization failed");
      
      // Send the read transaction 
      `svt_xvm_send(req)
      
      // Wait for the read transaction to complete 
      get_response(rsp);  
        
      //Generates WR/RD transaction with maximum data value
      `svt_xvm_do_with(req,
        {
         this.xact_type == svt_apb_transaction :: WRITE;
         address inside {[lo_addr : hi_addr]};
         this.data==(('d2**(cfg.pdata_width))-1);
        }) 
       
      //wait for transaction to complete
      get_response(rsp);
     
      // Turn off rand_mode of the address so that we read from the same location
      req.address.rand_mode(0);
      
      // Setup the read transaction with other variables randomized
      if(!req.randomize() with {this.xact_type == svt_apb_transaction :: READ; })
        `svt_xvm_error("svt_apb_master_blocking_write_read_all_slave_data_sequence", "randomization failed");
      
      // Send the read transaction 
      `svt_xvm_send(req)
      
      // Wait for the read transaction to complete 
      get_response(rsp);  
     
      //Generates WR/RD transaction with data value between min and max
      `svt_xvm_do_with(req,
        {
          this.xact_type == svt_apb_transaction :: WRITE;
          address inside {[lo_addr : hi_addr]};
          this.data inside {['d1:(('d2**(cfg.pdata_width))-2)]};
        }) 
       
      //wait for transaction to complete
      get_response(rsp);
     
      // Turn off rand_mode of the address so that we read from the same location
      req.address.rand_mode(0);
      
      // Setup the read transaction with other variables randomized
      if(!req.randomize() with {this.xact_type == svt_apb_transaction :: READ; })
        `svt_xvm_error("svt_apb_master_blocking_write_read_all_slave_data_sequence", "randomization failed");
      
      // Send the read transaction 
      `svt_xvm_send(req)
      
      // Wait for the read transaction to complete 
      get_response(rsp);
     
    end
  endtask: body
  
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_blocking_write_read_all_slave_data_sequence


// =============================================================================
/** 
 *  This sequence generates alternate write and read transactions for
 *  minimum, middle and maximum address values to traverse the addr range.
 */
class svt_apb_master_blocking_write_read_addr_sequence extends svt_apb_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)
  
  `svt_xvm_object_utils(svt_apb_master_blocking_write_read_addr_sequence)
 
  //range values for address
  bit [`SVT_APB_MAX_ADDR_WIDTH-1 : 0] upper_range; 

  function new(string name="svt_apb_master_blocking_write_read_addr_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    super.body();
      
    /* Generate transactions for maximum address value */
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: WRITE;
        address == (('d2**(`SVT_APB_MAX_ADDR_WIDTH))-1);
      }) 
    
    //wait for transaction to complete
    get_response(rsp);
    
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: READ;
        address ==(('d2**(`SVT_APB_MAX_ADDR_WIDTH))-1);
      })
    
    //wait for transaction to complete
    get_response(rsp);
    upper_range = ('d2**(`SVT_APB_MAX_ADDR_WIDTH))-2;
    /* Generate transactions for address value between min and max */
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: WRITE;
        address inside {['d1 :upper_range]};
      })
    
    //wait for transaction to complete
    get_response(rsp);
    
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: READ;
        address inside {['d1 :upper_range]};
      })
    
    //wait for transaction to complete
    get_response(rsp);
      
    /* Generate transactions for minimum address value */
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: WRITE;
        address =='h0;
      })
    
    //wait for transaction to complete
    get_response(rsp);
    
    `svt_xvm_do_with(req,
      {
        this.xact_type == svt_apb_transaction :: READ;
        address =='h0;
      })
    
    //wait for transaction to complete
    get_response(rsp);
    
  endtask: body
  
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_blocking_write_read_addr_sequence
// =============================================================================
/** 
 * This sequence generates alternate write and read transactions, with address, data and pstrb not randomized for read.
 * This sequence can also be used for 64Bit address and Data width
 */
class apb_master_write_read_data_compare_sequence extends svt_apb_master_base_sequence;
  /** Parameter that controls the number of transactions that will be generated */
  int unsigned sequence_length = 10;
  /** Declare a typed sequencer object that the sequence can access */
  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)
  /**Object Utility macro */
  `svt_xvm_object_utils_begin(apb_master_write_read_data_compare_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_ALL_ON)
  `svt_xvm_object_utils_end

  /** Class Constructor */
  function new(string name="apb_master_write_read_data_compare_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
  bit[`SVT_APB_MAX_DATA_WIDTH -1:0] _write_data;
  svt_apb_master_transaction write_xact, read_xact;
    
`ifdef SVT_UVM_TECHNOLOGY
    void'(uvm_config_db #(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length));
`else
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif

    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d", sequence_length));

    for(int i = 0; i < sequence_length; i++) begin
      /** Set up the write transaction and populate the slave memory*/
      `svt_xvm_do_with (write_xact,{
                        write_xact.xact_type == svt_apb_transaction::WRITE;
                       });
      //wait for transaction to complete
      get_response(rsp);
      `svt_xvm_debug("body", "APB WRITE transaction completed");

      // Setup the read transaction with other variables randomized
      `svt_xvm_do_with (read_xact,{
                       read_xact.xact_type == svt_apb_transaction::READ;
                       read_xact.address == write_xact.address;
                       });
      // Wait for the read transaction to complete 
      get_response(rsp);
      `svt_xvm_debug("body", "APB READ transaction completed");

      //`svt_xvm_debug("body", $sformatf(" comparing data for addr ='h%0x write xact data: 'h%0x. read xact data: 'h%0x transaction: 'd%0d",write_xact.address, write_xact.data, read_xact.data,i));
      `svt_xvm_debug("body", $sformatf("comparing data for write %0s and read  %0s transaction: 'd%0d",`SVT_APB_PRINT_PREFIX(write_xact),`SVT_APB_PRINT_PREFIX(read_xact),i));
      if(read_xact.cfg.apb4_enable) begin
        _write_data = write_xact.data;
        foreach(write_xact.pstrb[j]) begin
          if(!write_xact.pstrb[j]) begin
            _write_data[j*8+7-:8] = 0;
          end
        end
         //  `svt_xvm_debug("body", $sformatf("comparing data for addr ='h%0x initial write xact data: 'h%0x. write_data='h%0x after  pstrb='h%0x read xact data: 'h%0x transaction: 'd%0d",write_xact.address, write_xact.data, _write_data, write_xact.pstrb, read_xact.data,i));
           `svt_xvm_debug("body", $sformatf("comparing write and read datas: %0s write_data='h%0x after  pstrb='h%0x %0s transaction: 'd%0d",`SVT_APB_PRINT_PREFIX(write_xact), _write_data, write_xact.pstrb,`SVT_APB_PRINT_PREFIX(read_xact),i));
          if(read_xact.data != _write_data) begin
           `svt_xvm_debug("body", $sformatf("comparing write and read datas: %0s write_data='h%0x after  pstrb='h%0x %0s transaction: 'd%0d",`SVT_APB_PRINT_PREFIX(write_xact), _write_data, write_xact.pstrb,`SVT_APB_PRINT_PREFIX(read_xact),i));
          end
      end
      else begin
        if(read_xact.data != write_xact.data) begin
        `svt_xvm_debug("body", $sformatf("comparing data for write %0s and read  %0s transaction: 'd%0d",`SVT_APB_PRINT_PREFIX(write_xact),`SVT_APB_PRINT_PREFIX(read_xact),i));
        end
      end
    end
    `svt_xvm_debug("body", "Exiting...");
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass: apb_master_write_read_data_compare_sequence

// =============================================================================
`protected
^D;T96&S2E>KL(-Af:D8O5__NSC<9a,&AVH1C99e]R<=4-C-&:3W()bcBb4>(3B5
)GX<(K6fDD?N#I^S@KYKV=Y;YCfUPVZI\c(ZeL:(I<2AEV1a1J;&b,\=3)g7S,(e
(S;??\&<0U#L\CEE-KWEO(?Q[MPS(aY9FE)#&/DWN3.)&931.7^3>T.S+MG>B?A)
UPXB@\b[cT>afJ4T@=+4ZG#(G#8H1.]]<?9aRfZE3AT,eaEb/KbMbZG+Y:^Qb6[]
UZQ3.dc04KDXSdBD<1IS/5\A@fC#(V,(9IeJ59ZI)#@TD:ARN+c(Q#GQRc=0YX,+
F,.K=>?+G,9(2<Y<Q1)XPDFd0LFHW1a#Je#A6(V\ACKZXLF\)4YC0e2\I+4;C@M2
;I\_+eCGa.+8SY>.U;>JbFMUe>Z[eEM:U6+&e^LMS#fgC/#\dIGQ)B<KUN)8HI:e
Cc(=DHK]eTPJ#;c/[:-dA]46DD/JRQ4MRa68>UL0E^gd5Q;QHPZ]17\eVIJE#>LO
#d0EcCD2>W)TVEW)LZ-L)XD&bcSC/FKDTP\Te7+174B^HR3.A-NVNZHEXAD.7V^=
:9+9;7&DB[_TZ99<D8Fb_2G)^,3cdINMLYW5YV7>\A-=\W55FRUEdU\-@BQZ36ec
_ZEOXV&fZOf:eMP;8=Bd[6N-50>F43&ZMWgcG(D4T90\9+>c0MMNB@EXZe5VH?X=
[?8/EgS8RQH3_J=+8AZC?<+8VE35JSN0_6KFRU@TP&>7d8/1I,gH0JQ9VV=A;3\@
J@1W6EP=:[]7DPAEb.H34_4Q>W51S@@:BIKDE0>,.YdK\;T-QG(c/UN6<SI\,CEI
W>\b?S<8?Q_IM;TK4-N4)3ZFUWPG.(#1&7eA;Y(O^V\D(D=7fMdc1\MC^a-KOVL,
Bc.5UENBO2fM2S9(WIHc@Q_JL0PJd^U\fT[X/(M;_GB>^J3,dgGB/^:<?fX&4<XI
HD?3_E>LL@aY@,N=aJXJd38eJ#;S6=2#f7-d^L+Gf-E]O2[QM:+b>1NN/7Re0fb&
F(La[:&CcDD72P67)>(?Ug94I3C=Xb][A4/d(dE9[gc\T;(cDCdW5WR;DA3&S/,d
6O_9#EE3b.CdPd@cNG5Z.(#PZF5]f++_=AeLK#6R6bbDS^g6#c9K4HYW,:g]ecSD
/4RVYf\Wf+3)#@WM>=GPXfBM;Z2DSS3&\[b^KT.ac-U5D9ZU6WdBG\?K9#^X>S2W
)R]38OD<S]>d,Pg-MXGGF;6P.WIf22TR@N3535>74;?3HG:RA]^#ae-0AD:gH:K\
e@:JA:H\>^^4&U;&<OGQ+7<W7,2<MF7<NMeQ>f+S.NRg8U<S25-?Yf1J7>N-#2dO
W?Jd.cATG6ZTaCAgMAXT8LCbdP)8?=#1dF>cgXC.W34,3?=Pc4Td1Z<:(SEZ>Zb9
82Y+Y^0/XMgR\cZ.:4E@XQMI1P0gb_,7DL_N]#4,;A_>)bf^Z_V^H&=NJRe(SdXY
.SJT[#0>L7[AE7bQ\HLUX..M+H5.#Y.[Hcb4La@A-JfB,H93Z/=0cT5B^?eeY?;_
N<HfN3JJPO2D(/SJ.I]O1CDX<FgML_JNbEIe1CD-SOU_6Z1\)9=FA6T+)8:0Ac)cR$
`endprotected


// =============================================================================
/** 
 *  This sequence generates a single random write transaction.
 */
class svt_apb_master_write_xact_sequence extends svt_apb_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)
  `svt_xvm_object_utils(svt_apb_master_write_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_APB_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Data to be written */
  rand bit [`SVT_APB_MAX_DATA_WIDTH-1 : 0] data;

  svt_apb_transaction::pprot0_enum prot_type = svt_apb_transaction::NORMAL;

  function new(string name="svt_apb_master_write_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();
    `svt_xvm_do_with(req, {
      xact_type == svt_apb_transaction::WRITE;
      address == local::addr;
      data == local::data;
      prot_type == local::prot_type;
    })
    get_response(rsp);
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_write_xact_sequence

// =============================================================================
/** 
 *  This sequence generates a single random read transaction.
 */
class svt_apb_master_read_xact_sequence extends svt_apb_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_apb_master_sequencer)
  `svt_xvm_object_utils(svt_apb_master_read_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_APB_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Expected data. This is used to check the return value. */
  bit [`SVT_APB_MAX_DATA_WIDTH-1 : 0] exp_data;

  /** Enable the check of the expected data. */
  bit check_enable = 1;

  svt_apb_transaction::pprot0_enum prot_type = svt_apb_transaction::NORMAL;

  function new(string name="svt_apb_master_read_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_apb_transaction::READ;
      address == local::addr;
      prot_type == local::prot_type;
    })

    get_response(rsp);
    // Check the read data
    if (check_enable) begin
      if (rsp.data[0] != exp_data) begin
        `svt_xvm_error("body", $sformatf("Data mismatch for read to addr=%x.  Expected %x, received %x", addr, exp_data, rsp.data[0]));
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_read_xact_sequence

`endif // GUARD_SVT_APB_MASTER_SEQUENCE_COLLECTION_SV

