
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 
/** Toggle coverage is a signal level coverage. Toggle coverage provides
 * baseline information that a system is connected properly, and that higher
 * level coverage or compliance failures are not simply the result of
 * connectivity issues. Toggle coverage answers the question: Did a bit change
 * from a value of 0 to 1 and back from 1 to 0? This type of coverage does not
 * indicate that every value of a multi-bit vector was seen but measures that
 * all the individual bits of a multi-bit vector did toggle. This Coverage
 * Callback class consists covergroup definition and declaration.
 */
class svt_ahb_master_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_ahb_master_if.svt_ahb_monitor_modport) extends svt_ahb_master_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_callback");
`else
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp);
`endif

endclass

`protected
PAMdN6W_/_R+)CD=W?@a;FXe;FgL[GLJ[[;[F+]Bc.YNSB\EV,8c2)>L[&Ud2c3T
&.8)?M_C6EN+FC@TcPEe]<;AJ##3:^=G6dLHG,1H-g3[MY].3KQX>ga,>g:#HTOV
&GOcfYN4NC[UQ2.A<^WbJ_?bRI.7\/fcXZ/?c,-:8+IH/OPDS<1DUPF.WH@R[bUB
+Q=<f3S(LSSEH(I-,M(A<(>_NX=>Q4aNYKV,Z3#GP7S96HUefJXGYePeYe1F;Ue1
E)CgNWW\ZRA,bJG-Z9Y_3RgDT>O=G\Q7PAPVRA7WLM_L)1G#c&[aZ@E1KX^#G#);
A@39)D.()E8@BE97=K?@,5.\&M;NO#/73OUe.DE-L=b2,I>H-(,g_0dDMJEFI7(g
-F-(@5JML>CSK/X6:&A;J0@BA0aPQ5^^Ff.P\)HMfN+[/,,CDQ5@@eI31C,]-8R\
^]J8,CAaZ\JV\UaU0=W_ZT_M#b44g-S;f=]-4RbPG?43>(ZeV2:Y-Nc1>>)A.6Sg
SCIZ0QSb31GTEL7W8KM\1OG?_P0g2O+\68bK9:R&f)(PZ&)aP?V67E5gX?4\)BS\
]d)WcUVA&=0DEfPM9MYTA9&FbT;H4-^4S,]Y;U;/f?8_f#UACf3#CV_(c7ac@03f
)E_;NE@.d&fQ(a<g\PMGR;L,1aK12ca>CDP>00=V\KT>eD8g_G+]S-PY<B\4f-:K
WV#>\_1GX;a84D&)Aa^1J-e?<AN60@UTX/S@fa8(dCX^,=62E[W;H6@gNBQKQKVP
faaE\,RF-7Z;KdI<e6L,5&#FOP+Y4P<2.FS3c<;-293bM-FV]d\L9<U6XBGbaLAC
3Q5Z4I&^+,c@L/EB[FLeUP(=]DY&6O/aY&63VZV3_=URBJM??8g<6+cONF31\<:I
?&Y7b_g;=Ib05/LDfd.KL#NV^KA66g9-+A]cJND\;Q2MW@M,<SNU9OZ4ZF:VUA>F
.F=Ng0WS6&1;9EXeR<(--++dM9R(M^)6b/40Q^5Z/&.A\-0\^MF5SNdS>b\(4>6F
(7J+1NAKXg-L_SgCWHO6+FD>g5+gNTUU]59UcNT.Z8&<JRS2E)PP)0./6?/[\U@-
I(?[RE^d?+JLgO+Zf9e/7TEVA;LDVGTGTfD8Zed1@\\+QBXT]V>U#NNfB1L++X=Y
6a=;FVSP_F\LJZMT<7HU1&BbHa;eV29X3faaagN;N?[RREd7[14.)]=8[N<(IHbN
S,2;6Y#@BETO@LY)b9]IM9c;WU-E<9E)@9[1P@2&S1JgB)GY[+AN;b52;,CID7FF
4W/@G+K)(d))dd=F+)]6]&A\1Q>Ec2+-Q\)4)cL2MdA2]V>Z?)U81]aGY[UcYC[U
MY=)CMG8WB/(R/083+<#cFA\4D[C[WH3^_#a8:S@H:;/_UPDZ_&P@4_<?Q<MBe6X
6:OTD3eUE(3T>/8d3U-_.XaDBZC\><\NPgTY5>)B=K@a:0^YF-JB@)SdX\RRS:[O
(&V&JU.W=T@OO/#&R^X@-=O?GBSWSU72RQS)I;)Wa&>.L<LW0RT<HaQ2\KMc,5/S
e-af=/[0,C?861I+#e.OA8ERADB.TG3QJ\?VGOf1Wb>IIEZF^;fH58C#L&XDY-(,
<MU\&\8EfOUDDE6PE(#XT3[CAIO/,[d0Z,2WD18WbF-HT+=V(=8GcL+>.6RRTCU:
=D(F[CW5&^&<>T44dCXD/^5(;,C++I8Kge[FgCb#JaGC-9<ZS_b4dI^a6+DLA\>Z
_#8=eHgRZG^,-GBMbYgV<>1Laf<I+V-KEIN0)2VC[GRH^ADRQ.\K08N/V5fb.X,g
+08bKIR5:I8W7-<90HT#e[5Q;TTJP#?H3490>ZUOC>6OY]X1PMM7(a:V_-;]@g,.
8d1LgH))V>0&9Pga+.D77D0A\&HCL[]UVBYU;]LMUN3R]f8=Yc@;IW:YX7;-SF=\
7CET#<&1F6QWX7eV)\H;[gbQK2D?]d2D)><ZOHA+3F#L0_W?JE3+?BPgDX9;<QE6
#J\G;_;S7-??A)^.Z38g9-T\?4-<1E\E(59&QRAZ=VLWK.bIOFYGXKE:;[EL^U4;
;@Fbe8P/X8_6F41fBXBgd8V&(.FbEZ>e)#b]1IG?24ZZ[KYRbOB>Y,+&B?9NP_<3
)ZSHJQadVHJ-eVAf0T]+H?2AU.bb:3SO?0D^[8T-U1TDY6cg#S<(]13,L-/YF0Bf
-9+PX5[GLbaA@Rf5Y3VTY&@23E]aa<A;;?Z,Z[aI[=_aDcYRZ\]8@GU0WXRKQHW:
YO#;,)G3S@dU9WBM?UI7QFPK\OB;dd.#d5.DbMfPDNE/_/GM?2W8RBIT<EBSaU@D
B8NK;K;@L[\F)M/&H/Xb4FN0AQ5IYcZcg@XdA_D>NQ(=P=COf9bGfg79K)-3T\9a
e.gH];XP0M07WHG/A<_5)IPY]\fPfIDV[@8VKC3=W4G_Gb1#e2=M/Fb36+/bDM4T
5g@7aFE/D#L,R#08(UR];OEAbVaCWA/K=Q,<KVHZ_M/C,+cW6/9]T]:FQZNb3X9g
S)<#;[(-da29fB-EY6:B;D\(MXZG7^N=@&#BJ#615N.)1SS/R<3A>g;8=;FaTO74
B[9KNg-NN/-M6(5S5Pd4O,PX>f=PG7O]b0aOTG,M@&.(I;-?+J)N:^3B@R7f9KTM
)@TbH7,Z^JfM/$
`endprotected


`endif
