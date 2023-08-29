//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_sn_transaction_sequencer;
typedef class svt_chi_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_sn_transaction responses
 */
class svt_chi_sn_transaction_sequencer extends svt_sequencer#(svt_chi_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port for completed transactions reported by the monitor */
  `SVT_XVM(analysis_imp) #(svt_chi_transaction, svt_chi_sn_transaction_sequencer) ap;

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

`protected
NXKUCd[K<KNcf&B<?\^B.dOT/?5LQF5OH=&&f/1\4_>PYf7)ZPKQ.)]DDNP;;)La
2-AEHW>C6..^>8P7E(H2IbE6G<]MMQ]c-\Re]6DWeB2Sd[#O&?P4R7DQB/Jd--_;
R&W8[Xb:W=4B3LP5TY@N?6[8gA#dNMMQM(#1X.e<7EO_B>:G=^BdP=\_Sf,7Z8-D
4<?F.:-BH#>Y>-WRUN]VKG(GCSLg^&O\5]AK@^LgP0WB.B+M^/.ITfPTL.(;H:_6
^Gc=SdC<d.^Y0$
`endprotected


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_sn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_chi_sn_transaction_sequencer

`protected
C3:P9c,YgM;;P#\E^SRTb?<[+YTNe[eCW7K+3JKN)DYfH<a9OH\=.)5BHJa-868@
3@)+W@_O3/<)-X1R[6_:TdP-cdA+0Z&;7EDb,+@8-BR:b@.)NY;W)S07Te[S)BG\
?8P)FUDKS/Y[QQgBAC@^D<ORW,X_2\59Sb.2=WDbU]@^WE^P[EP^6?3Q==a&:.79
>S,LX&b7\\806OZY6<e@Y1-LJ\Y1/.QXC]1N4V,Q4GL,U-<#O]M4<Lf>PP>)@8BC
-<8GV=OD.38A:WWG&aLV=_P9:)4MWJ/c/,ZP#AbfZMg9]+IFC#=QS7L&:R<BIF<0
?Z;cgZ=Oe@70RMO4N@JeEE\T(=2EBgB3a4(ESLVe\3Rg[2bUIWc96=&M+T.L].c8
G^)Xa2Z&[82&K3L&],>@XaAA2,H8,:]-<[__\35f,W7gG$
`endprotected


//vcs_vip_protect
`protected
-d[T^<-YT2-K7,L-ERg<,3H[3,:/XQ@<++a4+//DNFJ<JCA#X0Z:+(X^31A^[CK=
++,19@DY8XKMfWHVS-R^I2XM(8Nfg[(^)T.DJ+X]&\<45D?&2[J23Be0<NC@W2Je
]S6).Sab-dCIBZ1MKS@H_8H1d751)X(b)#D:CN006M,A+WR+,78166W6=;3GW&4V
a-DB@#c\+Y)Z8c/5c6[MQ>44E4\RU6cVMD58A=5RPFVG1&a,0V7JLJI6:5Z(VW-P
<5+@WCDG+aQ[?/?][#CCE_SUP#P,Q,b2(?SUeNR-G;BAaJ@dPDE6D7>>J1bGWc@F
b:;gR+5=^ASUcI(-E_Md,5D0OZDVH1H:)DZUIB1b-67fL3WT[HD2@fSJ:1X#R1#R
e@3(D(M5U(HT,B<>+g9fPIdUF=dS=9WMI4fMQ5TC4.)#W4..DWB.Ff),TX^REJOT
#698+/\2C8cRV#,>D(/-+0c6DJ/R2TD-FFeXJDg]ZJOe)NSg&ZRDW9Se2F#7+Q3B
G>f0CP8_E_^=A[@#B#)++6;4g\Pf-@S6CeXQ)97_,0C;DQ]RTPbPO5)A<B75F1XN
@A^OVB[(7+4N,,QZc61^e]RKdGAaX8B),J@0K1SB7YLLQKOT)6;451S4(NLUV#-.
X=KXE#YOQZg+Tg39\F?@AP>\I)L4aW((N?Pd7?+LOW\MF.DaZ#gCdLKb=O]HaFRR
YFHWA5P5Q/\J8):(BI,SY>6#_aX8VPgeY4O6MB+QBE=;@EJJ&A6H,N3KB,dM,X4f
\CS#T4TW7]Z<3SV=UEVbfF)U\UaB7\bg/7Ha=bH<22g?/cGWdS#\;E]U:M9A2^[K
gWN(CBN818LaSF67[cI4;9dUVA4<c^dK<6GZW:0>[\cYSCEVBL_LWgA-f+81@_7/
8Cc8624+]aB,1:P8#e#4@-)Ve>IW/)SI+MTbCTT12d\1d8aYE(J=E1g:@6D9\9\A
ACQd<FWH)Lg1WF/_D^M2G7e?eNS2C],\5PB_NM4fE9M17AdW>J8=)\8>LRO0VbO>
Z2ZRM-G_afgSGY];fFK5De8VOY/,GO]G7:.Y.P76_MHa-NAgY]F1Va&4<c;Q(9W@
9>YDEc:A?2>/?4,_I)OP_Y/#.SLe:^8R&:-\135-3fMYg9Z._QU,[]0f/1/Ea(7;
(?86MaV16EN3G@4Ga65RYL-;F9&1[;-bSHN6RGTf-9,M_fT->D@#9^KE;2LE[c,O
FDf;9-e4e6-SX_Jg+9@,08.a<BK_c=T^GABZgT/Z>W6MGOf^Ug>4257>?bB:YIYO
AL<+X631M?@5+CeXd.#5D]NbQY;)6]0KJB&,K8JCKOXE)#1ASU)DC+bZDYQDa&/[
^5TTa3f3PMaeN9?5]VHQF;f4CH)C[ALMcXNg-7^XGUYVe6BH:11+968,fNV]W<\A
2_EdD<AT^^Y^gLZ98bS#LfOH:/RZNCBLZ-LFG.^N6ZAP)Ra0H\6TeW8^c_CNSLZB
f);W#Ig^0?FDgGg1/0/)&CTT;P#P9\L&63#,HNI(KVG6Sc=?9QgcSZ=>D&:0M.1f
?Z=<CQEZ_GT],HD.QQ<53RHM-::6g(\a0T<ACE#Q_VEMN>W=W&U>05Y98HbHE^J+
eb7^QR](XZTS?5,C>46c\g>=N^_bgH1&@MY--gGg4BbMBQXKPSH,83f=F[AD<,c@
EL858J0,H3DI=bMA5f^N>:MA^+:c^&8H)@9.DOIVXN>J^UB-H3US-J#e7?@383M+
=^^2THCAL5RRZ+_4_4Ea6VB(8U6B[3ZR8f_[gUG?QL-//5=[NXcMgcT?e\<;)e)-
cU?ATYN-,;<9)^\+R:L;EP#)576?MFV^F0OeRQ9>+838:89Q2&^N#ESM<&aT1?:O
I-eTf,d+EfA+NKVRbFd#=(=Z<Q_Wba/6PB5XFXW,,(57,Q9df;c0OCC;#;Q^YE8+
^)a5T\PL1H>:9JbQffQ4b^HU^V^\fdX#-@FS/fC/2X4H_\XWOBXe[c/9QId4DIFC
S>D.eV)+656K?X=Rb>bFKH?bIdCEZWY0BP^eK;<=D>98JU63,6#8+RC#],\0:bZ]
J@]=O_I9bF=]aI\b1#AdN?C=)d04Q?RC(\@SE]#2RF-c0,JN,=75eQ(FW>HEU^JS
DLA7=2HM,)<[AQJ9OGMg?]c=J@G<g2gQ7/D@A-Og;TRNJedUAXY/M\FEE+NAG]3C
5-ZDb.BUTAgZXgKVRM1ZdTHPcK>c7E85edIc\^]HTVb9D@gTeb6gPS)91^H-fKSL
85BgLeYV+F1E8_7@CT]Z;:HE@IPgN)OF\M]ES:K(M4Ve5Z)KZDYQ61Z;IA7a89AR
;]GP(XB<5-L5A=#20Wf;<U=&3S@cf13.X,1d7KMT\YMOC\/4?C&S3\SW=G\.0T>F
57I6)>8,F(6RPQC99La_\Y-#^M1e#/^[W0e/;97W8/I)?H5PcU40eK<^:cR+GV#]
LCGSS^#a[(S=C9>R40fI1<CI.4SOVaXXX)>8+WTILc_c5S)6)?-FR;T)N1^W-UWf
g+TQ]B0?g0<aG_,QA8-0LB?W;L;D_2#c2?f6<[2ZJ;)-3GQ,LCfH;:WMSGXE<76U
+#6TW-9>R2K?71B??\E)\QA7^.6IF<=R9fHb^2-R)0cc^X=_I;J8QT<LJQH;0UB4
[V=2YFNPYE_H&A3I<N+UOWeB7K1(86MgcaH#]R]+[1#QN6O^_;&.Z:g)ZCOf4b^T
3MUE3PSba#gBK6R^S.R4aD8GB40;>R/-dR>3d757B@I1Cc:cNcg&M,R-,Qgc41(b
,(1LI\e_2YI9\_Oc9A3A::MO+WBX<D,8<$
`endprotected


`endif // GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV

