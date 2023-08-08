
`ifndef GUARD_SVT_AXI_MASTER_MONITOR_SV
`define GUARD_SVT_AXI_MASTER_MONITOR_SV

// =============================================================================
/**
 * This class is Master extention of the port monitor to add a response request
 * port.
 */
class svt_axi_master_monitor extends svt_axi_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, svt_axi_master_snoop_transaction) response_request_port;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Common features of AXI Master components */
  protected svt_axi_common master_common;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_axi_port_configuration cfg, vmm_object parent = null);


  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);

  /** Sink the read address and send it using the request response port */
  extern protected task sink_snoop_address(); 
  
endclass

`protected
2AO;3;R]2LKf+#K2b-G1?GegM_Ib;Z5=d?5K2DQGd8-)D)@AL_Eb3)(?_C.][LMZ
fdMT=<5YG(0H&74Be&6SAYb[:YPGcW-)A4.P\6W4M@d^FKGZ-FG:4CQAK<K3Z+:f
_IEUa.Y0^>V]7a2>_1INb,PfTZ<^CQ[\Z.4?=I]\,Ed3DV:>VcWcGYQ>0Pg(0Ha/
5gOc\]gSe,?M+#P24a(HI9KUL]FK6\E:F;:>=/K0H3ZL]W0>DWF>?5/D0^-WE0;C
^1eD[L4>BPE&SE1^6MP:8R\UVgEN=.@aG4ff=M)9JOcO(T\:Ibg]WOBHJ),-4Pc+
:>&d\H\,0NO6aO#,ZKVIHgS^EX<G(YeHeX7beDCdB[IW95@dJ2)TgKBHP$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
I-_NZD=<bf+T?<(<ZZ9OD5?<)LSE[@dERX?JONd/I@ZdQOD>Z,Y[7((=92[N\Yge
g96Y,(QP=:@_e(M6V7aPB^=KXIH_H:9f-YWC_\5;JM-.B?WI;;&0\-\IXgaf[-^D
5I\J)@J6PCLJ/e1Hc-5(Z01A?ZA?ACe8X)EON4O3WMc:D,<W]JS:>=_gIGNd\H1Z
[\Q=>5fS\;35:N,ZQE]\_aAC]\E(V7;]T@>/<6#IN0OQNRU0P334;]&dO1;5272g
f;TLODA]WFS.B5GN\F6,2=>>?LggCT+@aRcZ-03G9MH9bHX&E^COXYA-=[.A+NV#
V,/9/=+b0T#^GOB]RgQ)Y^PE)4W]G2Nf),[/R)GFQUA>77Vg(GdPGG(4TJF0KMDZ
E&0TL2:]D57g]]Ff#2[-+:cIB2AT[_1SMC0@+H#(gLNJ-,c63G,0_O]N[N3B>X+]
X@E(;:8DeU61Dgg2aMGO93/,NXMIHF;#+4:KI).J>>\OOST;/02GA):YJ5L[c#PB
3HMaZT5de?\dQgQP\J&-d]KEMC7C(MNXPB9?2ACB>&.A+O1:P5^@)]-+\agT=>00
+.9R?Ta9,)NL5[9:N6_?T<O-G29fSF5MZ[7Pa&T+_XR[Pd=#;/[5QX-LBf;6#B:d
e2A9gADX\c(13=^f@@8f[O0?KZL/(XP:==Q6RG&NG<;^Q=4VH3/PWCIGM>IEdaTa
TGBaI1_b3XFZ1NScRgSda+=5Y40)<++&aWd-(SXA)Mb)83]>Ee=Wbb.@7,FJFUac
K3c)fL8BTTbK@DBWSKTeX1#PZZNO4FQJPA&QdGZ[[P-.<\\X[2C;6M0:X:G8cDWS
N/(_W5NMOZf#S@Pf&6^QW3e&DT#>>7P,R2ERQgHVe9XE&EWe9I(:PaM8=bNP^T6^
-<9[Ve5>S9Ge_]ZT#4MG9Sg9TB)7R:TW?I?OBaB@L=dFadLI7-2Sc^e<JJdX/daJ
Q9e(RQV;(X3e2<D@Y,cA133\E]>KE0,2<_+XE.1EM0IQ\+O^d?N_QNFBWY>^&^cO
.>]Jf.@fV<<J&QRV^GEF([@Q#8]DM?W)?R)KfH:L(-@TXX/-MKgKZg&f&09]g>PN
-9BS7&L^_e4_g/g.+0,,>BNYFRCU#>&8B;H97,QY(,I&>PXaGD(8V\/4BcL?K1:Y
P>MA_A[0?^_>gZf+aNP1B)5J#9HPL2J-OQ2D6,E-0OOg13XAQ@Q(V27I+b?ZXBgJ
d^5L>Eb+/]I&_JNdP;]/-00\FfTe1E805O?+T&_7ec#^&-#SC72DNTgf0eMV..Ia
BZTY-6A@g8M#.14g0V7Jee^bPUQP?-R.9bf0-?,J+aHYN@/SW<(N)c1SH<7<TD\-
-=N;T4J)Z]\;U:U/])&]e_8N[g2]fNCE26KY&?6-4D:c+a]aLH+dHSBW?WPQ8YQG
dSS5N_<=8X?Ug:dK0)f9R0#8<<OV;g?9]4TX>N,6(MQRg-gd7))^]5Z,17B5<OdQ
aU&W):(.VJYYFA>4gG,6>Z/J2J,;6)QH-:(,.#A6?[gLeLSQ>G-E/7>;EKd@IQ,A
fP^4JT627]BL\;M,/f]3B<TaCFG[RH9R@$
`endprotected

    `protected
TH48#U<6,3+bfH9]6OQ;?2<6&bFaa6;b4LETL16RG-..beP#E<,E5)8-Te^W#8g+
K;&_UT(d<O<YF_E+If7X_Q<67$
`endprotected

    //vcs_lic_vip_protect
      `protected
:6,J8Sg_8I\8Ec[EJMaV?YMIKa[9(UcI<Z_@/H/?,J8Zd@80U<g8)(0^XHTV07E;
&<AGZ)TZ@<<adH[YeWPe>c=6=HLF^=GYVg,O#I2W\Qa@IWVC]GKA)#6,b3SgKF#0
VT/58<AC27QA=7fBUDJ4bL0RV>ZbE5AcXWFgb=472&aRYJD:/I_aJA#SI+U4^ebf
OA1BSS?><gK@Qc+8eB9-HE:E-_5RHMN/fD)&c=-N14NdKa6A_/4\YFEOOg9N&0E0
_dCe5,]9AI1=7FT6U65_,,cL7^]>)7=TE[^(aEU#-N#(Z&;X\3AFITEON$
`endprotected


`endif // GUARD_SVT_AXI_MASTER_MONITOR_SV
