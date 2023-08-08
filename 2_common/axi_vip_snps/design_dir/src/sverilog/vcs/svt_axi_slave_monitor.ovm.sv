
`ifndef GUARD_SVT_AXI_SLAVE_MONITOR_SV
`define GUARD_SVT_AXI_SLAVE_MONITOR_SV

class svt_axi_slave_monitor extends svt_axi_port_monitor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
  ovm_blocking_peek_imp#(`SVT_AXI_SLAVE_TRANSACTION_TYPE, svt_axi_slave_monitor) response_request_imp;

  /** @cond PRIVATE */
  /** 
   * A Mailbox to hold the observed read address ,write address or write data before 
   * address seen transaction . 
   */
  local mailbox #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) req_resp_mailbox;

  /**
   * Local variable holds the pointer to the slave implementation common to monitor
   * and driver.
   */
  local svt_axi_common  slave_common;
  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `ovm_component_utils_begin(svt_axi_slave_monitor)
  `ovm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, ovm_component parent);

  /**
   * Run phase
   * Starts the threads sample and sink tasks
   */
  extern virtual task run();

   /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);

  /**
  * Sink read address ,adds the request to mailbox when read address is 
  * received.
  */
  extern protected task sink_read_address(); 
  
  /**
  * Sink Write address ,adds the request to mailbox when Write 
  * address is received.
  */
  extern protected task sink_write_address(); 
  
  /**
  * Sink Write data before address ,adds the request to mailbox when Write 
  * data before address is received.
  */
  extern protected task sink_write_data_before_addr(); 

  /**
    * Applicable for AXI4_STREAM interface
    * Sinks a new data stream. 
    */
  extern protected task sink_data_stream ();

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_axi_slave_transaction output object containing address,
   *        control, read or write and data before address information.
   *
   */
  extern task peek(output `SVT_AXI_SLAVE_TRANSACTION_TYPE xact);

endclass

`protected
40J,8=<QZg/M/VMO)SAT6?S[+)dCG#QfL;E&&7O8)0.NP[>0RdC,3)@[>Q&3]<@^
XCU>2d]]aB6Z/90HPa]+1d<LF&K<DVS,+8MO&_JD63V,M@./\)eV&e,+(65::e8Z
AV.Q,HS@;Re15(>L<V#LdbY2(?L=X./S_RQdY,C\CB^E?S.)^f(eaKFR<Na4[+7a
PH#S5Z9#cD_Vc9d-R]A6[&)M<9fba_E00YN3[1[R0I@aS(SRQ;];WPN.?VH.G<0Y
6D<R[JaO0bCJIB(BQ_(HfMVJdQOY/GRT[BU-<P[@<+FOd:.:P,WgF<NRM/)S+/,G
53@D8Hb,RQ,&C-YB)D]6;bg0\@DFS\UEA:LXgA__F&FRS](^VH2DC[;:TVF7[FdH
Yg_[:fUC?N)IW+B&eL,;\@-;3:b+&A]2BL+)=G@C\Y(FWfN#\B(S&<NJFL.&dG6\
[C)eTQ?Y>R<(BLS1d+ZY>+T(b^O[E)2-dJF5dZA:QD[0TSb95b8VH..Xc2Vg=X\H
PXJ9.@-R7HF@=MId6M2Af#4OeXUI.:5;Y3O>e>[_LDPPC;C-PFG])BdBMXR#;Pa7
STN(7N,Ye/dNI3;]<_:HMbafUNVK]&7eaTE^^6N1B=7A@U[VAF(X\Xee^_ZL#cf_
AED8,/#.SYN-:fg_fa2IUODHJ&(M0R2UIgTB\_QAfaR,f-32.5MJ.V:N.(d150<8
W1NgGK0Pc9L5\J5d?+aPJgU2PNeZS\01L6<gEb+(?EUB+/5\B=M/6,/C^a]E3U3-
?70^+\7=O=GT0&P?KWMOg91N)/I#S<ANgK_1H6989N[ZeQc,Db[)J#c9FPFY4LJ^
eLI2b;,EU3#9>C;S5eQe.+S+c948CL.9/J.FO),397C.OVCCa95-F(bZd(R1MV<)
6cVcQ,:WCd?ILYD^T0:8E1O+?>RfHA\DDa:(:,MH,-];.1[(UYHLA;F,LNZN4UN&
5-B>HDg?E@cE4[.dL^]T\Fa8&MeM=0^Y<deY;1dDZg1V;HW,[3)g#WX22c5)6.IH
6DI@=?cLOe<Q=-L73_f\H(P@EGL?SF;/?6CE7f6B8#MKV)]XGfP\-c/PEMJc;_+4
=c2dW_N<B7=L^,E<a^Ne_3+/fcG(L;^^93/_/cK.97;L)##/=78\J2XGdO(0<>8E
O9#UY7GVM)QH-LWBeZ>P2L6C>f+L@S#KPBH(&LTABfK]U.YC/&9]2^=8MDg^?LD2
7O]X?T8TH@C;>fW/_I+7#-350X(-,:XJa\S:Ca<^I.UMW#&:TN-GZCN&QT;f]aMR
#IOQ,\5J,3_D+g86JIW:9XgJ(,>\./+C,#e8gfa/U>g,D7+_X]=B=M=Z,T-__7f@
:Nf<ZG4S7:=f9-(ZRIfU1.I7S_J8+?7)de78QVB4BfHg5XVHb/C#EM//(Bf#L#Wb
;d,B<gB)?D&-M,(=7-\^.#;cgOG\[>BF]TVQ9b9T-L+X<ZZ_M7N9g_-6-_P9BOM6
4Y#AG]<&U#PZO;10?>ZUZbX^C_4EP739KH\-T_8fI7W0Z#QCNUIB5&Ue)])VMQ,(
2F/?REdBQPb?([9JR?a9R?J^Zd,8@K;HJ9g:2b8g[?][N=dVLBf21CHXTDXC(@&&
R0E]\/4:V=:7/(\&Y/a\gcPCU\\);2@+.B#\1V.4OMCECQWL?71XVG1I;4PSI4aL
K7Ca>Q=65#;/UG@+LS)X9G]Z\3e>07NS0CKE[B6)^MUL&[2T=14D@9fLKbZ55V1]
?\R6:@eINUEA5(AD^g->BMEP+faYGaQFdBR80#V#8<YE68+\K938#e]?E=PNFX)K
Y:ccB@KVNaD\TdY[M1LU9Y:WH=7#=Ob[WO?-X+B3IU01:ZI0KAXf/\7[&YI8D_#2
@e#8UZ?5AA6-AGIX]9:aVG<f^5g=24^M=G2aeZ[G(GCOM5=^^,F7dYCb-215Q099
(/3Vf3J/a=Ug:-ZYS?)Q.WW.FZZ>da3;AH)JgF>OZRAQT\dG1TAT/2FXLY:0RC>Y
KGfKf:Z&gc6R25P^.V8^(Z^)U9T-NPD6]X15?=(+1=Q;<a9@VUK)7H(B50CZ3a@C
>Y?D<5))-=Z;C.g#ba1[H1ad;\L4[;(52ZL<RM/d,5#FH4FRYES.8TF<NbGEJ=MC
SG/MATaC^EcFT8]W:(X>HG-TF7.OO?FKS_5]AFb;2Gf;RY<VR6/I(ggQF[N^0I5S
7UV(C9FD]Q8CH08\CPO7SIg0P8.E(G_P]Y-4?P1@=^_PXE?bF\\Cc4H4<AT&.ZQN
E&5\LK9X#X]M@ggE\g/=2BMQ?2=KZPGGUWb\?/:1T/<:EFdS\>@#B?f0,=&X+6HY
&-1[Ca(g)cWBL:L\R2IPI;V^[X4#E/<f[[?BK)bdYLSNO<\/)XDW,.&TgKNbR<C@
>e_H)CZ.fdg_bD^Y\Oa=879fT/_V9AU7]f<_LISE_2e;BP4&Wa^A&c;>\ACA_aF]
_aRPN;ECecB(/Xb&F-<I_[9-OLNER==1V6@H]XU7;7&^UXQHSaR3f6\X6fB(YL1#
\5UWH[[?Z_0(ZV4?dR8W_7@-NDA6-IN.(,Y&^NI19,_c)bf&&2_W#e7D?0]>JaTM
gA_<.dd\_#0=0U:,E3S5]G6^8>H1_V<D3E(CPHDR,[8GZ/L8R@FAZ<_g&(:_S56@
^2Z66F:@IQFUW9;HWIW6CKV+CVg;B#LEWK\:07LD8EU]H(4GFcUOSFfKX7S#FS&2
dT.eNK\#2)fR38cK_3fM>>/R?<F2^d;-4:M8M3S+Uab:6[\eIg+]=^>4WY)(e[J^
bbN9L2<R#O_dIC6,[=;\TAU/C(7RfRbTDQNc(ZNeDXU:Y-E9e4(=:)JB_g#&2X4_
1GfB,K>\5g=4[?:>)Y^7V2Def):RPZ@C&V<f5<=[[^V-R]/e\W@>ILFGZAbd2J>-
=(:b>Z<--JITYBX2\A8e3SP?LWb?GF^9gLHVB@GZ0d\4\dBD?,B]+@fIAWLDUOZG
3IW3U/.#>G4OFDP5]DZb0)\d60fZ@aG1MS;KIB3G#&OQD.A\,)4QgfJSNHffMI+A
/&J_5.T<DHP=._JXfO1;F;S[5O</\BX=6\)^8L]fFV,dacVN\e;c\5+C#MUE(P&>
AgTKWIgG5gZ00/<VJIP\gF)IO2e2]95L-ST.a8;N-&O;:?-?K3#Jca:e8OCbBAT/
&&6J/OI.M/HA/^^eF+ZEa\AQS.J0WPXOU3ODe]OC&ZDUFV&.W:R)LEW#UHfZ8&6b
+V=LaVA3BWA=<@7DeT6:&T3NMPG-YH3]B&)6bMD=VaX#Z.>]]Q8,DF==V3R[&H0W
8(SDU)bYZ6.]#TL+-X?Z+4OHK_?94R3I@$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_MONITOR_SV
