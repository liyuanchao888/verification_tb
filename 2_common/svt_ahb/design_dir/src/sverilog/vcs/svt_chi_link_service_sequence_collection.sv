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

`ifndef GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV
//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_LINK_SVC_BASE CHI Link service transaction base sequence
 * Base sequence for all CHI link service transaction sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/** 
 * @grouphdr sequences CHI_LINK_SVC CHI Link service transaction sequences
 * CHI Link service transaction sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
/** 
 * @groupname CHI_LINK_SVC_BASE
 * svt_chi_link_service_base_sequence: This is the base class for
 * svt_chi_link_service based sequences. All other svt_chi_link_service
 * sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or
 * sequence clients set the #manage_objection bit to 1.
 */
class svt_chi_link_service_base_sequence extends svt_sequence#(svt_chi_link_service);

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length = 5;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_link_service_base_sequence) 

  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_link_service_sequencer) 

  /** Node configuration obtained from the sequencer */
  svt_chi_node_configuration node_cfg;

  /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

  /**
   * SN Agent virtual sequencer
   */
  svt_chi_sn_virtual_sequencer sn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /** 
   * Weight that controls generating Link activation, deactivation service requests.
   * Enabled by default. 
   */
  int unsigned LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;

  /** 
   * Weight that controls generating Link activation, deactivation service requests.
   * Disabled by default.
   */
  int unsigned LCRD_SUSPEND_RESUME_SERVICE_wt = 0;

  /**
   * Config DB get status forLINK_ACTIVATE_DEACTIVATE_SERVICE_wt 
   */  
  bit link_activate_deactivate_service_wt_status = 0;

  /**
   * Config DB get status for LCRD_SUSPEND_RESUME_SERVICE_wt
   */
  bit lcrd_suspend_resume_service_wt_status = 0;

  /** Config DB get status for sequence_length */
  bit seq_len_status;

  /** Config DB get status for min_post_send_service_request_halt_cycles */
  bit min_post_send_service_request_halt_cycles_status;

  /** Config DB get status for max_post_send_service_request_halt_cycles */
  bit max_post_send_service_request_halt_cycles_status;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_default_sequence_length {
    sequence_length > 0;
    sequence_length <= 5;
  }

  /** 
   * Indicates minimum number of clock cycles the sequence has to halt after issuing a link service request. <br>
   * Default value is zero. <br>
   * Based on the requirement should be set to appropriate value, because the random link service sequence will wait for a delay picked randomly in the range #min_post_send_service_request_halt_cycles and #max_post_send_service_request_halt_cycles between sending two random link service requests. <br>
   * Can be programmed using config DB. 
   */
  int unsigned min_post_send_service_request_halt_cycles = 0;

  /** 
   * Indicates maximum number of clock cycles the sequence has to halt after issuing a link service request. <br>
   * Default value is zero. <br>
   * Based on the requirement should be set to appropriate value, because the random link service sequence will wait for a delay picked randomly in the range #min_post_send_service_request_halt_cycles and #max_post_send_service_request_halt_cycles between sending two random link service requests. <br>
   * Can be programmed using config DB.
   */
  int unsigned max_post_send_service_request_halt_cycles = 0;

  /** 
   * RN interface handle.
   */
  virtual svt_chi_rn_if rn_vif;

  /** 
   * SN interface handle.
   */
  virtual svt_chi_sn_if sn_vif;

  /** 
   * Constructs a new svt_chi_link_service_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_link_service_base_sequence");

  /**
   * Obtains the RN virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_rn_virt_seqr();

  /**
   * Obtains the SN virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_sn_virt_seqr();

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_virt_seqr();

  /**
   * Obtains the virtual interface handle from node configuration. 
   */
  extern function void get_virt_if();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** body method */
  extern virtual task body();

  /** Get the generic cfg DB settings */
  extern virtual task pre_start();

  /** is_supported implmentation, applicable for all the sequences */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

  /** Generate Link service sequence items */
  extern virtual task generate_service_requests();

  /** Post Generate Link service sequence items */
  extern virtual task post_generate_service_requests();

  /** Pre Create Link service sequence item */
  extern virtual task pre_create_service_request();

  /** Create Link service sequence item */
  extern virtual function svt_chi_link_service create_service_request();

  /** Post Create Link service sequence item */
  extern virtual task post_create_service_request(svt_chi_link_service link_service_req);
  
  /** Pre Randomize Link service sequence item */
  extern virtual task pre_randomize_service_request(svt_chi_link_service link_service_req);

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);

  /** Post Randomize Link service sequence item */
  extern virtual task post_randomize_service_request(svt_chi_link_service link_service_req, ref bit rand_success);
  
  /** Pre Send Link service sequence item */
  extern virtual task pre_send_service_request(svt_chi_link_service link_service_req);

  /** Send Link service sequence item */
  extern virtual task send_service_request(svt_chi_link_service link_service_req);

  /** Post Send Link service sequence item */
  extern virtual task post_send_service_request(svt_chi_link_service link_service_req);
  
endclass

// =============================================================================

`protected
W+f(JH6X:1GR-<5/MdMON>QNA:GXIaJ[Z+3NVHK;V;;;R61U/fcX5)G)&6CNB]X6
\Q9#N,0J9X4G=dB+#H]PUQdAEbP5c0&8cUFA>.UEPF4-<PXea0e0f8M3,TYB^aeF
>RU_C<#[I0SD36M^eKAX@a1gP4^W@E^EJH,?G#6gY/g;\b6Z&f),VG=:4]_81a-7
b@Lfd@I7_+fO9bgVgdgEK2WGF)A6=OA9UCb\NYII+MLSP=L_Nd<J[f@S<7.bFFAM
IdMFd6FE@?;J)?^-Z>5CN_N\H+Rcb1R]<$
`endprotected


//vcs_vip_protect
`protected
SQ[K9Dd]A.BA(LFdK_X+L)Ke#3(0Og0O,)>+,N2[K\#AU10SZEbN2(91f+/aV./D
^b2X277VS6^7IAA0g)GQGNA]CRE0<c;[5Sa.#d;I<aY&e73-+K9>S=YN/c;]9aJM
;f9W\/.ZLe&+WJOUcW&4#7&Z2ALWA;BI9aN0:/b^eL^aA-B)27@N<QO]0=LKU\99
+]2KY&<gc.N<8Me6B;dc7J0(FGZgZ4-GTTH#gN:J1DU@FX17\;8cYIOCcA-[NI,S
1ffB-0cc,+Q4;SR+IKd6NJUf<0:]+2[0fW7CN9LX3VBLfK3^+<DH[Q@V6E=T^Y=0
(d;K0G5>F##6?+0T;,D+@b9\b;]&SY6@VPE7e;</X.CJ5eBZE?;+eE87L,E3[NW3
cge7Gg<(PUd8b_@c3@CM6f76P?ZfPTBc/K]=<U>UGJY/aAXG8fX)b^]@G@32AJ8-
_/8\DR@c+>Q9_H3?bNJU]\aB/^VgH,]ZNN<VCDCgFAT;]:e+PS]6/]+Z\RPSHE0g
WR>-^,1<HSHN84Z2^<QDY(22ZfFObR+)K,JSH5EB\fP9#8WF&;^KA=DGd2&\YA/9
SZbNJRDc48T)::GWQEQ\D?)&Q,4R4155d\5UW\aQ?M;-9D7:aL#N=L5KTAbK)(.Y
I#V-+48A,PGW(&UN;8Ka@#cdW)9^((fN=d73]0SIF5-D;R=fZ;US.ILS,63,Y)E)
U8CAEVZRd@&FggdE(6X3@-gMe1X80HB(Pd[:4Q+MS0JVaDfd#Y(fR--b4ZF\VNEd
Fc5N1V1D3>8b1U7TP@J,X<5S,2_K0J:6].Gb5@=HM2\.[A1Fe<WXNBBa2K6[;0gE
f/-CbX<[ZN7-[[Oe#Z:&.H)X=RMFVPdbg;4ICANP4.\C4?0g>]D/1;?6L=:2Rg,V
]-cS3,C0.a>V5I;L0HUQ\MRB/K:X(e1_(8a1>GBcfSdTBSHBYHb=DgN(AIQ:2;.G
E?N+=?UJA)0bcQ[]73-#-,=G,UWA@CM6AK64@V\X@0BMUY]435ZMRdU]P+UD^+QJ
acUTVUe/LL,eL6/80>\COJR;dDF4NaFVC&3Z;O-Vg^Ag77:P@+@2I<6?9LLR+;/U
1]NX;#0C4CQeM9c_EK-d&2OJg/CIRfKFVg0AFPHNZK,e#>Hf3f5WSR[13T0DR8\0
+fJABZ2O6Z7(^O@b_A-[E4a.?VbBXB83OOUfK=8Z.=YVdN+LZ.506F>CY-G403G_
ddc[K(]AA?Y])2\,(?bMDIegST7:9>E,aK>&O?PTeM)G<_7b&/;4<=+)-=;dMP73
B6b&gT,ee&\EL>7\U-),+T/7]KU821Rf5,c5M4^CcP>](.0[6]^?[-[_gB@=/0\@
D(/=<\[a>.;RS;gC(D0?J/S&/V^:2-75-I@@HBH0=a[6[@^#X\Feg#cX7R(SL3B+
525V=[Q>-f4L5b1b/5b,[VfUJ<KM+]11K5aQHcZW>e+\HTKG1aNgSXG[(SP4)Q6A
=140\.A01NCEPe5,9+^JBSNQL5.IZaZWIQUX;Oe:_HIM[M,F<EW+gQgfP:.HIEUa
+:fYA7GSge0G=@VMMa;D^BL8N-O]-Pcb^ac,8S[?&@XFUO69HdZ3O>g^H62F7H\V
#+T\VLB]I@5?314Y>@G.@[OaG?13645H1L\HE;Vd4IEX3RNA(IQ5=)L2b1<TP6(V
19.V?T[D_E;b9+C3R,DI>R8c-YdDZBe(OC#4R)0^KdC00[:f#NTFgOQeGHC1Y<F(
\U0ZB?<H6@:JYc+QcTSI:e^c:?]\aF^HKAHa(P^aA3KJ8()?F=V=W>IZ;?X.8&ZE
K+(9ZGaf#CfIFFBRHgI31KgbgfYa>fLPK^-8;HOH0ebKg8_1^\ZbU(>,_V.f?P8W
E:Ea8e_J0FMA,@;?_2[&78G<cO^OE:D6FDH).+O@_R>Va@UcK>PO=5;fMB90AD^Y
gLd)Q6+GZ]=2:#X)&NQc.4))f=^fP?/AMg6DOPVV>0c,Z0#RZ5./KPBQ>K+.<U/Y
OHgCdFO2O;@-WeM]&_#9A/TK8K3gTe#??;6EAK.B?4+(D,8]RJK;@62CZP#3AcB4
4D:JS#5XfJ5.EfJ>Y]d(\?[A5c+F;\E3Z8L\_d(R)d_82C^7<2EQ,>@(P.-9Dd\W
O/Z7(b5QY@UaNgHbIcOK?>L_0B^K@,Y/d6=Sb9)0Lf?LXDHe#Y\NQY^c51(4A4OF
W&VZ^#ad;e>XWGS0^^HRT.6XS?JXdZ?ZD,?dV1@g<f/1^BIR2D<E1YQJZ>c3<eIT
)0?6CfCR\c396,;F.Yf];T>30Hg2D3CM-Te7UQN7Qg_C568J2:>(e)M9Q_+#\MS#
_1T-KXZ-4,E?V.N#[a^;S)AbF,ILe(U+^?PZAD=Q)B;6G8,5fHJGS9N.f27GW6SV
YcH3GTFDF=1KI-_4,<f.4N<#,VS>W74S3R7W&e<W@WKJMA\A-+U?eeD1f83E\a2)
#WR-fZFbU.=aMJg1HP>378SJ4^7=X3<[0M+,&+X+KTOe4QYSO/c\DT#XRS^9UM+4
Q=)3:Ze^(Ug&0(0CUIL]ZPbSg@Ia#QA;WRM8?0cJdd,f7Z/Ne^\3e@PR.,JJD)MT
5O:T6,:efdMZ8B70,D(P^/Vd^?4Bc0P+b:6R8\B-#g8O])^P+^Oacab/Y0XP@3eD
bAXL@K0ac1:U7f_,QOeJE>).cIC\?4:d8TQLE1QgQ^J5^C4DRY2OM3@\U3_DM=bZ
F&E>67</Q#OP2If3ZbUE:]Pf)TP2=>,9V/UDN&]QB\XYc&DW2U2]KgN,RE69W]H>
LQfQ,9eLT4SC13C9FcG7&XFP_KGY2(_4]V)XJXXRNg5.G\-R0&8F@O+>F=>\C(-6
/E?VVRB_QebfJT\&cKXZ(2[,AH_3W\S4K&E++FKJCZXTJ04_F-O1@5+TUK42&8Vg
cB7KEVSZYI(7->2BT]7=^O#e48T]9gd9,Z(0,_5IMC728dYVV_FV1Fe&ST?OCL_I
ACUWWRf1W.LbR2@<BcHFD^37DJN5eD8A&J8,L6_4E=D0C\NH.,Q2-AO&=-YIZcR7
58CY;K[R\W<T@;#_:Ecg3?4.P<_#&Kd@L5V-6ALKMd4MF\3,FBT\>E&^GI#a/5_T
QIb,PSNW&Q8+LcZaFL/L.bZ+=D?ZWWd7dVdP\?L>P(M-NbVcYJ)R)+Y>1LUL>Y.A
b)YcXRc]f.FS-UN/fHW/gZ2/<>P)0@QCGc<9=&5)eI4TH-R)GE_W57R/P&Lg6#.8
5WH)V4G9g8Qd1<__=R0GPc;<aCO[FFGKC=Z]#E]+G>27R]7)XA-e09f5SDZ^N3;G
KUc/1QS1,g;8Y\PP[@V0_W]b78;;BV_2PX6Of/b>JH<PdYQ^Q=U3SIUB8ACF.&9c
=a1\<ESJ##T,E]aT=IU)M=]VF[#PE:\fEg;O7[8;<CRJVDBW6\8QfaTGAV)Z8cB]
N7Md-Y)W-aJD,c\cc]CeE.C[YRMQa#G1^N?MFCE_C]JWN+UWV&J/(-H&.+_\<<NH
^G@c[Z/bHT-9GV-7-]4)O1<TE7aaK^dDYKI(V:efaC3fI9Hc7XWBgSNR_P]7#T)@
K_Agc^X<gK-_YN9[BIWLCD1AE7O377Xc=6@eZH.9PL2&DX(QaLYCbb2aEMZA7D9C
,D]8VFV05#JFIY5Na6&\U/R]Qae#D5F\#WWVJS:6+@#VeJMHMTHdTG1<TY::>=/I
48Z\#I,fgH(J^f3O4eOJ/gK\:RC(;Q=HWC(&1[1_G,WeD#8d+Y=/Jd0[;3;acL@&
(-IBSFBI10B],1WF0<?:2Z0c5F\:.@)Q.FYY]QM#;gP_5IN42<:.ED&^XZLOCS2/
>D.B+&G]Z[ET/FbNP=P#HMLGe9cA/5JLC8H45[UOUg-0cL([ZE3T(eB3.I(b=H8f
@T]F(69];g3#LDag5Sd>3=4G(eAe<K#<@1R/I/QGXD2<>&F.[<7a,]=ae[IW4+>9
6]ObA__dZKQJP86V>,IDBb6LI&QIMWPVg/H6aY)JHO2#&<Fb6OK8DG5B7&D[b@SZ
1eB8>fQe(J4I8T:]CSQ3QOLV&\LV1J=^Y2[5KXKQe@I;ESMFgE<3d,/I\2XWegJ3
fYbe#X1/BgHG5MM<:(-\PfUD^?-D;4J/D4AP3aL=,Wc0+OQg+34.T4P&fVI0V\P.
ZMBOQ:fI.5)@QB_F[H43:HY37dW7:PNJe4A>Z&6g8>+K5_I)8]Gd&gAU.FB_FK<V
;S\1(Fe_aXLVYeGC7b#J621\T31b)C3(@(3W2T3KXd,R2Ab:b2LT2GAL?KXf?K5g
7eZ_C_)UEYGSK1V;HU:3@[>[JR_B#>C>^@XU9(H4DGN3+K&.(.ZUc_7+HX-M5D;F
8G+/HV7FR1,#ED^b&3H--NJO]01?_XRVVPgE0:?1CgMTW/Xaf2=PC=A]-9=fR2O&
H1A+0f_MNJ]#,$
`endprotected


// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::body();
  svt_configuration cfg;
  bit silent = 0;
  if (p_sequencer == null) begin
    `uvm_fatal("body", "Sequence is not running on a sequencer")
  end

  /** Obtain a handle to the rn node configuration */
  p_sequencer.get_cfg(cfg);
  if (cfg == null || !$cast(node_cfg, cfg)) begin
    `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
  end

  //  check if it's valid to run this sequence or not
  if(!is_supported(cfg, silent))  begin
    `svt_xvm_note("body",$sformatf("This sequence cannot be run. Exiting..."))
    return;
  end    

  //Obtains the virtual sequencer from the configuration database and sets up
  //the shared resources obtained from it.
  get_virt_seqr();

  //Get RN/SN interface handle from node configuration.
  get_virt_if();

endtask

// -----------------------------------------------------------------------------
/** Get the generic cfg DB settings */
task svt_chi_link_service_base_sequence::pre_start();
  string method_name = "pre_start";
  
  super.pre_start();
  
`ifdef SVT_UVM_TECHNOLOGY
  link_activate_deactivate_service_wt_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "LINK_ACTIVATE_DEACTIVATE_SERVICE_wt", LINK_ACTIVATE_DEACTIVATE_SERVICE_wt);
`else
  link_activate_deactivate_service_wt_status = m_sequencer.get_config_int({get_type_name(), ".LINK_ACTIVATE_DEACTIVATE_SERVICE_wt"}, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt);
`endif
  `svt_xvm_debug(method_name, $sformatf("link_activate_deactivate_service_wt_status is %0d as a result of %0s.", LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, link_activate_deactivate_service_wt_status ? "the config DB" : "the default value"));    

`ifdef SVT_UVM_TECHNOLOGY
  lcrd_suspend_resume_service_wt_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "LCRD_SUSPEND_RESUME_SERVICE_wt", LCRD_SUSPEND_RESUME_SERVICE_wt);
`else
  lcrd_suspend_resume_service_wt_status = m_sequencer.get_config_int({get_type_name(), ".LCRD_SUSPEND_RESUME_SERVICE_wt"}, LCRD_SUSPEND_RESUME_SERVICE_wt);
`endif
  `svt_xvm_debug(method_name, $sformatf("link_activate_deactivate_service_wt_status is %0d as a result of %0s.", LCRD_SUSPEND_RESUME_SERVICE_wt, lcrd_suspend_resume_service_wt_status ? "the config DB" : "the default value"));

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug(method_name, $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));

`ifdef SVT_UVM_TECHNOLOGY
  min_post_send_service_request_halt_cycles_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "min_post_send_service_request_halt_cycles", min_post_send_service_request_halt_cycles);
  max_post_send_service_request_halt_cycles_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "max_post_send_service_request_halt_cycles", max_post_send_service_request_halt_cycles);
`else
  min_post_send_service_request_halt_cycles_status = m_sequencer.get_config_int({get_type_name(), ".min_post_send_service_request_halt_cycles"}, min_post_send_service_request_halt_cycles);
  max_post_send_service_request_halt_cycles_status = m_sequencer.get_config_int({get_type_name(), ".max_post_send_service_request_halt_cycles"}, max_post_send_service_request_halt_cycles);
`endif
  `svt_xvm_debug(method_name, $sformatf("min_post_send_service_request_halt_cycles is %0d as a result of %0s. max_post_send_service_request_halt_cycles is %0d as a result of %0s.", min_post_send_service_request_halt_cycles, min_post_send_service_request_halt_cycles_status ? "the config DB" : "the default value", max_post_send_service_request_halt_cycles, max_post_send_service_request_halt_cycles_status ? "the config DB" : "the default value"));
  
endtask // pre_start

// -----------------------------------------------------------------------------
/** is_supported implmentation, applicable for all the sequences */
function bit svt_chi_link_service_base_sequence::is_supported(svt_configuration cfg, bit silent = 0);
  string method_name = "is_supported";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  is_supported = 1;

  if ((LINK_ACTIVATE_DEACTIVATE_SERVICE_wt == 0) && (LCRD_SUSPEND_RESUME_SERVICE_wt == 0)) begin
    is_supported = 0;
    `svt_xvm_error(method_name,$sformatf("This sequence cannot be run as both LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, LCRD_SUSPEND_RESUME_SERVICE_wt are set to 0. Adjust these weight attributes appropriately, for example: LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100, LCRD_SUSPEND_RESUME_SERVICE_wt = 0."));
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));
endfunction // is_supported

// -----------------------------------------------------------------------------
function svt_chi_link_service svt_chi_link_service_base_sequence::create_service_request();
  svt_chi_link_service link_service_req;
  //`svt_xvm_create_on(link_service_req, p_sequencer)
  `svt_xvm_create(link_service_req)
  link_service_req.cfg = node_cfg;
  link_service_req.LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = LINK_ACTIVATE_DEACTIVATE_SERVICE_wt;
  link_service_req.LCRD_SUSPEND_RESUME_SERVICE_wt = LCRD_SUSPEND_RESUME_SERVICE_wt;

  create_service_request = link_service_req;
endfunction // create_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name, "Entering ...");
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize();
  end
  `svt_xvm_debug(method_name, "Exiting ...");
endtask

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::send_service_request(svt_chi_link_service link_service_req);
  string method_name = "send_service_request";
  `svt_xvm_debug(method_name, "Entering ...");
  `svt_xvm_send(link_service_req);
  `svt_xvm_debug(method_name, "Exiting ...");
endtask // send_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::generate_service_requests();
  string method_name = "generate_service_requests";
  bit    rand_success;
  `svt_xvm_debug(method_name, $sformatf("Entering - sequence_length = %0d, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = %0d, LCRD_SUSPEND_RESUME_SERVICE_wt = %0d", sequence_length, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, LCRD_SUSPEND_RESUME_SERVICE_wt));
  sink_responses();
  for (int i =0; i < sequence_length; i++) begin
    svt_chi_link_service link_service_req;
    
    pre_create_service_request();
    link_service_req = create_service_request();
    post_create_service_request(link_service_req);
    
    if (link_service_req == null) begin
      `svt_xvm_fatal(method_name, $sformatf("Unable to create link_service_req the iteration %0d", i));
    end
    else begin
      `svt_xvm_debug(method_name, $sformatf("Invoking randomize_service_request for the iteration %0d", i));
    end
    
    pre_randomize_service_request(link_service_req);
    randomize_service_request(link_service_req, rand_success);
    post_randomize_service_request(link_service_req, rand_success);
    
    if (!rand_success) begin
      `svt_xvm_error(method_name,$sformatf("randomize_service_request() indicates Randomization failure for the iteration %0d", i));
    end
    else begin
      `svt_xvm_debug(method_name,$psprintf("randomize_service_request() generated transaction for the iteration %0d: %0s", i, link_service_req.sprint()));
      pre_send_service_request(link_service_req);
      send_service_request(link_service_req);
      post_send_service_request(link_service_req);
    end
  end
  //After the sequence_length number of serive requests are issued, this task will check if any RX VC's are in suspend lcrd state, if yes, a RESUME_ALL_LCRD service request is issued to avoid any deadlocks.
  post_generate_service_requests();
  `svt_xvm_debug(method_name, "Exiting ...");
endtask // generate_service_requests

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_generate_service_requests();
   string method_name = "post_generate_service_requests";
   if (shared_status != null && shared_status.link_status != null) begin
     if(shared_status.link_status.snp_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED || shared_status.link_status.rsp_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED || shared_status.link_status.dat_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED) begin
       bit rand_success;
       svt_chi_link_service link_service_req;
       link_service_req = create_service_request();
       //As this service request is auto generated overriding the weights.
       link_service_req.LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 0;
       link_service_req.LCRD_SUSPEND_RESUME_SERVICE_wt = 100;

       if (link_service_req == null) begin
         `svt_xvm_fatal(method_name, $sformatf("Unable to create link_service_req in post_generate_service_requests()"));
       end
       
       rand_success = link_service_req.randomize() with { 
                                                         service_type == svt_chi_link_service::RESUME_ALL_LCRD;
                                                        };
       
       if (!rand_success) begin
         `svt_xvm_error(method_name,$sformatf("link_service_req.randomize() Randomization failure in post_generate_service_requests()"));
       end
       else begin
         `svt_xvm_debug(method_name,$psprintf("link_service_req transaction generated in  post_generate_service_requests() with service type %0s: %0s ", link_service_req.service_type, link_service_req.sprint()));
         pre_send_service_request(link_service_req);
         send_service_request(link_service_req);
         post_send_service_request(link_service_req);
       end
     end
   end
endtask // post_generate_service_requests

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_create_service_request();
endtask // pre_create_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_create_service_request(svt_chi_link_service link_service_req);
endtask // post_create_service_request

//------------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_randomize_service_request(svt_chi_link_service link_service_req);
endtask // pre_randomize_service_request

//------------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_randomize_service_request(svt_chi_link_service link_service_req, ref bit rand_success);
endtask // post_randomize_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_send_service_request(svt_chi_link_service link_service_req);
endtask // pre_send_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_send_service_request(svt_chi_link_service link_service_req);
  int unsigned num_post_send_service_request_halt_cycles = $urandom_range(max_post_send_service_request_halt_cycles, min_post_send_service_request_halt_cycles);
  if (rn_vif != null && node_cfg.chi_node_type == svt_chi_node_configuration::RN) begin
    if (num_post_send_service_request_halt_cycles > 0)
      repeat(num_post_send_service_request_halt_cycles) @(rn_vif.rn_cb);
  end
  else if (sn_vif != null && node_cfg.chi_node_type == svt_chi_node_configuration::SN) begin
    if (num_post_send_service_request_halt_cycles > 0)
      repeat(num_post_send_service_request_halt_cycles) @(sn_vif.sn_cb);
  end
endtask // post_send_service_request

// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_random_sequence
 *
 * This sequence creates a random svt_chi_link_service request.
 */
class svt_chi_link_service_random_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_link_service_random_sequence) 

  /**
   * Constructs the svt_chi_link_service_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_random_sequence");

  /** 
   * Executes the svt_chi_link_service_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_random_sequence::new(string name = "svt_chi_link_service_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_random_sequence::body();
  
  super.body();

  generate_service_requests();

endtask: body


// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_deactivate_sequence
 *
 * This sequence creates a deactivate svt_chi_link_service request.
 */
class svt_chi_link_service_deactivate_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_link_service_deactivate_sequence) 

  bit seq_allow_act_in_tx_stop_rx_deact = 0;

  bit seq_allow_deact_in_tx_run_rx_act = 0;

  /** Controls the number of cycles that the sequence will be in the deactive state */
  rand int unsigned min_cycles_in_deactive = 50;

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /** Constrain the number of cycles that the sequence will be in the deactive state */
  constraint reasonable_min_cycles_in_deactive {
    min_cycles_in_deactive inside {[0:`SVT_CHI_MAX_MIN_CYCLES_IN_DEACTIVE]};
  }

  /**
   * Constructs the svt_chi_link_service_deactivate_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_deactivate_sequence");

  /** 
   * Executes the svt_chi_link_service_deactivate_sequence sequence. 
   */
  extern virtual task body();

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  
endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_deactivate_sequence::new(string name = "svt_chi_link_service_deactivate_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_deactivate_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize() with { 
                                                       service_type == svt_chi_link_service::DEACTIVATE;
                                                       min_cycles_in_deactive == local::min_cycles_in_deactive;
                                                       if(seq_allow_deact_in_tx_run_rx_act) {
                                                         allow_deact_in_tx_run_rx_act==seq_allow_deact_in_tx_run_rx_act;
                                                       } else {
                                                           allow_deact_in_tx_run_rx_act==0;
                                                       }
                                                       if(seq_allow_act_in_tx_stop_rx_deact) {
                                                           allow_act_in_tx_stop_rx_deact==seq_allow_act_in_tx_stop_rx_deact;
                                                       } else {
                                                           allow_act_in_tx_stop_rx_deact==0;
                                                       }
                                                      };
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));  
endtask
//------------------------------------------------------------------------------
task svt_chi_link_service_deactivate_sequence::body();
  int min_cycles_in_deactive_status;

  LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;
  LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  super.body();
  
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  min_cycles_in_deactive_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "min_cycles_in_deactive", min_cycles_in_deactive);
`else
  min_cycles_in_deactive_status   = m_sequencer.get_config_int({get_type_name(), ".min_cycles_in_deactive"}, min_cycles_in_deactive);
`endif
  `svt_xvm_debug("body", $sformatf("min_cycles_in_deactive is %0d as a result of %0s.", min_cycles_in_deactive, min_cycles_in_deactive_status ? "the config DB" : "randomization"));

  generate_service_requests();

endtask: body

// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_active_sequence
 *
 * This sequence creates an activate svt_chi_link_service request.
 */
class svt_chi_link_service_activate_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_link_service_activate_sequence) 

  bit seq_allow_act_in_tx_stop_rx_deact = 0;

  bit seq_allow_deact_in_tx_run_rx_act = 0;

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_link_service_active_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_activate_sequence");

  /** 
   * Executes the svt_chi_link_service_active_sequence sequence. 
   */
  extern virtual task body();

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  
endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_activate_sequence::new(string name = "svt_chi_link_service_activate_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_activate_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize() with { 
                                                       service_type == svt_chi_link_service::ACTIVATE;
                                                       if(seq_allow_deact_in_tx_run_rx_act) {
                                                           allow_deact_in_tx_run_rx_act==seq_allow_deact_in_tx_run_rx_act;
                                                       } else {
                                                           allow_deact_in_tx_run_rx_act==0;
                                                       }
                                                       if(seq_allow_act_in_tx_stop_rx_deact) {
                                                           allow_act_in_tx_stop_rx_deact==seq_allow_act_in_tx_stop_rx_deact;
                                                       } else {
                                                           allow_act_in_tx_stop_rx_deact==0;
                                                       }
                                                      };
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));  
endtask
//------------------------------------------------------------------------------
task svt_chi_link_service_activate_sequence::body();
  int min_cycles_in_deactive_status;
  
  LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;
  LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  super.body();

  generate_service_requests();
  
endtask: body

`endif // GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV







  



