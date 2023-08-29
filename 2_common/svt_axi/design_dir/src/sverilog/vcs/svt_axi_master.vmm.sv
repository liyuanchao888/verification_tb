
`ifndef GUARD_SVT_AXI_MASTER_VMM_SV
`define GUARD_SVT_AXI_MASTER_VMM_SV

typedef class svt_axi_master_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AXI Master component.
 */
class svt_axi_master extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** VMM channel instance for transactions to transmit */
`ifdef SVT_AXI_SVC_USE_MODEL
  svt_axi_transaction_channel xact_chan;
`else
  svt_axi_master_transaction_channel xact_chan;
`endif

  /** 
    * VMM channel instance for snoop transactions to transmit 
    * Applicable for ACE interface
    */
  svt_axi_master_snoop_transaction_channel snoop_xact_chan;

  /**
    * A reference to the cache of the master
    */
  svt_axi_cache axi_cache;
  

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI Master components */
  protected svt_axi_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_port_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;

   /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema;

  /** Event that is triggered when snoop is added to queue */
  local event ev_add_to_master_snoop_active;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_axi_port_configuration cfg,
`ifdef SVT_AXI_SVC_USE_MODEL
                      svt_axi_transaction_channel xact_chan = null,
`else
                      svt_axi_master_transaction_channel xact_chan = null,
`endif
                      svt_axi_master_snoop_transaction_channel snoop_xact_chan = null,
                      vmm_object parent = null);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  extern virtual protected task reset_ph();

/** @cond PRIVATE */
  /** Gets the active semaphore */
  extern task get_active_semaphore();

  /** Puts the active semaphore */
  extern task put_active_semaphore();

  /** Uses try_get to get the active semaphore */
  extern function int try_get_active_semaphore();

  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_axi_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();

  extern protected task consume_from_snoop_input_channel();

  extern local task manage_bus_inactivity_timeout();

  // -------------------------------------------

/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_input_port_get(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param device_id_queue A reference to the ID's of device type
   * transactions which are currently beeing processed by the master.
   * 
   * @param non_device_id_queue A reference to the ID's of non device type
   * transactions which are currently beeing processed by the master.
   */
  extern virtual protected function void post_vip_randomized_xact_id_update(ref int device_id_queue[$], ref int non_device_id_queue[$]);
  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(`SVT_AXI_MASTER_TRANSACTION_TYPE xact);

  /** 
   * Called before driving the address phase of a transaction
   * 
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual protected function void pre_address_phase_started(svt_axi_transaction xact);

  /**
   * Called before driving a data beat of a write transaction
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_write_data_phase_started(svt_axi_transaction xact);

  /** 
   * Called before driving the first transfer of a data stream transaction.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_data_stream_started(svt_axi_transaction xact);

  /** 
   * Called after randomizing memory update transaction.
   *  
   * @param xact A reference to the memory update descriptor object of interest.
   */
  extern virtual protected function void post_memory_update_xact_gen(svt_axi_transaction xact);

  /**
   * Called after pulling a snoop transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_snoop_input_port_get(svt_axi_master_snoop_transaction xact, ref bit drop);

  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a snoop transaction received the input channel which is connected
   * to the generator.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void snoop_input_port_cov(svt_axi_master_snoop_transaction xact);

  /** 
   * Called before driving the snoop data phase of a transaction
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual protected function void pre_snoop_data_phase_started(svt_axi_master_snoop_transaction xact);

  /**
   * Called before driving a response to a snoop transaction. 
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_snoop_resp_phase_started(svt_axi_master_snoop_transaction xact);

  /** 
   * Called before writing into the cache. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_cache_update(`SVT_AXI_MASTER_TRANSACTION_TYPE xact);

  /** 
   * Called when there is change in the state of the cache. 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void post_cache_update(`SVT_TRANSACTION_BASE_TYPE xact);

  /**
   * Called barrier_enable is set to 1 in svt_axi_port_configuration and
   * associate_barrier_xact bit is set in svt_axi_master_transaction class.
   * 
   * @param xact reference to the data descriptor object of interest.
   * 
   * @param barrier_pair_xact Barrier pair associated with this transaction
   */
  extern virtual protected function void associate_xact_to_barrier_pair(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_barrier_pair_transaction barrier_pair_xact[$]);

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual task post_input_port_get_cb_exec(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_vip_randomized_xact_id_update</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param device_id_queue A reference to the ID's of device type
   * transactions which are currently beeing processed by the master.
   * 
   * @param non_device_id_queue A reference to the ID's of non device type
   * transactions which are currently beeing processed by the master.
   */
  extern virtual task post_vip_randomized_xact_id_update_cb_exec(ref int device_id_queue[$], ref int non_device_id_queue[$]);
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(`SVT_AXI_MASTER_TRANSACTION_TYPE xact);

  /** 
   * Called before driving the address phase of a transaction
   * 
   * This method issues the <i>pre_address_phase_started</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual task pre_address_phase_started_cb_exec(svt_axi_transaction xact);

  /**
   * Called before driving a data beat of a write transaction
   * 
   * This method issues the <i>pre_write_data_phase_started</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_write_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called before driving the first transfer of a data stream transaction.
   * 
   * This method issues the <i>pre_data_stream_started</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_data_stream_started_cb_exec(svt_axi_transaction xact);

  /**
   * Called after randomizing memory update transaction
   * 
   * This method issues the <i>post_memory_update_xact_gen</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the memory update descriptor object of interest.
   */
  extern virtual task post_memory_update_xact_gen_cb_exec(svt_axi_transaction xact);

  /**
   * Called after pulling a snoop transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_snoop_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual task post_snoop_input_port_get_cb_exec(svt_axi_master_snoop_transaction xact, ref bit drop);

  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a snoop transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>snoop_input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task snoop_input_port_cov_cb_exec(svt_axi_master_snoop_transaction xact);

  /** 
   * Called before driving the snoop data phase of a transaction
   * 
   * This method issues the <i>pre_snoop_data_phase_started</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual task pre_snoop_data_phase_started_cb_exec(svt_axi_master_snoop_transaction xact);

  /**
   * Called before driving a response to a snoop transaction. 
   * 
   * This method issues the <i>pre_snoop_resp_phase_started</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_snoop_resp_phase_started_cb_exec(svt_axi_master_snoop_transaction xact);

  /** 
   * Called before writing into the cache. 
   * 
   * This method issues the <i>pre_cache_update</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_cache_update_cb_exec(`SVT_AXI_MASTER_TRANSACTION_TYPE xact);

  /** 
   * Called when there is change in the state of the cache. 
   * 
   * This method issues the <i>post_cache_update</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_cache_update_cb_exec(`SVT_TRANSACTION_BASE_TYPE xact);

  /**
   * Called when barrier_enable is set to 1 in svt_axi_port_configuration and
   * associate_barrier_xact bit is set in svt_axi_master_transaction class.
   * 
   * This method issues the <i>associate_xact_to_barrier_pair</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   * 
   * @param xact reference to the data descriptor object of interest.
   * 
   * @param barrier_pair_xact Barrier pair associated with this transaction
   */
  extern virtual task associate_xact_to_barrier_pair_cb_exec(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_barrier_pair_transaction barrier_pair_xact[$]);

   /** Gets the time at which an address was invalidated due to a MAKEINVALID coherent transaction */
  extern virtual function real get_makeinvalid_invalidate_time(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);


 /** @endcond */


  /*
   * Returns the number of outstanding transactions
   */
  extern virtual function int get_number_of_outstanding_master_transactions(bit silent = 1);
  
  /**
    * This method is used to get list of all IDs which are currently under use by outstanding transactions. However, user
    * can choose the type of outstanding transactions this method should consider while extracting ID of active transactions.
    * "mode" and "rw_type" arguments should be used for this purpose.
    *
    * It returns '1' if total number of unique IDs currently used by active transactions, is less than all possible ID that can
    * be used by an AXI transaction. This helps in determining whether randomizing ID field of a new transaction which should
    * not be part of the all the IDs currently in use, is possible or not.
    * 
    * @param mode Type of outstanding transactions this method should consider while extracting ID of active transactions.
    *             Currently it supports following modes (defined as string) ::
    *               - "non_dvm_non_barrier" => all transactions which are neither DVM nor Barrier  (default)
    *               - "non_dvm"             => all transactions which are not DVM 
    *               - "non_barrier"         => all transactions which are not Barrier 
    *               - "dvm"                 => all transactions which are of DVM type 
    *               - "barrier"             => all transactions which are of Barrier type
    *               - "dvm_barrier"         => all transactions which are either DVM or Barrier type
    *               - Note: if "rw_type" is set to '0' then only read channel transactions will be considered for non-dvm
    *                       and non-barrier type
    *               .
    * 
    * @param rw_type Indicates which channel id width should be considered.
    *               - ' 0 ' => only read channel id width and transactions should be used
    *               - ' 1 ' => only write channel id width and transactions should be used
    *               - '-1 ' => common or either of read or write channel id width and transactions are used
    *               .
    * 
    * @param use_min_width If set to '1', minimum of read and write channel id width should be used otherwise maximum.
    *               This is applicable only if "rw_type == -1" i.e. no particular channel id width is specified.
    * 
    * @param silent Suppresses debug messages from this method if set to '1'
    */
  extern virtual function bit get_ids_used_by_active_master_transactions(output bit[`SVT_AXI_MAX_ID_WIDTH-1:0] id_list[$], input string mode="non_dvm_non_barrier", input int rw_type=-1, input bit use_min_width=1, input bit silent=1);

  /** waits until master is out of reset state 
      @param mode if set to '1' then it waits for 1 clock cycle after reset is detected deasserted.
                  otherwise,         it waits for reset to be sampled as deasserted and comes out of reset
                  after waiting for the negedge of the same sampling clock that detected reset de-assertion
                  to avoid any race condition.
                  values greater than 1 shouldn't be used.
    */
  extern virtual task wait_for_out_of_reset(int mode = 0);

  /**
    * This method returns list of transactions which are currently active and pending inside master agent.
    * 
    * @param silent Suppresses debug messages from this method if set to '1'. Default value is '1'.
    */
  extern virtual function int get_outstanding_master_transactions(bit silent=1, output `SVT_AXI_MASTER_TRANSACTION_TYPE actvQ[$]);

endclass

`protected
+9<gUUAOL5H22[eMFN;Q=_8IIY0OVafa,0ZYI(b.cO8)8b9D=Y;[1)9V?W^)4@T:
H5<Cg+XTeAc30EX264;/,[>_8PM>(Q<(,YeZYO6EK?O8?fU13FR&L0&ZedV6N\PV
cJH+CMeO74<c>RQBUI;5GS.D3Se+:aOD2Z-0E_XI<;16gX2CV?=d41_-@3/a33U,
(RZ8OW;T-..2O^+cPNSCT\#PY4b?EUTQ;V0BP?[#[B]RJIVg/:=M#YNNCYE_Nd=:
8Ff7.^PZOGYJUI&1=TgOZ+b)_#3c&CFe[IbAV9^=f=,>;;aF/I^C3fG<,IX,=bA=
dBc3/I+_Q6J5S.Z;SYQ:c,4OXXJO?Va3JTTf)8;8XTRQLE3_KL&dW6;Qd.g/RL)_
_=b@T3U\CX.0@YB_WXF,^,87UggY70C.Q;/8_cTEg#<D1LD3O9)e+B40Q;]:7CZe
ZR_JaXPMK=K)]cDMQLOJdHYRb_/?cWQRLVBH5]Z3B2:Y\)S0>Q=K=F7Q^HQ8(Hbd
K+3H=KBUH(X@S/CV:6L,I-]d)?TG;b(OFV^+M1V7JU)>R])PV>?b/8D#L=cHO90N
X4:4L8<JQ#e+2d3cL2Q,M@K47O^^8&.\UcS)28FQF9[F:J3&3bfK86Mab-\&LL5)
XFYc3=/QK?2AHf^gQ@Y5LGBK3;cS)00UDA7R<;HeX>BI189H?c9FV\c2.gg9@1XA
HVA#^,:+?;C0>JN9;J4FAQZ?V4OJPW;@W(6[c&>OF@OZW^,RWO<eYa#9OJ,M+B?4
(XHW-.a4NA,GKVBZNX/#0J5KK,>?=a/R]]3fR8a_^PDD1#@=)B7-d3#A4ZXDa8[O
cP,(\-7)Z4@)EA><:eCfD:-2INUE\?BbP7FB?Q+#9:AE:?)L=3C&=Vc#9c&^:S3H
RO#9K=8BY:4N(1)a[3FA3(Z)g&dE5,\OF8=@>AQ]&cZRHEfb_M65K,YOJ33LWO1L
M_f:d=UC@/F0Q>QXAF>XQ(.&23REe^JbHd-.=ca-92):G1USSW+_D+Ue:D&/fQbM
cY=V8_O?U4&#E@BDO5f;7/>KCf_QD8.BWaT=EbXNb=?IW(&CU9[./0QG</NGX:M2
Cdd9G)R]=)Db0O?41HLM2OH=D.<S;e=;/GJIaI_SKbWLLT4a5-G[P#bDI-;[g^0,
W-&3-,))ab9e_3Q<f.<-HE\V-1RV+1^MR&Qb0]#/W.ffO#(M04?FR)#0&-=ZFB;<
A8(G-)_KYQQCY1\MAJULDeTG2#=JI9e[IM]V5@=?(V-1)6,,T=0?HZ)KCP&bGB<9
)#?eD4RV[G3GU52R+/E5YM?^:H4bI#2@L)>@1f/])NUNWY91TJ#f24=c(8J5R&/5
(gNKI^/3cR7Fc5N2E??=K&5Z.^#JU;MVOZ4[W),2Y0NO^41dZ=FQ&bY.G1[RAV9E
E[VP20)B3.-+8eL(CORg&Q]bY&5)W,+:V8NeYJGX.SUU1)Q\V:?4>[7;PVQ3,LAS
AQ9cYXQ1dD)3?DPTJD739Y#^)6]]U#?CO5ULX1,:(O@TGELc3&-=Zg7eB@gM<V=g
T>EBYG[D>9]_?[<M>K?)0^O.H>.J8/8fc_V,f_4^R(;0LHSF,=L^Q)8)06_D=;;3
==Q?/)7eGW9MD]]3=eQ.#3Id6W6L_B4e]2#5+]YA5AO9B;_M2XaCbQ[af2dOE?TP
/b_X>A2F6gcMP?:bD.X>B053\#,=Z?D\b)gAB^fL,cJP@^O,T231>We8-8>8CJBB
g?cD62E,-FKD.)D?&c\O/4:1bB;A\\2PSgdJ89ONfA>aF@H7(PQC2NVXHY9PR308
26#cWE([-\#@JU]B=M@]ZD.+NB^?/7A-:?-@N50R(R(M[;W=-@GK:.6Zf]R+Y^(g
V,##Bd;NNINWX.HfeJTW(_GL-2];D5f=46eVYUF@&2FJ-)R2;:=#<9?c(.<R[#<.
B)7UAWJ#L>Oe/A-AUaBgPR2:<CWXa-FY4)7a7_fMC\aRg5)@7Y;.MR0_M4OY[0bQ
=I.7A6><,8Ve-$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
41.ERHDZ4a21E1E+M6-493>dW7>AKgHQIU7H;WN3]g0<=C496C,:5(E_FbRc;-^8
^a.]G0G=5647K6TGD3T7(+12:aFFY?9O.A90(&_]B[.]1,W(+M9N)F9K>R#Y&J]N
U^5<2BE4c(9<I726BD4\\cBb@-3V49^caC6^MSS/6P.FA_.DY=VIYPWUPXLJ>KS_
>::V_9S5<+@D1VC<c=1b[b.ZQ?,g+]A6Qf>[-8_,PcY-=7+,069cW)B]=05LU_Pc
UM4]E+R46TA#SA6<8P1<=_VYGg<>2J@:cAYC>>g3O5@=Y?6J1TH.2[/CKT@f]#A^
IFf.fae[c7G&]2Q6HSY;YK/OGGdJ+0J=<?gdSDP1F-f;QRIf\QFV4X3E\ZLJ7\05
5,fd+b.3BP=/0A<K0DP^HQ5=W.P>2REOcI9?bC<aO&X&E8V;aE6KZC0@M.HUT6D;
K[2a_Nd&&PHG80L-IPfFR\2;fW3YZVa>66eFHP,RgE8G/194b4&>OJe7\45efP;X
4R9@=/Mg<_^8Fg)Z<;(>,D89CW0JVa2a1,ZKW_HG0JE>)d1?T1dN>N\W+0eeB5T<
@?1+[>R&7<SJ4T_B3KK.L-TF]KJa.X2BJ@DVYC(<]7/T?,D7VbUQJf-VT[;=ED\J
#d0FMS.<f6/e/P&/@4Td-=DNeb#^#C&#=)3>IQSeP-4Z[GEAHXaUY=2,YdB)D4&S
A+24g9+acN\R\KF0(R724XX8/<b6__JR\::_KX:M(\c_]Mb]P&[_H0SQJ>U&?RW@
L;05GU_3S\9dA_FT=(:Z].LH;+,^DTF9F_[gA3X]<JgAd1Ig3RPKbO_=3)D#\475
L^cO063&G\OF]\+:Vg3f\EBTK\4+4dMK?#(9dW,P)C:&K5I&S^B[4T^bGGL;c21J
;KAYR#5-QCA:8_cTUM;K#X7J/<\gE>_T>g>5Y[^ROP9W=S<8H#TM+)]53V:>AA1E
RcP3E)E7\c[W6I=6PWGEOD;U+P;QG4Qb]Z9Yb,^X,I>I^/[c0(bIV?aZ=#B44DS\
724FKO7?BZ<,78;&K@ZOS,T-P,=+TW9IXeM/N=/#d<gQg?g3=+FC5H]J@VfTcgFc
ET-WEJUg7Vf>RDA)4&9FN@)XH,TSLe>63U;<QDICIN[>RU/b6IeJa0==O)EZF/#6
4\ebPE=b3;feG^-2V@W)TY?UHWfA(A.2VH/5F5E0^JOIMSQ]/J8RFbB/P#fP:E#6
F[aKg,U2(Q_W9C?Ab2e=92gI]^,];Z=\ZNR:U^1V>(PV9,#),2bf2LYg7_WV_0Pa
T/?C^16^O\LG^:G)?_B&E-3&?[PW]T#K?Q]eaLaaZ#a@K(0F:0Y-bCJ[#W]+TJLd
<Ra[e\U.@@Z/f@=.IM@B/^5;>/.7EVEJ_c4IH:W-H3/L8L+@\VKP4N\EG8^U2IW:
F?3I+^aJS:SQ=AI9R8CL5=[U/bd@a>),aaVJ^39e5/P62KYN,?-CfP57PSBS4[>g
]fJ+D2:7FVUN:P3L^U0fKXE<_G6JE4)(-HgAE3ZEV]#1DF7=d&F]J,TD:K,VH9=F
WN7b[1)_>1-Le1,#9QgM4g]6M9E8Y8H;PMMU97EKDN+fGZ=XN^14[.WI?D,EQZ@@
&SQIX@:[/^[<#:3OePAXa>Z7]SEaX.X/5c_=.XTbF\2DBWEQGM#:#[IJ/&5/K1E^
ROEL_1Mf/FE3Y<W)NA7cV=<;J+WJ[aK,b[\b8,5O4gFe3dOUMC),W&R?Fd62AJ[&
,&]M)#gS#8KTXF1/IJLF:E4M21LJ\K32.8c=<UVS,N3?.ST?/\EK+K4]O@5_&_ZA
ARS0V+X/LX+_]AO7SOQ+Y;5=c@M@=#,W1ZW8H1&6V=FJ#G_b,X/3QBTXZ-]72D1A
2OZ#4O\aIKJ<d1P:_CRB1^KSKF-L(J011K:;Z=_L9IS3Y@C4A5EDV>b2OZ7A<:_Z
(A@2DFQS842?0M,HRRWY35+d1:YG:FOA<Z.A=EOXeCE-X\QJUCea0-,:IZ28aG(H
e2JZHXSD#IOA9P0PNg./Z3H;e#B7W2]Sf0)M]Y2Ta,<5bgIMREE<0GQ:O_Za.5_\
IX)5;[[IQbZ^E0O-L70<bWMI;J4G5BGSOS1)H_2.b.HR\=HaSN1591BV4.RIc;=c
RDSI3K[F4AHUM]_X03ZcLIM<5C=-P-?g:[-H:&H(49-eK7b7B?^aA8FHe:R+9680
6VE((Te#BCdAY,TV:c#:cdQYW/7595+/Xd/XA2e43AIIKa9b93.60a.A&b\YKX>I
0J4/ML.UN.E(ADefa2b\X&[)Cb5LgS?T[FJFLF).3BK,[f](C\A<JgI[bCG]5>UK
cgM3Q.-CLZA>9/(Q7#Q,4?0cb/.EV9cRS//:=FBgN.,]E7X12PF>OJ:41:>,R3f<
OBdCI1;8(UP>a#3/R)8a=AeA=dTAJKSZa^Y?LD/e2M1bH26=dE_:1a#ae=g+O._G
@1U6\YUED\#ZJISM0^?fJJE:J6[OIZ+E_0\9V2?\DgYAM@a#02B&gYd\=.9SXTY;
BSKH,E2Hd[D902GAN2HQ4NN6-d.YCfGC(&LZA)9A1g>eg1T?-9RZ?5^Cb-F(1Y.g
H)Z+<8aVGbO@IWcL:YQBZUY7J(JMZgF39b&DLRCR2+ZXP>2V[F+6bFcD(P,PX5NS
VTcQ.cMN)GBAIUG<d6X:GPW+\DU()<QCBVNEg^JRTc(-^TK@&Hg(UGX,\QR:L?6D
]:Q?4XL;cGg\&;N84d32M-:]]Q51dOO8TVM>()R_LbPB-8S:13R:5Q0&.R6YWH=Q
C##H:RQEeQ[CMcfPI+J?;g<QHVZg@:<]TF,A:Pf])bP2Fg3X;KX;YWAG]1A95/F)
b&-C>2?cEHFdWY01cL?CA84A=(XZHF3dHId^9fV8I3cGIcaDcIV:8gFDK@M]:KaF
bR3Z_P4I>g?9.KE_eH2O.BA[gNFH@P[9Sc++:EC?I2[B=7U,)\8f<=+X#N,U\a1U
;WV/_[@9&aBRX3da-XLdA<g#6K?BQDR2/KcOcVdcEd8@Q3CWVMQVgD>W9e:)_M&X
FH6^c6#?^=DJbbMA:M4D87g?]C8e>W\#/SBG::=ddWZ;fY7.6JfPTR-U(7FFS.]D
^eWIG(cYC;KW3fgWW4Ja,dSKV-fJKcQ2]8c8LY]bTa-ZGNL^a.\+ZKH^P9L6XP_4
O8C-QeHN_g4>Q5TZ_GT:LVROA&9D/@I^GJE?T@,g(LLYc7g:(CWZ0P)#QV-4bN\=
JNM5O.;4+=-BM6?&>79IZ]=EEE25.MPP5#A4N>G;5]I_F@,JaZK;Je_S;;TOO4Y7
@Q\NZWbYE(>EXKFXEC2N6]BS5\VX7=D6-D&>S-1TAP-A4M_TDSAK(G?MA8Ng@X1-
Xd@H=&Z(A8H(RbQB+[bTfRDEFJY:ES_ba9_A63W]L^<I\4>W#6gGK=BT[)>F8fW_
g=HS\SN?>,T,,8[d9,4LGH:C6--7)#-0=F1&/+1]\:>2/Yc^CI5L7FGO;-(O><4F
43+D7?18B+BK-,?D,6/)):XZYc?TQ/-Z-I+F2=IdB.XWXID3.OIF1JQOO..NJL\#
18N]N@V125_#T3:79V5OQdJIa4?cCZ[&0WbWe)@K)7Wd#fDK](4WJ/REa0GfL+2K
S-\;-C)IcABPP6K4X1V9/F)I&MNQA>aGRDBMSTZ4=+@0&U>RVZ:4TFc2Me/OPF\F
O(G\T?SZ<?R2]9?<ULV^2Y9Wg&)R1RS5Ib&#XD.@O-P-5QAJT2dDFY.BQ=,8]53D
;cG3:=RIc7UK5>3e<S(@<Xf/SS1fG<@K4,8.(/@R0<a;f@JGg+E]A=>#DK=-^W<D
DY+T.3W6c8]I1aZ/5>7;f&V>fELB?5GZ\?D^7>2/=2<EOD:5E<@MbE2P?2YXA>5G
12>\[9\c\6&a<(&?V5V#P9aLK49;;03fT@[K<R^<)BS4W94\.AaN=c2_0McP4#X[
\M@VIJ3f[e_C=.[.]]PB&(ea>#[2FW89WP^MN<M7.[HQAG&C1OBS_GS.9>:f2/GU
T]QW5PE8[2&U]d&TbI5FBIA>HVf7?8GA(4Ub)48GOYF.@-LZd_Z#b9U[WRMQR=&Q
b)^E=3--CG4C:](/#77=\9,gfS8fC18f9.B]TgA#a(_C>XH[A5^;fCXI>VNZUO&6
.fY.gF0aF\)045d:O1+U?b-WDR.[[&]]5Lf&=:NB+1\PE^(]LO-WWKK/0NZ+2Z88
D4[_CKV-;f,AM-4&-55JUDcDDCSAZB9;XOH=YXggB1Q.),Nd5-<WNOSXV>_[+LDF
N@Ta#>-/^BZP\CCWJ+dX3/b0-\:ODL^#1UH/3-#U_[U/?YC;\/5fLW>;>8NQNY;@
Qf>f0U<JD>)EVYX#^/IC6_G=-&-BR40B0Z(dL1FV;\.[<8fR@N??Ab8FYTZWQ\-[
@I:AV0NSE9IUQG1gL5,0I@1MJYc)B^/LNI+U<+Q1eM#TI_3\I)QMLW52F(.P>-1R
&D2+A.egdgO<IFcEcC03O+9LWS8S:Y9H:cAMG\J@NHdV;Z-38M<5ETcV;a(/;R1@
F;E^-.,XFA8R;QR+b:_[Tb;#GV-RgI+8e=]I8O^FI^a?7c-XdPPQeJ79.IT4IAKF
LYQcf9]2[IP4&Y\AfU=728ga/MKb9:&DH63PTHP81@22D@RZP<+&]ZO@U)S#=2:Y
&gY=EU;2L)c(c/S/YK+/H=^+fP/-+YK0.:NQ-:Ze/#E#9<4P,KAd.>ffR^;01UNV
f0]:1V(>^K,B+S,NfFSf/,a-]5L+HPHAV:cYdb)/(VeIRSeU4E07<gJ+>&N7O.3:
LXAU5X1<_8aI>7BTcQCe2F()5cagFca\3:V&dL6JX<&X[M];cbW7IE+./Se)f8QB
R)S>WV7ZgeR:bGW(+/0:T#d(U_W3B:=eD^VH(7g/Y2eZF[[U^+X_D[S]&/cPE3,-
>A5839TUO./?;#IR>cGUEMHf,00J2?fc_,[/0b3:WafSVZ=>bSS5K\NNG9c2PJ..
D51=TfBE_bCD^240C2:AG[00LeG4cRHg0[U-EU-42)W/VPJU\:LB_HG/9(OMf.BK
49c,/M;?49gUb^=8NC51[fNRB3HXUACGJB9LOGFG.RaID=9<^?Q9YOGf=fW6e#WX
QLF//HMT6JWW:;e.:&Yg4[e9fD&=>P/1FWP7F(=0bIATB=2)0A+&0+<fM>,d(5-I
\Je#.Y6GYL;&ZUUOZ#OIK\[\2.56.EYTFEDNHL;RU18TO^/I\f+9F\.0TMD^PaL^
(QDLRO/9I(gKV)2Zd@QL+WMM?_G#V_cW:e1B:a)+:U7HEA-T0R?#KNc&/T1D[TE5
GaL[ZIa)XH5<WU1;<@(NOXP7KKY,-A\Q]Y=?V\a=CDf<BUMefK)6_\;^I6:>5H-[
85F9Sag60AH;Jb&-]bgL8a1G>0UO/TA@:/&g:CO>Z)7<WY70NP6e>;H?8MgS[C4g
4S,)R]2c2bPRRD8]);g&&@?APF--FcY+dHVcD4A^75)&I[VQV851WaB9Z#Cc_WNg
7BZY53d_C&=[2S?03a9+82aX:2IRcX&L\9U1ZU.\fDTLP<XNBeg7_:?(@9\1f^GC
8PJO^WO=3<?Z_C8K@4gPRI-EB(Z?IT/B]+T44YCDUfSVKT1RG&g,Bb[MFZ)4KT_B
+F]1bSd4c3Y@^c>MOMP<1/W)T(YXRBAY1Sg=TBF)\]]U+YYI==0COJ+H_e&Gd29=
P;H#QTf[ITf0X;;_PgfGUfbNYNTNfMgMW-=L>&T>1VbeA.K-BKQIEF->d&G#F>H4
][:<CAEL[[;,;&a_Cf>e/-EMK.QeROZa_ZE-\3+AV@0#M#Ig5Ad8B@XME0LQW;P-
bbaHcZS&-b&23T76S=+8df9U71]@+]FX21/>FW0,+YNSd9<^a/8@Q?;;LJNY=DC[
))GT1[CYRfLb\JV<:_6&0W@.;S_Md[2^7/F^+_)1[9G)c+8JF/G+O]P7S8J_N8+5
9E1,INa,Z9ZE)7=?91Dd_Y.8LW1U\+(;af3U<e]^.L?(=0>(fCC8\#.TON^.7d+S
AE.TTLd[.:J)@Tb_=IV6\@:GXCDc\LZTAQFTC5g[>aPb[@8NTN?I5EbXY_PW]7\O
KVI5X&^2J/De(:-)H/3\=Ef&;Xa\GW15UU0R+a7R#C<0cN09YLJ2KJe4X@@;;[])
68/.[gJ)d_7-ZV\<)8N=g6LACeH-ITbOBS44c3X@,S&TL[U[-I[ZJ/AUK\YD/#N)
AAHgG9\0eb_E7KUGg/)+a=#@aWU3fGc1^(+WIS1.VBTWNg8.NCM)]C[A4]A[7I.4
;f(AX0@HW;CZAF]\/@WOVW27R/XV;LG#^L8]>a0=1F?@gPW.JeH)9-9cO@X#HTdD
]Rd[a+TY?D?+W),=8M^]GX^/ZQ62cI&V_+X+Sd;#/R=(\RW\-GU-RR+PY?VBP:R;
Z+Z=)@eJ0ICf+O7gV+Q&ef9;Oc4JIMD\[WRBP(SCIIQ?VGfDGC;Tf[12Wc5:<QRd
ZIOOK3R/S+#e#A6/7ZV)K\]ROKDVC4F5NPe#Ia=Q&e^6:D=@g<[G_(9FEGW1-,7\
/=3&;Y,N=b=C3D:>dV_)R#-NR+]&aKJA1U;WP>>KdP1/I^GI4V,XgZg7.S5W]V#\
V+Id8OEA^137Y;C_=B7WAO^6>(+B3^S/3J@ffME\a7P#69F23D##JQ7+;B19H9IX
DF8O4-Ad_V(RFP;5H(f\ed3XA);40((g\2-9,&\53<\;F2C\H/9O9S:2RS5+PJ:?
TVDC>EO((@Qf8K<T@H>3G\N@+ZW>_-Hg^Tc&BQ@I5AQF]cg8.W@ZH-bcZ\SA4bJc
Y://-&DW7C97Uab/W;a3SQ7N-NG92C@TgeR43=(89Q0;NT(b+#ZWN=3O#WU=-S5<
]KB1c<@M-8TY>.^JAf;S).<Jb3>FF:[P6ZJETH^4BWOPAb[Aa@58cc]^dT#0_\E>
afJ9BD]@R#@1MWJg6T8LF+#/R9R1,>e931;4X-^VTV4PC#7R3&^F\[Td=):1;DCa
g4UD+2QH>4-\J(YMYMJR2S#=SR&[UN+D\O1?gG,L.)NFA1E;JL+]/.A>]d@[>J/f
6[G;[61Re[)TCWH>EQ&@9YG:459N6B<CZdW\/UD1=D#Y^N\T56c@c5W/O30XY&US
e+4AaL3C?/2?-A0;I3USD(Ff-;^4LVIT&>fW<#=P9aY?6TY=GK=b.FUL&MJ,QIS#
2Td[/.44Z&O2PPMWUH\Z)YUQL;4IH&dB0NdYL]XMM.PDa)6^)/bV,gGLB.a@bM>d
f?R<bcHa)V7AN;K;FGHaHVE_#)4X-0UXd>,7?YE/J;SCOIZ?F30(5)V\?Vf)_?U=
gJZIW.5=d/MU(dfN(Ig,/;9&&JMY-T>IE5f<DMDX+8V1R@QY058;[5T1W3#bKH1a
-;[A3.X0C=KE+,;(>>STLCb<#NNd0G9#^XfIT:]6BIX8LB._Z&?)BG_X^dCE@KW#
cc[C4MCF([X)a=YSD1Lb#caPWXbCH02:Y1:T;+>=AbN6-YUHQ.R>7J3QW7_,T=_8
/cJ?\:f(ZNB=WV5[NG&((?@YGI(O)W<W&UA#7L##gM@J+05)TK(2L4CTT:YU:C+6
3Z8Pb]M-HGHNTKI_.7I\MM3BP8:?X-C+DD>e;J@UaQANG:=bL.<D^>.+8c/g90)X
8Fg\=]]PVFOQ1c\TV(@6JC8T9^[4#c_1e\\M)g9a,AMJT>[dR^_Pd_-KdKf4e=PI
>dLL4DQd?f4EdGLMJAQ^cE/bJTe>1##NGX[E4/aFG,Gg@1(JIN?D[6=DYBbZ;/g.
FK3AJ<M]E[B&R+gY:A^8:bHPCB1W;bZJZ]JJ;.6.bcUQ]E5?[X8a0_E.[b^dXV[]
DAEEC)cC[/(g#cX;J#JaI=CF@\E9d2\LLYgJ9FEE:(>N43#3EK9^3-Z0?C,KP>>.
K5N2bOL@Q:&&XQH/>5B[&-<:cNaH;_XeSe=-&@PgD;KJ<3bNA=5[-6,)^TeaSGEQ
Wf&3>7b54[QLC.10DV50B,+0Nbc.GZ:ZeN^7(Q,LK)g:PHLM=gFb:VH/g/eN+#,b
e&1L8N6SWSI/N-XaYN##0;64#D^?]@f9&cfUb(D,/EW<[\4_&.8?;FJ^g:\,@2\H
&C#X9Zg0K8dJ(OG\VJTXF+W]TIS3K=[>fE@^XG\+,CgaT-)(BUD9HS[&..])LA(7
I@M?8/49+OfGWcb31JOfPP/(D5&?c1K4^PXZC&a)E_Qd:DP_ZB<2I9aJ/]72cc_[
]J;:2H4R>f4ESadLQf7LXGRG_C6\:QY/2#0O;A8\+@6G?^1M9IWTT&MUeH]C.Z=/
;b-Z]>:UG_d:TUa#F5?<46<Wa;/[JA>LK^CRM]9cCWbFBY(8e_[F:GC+bgcMc?X-
8^3#QEPB_c[cA(Z:EEg4,?gA)b/5@X/J[g;3eG^;VGg4H=BP?KR\CCEA-A&/f<[+
_/=ZP<b:JcVa&5#LZ+aRe/,IR8E<E7J-B&>,+[[8U/T>a(Sa,:YC4HI,Y\&,S::K
SbH;0b1Z?ZH5B_]dddW2R=SS&<X6f&A=UbDe\U#e:=])&N-f:e^6;NKY,c_AK^/Q
N_XD_ZP1/LR[9.2VH;g/@53B^?8e1>RaVVLDM#4d)=]G__&>&ebSN2@MFGDAcT=a
D3H((?(N9OU8,UCdSKZIZ9cd[0.0MDA@L^ZHgF#7O(<(g7\F#C(fL85JN3:^]K1D
L/c.fSB/^7eILYA9T6<JfYTDW[EdVV@3]KeS:XZd/d.3Q5-IEZ<8Jc[ZR3PPJ?-1
9e7?W6(ZB4fa4&9S,Ufg@[+J[PQTRH^Rc,VMSH3M-T1+/?3BO<J:+D.N]T#^(&,8
=fGAM(_X:_NT9C#YNb4<abL?OB>?R\f^6,[_8(,d[MU-37N;]^2I(40dbB.ScOf6
2ZE3GCWAbeLEK:BAQP^8bXRIE;-T0g9LdBeC(7e1TXB0CCJ=879U,S&FZ@H.;PfX
RY6F_8[0Y&ZJB)[fB)JMV4(UKQaeC@gUZ&cE^5eDC_KRF=S/1c:5EQ6B)K[T0F/(
B+.CX/&^Jf&3f4CCH(TD&;P2##E3;/C2+0,2[)Q4dTa:-.8,.8N:9BSgXL5W^Og:
bS7O\:_?I/,JGJW@C@MM282Xf#@RBB2F]d/UKV3BgSED41UWOVT+Qg@])@:D2]7.
Jf88O[NNUD7=b)PB1+c7)M(HOK(38](_]:-CF4FBKf#Q=F^Y?(.#OLN+-a#P-]IG
,ZZ:\?O8BL\3e7^4?LIO,_7=[02859-NaU#2P\7OF+:d:+]NZ#EOA[_M&9_U\.Sb
NNHTZ,Bb,@\ge2cRc=dNP4SFVK\FLDaW(UV7]5=U-:87Q;LGRF^5T6821GG7DLK@
G56W1,8+6/+(RBO98-X6N;G9EROTH;#TRbN+D]g,#fDVDQFKHda.S&=[F4/BUOU]
Mbd7GL2/<&[;+)=7<KIUA@XYK\W0bD(K64PDW)?ba-\J#a49-&Y[R+\-#OI3E^8[
[)4U?+1[-eTP>RA&6FYDEWQ#R\@Q@e)L-WQ/<&9988UNGR(f+^UaF?RJO@#Nc;CA
5A)b?8.3)4&Y^I;]FYgf<GDDJP=JcB02<5OJKPN#?TPLHEG^6^,:^VL-_6a5UX3C
&=H^4JQ>C,K0a0EJ@a+P5/L]1=dSHeLI@UULTR/R#R&R&))R6FG&3].5-D:DE]^S
=+=CEKX8f85GA^R-)/2>B+UE28IdZeDb=CE>-1HTCRX;(Q^ZZadG.X\CX0VIB.ZI
&9@TH5F0QVZEZ1K1RTE+E7DaD430J[S-g[[RT/BD[J-Dd>@3&bIg(#&L077;E:6L
>97RQ(Q)Kdd?3MM4FI?=M,K=BCB\TYHT2aGZgMD0F?AS,M6H[+a4?.4aJINS&&G6
?H+,R_2(;=I>^4cgR8UM#^[.>+6KE@d)d78)(WcZ<-C+(PG]dEYX_=J:R#U1[;22
_R8Vd/aUW?Y<8d[9c#VbdSbGWV1L@\#5MK9I:(Iba>8W<<@MfUKEf324_G=21O\_
1C31UdPAdL,Q4-V?SM;4;J(447@-^(,H6:_#\1ae#I:?\#d5fDaOTHZc-JE,dOQU
dD7L[5C>+K[R,T2#D)F[NEFDg[bag5=Ne_X<]=VO&/\-0&dH4;=b_H?XYV00,Q^I
U@SLJ8WJ-K)1Nb(;NMCD3[-DYD)^4]cSYC.MQ8JV,?A?Df8E8N/,D]4?63ZQR#>/
@cGeb\E&OMb?\W_EUc5,[-Pa]A8(L7D54GRA<.R7W]&cbFD:GEK?QX=KJ==E=N-O
BUXVb-1V;NHFNJC5MD=^ML_F31<ML=Q5>12.56#;2R<C(S^R@+\SC3@M:Q_@afg1
9&[g35M32H\7@Z77R]AVU8@f/@aP0WZ9>2A,Bg-+DO(]82?I1(YH(T7,8;#S#d1]
T7g[6a-S#g9Cg0DQ=&^<I\[80,(UD8(]L_(25D:T;+:J=fb&010BKH+D#<@3?B]Q
).L\JfOPA+dVUOIG#gYR-5Hb,dd6G_MUS:1?9JeDc^R_^9g--WNFCK8XT/1b&>9.
Q-G6=2&L,F#P]Xb@C\QXD+(Ib(AFX7XX)QVQd,TV(;QV4X+T>BR45_W7Zg7ReGKb
:<O]:,(Ne6U/+2YLdC&f9-^ESeCG.,e(;PMKE3YQZL,:A0bB#PN]V3CJQ)57+HK6
/N5>f/B<-JN311VYDdL:5aLAD32c<_A;7Q?5#D@;=,DN4#YeE^ICG77A4HXW3;[\
,FQ1ee@b>)KZC)CYH4.1@]W)/V22#;cQB/@f)Q.HT[3&F/eCN_J<KK8Y:X9CHJaU
:^bGTB,:c_f9>G47c1Qdb7,^0/#Y.5&=8VLBT7V.\-L4-/PT6^?V[,dDg)]g\>CK
+V-5#(b+A0D_:-2-3Y#](2Yd/Q#ZZ=\T22^cX7RUKF]J.#38B[FS?R1\O2aJa:Ae
HbCT5_L6>dIc0J,9)c576),28D)SDYE#QK)Ie&:[ZKgZdg,[8@6V/N<O#a.cD61H
87<0X=@fL9eIg\FJJ/</GX5H&1OJG3?5MQWAcC#F4\IZER[K8TG8)TGB/G#Q7/HF
5;T;dIDL=XgSfT[_UYBP\VE)_FY)Ng02>ZcVfW2T/f#Z0T)?W-g&JN\_7RZ[B4[,
?V]M#SWd(&@,-8f9O<2JT(+0aDL:d.Gb3407,,SP[EGfB.1=L-VMV&GaKVC(9_UL
9O8,5NZ]3UVMf9UKVO(da>7dL]E8W;+JM;Y+,W^@a=^N+1-dF=A5[/(B0N\@>6S\
(RA[(:(gMg8[<f<,SG<fH(5FM@F3e7HfFJ:+:3L83?KCU#75K?ICL=KNXW8c4eN]
KELDD8;Sg4-FCba3Cf6SD0c.[.)9VGR)T3CGBG_KTSJVS_/+ZdK(5DSFF7WI[A-4
CV:7<fHHF1LG7>6N[[L]Z#_\],]RG(@T&89PUCFGD1H2]T@3:OEX<>DMUJUg@S9@
g8#,;;K<H_\SATT,Kg\1)2+?e:LRUT8Y<VA6cK,S\Q1bP.3D[G2SE2(T\a=;X#UJ
5]&N+GGVUOV9O1K(acQ?-DO1_N2+R>OGe;aPb;+EKI@F#>UfLPP89=0E3=1;8?3Z
,&50Ya<+>_+G(2-03eN9Rb5::C<E4=DQ0[+RGF^EOQ4_JK(I7:#AaNT@2Ga+;HMJ
V7<3EG/c>X8(:DO5QVI6HaQ/?I9]+PSf54#12-CC.2LK)S&ZT]_+g8[HEVLg.gXH
@-3.6;,=5)()K7UMJ?>AJR>MYH24bM?=P;,2LN50O^Db<R+bA-V/N:LE4e2_(GGZ
O-RaY-24Z-X)>:DdN]#]bdEce&Jb&2WUC5PbJZ.4V/_baAQ,00))]CT<8e9KU568
CZI3B1Lc;J3MLR<<,G/2K.2CH=T+/_TJQH4NEQ-/&A.O<69N:^7C,^9Z2;RK8Xb<
-H-NbcJ-Z8SFW,HAIV8<^+Ma/^Vc554857E_=^)]8;f_C,dEHF0:-<.<1V8D\.Bc
5Lf?6;MY@]>;E][1CJ;CeRAO3Ee65^GP8S\-[73V])+E1d>=3GJ+9b/I(,^bae^,
SST04@QG-TC<)A[UUBFeS4,E4SDZM3b-@\:^cAL@O0_5R-BOI:IS>RL\1M#R_VeK
SN2>=:(@):UON.YgF=&Q/JY+R,7.g44((@9AXXPV>/9CH)EGIQ0@845#E)E\[9B.
SA^WU5ZJ+U)](ULIY0:@FTH<Y2SC=TCO]UKCd9>E70^<GJ1:aQH-YP>a[R,^T677
N>9M.f,6Xed4)T6RCg>@B9[>\,B@^/>[D(cQDQ/#0:^E8]:XQVY-;Tg)A)3?ZGSX
[-aaOfN5A9@DA:EJG7Z8CNUbfFBF@@G@X]IBRO7Fg,KaW8WVCf^#G@T_CX)Y1NFN
A7H^Z.f.(fUWK.CR2VR#2e0K/3P+=R#=@)IL3^(AXZ@/&4.@a4,X.?J(W9A0?deB
RF;RW3FG>DC;L)eC=VO]I-d4R_-bCFX>S-Y@9U)ZLPOSP#=1<\\?2\T4a^b1CK=[
b=V7]Mb)G01;0016d7fKC<@NOK\fT\M+fN=R.\]<gJ))C@[O<,ZVN+885IM3O4:3
:R(dZ#MQ3D)b-JDEX#>SA[Hd+8b,I-WDfe-[55VJ/(/.8?U]\_,-DfZK)@B92/(J
JFHK,(&=JB-PRVO2cWBCKDecZb?>#-DSCA7a(]O&>5JZ#\?,H9]Z11Z9]@+DS]VX
7bGI9QdF+4JfEN4FVFDCDK47)XQ-K8=:f_Y(3#fcP-OaVO<L3a7MP:3)WPX(<Zc#
Q5EdPRDA:06+e>gcD2C.II+68IfI:==dX3K,6K&cT-Kc_3BI:H3X8T8G7CHdBYX#
J\.MF7e+8SdHDLaH7AG5UR)T.PX/LN.56/]1@]L6Z)fN-)TW9)KI[B#.S&8ZS?]f
OeR2g=\g6[O<Y7&).@(]]DDU[+g)V)49Jae]YJ_N/5]0\X]P.,f)CMZ:6]JRe\PT
B-;H[2,g8__I5KOH4<#99L<AgIBZBE@K4Y)eC3()4CNC)(gfVBE1c.V+9,Q^XM(3
UTG6^^9)g8-]Q/&4611f;MDE^L=U:6I^9;4f#HaE0_97a2X37U3R:S/,;B].FV;3
BIA-b5d/7HCW33/G-3?NeW&Nd<Bd>UcK,c;D.\&6WXe)B#]FT)a=[TSO#;ZB&XO(
e_]&EMb&Tf=_/b\2KbFdEUTO./PWFH,CT.JcAC>:OYJ;-K19+TI;SNX@>9PL?a2X
cN=/2Rc[(W(1OL-YX+(::>1fCWFb^[((^O,5-(U_D_e;D>gWXB&5^CcPU1U8J;IV
X)@K7Z([P05SLIL)T]/_)X/B<Ydf5CD(K6YA(89;=8=afQA499[cB_dRbDG-SU]O
XQ@Z<HVa28+GGX-M<OU[]W2f9dK7/gB42)6&P4^-.1UES&D^LY[3K9ZZI3S_(1^\
X88L-P@JSdSY3E0/:D.>S7#AC8OIbg1SPUR/c,70:e/CF).;GgWCPF#&70(D3X]V
[(EAb).#a[,3K>ME8\[4<O4fWZ+1DANW,a,J2J5c9U2A@M)&Q@?H\?-GbH5(,<&@
ETd@f6[&</aMf2Z7^X4.gT;?N.eM[]VZ5c@7+E,0I:]893HC:#B\W)K:M5]^=Uf\
M\LP0P5RR,->Q9(=>D-0b_P1:++VeGSK,F9=U-1P@gENKR-ZGY3D1@(+F[/)LR:Y
I-OJc.@K<dc+^bd@#4Z)TZ>c4,e((VE:)H;=F-Gg:IDR0E)AJZcT&YBIOZH95]64
FJO4D@U>O9bc4D.Qg_6+I:]#TdK+b/Wf&2Ke3R<fMT9/=;dH(ILGW\>36&bF63D7
b/<?\d6fbA-CCIG:BGOfN&eG-(/-J&edF\4<6S45e4:c4fPbLGA:6gX><aY-GOL6
gGdMMRU5IbePIN2<)I2HJC1Gf++)JI=+03I:L;L2)0LY_56,45<FFM/7M18=KL3P
C.Fd1OdMQPGOH&NFHdcgcFa.(=cROBbZCTSM[EM(;LJ9fb0@W@SV&N\2G\/_]:HM
Me^ROT0_L:+-KUHL]AGDD#)H)W=]09DQ=NFZWbePP0CfX5eA</^OBZJ>AC-O3\f2
MJ/9>W_)f&M=&eS:a_K^a18R1W9aaKX(cbG2Yb3LdA_4R[F&C7/QD>9IG&F04=,T
^dUZI0d^N@ONND[-HB9d&;Dc61\/eS/NIUU/8.#]DHeSB;P\J8LNVW@V94E4^#/C
P;/(Ee]8&J:dVX.TEE>Y90/e)cd)E7ET,BW=e-&7,^M+#VEEO\:TUa3a)H-B]=Y7
+L_8[d1ORe9Ng14M01g..#JE4FD\XAHa2JW_R7-?_7_6DVc;CCRVV[6A7G=RN,E@
&H.QU(SgeE;gQB/3^Dd2d9MAR.dU\+0He@[g\8L-KD)R#&?.2B/9C^T@a)TS[N.T
3M03P<W]>LG[=]M>#<S4McZR5@V[^;dZ>\4=?:M=IH[X5[#cX-N=V&^N<1&^,W<.
TSNbNdDX<#bfJ8TPf/&:U8XL5cWWZaf#Q9&#_T+(b3/bCFBNX;-]V4YU6DW]9Sd@
\:<T&M^=DZSF#.(TEeUg7@@=YNcD[(Q+F_<<GZ)/e51c;W^E<_fJ6Jc-Q7b\P3>J
JHUI;?:LH<O9K44YTO4ad9@])dV4;FL#d+P,P8BaYa@X<Q229:MYGd=H1LQVO,8f
M?J+3@?a>#dLd7TD[-&S@C;,ISeb]:fXJ=MQ1SW2D13S@WWbFUF7VR(SE/\HZ::>
[KTG=f@+A50R>dM6#P?K:,DgV[_da];^<Q.B?>RKbMZLLfOW30DWW)-5Y.?XCJUT
]2&:(g37:Q=7f@+QOgPU8];6-T:6^XcR8bK-B,>5=64N]R0M^SD.Q>F<)F2V[OH#
4T#8;J@SO-RN/MGA_.ZTUO,^@QE=S:CX8TFI(JH\CH^G);0CEcKLc&96L&=b&E1O
[QcR8=,/Q0JV4<6KU40F62E;QKcfS?MXAHIYPJ_Ib/4XIPZ8K83F>Rb[Kg-MKc^[
5De:P5c0?_.8d4Ke:ET60W0FC^-N9Aab(a>MBa.-&F5Y^\;#--a^2-Q\3^\aE-a]
ULg7;10gG5WZ.QNH_>dNN5LR<9GQA]D6E&[2XD(@Vg,bbWK]81G&@VPN&9N000K,
Z_PbMC#EPC(NBb?OR@_Nd]-;(XA9\CB.AJ_C=Z>1Y,8c4MgLF:7#4/ILJ8TT.P1@
3FTdY)<dS=Y@Y(>5C(LSG[T2:;+7Q2(^)KIgd(<V+C&dT_]QS;V+e32_,bQ##I7W
+IBE,)&#U,(NaFgH]<RH>#e-=E9:dFd?Sb-3cU?X:Sc\:/G4V<O3D\>3dA^^:;O&
Wf^VO.<G-]/P(8FHL73\F+QeEE&N/WKL6M:cd0&Yd<5_X?MB2M8D4O.AP_Ud1Ma1
:SgL<OSe5J6d08<&,#Z1HW:I]<9R_#/5fBU\N5F0@6-H(9I;0+EO/HcFR414:b#c
B^WP/Mf(RI]UEP&JH.J:^]M3/G[E[E@?5G0-ZS?KWO1YdMD).:ULVS(D:&A/L7^R
X_S-2BHM^XYRD@UO/8d>0FS@C[G[b#dL(a8.D/JO\WU,PB.eY.^(f7P]8-]5J4-B
S)D8M,P9.X<Sd\NB#Z&(Y6B3U08Ye[Fbg(FaVV>&,5#;8=)8?M6KR=c<OQ(M=gda
IVPS;+01:JSN[_;,NT(Ic8--0CbF]95)Z?T9EfUd&6[^+=3<^\^\VX.(Q==b;BdU
:2:[:)<N7DS/(<,R>Y+4=ZLC_;70:b43)13Xd[<@:FL.g1Nc#LCc6)1a=D_<^>JW
CPZ#C_2?\b@F9CA/5HfYM[4EOOc=b&X^25<ZW-gYY;FZL1@R,C@6_+^.GQ7]^Y)>
5D)V<#MU5O#>eJ>\MK.SR3:)Y&&JSf+C+fM7-FFBNeN^<M&RgN_fcJOF^MJ&H5A\
11V-7gTO2_RUUK3f9.^U>L3_4G;FO&4[W\E/BS\I;][5QN#2&3UGP_b>@9IZ]:06
dY(R?\/@/:NVd=1T4/9@,aIb;d25IR-+B<_JGJ3SK75L:J@F<I/V>9M6BQ6A^,1O
)^]+/9-f+O81A/;]=I<AZbKEMgAUXeU]g)Yf:UHP61Vc)90^+HE<N0H,08aSZXH0
/=(FL)4Z8J5KGDZJDCS<S,L3HI?g(g#[f8PH=LfID4Bdd-GA:\W4<X_[/RW_F]&S
7>]XX-5QHR?1QQB/]4/F\U58_>4)6.ReG=..ERFX@YA3TUB=WA\<bc&>UR(,.^:T
AD7)AFB]VOTYGAR?N3W]WWMFLGLS=M[:@O)dP)N]X8]P[/U<KV=5UMXa\+G<G^/D
IMVF/.0/(3RFDHLD6DG#]U[UC)Og;528<?:U.DJ&f^BbP4&;T1QaYOHB&7X/L)\N
Ff&&IcSebV3D5<-e;DaQ.=]8MD,?TCgKJTUgJD>@dULEdWJ=g+fIHS3&gAIQ\SQJ
bg16K_,YK?cYSP.NF,CJV1MHQce<Yf\B[fEA;H]=_^ISORVYK+YXU;M@SF^Edd1X
8IQ3?<:ZP^WcW(Mg#HQ;GU]b;MF1EQc5WTTC8EH+#f.PX.R-I&:VSB6G5:)CLOG:
^G5L/\T,?()V=D4=(c4NHg,I@-gbEWgHQV\X:f57;R<E4((<].C\C3g6\3#L[Mae
eW7EP8B@/,A^7D<-NI4Y);R:N+4[C?a@1U;d(6P]^Z5++17(EIcaN4Ra)8T<3EVP
RX8_REK^^@YSQNE@F2;cVQ>B=Y>2S/CA6,afUaAa2>P2<+/V>IVEJbRS[T;6B[Z/
KG47cEZT?T?20<e6Wb_?IBN]S[,Ta/GA\13QfA_4/c4-[1bbK9X/YTcffdJb2I?L
A<I8DL<fVG(E/V]_Eb0AcFCe:aKQXLB;VJIf)a0,^:RG2I=6ZD_SGER[(:GDc4E9
U^\EY.VRN(ePE>)c(4D73>K1OR[?.+:f)+_cZ:e84OOaDX1TK9dFf;^B_TU;3P6Z
#Z<.A.(<E9+1G48]M?3FSR_JVCCL-ESV;.JGE[:.O?G^0)>W/P6@K#S=K[S-g1A>
VE5/R?8?8/5)9e#>+4TVb8GTF/[3W;c5WM^8LF4Z[OWIgOB2GDH?ZA6O_)>ggDH&
86,AIGG&W\gc0^]KU_-FOU?MFD=85)<R4[WL^cDL>XgXW>;9E-9BLQI.U@DF39>M
P;WW9D,,3SI2D6L\EMDN4OI2cLQ8G0b-(3fGD6:;fH6>[S.^DY>Ndd:7.0A::Bfb
/@(:GgU/=X\(YbFX6C&)0aL^U7,^/3bH5EC.Z-ZNP3PMLdO:aJ6NKe@-?FK0\F/J
8>:K&dI#8H:;R?XfdMEQN<DGf:+X\0F=B^,d1bc3F\XL/0I\L425AZASNB?Y\LZD
c,^:Pe2IUV=b[1<Wd9:QG5g3^CHO-M?J5/a<R_e][:GB@4c2^7TYK<;++X[N,.CV
4(89,J]+EFbL,:Qc.d>,P\&DO^W_[U#D7Y6.K-=B(Q7=+gNgH(L32d,AMWg8A^BF
O9#aXK@/&7)cS8a];])#E7.J?)NH2M?g>@4C+,B/\Q\QZ+Bf9.G9T7dY5Gg>U0Q/
:aRZ=JJ:[^W;I#eK75=K0cgO\ed7>RbV34fY=]d+ECR6HF09N<=8#8/Xd)EJG<Nd
66_Jg?2;QYTBg)O<8CBAEa]W7LVSbf35?UB58bH>:fPVcDL8/RLdf,[C/?bIQ?WS
\B,H0#>a<Q]c9^B)H:K1gE3Sd8[:.F5^GD:g^a4:C#T+68)LZCOOP#b>?YgQQ]GQ
2FefU]ga=7]TH&-#C)CN^HH_FAQ7aT-@K+5^569L-fUd(/4_P[J^-KPbWf&;=Y\F
CR)>2D_+dSRE[ceG>fO\(=U^S65c9TM0FMGB:TY]V]VgV5MZFPS4X/<U(KJ7FK37
E;1,VDC^KX\5V7R(QeF+G?3N_;e4&1;J\Ib2^F^E&=a6@FJQdOLR\-]0C?B(1,^2
X=@1[EGODHM)YSM,KP2)D>\8;[b[(+H-_R.eB)?P;5f.3KR[07SZ+CEd3JI:XgOb
7,5@M2&DRKRJ8JSTP@VHP:&W+cU=]_DPH,.>d6OBX\DM[IGKRN43OR1MWWA3)?:G
eddS#].:bdU\f3#M0SM5X;A+ICL=aJ\#&UC/86Ha55SD#(:>dZc++NASP59CMQHO
bH8.PZF=?AM&UV-YNb&CIRBNEI?@eX36@HKa:Ua)5>7fSBg4_FK60/:[E<:#VKON
U_LZU3+&TeB)(ZU?CEG2+Ca]g?>B7V+]]H+DD?RB#F4LBJ5)d#.)#6.W==G0b0SK
]B@#39TFa0NNX^cdSZUT74[C0/8FJP/A/RU2YN/7<4O&dUP)+Fa;6c?VbL\EPKJB
DR<3LN7/3N=G^cDJY3)]EN^^K>=-Q,e0PX&Rc1H9(QT7\T&E19\#3NY7<7J)-895
bA)P_\@?)-[R#FRD8D)UZR4-\+@-?O,0X/2AHOU@,;B8//DG6gTef?WbHLA92-VV
1bSO3GJQ5)_DHgAOWb01Q2.fN:4D^Aa4W_d>=[#?)5D8((#G#a/WAR9NI.9(U/(T
/bW[bRDV18eX775HJWd:<fQ],@Y[Y7LbL0c^)bgUZ>3Z;c-\(6KSS=>f\A9W62#5
eZ,^d&)Y2>NS0fC[f.T,2fc8,GNg]I&^NXcCR3)eWdU[>;)ggU4d1U607YDML6\#
V9RbDXNY654_BJ4CQ\SKJbDL/DM?5>E5CCM+(BM93[HD7cA]D?^N6/,W;=YL5Fd)
[H(C2S]TI5aG^a<\a+aJ3B2Z2e]>EQ/Qf>I4c&5NH[>d68X=42[M;:69d[O.O5A[
E_VW.aUabNF=_BIDe(MPRY7A+EaGLI>UH[G)a&U>.1DEXAOUZ^K9R@//6R+4&#ZP
;Q1DMYXbZ5>Z^<2AN;X^Q>;3cbZDAd,S/,R([#fX[_UIO7^PPZR7.bZA<dW[(0gE
=>Q_E7<Yc&gV[PV[YY[Mc6&F^KWeR6:[<GA\]7f3FV+Ceg<J]WEL][1DMeEd\6?6
G5-U+T0c.7fNO06R&g2HdD-+<,MQfg7;TULgW,R_#=g_Ja/<)A/=(:4H22gTcQ-_
Y&SYG\a=.cS>0RXcd^(9J^e]WSWMd@a.NJ#J,=>A2_^2V/HI:EB6g]H\_2;07M;A
Z=2J_)/J_]K>0I7c/&:<>_GFIJ(EaG27g-G]2Q9_Q4ICaF=:f7(f@XI7PM<ffBZ(
6T/5\(;R+YP5,FE,@fCFO)&M)B<ec15.RFJ2LL=EX_a+e+L&BCMXCgYa6M/L8;=d
5?W6A0B2;)#L\-WLYQ876BEBO-Q)B[?[?21HXOY3DP+T+]P-C8;c4KK(7I4Hf(eB
Z\<Y3?9fLd_W@J+)&\?XV)B,+:>HHc^JL2ES(@<9GND7T+cU_Ic=CXf/Z,E]DdcH
gSW,EUE^,X18B[VDK)07^MS.;degG./<G1HAeN#RW9aFGOM1QTLAYRO_UdZ[<(^(
3DP;<@6L60O5-.0b6)7b7)[e&A1VKc<#/T/XP#Y\2;c>BBWM]A9bQSF3dCdN0fgM
<;FQHdL#5?I<@T,GF<2fDFfU:FKccGCB_/6I1eK>G7=a=Z4/8VJ@.BS,5IDK4aE@
ALM1\-RX2a]]KJID0?41BD8PV?TQ[RE)gE.dG>;4NM6/;@8,^L[J0,<0=#R0Fb^Y
T4PU6H,gS6F[_(0]&&?,PaLV5/L;=YN2&R1LO)87-d5B:\\_H_<AU+Y,#Zd5B38M
HKQ8;U_),R;3#:TLSBPB?Eg5;[bL59M3d\#;B?_U9&2BE)ML+9SCf,Eb\?&FKga5
IU/9UJ@8#HM0g7D+8^QL2C_4MZ,HUg5@9S@1?CFbeO^cO.69D5e7BK+0\B8N[cX+
V,U>;#YS2C?\^B4dFM.T@g)A@=Yb4?\0D)Ma_eM<PR41g/9:=/I-:)&\P^T@4ZZ@
0ZQ,=IT@^A4:UPFbcBHV7a3M@PQg.A10<+6ZgFJ?#3-^&]=?XR>>[KY\=g;)Q+da
UCK-:[^f(P,<OL@>L3L@_2TPO@9^[4===#LdTd[K1a.BL8I9Y7IM<)_W@;<<NS-3
EHHG>5C(7S^I5f;0#(,4@6V7.._..RX-,b]@g;;A]P,-)BAOOC?(>\VH?XRMPHK_
\>#,H]6K5_C]=(_@cXVbT/;O;f[6Q:U4b?>@#L)3(=/=P@:FWWV<Ef_>DMBG<&Oc
FQ=)97cfg=(@EFOW5L93D_X2WeD/<FL1&IIaI)SWM#Cc6^?T(K1W<-7Tf[4^HX@N
e<ORUD77BfCS&DZ_\7D@(.^S)]VbS;:c#\D4dH^gb]Sb7C@,^X^9K<EE]OeaJ>Vb
EBAbOS8e]SG392OQ^B0BcV_+:L/SHK^Ra/.(48_(-Z;c6P2=/PeLV2G<-QD:2g>W
CFg5]I[27S5V(D4QBH4&F2SB[fMT^?:/DFAA5>]=aQ9Y8^MXYJC2fLW>.=8W23-E
<Ac+S\P+<Qag9;Z;3((#g(Y_dBKVVe+8@^4e6FIg2::?D<909U/7-bb)+[eBNQ4Q
))L_UC@=(TXS7]\=YPE2[1U0/Q+6S5c8-ZPRddeDJ38g.FS0G3/NgY&,]VWU8d[F
S;<#N/L??D7YMTeT8S7<G;26f60]^U&bLJL2:H4#Lc^3=84L,^TW0e-P1+&>d.,)
5M]EIO_&P=>dF6ODBZQb;VX0JSOTJ_5/fLE7^cWLM&TCe;S.R:#ND]OcY^K@=@WC
+^\Hc&98g86Z5RfY7XW(b#3BRH7U7/SG@I;;/[5?<SCIe#WaO(E,;S8>MN]<>:?g
2c[KWAaW5//PVd0/PB#BJP_Q>0X]ZYB&01SR=8.U0Va8cCX,AP.[3DIRJJOS,0RJ
#M?+d7(GLGX-D(EZ/M?VfP0HTQ(.@GgE@?;XMF5@5C_3PGf;V_(D9T@aO;3>H9(6
Rf;c78D9;J@P[e4/g(13:7UZ&dC?.?P<G[A-;)8SC,X06X3Q.2BfBQ^X&UY<TI(M
&/CT4O@@(Y/WH&QL\AWE&e84UICaJgQ?fCE-J]<0eIB.T)514JKU7/4c?&EQSg<>
<K.JP&#HNH_#@f4MO#4#,K),Q4WXKV^CW&UEa=f840013VcC&=[VQC=+f,SQ=:.5
7R(LL+OFCb9^H/Tb2[XA9?2+O,O@V2H7.IJR,KP&1dbA2PXfH2M,:4#TaO54=GZX
^.g4Pf]:^,.H1<&aD2>.?BYB?a8<db2Q<CKI\_7=[T54V(2#87Wc0/2UXOa&2SD(
,FCZ7#;?G(]5<E,1]C9^NQ,bOJIfYbc+eg-M7QReM(eM;^]dUA@QM.T:7Fc1E7XQ
4[[c,QI4_3f<N^WTXeFX\?eWHVTaOFZTS1Jc[:L?/<J_e2PXbVCQ)=FO=g>#A[?Q
PW&OH/7C=cWQ@_>Ya92]CdaJ/G\,YI1Jb(:e/_4[(Z3?\>:(PgT351&M&NJ6)V.D
cfPF4QRX=)Eda(;ET1L\W,V#_;=fO<D1NfRdbSTbA3;aV>TZ#8UCC#3McOF9QfLG
GX@9#_RGb4FK2ZNNcS/M?00-@L(NU4e/RBGHcS5cL-Bb3QJVd[b@Pf:.CS:_=&3/
9N3)ULS&W(K+418BH)S?W./bE<0Z0,\b?V^CbQR@J\4TXZ95R3M((]28QLN=3L.@
82>3d/04MNJ=L0g5#,X9\GVg(@,:=T?,LQZ-@,+YYS(c?/RdB/TB@T.FaP.g1c2U
?S@WF/NFa<aVF5,,S+/_DcJL(040IEa9N[BHELIb54I3--^#Q,7+UJ9M)b@NIS)T
SW;9Y(2e.N2X55F3OJ3R&?;OVL7_7CeZSOI^:B1gfWD(5-63VY+X\=af+WH:7T<V
/;FX7.1b2d7]#cJ2ILVH)O(QQ;H.)?(0,fV94a7[O53KTF(bJYO_:SL<LHYGCI5U
A4;(6Y5cI2/QCWSK,WZ8Z<>[,=<X:3QdEfLSZI;_Y0SNO^gTfPYccNGK],f33CPH
BR.S0GV2#+\E./g;0(^0bU#B1e(R[?fG-<LV7AC:1SYfP0BM38AECeWNP:0KN&[E
g/W^OID;3V9KZJO>Ff6_/<RUD2fPR[9\V(EcCg]E/N\d+PN^B3R/(HP84^<Q9&K0
)4#X.\K_1,1I,_#1Ic_?5gJKN>2MY2XA)-C=;C.Hf/@YeKNf]>(d2UMVNF:cTLA6
Z/5?/C@=35LY;DO-N32]JRBJf/\dGOMUNg+SaKEd?([9_2^\/dA^JQKS^f-W8NRO
_V;TK/)A,M?W,AGS]@AG;)b[9MEff1e9UCG-=]IF0^J=b@=TKF8H3^=^\B&6V1HC
)]STM2H9-Q4ZN;S?d=ETIT8T2Wd8Ab&PIJ_#>#Q)C7\,2J1)272cZ^-X?Z;O7(UH
?7-9GU7D:TH,O9PI&Ka?V6b<B>ABK[K5E#H/_<9#KNTD\))U7gD<&@=\I)1.&d0M
BQ-:O+IM:>C.Xg7,<E;]YCO8WB^(JI/&gJba558ACbe?Bc-1W\aVBL92XJOd0(Ac
;T(JTgfc7Ag6F/EGRA@8QM@]=A>6cN3]>GL<TcK+Y=Cb:d;OEP&(>\ZdR:<ESQgL
SH3c7ML]?<TO74674a=LS&T4,@d[96)@KQ\f:9)eB)AD^e9[BSV9A.V<.4V6Ve<V
gK/8,=^ZJd,46.W8A+<Gf)ge;dJ/JOd8+QDFBQePP[+L1WcWM&8[RaQ:/F03CGF=
F#c:b29HQUFZ1&\=,MFT9Z0ASWQE8@NY,#GT2L,W4eTZH&f8@Y,]4>.5@UI6+Y^/
#G2/_P8G34bK+UW.GY+G27:GUSba+2-1bY8cMO(4-&6.)c8;M5Tc<,d[,](e91TW
1M=Y+bKN6#Ma+U@,Y)(3<GZfb6AR)[,5=(b7IfPeD]UT./N2X7bf3H^>Z&_D:SMA
RH_6(5GdEB8L56eMRO:[e,FK[GJ.SHJK8]Zf2<=T#Sa-5,96&Qeg^aCMCQA/P:d:
cPSac6Ke_4F#K;,]WO[Z@,Y\0-JIWSf>(+b^5F2^R90<]ZD(5M@2WV41cD\Q>0\\
JS6])X?K8e:BFDae)D\/__)83QF5JH>^=DEa(O&AbD8\99@,aR0CR1ILgKS[?W+3
U#8c5FJdJ:8Y;EWU.[LJ1S64).f/)V64O;I66dbRA0(,]>SGC=8KH7O:IWUR<aIA
a]6\WTDeLW7fJfLQH5L+HWeM;KY839SAM_6eOP,J(+^C@ICAQgd>Bc4f3_70^F>M
[-L]VS0<]][4_0((BUE2(0,RHMd4=X_RMe?\P9J8.JF10++#Xbf)RfNEc)PWWTHg
(N=PQLR9SLC35OG+U/CF8S-dFc:0;OJD61[eK4@O\C03VL^C<H)9<S[Z\1CcGAO8
X\._7>I#0,</d(3,A_<@28&U_V1VP#D<4f+\ONPWd3_9B0Z_8[-5DA#28gb.&>gP
g9BT/[?aUV(NKH1fA0[7#T&fNL)4:9>c=S-a(M5T_HQYgfGC>LLDGa?:cJ[PMY&S
b)GfN#L\;5RX>NGg5Dd@YgEd4CM:TAdGC;PLMQS6D78ZcP-Y\##01/E):JT#NOFR
W83I2J=+(TJP<Tc@YbO#.b2J=JSOXARN^,^KU8#?0>b&0XKZ1[b+:F-2UW,#PTP0
PE84-Ibe3deC<\HZSP1RUfZSQZTWHGc]M5=L#;#M:CHf\VZ(T52/>SdCf<9#,bb-
LWS5ecXHL-g6DUGTgcJM5gU[[^bB6G?N_cM3C501D2b3EZ<7:S_C3c8,@MK6M/5J
eVEJ6De:U2.&HWaJ?;-9&,GbW65ZW4JfK8.\cPG5d06/J9aS-cP?.8PXPFB+BF[F
]C49@;U-QN114.FBSH64]QL1_08d(W>+82S:fNF<;T+<YS0X>L@VX/-\[4aF:0<L
RD0Y(V-_C0J9S2([aI;Z?4ODAHNA34aIAX5I+0[/+_^9edD]<#))dBK9O93C#dM(
AH563#bLC7<[6<gEH,0\^TWOQTJOH7<2=RWS\<9T80C^@fDK@MO?<9\+PJ34#^GC
A6g0bT?0Q,7D,VJ118/Q1Y2P8EWEESe)RFX]PF8-Fg7V4cX5TO>PI[BEE:<;;g-S
MWJB8/cH/+Q?:RMTXIE<aW(K1SMB:_OT22U3]C]]WTC00,EZ,JC554./?g1#;3YA
G39ZBWEEHWT,PSc1CE@9K]>]^Kc@I(N9^7c2[=0&e4^U0JP9208TBM_^GTJF&6=6
VfRVA-HAY.IE)R>PEYg#IIgUG^Ja4O>5;LJ=b,Ig3?H.:a3Z1V]6([Ve@[b?YeZL
53I,Hf-4Jb,<V&VJG1f-)GP_7^V_-_N+SB\O&YgeM2@(:Sc,FGea01J&.D\,WRcU
;33MIDegDegf58QL=7IH.CW_[SX5cR\EbU5];SQX@c0-HU0P^>QB&\;]L<2=]O4d
HEY[__N5&A-3aNfWfJ_@VKO(^34ScP1MeS.b0G#D,7&AS44+I.YcW.b0:)6^b.@7
+QTb2aAIY:_=7^L10XI4[C@R3R1L.c\-N.c;4D^@9N6,0D+/JQ/8&-JOe5C(Na69
@g)H8TQe7@1EF\N,(fa3L3KbZK6WI^e=++6=0DfC;\6c7>Gd7BgfUX:BH=,[B,c[
.L/:GY=A__UQK0=?5@B>HO7fVaDA)Yb_LNN4V/Q3=a),6V97(;UCbLW7N64gC&;6
/@[eWTOJSdAFXMMQG].&Y\/\TK-4YeJT4/U[eY[2)DcRA=B]#>d8]HfBH==8]=e#
JAZNKaBIFQ?\\JC1G8d\#.Y=Q^>00EPQ+@Z:P_DX/VZZ][-(/R9c]N2<EGZF7Da:
Og(+B^a;LU75RP5<L952@(JSI5W7P@(==^fJ6\Z0X(S3BIZBV.BPJ]SgFQ5C=/W5
F.NNAFO#8+(.=+.V]&Z7Kc-cag3&_W-:dDcX<73@ZC=?)>I8:;)-GH;89-US<:_O
1Ef]8D.<INb<^5Z_3(ZI1_SeR.\TT^(D\XYR<e8S&GebPgRL)(\<F9[EN&KE:a-Y
C-IdIUg1^P>Z:=3>XETT#J\,V-U^TQB>(e=TLdKRQHP8dcBA3MQR,N(&P(a#N0+1
A;2/471F512^BVM?+Ua8g#3W(CAJ_XM6W>;aK>9^fHTLV2BTUV-#HC+GK3S0E@P]
-MD&N1GN6,Y31OAf[6C].?G4e@fD_&,711<bg#:5I9VHY>4Bc.X&Z\]F6_O7MYL(
^L2.a+TN#4cLVfg4D=FX_)8-()8>R72[(N0EI^PB7W_&Vdd6LBE\TVY#e?Qg@g(-
@S@f;#UU_80c&A:dGdC-&=[=W37e76DZf8e?F1E5)2]UCL5>X+4ZJ_D-.JIYV&Ac
]EaA2e-O>OWaa;E5#.63F];d5W<YF(H3N_-gSPRfFRAN:ZV<S=TG(RS<4U29?d?c
IfMLYMJHKMBG)U2CRbRDKS72_0e()5:_-_6IgeZHCV\W,e^,#X)EA=6+R[&PGQI,
;]/R5XQ8UPb-[TK:Y,P4eLFK:(&C3:&1=N#_<JY6gT\/#cBO-I&_Q.;5cb9bO\>a
;#dg0e/5KMX:VGU=6?6:Q6fLaPF3A?32X[049L/W[-IK\43VL48e+12[A?=E=8Q-
>XPG+<JTI/DY4EC2O1U.cW<@\[ANDd:<RW,(E^S-YAfCIcReT-@3,=bUA>c<3A#g
KC2ZO/.a.[f07MCU4=KaL-96IS&308)2AUM?d+39Y@+@D9=FG#O7B&XL-JUbdR]P
\):Me)]BfK6]>&0]D;XG_B24.WF&;D<4HgUC#G<99(EYT9@BIS-#3QL]b]E8(-I6
g?\T5&-/72Y2+11b_4GfV#R[(N5+b]>Og)@d@SBPUNZ&4;V,G8cEUGa:eI<7<;gG
5<RJL\U]]:[RO)Ef]cMb(@\c?\&RcV\fIG3G.>57XG3;FbHQ#5GVc;E[;QQY6=/-
L.g:7@:5:PGUI89,=Y1-VP\0CZ_^?ZQH^4U:D^4K(.dR1g\_OI^@9;R>[]=58=R\
=T[.Vd->8J5Agd=C720\1M=K5=4<K,=OU5R;U_T?883_QT+V^Q-2QV/d3,/:SdT9
d3ZdcI:gKIG-&SLO<=]9_OI#O:T<X?SL?+>&0]WU-T>H?9Ha7XI3Z[XfS->V9Q=W
1K_.N9#WD?7/N4bUQZMeZYEfBc#eQ?ZAe689V7ET3^37;2.B?3KV4]RB6(XDf1SG
^UE>fRK10b[Egb3V1PBeS-d1D:850QP7A3E1I8#:(WH#Q?.SYF7]>6)+Wf)2[:?/
Y+JC,=LKR2+=^/fT96Y<4=@R-W=0Y<C3U0^?g+7?Hd]V].Z4_B.K9Af3AJD;[\ab
FHJceT0+17Hg<2YKNSA+)P4CL7d;Fa9&3g1.Ga&Y>\gRb873\Lg&BZ/g(gK.B.V(
8V_L=UF_^Jb^_e>0ceYY^0DS@#f-g;^?1&]&(P.Ld&=[J,;[_.Z/VSIDC]D@H/gN
S@e8e3YO<f^]F[;e8ERULQag=.G:g>\STBa:ZK0U4Qe]d6gV8RLBKAPAg>AG]=b_
(EIL1R=_GgHIaWRKIK-g8JK8^WDb[=TGYb@CT:\Cf?(UT-40cD0>/U>+?YU5eS@f
O&<;/;W&DQIC[MD/ZZH72ASR5^9PEQ+O,9X9#1F00_[Q9DZVa=9+3=#e?)3<9a3Q
CH8=+_A,EO>>,,FOUU^SDZ7JBPTA-g]SL]_KP:70(3He&#30V7BNc7Q.5G>YFN,-
4>OQR9.HVPCga/82,X;K</d)8>dae.^3VfU/O1R7e1MGNR:?P,f(TA<I0SPQ^7W\
ab60UH15bJe/)&g=7K<dBf(&L#HSEaZQ/I/Y?SS,39AJA\PX)JNO0JV5?FfXKfWY
4/,<RaB_</]CK?.Ye=V(\;Z1#GX1.\UAa_W7?W:?gM^(S&cdF:26M,VOLEeUbA&H
TdGO5187MW7;cccM0Agg_OT2>1I@/Y:H0^]]23U@bYYa[3W4W.9)^L9EVI92^(,N
(8G#[,ZdLbG#+ITHBCBGbE67U3+_I;:7_T++c,RX=GJ/)(V]@;DR7[gX[f&^KFLU
;.GOCUS_<A9M<:NRIg?0cWX^9XS9OO:Ef=A/,OW+++I-\5JN[@YC?-7GceIUdGL<
&;]]T#H_C]O6#;G)C+)N&GYg#Z.=Q\I^T22-U1IW_=<@75QJ?2M<1b3<,HTV2=_+
SDVb1N->fQH&dQMCK/\I+],93:X[)?<V?^LB-CgEU#[c.c(fM&=UaOE67FI/.bF?
+VZWXRSADER)CSW\+OM;UA4(E=+6a;)4]-W#28?/HO:6\8,=T+O9bC3E2LBg#NZK
WKeT.V>GL:]?HGH8]?D:[LVVEY4b#Q.A+PD@HK9CQ0?c==1C-;RBdSf4<;2a-C8)
VFVQ:9<gGBNT26OO0fU3J6c\406-Y15]D[(Uc:6a8\fR+;E4g)NE/Pde8[F1]JD9
(^cgd[&B[e6?=d_TCGO_=HLd<eUEG+/JE+-dO1SB2fBQUUfQ#1,]8.(^DF7;7:I3
3=GU3bZ1D#(_@Z5bB&f@?26D4L\-M&7&M/UdS\0.6]G24GaA<H;I4TbRegP:X\)9
?FMfUfB4?RGVW\OZNXY-S2\C&?HGDDTY/52=dXVcg6D@^;UO2?dQH\0Y0GLcaF(7
/d3aN3<dI[=U0bgRYV@EI@HKBO+(#f93ePVQK)3bMHH2,IW;/MFbeg1b5?b-Ce[e
<Aa9.U)FfGA?4N1eL(S>fX+Tb^5Z.Ta@XTZWALK^<+68Xg21<U@1.B3CVb/eLSN.
P^0da<68(]D[HI_C<7VR=9(GV<)>NZ;Q+SUBW8afLM-dU]>W32CZZ=HHUPWLFYf^
/Qa^?7F[L9>QV:9W8+_1)Q]P#>PI24>UK3:EH/7X2+2998+4UXH-=U;O&e@<RYI=
Mba_LP#CLSZZ(OFP4QF8WI988Z4PTA^D@JZUB8@8MQV;dN@G:6?I8<VM(f6L]^7W
\Y5[C,C34C\0VM>aA&^=Db2[63XeUVDNDVKJ_9B9?gg>-c;32Y)b+@#fg@VF-+)c
H53QV:1,4EN#W)3Cf0DTU5U(#:<+1-/TMMg=\d8d2O70>LBdX\^Vd:+^<?@.eAaO
LAdcJT?eS?NfgT1.9WQbMIaO_9X&LW3X:F?YW?f[QJ5BQ=gV#<Q5]M,/^(^13Y9G
cP04M10e,U6MA/+AI>EH+Y[(9@SC/TC)8\9LXP.7POAY6PS@JPb?(=#^OVB<N_TO
3&MV3MY2PY6.>Cbd.H/9Q[>@A#:A\X]E=:cV];M@IU3Dd9/7T#=4A\BeB#_CQ4O?
cF>AD9D=Mb=:]LP<dHKJe4LP7XW=&03Z51a&4e6)+E^7P+W-H2[(F_E\V1+d\&b0
bTdfN9E0Pc.Q.VW3&]77^Sac27\ZgV0Q05,CHJ]b0O0[\gK4CCWO1d[Sf;RFW9[X
91b[_[J//QTUQ8UZc#?A<aLN@MUf;4OOAED+c,:Kb&A0OX8dO7gg^C#@ZAc^10@Y
5P/&ab/9VfJT=XN9Hg#<+][_^c2=[]AdfG<F#WP#UIN@+eG+2?e:Mf#4&5L-SE^A
+:]<]^I0\Q_e:+]fR(6NbIZUedBNdG.0_O#F:HD,BRZB_9NK_^<X#3?WN/&L+FZA
(TOZDc.]a3=KH]6fPRYgC3ZW-d&O#A#IQJ<7<V<fSFZ>03aSE<#61_Z>K3>;^L#E
cS8FT18V-9-A/HW83<Y<0(P2OAEZUB<^^VXdVfSFd4&=3aJfT(OJd:19]N#@+-H&
LbL2OO-A#4+_LZCD9bF(MS41ZOMMa32#b:,W-Z=eGJO]8N3#1V(&b3e4AXd+g9dQ
8eQ;^YJ\[(/G@>]324S(5_TO/F]d]8SU=;bfRUeVC1VUX=:PYL)UQ5XT-VB,aC44
F4gRggD1/Y8J^U-967(N(C+YN;C1GK6Gb\d[A<#GLGGeH8G1MO+G<]X^=5cdO^?O
H]#=\Yfd#gf05&1R=QRO^^V\6==1.:3>G<O=9S1D8GfQ.eX?fKTJSF^47F@e/BO#
b,#/>L3_Ka++d49[;a()+AGGaHL1^_0?0e1)[7A_9O6c7(YS(0=7H4=2EeYCMIV@
<?CV8fPfFG0W1Y12K=0Q.XBL-N5>&1b)98:VS:)6D-8YOS[YUNN&c(]Z[AePE1N-
,A;@-B1P4LE0OGP6,JNMUM]H(>2)FVKKQ(c\>:Z.GX+48D4K540UP/_Qg<dN/(3/
@VFEfc-aV=gE_LG[eU1^V6,(S]bEE2\gN_R2N3IEAP\1Yb@gQ2&aGd7Id20;TgY9
9Q_g@ad89#B-ULFE\J46[,>.U_daZO8B(<_-0cQ,+FLADg;4STg,];cPaa^SN-BI
GL14K\4N-a<1]IC/NK<T_>_Z6Ba)X-Yc-6L5YKbJ><#[g:Ze>BEO1=,?>V.dZ>Ua
S+\;fLHfcH&:\a:cVDa>8:I?T4J;R+8RC_@O>VaYZ?3[84E()Q=BKM\XcRd8[&<Q
;1bB4GXG^c8W#G#5:E:,&P4^S,BA=,8XgT^cCK7O#=I<(KTJaD=MNT1UdYE@:L]S
aD5^H-LHfW_+HY&_Z?E8^-g_),a^@#5B0H7]JQc1D-C9G.fB]^HP./SUO@:=9Sd@
S7BNOW;;G>A_OHG(VT-+:d,Rcb[W1((b8/XIEN82a1O4aF+1YJV01)VF6YHLdQVD
KSX83KMHc-&F5\<Tg?,5BSX8(9M_f4HX7/L)4NYXU&-69Hb?McYSD):FdO5<_:0e
g^>UG?2fQ>PGY4D9#[4[07@/fJbQ+bTe>(b@O&5fO:MVc=&S/fOKK)_OME.;+_L,
DP^2,LYYa&gVb2gF_a6IH-PSANL8GX9:IO=?>70K>Vd2U4dgKg2BS1L7Z8U;UF=+
C=2([_C2#4#J+WAf\CM1TDOgPV.,Y3LIO=fY&A]G8B.I/[B^f;QWL[^=M&[3MNVQ
PV##TLL=YJ8KF6b5SPD-1JZePN6FU?5T=]&Y<fbY(,gc06I7+FXeM@^94K[+[<e0
KC:N\26\9IcCS1-\.:TU6:JZTDgIOgTfX86QFGE5;^JYe91Y9V[d(8\RYA9(9f)V
dS:H@MYc6EYeI?S4XP(R>[B;L8E^P3-\8MW(P>&WP<)71AdE-C02^)\Fe,Y+6<WN
[;OBKY7KO_dLL7fSN2A4;@25>?gLN,ZQB0GT0,O:(J-L0J.\>;2Mg41C5+DQ@858
Ic.U5C]1CQKD>]+]W:V_0CL6e,IC,d^Y&cgB_@UK/KB,=:Yf@M?;BK?a63BP2.fO
gfGSW>B:&ZBQHe5M2VE>9V2_HZcE(S.V3)P<N=JC>ZD=&=8D-&O9^2J2C.W8e^Xe
aMY1[E/2-RF__HA=Q<\\X4<9_@c.e_:.[SY\YXa4J#X(dOT;JYW+MB;Sc76V3Q>S
5T<SJIJc\e?\@N1T9f@\W7>a8I>:2:YcZ;=KRD6NaFPBbGfC:e7P>RT,cV89@JO8
WT\(5VWb8f2H^81BR9NDf<gT(/<)86\RK0CZ-N?,0_bKe,?3ED,.H/X\+70,g+AF
QF1S0]GA_#d<fQAKeM6IP@<MWQM,#]c\_Z@A(WWBb(aQ(CAG9;PI\(K>FF?6@SbS
;eUH_4:e\OgA(QYF?e,?[a98RgE8c\UB:A@\#CKFP@/2#8&\NK5MBUN_BU-^(I:U
)VGC8>QgZT9@6Y[>^g1SFHK86e0JKZ8X(/Ue_TI2/R=5U4:.:1D@JL2JM(\I^3C#
W+X0eT1N>#Yba/\[R@H3BdZdM^BO_:@Y926+K1Q&6@,Mcfe)\&cgA<V3?)dH^-W7
]<L_[BU=S-G#+)M6WA[(S0)M\,=M>Ob?I[5\K0#(QFL0=dZJ0De9U5^^-3a_@]9#
RXOc2E(H6B<:(ZN\DLCa8M,f56:SD^;Y3_.J.5)[YJ:.=BLV36F5;]Fe==.U??TM
SCOGADMRPF<)H0G^JM9?Vd:H;N.YFfM3\#I8XVY)5\9;43PN-3Z5^6:?[1:2G3ZA
g_Z@RZa8#,@a^bJI52>a>8LI1UXLF[18G]BH2CcYW0c>LTD=)SE-PF#6)VUROII]
U27#f]2_0CBg=.[/O4YS2VW05C/QT&0>JD;@.?b7bb3U3bY&/:I(1W,03e])/@ba
3e>b=84DOUGA@J\84C<_:SI-U)\[K9ZK@gFBN^gLO;_^H&)<fb[C33G>H26:6/X]
TBH-./NV9THM4R[_cd0bRe-?67GJ0-GN>.IO3QgbI6A;7=_Z-/?;NL2^([JT2UEc
F^[Pe/:XcV,VM[?N>1A19F,IWPDaQUKe(e@YM,Q)T1(Da)[Sc]\0U1LWE8Xebd;+
^;F2VTT=Z.H>3_d5Q20<HG3/AJ85E<ID2H29@KM.LO?M+b2JcO?;g]JgVIaWe(EQ
NdPK1],fa?5O&7[B,aPCW:^3(QRT?C:[,.g&I0D#VJNN24O,C>,F9@70gXP8..(X
e1dWJ/CL8R>Y._NFC]b#5[32#E>LC=F1NHDS-FYb1.0\&2NN)_Y4&a>fXRWIE\fN
ADVWC:81&F,2?-;3WO@+-)[Y1BBa98N6fPF>FSgO2(+XB5VPK;^)1Ce9dLM.I>B]
O(d#.YO\E.ZJ50Z34++I;SPg<CF\#_eYX\^eA7@R2P]9)A@VZ)f]OOV_5Q77C@g@
U<IYA?D6TE;Tgfe4R#9:^V22MQ[c<>b4EaOHd];H.DFHdYK9f,@e1CWU1;O0XMg_
(.-d),M9/NOZ#[15-11P&#7d14cH=MD99H&Y99O4HJ44D-,T&-MTY)FD]OK5_eI;
?deeC.AH&NT80#:W>BX#&U+_:-[V70GU<9EW0FO1/d(da?ADY1F_<U5VX)MDGGHc
ZOEZ=K42,QUg=J?><-+S?fc#ER_:cMUZ-@:T(.-&7[NS[dOHGgSD<DDI_5MA\aBL
I_<9@D[_,P]PS:JcSXP8,ABZ,.[5B^-]P?3XQ;XDN>QWCV;fLN8J8(3Q-)#-S_-H
a(]D4Xc3dJDPRRKY&@067Y;=Z):#DR1&a^::LAb9WR1+^._^8O^(I7cfLK=5,LXf
D4JLI.NWQ+@XcG8O;JVBLEQIK+I8V8Rc&DC#O_^^ff<DT[-A:?]C1;8IN8<UM4>9
.N])LJALB(RR1NTQ+S#.TNY76NG7,aH4WSII-_LW8>:PV_?GEOa>_B.#MYb&fFNd
9USDS9DPD_DCB]4Q9P[4c3H=OGI/b1BUSTOB7PgX0E45gc8NLR=O/]JK8.>L.A\0
a:dJ-XIPT-I).&TUV.=)1d8C/_0e5R)_@HA<@@eF5?(=ZRRS85Ra?HCB@9&@ZB9>
W\Abb/5S6dFSCMF)PIKV>P0QdIZ0XY+Yb,<#5QTf6P@#/B6VR+.A7eIL@.NDdNf>
,a1UD>bH9L=-Fe3<[EC/>?8)&)G9D<JV&Nf_5,@__^=XVHNA@T]FJa#/(aPA19)I
7[<]2dM@T;NcUU-KP2/0O]LaH1.H.>Q)VV05C-CZ81fN#5-ZZ=4MPCLF,Ic^;)H.
eeWE0_g6:PV1U.P=2:OD^9Q/g_#?4][P+G^:<\@]E.b0FO:@,#KQdSNMM+>AafPJ
WV2.?ANdA</Q2B-V[VeL=ZWD71JKJ4W]^ES25NbQ4F-LB=3BdT;C.KA;Gc33R)Ie
9AN4QE,IY.bRO2U:TZ@]+2CR97O;8VB3O#=5/C#U.SPd6R3J;a_B]3dJbP=3HKd.
3.NQVR7bTW=UACW]d85Q6;6^O#Ya-G6]J;)2S8+AZAQH5K&dVK/L<^_/L3[a.18,
ER6.g)>/##[6,d2JMYI0#Q;6_bX[&;0,UKe[=Z4;GE^c22a>WaHf(IER>E:T&0;R
\6PWB1Be=-_+UDSd4,aXc9a).[H65:dd-C_=FH??JO^VS:W9HaRK(M7Y2?_^_++W
5NeK?#]\e]O4?V(/0QE=/gDQ@5e=bD[Ee_OG8N2SE,>Ugc/<J@3FZBIVE[KOFP,K
dU,,4/>#.6)L/F@N?^<c?R?]L;P8Jf7@MR[HRJ,^N_.f1O+e91Qc+>/e1g>6:5[R
Z-2OgQK]OA;K_0SXQge,7EM\e]4R.c48\^][C2EJa)ZF^O82/?^D),9V,)5RL;G+
:0.LNM]79B\6RZOeH;2ZaC^RBDOC)6HPe)NO9c7X,Z)c[/#:8,^Z>VT_O#b_f9eO
4UFS#^ZPe-T6Z8C]YD^REH8Wb:2BEA#g0>76PQ3@@G]H&<M:TNQRGX^X\_3I6c91
7--;<WeFN&<?Z1<,aSW-QU>,&PM=a1MeH4/+XS+]SK-4EPUNWIW<#8AfO[#<_/dd
=(5,._Z,@c[gV0N]L0[dPeV0JK)f)dIe@--?e<S/YWIXgL]bHAXAZ/=+L8_7QMWA
/HA>KMO3]S^#TP.3H1P&\NN+H[4[355Da8;RV/)M[/bH=+195]V,))=QDINDcM@,
<R[B+W_ITfRc_J;4_<ZYZAP_7]=egN8:Q;P6EQ_^ME4,Dfa]KUIa,]]&_GYU&4Z8
dVA,V1U0B:+V\.)R//f[OK?]ZRFR_g:24([QG8_]Z7@&0X;fA^.b[<WF(EKBMT5V
ZcZcQDW1=>])[>JU1+GRT&856a)H>.&0V9b\1VbTd=c@KETT(VEeWd6@@Y<8,d^g
6QOIb=b/g88A_3=5.#8,bE#4I\K]1U\OUH]>\M?<=73RGc;U7gdGWdQAW2KG2RU-
#[_8TRU<aH\CVK;\0^+)+KKTN<5N@R??Z[+^K>EbIS=3FVO1#7\MGER5/&/8\0KB
.P(U5O#;f+RTd9^3]4)B,4MIA+:K/\3&TCL(XT6I?_Od98:4/GE@B@1Ne#+72/8N
,fWea.f;W6#0G^4gAa-O:dS-?HS6Td@_MP6:EN^>GX+dE$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_VMM_SV

  
