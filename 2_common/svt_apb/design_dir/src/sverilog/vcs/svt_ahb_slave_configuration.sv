
`ifndef GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV

typedef class svt_ahb_system_configuration;

/**
 * Slave configuration class contains configuration information which is applicable to
 * individual AHB slave components in the system component.
*/
class svt_ahb_slave_configuration extends svt_ahb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_ahb_slave_if AHB_SLAVE_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  AHB_SLAVE_IF slave_if;
`endif

  /** A reference to the system configuration */
  svt_ahb_system_configuration sys_cfg;

  /** 
  * Passive slave memory needs to be aware of the backdoor writes to memory.
  * Setting this configuration allows passive slave memory to be updated according to
  * HRDATA seen in the transaction coming from the slave. 
  *
  * <b>type:</b> Static
  */
  rand bit memory_update_for_read_xact_enable = 1;

  /**
   * This configuration attribute is used to accept the following scenario<br>
   *  Hburst >> SINGLE       ANY_VALID_BURST_TYPE<br>
   *  Htrans >> NSEQ1  IDLE  NSEQ2<br>
   *  Haddr  >> ADDR1  0000  ADDR2<br>
   *  Hready >> HIGH   LOW   HIGH<br>
   *  Hresp  >> OKAY   ERR   ERR<br>
   * This configuration attribute is applicable only under following setting<br>
   * - svt_ahb_system_configuration::error_response_policy is set to CONTINUE_ON_ERROR<br>
   * - svt_ahb_transaction::burst_type(for first transaction) = svt_ahb_transaction::SINGLE<br>
   * When set to 1, the active master drives new transaction during second cycle
   * of ERROR response. The address phase of the next transaction (NSEQ) commences
   * during this second cycle of ERROR response when HREADY is high. The slave
   * accepts this new transaction without flagging any checker error.<br>
   * By default the value is set to 0<br>
   * .
   */
  bit nseq_in_second_cycle_error_response_for_single_burst = 0;

  /**
   * This configuration attribute is currently applicable in AHB Lite mode and for active slave only.
   * It is used for the scenario in which the master design is analogus to both the AHB-VIP's error_response_policy, ABORT_ON_ERROR and 
   * CONTINUE_ON_ERROR in a single simulation.
   * Normally master does not behaves in this dual manner in single simulation.
   * User needs to set this variable for the active slave VIP, if their master
   * behavior is a mixed one as mentioned above.
   * To use this configuration user also need to set
   * master_error_response_policy of respective master to CONTINUE_ON_ERROR,
   * if not setting master_error_response_policy then set the error_response_policy in the
   * svt_ahb_system_configuration to CONTINUE_ON_ERROR.
   * Example Scenario:
   * CLOCK:    1           2            3
   * HBURST: SINGLE   ANY_VALID_BURST  
   * HTRANS: NSEQ          NSEQ        IDLE
   * HRESP : OKAY          ERROR       ERROR
   * .
   */
  bit both_continue_and_abort_on_error_resp_policy_from_master = 0;

/**
   * This configuration attribute is applicable in AHB Lite multilayer mode only.
   * When a multi-layer interconnect component is used in a multi-master system, 
   * it can terminate a burst so that another master can gain access to the slave.
   * The slave must terminate the burst from the original master and then respond 
   * appropriately to the new master if this occurs.
   * If the value of this variable is set to '1', the slave will wait to rebuild 
   * the aborted transaction. By default, the slave will not rebuild the transaction
   * aborted due to multilayer interconnect termination.
   */
  bit rebuild_after_multilayer_interconnect_termination = 0;
  
  /** @cond PRIVATE */   
  /** 
   * Enables the internal memory of the slave.
   * Write data is written into the internal memory and read data is driven based on
   * the contents of the memory. Reading and writing into slave memory requires
   * that sequence #svt_ahb_slave_memory_sequence is registered as default
   * sequence in the slave sequencer.
   *
   * <b>type:</b> Static
   */
  bit enable_mem = 1;
  
  /**
   * Used by the AHB slave model. This configuration parameter controls the values driven
   * on the response signal  by the AHB slave model when the slave is inactive,
   * that is when the AHB Slave is not selected.
   * When the model is selected again, valid values are driven on the output ports.
   */
   idle_val_enum resp_idle_value = INACTIVE_Z_VAL;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  /** @cond PRIVATE */
  /**
   * This attribute enables the slave to handle split response. When set to 1 slave can respond 
   * with HSPLIT response. 
   */
   rand bit split_enable = 0;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
`protected
4?cSY\50VB>?f-B>4UC-VD:c59TMGB:TTLF)c,Mc>GF2;[B03;,C4(;ZZU)4aZDG
WE:5--M&<aIY;@#FK=W-d),44/)JTB]BW96eXMB3EFa9/b_#cZER(F5IOIE&=6\:
O61;70D[<</PDV1ZD#O9&HN0TgXC#AA&FI12/P#1&M_\N;^1,I?G3S]b]OW#VSX+
U1HIJ])WCbX&R1Zd@U5>SZ28:0UO\T;BfBK0IU.c3T677-]LQ/M\F7b0IU1C6[XK
a[FJA5L;EB47P:?Y:_23M.EW+H_],8bH\>-[+FXN_^;6[P6^)S\Ze<FSUg1[L1JY
PA_SD:^2F<B-aJ[#W3/a?]HZL@)ZB2Ad6Z2WN2VX_a@.Q:b?,>d,^J,/YL1B2V<M
N[OW@W.UfI66<d_b[NWaED7N]ZFB9IEURY88WfB1G6T6HQ140_;^\;):]CTV-//4
R3K#SJLG1=_=:_/GFM<?d]YZQ9JA@6:3,P?a_gO<SVgNZQZ,TPb8\+,4-(P@09G#
c3dFX+_H/1JW4BNC97^P.gVGIGa8P5,MPH^<9F//=F@0@HCHB:>K^JY_VU,47UE;
\U.Le=]N^D9PaU2TM(gVD_0/QO6L]cN0c\N@&<0FT/QeOYQE9(^.a2dX>]X<,MbE
4W7(N^aN]J(>,,J>P_8[OF+c]&(CE2)cU:;DK^LBJ.J]Ia4bI?E1PEBY-.@<WF3I
B#=CXdP6]5/U_.7UOeDfO-7\<a8HA-Cc@@AI/F:?,7/da\.FeP1Q7+7)3C5_6^cT
YEBE\?YXEQ_?5;g1U;Edg.]\:ba8/?+-C()@0M>A62.JU3CE7\VI6T9(GfdJE1a[
R<:VV8Ya.]@dbG\6C_6RR?db?b[Q6D=DH4T+6Z:\>79))24@R8SbCY\1#_=2\A6S
?D6W>J0>3KLUB,.Zdg3fQ37_1We+@)_P-E6YIE[D#B-TWXRA/Q7+L2AC7/Yb:ZJN
U3b\b)_&9D69DUYBJ^RA,c\FNG9QP^TNQ>Z/SCa_ZN)JM3D@/4U-P(4ZM@(>AB)P
JM5HB\?7@4R==H+:f-T/D.L_]39P)6(L7B(?3D]\)bOSVOG/bBdHY=f]ECU6-Nb#
M&LV:N+^Pg-&N,fEFg-XA17=>:8=cN\M.<7b&[[-XL(,,cdE2\/<A<\NZ3)D329EQ$
`endprotected


  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_slave_configuration)
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   */
   extern function new (vmm_log log = null, AHB_SLAVE_IF slave_if = null);
`else
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
   extern function new (string name = "svt_ahb_slave_configuration", AHB_SLAVE_IF slave_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_ahb_slave_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int(enable_mem, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(split_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(memory_update_for_read_xact_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(both_continue_and_abort_on_error_resp_policy_from_master, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(nseq_in_second_cycle_error_response_for_single_burst, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(rebuild_after_multilayer_interconnect_termination, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (idle_val_enum , resp_idle_value ,`SVT_NOCOPY|`SVT_ALL_ON)

  `svt_data_member_end(svt_ahb_slave_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /** @cond PRIVATE */   
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  /** @endcond */

  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the AHB Port
   */
  extern function void set_slave_if(AHB_SLAVE_IF slave_if);

  /** @cond PRIVATE */   
`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`endif


`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else   
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);  
  
  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  /** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_slave_configuration)
  `vmm_class_factory(svt_ahb_slave_configuration)
`endif
endclass

`protected
8d2V4T5#=Tbc\fVH\b4@Vc)20g&AW>ASE0.SZ<#/0[XPd[0a+44M5)Z7N[UC92PE
b/7KZ]aaT5DC]02O<^+aOdQF8Kc7>U>1OMC8,K@(Sbg5C=GD2+\J:>.Q<\,<P4<.
I8?>Z[;PUX[:MN[-IW,C.7GEc9c57(&6dGc#QY3_MbaS&Oc3U&^f6J4aK:S@c^+G
9]I]VLb0,NLXEZC;E^D&@[3(C(-41\DBRKd5J..^7Q/G)7GOAO#(Ia(75,[@d21L
NC#MdbBJ01KA#dBBdR3?EaYXWX(V?>06g#b3:YDUE)_A?bGL3P];d)[N>A3b)(KX
g?bE]@6fCc&]8(FJf5#I;:+T#UE6;_e60\9LTe\f?<?4KV_IVdcZ:L;Y(;RM->@f
-H5G[FdE3T1G\MCUN7CUY57?e&SW\+e7U;g9LF4)V,Ke0;EBU(Rf9P1PF9e=^VbC
<][S7N++fH8(H2U-E[#K^cTe6e:?ZgB7]aa34]gS6MU]g;F(a22YX3e+JC^+3cAd
I;,O35400;\4;AR=Fe78L,c0Z;0g&4[NX,,9b2#+73UB@OD7<02KD=@4eBP0[=&Y
UOR7H5QGXYZ26b91A/J<a6FO@U._.Y<NR2a,+=#)VfEWF9>D)c(L(]Md\4<MW0C(
T?faEM:/X>8#7dY\R^5>e@8ZV<BcKC,01O=30:C@28SMR6X8)\RV+&fKG?8/5-(AQ$
`endprotected

 
// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
5:b7<D&)Y5^eB&?]f02A>c.7N[G,/=Z]aKLJDgV2:C9(3.4>,A6S-(..JI77+b2=
LK5E7B:)aW4I-\5^M51>,4_<c&GbU#=^gWDBG3DQ(?+eFWLUQ(TWV8[WcLbN(cKY
fcfUNO-U]E8]9L&Gc(UR5P#9eY9MPL@QH1&gX(d(PHGQd6=^TZ?#bZ5V(8;#9#B)
2[W_CcJ(Z;#]:^e\7JSDKd/:\X&a7R8gL0:,THPbdP)TTWJB=ff8UI1DEQ5dL@HF
N.4cIIH:a@70QI:>fe>=K,[;&0DJ=AG@V58A+JXYHFL)709:^9RS1D>8=ePbI7\C
V,eZ>J)=Vd.LH2bF(=A6c+Pb=CU6K2agFKWVL3ZWZDdaQFX@[YJJBT<W@1(ZKPb@
2SbHE(I,:J/>5gD1W_af0ddcGP3P_F;I@X./I@\G2F-T9(3.:5g_SF@ZWf]A#fcI
?JJ<J.Z3VWK0D]T9f:ZQ^<@IMNCS9=]EF^ZK#UPK@F?YB=K?&/?;4aZ,CC>dJ=cH
5RKa]=cS#\S1-_=c#=3WUG[f#?6If3VFTV;4DXWH\\J;Lf4.HI#EcDC6+M5CW#Aa
.RCZU=F:@+Z_5_fDJ7H2eP]NEFS=@<)G?)?.c7>g\^1U+0EHX4Oa?CRa)G\N2EZa
.Q.H30.(.8E.TYQ-4EK]H[]MXQ.;L8&/:a)<=KQ,a(>a=&fZUNQ2XAOB?\X>NVQB
MS<Q[NKY/^aYRCDT5Qb)DG5;NBK+gdC?3G+J1MT#>A/<260-GE@O-\9WNX&^F1.a
c+[,.V6@4^>9NAG^Z)W&-a?SJ=XLeV]d&a<6aa]<ZVe&+T0K-4a4VMg<:FB6GB8/
WPX:3dY?Ie[2O-;S-&_<W.5T^H1A:B6R>:P;I/9Ye55/QcJP)K;9)(A3AV;ZAC;G
4/._-34=4<9?#>4284]9]a]1=)A@EN6_]22D/a5gTgeabHUEXODC-\LKC[@V(3gB
@6D>)SdD0@c^)9SWM9VQIU:]B4;D:N-46OA<TS#HI+XcG&O,c(T4BPfT42e0b_7E
+R/MYfb_#&229Tg3BZBYL:Cg:@23I#D];+<f]WAa:-BTg[(EB=(M91bA&8;B[c49
CWb02/AE]bcScY0-HGT)E4\^8RM=(?@_50@U0=^-c+ObN,bOEMU15LI4O27_<^:\
7ca\+M=1>2VL]6ZGU,fCV]YU7E/D+HI-9(^:=]6RL/>3I8SGVB;aK-/B//<.5&+5
_E,7&6XV,]O^YW0QYfK35=9bTB6G17^W0/K@P0IH=WbYE\26B;9f?NLQ7EDR6O^5
N^)XUM3JZPeg_CXGQS,]+-^;@1=fEfNVD&^9W3[NW((FO4&2HI2Ng]J++<#FCJ<A
>9ZDH-JC)XU2ca,=EEC&372c^a3D[E8dTeU?Y;?IA)VMcQ(9QYW>896:E@,:cdRN
X>IR,_PEBc&?[8a@ZCG5029,1X/QCJfg-RJ+;bHHaBggQFSfCG@.QEC\f@:gQ^KY
PW=T1ZM#JK<Z3O4?)J#<gM7BbI.]0;YK]LS[N5\[])Q_-#6cZcFSa/C;U)<e)P08
3P>P0U.0K,M6DOEUKYH<(WaM7>bHXO]fW/I:3O_Z6aQ\SJ\+Z_g0AFGE(?MYAK/4
O8bR_/9)I@fF:OV1?/6&+N_@1N]f?Z?=8Nb=J//fCg+7ZFF&2BIM#Z3S-aeTHV:c
e6Z[bG/0WB,C]fP:2V_+\42E([&6f+ce9^E;4PJ^2Gd2Z&G//6Pf/[<9Z>Jc(Z2f
#AXd@dU_#_g9-Y(3dAIWfKAI&94Y0BHbPLgC#P1>F3Q-HaRW_D##a.NO-(-4.d<B
ZGVf[B,LM]dG0>,KP)XCg4.VON;>VN>0&0M27bg4E,@5[69eMd8D.DGMG/=YU_WE
YfLeX[:T.MN2(-<L8?S^NRKI.\0\PDY^Gf;e,UE+.EXb5e@N1e,^AIF6(\,6S:38
g1?QU[c2TIW<)O8TFJTW<L5>=7c-/DeFd&6VFFN-7C(..d>GEfHSL?B9bZH[IMZP
IVWC5aX-L?2&)_I^M3;QQ?/bWT^(G9.?QD,MUf-GWEaa,Ie@]GA5)X8N9[bOR@Tb
0<8e_Y/V:fIc)LW.KGM;#+;C9&=4<5#@<V6#,IDfYGLb[M+,W(gM\b#3KKSOe&:N
AW&T6TERD:1=3G-T94/+DII-[HC08eC-7bXA@a]c+5PNeE?Rc[,L6Ig1/(b:,RKU
6.,.Z(P]O>PG6QY6),MD:>\H[IU-fV^96@:]@\+PIL@fSE46XPK1,1UU;T\W5(]N
6=1<D(M-P/=e^gZ@;K]K-6cV;8#T)BKL0=Rb9eZ<Ac,>LCH)U=aC]_[O[_7+,S;)
N5(,DHa&930dEJ94Ve7O,H2-+_2529B4KJ:J</QHE<AJSX0=/&2&VW6J?.8G;9#L
37?RJeB:7[XfE>bIHgc4IF5+3ag/K/-B>@Z;1Y((G,g(81gA2Rg77G&^/A1XG<(H
)K-C\>^J52-[P=/]]E[0dUJfa#+d:_O7]c;WNMC(#c^3gf-8ZU]TIc[=a,Ee+QL-
cNK0C^MJW.M3A(e+/19X0abd,W<^IRS^VF0G;=&11K(E0]A495@6+HW83]2V9Ia:
eR;/_W,=c^)PV]\caQ1A>)=:#>>YX6(d&Xd:dJSI^3FS&YRPbc[<OW0E^I&E9R#X
+aScR#\,f^d\a?1d-5.]PK&K>d.[.?T[A&9[TJb5\R]1V7OU/@7-gT0+NA.cY)dW
J@HaK0[7?)(b1(NabLRW3MRPcRcLSPZg#ISNP]8_cU52;9^?]QF8(<ZHGJ=CbP^,
4JBP#edGGJO^DTPPG](.YIO[d_#GSMM9P-BC3;TPN\FSZS+aR^7,;/]14d]AHa#1
1D<Z#gXg)JN3QJ[^(e-d<];LO&<6cX[9CeO8-5J[4.^QI,f:2UDX/KfX=-?Z\]fV
#1TdPWd@>[.:);e1cT0f<:2KWgZQ>U^1S><@NS>8T<=(^3A;58T]ZNLO35T^UG02
U_Z,=Y_A@gD]bdNZY]UNU36QZ_J5PABVV4B<[E6IP5>KEV-E)Q2^.LA2EX]EGSZI
5I1Zcd7GQY\M^GPCGPY(AGU==M>.bK>/LZQ&Cb8H=X-V;[=4U[c+@ER?4_+]5A1U
3#SF)FR[fZ?^OR>bR8G_(-0FM+LM9PN6?NNS,Q5Wag8:KP\eB2KC,?feQ4agS-UK
RL9VceN>.NdRF862P(F9WZZ1dRM+<GC?7Pa4N0SN-<EIO-<&#IA,?9=P<7\]XROa
S/<aNG+DW6=&Z+)PL2?^(7;/H4WX#Z7HU@7/^HV)J7R4Y&MO\f\3(DPCX5RDX]HE
e-=JBGQKFMFAd<>&&\3+Z,dTY?RZMSeLg)/1QFXRG0[c+X2.\gDN8L:5c_2,4I@/
SL=0[cJ0&\+6AafG/J()(O,<bIAd?A>?>?6DPdSW+WfV,dI(PLVM7C>&a=#gbc&:
Y+,__c7aP>J\B/^SR;DE;T>Y_1DGHO_&e^JW=D^>G(a,><.2OY-c#.8N_X,9WR4-
SV(DD9H>D)Y4\;N9BGB=3FcEB6N@HJEMab=gT(\@N\H2FH6J]D&DU8\\HEBg>G09
1ZA,E[f]8Z><UZ5^&,>T&+FBC1ML\.6Y<M2^NZag7Y6U@W8F;+f@XDSQHJ?2FD@5
b&^Z-8S\.5?H^(MB:&IFO-;[H^#+]SFN)E)^/(=g80NW2BaZ[EV6C,;I\G_-\?.E
cfM)V,QCILf.\@A08N\95[9-=AJUdUEG7U8:^c/Ofc,P&[aGO5&L+J3a^6=)UN:W
e0/&8LN3eUM3CY#N.S0WAMTJ7)[95HC@S@JHMSWMZ^WH-ag_,GQ;gJ?YVF7FIL(B
[eBJKT)E)gVHXOA>B&Mb5gacaceOBCD\Q2a[)S5+RG&CQBEMF?V2D:0g=AL[]^,c
=V8A#_M1)<Q59NVVIS(fg]#;G_K+LF^O7_9ACCV&G#B-AG4V0CJ&(6)6dC7MU<(O
)TJJC&+_<].][PZNF=gfD#S&,O443CYI)M&--e,C5D.c/Yd5/@H2/(JY4PU/LBE+
I):aD0IOW/9bP2ITdA_,E;E-L[Q<2Hf-,LLCA8\K-XE5aA9_&0Ld-6-QMgMG\.T2
I6ca+]1?C8-:V]\E#c=Z_#g3>.CSfT-1V2Y&6T;CO(<c;O7Y/b4W8RZ\;&=]EQZK
eDVT7V-LU67fa4a5B)^L8g=\@8M#ScC-0c3]=VHSIa;4XI;RaeIZO0@2TNWaJ0K_
JQ##15T<;^be]>NL^(;],>SR9G/RIDQNDE()00./A4e\bB7<K<cMPC0HH8.g0:)R
Bbd/K^+cd&fg_L10_e(1\>/(PMB:Tc_N1S^X^U\XeU3(W?83PEd#L3AN<.aCc9bd
6O&g/fafKBDBbFI4Wca?K/L0;UdK[HAV@B>TT55c<?ebP#YNBDPc6P6M//KI2K:Y
84;fA=]e&4,,G0G5\b>;:c9VCc&\WB=-5#&@&3d(ZF]d\BZEDa<f(e3EWNDUL0d-
FO6^,6G1D03I7SDM)ZPFDAeK2S4LW9RgC_d5MCG0;H.>8.,Q>fFLGSc0^JCUJd[b
<Z<3,PH3=.2PL&#;?4/D=/.+D_J)/#GX+KV]&1<cG(O,.fb-YR8Z=3ZG5KM:;Z-4
)<+/IMOEHVYMV\I(W@.1_U9c_U>XZF-:OQ)]Sea2#O&[@gOLF3gQ6faJ&DA.51)7
DA9#:1.6eM]>DA-dP2T^O6C?gFHVcV;UcL75FEI>b_c/&Ub\)GDcUFa46d9GObB7
g0\OG?aJC?\77EFEKd-G>gD&96QWV4T^NMQ\5UIJWY;C.TQag]XQ]IOU<:fGcQSX
K8:=Fcg:ae)<V#MG/Q\f0>#Ja4O#6OJM.CK>081)FFO?8_D03=Bc;#f81a.f^dXW
.^5G:AYbbIYAC.)IL;OY3KK6Q96I.,1_a718C[:TK376:VPN28[d6]@].YCV#IG#
\O.8UZY>7>6R=@eeBL&B+I<5KE=:ADFS?PF06(g;<NNH-;JX0EP4>L6RIMC#>c.H
Y9:5<fTN.XG@\ZM1;EFGKEM4gYBd3LH[JBO3g)(?.LE:PQe:Y2@T/F(F_G(-X/PG
-#bCRe\[V,QYbL754T:,0^VE-PWdYK1GbEQ^N=Rbac=Y&[Q1P-NDXOIeQ^5D;:aO
Q@K1WU]74?](7OGZ;4\+Y\QX-APB<G\F+1cOVV);IF,7]SFZDXPZ=b6B)>d9B&;e
I./BQUDMD\NJ81^H6X_3(#9bN,N1UaG282&gfM2\e^fNR\K3QS:_H6/2I+N=>7bX
b.SACD5,/?I7Y-]Eb?e\SSXMY.3Ve-305]2E7af\JD54I\:M\9gW0TdEW@0Md\B3
FMM0D=;d[S@.C/J[9JQ5cXG-=P.e1A&cN;#?#9Q/fMY(J4FR=8C/Hd0QZb(1gc(M
QD.6=&9ZO@a8C9E@7FD.5-^FTJe#8@N(bPQW3/.Yg_I:+@N9c9KgR:WU9DW0;PST
#LX7G=c)_ef49N:?C)Ff3dN?VM35>gJ]QDf2:\MR0B:-BV(6ZAPAQ8BAZ&QJ[>/f
ZfM-fO]I>0)_/NH>3bY0-<1@Z5^S9g=.TG#&4G&N&<^SUJAY)\6XI^HS,9EKDa2Y
[;,=ObcJ@cL&WBDa-bH7RQ;HZ\Y\QRPaX(O#R6S&>_E)=-L7>0bf:CEBGY986WB[
g5:aW58F:+dgR76LXAbbV5BYEI]6g>>BS#_Tb=gZ@&c=IR4^^V803=7YB]>CI4FP
Q;THF7D=OFA<C7<4a,+[AcM@V0ASP/45Pd1BV\>),RScSI?JVF&_L/_;A:1[eed-
\L2VUL7[#/Ca\_F;&+NKY^KRGbb,^g-2MGUL,_f^dN6=HgBd\HKA05eOeHU:f<75
6+&1LT)22CeF1;9#g6(\Ae5TEf4FHLDO[@8gB+.1bEE4<K9S1X.J0=9.b,])E4Q2
^dJ0a\>EA;2_ALWGgK9?>]AI)OBJM[LG-OA6fWATGUH&&=Y=->)UPNH+&:bF&>bX
_ZE;18JOBX+B67fC.AcF3AW+PbPH/VEBQWW(=V;d[ATcCgV3UQ(5U:1&RJdY-QL,
2EdZSO.>CBdQ(R8EZ[Sa0&;8=EJ1S4_#J)TEM:+Za9[3Tfe:REBI4>V405;<0SI\
caIWH)+f,5#,7aW5M,SgHI<]Q]D=H?EGHM4M\KRFD[;YL@0_WY84A8L+98b?)+CQ
d>]/Q5GO.?:^?6)HH]gE#]K7e]-PX5))<V.gF_a4@c.#)HA9G&9D<:0E072<9L4^
.PEHRULH[:X7,cT78QKKY0+#P@U3/Ug@-/T:Y_U^RYZS@8g;WQZ>54fH4fd)=I0S
BTR40E=(V_W4PNV</2QG=6-4e5eLK@WOGWD8@@5OJ/>N-LX]H-[(?,fBQW#?Q)6X
.[cS#QN+D&@)/0R3fcT@IR?a@^?GdcO9Y9TB19,QJQ6DX??4_=LKNU(EB[76J5&L
P^);BdfeNK4#Wb?>5/,LDf:UH#G,e&gOe5U34a1P#LZB^N3^\0.D0RW-9_GG\5<C
=XQ.bL9[6Ae_9b3KcV8+@JXFPG>PW#TRg=P=7[:);#UVUO5]_MK36@Z=F]9E<gCU
(/e.O;Mg2R//baNbYVf8/?GgF5^c8VTTCO@?HU]?d9K+fgK:fGB5g1c@,fcD6I&C
_RO]JSDb:?G.1&.a4DbYTRT2NdRFKce;Y&g=He@XO)1VJe[a8T,8JdNX8XLKZF#E
JNHI33[eVE562XH?b+Q+N].IN6P\?YEZ)4b/[;E8NH+8Q)U-88R)JQG4?c8(<8+<
1Q5LaM>7YRa)3\Veg0?F@FKa9LBM3@3MC\[G^1IYOI<,J<#]OAD\fMa5OYMZL9La
4AgBX?90CW6VD/b1&EZQ)@;W1NCB1CfH7c=>KdKdMb,NgS7RaC=aAI1?6D;A2?d@
B)?cBAWW?>9eg0XFAZJRI^QPWBA6W+,Z\H2=Uc#Wf9GWYN1]-P)0X]2f>M(cV]4^
1D(,-Ac.6+/>cb8#P4=TV\T=^&Q)&,XDM;Y2=M^_JUf3J26D+R@\DB_:T6bBERJb
4(E8eaJSKK19e4Oddc(=\P^.^M?^dYKDa>4\7-.R\c(M4G+;\S62\eN;.OI3G4A0
U4H7L_Q=]3QU#I9)]73O0H-1gQY5;9:e(-JdY1.B4&UR9eL\9INgP6>g)N;<g?=f
(99_+<Fa#U_A>WA#g0>_F&V\;N./.M<Qf,VJN8^-+(d>gfJGOT@G9().)Q;+ceUF
Y-Q;bC=5L<MUXQa\H,FC>&7c9WUgCZ,C@55TgMZU,T7#?V;K478.>M:Q3faO6)Dd
@DH4J@EE?]XSGA=G^K>ZY2F\KPJ,(9XKXQTV>WXf,IR#__3HT6f>JgFF[E6/E,B]
0D/X7FH&>=5_c&-(^?4Y0/Ta1b1(VM27R9#dHM&M,5]CDHd@?SB/XGC>4eEBI11/
0&Z]JDOg/795,#^XG&Pb-7W>[:/GU,W6M-N.RS9c[aM55MP#TI?^J,S:2)E^702R
d[)gN/fKdE>^UP&0X0OM?Of/P-\R+T,O-K8/0-RDZ,.7)<ROf3_DFBCe60JYEZ8O
=SAU@9/<4QY)8HW5Z4ZH&?\Yc\1XG5:5TL;A.6CcXU8EFVBYEfC]EV_2K=eYYGf(
:892eF\5P:4g)^\Y44e@^9YLUL;TGJ7NVG_6MYOa/T4A:TL>080<HY8@]RM]OF(?
64=@0T:1aP[C&I)BZ[gdBfTXXQXS8XTaI2JP1E;X0]gS</Se)T[_U-SK_.157,CY
+=WI9]EC#?Z]U5:;Z3=Y(^B&SWXe8Ud-C\(aQFW1G\-EYXb1@>;]O:bc5AS1R7d4
U[>TB9L<98_JRV<]MJET/B.f/O\).]73]5@UbN\TZ0JE(KFLLcM=0:(gH8T8ENNA
T=JZ\&ODbOQR<ObP)4BAJ12P#]:eeCY[@a9T.8-)<C;47GYHbA<5BL:,B\E\I@WK
W>HfBZJU<T&E3b[e6K.0F]]\N/;aL<;\5,B7:.fRb]\DMO[:VR^6)G5B,@)TGRBe
A::ecfS&c4c?dTa#I[DN52^-8&3W2d\6/>ROY/7ED]2GP1VL5+fQW1;ad>9dCX#^
-5<Ua0+OW+=VVW?WM2,<e,7;M_a=K15<8=DX@P0VGFCX4bA;&Ba<NLZQ;C+@(K\1
4]DE(Pe^FUb=9&^8)SCg02U[cM=@P5V-3<O+OdP+Gad4Hd(1JWLMaa)^+5a;40bI
Se#)1X^@,3:=6OI[=<J/KY6PO@V]>:3)QgG>]TXd-4g0_?:d4G_AdCQf_(>dE9P(
4#1fF,ANGIR[R38BaV-0cTBIf[K5dR#HH5X\+g4NQW/KMBA\g-;2O-CLZ@W)EVJL
X@73GF:>T)AA5AIa#eE../QAPa5FC4?8R0[5;<e#=#YAa.R4.EN[=_YcKb()aK,(
;,0JXKWS;J3YV)GfS68^b))LJ]Z1[,fTO/MSfY>6AC[ecS0^=?PV_Vc+:O6>6=g&
A2-REKGYK0Q;E:e7=17A?2FNY;57;;S-J:)bY2baWS7e(J6D+U4H@QdS_]7_0R&@
02d[-d/GT:aR2cB+?/P9B>+J,^8L&>Wd+IfX-YY;,7fFPS:#D]-:\,K+EHHB)RG_
F60X-R)ICE@/P7^1A)Y=O0T\>NVCcGC.(,S+9\HL6]5PFRAK-8]C::H4cMC9.Y,]
Y>[HJ=aN7[[f)CX&#0Q\4S&MCV\S,^G9A?U87a]a9P,d2FO+<7Z?.5Z5YOX(REBN
K]&7FC.ZRS9J@RWdW@Z#H+NXgI/V+]V:@A5GAf:.]SKC1B8015L^DT\F^P_ELAg\
,&VPbc@N5,)WT/I-Ac,=/?,:#OfbR_&66?R1fEeV.Y]E@;dDE16EVBd5R@]7O0IQ
VM.+[.R]ZUB]HeK0C#dSA19QT-eUG&MM3XM,_:EE3gT+0:VVSX3HIR>&.g6&2_VB
Ed79WK[QX8E,\ZJCc2V1H?7EK(FI3cUId>Q8O+P.fAPcI9?D@3eCJT.;PU>L+H1=
g8F6L,2c\:2U(9/1-Z.ZEL)P]>VB6CHVP^Z\D[3F44+AF]^?dUFVEZA5RTM;1,-I
M91+efMAdeWb21Z3JF3gLg^D[)FG/00Kc,Z[E/+,d&2dCF[R=?1V,-\E4Q2&R0ZO
QLL&2;>R6(-3R,e)7>8>Qf=N<gGJJVP74)&b&.c\?&Y&Dd7Y&1e(M/>_Q==g9ZZ#
8Ud^E0JKY@79QTTa1aU)P&V/e>b-Yc,5(Q41)H:gI5O@fabdbcO?(Xfc0@>K+MV9
0R-f,J/5>aC9Q:[XA1UbF^QFLLE>2)Rb6)^gUR[7aaW-PWIG6,^Ea+T[#F(A80??
L#a@,\ga.GgMSG]HEZZMeXM:48P.cM&L>TeT1g_#J>De_:d)fF)8@>E<SMMS;0Eg
=3Z_P7fSFIP0>K9?7A.=507.)0[S^ANacE,;7J6+cfU)<:T?->8(H]X#BHO]N.2@
@L[TJ3dYcd5>+U[MJ2L_?^ZK3/YJOOCc,U+1Z/\]GEX140?&f@=XEOH)@CcS/?c5
.gbCH3.CeW+f7;,0>A;SE,C8C1BE;Ee7.>EQ4.=R-/589:K5K8a?&Eg^]YfTQA2K
E<7AE;?KZW&0\)+L+I0Q;:,8L[#QG(Ce93/c?aJU5R=-7AgdCX>,C#5SYT<?>gf@
./fMCJ2YRRfW@IdK/AbUL)Cg0+f56JAD2OGBA55>,?d;[=7P.dH=2^_OW2R[@VKf
\Ga=O]Y7EUO:FKVZ_g3^7bffUC?WVGH+SC:d+UHWZVL2<0_<J7=9])?Je+U-@>L3
b&089WTVNSggTVe<7G)\?@-0#E6NBNf?(5fNMdYOKG/LUS4:@7E)\2_],C^Re2U:
5L39PGe07XI&f/(dQd_,></&&QH,X:SEPO73@+5B^8b\)44SZXcYO)I&-J6R20.=
-_dfdgVS+W89^RCbAcD+4G/CccCF6;ZJ1CG_b6,71@71IIMgN#\(b1,XId+OO:J-
c[\5-591G?O/X^E#,E@Sd8Z\=G54UBaZ+1&&[+A?3-&KVJ#HL690S=DZYM#;+fA1
H<@Y,?bAXO=3GGQDXGM.f_X52>P49.<JI[S0Na;9SdG)RP4&CYZF,)cGb<J,8M<:
/.L//^F0SEPbQLU:7Y>Ud3AJMR:2NMe+:\a&^2R2X=^X@DUQf@4KQDc&2cJAa9A\
dAM>;0>[J^FG@O,&LE#FR,GS??ce:<X(bL9/IHWZCBT;8C^LGLC+JW.-+f(#eQHJ
AO.?UBF2@OENRU]U0()G_EOdUPK@cU7XG;,8@\1DZ2Qe0(L8SGLJU;;ZTLWRRMK+
X(3^N4#S;bc<B(S7f[.+=WUB>52.-gK?;ag8+??S\F?BdXdg2-R#eEb.5VccHRJQ
Uag;&83ERW4RM#O+OG@V/T6I>?V@>JZD]50#X_I8@\</cgR88=15SIDBI5QdXZ+2
)XdGHR;FdTL&ccGM6Fb-f(HT3d@/Z_6aWc-8Q&#--bX#S5Kb.13FL_)CZE&GfYc<
D)[a]QKQcN_YUP#NY\GP;.FHJcD]&27_fG[bW;)CIcS5YO8;;&EO(R3]2)PbH-:E
B,N.4A[E?)XD.bYI.GbcZSe&HfP[a.2F,L8gX^MWUYLZ2B@Qa<8I&0)dG&?Ia.&]
AgI;U;AS[ad?,#G?cQ:J+Q==-8L\VV>-X4(X9O94L#,;1KXg2)7<[fX4;:A0gV,;
>TY,Da0VPS2H)88+Z.fJ71?DdN/L_K7Wf2.)7\#AU-]C<LB.)eW9^B<e:W[YETT.
@Y4TbZS#@]YU6b\3CM>:YWc)>O?KBPZQ4-E&bH\36eHbRc(O2C\f]_;YW8De9^(]
C]N8^2MG^L77<OYN1L#MJ)&c+Z);G(Sc8T@P9DK[]?FL];FaA.NFVS[7E[\Q7<I<
0^NEYV?STO;1RZFT)aI3=?V/bQT59BMaLI3/L#/^S+/cLU2d19@8P<8@:McbOS+N
,Id:EM3GMa.G=6I+A(]F\ULf(IN<\/bK,dR1L>DDK2JfcR983Nf;I8-5)G@,V+KO
(?Q(/W8W8M>Dd4Gd<@,@V.#E/\9([c))]TP[RULR]++H.OAMYGYIWM(02JN>.0H4
&<aIVGe4.ULGdb70A0\+cIa]Z1(4&3TM0&:-_d+>?=Qb5(^gO[NRb=G398?BgET1
;>HU8UIXP?W-NQ/PaHd5QV&#<X1+V_(LHN&AA^>A;D9d70C-RR)cVW@84?1daLIF
N8+-.,(U_96-4b\9H-X(-O#T]TVU:#&fCK8ZE373YdY4&Y4W_RcagDJB2LMZETCU
K1:/KW(]:\(I0bO2c^ZXU7Y>g>:4S5V\XHG]7R+fG><d5N6e>>O\ZZH6d6H9TfC)
A45b?Z]V_cO_JZ74]3<1P/WK<^?3<JDgTW77-Z//.60ROE0]b8I][aV?#C8/#V41
W,C-GZ;AS[L<+5)6]Tb[X:FM)\/M?g=D\6G1A81TM8-dV23KE_]Z1HLOO,OP6a@P
J5>ZHb&g5M47A.@NVUe\C^J=?0(>[[EP]ZZD(^ebPWD=W#8\R,#F?&+T4Z]T4NX&
_#5L659S2]49Q9Qf-K70P+M:UP;1ea,\cR#>B.][NK[,S4V^-V.M8)Z1a0fB(7[X
[17KU&H0+Y#g3KO[eX[gd..-7CRLWg[SBO04b=6G_,0#6?H[]=5+J06>1/RYF(J4
]NcES/SF34T#JXgdA8?_\I=&F_c=-Zc9)XOV9[R:TOB16=_MC.]<][;ZeLeJ+ZY(
E?2XTM4:UVXWK4C7E2GEA21aURES/,g#>3ED)fE(RPE.S,UWE_HJNPV=HM3&EC[&
D32Ae+8[=gM7C/A05,MS_9Z;,SR\1=1^[48>3I6ULK24C2Sb0abbX]]5Ce6&bE;e
;BWSa3PP]2Q<O&^cQT[_^[H@-\IQb4eNGNVMI/E^WKA4=7=;37(YI5+;B43FNJBA
BT@AUV8OP#P+FQTL>>64VQDK3c1)WIMSZDD1E(@d40&N9,.3,CbH.:\6?-D4YXCP
f@[P2TJ;aL4R@>2Gg])RQ@U@=c^M?3NFR;;aK=]b&9+Q13[Y@Wf-ZUMD];1@cRLV
T/KT+^ODG1OD3XOW&O(e<_dCQJ^V+BgY;,FL^68+OTI;=I8O:<C5d:H2J:]HT0Yc
<8^WCZOEVFTCM.IFY<a:_RN;MC/+(5T6]b5II-g-EQOCFH3G5(04J_5(B^ff5+&8
ZC#b+SS@7&b&7H[4I8eK@X]0XCa(bAZ\=>WQ7I21_58=)L@&P<I>R&>@65CVSI=^
,H<<BWX7GVWVZ_8U[8gTXQ0;=;EfcbB6:abDCgKG80W_2:1(3B<XRB.(@Fe2L)/,
;-VS7g_5Rc[4W,O#B1[,P]1S6B:&85bNa^Wb8><QELKZM5-=aVV20D-b22f&-NVT
83PA&,AP1FVUg:&ZXNJaY^Qc0_Ma;(;,V76Q\DVY8F->e9_6MC^e@+Y<&0Sb^b+3
E>KGf_NPdZd(_@XUF@/3Z=gJL=5+HO:EE-=O]QbM8ZUY?-0Y7cgHe+OG^#A/U1N+
K.c2#(76-F:E(E@?>#XC2;33DHME_(^ZV2CU^0^@SEFO)3-gT-\@D^2\OUAfN:T>
gSK,U<3>HCQ5X\@W/_8e()a<#:E>=1;E/EU&Q?O[30e0<0d_^Y4K+3>24-Q]TMS+
5B\4Ed)5&_X[6.\f&f8FEHO9,&DBC]AQ@C;-T2Ee,.]6EN1?.YUPD;7@/2G1BA9f
d045aJ;,O6PR0f;_,-Y3:Ba)Bg&b&&L6HWcUAZ/E&A?P@8A+aEFLBP8S>gRf&DYe
6UZ\S@0(N5HNAeDL?@#cBC0I1RF.?aD>g7U9[)15b>I&;)De)3b/Y0(.N]gRD[T[
Ta/G9@>_Y,7(AAJ<Fe\O>:-42G=&3HOdW,XV9&4KD;f4f8TE4dIW)YcJ.#eKd,d<
H-g5)RU(:;H7<_De@RYdb>PVQ3Q^M@<0R&b5CN#BVW4VXNNI8N+Y7+<ePZ#Q&7</
4WP08W,J];AK1QEQW^X17F\BFRf+AcB?EYL#.<ZT@@&#52Td30+F-^@;A&+Bg/)T
EbA+-.+H69b]0]<]9aY=T#W^I0-)7RE4SfA@Z7/(&NL<CfSC._21cb]S-UL<&>E)
;3PG[3_CPSAB/3:7-Ie_;<L/<TeR?S(D(2<Ff)[BI[(HH/4#CZ\MOcAQHgG.c#;O
eP)UB\?@\)\7UT89&+]>O/J.]ZXGE@_gIHI/>9WAG+#LF\SNO>W?81+FU:+K1aLS
+BPL&[W1)#egK+(GC0eUA;/?>/CB<T;4DK8E()0-QR+>6I1-WB+d=B9[d@4<L=+2
D[)W+9^ZPJ^9Z=bDM.4TJMMJWS]:_U+/b^:9C@VG5M<3M2QcLcc?\:_^aC/-d\[#
Q-P6.Q#GbgD>+=[UeB6gc77\P7]R>\7W3K2SXJ(9e0RG2LgdcF#00NR#[?S1T1+:
[9R6Ed;T4-X#4QC\/3R=1R:YYZQc[5X730Z+d,7OA.;fOYd_E;A_QgOTZ&&_>K@?
=C(PW\YCJ()X_.&82Nf(e:>D)/\Tf_UDZE6]XD((/&\4GV.5G2JCJUSJ0OG3Q5,e
f])E2&,_@#O2H6d#P7DJX#ccS_g(O_Y;aN0G&LXLJ#S80#OD]64&E<#1&DTbJJ]=
N6K:Daf;Lb6?7UF/Ub1C<XE3OO2AK.HA[,WKYZ=HC+.G3-C]P+LHVR8(.2?cQ:6W
4CWXI+NGJV)aD,L[gB1=e;X?1>P?<eH1eA^HNb:I?0JD7K>2?_AL1bg>9W,^a<eF
-,_>4fN_LWJ.)MK?R.4b0?NUGc&J950MF2&c)K-\gM3d1LU_/VZU@0Be5-RJ8D#G
CS-/#RO(^2DF+X=W>3f,g[e4#GV2g2bQ]M.Q#G7CC<F(D3/M3^FP=TK7#5:RP/-L
ggPb+J(.ML&\\C=5g]R0bT-d.DV3.agEaE-90a?,^?V@<U)LGYSO/^-e.;9OO+^\
H;Q3),1G#HG)=+>6H?XKDdXMF+IT2<.cH;\]Hf5=-,]OG<4.,Se4/YQd.ZJ>;:FY
)E:)=bV>UDLea<UeBR5a7:R.><_+1&<EeMTVWPU\A7].0TMT:D-\(CbbOYd,V2[+
fbT_G3Dc?4AB.ZR?Y\dMT#3N#Y,Ta79[F7+P.8aCIdY,E@4f8=Ma+;MK)c<S[JK<
gIQKDee#[UM&G>^9.^a.3e,3<\]^9;@E?L0Qe3+Zg-G.I?L-D6-K\7HIJdAIb,_I
/g6V->6b.#.IK[,1(J[c;&3[;5H03LCg><@I;N=Af8E_Q#IJ=10MS7JRg7=,08ed
1#Jg3>P#NTVF^>V7U).-S/&O(/aV4+O^_8Ld4YCD>=]3?LMLK3dWcggZ@fg)3W&@
F09f(:?PJ.e.BbEO4J)?b,[9Gg)2XEaf5eF4+Q_;e#[/V4GRL@^1eg/CDG@Q>#?]
1L?ge@?RBK[(.,^W6&]fJ#OAg_f/IR6A&;D(F4LF(SS=G[POCB;#KW4-.Z0eV>c>
cJ#b;I1:?:\-g@/FW6]H&I;F6.7D13dRf?8G2R4Y1dT@F)NT:\ZfCYO2gBS.06d6
#cRb;eGZ+4A@f4d<AT]f;<)I<Pc+#4bR9+4:56/+[+#@Ke6G#=;F91Jd5;[\/.R.
]fPVFD-S#^+2F:/.Q,9T)6X1]?PN6@DdIDG/@CB^MT=^<,&U&^4&V(_<38AN:_[_
,;_>;^cE.];41^#,J<F8SNbYcFO<N,FVIF8(4NfDIXDPU&[_91>Q:TBgV_TP4Q#6
>>aLcK@^B>+,)X.LRWRB++_D6I57NE]8#.UN6;fT+gd2\&f5c&B&HHCR5bF/a3]U
#T.-RfH[N9MMBG-FG4HNH0];LI_\K].\d_U[7JTNX-eAXY6TMJ93RYQ/9X\5:]bM
5c_E.&5SB:LEa.G)#2@VF5b?(]62F5?,CH]?>D&AG6<X4g,YFBG5bg5\3bU12)MX
bYK&9f>?1/GY(;N+<-HHR-A(.gZ#YII29Sdg9=gDD],ZR20&X9&B@J(Lf&KGK:H5
716Y+VQ/&2R[4eeQfSa6X#V?#B?)J749LR5gMCX)A\B[H4Hg[P8=3(_6#(B4M+TQ
^YV3RGL)VX5e_^M(#ZcKC?>>c3IV]#g?]YH>T\O^AIdBa>P[>bI7Qg4+)8aWOdOc
g3N[2<^ZYF^;RMOaQDX2^J=Id[,FUC.HJ/J5EYdR5MW,d=D<BN3Q1#(EggJUC;9C
M(#G]bMQM5A-33PRYAZ^SVD)Z0<8+K/=MEbHI0X#T@8^4R<ES)4_T(][O9I-<=Y/
2d=YVUd&0/,a_8339d<Ia[T:?0&NK_^P(eFUQ,,E3[+EAN_5AS/ZReX_gIcB>BFF
4RJYVBe-(bC#aPW6V=da:/bRVNaWP9e&5acE&>OY1EMUJ-HNM3,b4H9/7N200X<g
\#+ce^G6EX_.B1A<:G>eQ^b)P2C4B/LF/g;HO)>1_Qd67@JO)+H6PAXI)WY1;SB>
O0R.)-@W6g7M/:>QW7\H)2f,)Q?:4e(0^3fU(Y\[>GF=b>7b_GJ6=_1V;67/-Mc6
(^2U1\bd(?W[M&@?NRe][[#FLZJE],-fCT.9_]+,Q?UEbT/O00Xg/>&_)DIYLYG7
9+>D1K<HGF5)=^<,<]>\_3O]K/\H<#bY&S&L&N\[&Q[Mb3U9:)3RGdQbDJc6?X^D
Y\AW+D_]J?7F#BH\<@4cW:1JL)56,U^N2(+4/]/_JZJ3>3(7JVT#\IPY65]=Pd_^
5Vb7IC^N+=GbU1=@K:Oab,,=7)25-K@DZ<-f\NB2EP^09M0N?]WLc<&VL]RYVFGa
(>]c<Nd9BVaXCH7\M3-()<EYgONI;2LLbF)VN2.^FYBa(GR_-1b9g/LFFNZ=_US^
@)4?_ZeR=DGB,[3QA3Y(F2?Y&A,6Gb/O]21\G[#(gD3LDRFH=4QIg4W9SCBP+XTC
,S8?W7A9Bc-H#+O@K>TY4R;6X2R[J?(R.I_?TYgc2.+87NGX,BHY_4I2]]Y]g\JG
FPN_3Ng?(D]\:7:1+461@I#aW4A90QG9a^6\FI2DU:C6CgWN0e@.UGTYdU,LfaSg
8:a/VR?a9CJ\7GB3VgH--4JbCEE]D4.ZJK[M0]FY2D9db7bHS0NVMSMLM.[42O@Z
=#3J-38,MWFHUK,He0bSb;#Fa=DQ8XP:85bX4<[>-1)+gb(6L3E&YB9;G,/.AdCS
9A;:P4fR=TCWA:W8V)42RZQ==1=/4F@Q/\MSg,EIHUfIC1Q3X6TVE:eU^0N74=@b
SA/P+US/6Y?7a^+\SaR^>>>6f4JYF>FLC96DPT.3QU(;/aFeb\1J@.X8KW4:RU;g
_Q[G(F/a<L<c[HWB=LX=YYSF9ZL0K0TAL#&.8g<)/BF4EX5gBCfHRNKTWAF>]P(Y
^+YR@6YERB.M\aaW>0f&dXbGd3GZTgF6YOfP6S6:W4E>P3[HQ8EMRC[eLf8)Y(Dg
af>?R&EILR40#GG,Q[R(SC_V9(O5Ue0CE+c]3YOYD]8ggCMG;&2JW\aYV=SA23NT
WV9RU@UW/Y+6g67c37E5dN_VRLRdbAMMPR?M/J0@ObQ#adW4UQad40TPH/;)44RI
H<b9_da/^FJ_:E8De:W_GCN?L8b01/9[TSPZG4W;.7GA.RaAR.4U]JV]BA6N/^O5
&=&)3?dFKD.Xg&U:9&U#Z[/0M.-86ZEMXP+ZU#b[WS6C2&O)#QfS/N[8XL@);>;>
bG[ZA[BQHDXWfS35^-O[>C(daSR?]U&b50a>dZ#Z.UHV3#23IZdH:)5YM7H-I8LW
?bH=K6UX>IS=0)+&NdE6@OM;Q.e@^8C,YXH>U8+,&2R0_FTf\ed-T,MG\6g7g5Q9
&)N#.aRRfOQggXJ/Xab#?F1I<?c?UWQ2E4_W\QHgCRB+NH^S:2\(K(48B1-YRZQ/
eYDg3geKYfZA;ed9R<W>fKCH9OTcZS<>,Gg09]BN8-cgQ/=/4S0<<[@1b?)I@]2)
Z5R+Z6:@1ZG.;^9cT;g1F>YNc70RP8(dU&d7d)F8-KbBf#W@N+2]b^7Be[UKEd3W
?1((MZY&DDS:_GJ22IOM:@Dg4b>Ig;MI>d84K91-H(QJ/FObKcWB=+XJJSOB&T3b
Dgb)K-fBTWa[NY?H]X@JQ+BDf87C)H(U&JVU<aK),121MK^9KM]bY,;1EWH7gL,U
ZTQFX+R&2g];9N15[1GF1W=ccLRT@]@1;+4B7W=.X;>?,(C<Ne&6>S8>V8I-_9/3
D..Y)Z1,+dP+L7([]_Gb-bU:-4O:;BD+@8ZDFR^]#26gLCA[N7,f2(c\2F^E5WMQ
-:<4g.DJAFHLPHU-,f>H.dD@Z,[J;&<b_BLY0K@HP/#U?e0OOMT)4U#Q=K^RD&6C
P)V@,eVR4CC#AN,?gH>P3DU^3fN@VI2CR3b#R3,LQWU,91gE#5L2^S,-=+H9X&^H
QPC?^;L[Mf]>9R[b.2C48QA]aI]^J:\b<NC4aH)d58(OC<:a+dX?P\\=DJTVJ.&]
0N/@b7,Z.@GMXWfbF(2-+dB=5fU@GQ)\5cG^OJT_>^_[4:DOZ:OBR0W<Z-Q5aW_\
H,JQUb5Y\6GS&IP-Wf=NXge>X(Vf)8eeBGO9V2;]?JCgCWUd1f+-=RV9PdcdF]P=
Q9/=<\(0gJ_M/Nc5S(:#W&VKLG.@aMaR_JLN:FfLFB]9183cNRF436e<5,@fTJ:X
U(:_H]ND5[]f+C\KWQ1<Y/6;Hd3Pd5J(JO6Sf-AB9(af\CS)F@LRWg\bEF+I&A?7
5cDX+ga7-X:;R^;_,EK#&5W3LFA]SdL7]5&-X2;d71U1G-I_QWSO@<)DXRFZO,+W
ZHMAI9d0,ES:AG>F#)5<)C2A>TR75#)KBcA2.#</:^J[&E)D>ab9U+6)d41BQ6:;
GO.(ScFPVc4YKJ[5EF(1S5]J6>BeEXd;CQU#bUKa\8@5F,Kf?VE0.XBTN6WY4;O,
)=[8)FK[.2:T_P#X?GI[/DC4IZQCZ;U:JS\R^BggTCX>K\Y#I7a\@[2VB<7g67LI
<GRJ.Ie9VPHI5^dDNPbeaJ]TR#5bXTbgV&.EBaU&>f)KG6f<792ILTM8,Z;DcBbf
5P=Qb[=GBO&(3ORd,NO?a.V3I1H]9d/P_5#f0=aPg@b\Y,78Q_Ub<E@#ZGFTe_?G
9W8IZgcCD@DBK+aaQV+L;[K]c&#dfJT\C^P0\URg^L&>4/[]Y,H8,3DI-Y)((;b+
3A#bLY/+]W1KOC_\4Yb7CeeZRRY\:=?E\1Da^<>Z:GAAb7b;ETc&N[MF5./-K-^P
JdI<N?1gCWI@U8JDF5K30Z>;9L[EK2dMFgMB-U((\0g?f:L:MW^V7DYGa:FCHOKV
@K\_005I#^<7b#8[RY_:6<X0<15B&f26&6H774ZFPYXX;=Y>eVH^9LWO?4@J\L5D
\U>348QWOb-?cUYO)]09;.&P,#fCB2]U>f,O&U^<6df&X?;fYF9Yg@1=VW?F_KPb
Fc8G8:1K6d=TC-ICMN;(]002Xc0U[XH\KQ_]977C=Qg9420Hc=<H?,D0GHY/9BD.
4HO<I-)V6Y>2V^@X82F)FUQC.P,6W.YZ6WFL^YIGf,XY968Z75KMTf83gbX+QU7e
D+@:[E#@[CC;/bM\C&OMcT.5+;]IDC[+@H5K(8HDIdd/CcU55VGHD6#FEH[-f&E<
Bg614FFPJ.]6F23FJ)@6?e\#B[N]\)HI^KQ6gELH0[S#(bc&#8AUAaCf<)SbQdKB
gA82R)KIZNXJ=+R\&_+EL<>+D90TZL3U0:.K89&a1LNQ0fVXN36->+BeV@c3ANQM
Dg2T7B-?7Gg3<)/GUfMK^06-7[;JE@.1F@LFc?\:(Z@X&)&G&,TEWVFCIBT1OQLb
A8R/>&df^2/WRFUO-gGgZ5/6\_R]f97SVGe6@Ja0HfGdER(;6HPX>6OE\=b5L5dM
J\bV(,><S+46:?H4,9#6ZC;A=bBOgQQ4PG17CEfMFd?DC6Q]fF7c\K_B]a)d\/?&
<2HdR(45T3VK(P,.^\:M26090=-L(SBRVP1gN:gAI:C[_eLcg25\--=&cQ\O@2H,
C^^Wc1_]&E5TXSVJ]E?8(Hbag=F1I23YH<UV_Y?Lb7M+#)4JP&FY4\/e+aG?dN,D
ff=-cL3a()PK8d/+Pb#b8PF/PP3UX0H.3:AB,6b.7O2OVP5Sge2Cc?/0eE=C]ER3
b-.?e7:5[U3BBNV_0A:15\G9ISgRb2RN:>SeJ_ca3&ATW<cOW3bb><Pa(EcI-?-?
HcKD(&2B;0)=)N0J@Ef.1&AL/.HP4#?3#cJ?:Ta;84._=[I\[WAL#RZ.N?83^cSR
1,3RGfCWf#]Z4,#RB[57NHQ^f)EB,fJA](>f4&T=.g^8RBH6e1b_)bf5+)QI@Y7L
gfeD:_XR-,5NJ24/d]4GCA34I]e:4TYQSbE/bHbIc)/5@e3?TSbBC^]2UW._0KV&
FfHEf45C[NcN2(X/\R/+F5@CcS\ZV>^CJZ2[,>+-(Lg@EOP&Sd:5Q\4C)PIeYF1P
AN0PO-:RW#8B_H\,<6N@&R#<)+bEaBP8f6C3HR>P<H,^4I;EA//PNU\IPGOc63^Z
+]f3,Q>4)[54X5)[L+E9&0fe=IT?CU9O8\XUM,H@<8e2]>(JGCM3R=O[><d(aG2F
bE079D6E\;Mg/,[S;8,9DSZO9EH2[+6&LOWNM]6QbLM1;>-Cg&[>OY:2H3NT+&\e
/F=JG9:SRY>O)#QV1ER=QfGCUAV)/K+5.#g/]NLU)&bd0MdF_\BIAFTf5^H5#+ZP
,^9==gY@dW90g3U(25cf,c)\b;O/bXN^\NRA(\-8IT;YTXGBM,[@eO_K)9]5:)74
+\[4UFb^&(2NNL_T3a_7>aWcLOCH_TB.FSVDNV;7)4WVGUO<:J9_N>K9Y92G0ZPY
9<=Tac<A+9#.Og^T2NH78DQ^IR4LgZ\d^a>&d?(Q@/bKHPA>FIa^=[OBI)+;=D7F
N>#;G:RI2WNPFCJaWR.)(Da&:A4:84F;0:_aA.\aJ=Ca,bPWP;3?Ld,CR-G+^AAY
#O?S5eH2YX2N0<9Ob-4Mc&PBa93fIW+>>X6&&HC@(D]X4K(f7Me\E?/TOHE52OYF
2O&=c@S1I<<^L,VPLR#<<K8]WAABcAFI4c;8TYF_L?_N&cSR2M@.-EU>Z[?.><DC
LH7_Y0LMdOEN-Mf>.QF,.Z-0gEcWKB)/+.efYT>+Z7KPJ-Y,I-=@/E)GZ)\c8+)I
1+IFDVRaH]48C@LeV/1Ac:H&VT.ZbF1Z_YERc>;[LaIGB&7Y)/U>=#-4L,b]S=b#
+Sg/EH1YJ?LQVRCg\.A./X(eOHAIJGgY7Y1Q)ZT?WF1I37-W#U6S?YTGD^fHaO1P
,[OgL@7d:--QI2G17e3@=Z;?\R:DgaDLaX]eB#?_(0?6cASfHSIGDPGW5cg33L,f
0L;-/FYOE[.+WI9<P#,-,^@6;Ye5F)d?6L6-FZH=_2J(M4>c-7RSK2CK/>TA,GL7
?CVP@W18(R4X5DL\_;I3.F5URT^#5_3fTYdRB1<f=NaH<+L#gXGd)YK(bP,@c1>-
ZaS]8NKF2H2-T<=6[aFd]9DHNL:QHe>PaAUQfTP:A6cD^>>aT#S807]ELe,+<8d_
:=cQ]b_G&c=-,$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV
