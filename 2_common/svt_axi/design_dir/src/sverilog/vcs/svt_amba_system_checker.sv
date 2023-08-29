
`ifndef GUARD_SVT_AMBA_SYSTEM_CHECKER_SV
`define GUARD_SVT_AMBA_SYSTEM_CHECKER_SV

`ifndef SVT_AMBA_EXCLUDE_AMBA_SYSTEM_MONITOR
class svt_amba_system_checker extends svt_err_check;

  local svt_amba_system_configuration cfg;

  local string group_name = "";

  local string sub_group_name = "";

  //--------------------------------------------------------------
  /**
    * Checks that a transaction is routed correctly to a slave port
    * based on address
    */
  svt_err_check_stats slave_transaction_routing_check;

  /**
    * Checks that data in transaction is consistent with data in memory when the
    * transaction completes. This checks that a WRITE transaction issued by a
    * master is written to memory correctly. Similarly, it checks that a READ
    * transaction fetches the correct data from memory.  The check assumes that
    * a transaction issued by a master completes only after response is received
    * from the slave to which that transaction was routed. It also assums that
    * there is no other transaction that accesses an overlapping address during
    * the period that the response is issed by the slave and the transaction
    * completes in the master that issued the transaction.  In ACE, this check
    * is issued only when the snoop has not returned any data and data is
    * fetched from memory or when data is written to memory. 
    */
  svt_err_check_stats data_integrity_check;

    /**
    * Checks that the data in a slave transaction is the same as that of the
    * corresponding master transaction. In order to perform this check, slave
    * transactions are correlated to corresponding master transactions.  This
    * is done only when
    * svt_amba_system_monitor_configuration::posted_write_xacts_enable is set.
    * Note that posted_write_xacts_enable can be set only when there are no
    * svt_axi_port_configuration::AXI_ACE ports in the system.
    */
  svt_err_check_stats master_slave_xact_data_integrity_check;


`ifndef SVT_VMM_TECHNOLOGY
  /** report server passed in through the constructor */
  `SVT_XVM(report_object) reporter;
`else
  /** VMM message service passed in through the constructor*/ 
  vmm_log  log;
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   * 
   * @param reporter UVM report object used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg. 
   * 
   */
  extern function new (string name, svt_amba_system_configuration cfg, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param log VMM log instance used for messaging
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  
   */
  extern function new (string name, svt_amba_system_configuration cfg, vmm_log log = null);
`endif

endclass

//----------------------------------------------------------------
`protected
aM-Yb?Z:8gX)ZCaN97-79NGf:51W(PaaaHBP3Yb?>(V^@cJ17dP=2)F06JU5\W;S
.2YHL1E45K4dAe1L7U^1NI4Te8(2<OfE)K_G[[.)fb-aT(<gR(dPYE1SLV\YJ&,H
.fW?;TW=abEN;TV1I=Y?&56<DH7N]c\AC822:9dT7;>b2^8&17\3R(KR2K=VR+Qf
M3Xb+6\28-16b0(@G8g\==VK#8gg>CV9TYSI;cUBY53+MeK4eTB4bOcIYVd;N9A<
&A36UN&+Ec=B^6=4U3[?^8<&RDK_GJ1?Pb<G]P=.6Z&-\MX#+R;bJgT\=##2@Yc1
TDZL.1.U?be-X1dN4#Wbf^JR0BW&61XDc+-)(D].(FLIF>K-BN3MX9Q&T^M:.3/N
PHag3c+5)DW=ZXLGG-9K3&O6R:QI467V9HdYPaEU)LTfNY>fa(c@RF7)Z=4LdcT.
<g0VLE>46YE4,_Eec]Wd+R8^<XL\0T_JHPRY-a0b]#]_\PMWA1V>6VETIIJg?)43
gMR>;I314,5dQ@FMYB\D-QfV^&SA4@;-E4J&^;g[)&N1Z\CFPB&a.B35STbAVfO(
d(\P^X9R?gF+<+S9+P6eC[>&1.)HC9]9,VL_J;AC/F.@CHMBEUWLV+YY,Z3@3@2B
EJ[:eS=e7/>(#.9]5:MLZ+RD4UKYPIHBa;C(N:--(Y&LaA<H]RLK3)]=^##7O-Da
CLgIUVLBR(d@\.fcEf;1+e<Qc5@cYH_S74PRaF#:6]]81AdQ@:WYKX@;D0#R_6Jc
4N\GP+IFbABdH0CA(<ZLGN2]GQ/Dd&;)<#[V-G#PC7XVI;A@U9>cY/>GId(+1SMD
+(?B&(6/D/X(U1T;+A4Y-3==+E>a)Qd@>K8:&gO^]Bc5KRZ=<35#DgZ1[0)H:aM\
cVUPaG0.FA\\T\ZT@b&@D]f5[VG<B2PaMd#gS[F8PK>3g@;b-I9?>YCZ^4WO[\;9
2ee1(+b@XTa@Z+]W+aF=KK1ES:9@N7\N6(0g5@JO4e>IC\&Da1;O#91GY#\0BgUT
2(;,V-^I:UDO;?ePS>2:7F[6gV.5H,7M3=,WTMMP(#P]5O?8J)e;,A<SOd6f5:A_
aG5PXV+E:BUKTFHeABE3Y]8cN]B7T3:Zb(#R(BH9(0ET&BS/BGd@ZQ1,^:4,N)O)
_/Fa0UMfL]d<G?N>9ge,R/<T//FKRc.SHTNU@P<VX=BQ)H_>dZ0]>-H2[CJ3MMOO
GZMUP660&8/@9A&#6;gGT+,?YSZZ[LRJK[W82T;L]1]D6D6V3-Bac&J612X(ccW<
T4:C?&85bf3R<G7T916]_bW<2]Ff38-_#AVO&PB\_<ZZ5L#@cH=8#\96^899<H_=
Z^d6LfM7BGVf3WJTc11BCFM>(5e#\[(fA:c;7T&X9ZVBD^9[Ef;S5\?9W>46:EJf
)J,GT]NK3&+7/QcWVCFa4BdSK6G.EL=UP2ff&IMW:VQCf:TH@#SbL[DD.AU5WICB
<J-7QYDG=E.J,Y/=,ef\[P<0FcI?<+R<VaPEY)<bQCM0E3C1\CJ,D;#XgZL8[Oa(
CKX^-ARL4ZEQ2IaI4/b^#3MAYDW/U2VbR-RZ2?WDQT>&RVH;WDD2UONKfd(K\-L7
Ogb<_,L5A@.7+c8,R<\VY.dFT\DY>033?8Ve<3FBEZBGA=)_QaB=fND)2E/:4=>I
V)d7OF7+1;<D9aIVc54@OT[>FDX[=X2dQ#4MEUPKA]W4fO4VT8)HZ)+90W@8H)5C
_9^.HYL.dVe62dO)VLceU@eA@<eWO51G=@5S=L_XVdcSCKb^E[-8/LDUW@:?Pb^(
eLOJ0:Z1](ZNM_K41Qg?/b]1,cXKZ?8V@K4@KRg+5F=;2gOc6NY7X0XV,a?ccFP8
=5]/?EK&b,g9<#3Ua(ObGcfO?EG\R0+>>bOQ@__8&.CdD)aaWTM?Bd(B+aC-+)6-
#9\WQCFKd7<DYaO\VH+;U:1(=0FY:b7#6@14=B59f+9<9cEdUS,__]C:BK6JW2GR
C(:642S>.0(?Hg.LLF>>LcE&9+a:RYa.0MO5J#5(NNYd(M7CXJ5Qc]#^57N^G_cF
?T\73D>72RAWXYF0@gKYY;6I&PZ3H-;<B9:_[/6JG,A0)IgG-M2K@32dNLK,Z]XB
1B8:64V[0-eW]W_AX2(TbAX@e)YYVIOb^>B-E;K:KH&?&&fN8@?C#(6W_beN_,@X
gZa/?&EL@BX<7bfcU8-e09?fGN.Od^&SHKAMB-K(^@eG&#?<_#UE:;HHXa6)#F>(
AOe@LZg0>.P7_340VVAAX>UCYGQU35(<Nb[:&R\;X55.C@6L34EG\>AZ?=b6C22>
7N?8Pc_LHY:66;SL_VH=(+UC2$
`endprotected


`endif // SVT_AMBA_EXCLUDE_AMBA_SYSTEM_MONITOR
`endif

