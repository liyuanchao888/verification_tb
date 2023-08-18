
`ifndef GUARD_SVT_AMBA_PV_RESPONSE_SV
`define GUARD_SVT_AMBA_PV_RESPONSE_SV

`include "svt_axi_defines.svi"

typedef class svt_amba_pv_response;

/**
    Type corresponding to the amba_pv_response type.

     See <svt_amba_pv_extension>.
 */
 /** @cond PRIVATE */
class svt_amba_pv_response extends uvm_object;

  /** @cond PRIVATE */
  local svt_amba_pv::resp_t m_resp;
  local bit m_datatransfer = 0;
  local bit m_error = 0;
  local bit m_passdirty = 0;
  local bit m_isshared = 0;
  local bit m_wasunique = 0;
  /** @endcond */

  `uvm_object_utils_begin(svt_amba_pv_response)
    `uvm_field_enum(svt_amba_pv::resp_t, m_resp, UVM_ALL_ON)
    `uvm_field_int(m_datatransfer, UVM_ALL_ON)
    `uvm_field_int(m_error,        UVM_ALL_ON)
    `uvm_field_int(m_passdirty,    UVM_ALL_ON)
    `uvm_field_int(m_isshared,     UVM_ALL_ON)
    `uvm_field_int(m_wasunique,    UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "svt_amba_pv_response");

  /** Specify the response status */
  extern function void set_resp(svt_amba_pv::resp_t resp);

  /** Return the response status */
  extern function svt_amba_pv::resp_t get_resp();

  /** Return TRUE if the response is OKAY */
  extern function bit is_okay();

  /** Specify an OKAY response */
  extern function void set_okay();

  /** Return TRUE if the response is EXOKAY */
  extern function bit is_exokay();

  /** Specify an EXOKAY response */
  extern function void set_exokay();

  /** Return TRUE if the response is SLVERR */
  extern function bit is_slverr();

  /** Specify a SLVERR response */
  extern function void set_slverr();

  /** Return TRUE if the response is DECERR */
  extern function bit is_decerr();

  /** Specify a DECERR response */
  extern function void set_decerr();

  /** Return TRUE of the PassDirty attribute is set */
  extern function bit is_pass_dirty();

  /** Specify the PassDirty attribute. Defaults to 1 */
  extern function void set_pass_dirty(bit dirty = 1);

  /** Return TRUE of the Shared attribute is set */
  extern function bit is_shared();

  /** Specify the Shared attribute. Defaults to 1 */
  extern function void set_shared(bit shared = 1);

  /** Return TRUE of the DataTransfer attribute is set */
  extern function bit is_snoop_data_transfer();

  /** Specify the DataTransfer attribute. Defaults to 1 */
  extern function void set_snoop_data_transfer(bit xfer = 1);

  /** Return TRUE of the Error attribute is set */
  extern function bit is_snoop_error();

  /** Specify the Error attribute. Defaults to 1 */
  extern function void set_snoop_error(bit err = 1);

  /** Return TRUE of the WasUnique attribute is set */
  extern function bit is_snoop_was_unique();

  /** Specify the WasUnique attribute. Defaults to 1 */
  extern function void set_snoop_was_unique(bit was_unique = 1);

  /** Reset the properties of this class instance to their default values */
  extern function void reset();

endclass
/** @endcond */

`protected
?OBZT6=Q@J&eR7Y+T2ST:.5\SD3:ZGHO9V-,?#LLCE#4=35T>V))6)_&1,)V-X.b
V?PJ\:2=)5g6K2f52MXE<++HXZY:F_DG5VW6gM1[<Q2\SKQ0KY>8(;gc71\Mf.,#
+:?S2CY5MK(:K7[Eb4U=#B):UF:TF;6_YXB8Q@c/SC;?dT\QRcU]-F7K0bY-:NAe
/QT9-3D1.DaN[H(2Df,-\3?:Xg-INc#_&[R27c1(U-RX0+N]RDT)6Sd(198)^D1Z
e;=KS[0..37J;P;/?0^6.>>VNR)CSbY:2eL1a#[2PC0:\5V2f)a#G(Me>/>Ya/9@
1]2O/K2B&DDe>7BK2YLFYHHUA\b]C(B9D40@@M#I?FQBeU<I#Ag0E773ROP9g]KS
f_VKO7>/<W8>bI(1[b=ZUES]/WNX;bTJ>G?\f2gHb/WbQL:g.A_2I7Q12I_,7:IK
O4C6H7I@70UO\G2X4c]PPfV,OGLFe>:7dBBSKTR&;\9HdHLY]9Q_A+_H1=B5[[L#
:+KEN3/O->H[XA,#bVL-cK[[):XYRY\I>g<25eB.XS/-C(+CG>?&)7]^VL8RVG6@
F.]Cg2K.gEXXB1g,:,:)#2>L\?dCI18)gP][X(5V60TNRRF#XP6OgMU:L4-PGEER
Y>[5d47:--WG;)XOGVJ(8+g^R2OA@]JWgg=(29^?<G)[)R/Z+ffL,^7XK3J=RF)/
HeQU=]_LE2]R?0#UgMK-?QV[];@;0PH64<VG#dYSF6;0B=/+9Nf7A;1B[(S]bAMB
,/G4dg2a#7708b>D.:3_ER2+OHgU,<1bO8PeB_:@@f.@J>9JETFgAZ=2P0#O>S6G
]RP+Q,b=R4M\_6SZYP29B1@(b\Y<RS19T45UTOd_B#2?9^&Z#RO0Cg6.,c8S)dO#
K7ZR@Kb(We0:71OTfK>17TL^;O8/gJM3[P#OJBKQ[EXPY#N9)]Tb;\Y^@53T6cdX
O@]_QWP5]P^&:<GG)&^;A2IR.BcQcXN?a6#@P5TI[8eXZ?)Hd(3dM;Y9X#:C8Tc(
/bGgWW<AR.?FUW)>8f_YHCP<ffO-^c5ES3W)#3V_bQbeTN7KRbAR-7_F2f4VJAY/
J:Dc]C=\XJe\^>b@CR\f>=89].bRTB\X1X?&&W]B<_&1:XaOK#4#/@EY.1>JMfE\
YdMYDb.c,\J7CO&S5X<4R1bTQ>:MF7M113@Vef.SL]g&C(YLOU@FM:PMT.S[L&(R
eVYeW4RH-C/VEC:NJYV9e=Caf2;c^,d10\S2:GaY+7RecP:LeL7OI&#@@T7C098R
LB.#^>dGWMRE0a\8XcY?/WC8.>6OgP27IZDNA/GEB_<g75.BU?d7IOG>3AVV<aL8
?eVE8//Kg+?<8]<GY)ZL6+HQR-W#CQ@W7Q(DV.?U0-VJRf,8<KWHR[F6BaVc/-1J
2Z/_+Y>;;WBfe4^;?e:XfGRG:2Xg=)V3]:SEUM-D?H7SU1#G9AMJ.FO7)XO0L;<]
Z3W+cc?]OX[SNS+A-@a(O8ORU^<fa=IP[7OXYG^W_4I+;.^6UBLfNBDePQK\-\=\
,W(1U\d@@WO_?MU?OVIV653R\QPEI8W#+M#)VgBL#W<61O]VQ.EC9_LZ4D)=<Uf>
-MQU=Y<6f+V.GR_afPW+U>9F927\J74G/L2VeTW=&4YCdT.N;J,UXcDM;+f_aFJ0
-2YaE#(LeO&+PW]TfO9HUf^D=-[c;0<-2+7eJR&\HD1]^PL=5WB.gK4A5Z:[(PMS
.(aP):V&7&6KDHKO[H,CAUVfUc\K1=?276+-K=b&<1TbY/]73N.<HLDP:4>0&+FS
7SMb5=)&-De+I&)4CQ:\HgJ)+]6X<+ZY#1G71KL^ab]/E=D2S[7Z^O4BLTUZ1DL0
gZ8&1e.W;L]b7J^:)T0T2O:;MH,>YdI9PI;V_bd,fY>[?U0AAQ:+[D59^\<W_f[E
2P-C)ZEH8R29@MW,G7D+ZQ/<L8bN5L72LaZ6E]g-G2^CAP=+X0;YK\\_F4HCC7R2
UG93dA,8SNTCg[Nc^8e\BS;A(^&fT_D[^31fa]&W,90cB5/81aZ-Y,edIWDRO_DC
d,a8Y75(\)R>?fXC?0A-aD_P3?HE2E/23<BB>FIDHW>=-+I9)_//:=I9E0O8H[34
3b966IMea8:fA39CNe;J:S>NR+:)7PO.T2c/(YWRb;7cT.d\D9]&7MVY8P1=f&=[
>W=??D^),Z7Ye):I5=O0HVWa]P,WA+>=[W>UXL5O[61FZ.XDL(:g:N3:6C/ELE,E
EMR)Z2/ga:_eIKDI7(P9)eS+>+>Qe1gLJM&.0@/:J08]?(7QI\IGc^YSJW2Q:=G<
7[9]+f_f9a7;MC9Y^6ZMTZKY11P:BfW9eJ_4fQXZf<8+(>W9R?C4BSca]>c>(:?3
]Ua@]:.#@4N5P(D\RJ+dTV[ebQ6cWVZGg=dY@g#YD#UNCS;X^9G@98,C(2HfAb8@
8G0A9@8S17]Z]?F?F6ZX^d6XKI38b2<Gc:eS+_<MfW)0F(14Yf=ZE1.2<0O?#gM:
K?<L\_+TCBG/fN(9ZBH>T&d3Rg6AO0aF7YNX58X7>K3BbI\0W_6:-bT\DM[6#)52
@0A0,\+51,=XK##bB?)X>2aIR1:T].4dcO22.>860O#R:TQa@I]<93?V45Z;ISQW
7&7QS5&?cC,eDKa#6d@CbJ3?W1O;)KDI01J?LbE#6K\JFK#3OZ9bc(#(-b:^)Pc<
J<6c_MX.=6]>[aEEg=O.4RT=a_RI6deK_\dG?ZC(?S6T,8B-/>TK)cC,T7[,RaC/
BF6(eXTPb6T+L\I0URS1EUGHe\RS_EA^H-dd=J#P>DCB\-ZPQLK8^@28DDbgC1Pg
Ge,T^?:3-FeeJ,UMY.;@4A(D;,.f5&&67:P?=?b42EE_+L)0E0;U\fe5KZ<Qg<D6
SS7BB[VJ?.G[<KB?fY:,G3gg3KXHXRM41O0@./HSBReK93>:#<[T;(E,>Y[0X@),
R:R-CQWCA.=Ve<dbUfKc&GbeCb<Z;agR=FU2B@K(39.A?XdaLIHQX.@MC<FT59dB
&(6.,37XNT^8@U1,G<Q(^IQb<QQc65;)b1[3Y#ZF#W-@Zg_5KVFFN^H/.B3E/?OW
,bgJ0J,,OD1RM>c]V)^XU+J]bdQV\+X(\9[Qfg)-5RQ9OAAa5Q^(>@H/J$
`endprotected

      
  `endif // GUARD_SVT_AMBA_PV_RESPONSE_SV
