
`ifndef SVT_AXI_IC_SLAVE_TRANSACTION_SV
`define SVT_AXI_IC_SLAVE_TRANSACTION_SV

/**
 * svt_axi_ic_slave_transaction class is used by the slave ports of the
 * Interconnect component, to represent the transaction received on the
 * Interconnect Slave port from a master component. At the end of each
 * transaction on the Interconnect Slave port, the port monitor within the
 * Interconnect Slave port provides object of type svt_axi_ic_slave_transaction
 * from its analysis port, in active and passive mode.
 */
class svt_axi_ic_slave_transaction extends svt_axi_slave_transaction;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_ic_slave_transaction)
    local static vmm_log shared_log = new("svt_axi_ic_slave_transaction", "class" );
  `endif

  /** 
    * When the #axi_interface_type is AXI_ACE, svt_axi_ic_slave_transaction
    * represents a coherent transaction received from the master. In this case,
    * if snoop transactions were sent to other masters corresponding to this
    * coherent transaction, #assoc_snoop_xacts stores the associated snoop
    * transactions.
    */
  svt_axi_snoop_transaction assoc_snoop_xacts[$];

  /** 
    * If the transaction received on a interconnect slave port (from a external
    * master component) is routed to a external slave component,
    * #assoc_slave_port_xact stores the corresponding transaction sent to the
    * external slave.
    */
  svt_axi_master_transaction assoc_slave_port_xact;

/** @cond PRIVATE */
  /**
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating master. This field
    * indicates the parent transaction from which this transaction was split.
    */
  svt_axi_transaction assoc_parent_xact;

  /** 
    * If set transactions will be forcefully routed to a slave, 
    * irrespective of transaction type.
    */
  bit mainmemory_data_exception = 0;

  /**
    * If set, one port which should be snooped will not be snooped
    */
  bit snoop_routing_exception = 0;

  /**
    * If set, the response to a DVM operation/DVM Sync is sent
    * before a response is received from all snooped ports
    */
  bit dvm_response_timing_exception = 0;

  /** 
    * Indicates that a write to memory occured after the interconnect
    * performed a speculative read to memory on reception of a
    * transaction from a master. This means that the contents of memory
    * will have changed after the read was issued to memory and so the
    * interconnect will have to read the contents of memory again
    */
  bit is_memory_update_hazard = 0;

  // Triggered when the assoc_snoop_xacts queue is populated.
  event snoop_queue_populated;
/** @endcond */

/**
Utility methods definition of svt_axi_ic_slave_transaction class
*/



  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_ic_slave_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_ic_slave_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_ic_slave_transaction)
    `svt_field_queue_object(assoc_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_slave_port_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_parent_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int   (mainmemory_data_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (snoop_routing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (dvm_response_timing_exception,`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (is_memory_update_hazard,`SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_axi_ic_slave_transaction)
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_ic_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_ic_slave_transaction);
`endif

  constraint reasonable_ic_slave_response {
    if(port_cfg.sys_cfg != null &&
       port_cfg.sys_cfg.posted_write_xacts_enable == 1) {
       bresp != DECERR;
       bresp != SLVERR;
    }
  }
endclass


`protected
XRgHgR92]I7Z2HTfT(b36++ZZT-I[5UN=+):;L9NI2Fc<H-[:He35)e4O[f-&e)0
N)=O,fWE)/bcR]Bf(_6FLb@Eg]:67I.W8-K]b2>[VW-;D_K/g&2b6^RW,Y/A0MAS
>S+G_NZT-V-5-<@L=egddd_M,Me,^#\D_8K&><Z5>PXO]<UZX97QYFBN?>KG6b+W
>efOXPa8&V1;_0BP>=0=S#)K0OSeU^^7VPGCSBQ+_>c3+aN4RcX@[>Hf7&VJOCab
4YC=98M(Cg5R[JI-M9\d5XW#I>d[JH]VLc-/LNeR-N@GNQF:EdFVX@&I@LfEgcca
ZD9KI>QIJ.1BE(O9MWb#MRd16dNY7^\+>C9JPe/M]e#e?8]\+/0OJ<^0)C,)g<KJ
3MNJFVETKST1/55b47-4+KFXOO98,U?/D0YJ+MGG,4V@N,6N]8a7JgRD^b8=K_VF
18TK<?+ZdZ&Ef0?6_F5DKFKA[[?=,a.5+740@>d^ObUWcN^L;2)AV,J:3Sga\34.
LE6a1+V=??bLBR/L-N96MXe)&#E3TP)KPVTMcDY)XB8gb;\E4@5):V>L=KW#B3aJ
]S3bEbDb2)__I=+f)\P;IVP.:-E8cJUIO,MSAZ>^89VGRB&&1VQQF;-,O644AI@]
Qbeg0d8U]@1BPG>P^X>_U\-<\<HXAWF(,bd1)LfE]K/0DR\Q@:91PY@X_&63Fg:f
#DV/EZ:ILHO]^>E:]78G&H>d]OC76],?b(@B)-D)cN[8<E3H<Q\OA=,7Y-D\@O=2
SZW=4]_K<:@50fIFN.H1P\(.dW421E2<VQ@,L\,;(I7\C8?HK5Nd2ZB#@3,4-ea1
E(eKJeBb;d]Keg^E:SGd\#D;M](^e78ILXH:\FFG4He#9YQe0&[=e0?YW+ICNT<F
g\E&RA-EeRNKHE(C#=WP\LNAMCdXV]7^\;_UCOe1X-R#B$
`endprotected


//vcs_vip_protect
`protected
GU5JNeQP=J8bd/F3MVQKBE-8a40U]UeR3aWP]fSP6.QSQQG#OcLg1(MO?7;8+ZW=
YXL#YG&._._88a-;HNH;g7GK>3.2<H+GcR2aFPd8LScM3,\3KPUC1@OSO?\,D-#<
6>VLfBMb&N6):XB<Vb_1F]Z-Zd;<cG2W[,WM50_&A?FFQCHOR]9V.d3=.A;I&\8Q
),O7cfQSAUNF/Z.>@F>B3>.,9PUEcS\aR&V3K[ZV(f4A:1GP87;=S4TWc\M&Y2/W
^b^e;F2(T.X\,Sc3WbBTGUK9_5e&_AYU;6&ZVL5)_3KDfCIP7/006^^#^1.)I6M+
;5,06QeW.C^EbBY?3YA:8/09:JC&<4XS^)4=/L;Ib;Xdg(gBT5^bNU+M2^2VaZ]1
M1.@[^-Xf8A,RM4)f9695PWFPT:^MQc2+0JVY(ee6e3\I;cEf0eO_]bZ)PdA,.UA
-DOXLeQ9@-;XeF=XfQdgDP933B&c>fR/+:3:-+c=IaO]P7_bU&R^W>2WC8T4L7;A
A:N2HDA^cWbX(]NB1HLc]:aB#S]g/IM]KA1SH>Z;)V,b)7T@N0#Se1#.&AT2g=,V
NXVS/P^b<:E;K3@71FGXJD[;e&[N[>-NI_H:8.LHA]RIa+L:B6@\7RWR5=#[6;)+
F(R#Mf?MT[EJ4_^(MBIgP4+?NKIHN,Z&\NSC+a6>?;D3<]5W^-9N]KJ:BZXaGcR?
LYZX]KE<-Jb.?W)U.4M9/=3]ZZ_9fJWIB)03GJ/Aa@X6R9e?[<@<A4cTI6N1USYV
+ZOU@.+>32QdR)MVJ/5J<M58VbJD<?ZU-]?(eMC5Q&C5Ug5RVZ5#^/Oa(?;NBKCc
R&@G5195e4IPWCb]XK+95dPRb[T&1(8_eL/OU82^?RAO1[8UX,JR.UgZebT]VN^\
e757PHB11N5P+$
`endprotected


`endif // SVT_AXI_IC_SLAVE_TRANSACTION_SV
