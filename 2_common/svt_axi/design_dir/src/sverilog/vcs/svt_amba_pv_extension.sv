
`ifndef GUARD_SVT_AMBA_PV_EXTENSION_SV
`define GUARD_SVT_AMBA_PV_EXTENSION_SV

`include "svt_axi_defines.svi"


/**
 * Container class for enum declarations
 */
class svt_amba_pv;

  /** Barrier types */
  typedef enum bit [1:0] {
    NORMAL_ACCESS_RESPECT_BARRIER = `SVT_AXI_NORMAL_ACCESS_RESPECT_BARRIER,
    MEMORY_BARRIER                = `SVT_AXI_MEMORY_BARRIER,
    NORMAL_ACCESS_IGNORE_BARRIER  = `SVT_AXI_NORMAL_ACCESS_IGNORE_BARRIER,
    SYNC_BARRIER                  = `SVT_AXI_SYNC_BARRIER
  } bar_t;

  /** Burst types */
  typedef enum bit[1:0] {
    FIXED = `SVT_AXI_TRANSACTION_BURST_FIXED,
    INCR =  `SVT_AXI_TRANSACTION_BURST_INCR,
    WRAP =  `SVT_AXI_TRANSACTION_BURST_WRAP
  } burst_t;

  /** Domain types */
  typedef enum bit [1:0] {
    NONSHAREABLE      = `SVT_AXI_DOMAIN_TYPE_NONSHAREABLE,
    INNERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_INNERSHAREABLE,
    OUTERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_OUTERSHAREABLE,
    SYSTEMSHAREABLE   = `SVT_AXI_DOMAIN_TYPE_SYSTEMSHAREABLE
  } domain_t;


  /** DVM Message types */
  typedef enum bit [2:0] {
    TLB_INVALIDATE                        = 'h0, /**< TLB invalidate */
    BRANCH_PREDICTOR_INVALIDATE           = 'h1, /**< Branch predictor invalidate */
    PHYSICAL_INSTRUCTION_CACHE_INVALIDATE = 'h2, /**< Physical instruction cache invalidate */
    VIRTUAL_INSTRUCTION_CACHE_INVALIDATE  = 'h3, /**< Virtual instruction cache invalidate */
    SYNC                                  = 'h4, /**< Synchronisation message */
    HINT                                  = 'h6  /**< Reserved message type for future Hint messages */
  } dvm_message_t;
  

  /** DVM OS type */
  typedef enum bit [1:0] {
    HYPERVISOR_OR_GUEST = 'h0, /**< Transaction applies to hypervisor and all Guest OS*/
    GUEST               = 'h2, /**< Transaction applies to Guest OS */
    HYPERVISOR          = 'h3  /**< Transaction applies to hypervisor */
  } dvm_os_t;

  /** DVM Security type */
  typedef enum bit [1:0] {
    AMBA_PV_SECURE_AND_NON_SECURE = 'h0, /**< Transaction applies to Secure and Non-secure */
    AMBA_PV_SECURE_ONLY           = 'h2, /**< Transaction applies to Secure only */
    AMBA_PV_NON_SECURE_ONLY       = 'h3  /**< Transaction applies to Non-secure only */
  } dvm_security_t;
  
  /** Response type */
  typedef enum bit [1:0] {
    OKAY    = `SVT_AXI_OKAY_RESPONSE,
    EXOKAY  = `SVT_AXI_EXOKAY_RESPONSE,
    SLVERR = `SVT_AXI_SLVERR_RESPONSE,
    DECERR  = `SVT_AXI_DECERR_RESPONSE
  } resp_t;

endclass


typedef class svt_amba_pv_response;

/**
    TLM 2.0 Generic Payload extension class used to model AXI transactions
    using a LT coding style. It corresponds to the ARM amba_pv_extension class.
    See the ARM AMBA-PV Extensions to OSCI TLM 2.0 Reference Manual for detailed
    documentation.
 
    It is not designed to be used directly (for example, it is not randomizable).
    Rather, it is used to interface an AMBA-PV component to the corresponding
    SVT VIP.
 
    Does not support user-defined attributes.
 
  */

class svt_amba_pv_extension extends uvm_tlm_extension#(svt_amba_pv_extension);

  /**
   * Methods from the amba_pv_extension class.
   */

  /** @cond PRIVATE */
  local int unsigned          m_length;
  local int unsigned          m_size;
  local svt_amba_pv::burst_t  m_burst;
  local svt_amba_pv_response  m_response;
  local svt_amba_pv_response  m_response_array[];
  local bit                   m_response_array_complete;
  /** @endcond */

  /** Specify the number of transfer beats of the burst */
  extern function void set_length(int unsigned length);

  /** Get the number of transfer beats in the burst */
  extern function int unsigned get_length();

  /** Specify the number of bytes in a transfer beat */
  extern function void set_size(int unsigned size);

  /** Get the number of bytes in a transfer beat */
  extern function int unsigned get_size();

  /** Specify the type of burst */
  extern function void set_burst(svt_amba_pv::burst_t burst);

  /** Get the type of burst */
  extern function svt_amba_pv::burst_t get_burst();

  /** Specify the overall response status */
  extern function void set_resp(svt_amba_pv::resp_t resp);

  /** Get the overall response status */
  extern function svt_amba_pv::resp_t get_resp();

  /** Return TRUE if the overall response is OKAY */
  extern function bit is_okay();

  /** Specify an OKAY overall response */
  extern function void set_okay();

  /** Return TRUE if the overall response is EXOKAY */
  extern function bit is_exokay();

  /** Specify an EXOKAY overall response */
  extern function void set_exokay();

  /** Return TRUE if the overall response is SLVERR */
  extern function bit is_slverr();

  /** Specify a SLVERR overall response */
  extern function void set_slverr();

  /** Return TRUE if the overall response is DECERR */
  extern function bit is_decerr();

  /** Specify a DECERR overall response */
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

  /** Get the overall response descritpor */
  extern function svt_amba_pv_response get_response();

  /** Set the response descriptor for the individual transfer beats */
  extern function void set_response_array(ref svt_amba_pv_response from_array[]);

  /** Get the response descriptor for each individual transfer beats */
  extern function void get_response_array(ref svt_amba_pv_response to_array[]);

  /** Indicate that there is a response descriptor for each transfer beat */
  extern function void set_response_array_complete(bit complete = 1);

  /** Return TRUE if there is a response descriptor for each transfer beat */
  extern function bit is_response_array_complete();

  /** Reset the properties of this class instance to their default values */
  extern function void reset();

  /**
   * Methods (that would have been inherited) from the amba_pv_control class.
   */

  /** @cond PRIVATE */
  local int unsigned m_id;
  local bit m_privileged;
  local bit m_non_secure;
  local bit m_instruction;
  local bit m_exclusive;
  local bit m_locked;
  local bit m_bufferable;
  local bit m_read_allocate;
  local bit m_allocate;
  local bit m_write_allocate;
  local bit m_modifiable;
  local int unsigned m_qos;
  local int unsigned m_region;
  local int unsigned m_user;
  local bit [3:0] m_snoop;
  local svt_amba_pv::domain_t m_domain;
  local svt_amba_pv::bar_t m_bar;
  /** @endcond */

  /** Specify the tranasction ID */
  extern function void set_id (int unsigned id);

  /** Get the transaction ID */
  extern function int unsigned get_id ();

  /** Specify the value of the PRIVILEGED attribute */
  extern function void set_privileged (bit priv = 1);

  /** Return TRUE if the PRIVILEGED attribute is set */
  extern function bit is_privileged ();

  /** Specify the value of the NONSECURE attribute */
  extern function void set_non_secure (bit nonsec = 1);

  /** Return TRUE if the NONSECURE attribute is set */
  extern function bit is_non_secure ();

  /** Specify the value of the INSTRUCTION attribute */
  extern function void set_instruction (bit instr = 1);

  /** Return TRUE if the INSTRUCTION attribute is set */
  extern function bit is_instruction ();

  /** Specify the value of the EXCLUSIVE attribute */
  extern function void set_exclusive (bit excl = 1);

  /** Return TRUE if the EXCLUSIVE attribute is set */
  extern function bit is_exclusive ();

  /** Specify the value of the LOCKED attribute */
  extern function void set_locked (bit locked = 1);

  /** Return TRUE if the LOCKED attribute is set */
  extern function bit is_locked ();

  /** Specify the value of the BUFFERABLE attribute */
  extern function void set_bufferable (bit buff = 1);

  /** Return TRUE if the BUFFERABLE attribute is set */
  extern function bit is_bufferable ();

  /** Specify the value of the CACHEABLE attribute */
  extern function void set_cacheable (bit cache = 1);

  /** Return TRUE if the CACHEABLE attribute is set */
  extern function bit is_cacheable ();

  /** Specify the value of the READ_ALLOC attribute */
  extern function void set_read_allocate (bit alloc = 1);

  /** Return TRUE if the READ_ALLOC attribute is set */
  extern function bit is_read_allocate ();

  /** Specify the value of the WRITE_ALLOC attribute */
  extern function void set_write_allocate (bit alloc = 1);

  /** Return TRUE if the WRITE_ALLOC attribute is set */
  extern function bit is_write_allocate ();

  /** Specify the value of the MODIFIABLE attribute */
  extern function void set_modifiable(bit mod = 1);

  /** Return TRUE if the MODIFIABLE attribute is set */
  extern function bit is_modifiable();

  `ifdef SVT_AHB_V6_ENABLE
  /** If AHB_V6 is enabled, then specify the value of ALLOCATE (HPROT[4]) attribute */
  extern function void set_allocate(bit allocate =1);

  /** If AHB_V6 is enabled, then return TRUE if ALLOCATE(HPROT[4]) attribute is set */
  extern function bit is_allocate();
  `endif

  /** Specify the value of the OTHER_ALLOC attribute on READ transactions */
  extern function void set_read_other_allocate(bit alloc = 1);

  /** Return TRUE if the OTHER_ALLOC attribute on READ transaction is set */
  extern function bit is_read_other_allocate();

  /** Specify the value of the OTHER_ALLOC attribute on WRITE transactions */
  extern function void set_write_other_allocate(bit alloc = 1);

  /** Return TRUE if the OTHER_ALLOC attribute on WRITE transaction is set */
  extern function bit is_write_other_allocate();

  /** Specify the value of the Quality of Service attribute */
  extern function void set_qos(int unsigned qos);

  /** Return the value of the Qualitify of service attribute */
  extern function int unsigned get_qos();

  /** Specify the region ID */
  extern function void set_region(int unsigned region);

  /** Return the region ID */
  extern function int unsigned get_region();

  /** Specify a user-interpreted value */
  extern function void set_user(int unsigned user);

  /** Return the user-interpreted value */
  extern function int unsigned get_user();

  /** Specify the AxSNOOP value for the transaction */
  extern function void set_snoop(bit [3:0] AxSNOOP);

  /** Return the AxSNOOP value */
  extern function bit [3:0] get_snoop();

  /** Specify the type of the domain */
  extern function void set_domain(svt_amba_pv::domain_t domain);

  /** Return the type of the domain */
  extern function svt_amba_pv::domain_t get_domain();

  /** Specify the barrier type */
  extern function void set_bar(svt_amba_pv::bar_t bar);

  /* Get the barrier type */
  extern function svt_amba_pv::bar_t get_bar();

  /**
   * Methods (that would have been inherited) from the amba_pv_dvm class.
   */

  /** @cond PRIVATE */
  local int unsigned m_dvm_transaction;
  local longint unsigned m_dvm_additional_address;
  local bit m_dvm_completion;
  /** @endcond */

  /** Specify the DVM transaction opcode */
  extern function void set_dvm_transaction(int unsigned trans);

  /** Get the DVM transaction opcode */
  extern function int unsigned get_dvm_transaction();

  /** Set the additional address in the DVM opcode */
  extern function void set_dvm_additional_address(longint unsigned addr);

  /** Return TRUE if the DVM opcode indicates that an additional address is present */
  extern function bit is_dvm_additional_address_set();

  /** Return the DVM additional address if present */
  extern function longint unsigned get_dvm_additional_address();

  /** Set the VMID in the DVM transaction opcode */
  extern function void set_dvm_vmid(int unsigned vmid);

  /** Return TRUE if the DVM opcode indicates that an VMID is present */
  extern function bit is_dvm_vmid_set();

  /** Return the VMID if present in the DVM opcode */
  extern function int unsigned get_dvm_vmid();

  /** Set the ASID in the DVM transaction opcode */
  extern function void set_dvm_asid(int unsigned asid);

  /** Return TRUE if the DVM opcode indicates that an ASID is present */
  extern function bit is_dvm_asid_set();

  /** Return the ASID if present in the DVM opcode */
  extern function int unsigned get_dvm_asid();

  /** Set the virtual index in the DVM transaction opcode */
  extern function void set_dvm_virtual_index(int unsigned vidx);

  /** Return TRUE if the DVM opcode indicates that a virtual index is present */
  extern function bit is_dvm_virtual_index_set();

  /** Return the virtual index if present in the DVM opcode */
  extern function int unsigned get_dvm_virtual_index();

  /** Set the Completion bit in the DVM transaction opcode */
  extern function void set_dvm_completion(bit compl = 1);

  /** Return TRUE if the DVM opcode indicates that the Competion bit is set */
  extern function bit is_dvm_completion_set();

  /** Set the DVM message type in the DVM transaction opcode */
  extern function void set_dvm_message_type(svt_amba_pv::dvm_message_t msg);

  /** Return the DVM message type in the DVM opcode */
  extern function svt_amba_pv::dvm_message_t get_dvm_message_type();

  /** Set the OS in the DVM transaction opcode */
  extern function void set_dvm_os(svt_amba_pv::dvm_os_t os);

  /** Return the DVM OS in the DVM opcode */
  extern function svt_amba_pv::dvm_os_t get_dvm_os();

  /** Set the security type in the DVM transaction opcode */
  extern function void set_dvm_security(svt_amba_pv::dvm_security_t sec);

  /** Return the DVM security type in the DVM opcode */
  extern function svt_amba_pv::dvm_security_t get_dvm_security();

  `uvm_object_utils_begin(svt_amba_pv_extension)
    `uvm_field_int(m_length,                   UVM_ALL_ON)
    `uvm_field_int(m_size,                     UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::burst_t, m_burst, UVM_ALL_ON)
    `uvm_field_object(m_response,              UVM_ALL_ON)
    `uvm_field_array_object(m_response_array,  UVM_ALL_ON)
    `uvm_field_int(m_response_array_complete,  UVM_ALL_ON)

    `uvm_field_int(m_id,                       UVM_ALL_ON)
    `uvm_field_int(m_privileged,               UVM_ALL_ON)
    `uvm_field_int(m_non_secure,               UVM_ALL_ON)
    `uvm_field_int(m_instruction,              UVM_ALL_ON)
    `uvm_field_int(m_exclusive,                UVM_ALL_ON)
    `uvm_field_int(m_locked,                   UVM_ALL_ON)
    `uvm_field_int(m_bufferable,               UVM_ALL_ON)
    `uvm_field_int(m_read_allocate,            UVM_ALL_ON)
    `uvm_field_int(m_allocate,            UVM_ALL_ON)
    `uvm_field_int(m_write_allocate,           UVM_ALL_ON)
    `uvm_field_int(m_modifiable,               UVM_ALL_ON)
    `uvm_field_int(m_qos,                      UVM_ALL_ON)
    `uvm_field_int(m_region,                   UVM_ALL_ON)
    `uvm_field_int(m_user,                     UVM_ALL_ON)
    `uvm_field_int(m_snoop,                    UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::domain_t, m_domain, UVM_ALL_ON)
    `uvm_field_enum(svt_amba_pv::bar_t, m_bar,   UVM_ALL_ON)

    `uvm_field_int(m_dvm_transaction,        UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(m_dvm_additional_address, UVM_ALL_ON)
    `uvm_field_int(m_dvm_completion,         UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "svt_amba_pv_extension");


  /** @cond PRIVATE */

  /*
   * Constants used to abstract the setting/masking of bits in the DVM opcode.
   */
  local const int unsigned VMID_MASK              = 'hFF;
  local const int unsigned VMID_LSB               = 24;
  local const int unsigned VMID_SET               = 1<<6;
  local const int unsigned ASID_MASK              = 'hFF;
  local const int unsigned ASID_LSB               = 16;
  local const int unsigned ASID_SET               = 1<<5;
  local const int unsigned VIRTUAL_INDEX_MASK     = 'hFFFF;
  local const int unsigned VIRTUAL_INDEX_LSB      = 16;
  local const int unsigned VIRTUAL_INDEX_SET      = (1<<6) | (1<<5);
  local const int unsigned TYPE_MASK              = 'h7;
  local const int unsigned TYPE_LSB               = 12;
  local const int unsigned OS_MASK                = 'h3;
  local const int unsigned OS_LSB                 = 10;
  local const int unsigned SECURITY_MASK          = 'h3;
  local const int unsigned SECURITY_LSB           = 8;
  local const int unsigned ADDITIONAL_ADDRESS_SET = 1<<0;
  /** @endcond */

endclass


`protected
=U[M/JcQTYcUY4TO3e^A-912?K6Sgc,=>][>>1E]>PL6J(Pa5B@A5)-Z2P&O)&:X
Z3)Ca>;)7HKd[-ZL&0YS_NH58:LD,P;[JB.JAPG5g1YgSF@^;&dDV1)_V3BG/eBR
Cc,,C=6FWF5Z[[_7.K2-d-R/\;-WG4?\DA]\-O<94V_-U3NVbSE?#E[4?aMSd62E
b8G>^^DdbDA6=3>].RWK_=LEHX9-9-.-Z543DIV-g_+Q@O]Lda,D<8T:OBe6RZaX
8#B+0^;\-SaYDC]H7XUe^f_0QF_c\@BW#@V,=;4F,EU:9PZLCa5e;HDP)L_Y7)[P
O]81W9/fe]d03Z4\N[aKcM:3B]<Fd3YK)GEEU2.^MP=DX):CW;E?O96CdfX,MgGF
_XZ?\]2eP([+H=T4AX,aKg1.PKA]+If#JHA_@2[,Q/P,IT@cO_]ceO&CE49GAF&:
CT+_I^=e3/A/HYPb;;R/b,BO[dK(a(-@#0/cIVG=EWT,@DU?cMe4/IY5PB(,:SfD
R,/\_H^c<F^Qd69L(XZXEH>5PIU<D;[AdXUO/3VO;E#DNg)Y;<33N_Q4H4@;[M<2
PQQ6+=<<64FCXQe#J.=Y8_,6\FYCG6J2&0]5g0KL=8S#dWK+)U#d@-O^><H>RE=<
:A.9FI;ODQI9B3JPbeARAFDWeeS3VJ]1\>0g@=#F-eOC>)ILRX8_#Z:(413Jd54^
U=-LH0)_;@)0S:;-=ASXgC&ZE1UTfTXV&G7/20?1dDQ3Z@4aOX5/FaU[bS(=NNC4
OG5J._^8OgB^N<_L0&N(#MP/(?)K?;;[W:9UYe(2\7QV/-E=H-;gCCPGL9RZ7SQe
7G3]VF;+ZIdPEZZE5QWUGWW&N.]99H63bK-f5O6PdfI_b>N[26T1[/^]+D]1b6Y7
[4OWEZe3aSfQN]G5O5&(a1U3=QO+(a1eX:e<9\I[,HMdIG/:b?QD?&e<[FC.T6A6
fZEJC<4^[^0@.TJAYYC)/.fGKSg<C6QYZTa&#d>VU\cUN]cPCSAM58[]4dGPI^G^
0;8;6G1RL<^N_8[UL@TT?H\;<\6M_?9geQ^U;48c1B(H:#&4[5+UJT.\X43+2]>+
E+\4W4WQQdg-WUP3Z)>HcHW:aG7LgaME56GE_+A)VT7PS2MPf=Nd?+L4^I&1HGIZ
0.cE8HO+[S)BKVBDO;JZ#])[I2ed_fII?H#Z6XR/<+@ggE1Fg:K3ENd^6<9fGe+=
&@(.8W(_V,[WO23^&2=S+\\@EWdO:Q:gVZb#S=gI^c(gIQ\]fKUCH>2c[X=A.>bc
eTC(c9HdQ_d[Q1[,=Q6S1S8QQZ10V+dA<=P2+C^1RK=DbS7g[Z#8/B)JaOI-FdX5
YX+W]0BF-B?[Ie3W:(4:YfP4b?\[QIQTRaMBS<:,(.01=WaB)Bb_CH>+J_06O\a)
@&CcHNEc;^UHEBWBdaU@daUbS<07Z.a&[-+^P+R_,;-WA\+>Lg>AKRJ#-,M_H4?a
CZ4b<..Z3g\K^XeF]W2([-D8K[FM5391[gE;ZcN<=&?4U#S5bYcc\2QZOT_2G6@W
-e6WYS.D/b:EfaON>A[+0UZR>T5Cc5f2cVE3N=4Q_cM;5M538=bZ32eF-=XU9&ag
&-S:9UO2;R=gf4[I=HP7c7]gWAG\aE+)-gTTU)Ab]/C.3a9-8[;fT^SgLaa<;E:I
b-C9]\5La2\Qc7eBCQCB)Bb?GMPZR]d0I?@da4H[8H6Y)MHF4X<I7PHC9BPYHQT1
0:.4I0X0b2IY896]=MH>_c6/gZ):V3a>Q2C=6<4#KDCf0O6HO=8A&bKWbTa@\]D@
@bRE,Id]KGZDBU3VAA&X2FQ(\Y0S1P)._)<S6)..=_+TCCUS7]TdLHe(./A5LQA2
1MN@O32TQ>g7KX>495K0@[ZIZ3+^M9.8)2K5C?f&#d?0&@52e/N[\;36=4RFX^Id
?d+MDEUXOANc-Y?@W.J>6]cFQJ]Cbd0V_ZZYNe1=LI#gDcaMLRgR9OU4aBFKL2IR
ERN4g_#5gMY8ZUG9#5<49<9#8N,GUC,\.M.c/eHZOdg#U5U2_g5+>1F1?[L@48eF
PG2OA#&_>VD[G[d^,Z^f9>9>OB4eI3R[F_/GA&7g>fGK2KF5DUN#04,B+N\WB1Q[
E=L,=P)_ESTJM5PaZHd<KU:&#GP##\\-Hd.IFF\XWZ9G]_UNe&-bcYHY)FR8W49G
#eJKQKTRd;+8@>RHHVUG^)HJ(C.<,+gHJ],&95.bSI.>+5H_eJ#RAL>VAWJeR2.Q
98_0[:][<=-X(cW<:e^6(?OY8<PgDRCHLO^/f]XLGBHa==TMfQ<8L61[[3MF(NYB
RA?JbMDN(\\1eSZEZWKW@/XA:;-+_a>E?I4P[4F?[4bR5>,W2I?I/cUcdV#?Y1^I
ETQFIU2AY+79?GGP4a6(F(GS_R]c<47gL>cTA,,f5,;GgRc.B.91(<2Wd))e@g6<
a6J4#1aQI/afHI52NJ:56E&W6)GR](MK+9dgHL0b4<O?_[BTbII8V6Jb+I;[aQ)5
\C/V2gc;U^>2M#KLP+AYVLX:=gGKcFBAaU(^(A:,0A0ID8VGg(QU&&:fP+RJfT78
Ua>N_cX26\HL&8Gg4,_79WW^;e:9VGY.b_HM-NYP-G?:e@Pd-0EJ3:AE79)I;M-]
E>1QARLV>cD2.b_^P^K=OB/d7bb-;f.GGTbJ>EJ??<</@E]-ZN>>]4W\^N0_Xa-6
+9B?&(B;=_W9S:d;QCEJ,U&:Pd9AM9SC>/[GI,8#_)>eMZ&EH9KKOP[O@9E7a90K
,e8R85?AQWKS.285UBR3[8BFX/?B&G37/5XJ\1P7eI(_R?Q0/8/+BS_QTc=E_1UP
:XL:S5U9Wb<5\-b]+0>]_MC)WOY0ZHD7D?U_d.;2M#O.,X4UFJ#.GNJ&8?1HQV:b
.86KSEYVCN27M/3LH\GJ997O05JCM13XR8]4[=RRL+VK\aG^2SJ@N?Y)TDfE8Qd1
c,Q[+/.F3^e];)\F7?Y]b/S[UKFaCTE<EKT\B+9@ffKFWFaT_YAd0Kf3:24G,W)4
YKG\=92</9^K9f/&[Uf0A1L-0D4aFF)]A]e1.f^eg12QHF:K<g1](SW9eMQ_C49K
2?dg>WG+:86^AFA#CJ87<#WESdL@ZZ5dOX(::6a40&Q[-R>?&?a2??>L:=[T)eUT
]N[5&C]VQ<eZc#7VR0K&36=OW&WCDL)bKTgIgDXQID)EBY<<M129U6&CbF_,.C3/
:VN?T@^0LWeagbO:)5V:]PD)HIFY+ASL@>fdgKfZIT)]R<FdDc.ed8_:.-c8_B,U
_L+VWb/9R3.]?QG]M5\+9]F>+IK\9DWSf]E=+1(UW\NUDd5B7Z37@_@gD4d:0E.J
+@Y#B-7CV\(b5D-/H>R4G=N;G.eaLX,27,IHd7>_I+RSGa+b@P96DSKT>@=T^CBL
:?27PAGF]X-+^G(.02_-W(b-LX9GZcd]D9KC?7KSHD7d/KJHT@G>)CIE3-L+S=9J
^3XHZM^Y7.6Wf_CfOSd44,;8Y=(79bdTXeH?W<JcXPgQ4]M)2HZ,SE9Y-;&E9WM_
g:3ED_K3)ILZ6@RF]BK6Od/e7fWHeK7+S(fWTU;dRR8<>8[=-V;_VTa+Oec5I3;2
+-3)X?bKU-84EX@<\Y-7JK0eHR]0MLO@c:N+)e^4,dBb.Afd8LT28999MXC7/+f(
b:F9_G,&.GA&e@;Y;,[c9ZZ@,f@HHK37)HSe]SIYIOI2d,A,FHH<gK1U#L5)&fXA
8[===.T@/[(0C6<SKG#H0I\/U9VMRH:PV?B;9L2[eW((A:dY+/Q[@G6A:TdLfQ=]
XbMJ.=&R_3,RA\;N^8@CTg#Jcf>\2@a9+Lg.4a<aU@I]MNC)6DA:UEM5e6A[?85b
d@aC&9YEIeb@P@O?-?g]H5^e)>&7fN(V?JG480Dff@<.6G+&X]8)NA38XIf@SIV.
&9.J(Me-5V[9\(A)B/\#cWdcPAe0K7-UP79G8P^3,-7S1^DVFM:QN\,f>\QMb,?d
\0O(K<V#g(W),6(0-,+JBL])cQG=T4GKb8RWTPLSLHO1aKL-S+NfD9?(>PD+]cDJ
g/JT+T?&>.D)R&g)V58;9.W#,9LVH>O/9,?TN,6,)MS_+08b=QfDR1G.@?@LP@73
a@409\I^0Q_ZV>SR.TUG8Z)1e0T_<9H2KfdH]a3CSR@cYY2:Ed.I?O3_:ATBSP,&
#Qa0C1RHgLGZgB6\^(I:-IW,D)#?Z((dKLX(.86WFFd_RWS.g\JSAHQc@8Y1_K@G
)\(DT0OLT78\)96@b8ggL8S@.LA7B<0cN&I,>8WJ&LL/+[G]U;NS,O=3YL-c:E#)
76F@W^A#0&Ga4BE:bY[,;4<OOC8YB/GOOVRMV&RMZV6QdAEXZ-;[K_^B5bZF?90X
S#RebLY1OG4EM618,>ORP._>K-^Jb,R/8N42]=a?a:O<c14b.Le?39:;c?<RFN<^
gQJ;HEB(;Y8Cd&Xg+g;^-KT1Y0:F)ZgN.^B\S&U231Nc?-T6/ef5c4e&C?CQIQ6]
_Oba=J=PWPD<5,,^:^#JYd#V=aZ8abb20GCeG\CR@/XYb^&53g^2Gf[e-1Z7aEg.
FA+6XA,=:a&@2BA262ebA+_8/,Y,.Y29/?9TfaI>FCZ7Z>Nf1X7;_=?M]Nf,RO_V
>QQVY7NLKT&CW>KWC7@QH43Z9,;>PFZ]aW>G^&DVY[U+e_#c&QSa)?5g2KFH3O,,
NO^Ga#=WY;4A>3;eU[9-XTcN]#IgXP_<N.P>##,9D4N/c51D9N=a7dZV+C0@-A@-
9W>ZBDC.^B];/,(RFJGNAB?3.c#gY7UUCTg]I,[f)6G_>V2335E;QJ,2)c,OX4II
@V3=2-gHD^T^\Z2^^YaXJR1&CDIIa33:J/L)_B[GZ.&/O))(J/Y]PF.5VPDYG+a0
OSV;DHE>bBOS?U(a,;a5[^3ecWSYMO#c[_H=2GF)N5W>,>@FPI?QN(4eGHAPDDEM
K,32=4I^?g\g0/;Wbf->LP@\3+g8+?)Z)dYA?+>a?NWU\:e_R5\/(cGMMS@0YOPQ
@NgFF,IQ8d@RfMS#Hg]Z-CN=Q:IQVFS1&9O(B5J,Ga4OUeH&fg)e=H5S3a/L,C/C
9;NML=D[C>[dDAe^2)Z+e1BG[:8QfB[RFa9&aZ\.6+d@5^f0<IS19_,Fg=@ESA+\
X0V0ATG&P+L.(KX12:JX;e]c,8KY10CW1OAA;0dbTfXKWHC5b)QeTDF(O<3N<]ZO
J@CbS-565@5Y_GCeD]@7e&AW^e/b?BH@2:_FSHTfQPbe7\[XRQgU-EUOfb24)7OD
-)Aee&D>K0M(Ag@@A0H+e&\f>&.]0Q6N_^(8U#_S?.Y6c52<F=C+BX)AcY1<I_,J
23]a:NHLQME.d--O]7aGWNDHdDI\,b52^c8:A0O]TEA55.#SgB3PO<2Z;+FSGZ1-
AbX:]?;OI@1J=Zd-T(U6].@L1POe)f@d[7dC]6.B#)/Q:MS08+]Oa_NSMG21Q51(
R\/D793f6BZD\221Q4#>Z#dP3,4R#O3T2KQ,9_dSd?C>:4^[]V[PeNTg-W9d]L(S
fQ=.(e_/C^\#V_,>R([O1WUKTeFC&]#^<EK(g>G3.F>LBQ#e;ZURb.XGS@\X99CP
]F4&@a#A[Z>>b8UD?=2)SR_^X;g9c6@JMcIb++YWG(K[Eaa]/A#?2[KU33H,7A/P
^3L2(DYb_RD@(_B1?HM<9A9@a48Uc]]H,aHH9;Q:fWMFPf)-0^CMbEH.(IX.1[WA
S]X@2#[;]JDV\=(HH8(&-+QR=R^F#W0aC)2EJ:=3fF5F@F2U51/FfR\;[</[]/dF
7H7U;(/F6DOSLGV338SK/227U&U2RFU<LBMKdfYMGU.JD@?4W/.d;DECWb:VOK+#
+VL4)eEI0VK7Q.Vb>M;YHX/)IBXGRKG0.\XUMSZ^T\O=0dFV=KR.U;M7\ZDW,?:2
:7UJEaeXL]#7T+&)Z=eLf<0Vc>_V,_UMVGDe2^)2NI46(GS.5@/=<8BW_+NaLda,
_ND;Vc^5EX\\DJ1CR4):V(\?<V)=U)RN+PT.COEYF_gMEaeBf>4Y0A6P\ScGE.++
0(3Z6F3Y9ZPRd_.M8R<>PTY<G4Kb_+CSP8;8[MJ:cSNCf>5Y<2e)XI;:1TXSN<F2
[7V)9U00Hf58I[B3\V5#GgH0&_]BVAgC-[@M94HPbQ8P+@H#7cbZF(gA2HfR2d0B
/7]SbE_F?gF&9URYV5>dYUBXNOEYY:g)(aE03X+#@D<+Y4=;R?2R.3U6?\46E+5I
e^+#\D.<[bcX,5KE:F\-+[Y4;=>^2?K28UCNJ5W>@c1T>+8F2[dM2A-\L:\.B#E\
XS91Q]e\c=JOZ24#TJAKHWVWfgFT@DPX>,0ARY:SUe_(f79UdZ=9-fVL/N4I@IL?
TYT#aL68,_3U?TB3A_c+Reb/N6HVRD#<7N;;E4S5fZcf]4106NYB6,HM.a;/eeL)
/fGfaP;6Xe0^(8e\fO=<1L8._AL\C#/Qbg8ZJbd:ZO7K9Y5HXCA72UQPO^Xg>IK@
K?2E?7QL/M1ND4N7<TbH?/[fd-18[f(</,UN,H?[-.fJ_\>b@XQTNMZ/Z7AQ05c+
9ba9+DJ7TI^HC[GW5BKD/+HgI-MIU;(MV/(RRJc_\#@GHGge.18&>ZGO38E[GW;Y
]dBa:N,QD&LEYHbPbHGPQ6Y)XPfHSa-ZZb<YN6H[:2^[QDF,2A;2O4N&IQB__7IG
,g9gT)Z-#<0^\001\@G6b/@EA.:dRD;.(Z[-g<KJH;E1_f]#FB.J=6N.:c=RME/5
Bc<d4^aU2gJQ1<f[83],>7EL>>U-90cU\g-^aUC2YOCPC_@-PQ9T)\e)bB@JC1c)
Md97f&P1De:RYfW7H.&BU57#PFM6&?a:X9+..aG1K6E;2PKKN?J[35a<We0S-0a:
ec>[&?CHQV_+b=S,2+<cX=d(C@WLK>K790#@AL\@d64IV;JI>\&F-(aN;+O9SX2)
.C^#\P)g0EL/Vg60>9,_f]#e-[,SaY-;:5U1eceR7L1?4<?^;HH4SK)?BAY/ac>8
Z=Q49\a/dTQG5(N@3(L0a49@X8HaM\(d;.cc>EQNPXK<TF),NE27Ua[U-_a9Ld?#
)>?U.Dd?06-M)Ia6KDIYE@E<IgAU1f&d(5,95DTGf/:A#KCG-?dGVbHcEA(>^c>.
,eP(K47Y1:+D,REI\?J0W]WOS<Ia_Qf(;>SaLEFT/_F-_+?P@/Gg=?ANfWGL.;#,
Y^Q^V+a@W:>Sc^]YZVB:eH1K:_]][&K^0]R@ecX-O^U_1/:GWCFY^]H4Sc-:W]CY
\W4D]>92S:MZ>>0fF^>IFUb8W:YZ<A?QeS).UAJ(/@Q99R/R3_]OF+R/L<L951)c
RY.Z@W4K)#=L9RC-I-^cY03_.XCK1(?N?^DQ=#]?@TfgS,8gB3@KIC.^C2FC]e(c
54[7(7N([@Z3D9(A=D;9;98.E)15)M.ZDNJO^XQY[d/NO.:B.aaYLEA.#9_eEdU)
3f3Z<6L.?e6;YLM&IJ8Q.ZSN1Z<EH:KU#OeTUV/J.@d7IRaMg31QSX=:d8Ea[]CN
f6)2@K+TO?(9V8RJ:N,<MY0E@?N)cD>L?Kd/FfAJ7FT(BM:D#N]VcDd(^&KgZfFJ
AVNa<,N(H4<gF>GW;4TJBaN^L?VeRW\UN2#=(E:g;KcGU/;;W_Z8#AKCc3Y#\0&P
f<#88N4UY:3W1JN_#a^IQ,W@a=d(,?fa(Q<C7:6.3_H8DfR+Q9Z.S0Ac-Ib8&@:g
6@[/924cAYRI;??E@C&J=\7b2@JW8AQF&0YR7;cA)efD(8/H-]8:FXSe^OYPY0_;
/L<-UP16IP.#:-1d0g-M@2#\IVO.eKADED<ZCa=PXIN@G[/XJSbX.ZXUHUDQ)\Y(
O_,9U;)BD/c3b;ZN:\a_WV=]/Y._[?K:)^X\ddB8QM2B=6gA\M=U;L]d^8LBOOcE
?K.5_F?=]Ba,5ZA@MWe,G/)dCe+>/U01/C#Z[WY?e0H64Y.EV&,C?.GJc3K)ZI57
f4B\16<H#(?_=9\3XfFd2VTgdJ+HRCC2ECR_eS<?:a&,#87TR97(7AT[f.\#0JS^
1LY>eaa,3gK2O(03-V=a5QQcaEVRc9A1DeQB@HaUW?6^HSE14E3a-D9L\H;A>J5c
>.a2K9[#<CZKTf_KWLVBLZ<TK9.aa4:F9@^J7]/RLFa,0UFEO+Ycbb(:EBV>Q<b&
8+?,4Q;,SZZ5d.I53d?NGH57TG@I2^L_-Q,3:5@[HVc?[-.3PU9Z\_<Q=POd4]>A
G,,3NIMP4]]:B5LH2e5?D]D&G4g)8S+e+IT&SBQ9#X+cGX,TC^2dPNSe0fYg93+d
FGLW2d(d=22ZM,+A/+gd\D2fE:OA,2AJ5Q#cKPV?f/0\dHPV0:M)Y3V,ZB?^Vf##
Z_I+_54>+JPU<_gM;+VFKI2F(KKB-+?]GbKF1#7+LVJDDY\/>V9Wa(GB/&;73.I_
(1JV7JNN2FQ)8])2]B-L)IcW6eV0fK:30NQMD/ESdSK/AZ8UHU(SGdST^+SVFWJB
KG10,_:I<)Z].5D#CO5O31I?fSbfgD45>]e5.;=9UbfQPA(e2CeL7?B9[)bb(LXG
f=c2g_+8V^&C2J^GcEODcY^+10.W3JdS-,+Y0gQOXeI61<d\Hf7](V2=dV1c14Q<
9,#3(ZTQaf):;X?AF=:=M9O._VPb1M:YbKC[c(>OQ;@fSW_.bLe?87S7R4bD1?/F
9&#?)Z8:KC;=,?.<dD>ZA9?Z>L?>C>,7<c2KBDSME=K_)GXC<K3c#^O#3I3Y]G7U
PB_?7KA5Ra0eSRPKM854@e:/^1W/#/3(3>+K9BOX.(.&2(JN8)8J+K^Ug[KW#D4G
4a>5H8_\Y)fU&01f>?[21NUcc\MNAVY_Og^E3A]H9)YRc?1[(+GH(AO:(6^[/5BA
CP?D^;BJ>F/Hb1WJcI[C,+8>8ZY.,e8Y45>e(A[2JTADLcEdS<c]TPB^2EW)_,GP
I(Xg,@HXEU)I2C0OD>;49_Q-T)T;^.JPT?_D;3Lf/FBNO)e.UD6b3ZcXJ0CQ\c52
(<.2JJSV9KJg^QGCJc4<af/XA_]C0gSe0UN4dA[_X-&.K&Y+@bO[_/^87#2g>V:)
09fQO^5_04M=d&CbbeUSL13f>Y@414b8Z;@4)1CNQ=fgXC93>Ye\P/.L#52ZfG]X
[]0I1->FEK=@RdRU(&g6f&GFS&7[7H>8#[CI40,;=Z=[7<^AdeD:[N(Q2+OQP.3c
eL41cUXfZC@g.K^N3<X;VPHW[W;a/E?[H]ZH_#He9D=\T5_bRd-K]+dH&&T2GH/A
HB-.4OP/DT=c,CSDBV^3QI7..(MRCJcTW58(ce3NSBR9HEA02QS?KH;(#YUAcHSU
TZJZ3gO;G+6AfUeRLJO;&UR1+68+M?5?7Y_#HeJGH+TE?W0Gg]M\E4(@G#N&+b(_
7eN3&@W,+0Q?e?b2DW@N2(fJ6[V1(?g(PESAcA)5f6Ya?FU&[#R\VL:Wa;M0aWZ;
O7Q?#6f))L:#fP.Dd.2/#ERg6c#=WC@5)KSR(1?P1a&&9X#Z>([H6GHR)cMD#/Dc
D.X6gg,)E0a2?e?a&TYb/AU1FCM-?XY6QRZ21cc[@CAUJEa7OQ[1+\+HMXK4LR9#
?9LM(J1Z#R-BP<ef6:WTBPFOO:LZI_MQ>6TLILJ_BY]1DIXQV=Td#18BD92fQe1A
^d&3Wba4.#Q8,054R,\D.Za4OaZ1eQV.ZaE-)-5D@YIC^37&T>Ge6ASG\P.M#+@S
]OV)G:&JQ48P^@bL+E=P:cGUKf6g^6&-\H:4eMZCC[)f>D>O4_.;Y:]E0f._B_#6
[,<)_WO2;a/eDK=CQ8YfKCL4QZV+\8a]CL^3Q;;K7VFL&SBe:Sa?33MB0)N_J;cU
I=5N?P4L(DXO(XcG.1V7-E.f=N-+[gO1Q:S23XP\I++6Ag,JgR;LS/Y:/#[-EYDA
^?S@Hd?ZK/J(/J78aU2gPd/R6[U.@LU+XXIAS\FBG5@T,-bX8XG.2<EB;8E78@c[
ML.=NdA2MBC/89E@PPIAM@5=\XW46YX(9Yf?)X)H-3>.CE9XQHFWR:Z_<f[]D-b;
;5DEWVf3^0:\HR4PFEL5L=T7Q->f8a^314_27AOYdb3IF\b7#TPQMT9=60)QQ,Y.
1DZ,P@NEfJ1U(@-a6@0+V+V>[(\+O#-?O&bUG5caecHH5(2eL(d2Z>4<\))W<HKZ
Wd@#g56F3#,SPF>8N\JK.;+B)D+RL<)X2&@OXgafLKEgF;@^Y.NP[d3MA,5I4H>+
FM:6(R5bEcET^_c_@<29gO<WD/#<W8<M&1T,?^OEA1(YD(YTbA3Q@Va;KcJee0MO
I=H\-)7KG6ID<K+=;X0^9WZT25K3>.GRPUNR))2<CC+X)R88MNSe];2ZEM]cYR(T
LC3Q/d58F1R#=#=5WN1V_ZX63c.;VDNBFE26(fJ8>1J4+HZU2+U3)3/gL&<7G6+f
\RQEIdP7TTVJ>YCJ7ZJ=gKQ(FfL@gNd]@e)1DM/2+12#_:+V2\)T/_V5N?f+VfGb
GO7dadWVOSOdaaN9;01(D0XW8g2I_Q^^7:JD#&&9eMDc+Ydc)6Be\CL&7P80R?g)
^\:fT#X@gXLMRD5:Y5B&Jf9?gHL-I>(3^P^NZ?T[B^:>F:[5dg\99]9ASUD(1cG<
#56,/5(f+E&.#G<1(0@/3((]7O;EOJAM7L44TLd]a8e(Ge8V,^]4,X:>T(VC:^cI
Y-9&EA@Yg+F/+Jc?/D_.T=CHFGRI-,_KaD9Qc=QbL.^L.@.N,:Q(>a5<7;AY(TOU
2B)/8e&OMR,N:O6KC3T[7]45d\^DI3&M<NM6f?KYN@\T)M093UEH5@,f/CaI@@:b
L7d4>;3cX9VI+@QA_g]>AG&_/836SYZa3bV3-<;?W3J8[G?)4NXGc8LZ9QTALY:\
Qd7c?OVPI.=^DUDeN^2UFCYL/eGNAAIb3DPA-),?=(G7\V](>bZDVVgf,.V;:D0=
X]42(c)XM(>TeYSK:T1P-AbF26@T^5=G()J##Va-PT14d[=S<\??A2EVZDg.:W])
TYILgJeSdRAW,DV6([,DU^^CKXFLJ\S/53IA<DJB1RC2CA(F/(1-QNG+M:W>7Y6W
eaC\_gdX,CTCQFc&_gB=Y_U)REG:SW7bd)Tc]>&O3H4,0K&_b>-e]1K];_NOc.B.
L68PZVG3DNNb[-IDQ,P(C+(SVT=eH;X5O:W33]N+bX@;&NeWHUGPF)DJ[6\UALY;
12c8ZF>O.ZQJ>C[;2B6IKOZX4OgM8?dFMH3#cMATEfLc&R(XbRYd[7QFNI0OY4Z)
GL)WAHD\I&9bDJ?G=T=I?_^@N_G-MMZNac3@CR(6V>e?>J(9ZD?QI_)EZL_Sa,.0
d//W4@<bG53PfHf,e#AY8O4B8bIa:9I1FRa1OXFOaCfM3NE)/YU6G,[Y##K7DLP0
58RZ=5A0[69;(?^GZ.@Bc1SN?5WJ^S.Cd_IM^fWIFULgBCc+_^]GGS+(UNR;E(Jf
[3DDa^,f+#c+8PE(@Hf0EL)I+4P<7ZV73\M_HUb76fTJ5#]-6J?7@[E,68458_2L
WPDP87/XM[DW.C,_VB5;WR^FX_W5;S&^S-+P+dX#Tac&Fe3:37HCFLJT0E4GBYg)
IX8gCGW-OM)L42,[VO5?O4,Z4Y164>\D=5CD3[g].)EI,T<NOCG;B3(Q?IF:IQbG
X&JD5-:D?3fWJXG^KQ_-db6S\:HK,YcgR-RX98bRa?V0D>;#R([T]68Nc?e+.9D<
JEIX3a-(ALUa<LPR8>?#241edKMTKOVW6BSL1K(7>BTQbJH0d8Z&N;f,SK4_(QYR
2L/RY.T)+cY6g/4#S-HV?851)I07e,5>71]IT?Fe7-J7T]U?,T<#,\XD3A6@,\b+
/T5T.W_<7O9.?=[E]-AY<2;&Ag.,2YJ_Va0&TDbXS;=@0=24/7Z:7Je+^WG8WV<D
<LJD/BEc9VRQI>>7;YR5\HR^Y1+]<RUHag^^YTZ+,2@C41U&0Y:FWA(Hd&Ke,YCb
S3]_1MQZS#L+J6c#32&TAb[QY47+MBI6TDa/L,?=WS3HK:<NfA/2.]>L;NYENW@0
Z37I8;A&,6J>O7.-#Rd,eT./&^8.fc^R?-gS+W;E3L-TDb4=Yb1T?AGWU3-Q#E4H
\1@K.gYbJ4gTAJ,8(MYO[R3WUH5<12+>dC9b8Hf:fOS-O[W8XT5:-G/e_Jb[BZ+H
^T)Y2GGEL/5f@J1QMPGXaTQ74WH1@Vc_VA]J=MC-<0ZK=LBQ.S/<UT1OX02Y4d_C
8E/3XRbQ^<\D<]&-,W/E]I]L9)5=,d<DDYE?:LMIHLBGO?_D-aY@]WC.9POL\;C2
.JIS/OG]]W:#:^?:VJ;4+,#L&2=Q_(T>86[GKKOaUOeP9N>TK\5)_b#J70V[E4aV
SASb[.QeY_H4WGEVDf6Udd@gGKY-_?Z,<17US>bOB#^L)c+E>9Se[,WL@(gcJ]11
PXe.2TR42G)b]DbV0WI_W^eE688b\UNJW@6]6NU4Y&<3#^09Q5,-=cX/(P&]991@
ZD?/QWZ4O&;<aNe/a>JVJCZME;bAMUEA([561cKe8OJbJ,0TS\/[-g42XDW]JODe
0Q&_)^+44F3#bBILaN_.^I+#I30-19HJTebG=OU6dH._F2)BOJHZC<UFE4dYb/W9
]S_g#<\&Oe8)J)]a>^._1Q(e.;AUXTBd8/^UF7B8-U/N<Y.W:/5GaX(#e]ad#FcI
58:aJ3V2:F>ZPN_[]IQ<LRfXGO)C]3d4M8SBCG,?U90M-XB6gGW-09/^42O21a);
A;1aM4\0gCBMN[CQ3SS3MJ@E4QX^FG_6>Sb->GN=CT>5L_.7LSU=WCS/E]60S459
@&&]X9N4@&OU-I>H=/(^HFK,#F(_N-:@E0MSKD@,G,Z&^T-MBfc<MegG]&JdDQOV
Q/:d(UPe+;>b??<2&RY,f^5,Ka?AZaKH9H?4g>5^ECU4:KKY@^P&T1)9L14YHd8Q
\[,fA/V\1W3&/;(7]RN4WU38gT4Z_J8+L)0-.V]1Z?1J?-R/;a2:9N9KLa0Id]3T
M+Ac0Kc)H=YUg4)]WF.f]<H/SRD[FT^7N2W-^Q<f3(@N]4WLQ,60V3HJO^.e5D]+
afB-f9D&M[JQB>1fIa5e41DWXGVa6ab,8Cg^,2(bF2Sd]Q&M0>5RBFEL]>d^6\8&
gaT&fC\UGRKJ)Dg#g:2&Nc884HO.9ggUgTTDe=P]I29/9U_J2C8J-F^C44d__/a2
d4YP6g]M8gZ_e+d_^b244?>^fLS<CR8<c;<?,cOf\DO5LC6]NPJd7\cPW:9V6g]U
?@XUZaQD1<]gAT3cE,/D2deS2P@A1EVVZ(f)OYI7/V/gg-NI&a@HWH_?./3D>g3K
\II?E6,adZB+IAUNc4d3CdMDR2[(5f;BT^69U3D-/(;de7bYDXfP0PQg(M.PX&X/
G)X@48QM0]_Fg9f(>.CKY&#F)AgL=K]gE::494Rf_Wg^L:6Y?bY/7Y;J37/cX)g?
.MY&@HQH:PLeNJJ5)3H@G&Ag^N=<K<TfN]#-b)-YA.DTK;V:C-:M/:\D(?fSDC-@
RW=[-c[3YN>-X9-TGX?a3IIP2g]=&[6gX?.TL5gI&20TeC&gEZcI^EN/?:9L-Zc9
-Y+:a\-WE2#ZTR^7R&Q-(W@)MGU]PM_YJYRb-60FDPGCX?dg@\38HT59D]QgB7,e
d,8[+0,2-^SZ(c])KOL6DGZ#;b4dM=PcKO=1c9+)a+Z9<J):+XE,S-Va3Xe0MY;C
eOTYf1e+X(>:GWSG]<DFODTHUKVUJ^W,aB1-G<a3_=,[B-.EgX2(N,Y3G0[O<MJ\
[gb>7+#>/gG\PHZOV^Dff?+fC?&0VAG]7Z=Z5IbZBML&#@A#+A:e@6Pb,>ebE?34
O47[M?0FRbTb2&=QGgY63VRb(eTg[c[aCH5-<+-NcNIRR#=8ZB3d540D(>\>MJc<
c4RCMb(T)FE)53&dIf]K@eDcQX:3[S(c,:133;I;U\Na_OOdf,E>cEJ,_=3>MSK1
YULH.dAHZI[\0A[+1K\M6&ZP.<&=RG<X.<78:\=+2@(G3LTcd25.,\I-HU7?W[#@
LZ^6Rc9<7/<HNK<aX9^&JgFdK5Z5RY/L@SN#-XG^a#D0;?gBRFAF::J.],.CEEA[
V#\<HK1GPY=PY^=a5\aV(LRV-8dQ2X+;N-]AbYNMW[c)#=gK^AgL#?1aTA/C\PI9
A\(OIRI\Eb72GcQTXe#,K1)VA^QYD@Hb&OcR.HP+@/=a]XfJ]1WfQ^LN;XCN@O6c
^FN,YBG]NY6bfBT1e:@ZC24LZ[L[00Q&ff:<&5LeL>WHDZHI=gN(=Z&Q\SH,5:#6
6+(_2<?F:bVc-[gWIPc2c4gWbQ&)9Hg(.:ETPRJ-NV]@#M08&7F?0#Q9)?KB8R9W
[I>\T;0,20UeEJTZ@.5/PS\]?VWS:1:TT;]T2>KG/_]N7K\&A?/b/1GQYL:SX4Qe
SHgdB@R#c5_A<=O0#-,D+.1#:#)1=A[RQLTN.AE3&6(Z_:#,+MXNaZ&[:R:9YHV_
JH@5H=ZV_U(.U>,:ZW&\2<Z)XYa/Ig;W9YBHLMM_GVF&,6cb(B-g7^XV^F2.B;c@
]ga37>Q2E16Rf+.<cQM@9NFW54a4c#KaBT6^+01DL\08M[ZRbD+/cb.cR,.A[A/L
4MHbT;6>\C<@G&d;f21:NAGLX^JK:eHaK&^P:\d6T.=b\B\1TO8cBT5;=ddW7Y+7
=8FSFZPC0IOMOT578CMHdC:]L-,(c]e+ZGDB:Gc1ced576,N=AY_[U/?5D+:?Qe@
]4W,,Lf>^dA70=V:OGgOUIA8VNAFTJMYRgL],g3Yb<JgCHWT;U;&SdGV2T;J<g2/
?-KQ54M]JQL;bOG.)822HTJ(.#,+:cbYU156/Z:)a6,4T/P/_AOVIU5Y2MeB6UTV
?+OE1H.?]LXb;/1WEb,>HA8C^;0+>QB\:Z.bECVPW>OMggP>KWe76F#H5[B.WO1F
5g7SaaL=S]DdO);/SVHI)@f1(aTC>/Y1O(,F)Q=fc-JUG/;.fc5GNfVNAS6Ye?)_
9,8F\7Z7RI]7541Hb&AScH),MC;AJ47:c1&A+Z1fB.P6N)H=UO=.EB]?71ICf^;a
Q<c8&HgJL<L_>)FLMKPP]6(37a8Aa+/IAAD9fg)7WCd]+;Y(6Z/XUcYB.?4.C=Y2
5PF;3.W^X@E(+8H0Rdd05R3;C8^aMFe(/W@4R_;&1Q,UJP#(^C5_8I(HfL1c8aWG
9=100\+U&/OO=9+_H1R-:.Y>9[W(W-C^,Z(^-7^97&,KHJ\[6MTBaB1fg[ea87&K
?5:CUYeP]/,^H_[&?_8R+_e)S@D-P,Yg+VC<3ce<1@SYL;7f8deQA,7.G(DdU_aa
G=)CeTd4V]7fNQ=7Z=+.Q0+:9L)H)TOa.IZHT1]A,L#+cPJGB/)1GB6HAV?a(?RY
>-F-X,V)Z19CaQ?Aa-dIID/TH/O(JU.29U+Q7gYbV#.74@MDH5\X1LQ5[/U]6JCJ
a.:LF_b\(?Q/1I5gEV@F1d0E8>IbaN_d[X6ccV/RO1./XUOKOLf6a:-KO2U#fJ81
SJ1JM=L>6>9Qgd_KIc7,M_A;UQd/\;T\,Eb83)_O](82a+NS&([P_I.^eV^SMX6[
?DI96/CV;B]_C_F85a;gA??^d@8,IUb&O8Z7#[IbU([1a.SGgTDDe>fcV<Wg_f?^
76CZdAP]2&>d:QIYRbN.SHG+_c.Qb9:;^<0W1QNV^YP[)U4<I]LXd;)aD^GX+/@O
498)]>+WA4-DAK2?]f_+#\4<WC<,]BGEYY?O,BU3:4SJT>=)U(cHf6SS2ZM;fVN2
@?LaL@P_>TDS;L3YgBPgOd#\Q]U)P;TOLES&e/;<M@((dQfNb)0XN]@L^P9T:,=2
32/;=/+U8c8a@DORFWZ:84@I[b]L>)R_^^X\^7TRa/N3WDQ2d[@T\I)41ZQ&X..d
&UbT4KPS@Cdg_AFV)PIZ^g&@I=D9Kf31_)ARHQQ:4/GDRN4ef;DSRe<(OeQN_a(F
,=NZ[fI8g2^<g8R8:8.W=CH_/6RH(Y^AbG[V([e6c4b_YJ@RC<K(@FCJDDO-KM?S
eT-CI=3HOHS<)$
`endprotected

      
  `endif // GUARD_SVT_AMBA_PV_EXTENSION_SV
