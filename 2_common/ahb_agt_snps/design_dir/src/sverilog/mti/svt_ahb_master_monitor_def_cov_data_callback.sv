
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_ahb_defines.svi"

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_master_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_master_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_ahb_master_monitor_def_cov_data_callback extends svt_ahb_master_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_ahb_master_configuration cfg;

  /** Virtual interface to use */
  typedef virtual svt_ahb_master_if.svt_ahb_monitor_modport AHB_MASTER_IF_MP;
  protected AHB_MASTER_IF_MP ahb_monitor_mp;

  /** Event used to trigger the covergroups for sampling. */
  event cov_sample_event;

  /** Event used to trigger trans_cross_ahb_hburst_hresp covergroup. */
  event cov_sample_response_event;

  /** Event used to trigger trans_ahb_idle_to_nseq_hready_low covergroup. */
  event cov_htrans_idle_to_nseq_hready_low;
  
  /** Event used to trigger trans_cross_ahb_num_busy_cycles covergroup. */
  event cov_num_busy_cycles_sample_event;
  
  /** Event used to trigger trans_cross_ahb_num_wait_cycles covergroup. */
  event cov_num_wait_cycles_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact covergroup. */
  event cov_htrans_transition_write_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact_hready covergroup. */
  event cov_htrans_transition_write_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact covergroup. */
  event cov_htrans_transition_read_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact_hready covergroup. */
  event cov_htrans_transition_read_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_hburst_transition covergroup. */
  event cov_hburst_transition_sample_event;

  /** Event used to trigger trans_cross_ahb_htrans_xact covergroup. */
  event cov_cross_htrans_xact_sample_event;
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through observed_port_cov callback method. */
  protected svt_ahb_master_transaction cov_xact;

  /** Coverpoint variable used to hold response per beat of a transaction. */
  protected svt_ahb_transaction::response_type_enum cov_response_type;

  /** Coverpoint variable used to hold number of busy cycles per beat of
   * a transaction. */
  protected int cov_num_busy_cycles_per_beat;
  
  /** Coverpoint variable used to hold number of wait cycles per beat of
   * a transaction. */
  protected int cov_num_wait_cycles_per_beat;

  /** Temporary variable used to hold address pertaining to last beat of a transaction */
  protected bit[1023:0]  addr_last;

  /** Coverpoint variable used to hold htrans type of a write transaction.  */
  protected logic [2:0] cov_htrans_transition_write_xact = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a write transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_write_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a read transaction.  */
  protected logic [2:0] cov_htrans_transition_read_xact = 3'bxxx;
  
  /** Coverpoint variable used to hold htrans type of a read transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_read_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold burst type of a transaction.  */
  protected logic [3:0] cov_hburst_transition_type = 4'bxxxx;

  /** Coverpoint variable used to hold trans_type per beat of a transaction. */
  protected svt_ahb_transaction::trans_type_enum cov_htrans_type;
  
  /** Coverpoint variable used to hold trans_type. */ 
  protected svt_ahb_transaction::trans_type_enum cov_htrans_transistion;

`ifdef SVT_VMM_TECHNOLOGY
  /** vmm_log instance */
  vmm_log log;
`endif
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Master Configuration instance.
   * @param log A referece to vmm_log.
   */
  extern function new(svt_ahb_master_configuration cfg, vmm_log log = null);
`else
  /**
   * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Master Configuration instance.
   */
  extern function new(svt_ahb_master_configuration cfg = null, string name = "svt_ahb_master_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------
  /**
   * Callback issued when a Port Activity Transaction is ready at the monitor.
   * The coverage needs to extend this method as we want to get the details of
   * the transaction, at the end of the transaction.
   *
   * @param monitor A reference to the AHB Monitor instance that
   * issued this callback.
   *
   * @param xact A reference to the svt_ahb_master_transaction.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void observed_port_cov(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void beat_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void htrans_changed_with_hready_low(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);


  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is sent by the master.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void beat_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction is ended.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ByUXwtM3HWYRYArnNyZ6f5pakEOWWijX89771fkKSS6JG5+81tXIH4oigGhahvDZ
4EJvgDrgeS1swh1dpSJD+bTvqsY9gMISqSNbbmzKkDj4Q+9OOjmA49oKYzhstPR/
5eAz51od+97JPLGbPrRfYqtiqPvNu6rKjsjPGrqomVE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15450     )
gO3vydC8lKgKtXPMf9H+SG8n1LFpHMOSKr9mY4+6rVpYgQNCbG8NSgldmAIsVtmT
zCtU3JpmihD4F2i2t43Kzttk852CwHEYgVd6KciG/nVbg3Xjd8hXtmUxFOv4I9ep
/UQXmCQ5FDQpgAFg7R28yp4FWokBuBlEPy/fvrk37tEBmTacZf0PLCCOH0AhBCpD
dJurbXAdjOzlfCh9Oa0z7jcQV+kPKJqCNCF3J2S8TUWPdluIrxImj5GbqIcE+YPh
h0lJnXIO3E9ZIt+2hvWaG53xlM+j6K0BDY1Id0OEp877b6zZdraFiHoQFIu+b2kY
aIGu0n3a9mOkuA8RMBUwoXIDCMXvRmW9v1ofHApaUQEU7HakCTVcomHJRqRoYppZ
Ia3IOZLUpOLLd0exxaetIr4ZmBkUXA4+A0EWI+nmwm9CfjidbMb39Jyr2JFjXZZz
DwZSPojFvIAqchGk3QsUhl6177lGNRcfCT2guu2syd68fZoNt6rrqgQCG47qrw96
m6p9Q8w39MWPz4h0kqx01SQ5J7Wdwvvp+erNU5bBXa6DestwG/SQ8v+femIXYrhB
zIvsamzcq+0ZjAENlbrFfh7AYiL0ZEfMzhggiiOgUgL1FeA2S78A9Cgfonjikly7
EGUv7K/DzdBzaSEIvi0SnGmlOOhyCemYHlVKawPG+qx8N7GHDG1LsuglPCGgbEm5
Ohm4yn7fFAey7DU8v5q5tv685P/PeT7NpLkVPfqWDR6VC9WCSDHFIC6RsdhU2C/y
z0v4CpdbAMvoMnE5d5YdyqDppHbdy03ZUkCLd467rfGXw2K3UdqK3wuTdHUcuUvL
iACJwqfxkObrMPXAoUVV3VymEJSvph3PYFbocAYRbsl65+aqyLwzbRkc+J/MhCl5
CJrUXSTQiCnFF0gfTOjSTTnC9vMWSwA/3CywnzE3r3AnL5WtMQXkrBagSMv+ZUHZ
DA7IWMW1IO3kWITH91cFvjXPGNPBm3QTcSioTXq5+rzMJPV483ooGhKAL/ilXikM
cAAwJhQMgYKeAd/H6eZ/3wVAD5xp6f9riaF9Ns3vHjUYLANqPSnvIOKQKoNndAgo
oK/hKy7rcGySzy2U76LTfe7i5qL8RYSu85bVdQluCl9L2SEdEtAPoGw2PptTXZsj
ZC/K9v8GRWxByaFPrU+yOy+D8miMKdlWZQFnR09kbJORKWN5fw4Q2FKDtj9t+NYE
SvulIvr39pAfN+C9AtUQ3cWJXhES+tjqBIoSTrlFTNxp/KsGKBJYsN5UqxMzp+eY
o+WWIYmGJXTVJ7TsXC5oQkie+J02tI6MGGRP4mc76Xj/8Sbh0FJLJlzx576mCxe3
pd1wPmi4+5O/9JWTqpwmh8XRZdAOe5V1Jg9dHkKGNhS6XBqm4tDtFd9iEpzmTQdM
Q+MC925UBuYDu2K5I18oxi4nA4pY8o3CAinWpZDIhUnpElbWVnudS1WQ7QOiGqyr
jWjn8JiMr3JjA7UOXPuaEZZZamlaESW+GsXlcPkCfQrVEjmN8PxvPKhlgkIeLkXT
qIb0O0ke27uw62kXRp4jXv/exrrr5m14hfdDK+pXhhk2HCwoLrXqErCTnJQEIOpH
Msj2jel1yDbKlXnSQpRXo4uoGkUweqNf6s+auKnIAiKgyhOWjqo9I/jg4UXiqqNy
Yuj1uhpMZjc11kwDiuLjQCT6EpI0J/I+ci+mY+ZFAAwHVDfBBketaGHGwWUda7//
rfJygrPOQYKfOmtriOPFxqsa2+plsWPtsMBcrZt9Un+WpOY0Cv4ZviSwcy6AQ2AM
8NXKA4xib4fTNAwtbjEd/HP+RAxbG7wgGCBJhiLoeaQgcRTF4RJgpq5AmdqCx59l
h7risFN5RIiDgiEbsEfTCj84I7bdaXOYtADysp0Y6Bk8jtwwnNzcvXsJoxVoBhSp
oVVn7DSu+RGdo5jXmYvAKOsa1MMO4oaa93Hqzl95FR7V+xsqOVEU/dbLswbUMU+Y
yWUIc63IuDwuRq+a8jnFlQvw1T/QGrm/rbyDIUhKRinoF1dD4mjsAozDdgjQiEPB
QNnydI1TcoEz3j3Kyp+uAxJydNuckHEFuBRGlaPC8fV8ctuOASqG7FuDBbVYkefL
MygQzJnYrWWQRtnugdMOVa/33Xdrv+3LldgkPU3W/sjk2sHzrQlB/2Bi9jIcHKkH
+cWYRknMYd7ppQzT3ZbxKtf1iYvIc01DSsUS0Is561NMdbaY7Ru0VacyfEnRxs2G
Djd7xGR9lWB2ArEl9tXR+LZyIRQ7YcFLvenb6gWge4uhV6jklYTSWKUABq9HG9eL
Nw4GQOTDf7BmPboNKzuYT6CX0s+Yd1liv5dVl5DGTXms7Gc0MdK0s52ViEHLun9q
X8XutR4QMQUguZkcALjg78r8EyIodgN4K1Ml/yWwwq4s/8wRBesroIpxn4bgS4gM
vi4shpCwwFkOqbE9KV9VXQ+Q+ugnKH1IvLsIWKXQu1+ptvHz5TMRHv0IqMQxzJna
sfjJ+cO/aY/ph9qDteQMfeUKsrQkdwxgKcr9LokLswxs3I8r/7KSXqxRZ55v6WxD
dw7kQC6dDgpQ+ORDzNgxJs6SxlFCuXlut7OkWcj9U2bAbpRQVNAJqBGykLBPw7z2
quVE4dBeKRQAHFfYftn95a6FnavW31h3stZDo8Hx+I+r1AxA7EkYDC9T3A3PuhP3
Qfd78RliUqVlq0R9OQT7Du7BBRe2HgDbqNp4lVZke8sAHBI0FzlIK/lx0wY5/NYq
yXn5sfSCDo1b02lM02VJvDGd/y/EG6weA81h5m68opO8g3XG0diozAVGajGz9cc/
gQMfwfSJR2HlUwtkD7e6jo+6C16jAr6LgukI1k3co/8m68wjfPjg6N+Fdbwcw2tB
KjSBrDdWvlZLanuXrfvo4ZNV5Ek4Nyt2q7jFXAP/o2JxwhUS/D1RcwlZvhyZiYBB
cznYzkKNOWdJMTDvUaiQtMSaJG1yxT9G89nxMwUSXwC0S1y7kqtWQVQNdliP0ikA
KRRcFVJnuveHVRGVJWel2QJi+SUYOZF2+9nr2TwbkHNJjFEbaXLyVWXqytf+r3gL
iQtRXZFz52r76WV462pCJkEQq5V5LgNExt3wvV8509AzN4EUnX4gL9hap1RYblSU
49hovnaZTWagqDA0ldU1Klfj+FA4ubaUZOzKGQywZyUDc0v9hvBsV1tb2xXi8+P/
o2SP/Q1fRQzwSYbw/lGwd372FzhN7nwIqh+qIzNRf3wXQ08YJGrCiE2uY8F2ZnsR
HpYZGiDw4V2VUD1UvKut2SnsoulsWIK89+og/eYhc8Ur4Cq5u6R7FpuAeA5z8AjJ
QMHZ8bJKkKyorEGe1kCeNJXMECE+ZJdRQjGRhqyzqLCSjVstQkEvUBTJlFVZGWwa
sFNUERXD21pwJtZBDTE5tleHz6MixdazzYF9nrsbgzpFyzZsHtFTc4fXh5EWUZYk
tJDz7Bq20fWNuVqNQjewi8h7hp5kR4iNRQv1Rown3Sv91TS3LLiBo97v+eGmB+77
dKxLPMziYxyBZakiCXWWFuvWwcolZ7h8sqD4NnAq1pjIv2kjUnOYFdxeT7bAypjf
r10b2sh+qC6iQNKu4RGY//HegplCtajHJqQ01lxP+3SHHk+cQfzSNCMoKWaMG9DE
27Cy7xR1LmG3PfC+WPU5BZw2aILscwnd9l2lh9NQrXNEyuBk26rD3lj+NHS2P2Rw
mbv7HSbm6wey6JjSBNcj3+lA8H1491IUPZ7PinnVrG256IK4d154/YFkykxA1PZA
fDVxsXhTFuny8T8idt5dscfmsiqY1YMzWqeKfboL68JxrEVjqQEhEvTx4LnCkkrF
6goIW5zSChC9Qv7Fr3O+KABSczs0uw1snfQHqoN0UO6Ej03yWcw5cUQcATFxWKlx
A8iUjhjk4d9G58HHygYTS6vpEEwPw8bat9KTxPVgJx8VOTRHUDRn5m4O+VUFIQyv
tSrCtLrGdDGTlEPN6ug1aOBTLerHzAVm1P2aJarKgQT+QcgFXrwbrJDucKGJrnjd
cAU5wAbD0hIoaBK/tDQs94+ODsl9VQzd/fW3pPx1vGrLhk+veOQV7rpRwr0gNRBj
wTrgOzN1llPxJKrYFpTStwXY6zvm+bj9pdonXFVP8xLePGVh+4Ff+ZI/ZVF6oMw1
CEJxz0Ya5uylEVg+yk+PVwtlWzGbRkLkGw+V2hBRKQyLyoa11ADePYWKgINhHCe1
/rgmiXNlA9hysCdBInAmKqrzJ+hTKKAmYr4cOGhE+9UBnF4iYu73a62UUMm0LpJi
GTnf0tK0nqs2LOgxTONLPdAAdz+QuviBcz7Yl2lICUVnS+EZoLSyebWwvGL6W3ea
V8kPvPYUWJHI0vL4Pjdly3bAsJ8P19l8QAPv7paoE+0sl+x6hS4fEx6oT+CQBGZ1
ZZRiHAYHxedjrzCWI+xZh45Es45NgKkQZRe3UXoNSI0an3kVK7T1k2Qsnj58w2Qw
uFfXBbVwYvzsBREDb3Wto0/1t0AgY9c1TkYLqW1Jdy7hSmfJ85axCB+iBPFzDol/
X8HWpZBCqtcRaGu3XMZg22/jbUUSbKSflSqVZl0roCV7wAaUUk2/G01Ia9VpQLmL
ro9UZze7TtiifOd2sXcwbYWqZXje9NHYDAFjw9rl0ulzYXPqiR4YWCUF5egoXiHW
ISoCqyzK5PEFahRq3Aw9VR0wCpO8XHJ3EpyFOgrQRQoMy/hgTQvdalEryHmdouue
uBvcTCpX7YumoTRHbsafIZpHar5r5tZrYHqoR1LEgnIAnUf7wN89j1w1+shrnqHi
WS4n/KEbluAQVNkrxqnwActB/jcW365Z8I/xH3SM+vfw9reqNkH+rLAjFd9sYwS/
FoBwKoLpwEvbA5pGkZf5+l7PjLCYPuoUPsiG/ZBtohxrrHYqBMatWtmjlwefrHyJ
jmb3bbmebrEGdAAqak03wnj1pWSlbt1zxb5NcwWHrMHHX4wRQjRqldLsoURDfyyP
rcwOtXo7xJmp2Z1jhuGbezY+q7vfAIBY11kJcFn2x7zzu4uGOmjJNCaL466GFPZo
rehv3hfhwAtM2lM6s64kSykBIMNJjMRBqY+8sWmPmDUlMT37x5JtpMQNtUWlz1fc
X1YZAquE2seaAZv5yLV6tCK8D4Ezo9IMu7lcdJVz8QVXWSZxRAuL+VfxwJZV8KGt
JCE8Y7aWRvFxyAsPoJbc4s6ytMitkFLMNK4L3Fe3GCsZM4A7CX2m8NjuhlZBLKy1
Ugjjnutl5rXwYjbaNgj70v6vHOJAYt636OZD1vautYrps4Y3rTWLFz8X7P/jgK7u
n8STW8IVWEZ2aI7gcqmok0908VzD5A8Bv43GQpzY+q/PA4N6CaLmgcddiP9W445P
vQqYGuIFclZlB7YEhGpfSSl6bRcof6PHM037DwERBx/YHnqfk+C8ROd14TihIsRh
D8v6B99NIb7gpiZqzAxtPNyW2/z7M9MUsGvG3ulgvic5/EoBDtFeMlMMpr7/nfUh
C86ZvnhHuqzJSclwcdnl1r10hQ9/yvHr+i93zur3fP5MSNqHwSrhYX6b5vxWk/um
h352/vW9jwrN/A2M9h/erNO3sFcxN8tjS0H4lV77dZ4+zbJiOs0JMKufL0pyLw/L
mcktx3jT4XRxOFKgdSQKvM4Bj6o4ALIFFJIKNCyV2HftcICYa01kvlGU3ETN9EDo
4iPSEnQpZWibLPcckc/IWiant8Guf5on0AnzaTWf7Pv8ddeQ2J4hDqGxyrQnfTR3
Qo4ZKqd9ewPz7Ymc+vvrG/5dISx5rKcd1LaCfXpu9HLO/p0g9/HaXYjDAj1l0QSp
uCRvjkKCVZ+gPsSvoljB4+YYXMRzeoQfqePQsuu+WfkYAFNyKyryolDyVsWw4T27
TBrFMVku20H0mOiiqjqS4Ee3u5IaeZ7A3Jy42S6mTwm3XzQ+UwamRS/bgm1CmR2r
TU0WEOa4MiHEf8g9Buk081J7UN9lyB/lQfz7PiHg13XsHGHbrImafzmdzbCjET54
0YkRiXsBo9LrpH5+InAtFaTVlPCMcfofZ7wxaOWkAN7boF1Zyhsn0VSbhulockfs
P9GfzZSzc5l+D4/7/3bZmZVQ6D9IxPeFTVXCUV8EwoqRhJap/ovJBDCVKlDU58In
2WdtEy0sPfp/Lxx86lyGzM9bhP1MXwOr4JdPASVLjzJoslMGafyJcnxXZpsdHhkO
FDOxB+cPts7bR9oRcIxQiEAtNRFIFjrdM7LSOhJeaqpjSVzKrLghjQTww9/UmKg/
0TJKxd2x1w6YIRK7yLr8vgzTQMuuVMBY1Sgx0SOflw6qQLgwLdAsQryiA0mFB410
BKc2Dbf/YeOlP+C9d5/R10pXSWyp5TshZb03WntZpq7ksZmEmfbReNskKUwPkaGW
2By2vxkDVUI1L3urSxrxZYwlPyVdBQc06MVKR0lbv1H+saz9FFLZ7s1KSjtgyFd1
RkE3GuqPUkg3ll0NewZdgoGCuCHYvoDNW+d4WmsaxBP9D1KyCCnyh0IkL1kv6O1g
kXqOapo2Jg+8gs7ia3PmE/XlJTfdCcVOCfPgeXL+TlBZILfYTZJUaVIEeGRa/Iui
lujn/R9o4dZNyk4lkdjERZW6Kz2lJBXoHgHKWDe15WYmhAcUdK7YuzNdhLmduA1q
rl4jhcqDa87kXEbxfQwDH6DU4LaqEPKj2N02Oeqwp0EsMczBUrpxVdhO87dcrCoG
/UlbuFw0UYY3QBxxH+b4SHmr6d0RQJgsxZy5uZfxS3xFdzCH/IQel0/lzifNELms
TB1tGIF57GT5xSlip3iVRr/HVyAeIVR8lm+wqY6QhS/FfuzMfNqOvpSN8jEFPgoT
wxhlhck2TWXdFvWnmFSZL4dGWw/CYEVgWfNVysj5QD+h7AtARM5ovNIRkXtYatBz
WHbWlLDtEWdxnyBzaslMq3TSJY5M0ZgDx1CXzytAX8KbYM2sE1CFeDL679qJ23gJ
nWjYhg0ibKuNbL+arLU819uDrAAN7vkTWoMsbFhzGQZmzZJWCnK3lFKUsoTA6O2H
++ll8U1dEhVwAwLXFMnJaPL77P6v4rzTf/ZgjE4GJv2wxlmXd1M1N/T3NecUvXQe
zwHBIEJJx8zmxvRveN5pcBNtcuDLcYQhgt8Nzh3BtLkKf/LObFuJvD2e/d+Bm8ST
YzBxFre6hVHryB2+cN84+0qBXqtqXkfkSXpyW1z2sotET3GjJWM8wcGgA/pG0D+O
4szJFln8prP6Fw/gzaKJQ6QjX9lKesSlmWPl58gJuHFUExEPkC3irOsvo33uymPk
t35PUySC1Vpj+sl6JbA62qZ2L85frAVS0IanEFqy85f0ODnGHNRsUZzxqnEGG0Tu
dfd5xRZ6OMp8l/+5p7AfmB+JpmYJt0Ot+Ox1tirVRuVkirV/SU5poSzj5Krm801f
6UCRQ+a3Rw7jNyntzxeyqiwpeiqd6vZelMr4V8xn/924e/ZZ5MOSlBlTRH854Okz
k+YLNJmhnM4Z3Ohl/4RSbxjeV/3yTRdClMxYsVKBYMGtRvEEgS5j1dmyYHpH5mhc
8NzhzYk/TAdoIvSeD/hgnCfMLkfTI3YhVeZRmK/ZRqaXJ3ZkfseM0OekgUfYPhDj
/zHqaNBArSysOY6M0+LpQ3lXWQpN6BF02/ugN90nf6pxZTZD4qBmgQw0b7ZHXPux
YJMUpJkuAMUcf+/q+pJ+jLqn4BSzHDprp1+WIy7jQZB0uXxIUJlQEJsczk5gMpQQ
WEpYMsok7KMUdXRbspuRHU0MYV50siGw0le+wTNjZHqixN28FRbY86NRpwvWOsMO
67GrrsEvi4JgbulW9teUj9xoq31tpv1lNOh0ArHWlFmeuwVbjTcXtimU/CRw3csm
Joz55oNPOaa3Iw3AdJRoxbJHHPlv/FfQ/jbADqGeq9dhu5Y0lFugZRw4NYDC81P9
sZsBj5UqtesoMep44jZTxFWVAfL5cYXfzFOJfaCyydDhcD++CQvefX1rzWTR8hge
+0R77iILuPYbZ77PRCPJyIns8Lgxw0BN2Lhf6wZO3oiq+Vwjut7uG4z9AbJwThyP
7sClpCF+DVtyQdpp7f15XIGDCN7wdgEHaKZH8ybQ7i6dGSwKnrnXZubRn3AKqOBX
IhBvl1xTWuOHX74JyhfJJ6x42OBDTBlDlaWlVpyBvKD2NkO9vr5fj9IrSGzmZAyD
r+zLHKRnbdSyovFldzxuBwWl3Jjz7BaNnC7Jz6SWSb9yD1RIKRMF4zsaW8nrqcMP
6GV2zNU92uPOTZhaKatCXjLw1OIK2nm2vplrCwk6aNfFt4uW+RNDUiweiM0yyr3V
+7E/hUZpojFnWcgs8BRGLm0gpOAN/jtM2xxgOrumbuwi8DY5yqgk4dXn5APoDoNq
Ut24HTnago89/qt7pBKiVeUihDj1Pfl5dAmrpu6QrcfnBdtqBtOkl7utAMTP0rT0
JwK0fBgxa6rJxHrn/j6n0blsMaRPaXl+67b0kb20Lm5shZnfbmHu4MQnYv86EgqQ
NjpFNecKPSMOCVBJAcPZ8riu5BKN127VmrEplDMlquHVc/2GXosB9Dm3KDep+qWI
t6Nt7T9KQsLZuEFsxGGV9hUS14znHEHGjI/sYm5La74JsxVy1l4iuWrGYK3yby22
VcsAdLIN+PVIWYXfOPCqYFpUE9qnTkQKNUmdfm9qqdswKbFf2nsy/89vGMKlTG+o
iQ/99hnPT3KDQ2JMbb2YLCKyNYxzFXF17UitN3JLJtitj/oDoo008lDz2DkwsXic
otgk4Hi0LnW4tc9cq7vsRNIefZUnktciNKsJeqqR+7aaoHRuWsb/FeG3D6QEr69A
WIjeUoARCjDtAUp4qVDHg9nElkFArm4rm2zeyNLYK6XtA4ejPgtFaFyCP2rJjBDN
Iahuliw6JFFDTmDkBo0xiLp+vhpZn+l8ag48iSmK/YN49CW4S9UL4HpqEsl8F5gZ
fd3OV8TGYMbqWYx60kbwaVngNH9Ra+q0Fm33Oe4ryPQxNqPmgRnABbo0LVbqKFZ4
uxVblGPyBR+AwD7dzrjYDm9Vkjju3ANtLNFnfe0CHhtaErZusHDvD2nAx6W+GQi/
E0fBvDPgnYbwnlZs8N7VK8IsPffsJEIaIc2YPMS6URhB1SokRP2/QGebX2wb+m5R
7mjjG4hr5Lm0o7S0YwAmzrQLFwxC4VXN1sEP845Id1jfBHyA8OVNJIqFdZAocpGJ
uEEFrK+ERiPsYaZgLwzEar/yed/0qoXzv7mwZYKvHiYqV5La9qf/51y5LbqbBIWA
u66cfyevbcRO+0x9MDslf7nk9bbrMW4T0WfxtYtGMfR44tdA2EerUlETy5yUubmM
W9yILRucaw0VCDPbL5d6JSxONxDm1iUMs2sz4xzGQI2ao8LfxcAoQ8iknjyouRMj
ThahDwVRrpTQ80y+gOAgyliSITUiO2P+Kx5m/jDKIu3E48mhG/+Glw3iFP690m3z
j2bKlVav1IpuAZ/Z3uACRLempHSd/THoQfbxesLtHkDahW1hUTcXxBN3Uomnnnrs
IOkvOrKTJPwKU56Xm4oABt/mPwFiLztB2QXcBJZCZFb2G9tTbuwVFAB587bhCH2J
i/Es43iQoxg1NYWab5jxEJVsBDSaxX5YIAmExhtJ1n6SBV1uMs2XiFrUE8FurEm3
oNL/Wtsv+7f5aEbR8vxiHQteWQM8DIMJ7Kkcra/IUxq/qtyHgDa3evJxzBRwELJx
W8QsAehlMXGMhJta4YGzrubdbfETigdftgfuCni0/s0NsfooY5zvdOBzG6hyK9FC
zwm7/SAm7l32De3dcZ/0+1WuaMs/9s/zWu84KS1imz2L+IsdNVm7/73OnI9wEmpb
D5Cf+1J+yqlGipoLc+74TxSSXKrEbcvXQqS1FYOETG5H/wTc+4mVKN6DYWIrip6a
TuvlhoMH3hEafPqjDRkV2DPtB2AsAyZeUWdj1PeXzG4OFTHvsA4uRFLSYGlJfkum
TNUwd1+wB5HZpnaYdJ/KTKRPidi71dsOeNn5K+QSrhcYiElJJaup+7e+HJ01pRXu
f5KkXuUghHkj1KIcuHyglykgWyBkQXFy8lBbbOhk7pRyPdXS4BVWvBWqiTqI2gBS
ZqDR032xTyrl8iuZeZzuwsr346FgBA4v+TGmi766SjPLIyNAOJCMH1W4PaRwM8nc
GDGFnKneEH2lb2c+sMA8BFOz94mF1h1KxriHZMyMlNxCD79IThTo/0cznxI+spi4
y32zaTA2f/C+L2eSyjvNjzBXZEyiI2fODuyLDhzxYYgfCJV1z9rkystBY8GlA+I2
uA2i6hSqfRHvDCvJqdmYdDBZ9AEV+nvIIkzwDrvU0KEK0XRqNVH26Twv46pFcScP
gHHOjXkfwt4WQELQmkj7WnM6MEDEwc+PDfp14DgFrf89kgFv/g7yX3GvnnFU5RfV
NFcze3D9u3MrJYWYNVWOeBZ8bMnXoitsS5k0qoCIqFBcdrApxiWOx3/OTkCdfsMr
66Melgo5bo2PiGRIVk4ISC5vtyd6R5wMpQ9sDeckSKfA/3hLw8TsJkLu/KyCFATn
7FWFY9PPFKtTsjP+tEFN1M2zZqk0qF9g/RqECY2tIZmPcp3qZ0onz/UD5UsAVdx0
IstWy8BXfcux5UYY45BEJjfvSDG34rcFS4JVAYr0kfeU6wpNmfx9HmQEDooi+3AD
wlBFWpK6BBV+QpPIcNcP2psWYFhWugde61Xr07cPCu2DfOGUznbP0GifIq8SPIfK
KUaoFvRLfn3yqf35xZy3LgKpSQHteJgQB7uBla18anfoSxGlN/KZCOENnIQXg6v2
VeqFpy0dQVpbhZpT+86NAqxBJI1B0GVWFlB1gPdJfj1r2KPGmu+m7lv/DocnWWhB
Gh3vDTdXqOcFeRuLJAd6+v9GkwUpE/QdNrZ6SAKTx9A2iwoRofUZ+LuWEzBob/9T
lEfZqLQNlDbIsY7YEpCbmfOZes1PEd3wDqznS7NkJfZ2rvLL/vRwgkSWl+lv5cjD
hH4qJbzP0eJCX1HIkTvgYfkbU5hE8BhVKcCVoEZaHWl91ZuvAW68vEb6UlMdWVW4
nE3vN0xqMrHaeaSA0rm2Q68SKecvf8KZ+TC6Yytc6jF60c3sVQwHO5XGPD6iUbpk
JDITs1gEIdUQ9wdaBb9huOJkzlx8U4XdU7n+gB9c/Jyd98joHhrPN4R0uX+phrJL
fsJ1Rwl2DWlwQ82WrYtJYJ1pK/Dsb7fFcIip8a0cu0inOucwxbR5vCraCgnK+t+3
4ousaebxeEMVEIg9q+2qDiRJrfzEzihvUXp5hKrJ5BvPio/GtgQR2pUTuVO4rjKz
Pmqp6/yCcwDW/Zi6liNYABSZ9DJlUCJLowvgVAbwpDrL68NNiScHg5d4dBhjwUyZ
Hcw1VuMoHb12etJC/q11e/PH11MmOtdrKFTMmIkeMg1JLZslqr+mn+hGTXi8uVDP
xq3+DhGx5wYcahxhmeKigHGW3loYeOdht1UzdRrAGxwAD1NRrQ1oASTCIrjUrNgN
XVTMXr9w/1foktl3uDo1R+gokhw+Wq5YP3IBouXSrGYuAh+gyC0VGNXqV8Lk9LKN
KiDpB0Fl3iRETUUBfFldjIkKwEyUTx7eRAJvrdR+VAcLi++yz0YkLtGm0aG3tWsq
uuT9lY5Z8eXqMmFFYi7uqFmLJpaDh5Y9l9X+9G7H00ReR3OVma5o3CXpztbvYq3f
j6yX8Zdf79yya2iNKapPIgyqAYnoSEcmiSHYDKRJMwtCe84srrDwgUqCbVUxeO54
UWgiDDBW5JpkI6D1eDsWKQm8LQiGkdz7ZloUPQNG1W9ZiUPS6k0XT9OhSGQYtztR
lS1QcQ/AYdIZ266e4Hz+JnT3daFSLxur0RIY77+J5dYrLejebf1/9AB5TYd+vM+l
TR9q662EJ5Kdc8EzAMTZB4T75zvVhu2VWCGMZdO4X7CVyA5jUO7c3+bZMJV9nuLc
1QtxZNlfm31Pxz3JXcC51bEygAasuHPIOBMoLIy1SzuCAbGebVeaud8Sjgv/pkAR
HR2RwTjnJLsU1guzbnfmH+l8M8B3xeAdtrT/HGNh77zTV/ZOE3esJlIWdN4MM+dr
/VOU4eCtKi1UPs+xs+q7ISGizVBeM9TZhbgVrjKDTXoOKELKQiZiX+x/nICPsLeh
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WiCIjjGbxZZEnMVFJXrV0yLFw8IgUJRmdoAfih+CRHnq7B7a2YuSe8O2aCq4dNn8
CajOnfOYsKkyR4V9nuo6i3RSIrFuWyTKG/SwMHJgrWc64fMor44f8Qj8cbN2f+Ca
SlDw6u+Ctr+tz0ssqAYJQBi699lwzDlJS2h2HOSxCOE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15533     )
wnYn696VuKMTcNLVxYdcuZ30nG8OsqJqwboow5cYsvKu+5P9l224qJCtWlUx5nhM
kNaY2KZvJHc3K4h8NOLE5MmGTgo3mLE1Gkw1j/I2aQcNz7dIZGUe9f9c5DrIjwIJ
`pragma protect end_protected
