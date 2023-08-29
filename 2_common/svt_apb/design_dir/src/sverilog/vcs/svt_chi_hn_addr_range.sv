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

`ifndef GUARD_SVT_CHI_HN_ADDR_RANGE_SV
`define GUARD_SVT_CHI_HN_ADDR_RANGE_SV

`include "svt_chi_defines.svi"
  
/**
  * Defines a range of address identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_chi_hn_addr_range extends `SVT_DATA_TYPE; 

  /** @cond PRIVATE */
  /**
    * Starting address of address range.
    *
    */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr;

  /**
    * Ending address of address range.
    */
  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr;

  /**
    * The hn to which this address is associated.
    * <b>min val:</b> 0
    * <b>max val:</b> `SVT_CHI_MAX_NUM_HNS-1
    */
  int hn_idx;

  /**
    * If this address range overlaps with another hn and if
    * allow_hns_with_overlapping_addr is set in
    * svt_chi_system_configuration, it is specified in this array. User need
    * not specify it explicitly, this is set when the set_addr_range of the
    * svt_chi_system_configuration is called and an overlapping address is
    * detected.
    */
  int overlapped_addr_hn_nodes[];
 
   /** @endcond */

  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_hn_addr_range");
  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_chi_hn_addr_range");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_chi_hn_addr_range)
  extern function new (vmm_log log = null);
`endif

  /*
   * Checks if the given address is within the address range
   * as defined by #start_addr and #end_addr of this class.
   * Returns 1 when chk_addr is within range, otherwise returns 0.
   * @param chk_addr Address to be checked. 
   */
  //extern function integer is_in_range(bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] chk_addr);

  /*
   * Checks if the address range of this class overlaps with the 
   * address range as specified by start_addr and end_addr 
   * provided by the function.
   * The function returns 1 if the addresses overlap. 
   * Otherwise it returns 0.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_overlap(
  //  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr);
    
  /*
   * Checks if the start and end address matches the member 
   * value of start_addr and end_addr. 
   * Returns 1 for a match, zero if there is no match.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_match(
  //  bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  /**
    * Checks if the address range of this instance is specified as the address range 
    * of the given hn node. 
    * @param node_id The hn node number 
    * @return Returns 1 if the address range of this instance matches with that of node_id,
    *         else returns 0.
    */
  extern function bit is_hn_in_range(int node_id);

  /**
    * Returns a string with all the hn nodes which have the address range of this 
    * instance
    */
  extern function string get_hn_nodes_str();
  /** @endcond */

  //----------------------------------------------------------------------------


`ifdef SVT_VMM_TECHNOLOGY
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
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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
  extern virtual function svt_pattern do_allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_chi_hn_addr_range)
    `svt_field_int(start_addr ,`SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(end_addr ,  `SVT_HEX| `SVT_ALL_ON)
    `svt_field_int(hn_idx ,   `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int(overlapped_addr_hn_nodes,   `SVT_DEC | `SVT_ALL_ON)
  `svt_data_member_end(svt_chi_hn_addr_range)

endclass

`protected
CM2PEP+b9e-gF(@^ZO[F/a&EUI3<6X[KH0V614+I#+51]4DGAdRQ+)?Q^IeDaf]F
GHVVI]XHE#QI&1cOJOI+0,Eg+8ZMFO?F5?R=fG&#_]cKHK/QJ<)?Y+G^^f\#1<)=
0#E7c-5V()N\1]g0AJeF-.<8,W-^/Y#F3(f1Fb[,FW0dYcY7aUGAC7=YHQU#[J21
4ZaQ^,E:CLYg0]Y?LJX,eZB]Z@60IAO&GXYW=R+,f:b-bbdAE,-LGGeIe&L.B9W^
84?)X>RJ68(1?P=1a5/:befOA6)gVNBDf)DLg+.43O?<3KcdFcZFL;[K.,g\eR2G
J7WA:GT]O/D4;3E9LEX-eD\V[2XVK-c-<<^_G<SEWO]TT2RR_J<&-@_X-fH5Y)SP
^^f7U(_7:A6?N1N\B1?D\A]ZHL-7Q,\E1R3YdUS\OZ&DVcHT+Ja\b2)3IXX@KVVF
]TF5R];3QaBWD>6Q[PBdM30a7NKNHb>1YE;60Ia(Kc9#Z:F:<_5HQZ_-WWfLIe3-
Q:^F4#-P8;5F(_5XQZJ8.g,/LW,0IDT&F[&)Td+W+P(Of^4DJ^CDX8\ER[LYF#,K
92T#Bd_L4V;MF]c87#CBCcF8DB-U0aB2ddJ&BDC9;(A3FFf[>(4#2B<Ic&Y)[]_H
9WE1CeJHVN59_8/Q>HGW&TLIRCPS&/OI<$
`endprotected


//vcs_vip_protect
`protected
>P&JV@0055V2;HB4f(DHgN4E>d#\Q5L2[^-/);+e?XPU.U?KIM\?/((f]1gCdPMP
22dGCY][?g;#g1B6QZV5S?cbJM:\Q6I4=/L#&\c7_<<7ZL520WRE>.JZ_:,Wf3+T
RTY(V+Xgg?/HG-,EEeJ,]=YLaZN:;85cDUdL<e>Q72KbAL8;O0U6L68Ca:eQe9QQ
,da#C&a5+Y1];[7Z5TXR_U/.S59_I^CB#ROc@9LJ3JW@5d?LM[Wa3W5VWZL;cg5f
GITJYSHLgC=R;5Y_3G@K;R?X&:/Kc(>0,dVa16C,E2)X6OW(X?a(eX\036JNH5FA
?5]>4E4bB.R=PUBdUg=<#gIGB@1:&gFYf[,-/F1,g5>)#1<V)^c8T4f=FLQf[.WQ
:H=@:AL\TNIa8g29e,^FM>b=6]5R-/THYacX?,C@83N24T1_V3#W1(\Ma8\HT^O+
fNafWK>>Ae,c0.E+ObAb7))4YM;LX:4^\QN;>:R)\Q>9dJRBD-O+a0QJOA?L.I#U
0^0?9B#SaSHV(\A.T=-[DbLP7eLaG;dH0dA&#13@2GNd57b-.;H4Nc=5.>ZG)C-<
38,&#.]>fH88_gU1,gMM\#De=N7WeT9]e#4(G-JN?ZU0<>gF:XNU)L_>[)aV0AE4
3KT#WR:T;1_.R_=L&YKW)0RIHN:#<YH^((.XP)/4#0IA>[5F;_YVW;<2KXNaTe6D
a]9#\_\WR07EEd7cQ6K]M<GC>AKUB:M&5a)T=MBX>RRf4B3O?AJ_S)SX4@2@I-VZ
GeB,PbVHKD1-QX/:ADW.7(Of&VefVd_UYH;gaY_V./Uc+^OD/PIR9a)@6G+Z]2c/
]@?N5)SVMDdNV>(#+B3?M^PMQMc[BG&V)JA;0,EZAcR\@LCYFg>2BbEH7\?NR6[V
V204/4+S6+IIZLOQV#F,g0b4.H-,1@C\H;9V1X;gF-TE<-cDVRFX.W]W[G<Ea\,P
W98YeQeUX7<3+SSYX+C(e0B&E>c6c;<KVJW^gK]PNg+XTa(LR=3D>dF=?ID>^2f+
(JWC,:?7/@(1X8HLELSKb&I(N1S6&0UgBE<g<JcF(:4PH;+fEF37)a80&:U(:<MB
J1eKDF7FP1^KBKH>;<gTE0TXD31e_00U=Md0#[W1&YEH75:Y?NA67YS;OP2-+6VU
ST0R74^^:KVJ=@f[98W.bFV3=3eXWd8DL3aAa0[&D@GF#J=Y2APW1^g.c:c@)J=I
<RF;L?Z5e)HW.3UG-BW<.K_&D9,:(g9aG1\D1USJ:UBfW,-KXeB;0):G@?ZfU&],
XAY4SR7_+.5#Iaba/1+W&OH&c(L/F@:TR#1cbV,.)fY+2<U,egQZ7_gWS3?.&(/S
O2IAfMXc^2I0I\\WHH:;+-^^Eg>\@\ARfQ583e_P0Mc#\PaVJ^QW)@.<^^ZdE_(R
>1E^5S9C-UJ(8EC\5>]OBWF_(3b))EA9/8-[PSPNFA)e;aZTbeG/6.@]GaHE[1&C
XWDCXVB<Nb1/89C6Vg+>;:c2XFDd)-Y<^:S.HJXPS9H?M^2_c;aTLfFZC76E2AOF
&3284&2^:ff&&L@T3g).?J4=M,e5,-b2J[I@4f976R(WL/])E<?I)I.[\(Q\/XPK
[8^F2AIQO/RWG,T-.S^3e0DN&DVdLHO_6FefSS1aP?_GCL]b;J,bbfb6Q&RE&#I,
1[^(a.NcZ<#DPbN&MKK9G7RL3S[C]B<B(K+:]]\TUeec8<bG/(aI.9UfU&).O-Me
ZMHSa0]#]TW-ZJ=FDT,/RT:HX\<Eg+MWMc?-S0<(,8Ga6(A2KC7b;-D-M:Q+X(.b
-d)@J5)=Ab0O@1<]]?_U1N_82JPB+V=[_8-8POKYgHU45ObOBE#5W1@XFGE#8ZW@
)T&2DKc75[HPV]H87HC3#bO9LJ#C2DCKKCDP7Z)5;X;WeB0Yd?ZRD(a#?M?LD@J)
RQbFL3d2]X#3<c\=I)gZ<T2D4A:>>#CMY@8WTbJMDG=F6CIbHJZJa5WTNK<F/>JT
WBJCII.V<Oc0c,-aI0SWY[6-ZD,^2X13SIbSBe4(LgO)I(?E(@[X?R@-O+Jb7TFF
FdLNZ&,b_K44FDBeA(5=[A:dCK?8F#d?f[PNPA>97LQaZV]&Sc/7J5FP8:X4B&bT
JM_MZX5+0<EVc)Pg26<]Q]P&)B5Gb(9;_HYH7.eFHd0ef^U3-7</UHdZKOMO43-I
F03_V\B5DdKJY@BTJOTCcG]FK^S/+V@R08JQeSPXaI[=ZfQT-R4R6eF1]V8;&5;R
&YIFLLW?NYVK3ZS^2GBK52Y[NW8HM^1&eO>3:)AA,\0Y2&[_(8?E;4gCW7EAa=GP
T,0WMe.5dJYV^E,W0Tb-Yaf\Z/TK:KT+VOgNQQ5e>3#[5N].M<=<CJ86M#SB1N0G
8)0N.+#3eRF^J6ScSFHDFBQ1\aYAW#7S+1b6#@,d2b\KRRH_;3HRb2b+Q=dK?3>T
&;R2Q6:LR@P\8c??BS?:<Y^I7dW<T:HTMA#>00S1+(DNK[B@XQUaPT5,1>d3K8c@
<ZZbK\^HcZ_gSZO[e<04FBJG&F9MP8W<,LI5A)IJ#^&bYYY7C:J+S54<8C)E^@<(
E9b=[23ZAT,cFT[<@d:UL9CR]]28=6##+8-99TaE6fH)V_EEK5CA^^[Z@7^=BF^9
PdCLVK#aOZN;dMDWB61]/SH#=AZddVHFeWP>?<F1_L=G3f,f^;0^=OZ6Oc,]H#)+
>E?:?TP)[(NgYgGWUIS,b>GZ:NQ.]Lf^4\\TY\5<,\:+:(3@S==7RbJ=>:JHPfNA
RU3ZY-f?<UE/fKF2^)J1=1>5d_8cW?C/SN:E[EN^JO./&EO0Y7IU:&a^B0:VCe]b
0PB:aB6^YYZQ,WG<B,&:./J@QF6H>TX<BCS52Ib^d__H.B:[&6b51aBYccTWXZW3
7TRg\NS0.NK9O-cIN-J)d<c/&bG5<7KX#.YO,?d/\T)MM30L(1-1/IRN<dK[VA55
7TI8-<_O5Qb=U;GORXEF-0CE?3\/+3M1cT.ZTYI@CLZI^GAg_LLB61UZ#W+Md^UJ
+8]SKM#+Y16D&F6^\-:fVEcg_7TXT21Z7dQU-+LF+_+&B<_EMGLgc?>#dNJ)EIGN
Ue4/Z3aHS/;B(N_5^_^f2ZaCX<:Q&RFA;/4VN8EG5/I>fU:-?a_OO9=g0+S#4K@_
SD@2BUBB,#D<N8VD<HXOY4[K0H>?R<aW/GMNe^dH40Y]#WV-+)B+cfS[;4F:/#FB
CIHG=CZeQJ=A(S&_g?P&f7?]:gPI\Z9BIG.IP6P70?fMf3+G2g4.,QMM\)B:A8CL
=#[LKA9cN;K?6e[;PD?X1OO4gH]=H(=Za_\,d0I\TYZ\.M53D,R8]W3cfQAMI-^:
EI?&=.SFZFFM;E-.N7(dN&@<+g:BVUZ23+1.;^=Q5=4E.WFV)J#&>Md>d&.CKCHC
R-KH#E<a;S.4Ucc&C,;YPWd3&G+Z+S<a-X(:&42T]JRXEX2AZY#,Y31YFC)RG&0f
^J1WD@-PHCGA4]1J5ZC5.6c-2.\S-YASZGJdgQ]U7gePJ+TK>:3dU;]eH[KC=-NN
G9GH]AR>5aMK(WZ.a\D\=.CR4#\D0DOcTb;bL^d=DZMJ]7]U&T_&5?IF[_--../-
g-^8Z#(-/N#+?9b,=/ZI[GUbC[Y>9:+AW\8\Bed<PRcD@fPUQ@X&S524#:(fIMVI
NLPFW.YMa@U,#c:M]CR.>\5cAJ&I?F3Oc2]2OA.(Sc5LX:8DfAf?7O0BL^(40([T
6_S-M@9ZAQK#.8=V.#OMH=EU]d=Q:SH=^8GIdN/0)M:FT+Ga,GMP5NPRI6)V&>Da
+JCV^18\92-K6/M;=B;WQ-FNUAYebKeTd3-/e[R(6>#F)V04(DCHZIVRLBCLW:O(
P+<_?:UYK)d,@#bGFGZY-eY)6?H5+@cHD<(fO0PdKN20.C:0O,4_Bg5OgV8cATLO
TDTVGU,6LVGB>#:cVP+3)Q>71M/8&H\TTO/DD-&5SLI+I7D8(F)fO;eKSRG8NN--
/X-4e04UL4_E3B&e&1GCQO99f1\G^WK@E6g@E2;AcSe/+UYMGBZ<>=MLdZM8;HXT
Z)/GU7HMN8C/^W<AR#3/@cTBfQZS(\6WE3WPQ-6ge^6Q_fMXgKWQK,)-1Y?ELQO=
MU;3@FfSAf5/8\3.W&SPQNfDE#aX=ddW>4)0[+DA2fDOT-L;5;U;TdWQZI4[K9cX
5S-TVU_SY>^T[V]00?57.f:DaGBODgfVTY;a6_b[d&^CaS<S2e52V[#/&1Y_-T^/
K2OI5,,3@?Cb(0dR((0c.WV7E/b8O2B=KM.(JU24@3Z#1@.<YQb3&D<;=79UaBH6
FN7LHV:^JL(@4US9Ff/LE_0?CCK>cAG6/4#L0MObH5\[e3[g?S9[G9R[N+-b8F5C
NJAdf\gQc.b>/a1TS+AF0C-NPCF1#e-/+^U]T.ODQ5X-g>0G2-U)#\=#)I;AfI7+
?W/9b-X<H=9KCSN1ZTf_^>8.RMO^N77X74.9D@&1[D47\g386//NQT5F;FV-OH&)
8-RS-:IJ/beWC-)6O)\AQ\>FALef?DVdATW?VJGd\>8[8.IgSd4S>+DcS_aF53Y,
-bS)dH2geDCPe76BT5-AN_JL?)5CeS)#CUV.8SKPXF,CHHd-RB&NeX8&@?GA4>MF
?IS80^>\^FOV,g3PG&/I)f@>[]9+dI1caHQY3Y@J8>^bRaPM)N^6^;:.#bC3d7?X
2ZgTJB3aVVb-:,Df7^>=V?--4^TP)DSWTE_):63,B-X1BF>cT-OSg\)ICCT-\Ze^
ccg\<;>A\AXY\9N/16B+5;UaR@,DKcT5/L)&Q+0b?T93KYW(AH1HLNX^_#]>35QM
:F)HWEVHJ.;)L@9QG;Ud<P4HYg>cfQ;CZN:OH#8O5P<YM6)OfIK2D):,Ec)5&H&Q
-_A#(]BY>9Tb5T@)___@,S3a65TIS7Jb59KTGAKK6UL<E/Zf-CBeKC&/ZVR_4TVL
]W_VH@f#8-GbgHc84d0\cN/e=EK?M?GJaUEL>\2WR0Db,9aD8^BJ6AKgF(b><VZG
Z.V9\+(?O+7^(Z>P<:9G,?MC)ILfcL]]7bYTU)]>9#c^7ZZfe3(TUD)7cM_;4WdY
32aN[:;3NI6873,J3\^N\LM#JIX/7/R\Q6,eSH@Sd]Zg1]-VPW)@<c#:f5PBM\<J
9.)1W_0AGTf)>/A^/BU-@=d,.;6>Z]ReG1;=L=_8fUYae1.NDa>3:61\NLKG-CML
:.Pcd5>8dE9e<cWTa9]GZOH]NZe,\1Y?\32_396@VJBB<_EU_0ZH(<g:c,0gN+]#
b3/X6B?P9Y_SQ808KCV+@LCc?9><64W[eYT7dP#](bA8L3^E\U&C)R8+,:a=[#5[
<L5Bd,92P<fPA4LOd:<BGa_.WRfd3I#3=M(O7\Qe\)0YOF;PHY1J6+f82XgTeNM\
##I>Ge<=G,UdNc8UC-0Fa@5N(XYC6Ba:UU+gePCVH9.eRa3N?-EZPc^9G<Nc8A0M
cG.+RU0:_<d7Z>;K@]9SIP6&@^6Q7;c-Y;N6C3M._c^IFI0:68I-+WL\^Be1PT3B
@eA]4@We2NESe_e&/E/7Pc1W&D>K\-?6H6E+BJa0H40\O#ZdYN4BNMA4MW^6V<JT
X@L6Hb-R>SSdfGHWYfBV[Y=-<P>>\61K\W63_-V+@1aWI6ID)f<H\KD9VJ.Geg7J
5^#dF&B,0-:>eHAH0ZFL+LWNH8RSc_SR?^Y8Gb^8Pa]V:YL+D(<KZ[a(7D^Q&8>^
eZ)7:D_8M)e(-,+b64cQKR,YQ/Y/AE@f<Z5deVKIZ.S==Q6FT-5FfVE>_>8@b\\?
KN:aYbbWEc2=TSaLg(GS&4_)E8).,dR[E4#7fB=N=M5QW7F&M_aY]N=.WTQVFDW:
WD@GADL(J\VN.gBH77@:&O5B/+a.9.IPBW[U_#9fJ9-_CS()JC8EJFE7LB;;M,8<
.P3c@X.=?4Z5?9#)AaMMSJCd12A=QQ5@Ea#cQdc\(F?HfK7g=eOcZ9[<cgb-:VYF
(5g@GdMID-,;2AQ8CC?#2Q&5[RA:.)-+-1D53Rb/S;]0K^70IVZL9MY89cBa<]OF
<UXG,P.&FLE3XagCI]46)TP(F0g#=:ZY[-LKX)SD/N_KIM3H:aD7+[=90A5I#7fc
HD:?90\:4Q@L31gG,13KZTgJ8,XV[+[SHN:T1D_bW/c.;d.L/>Sa.X<4d/I=RANB
M+;#@WcODD<W09CGaB7.cJLI;6LdO&B83UU(Dcg4_Y#?TI8-7?J#[@M3]C9aZJ5A
S#)(BSa/:7YHgAfeOIHOP&K0>4E(TZLF/dR9(P+4RZZ,E]7+&^)NP3fU=3?FG[dN
WM62+Q)IV?aF^:WZ7Y+Y[J)1/A]VGa\e=e:@a@Z#e7Zb(@FUF=?UFg&H;&S6dOW4
c(AYYRG8eHYZKd0XE_a\e.O9FKRO.AJRNHb2],)IC1(@+1JDZV@4&@Z6-Hg_&?E[
TBTTC=E1]5Wa>QM=]LM/MV+c+<aY_-0];1[8KBW<F[9a=LN;9,DQ@SGVXF06Ig0_
f&1+ZB5U,dF:cAME^fLd:/=#E+6A8K&=&^WRBQ]QQRG[G0R]3H(W;0cDe;U-e0dN
#FZ>J6e,+ga@E[6Yb[HB&H;.>OZ8HJfU.&DF_d8GaPE<R2]1-20T7K_JB=f-H3(Z
_O?9PG,MTGV#H=-W/0/21,1a8(^<58>6U2X9HLCU=H\KI5\d7#C(0I8P#<Lf-0A0
#M_X-#f.0g)]@HTVFLbIXOQ83W(BgSGZSX;0Y\C#)-fE@@7O((F8?)R&_#cGH.)#
GfPJ2[[D#dAQ]0FGP9S053;eZ?JYSc3I>d3N8dJNOD&R:aXW9UgCE0#I#D^H1d65
V6YJ0253b[XR_FPWSYOK>8;U40Q_-fg\5Q#Z:L4.;(J=g1RJ42ER5=eB]?-M(5UP
A_IR5SE-ReVEI/]I7#S/-858Nb?D]Rf??Z;:[[AS/K;R^K-dY79=ZKW;,-b^4M0/
>)TC0cFbe&c.=gb]U:,P>^fQbF-A=Fc4X>>(6QW8DYb0:FDDZCJFK7FAC>4DXda:
WYcC\bEU\6IR6VZ#B]>CZ]I,<^[_S=RJR2II\RH<SY#8+dM8faMQFMXM3eTN^J9K
7f930cFaQA^/B-#J[MF5<2CT4/6eS85SV8DJSV0a-SeBRa+R>[b;3(=U4BT;9ZGB
fS2->b9RBC4,VQ=S/.Q[d,B\5N/ad1XU[6#@KH(6f18T8cZYea=K.B(L,5,MGR2:
2EFHB,Xb&=,\BK4X6C\,f0(gJ-AS48fI;f\W2OS1OdN3MDg?9MR</dN1[A9PYOE:
62O5ESg0Y^L=/>6eLZ(U.a5Qf4MTR37E5)[56V;62AZ8]I-4\fX4Ncc_@-9YbC4,
MVBB5VC/IYCUKQ-1ESBTda/MRcVJbE-6+^6\AbCf=##,cec#LRHgY3Hg2b@K:0K[
,Ae2O9VFS:dJ.Wc[(R;7H5b0NRHQPX=2]=Sd_Maa)>-+-3VL_L6M@.DOC(\U3W\g
?/@Ec5O,fG7AXA@@e<A1g(^R0;1A^+b@/R]2D/bRYZg)V]?EE:;M&4fOLc]:_(^-
dBI;]YHCU=@0fF++=&.dU@AIfDCdF^&L/;UMX\P=S__+e,D<+3Bd?^[XAMP+K44[
TG;b(^]TDQ5ga^^9@c6+?PVX]\c:J_PXP/-S[Wf(-Ac<W]e1_:R-Y63@5OBZN-5,
B]IIHA0-7SSaJ/HWc+@d;HLVZRgGeT#R]0WbbPX@7\,/?[==V#6f&\bKRA=8gKJ3
b=WY-6])<e.aX.AagYKf,+DgY8=.WL22<DU,9JcLF__B/c^R0d30?TNHB]PF]GXF
DA\a^-B0V)@;T>)6S,Pf<NR+)XBDJ]9b[LW,=^?(3ffZ3LCG#1&TV+D:MA0-d<fF
7ePX81&)aN25P)UPa\EHLMLD(VfR2=X=dF(I)SC57D0A[9:M(\V62b0JE/A:0]<8
I6=8eI?=AQS@bLE,SFFfEE6Q>+^B0@9_3XcAT<31FLTOc9-=N1a=Y;Z6\PH>Z=cL
P00JcQMVITATI)YAVdJBQ+LOY3)1B\dTcb&N0A-1.8UP#VC,J:fE8Z(,S,LD^8&Q
[g_74,2RJcM4L,0@YU)c<Ucff:^11PMEG?HCS@CS7@f&XJ7#L19OH[@TQRF:8W]7
7A>@N.^(2)FFF437_b(:Ra_&G>5M1^>@b)7[-c;N9A98aG0>d<XL/Y^CdO]<-CHF
PFWOTZ:Q#B1c\AL@aOSVR\I4JDX3@E_0P15/Ka@:6c,5&KO,Z/CK09D.H5Tg=-Ua
;/GDR+Z?Q#9\],R3(CBeeY^.8,R#CWWFHM&aQY0X#6S?d9CSJg\<)6;,X+@BWTPc
c#LgeH&;g0Y#R65&PRVE\Uc7SDW^aZ+F)F+--?96CDT@YTW^bH7GIKKe8N<D;c@E
&X[,JP6Q40.39RUD6ZB)6KNe4@eM=A+<ScK)JcRg\K-0fC-4:)<9He@1D;7BZFSD
1^A9G#Dg-H3+1JZUUgcY([]fWE,LA?9NN&1aP)3_Ue:2I_V.WZ,52;aB81.O0.-D
=GA^AF1T1.)5V_U5&,B@K@2.;G&K)\dY?YW)X>B]aN7/&8]RePD;)8[FNC=[SM;H
13AYU,E>c&5HLg>,3N\<#JaU1Mg_\?5##):C5=]Y_7XQ&7T4g:f&g-E1dH3M.-2:
NUG=QL;Z7af(U#CDQ0(:aE5/=4UMaO>GK9DaHfeWc\J?cC?1,X?CR3;IRCD<-(6<
I#(1>ZIIP(D=QSC6N>?Y3:beX0.T0fQ#./T=+DaJ\8P&;_>6Of10A\g4NAF.7a#-
gdfV)EMf+/;8\^^@[1YCU=g0P#RV&Sd98ac^DA0?]VV1d9fEGNY0bFZ^G;+:NeUO
>YbUXMDX;ZV^@MX^S+9LUQNgJ,WN)=KQ@>XV?3Bg+F(@/gAWRFCQ>3QZ>VKYfQB\
LNXRf]<W-05e@K?8>W4\dH87c?^Y+3aIF:a9+RV0X5-IT=XH?IDe\UUI+#-VE<+7
EaWJK7@7C/QeUE/[\_aQfI)7LSDf/=MVH&N8fZI2c:OGE/\QW];EZNB@-5d94^YE
4&F5L6HMF&MI)NX4e;6YH;d>_3A=W@_VE5QePdE\LY9cG@bDO+QT;aC2^c2Y3P4<
>e8>7b+DZ()O^<?U,19TN.FM)_HI3_b;0?P[bD>_?e4WZ<0^ID@MX)=09AU5B)aE
^&01FSg&dS-L#8]-RLV79X]VI,T=2L>(?b0bGJ[c^\]CLDE,Q^@ZC/f>fOcOZU7B
+;YdB&;Qd/+P_]^(H5eF8O9f4YF>_0+S(-R^FZ#BFVOfbN/BLUZ,4-3SbU6:TYE8
de^;J^a-1+);VN/c<<RR)<.A\Ya+0fF7X+M;M@^3@YT6+FCf4YLBRP1B(?f[^9e0
c(S&.0J48;T#4D4NeRI\&eC+<]5X[#@A0<3UJ1>gL3BG<9g;94(a<R(M)]T[e9ZN
/]bX[Wb[#K;/X#F:YYGY\Zf8[X1H<-@3C+\Q8)L99)Bce8:H&8;[C[KeUFSHTEbX
3OO1D.@0W])70Dd.^UAN>ZJ4]NT@X12GN7H]4#aBLgDO8_Uf9YbG7LB/.7f_feE[
;SSJ.8-,J<P:/=Y+V1DX69WJb)CD[OXNbbUHBO#I16XSbcNa.QR<1,f,8@7OE\,T
[/9Se,+8?DM<I2:-Z@<8SKV401S0Y?+@/_NS77aa0KU^Q:#-?UVRQ1ZHTa?1gIdK
QE5W:,>4@,#5=H1DEUD;S,J.U,MRd4/K<:DEK]KF5_H,d<H&1PIDO6OIL&QH50(>
G)@-P1U9fb]f5@PMM7N8WbcdOfMSBb\W20d>;cL6FZ<.UXMP+D7EbZdR2F)PTD35
@,G)=[T/MTFKFTEc>\C;MQWb[?8:O.-3_)0;28(ba^^?cII#Bf^ac@>B2#TS:SX(
QMCI/4U]MB&DC=[P/)_c0aHGKcD_8YZLF(-UN6/H)[;D>9.a[K7<MYUUVU)?4#@M
+Ra6RNYf=J;f,54X0BVc^S6b]XY<;U]TL)(WW4^+@2?7Jg+0PBGREZT41;_f26O,
>fQ245Z2?LX8=JAZc_KE^U.ZL4K#6IA<FC&Bg>\b>b-?aF,DeD&A#2bf\9=b5DS?
e_&Z103dY-6SNZ9(<WG.Ja\b>XNWU(f]_<K=GK./;M)U[-[I#A7SeY7K43O;1X@1
))70b-d=]OW#WK9H@@)4a6AKYOD6@#RK04L6WZ[<P20:3g3Z^)0V[ga@3g+PT)NJ
Z2EC>IBI&Ga6^Y1f#P4WX2Ccg:0)0&&W610=+dNPJRHSBUO0:2[<g)I?FWZ?8^RQ
?\.6935:>9-c]3eHMDFBc(e/B(PD&&)+K@:0EOT1I[WW@L91(]JR&3H++.JT8)E+
.b=?@J@E<,&\Q,@_\3)Y+Wc.8:)K9>b87XJ#7RbB?J4J:>_W-FG@679N=4_AQ3X-
c?83_Q>]ZSMI+2X#;Qg0N?\]f9Z)HS0b=eZTbe1Q(:K^ZK\BL=ND4a9?S3dKJXX(
EOQYfQHHVLIA3S<+MVHL\3f?29=/=X-P^/19F=Vb.#0g8:&8:9@GF34)9^e#W?53
K^XJa6ZGVGAR\b8,<M+EV5F>I+A]cD4#;aO0?2d<&+;Jf\d3Td^=_e5<:?-55#\W
FYNU;4,;I6ea&+5P)US=,7TL((WOZY]SP;(9;7;#Z;E\G:dH.H4C0UTf6F6/^G#e
<_bHAC/ML0OA4^3)AY)H>SUfZO0YFT5<P>8(B,fCaIg#IYd.N+;V4&ON972U6[=Q
,X-g[(g#3F)(cQADFM.NNQ-d6&::64#/N^Bb(CVWCCUUNMfPME9\0+#A+-Ug9=f/
FDaOCOO14a3g3b@91M40?bV@.0O5QaAJ,L@221-<5(I>CP;+.Q],b^8Z=#KI)J=D
>2KC5W<gD^0,;3,_MCFBbLG-;&W7^8F3PQd7IK?TGX<0I&2GH[847-e]T@OUV3O<
143&N;N;#XeA+ZYe.V[0ISf[.0PHOO@ad?;X3XLQUW^S<61.-#R4\O;:9._B9]#0
_X+bcbW#3dd]ADN^RJ7L4eM^:XULJ<f<1=g#72;=bKg6WU1L.3#GH\P:dEVfZF:4
#B:UE@G)dbB\MTFGQQO6#c:TPaA<#SdGL#A@UCK;CGGg[dW8KbNe<67UUDDbdB@5
L?>,9R=A_=McK>(^BQ>5EF&CRE^12dS6&N:;?c(]g7CK5\,g)R.IQC7a<BQ5P>&\
[[N)UNFU#Y-;,2dOg>R&F-[PY4AP,@7K=c&/^J.S2898.3.SgLcgB0(TH+T0EBG4
\N=<.QR\(ed75E:0#IDdQSdd(U=-<)3V?/6QA4^?@GT>)=fOC&D-?J3ZW6<5&Y^0
9W6+NE2>JO>MSJ;?KT/W21I?9SeY7MSJ8:T+(TB\6S>):b:eVB+-<5ZeDc^SAP>A
#g/&f&AT[8f;aZKR&Aa>gOd6)0.Jf+1A#MgMZcXFXS:aEHdFH?.=d[PSd,gAS]?Z
I;3;BKDZG?I(dEKD5=g_&OK\Qd0Y(^3SZ\a8B<D,CM67<3\a:27D9W0dN^IP77@E
X3bKOX,_D9bc/JSZ[KQ>LH;C][SRbeI2)GF.0)VY#e-)983D[ZP)fc+8:M^[@M#\
fSd[/1LI-f68BV((/0;#[F8g(Lf#5DE.Ydc,/J=Dab0JI8g>GQ.#EC5\X@(P/gH3
G[cQ?<BGWaIS@d=E)(+73fJ7L+@a^)AIEN:.6/-&=DS\<T<7P]cC([<#?H?I;-7X
,R+S(DP2L?.Kc?T6CeHg[&18f,&P?-6;]c^FV335WcJ^eMD3D\JKI0?Ue0d>_I2+
M0M[6A4;-(.+[>BO/+=T]fW2A&-)A>AP2+&Aa6CE[a^_>c&R.I95K-G/fFC51W@P
PSA>Ab.59M/FYS555cK)NB@]NI4)_/)Q60J^-J@W^4SSW//3e:6?Z\YeSCCO+;4K
+_J\=B+H1XV&e[>,<M=_)c630-K)6UDedYK]L?@1)T43A^]bQf8/1WR@-O&7@?(b
6OT,.6Ka\4dX=><aQ^,ZUgS_DL,6DE>HbLcJK8L\<.1<-^b#^7[.0@>U:&[f2MRD
E_9c0.PZQ@/(C&RV2QSJc92=>B&O=X_4YY7ed9QWaQ)[&b>0)Y9JMec.UagF,_c.
fY.AI&>6OL77PJ)YBFfQ&1?;M(fAZXbV\LXT@9XVJ;E&Y7D06f-P+UJRJ\HU1[KB
D81T+[O)61^9JZWUfb.CYc04>=#/O1\@aIW6?-LfUCHM?02-:W>bHDG,^9GZL76F
EA@7WO&KSRNRd-_0aGP.CHEWf4F:]28(f>6/TZA5=.U[B_LP5)F)YCDfU#>SN38+
V;=_:]bg4&McZ\O>:TfHZ/B,6gGWP/._8[gXE]17T7E5X?-0P_\0Wd)K^Jaf2H5?
a?1WER(5d4Y?_f;3dXLA:cfRUVJ86UH7IT)A=4SP2._XCZ]gP7+L2Q]>8Y32<&DP
V=WI5@VHWZ.Z=T4KWVQ<]\&C4Z3(9[O4NIT>R>^\c<FdWKT:R;#^/L&KZH2?3M<?
[#bIV8DR:MH;(=A;K8AVYY-<V+8WV/V1aZM(+=&D>T8E4039Q,[=G=,<BO<af0RP
O#<_]IfM2BHbU,SJd.M3YV?EgdcWCD>PY::QI>DWIbE+dO@_dTI/\FGE[_]5[5IJ
gX9gQIIIF&N&XC>E^>JfC=:[WB)>eTOCRA].,]N[6L[<?E7a[3OEFL&I&PJ1eIcb
#1:a2ES^H28R;6JUX>Q]c:8338]Afc;?M=XZC.ITDEb&.Pa_9D]d?KM^\a_c/VfF
S-C3J^45RL:6IL,TG@NU-_G=Z#IL0aU+Lg15gc/_BY[>D8)TIJ6BY&;RLG)+OI@f
b4MFdU]F.cJ9>,@Z/X<ZU)LA[9d8/<@E?_a\&N_O,.Z#_/LgS:MF2G5>E8KNg:=a
9,P)1I:;Ca4+VYSIfF287cK.<dN4Oe)^D;[=V/V,.5OXB[HBYL>;C@Dc-,6ZB,9&
eQY=@/&g1VT_UfUHe=f1@+>/bWU76CS5#+L?Da,,;2HcNJH[98706#J8^]R2:ZD3
&@I/OOZ0\4a1[I8(T:ePO@]4B9TE(I(ad9+QEg,DS^7F>OcG:X;=,<_8HY-R]CBQ
(:H0K,\@D^b1Pe.7Ua=WR>bfSPZbZONI^T.EREa+a,NI:SaH#@J55=?e\b2I,&Q9
KW62)?)[f@01gF,a,W,,<.LYd3E-[deA?5S\e5F)(5[3Z=_d,^PTQ39YR6_&(/(?
@a5K_ScCYV^MM)f9B]U+:?K:^O;K456M)/gU9C3TbO#]C9YDBN_;E5:L9OeEPGQX
I_4D<0Xf:/7P]@?[0cB)c6AT83[cQ];V--5UeXa[MEN:1OOS(Y)ZF,AB1PZJKUWe
/29\(SGA;Pd^0SKI]8OTBHFbOAUB-gX[=/adE@)e<RA79e1/RXOJ[P,;?;L;O5>9
TD5F/81U_\a?WT\.#/(=1gS4,)T)I(T0K#8g&0R<Gb+Z^S#QOTMG6efeS>)fCeJQ
JYJL\fB&1;1FAG\1/<7I,a@RX8=:7JRB(<39]R,&f,gH&DN@@-#XOZBRW4FeY@0D
5CfAXAO#F/)N12@XZ+4fQJ\88G:NV\;6&=(;OMK2g\_4Qb728T#WLL[YYKG\ffTX
]^TEg-?Y8EGa>P-<;dY2C:c8K:1eZG&L=_[RPOMM)fW6Hb0^K:>OUPOPWPK>f=gQ
XKMRKIB=7VPAMBf62(?C.1#9:a;)7\NXQT0J=g=ELfO4<=>QIKCQ63JV7KP5J\G(
0X#+.Z_P&\^_;HLa<a?d^6>Wb]-g5T,0c]Q#9cVC9,fBg0\-XLP:]c6[XLSg)M:+
Vd18=-+<^CgB+)G35T^(O=Z;V_H.@Tf@O&)TGSd-GTLeUGAA]:7H\;9EH0MXWR8V
YLXJNHPgW\2KDebYc,^\E<+&.>&U=,DB2X)5HH5^ET9<T-O&8>fO0SFI\:6[&dF&
VK&.DK5?I7Q1&9+BH/34ED<M>\W.2VI6=>O)#PV>+]BcUM-0S<7R,W.AQO]:M?=;
1Y00N_=N;A3,<BY<KN=DfJ1(T6a,=9P6=^C8/4OX;gX]d27ESd;-06](d?/O(UVX
F<..#UZL365gdUecA@FA=I8&P):d5KWL5ILC.F;XG77#C)e^/H]&T8MGB7=F0gL;
K8T+)[I&7V..B>\/a+MG?JVg1;YK+87XH]-2XD=Ig]:PDUT7R>52JH/ZZUY/>b6B
7,]GPIE\e>]ZOK+Q@S8JT#T0HO3TBLNS>d7]_L2,eNIM3&J/SWa\WOS(]b\6>Ze/
F2>OS(A,Y#Df7I.VV_EfBK4fRDS+/@c;6T;bLE=&(S,W5&(OLXJ[a/b@XSVIg3DU
V=<(Z?NDI&e:WfT=8@2bNa6d7[2S4\LK>+b3_abL8;N_/I>N]D=Ca]b@N$
`endprotected

`endif //  `ifndef GUARD_SVT_CHI_HN_ADDR_RANGE_SV

