
`ifndef GUARD_SVT_AXI_SERVICE_SV
`define GUARD_SVT_AXI_SERVICE_SV 

// =============================================================================
/**
 * This class is a service transaction class used for monitoring low power 
 * interface. It captures the information on low power signals during the 
 * low power entry and low power exit handshakes 
 */
class svt_axi_service extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_service)
`endif

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * Enum to represent low power handshake type
   */
  typedef enum  {
    POWER_DOWN=0, 
    POWER_UP=1 
  } lp_handshake_type_enum;

  /**
   * Enum to represent low power handshake initiator
   */
  typedef enum  {
    PERIPHERAL=0, 
    CLOCK_CONTROLLER=1
  } lp_initiator_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Type of low power handshake */
  rand lp_handshake_type_enum lp_handshake_type;

  /** initiator of low power handshake */
  rand lp_initiator_type_enum lp_initiator;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CACTIVE and assertion of CSYSREQ 
    */
  real lp_entry_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CSYSREQ and assertion of CSYSACK 
    */
  real lp_entry_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CACTIVE and deassertion of CSYSREQ 
    */
  real lp_exit_prp_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_prp_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_req_active_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_ctrl_req_ack_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_active_ack_delay;
  
  /** 
    * This variable stores the timestamp information when 
    * CACTIVE has changed. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CACTIVE has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CACTIVE has gone high.
    */ 
  real lp_active_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSREQ is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSREQ has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSREQ has gone high. 
    */ 
  real lp_req_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSACK is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSACK has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSACK has gone high.
    */ 
  real lp_ack_assertion_time;

 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_service", "class" );
`endif

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null);
`endif
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifndef INCA
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else

  //----------------------------------------------------------------------------
  /**
   * Extend the svt_post_do_all_do_copy method to cleanup the exception xact pointers.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function void svt_post_do_all_do_copy(`SVT_DATA_BASE_TYPE to);
`endif
`endif
  

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

  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_axi_service)
    `svt_field_real      (lp_entry_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_entry_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_active_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_active_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_handshake_type_enum, lp_handshake_type,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_initiator_type_enum, lp_initiator,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_active_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_req_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_ack_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
 
  // ****************************************************************************

  `svt_data_member_end(svt_axi_service)
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_service)
`endif

endclass

/**
Transaction Class constructor definition
*/

`protected
Z)B+SICcZaEP6I\-S]>V/R^=RFCT/QDeF7B;Sf+:FBb.=C><=:?S()33NJ(HN9Q>
ZI/(M1#N3ADP5G1,aSOD-61]+eg3_(M7(_cTTTTbGT+eN#bDBUb,^_<-N;LMPb(K
NN7+38T]SP27>2J__XR9TA+:.XEO?PDYL^D@2TP5/a<Oa.-3E2B,S?VB\O\,<1?0
AD4>G3D[,#fZ@IMW:Z[1XHe81Lc461K4ZEPc92)7,GE&a)#,_HPS+ca?6c2E\?)&
f^J7CT)&1DSU.SAU0JNIE^E4a;0@e@\-,\O:69Mad2UE;-bT_X96gc<+J@0678O6
@)8SL@51\XeKA8c)c+]>OgPC>bfC4f>WT_,,TA.+eC]<D=_UQ>(<NUN7#;OBM=c_
>?[O[H@eaRe+71#,WLDIZA=[3E)d,S_fQ&XQ[.;,).Jc&W)]UNe(IE8#4#)dHTdO
KJZg:/P0M,bT9([g=eDUEO9X3?e,#.eLBKWF\ZcccG-0.II(E)KScY-@/VX]\V#3
,D_:->,:.<:^>)9RVce\Dd/;9B88M^)/aQ&NA]SaK<]@e>1C@)H6=)W=:98feab7W$
`endprotected


`ifdef SVT_VMM_TECHNOLOGY
 typedef vmm_channel_typed #( svt_axi_service) svt_axi_service_channel;
`endif
  
//vcs_vip_protect
  `protected
_GLW&(4KI#&O+KdR@\=Z^4:>^d0(L9N3ID12RcB[c95O)33F==I04(+IXH_^J9,/
O;gC+Q9JMYfCBOU/2V)>C#Q[4:N7e.:aV5gM+\bf?)MU?#=?=X__a[WbGQ)6:Da7
(eabZ?+VM7c;=Fb]XObb63LXZL]K:3)-9[cDfacU1O<#G64L@5#EYU.F5M3Hf3=Q
5dIN?,a#N6]OO<Q,H&f()4(28Z)0>,GHE:+(1WL7BcT7\CZGa#LMOA?FY(=eSX>6
&[aJ7T28N.K8bd-8c@KAYND[?.@(Xd5>Fd/:#g=QF=L?P_+[b\[+,E:a8aRHLC=]
VI+@.&bWdTbB;_+RG)J[f2AMeQ>5TP]1]7HZ->6E6&60OAcAMVfI53H1#<R2EAR9
JX;Ld,2&T_9[O8^]=WEHa2bKB[F33XSL1@X2V3M)\FJ>WD_cN_8)A8N<>bRe4?,Q
Y#]B(IN)9S#SNPHT7A7HR=H3BK(X?SNccc#KLB)A#7MX,1O\K-FRc0<5.T\eMI^3
Wa0U)V^0/N0//^P81^B?D6DV2DK:&e9C6=F8c3[W2]@dbXZb(&IZc7H,?7P_==X2
?\85=G/(E)Q=OD.(e,_7UZF1=7,YNSG4F8,7MXF9BACX:#P[^Q;.0.P6>#2K6G8L
QV2CN4;:6ECD5P+EAGS2V,SCM42;E.1]DRIe):B/^Ed_Y:=H/ISJ52#4Q<B;4/>=
b(@Yf@-I8#EFZ<3aLE15G]TJ6]KA(&Q--b2.P-?PPXMB7D)GH=X:A^e?\)JZY84B
A9FN/C.4L,>(Vc&MOL=aW.a//L61G]7)QdKJ?6[]2/#/LBFK2[]5@e#8OC+GHdc)
9fTL5W]G.RUd^.e5Q?,X+fNKNc[7E0[XFbVY0Sa&OfeF&9+6/U48&_OV9UD(MXLI
Y82FaPf=&ffTD(]O/0@+-_^I6<>@.?-#6M:e7dd.B0.WR029]efaJ76M651POJC,
#^<c#XST:^Bd4(<?BfNUOHS_=c#O>ZMR+[\e<X@<_AN=AbWKO>(HeTIZ/d(fC9NM
<Xc1DdfYN,aC[Q:AA4I=@)7R0N_PDOaLQf8Ba?eaZVOWT8WdVAIgE?c@WDg6-dPa
Sd_cO:Yb((g8=c7U)M)CgMfB7cCFWOCJZ1&?bbPZC.C6);E^>]e/SC2JG:DG;>3c
FKUH0V15e_+geI/e,;+6[OD1bWQg\1eG)L-SAT<S&LH3L?4:cN\(>:_77)b0;(U3
^<SEI(,CW\/4..V>Nc#T9MdA\@/JadgF\.Z)ge2HbYb;Y]6_I&;<GYWBdFGO&S?=
62=.ZU@RaRB@0[K9bLC:g<^32@S+dNdE,Faf0d[Z14HWaN9HF4U#X8L/9g4#F6bC
>C6XRX7VBSZ75JQ_EV8=]gJA-81UUB4\GRMX4AD&#8?5eH;1dZ^J.(\J9YW-If_)
YTIA[0LAMb896eQ]GfH0.e+bee6O,2+JObRDNb3AG,-1S?FQE+:&HJ4->S8/H0I:
0-DA)bUb#.7c)eeOUK-4e:&M2A?]Z\eAV2a2C>Z_KI)Ie(<gW.810^?E=V8GS7H:
<>\194L/F-/QPG;Zf(@?,RE/]I>Md[VSI]2+XN7@U[BU73S8G/3MHEPN)\V8PHfN
9\9QgJC9HfbT1b=-CHZ&g&3b]9[D;QW8>Wb.0U:6GJX<:[2=B4:WH,Z[,VO\?[N\
./<dLQ@?:AI.I8TYaT[+(<Qf(DM^XW<VBT[7K4Ud7e,[LA#XD]K6a.S.,0/W6F0S
?;SUcd]YMP2IJW,ObK18Jg._g(,V]TE]((&<-8(_;IcL__J#(ZCL/L\Y5P?26aZD
47Y/8M+W_4[\F:O5QWHf2>=#?5VP6Y4U#_T=a#V/FZ]gcH@M=Z:\&Af_@)X/_aH.
JQ5\37NcGC,2Gg:4NYdTWd;e/(@N+;dE?[5&a=S\<5e1fOIOTZ_FGcXH:^EH.):#
6&[3>D(9Y:ZcRP1R03aD@1<LY4G+OR4GJ9aIGFPWS;W0g[+M(EBfOENJPS,XE>?I
P5P6f[P=(LgcO;,=O;ERC4I=SdW>=?Z]9HA51@:caN4ND[>^LeL]A_91IHTM.7_E
HO/[UJ6R3WK00#0b>O:<Hd,gR)GJ-,W-GBa6)R\@D=dC8M_4PX3-<PDg)+Y^a485
4Z-]6d50-9]2Gd4<,e_7&;Q80H_-1SG(YADfZb@#77NLgRe<.0e@XCYX:JBf;YI9
<<_KZ3WZgYEE9b3)D-99&U=1<Y[8J]W)g@MVG&4C(^&K:8AgGdJ_P[RPMV\fD1[,
=^BM4&36NQGW1Z#X[YQMK;dg9#SW<ZfR<AMPKBBA#M6=DbWVC_K8Yf2D5Hf^cOAI
VN#aAIZ<+3?Q7DIV28D<>3Oe&9SCPf2Hf=+/NAYQ/gF3GE;][7:<NNCP5#VRPU^I
YI5f>gZPZP,(@T@8-B=KgDc_5=5OgM\+g?Of9dK3b.;,OFH24QUCaVNZGS+BL7Ve
;Q#Y?e[QWQ5\,NH.,:2\KgcC[6+>W7QfGL>:<GUR<FQ(MIEbdF:fHO,V=MP-8:-T
d<3d<-U)O8,X.RTJ;?UeM(bE5#)EZSZfeX181&IQLdGGMc#OAG,#[HLVY[?I_bV=
+[OYBCG#/;L/I?FAbNN(0H\fb+PeBI7BJE\QVK<?<4e=K=+6>IFf/BC=IR+X/JOY
dA7E9#O4X4c#AHB7UMN8F^_:Y;W)C<;K+?_-)=b#R]A7J152:LL5:\]e(e>P(5EO
):e&Y1;);cK8Y?P70\gR\.\8;c;B2dL[f>92=8ODdFR>W=ZAMK9LaT(/G[<-CWUS
9W\I6K]=5Bf:0-/6?Y1IT5>CCR4e,&PEd;RI>;Xae[W[-[A]311L6^L;VHYELMS6
KX-F.cG[Z]6U-VN_?gAR2ITb(6NBN(IPe3a0_,-9-W,TfTC>+I:04B0:6Y3:OLaS
@G;adY^3#\28cM[HSZBWKQL)e@7O53ES4\9-D\RfK):G9K9CPR>IbSM7ZJLPXMQX
/^8HTOFH+5Y5OKGH?WR]X0],T)aI32f9fC/NZ;PAHI[C#-_L]Q\[3&c[[N#_eGbG
4XMcd>Cf>8d]a8;=AC.PeUP_)V6RR]5?f\LE8DK:Z5(_,8NP&CDg@Y]+5WOa,T2D
<Sc>K/,5cd#R8S?DbP9;3L[,XSLb<&;+WDH\#,TP/OKaXV/DCO<>E=#3VXMD\<&&
SAK2=B?(\F4INGZf,MD&dE5c.H5@Sf(&];XO:9O]XC9^/2D[B5L4cLL9?;-V@gO1
Vg.BTS?J=@f0IT1]Ba1S)77HfIeG)<BFeR86(G50M_NC3O0M5+X\E_]2H;FK,SeK
B12NWUN9(D;.R[+S5E\S>N@H,Kc/8Ke0?dAU&\/+F@,VLU1NCKOf/3ZM-8U&_L^a
J;F)JHLY:62ME<fH&+>Sbg8WE+1MA)ESW2F-JWR1#9N)e69=:cgeD2).)DPT<0ET
#Y=_Hb#36P0Y?UDB^EF@L0OV?.C]VO:L>B/E(=/dMZ<;/@+14Y-c-CHT+:D1a5AW
fGbL2WMFA)d3Pb+Qb[a2W(C(LUKg-f8VQ47^&58Z1)D)93J8a-7afeVO3I]a]4W=
afN+VeNbJ,?[5(TE2OL]9V4A3?I-S,OFECNLdSadQQ859^77]:Kc[gM]O<3HA&Uf
6.dG(dI4.MH)4GHMgHc7HZ6f+2OSR/\gFU5W;6eWeZO[\RS\b-7[+&2EA_+3Vf.P
L,7cUEL>+65#CP&1<,^E/L03W?1fKgbg]9^BXQ\?E]>@1A5=MY#(1aKRLP/E]dFe
]U?BgFH1L6RJ6,_RSNTJGP6:a(#7b4BEKeIb&)#,SFaH#6&WT^&@;;>SFT.S38M@
,\0T:N\EJ3@FbgMM83-R)cZ5F+IYLW^&O<E]<+M_&d/=DOR&Vd3fVI33U\/VFcK8
.YIE\S694=662bA2P&57\9^6,3W.DDT[.(9E.0&&A@:Ed0J\CDIR)#;R=C:N92D5
PIeUGX\H@/#Aa&eVgdJQ+3]Gf9?>&>0]E.63>?Q_U-P#I#bO1OCJ\FbF)?CVEC1Q
,U>EOb7:>MSVJd2Sb<B>5fa?Z+AURHQ##=aS&GMB<-NPY+aO0[)0CY\bG68S\@@A
Md4@+W#M]Z-Z11SH4:P#T5Wg/6C.E.H99#SFY6\U[M2^3OFHFc;77_;CR6E(<1+;
8[YU7ZT:bbT+a+P1N1Z#GJD513MHg&A+NfX,)>8fA<#5<CXQ?.cF\L/cfWQ+14+R
:6c3Qd.a6(RMd>NKfY)P&)?@:Hd0VgYYMR5JE=M0eK4Z[)&OXEJ._-;KZO25c3b4
LDbffSE)([4^J54XCM3,3=JW@\D+4Tb@,AEI#36;U[V[e^8[:H23Gg6:^ea8T.^+
[JN^9E)M[:6@aJK9=P26@SD;CTb:E[.f48HBTC6:_GFcN+c)Z2)D^-dM@8-II/3]
d[.c(PLV=a,.>^P71O=-Y@>Mf.HVe982]cD:@[C2^=\@UJ[6;WV.F1JY#b7B]/5/
K.OFTeZE5f#9Ig4D/@eE0K3d(?G7Y[O.DR>6:U\\B^:4-TD:dF>g-M#LEF6]G?d2
^&04,#ZMA8V1S+\LKO[(7cfBQ^/6ZdF@B2?HFVY,7J[:#3d[FVGdM@646L)CM)Ia
49;^QY:@W)Y4LUA6cW7FA5#A/7@B8S=7CAF4JeV/JC>.acJeag]:>88]4Z\=&Y\[
L<-&VUeZIB#M63><]=>A?OY7>f2@9KKF=A+7U0NDe>,M@[W5TQ;M)H.FCdOJT_X1
Z9@P2@Q5PANWeTGfUSM)dGe3MC<U23e/MQOX?.3+E0_Pg)I(W31^TZ:T8T(;5e([
X8d>?gfO[5O:85R+9P@<0?8]_V^A)@U#_&PNJ0.6(Qf0Jfc5/Be[H/NWLaKU^BMN
]4:ZV1^?J<6SWd-JM5SWb?bOdU6-(8BI:98]EG&d=O<[.c/6aQGd93SCUP760OP+
a&1fdab^.P(Vb<5PgZc9/.MZeOA1PO,SXR3RKSG_NT\1MVEaX2E\fVGXJIG6,@@F
gbJJNVC8JP(Z70EJcd8,CSO4I4gQKT9)D0M=G4e^>e7MW,YW&E&ge#cNdMG,6;#O
E-G4Q]B(N-<K+KZ(gfQMWX7M0K3V:?2.d\c2(._LbJM/(BfSO(?LTeFbP[f(_&#\
Q++-KB@N5YbNY@gQUdBF\d2D6+e)PL)(A5cCCM,3N3]M/1SR2W:DY=Z[QSc1<+=M
5E3gX?9(DBQ,AH6=c:Y,YH=b(HDV(g8TeZLB0U?C,5=JeAQ;8+_UM-+=[9b5-c4F
?@R_)RO^>]L)GR=KEX7B52RF?3L#X0JW\#YaKOCVNYZK7S8RP5>&6;8M)>Hd,\O=
T>_3Z>d?2NP@#PX[ba;#FNFbN/@]:6,]S,()4E0AN^U.CRKN76WVT^3CJ(a:<fc<
?6J&<1,K8GRKD7J3Ba;85,Oa+9=F222=4N5W?WX/LQEb=FJf6CAD1UD-=BFLfI/1
]^?ZFUCe@M3ea\I4B.]S0f5e[L61QK@3QNFV+M;@IZU&:&gde\C:P\LBK]\O-=L<
MB8c,,7F0F@L5G+2Tf>UWN?16CR>B?aGJ7MC<+R/Sf9ZV&//8)ABcYK@;(^cJLRV
1a1:4U;BNP/Z54dC>6)[b-5)?^](X=.)+Y&D^XbQ&U[\A/JH2+?JV0f>[_>QEY;I
?Y+P)U^?VfUR&aN((g66P^6/3F0O.+^8@N#VD17,QJ.#O^F^GJW6eb4O/HW#M#PH
=N.(=\ZMW6)WfFVcRfDSCHgF_9d3J8B&;S?E[X#_,RJ9FaJ\;D];PRP5fEYKV;?c
PI1J6A4-\W+?VR7L3PG42R7Ne[A-Be@W00fAL,72KBb8<HaW:;,)8#Ce#G=K]CMI
Y7aXF>X7R6GfDD)I/1?SZ=23b@EY]5ce+B&:9AQNfSM0f4BgY0>gL>dD&26(TZ=N
\TMb/O6/J;;)1OUFeE]?0fde49:cBAX--&BMC+,XCf_O6ec1+AWAT_H-B-?@cI1H
LXG.(gTU,1=H=IULe5/EHGKD,CfbB<R=^e9b8PJPIXK4YSe\Q?c\HV=?C^)C5c<O
,Z?TF_TVTB?I@,;<Je?K1&U9f+>]\C?]-E[]R>-_X2RKPOY4A^1f<COIT(D/RTS\
GcZ&g3eMB9UH1TW?KZBY8Y,#&Fd#&T5Nd#OIVWZPXXG:@MeJ<M#eM(5D\:)4M/5A
-HNAeFAOg6H7/3Q+TJGNFbC[QXG/JJ,_4AAIM\IA[de.Sa0:,;.OWMCWLW47V.6/
QK^8A(Z&cEM/^Z-10E]LA6@R^:>fE+_ZY,gQ3bN\c^YI9AFO>e8WD]fS4P5g[SU/
Z5EN.aLZL/d@6+#9E(Og\\Z35Y^d1&eCgOJIX]:(JSWMH#.CXL;cC2_GfKRY?cYV
Y2G3&g^DQ4UF4D\,<eBa6(97+DR6L5:6.6>8aLM:C[Q[.7J.GfQSIb)WMd#e7?S,
?Uf)3bILec4@McR2faQ;(f97dH8bCggEDeH\6F\S(P-UN-]-MA6UC>:P1(P^Wc4e
KL)LJ5Jf(WQBOf;2UY2.LdebaN-N7NVb4TW=CRfB-[WDUM8?YHZ@PX,]\=2E,_LH
C@U<Mb(I2fPCJ;S)[-_Q[.V1E0I(Y;_3J_[1GeY-<-T\U;H\8d1NMFA<&OGOWCN\
I9Z09Qd]ZdbgW?LbHg&?<=(@M@T-8)\4[1DWGLKE+]O\CMP0HHX3?GR;B5_>U2,S
75UC1;FW0S3:W]TW>A3-2/7V4MHHH^bXBZ&#]5YC4L-2R#UW6ab]F#)V=@^&[4?a
aN.1_\LM,78642<478DHM^aRb0L5E<6.T6((53&KKL7R=RZZ4<E33&D4/effK.cb
><QaEJ1G-RR^:#;MED_E?>,G+-B,b>9;\F&S,FVN0Ug=I=b7Ud/NKa8>eVXTVYN]
1(&1LR/UKc1RIQC^Pd\M4>X;85(LA@<^IU5IT6ZEEPFJNfV,a/UJ7@DG8/\3SRQ;
I-\.MDVQ;f),eSV0AN(T3YZ,]VPDF.,<fD.3+RE)\BfPW8;Q/J0^3WXC>V@f\^B\
M8.@R^;a^Cf_,HeR>^NMGJcLcU,<?XR/<PYI3UdV]c^29CF>B<EUTK2b3B,K+Rf.
>;4HfM+:cBSX\9B,W.Q;9c>-WZ+H/.edT3P[UL(@\QB@MM+8SecZO:4#6>Xc44#0
dJ=H04-a?f((8dGW]:3Fb1UFB[BX9J7AeNDM(#51TO/&[:RF\-FF?.MJ[OKWdQNB
?S/YfYK\86Sca#FR27bZBQPF_Z6#-;UB&dQ#0ZN[D;+Xd>UZ=)cF5A@HcI5DQ;e6
_)UW]d:e))d2_9(;FSEXQ#543VeY;\Z57GR7ZcgR(],M8\<4bU,2#7/bJ0=gI:+/
MV,D::P5g@17Oe3]1X:C9=CK@+e/&ea6EC+bA);=LS<(--g]UW@;25537RSSc)?c
+-,J5,gLcGc:<Nf<N&T]JL<K9KCGQeVR5D?57PT,>0GWgFgVTL..5J?_B]6E?,2J
36e3]XS?S.=0]+\[LU:b,PVI_Uaf6;J;03ERZNb_^<_dF.Of2cO^H/ff7f?S6MX<
I.B-[\ee77^E6M72VKUBWW_HY6^fZICMF:G4?AQ#04?=)I&)4WOGI.O,M7Q]U>d?
0KOf=P;b2.L[]#OcKg4MWV)0(b=a0eDOO:GJ^?eF6VM9R[^Z##Q8ZSKMeN&HJECI
:Uc<2D\cS]TSP_5LL2]4;+c@1O7T1_R);^ae@83fK#L=X-Ace6L]?A/8DE0D\OR]
(6PNN7e+O>Oa7,&,;4R]?U1)KX6O_fH+]R,f8>AFg6B@YF[8NbW.D&W38b:1>8(C
2^LBXZ5(.#7ZZU,/C#M>6dIBY6W85IKPXL70QBV.;JI,g9bF3^Z(Q1OZ#8aZJKC:
6]^DH,.L\U-cf=X:\G_<A;]M.^-g=\2Ae?AcBV6L0CKGJ6WBMdV:O_g0D;WD6@D[
(Q69_R?R^^I<1[N84=7g(1NCPa/2I,b;EGW_CQ21/CS<#2E>DScKI/<.-+,e5R.d
:?]OSebYf,-g7bTMO2MHE@HNW+ba&)EKCA-)[VNJ>;ZZV_7Df..,@Ba:,HAQ=Id2
8+^cQUGRH(Q&;M.Z]<&\Y<fB9A:[W]Mb(7UAR\BM6=c&Ia;JH-SQPTDfJfXg6_5^
^f+3E)gC=_>>c5WO[c,PEWIB\bSA1>[IH;#-fcfX0/E0^EY)Jd2EB2Z/A)AVXT#A
E:N#B2?c7::Y((e]M[6AW8M#90WbW)E#6X/53OWDZ0/c].@^626GGMA,KJ2A\DB_
[,Tff4T>8Tb4ZS,f4VGHU&J&UU=3_J9XP?AX\A&R\RD3>^_R_JK0OTJ1+D<4[H;H
]<[A4J)Z[Q-e6fK]<9S^,@5HVGJ^G6[R3VAc-e:H/(Q/..QDC3(TIQ)=_gI?gP07
;aY4XfB<.O0>F]NJXg1NI0c4DLV]TN0)G6:1]/,(8,JW;0_.T;C<<aC4+QBW&da0
ZY;@gG=Ibf]#5<ZT8F9CSV;A^SNRe80Mf9H(17/c052\,C>0_/O@IZHT4:Z4(&;&
W?+9RE+/NZ.[?/JG1];JWRK4_T??_b/Q==5--T/OB]EaS?-[[U:9ADS#2-OP-NFd
PDJ,/bH\JAJ1U(>LFDP6[5MD=R7Je4W:OdT:B])aSE:U[Kbe/_DKX8.JV_:.6W;H
H<RRG>GVHS#;=W2GFJc=.-OLQ@bE,+d+MPN_U=1e6^LV[PT&0+Y#]3,dfML2&,4@
,<:-)ZJ\c;:C6(W&Db@A7A-;]DZ297#c>aUOPOU1:N3UQ6ISVf7#7C3@+:]UE]GG
P[E0d0+/?AD=IeI6YDUEKZQFa=e(G\7;W[_,_ZT0-2)?SX_2G,OE9A=/W4DML/B\
#XMY.\RPeG1B&C]>I2/1DU>bJWA0(1#NR;IV(OEgU;/IED_bN7G@@7M4UbAQa3-G
WCY6R00W#]b6Z;;dHG0bKY[.O+\<VfEZY^K6U.JBf9_F5LX\8AeU2Q.6:;].9,2]
BL7+6Z7_K#]RBUHE<(3bP.5F5::M8W#D>I+a[T&[Sc=U[DTWJ>H-3=4[\AQ2O1MJ
LAe>Wg?,JCWP@;_8)4f.]>,1VYVJ3JKDU#JLS,4QFL^/\0CGBF#Ha,/DcdfbObR0
?1L9S]H1W,C4&#Vgb4X3;0.bART98)2-XW?WE7TN8S-HTaKB\^Wf]IH+/bUKcSPH
Od?aBC+O)3g<V?=2V49.NQc7]?+^7AVP=bbAE[ZZHRffNM(aA)[Z4^0(O>>+IKRg
V,8AVS<D5fSEX/]G9]SE(@G(F6?95_I3II(0]MR,=(TeT9;FgCHBTa(4A4K0G3O=
c,g.(?cb(b0La<bII?.4HNeNWa=[LJ9eS@g;d0RZ+aggH1G_YIO5=,W9P@/]T>Mg
[5JX[L[g-6/J((_We.ZK0K:TBdd]E65HP^V_R6;g4N;Q.:-T_4<:R_JQ4Z+3L81W
1U[.[CR)^>DF9?Y88d&VSCT#WEa=F<Wf,]3-JSDCc@0CVF@4RA:3\)WU+^c/7eH2
JNCKf(I1]@I4YV0.(Z])+1[D1:ED)f\DbW3OM.4-4/VfE=C6DcJG&O(:\<TS;JET
F2Q4=b+9[V\&OTfB<B^)O^DT\,WE>7c.b8Q>c=gW+L)T(TGEe(,)2R]0XbP#Db>T
_G,3?RKSEUCKPU=X=6>cYd[Y>Y3I<7Y_)G_E8<XC/ZW,B-DH6K&A5K9EJ;(H?X06
9g,G;/3L)BB+5STAFAe=cZ,210T++gZ)JP4TOdf8R(CR3I4QL:0aMC?7CMGSH05f
a8U1;?BMJ,5^Udfb)J&^]Y&IJ^5V\MVS_+:)Pf>#&&U]]+)E]K.-+6?L_B5/R3:9
B=\:WC65EKBaR9,(G#LG\5YLVKKSa2[A5(9R)A;@ME749X\FP??EBE2eMeM#(G]e
M@6P-9TA4OJ@>:>d+a1J[(dT[a.T#:X_b>\MB.9KFfH]ZM]BD6#1HQ@<&8XQSO,9
A+3:]W6-C93T=8=KA<ZH.-b+:8/4F37I87K)?>c>=X8e[\J?U+/8CBD5]@X.V\36
:CS-8.QCGWeRGbcAX=>g?:_ANEGW.8PSfAg#g0OG-K;>&JC/YG^1E/2#73Xbf=+X
\C@)98eUM/+^CgGY^4=NWKe-bA&(A^-_>/2OCgWg=@X;\F0(;I3fIQY5LQ.1JU+_
Q&FaS58<MFU0JNb2SE&c838-1Td?A-FXGgC)e>&JNKb3Z:YV[fW@>Q_Gg;O:Y0NA
6[#)D,-?9OZ\N0TM,BB+3_>DY+237&;c):N6EG<D2?SBcRM0CMWBPV7R](&B;:]P
ZgaaZ-S8R1/P_1-E,3,XZH8^2D-M5P?6M^cJG5SEZQ.4KdW\O;5)Q8]?RTbT-A+)
@.Z>>/W^NeQE0PaS/\V]6N=9I#NLJ@UO[.88A,d5X?4+5-:FVPcN>>V[L?S;Z<O0
21LPBZX[NU2aEA_51:TO3f3LT&F75.4O)EHdRS/8MH8;TS>VeX@9KME);JT>R-KL
5L;HN[XIa64(YY#/4?EMAY)Y16+bW38;QQ@1JVKd2dJf\@4LATg1b,M#H2ba/51N
=HfIJd9fEdR1#gGS1-BQ#H82))TPeY);G-/RB\Q8#BM<g-R&1S<(SWBXb)gO_\=M
@Jgf_PcYOOI[EB\#E>c@:C=VUY3[4+TM)1/KNe1S>GeIg2(J4Yb<?32HIY326#-E
_Eb3]#4+9_2H60WJ@B?f=:]+P5?;Q1@UA^77N1D>T<Q1a<#;E+L7&,>;\/=(eHMF
V5D=4&\UH&^F[POY<V:B[<7QC_c=9X0Z;\8=D&.#@VE&V\-g:F32eO/B4?^^4PeJ
c>/BKB)\cL1=2N._]T47A1S]dc5(^CO2Vg[SC]2OTfGb_VTI>9Eg&5:1HXge7<d@
?a:bKZgNQ[U0gC3KCB4Cc)Be8CMN-U=ZEBLZM:eC7/:B@+[6?;;TIZFLc/H_^@)F
[e82.AT2d4KJ:#d5(SdQ;YQ&IgVV<2f:4+3aX/J[Mf@^#7>S#<-+N-U@HfB#JT<b
GJ88>g2A[bHd;;ggKR9Y@Q<GXTT6D&/(@0Jf>;)=G]e(U2Qb]eNVVd^&C[):K2_L
2fM3Y38L.BC?S^-S?YTAA(d=aabCU;7-:cWT9Md=:I1AKM><7]H(V0M-E].+#IbA
X8R(?2=#&,W#\:D&)?TGVbI.Rd/8)(:+Q[&?,LD)ERDTcQ-L9J\c8#c7+>)WWBU5
LP9bQI-:CKA,J#[YbRF86a\a07HgD[DA@CX<>&)+LVEcCC/(X(XM9]58e]dUT2SG
A[Tb8#gYJ:f@d7ePfUg9;NI7?];D5C-g<GZQY]:Y3)Q@M2@]eMc9;eT?<,^.18<8
#=KS>;.4I/C#-gW7SKU7I_:YX@Sd7f9:4cG^2VBbg:2;eJE2R..M6ZK^N?:UAggV
#fXRT^?f3FY,(E>EYbH=49V^2(d0L/^9]1+6&(7H3]+3;0P7(Nb+ZDB(MeQJG51X
?c/+W^/ab/a6QV2&)L\;4Z5&@6M?f24dXdT1;U,0&.CC1T7]aYUN3#?.72A7=+:8
-fA0,>[8.V;=f^OK\XaH6LLE=1/7bXRQ]H&)?X2UdD1TD(dABWgWa&&S1;ZAbP8E
a_a4@1,R];P)BIL^XfRBQXO/[YULbOa^8#dWLNJId<Q5WC8Td>8MPAXQ;&Vg>1&M
8^5#1UdC881Ld<eN-+<La4W5dIacO.?)XVO^6gO\Bb&6)W2?KOPTG0Q_(a5J0@6>
):YXS9aaKI),;Oa[I.IG:J2\4QIST@>O0K1,1-QNWNT(GVd#\.b-fI2L>T7+2U5B
#Z2?^V<+HX?=>FIT+cL:0c)PG2,1PYQaSP2)3Xb7-48RJ7F=M?TUYZ5WFPbgg.BS
1?HRC_1E(IfVU\Cf0HPGVAAT>5<,+LB&Q:2BYgK1JR7G^R3aQA4)Re/,LUYYPY(H
J0TQKOR\=?bSM]+BW[IWDDQ:]T[g,Y<;\8S^>EMDE64S.;F//([S84A[eXdbe,N2
bKZab6=eEPD5VAd,1[:RN#&?N:(6.HC5O1[\6V01)(HQO7?Nd<c:R,N^C)VT9Q^^
U)BKbG7XAXG2/MT[5@H)>WeAAIgA5.P\L/7Lf)H6K=+WT2&>X5Q.f1XZM,)XQE\K
dYTLdM(VMJ.+L05W]T/d?V0-UGZ^O);NJ7/MX9F4HQFJe_1a^eb-A?KM&LBLId^.
d3N-gIJXDUY])TS879Df^D\Hf7EEA6F_C;IPVSH>e1:W(f7GI6XU<QOP=.EO_S]T
E/HU,W#6?O[>]8-c@TEM6]-?P:^e+TE;D&/aRHfa_L]M;AJHO91+dcfROX2IL5^B
M3JO3DOVe/Lb.K2<]e__JR,cJ&7,\M@fRgJX79R=&6+#Z4E8Q5C83L5Q3K=UEa8d
A2)#=\aI1?K-1gD_5WOG\KTb62CMa<fMU^XaTWAWc;#&E8;SPMUFR+U]I-7Y@K3e
J5NcFbUJ7A\1@Xg\TE:]V:+\OA=<6^0GgV9DC&WO<7#Y.)+bf@AT4+<;RDVVA^aZ
IZ@7&DQG)5],bMBBeHXfa@bGM0fI1.I;&(?\Rg^>50#)?e_P@Bb<8BV_,Uc[g2\3
H48X3FUG(YH=Q<301RaGK6GeH3(aD<Q7gL:6M^)6X.,Y(#7Vd<<GS&P1F_DEAY2g
4/Z]UZAA,[VZKW.RMKU9#5Q+9<P2^PM)W.VL<d[K5/9QAa4#^RZ.:4NZ5afT,5A_
LIK+cMd3cUH\]_183)cWAJ#4?F>@&/522#USU\SL[J>LAA9\VCGHI3Jc?13V?Z#@
3c8aN5b8[S:OW&^</bAf.[#H&aB3^+eb9fY.CcI^&fecS,++GJW6\3aR8P_V-+28
2H_1J93PdBg:FNO4,X?g]<Ie<\71S)4f?(S&G4?TUBL;.;P@I6<Z^_ZVf<4;-#M#
(RaF_Z6b?AW7_#>OEK>)C7e_5&/0U6N,(^TJ:J0V3R?eKRb=Z?HO1<[,LRU-,19a
Q-FO/-Y+IB&)UT:2MB@X7b5(T<.GK\I=R>J#e3](LP&D3V..>74ST,JJKR+>TT#L
9:_YW:VC]9Wd8TF<3(>YMRVT63(FBg;:S64--6.X/NeMWeE^K2Z2_C0^d5UB2I[1
-5Uc\#/cO8NAZ+CB6HHGaNPN0)bIDJLLfU7JF\C(>L6=O;fBX](UcWaSMU8^NB>^
Z8=__B1D?f;4MBU.e;1F=S2J2;T8;]:bTN4:,-8Ve:7cQg5Y>V14fb>XM6cXS@6B
7(RXW1((XeK;fYZ?9c0WU3>)@<5D5X.EX]#YJ@AW5#SW&G.)f.0U^48K),P\b@#K
VVR0a<?SRY(:P.;eFe^I:De)Qd,V_,[ASM_QX+eea&MD,([XYQ:Y?P72Nd[C+X#L
)XLQP)PgaJIKI+X6&UORSHfM7+H_7E2</VcW;Ia]W?B^Me+T4G6RgXL3^T@)@)f2
S&5(?DD_]_\?GE/1Ue3a_;O\+Kg08/&:&M+bA2714eQOf99PgGB]-e,Y>OO47ad,
+#.L4gd+e)8,R\O@]Od@06;K\&SWUbT0&;>WRMO0AAR/<+L?NH6[fCD8_Q-Vf=-_
d--#::Fc]9G1#7X2WR1L7OUeSM#SCU.WW^@&/K&?N@<8I2:D:JIR<#LED.P6#RJR
M;B,.UFG)4>e5,a@UZgE&^Q02?T55CWE^Q5dbJ8^&0SOR_Z-YIC/<C.8b@>+T1CN
Ua><2U-2g,SI=S@=LB\0CIZ9,Y)[cc.V_K4&CZ:YHCT^XVSAb98Yd141WIM/]]#f
?8[@Y077F:SF68gN2U+@ZTP:3XefN5B2e5a8VIAMcg#0AD^cTA1^AfN1C]<[VS),
5(7NV)\5YaOL@2R8;[PI+BVFQC.>54a)I^;G>CCc=dc_].d7LRcMK=77IDH<EcN&
[RPd;ZC/6\6,PW/0d:(XX8&c&A]NX=R4L9FUJbHaVbICT:7Deb#4>^M;G9;XY.X:
5;Ke>b2fF4G]KKD,ZO7@5)Ne\G\UR2IO]1/e2FfPQWc)]@ETb0c4BdF<gS<4/=<7
+QG\O,8V_<<=R_;[/F[-<.?Ad94Sb93aH8LF_Yf[QKE?3Q>\?:DQHXbL]\XSeFX+
-2CEcb(LO_2_BP0@DX:_A6&Ug4bU7BeBgcMFU]BW8=WTGDG\;De0<-,I@)Y@#GC1
(FdAC.)>Q@71]13.=KE^B.cLD0=P3&E67I?DW^,M):b641e8PCNEa1=(S4+a8[6W
1J_WS&b,\X.RYfV8A#SdEN5-[DGX.e1C@e<XU=TS>NO@G>#5O;W-bCUA#E7H4<cK
]8/I4WD17,GAa?3UNCcOF79]JIc5]=7/7HC3W((@/&&NHc[\AcLSd5cVZ\1<5JW]
@KH:R=[1<F\)?eB<,+YP\]X?aJJSKWRgS-K_NMPNAT=)+[MA?.Qc47BNA_eZ]/:E
HKS3=9g#H(AS24BPLXMM+A;<OC74I1Qae[U<>&BFReXHGEI-R^MSa0&(F(_\S5M#
#C1BcAc4RTXb3<OKJ?9PA=),3\4#@YH=VeW@aL>gN7Z]HZc6)c)O,?2gEW[6#8]1
Z<XX#3ZId.@=8A^FA-,g.Y]6(>cdb94d4>Rf))MU2H)MC<a<@(?S0]T)Y92fW=bF
AC2WfP;0^2(dcCTI6K#?.2NJEWE9NU_X3eAXaCW8X3>31SZ.)7)KC/_a.AL/#DLX
)&3?L\NZQcJ2?Y&f5Jb(JH=1^9LARBUPbXU\B5P>T2:JV[b97\<8ee<3<,Y8032<
OcWNa;2RD)YE_EGQ5<g&:1+g243X.#IN/K87-&ME;.FPdH]++LQ&8=2K6Ib9;IfS
eLHQ+VbGa0DCJ1L+1Q1_c<O(<FKdI1+DS#.5I[W#QK&B/SJ[G0?HOcL3g,V::HXJ
=,5a@P?V[M(b=]K-g&c&4b,:9cN85L)G.XQ(IM05FFbDMPL;\Mb7<DS]Y0HUN^GC
C1FZ\K2IAKZ6:/J@K10&;1Tf.g4D-_[)eYTZASeUN:eJWcASW@317f8AG/KK/4<1
TFNTN3O0LPR,6B.=V0R2d(X59gd[Eg_&]\RYZPebP>T0A8g(6L(V,GBWAYID=,13
B7^7g#XLXY[4FSg5<H?M/8@FC.(CQG?E&EUSMV?8_H<K]6#/b_+GeX(F[M5+5)L&
W&bAfW:^F66NbPH^E[dD.\dG]+;8<bE&C5S_Y#FJLH+4_O(c:YDM,e4B(6);>R0N
BMaI2b;9+E3aLg\12(>4\ME1dDE<RWWO),):QC>gC:)9Q&SJ^RIfK-2CKDVP;9OX
&b<R&AUE\GG)Pa=RKJXCNb=6_:e,^[eKXW?)L0M6)ST.bEE<H=XW\N5J+/>8)TRg
UF?fEHPSW:Ka&a]3@P4KUCJ\C1(4J91?gR/Y+Da,MS]cLCG.0R^=S(D\aVJL1HgM
U-2eC>=MJJ>^Lf+^2eGf[>(&T\YBOB?2@IPd.UU2+X3TLD:c;[N_<Ff0H5#CM@]:
I]J8M:(G-;&d#1.eR^2-MDG3ASX.=SQZ([LBEd(dYGfPHNg7P(>JCee1A1UDC+4)
+-+-C1Jg0[8RD\bS-0[L@&aCb#aV/.,/U/-aV;-OPHMA&6H=d/\\_>O_SEeEc;\I
6VM_W[WSaHOaM4M,EZca01SRYeH;\L@MJXEZLBJI^^S;5].R2RO<RaH3)@;:Tf&<
P&MYLH_]#K420L^EDE6.,DXX)G;X4-3\M9@>OcSA<ON02D,6K_5GIB+1?2#_;:6=
_<K(1.gUe.d]S)(K7G]1JT5&S#e8H</35;D1S\VY7:gcTN@=7gLX<LJ+Bg\F?>4D
HNbZ/J@eXGKY@KTIRCE=MM]N)c\dT<T94<>YC,?I@@+@e&SN9R,SO-ZMUGE);b,e
e;VbQ<C8#F3X,L&TN]XK=cgO(@Z5dM^fCPLY4+XF-(BUDN4P@.Kb->HQ?;.>9&HU
LV=gcMA]C^_H):7..[eMG+/eDQcYY<13??50KWG,Dg3==QS[EIVZK]6GW^EMMB^7
&YcECH(0c/]2B#d80g<H0BO/_\^Zg&VXLd7f,Pef+G<c>X;\)acO=R;S3f=+@&BM
g8?b-?TWdLBB2^#5c-GB\L/BRCG2L,#ZC+3W1]agK5g?1:W&,fGQHG,/W..?dLI9
eQAX]CPXF]5;(+_<b=ZHW55T-)Q+T_a]8I/^>K5Wb5]K@_6)f4OH-C))S0Zc(b8R
UD[WeB3cWFDLCQ=Q@(KS653E;6;6UT(6FNTB)NVeC#KFQ=Qbc?;f7Z9cO/ZEOLK,
RNZTc</RZ9cg?DYb\]Q#3F)(&<RR@.TN+3@J3WRA1,#RE;QR/1)J[J-&[:ZP<_>[
S+Z#74N8:,X;8XJ\];OY_+&15K81S#A&#5CS=BPHMDEA.G8&\af@+67O@_G:)YTW
EaP&a[bQ/1E[9K,M_LKGgL4W86-?La_7MOcD7EYS9[X:R3SVE2-UW@WK0^BG[6PX
[FB7g:=g.8.)0WHO:A;/?6U,;E6X1^f><#5OWUQQ@5;L5LGTPT4U;1AH8ANWdEAO
0a30&EP(P80WJ_a3I??MW;cNg10c<<I6)(W]C&&R/CZf1cC[W(]H@f3I]#cTTGdB
Aa1a#6\BHC[d8Tf02dR..R<=XV<eb:E[6D4)O@O/T+JSN>J+g.?;]RT6JN;Y1;I2
W1>)V;JPDY8UZ+5S+@>eDTfa>B2#WbYQ-;<6A896[V4Y0B,AQ?(;C-6VB8NN:T/^
J3S?)GBH<+_&KEa\cJ4/C0D/R]HN[WC:NP?2e(C0JTR>4=>Ad),Q/f]US3f7L;(e
-5XY_7L=/,P(1eD,T.)0.BX5]6:c:cBHJ@6D\+RKgF>STOQO^BXRBeeVZ_6.JVS7
NV7>8Hb-8<&_(/N(Q@<CdVR80GBQ7JGV][LT3EP.\F+.V9OF&dZJ(W8:69Pd?\GP
(&NU(b3eXEQ\\F9Ig@0#ZeRa^d_,76E6KUPP9X-dWd15.3)aF+a;d[Z-ZJ9=HabX
(NU(0cVLLa;e506dJ6=KRdg-J>-Z71,Q]+5SEYHRO#\b.<5-/<1LTY7>JTFGCc,Q
.bJcJ9>:IE9-J7RARGe[JS>0c@(CWG&26b;SgI[I@4-OI+A(dGe666ZDM=S]G4RZ
VWb7:NcG:H5b[7?J6E-2,?A)6P>b?eDM9c\KQNR3/W4.EV>gM=aIADZBW)#a3^Bb
fR3Kf/cJUb1-Y,#cLDD00&;F.VV;DN)c+<D(FD>YYb6gac/2aZA_>((0=U8ZU,5F
:QdJ&Z8]2C#fKRe)(KC]WGQ(?12?C2g3)(9_c;Q4W498FGb<=/;&^0(0J$
`endprotected
  
  // -----------------------------------------------------------------------------
  `protected
I7IN9QVYd9CdEcO=SVa<AOcNf73/5\)2b;J(01[,R72EY,[Yf#X7&)UN7HBFF[)B
g9GMHS>4F8Y[ES;+UfE4QScN1$
`endprotected

//vcs_vip_protect
`protected
MWA,T=&HcdK/IPHbKSW<KV4=X)C/dgM\2M,65,_7JEQEL#38-YK)7(g>BQS-Vd@8
O.SIN@H2_(O2bT@&PV3#1^QQ,ES^/c]=X_3bZUbLNcFH.F-&fE687EN\cKI[@@+P
F,9/@eVH8b7G<9<(dPRK2:MZBZeUK/4[Eb^PcNI,T8G#C_TA6V63UCdf)P7T3ab;
YXK/XfS]SB+-\_3.D6_,)2T2S>>fO&OIU<4^C2AJ5SK(VYIHC;]fY1K\?]M)??DU
/JUO9O14,HI4.cfGM(6+5/(BHOG^FJ,Z1U#8V7bAHEG=4H#\0Y.Zd2?P3L03T)1d
e2X+(9aQ_ZVJZ42JWEX@g&WBU;)5Db4Q604]G.F]68LJA8[BL\:Y;G1[,S44V<f+
(fBWF(^d7[C4P6gYABJP-L7]3]M#<TG/5)XZeIM,PeG:#^a>#NOQ+9g091K3[<8_
@:?E3J4ULKX41U.]0cY&:J/&&G-D5^aKO?WgLVa]=+EKD9_S6JW[A;I)fbd3C?0D
0#Y.K.9#K)_Ag^L3Q2&0DZ7d1Eb;-1_@8Z]VJGF8D@]QHR19_5c>ASRIQbGGcWJ#
4<58@G3Q;8Ab-b8IVW(K>M9=a=GEU#2D7A\[-YM=><_0Z)eM]Bb>\>B;HA8X+&b;
NAfXM.3/FXY?7:^BIFIf#.f>LZD74BEIbM4JSWVC5d1+=M@T^]-?)GH>E5F_=/ZS
_Q)#DJ?N8Rf;.0?\(N3\Z4M]3U;,A,A2COWJ^-8fE.cXNMY(>;.51DaRTSO405Y.
3e9YH;f0DaM]72QLFE_2ZeN\EI#JELL9:G+6?TB8c?F)FIWOY0QSg=CQB8_>45eI
cd?Z&M@220LVOBDWA(/QK;6[JW[/L\D(:@&:B51N\b&>6-M>(L9@NJOe?0O,&,<;
-&J8/PZ?>9bP0J>&J@)CV==83D<I-T4;NAcNN.N-WWFX)fDMLc/Y2VR=W7FR#cJ[
&IOT#RK>1KFET8@IFW@WTSfM+=a.0,(Z<Ff)B/(,]\fDGSX?)dEN9F+g.b,LNf^,
)@eGLT6/T21CD107I+DIeI/K<B#QRP)/,K3S9Qa1\S[M4<c[bg3X=W@<Z:_U0K=C
0M<dG&SO>402=B9D/D(_fdRcdH4HJ>IYW8((I&[Ta?QH)=&.4=7>PJJ[E=RIB3E2
?,+5K1^(0fB)KI.G0,,Y:4_(L14+EaWT6:CV_d,F)KZ:c.0D#:_cT^W&&.<@.DJ]
2P43O,9egQ\)/HVSS;G5;g+?,^YfRL_[.P]:UETg<,ET/TPfX]b?aVQ6a>W&ZVPE
)_Z;[1V&KQN]eU/\WXOGFP/6@eO;HA=O:5=N:3[[K[-AgXf&TV#^g(=#;9)378d9
Ja5/.]7?P9:1ZTbG;,;c]6G0):).+Y).KIWQaTRgL/=IAME?R-UE(88FCO)=<RPM
+,UO])+24FEHFIV<D64IDRRJ_Y&\_LU/>2XC,9L->317N:B&Q0\Q)DbV9N;g:B)Y
UMGI.;;d:cf?Ag[96#OdfBBXR8J#JG/9bL?-Z=Yg?-X.D[dG:5,8OD0;SI\RX.XP
MEe0-Q(0-^QKQbaQHL--\DXdX/eY1,>Q=$
`endprotected


`endif // GUARD_SVT_AXI_SERVICE_SV
