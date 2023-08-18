
`ifndef GUARD_SVT_APB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_APB_SLAVE_TRANSACTION_SV

/**
 * This is the slave transaction class which contains slave specific transaction
 * class members, and constraints.
 *
 * The svt_transaction also contains a handle to configuration object of type
 * #svt_apb_slave_configuration, which provides the configuration of the slave
 * port on which this transaction would be applied. The port configuration is
 * used during randomizing the transaction.
 */
class svt_apb_slave_transaction extends svt_apb_transaction;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** A reference to the system configuration */
  svt_apb_slave_configuration cfg;

  /**
   * Weight used to control distribution of num_wait_cycles to 0 within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int ZERO_WAIT_CYCLES_wt = 7;

   /**
   * Weight used to control distribution of shorter waits within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int SHORT_WAIT_CYCLES_wt = 2;


   /**
   * Weight used to control distribution of longer waits within transaction
   * generation.
   *
   * This controls the distribution of the number of wait cycles using the
   * #num_wait_cycles field
   */
  int LONG_WAIT_CYCLES_wt = 1;

  /** @cond PRIVATE */
  /**
   * Indicates that the data read from apb_slave_mem contains X.
   */
  bit 			    read_data_contains_x;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
`protected
Td?5=d8[>]^d\3BdR9.(5_&Y=Y4(FZ;XBW@VN=gMYD[^?eC,X_7/((4HPEDN7E;O
?7[Y>I?-SHB+DaK22/S2g313TE8eT)Z9b#W1I/:[_?\BRF:3;R_D7Eb5IdBT2&<f
Q5#g8/HJ]Y^&BQd-_Z#UD3BdZR9<55D7PC[K(/aI8J2>RgXHAgH=Fc-5S^B3HVU#
Tc<+_e9N>^L7NX=;;@g?9=2HRU(dVUO7?E]fG#CG@F:6^7gS&R=^XOGD:+&U[U#>
-]V3S]UCOgP3f@2[CT>[3aCYGa.5fNbKUDK+U]4WQe?5O6DSZ[SQ2IOL48@;1U;6
_caY+ZL?OE5+<a^>g_]+]-UWM/>3]R1&55BE(=.FC\>?EM[3V-DB#>&gEF@,-2Ud
3L;AE&\=aJJf[JO4_)PIUCGSR0]_>N\g+@3B0D4R#[RPg&b-)>\8L3NKDcJ]Q,,D
W9FIIaS5KXO-b,7I_7KMH/XYPI1_>bMDRZF7gYY02:V1OB>>0dfZ>(F<3)9<472Z
BY3/?+K?dJV3#C-I19.?=XKY[AO^B=ffG)FHgaF2-WF.\cDf3[.<IKKbIW<X&b:F
bG/fTMP61/.dNCPF/6_-7RVg+-aAO,?IPJ1DI.c@5WW\EgEGWGSOVgC/[0?F<7(e
1VAKafRY?WZMZ&@2U^JXA=d^gWBD#&.c+CD32@0MNbT_FFNME[-D7<d)[b:ffBbC
\ORM2<[EaId\KJ[:KQOT_9214?gP8HC7ZEcG(9N15MFO=d(J>;-[ZFCTK?4+>6?5
.;VU>Ce4[S.dJg4b+T8STHfCLTI_Mf3=,Z0],24R11->2,-_LP(0#04J1.+C7e67
NFSf7A@VLEGEbI57H<)V9?T>VS4e-@O/f#(9BO<6>^dN=B21;2RHM^Ud5CLLPCET
V0/1BCV=((&W&)+dW6Y3Y5T>6$
`endprotected
  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_slave_transaction)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_slave_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_slave_transaction)
    `svt_field_int(ZERO_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(SHORT_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(LONG_WAIT_CYCLES_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_object(cfg,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int(read_data_contains_x,  `SVT_ALL_ON | `SVT_HEX | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_apb_slave_transaction)


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
   * Method to control post_randomize
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);
`endif

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
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

 // -----------------------------------------------------------------------------
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
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

 //------------------------------------------------------------------------------
   /** This method returns a string indication unique identification value
   * for object .
   */
  extern virtual function string get_uid();
  
 // ---------------------------------------------------------------------------
  /** Sets the configuration property */
  extern function void set_cfg(svt_apb_slave_configuration cfg);
  
 // ---------------------------------------------------------------------------
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

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

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
`endif 

  /** Ensures that the configuration is valid */
  extern function void pre_randomize ();

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_slave_transaction)
  `vmm_class_factory(svt_apb_slave_transaction)
`endif
endclass


`protected
7WIW92gMde;FJRbE88?NEPT6b,9663ZAJR7]b7R15^0-2XCgNOM9))TJWPb__5KL
LB]DYS\2DI-:4Agb[;)^aG6(@YB]><?<S)4M59DBJ;@-7GGPd.5DX?D6GA366)^_
a8D78Seb,GPUfJQKD@R3W(HR\EQJ0;AD/FFZb3c^-=@GbZJ4VDg36[=Sd2ZH(4VU
31f4XJMRf>;S9=,D4;;0,^KO+S3)>BNCM8[[L>dS.V=X#/1#ALJJ]C_^^8>7Db<a
3MPDH+T6H#OLUULRXR&A1-eXHeK.4]<)?._2]&&RZI7Ee7L:UP@d48[:W];]]@&c
e8?#=dN1^2H^_4GOGH7=-WYJOSe#I7]K_P-4O<L[aMN8?UZ8;Uc)KJg)F,&6f\&e
U84]\8N#G[Z:T;R_?UBQTdE3AT5.C#I(#]P.fK5D7T:RSCWF8a?8UW;2LTg?L[44
^VRI=0a25R#CMDAbA<dXG(B;[3c,SI\c4b7)7-7HO?-AQ\RZP-.R-c)<e9I=U@-G
a;IULNV=K,(S(,W=e]K,EFK+]?S0LW)M[>Ye)P=0>&+g5\\6PJ&c9-DUBHO2cVg[
IF)I)XK?Z<_fRPZ2I&9^C9PH>6bNd.@G?$
`endprotected

  
//vcs_vip_protect
`protected
^P/B[6b[Yc:]#_SHegI?]31Ca6_D>^+/F@R&Y7#M3[a7YTUbT8=U+(\,HK[M?bfU
+1VF1cJ[c+bJa9^7c^A-aI]^B;^CYO5=[ZVSPCABPBMM(2H\;Y)gaI:HB6af8M18
R[P9VXQS&-HE>/\=N(81--FMDFOPO;^?Od8AG1H(]WJ>5ZReI4;Yb2-S_YV0PP7;
[L9K(?>S.&D&E80f<f4LVJ5-/\\TE^SI)@#R4_YZgL>Z>d8P^Y@6Q?,(1bEQ3X>e
;;#a5M+XJT)26O6c5BMH6/.>E<GR@2FU7]MVZC:fYA<(T2CXbO=N,DS\K_MXV=[a
/++Q&QC,<)TRBcN8_4+AZ3R;M@@B47]GL^9UY3=CH7EQc>5+d>:Of7JL^Q.-M]Q_
]W\5UD,=FW+VaM3,8B:+ObUa]2Q;WO<bc4Meb5Xg3d7-IbH.(<W&B@CPV,NDVC(d
/J5&\_Y:Z=FDPN[_@VD.+ILI[9T+;-0VPCEX.X6;[=.WJLL1V?\MRUH2U1]\FF<1
8Z5-9Kf5bAS=R_<f/OE)+&1T5XI.,92caZBT6GSeOS>P.8+HK,7GR#[:-WMM4S@:
2Ke\W&B?PW-4<4#W0=[LV]d-F;&&7D_8HJ8Wa[L>]=7_OZMV3JYV(;UJ9gS14R.V
G>TYQe83ANg)#_,Dc22NQ_]g=I/gI5<Z:3KHD+f\aMNdGFUbTX1f.2;K8-.-Vb33
Rg;O6eaN936),$
`endprotected

// -----------------------------------------------------------------------------
function void svt_apb_slave_transaction::post_randomize();
`protected
D=UT/[U[)HM:4bP1KFDCWQ+>>O;;gg>.E+a#?P[^A=?fT)BdT^H[.)P.P#.I+<XK
b4^GYYe,Q0/&9\_aa(<0^I5=\]5IG2&\BZM&9F-,16NPP##\eRB]_368Z+]#cICg
UAQc1<5<3M)J/Y]ZKC:Y\+@39E;TYPCf.&X)\Z5OVG^Gb^GgRBR+N=f8MbKZ1T,d
\,A9V(>ZD(46S_&>a;4HZ+[P&7;GJ0RG<H@(VAN+PWH-8=D9TRA3Vd\1ZcJP]4L:
9TCdHgH0M4N>G+Z-U_;8,f,0>e5=74,O>$
`endprotected

endfunction
// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
;LN@=a[A03L-Oa(_&W=fZY5_G^SM1;C67A;;N#N&2DfSbfE3R7YE5(++e?Z?U>LL
4_7[3KO>T-MB/R/eZOL]JQ6J<=5,GRe:-&7gb4a2@S8[-bE/6#[\L@c1K6]IWa3W
=C>f\ac#(^#?Q<[789\1JA0.-IW-T4V-GP)1T\:42fL4WI95ZY<MD[/&f(,Z@fX>
H:(,2+^,=KS1>MY,:c8<E:aZJ2I4;T\XB=:FT&N?O;4RNN6-[G=)CPOU>#Ld@D4?
-(g&W^)de8_MF_^,K&JP48B]a>0HIFG7@W-N4PRa#QAZ_HI_/2EOS=)UH5OCCR3C
:A5N,;#78<[0^?X8S?O>);E,>9^?VA:gAN#Z(JdW<)WW^a7]]B80PD1cc+]&J(^1
;GTV0P0)fe_\AA;8&DC-9_N[4-^D7g?URb06J-A).,1>-#Pa8^LaHV1@X1CKJef/
,H-+](#&<7:0dJ5PXLMC]gPK832B\81bA#Ue,52#7[L+B=<:Q4DY56,J[e0YX-X0
A+7=.XH.-T-W>.NN_e2U+\gEH.JfVJKeaT9)Td)Wa+.7B=6J_2dc@YM62V#ZC@Q^
d9g+cV&,dT;/<D-f@T#,>=#]4E]WLAOdgUG5+G.U;V;815^BT\]5\J:/I0OH.>>7
B:?/4Q)UIFd(5R=bb\OOQ-g2ALW)CTQ[G:#Q=gQZV?b39a55Q6IJg)21P-I8V?N&
FG-/.F:5G:X,<AW\4V[S]:9gYWDB[P[.f;BgM/1C[X)M-.0<AD5c=HYcL&ZcBS<-
^K+8?#c,B,(5AA[,N?\,fJZ\a^?;Y@H3ZVfa>NUbO&>JKXF(VY4:[c)6I#K>5UAf
)VI3&2K13c_KWgO088>WL2TaA0J2:?Ee?Oc63D?8NRd^<T<(Z6cScD@-;;S(-cCF
YIP-V;&<a.>LYWgHEALZ,=:J[XBZ,g67V]fMTcJW(=DB&EfW+V_YNVE@@?Q2X\,^
K1,<f_aKfSNSf.APLUGO<XK,I_X>L>^NQASWPHL?#76g-MASV.JR(5)+^U;/QRX#
TRBgeCC..RB][+2YAG/(4UFO,Ff\O^OLFI:D)M-SN<2)NSYQ;GWV]TIS7RV]6\I?
C)_CRW7()[f3Y,;S&;.(H&2R]RN<O^IdaO@E(A(8M?c./E>5UB)3\\2D:D69]7[bU$
`endprotected


`protected
LC1<[JQ]^/@dZ:eJE<?YbRPcK>--VBL1aEddU\9H4@AJXJcdCGP7+)JK6U]c7EHJ
MKKB5K@afDId,$
`endprotected

//vcs_vip_protect
`protected
4N;Qc,5c0UL/1JH?1&#]1bD-fER<,.]^XQIS2Me200LC<CUPFPU^.(bDO=c;)2\X
[0]H1#5)/FUZ]b;IZ609bPZ?N-8@cP<:U@,c0(5>[E7bYeRHdVU4KWHV;13-CE4D
&NRNZ0:;\.W^dJSbH2D[Q5:+MI.MF-&920>DN:W.:0<FD-O84-AHVfcS?HB,3=/;
dgaZ/gb3WGH<RgIOT2G@+(cBf/N)93Xf7UgJ#0F3#S2a.]L@)D&6+S^>W_9YH;+U
]3PU4\Hc.3829><J[#6[XI#>4;S:Z0>)Tc-7b&Hf+2PBa_)4#RK\P:BG@@4DVbHU
^>(CT0<,/_W?fZ_1B>\28,J251g1UL@g=_0()#_=+d)P#dgD\5<O-/<^>HYR-NT@
<3eCMbK9+2MB1M45Df[W4EA\2XL?O8:c=U2b+Y.fVH2?BGK.EMR.O89&0.DFVIbF
ZU=S@NOQc;0TZE],QAH&8,24]b;CB;g8EeffR3dQJD^F=K:^e(^6:a1gaW.Jg1&\
8C[T&L-_.NU/M]g)KNQ^63VAePT&I/0FZ_b^RTJ85P6c?@Z:edPNAeS]8,91-.@_
A1);]e--<Ja51b^,adY0g(ed/4K#6^[6<LFgb.-4,[S==BA@KW4DMWVeK:GRT/#?
USQ0TL.D<):9g/<JKaQT_)-[cEePG&b@aW5P95Bg^f_6.cOYHUf1E\.<I69=dg+L
=Mc[#(_QQPa+B8W2#_/HUP#If/I><dFa+)d6\HXK+0-M(&K7NP[T>U0d4@Q=,Y+-
P=fM-=gHU<WQMZ:G3E-Z,#H[+G2#Y0/LZ1a60DF9L^TV)^cOdN+Pg1#dbZ:.TZU<
@F8O\McJ-7[4\2A:<VMF?P96OATc)0Ag>Cec2WGDW&1Gc00+caf/#^(AI@@N0B06
_4fVAZ@8@Hf@;&0@B/\-]&-INVSBQJ24fWJ.a9+=[^L(CcL.@8NDLKbX0WW&gZA,
PBZKQ6I\HW4TW-7CQEPR#M9?OL+Pf#HL>D8TGV09g(F@NG_IOa_(AF@fMY,C2\83
X>(L-LB)NN<4JTU.=(d0#//9W8WL@95P<#JX4+U_>UUJ5e_QA.fB,gRP-8K5:.,8
[@^BL,Q&HXf\[8f:F?gg7<9HJ1f:L6cNfAE_ab,N2>B)LP<a[g+eE)X#D(Y1e7][
+A&(3R@8,L3L1#Y[HQD?gRDec1dXRO/#M&?O91J0Bd58d=:;0Z4A<6+8.UOg0);S
d]:N9a^)Da[V3Tf@^T,CgBcWNMObV[PVE.)^4aC)K_N=<CP;bd@ZaO[&OJ0&H9f^
=R8Y0b[@]:L101<eda:eXYA_?:)^M5\Y3YRcH]]/-X)e<-D=ELLB=g@N#.E&LM,G
N8,gDTY-.[T^8OQP9F>\@V\SH>Vc^1ML=S2IT;Hd_KNE=PJC#+JGI^g3Uf)J:d/F
5=\^c-9I38NS,L,51aW?8NWR.#7SVO8,ROAC.I]V92AK>4(BaW]V1J)385XJM=[U
NX,L_bRU>gYL8aP^7N979^&S_CDMP14LMZd,))BIRJ?cTb\+G\WLg,@#CMWe[L5=
D7dEL]9[F[Ue>a9bHHeU6](.HVb6PG(0dO2L2:+<b5U@M6[P/GeFaA5PcLJV(XBB
/G.UF7e/Zc[A.PQQ,O2Mb#IRQ,Q8+9)Y4J&KBg;D\LdQ76_BATB-0M+VDePZ,Ia+
Q0\_MSFaJ&[b-2=UY[Q=MXZCZR.Ggf)E]@W_8gO.,2E3=UZZeHWKXSYEL,^J&FbN
<J.-P4>BJN2?a4RY+G?W6N=KE=(Q]BAc.6,OMdSX^NC#0CWPSfdT2UadEVTL;Z24
#UG34a-0T8,[#+9V0.=/7?T0PPZSVL6/1:X;TN_MfX[S+YW)(A)3ePCa@4J14NF;
M64;=XLHcTT3X9\N&?5QKEEV7:^VK4PY.;[[J^M,F:]/^O_;;>ZO12LMb7W)M&WO
c^85dW\B1V3X41,1L<A=<aOT9>3NXATIc/A4RVCJ&>[Fd#FdF&.^DZM>_?DZbZ,#
U?>Ye)]]NaSWe8];c):>BIFY5g7D-C3PR^?H]W4H,1^AE]-K]SZ4KOW7ROD^0>K:
S(#AWV;T4(+L]1+YV0CISD_59RONT)JV2&2B3F<:/<CEL59R&3C@8LFOKH/g#^7<
(>)Yg&X[+@M1B:=/I/^I<g<DNM4<A=d))DRVW718ac[M-f(?8:)=f-F2f/I6S<3X
/@A1=.1f>Ie;IbBLg_R#f4)cdERAL<a-d^)]4aFP7cF7^3:KR0:LB_eFI=1-2Je5
g,C4MPLJUS.X.QJ4-S?<8U(7=[9E-GX5K9MFde8N>bG/dCKK&@Z7gUA#=F]1V9\U
+1L_(KG^@JRe(dV;8&R[4ZA/DU^TTL&9Y6JW/JRS8904I@b:8dE\GJ:5T-TJ\?VW
\dQ:b;-7T-)1f:Nd;FB59Z\)&\+ZSaR7g3K>S(?<d+/]>)ebDXVPg+aJQZ]EW4#3
EZ,4,a4@_9L_\\/GQI:[3[8H,1.S[F?CSbOH(G<LB_]TcKMR];,+A=?6efgF4SF)
4&^dfVW:Y+2-EG3^3@2J]H&)]?FTU;J.G.fcS&]#?I=J661]a<2YUH,=7Kb#C\FJ
NBC_U\)8.bKSM#WZa3Pd,76VU^G2?_ZMQ78T8]\4aK2fbX/+9]eR-e7,c9;8W,gU
e0CP:G5TT2F;4CP?UXEJWgHQ>I_F=[UHD_;;b]IX.2@H)d08MZ/J9fW:.L[5XB#>
AV_^IXK:9bg:(T[UT<,0b905e6GQAD4UU_U:;/F4J9TNY[JbgUU@F\9M-PdKS^O^
&MT7-=IJ.]DUZMaeKUJ50P+Q>;#HD.daLC>AeM?]9P;P+@3G@GeG3N(7Ldd&f#V#
GM:ZXC5_6B4U2-<V;)M&_(6I?2:VF:FZZ<XbBgEKOU.Uc8>LZ[bXPI_:L12d.7<S
?#d:U>Na?2[If=/L;PHGQ_-S)FE:ZN=7:IBW658#CCKe3C(10R^3J=__E/.KY:/W
W\]\I+PNEK,U_>>6>4LWCEAYBFC&Z?;MD=Q(+7Ng)&Q@gU?FAM=LX<NfZ./W+<HR
O;UMNO6T(5)=GdPH.Df9_5A?DZ[EE_J5d-MB?&GU:J5&0gE=9T=.:C6D225>)\()
N3OU0DN+2N8]89JR7HXGUUaE3&JAcK77+LONC(</bNC.dUdX/?PAWc?9,3VNY,;W
YOPKR47(.6Q#AB81<W7NK.,MM51?,-Wg,F8;\N&VaCH5MCN5GA2V++E_VS\Qa7EJ
0X;R_21PCdJb_67PB;VM/)&J5::)8MA=R5(FcZLd-=L0[_,0eZPTCIO=@e=4-TKN
c:=Gb.5-J<?8/HLF,Tf.]1@9\\GO;V+#P5E&gLQD4?PdJ;-EG]#4UcfTW>2fRYW[
6)G2J,a,JL#K6P8DD>ROS]8R;R7E0A:\5)]J3/CIHFYZgLH),^7S#cVT+9>[K8d[
LKcY4+=I[?[P_g0dRc;V5[3f:eADSK)FD.^UV&4W<cV+?,,AE-cH;2;#Cc9U+Q7I
3M7:aG_]:c<9).[J(RM>W^8]ZMI/K8;,C_.[_KTF1b\W5.+FSH?WeAR&:TFRYH@]
_5_SA[Z/4Vb48)-d9BAFa>63,+dYdg5I=C_,=MR?g&3QPeG-L.MWBAFX@(AS/AH,
20\T-,-KfNb0IG_:a@?=U/0P=<:-^B^S.K4^([a9ZJY-74[;;cUdJ4SfU<MAO>MI
Ha8fdg@O,W4)HOUX?EB^fb_g6FTS7a-c5>Md.ff9ce=\8@DFL5EcHSP)C5:&-SC.
-2RQT;IB<Ld4,?>\A:5&7,3]D.OMWJ+3AYTN;W]@Q>B.7)B,9A0>K5&Eg2D2C3(Q
D5R#A#,#/fCUI#POeO7_WMfD^g1aaWa,(:C2<_?#2?;MW6(555KOMK1BeQU_RAZ@
OC;a9H>H;,UgB9HG:ZZ54,YYePP_SAJ.MLT7ZIW7(@#cZV,M2L2>fWF2=#48[HI=
;KN4WJgZ1?OB(]2SVC_D^c-g]R1_+KE19@f6O9X9=KWM@B/_QZEV,=\^FT/DB<E>
#Vg3IE0>FA@MA:I:P(3_/R]La@N#2,f29#g?9K-8&CQ^AfLDEE07EDX1F#bY8\W(
5_H_X@IbDO)-fAXW>>4_EN&)6ENO/6=00G?18[Ke?-^Z7aW)JT^59d/=_Y4G_98(
J=F/SJXFT62[@N/[GHB6QQH>,BH,R>R_BeJ<>N8J^QKO^0.Z)EZRYaE570;5]>8>
bWd0/QYI#5EOVLcH6HRZEVb-@g_;b@6S:Mdc?d@+:&J>dA1#0_[P/P(0P7OE1K9@
YB7<5IZPYPCdMIJUVK<c+IV]VA5&7-Kc&DMPW)JW2e/fM<d-?.ePc=)4#I],Le+L
&]H/C1=MHNWf-=SXMD#ODS<91)5)^>SS2M<?A10,JT2W.7+-2JL8W1HXP2J+_2g1
-c\U8W:[-)>Ad,.Y]@H^T2-?:MAR[bWQA/a.PKCWAgE8&a)^b.@4/9U+Z4_Rc\#G
c+Z&/I2JaVQ[7#L\.f&WKf1ce75a3-6M511Pb1gccd0E=?X2->\D6Q\H^SAQWc<D
EbJ(c^>-;HL7_\8Q>;VNFFSYQ\D,1XUeZ4PQKIb&LTHSWS4ED@+F.15f#/M7R^X2
BI_W?+E;KB+>bE.14+DMH&3.[KGbS#Ce0+9,97.IRB=_g=ZWCD0]#^e+I])5?3E[
E1JgOYff_?>>g/G#Bf;&UUac@R]J(WU4VeG9Hb4Sd[;\S,R?#8;GO-R9g(#Oa;GP
g^MGQ2Vb3e3C7JbLT[DIX/A=6NcR\RXc9K/K-aF@7Zb)gSZY<>10J:gKa#S2F__d
fOXGG/>5TR;[caQV0.154)01\B6=HPdWKR=^EPK+?6,c_d(JM_T2f2AeWd(-:8O4
K0cO,EP1P1gNLV\&Y1#[eTF4V3A.Id:1Q[H_R,>0M.B;Q#e@bN_bS2N:S-3B)_fg
e+?TLFUB]&6J.NJ@)bHe1:7#7DS)OM?C/caL4_+2WM#G4/2;KD_WS&XR&(dTF\&^
GEPB4f@&)]gV]FH>1S\IYFSV?4RGKHN#+JI<C9U]B858#23V4UB:PYWLR=#<+Ne@
R;bS;1.EZRKUOC;VEAN4M@<17B^H/WWH1@[II,1WafJS\U^J6_H<eW\ZUaBW1#M5
c7S+H0PRbIb?POcb\L-L])N=f.BFVO4HC6X??f)>XET93_g-&PFW3ZS5[NI+/FW3
UYRTD=Je60YF>6IYVB:9B,3?-7X;^Y^b:GOVFZAg>7Y_=^4V>8,K#1/c4ADW37g7
c?X?R/cOOEBT5N_-L-IV/c#8g&Z9F?T)f;S<C+7T2CP.b60=HZ=B[,344>+gWB5M
T)UC-AJC4#E6E4=+/6R;#,HK<1>GVYX><)YO(0eKRUVR4#7W#Ae;4aXKV+O&b5QG
b^+@_Oag)e-T/dAPOZ]@e8/__JQ.5H#e?W7L/Vg;F63X/(M_JQ3,=.\:9T7Q4bQB
g3+BX#\F@R),ff4NDWbZ+>O?eCFI/Z5#1.EW9U#&g0T01[dF&<>:05;-(fK[TP;<
#@:2<NXH\S4.HKF[UJ/FP1SL=Qb18&9Y)TZS0>6=TKKSN(Nb?EFL=Cf_ba6MP]2E
]bPQ=f3HeY,Vg(.VDFa0Y-2b_+ODe3<(A9AVG-;8-@#5Y8];)6V<\cLJe4]M-:>(
86=>ef9:c?+9?f;L?0MTKB>=dK;ZK[G2[J5GXB>gD+?:gH(6]RR>]_&SQG?VPJYG
7\X?L\BW7T/4;NeAEK,[Z]U2N6:ZA;5NTdWZN#6N2OK?.))g4-GRAL#FZ,-M084;
5c^;Cg#L+EK?Oc\3NIfU1:a9e962eZ(,MICH#2e-LHM&4JHQ(_6<#?VMKNOW=ceW
?RNYC<VUF&91:?S4-_\S</_CV<RC8R7SQG6Y2V[9S7AFKM+.\9XH=[C:2H5IME-e
<;3TB.LJ;+WR-9OZ;OLCb+00:47cBLH2XR.DcSC,3,YL^cJY#S.I6AR=.gU9<CEJ
TH>)c(I+8]N@H.2^?]U-R,3N.M6#SP#dG=P;=K0EM^W?f;<b)E2f)=,?e\=3KU#5
0P<(/N9=(YTgZU=7NN6WABP7EE]OY&8B([5d,-NeQ]<FJM#eJ0+9WK\TYRXXJV;N
H&4bG[f07TM2=>fgS)3=;=Qc[OW=N),ER#0Ze9A6D,;KB,B/A4Na8U-VV8>Q0FXS
,#MW@[X]UF^b-2)8G5:3K3#@A,:FX6VPQYBg=cJR/43.,/=W<d(4beSM1O2a:RKP
c/fUS#ANCe:?0P_b]IH?WTA5ecc7OTH9N/^O504<&0OJW1:]NW??GDgT3@3.2_Q8
BGfQJN0S?aa@E;g3,U]1<a:&>0^<Q=d:LKeOGBW/&A:-3c[F+<<eMHP=KBFHR7G1
^;Q4H6@3]B&?#:<-fGaY:.+\_&a]L1E>CHY&F\K-.XW@Y[82/Z<(e6D@&&XHN4:M
G<.0A-+/&ZZ-J2@912_2D8M?5/BT/beY)L^M1N&0Z&eIeGM1XTeZIG72\S6U4NPV
Y<&P7HX>_^H?>)+4,1fc[1(;6SJ6N<C_[R..L<3ZZKOb+9/8:@\d2AOL0,E[e.O=
],X:ZJR[D_B.W2f3O6Nf?]4.7R9W2[MZ.=MGPNR_2ceW(UJP9^VGLX>ZULM,><-^
gc4HbK[A[;CNC>1Q?GAZb_P7\JT2MLf+#E<F5ZRfbKEFQUb<#K/H=WT2Rd3Y:ID>
Nf-eL;8MH^;PQE2/EAVX#b\a#FKUKYRP@[]T#\=bF5;ICDcCK^?;=+5bM5b-JYAG
+4EJ9I\:AG6KDK3)8]Y7IV.eJC-b-@W6PKAfE[N=>#>,H_GVGTI16PReNd8,/5BH
T_.(@=W4acNE;f5+Q]W.5aadd;#Qg-(&Y0D?H2:d>^COLOe[DX46a/C.cEY;G]AL
KMFBWT\.f1)\7Z//Z>VWJ?[R4DPL_2+[d4/&59ROZFDXe6SW64=JSDbNJYA:-F]H
BR@cEOJJ_<V\eO6>NaP90C=CS_DYSc+eI95)_50J/7M:b0KY):J7?G2&RXeQ;OE>
gEEY=9..1A>@65<DVf-+cUPgV5MB5;VCSbb1.b&1<9W6#Z4VB,cLVFeL_EW^8#YR
SEA=.aPJb<,ee-SgV[b2eDR\9-@+Ug/N8;VK#)R#3(O;F>W,#,QL]HV#7>\E7Q?e
P>Y2^HHM0WHMN>8HY;Ug@c[SH)a=ecJXfI8d/O6)8b>A>@+H/-BA]1[>;0eb39S,
^_UM-QDWP/UfL\:I\MA]=[gXJ43Z@[Y3;J6gSEQ,>WG@]CTf1]AXf8YMSc;CGS-D
OXHN87ab&<fP)UC#Y18R2<RTL[LQb^N&1,/2@0B[_:IB1/02^bd^cP2fGSF+dfSL
MT<Fa1ULN5V(K9cMOF>_S8_60e^-/-cE6FcQJK8Y9IbXP8DTJL^b.d.(:Ad_XZ:g
1He:A?ZC7a:.LHa?4[)<Vcb0,bgDR1)5g79AK8)KBQMD^gXcQQdgHRe;V6cbW&H=
<<:^CQWU+@H/[EMZ_]?c,0C8QMN@SB0g^J=C>b84?_04E]UW0TKH:^AS_UI>-P#,
HCY&d,g(?T+_RQ,/C,W,gg-^:dI7+#/<RW)F#RaW;2)S=5M^(;&e[>38V9-2?4F>
#1S>,16[)O?L4HUc[ZATBEPD1+aN]e>Y24-e[d[L2LJ@J]U[;,7AEKXJ5NM-/<&B
)L.bW59X0<[FO&WPf)Z(PB,NXFE+R.>]Zf:M:F80:ALWZGA:VW=E)#E=^aLaV3R=
_ZeAVNJUFHZD1UASB,T&]SbCA@/\D<J(.1U_ZA[^/,aX.P,8^/Q+XbXWQI#T]Y[H
)V>,;[N>^A4cK^Q]@UN;I[10B]EQ,1CaJaZY]3JdF5L;4@=_E#-b:aX2JSLT?W<4
7J[)H3;=]E@\EPQ1,fG(&BK9fR:]Tf9J4Z0BZce66;KTZ7VH\UL-O#X0+4#cYGY_
VCX\3>Ff\ZA]#>aTN7>XdY&#/8)+H4UHAeVC4\(5IdM4^X@>P,G\++7NF41H8L6R
_(?V:57CX1B=POLUfa)\.D#T(MCJe]\:Y62@\@d\T,#cA1&TVeb()U84>+Y6DJM=
G)8Y/Q-G>/Aa>L2P7)OM0G+R.J\]E3#EQ4e<L-cHE&aV:=fQ#V.2-8;W@/D9<gPM
.#fQ.\<80;X5M6d)3JNDIUN[:G//E?>]aU\;]E<)(006aedM6(Z2@(.,.B&c98&g
XP\VO^XbUCQ.I)Y<EdTEA6O5g=G[SDV)a@,OCR^JRg4g++/Q=#?:X-GP(f]D8Hc9
T/DTR<H>EM9eFaCC@RU4M:U:1>2AbWU2MYK[/4L;]X-F&&Y:dU7)Tf5N,(-8?dbg
Aa=4YMCTf?/HOg+P4EA8-;=Ca+b26]D8?9eJT&b.@WbEQc2MYHW>2TSI0PgS;D;Q
F0;WEO=B9a]R616OR3KGg<RZO#5)-4FC[N3C/5KeEPaLGa&4WH[#?G-Ce6>\0^2N
PUH/_dRK/befN<\CC0MFd&EZ:>G(gaKR:/4ObL5K73IFabO19b=IW#SAHC>M&91g
T+(=,3GV4P-b+-T9+#VMVO&)X62Y.1O,;63#Z4KJ]3FN2RO6D4+42NH:<;Va\>49
/J=_X2[C[B050BL\L]+>MA[c6NE@G0,8WRdaPU?Q[dW=Z(WcT<]\.Q/_KUQ71N@V
\17L/ZYW--;XGX/Q#g(]H<bN5+#MY.:Fd>];L^RVR124O\72P:(W]P64<Hcd13.C
_5+8P50]50,aGGAP6?+;^+-K:2g6.ORRAGS6@=D=MBNC0b/2N[@>MGNZ)97D+a1\
C0D:C92@S#P_?d6E5X&cUJb=JQ,).W5BZB(Z^aFPbd>^MFJ@b_;f9IJ2WYU4IB@_
7^NQ_UR](7W(R?(>)+f1[fDN5YGa>dgIQO+>88<\O=OHD?I6HK&c5)fA2[34C3QD
3T@(T2HWDQ1K#PK,A27QSGAf<Wa7.G)/<WKG<Bg2=RGL:cb;=-7aY3_\CB?\R5Sa
7NP>K_0T,:e#gTZ)?TU&;fYf02HX38(\+\&6C92WO#71PYeK:_g^ZV8g^KdIGgKf
RR[Y#D,E:K/4KaO:89UBNJIA;:T79^[Z+BI6aM))Ka<1DQ#H(@7@U0[WUd)D?/P=
T;EeB=;4-/J3<,S1.AXaYS#5\ACMUV5R-C60>9?_.d5ZOI@BY;@K#Q+-[(9R\?MR
DSN\87,)G]1J5[gI#[CCWNUE1]],[7)HOF]^ea^-PKJVNAW827Q,cJ-daTGL616#
KX>EB@8,DMX\?c91gGd(E.<Ua]\N3Y]d@LJ_Oe=OY>d6CfTG)WM1Xb:XbG+I[,K?
JA10-J)TcR<Wg+JS^)KRG,KYE;(+J#N=b1A6@C)J:I:W6;ZH9O9@6B-e:HN0^S?L
G=YAI6WSDZ]/N#8H)F6-B7XfN(EM6Q;@bNM?76:Tc\.TC@L]#YBVQ#+/G@SSeF-0
+([K,R7H;RTBBdK+YRDF2]18=>V/&17_<a4IOX/).F5G[B7S:bN#b.c>(N7]DA8V
4;U=,)+LXHaMSaRQ,F=>XQ.([D<)5EZT-QB)[9fc&,?Z/f8FcK/)2(]^#UEcJ707
NIF2f/]TERBGM<YIK/]SA_T>H54<)YP)GFc.E8Y-JP(EHK@#5MfIK=2C&0f]c2RT
@#I7aRUa0I5,VRA0;Aa&._Oa+_&dZTQF+V3]V-6+3;b,U_7WgVG?:Z.F>L+0#S-g
/XGX0D/R(P2a<2.[6QfWfHPT924gTPL[0?0N0/KA63@Bc9?1AZ/@QJMY?b\]Q9&P
F-)@D(NL[YS-b4/10Y^Ze&K0&X\W=NWUKSE8ZdJCK((/.+8<CAX+0-GZ>U2+S@YW
D1;XJORL-G<_>e9W8cS6V^@,PdL[=T66#E]8NFV7@N)&gK:3.JK)8gee\FdSVGeU
.2U6+^J9?P/gA9M932;[JP;.VcaH#AVB/IPfDTR8>MB2B)UXD/V8Rc^[-aQ-)WT&
6K:G@VXK[LBO.d.c&>5DL@\#FH[)06O;WJCXX7GEFBXSY1+EL.3#@b+.e&^^2<,1
V^\HYOHa<F\O+T)TG1.F1;d>YO\P#O^+U67f^aRF[S<_e#eBe:BR22W,2L8a:(M8
b>\D#J1FY@R<(GYUdb^bV<5#dORO=Ya.-Z.Q/G[>&13T5X);R9bA4SB8g>gK?EcN
Z:L+dWKK@8@UHCfOG96GH?H97b#g(LfX([RHP)&B]\+H#8CJ1QL5_1_V-a2+)R.S
5CA(a2gbN9eeP-2[&gUD>0K2+Q1MQ(9@4XK,=5^ZPIaQDBIKDXC70T_S)R1HYSSe
AbD0>>B@K^fgN[U\:K4YdGOQFF_5&+^RfAB;fW6.UYMU/=8)R5-CW=PE<NC@5@3[
P3S\V[@)Z8P?ecWF7:E/=4;1SPI600#1dTg>UNW_YR/?)RHgG]AEM8fe#fa1)LM7
OEHPU#@dLYW&7GeY,F:P(0Y85fV>Y_UeeVG(O36J\Nd1;aLWAR1N&@V3B<JT4QIY
=aa2Rb>]\,O=?YT6X.AAWgY<X0/1M&+839F<\6\NNfC7]^f4P(0ACcO\[LYFfbe1
9H_>ZDI=XKH@]7=)>+(Z9R=MQPZ[R147E_QCBb0FT=\N2?3?#UAdI8Gb:=]^4J#3
V<[@DC1<8#,0(4:>T(d,ffA-V#)J=M_MI</V^OF3F_E+LH0@_g?>&H]_\egCVe=^
X=;Ig4cL4F^Tf;IUOC2(2.(,W[B]-MPRf(]@^L)6AYfd4:P_&PZ<fPQE2Y<90E[(
SPRHK=Y,9Y.R5CAHg65fDc]=cfC6:NYd0La0=33-AMH^[.5/AEUB78J8=,4?TJO+
^=^HgMUG4,I\U@PP2Z]f?D9c>-:C]cZTc23c4C@29VJdWGM#B8:f8N9eJg;MW0@_
O,VR8HMN)GWVYbA7&0g1b=W/R6@)&X_>>4S#_<5,5KYB0dgGdcBfSBEg67QY=]Ne
VX4+6H&HI753&?bJ<=C)1+9\9I=Qb9E0D^/.[I=)KG][YMI7?Da:Z(Zd]da18)\d
7@4B#5@XdAS4X5HAP9KS>:+#2:2RO8,9V&UWM:>E(J^C2W3.d7?]f?N;G^5_PK09
)?4^R/8;g6fc5cE+FHAb&65:9Q#4\KNB]?a/ZLNR)@Ne]eKc^649E7?48a_;?Z;A
TKFVSLg;W9F:Y#7b0:U.\L-BYM\38;FQcMG1+@)B6f7ObVTJQQG,OWD-Q6)\H(T.
9P#3>:eC\4F?aU01I]P:=?MaBRXK,RS+[&VMd<#HXG>X/U@M3-;?QN1LV8^]Q^?c
Se+Nc3]1=G1cU=(FfC=E25<NG2T/^KUIUQE9V&e:^cUH:b#c4^f9,gGQ>RZF,&1U
8R&00f&(HA3M3>1ID>\(;R-g)1.]H<WcQ)?P>UU;Z5e1PF_,@IJ6&A:ISe\\]23(
[8;:5gTD._NA(RPQa4GSXC&XJJWKcA=H1?d,2C+8,OL_\6Y1a7N=c?d8(b;aPZ6a
3G8DWNgg_,+;ZYdQOJcT1GG@@Z8P^9Ed6@/G2EAN\JXb2M,^KGXDAU[L?KL4:DJU
]+23JO]=8?d:9FYO/.Z)PIO5-BL@(Bg)FU4-X^/U+Z0@e<MF5WRTa3P+S;-=C:0b
</d](2O=eMNYNOICNf8(&\e;YL#/>_HUacW=P>5M7Zb5GD[[[9-X>.c7=TE.K+]d
f@^]PD&&f3IA<MMEJK@d\_;OSb?BB,;<b;.6(&UA?74>/2+1[PC[M8K7RLFGCNaB
P=174H(gP7T:#^@85_WV_J>DBV2#W?a?^NX\f-aH?R_@+7T&3>SdR1GWXg_K@XAR
&e.gJ]LaX\K:0$
`endprotected
    

`protected
\Y/4=+Xga1YY8+MV;5T+C4A]gC84Y>6/A[K)Y-U]0^+f(THbZNWI+)a+ae-W^(9/
c?O#4:2W]0VY.$
`endprotected
    

//vcs_vip_protect
`protected
Wf&7C(CM2CJ0R0b\FdXWJ&)44HH+0fXc0)UgFWU8<^:c,(d:^f)E-(ZS?WVB5FWC
4W285O,M,b>1]M<dH9YXG8NE[\8+[T(?)3:BWNT6U-;J:g.2Y<F5CJ>>_H/@&0ZU
7FBPV^6e@JQSQdRZBZ6IY(2D#QAQO[YX\NS=dXb>EOUQ&MScRZgSC>J>IM<#LKF>
>>TDC>d3X@:S5N+?:bf8EPgeQU@]>+6H&-D5K(-3PN9:c4EFZPUV;SLSOc@#+0^I
[A6V2dXHIXKBYOM:3[2cbFV&S//1)YX6c4PC;)K?G]G/1P\_4JK#B;0/AR\RaWg.
>9)=?/2-DX.\f.I<K#CPHL8-.KGN^HbM_@f4FfOGLa^(4Ob2+f_179#0eLJObRD+
5Ig2YYR);LZ4MXT&]WU+8ASVTO358P65>J@/T58ec34(fWeggafAB-VIIOKg19;a
;-+VAd8O<6gOT=5-?^(9E_=821@745=O24PT,.P8<&7ZZD026_OP^:WINY.B3Ff)
2a-L4DN:D:I3SDRdK)K;GETdXT^PfQQ4BX46VA5^fP4&<&O)97(37.5^5D8X1/_a
f1Z.;_:;aY&bCN@V)DL,fZ],X?Hdb_6UG6#G)7>_.ADG#(K8N2I-aHTF89b>6@eS
CAKVSf-C0@N6RDA^VbXW\3HC1gD=IZ+6I1,7]PV5PKX]H;C>+R#79]0.V6MTR-WL
Q_YF+&M?e@+8W-+8\J79+f/-20gg88]F?5GY[L&ZFQaZ^#\<JgKUSF5<)L9]F&<6
3=^^#VgA.c^5f^E@:_5\W7QGZ(:A52U&S,Q_:0IRZNT7/+e:[7c)72?&3;1ad]]7
6aF;ET?bGX75A5HK_#L0]Y<,DPT6d9]IY?Ic/A;MVDb&R(g+H>X174B9If?PCLAc
.ZW>LL22cB[SKDee+B_NFW\&F]bXNUX@Bb7-)>TVfEYY5FUVde<4<P1@+ga>/f2c
2bR-5]B63WP3<Y2<JCbeCc#?b]?A=Y1@BFJ^a@V36VY,@WE_gE.NH/-IUKY1bNR.
e#7[DNR)+</UD#IA/UU1A^_/IAUGN6(KaG7&^aM+^FIZ?UbB5Ye+5R\RU56<U2R:
]VeAOR.E)0=:DR>1_LW[7a)EQAZAb#_H]?VbH5=K@g@L8HIFEXYH2P8[9?4CRfe8
VcB08&;0WA]DdCVK)T3CgMK7g3O6d0)>WO)2YG6:09\/5QF_?1#J/,CeO;;g+;98
-Q7Z\+?X0C,KD0B#fU:NW]<UQ9]?5GWKM-E&Yd@7\g1Fe&H>)U^>D,<NBFFY[P8V
[_JCS.#Q:CA;8Fe_+L7?@&4,R@e,17d:IeQT-G8U;b)-a>#d=>&gFJD^YZaWUIEZ
?FeVfSeaQ.@XAZQ(+VdVD?U7J,KR@/K>/HbIB8dfY806?\Z94-;Ddd4[NGQY:X&Z
NRW]0HM8&YKKf?J/[H/N1U,V1CgMUSD56a?8)4gUBTQ-<6T+MW/0CH-a-d;O34fJ
d4[T7-9PMIITR@&47:W?0f[4TLbEXERNfgVDF[fNG1/\#YYM[I;eAcR71DO8NIG_
5g)I?;(7K8/:=YV9.#+]4bCfFd9J2RbcS1TEZf;:,>7A1A^/d(_1_--2RP?UH33d
#0[C(,gOO?UB:MHAD?/bW<8CKOX;Q1^45AM5(,53;#PT,EDP/]@\<&GXUWQZN&4T
_EKbI?I<#NQVRQ0DWJbOBaN_RPIS1:L\;RBFC(908[-F]K7G#d^R)Kg4]-R73)BQ
#dC[GVX^H/cTYd?N]3#UE:,W5R+Z4N-A/g8.4)d2BI>b-HbH,6,?3R3(ZRLJ2OLY
8K_XG9JdFX97GXFc.].MaZ;J/6/=e&^3=>^DPX,RABD1K6P29#\>J[/bS[(&.?U(
d2LcA_7C.::LOO62HWE?0>;QL4MFS+@S#1H&[U(.)0IOAEYUOIE6+EPP3U]0JJMQ
NDBTHcYX)^\PHL&1&Ce1(PMGc#1OV[NVg7bI)_Z>LGN:M(8ILgX(=8bPT9\&OSC4
E-7\a[NdETT&M@\B-PfJ5X[B^EY@>,?(gM@@,BRT7M=8HM_V^C8\g#8IR;21@Y/L
W&WQ3&V_(IK?8_JV3US_-W9XM;3()[\<V0aCa=f7,dELe2))037LdPIO=cgXGVNN
^)::PQ^a8R<N?3?N@W4a:XIO?aWKe)ND-)1e@a-3SX-/]O9^edH4U&X47Z.S([GF
&c;+JK]V2IY288;a^fE]7c?S7EE\:,F/L2#XGFKb,I(9X-0W53a/A:OB/_T\I201
7)E)Vd=a+SUDRDX3VaEB+S,<YDH_YSC7-MRCaK/\:5SY_-)aVY[JMFdNV4PLfZg,
;00T+40,K(DC49XL_&7)2A+-Te95MB4EV@U_6>CD;G/WLUKb>edDKRA2YD+XQ2Q,
4Xc?0ISBQ\<Q#VS\FX7?#PcD9[&)=a>Y54DQ(VI8<?9P6(SZWL_d2fJ5UXB)TU)_
g5?ZM_A^-R/=[]Q)^,EMDL46[^=OP,^R/T5AI&bX\g<e3T/eGR[EK7Wab4a[8UbC
-7#&-cR42^SHZ[K+B,4?K/;c0#QG,=&WCND:C)968)#:N9cHQ=f>V3VSV)=bGYaQ
&-X-HKI,fM#M/d,T1WF[8d#FTY56<fNa?8TQcUaG<A=(&5FZ^B)^f+&NK+Z/>DLT
&Q6TW1HAZT80.)H10C,><VZP-[VTOAOTge_eM6=;YYI=OS4NXR/d.JY(B)&ALL6N
<6^Egc;1a/P5_ZAD9TD>=:daU<O\J,C3_gDeb?Y?d&IMOF:WJB8(KM_,Rb)NQ>=4
DC5<>+[4Q]O0f&gI293&Wf7XdTM#47E@_+Fgg/LO>6g?V@7WFV9K>R)QT1,>)Q&-
fSd?@)][-J@C,66P05@)OX9AP_PfZgIB2Ud_Z(cIB+LSagg&AV;6^9)X?OGf)F<g
<-<fA+@Sf^3Y&>TFCQ-T?B;V_be+)K4?c3]PK5FZY(,d^#K<aTd\/H9:^W&B]a4W
&[;T(Y91XQ-T272eLX.O4\9-c24-(_WQ53JRM[CMe.1dXe.L<gg@T,A0??Y_f84#
U_YORYTS9,bQ77eW94:C.-fVT<TJWV9/acP.GK(NN=L:R/^aC88#N+#[-[CIXKSJ
7QK;RO.I+J<.eW=/8c.e5(;@d+:POST9I5@>[3\&8P6/,e6#98^J7IJAG<Sf0L(F
3JC1N8.>M#Jf_\B,T5#BQ8P>,1ZY/RDDL?d7DS/5>fg)+IO1BXVLPJNZLXG>>1EI
f.P-MG/D#LBJg7\1&E0DZ4a.D&&L[CPA/<)J\ZQ,Z9)5OeMf<H)UJ/)0W-6I#8O:
aQ5+3N_31\XX+&WE]K/gc?.VCF&>D^__F)6H,Z&:4[;&#-.5+O]^K#5G9e58F;TO
V&+T0\-9aK=c2V[1L94c9Ue3(\18-e0_77b=^S(dW7>UAV.A2:V7>NA(I6QI9(9Z
IFX+I#X+3\2YE\-Z]B5:<d:#MCGBMP,.24)WbLfNZG<<GOCY&7M9=3H?2_f<L#4+
WE4:2]J1g+.OHQIEVXK^L\<7S.,>&Q61OfXLO)6^1^S#<>O5Ke[[aHbP:T)Q#FIg
VQU=PC76ZWIEH:V@=ScU(L^K0BSU->@WE#4BT5)4b+NV>fQb=F_+7V;NI(Z]&S5W
X^UISW5FI.2<-T+N)^[X&Qg4)NPW8J;2_,=CIGdQgZZ?ML>La]B[^05GfIFf&/SP
W(<WN.OA2P#9RACI8(F,_RFX9.;Ed.I5cYHES,PE:7YTEV.50XFXLYU]]-<GPYVS
-8;RM.A0/,VH>f>gUD.]1@e1DSdI=ZVeP/)4;_=a&.,HL;YDgNCRQ>cZUVQ29@&8
\-D\+9,YEP@@eY96Z)JV5d8O>XSVFd-M6UX-=/N/_Z.Ka-W#]6DQ&7cL:[YYX3^a
-aRR\,PL@91MGQB^@2YCFOF5/4A(HT.P)7ER+7+K3[d8AUC+750)fAL3AGBKM^+X
@)0DXd9T#5(8448_#Z^I_4LP74Ig,YG8I/Hd?T5K>&J,E2HaGfZOfHL3O$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_TRANSACTION_SV
