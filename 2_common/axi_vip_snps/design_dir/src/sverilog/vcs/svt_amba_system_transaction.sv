
`ifndef SVT_AMBA_SYSTEM_TRANSACTION_SV
`define SVT_AMBA_SYSTEM_TRANSACTION_SV

/** @cond PRIVATE */
/**
 */
class svt_amba_system_transaction extends svt_axi_system_transaction;

  /** Enumeration for type of interface */
  typedef enum {
    AXI = 0,
    AHB = 1,
    APB = 2
  } protocol_type_enum;

  /** The protocol represented by upstream_xact */
  protocol_type_enum upstream_protocol_type = AXI;

  /** The protocol represented by downstream_xact */
  protocol_type_enum downstream_protocol_type = AXI;


  /** Handle to the upstream transaction represented by this system transaction */
  `SVT_TRANSACTION_TYPE upstream_xact; 

  /** Handle to the downstream transactions represented by this system transaction */
  `SVT_TRANSACTION_TYPE downstream_xacts[$];
  
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_amba_system_transaction)
  `endif

  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_amba_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_amba_system_transaction_inst", svt_axi_system_configuration sys_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_amba_system_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_system_configuration sys_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_amba_system_transaction)
  `svt_field_enum(protocol_type_enum, upstream_protocol_type, `SVT_ALL_ON)  
  `svt_field_enum(protocol_type_enum, downstream_protocol_type, `SVT_ALL_ON)  
  `svt_field_object(upstream_xact,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_field_queue_object(downstream_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_field_queue_object(partial_associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)  
  `svt_data_member_end(svt_amba_system_transaction)
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_amba_system_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_amba_system_transaction);
`endif
endclass
/** @endcond */


// -----------------------------------------------------------------------------
`protected
<<gSb<De0JWU&<O]PEL=.>d91:M,g&V?.HZD=C>@I/g@UKS)6-)c4)WeKM5H+aJD
9V=FV0NS6@[bY9]?-QEOeRJ76AJ=1I0a9U&)_a-Q4c.#Z@d=OL4FIE_#:]&7/ZG;
XDPg\K.J5Q+/c0FAN20C&@FK4Z=]V048DI^U/9K(Ie&f+J-9T^^J5M^Sf>KF)g9f
IZPZ+ZdE+K2e#5baED#06+/Bf.d<EALT?dUIKeAU:ASgIPUVfdDL<dTbH8SLQL,c
/=LX:K?e).Z7@2-EL\,Sb)eIW#B-P?Z@P],aaW@+=3&^LZ&NMO:S9:SM(eJ>(D^.
)eT6)#[(-.K4-F9TcC-@/S61fcD7Y?Z(AA0F[@[W>IdCJc2F04Ub@F;GH#c7HTBP
G8HTDZ=IIQA?]PHUFOgEE;edEWM^#A=e5@JZA\Xf)-H0-dgO:B[cSR]?BfWa3dB&
F<bN\5+92.SV@N9]<ge(]#\F/39[EMT??@R?N>])V-Y673+9X.IE&Ng80cZ./QUc
H7c.d=3_.[CC@[Y9EAS:./YEKB,,fPfcZE1#.O5?>/B6cAG^BD740Rg.>?Fd_5+1
;=>COY^7,&]=60T2PO6@b<RW_M>ZG2=RG#ef@6XH]-g)KG9(&&aX4fAOYIZgC]?/
NH=W/bXWCHU9Oe+dD6X_)[.S+FA2:Q3d+f5/b\R]:?[O[CCb.aK0MGe@2]-2:KN3
,)R20+F,&\dEZ(32:YMR\_c<#C5LWJ6/-UW9^1,BMSAUaf3]+e93I[^a<F9.]1gF
/MYU0S>1#a\GcO^SXTF&&S>7VVD-),74F5X62N+B)C8@:[TDMQM<^df[ER?0)4P/
dd=.P0+bcO82GFZ@7T0UUYQX3@MWEV;??$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
],V]I2fQE8QIV(U^>@]f.@&03X,K?.\;Q&AGgJ9gUfbB:(3SDTg_0(3Pd+JDU&bE
,[X[70/^a#:H36PRSf=BRU2[9&YLa267XV4[71d3.RIf](DHQX-J/#+1CA.69@KV
fMA;/b&D&W=W#V<23J,F/@g)P2?V=31I-:(&7\SgGV4KM\Qgb@(FSL5&BH8VPe]1
Kd,+&dD<X[1g?a8&N,RBY&g(TUB<_ADd>4,GAU6.7IO308HM62,_dS9:WQYF52P^
&dSLg:R[AS-PO>PIUK2XdD-&(FfG,Yf\1OfGJ24X5S,3cgHP_9/IYO=.UeSaZfD5
_9C@Q>Rf+-3.7Z)-#)@)?+X4RMFeECM_YgNdJD69,QD,].fgbR4#A]66Jd9^\2ea
&?5VQ</HAK_^aA1<BJ(.4d#6.8CbBE3RCS.RDgRaDK,dFI.0-;A[BE7?P5&+JM3<
3?Q=85f()fLbb,[B[gD\&V++>M^?(9g<4X3WDNQg-8)D/]@8dSR/gKFf[\SP[V+K
@<d=5_J;3+#,OQ1INSZM.70A5)T]\P-O<Z4YBQ4^,B#(5Me_ZK5DAJ8N.R\:9]/@
a]0]dFU)7^eFO:9TQ@8fS?+MdR;;<\UM_\?A#<V7;&08@G0WHbWO&+VL]W_H7J)3
N_<c9;=,b24F:OKSKgUZY&cZ[]acS\3?WaT[NLZ<B1X+dSWNU-eA)71a.B[M-2\/
XZPeW=W.N;?;F)RW4?-6G@E.@d/&+RYNL6XgP(?.+RD=7,YYX1E?,62,(6^M,dg]
C^WfZG<U>8\d#\&F7&9XXH^Z#YU0@W-[e)8+9T43Dg(7Y-+B12)Y7#5b01bccT:.
B6&V@/Ae<K>KN@04Q;4:5-dY.\-40TYQJ0MD=P4:(2bYQM#5RR9,+/4/Td(5g+56Q$
`endprotected


`endif // SVT_AMBA_SYSTEM_TRANSACTION_SV
