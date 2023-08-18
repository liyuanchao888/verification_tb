
`ifndef GUARD_SVT_AXI_CACHE_LINE_SV
`define GUARD_SVT_AXI_CACHE_LINE_SV

`include "svt_axi_common_defines.svi"

// ======================================================================
/**
 * This class is used to represent a single cache line.
 * It is intended to be used to create a sparse array of stored cache line data,
 * with each element of the array representing a full cache line in the cache.
 * The object is initilized with, and stores the information about the index,
 * the address associated with this cache line, the corresponding data and the 
 * status of the cache line.
 */
class svt_axi_cache_line;

   /**
   * Convenience typedef for data properties
   */

  typedef bit [7:0] data_t;

  /** Identifies the index corresponding to this cache line */
  local int index;
  
  /** 
    * The width of each cache line in bits
    */
  local int cache_line_size = 32;

  /** Identifies the address assoicated with this cache line. */
  local bit [`SVT_AXI_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this cache line. */
  local bit [7:0] data[];

  /** 
   *  Dirty flag corresponding to each data byte is stored in this array. 
   *  Purpose of this flag is to indicate which bytes in the cache-line were
   *  written into and made dirty.
   */
  local bit       dirty_byte[];

  /** 
   *  data_check corresponding to each byte of the data.
   */
  local bit       data_check[];

  /** 
   *  data_check_passed corresponding to each byte of the data.
   */
  local bit       data_check_passed[];
  
  /** 
   *  poison corresponding to bytes of the data, as per poison granularity.
   */
  local bit       poison[];
  
  
  /** 
    * Identifies the shared status of this cache line.
    * When set to 0, a copy of the same line could exist in some
    * other cache.
    * When set to 1, it is known that no other cache has a 
    * copy of the same line. 
    */
  local bit is_unique;

  /**
    * Identifies if the line has been updated compared to the value
    * held in main memory.
    * A value of 0 indicates that this line is dirty and that the holder
    * of this line has the responsibility to update main memory at some
    * later point in time.
    * A value of 1 indicates that the value of the cache line is updated
    * with respect to main memory.
    */  
  local bit is_clean;

  /**
    * Identifies if the line is empty.
    * A value of 0 indicates that line is not empty.
    * A value of 1 indicates that the line is empty.
    * applicable only when is_unique =1 and is_clean =1.
    */
  local bit is_empty = 0;

  local bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[];

  local bit tag_update[];

  local bit is_tag_invalid = 1;

  local bit is_tag_clean;

  /**
    * Identifies if the address corresponding to this line is privileged as
    * per the definition of AXI protocol access permissions
    */
  local bit is_privileged = 0;

  /**
    * Identifies if the address corresponding to this line is secure as
    * per the definition of AXI protocol access permissions
    */
  local bit is_secure = 0;

  /**
    * Identifies if the address corresponding to this line is instruction or data as
    * per the definition of AXI protocol access permissions
    */
  local bit is_instruction = 0;

  /**
    * Identifies the memory attributes of the address corresponing to this line.
    * The definition of the memory attributes is as per the AXI memory attribute
    * signalling
    */
  bit[3:0] cache_type;

  /**
    * Identifies the age of this cache line. 
    * This gives information on how long it has been since this cache line
    * was last accessed. A replacement policy could potentially use this
    * information to decide if this cache line needs to be evicted.
    */
  local longint age;

  /**
    * Identifies if the partial cache states[UCE, UDP] are enabled for this cache line.
    * When set to 1, partial cache states are enabled for this cache line
    * When set to 0, partial cache states enable are not enabled for this cache line.
    */
  local bit partial_cache_line_states_enable =0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of this class.
   * 
   * @param index Identifies the index of this cache line. 
   *
   * @param cache_line_size The size of the cache line. 
   *
   * @param addr Identifies the initial address associated with this cache line.
   *
   * @param init_data Sets the stored data to a default initial value.
   *
   * @param is_unique(Optional) Sets the shared status of this line. Defaults to 0.
   *
   * @param is_clean(Optional) Identifies if this line has been updated compared
   *        to the value in main memory. Defaults to 0.
   */
  extern function new(int index,
                      int cache_line_size,
                      bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                      bit [7:0] init_data[],
                      bit is_unique = 0,
                      bit is_clean = 0);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored in this cacheline.
   * @param data The data stores in this cacheline
   * @return Always returns 1
   */
  extern virtual function bit read(output bit [7:0] data[]);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data to be stored in this cache line.
   *
   * @param addr The address associated with this cache line.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data corresponding to
   * that bit position. This enables partial writes into a cache line
   * 
   * @return Always returns 1 
   */
  extern virtual function bit write(bit [7:0] data[],
                                    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                    bit byteen[] 
                                    );

  // --------------------------------------------------------------------
  /**
   * Sets the status of this cache line
   * @param is_unique Sets the shared status of this line
   *        A value of -1 indicates that the shared status need not be changed.
   *        A value of 0 indicates that this line may be shared with other caches.
   *        A value of 1 indicates that this line is not shared with other caches. 
   * @param is_clean Sets the clean/dirty status of this line that indicates
   *        whether this line is updated compared to the memory 
   *        A value of -1 indicates that the is_clean status need not be changed.
   *        A value of 0 indicates that this line is dirty relative to the memory.
   *        A value of 1 indicates that this line is clean relative to the memory.
   */
  extern virtual function void set_status(int is_unique, int is_clean);
  // --------------------------------------------------------------------
  /**
    * Sets the protection type of this cache line.
    * For each of the arguments a value of -1 indicates that the existing value
    * should not be modified. Definitions of priveleged, secure and instruction access
    * are as per AXI definitions for access permissions of AxPROT signal.
    * @param is_privileged Indicates if the address corresponding to this line is privileged
    * @param is_secure Indicates if the address corresponding to this line is secure
    * @param is_instruction Indicates if the address corresponding to this line is an instruction
    */
  extern function void set_prot_type(int is_privileged = -1,
                                     int is_secure = -1,
                                     int is_instruction = -1);
  // --------------------------------------------------------------------
  /**
    * Sets the memory attribute of this cache line.
    * Definition of memory attribute is as per AXI definition of memory attribute signalling of AxCACHE signal.
    * @param cache_type Memory attribute of this cache line
    */
  extern function void set_cache_type(bit[3:0] cache_type);
  // --------------------------------------------------------------------
  /**
    * Returns the status of this cache line
    * @param is_unique Indicates if this line may be shared with other caches. 
    * @param is_clean  Indicates if this line is updated relative to main memory. 
    */
  extern virtual function void get_status(output bit is_unique, output bit is_clean);

  // --------------------------------------------------------------------  
  /**
    * Returns the is_unique flag of this cache line
    * @preturn is_unique setting of this cache line
    */
  extern virtual function bit get_is_unique();

  // --------------------------------------------------------------------  
  /**
    * Returns the is_clean flag of this cache line
    * @preturn is_clean setting of this cache line
    */
  extern virtual function bit get_is_clean();

  // --------------------------------------------------------------------  
  /**
    * Returns the is_empty flag of this cache line
    * This is_empty flag is only applicable when both is_unique and is_clean flags are set to 1.
    * When is_unique and is_empty flags are set to 1 and
    * - if is_empty flag is set to 0, then cache state would be represented as UC.
    * - if is_empty flag is set to 1, then cache state is represented as UCE.
    * .
    * @preturn is_empty setting of this cache line
    */
  extern virtual function bit get_is_empty();

  // --------------------------------------------------------------------
  /**
   * Sets the age of this cache line
   * @param age The age that needs to be set for this cache line
   */
  extern virtual function void set_age(longint age); 
  // --------------------------------------------------------------------
  /**
   * Gets the age of this cache line
   * @return The age of this cache line
   */
  extern virtual function longint get_age(); 
  // --------------------------------------------------------------------
  /**
   * Returns the address associated with this cache line.
   * 
   * @return The address associated with this cache line.
   */
  extern virtual function bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] get_addr();
  // --------------------------------------------------------------------
  /**
   * Returns the index of this cache line.
   * 
   * @return The index of this cache line.
   */
  extern virtual function int get_index();
  // --------------------------------------------------------------------
  /**
    * Gets the protection type of this cache line.
    * Definitions of priveleged, secure and instruction access
    * are as per AXI definitions for access permissions of AxPROT signal.
    * @param is_privileged Indicates if the address corresponding to this line is privileged
    * @param is_secure Indicates if the address corresponding to this line is secure
    * @param is_instruction Indicates if the address corresponding to this line is an instruction
    */
  extern function void get_prot_type(output bit is_privileged,
                                     output bit is_secure,
                                     output bit is_instruction);
  // --------------------------------------------------------------------
  /**
    * Gets the memory attribute of this cache line.
    * Definition of memory attribute is as per AXI definition of memory attribute for AxCACHE signalling.
    * @return Retruns the memory attribute of this cache line
    */
  extern function bit[3:0] get_cache_type();
  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this cache line object to a string which reports the
   * Index, Address, Data, Shared/Dirty and Clean/Unique Status, Age and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_cache_line_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this cache line without the key prefixed (used
   * by the UVM print routine).
   * @return The cache line value as a string
   */
  extern function string get_cache_line_value_str(string prefix = "");

  /** @cond PRIVATE */
  //----------------------------------------------------------------
  /**
   * Overwrites the is_empty flags stored in this cacheline with the value passed by user.
   */
  extern virtual function void set_is_empty_flag(bit is_empty);
  // --------------------------------------------------------------------
  /**
   * Overwrites the dirty byte flags stored in this cacheline with the value passed by user.
   */
  extern virtual function bit set_dirty_byte_flags(input bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
   * Overwrites all the the dirty byte flags stored in this cacheline with the same value passed in argument.
   */
  extern virtual function bit set_line_dirty_status(input bit dirty_flag);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the dirty byte flags stored in this cacheline.
   */
  extern virtual function bit get_dirty_byte_flags(output bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
    * Returns the sum of all the number of dirty bytes
    * @return The total number of dirty bytes
    */
  extern function int get_dirty_byte_sum();


  // ---------------------------------------------------------------------------
  /**
    * Sets the poison field corresponding to this line.
    * @param poison poison settings corresponding to the line.
    */
  extern function void set_poison(bit poison[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the poison filed corresponding to this line.
    * @param poison Poison setting corresponding to this line.
    */
  extern function void get_poison(output bit poison[]);

  // ---------------------------------------------------------------------------
  /**
    * Sets the Tag field corresponding to this line.
    * @param tag Tag settings corresponding to the line.
    */
  extern function void set_tag(bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[], bit tag_update[], bit is_invalid, bit is_clean);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag field corresponding to this line.
    * @param tag Tag setting corresponding to this line.
    */
  extern function void get_tag(output bit[(`SVT_AXI_NUM_BITS_IN_TAG-1):0] tag[], output bit tag_update[], output bit is_invalid, output bit is_clean);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag field corresponding to this line.
    * @param is_invalid Indicates if Tags are present for this cacheline or not.
    * @param is_clean When is_invalidis 0, this fields indicates if Tags are to be considered clean or dirty.
    */
  extern function void set_tag_status(bit is_invalid, bit is_clean);

  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag fields corresponding to this line as string.
    */
  extern function string get_tag_str();

  // ---------------------------------------------------------------------------
  /**
    * Gets the Tag status fields corresponding to this line as string.
    */
  extern function void get_tag_status(output bit is_invalid, output bit is_clean);

  // ---------------------------------------------------------------------------
  /**
    * Gets the poison filed corresponding to this line as string.
    */
  extern function string get_poison_str();
  
  // ---------------------------------------------------------------------------
  /**
    * Sets the data_check field corresponding to this line.
    * @param data_check data_check settings corresponding to the line.
    */
  extern function void set_data_check(bit data_check[]);

  // ---------------------------------------------------------------------------
  /**
    * Sets the data_check_passed field corresponding to this line.
    * @param data_check_passed data_check_passed settings corresponding to the line.
    */
  extern function void set_data_check_passed(bit data_check_passed[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check filed corresponding to this line.
    * @param data_check Data_check setting corresponding to this line.
    */
  extern function void get_data_check(output bit data_check[]);
  
  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check filed corresponding to this line as string.
    */
  extern function string get_data_check_str();

  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check_passed field corresponding to this line.
    * @param data_check_passed data_check_passed gettings corresponding to the line.
    */
  extern function void get_data_check_passed(output bit data_check_passed[]);

  // ---------------------------------------------------------------------------
  /**
    * Gets the data_check_passed filed corresponding to this line as string.
    */
  extern function string get_data_check_passed_str();

  //--------------------------------------------------------------------------------
  /**
   * Sets the value of partial_cache_line_states_enable  flag for this line
   * @param partial_cache_line_states_enable setting for the cache line.
   */
  extern function void set_partial_cache_line_states_enable(bit partial_cache_line_states_enable);

  //--------------------------------------------------------------------------------
  /**
   * Returns the value of partial_cache_line_states_enable  flag for this line
   */
  extern function bit get_partial_cache_line_states_enable();
  
  // --------------------------------------------------------------------
  /** @endcond */

// =============================================================================
endclass

`protected
@DK:@PK-I10\Qc_.>]+IgZWS]6AFUZ[5\THgfVFNX495@cH_(IC20)(P=&\ReKNB
6-]H/H#cE5U[?bV4cA).XN8CfUCWOa(UZ9E&Ya@T495L,b649gDD0JGg:Z;UMZ9b
KL.LH_B;Q;&)BTd]ULT)#63CT\CY71.D(6(\<Ub0M74e?JYYcbX:L9e[f-:Fga&U
5-3K=>3L+IUL3)DWD&5cWGdZ&]]\<cFAY&PMF-48UGRfP&3@A/J[K5.cdNZT7a8Y
SY<RL^^XFd/HV4B6?9/c3SC4a:586O946M6FA/M2ca8J1,(LUPPGG]W?\U/N(8,<
UID3G5gFXE)36?]G#9^ZZPK874c[McPO3IUSQb>:3-(TU<XTS@>\bPH3aEeA#77K
762=SC,KdT1;QJ/^Qb+e2(1<2/cg4G7,DGc(LOIaAPFRP,Z)gb01dP\>a#bZ:Q^J
NOY]R)/f(4^N/[(P)65b9<Z:a+P&G&?OFNI31a+IR(I+/S6^&GAXA,Z@ef+WP??Y
H1FNb#8dL2&9K?dF83_KJQ0D<UP-T0-.)RA0f6M[.16UNgMLCa^f65)GD:^e[H<M
E([V]:+.0[[ee-#>eLU8LCMV6(6,SS[FV35D5Q:/EC1(4dffJ=3V(8ZSYFO2[E<.
a)AH<<#--\f=2]O]UL0GM&>2(BZN2P7C+[S0.1_;,?e3>A[\eXb9eGUb^^\C9#ZG
YAM.cEIL?=cBYJ(28^3045\G5GVc=fb(+H1KI@60G8VF/^?+QfVUOa+.3<BTRB=a
9bD1U,F21C>G@F-8)6<YK5df0L6UHP40>FTXBA@WFg4SRGH(cNNa0UJ+>IBEe6+b
Xf2UW.&>3)MTN_)9KU3Z]ae^BUWd0HeK_g(;UGT36(U,Q)4Q4EN0)RZH\VF_I8C-
X:d94?L+?4M:B)C][JR]EF/K\\:+6)KdB@B^e?U2R\A7B>6<Y/92(S&)=b8C5ET)
0B30/BF-/QHcC>6OeQ.J0dH>Xa8B[<R<+36,e-DZfN17C$
`endprotected

// ----------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
Q/>@^C[9d,..-#&L@E6TEECJFUJNFFFM(-IBCW+g=0>&>KHYN+JG2(UXJ02f.[NA
,>E;#&^P[IL4+#082E(ZL<GLQ<3AN=)H_FB?QaEFLF=?C&#g#95Xb2S1aYKQVTVd
3^-V^^+X8&GX4QeG_,0F\FE/4@K+LFMg^H]-JL4UY?9LPYHF9.GTbGIe]e1?/AQZ
eaTC0&7:gWH5O\(?..A/fT<UKIA?cR:QI\c0->_+[CK-3+O@H?DJ0ZN\KE.-4E18
XJccI9T4Db8?WZRA:EI<_TP+<9.YA<WR=T8QI8@4XC?7R2AZ\Z7GN[5O=WR]ab9=
FJ61d90MV@.@8RH2C]P;G(7LB28SW#9;]I6/a_ZR+BJ(_aW1Y?CMSc+ZVI]CGG1:
0NNa\47?<H^^f[bG#1NZKK36=>OQU2E_96>/_C[beKJL)Z&g6.2_B85QK(D3,EQ]
A,_dS@]Qaf:7TPd&G_bQ7<FdT+?cR:b=,5A&VNFdQNH&I(YgQ4M5<gXK;Z4P#fT&
HDH8fgRQJ&3MdgD7M/gbN0:-(TP.f)@-g\g5\5,X_F\/./#b,K1JW^Ge@/8SH4E[
MVd2M,cWSe79RZR(V=;I;9KgI2GZ?L/KV?b.@_E#+H3VHaV9K9N+:\N9:&ZHGb2=
GBgULH01dJ>33&]U8XGc^EM]R]??\T.fLK_>gN2.?:2BIX9[Rd:TN59#g./)/GV9
3/cS;a6KIBNZ_+cR2(ObTTLCBA:7@:3WHMJIZ/fdJC(,GSQ?R#R7U>A=+O9>=K58
P3H:?5S&H(&WVdI3D(Y,QFI0]c7ded5]3I8Q]Z9/#Z^QM?+0X;]?K1HB9K5/I;N/
\UNZ=dAfC??WJ]3-UIZ&,YWG;Ef?.Y42Z)2VQI)RH#JS&c1[23C<@E@<1P.gIR5/
R=U:a,L?c?T5+E>1-J&B;<cA^b<?1Jd<V<]71TMDVgKCN]:O=+MOKE[B4P1.SE^d
W/P#Y0,ZKb1;A=58R6=Xa0>].[8A];KcJ[]a<A0H>3@[H>d=;0D[W[&JHb?76W97
aOSP<1ZZ9GE-g:eIa:??)I0:U:4VG[?&/X]gc@/MdW(K;5.:PRG(NM;R<?_8Cb7C
<8ZNf50aE/,8EAGB>bOV<N0S?03f8R@@+H?]LU4KaUF3_M4+\QW(C+AS\Qe5C,.I
N5#g7-DKR;J?QU+=b=<5a[Q>TWf99Y^(Q9[.5849W5Ege3?AId1J<&bWDLg:TZ\9
ZKcP\VS86[ORK_=+(UG2DfK.XW1MGYY:d5dAF@_0<PWb_7K4g2V?dD.2RC:,eV:5
A=W9A<ATb1ZM6cb[J[9SFOP^0GcfFMFLT9N7NQ5_9G?Qf7D;&4FCI(=G5+_+38G]
8Z^COdO;3[7R_1e@EB;c7]5KZOPS77eIXfSI:G(bX=adTUH3XEc_c/\_-XDcUB=(
bLf?\fH@4RSHL.P6]DT^2c[IGFC?aW^8M,-?7JB[RQQdE#0^;d_6X-04Q&:D]Xgd
^CbYX?3(Y)/JaUKa2&[JEU3OP6.QVM@T+VW/Rc[HH::PcP&d-2Z.Q:(C2aG)US42
6Qaf?T90&0_;V)XScg0c-UJ^:S4P#Vc6B?g&G86S#Ge@__7PKX1dVWbU,HNR\Rg+
d1KZ^;cIfS;XMBaT833DBQS##>S+Ef-O3KE/+(H&9BX_8&:5Q[G>G>&OD]:e(X_[
CFHgJM91+Y#E:WPc6L+WA5[<@HCa0=J30J3e=1[]>A>CPDNK9J=[[5XY<:TC6YN-
>87;-(L>a\QY(cHg/^[-;#Q9=?g.Y4=K&U678&TG_DDa5_8,]Z^::=]/T>fHb:/N
5W(LT?bSUg\GaE4TDbXED2=T?IE3#@,/==/?gWf7WC_ffB\QBU76F65ZFb_[B(#X
@Z)WL2Z]B,J,H5H.ZT+,d2Z.SK-_J)S&3Bf>Yc5^UQ;d]A-+4@E5=Q=IfS\^PAA4
+)#)\#D1gOXU8)>6a)Y(4U&F]Kf0.ZI#gTLdb7be=dA215dY\CL5HWT89/_FM11B
SQd=YgdZ_&53eVW]]4>05?SE>4TI68#EN4&ga(+a7KgcX=G?E(MP<=\>X&)f6^=/
_19:XJXA+BUBc5_WM;Z.]U.B#NG9NL_R>WT57X7NF6I<]6_g.+7X_L=SSOMF(,]R
9;W;1f:T_cZI;fHEJ4L@fa)B5Gc,#2&/@Tcee>>SG@9X6G5ZL2fPcBSZEH1W10Hc
4,?[]0SdEDU4F09fJ).\7HWgEV2+08BeG>MJQUZ6>2FDP-@.GXAAAHSM#U^&L>J6
X:a)JRfDQS(&G&0YHb+Q_CBX)L[49<[H@gSgZLX6)\&S@3P-1GXX7f<P@?))Pb\T
IT.J/<UH/RKc,JD-bNEO6ECLYDT;&(QY0UdVN5CTAY>cPAM7/>W/4(@UMaBL-a9?
cEQd-NeNO;Ab2S&<NH0T4#DgGI<<OJfF@XbcK,><fcU;+ZU])Ldf2g_242e[;RF-
\gJV:J=KJS&)bWA_-+VGLDeRD@2gfB?1CHQMUaDT^S>9/442W;O3b10R?L3^1>LS
1LEE+^VeEKV8:_SJKI?b3A?HP7]YVMD(=+e7Q29,FNT@UN@fF^3B>8e4F,\We_AG
Of>:Q1246bEZ7Y5>&:8d6e[f_;/5+I)]0g>PS3L1&G[J&8R2@9FNeEQTe^;0TFgU
bdUROg9Yb7&(a.MM24?33KP?JK?5I(@?D>GH@Q.f)1^Y[XW:WO+K<H.U_a&;0P.Y
5?]XBKV^GR7?M,>,)QRB>Xe8V2UN;J0VRbEg]Xa06E@(?:N6ZYQ]La2KCPZPCdSI
RF5See=MSO(0/FKV#L]D@,=<ZR0IZ69\<6>UP-(ZJW?GH0;XUQK]-)[D7UJ?(P=9
47[[_c]/)R=>^:IN@C)XB;Sd2eD>6g\PJVB)Z>Gaf(>LE]A,FQJI]Q@Af>P9dN)=
]F)P9->Ve9]/C0>CD(]H?3d71>/f&#5^UDYB+<:dK3+@V>Rg;fV]U;H;L4#MP=-)
.G=+8HNfA7IF-KY9+/:@eBUS,gL&N[HLR2YZ/AJ)Q4D#@U&3Q.P3f_RR8@<S0\58
Ef?:S92a81f_8<;VaXTb8LAdY1M+6IZO..85M6f@32F6NOfK?.,J<=AOJJ_32;(I
L3c#).LVZCCIKVHW8O0U;98/>dM3).UQ\I-\SLJ]RUgCMMH4ZPOL0=Tg;DY<20JO
=C/OdQH;KX380R.D0CO&f#?KDH@;bDWC^M)V&f\R(T4/0I<#ACA-GJK8,DRD[-[X
6#YX)>KE-W\OEK5A+-T7D5d<6_3R(]EO9U6Ie#P5#+HIW3b#c9e./YOA)8DaDdC0
I(c]W[+?Rd5>.>XIQ]C]8A2F5Ya30HQ<AgE^c[Q4A#(E(;3dgYX,L@bb3)CL(c8P
]Vf?@c++gWaa_3W<I[L;#@db3-(9^gMLQPKKR(;;<WUOSbOE#gMc2]>A(MRW#MAZ
JC4)I/_8f<0C5B?FY/2/<5=#SY2aJ7J66L4JCaB]YY<f]+OS5P+JDZ_JFW2+RZ)5
_?@USgdZY6]INC4a8?YJF>J?Wg.89NaUB^NA3OK<N-2c\7<BdGT.PZ-g6AU;T?Q7
5DMT2&<Q7S=fN1[S-E<8C#RB]-c[/cC6e^f>M7M[Rf(J1X=c<3ca765S-G&0@Q=.
5&Q7\ZDYD#.)8M.7B.T6;Y?>D/c,4(d>[5,</X9UXD2#0):6R^b<>bU==c3O/>BK
CRS&FJHUfcbgJQ27YY\PYEKBd3FY]DeCYM#b8[F@V_CZ0bgd8-[e++gCcg1W99Vb
b6.12LJ>)(eEQP1TGcfBX1df<1@?G)ZG=?_G8]QQ2B;9V_IgRB(P9ZG-&[[THD9^
PN?F710d>2=X.>_<1Uc\fdV>0I?g.SaT>VDQ^]BaLaJ(K.KE2XF3e-7:X(=7U/_J
5QV.4_?b,cd8]HHgW-,4Y:;RVNMd&3G>+.dB5L/2PF5a_6H3-F2NN9>L:X2Y0?9R
?0^T@>8)Z1T3\SGUQF(0Z/_#T1)</KOUW-VMGQ<QHgB2D[99]C1[-g-.C^41,LHE
2a@JL]]fQ^6V=GVX\(2g?cTe<33cPUZVU[&7U#W@_U0IE7cf?WgWJ2E=e5^M;g\>
cGUK?KJ:fe7fGf^D3,cR9/R_B2?G5R9#1UOO+]FL25gX>bCaC,+bW-7cZ>3;SS1N
S5MJA\GFK=(\3LF72OGI?=DACUTWM3IKDdDI)7>BBENZ:+;X0ORD-##79-B7#e],
1KL@KRI#f8X7.Id_1E9D6).UA-1MD@)HS=ZT9+J\,9Ge/>-cSO@=RVZJ25C_86F/
O^FP_5R=5bR)\C&=F\F17J^>2)Y@,J55UHJDXdQgeML9UeYddaWGX(1.#;=]DAWf
MBV)A.-H9CPb]\WaL;GgP^c?>b:BB6Q\9KU]A>SJ7_K/+K8^ESbBgfQU0ZgfM_4>
QXT[3FOM])<J4IO3PS>ZTL(J;#7\P::=:C:B1W6fT0B]C./4dFUJ2?QNfP7,Ve#)
(5>b>6:.U4TQEGX=FSNBZ)7\;N<^^.Og[Fd,\fO9[^&c[EMD;_dVF^S-P+Z)L?JF
^;=O-^@:.(CGA156^@/EK\C7N4.]fdH&]:B[F-_a0S7cING(LYO#-<b8Tc4I,DJb
NQAT#gfR1F.IVWJSf<H.1LcAE?3Aa?Z-U;&X@\GV>H?fZ&V2OWS<.FI-f1VUO&9J
BR=Mc&RP.Xc./F]/Y;WbA^NC63K+\QR/>@ARc9S.[-MREQG_gaJ-bO7MR(/4#A47
O5:Xc5a>K#(Q^F_d2I-fUCHQa=^e>Tf8#FXOcJ&@#59)e^c15dOg8V#S=>]58=)&
Qg@S<HZ4=Y[N<4MWO.=,E^QBF1_Of)4)S0.dWQV(&,NPeB]<93aOOVJ)4cgYPJd;
+>1[[#5-W<UdH@RK5Xfa7eMTMHJXU(]R=IcN^CT,@d/PI^[\JP(V]ENB:3;U0QYM
H@3JQ)2ZP9LXNOEI&\7LXR/Ve7OK_JaM7[SQY59<X)N4\I?AH7c6K,D);@[TgA+=
ZVBLcTR^^P)R]-HeTI>_?a7F)4:RPeKO_cRQ7:,(C2CI9,67PYOU<IZ+75a6d_6D
+Qf#Fe32Q00;X,3G\Y9V9fKF0[U+_)G&85>6?W^T5#MKV[QPS98CNg2Y\b>^(8#C
CU,C]5\1dV[aK?]NJ=Gf\7d-KDKSb5^Z63P(0/=AEg-</)T.(B9TY]+G?0+Y5dTD
&dSPH2b7::OU_90:J,\:I/?>P.YR47)GD[#aGLV^YP7P.VO_#K;V(/Sbe\UeU35E
>b71E(3O6>7AF7EU^2J?(788N<U4Z;WcF\WA@9C;TV0DK8LITZ6_1>0(6g?-]W.8
@Jb9K(+@@]MX+JbcN=#[g#4(RfB8UR>\(FAca<+1.DLZB)<#A?e,;@Z)N9W[.W+\
1&SAOWT;ZFC58_.2b9O#cfH3NfNa<-]D(9c<O7]+HM-XecS:)_RXQ\FIMAeF[d4?
:MECP_gMZ?1O=e.VC(R<0gO^A59E2Wb&(-?>(>\HOMf6/,DaN0HSZ[&]?Y;_>(bG
K2e[=,c(9FBdU)3\N9=W_K>KNKc,d\@UXWS]387LCD^UMg-ZIR^V2UdU3#[FQFF2
d/I@((F^#?I(.LX<6WX]BJa87?.RFGTW,a1bJ?TREXB.-)-JW_AG<]BO,eSYKJ9^
FZ15/aB^\E[Ae75de:,_S6(@[V(ANZ+g.0)M=DW&),+c7LI\NJgYg;7]H813FJO_
H-C4e;LXI,<GD0+f,-A3W2;E.3X3E:V3Nea#N7<Y)EPI2JMR^X+;Vefe5gV+:[TP
>8Y1g7D5D4IP<W[26bND0d1TQYCN1T7V.IebFUA0#KVgQFIbZ+S<FC];.;&LPBg]
X<?&&+N<DP)YO=/Q8&JUa03^HYPVVfS^,YOEeVE#W8HYe01SRg^=cQ^PZZ&9A@4;
>3G+cbXa,>K+0X]PRFJIe8F6K.9^^?=Ba[0@R(R8)Jg.?D_b?/XacD^_&D2]Z^KT
4B8Oa3\P(>@D_@,d(;SdRD&7^,7YgJaJ>+7d40UIN<TWKS(=W23]/L?NZEFP#(Z/
[.P:P3=/OMG0UX#RWJYT3&3RbDZ/cMBT?>YQ3b]3K&3__Wa+K_AXbZ\B,>aW9IAc
/ABM.IWe#M.(F.,?]CD2LR_T>gYMX[&KA.R(7D+.L(f82EQILe[GL1dHL+4BX(,G
#1J]>^/ABL,E5:&QMORXQ[)G@U#RS]?.09CD##=W)=H_eL<SdeeeF(F:JfNW@Sc@
@7ZZ7Ycb<Cc\5E@dR1;GP3cL4M52dI;1:Fgcg\Y(aSe@CE#0W<TN#0S@\>dQg+WO
a9@?f&3a9J6[25>^@VgN>gYGH\-7:Qg0(g\@a_KKJGd(_:O^(AA=0eN,9c8PYaH?
;>KDJ3RUcYE\S+9Qb1a\=dNGfI./Y;b:,:B,,=I;U:C4MBO,^#&(2cH,3XGbMG^g
S9eeaBJ1X]]R-<=^=<N<,DIe//2g(\aJAcJ93/&aX@R3CSC.5;1a_X/c:?e9#92=
&0dd200:<47cR#b#.[RQfLN3K109Uf\<f\K[2F(Y@L0Nd\&9-AQ92Ka)KIJ(?98b
XOE7?.N7YP@=CG.]_fN]\Wb>O)NZXRM48?E1L1LC,A][4NOMDNWR8LNGEE;17:e;
+Ba+SK;[bQ[09VPHVOUKIO<eY@(bI][[.Z.URdL^=&OM^/fg=^H5Y0,cW1ZJ##+3
1EZ_85O6f1V(D6G\RQ3@^+(R2UNH(>U3AUc]VW.&fM(#fg]K=R8<[>(_576YVDR7
6YPBP)<cHI\g4DN=J(Z+JBQa2?U?A<=ac;QECbS]1@OGJ2A].9JMIWD7B<^(Y+N6
YL3__>IR&V0WU(@,T95VOg8YXATC]DSZBH;5Q)\]<caP-W.OMc8&/HB58(H6c:E+
OUP#/Q9_L8)@SCCdf<g^+)/]McacL>HZRF\4:WX9N1N;MRAJb492=12(/PJgBO:3
g.&(\@6>F&fCI_LO=:2d#I??6@e#P=AP1]+;T\]<8V[1T85D[0D)ECDD=8^g,&Of
V2d5bN)KaNUU:#PN9e7e-LO4e#?N:36>T6[0XDVN4d3)?M>P2EgSQW:d05.F,aBa
.b=:8fS^GcR7]5Q@ZccN<ggH-?e;.IOI?F:K<FY(Uc2R<PEI.Vg5[=5F=7f++@#V
bQ+_OK^VL[H5/)(cX8a.DfXJ6WHQ3MF]A4+d.S,[7X3PU@?@OFY[/51)D>M/7UKQ
CKdX8L3]GLC;--O48+K^E@&>IBH6:FLX8+[e1T8\-J_g;e]8ba]=f^MB#@MFBRT/
O9X&G\D3,O3[0I]7HAT6IfA7+&7]H7cNK_Q5BE6W/^]Fd,0EAf.FR2J0RY4Q@/,d
FJ8N4Hag;2H.+]KB^]UV)@M#<KKVK]W#34YV2I+dg+D>)0<7=E7]#R)A^LVPW]LM
Mg0MaF5_]=J:=Eg_OW]TM#0I>.fZ]?/R18G;ZOZ8EJDDV2G/g6T,Yc_CL1>SJO-b
:Ye@,&g@]\<U[A^NP4cQH0.A9XP[B^VP8=4e<?#:+DCB8-A?V19[H]eGUMC:C(8H
#VX(>g>#H@aPL<G6:?3W7+(@-/_OSERPKU?beBXgSKYNV[T^0:/0BBG/_S.8&Q39
FU2B]JJOf)6_2SKa\_;-fQ&CS625;J)M\.N3OdaS<V5(Z:MLY>^<.1)FB=\X/,1+
PL&CFSMN53[>,C:Rb]66^4N..QeJ)82@a/\@J/W,E:PXGXG\GI_D^XHA_9F(:>\-
#EH7b-f<15MI=0+f^=K<5>FB>F/^EZabfc3;J>=MK)44Zg1eN)dT7X]Q^6TX+?(3
c^M(aFA2V0RUL7EX2X0@D8bFEO]S-NU&@21YBK]<7@KC]XZ&3Q3HGcNKbOLUN.FR
:UP\1^(\D)b)C:[RW&8([Ac-cG7N^dPA9.WXYMcT7VF0VKLI.U\K\E7QGMg+D+A3
OJc;C\-Mc3c<?6[-NA9d8:FUH5<ee?gHT(62HMJ6]WZ4JE7<b@J1gC5\_^U/M>G<
/2a5ed@dCcB^c@&QB=Xb4]L1V#7;/68]AAB9Q&:gTOSXC6<f7N3EMWXCO?+Fc6Sg
0e#7Kc9,PCC659a\,g_d#T8+)BQ62_0WV@=+MCE&KXY[#RcS9D4S=/b;2c_S^KBg
E2-I6W?&P3;_RF>W]bE.d48[VDFD]KX\,8e<MA:857)_:cI5Da>0XC4_<gW=La&P
I7_W)GO70P:0C-2-J[^P]:+BM1JTMK)GAF1\#1Z#_;0R=a>ZW^S3K&0fW)\4L8RP
0YU=bdAD-efc@Y_1O(cd60M\<;X>UdZ.CG_[T^0Re1AR\9-3^YQ1Q4E2J.1\.R8c
V#_MLP),(e>LT-aS&<I6^XBP7Aca^23)<X:e3RUOGXa/5QJV/G=8:LIB-BGN023;
M^^3^a(ZXa\>.dcTgYO4YQ20e,SH<WQ=6BBgX&f1OTXgSQFK>VC-&J[.EHM#,8C+
CJ5Aa?:52D0.d/,1PG\A[[Z@IE/3><<3M\HRd7V+5[CYMRYVT>gTEXb7HASdV7Q/
<ZdIJ?=1eEO2;b[0&/2A9P,1R-[CKA0f_D7cPg_T#TK>N<5[X\a8FF6SWbVEb]^P
HZBTAHLYS-=#QA+83V2\PJYTC8.7H[/d+aV1G)MY=V7[UFDX^,6?+&=N=T.3>B2_
<[4JaHe-+Q1MNPQULB\+Xe5_\?WKfGSTdRW/E_2P9dDf/)>eEfTO;O\&:?Sf\0,I
&0Xe2afL^K&JKPTG+g+I^>QD>H:>64g:9,B5a,IQc\9WfZZ^f=GOTVB?-<G0O+U5
f-#8&GGPgG=dSLTU(G^Z7,4aVYC7>1_[CFaJCL);c_IU:YB:Y=1fJ):8@?YNVeAa
.VV->PgGf5B+(8@(?8Lb6W(1G[2ZI>T\J?L(4P[(0+=UEeI=4@=ZOGCCZJZ5]bB0
b3?X(;]A/?X:0BS)<0S)3eV=]P8^:W<H8XAVeV1e/:bg=O=-AS:fT5YCSMP+>bYT
12?Ma+QGG,(HK>g)/9XS^c,0Y1V2d#6cM]HB5SEBS?Y6,3Pg/^TX3Db?7HMaZ7-4
T+T/^3+D,].[KJMS)>VYLc<?>4NKK_\5F&4Z4fNSMa;PYKKLXW^L+a_V:f]C\W)g
/^f?ZeP,C:@5.^B1eA6;;-BZ#U_C&&A\ZL[A1/P\YB_a:11-cbYG<SQ\Jb5)]Z]d
XBbZTe,7=1beOYLPOc>A>:._O(BY4WG8?.+&7B:6=D@_IaUb1MEXFX)Tfb^3bTL+
@5KYf5^a]07PM[_T8-?fVR0gASX<\E+B6[Q?/P+@OX.P079,U[[\OQ9AG9?SBMb1
P9J\+32_[K0Q,C<T]81,c?IMMM.NPMGY/+<f_;AC=^-7P#Za05;4NP_a/Y)VOKb&
9N?C3I@=0>&_Ffg27C/?cg]\bI^[,+13(QC2aAJ4E;E9R54b.9/)#T+a.K?F@&5b
T]E=?JaH1d[UfJ(]Q=<KHX9\OW/,QC:f[N9P&ORB]a;D^<QB7#+TbeL,b2-\LgbM
[\6UX>a/,P3T\8c1\GdOEO^7ffe\169&0W<^8.I,:dMS)g4>/[]8Tb:)c17IgF1.
=6N/Sc,d#Nf0]E9VS5G-5#E9cGXcT+QS=_]+^D36dce&LVNQg_fF=VFT]:>9:\eX
Y^cEW;OBTRXQ,(P>O[S=PL?CWIH=4Nd)VB?0K?9]77ga(0aK/D?JOFU?:S\9#NG1
J?<KDPHP1VKfJX08LS2,&#6Y9SN.d4D=JJNc=fbgfJ\/?S#-J>\6/QX(D1K,dNRY
;M:R^16=:6I=GB8AE,B]_GKV,=LK&<N7a@(:)8EV3T=[:2I#([M05aK7bc_ea-PF
6,<6A=b0F@?O5WKE(UJR4R]H_.8\EKDA\M=(:e3QV[0fSI]KJ0KGac+R[@L02G(=
OJAgH2HGYRbd2JNU26S-T<HF-A?64+f5^9,<WXV?gUb+Z\Q3d^>A_2L\2\U:5@/H
_C.Y&O?)E<PSXe+OaA-9<K^5GT8BJ?2CI)I)6P+bFWN64CD-_)M_g-[S\#JQ#:D:
42>]6fLRa<D93B1DcVf+Y_7E2B6YZ93V_WWTQE4AYA0XTYGbN(b^D/;32(^SU#^f
8fUAS:?-+2P.8YE]TFTSDNWb8CWQ7H1SL;OZ[Ac28@CRP14^F&&O_c,:fC^1MX^5
HM^Ye2Z/]\D)TZN^=,_/PE0E)QA&<X)UV&>O_C3@EabJ>9JNOON8].YOQ(J@-,?^
9[cF3,0)?VBGZc/]0K[1YA;>[JY^^U>-&\>R(G@+-9KG34LXScMfKOXD+P80L^Fe
@&(1@/@.0D=<>,6-J?1c/ZC19>6U\>80I,4X;=,;[)B=/=GFf&>^X2Q7BU>IHG5g
^e^G&EbbXO3X5a>.2RDM:OGJ&=#O_fRaE#P3X,XGA<de5UeJc#)R0&(>&L-dfOWE
B^K1\3;[1;WV@)gOd,;7g:.VWNHVF:?)dRDT3g5W,1PE@D#QA(f;DZfF#VRY:K)@
_NbY]C;DEB\OfVHJ\2MFAN/^-,2O-JVgPF>KF0&1BVbaALQB0)ga78gK\d&4,?^O
:706:>PRa=f,U]/dY,SOX_98]?CWH>P1CgQC+=6E8?+,6QZ)>f-5S._2Y@2E-f,H
H:B/-bO]WdeXX-)[+<[0adOAE7eFI?c@QHP5caZY_G?e6b<Q[URK0#^e#a-R:BDf
?M7OYge9UYZfP7/RQ[<GGg&6H\#M5-G1C#6B8_[fP7(X57c3:Q8H7KAV4e1NfbWL
RR06&7Zg>fD)E)b-M0ZfSWf?]M@=b[e)Y0C-K:?_+(OX[H7\d38ENb.FCMa6QU4b
FKa9fg]fdVJ9+H6Ne5T^S^T;;Uc3A&LE6X/=cTK-+J[\K[A?W:+V)Q@\4@?J(EX-
\AZg2_LMLL)_T(9<9Pd&)WIDBNcf)7<aD#FMEeJU@D]NB6CF>-3D():RaE-1J,H,
fLcH#A7)1)5RYG/f/_RAPOGGbAc1PXaJLT=-aT>A6bPSO@?/b#)WP<76GSdDa,I>
H98[1=FC-4D1/MMTQDZULS<87B:CIg6?^S0(.eCF][0XP/ARY\2/d_K^TAXR;<#_
_f(NW7]@.7-g3C,2WcRf-S#=_<;D8Za:0YcM00.;\WPVP=e??U844AHGJa(@g#I4
2T&+D=U,OBHJ[K^-O(8U)?P0:LHQ#+_XUF&F=_>:5G=&=CVFV^ZO>O_IJ(+aL2e,
T+:Y4]#Z_D4L@G[3^2WNCb<M;g1[].f+_S-a^ef&-4NYI2DW2J.FOe5AK9?H,EaE
.]fZcT2X:Vde)B;+aCP#<N^38G&U_L(gP#Z,LA>IL2XPZK?<O(0LR-W.=DEKb5Ia
2,Q_@EH+eK.J9\@YA<(dMG8IG30LY?R0NEdCD8\UMaOMVb[0<7;aPDTWV>,Y^He_
#@H+dN(7FV0+N>^WO.^7+2URf8\][KVYI[.aUKI(J629O;J<63e.Q^JId_<gEf+/
SQ^.8,L:SbK)KGBD7;\5d+K\dJ#V\IO&2VDHH&>:[01.2Q_\H8-JM^[1@=ANd4Ce
g?MLQP-7Z\GB?YS@+PU#Z4A;K&W\-BM^ZdE#_A:/<0A:H3U#e@Z1BTVBMNW(=5g&
:Ie5UZ)(ZK-Wb.F0FBBLXR\3<WEVO)RPH1=Q90-)/ML]B&J_4J9I2A)Fea/R/W[/
26W?YEaY]#VNDdD<dEb;(GNF.g>>e4:T_4UT=g_2U,8e-IU]0S@bdH1P1eO4#P4U
Z/3Dd+3TP&UK+_<bJbQ1d47&K>,UeZ&YC#F5JRb@O=[f/96\+#c)L+9(Q^NY(I6L
EV#<9N4ZWT9+M^^fS&Me:2J>7JFQPARaM(>60.+758PHV+MA1MDN5C=@A1I#-RC3
@f2.KdZY9VHA77]d,/B=TT5dDUV2?9[f6?0:7.-(.fVU6P<2C;:Ff67Iea:^61Xb
)+15VNE>IQ#12U&FH.d^L[)a&(H:A_+=C^^ZTA0/Lc5X#;76W(\MXE0<\GWCaZbI
2\IU2WOSg.NV+N3<V6?=HXS&VWd08J:KHb:3bf/?A4fFBLROHI_dLZ#HTF<U(0J0
DYgZ=G]ZcF]W3Y#.;eUR&EOJ0dIQ&5=2f8Q/EA<S1PD.21P-5X\9;bcN1A+RfS/O
[2/G>4<dVJA3Mc->CORF.U7TW>LTZ-Ff&>^dHN?2<gEX8]8^^HD;\)8<+#UQ2DFO
7:eZgS@W9[(b)a_F4+3(T::I_W^SN)(f<HbEHYI4_N.W7&^W,Zb9JFFMQL8VSG>2
b113Sb<@(Y:V;VD#Kg]P<=J.(X;1JJ-6,\3<.O)#W74?R[>#]3G5[P@AHG8AO/8S
L;@A^)GZ2=#:.C&T3\</=?O&[)7]gEX]_KAb8=9a?Z92#<X+&\T5O;ZT;3M3TZHC
Z6R<DGC)a4XOQK[1AG4IE&GYX]If6fd?:+b_XE9WbI<-&:09Z/<:6?Kb(S=+?JNf
eQSTXcgg(E:&LDaWVI,ITF886Sba>\&58Y;g+]U8I+^+Ha91@@)+YM2E-afW0]9]
0A=cN^HEV#1fV/7;&.Uc[IeQXYNYVg<&ML=E/BK3JX?2f;TTEQ2<GJF@fg4LKJOG
RJB<4.BF1_^QFZDdb_6b?JTN>(Jeb1b48E[8,I)1cZOKX[]_D6@57-KbRQN5Fd=A
_^Ac_-b]O(M_GTR(];=6dVM^&LL,]ZNP8=K[.UbJ8PNH>>aNM?1SdcQD<1L#aLPN
F]T61AKMH#-cV(4g@K0IL3E)@.IP5(b.D@<g2M3#C>Y.#O0?9KD@+g?Qd:\M1]=0
X9LR2NS=8Lb/09=:&[+@50-I.gKLg_E#AHU;X]Q_;?fa<2WC7;1/<]]AJb;e_UWP
)f/([W[4>WdLf_E,^/M>a=:0]N?Y6=[2_OCQ-D7\7U)Zg9O]BU^W;N]Fb(/:AQ__
:RZbS6;T@0WMZP-Ca/\,gH&-:2\#A:R9.b)QGb\8W1\FTC?/RRbAEDUS<(MH#48f
d>(VX8UfG(C;AYaf_C2HaX=d>Y<cOd8fW59&NcYP;TX1U,D?@:dKWcUMTZTA+8)Z
TVEG=PO5H#7/P@fCTbe=P.RBFEFEWQUNJ,9ZFX:-.@4FU8.JQ_Y1_HK40g^d^_0]
f(;8@cHeaSGeV)MI91[g#RB,ac4FQ&b(_IG;dWEU+[b<a,PfJ6dcbU#)RHBKTHeJ
g<3UZL.?Tb?.HZ/CO.6Eb@M.>?S_O;;GE2;E/@_.V=]K^W.VZSD^&eB(&\EIG8P-
C4W(O=d=1OSQ#[W><9IK^D\_dAF\J0OE\M.g>TKUgR>T:9#Q>(f);:R@L<V&OY/;
8<DW&X@a,.C+Q)QSV0N&>TMX8>6H4Le8AKUTTAb;;O9-\SBSL96D.=_3AJ,IKgF;
fH8FIS\Y@2GZ<OcSAG\,\K243/c2-2+<6d,353da:a&6ZBfI=_4H.#FVPY#.-Ag2
B[W14>6@R>TJ#SY@ZRTEQ4Yb)GSU>3VW5f=Z0aOAVQ.6+&QWV_MVbU@TK1H3#+[5
>N91_038b_VBdVY@Fg2[N>DfX+^W0\]XO1VOS\:UX,OIL(-&7V,3H7/R13DA@2eQ
3>+?CX\QVfd)<b;B+.TTR1CYD[Y]CX.\H;TH(7bT;=K8I6(Z:N8[fII,0;@M0T30
)X6;XC_.W#9;b>QTA^E\&9a)A7dYP(-\fae>:J_T@cbg0]deF>aP@Z[UCJ(1CJV^
W=RZ^DE>DT[&;T;X/d@D)?@:eB+PI^4d>Q0I>/(^2XPK0=S7_>\IFV8^-B^6I5,Q
5degSP]-)BFHDY_>(>9^T_HaIFI)E6aSPEY,,c;M#eC>V[?>&eTV&OB2Q-[a\e#d
;Z7OXD#&;KL0ORT,=6\SbBBCFcfg?-FDQSM8A3/BOAcXg9DP33(XHWM;(>,TJ#TT
Z;_RCP0(J2ec47RQNXOKW(;2Va.;VID&1Y9?)9:+8&<3?&UbMW2fCg:76,)6\g60
+^RFcc-FRI<-47I)(,c<+I#6X&1)\7;.,9fOHTeTZIW&(_1J0X:@Z1P5dAH]BBFL
1W4\9D</aUKSa.(G5MO)^[5=_G#gLAOVf-Pa_bMbI:Ff(MB-BTK^[XABMVFFG]K)
3Q_C)Vd^(D9^A?Je]_@6?DcDaI+IWK(D5b(ENeN6:W)THe9T4,+.MLggJWI=4O43
T6Xbfc#_5.1JgeJfCaX;bNZ;C4T[=eLNI<.8J_ObQ&&@-6B1X,F-5bY&T=6V+6+Z
2Dc4-=3Z=>f1W:)<XWSQ=e&V0XSDT#BLF?>9_Ue&RIggb50,dKL@.HLg#V5G@/<#
LC0@Xb#f7?_M(QS#=4g9C7<;@W-)]F]-M_d+@[BF9LCgGJeFHVJf5(S[@;gOb5eK
,9M>+1EU)@D):f&-^aT3DK#E=F=PE4C[&fe[^0C]B)3d];FF(gdR4-2.5\BT[;XO
?b2Q),=I:4AM:PKUM/gA?DZ?@(DRJY(&+O-Q)7E8+YY^>Re;TG]4QG8:WS&_TE,g
G/?TO8W]##:L>X7<Ce#4#NK0FR6<R,KGWWf]e=T=N&EbE,BOCVFNM-\RR_NY@X\I
D2)IG2VQOc;M^Mb4ZI+V>4g-Z[PB6?[LQ/Efb7aFdQ5<DDU=HTVWCgS8CDR,F_L]
a7]9B+T]9ZHR1PdG(<G80c)P#KH&IIAL2W=+=AV7.C-@9BSS@a4;gW_GPH0SgCNg
H08DD-)1D/_NN8^>dDIM21:PeZ&bZJLM:#DC1.<4cb>A[C<^;K[;GbQ^<,T3MHE2
;D=<^c&P(IIW.LR:1-W)6VEgg66[78;WW[LPaN\JgF_Y&0]\@3=J/??.Da-U)=P<
]I&COWTc2gQ_BL+9_P4^IfK,gNBd+IN)11)C2dVaO&S+UD-cZT[WBaR^:]4>XI2^
2\9X=OAdeFG4c(/JK(EIP9]2JCS54dKV:3B+;T.O9C>>K?;TM^=W<E?48fI+a&5U
PWFL/a&84GJ#;T#)H9cbGDcef]\?UB9D2@9DZ2DI0>)4d/BUIF&bf5RL47D.^O@O
(EPF4?E=-GR]B@df722N^#DfY)CZHI+@4-:,#A;B:?TJ83.-cSSH&<^4+-]Gc-YS
><46EIf:&3KOUKM@-(.]2XGF[Z7Z,AF.QVIa:BB?72FF27aQ>1gG)3f.I_\9#2?4
^\[M@+2Q<e:#).?2+9[Ke:)()3Mc+&?SLQN86K8U9=N/I5,+-DMb^)M:[18H7J/S
,2d3N\C_W#cZ?4gX9XC);b6adW3B.M4@Cgd-^:CUbYe?B?=_S:Z+2]-YUE=W&2/1
1?AN8?FaDSJL[)Z3beBYG2\-]Z<M/ZTE(->@P5QTP=?JG&EH_d=.b+G:O->.N8]L
RbKc7FKP&B72P.+[,BYVa^]8XK#:O?E_bTO1/^:3;f^0X@O]FR-E^)ZV/Fc<EPP0
-1/=\?52CdJ00[+VY\JTfbHMDc[(JB]HGD\4N=8_NR^#a^1B@7Of;LEF,51cg/J[
BQG3D>2GJFK0VPZg)J.G[=ZH\R9fbf<>fT#&92=4=CYfOP-]@20+:UICXXZ3V.?]
Sd@FUNT(\M]KI/b<GdM[J6f\,0A-B>HA?]OO-@/,7F\NDGLKM&,D(;<(65CXW_[c
Dca^4?(YUb[@<O](\Q4(80eT8VXIEDcT.5SA\JOP@5=b9K5L[c81L[#?[>:8]e66
/cQ\1(N69Mgg:MZ9gH4OROEGX(^+E(;AC;;_NTKEPN/NeF^Rad@I7-Q/Cec_:U8C
g/H66d.8CC7Q(D:5,)We17-Y^RM##9//U:_1NT>,Q&68\@4)<)QJb\/Eg\,=#:P.
6O9#VIU]c#SQ0f9?.?NIHc<BSJXKe\3c+N:/E;_CRJ3BZO;RA(M/e>#8RUV&\C+e
<3^:-3L_^CN,1Bg+&=M=.e-9aONXYWVU(0.\YZ&b@^K);#?43LL0Rg#4AdbM.gT4
^>3DI]1-,T&;da\J<-L[LJC@5HXY5T[W;RUL\E9@<&#RV(;N9AE0d&?DW:2\\[I9
IMEXTIc,<X[PMfG&U.9_(NSRT6>7-Yb.Qe<W1KM&B(@X92;?-MU9Q3AI)e_^-,a9
8VHe7[])+36+HW,gCc<,&FfV?4QCIJT)41O3U4=e>Q8dFR_5cV3T;&,b-I\E3RQ\
Z9N&LB:eAE,)(-D8aa_1dT1X/484:@\a/.f8XK.)N?RaO2QOU39KTG209ad:W[2g
1V>D0BMY[#cVaUb;7JeFT7WM,&&SC\d=1WR_UHW3Z:UZKQ<+7U#RQ2CK+)8T#R7/
&JZ[F=9>^8ZD3GFMg+0;BFLY>VZ^2Y0@gGW.ZKG:#2fU8N66DY@OE:R_Xd&(E\8]
JMJ][HSJK9>J^846g<[cHR^G.A6DU<7:(U)g(7W,TcN>GO[8P4JCHP.fR(&/]EVZ
-8FdfG_CPS)3AXRCcB\EDQSaRd^+f4#a:,.BI:D>KQ2>,^<M<d7O.,7D.&0)Y<WC
[NZb/7<;c,.I\@_]d&FC>.@LQP)g\;GC+bH0D=;8JJPG9Q.9d+4UAUD8OaLbW_G[
AD6:V9fAfZ>NQ0-,SH6V/=1eUSdMF=7K9?Z_A@d6((=516^PO7S,VX3^>#7NVQA)
42g57@4^);-T@#d+Dd=;e/TCAeBb6^61d/7XYXWD9W-367&)dYeH>V,-5NeTQGce
af+RN5G0M^37N@B/46V,_UVCKMYCS1-HaD@VS#WI;aM.E5CS+#JV\W=FY;]MacgP
&)Se(JfO)MPG/ZAV_^dI5dUPZe^NMFFTHW-?OX3N?4)JO4Idbc@LdfI:^#,V]8)V
DC0)LX1.8V_]\2dV8=\;8HdPZ-5EG4^KgL9;e:S7dA0Q#LH4-J6&<XG6A<?CZ+69
.?;c>4J^4N#-TK(,]]0ECF9+F&7TA(VVEgK&K<]>_F-,5ERf(WY1[fgK-DIG(0:]
+GG^5GE(VC6d_7UZ8c@DVbX&Ef+a<^ZNfL+#SAf/[e4XVP3PQUEZAC1Df<N4/PO+
5QcJUDQH7;TA2#MdA38SgD)L;Ia^FB:XZ@4/<42E-,5cE4ZS0W]MRg2QYO.WOR&E
VL>HdU7dZZ^fcce:gX]HbK88=C2aC4KLdb7&6-744;B_CWP^DPd\-HDa6[#RFNT8
/g].,->e:J(-XKd1^REaD-<6I;B6\QbI]Rb:>Y+.,P90#\-IB@W;>^[K&-Y&b0J,
?I#UXX2)UU(\&W-BM-6@HS1K[<HY:H-Of__@9S([bT<&+NSW;\a_9LDX;81L9:ZG
(GZZ(8Q2PS6])EU4b<cR5M+O&;[2S3W6>YP]#]b=\6?N>_9ecG(L0dL,U7cEDMY0
:VPeG0gVHDg_/Tg/DSO0cbLKJ9+WR1KKI8,A11J<-bKABSf-R-XZ6cDTObf@BDK2
,E>;0SERSd.N(aFT_8ga,[0,#K9OG4eQN6J(MaWaK]2/EC6<VI+H+JTK#8J06VaE
bA)JaDU&LG:EFXX/&Z]e2KK:fD>Y6E@UCR7DE?Oge,AcHY\B\RRSVMD&T#LJ-AOR
;6Zb598V)]Jb/Xb\U>OEBFb[62J7FBH]R;60DR/SNLM0WTeG&&Z7?QJ?PO2D)R&.
^b(&,:T/W<R0F@PCB>KKe.<JI+GA^;EOVK:Sgdf[+U[CR0.?)ccaW_93D(#U>31=
0GfLFUeE[8&fJ(QF0VA\//_agKDFO=O:^cQIfOY8_W9?3fOF0?a[-:+YJA=Q.4KN
8KWBQ8a<?[Ac2:5O[]BcJW)CM,F2>RDGD7&A_d#eRM+-46)FcO1W]:Z4_-R;[Bgb
Af]^RV6&O?T:A+?V;^dVD0cDaGCA5HCBVDZe=9V_&X?7f\AZ_LC_;6=U&bc_5U:)
ZCEFYXg#POUWU?=MZD;LE[@;VD,2-0c)71418#6BfTffHb<]O,J5bR1A5Y=,e[\c
R&O@cAbIH[RcgDe=]86+ELRg.ZNXM(59OPNBAQE>Y)aC-KJA:5K+Gb#C5NE-;2LK
-c?(gK90C<^dT+JSCG/6@Q:H&gPE+)a/H[A]:6=S40D@MdY0A5)9L4K]\d0>[&Z=
&7N]e5_3XP=#5PDF_JSa>f^Sf::.+1/P1^aO;EbN-3,O.GfdgRPCfHO+4)HG4,Z;
QXZBIA[(YY6G2VNXbI>Bf/1A>A_WMc[#P_HH0cRM/U67\BO^?Ha@W@R.)IBf>66X
KCdS_R:Oc<c.V)L5ACNGF\/\>543>3:67T6)F@4Jd21aU7H#eIUP4?7RU,[fC2NT
.VCe9(ENe3e())a^&2N7^CG5KX1c9]JW=gS1V(<X/([.&b<MK.)<\M\9J/g^&cFD
A;3KaI?ZeZMA1UR)O)_TUM;2F=SJP)eB&9\.8N/SXH;b>-5(U(RLY>3g+[:UaVS.
SL#+2L5C\[ASa&<=S>[^325[H##b-OegRBM7:c>^4@Y[O@MDGATOGSA>F#d2#I\=
I+2W]SPZ2OUDZ6VP7KJeT3&/97TB^JJL5I;2fb<>FVYK/@F]:^0^THF:?9,_6b8O
QYE(3#e=O3,[YH6?b/7M?WQKSLIMJ5=F&6J6PXYcW6]@Y>e0;IW0)JaST.f>+O&O
O7/.Gg<&J^RQ529K3+=<-/7^?DJIGX=)IM^LX;_e?/(aVg18;UH4:PTfHdWI)8e\
?b1+B^KP>6XPOI7/3^c]^8#e_9M9Q#P/HJQN=DH=N=81.A27:L&Z[83=)5.Q@:<B
U?a=895B(9@-g27QdRX1L]PF2d[6RDT6,:,8.g@#6YTe<?E4\+^V@I(3\ARDf>MM
2\+RO\eM4@PTMO&d=5^)E#@+XSV?f+XG>4a(?Qb14Q]9fc^Y9K_&H-[;,N6,M)IU
[S^I#GIXDN5.B^NCJ;H.@b>d/:V^6EMaGHAVVNCT5:H@:]-_H_-R1Z?,_Ad)CI^Q
5+FX<]6Z^?a/2R&bc<[>H(I3I9G<e+9N]dCHYV?COQRTLX(b3)(;-QL&fAY7/]eP
J;O?cL[+T7]cEbZ?^+004A]98e5cNO=YI-J&IJ.dZ+Y3KKYb)2+/XdT2DW?A=TYG
>52\#=DHAD.,FH-5,bfMUa<P?2H57[:,HB+?c925T3@acU+d>/c;ZH=9XF#V/WN7
JQB2/F0_O_BdGcNGC.SO8MCQLbW;?2P;gG5C-eD[KdDWC=O7I:<[dXT:a^K#]6V;
8&.F\gHca=Ee[76aJ-B,G9G^e0>0#K[[J]/c.J4QMAR:4MRPSG3AY?&:GU9KcTKf
_C_1(<N]4g4EX9G-NfbHEU@_X2WJ8S#J9YJ,/\aTR/ZM+&6BS^I;]f?VMOKWfT9.
9@,C4-0eSfM,>#3\LdPe094AC4VW1_eT;bf+8WD]K-?(^.4AYbW2J.&]L&#0Q2,9
MSPX\b-&&_@]3Ea1/AQNR;Y&e.fX38PVNGMRb[,SGT7V4#g[5K<D(QDgOH)1bR1]
de]S=C(5_2.3@D(OMRf+EbGg(F6(X:WMX8EIcY]6I(N0Z=?B\N@JF6Cff_NOW9A\
8X1Q01I1IMJ5F?C&CSK@S:8X_dH<4g(:L,RHRBG5QN1=c9#5\I3NC3g7MWV-<]Va
4V:\+G()Z7a;9d@?AEVBD#1W:H\>[PF,4&f&[K@Z3L=PUCZ_gTWgK)LB[8Xa9]VF
c9ZT8UQY#LFP]8E][_[>.9LX3EW/H-XY6-aR\:ac5W08bfMXS&WX=.:^L9U:C(CX
-LFS8]V7&B(RCB0Zb/Q<b#;3Vc6_@UPdcFC+N<Kc_D<9f+[9TYW;1>5NG\^b9<\Z
#>]NG<.2\e(?bJV7(P/Lg97X3H,HRZ)1Q=66g8#@RKKHJ_D@^_.6+Q79DJE)VZ?;
682K?4R<O&aX3OZ.c_c5^\\(^#Y8(;LUZZQd@PES>([EPM]9AN+dTMM2#Hd5)/F3
18[#CWH,L9??IC;;?W\Le;fE+5bEJ673L6B>77NKP>SJd)C6@M/,L0595T7N4IH5
;<1TBV34aO9Q670DQ8:NDP4,-2P6O@#@O?Q#Y@)-e234b&[:@;(G4W,e>WU6c6GN
V/4ZU=[U<SS92M<,H&-HgUQ06?WgG:+;^9XXGMF-2;X20N4;a7C(M^OS2Vg:^S[#
R63>T0Ob@+aG5+ee7[3f6KWP;/8#,CbA?0,4R)#=L=I_a>@MWU5F/=gNe4,-<SYM
)^ZK61X)V/L3JQ5]+J#X_]f:?=feSYX-#Qa&?7b@547.Z&,S<XG#W5IRYTc^9,_R
aGM\@.U6g<a#+K50e_.I+Cc@_U;MPc>caDOV1]^9NN;F@/<GWQ3P+BK1G][33])R
(HW;3S5;HA.]d]28F\b0\GOGGU<+@+&X>[\a9g5/@+F_9VBVG0;\;O=TC7)Ja7V\
7\N,]<UCD@9Lbb7G:\WS8GdG,]@KEa;]_FMRC#;9R(3ILd\AOe5G/21AD4:+_IG_
VA^NX3\9LR:CS-[/^WTOba61:+J]bf#CGVcfHB-.(=Z\1e^aIfd>G1]V?5ABYcc5
X1AJ&DO6d.SWW;5/9)ZbdE@RY==8)-5:9)84>E,W?3Lb>U+DJAe#-g8bC3)RHDM:
dcQ96IOHf.e.aBJKG+))JS8V9b/(YW21R^#(]4&WR,.0=\,MK]R7]N1+cgVU+F,J
0S^J-^A.N@:dL6)7.=SOS@CDYKXN^[CO^G>WFaI?Nc[,KAT/37#L:a#L[3?;[J08
]#^Y^]Sc59g^(.dOBcI#,]\V)QYYXL<7E::HQ+LEa6CceXXPKD,T(BK22g-+J>]e
,D;e/6W[8D;FD;T=Y563?.YS-5(@f,S^aUfLLSPO-A,PH3c41-bf_;KOO/5O5WTS
RGRG<X\?@O+T@A@ZW7fVL5dD[#a/ZNQa]KSdBTb1DD]J?5N6ZPeA(#E^H<4_8f\D
-b95.K6PF1B&Tc;XFU^B]/H,89LB+<?H.V.>&Yf==NYN>deSa-/9X3E^P$
`endprotected


`endif // GUARD_SVT_AXI_CACHE_LINE_SV
