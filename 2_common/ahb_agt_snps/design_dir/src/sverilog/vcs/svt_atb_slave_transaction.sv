
`ifndef GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_ATB_SLAVE_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    The slave transaction class extends from the ATB transaction base class
    svt_atb_transaction. The slave transaction class contains the constraints
    for slave specific members in the base transaction class.
    svt_atb_slave_transaction is used for specifying slave response to the
    slave component. In addition to this, at the end of each transaction on the
    ATB port, the slave VIP component provides object of type
    svt_atb_slave_transaction from its analysis ports, in active and passive
    mode.
 */

typedef class svt_atb_port_configuration;

class svt_atb_slave_transaction extends svt_atb_transaction;
 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_atb_slave_transaction", "class" );
  `endif

  `ifdef INCA
  //local rand svt_atb_port_configuration::atb_interface_type_enum slave_interface_type;
  `endif

  /**
    * if flush_valid_enable is set to '1' only then slave will assert afvalid
    * otherwise it will keep it deasserted.
    */
  rand bit flush_valid_enable = 1;

  /** defines delay slave driver will wait before asserting afvalid */
  rand int unsigned flush_valid_delay = 1;
 
  /**
    * if syncreq_enable is set to '1' only then slave will assert syncreq
    * for one clock cycle otherwise, it will keep it deasserted.
    */
  rand bit syncreq_enable = 1;

  /** defines delay slave driver will wait before asserting syncreq */
  rand int unsigned syncreq_delay = 1;
 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

    constraint slave_transaction_valid_ranges {

      solve burst_length before data_ready_delay;
`ifdef INCA
      //slave_interface_type == port_cfg.atb_interface_type;
`endif

     data_ready_delay.size() == burst_length;
     flush_valid_delay inside  {`SVT_ATB_FLUSH_VALID_DELAY_RANGE};
     syncreq_delay     inside  {`SVT_ATB_SYNCREQ_DELAY_RANGE};
  }
 
//vcs_vip_protect
`protected
5YK[Pc>0;ODa/Dc:A(\>S1Q]-H/Te@\/]T=gL17P[/3XX_f(E>/\7(9096:e2LCN
(W,#;,JfIXDB7P[g<IH7S2B.DCRWDTE?Uc01KZ5;]=_=cXd]gBRS\0;:5P7g1UZa
WZ.+fO29QDG+@^,W(?>:FM61MAJ\C1cV[bOT:XV^V5,#?>?1I^&=g+C87FNBRfBX
d-EI:\]2E(=EWM1aA9\Wb_KZD7?Udd(/69:\Z^JgY/3(L7UG>3,77:3V=I=N7Rf[
(O^W5BKL@8W?]DIG\1XCQ>Qb-7F3];4:OXcQa>QW4^a18@0X(Z7J3Q]-F]bg&H^R
5]JO@<EXR=JE&[C3>^Y6@C+gCHT4I[+>N:Nab+J79O=M@AB?+CXNK(GS1+N=4_0D
NNFILdLL3YB0PIcb?..1Z+,L=9VM;FB1,O@C06R6H0&TSRIb+X[XcIfXX\/ZC@G>
>:_,C321;0X]XNe3^MV.aCVg=aH90_[e4g]5U9RcaXeOf2[JJH:+Y)_Bf:O1D[=e
@B3RG8E4+O]ca+:Zg9)8XMF]_:?_ZF[MeHKFe7K9H/E(dW&YdV3D2X(g&WYIa0<>
;P7</[IaH;YXJ3WaMF70V/_BK.S3B66OgE2Q..Y5,E/U^ASagQ\GLHY6[SQ7>?g>
4gC2:O_-273.]Z.T+8YeVU<99D+[7)I\d+dFd5.B;47#(6f\;;XRNFYgCV<T)f?E
d&6YEED6WP>\S,EO+T0>eMfK^NIWDZ(7a4(cf0-V9/?M000AJ=3<eK)F=VGQ\WR>
5PS#J3<)0BM6&>)Q/+_eB08+0>PR4)EdYeT=#YCH6UA8#+T)>FGUe5Hc&0KL84,=
XKbX=+D<W1O[E_18dF,71.4^#]_;\T?Ra@B&6#P4L4GNU#5#+A:5X#PeT-&P<NZM
DQ54BM+7,+]H<P\Lg]c)TWN+\;8B/BI@Ta\1bW23OVW7:D3d>NXF9Y.XE_9XA/HR
=C..=G9g9^I-6Z/WMJU+SDU69UQ1HQ#@1bBf>3Y:XPa5H??9F<<Yf]RdU-2^d:-6
P>^R;MdP6T:>>IPS1X>ZP^b@2P]AeJ#JZXIJG,1a?=8JBcUG&=KNRbU[d80,]XPC
.J)B5W<LL,9U7/;3MW/d=A0#/GB(=6K)UaWIR>dfCY+<eEN#@e2LO[\HM4@[OD27
>O3Tc>_E<3A]W]K)\.^7_=3(07]0;dY=^Jfd/2]O8a69cd0_1d1MYV)fZ#=gL\GM
E3SQ2ZKg[a>.=[CcYX^/ZOg-aS+b3P@U5Ne#T=P8K<KN\T;7+WZZc2a&JLL;Fe]V
L2<NML]#cF0S@R-cdbdX=@gYWeQWZTH1WR-3&_Y&G;gL#\VaH9_HQLKc8Db?#e+X
P\d8N^DdX_MQ&.8MH9N>g=da9S:c3/]^@(SRd^>Y,A.>8.,@MT#,0=RCN@0FM;4^
1cg4V^WEQaWU=DYZG<=4Y:K9Yb[W6)FIf;K#eDW2)=Y:JM2YF359AP\5B[AP\9f-
)-aPP<H4>g=C1#IV,b?.A0+IIf[MgE,4THB+G7f4;8\MMAbVK>Eg^)\.B656QR3V
88YYB(L3,_JQaeJ8_>A)W<HV=DVUEO/C-E@FD7T.\F3Z2cdV\ZQVU3VNTQN=YVJd
8P6fe;YU9LAQMW4GbaX(N=FHZ2G.Q9fV>@FA)9XO4.:A]0>K(,GReC=(;UH4PcJa
1a(gbK6G]E?WOgLRfHT0Lc+X];W+9X4cUM)RN09/4Gc<cBCIOWGBb&[PPCAMM3G1
T/062UI,C3OIZ[WS(5>^NEaTV,9a_\V(:.c;/RL&_<@@>-.&HcI7XNI?8_g13=7X
d0JJ<7g4CbG)F3Pe,Y/KWTRD_RY?V/eWc;aV)Y>T_VHa\S<Ff@D)S)/,FHZDaZ9D
bG_=ePB]WZ:^7S-&Y+7MS,LOP1LN&KbbPH&+M0L3F47g>=T5eU1[b+E#P64;K(WM
1O\:ac>R/ZFHW:RSI<?cF926JNUM_MC=T:&>U5GK8C^ddMYEFT#DE2ZcaYM.STZ[
LQcAJBIV;LF=V-0Y@^^@g\,ELTK2@BNgTMWWW=@V&ORdI&]EE)H&KGW=Z)c&R(a[
-)JE<fIT8S?JQ7CQgRLOR^LL2^[,4T+Jf\Xa9.P2)9L[>f\A9CROC3QLeK\Z,V.T
(WH\N#ZL@L-3FLDVe86Q..S_TW1.Zg]=.)Gf1?_2g8TbX9;AaNbT72L/f@R=G=B<
aM<cc<#;4EQc1M^=#MI1E6Y0)=YGPVfBL^R5:Kd==EJ9FHU[dYUB#VbS]\@c,@1B
Zf\7+RY:eE^Vd5M<9S26&A=18T4]@Nf]4M1gC(00-]d(?,B)Wf/6R0_BI+)LCO,<
+UdZLX_WA0-99(\VUL_0R+C#?.1)BL7VO,2b4HUI/H_R4YQgDQAEa+PRBNE7Xd\Q
<#VW8:#\6[d9;PZb_[DTVQLe+PbBBVaX\61\R(-\)C/E0?Bd<F.NHIag^,DZ:X#K
Pf4+LA[E;X)];-Ke#17TK&)F#f[C>/IW66NX&/c-)K\efD.QG2?MQ4C911I3+53Y
P1J/ZRGMSdcM573UNVQ8\Z+JWA^SOLAK>aL3@EM&>#3YB\/Db[VJ=eg5N]Y#Sdab
C]A@W1G4_bY=TOZ>U/g^ON@PI8GG/f&V[#\b00+6[XB+X;eTKHQ9SIH5)J@&OYC,
a.Y]W-\9\8^OE<YM_a2NT8U9XJS;&HVc7]A/]1-5Y?[MEQ,+PBc,SaT8Gc>JWLX?V$
`endprotected



`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`else
 `svt_vmm_data_new(svt_atb_slave_transaction)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_atb_slave_transaction)
   `svt_data_member_end(svt_atb_slave_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * 1) Tests the validity of the configuration
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize. 
   * Calls super.
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_UVM_TECHNOLOGY
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  extern function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_atb_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

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
   * Does basic validation of the object contents.
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
   extern virtual function svt_pattern do_allocate_pattern ();
  // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique iden/get_uid
   * tification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );
 
  //-----------------------------------------------------------------------------------------

`protected
L1M\8GT>&FZ]:3/,_Y6D?bM[.PPRE]Kd2fX5Tb<Q#Ge,NUUeec4E+)0#=La/F)[S
0VEXFf.2JTO],$
`endprotected

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_class_factory(svt_atb_slave_transaction)      
  `endif  

  /**
    * adds data bytes to data_byte array of transaction handle from dataword captured
    * from physical bus.
    *
    * @param dataword : data captured from corresponding interface (atdata)
    * @param num_beat : databeat number for which current dataword is being added. (default 0)
    * @param valid_bytes_only : only bytes which are indicated valid should be added (default 0)
    */
  extern virtual function void add_databeat(bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] dataword, int num_beat=0, bit valid_bytes_only=0);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

`else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

endclass

//vcs_vip_protect
`protected
:LV@+CS[.E<MCP/#-8ONaXZ?\KF<b=gCX5K=V<K/LfGSAH6e:QOC0(].=L-U:2]G
/(3MI@=[<:)\8JA@3OfW_/bK,4R&&[N-?NRK>GJPL@77\GHH.;M_J.03?IDZPddJ
4AHV;9/A?;Xde,Q:B0:.aG.:F8OLaJA:3Mc_X()?GfR?=W3Z=(S.c[(f5)6WL4H-
BRBb5SNS61=-Z+dL9V>[\@4Z]-[SJV6.EHB:K=K4623>>f0A@CN[5]7F/ObV)c5c
EG&YZ3&HIV.W.U_Lf2YF)<1g9RNKJg\><@[U_I=O4(WEP4R>=V/TJUA,O15:PI8&
<CPJX>fg9ce4G4?V[3KAN8=+.B_];:_C5JG+6cc>#&]Ff??8+Zb7#[[?L1Bd2Wbc
MIL3ZbQAL+GE&X5d25a9L^KP5f7SYESbS,a3fG+9ZN=)?T\9gXYR/K+:Y4K@7Bb^
b;JA3N(6IfG+(^H8dFNVAQ5LEd18</.IdA/4YXK3b@#b\Y//_I035EK2IQcCN^.(
d3U?CeY<f+YJPg.R,+:D,EL+-e+;2TPeJAZ-P&>E=4CG+JY8Pc(GP3E)GXf<IQfP
K--CX+FELQ5[S4/A6(gM7VL(LZH@77HN,\Te]RFWYSfM#H-6R0:;XUOA&CXCHSeT
($
`endprotected


// =============================================================================
/**

Unitlity Methods for the svt_atb_slave_transaction class
*/


`protected
I_8-]XAG3E]E_J6(cP4?-2E4&cKB3a67,gZ<3Sc/]1:3,@1ef#KB3)f<QFNH:]Xe
0F5SE04M85eH83C#HQ]709K8ZeC86AGF,M@:2.fC)GD<[H1cd:\TJ;b>)ZP2FgAf
>+TdM0[G__-1Z0PPTVAZ6]PS74G(Y=X[9LA(7P>,G80.LA1c>(fKL()#2C<]gg34
80:LO0WBIWe1(K]5a,#O9\EHZ074MVeQZ>-;<\W]\7C1]E;0P+->0N7c)Q<CHga7
#NefLMKTW>^M6[Ec-V8PaPWN42A?/OSX4&d0[+GH>QVZ0SA;F_<N]Ha@IYVG#d3d
TL//dBY[WB\SDRA8[H_eY6.:\A#)PHJL/,Z63N,#e?0bME+RN:+LcS\=]M1cD\(A
B:[b+bOM/.f3AQbM>AII]:_a]e+CgX+B>g3J,/3/O3O14]3;:@M/?X-5Dg04J29Z
ID_WbF44M<;)CINe,f3NH7U4W-K0F0dCEJX&Z1;RXH]9O&,F&E>bbW@e1UHI=BgX
LHAJJQ5A:4<K;gdXQ)-+Wdd3:-^65(D#IU#/<36XfF&:S.]1\bYg[a87]2XKXN&:
?#>Q99NQeO;XRH]D:(OD)AK0+R-RP)15e\J2AfK3c]CdH2(U)H(R;R6#3-=dd]VN
_@09bJW0HZ@A<OaN3^NK[UK,2-f0>]SRc84]eROV7QHZURIJbG6PaKE;##)<U(=B
#:M/@K14<A&@4SEDcGQY4[91cM)f/9-JR2<H,VaeRLPg0_-Q?C6d+K.M6UPVb#/8
U1R2^]5-^]_A[;a7Fb6-GH/#3.7d=F6.AISSEV4[bM^g0fUX,d?_4J;?U:D>J7]T
J:9a]<NF?+42g5>WSNTHZg;&c.e7Gd^3T7DdaSAL?6P_ATVMY<:8FBC0DUPfD:ME
<\0_fL3ZeHZJGIWcQMZ;&&ObGAgAeN0WJ-E,9YV0KDa@;5?OX_XW>I40_6a.;<2=
<E\>,fDc,AIB?HZW6XTC078C.Xg6184/3WgRf\N4(H(S^,a8X5)605ZEg7V\f2H@
/8.(E[NYS(_C+O?T[/cEbJ&W99Na@CS#<72^P4(/f?ZLbB<^2X2-?2b-8T-fd&65
;7U&UT05&^-ggfOZ9]_Q5RdF2Cf8P?g)@$
`endprotected
  
// -----------------------------------------------------------------------------
function void svt_atb_slave_transaction::pre_randomize ();
`protected
^Ma5F:/T9a#GJd4AO,=[#KB)+XCDT]#BS1>(;Q4X4O\#,+ZVCf8:3)4P#Q8egDZ?
R[DP21cM-5Hf:K-<BHL/a.1G1/Ogc=Q2eZ(\.E]SB_Yb<e9JHCHSc[5Y7N3dQ/RC
-fb<YD@e3SG4^Se4bZX5<LMSa2b+bTRJVc>;Z5W+KGGS-]HNM@8.TNEcRe93GK;C
?PY/3cAIU5#[&T6CF[;XMPMMX/H(>(cULP0gO(#W89I34<A1:256NB]M8+dX6<T:
=C1c]YEffcH>X9aJ=V&W:PWO3O;\,U8JX0KEaJLfG37-V2d]]A><@1/Y\^V#c?O^R$
`endprotected

endfunction: pre_randomize


  // -----------------------------------------------------------------------------
function void svt_atb_slave_transaction :: post_randomize();
  bit data_only = 1;
`protected
.XH(34314^@)L;14-+W@?D\fEAN6)^#B3FHQgBdCQYN)\+7C0BQ.-)_d/AbSGX>F
S,@+]d9&<4-J6A/D(HO@dM?LUZRa/6?BKW1HT]C&-\<)C$
`endprotected

endfunction

//vcs_vip_protect
`protected
_2CGgb@P^cNE>eDAa?5Z:<X,QOdQGB0G_>IA>)8WLG6UA3L=I3Ic0(0G,>HSI0\C
?2-(&EdAg=Wg1I>]bfHeV2AQ59Kb;g)1BS2FJeVVN&<GK/LOag=OK7-7OZ:;R,-/
3[#/Y3J<@]V>IF<Fd(3,<L#e[))\P1J2a9>F:LWB:@/1\0MS3a3g_H#&QS=aaaO2
=QG]J>V,N.KY+EEKaB#-N6dD3ac36bFB,7P:5:/LZL>a0C;_IfTS6U[.L9aBRK7O
]&/N5GR]W@NX[EM-=f&bd8MLb_QHg7M_:2@2OPb<M4OA#N_84SGW=0a?.\9\VXE#
EIGEPSA9WcRHY[.CN76bOd4fE7f73[<T@<+M8Q3JHCSVe.7Z2H4349fd49\QFRLR
+XK,_(@9:K?Z@LK@-eVR7Sg_8Ace-F[/JF0_&X;3HV5Yc?Y=8Y^?c2Pd/BC7+>;5
853P7M)fWg#HT2Z]8W)0\(Y+U<AKD566N#b9JcW;#gEQB[GWRPB&Y<[0#I)Z&YW>
)=13,80@aI4L=dJ+,_ReS\?Wd4UDY:0f:SA8C?g7b[CR1S<f(?000T0UFRT9DU.4
5M>-SZdO80OceHN6b=X3C[Ue,9cYEL<?:=V@ECI(^YS[(T#PS=XYa@+J>YKU@H)E
;.LK9YAPSLE06&?F+&g#[W?L76>7U&VdQ(Ff6#J@WQdCNAD^c?.Kd^98>SK79:/#
6]&)g3>[\R1QSZbO.4b,8;HU)&IQcZ?/T?Q,DY@GJPRC-B]5_:dB2J3Z7^Q&aAc)
BCVZb_GU95;<6W1&JRL;4U#/bB50-0(MXHPGJ=0I8=K1Xcd5@,VE:RcF3MY7E1LO
Va[V:Q)-GP[&G=^<]ROK)@F,LUVCJMd]PfJg7U#5-M].R]APS)NZT,S;3O@V@ZJ1
LX0_6g2SG&[B+1E,3degZ:dF#PO+;)@^1A/T#7]A/CGV45-^S4;eW]QP#&2<F[\E
XC#)V8)&6FM<-b[:.[;-^dNK\Q#b)MQOaNU-W4I7,UD5\Aa6PNRRUY#;&K,gKAD4
4C107JG;4Naf;7TfbGZM8@U3ZY22925I_5).Y=dOc:2(C-8MVJ&5F#+ZRE9.V6-_
9N\3)DPd0/O]B=Z/a;78)f9=)ET,Yc7/f=N^#gbEZ#.<K7Z?@gJ)1T^+C@S0Q(8&
F\[cA,2L<A:-@XLdD6MMSI;>7HHJ=CY[E[Va;Q5]E5WFJ.f[97bB3MON]Q:OTd+-
b/##bC^8dfB>bSNK6=DI3-8_^MI?YCS;)C)XFCY5@)81DgPO\;VXMHGL-b3aaZ(c
&N^82L0gW1,/.\P2@5_8163d_9G/JT:b(g0FBF>[9C@R,8R4<><eHZWXUSC)CCN1
53NV(OJ(B@M/<\,/ZK.PSdbFgWKECc^E[][S9KdCIGZ)C<>UI9=6=MW?Nd2R-eUR
&X^GcX5^+UQL4?-5a)1e7a4E7gOL].=H@4(G1:-1eJA0#0QCFZ?L?dC+ObFLG&G<
;V-?#/6QaJDJ8_\V-07R-cZd7)eaC;VD@bFU;7\\Q6/&JPFZOIZ0P[R/COP;[ZI7
D:I=a-XL:F>Y(R,65T5>HT=6T:=dGYHc2C91d._9+2Q8.G>&H,0QNK/_9MF&f)+U
aZWL\_)K/SRSTVMC0/).I_6T#cd4YK0JPW6)CE;JFN1WM_6\18O1P=Y/D>(#bX/V
FB,78#:NJF8WYK[#A2\fXPLLcR8\,BRL=cGTR\PDV<40-D8=94;M3.DR2@6[8cQU
+G[HRQJC:b,Y^I6>DXYUaFG8QSS#;^DL5ZIYPK^>8IgHG.X(O\;NBKR@aT79;EY=
8.ETG]+fa09ST<a852+W<fOD6Vc+W4J3c>a1,SNM^#&aW3N(88;=92df1GQM:fHV
b\54dJZU]FgP5WdYT8IU&,K40SB9IM0dacTgAg(MJ0[Pfa9f6e3bEH/4<W&X/>W9
HM1R8B?f\Bg44,Fc6>g74>Tf7C[YWPNaUd6KC]7?F(D9D=RVEHdMAF]GK.ZR9gAG
V8SY;f[1-D0Q6A6@99.9\3Qd@:<#?g8KT]LHX9Ec0E=^81OBReLU&>UXF:]7g=PS
<]I3^:<c:M=P:82LSTS>Nc2Y,&5Y=0P#Q?Z?C?JdTI9Z/P^NSc&c+9G,X4AV6B(I
eD+@4.WZ5aO^U/>QS^Sc-AQ6MO\f9O._QC(G9d)[P-?O+-8/KHKR13RV-_\#]:.D
\V,)SOX/d>7,0T?T[U[,?,B0U\I>:4OC-W&,YVV=CUc74B)e=1;/F;RAFd-Z7^@>
A^/d1-Dc=;C2>/9V2Qa\+(g,(Qd3Y^YL4VPSDa5SDNM8&.#BQ..aYfc1.SYD8MY/
VD\:R@Z_<G1H&YG)L5WE0W3AT@I=4T59C4^VN(K&OU/K,X(?_\F1P0?b0S583@W\
/BI^bNX\d3UJW<FW9#?V[\J;4NCM6WQ(JNTMX:Y@3?=?0>c33E);0M6/&6\Z;DXO
Z<GE9<g(U1K#Ge^(5_5:]I4Qb51C8V/]WKW:=IA7Ze8fHAY=#;e>YS[YW@=PFf^>
2+7LeS-Y\U_YfS9\.]WR5S>e0MOQ#;d++:JQaPQbE_cQ#eQYe3dY#cGW6P4UY9L3
+eHd[_cVb,?YEMB2C4Y<2HY?(J.Ue[)&)/)[[Hg<<dG+8G#X8Ud2?c7cZ6;D/fPB
3RYO4Q>T9.-a);MW0aG=&:A4MTB84/@S14>7CJ/PP:JLDbeDXI\IaI[^b;^&b+XC
&aS<[<:dG9)-XQfW@B3D5[=A)4cc3+OJ6<Te?5J1F^I?=<2/J1a&X2AOZE::Rc;9
Y@2NaF]D>(K0PFa)2[X_T]2gK\)a:XX3e)FJKC2OD^c71A#RTDRCF;.Md.T[[/S3
W/:]OD98]OM7D6RMORG#B(L=7@Z6,B(dS@Ed-J6;=6MEOI1;#<EYa1.4G=b?VPc1
::.;Q-+Q\F;@2,;;XQ;.JTC95d]-SR5X\b>_F-a^/L=YBWNPg-AU@C8bM\2b.>MI
84IG5ALWd>COXW1-78b2.-7CU)S]PX\c4L,c-/_(SGcbb_(FRXG:a\P+RPa_)0,J
HG1F/1W86U/IJDJTT\9OfR,;(M)L@Ag4bSbV?O[VG-K681484dB/9RXgI.bdf^@5
E.^BY=R-ASE<>78NC7VcgI(9OVT2<3^EGKM36?(WQQ6NE#P=(W,+I7=U]Oc19e;c
,DYM@NLL-CLIfdeH1):(6>D4KTXBO@>3>>QI6]2<GcC.R5=E/7Ca\4MCFEBK-Pd-
TX>9;I[7HV^g.^aE.?L9(De@H3Jd1PIdAE=_dD,]HQ[Z:0#-#R?fY#G[)#cg[J&V
_H]JS/QTdP\U3XK;2FF_D<f,._C[Y3QbHXG9)5WdEY(JgH/Y#)^V#4EJ^F-]XaK6
4>BQQUB:?60KdR_;CZ7d9aFa.;5)84Z_6)D:d#6G>=>Y&&1ZHVKJQ8Vc.ME)ceg^
T)Y(/.G<PEA?S)>=GM:)d5+&\U-X[12:,]1)-^JZ-,:/-G;Wb_-Z9=6MJ;Q)QK8I
BMA+Ng\bQFdG2=#4bE1XNJ2.^]1LRD8O;g3=Ybe_#cX94Q<V7BB-S&HC-4d1,(.Y
[:XQ/4QL:?X:Ee5;X[)P<S&eD_7gQ=aH?QJ_J_GF_JMGJH\X6d6/0Cc[E-AMW.;J
b#)BIJTVH#P>\W0QPP^AP_MQ@PTQS?f.+Y1_M2b^AQ)Y4()a+c[)&H<^F&F:?^g;
9_O5/::WG;dJ<I+=TeYTTG)fPZ^WcUG?;67)>B58DJU]1aFI,8)P#EcF[)H5e&2c
XF2W:VXMKGW)V9>+8PODg,@^3778/<bV-EC_<(.SWE@gGWc+\W=A@-F673,HFLc3
I;[6J+<a^ZCZ98AU)f6W+B7[2<O+WR9<QaaOc0I++TA1E]22M9e1+^#5MT5?2)V&
G?6ROd/eeWFZKgb(R1<IaJB+Z?_gPa.D=R-cE\H.T9g]/.eJ6CTH(,Y=3e2U>e;K
J6cgTfCGR,1]X?B<W.Qac(G[d;a#DI.9a94@aX?N,>0(HQSHN1<VEP-4e/b,+eV<
@^W9KVe=;c)F9AIDN-B?)A2EgaY<=Kd/2I(+[bbdN(<=+]BF+>#\\Z,>HG+K/RVe
#484&,[/4I\[/6:B@S9DNC:0<3.D;cRXgTF-eL>\08OP:d:J:bAN/Dd]R8XFX-U7
eS5RZ.J?a[[VF^b8TgIa#Xgf.07&3938+RS+:K<]PK?KYW@e\,XbJ#3CVfE+UaJ,
&G9g>c:T)D&WOc.Gda)[,P@f_d2e[2M-Jf?V&&f,M_->,ZD_c#D#g;RBIAMX9WFf
JC/T,CF9J6aVEAJ;M<\_eF^CAZgS\5fe.2aaBP5XD1_<Q?)XZdb]LT540OeON)>=
GL(]HPM2/VJ=@&;:A933BV<DSSI4GS?S-DcQ9KM_OU[28c_?8dD-7(01=XLe51>?
L.1f__5^b^4=-B:WXD]_M,3T;@Y6M@@7fG,3_#@VGR,6)>AfS5VK235.3BDe\N>3
U\b7Kbd9/33,#AIF17:/8ZZ8^BM3JC#?4@XGa54V/G35,S&XV-PON^U9R(FU_Y)D
I7SR()=L-,>PaYD#V#VSC2P@9De-La_:.U+<KV@a,I9S^BW76Cd.H+CUW?KQ=+HW
[7\;6GQ^e<J+2gTc7V@C_X9]V_Oc&]_.;;/Y=H\Q0+FbEg9?(;@UK18]I12&VRS>
A6>,WXWK\aa:Z)VK>,AdAe5g8Dg1RNe1<^KQN=9API?>ATZEb/cUW:V7-R3IUQ5f
9N=^0:O2B<Yd9,EVUd^N:)4Q@b(+(J[aADd35TKX:8E#,+X5S-W/#U@[aH-<8^XC
V;e7Kf\>6gLLVec0KTC5]RX)HbENc:VDX,55-781Z.NHM>S-9J9;W[/ER9N873.[
Z)6O1F8Ud8?Y4555>VN:fXBCWe;CH.ca?6^->-2#/YbP9M<K(a?0d\TcWEDSTe#[
:gV88>SNd@\;OWV(0=D#ff#e&a=V<;?>>:8QDFY6+_29(^+KC[K.HK2^L@)JH+74
NZXS:(&a(C#DbSBWYQW:+^U(9f/5HMW.bFCdULaBSY4I)e)[bUQa=>W6-O8AaQU,
>D#^UWT=A#L>C3bD-&#[LM2KHM+&gV</AX29B@BCJf\dY\e9VWB?=4LTQ75IKb.]
OaFMB<@\bAD7&g-X)+g1&0)T=^D/@d.aYP=Mb)<aZANF2P[.,9WA)P/Ve47R9>L#
8cN@+HD-Ib3IOfVR[OQ=OH1RH3=d<ccEEJ,Dc+HABBbPE>65+J,cfG2Z[5U_EcLO
d=IeP9f+f5#,6L.CWRB.PWU6[4G_;ON66.d3M.HZ3WA_HT;5eX>VdY7>5IEe:7ME
F2MGH-&a#DQ#IVPTJT=+Y-)LO?P<I6-HDQBVT]WUaaO?XBeeZP;H-^F7cZ[B/W1U
R9.[,;dMC31b\eKR07/aeVAe,ddgI#e&K+@H/IUGPe(Wa+K0&0TV\KIXI<U7HLM6
#G[G-0Q,&<;;cJANWHM:b#16JF)D]A>\.OZR5a1dOBcE<_:NdM7W-IVE.=8--3g)
Ff=b)LbTT^)_N_==VLPCd.gg&P;/=9,4EI(&4b^S&<]9[<RT_O8FP-]_ec=.V5]E
MBK=J6TafB)Fd7;F#b:[IK?Q?TD,Z,dAUC6-R?^&4+/W/7.-gO1(N;eADG2=>6/B
9EHM79Ed4W27/4.a<&G\1.6S#G?75R/U[@3>\4e<PU@/3aDW,U>VC+c?>-A/VaA3
OFb;-V)4SP>_CBWL8>WSaD8A<EMZR(e,JC__S+3FC&eeX.XS:/UVdR-7H_)6Dg&4
C+(U@f#[Y4f3HE@?Ed96XS[\0^H-U#(HcWY@dMgJNFdGdI&\T<0&+VFc#\@#C0JH
P44/,CX>[B<,\1VQI6[+XfX=L#RN_QcB)Z5JNEHQ&Y[:N@RD4g4P3.3.8>+L(AMH
b1JMNd0@6Nb2+>ZI:Q\W/G?PP(ZI[D#CV4P/--Bd5c3_8>FSF69V^5:f_NEDQ5TZ
B[^LRBWd2AV<_9LKB<ZY#&=E9-#e.)g\/7_[S&Gg@dF5O;^bMGLgBX:6YD^Z?U]E
\.=5>]T+g.DebKLA@AGWXHO<aFN12<UR-8Z<OSD68(JT08eNZWeYPD)EH28DebVF
3=-[e[QHP[<B,?X#1-3&M5DME].OY8bPZ(g-30=KNZZfTLMXDZOR1;bBAH:fCW2K
f5AEFLc38ITPWg)RTU#V1[),33BC?Z(Q=G@CJJ#fHI3/b0[VTG;N\a@7HT+[ZGUL
/@1641cRe(@d5bC>gWID0FFT4JXAM^Y@+FX]+3Q9?a45V@=@X_]c:E?4EeM\6IJF
,Sc2SO#CQ4#[a+C3Z=-J5.LYGAO78+W;C,8-?^B5UEUFFQ,Q[]3ZRc<#)2,2_=GO
C(F>:C/I.1@gHXT_M-CIE)DG9L]22[M(&cQb#(?-)#.<N0G.BR.Q1S#KdW5,430f
?B.bF0OJF&XJT@X.OVJ2^T5Q>#WZPba]0e\G^J_8CIVfOf2I5Ib72&/VJVIX4X7Z
[:64K?FB<+BH.\Sf)XVgH5BUUE)Ig.\KO)_KV?fJA[9Ub?<#M3)eU)_9Jf4b<E<:
G0J9)\,gGIM:_T6;&24F.Nc9eef[dYT?J\:M.SN8b>B#_(OKZ)f[G2\:H1VF&X,/
AZRfD\F(=8-#0a>>HQBeE\8;/IYPZ6AQ8C8.]g5/2M@gO/;>>2MU9Q;;]ENbEM^1
CT9SGe(6DI20CPg84X91PPVZ=EEgK;5)H^WcOD8;GPE@U4B_U8b29;#0T#>6d8GL
W-bODK[R52d9>>NVCI;+&2Y_4BL.3)UDO]_/2RA+2=EVG[Pg+[Z;1S:f?,Bf\PgJ
=4+(UHX.=+L=\+J3RY4gDI6^Y8/.6&@9+Y/#=dH<N<8/JK]JfY\J;\LOMMQL7U3G
HeZZZec6\-B2&W&Tc)HM9=FY95b<,FGQ-dUHSP9.SJFSOL0]c9O_&VAHAK6R7WPg
\Jg#>f\SbHPF_F84J&7>(P[LK(HKXE#42\3e&S@)Bc+@7XTG6>BM>LTMJ,.:TaTf
b[)J46(F9[IU,C\VSW9REA^/HQ=Ra7RcKg4?=04TA4IQRePMa_E5\KdOGR]fPb+c
B3XZ9#bg0-FUg0fU3WeUbM+-\6/R&8#](@8NUSV=QZ496=L\\H2^45J;^3;A_#AL
bAW/I+7)7ZTK(+(f0FbM#\_K8.;:>SO2ZIWX,1;ATAN2)#P?WbSE,-^GIeRMA-W?
&d]=/6PIFT//+SA&c0BCYe9]f<\HM@?QCP5VFb(50H#=Jcd8E;H2b8Z,02;1aX3:
LA/8V43^>DFH3^-3gS_#?&_?H9^,O7J_1.GGgYNWe:J//Fed8XIK.>.&E6e6WQ^.
Jf\JQUCI?H2S;Za.7+YI02GYMAGGH_NS]-9KGL&LWU+XWG5O[>02.P<ff08V&:MX
HQ9]UaFJOOVI0BRU0P.Y0=Gf]>CI.STZUTId+bO:/0,TP;g3UG0O7cE=F9.Q]2P1
AL[H=+D(,/4bGD&Z0/d6]-O8:d,Vb7<RGSO\\A&]=)PQ,Mc8_0Q,7YaVM/&P^D&e
FXD8bR=HV\04ZI4QKI1A_YYI][3_Y0?4eZTJ.YJgC](XELON[)L.?,e[^KO0YLN]
C8Ug,=J5)[c^+1@#&U1d)Oa1]Z#_Z3@@.?0Q5a41a&)G+bg>&SUc2IH1/1]6RecW
Tgb&AH8K8KBbMS[+Y1Q,C3B#gHF6X+KMW-C,8P2g)0dH-MgF0E[3FYd42JM^FacE
P9L[Vg6)e4]QaFKI?bM>N/DbP;W8&RBT\;/NIAGSfASZ4PcH\IgMU-a7(5^B64Y:
P>f^BZC79OPHEeN6C6-.EW,Y@K;54RR/eD0UMa[W7CJ)?=397:.+96\9f@HYZQ7K
5PBJ3b+_c@Y1e/(^ZBN=-c./]G/_>)B@T+K&-b[^\:09Ga[3,[O#?dQ5=:..(g1G
7I1G&2X42+&#fdZ(gBX72Dc;/ONDNCX6CB51]b3@5:&;RH28Id>+>]S=,>-YFH42
9T2BU5.#8STB?U33(9&2#3C[I,7U35J>R67baVS+;7@eD[+KadI;9E0Ma840S&;.
[d)>Ib<H;Q87UH)cUS9VT#DaacQ-_X-V#/1G<9P15T-0P;JAE7e?W0f1a[5CIZ@/
PZXP=aSaZSBE_X+GO^?FVQdeJSWHgIH[5(e)e8;G_OFZGP3T><bb4@?GM=-Z5YaE
cUQM7]LG^[&H:3a:VNEbRCAG,#^-?]H8^f46<I;;\1#>3WF1DDaYQF&E3L&^;9S8
BBC7.SfGI.V@3V=PL;;\Y?+?4aQa\\X_fW-?X_HI<dSRTS.EM#b26KS:4VFU^8&#
C0G30&cSRPNIA@eJDFZ,51/)@^J=L#5:7-#8bc8GaOc&VIVT\YP?S+S7>U\2XeIV
9[J=[UF:acQ8O1;X2>B/bQ,I&TY+KWgJNTa-=WfS.PCQ4GV6<OW)AREMe-b@J1V=
U@#/3FAgU0-W;0ET9?S/Y=PJ.[#Y+fX6.X7dOB<dced.9MBNF-2?R\dQY8c]0-YR
A25c?1_J_JfGX8K0C3d4Y-UCAA<E3-e/?45C=N#d(aI(89?bbQ8Z)a.;:3_e<e8=
>6J+e+B,7@_]YK44\D2J)OAOH9KKf,MVQP:7gTGKa^>TJ=_5PDD+29fO&5c&N/07
S\M7c@a8L3\HBB.8d60[,-T=E0Tf-)0@1\H7;A@1g97MQ-(L#2&R0V@f]3TDaL[5
bWN?F<U>If_3ab;Jc(V?TMM1P5)=MKUI0f\abLH#2C-&0fM31,a)^B10>SfQ2HT6
S;Q^V4LZXY(b768)RDL]PLbWL^BZ[-2:5dCHHb#T1dQVOL7KZ6FXFHR.=.PC1/HH
DGI(TTOS<a0(7_Kd^XGJZa:/9?1C<XXX>IU23W67V1ae]YP)6]#8N4QUY?DW9\V5
E14]?3UJX2?P2f;/2COZ#&d8Q]P.DM[MK2)f1E)&8^eEd_36cec;d.Y?T=e?D+Y0
2U+(B[;,+gJ@<?;cYIK#(<S^#^T#9Q&ePJR@fMIbB6YN08fZ11I?FHZHRg_:2I(X
d?6TT3L-(->78O=Qd9@C=FDfT9)H\c5[#F/AE,U3]5fM2/<2#L?g@b?B]VTBeRQM
UG,]bEd9b=J:+W>E\c-)D&C64<+<O3,/[I,_[7SUX:M-^.U6>ENU7f8fLGM]G-PF
5W:0N2Y;L6gS(B5:bLfU?fMJ8gYV11TE=0@N@:=]JO.J^P]1fHCPK7D^;a4IH2^(
Y25Z[SNH]B;W/[]AB#L.+W8BK85B^PdXGAaRY&a:JgWIU]T2aT;90BeU8KV@)NP=
:M=L+=R;O-&W5HFR</,<),2(KC]6Be>cM@@f-DY^5GS>\D\2MP-DbFdNR9RAf6?D
]Q,6=^#&JS?2DE+PCd:aUWP>c2-2P1B&9Cg2-KJ0+VGK=)0[ZQYT2S@HE/J<DdDM
#TS\0)(_<_cUWZ>RRQ;;0UT2WCGUH=cb+[K8[_GWL@ac[?:]/D576#fMV\;/O)C.
D[<1:3^@QAd4.EP4&#G-\Qg7GJcTF&);4<:;P]EERFgfSWQ2NI9-?&CD3PCHJ5/#
/RZJ2Rc)N0K<+\OUV7X5TCJTNB1@,/(J,CYdY)?cY&0(7SEcbZ5=(]g[GN=\IN:Z
L\0d&JMOXMKREB1)1&1)7NN+BUW4\^U14J3.1M4UC)IQf.:\&GO/EaP:8<J4/V;;
UMV[S^WA-bd6VQATCN6d0Q&-JX\aK+/<F2#bT9f,TbU-N]FUG=:_:9efZ8-#R-6X
3@8X6G[F#2Xgf(5A:6Aaa?[,GVJWYIceBI6abDZOW\bYeE?28INIabV)<X;D5#;_
gXKY&#1-G+A@2R]NHDKZ>@WC&MPM?SgO/f[JP<dHg+>-<(\UJ8V<dNfDd0M2[.CJ
>7>(I(M>F^J-(OO:^LId3<g)Qbf@CJa/D2+[.MGP8#AGQ+bPM9?O^UNJdO_X>a>8
(0.dWZATGVZa1.CWWFd9VC0(4?_8[#G8Ab1ISS,<2Gf:Z#)\bN3Y89f_SXcQPD,E
-c1GPMB.<>4Pe@@;DKQQ@TOW0WJ2#ULDdC<<D7@bFI^DPGRWP:R#KX3V^gI,f@>M
52gf[P=V^MH1D;BZcL)Y/Z<N#54dV7<ODA1g>Gd(Wd?OJ:bF7[gH?f#^JJNR#RGS
KR6>0AGE0P]f31X3?g-M91W/TPC]3\)JJ2Q]Gb6FeX@R:<D8O.;\ed=O)BK_LR=B
&J+P03?RL@eP0F-5H[[O,?dBN8W&?KTDJ&N(O+>H@-1bf3&NQ+<1.E?W@=:=>8cI
S(9D3c#dKKcEE-5O=:Q30MTDcLBZHT(4Z5DE=T?=]RCFH:3124IO+KU8#ObdDXX)
?K4UY-N&Df0Ef_A+EcY=\<FY@=^1M=_)bB-AVQe>AU:543V:?D-V5dN5B?7E/4?6
_2?L5Q_fMT.+N0T&@UHYY>>?F+Z^/Tf3]7).6XOAb<cc,dJd6J;_@fDW1=O(-?c3
L2@C9_2C/LY8@R)B3[g3L1CeC+85c2.+&LSO0C>@=I[9,W[5CO4O(g>N.J<f2JD^
dS_dQ/1=LRg?UJ+DCC6_a(1C2Pc4:g:Pe1?3BPbOfWS=ZI?PC+K+KcVVEXOK#BT]
SRZ]DTg<\SWF>]f8QNO3#K4/d_19@4I3=W<Cf&E_KX=f0:#\2+R&F&(T5._2EV3T
8fd?_)V-DB:b]X_:3+b@cIgcK6QWa/&WCV@C9]RcYB\1f5SP@\bL2^D0=F6D0J>U
T@GXN&(cK&JF=egfXMS5Gf&E-1(]]@B0J?QOQA[M?)fDU9<<L_D&NNV/V_B<XHKK
M<=Va8TNY+XYd^c>\/(aS07VY1@MRS)DPQX\P&\e(gMK6\_0,>PH&;(9b<aUSDMF
M#URRVO+cW56NXf.a:2]FM7gXdS:Eed.+F+Q9M.AN3TS+5:g--4:Ye?UY=/]T)R_
g?R+H)eB2=T,)M36S92O/\bFcS&\;a_a-OaT<R2g=6-Ea9:8&0_X9)-H,6^O=B77
E::[7FMLY\G1#]A0GMA[-L0NeLg.E^_b_K(E+<T+-[2Ne+DSVa&UOV^VDLMX]HOP
&,De4N4=.TTH90IV[7&3);IU0@KS+DE)J5c-RTYFP_B2-Q(a>^<cb_4D.Q=>\cg1
3PdY)_4E&:8SF[d0VfWD&PY(Mc#;Y+CD91SN6(H3ZbU;+7G2+fLM2LJM#4@fXd+,
e3&d^,=(<JeaON]8@_@:(I:],P\bgJaG/;dQUXa-1X^:^RfU5bK-./c8@S.][)eC
(=>\^J6)HeJ_B</<G9f?U<R#=34VVeS363Q>LBEa,[0;02PW(R/EZW+Ya>1]WREI
W]9aQ#GdY=-a@88Xd#ZGH<G/^K;?7HU/S08T]&W&1QEX^UW4#,5H2/TD-)5L,IN4
\.V#M(]3ONH?<POB6H]RUHXW&-B>&^JYI_(fH,2Z_HH&9J<dWgT&JD69,DM.#PV<
@KSN<\<=,&_gXb-2f\Y=#YgAS?@SG,YX:eR6L81gc]P_<Qf>G)PQAXZdfIT6RHgI
E]T0-LU6fT.P43+bf3QdHBfBL#(CcPJV_Qe:Yc-Q/#Z)[V-1G[]_G];Yf+W-c^LX
dNIU:Sd:fP0Sc/f]b11ag_0WS8@1+F/\SXF)L)<c);RfL1WZZ(&LabGICZ1EY7JS
\.b#G(aa#\]6g<^/7RKS+E1=2\OAC+R4e4]S[B-dcgDBDb;:ZUfXEA<?R-7c94VO
5-Pd5-&TB9/Z.YT8)CA&46S4beV(d03SDU8&],PH3d#X?(Z^[XYSBd68cCFV)^,^
V,KZQ6>P2AK8W2deM=D;L8?JVQDNcbGZ&73E3G:\/g9?Q^FE/QCf:3b:)-[.WCJ#
?/1EaS(1Ac1-IX/g[RD8^eeN&-:f,3Ec:UI(E9+N]H3EcH:3ZcbJ\M:@Z5,:bMc:
EQ+R#Zb:SPfI6Z8@DfdN\OY.BA7d24&C5bUQTBZgMWI5&^8:/\2gO1>Z<H.:O\1K
5_gEYPTY;I=YM6<U0=ZaJS#[<;S4L-6#--]868#(^(?^Md?4QYX:aZGH_7PVK(A5
-)[8cSePHJ;3FNJT5:21?,Cd&V_H4(+_0[.H[d5W:85P.5\YB[+JM=N60:V,&-O(
_\(>UB68T8Y\FTK#0Tf/Z#\JYKNPP1U,e_6M6=cFe?0g.<]<eP(ZUD<)_Ja9A0&5
0aaU:e-O2/WXK@I&MH-N6N@L-W#FLSNb95FXOQ]I.C?CKNY@;#J&)##Y1bHPWIM<
[Xa6[f.GDEW;ENfe848SbWPCLCU75J/XSZe5@WXJ,e>#c9PNf?1eRbUAe9\B#RII
Abd0HQ,DX_A(gfAF(2@\/eZTH1+BZbP#1bKJ7[dSD#S]-IM.ZY\5fB6S\TedOcP0
[g9UB5/1e<&3a4\HD-J_UV.aFY-#QK8</7dQSb2>5CEcKg#5I6V]=0Ud<25W<eB>
SOO&0>@O2)Z\;NYW\VUE6-.e\9Vg?QG45V_:GV1\&GWa4S4<GU4HgbMQO/8A^.d:
0gc)Q?bM[51#T0G0bJ7)GBf\;PA:;<<UPJUe88=/=(K/CO&DE\(_(9+/O)/f+>C-
=Z(U27bRWY=dU)cGT8eW;d<,cT&S26]]1V?e<@\F\I]LJ[OV_6GD90S@)_bC(LST
V#@J1)BL_WW(6f7+UL(DY&A:?GMK09_@8(dL67VVOQ]Z/]H2M2c@SOfgV7_CcX/c
dA203ZV-MN,M7_XdX>^(GWb=Lg^<H@Q?\dO:.)W>M6AA_C[b.BIPb2(?eV3Og9Z&
1JG=Z)PL)5Neg00_HNZ_@SWR\c0d>M^VP&g(QO<+RES-^JA^?;EP#G88JCBb3WK>
W)TIIT-^ZW2//bR0Q:SbM=VT2)8B19137O=<7;;PCICK^QXJ2L_#F#,,0ab/2Q-2
OLD5bX_813g/0V&cW<,G31:W0Y)V]Fa@<5464gbB.Y@3:+d#=SI8@a7f<^MSe7/c
d.=W72^6&^?9/T7c.JMQ]K6C>KDQB?>c5?BJ;/_SP\N//?0EQ-a[ZVXNLN#YI3<\
A[5M=]S-97AO2=][+cAS,1IT]UV\bM_7#&D^Z3+gGOXd\+T\8M3&N_[O3=RaF6SU
,+bK8HI,(2@\OR):PdfDR^UGbFf6F0;3>TOUPF]?=5OEX-1R6.5Kg3X9@dNCN^&&
FZZVe)d]Z0HgMe^d\:3Ec>a,\,N_<-9RU1>6bB>2D(EAb#aJLaBX7d4KdOIL>5<X
D5-)&02:W7XbN0]P&6+2=-B\XJ_N-LBJ;JCWV2XM]#gCASE@V6DCQ]=88_(YH]:P
@DWO].Aa]cI^?:b[#]cQ2.Jbe-_L^X?dT(/7.V2bU5.R)_SUc@2=6ZF4AYJ::e8I
<JLc5D_,,GE<NKbWbC@R90(IP4:L/#:FN9a?Ie,/QR/F+fR2;6^2[E?K4Q;7U(RN
Fg2,.2,R&OdcX[f=E7Yb=S>8)9ZT>N4+IfV56D@7YH90+TUaaWB_0Ua2M0ET]^9F
9\@/T/+1EKI_UXEfS[=XXa:(=ABNBZDBVG62@5Y&[4.L;6,M58UgaLXc/H(QV_]1
.^6ES&\/5:XCd8.\GSSVQ?4GPC;>:JC[Vd87@#E3OZ?MBMCA<EMKTU5dH<<>@TR=
QG;0eP;]T1[;N^PT0V10^;FD]fN(C>B_XCd-=50;Y7N7IJX9;#W5D/ePRGW,/>?G
U/AGg[CD+&#5-5MWd;W_/.T2&(^c]X9F7bbK:IS96ZgZ_0,Vg_d:]S:#C8?38I)-
9&#Jf=G;=gYf8,>?W6^-[CNDf^(4VHR(09gNZO2)]TeVR\c5<KT:)=cf(>JQ7FbL
C>/+aXDbDLg\56c[GY2>[,GN9D2#aeBL_a+\#^39^H0LaKBTHZ9:CfdW9HT>HROQ
Y=#Z&#eT#2M=N._^Og=dfb-N-&_V2,G37O)X:[XQ,4M;B4+#D\QBO:D3RP(:H,dO
?X@;Fd9fVZc2ZZ;^QW=)BP1H/CV<H0M?&Q)Z7KH3CTC?4HG5<eXH?MS]CVed3FXY
10&cCI3dc>NIUNLVW-L@]Y5@,1].DSCb_L0(+\)0e[:?c#aEU66R)]X5#DgNRLEH
<2I#0\<?9TRFE#DD@30eD+RCTaC>1.SD_4U5c@V_NTG3@K15c_3^UQ;/CUDf;[64
84=Uf_[^9S>-0W8:RBPg]d^3H5\cU1R5QNB(SP7?X;1NfZW->O2(+:4HLU7XRfQ+
E#-@ZD.Z>BWQ,@Z+KbM5K/IP^aCPP5-KXKe5)^21e\cVPB6CCA:UW]&fV@Ne:N?Q
B@V^Q(N)SH1EG6G0M8[W\Q<T<9Yc2DNeNT2IPVWZ\gVAb_DbTgBcWRS@<.LOLf0-
_++2bR=<1FPRB1O/]E2.T5g6A5M,9WR3DMaCPO.0:8M4>I_/a7-X^Y?R&BP2/H9b
-&f-2;IES8/Z+(.Y0e(9NWSdc&T91#ZGb,TDa>a;,_g=D\W]H,C3d>2HNS#SRHYV
PN?H0@G5H(5D2=A^cHCYN+M]F9I]2:31/.4_QYbKcZK945?a8KR[P>[U+BAI2V+H
/XFd^\dQ/VSXL#J[R1^G:W57>ML+.93X_c\I\:EZN.gfN.HT^B+9RO64(c>Ecb[=
FCIL<1=bO>4B<Q&ObF>U<7+cV?>5I)TO2@C:JdLIP(\&eKL+MI/7Vd#1?]V?9.cW
6VX/.2]^1^L39XH/B)A.,cLV<K,/8GB+[U<Sd.)1cO_P;P+c+cXK+f;g,2FJ35Ld
;#(/XF:#C+R=+\::WcBDDA6bV:\ZdE)TY@GgUN18JVV6>GfIS1?0eA(eQLG1DHUg
C+TNf00dZZW1H#F-0X<0aK\[\(ZeC4EX:Ua#5Y=6C5eB(\4K>3)9(S5_KSZ2PF+L
(M;)Qe1Q\Ze^.XGYEfS(SYP2@bA&gE,8[3#WZ]OCdC=4fP&?GHa1e=RK74M,gPUR
>OA:5:(;Z4KFY[N=B^NMYJK]J]_SBR1)LcCe)e<Ob\C@(gB9fRceeM#.5Y;B15[:
LV7E.KIRFT0TNCLgM]O54ScfOG/-Q9MIU<\d)a4+2MP0W?8g0LU_#(-&?f;A@,KI
Q,30U6HB+bbb_,:F-I^\9@^I\S#C-H.\2V+&_a;/]52YeMPU+Bc2A/S]W0+dQ,>K
2AI;J_-f>aR>-=bQ\WRCc@d8.29\F)DZ>a_Me)?3ZV(D,fBaFTI_>^+[K93H)?,1
UB@_9NF^MdgT+KbaQb<:#6^\_<a3_[X\b#)H:_E1Lec,4Z<WPR?F#0JG_gML9?14
+8W==)T5fVRe[N-\G9Y//(+8V-K?+G6[Y4#0eCVLRE2==?1^g@4(P,=+AcO4bKgE
0K)(fCX-ba(0/e2@E@&c#(\O)?f.^L<faA5LH^5[^06GSR\eVGIJIaK9c<-DGT0&
][@e0-LPSJF5XMJfY4T6R2K47Rbg>GR)?cR_T=31KQcBfVc(-BLfReLGW#Ig9/RY
V>R6McATgS#2G9A/L6HGA_L\/J9N7Yd:;ZYcP@I7(<DgaeSY/L.FI-E_3QcM&Q^g
KWS->I29OGeIb+R\4Nd^-@bEW19ZgPR>GEd01aI7bBYd>GN4K&KZ7,@:A)H+5664
E6+88JCUW#QUeCYfD[.HaaE[M/NO:>e#EQUR[WQ4?)FLdXHQ[2>A[47?C9\Cc+_?
-D:XLfJ+JcOS3.C?bZZcT&R<53.FPJb-S(Zg=6^?=@+g2.B\()MB6<-gX+T6bY6Z
-M.DQ]\&3g?GC5c;a[4Q[J/1CLB26YP+XE>f+a-[Sg3WRZO;[PJW^ET\c7>[VPLK
3[E/c>g>9C/8^)JNQ]USU6K=g]@2^7\G1.+/^S3W>5D1Uff0BdOa=N\D0-JHb\+,
?-/.=-F977_d-Heg<0C2HJ3Mg<Y3#LU]/aU3?IO/7,S\E<I&FgfHNQ\PH[F7b[MM
A8^X)V>67#JF\XbQ)^:&^/J9I#JZB/#:CbCTS3Xf+K^S_[C2I/OdCH9acTJC_,a7
62eaC8F&I0V^1EAS)\D:J[=DHMe.@+)DHV2)d@&O1a)f19GP0gHC6XaG5^HS+.?X
WE1UD5S6<TJ\,<#6-,B#1QXS]KO;6;\-YAVaSbGNeDXWPdZE&ZJ7\&-3?)XSH^H6
RQD3CQT5K[C&V92-ND/3H2:&g(1Dc,0Q47bA<(\5,<AZc7A8C)RF=L(#C[c/I<:b
;1PJGgA)ec&4?9ce)[(<?SYK_H#CT1/EE2.UOAd1OT19D4;I+./,#)\dMJ4-2/QC
KXF^P\V1W.]+e9P=dT<VB/B:dBV+aGFGZLCRVBCSK/7P)AgbA?_=e@(cJC-ge4F\
a]].f7G-Y0)C+?d690;?.S&-+_YOY69EW:,,_6^_ZTBd<Df<@(_E3\?K0A&E?ac-
11J@12Df:44UN:b)EgfJ/MQ+_?@4Sdc2\IU54aK<@ZdN26@d0,7a,MgR0>b5>,:5
H]MEDH<B=KfE@-(2_aOC>9_.R_a_-VTFA3A4C)P8NRA@A(EC,3U^dV7#^@@GJ\bG
[1_4O:N]b1CQZa;3OF-W7/JYaR2XBN;4ed@;dHCdfUMD=/6a.;[(Sd?>NDd^^\FM
Ec6d\7&df+@A&=.\;2/SA-PJb_e+Q9PDbff-RZD198ZG#UL#U@cg?5OM>^TT)]#b
^1@Y9?fD\11IAGVg::P6Z^d,f,ZgMg@(ZY\<LH\:@)c[@3124Xbb(QT&Y4.NWcPJ
7;2(Y5O]-IWaQ>fd]OSgg>5E&F.DN\&JSL87C5>HQ2WL)D\/S>F[c;]D>Z?00FeB
QXe\QK?K.[:YP9U[RdZ>9^4d:B9ATZ&RB<LD0U7EA<g-;-ABeAX/Y\e87PKMGUO8
E>,?=9++g,+dW)O4HI7@3_E_VfU/=[?HFF@UcKQ,UL5,Q]&ZdB@[C?g=9:;HC&PP
aaJZa<UUgY\BQ0_J7.(>1#c]4aK<U0fB<L\UbQ:SaHGGdG07-@--3S:,0IaRbBYX
@GFYWK#Q[JQGLK:RG3#P/H0XLX7VY7I.U\[9SI7c_:SD@+>6aPNNX@^TV\RK?</W
&C/Z<\8&-(]&9DG+VfE)0d56_.^\A[J+POf[EcNFZ#>eK[C_2&?N8V^E/-^@A_AR
59XVd=-20:GB9>/dKD7F_?aSEN.=O2-SE,_8O2O^DU2Z[=X17:2A^HG^YgXYa?</
9P1/RNX-7Qab088#>HU,ZS[L_X3Y2OJ(R-BJZGB9cU\gT=<VL1C5V;]SR>H4\S+D
\C#GXf4IQebe#5<N=KdT]U/;YY2W9J&^_HdPM>?U.8&4W;.E(3XML986?:X#]FMB
eAWU]PZ,3?.XF=PS&^44(A=&TB&JYc=Be;0>F1fJ;G7->:,RgQ+CYQ3(8cH:U>0@
Kg=E>Jg_[/>GJX^K/9_G?]N=IGgb6VH_cK=e>\SAVfTg&SGWTK;^GA>^&OV:K.BZ
X]cRT\QQ6@NQS5I:8,@E4?gD68CE8:AT-S5P1CJO^UFX(/dD#?Ma7K:7B4U@QOb@
7A>;I9KTK8JXd2c,#X#M?)cc4X(0<Db;Y<-VdF#6#BS^HLfS25@STVW2(D\A>:CU
ML+5KG?C./@bIZ\8Z\++9GS74E#50:[GL@d4fQL:,[-F0a(c[e(8(Y]+D_e0(\_7
:W]1XH<G2Da7gXIP8N^b[F5S@M;671VN#<T(X\ZRVf]4=1PVH<VE(E45P;/\gEGQ
Tg0J)FGW0IRc+8dO_IbU7./e#K-_S,-b5-56/T.Q+^J/6W75X#TU)ecLO>TbG/FJ
Pb)_)a<72)3<O7N:T#0,R97OECS::D5.3FSLgQTN^6Q)E5?,V3R+BPK#0#O3>fG0
+Z-cc,S?.1M>>/eFUER@3GVE=8O+]b=Be&;-dWfdP65(A&OZ/0YG)Ce3Z,7Q\DK,
U^KgS1_X.Se\J7D&OMK1&KQQ6MCJ9I?^1/VTQdY3D+-H/>>&>;73I8<:IW.f)^59
]IaE;(?ad?f2Pe<RKK/?V,_8<d-T.<GK7]T(B7WcE5JNeZ]9#LaD89,KNAg4^7]c
B]FZF@HA,/E=8)B6g+?[[T84.#-\a?>d3a(T][T0J(>VG<VGU1&I^0Lfb)6=6J_:
I(7a]b],2XB,W42_<a#?VEJ)CN/<;b_C#-./-90X>H>P(B+Qe4]g6gBID=L-Ie_C
C&/cPbMH?Z&[CA60MB=g]aT\@H4g/g:d&)4);YR9_,-0\Mb2c)&cf,<E1TMZD+aS
Z^2B.SbH^J8>I)aXBFXD6N?RVW@RHG:LT4<2M]]fD.,[E:]PKC^(@3gM+BBP<<c;
G7?gYK+0BDO5UTcAD]ORQX;LVd_(#V<274,W=_G4XGgO;1:/E<-.O8I+d,fJKJ&B
RJMCaY-2C.]Vec5?@;5e?T-YWeA>^eTE+-5HS9LHIL^@Rg6b;0KLELe/J)3Fa_;^
#R<9@YS>W<g,[^NMC^<1aD,.B&6dVEc5M-X-<3-d1D[Q[@U5=(:Q+5]^39-<S6/-
e\^ACS=eD-IGffCC1;AE2LD&@&<c[J?<5/N?WG9K<IZY.LPZ]g/C&-FOED0^a\a2
]K\FFLJO78<^STg+Te5SKdWT@]WgIT71;WKHM]]O&835QfaT.ANU+JeUQATY0e[L
UIS27EYU&70V[7>/>Tb3DZ=V,ZaT5H>NPJQ&67H<MJ-&6@QdWaZ/\._C18X[.gbe
9PTT2:J\e]5#3g7f>I_I=LDTE48KT1a1]J=QJP0W:3BQ9CA>6C,.P8V6>KF((=55
)29NU-@9WW@;#_O+aeFE[:).L0^-3G_CN=9AYU<.1#c7Q@O6bII=eKJ7AbHW\?Xb
gSFKa8<8?9AR;SO5FAEg:M8TSZFD&\[Dg:Z1WU.H7b8:7<Q;b<d7WaL)FKcIL;LC
]9]QM(WZMTZNGH5;])XN&^=X@4W=[\aC<^\d-@ADaB(]f>e8\,V-MaJ,ZT;^.QBd
TH-CSaD\@3G8A#b?VdDLY/E^aL]X@330AT\S=.SL@YN3\,NG9E_]dOb0?fZ]]L_T
KFTTANJV.&cBe>(bS?0Y+a;SU]6(\(8>#eT_MBZZ2cP+(28^&KRQ8_GN0B#.cJO(
D&K]HAJ)b&MFO3JX2HC0C_1aSe]IP@IS1C6]0/ZNN+,dYQdEed(SKF31[(C;.ST^
+S-GcM8\XfZa2\:dML\V(P0#[W?MCB@^F0X>L7VU@>_JQYU9BVZ<0I,@_>5W/R[e
:>?)gBcO]dQdDVHU9]g/.70_CH.cQEOf#YgR-;/U,GKT5@+E_SJ_2X2LIgDbB.-a
?g:3LNAMLEXU/9[G\bYVcbBBFPBbR<01&7XTBE[&:#>G+TDYDC4B5]Q[YZGX=SD_
^Z#1#NVg;[=04>G7:We5c:0c2C.@1XALV..P^EZ<E3(JM,T8U+&f_4/0GK(TT3gP
JO=Q/74T1P,BKK.EHYX.#^c@4/OU9PHM0-)?:N2G[\Pb?f-0IK_fe;5=^Y&WD:.N
Z8G,,bF3F.[&L;CgB/\(3JPBL+=952.<Oc;^5&87=MQ>;DAQRUW@].#VTW2HMZ@[U$
`endprotected



`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_input_port_type;
  `vmm_atomic_gen(svt_atb_slave_transaction, "VMM (Atomic) Generator for svt_atb_slave_transaction data objects")
  `vmm_scenario_gen(svt_atb_slave_transaction, "VMM (Scenario) Generator for svt_atb_slave_transaction data objects")
`endif 


`endif // GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
