
`ifndef GUARD_SVT_AHB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_AHB_SLAVE_TRANSACTION_SV

/**
 *  The slave transaction class extends from the AHB transaction base class
 *  svt_ahb_transaction. The slave transaction class contains  slave specific
 *  members and constraints for members relevant to slave.
 *  svt_ahb_slave_transaction is used for below purposes:
 *  - Specifying slave response to the slave driver
 *  - Slave provides object of type svt_ahb_slave_transaction from its analysis
 *  port at the end of transaction
 *  - Slave provides object of type svt_ahb_slave_transaction as an argument to
 *  all the slave callback methods
 *  .
 */
class svt_ahb_slave_transaction extends svt_ahb_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_slave_transaction)
  `vmm_class_factory(svt_ahb_slave_transaction)
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The port configuration corresponding to this transaction
   */
  svt_ahb_slave_configuration cfg;
  
 /**
  * Local String variable to store the transaction object type for Protocol Analyzer
  */ 
  local string object_typ;

 /**
  * Local integer variable to store the current beat number which is 
  * used to created unique id required for Protocol Analyzer
  */ 

  local int beat_count_num = -1 ;

 /**
  * Local String variable store transaction uid which is associated to beat transactions,
  * required forfor Protocol Analyzer
  */ 
  local string parent_uid = "";

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** 
   * Number of wait cycles that the slave inserted. <b> 
   * This member needs to be programmed while providing slave response to the slave driver.
   */
  rand int num_wait_cycles = 0;

  /**
   * Number of cycles before the slave asserts HSPILT signal.<b>
   * When 0, HSPLIT is asserted on the clokc edge following the first split response and 
   * is deasserted on the clock edge after the second split response<b>
   * When > 0, delays the split assertion by sepcified number of clocks after the first split response cycle.
   * Default : 0 <b>
   */ 
  rand int num_split_cycles = 0;  

  /**
   * The data_huser used to return information from the slave during READ
   * transactions. This member needs to be programmed while providing slave
   * response to the slave driver.
   */
  rand bit [`SVT_AHB_MAX_DATA_USER_WIDTH - 1:0] beat_data_huser;
  
  //----------------------------------------------------------------------------
  /** Non-randomizable variables */
  // ---------------------------------------------------------------------------
  /**
   * This member indicates which bus master is performing the current transaction.
   */
  bit [`SVT_AHB_HMASTER_PORT_WIDTH-1:0] hmaster;

  /**
  * This member indicates that the testbench would like to suspend response
  * for a READ/WRITE transaction until this bit is reset.  
  * The transaction's response/data will not be sent until this bit is reset. 
  * Once the data is available, the testbench can populate response fields 
  * and reset this bit, upon which the slave driver will send the 
  * response/data of this transaction.
  *
  * Applicable for ACTIVE SLAVE only.
  */
  bit suspend_response = 0;

  /**
   * This member indicates which HSEL index is selected for specific slave during the 
   * transactions.This member is populated by VIP in the object provided by slave 
   * at the end of the transaction, in active & passive mode. 
   */
   bit hsel[];
   
  /**
   * This variable is used to program the data to be read by the master, from the slave during READ
   * transactions. This member needs to be programmed in slave sequence for
   * each beat while providing slave response to the slave driver.
   * The usage of this variable is not supported in callbacks.
   */
  rand bit [`SVT_AHB_MAX_DATA_WIDTH - 1:0] beat_data;

  /** @cond PRIVATE */ 
  /**
   * Indicates that the data read from svt_mem contains X.
   */
  bit read_data_contains_x;
  /** @endcond */

//vcs_vip_protect
`protected
BLAe(0ba,9bc-^232U[FN2;NVfZc_/R#dZcP5T/b:4e(W+/1YK2N-(Z(CbFZ1@P.
&P)@F8;FZJe4R>E<c[QA\Xe]9dKbP35P^L(>RdZ0V:&.R\N#d9.Q?2E3__Q(ZDDI
)fDIaFT)KET7QKR>P#,XH_.<RJ_,(D5aedOaSC;KSM4G-S2C/_N/DZ[L5NVed-B4
7ILcT<Df9RH1Rb6&(:+TUf-TN,Ja:WV@V@.1M[+E/KH4__5(cO[9<Mb4\5?CeLef
.d(FJ5T-S]TI,Va+G1eBQY(+<SaWF-[7UB/P;/RG&]D-59>B+Zc\A52U/?JN0&^/
Q8gGY\7426WE<OWbSPR#dW):ZG:56805W9@Z6<<=DgTJU?0c,[9d:\P0T\^K6e@:
J7]3>9#52U6?5c,,-L1XM,=Q[=g2-WT=[+B[TMGTIGC>XcHLKS5L,0(#D7FWX8^B
S@J&>H\@2gN2M+d<?OML=28fcX7-R8979WI?6LNQB1VU1-9EC3=G>O:>b@(.NTXO
W1;<U]G8b=6S[bPXOPB^S]KH,Rf11,;b.7+]H.085H;P),[L6<;?T,0VZ7?Z,14I
&0D##8IJYM(T-HA,VVQN8<XcG(^D6F5P7G43XeBdU)B&YgJD(L,dZW/LZMLPD&<>
2883fJ.HP,6N62eK4QG-1BJXW7+-L-M-3WdYQ/7Y-:SB&,&LSF2=6E_d5D4cf162
#CMINgbN-AK5gMZYLGYd5I\:Td(1SGE9XcC1GJ2b7A:dHL^(_HX,3D+EJU;FB2_1
.OEHTa<0cN>E#Z>dMb?=>gg:c=fX0V1>Q:@LQ4V47U>b/Z:cXce>O3F;T19AP0]\
/=.+KOAdN89;ML5]F4\c5:@CH/0&RF&L+e95+7?dJC(N),HA4^9@BGJ\LV:HU@\7
=:F\S:6=VR^&4\;:1/0_>H(-ZgTK&NcG-ITf:A?^.80T^3G&[L()]9VA9_[\B3TJ
(=F@NC,fHKSEX<IT[bdeW&RJF3#D040K?OPWYS_<Rb.]I1ROGX+cOfP34Q>Y>U:_
,,()2_GVWR^b1-4(3Jf@51V=2bJ./[.<dOVEC=P,4^:[(gS1@:VZ@_1EC[7H;X04
g6bEIA?OV(bJgO]f@\5>PF28bLK7I50SJQBHP<?XT2_FdEIQc]1+DK]J81C9_;UY
&W.9O3Y09.f/+78V:IQQb^HT#07C&(<^03ZQTL6K@NB85TZ(59Z]Ta]JJ$
`endprotected
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_slave_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_slave_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_ahb_slave_transaction)
    `svt_field_int        (beat_data        ,     `SVT_ALL_ON | `SVT_HEX)
    `svt_field_int        (beat_data_huser  ,     `SVT_ALL_ON | `SVT_HEX)
    `svt_field_int        (hmaster          ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (num_split_cycles ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (num_wait_cycles  ,     `SVT_ALL_ON | `SVT_DEC)
    `svt_field_int        (suspend_response ,     `SVT_ALL_ON | `SVT_BIN)
    `svt_field_int        (read_data_contains_x,  `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (hsel       ,  `SVT_ALL_ON | `SVT_HEX | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_ahb_slave_transaction)

 //----------------------------------------------------------------------------
 /**
  * Check the configuration, and if the configuration isn't valid then
  * attempt to obtain it from the sequencer before attempting to randomize the 
  * transaction.
  */
 extern function void pre_randomize ();  
  
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_class_name ();

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. 
   
   * @param silent If 1, no messages are issued by this method. If 0, error
   * messages are issued by this method.  
   * @param kind Supported kind values are `SVT_DATA_TYPE::RELEVANT and
   * `SVT_TRANSACTION_TYPE::COMPLETE. If kind is set to
   * `SVT_DATA_TYPE::RELEVANT, this method performs validity checks only on
   * relevant fields. Typically, these fields represent the physical attributes
   * of the protocol. If kind is set to `SVT_TRANSACTION_TYPE::COMPLETE, this
   * method performs validity checks on all fields of the class. 
   */
  extern virtual function bit do_is_valid ( bit silent = 1, int kind = -1 );

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object rhs), `SVT_XVM(comparer) comparer);
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
   * Allocates a new object of type svt_ahb_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * svt_data::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size ( int kind = -1 );
 
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
  extern virtual function int unsigned do_byte_pack ( ref logic [7:0] bytes[],
                                                      input int unsigned offset = 0,
                                                      input int kind = -1 );
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
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[],
                                                        input int unsigned    offset = 0,
                                                        input int             len    = -1,
                                                        input int             kind   = -1 );
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val ( string           prop_name, 
                                             ref bit [1023:0] prop_val, 
                                             input int        array_ix, 
                                             ref              `SVT_DATA_TYPE data_obj);
  
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
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
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
 extern virtual function svt_pattern allocate_xml_pattern();

  // -------------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
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
 extern virtual function svt_pa_object_data get_pa_obj_data(string uid="", string typ="", string parent_uid="", string channel="");

 //------------------------------------------------------------------------------------
 /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
 extern virtual function string get_uid();

 //------------------------------------------------------------------------------------
 /** This method is used in setting the correct object_type for the object
  * to be written in PA to get  a unique uid for each object that is getting
  * written through PA writer class 
  */
    extern virtual function void  set_pa_data ( int beat_count, bit transaction, string parent_uid );
    
//------------------------------------------------------------------------------------
 /** This method is used to clear the the object_type set in set_pa_data()
  * method to avoid any overriding of the object_type of bus activity and
  * transaction types
  */
   extern virtual function void clear_pa_data();

endclass: svt_ahb_slave_transaction

`protected
1U\:);/XbcOD-@2L(:=<+C6c&R)#0HWRaGP0]9(WR>XRX&FAJB=37)dP;V6eH&P3
cb/QSFEV<ID)N7ZTafJ\;@d>UZKR.JC:T^RN69&5.-9.@U9[+9aS186JC-F_eg&O
@X,..1)fFTL7If2RNWS]>C0:4\+-\WHY.Le<O3C_ESD]6/EgWW@6DK476;@E,@e/
TWU80Ff-//DYB\Y)KX@c@5dL;Q=@9?bZ=6;(f@,+@X#F/>8e9TeL(2IOYM.edgCC
GdKGD3e9N:a&D&O?cKW9]D582/bDeFNSWRZX@>X89?RG)=Q51eDXN;2ATRTFTQO_
D,V47V)=K>0?[[=VJCY,_.?4Z<5H2eKb<F1057eKC\N5CZA0+2DO\eg;8D,(F<CR
&)6VeV-R<a9WCU^N&)UY\])?AYgXAG^FL^R,+ffCF_VgaH]ENP)T,RMd2>E&S5?;
fL/8C6HaG))P=S-GQ)SN\[>8-ScUB3-Jgc)?V_Dc3.eM8bK;DAI&<(F^ccG9Og6D
,LPOa=2V6J(@NNE83B6=J1>b63_JQ_J5)GAG@RWb/LHWI^OeebN#\=F^K$
`endprotected

function void svt_ahb_slave_transaction::pre_randomize();
`protected
)+/EE=>3Y)gJRMIJ(<_H8P-=eP[b//f]\VT+FSURa]Ica>MYKHAB3)HC&e[9@DC>
RdcIcD-/:A@C=3,..bD^VZbD[_;C&8>X^,a2/@R>XAUKR>HI7P@+QK[7Z_V#?^]c
U_-P4G3:/gHOZ]dI4VVa,,K#cQeXV5K0;La1dUXW7)<PN;WK:O-?&IU=Zge4-V_)
DA=EZcDaR+>P2RO]9<F0\7K#3$
`endprotected

endfunction: pre_randomize
//vcs_vip_protect
`protected
NQ-9@EBG973ZgHKFW2@0W-?MAW8HKQSg6,NZ7=&4)S8Q9g/##RDW.(@[T0J3e7NI
OD=6-RDEZ7e7Q1,U@+64Q?@W(e6P>3K-bKPQ:dDFc?45aUUW6Q._2G1+J^<a2=Ug
H57KE2d7P8DLC7g[D>R]e,B?[U;Ba[N]gGdAJ8\^C#5_.UODIGG#Hf0)<J7YT>>b
#DdOW+R<-6USc@)CS1769Ac<I.I@)WJ,L\I\=UZE<+YcW]O-D\XCUG]X;2C0GXH9
<IBQ^OIcG.:H:Z1e&]1.BEbW6:N@C2MA+Ba9>e.aZ(3X)D/2MgG#-=?6ENb>[E0e
-\/O98,2,Zb0=7>QcfQ-Y)(N?XB9W6#3@MOB,2V]6QA@>3-35N<\;4)CRT8Z0A(<
WCcdFS\B1fRZ]2B68)A\@g<\Pa@K?H_BUZ^^3=eUX@WAY]M3F+[/GMHB7D_Y_O-U
4c?;T(DCE9]X>^DR[7/YL\d)7:NX&<Gc,8?a5;\B4ELR\FU+QdAgBX3;JaY5D^_E
PO>KdML2?aeZ>7\ba&5W.62#T/2SSQ1G.J-0FF(0]^O^-.IdSRC\H@OSEHN(K&NU
KF-<=\Ic<cK<&LC\#W3ANY\QKF\[#LeDR<J=Bga^\SR.]D(H1XU4+8D=EGN>\B;-
g][\9T-2:Q8eM9VE)AQ\ReKE&WR\PO4g_M[[QA[B7<>P1ReQV)O]-6#..DHK(La4
M,(Td6V,FJ@.K,T>MPO<HW3c/?3ZS7S,O0G(a:6?1UWKMG@U;3A]B5;I3V&CGJY1
Y[Zb1=?BGN9BF_Ua5aa/@[H:Pa1]>Hab<B:LFJZ7<1OZ<Qae?H>DRdPW#PfP.K>-
K0&c=SOQL42E4d2B&-4-8AHI0)FRX2\Ab)1S,IIK9Z0NJD\-eW(6Z\D3Z(K(4CfJ
_WdTC(gE6MIG4(0<G)Y>U?1Ig7c)2])BAD[;_.[,W-?5[BQ_Dd1bE<L8<TA5)g4T
YCC,0Q\V(U,NF^3W7O4c+Q1J)+6HJWUaLT;IZ,][77=;Q?TDJ,BC64G?:b=_N@F2
@XAE]aFZS[\^DJL).(=2D:^TOTA4LL]g1.1+742BQ1&J:Zf&:bC7R5;LJOXI(bC+
QBYTSSN)c1(/-T:]_=3UMVZKL4OB-,Z=X6NR,J=-J-gTM-DW.;WL<?,(PBH32^Kd
B_gM1@&@I<YWD#A58IRcLJ[gD3<fd:<aa[2[F#K0f5:@3U]CBS:(BAYL8d9P^PZ.
b#U-Ua(FO\0Cc41_CO\?J@ZQ4&NIEEHW\K6(BQ5d>dNf73@B;Ha=3F:W4P]^&;Ae
KF>7/KV7F1B_&FRJceV2KafS,+2g&05Bc^>F=-E#0YF<84XOa4KLJBAb=1DQJN8#
fH5T,#b6[,SOWO,?H,.+aN]D:930]O5WKQfeb7-.?.=ffQ&Q#S\Ze^?C4)CdH89E
/S,L;9a;S7Y0b_5a;XB,:YZ88EJe_Z;6TG+Z_a?E;ITK3U5@9V6E16F?.HY;19Q(
c(A8I&URR]=dH(QN3GP,C)(5B[2:SeP1BYGL(,&I5XV^\fFNGNSc.J7^8&\]PaK4
)JR8ET^7f)S8C&M>97He1@PFe@17-.5)GBQLM,IPP]-a:CX[d\2/_DbO\A+cH.32
W2Hf,]AUX3FVI)/?f>SA2#H@54P#37?QbX[11[Ic62e@M+2#W:&?TU/0M,BH4FA8
b2U:5A+,B97.f/TFWHb)3J;)/\[f4XJT[c082\0:=.+RU@/8Z5HQga51C3#/ZbTN
\]\5D/,>:BD7dY[KM>a_^W4ef;.e,>J[U/#(_=FBH(#YOHOKNd:7,G=:4Q#2/1(6
A.L-@(A@CXcRGHLMFX^]8L#=5EM?f8X-DTLR32KEIF,9[H@:VcK[6\#\_6<C<O8_
&#a1.+FOc+[M8OBX:9MQMH7S49TG_S1V/D)E,K8aU\RF6K6IW+Z+aDa6<94P-IW7
U_SSK738Y8[<^FQ3cfHQBeI6^Sed5c6D7_D+0&[Q4M9-e1JX]&f[5MZ6SO?0MWMC
L=^;45)\f^^^:<7;YI,3.NA\#<6J)Z,IgaV-.#YMgc[.@9B(QY6;RaK9T7]I_.E>
G<C]T?,RKK&99(]TWZ+HW#-D[L)EX)eSA(=0gGJbdNB0O9-GW._0.AH,U3LM8R?R
c#gVH@ODe?KQa)FS-:G>6&H;YZc#/JEPJ+&J29gPfD7c.5Ba(LSY>-/S5cJC4/dZ
0ZD.N2c85@.U[)(@2ZI(?>M=F>S59)\,MRO-6;HZBY5^U,I?3->[HQM3Gg.[;-W5
AFX/dcS^MU3B5A#RgZE66KQ^U(;a66cb-/VfTc^-3PD/6Z-D]E]@IX5c5K&ED\#+
-E9HGPbR-?I?a>Y5?R;e2OI<9Z#PA4F&KEf^#0EO-K]d6REf0_dZdM2,6[8MGG=:
9\W8b,T+O[,Z,M=X]X&cYF-DG;^GB+YH_L,YDdb0E[Xd+^/aB4DAP7Oa6T/52D+C
#eL;^TOBeTN?RQ7bC6fAO[-FAA[X-N-/gB@;7&+EB_2A0>/)H\M0e,^KebLZI:c8
G,F5cP-?CFNJZf)UD;)WVDGZC[_[_465;W02.gZ3C67(R#c&cRT7==VYL3AgV7OY
E11c+=Mb/G3&(EPUf68,<ZL)/cc<=gFO-5f<#;e<K68IH;#\OTF&]F:3.YO]==TF
2d>S/XWH3QY6ZNE7]a^P^>f^_d(L@AGR9,Y]?a?\O<6VC9CATY5OSA2:KUa;?7K^
543_^OGf;:OK1LX&XVBW>8D866X7TfZ(9RHV63E?DGTN4E,.D/_Gc.fZ\540-aSO
dT?(V>4gFf#&))QXYIaA#8<5^]E8\1PAPO>@/V2JL(a]@;(X2:V)/47=6)JQT-L-
0_0YU,Z^(.W,7KA,A4g=V?;N(+N/P/#^-Q_7d/Ae646?7_#?L9@cg;EC=SAH(WF3
d2L/Q-5.N0\<S861.L9K,,WU^?]#bOV7,_g)H@X:6=e;Z+3e751g1_JGAaaUAS#(
EcI0Y@(/c@U61PP&K;@-,CHV?BWe>&.0?:=egH263T#aYQBgD3CC>_@_0-_U2MNK
(OQdg_L;-K8WPT1YB^GTG,D^MT((eQ3G0>HN1eRWC8Z?.V^.XD0?0Q[fNYO9S?Nb
5d-B4f<d5=>E9e-e7SQUc8X)+=>QcMAf@665FN5H9AADI:##_9SGZB^/b^PN8(O]
f&IUEC\[-cZBL+.A3Cc9QBg^aL+#MP8fRePEI-:W^GHXe[2[=L4#5)<K[OC@aR#1
M:SK:,=:Z&;_B0=gX;ag.?f5++IU.U[da8gN?ELT&Z<gQIf9f^_9Z(\b.1AD+eZa
AO<Z/T=FLLRR@&SL3TU8XdHA()gY:ZR>0.HD0#dg?\FCB7R^+-X27O-g2_Z;&f0M
_D><A):O>S1B^C\XQTOMNMeRH9^O0,EZBa;,We^B())5\MBC<dONEA8#B^Fg1eQ[
e:&cK,G/4e8WP11[0\gGHJI17VG_V6RRE0MV5G2T/D8[HDbP,+^Xc\M3(;>5M?AL
7b#H=0.FZ;,AHg-KP8a)gM#_BU,C+UCJ/RE1LYKa7?UX9_<OBaQKXP?ZIY]@D^M(
fF?Y#[c(Y<O>0gG5Cc&ZA8\3)\)0[-NI3ME]eX8O?+:baK-,[V8X8DYfgWVB.=Ie
H<S-+3Bg;L)#<Nd<:WbaYcF)a&)T&Z:MKb=M?H^cCZbB?9C(DZ6GT97AF>DUD/#>
4UDP?>N0Y==#)^FR@0K84]^eaO,Oa@+TS5b0O#HX[b,:1/c,=AD/806Y:OaI2504
Q3:A:YN6)fG_N2@NE56LT0U9^RU_<aa<;VIJI?0)-)(fSWV0ZB8G4)g0-H)Re3Wd
59e8f1MM.fY(:c<,0^=>[.?#].LT@[eg3VJ#PNMDE<+LO93)fEI[CI70+0.K6)?)
);c@E@X>ef-:XBYd=LPf[OS@Z_MOe&IL^C4e/3f1=8EQ&_KV8-A98E6MaP+b7+&c
F_@SQ8f^79DS9(+XBED#c[::;EOdPdf7S495)PZ5A\U<be:Q+MZ)[55(4JJLTX1d
=GM1NR+U=5edf)5S[Z)VH0-YA-2Q1=XW(Q:)-^S+L>[2U+S2&f_#PP)ME0(<]1=&
0#4J^,-#B14B[gfDOPIWT)4.DGC990MU+Be-CcDH]R_D=6L<STM>4a]=ULQE+UP<
eg5\33bcNW\6F?2,.H:;gTb93Aea6HI<HCB>Zg7L-R55];3ROGN=f0/a=AU;>:#C
WfUG@^\fRNcY&JR4OccXY):<UH]@,3=7]g[V7N-C-L2\=&?7=5-G/YG]2M?>]4>:
?+^efB,FaFdW39HP;S;.PO7>CZ;B>J&>)L5+N>Z\U_&g_;=T0H2;\7,gaW&c\4IH
<4]GQL1//_>eS=:,84?\[FTSe6@LFEd22\HE@<OYELPaE@SMc@gVbMLA;.Q^YWJV
K)-V)_&3Bcb<:RgZ)?G@RVg<[2UM](2-J(_G1)4fa_9A:Qb/@],N6&e7dHZf8A.2
7\J08S(A77MRf(UJXU5f,OZ#94-bW9U].gEb@(FMc.dVTCM?2Q&GcSIIBN[J^G\K
C#6XaGVJ1601C^.X.fN[9R,Z:DC:?@Rd-I><g9,9+S+->9Q+(7GHGX.Lc<49HP11
@cF/\M...+C]7UFLYdd_b#AE)7]0Og[>J5X=:ZbSVN\I#_-<H^J1^]N,aCA2]VJ>
7BW-7Pa2D[^#VC=dLNWOFAe&fE9Ga\K^-U>]M#4,cS8_\&SJ2_<A#bJ<J]),R28<
KDRY\8=41K)>2R;+9/Y,a[BcNK]+@XJZXD804_H6QegLU@f=8K6_92_[eeYReR@&
c:I)\d^R)3=69-cW3JN2&[>5@(P9c33[WN\KDYN:KF,^cQ<#VD@?,c;3DTW[V.Ve
>-341T4TML<LGS(XP<aEBCaf[=VITfKUCGb]&F7-NW;f1abMgNOb-K^O\/bebEa/
:B9FT+F)eC)Y[4fTNY6eBNJbTFdG?;4Z_I^X3.3E.Y^VG?b>eD(8E4UCJ5Y&.FQ,
67[-U;#CM;O4fG;G3Q[0.4ZK5a3#_QQc.;@3<;-.&8UDS2X3\]6#,\LINYf0H>5-
3\X-CfAT/HBAVb:fR>\SD@Q5<A_3E:N66X)WF:-E?Z#J]<eS;(\f07U]__+6YQfB
RH6WFKH+GXM+#+&IKF)08W:OQS&Hb@\5bG2Za^XQ=U7RdAABKK=fX<54J2.S1)7C
6JGIZGL@CNM()HQ(9GTL&3Y-9gO8O.()T,eLcIE;Za8[M=W?+E+S[OEPJE3DT,bU
06efScf;1;;?\S[?K7FW+Sg#?d6CI.#_GYMbMQ+RQQ^f.P9g@>c2UK@;^0]]F/cY
,?19-6J)C:CG4O<LHWUA>4))aaXR-dYfPaQUc<B-2_Yec/)FG&(dBWdSFd<UYV9&
5@dO)D:>Dc>U8FKXPY4b&^Q+c[Zgf^(?TWeN(cR=/Z@gNSSbEHU/BGXKC3OQ&BN[
R\FYgOgeKE1A-W-(#P^O]P8[a=72#]9K@Ace(&=H<&<9[,M?W@fad+,>U<\d-5-5
=\a7\(GX3HDJcNQJD-G89@NLfBeD,37E\Z]3R-?IZZa.+ZL#.(HWR0(aW_>)N\>J
ga=<&Md\TS^44D_WFOS;E7U)+<gIS3G,MIPGZ<Pd886(I&:AS&(;Z)N>&AY=^EGP
C#RAF4+geN)5cP3BH2:e^[Ec,/&TO1DB3F09=&#VIS+8_B&N3E_JDRKdJU(F>4B\
H#_Y]GMP3dW=GQ@O:#X#X.;>5T\=VX-0K90Q#+F16)B3d6JF6]Ib[?P/4d5CFHN\
N+b/^:^W)[3RC8:ZJ2]ee_NQPE3.d?bP]4O=(=VJc1<&;B/Q\T.>@#ab8VH78JEF
F:6UH=CRW6@1#)g1ZgC:ATBaLD8[f#?O]7V?ASeU0Y8)+XLM=4d3@U>S.&@W^EaH
-aT\FW+4eC^94[Y^TEC\TQ=/H-N@(]0;#cSAAH]Q8,UT:EC7WC[EDS.EUVE#bM:K
Kc2LRSNUfA/@]5TeRNCZ:V#+Y8B#&^S+D-[N96B+=E^S;>Hf73O@UIQE7,)+,]/K
DL)_\3O:QEF@K479bJ5H2KA45A7cZ5-dG[[eg+<)4J,f@Q_PZCN-\]b,T1<<+R:D
HNaZYC31\O9F;EPg+fTY4U<C(<fI=997>C_^VAd5F)9Ee7,3TR8WUA(d8FL+X3L_
:P3ZO(gb15(:\E<b-5PDA.>LGN@TCJWOS<-&AFMgL3CE73P?A@cUYNaM?\ZG++Jd
HAEP[T=<86K/RPKOJT_JCK;4=6V[?eNR+Qd)(R2I/.7-S5^F3GfEd9HWd8JL>KaB
@aAB:W<)d#a\,?-_b8WZ+0fDF-X0056^NM<d;8fXOBCT;@4_g#.8gB_?WRNE;FJ2
T[(@P#7=6H#DffNfYd6c]-L:DI5C-Z@RPCD@&_;]<SI[4HNPa5=@K^B_29cce\18
[&71)9DeXIV[@2))O/d[GV59&X=(H?\<W61;QIM<&5:b?^+ce4JF:bGg/-LXK]f#
E9TKBdAd;HEI\4Z:XIbQ9@Z?KD/gAcR+)T.<U2=TAMPS;\@34.ZgIZ>CTHDG+9YO
,eD4SO8AY@=UGR^[Z=gL?d-?0WN;UJR0&<^aTgdVNb2;;S>&97a3K+ZW:JdXR8_-
N&08?MK?[NDP(BHYO8)U_deDIFJ97.Z(<S43+f4GEF_>eU=_bf[0Q)Q-MW&Y,d=P
R58NX&@87_-dS+fW\5&.SH<JV\KU1e0d-XOCI,83(K/3]X+-A=IU\;W@=4J?2c6;
>dWe(]cA9RL]/4gGbC6+F6;7<:ES42^968]_5@BMJ>GK7[/+_WWH?ALf/UB.+B4+
ZFMOCHZ1HG[O&C?N5b4??@d_&(4CcQR[B0d5M^JF4YT]9PO00eI-1P--[4U2c][,
K-D,@8<Qd_)a(],RQWW9AL9O-(T^GAHAA&A[V&^WdJR9f@eS\KR3<]J>cX9]@-fS
(O28;>7E)E69>/ca?:bA>6cX?.WD);PS:LDT#a;Zd_2LDcQB8_93(#NL]S7;FAf6
+\8N+(@Yad<Y2Y^LMYQ>fNEE6XGe88KgTI??)+0@fVW(#8T94Kg;W7gU:?87Q@>[
>GaI:JUDW>)Y(BS/-A\SSg-:DSM,=32.):P#&F7][e[QIH^-H.Dc1,WE)<E/LKL&
I(GDFN]_d0AS9E+T,UK]1Ga-WBAN9dg-:YDDVK)8P7]K17M^>Z1F;IR[Y;W2&F(1
(b-N/XJKH7Wg;OQYPfZ6TU(;@><ICTdGFKbEFg=@^/;Z4[OW@V+.2\+DBIa=UgTA
,9,1+?FYOW7c>S#4_NWNV&egR8,/egAD?LEDFF@CWH>LfU?/[E74&309Q\U?H/fY
P0KX=_O40,QM.:2EDL?_c-:,?UE\++#RA-F4J8V2^QDY78]E5A4^HR=FS,HDF]&5
1O?6d)<)?T<A9K(_Te1<M/2[F&M=]@CKH#NG_6.0UI+S80EFeCH+J+I)Sbff5F^+
)BA,Z&=41NcZg,_2^@XF<.J/fEfJ<Cf3_Sb?aHP2782EQM4&Q89L5UMK/RCX4FXQ
1E,YW_16fO?^b[=72I+-.VK5Ma5C3>UX447;e)+>0@Rf47:a0b+DV3A+#ed5,g4I
)#W#@(_1H1DE71dP07O;P\-WAdK5Ob&=JYB]FS^Ca+3,)7JY\KeX<[064T.4AZI,
GcC7Q;6N<HP])RBPO1X9f^/=/<43V7LR:6ZVR@J3F6:A53dB-cAWKNC9ag_+V[/6
7g_R4:1,7U-1;N0#U6ZO4;^Zc=fac@?^B;+8AXA2d=HQ_U?_1/HNf1?#7\NKB6)U
>?<#2D?D-,>RA_DHOI[IF71(/ZVKKgV\7dIdGUaXS80T;d(;dS#PFDM3/J?D>TX4
K;f(gKce>Oe\OK@T0HO1]#/:X32.<L_>fYQ&D2(N8E1KVN]1AW&_A;@aS\GILER>
+(914L<@D?J@9)A.>WB2D&NW?POMbJbQZ>QGa-3EX0gSK2GBLW@KEeM:J7KO\[GG
ZYA1-DO,C_)dPNKI,DME8^>Pa)0&3J[)JV^G=:[&_0K\[DBA/QD>BK??&JX@(_Yb
>(Pb:Ae@2\LC)NL6WWQ=R>e9L=g0e\=VBb@[Lb1A^R\]g_A.)E61S/N5H()5<;eQ
PTI<gW,BE.DPD&aP_@84J:=GEc77N>>Mg>A^38S=;9.gdJ4[LNK4OHOe:M&8#NT:
)Q\ZNS:5YE+<,J:C2g;_0&BfK2JHG@bI#[ZHQMC.C(T]E/GdVf/:O#?EL3/8GGTY
Y/cFUW<SC7/>Y=V,(7Z7V3Me90XSPQZgE<:0_.@FNGW+((+7EJ3d.(PG>]gMeDf<
Q=c(S.RW:^:Q-&_e>A=JL/G+:V4+\bO9SA(0UC]>[DB6Oa#g_?a/UKZ@F1F3I^T=
<MAAQ.1J.AEd\)cY>T;]@cRVC=&AJ?9N454:[ALRdbIWd4X.+6-G-8+Xc=/G9^Ub
Q=]MgEdIIf+B?#J46X]MG5M9\QT-9.U14_]\0./=KJa3LN9cX4YfQV8<<GOZg=U<
QD^ULFLeQNa+)9XFKcZLEDF-3eYDN^<BGGB.6\:+J[Z)E+Fb&8/=Ee0V+-B:7Q=a
;XUf0SDE?9BJQX87X(?Z:)TEM1[g[O14OFeQ0\-@DDUdQfWg=MeL3\_+6Z?25=-L
2N@6SQ&6VX52A#@[Y>_4EQH-@@f5@RUZNW3,?WVR6V(/OYaXR>(fE(.LNH1g+e5?
5??O(\IeCX89EPgDJd?+5RPN56cd_Lc\C(e-IG],f4+.e6<A&H6F8f@Q@;d:[M,9
K-.f#6Ae9CcK(E>:0g2W29<W30<.Ua\<::ANW_.Y+.c45[+8??YB37[LHOa_.eVR
(4PHdJfRQ7M^W17Md8IHKY<V;_<N[@7^P]OG0a3DKWD.TWXR0PAT;[He2dR6aW._
.=>7CBYJ3fKCB=9#gM+9/A(K=_RK5ETdV<-00E.Le1WO.T)Z_),^1Y6H4(aL&[-Q
]2R>QUc1P&g#-;Q<D:#3+XD61MZR4B#K#B[1ReX5+IHP4EQ;F43(L^23fR4d:0[A
GXB9X=ED\bTIX4_=^+Uc;+e-0KX@Q6H^;GX[K>Y6W_e?#fAI]?]<O30.M2KEI5WB
R_Z@3b(ULXI#\T3Y96R)JIGgAF2[8G_<.)LQ,9^]=JQf\HRDI@X\V0Rg\1GS8T<D
ReQ)TZ-OD1EC9::>f9P\J3)P^#1(VDDFD:+XB_+>Kc=M9OOV4H=-O:V^[bC3DE93
,(D404C/(1VK1#A\;/+IG(d7-4?,@=67FE+W+C2V=CV^e,gNAeV5P4/NH7(de,MX
#2g&,KIK<JcQ=QfcW1eG4].1e7R=A:@H,49INf/Ag./B2a;OO,e3&K_2I)8M8gP6
.O5E=;,?ZCL:O>3,Rc)/Q]+#,_0[M,#[KSFTZDM-RQX3e0UVLZI#I8E&ba?6fgI7
1L)YbR=R7PH7HQC/_WZG<1.cgaGc<RI4Sb53F[>BfbHT,M0;\J0TAM[;E@MX_5TF
)d=VJ;I:-HSf;R1.a4QKGbOVSPOVEWZS#;#_/G8I5U>W:(Ug=e8gQ.H((29F5[[S
Jc-_Pd+Xf)7<RAJ[dUcOJWLA-WX02#:1Yc-T&-8AA3\Z;--T&^6aSZ8#^,)\G#;9
J&#0WID,]#9V1Fd&Pc,,aX^+\f9AYY+L:-gdgafL(#3E;bIc+<-K;#d9/5]FDg/I
A/<][_MWI5)#W_UDeKOdPUM2d,+7X&OFf<8BC7U1BU6?898QGN)^/#7g0,(4982?
aAPY3V0(4-Gea[R-54_EQJ><IgG.[=TMN+;2996bE:P<6-A-B@2^OVW>79f6._;#
\/1AV9P6d?MXZ4MJE4/<PCb7b0>B1c=JSbJH#Mc+fMdDM^?R14CJ(6KO5Q_E#>1E
WPLF42\8BaM&B[C,J+]ag5L;A@R27CA/3F0;)_D>f.UfgbX=]\aF<]IB^45ab4=S
?g]=cF.XQ+1YR.RW-58c\[,dX]J#K&\IO\H>W#/(S=_gDPS?.fT1[IOVT^X0O2[J
A2[4g3_df-;4ZM9ZM2BU0b+XLB7R_V3f<)F:dTUDD<;O38,[UJd((Jee_Y[H5HU^
?S?@9#]WJFTUH_Q&b]eCFX+;c5T12+I?:J^FcU+=OXXNJNLPGe_)2@dPG)K>XS5P
A+[@a^>SC_&8a-.TPC(0(7g]P5ObA1#?LUPa<NQg/#-G?XFLZ(MX#I-/]JQJ5BFR
.cOM^.TZZT+]@HeB:DWDN?W?U4J6),37()e>RV+5<#cSRTF2P)HMY,-T]8<#_G;c
6N+.GdQ4S_=B4M1G2,31832BfBaegUA?/E^44VZ@V1),I]XJ&b^B.GdSY?B]e&?7
dO.&<21UL=(gWZTUX,&7YX7ZW9C[EcF(>]c1U]TZ;.._5E/eA[@[61D:28__87Qb
Z#4D(#dXE?X]DS+U:0;c8AK4&WC-Q9(.K59LVJ>TW406_,M\LP_=.Q9O/gBDEQaA
^F+HJ([-]Hf7aR0TH(Y@9a]=^K>VIO8[@,,0b:5D+-Ab8[04>3a\0gZWGK7][EK&
/e_Se]<F@Ra5NMN-\S@^HI9f;GDH\a/gBQ[KNE=V74;FZKDZN:cJ<]<fD9cPSgA>
ceW6bYdK@0V^\S_@W1:AceE8g&GUJO?AJPEb<TZ8d-7BGAGR8AS/aR:fLEb+RJ,M
\&L5R?(fL&(^0cPA@(P9^+SM8PO)(ZCBT@B3M,JN8_O)LNZ(7a1)>gD1^#KR90/]
O@\_(?6]J.&6ZYZ>-d#30N&HE4_.[0W2ba:;d]W&[6#9gd>,ZL^0X_LBc_fSU&]2
,Re.cU60)<Q]OJXZAD@b5e73;E5gZ>TIBT9:09.#_+gJA(PWHPXV7OJ)90WIDMP/
NJSET]@D)/^CP&:Id9=GOd3B^a9BEX.=_LJ(,<8C[.@+5bS[ad8BN@OH#LK^>^fI
UI\EK68]TB/I9,KT:O;Va8=O4^eZb^N+,:HH]VQ^-TeQFLbO<&bE,(3NfD10c9cQ
dXDUOLHQU__GL)f[=)&gbK)LZ><>GV]V\X?(PUOWM=bQ/a+62K&I/8>;OW;FR.SW
Dc\BRL9O&d:LSAW6FECT7Z;8fCF@NV\^07>L=UOXd@,+DZ0CL=B)@U+V9@E#884-
Z0:2S2c>/5IOY2A]SVcR^>2(GY+bIPE55(aY5XFZYTdT:TdINMWFWZ1DD?<XX6TC
8\^]QI3)dQ.[VIXRO16[A7geB+=dZVb1ZVTV+GX-@cLYDBL#DB=TS4WA0^>^U6;:
E+P2NRKL]c3/)gOB.4YY:G)XBZY#X\(A1:_gPgf6U>A\N8QK,IV?U^T,R/XBNM0X
VEVM\DAW;4Sg@)&:b=9efc=30:-0MYe48K[@1CVO]J2a:a16VD6#JSgS#eDe?Afb
3IUU=/gU=(.H.;0fe:?Wc^8XQ<?e22Td4c&5eT@W<;cX+01/D>E?KcdQf)UN.8\N
<-g4gGGb,OQ1C(-g[+[H\_8QNLNU@Y<=MSf>f.aC/dOF/DCAS,(g6=(IcG-L@PVH
g<gc5PcTcZfB1_.T/bV.-_\6f:F/4W1<>)VRGMM)G;S4EI3-;9dCa2;1]CJRS:bR
@c3-d#./g]6-/;,DK_A<<R61Q->](,RX60I/.AZ([[/-I]#,0C\M1QV3d8,=8d0?
\3FAPb&[05=FE^KLGb?VJ/\LP^c-NY6EWb[_2=G<JC69_a1J.MX?@CcK8dHa(a<^
YWJ-KWf.M8+9R>d#15f\VDJ.2R->TFNbK(8aTM<bE2#GHgWK)\G_L(DS[R,EF/e7
K_a7@XV9132L65O=C@\(X@L?deW?LL\Yg0D03Kc>e7<>M2[)d=^=5b#dMF6(dY7:
_ZGOgc8Zd>(-)6\IY;;KTAB<6#dPFTGADLaZ&>KQeJ,\Oc#+gd]b)>VSIXdJQ3Y2
&5V,gL]@YbFEK\9FA5A0;0Q4^_/AN068,.59L7_gA74J2M5W(51],]af,B6H&6CF
eN_eA-?1J-,8G.L3<_[9MU/]##14S\[ccefWJF@\PLe89[c42RS#g.PN,(B37L_3
R_QB_#ZW\=HBQ.EXgI-7b:#4+0@B,+=/,9]?=5aS#Q[TZ/eBb^G[DUEBPI<dYd?-
_db-A25HcD.9gV^S)MS<C8NX4X3GRV_cYTNFb5-]HY>3NW5ER]@^AD(.#D=PKGBR
^HO5U5&O=dHeA8[<aYT2g0I(DAH>I)7D@+&60[C,95T^+7TT2d,W\HX16\G9c1^6
_;-]KP61Ra?e1)fD48/VK4_9R96V^^cC3LX-_6]C5))\B+T+NH\E=;aa8?&BeDE_
^eF:1?I5:[NWeNcL7BU:(;JY0+.AEb3B<VOW5RUCOLDYN]6;gY4A;34BDT/bGEGY
;c7X@\/Sb2LA18VY0:VG(0^S+I>3W#53:OU2N^0b/QYa19J;cDLX9.&G]<MA8=KB
W2gND;3X..-;J.M8YX7\-NM)78L.&c1)1POY;,N2J;TTbYPHWdITSbLC?f3110d&
1cF([.WQ:4T#P/GH>E5[^d/Z<>EAWeKM)M.K?#CO1UB9)Y:2ZI=U<)5([&L+<NVP
@=B+OM8,N\4#a[]@2H8fY&6b2K5A8@Y?1XJC[CRB4NJQ1JOPA66]/B,[7dgVI2Y@
,I1\8efBg;3\C9+J^.3^U7LD31T@H2X-Ya5KFCJ_QUf;KZ89F2cf]K+>]10+cM\P
_gMa>OMg\d8S,e&:FGK6T18Bd/K^f8Y@V,5NU9TK/?Re@ZgIPR_.C8#QX2N&IG\[
:b_,YIZ\/6+a<Z#O\/7SDTV,C04.bFVB5H,)gA<ZX)CUYH3A7./3^.19].8)W4X&
,f0/4ERLUM#MH3?#5>#C[?H?0:P//E7X(80U\aEe>KZL/-fg(HNdV/P?/(]gHU#5
ALHKU7E#>-bV_IJSI,<eW_A/fOYe?156&\N?2e&d88F:NDW(73470DgVG2/+=NU#
XW_d9S2bW/W:Q7S>gbVMH])60N<XX]E?8[[?0T.OR^SGWeFTMLUXeFYB10I.R&2\
6cS&fGROTSbGD@?E3M;cS/&ObFM;fOKeF:>e_@[I@4H2WDR86.2CTRVW<aXR)P\W
,GC<SEJ(0Kb6OAF@N1UXHB-50U(JC(g5b\[R-M(U(6+Ef#g4LU2Hg33YMV2NEfIJ
S=]HE#g:[21EN?-IF4#KTSJgG-cJV&FgBE(X#+4S[<J^?TI75@Y<R(P/FIA-0?JK
9e([P7\4A3Qee_6<HU5SNU5I6b\[/9\U[e]MJ&B<P<JfWc\P8].E;VDOKW)cA).5
+&W??F0A,^#_S@KMNQ#1ZOU2LC&#_IBF.UZS:(0QC_C9-2>,:</6O2H4SLX4a3VI
4NHEDBMXF)YDaeA3&b(6^<O\D3Yg)I>W^<NJ9fIFE]dV/0KffHQ[FFZ](T3P2KI#
Z6;9eaE]Ib_(bF;1KP95THVL>/dYML)6.,dQ2Jb2aV&CK57I<J][9,F+e4/=^@E?
1RB6=GPHQJS8<7A0JE2WH>8Pc]1Ta2_LS7_4<\&]eTeJ07-U#&Y0&\gP?<&4B;e2
6N/L2JG9L;DG6=6cA@Z&WAIE>0NPB7W(;>SYT:^V_@b[aIgXc(&8f[YgUU]e6:eV
2Y3,b4:XbLUgDN+I6g,]JW@&)D\-N(7(I#TG\XZ_#A)&\X\TeGN]<I[eIe#Se>Jf
?ggIDMRI(/:&E#@_VgcK>.0)9X<,JK6O2PJ^BfJFX9QFfBDK@&O,,@8B0J23F5@W
)<U-]65+Od^/^RU):PLYe8,YC?OcTEaXe4EANQ^DX^XU._).W\4.g;2[_9.W2,VG
2K^(CM&cH=-E#V\V\.<:PYca;46(Rf8QMQ+44ecfKH/;Sd22/Z<a^Xd3CEYR7QZ,
0ba9@81?b##&a2>1BZEC_R:G;U-e&MYDDE_]WS&N^FaCTST?#6(W8Y3a;1J)L-1_
<,<6(Q4^T#.X1QgY=C5NBCEP].WU>(8FfXe.Y1&K;[)^OLK2J<\JG\)9Jg>Xd4C<
EQ0N+7RWN5K?B,U^eUT&/bN<C>OX4-F>O?I?6D=IFbH:[]^/=V/7/4A3GVa)0(f_
=5E0W=UDXNZ>_7RLX7@cRL82)Cf)4S>5Dc:=H(:EDUHc@U67G<R7/M.-ANb4L>U=
OM7#:@3OSgCE<BcH85?U/)@aHK+RBPJ9Zd#aH>T_VR,.W#WNL/O7062XP2+b&C(.
9DLXV17+PY[W(<2NS))[<D)1I&1^@0?VOHIad4>:P&H7S7FHW[91Q8=aSKHDMBR1
QO,=8ZQg;G8gbE-.;:I:2C##1@];1VG=[O-<WGcTC)aI(?:Ke]<#\__IcD#]\;[X
gHcV^W;O))#0^3VD&/:U5\R&aSPGI\.,)&P2D4g=EgR\N.H0IU<fb63S=aY;aYF1
037WZGdG&:LNKA/6T;^LY4GF)=0UF(2Wg07@JT6?NS\#/Kg>29-4a,,]d06I:?)f
\KZ^OVaSS,.+Z?,R\WeSKC/S9#1.^1cI.&:CJB/:5E[K\Fc.,2Q7c=G3<aW?[XTA
eZ].9X\<c6H,SRcN81QKVW0)/V,_3GX5Zg.c@cdH.EZ3.UOXQ?MYB/H.D;^E+D<I
c],2A>cA7gDGB16WZ.K);129S+:5+4V8^D(ZQHTeRK;K6#]a45.8/^Jb,[S;O,Y6
KUWJ_gNJT8S)T/2FT\7Kb==[-A=NL62X10?gaJ3^GR[gc4:dUOK>&:8L2I_O8,A[
-EDO]0I;WZL=f?JW>##25R#GR\ZLVbV]P-UgD:?3KXbNTH+R<TG5,\3&f]:P\@0-
_/S=CA,VBC<ZALP[cHWX-)SB:#-e918GD-_04d(&@RTdeP(Ac?@/4]L3N]0E>d6S
aT#]WMUHNSg?M&EZ&KG8E:+M^=,OQOV9<a9I5NQ#RN+GMWAHN\\/U+0cIW/beJHP
)Y&gB8Z)<LZNB;0SQR@IaLYB1Y^-TS58cKI_)]B13K230WK&<A@SKE1>1FUT&H;#
7Z->EYSS&SE=e7PK>3ZA9I#R-3]2.9dV<#c/?NFdeefb?3K2ZI^+fQKM&:R3W:PC
IU)=@e(:,5<[F-85=8I/#XZ<F&E:GOP9416:@XQF+_@Yc8LbG0OMI,@I0V7HSZPQ
RF#C--,fO7EEY_cRW@^-40U8aO<Y6KfCU4\TG3;cZ-6^QON/Y;UV^RV,S_J\?4GB
XD-IVeXIPcB:a9eJW(c+>1d;eS3VG]E7Z;+FNE(TRLFO@d)b:+,W&GC/.H.a?Z=,
;59=L[N8bTK^4>DAgM2CY=@RM5EF;#3=a33DfXTUVC9^HP(+J&fP&ZfA_=RYOF7a
ef=HVD^Q?R&9&?T3NEc.T,;K-]aDG)JCOLcC>TJJQ(ASQ,<JceP12,M(W3&7fe9b
APRVGDg?W0(b8FCLC)Z4Q6I623;L(\G]Vg-H+BV8C3H-?_gc/f.HQ1\\0M@G(HK]
=@,A4,fN_XH0Q,;F.aX+F<_9]^&(O^6A>G<&2N?\7?K?P:M0/XRSD8)>/<bO4Y#S
Q#)9MX?>eV0D=MZ_8/;eDO3d]QM>^DS-,/5VJ-R@]cOLaI(+7-Z<9FH,=MbB(.4-
5Ycc99MeDR4O5WQKLUTAc/&b<g#bS2R9]GaWPQ)>:P.-\)IQCAA>:W5(JN^X0?3:
>P8&K2Sdf2(D=QOS7/SS073>8@6>9<_bWg57dF<Z]N@GB[XgVJF#H@4U1c3<_)>4
KA=WW08Z((IA5SD1T&/H\[g]YDeHdG/[ZUR3GD625E8>1G\QVc]b(-_/&VK(HNf4
IWA8JD6DD&_))0g3bI<.M2Q@_43T<MMQ(:f_(LdJd.JYX7\+(D35&)XLGB9?TfD6
cK48<WW+=e>K]-d(F7X:b:[,=_NOL=CRX2_XDGZN:D_AG=@===KTX6=</@&^+7=F
@=?V8FTZX6=AF\0ZZ_=K[@-OYVJ-#fQ=c88Y^,F+O3@C:WG99)F]=\<#HDIZ<LV@
+OVO#&gFWG)Id(,<GA?8Fb3#+M(280ge6\:.Y\5J7S0G>H1V[5/L=@YfaDcUZL[K
34S7KKHf2M)T;,D25f_?L3IX<C/f-WZ14V/#AA(?Wc>N-)Cg9?OI6^#EgXCO1RY>
J/I[Q/G8997#L-\a/HGLFL7DABV4<U5R(&L@LZPOZ<6,Z_&V4TCD&M@R5=3=_EQ7
)[K-_X7S3T6#3C>G#TV9K7#YL2@W]a4&.)L78f/-b-<2K?SWRWRL.HWc\<Ff;30&
F<=b3<cD6SIcd]bJ5fDgM[RG1/EaG+EgMQOOaagfXYM=7ZB<7F)0N^A(f2ERDQQQ
BFWM96-;O:W8eg;e__C>/+f/;dO]RQI2[Mce;DE?QeRTRa[5)S5Q>@8@J])_TUQ\
Y^B1)FNO[b)+MG=[V>1#D37]Y__Hcg7N2-X>:IaG-+M-(6O5S(E?LVG&6Z;K4MXD
]\Pg=J;T316f=/0^R9Id#2J_#d;E8SRg@W5//0aGbf>5QFg&5DO/:GFfMU0HBc/4
?;9P=5:Xf5W-aA4,.]Z5[34^3^N2gdZc\MXUR[5VXT14CN1KdS67,[0G9(9:e<:=
H0X.4I1>D2&(I0NX-,E)1e26D?Qa(H,fV#:]Z]D8C]>ab.=MEg@T/7S2e1OD6SZ6
S]8\<fb5P(UM[=aM5NQ]Q20>1.YV:12P;6,A&R=2HF]AU4V2d/Z\a?-]WMePWMGR
#=Q0JGPB<E2+^80L-6R216;#9\N]G3JOY/H]If\_&^K&=Q5PgIJFPOB/:=TH]ZO)
O@(<#WZP>(^&@5H2;(XgF5SVO5BZ^FIddB@6SI:5<HH8dOIBKCM-RB/L(+B=HK^J
VeGcdOREb?bV2)QD_^Q,,I/6bB=a0J?E_VabH]NdJ.gg/=RIFRQ;\?V^EX1G-9T[
;+fAE@f[bC<751DA6#GH\8c2\<XUXCSIY[V;7IGL7S=]:QcDV)].S]dFNd))57AV
\KK?@N3C(K,MW?0<I2Sc8HcDLLgXRG:KgA.SJ(OGNG43-9KTGCL<.:G/?6\/IERa
]dM]7_Ya12_.7CK0a+6@#\:.[b?N@C2DPQOc?A/O==K,]0I2MI\N_4XXP)6bf(+1
YXef5aA>ZFE4@8?U[2]]Wf<[XO+@0=F6aa3>,]WB)1KNJI,;A8A--8-NYI7,EB+Y
9VHU]?:ZHc>gLZ4/D0e<BCdKP@:.UE[;;V@#8MSWgTe0a9>(A299eNE9aCaEJF@_
7+JEg\CMF6VgFcgV8Q>_#FI/N26266RB(7Nc5VfcK)??.YK_W1Hg8,+gKH]cg07C
QZ>#F9&7D7b/7UX+9P&21R3d](ZK41>cAc:;gZ4<Q>9JN-/IU<4?JAO1\P[&B@SH
ZY9+]&6a:.1,LIROH;eYP6](+<_#YZ<X<Fe92GL@>.9/6#;I,RJ)4g:=AZ9<G6W/
a)<Kc4SHX/.(2d,eT^3QDW<aCf3-GIEW/\P=-QVNQC<3\81RHWa1+?]M0JNf[NA]
\EJETU21RN8QG)78cbCBXJbV>\3?-&f3Qd_]ODQK._:CY3dYD<#Nc16(04URCd(c
cMQgdXRe.O^c53^eCd4]2VN]_Q&1PF#T)P(>C[R4@Xc\.ADY-(Ybg[VFbeDf__OQ
##7fT]&EPNX_4;U/?;[)fVO6ZT>&UTe7Q5Z4T;ZD/\b?fTA^9gF0=<Sc^J.\>Ga<
DH2(A_5P^H#=@\)=5&(331@.&UPb]):beQe_BW1GVLb1PV:NfXHP.G&T\OG_46BQ
VZbSS4AV92<DF]c81L);N#YI40JIUZ&0U\9\PgWR3>MXc/0NPE&#G2Pb11aGPNg-
E<)3IU#fB<Af(7[R@Tcf&FN_bG#)]:gRU7.&LO83Q-J#G^GUY\GC.HBMcC+FHK:d
F..(A6(&4O>;X>_[EM7\CO?)-=^5<GC34KO[/QU\c_ESSe&V3We@/dO]NVLF+#2F
M9NW&<f7;3:.(KK-0GZ>dAb+<FIXM8gXSOHFQ]fI6>2)aH\E6FX6a.K5Rb8Y42V:
.9HE^K()#b\>.FPF38=1NBSIDb699><bQ2.7TL&<L2>1SD#Tb&Y)>;+ZKH@/&FaP
)53YgO97^P[a_6]]@R8CQE(\CJF9[?KF_MA;_S3Le-fE.-Ma>FUEV<669_#_DP/1
JPE&WH2F4;6H^21C;M&NDLIef]C(-I3QfTX87TDI2Y;L5@C?6T\gVQ+[HXZVeW,7
Y+B19>/?;S3dM8T_HL,\/(F)0<VR,aX?SD/G^D42PBUC60Q.>dFUF;F9N:0UF2QH
&BL&,VC19)3Y2>0#0Kg#[MSbY1/E9^F9GG;@MH8,K9d@D(,PX>3494]S4RgLS5Ga
M6\76J#M_Q-O=5b:<P5@&a(WH7B3Y4(K65(VF\OKdDbdU)83:f.Bb)8TEgV\-1I_
aBc<;](Z,_S9.#;?Q\Q(3,,K6VHXI\7I@9OT0J)6cW#U9,YN>H>e]KC&@VP582T<
L?W47A430H30?dYgcQ]T=Q<B<T<3fSScgJQAegcU7B7FL58e#HSM9^L#+HcfS3dA
26-\_,Sf4OQITb^HcS#8Pd?U+CV[2:T7R>\FX=AD?&HGY:H(VGL:_QGZDWAF?HF-
8ROFUK(48c+6\g=C\-D\F-CMJCM;_7G8&g_O>5FN/VBc4YS:A#UOP?67G7-,PdbS
Y2U>^27U>JW\GD(Y;@?]1.\^,U(c9([f^UMW(<Sdd/J^&].^PW#3:2^a88=E79Ac
0,4[J)b@1+W>WH_<?14<GfF3Ca(;#[(_JO)\KLMZC_JA54Ja87baD,O+LK8D]#<Q
F#OW&Ed,H:N[eOTb4-]:]0O+EUO:dZD0IA7155U/b<Qa=9WA2XVEE+[E8UKF_DM:
YXIO1#][O_T5ERfBXJ<3,I5+JTNMQ]Y\?&(CRD2gPN]O:OJUK[KR^315(?)LDf8I
5TfBU[/a]3#MVUcDADTIE]89@C\#b2-A]D<,\agcA+5.LBD.<a;=+dNH[W?WOL#=
?CI:))3f;P0EL-C#WcA0:\dc:FI:bd9P_:)1=,cF(HfL[U1&;fILC2=3:<\R?EIX
6Yg)\AEJ-#3>&J=aPUF0XLJJ4+,g,^IGTJSb=1Z;M=J;aL#<F.2.?&0Ma+>Xa9-I
GH=F_e^cA&&B++c].80Ng2e+T<fJ1=<TeNTS4e(IN]J]ZJZ9HIg@5c7,:A5@E-.f
07@/:XG.Y73\Je:PPJC(LObVU2K7F7/@OGV,<@SK3_P0;.3DF+S(aA(&N3,UA-_F
RVK3\@JeTcJ<52>MbI+Q@_OX\0SFgcJ1a5M?+\Ya#3AFaKA5FWKT8Lf6,ggS<4K(
:BgbOFFN&.Ta=8L@#OPQ:#3:_Ee&R>dA\^]2ObUIUM;_CN+;Zd-<eK(Ya7XQI:4D
^/##_=:_A;#6B1F<>AfMY]ZC,g9#8OY<R64K?4]P70eNG+J19cPB\]FOaDLEF_0;
1E4dJ-/^::\ZTR,>/4eK>_O+Y:ILP5AQX\g>#ISOIZHF&=7E2R.^]Dd>M.U8IN+W
VdV@\]<F(Teg_I7IR1G28D:/,A#<<^1UB;K&:CO,?;=-)W:ZZ.QGF38#0#)^U/V)
QNTKCR^F7EF_5Bc<9cYVFT_XZ[/MP[D&A[2V\20AS9ZGS>TbAA+/J8G@K6^N[5-S
+.S(aSNDS-ACc],ATBS9+=:AU<7W1\(;DTL/TP(:I&Y(M?.O_KK0RefDY#F7956P
,R5+5Fc+<AJ=Gb)LNJ(==-aVM/O>]?IKH-/9T5G&?@LY2R;_-g.VA>GU8dN38V#Y
>??2T81<\Ig1BH48PM#\C//X<)74O4,G45H]fGa9]K#)NTe_ASP;McG00f2,Ob(a
8V/U)I<:[(6g#YRE>]G99V;([<1;UP?B6)XB[V+d80J/U<DXX:@>Q+7XH;RZgfPX
ILQL>HSQ]2^H@\VYee)g<>UUUOHA,[:Z/V-#ScV/LLJ=SRJZ21H-TF+F9\5FV..=
J]HY8Z5QZLZ;8ID7EfAB:-K#fI2+)S6K\-8+<2+]]XO9Y\21d6Y4[@0Cb.Hg//>8
:24@/\JS305FO=X[A\W0Z/)O6UT4d?UcHK9F6bD,a]/2T)>,CNg)4;\Z&45;8K]b
1:e0Ad@a0#JR0D1.J-QBT,&7>\M6YU?_>3<V?\_\21cSWGeHbILbE>SD-WBG7gXZ
U4N9f-V&1^4HL#=V^M8\#1Z60O5dDB4YcM@S4Eg#aCNUYgC8-d.EM;e<e[3Vg<7V
WKIM^34(c>)^WFVK0;f#R5MD44dbZQ/?c@df\)12W4+OK6P&2)FP,<OdS3+RT#b4
.bYFN+C<L\SAZIFCg7CN?-3<bfU5F6X;XH1.\OYfA7YK6E#c>3Q#+L)48M_CZ8.Y
JJ<IJ&)1JW&7^>F30+SB,N-RM=KS76@)bdWEae[8,ZB-\>?1Rb+ddOC5c)d@>SGa
:O[U^ZG[Q7;HFUS;ecfSZGY?[1[\406IL>=VX_1S+&a9]7b(dc#6H+&6XE?.6L5&
_a3,G;aU[;35@6FWc>U8d88-)g4-_0KKZ^L\^VU[=VGVQN.?IUCG2,dJNd)N0-J1
SHS,>a3c-c[\+QKSOE5V812MOIIVN[g>D,GZ0bb@N0R#=[>a+O30ET-HU.#cZ9;B
Ac89I9U]7RJ>)K6f]>7?N@@_^WH1fO(a;D7-3REV>-FR_W@K=]@_^fUZcFb8(A:E
.-89HWP\GJ;T9@1;=9<]WbMPbLcQU\K.=I6),<-G4f,NRV+&D0AL/0]DGFOL[A:A
)ERcJL\0F<S^bW71f:WULBK\DKE()BPM)@8]V)?7@Q-)):89c?EPBGD5Ca)?.3DE
_eC@GLUE\);2#C7G?LEJ+OVIZ\Y5G[2CZ5O;5T;)HU9>X4F\?R=N,T<B]ESXc4RC
/)HOd\Wb2++VQBAPZ?HQ#_QdGMOc(HJAb7]30I4_0S&Z?1(W&O&2AFG81<(BVA#e
_2IWY\KK>>38TO&+)0)@ZN5H7cLc5)?#5\4eEJO:\(L\B&S#6I9=gZOeY@>##&D6
DD&QVF8P002@XTFN8P@<^(OT3VN()TFb?fZCY@QLW7W895F)F-NH@E2:<7J;e>Jd
CC91)RXB]1>deF=I]RFOF-2[fODM5Z5>AS@,91aA7CUV>QPFcY)Q45\\3YV]MTSD
+&]-F(&J.VL\DRU7X-T\&^\](/N)d;42F:XVG)4<5T1]=8C_UCZX6VI#WP(VK4,9
6?1Q3E:eS3OV)eH@J0BX4@LIUVE2Z&208)WG/fgE[/,7ZeQCgO1UT&9/C54O(_E0
^-OW,OAEVf-(SJ1\24D80cc)[-3&c;F(3]<R6W:fXg<1M6-S0BR0WF(_X(Wc8U,5
3[HMd3\[X#CU=WgY45dE#8M=&8_dBRaBBRT9P(DTgb,egDW^M#ZZ-g>:YFW__RV0
fX8WV;C6ZEN8D?RWU2RR9WFZ2L50:H;L2gdDfZe[7,g,(8[BR]55fAE]OdFYVSb@
8R<C+Ed#1cQ#JKPZUE]KEJAO5A80^T8=;@I/S7LF_7PQa^aTG]=IFC9T]MI3@5Va
T=:RS&\7FD&QD/=+&2TZYRa&:T[FG=KcfP@#KA_B=_(H^):3[F-X?BB_5W-6V/NG
T;]fDW2cS/:bQCC1(IBgAQC>:7(9<J8(L?(Z\:9&5+WQ\c_U=?8MebQd^b,+BZLd
F0c83XJC(;5/ZVTeOTU;F^<IR[6E04_;0\6cVHNBa-OKcWdD0\O/T,Nd.A0H)+VN
82VW@5_Z/Y5,?DFG#@@_g,_bJ-a(6?0;<AgC(f6B54RX)C#STXP@N1e.N_7NDe<f
H^?7-6g)/@.,RcRK=g8D^Q/++C5D):)=:&6bT[fPfZA/..CZN0^JY]CQ.VF#;VRI
H+XebebANL;@>\SUD-^JI81c9E5E6XWNg-fFP,W:5R-X.)O#T?B4:X&\/((&3&3J
TJ-YbPWW0)B-gUcg,<YH4?;BCf;dAAMMB8=.(=<UWSR?TWO:P)>V@L:dX0JJ=J26
6@1PE-74-TA><,QXHVIR4-4O9Xb.Xd1JS0VG)GI4CM1)cFN5?cOMP0Z+GJ[/b+3P
YEC2(V6->SU488:H<@)G8YA9ggg(Z1g7Z3G<->\@-afEUSI<5?-=_98a?1ALM@^S
5FG@A:S;[9d;E6\5I+?O[<A963SB6L:KV6<S[RKIVMPW^@SXc:dNcDJ>d1)GI\WG
F1UfXXbR;?c]33fJ<d38V#A]ASDD)+5O1Z@e]JCP^1#Y7^dVA)BU009_L<49-],\
8]OQg09V2VS2fA,X4Z/HYAE-6)0.fC4C.g^CE2&9\F;+XFR[=+^F,TD@TLaXO;DQ
S&Q#?=.Fd_JND+EH2+W+K5\2dS\ggLUD=XQ8d^()+4+IY0IdJ:<BNd@Z,5BIN(eL
:+@Cc4SVbB6JCZU))7:](2O>B(_=2e0Ee51N]4FP3,L\>6ZaPHd_1W=,SNW@[XGJ
f\VbB=c]N;FgEcBcYg=c[[0g>QZb_TMO0PR<5G+4D7^9\_]KQ(BT8JQ+.L=e+/P&
[@:LRH^D9()cbJ3&fKL&8EXM_c5)E:RVX>O?+O1)W.H;QegBKdL?+MDBF:XbJg7D
cbP;gIfT3-+)[f;7BQ6CH>_f6WN]DP7.4KN84JDQK04P8;<7U;@N+1+HG(68(CR@
@2&6;-9_3?51Se8#(d.JJJgQ=FFZCZSUd]Q4(GD^C3BL0/;V3V=@B,(2MFMJg@H8
N#T,Vg?/bf,)/YD#RX6[7,?636bF8:7\D</>/82>UXU6fK8KgR,]de0/=6-O5@d8
[H;R/MP03EN6:>M:F.cS>11e4L.XU5LXZ?TZ9;JFJGF+/>VZ6:#[J6RT[93BRD#\
K3OG-;adb5@_0ZW(_?/BM8fI+a0BWAZK9E]AM\YIfO/:a=OLEe_Q\1H+VI.@/]G<
FIOfS^T_+;=GH7e8eb0/0-9,GG3#[8<8.Fb[=D4VP4(/#5FG;UHFII7/&N+C4ZWO
7C=O5/OYc56K.F#I?McXD32=f;I\/cKB7\96^;,H\)(^&>8+Z7)^:fa::QOH[4X\
X2[U1EU?Tg1NTEIRHgWH/cUO_g9P\.F#[CM?;Sf.HP(--dR3UdS8G]6B0LF4>L1\
K&NT8/N=c)]2c<GdHB#<@C\F6ZE#[&bE=7d7=-9HZ#7[F=-:Z,Jb&Cb9G(F..;a1
D#\BF0b)gF/IbFRc42)P3dF/#Y_f0SH8&YO1OgC7#^AM3ZX9DWcec^H5SB8:R,M]
ND=2B=8K):&#SHOe(;YNf]9gMYOB45/a]).4[7=_6-+K?RS=:EgQ3SgL<3>0HEJZ
13aHfbZ,NC.0b/QUY/(GU@,X)P]T-HY)YJ,<D2XCL.HFE>#4c-DJA/64\4I?OAUb
fFQE2K/L^(9Pb0OT,7/T]1(1f[I/9V0ILO0E>eXD#@-5=._FEgCc6G+PFI/-<D5_
9E;_>ZYbWd,(FH4CRWKWE/._Z3HBZ:\13(HZKEZATbH6<Xd21AaG<N;Z.;+M&J@K
9H^Ad^[Q3;36I9T.L_WIVd1^9aPE6\5bQA38;Q4aT/\(Z1b.W&:P)b,SdE<&/E87
A^G.8FOI<TK8e^]1SXE7O<O3+BA.[6PLdC4)RDP\,7J26g>N)5?=P,->^@]T]/CZ
SSd#\eF?cXKV.IGGUSGe:4b1fR(A_d:F5B)NW<bIGP0<C5.RMG,DIH<_K/,/LJ)<
XCTW9&7JCSa&J#)IB#e^eIH@@#M0I>3cdHNF/=&:.g<7230\RENI/ZG>U;8SELW>
OA-7[cN>5#\a]&T&JV5SB::dT0HcKF^54EdFH\D5+8,:QH186N=;-Q(8;<(@K?c&
23SZ/=]Q[V@;PZOGM(gS-gDJL)ZJ<+#F^XZR\^_C)U8HNYbRf=MSZZ#N9_AS0XBS
=V-6V(gL.bVIYfR(XG_AaC0g5Hg6]\(=7U0M<0b(N_WH(e:VI:W.(HXFKf-=2ec:
F-XF0<eIC9(IZ]D>R&Gf0OKCd4#AdF5>Y1;F?5=c15\Hb7cO)4e@@?LA&IQ(4Hdb
VU::/QI\[JQ<IFSB[bC[U[7_;8^](XQ.(MG^R;E3M+eZ06=5bD?B1]#^W8F)1R\6
E<,4X,@4^ZET3TU/S^=:Z=VA,>^O:5,?g419Me[G>)M-c-(F91,3G[3@YSA5D)?-
\PV;;RBe7R69OaD^6V_VZ0)BZ[<:0J++XTMOX0.\P]S=8)/K=H+bYFZJ3FTWA_fH
TKB^67dHfC/IL[6/:[]G0(X#bCf]dK->W+2RE\Q&#f:;L<#dT0DM.0^D?[d>P\A:
a;DKVU\4T2SY;:A<)V;T3;4LDd3#:J2M1)4.Q/Q6XO5N7)?(-d7,UW^SDC#Z=5PL
IbCQ4A18:(F;-4ZQB@C,AMV;gQO^CN83(Y3Jd^.H&=]&LD)\)]3SDbFG5_E5/g_e
Hb15D0\UYWeIH2][1b#5\U+gQ/V&YPTOC./JQ;2/P,O-996WYX;9dH4^RF/-R(BU
S[B+X)=:8+NW6@,)UGX<CWfFeHG2YGKSaJFWF8:+&cTI9LN.eP;\[cae>FM4)LJ=
_efL_]TVUeMNJcSLZ<CZOHVOI>ANdW(f7-YGSQ6e7AX=-,RT(1,#FYR]835U-aY/
;W[?8-gQ?.aeT-4>5bK^bA@Y]N9K36J?:Z5[)9^H;8<W(J-&EQSOfH@>][@T]GdS
Y0M81>\PA;2;A+I7)6@(J0BXT)WCZ8\P_DLPC1I_I-RUJ@[JO-BYUea.LD/af00M
L6D.Id.(GU[W\)_E;3@8Kb8WYOLSL(;AX+?X1L3N((T-EX,cBd09YA=X>ZDT+YY]
4O)4eW6)<ZW\+U\<N1U[RE]eTaQZC1^#5Y#XV,f/-U26[XK\cfMe-.NFUJ@QLOZB
IUd5;D(TL_+D,d3UWS::KL0D^DE?6Mf/Z5G&)P30./_7<4M-N6D\1-3E,<84:O?Y
#dLI413+U)b[d329_+2K@+LUMJ1QBg60:UBTcL#@I4F^;:3]/Z&:,?/9FF[))JH+
YK0N5+5^2<@RgA(1;#d^=eZY.)5ZM#T7=&_CL[eGEV9U[#fD[-AUZK8#L1^B<.QY
JO@635RF1EUU1;R>g-6AUFOXcCL,S46V/21QI]aECL<Z07SG#](;KV43b1XYRE&f
AGFN#eNAKJQS:,XefX0PBF#;&UOc7ce9Q7,D-L)TTO.7/7VHbO&@]PAO]3&.-LC-
[EO&VBH/b1X)PNg5EbVMgS0cKHd?dHBU>VAJFCSMLWIPf=eR^)#D:JA94CZP.Q\2
f]\[BJ46X&MF91gI=9;1/YD^gZa5@ag4g=IP:F-\YDEOR3198e6VW(E;?c\c5ESB
R:C9HH36,4=JFXC+3fMG4UHK4IW0H#;CTE037\M>a5Rb=6&26.W.CG3XGPgR0A7S
O&[E1G.G]5/>7f=]4;D[bJJ3O8UHT\9e-10&@H0f8FFB4]BWZXUa)\0bF&1LW9:,
_>]df5O:&CcVGd(P5]XT&,GF^T7VZcfC.&fK3&-(F\(e9e9.Y,FN:)515eaX32b,
3eNGe=6:bb]V0$
`endprotected

`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_ahb_slave_transaction) svt_ahb_slave_input_port_type;
  `vmm_atomic_gen(svt_ahb_slave_transaction, "VMM (Atomic) Generator for svt_ahb_slave_transaction data objects")
  `vmm_scenario_gen(svt_ahb_slave_transaction, "VMM (Scenario) Generator for svt_ahb_slave_transaction data objects")
`endif 

`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SV

