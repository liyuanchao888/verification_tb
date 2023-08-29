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

`ifndef GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_ic_rn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply TX Snp Flit to the driver. */
  svt_chi_flit_sequencer tx_snp_flit_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_ic_rn_virtual_sequencer)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_snp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_ic_rn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
LNI-B4bG/O6PeB0^30:d;Q;]AB_T/92ZdHM#A;>>9ZE@\;@YN.aZ5)-&-[4<QV\N
EN@9ZND+K?c=Me6IXS\a(1c[)#K@5H6,J(\-YE@.]Z58,5.XgEddT.Z4[a4;ZQ7a
8IAPB)ZX#SYR=(S9Eb/D>DEWcWZN^)6Y4gPQWbW3XMK]XKAOXZb,TS@Vf3<0DUZE
-f>ILZ;^D.4DJ++^=(Wb=QZ9g[+G2R;;Cb\PRBc810H5ceA)0YB^8f;J/X/#P17#
1>HL^^XBB(E3GX6#ZLb0+d?;88eXUIT[4G-aDBN3:JSVQ9GKd-DO3@5_^]a)N@J5
8]^-d\<f.NZVHU1gF72-?#7V2N<04(IGQQ.aGQ;YZ+5VE$
`endprotected


//vcs_vip_protect
`protected
OH5MI70VI&,4-a9JT7+.YRU082)[;,e_5.V+AAE_6gG;e5>P;C^b3(2YBV@]Y[&I
T4^e>I^O7@VXKa>F\DDE:&K2+YA3C#:_#9)&I\KCR11]C@UV\8I_DV@8UM(VecS&
9VaM7#48MIZaGYfAD7W;XgO24VcXU:Yf8^KGJQ5TPZJIUFfZ.YXRe9eHTV>+,&\S
eGc00fafN@C3+9d11^b6==K;45Cd<]Q(+C5:FD-:=efB@YOE0L2->.>I?:IL>]BA
(c/7K<6Fg(A=,:OWD9-fU1A>M99+^G\c<A\@e:QfT;g5&S-R3b6OD4H?LX1,Y;,&
4B->NK+XX@5U?X^AQQS//2FH4eaW+3OE\7FLXHa1E/07^D@H^CN:XR+^?Id#VAbC
\0H>AZc=\-[9<>-^:/0;J.S(&>WTY:-TG6KZf5=#\gD1+A+[@=A,C/.&#_gcW7)e
\^fdI-2@OGf6Q]@Ca_c)N=PJ1YW81L+ON0R^aR#KM^84M&3@D?RZa8H?BDe)SI?/
B=5+7@;4Y.a2K/KcR^R5[Gb&c8.+FFf[Q7.<;]9G(dVR;c28A+30DH/7TH3e6F_X
(2^9+_YAZC5R0PWM67BMcK^)-?EQeQNKUT:E?93cGL,cE?(RK)I0WG@Y12-4/+-J
ca/_434e[Gf9#RS+-:d?f?21;3K4RV&a_2+GVDILS_?1YZfN>]QLO1N<MY[af76J
]C+N#[\&FLJOK6_PQE+C^A:XaSeR?Wb7b99P@Vff9e4BA5U#QQ[PBIa^#=-M./=A
Y4Vd)H)NJYK9.0S9.,SM^9Vg.:N?:2N#^WJP4.DS+FVG9^SB?[@9@\B&E.<,LfO>
LcD#5?]22-aQR(<A>ZKZSZBZ]98RMf0)=aZ.7>?.<@c/50[B+D6E0,NeA=c/8ZYF
9BQ(_G@WR_Qcf(D]0@QYI\#8BZbH;WOM@HPM(3ZZ3#,)0&=?g0BZYN5<I+<=1\@8
A#^da9:bJHCE&XHac47X&WB#VB-Wd#Jgc8Q_W6/TOd4R,,&+UG60@J?cO^.C\]gB
.MCg>f)4U?OMG,3JMBd7US^KI6<fXa>O-MS]7G0U&P=^^@5=>27R=4P<L5(^@fJM
-AH7VQ6B1M41(5b2^L6:=6S/1UEYD5OR]=dSA4I55^P0[Q[F=IcM_:b42)6?V?=?
EJK4g_?AT]E\^6(b.AV6Z#;6LeB05J01W4XM=J&#Q2?R&>VOF6+5_L]VN^BRC@.9
D:B5_4DF9:QF+XE;eWRHL6eG\X@f,CPOb)5;bdI?RSQfA-/OZ0N;:M#Z+;7g9[+J
R\]DK=LTNaN#M(PVC_KW-6B]L]SXC^8/JJH<df+DL)+6NV>/B7UF7U6+b]=>;;G7
\L_GH&2Z=XGDeTf,aCJQGb.ZB<(UD+/>M9:DJ/Ca8?,>F>N260TY7bP-P_Y?U1#Z
A(^//.@>_6NTC\10.D4BDb[D/2#CcHWc\>[+2PSXP-7Wa\];MXLeb3>e^<S7^\a.
:.e<W=fQbSd82B,e2T@-cT@@CR[B6@Re?0b^/G)&SE07YaRWLQ@LP3;B;6c):P<A
ZDHeb+2+@ICU1[B9G.?^.AY9\<ZA4#_IbV.>D)@cUL:4#YUAa0dYBKg(4gOgS6J_
U;Qebg<:KI<DgeTPg3f<EEMJPEQ(X:Ig\[?0GPVOG64>EMX]FWR9aLF0EEL914N>
W3(2U>MPYb:dbM85GC?<22LdMU9^:fA::-P.dLADHNc)3G9#^#7aXXRX\cE\fXM-
>B:aDHKH,Cg-/R2199cLUB8&b[S#QgPX#C)]/>I6KP[/)\3BYN0)>E&ZL6F6KU\;
c:X_NA@23O^9R1#X_cb5Se?&&_-<^7]F#b5>]H,@Pg+I/OM6:0PEO9O:5<\KJ#M_
;g?.X3gGJN6YS\ESUL1+Zg#S^\]I:]]9,D:Q.5S3I4ZeUf3E)K_@1#bOO6+U&bNT
-IU3@A1g<#>2VNZTf(;^4@(R[]RF#_T6P,;6#7<KZ,&VCVRQHJ6RVZf]LS<V3>5b
+MUT_B,VXMMe0>ZRfIa@0.]Kd3S>1_A&gH/MV+XEG[4LMOZ6fUQ#J-AdO(MRK3.e
ADPW<SMe>bMOd&B\=a6OHY+.8_Y+)8+Tb=EdZ;KJNFIW/=R3?b<<Ja(e=9Yc=+Ff
?2<?\#VM8(5:+(8M>aS=3,&b].bGX9fgZD?ZOZU&79EI4cWg4VX@[EL.P2W[cH.E
UE5MJ9RBQ15IdLN<R&-.YGIBD4_=)EXJWMN0e-WV?O>8-<O.=HK4RQ_+CbYb>_A-
:cd]NYQ\cJ(,II3C7H/&-a-aWN5D\U_),gb^VF3@24E9T<c<(.<;]1C_S4HCa>5C
QS?V8VC3?Z&L+abX-0TM1_NO)[^V37CGB.\46bP424>[&JU7aG^SagTS0LF,D0cD
,?]G=6DZJ1>@g^4Z[B6f1].J)@IO[f^3/<=e-#YU477;b3+/Y&0WA[K@:.e/7-(.
\B<YVL7D29.II.M#=G3.TV4g0)D\gQ^D#9\M-@6-6(1K7eEOM7V[^,eSU7ZA:,3E
EB=^>dNFbaaf@^N#8_U\5HO306f7CN9CINE,2Db@K88CSb)eSQ&H?W_GIJHM4A\6
8a_aUf-_.b;dZKV7Zd\K\2<0d&fCH.(3fYg(.TKV;0;]N2D8#2@OJC,=YJ)C&c+J
A3ZM4KNWDG,OA<SMY<MG/BF44R?FQ4:U&_-c0SG\b\>]Y_1WC[0PSbSCD2aa2]ce
\^MaI1<_2-UZ14#]F;IMUZdeCaU^WJC(@Q\RI[bE0^0Ag<>>SF^f@C-MeVXI+A6M
5;4\W-S@.F9<2Y\Bg)QK^HfA5A/;fGW==$
`endprotected


`endif // GUARD_SVT_CHI_IC_RN_VIRTUAL_SEQUENCER_SV
