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

`ifndef GUARD_SVT_CHI_LINK_RXLA_FSM_SV
`define GUARD_SVT_CHI_LINK_RXLA_FSM_SV

typedef class svt_chi_link_rxla_fsm;
// typedef class svt_chi_link_rxla_fsm_def_cov_data_callback;

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_STOP state.
 */
class svt_chi_link_rxla_stop_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Stop");
  `svt_fsm_state_utils(svt_chi_link_rxla_stop_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_deactivate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_deactivate_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_STOP_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_STOP state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the RXLA_STOP state, the receiver can neither transmit L-credits nor receive flits.
    p_fsm.common.rxla_can_xmit_lcrds = 0;
    p_fsm.common.rxla_can_xmit_snp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_dat_lcrds = 0;
    p_fsm.common.rxla_can_receive_flits = 0;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_stop;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_stop_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_ACTIVATE state.
 */
class svt_chi_link_rxla_activate_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Activate");
  `svt_fsm_state_utils(svt_chi_link_rxla_activate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_stop_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_stop_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_ACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_ACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    // In the RXLA_ACTIVATE state, the receiver can neither transmit L-credits nor receive flits.
    p_fsm.common.rxla_can_xmit_lcrds = 0;
    p_fsm.common.rxla_can_xmit_snp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = 0;
    p_fsm.common.rxla_can_xmit_dat_lcrds = 0;
    p_fsm.common.rxla_can_receive_flits = 0;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_activate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_activate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_RUN state.
 */
class svt_chi_link_rxla_run_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Run");
  `svt_fsm_state_utils(svt_chi_link_rxla_run_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_activate_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;

    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_activate_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_RUN_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_RUN state.");
 
    // Records the simulation time when the RXLA state machine transitions to RXLA_RUN state.
    p_fsm.common.shared_status.rxla_run_state_time = $realtime;
    
    // In the RXLA_RUN state, the receiver can transmit L-credits and receive flits.
    fork
      p_fsm.common.rxla_can_xmit_lcrds = 1;
      if(p_fsm.common.cfg.stop_snp_lcrd_xmission_when_txla_not_in_run_state == 0)
        p_fsm.common.rxla_can_xmit_snp_lcrds = 1;
      p_fsm.common.rxla_can_xmit_rsp_lcrds = 1;
      p_fsm.common.rxla_can_xmit_dat_lcrds = 1;
      p_fsm.common.rxla_can_receive_flits = 1;
    join
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_run;    
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_run_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine RXLA_DEACTIVATE state.
 */
class svt_chi_link_rxla_deactivate_state extends svt_fsm_state#(svt_chi_link_rxla_fsm, "Deactivate");
  `svt_fsm_state_utils(svt_chi_link_rxla_deactivate_state)

  /** Define the 'from' states. */
  `svt_fsm_from_states('{p_fsm.rxla_run_state})

  /** Watch for the action that initiates a transition into the state. */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    ok = 1;
    
    if (p_fsm.common == null)
      begin
        `svt_error("state_transition", "Link common is null.");
        ok = 0;
      end
    else if (from_state == p_fsm.rxla_run_state)
      begin
        p_fsm.common.rxla_state_transition(p_fsm.fsm_state_to_rxla_state(from_state), 
                                           svt_chi_link_common::RXLA_DEACTIVATE_STATE, ok);
      end
    else
      begin
        `svt_error("state_transition", $sformatf("Called for an unsupported from_state, %0s. Ignoring.", from_state.get_name()));
        ok = 0;
      end

    if (ok)
      begin
        // Store away the previous state.
        p_fsm.prev_state = from_state;
      end 
  endtask

  /** Implementation of the state action. */
  virtual task body();
    //`svt_debug("body","The RXLA state machine is in the RXLA_DEACTIVATE state.");
    
    // The link is only active when both the TX and RX state machines are in the RUN state.
    p_fsm.common.shared_status.is_link_active = 0;
    
    case(p_fsm.common.cfg.chi_node_type)
      svt_chi_node_configuration::RN : begin
        case(p_fsm.common.cfg.chi_interface_type)
          svt_chi_node_configuration::RN_F, svt_chi_node_configuration::RN_D: begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxsnp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state;
          end
          svt_chi_node_configuration::RN_I : begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
        endcase
      end
      svt_chi_node_configuration::SN : begin
        p_fsm.common.shared_status.link_status.num_rxreq_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxreq_vc_lcredits_in_rxdeactivate_state;
        p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
      end
      svt_chi_node_configuration::HN : begin
        case(p_fsm.common.cfg.chi_interface_type)
          svt_chi_node_configuration::RN_F, svt_chi_node_configuration::RN_D, svt_chi_node_configuration::RN_I: begin
            p_fsm.common.shared_status.link_status.num_rxreq_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxreq_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
          svt_chi_node_configuration::SN_F, svt_chi_node_configuration::SN_I : begin
            p_fsm.common.shared_status.link_status.num_rxrsp_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state;
            p_fsm.common.shared_status.link_status.num_rxdat_vc_lcredits_to_be_xmitted_in_rx_deactivate_state = p_fsm.common.cfg.num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state;
          end
        endcase
      end
    endcase
    
    // In the RXLA_DEACTIVATE state, the receiver cannot transmit L-credits but can receive flits.
    // However, it's permitted to send L-Credits but receiver must stop sending during this state.
    // In case of passive monitor, this should be always expected.
    // For active mode driver to allow this, it's required to add a configuration under which the
    // driver is going to send out a specified number of L-Credits (as configured through a parameter).
    p_fsm.common.rxla_can_xmit_lcrds = p_fsm.common.cfg.rxla_can_xmit_lcrds_during_deactivate_state();
    p_fsm.common.rxla_can_xmit_snp_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    p_fsm.common.rxla_can_xmit_rsp_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    p_fsm.common.rxla_can_xmit_dat_lcrds = p_fsm.common.rxla_can_xmit_lcrds;
    
    p_fsm.common.rxla_can_receive_flits = 1;
  
    p_fsm.set_rxla_state(this);
    -> p_fsm.state_changed;
    -> p_fsm.entered_deactivate;
  endtask
  
  /** Return the name to use to represent the state's object type in the XML output. */
  virtual function string get_xml_name();
    return "svt_chi_link_fsm_deactivate_state";
  endfunction

endclass

// =============================================================================
/**
 * Class implementing the RXLA state machine.
 */
 
// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_typedef_cb(svt_chi_link_rxla_fsm,svt_chi_link_rxla_fsm_def_cov_data_callback,svt_chi_link_rxla_fsm_def_cov_data_callback_pool);
// `endif

class svt_chi_link_rxla_fsm extends svt_fsm;

  `svt_fsm_utils(svt_chi_link_rxla_fsm)

// `ifndef SVT_VMM_TECHNOLOGY
//   `svt_xvm_register_cb(svt_chi_link_rxla_fsm, svt_chi_link_rxla_fsm_def_cov_data_callback)
// `endif

  /** The state base class implementing the RXLA_STOP state. */
  svt_fsm_state_base rxla_stop_state;

  /** The state base class implementing the RXLA_ACTIVATE state. */
  svt_fsm_state_base rxla_activate_state;

  /** The state base class implementing the RXLA_RUN state. */
  svt_fsm_state_base rxla_run_state;

  /** The state base class implementing the RXLA_DEACTIVATE state. */
  svt_fsm_state_base rxla_deactivate_state;

  /** Used to track the previous state. */
  svt_fsm_state_base prev_state = null;
   
  /** An event that gets triggered which the state changes. */
  event state_changed;

  /** Events per state to indicate a given state is entered. */
  event entered_stop, entered_deactivate, entered_activate, entered_run;
  
  /** Shared status object which is used to convey the current state to the outside world. */
  svt_chi_status shared_status;

  /** Link common handle */
  svt_chi_link_common common;

  //----------------------------------------------------------------------------
  /**
   * Constructor
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_chi_link_rxla_fsm");
`else
  extern function new(string name = "svt_chi_link_rxla_fsm", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method creates the FSM states and sets up special states (e.g., start).
   */
  extern virtual function void build();

  //----------------------------------------------------------------------------
  /**
   * Utility method for updating the FSM state in the shared status.
   */
  extern virtual function void set_rxla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the FSM state into the corresponding RXLA state.
   */
  extern virtual function svt_chi_link_common::rxla_state_enum fsm_state_to_rxla_state(svt_fsm_state_base fsm_state);

  //----------------------------------------------------------------------------
  /**
   * Utility method for converting the RXLA state into the corresponding FSM state.
   */
  extern virtual function svt_fsm_state_base rxla_state_to_fsm_state(svt_chi_link_common::rxla_state_enum rxla_state);

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided state can be reached directly from the
   * current state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  extern virtual function bit is_viable_next_rxla_state(svt_chi_link_common::rxla_state_enum test_next);

  // ---------------------------------------------------------------------------
  /**
   * Returns the name to be used to represent the state's object channel in the XML
   * output generated for use with PA.
   *
   * @return The channel name to be used for the state in XML output.
   */
  extern virtual function string get_xml_name();

`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Returns the name to be used to represent the state's object channel
   *
   * @return The channel name to be used for the state.
   */
    extern virtual function string get_name();
`endif
  // ---------------------------------------------------------------------------
  /** Must be implemented if a reset state is defined.
   *  Automatically invoked by the run() task of svt_fsm class.
   *  It must return only once the reset condition has been detected.
   *  The implementation must not call super.wait_for_reset().
   */
    extern protected virtual task wait_for_reset();

endclass

// =============================================================================

`protected
E-&8YON?JaZ9Pb-)792[0VR[34>ed7\.a#)7?ZIEX+IeC)FWSSbE7)>PV>N[K2=D
837eOT)L;R4GC:)07[E[/I84C:&63^OZa@DT^b,_#9JX/EPFW4QVTf])Eb?[ZS1Q
8N2:a6P[]DW[S]cTV(<.E>0LJ/4D7N?-SKUc&=Y^E1NbP3)NaKJEF7I+D,EXZ#8I
GbCJ]Na&Z]cIID&A,V^aLBD)2.KKUL7U1fc(?.>\.>8AeDAXHg:,X)RH^P1S?Ta;
Z-+<<E3DNU?92SA=RCO7X:,DMBOMB07VD8VRVFYCF)IMGSLJH;ZD@e3PRN+O;5MO
/UJ7484.K+d\9FR]ASCgMf:4W/)+H2Fd;I.X.MKdIZb@aGc(>8fX@X.9W>>W8;c8
UPd);]gOXA7^5[Qg#7/#1Q\K;::L[:C5]R<_aI39XQ&53P&R;]Q4\5\=7>bYH=a3
DNA&HX^ZHEA^0$
`endprotected


//vcs_lic_vip_protect
  `protected
c67bS-&FUE9PU4A0[QE5CXa_&Df=]g<SEOQ:7BZN@^H1V&6=-&H]&(X\cd@98212
BY8[:eJ\dT54S8.f/Y_J0)AB:;RJM.Ef_<GI9T26WEJ2)cES(.6P0LKF5/V+CHP#
(LH3BAg(J<OS;8?HeSZ7RN,8^Z5f-H2d\0^H4TIR#R#6=T]#]@a0e(-MW6@C15\6
gM]192bUDNSVY=YN@_H5VR9RVZf2<X=G[,L_2=JgNM/6S+RYHS9C+]MdYGF@d.&V
&1Ha&?Y_b.S&NgV363\^@a87[-ARIN?gYF[)AdDNN/IM#OXKW@^;\N_+_f#5?+T[
,BFaDd=T3aLU1;ZJ<D3ggZf\DD9S/C]E\bbH.RIME&<LNNE\dA21V]O1O1H3WIJ\
#<W/FRae36.eOPM/+23SITe0\EH4S8[Ia6XgLWbD)>H3[9fC@W8eS9H\)K-dV7.e
)L)I3c;_;-22F0Yca@cfVFb59L#)cS/R3aVU/Wa^gTK\XC0>&5g<\KBcd]/URSUW
9F_G;[#ZM^:+2#1AQHI+V)K5I;P396c&\H)1JId&\=+\25R@7^^L@:-b\C@?9V&F
AE\T&.D0#I2NPR):L.E1_/b8VR4LbdXAgF./K-G11f\P<I)X^+G)ILY7E[cd.<Qf
::F5E^fR.0.B)REL<[6:VTXc(4a#/1>)O.=NQ06_7K>@fA4+WTJ?##R>?gCE/Y[M
4RF@Bc/QT3RGU:G=\BE_=dJH&9Y-#QDa0,4f9^;Cd:)-?Ke[a4#2JSeS[C:=W85J
e(;aR3QI8Za8J3<e_+KQZ51V:M--<IGRJST2b2Ef3KMO+26])UZEN2>_MU\g^I6d
UFa<e#^NR],a=<PR^Q=9J>VZN&[J1?T>)Z#O,\>Fc;,TT<[C[X6H@b7Z=::cg2\S
8(XU2BV4]<\HLee0TMe,5W#WQdO]9[eS6HBT:BRZ4J#^/?]5[^G6UG^EgWWE1_0d
R_0,/E[Y\,<3cKBa7(]T37e8DJX8#BB^?(850IOV<HeUTd82g]fF,D\3&)0Oa6>@
DI,8>J(d\_]F6AGE+4<(V9]bE\O@3K9&F82(M\=O=X_dQ.AcDA:1ZHc(8.PI;[^8
?HVCUZ:WV:,A&.6U,]GY<,?I.9WNH:IBPP2(fbcFUaW;E-=SF@M-GC#XE>;04OWQ
D797d(\&KC]BA&-g9@L)(Z02AgE#H3-B;7T_\g,-:Z_\YI#/XRT^N3/B_C@R.dD8
G^S6#TLG4I1N/]P1A+1273#I=->2H\9.Q3OH[9f16NW86G)f;N17[9T#;>?g;Xb&
J07:_RKG1KNf^g^&9X:\5](E:NA5[]g;?O1R3.8;R8_;2X=^eJCZa;Cd&R,[2G.;
3Ie2PM^YAK;&cb2dVD3#PgD^2@WI?V4Gb5<90Q\<\<Ae;FF_e@>ZU6S6HRGP3(M-
#+bF:HQKN3@_]KX<XOW_IG]C7D+fA=SQY1@g_AU?&:&FeVTJ,6c.,YB9AC.4]SW8
VNSN?@JIRGL_/$
`endprotected
    
`protected
#NY0YF/9:TO,Q9K_8#AM@e(3^Y6V[5+E5&g^E:0g?DE+6e-HWVIF3)XYR#O1XDM1
:Be8=gQE91Xf/3gYPdbK8UeKGM\_-2Ca#,\6C;S0G#/]_/b>c)Y-EfSI@Pg6c89@
e=]YIMEfHg>VRf@+EAe:Z#X9@-Qb7H#K,M?@G,H67&,]H$
`endprotected


//vcs_lic_vip_protect
  `protected
.+:c_4\>]g>A@P\J@N7SP0Z2d4WQ)CZAT3Q),=.M6FL/VVG.AW4J0(B[g.g&;Y0\
-^H[OZ^;(,N0NJ27Q\DXb\72[d,^WdP@3JWQb,YZ(MI,-VFR3/9US78J@L0+]69>
JBP1[<_C]AKA2F4fNFV=c.<_N;M,cO;4SPU4\WFgBMIf&K<:P_VB@bgd1S\^D=S0
9+AX)7C6(N,E+_,XD#T]^-6GTB1D^SOQ\L1DH.?^&;#9GfEGP4SVGDI[NFF^?R+J
IE1>L]ZRgL:D=,:WCC5R&)LgOd9bLH\;KFB:>7>81]N6741#KRY^+cVBSC]fLFHM
Gc9J(,X.O-W@Ya(\=:.]Ee<:cBJFV^fB#VM;g4fNOEKB8<J2A#cNVU,@7.a4SYgN
)OVOWOZgZ,.43-@\:fZ_Q=]J5BM.Zf<6=c0HSgY,FRLbCGX\NX,PZ9FCXNKR8aO\
N1^RK8#BMR\cQJa\;,X]=XE7K/(g1gc7b)H9GO(?-,8JP(DY]JVVbc?-gNegIMIR
P.e&2E/Y>@&;HOLZA)b_J^2?D&D-:>a75aK6@#&-(U&4SHG=>=]2NOZf/#,@dK&K
fd/><eQ]&1F@^Q4;EYB^^3g5(,.SUDUNe<([\/g\1A?(C]WQcB=)M>)CTbeUR]M.
ADd#7G<?>XHG(-?J6Dd^;#3NfKOAEb>656@]B,bDYQFa@DKd79EbeN]cRGG,__7#
I0g=:S3(C:gM\34Q\(#(C9H=:+fT)(<(5K\\1EPDGJ8IV56Ec-M+AM,CEbR@f/FV
AX>5T3(?f>7V=W/#.?9:adLGe)YCVFI@3D5V&_CC-7;:@(Y(Z#0[Y0;M_5RZACKB
WA]Z))gfHJaAg>>I=B#7.5ceOdBSdWHT@XIS;/_<;<]4QP?b+SP7_METL9\3-cMC
H[Ig>&>H@Wd]I]fSKcUD3;<Y4\>d4&JV+LN,a;g6]-cH#\=H9<VFJGV2MKL8fGfM
(818?cVTB;2U?4Qd:6WE(SNVEOZR)J,\f\[^cXceS(SNEWGfKAMTNMU,2>P5NI2f
6D+OcH/@F<G9O6II0>R=DSWPg,82g(2fe@?OLQ(,g=I;Qe)+JY91:_DCcNH>[4<X
0WDJ+3U8I>LHKM:S_0V(RJG]J1;MEI>,2=ED\eS=1:_cU>cN)^>QHKeg9db8:3^+
R&66\HDHFd-[ZRTgCIeA=[4T#;?7W[F4JcY>0aa?6WXSF;WG6\N?#QD5eNX9^:&I
2IKRX2U\a4J]\X8=20P>Se:5YAOI[BH0=V-[#c[)cW-]6VQ+#EZ9Zb8dPIQ\NDMc
KK[M1aeJO5eQ=K.3c19\G=)3\KWYPK1U?RbS[La@>G/eMf,/K8Fg[;3[3Ce8NEVX
\181\13#.B/PeJ5T<>;/9[Q\7H/JdJ#\;>8c+<LSVV_g\b[_Xc8#58E)^\aKL5]/
Y<M-4&?2Z(U3Xb_d/XC;:Z^EHLKK5.E9\M)JB<eINXTWB5RXR=2eE9c4L]M6V.6=
[Tg.1OF2WRL<M2aY]//MYdAY&2gJ&K3@X.?4L<CSJ:>F+OHIP6F^1X.<M4dPW_4Z
Gd/A3?G3X>E[0,PWUJ,D1UZY:U/2012KKO0^<9ICaST/1-4J;Gg:7N8XYKESe#S=
HKNSTeOR.^c1RF&P^Zc/>XG-1QUgB5&5T=[6FM=,L1>&3MC4AG[/Ed2NV9>X#d:R
KI/R=1A]Dge?0fY0f:U]N587e&OZ/SE6LQ5[;ce6I1cID[D?=+HLPf83[BZY=G(U
XEH,?D+8\.CDV.5NF@WD9a1d.H,^[3PS.H;B=#S:DO#C_bNROX3+^XUd<,Gg98<V
aX:e4U5<#ADR2GR+,bH\>WcZ](13@719JeU,Z)B:0+&Y4EU:9SR41/K/G:B)_ag5
LCcE\->==5NLKe#2Pd.8FbB(7+adLUAQYP),cT#Z6e;V2__:8)<Z?R_X^3>ANY,3
bKT3-Rbc-G)@J[:IM5.4Aa:8c&A.G:1fCD)gDaY0a,W4a+?HBbU:9IBLbH5;:=ZE
G-W=a5eA@EJ98EULWP0ReLH1JD03-S:+_eT?dL6#M]KWSaRM@_.1Ibe(gQFEDcDd
5<\X-:g?ca()_4gRG<0[,0R&&bV#)9@gXA7:UL+FV&A)MVH9DME<J0(1d^V3LYH<
bQP2(Tf7=761T6A7YAKI1=J.]6.dW7FHFRE1ITOD=eDGHe.=5Of/;;0aA89DDQKS
?P9QAN9agIX-3Q-bdODe)<a[V3JUWF0S11#.[>MeC^SU(+aJ&KT01@PFI^IU&/@3
C#fS,IRSb(ZTUV&WLDgI^MY<e1:^R<^8Z#aY3^]:2W]gM3adI<b4EP4cFO=NSR,F
c^O.NDP18VJ2LGSGZ\f5><f9C8VXYY8Cg6L6@VcT4>,M5Q#+&.F.]YS[GW5OY_:1
YcTST7bN#9K[aXBDOfXV/6<QI((A2-;M5-OA94\0R_SU5bWYe9b8OH^Y_bd8b)/7
^@.\LN<T>bM?:DF1VXe1e&XX^Md(,&aUg&Y1;&GI(GVH4#Gc:I)e5?cL+AcBd@_Z
?U+2W^gZ45&b/BRC&AZQ\]Z9ORe2270)1CI^9LSS[,N>(-]8M:<eeJ/FLGR/:1OL
-8DYM6G[:IM&7LE/#DI=_bT7dBCU6-U6_C<;Hf9?5be\;INagBR^6^4bbf@H^SRH
Q/NKN?<19^f:D7(D\,I[d_L(944\_K;OaOb36JF0d-Q)<:C=?S_9+ALFY9)5/J2Z
7N-7Id(_97e:?e5(IE24J#VNc-6G(K3U7RL;,a5]YB-)O1:+/BXSe)TYb0_VR3AQ
Oc)b2X.CBCLQac_X@gcH8f6GMd<S4Z#DMe4<LH7H:aH@a?D]:H79Cf)=9Z^P>BJV
,;K;&<\Z;G7/3T;IP(&:EH=W@ZI?-032F5I1_WK:3V7@;fdZfS9#=G@UF:(S@\F>
aDM[]aD_eV/Z76gI>76B3/<C9P^02\a<4\3Ce<ZI90=YY(\8NI--G-_CV^d/4I2e
RLINW3T#49Q-f,],NN_K<,#N7TZ0<,EY<Z-aC4_UM4e)/2g8Ec@)KAI8H]QL+AW.
R1D>gcQXaJ7@Q08G9KUU=J#aDYGIN>?C#_#]Qd9A5MBa-WWcf?2337)VdZe6P[eK
V9eYQYTFQ@ROHf:N/;]Rd@A=Cb8,=]+bH([>+a@cZ-]gKI0dR=L77fWE-eIE9P6:
5KWS@E3QQG@3,[1KgEfcIEWWU?:YF^A:8a;L(^gC.;-(3aM0gLVc2-)UE=&a8(?A
Nf6;)Dc<N7&&Q,4g2J^LP2VGBT^G@XPMRbYgH<UfB:&[/d5Sd(V_OFK9>I\#0Y:M
#I2T7B77RI5aK.9d+TLI&X^;.)F.S97:Z)[Z(G4MPKfCQR7c#/=#[<O\;-&KgTT]
MafOKD(J^(<a,$
`endprotected


`endif // GUARD_SVT_CHI_LINK_RXLA_FSM_SV
