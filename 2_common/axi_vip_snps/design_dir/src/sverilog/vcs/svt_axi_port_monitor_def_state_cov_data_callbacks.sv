
`ifndef GUARD_SVT_AXI_PORT_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AXI_PORT_MONITOR_DEF_STATE_COV_DATA_CALLBACKS_SV

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_axi_port_monitor_def_state_cov_data_callbacks extends svt_axi_port_monitor_callback;

  /** Events to trigger the signals's state covergroups */
  event AW_chan_sample_event;
  event WData_chan_sample_event;
  event AR_chan_sample_event;
  event RData_chan_sample_event;
  event BResp_chan_sample_event;
  event SAddr_chan_sample_event;
  event SData_chan_sample_event;
  event SResp_chan_sample_event;
  event stream_sample_event;

  string s_inst_name;
  
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, string name = "svt_axi_port_monitor_def_state_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, string name = "svt_axi_port_monitor_def_state_cov_data_callbacks");
`else
  extern function new(svt_axi_port_configuration cfg);
`endif

  /** Called when write address handshake is complete, that is, when AWVALID and
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
(IBDY+92g+HG)9O81PY5:BYH1+P<Y:cO>BPcNcGQ<,KSRIPHcU-Y7)K]&E4NgPM?
U4/&HFCOCTSe=Y0=M@.3T52UAW_=TP&3JXgP>Y@baAcKgVJH<HP6BKI3=4\RHD_P
DTb;0KQ^&8Y<5fJP<3E@CJB:Y96L>Q:;-3O[CC@)Ndf@Z@IN3cff_5.2dZ9++X@^
,W87,bd(K+_,<=GKK21d)<Y;0J3g11/[>N[7d)Xbc),+b63:9Y;K>-^74BP+fQ(e
^b(LaR/PWZQ36#6J(75&eWKNMG/.VdH@W@MN1#cVT+T:5UZU/8^a5MaRHX_Vg]dW
Z\768PR;C@B/TZbWZ[a:KL/54#NLg-cb,>>@L(L&E0a5.e<3Y:/PC#?)(/C:b&97
f&c#Vf+[,aN&^NcgLac787PH7[SC:dFeF>;W4]2,_@f)V3?8VgP,/c<V9=FdS9D;
eJJ&+:8,_2gK60\-+P:/J=ZQ.GC9-+K-Dg+7XO-JYM+N.X0FXZTZ/#PG7]E[/\6O
;\;-8.ZB2ORbS5c@FE<cbW4g6RBP?O)ZX)<I?B+_fDS.P8eg=_d(/4fDY5g#@L]9
#FEDCa2;fZ(_^YS3g5V?WeJB9?UCEG@>+4+A-DZ5TWMFfJd6aCL=e1]A=<K_/5-#
eV-?=3>[-14aEC3JNT#LQ/c_>fM5S3YPOT4=C)aKTA.0@@+0U@615(gb\#.SZU#D
b(5EH9^?1==g6W6c)c?7C7T@+.AMNd(YVCT\>7a@IE+J4=-B+JDQ507?agK2?(](
OYEdFJ8M0>8H(gbXJZTX9T&09L8?&/X?cVCLPfFD/;P[R5J5Z3JUZK<a3YeA0c(A
-=R<O:/Yb)GB/6Db3EdHFB4L.E#PD3bR_Q/_6WB@-;CRMCUfYgEOg]V[>0NeeO,K
EXM&.gQUeKVG:70PA-eVTCDE+:G7BL/\L.ERE&VCH8?GM0?33V3M@26V2#1C+O\M
JC9\,X.G1_G/;+QFe/.P&\T?Re5^E9\-eZ/_TB]YPI):WWH]4@&M8XF(743aU(QH
d7568I9/02Tb)0.D4YV+9/DD/><3JAS\)WNB.Y4._]-+MbU>E3BF=1X#>7&CX=f5
TgATRK9E0_K/1L:bZ5Oc+BBL0_e8LGH(PUPF95&IC67:JEV\9JY4\W^)>Pe5,EAW
VSfC,_SF,R.0E5^6dAUgUIK15@0/AY9/Vg78NdX>,2F_VK\g<+UDU9<=+J&0E,Z6
eQ5DXNOK#M6&.?V+>/BTY4(4[D2:_SN9R6-3(X+]b./6HLPgBD]6TTT^Q>?RQFf2
>^D6GC47O.T:<f_S)dNMfR)VAHf-N/JSF;bCOeVZdg5Cgd6RR@.FEO5@QGTX]3Y]
]ZE=,+]U?I9Y\?KfM04IK+V>K9Ef5fKZ2M4&9OI]UeSf-.#;PMI</Xc2>bV,g\)\
J3HY7Y5,M:=E\NcZ<39AeU83<=gY;:\(2STQ.6ZE?#3QfGVA&Df#V/2UYB3Q4c7#
\=&1L6&YZOLe+8&]W\7>>]dF06V2GTF&,L9S_DFRHd;TOM>ZgY&QHF<D]0NMU@.+
4U1TU^daNS95a@U5_cHXOCf9VFOR)@^/WZC75ZOM^];5g1WML_,eg7_@.+Sg_W?;
_H[_C696.;I\dRVN8:_>]PTUF[D3aHZ1Y8bXSaH.>1cELM9A.TLTK:@E@>eR]RU-
PBNEY(f\W]F-;DP-fE:R&D)feLD\^YYCE6cf.a/[/FH@FQWR7UeLMI)Vb):&Hed8
8]DaP@]5&1(fOH:P25H29b(Zf(?4[XK7<>0CWAH<GRXDWVNF8d.02O+RYHV[VV5E
2Q+Ra+^[:<2\C629]Z7E6/Oa&3XP)&OI(O7MZF@LdGQYCCWX8?(FI^f\9BN.B=>]
G2bVQCUHB/>bdfE2(ELc[M8_=2CIWcY(TS5a6_g@T)2XCa)<9).AOKH<ad[>P+^Q
#,,U66KAUS[#C1#O@W])S#V<6TXg(5PY[)E(L)a,(56]PBfcXIAO4V3N^0A8FT_T
(.M#dgEY+efSaA?>T@1S[VA.T>:f&c8)Z^MN5),VW_CDRa#CI5>PB<+QTQT-cG[C
G^74G@0b(.-#aYcfDBGF)BcR=WQC&AESNJ[IZ[Y)I:dHL>?>V^b&1N39Z\=Q]Y3-
g\9g[\^[BH:fNLB?g^;1S([G]KQ:RC:OLKa-Pb5\]/1D1I84UBaeJP=Z1G/ddZVI
:,AQ(XRT.BGaFZ4MGd8f11L_X[^)>SG<Q[(266D[RY\@^ZOA1LGO44#/6L1_(,/E
8LZ9ecd^-H?,=Y@:)B\@Y8MJbC8Q^<;W^2d@K1H1X^<,^.X4bAfb04FMXSN;bSM+
DIc1>FW._0f@V>gf</)1d7XHHHEKEfYU+1MO#PD8Cga,1V\2NZ/&-=-3TdDASZN5
SXN,SA:fUKf=);3M,I;^5L3;+aIa:AE0WN47Ob[c_?4ee@U]C.d,88FfR?GZI0Ua
aHNPDf4g0ZXGM45E(/Hc];G09C9@>CNc827fI9C>@(+>6=KPVMJRQeB]77Td1A2F
CQYYa6T.ZS#Z\(PH-f?6C^-S?-U6V(+?\fJWAgLU@9B(O./Z,^VLY&2>)K\KY8,?
+e1<bO:]7aZCMKHG29A+PHf2],;RW]ZQ;:68eE_M(F3S58bWBTUUXZJT,>3e?-&.
1Z8/QY@5,;+JdJ,5C1EMIe5gKg;6_Z>)85;cV0T\@18S_#/V5)ff&[,@H,(1RF)<
c)B/A^Sa^6UCR/83>?8&[I3\&FE]E/<VYB(8GBe=F)H^^NeJAHe=M4)G?@#de(5A
,@LQ6:VXX,Jf1=MRg&X@?Ea.)4S#f;3?1M,]K2dP;dfJT\PI;3aRB:f1BSQe-_a&
X_>\3C1(AD_S[S,I/:D@N#>V1&ZaV4T@9QbXWa2CL\0J,I^@,G3@;I&^?W6OAg:,
bDCf=;E1;H;1U&0#3=Y-<W<BPNgQgN[)UG)<8@_:<DW8K1[TaFZeg:_4U&ARcWC;
N<E;Z2UVW4-II4fSEb++TD#afO#4+YMA4L<XROB\g6#B(_W8XJ#/\aN07Ng_M_)Z
=DOBD8P?G@SBCf<^LCYcXe9H7<?G0@&@L^MAH-ZY>#JTCG\g.(UeHFYa(KB5fLZS
SJ]IZ74/NdQLU2SU0?C,W0@9L;3PfeJ(0=<8#QH,;6cA3KX@@;XWgLBX1E4&c?D#
?0aKb_>VV&aL*$
`endprotected


`endif

