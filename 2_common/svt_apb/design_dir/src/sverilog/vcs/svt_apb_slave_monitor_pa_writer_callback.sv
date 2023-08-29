
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_PA_WRITER_CALLBACK_SV


// =============================================================================
// =====================================================================================================================
/**
 * The svt_apb_slave_monitor_pa_writer_callback class is extended from the
 * #svt_apb_slave_monitor_callback class in order to write out protocol object 
 * information (using the svt_xml_writer class).
 */
class svt_apb_slave_monitor_pa_writer_callback extends svt_apb_slave_monitor_callback;
 
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  //*****************************************************************************************************************
  // The following are required for storing start and end timing info of the transaction.
  // Stores the time when transaction_started callback is triggered
  protected real xact_start_time ;
  protected real start_time;
  // Stores the time when transaction_ended callback is triggered
  protected real xact_end_time ; 
  // stores the value of transaction_started is called consequetively i.e NSEQ->NSEQ
  protected real temp_xact_start_time;
  // this flag is set during the transaction_started and unset when subsequent transaction_ended is over
  int xact_start_flag =0;

  string parent_uid, transaction_uid;
  

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer, string name = "svt_apb_slave_monitor_pa_writer_callback");
  `endif
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param monitor A reference to the svt_apb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual function void setup_phase(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  /**
   * Called before putting a transaction to the analysis port.
   *
   * @param monitor A reference to the svt_apb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
 extern   virtual function void pre_output_port_put(svt_apb_slave_monitor monitor, svt_apb_transaction xact, ref bit drop);

  `ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    get_type_name = "svt_apb_slave_monitor_pa_writer_callback";
  endfunction  
`endif

endclass : svt_apb_slave_monitor_pa_writer_callback

// =============================================================================

`protected
PVKG9d[C3HSEN3O3g4:d5^3Ke-Y#J@[I+T3Hg)WAbIS?-gM^+Y8U-)WKPab^.]W)
<J8.MIIdeIOMM)Z&5De,U1F+EaNdV6+J\/>8aR9?^/BS<ZbI&&MIfb>/KV6TR;.=
T<^^9ZOIf^:6DbF1bBg:A\?TH_Ff:bITJW8ZWSKC-HDUWK[_M[>=KK1D3+eG3@0<
-U3KLQ&6Xa367NV)O8T+QA+P#>?_b9-3MC@VfO=6FZ,,?3F4WXdZ<@N_e54?:gJ\
ZN[(e-9LObZ8eY-GPMQ_EHQ0e\d,Y6;-0f9f>6UaV.V.aXaOF.2GZ2X66K8)C69<
)/,+=0]Ke^F?+FZ+=+#4e_YV4eG=@],P,VM0Ee&<1(N=C5+8H[U7;f>&eJA4RSd,
@D/S,,J.VZJQF;IEdWEU].#EE^3[R<b>1;U-5e)f+R08\gH.H72^8CP=I.W,dMN;
Y(R+#]N35-)455d+DP:>HTOVf,b)JW.#A9M1F3ga21O-#@[DB9T5B#9<R=4fG_RU
C(La0\A+#VR+N2SQR=MV(FOV2$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
#TO]c@T0fR1VJ9aE[RB7-=+fC0;IG-)8TOb2ADVa#DL@VX,Bf-\42(@PQc&)P2>,
Y-0>_Q/LW;T#72H&C=I9Q0BGVHR5ZLbHOA#UM01P?4SOK+2^-c)(ZT=cP,V8HALf
.J1?ceALEUTC]a@FM3FEcFKMafI1fW(QTMB64<g.+,TQ@,7=9<SKE<a59(A<[^\L
O8>a^-Ae;L_2gfM2#HVL@H^aHaePgdHD#D>9QD<.B,+UXP3fVOZ,<YJV/)W-e^O:
RB:Q7PY^C7R]]\GfK^Da[Ga3.MM;c3;Q8g-bJP:I>JYb_g/+d8:BQ>,AAY&.L:7a
(YC>b89^Fb3feVSA/]cM./e(S3fVX(QfK5C5eUD=-.)_Y2+=c/g3R90Jb7=P^V^V
c3EW>,ce]00/aX0MD)ESTE>JPcWU,46:RF+>GV@Fc3dV[SKTN+B^a@]#XM7F[Q::
PfY5D9[cdHVK(GCCLd:SVL=g)N-b64a>IA>)^4W-8dcd_/@;Q9-IC@ICO0142^LK
GeG@gUTV2PS6b1O/V.ID??&=H\1g&fNA9UT=4.0>T>ST5eVB6\eGg;.@f/H+Ab-M
f4].dY[88T>M2>=bIaEH,Cd^<=559T\9MdX.4d#cHQL1]eOV1<Y#,-8)_=YB[QfH
bP+P/[Z5D7_8>O(8Qe^\cRK.6]@FRaIUKdcLW;T=<T[JgF0B4_\P)&551]9,9XKc
@g^.ZNf7b?Kc,HbcN>)BK?PECD+E8HX@MDGPE9O:1CWB1BB&UOBPYae4&Q]G@Cc5
V5X10Q#::3,O5P+(RDaHMEU;caW3TELD]GM)DEf;/e@?>[XC:U/Z?PHX3W,^0K1+
a)IO<6^&U_Bd\W2>M@0(QSB7,RcadC73XZE51[Eb)/^E+(S.1E;QXd)WgJ)@GAdL
_3;;FOFQ3]S[#+4E\8_,6/.IM0eB-#;HD7f^Q1==(QTc+Q+TdQJ)8Cf@SV:>VT(1
Cbe+CH=3SHf6#XV@P3-+E5(0&=T0K6D7]/Z2]V,9fRIPF0eRYgW#9H[R9VDI=MWM
AZ+@2@[Z,5=K>O>6;7&9Ad4DG4&Md]B-C&?JO.B2Z=WBET[P3]\b#I#50W)#McCG
EYPLPg>9(<Sb>9a)ESUeOV[d9OCfE>+bP3D.UL9EdgUYJFZ=d8T?M1O9G/Y,eK(3
.)<\X^cd>[2+g97<cSA,^OJS5;3Rg^WB=;13:f9HdTXYM8>T9.CJfIX5\LYI0DG=
_c,&ARS&>aM1BH9:eJ]I:J1g=U=T9?cO9M<(1]0<I3,:X=PfD_@N:4Q4BHKQTR_M
YU#HOWC>B68Cg.39g.dL/(8d<<X?COU@T#3^0>0Dd_,IH(]R2A^QDbW#&D@]7UDO
aVC.^GYBK\V;^9b:_6RV?6]6a=S,Ab+ZB->>X&AO>Ea[W>G#DY&A=O/H4?R6a)H/
E4_E4(cJ^?eWPS^+/CI4)Y&08:/dC+-g4;I)Db_0MQ#QY]JAZHNG4[GG,FdCOV(I
TS+)7NWC1W9O8H,Y<dL&101F)1J7J:Z&?g@7-VT(McRN5C7_Sf2XeKQ\#.9d59.S
SXW5cVL3W9TG8H+f1g/Lf3F;-W(0[GEOV,#H>aNV@KM/L3IRECd<(</JZe&;b.bL
GR=6<050\4.@H.]50@GfEX_<]^8)^H:M=Rf9K#Y5:2445A<5+8Uf@D;^CF5d)YF2
g<4gF(H<.CJ->Q[=+:=CfZf&_gE_EI^1Y0G8&=S>[-KX^d]Y/Z98--JEg:86.d?,
A5SU?[@7d@1?ET]:]H4I#gdV++MI>SY;\XLCA-SWS(dY<?.4+_c^96F9E&42A?af
Ta<[d-M(LGRH#9=<(#A93<WVJKTUgB?B6U,OZQOECGeD1MWb[^P<WOV73LMJRaS:
ZR4EVYNG5?-D,CbRPAY&P3-94:@@1Q+9I+STV)a_9[gTEbR-K92V+]Zc36]S-I\g
(Y2>a(6GRLWb]GdIV7T9,+^KZ/^/9KDM>SB:>,Q0f2bA^I7CMa8&]JD9f)XQ[\95
U9f_IKX9JgJD.aJ=3J^FCA9OWB;MDA?K,U&IP<MP_^.ZA0C]/[Q;BALe/0K))-F=
9(NNAYISAYV@fVe-\J0(E:XgcZ_DD\IT07-R9N_>?[3JD-=?9K2c&g)a5HaTYUPP
J:[g9W6W8S]BX:@6eT&767?U(:a9.7b&6]eA+C.Y.HA@/fO9[NQ]0G<b,XJ4ZdAe
V::QA[[6K#LTTE<UWFT^a4)+WKc<NLa?fK^.ZH-;GX89EZ0,DgO/f[_T&330ea1d
J:[XM;(MZIK^g5^A=6[7X;e7EH[0cAKI>AUOF2]V8VKX+P>XE5LP:CHF+.dgLb\f
1CCR:FK8)PSX@PMS\CPNOeK3CUY8(WG]G>O.M5=E8R#eHaF[V>_4;Sc@]#B0LDe4
U^H<MIH2)GfT^eGS=H;NS6L([&_CU6R-5(ceZU.^T?1-d7QB2R3\^UJbIVOB>cH^
JBd^OFJ/d.I@<E]>AUB<232=8-aAI;<@83W(.)F(2DVcNDM84dfJ@g/U69JeGSKe
HN#eFKAZA\BQZJ/@]5#EVF_-RWG[(Hg0)-aN<aYMC7Re.+efBN;aXbFI?(G&DcDG
@a5^OJDV/45.AQ4N>136=>5QZ&FBC99BI/cF9WMTSGT[N4Q)JSD751/TO:6e?5;[
50A3^RDE)#4:KIf_GG+U]L5Q7$
`endprotected


`endif // GUARD_svt_apb_slave_monitor_pa_writer_callback_SV







