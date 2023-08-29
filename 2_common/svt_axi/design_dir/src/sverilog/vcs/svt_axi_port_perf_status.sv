
`ifndef GUARD_SVT_AXI_PORT_PERF_STATUS_SV
`define GUARD_SVT_AXI_PORT_PERF_STATUS_SV 

  
// =============================================================================
/**
 *  This is the AXI VIP performance status class used by master, slave(UVM)/groups(VMM).
 *  This provides APIs to query the performance metrics from testbench. 
 */
class svt_axi_port_perf_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  /**
  * Enumerated typed for the the performance metric
  */
  typedef enum {
    AVG_READ_LATENCY = 0, /**<: average latency of the read type transactions */
    MIN_READ_LATENCY  = 1, /**<: minimum latency of the read type transactions */
    MAX_READ_LATENCY = 2, /**<: maximum latency of the read type transactions */
    READ_THROUGHPUT = 3, /**<: throughput of the read data bus */
    AVG_WRITE_LATENCY = 4, /**<: average latency of the write type transactions */
    MIN_WRITE_LATENCY  = 5, /**<: minimum latency of the write type transactions */
    MAX_WRITE_LATENCY = 6, /**<: maximum latency of the write type transactions */
    WRITE_THROUGHPUT = 7 /**<: throughput of the write data bus */ 
  } axi_port_perf_metric_enum;
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  /** Report/log object */
`ifdef SVT_UVM_TECHNOLOGY
  protected uvm_report_object reporter; 
`elsif SVT_OVM_TECHNOLOGY
  protected ovm_report_object reporter; 
`else
  protected vmm_log log;
`endif

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  local svt_axi_common common; 
  /** @cond PRIVATE */
 /** VMM Notify Object passed from the agent */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_axi_port_perf_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_axi_port_perf_status");
`endif
  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_axi_port_perf_status)
  `svt_data_member_end(svt_axi_port_perf_status)


  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  /**
   * Sets the handle to common used by the agent. This needs to be called by the master/slave agent
   */
  extern function void set_common(svt_axi_common common, `SVT_XVM(report_object) reporter); 
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_port_perf_status.
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
  extern virtual function svt_pattern allocate_pattern();

 // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_port_perf_status)
  `vmm_class_factory(svt_axi_port_perf_status)
`endif

  /** @endcond */

  //---------------------------------------------------------------------------
  /**
   * Computes and returns the performance metric value. The metric is computed 
   * from the beginning of performance recording interval to the time at which this method is called. 
   * Following are the prerequisites to invoke this method:
   * - svt_axi_port_configuration::perf_recording_interval must be set to 0 or -1. 
   * - svt_axi_port_configuration::perf_exclude_inactive_periods_for_throughput must be set to 1.
   * - svt_axi_port_configuration::perf_inactivity_algorithm_type must be set to svt_axi_port_configuration::EXCLUDE_BEGIN_END. 
   * . 
   * @param axi_port_perf_metric The name of the performance metric to be computed
   * @param xacts[$] queue of transactions related to a metric. Supported when axi_port_perf_metric is passed as one of the 
   * following:
   * - MAX_READ_LATENCY 
   * - MIN_READ_LATENCY 
   * - MAX_WRITE_LATENCY 
   * - MIN_WRITE_LATENCY 
   * .
   * The number of elements returned in the queue depends on the input argument num_xacts_to_be_matched. 
   * @param num_xacts_to_be_matched number of elements to be returned in the output queue xacts. 
   * -  0 : empty xacts 
   * -  1 : returns the transaction object that corresponds to: 
   *  - min read latency observed, when axi_port_perf_metric is MIN_READ_LATENCY 
   *  - min write latency observed, when axi_port_perf_metric is MIN_WRITE_LATENCY 
   *  - max read latency observed, when axi_port_perf_metric is MAX_READ_LATENCY 
   *  - max write latency observed, when axi_port_perf_metric is MAX_WRITE_LATENCY 
   *  . 
   * - -1 : xacts will contain all the transaction objects that violated the constraints
   * @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   * - Value passed to this parameter must be in the range [0:(svt_axi_port_perf_status::get_num_performance_monitoring_intervals())-1] <br>
   *   If there is no interval corresponding to the value passed to this argument, an error will be issued.
   * - The default value is 0, corresponding to the first performance recording interval
   * .
   */
  extern function real get_perf_metric(axi_port_perf_metric_enum axi_port_perf_metric, output svt_axi_transaction xacts[$], input int num_xacts_to_be_matched=0, input int perf_rec_interval = 0);

  /**
   * Returns the time unit for latency metrics 
   */
  extern function string get_unit_for_latency_metrics();

  /**
   * Returns the time unit for throughput metrics 
   */
  extern function string get_unit_for_throughput_metrics();

  /**
   * When invoked, performance monitoring will be started if already the monitoring is not in progress.
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is started as a result of this method invocation
   * - Returns 0 if performance monitoring is not started as a result of this method invocation
   * .
   */
  extern function bit start_performance_monitoring();

  /**
   * When invoked, performance monitoring will be stopped if already the monitoring is in progress.
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is stopped as a result of this method invocation
   * - Returns 0 if performance monitoring is not stopped as a result of this method invocation
   * - If the performance monitoring is in progress, that is the start_performance_monitoring() is invoked,
   *   but the stop_performance_monitoring() is not invoked, the port monitor invokes this method
   *   during extract phase.
   * .
   */
  extern function bit stop_performance_monitoring();

  /**
   * When invoked, indicates if the performance monitoring is in progress or not.
   * - This is applicable only when the svt_axi_port_configuration::perf_recording_interval is set to -1.
   * - Returns 1 if performance monitoring is in progress when this method is invoked
   * - Returns 0 if performance monitoring is not in progress when this method is invoked
   * .
   */
  extern function bit is_performance_monitoring_in_progress();

  /** Returns the number of performance monitoring intervals, including any in progress monitoring interval */
  extern function int get_num_performance_monitoring_intervals();

  /** Indicates number of completed performance monitoring intervals */
  extern function int get_num_completed_performance_monitoring_intervals();

  /** Indicates if a given performance recording interval is complete or not 
   *  @param perf_rec_interval Index of performance recording interval for which the metric value needs to be retrieved. 
   */
  extern function bit is_performance_monitoring_interval_complete(int unsigned perf_rec_interval);
  

 // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
D-5\8;0(/I^N=(^#,M89WC[Ba&08ebT#;O[OB?f_GXE:U<LV<H]\7)W?Bg<O&8WB
fX3B/Z_9JSe;A#T^^)-AQe_.H_)IMHXX9.ZH(LAaH@6/:8FZbVVd@N\fGQ;CRYVc
g<CIYa)ML5b8d=TS/F]_]Bc6eCG_F)0/BZ@UHWL:161MTCVdXXWK<6R1W-#L?:F@
B+V//9T@I-e]&2C^50\=Cc]3<E:&)(JVdEg[H72SZgc6GNT]f/\V/<E+I?,_?7OL
ZUf#4ZU]5L\:@d.a&;-U0J7Z<c5+,.:TI4@e/IOc51FK;V9;fHM+[36HQ=K:I/_K
PP7Pa#-5#V_c970b3D17a<86fPFSaY:NYZTVJ>(3@VJV&LB9e?fK/A1(;dM21eF_
44eg\6+O\Rd,&5#YI)Q82A@0DRLI&RIY=L.Ha.:]355,-\Y[f9TE+BLOVCW#/@4&
@-WACY4W5L4=>&4@G\I\7G&\c.P6]0IVa(?4f_(]_g>-cG<BFW39_EeA2)FPb6=_
CN(?FSBR]^U=/$
`endprotected


//vcs_vip_protect
`protected
WAIT3X&HEI\)S@Pf;8@C?7C9Vdd)3F,W#]++PE:ZV_NEeAC4D8F50((,VN7C3)F^
/>MK=GHS^:O(HE<&,&Tb4L0UN0AU0<</=&cG9=JQN+5(40]d1@.V)TY<-V<K3+IN
A3d.<dC8F0fTP36egXX2(8>GUgY^M6,9QOcV(ED\_(NYZ@DY-b\a;\:UPH;1M=GX
F-80NgOMMF?13X_&)fdEgDKB-;W=HJ2M#0=HZLB\^+4F]0ET/;e=\-BV@.B[4OUN
X@6Lag8GA^-f6&<&f.C0cB&()IIY:<bOCPN]7->]N+QA588/fe-gZA6]^?P][9[#
)P?3Q#);4Y?+#LHTATcOXB;PC61RN2X8GcE>:6OF/e0>+bc5bAf].;C2S:BT#<L:
IU#36dVOJa1>6cMIb1^/WgGL&M4a2&&[2D.dfb\<KNQ3T&N@X-=:&&)29DL9AC8@
2a-9?0+Q--GWa4M5AA<@J?4MCW9#ANL/2(7NGFWI[ECgR1JGJBI;MB1OS:;-e:g3
3IV1SJ\(A3@7CJR8)#9A>cd)F0C,O16gJ8g#3]bbJJB8S.ePDcQcF514feAP<@34
-GEIP6&.>G88edG=/J72fAUW4@B,O\R03^2B,76GCA#Q-TYKc>/D>M>J=\3DGT60
T=bB2DGYbc/VMaQAHT+OgVVJ[6]2+fYc]70>J8KJD^SUSb@FGC?0>L,fV?N8R&T=
=9;?f.7;AZDA4.>YQS(O^\AQUOH8QM#^L_C,f#YT1?ER[YDRgJTDcdQCUc@>?NG1
+11@N1,4aSRH>=U#>ec2G]@XDF)_W.LI#gI\a,WNc_AO\MCAg1[7bKReEJHWH45g
F;CSbHc1VM,.3K_&(UYHP&@08Y2C-L[;&HQ3PRNHOd#45[+V:T1N1XW^Z4DQ/E/U
9_DK<)R__LV@;PQD/b_5GPJW7Xa?b6_9#(BPf\K_XIH1MbX9D7e54<V]JT[S=)97
<^L<d?3H^NE/XHCc8;#eK(-.<TPSbHP8J5SRU--2C/[>LNFL8g6#6_;YaD^ee^9H
+eJ:E@Q/YAYJ3)c.I4[,-9C^Q[<[\LSW>8<_B9:\M7G=BUZLXL,.C;OH[27\b5AO
bOJfMOT(BCQ-VO/^?Z/F4WBP[IGcCZ2Za[RJ?90#N.#1B:(Cg]ZAUD&gC7;c2ZDR
ZgFX#_0>.6G8SWDfF;KD_OFd1WJO1L1cK/S@(-e6S/9;A.^[B>fbM+OfY<TO=5;:
?VE]EA5IIBK:2Z#WV6672VcLB3[+-_9(#GL&5I&10#O[Z/VCF86TI/:.3J^9S52C
<7WfQI)C_N&<2K6XNLTS9WO/]2&YE72B2ZT3.Je8B1GSfZ;Sa=J1LJbL)XO8/<fW
GNNNI&&3M,6_;4KTQg?E)TdAGT,9gb4+9UAO/>7<-O55?=(80=fPC&-16K/FF,Ve
D3N1F(\L+UB3/Q[cKNT]J7AaXeQY[ZDRGEDf3(R_g#=A4cGKe81e]Nc\(XN:1cU[
H6LLL/G+)gH9X3;D6U,CA;B;;S5ZP=C,1SeL?<N.IS?QMeI\=T-aUR)IUGbI)N9(
#F(\=DeN/VXg/N&+]VgYAU1#;]D3D815)J.<AafdUYJHTGA5:OP(Y/(UDKeH81E^
U4FaOGG[6T_MRK29YEOOMQ1(7OcEFdce.N+f795fI.9]^).(/fS3#6D2W:gBY_R]
e=LI_,4W?XK9FF2-a4\4fOC4.FG1WL/43_.X^,5K_3UP..#gE_?LY@+WeU\FXTF?
cS^Hg540W?:aeC7VH8]VN(FMG_H1,Z8aZ;/KZSdK[U-QBZIc81E5_#<B<U4F^cW1
^ZHDb85B#)JFO8SR-6+7]=#>WKP35,@GcUQ>fSI&VB,UF(M<W7cKB9)BgFNIg\.W
.^S-C5?Yf21e]<403B4)X0&XU;0+_\4eJFYJL?^^7KW;aFOY^g(,C,V^HZ&EQG8R
_;Q9Y4_FcK_?gS<\b:acT8-A\ONUXH0H;^Z1EX#WCJ/V@A._TWAC;Ka=^RP3X-Pe
OCL?@;)S+&?BW#R9XX<X:,P8eSDXDFMV#</M?>b,8]^5Y@_MbD7d?(];GG;bXA1R
>PET5+KBDBJ)D:fcH4?(;SBJ..1:>/ZH<_V[dVZH]ROI^PRJFBRZSR0fO40K?_(e
3V,c0SDNCZbP,L:VRb]QJK^]/Q#GM7<>HT-IIaRE46@H&;eeS_5R7L+3;1\\SVBX
M&8GZCRLNIO<\N11VY8?IHKb=-3D3#A4KOSade.G2_f];MTY^HaCVH.,a?QGdHM-
aMP<UbRE,F?;ZCVRO&K9L#TV4]]3LP8D1J^OH<\FeEH,YVDE6N;W8f#T[\,FAC/K
5Ne&YE;E(90PIKgV_;7[fL@/>VWFM(SI3T+_5ZF0DYG?096463aQc+.d-Q-23DTA
][fN5F(ffU7eCQ:fPHC(98A9XWb+;6c\5=>,?(28FY.X2.DD-K2WDM71BP.0H/]g
LQ_@I8[ED>/)6#ZWKF/A@d>XWS+IA:L/Y[/HD:J;-R,-e]OPYGPV8Y9a.LC&Y-JA
Ub]5@,<&HN.b:D1BS9d&\Q]HGZ:B[S.(9)@LTX<0bf289.b^J]DAP-#:_@:(/eRC
OBe\+X.>@ZO:fI9UU?6@(?7V,3.&f@d0JGC,Z@#:8^7F<Zd/g7KD0J9V?B2A2(]/
J)cdK-L3E1,2D\DcNPJ1STeY#:CYC53;d_d5N_/6O+(0E@ZI(PFB>A_Zg=60_(<V
f4-VOY-g?MH,=gCOO:1DK#U7d^[UZGU-AbE/-)QdICd0J/d#/8G(&[EC.c5-VW6G
Icc&YdCR/9I<)#4g1YHKSV?aPO);?Laa@Q8-V+f;R3-)S4;V@U1<4]X0a6d-/Ka2
^gUGb>1XXZEBY^=VVHU^3b041/,_3F>6CCIV^Y9#FLZ(ENKRIQ?T/M7_6@1+6._J
OL996_EIBS;S.\ULQ[#\T\MU5[?b6d<HO?ZL.QG];46B?9/SbVW@b;1SOT<^1V4(
:gT=U#?DA:HK]2BZ89:?@/,U-;-Y\:CXY3GWUIgI1P].2LUaSD/=;R8+QX:JD?LM
#YI5ZPPfQ9;>YZ;><GMeH@,X@ggZMEg8Q^<cE:_>RTd?_#8JNIg7=/[6K)8G(?0=
fgK=WLGRZgcHJ9KBQa_-6ADgOUL-GBR[fVe+[&g8)9f.#MKQ4H[I9>U4dE?Xg\I+
]Mbc53^OJ]_]]H[TBW</_T1cE?8;&8a2?Y&b&FG8.MU)M#SIFb=cR/c?W.OD:IdV
&Y&OL#\,<QfE,?b>W_H7ZF4T5c;7(d^E#A&f4e6cT2704/9Cdb7^SHK+5?V5bM[,
+_VV3]CL#9(75;/:fe26WX7dd4_FeA6,d9C8DE.b=;,c#@]W?_#Q4Be82S<UD25V
b@^gQFS+]27M)A\\U<DA6:f5I9Q71LINe0IW^RDeR9CLJEFK+G\JAS&K]g#40KU2
c@(4f--bMM,Z6Te96\[aLV(;ZFVZQ#>e\&Fg[f]17.(WYg9P>N9f^:0KPBBC<;P_
3g0g&WWC0B)+NQ5XWY2Y:XBWD84BR:[^IfM<0VOW29Z.DEVXZJ-Y[6SJ+[.PI1TY
A+H^QB45:SOEK,J-OR&D;^(J._W,W(ZbTWU=Va1HS6S+=HSKg]&,H@Kc(ZR]R:..
><#K.G6X)5RXHG8UAeGg]^]O5&X,#3_J/&55PWPY[Y);9\a@QW1/<5feY=,?_8a^
=3]BOP\4_-+9Wc>E&DRIb9aNXT])C#PeOO;UPM@FH,(J@c1E+9d_<]>5;:3[36;[
5\bXCMNJ]GZM+8L92C6\SF1\\\CZT,QV.Gg<^H(Y5VcT^N<3Gd10?E(d@OA=?PK4
;6C,/5FP]S01_.2&<^bTT)@B[^.SYOWVPMIP0C6OEN&MOEfVQf7HMcU:F;D;?1Dg
R.OZde=g3(BQ&RYT1]LD#B;B+>e/[[:Q]1,\&+Ga.[Ncc?NQZNPe\BH]<SKG929Z
deJXFGe4d)dbVb@HOTRNfY/#7f@6;<Z.1DWRJd=7]0gLM+_)QTF34O4CC9#(09J>
+>-;c8<<a3#DbXX(I8YRN+/(dMPDA_-OC<V)BS4YD,/#BcUK,C,>c\04Rb+,:N5O
1.a/HPP:\8WcVPbbc6XT)^)ZfDS62/CLaT./bNG=bfbW+3+8Z@:B\DY#,\+ZZC6(
4WNf^(TIdDW>Ub/SN9H^GEPZf2X7QPZZSd3agZEeQAf3UJZ>##HcUcBW(/0WG2B^
C2N[IRQ73e];D757-G0J#gF0.(H32\3/FN<G/>4K_4>dF<]9E28(1;2+W(&,WX@I
G7)CQbDgXE3&U9IZbKXF=afG^7bD.GP:bP;ERMIPHGF7Gf.6#._)gM50Adg/bTcM
TQU^:g=U/_X[)U#MOQ=aXW(XU[-P.:,9R7UN4HW4cS:]e/8#SfJ9?35dVdfN.K_e
/7d-)03Va#Sc0BGOH3NeF>DZ=M65OM9]TLL\<[c/B0+LI;.FJ1XaMUQ1H2>AWSN(
#WbXPZ5aO#bf)1TL1MF_a)D?Bb&WS95)0J;YaeI]dP._-,FABYWIUQ7N4NU8/JUU
eadUe(cL397Ra_bSO_AGc>(Hf_R2P.[1BXJM5VfS-1fS9Y360G?e3R<2TZE>\N[O
>c.@9JC9DOG&OF/0-0Y14Y[(_PP<GGP+8T^e2P009_R1df]YMe-]?PcXW6A_b)T:
f6B.MJa<IBF-Q1O7]S.H+>IC@YF2<-c:VDf&)edPZNbH[WP;J[]#K5)&7AWA[54P
LL+IW418f8#/W.5I.+;],;KaJ[daX>L)+OF@5O@I@Y,@@Z;eI_C8IgfR>EM@g+DU
d\/JfI08<+B_.?<OdcWX^-TT\eAE#A\P>F_1IEX.]9AV2;6U_eM+G,Hg=628-V6H
1U(Aag(&_OK&<0\RNY-+DJd3&-R^d8[&[Z[)HDS^208-L?bCZA>@bB64UJ13BV\b
YQ+I@5e&WAgV,9-]H43BgAC2PPJd<YMKF7c^X2X[VfJ]WNcZ2#I_Z_1H;dd-:2#5
SOIV;-B(\V6+A^V?L-Ma[+KA.;e#OEKMVP4/dbU\=0??#=,H)^II5I1J.e/>H(gB
bS>A&#&8ceHN93d6@YObIJW\5dYMRB_1O>\&>>B=+(]C]DF?:J)(4VB]<],Ta,]J
=M-L]NF^L95B^<RASIM03FP3IR=CdB-0)a)HF7NJ+-PgZ7e6/3:3?O+GR+)A6PC6
9Og#43Y-+CP4C-]2gA+BH.=aHAW[c.&N.(0/5.QUD8dcK\YPB)4ZH[W2?Z)2Sb+)
<c&]VK-(XXaP.GP+-YWJN(L6WK,Ne59S4B<MYfMEJEIK(KHHN<3fB_R2A^1-7=(3
gT),A5aAB85,Y]0TXXOc-NS,4,Lc__d..Bf-Q/>f5ZQcK-GFF>Q4S>NSFZL.P2BL
LA8U=O^1IJbU;AW.S;Z,0-\gCZ.9Eg\^&eA7G2c.=CV3&.6Z?BP[:\YJcge,9:C6
_:(U4;,LV^5^0=^\(^9&:=_#3JY33@Z3T3\c=2)>ES9MU3KB^#93aEJ_YIVacI7O
)OVOVSd\TEYS(0Df1)E)dD(c,,_Wb/6CA>SA=Fff7L]dU=_7-X,;.gV?1_FU:bOK
:@V?,c)F.f7[&T(WE7I@(dK].Kb5fXDUMSa)7H&N^-HWN\&9TQ@<NH906^B8ZZ4N
_a;KBOP);#:5aeE>(H_7C-U,fA>G)]HPO6G>gSgT_O5D[G\3@/GFL\.#]^JRgGQD
&3SVQO/0Z_7ZXS&^5d]TS^9a7AT?T0HBW&;g5ALdLV^?MaI)@(<4=gG,.YPWW&Dc
3:7YPW)cN&QO:gSIV+L=3@N0I)M#(.B+_[F)7)DB=97O>F=HQF9bHNOE1Dc582<(
1Y[a?JUHE8P=.<f>5).GS>Y&gVc59G9VH66ZA.R=):ga2=ICX#f=#[L]#&EBLa#;
eQ58@)Fc:78e^1DbOG8U.[3(DV+TT/F,e)Sbc8?b^YU@fFN\^?H47D<H-+]/6be3
IQSW+^9M<@G]&@F(R71(#C4WDS:<K)3WVa5MXVg,:JY9a__UJ0gL.]d/HA;-H-VD
MTW]G[4FHOLdAKPeMHH+OK_-/c)dT.^)F6dC4)+_c\[XdX00ed?dWFGZ90WN/Z<L
ZDNSJ2VaXPGIA@+K.8?\#M91E1e1QZ[gS&0B.M-7(V^FSSWD(fK;ENQSU)X88WDE
SdFd3)(a<K-&B.^WHaeBP7WME03+AeL[00WaR#6R(1gA-EV^X]f/5DEH_-TfdLUb
1(3#H7-2&ZeDIH88dT^PQ:_&b2H+RcBLF(W/M(cM[-&Q8@#aL.B2d+=g??GN__^U
/S?DXDTXaCPN70>\9)g]R/98SZ2=7429@HW(^N4,D+BX?XX:V#89^X+<JI&RUUO_
6.^2X1B<FP].bKDdXH)HU26E,9NBY:@b#Y^0GQBF\</7V.GfSZ[#JVa],U)(NJ.\
PJ3XZK/IH-.9Q]aYDS)SG]DXX]>FG0+LV:F+cH/V6Q&fe(,9M(Z1(a90c#^W.-6.
K\5M7e3N<D+)Mc[&O8Aa(6BA4eC_>E]LdH&[Rd>1[RD@UUCY_38@d@AV5XSI+g7E
a-,1L),Lb=SAR/+1]dK:.2C3-BUP]Q8+,<9.#330=#LDCbPc>5J=2YRPG77#6KOD
W3SO<38_V)WCaL3);(8c2F/V&;&/]X[)^D8Cf]c7/1,16fFPNKJgd03X7/OX[+B0
_R^U:FX8H2DCg5K/PCRRQc9[ZW>XY,)caF.#<3C4T#YS<=T:;.H]@XIC1T/0QB0g
X5VX(#&^?V//9G=Q)^6U^6TFceWDc-LM,2gLYZASH5FZf.K[V7I7/_M6E#Y&(VD,
/P8-d^L^.3Ze7;_:LBQ^eTMN3;+2RPVCM28G0H@^6/W=a<&>-;^bXe,>dVS1eeQK
Q=;WDdK:-B=J:7QFBb.Z.1aF_+?@[)3X,4N[DSW>feE@7Yg3WKC)0G>G@dOJ:I0,
]:fK.>;UN5a,b4aCBEBCKYbeWA/S.a#OX:@@d4P@W0&QFaFGdK9d[CN8]Beg@_0]
;fI=4g@b,1[CF6<_EY.^BZ(6#OTD7cbF:\P9e:P7;\]L>1Ca(ZHC[\7.J5V>Y3+3
>,)EOA]5<COfTC1a<TPUa\)d)B\&63\dN#f^1,L:,J+Ye<3WJ0;SLSWH^.WFQU90
1=MM^B0[:QG(G[CMV^-D>]3N&SG?[+YLe&9AA+Zd?PKT[MMD3])aYeQ;?1;Z9QVN
R=MMAB0K>2fZ<g.XZ034.Q98gP3f8>L@MQ3XG4:6<&6c0e_K)68O6Q=PGNPb>?U;
WZXR;e5gTP:-P4acX?fKBSH:g1)(;e#Z+V,(Ia2fXeM&QR7cEGI<\J9W>Q)7ZU=-
ULBeMW9(5D@Ve/VT(QEB42O^geR3ZZ^8&B>1[[RT\Q\+7bT#VZ#0SYeN_^9KT2--
e8+DK>KHIe0ZBJHMZJ6P@<KL_B<&Zab()\Y;#1OA-XU#=@#<^JeM>:WaGdN(R6-M
de=Ug,^b>HUK^FKB&_.:719^E3PHFKFCJ\2\SO3d?>I/R8a:AS7LZ+P#8H,#b_@N
;?OP=;R-6#W#NT+Q/(W(Gc/eYcI,-cbTLM_T^R?KNe:UZF52#A&\7O5V#G#^HdY_
00QWL@bUOD2H+<3)aV2MQ14SBPQ(T[df(>O91@@(ZEXNP\03;51YMQQU\6),+gV,
BE&)DNc.CER3^3B_@Z8MOMf_Lg5P)\,OQ?,1H+EcA?WX,;JYb-T]2)9SXL2P#<-H
Bge_=CSaJQSeC?[(0<BVDBNAP;,UL]>Qe(KO2.a-<:++F6fa3A1?^3?+XY>D)<GC
75,5/e/5P?[7)UJXW][^SMD(.Y)Y#(cB0W7,MLGY.8605.HD/R[D^HWIg,Q_6TK=
JDP8^\Pf\6KB9G47<W?<;QKVHODVYFK8?V8NV(RfWW&&:ORNEdK,V]TZIL+fG1,+
02(;JORIZ-@F9X17Mb=8?[cXTIBc=gfQ4975\PNE6We[YY<5D0GN&b(]_OfKDcX^
Jc08PDMDF=&6)-4-UbR3Ob#faV5J-2A//X(1S[@4P-G>D3&=)\W0@37V]dFTJ]3&
#MRJXT@YY=We&4J[OEg=:1g+Q@].&LAFB8[>&C;M\EJXM?^^=2G&6:)YHP4])X#9
I2c\J-)3AJ^Y=,Q4,30]P]8MLFA[4YB]D?(3D8A#EZOI&GJe:>WJb]5g3Gc.;,>^
S[,DBO\b3@E47LB@+OM6c:PQ_@.acVA4gV7>)W<,,ID>?/bO?GM_NKdcDS&J\^;=
1ORPQ-U:c(9:J3WL#E.,c4HfO9V;+E996<@0a#\#WS#W/+Z4+XZb#?N]OYA>##8Q
S=a&#-TF-X(d4dL)4AJ\/I]a/(1R1dCed7GNd1EF6Q:[.eA&4ccWZ-6,eQJJR&dc
a2e>Sd,KA89.D4DTPVP&SK.?PZcFPA#8^7F.Yg:GR0/B3DHML.9I7\.\]WR,0WM)
ZC;=H.cXVAcdL54()e-,e.OLI/1CG[F7O8fJ?Lb2Q,,?+Q[/)gda8^&7aZ;G@I+f
QO,.M0RQ,Q?e/^37^:?:;ge5G&@JcY^Wc<d24:gXe3N/g8Q8CYY#J744#<MCDF_R
B)e(?@DT=[:b+K<3@f-d1DX>#H9)f7JE0JHF5M,7\#I6+g;/#=:?d:ORGb_D&aYV
_\@G&1^3L(3MQLB=NU1WUBM\:f59RZ\.X#S.I#c]U3C;,?PE.<22M1GG@-:U@\Cc
H2[96;1Z8?gdEWS-/:HALQMB@EeXXYcO_4(HV[?<5?F_3XVRGXPc5_C(WZSLO^XI
>d-N]BA2I4Z(LEeT\J-<Pe,JcP?dbZ,3bc3B@C+^[759?SX5cR](M88BaGRR:8gF
#6=9D#0aVQ@6YfJ;0HWHV_7B[(.fYc:a>W.6g]_d]7P5/d/)]^K6WeB>03eB9C.2
S:Y7NK\<\B<.0?b)TPJPYO_1O,c\-&90I0-T#R5LVI_Y@2&MaBM1V@Q)fc/W1g3M
GWcS2XF^8BP3.-6/Yc@-QM3aC,PM)b7O:a[-08F;e4TLbGGX_\Od1B9>eANU.X#G
P51(cg)L)?TY6?32gOS@BOFgKU1WB)ENWOX@=[L/I2VZD/V5f/W5K2N@<Ia,B/)A
^7KOKfP1<dYI,WKB8E<L2;IQ@NgbY_@,3D;O87d+B@?:g]g9^Y#YK+B=DHT)I&AS
eZ-^TdK(,6Z^P=_-e6_MMVACSSL#A:2R>WDL8Sb#W\A&IF>-g(-[QK3W82Z<;K<F
3<KM9XUN_Q\[)K8g:Ef[C56b,f]OAG>.?-M)D&^?G.U?CfHCKG7-];62^)cbbDBE
Q;Wf_23/\8H-,7@BCKKd(0D?1_IFE5L8TGYJ;O-]?5=_bZKEBX>V4R[GR#)6Q,cB
4f5N,#)^AE4<G=F;TeWGfa9RR0C&f7.D]aK2@SecM.],<.V=c+(Rb<c(b4+bCc8V
60Z;7=7M42)c)Y[>,O:a4DYHc8RT3\.]4VCTaG/BSXN9GQKNZWH7FYFdST:E>_gX
X67d8^g7RL,>B84HUa4UTEC)>WRdNBC8UQT?PR6]G09F(28T?D#UcHZ6LAKSUfZ-
_K6A=O_4,]O)If(M16g3)_VS/UK+=5,b(XK]IE>S&H&KJW]]eGHYFLQK:bL.c3##
A0.&R4LZOAN(/IN&EM/K(T\?Xbbb\93]@-N.Q](GW5YRMN7G31L4>Fa\E37&WfFC
8bJ6JEKL[&^^>[+\\<R^E9:bXE(G;C(7(GYH-;Q]?f(84+-9C,7Z8P8,eFBXd]77
Q#F+:_?^(g7cA_VNbfG3=6^=]ZZ+GFZAeQ0c,7?Ob.QE3/Y;L7,./\g4H9G_aCYG
XHD:O+&2WATQOZed&CV3K5^,Q)&M12C33<HN<;WB:Ie<A-P4P0a3e+.;6B3U_cTG
CL-8^5<Y89Z[Wg90b17Q0NBM+7FMd<gJVGPBCQ1Jc0.D[6,c=?f65B/eK2c:C/PA
V[SUbXEI#7+6P=>I/T0\,c^)-+SH>)c11/IKg@[\6;Gc/V2[RQ9:b\7aQ+e[b0]:
\X=cbKS>COVKC_#0I[EX47I2.[])+&_-0\9TOce,b#gH]UKTI-c_WS30<-/SME<=
FFYI(]A+<fLB,P;L_/^cEdV1P5?,f+0Ig#Lg2LE2USWQM7K5)?\b#=Z<-A0NC(@_
c7NK@+5EY/.QcLV>gN1MT<R;N])7)I0UYY1V2\Eg@J61cZg7TPJ>L?c5.4>I-dU+
c_X<+C#.O1CULF?J^c&?/@54[g(\<>b^1c(Q#Z6(P>1+#RJBX74HA?L8fCZCcY8T
;Z]<FM#4?-6Y).O?TY\[^/>&+0\[(I5GB@fK493JTF8J(Y\2--1_^H)?>2;Q=>C(
Wg_/GXT5W4cK(Y.&d1(P\RS,-+&KS4cOC+GZ]-Vb7,E6R;(Ld4Ydc,f[g5]gM60R
,Ue)CZF^BDR0S]&.<JPH,fHPAP4d2HY?1_5\aC52YTEWcHd7HgQPS=HV08K\-.Z8
G1F>Y3cNbN^#ND+LZPN:>>#-CgXOcd^?[(JFOg5BMQ92<OIWRYT/-K/(BJOebQHL
?]U9M#[d4ed)LaV^2(Y\cc1X+NJe@8[0KZ]D;SI^aG?SOT&d-8(5#d24HU+H(SN.
=7a:XgSVXT&>D^(=X0Z,>7[PGgf0-AF923FF6<Q.&,e2KaAecfc1,/X17IgID<eT
ObIR&]YJ]I2-0fTR->L4W18K?;Y5eSH19(E6D936P>c#=M8G8N/^dQD:,aFQ&L4<
97;[-1T_&F,C-eSSQ=G@16R^&_:Y@bPZ1NG2/R9WbO+6UJ_AL7C<3&SB\4[MKR=O
T-W,HK9L_Ca99;HS4XO\K)DfX>HSUPE6_]ffA(FHYIQ5.EQE9L)dW4:DFb[S&9QF
2#f-VRB(+<g<71LT0BBIZEA_+b)60/+[3U1+I.5,F2=XLK):6U,]>-5>FR9>3=fP
3FQ<1JDT^=3LF1BfZKI0S5))YggUeJR-3.:g+KZ8L/,:<1/6()Yb+@FLSNW\]cMK
&YY6R.=:P,73271=WK,P#4YIe^\>#1:F>3J4]):Q>K,HbE&+L[_3OX,?24M7e_(+
a1NB@5NJZ_UbY,#Q,Ke@\5B^T\gI(29-DdVg]+Bb:VUSVCbd,_I:ETA#\c::;=BG
:#IgS?G/P9B(&Z?L:eN7.FTIf;VIIGB;QK.egY[,VEfI[@:RG4ZNg,-Y0;ZR_-:9
a0Cc36YEI:S)[,G([?2XOV5DJ[C9Q#\8AZ0b1,7e^(O&1.<B>c9U8TBHQT_>8Pe9
:a;2G]_SbMUCL<Hea>&81.F6A0)G>dgF<@E59JPb8\bEN\@JW:,)F9S2Sb+aB^HV
@PfYGbV#bX.XR1ZW]>_&:eGRP\^GXRAN3,D6_E3Q,>^:CF&CU575=DC3UCc9.,)g
C2a?UZLP67^8ZJB,UJF+^<N_AO,BZY^7SR2JB/M)<RB9A<3TLCR+bJ=@]=/)-PJ6
0U9WC-1@V-d>U(YM_Pf-GUgac9eFGWe0H_;F+8,4dGN&/O\D,),0(VCP0/+E=Egg
(\\/=E\(YWKQ+XIggP/0DD;I@c5CGJS,ELP2WB_ERb(I2J6f]IW7)RJ;;>cT=50O
PSEL9NS521#[QO_6SXS.Z>XBV49#cb>H2]M>WK9NIY\dNcE7W9K]fHY>2^[@Dc=T
HbUABVNU]>F@K+@Jf._aDL^J&,48LQd,RUC+A<6^IHT>#dbK,O]41ZWaNe2JV<?<
OY3N\TRVaEg2[NGAH0J1M?N]GRcRNIH.XU@4UCN&6df7a9M,UYGV-\IeBgS06\3C
eN1&@Q7d_ZGUMA+^YOIO1>=K(KRV5V9:0[LPQ@1UV/<IU?<V#J-Z==Y1^Ud]KBQX
f^Ig](cd/G?GM4VMP^2?-77CUA[fAWd7UQ1Bd33=<_[12=\:+H/_ga8-.5RC@bfR
=RE]/cfd/LA]&3-QZ7WRB.ZEL_8>WB0MPZc^aI=L4L0,PN8e)Y;Z8R(0B)[/B[HH
PS)JK?;F^M,e#Fb&;d\BY,cd51&@E#M7Y&CdU#-\2d;2?X@CCCTD+)MH0;=g/?KE
WYbL.MS=@[[T6VF7B\](GZ)?UB]O19e:?I)1]bN6HQcWM;N\86O(F7X7O,QcMXb9
?,MOVVWYH#>H@MS=RZ@gHTC)NTELaE&f>AK?Z5H>a.MPGP?H7e^-H^M&3BBaDJA]
)012Ea;U14?XH0GaL8=Qe->G/6^7]8H3G^#C0Kf)Ae7IM3^-SgY8BY7&938eH=WW
;(;E<_VGH=YNOUF1JPfNSbILg8c7K)QCY&8J8fV=76HNTb1cSG0R8dEBf;#]<=AP
\Ld8aO)KH97<JY]_N/U,MX\&(EeO<E.DZU]g=52M?5[SUYC#U9H#8M<,VG<FP)QV
c>;Kf?K=LgWT3,9N#5e2IgcU;6@/6-.0>?9]&J?H4ZL2EMMI0N\8DEE><)@<M)7:
K.V=LPY-0IP+_;]VO7&&\7P=IdH<]C&c46<:f+)G6&FJUG42ROOUY64JC1Aa,2FE
9>B]EdO2GX+J-^89Uf@T\<&,&+e:AQP#=7e2RM/W)D>a\L<^TJ6ON>;ADKPX:IZf
G(]9_Z(7\-b^C-3Hf[Qd@_cR;(-#PggJP&XKPc<I?65@Xg>cc5]ORA,A[PDeC.^Z
)/K]OY],OE+W@-L/f<@/[+23Vd7e/HM-R1MI\abXQJ&@U78V\+]8K3CA<CTb98Y-
_gW]1cPO>D?^#e@Za9<=f#M0T+>EI_a4CPe9dL999>TB.cNI>M5M0;J_S-+[#0VP
)^N]W8-eXcQBN8L&Q_OKPD)<:2Q]OHKF5_gO//2?)7^;G:KWT.cd@M]aZ0A^H/C\
55I?=X3EOQd24QO;]+@4>.UWI#>XMf3X5W;a:KS5[2_9:g16GELWC54K<NF/\6\&
bC\R:.Z;.2-cRa?ESBNYOg;G_.GSe(MG@8]g4S6g<;=QCQg&8HI_.GBM]EKBPP>S
Ib/#W<I+TAH.BV(>]9N,L1X=6,7+BeM1V/2dRBSg1gXO;U--CHK>&K+G([I69-XE
0eV#1IKF\0IgDA/5XD(>N6#&&H>,eOA(f(E-CE7Z@Mg0_P.a2AM?#GJHPTJ[A5+E
E+&5dM]LF>;>E]B6:R@(J#M7<P88#dNX]DeObK?X(bGSZIYFbCY[B9e-0ffE[JHb
#)UZDRVXbJR12-NfD0f;M#?O#S0@^/2I?,:G2O@0ZG=LgYA9=9VC#,GN?PgJ&OX1
IBN0Xac5KH^4SGFN]M>^:5f[(,ISZ31e4G-<2H13Y\K807(&R30YdM4gQQ@&>H53
HHAR(;Q@1,QX]bTebKCAdI/7K[@<)<^eKA>02fC.ggEWRQ9N0J9gNMLc->&RS6B9
^cPD6ab4N+J#8e&Z6Ra<P];OI47#V9PQCW8=?+XCWg_bf1BO#;>>::fT9b\_.#I?
PTWD05PD8DYIb2K?gH0#7X\1:<4B_/C_:]NHEgGZS>3T.K<A;,fe+acd/\S,We]7
>>?CO6DgZ)T@RO5ECN,VH5;&#LJ7>\RO/-Z;[M#R?<@DXHE)IYbZgI1\#f3GAT(e
T)VO(f>BaDbP/SRde7L:J#<@ca)4.5&2@b\8_7+L;\C=V7VZf(gYDJEad]FSWA.S
7fBdIWT78<V:JTd_J&Wa[KWaM024eGJ7_c.&5S&B>)727X9?B)>3;6P=D=H7@#H3
)2T+:JS,+g:HSDbc:;((SffdO.7\Y-bd_@&2N;A/I1Q70L:YbH12.GR_+I#&--+d
+\7(8&V\9/FaLABQ/6(ZXS6]O]edW=.FdZ&91LR;->O6.Mcc#<J5<5e\L?Q9@JYW
b0GH<EE+R=.]Z.&,3dOO[^4;.A6RSY=(_IGK)QgCQ+D^,2Q(GGgV,;WK&dV5:K,P
9EL.RdA_D@-FG^Ce(Z^aPB3N0g]:3E&b?e:IHEPRS(#U)J4>5]@P-a]gM?(]>/I2
#C2#W:^[#aeP76K=A&F]^EMVUQ)&-XUH.VfSH2=cUN(E7,<JU?55Sd[4+?R#,P+W
OZDE/0-^D?=5H,ccU0dUV_M/>8W4\GFY]+H^;FH&0OXR75A:P\N<,[;@F)+&LTGK
IQE2[)V^=8#b@Y-;+FO9Pf<,N&SX90>CQXU3I=<8HB?gOF9AYed.691KG^U8/CMS
M+I/W-e>&8b8-CJ.ZAX#Nf:]1N;,AD@0a_.4/X:+3.8WF<Q?P#^]B3;9]?6MQcNL
XX,0@D(,@6C7W7E]D_N6K8B.T2U9Ng,R.7NOF;O8I3=\(./MS0[,I88JLVT;?bY6
9V]21;0.PB^<HMa:D&]:f#[>K]ZYU:SJ5-&43FY,E\9JO]cP46+.ZI4BD)736eWP
27K]^M32&D-/bH]#3GN,:]aI.>R@/:=e[467LE,Ua9<;P3Y>3aR[)P>T1RR1M]3a
2V7+@PH>,cObNdZ,I11>2&FWA/O-;D_@KbN407O1I@.4#7bG=XQ>9gXR5^YXB_QP
;<Q//&?#L9@18cYY8T=;N_^++_-E-E4/QSb_P<)W1F#aHYX>3CJ+cc&1CS;db1SB
,P:YHd3>J=a</JYgU8=aA9VO9)O9TNcTe5K3ZK>:VP)B_YE0>?E7d7aSI-ac4XPX
gfHIXGG@)FB0YI[=I@=LZ4_061-T2/XP.9NGFH4@9a+?2_U7TXL1,1[fc.P&,fL1
K&:N[HP\0?bdc8&/-Wd87F5LL+:<4+U3bVCWYL4KV.UW[(<If.VCH@3YH+9gRKA-
@FT@a&S0Y88eG?795RHYb^D>bW@5E1MMg_J_BSLb#PWL5]0W_Hf5/f)+T_bfXb(-
0B4,L?5#=YY=^=-@&)FbI-_;b]>H4ZaM>-VUG9?&J&FL29&M-S:+6-8(69O78WDT
U:2[f4PYg5R[LUQ5H8UaY:4,b5,bQ6GX/]0J8)K)gM(ULE_b4@&1+.a><?0AQMT1
-L(VHScL.JRfGY4R\a)+1I&>Z9MWU:81Q]e75\AfWgV6YVZITdUJJd@@fB4T<c+G
R;eYHZA.e<RKJbC0f-@JR:MB(>O4Y34bVP0fQ/G<T],\JBKfU==I2GFN^0ND74Lc
VL&R)?2+6Lg.FH0Sac7d2=5DJJ?3/9VUQ7(=:3I\WNZHf:\Fa_7^W.TXCXa\O3&2
+\4De79P97dCOI<V3^;SP?0\BVc\--S8[/YR]VRW?Y;&J,9^dGdA=E_Z)5b;QKBb
5JMQ4S<a1S\GNWODcPEK^[>dGfVF.LAf^U1?0a9CWGPfSTZOKX)fQD-g-cKHA-+L
\UW:>C6M@J1#L-GMWYV:R.<9DCKV\VN]1<a#EEAW8abHIQW<S5<3K&OQ^_>M46^b
@&_>^B<@^QSLTG,&C6g29H<^<PQ2fRJ7Lg><^Ga)fa8G:_@H:Bc_86F?29DCN3YX
V_5cW7]RVHZ.>^[bHea932:IUPN?2X)A[9]N,-W#c>f5dKGXS:^QeQKcSBU#BK@I
12Q.-_EO&--b40.f&+Q5J,ARP<gX\2:[5/I>7/CO::EVD<NXXW]QWaDL2.c/\7eQ
+>6bLbC<?XO^RKVS@PDK>,b.g&+SgGSJ=R-5/#,LLPQ[@I_F8]c;Q1@ME8W,0d(<
,@+Q@-RF-:6@7PH1)N;K74^Ld)aH\9bZ(J/B75[c+d;17Q8Tfb(0fW8LSZ_MNBH>
,9=&cTQKNQ(#+g@:Q(JgM]D[O=7]?SXaPK;K97[--96,a(XD=-gV4QD2Kda4[_YR
DT<QKN=#;B6)JF[E^,7N62aDL3e_f8X;>c[0H7]3Q5Fa(G02B5O3V?N3SJL[RQ&g
(&XHeJFE4Y(46W:2^O7M;-UA=.?,LFLUTQ?;Cc2eKCIg1TWU\<eZRCH1BDFBda^4
-00a+e=0K]_4,=4F-.^IQTDfY(DIHNQN/32.C/db+EDc[_,ZOR8FBW,WfXaLMJ=-
WN>H)P\7S@(U0,+BaJgX/-I\a+^P-1@UTSPd[L:4K5?7JLQT2\U(_,3UY6,:cRH6
&J71.>O=<UZU>4Q)]+@,cegHg09X?a21S4bAaS:e#YgTd5O5BQdg[.K#Fe(7aAG=
_XN=)K@EH2ab?-51.4JD9F/a;2BK&S>Kc1^GBeJHCY/_&<?>d9[7M@Qe5[#@T;>H
d.+F4D/&7O,/)A59(Z<4Q5?<#-+R3XU^=a=H9Z8FV#=gQ\C5eC2EDTU&0)SG@?]O
P9[VaT0T3GgQ;NM8.>ULTK=c^0edR]7><I_&5Yc01\_^1NK,#I/H;ZXdN<:7@FYU
OVT\7IMb-OVg?;YbMTS-a)BaIaWB,_RG8S4@I8cI=_CW2b+Q-gAf15d8I-43/)2U
8^K=H\/fM<7ZHa@e_C0])LX9.G6/9Ne+K@,HE\XZ3gO50(:BdF#=IHY@L2>.W:D&
G87FMgH+HL,_=D?/\LB@aBJ?e1XTQa&f@;A+5ZM-F19SJ&.2#4e+;JBe9<XQ\UK)
>B98O&KKSd>./Y9AZX:g;Wc^3KQ1&4EaH8ZUFX7<AW^0YEFRC-5\\QYC;X1gPCRe
Ic3Q&N_fB=Q39.T;(W=E;9@H4fF-9=O7+&fB+>dM6CB1)_b/:.ZAQ0Lg3XXR;DZ<
d:VVMULS@0V2dY(LLB#,VS8_O2L,63+3(GF;.:<bfP-1VOACAFDJSD>P]Qgb7=3(
O0J@ZUY>3ZDOaF8,K+6Qga./;6Od[>)AVJ^)Z8D:=4W0KB>Cg+#/<&(M2[fQa9XD
W>?2#5G8e,XZ93(4?/.WS3O_Db@[X1C\,1e\[O,<I0(P;U(2XK:ZTW8Db+2fP.L+
DY=7XLCHZ#8(dE^7?NGcI@L.LLU1VD+[&N/XO?gAJ_;,;GVba]LJW5P-.bAF3Xgg
/#:,1N[6RERU46;)>bg\/7CX69=T37-,QL7#M6I9WEgY9L.fR052278QCI#2=YD2
.[-7DcC]8VbZ\SE:P4[/0b)&g(PRe[XYI(e-M?[D-MTQJKX9H+<:]:g_3gA/D:,O
EN49\1c;;H4/6VHM[RR#eP42bTV80/IB1L80K20[aR;)UQ#&1Y/:Q0UV,A,ON,g@
?Z45=d,bF&(GcF4JA6APBcVgJF1C/UfD@H18@c<=(<0-Q[I0If0COUGPKC2b^V<D
CZ]:M/8-HEQcP2.NdQ4=J=#W&VD:>V2&ZZ?Ga4>9\0;+63+_F:4^]O.[5J5E8(Nd
S.F9LFTaK(-NQ9V:JS;PaUVDb^(4UBMX[KA;HDW\&R@PgNM-4([g.GMYL1VfB<JM
SW_RU9O)SRC+)ANZ-Ud98.:M-1#>dEG_.58QSEN+6F7X5SC;7L@00_>@A.<0UIF7
4ECRcXMaQTI=;5H(JW1NcCTR#^F_[)<;&S/-PXW=dPV2cI#M,.MTQ&8aEYP8Z5S=
.a@(/\(b37(I<0,N[F-:5dD03OH]1_.5T.L-<,2##[fgg4M86S\Z43YK);LN<)_(
,/2aFS1[--#c=HgL2.bN]7]X0&>MV>?X@&:Q=BWc+I7^[/4cBKH-.QFSg.M(G31f
-CI1,ID3,c7LO?W?)+?S-d\W4ZXUI14Z4DBVf/K.\_DO03-X@IEcM^G>8K.M+MY\
3:e=F@F@LU=g-L@a=]SRQ[8@45FZ2(f-_F2=:;DZKN=^Q&?\1a&M8@Kd,,3LI:HU
FSTU020F@)C;MeQO]169e\bW4e4G\6.=dRULTKH-aVI1KeF&P/ZG?E.5T/=E#]+c
V[/;^ae1V@0)E^@N&f]gBe8F[eaEg95QO_g75QSL-<^A#.CWfIILT>a48dc]Q2-L
O]@Z0<BD9>#VA/ff\K\BV@RX4aQKLgZD&KF@LLNJF\^]LU57]Cc7M3.<(OgTH0bK
?A^+LS2I]AJZ]7T>WI\_.c2dTK+2=L,;4)2H^;1&?&[c.^]2;M;-a2WP?63CMEB4
.9Ae/2g.5=(:6ZX-(f_ZEGZ_M;bVeg)0dI_SXK\O]HC#O2Ma):WMRc=LDMW@1.>b
UU]WK>/4QLLSR.S.]18(URN4QS;g)6AJ.LA0=ZSQe()-CXH)(ZOG+PU?eJ:>4cBg
gA@C@cM->]Ed)a;g2W:+PBc5F6DRc66dW,\L6E27:KWE_;B9^Z)=74?O]1[V3,dP
dQCaZ9B]J^9TL4()V06@=Z2VUVPFa2RMCc@#cN1F\eAc#SKH(?B_[fV=U5T1JD(7
PJc?9S)84SYCS_CA;MLC>[;bN9?>Pdc((b&[/J(GBZgSfM3L]RV6[b)0>/HFF[04
CMd^e-gHPUVXL_;K;IfT18B(Y=)_#T/+X^OX4/8R&T2H)N0R+E:=6[J/_#UG0\Z8
O,H_C9C(?De:BbV?.A9Z2_GJIGH2a:#5_IV=(Od0Wg&Cd;;NDg>_?CS5a+(8[1Y/
4JJZK)5->a/RdE8J@0I80KNXe5YO7;-PD<(>[SQN:I;;Y6K7T:;b+F_>GF<].>\O
AZAQADL]=Y+X)g;e&G^54X&JDQ8e0#0(c(Z7(91GNJ2(7#Z>0=c#/J#-;N7>W-5E
5W+SGg.:T@SUAQ#IN1dSV?:Y)?de6T1Y?OZ=QVKRF++YaWSTQQ3A0ECc&J3N<,R2
GDET-;QD>Y#_VF-1W6R)8W^c26U.)YS;N7M[W&_\CLMdMI0T]9Da+K9PUQ\UWb_J
eTYfPCD7FF734#fdP5D6O1R5P^DI3;-.(7]fffK/<6.>UVPLX/+>D#W456S1d;f/
JZ=1OdRL71D7D[(=[0X9@,FIg9_2Q8WWOaZB+d4A)J8M@6BV]&;=L]&2C/0:a:E\
9.??9Z#9WM[Wd<.5d>/EDT[)<^fSVRXRFeYMJ:b/gT@ccNQ^EG.K_B4ERf7,O+:g
@;dcL(NPH4OgVNHGY3VF]FZf8N7^-49[)2QgVa&:_RVfbWR<TE.;a2B.#f(;LP,#
Gc/O-]YONB(RG0f&;[:Y9aeSdS:Z4M>ZcU[JVZKf9+YgZRE:0Qc)+W.XAc^QXU-8
M3S6WE:Z-).9&U.6?WV^#,dca6OL/d9KAKJK?_=V_K&A4D4)U<GaBS?d=<&((5U(
K\SceR2S(EP;Eg5+YC.:@J3cD+;T#EC7eHA.,3aKY:G7KT0K;b>2F:?JGNeFY5#6
^>@G5YB+Q9c>f3,9:]RE,Ag#e>&++@BV(5&Q0JLHUa4,>:KA6:<;\8BRe5<3)<7A
O_GR5b]@g<&J^#,A]]X7QFCAL-8eUINJ7C_C.bA3L6B6KCBDGAAK?YC+/&-E?X+c
-FLg]F)3N,dE=&TVWP8)OYP6:d1B_?VTHP+dTVPM,_?;&3[LH.eIHZ)VQ.fS>LW.
36-\&ALVeSD0?[&;fFTUAYb.Q;g5.RH-A6#BV.LNNI=SXV,d<.S?XT&FRRTRW5H;
c&fA8II7U&YgQ,>:-#<<K#)Z\[/=URS\&G#]WYE2AaB7aNA\NGSXfeg_(AB41S\_
N:XQS(T)H+JBaQPcKeMFa=.I<=+)6DW2\<&d)ECOS>7ZRB[12E[0\);<Q6\X@Jf2
_/?WCd0YLe]fWg@HF-KR(HM-b\O+YOfJ+[3]QR,T1Pb7/H;Kd=IQE:/+a,dUa)-J
_Q3?R9-/[9)bC,,X2<Z(_3BY[7+cK>_JRD)GD1E,F-.cW>&O[F3\dTH(\_I,<8GO
3(eQM1G_I\+-?#Y?7OI9d@K0)837OYKS[O)K2DFKd?Q&SR^N?]K/D<@</\9,gO:e
3-b=C\SGQT&P0O89fdSEP+W8+(@5L\S&,-B)WFT]YWf]AJ9cF#Ad<c9PK/5c^EDf
4;HCJ./Q,GK=<\a1.C[d-,=ZILNU/?[TEXfC&[&05>XW5S?6Xce_W3[_X=Md(Gd-
d1YJ9?4?<Sbd(4He4\VQZd]3e1OBfZ5F>CB+U:f\)3^]dTIK0?B77&_cg40FNEbb
JK8JRS-4:AbK&\NeZXN-/7E:9M?_4]5O-KK#8G;Ig[#ZN9FW6+Mdg+DWM=\>I?2N
dOgf4H4S+8F-8Pf(LSPbBgN]gV/O\FM6a6>=H)4&c@#)LQ21Y,Z2de<1+V).R>A7
IK+&\SJ472[f=<^U[B/)=+\D-S^4e:4&NRHL+Z]4A[P]0[JU)7B^>1Ca0\T)B.(2
\V7D6Q])FL4eXF8>fX7)f[&_E,P(TJ&PJLCGG2P9c3YM<<?RPYVe:c0,2@Ie-J1/
^3GaB^O7Q5^Q/cJ+d43Cc?[T/=#7fce1][W]cU::f.U\FHb6])8VU#_](^bHZ3_Z
bY8NSdDP\IJ>]S._aK-TB\08YMKgQW>-AEcdJ&X=R+gF=A#fNgg<f[d>USUb=<^4
)/Rd8TF8@<HKXE]1B+>J/6OScJ(#=JG>2GJ+&R4^4a7IgX[f7>&E@GdS:2T4UXdK
KZI21Ne;A-fP5/J<<)OV0+72KFV:[,)44GQ>DOJLFgVXc07[KD:U^D&\^ELaS(b]
f\ALPfN)ND82NJ4Fd3VW0eCMVL380RMAfe65C4>ASW=4aO-DVC,^/,=;cB-4aWIZ
DSOb?[(6>O5&\&E6]QM>BaWeAe8EZN(g6eDX;P820E7SC9JO)A^+cae?9U=\Z)2U
d?+?8ADgf[/<H8L50=Q)@OJF7dKRc?b29NZfKSX&_(EbNLaL?eF[g7Q;6=(H.deY
,G4GANXA;W>:A-_Jc5(ADXY?e1U0KI8+g6X6d/-+T14e2>JQQY&OUDGDHMIP7VLS
RBUL?2ba#:4F:d;2CUFI/#L@9/QQIeU8>=d[[g6,f)B64eNCSg@JT&><F5HMb7H-
WP_a.37MZ>Va</c/UZ1Yd@d)&SET?Z/YRVD1g<OXYEHRSXQAAb^:T+/1/VbP5C21
++?P8C7;@II)449gZP=aa:C,/HQWYX4ZP27<a:HLA^@[L9d@M,\/-bZN754(YP:.
R\-S;;OX9H:.MU<JJXM4[^=.TP\dNUB;7/+dO@Z6=W&GCg[B;-gH&Y#A)@Mgaa)G
:&D,J[-6.g?g5ZgP](P#aG_Ga2#4?V_e&DGPH@8HeN-#aA6UMKJ?81/N@9ZF5&:c
3e39FO[0<(\@N)[_OU[=NAFH;_GPYG1->C&D@Ga_2Q@MRW:W5EdMgc.PXdF(gI[X
YC#VcFf1-eFUY_\88^G)3-9PV:e0J0S0Yd<<GG7e0@?O85O<>FX/,&I9?L^:XK[-
]50^_B(8ZRY\W:/V5N=_]Nbc\CH1^;ISdXV(5045,54.=;=;ABO(NCU+4XAIV.#E
A&]4-7]bLQ4\=?K0_#+,/2:/VGU?;[N25R5GY[(J]Cc#A:\>@&U6JJ2W.\_QX6#2
)=:O\0gDT1aNNL2H51_PM795K]E3L_(d_4QeI1&Z_\TDTXJ66LQ_-66HLK6f/2-B
6J(=&S7+ZFSbG:5OSaW<XSVeD(ONffR_4aKd@?QTC8@&SB\@4_,H;9;J7^CUYZ3)
^Z1EPP/&3aUBOCF27b[fB2JIK4QZT<Q>c9dD&X_W^eO-0>4VY,KdDR>^?ZV:\U@<
.,+2L0=W],.Y@GcEH2GE@K<O2/eFKML/aDd\1HAQ>RL;X)15\VDf9\\6KN76aNH3
0YY8bgHO+gI,eI8)Ea/b#_WFEbC=TI9D<=>,N3GfMQb=ZNQV<\G-A^,6Q<.aG\>#
362ce)IBSH1):e6IF^g&\N<7b6RNa/Q8Se\OY@7B9H\J2RUN-PO3^/DSCc10N.QL
X1Ufd:WR^;bC.#cPeCA<52+5b^e]MZFd+d)GdV?ZA&HeJB2KMaPaRS^CLBVPZLLJ
T>YGRMR4050B;[05?JUJ(GQggd&VBJe4,&K4;NYFRSGV]]ZD(?1BU7E28PNKbe<\
3O\2C;^FD.QAS8W7F7RU+L88M,2QE&R]NWdMD_YMPY=(&QFBH2PFLM@C6N@eeG+K
K2dGG]GbLVU<UUA?99VK_]R@XIZRYWT7?I[e+e6U:Z_fd3f6Ud?.5bF0JT1QS>?[
\5O<E@>)D.fH9>;6WFMC)0D1DGc5,<H.Y96\WV#Ra8F)3BF(e3..=D528.4f\3?G
E<H00g5V?S:bdHA_[=5b,GT]>^JV=f90;SS2R-42NdHZR]D8a1I^S<[S#?4ESC7S
ec4I03=O=>\NK@Sb2H3(dN-Z]-\_K(YZ>5PcDS/[138d;;Y,F/B/f;(X^2NJY7=.
7=W3/:UeDK(WP@GUDE#DC\2QQ)^3?A\+I,g2U>TG7)0NG7##Ma@e@dTSc[X5Bda6
=74YQA<OA3RF>Hg+1J46T0J_P[G#+DO#/9A;Wa\dPRQ,AS-BG=O^J#2AJ1<BJO<Y
<<[LKFTA.,=G42D:(?,bAYOD,S/MQS).G6Z@Lf(+d)AP#V7+_ZB]:9<UD0<f16_1
M9(IM139f^\NKL#.8=+QY?gVJ^c7.-83J-O)JA&H-I).XLA.VCDeUaHR\ZSN=W(Q
2,4PGdEKCM^SZ4_A__dPI&J-.;R:W\\0:QSa4+6e-]0-&bg_K<4NQ(O[g[14e&^3
ZR,)23GH?TF]Dd#dUPUI:fH6N<F#d[D]HIAJCM>7YPZG3a#7(DZ-C1fE17WLbOY0
Y:5H_7V.=?<WL20d5LC<8/8HbC\D?6&086MFARb3N#Cb>_H<L4H,\[W/<WL-S-.N
1\C\,L92eCF[&2LF^39:aJJOV4((X28e4LI^:XY^0ZfRgRN4<+B1,XP:FATR4#8U
FF>B0(SA8OSBc]?(FVfTZ1c-QeFV-C7N.(5e4YBZ09I=-9cdDQ<N&;_PF)=IY,&B
bOXBa_D8]:4d,=;D(O8+_A&#W(ZcQ:_#=aPO?(F(Pf=O)2#:GJ2ZS7O@:#M468gC
A,?IQJfc=]?dM<4e:7KVaAJ/d:Ug&c^0EXbbL1PdLe39c1<K)eQe^;>?_fMQPa2,
W.ZIL,M1URT+b+(JLgYOWE?&/.G>&UH05B=B7?NMTERVURUJA4A:Xcd/8<T8a[L-
:?F<IK)f&1\+3=IF/A8c:_PLNIggR>J,=^P5U);]NZ^4NNKCe5c#^E\1fU.Gd[=)
.bOWTAaO-(\E4e,?@F.g:W/#N1\/gWVQUQBKFN/Ab#HM_SB@>Q-US0g(b48(bYOT
<e1C,fTAAGgSAfb+RdD-ZZJ9N-e<;O#7-R8=fH,3(I5@Nd+BZ\C&&f+1X:[7C/47
)#c+@4cPf<X5c6FYTeXNcAS9cdZ.V.5;gR_W#\_HH9NJ/SF778=U3654Y^b_e>\a
dU-P/DJ4<5@&Z>Q7P@,bGD)+aR+93c#_IZAA3+Ge;N^\B,5Z5E(?_R0Q4be][WTc
Y0cW/:#[5@a&e,;O33Fd_IEMdb_^Sf>T\H86FIeZ:gW6FRIFI6CD,:bX=Q<EV_6:
+M@#^]@;[C?F0HEX^/cZXY@P<?^OY(3S5L07B3[G:P8eF[G=f^bO(g^]-K@EE>;K
b17g>IHAU1A1=&>DXK:X?O&G>eBaAU4:^aggg>#UM1FZX]SM<.#eV;O95<G<XI0E
ef-#SQ?SI_PI:WFC3)+L:[^R4J:GH52D7(U##M^8A-gY^\95BY(B;)CWHPTL9f]g
(#N<ab=\7N>=^aVHZQZVA[Z5,T_9aB=:c5g)Z-S3TJ^]9,cM3UgCVR^#AG8W2JOT
\NAbX3e?0fTB,<,f#b@LD:X_[\B.F+R]BK,3?;M29C6WXe:>N^@UFgHF9I1T0UMO
2AZ/5#F0WX=daO097+-Z\GC8#\STTZS5-1PJQBZS(OW=ON&\,ANTO?^<@6&E5,.)
J0L2JS(2GW\MF1?N\E=g2b=^eeGWJaXJQ01]F1=c\bdfF_[=2&^Z6LPEQ]Q-W=X@
LVN=M.4NG=1G&ZY[-=@:/eMZd.)faJ-<<]E:#(1HNLdO?0W&36&R_.-;AS5@T<VD
Ba4I2O(bD).d5XfK-.NdIf@+R3AKE5FP:-XMKbgTB[;.19<8P2G8C4QPZ-f/Y>IG
<3O&b/UBW3?gVD-0K3S9a>:3dT1T3GMG7c<a0We,ZJ#AF+6VK_O2KJ8WAZPL2eL\
SE(/f[NYf7/2eW:0eC>RBgBebb;KWEe4H3):U\(+=1D:\B7A1)b3?_[3H&2E,f=^
]d?0-TZdOFZQFA)DK--1&OZ:c_9U./8OH8B=-:0H+E_gEA10Y&N-[,<1<=&C9BN@
Gg+9]2B\8R=#H99O#9+X@@DAO249#N;4>?6U\79J]H7c.LAPbefRX_WI,I=#g)Ka
0Z7/HY;M<=_B9^QJ+7;=Z32YWIAKaE6YFDC];f(01EaJW&KY?P0NZ2e,EeU0BgJ>
6c7=;193eb187W_0FTFW+Y+^6S4E2S/Z5N<V_:.?9C1\:7J<1K:EM96O>8^9HF[R
;\&_g.9<AS&]8AeBd+e\4bB]^<5:0),A6f+cY]DT@&DN8BPe.]91e@>P43I+Zf2Y
:SMP9]BOJX;48e+MSD<XLB/P/M_7D4(K\b@3G^[(#E8(A.Z;2J/edg4&Y\4Q)_:X
QFBPf>FGRecCedDa]],XTSQ[40F-Y,O_+>FUf@48(,GU80EaX?HM6UL_V=?9P,\X
\FQ5\,YIgH@3bTJPgQ]X:([\G4>@YYR(.9]2W?JG^\E^0[a83;WLRLXHZI+fATHT
7b7Z_N.SPN<+Tc1dR18>.:dSS3I)A@<?9:eW;;7/_01U6\A=,[Ba1(D-bQIKeAgb
1Eg(A?EZH+3ZL.XKbZMZZe.H7UN)0W>R0bMX4@),RFL7:gHK[30EbS5=aEPddKNC
4,=41F-cU8+=8g\Q+9I1H61=Sc\)Qa+0?:D4:-+]RZ6@CI.2WM8^Hg\0Kbc7T\e?
4-Xdc4:fO#67I+VfCOT\(7=Zc<;=UE_VBQa)=3XB_LT9R<7R>N)#UOR^B1#W.aFc
2.fLYSZM#=:Hg(5\B&0HTS75e62(::>F.=#PcR=KV@eANB?C>T)e8)OfD+Y^<J-K
=\H4N+33ZJ=W;OEB_;N//PR<).2<dEW93Z?SR.c0F[g+<F#H1(.PMOMMZfg;4@e,
SY9JN45+OQ<SN8IfCEU=[1>_OC:(<UZ46:0TIcSV4PLH8;=V29fR84F42Z^//,e>
P@>c9[^(>THf#G?c:1e^LHA\7c,475RY5b>,&.=G\])>7]C+C0(g,Zf:.S-&Mc79
ZRGR9.dGf5DeLg=WG;BT#O6KE1FgDa#WY&G)HORUIVRC^8@@UZB.</7[P.Pa8_VQ
aeVYC0N].U[4<<_a3G6(1OJTL+\/B_eTQ?9H89gZN>0eQf7Q3PH5@Od17Wf6XHY1
g>Y8UI+BdD>d8Rc<e\dgP=I,]@GJ7;E&[DC_LCY(>dSM@N]_GU=B&W1Pd+5105L(
&JBS?M=KE&8.3B?\gFQ.@GHUGWb_?g7N6c&EB75DF[:0W<K\FNHX[KE>Xa,F]X>N
AK>C1bUQ,bTRe7cAF;\[[4?0d)\K)e-1-+Sd]92&G,]/aESR(\FC(538M2RW8A]9
QcKJ;I:L=6bT>S7;fLH<SU^b21&@;F14R+f/dL4JP&_2OBQ(P\AF#6R7,?IEC(\]
/BCIPBbL:L&_)UX1MLf)HAH5@)P<a2C/G]K^+9+6T.#YLK^12A>C@+OA)/fO;XMd
UBW.:-\F09_D>5gaGW.:>V7^AW6I-T5<]@6UT<C@UMCR:@=S(I;E4eH&[V[-a###
a+-G6X(_[1UIL9NB,DC(SJDJK#&-._NRX.-dT&[\M&AMOE4PC[O9^1b0(,d4NB?F
]L:P@aISSD?HdG(J?_&IeDCK-)\-.8cL@W,[VH39d]aG8D4/]8J=D6L\.DIG=/O0
a_9\=M=@)<NeMNWB8g:e2E0-WFaVXRgBdReL7:-PMRPg3//D[c:TABg&,@g+2C:Z
V-TGZ=.^R73Yb?b66<H2Z2f-P3<&ZXYe?=IfHb;>A^1IQPK_\GY?]B(8D3/e)NL+
5dd[>37W02DGTIC2QV23K@D>ee<+Z&CS6Q+7L&&L;3T^fXRK6_)\L[9(9=WU[+C,
gQ9AT6>4YNTa.-WE]H/SeH.>/]NF_8\Ed>>)1RdYA3<&f[WNAQI^YLLK_P0=G]T(
ZI0eH]]NN?TLaOHX<fTH9@ND=^.d-7//9H36031109d,&0;X8_RV6^McF.QT4\#L
03#>7f?b][KdZ?Bg9[O=XS2&GBTeNONYO:TV<<&7V(6VR:@1eN_IeD@9YAT;0I=.
FZYF6>3)f-bKL36E8>b#@:&^#5XR1OK8BM=6:-^QBG^6V,:b)@A@O]AM=gg<&afM
:Z;:;+/(+3I8P;@g+d5KDUb0(\A0Ib624K_A,=81-Wg+gMSc.W.Z/]@Eb4A=V<O-
;VE/P(KN+B[;(L3M9N8fUS.SMM^Y)BMI)4E(=GV.3.Rc1,>:g:+#<Yg=A9@L&\BL
O(^3bfgb&1=I^].0(,02&LPK.B#A0_g-\(QWZ^9]IVM.#Y>fF6->YCF[;DT6B3]f
d=cL\?CV;ReQ_:(>^7H(MCOT+&0KI#Z&]W[gdCD8OTdT6CR#6S<O>4:./Q;#T+&c
e(,-<1K:LW6?-;AfM6(\I2&#)Y\2d^JSC3-XVR;DgEVQM206G_TBX\TfICN&aU@4
NCcZKZU>W+USQDOCW_RfEILegJeeB>\Wc4&V\MCAT/RcW3C>7B.WNc/TMQ-:cCP)
I1Se:d@WT2A_<I\eaB:^XBQ4e>X#->W#=c?YMMQ.X-<_1W05H>[b+.@(RNH,JJa9
RR>Y98]d<PMN/;K?@]Pd7UF9KeJNg)1&TU^S?:/I[-AGI0GZAQM[-GA>E1L1gKLI
IaJFC6#8WULOVYT./cSDH_0-D2T03@6)\bV0Jfd8\_0_D;VM:bOE0/KSf,NNZ]V(
APDc5,@c?\=-EDYH7W9\CQV#[876_V6B31&S4bH.8?OB0XXSH7M_EA6I>I:;a1^R
69^c^LBZ/.>I)_Z/8<Ag;(+V&KP.P.a9^T0=Q+(5<>79;A<IB(b6cAT;];Ic-Lag
=0)Y1VaMQ3?1U_WBV@2.VJ42R(BAdF\9EN&R:+e4-Ob0TC@([D?+V(:36\W,f,UX
\=VfLA7V3[P&_;JHW&Ff^QN3Lb&0WM@gGg)Dc_LGeZ]bba[A)0V]NJW96O<H#C\R
J0d^)RTG204<Q]\+--E04&Z.8gE?KD-]A#6.YCc^V#:XcU7:=O&SIb(O>&67E)8X
K+\U-BNP_a-NaF&,W_G\&\Ee2>EMVF0?VJGRI;])-S;eE^fT/U&97S#Y]7+4&YPJ
aD686.dE[J,>IX,MY8(K@R;CCP^0<TC3:fG[<c>=:(VO5Q@@NfG:]I4:(I[#47dM
DfZ1>\,LY-a+DRAH9FJ@SDMUT7K;:>29_&@?4;]Za#:H8IgT]1f8Y^cGF02;2JF&
]CCN)DH,NSF]E^UFCdI(<1LCM4IS0J-4H246FdX++Da=D^QEV3a>PMX49f;@Z[N1
1I1@]#a4JYL[I6]7L7)+=d>c2S>=NV94&2^^:?0(S=7[MW31K>FJPK_6^4)P8cO@
&IJJFRMf7c_W-f;-KF/Cd/^0DPCJ;[:=ZTgAd@V-JbL5D9eCH9:/>&VF+aY294):
0T]2/VFKfWDQ;4MP#X<.+O+\>+R]+)RX3I]2F7XF>a1RAT8=M5]1da,E,aWX0aRG
OM-MWU#VYL9&N+dVBH3>b@DU8f>R[<Ca-KQ?1eT83L?G#XcP=TK;6KgU18a?\>E;
49+]GG[&C[^3,RD[6#3D/>V:GQ794:aG&<@2W4Xb_3IX]HFSYY((=_ad.?:D<@9.
M<I/9B0H5&GJ,^b&7XG?9S,_2)53L3Aba]E=L]_F:8HcBA?9NDR_DYBRQa)6;4P7
W[L\+_2)YLSURMC<=UYIE8&b40<6W=7SB2b)c=71Y6Ce&C<f<L4bJ+7[XREBRd^2
CV.4,;(W[3gS@6;>K#g(IP3;C?=6KcY@cG[?TVW9&-Z?3HfX)_+CDQFNc\cM0,>X
4J59U(@L;<D4c.S6MK]\g8)5>@_XWSMb.D>2X^;gML^1117OHQ;E4ZeZ]+c3[]Z@
K<2AUIcMZN?HP.\-AITM=H6PR[C=Z-,dPNY(Xd=[L=e1UPCeO4Q5FBDDe);0>WOD
V4,=?K5-,B3-;bL12fS1MOd_M39,_:5WD([1D^ZA;+5dGZ^WBM#?WJ8HW6Q\45#8
G8+.Q523b,E_e?+GC<,O;?eB)+P8A(L43YXK2\0:\[L=_Xf_8bL/33cL\G].(2<e
YWb-03:eIM1TIDaEe=9MFBXCa0)OHRe+#^DVN6X-SK9LUUJR+JXY5ZT/D-MM-=U1
\7g_2YRZ:V15YL5a0]V4=8/&@:e9\PW#\fH\4&152#@6aHNE-3#[;B=V_M?f[<=3
gO3EaMPGb:WaaN+6>6@c#.A/\;d(WY,#OF,TA615@,CEGEHIAL>8_GBCOd>,ZX@3
]FJLY(_^2X3@OI;.O;ec@V-b&VXY<0@+W()9g;Y?1PO:N#K^EfQ7-OMa-K.,:P:f
\[8PE2bA]UB0@I2;QATU\:ID5S(Q0,bH^[K)A)(BP&C>OQ^U(<W6A<&8QcG2R]Wg
,[5]FT<#)eF<J;B8Wf)YVX</d<A,OA#JEKX=(77eGb,NCFKR7<ba^HXOA_0/Q-R5
\-7T<eONcO?8PY2gdL6KX3:V0,?^^+d5]cP\aV.UEaQ(1=#gd1TgB\AeJ^CAgHQ?
^e]6#MLUD1/&#3H?U9FMWafL1Z<K(=2PQ13f2\g)ITZ?T>YEP/;CMd_Me/JX2=@L
3YD]#W-MDN<cY5@?.7[DaDKMaA+N0.-\bV#MHO88-N336WaC[7Q-P;@+?0N=HP2C
0HA3L(C^Y=IUg#Y/@2U,>Qa-1Y)8)c-LFZ2V?6M>02Yc9dWQ1K[TdE[XcGeJGC5a
=&K/J_BPQHGFGaW\>G6B]SME)@D5_G4T_HSM^VfES+C0U@9YOL&(T)_Y8;R#WI]<
Y+T9bYR+Z5U[3Z[8<D=JdMFJI7ZU^fM9+@dW:G+2:,82=eY4dAb]]]S]&I3+<N0<
D]^-QZ6]E7.S7T?,Y4MH,=TU3+H:,FbR5.?NS2d#,(CYS@AgSXgJ&]L^(g=<H/^c
JSBCe&/0_-X0U->@P0365Y><H_QO7;2F2>VHUW7^3Z8KL7\).6<\^5OZGXdCB@WG
;=>DD:62.KOeOP(XG6ZeEJd\.fGB[+7&USZ^FW5@UTFa.7)/I3/<Lba<J(K+PFFg
c[1TMRWFS->M8J9RN+7[@GF@N>6_II3+CFBU?b6#\_77S:/8]W20R[WcWQK?Bb-;
_&#)_Ma<?L7YY&D=:fUE5Q?>a+\7-M3JZ.9#AYJ,_GCIeV96EUV5Hfd3]IeW7f\J
=^//b[Og#7#e?d[3(MS9-[L)+Z-A<EfWdAP?LXPa4b7B24GT@CS0J8VD?gWO=3R<
WVIUO(PWE+e.I[:MU8D(D?3DL;(TZ/bg04N0_Z+KR2X47_M:06&HA?LEcMeaH:2B
GU)QbM,E:\&NHH><.0G14F1[d<E?ZO<HTE0F<I=]&[OKIHfN9GNOR@\^A=Zb\Y48
,d]Pc@G=L[@c72fEG]A;H]eb9+^7?B0Ff3dI@_80\-2FRWM-gg.fQX]d,.6f7g-L
c)f<\>7SI@BB?ZRX=D5RB.P@].;K+5-4+L4H\@<9f#KgH=Y,LGSW\MZ>R@IT,6AF
S)Lg9@[ZS]AWR0\R4R;@MS]6IU1&@K^MTF[<F0IT,?X>8gSK25@O\=A0NfKH/KaT
13FA;NHCQOE()HM&;TL1P#ELdC:8P@M]4QF_#f0(,ZUALD(DM-(a&;UG\CP3O(&[
gGcc9c3M^g:;e]M#N/(4DVB@/>)]V2M-;^eZX;2]QJ=RgW+R]3=-0H=c7QA>C2aZ
MOTXHK;C(2,8HQ\,:]UU^ALf6]_1L/W;5L[eG6f;bCPf&_EB,dI]X@0<d[FIVeC@
A,JY,:L_Y(H@Q9>?1Y-OO?FH,<U:B&YBET-\9FYgVRC,bO]EH.AJ:1?B?&+P=+D1
OKSf)e+5_bZ\571K&/Q1Y<)Q.W+CY::WUSfCSDRe@,BHJdWY^A\ONRZ<Y.c[4Y5(
UJ+N,77=+VX740L;AfO-3:NHSYUGF@Cc47I>+6:4,RGc3HB29gE19VO^:LU3I]GC
3F_YQ985XaY[J_7a5d(1_>+-a?)/&3D:@HcAY/MK7R(&/H9RG6>XTEI?#X_#5^;#
4f[C/-TKRIEc7#/^J6OWSHQ,H&0AbDEUN/-f=]NbgS,#^=S8cAP,0VZ04@/\X,P\
]3aNd1/dEE2_YWKaGUPMfe0G5GH(@fN1f^<LQ:IO6K/ZgHS;P:@ObCYOKG&W]:KC
;RF[=c9NDc).(Ka0S)d>YR&-YO0L-]3+G<Y@DU)Jf9Q8#E+68&8E1,PC@QfJ[BV:
@6&R[W^QRfVAKcSR5;gVI7@/#5Z&WDYg7&[c1a--;/1(gb9d&B8CAAJaW-(FN;(P
Hbd0Ye7&d@9WO+R0]=OQ.#b#-LQW]UJX5^AUGf;_DEE--L(41LEf:b&c-(CR<^_R
HQNGP5H3H:fRMA-NdLJ]1\@2ELQ20b#H<e3@5@S8=S8VV0LY_YC]\&]S6;&YZA_\
5Z,?d[(7aTe5gHAY/R:B9@NS@:MDQ:D&EG[5&Z;aL_3e>AA@55C2caRJ][(F2)D8
gJ/,KT>#M(T/2OZD-?WDU_:AFgU>E\C2KFaGa:f[+a&8;0dB8N=MS((b9Rc-N+.(
=g].P).WPcUaMZZd#]W478OA]&Tbf#3(3P]<M1]#UDH..]U?_,c^[0WKJ#?EgdCR
U4LLL<RX.5).IB]5\d,/O?1\=f:b9^YW_-#;Ofb1YX<[b(Oba7f91859XB^JK1UU
a3L?&_d):e@M>Nc-;(:K:aDUL<@J_Q@JXO+EZ6T#gD_Q__[f5<FWHN(_M7]F)(PT
<IVFYg]U-dCW8^#4L23VFPSQ=P=dQAEF;L_/,M=(WT0B&_2O.[7O\GO?5f=6bGQ&
:;>\IHe(&]fKKaeWL_gTBcE84&/\[/&8W(FU=[f8eG_2cTGC0CQPV6?2=>Z8825L
\Xf6N-X.QJ9L<@OUY&f>&.VNM<,P;]T_^EaX,,3S+VI0e@YJD:\M&O/ZQDJ6]WU/
+.Z^A?JSJVa.#69H>C#F4cY:bBQ2cLY1R.)EL\?/DIH[eZ8<=<66G\]R^KMJ5Fd&
4c(NJ#M-PZEf55cY?Ac^f4HB]3S_;+NVaXKNH:(HW;S572&3U5YDJ&BO8PIL>[Z]
];CWSL2b^e\b@E^#QER?gg#7U2XTX<#e]5V,NAQ6Z#XE8(89:F[UJc]3V:KD5E<Y
JR:4ZEQRIH26IA/J#-F]C=#>Ig&E^J8[LM=K5-L2025e2V-M9@FEMNDGd7TH5H)(
A:P@Y6\13ACR,YCF_:eL?4DIFM5aK(f64<\e4?c0Z0AWf4Xb9\d3a9_OAE:Q6=+U
6T^=,V9#R<02NBb]Ga<F8&AHG\=+Cda6L&LCS&<58+g6eF]K#488^OQJ34JS-+A3
_.@bA_^4<XG>YYYO=\6OXO.2gBWUHd+Qe1dDHRbaG07aM>4RNG?L,5M+?^WM>#b/
4+IaOKTOL^cdZ_7#g[C,GbY83OdH:b8^YbUO#[BC#MWM;60R;,4]bcC?ae7:>eYc
Te0f9V\C2((MG>TUZZ0Q;YCS^.X:;#W=dL/.D,ced,RbCBGOH8S;.&OG,]O9cHg,
(1],EZ,7?1=^@^YXNWYEa25_Z:BAP<0NG7Hf<GBDO@g1MGcJ]F6@()U::f<GF9[^
W.G=c>?+M;JR.OaVWefe-gbg(6La+da&__7_8T(3I2VOU2P]gd7JWYVUX;@EWeVC
0;XK>gV\1g26\g6)8Q0G>Q=MIV32KN(c+@4N>8Ec>)SQG/DP@OV2K&PS^P,&V((L
XTZWRYS(N2RC7)U1?)Q_WGL9].O2[83gaX?/b[V<2[FFT#I8b#RF:\[L[N<=:B;e
a^Id_3KFb5.[I[NbN,X\AP/TDEd]JYf@[Qd#>&5HAaU2f5+VMYd[7FcD<6-W.#=&
3>+E&;ZTSUJ.eK46@M]KDW/1F1[6[;BO7S/e778TDF:cE:EaVM\AVPY\)F910HO;
(#6=7fa8KL<Y.I=WPZfB/HKC3-R8S,UHe^I59JY94KREOP9U?=TgbZbeH6W6,W;R
0^e6a5ZV(_]BUJW?dg95b6YE_,/W8H(D;HDJ9?IKB,1Ae^PW/3:83:&V(=c@ZaZA
QN-6@?[1-5Z;B4XO78f.A(_6.E+fUc3HKb8gfcc6ag19JHL5+1MF7cL)?EAOa;:=
(<Ub[\1VcLG&e>3WSH.5#c=gAE4@[cfQ9J3K:&W)d>=>O])U009<A0,/7cVQdW^I
U9\O^68&6dO#SQRB4ZFC8FOK):]eK3?\=\23UM?dRN\LM?3^IeV4OWI@+A@D)YSV
eP-]S^?g)5[LIdgG0NAVQ3R>Ca0TK)76@Teg\Q8e19#(;:N<ZN5XSV3+WQ2c5/c5
P@PP@3A0FI?91V>^5KO3^0U,Y?S34bf3g<b6bGY#+dRQEB#-J=\L_g7.WCR)5K^f
cU+bS+)M:+C5S;WGfCZD_P[PN5.W3ZV<+O68K=ICXFd+3/\]S8]W_AScaM>5a\.O
_U+\.e:]L:5PA]J5)[PgHBJ?S@e0(I?]d.4./S+:_;aF)9-a<(1Eg;bBA;KVc<6D
0gQR^ISd-(,2R3bF,>4D8KQe/1T77SLBRW1).D-ffU_MbE4DJ>e]OGa;G1CFQJ=c
?F?\-(F04RA3D&YY3G4B)^KEHc1@-N)46796,#(<DH90J\^;99cHE#O2bZe,PA=&
_.:UK?9Kd.GZ&H8R36V+;?94U=cfQF+W-\M.B:5]/bY/6e-E#,6L^-&^J6VQU\B/
R3+@?AF8T_@SGFY&=:=DVX_V)L<c8;<gW+^OAH_9#(^e][#-5Pc3^]-a2?A\&).O
T=4^[DP97B7[+,GFGG0XG2>VN5.S9=<0<PQMT5J1Gd0_++A;E/,LOCaa9PVSZg0=
3E2ZEPW>35LHYA-G0<0LB9a=cZ-SHS])16-c=].>1=gC?ZaBb3\G1cG1PLHFfJ0f
:(.aW\bG0.f9S6?0IF]^6HRCNe7Od3I^S=AEZa1f00CeH]G+VD6XKH)>L#E++D:2
@d8d^8/fM2+c<BFUUB03gYLGd<c,YO>^XE4_EVcGcFLZ?PBONfWO?&:C\)9@Q]X9
M9d:gIe->7(CD2F8.)aK0.MEJdNX4O^YYK4_9>[AFc+cV?^,gU/0IS:.A>f4Y,#E
DMG=B#GIfE(MKMJBW5[6BZ?C8Qd9K\eIO1QDNVP7)V=d_<]e_Yf4IC9/OMP3-\3/
LDD;2d[5VW(N9WZQG^3W@_2_7]6<V1F_(N,bF;)W)d?b[.cb5<<E\+Q]Z40QR4BV
?O42L<R4?^6(6>(GV;Q7)W9R1:6eL>E2W7]4SHKP@SAg&6?&YFU5>5M0Q1@&,]6/
KXIWgH#S[)aOC,6UTE^.WHVgTKLP274(bc,VdB;WcXH+gUfLP(\cO>^(Z]Kd#JW_
XgTdGDTe?Fg@_(6I8_I[EOfC@>8_?Y>=Z(T#7SX.\0,fX0.a<5Zd-J(&B@202<=Y
++AR07XDSHSAa:,We@OEGV75)c-GRL97d<;T=.dZ;KTgF^V\[:);71E]eBEE_5Ld
.PS9ZU_-DaLGKCN>TN[=_H(c.R5RX_e8BC1)#/f@A#AeLG)?cFg/8^+OAKX/55Tf
YM3a>_EA4eWW?&:PG77c&H>R\DQO&Qf5)[Ca[V@(MeLGd.[?5W6DbDE_/?d#QJUg
&0WB4SM/<\>U#cN,I(Jg;T88#=0WM7_+gIYVGS1LTNCgM)d4XQGF)g.-UCF)e?UP
2B#TV)0?RG&[&C;K\DDD)\Hf9AG.F(7gA2/#c,\O5W-a2\Z3E8Z)P-(G51M/P66e
+M1WK\1/JS(,@D&POG@R&_8<U3>F1YLAf/N>]aHV,_d[Z?&)\]8.85)fBV;O?[^c
[#:7QBO<-H3[))?3dg<e]K97AgAaKQUVWJ#8Tgb:#&WS8a(6CG;fG&,7[&IMcBY,
4f0U/<g=g)#PEW++G]bI^RQY0>E-7.PRV^(=C<@gQ]\</?OU?[S&+>B+QGG-F)MV
QV@6J4c@?T;).\31Ld3?24HUJ0GM#beZc4_:G\Z2N;D@7bQ,UaIG>I[R^-0EaY70
BX])O0KL(1_^ad=NT0Y?ZH[0^c5M4/+aD2V:AdO@&ZW>SL]14#7T/=dJdDd-e,:[
g]^Q.O3[Y,@?^RA_J#\4:.)^R+.WO?e2b=L0cZ_WY1U,/K6I(NC[XN2S[=,aWX8P
B]RDN#-/K/g-P?1NM_4##9gCfT[JF4EBYT=2@^d?1J:/M;>987Nb<e8+:12aQMg]
YJ(]2_:M5-V;Xc[GEQU6W>,ZH.Pc0I9PFQ57c)&0b(.:<,XQ[^B,)^Y^.0F=J/2K
(CQ(/7e_]5-W7726OW-c5;8fgPTD?04#&?^>5D-UGafX@ZZ3Q;FbQ,?.#GMF9M55
0QQWO5<N#,&6bA,NHIKfbf]-IRU3_../Qg^8+S,)L7>\06W[Ub;.?1B?deeEJ@Y?
QaZ>(SgI+F_YY/F<,B/f.+_.\gTNCG7YA2cOD[NVgeX#VBg^[=B6@<GgGJX\:YaL
ZVI/gU?JJ>+e=2fHg@SF1PD8=@<^E[)P?6GbYZc@>:g4S]PJc2)]50UYNLZ#aL^+
c=Gf2UEH)R]KGZ^T+RUU[MH22;ED]_@,,]8C+eXR>31?N:2HKU3_HWU5#8KSBR_3
&<d4XC@+6#>).S1]>QP&eBCG?QFe3I9Z-)FOE&?fH2O>5Pf(UC/PD;+,.UBQS,QT
8bb,PdfZS@/LZ]80^QB3IT>K7a)MAX,:3_=;WZ]J;TEP;HT#VM,JKc5@B2GaT#_-
(]6GefLC3U2+g-MZ2(B10(c;?MT+^ID+D/_Z=ZD]&8fUA66QcF;)3<cJAA/M8Z+N
M81K(HE@@#fFcKI]<CJ=A_8D&Mb[fHP0;_MMF6f_-gP/3Ld643DI(#8:YO.NUIT[
0Z:c#bZ<eZ+g3#O+34/B/d6(LN@+(TWN7&^1S9Z]GR/cC]W=;_:#1ZG]T1&5AD@:
V=N>A3SAANF0-a:3c:\(\@KT0V@ba#C2).PWEA2.VJ7?AM[8M/MJZ#VERW,P9eBI
#-ET_aWSI/N;+1gMIG.;XMaC9\dS1B)UVC9?\T)\<]dZQ^AN9J]B_4_K5]ZcI+H_
f7a)43=S5I:HN(Q1acFGf,^IDOVB7:XTE2HbZ,V<313(0ZF5\@WDbE#B<BTUTa;J
6YH(6ee?>fR,Lg0>9?DRDJFIHQ(CC42K3d/6QL^a73&XeP:.DR68)M\7,)bZ=d44
eR7+@ZM@:^fK_7GbWb\/:9[g^3Qce)=T88_X5dR=OCS:5Q6+U>/A5<YIFCQY#TD_
Bb^(L&.&1>A.6(&6P/()QG<4Z4<TMeU+6XfL=C3\e0U&_I:LN5dCA82#&Z0[@N;&
XGCT;#+-^XRKE+&I<VW..ELRd7PV^HQ;@+05bE3:^&LH.Q+;.BO<7=f.Z<3(5bGW
&X.WSUG8+VO=cE3>_b,aZ:da1>=EXE)c^/B=TgMJ0/<A>_A1/c.[T9>]MJ,W9)/E
#7T.N?:b6NFOQ5JRM]F[[/>+/[1G/KG-WMag5F]&08U,.T75c#cH;ed9/YcFL,/&
^YW7:cd@P5/OBd-?=OZ86WWA7;.Y=KIHVc6S<b@Uc.@VY4d.8Y5GA?bD\&\7O4JH
,4aYJEXZHc9BDMaa9:/YBVZ?BVE>J>\7VJM^eT-cg;;LNKU/;Y=JD+OFFg])C\]U
0\^\1<N?9VEYBT7(PFbaT]@A^.1U]#]@\MWXc>U8MF0>8:MKcMUUd99eOH^1V=FS
@]a_&A<0/,8)PT^4QN;>?M3K]g1USQIRMW5O<CPE#Z737eLE]JVT5KC0NR[X)93D
-GW@WM+Jg:)O_0]=&cPGW>G9,b/DH].14]X=;^)A4Q.47H(.GSPPD#46]dVBW6<M
9?>MRJa)+LNgebALEJ(,/=A?#<GO6NHcWb.dZ00)(T9e#+S?-N/Qd-NMPc,UJ7V;
^MQG,g)Wg9UUWG=;/Te2?2f^@YK8CW4XHI=P0>1Z#.I=-XH^&U3BT_U<F3@_E<T)
LC_YL,>K-=_<<O^9;9N:.>JC6TP)=G35;d75]&3bY@X47F)40C3YHK9]1E&1JNec
J>))6_ELI&QNgR&Y#5TDOY[Vea3.LM1S[G#/Yag=HS,1(](0e6\K4Of8C)@,.@cG
G>Gcc0C3EQgEA<U<THH-[)8ZBU(HVKHS8,^MWM+&P3MY@HD.C)0Z:4-aOQQ\;B?0
U<@L#>46_/bZdHBRN2,QbMDL;2)DJ@&A(C97Fa-H)Z<:<F>]H;B\,E\V]0U(bZO#
&f5^?f2Y6c5?W&TQC5V.fO..c(UcQ]+T_5FO\J)H4aDg^+FGUYBgFNX]U<:I;)[L
X,54?=77AQ-#E&,..RE:e&\XP#L1dQR0R3+EUSWMgJ-EMV&W9DX=,efIE0ecZYU/
JdDC0f3f<<AKBVDbPVZYN#R1faVbKOZeSgcM:A&e,O47E4aP\A^G5QM3-V0TXRR4
f<576+XNWWE:I4=CQJ7<=bQW,</>MP.CcBKH(=GCK:QP)9<Nc>:gO;Ig7[fW+D1f
3#+?ZaW(OVRJdf5_6;J+EM&^@eNS)WYSN60d>9)cM:,I?S5[8;Vg(F0OUeZ#CJ(R
FR]A)T0SH22+5Z05bIF\[V,1E>_\(aU)=3aHUAc8H/231UEB^Ve^=@?54-KPa7bV
F+XL1J\;6R5^,F>R7>1XC]Pg56)eb]8TCe@XaL0G.\_dbVFO:B=If0I:a^9;dB]<
=KVFX1?>15L[YP/+53&1+^fHZZ+dO0L&5dT.88.Sg955<J49fK#MK4Uc/025Oe4U
TaHJ4f);UBCf0TC?[7V^4O3\V:4]Lc=PR<R#1LHJ<ABKQgbVNgM0f6(Z,3dHBdVS
<a&B3KS[3@2&gCX..PC&(R/TT>>OePTa;2KG-gNbe=Kaf27Mc]I0CE:J,V]g12gN
E]0-9EAT)8N<1fW=+5R.<5[A,KW0Fe1A^eOAJWdg?bNDLC\b0?PG=XEbAD9<JG9:
^?7I7;,/E3a7K>EgL3FCU]f70B.2[DbFGXKB3\D;C48O_A<\23Q5OKGU1BE2GZ2E
NTI30aS=e,<BN^N_/H4]-g7LE/cJ@,/ecIN,==RFCJa;:1X7Nb4=AV\BFADb5>&;
;;3R=T(CEO3[:)#06dE2&,JObNAW&E-\TEgM#U0)+P^JQa9+?gI&.Ic(#L#]^BM[
[2XDB./UCYKP+5O<=9O4,LL=(FG6B11=&gJ9P,I#Hg&7-cga_129LcWY]9P?J2N/
M,\=+N@QXO&I]84GO^KQ^@2G#8?;F6A0X[f]bfO78_496_dX98fVCC9SI=J:+Uf_
5_,5;XN@QgZHPI(YF4eOV(ZY[O=.4-,eS_Q?>X;+(X-,>P\Yd02RKOSa2&02aKA=
B:Vb+^Z]0\G\eL+;:T_#4&KTcR9Y=_I&P#HI(43N&ZKC6U]03>/(E6a^,?CL>8:U
),,gb(1]1g8ZO\KW]9H>GMV\0MeZGbU<@CfeYJcIX-;3[g[;1TSf4H(UCKT7FaB&
98E0A].XgP#9OK^U,K;[6?_:F-QZFG(1#-)UVb[)KEUA(g_\+RBc,9)CKM+5c0UY
N1,.-9SXIJ3STIFYLJ]\2D)&52;^RI,^Ma,+E0@f.9Y4NMH^)ea_d.>A2)#)1&]c
\AfDaG(@+=S8fPOF,S8[V]O.R4])S=Xe98C[7O>;U\Te1DU6W;L(#aA?M28V\3<@
LA[5Y\G?_0DPMYPBB34=89XGI-SDK(R(J[(-VKRDY=O,M2;NB6daJU)QV3Oa^#LX
FY&b37:D;05Y/59H(3?T3-MH(cXc7;ca))d,\3GdaSg-a55eR6aY:Rd2NME3;./:
G@LBJ)[YXQ:R/HRNR6R;H=G@.bZBc1a=b_H3P>BF-)O:LWTD?Z4\eDcbQ(a,N;0?
LLY/EYU?0T<,(]bd:=ZHfHfS,0a]81ZRB,9&aXSAeTKgIJBDGeS+f7-3..ICbB;7
]?(D3EIba+U[5F?&_R=I2Z3AWfb(e)=0SX=<_7a^?,H?;]0gFaF_GfT[Y_1@14:L
9Q9WLPB9Og7.6QB9.3)]M-6BVD];&)Y0QCQPOE7=V0?<CP+(]@M;_OT\_63+M__a
/==^32XN0[dZ[ga/1)/TPYL0Da6M]=a,+41+Z1-0g:OR]0<BQ/.L(6JSVNO2EL<#
fcJ;(bR^&X[^;IHY:ZU5\&E&&XX=.T#]eQ[8+KX1I11?T#A.LEPaHWN^;f]fHg&I
_)?FQ[_D\D7+REP3=V?eG-CK<(M5O?-FV2HM:MC8C9G+c)Y9-O)b\;a5;#V?U0eM
=DL#W6[0H#RSe0M07JW@+cJ5I^9#e]+ZVC75I-,AR4Bg(g#g7CYW^b751UPC,6V1
-e&3&Y7eCFHWEC1gL[^1GeVDH8cPN6GDL0a#JS_6:EFD?LM5]:?7ZBIMGO(UI^+c
CL:X&(YGWV]@^?R&HHbLDWB6.I?4fYHYL=KI#:NVYdYOe_/aAA2daB<>5;QK+bOF
CYOO9#ED_gW5-9F2d&d.c=>SC03f97]()[Z<88WP.+OFV;2<\QNO1[BN3_,@J/C8
Y8OJP9OCO3P</@\,5:C9W.^^XYZJ/4];9Z@ZH\1Lf8<NR:I[CaF21Bcc@AK[TIa:
VAfd-.7=g]&H34&C^b-a-M,g,QKT,M4-39&U=e6aff27/GSYYgaNLb16Nd[^&YUE
]P[A3I65HJd8@?(W&3/+5g86K2/@LT6@I),[/D#DaD7_)OU\#c97gBc)f\N4+O/U
KAQP:R4,#+>cB>\EaVJ>/A#BWC5ZUL\EE1K-,OgfE@,/CI=S=8&S/(5,K)c&BK2e
;630C/Ma)=,X\+NQ2aSD94gF&b9UPM?O6,5a>@K85^b.5;1>a;Z.20;?[RfS&PW#
I7MY\Z2E#4FL@9BL66G/R<RW?6gD_U0ffgO)_IUH8K.Z^c7,X+9c^=[=#,_T0JV.
2>Y@aN/NT/TE5+fOV>9UY;869#CV[#a)g(8.Z]RM4V_JEIVZe9RQUQZ7GZUC94Ag
/DGTFSCDT]V./V3c-9DR=T\/Y?B6<KdXQ_B:>8/.BKFSNXE6VdffXA=8G3C>W856
g&OTeI,6U1e853)1;K:XUb84)g)S>Y]4>.VYEC/f\O(-V0XCA;1NX/@aT[YZf-XZ
=,152cg1[gd;Q35/^BG>NZ^]Q)7M@E&L&UHS;UdegS?CX]:)&?V_Q[DD/-.\A,0;
Z:5:eIJ+W/0H=,1OfNQd6#HF=[5TR.:Mea[F\P,:KJ+H7WL?CY59^>1Z#?++&FW9
-)4eGLaC)TWC=7:\/U@=T1PWU6dST1#8.@P<(&[Z.Xa=<FY330\W(4/),K4OR[G1
bT5:dTBMB=4GS.:X=SZ:0;eW/=TYbZe,D5e8G6U7aP@Y9=^gZ[:Jc&TSaRLc6E_+
HHWcgS:.b-I\^FK2LOA_/?,G4WW581)04_1dJdY4;,GTW^FUHPeJSNaUN7<c4g]8
Pe[dG._JcKIfOfROafgH=d>SWQ6K5Y9gHAeIeU.N+\Gaa\cR5+7F>020L8_3?9aH
S#1,1)V,R^FbSUC4Heagf+OK29_QW@DVR^UOe\AaV>&HN?6Mb7J9PbT5cT6f]=?[
V\5@L@)/1c\29<T]3Ec?5R&):CN0@d;.Mc>;S0N>/G#38gLS(EO/((0A]9U=25g3
39TVC_&6+VOI:9W3a/J:A,>&:UIE[#-O1DdD7[H67X.e_HII/(440/N4.9?.I8Q5
T](g@MPM+>OGB3DM9G3DPd+(@O]C,_QUeI51OURU58e?[cW]XU?\+\]NSD9_IDP)
gP8-&;+=\.gU1,\7-@[_d\S\<gZ/Y4+e=DR7-=6EDY4ZT)Wc&361(O;IbG7DY+)5
7.ORc[bI(IFE;UAH/_9]@9GB1Z9ND\g0BK_,0OfBdgE=W_FI;^,.1UFcW9;:9<cN
@VPBeE61IOXNdA89f<0Y85b)\_7FX23SD:N\)@J>X3gM,_YGQMHMKaZR?Ib[5R]4
J+.3fBIdb7<<)T[a\Vf^Q^D[gBW5fKL&]./DOM>TM.+7QZ_G30L^bdBU\K^da<;f
Le/ff=IgKV+U+[R]WI,@ZD\GLRQ&[ec3YY[<Wf<E26f3B0b])2aDDK7B&=AKBQN5
4TZL?0U861UU_=:TLLQ?E?G3URVeOa,L<0cZ/a5QQ:0,03(6-)9f/S+2:ZLO3/R[
F7a<:9HFPB<M,TaL?)K-:-\aDb^FS#I@DQ=]g_QQN--&D[BJ<EbZL;DWc7[UJ2^b
a?(.bX[KCe+G8U04dV.E^NFZF/Z./0Od0aUMc1Z&Q,C./R9G4IK#-..e<&]7P=H+
.DT_@L,C\A)fY-b]60Z0.QTf:9CWDR<3^FGA3;X:7J&.aO?80MKa,MVX8Ja]C\Y]
23/:aV)bA;af=U:+HI.CaQQc+=0BUKDU=7a7W#2=AYYUL)cUbLBX]YYaQccEQT+F
+DBI&OfVdX6XX>8;=&C1[KJ?AdJ/5_L2c7R,:R?<MQU2GCfBOF&]1I2)M;[eR)BL
9\;+@4F+f2f)RMMZ9?A2535YID,CPC3@7#2LM8[UAGg@4H0>+c)c8KO\DKB5.1[f
a&Zb@>38f@Z(L-Tdb+dcMW+LaIe(_R\5T&,SDBVfOJG6^DH9S^d4Z5;e4V#DD:.8
ZN,e:56::Q@F\_U_^_;Zf+bg7DKLFD0G^_.K]11Fa_>>=?T+6]O4E;\dX@a[e;)2
Jf((?X.]2C6:G:&;:f>QFH>3MW]4,6Y]LFaT^]BV03Te:UXCCQXWTc5BdI.:;bKQ
U?NWJceIXPWg;YQG2S0\6H9;)[C@;d_L_[C0)R5Y43\]2b9K=Vc6>>3?cc<eM>0g
[b7D\2541Q2JB6cSGIVI3EO\f(C@LV@.#U16#]Eb0\]UTX_^8I]J4/+IB#W^gc(>
RL.VDML<HW\1fOC^dHI^-^eH;<(/NLY.C-\8#d9#G]bMMG&Hg>I)C1W]Ag8;\=f3
&:3B2YCJce^S8C:WbNL)(DK#]:e&DM)=6bb3^)<g61@6WYWB)=Z:J)E/QeKZL15L
7I.a5QbK]9_\0)=A2Q\+@:O=PZ5<2ZI9G9UYI5[g5.=;9NIa7N,K,1P/>54\3f_F
Z;O@4eDfVO-::S6\BV^1WI=^EJF1Y[<A6A3<LCe2=L7=C7NKG<@0ZC[P[KF68IRg
+-=d0Gf)+<O1=fNU_cE2P[gI8(bD.DTU[-XI8ZB0e+bWMF5L,[NM1a<DUBe^7-P0
dE&@PMUQGF+QJEDT6PP-.0#g]<9A9PdCM3):PG3I<-X&P&IAV2(?G02E#3);,:8e
YC.8,3f]@E#Yg5Y[5);0fYE1]cF(OccJP/2a9aF0&4PIfOYHHf5Z\PY4VINfSE>@
G_93XVg[_eES5E?J,e-VU8_WH6L>eS@;QN6[JIC-[OVS88M<NP6(WQDXQZg_eR(/
;]I_BAS_4HLg/XMP-9cC]Y&#97gA_7+14YI&CV/V14>Y:G3P1N[H1#d&EV49be1H
M_PaRXYP:I,a<LgOI0gLXbS@H[-TbK7\dI^UXQ\ef5_g/1IKc8D=Z0[eM=d0#+>[
IP>6/B;##g:;L&?]JQ(2CCJ;MX=;TX@K]I2;+d^SGF#JDZC[P-=22[R&=&I&\BJ.
/IadKJR=,?f=ZPYgFNDfXX1[f)D#G_NN7@g[P?]NWZG18Y97]B+KC?-J>SSTPNEJ
YN^.YGSb1HY);4XIO3SG9H(((B[EP-6EPX0;WNGebBF;c?.,1O+?J6G)(,?X.U@I
NB(>]UHd5_0-C&DQN)\aHQ@U_C^<;-V:^R7f=),B0,;\G2K[0<GM]NVeNb^.<>1>
_;=3YCfW/W#Dc.K?,aUG;T-6-83SVH]?0#g@<>fVSKW+8Y0gD-KLB\#Sd+>GWcDE
#(1<cK4cVW\aeSJX96KRSQA&@PVY1Q-JZ.EWJ.7=N+=3#D1LTD/Zg:K8HKa^eGLB
XE0H2#fQ8GY_WJ(.C;(UKV_cH(?/S+28YTS?c.RN##7g&N?5[Vd?2VHdJ\UPb5G8
4eNJbW97V_c6&c5_+B,d@<T\A0#YP[Sb+Hd(<aW.59=S):Z9E6bU\S>U_4.Q7DIg
I<)N=beKb/,53IFDPI/#J](1_HBQ>W&AQ]OP?JV4Y0)5/;fBDYFaSP[HX]S[9DNB
FCF,4N?.)U1-;W6E(Q2d-&2Z8fR1aZaI3S+;S23MgO?5NaXeHC?LbA],E(&:IA]f
SD3@L/=DMdNT7RINeU(GICHHgEAb.T>V8Y+Ud.g@bZ-8a0c]BK_WK@87>Ka5[_,=
=]<P<;A+GT@;)^JRP,<>L>FaI_M]@d-R)(?[gdZ>D:3]P=R2HDJ?S4[2<Wc#YcPU
[+X&BM]^f#UE27X;LJNeEfA1>@:#3J_bZW<N;/,X.P]S=(PY)?U=d\95b6-43S.\
Q2FGH90cS&?Ca\_X.PS9KH[g,EIb>KWS,;W&O@<7fSF8ddbTH5<CK#bO=c]3aX;f
G0N.bK=(#:^]e\N10]U26fH20+<:3Y<@;WHJfKMA<,CgeF-?Y.Y.NC;-L@Y?#A#)
JV^PLZ9R8C<5,&D]I,?Q59C3OB=:H5R/LCFFR;R[-^.=.00=O?-5&6X/>\&HB-=R
_4?#56eJUXT8Nb,7:J#VUZ^/1YLHB)+U>)?K_H[9&b1Sg>),7NXM\BE)=\4abGEY
R<cL^0=X(#]^d7EFGW3KXgB^b+=V3(9ZRXQgc35HM(CMd8?72a2)H/a>C^:]b_G+
DNd3QT,88)]C^B^T2S<2(dJ8+P(g;AY[:f<O9K7I+6\=]7JS5.O#/;14^UZ_aJDK
&_:7dgG;_,V;N0bN)SGEJ:]-O@?Q/T)=fd7<cF3K,FM50Ec^a-US:^=--WR@6((K
XAFE,51/e+CZFTH]fU;;PER->2C-Ya=E<d@;W:>0?:-/=;=>.d(K:=-ARW]cJNG>
J.#0<1Y(Bf6#4RaaNS5Y]T[#5:(FagQ/GB#U](0?LN)FD?b1NBJ4.7EYY<&YSN+d
+=b8IY#?@)?7Y;?HMSOPd9>>0^:\(S+LNCQ7//1(K#TfB=T6g]>[NV&F@d)61>=I
dCC<^QG7R3J3/&V7.B#\<.AMA,2\NaOWHfVcRA6CbFIH\X[b]<DYXHW+LBO<G;ND
V<X\3<;3C7@ZR.@#[ge)D;:+O=b3CZ4;d0Kf>)D8+N]W:+4T(PN;).:fUD4=7b]J
PB)3B/c9#d<FO9bWK.]3cUcM;2^CB?-cA]F^\(=S)O<X.DRgWO]P0g6.5C/X=eg.
EJ^W(&Xc=?1[>0,W[07YXC/CgV0H1SQ(=5a,d[cX8X^d9-X^Ka12<DP9&aF49FLS
B^:0U+C#_=OK/:.]@@?CZH4-f2]8828O/g.4eWXTBAGVN2[>b\2ZgedZN46PPABE
Kb6@3RN:4&;)4VZQD<F>)++SXWFRNg?Q18W::d08M3OX-M-.C8GFc[N\H9]b(fN6
1S?fKZMPV34+EbWF<]RV,OV/71_N]>##4,:3J?>#b_V8=1B1G2G7^=0T-YMN,KYS
<T)C5425[[W-ZSH08[6_aUM^I]Og^:>HJCB8KWZ7WYeeE(@Q-Z3KMU#4KE#MJ6>K
3P>;_ESH8NYI;RX1HFPIYDV3/\OYd::?8S],cI9c:.FCMW2U3Gf=SI@Y4Vd>B8]S
S>a#U=>[Z3N1I@7EOcWT2+TQd((G(7c#=BdIWW?:LA79f<M\J=@c,d].XG&fI+TT
P^RfR0CONa;9ZM2_YbX+@V/#OQF5G9X?2:CbcbcQ9/X<K\5&9.aD(Z,0_3\SD,^-
QW2:0BRS@H#(d4+YV^W/D;<S<gM>^b]W?6F3>g+.IZb)e&5b-.JgCSSKZ,6S[8_9
L:L[#:ZD=24>+2IDV>.BCD&/TE^5]3)P^dH1;T,&OI6K@CIa9F-SaP(?.g>._GD8
b]R_4O9be_JePG_LS9.30PM)dSd@VJMY\F/AD-G&XDb4#F0@2K6DD<^>79>P.(;4
G;44>/9ZBBJ.FL+7_A-MLN0L2@.ZJc#Rd1Re2-Y92;4U\^?Y54AZ@<NMf4aGWHU:
^_UF_54g7a4a9,:CZH67DTU[g(ZPU\GFGaYE&OZ/@2a>g<g\WP]AN1PR]2=Bb/\O
B;K2WEYSN05be[;18B#8\DaedPOP7Ge@Sb33V\XM-]\7B7H\g/IGe<D.-U?=IU,5
KOd5FZ@)E.K+HD\0V?T/\F^>b\T:22PFT@34]Lc)DdBBJCCC/c,4-_-5/Ie2N8I9
099U4V]1gM2g-M\000d<+-<AD7&8=b[M7?c],7cON&b)7W?Gac<YMZIcZEAS+V3O
C()21JWDIg^]3K1&P^^R0VK0KKddd)aHOL/X(B5)D(B<SXc-.\,Me&_(^):=:<WC
B(:=Lgf7\U9>UF0J#C#:6ZM(U@I<]Qb+a&6Z-:UX/M_?caMQdZ]GZ<R&Uc34#JSd
MG7N[1PEc-KTCfE5ML)?f-Q.#F:(f<TJ26a^ZO9NFa2UYKW?VA+BNP1=2+BB:e6B
^_9d6G,=8+Lc0;#ITUS,Q3;:9a<(\c1:-ZII/W[+0E3-\Lb\0bg-GW9M/6<D.X]G
YC&^#LEeSN&DADB<OO[U0bd.^>FN+2-JQU#GIM6(MSN2AW?XLBb;+6)T4Y)b_H#Z
J\V7FYFE[a4QXC1@2._X^PSSQA+5KbP0B^SCA?5GP9<QaJ]>.f>DX:7FPQ\0X7R]
\/D&7U/RT5\aMg3/\9/X534RP1QVg)\3J@HM5;<GY=WFK4+/^)AE,44H)U4-]b;)
c\>SICQQXeFCeZBe&?VPJSJ#7^Ke+PV6/AZT-L7;c,#Fa?HdL>/e=SYcecT_gJNT
<NCg\0Lg@27-]VAWE03HD<X.QdW^#<SX0]OV.J>V?(\ZN(BdO(cd1DCV8[ZE>V@S
Cc_D]g=((;70CT,KT9-aa1BH+B/B7NZ^LT0(V<)<e0Bc-Bgg01OV7GbXbG5\K&_c
9JBNJGGF8c+2-NA)RdD@bT4]?-KEb\3#YBZ7(VL+Z^/F_O\;AFac0XZ7/><Tb5X7
HCVAc2-=XIg9[a<][Q>)b=AWY_>Z32Y8@ZN(SL?.L-PB^Sb)U=0(=N#<\FCB:6:-
b[5-1b-d<I>JUNWg?BLd-_(CR4UdS<\^40M3eTP8MeIMdD,6UW79P:IQeL4eOaM)
&K&2_e973#.H&M=eHN]IYVI#8&Z0DC7(f+c@:<NJ^0<b+UCL&B.I9=O&+6eT/?SP
@2SA?2BRI\2ed1eBX;PVFCM)(41\1EL0FNM_C;C7Y,DcJ2?M(g^8T#E3N/PC)d=C
FTbT<I[1]:JbEZZ=8OY3B,LOM@_.BKC34_[<ZC@2P_UV1R.efc6V7efa7KU&W7c]
_#1MR;)ZSPfQUe@eX:d2J/HU8Ia^7S<&0G)I0PUBHVKTHaE3,XVO6)O-W+4##5dW
]O1I8;/&W?6/3]A3HAPbgT6,aJZQA-&NCeU;g;8X@3C0E38:5>\>KXQPX;^)<#Ee
VO/,8&Od5G5I_)DegWCM0@[:]);]8dcKHOV2\O&W>E#^A3;2(7]+64MUK,aW(3B&
eHP_,/P<LW[ggJgGYJP5#Ub,+&=8<,OWJ,RYYJ1f(7-KFH.CfMG)?D8Q]E;4[7;B
7+9.[0#92c1XROR:NJ4Y.,JG(VZ+0]N,2;8Yc/S)2CI8.[UW.BELZ98gU&K)_N^.
eQ)S8WLee,Z_502>g=II]QAC)C@/dVNL06EOf59I[@GXKJW>HIg0TNaAfQK#\<I]
JKT.+Sa3-(U3+2+ERVYOB9.B]g(>F31UgX7B0,F@,gKe40OQ\RIJ&[2DgFJ/F:&U
dK.9.1aWM/Z;_S&4ZR@AMe?;IHH2ZPLc9;@C?8ZfR/aC423;XD,7+&1bBe(#aY1_
WTQ/>;_d0C-GU#LZ;(dWKa5?DZ#Jg9G?U<D]N:.S>-\FgX_/<WAa-BCC<aH\CePe
&KZ.@b0XcYV^33W;U-@,Y<A)3>.+Z7FZRCT\RZY4QHJgfI[530(3T[YB9@SG3@R/
6B:[I:HNL.RO(.TWN2S(,ab\69eFe-L3a[:\g#R5F11E7B>6TRQ3XL+A/cSO_3c+
)e\(>Lfe)CGIP((?BFSG9PU-AP>gKW(ON=dfR1P4K)]L>,P[S-ZZSbJE\#>V^OO<
)(=a5:_;GZY;[E>7aAUWTW6gC=43ZQeVMc2>PR/1.=Bb,:aaWJgK^J\<I;E5:,WE
0UQ>J)FW8b+GQ7EgVfT#=KP23Y^BB)+_?SB,@8.8>D^>d=Kb2gW@EDb^4-J00Q#7
DV<Z.2KfP;+#BM>I^8P\:bE<0)RP6<@_7X];PB.c2eX48S^WAI0EgV@SY^+4gH:\
^S_E>EKf]NBPL1Ga+b4L#[27g[@27LdPd<>GbV0)_/#c.f29YZQR.:S5BaJG2@F0
=&>7R7YB:?@d4&-8DA_5P8H^B(cbJ#\TASZ^JB@;:KGUC4JZ,V0++(A:LAZL]PIB
\JS=M(3TZ+#V_=+GCZQ+;S&K/\CS;F,UF-^CO4IIGU#:8bUFYDQ]W5bA@U5#Y,;V
KW6?gL41VI/F57<Ye>0B@75+CbYB60(G@=fgK32SA]2^\-;>Nb([D&>Gg.fPI;dC
L8U6&2UFOd)1SLg_=Ia1>9L5@,FD/&4-(BL]RB)](.5\:@VAC-#>Y4YL0YbC23,)
Yg-1WJKa\^.]FXL<O)46IK<dF5a);2#C2e?2/#e9TF=b2CfI##SVNOb,XHK6LI.5
I)_<>IY;<E>\>T3/R?OS#R4UAHaGFBHdR#ID#1F5H#\@5L.M.XNKVE;cMTaL71EV
WB8B0PKQA/EQEf^B#^#RecBJEA8\9#fB^b[&dK@KB7,>a++KA8)1=&HbMR>;&/D6
A\IGgYg5IAS7:,a5M/e2HC_=Y?KT<D=XJF,YDZMRU,:PK^2SL+ef2E.6,E?]cdaa
8\QJ4Tg/a\N&HZTHLNMf]X5cVA3F9,Q:=Fb-eAEA=1.<-?e52)gM-/b7Wed#S[A.
.4UKE=&M+f]6N=..MM4(f&HU1:A3HRSQZ)6Ig&&e2+T\O^B:\?Eg6Q30V41XY4O(
S7B<X7DP[@a0bgT,4:]a@DW&=]B2N,3I:T6/#=D2fB4^Sa,OgX>>[?Y4@X+G7E,Y
dI<^ePX:a87EB[+Y0@Ra+&JB<=N7K-c0^KV<;V1BT7TfAV0eVf?d&S9L1c-+bdN\
/XR(55,^\B3BBfIC]fY&FF>T?(\QAX@Z3Z_M21/ZEW:80\^M28W[3FQ)0RH^eKYD
KaD>b/=B3JE4EdFURYG#\>1>7e1;[E@d?bG:2@;Cde@LPfceUVA,JYPF28;Q9VGQ
D?00fSg6^e7:S&[XeBFNLU1>3$
`endprotected


`endif // GUARD_SVT_AXI_PORT_PERF_STATUS_SV
