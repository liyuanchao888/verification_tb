
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_SV

typedef class svt_apb_slave_monitor_callback;
typedef svt_callbacks#(svt_apb_slave_monitor,svt_apb_slave_monitor_callback) svt_apb_slave_monitor_callback_pool;
// =============================================================================
/**
 * This class is UVM Monitor that implements an APB system monitor component.
 */
class svt_apb_slave_monitor extends svt_monitor#(svt_apb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_slave_monitor, svt_apb_slave_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
`ifndef SVT_VMM_TECHNOLOGY
  `SVT_XVM(blocking_peek_imp)#(svt_apb_slave_transaction, svt_apb_slave_monitor) response_request_imp;
`endif

  /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  /**
   * Event triggers when the monitor has dected that the transaction has been put
   * on the port interface. The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when the monitor detects a completed transaction
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave_monitor components */
  protected svt_apb_slave_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;

  /**
   * A Mailbox to hold the request information
   */
  local mailbox #(svt_apb_slave_transaction) req_resp_mailbox;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_slave_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


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
  extern function new (string name = "svt_apb_slave_monitor", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
  /** Report phase execution of the UVM component*/
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void report();
`endif

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
/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_slave_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_apb_transaction xact);

  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_output_port_put(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void output_port_cov(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifdef SVT_VMM_TECHNOLOGY
`else
  extern virtual protected function void setup_phase(svt_apb_transaction xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
`ifdef SVT_VMM_TECHNOLOGY
`else
  extern virtual protected function void access_phase(svt_apb_transaction xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called after reset signal is deasserted
   * Callback issued to allow the testbench to know the apb state after resert deassertion (IDLE or SETUP)
   * Currently only for the initial reset
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void post_reset(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when transaction is in SETUP, ACCESS aor IDLE phase
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute.
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `svt_xvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_output_port_put_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>output_port_cov</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task output_port_cov_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the setup phase of a transaction
   * 
   * This method issues the <i>setup_phase</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task setup_phase_cb_exec(svt_apb_transaction xact);
  
  // ---------------------------------------------------------------------------
  /** 
   * Called when the access phase of a transaction ends
   * 
   * This method issues the <i>access_phase</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task access_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after reset deasserted
   * 
   * This method issues the <i>post_reset</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task post_reset_cb_exec(svt_apb_transaction xact);
   
  // ---------------------------------------------------------------------------
  /** 
   * Called when the transaction is in SETUP, ACCESS or IDLE phase
   * 
   * This method issues the <i>sample_apb_states</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task sample_apb_states_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called when the signal_valid_prdata_check is about to execute
   * 
   * This method issues the <i>pre_execute_checks/i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task pre_execute_checks_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Sink the request and add it to the request to mailbox
   */
  extern protected task sink_request();

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_apb_transaction output object containing request information
   */
  extern task peek(output svt_apb_slave_transaction xact);
/** @endcond */

endclass

`protected
8OKQg7Gc/MG<>_YQ/S:XHL1R3Z[+g\/YUdZff]]D4_WO4=.,,JRF+)D<4M-OT=QW
,<>?#[CLHF0g.d#@,cYRDb6O#]7ZEOgU3=d:/2Y&AX0&/8L#K<X8_Q3>K0@Z9G4U
P<;DdK2BSIZRb_54TZJ6BfYUJ<FDIB+TTd<(dCSP-aa&d<U>2XWf)LKW)#c@HG\V
V9dAEPANS#,9T28>-2Z/?YQ7g-a9FgH=;P2/ZEZI0c\:^.c_0BFD2@I(Of3DV>\L
##K822fggTG+]9XFJ8^eB4F-F-&E(WAGK^(85?97J>GMa<.=JfgQ,J6N:68/.MMI
N=0&>EddbAI?.aP)O/-]F@eH9d9@<?LKTX>RZ>#=XPX?CUJLAD\#?CXb3?^#S\9d
O@G/7JU\[Ee,N_U3H;;TFVZ/Gg@>[T:Yecae@\Tee_9\^.cWLDURJg7H8eJXZLTP
($
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
^4^,C)BW,^GC\X(8/5^ZRe&1b:QU)^M1T216MYG^AH4B<LY_&M.Q0(&Q0<7GN-4H
;15K-H+BM&J^SLBY^dM3(<P:_(B@_459,8OID3T11dQaYg7E>W+4aK^75acC:\BP
SQLdE&49\b0?X4a(-4/6D]H6fDb7?C&[<=Yf]_I-ZH<8^RN/+]SB(Xa:6>OZ#:=R
M>-2#K4_1RY^ZE5d?c@(>M]aP?840&?_),.?NN:8A/e4cWSQY7:0R<W^>XH3>:0?
L><DTgD_4CC>YMP03:68b<8X4g[;:#O:ceY8HDfK:GFTdJS<0SBK=2(#+e_D[TZe
&5RRH&=P#Gg&:<Q]g><0BW)?HgH0XDeaNMWOIb2V_fYGP(7_4SEE(P?:D[D6-IGN
0Y&K5eUf-;dWYXB(-eR97AQWHag,^U6H2-EC0YfC1N5_GSYNDMTf21R;6e]HR)G(
^H6Fb-8LbG2K3&N;FG)d++C[KeI9US=?._CL8VTI=;K=_b\5b<\SOA(S0;FRWP9e
NQI)G.8B-MAPHP)XI=)X,>=^eaO]cDKJTF/E70E=Q&^2X2Q4.F#@Pb^SbG,I]NU]
^4)C>+.H^f<a]^JY6eU[Ua\A,QUJfB+4>?(bUa,_UH=>#dfR5RQYf,c;:Z?8I6d@
65-,B/2C#9M(]F?XKQ;GY21a11F?\:F-ZfOBZSFW.K1d#P1Q=2;R;^8)^g[;d#7A
f\^[NI.:D49V^RNG0(Y?;WSYBQ>2G1JRf<_b(H_EQQA>Zbc\Sc-@S)YASY\_P.YA
#[Y\NF<Pf_a9YJHa#BT&)GP9cGRSbWGHg/H6-YMM<0ER4_>IK1(=,31W2#VXQcBV
0>[BK,^b+ge+D_(]@)B5OL_@Kd\=G].fGa[7.LeG-cLGZ?<gRJ2Pc+-W-6H_Ab?O
B&=0XN+Aee],E77EQdLR]=<92Y)P0ag/7W--bbZ9g:/6EWFLF[=JNMBX^@Q9Y:4(
YM.R^S2THT6H9@X.2RKD:&]eDE22&73?.b8RA59T/g1XV3OaYG,?,Jge)\4WcG0Q
<_/C?0@.eK@F4MS(N_HV.:R,EU@KC78+0.F1MWQH@Y&U8DO[d/_?9RW\()E6-)LD
gI=.(UfS+6O96Y.g&[J&A@R).MVL).SQW6(9edE-bJRA?N+8#2^9UF>O,?O[<gCE
K@ZE@@4Sc+\R7fV#K\GI:T87P<IRf7X=SU<?X)8[GK>FbA,QBL2+F@=XIU/D7.Aa
X_=HTa0-7K:B7Bg,Te1/Q=Z,_U/FNR1U6^#&b/>Vb<VX-c35JCDb\DOX]9BVYWMH
H&,_3S/8L2SL+E6PgPWV)Qf/8H[23,Q<I7VZ3H2ECD,dEILNE4>S3.cHZ,S3)VZ+
;-BJ,5Bd-^gdH0/HXWQMEf8^9940Zbe0F1I,fIPC4,77Kg78K/KWeJA?]3Qd_)1[
F>PRKAaL-Q0<<^\TdV(FK^4L\719?US.QR/&bOV,@ZH[C^U)SfIJc6YIH\g948RE
/4^UZ\:K=X[2+,e+C\=8^67-OT]H2f?]b#65K)C^c(5e/7YT3>>B<<U)DU&#^6?G
Z#MeNO,Z[b;(6[#UZ[URXf?/>[GZ0cGI(_+/N5A2(.LLG@8(SKT:)VGbd,,XX<[#
e<T17,<=c1.;E1)Z2.gL;FH9_14df=@56H)+.SSOO.\/e#[[GW#a=C_X#R9N4B21
]\+7=Ig<.&e+(Q8[4QZ:15T>B\+VE6#XE>8Y<:Q8&f/c=&b;/M4d?(PS7T-e=,2=
+/0e0UT5=NJG?cLVIS+a1QL56;JG/+?[I4M9#?=fW0@00=Q(:eMLKdO[A2V==E94
FDc1&0U[X)KI3CedaYF)4&66C,RE^\#<O9MN\]2.8XO>=HT57\gY4(?3:;abX]XP
E=JX&/?WWS9/BOJL7bg/eI;AR.C1#f+#+f2g_G_#6<[aV>;]VgC#7CT?gOX08:<E
+a0>)7#6,0SVD(@YW-U-;BN95?Z3@R73+Q58c5.WB_fa].F.;G.]<TJ1IF;?:4Fb
=2^Q#d#R_VOBDXWQJFa12a/gO[&??eUf&MAE1,YXQYW3JN.9P,)6YEeV5/\S9DNe
GcXH^=1DW:I?FB\[E7(P^,S,d/PAHT<_G8^CddSD.dY4_S-C7M5cXS[#XEL4S-a4
dVecM/NOgbD5L(W6D@Q-dORO-b&-(8OMS9AcM(ecL/fMA^+d/J9,TG+<PK5Y:M95
D=#7K:4#_22AW<6&AOXTWgdDcYGE99@Ic,cNFO(:OEbBcA9,GMVBI/W/@WPT+e1^
<M:02\X>69A;+M6+-cEcNKQSTb4gITg,KO)cQGUJVHF@WCQ@FS&2EdD,^4BL_@C5
VARcT:W,2a5f<W_BZRAJBCONNF-80U\[/c+SSHDX:c7gT<M=>MC6A0T[B7AY@KSJ
VG4Ad0d<]0=NO4Qf=W(QPWZ_JC<AFW?\2P6.U)(\=E6<@X5Y,UK+@3bg69JU(f-4
0D#_6]U,>OPa@4NG_aKJ_2RGKTf>0][&_FQ#NRIGR9OdF.H6f<:@ca<>)b)KL5bW
??,)L6<d))5@3JGf0VV>Y(XObFPT?:UR\f^:R]]MWX@U-2b2-g;e<cd&N>4HQU@.
HC[&6QE;5+9DcLT;-4ZLH(,2?8?E(4\eXa&[<#SBJC41U8U5^Z2MDG?<^7KK#5:H
Y?M_KM,JDGXC.3gVeB==P2(TOa.S=O36E(@TT[?aL((gCC+98?bZbNH^3+>[>2<,
d00)=c^HNb[9Eb3JTa>-7(Udc(U_SI^dc6VLD2<7OJaNM.^M4OYN\?HV2K7_RC9E
H\PA@(d/Gdc+ffg1.Z1\+?b=Jb)e8N6Q^.39+efO,ZTS#U&_1(7^>;BGF2f>MY3D
5]Nf][=_&@b)N)d+TI-Ag;)[,:Ba2ZR_6+aLd)5\\c#V.NPF_1<6feI43NcQUBRU
[DVU8.+O]a6JB[EKE6W)9R@_fJ#.9O5G_&L0-\[N0Q5WK<AOMMWbJ<MVb1bD.HFY
1^Z^RgLc+G+g\+&A/E=C<^GfR=/I/YPHD>Bf]c//I?O1,f8/Y\YKbZ]><_0^RR:[
P[\1eSN:86WC@2HR&c]OK3K_T?c>-17C9CDP6TUab718b/FX)VF\g1/X]VQ+Z8DE
X^R(FKA_C>Z8<e7I,VYI]Z?6FK&XC4K;Ca1O<#F_@gNWDJJ<Y.BG/DQ6c.e;A_N[
WQ^b#G[CROS9)A2E-N83Y>BN:K&aN55OMMVg_=6;<bTMY(6&ZC6_;K):;=NW&RP-
=4W>fGQWVSN9)[DVTVQGN,g,-<]RN=;K^@/UN>-71O-WMH6LTd<Y51[+R1^?&X:K
D^(T9B9,CILKT]04WHGgJ^Wc+<M/X+KeXX4IEa=a5@7=O;^X5A0SKQ/b0@+3dEf^
QIQ.S#,F&J>,?eb]1-eK00_?GKF:BN11F^]-+M\RI4RRDM3TGVS+4#(9=]0>ED\9
P(6U+_)&[b9)d_>O5]FJ?F3b.&]f77#BHG&FHA6SQ5ZNBGZXI)W7,ETQeRW&8Ac1
.?20MP8(_A-[J,6<WS@A0@@a5C03e3SL=V(4R0D0WUISe0]bYDH42DCNcIZ0IPeO
^P(Xg=M64O^Ed2JYb632;ZQLf[NZ&:Xd4K-\PB_/9A]=^PX<0H\aV@d,ROD<E&XZ
0FI7D1EHJfd\/127df#JX45W=fP<7g8\QTaJ]bSHLRCV(SLJYaX6^]CNQR-YeWEO
.\f&9>^#^ec[>]5Ig?N?&=9g7<6d?e,IYb6MN<aXD>.6Mb>F7^4Ma9g;a1BV-9a8
E,AO_CK::&,LY<ed1;S+Xd5^[DM.e19GZ2EIKRIgTJ0_;HFfQG-W;NH>d?I)_1Z?
MUGH&N1>9:0/:K&Y7)0ee.IgIXL\ZF3GU,-M1^MS-\09_)EWJSgO5P=Oc/#0&KHH
(W=VV@?4.-13E+C83RN):<V,P#<LQFDMRC,X,G[FKXY;J+e,T)fc^8PJbE,RQ]L7
R8&X)9V645<P[Oa_E8)V:Y[#L]^Ce2]^:Mca2)N]S]Q,7S05U92T,A/X,QURN.>P
&U_-.XKIO5GHY4g(]g#>6D6cR:e\^+f?5BIYNDeH/f9(.L2b_V,#([#91=c78]f@
)8SPX+A8L]f\=5gUA\DU2Uc[TdM;bM8V7.KND4GME:A\5dX/)Tbg8IfKJ8>]@T4J
I-^NG)BFI(L3XZVV>&^+dZ<IFTWe>]@Ib84P[C<Y@0INC;\L(L>Z9^@(LSV?RQ=P
c0S_T0C+&e@SVfX<?=2\Z@,L?LJVL8=H68&@+NWb^PXFbL+G78^<PETWVdJdX=D5
V(HcQAIT#=J(TVOBQ@<c0Zd/Pg1AIG#(&>fHM\V(Re=Y_JX/_TH+8#V\a?6fg.,_
[[KE6;H@LTX;A9_F+SO9-,1^<E+BFc#7=W5^_T)/@]d[.(GJNF6LgJD2e5.YI(JZ
PVW<B@LFa^]gLX6L(,)_/CN]3+<W?PVW2,[b-Rfc(0L)ZW@15K9@D@^H>@6RA1Zf
CW3Va].ZCV5/1b,2)M#DD+dU_eR9-UT4VEN-BZ/^fCDBg,OGMC#Od8:1E6I.+&O=
@:Qf1c89MG4]ecX0]PM_:F+Jg>4#,c61AGdZF;J6K=#c,0?A25d@QISg[=+5L]?=
D5U?\B>gVL(,,;8)U0)><1K2Kg/Q@I7M\V/(F>)#-P5=&Z_-?d]-IPY8VT0/O;?3
a.[8cV(7@K-NKb\CRWITa6.SeC#I&MM9?0W3M-e/@4RaU/[K(3?>(+9]:WY/LG<I
=ZU/1;3[M-eCfOaKc5ZI(T>VbT&c6O1;9?e(GF;1Bg:VY=73^H4[EN?-3,+K9T_W
:@bDK-e0,Q=,J\5ZZ4Z6Y?G?04^NReIM48<LBBOd^g_+N7>]:dJHcdE&C4_RXe]G
T?<4GS?1aGS8;ETFe<CL66fBM?Z].LeTNU9eRR^G29b(DG1LJ].G5[25O?L3IQ\a
NYfZ-7J1eWAD@.bWKS@CS:9:V(gaI&UO8<1d6<9(B)EQR@5cV]2#3C&-If5IafRL
fE_BTQD]=^eQ3b=/d,TO210JF.O[LS@LNfUUIFHJKK>^+G##7LWc7_BM1^DRS1W;
.L&TKY3e;4S&>cSRgg)ISY#\+_,^@ND_UQV:.ZVHM/cA,g4DcI7fIb+(.QgTeFUd
aJ_5&eJ#9)X6DE:PbTXe=#UB8B05eIW:6U;)]OF>I?9W]>7@28\QcI5#5CI/SDVN
/>EK+?7W:;O-GH))Ec;OP:R4YQ^7>5,:3R45f>M\I<LF)2K71YM(YeCc9-;,RJIf
>fZ:eCIO8LWIM3bH;RJRW5X@;EaD^WDRD+DX1[6:MV6EBQIb6(bW3<H^G_Q0b[+3
.7#=KF:aUaadOT7##K[N(fVU89W#.HG0\DP+A#d]MLeC-\Aea2&5<>35C]P/Q@D9
KBY-02Z2d]LJNGL#UC1\f6<XXbFJ=ZU).]W?b;&aGc^?1?KJCW==a6YN2;,<?Z/(
:&=RQ8,UJV(#4G/4Q=0LCY0&I[,/)_:7<e_GN[Rc_KUK@b1(75[B:)UDX]2^Fe]+
/ae.VA7Y_CDaDEcVLT::e[O7+S.UD]_3HMWLO<PH(O9F8IS\,g8U]U=()@MBBga]
BQD53>H;&>&CNf&/+]OTZ\J-0/ZG9YFg1V.C=F9EF/G>OL(XJOA>4X;NBfBI1X&S
(K+8<[NB]@D1PXb<V0N(2HW#C[/dIB9ebdR?D4+AXW[>9V[=97S@:>J+g+F:KZd3
UOd_YI>J_1ZV5fL[W?+;)cT_N1I5W25.0E78OPcYAUC-N>aa0<[=N96G28I?dV>H
=<#6L64LHgS?S>;AA@A4AM)2_:=18>&1.@E_ZOW?b:gdf^1-CE^T]P/PNbYWd+@A
QfXW&[&c.=RJ]E,];;dOcGGC6Qg/0+V[T[?J^UIaC;B^MLK6-]GE?IP\HHf^e?H?
_]G?Y.d^5#I/]5:e_43g9GX_])&)HY3R;EIP>Y^@4c3.]K5f?]YH+4Ra;HBBAXdL
92,Y1eUJ&]I71QLF2Ng.T7bfZa.fWaHQR4H]E;K^4D>b#BV>Q^[6VRG7&-##A>,@
8YTH84(&VI2=A?+8+JK_.P9c^I/WP1/HcS4TACFg/?XSB.9KMZgG-^Da]XOfC@e8
Z)]g9:N[7VNMMAHIBTY=I=E/U0A8O4,VSO#66QE+g,X;&#J)a^ZV&VX(+C-c-Tb6
6BZ_cQZ5]_Z/e45Q)^2dXQ76WJ,_)LI<g[3>TdO3RXK:>Q2[T_.6P=Tb=H)Z7b@g
HJC(:H#OPcNM[+A3c7.\2;P,bBNfbdF73PaM2ZH;N4OL,@1KQ4@0B9IKb<2.b354
T]HEXC.\R@75WYV)YeBCL,_3fGHYX7<NRa37E)G#@1@,VLB)CGDC6C2JcPHN#Ig2
EP:7HeU<f.@&QPLbGMbQE2V4T0f)gV^I/00<2O.E=R1BF\UY\+<90=+6P&Y15;_J
DcLT,4LS6QL]G3)G-@E>LU0O).e:bL&5@G1_GRPVBZ#BJ<fU,2]JZOIHH.,=HAW7
ZODK[f0@.:@=BgI]?]HK.HFQ&.A@3OIJG[fQW<L9f[[YNR)9GNVM4L-f5Hf-V;WO
Q-WX->JN6\+BA#7c6WG=^U;U1,4^2PI+493,ZC/VJR]A&-K6e1:EE\@F[^K8@B:d
)9:R=?JTK4NRg;SK)-/RDX0M1E1QSb?U]@A&@QWLMVLBfaXKB3@V\U(=ZAc-I+)d
L4@R<HbM\,7aNY]1\Cf>Sc2I3BL7CD5M/0eL./W=Ta:J]2?I>(\S2F+dbE<5__-^
,CK7U/TT^\:7G5,H=@5IYP/\WU53-S(ZW8R?_O@ZY=SRV)W?(GBR<U02JRgAY;(d
T6]0U+dCT]a,X>;L=@4>5HfZ1Ic42[.,Pa03C,5MFaA0bYU,O]F(:1@RC:SeU7[U
E?.gHY@1AJ./7E+>)1[&18Oa+6_Qc2eI:D_BgY,O(N_Y__NG2/ObgV1KA?,))/Z9
+GIKWBUY8;X[#W>/W1e0(3\Y+Wg]]WG;+GJ_.^N6]GZ,78/fDL9VY,.^Y?\KW#9&
fLV,\)ddP#eWbFC:/9dUR:9I\84eT5/VKLFASQ[];WGFC[:I]7K8d5]6TMME;^,K
P;D-F1ea8+Yc?R/a-:TaY(X5IOeLaQ5DTNDX:J_X7e&^c>&WE>]3,Ja:<f2]a.fG
a)27R89>X#@0HLH;gA[0_)N::Sa:0EL1_?(-QX0;>GSW^=+cV6EDb,H^;3c329[V
D_fOS8W9SV;Ufe6NOY0@3KP^dR^2S-Y<D3GR0cTOA\fKS@b)]9>GKM50T7_]W7<]
O=JdZ(37Ld\:=T6_F0#cV->\BR1PDAg)d2EM/DW0aT[fVU/7[_,1#YX6<J4a=-1J
+R[d^UfG9Nb9R&.S9Z(MI&#&6K@_JZ4\VUOFN?ZDJdU\1.B^X3]#fNfV9[N_&P01
+K0HZG784&=FR;Zc@R&_,f,V4;fU_YM^(RK6.8V(I>B;)P)12UJ.J0:d[>[47d7-
KNcH_IO5[ab39Q/R4+X#[#Jf+/EL5:,dO=E^bZ_>JVX;f<AKNXM:\=1.C.Ua4G6T
RTUdS2L0;U9S;^V]f2?JOFa4Ye0@bYca6E=dWT#>fOJO#SJOOdSVL06U;,@9IY^/
:@595JX=X4<[:fe?37f32H3HNBFeMO^HB3&[K>+Q5O8D?g8UD4Tf2HbD<P2a[RU4
X.E#C@AX:@R9G3U^TL/)b\9T^d6SQaHCO;XRB.PA^8=b<VH<,8b0N4.0eN+<dBVJ
5-G1/Y-+aKQQ&H#T10Q?P&I(FTI[]K&Hc-\VJ]BNQ4_#Q+cdFN9XRR1-b\/HZ4W4
K_FFO+&<=9A-XY/He3H^JA35Le@d@N0E@PSKGK914;WVSXB3\2<@631]?PcH-BbX
/#\C5\GCKU.W:X<DeIfM[F3?Xa9>d(XC+DJV+ZDWJ4:AJfRcWEI^?J@75O;f(FPd
0b+TaMcVcG9GaeMfE6OYXUfFe2+54<L-_DQ-IEK-\\5^Y,5A8>S0;aLO.AAN08\d
[ESFBTIHb?HV8).[_T;(UWT(TAgb]Se)03EUNIH<&fLF]O)KI?WP=B,fK?21A@^P
T,Q1MT(AE\A9+#.ZW,FU,f@_Q[_2.g^:bOfAB>.<\>Y<^0N;R?QgM+OI:ec_51a=
.a&JE8(4ULgbB2DE)ZR[U=@IHR@#(>&:H8IP@;W##LXD_W7?ZE/_NM(<=AJP^&df
W-8d/YCUe;d32eU;7]-bf=RdR2YcGJZY((_AZ&+[#=>HPdaUKe:/O[GGP<K^9:VM
f(Fb\:P_c[62QRA>+9f\)#UcF=NG^/K6R3Y\g]dSA2de(D&#DV)-;dPOWTVgS+4+
+JAEQO@a:.eA#8#MGcRaK5<J5\R>IDQ0\8g8RaG/DIIW+cW5KA/C;6_]);D/UNBG
A6^<R+)#=aNfO\+f;W[4#N])V]HU<VZd<VOTc1A+<J\X7B?Qde\MV]>-VZ5Ig]&D
T_EJ[Z2).5.X.e6Sd><[>aT,>\(E].I]N:R-X]E[_4:gI0KPH@XYVPY8M2NHfHC&
==T,9QQPWD1P<1KfQ5F0Ad.gR.EP0NK:Wc/1Z:>@\_IB<g1FXJ?Gd?0ZIJC6^Gb-
[eY1D[Cd2L^SF9&96gM/R))3LAN+9/FdL_Hac.cUd8:O2S<9&aX28#\&?8W:Rc>(
G6a-U?77Z82CS[4T3#P[+\Q#GMH:H7YAT:26CD6T+].Ofc2EL#\4Dc&A3[a@8YV5
CR<SM1S1FccR(UfL4U,DE\>7fCP6\UGL@@Zed1[EZ[GaB-P;e-N7J-9/Y3CP[OGD
JUg+ecDP(,+_I<)T(6@N9T19[/:8D<(8N8_,?a0C8^X0aF5]a1=2(ATdL^IXLPQ0
HNb>.MgN,6e1\>,>AN)X)F?A1_,#R@K\2P0bfeH=YCUC+?LZMc3GO;d6dEDIU7\K
-.=QH]geF;A71Q<CQf35IUZg)V<\9<9ZDeH^W+>ZGK?A;P]]P)<]-a[_B>Z_:,/;
A<RMQTF:@J)R8_I:acP3O2HWeDSMCU/PQ9C=AReVUC1PA,O212DJN2@48J;e?\7O
:N1/I-XdB/9RL88cYd/aCKK#7V9]V4>Wb_aBe^e=MG+C]1[AU7>^SB.8E8MBK;G9
4ISacX=NWd&:[Z#JT(OY[c4=c=X4.Gd;EK276)a;8K?J;+d<(DCEJ#6A<3@\C1]7
&b/&G8Z&Hc\88H-2;8[bJfP2U7_^YKAU,=a>M5e^C=O\#N4Z)6&5DK)7e2O&/b=U
)@1WUG(,5@BU6>aV=]]:(&1]2e&d+Q52Q600XY:#1]PMV+8]c(dQOL\4E]d66_UI
Bb@JEVA_c:V)-cdZK&[VT@DWE#Q<dLf.^WQNVaagYUK-_)9W19<;V&L1fT-3V1._
fM(7AO?\E@#Y>R[1IYVBP0YA3IT7QEBI?TX4aM/.<<-O0(_2L>XQ9dbM9PT[gT_0
>M=O)B]fbANRR,=gOF3637OFCY>UbgUd\OU2(KAAE836G?O3KYZd74b/WPUUKWG)
Q:G19=&)W.5+3dYQC^>9(79&LL&&6PJJf-=F]K9[(e<JJRDO[[1[W/E;4RHg6WG&
ZFeME5SM&I_065&&WAc]aOZZ;,#EQKQTdc1,,P1-K4Dde.O5)LM/LQ4GEQ+2@\PB
_M86FV+cf=CT?Z.+Q&]5(Wdcd&RdeJ;OW6G[[W]#R8Y1_a#;MJY;VJNUB9B?5[@V
Adb@/f9>.3R>DE)RC>DJ,40eX77d>cRWE8+c47g_dS\]eWWb=O_We7-RBCOU24L?
SLBRf(GAJ]cF>7T20V95N^9<8<KF:;,X9L6Fa/Q2VKY+U@NM;S+W,ZabDM/)2T8?
Z/eD]8NB1YZ/(3Bd56,>/+9GV=cQ7TM<,WcYYI.B#Y^E@X5@(RI.7>06g\><=0aS
@_R:B_c<UcMMf;OAbR39H+)7KFM0B>5g>TM<BcRU;HT_&5-66T4I(b17=\d]38ZE
B7<:bN>/?;^.^,J5I,&)MM83<[IJ/.PID2X:@\TQQDb6VOffT1B+BeaK)\g38_AU
(Q&(QTWA1Q1M(9/dTg(LN@FIIcFDQABZM\,M9ORJ>N:+6ID8&g+aXcN_42<71Wf&
58aQQ6\/e&Y0Y@\\dQPLd&33EC[DN;P^SZ.S@-^\5N^(UJg0;5-13:J5K]8;41B\
SMPXM;TO\>&YOV4dPP?1T5K^HcJM>QfCH&J6fcc@cNLFU7_[\J.F?S4FV-X57YFD
#(X=79KIMfX.:&Dc9)bX><(.QKgf9gE3NFVc-eeA_1BUC#0V[S+<WNAXeP^_WgT+
6#(]&e#AR&+L9VJG8K[MK1:NR?VeE=LU[V@U=R#Zf<ZMIAH=O-KK,0P1)S#f[=<]
BL0/[=aR84YbQHf=^/gCECG5QYD3^f>?+d9B+VA9gF=7+G0+f-N&]aOX]#&<-VT9
R:+EJ.I\RDO4&L6<474S>;DJCX\1ag[\S3+0:Y\ZK120H<5\:X?3RZS)-IGDZK1E
Z;XX-D-ULcb,0X3TbgZ??g>E+ZTW>G0/]?cL3PB#UY9NB,-<Y=;?dA96#2eA>A@X
1WS:.@)Rb1/XJOMQ6e&b[7-a=T=c)bc#-:N0dYeO\aP,;ME(CXB-(Og;(a(>D_&K
R?+;>6b.f,UZc2&>dL-PL4MJNg=O=3;3]GN(gY@W-:.;M8G4K/(<B)FFbKD(Z/I]
.]NP[aNYD1.1PJ)VP)LOP:E^c#_+L+d[@b=2.eK\Y,Yc;B4KTfYHcW3@02DG_GV1
dOYc6[fX),[Q&FJ;<.dC9NAE\CACJaH&8U8E2]cRS[6L#[Q8JEO3,ZNH0&>?bGbU
)b@cP)Eg.@4GKT55\H3>&g4APA(Pg_N_5J)>?4UO+gB\.R^O^YGMOQEUA=C:1]YW
UN1BH470FJ?ZW^[H_\eNNC-Y\6dcE=+OcJ+TVXI51NB_/U5FLZd]Z>G1_2fJ/UDB
80F&@1_6Maf[G5.^R0J2WgU,fA3L]+>4b74C5?O=Vd\X9XabT:Z73<?;8dZ@MS1K
Idf)S4;#GQE0PJ3gDC7g-c#9cXPTdEe=5E@AEV1-JV4XM]\2@#YL&5]aE;>3L2&X
,SX=:2UdIRU8]H;FG/W6c17QF;C9,I9)bNZ\33gFIU3<P(Z7aIZ;.5VK6T(P(9X:
VF2YSDL@_b,S6^:H#<be0)>PRMcUP.gGQ0Y#[4<4->F14_U_,:KJ=g5aQ4G(bLd-
a=\8cL3C3-WT1-&/dJI+:-CdR]g&=ZFbAN:D)&153J+\K@HAXW+ZSfeZRY3JUffQ
+WJ<L(Z\@QD9AA4P5(=.JF0M[fK#NG.C=QQ4=NcdZRK\dG_L[S(gK@,28<[AQ)[D
;HAbc37=6_5717;KMCKA]d2SB7YK05_T:R:7e4/AD899a3cIcU=QgXK9aX;WA@B3
FN3.,+:CCa#K@BW^.5//;:ZTe9AgDKFTd+L6e<1F#&P2>GW\gbL]\\Pe:WZRNQ4\
/10F/?daBTYdH^WO@>J]eJ0(+5KKRCGdM7bQSFac5YQ50+I@Z(J^@Ha]ET/4S^:R
NM8;08O::(_XLHe\Z)SfJ-W9Z;/),]>+S(1@EQU+)2]5A$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_SV



