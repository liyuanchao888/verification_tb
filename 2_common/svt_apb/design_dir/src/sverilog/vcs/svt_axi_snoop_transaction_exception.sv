
`ifndef GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV
`ifndef __SVDOC__
typedef class svt_axi_snoop_transaction;

// =============================================================================
/** @cond PRIVATE */
/**
 * This class is the foundation <i>exception</i> descriptor for the AXI 
 * transaction class.  The exceptions are errors that may be introduced into
 * transaction, for the purpose of testing how the DUT responds.<p>
 */
class svt_axi_snoop_transaction_exception extends svt_exception;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  //vcs_vip_protect
`protected
W6(R5BX#L0E)5[WQN69Z:L&fABMc9Q3MWe-g,H4TcAY\/9&G@GD^)(f_-@4/A2X1
.cUNeA5bg(@XGc0)>RDC-N-;W;P^c1(V-SW/D9BL#1[75D<(-bg>f4:95=gIGVB-
><(_T&E,e1H+I:NG<&e.##aPa0NgC^3/O9+/^0IPU7=I<[]2,Y3d+ASPE],QYYbN
a+&+bc8K;a8R2JQ(Xc)\4O>L=F2f-c93;R:8\H=DON^?b-OdMHNH+AR6a1a4/H\e
+]F5BQ/30SQIXbEWOd^eNK5]?SKWW)E@V,d5(R,:.WF_=P^ddS5LcgM:0>\FPCdC
9L1JRHfY8aYO)_Recf=P^a3b-87F(?O8WRC-9eg?>fC:NaS<CZTb^GX5ceX#K]W4
Rb_IF/N\Cb_PcG>GGfb&,^f\>6=e>R3#OM;^cN2\1>E]VA3,IF6DYdZ,DOBRHGCK
?UaeMXXXgD&]>8d=^EZ-IbI(fW=UAM0JL.EP&RMUU0<NK>D]77^4VG+ZRZ]\L7AG
LEDUb2ff9dIQP/\b^E#TeMJS;-AeESYF^K2:)e47:EaC0#T;J@d5A7_cWc<R,>a6
?2eK@Y<a\N\2ZN[Z6B47T[L0^.#JPeD^^@W9HYecW]5IL_)CV2[BH3G)B^W>[TIR
O.O_O0DUKVZF>f6P3V[,6Q&PGOBE35D0#^<[T05@W60,205;8eTbA<<(faIbWP^R
ZQagJ;c@dKL(MC/AW0Y;=c8Yd57M+W)ZS)\A3:gKO;dS&f(EAb,gb#^J#>-gcOB6
K&J3D_D]U-1Y_-J8[K&NW.(bS;fGT7_H;KcTFb;cdAbSEJU>Y\0@&#DVTe5=_2^B
NE./ZG:+10]Y/$
`endprotected

  /**
   * A transaction exception identifies the kind of error to be injected
   *
   * The following error types are available:
   * 
   *   POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION: Corrupts the cache line state based on
   *   the value of final_snoop_cache_line_state
   *
   *   USER_DEFINED_ERROR:   Generates a user defined error.
   */
   
  typedef enum
  {
    POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION = `SVT_AXI_POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION,
    USER_DEFINED_ERROR   = `SVT_AXI_SNOOP_TRANSACTION_EXC_USER_DEFINED_ERROR,
    NO_OP_ERROR          = `SVT_AXI_SNOOP_TRANSACTION_EXC_NO_OP_ERROR,
    INVALID_START_STATE_CACHE_LINE_ERROR =`SVT_AXI_INVALID_START_STATE_CACHE_LINE_ERROR 
  } error_kind_enum;

  typedef enum bit [2:0] {
    INVALID = `SVT_AXI_CACHE_LINE_STATE_INVALID,
    UNIQUECLEAN = `SVT_AXI_CACHE_LINE_STATE_UNIQUECLEAN,
    SHAREDCLEAN = `SVT_AXI_CACHE_LINE_STATE_SHAREDCLEAN,
    UNIQUEDIRTY = `SVT_AXI_CACHE_LINE_STATE_UNIQUEDIRTY,
    SHAREDDIRTY = `SVT_AXI_CACHE_LINE_STATE_SHAREDDIRTY
  } corrupted_cache_line_state_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Handle to configuration, available for use by constraints. */
  svt_axi_port_configuration cfg;

  /** Handle to the transaction object to which this exception applies.
   *  This is made available for use by constraints.
   */
  svt_axi_snoop_transaction xact;

  //----------------------------------------------------------------------------
  /** Weight variables used to control randomization. */
  // ---------------------------------------------------------------------------
  /** Distribution weight controlling the frequency of random <b>POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION<b> error */
  int POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt = 1;

  /** Distribution weight controlling the frequency of random <b>INVALID_START_STATE_CACHE_LINE_ERROR<b> error */
  int INVALID_START_STATE_CACHE_LINE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>USER_DEFINED_ERROR</b> errors. */
  int USER_DEFINED_ERROR_wt = 1;

  /** 
   Weight controlling frequency of NO_OP_ERROR.
   
   This attribute is required to be greater than 0, but will normally be much less than the
   other _wt values.  If this value less than 1 then pre_randomize() will set NO_OP_ERROR_wt
   to 1 and issue a warning message.
   
   */
  protected int NO_OP_ERROR_wt = 1;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables. */
  // ---------------------------------------------------------------------------

  /** Selects the type of error that will be injected. */
  rand error_kind_enum error_kind = POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION;

  /** 
    * The cache line state to which the master must transition after
    * completion of a coherent transaction
    * Applicable if error_kind is POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION.
    */
  rand corrupted_cache_line_state_enum final_snoop_cache_line_state;
  
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Maintains the error distribution based on the assigned weights. */
  constraint distribution_error_kind
  {
    error_kind dist 
    {
      POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION := POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt,
      USER_DEFINED_ERROR   := USER_DEFINED_ERROR_wt,
      NO_OP_ERROR          := NO_OP_ERROR_wt,
      INVALID_START_STATE_CACHE_LINE_ERROR := INVALID_START_STATE_CACHE_LINE_ERROR_wt
    };
  }

  /** Constraint to make sure randomization proceeds in an orderly manner. */
  constraint solve_order
  {

  }

  /** Constraint enforcing field consistency as valid for error injection. */
  constraint valid_ranges
  {
`ifdef SVT_MULTI_SIM_ENUM_RANDOMIZES_TO_INVALID_VALUE
    error_kind inside {
      POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION,
      USER_DEFINED_ERROR,
      INVALID_START_STATE_CACHE_LINE_ERROR,
      NO_OP_ERROR
    };
`endif

  }

`ifndef SVT_HDL_CONTROL

`ifdef __SVDOC__
`define SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
`endif

`ifdef SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition..
   * By default, VMM recommended "test_constraintsX" constraints are not enabled
   * in svt_axi_snoop_transaction_exception. A test can enable them by defining the following
   * before this file is compiled at compile time:
   *     SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_snoop_transaction_exception_inst");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_snoop_transaction_exception_inst");
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_snoop_transaction_exception)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new( vmm_log log = null );
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_snoop_transaction_exception)
    `svt_field_object      (cfg,                         `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object      (xact,                        `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_int         (POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (INVALID_START_STATE_CACHE_LINE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (USER_DEFINED_ERROR_wt,       `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (NO_OP_ERROR_wt,              `SVT_ALL_ON|`SVT_DEC)
    `svt_field_enum        (error_kind_enum, error_kind, `SVT_ALL_ON)
    `svt_field_enum        (corrupted_cache_line_state_enum, final_snoop_cache_line_state, `SVT_ALL_ON)
  `svt_data_member_end(svt_axi_snoop_transaction_exception)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and svt_data::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_snoop_transaction_exception.
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_allocate();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new object and load it with the indicated information.
   * 
   * @param xact The svt_axi_snoop_transaction that this exception is associated with.
   * @param found_error_kind This is the detected error_kind of the exception.
   * @param affected_tx_packet This is the index of the tx packet impacted by the exception.
   * @param retry_number The retry number when the exception was encountered.
   * @param recognized Indicates whether this was a generated or recognized exception.
   */
  extern function svt_axi_snoop_transaction_exception allocate_loaded_exception(
    svt_axi_snoop_transaction xact, error_kind_enum found_error_kind);

  // ---------------------------------------------------------------------------
  /** Does basic validation of the object contents. */
  extern virtual function bit do_is_valid( bit silent = 1, int kind = -1 );

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned byte_size( int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports
   * COMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack( ref logic [7:0] bytes[],
                                                     input int unsigned offset = 0,
                                                     input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports
   * COMPLETE unpack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[],
                                                        input int unsigned    offset = 0,
                                                        input int             len    = -1,
                                                        input int             kind   = -1 );
`endif

  //----------------------------------------------------------------------------
  /**
   * Used to inject the error into the transaction associated with the exception.
   */
  extern virtual function void inject_error_into_xact();

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision( svt_exception test_exception );

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val( string prop_name, 
                                            ref bit [1023:0] prop_val, 
                                            input int array_ix, 
                                            ref `SVT_DATA_TYPE data_obj );

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val( string prop_name,  
                                            bit [1023:0] prop_val, 
                                            int array_ix );

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
   * @return Status indicating the success/failure of the encode.
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
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   Performs setup actions required before randomization of the class.

   */
  extern function void pre_randomize();

  /** 
   Sets the randomize weights for all *_wt attributes except NO_OP_ERROR_wt to new_weight. 
   
   @param new_weight Value to set all *_wt attributes to (NO_OP_ERROR_wt is not updated).
   */
  extern virtual function void set_constraint_weights(int new_weight);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */


// =============================================================================


`protected
I^6d32;2\P-ddN5/(:N65=<4QV&@0^X>WU0I@\:9PdE0KUJcO)d(,)S,>KeQ[X9e
L?H<Na3>IHfS0WCFIAHAgdfM\B@0,T?9#LdKdOd&6.+0S+.U_0&JcTf7OG0d63I/
N36_B(\711;<cNPWAS9K1,_S>^>;>O_V0U4A#^5])@:<]f3caa@38?U]?VM4P]@e
I>SL[b-81#X6:U9gGB+:=#[R=IR?NT_<43^Q-[S?_&:Q/,69c]e@=W?0)?N<9T+Y
17OX3Y.GO[T\JK(A,(7X&=#gLd+^)NV3gZ[GCX.PaF8&4?4d1R6WOCb>DEVcJ@WX
]=>TF@3gb6c.BI=V43O@aW6@fI6^Kb_UbN[1eB?1/;LVL5#E53;gbY;Z3@[^b,W+
gYS^O>PWf/5gF<Bg]C&;OP/CX,8]P=).^<H\Y(b_>?)HL:)bAPa_EfN(Q<(D&4C2
3fS_C-JBa0T];eK(LG=68R)^Z0AE:6DPVJZ>C2GWSJGXRc7S]2:6-7f@/Fd<WC:5
8I2fe4U0-XCgg[YbQJ_A9gST>WUUJH1NX#Y49>S9NROa+JTb+]d\BA1&Jd4K_7)/
f()+V?;;L@g-Q#>N2&>He)Cg,9D3OZ,3]<0V;bR+;0B_2+-Q8gU6_L:<Z^3T+0EN
gY+OP.E+=acb]8bMZQ3b]0V+5RO-SD>Vccc80MBDG-BaU&M[/=@M(_ZV>U0MT[Y/
_Yb;fAcf6CF<d-cF<:8<_4OWAN&D#3G.Y47-5]__+b32f.>0-DQ]BY]EXIb=48R.
V4)&EPUUGF),18F0-cba/BOW3$
`endprotected


//vcs_vip_protect
`protected
?UaN1F.E)K8#J1=1VB9LWZb)KdC-^Z_X^]AT4G1e+DXf:S;U\EEO6(0Ne2I#;W<Z
WTF\)U_D/E3R-)I3Mc1PJ)U<?34cKM82:MLA?T@Te,Z9KT/[&G.\(:ZIOQ^2?<7g
OJRB-#H@2+M8ZT&29#/HW#W\X3)Lc4YAc,OJ^?K.G)58L[GI3K<f-LQ].QQPVP1Y
WZHUSI;]gZF1[\,<]I)N\:0Xb-3GbWLgAU#3(3++&@cZRZ2,XI);HAU6#3-bCf]#
>TF;6:4/e@+YEJU+V^D69dXF;<XB#A4+8V-g^bUD\LWe(B#c>bfcS-8#IN<#2]P]
YS&/+7W2T^0F^eKJ2TYE0<;FaYQY4ZXCU(Z.-HbC6JO3<IPW>Y8X,O>DMaMUG<KN
faW?OF9Z@S&>>=+^=BOWH^/2La6-)(@/I/Q=,Z49b1688_Ube?-XOUY:XQCO.YFK
,KL9KHXg=W99eJ<K8-(&K2GVCH,]FEM0E/#,[JaS6b_GacO[[8#:cE.eO89JGQ;W
.F;<1Gb,AT=NcPD7Z7=F8XM3L\891baBVDB:C<J9>ZNDeI^&Y5V6XFZOd_3S#I^:
g45)/a[2dCOQ87_]NJE<fB<P.,KY7IG?H8;_,,O9E4?;O#9+B]0Xc<)U?cB@KA_L
A6^-g,YE4a8e(8(W7I.WDW?V9)+0G+[[AT/7M3ZJ==J&5+JJdY\fPR9&#;g2LAAY
aPX:;Y_^)96gZ9BK556e=Ab]:E#OQfXAV;>&+McEUKZJ]gBbaLW)J(.>06XZD-g7
BFS+B3&6d/R>&FaHRHF^-Ff9F:aOHCe&Q\1?)F<5DVZA:0V)g(0[2Qd8DbOH:^YV
9e3)eP),I-@-8#5ZLNO7U\Ya;b<(()ag@SX[)RZV&2KKgP3Q7QXZJdEaK&,3K+Z8
[3Bf]&QOF3_.^5.2aEUW^6YZ-A)BIRZ26ZQ3)b4,f._TF8@^Qa#71WUN@R)O[=D?
R[aN#(?6B6-A;MbJ.]Q&;LPJ(EC@=_,##?G^G.C_AAac(:A9]3\9Y5N^7H0C-[9b
[U>\#SS9#0)2N6V3QGA\;NU2B8;XSc384NMcAdW1G\A[JH.7.L,GF<RBLUG8g?=P
99d;XeYYMcdEfcb9ZID>,3#TbUK0a5SaX)TggC4+CFX;LBYW);N@K?@C9<:?SYQc
N2KWe3IZ_I<T\[U/8K6V&ADgPAUSNB\=\I?AO&2a_KgMce(RE??T1>>c.>PQ^Z_#
7J3P,4BZ4@1H>4<@c0H>7ODK@86BZS;0dNO4;5U<:DI=Q<^>Q;=NcePA1R#KbZ,+
3.?-3_YT-cS?cOf7U7Pb9Q_cLFJUI>+;1d+V.K#-BaQ:L<(,XEFLEb,+#]6)G@>O
b=A/fbAL<S0N]Q<=H/)<M(Kd@V?efJZ9eO9:94</,>D.G0]V56M#e\I1+.HR&KT@
WKJ-g2Wb&^KgLSJN?O>RV@EaQ3WU+\+?SW(,c/^JIW.\BM]-+1)?,N4Q@;IKM4:d
7b_D8:=3VNBNIX>7.8C#SegR#>,4/8O_GSgCGC0[Zc39QH^^V0<@e3NdKD4EXD1Y
B(cMH5#P\9X)+R(LG72]QXT9)E<0Wg2#>Ng5S]ObTeY?V7DTJQW6S_K,aPOg^P)N
@\:>O+D^?^DZ[RgAN[_=_41.QH<J+F_UN.)Q:<4a\RFYZ[g6C^Q/c/:H<;3F6KG#
+,a@:WW+dF4]#FHBUP>GF=fAKWeKVEZ:e>#75Deb8d:1;[gY.1?#/^C?PM&g]Wg;
e^9?)/eQe>fZ5#\LLM8+f#RC7D.>+8+PSL_C[+CcV(AASU3=>A/0:H<C8AKO8R];
9Y[V^)A=)d6[D#2b8@.Q(?WPXDZ;9GACW;,[_>^cH)[b#Z:cU_adcS0-PHU53QIT
XHKf9)4&6)g0S(BYWHg5eR(^STR]e[Y^PVg/d;PN<8Xd/@?^(G?^//_PT;NLC&g3
18]bDL5.JK],ZRaGKaN&WV?-?499J9?;=H@a.=a=CG/BE8+eT<NEWF+KSZCba#<e
L<--<MT5#-YTA:D0ZZPcA@e1T=,SN<ge7.3X>9HNRFV09P<WG=?WI1TGQ15gTI=7
;QXe(X+faI.U?GbE?H.RGM26gJ^2L9<f]0DaA66e?JEPVLdAcgWBU.fI<M)X>Egb
V+=^UZXNF/ON\=6V=(ca/5>I[3J&V=e_;20:ACWN->Hd:ZJ_/1SEgFU(JI/Q5?)\
EHS#[L]9JQZ.N_e3f_:.5f#^XR-JD?UHegH\c;R^XJ4E@ZT]O+f&>.)/RbA36(U0
OO;;+95-6e(=_>O)(2#FMWQL&<WcVJ--NTeY.fWD,M5+2[EED>SO.LH?O<c4JNUA
#7^IINaOF1FH[L&_NbO>(>M?V0]>(+d)W[Q^+)TF?4(Q1SgB30O:aA/RP25>6/#g
ZD(RY3CXgO[bb/57T07E:=@O>aMDW2/Z,14S[5Y3=0CYI#J-b6V]c<a?.Z3>QU1e
W2,^=LE:A43?_MZA2A,_MVgGEQ4X-N4T,-V1>51X]2b=fVBGH(QE0<^9^\dU&M1>
IAM-<.JcHC.,4ec6_N7WWKEQS85D7?N;:)>Z48^\?g56)Ja3E>..dYT+XXLHaN3G
[Jge=<)WJ<7BL8L5c:4_g:P#-cXAe]D4V_.-3a]]E/)If&a,4Iaa5#5cFUO+e5KA
EITN/8F<Ze/?P9EG]aHCf[H\P6b;He6#/549V]RQ5QY?ea25c<0F.eC,8-beV==9
T)E<6]GHZ=JgWK@;NSbB=,dbF(&aKVB>\^MP\Y_D6_7DQWVK+Z71@;Of\-0[D5-<
T\UGFB?PVgZ)/^LX-eTH&0d4S#Y^4VJ=?)IaB2X)dZ_19\?;5W25-_3GZ<fJH?1e
:e1g-N&XZSM.;&f3c2bF+7ZOP3,AWA]&R[>>_GC24PWLC(52KA]3N.KQ#<K=(#O4
E++M]#6OeH@<59<MP6P^/>2A1U7d#(WE7?FNE#2J;aAV+()>)K)I>Nf7J6.:\O36
-&5a^\fCMc:&:A_-/QKUCTVF<>a2@)I7?@&<H&NFb\F7.H4UTLIONI]J_#3#T8D5
H]Xc<0TG6:Z&K>G5T/XUK#PO0_gL>B7R?Z]^4.GAg#9#GV(H#c[@D4O(8c[Md2^]
)YO9-[]GI6/SG43W7X<;9@WBC_X4^4e&3V&^H;)\g\MZWG)C;RJ/SN,1&]GEBUSb
XE8Y8:ba;feNE\DM0\9F^5bZ&/?YD7gLWY[1?&OVV-K9E.RX,B]O1^b;B,>^^+X[
RIF\D&[c<(SNfeCVf2;XUTa-E@Sf)0.P1=25]YIGJ;\E3:0PfHMUI0A8#bL+\^V5
_;K;#9?LG]ATS@f6&GTY<0N3?5#_V:TXL4<](CPA9\O2f?V-A3P^9M=9<#KbeNgO
4B6<S:bUGQd91WGgMFO65d9DO\[TKeJDQ)R+Ld1d@)0AVd\T#b9_[MXW_RaR>_>;
UUJ:a2b_gN6EMTS)F)_)UQ^EAP3DJdO?W^@-d-<AZ=M?e;KY4;#P1L_9aWa<;[+^
?&ccV[>ceSD20:R,(MZ+]DM0)/f8aQHB0.8_C0gMbJCE&I<O,;NC-=)Q_]ZSG&.&
?g46)&g7d?#eI+ICc2;,.fdYZDSHO\1LA5fF/e\cQIK=D(2Z)#5[UT4GT/T,<]N@
VSL-0H?Y99I2,d\^^2a?&&)/W+1:\XU84TL(8)QHDWZR4PL&JfF<.N-[9PWL[(/+
C8R4-gHO>#g=C,JB&EKN.-)gf:0)FYO0RgdRC_&WMb6f=PcYY:3@L-Q9L3aP=\Q#
+&R7;6PYS\4QA#QY2<28\)S?/7-H?c.,6.+#=_16L[?W@Q]E&Gg2QY+=YC]ASE.8
QBQa-[DL+A;ET]eHA,UC<;g@0K[8K1/AO,0A,>9=NLQaSPKIfLL(MecA)Y7+7CV.
PC7d7O_5cQ2-@3E?MGV)#S<GO5GP/[]WJ0g?-&NK8K=D,Pb.15_aHP&QM])#/-FX
30g9I(]ceE8;.Q?T+,&5c^g5;.RUK3286[<2/^:&A5Y_0HGLUC(B:)_0W)fBC?e/
b;D2e>EUY&d>;IKg;.9:G\+g7c]E0]QL)#B4\SR62Z7@N(^[_M\a5=3O[VX?Va9<
e+O/WG[DS?<Q/-O#S<MdSG+0AVJDNeENHR,68,dB_73BO2LF>;:P.\C;ZTeb=XTD
?H,W<ZcQ,=&>bT\X+@_93K@2BL1E1JSQ+(,:eXW]N0ZA4]/2?T;L&MFKS:L98g>[
0T/Ta?<eMgP2>.C2651Y9.RAP49c?]UW-UfR3LIO[PcN#LPEA^C0BRD<42H;D/-2
O\^>,)HZQ8^2XM<W?WU-2+/^(8&/GaeCIMLd+V)c8&\S>@gO3c8.BU7DRe,,0QR<
<a7d]&&SbTO8-WX7Y(#Q=LI8RdNS)dDDTZ<SC.Qc(@+;\QPCOG7/ZP/AH_8EHeXX
HIJN&P(=@Y@][]YR=D9JW;cHCXTc]ReQ;F6N[^WdJ^(CBCeAc(=SOU<B<&-T+8:)
/8AHcV?[E@>fU__;W&-WFZSbg\:T>J3PLbK>d[6U9?++T)JaYG^ZDH79[E9R67QH
3d,XXEJ;46=1H]U@PGW)e\BK_3&WMLNWP.N>7RENL<;B;(LB&H^gNa82]+A1ABR&
F)QP4XIW)_AJMO\]XbEJB<2eG0e8d94IX(7\&I2_DD<N4E=6QC](V2-C]]SWXXgO
4g<KE/4X86L8SPN78e)adHXc?dD;&e7=70OT,S=P8,F:<+68=:bY<T[QJZ^5DWg1
JdQ@0Q7^Cg:g(X_5U\cf?;f47AB>XE_SWPR3R+@N1:Y:Uf4<A2:IXEGVe^?LS,N.
F<]?UI7@O\/+5JD2eLc;0?E6EM8:f[9&^#ab<LgOGEHFX>TYY<Lf;X._5OW2+)&Q
==>KEI:3,..7a]8-DR#7YS+U64f&P0U&K;EIe2EP4AQVPENJ.>,+]F7KRIMGNST0
57gS3OaZ<f0FO0cRJ<&;3bd+#S@A;>/#d?YM38-YMIS,46CbC&5>0H6XA.e(#JCD
2ZY)X,6BAS6PB<H>2R8-;8KRg<(c2\,==H4f=d1685WIUFG2KY9F-LRCNV=TSe^)
D;ce)e,L6I.J<E[Qaa=<4ScQd,8T@<V>T(/67)^M64?JMA1<feMVT(X]07gfZ(-S
<VZ<@8V:EIAX6ObW0M<B?1=E384D,<P)1K59I<SIXb1NJE.)c&c8<4[I7Sa.SeO,
5V]F)d5\RTJ[2/Y4FC1dd3EFOgQE>?KV-ecE6ODIe@=a^;<6S?AW2E#TG-e)>0c,
R[B8.;N&:&K2&2BJ5EC^SQc/a\-K&,3U&E4Q&:.8NHfb:0LJ0UgMCWCb=F/@@egP
B8O?ObU,M+7WFX#D3/]Q]D9:f2<=HF5=(6[/2\PZLC:8/Jd^DS9B([L[S_QNL4N,
_7GR20C(ICU-]3&KXKL7.&_a60U2c4f^\UGW4KZJ_beN?U3ZOVP?4Na:R-4fQ7b^
e?8EISbYXJEL_I6b2<bX4OGG7\AJ_&MDT]I.,H&@SW+3433FV-K(@-71B<94d:TW
F@(RcXEDY+a;4>J:Q,SLgeL2=SECOBg/C.Sd?OF1P_gbdL8MTU.\ZRO,^Q6X]g^R
ZWGS@4ABVf)8+IJd:.B_aG2&e^6?.6=1,@e1=]aLdQ-PL@L)+F3E^HVWcZD6=7Yc
#b6;&-][W8>8V//S_g?5b0OX(C(&RI4N(7JSXQQ#1[C[bSV=V@dB\X>M_[1Z5&-;
Og]UO(J2&N4FUO0??/9MAV)_;\g?Q9Z,P(64O<^QT+N)5V7J7e::AEQ7\9-^RfL)
g1c:_HKKQK2fbJ>+1=JdFNJeW/W(,)CJZ2aV[NNS04d,>L6gRgC>GPB6J8cA-3R>
&3+W,CD6QV?3]cUgO.ZZ,3A+29Q^HGI1+X[fg:))6OJPb+5?+gTRPP+_J)G)bd^E
1.d<.7R;C5[b:Ig:MJ/M9(5eO<:=&Z\0VP?J+^=13c0Wc#YQ;Vb6M-_T>H;]2Qce
fQX8PV_\/&4:YK_>;d,c1-Q6C@)#DDHf)Q+&W\R=c-0H9U8:Eg0[K/MDcK9V[;.Q
f^B@[M@RFY]7.2)<K5B^(SEPB]A,#N-]cMC>6a2\Z+Rg_WH9P(:T6GHEV>KY,Z[6
^b)=b?1AIF86Y>f_L]&#We&XCG=1=]+:gb:b;&M)Y#^_PMe0:=B4_[\B)NEOU<)-
Q-&7FAWQb,8[0P-d8UOeJ#&52c;C;Y+LI&@ZY2:GDYQZM7Q7#,GfKH)]B61:UBRe
=T89D3Cba@?,dU64WR@HK511f@_M30GFbgH[Q95Nd&/^OZ^I?I62);V)H;:L7gN+
ATEeU\.XM;JR6QLXI;g]5;2gR\+:N/^BJcUCGJHBL5T[gaY#IIc><\^D5aRf;+,I
5L0a13/X0+/92PQ4U:G(MI[4&AYVMOdW:9[_);2(AAeKL)FOD&&/d]RISEZ)aeF<
\fG.J;-0QKZ8.N\^I3AJY]E;[3d7CV?9^-K,?EN+P-5668(#IW:,b/S9N[R<X3XM
D9b-PLe/ZL@/^gaQKf^GUTBR3DTQ2XU/17\+ADO@&d53P@9/99Jf<IFP8cWGfd@G
:8]J^fCSaPLTJa:,eKU3K7_4S(HIU+&_;)9Z2]MRIC0&UBG1KLWKMJcA0KG/.IY4
B4a__<?,d((G=0YS8]-DC(IPE)]6G+Z\K6Q,L];Uf3>7\YLG1NDEOIT+aM,3g9A7
Ze9]1]S1::MOaXR#W7E(7PZF^Med&[[aI)^.A(3,IYLPCQ86(A1G<X>EO[\9RM7U
+Y7a_e^<<I(WZ/UM_DPNB-[LJLKO(eS<\0<Y7WLDcHBe+(C[]?5,\>90b5K<+SPW
>1\cI>6gF.7Rg45G4(GB^QPC)7_W[b/OEc@b@C:bL0J5#\5A:PbaZGSK^9B=&fSO
:<P(SKS#JM^;_WM2I_Q-QD_b&(>OS32@c78XXXVV(V5cP8;Jg\Z^X(5\^QHe::;(
C2B6T+N:&R+^Ne\4gB_ff7]dV1,>1IM?[CbU.8:&C&#Y;R#e?IeAZ,>DN@_XM<@Y
:eQ9]LAWBLJBOFc:aEHU</@8Ye2-Ia;RF9/eVEQ9Z;VIO]GgV>RL,)0Ib6H^g/<+
QNf;BM];S6a2N9dI:Ib.JU]0Q6a#4@48Yd67N&SXUN+WcIL/3&,eOccWD9.f^P7H
D<&dJC+\2]:W[f>=O<KMX=Vdf0+2O1?aA(+]<bKBE?)<+WQOHdZ<M1H_Y>LQQ)VE
X,0@X;COFfC3I(abS6,.@g=C2Y-B,e.9V1fDC:g6D=D?G=b_U+SWC<G.@Wb>0Xc)
ba&Y<=UT6Z-#<UgFEX=&ARIBL]d9W8U53,<g:K1B7:_99H\Za_c744#Ja1J8&1cQ
J&0Q9E9Te=#g,FgAS3+2^gA6YE<.Rd=g&C^^D7G?fd<=-^BM],LNHI#d/0QZG7^Q
(A-XU09fEL]#]C9)5;K?CL3-,,QKUAI#CH-b3K@JCeg.]8=XJ=6,F9cf0bPABb[Z
(#?=d=6a^ZJVgU[eL#aTf_DWB\4=+g:BM?5?O5f&OV/K]DA#]064ZV03(SWX=V76
g)0Y+&M==62<LSGfAVcb9W051K+Se.756bd#-DI8WM>dc_bfI2/JX-VIHCJHdSW\
1XESE_gR=NSK>E3:YEK]BMfaTZfc@9Ee_f,O9[aK_6+IEV4bLC[?+=9=#/\FfKYH
0T0NBU<+D9^XOa0\O_VC,S)(3FCNRRe.b5GZffC@)+,P<727Y@\G4>Y30P)YXKGZ
>F5HR]HY5e4\P0&.&<SCEE#@;M)D::5@BAbU2]VfAWYWB&7/OZZPTU?(Q90EgcbO
UgNgJY3e?Xf]/ASb-0_bW1QC\HC7:bL0gV9)5(fT_c:]+cP-JD3RXVNgBLGXH&aT
Ca+UI?g#(;0L>a\@?3^F@-WfEG3W:ZW(,/@f[,Sc3]_<ecTXG57aZYaNU2>G_:3:
9de>KA4?AS#gQ?7aLa0J0XfU;KA9<5Q\5e772ZXL(S3BM3cc@Y.QR13A+AY9#Q&-
FQ]O)>_<KRB]WN<?YQ5R;P&bR4[A7L2e)PFOgT&B5,cTMLgV7fg1QbK(CQS,63>F
XN@C,ON_D-BFRgaZA;T=>IJRIVaIFD/_B;WU1HY=:[WJ_E7Z&a)@&8L<L34N8cbX
C\X]FT5HS23<CZU-I=H\NAaB[eVMT^[F8KHQ&J16Mbg\A;#gY/geN_2_TZ#X>Lf\
P]KT8NC@P3A/PO<MXg1DN-g1#[X.M^6CeH\Y_N<.9]:]HQSa;WAJAX^P8DgV#f1#
GWFcRXZ.H;ID=#>:Q1b)Tb2(49;c)E<.?)5P:0#8/)?SAN6ZOdH]4POIYgPeKE>f
b-_gX]SD_fe=Rc(C<\_Z(?FbZZW/[]Ub;a>Y7SOg7.X#</d+cg&89EE4Z:9>0]7T
c=4;b0Wd)/NTTT0KU8@3T,aO7QIPJ?+?eK^>C.E9b)7fTQ&((=W:KE2Cde66(U5P
RJYa][3^G56UA[3^[/]B>PUGZU)b+A;CaK:PUZdf#_3#eX:8_(>E]JZC5X7.dZ;)
,cX>-P4fY.;DJEXe.F^DAdNcB[92Of=CMZ)+fJJdMb.Z+>3ZP^YT)8@--=S98f-]
.MRE\#e.G3_T.S22=Y1aO,H39f(E_BNB&Bf)-LG:[SIa(WUZWCA;ZC7576_d<H,G
c-D0&NaY5[a0dJ81:Z1CH/K9&/RbUaF^4([I2a#(-7b);GN[6L]&]2&Z)/gKA8C.
KX=5e=R.WQ^,;c>0L1MD2ecM=.F4e&g/2VN##;>#6\&&MfVTYa[-bX?gLQL#Q9T9
(D4@J^B<KMF)[O;C6c&3,BVDVIUM3)b-?X0&4I:Jf^Ug9b7Qe/c^U>IJNBIIZA_F
+@R4QeS=W[GUUEWV:Cc^T=\cE>UUJJML1TW?3/U:(K;#,6)K\Z3^=aMDL(A+[_;f
>SBN1<cdDB<;Fd??dQaQ6)3M,.XEL@^985gN#eRB(NT#e^)]V86K/=(M^P=>X)E/
W=?eP#7\aQM^P(KScG;N:<MbHABgWNH+a1dT,KYg2B\^eA^A]b@+(4@?J?7DO+<B
50GJcdWLJP5;/M/S3eB][1Z?=\&3TZ7Vf=.WWED0<ScHH2P/eU/A6_H\7734e]Q6
fea1D7W5/-6UY\4LH2HVd_?Ia&C)X7V&DQegYMKggVTEC3[-;2&;H_LTWU<XGH)J
YFbMUU(:5_<#(5VWRSTHf@M[1;P2=LDVA2S\.SAI(XAW.[\eX#d1#7/5VA\1fc@,
#+dPO[:2]B(YG34=6HA>\B#K2Ka]LCe8,K7B7PBK4.R^WXYUM&U5M&a11=GYE5R<
gC6>TO3:<DLb:4NTHT.aKd#(R\L:2WUQ?V91+\W?0O6^cIFJI?BC9IS#cG4#CX5L
OB(Z@6+ZC)I(DCL)9aWN51.-3)^d]^a/_^-&46S17M@Z4DB_=FH)NWTXZW#5T:LZ
5BbNfP?VTQeVGV?5FQfK;N,\+96g.+b<<f8=f(fa3K)I)W(#.gR6EC&>7a[2/72^
FYW++S]c8,O\-3,gdX+SAZ\KL)NABf]X_a4H+^de69,H1SbO3??B0.D/N=/,Y[N2
2d;E0S6^Q4aI9fOB4-\<60-Gd?e#,XLY.EgYOG6)-Y32Gd<cCd9F:,?A>21NMFZ8
Jc&UILW1]FB[LX=8Q81L8-@]K-K77(g(0W[X^c_\T;2(EB_dc<6V,-MZ/GE+L:0:
bWXATB@#IKE(:)_fO3Z-g<3RgaUQJ9)O_XDURH\=JW?Z.V0^T85MVZ7D<TCYRB@I
;7)2MeXb/AZ^1SI:<6@+)U1?S)Cd@,2QEBU_G<+\d9,A#E)1^e(eT.580/2\[;7B
D1N>?bK4R0K45?MSbg.K?d38b8A6XFQ85>?SS;ZEa0FL]XI6+0@N<;=__XQHa<]>
X]d4B)7@(e7c.\bHM41D_(f@A?Y_=YSL/W&<#YT98))CI5D;Q6LBN@[++SIY4#S7
<+#I37g>R+\a@P+DdS]8d>MC_Ve6^\]9K@Q(C7D.:@;14gY-fPe8#):WID6-KT\4
S<5>/27bZ0UaVVe^?c&a1+cM>WTeeY<2-Nff>H.MI[)bgG(>f&&KLg5TOg9G0WP/
O4TCRgO]]Y8=XT<0.f]dYOQcRZH)bCR].R94Y=]eYI_C5SD2[KDc&])Ge,0^3eEH
S7Z3E_I6Q5E/MGN7?cdYS43-,:<(dA)]&gZAV,DF(QIPZcQTcaA&##\@\5e)P<L^
Z1+@:LfK]Q(cFVH0DgUB_\BXge#SELIWQL/&M:MYSLUdZ;;@JDP;>a(:??GEY1:=
08WG3_,5FMLee<P<U#.5#Tc4OPKI\bfJ8?9;VW,EH^J<>S\F(-LI/ZMK1+?OVWKc
0Q?@;^W]EG^0I6)#&+QNa:<OP.f#M\,_H)P6.[c&H6^@QeVS0b/NA5b==0C-]]D@
JMZH?/.VG0C&YD3=@)9U:LOXb>@&Z0\AS[C#T><J]K4c3PA/\I.VB;]KO7>XVf/G
2g5c:dA0BSPQFD<-U\4d3E#75A=LOLb3C-M-P^?X0)-@Y3B.TC3SW\Q2I(U_IECg
6\975L\C5aN8)XC,:3L9E9P6b8-KfU1?>:Q[&YT+EG15>@542?A?=BQ9^YU?XBK/
GYZ@BZgA2K55+Hc^5;#ZLfe,G&6?#+89b6JN.>WCa7Z&7>CVf09B/K^OSU;-2?\a
1)TaT_H7(]-YAS3dBS(:2;/MF.H7]#XUd[Efg4,0DA0Y+X0[bF#)VMF]-^E&1fUB
\D.F+a69=[<#XC6B.<f;#S@^e[N80Y+0RI44Qg^LaGQ>WYAO(TRBeD+>R<TM6X1T
#3#=PO(4g]_^&F9KS_77@X56^P-Y]1aWJF3F][/)g[/<Oa_QeR[Ued=7D9N]FTeC
WXVE?#I4>ZI7YUc(b_cR?G8[5A0Z6.OB;JT9]Sf9F,U5bN<;K#O?V0TaZ;Gd[5[Y
916B4#6KX/I_O540HWJbAd(C3/Cc5;5)EbAV:+:;PRDY&G?1=:)R)Ee>FNZJZ:I,
F#U#AX7Nf#XO6\@A;N;H#a1R5aN=GG=EA+]<8e]fgB0G?R+JLEbM1X@K&XB;S/9:
>bCeILU7&>FcR.0dN(K/d]\#/#LSQW8&W+\/2N0-YN7cUKeI9=C/N8@Z8dZ<,P74
R<FA05P#L@P^(ZRV1c):;e9300KJ42I+A9/.-J8V]76ULK&a^<HNRgY[#OENgQDQ
V=57gHMA=LXZ?a^\#4)F54>Vbe7FO]^KE+1b4cfEN&C0]JOY^[:??>#gRS&H8>Hg
I:ONW>>:e347d.ga_fL-FL<fRgR&1.WKY(/0bC[BK?De&dX,S2WQHMU<IW&+AAA1
TE]<@&b&cf.I>[-6Od>cJ;R,UDcb2Y4JZO#bC_eX75[#e>)H82Q+X:,=SO.aU@\8
)YcZQHRDe<9a9>eeU?ERDBQ^<d:13[0Cb(g//ND8<@=9IR81:EZ<D<GUgE#EPVMa
CAA^fCPEKAea:7SUH/0JG;??\;C?Z@/VX4<R#_UN:OY<-[M?Y<dHfZJc(@4:]HE/
NI]5=#P:GIJSNESG#EEfTU;6]b9#MX4#8EK<18M6aH7;U;(G3T^b/K9Ue[Z(eg/8
/T>J(;0Qg1H;0SSKcWZc6-R-R]@[UN7Ha&1]PA]7+LT8KGS^=-Ve;FUR](=&@9ZX
9;EU#BELB8H#>4,Q:\.b;ZdAX>6)[QcP#>FRIf@N-?A=ff72BA3-aVP4(3VP>QS\
9DK3WE4gbTUS-L\dL1fbSV\4^D^+>P_Y2P9ADL@2Q;]gA,^OVK3IddQ)FcaN[g\;
/]d?_)(LB8#0-X^RI>934W>;HD]I9+8G(W4<2PN#=A1<ZQIX[Veaa/,/71?](7TW
_51]4S&O62&3_-/5X]_SQ<Z>BI>@;a=GYVO9Xbd(-04(T4a[:MK^5&Q_O)\&cg8[
KL)fW0^,e)5\T#]2D5.9O093L+X:P-GD2KR#OHR]L6e6Q-FK8LcfL3P&(0c+VS#4
fNCZ29U<O5E>UFN1e/\N+7U\3g@0Hee#Q5.?T2>B9+&aA0@TBV>_/.=YDf1(Tfc(
C67L#:PV7Z<^5_<ES[093KbI33A:8H^@ZTC=OeKI)/a,dG#4&,[RR[JD_Za6CNGG
fN0C0KMRRYIY[,EI9(d;V>(fL,eQCFH>g9<#N+XS)#bV5c<Y?X])-E5gX<R&U[GK
ZZX5V2>F]R7+cL4=\\SJ]g=ME/QK)(S@X9U<GcO1G5WIfF2P=3adQ13&[>6/;1Kg
-)E54.XY]OV92091JJ3X(Z5^-N_[&[M<2QL^=3P+SSLe@]101QA^(>W#RabS#J6-
31LYFSW3\.;cV<[L\MEbT-M^d=KIL5.8MGV7=8W#T>,L[L[C?;\:cK?5@UAZ3gES
3EW]YfVZ/<?[?#AWa#Ee49T-.B,Z+RO\P>dUTg:ET2.&W@2E0DS[O&EaI9)3<G9E
ZO/029Q=Z&D,LW97P/>13FQQ.(2C4#72^F1c^S]?ggISPK]-C\)[0Sd&2Ve/fd58
?[?H9ROP5IF?BES<?]9gS^B2>^]ELG1;RXPNYe(Fg;0)MBacbLV9Z^B:6:-V0_ZU
KGHCRS41Y\ce.[[FOST^/3+4YGYZfCOES4B)c:;N#\Z7aWWMGQO@W5?R#C);_IEH
V?C2(/-DU7NI4PJ@5D?<I6,72MN0:bRA,\-MAE>L3f2,SY030fYWHg-<8;e-[)Oa
cB1X7Rf<V421W)UNVN._HQgVTD2^[Nbf.^PG:Fc/YLLBM,J-BS9V[76&873YKb&4
dW3DTe<Bg(B9VJ+N)K^;ZD345X&;)HYPB[XeM=(/YcC_;UXDU]1EOQ:gG;c)10aL
[N_1ABRM3a_cGg.ce-0,LL&<]@7:bTCZSI)0.+\UYfa@-4Pgc[Ca/[)\HG+ON/Oc
:0/VBOQD0A]9;LAN+Q@Wg<J-+8dgOQAb41<<:Y@=21LR6\U,]g+g25;QW>:?V?G.
LO[CC_?E#L9(L#UTF2E0D=BAIB(KGg#PgEH^ULGg@fa4@])f]@V<#=(<PC7=-#NS
0YD.\V8[,)<>fRX-P,>:R@+GLR&.7b&+S9N.9,:bS.7^O,d0:,>:7?@C3C/Z9MQ7
SW<dJGfXOZ[#M5M=6N\>+Xf:?B^TfHY[ONK@[/f49AR[H9Y-A(6<DPeNKY=+(bUY
dOQaD-HO7A67Z7.;g1KcEeF&G4?D.1JO-G2#;]C3/C5Ma=S;;OG5BK)_;W3,77g9
P>G<4GA_La:#4GGQP0ZfG]NT(g1+dGHE5\0?&OB_,&(d04f,GE&1dNd^Z/3P6]QK
O-Q_0>Y4MWdS>IU>@#F@&beD.AV=Ga\V2,W/@1AaK);WQb6a/(b,P?(d3JA^+Q\Z
HO^2<gb+F52SZD+4VXGS4fb>VC.[28HUZa7-SIRF^T8a>9OK7d?b8595@0CQfWT;
a#ZJ#\U/90D;K7H21V9RC051WS(@2R+@)9J0:=a(LPFGQ7\E(1P4PaU^]^a;]f(B
1O4J=EQPDKC\bL#P<f4cB>H)]-2B^WG7R@.U4@X#1I>Kf[Og-/G;[82/Z61<NAVP
,ALf9G)X?LNVJ\O+#NC<EV/<e\XPI75(L,aG6,9]Dg8KN\0:ZE9:8U5SYVRBV]CO
A6;.egY_S9ZR]PWH/X)HJ,5).[c1?;W?MW:X,--(L16=gf=/RZPGL40T8JfXPT9\
28M(Q1bg\KfO7+H)e=[]b1FAeAD;,f?.N1[HXAF+gTOB:11P9Q9[#,36e<QGE&L;
_^^A)PZF(/<VVHN2H[Ma-g(,9Q55E[(PW3:Z=;GaQQAb#(X3M=+J133PX/3F?>6O
6E[CW]0U/;IF?\)?/cd0KaS=_8XKUP)4<Qac3CPW:P+7]G]^d_/04UC5HbZDBB@Y
S\DSHeLd2#+C6#e@<(I\FD/K;)WN^I9HRIX4gS(bB;M&de/cGXOCD4U42M3V4//W
\8WI(bCLAW@3=):?L(#4]IK&V4Q9:a60PJNfc90aO>.=YT03cM+BH,I@#IZ6J2Nc
#-7ERPXd=FPBQa_<#=J(2_?VO:PgR2?dDB-_=XDE);-#Ob5@<YVC#][(Q(7gL9F-
gI2ENG-3,LL.PC6Bg<CbG;O-NIbZ#-;=g8SJ^O<XcG?OF/aIcL.Gf<_ED=O:45DC
?3E_=ZCJ-^ZP?PX;>PEZ@5[:4#DYg2\RcK(ReBa)PA?43/HPZER>,=6b\T&_69NU
X[-H0S<H;W>T.:B.STWf)Ve7_X:Y0#.N+O\/Wb#W4O5OSNXF?YYbZJ9EGS_f5H8g
;S]6?dR]^=MIDRYbF.?@Kg@WLC7/=5OBE(#<CK;6Y1A+cbH1bfYZA&\?T75A@Vb4
IU8VgS>MMQCO(a>K?>9^f8;=LF82[A:-T\6aJ0M>S@aB@-<J<)/>-BfLTVg_JER7
])&XRKR(?BJe0]@U1^WQXH]eEXU>+adDNU4cBKUKO(9;7T7_J,65c.#^P6O/^T=a
5PAKOT^;g)(XB7<;I(fd_QG0PO.?1#)44[W,.NP>X_H]5Y=Y^:fdD&dS<5Z+PGcH
>HE?8eO5HUSaITT>Z@5]Q/PSBJ@4F]89aa,KE)EVFG9\LcN9D[PW2[e-D/7W+A\<
=_EYJ7dV<05+a8#U).Re1(=7_c;4U1fAEZ^cH8-MF5B=U^CU^NgU10I8<c@Ig9Y_
D9];]ObK]3U@1IIeGNU-Z/)&=,Tf+eI^QbL.</8L)ST1I>O&7b0_-V8ZX)N??d.d
=gRe\b(cWd6R9AHb_(c\BCG\1;-078#_]@;,5E0FSY5J1:_&AP>/.cc984XO0[K#
L;ZR^PABEf9(aQ0N>bbPOYKb=XDeaECOK,&#X2\K]^;;f4T=B=(NYK4K/PZ<3M2Q
C5MR=,0Re.;8@V;CEOML&)>A:;g&1;+:-(G=VfIQ7>ca7K/@)NQDA;d2&7+&(D35
N>6EK)42VeK;==SF^CY\WF7:JacD?_^-1a:(-FF4_TgNYgABE2E8-+7gR+#/8W4#
Z5PNZ/-1Ae.73&5ARg>eR-/e)c7ab77T@,J>)+<;fYR=^HabdQ?\M.^MdF:RVZHK
9JfC89RFPI(EU&2/H#QZF8.I?Q8)&#[S\Sb85fK(_40(c.cF\DSe,85d+.:U9O:6
LS0;Z#gZBI-F\BI\5HK\J\:E_EPg5OMEC&\&;ZEY6-RAR#cUe,2A9e3FW04)(54-
#=GJFU@S@:MO&TNUWRPUTWWEBY/M3^\N_Y/TOC#X(RHY/TO3,#\gW4=)J7FT&[J^
SN_#STKAS#C#+KZcGd[YHPO?gLC9XY73S#C_62bb-;MC^RYDM96NgSY@F1ZL>bKd
bXF[e):2=2^.4ge-XC;,M?7HBcOOLeOY[f3)MI]A45Le4#_V=BKf^.CRaGC)_Kg\
35cC4=c<JP2\XAW].X;B1Xfbg?LZ=P<W+#>IF,\FKQCgaUNT/U<-@=/=ET69PO:5
)+^P2H5GYgSBI8JgWCLHLJ[Ka.#\+3O:V108IXO-;68^dYCH1(D;GfB=9EZV/^BB
X&2fg8Xe=I3.C6Le+Pc9a?HPMJ_1;YJ._WQ4/=\9f);;04E&4:\)NV1:2+7]?V_0
BJ3EIGJCgW8[=>>4=VL6-3gTeR[18ZM#W7]c>@M/TIA@8-)FQ?^1X6;.;9LO@QT2
J9@5ZA+H[L0U[,2U-eg2MAKEK=3c54B83)[_U6K8CfYCQ2&[A[CNT-Za]]N34E?b
:c_OV-2F7OL.)8-I8/_VA])83b&[dI7a?K/L&+,,19c,#L8R;#<U>RQ3(@CXU6#I
>7LPPc-4]_fJbTONE;:XBPP7P5bbXa7ecMWHDQ3e-RMWZX\eEWAEVBA+8T(F:d01
VSO7<ZQTDeSM\9K?B-^L^U]EH[5BSS\(Ld@#IfSUded5N3&Q-+cK=[=.J/&,^bcM
4>)(#8G;\Bg1(aKRG90O5b)HH,O8,#VDFBE06V&c/^Fd2.=N#eU5>#+RHT>JEVV9
3^2&7FD79XC_aM06+5=EPEWc4+]XLEP5KU_F72.Y+b(Qc537Y3VY3?@IEcF)c-:?
A&J[ZA_@/1JN1M6<3^X54+dB184R?GP^4K?+A6:W^S&:3VX.<SB__:U:7I7G>EcA
:1_GUg[]=AKDE1RV^I60(I]HJKYZ8]FQ3B+9/AX_TLDV1_ePOOb37-/0P]:6?S@+
e>WeBHY;W:A#^,TC3191JOQ_]XDac6AYFBXc._SCZ6OW/PEAeUOEfN)2cPe9Ug&?
0KKQSVC^F6Q3NT9GbKA@JW(b;;/gQ;(AE_eeCSLXg7,c/D,QH#-8?bc1885<57Kd
XSLD_V7U:aa48Y)RP@1c:dg1YdcaD+?2Z+OAf)/>C[GG\Q(74]f>^E2gM@^_VG)G
_W2\,N^L7.,Q=K1T0Xc/HK&^6SO7N,2Q&IWUEC8P;J:X>23QU3,OBaUdS+dX5F?d
1_3;L];024T)Pc4C6EE;R343>cIRG70OX\QeVU4]5;J\)gXH.+@d^-#NJO^TgQ?5
ZS<T9gT^=(\J0PAgQBDd/J3[0:bb@2bQ-/M#)3K[J((#2OC96WdQUP#ZD,eJG#:7
6[LRK74(X24I=[D#)99OBZ-VUMNE+cJ@@,_dJg:?MEg^HSUPUED87WQJ_g5N;81c
^X-OL/If:feHADgU(6D-N),SE=NQb,9dB;9=W[<O+)A>_b?FS-Z4XabBUM4AH.T3
Zg/;cF9a4fV\64\U:AM++B-[H4J/;:K0Z^KK2e=+e:5/FIc?_d?Mg2d3c</D=a9;
KI04Cfg\GgQ7.YD2NILBfM=1>_1e9bX5a>ge^Ld&YgKCO<[)[aY\V8UE+aMT;NU?
CYe?OL-1PI]bdVK\fG3#)O\^3c;Vab=^,6JC;1#?GaQ^6[.AEGFH&ONMbbKbcc(b
Y9=-g?(=5-5LA:g>T<^X6;2=#2C]UOMXT5EA9S:F&IG,T+_JJGANb^4T+_=L>(:=
P0a]=H<:),G]c?1XN=:INLWg>D7Z^B7AL6eV6^Ug7.=?.\YICHfY+N+Z684@dH8Y
7g4CU#,3]0)Y#+>3LD^8UC/#(XGBSGb^Bf@?2=,<F]L<B_:^Kg\2a77ICR5[@cM;
:4aK\KY?<Ec1ORT)K1d7MX6DcFBOLN4OA/QM:CVgYM-YgWP3,KM>SfD(MeUFgS.#
Y@(\-(W5P+?(MVE5d,YEDQZ::[cW@-]>+GDS4fcW<D:3c890/)3+&Y)c2,Y&#d-.
bBGKFF>2&D2L2<4E&0IB/#-0N[3#R8B+[F&Yb0,P88@UR@#gdNO9,2:BOD[=Z(fU
\]WTfO1)43=6d+B#EK4,+D#?BC,?+BHae_97cKaLRN:A?]4F4]YNd_KM/F7[WAXF
fL#d<<5=ccE;578D?MT0DGH<KH<dMN7M4@[eg]\DB4MV3c_._#,g4,<EJU47S#Od
]fX/3QX8#[O:WO6;>b\FAAV7+ePXX4@-?]U:SeO23^aLb8ad=6G<gS\,eXMI(I.Z
Q9[52-_,K/,][NA=aL-70M7.XNe-R#d\,N#T]M<DPU^bJ^J[WWP7@WgX)_5_<@0G
b:[7b]0:B,V&DJ@+.VJKXdC\2O<A.-?)T7#[<ZFCc[c^VRV^WC(:4d_T)^b,&(1_
T6>_PON5(XJ)Z/;T81fbVQ[.^<Mbe)LA7b&M=T_N7V[PI:.Qe)>CC<b3\71^E(GD
G(T1\^K5bB?<-J@e?C&(PFVKaDFN7F?O^5c?_)dGf#T+XZeYb>dZR69d=,-)dL.O
OM@E@cB,<J,E.MR7[>bdDNR>2;HM=4Y/BB?_.U?Wdd[[N@?6RP;]dFI8b\bJ27.G
QC]a(aO[JaH.<EVOO#RO?4(9F>f[P:ZY(@.S2afD5JO4QLA0.WZ-;Z?-9(MR4MQ8
H_8>/Wa5G.H?]:\KZD80c;=O,Q>QKLf7FPZ)c#VUI]g=59#()Z8?V<IS#Z@+QH9H
NJI-6G=(VM7&8)Sbb,:[<G3441LM,7\(082#e(/-TA<,YSMKHJ#._ZPY?2-UM.+I
?:7U])2+0X_Bgd#^-P8&GVN[c[2<-HdT<gEP883<Q.e2^/477a1c+1eX5LZQV8Q:
>(+7?fBXOG#L]8[@+HK_7HJ2R75Za9MLSC(ZK(/L&3C9fR-I4G.DZXBONFW;PU7[
V6F\=Z/SGF,JY&cg.9=GdfFF3.cUM\0;Z@SCHAN-HA59)6LUG@+\NK70-JFM02Fd
O:N52f#-:eNU;Ib@5IfY^@LJ>XS3K=bJ<1U;F:DUe\[U?Mc92&Y/\faJ;NC,TDK\
:8+J=f)A-X,(dBd&/H?Z1?E[bQH5DAK0<48APg5R3)->/+KB#.ISI&DVaPTT92ZG
cR)Gc)3C+OA?OeRX,R/29NQ4aCM6+YgV1_26JJ)K[O/OgbUVT.9M7N9B=a<.M1;T
.YfA.R-C3UJ06V7PCTX4(eK=Q.CT<E6^OOZ,V[HA0#RN@/2J9LGS(T\B_9?6U<<2
:C0:]LL#Xe-_@-<R80R4.Y4UESFT18H/Sg>Ogb;U#gNGV483Lde_c7bgE)AY40=2
T74AOA=/M856#AffVWHO6M.9.K^E<5U;5Ub]O&g]?bF.TeW/JVe,b?2=MdW3b0\a
(DK+4HM&Nb?cZ>g]JYDe.-L04F8J)K;MM(-BP7^:^_2ZaCF>KBE-<d-/#c^2V8PB
BTBYg/gaOVA_0:E#H:RAL4WPK8PK&Og]0T(?-,[<5&g@CD;+b\Q]R&(H77?+8;2S
5e;L(5DK[7[?TW5C4)(b?J5,K0]/-?XJ2U);P/N=+)&Bb8#7,QM(]&d3RFeN(_E2
UWc8_HKIOe<AVH/da1VI,PN0B0aaD##-YaIF5b8-bCH[aI5+_80Wf(8c7I;.S3T<
E-U8>#MADL[GIO6W\?V##+C(&G&\a-:LR?.C>O7B7^.0+OEPNHGQ#dHIL7Z];B]^
YTJ)>;<?X,6+48._K\V=(+0N9GU/Dag5Af)?O206U?:E:-aY>AQb:Q6-4P#VZ.V5
D@C.CN(KE)FG.G=+49FV#ZB[eE.S?V0)O\^QMT>ERSYQYS-Kfb7AYW7<A5SK3<>5
NAX,/fK#CHDC\X:gJ3#I+51S@g6f\RZT41RR6f64_EB2-KWOHX1QCT5ERDXILO[;
QNPOR9+.L3R(+YO_)M<KRb98?b]eW.2gJ-4PVMUCAZDV;-M@28X9UHIHdcF36)0B
6QC>NMLOFETcbF)6LYR<R<eQPeOCFMX0;b3RH3c)eN0cO19IC1S+4b#JD0@2JXM1
6DV?H>=J+BVagPD=XB6f8U\V>Sa>;-]ME58a-]FgP:]XU,SVLI2MOS=4F<7YWcYI
dYeY+DSaHXE;6-QV4dKBJ_@LdbS/6[TZ:g_M>@)^bVSV.c4-ELNXX/G;637AXYS@
&;eDMH_/d#Ef3@,P4g\=F(MI)&H<+._1.Rb(.-MF]fLeA-+,+;AR<[J<T,32,NGb
_0;<]J4YA.0g:V\Y73[+4[=/Z,[/(YLCAYK;H7[;NdO85>0SN9\<,P0./e0D0OR0
Of[4BAO=59L[4C7eWYX]^E86SaI?2G+-aD/B)]-T=+=:VaE++##+9A?55d:MNYDC
bCRT200bS=2.KJ8.SDJI48J?D420T?+cC4&)L4/A.VWDD3T8LQP#/#Q;?0N:BPeU
#GPGN0MIB:EH53dWT0>>NggXd7..)><V+,QJ=ZT9B\]fC.cRD)EA[]b@+b,\I:T=
/B\H/Z1N0,W^e6f?g+9)EP+[RRg,fV;QQ.XRLSC7#[&)#=g2aW<J1J=29,8?Y6>:
V<L:>J+/(D,fFRF>RQfFdZPK76OAaNfRc;H/GAdG#)&b4a7f>GWZ#8W>JT]f+bb=
\[80&g_Z^-Fb5f6YW(,-aHS8@Tb3C^,3VHg,fLV_Y?\KIfRQ+\KODU\;O59I09R.
c#QBeR57+N_,:\#T4FXMN@>Zc@[2G+O.#V&0F43CQI;F0;RB/X6QJWbI>,?Y:2N,
<MD7<JNWVb&FJI1#=5^=.FaL/^OO+NOXgFG[-PeUP&9_G),3f+agO>f4dc<;ed\=
aT)H1cSeNgI)L)_a.(KDV[\)<@BYIG8L.+E0\<9J733F,7;cL&9T/8W?KGg9e#6J
>-5PgV6NC3,J)?@&Q7T:dK@0EH(?OE7X:J1]&Rfe/\GA,0IWB:ST-X+68,_/].Y8
e?=(Jd;@?(\cMa,+JeD\E17dMTOYR.@N@T3fgH,GbRbGAa5eVeA>DRF^].8WZ@Z1
^>M3-;O6LTD1>3#E)UP<)Kg54afBeaQ_)0P4cG0Fa6_&Eccf7YD<OP&=edSFWCa0
MG[=2:0FG:KZIgeJ1J;GLDA:TKP5)4_;e:eDV\4(EQAXVV_=CB[&]#(e#42KC04-
/BFAB,C#L9_[b]a9\;N@J^,E12]a=SNDEXYC823<&/IW[UUYYO56<2Q&&)XfHIdT
Q[FfPBcN^O-O.Oab1gBTZ-CT@R2HK[H\3Hc;Z)FO=,>J0JeL]=K.W)N<NTZ0(86)
K7^=4S8DU@&+CU?7L9-1F+:;(Q75^NgWK<#@ZBDa<1eKG^6C0,N+2V<C^[[EWRb,
O,J:@9X:K6SK,.4aLTH>IKMN1G(>@R6da&QM=HP;:<6GQPYB.4b:TVQB^f?R4:O+
==HAA1-:/S]UfP=0UARdaSacGS=J&F7dYJ,5>X>Me)aad98.\_BJ>[XNR947E>3g
0AESZ:&1=1L9TMYdK#f=Ab#IGA#XB0fNaZC>XX\Db2,.\a=<:IN&b8L3aWL,L>8\
6#^8[F3J7-:>:P##5fbQ7UU&4^82dGUQ471N#O8+8G\WOL6?A@\QfTD,5T,cQ3/.
&Ya7N&).>L[Za?R(g^;GFf1<02&g1XFWIDfAg9]]cf;e?Y?V(/?NA^-gV9fC6O2d
1H=/AYZ.MR<NM.SgV.dEf_;YbbVGJWWUIO5g01;B<\f96WASJ]56&\V/g9R=&6Z2
9DV5YPYOL[DgdIVHeLeZISMGYbbd@5gd]/FB<g+Bd(ZJ2Pcd^(6L3F/RfcQUHa/c
S28H#&N;[>[_KLO3<cBSQL?JKG8gYSOFLIA]aHUbdCM,a(B:NcGB;ZGd.cJ&H^N<
YP35DSBOTU0PAFQ59(7CH-QIS1LN6\M0V:U;D^ScG:N+7Vc.<fW3)K&T5Q@US]8X
.T(-KQNNf>gf-&BG?&PCc\;@FT+2O<A=>a5:2=1DdVO8F8BFH@A#+4JdH\\->R0+
^c16L0S)<S(;XaK:_B1D?/AT6:F8->Q&_;:(_e9-+VZA:+?b:K5\ZM#d3a8J#LL^
4cg8=<?;1Bd#D;6&Z&)1X,9UE]5/=6;(U)9+.(?>=aWB.)1:AX<R0M#+69fG@1X\
]8&MA2bK<cd;S,c1e4c<c^Hcb.:S^IMD<d?UD4bc(+>dR,JNS)D^+O8gQZ^>62<C
Z#6KVJ1Cc@^c_K7TgNUC/[f:CWKSe>[E53+f_L[=fA].=egS;0IA0_MBNd1F/&SN
Y5V6.+(3d>&f9LH)b9-:DPBEI-cIJ#\Kf[BF4#GMG&TR_/^gCF79QJ[dY-6-_-]B
\5D(gG@M?MaR&Pc5>Sd\JPQf;W1B>[L(LeDO0UC-c&>e[c1V6<.A?M>YHR[KSG>(
R^K:/<a.]51fAUD[TY+:A8LEB&.]F[XAYaW=6C4/XKfI<A>.:>U(:c^;MKB-AALW
g7KbF@)D#cOSf-Nc,J+4O=8EBDc8?J]N>NAM-9R/TQ077L6dY0K13]Ag^c3217.8
CT_.#@^4L<67R]C=HT935N5WVfOKb:cU_R^VAg/K<F;Kb);D1bB(2ZS\R(5U,;WW
GPdM@:EFYAZAV0;fJ]ZYK>7):.((^.R;L/N2LYYd=EOZI(d+&FH&=O[]+C/K<DBQ
ddR[?bTE1EX[61Y8920=/P7AY1RA0A7]E16?&:<_D;M@E^=b[ER8TfaP\QG5V7bI
5)CX=ccTPIWa]GA5gKN]a:CdBZDda=<WNHP1+WM4B;d:9^H5QVW-/[8JC-<[H<>_
)/3?cK>\S:]JdB3eOLd?]T<^_F:6BR&_7EMf93?4IG/MfJ7F)eN@e&RWI3,\X8eI
03&:Pf=d30^;]MW.cA[LB^:JdCfE4>QE3#55X<YJcfJ\PHJ#I/(Y8@[)(?c_1:?=
H6e.M)\72\7J?6_dXfWfdJfWIM77+X<>M&13W7>?V+[91RG6-Q[\(>:=^&N:N5I@
VcUCP8]:0SC0N:Rd2F=gTO8c<I6-N<N+ea0UD<5&0C#\D-6NL<7^bYF4&Z(^8Z)6
B+TLL@BBP##X]RQ<9&>R.5e+GcG]:082<>&bY6<+/I2SVP4Ea#[O+Y=TZ.XK;G6G
a,MGUYX<30]MAbRZVNJfBa+2-7+>=dTO+190WVMJQd(fP5S[F:T^IPW(JDXD8VNF
Zf0U8H6,86SW@ffIA,H7a8+#H86@N4+L#X8:3RDCg83\bN@IPL)>XL-BUN)Ad^KZ
,R]&Yb^P?XR1SSC\:CHODaPAPCFCIgCNT#=J1f#6QG#GHW#6V.3TJKd6)N.4SW]@
1S<)-eP]J4J-=J#SA,c=Z>6P0MO\7+U^S0J^334b.bd]&)TAF_(V^)<EW5>3=I35
B\eD>Z>TcIXB/FP8a0c@\A]Q\C00[81_0QSOfYd,HefI28<Y7Pd;)a-gFPd.gZA]
9NXV45J28GU9K>@OE@B#6f39DTRQ6eL#TdI]NTXGT5PV&dbGX#-Y9L;_=@&B.-_A
OIZbAL2V^>F,0JIUC9_HX3U6Q1bDV0>HZLS#5e(@AYEH5NWdQOb/SAQ5?N.,B@B;
-05B(O^-aCBaXcV_G<A4_:;cM)X@b=[0TO\-)fE.N,/X=-d@6Z4H&LKe07J9).&.
bQR9;/J3XH.?E4b]N.JdX_:@Oc\J,L92/44e1@RI+CIU5:e-g@F,[NdD/g)(->#g
M[g]61003RaH&UGG38Xd7QR1SeB5ZO8-WSLK/D[X[eULY]K<G+@9JM:@d)A@fAY_
FO;(4,+2[PMc)fX?9T5MEH=-8b;8_K3eJT3Td9HdB-,196YHE#C)Af9&?7Xe_5F6
#M9a6PScOcUCZe>ZeWZ_SP0EJE(RS]?7JUa=\56OZOH?V.b?:--YS>a9[AC-fCaF
0_QG4\b&Y&\T<L#cD1]/5UK5aPIfQ;U7R;:M[>0&O0cHf@G?>9>P+F#IV5H@)?AH
[?W+]S],a<Cc0YdTCI0<K<:X#N&^#P\2V=]GGYW4&54:Sa5/CA+d:K7BCNa0IC0A
@XJ--G9#F\9@,Y=]U_b\cG#:D?<:PK>S(OMd?bIcHUIPde_8\&e82E=(Z?V?SF2/
+^F4\DLNKeFYg3;/:,B?Lb=dUCI^<ZK@ES0IgaJBJ-HGcF_04-Af@eK0cf2+D=R;
P,M[Z(<a6]F?M7X9).C-3ND,9O5PfJ#MDU>J_^Pc/Qe[0eOBCO-==0=Na&3^6K8L
ZG9RF?S/A(@4a>>AY^.7ZL5YUe8A6]IRBcBCAC.4)SYHebAZ@6TE=c_AMWU_<@Z?
/[=0fBAY&I86P75MALfX72Z9G:>T_Dcd2-757LD&@Z-TaBFF/_,fE#>D;;4^S@MB
ZBd=fFUBYeW;L.G9A]7-3U:A0>fK5T=P[]_;)A8cV.SY=WZY_E\+@\75WC>;WSI8
Pf-;TMB4,\<IE^FeZ-+@K(/Sa?8D505C/L+K#BdeLFU(aHa;^dXAfHI>0a&D9\?+
FcDTN26gJ6dA89,Bg;NL=8&@gcJ/XC0WI##MLKb8-?=(>#A,K[Z?(a>:Q<037WYF
WGJMZ42/RTDObSae=BJab#DW6?4JNTeb^<@^1LIB4[3KH0BMQG/I-LGJ)GAKW0]_
a1;&J_16HP<fTF43dY?S6I0KNW(L<GH24VL_8eT\8_62g>#48+_8S(1>GEUg@J;E
@XIW84IIW)HLHT&F/L<5/[DL5;6G0DR7,8DVb,_G02A>_A.M?M975=4982W],/H+
SdgCM(c??.-COPUfMa<\R)8cL,V<HM(;,(<X\36/7dMW][G6bgNA+.beWL&8)gb?
HWd?N_D0D?fZU9D[J/OK7+0+bN20]g<:41)/]AR&@C1+8_@HCDf/?dCSXZgBIOAe
?0A9LW8Ka9_@^(U/PO<0#3NKLCCL&cA1>.7T6JCS6#bB3a(,.ZCagMWN1&(bR;#V
H03/-a;1S.a)fNHe,I.ReU2JK/0XZB2I>TZ_-:R141;:U21YC)aP+LA))9]\<SU^
cAT[?MK@=BW;b;FN:b3dJ(G3PfBN03AX4&6ZZW4K?.gg.5AN=<f:=4A:\GX>\LU:
/(,:4+D_[8S;gM_0]9&#=&JS#Z_WC/ERE]072CGAgbKa6=E4F,TUAA7N]^bNEFQJ
3K6B@/cb([^aD]9>5Q38ZBd5HbW1707SIOK)UR?UXM:&VAX87SZH15ZF_cPc9@4K
7:fK&N>d<3H8X(3Z_3:/IgI5YX<MGL=+/U:H+&5ZL,\c[?UT@BS8L#\WQS]I2+.\
&U?F(1O0XCUP\)E23C==W(H?GO3BD<PVb6W+P>(b33_I/YXP;YTEE/,ee=GW@K;a
^5/<,J5T..A][6+3C>TUHOQHbR6(ST=CHdGD\_Y[_?NE[e5BC5VM+;eY;=aNgIW^
UcC5SI32UHaP,=9-93>JP>#;-e@f^U\@?#2(JG[+T,Tb52A1fVaKa9DZ#=Y>9:_8
+GMTVe>TA]E/^W-]:\]e)RW]>U-ATY2;;b]NA.\FRQB=\N8B8.J_P<ZV7aZ5^Z7.
+<\D[-D-I).Sg][aO^dH^(9(gWdgS7CT#)H/GH&L^BfT=VN[KXCWTQD+ZDE;5&c:
?19dS/K0[I2^)Qg3)gH?7-\\MQD4Q>B^fP&4C=#=IST(V:c=B_7<&\f1[JI(E:12
gGIK\Z^=)&b)RI@c&?AC[9X.P]>Uc+H=&B+U74U;CA-FIN\EV&b;a?39WE0S-eHa
C7#;T&U(GVW:C_Ed_dF;6=XIE/\0RLg<K,3SE+Ma.^ePE@?b4a9148RL?#cec=VW
YV1Td#aC2FV^dW;g\?9IEd:.g8;#Rf;3=K[/X;]269QF/AW96>\6/2O^eg;(b#/A
5)7OSJRb)+B^^<2[^-W1Wd;9d,+0.fH,>5^GZ40O7E_cbG>2(=XYVW@65a#fDGfA
2fF99Z_>.J<+gB544.-eAdJgX\8-\\P]W86\]c/(H5<3GYU7Ma5TJ6NVII<gDQ2a
5KC0Od9g6NAc+-(2cSSDIYC/a)3<8ea9]\GJ#O2<PTZ;3VcEcf=e>,@Q70g&N#W1
229D<.&W6=QCI8,8c;=/6@Xg+SW[d?SQH4(;N<>3GPLN0gQ#eC5VWL2>FFLE[F]M
M@Kfc84G+)Q601OOa[9E&G&e.]O?,57[):^KKAE@W[[PNMaW_)MNRMJ8QVc+MBW]
?YGHNMRdQJOQ3C]fF@e1C&]RIda5LbI<f6<9afOQbe:=aacW@OV\?7+BF([<Ub.O
HF]?YYbcNeW^/)9\VJ=7eAZ_#MY,a<OQ)<FM9)\?=R)-e/fcC.T\CV8bA-(#/RLX
bJU5),J,JK22GTQ-CW2g+-4;Be[4M5C4G/T?):ZNOYBOU=45VS&9#dFfO6B[8KNJ
24:Jgc^NL^[FP[KWgg#647,c=J3AWGONUL7?&GQK+GPJ/<W+]4Bd;;VcTHS8,)>U
d^eA_,b&7OBWSHN#6Y7XYa+\N,bI/=0R8cPR/:<EWW<>T:A?D^XTb<BbMWHga0@E
LNG:-A86F)VC74bR.R7KP^:e&7[,#GX[T4S#?M_bZ@RP4L&)c6@Y,CQgYICgM#c4
C:<Y\1-781aJJL/,_cV0/4T6OL;)aZ29R=7B,]LSWNL(OC?U-(1#7@IgQ0@Xg7d#
d;&Z3Y:DeHFUX6L^HbA#g9IfWdX-cdIV.d4DH@<N_G#1+(EfE,8[IDeDH7-&-;_9
gJDf:_?^M(B_GcFdPV#A)FL;gaK5E7B3VDbKYeFQ.4ce^(ZPY15FSH\M.C)XYY[D
(C:.b=C.@^MVbCe4,>R+]U)2dN\E]O=E>PbYg\4<dcT4T1]CKd34CF\MN$
`endprotected

`endif
`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV

