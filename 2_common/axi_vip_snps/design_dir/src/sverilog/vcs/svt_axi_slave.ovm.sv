
`ifndef GUARD_SVT_AXI_SLAVE_OVM_SV
`define GUARD_SVT_AXI_SLAVE_OVM_SV

typedef class svt_axi_slave_callback;
typedef class svt_axi_slave;
typedef svt_callbacks#(svt_axi_slave,svt_axi_slave_callback) svt_axi_slave_callback_pool;

// =============================================================================
/**
 * This class is an SVT Driver extension that implements an AXI Slave component.
 */
class svt_axi_slave extends svt_driver #(`SVT_AXI_SLAVE_TRANSACTION_TYPE);

  ovm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) vlog_cmd_put_port;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  //vcs_lic_vip_protect
    `protected
9c5DWUDODM5;A/]/]Hg?6HG:/T]Ng4d8PTQJ#-:2B.O<I3bXH&:(5(Ke-6+dgKJC
@N9<FPAB6RAGIg+Cg^]cCQFQ:b3Mc,]U?Wb6_?-#Xa[:Q@cD)ZfRQ_7efUM/IX..
OS;@bFF@1]8\_5SfC1(:<P3IdB9W5ITG^BS961C)[FB2H8+bdLb069PJNM8DfCE0
&(CHU-UQ0W[_Uc97OA0G)2/7g#^?6FG-F=UJQDEEMHcdSU;E9X@XB7:++=YH\Z/H
ed;OJC@1<(1feB_DRLU)B.KO-R)fMb-TJ<,d[]549VT.K9)M3\GQbV3C)?X]_/):
Oc66I)/5,M7eW=G_;X>.0^g1XFZ.HGQ_3RFDfS:1#0cJD1<GA=bUXY<4N#+.0P[\
KVZb7?T<CKQ7dJC#C^U5BP?&?Qg)g(<<E4--@20EB5<_1/]5+WFR=#]FG?W#4PK5
TE2Q\KZRKUe+J6[eG+UOfP#2D[\aBHN2<d]N_17NKJ5,442R<@I[)9:@^D4JYKB2
5<J@f1L5Wde[K4CD7d,F;VN_7T9HMV4?((A>65UPC<Rg:UKF>U8]5)7S8F6E/3.?
^:S]:HBP<?g_+[dSCWa45D\bXBIY8K77@Q>,30W2gO(4T56:TCZO=O5)04(4V@XD
87>;[VCg8dYX.<\NQ]L>:OMdVCg7I>eNV9G_4Q:3gE6Wd2BQ60>eF[DHQRN[?e?f
A8>JaHYB>f:L9BMMbZ:R/b]dPgJMK[I7)JK)VYN:=Z^KZROWNTK&)fX=/P#RN();
A6Q?9a(4=Z5dAO)(J>GG,;N5[:BS@]C^O]fMZI@,OE:X-:L&[cQQZ(Z&Z&900Y&G
QF0a,2KPM6&=_5O]&MF:=C4a_BQHPeM.WZgBY^W:45;5.<S;Ec?&^7>RZ&Y;&Ha0
6C0O73Qa13M+5V.51C(S=,.X;ZQG&75ZIUOZOX/?[VW(&DOCIg:Y7_SBX@6\7cWc
cST;4[E#X-PJ3-)325X/5EV9BM@O^J\))^R;FHU;/MZ//>)Ha/bXc?;CWI40aMQB
;b1BW1IVGWd7(^@?gJ9>Y&)W[24PK\9_^M3-R2H#)0fY7L6GL[H<[HN/>ZT=2OUK
JH\g+N-,Z[4FIYCQX:I<X#&EB@+Y6QTM<B]A1:)RV,f4SRR9a>HDOCI#0D;GcU-F
A.-SYaT9N+E:GD#JVHJ?(.&E7$
`endprotected


   /**
     * Response port provided to supply respone and data information in a delayed
     * manner. Refer user guide for a detailed description. 
     */
  ovm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE, svt_axi_slave)
    delayed_response_request_export;
  

  /**
   * Request port provided to supply snoop transactions to a slave port
   * that is instantiated in the interconnect.
   */
  ovm_blocking_get_port #(svt_axi_ic_snoop_transaction) snoop_req_port;

  /**
   * Snoop request port provided to allow snoop requests to be sent from the
   * slave, using Slave snoop sequencer
   */
  ovm_seq_item_pull_port #(svt_axi_ic_snoop_transaction, svt_axi_ic_snoop_transaction) snoop_seq_item_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI Slave components */
  protected svt_axi_common common;

  /** Configuration object copy to be used in set/get operations. */
  svt_axi_port_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;

  /** 
   * A semaphore to provide exclusive access to add the transaction from 
   * sequencer. 
   */
  local semaphore add_to_active_sema = new(1);

  /** The process that runs consume_from_seq_item_port */ 
  local process consume_from_seq_item_port_process;  

  /** Variable to indicate if the consume_from_seq_item_port is blocked waiting
   * for a transaction from sequencer */
  local bit is_waiting_on_seq_item_port = 0;


  /** The process that runs consume_from_snoop_req_port */ 
  local process consume_from_snoop_req_port_process;  

  /** 
   * A semaphore to provide exclusive access to add the transaction from 
   * snoop sequencer. 
   */
  local semaphore add_to_snoop_active_sema = new(1);

  /** The process that runs consume_from_snoop_seq_item_port */ 
  local process consume_from_snoop_seq_item_port_process;  

 /** @endcond */


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************
  
  `ovm_component_utils(svt_axi_slave)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, ovm_component parent);

  // ---------------------------------------------------------------------------
   /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------

  /**
   * Build Phase
   * Constructs the common class
   */
  extern virtual function void build();

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
  extern virtual task run();
  
  /** Report phase execution of the OVM component*/
  extern virtual function void report();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /**
   * Method which manages seq_item_port
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_seq_item_port(svt_phase phase);

  /**
   * Method which manages snoop_req_port
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_snoop_req_port(svt_phase phase);


  /** Method to set common */
  extern function void set_common(svt_axi_common common);

  /**
   * Method which manages snoop_seq_item_port
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_snoop_seq_item_port(svt_phase phase);

  /**
   * Task to drop al objections if there is a bus inactivity timeout
   *
   * @param phase Phase reference from the phase that this method is started from
   */ 
  extern local task manage_objections(svt_phase phase);

  /**
    * Implementation of delayed_response_request_port
    */
  extern task put(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact);

/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void post_input_port_get(svt_axi_transaction xact, ref bit drop);
  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called before driving the read data phase of a transaction.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_read_data_phase_started(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called before driving write response phase of a write transaction.
   * 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_write_resp_phase_started(svt_axi_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `ovm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_input_port_get_cb_exec(svt_axi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * This method issues the <i>input_port_cov</i> callback.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called before driving the read data phase of a transaction.
   * 
   * This method issues the <i>pre_read_data_phase_started</i> callback using the
   * `ovm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_read_data_phase_started_cb_exec(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called before driving write response phase of a write transaction.
   * 
   * This method issues the <i>pre_write_resp_phase_started</i> callback using the
   * `ovm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_write_resp_phase_started_cb_exec(svt_axi_transaction xact);
/** @endcond */

  /** Returns the number of outstanding slave transactions. */
  extern virtual function int get_number_of_outstanding_slave_transactions(bit silent = 1, output `SVT_AXI_SLAVE_TRANSACTION_TYPE actvQ[$]);

endclass

`protected
2OdZGJX]+fO]^63/[@9Af8+&LZ_F8be)G^1+ZZUMY53Z.)d/0?K75)#E]L8V(eIY
#X.DX4L8]B(NgeDYP.E,BcL<#&&#W^NKBK5c(I<58^3;N?WaHGZ3BGB^2UU7^Zgf
B\+5M_TR(N<[R0a?RX<0YJG_7TdHYA7)HWQI_XW9;>:C@SIZV4IeeBa)SZ_Z_S::
+](aQZY=/ET47[(V5L]M3)7TcK:/-R)2EGVM3e>[?1;Yc0FP-)&@a2RUX]TCN9e>
RF&<_NJfU1A&)ab/J4aTg85EG)2E4#3F#Qa+31J35c7(@@QRcT;O]_P=SR-3>XP9
85GV0_D7b1QZ._]WgB&Ee/a.Bc651.CXdXY9)G=N3RITZKY_5[d;=N2/Z#V2T_aA
29:KeX[ZedUdUUbQf6PM3+T#,E#NA6G_OQ7#E@e7VQ3bb[MAXQ\ME2-S@4]ENec,
MNI&PeUaOYEVb:1]YScA7N6O9_TaT?3[)Ve0cb/+/O9<eFL8efg7E#I:/P#9W,fL
_G3@Ea]9L4GU<@#W#dS7e224R.[YI]K=1+QP[V>DP,PT3J>TYO9QU&I:M$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
A-TINIf7@+8U1H\BC-&cC#Fa2-/KT>LCeZ1S:H/3/9e377Z0MHJ7((CH,JHI.E?f
[]IR706;]<O60V[;?ISTe;-S1&)8SMMK\<<[4/>=eURc7Q8MZP.Y:G\OCI2\YeT_
O/(Q+#,KTA.I(;gNR1G+JO<)FFaV\/.FE7L2fO(3(-6MZY[E#=JO&92_0&MBG]0B
IKa+dXK>M]V>VUIdRW-<;d_8Ze/X6VdKARAICA2<&0GKKU\BZLOe6RPbAM#3P)^^
Pf7RBP9F2Mg#MSEE9-(bYHd=/.a3@NR=e&=Af,WbQ4(J:-CD.RA#WY0caL#WT[cO
:<>Z9]b=>I?.M]GMcSN^K>D;N]:+;\]GQXC24#Z.28DcO#5<EARF^]G7>KbQ8f/2
/^M3A#5?2K0-JSa.431_KSIS-W6d5&WE457OU/;O,4(#=+gEg:/RaXLc,NN;VJOR
T8A>0g-d24U@738\9&#@]Y2CZYOJeIXCY3bKJ#eRS/DI<8[QXDY-GYECIPf\KZU+
BHcN.#NG],\#8cA8U=R9@@V1YG]V7X9E<ZK,aUgCT;Cc83B+e68?+1efBJLa+6fg
[/.&9VB=T^G:L08\WW2a3D+\9dS&N_D\&-f,^]4BMR<Wd\#7Reb\7YM@I?R]H7;f
B^9ON7Zg_EQeeK9ZBC-\;+fNJ/=AeNKYXD4GZ+@Zg^]50<WZ07AHIIJEG+dV0:\N
;Z5+1NV1F44U5g^/^?3NKAX4=N.E]OB4NQA@#]/LV&#/;B-L8:3f@SW\>72D^c?U
S:gKPP^JF>Q,^TBTHY0Y6=K2aR)+JIXN4a<9>>YLFF,aIQbEZNF<A,)]#Y/g1BJT
.[-DP6C4_OcR[c[LF9&;.XaT0=EF[PI:,6#H0f7EE6K7MJHH9=69LS_FCgJ2e0P9
,YG12BTX4#5@<HeGEe8NED=E7&R;&^N/F/HdI+IJ^&#TG:?)S;Ta(ZOIV>Yf13Lb
+4,OT)E^TO7<128^KR9OZ&DE\0-KV:3.C?C7)Kd,A7>J[M6VWXM^OY/Z8)T@4MKM
(?9Ee(W+L=+:-=Sf,T>)ddNUO0#2(c@]eIA5I<#)g::7#g:?=^WM_:C7:RS34:#/
P_Z1X3+KYKa=_b/5A\BD3<?S#7+P2N0aKM@8J&5P&G1I#c]-VVK#_7fIE@#HbGce
5KRe9OLNJ+T0#X>+;]Ie@]+4=.B:@M/LffG[(;BRga^QSV8-VceTY//ED]^IcS.,
=AH<T=7fc4-N1A8W^G/L#M?^>G4;fYL[T75c5?\=[)F[#XL&Q@=_]CE<NYE=T^.\
V1T<a\Fc&XAS<]-3D-HZM4?C<I,9#K]GX<P70Ib[Z)BTE:G4./DSUgOb\E>e4BL#
EcUHPa5[PFK\)NS3B(2JBWA4>958eIg1U8_Ja,T6J>?Z(eHCY9_aC?GN>Q=JAf(E
YeU4a\01RYIKI9OPAU47YE?_FN;SXW>NGg,)&NGNQ9+APU9@\39\Q3X_WBBA7cKL
:gDaV^;QR\bXaD(A[4FG3@&fE_4FG33SCQEXg,QZT78eaWR6YYRYaWg-4;3AP=L\
NVUK6C3V3=c/Jg(0/;UO)M1Y8EF&)[LR/R?1BW+cS3C7LF/W1(X-aT^@<]f60c)U
4=D6JL/Ug@=Zg3LWa.R)9#_.EM:a6VeJFdB3,4>:P?eQFb;+7:QgQGfWJY#Bbf^K
7P&gD;U1_K,B9&;=ECSaXU5g.OAa^EX33R:TEQf&:9?bFfR]?FK8>/<X6M;d&JGY
1J]\(BMF<X#Y4_KW3,\D<U]W-a\XeRcC?9WGH3+Z)Y2Q>fN12C(JKP)8<WcP\&8V
O26A1/ba9\C\GC0QgN/:+f/Bb.VWegFbP;[5&&9^TQVa[=;-G0#JYgcc7;ZbB2Lg
fUQaC_8g,N2HHI,=6QKD;=fP-(NdN8fc&SfFd@S@G];,^&.\A#LR:5G2#)2De4gT
B4ZfU]5UBQ&XEN#f6._VTYfC[\I2=V82(>+Y2EdbOGf>YX(X,40<[4L9ZOHYdV:T
dX5F@#S5Ac?;GB-Ae1JB8(:_XSWNP+<2bL]3T.7cFDf=fLO)6V4CN6F(=KeH61:N
R]]D</L45)<#L9<]=Hb_c+W6O@O7aD\ZVG9]L9g[1M5>B^)XA9=5)G#S/2SaHQ+P
,c?_8b\T#2:+UIK/Y48(9^SMR(I\F>AL3[YY3ccA<SSJ\0d:HGB\g5C^\]F:;UDQ
^,8\^fb<U_/b-e=QPbI5S1]UZ[DONPX@_E(,AO<7<#_,@0^>3YNV=:F(IVKdT<AZ
KPE>DS=I1,,DH7SSQRb)8X1]AcCVD3gM\f7eF_a?C->7D?/\d_:N=G]I-K\f)_gN
N\&8HDYR2#[Ka6.L0AM;PF:H3e@g-4TDZKO2GRLdZ>6E4^^V007aY4S1.&J?WCC;
c[K#T:2c+Fg>-#66Z<M>CP,@gM5C[U<-dKb;(MPLZC+;>01R[EH\1Vc<HY7,?(G/
YUTRE.PQPG:P^SJOZ#2[4NLC4\Q^MaHNK:&ZZBdM4050YWd7PF.1bSZ^Tg1ZKCb?
[7BZCee7JO=7&\MW4Uf:a86)][3[PNXE.=\?&A=B&cFbJ-1NFDf7D#SQ16B-0JK,
YXN+JO0g4>Hd(X]ETM]-S627bIL2f^L]++E,;TVCb@=GMAg)_E5T_=YLb>+(?3GS
]L_g[0-[5>d7&Zc1;FD/S;C8W]9\d)<K.aHee]f<-S;LPe6\Z?;/RgIX7_+=DDUQ
<RXVF-PRM^Ae@BG^gW8=e+;WEOT(g#TSCKTC@LdNTg+]RA2]A&WX4C\bG6R:P11H
EE:ff&FeYPEdT2ZYCA0<1AK].4JR?BHTW5EG,c37La&=-0DK0=?[ea:OP]BJaTUR
-.7]_31.QTEX:fV,?XE??<+3MWTJ0\T>f^]BXB>.-4>a^@U1>I_<=+6P6(J=83WJ
d&Gg@L-BN]E^8I5F5#/3PG;\b<IC^PcfWJ.I<?G^A?1&HWF0-Z/&E5HM@HG,H:Od
+C;E2[c&CWZA&]a<S8\,<UObK6G,B)60CIPe3NL66WO\DNg]UWb[4B;9f5d/W6c^
I_ZEUbW;&A^K7UOf43DOPeW:?:5VS:5JMVR5AYY^;5H,#K(3.[^>_SD[,2_/SQ7f
F2>b0,-TaMI@Q1_.IE9cLHbfTP5H4a:6eVM+QJP\:TG8+>W4fW@9J;[N?(XC4(QA
UVEf/S;TSC]/I5[H-IHd;Dab&:E6D9Sc[[66(V[-V&9,4:DIVJa08cEXfS=/.Z/P
DAb5Z-5AU&LV@c\c.\eJA@:X9\fJaPAV2^+8@=U/^<QcEHL4c=OLR7:S++7ZJP(Q
:_)fQFMJ;DJ;8R:MBgJ:#dH=dATAY=DW:<HAaM1Nd?\4QScJHc1.^8C\.#39]_6X
OA>YK-G8)4QdR+MDU@72F=gI,W,+JO;V5:QSC,^EBQHa_(-4;]?\@:DH>BHd\BH<
V]OL&Yf:TY3(aR.V]^N;C+1C8e+V2OWdIP\gGL3/-9_E(Ed4/=3VJP2HF<@U-,WP
-42V,c]0&gCJ;c#;M]Bb/?Pg#^(,9J88I+g/3(D_L_g9O0@2[-<DJL@HNU_2A_e(
J=\d\>(P#<GW/>;//AHY6DEGNeRB>=aZC-9LdD@EAK2<\4F).a:_(61aJ+8)[ELf
g_I.#,HKPYD>5\H)W77/&;8VPPIaVb]3Z/6UB9M:;?</MfGEE\:;\Dg>33\=cSH<
HH-E-)(V.+=V/X<N]]S1=G,GV7)Y3^Fa1,9#T3T6d/5P_,UB8S)EbD;g7S\Q@[[,
-Q_K7>\Pf0e0X:YSE^V:6+IEQ5-DFJTO/^5,bf;^(Z5WBgF.GF6STWX5D-?(P,K9
BP.E<I\K_\NL.8XA5(b7_?E3GeNF9R2aP0,LPedYWR=XgWQ;fXL9WIA;Z@_YG&2K
3cbPgI@SZ;ZYWg><\R3=a?M\Q:SN)_D\W3;9.T-H]c^4&eLeCeX:06b5eISYY##L
PA)1\RcI7HE?/aG\-+]&[;-).BDe,,3E55_K6TMA3AD=5G>MNZ]Pe(cA<c\L3B15
4&g,6YZ&Q+8LS<D4]-Y7HRdcG7RWZQ(NYO)Df&;\LD&W0b\X7XWASQJ0DXC#6X:W
Z=e4g?XfJb64cGggU33C\H6<4R,D)@1=XeY?&2Q^2U:]-PgV9\N\[EB+bL48B\gA
cN<<0@N&\1Q#E<_S^7IW5:^>?&AN8<XcG81O4aJ2]UHa3LW3U9aW_ZOdHKJJ\7Hg
GB[+-WD)H[cgbI\Vg^RG#;#d3<]R4H24+<B_1>YbD&)^e08^gG_eH]f[RZ@[PC+S
UX,B2Zd1)b1egSI4#J<H12ZfH&d-TX,8g/\9Z[M80,M4=VaAUa5JBTS07V9S-?F2
V(bZ?7][4UN6aJ.H(G6Q&M-c&,D1IY46]N6KYc3W@f86[JI)@>,5+M?@QCZb1J--
@\Mf]L(-9Yd[NE733MSIeCK:&3Yb_f:gWQS(8VMK-O0@8K6e=KKM;M3:>^F\];F-
IW/&[L5?T9RWP=116[#^4[E6MPM,Cc-6.6YAQJM>;&Ked-0FPH?N@2<J&ZcR&T?b
dWN)9,[>#(@F,./fXST,R[_)Re<S=R+K+J0+Z<I>0T(4Y2-&GQ)L\=fHIf8HG#)#
(826N@WK?0S3GU7XP<9PAAa6TM<,\Y^f:;)Z<fD\H_))JC0UG@\&@[(#7>3,gd()
+7=H@J]828#BFEB+-/fFO7.R,6N1O@K7aWdEOH>]L9_5daXQ,=:Z9]WeP0<QV/N&
L.f@Q,_(S?fM0DZ/W.2-1\V\X](4.I-=:7+\HW[0UP]HC.dT0:^4DA)62He>de83
HWSF)6a6-/FHE);U0S_YJAGZ/]O8.(c7-U0-@c?^aLC\S\MYf6M:Oc;:-]?549;H
,S(2T+;g3c]8#_)X\/-gT^H.Eb18V5DZSA<B,;95gS^JN3WP8e,YM(.05[+2+[e9
G.GP550Z657EH=,+MZXG9_N<A\-ebQJIdY?N45RKYCTABW&OKTD1XMS+FcEd@H=f
DH(&DgSCZVe0\K,5E>@N8L@BY_,NS#d5[V5L9:R:-71U3:,??B##9S-aPT:3SFN\
UgK+K0E)09.A:U0_JeRA)]]g5gY8Z73,BI<]HLDAAH3,<ISfb-31=7Aa1;eG/E(H
a5.ETJ5;4NHYWA3@QL=d.=e#T:?(:8BK=;V9(d<X-22:4A=12f^LBCW6GF7A4;II
N-55UEWD)?1PHQYCa<VLFMd<PECW<)eb++TAd_&JX>7J<T[QIgU9ANMUI)Z]:M>Y
OQ:8A;bP\-VMNX<+&_X.2D7Rb6IQB/+FDN:9VBP@:P.VW8T-b(-4.\B1dM#X(gI7
Nc<dXP(VJa24+Jde?-<E6ED60E)LX4W552g=4^f55S#2>/Ab46+2T/cP2YaPQ(1P
P@WIF51Y:G^AaOK?<^)W\]1J8Z6DeBf=J)F<^S;+OHJLecbaaJT:fT;gePZ7RO#F
W3HKR,I[PZc=Q[OG,+ZM>g\8,S?G?7@(+KLG3AA=Z0/\RcQ-LL6DTa24,S2B\ZFb
cZ66cfaBSIX2)[>9@?Q+M/(/;.L,FKY=g2E<JO-P3YFPQcC@RB#S-.L03H117)AN
cgcGOJ=VV3A1/9MA4_:@2R41NRKdVS#_R8RD54S33(HQ[g;+PMF=.^M8aK4QZU0]
FDdLKHS:cZN7#JfP3._L.#PK8&Ef)4c)fE<=)\@4O6TVM>R2(cU_&;3?)D0LO-A4
NELdHWJbQEFL5XE3Hb3eX+A6?dL4Q;3PNJ<[b3NPb9b+d7PGOG89af/N2(-fLJ78
AD;FA\]e:P@BT7O.MfJ:7;X^(K_89O+\Z?@I:S+>IgYCP<9[c6=X<7LC0Ib]d.]L
#5ZFYP?-0@9^TegDf^Z\TMCc39^<[d:5,<Ib</+/D@174Z&D-,Z6RTXR=W6+f?L5
>AX+g/,1_H/bLNIF(=FYZ^b-f]9A3KKZ+dXQ)56<-P+F/fY:2-F4375Q0ESUHBF^
W[#6<):7LaR#F>\U_,^IHc-fSCg/S+AC,-HYN&cFWX.YF1W?Rbf@I;/>LPNbT;Z4
(XS;3O@#94=7WVP#1]Ug5V+Ra<9H/08X+YN;MM_1T.KCZ@JL.A+g=,MA+8FIZG3\
_TG5VgB.\ZIP]dQ[CR\>ZR&P6MG]bS<XV/_S4QCT(9V6<BY_U,4bNO5D7MZf_DQ6
6&c(gH=CJ9d+EMW5ZZ+^X4OT[B6(24MVS?d/K@GcDK\b2K7S1>A_<Z1^>:__fFON
_e>=a6&ecK_JY094+D)\,OV<JRP(R-W.6+G;:BS+?cXK&>CJB//-5;2CM^cDF\bX
H//H=C3A&E+I)\LM]/S5(.a>U,IUS3-9^D-D6]d_E5AHBK(HG]KcCP_ANC:_fJ:)
6E13N#Rg-GdF]7(@<\Fb2=0[/+Y.SE7Mc&;\.3YJQG[VVQ)4@P[/>O[+g3C^=c&U
71=,G[LB.gQH1WC,MQ^<XVA>G\?D?1,UAbaYDfSQQUa3]6G3,>W<\U+RHcO(E.]C
UF,#6)B-+I1Sd,6)7_UWFOe(QWEDNa1Z_NVS^K8Q=AH8f;>63KL_U<>OeFM9UA1F
M_F;b(/gR-/Y[]&X4Ne)9IA3]Bc_60<dTXSNQN1/M^P#;R7bW4VcIB(RQ3SPeXRQ
06c>1N@]\gB]f4a^>;-K)c_=)OA;g;JQb1>Cgb;Z+7-VX3SQCOKc=c1-DA8V\EcH
GBAA/3Pf(?D.EC]A9Q)e)>&EP<.E7c366RBAJ-:OY\<X;<T0Q7VB4:Ka=;,c_1)9
[Q=U4-LW6O#I)F2HR=A_bN<2LO=Vb7S1FS7;Ad^0BCALCTU?\Q:VeOC1[eb+5YDK
^D_#:WfL/+GWQCdYQTWS4IW;67Hf5g\2AgXPU8X]PfP7=^\8+F5AR5HEYUcMPcTB
_TL(245^71YMOQQRdHdg)K/LM&@]E.++5Q9eP2)NcU#)FX:&@3=,abC,f&7a[@\g
7=\GDP\9RT5K=[N/N/f6d7g@<BOHgBU4SNa<G>F[:V7.[08.Vf5A3Za;&<^XP45T
F/F8F5G@LVI2>GdfFY#_>1IR^T#>,C>dE.ITU>KZ92<X.@4f&5Q<XO3T-N7JWN]=
Q^agX_A,=597MDR=P99H.<<K06APK;E\@IRB4a8.a9:RI2+e)HM)/c?a/^a7_dc#
)bBPZ5cI#?70D:?22=/e=BVDI,]Z>bfCP.JLQUF?SM6-@W)]:?KQIS@]+8672FgH
&eQ_d0_I/(RfZ@3/=/X#c[[/P\?cD<FZDeB)KR7\V/]7U9;\&UB(FLZE,3?=SEDf
>M>XH(AB&.QCT#O#Z,SAIVXL[)(BMT,;c1AXUGg(8##\UVYNa62&//QLg;d@HSF\
dXH0e=IP/dBaO#^O-g]79[XN:3BMfCKK3669XM5064,0->UNYIAGX:#QbdVNKA,c
J@BSa#Z4O(07ISaM]^HP,88_^I^LS)GL<Q)#ULQQ#P3b^QbX/SE3SPZbeDV/NA;2
9\W+&MNG>1D:#7;FQ:Tb;2Y#6IBQU/CIT_FP-,/K(,@58S/>>.f1E)<3IZbge7[O
_-Bc.W\=KCa/E4\.;Bb?U5:)C0_CNL7^SHL>e9:R?BIa[^/<G?W&cUV7Z=K7\MKF
T2A6@^dCWgBGQCI#AA32HQ,\0fF>L8FLcR03b6)7GB87#C9X[A1K_;X48PQRe3(R
E7A]QIJH7E@.@138A+c#,;[<OM+CGL/G><e1L3Z#de8dDS&Ld2Q,>b;aQ.P3b=G#
T6eJXP\MJ]6AN3V\b;52GARbAf06+E3U.a1;M^\.H@&4L-);NUXT]Wb.eA&R^JA,
FB4)I3#_].fWW7W<aB3IfSc\e]\Na<dR=JMT]1.EK#K80=\dX>)&b,c(?V-Ccg.C
9/X<G3OU.3WCdG,3VH#g1_TeP?1O-5Q2GFN=MdN\BQR\L4W/?WVe@W)0DT.UXbgO
/>)-(76ea6]:T@;560E&JM##M>?R41fH2eFC)&?>f]9.1JYSGScg2f>OJM@&QDb?
/J@9]Q]NIVKQG)9gMfb>>]EYc2_Ef0+0I>Wg-3?O,CO57(0&K,?@9\FZW8([&b(3
&1-S:HHA8.a)PZeAAN),E<C/V]1#ZI3G>W\\Q2&.5;:;gX<1Y4.>4GNA->U2Ac1&
KH3O,3N8V-[9,7Eb2_NFU1.Qf+_e[Xg_/C.d.WTWd\R4_WF3T+8Z;IdOT14TF/)R
S+=8f:\a[Ye5F]IN;_UeAESLg5CRaLb6[Q-=A:e6^JLd.UBOb)8M&FG88R:>T=/G
PE4ScO9^K,W5CF+9VB)D9>J\]>=N9W9Jd:I583R>PZc(YHadF/3,W3S81S#<=H5C
H4A.RM5@P-?4cH3:0;>HR42R_BZ^I?<WF/-_[B+7EeP,Q]dY&PWKIPD+YU=9?9IS
eCR[dEM-\7Ma8<-gYZE5=_bF+&fU#IW)]0FG]OOKFU1)@O1NL:V.QS^O\CVSBK/g
NT#:&<gQ3^@FN=_19,dN_.A9a:H7AD\=-HZWCB:U/1SC:6Z>KFO#>JD:&-W@#9I1
_I=+CB3bS@R=KbUS2S)X,2V(WRgMI[;@IEcb<5=bWME_KYRRD\:0U&H4TRYUcNT]
?]>4W:F775DYYK<P<gG#55QMJ:\@/6T^G44cae//&EJ):<D?I[Ag8Q>N(UI@L_4=
6(<]S7A@4G=_88FJY7T<10TT+9-C43,GJb0&9/A_gGd?bB#3>=>D]86]JW0KFeEH
dG\/#BeH;8+RBOA+=CDQ(LV2_W(\/WG3ZYa8ZJ]dc^fa#-_:+EO)BLK]Q>g,d<<#
G6AW[0a8Gg]Rf)GPJQQG@dZHbI]a1;HTI[IB3M)Z^Kd>6I1P2L:\#cO0e-.3QFIf
@.^O[Ya2IBN(359?>=a9SEId(R3GC<6+>aT_dZ1\_<9+EZ)1HD5_MY.0-e-092VU
IZP5\J.[1FPeLL8=V0GW6L,B#=V_:\SW\(f(_f)eX=/83fSbG5cc<HRI8.KL,8]]
AT6,aC6Y@IRg(XCS\a,Z3aV7][gFQg?NI=AE6J:LH.\3a&11_#+X/.4&>Cd,.,#-
6[)aG,IIB;P\Y>Z8SF5bHZG_72QP<K48G)5Vf]3BBgLO<(0=K@928VNJG1IYY#LR
6=?-C,Ng[Xg0a=JV]P1aJcSQNHYLKg0#UN0BP=<b7bUea64,0Ea2+PfTJgc[b2gY
K4/J07&FYCAOab]EXJL#(L=@gWM&cc7P<>0_0):e@(4+3LYZGY,4HfHCbfN.,[^S
=S[GW-agS=TS>AR\:KeKA696F5.Z)1^[4ROJ(D/X)_>aXM6[TZ9P1JTX,,83ZQ];
3:IFERHfP;AI3/f/<M392GIMCU@1,^0M-[:@/B1OZ^QD+I=Aa@,KL:&4:(==Ag5I
L-g@_W=B=22L4efLN2?\.3=5O]gaE2\dMX8B7[M\]MS/2FU)US[#V[@#GYA;LKcI
Zd+#Z/:O8#\3/Z_TJ.H)_GUPZC>H?CH-LO?[GcQB\13If8M;XUC:MP&OL4IVBUQ9
@]]KHBbFEW(D5YX54Og,S/]F>VZJ&MeP//agLe+cRQ/>(L\OK8I-QUQBI<fCD#_J
1=QWXJ6/4ZM67[0_2KP60SM2EK-CFX0^dT5XR4P?@/K?2BCK#O@.GY.Xc.cc[:Zf
#(L5ZK8TUT6=9NUJ2I.C(-Oc-2O45HA^\DBS:4?f(N>W_FN:ZbK1d<6FH.UJMNHQ
2=3H\T;3^^:H/^WH=744XMOc8$
`endprotected

`protected
b(=H<@+e+.HZ-e+aF0;e+M4DC5N?O#VZc?79X_TQ5^&7D>K/BTV4()1AO88Te4[_
fYeBL;>EG>_:AK=FN>0;[d4D3$
`endprotected

//vcs_lic_vip_protect
  `protected
<>gD+497PL_C_,..<Td/GV^g;IC23#Y;\7&K(d6>J[@X06cfC00H-(SIUb?D])-:
P?f9f/f4IKF7/5/AMI-QcZTW>9d.7H.IDgZL?WK?gN]2M&^]7FHZ5;((Be/OcDKg
Lb^U28E/#59JILMBd?UOMTC0&>HO1be@7#&RO8IT?U8g8AdbK<I5\>#>/e].?]b^
dP9LbJ4\b31AICU@\),[P8^D=P_3B[.JUQA(+>6^g<fgKd/J>L9_D#I>SWIHf8[a
SKdPLT9^X88SSNNe@\7(Za&U[IN=f?eWV2TZfZf#D)PI]T+C&-Qf>C+8R@,7&=0V
1:Ib#BY1OG(=#S1@X07:D3MQ3c08),&CY>71Z^,eA5.QWKFb5#3@-CSB.&N(A=[A
>HIN^RE.D?J[JR]ML>D(.>;g(b.SP=](Pa,bQY\OSAc.+_cBX4HJKH/Sfge2)^8e
c2F=)J)P:Rg.>3\4B[bC2(B<0#ETIM(&9-Y/#M2(U4+F)4&+;1XQd+O^[6H,KNT>
OP7b2;IO.>6+3IJ2LDg[&P4Pe]3gKcHd8Xda,c/QKF@KgJH[X^K+?\,0_5R>LX@7
c#OS4eWdN8IeLSX:XHJHN<<W3M[SS1?#]&XJNVUGeBY&T;_BV+J-J-??FZ[,M]Lc
\?KS8^fN+Q2aLRQ@S\<9T1GCM?M(,JMbG1C&36#OU5]RL_d[VE(=U#RM-Y@f4OaE
cBQ2aYL4DX^ARcZ-TOG>2fRWW0W#EYDb:-a?6YZ3ULR;R+c9.;O5DdH3T9CL:LgE
2JFOG[AG>/8I]V##)MdF:[ZMI6Y(9TAX87N694:)N+[4Bd#A-c><1=&:8G66^_>>
7<KbG2Jc8#J1MF?QQF;EEPESE1;T#[Z3cGgHHXaKgf:>8a/(VeZ&DBBALd[23]H(
<gI].2G,4,=g[_YO3.K(3S8ObET]_2ZPT^1#XA1MMQUOe_aG9X9DWAE#IB>f+);,
6W[UCECdKLZO16_SPQ,51I42>^N+g/MMT/E09d-MMPUX/=/=4Mg4#5PE\f0-gU6Z
C#76S_[0(6,#/Y+N5(I]CDAMC668X:&X,Q@0A/HK401f&aKN:WY<1#T,E=W)@Q_W
?Le6g69\)ZI]eb\L0Oa)7P[:QQ=TF8+V>@JA8_WJ<&0EXTOSeCYJ]D\>],b2L0fR
DHQLM?VTEUJ7+8f8/#>_eHL[(:C@XH_(,KY?4?4ZOSMU6V=4GCgLS:d/aJe#\LVG
UbLaCUD4H<0N\-:#d,]XfNa=?&>O<Q8HE+W/fNg=2XcebSQ#([8Ua2;INMIUJ@MX
MF?R/<N205^cY2R56YW.W[^7[XX)^STNe,X7.4AUNOFd]gQ&=/RR5T>5+&OXPVC8
X2EW)2VI-RDTXc)-[&VfJgM]B9#-BY;.W.?BDgG&8JC)DOB8>RU@N](?7?(bXX3b
9&.bOa(<XGTB/1gM>;KgJ5I(g1F82U2DPG_JJZQcCd/(#8PF.[]-deG6V^U-]QON
Y?17IOa45fO;>;.<21g].He9#e=MR.g7gW)ML@2H#PSIa/4;F<A86Q./C,&E1TcN
?Hd;J&d/L515W?Mg?T6fg7:_[c0M3&)/Xa/=AZe:Q,f@>5^3T[@ef3O.(acCJET;
^Q798f8H9eER#EWg[T_fY516]8(2HQRSR=TXPX]P^:B4e.M\I#2+g&.O8MN3#Ib>
\WK=;eN-4S-@@>>E-Jd8Z6Z3^;bPM-AD[S_VdAI\[5b)1XP/4TVJ>]_bB&N\-ODe
7CWVXKf2>Td.96eKKHH/?;/FXRO)WY4+\b.deU.>/aI8S)E].8]YLMJ&0JF_&@;g
YNgVSM[8N9T93g-)eZBHbVJ\1d2T/0fX;?d1c9,5g4B,R.CQ(dO.5Z-:>ZL]YGFK
Xa6AEZMQA@W)RcKCMDQ<=;4g&MJ,e9R(#Z<#6KbUUF-2d<=E/M5Y]8XZO9cCOZeC
f>+W\5G[IUWQ^Q=MTBAIK>d+#XbI.LJP@71\\#IVfAdXfVR9B1A)&aGN4G:9VP3^
TKCR9Z5@<OJL17[JGB.0OS&fP?I0AcB]CM1Ddd>,9QMO&,NX\,12c_XA^f412d(E
4_#VPC@ZS,[@YP]&f+K7A84[3OFeW6NAH@P/\9@IMbTW,3LY1^S1@g9Q<<+\GNE/
Ea[(f@4I^6+cNKAFQJHbEDM,^>\Tg6SYeFQ/@^@.M\bX]FO+2W^Q+d)1a\,1..]]
X).\gDY)MX.2(1O[b;5TFB6]X)SZ0ZYaZSa?eSI&.KD;/I><#])Qf_5S[C;=VK;I
0Z/()@MO;afaW4[/9gA/8<df^3a,AJOR;1KVIK,_Sa5MI>fYPfXN<A&.\D_5@2B9
^><.1IK3:>LCHU(_W>_A.eb\/faMX.W87J-QJae2?3;4:1U(@;JgK?39)g\8K&g1
;-T[/RJ89Z7O+@/AGeAUa/bZ64\M+1B#HA18S;_).TNVMOC0Ag[K@HA^fI;b4ZIc
J5PL?7gZEC9KH9JY>Jc=R3XD2MWY9-H^SJ.FII)dE\]XB)M(XGa[/+/7(cJ0HbE(
=Uf>#(@E841Qd?=3#W3QAL(9[2R;:E2EF<SU44a-=2D=JKZAK&^eXQ#N@18DHdac
L2GU==/53-9)06DR:bU^#;G])+C-_SUf(Z_6+6XNT=T5-_L+MI4R\K[ILga_Rd;A
gUIJ/EO#R_RKVId1_.D;CS@W.b)4<&;\3N&Ic<OYMaB6f0M,?,-8N1.-f5@CHO4F
&E5P<REfJDRCP.-3>#FW:D^_a1P>6=[SICAb\a(?fF9G>/.AXF<cYGPMf#.Q_aY^
c3(9?g0bBRZ@U2VIgC^O(e6D.4ESea55<9N5,:=+XUBJYJGL[)SR,0e[YL:KbJ/e
B&&bW-JYf5,]TOU&R2M@cWO#CC.,eF:#_W5dWD\9d5F;d.+5W_=V&=1[&6<;TY&T
,[4L8H]db]K1XQ.P/&^O#W[Y3/;+5+gQIg<B@=XJU7T[IM/cGZ\W(a+WSD8(G(_:
IIO.8Z4cEV(db\CH@T978<:g7dT.gN2bCd5g?JZ,M7[V,-7\?_bUe_1XLQ)/e(U0
J_bb>c5bKea5[RAed)-WNc#TT4FRO]FP-e;::b57S-Y9-_NOY1,?WKcSKY:(8MSI
G;_B1OAZU)XaEJME^8e16gSED5\#5_+VLe)ZC7Ld#VVT1,=dQg&TE\g8<+e/0@e-
=WD1>GI=S^a.4?ORL#d;3)-CX1Vb(#,eeB5O<WFKV?QIa\Cd+1XF4-:+d;\LCSK/
(Y8YIIS3FXJ^bUC:BKgDL[S96JJ+^44:N,0:P0\,SQ]AQcc+N+RTDN5dG+0b8JN&
H3ef&/1+07@eTH70]b.H+L\BPY7Q1>2C>eXG3+4T9@4B.R,(GL8J&f)4R/[EA0aS
.S+T\OBbCa/d]K4SKGGa-8UC9:=aY9M6(2aL/ecb#2WC);8g.(&<UE?(b]1.#XI)
/e^;036S\].2(EJ).I98^IfX^V^,d?LUM0:R-=KPCV9]g+[D;AMJ(F32eU)GC6d8
<Z3;V[D?dD=R[0RO,?:P/DVd@&A<A.5C=e9];J.@9#VRc-.Qc0CVgB@+=2eef4DD
#C&@KgP.WU:b_Ee..Hd^UR[<dKMcFJ8J+CPX5X3f6C_S&\5/Hg?&0&XM][X_Fd:g
,AW8HSEfc.aE9=M,S,eTMY6;SOH/1]NM9+<:[I<O>&R1g]RCZ<TI>08dBETU0D?+
UgVJ&643A2f(:3/;J_<cXe@Y:Q]Z8VSP\<2S=51WVY8MX)YLf\?AM.[PLee[HVVb
_e5,fV,4=Bf.F\2U\,=8b4+?G2(9]E)]Ic[S8[N5W3Q5F]]@(@UUPZee;d<_^S@0
56Z3JBfI31X]:),BP+X(>ZJY\O@H#H&.a#C43>X+Z()J+9b88N0/8U^NXUPSf_::
RGFD#OJXY@\&-Mf@<RdM&b^YbcZ=W_Re?AdG;b/SA>?^2G+DH/=A3A=X/(40WUd>
W1/Q:#;Gg/>(#eB]YTKJgaWcc3f>PD@(ZY[]D6C8_P&>Z[(^@bRW]_Ig\CY@]aY#
1FDPDI?>bXY_Re,GFcU)(b]G\KI+?)(8/&e]<-fMUWJ5;3M(90=gWa3dG.YCdPa]
XV#P7)^OYFQ4W<L_ZH66L)Y3a>Z8SB?^:\1/P2Vc[1I&d=.?8Kf0.3d_YI,1Rc_-
(,HDS2SDeBZag&Q-G9CVC:6(^Yg=^KTP2CXL8fLFJQN)HW9#B;a5)T?<]a?fKV.\
3ALP1HS[:4CdWSU=Dg@EI&;&4QU(/@Z;(<][]?7ZZ1?A:egG:;<A<1]0<AZ?8ZXV
P(KA_OCJ=#N?>EX=a8+-([2D?:9L0H-EI]9eX_dWVFBaC3f3[=O,7;[+PN/.cB#H
YVU8(=G/6BP)W:Iac&8cB--GE.DM;R2c.<IQK82O,I25MUgg-,d4..,(c2R&eYN-
6D8Z>?9dF+JM12FW7?2I:;DBRcZbZ2#BH?&5+-.cH9?;_?/)7;_cfJN=\1cD6N69
-dU3@3;2Rec;&L[S+VW17TEFMMYHG86)Ya\b6K05;QX[9<NJSf:78Ga9I^>=29Y=
D6+S[:HW2EE_BCM&#(@TQ[T=6;^8O,/ZZ=AP)YW.>:W\G5QbP&GW\V)2b^0QC<M:
<F9eU2)BZ6MJ&>HPc0RP^/T#Q=EgJ6H+6+D::?XL[:2EORC1,Y:O^(7.8L8#J&S#
K7AKN72PPE(ELMe2=+dJNL0JTRIZEcHVbU6J:8+FR(^d<(K5.IR&RA\)--JMF.,/
E^M\9@_#2c9UWF2Z:36PGF12A&^V]:&FT)>cRSfSWD0d+?W\\T/]HEN,#EYe6O<U
7-eBOH19e&R#718OW-J@ffS(>PSDIfMf;0bI&S3c2V2I/fRdRHbfg^(R(2Y]/>ZZ
EQY\BKg()0^DA]4O]+/___#ED3BT/.[4#,D\(?]dZ>WBKSW5V7cF&9=Sd7Q#0EQU
,LA>U&QcZ&gZ<;41J1NZ\UZ<bbP)YgdcJSa]RZG/+_N<LGYL_J:(6,ITWJa@D&dU
/Ye4a9YSI=#5?8-aL(<0:PNaQ:8DF8;&WTP92Cg(IC>I=<3e@,c03bPE^L#RdB9&
\T@4V5SUB#ZMbK\TT9-Lc?E2D]U;5H6gY#4e2#\Yc;TH/_-40:QW=(<-42[B&+]#
DE+:T/=08B.g.4d4;adU:\cPD(8[5PZ:Ba1(2BW+E7:GcGEbY5Y_^&P?CEF5]2Y8
8-f),3G71a4HN&^CFO_cEAJKXP#/YM6WC0#F1?TgW^=+Sb-EeB:Df^5?+T[b.XGO
K?,@ed]1+Wd\(@/-e_g6S0:dXH5@e;2])EMb?A&?]:&5N)5B@g7;0>=X6F.6Z^=Y
-[RB<]J1TYFU/J[a:@CMYAER8W(N1)Tg^:eR^CCN.GXGYg2/Z2_SB1N[^a:M6)29
(Ya8(/b=ZH9[SF9SNgKTR71;:[Va(Jfc9,(1I@TZG+DH5,,b+6YV,Yd.<G8XVN(C
<R4d<ZM@);AEZI=&UOTMP)fbF,D?>:5+V4B0,MB?8<CG2X3MS0XM#H0KF0&348X0
R7VK:gNU>B6IOGaP^;[_gb>?I/8JaFY4G\FQK_aB.DHVG2DAKbc/VJ+<G/d@(Ig[
QcYZ9S-U/P6C]@L3?M48@4DM)(#]XA[GB\RJeHVQ1<GD<=Z[P#7R\E)D3:Af@@]O
RaVBeg8N9>JgTddT6aO>W;dSgW^UW\CM@^?0(2g?F&MH/Z+DfPW960d3N.A2N&&N
E9O(@_2c]<]HBIa9<(A:)WY?48[4LARZdN]\3HV;;7L?gJXZ=\0MaMTDR]^fE[V\
A#G+QMI5AC9QQH6J\:BQbL7J+24_Q3gOaH8D/&>1>]P9f>#W:YE]Z:K8;+/A8Y4P
U1+c(KME48eG\]0]=Z>-0LOQ18N7VIF=G?[7-0HK+C4:0[d@_Ag5dd-gA1;BW[S2
LE.a2<EQOJ6LK_JLH4a]MUGJ8KHHCJ<U;Me@6R&L96A:PHbD0dY^8Yf#G-P0U_#S
Fg,@LID^TK@BY&Pc((JP_5SR)CHKg&QRBHZ@H(F,/KIV6GJ<LP,cH.4.b[/gg98R
JM-?,8[^b>.;Q-A+)TPE5RbWYC1:N[ZgZdLI6<?&E<c)_KR_25UOHD.-g83gR;IH
)U[Jb3-Hb>0L#790?VgMfE(e4YJ],PHZP,UB/HO(c^:\HUY@Q5L/e0^PQIgd(Q:-
3ZWb(/IP]H1>R[A(MRZMY1ZR.Y0VWN+K/(XcA-F0NWBW9IH5<d2HW@D6Z?@[]FE5
g9T#_;0&@;&.N;2MJ08EcIYbVVO\Lg9JW./[8VF7\\_:B0NM?;0TA:J(11bZVCV<
_R1\9G9/EQI_4?<OZ>Lg9Dc(^EPEYEXPMg/ERAM\d4&5BDgGagY&M4[TOF>f8;FX
&KgYcYUD]Q4L+eE&4\HgbT0#d6YS>1OJXU2-JBO+X=a&2^TdXDPUXZNY:.Zf:?fC
(YXG@g=<2Z70P/gC\cUOAbIeJ=3;2)_55\AD464PTNKWa;8>L(YH/X7<6_OGdO,=
-G0.O,9^F2e2PAC2X8S8Y.C.PU)NCeV5fS]-3)<=+>OAKWWQV.G.PTdab5gL1be9
;+9PU2Fg>N?Z\.[GQT^S^Gf9Wg4MLPeOZ#T.CS2b9g)2C6AH[:#]J,3X>dE0c4OZ
_)+-C9)Z?-O?+4-@FX#^?c=bUJ61Bb+P;)0/c@9FdQ0WE1da11V-0:8IOYb<T1M@
bW@WH/JF+H4&#c1EITC[;a/@6V296X;\S9WRS\]<;J+)&aS-eX2Nb9+HV7L4&I+2
^JU(f)NN5?,K0D3U@LTa(89e8ObWff;ZQbb@;F/G@A=-KSaBd\5,E6AHIDLD^73L
=F\G(,@MDH;U-f8Y6f(F702RR]E+1NFY\QcSE5bUHME:BOg2UY>:4YROe<Xd6/C.
C=e=0D>-]L?SY0ZSebgVVc>LX;,>3B[F65?C-47^[b_g\:LEP]/c+^N)39:UZQ6W
>V8]#b-X14[7(F^B<c3:X+Q=U,8P176P#=PNe/KY<D;8@R?Nc/8Q,1)Ia#a+5M+)
P;-dOgR8_Rg0X@LfBB.B1?V;fTFP5:S\J)aE\(;NJ#Ndd5\M6OQXQ:L2W52^2dBI
1.@DH+3]aaLTO5VCJ6#&6/4CI8.9)R(J#.YMA98J?8O,RH::<:N<dL3O^IH.PHI?
[(BHG0[5]37K6KT=;)NPTd-?N4<8XE^_;IR.LfL[(L:RV0F2_K86X.8_C:[IWGD>
[fYOGBT13Y1W[gNKPFK]52g,+J:-&&K)W3A(Z99FE1KXC+584La@cHX8&JHLf7[G
CbC:3U_QR#HR;=YCA[6&9S8=PDS95@G?FG=cBg;[YMZfJe9JgbQ_R2\3]PWH@gHa
Z-Q>e0@DNE?Z+]A<-]eeUOUD\=8O(_^N^-HV]@XE3#=8V\)3EO+2IQa9)dF@8_YF
UP<VaA9ZK-L;2]=5La>^]\5[9?F/(.;=>\;ATM78<3K9cfZ?#aY^MfJ3GN_eCAL8
Y8R19ZQ<OHgC)Vb\?K5&_IH@3PSAM>Qf-YGL+;W-AY_N84e(Xe=G0M(VK\@QVf&G
S+8Q)-aU)3N#V#>He0c9^gB7B/70>/KbeD1fP?Bb6#1<&5TA;]_A(_RaB(NF7F8H
,Y(1G5D-eZ;f#.)-bP=@F6g?0[:1Fd+<W;A&/0/W=gDf3;NS3VX]P.01LB]LUe;3
.gH.<NB5K:E8A&Z/61R_H4<N=O?@?1+;\R0+>:8S_5bf54CO)[2QJ>V;3JC5(RRQ
b4WR^QM+/2X;B,WI2b]a=JGQNPTEVZ&eFaN<KWLZX>fS/L4,CC;L+,6;DHWBWFXd
?,#&E?XQ6O^R7Y20GC.bX4Q-X#E&6>KELQC8;N/c>3;1JZDJ+XAUSK6.GKYO9SB9
Q=K]TO<3Q?EQ3:?0)b>]PK+#,:&PS5,PJ[NIe=0DQ(7/FKAR-AE,N<Bf<FY(S(+C
;e@cK=A&g_S:gBWN6L5bGbb/DV+?FAZ,ZM>JAeF(U[a,3^Q.K((>QL#^fQ#CJ4H4
(T5RORT1CM.9F+C&U,_FWd?M?6&&4W7N)5\T(BA01X.IgQ0G.\O:CgT;4b0<_PPg
XWA(2AG?6H-4WOPGINQ@277ECI0_]A=N/4Q8+YL]W,cWeB#ZJ4/G23IWH&59O0,[
/,[<@LGfGKIYA6Y\[g7AN<[SJZXOJZ7F4\8K#4CG5_b,cUJ;N<b9T?NaBRbPA0+J
7\8:-QNB&1<M]XGeDGcM/5E946-Ac0<O[.LL7,+6YKfe/ICTKVF[(TR]L:?g>NEU
Of0IJV;eGS\,U,_OgJ;FVSY=VE\C4A4[fg?8[PLYA@W@MG:d\CN,^ca?BH^AV,YP
P9f<6(2/4#F(/N,J>c;7_g5,T-@/WGUSIBVR3gKXI@f(Ie=<1f_YU+U9MBeQ:PUG
/<U\Z7>Y09ZdP1@^P,U3L^;7E\1&U/)V/(C-E^:-_2\7I6&3BeZ8=P+-;4TKNZVQ
R\5.48RAJY=\;00bLA/YFVKN@]&:Z&1bBATT&ISQ)A0PR3@KG>>DL_:[1)Ea^R>c
]_-MC/UX4:ZD,)C2Hbe4ZX>8QJaY</&QH(RMVK<eaXA([;?K9KH1XKY3e.C6BX#L
\fP59#W8=C1VaT.2OefYHKXO<f_4PNS4ddc8\C@K^aBA#:NTF+<FUT3Sb/G)b^-3
2P0BMIa+VNb&8;]Z42C2^XIfPXd9Sf]EfPBXVYU#gCS82(5:_=_5G)b0a+&X:)dZ
QeB,&W_M?@YY_92MFG3[SB4>9T(DB3Z=KZI7Wb#HYd7O0_AL7FA)aEJRd?b)E8S9
[e0JbFV8RIH70Q:5AafJG<ME;XgU9W:G.&XBJ0(J7G=Y8,J1UO.^(-6+IZ:TdU2a
EP)=0Y1gX\85S+_A^_[E,</W1U:8Eg99b/4OQe,d7<I)I&a13>MKf\Q7VM;eN\I^
GTNN36I#K:Gg>2cG8D#IEL>U&<;=&.-I_A9SP/H97\OE(W[&fA2+,1T]A)?3g[=c
=<O/,19@^2P>MEb::QEb(L/P[f5HS54TT(SM<@D+TG<V_9&SJLX?NF;=B+;)QZHV
b\;fJ(Y-UX8YfeS5=ZDAX0+J_5L8Y\_E]\0Q&Q\Z,DdTS0QF(IVM7;D-7LMFa8K^
1TRcIL@:3?OZ:=)1Wb&0d38;8aS4DJB+7c9:?W,5Af[I,1ZE;J<Z-=)eZN2SS=Kd
3F=1eXFc^+>4\ONL-d)e8ZR8_/^ZJ_W1bRaVDN=[Zc(8RCEgdVFCCF//_\5X[C8F
-,;4[1<U;Fe[LVR-W3P\2ZQC@WOBZG-M+?1GKTED1LLQ<M6BW-0/UcH8&(eQTSIb
,)6QdRWDLQ]97+5B9.)>bVA])ETb\JO+:9^O<4LMB2O>&@#WF;<PLS+>SBXc-98;
(eKD&f^Y=8X1:aL+N_JX-Kf3?;UX75YaPNAW?W\Y9e2Xc)Q/e0b<,e&WZ,)8(bE8
3E]-S)OcM6]B;@E1[I^1;WKN24c(^OX_77b>X.]gS8C3G&3-2&e_@P+F470Xb;&a
/0O(DFD;8OS,a;b]I3/_B^f,Q:PF3QK5E8C-HdAJa0NEUc.bYfT6<K#8c;g,RH[4
,LE)RUVW)J9T^ZfIF6V26g9^:9&e6(XI)VbVC-P_,d_>;;FBW9U_+FN^/]I.ba?5
&1FH^45Sf(+<>ZcC?6E)3]d>^KXNe5E^;JS@@ZZU>]^L/MW:>2c;1TfS4Q8.,.4T
>G8;X4C^3^:I)YIK1QN41@JZQ2ReDE^<4SK>)78P9L.WX+.H],,Y?0L<,DSU@ZVb
dac)8B@8Zaa99G-]6Tf;)Y3P2=3>R^MZG(3RS)_J@L=,<-XSLZI+&;1E.^Sb#Z:-
9a/70:&F&+YeB.ROeEX\+UE\<c(Y#RLc]4=153L)8R54gA>7d[K68=Nae<Z@IdXM
G\?aWH0UW047N+=MZSS?AAD:V#H-7;7H/;70_d:RZKI=3#^8-2K]/b609T8.<ONT
YD9)6QACH19A.Qc22<a4N<]NK6N\(.])(^b_J]1_-JT&N,<EUc[0()X?_K9La6ce
\-2e3.:3E8\1IfQ,>5e:.F0/BDN#G:e:0c6R&6K\0(TbeB_VZDJVMLS+cZQ#J^A2
>77=a@?gD5AHT=V/;Z^4-M&N;\RdGbOJ-1(A_\:R:cJPP&C_RML<1=PD-B@T4e9V
3+?=H5JM))e2VdHQc-K5Pc+78?.U<a/>]T[EQ4K3PVD@cIK^&I2C1-W]0RZ<UDGf
&.@+WaJ<(Ee+\K#M>F12[QU6a-)GI8Z,7E(N<gbD_N/3,\e3a<dE<LB@\AZN4eRf
94,S/2A=P.=cYc.N>cGCaO7VFICe1a@-dS@ZQ3O?2@AWA6S_9#)/@\@IW#e>-4>L
,=#U8ef/:Z_a(I?]2-0TPB?fa9MWY=LeNQUJf8>>;Q5MC8=(OIKeUTTRC=C2U4.a
F?3J4CNV=7O7E\1RW1=g8BI4?)PJP()gZ_Y2MG2cS5M^61=91)>8[<]?Nf(:SS/D
d#fVC2EY44P&MccaNIFE61TX2.A9XR\C68Qb04R@]@DE:a+U)EPWH?KH>5)UT^[f
;W<bU1J4HRgNNNaW^MfXU91PJ26E,8>433,H5c2UG<9>[_.W7_P5J+BQD[@=1(15
2:R,3(OT-.8H3VMJN>:bTeK=X-2WS34[]T>0WJ,:I@H?D8g#.OUP8MX?:f2+B4]R
cb^a12AK1dK?#6UAWL_JK6cMe,O7CG7,We=E2:^;^/..V,/[/MKU5)H7VSda8B7Z
E21/f6@H>_@8]YR[#<DKeU5A@Rc>E2/L=)+74AcGQ+)-AHC<gVfg>G^0[5+FK_29
@TAPYD5;F5EC<KGe[C.b:Z]K1LS3Ye17f7\(SP^LP(?<0=\OFO-M/a0EeY<0B=((
e,F56^=\978=^0Ub&_+RGRBDW]YeR\ca3S56g<QQX1IU4CdU.8JQ:f5X9O8.OEFP
>,X=[f5/R#.H)G>bJPXYYYR62B_FZ8ZM>2NVH,HMMXQg03A>+c6Q5)+QT3W1.NLR
5-O<=@Kb693cSI8(EMS:FR](@^T?TK/;ZMJgfQ,(K_4,?F1A5J?E/99DM@ega,):
8;g,<Q5D8&4c]6\DC0)=6WSbR4M3CE9VF&Y@cKSA5.LdB]e/L2QD>Y,=_^<4g/&d
f-M<LaBMe^WJ/DQU]4bMA:8W5UIB//IfV^EcI;OcP,dDc[6eU@\HVN^J=9C=Cc:I
ER+/:O>WdgXBH3]-+eAR6a2_Z8B.E,#N-JU#D=bA#-RI0ZE:eTFGX-g(6K)g#4B)
cM.(R.4e3H-#/F8JHYfDJ1@G<@]\E@6GH#&_3I-+EQ;L:9AA@EbFE>^?@N/K62;g
DM]FLY)#YTMCWJ4?GO5^-@1+9@3B[J(=I,\DVZW<U3NV2/<.0R(EfA.6dWf;:8VV
Y?dO@C(GG)Ze92d\BdT:=Fd:KLN/RLdFXTD(09],I8f<+Ma6I._F;/J]26b\2:-;
LN0M9T92gZ]bU+@.Q4b3OQ^N4/=b>.BC0@;X##R.L(\<90COaN7Z][JBKS9;RM06
/&5d&+g1V3F:>_M:#O-T=:Y#Hg>82IIZIR>^.#eE9PV3>>Za7#e/GI2N(b4cVK[g
OH4DV[X;.&O?NHa3\AXXX2Wd97<W?P8NR=BYWaY<UQU=L8bI;dSY5@;O-90Z9dZ+
PQ;dfFLg,QfE^BAgbJ-SR4<+46g-a^.SP6GZg1f9AfdRLA,H;7@UbO[V\=3N,-32
G-Q>.EABL/+<#.33.S2EOGFAWJ6_GGD7HC&O]80.eWM-P)-Fa6EEZ3)aOc4NP7_@
#bTMQM+<gS^cW<V\,#8Fd;N3c^F9N:^LZd+)Q0gdKXE(0B..4#1ZOLAW-aBII1A)
99DV],_TN/^ef92b02fc47_5FB)8ZYeBL8f#??5d,\]>>5?cWAM(]=2aEBSO4W8W
4AHg[:c4N-.Pa#?_EG3BAV.d9+#,36<[_>)84a],K>)XT_?N(BHEWR-f-GA:@?]T
4g3KQfe8Yg)B31.HBQc2NeFcE2?DI:U\,9(Ag.U6.V^DaG252>45S0CeXL\,WO>8
4GTa51:Y@3O#2#]WODX2Ba=[\LA[M>H&L_A4fH85(7.XDaYda^+]_QI1OcS?_aW[
Q\)^+)[UU-5Nd9@f92/K[a1.O/ddYG#2?TX2Cd.a>PHdC[0C-4@dUEG[)T^c2fDg
;G?1@/HP.)8@^?f;G@N5SI++-Q3B1VN+WG5\V:WGYF5b>?Q.M9IIg=W=K(]<JSW[
;6\eN\B^G>XbL.C.\)?SO&bcYU:&VTBK\TN617K<Caf/c[S_<8cSV80E:EMZ^JP=
.M/8SLXR-P\&N6GCcH>c)FW4,f(4WeT-R,,SZ650+QJbV@C^AS+0RLae.9&/8RU>
VEdY^+]Y@^=\=(-82c#V._BWP4gf7,5\@?g5&Fb+WH9TIaY2WA4^AMOR/Ff?0VXB
2TKDTD@@GC@-/T8^_Z.&9Lc1P[:FbLUP-?(\6LMLCcYQ?M6AQ8>I,TPUg/?caECQ
]WfFY1a+Tb-g7MT.a<O4;)<1K(ce9\G7>VZf.RZ,7GYU<T2R]Ud#8ffN3[G;g>S6
.H_\#]3DP]PWIX)FZZZ<?_5gK_)Q4>0AB[N;De]dB)Q,V4V8d<=Df2C-4;-_c<0]
d2Jg2e;dI#3[^Z[aGMW8G<AOM)O#H_CU#W@1NJ]T#]cIT_-Yg-6Q&A25.WG7FLfQ
+,gVO]FVHP(F=I@,S3T=eUf<_@4KLF1<,KUNTK<(6E\6SA#&VOQ7,4/)N5MdbL)9
eMVIE6KQQ#F5e+gP#;LDD_^X@dgS5fXU\3>K\H<+?ECBcFReMUR3O[5BNBY9^]>(
?OccC0D,UW:-&+E4cU&\4P^X5$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_OVM_SV

