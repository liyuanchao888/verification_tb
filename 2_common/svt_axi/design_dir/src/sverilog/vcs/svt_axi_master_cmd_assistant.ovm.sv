
`ifndef GUARD_SVT_AXI_MASTER_CMD_ASSISTANT_OVM_SV
`define GUARD_SVT_AXI_MASTER_CMD_ASSISTANT_OVM_SV

// =============================================================================
/**
 * Extends the base OVM command assistant to customize it for the AXI Master
 * Driver.
 */
class svt_axi_master_cmd_assistant extends svt_ovm_cmd_assistant;

/** @cond PRIVATE */

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /* Reference to the driver that is associated with this command assistant. */
  protected svt_axi_master driver;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /* Flag that indicates that the method has already been visited. */
  local bit recursed;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new command assistant instance.
   *
   * @param driver Reference to the driver that this command assistant is associated
   *               with
   */
  extern function new(svt_axi_master driver);

  //============================================================================
  // Methods to Support Command Interface
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Command Support:
   * Instructs the component that the command code is done modifying the data object
   * (config or transaction data), and that it may now be checked and utilized.
   * The result of a call to this method depends heavily on what procedures are
   * active.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to a command owned data object that is currently active).
   * 
   * @param handle Identifies the command owned data object that is ready for use.
   * 
   * @param delete_handle Indicates whether the handle should be deleted.
   */
  extern virtual task apply_data(output bit is_valid, input int handle, bit delete_handle = 1);

  //----------------------------------------------------------------------------
  /**
   * Command Support: 
   * Retrieves the value (into the <b>prop_val</b> <i>var</i> argument) of a
   * specified public property, in the command owned data object pointed to by the
   * <b>handle</b> argument.
   *
   * <b>Note:</b> If the <i>prop_name</i> represents a sub-object, this task
   * stores a reference to that sub-object as an command owned data object, and assigns
   * the <b>prop_val</b> argument with an int that is a <i>handle</i> to that
   * sub-object. It is the user's responsibility to manage references to such
   * sub-objects.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to a command owned data object that is currently active,
   * or if the property specified by the <b>prop_name</b> argument does
   * not exist in that object, or if the property is an array but the
   * index specified by the <b>array_ix</b> argument is out of bounds).
   * 
   * @param handle Identifies the command owned data object whose property is to be
   * accessed.
   * 
   * @param prop_name Identifies the property name whose value is to be retrieved.
   * 
   * @param prop_val Functions as the <i>return</i> value (the value of the specified
   * property). <b>Note:</b> Regardless of its actual type in the data object, the
   * property value is converted to a 1Kb bit-vector. This return value must be
   * dealt with in a manner applicable to the actual property type by the command code.
   * For instance, the command code must understand the int equivalents of enumerated
   * type values in the data object.
   * 
   * @param array_ix Specifies the array element to be accessed if the property is
   * an array. This argument is <i>required</i>, but is ignored if the property is
   * not an array. If this argument is out of the array bounds in the object, an
   * error is reported.
   * 
   * @param is_handle Indicates whether the returned prop_val represents primitive
   * data (0) or a handle to svt_sequence_item_base.
   */
  extern virtual task get_data_prop(output bit is_valid, input int handle, string prop_name, output bit [1023:0] prop_val, input int array_ix, output bit is_handle);

  //----------------------------------------------------------------------------
  /**
   * Command Support: 
   * Assigns the value given in the <b>prop_val</b> <i>var</i> argument, to a
   * specified public property in the command owned data object pointed to by the
   * <b>handle</b> argument.
   *
   * @param is_valid Functions as a <i>return</i> value ('0' if the <b>handle</b>
   * argument does not point to an command owned data object that is currently active,
   * or if the property specified by the <b>prop_name</b> argument does
   * not exist in that object, or if the property is an array but the
   * index specified by the <b>array_ix</b> argument is out of bounds).
   * 
   * @param handle Identifies the command owned data object whose property is to be
   * accessed.
   * 
   * @param prop_name Identifies the property name whose value is to be set.
   * 
   * @param prop_val The value to assign to the specified property.
   * <b>Note:</b> Regardless of its actual type in the data object, the
   * property value is sent as a 1Kb bit-vector. This return value must be
   * specified by the command code, based on an understanding of the data object
   * property's type. For instance, the command code should supply a string for this
   * argument if the property is of type <i>string</i>. Similarly, the command should
   * supply the int equivalent of the applicable enumerated value if the
   * property type is an enum.
   * 
   * @param array_ix Specifies the array element to be accessed if the property is
   * an array. This argument is <i>required</i>, but is ignored if the property is
   * not an array. If this argument is out of the array bounds in the object, an
   * error is reported.
   */
  extern virtual task set_data_prop(output bit is_valid, input int handle, string prop_name, bit [1023:0] prop_val, int array_ix);

/** @endcond */

endclass

`protected
_U-7)Q>7:Wb)89f2WdC#3MTVEgC#U&gfIFE_>K(>C0<ZOWR&TESg,)7\@Q28bIVd
C\cL_1#g\42R0CW=(MUM^6(BWBQFI6U,+)KDJNN]6Q8-,R58<D_I765a\]G&1B?]
Yg7J8.L(Z5670CFQfVSc6R)Z#HE0+-&N:N>Ff#8\IV<b/+>ZWQK<#OXGLVEA[T@<
B@Y&,Qe1^MWOOb.;61ZEHBfH?g@[T8]eEcc30UBgB(E.T<f928=T+DW^KQQcaD7;
ASg#^M4\DEFHYZX-68.eeF\C5(8f#&NG\/a?G?dPCO)4Y^9OU9IO7Ld3dZ.Y#&_;
C[,9g5N4XJGH)$
`endprotected


//------------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
7EE^MfKe2?Q[+dXZ_:#4R:<RVR[POH<^b<d(BKEVHG9bObJ\c&EX((].cY/d(fA8
RbM)B7:.+dH>(IKaa<R:U]F&WS>M\>MX+L^=5VDa3E+<:fHL\25C+dRdc(8DFTK#
@(Y+4VJ8NLg;NbN9:0AUd<<06FE[G#C(L=;^:e/^TN5b?0LL>,0eTF,bUeJ5d/+8
[@.<?NaEFGgMEHg+R>R060OKD/;WOcC]8fc]S&1Y??L\)dXCeCa=&42),&@Y3aAe
cO+2ZD\E3+d7J:P#&L\##)/R:U):,fGRNVQU<MTP9ga5_^8NY@?53U-D?WdTFc->
bJeIKGc@E_R&\6^?IC_](/LKI9aUX#16YbD(Tf;7])J-gX@?S=S(MRB2@E?4fX,>
83MS>Z.19OYWb5&8^MZQ[[L5+A@d<,^Y=;f^8C+D5,>U[S1J0HZY#dN@=3]0_/E^
#6Vd>\ZR#I?I1(5=33ZA8Dg>Z^,2_(6L>5::eaJMGB7JSUGAeN9g)8;YfK;E[-5:
F^0g^\/0R6EBa?+efZDH&Qf^&E#VXQQJVeT<K7\W,D[-EYUgX^]^WWUX1+K#b7L-
B]R;3PL=:EaCJbQ)UU)O;bLC.HId<>^.>3-GXe-ad<<X<UVN03.;#57aQ#6WJVDG
&<I6363RB4]:YaU]FdDT&&TccH=+JZ/+G2Ag-f6)?SI5TBJ)JG_6QI-V#V@7gNd_
g8H6/]aXA,Fg/(<07EKMR_T1.e@ZLS-3[1T9DGC^AeBUU-LK=XXFQFd:,U\>-E9^
DE[@C.Z]Jb8<0f7C7HL-JY-Lb)>3a+O/>,ZX1BYDM;QDPK&Ub&]@bbAX>?QE<<?;
,7S,#Ta=0(AbORTG1aIV/&7f0W0/=M:M+Hc1QXG,MAF&?M,IAb^ffdV94&c2Z7E7
X_?KbP)XRb<Fdd\X<M5K+IS@CTBKcA^SeKV5FFH8.A]dR6e&7IXaW?a7KT/-^.8e
B/YCOZUW<OG:eH@RD9PP:9KI=F,Z]TZ[RF-(b@L3UV3FQd0MXX,CM;C2K(CO[,;@
>;3((#833[<ca;E1KaG6R><1L]\C#VO+]LYN1Mg:S&ZZQ.6+ZQ+_\+HGJC+TSZF/
UL<861:)VZI>X18]LM0;P]IA/@^bI?cdE-Q5A)K2NRJ@;S^1\3ZCb,(_H#<?cC9H
-<5N9.M]c:g;df=@4\##\(.A._W+AI4+bEgW++b=E<P]4fU-X9[54)e4E5Z:H]6]
6#\^-e-adW2\fS\V.bTV9@MLIZ/PgS9ZP2N#M[]fUDMV\47F#W/G/:bZL]<Ug/TZ
cZCT,:-ZP])+Z@L43#(R><(<<R7[8;Z+(K7ce7M;a/;N2,/^=NNZ9=QG41BVQL;:
IP\F+65WC:dKGH02CSXYEW&2:adKOCPaRS&N;E)]]^5P]-GN7286g;HH#Q1.,1-Z
A<<<83Pec40g6La-a7?Z1?/G;A=B:d06-QY@MTLTBZOJgD[C516]=baIPYfY\AAa
T3dDD-LPL=WUF7AfYX7C:E#>DQCV?79Z47#H8#19H;U-9G4M=Uc<<?Z?_QET9O6U
a5YQI+H36.A1@9<+1a6[Pf,9dR#gK7##P?9VTdLf^eG)ZK^=PePVTN[-B/e(FIbO
7-+L_4#_]Ia=JML+I/,bX)S<QY\?CF]^&C3/.VJ@>Z1[\a]NPSX:_56KS2^PBa3]
]ONHDD_f[aQ(F^a/)NC:+:OHSc>_S4,M4L(X)C#=U&6Q^_9SN-6]H;c1[BR4)QfU
?^VY,5.dfYe4@3Q0]MeO.a4cD,9.,LfE=,T)>9&7MYAY<B/598;>fYLP-#Y4B>.Q
-\6d#Q[L4C:RK=;IZD5^g2U/8/<CegeJ(I.R-D=-/A0;6])Ag:[:\)=X)T10fC-B
YF4RJe;Kc7C=\]8fORS49:g83]VN@HEfY+P[(U[YZR5Z/-VdFBa?ZBL[9-b6I:c+
:Y292M:>Z7LHDL-+a1]9#]b.XHF>#CNRcQ_FA^]B2:[]IGH>U@615b04;/:AUbOL
RU7eJg=0--1D\HHB?9L^-eV#W\E+G=6/-G=HUd7S@G&Z_4We94Z01M&U2-/HF=.D
:Q69B/a0a7MNT@BMA0IWT;^:g5Z5>)9UAGbYKcEb,Qa7Rg6W9G#\c<NUDb+)FNDg
e>CPC6DPNM-620.C\fS7BC8#C[-<97JX2R;e)(0Y,-0OTA1VF.7?+CT]73KHXU>[Q$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_DRIVER_CMD_ASSISTANT_SV
