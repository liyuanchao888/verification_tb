
`ifndef GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_port_configuration;

/**
    svt_axi_ic_snoop_transaction class extends from the snoop transaction base
    class svt_axi_snoop_transaction. This class represents the snoop transaction
    at the interconnect slave ports, which are connected to the external master
    components. At the end of each snoop transaction on the Interconnect Slave
    port, the port monitor within the Interconnect Slave port provides object of
    type svt_axi_ic_snoop_transaction from its analysis port, in active and
    passive mode.
 */
class svt_axi_ic_snoop_transaction extends svt_axi_snoop_transaction;

  local int log_base_2_snoop_data_width;
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_ic_snoop_transaction)
  `endif


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_ic_snoop_transaction", "class" );
  `endif

 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  // **************************************************************************
  //       Valid Ranges Constraints
  // **************************************************************************

  /*

    Mainly covers the valid ranges with signals enabled for AXI_ACE. 
  */

  constraint ic_snoop_transaction_valid_ranges {

    solve snoop_xact_type before snoop_burst_length;
    solve snoop_burst_length before cdready_delay;

    // Address is within limits specified by 
    snoop_addr <= ((1 << `SVT_AXI_ACE_SNOOP_ADDR_WIDTH) - 1);
    
    // The snoop address, ACADDR, must to be aligned to the data transfer size, 
    // which is determined by the width of the snoop data bus in bytes
    if (snoop_xact_type != DVMMESSAGE) {
      snoop_addr == (snoop_addr >> log_base_2_snoop_data_width) << log_base_2_snoop_data_width;
    }
 
  
    if (snoop_xact_type == DVMCOMPLETE) {
      snoop_addr == 0;
      snoop_resp_datatransfer == 0;
      snoop_resp_error == 0;
      snoop_resp_passdirty == 0;
      snoop_resp_isshared == 0;
      snoop_resp_wasunique == 0;
    }

    if (snoop_xact_type == DVMMESSAGE && is_part_of_multipart_dvm_sequence==1'b0) {
      snoop_addr[1] == 1'b0;
      snoop_addr[3:2] != 2'b11;
    // D13.3.7 TLB Invalidate operations in DVM v8.4  (AMBA® AXI and ACE Protocol SpecificationARM IHI 0022H)
    if (!(port_cfg.sys_cfg.dvm_version == svt_axi_system_configuration::DVMV8_4 && snoop_addr[14:12]==3'b000 && snoop_addr[0] ==1'b1)) {
      snoop_addr[7] == 1'b0; }
    }

    if (snoop_xact_type == DVMMESSAGE && snoop_addr[14:12] == 3'h4) {
      snoop_resp_datatransfer == 0;
      snoop_resp_error == 0;
      snoop_resp_passdirty == 0;
      snoop_resp_isshared == 0;
      snoop_resp_wasunique == 0;
    }

    cdready_delay.size() == snoop_burst_length;

    (snoop_burst_length << log_base_2_snoop_data_width) == port_cfg.cache_line_size;

    if (port_cfg.dvm_enable != 1) {
      snoop_xact_type != DVMMESSAGE;
      snoop_xact_type != DVMCOMPLETE;
    }
    
  }

  // **************************************************************************
  //       Reasonable  Constraints
  // **************************************************************************
   constraint reasonable_no_multi_part_dvm {
    if (port_cfg.dvm_enable && (snoop_xact_type == DVMMESSAGE) && is_part_of_multipart_dvm_sequence==1'b0) 
         snoop_addr[0]==1'b0;
   }
  
  // ****************************************************************************
  //       Delay Reasonable Constraints
  // ****************************************************************************

  constraint reasonable_delays {
    acvalid_delay >= 0;
    acvalid_delay < 10;
    acwakeup_assert_delay >= `SVT_AXI_MIN_ACWAKEUP_ASSERT_DELAY;
    acwakeup_assert_delay <  `SVT_AXI_MAX_ACWAKEUP_ASSERT_DELAY;
    acwakeup_deassert_delay >= `SVT_AXI_MIN_ACWAKEUP_DEASSERT_DELAY;
    acwakeup_deassert_delay <  `SVT_AXI_MAX_ACWAKEUP_DEASSERT_DELAY;
    foreach (cdready_delay[i]) {
      cdready_delay[i] >= 0;
      cdready_delay[i] < 10;
    }
    crready_delay >= 0;
    crready_delay < 10;
  }
    
  constraint zero_delay {
    if (port_cfg.zero_delay_enable == 1) {
      acvalid_delay == 0;
      crready_delay == 0;
      foreach(cdready_delay[i]) {
        cdready_delay[i] ==0;
      }
    }
  }

`ifdef SVT_AXI_IC_SNOOP_TRANSACTION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, "test_constraintsX" constraints are not enabled in
   * svt_axi_ic_snoop_transaction. A test can enable them by defining the following macro
   * during the compile:
   *   SVT_AXI_IC_SNOOP_TRANSACTION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif


  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_ic_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_ic_snoop_transaction", svt_axi_port_configuration port_cfg_handle = null);

  `else
  `svt_vmm_data_new(svt_axi_ic_snoop_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  `endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_ic_snoop_transaction)
  `svt_data_member_end(svt_axi_ic_snoop_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * TBD
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize does the following
   * TBD
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  //----------------------------------------------------------------------------
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
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

`ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_ic_snoop_transaction.
   */
  extern virtual function vmm_data do_allocate ();
   
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
`endif // SVT_UVM_TECHNOLOGY


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
  
  /** 
   * Does a basic validation of this transaction object 
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`protected
PI:,ZdAO=7_/HJ:)]CAS<baCHD146?LD[>W/S_KSd9S69I>/&C2a,)-f#JG>Z4A6
0H3>A(M-QYZ/,$
`endprotected

  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_ic_snoop_transaction)      
  `endif 
endclass

/**
Utility methods definition of svt_axi_ic_snoop_transaction class
*/


`protected
6,+7UOGV@D(RE=@58)RMeDf-K0ANL\bS_YD130PJ3>)8B\AGOd607)IC0FI.^)f,
X_16W_Fgg=T;4cEV&E4X-9CaO)W1.N_9_-M2\fFM5e1)\a&RQNEg<(P0@WGcGUd6
3;RJW,.3(DLU2b-]7[PA<LK_]bD-0Pe7]e#PX[7U&W2R7FU9(M4fe<6ZWbTD@>(3
3e_5.VW0UbXdU=C;T4G<0Rgc9-1[I5W-WL(?d@L;FK7,N?.J/]-Mf(5XL?^)e@\6
XAA7=bZCBOU_NKT7E[-^-FD=5M0L5g?XA61J:@UCX]4AAKcS7?MB>Tb9<JS:,c2=
H520g7EP3_82aK<U8SV#,(\2fBGBKYHPK@d)AAV6HdKDODc[\+O1),G[1.1:N<6E
XRbQ0[:O>E4MOYgUbV+@.&dSJ]U>#=]EN_ZdY5.<,:K)G2AT._bO(?@>TYXE/C?F
L/b8#agG4,OdC92)]fSP#IU66PP:0IA&W)VVW6MA;cfHc>45[X&V+59g;X&0\P<W
3][&e^]d3JYDM=0)e3=b#._dUS8Q//SD\VN/U,/E8Ha+<X7=+23T1IYWa4<_31<(
&CRJ.+,>BY3aK?0EZbg1f4=-a<PT5(#Nf\S(-E3)@F\>)\@MX+D.Y_]2E+F:R:,T
G,fYXKPSZf_R-8=Y#:X7NgIb[S?.-H?\cF.70@,4De4&2_R@>+?G.1Vg;[-OX#_B
CLI:C8_e.Z@)0OfQ(S,6_BP]g7A,Sa/d=&eT8)R39IeUNPg<\7b^7-\4f@bXJ9[(
a\/=^@&ZeC8J,G?bZ9NcFeaXR.&GG?/#a^(NU9f-MO->F]85.[1&/-^eGe.V<X#R
KFK<R>K,CBTd)C.;XSNE7<)AC;2Z_N4I1;:?EGZ\)c#gbT:LcO,O5L4MA1C:M2;/
X2Z\S)Wg7+WdOcc4)57c.B-a8H=5NVZ@8ZG_0OQe#)W4<.;Kg+/5>9+-DTNb;,P]
215Rf(^2[^YKY3@RV^WF^_2XbV4_3GJHKdH[R;MWaa++QF1?N_/dW74RVF^dIgCS
OYLI/?X(V(?[1FI34I.\M>)ZBdf?=-+JCaA+D>W@A:-d?&:7_4UCYP@R?/]A#QWD
,BDE9,YY#PA./_+L@A.@MNCg,>,b?EVPCBe//4gDFDa/.D2OHCX5\<LLJFPaKc:U
7A4[c=4D-;P8/gFY&=R>=gDLFLX_d0a@NIb2J4N=NJfXUWFIT;<12.Ne4<bRW90G
-:1eUe)XQb/R1:(8N2IQg)Y_cFHO]2EF[Xg/c]daO#>SB+>-+T^C:MNY)4IT[;32
Y@E(<e#94+7J@27Q]=[(6?@]H0W,@SA_FGcd3HB><^(1dN5CRD(]AE^3d/>VgTJU
QE]]3e,,C](g(8b/(]O7/N_>OO68I?M+7;BXbaUaOI;,J(c?a6Z0W>P80U^DbFLA
P#.Z(4(5cIag,$
`endprotected

    
// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::pre_randomize ();
`protected
/GBY+8RSGMaZBGZBd)/P\?[O2bB[6eR=0@/_LE1\)I_7,+H,K]f(+)V4<GW<N/./
=cY(:;^R(=\8)KV6W;IE]@XB3_@QcMNWTbe3:BG;)I_QbJOKf\6E1-1\fa4L^;cF
ef4VZfbEA=6K_);5:4[U?]@C>&-)E9C?+ELHW:2.G&3^2Y<Y7#NF=-5KXVPR6Uc7
+9N_)AN)X(W,8.&SR.BfZB5FF0W6)\+UY<AFHXbSOJ);E+K11-1IC;WEC>LV3\NE
\bJAaF3gN;_KYV?6^TJ0Wc90fEH.)[<,@F:Yc>D?N#-E8MXgc)&#3TJfK)D/ea\X
F/&I\3Xd:1IK.$
`endprotected

endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_axi_ic_snoop_transaction::post_randomize ();
`protected
,5d5.a#=0,1;-TWDbF8RW?4LJ/H[WJLI?W+7N&1=S0V:aB2KFJ0L.)a9.L?H?6VT
^Fc5HCGGF]K.P(DD?0[]@X1_FaXa^PE>3&Y(9gM]_aN:C$
`endprotected

endfunction: post_randomize

//vcs_vip_protect
`protected
AN\c)Pa/J<ZZ)>/c+S7YIf#1.6T>HW\7Ug>NCHK;G4e&4SUJ41QS+(<R;[f#>MdX
>f28Z.EaEGL63YR3MWff-X3NM^,7VD<Z-/K7I\8b)&S[)#6)+U7UG7;L+VZ2[IbH
\9LK\3UfV0B01I58JQ^7Xa^_EQM9BL:X#@,8KRJA-9,H0S)B[LD^0X4^&OSAQe6H
8>aC8+2M]C0EcDXT@BH;(EgGY>YC3gP8J9F@IXK>EV50OMdKT<\bSEOFgS.gY7eZ
f2236W;aN_KWZD?0S@S=6U5(^3V\AW7Hb:I&_2S_Z-15VJEA,XK-6/#)VMa30=WR
&FEER1AE8#H88b=BQ.?Z-efI\1QHZI70#>87V+5NcPXOR,1.:H-;7UGZaY0FYGW,
4@_WHa;I\=H-R6:5BPAIDLaCJVG;E;4MIDTWaB.7B)61]-=bUgB6fgJ)_1\\Q0P:
fd-^7T-V+bDFUYFL/04VQZL^I0bV5WE+SO\dID>LLQH8XIX56@CYg3Q,B@.d^=<9
40e)+0I91d?e;.ZW#Z]/a0NT2;:R2/RK0c0.9U@3KRFVO7&]9UaVgH#/V&]Ycg0&
\/Y561Cc-O2;]K[JAU5+KX#-E02BUDJCDL.@d^^BQE)g?;L8f?W1@@M2eR1ID3A4
52;e+LRTMKI+5bXHXG+f@af174fQB3QZ0N^^NKMX//PPG/=PUJ/@T1_&/Z:N308L
Z+5RA>L)0D<e?T[IdacO.;@[035Z-HT+N0)XN.9RV.PXT&egT^-b7UP,<7-?,6_+
I<5>#I;0SJ<8>)aZ]COOV.)[2UBGCeeaRHLGBZ8IW;U2<:MX:Rf2d6>g[YXdZ5M^
NU2/&S85/H65<)=^>-DLb#OX-fJdG<f0ZLI\e^]3<QbJN?G7F^Aa-+Kc?+DZ^@Rf
#b^<?[S6->C]Me3?0/EdH)CVCF6KIEV)D4M[PK4K7U-3JU5^Z:VMV6(B/5AJ==WH
c1c4Zf=T:B:Z6H0-1>e>?g@MdGgZ1(H/>_C>ML;MO<DZ</X;VG0Pa;U_@QC7BZE#
g_4JRK.4VAPI&7SA_WWDdeA(>GdMbY2J-Te-bGT)WeeRMcUS:5;I@Z8f9NG6502.
(BZ.K>B+EIB=Q.:cRBJR[_b5Z.4?Ra_KdCgT:KO(-SLCU+.5ZZfb5SOH3OZUHII1
aKR>?L_\_.[S]RG5^bLNd^4(3a,gKQ[,QPI?QU+R.]C>OXI=,a.P?\;9XW?5^dII
-4/J8HW2N3J;VTDHc0K(-c]U&-1cVB)1JFSM,V#>_XKWW6;-fG1_45N7+(#0<aJE
6WMDMENKO2\5D8<RM?C0PDSTDL,V]MC\1?Ccg@/6@SVMK0KM)COdO>^[:Ye],>D8
Wc[6/Ng9:;>cXE@9IQ1X]EMJ8HH[SECLWQ#4dY8JDfPB79K:QfB76D74S]1D5.6V
6P.#D9_MG>X[\#UR;&/);]2KN-b\La4?>/FKDM,M)TF>XIO5<8\HE>;OGUHZLHQ1
IC/_GCM8_37.=E?&ge7Z]#fA>0;_>DAK_d_,:e-N02;94B)<M^\bJU],bK;M)#fX
/7-RCHH9<RXaPK.X8B(]JI?J<)B(,3WCR/>ZOgQI38=ZfC_Q:@1?_T0;1KQOA#8?
/cYOM>:PdO<N#2Q0+cO>F?+M2V+M(+(LEgTdKGD\G>+#IHIBG.H(3CQMc7Z=aGQ3
e0->NeEa5KWL,(XQd?RUaPMcUEK32LGH,#Z;ATN20>e50MA0aF(&0=aQ,-(YS.E4
b;H&;,?&eK]>26LPa9X9LbG.deNg6DW3J?Jb59K,bNgH#.ccIL7OD^fF&[^[W/R,
B<R&Rd3VPCa]W1=bN-]@>3=+@ReQc7c:U21,?X4J209Y?9?,S>-X]eX4e.QE+bg#
\55I_1f@WaKFe\R-Og-b2XFRD>+TW2__#0I]_B#d6;P5&_2K?WLG&NGFI2D,BH#5
[2:(USg?N5>+M8U+I&WdYG;51P[MGUWNOY(;;H..J#+((+K,I?2bWK9VP-T)WGcB
\+XO3A_TX#CZNA<NUfKeFbF\9d-1/:2\<Y6f))B?BU1^5I:-38f=2d&U#OB&D)d5
MNYT9C554:b[)S_d:VTGQ:6ALQYgDa8P;C;QWT2[P4X#N<\R4Ve/\BRWDU6V@])1
,>QKe]?A:5R8MaVJ/fN+7ddXM=HX^P2MB1JX4FO,bPB7Xg2)&4U0YQ?WXOA5)ZYH
NQLX5BTF-2A;8>JW875@/f04,?@H;HR(CIa#>Q?M2@V,L#d9RS5c10BZL58IF=UK
aQf<^H,[OfN#JV#X8X/dH#gAM\9bI(GOKDd#W13e4:.1[2JP^>-+c96#CYS2FZAK
/PK9dXgBMIaC)[:9WTJbd8N-^cN&:(g4a^LdVL:GDEF7VIc2gJE;g0[8&7g:fW])
@#/-6bR2]U_T8KZ=@c?OJ(CZRY@+);>I-=BK;11K<cY[ADNfWZ5=-=I:<84_0I^.
J<_JE.R-(+U/R?cW56L<^Hf,;4K_YF5f]1&G/gdYH9STP]B<0L>C4.^U(7PO4Ef8
VF(@)[CR)QD]YJSbIGgU9PabH[/6+W;LIb&NZZSMGYaD32VLd5B,LIgYe[.&GAUE
7N7D<eBGMG;X8c(H57UK4M64-/1,_0/[(IM93+GEe+O8SNH\<QHLU(;W=Te5]JX4
dN(9<]6eV0G6g1XeJ.=4<1eZeF+g<.YFHgb@N;N^\6I93&R.+Y)+H:AcHVPSY(CD
OG?@Be)+dOba8,+cOJ9cO:ZGc39bI\5&9=9<8P93/0<Q]9YGA:BCRdA]/+\P)]MO
:_E^^]K=V4QV?>2RM=TeC\5N9^=aZG=:<e<J;M2V80K8+R4BG\gKIaP.g<U_E>;X
GQJ0QCU\O0\X;RPIYPbFdc5fb5Y/\#;DaPSWOZ,X:6Q-8J\OTF8^eZf)WA82#d6J
fPUOB#0PeWKNZ<g#4(>LX(CE-2#-)MG[T-AQIb@0^]VW=5gPDV,1fARCeI)<;7g1
.=@M?.)F^YKfT@g4e\Z:#^1;g</D7WU_SdV1/DU[dC>:HD4Q[PX6YR,[OY&Ee;5U
+EZR?7;9995C0.f^F;_JC4V[JIgVcTA1HVLCY,SbLPG0,E;DdX/23A@[M,)P.HYZ
=Aa@WQ4TZE7Q<Kf#FU</2JfGbYIR-[56VZ[(W6W&>0#b=(9ZfMbdL)JJ]b<GS_T.
[/^.]V]Od6#EOc3NHIPB\\IYP9V&[<OS0CO4<@<2-@LB?V\eM1TJ;;a40A8Z?NKg
c5&A,[TNdF0BcCZP7KFOP+f.FIfWZE]TB+I9\-ad[fS_SZFUb4[ID&_:\aaO)=];
^VL8DINV;SMO-WC.]d2T=]500X(-+?XfNDS37WRUG9#\>USFMPg55J2U3U3-R\TZ
4B7RG^9:UH3U9ST4b=MVY/?&G@f4,B,O64INZf7?<4f,-6)_8#K@1D^>04Bgg<>c
41S@]QX-OY,FNKE&@c@V=^Z=MBO.NZWOCcIB&E:f]1C(05@ZEHR;2F=Z75)0d89@
_T[BO9\@DfQU:MP8EC=9HZd5DQGQ8&;7]/W3=1MNP4L:E-A36U3,04R3W[,#RF_(
3WIE#EAYE[/6=)MT1_BWecgPV&7DcZ8BNDP&JDQ)GDT^Q035;QcL0[>,bfR^.V/W
#]8H?MUEM?KU,BAJc+aSJ\DXe)PJ2gc9e>cPa?#)PQ9X&fO)CSUdK-5H;a_PfY@[
.4UY47J(?0?Q_[a@R?UW^NFQ=T)[7/8ZXdR?SRXXU=]P+fO.X2KD#_]LKZ.G016_
4+edMN&L9KFRB5D^J@R_-ONE;:cKFRUU.:4SMJ-53DbB\Rf:9DRXY>Kb#4;;Y0/]
Y6J::FXZfEg96?O(=QLH_VOf-^(@:5E#LH-6A=Z)_G/PFY;-_0ZQ-Z4?ZW8J9Cd4
6@OJ;TEDJN@Y#MSCPY=^46#gX14V.-VSAQ=.L)C.2I[4J==J3[#,fBZB64B1K+8]
bD<GcI5M@TK++MP2E9#V01+8M:.CL]SF8V3EN-aFR@6D[O]C5:=)/F7>-EZV@#fJ
JUE,5<O\:UPN1fb]GB0=65gMLI-^eg^UWDd\ZcAC_;?S:B\,+]/?Q28L(J)\,/&3
=@.+aG)(-6\E>CWIV;_B-Gd-cN(Zg#>-P=c8#U.cGF)#\/#GdK2:RLCTcLMUd>OX
gNbJEe8b<a:54PaWeR?9e^_);ba7Z3B&Q;4)=<1FX.13)[[?Ogg(#&,d]B-=_@K+
:QBCGE:[eeece(^7afb6A+6.]J4cfWKPZa30</IFM#,-3fZWRb1dBO,E(V_bd>TV
6QfFF(,XQe3c;SZ9G(+JCH:e5ab.8cF6Zb3a7SbBH(@WV@L=55.?T:SE/&HXTgLf
PLQ5e9M:Ba)(MdJG]I98N@3;+;#3d.6&.f@W71,+bM=8NYSNcFbU&g6WN-=6CPI[
/^N3[.@SI.-cWXE(>_ag\D_Sd@Zd-9C&,P1/2Y4f:IB_OD7NdgF+N50dKE>0DcRA
f0DHZWS>+PD>XHKW474R;\(#NbLQSL#TFQO8Zc@.V27),UD:^4,0R<gD(JZ[+4E8
TT[N[_2YP#(/][Ld8[QJf^@?db9bYB309DbG_daIHA,\aMcUS.g2A;)?LbF7M9,L
Q8_/8F)LGL3-&Gb#VGH-7TTL5X:U(,50MG)a(G,O][.8&0gAU@7N>H;+0=S>R(GA
I/F[H:=OSg7X9.-UDZ[>T6U^CRA+e@86[Q4D6bW>PJ.+f2a7W@O&D+QgPC;2302^
=IU(a+7G8(PM^R6NGYJ0Rb#2,_LcSWHV2.QHf].791[KC8U?2PBYL:,H#7M,42]W
BU33:?J0\7eNfeTg+3ecd#QDHFII_YTJN1YgZ9I);-T;.34cBLIYV^_#_#N;F(SS
A#Y;T9)C=H4aaW=7->XHA8WBE,H7A#W,Ze(e7FHP2#2acM^9Z8E5-VO>R_27He<^
aR9[VReeKC27AdX&5>RWT_4GHI,2<E5:TN5,#1(5Qd/SfHM58cG)e8SM.Jf?CR7a
XDM@L(+:Nb_>>66N0)OC<Z_+4g18)=+LdB<O3T_1>C(X0G>Dd3EJg<_#6^<7VTL;
RYBI2R2,-c#b^3,QIXP#VW^VG-Y(JPTb,-,J2:;EFaT>Fd5BFS^EE/@UA]UADge3
g6gFL2(@@5VC2ZFb[SAb1=K)9JAK,+?5TUH]J>A+MC\+V;a1EC971DgBMIY_dAgY
IP0gY=2=[f^T/_Y-[]#&#U^?SD5IL@:gNI6U-X7^5dNTU[^@478KSSZE09^77SVT
\gC8cJ^#+g@CBI?MfR+_#K/UMY1GO1.??U8QSSS4&Sf+7M2)?)7?SR/4;2QV>.;\
>G5,#\,[2NW9XdP)/X<<96)bAB;LX[<&e&QNDW/AH?@,\G7=eDIXMWVWS0A3c.K2
@\eVSX1QT6Hc++CT^&J8^&7W0f.[I#&Yf/^=5T]4T,dU>:3,TEIeD7bc;CA/R.VR
V-7O/]_0BM=\K0\7,I91W)VAFd^b[B<\9-M:/Sf3WOX@<7P/TO[BHb@T7#<_4W=b
6OJ_ZfO1a6&SHW<M+<B]0[(6B#TPSV/;DaO5g@1)FK9MG7W\DI;TH;X9))1f&b<7
)EN4CLfBGSgVY&\,B)MH5QacN_SCVKd^b5YB>V]9cE9?acHL3F>fY0We0G)N+NXE
K?K/@MWRaQ)Q>55;+IY1N(;GZ4a.CWaXgXA&/@(LX/?7eF6H7>Z31,])H6Pd,51V
0.e=g+>335Z7JA)]W3:F)H7S[A.4aM^,V_2)6[5D24U-,PB/V4#QLH_bEFgE8dPK
H5D4UdaAX0Q?>;69+RE+M)E>=L-)&5.@YF1YPD5V\>KYRK[:8/ET5,2B84M8Rea]
2KDe^Uc31/02PF2d7[5J8gR[,BMfaM,S3+fKX6LW&L;Pg]S>#:9Q]eWSV-M3C9K=
5:M8?LCZ(N>(J;U#Ab#Jg-,<9@EcN<=TQ.gPg[7OWRV;0?(,I=)+2W0<I_O57A&1
JAX(6,+M9^RHNTb^1)V@CDOc/[666-MS=.Z9_<)GZDeCaOG<-92/cDWQ0L5]\W#c
6L7]+:FE@fZ\@f;Z+#@A5/\YQB0Q?cM1ff2KOFPVP9\@Z=+]@@2AQKZOeGB2]A^V
AUb@SW>JC#1H4c^S4LO2b?ZD5edYYNGG2Q?ECP52RHM.FI5Hc/gD+G,P>Be/(J(.
J]LZTK/=H5EL7/>XWS]X7bF-62gETUKD[eYAQ4MNMd2B=+4?eYR5IR4c&<g5K>AU
9-S&Yb?cJ#74F=>;SQ4cG(5CbaM:3bFS](@d,O<?Z9_F>Pf.L5;-#FDBQB:X&fH5
OSOgBY(d+V&N5Q,AEf?6@Y\Ncf/@^J5AaE@2g(ZX6Q\@,-:9N.Dce4F5O&AE4Fa2
6@;#^?QTSb^G<gCNEWgg_.eXCMe\NJETX@EN#C4B2BJ;^@ZO2@Jg1^FTC<-F-?:6
6T1AS3b>Z>g5?;c8D9L3(-#6/::4<6==7.OVcB#dF<D(UL]RW(@O)TLI/&/,GcCV
H6M^[I]W]S(PV[gD=XXV0&2d<VLd-:+<MA.(9M/0=:;XDcYE_B\>UCT_:K4TKE<Z
Cc\P5_Ze?3>\4)@HU^3:1Z+ZGJE:.+TQ(5EHFCM8(O9)Y;T-0(/aO/>QWe1<1W=U
b1M#[Lc=6E3A=fea:#^<:1@5JQQa,c<.fNI:BE:Q2?W<<=(FA(a1]FZY</UQ&U.5
B?9,E2fGd:bM#2LGO9#a7DB(.6E5]OEOV5_H_;0_SVWV>Ve]^&H.YL^AFQ28#^?O
Ba,61^dP::G;?[/KYBL\N=Cg2<f#29W-X3.QO6>WC#.9@#3b60QRA]3L1>90R;WV
[Q^=VS3gBaLIP]Eg2E5??&egS^D)>1]#.XIFU5ggX0)QU:E=9W97<dS3FW@cUD&S
>GFN[A&bQ3Q34N]/B30LIA?f1ARb@Ae5e(GVHG];BXUR@(DOGEbJ1Zf[bI?F(H8[
/@VEHB2\8DRI:4_6RM-f5MT&?GD0b(W>_N6V0USKg>X)cF4c=/2FL1:1ZWRDGUYY
FECN##?fgLS8G2F<Y(QK=a4;7\;?J6),?6b&43O61]#XRaB.,UQNZd#aTB8U1W/C
#V2+0aY4WcaHZJDIJ+.8S-6=_/84b&16;aOf[]UNL29b\+DQUWNb_-5Ib;eKJ71X
05&N[bQ?>fQG/#@#_8;G(-ABH0LPR]\AY#]ND_]8.)(Y3T9[2+Q4DaV&1@]PCN;d
RAZ)d_:;2(RYe<3.JC1eYe@W:WSOP>CXG<D=@Y=,@-65,:QP<M<4>DTP^U0\KM9Z
9a@9+@:DN@1D9@Fa/]0@b;>>E[bcE2=GFJ:RH_4AbU<UJ.ObN-M+C_.eZI[.f->\
K4-J9#/8f@Jf,?BRU+O</HI3-&=&_)JR;f0Ya_;:Bc<9?)ZY7b.7RBJL5U5PcP,M
6:b4XXG]Y?#CF+V/,6RE=TN;1U9P][)/<6UPWG3=^CAOQ<F1A=+YaDR?HMWL;VEF
,BBV[^+TT><0]7Qg^N&<<9AG-b2A?HU<Z],<?;02OQd>G@ON8;afdYW_T)eQ7U8(
X;ZR(9f=a3I))A&/4M+S3S?[UId09#^c]/&gE;/XD,K_-aZ?P_MM5,\U.Wae@V)[
#\N9#XVacKNH;A2L6S\4P.C>;SfFZ?1W^WfC^:8A@\0??F.J\f_da1//(/a]7b03
eOW]--G3I62NI0@M6D8Q=<)R8;1?[S7d[O_N?O\gc4]d]\VUAg0J8VIL?;DG#=)7
TW6,Uda[E7f,9]eVD95<?P\964,-LNSIM[?]E.Z4?/][-VTgO;<E(5Kf__CPZLP(
)?/PW>BQa@Y8LKO4MdP7CcH/Q:1TU7,8.@JDM-VRGZ[.-R),>.)&ffg^EKRf+;@<
.gaU.-MOb\^YKS6D#ME#A\4M4fKZ\0;0AW::)(/ZSW\)@.e-=O.YHMeRCQE4c2Q&
?U;:E4LIDXE0^TN3VW@J,+D,^.RQ5V1RV;^#Pe1#&FZ.Td<Zdaa\@\@@CeE1V,+G
^;@f+#?,9Z?Z<,@:,#7DecQd2ZPQE9GQ2,2\7UU4dJ5M>(XFKRUS4Kc7#<a:MG&)
gI)U+[YAB<-^36K=H#ZGbNf^e,e+\M,O;2WL5LeJ1=>Y5d)@;#DR(BgD,<XNIV15
2?eSQU_S5.HIF]GADD(bHBIC9_de(<Z\^1AP295A.[-IHe?3#10ST--PXT+XWR0(
YO6-GRa_\3&?:W78CI\E(#VPQ9O4CL4PR5aBaH#+2Fb:b^/-QN6\Xg4;;#6dS2&Q
O&:N[V3?-FED]WF4L,.YeZ&#T;CQ8KR-;77,PF=ZFPA0g->3&V91cN@4FJY,]/E?
ZM2.U\3BCIH5_0(N]Qa]&+gG6eY#caXU@g6O-V>E&.>?UR-]V6gWJWf0_XW<2C&U
FGDeUP8HM7:66?+,:#P,/RDSEC&/-8(76.P)bGZ)G<W#=UMXDba<:T-#gDNE)O(H
WC+D99F?M3_IPU(8#f<d#52E,)5^\bM#&7O>))8f0K;Pg9<>.RR021@#JF[9YcJH
RLCQgJ?0[6cU06)O,@Y\bM5H1:@=_MQ/6D^HecVc8=[+&8&>CGQ[N#\SJMPa1T/a
=OK9Q8_&JJDb7Y^XHe0g]CP.5g^WA>?dY3bD5::=NTI>4:6a.SeJB@_B>N@M08MI
?EaQQ\Ra?=)GWR,0ba6d2<_Z+>XOg3V)g0/7XYQQX4W?c>(6BH.^PM9Y8E-eF@d_
,C^:)b9^P/#2&F^AZ^@#=YKP1HU>B@7D/J-1#F1=2g)]/O^\#V\5R3SU/^_X-RH7
:&5FQY45][9D7RfNC<7P3LTA>-f15]:)8N=R7;#[./Y71C1\(Lb?-=>KD[0LbM+1
4G;9-JR@8@]2^R3?[\X/8->A<P\?ZbaQ1fM,==@3A:]0,.G+8@(I)K4(Bf5<dWeJ
4Y;Z^T(SL1;SPa/5\9d-.K97G4:=/3.=&BXW44:>-\RJAeF@Z/)_VG3XC;X/E#(b
eK@/9\:C-7F7dKJ/gS[D)0PfEC)&>aA:1+dZOb;18B<)>?UOMA92+JX2^RC+3Rd(
;G8SX(:W:C];f&A=GU+KHI>XTd<IFId8a8dW=N4691@WfA4bS6IWCM3(/])@J[YQ
CK9LBH8Z\.X[DPV]cG5-\V+Y4/]-X\gYUR5+bg3:\INRa)aA<CZ-G@]GBc0]a^)K
MK4D9K:D(T3R(SYfVYG58E9UM_,=dH6Hea;Z+:ZFFUPg-&\Ug[_5]6g-^:#O<)c1
QDER7]W<eRDK7bE^)6.3G/U_.-cST=VJ;Q=gMV^WOb-,UD>C3&F.gKL\fS&6=#5S
Wb.W1MK[EN^J^K@WNW1962W[I/dH+GX#NY@3J_eaX]W_WMdLf2f#CEg3R.Fg<]]8
=K58(1f-;CR.BcZE:QKM:.DQ0Y#[a8QKS&P-8Q7?[d(0A5ZQCBO-c_L7,+1B_FOb
RX8VTYW0eRS.K6ZI.V-.5.gSENA7:@6f@+ACgWDe[gBbg>5VO1Ja>&WVEdaD6;O?
:,[,2aQb#Z[4.6/789NNZE=7WZ6T:]:&BKbRYGJ@f^gAT4Zd6,Ha#T@\F1O5cX6C
PZ548UA[G#=W_d#QS-]-EN0_SH3/@4cCE63V9J1QM/?EI[J-TAf;aB.O[f)3//Id
&V6KSggEMN@1&,C&?H00VYd>EEEBS?/#N/+AdY_RDgdM/>^OYUH9/HQ^WF#/1>_&
634:eG^@2/]4W)WCC.^fW0YC4P],JF5NL,c/37KVR;f_D.)#C__:7MAVN4NJO:Re
-ED=>2HO?/1AJCBFB(AUJDa?f)T1f[IB:HKQ;UIU5F=1)Q7EK4@;_VAZ?;.)g&-W
&bZ:MSTIK2:5d/fMIS9<O)ZC:98J.Y17G=<b+Qd.[EcR[G?fLga.Z/D;2JCYCVLa
dYWFZLSd7RddNbSc,VU8]ES@/)[C1W[C5MM(0PD#;IIP[O+:>P-Y0SL/g^bXCOd7
YeHG]LBULNM8&cN^E)\,f23T(T/95Ga^FP+DP2>)G6.:7[K=C\UOfTIS\D/IXKZ9
>Bf)]3IR+fN[;X^\&KGVD3f^##Ke/dKHg++/]@4+eS/#LVKgK+U]PY:UGZ;7N>AK
e>TAQ#BfZX.KTJa:6Le0N[_K2.YK@]=PJ^\;ge&(eWM3f4ff;CMXL8SZ:e99]DRH
N[68/;2K(_f-:UZUK]#I>.SO3e8\c#N91:PW)fAZKANJSWSC&e,KSJBcI85B[N?a
MSRN0gbMUFAa.>:0f64f10+\)9WTgJ_X&K,(:Y]dV[(6T1O5F)a,b1QVJ2VIP3F6
9R)5c.eUd3fZ3;e4^fWL2Z8:741H7/deeR.)HS5gROaY@H9F[J&#)P6W]HXJJ9cc
\@@68_PAYZ<FQR7B9R>GYJ6?\Z8LU^XM=],cMR=Wf2G98O[Z7^=?GKV^7/P?#X#/
@c0@-FeO.6FCd-g<WQV/FJ\C7c4&=248SSd#O9ZD)JWR0?H9=2H2e1]RM8?^YaIf
f)->,&F?_&G0R_U9\9]7:^H1@cU=^g5@FBTJ(R>G+PTBeVf?FbI_PbeOTBXc\DD;
7OKU.fZOLNX#UVNB1A0F:ZRDBDed)G1JZMGM(IY)27_;O<e6T7P7^9da_<HX]RTg
YC7+=<0:Ma;5f/9gB4A7->1>1CS4N>-)WFR.?CSdPaK:ZBLZ[>9NeCAbOGR>K-9;
-O6A./O>,FeN#:Fbc8K;T<2-1(eVEJ&,Ccc]+1bdC+g6IV60P/+2NT>CBJURVATU
;(&&0?Hg4g9a3&PXgKL,D3)^aLe[7/SI/9d0J30gLCff;F,61X5VC(-c5VO:.eIL
aCJFA#Xf-(T#T5H;?E,Pg5J(^R5ZBRD8<H\+.)OJ(-cMGN:^_3?(J(_4JZ-e6Yf(
YdVW33\JZ0(STZbXQ1>##<H#A^6G[[>;AC[W[d@.(9C&V3>cb3<dGd;XOd?/B79O
9c2WW+D./g/;&aFBcUdYI01._[,\&)c(<.GCPN6ME#5bLH7KW3);.Z#=/,EP>O=[
QRbfK4_.3I?CM>PRf4W2/#UL/6KHL/]ZO&H6OedS4F2g=cNK9g8b@>dCV.)@V2WG
5+]DOB;N+d61L1>9Y8Y6.P4d,bW2:Z>EIH[V,M(Bg18]@dH;FF6g>@B0-D-YQ-)1
Z+UA6XD)OMTE&Lcg\f4,B2JQV^F38PA-9\FY9=(]L0]#e9#cKY3@\b;c)He5Y:Mc
58BO-FgTTde^L1P>.PM?VMgRH=F1GYM27GO\?[,HYWG@FX@HL1EG]6Xe&Hc+VMHG
>Y3EN+0(F+0\_c0DKeE2.T-gQ<4&5DX8S\KEHAOXWYHW4=S1T>3W:RD?@,&>P3A3
e2E&F1T67X?N&Mg=BRJ+C;TS<M.TVK:Y77(]V6QeP3.QgWNS3?c-d>RId3U,G=2;
Z3c;,XO,:(9H;=<e?8NGDKXOGc:S+4,]I1[0H^^gP8B<.Eb#GZSaWUE5C.>@SR[(
<0LVa-f?83Q3F\a&#/-9-.cX6.PMD&F<OL,_0e-(-]]5,ePNc-D/VL6?LIafDJ&1
)NKNZZA#F,7=(_:<3X,9G(3IH>?eaDSZ,/GM,bdD?KJ]#7CQA;0X2B1I/MQKa<Ye
c]+?Md[BL@R2/?)7:2[12X,4Z)Xg^ZF.^OL@-)YR&].I4P^4VLW<HY3-4e/&79A:
=e\?8f=EDFH28HFgW?S79C4E?M3fK=SGd;21&>a_XD.309MXUKMHC09).IP-7IeM
@@f0_^.UG)CXaBPgA;2D#R+)^Y+:H0/E/@L;YM&#:SYL#4-A#c5^(Q5eLX>JPN9#
?&+&f_bc2HV(:6S&_\5=JcS6:/O5-QN_.][+bfe^SB&Kb(E]FG>X?JH8.YbaEe@Z
_JdbZ?A?&M3+aZ,D]XdPb2Y-D=[Z@9T,3_LX9&SP(,8ZfLEM2Vd-[+e2BQML;CEO
]/Cbc#Y(f&X0FYR\67,eRK5(X5[1Q6/6VQeb].9ARcg)4#YL5Z=G6,:7C,2>@8ZZ
&CdJ>e/RaaJZfX63YGf_E2AG_ERPO=+3C=]X3DaW<?I95bL[2>cc2))cfV^99fJZ
CRVdYg)FS)QKLAPN\b=>TMaR-CB.V)@&S^5+7L=^TI8>5[Mbb:=I@1QN08_A?;6H
@X3C)aIY.5)<[0dXPLZG<fVAL0.1fO)fMJ\NaI44V,Mg8XAbd<LTVH&CON\^XRE.
;@:,\f[R5@bMS+Z?c<#6:))CDQFSL/8U#A@^a(-),,af0FQ<HV6=-^QQRE?OTON6
5g4fa&EY6RN>CM/L:V8_)0T19R2NLL68ZSN20\LH;b=:?f(M6]8^9<fCY/_Q1HaZ
_^;d,A=g?eb2_?SBgR^9C2XMBEF+d=@_-#QCBH#Fc^UQ>6OQ)Be<,<_cW1fL,4Y4
H]1d[.##OU9A5LH7]7E(e#aDX&c^N6?Oc<.GC=B+b+?Ge--#-aU-Jc3M8R7PRY]X
gG]DdT@FVXGcdI:d4\47&I]O#.gO;.3>YI],V:)KNQ,.>.FGV:K[ZR>HE=L4KC&G
D0,eg_<]05SH]?L>JZQ-2_0^Pacg&_XK5_@\P_KcYS1:;5>)EL;F62Wd+/EG<K\T
K_JASWR8?;U2d](KE,U6aICe15DRR>=\85EI_BB0a;Q,>W@:[f0&+PbYBNaDGRG6
[),g>Q05g=b)W2Y/O5#Z/H:eJ@ACUBPA\ba>9U1W/B2F/^Fg6aMQ<,YeWLD-P#0Z
RW#bg3>Y;_a69-FbP3,d,_@^Oaf:&G2A8+<IcM.UN693^=1E-70K13D3J-0?]3fH
f_SQW#DBdA:PKWW1;T=eBRI-<Q<_C_54TFU)M9_/+3J5<(:U(0HA_2S?MR.feCK2
B3XY>bD4Af8Ef5/+.#<G5@X51RDAWHdW;QceU=<a#XQKPLO-IWI_cg0[&gWH9M/9
>&)<[Da].+]/QT;NIJRCZO2@X#],W7G/eAO9#R@b4\+7WL&/O.)&Of/BQW;8Xbbf
;GK9>a>2B4V=f\_La:GX.(c[2@FP)+U7)eV_8S:G;A3de2BSW)(1)263eIR#3^XI
BHMS<#8e/a)L/\a>=#:AQ<>b:e6?aULRMWO[Cb/GQ[_(IXGBgCeJV&VJ=#AF^IG3
f(2G<WGZ-0I/_CEdF\S5@NYDeP#H&ACWP.gURL<A/L2[1VJ8)E(=/N(Qf>C6E16\
;0XHSbBCW.#UU[e/A2X5f#7FF\F4ga;8(T0L,RHHK^\NZMW+IKWZCKP9,3JbO9IT
/Fd_73IYTKGR=PA:Y(>WaVC0<EB+W3V8,?D6?/V1=S8BD[]ZTI66\OR.#a9)M1MJ
A;HSeLc,4Y5C?O_N6Oa^Ig+Ad>eXPbVT3O2dF.[_YUJK^XN-+JcJfbAF,dMW-e7\
M#+JIX):(<)a^?\15+>1EJJLOPB?fCF)M&F8J2GS[bSELW^]8-IfZQ+58H[18UQ#
8?0Y3TN>@OTd\^EfAL4N?^Z),06^LN0OZEXAcSR[9S&(Z3b+Ja,Z(+A8f3=K8+C_
g;OFGS,Y[TJWFL8B.=.>8_@><dWFW:4OSeId.U<[1EI^-W/YT:2]bP6bKG\8]G/e
\B/5<P/d;U/:ETH@G-O:/_eC5XONeAZ]b<1]=URD0)3Y7]aF5AUFP^?@8NA.Z0.2
U<b&b59)0T;.J-)_(&.>>KPbJegEF+/H2N[d-e.)(1U00-6dXC=STT</X,6ZMSD^
Le7AM#AG/^^UT8ZCPE^G^RYGBP>_/HG,99;(E-ffRD3NJfa4Q_E2a\aB,.N]/X98
G9Kd&=4D5>1M81GT<ABZ+6DCX@L4_;eY9&IM,Q@[EV2aF4bNF)_e[f4U,)M3N<X/
3;1+,>F_)/[A3I\8[QJ1Ng&MA2XD6Vd(D&D+:KI/BQbaN-AJc8P8U2HI0=),2F]0
KDE)N\&7KYb24&[EO]O\aMd(XFa/-T>Q[HX8OXMc6<(gD-ed3.Te).GA_8U1M+dJ
B=WW0@?L/H;2/$
`endprotected

     
`ifdef SVT_UVM_TECHNOLOGY
   typedef uvm_tlm_fifo#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
`elsif SVT_OVM_TECHNOLOGY
   typedef tlm_fifo#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
`elsif SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_transaction_channel;
  typedef vmm_channel_typed#(svt_axi_ic_snoop_transaction) svt_axi_ic_snoop_input_port_type;
  `vmm_atomic_gen(svt_axi_ic_snoop_transaction, "VMM (Atomic) Generator for svt_axi_ic_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_ic_snoop_transaction, "VMM (Scenario) Generator for svt_axi_ic_snoop_transaction data objects")
`endif 

`endif // GUARD_SVT_AXI_IC_SNOOP_TRANSACTION_SV
