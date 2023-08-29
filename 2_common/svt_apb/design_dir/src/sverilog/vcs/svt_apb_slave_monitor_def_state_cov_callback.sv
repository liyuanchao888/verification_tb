
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_slave_monitor_svt,R-2020.12,svt_apb_slave_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the port
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_apb_slave_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_apb_slave_if.svt_apb_monitor_modport) extends svt_apb_slave_monitor_def_state_cov_data_callbacks#(MONITOR_MP); 

 // `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_RANGE_CG(paddr, cfg.sys_cfg.paddr_width, master_sample_event)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_RANGE_CG(pwdata, cfg.sys_cfg.pdata_width, master_write_sample_event)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_RANGE_CG(prdata, cfg.sys_cfg.pdata_width, slave_read_sample_event)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_RANGE_CG(pprot, 3, master_apb4_sample_event)
  `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_CG(pstrb, master_apb4_sample_event)
    pstrb : coverpoint apb_monitor_mp.apb_monitor_cb.pstrb { 
        option.weight = 0; 
    }
   endgroup

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_apb_slave_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp);
`else
  extern function new(svt_apb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_apb_slave_monitor_def_state_cov_callback");
`endif
   
endclass

`protected
c]/>d;K]7H(OC;YO2GT4feN6ZJZM))^J#5aRQ#-(U5OB+?>,/.6R+)[Z,]:FD)6-
&?3,d^YUL3A-600&O-235YCe19/T\,BB6U5K(>=T2FZ<>]V/Qe5AGg\6e[+T68]E
41KL&/_RbYG?ELg9TVW7C(?>WI_&<A?d^C98ZUL^SMV.?:?4V.2@RSAfR)YT<MLL
gN(9K(X;-,Ra?D&+QS?fI;)SRMN1W2L-X]9UXFf&P@/LY0@SD?Q/dPZEU(XK\OW<
O2F<LHga/H4K@-8H_Y.VQ@:#dG]B6f5?GEQ)Z:[7C>7b:e1ZM6ae_OW#]F\g^0eD
bf5;RUd]-?g_,+,dM-,\\49;XU+K5YQcND[O0A^KQZHS[0CW3d4<Y7SZ80;RbXSY
a&@];cP0dFHR&[L,G[P^4,,OB/T<6SF_O+,]90.ZDbOd0P.0Q^1L:Z=BEcK#+S#_
XOOdR]EAR7W]E_7;\@=\aX4bK3/8IF6X-TS#22VNe^Lf9d=U1gG\S3XPNK,TLf2>
=(cZZD9Q8UFP1EQRf8;@S/f#D9Y@GFca2?cK5+87(:A[>PBTPGd59gY9Sf-_cIR0
Mb;bO_7PQMX03\3Tf/RH6A;<?8,[QET;(AfI]8Xe48RgT^AIRCRO=3NFYQ2WOc>6
>cF]<X3/cSB&SP_Z^1M_.3U=5Ce#Q<\TM=H0[&?N)]\KYJ=MGB_:Q<^TEf=GP>\Q
+d:7VfVBUUc0IUTCdAPW2,eMGC#VS#a0A++_SU_.f0HJ8?ga;HHSP_:<QG0AZ<5-
Afe.L1cg8<Nb)P]/?Y<];b>=[-NX,<f\KP;JB[KTW4F_4fQ(G[e[PY+b&@e:-@GG
7S.C^>X-OdO_8CBYGc7HbMEW8+Y]Y^=Z5+/F?e&fVZ4<:N+b[<f4fd2&]1.Y3GFL
bMV,LEbLbd_^bd/<@QU.aO7;=#S:7=gPf4(1(H=;T<Abg@#3a6S97./J1N4/J1]a
=3.;d8A,_eJ&67Ff)J>4>][]8eSfC<LIc\ed,eGOcHQZ_<aZ0,3ZQbI(#dFbX^QB
H+fG.^<[WH]d)&:2K4>^(:X.b1H#EgC/WAJ+[>7.2>ec<S0aI7N6<D30]7#NNW>S
e<K@TE;d)#_I^(g,?P6&eGS8_3#bS4<c2CW<PM1F^(LcC$
`endprotected


`endif

