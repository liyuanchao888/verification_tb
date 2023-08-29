//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV
`define GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV

`include "svt_chi_defines.svi"

`ifndef __SVDOC__
//Update once these methods are added to the system config
/**
  * Defines a system domain map. 
  * Applicable when svt_chi_node_configuration::chi_node_type = RN is used in
  * any of the nodes.
  * Each System domain type (non-snoopable, inner-snoopable, outer-snoopable)
  * is represented by an instance of this class. There can be multiple address
  * ranges for a single domain, but no address range should overlap. 
  * For example if RN0 and RN1 are in the inner domain and share the 
  * addresses (0x00-0xFF and 0x200-0x2FF), the following apply:
  * domain_type     = svt_chi_system_domain_item::INNERSNOOPABLE
  * start_addr[0]   = 0x00
  * end_addr[0]     = 0xFF
  * start_addr[1]   = 0x200
  * end_addr[1]     = 0x2FF
  * domain_idx      = <user defined unique integer idx>
  * request_node_indices[] = {0,1};
  * The following utility methods are provided in svt_chi_system_configuration
  * to define and set the above variables
  * svt_chi_system_configuration::create_new_domain();
  * svt_chi_system_configuration::set_addr_for_domain();
  */
`endif
class svt_chi_system_domain_item extends `SVT_DATA_TYPE; 

  /**
   * Enum to represent levels of shareability domains.
   */
  typedef enum bit [1:0] {
    NONSNOOPABLE      = `SVT_CHI_DOMAIN_TYPE_NONSNOOPABLE,
    INNERSNOOPABLE    = `SVT_CHI_DOMAIN_TYPE_INNERSNOOPABLE,
    OUTERSNOOPABLE    = `SVT_CHI_DOMAIN_TYPE_OUTERSNOOPABLE,
    SNOOPABLE         = `SVT_CHI_DOMAIN_TYPE_SNOOPABLE
  } system_domain_type_enum;

  /**
    * The domain type corresponding to this instance
    */
  system_domain_type_enum            domain_type;

  /** 
    * A unique integer id for this domain. If there are multiple  entries
    * (eg: multiple start_addr, end_addr entries) for the same domain,
    * this variable identifies which domain these entries refer to.
    */
  int                                domain_idx;

  /** Starting addresses of shareability address range. */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0]   start_addr[];

  /** Ending addresses of shareability address range */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0]   end_addr[];

  /**
    * The node_id of RNs belonging to this domain.
    * The node_id should be equal to the node_id of one of the RNs
    */
  int                                request_node_indices[];

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_system_domain_item");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_chi_system_domain_item");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_chi_system_domain_item)
  extern function new (vmm_log log = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_UVM_TECHNOLOGY
`elsif SVT_OVM_TECHNOLOGY
`else
  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */

  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_chi_system_domain_item)
    `svt_field_enum(system_domain_type_enum,domain_type,`SVT_ALL_ON)
    `svt_field_int(domain_idx,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_array_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_array_int(request_node_indices,  `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_chi_system_domain_item)

endclass

// -----------------------------------------------------------------------------
`protected
IP>2af>L]g:,dO;^bWP48Y/#?E2Z14&Cd840Q;6R-/;f7(#f_V(45)?TfJ.<BW_B
/<3_fH5TCUJQF)#a(N6N=I826V1P73P8GSd[:P-3BJHg+V,7Vf0F^X:.YIMG5[3D
(+/5C,0#[_5-USYWJN(#[(^I@2AV#fLF77+&.6PEa_2]1)DAS&d?Ze[-R^M]MEC3
g1,=523.Y56?E</[#O[^^-GP;D]M\A1NJ^cdH,D+VWU6B(<-d<abPO;2]:X5T2,7
T,Ab>D:RHPT:QORMD>QYF[\0U4eK01;+Lg1071SMURffQTbP,c07bHee0-5cB,;^
^HHQd,C16fR1M7-OCC,@/6P.Z=2Ka^8U&]W[6?)](+(3ZK()8O_Q=^CPQ&?+3E9f
DLKKf+^5SLR]>:aQ;5dN^\KJ1b9^\>IM<.;/0JO<[Q^5&457N+Y?aEe@dC8.WDL/
Q3CXW)_#d^[6^852LCdV=PANM3L9f<X-2SF+a2TF/M7&2<;K]9#F8_7VFCH6_6/A
(DUW;3U9NCdR;?)U,X/deDF+/OT#YX(0AO&<E,Gb?W]T5Xdc.MV.6C3K?aUORPBU
O9GHE-G&;DDSWR1?AXD_V4g-[6?L.EJ;Tc0aGCM3X>7Fe[<6S.\(e.H4(9NcZ1JC
MY]).YH;AY5/#NSVD:B0)]Hb^]NAc+PVKJ8@+QS2CTFRV7DfPfC.Ga=7?)D&g[,T
U&#S2C#>1^(/)$
`endprotected


//vcs_vip_protect
`protected
_1WJ7NLUHA;ZAc&(@L12NS7Qb<aA]TOY\@2#CT#VH.]M[T92?>1f,(M9Vf0A_/\O
F78A;=fZXN30,FbBNT]9M5)<5gKH1:IN7^X\E62XP5]>=RXLF^B\V3PE[TgWHKVS
27_DW\PQCL:>/AG)JcbX)\H_BLQcL[Y\G,C/G3;0VX:_ZdJDYd(7gF:3Ab=^W;Q\
Y#3,01WX28U.RZJf4N)0I);#CYU.DY.d#\0MACUL6dS&T6VRB2]^UcU.K2WA(B61
6fF^2?[M&6[=e56AM#^9>_VeUV+O]cL])O2,QP]5LQU&IZX8F7O1LD&57IKH>8fc
7;+-IPKgFPM.[2328BUOI@)O2fBB\DSJ8&4PaMT?e[;+g&R,ZCGU9SbQ,)UFFQ_9
I/+<e0d(S2](-f:;>@b[IUI+.?XIGYG?V4^7Gd</0H5R>I^[/)H\)SMfHb<FA34:
TXJ_Z:^b/RLH]6@8Q=#/^<+CCMHEP5A.9YR(4XF(UAc;^C[VeCJ?O\8(B\@9a]>2
0c1B81@0^Q6#B46fHgKLH/e>T-\9=C>QAM[\OS7BO)?=LSY53a&Q:f=,C<8\OS(V
Cf-PMSYX]bLJ0E#=UN=^egQC9I,XJ86(.(K7[W\)=0CH\O<YMOZSI+B(3AXeV@b0
QGH-;CRF,<R:aLO4d-OJOU(Ra^497/581044P@@4B6d^/Wb202ZTFgTb@_bB-<Q[
?MATQR^.M79DY\19HGc=/,X)2WF;d<L?6?N)7I[^g7^OBKT]cEbZMNAQ?Z-=^@IL
E>ZH]<=#/J0g[7WZF(JAY^2_;b<>L(dI9C@WW\^HA&]&&GP17N_f17/1X#/U]C6D
b48TUTT4PgA7D,_T<:a5@XY[?C?,=?I8[<e,H[YT=#Hf<KE/fBR5?^GdK]aR.@K.
(9ffb6=[PILZgb]A;_KFG9^A+EaG2FIUOG]P;^\d^\Q3_AA#4g:Tc4EIH]H:J./O
\(WO^M>DBK[X#b#QYO-C_YEIIVDb#RAR?fH&NE\R2H@/+E?4aScN-D^V,gc6KS1#
))\>XR\4/ES>B^dTb#N<#-M9L6=8K;USXYQR-OaOa#ac2SJ+2=;9\K-J3YL?XgC9
Md,W1N#DAE;H<BNLR?UU-DJcfLcZU9B:(H95FL#S@7TLBRDUE):4c5=,S-\11a5>
:6[_=X@\]8MGgX78Q.)fdf/?R^LA56b;O5G#S]G+7L&/LMG1Q<7fO/0bY-<\Y///
_<E,,EOQfVMNgHU><7e^Z;>[0Z.B9ceFT4g99UABXB<\E79^E;>ec-=HWZA;RKPE
Fe&ebCOWbeX_E_[WbeNHf-d5gf1E/_/)\SdM6(3C_A^F:V58_8,Q91.F8CM(KTSI
8?b&,003a^=e]._VEdS950T+Fe6TD4T\1AEF1K=D^EObY((AW<KZ1ag#?N/)MF)4
11)EO]:5AB=G;N#.DS)>G(VJHfF1?9>/AC:I@[?BDTGZDXg0B)-SOaIfLIb4;Ad9
>KF?3H+BGWgb?PMbJ^PBGRL/1^B+cPQFB7e;/UfKDTK^C66F3I.0WVfUe>Q=c-EE
Yd@W<A0PMQbL5;O<JUIXLd-GE_e:dHb/a^@^LL2-_.6OOfQ+9#1K[D#^g<.RY8:^
4LN/V0AZ/Y:U\=E;b;DV/C>.0[:FDZW09,9,.C0Nd,+X[UdcVIS-6gf)9]f;@E\<
5TQ#1f/IYg]QVd0R#)#6[^E>:C87F3,#7TI\3^Q)9dXHSC.3>=;(?d.=8=g>=(.b
2S)@2)9_<>IE[?+D(a7:[SFd=G/?<3/9Ie.Wd>F-U/Q)U7c^TDO(=W#^&WYR2a8R
.5,LbJaU,JC0MM^K#BZU[7;5EBQ9TO1]+<:B^eFbLUe]6_GNSB.]J_LGL<T.^U_Z
X;U)/##S6YV>CKKX9PCD?[IRC@L(^ZM>R^CN8D<c97]9@B/aY^Z&6]I3;H0X)TY]
).Y0c8Q(<Hg\O@IU1_3R(7\S/1U([Md(T_7=#IJKV<BLYIFNOfPc71IAH<P<_>65
^=3D4VIggaU6]M\OMDX_TC,:CZfK;9Q3A&>M4,<U\\YB)0N+R4?egacKH.;<:9V9
4)-81-FDe9OJ/#^7;J0c8S4R7T)aI,81<.c;AgI)VS>V0[1;73^&Q<XAf&g7+/IF
V,C8c5f&\MaNbU)A1VR#MFSR4L,K?<\d:I6=]=T9:5]F5A+H9F@AH;1fH[6eP5(=
#)D?beS&]LIT5-ONI\fG[gQFA)5&Z,XGT6,]]7fEa.f&5aY.6N#&L&V#//OTJ?ZZ
_e1\WDU0-.444bc^BL6KXFP.RV5;\/7B8\eA@=E&13C6__.G#MZgf7:4B#A[D(Xe
F&,Zb3?^Fb>0RS&5XgB:^8X=7gg-[WCeD(.\LLIY2HP,bcI74-/M[;XeZ^fXR?UV
628Qd=:d@@(ZA^a\M5JHA6D2B2W[;@ZK@6g\YaZQY;SFJBe#J<99Q9\NH_AaA&&F
9cH:<<5MI@J-?O,T4;\GL@Z&BWKYB(^N-\\g7-PB;b.O8.H/@04dS@8=@ZQdfDB.
H/QedfEV/(PRK+DEM5Qa3VV?7?gB9:7Id?.eURc/dZ0V-&KNB]/N&K=T(J]a96I2
=3Q+@(#/+>6DGbEge92Z:#_G_7F]SOc<LT0ge/S0f/d7\=/bC2OOS4BP=GLgB344
P+\^+M#JYP3T(C3J\f>1NbD4&PW=dM2A1gN=bR?XA2K_PgcFe^(D7V9=eVA)-31G
e#b:8-6[PM+1bWZAPP9-+1-#fE:Eb/fTC27gGT]W=9HB8.5YF16FADZb6WXO99d?
T.DD18\W[]YK-bFYg?Va8M0AQW&Ae1g7SdJ:MV1cTdI3_GH/bAW]f?^4G^>TUL#g
>+.)]13,.OCCV7eYB2fUO8^>2<d#?JQ]WF.,+De23<Y[MT8@<af12Ue#E,V(OcCB
(E501]5ZX-Md1Z)CcObYf4K28g&UbXXMQ]:0W(5cb0(2Kf-B)T1SDGU#ag]WN#g(
59fFDYBRJ91H^GdU@>UHKRTX7>eLS+NLg/>B(F&&&CVL_Va0_UW@/MF#[^V]SJf+
TP^U5X#CPeS[b^#0,ME=IL,VP+=Q<1VO9FTFOX@Fd,@&K)T.NR2^bcCXUS9,O9F:
=G,U71FE0gP)8I&#gH8Y7FOc[0CfgCeAXG0Qf/TX;T,.?E^0g2Pc]0)+5E^2e15-
6TgS]a&[1(G;f]T+S9aANAN+?3OgHVM=;?gS+dV2K1aOIPDg?/5ISgZ5.F?Kd5RG
PI.3X6&df-WM<WX7BEUg]V=/,?<UXLdWA^HG1SJL>,dOa6[gXOVT6=g_TX(S8Z3=
@9&QMIe\\.R(?#?@eQ4G,Sd+,#F(C<gJG)GY/HcE<BO3FKEW92XXSZaKEIX^\=+&
87:KfJFbQ=36#LTHX1,T^2&d^CV0(;&dB[YOH;S7)b\_SG7:(6=N-J1&G[6___?/
S.?T82N-Z?=?6BH.0LVd_Yd3gaQJ\2\N,=IC]3fC3NAW&#DcRfa@Xe&U+eJ2S;]-
82Y[HX_R+a3I9DPK:^<-aFOP7dPCARO1V\3ET;+FKCc9]JPXAbR0;aU,2KbVcD&6
Pa2:KO==V/R/)25_=,IfT5PK+(eY.D?CR3<F=L+I\/#T;M&]9O/W+fU]GWb6Bge6
?cC00QK7#6U?P(EF9;G91NY;N:V6X?P,89?e)\P?O=<MS:^7FVefZ;f\=@22S]gH
)+e0(L?)B0;K1+\a5+?Q)_/-ZPK:Zc-(LGZ+DcN6>FTb.R7T9W+&+K^\,]Zcf[HE
+8_e1K9YR#YEM881L#S)@-JL:AR?AF;F:HH&[E&O_?1cTR95ZZ#U(+c?B1()ReD)
H]M-=HY9ZHVAN5f;US>eMCFR4(_B72OI^bZ9[+c&1>5b155;@_]F^5&O5\1T5ML+
g3?c9-d1ZB.Y<+\H9LZfH6L/9(D_W00G;&^KO5O0=F(R30d^86VPOf_:RMb8&LL]
/1/2&c?I&VF5U5K_C<],WUg_JI<g<HSd/N)U;B#(c;[SC9Wc_NKa[+_W8NH\<W&M
C+4bM.S6+?UGY5[.Z\UF\#A42eVF\MTWe;NU;)Xc2]-U^J8N_0;#d<>Pb>]B(-6B
FG6g#EH,\;FJ2DT?^)5:D@_)VJ:CaGQ^7WNWUH6V-@,Nf.51WA<T6D,&1gVJ]QD7
?,6@@I.C9E\[GJJV6XU6dW<H1X<X@UYW-(c3<NMH5P[9eLHe9X5<g\aIb]42aP4:
Ub5dPA/@#NZg@E8_0\V9@P0Z=)cf+@]998)R-6Ne5TGZ5dU3RFFcd38KZW&.aYa@
/.^=,S.YA/>&_Y)>eN&,bC/1K4S9VH]D346g_V?,>g_&E<+@>E#O>6ebeE-[V1/C
e>ef:P]QNJ<@UKJfY6K+3[^aC)/U>30KaYIU&R]V919b]GEX<XK86<HOASM(R33a
7f8(21]++.F.O08Z2?KgbVXDNI+.U-NQ2K?d1+XfS_?7Pc4CS/Ug\eY@NaWDC],J
_B;B;c2T>ZR8<@;>6??B6,-gNZ0ESI.02:_7[E&WHDCW?)Xe<4b4_>=Q)O5^?[]O
EfIU-4bD(g.BE=?32K_Ja;&YD5.9-3)(KfeK:IJCN;LE2LL;[Og2W=>SWa:]PbIb
K(a7U[PT?F7P4MFS9_<Y7]TcR,2d(CQ@g8OSLZ-Q6e4WEYH.M.E>94^)eJ5e87M]
-ULT>f31Cf6CEV+R;=GgF:R)_cIf@.GM<6UA_?SO]d.G=T:)-b@T+FTO&HXdO-L;
H?&)>1NU.>Te8M,YbQ7e^V8EMDL5JK]ZGJ:07T?/V,S(75@:=eaN];POMJgCf)M>
Kfd<7Q7Ka:cW4O5^YC9Ra6YLE1WdBfIU]9KQ<fa7+G),IQD:+1@W)I\Ob[D182Ed
J.^S2g?Y)N>-Q>3<=e7MOZ/NRH_0Y#.dG<O>;?>Le_39CE+7^A4_fdD@^H7ZNB\G
BbJ/b6ZcD8#UHLaP&0JKDLX6B^6UPOLZC#aA/2AM?-/A11OSUY@8J7FUFT29J.,F
F,N#YZH<E@HCPN4,4f/.3Hc=R]BBO&8MZ@J]33e)7Da8#]a880gYPW7H\U?J?X#4
]0gJZVaUI^5Z@FEVcg0eS50GeB^:YXef([Za/+;,KAK+B>KNG(W-K4A(Y#B^5A_^
[130JCATS=@,HZHb3)Fde=]aaF+Z@WgN+=-gb7+OO](b2KI,4(U:NL^HDF^_HAId
<M0(48A#U.?OCgI.J:V/@@+d6.;,cWK08VUH(9IO0GN^&MfYA;gWce8SD6;c5_Bd
3,R;N#F8/df&+H[CUMM\Kc]LbJ7>.H:T[DCLZ91X4YS?7)eQ/e/:X_+5<<UEM,4M
N2XD4<&_OFK;8B)_7+dQ>P+_Y>0_c:D<WAL+^7BIZY7\?;8GaG^\O=J9\U1UH5Dg
;T7@:fKFH:JG;4;L\S8>SR_WYg:&.gE3-a1=1V)/[//46+A9;.TSA&?P,==WfJgY
<MW0^9(+<94.K:UHgIg<9&BT+IdYY.-gQ9D7&ZUVB.L,KF>1/M0e9M[EHLAEOC<\
>7_S@64OB[_<Of6D^#c_[4dXC21T[=eXF/;aaK\0Sbf+SK[bBT<&6@I12)f8>&)#
&E;](+HU;&Q^)T/fc_2:];/a]Y7]GDe8FW;0I[;3d;6=66^CP[+1/NFN+>6&8#X0
d<.g6aG4fYUdZ&C+P;]\-@SeXa>g[]BPWO#0bX;@5,abPg3L_>GaVA9A)D1P9>EK
AK3gRDHP6&&H>38D]RcV0^B_Wa;XfU,U(P(5<1L7@O38;Ag7c^.5e&^b_J\eXb^C
4?@a4Pd<@H]D7()_#@8G880Q.?;+0b()_,L4Wd,.)GA]9a,XS./0)/7M9=N:J)4.
Re8^2\LD;O3HH(Vf,GRf9+,(<F]/fR;&S8Q1H1PAJOC\A=7\RGB0\]/>7PJ<4DSc
[E9bd7BaATC\6IE+2X=Q3#1RJZ@fHR\OU;U3=^GSQ)<gDZ09>KH4ERJQX+ZAGXd4
H2??IG.?0F<708)REZXf[Q_]<gOdE\#8Hc4Zf8WRB])T:HZ1Z9QZ4>./\N_-M]gJ
E39:7.DV:W:,WJ4C1Ad6TB.1=8LN;b9eE=VK3??_(f_NH-f#0eD+BLGVLe-D1c-=
(,P;&)>IITID/B)2f5[CSA;Od:9;Lb7==C-EAYOLDI=QZLf3@0@<:DIQSYX;Z?LU
(WaWaD02\K:>Y,1[?4@7g]4PJI<86?gUJOfEgd?2CcKITFQ#R4(@KR?IaYGXTdPS
)=1M-VW[P#?I32L\Z0BSS]-]R(-@3EJ79)E/5@c2^[)52-BVe.&.LU7;R<+AMcXA
4EZASN2Ob^(W+-3[KH_>]ea7acYg=d-+f8J#P_T0CDeW?2QcK@AYLeaC@B#VE5>Z
3[DRRc2U.6=HBW=UAB1O>HcO3M_9VNKS+a_(C#(KE::B4<A6KB+aI6]dC\<;7RdK
e;-R4^NKcNNAV-E[_c_R,;-=1>CZ(aT\B5[8++>KCP/Ug973O3fDc+/AM@?(45YC
OUd,RCWV<aJ=H8=,>^5Bd9T8NOYAE=?V+>>GB[\R&7R9^U-#/Y<48^N].+G=U>\P
&C/N:(I7#-_7eSVBSDa,;\XYUaDV&@2U_3Lb69aT(4FS2O4<W;0DMUf)0^-f>T^B
IcVJX1c\)Vcb2@(QB1/PgBaV)<;RV[1gb4Nd)#TfW[2@e\R\P#ZIbRJ^?SS.YN0X
D<fWHZO+.M_ea5G,<bUJ[I.NTY4GP&f4DWEUSaR<SZ44@OW,CSaE>OC890V&:B48
^ObQKB_36X-HOdEeTg685,&g+W:4SCD[5e8VCR_1bc\-(+89f7f^=:S-I_(9_XA6
WDA(=K--V3VaG>4YV3@GOU9ELHZ5YcD-&6E;@O&YBf3D&J&VTG\D7Z1O_([9bKW)
K5UW;Q-W/-ecTY,6E/M)S9dP?;P-[d,gT7:</_+Zc,4&A3R1VVR0IS&2_JI-cXEP
9bOB5Pca0,#HM_B<+BgfN4O\XQ:TTg(IHe&J,9H?NJKJ[e_,E-MgS62)9,M--08M
[&Re4faKIRQ3@gdFN;LN&McbHLMZMBg2[d][R/RTL)2PZ,7E41Ra(?\X5FK[CF)0
^CP5?4Q4[CUPQ\/Q<3FLHQcDgZM#I.R0Y8=G5:<4P+9J;W..&EDI+b9cGY0fB0LH
-Laa4[-BbQZ[4(,)L+YJAFJg\WH<g_9P#T9[HRX@K)UPZ#OH(Z)L1cUQNR\D8,VU
@VRI9f>O16?IO)[[\\:-:FDe?^Q0FH:129WT=LcJ_C511eJ+:0d(M:aYg,<TO-(]
5fTCB3UA32#E)ZbLY2KLL#Z]-)L?eN/A:J7+NCY]]NB+<V0CgMeWB<b3A10+,bH<
842VLFV)TR5/HAMP<]MHcK>H9A9@AHTKMTgT=Va19R/A3FFE65-F1K^8I&58K/]U
c?<6Y->X0BD^.D0X[\LVJ1gUANOIB:OZT8>2X<LUC6ddV<_]390IXFCgGceC>AZH
Z?^@]\4/Oa:H:O?,d1QG44/4@N+;=+PC9B.^.]8CbZ_2=)O5Rg5[,)#I2R<?#9DW
@A(A);I.-[1N&.KK4P]PGc,ZW5>S^H0+H#SE5_>cF;PPMfDQQ97A>YZJ_^eQf+7H
-RZeZCS+>HDB_-?@R@-I(?RHZX<SN-UF[/]C//C:]S<R=b8Z68+H(L&7YJH]@5DS
FWEY34CJJ=W,[S,(TaJ-Fd0aML8PR.9J,@RFBe#f&gM0B\5&=F9:EJa0THg_LeR@
<LOIKR(I.B_eB27QKZS25A\g?/,889\5g)J+YfK7T6,TDFb=<O9(Ve6gbQW:WJLF
-G-Y^eWX9]D7bJ@]-L?:R9a5;R[\P,Ug(G4+:ES9,a6-(OBCZ6GeU[_-aKM7PH6N
YY4:(G6Q:@HE?:Gf,C:_KYdF+JSE@UVX0XEg9CIcSgCCg<&H;J0=3O032@-Q=5B+
V[I&eVfRB,Z@c4HYO;4Vb[P)A[&/JMf#L>9dYb?>B/][2N2c4JA7f30M6#?F0@+c
EbA.D]3)gJ\P4AJZSaP^52bKIIg)S1^<4@L1Eg(-D#7F=KS/2]FeX>S:NV3C)UB^
FG8LbOg_4<,Z&(2W:R&<+VZ9KJJ4.X4-(UV&=&LE>TL:<E8bUeA]Ng\<3X_90GdQ
0(\^(Z6I7R(#=_2=bU)<ON_-fJ+4+,WO3FeaSFQ[US_dVDGd[/G@a,EYa-8F0@K8
G>#?cO#/EYUDNaGIO_8C+H,V(KWZ?ZF6CLCeFLfS;.fO7FK&)@<F#W2dc&]]eGPB
,2X;#Jfe)K19WOU3PVP\WUE3aH+<16R<R822_\aH5?T^T3;8OH<S\MIA]-ZGF_VH
3W_HZ_^gSE9T:dCIH\X5#d?FgQd@gZT-?>9Y8,;gO<K.16(2?.?f^fN/99Y@S4fT
EO-)KF0C8?@;g_fPR=CF1E?JLVHU,3\>FW^QOfC9=WZ>&IK?;QJ:\CQ=WNP95OCS
RA2E8=<MI\BRPbG9CIVMRI?TAR1C5NKV1-OJ>ZZM-XFQ4Q.<R6,D^_^\TX97;8[G
V1UWe+KKI586X:-Z9ebd&8>F[:9#\5QH>4L77S(<JS#=0M(/M,88LS\]>_W\PCBF
^b))AN3aYNO(GIcM#540I?dcHfJ@QNb8T4SA_e>5H3QME5Q45+FfXgV:HBYe,gNH
B#BeeV00;CaO)gE>G:bWH[3bfS3F46b?cT5Q,-7A[SZ8-dO=eUH=OSVV<_+0dHHf
I+--.@c]@X_^9>b7)Z_UTT?I[Nd7XeDGU5F&D/X0>T_O0PT?7b.J:b.#O\WQXfKJ
LGT-OUT4gIg+1.&4]PA5HN^g)-<MQ^U1QT5b+\3&I]>>T-)KE+a]NB13,?-SI[4S
PGXTS2S.UNgc#/T-LaeDT6NbO=RL.Z-cO01VZ;8;OeZbO8)OM.>1#RPKC<=<)cSH
E,HP2;]B&:QY8O6[E]#6eK:>I>D:S6;J,N@1-TDM7S34_5O>E&22(39,KU.DJ_J3
C/-3H,bQ_(&]E_&cW^8NSXCE9EXR:]@TZV+F(b.SDK&;Q,,]dY#PIL74aK6[]HDG
fV)6a=B3AL_S]_c-8LIXg;9NV57#ZPMI_)@4dZ&@)ZVE8UBQCN:C.E?E\,Yd)7H:
Z<NBJ0eD14#7[[GL\7SY;AAQfc)g:+6fG.LA)8B(+9f\Y[_?Z/HC]OTYN/-f.(C.
Y13;0EFD118KFa8fO]&X[XO;bC4eU(dKD\-/>/HH.L)0D/g:4HEK?^ICZG_>NV07
V2G#Qa_-4H(F6=3;A?Hb^XG^WKX;\,dYH>.CV/;NBZJ2_[D)(:Xbaed&J>J2?VQg
\LZK&-;W0#9V1#)/bY:9)@NJ_?A256F>>&LV<XHY.Z-G5Fad;RdN+A6/LZ)DeADH
Y6K;)Y0#(79-]@EJ6+d?_@.]6@O]^EaU[-BM35[1Ugc9&<.gY&BCL;LW.c@I7BT.
fDKEJ57ad:78H9A2g4(DV7c^TOO5WP--D/(O^FgR[aNV&RX&8.8@G^N>@beIQ537
_38aNe0Z-=DPYQXa)><gRZaCAK5e+dM5-.Q:dbC\-4R3Ge@NFN_CDKEOaKaRLce(
RF-@g7W:CR=1YXB>6J0E?\Cd55\C=^3S6;BVfff@g.4K#-A+gJ8@#+BYL&D5a8=D
?f@FR6^.bFM;H(Wb-A99g4K?U9IOB,[>(<@][@[<7BZ:U+,PLC/.<QfR-]/]3RTY
VUg#UK4^MOc7VP0O.V)9a8GL8\C,A2=67KT7^aU]1+A_)4a\F]5(<QCJK,3HWW^^
0<OW-#cN_NW07AGXF6?)d2VY/JfQ+Je?=S0C?E5,V6Z;eDH=B7EKfK=7\>ZP193+
V70O&-Z1\52P4BNa@[:;=AN3;25aKV+(AdefX]?,X)Y0A^29D-<D/97=1SOc,>Y9
DWD^gZD3T+<O:R/VJP2Ef.;.(8I,FcCD=+a@@V.<6f-dUJ-.MNO[U>C:OQ?KbaN0
Ma,Kcd#;_\XM;Q-^X9)dJUY(8Jf+b;6P6?YHL[b\B\gca/CZ4?P7a?2JGK=))&MG
ec^2QdML/bc>>RI?/]5V)b//Dc-:D#f&Yd#K1C4[,BU0KJ/C3RdV@W(FZ9&&e+16
]<E4N(WeQ?DL#;0Y-/I@0V9bHbSfWE0E/D2W8SH/OWD7;cI3.fX/B6(3\)/96IbS
IG]0(a;Q.W7HI=M9A:3?BKL#(DPGF^Nb]@N-/^T]2@O9WN_:/bgT+/P5Q+[>&>3R
\>Hf4TP:U<D[DMdBU4e-8Dd(N^Y1FOF+GUMS#1=#,=Y2>?2I(Q1N6PS#:\8e93\@
1M#U/V1^SWHLCZ5S]3=@^1QCGJJbCSK@J&8>3F4E<&;,(c2#,)CgJ[SLFMH3]UH,
G[();7+NeA)#cHgP:9e=gHTZE@&F8X1TCYT59:/0fJVO?=5gfdePOM:AP+<I.V_Z
&a=T^HdIAC<W.Hd9c;MCe0?T?D0FC@b<P9YcUIZd5;\CdV,5Y,7I.5/T/H(LeCUT
=8Gbc6C1=J]_V9(5/_(\+CRQHM>GRD_E67@(GM/aMcBPcXFIS?T3Y6U1G1Z_A]?E
T^)?)19[6CQ3XXgBda+C6K12[YG>;L4W72#cSGOT.D=f8e)0M69=D+EDZOSgH=W[
V2=Z:HD0f@-_N4GS0&A,;0S^FPObKQBNKM^>[\T2+--?e6eBVZ3.56F4POBB^1:0
VZ],P<Z?73fAFM7?BQLRI)T?#edWC(@[\02ZJZ201)_/\OC/PO<27O,[^BeV;LGE
^)9-d-eFY7K&RBA.G1QGKS(8&1Hc/38:e4\,V^OIY4KBb.D+REC(71e__Qc&SXF+
</=PZH@(Ua#TCP\=9JNI-eXS-c-g@(UT?D)Q7GIMXI[-->bSX[G0a3O_a3_AW=DB
fZ</1O5/QPUIKCH/gP<=0F??AM+KCFLfU-_XA?a=a)2=_R;TcW^OX<WG2EgFANHH
<T-W&VP[N8I3YW#2R/TLYI5<GMaZN;BOL+X<TR_XB2OEVPYDJEFGKCceL_-_9C^>
:OeS,(CDFX[C#&\GUB4QVaFR=3b#gKW0HIM<I?LW:^0ZC1Yd1;2IZHK5R:#E2:IX
ag(6a^AG0fcV[&GL2M7aQc>@K>DUC9/U83SK#3^,B#^M(,2f.7+49cDI#fIENFNU
Ud[:TXBV&JF2TcSgG^eZ\Q=IMM1:MI+07^UdK@10bRU00?ZTE;M^DI)NbQ5U;&AW
T[6@fI]Z83<Ka6H6):K?L6-?-ZC<^XIfXD-&;[&MSK@^:12?9U)IA\\#(@gA/>,;
H.OHIa83.EB[E-A-:D2g9fBG4.&J6X1^4XQ67&C)dTGYXdS/H_/6S^/.K9]?K0;6
EOW2>&CG&QW\_](D0[OO_(Q6/3#b:F8&3UDZM8.3;a7+PQd#O@JCP,I8fQSV.EdZ
LOaM7X-gd.CfBLL\39;U;B#[UG.51\E_Cf_L&TAd5)F5#Q?IADO\;9d<.0+SRG2c
>eKO+SE)AU4T,KZOE2&eN@0UHMAP\T9-M0a^N>&G.CIEH?6S&WdMM[(;9MX(5/1S
066Y0F2<Q&4bO)aPR.-^0LP[FT^Y5R]T5W2LWQcPg;fYR7JU1:GG8_9U\TVc\[;M
^@[@]5,8AYXOXb4FW[A-(=3@>F.cN0LV.S&LAN:U/WdcdcY1B5_d+XNQBK3;-Y0S
OZ5:5JX8cMCL?6IIK^JW^3N0G=[0A^aC(F,V;YO#09&L4M@c[XUNI,b8,3NSBNNW
e=3H21,+D_&9a^VGad5E-3+CB.2R5E]1Nb-YWB]3DD(_e=Y#g28WEDG#Y5eF(#;6
b+6(6cc?1,^049+fK:J-XA(VXNJ.6(+SaKCe[d>cVPUQd=>&-E(\e6G#N$
`endprotected

`endif //  `ifndef GUARD_SVT_CHI_SYSTEM_DOMAIN_ITEM_SV
  
  
