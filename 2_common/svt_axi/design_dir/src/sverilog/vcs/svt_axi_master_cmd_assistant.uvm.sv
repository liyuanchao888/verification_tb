
`ifndef GUARD_SVT_AXI_MASTER_CMD_ASSISTANT_UVM_SV
`define GUARD_SVT_AXI_MASTER_CMD_ASSISTANT_UVM_SV

// =============================================================================
/**
 * Extends the base UVM command assistant to customize it for the AXI Master
 * Driver.
 */
class svt_axi_master_cmd_assistant extends svt_uvm_cmd_assistant;

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
WORFK)+O6&9/fTd/=F]<cW)\gT0(X\VA@&IACg&C?e+b\CHFA[+R6)PCTW-8(+]8
1B[4GTGPY0G++\.SFeRD-e:T=O<1aGU3FO+;5F4OVS#+T,:]OFcC<3>JWf?cEF&-
\#7SE<-Y:-Q3,eORD&6^6;S^@6@dQC,(IeXbZ81L5XORN#HSK+G-Ud0c]V/HJ<bU
G./;XaP4Y_GWV?LSV3-[NSQQG2<-;-(TFP,I)(4ZB7B:eJ-0e>3WYO^)U2Q28T8H
]CgAW-OA/gRWQ=6+G3aFV20:PKZE\gAR8bL@@YQK:J4Z<V@;AVb^LK#eOX2X7SHR
J:0bc]X6/TGW)$
`endprotected


//------------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
gV.U6.OH&&&MDP<Pe&9]V9b9@FD5]d-\L?\b-N_W,^]5\U>NO]?./(C6:FEG#;VA
:I@@^;G9CBC-MUBL>#]9.=C5<?XaP)2A?+G@EVZ/:PUJ_CJc.G-6A;W?T<(8/5X?
A3S31&&b;W60;X8e==BQcH>-=>ZPT/_/6acG5V5Cae]^5F+2W_]RQ?:8e)P(+d3F
XDVFB>01@M;DQ<Efcf:0ZC&7(WGOPP/VaW#G>#+2g:N3CKOT_[ScW,Re,aM&HC_d
3Jb0gd^BH.-P41c#FXPE5KK6MTEc[G&/-SJb#7g,b5fD6X>K1^0FDG]GPfG4Ga4Q
g52L#AId\RYa/=GKf/B-<U4)aAVIEQ8Y>b[M2RO?)T<:(8eX0SJHDcK[JKf9:\.<
e@8GcF.L<H&293_2N49J?0>V5F[E5#Sd-Y/_b>S<2J&T9I_=1bS9U<\0V[K#[14/
Y^UOEQZ-&Q\-E]NHYdUO]cY2a@<gFe00PJ9M]>SCUB/,Uag[_\T57\Z006@YR3Xb
EG61aS2b6H()g&a19?VHAd]fMPNTZI>8.GIZ+F)Sg?YI2N4IUcX/K?c1/1LE:8\5
d:bCA9>e^+C9Ge\HMISI(E<IR\8+bP.S8B==)0P/S-Y980:^XBJR^[/Lg_):W?T^
MBfZYLZfc)J>\(>2gO@LT-g1A/PL_S[c0ZPKI?IHWaJ#[GK/E?G66c0Fd;6J4DC[
:S#IB[84JGZE5S&gV9QGa&X-XcU6X?8#PO?Z7#&Q,9_1^X][/#X5V?&T>Y-)SfVE
BeTdgQ=+/d5</A3@EF&c&bbP_83)(YOQAgV)W3aN)a+[f@O0PQVWJ0,b4.XL)\cW
CXcR3]aOSUCZLI=0]:HCISGNGJP\LJ_O[eA@^&=H0NFfb+6<&VM,X1J+??^E?f0F
IFAd5]]0E?T#I2U7&N@^d7B30O3g;=,^,YUEH7RIBS10)W>,/^3Y.#Z<_))2gac3
9edUN@WgDUCOU0<<90ZS\8HX.PHVJ+F^_&87JD_49M+UKeL#[R@ZQBWJ=1;,=D@g
/I=aRdLQ\6>#@e@GG-+c[OA\fK9=K5:QKG1RA2/]X-LFV]N8NJG<C:U6HR3.FeDJ
AK+S81;b5g)[edP9DF0P=LS526BA->@f?G_N#D;@Bg0279=:K7)4_O0>=VG4Y^&A
6E+bZ:FI-NeQeC1-Nb0;dPSK()KdNeCZCObAWd\6g?NP#>HX/)TH26AF6C<cJODa
YQc(VILR=P=VLG0\eYAV)BO](d4eG]]3e31a(-e9\_VOaY,<H37(a8eU.BMeA6QM
>K8a5>G0L/SdQHgB)=(&1(EQ)FgR.MHBUee2BI:>[/fL9H4eQ/cW]_O?UV&,_BT@
WZCR3bgBGJ,f:)R>XP\;(C+]P4S_A;N2g&eVIQLT1/9ED.4((a,\e-3,[aZ3QSLS
aP(D:Cgg\a5QE6I)3(?:FVbU-dWR?5R1S?87bF+-584.RBNdV@#OC8e:P(XRMA]2
65Q8>3#?G(L;OH.^-a2MH3,IRLTffgG_C@.a[K&<Y;KPMQ@IZ+26e5<A/@&U;,5S
\5:.U-FAR4^[dVbEIAYPACgCRI9(>fH>M:KN>(S9b6+IEG]Ab_7fW#8.^X39+VRS
+<IJXf_,eSS-b:)M;3EGCH,4&:8HD6^T(_VFJ-]++g/&4,E>4I+G5Z@3bW:>fFWO
:)S=O>545d;fa(:<.R3U.4Wg#94aSG93Q>1/2CMC_U::#b4:;:IfgQY(Ef#(44H3
+?BJ)QXA7W]=cUc-XSA12FC?Q,[S-#>-2QZ;0H[8.L[KQ,bIe^YBec8;>a3=JE0S
D97RdK<d]XEc[J.bcT=D[X#ggF_G9N2eDWSZ/2SfI60JE\])NEY#=#>P2/+3054@
/E\USVY,<9(WY.+._,[J7ZZS[FRI.HJd3(7P]@3:2PJ4U8AfaJF2-]=6f-,:bZG/
Q&57>KL@\&FVe:[BWGI9\ZK,AC6=9f1<:cdWAES+S#A:6\)/)T>4ZWI8P34RC1AQ
T-B<H0e5gb&bQ+DQYd3aY+ZM8W;dI\3BZ7([JQ0]dbV@_3U#?S+?/7I;GF86&BEZ
[?e:.Y>NMPAd6A9:(.=4bSXDZLV/S-.+JD_0<eJM_1XNM>W(0.D=.)/Y+c-HSV\@
J+S+Bf:YSf.e&K@GP9#D=g1I.UL2a3X(]2<OJ]T^K&6AO3RIWdcEWbZ7<?Q(RI/0Q$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_DRIVER_CMD_ASSISTANT_SV
