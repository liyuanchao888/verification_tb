
`ifndef GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_APB_SLAVE_CONFIGURATION_SV

typedef class svt_apb_system_configuration;

/**
 * Slave configuration class contains configuration information which is applicable to
 * individual APB slave components in the system component. Some of the important
 * information provided by port configuration class is:
 *   - Active/Passive mode of the slave component 
 *   - Enable/disable protocol checks 
 *   - Enable/disable port level coverage 
 *   - Virtual interface for the slave
 *   .
*/
class svt_apb_slave_configuration extends svt_apb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_apb_slave_if APB_SLAVE_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  APB_SLAVE_IF slave_if;
`endif

   /** A reference to the system configuration */
   svt_apb_system_configuration sys_cfg;

  /** Value identifies which slave index this slave is in the system
   * <b>type:</b> Static
   */
  int slave_id;
   
  /** 
   * Enables the internal memory of the slave.
   * Write data is written into the internal memory and read data is driven based on
   * the contents of the memory. The read and write into this memory is
   * performed by sequence svt_apb_slave_memory_sequence provided with VIP.
   *
   * <b>type:</b> Static
   */
  bit mem_enable = 1;

 /** 
  * Passive slave memory needs to be aware of the backdoor writes to memory.
  * Setting this configuration allows passive slave memory to be updated according to
  * PRDATA seen in the transaction coming from the slave. 
  *
  * <b>type:</b> Static
  */
 bit memory_update_for_read_xact_enable =1;


  /**
   * A timer which is started when a transaction starts. The timeout value is
   * specified in terms of time units. If the transaction does not complete by
   * the set time, an error is repoted. The timer is incremented by 1 every time
   * unit and is reset when the transaction ends.  If set to 0, the timer is not
   * started.
   */
  int slave_xact_inactivity_timeout = 0; 

  /** 
   * Sets the Default value of PREADY signal.
   * <b>type:</b> Static
   */
  bit default_pready = 0;
  
  /**
    * @groupname apb_coverage_protocol_checks
    * Enables positive or negative protocol checks coverage.
    * When set to '1', enables positive protocol checks coverage.
    * When set to '0', enables negative protocol checks coverage.
    * <b>type:</b> Static 
    */
  bit pass_check_cov = 1;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

//vcs_vip_protect
`protected
:0>[9:a89I406W(GI.H@1I[+I5E+QZI>b:6:#CRb<CIFfVC^6A]U6(@VOWG5O/gg
#:@0+2NUe&,?4E-FGX/AE:YL(Le2@gY9R)FD_bH5Q&,36d#;-KG[F=@VI$
`endprotected
  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_slave_configuration)
  extern function new (vmm_log log = null, APB_SLAVE_IF slave_if = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_apb_slave_configuration", APB_SLAVE_IF slave_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_slave_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int(slave_id, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(mem_enable, `SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(memory_update_for_read_xact_enable , `SVT_ALL_ON|`SVT_BIN)    
    `svt_field_int(slave_xact_inactivity_timeout, `SVT_ALL_ON|`SVT_NOCOPY)
    `svt_field_int(default_pready, `SVT_ALL_ON|`SVT_BIN)
  `svt_data_member_end(svt_apb_slave_configuration)


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
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the APB Port
   */
  extern function void set_slave_if(APB_SLAVE_IF slave_if);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

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
`else
  // ---------------------------------------------------------------------------
  /** Extend the copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
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

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_slave_configuration)
  `vmm_class_factory(svt_apb_slave_configuration)
`endif
endclass


`protected
e<QY4:)aG7&3?\T\7U.\M6ID@UR.;CcFN0Qdd=Xda=&9e2Q.JCd#0)B+eU/1FI<R
G]cG0?(5(WOe-^2-K&0_]7?5#D(c5=[A^5(5XQUT:E#eb9+YF7IbP+)SW,KCg\2)
#?1.7Z?.9T89VH9Ob9>R-,4NLEVQK3eEO^]HB<&aO]VNFfECf-R/4AQ5O^<[9GFI
6c>4f-B7f+XOYL)>=7WLXJ5#H#B6Y-DO;aV>0.?cB].]MDBTU5@c99K^CHH5L8SD
M#@FE)[85LOTA:aQO(aH]-6,T6QFBgbcb@D^(&HLRDb>#ag+9e>M8.[X&=15=8KI
[.f.+MdX9+PU_]_c>;dc[Q/Z#2?_;g#/Z&).bbe\Q9)TMOJG#KJN^[GQTa\^UZ63
XG(8,(&#a3XS,:e/=cS5#(Kc/H?)bNG(P8=N]YN<f09E5J4LeA2d.83?IJZD_=0D
EPc?.:5F4J?e:C0P:HK9b6gZ\Y\Kc0)S3(1-=<R+8/Yc89M[a2UJV]KOfJcFSKIT
Cg2=9G.1RI(b8e4g77EQK<H6G6d9)],Z(NfCd0^Ad\<.)E9XOA--09#\E.+9(.e-
ZPYZ7K>-:U0M@1O;/f7fA(Z2/Ie#9,=KJT)@--JI3f>91ISd^J(E,FgWgXQN3HMYU$
`endprotected

  
//vcs_vip_protect  
`protected
GYa)LULAE7;#gEaOTA6ICIgM^NV4feNM-)<Uc1](>[.Z+P]F8Xf[((Zc6[20A;S0
fS(=Z^;8ORYK=BM,[4V\HPgKMIWaRPFcZ8d1^8B+7@.5HNfYGPSQ,8-IUN@C(&?[
DFJ(JY4)L5:@<gPIE;#_3+75e)fd+6e3<+Q9@I[F_3\I9/AR^b@5TWfQg9M]H@RM
[KAKR:\.\eJMPQ/?T=5/Ob.&YA[)CB[^&MOd:P<,OGe5OC)5.6YD<KSN5E5g)@7]
I5S=A;ebYU;G?/aS-[;_bX-J3HaL,M#DBPYa3,cMfSF9FU1F[bX)5:P]S;K>)A;0
UL[AG)\R1?^H3TYSZS&?=KV7OD=C#a[3N6Z+]9Sb629@30AVS<;6?5U[4#a1DQV;
[VcfJXc:(;R6V5gHcEe(CIL-PMJ;Ga->QD=@T3(&,P-PQc#AM,@YOc(D.D?#_,]f
).+G5_3MTWZIA[T;&(\cNVQe2L[Be-?C7.a_[g)d,J(9TH(Be).E)6NE#Ig?<7CB
H)@^.JEVA:(&L8IaM4+@3Y7W]U=ReB:Y;fVLF=>XZ-;&BAa>4_THCWcW^#YRf@XT
#;NSde,(/WJ<YacBg<A42<YEFV+#fSTZEF1V)5R]SKLZ\++V55V<[]UR)?N2-GM7
^-XDFd=9OA:Q7N82ETP+]1&V#,W@X1F3];#e]_K<7I>_LR\HWCKC8,[1;@b31??+
+bZ,N+V[=c)PMTe>NL=ZH,ecB2HdSVF/6cY+VgC3E/CBcaZcg)-cH_CG-4ECNV5-
Ma9YTV6RX18;VWH<5?BN]1M6e96L?7US&PJ3Z?D+75:5W42V14:#NQNP)R3#0c&=
bFQSTWc?e-e^W&?H/UdCZ7YE:QVQ)&74fGa9AW@MWH])J@7gaG6#B)595aee,eGL
aA/\/aJ11;9@E(S0_FHO6=C.&0YD2_DbNLe-O:./:/I#/MJSWK=6cZKFG^[9VaUa
8TST;eI#2GB->PBc19916^BZ;2a/&g+0Z^f.I+_IGZ3Y@>f:#+&R@b3BH3>KCdP:
G6Y2IdZe@H/5TMXa&[[++9bLW?ePN;<c7g=CLR->Oagc+J;@>+QVO9+YVTZ7NH7]
66I:Yd]D=FKDGU?JEZ9+@HN(BPObG@H\H\&GNSVO:]A\(\BZ74HAE.:/f)=YKfZZ
=D)-@;@)dQ<14G>R()L.\V](=Z],;SdY6g5\1A)<40(VIA3E+Z)8LMMaZK3S5KBP
:H.(7Ig#/SWAX,U\>NOC2Q(/#(gD.74(<]JHGLE_[dY+GH/dWK9;PX4G:d8JR]HG
@?+T+(D5R6==(DKP^V9F0cJdGNgAY/EF?Z(&GGd9Q:^F8BBd.(KQbXa/XDIWJXM)
0d@c#I&,U1bP=TSg17QIS:UFcQ2c>JR?ga6DJ86P\:(83SNSR6&HI<]I<4_9<^g5
2-e,8JAS#CC_&\BLBEDg^b4HT<&H2J@T.4DSCL9;DMV,C:^f>Q(4^,;U?7[;H-&5
Q2P;GU(D;OWcT1\U9+@80BU7)BNU;0=-.C#&09-02[^1ZYbF?f>;>c^@&Ub5C71J
WK:f8XS,2)eK-ZT2&GK?L2e+H_@Y_M^5253RC7gQ/M?I>-dOB+AO/7.O_S\BGPX1
eUZXZ.TdM<0)B>M:?/+]d_3F.M,SASD(:b#&b,F#M14[eW90;a^LQ7K5eR:caL4&
ZC@;cO=/>R))7-4[K67<bL3S_:QdgVQ+SdH2SR8XQcQVL8JPK?a;(3[0)MP&J\F_
2;cF&dI:^0BMc21Z^>fe[g5#e[f\23&-f0c&b)=7JXXXOPZ+HGNaN4+gG(&V4J\9
8gB_5KSc\OU)UJKIV,PQI]F00[^0=:@d[6VF]NNYQA1?1E&MOZU=&-E6.AXA(=.I
PF;_,2FB5J>B]AXd(O<QD6-TZAXTTMLP2U3I7[QST(:T^Pa9TZ>T[2SVbIT?-X(Q
fO(0/03530aTLL]e?Ob7@Ga0_]KgP.d=.]#>62GUf>](fHA)=7F:=KT8YI2(K.+e
bIH>e2_9#XL#cF_aIPaV2<,;/76SPMP4EVUM-]D+F.EM\_,U_dOZ^I;^[+,/PFO\
9ORg[C6#<b:CW)Q:)#GU8E7#/C;YNI2\;81&N(_/[/AAMN]5Y>T3DT55OWL.UK;=
F+.@,#4K@X/=13d4BEFH0F^F]e825&[<8Y,W/?fdP^d(8-VBET>.RA<RAE.0(R3G
7PDXOO/+=16@.(U>X[&.+63bcU6-fFTLP5[^dE?#cDcU.d2>J9<:QZNBYF5B1T40
FeZN+@)2.ccP1=@cD/K<HRDZPQFL<R0-6W5B@gE[;LYH:IRLS]J).LX]BcO+AeE5
ISHQH]:]#D,NcdDcM;08aG)U/BcfDSeDG,K8/AKR/_)[M3b,-Qe7_?R]7)VI\N.Q
5N?c#_;>1fH1-B><bg;c+80E9_3#:ULD:]@X3bP]@4W2VN^BD)Z,gB;3MH]VC6fC
.DTB7V-^BVeWD^\1Y4MKY&2BT->7B5LAQ?REcbgN5[D(BJ_JJdHPU\6<1[F(:&LZ
8A33X5IT4^IAI9fCF@USIgXZG741R)DD+9Fa>7E#O:_3bVERPf27<E2LO_cTR<=]
,QcCGBR:@7U1Q,7/1EN@S&g):e]KI4^H43[Hf:T@TEK<c.-E0bbOME7D50/;:dC:
DYB)K9>I4GHV:3E-[E<V#TPL20e2DNVI+#7T6>J<IafLg#&]bKW&=6-)/9,fQ83?
N1OKI@Z?_DDJ()F.6O:/KM-Uad/\@+5KCLFM@RGI#VU7X+b>eMVb(cXb^P>R([D>
fc.BX?ge5]+][c10H7P8K<-aaI;EP?>BYdMUIgd&7U3Lg:^6+&\g1a4TC#-E.)eg
cYcYSbg><57,_+7]e7H?X-+5=JEX96PdCUU7)1W7<4&:7]d-(+7NR9WfQf_4TD9B
Z+=R5G/+^[Qc?(a5&+=]TUKKdRD>AEWL0/?<JGYXa1.@:IML/=f@)/EMbGYFbK_O
Me(D?c:_bV?H1S=0FS=;E3<W8I[4/T2N@9I5XLc([JXYJEG;PS,=#@>N2\=2IWfQ
=#;IF68[cG_If<2WTUc&.HZ;P9X:=aZYB4b[JB0f@WUI]U>c:/)-aGRZc9BaCA=3
>W4048a)7^f>?A8DE38&/@b,fTbg_34Q/fWP0Gb>_a&9471:(2eVQ5<UYb(F5#d4
Sb)C@MPPS<J#O\6VCJ/U#&bUO.<08b+^APPg+cUCZWbL#c64SMS#N.?>D)SLHfNf
G1dDD4NQc-1df>>JP]WA2Q:8;(,CH#gG9,O]\O?GT^:3+P\S4cRXbbaZD5\a8A.N
@/1aZG06]R0eI=?[Lg:UXCNA0/D?/]+g\QK2(?^2+D#I-fLIKaHWG]3,XS71_,bE
OHNeX^KPO#c-T.dHT)G]Y;H&gX[<2^YBWMB\.E>7TPaZSV<ZTHL.+d5V4?4_H76J
2VJ3g^MOE;I+8.=Z-K.2QWD//ZLV2.g+/7RbHUaQa[TPD5R;9NN-cbf=F>J3B5M+
6Ib)O[WbZW<-6D0]XYHO-.2QQW.;dJJXMZdD.TVY+4&L:QXf[)^f+H?-1Ea0H?<V
:]](Jb9HD3aAae?L\E^[TIaJMRHNO5bW-d:[T;f,=@A8O-(G1<:?ad4RTd3/6Q2^
ATYNNH1VgBe4L7O9#gCF5;6VF\]gf_8QT1b/LDfJF<Mc0=Fb[;U/eW(fZ&AG6?S(
-#P8SY[4=V=<J(>&.M4H=f#M[XCG,(TL\R80<PTX3BPKaH.;@_34H8)6Lb#GG>eb
6K8cI_7Og_TZe++@3VVADMV?GNfa]<caA^-)?UHOL;\3+CWDL?8Q5BKG#gWBH5]&
3fSA8\da=RRQJG;+d<+dMSI6F,C\#+1JDe61If1H1gXSNO0:eX[[\,N=^f)@JFd)
^)Q4G[6MRIQSS#Na2GK1dV=/[69IYeOHIG.+a:W,S=UIJAURQ=VRTg8&JXT>Q#Q\
921d?FDcdGCAO_B2S>@E&T4Zb&DF]&5d[:(87>SIS?X?f#:A,=XH[]21_U#2OTY^
DI_#g;WZa@2=@G?JE1[G-(-XJ)6.\P=TAcO6<QI+eS)Y:@L&Z.;LQ/OTC:;.6<?M
9&[G#-AHI3C@8&9\L9W4XS@WQAL73O.APC9]ffJ3:2GS1FEN3>@=U6JeYH<bMOAB
gN](1PFcb60L(#a?>13Wg2V0VTWSgfT/+PZAEB--^4(0I3FRG<]4a)dQG:J_:FPb
G@Za3eG5e156Zb.C@MP_bU87P;N<&A64#PBL)[[cN@CD\BAc1.=d1R;>@PT0TRWY
N\<HdQbLIH_VA4,+BJT1)IYCPD9#FH>9I_35Q06(7Q6HTB?@@;6PXSV,ZMIX-_=V
]aVL<6dGeRD9+[)@HXe,2SbX(#dMBUbU?/^BUJQ49O]70]4KDLa<eP>J8-K)\4DM
3F6EA<d,gVURQP3MfD,_H0[-M3OT_B.c=#&PId,cOb8g(R.C?5(+c5^]dNC,-5/-
-E:&.?;ERU9I592W_+SA8d<A_XL-?0S^f\KC<4F)R>6<fU8GM<[I0,G=AY42<[F1
H<;<:c(3fXCeT98M1]XF>RYAHbJ\fJ)2WL1;YFHE067:C]7e1(1MT)d?g/F71:W/
d.#SE\Q4/H=^LHaN<^0ZZKP\3PI7]Y#d-QL)d=B6;THHZD0a;K1EB^4e1:9AMSGQ
JIM&e_L?24XW(7CTPOTDYf]UB1Z.[\Z253GYYJc6Zg[@;0bgdbUW=?4c,f#e9We>
Q\)a#GA=UP&MfOA^DDcXU<9<aaEP\Nd7[eU<TA2J0W_6dcCU3XT4@?1H\WJ=b[3#
ZR]?79UW=>.LSVLY>Z+&/+e[ZU2XN<QP4L<\N#+dX[e/Vf5(gM5BN2SMdALADHRO
e>Ef^;B:/EWXCQH.XWDO8D[eAJ1<\b;/GMS)X2&&-@@\:FY97B&8L4Y<4+g@O]NW
Q6)b&;9-9Tb_>YLN1KEY8E^GQNTU^?Mg.U\I5dc=,Sbb:VH/31c^,53fOf(XT_X+
&6P,E6NV#cR-22<OXPWT_\X]##4).Wa1DX067VV_Y0NA4P37EaJ;a.PWe>]/KK[S
:K8FDP_LH2g?0;(YOYKB5;JeZ6eGPAR)VWDM#7;P)d_8;23Wc^C,<M,B2=K<fU3G
bA_T@[XUWGVeT3XdRM+e8fQSbJ94<XXYbFO8&54=b7A,0CLAJ.5S=0_TQGC/4NLT
3^L=VG9GDHBNQH=#d]18)0Fd5N^.A_V+QZBeb3G/UV]aW=-L:1&4SX#a-1H,:e[/
_d92W#](\0M_\AJ^?,5KQ8)(.ASD(09f?[7,RDf+_a@R6fV9C2/Ie<^#9AXaHc[e
#[]#&2gNV)DOe+S=3CDX>PJ,Afe4ZZWWfS^G-K_ZC4-L9>X44#K4[eL:^D/=15cb
:DF5a&Ue/^TI?^T@>4^,BeV]Q0+Y4ED<f8W7Wg.SdH.ACWJ]#.;1a/7XI35GS^Ea
Va7c(]AR@?)9.Sc?]GYKPT9;5Y.eOf4NBD8LVH4(#8;]dd,?DCc6Z^;NSM5DG&6C
B_Xg/DSL?e^-31LDV-BPOX\:C[-FF]/B<MCE)d24]H2T^&U55]3]:Nd@0XT:+(bG
Eg1dZU;;H(=1X5OK+G0RURZ3F#S]UC)6L69.c_6=<4-5YGO,,a-f@AW9eK_aA1GH
G,;L>3I8NP2?=ID_XC;:1&H,33LY+_bBc=Z(:#K=-8ZE#<2@fc\b.OeE6HM/Y&E>
#J=aIA>U-YI^]IFADTQ)G.FAN<8L44H?-,LS;efHg;H\76&37;<W_D29=;\@cdV<
<+EXOBP^>/GKEF<g5Tc,9U7HcR)bNU3=GN>:K7J>dRa0,2OT1W7TPUf+7+1PK:L4
2Ic?+UgW_WE,;;C7.+faEJF@7\S2S[=+fSPHD:[3+<9(_.VOPPVd4c5&NE^]fIVX
_+NJ:c+XK91&_\f0QD/(V#JVB,gUX,S@cSUHS[NA:b?CeT4\Jg6O]TU:c3ED[^FQ
dX(2N=OTJ([I4>;&&:,MfVgD8M_-,H5<<68)URF,5,LXFd.(K-5=/cNWX/dBbccf
GU0I;08&]6EVIP9g-.9S6EUZg_Cg<V)b53\AHANQD=D>_bC>N<7c\>[NMdIPSJFU
2[@;?P?EEPVD)-F9ZA#8F]=\8d<QU1JPX&I+d+H:E)Q4^HcGe2JLWF@,FT-&:BK2
ILd\8F#?DJKa.e2&L+I+>@L<^P?R0SLeg.@YQ@e1&V(+f+ecM83];/g9I71-/HS3
4AL2<5NM;96RKe)[P>KgMOScFS2B1@8Y7C6?&3;.H4^4#(aTc3eb^NDX-RWB#bIM
L-[),B)TA,-PDS3W+>8^Q[S@J5EC(8BRNS<N9X\Lb[+NI=PDbUFJaL)NY8S=a>AA
b]PIX)U7UaC,+QC-#2)BD[,.9dJd^-/PGIe?5Ne;6[BaNEVfZ,0^b61^P98,)@;?
VQg,^@-).D9.,f>\O6[Nbd0,&)P67HPNHSWU8]\=;5cGc)DbUA(aS>>OHC-eSbFB
KMbS=&-72[?WN#)(eL(;RUHCEPG-&KY,b[GX[e]50FRCaA,E\IcgdQ;7Fad+1@17
bM/O,P_0V(bV:/aF)P9P]T]0Q;YAP#?#+99ZBbg0)SF.W[=4-#gRDY_aRKB[S-]g
T^ZAf4UB2PTGX?W.??-=Z),&9K4Ia<179B]b\Z\-T]4:3DOT0WOC1)G8dH\I,F]&
La&O7#V4Z]IKQ/()OW6b>B\Y.9\=BP]H;B->46LST7-K9<[1A?T?Q(D6.I#=Ng3&
g#ZB-#LL35I)9H<)5H?NT-4].E(25R>@=/YX6OMS+XW_f)EL>Ra,6O2SC/dac&?E
R1SH7b98BA?.3,16bCH_59eaFS@c;[_fc\FJ5/B,TH&BaTbg[Z<L7Y(cT.K&HKX<
VH/A2bJG8:+XG-Q?1D1D;;RAQ)>9:2#g\Lce(+(fbH,2BGZ>R[L?V([ZD60.XEeH
^Q-H:J_:BbN^<I/<Q8>Z[>SMGcO^Z\?XC&(aJ-Ka?W8Z^H?MEN>fdLXPZHW0T2+3
GbM^A07c/H@11Y8b16[NB>4_dMa,3TVCR/7+M<1XO?c_4=9ZC#0^0(B[XgAX2e^b
TO5a75L[BP8I)bZJHFa2XB38X/YM2d\V+:45_D)>/417f?O=WJ#?16F5FHda&fW@
c#8-.H72PL[EM\^T_afH/+4.]-?,0F[ZTXVZF=]+afefQbG6-4>[6)H\A[ZFRgNJ
WH9a15_S#RX:P/7d\MDTVeQN/KTZJ0LTdg=H2C\9aZZ_R)K[&S]C+BECaScWYed#
-a]1R0A801.+Q:10;SAXD#-,436ACA:5B\7>N8[7:<-AG#>/@LLgYg\>=MOdD03I
6F#88;VZWS:U.=O&S##0G2gVR:^bP]028FI\]H:6_K.Gf6HH<cN7L[bV;bccgV:_
e>9CNdWR7+gXA[].<)&FQBA[]&F.#9]PC8_@EE_YB88;6,IQ4+(ZeB1B4(3e<_>A
\P4e32O?==[1Qd8FMKJIa:7;T3Cd.g@+g&[Tf9Dg90Oc+U2>?T;B,4gb[4ddCH)_
Q&?Ea<QL6eYdWfJ;d?#3?dgb@D>7I9fN6S_B+#ZDf?NRG-QIHLZd<eHBJ^>gN7J;
[>#X[-UU;#A>OgX;/2>Vc43<CPcPQR60Y-,X652,b),R@+ALLVNRgU?Da3#-J;aL
Q,3gDABW#<>d<0KM;c\<J>1_=E@5P>JDI=,HZB>)edFP&:2A\YVJVde);24Y8Tce
]A(a3dVF8-C.XIY(:>M_B(LXa<+&PNW+HEO^gfe\Z@CBMcU+(S[:/(geR1GPPZI&
L1H0ON7Y-NSAYBdbFWdCF)BfF&f<Sc^#-<#DD]aO/16eLUJNe6L(1KaOSVNOdTPW
Qg\.7KEc#H:ZN:,6?a9ZbV<C4UUV3A+=^V=g.64FI=L)0Ag5IZfgJ/8L9f)08BJ4
D:IT2HIIb[IWR_YJ0d^b;JfA+TN.Xd8YGTPYY__HadbU+_2N2b,?]&Hf/#BE9ZN<
]^b.FA\-+.R&-3b&LGG)GSTW?8UBBR^\;.9]a?3M8]cSaa=AK4E]B4=^[DW=ZH7S
^\d\LfdG<CGO?dR]+8BL7.L;22e\\_Z6[f:fABLR5ZEcVcWcZMc1gC]C-/D.g?6J
8Dgb&ZM1)3@)[O0?Z=;)-L_Xf_@2Da&aU2dQgeZdRT[/[]PGfAccNg6>8(C^]>6^
E;=GfTdXE[:[I4F4KFYQDc_[98<cV6Q>d1cKQ/5H\<(-EF\YW>b:I(E;dfP1G9fL
_J3O\df;+B5)-dCMKE=5X<c2\6/b;F^/WB\D&=c6V]&1.TWe<T,.dcS:=<dE>4EX
T^OgJGPbN.6]2B+HCfdPC?gR@G6C)5^E<D[3/[9(Qc/b-<f+L>]cZ<;\a;@8MU[P
/W++R?f4QQ\SMfX.I4-HW]CCB&b@-d8#G)Y#fK@c2HY/<\PG(QX)SIU<cF[[]/9S
,MP^A[gY(-#EL.8BDG)B_2G<\ce)+L4E[e[0Z4J?WKTW7gK7#J+]\\9dXI&2Pd5P
#ZQJPHP(4@[:EWZ/>feIQX[_6U@e2?^Q3)XM?C\D#R:5(0;V^\83QbV^bdT7gOU(
)/WXTU<(NQ3WXJeF^3ER,fAFHIf<?9,d\=cHc/S2>b7[d+?&&:(Z1H5/?-;fV^AG
G/&<02VJJ[5B[@f5Z8>e2[(+ECe;#dP=E?QaLCI\\<&-73E=WCPB(^_K&T4DWWNa
R3g5?E6gW?1]6cICJ7,-DOV12N:S9O\4Q_</IGQd,)E;EK^9&g8<X1A)=0FOR@#T
/F91OB-a.KdbM?(CD4-PT4G=.\C^1QV?UJgST0>^P9\DKDWMT#\+/SE;_Uf&MT:5
-9Q0[fJ7S4VUg)#\e&P:T2cJ6DNZPKW/dH8Zg8NK8Z:JZ^\136_:_1@Q]#c&gf4K
WKF?\K&\G^LXcJ,F,X<<Q>QJC;@2fUP&-c7>RP&YLgBFN^9WZYJMMF;8VG@+e01?
=3^V]Z4^,[=d5D4C6V\D[1Ndd;(g65@NFEegA-3Y4V6_>f[8XX/1QQ?Z)&;\<_e_
TaWNA[[;4g<4TY/4b>6^@(Of:#c?=8=TO]B-U,E_T^RX=(S<M+U+cbD2#6+JIE9_
6OL6SF+99QL@E:97NK\(H^.;+Bb?H,L.NTP6K)f^,Y;N=YZ6(gS_;K[I;aM>RUfc
>>9=:VY#+^d_7;&S(7:ZK.<f6K6,K&>L+44=M2,_f^52U0gEQ::B2[b9<PNDV@#4
HNMZA;]YFWe^5YbS/6DX9==;a6977D+&;^TTV)(AW[Aa+KW30W8a758F=#/1aFac
#>98B4].K7]J/_E2LAaG24b4=Z22fc5@O=@8@7,CC9gTc:P:6W,\4^I8eg1?._G7
9B6>_BK^:b>/_eA.c-1[f67(CCU#Cf:@D&.\;O<3(]\4a<e+2+8N6AGIR\P[OL_f
&@de52>^QcM<D#7YYNbV:KKcTc5UO0F89-=7QP,8dR5M^H_DX+gDELQ<U6]5I#Y/
&&:WUP/A:1A2Z^7GFf>>MJ.SJPfA^.Ib.6VN_0J&(,#4,C1FP8-7aF=a]D_==;ZN
CI=OO^@WD?Od8]dd<=KTDV8T1?13H1eX+0ATBICgY=76UTJ1_9UdGK5;A_JMXZ9I
a3&T@]OV30[9b+SPd[4.N@?gF7#.1C/_@0B,.@XEGgf\-+\\g\/_-;O4I1>)7^OG
DBA[DXEa,Ea?2a<9E3(_<)DGfaK?L^]<+<[N^VOTW2X5_)FGa@9Va3LPJDdM^1A<
5ZcC_:ZCV;8<<^EI&1:Sb<+<V3ERBgJTI7C+B9Uf+Y]?cg)U[Lg^U_GN>375D<U0
d/@4/1=IR)c?K,(bFXT_cFgQgBY@V;=0MI=BI<S8&M>+1a/#BPg^08NNG+G.e8LN
Z7HNg^;2N2M@)G=Y=-AWQGX:]X^YYKbFVWI5W/;-71>g15]edg7CV-Bf_969EQC)
&:=#;8S&TIR2Ke;[:OVB-^JT^1W4bT2A;X<-P9c2X#cWNPW1>VfAOR?=#.1HH9ZR
>N]D^.=ge^faUU4B=:U>X29F1[<F]A_a3NGcQ(R=U;GT^a]GS[G&9LRR;\SP;.e/
IHX,0:J5S4Idg:>b_WOB72PYRZ7b>21-1&=>-T#]08G?.\?W7..0eTdZZ5ZK#a/Q
8>LB@6e;XW6<2E&=4.+RK+a=/[)PAI=VBFeE.aJEZINLM71GaTFOMV[ZNMH;-(>a
83^cBIW^;G?=E2@FJ?/5WL^ZAH7K#f?g0TOB-#g^N7fY@]V;QfJE[73@:NOJ44g0
RHB68Qg(D[M(?#5QYG^MZ:&&\4bfWe1N)3H5^?#fS?bM5+Me,=G)(;f[,5^Gd_S/
9&bCIbMF75\#AMO9)La/HF7J-VB#fP(L9K,fI&WBeK(#Rd_>&01+L#,5a1_[#O)_
4F^94P3T1QDR2EMf0MG->)9A2>M@2fFV?bLZ/dd&,IbK>:F.cT87GA5]f#K<R?1,
D^]7)&JDVR7g]:KR]F<OR7YRQ\(N@b>NSObB_3THWc77H?J5T?U)M80D^>dH/M=U
<MDS(<S@LP6C,W.Kb74.E7adReQ3C-H:Qe4f^LREH#=2[&@1=?LE\2d32@RABJ>G
L60__PbN2B>0Ee82\Q\4f]Ga[9.g/N@V7WLG35#B0#(92ZWF9\]\QDcM1RIcPf[g
K,N97:3L#T/#3#M?e]+gR@S42cUZ^fU@c9L2;)R;gb@(.8bKSIV&:X+4@(IMTJS\
OACLb1@Z,;>\cDLV#,UQgM5T0=&G)F&4-g(SXAdd;PaRW8-/):5SgA41.bC?97>Z
852A?A,0X\?8Q1#cB_ZCX<UN+_P5+K6L3CU4)-A83OS3:=9]cU6E@#3.Q(?.HdHD
4C4/W_=R1IE#QbN#61,&?ObLgDf+7_)7(Z:,DL=9D,V&5A,4N2e03dffE46g-)X3
FgbCe=1Y#]_T.4/D(B+_E&4S@_9,7OfR1=1A8f#,b<<3dcT/?4@73B,A/6g8K<\<
F,6GLa-1&e/_DK2_[S<fBJdA_.\B4G=C8JJ4P94U3c>3PE=U/B&ZLbA>]D)@1MJJ
+9^Q]K,L:C=B2-GJ37#F+X7(2:3#GJ]gR&Ie92ZfK3_P?2-LH5U7;-._[80<H0]E
ZEV5>R,P)G1)6,>Q(,fKOY\1OM;f,VQNSfV6H.W<6NU-g)8:YbE#=@7[Vf48BWV9
6[8BC-L:N1P#6>-,8[T_d&CGM#WgN&3L<$
`endprotected


`protected
f=.6e^[T[RcWf=?LV>2>+A92N]MGa^X9LXKCS_].=g:3GfPP(c+d7)X3@J/=8_GM
0^P_&BaBK17W,$
`endprotected

//vcs_vip_protect
`protected
5JB&dC46L)<DY3Y829WfGPJW#5X3_(VcN37+.H.J:,0-@[=(?Of[-(JR>X[@MUBb
g)R6E);YZYEIH5JJd4:I4[GNbYM=66XSIP\1#<7(IP-7HB4ZQ[e9A1<&e=O44(&#
37K5Z[IA-1a\5/#H4d7I\5;d_D5W^[<&Dg5FA0NP]S\H]6<[MG^45g?=C]adEW[N
A:8;NJY-fUUAg;DP6AH#^O0,XS>FgWX:9-JUAOJ6MUUaW(UOK([E;?KI^P&#8bBR
?cE.@R^^02/58KPZ=g4A#/3#O6?,e81(N5N#CX0c=RRS\PQ9Te#+NU9<K&G]])d#
:V@RI?SUSR=(A;P;VM7Fd=4;aUd-+1:[^g.ZM^?6(Q[EZ@LAV20XZJ\X6PSZ-T4L
aCTM9DU@&\@6NY(cH^;T4H3;HU7B,EER^c&D=5D>QWULT++(@&6L,>9]&S_MFY[7
/BB<T(C&@Z^B5g)_6EO@Q7<XcW]:;F9\3QcE,N)P6IRS#VNU&4=.OF=_785Rc9.+
IN4\PN3>\G:R6AIYFF3fO;&GPYC[]WHTN15\9G&CKUc[=1V_0IR;a&<X>D#?&I8a
a63J)\Q>Xd=EUbRb-B]1.(,C3KTC5J:T,(F&@UZ+B0>2c<cO=8ScAb64?_<CXPR&
:7:cWOS>N/+(P8N]X:G\MO)MU\cQI;[DHS[Y2&E=CKcGR>5d0C@8^cK6bZ?0CG=N
J5&VJY/^=.eeY<,gLFQ@.e4YLPG.()M9XcR#egKX3E;7=X^C5.FQHYCcLHdE9Z79
M-W.a/-+I9O26J+ZJJB5F3B2WeEMf\\XeU#ccMGVfD>_gP-T.:<GK^?#LG;a7?+g
cOPN4[/NIM9O)G6Cb8GcG#7_WK_?f07+25ZBVc>aB@3<\NVg7c.H6c/8\0H1@:ZT
KKT9Y((NR/BcS<Jd2LNF[^M?)Tbf(P12H_a/a/DM03/3(M^4]F]_Z2:K[bR]YE;F
5f1,N^N/WfH)1@:WKH3HU,XN8BVX#(cgMIE9WgAa&]7&gdf]e4^J6]a/ag>(GdCJ
/^3-43A5U>CPYg_XUJPbIgI-XMZ=NWfgf<TV?2V6g-)Y3dg4ML?Y)Q2#33(RXG:9
G8?e)H:d&BbcW7?1U.M[,5RQ^O]PPg;e4g;B]-_Y5RWL]BEUa_=3dM\:T2QUYF0]
/XNIS^Ld,+(X:Mga[c6Y-@I2GG3YV]8&KQMKcPV>:N7[a?9M_=>)R/R(9e]^6_1;
2CgeaM/E:-VL^6O8_/0[ZX&D[/#MO8+11g>:FMB,96VWNQa)4gg<>V<O;B,@W/]g
WcI2ac1VVKL1ZQBg?L-N2H:O3c5-I,^,9LQN(4,UYWX^3Oab^SU^DggSG/F)1I@Y
KB/)W,2I>>aO>M)T9Yc7,a4X,1;c8I#A410X057/FFUPTZOETb#A6NDIIU,ZfMD:
5>#>2S>+9QII@XDIRaaO3?(8SUQ<E:0&SA;\RB87:Q2dA17,9)=LSf6J^[3MJ5&]
-[Q7?-T[E:G(SX3ZSg\/K1&Dg/D/8-/T].7d_T0_eVcHIgJg4-FG7&14C/[\X^Jc
@a\@CQM/R=RO8K/d<gb:gRKAE+fXg75Q=+g1I>[971_(#L#VGDSOW9=G.=3R4X65
(3DF9/</E\G0B?Ue]RaBGHKA5$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_CONFIGURATION_SV
