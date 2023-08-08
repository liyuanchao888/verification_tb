
`ifndef GUARD_SVT_AXI_SYSTEM_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_AXI_SYSTEM_SEQUENCE_LIBRARY_SV

// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_axi_system_base_sequence extends svt_sequence;

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_system_base_sequence)
  `uvm_declare_p_sequencer(svt_axi_system_sequencer)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_system_base_sequence)
  `ovm_declare_p_sequencer(svt_axi_system_sequencer)
`endif

  /**
   * Following are the possible transaction types:
   * - WRITE    : Represent a WRITE transaction. 
   * - READ     : Represents a READ transaction.
   * - COHERENT : Represents a COHERENT transaction.
   * .
   *
   * Please note that WRITE and READ transaction type is valid for
   * #svt_axi_port_configuration::axi_interface_type is AXI3/AXI4/AXI4_LITE and
   * COHERENT transaction type is valid for
   * #svt_axi_port_configuration::axi_interface_type is AXI_ACE.
   */
  rand svt_axi_transaction::xact_type_enum _read_xact_type[int],_write_xact_type[int];

  /** Handles to get system configuration */
  svt_configuration base_cfg;
  svt_axi_system_configuration sys_cfg;

  local semaphore sink_response_sema = new(1);

  extern function new(string name="svt_axi_system_base_sequence");

  /** Initiating Master index **/
  rand int unsigned initiating_master_index;
  
  int initiating_master_port_id;

  /** Initiating Slave index **/
  rand int unsigned active_participating_slave_index;

  /** Initiating Slave index **/
  rand int unsigned participating_slave_index;

  /** Array of masters that are participating and active **/
  int active_participating_masters[int];

  /** Array of slaves that are participating and active **/
  int active_participating_slaves[int];

  /** Array of slaves that are participating in the system so that the transactions from the master can be routed to the slaves in this array **/
  int participating_slaves_arr[int];

  /** This bit silent is used typically to suppress is_supported message */
  bit silent;

  /** Represents the length of the sequence. */
  int unsigned sequence_length = 10;

  /** Status filed for capturing config DB get status for sequence_length */
  bit sequence_length_status;

  /** Status filed for capturing config DB get status for silent */  
  bit silent_status;

  /** This bit indicates whether the arrays related to various types of nodes
   *  are populated or not. 
   *  This is used by the sequence for maitaining the infrastructure, and should
   *  not be programmed by user.
   */
  bit is_participating_master_slaves_array_setup = 0;

  /** Represents the master port from which the sequence will be initiated. 
   *  This can be controlled through config DB. 
   */ 
  int unsigned master_index_0;
  
  int unsigned master_index_1;

  /** Represents the slave port from which the sequence will be initiated. 
   *  This can be controlled through config DB. 
   */ 
  int unsigned slave_index_0;

  int unsigned slave_index_1;
  
  /** Status field for capturing config DB get status for master_index */
  bit master_index_status_0;

  bit master_index_status_1;
  
  /** Status field for capturing config DB get status for slave_index */
  bit slave_index_status_0;

  bit slave_index_status_1;

  /** Randomize the initiatiating master **/
  constraint initiating_masters_c {
    if (active_participating_masters.size())
    {
     initiating_master_index inside {active_participating_masters};
    }
  }  

   /** Randomize the initiatiating slave **/
  constraint active_participating_slaves_c {
    if (active_participating_slaves.size())
    {
     active_participating_slave_index inside {active_participating_slaves};
    }
  }

  /** Randomize the participating slave **/
  constraint participating_slaves_c {
    if (participating_slaves_arr.size())
    {
     participating_slave_index inside {participating_slaves_arr};
    }
  }
  
  /** pre_body() task which is called before task body() */
  extern virtual task pre_body();

  /** post_body() task which is called after task body() */
  extern virtual task post_body();

  /** Used to sink the responses collected in response queue */
  extern virtual task sink_responses();

  /** Function returns svt_axi_system_configuration handle */
  extern virtual function svt_axi_system_configuration get_sys_cfg();

  /** Function returns array of slave indexes which are Active */
  extern virtual function void get_active_slaves(ref int active_slaves[], svt_axi_system_configuration sys_cfg);
  
  /** Function returns array of master indexes which are Active */
  extern virtual function void get_active_masters(ref int active_masters[], svt_axi_system_configuration sys_cfg);

  /** Function returns queque of addr which are non overlapping */ 
  extern virtual function void get_nonoverlap_addr(ref svt_axi_transaction addr_collection_q[$],int num_of_addr,svt_axi_system_configuration sys_cfg,int slv,int mstr);
  
  /** Function returns minimum id width value for write channel among the array of masters given as input to 
   *  the function 
   */
  extern virtual function int get_min_wr_chan_id_width(ref int component[], svt_axi_system_configuration sys_cfg);
  
  /** Function returns minimum id width value for read channel among the array of masters given as input to 
   *  the function 
   */
  extern virtual function int get_min_rd_chan_id_width(ref int component[], svt_axi_system_configuration sys_cfg);

  /** Function returns id width for write channel */
  extern virtual function int get_wr_chan_id_width(svt_axi_port_configuration port_cfg); 
  
  /** Function returns id width for read channel */
  extern virtual function int get_rd_chan_id_width(svt_axi_port_configuration port_cfg); 

  /** Function returns minimum id width between write and read channel of particular port */
  extern virtual function int get_min_id_width(svt_axi_port_configuration port_cfg);

  virtual function bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_tagged_addr(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] arg_addr, bit mstr_id=0);
    svt_axi_transaction _xact;
    _xact = new("temp_svt_axi_transaction",sys_cfg.master_cfg[mstr_id]);
    return(_xact.get_tagged_addr(1,arg_addr));
  endfunction

  /** Setup participating masters and slaves */  
  function void setup_participating_master_slave_arrays();
    bit is_participating_slave_exists = 0;
    `svt_xvm_debug("setup_participating_master_slave_arrays","Entered ...") 
    if(sys_cfg == null) begin
      p_sequencer.get_cfg(base_cfg);
      if (!$cast(sys_cfg, base_cfg)) begin
        `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
      end
    end

    if (!is_participating_master_slaves_array_setup) begin
      int index_mstr=0;
      int index_slv =0;
      int index_participate_slv =0;

      if((!master_index_status_0) && (!master_index_status_1)) begin
        foreach(sys_cfg.master_cfg[mstr])  begin
          if((sys_cfg.master_cfg[mstr].is_active == 1) && (sys_cfg.is_participating(mstr) == 1 ))  begin
            active_participating_masters[index_mstr++] = mstr;  
            `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" master id that is active & participating is ='d%0d ",mstr));
          end
        end
      end
      else begin
        if(master_index_status_0) begin
          if((sys_cfg.master_cfg[master_index_0].is_active == 1) && (sys_cfg.is_participating(master_index_0) == 1 ))  begin
            active_participating_masters[index_mstr++] = master_index_0;  
            `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed master id that is active & participating is ='d%0d ",master_index_0));
          end
        end
        if(master_index_status_1) begin
            if((sys_cfg.master_cfg[master_index_1].is_active == 1) && (sys_cfg.is_participating(master_index_1) == 1 ))  begin
              active_participating_masters[index_mstr++] = master_index_1;  
              `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed master id that is active & participating is ='d%0d ",master_index_1));
            end
        end
      end

      foreach(sys_cfg.slave_cfg[slv])  begin
        if(sys_cfg.is_participating_slave(slv) == 1) begin
           is_participating_slave_exists = 1;
        end
      end

      if((slave_index_status_0) || (slave_index_status_1)) begin
        if(slave_index_status_0) begin
          if((sys_cfg.slave_cfg[slave_index_0].is_active == 1) && (sys_cfg.is_participating_slave(slave_index_0) == 1 ))  begin
            active_participating_slaves[index_slv++] = slave_index_0;  
            `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed slave id that is active & participating is ='d%0d ",slave_index_0));
          end
          if(sys_cfg.is_participating_slave(slave_index_0) == 1) begin
            participating_slaves_arr[index_participate_slv++] = slave_index_0;
            `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed slave id that is participating is ='d%0d ",slave_index_0));
          end
        end
        if(slave_index_status_1) begin
            if((sys_cfg.slave_cfg[slave_index_1].is_active == 1) && (sys_cfg.is_participating_slave(slave_index_1) == 1 ))  begin
              active_participating_slaves[index_slv++] = slave_index_1;  
              `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed slave id that is active & participating is ='d%0d ",slave_index_1));
            end
            if(sys_cfg.is_participating_slave(slave_index_1) == 1) begin
              participating_slaves_arr[index_participate_slv++] = slave_index_1;
              `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" programmed slave id that is participating is ='d%0d ",slave_index_1));
            end
        end
      end
      else if (is_participating_slave_exists) begin
        foreach(sys_cfg.slave_cfg[slv])  begin
          if((sys_cfg.slave_cfg[slv].is_active == 1) && (sys_cfg.is_participating_slave(slv) == 1 ))  begin
            active_participating_slaves[index_slv++] = slv;  
            `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" slave id that is active & participating is ='d%0d ",slv));
          end
          if(sys_cfg.is_participating_slave(slv) == 1) begin
            participating_slaves_arr[index_participate_slv++] = slv;
            `svt_xvm_note("svt_axi_system_base_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
          end
        end
      end
      else begin
        foreach(sys_cfg.slave_cfg[slv])  begin
          participating_slaves_arr[index_participate_slv++] = slv;
          `svt_xvm_note("svt_axi_system_base_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
          if((sys_cfg.slave_cfg[slv].is_active == 1)) begin  
            active_participating_slaves[index_slv++] = slv;  
          `svt_xvm_debug("svt_axi_system_base_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
          end
        end
      end
      is_participating_master_slaves_array_setup=1;
    end // if (!is_participating_master_slaves_array_setup)
    `svt_xvm_debug("setup_participating_master_slave_arrays","Exiting ...") 

  endfunction: setup_participating_master_slave_arrays

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    `svt_xvm_debug("svt_axi_system_base_sequence::pre_randomize()","Entered ...");      
    super.pre_randomize();
`ifdef SVT_UVM_TECHNOLOGY
    master_index_status_0 = uvm_config_db#(int unsigned)::get(null, get_full_name(), "master_index_0",master_index_0);
    master_index_status_1 = uvm_config_db#(int unsigned)::get(null, get_full_name(), "master_index_1",master_index_1);
    slave_index_status_0  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_0", slave_index_0);
    slave_index_status_1  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_1", slave_index_1);
`elsif SVT_OVM_TECHNOLOGY
    master_index_status_0 = m_sequencer.get_config_int({get_full_name(), ".master_index_0"}, master_index_0);
    master_index_status_1 = m_sequencer.get_config_int({get_full_name(), ".master_index_1"}, master_index_1);
    slave_index_status_0  = m_sequencer.get_config_int({get_full_name(), ".slave_index_0"}, slave_index_0);
    slave_index_status_1  = m_sequencer.get_config_int({get_full_name(), ".slave_index_1"}, slave_index_1);
`endif
    `svt_xvm_debug("body", $sformatf("programmed master_index_0 is 'd%0d as a result of %0s.",master_index_0, master_index_status_0 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed master_index_1 is 'd%0d as a result of %0s.",master_index_1, master_index_status_1 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed slave_index_0 is 'd%0d as a result of %0s.",slave_index_0, slave_index_status_0 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed slave_index_1 is 'd%0d as a result of %0s.",slave_index_1, slave_index_status_1 ? "config DB" : "default value"));
    setup_participating_master_slave_arrays();
    `svt_xvm_debug("svt_axi_system_base_sequence::pre_randomize()","Exiting ...");  
  endfunction: pre_randomize

  /** Pre-start method for inintializing the master and slave array that are participating */
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    `svt_xvm_debug("svt_axi_system_base_virtual_sequence::pre_start()","Entered ...") 
    super.pre_start();
    setup_participating_master_slave_arrays();
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    silent_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "silent", silent);
    
    foreach(active_participating_masters[i]) begin
      automatic int mstr = active_participating_masters[i];
      if ((sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (sys_cfg.master_cfg[mstr].axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
        _read_xact_type[mstr]  = svt_axi_transaction::COHERENT;
        _write_xact_type[mstr] = svt_axi_transaction::COHERENT;
      end
      else begin
        _read_xact_type[mstr]  = svt_axi_transaction::READ;
        _write_xact_type[mstr] = svt_axi_transaction::WRITE;
      end
    end
        
    `svt_xvm_note("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, sequence_length_status ? "config DB" : "default value"));
    `svt_xvm_note("body", $sformatf("silent is 'd%0d as a result of %0s.", silent, silent_status ? "config DB" : "default value"));

    `svt_xvm_debug("svt_axi_system_base_sequence::pre_start()","Exiting ...")    

  endtask // pre_start
`endif

endclass: svt_axi_system_base_sequence


// =============================================================================
/**
 * This sequence allows unconstrained random traffic for all ports
 */
class svt_axi_system_random_sequence extends svt_axi_system_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_system_random_sequence)
  `uvm_declare_p_sequencer(svt_axi_system_sequencer)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_system_random_sequence)
  `ovm_declare_p_sequencer(svt_axi_system_sequencer)
`endif

  function new(string name="svt_axi_system_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // just extended so that UVM doesn't complain about a missing body implementation
  endtask: body
endclass

`protected
]:Hg)AFERZYbG^)XK[gKb<gc&B\F]7R0X8@-d15]\/-QTGIM5A:C/)N8(KB75/U6
Wb[2DY?Qd#4eH&f_URF:RIbET^LYPQD,MK3,)+57LKY<YI_GO3._caK<ZGBZDODb
#U:JK\GC1(fDMOQ\b,@TZT>H3YYK?@6]^MBBV]2bgLWVa>gYcCaCN9EWa&LX;_d_
MA8?FQM<P8MN737;KZML4WW4BQFFR=\BZA0@Q[;67-[cV5Q,J[5b&c^)8<U=V0:e
M+Ggg]MXLQ_W8/edX;3\-cAYfCBgP,,eIbW:5YfX5:/N9.G85G4e.8C313-\XMB(
TbG\&VVH7.0AY:Z\?E>5Fc.CL):,cY_6H5CgR<<5H;1>=4):,;\D47^F&:LK[I>V
/);8[]V:]7MCNQbJOSRO.DU@R@5bb))ME=/<DZ24FUJQL4X)&[6Y--.+L2282+R;
-TS^ga_RH2BF(,38V[QD&UTg&MZD^2K0-fDD)Y8\(8ZUbHJ)&,H5R1GN#/LYgKO)
[O]RW7c6Z@<;#I+IAQMNI3?_=<7T.bP3SbWD7:L#FO>/PK=08^Q[U)6V03#TZ9#M
O^)7>J<ZPRg>Ne\Y^ea0;F0T3g.Q(-8g&RHB,]49V#MU7b=99gZ#=]b^RQK9M33b
2>R9PM,66#B&H1_K2@fQaaTc2dg_#VE[5VQaZO:Y=KO+.aL.K2.IgOd1NP9=Sb?O
>D)c-_0[FCb>0,8A2)a#2#GL\<Lf;L-Y<4C8/L^M889T&0@-DX=?0[G[/B#(SbJN
TU)UWBPagY(0](G]18dK?EPK6ZVKcFF.g^U#Y[Y)WHK&c.S+J^?W&;(e?O4WQZ_d
7#S;TKYAJ4e?cH^;ZV6Gd+^IT,4b?c/)Q)27@Ae22OU5b?f8FH;\a>^Y4b]U&<T?
XIg6c(YGEd4:6X&P^#N+D5[2^2YS^YV:Fc(_4FH6IO/9Y\(=F/(P@@4P.4_11DTY
?@)ZQ6G#cRScJOHX&UXW2?GYV/a&3FeIL5R34O^^dV[?I^\<[Ug0E/a9_)\ZBKJV
&LU;2E8(^OYGEQS6]SG,X6]>g9LfVg&fU4O;17+/XO9Q>7Mc\Y:a<K&fZ^S^CS.P
2<fL03])1L.DIg^J(b>;28/g;-1d#GOfTMRd<YR9SJ8T0B.Ze+N[[C&-MM+Nga?4
S9Y;+LTJY5,O>(14BadF3N(>L]665ec-]KI3)<@KaaVfefeS8beTJSfUJ&WdG)B6
d.f?NG1K<fNbI/Gae0>N,1T.;c2IUc1D&@1_,<V435Z2f49SH.KJ=PHWJ5D00DT[
]=bGL\=H@[PaIb4[COCMR(CKDG,gMg0J)[F2EP7bNSE9]Z5e.U_8RN1/74IZ)S6^
=HSII\H88eR;TP_gfeX84f73\9W;;:Q6P,4K2.1T,HUZTR\(7QbKDJaJ043Z<C2[
XH>JX:H-8LTK9,7I[Z\1<:H7KY-?X(I(UOF]0&#(CST@):VYF1AML1.cc;a_::(<
U6P8H2,dcV:g7R6P(IP&PM67-d+V;Y9_CEPOV#<RcW>deMZY6UdLI6M-/-RMHYf<
-ZBKQ1;CE;8f8@T1_7CDMX4WREP4-L8L_A&+[8A<NLf&2TR7?DZP;OL6U/Ha\8ST
HMJf;W<N9?MWKVcA7=1MN1)5ON/CJV<13UeDL^1bN/:,Y?_JGQda6;N3S&B86d:>
d)X[YH^I0:<:9P,YbdQ8Jc<C]O&1[I].E-0S>0Wa>[?87a&+U(IKG<X;IYFH[L_H
CgW7]\eJ2I(aBL5[.OTbO8\0=B.L5]QX1].A/LJf-R?fWU^.bM@9aJ^#=S6C,^Y@
G#8;JWg-3OZ^NFV(2US5S<I+EB]LeH206X\B8=0?C0O,(BGVE4.7S+0caE=WQ2::
4<[0gHJ)>RSNBK79EE_S:.&XB7Q>&U>3__>?DbgeH.&eZ\)0,67-8TK,bT0;1E.5
3JHB+c>.0.VbS[@Z=+UdDabe=R[8Q.TbOF&N/^^[YEbU5O7;b7D.Q&^W3RNGd505
HS;[N3P)^:dBPd<R7A4aEQUYPT^+bWY7-(ZU3)WA0Y1Mb[fZ=8+6[D]MYTK8T6O/
-ZT._24L-dTE>,@UZDYIT[J6,Cf&W:BLU3J-Z(;-=/7/.P7GO0/=K6W]J=G=ZV\b
e;EJc+X\Q9SDXKE.Bf[V5O#Gc#BX+L2X;6\^.]&&F/bcNc<E4ePUI;4b:gGDD9?c
7C05IR+^;O@e:-.8A,DCB>@KMN1_Rd)F7C/LCZLE,.0NfCcZ?CJ?Z?eKA;1;If13
Ie#H+(&fE)B8cf?7NHJb/9#agG4DAZE5J_MV>0,X8eOMg:Q9)0N-WO8U8(bF4g;b
-GOO)1KD[5dAP/RTOIKVRgB/ZQ=HWY)a<=.5-Te-76g^b5Bf^&DW(_Z[1,HUV,5E
g=bbQgRQF8G7^X[:2^.,+XVMP,=e-11QBMNTH&dMQKW\DaP.c&@R^J>XQ@b67^(A
Wf_^B;J646DH6(\cc\O@<9+Q9WZeV=F]GQ#2=T43O>-3@G-I)E2EFP&D7#02e)=A
8<H4dVaU3eb(3BDWVc,LO3LcgL3\CWO-#PGEG.27L-\7E@4&Z&?T1TYS.6,[93,O
a+gd3;;>+:I0BQM;\==W=NWXL9?[=N33MfKJgDQ>PSaJ[F&O1SP(48GP(-gL[.?3
J41]H81AJ39#cC.H+-4<T)-\?\<^RJ[c^8>G.3Oag@dD_L\3DB13&)HAgVWCgUC9
XD,NPW\LXSN0>IN;1OU>U]CQPB>;KVL4\[LQ?&U[B;5=\gbdEF44@RcJ12)U#bVW
IYS97g]_>ffL,48:)8f=c(X26.FEHW;]BZ+4-@GPRL//_1],;>,J<-+0[7Y)gGEg
;:A/<]^&bf_:8=KJG5TX#JQ^;H^6)+L3&R6a^\]cALGcEF5e5]&4C8BLaXIc&GW6
,MNQS_<0#FAS9?\a3:0M2Q-&2AL-\Ug^0GJf)eZ1R-FIc.DRb#[J@#,]AEB4+0^X
[?>\XMGIF/eBM]._BZ2:+0RX^QX,)^7LMg=fXP]12U?R:&G08Y[JICK+SSHcE/]^
^6/-@aW-7-.:_>M^OFE.+H)5KZS,ac7HY@,7IR6B1Fg.\O_gd<6P>UV=RdaH@LVG
+QBE5LW,Q@;YA3W=IR2#W(B?XH84QL\^ND6(d+fL^?0IY?aZYLQZET[EK+1#7H>;
.bSe:8[5g-07IW?K<_45@KW\fPV;)Q[8#,@-+a5[)b.\_e,df,18;XggEaWL16JI
D.;7H@@Y\6+L;+EYgUHVWWTZdWdPFYSXA3GV&aA<I9._.J-326XD_>/VFJL/NGH8
KDXDDP@IB)+=BWAN]_/S(<0afWOTCQT7UeS44&f4Ia<4Y/KM[BW&AJ;EgVDK0);c
g-W_V+<T;=AcJDGAS8XIfJIfI9\(J-S)Y3.eD\6VSY1I_2C\P-0ZSHV,1V,#cg6E
\3AB<4VG./FCI>;E6AIbT93gI=QI0399,T92)(0@(bXW/@YSPY:YE+@8F@12G];A
:dWZ6H7bD)_5e\&f_B2eTUe7CFRCS+[PIAd_)U;;S;,\DC15)[S&=aV2B1d_H(:2
<HI?a#1RWg<G9<@&;6KdSbEQ,K<f#WV5M28N2FA#J=9Y=0D<a7J5gFJg&G(4U9XI
b?g-G;[Q_CY+FbM>Ra8/<aV(J\-J:SaC6@P<9&AcXIAKKAE<U==ZJ8S[H4=T#4)=
:OS]1_V1+bY[Z:4^@RDPU.;B8^JKL6(F6@,AfYLcb(K&4O?Q=QPId\2\Ab2a(>Q-
Y4<,#+&<LA@WW_9fD6W>T]gQgDCTH_[6=E<M]QZ9[CeeEf4.(^W/8=HZ.e&SgT@d
?1+6-=W9:[U4bI;Q\^+\.bZAd^]6VD.WQ[U>W5T_[Xfgd5-QN6_XK/4)(6gH2^cI
D[V/TJW//[ee^><F9Mg1:b)b?R/7WKPfcIa\)OFcNAI:PUN)BN^cPS8TPf2OB]&6
\V=^_12AXS@-J]T]?,b]#7O7?=?P_F(>)5TQGCaTKg4aEZgU3YKEY^Vg1ZMT6CNZ
\P-GWC]=IPb@#fKZT7;2N6V/51R=Q#LWS5>:X,PCE_:6gL#e]@e<CHW^X3NVY.4&
L6?POK4d^I->ZGO=Of\W<#_2>C5a:GbYFKU/-dY+;.QZQ]2]-&?\OAE1)&5H>\9?
8V?<)Z=gVYWONXY=g?PeC9d_\87[.WT,LZb@d3A0#R1;ba)-M<Y0OaEd:DG[<;X(
;K?LJE7DW5ST/+G]eMU;#C9E^E(^=G+Z0A#KPeGDJ2:^GW;@F#8-Z6HCZ(M^c5G1
>a&IZG5L8UI-(QNGHd+-+;.(8))BRA4HEH^]2T2PJ01D]9f6X@c2]==_FEO[a_9[
GG]PGCGZe8JPBE\1G(+LG?YgXN,+#_Rd3]=D?M[P(8Y:K_9WE<g_GE-:UHHBF^J/
Bg_c<YKV]&g:;I&18D)W#5L4O_Q^P7W.eL+-\,g2MP=cUT-2D8=9?PQ/_eW;Zc\M
6Mg3e5?CSG:?S-MK=>L3c[=_9+-X\Hd.d3Qae74b(B]C+2O<BWB1-)dOa7<WUb=M
@287-#5GIG0[=Bc^6@VBf])8[;IZ)[.1\=C]RA+):2@:[_7\M8d#1<Cc3H[+_G9]
8Dd(R<[#9(;_N<>V\c-I/)cG=8LF3B/I7[<FWE^1C\94Z]CNd[WgTHGZ&.K:(BTS
1D5fLJ)TN[QcXcga#;B3[5a\X,6S9b)JMD0]aCWHV&JT+CYF,]f(_CKg9e,g?/Vf
<3#XN#\gVf(AR;FH\;=#<5(eAYE4(Q=W7DWW_3<c-8BM8CPIDD)YBc[5[C4M#>aI
/dg\)=N.&XOU&&6Q#W,:^&>1eZ3Sd]PS,QeB/R7BbS)#6@=^J,M/]8:a,Qd<.4eU
d-:2/BJ.TQ_H:)@9e?8aCJK+Z<Z0&PcDgLb#DK2cG/QNO>(24d0UdZC=+M2G\gWS
D#2g:b?A7DNUdR]Z<]<<_g3MDJQ2>AZ#B:/.FaCGYX?bbH&,3Egd?UJJB7COW,^X
>VM5Wc5TVZ;90LgN0RKTRA3W4]aL^7-V[A^.c2RP;G6I&9F:T^UZ1<YBR6Z,>)Y<
>_?TCEK:)L.-fOWP>5gC(UUK4D4\1#HMA9)^IAO.DWU.,U#&QBG_@/M,SfDV]Q+5
TgbGIb<95R@H_+8S_WMFW,?^Ief\+d^)=(^g&b\TQ5WC174W8D-UK>#,1B^cD4S[
G;Z7a95CY0&Y95=1Jb.S_K.g?TWN(gQBQRE[)([<fD]]9T#TE<D+JB.dP:/USYH=
(B(fcMSQIcB1JE[]cU>M/C&eCGd4A]G-?+>WOgA\4QKRLd.-bK2B1N-VXBc?eQ@a
MX_IS3BK;&fM=U_X[OC+^0MYWI47KEB[A?1/ZB;9Y23AWP6U&NXPbd;NOXQ()D)S
GS,@HQLVB2U)c<e)P&<GJWc/R/2L,fP<+HM&bHFX34Q5c2+P^ZDD]74#-PAa^d,M
SV&fJ\NPW\;XO94Sd+J3JC/Y(?J:6Q^PE>8/ca4CX65^6/G\M#+3;P(/THE4Fd5A
gGbHIeH-XT(JE_93CSA>0Y4Z1Od)FJ+=F>g8?Nf-:662c:<KQAEaEO]@fP?a&9IK
SK4OOO<./=24>^L_[,3G<UAC:780MK?e61HS<K>HFZLV6IaS7:6]fgYL.]J.RI@1
<^B/&d])414_O/#B7W&@SCR7a_A+.PP+DBWC[WEV3TaeDUYERBBBegK4#RGJg.[b
9SA_dOO>Z/Sd]L-BPQ,QUI^KOVBN/CJ\Y\TV>3K@T>\e=47A:5EVHX]2(N^+J964
bB,5C1I./F>_fN1W0e:L4Xa>6]gB#68:&)/2J6,g2.eFe65<Z=OZ([fC>MeFEKFT
OC11O1ZL+:NW0FF]Y:ccCVR(<O&CbLI^A9IYZUg?ABF<7@35PdaJ(;c7gH>O?2)S
Jf,g9SF][dMXBT:+fePKMIS]@S9FA.>7I/,c>&=Fg7PJSTDVAe0#9f;&c7X#X[_g
U\gcQ^a<227:bKU=>9P(Pb;UP;QdS2P@Z-.^R<FFNH3ECUXV+PMIW^e=X6JZaPb,
\4QKI11J>)I+I59N(@7#(gD&57#JYL78#e-M3(KAOE)#G23@b;bG)>TW5d58(;VK
W4_bVZe?]#0<<Ze,[gSN6a&9U34:[<^9aQ&BWO4SA6+KB<YK,&W10Rae9JQS&D7-
GHdJM;;00K>I9HOeL;EeMRTJZ)F7/K@P>)->XZWK;UZ4S61_V4=:\2c0MY.LPMc5
]/R:Y/_6P.&e;NO2=O7W)(VJg/:(80Tf_7<>f_U\A4P]g]Y#CSE\84EG++22KNNX
3_6e&H3SSf0(:Y-I588gR1JPB+8Qg#BO&9.MDS/8T(e<W1/+aRFH==7NHc)V)3OD
;AQYO/V>QgI2RBT5[NU)L/;Q@T3F&L7^?/4/[<(dU]eM1c<:ceB&c-8H?b<MPY-(
L:?EYX_7fAV21>_69W;[5.71S<e+f]bQ#>)Q6=AD-Mb1RX+AG-XR/[NZMI-dUJS7
3X^OABL\#geb\6GT5;P8\Me\=8bUP7#H?QU&VH-d\=DQPB]B[F(1IQ=a8(K71,e)
f[@NC5b48GQWLK+]P2e)B<8Qge:?fVb7YPK0:?e9C&c>)0FUZZAKC0QYMKC)EFAR
/)XMV\E@9MJ2Ffc,R/:6WP<cgEW_&Z;&7&9>Z\.;]+5FbJ.f\-3XX.YMB^0/@1D;
JA?D@D#13G-Q4aa:MNY8)H9F9L1dHL5]=Z:VD^3,/@^c>^@L;dT;D7/c55JHR59+
GPM5&EIV0S?S18=^EEdag>J10P&Se(=gG\R#-2&BE^Q4R5Y;Q+e\_2J\3E:NS6)?
CH^YbLBBVR.6NC;:e@f@@=F:SJ/?;U?dfNc7J>Ya=T(GY]\XNULdE9ON(8S-WS,f
ZeGJgDQFB\08&HfQ3cP[#2,f9A4_Z/LF#1[S0QNbdVfgQK1,U=8S2?8C8GZ>Q5b8
,/A.0X&KDLD_ZG::P:V0cF0b9TgYOgPHe2CP?#Oc6L7=3e#gF>BAC=\1N-5?#=@:
0ZZdJMae9^V3@>.C4#DH--)[V00?,E6f\/e652)N-RGQON5^U\)0c?(5Z@T>/+&D
^dR^&0T\:9(GPa4CJG@+1(D[JS,-UE<=BTPXOK&Q8>eR=\:9^S<P^4<a86TY<IKZ
55T:F;\@b&:Z+V=RGM3&H,Me.I,#D<A[41F8G/#4<NIeCCQ6HDFQ#[D@MXT:FW(/
.Ce^_L53c[C+=/-F0D\PLB0M5^C3A:?GE&Y(S\\0U#SZ\I:5G=,M?Qb(VF+g>_].
Y)D,=UC0CYQQNO\EQQ.,EG;2(P(=ABK.L#Ob3bEW64F\6^cILGK9;55IDL/FaHVb
BgKA8W^(XTL^@=gS^-+TBLJ1Q:U?24&Jbd2ZS+]N>UJ,_V.,W;3Z;8\&K\N[C6cM
NFWR/Q<:/Ua&ec3L\8QD2CJ12$
`endprotected


`ifdef SVT_ACE5_ENABLE

class axi_master_atomic_store_xact_base_virtual_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length_local;
  
  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length_local <= 100;
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_store_xact_base_virtual_sequence)
  
  /** Class Constructor */
  function new (string name = "axi_master_atomic_store_xact_base_virtual_sequence");
    super.new(name);
  endfunction : new
  /** Raise an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY  
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body
`endif
  /** Drop an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
`endif  
  virtual task body();
    bit start_addr_status , end_addr_status;
    bit atomic_xact_op_type_status = 0 ;
    bit sequence_length_status = 0 ;
    int counter = 0;
    int local_sequence_length;
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  local_start_addr; 
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] local_end_addr;
    int unsigned atomic_xact_type=0;
    svt_axi_transaction::atomic_xact_op_type_enum atomic_xact_op_type;

    axi_master_atomic_store_xact_base_sequence master_wb_seq;

    `svt_xvm_note("body", "Entered...")

`ifdef SVT_UVM_TECHNOLOGY
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    atomic_xact_op_type_status = uvm_config_db#(svt_axi_transaction::atomic_xact_op_type_enum)::get(null, get_full_name(), "atomic_xact_op_type", atomic_xact_op_type);
    start_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "start_addr", start_addr);
    end_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "end_addr", end_addr);
`else
    sequence_length_status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    start_addr_status = m_sequencer.get_config_int({get_type_name(), ".start_addr"}, start_addr);
    end_addr_status = m_sequencer.get_config_int({get_type_name(), ".end_addr"}, end_addr);
`endif    

      /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */

     local_sequence_length = sequence_length;
     local_start_addr = start_addr;
     local_end_addr = end_addr;

    `svt_xvm_debug("body_samo", $sformatf("local_sequence_length=%0d, atomic_xact_op_type=%0p, start_addr=%0h, end_addr=%0h.", local_sequence_length,atomic_xact_op_type,start_addr,end_addr ));

    `svt_xvm_do_on_with(master_wb_seq, p_sequencer.master_sequencer[0], {sequence_length == local_sequence_length;
                  atomic_xact_store_type == atomic_xact_op_type; start_addr == local_start_addr;end_addr == local_end_addr;})

 
    `svt_xvm_note("body", "Exiting...")
  endtask: body

endclass  //axi_master_atomic_store_xact_base_virtual_sequence

class axi_master_atomic_load_xact_base_virtual_sequence extends svt_axi_system_base_sequence;

 /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length_local;
  
  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length_local <= 100;
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_load_xact_base_virtual_sequence)
  
  /** Class Constructor */
  function new (string name = "axi_master_atomic_load_xact_base_virtual_sequence");
    super.new(name);
  endfunction : new
  /** Raise an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY  
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body
`endif
  /** Drop an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
`endif  
  virtual task body();
    bit start_addr_status , end_addr_status;
    bit atomic_xact_op_type_status = 0 ;
    bit sequence_length_status = 0 ;
    int counter = 0;
    int local_sequence_length;
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  local_start_addr; 
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] local_end_addr;
    int unsigned atomic_xact_type=0;
    svt_axi_transaction::atomic_xact_op_type_enum atomic_xact_op_type;

    axi_master_atomic_load_xact_base_sequence master_wb_seq;

    `svt_xvm_note("body", "Entered...")

`ifdef SVT_UVM_TECHNOLOGY
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    atomic_xact_op_type_status = uvm_config_db#(svt_axi_transaction::atomic_xact_op_type_enum)::get(null, get_full_name(), "atomic_xact_op_type", atomic_xact_op_type);
    start_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "start_addr", start_addr);
    end_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "end_addr", end_addr);
`else
    sequence_length_status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    start_addr_status = m_sequencer.get_config_int({get_type_name(), ".start_addr"}, start_addr);
    end_addr_status = m_sequencer.get_config_int({get_type_name(), ".end_addr"}, end_addr);
`endif    

      /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */

     local_sequence_length = sequence_length;
     local_start_addr = start_addr;
     local_end_addr = end_addr;

    `svt_xvm_debug("body_samo", $sformatf("local_sequence_length=%0d, atomic_xact_op_type=%0p, start_addr=%0h, end_addr=%0h.", local_sequence_length,atomic_xact_op_type,start_addr,end_addr ));

    `svt_xvm_do_on_with(master_wb_seq, p_sequencer.master_sequencer[0], {sequence_length == local_sequence_length;
                  atomic_xact_load_type == atomic_xact_op_type; start_addr == local_start_addr;end_addr == local_end_addr;})

 
    `svt_xvm_note("body", "Exiting...")
  endtask: body

endclass  //axi_master_atomic_load_xact_base_virtual_sequence

class axi_master_atomic_compare_xact_base_virtual_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length_local;
  
  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length_local <= 100;
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_compare_xact_base_virtual_sequence)
  
  /** Class Constructor */
  function new (string name = "axi_master_atomic_compare_xact_base_virtual_sequence");
    super.new(name);
  endfunction : new
  /** Raise an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY  
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body
`endif
  /** Drop an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
`endif  
  virtual task body();
    bit start_addr_status , end_addr_status;
    bit atomic_xact_op_type_status = 0 ;
    bit sequence_length_status = 0 ;
    int counter = 0;
    int local_sequence_length;
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  local_start_addr; 
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] local_end_addr;

    axi_master_atomic_compare_xact_base_sequence master_wb_seq;

    `svt_xvm_note("body", "Entered...")

`ifdef SVT_UVM_TECHNOLOGY
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    start_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "start_addr", start_addr);
    end_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "end_addr", end_addr);
`else
    sequence_length_status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    start_addr_status = m_sequencer.get_config_int({get_type_name(), ".start_addr"}, start_addr);
    end_addr_status = m_sequencer.get_config_int({get_type_name(), ".end_addr"}, end_addr);
`endif    

      /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */

     local_sequence_length = sequence_length;
     local_start_addr = start_addr;
     local_end_addr = end_addr;

    `svt_xvm_debug("body_samo", $sformatf("local_sequence_length=%0d, start_addr=%0h, end_addr=%0h.", local_sequence_length,start_addr,end_addr ));

    `svt_xvm_do_on_with(master_wb_seq, p_sequencer.master_sequencer[0], {sequence_length == local_sequence_length;
                  start_addr == local_start_addr;end_addr == local_end_addr;})

 
    `svt_xvm_note("body", "Exiting...")
  endtask: body


endclass  //axi_master_atomic_compare_xact_base_virtual_sequence

class axi_master_atomic_swap_xact_base_virtual_sequence extends svt_axi_system_base_sequence;

   /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length_local;
  
  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length_local <= 100;
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_swap_xact_base_virtual_sequence)
  
  /** Class Constructor */
  function new (string name = "axi_master_atomic_swap_xact_base_virtual_sequence");
    super.new(name);
  endfunction : new
  /** Raise an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY  
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body
`endif
  /** Drop an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
`endif  
  virtual task body();
    bit start_addr_status , end_addr_status;
    bit atomic_xact_op_type_status = 0 ;
    bit sequence_length_status = 0 ;
    int counter = 0;
    int local_sequence_length;
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  local_start_addr; 
    bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] local_end_addr;

    axi_master_atomic_swap_xact_base_sequence master_wb_seq;

    `svt_xvm_note("body", "Entered...")

`ifdef SVT_UVM_TECHNOLOGY
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    start_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "start_addr", start_addr);
    end_addr_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "end_addr", end_addr);
`else
    sequence_length_status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    start_addr_status = m_sequencer.get_config_int({get_type_name(), ".start_addr"}, start_addr);
    end_addr_status = m_sequencer.get_config_int({get_type_name(), ".end_addr"}, end_addr);
`endif    

      /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */

     local_sequence_length = sequence_length;
     local_start_addr = start_addr;
     local_end_addr = end_addr;

    `svt_xvm_debug("body_samo", $sformatf("local_sequence_length=%0d, start_addr=%0h, end_addr=%0h.", local_sequence_length,start_addr,end_addr ));

    `svt_xvm_do_on_with(master_wb_seq, p_sequencer.master_sequencer[0], {sequence_length == local_sequence_length;
                  start_addr == local_start_addr;end_addr == local_end_addr;})

 
    `svt_xvm_note("body", "Exiting...")
  endtask: body

endclass  //axi_master_atomic_swap_xact_base_virtual_sequence
`endif
`endif // GUARD_SVT_AXI_SYSTEM_SEQUENCE_LIBRARY_SV
