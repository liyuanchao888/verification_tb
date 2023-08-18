
`ifndef GUARD_SVT_APB_MASTER_COMMON_SV
`define GUARD_SVT_APB_MASTER_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_master_monitor;
`ifdef SVT_VMM_TECHNOLOGY
typedef class svt_apb_master_group;
`else
typedef class svt_apb_master_agent;
`endif

class svt_apb_master_common#(type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
                             type DEBUG_MP = virtual svt_apb_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_master_monitor master_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Monitor VIP modport */
  protected MONITOR_MP monitor_mp;

  /** Debug VIP modport */
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_system_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_master_transaction active_xact;
/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when master has driven the valid signal on the port interface.
   * The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when master has completed transaction i.e. for WRITE 
   * transaction this events triggers once master receives the write response and 
   * for READ transaction  this event triggers when master has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

/** @endcond */

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_apb_system_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
 
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /**
   * Creates the transaction inactivity timer
   */
  extern virtual function svt_timer create_xact_inactivity_timer();
 
 
  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);


  /** Tracks pready timeout */
   extern virtual task  track_pready_timeout(svt_apb_master_transaction active_xact);

  /** Executes signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot,
                                                  int                                      slave_id  
                                                );
  
  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UuubFcBW4EbFtLuXzOUB1Y8yt5B12KWd4rMipmLxXVGh7Ovirr4VbIPPKPLSlVV8
jE/0hDCAWbVCSFfeBAOlGEGmHk+KTKSKW1n/GN5CAZtMZqRjZcJXJsMjJoG6HSTU
4ZWh09VMjdTV0cbFUfyRWjjzJ7qTTBmcJLlQv9x8ihOgSODln/l+Dg==
//pragma protect end_key_block
//pragma protect digest_block
FnkpiaFFXJqR0RCc8dZS9ckEdf0=
//pragma protect end_digest_block
//pragma protect data_block
V/xM+lqnJxo7kKInnvOpzIZT/t3fi2+WJ4PdFVePiYfSWxa/Y0tu7P7yEyxsqZWC
FKHo1SP4mg8mSDUJtX8DbB6qTHPJx5pO9FXetFvmsNNmLeCg3SR6i36HdoMfmsex
7xN+PfFEWLSfVdZQuyF/CNhLKni5ngnUWuTitPaE/CA3rd9G+76UFa2W04VIkR3J
/fegFSCDhL4dJPgRTaD6HheWlxyNA/hYjADQlxK71m0YB/wGj7PZPdA7Sxwd/kNo
9ta7Hnw0XK4Zkh258mC0YQ5S3IjhQqKd98qkl87dQWAshLqza2UcrcS9TFvrCuME
sqc89T3LlnSXfUVZw4E+BFPhvCMebeDLoO5A/N0NXEQAWAfd/8Pl6rbq11iOO9jR
fcP9vMFGb7RzrjV16meq4Sjw/qLlNwYfHt+J8YS5Z03DOSBiDBjg10V9yMbi74N3
NFb39BjfG0c2z78XLD4XPOaTProCxKvXRaAB2ELpvm2dCI+G10PJrd3oiuQNvhfm
B4cJ4WXaDj0P4P/YIQ0UctAGSjedojnAr9g9sRTTvmVGyby0nKHsUQE1fRBAT4X6
e2vzSkgg88D0bRewNkyZP3aidK2Khbjv4I5wZFyzmQxxZnAhYnc077JLBFIvT8nv
9xRzZ9Z0ZJtn5ClQ2JhZXawPlLm3MeGYNgbPkw9ezvSfdj3UoxosouqPPW3QEDEL
D46OQoViv2ZfEFVD1zh9hV+n1Q0tGyTZOcalv8ntxU4IMBz1Hln67P5P0roatriU
v06cM8tSiubKuHz9HBzDEZfiayq8hAPHuLTtmJE1admuIAqnGy/rq1ky6CrSCoUU
IgfAgfs/fyd6TvdBuTO0TnABC1aqZfqE0Lxh2P1Mvliq9Z9pKM23OUw74Fog6j0a
xSD22xI+pyJnP/uzd9y/sAGbkbIqE/JvGMNBXEu41lK8deDF1lxXeDu0l0prcs8Y
AyLD62m+pqGL9PtUGJmhCXTAENWTFTIN5q5YgFjFfdVnDbtyxO4rY2bFoM2Z4eiP
rGZal/z+lOeV1j7XeSGta06KAT22JkhkdFFhxE0AbPY2nAHNFZNNea4zmuJwkZRv
HPT31n679zBzKP2Eon/VNQ==
//pragma protect end_data_block
//pragma protect digest_block
69Q0eKVkkJpmOGQkKXfAP4iMnp4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hZlhjGTMNtOOnB0gY3hG6zK8Tdq1ZgR4pT5Z1n+ecPw6AJRNMnKJslpLM3GjGXy1
bYcSZGFdAaOW7obVvgp8Ngji9dcsmzGL/slh2hyCZUr/2ylwXGlCnBRvBoO/26zQ
f/VKit3TGPWs3Y6baeRGl/OOHkMRjyPAAN6paUFZn7oKtJh4UgYbMg==
//pragma protect end_key_block
//pragma protect digest_block
ATdbM2tfLF8f2Eh2cf3IoV0QMCw=
//pragma protect end_digest_block
//pragma protect data_block
25DwFO7TKUDWG8Hc5Rw7wntYBuW+5IXOYCsDE8G4FBJCRVpVepfrkZ6Rghh3FISP
NzBl7RtyUe0x0YhUjRMnzotsqGtHqpTVxPA3CCAZ3YI4cBvTuWEt451ZNvGe7LD+
BqeWhjQXP0lwQmZjT0rExAiMUF57ZN7O5BFBgwOhmatwdjQlZFhfgNcnRa6FMnzi
xIaSPmxiBEEiah4JEN2p92JD1MynM/81lvhWhDEh8GJiQLYGkCEWglYSL4ZqWe4b
G7dRnfQChd+kqGURrZy/vHS3FEw7pJj9V/ri2TmqLOLtdTv1ZcG89tKc8VMdJ38Z
59Wq/eJCnsPxXvONGGejs8LHWbqbEXjuX6mn6ZZq5ta3MuZS6hxG/1oQRDz5915g
XWIyudL3Fm6Q9NuhSDSz5Nutx1UU9qZPk8vSMkpgvqUyDUJmNpuZTMkEQ0f8hzRE
uAs5bTrDjozewpQso29oIObMUZ99zeEu3i5OCYBwJg3RbH0uagmwkXqaBNTtSTnG
TMNqV++UMuIgI03GRSgg8zHbXj5ojDTB0+os35pHiMiLyjksVdJjp1gKQ1XUS5ZQ
EmVgMiUk21apsuwG6iCZShFwHqpQQfgeXuDa4Q8ZDyqEaZEAlcGF+imFoxNvmoS7
m2l64FtSgPz+r3WLU+4atKC6+W5ATBEF281BywAZAdIGa3YUJBlFcAPa5gUZUq8f
yLF4sRaKpZBbJD3wNnJK9xZ5pvVlfpaTV/l3550ggfz5NpKWnNPyrbM8g2vXibmz
+xt7pNKCWGHgJPtWS5QFtDzchiNuV7OFCTCoOJJSelTJcU2YNY7yUc9Pz0hM6rzs
GJ0JWv/hjQKoI08xjDRKEiWq4nzvMIl641DJgAAFKef3Z8WMLSk2wmh+yoOc36Yw
D+hw3Qpr+WTwhi9fcsbu/TcMwvuCd4JV4VqDMStEffJFXU07E+Ka4WdSNzrB8Zb3
wi3tb8RTK0bzOAoNccE5dgxU/bRrnJdCKEPFGFiq7OZFJ2VhuVrVVc8BJZSjR448
XDGML361eCZhkQHNXMRTLcAZtIgdgS6KKK9NsPgg3ye4FPWLDJ2iOYmui4/wkB9J
iYpDvNQl0WcXgShI2aEmabDxfyQ9XVJcWq/7BkkdsjEQg7aiCITa8h1oKEO33Rzq
UbX4kG0Apj9h4BNpsjLBhlQoBGWivsRH8VVG9t2FE1Awx2loMckscQsoo+rEmKyt
Erz+wMCvEeXXnaawO7nMlRni1VijDMNgtca6RCk0vHDJFsNPzm/xvI0ChUFAaOwn
GTfshQ+CqJEeMrNoNFyPUzmY8iO+BIwSkh+U9x2Qnm1BHrvzUHzpRGtL7Kv3yEA1
G32n3tZk03F4/PlKlNID3IKu/83j8ZY3pjoUSfiDwo6tiEQVYGGl4nLBb/RbOqP4
USH+uqYlCFFZUCBIEaMYX0KYI+Kx0I4BHofOElvmAM/xXpgXxzc7buK/OZ1kOHUc
Z/WZrtU+3F0MICekcrqJAafISTM5nfT3E248zH7pyMocQMEc/oIZQiwMDuwYBR6s
OxPpAmUxUzYLxQ/36HAT+MF9A6nBWAHcVF9FCQzPTT3NB8VxIPeHNllQGd49mH/v
40jS0fRtzoXHZlFn4z0WY6W44JZVNdFLlCRuIlTjMYnW0GgTkerd/mO4fAKArpeX
Y6VCRrOaRxy4JZdMWPThwY7NcxmXZiIKN6Eekc/MeqyfumChU91ANoyf9a2LtsX0
Xrp5CzoP+BlqjqVeOd+JyC/44GZ2rGy5YS7w0Pt4fR9nGKzgc4NAAAYWMV/8pQkB
cO1mYQH8wNrtMY7xIwFT2PtDu8Yu+yeLm17IwoJfjf1B917nzaO5ir5kn0NBl5Fu
lcvIRrOwGgUb4zfboPNLzi5L0x0S3GKR3JnfPCVaor4=
//pragma protect end_data_block
//pragma protect digest_block
OHwgNRo9Rrgv/YnX+3lRswLkqb8=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tU3hagKEQK97NVxj7QTY+tnl10UX6+x0GfxGHkzhBKKSvLrfg4e7bQmYZqDcy9m0
/vmJu0RBGPwT0RKuPjJ10IRPO3pK+EO0Yg+BCiGQsoHB+2Icrpu4mdSLVAg2pkrK
fcU27WVTUxwq/5Q/h5bCU0TENIl/henUcWi7S1ZxwiVyiUzQf/WCyQ==
//pragma protect end_key_block
//pragma protect digest_block
oEPEVkF9qrVGf1T2s92vsRBlrAA=
//pragma protect end_digest_block
//pragma protect data_block
G8nFVT/o2M4QXrVYW3RG9OTfMaOQmJu9zyl9mCXYLvYmWdyU54poz89WpRxHvoMR
ILuC32G6cBNg0yDG/uOaVeUBz/uUJN5CpPkOR7oOisaDV4Qmn/CPuWlu3dpjKONv
+gursSD3vdw7Il9+nFT8cbYjNLFKE1oAcaPZVk6OGbdxW1YCTsbFkjO56W7qc2YM
czDYkoX2ZKuS08eLGMr5Al1pZs4y8b5Uzfz8NA1IC6Yw86iBT/DG1uiVr47rD0ZD
+CDfSgKXfUHMDJ+IV5zPRvBW531F52dic2yT4amXSMfUGFvWphAOsDkYqdaYAnc8
yJUS0Sq8HbENsjkuhLQ/GEYuDgYg8eiIXZ8C1oBcCYNemtRnBu0+mYIAxczan8uU
R8/6gMYbRVSXYShnbNUjv1A8gMDyDBmEGm+lkn9qAyauvfHOqhoNu9gq+VoATit8
wDSWoqnICe+VGZnVuFrKB82CY8BJo/6iG2ZGtM5x2uE=
//pragma protect end_data_block
//pragma protect digest_block
MSZXIagwgavbCDklULZAfYbH4pY=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nYtvjGeqJXk4E3DkfOmLZf3NBqDmPcMOsNnMewoZt3vMD0+TPg4h0h+LllVgDIuX
2lFtu2HnGXHFEU9VET2BzaJspiF4Nm4lkZoRwsGrMLBbnw7/kYiQMgoI1QYwGEAn
6UUukUDNKI7NC3x70WF92F/6WBKut7K6OTQAA7+BR6yi4o7E8sYnfg==
//pragma protect end_key_block
//pragma protect digest_block
wAO3S9bHBLD73eDsQeoKNmABO4Y=
//pragma protect end_digest_block
//pragma protect data_block
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
r/AeM6GKumOOPy+3te3PNSb9wm6UjNI50dWtWqf8SzmykZabpWWCizuNmR446g2h
3LFLRudbTNDHPg6S0KpKYAM1dRBETZ3EaQUw3mZRVqR/SqmNwEEWc/fz7mi0PVkL
ySFrmxfmKWNVjqqUYWvnQkKHeS/2rCezPg0nYR9GO+u4WKVSHb/k+Z/YN/L70qkS
M00jzBS2HObLODJFvIbZtJ5mgrecBckRsr1sdTT5yjHqVOVo8zwJ4Ob5kpTxVIRq
R+CUyQrUxfLDfuYgS6G1fWDwyxU4JMaJWw2Au9msU5/3TXR1DSar7AinZxpv/g6A
r9mI6X3aOGPfY6QLOtIMLmWoVeNmJ8I6efmjzhlqOkT79/22XNqlvG3tnL2tfFZw
5kQHAbU/J08vaaIY90qlBYFBbXnP9hKSxTY+t7xlJ7nXzcIJykgsgjqkEkk0Bb8u
I4K9902rTz3MjTiRXYSQl7qdPSgvlQfc3S+iDQ5ZKT+gQQnHaGCNMgmKK1d6qciu
vrszDFZ1dQBawWD7Pz7jAE6mCUfI9VEKePt77ityVBTmXqf7yXBxAHY0CNOZMYvI
sLDzNqDuILK17sy2boSzv9hcWVzotv0ln0SgEpwkxsBF2tYRbAkj7xm+pwOw5ex0
5ozzVB1r2TwAkioDJkylIiGejCoGRfq/rwXMXDJPOTkkPkjQnIkYmkFuYGPoa4cs
QnqaiNpRQ01XJxGRlS36uGCANxWPz1GvwPDubRLDedTOg4vMWeHT2WfufS+6cI13
kfoarso5cJTpFXKUPhEGrqe6HZwWFGjbvnQCu3an+2MLp3FnagNUGMaGvRqDetkL
A7FNI8NNr41vAkZqNn4aYcqY0/vJxBNLBhT3aDW6Vl0KHVVtMDR31dRX36oRHla4
3gf5x7JzVAcvMSMozCYaPIdJahSU6WeIwmYO0x7/DHOh+Fl3e7wfMlvF9Qv9m7Q/
C9LTe/2+CR5gnTxf6gkukCFWwjd+hB5yujeFydIpVB1XqjKeLUIU9v0uDoJfBEhH
L8CTTTgVZR5WWKVAl73Lju4VPZVJgy1ybhCnNEMotPoJTezz67jt9I/u1qLomUmt
eqq8VVW7NidwtJj3v0Y8D6XRR2lYuzBsU+CF/EnJ+eaHy559AzE8AwI7p0IT2uzO
O37wS6UIqf4YfjpgjoPSHZ+CSG9u7GtWeZ0tEk2Z0QnDN9gAPoHdhj1N6VIIWlQ1
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
r5lbUHc3l7K9SqLZcpeCuQ==
//pragma protect end_data_block
//pragma protect digest_block
V8Cc5duRtQssl1WHRoeJTTs1T+4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

