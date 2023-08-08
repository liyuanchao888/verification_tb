

// =============================================================================
`ifndef GUARD_SVT_AXI_PATTERN_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AXI_PATTERN_SEQUENCE_COLLECTION_SV

// =============================================================================
/**
 * This Class represents the following pattern sequence, which needs to be scanned within the 
 * AXI Barrier transactions.<br> 
 * READBARRIER followed by WRITEBARRIER 
 */

class svt_axi_barrier_pair_rd_after_wr_pattern_sequence extends svt_pattern_sequence; 
  extern function new();
endclass
`protected
dC).ELG4CBKb)_-=4IM2.T^EC?7;0eg&7g.;FC;]P+7M>OGge<=U/)?0>Y_UZbKK
I[6OVe)XR3aL>@bZ-J.KQYV99I1LHI(B6<Q(7-/7<[\(\,Re9Eb4J@/c-&36@)(2
+&L),AN9HF5+aPR.MV_P;GTeVP\EL?eGJfOH2fAND\YFGaL\?3:13F6HaS=L[M@c
I;50?.?fAVYM\9PO4.EFQT;W+\(DW3ag8AH0W#&HbC[4ARBF)(TX#5R58b#.J7TG
CA]1+X<6#XU,U30b)1\]be(B5DICGNF+LXa467#I->@/3<R71<eC0cA6B9Je7VbV
E-b;I/H;P[E5PgXe,0<V[=L\[WJQ0/I5OgJbW;cKZYN#DC\1>[3WZZfMETVW2#C6
6Rg[U/F<O3)6OVU1e3N:+6OKAMR^^OZ,;YD_M\P+5(<F\46f[<HEVXa3/U8AR[5Q
;e<]P[W1DB,TYT@d2:2cJ:OQO&-?aD0B)CJSD1KQ7>;dW-A5OT0E4Y__g_XW3]Kc
KH?.CP+^T>8T0$
`endprotected


// =============================================================================
/**
 * This Class represents the following pattern sequence, which needs to be scanned within the 
 * AXI Barrier transactions. <br>
 * WRITEBARRIER followed by READBARRIER 
 */

class svt_axi_barrier_pair_wr_after_rd_pattern_sequence extends svt_pattern_sequence; 
  extern function new();
endclass
`protected
>LRaR55Ub;a_Nf72<\9U+dN.?30N,7Led><\/+7>WN)g1G@T/C^V5)#061SA(]Og
TB.V7\#]Z>6JaJ:2O?^8?7C5G7O>,,M<\\(=;[gPL(LQ/D+5<2<6B9Mb;0?>9fe]
2F1E&9NNYa#)N<Z1H_1Q3QF4H7)(JPQ#.FB05?PU1V;+\KW7b98;R7(G1?G;^E9^
3LIL-K&>-fB=9fQB\1YR\B?]R3e99G?_4\1C7_d>E@Xga)K+Y3-\19?R=3QRNG/,
&@db5E@(2KbQ5MYB=8Xf[^Z:Z>dIG^3WF\F,1V;65U]@4IZ>3c9GJd<WHUI0NP2U
OFe,^CdPR9+)FHQC:Q65Z0TX3X([aYcCTB\IS&;B,TG>6HH<3E+cP>/.?f3T(S-A
/<(Q.IgWd972.d:O?FGe3[2?FM;7^ME88:)AXOUQ3>YXVR-.9AI_e4[O[Q;SeAI5
9+WWK,P&DfTDJfC&S&.;>)bBbQfe9KI4efI6cb;?ILg3Z?(]U=C2ZPO(7))KI58a
;;eea966XP<D0$
`endprotected

// =============================================================================
/**
 * This Class represents the following pattern sequence, which needs to be scanned within the 
 * AXI Locked READ transaction followed by Exclusive transaction with response. <br>
 * LOCKED READ transaction followed by EXCLUSIVE transaction 
 */

class svt_axi_locked_followed_by_excl_xact_sequence extends svt_pattern_sequence; 
  extern function new();
endclass
`protected
<XOG\72AdD2g^8A5MOfZ_]=(CbDbc[CZ3dLE^=A,(<I\CE@N=8d42)JId50G3geZ
H4IQ,f+67QdJVIIWH:9FVF0]8ZFMS<4_/TQ\B9(gR2I<=4KB?IF5cgD\F@D,a1IA
dIC#cGHb4A@#)2#^;JEU&I^1e_19.I9?1+(H0eGd@;--X^?S@G5MH&eJ8dZ,=Kf^
b[89eSG0F+9^_JLU]TPK8]9D>MTceWdRM=UYf.SX^,(3E#P(d,bP?V^<405T6WH0
]FbJW#b7AO?KA9JJOI4&RP8Ga.4^>+VG0-R9J/a\(^S>N.VgMbO+gQH4@J5/\[<5
R^6d]0fL^a/B8X7FJ]?#H/5+8dDJ.DD-#U2GG-)_P-EE4KE3g>08>,Z)8e69A<<0
(V=?3-gJR,?T;DP:H@#?d9(c5:EATY2Q77\Sb4;KgK#gPLZ+VSS#TM6F?/LK,^)U
7SAB<?X;#Fc[_Q<TYI_H<9BeX9:_4\KYV&4P73TMTc&JTg=c[266\N]+6J5\/5^4
<H8U&;/Ve[SF5B,XXG<X:,HcO=8,-L0Y\/MCCBg&JX/Y)C32D2?S(aF8cWBOd1OCT$
`endprotected

`endif  //GUARD_SVT_AXI_PATTERN_SEQUENCE_COLLECTION_SV
