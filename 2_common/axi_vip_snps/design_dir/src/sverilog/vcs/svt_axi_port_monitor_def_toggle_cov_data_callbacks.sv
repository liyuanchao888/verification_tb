
`ifndef GUARD_SVT_AXI_PORT_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AXI_PORT_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_axi_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,axi_port_monitor_svt,R-2020.12,svt_axi_port_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_axi_toggle_bit_cov ;

  bit signal_index;
  event sample_event;

  `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_CREATE_CG
 
  /** Constructor */ 
  extern function new();

  /** To get the signal's bit position to be sampled and event to trigger the
    * covergroup
    */
  extern function void bit_cov(bit b_bit);

endclass

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_axi_port_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport) extends svt_axi_port_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_axi_port_configuration cfg;

  MONITOR_MP axi_monitor_mp;

  /** Dynamic array declaration of the single bit coverage class for awaddr signal. */
  svt_axi_toggle_bit_cov awaddr_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awlen signal. */
  svt_axi_toggle_bit_cov awlen_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awsize signal. */
  svt_axi_toggle_bit_cov awsize_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awburst signal. */
  svt_axi_toggle_bit_cov awburst_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awlock signal. */
  svt_axi_toggle_bit_cov awlock_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awcache signal. */
  svt_axi_toggle_bit_cov awcache_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awprot signal. */
  svt_axi_toggle_bit_cov awprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awid signal. */
  svt_axi_toggle_bit_cov awid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for araddr signal. */
  svt_axi_toggle_bit_cov araddr_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arlen signal. */
  svt_axi_toggle_bit_cov arlen_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arsize signal. */
  svt_axi_toggle_bit_cov arsize_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arburst signal. */
  svt_axi_toggle_bit_cov arburst_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arlock signal. */
  svt_axi_toggle_bit_cov arlock_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arceche signal. */
  svt_axi_toggle_bit_cov arcache_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arprot signal. */
  svt_axi_toggle_bit_cov arprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arid signal. */
  svt_axi_toggle_bit_cov arid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rdata signal. */
  svt_axi_toggle_bit_cov rdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rresp signal. */
  svt_axi_toggle_bit_cov rresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rid signal. */
  svt_axi_toggle_bit_cov rid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wdata signal. */
  svt_axi_toggle_bit_cov wdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wstrb signal. */
  svt_axi_toggle_bit_cov wstrb_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wid signal. */
  svt_axi_toggle_bit_cov wid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for bresp signal. */
  svt_axi_toggle_bit_cov bresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for bid signal. */
  svt_axi_toggle_bit_cov bid_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for awvalid signal. */
  svt_axi_toggle_bit_cov awvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awready signal. */
  svt_axi_toggle_bit_cov awready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wvalid signal. */
  svt_axi_toggle_bit_cov wvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wready signal. */
  svt_axi_toggle_bit_cov wready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wlast signal. */
  svt_axi_toggle_bit_cov wlast_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for bvalid signal. */
  svt_axi_toggle_bit_cov bvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for bready signal. */
  svt_axi_toggle_bit_cov bready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arvalid signal. */
  svt_axi_toggle_bit_cov arvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arready signal. */
  svt_axi_toggle_bit_cov arready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rvalid signal. */
  svt_axi_toggle_bit_cov rvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rready signal. */
  svt_axi_toggle_bit_cov rready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for rlast signal. */
  svt_axi_toggle_bit_cov rlast_toggle_cov[];


  /** Additional AXI4 signals. */
  /** Dynamic array declaration of the single bit coverage class for awregion signal. */
  svt_axi_toggle_bit_cov awregion_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awqos signal. */
  svt_axi_toggle_bit_cov awqos_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awuser signal. */
  svt_axi_toggle_bit_cov awuser_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for arregion signal. */
  svt_axi_toggle_bit_cov arregion_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for arqos signal. */
  svt_axi_toggle_bit_cov arqos_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for aruser signal. */
  svt_axi_toggle_bit_cov aruser_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for wuser signal. */
  svt_axi_toggle_bit_cov wuser_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for ruser signal. */
  svt_axi_toggle_bit_cov ruser_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for buser signal. */
  svt_axi_toggle_bit_cov buser_toggle_cov[];

 /** ACE signals. */
  /** Dynamic array declaration of the single bit coverage class for awdomain signal. */
  svt_axi_toggle_bit_cov awdomain_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awsnoop signal. */
  svt_axi_toggle_bit_cov awsnoop_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awunique signal. */
  svt_axi_toggle_bit_cov awunique_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for awbar signal. */
  svt_axi_toggle_bit_cov awbar_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for ardomain signal. */
  svt_axi_toggle_bit_cov ardomain_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for arsnoop signal. */
  svt_axi_toggle_bit_cov arsnoop_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for arbar signal. */
  svt_axi_toggle_bit_cov arbar_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for acaddr signal. */
  svt_axi_toggle_bit_cov acaddr_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for acsnoop signal. */
  svt_axi_toggle_bit_cov acsnoop_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for acprot signal. */
  svt_axi_toggle_bit_cov acprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for crresp signal. */
  svt_axi_toggle_bit_cov crresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for cddata signal. */
  svt_axi_toggle_bit_cov cddata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for wack signal. */
  svt_axi_toggle_bit_cov wack_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for rack signal. */
  svt_axi_toggle_bit_cov rack_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for acvalid signal. */
  svt_axi_toggle_bit_cov acvalid_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for acready signal. */
  svt_axi_toggle_bit_cov acready_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for crvalid signal. */
  svt_axi_toggle_bit_cov crvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for crready signal. */
  svt_axi_toggle_bit_cov crready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for cdvalid signal. */
  svt_axi_toggle_bit_cov cdvalid_toggle_cov[]; 
  /** Dynamic array declaration of the single bit coverage class for cdready signal. */
  svt_axi_toggle_bit_cov cdready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for cdlast signal. */
  svt_axi_toggle_bit_cov cdlast_toggle_cov[];

  /** Dynamic array declaration of the single bit coverage class for tvalid signal. */
  svt_axi_toggle_bit_cov tvalid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tready signal. */
  svt_axi_toggle_bit_cov tready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tdata signal. */
  svt_axi_toggle_bit_cov tdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tstrb signal. */
  svt_axi_toggle_bit_cov tstrb_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tkeep signal. */
  svt_axi_toggle_bit_cov tkeep_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tlast signal. */
  svt_axi_toggle_bit_cov tlast_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tid signal. */
  svt_axi_toggle_bit_cov tid_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tdest signal. */
  svt_axi_toggle_bit_cov tdest_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for tuser signal. */
  svt_axi_toggle_bit_cov tuser_toggle_cov[];


  /** Constructor */ 
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_axi_port_monitor_def_toggle_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_axi_port_monitor_def_toggle_cov_data_callbacks");
`else
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp);
`endif

   /**
    * Called when write address handshake is complete, that is, when AWVALID and
    * AWREADY are asserted 
    */
  extern virtual function void write_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

   /** Called when write address handshake is complete, that is, when ARVALID and
    * ARREADY are asserted 
    */
  extern virtual function void read_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  /** Called when write address handshake is complete, that is, when WVALID and
    * WREADY are asserted
    */
  extern virtual function void write_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

   /** Called when write address handshake is complete, that is, when RVALID and
    * RREADY are asserted 
    */
  extern virtual function void read_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  /** Called when write address handshake is complete, that is, when BVALID and
    * BREADY are asserted
    */
  extern virtual function void write_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  /** Called when a new transaction is observed on the port */
  extern virtual function void pre_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  /** Called for toggle signals when a new transaction is observed on the port */
  extern virtual function void toggle_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  /** Called before putting a snoop transaction to the analysis port */
  extern virtual function void pre_snoop_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);

  /** Called when snoop address handshake is complete, that is, when ACVALID 
    * and ACREADY are asserted */
  extern virtual function void snoop_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);

  /** Called when snoop data handshake is complete, that is, when CDVALID 
    * and CDREADY are asserted */
  extern virtual function void snoop_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
 
  /** Called when snoop response handshake is complete, that is, when CRVALID 
    * and CRREADY are asserted */
  extern virtual function void snoop_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);

  extern virtual function void stream_transfer_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
 
endclass

`protected
eUag\L=8d];E^M+_L+#R9&INPe/7F]&/\KUY;a_-a?O>fTedbe1L5)?KO4CBK^Db
2f\H_WLQ8Hg?5]O]7c:BZ//T@G/IT,L-ZQ,Q8ELfNUAK?:_H0#e_<cP1TK>\AD5f
_g<4XH,6aKgW4I/0??H0:2@P9+eA&38,>VQ>M1&SJP&H#f5-MP-c^V?.21CJd\;:
Ea(T)aT,)1bX0C)1R==6;[bZPd:9U@G+?<>&YA;ONZ)[4_<cTgYYFKP#2XA(6I&Y
UHGbQ7L>LH9PO+;b<]4Zd?CW[ee(LBUgQEIG5R07+WC64BNRVOP152R2JJ5M+]^b
Of:Y[aZ/UT#.6:XVC(D-2>)P4LH?V+P&9a&G>LL&#]8ML+E]@@A^Yf9?Ye>\SY?K
]Kd891,OfQ<6DB1^Y>L6Z^<)1JHB+,&(M1c,OI3M4GQDB[L<6J)QBeETIY.,-VgP
[S@)JV[V2;MK@S+>&aFd,D^e^+WS0gEQ29NE(\+2,#.K<GcNA7UJ#8#4bA+QSgKI
?Fc0FSBc1N\J/7Y/N<F\Q+7=V==OdQOMNX1fC=aD_GSKHHYM2.8Q-dEX2cM]dPCJ
)2:^3FCRM5ETUPC59SK,BPNB+S=[-[-:fG-N3HK/N\]J]3O\3A:H(C;#(MdN7XBL
\3UV&#aJ?OWM=gYb#7:->W.6,f+IUa9AI/NE\E8Y^3-NGg?cHgaL(a0DOef#.O&-
R9Q?&DCaaGY]GGIFX.T-3d3a+#T4DCG9bN,M?fEG-cR&#Z5G]#SDB2]dBMR9(4[a
(cIK@CaCRLX8dJfMD-.D#W5Y;TgVaf_6=>>6;\=?6b>\ILFT_O>=I_#;^/PIE>a.
1TgW<FG]FgS?2)X8]A=?ZZ#VE8,.9F<V:6;d5a6MS;@Dbd+5<HSgV=LI9@b/&S@-
QZ&I3+c-[AZ.R3LNY?B6^B:]f@LgDY_R6AaYZ;;BT4WWF[ffG@L;Y1?WKNGSU:?I
GUf@:.9]4D)953;cKgfW)-a+Y<E9_@?<,+2AT^Y(60FF5WF7-=XCB7)0H([BJeO2
QI@ASNP06e8<f(&F6F\8Db(+?JWN\CZS@-_KUc[.[ETF>=aI^1QYeC]\ce^b4M)Y
F#+d\@DJ:():,e5^\<1O]0X/N#W1K5cSbSX&^W]XC1((1NMU6XSG&]agb-Q^ad^@
GEFdE(Ec<HHee[4<,=V?-?8=L=VPX>+Y^WaN^c3T/,-b?F[Q?#?>:<3OPUa^fXI^
eG>N3BA27bU,b#d5O6-,<a9W#&CT&4-d(CR:2aGRCU[&dN2#cb_eA&a8C3P90@&@
7b#_H5657,DMeeKg<Z\\@R-f&d(?+W3[Y\\3gP)KF&[,&c#PSPe5[F)+04U^]C.4
MZ0KKY7JgZ\#E_.WYPXg,4;/KBWW4[:^-cR05Y:#RAeO3<>Ad,FI?dL2M#L9VA]&
(3\DX6e=g2:U/N9(8E+LK<]4_S:UPd1bKH=Ha77[c)X]NRE0fa]DO\&fE,XCO^/9
6<4-ab:][aa2f#fb?PX9?\d]8F.ZOL?CTJ(/)AGAB&\XYc090ROJb<^5c0aH7._8
C>@/]F?\,1.XU5]CUKZUL/SF#[E5.;:IT)Yd8&<MFMgQF:/D;g1,JTcMgE3/a<Cb
DK/VRXLfO=07Z^YFFH3R&;U4XXcK_N.bag?<(CH?+NL100#<H<#0Sb93b(#E2f]f
?_<S>FAJg_0Nd__MaZ#ER6C41TF.E33=4e.;SE:58U+QN(6KHgM?;aFWRE7C8W@5
N@P(V_T)Z^/\,]]@c;eMA-G/?,Q)N0EE=R6e=FdICfUYbL/b\M;A<_9cJT_/gMLa
U+0#\NgU^FOH?gX8V5R<,,e[3eZA&O;TG)N+I)b^MOYe<ga=34+?=P8VF\NF-a8D
e=ddU=6#4^Q/fRB,A;>BbK+8QVCO?dNBCO/RB?fX=A6aF3bdP#?VN=b4E-EVd/@,
1KgE5VLYFfg65aMG&<dgOO#9(05;63/2@^I],G]gX&FV5@0SK>^-OTML3+W[-<BY
bg4NWe,=KB?\J1]T/Ge4>SU\/P>:4MK@b^XNYbVcJ4aLb;\HLH-EBb^R1=<6Q&\d
W7<T;b]_\@I:/HQI\HH0MNAf1d]2e;.#\8I/;cdMTG^Sb(#,0_[[<H(UIcg6RE6#
ZQ&/6d>Q#PF@Q?NQ-BO[2O,AR]KF+V1@>&>SObeb[[,J,NEc,7EG^YAGU@[NXS,_
/a?AAD7HF#=0+Q.06EZ699>MZ>#ULfSae(6@&FVFE]XJ5N,f=ZU#&Q?/YMP#RRB7
S6fG6E4YJ6GCb76PR6O)_4B9L]DI[\6W>/-^G?N#Acc83MN0JLB/1_R:GS]7,B90
WO<-8JD?H1FF\9K3c?20AcbH=[fNbDYHY5XL<HCG1abXJNC&_d.,HN?W5Z.9?5_4
W1.O-O0:C0e=f0EJF6U3d5+fA__gbRKPM(WMacQ+H10J\c+HCd(LI507:KV5WAf[
N<D_K6/O3(N/9JZUI5/@2(MH[_NGOaQc.O-@7C04PgeAa?B]O/2,=5+gC\/VI8T)
@;T+(H-Q2?]R4RX,YIWd4FPQ)M=A)+^+9FUe[#,T(?I5I[<O#XOJI(Je=5AE<-PW
E;(X=QZ57FU^909K5H#^NM5+LH=5[gO>SVRa_MI2N;FeWgD>0bb2K)WE=7]=d_U>
0QD35f5Zc1U]:_?K02NW7=<dVU+I2-fQbd)_\GN]A;:ZB+AF_@2R=1XJ]2T02ORE
Z1=OeP1L21J@5_4VOQM[D.VK8C?4ePKB<Z0E1C&P56\,URe7,eLJ)Y7;L8TRcT^:
(J+BU-8(7,;8J0./4ICAbdI>+X\74+E+&:C88d&F,10A&0WNOc-;;bSD3I(UKYY+
[BZ=a,g9Q5,f;5BWJC/K\b>)3[I+)+LJWLQN@a,_PQ1HAdC:becUC2JU^6cPD+Fg
TbE?HP0^ZY#QJZfb;3J].Z.9(C,ZgfXS>2<8Fb33FJ@e1S6[M;A60[W30PW62INf
/D@N;@/OF5A5+=MC&+SV/&FKdQaU(,-d9MVO/B]4AL&O[_-e<bI2LM6GQVRAff5a
@eS2U?\.=+,GJcYGQ82DOfIDU:@YF-R^d/FZ5aB+M+GH2+2_09(3KHY329\J?#)E
+RW2^^W;Y6V9UU2L(PJL\C+dP^V3:=bFZF-3M9eH]W9=aL_:M\TLf\#[TZg,b^P3
9_f]KdA+>S\@S\3Qd(4AObgXY1[8V/\.5Wc2B#9H#?3,(?+?)AMEK9TWQcJBG@W,
W5FIKXg2LXg_/QFa,JbIc8YPO&_@824_(YY0OXO1WR0NU2HYV2C?37U;Y;5DLS#-
b1V8FI\&X&3SN(&Z)6\d+/-/b:&R>?QL>7IUQXK);?OVM?OY3G<(>fSRYFMCBYDI
HZ\Q3M72^-0:Pe+<UJcPe@]c-A:)fN_?d5Z=<d_FRI],(G>WZ?I-O+bA#>:ESGS#
YdZBBQPK\9gb=N,P6RJEe^MMMaDd1D[R?:F,ZK^/RLT^JPfQ:NZ(0M@[b0#EH?6>
5#6YF,IVUAZ+,H2<@]a0CFEKJbE.:cM,_eH63SF]/Y?KZC4/fBfATX]TE.]BG2bB
]&WLg=IRB6&2KIK>CKNB-11Ud/_d[:;Nef)&[McTf70^g=Z+F^DF9AX<Z,&g8_Cb
SBTO?I:YSS@)G13.U4(gabZ=#&TR/>Bc7Q;\LH<I>cI6HUg\7@c_RA?U58RW8Z/G
N(_[K\MUB&YE9Wg#TZL_fX+a0YZ_Lg_.d+.J(]33=Jg2)WN:>[E67afD+GQN5-RR
:)=\1(&fdZ014,;a6GWec8#5?Q]/;<deaadK-XUIcWA?(d>HBWRQT_:A+JG2aQK)
728@F_OeA)WB7^7b2Y@U=F<ZADa9R7(8b&&P6K2#,eH:LM4_Vb\?0&/BLXVMD):8
g(<b4,AK3J&>X^7_WL,\Ne)=fVO@GZdI^-U,?]d1.MCW3a(B;9@SCZc<&AS4:NCK
1(JCaP_L?ecd>C>?L7>R3:0+dO-f8+,@?KEX[)O^4]\9V<CH5)fcbbI8:(Xa>cTW
Xcg.HLP\X,B74IaO01(K2M1aBYf3EIAM3HR]G0Y49d3b(VHc4CfT0B7]>8#CU]c7
bJ3<ZKI60>OLDgX&S?e;F+(JPOF>Fe1?/6\B(.ggLffH+U(XG+JA4:S<-3,c8JXe
9M?I-QLPQCG/K?&G<X>gOFK(?WS2U#EQPZ>W3>N;7,L?/H)8Z&>e&?9MI04+&I;I
gcQE0=_^=6[T9D33D]M4B4U6ZCEY7PGP#eNQ:(.:P#A4)O.-=dM.A@A^?9f,M\)H
2;&-DJd\Fd^HS;Fb&]>Vc-c_YT7D[8XCV/\@;5T_MJ3/&5_:P?8OeZUAY-D#EO=Y
fFFN4c+F.F.5OWS=JY6[UV]]Z(cH1Wd\39?C+B=HMR>6f+agcISBH3/<d26UFN5M
S#&<,PgL3FG6I2L;V:?)Z2X+XZ5-aW]L&MZ5e=HJQfbaH&59S^-gLd.<J&DL3g)H
cNH9[]8WRbN+M\Q4::J34><ZFg5]AdTMSTYFFCCNdU(VJD\gH6)<Q)JR;PB,8X@R
Qf29>5[d<?PS@NZ/>B1FG-G:CHe1]1/7)^=T.V;AT1eIF8Z_,CaMY-aIZJ[+R0V]
eZg?fBNgAO0(W(59=b@G>XU&0P5C:FdVYF\DE&UR,)IE78aA0[HF;<.SJC.Zd(4f
E,C7b=V_^>bc]NW2b4M_:ca=-CY\S+N\#C@>EG/L4daARdMU?3Y6P_(YCbS^NeW&
dJO3:NK@I;[1YECe1&(B,e;#2LN<<?X&deQF<??AONKXPUMV-B-NHGGAI1X_Ga-+
YP\;+11_PUDT6C5FT>O415CC(YYMHGN<D8YMVVe-==TAB3VP[]Ne>c3K\6a/87)D
f.YgB/5K]/d#TbgAg0Wd,MK]]&eA04:O_=7e&e9C+<;[0P8geFI\K:+-&6K&V</-
-T8#\-HPQ18bJ0\]VaEG;5N?J37+02M\IcBag]^5Q5KUd1?\B:?SZA:V.>[M#>JM
D.12fG2YdQ;fW7[DeR-C^FR&7>E7aSCPK[;YE)RX&4:H6=3RJaV-4O,8)X:E:R?O
RMc7OXHL#_X9T0d/geR\?)0DV6=W4\FO/XS7a[K7F131\7?_bR9JT3f8S\C,J786
a5g:/9TSTX?M_=0=)<c.HFefUPabJ:S]_JTL.FTdfaN;C\G;LV)FRbWfMZ6Z^cD5
7PMKAF>/ZdcPT0LCG]5cI<8?DFV2#g6P0-R#B5+.Y,[M/MS+b61F,L_9R8db)^#A
Y,<)PBQKdDNA2gSfIU,8E&TZ/8.a#g8OPTBMJ<-CIZN9).W#S#;7UbY1)USf=DP]
UAfGZL#0FTTYERZ;TAKC78GAE5RZfM.F;aW]K^8Ndd^)XP]<U<.&\:eBD]aU&<g-
Z-Jc.QT4+A(C9Ab_ZKUH6<e,D.[U;2ea3/^-bAZN)c9A-C?/g4]X-_cd,,7gS9#[
@B6SR&09TZ.TO</cE..BGK._@-K)5F_.XfCZ.6=>5<=,9fLcf^UaR\1?3/ACEXAI
bD@[f<.2_(+\G=?+V70GO<C.;U@PN(C/Z,<EF.7&2UcMgXK28;9&E9e+^[=XGOV0
V>3K>L#b/78FRG>G:\b[>bMR(=\Y_=,<faK9(Cg]N2:CRNV<N<_fWPG^?)<A4eE[
]Y]->)3:V,d+?GM_P/O6]_O]5KI@LgP1ULH/:Q1&&GKd7C)>38(f=D#Z),51CBId
GaZ9a03Q:_UCXFKg7]<J69dX?(C#LVb299?GRe@_@(EZB_g:@X(K+4@ZXN/L&_Ag
O&5eb-OL>:9PTCD0=HcFM(5c\,1d>fMSR,04D<N)d42)R-V<@P#]@ff>VQ=U2#_f
8P=>8.:dB+7cDEeU3(fR_>+4N+CU>G7825#+[b+8bF?HD#aU[G?/&28D6HU/e\;^
#<?b](cA>)HTI^\e?9XK+)FE+:D/6YAc/gGc7aOJZJ5C35CFaVMOPJ>.LcOWKaRg
7c:F@WD4Bf6#JU3Re/.EaLOe<dT<?7]^eHQ:Td3?M5SCe[,HfbO(=F?;ZZZ#MCcg
@].WPCQH)>>8DW/9Kbd0X;HFNBCE1ZEB,6/RCBbCG_]<D5<VI#96/6_].<G,#:?4
AU?#4eOKR5)AbA;:J/62MU:;M&PIA,5EEc/_AHHTRQ)NM7U4@@](F\(CC8&8[QG_
C\;7=785.L9cCX[CJ7O].K]dW3aZ+f;7N4(::L=V#L<)R\Dg=2c9?WL18OPGL30U
#IEN9H+ZCfLQ9ZRAU(K[FTOdg8#cg2SP#,\KTa6BSJJN8T=<GA;fd@^-T?O-=?=K
B5F.ZALQ(:a^#eC2EOC8a60UBMK]LB<c;_5g1/EWId]K:ALP0Z4B:,#(ZWQgV5(H
17eTe8d(cSO,9aQ:08#VUWJYZ^@8^DH5O:-QYd:0/?e?(E)FeSW6;]-1ZD59#^JO
H.6(S^DFf[0#H.#=48f9gLF8XI>-LQ02E,4.7X:^FO+:#Zg2,eZK1Q/9=-/d(^CF
RgO]Da[9+YC.4D+U/:I12)&HeRB=_C46-,H4RcR]I5V60/a3@YZ769^8dU-H3.cW
V&f^f@1QN)9_>Y5FC]N-/GAM<_P#:22M&ZQWCAgHC3;OD?9I3-F7<DM,NMLV^Mf#
?,@8?fL#3_\F13be96A_9)OH);2^BG:BLJ7+C@M6I:N68EZ@AHLLQ@F2J.J,g/.W
Pc(@+Y+Z0dWE)T)(Kb(d1D>f(;1R.e2A#,.E+#dV,S4Z.7&DS4:AB96c44UeZ1?_
G(Vd9I/4\XgKa0X#P20>7=Yag#YZ+GgD_5(:#-CQ7dbK9.8\(,JAN76RE1,T4E3I
.ZDJ=g9;3OWaV\9@MARH5IOfZb_c7-759/Bf;^28C/ecgYP3M7-8PM)91F]^.>aS
MfKB:UCadW+4?.X^XM=&,T;cJB#G1/\+Y9S/P[eKA9MDS=4.c-^d5,V:-9[RIAeF
+X\6<1[gS@J0-CDYI,:&eW\Ce>Ic7^4=KK=b@OC+S;cENaB<a>/AD8M=7)I-L?CJ
>56Gf:Hgg#;a4@SgbGbb1MD63N-XK;??4;dE&U<,-]M+M+N#3/+IU^]^1D]=,SB[
P6e>KH2MN,^.ZQ?0&G#@#?;fJ7WB8MYH:O&2g?eQ8&2,,/(IYb7.-\AV=[Zd?F[6
WS#9a+T<eG//L/<2J6R9.00HR4cDL-;ZdO35I/bC=LN//,:<7>G>&b>5&#HF?;1#
[U\]D9M[2>eW)Rd3P8BGN(4SQTdS>afXJ\WfIFZeWGW/#]=g+LXH=[V(Q:0Cc9(-
WZWW&D63;#/E=,cW1G_G<7U1b?YX3H9AYf9P,Udb#fX5E/7[g_5YYZ35#8[3,S1+
2EZ#=TUN+\G6E;CS8BH(1(@X@U,)33b=)B07bW\1Q<^MLCE+[MGJ[5GAfXZAIE(L
HGGU#?+_^J?P\)\FU-KMVgI]QL<cE,<:C240d?&]YCR8@WKG7?LGaV.VEVSc/b+;
aOMOH/O&CA26[A7S)4bGNb>bT1b(VU(dT]JN>1_aF=)V,1@=4=NI>:QS_Pc5;]@.
aH1MHSP<G.&@7c0d>0<27UX,8T/e<U;O-(O/&UJeA+QBU316aSbA8b,WVQ:5C]QY
YE??S^D=:60PAVT(Ca(1?@>MY-49A1daVf#M]CB/eG&W2KaY[RHL13b[?.E/UBXC
Ng-EZa&Z[Z<L&96<3gbc.H5fDfLGBb:Vg[^8<eJS?O^8;I@9]#ZJg9:CB28:9)=&
B]M#9Rd>U(]bU)@DA(6+4.S_WM?g9)#+BL-]9\a&V0@SR2ZQ.+ZKTYS/#fb1;-Sa
3B6^00LCdP\8d@V>E\^a(M49>f^,V+]>G:2B/FAQAH4[:@(7]^TPL6L5Be5CaKKM
>N5+[\O-#7a2Y)/74UA761WT<B]GTZ4e,U^DbMBIIKOTPB1GQ525.ERPH^1>P.P?
HcE=>IN)e?6d<,:CS(XH[^f9b&F8aTY\.C+.@(<=UZ^KTF.N9a:=1>dRV2\,^D:W
V\f]2/]DEKcHI/LI&MJ1&e:X79UQQ<bB.R+KAJCN@dP<R6K@HDP]RPX3,_D?RfBa
g=gde6&Bed55VJ,IM(T^=YHWR[[=IbJ1KcJ<A7#@FG<EX?R(/;5WDZ,(8YePf;aL
JS5.ga0_.KCb@6.W,9?4C@PPY:bK2Y]]AFNGM\MI]_-\0dU\H\A0Ne_O[[\>.Q=A
B#:63NabF&g+Og664cQ-fa>:F1]R0FXIGVFHN97](XB,1&8L1(<O+W8]/6DR>\,f
/K.8A2N2TVJM1.Z9a6M\ZE6L3)4<Bf4,9W6bFc92GU+&EJ<eNL^-Z+d[<86f]P:C
U#7>BH76Q\98=GLe;RJU#NAE0<@Q&<Oa0G<(0+b-5bB2f_ZPE-TScUgeC\D)@f^a
)S>(aX]P0R1ffH>16NHVOf?d(:]H;<Ac\0[a=N#a:Q>-0K/XReVKPO[T<b]PF&JM
JY-Va0RLN8<bcFJ1@Dc?fU?5V?#NR2LZ5(\a62f/O]cB]MJH5^H/K)+.DQ>2PH@+
D:1>g^eNcMR7_2@VLO4B:c?^]N_d9:7DW0I8-)@TWU2=4J@,-WWA=>,^ce##[Z].
->.7Rd5Ve8F,:Y[I^8G4SL\+=PgH/e<,ANV)UB[\VILBONG?0S98MVX^_DUG3b>S
2-\WP:cC&O^86A/VU#R-M2P922f/.>OMd-@daXGQ)C@W(Bb[@?^Q^<;XCMC;5S;Y
OK95J).C_+##cTUI9Z+OE=<bZSd>T<^6bCL-3-MZ(XaQ=+J7_)CZ)B00NV:;78&-
0A5KP1@Sd:L.^d@)HG_bH3<J\XT8KY&U8T9,_cY]DS^EL>ZD#IE#&e@?C(W@Y&:e
-f;g>2#IeFd.:,S=/MH:)NL357U]cJ91BM1.>BQgX).S\4DYC\3B6/G,b=ga#A6\
A7?5]>:\BTE-(-;C0+WL8YL[LM9ZQ2KCD\M39<S0@XH6Z-O=c5605,,S1F,)8D;a
A)gTNJX_K+D\JCO@D[dcS;V,@eCbR8Y^YH@S1,G<[8>:T=?WZGCg8++P7^Ob[Z<d
5a5ICOa-:cL\-GXCOX@gKV#EJE1S;;cZWI_-Q=JeCY=4Z1B)dVU9f9?;:LL)F7g?
U\<c:]7.?@.B]ERgNfcfTTQXOMG-9#N)dV6bCaWJM:ZgCf9gL<EV+cfUb00.2[K\
S6b[Cf9AB#B4,^>FVf+cC_MP1+(Ob)d:,^V26S8LV^_Z/JVME-0K[_HE:cQSFO_?
5&?\=eU9T;X67G21N@HHJ[SDQKIS.O,05PX2;G-C[gDJ\S1Z795B)^N3[?R2:N)2
K9],57?@[B.LR?cS[8FdJ>#:DPdL+da:7;1)EPT;+0Nd;,ScE)bOT<1D1:IYQe\L
@(2=PPBAR\[.IB=R5Q:f3DbK;.29Qg=DVA)5a#ed7+80Zd<bW^e)NA_d>Oa1;QM2
W48CM@DJH<,1P/55WK.fP>J3Q&0TbafD,K?g=(@9aH&NK#12GMW5_JU)^W2Q49<J
_1XESGa\K+]OS@cHN)I(b0995T>ZDMN_;.B^DRacGaA3Z[V&\DFGJI6;^+&Y@TED
BgG.D9AOL/&;/>D3c)9P@R4NQ>)@ZE7WC&7_:AJc:(:Ga:M=:G9XLXYDa#cf6VPG
)9<6WT>6Q2YA[\R:NGM#GR8eVTG-H(Y3Kbb16;^aOA8-IKc1WCDW9KAIYEVBcU2-
=VK<a,Wa#TbF^-0W_6(Zf15F[H@1JW<162(OWI#0A+.E(N?O>MDPa<NEF>]0?c_K
VY3Te4YK9G7;=e<T+TKg^+GgHY@NY\Y#^OC4T]Y77L7H?X(SY-fKIARQ6T&+[8fX
C;?>4YPV^,Ue7D;_\[D&C3J2bCR#YCUM];F/>)aX2[PK4\7&&1SX:(J6<7LOAU6J
1P>Y97(eCDLaN.Mf/#bYNB34]>+Q;7+;JSKG\-CfGTL>G8bGGHQ[(NMCXD_]6Yg6
Rf;JU]g.9gD.PBB\R8#&.YZ:TP_UYDC(#][fCFI=HZ4#K^NI,D274T#=,B9d(Ga.
(_gH8bg#CQ;Ff8e:-Yg#a_.P/X=(QPg,BSF?-7N6[]@1O#\XaYO9TMZY?KgEfENO
a_D@YBESbVB92KNX:24ETLCI_GX7D8:U_7J=C-bV>b+2:7A,)G-VQAN7)#e+K&)&
#A@04aB^A(N#X]K3V=(+8IC+4(VES?Y4)e)IF:5J9Ye8e)7O/V>GaFSf0T@a)]\3
X8OgDGV?56X>=Ub7(B:5YVFKXR^aS8_Mb3cC,3+AGPO&T=_2RcQOP9eb-[J0)VM(
Q<L(^C^P<KG^XO1MQ#)<[]8b[++9KP=P6)&:#MO>GKeUZ>XPe6.>eORdFJTfFIL8
R3&6?7&V#.9YJa<c+^af[a&a=2O:(R_JdKca-2I7#8/;OKLae_@g6MYKUbe&<TFN
<?Fc59e4T0SSL38/MN3cN@:@V0d>D-;H.\\gH\.B>c\]dOW2D@]d-(U9FD<1#VN&
STfV:E?4aE?[>9U,C]([+5_ebefD4+aeS4M7KCV7eS^&S2=BHNb?K;]VN5=X21;9
G+IM0=OWHPPM)-LLc,f\;U;>_COGML+D4_9+P>7B2)&U3e(IYF&HM.HBc@LQbO,e
&=KfVPD#?:T&dX)cW/#5g>,853:gBc)T9TQNR3MR.Ce]d9UKD1-8ZY<M77PGXM;1
Cb:a_?:?P@Yc?3>(>?T]SGCNfPZ2_3E^=Yd92-Z&7Y1T.-/c[0G2-YB]OTEPfS5>
X]^H,[bKIU79fX8YDA9QN=BZS1:FD7JV.P49BTY&S)3bKTI(RJLI<HWPZLXMDE\^
/VR8^e-\bQPG97O+Y9RERBBA9Oc6++N@KG.9F1egV(;3]8?\Ye=_S\:CK/#)PbgK
#@4123:R08BWFVDJNQ.Jb0)LZ5[DZ_cT)38]\Mc]L@^>b0)1\[;GQeAJ5(NLB0&8
XH?6fe\0CI=ZgfKJWADMeLc.,F19BNQ@?YA<<#2CeJ=Qc5)>8I@2^F;EJ&6UH@?C
&TgeG<+SB2e\GQ-e]TgG7G6IXT&H2;^[[39(:F\aYX=+)#767b-V1WN6e0SXUD(4
XIe?eYP^;4.+#4>X\5D@SXeUC\FdIJR_RfO9)#^Me:H_[2@D9]M(dR,_Xc4]W5I3
E]XOG+//e0d8])ac/,@[=JTU>E.Y\0((DX]SUeW=<^=W20f=5]5;8;BGgU,Q/DTe
ZcHf#1DA=aZYB0PIRL#\L^bf(8V&(VW6_BGASAIg^]J_U2R])T?E-9UE.\F<+1>e
SdLOT^#6N-?L9e(BR,d>&_#XVPIVcEXJT-9D0Q1dF]4T8>?K[OD(ZHUFMU,Za/[[
(@c>LM@C8;X]24Ob)[B#JN<acXMZf;4&-N)f<CLE3BfN\8KgMQ08C5bJX6WQa5BU
agWO.\[_&bGBWg]Qd0b;8.-e.J:VLbbT50HH73SC/@QPM58Fg_R:?AE8T87P<6aF
2R<ZM6aUaeY9C0TD,(A0VDQL,TMZLDXBAA+]:U<aB[FQN:E2L)A(?O^RJM\3gdZL
?#;S0.>2B</)?&@:O)3:&)R-QfedK@NBEA+.3@8FZXZ)\BF+-8&\&e/Deg,8g&=U
gZB^aMT8<b@4A_4X3Ce=)b-e+TE//IG<b&K?7LEX3()_AE.TU?f/BRSd[LQ&-S_X
+[.gM/(=BbVdC7D#41,HI-3FY(_3G<3Ya8K/eK5N6+Rc[\YbEV(O;C5bbG^CcbLc
URD(;WJEG22GQ;F@O66,(5W2_^7P4U329LG.K.M)Rf+(+K<J0:8eZF.620^_U,Ca
+/Da+bg+b6Y@]GF<g:N?\SGFC+OT4/g5WZ5VS?^-KD0]I=Z\)-La?/.;RI?:3YgQ
Q;S?9eBE?&:V2E5N)ZY1NdHgK8:Xb[BIA3+&&bGfBK#,D-=<I1OF7@.0[SC.WQ.I
?\bA/gc._J9LR&#feSAJcW8^O,10F_WW7dS.([YdVVFVa,VVQT[7aTGbIcf+bCf?
L\#Wd^[?9^HZ4L_=C<9b+6B<6bbe@=O8M[3d:=90QYL[Xc[aT+H5c]\d/;^Gf<W]
<[4UW@c-FJ>F&_d+MfG[UKQT[AK=,6<<#R?IZgSgZce?=A<KFKRdb)HSQ0DCMScR
/b4M.MTI1UJd(=_a5GR0c<]&Pa&Q9e2&4#@4U)+::M<6P-I,3]>Q+-Z#FgJ(=2Fe
RdGfPUOW312L3d8/dK_SWEQQ?,E9[,@(;3Q:<-_PTP<ZS/g_U0c,TAYId@J,4P=@
IB<C/:,6EM&Y2&e53K+3TIGTd).7V1,Y[e&0+>-5OCG8f71;RSW9_)Z&(HRgQBX/
O>JFNU9Z<W6KIf[J&D0CIT9TYU\0/C,R;eLbOA<[1fbF10Z^GZ:>@[_V^_/MgOTM
^-]TN@-#RQWPdJb:]1DBQ[8W#W;OQ.,TT^eD1J8-F6BO:.\QT6XN;6YL,4@:+g52
VF6,V#HYecN:U&SDJ-?)3e1O>MK(J,-JEL<M,HQ@___B;8Wbd25GBXJ3N7E+[F38
(PR9JOFDgKfcNfJ>]AFIOWN]f[JN@_,JK0D?V6c.:91C59L-1WdEJ]G.gN6-K_&E
T:fS13.1+DNQ^2[#;T8gLdO:aab^AgP9#/1#gC_f#W63(KEALPH@M7dfWe,69TM2
Sa\?[T7/:aPAF,-H>3S[UGH4]T#1X(AYc63SU9U0L201(1+^f@33NV?CFb?D2bG<
.DL#A^<2cU)A-53\P4JfgT]gCDdI8daGecZ0))/XPb(-,@NSB(Z;]f3DUZFI:I5+
5M^.8Hg,e2GIR+X5:?KX[)L5BUHN0&?LX9(C3XH+/90R\b-@5aY75C3M<#0;J4_L
9J70AYPT,Rf;3@4g/1R<AM:>VebIU2W:Y6RK/8K9;+0GR:.(VFS+Z>>4YbL_3dDW
M=GB14VQ.f-WU]S_B,J>ZIa\.YN,f11dUdO@D9JI2TZc?_(@@\<V1=F;9bT-^O>D
37MN7(E=,=_c,\#L<F3[dU>#/J_S)6DM4BC-/4gRgRSa/,EaOS:bbg\C:W_0R-=7
^YN_YKL@e:G,U:)X66&>YN4Q)9=c_:V,R>J0eC_FFIeJYYE0CX91;L3\g#KC#aV3
YE(,S\bd50bS)/WeLE_\FP^ZX@ea3(U#<>HL->0Q6CfM#P5fMUP\5)6N^d0BIEC1
_bGBGNKg#dZGGUe<&B];6K57LVSFDA4e8+b[)fU.>bL4PXUMPLZHfU4NZd0Z&[Q2
K1TO0:GU0U=D].:-0Y^e4]d;-2fU=aX=VSWA_\f.:;:@SX>IA#_ZdQWCV+;77>[<
Pc\U&\JA5K#K//0fQ-GN@S,<53Qbb9-#1+W_ZZ5-4J)]aM-@WOfK=-YfAUG,dLU5
;eD;K5eI2IYLfVW(Ce7]6J@)PN.=^_REZB],1Yff<8BIRZ?B&-P]0:UKe2_V9:Qc
+94a;E\_Ge)OX?K-5GQDAICLcbc^R,8IWB-F(1C=;DTYfP>AT_;:;@23,d44?<9?
acIKL.3)RWQ12&+QDHS0FB=aZ1Xd?;:>CY6@12@8/aG5fBE7^KL8P]R]dXLVg?(Z
H3EZ<\R\=A8^APeF8J(1bA;9.CPd8<)3PQX(JBZ@B>JY(RgbAT(9=D0WBd?:1(E>
.H\ed>FeOBX6N]65SH-@_=4Y.5J;NJ&R:bFFAK>6&JgbIB-#QUg-WfH/<1)K0dCW
IH1HI/.8c+2bAaLEeQ/D<,-5UQGA5]GTCeQDX3>_bUCCCX)3VZ487-0ZTS9;#BI,
dd4I;:G?Q)OX>L=gJN@TcDVA,KaQFS)\@edJN9IB.0a7B/V/)(7^V(DBR@+QR<D;
WIe8Re&ED?g^YdbGR^][bUdGG?H#.N;DM\g78FFYNITK8VO)QB#AUIMU?)1CZCH=
M4?+PFSC5F]UFSe]:^F=aC(JNeL&VRO6>NL1FJD9#G^3#X[C0F;a_N@:bfG06,gM
D/AEE>aC;@gQEdQbZF+<]1_b8QK#A_?cbf(aN@E?M,S4D10F)D>b]e=[OMMJCM2W
c1b]E/<:^.)abC5=d\Q:N2M?.3?1-&7J9HG/A?PO#XeMI&<-0/UN,cH7T-D2Ag;-
aMe&:D=b/?ICK4^d72LA(gg?4R2H3/E\9UB7=BX(7dJ]I#NdXORggD?)0V8BRQH#
74+UR0V;:QF=J>BZJ-[JH?^>5ZUVdSYNLP;FLRC,6UXBQC-9Kg>KXbC;[aJ(PHbd
Q7.gES(Q+]8fXT[M83-U_[7#F+_:1bg#?BPAG8g283f[eUCW;EQ/&&,<8R[50#BI
N4/2ae)<S@00?Y12gM[8Y_M)0We@);5>D.FU;_-WLVABRZ0Y2<]g=_P?;A-fF;R6
S4YWOUR+Q>@5EXE>536G_6A_.3)N[GP)841G=7FMY&91fSATeTC0D;fFKg9eWM\6
GKGP3U98I:D;F)=_eU+BJU_fCR2388/4@.I3]S.BASZ\LA;fTY1D]geY@JX7O?7,
2F(aVAP\J@;L2O0]U]e?e:TTO&CRJ75=_&+MFSK/;3@EAB;fT+>Eac<Dd2P-;H2W
K539S:\8_b#H21H>B.QgY356>>?)-_=-XL6BQ#]/NX3F.Q1)O7<B<N0cJB20g.,>
)IAe]9F5;1;9#P@N[S-)4)8):28a0B>Y=4TgZ@;E;9YYT.PCeY5gN.YH\K\aA+KL
SF:(9&^X<c.#1&L#M7&X=EZOR4H61Jc4^5(FP5)6DE+]R+)AH(NTXA\O_P4[J/6e
8;;R5dV5Ba>K0J2/4K_63+D[Z_?CB7W[CK^94;_>RF]B.e]KGSg;/W,+_^J^Nf=Y
<-Aa6S4LO1efE36Z6Oa3B86Jc.B.GF6\OX66D-U]J.d65TScYG4DN+=,3VS>CWJ3
H.Qb6bR.TQAL?@RKY(6:+K=NF0XVUK@Y.N&,5U.P2[g,\>G6FIgHPS,;#CNS-7B,
1KH5Q1Td[,aQ6<]^07[=9+?FQTZC4(JRDZ;R@D@\>d#)fUBBN0KE8F9<SRS<E1D=
b1=0A;7X2&1?M@[)8AIcDcR&[066cA\BA.;&bU<;;KS4LLf3P+D+B5Q1/AABY=>a
PA?TD(V(UG0.GX4=S&2=&)UXL>J[;&\/8+KIV^ZD:7W4Q4^[NWE<+g>9/W,31IUe
\AcFGZXU(O>EA/U3QHW.MYJe7L2bUQ;FPP/+9U.JL&:[Fg5a-AX(0/d7@dB4,f4S
3aKU_d99.Za:Q]FDf[HZES&7J(Y:)c\#K<4dV#2F7&dL(Y@(T\O0_&>)9L6F#cBO
c1M][CNDXFEcE[A<a@-:0>TZ84Zdc>Xd47O9fY\QQ8fM58.7C&8)V4FV^.?[I+SW
#C.\g,,[b-5R38:a@V5GPE?=e6G1A6C&R[Ec[F]He_.6Q+b_A,,S@T[Y75^6GQZ;
=>?@O=ZC:fS_NEEK=gVR9/6BZ8d(P[ZgN1QNK)f(.Wf82OU372Oe2.65>dLBD<YF
GeFfL\38_<-XUg<6PA-),/YEO@H_JbFF\B6^b<Dd7f3g3fHLRUBB:fXLX]ZL4fQ3
RfeU&=F4Y[Z&SQB8W\;PF0#R09^^L93H+3?7ZO1(Ffb^g_N#=)0g?I5&Y-Y]9L9N
6&=b>0<(?Kc<5De5A#2P8DD&.XJN0LddVE2SF,J5W:MC[K\_adQT5Z7-Pb^La<A=
E8#G0B(S8LI9_YKg(G?4cYO7c+0RW.(5WK)#];H,<P_05-XYK#44Tf:N(]8X+X=P
SMV&87C0V;?RDg,^ZQ9+K.7?CPJ6V/TeD.<06UXU69,fd7@1[DIQ:a_P<\9Pb=B+
W7@F2\OLX^_;Y&>,(05\BT=(0DG]DRYNZ+&HCDNPK\E@?ab7;ed8RB/<)/g.T]7_
=IA82^dS9IT2P&>&#8-&6]6)(Kc/^O^B05a4WdKT</5ga]G&ZL4c22_.V##S9A71
?OU18Q/ALSWX(#V._^-6[9\CI-2-6<Pf^ceD^:0C<T;5KQ0D+^SV&BNZ\(1A8HG=
H&J3-.>]:^f8W1f(APeJfeUf/:EW[(a4_)#\P1#?^Q]9[CV^4)^M<WSH>J6)\+;f
;7QXdTPd8\ZfYMGD48[.APRGH(P1+,FY@;R@K?-99TN#JOC)XWH[,S;E<0b\:I9V
CZ)d_;R#CcMSQ&SG1TId3&[f4ITcD2?_I=YT7EO0U14,O+:Db6L8BMNd5a/@4/S)
\N1<8gC?M8K>94NA&G7:AcIgba4+M2B((E,9]RL#:)IgPZ9-<^)fTDKYJV#AD9E?
RR;4Y@8AT(T]bQCCUBD)ZXEX#VE&CL0.:Rc<^f[[Q\BGILOY3]JEXG+5(_9F@gN2
SDP0dI(2-&W,MYTab?J+Kef<KXQW9E7XBCf,_f40UT3Q1E8eRg/[^><6;,_>dXa2
OJLN,S#UFTP.f][;Ic&9\#I,YE3PeGdb#0)3K#BG<M#;L2HSTL+3K2E8MeQHHA+5
WEO];S/_#O\@42/3gQc=<\>aCX/N>FQ>X/;;a<g1OA@?A0L)18WBP+6Y7/7T)+CH
Wc.3>[3+:fC9@2f52d5DdWC40?YX5[<7YG#RcMD;b_GE.Hg=/)D>(GcfE)^+:WY4
I87Z8ISF.@#4X\R2)RgCN9ZEcRc0,I;]Y5>7R-W@gX-02.(/BKSH&XN(>N8/+X8,
C:X(XF[#T[^,FZNDRQ?MF32@F_H=6=YVU;;P0@KcJb/fS:Hd@B1-DF&;EF\61;1]
4OD2Ze+],T^Ic2?G;P#c#/=a3g<_JeM=N8O2KS\d)O,+EZNE&B9b_([@RJSRN,6S
?5&B+0<5[7R2?/+.C.9Fgd^\fR6R8[f,Z-OV>e]b3\_(M0O,c#0F@4]3LP8)]5f?
6:QKPdBU3c>O88f0T/E7^]aV^WBG(WLC=-Q/cK5JDMSZPGQE4TaKM;S8OWa>GE8;
T6B^Hb?O6g86@9<@M/X,W2FO6)cC&fcG0SfXONI>AA.)L]Ke7Ed)cf6?e:g.@f_E
SB_&D:fA:I;5IU\>Y[6?6/<Me?4,?RY\W3SUIe2]11c9>D7,dE/;c2J4,TGHGD?V
a[?<g\-c?,UF.EG_9>HD2Y4/>5#R1;c/SR1Y4X=0RgLM3b<bBF/e+MTP-MDD1.2;
[bCg68_KgMZP#N=1?_N5)fCLH<)I4.b1F#01R90+g=\620&=1#&&a>US]5dUMZA6
OV?aOBOQ0>TUO^WL50S?89MHdaP.,W&LI82a]MU1R4_RQS:U0K^N>7K,><O=[W.P
Pg?8L>JfU0#S+Rb]7H&C:324)>CXMeS<&WA&cGY1O2R8\5=g1Fa]9@FFC=/W9RgI
=J5(@88dU4RKP_C3-/\N5-SdV@FGdeCT&I4^H)-3L+T(D:-([gT-A47bd#4B:Hg(
R?aRBZF=d@gX&KASg2([);:TH&O2A_&7C\(=YfTD]/ZCM;KHW(&-/8?J:Q3WAP:_
#Z\24J.[LIVg[\+1BYgV=(DWOD]7694R&f=2.CSU?[G4.,+bM2PSVDOH;XgK)/JZ
>HO9>0FO</@+cbd9+g0<8bNcdg3Q1=D>?L]-b1dCCF-+T-IBTMeM1BTACNX^5)4b
/AE5\#Z&RRAU,U)g=5b[AJY(HPZVYYHbI_b#CW?BXD8N>fMg\7T\(9Cb3M,RaPdX
X=4b7W;CTH1MX&cVBAQM?:(Lb<Z=dII?;ZS\WJDJ?g_@K:M8W59ddNW.2#FQ3+a8
QfPS--<e2<MTOL./BXBLGKNN]\3;6?8W-&,#cW7aH6ZP5R6=Y=SBYLZ_N;N8#DM]
Ue@Z:ePc^1W+_UgZB^VM<<.a?]<>KTE(WbZ5e&fLBVO@YTT[+I#5OWdCe.b49WC1
VFJ<VIG6:R]b)KPbU(Q24\3QX:7/K2T]799UINgO9+_7_CDY-OgY]=]J>P0.Ve6f
ZcYJ;TeOUV=I^MVQ]cH^RL9ZQ4B<O?+:D[CY&e-F=NFYGGZ5f^ZB;H]\L_Dg#3bC
e]RFX^?D)dCB&P\N_5Fd82;,UE?&Y/f+AIF9QF(4<b][BK61.=WL_D40P^AY3R]C
NAB3MS9UB2YHb.P3.LN3@;_U33P^b<&>YL&A.KZ=/9[O?-K3E\cdT,)(>C.UM21E
bH5UA5:L=?6&S,3b/NQO_U<BNeANI]eB9;ZC=JS,KgRX;DP,8R3K:^;9)C+(\<gY
0>9J9Y-]cQb\8)DKXGX?WV6H<J_HQ?[aWWaS9-[@9UCUfa_K8(WA9e[PQI/]O>2\
\]&(#47T07DP9^E\IW_R,0;M4..>PN(OET./UG25d\/W2ZGCGV>NeQU(R0=NIWW7
WA9Q7VCY?2f-60DL1./a.(XT>f_/6R8=ScB0#/:KB[-a675HbPbgJN&\[01(DI/b
LXX6>K+8-<dJ7.1,UC]Z.d,U5KYT[/(RZ;&60dDMCNI>50&JNN0ZAH)a)JW5^><,
C,W8G6,(2L)BKf=3[1?b8^06DOMI^V=LWNgJ+1E/&7NVfc([,UV#>78CUQXHWU.X
/DMEg99CDN+:Qc6]-K-D-[OEZ?8QZ0P\YAY,VA,a<\_,(=4efB5:d((a<eY_XS3E
K+^:)QUO\M^^8)g-GL2-A^=^;K>d+==,[Z^XZbf1gA14CL&aMY);fS)+g]4>OJR6
#&IT>@aTe0L_5dYU.^(E6/7a>YKZ?f]GL1#,23.B)G<+c&08)H,APLN_gQCgb#Z]
a+)d(b,KSL)_Bd1Jbe@M-)X9S4ZBF[E]&;7ZXKdO]8ff5I)2.K)MKCDf.TfQe?Cf
0L(=0>Ib[cGOgYc&VQE@.DJES6W8\U]\^2UMH-e[a(Y.=^g21^][23>3EMSVYAg]
&L<>]UU]efFQ\(#6dG6BY0Z2Y^WN-e&1@>KVZB;I:YJ,.#Lbg?G2D&S^:aD&Q-^\
.>@.&-EJb41R(ZWIK_I06I,dLaO+-EGASU]@e2a-QKXSU&BM>;;D5+Pe2Ve^AY_W
3@.8MdG]->3:?HG933;\[?E^ON[+5P,H>b0K6K/8aCa4QGA<=86U9T&,U4+U5^D1
.ELJ@+IFg1:(Gg)b1?:g]2GC_EJ)U,[gYXDS+B:B8E-@a#[K[d;4G-9(#TLY+C]T
S,M>G<dA?>::A?7&3b0-&0@.g^2G,Q]]4_ZR^8?K;YAcTO@c;G?S7^bCeD3:A8M1
2S0B:E\4GA#/4):[?8Y2ZKFW.-&F#AD\R40_11T_M,-8M2\F;\Dc2V6)4&063>38
9/?4c&[Yb&ZLX.;daG+((_-bW3&&QB>VQ))@C2gU..9gG0/D3KRK;NYAOe\A(a>1
E10DdNN<H,b&7bOAJ\]bV&X^TA7d>AYNL+gcOM^@)><;;9H)Gf0)[<X[Q.LfgGAR
M7bAZP3DHMVQ+@.&05@fDSWfdAXYLZL00Y\>+ScCH;e)BHBQJM-C=_-+=T-.+(YJ
1=@4-d8B;/&Z\Q0ZaJ9X84SQ>SY_HDO6CM5/(U<KS&D:@ce+&dRI7(T+Wa5CL?/<
RG2^g.Q7)K#U-3bQ;EB;=YPg?cB5_O]Z:(4,YZ2-f(J?Y7KK=02c8[-cUU_XXEQ5
8S1BY7f.eL_#(^5f9aaXJ<]25QdIaJNWJ4V(,.S]cSAB78c542O(,(UWX=D;XB5O
@T6GUV6G4=ZfD+&WFH7/6g=CIC][/BUYBCKEVFBN\f1f]_(N24ab;M4?IAS0&^1>
#:U\JBZYbI)&a0Ma#MDO;<UHF6XO6C)U^[9H#MD0XW9NGVY9E#8AC)<P7)PYHQ=&
5IG5H7E7+X<.Xgda0)cPTM&G9W\D9RLVaD\=3Q3JO]=VIEW(Yg-ARN-XYJEbNGYE
HAOV@cNMfNb7T6/WIg#;R9YB1.T74:.]C4[f4\9;>gIQRfG@2;7\(cUJ)+BKQM@g
DTL#Dg(W,+FB;T?DU1K5g8CRG6,geDH/Y&8fC:176@1HSc&NcU\;<5<J2)U<ZNHC
3Be]f.9KMML7?c(NV3c_5MJ3H&SHRUcQ)F:OC9_c;UY@Kd1@YTQ6cS&OSeDCKH<a
e\VDBGH,Y#S==-91EU?Xb?L-V??Q0HgD+3WgK5b5+QAG9@:[CZDJd8Ic;HdO-IX9
d^0,dQ7KXVf_HW6<(+R@0M,<,D[FJQbG,C]ENDIC7FgGB$
`endprotected


`endif
