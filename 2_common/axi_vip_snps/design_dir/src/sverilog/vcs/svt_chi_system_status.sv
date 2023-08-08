//--------------------------------------------------------------------------
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SYSTEM_STATUS_SV
`define GUARD_SVT_CHI_SYSTEM_STATUS_SV 

// =============================================================================
/**
 *  This is the CHI System status class that keeps track of CHI system performance metrics
 */
typedef class svt_chi_system_transaction;
typedef class svt_chi_transaction;
typedef class svt_chi_node_configuration;

class svt_chi_system_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * Dynamic array of svt_chi_system_hn_status objects, with one entry per HN in the CHI system
   */
  svt_chi_system_hn_status system_hn_status[];
   /**
   * Handle of the system configuration 
   */
  svt_chi_system_configuration sys_cfg;
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** timeunit string which is a combination of the timeunit multiplier and the timunit */ 
  static string timeunit_string;
  
  /** @cond PRIVATE */
  /** Timeunit multiplier. This is calculated once in a simulation */ 
  static int timeunit_mul = 0;
  
  /** actual timeunits used */
  static string timeunits; 

  /** timeunit factor for calculating throughput, bandwidth in MB/s */ 
  static real timeunit_factor;

  /**
   * Variable that holds the interleaved_group_object_num of the transaction. 
   * VIP assigns a unique number to each transaction it generates from interleaved ports.<br> 
   * Applicable for interleaved ports only. For normal ports it is same as obect_num.
   */
  int interleaved_group_object_num[*];

  /** Semaphore ids for each interleaved groups */
  local int system_sema_id_for_interleaving_group_id[*];

  /** Semaphore for each interleaved group */
  local semaphore system_sema_for_port_interleaving[];

  /** Semaphore for all the ports of all the interleaved groups */ 
  local semaphore system_active_xact_queue_sema;
 
  /** Queue for transactions from all RN with port interleaving enabled */
  local svt_chi_transaction system_active_xact_queue[$];

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_system_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null, svt_chi_system_configuration sys_cfg = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_chi_system_status", svt_chi_system_configuration sys_cfg = null);
`endif


  /** @endcond */ 

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_system_status)
    `svt_field_array_object(system_hn_status,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOPACK,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_chi_system_status)

  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_system_status.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** 
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Do print method to control the array elements display
   * 
   */
  extern virtual function void do_print(`SVT_XVM(printer) printer);

`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

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
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /*
   * update_latency_perf_parameters : Calls all latency perf parameter updation methods defined in HN System Status
   */ 
  extern function void update_latency_perf_parameters(svt_chi_system_transaction sys_xact);
  
  /*
   * get_latency_perf_statistics : Calls all average latency perf calculation methods defined in HN System Status
   */ 
  extern function void get_latency_perf_statistics();

  /*
   * update_inactive_period : To get the inactive period because of reset
   */ 
  extern function void update_inactive_period(real inactive_period);

  extern function void set_port_interleaving_semaphore();
  /**
    * Adds ordered transactions to system queue
    */
  extern task add_ordered_xact_to_system_queue(svt_chi_transaction rn_xact);

  /**
    * Tracks active transactions. When transaction ends, it is 
    * removed from system queue
    */
  extern task track_active_xact(svt_chi_transaction rn_xact);

  /**
    * Gets the ordered transactions from the interleaved group id
    * of the transaction given in master_xact
    */
  extern task get_active_ordered_xacts_in_interleaving_group(svt_chi_node_configuration cfg, output svt_chi_transaction ordered_xacts[$]);

  /** Gets system semaphore for interleaved group id corresponding to xact */
  extern task get_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);

  /** Gets system semaphore based on try_get for interleaved group id corresponding to xact */
  extern task try_get_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);

  /** Puts system semaphore based for interleaved group id corresponding to xact */
  extern task put_system_sema_for_interleaved_port(svt_chi_node_configuration cfg);


/** @endcond */

 // --------------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_system_status)
  `vmm_class_factory(svt_chi_system_status)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
]c2##+0+eaT)J>XPYDFGZURK<[I8&bN=C87T;IGgQ^CS><2-946@))V#8J2=>)^e
OAL>FB_<DKV8FS(.N[=2[U+fZ.aN)gY>;Wg6?6@OC+Z@;<+>9Cd//M+Lb[W9AYXZ
V^H#(CS<_W+N3[>+fE:@G-#9U<aA];\<)-F?=J=>0Y^)G\NW;4S5dd3ba7CUOb/:
aHb2]KP>AIWJ4H\Y,65^.]NW,:Rf74>c7e4fT/+#XBT=XAR+P9I@JQXE.47>5DPE
&-K7#7PVC-98#.fZLH5O52Cf,V/ZF4/[F3@0/B;.._5J83W,LNPEEdT@J7>)Ef)d
S.SO56+<F.Q4A(gOCc7^8RT<@5;OH25I/_3>-[J(]>aCOPH(9g>:ccV4e?=O/:a9
B_0>6AKE-]K^Gf0YV8c<#QHD[YH0WJ^TZ9d2;/2\\JEY^HGM+&GB2V+?/MRH;6W[
EG@4E+/cE[eCX;\-3a?DUddeWK/_9e?\Q2A0;YegI9NFPX<(LCRY,ZDQ47&+U_]G
83E0-GLI.E\V_)e-7MMb8Jf9ZRD)V\]&,+&Xg6Bg)RQ\BN[,<?:_LCb]6>/f55a>
H6e97[\_Xcd[@[;#Z1H.68?H7JES+QB79L>OcbOZ>+1_I=E1V-;<-0gaETaC8J:.
;,CVG?88@[,1TNc>]=M;@31&GW_fX.U.\Y>,IbM2UeEf8UJeB1ZDU\ea<(GTKB0U
;2OcG>LIM1=1c)1)ONcO8ZKC0GQ?76<CWFX?EZ[\)W>R6;.XcC64F[;He2ZFJ@eW
)H<HBQ#IKg=_N0#1f[8fD2WYU=eR4H+@Qg^\AL8=B9HeXa)E4bB4[?/]^DAMJ3BU
#VNcC1^RD;fYHc<ESYS_+G.D#MW6P+E(G;6D]a+R9gGZ5^>aDPSdN/0VY)+PRT7A
T4IM](FTB\,6-a+NIb222W8A<9@6NCAVAdIK[B24SbIbQ[O=)Nc]Od<&&^+-QK4#
WW9\JBe,EHD>FJ)O:#;Q1DOH:X+?T)af;dK3[BX;#KcaEL7eP5EO8&#10_([]24J
)Pc=dAJH73KBX0F;=#G?W9AXG+&66,]5P5X_c5GW@U].#:,/RJ8BV.9M:ZLR=NVd
FIKG@MPEB7&,,\<Y.dA6W^RFH;^P#VF+D@I7OFQO0RQ#:)B1gY2;#&:X08YH?G:(
3FcP4#.[0)_R;A7)8R^bIZ,Eg_Q;09#Z&\K1C[QL5b7AR]5G+5-D-#e)(/bQS7d.
\d9f3OL:P;TR2]C?)gV0>LNRXdO2GQGZ#CG-1F?(GbCB?&9T;>[->L(F3^(SR,\,
\1g4-\;.gWb#cg3<7IU4)FWEP4Q,=6IgK;#a#YLUB&Uc]]1J&A@b_f5_@;CcbIdf
]Bg3<3N2[HCF)(bdDaQ_NC>X68NN\&.(Y_Hb8U^?NOHK6X[DRcab5KH(c>UD=<OI
Ie[7=77:[gWa.\RfW(4MWAZ]OSTK=+LMaWF&A>^]QNU[[RB5:E1cGE7+A31Aa-Hf
d6ce)\9P]@E?UQ.8V@VT(5:XJaQ4I.JYVQRdV&/1T.=W\HTbLXVbDTQDGe49<+H8
OWT([[&54XU6[ab:BGcHc9cL1dOK<7\&I\^FX_;LXFd<WQ25P&C731O&bGJL[&f(
,DWXW<:Yc4/&+@D9]I_F?G9\#P-/1?[#+PS[X9XAAJ\5]2,]AUdR6WTF[gHGf,Gf
Sf+I6?YE7YT9(+K,[>8Ze3AM&@6<]+=B.@1&e8GBEA8KUVA4#.,ELa8KFS>2IdX@
dP[N<<2)A9@Ecd:2KWLRe<JBZ-YS<?6^.Y@]a]I12+U&-[,\_@4+.cEQ++5DaPbd
L=_ZgRP6IBX1&7ZQ(XK0.)\034e,cB,1H)X][W(NI696/PG_[W[eS])-2[(X?a8]
8R8A/KfM0XE#+H<W#.)&47)];^A^^MGeKFKBWS1;)b-dMRS>gBLA5.fS&eP5,A(4
&N(cBHK?;]G&eSU+aGMASU-&89/H-dOCcYE):@9ccGP9>Z\FA=MfCMBI[gM1;K&Y
VP;IWDY58Lc,g=AEC@[1_EC.2bEWD.AgYWCa+c/g6+f?QT+B=.H3LfeNW1YZ3/N9
W[BdOVE3cg/MY>XR=1\fWTLUAZ9-J]&91BG3;(C@AJ?bdP495\QNHT5UC]_<6H6(
+3fT]^C6S#,^Q@_HIEB5)7\PYDD2\F89:>+X>Q]C5>^Z]e(@0=BVG>aCBdUV\JP:
>IWD12K2Y:&_+R+N787?;[VYNTX:OFB_^6I,TKWU-YIP\FO.ZU(TAS0]f7.-Lg4)
K>Q3gF:aK3XB-@4B>EJH)<=ZQTIIM9W_M3A+DD<S<NR5T2^/;<Nf&/5I??)_U-eI
)\^3M).aD+7aEGNK49WDeSa3#/Pc23a/LDD3e?C2VX6P/Lc796=E?,Ye.cf8].3,
D76BdCc9SN/VFYD#L;>TAeT4=798KEETW[86JHY4U6L=N>W@)FaF)&4DNb\W9)UG
HU+.\P#DWZeBM/,d3BA+>RT5):LH3d+3f?WO3C5?E)2d6Z)/c2/0@\GNCNL/7^75
^G;,QCbP+:ed+Nc>D/0Da?)F@bUG7JOJBZ6ISYL48Ce8;L:g79/]Z/f8LG,:eg^(
VRPR:7:0A]?e@KIC&_eQV1/9[_#1MI47T//?cfS9J?70b00[N44C;A7#/06^b;OX
UKV90B#c+[;^f<,95(:6#PEOCN#/#^\8[(W4I4RNB-fQ/8=dPd@8eL2g<MMB9GS1
0^@d,Q=YARc81C85MKcJ?DNPTWeGZ0d+Z\22,ZD,?:4AcQ:^Tb(6:_WL&>2&:b[?
2=aNGQB=W6d.2c?5cGNV\-P-(.8YIb&c_\)TEM)0@1CA02I7dOZ:V7=b9PE71G^#
,+AcT:2ALfB>8<_^3,0eO;HSR4a5(IG<:XdaWd-f-M=WH,0[[F4TVTGGICgPTa<9
M15O#1Z;Y8YH8H[D3K1FY&d:D[=H8<B@PZZ=XgIcH#dX_UNCN&3)J1?D5Rd:2N=6
L39ZY_C#__KI)/K&EIIFC,G=Z_/#O\-c5-KN_W#BRb+?Q1=>dA:^(YZ]4ZM/HOWG
Gd#]RT(?V^?,O:A7</=843Ob;9NfLW[>d4-&LcS<V2XWF5NS&PG98M[.GL=EHZWX
5G>./@ZQ3]UT2[M)[f<^^g&>KK8@)18e7\BC8g]V.=DV5A^<STDPH2Y_.NW;J_ZI
15X:AR9&D.HE0&@T^R36#.3N5AbCI<EeYE@MF808#=39)F#dfM;[K5=c&IY9fIcR
O&F018P&3f2+Bd/I(LU7X>56Y>L20FR#ZE3H)W..>(5Ha&bYD2W9>/0:P1>@Q6+9
@?D.TUBY<Zba9379SFH]QLM4E4(1O&O^Z8J+@Gg)CU2W7E/W,8JdP+QE3:09D-.R
AM\Lg4<-_dAW\H@cfa1aWO4AWb@NG8FfL8#>+<d18-bMRXF463^\Td_Ac2,4X4#(
bQA(U;I.2^8DSPU-NVD?/,4;>OU6faKP24=>1O.WaWCg#JF.ZR;#NV(.eF0;)ba/
ER\YC=R/#@(=5&G2b,?[H]9<PVYQEX2E76[DB8N4[dC[;O7HA>fZf1(-G+/OYfa<
M(LD:<P?d,.58,e9[d?Ke=-KOfUJSg35X(ZX[D+B<:Rb8cWN-[R0#,cD5NQ.T3Hc
T5:fAB42(aD<?;3ffYGJ,5E@.#:;@OOQ/N,:C3_Vff+^Z^g.fgUHYQEWaC4RJ7C#
RL_@?&;BY+ZQQP7gV0#>N_BG2,E17U0[fce=:eQ&&Uf.=B.I.b5?EceD/NLeG[HK
MJM4PY=N2THXLYX.b#7[U14f3gA,BNEg_->YVJ289LaTQgD1_&+g^VUK7bA2M[7c
))S<TJYRW&:HDOadf=_NEKUIW]AC)LeL)g(?N^PRTd9eQ#\gN6fb0/4b.a>DTFW\
fM^LF+P59PN7b:5LM:#[JW_=/T2Z8KQHA(BHcEb,T7R+_2PY:93#NQeEbfF?02#\
fY0TGc7YL4<]8KV-/,+WR>6-\D:Q68.F1f:^-Z0=;dH:\C3a1.TcYgG@C<VJMgM=
,83HFH[6-gRET1AWM-6[fMEEJGQ.P(::\&bRRE-\S]7Je98HUD]7&e&H3?K2QB6\
ec+a88YfC?V_27SIMMc^RKOZ1(gZ+L+4OR5.PBV][AY,3]8-0XAX])0cY]Lfb>O1
65#TU_M[?db.O.7^)EG:ge^O19aHJVE:bT;2?=dNS)4_JTS7]8T=G<\C@5_(RR,N
F0EGLb(?E8WTN/;+O2X6XV\GMO[GeL6L>HTHN8W7(^#g1&V447PY@7S-4>+Oe6\[
f@TT&0Xb0G<I.W0YJ>.\HE,0>8Z_0@4?KF8bS+N=VBQ7b#)S;7\:.X_HFfcGg<1a
QE]&gGRCVB?ZO-4<2J8T=89+8aWQ9;Ya#A?FTX4NN0L&U)(cEa<:7E37eM[e08?;
_#W2/WM1+MR)bNfTgVbVNB-4MBB/,X#NMc&2I2,/M[Fc3fWc_\SF2_F^b1b@_fU7
<E)?&#&Uc(B32]:e0T5+U4GWf>KNCdFAHC1_9.S\UcVgJ/a>ec]J<R\Ee^&8Eb/7
L_0K4FJgF6.&_79R4Nc&,@KZaX)M1S/QQZN^X1Ad=e(PA^K2PF3KTV\6+^X<L17G
c\(U9V+CQJdF2AQ9R>3),XaU&7=;5ab@^?BE=A5d##f71Yf\<e]&0+N?UDYW+g6C
@#/Y_@J>SQ988#+F_;5845d&//d(QHOcSbAR-4;_.,B><NYRJ]JKgW5ZWEZJ[7H(
bK]&3/5=7&9/^Y^I]Z.\SfQ5Og1@2JV3Ce05;6_Z4+VR(Jb8+(-21;Q]7+_a#6&=
?G,64CRCVID;\5:cWdLZX.g,&&eMeS\^9JcAC+#_S4f#.5MG]Rb&IX&M=-KO;T?D
/Q7^PG/^Kb2]=ZFYLGc8.=?T+.2b#;EW2IL9PT.-M6II8ge#3_T-NN7KLX6:D?_I
,?0]AX@6)WM3;-eV+d&0Ka\[d4(^4B>Uff68Og-TfGMb2IefO:E0#Q7EP33a77dd
MCSfJVV_/;<V8ORg><Xec<+/c4+T0L;C>$
`endprotected


//vcs_vip_protect
`protected
7bV>)M[VCP[:e[;YYZ2IM=@XF\8/Rc2]VZTf@/T]5-UdI0>71Z2\4(b0TRU9+4&P
]4R03<U=B]eLUW73ba<X4LB+>05>1d:;X>Bc@?VQ@c2VWP\?)?[#X\JbAF-Ab5.^
7J?QP7PBX[K]DK]Y.X/L-V6G>IZ=DV\4&V_S,YILMLI/f\L9CTM.U,fS5#PFZPGG
+K[V848-;>eU^IQ;GU8D(T-V88088HG-0^N1gP[,eIb8TbF/K)5eXQ1N4X^Yc#4K
e-Y+-.J:?+22=BgD;P0XO3/IUC9#3=>DKCNV404P9=1Nf\\L;Da]\(99X>>cWIX#
#WLe05H::2C1SW,2QJa:KZ,;560O<UZ9&+eVCL7^Zf+7)e_-YBbZVbfNVVFP8VCT
cIbaJ[R<.:X=(1T,R6I,H[N-:M._?He=4C=OPH.6e?-2A6S/C+P=GBYL;6+0\JDc
<e2FA,JTN?ZBc8=e)6;:@dfD:_L@g0<8.:V,c-E3.B\cC:Q?GGAJ=>0U?C]aS]?^
:dT>=/V@13S5HO6?:<Zg\Fd(WP(^K/L1;@dZc=QS+b+._+&8NT5[#eDS>V6H^<Kc
UAG1O0GQBNBMRVg_^KB;Be[KAU4>HPQ^VVG/B-OdU,]bWc]K+M53RRT>WUMI/NQE
9X4[E2M>Y-UNO32+O1M^Y,Yc9Uaf]#Ua]@eYQ&82XQH^:XUGMBeET&01+YFQ63EZ
\#Ad[36;.AMZ<P27H=58]\AO8>UR47QT>O9RPcF\Z<U7fJU:?&L4RGC+P>_;E)HE
e<Nc(3e0WZQKaO9RF2I]6Hc/SF117(]Y-@3^3a(Ag&&>-32L6d/I;T=CE]J3I^-c
5<Y6e43ABcLL.D0Jge+[^L1KAbL:<0MF<cWPZ@Q>E?DGR[V:]R5;dRgJ-/V+]85g
#4BK1T<<3Cg4GRD9\P.L,C@c)(2+7<a-ODfC?4YbQZ/]:@L1#6c@)M723EdP&c?K
&UQPeO_@Uea2KZ@D_91#Ef37S+6a5VD/3aAd/M@-4W^W/K=_.-\b1C-XREMU9DMB
(X^)g&V7<=&4,6QYEAB;09(0_;=4R8=JM:eM6PTS?1Tf/Y/^-Ha].X5-e9\Y5P+_
V==:2<9U.CVaMA?DI,b0;YMIg9b>N-^I=(DU]/R1E:<IUc;YB4ED2K:[+1_8N.M&
;7^@D]62:D)DPMH^4@9Y4T2W80&Bd/[8E2e/R3U#8b>N01/].P=g?;O,;T-S9b6_
.?=fA@IQ/.IDM[8YN<0]PSGS4RfUKg,(+f=d3@@O]-4gA-V.G,LJBIBHR^GHM@1@
Zd\b&WH]RKFH/6YMG4\KAaLK1A_L(?M?[K+RI0)=.FS3D/U27(YQ?VRYK[>K+88c
a(C_a1/gSN;GO2G.=c;f3\FG;#-/1V\DA1&0,^,Z]PIN<P8+..K?H&RDNT;Se60K
\9MdZ.aA[A7EKaZK9E\dL1\EOI@/F126-B1dW5(Z:=^(J(-WIL?0EL:LZ^;_W@[-
.6,=S?--91<J#M=T8479aG>J-&_2^Z)MJ@[UI\4De:85Bb-+(/<E#Va&WSH1B8_T
T^f@TC\N.S:OZ>@&]4WSU&Zc7SK+O3^NWJFNWX43&3]R/Kb8=3@Ea,5Q[5+Xf,I4
XP:CH\_c5A:]N?<-;[1-+a@1BU8/_6)>e?Q)Q879]J72&=2)Z/&S\a[ge_f.DNRD
PEY),d>N^79;B7[78I>a]gdF;Q.A)1I:YMW77ABb)&T7&5T;7_f(NZ#WU<)_6LP6
C\+N]#>_08cX.@MPINT2:^ggY8a\3EI\I1f)K2B8=e</b.;dT@4N8RO(CPedSa)E
L8?#0E-VXA<:P?SEI35Da)Oag=YB]CeQ^V,YaSHZ_WG6_H<M-C?\G0W7SEP?RPKd
#T52eLdK18N[/Q@e25Dd(0>CTUYO\KE:G1cb[M[C-05Z.OeGHbfW7dSVAWHA>[?E
G(_4Y4IQHd#BC)&3)UAV/>7]L-_@;8c<QN1SMCgOH@3AE1/](SOM?HVWUDe]dMO6
ZffG<N[gZX#R?13)JB;d]EfDOcC_?LDGZ5EEFId@O7<PY33==&_2=.Z&<.-X:c4R
C&@ZOAc#:)[A1T2Rb>_d/G>0(W(E2f./.6J9W5EfIQ<DeU:[MfS&DYggB]M@&61c
)19TR(Cb2QaHHX=b:@2<g172S4G5_(Ic&DLS?Q6e-_]U^^Q7(25g]+:3LacDGD.;
fgS726C6d@0[+cM4:cI7DZe55g?W^W.82/O9Uc.@9(PQWg2Q>(\AdEOM.1-JSOPB
AF]6.^_A:,ITZg(V-TQT@SOBY@S_3P)Y8O7gQ=IfV5OV[ZR^(IYPAL(AX9Q=&X-Z
81?KVD(<acNNT2//>;W(OTMA)0Xg3fc7U[_.GU7Me13,18J7[MINDA\V#4^9QfWI
McYDU/(/0<c5[6g>7)UO/UF)M.V]U[f&O96N;C>F.f;K]44NI<#DEB-M#:-U;<F[
=;aW\BH?\4I#/N[N(g@H/\,@>&Med@8GAX1WQ\E@,T#]IW3c<GG4Y,L/(8M@=G3a
;K>d?BecX]IZ\W;:KDYN05649VAL@P:Ke9Y#QYH:?<WF1_9R9dHcA<8PdI;c&ZDB
eN3.XF>ADU1K&8@:YW_]9;1PO9b(#(-BAgg#I]FO+UHF6+/.JGd(b,J=\Ea2-f4N
VMM:1A^(U\?ZFdH]g,L7QDIZ<&GHUfA04]VPJF-:6FEC\GFEa77KgLY3ZOI1bA1F
,E0Tf6<KVbeWZd)ag^fD=Jd>K5&)O-.^+3=X)LZV,(-X13]\_5fMLFe6f&@>WK&4
0FKTb5AUB-3&3f=C(^Hb425O8#,#,+1Mc&dFG^B14MUGV^0;ZfM]2HJ-]=Y8g8[5
IP,9Maa<7aGS_(BL/+-X@=gPd2Pa,&9R6d@5?D86DBW6V,N]1]X8KOIC)?2^,;b_
8dW0IKe)NecF1b(&A840ZD2\)Y-BV74Ke_N)5J7A;(bOM4#TH5GL@SM,bET;)U7B
Rfe[DAF[.[9?4Zb83+8FXT:g1d<E9(,[M4V7Q>b8SRRA5L@VgZB=;;&0J+#]OO.:
e[4;GC]B=d3eIF4/87_[<>V.T?Lc7LIB2Bd:9cQ6CN(4\8VRG;=29[4C8^S0&NYC
Bg++U7d#Kf:cgS]X4?]Zb)]WA/30^/?^\<,8JXYUHUIEaRWG@NLF3LXENOI^-^C3
Y\]XAXQ4_:TZS/IV4+Xb>COId40E_VC@dcV:/)-&b-O5MP(I9.:Q1<_LTUY6gL7g
LFO[T_Z/;\#/S\5VQ]_fUCYcZV^JN179_UccHd8K1fcF[a)KL_/33N;VGcD;_BS?
G1^WIMMMd<7_fT:Y,Z=U+>U#ZYbbdU&3JQLe#8JK>4FLUUc#3+KNRCfZK/a=W&R#
XZHE=87H4?=^>&G8cK>1IN6)^,PA4>?N0]a1\E6b@9SN3VLaKJ>0@Z>M/1_b^L&(
)/b\&I\=,OfI:)#_C3^S#S3fIP,b9,EN6#Z]<6=YE3:@@b@TZRSCbDYFUg2OKS4_
/8OaJ5<UO&@BX,T\IPN9cYM<:Da#4_?P_9:QYS<B7R@TWY>ZdME4M5dZSD@Uf>3d
Hd<XU+&)R.LIP5]@C.[L_,?A^#5)D(?c>KC1e-DQY<?e<=Oe:_SNDKN_N&#9&][+
.GEUb;84)O\1@N_]J3?CP4H:\9S:6&O87]AGM\@3b,87U8,10;b4SM].F=UXb1NM
8@T][0U3^9NP[Gc_(XaCTW-fJ6;>IfJ+/&?75M9eY6]2\H9G3IPc9-=J&d/@7:CR
R[d7.0OBdTO]L;GTb@B(N3TS<=9/+R#?=c<5eF2e/JLDX=a;dI;I;Q>V_\[U8\M9
:J^#M@>LAI9;^<D_O53H>Y1C<&>G?bEKV--TX:)DQf8QLSF.bBLTcZP-O&E#-7f>
PYZM<1=2JT0dL[AEZ(D_X6G^@K1AO\2FPRRWYVNdRg_+_eT<Z4E2:P3@gR@3=XG7
&NPf.-YS-ILaJBG7ee;6?AEa;EYGFJ7)J-GT_R]?XG7c;B&bN?BA>QB=OI9LOI2P
?2A-86g)))&WGGDXPYM#ab+;bM<RSC(JPU0)8bP/K4,T.H3V6OO(ZQee&E@<Lg6c
7WQ3=D56:J</@RTLSY-30E_4.#eH4@-7(aaRUH<C-A3afO/2;ZQ:ZHA#I+ES5?MS
W0R-g]5dX;>2O@_2a.Y>Ra5[b<4fNQDF/g?+[KF5NW_Ac,6)FQe,E3DXV+:K3f,O
1]U1OJ8\]WG[Lg)Q&954HZB55@F?M04:Z/d=H6H@Ae,]I?OcWMJE9?5W/Da@\3YX
I_X;:EOHedJQ3QdOE3TMMU7/eC@FBQ9F8.?eeJA7;N=&4HQ34e.4SK(UH8PF/5&b
J9(,)^=^gb(50P+A1[)U-SO6Q)<Fde,4=9I@)Q-f#C8_>:43WHV+cX(FUTYP;@4W
G8DDLN@),JNfT)<1#>bZ&6f1#3QZYM^?GY66>;FcUacS;Sc;e\C.[S_#G@U:MBO\
]+BD]&2YeHFNLTVDY\N72RDT^3VK@&\b]_V)?)]ED2_1PGY/)11W\F>FT0Q#B0I4
;\2PN1:?Gg3O\9BeFg-R_4e17MM]G:5<JJZJ9T1SLF&(ZQe(3?34fL;\L9G6+JL&
5SS=2;Z)OE_g#<O.@a\WU]VcU;GV/f>9E^??bQQLVJV^7UXF\73:fb;D;9V8UO&g
\=V1@&4,[e8E@9O3]]S]/>6L4gT#KDK<Ia61W5OR\<E-,CP<W\f7J0\g6;Q8bF-H
?eNSaI)Kg<fcS15eW&S:.dc5S<,B78]#D0A7<?X]aeL;?M4AIV9(ELeQ6:(;V]Eg
T5c,EK/e_@@H65E=g_>Z:TN>I;Ld1T6OLb8MAC.1dY2OdEQ9gH6L7AQ4,4\/dd8U
AN/d=X39<VSR>fUbf=9&[Ba]+C,g4IE@(20M=/-Q,PC:B5ZZ;EMJ;JLaF;FB>J\U
4@5FO74&S?^Ic/ceNZWI:E(/WRDc9]Q^3QO?;&W66c[<T/I1f0:7SbU]0151KU##
e^.(QI(V&-).(M=SK25Q.Z0.L_2a3>)50?99b2./-M,;FHd.V0^V?fZL5J]e/8M+
XK.XPfbFf9)a[V6R7LE85?A<M^C?d.G^_RSgI9gNW@bMT=CBf5YeH[.a)@D4#Cd#
O@6W>E9gJG+Jag^e\LC2WAbe<ZW<6bSHMK^0H_J?a1SC[#DR/XJ<(KZCR]0KG=A\
DAL?1A0>A]SVR)KegHNBWZ/[FB^:7a,;AJHS++7(D(NV-f<4@Ef._VdJPBdeTfGW
aX<f^7P_.A@ZA>TV+OD4)9F63A^.eEI\6RB6@SI>e4.^#T4bdH?+](1@W4YQPQ3,
S\9:+6LB;73Vc5>aF347#ed7b<+?C,.-LAML,4F.2G9Z]1Q,?-^Q.F,(>/dU8<,e
cYLQ:^1eWdR,a,ccXQ6K@V2[PWXg(bC1Cd/W?^^Jf)WF4ONHB\F)9>I\=A#WeaU_
3DE2N0ZYZU4:bAId<X>[=@,XDOTF(g?6Re(1OK+6LZKVD]VMP(JVf-]CTc.>;#9F
-D&LIAD+d_J4U?3QW[6+^SKTI;)VgKNC.)9)G^-JB)Zb#EMe4B+O96SG&P/E;_\.
9+S=+NG/b^RDGIeX_4(LKEPGV;(AX3QD1bA(U[P\GEG/d&Ga45e&#7?5.bUI^RMX
70W+AE?=N8X+dCG+D:1P6W_;G3XF&Qc+MQ=bLHH:(5Q08VDX>?+3/7TE#IIK(B>c
R&Q,fA3e_+S;9TfPA7\.I62]]bHKN[N]F+2Z]2<V(JGMV>M8^A6eg=dECG5X--8Y
;H,<OgPTMI\gGE7A#^f9X7<,2U_7HH(\X.]@;QC+_FOLM6GTZ#-O[dD;FD,<PgWO
_L7g6O[D=4?=)INEH_],-HGFZO:3IbJ9GX_S-DFYe/G@ca2/_44fT_Y)P<ETX4c=
\7^U7Xa7F0f).Tf5/2FNcaaH/RUb8F98:02]4QfcYRV_S@c&#(X5>=+gQOI:d^<,
A>Ia36BRQG0#CQce3dR>8-MW86((06W1M2QY.>WfFB@+3T36=TfR<I3UX,-GL)KH
=DC@cAQ+_WS>,1&T3QI,<&URI;&<K(XeYOV,YG:\T<H6R0WF4Rb5#3F76cF-Y;1I
_T]([Cf<La>gLNgYD8.Y25ZZNYU;9WbHEb4>>PPX;Ifa@\RcbJ>Z[M:6P[;#8=CE
GU6bMf[?E\6E,X]:Gf](dQ2?.5+]0E=IAS?](G=1._d.\FZ:NW7^:BecA\P[9R)X
3YJHEOU,=T&g;\6NQc[/:E7G.(cF:SF4OMY4Y\YNWaO[]EQQ2BJ#&\57,_.[0Ye)
IgbSJ[b5QS\6=)G9@M<=7_,HA_6@,O7(@f+_/S/)bd<.LMYZQgI&2&^QQ/P0aCH,
JR7Wf/J\(NC^,KG>BSFaY0f@ZOG#A;F8dC.QCNe\3:M>WeZY(4=#4^F1LVH2=a<P
8>Y#+CIV/Q-<IKAf-cI3?5;<#Wf098NQIMEJM:-/ZB=]/WD[>S8/M-;GIH)PH2>4
2c/EcR(?H\5VeSR&O[2D)IF.9OI0:PB(9e^;BCZ#g#&69>BV9We2aJ6:JV>74R89
3[M=E=T@?cQ)U6=)bDgYcRBHN4^62/;H[[4?=V@:AT;1P<?7NZ>J9D/[_+6_=EY>
bbbBL]6&D>@K4OQg3&44>G_&X:&cTPA<OC>1-:B@9[#>Hf(]GOW>BDZP]^Fc93MJ
N>+S[(+-ZMd3C:WE?EC_Yb8KEC2F0934BO+0_(L8E:5M3,gYQ6bRN[55,8BO\Q>C
f8e_6;U7[W@1O,2e_/FXHBdQK9;L6#fG0\BALgQTT_@B>:Z2>3F6?>)3++B\9a[S
bB53A]1I\PdTQ<-R&a)KAg(Y/1PId\gc8De;5a@N.=@>84CR2-?Y\5<c7eT^:HKU
)<K^#7TLE62eJ26;2Ib;6-6]&-WY7;MFT2MIRNHUS6=G_N-a3bY_aL]2\9?/31:g
#?80D;a71A(J\QbNa-g@&>HdCILZ9Q#Ab5e5=NNN\2.#(ea/@#(MO@.F=GQg2Xe?
b<6K<AMQN0@SgYF9V622Z)3AK,R0C:dRFR82g_I;J4\(64?:Ee?0;[;M>(:Lc1[[
643UaODLOI[g4<GVI@;VFU7EN.[ABL2+)?Gf8O;CZc;fBf^:=DDP+PE&)Gd=LF70
Vbg,WCKIbeQ@=[?-Ea+E]40(<TV;&HCQ#1MYf05LdA:NEI5FcPX2Ya6\9SX5]d8Q
7^8a5.>TQ_a@)U^dO)\KHAGI0/\>Sg2^(+L?-TbU(X1/S&WbPK7O&P<gA)g/2bX4
aRb,:O?.bOEOI2^0gIOgdaJe>:N54?DRFKM2J.[KXe_?E9P8,J^fZG>[E6BQX-Bf
Cd0/C^;2=3Q0(J7g\EL8>A&^f>XNf7dVDg&]>/D_D]O@K@SK;_<_N/0DV?YDO]XI
I<TX)b.(UN+:^SXC<BSK;&RTH:#7P1A>M?IK1#[e]-[JZCUR8N])&8\)32JSPbC6
Qd)Le4VBH@7W<3eUJdW9H8Xe3+3ETEL_+(+@N3AX0Fc&#=V;[F^>0CB[CGd0^(SB
ZEY;O)(]G[<+^3T5I6-;OJ;-8BZ6&Ng2E>QF)(Dc\[S]?=IfIRAgY)c1d=P#-Y.(
\/QR;g(I.3@.GEOee=D^cA7Y^L_d:BR[]U:;>S]CR-B6U2:Ib@gUTe_;XgQYTF/F
.JaSZbA3dg;NcL_d>J)<.([97cJQE]&H3f9H;;U_RDaSU=/S7VFI2beP\L>]G.^A
(-F^ED6YRA_#5[7WVT/eP,@OT8?]dGg::.8Jc@P0S1@4V/)4_\3JFUg(J#8CF--4
&WcM>d]=G2OX(Za<[8VQSC,RN\YeML;[STR:5&ULW[]AVBWPRbWL+CD^E_FQ1[ZW
2A9<?CHXP5bUL:=33M;^HV0]NeL@ZH_2AXAD/I0>bfSRSJ0N4M9B__O4gC1LSA/6
B8N\>I(#X6ENE@W;G>:16S7T[&[;U3CQcbFE+Z/5HK#W)0f=;_4A<G<0bfW#Oc\D
5QbdKY#]\0WNW<TO+>/KRg@FcV=XZb&TYMKWC9c1fbDXH1TLdMORPG&3E+d<&;;#
P]g11E:^+OG7f):_2>Kg:@Q:U_e\[f^eS5gK]+ZgAa<?<&0+77cL>cY(M6DMD&TT
Y7)&33B,\5N,QVc+/8KSO5#O3E@d7PR6E[;3FDaJ2?31MOc7?4Q>G2F8C\-bS54C
\F^P6EOa41c4QcG/>V1A;7K(\)21&&d5R5YW6-^1\D#SeYF4EY#E,XX,CdVS:#)+
]T;bWTgcOBg)IEdQ=EYaa;SCLZCK06M0YQ/O<=#F^Kg0RE62IWJUIV=KY;I3PRO=
J_Q^&[TB&/LZ/1]>f9DD:I&aPUO>UP9;AdH^[?g4,JeQE>CMe7E=E8-7#R\-f0NB
=]XYK?\T?2:N0KaeJPI8g.TAA2#@P2A@ORG@d7(W\[2+#[R3MAa/PH85>EdeHJ-U
<GOQY9CN#0]I4<;63D;0:S+-@#PC/B<043D=EIb+&3)6Z@22#X4[R]041,g/gPK8
&_fP56:LYd;0Y4(W6F4=eDHKbT.QIN0^8WJag8<aQCGSC[7Y-9Q8E[:B@M\HS11N
4)HGB=c+ON08?Z:bAN#5(=YK9KOCF27SX/,&+C)1#1(B]]9(>c)KC5c^8#7b8QK#
Ja[?&?0\,#5XfW(M28F(a^;SCPgJY]P8@FX),f;2RLIe:96M4.,9cb5eW8JD2R83
6B\SFY>;CSM[J#)T]RMYf@]^+)G/b&Z?4cY^R6YOVdEPHB#Hb4A<5:QSBP]\EY96
(-UG7(3A.:S+#>72bI/e.U6K20gW3O3S[5]FYO25/0OSVcb4^PN_Z;</90(](9.X
U^a,b60PGMWJS>I[bH;_-c.<74/(/4DYPFW/H,F-e?_BD--G[N0C@9\c9Q:a#TE)
/?QfGTN&#:NY7\D=@L??/eS])HcI=:SH4?)0Y2JY]S;Pc)aS<-&KfK?F2XAQ0OcX
-E5VC6C:];U?8de4T#,HP?^\WU_cfJV(=@PLV_._W]7cCFebK_2?&WG\U6[OUc;K
3(W;.,0X-;,0P9#H.g&U6?,-(;B@QdNPDQ1XXeEI2@aF\eB026\Da7K^TE#cGXNT
.4NIa[eIC]?KONLA)eaK@aM^I&OJ-?;<&b4:Bc0(=3EfC+_F+8L[/K#2+=C&J213
W8/F?B)YOG+g1UF?bPK>e.@6JG+<QGPe];W>V)dggLUMWMaJG>9/R[W#WDGB:[>8
Te:D^<5?e7;8#]S(E)URO<.@G(#QE\]9<^WdX3(e;F&#c.^c#=R]]CfC,++.L-/T
CG=@_?7V8^K,HRc,PY0UYMdKPfK7H5Nd=6D7C>6TL9(?Z+>;.=^^RLU5-\>KNK-@
,=M210&Y<<ICJc5Y[G9ZLRPK30B)I&P,49dQ^L;C[NQg6[A4/=3SIF?EEDB\?>=2
F27Hc]S]fN6<:N.N#M\gSEJH2\U=PY?<Ug^.K^]d2.M?V5IF0,S^D7F(8\I70>H_
Mc)UXJRGXX.1I^E1AX8=AD4.c.3=L2ZZJ<=OQU<3<,EAK[(@O-RSROF8\JEY2+Z7
bHOZ#)XD&fV\ED2D(C#@C8fT;gK7G>R4Bc4V#;Y8:&?/T,IYYac#Kc&QG8EbZC?A
(N]]M3;4a7aFfa/1._3^fEX>8^eQC7?][PNSZ1F2?KDd8:AP;,4NXPV)R7c+T3>b
I5[A4C,2e5RDSM(JbeW8XL2Ie=ESR,PG\d4<fGc:K@6U#<f7;EC^WX2d1WY.6SR.
VaB0HA48E7PU:_A-.G5QDD(@\e+/c7,GK66e\?<a,F,Q,cKeTa0W[IHS)1>dJ&f-
?:8?J(61WAOEZ;E-MZ&=?AY1UH4RZZ#90TA9M0SOV9[6A5L<XX2[JcP7;-;bN+33
AFJ@L-/D?KF<K^6_BdTaKSEXA01c:B3TKVdI(-b7GXE,S?fBZLAA4G.WM)4?3>[=
9K]=AT#KBY)8b@gCOL8:-;T.._G(FYQe@T#<]Lf=SU==6)G#P)&U]13a?T=VHWeE
X:=>_a78N12C,AO+GC\6?<+5@F0JGF431DQCdQ-#TM(HTS<6d6.@K];HKYBR39CI
<KeB3g6[L9::PGJ_^BB-GO663WQMM@D6R^O/-WC@?b^8,<EMc]ANg@IY\<OY_,=W
TGQ?egVE/JD?M?)[895NLR;<-\c8ZG-GSQdXH48>ARfSY<N<O#V&&NPDF?XBS[-D
-\LY;.#bS\-IQ2N^&CMU1U@)\-TI:Z7gFU-C+3[8M,7DSI]BL304#]>X>B]O]:[[
Uc-KWC,DLH7T^?0)K@MK,8QRP3cY,@EeH/@VHTTI&;]\+7UP^A\9)TEV1PA\+Z6#
7ANOS3bX+OTfI1]M[e,78UGc=g0>b2SH[.Y]A^SJU13D3>JE=)9RH?g=cWTbP+<M
=3Y_ZNSedL+A.TTKSL@JdM5YY3aUgNbA4@JG<e#5aYeX3c9<+7X7FX7dI7SWY<fW
JLN>;&@T,S#?0P4CD,[IH9T80TEGV1FW[#5PD^54Ub-U5PbQDbR1OGYJM_RC[@<3
dOPQ2_>?SBgKERg/9KZE-4-+FZ>Vc3P:X3IdE&[HD;b=5Fa/4XTd9^57>))4C_G&
7U.O:TLA1S6fP/R@Q\_4Mb/W,WgX,MZZPU^bGgB[1SIO:19\.[/D]+<=Vf-AG^6E
D-G^&AUP@0-YY2,)c@O65D9AgZ3E]7?QC;9\Gc2Sf;=2Lb269g)R@O&)CV\NT</Q
ZZWa\W0bF_aZ.6DR-;fCEc/+fSYb2Wde:_NH+9bZ_.DM7VU:LP,#=UF>.e,cB>RJ
+0@TK[H^^AZe+]=>?ZX5XEQGAZ6.@.I]1JRID#M>_QA+=B\OFH+]]E&-1.LeB2?U
-R5DR_LfBC?6E>@_X/P,IbFF);K1?8.6)AN8?IB)D_CG.YRW_G1eOg/Bb3d=g4Hg
M2JFcKRG0Ia;MF&eX1afE0d^eQYAIe(Fg9/A>1bMRSN9(A+QY:L?-6^_;4=Q^:5e
&>LUE^BJ,d<>.#_c-JAL&@O[Q&6?M+E\S/F=_C;9&@<fL/@RC[S-@INE[CDcZ3&X
IB^f)/ZCLQ:Y[Ib\#N6[&J,.=2RZLefEQ&69<gaJgJKfOC_JcXL[YQYU^Y,Za&]+
9?^:9@+dYY,P]b7R;0ga6>eN-8dJ))\T3cb:Fe;.]>b=+Jc=OS(M(9:U@U5\(Yb#
Mf<6F.bPR3b0NZ7??R6CNZec-M67I_WKV;.fKbaK^?H2:?P?7WQPPFd)b:#[@;U<
+,JNfQ3,N++130N4MQ;S:@9JVLYcd[58L6@TOX#)]V&R?\:^^19Ca0X<);ER5b7Z
?)08A3Ue<e/#4f&>[gaM2>DY)[cef]S4=0db]SVYJN16VaFZ7Z.3-:-g^,.O7[Q@
9[?5GL)SQ+&^XUC<.0K17;M8bS-LHTBK<^5?4-BBRRT((E:XB;V?,a&PC\D&MY,<
[CWA[5A^RBQ^;YI01)<@H8dERgc>^[7.f=X2-WZLg4e@#OYS/K#[2&]]\W6f6\+&
8W<?Q92eec=aEAZD]GO3-JO/\;#3P3Q6AOMVQGW14(gO.#[.7Cb]EST-SfPN1YB+
D<7H=FN&EV/Z6C0^+f_&I1cXTD;^5#3\d>1E/3;\_[gKJJK&/=?M)2Q3PAP4Y)(7
#GTIdT0M4BTQSN_QAODbE+1gC9?c;BA.e_\e,W_RZQ<UeGAAN\d1216P5cBM+RO2
GZV.C=KYEO(Dd_J=aO-OPX8CPDEU?Xg2WU6X(J>NFQMT0Q>B+77R/aJ859Q?\5F>
K3^(;NaWadcVJIA?6W.K-dPa5>DPE665b+Ec-Y-&9Nag/(PDf9[^gA,CFFF5QHHH
;_DWX[73,>SNV^H^1^[(,0HUaRV;b_DK8a&WgT>^<ee.aFVS2O<>Lc.(3b8FdZ#N
[?YR1&\f=WSAV&6S&FFB7\#SUIVPJg_fK@SGT9VJ=ME)K+15K.5)JI_98d5WKFS.
1>1Y32OSZK=(]>)af#[[+-LEN(AEAa#bT.Q^g3SU5]M9W+(e=2E]ZXXcb=X5AA&7
D>\L/bK0Cc3\,EW=JC<\(IH=,>B[C42+U\W0.M\Ece2(44:=4_X/H]6#d_4PI=1M
J\Q;4\ZRHA5A8N:=#=9/F5UNNH>T)Lg=:eSE[ZV2V8N.bES(A38_3>W8W-(OcaL_
>9O<P\=75bF_)J:YT&@dgCUe4(863:Ag1L28GBfTTPL5_J?fG[\8<STP4>aeQ1)a
Tb:)Z0P^\+UV]bY0.ZE5_VaJW@gR4D5GE==f^+V@=F4?UX=6Y9ePUTM[a125A\/=
7?_)gDIC7FV^,5g.<<U3.?SIR<C=fK0U0YFbX&3TVG9^)N[YDR5-][3,7C@^N0eR
Yf6O>+CSb,3Q2aa&V?)SRXL>_37N0UX9W,dcIY8(1)L4OC)Q&gEN)NTM33Ta4;?A
d3-0-Xg3F5Fc:5@X5_N?8&QN[G4O)c10MW>T>_PSfL-c6E\PNDTEGL2N4cIY:=-Z
[f<[DcR]Laaa)W6N][(W)U@9ME#O:a^J1bRg_XTQJEWGJ?dSL5bJffF8C;9d&+DR
Z[LZf=/A27Xeeb+O/T]9U\N:[QB,gb:J:@e\ZN&@P,X9A+U;&65RECL&9QVOd[0f
[QQc9d;8d6APWCFN_3K=FbR28NWUb3LSfJ0aW)JXJ8>]/Xf1GS41=J9=@=?C+(,a
4F^JG5I3.#KG8:gcX;H+C_OATU;P7O+1DPeaKA0/8]F=fC)0;+Ia\Ng>J3ObJN@^
G+T)+\?2/A5d(5<3<-AKK<f)AJdBN>]/GcY=d#c/C?7AP-?9TFa50g#TQ4SP)4Q@
Z.3)4JMT)a@c+#9C>)T-BDO>O&7S96b=X#8YMJGR4\bVT_R\):T4^IBdCK]92?H]
OWf0/fS;/5J=5UIE.VLWD.&Z=^f,c-aZ]J]LYJ:DL-AL<c9=c_EP>Z76I5/)L<F:
S<;d8NfE4eWO3<E]#(RC+^#Z/gaD=Q_1B2X]6[QMTgC]c=VJ2IG\6NaB_WS_OAMR
Sa7fUBB7;O6-X^C0&=^Df8JGW_+V,d&P9M-gHWV[4SL6OP=SJ<-.=UVU&K<:7dC]
0&=9L3KT.CEMcg^+,6XfJESM3cK<\YI4[d)_:&[.,OX(&]<+O3V\)]#];M.IDc1.
8(BI<K5OOQ</SL>;IO8THAI3:PNJC_/=7D[8VV@a:L\J;?&a-=D/aYA^+g;XQ8;4
&ED6e=ScXYeHDQ^A\8.XM.9<daIeI4FYHd4QLIXHI>]6YW2bKg\WPE#4]BeY+0Z5
#;+O@3<=Sf;3[HC#0C],C?)>3ZD]JJU?][=be;RCHc?WKG9O@6S]+5VD8E,L)WG1
EB&T<WNa411BFdL9)e#_X[?U=@Z9097aALdKdLB_4/HHFW9GfD[PL-)M+#=X@Z^,
D+?^CU@E,#(ABK1Y4/R;^4Y9P5IJKV8TN,1S-eM.3EOM>gRN4:ERF]A8]4b:2dQ?
WFM(<_a/eDU3a_]Q7M:8Pd3=\gB?0fCCK?R)]7P]563eJ7BeIH]K;IIAUgA8W68_
J&/)EI^41EELE@<<6Nba(cf+;,[==--JE@Ca>45<d5Y)PEcAD7[>J\RJ-S_X@9b@
E&G_T4J#[UDBF#IDK,CQX0W.J^9fN>WTC1P-RH(@fX\>U_d98_<-)Z3D-b(3ZX>[
JDbeB(@T;4(f_4:=HO&++1G2J(X-_-E/H/U>[Y3E/Y-Xf5(@AN)3cgA&gaB:@C3)
e)-Vd&)W)#&XED:TH1/U<O;6K0-M[dT577&?<C[@AF\\3X,e>IY.AO\J]cF-2,R.
:9d0ZZ;#eW^EZ4@=1?GEPE)6Vd@MN-+HKQc1)b9gd_VU]\:QRDJ5D9P4J+,FG.=N
A/F9R#)d(A@Jb)(U,5g/^KF)^Y\La:;4BA:(LL3=CcY1,DZ2cdYM-=88<JgR-bTO
G<SffST-+3<4/>O11=_;E>/LHME7_7T(XUEJU^+A?<7OGf?#T+8;7SE,V_TF;P_\
-aCD8A,)MN74WeeNUb^9e^WMB6gdW=#9?L_DP@BWaHcP(#B;9)5(]<gAGB+310G0
V4F-XI8MXM_8f)/Rb(Y>CT+=5>LB=<W=VbTCHg<\^(@F=SOTaf,G(,FPTc07D+a=
OZE_(&J_R:@Xc>Y/]Ug#Dc(G,[,g5cPg]LNH7B1-.g26I10Q>2AU<ZWagJ/abFGT
fdgC;E]9SR0bNS+E,ZM[OBeXS:dX(.ZN_6R2N5X:b(WUA_&\<U;W#dP/fK5F9_2X
?<D/_]B^aWB=g/E6^8Z=&+(b7W#D\f)X4bP)LIaUc_a?(d7R0dP?c27F)=M?9EME
[J5:Z8JY+R;Qfe/^57]-8OAW.91F2)YZ^-ESfd?,F_eLNLB74DCb/[W,WQLU7#V_
)/(\FO]RQ(f7JV+FY7&>BX+YG(=G3LfL[#IU#c2_:GHfDRX-Q9RcNS>C\NFJ/Z0D
Dg];9VG[FI+JG)^YX/N4;FGTX=7_>=H&0\4T1WEE;=WR(=8O4&1_aQcdAS[Oa)XO
<5He#f<F_\M8A:dFWG?9aU;P+#c]PdY2-G<3\JI6WR3Le:PK=^fDN:C_73S5)OZ4
UM.aY\<=AAJ#M=D=^-3Q\1+Lfd-B79)AE3^ZBQMNXM]&X+>QGAS_:2F?;Q&cD#@J
KU^-DVHAZEVUJ,ZdR08[cBG-)cb2Sc(dRN5<AP4U-R#QATQ0:a3Q(T[..Y/M6;#C
1eaQTIX[cQ(DB5dNF;JDZU1IcD35?WPHZFS.XFGX18fg.f@XW3?B5gRJTMObS4Q)
4dW..2U@LJUFOgZL87VNeS[+<\GQ)f8B2aQTH59ZF;Z(BbBgM2b15dF45eBQ9R&C
1,#U:(>L+8(1afOL7U(DIH?DM,SW[Z;Z_V?3+;78D/6dKE3bg=8)H9e5MDb+b1e,
]8[?G=95a<6I(_QS5&OV/>B/ZYd0-;DXg>VaK]=O]bO.Q.?U)G>bM0cO<6gV34-a
M(\+a02<:P#SL=AWe)8<N]]NgIUgU(B(S]I8NA-e+(A>+e,KeD_J3F98b/U:HW_U
)aCXbUGY]B5fZ-,0OGECCcQaD^gP(7cUcU9Y&^/5#]DL/^_:LRg.3,_?.e+;99N<
/CGIO@ZIQFMU3V0L4FA5^dN(.fIEOMGfAaAaAbM7b)QWf,d>XdF15S=Ne#EUOSd8
;Q6X(/c(5M?SEW9L[Z,dVd]20^7J#8[IJXX5I2R_-\I+),21#26WXd8H2R4Tc6f0
Y84Q&fSP)XeFG1S-]0+K3U<<KX4?SR/c8dG;#C<2^/dY#XD/4F?/PK0^6W-YQ>NO
H#.HMef/,&>bd[XW7K>f^UgMNFU,N8Q+V:Q#CN3fQ7/014W2a=gWW4@K6+D^dOfL
=7)L;_0G@_D&FHaZX_Md28&>WDNMQ?2WOW@KH_C>?#Ub6-H><:XLGE=5X)#N>ARI
5RMI9KF&RXbae;&5R&-(J:=JPIFGXA<-aX,X+JSM4X/AF_cZTMEN(T)Bd:?4F)?[
:<4?)](Q4QI>HIFZX:f(BQY=Q#<MMd/0b5,:+a&E151E4DN#M8IVG)2>aEV6RNTB
LeCXd6RBdBHB,#3QQ>0G7GE1^YE330W0e<OX.83^I/)[Ogf^bR<.4UR^A[];c=+9
J?VaR&J(1cV^I=Y3E;NC35)J=_]1cG;\8-31.DD-_&_Y9QYbH2bdc23@OHS0QegJ
[?.+#DgEg?N=S/R[A-DT/P+W(WP8QM16AIXB7-@g_f^JKg1TYJg9J?7G16(\4EOA
2c63R67f)UTDdgV@R#:H=aRH;^N=+2EMb1OZV4dZPUb7591UNUKW<AQBJM?eV2de
aUd^Y:RFS:1G4RXEdbbMf-1<R(8)TTT3Y);V=ACDO;]V-A9_P;D?Te_=),Y:B^gg
/S&NFCKD_]^)9DF#L854B-3F()68W^,:/a_\P;GEV,P/(]6(U:Ba1-3:K_Q1_LSZ
\-EV[/>BV5;W,Rb.5;egINJ^J=]:HSVX-:@a<5-D(O/:Pb3+e\/IX,^MRYMBGRTM
8XY]C>0G),e8E>9V-/T0a?5?]9A8<4S9I^eL/UH,A6^1cS&_J1g_P=3<@2IJC53]
=0A^a6W9/_6]DZTM.W::5F_ZX\CCcFV@McMbWMWHFUV)[49=Y-B>a[(5\(LA5]\g
0=8O?AE_Z4UTS3RV\T<=YZ#P.A,_0QeZGcW5IecT(dP7D=XW=:S1ZHD:9\e)Q?HF
4=a62dX,KGbXEdR6dg:gQ(fQafQE_D5eR^]-)AZT0AGOHaP-H=Mb,<cVb_Sg8\R4
S1Le>X3OI28V.bZf7RO5K61YZUOTQRC/TWG3Dc_PWP/\0YT?XPMUeXAY,gbRJQY]
A+PG_C_Y-WQ&,OaNZb1SE,4P(9c>@&_6#G\Z))>bK#=S);[<<YDE(,JV@U9K\_BJ
&bdQ@5a\bH#EDBd3BEN:3:]J2cKSd[#eJc>MMe.fRAc7ZX#UX6(e2R3V/])M+,@(
U_R13U=;AD5C]03D/fMF1Qe=3g3TU=8OKb4:RYE(OP1eNR8/?37.61R9=#GLIGO6
N:QCK(LIVE,?#?fZXQIT&XJ+80_V1JPR?EN),DLXRBaWT\=FCY2^\1\QKOe<A=<;
?]?KbXZ^=M9,LDeV:Ca>0ec@V30HcQ@0#;)J7-IV&AC7&fd3eI2Ja^1g/6&ZGg^5
5350VYUf.4\)1]Y@ZV#-LfI#33._S&=7LILAK]Q?#\\5_)7eH-+&?63K3c^+>)W8
P;PN#F;>+R_SN-g0=BEKO[9F[A#gS7Cfb[TIF+e+79P(/]aSICcYT4:WL8J-5:d<
5?gE7/KN@QeP27[>?[L)HBFP4<)X\\;Z:AOC9Rb]OE281I9SJX=\d-P-#g_XX^>\
),UA[2A1=+X.^<Kg9@[@;Q<e95<V)M/Y08:YF(^XcF=CL-X(S98;D+4D,O>[=7;[
WC[cf(+Nd1N)N[FAM^>X69?=QOcbc)f\C]O)Y-)A_;S2JA?gZTdg9S4P#LIKQObg
>5^a[DAR4V[7XZ,gU&5=0Z?Xe<Qf8H:X6SAG&CBV:<34aOK:[T[YAGP?<0d>Q6bX
gL/O<?g<LL(P&D@bI2f?W-.D,HNSQ^:EG4FX;7>ZP2])dQX/Ba6Y\<J;F8&>0O<^
.fAQQEFe\_@WTA+f)aHBN2(Y<].?K;H(<e&]^O]I]Y@;\&I8@=GDO&,>:,SK-MP;
SL]fgQ-)9S<Q+AgZ\&:fB(@0U+[SDOF=9bY@&@4O]_QZ&9TaJBabS[J\bR.,Q&30
1KcSF]3?9QUa]Xd3DT?3<^dAacH\6b_01I6+DP;4BL5b>,A,6MB#)P\^+\&WVGW<
0@?1LL#22FL>N7+U.cWMa=D][7.4YNZ(A6#/)aXZ6E=.7RI^;.8,ELBE?VZWQ5)-
SMWSOJ>>@R25/A;>,RQYUMd3;(;;UU]R]N)BYEG9,>G(f#T@<@>X8?M#EFP-DcJ)
M40-0AWfg-)D)6E@]VW>O>MbH>;KGDCd)Ybcb-IR4B)M\C^7\+7>(DURL.?^Q3_B
gLTb;WB.2]I;P>-2HNU\UPJ64KIK<d_P?SLfGTbO>(&:E=>Y//#DP2QTCWG?4.)1
ZOG#9W+ANM.)Q4SVg2a66OZ&Xc+(1S5IZQ+S\MJ/6Q;2P(D_[Z>[(\#5N:&,<L>]
P>,aDN\AF#5@R:g2ZbXB5;(?VF:dIfQ?Q>/Y/(E9e+,g#RV)JG]bd=S1d&48EP#<
#T;0\bI<DD1+#75da_(13AT&PCC]M/Y3V8@MaE70@Ygc7-B#]aa/Cd\;[b9FAJK@
R=TIQ,:\1EfXI-8ZQ?#\eS]4..<S:Oe/f]Y<N.I37MdM\D_gTR@MFCa5SaBIKZ:0
?9Ac?SI^U<=O(IggL?^N9eYYPTB>b8YgAVK(JWJ;G:&[d.(W>TEWV2==>]&XCJ:e
,7Aed<K<ZG(F(MXfDg4@_(KeVH8VDf]gW3LWZT5<KcF85Q8[G_=G;@]X3,RCYg0(
-2/?A0QAEQcFRXM,(Af@TSG6RZ?BX/_6\\NW73S8;bX[Z6Wd==+ZUe(P[IUSGL9(
W[FZ]NA8-bEP:=72SYT/+L-eF^:X7_9b=c=O:H=+>;^-N7e7MJAc[,L+R8&ZD_]d
S=7?&O=9gECB].U.P<fGJ-cP32Bg0::_U^#)OJ1;[_/[\0F&0\R<_Fa#g[<4X;(U
1/H1^Ld(V/5b>>DP&fHR><W[bLO?2VHd6IF#Pd]C?:,@fN#:eT6AC]Q(<YH18@^_
b=PI(1J9>GY6/e/O5b?Z6Q3ZO<(^g(15:>+3G@WIH664:g>aOYP:\_VM5M[9I]I-
(_](ANBSCV5&R\TYDa\U)e\^C-HaR]JC++ZI9:_gCGEF>1Y\#E7M30Q+X9e>-ZVE
Z56\/UX_I@JJ=4:E8&@/O,Q<3NE-1>L(QT/R:Y:PPPI)C\XY7caC]DLY>JG@A:RU
D7E#P;1YGg&Z\,GOK#PZS@UKAeXH5c^3=Q>L7T1?+]/Ue+(.A:K2GYU5g+_d.Ec@
dD2</WWTcV[W6WIa^c3T;<:^N4+>T?TUcOVeMB_X>@[Y+Jf]WS82&fIdBUdLB838
D5,5:_/LDJ-P5H=H[3IgZ(W)JVLJU_XDXE/:W9OeBQ?U4&gBfP&[TXVM+JbSU#b_
Sb-#1_c&W_8NSFKDZK9/fBAb^5)FTg115^Lg5O@,&4Y16N_-4L6FZL2]b)aW]cZR
(Se[W<9\cD99e=\<T)#L]=3=97W\IFUfRTgJFbBd#=W?>cgQ[N-YJgZa8VXdVVfH
=/W=eEV0c03DfEQEV>TWFU_ZRC00E6O67CEK9^8a<J43[c,)J=WZ#DOg8#WAW@@5
.R/?94eQQfJ3RZU<SK76R<:[V9.dHL;ZB2,R9<V)598B_1VYgN5G>GJ;9:Ee;Uf6
ZC&@2=.SAORS-gT2cUGQ#<-MeT:TfbSJ4c4=LQ9OK&AN)EL08aSRP7?T.^5Jb^.\
He\8K6-MFITH^19PFZ)84N9fH#_F[_N.Z=B+I])gff(/#ZC<N(#Ka;]G5A<\9EPC
bL1>L3J852QWd&X_#B83<H35c8c^LD8bJ1=QKBGBO0B3-?1)NS?GAC<L8(98GXE1
&89>J?g(S>(-87S.L-^954IGQXCC#ROVLF\6&=BXd3@33I5&PcAcMX_a0PUT7bcd
6?fPgB];d5U7DU_@TDX-Y48/<caM1<+CT4MR;D6Q/TaNR^<VNZ8U<DH9cIJ^O<1.
&:B/TKG?H6.FU[P2ZOf(@@J.,(Wf>QH9LM,^1?D_N:IfIM+Q2NKYLYacXBLD0T@]
MV82NC8;ASFV1>W/>U@fYD9DdP7(G&N+([697WV3?J7EQR\QID+&\M2&R5DK0/<4
<N?ZW02bV?>d^F/^1M5UQI7)_==VJ8+)Yd-EZLc,Igd_S^G3e?ETKZ3CXX-a_DD_
&IfH(51cGNfR:9\aGWUV#=IUB\?V>YcgY54WE[4O3\PfVVNAL/CEaZ2S96\>^]>T
1RJ[gK.RB19fAPdFd\BY(?TMb,-)F:.c-ML8JJ11X^9ec/&MGJ<__aZ.\gHg453\
0;G;CKN<Z)X@YWEK[+c&6LG8HABS4/QfZ&UWM^6)@?<:LZ^+M&FMT0>&dK8c6aB4
.F_KVg>+H/>)^Q&;S.358\P:9d7?f]#9)+^g-C^+==Q\Q=,H[VKEEg+-?_@4R[<f
dA)1)?YaM6Q4SBJXFfe8X.);^WBGST,^V;44UN;6X,,g=Ga<O[J:GA;Y^EB^4N]:
2L2V>^0aJ9)fB#KVAEEW9(U;C]dB<HBTQc_0.T;J>X8IRE#&+#.GNIcB9K^&F2MG
<_HDFFG^/.Dg5];KNS2bB<QH^D27Qf<,4UFAMO\F08EUXO&U\F0OZc):/g4<P]&4
e#;E&UUY3K\[,Gf@B+GG>E:V?fX.H8^CT1TG#17c+Q[JdAB]#Q7+gVDL;1>8[39A
_:eRARB0aA:G9O?65:^,:ggc3MC)1+\A[HYLCefJW=M)96.L/7)E9;C7\#&BQN8Z
]7K&#=[PO\c4J30.B.X_;G/D<c9K,b-U5e9XF0Y.QeOYC]JQ3-Oc1Z,3NGD->Ug7
JA5DHE^9X>34<P[0=]N/^4#>4^/]28FFLVWUBQHK?T&/fSKYa,V]L7O@:fc9\K+#
Tg&I?]8=b;7()XVZc<N,9PD9/X7\WT4YHE/7=.gcbNb2__&I@gUOJCQV)H9()f:7
JV0ZI-;[5[8Ya\;\?I5+KXaA?7f4U(F/Tg9G87YLK0GJI4FH]Cb\gILZZOB:G9e_
fRK#[/5Q.X;9\YT/Sf-9\;P_6aE9K/5VfG8-1+OGP7CET_@3TE+Ya,G7NXEUORE+
0ASEJ>&;R3TFf3(S)a5.ZPX,Q>T^<\,8TKC<#g8YKO:U#E+cE8@TG>J)#OF93^+Q
4PAYP=:VeE_65;fW=,aef6cYcGOD[?b<2PcD5_b(c92Pb]]E_[THc72S\I#>50]0
0NXZWV1_)E058-BCU3<]Ng.O0.-,Q1;:^AYJTB6@)QC-#:(<_)EgLOE2gOP\eN_/
\[2eY,@,0PC_9)IN\_T(5[]=/B7WW@0C+C&=?ZO0M?0DH<SS\3ZGDZV#e;T)&Q]F
&KE1(IRD1E+F>ENCX0TN+ALQc41\+@=Z\EC/G22.>]dZeCD5SLYI:9dVd@J;W^DD
YH.:^&<g;;]<?&JH9S8Cf@60e[D).Aa_Zf[4cS6@PB8?ZJYCbKL>[EBSQT&U5@3^
#O&4?#8HY#),<,6@8SaMRbU^M,K@N/8E\G);Q@MX?23F79J)_9gKI[,5GLYKUGW0
1EfC>T\S</84A;6N??([2AdPLDOTcD;W;<?+#IGCEdXXQ7e&+T7a:LD_>aQIML)U
/T\&5(LF6Se4.3[ZZJ@/(3(9SD3I5gZ0FcM(#]MA@Zf/_]ZN5YdO85D+BB63B/If
f_#)TQR04HJ_Q@7M:H[eGV8YP&IG_;+W,_Y+L/a?6I/g6bfd&NNH^?c(BLOe?A/c
U)ge2>.dC0ca58:F<D^#&=1CFA)ZG8Y,VG4Y,78bfW47XMYJ&D[gQa=.ddXX_ggD
D)e^Zf2=FOG_.@a0APBd#T[Y(G;bGLJ9R@])H:[aADdINNd(8<4c@:6cFOdUF5F;
S7Jf8Y:7EPfSGKC[E>^#aK:.Fc:@7,d7(0AZ60C+NWC[(PZ?DSaK>>#L<L#2H<VP
9^MaSTA9FE6-ab9];U_dZS7^T(]c1_9[06<QIJ[fZ?IPCN<>R@</+PgT;A80Kb[L
,+LR6C)7\YdM/<8;#d8gS/MCB.PE&a6PJ]6BI[J8b+/Q-M47G)K);ANcY(Q9Z:fM
T(7)>-;d)I@(/:Z4<Yf^&(K(F/_HB^)0&HR6NSA\[@)[)#R/^^HF;Db_dfSS)R#;
IM?0e7P6;ebaTW(I0LT^@_8_8)KU:PI48_GN:G)W+;P<^TZ2TNe3M<4:RF1+_([g
-U_8c,^+YDV?E+=[4fPQ\V9DHeX(NS1&]gFP--U#W5>Ic3+G81.Q)+T4TY@S9F?C
cP7OdS<cIO@X4H\>OFgJUKJ8FUB?])-)f4fGV>^].<&=T,HO+;L+8K,>Z&LC=JLF
d^D<USa8V0AcbNR/><,VNUFJR:]CY?cZUSHBM&C3L@[,?PUEIfUT;fDGI27g-2A6
V3K[ba3,KeX1f_&7fQ]Ub1/LY?\+&BTOIY+b#aE=>g^dIWM8Jf4E2K^W6]K^<8\M
41=XFS^agAFaU#-42&..[.Z=)OIPII1U3S<.P2TY59c1(DP51<)6J2RJ8])C+UU4
H+@OS1AMPGJ=<DJ.:RU6)&T<6gG.f+4=48G:)>BDb^++>JCJCDW1V,]>b2TNGS\B
^SU2a36IL?^VHO=&g=g;\Xf=.1f]]+J2;@OdX9NL][<:T7)/YYR=d-5:&T^;b^,@
Z7&YC_^R92;7A+[eJ+_=&)Nc1I)3XeIS,S5;<82K-g&Y3UFSDHSHU_+>7R&A9HdD
HbGVA[EOgc?ZMV@.AQMWL5[P5.YK=>H8O^3W.gU9A5W2.Od54>B5bFTebGX)N]L5
g5IAV@@T6Y:6=^b0[PTRF)GeRA:3;]CT=1I^#3FIc?83FC(-&T>4=8+W;V=_Z_E0
[aa\ZeObfdb^G]W?G<?UGE.b23>&-IV#MF0-;2K_2>7/d+C0YdXc1Q2(OQQ-ZLO@
MWBNP4I08EDX8S0g5QL6N-a]IO0J2A7^Q6gJ-F3:8_f9)I2LG@ODBKcd\(R(2_#)
V#M=J#F7daO/TbKC@#VF&3T@EIg&-)\I9ZUMd#=.7:Xe<DR,5B#?N8gNc_Q--fgg
N90VGR4?_T,T=LGQ@fSg:64N,VL;O23H9E_QR,74L^E4RQe1#8-H^eT:+WL3KOPc
&2P[R0We<8(,8V8Z2ELN93e=K/B:]@Q.cA>g6[R9deO489KFFY?e)V(MZ2V9)dd_
XSGB-(=-g>D(ED6T>S=CG/b.+D4Kd2?AF(]L)^KSffCY_bVS&K)JTA(<EceCP1db
#N-<1P^aAfWJSWL^VJ[7>2&<RJ<1I@1^:?1Qg@CK3e6d[H?+0eL(WMW7WG8X<Gcf
+YHB3(WP)9JCAcK<;ISa&RV1-OW#RJ2I0gfffc(,FTP<,,ZUfH0V0)gV;X0YO)/J
N=SPdV++;Oe.PN/^/<VBIIb=5AP=H&b2<-\&;0HT+DE.1,V>)\fQ:.L4)?7:RZGQ
.R+d>G]N(_YeP.+>0&FOfLL)D182Wgd&eO79;<UXNbBWKAM0Q<.d#D\OHJ-fab+e
:+BZP?/XZ(]1BYQRHKGKb(3HDMM][;cE2#&b)V5TDWW804M5eX:]?>_AU(&fF8B<
GNTS0NYIN\VKPD]JB+;S/=&g\>>0UW.?.#QCO/8V=N.)^5#1>4aYS1K55ZD3NgM=
GJaH;EKZ0.P,OE74PBag3g4:GX?1@aXXJTddA#22YI2,2K[Rg=WK:Kf^9PG75MYS
WVeE)7fBE62?;=MW^:<:3-3.dCK,VBFJeg+RYe?(L\IOQ]RPQb-FTYKG2ed>.VAW
S\E4MG:C(OQ8,e2HB16cJ?RLE6G0&CMO7F(Kf5((g,c+T5L^:1ST]aA\[1EFg#FU
dJ.&/7E[@J73CE0&=T_eec^K:;RCAMUR:QZT[W(;Wa&Z1MeU6dI\)RH-6dcgCC5[
BPNJ6Ag<^eZdZ[P4:P(Ka9&fDWb&ATQ5B7,Y]F3],08+6ZKc;=2>#7/N]FHMbN5P
#Fd.G4FK(=H^VJ3C1RAd598YVcF[VGUbef1/4D@S1RaVEc\=S0bE.4-K1^ba(L@?
K3bZ)=AXS4+=7V+F83&U8Y?STc;V3#5fG,;51CHb11XYc#4cB?J2?3bb+g<BLC]G
S6R<DaJa<3UfNT71GIB,4MFPWW/#]Q#IB]BAG+0(4Y>B/C=FVLP]eZ>aAQ>L,^(H
@7M3DPH=B;9Wfe0B3d^/T_,5\41(;;dJ]4EJZVcHMTMg[=4-gMP8-O3U18E9@/I]
-?C19YZYOM6MaS?>Z:GBY79-L[:J@_@1@GD9<dVI01XE)1OH+\OB&1,bDgVdOET]
]S78<B[&+&G+EW=7#K;d.M4P1P1.(4>fG1<8YKW9(TBbG>\\DG-^?H[.^Ng(UGRa
8XP9+R=H>^._Ag[YBa6HXRM>,>3J]#,Z/IXcFa-)+ZYP4&?)/eUEcTA_:BJ0fK(:
a44gJD1CJ&(c92;IaUV.21LAUbCd6]NaJT1K,C]cJD&V(R64IE)&>.>fCg(DICd,
0JUW^Xb\Qd^6/T@;KP6efMI;fRI(Ae?,aONJIKSZ)LG8/WeUA8L)830,5:0#:0bX
@;KcNeeRRQ)6Z=2Jf70N&^@/^07O7Rc_IN/N;fc9[/&8VA;c.0OI\\U-+D>^ET8S
@8?-4U[R;^TKeBPG2V5/FT:.\N_/=N-+gdE]3&UZ=F^QPd2)FT[8SM\()[M,2>b4
)N6_(H)Q(Z2BJ9<?F\9O1(eF_I]Ge:E)V:=)/Lg+0&CE^f[fDa<V9Q;gUP^8Y@<^
N8O@bf=KYBJ+(S8NHEY\M1^ON>U,5\Of23+-D=_+T]UZ@:FgR4RbIF8(HY^J0\5T
SS8IR71KF&PP4O>;g<@PXTYM>b,@>21c<Q2O:X3R-@6[a8=/Xa4(#(78=\>I^d=.
E94K<PN@H,COL]U+=[cU5a_B?,Pe&GCHL_WW>Va=^ZJ\[VBfb,0?U>9\gO>cL:d(
4-ORA6RCMZ-OAf4]&3O[(X3MJg3&(XKHF<<.@_26C3I=#=[[L3BMA\<L.C)4VbJS
9a3PT;fXA1H5,8CDLg10:QPI:TABC0:3eOCNE_=HYPC1&6IVA+L2.=b.XVCUaB?7
X;fB6;,eU)2TP#DGf)K[JW;4Y(9M(>eb9H4?UR0QfC>MR+W8WICT+X^WY9I)@b2,
40PB2B1fA?_d9+1aE4aWg&^D;9A,/EOE3SR]4L2PcD\(CMXGc]>_=^QZY3(I5[@3
X\,&?)8.]E9QgNb,/.O=a@398S<O9E)E_>Y_DEe>_))^KVV3ca>64e6_]0T60PC[
5E968=+cOXUTVU#c?:;9Y,C_gc+C&;@FHJ+=T8OU9^I.EU_I@_ZP0>MPFPOEGN.V
H&fH],P=_J<KE_5WK)3^,H@CNS.?G7Z7Z\(C<>-:E67HgHaT[ZV/FO2/_R49<(e6T$
`endprotected


`endif // GUARD_SVT_CHI_HN_STATUS_SV


