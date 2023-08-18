
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV

typedef class svt_ahb_system_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY  
typedef uvm_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`endif
  
// =============================================================================
/**
 * This class is System Monitor that implements an AHB system_checker
 * component.  The system monitor observes transactions across the ports of a
 * AHB bus and performs checks between the transactions of these ports. It does
 * not perform port level checks which are done by the checkers of each
 * master/slave agent connected to a port.  
 */

class svt_ahb_system_monitor extends svt_monitor;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_system_monitor, svt_ahb_system_monitor_callback)
`endif
  
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /**
   * Port through which checker gets transactions initiated from master to bus
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_master_transaction) mstr_to_bus_get_port;

  /**
   * Port through which checker gets transactions initiated from bus to slave 
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_transaction) bus_to_slave_get_port;
  /** @endcond */


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of AHB system_checker components */
  protected svt_ahb_system_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_system_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_system_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** Flag for reporting master transactions*/
  local bit received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit received_slave_xacts  = 1'b0;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_system_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_system_monitor", `SVT_XVM(component) parent = null);
  
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`else
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads that get transactions from
   * ports and monitors them. 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
    * Report phase
    * Reports cache vs memory consistency
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase(uvm_phase phase);
`else
  extern virtual function void report();
`endif                               

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Method that manages transactions initiated by AHB master.
   */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_master_to_bus(uvm_phase phase);
`else
  extern protected task consume_xact_from_master_to_bus();
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to AHB slave.
   */
`ifdef SVT_UVM_TECHNOLOGY   
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_bus_to_slave(uvm_phase phase);
`else
  extern protected task consume_xact_from_bus_to_slave();
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

/** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** 
    * Called when a new transaction initiated by an AHB master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
    * Called when a new transaction initiated by an AHB bus to an AHB slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);
  
  /**
    * Called after a transaction initiated by an AHB master to AHB bus is received by
    * the system monitor 
    * This method issues the <i>new_master_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
    * Called after a transaction initiated by an AHB bus to an AHB slave is received by
    * the system monitor 
    * This method issues the <i>new_slave_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_slave_transaction_received_cb_exec(svt_ahb_slave_transaction xact);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * @param master_id Master port id which got grant.
    */
  extern virtual function void master_got_hgrant(int master_id);

  /** 
    * Called when atleast one of the masters request for bus access.
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual function void master_asserted_hbusreq(int master_id);

  /** 
    * Called when atleast one of the slaves gets selected.
    * @param slave_id Slave port id which got selected.
    */
  extern virtual function void slave_got_selected(int slave_id);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * This method issues the <i>master_got_hgrant</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id);  

  /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param slave_id Slave port id which got selected.
    */
  extern virtual task slave_got_selected_cb_exec(int slave_id);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual protected function void pre_check_execute(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * This method issues the <i>pre_check_execute</i> callback using the
    * `uvm_do_callbacks macro.
    * 
    * Overriding implementations in extended classes must ensure that the callbacks
    * get executed correctly.
    *
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual task pre_check_execute_cb_exec(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** @endcond */


endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N0A+FgYBdEYVbwdNY1CGV2saCiiR5efuZ1cvPUcgvXsOtfyDBryCyevZKiAJcVBM
Q7XZkKvF4tNyKQbrOdiSw1bq4SUQsyYMyZ811hYIy7ra8NyDOwbIkIgqJ4ox1xww
gCP0m6vyZSLUBCCEWiFTgBXn0MTI9/ZF7g+qcklEwtw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 398       )
kOJw5ree8i6L6kUJT2qXzDfBK8s5pSbBA8o5fK7vmaIx/eYKz5a0dATKSqDbSwzh
SNymocE4XfUOUtaKfczz/plT3/YqOemAOwe5RT26Wu+rAoFkT1LMzD2iHZI7Yymd
fxBWWw/hKagCqaMhrFhwSkUG114FBJtLid8KxJ2bhLKIss+Skkd0NhCstqiow7mr
7jgAcEeiLH/YWGnaTkzwiRt/ElzQE67sxJh1nnL93OJyEqrkNzdJ/ju0klfcg+Nw
8f4mZofePDp9F/nAZp1IZpMteQYcCdLt560wZfPFibXA4eDIPLYLsNJ5AEAiJkSu
qKz0Dm50Yb8WOvG+LIuwZsRV5mABzSeNyDl3I4rjq65RuYkQS0Uzh57FKvP7tuzY
Z1Y69XQpqcAAMaYH0BdfuuaMFyKSQRIVMS748Qxy4GExgxVeKa4/Flpx030HqhXV
XI1mSESji4vkAmkSJmpnqfMyvLefLfPQJ8xrxL8Cor/BZpEO4+RrxMKnliFCrH0y
fD2+TkvYroc2v8PYIy0lUQ==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MPeoFRfQmPemz37yi26vw066qG/p3KVxPj/W+K7gCm5mVVGMMFbcTh7Ii8czkd2A
ZlxacMiCMaBKziTQygFx1J6PsW20oCcPSeRqHqB09hhmPiZLeqPsaO2hylp2FbGk
Y8+fWQcm/SkHDNdx+oAxqaXJrzvG7GQESKwWQ/TP1Bs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10864     )
kdSlVDyB52Wu93W0h11H2RitUVdV70MgvX2E9ulxWcyul6HFbG+BrBkOG9Ktvcbk
1FkzyFsy63ubM5/SWJj/X1/K0Vn6L3vJGwKsTf7jiFaKNX/OInxB9xkOecQWsDyp
zr01nW6XFMW/xVvDbYhKNbylnTwHy/SL3owU+ge9yKUWPYmIl82CPbVrntMHQtx1
sPSdGGd1vJrZ1O6ixgarQz+mUOi9QLRtnyLC8xudxct3UUTpAuzlmcgvwzg36z1W
dX5kk1Cfv5ds3ibSydnPaSOgXmgXRDthrB/ravclnL6r2yQPKvF/DMrWgtTOTqlp
byev6UtDewACaw4A3sBq5vAejTZusvH04iWPYcKtB4YCWTEHQXArlraWE0CFqdww
temu5cafFQtHi8cI6NFuDIoFolT30X0Y5vDscqvhLWRep4WRWRZCdxs8Qiv2jJIM
WoniMHwMv+jKaipwe/AfgF37e5bK/ojZJZidERSTXwr3tU35xmSPeMxWORYKOOsb
uW/RrKLDQuoMEIALYROfJpB6F5GiNd5LfBj7JUmOmEPxln5Dcjj8sgVq8/vjnO1F
dFXkBG7lh3woTb7mA1SvZ+dMB50Bj4QhgU4qXIZdA6yw6ZC8D2RTHoeaq8XG98OV
6ah+HUUkR42K6VuiBIAdQbPQUt7kR3TuX3mdYyz/qZspBdMPMIcTufBg3ykZULXT
Mjl9PthEEF1hnMQupZazGR5aUH3T+lFvKBHmgSRCJaO22uzoHd3eUxVeF2AYdA4/
sxJQkXHZ+JApyOWu+gEHKhYLEecqp1OpBDKp4SUgQrIJ88vKU1bUeEp+gHvSJm82
ZKI94wUw5oxXS5X/dtYwiu1vCPh+CiODM3YTsoRxrQdbygVp+SCGwRxTiETRBImx
AkX9q56OaJfU14vQPGE1PDoENe5WFVOoj4lpVI+pFufIdhsHEkIorVZAxcQ7rSJc
dyCryAojI8Yt54OqNXHsh1LzNuzgaA6qAoD576V5/IYKY7rIklGgjDc/YhOM1iWf
tGg01HwXcgbMV8nmkrDHhUuYh7MXV8hJ/Nw5bce1Guj5R94R29O+19GuHB81u9aX
lw4v4+3epgw8ZBt+b+7n5ffnZCyL4RmcIxru86MyJ55j4fqIAnwOvIIfEccCco4X
+BvKQqfKExwOJ93YCel2JkDkF0Jmfcne4vlPrQvGKKFckGAqy3Oe+x0IvzLttubn
70mbVTBfnS+pe8ZenP16RIuHn1E8s8iuXHW4Vutoj8vH6rExgxI8aGj8zUtyPXO6
KfBwo8ZkMZOS3hgcLi/G9DVOHEtDis/v754JPMzBqG6eSnCjNRHNoLUEGrmVXzZX
osSA/IWFxUHWWxE+pk5Gn8ChY7uN+ZrVyJ5TtGJRJkbfejGOrA8faPQBYsF49VNo
K9dPBwxbbI11MCv1Fv/5cWrmxAjFDTP4+eV3mzYTXyrfVZ0HB6Es5aXlyI2lguVt
asxN6c64DDK0M/BdrrveocjM2Cf/VN0nDVr1ZkeK8Nux5LOJVCWOpjMKr+sKCELe
Z/7ULnGRnZdbWeDdFGfbq+tZZjaH9n1gg1PEAzDFcn6B5OMLfCesqiA42Xb7pxxy
BmizhOs3hD0vlMf6fsYKZkkHiXwXoR5IHjjAgiOj0SmBI8x4A3XSfe2+iBL2Hhgr
1yH7023/NDhjsQuWntXT3Boyz/XrcsHDn7tc4FsXtVTcOmGSyHH6G22inb7jMWta
R2U+TrnWIiB2KV400GdTrmiQsd6o/J1+3SOtxCokXtMr3U/Db3YnDTe2iKh/LHS1
Gygrs2omBxIvp44yklkAxr6TKF7szNGcgLrDj1C7xU5pYi5y9+a6ojBPRSd0IUOx
72wdTgZXZbOH2ErmCGw1jQz8Z/m21zfn8Ir+EX4Crf7VkP2osc4jkDKdB8zchTaQ
6fGvd8zUCrt9F5IOA/oQFKK/7Kn11AD1uXN8rXDExZzNFqX2pOmfzzZ+ZZ/WAxPa
HJMXL/tpPmZ8fdpXxY4Xn19msp4JFKFHrAiXVi5tkoJqgSncNhF4SUTdY8Ue0bSS
AFD4euq2c+RGuW0NbSB5S8nlMzs03TNeLUzB7efK1RI3DTQkoieFFMt8QEC9Chr0
5i7M/nsXHy980mnMVXgYmb4uqwVRcLMrhjyCMVDRB3WONOVBg/86Rm7EJ1M9W9J4
I+CjacarquBtpctrte5wkIdrgRvhavAuyufHYlDxEQY7BzWOrsaSX62jqSX8oIuG
zqCXnSsfayMvvK4HL1ALmXsL+TjZSnaYzoN4+cjxQD+k/n1KFAR/jnSJ1xjnMi7E
UZH0CucX74kl5f3Nx61enHI+KiTjbxDjW4eIxgjInPOYewv0vWhELhVVX735qCQb
6sEWBna6kEIm3Z3KRdTWpDZGx8+ON9Da8KaPVkBJ5R3Uv1Gl3N+43VPTGjfRD6Hm
vQe4vCjN/Hs36QxO+swy7cGEHTOTmJeMZTDaRzI5pkJfZkppdBbRQYtiBpT/Uec6
U9gQfzXclJSccvCmf6df3G1qn9ulxY53Ne7jT73JJAgQ+N0U9o5Y74Odg6RAQwm/
7XTDfy2WbeKzp9MwUv1emSuDGUt2nVYDrtp2+oOYlf1BTGnRHYQMGxkqTFMYC6QE
lWpYyuE+NI+qqq8o5iIzGxdHdf10CqrQeilJfh3u6xutWpy1DkEryXyulF2gKI1E
2kudnS6g2X9UiTuGXoXIDcv5sN1z+ck6IUa2l7U0J35fQ0UadazeO9zQUsDd0D5j
r3NMJNoXqHI1e9zbWOHJsMhKyzb8jgpyQlux2nadef1XMQ6hiHUuToH50mluhjSy
EcAIAu+njkAclbKPjcnOM+f8pzpW2atM7UV3J40UQ9sdCSbpOe+eBvznAunRIEmp
DEHiM1RyEgbRskrN1ESqEmWgc9vbL8nfmQ4LL4/NgFYUDCDz1lhlxJtz+3weq4vw
b+/qs7O1u/2Q6juXN+Y6pJa+cmCBJSjf/9PAQa/QZchFD9RXqj0rkRaw/EHWhMZD
+LiPOZD2MVAxR3Z3m0VaZLybNX8eRjxGW8y3Aq7QV3atV13hvzaMRRwMQCoBAedu
2xxPy8OhNDsULGJJgWHdThXkhtCH9VFGUVtIcG81/RaL8sTPKenAkaOC5PQa1HRA
/Y/iohHiclNsXHFux+p0UsVyWoRE/H8jl3OZxjsmQ3KEO1Go0oHNpicsTuWqzSS0
1ebBSy33FDlx/QhtvhmiUg77Vz0TZNgv7OGvajLvkvRlnjb+LRGjAn4H03g2PAYM
ic9HFAAmfXh8+DZnWeIxtZEOn73upMICMD0hBY4P3BJ3hLzNLqfNqI/jqrPC1Gis
+7IhAFvHSlvubl22CvLcNsDZFrWTn4w6OucDdKzl9BqvWv/VOtCIq7PY/4lL5VA1
Eg3TX9OichYXJhkP2nx4LSn0nCj3QPQ7Pah7m6GtnTv9ck3/UbZko4HmNGH+gDnq
6BlAGAs37JSWZi7P0RLECOSMJjU/phadmOBT0HVFDuBjnXge/hM5bMjAQjjDDCCY
d6EXY53OP7puRvJpwTk6NT6X+oaQNleLO/8SYxokco2Bn5AVeK1QjMBAorpN44tO
xwUJbWDW+Fn8nyvagbe7wnUTyPnTHkyR2Q0trXhjB7nYr4DS4pkX7eaa/YTgB+iZ
F0ZWN7Iu/iMkcCvxfo4mY8tJq6IFmrhGKQPBtZCTW7wWYWkd8zXSzU0R2JqWpx/N
EA9CnHUFtv1wVlpsWQmLp2f28Vy74U1ys93LG4wF10b8aELlPfgCZXP++Ygeahs8
ccsgvO8CaifH3cSqskgzE0SLGWv0CZ34vM1TCjA7ULr8ID7kNFNOuIzAVBQz6pnL
4CucWWyqDzd+2SYGIhN41Ky0h8nzghS/PRRo7977L7YHDcXAXxej4nHAW/wxMQAF
jCDY/n51qAoS9V3btGvcaJJ7ZvYpyMde1bLhYMXzuLb5FtTEROagwzzAcvYJnRq2
ngNu5jBjgbf44NzbxxiCs4XgwPGW3+3Cj4Qe+YsQ1NKYyiFxn6Jhgm0Ehw/JcCFl
04p7mmIOX/8MnvQ0VZEY1qGIEOK4I7wS/lfmVH6Pvwq8HfAth0WAh1hN6QN1Wqhw
MrcTel70cjSiG2MtyuX062AqXsc1BNc6gxQd3TFzYf504cWXG8z1Qts5TlVC8yLv
Bo6YOv87+O71aQ9YkLIJifitLaZZkEZElXUJVq5LGm5aGLrHx1ZG7q8M4Y/u6hsK
9M6tth34IdQp+Z9UjV4amxHh1JrqvIp7R4qk/OXswKDB0oAmMRk1mRrabADfYCou
0Qj5/mWX/rSThiFRi+kL3ZuOhUOA++hVw1qeCP0VwQ2QV4/jFRG3UcJo0Yqw9J5R
uqeyPfG3ITg5Xru1mnTgHuf1NbkY9Pi/rkBV79dqdMom7W8zQ4lZfleQIAat0Th1
Ars/A9vpy/EbqcQDkd9xISvMr+/mez0nYJwYT8dYtZsZfUYVEKb5d63J07iVX4Ch
yF92EuDfssmbjaNcyR/Ji0b/QhoEBX9Mk9Pfvn80tVgi0Z46fhGHN3vNBPVMxwuM
IF/DlcCBbn++6zks4HbHYuCCGSMJZu3VlXjApbhgi/y/j63Pxfc/abriOF9GD67A
zZDniZGh+i0qny2j47aBfSrg5MAz9WqRcyoSEiWEJVwWz2mWTRgNHw3Vo4REK4QD
k6BF/ajTFJd3CjFdBzzjH7iCe1+4koFsQy4MVPEUFJzroo76JRhHzF+Y5VIahDxF
GWhtHrRLGBxQ2xw81KgFO23Kp/KqZ2fBgOaQwWALsMXFO9q+R+DUSHEBh+J1qoPx
ArY7m02iVSHuuHmLwtGVdb2fDUZVOwPbOfZ1od5LSLcKRwO1JKmFFf1iWLz9yFaN
yV5Y8eT2MvszIbfN50b80MFly/Aa/TB9brKvRgDjg7+hcIKDjQ1g7iXXjSIpijxI
ZNbEmc3g88zqFTs0P40/xBE2NbRJuwf+AWiEYEwKMCSQ+rLkLC69SLut6WQdRzFF
2aBXrl4ZMkgJ4fw1zMCLcLu/Ay5ddeUOsmwttG2Cp8Weq1Jr8yTETyZuds/1v4CC
v0YKQIwyzNsLdvIj3/yoA/lY8n8MCqk5F1zaccyU9bqvd31j0y3WkJjIGaplBJ/p
vpGP6i+AbNmVRwioIxD7lcAYxWqawJOhNSJKDY/SO3+aPbkRvSnbZY5Z7iINHRQf
ck/d5HsB91FkpF3yU7N0UJcbeDiadE8q5fgETsYEftAAUNQlYciGdGamQqKjXCFk
KJqWeched3hGAlh5tcURyYhTH9P5ojIaoPqF/jbAmEbHFcW9Myl472t+cHEBZA8Q
OP1j0PzjWV67/+fJmLSCsJl7RZ0A3B2z4Nxoqlblwyxci7L1TMeXkkHOJfBLV49i
bPnuAJk8FTlAbtPVwXU158bIjrLfciXMcSJmcDTWEXSiZoSE+4Fzq0h0hlUl1nOS
7S/byIy71E09e84f78G93RM/PRc+zk2wMfUH+/uLegquwileZYL/pjkUkbM/Djdu
55Ppsbk35D8W1sdo1G1Qi8GhMgvCbfzSyw0gwjVlWMlSX+ZQZbEiVyaq9oaVcRy4
iYATmBy4gk0DGPL5y3z6rpHQWmUonYcmIeAaRv17yxMjXFuUe1nks6OfF8Z1yK5G
UuRTjQm4wJz/feMh55GPQ1eI5rA8ImuVXa/22f9CoKRS9ucfgRQRklYMz2kcoUU9
e922QBtl5ryvHV1uw2sabd5YuCKJMQi4e89eWOXWULIxyMzP0+3SrwR1T+9sIGvn
o554eaXVF3/CfqTwt12YwzVpPuQs11tAvfUlvEMZDzXu0SokA2/I5cWRy/S7XPbr
vB+tMvXBrPEfcwx4zE+ylUFJxdhVqvbnbv5pHL3XwKzbVatR67Ikd9fFpwxgncjy
+IwRioq7jdE5mZkcVGyqKX/1PyaK9yS1ODRrSc68/WBFzNGfx9r48oMUlQ4AaY4j
bKfRzJxGdSo5QoeGjg8H3ZmOdA7uw1+Q4zQzESFRdPIZTkjFp1cnwmvNFHKdlR4+
F7NDyN3QRhOApBvtzag+NWTtPY3dJOvOQBvPYEB5A17g5NUgcuWM+g5KBR6jX5qC
4HWjeNShIsS8VY186ew527aeQ6q7TPt7H2p9GLihxZb55KrWZLz0Kw5TyTeRBI+t
jlwHQUEOib+YQU+neJrnFqD5z5WeF+0wiWvVNDI1mdUCD10nrNAoilSKH2fv0NBR
/8IHBG0d3kQEsDA8Wr0dQl6TxYtaxS7A/khz6spYHsgnJUhL9Oy0PFpSYKdvzSnp
uKz7wT/eeEENmpxssUQvD56BUYJK6jhE+jnMQj9dMW3QPtzHD5NUEXUciSr8ubMQ
BqZUkxADJhCh8rwbM8KNI3LgtzZzx9zFTTsAuoX0C/8V4mOUwNPRzwwfgl9Ul4vv
njKxmCG9qpihKgT/5H1pEKMMqbQZqFcX9X/Q9y5ReAhEvV2RMt8d7YS5KoKenSkb
VEFBqj30mYSSwL+beI7EKlUpXkQtFZIhcvIkwhf+kIMIB7Tkg5xThP4jnGXQsOaQ
Cx0XDH1KPG4FmqZBLmiWb6DQvyvxVBqVSeZQiMZ+m5H7cMF6t9ZYnpVXKXJYmt8D
KcSiY8XP3H2BKOx0cU/8gNUVCYxsGfpa50CET36urvFNLCE6P5myPsF597N65BBn
XW4hyFYGsW9c7pXa72c258L35V4vJNmN14nhAdVzDT2QKdm2z1mpZdxglb/udok1
pdlJHxEhD0RYFhD93Fl+Vvv7rIVHWus6lrNTtw4p9uxxPQ0MxREP1hMt0F2/0AlI
76APMUSnhESqnFKQr/2V/IBh6e6FEWNZyuZ94NiVHptocJEEBWOQTgGM/959I/i3
Zxq/MDqw+5ROdsYZO9hIDnsX5jld/5X7ZACWzKo0mbSEk4Zv5uEOLpgtSzNNzNjA
aPQut8+vox/3VhQIj5phvJ+mo75MpF8uKkYc/5TB3pIpBqBbrRHDpzHFzLEATR2W
n0/2embjwKuheyrx3EAnFFlDQnFrt8XD8xtDu8m+Q0+iiPIydq/GV6Mk7ug5KrBS
6RoaAz76uQGTzUDqcLt7kIM3ZK61ZZrzaHAB6f0zhG0fyyY9KOVmIWWu3zxI3Nxx
KLiL+ftVcQHdwVOqvpR4VdRC4ferccX54RwBtiKWwmL8Ejz3T0DZl2mgjb3jy2u5
CwxKPGXtB2vznWJwLSMgAYpE7/X+Mts2sJZyafRewNAB+pwjlfp9unjrBkxhciwT
5lJD9WTXqZ3h9rmWWXgUrNY7yOFXr3bclaUmEAlCJX0FrvlS7nu6kybhmCItw7JB
6QwOTgxDbaRYJQFTua195iBXV8gR//JqQgqAiGaVUPvwezpp8izg6MIJB49VN23E
sSl6DUwGrYGcOMpvVLaYjRB5CmOHaizHyxn4aB6xOmErpEN7S1A/npG6NNI4r3QS
AKZ07UjRg3icvsKNTiywz2WGYGAOihFluJ988uFDoggR33Yh2NnUFnlLCtMUVLgZ
gXYk/K8OizDBFqMnvPbRAClLQkVt9gjXR0fVDhX79gTO8xczLroYO4zy4Ih8jKG8
17XQNzx74Q78U+x9QyRZfg+C70/yHvMAXpfKmWlJJgwsni9fGbrH9GOtXnOEbqYr
1SVNs57vR09Cuy2jzrpjdZSVCWv2xFOq/Q+P3CZ3nlCf8GeETI+bMnBX33cgvmL2
B9QczJWjeB+Iw1DJeAsuQD3gxGb8CHgaZOaIRj/Hh77DAKmwWbJNd+kaO5Bl3ra1
amicLTm/TjcIvurq/Wr4HUyY6fiqQrPistCl7AZUKqtgoXbzK9CbjvNK8Gbc0Z3V
wVMgFYP+xQ42Xdnr7DnuUM13UKkubtLZvn9JtFq4YPfS1sJVTB0pjvMWpVbifniG
gb/OgMljXTkwick5VONJifGqYTT4a6BFFYjVbU5Wa74EbNZfp+bAg8ZuTVBGrSVD
PEBsLt+CzejKXjkPyqt4iM5dBhe4wqB6xEhZBemnPgh8bp2r7YGr/hx19bmjbdge
cLHUEk01MD/LQJ1sZqdfGT0O3ksfTyXauQfAWimff2kC2TqJM3dYW0TEyxErEmb0
199kKyp/ClrUM3fdJHx4DyXW8RXyAzw2uGLfxKDe/KHVGJmE4uStdTpqICvSpFBW
dSD+4ABCEAsvp0cWwV8Kh3rbq7H0aA7GK3sctKm9hk1UkqYA3k5dBxjrJ0cL96rj
d7lYo34jPbjwG+hpREsYq2jkedn1RvTfi0VoXHHl7MRQVsnlOLUq1T8BEtV2RRhy
J2SYkKZWsDXAl5benO0e5dnIIm9ioMQOeiO/HxRLmxLK75YusbzCV2gntff2oIQ4
VZnkHgLQOAYLkSy3cQ1CbuKvMgT7oZe+DK8oLNgfokcXgGNUfOFktVVY1DV9GNb4
9Y2g9mlAQ54YAd1AhkPBt4a1s24Pgdhdp3WX6x5eZxYbGNPCA53CCBd2+kHMDP7G
ifS4JyxqSR5w3zmCAw+rLX1MHVZVxtPA/FC262HXf1OoAN0nsMTx/e9D4iFPzKZp
Z74CxkN2ddyJ4rddkwknMVXLtyMKF0cSDK6hgkKHOPs2uF+l5jDHxQkAHFzoUmHD
FEuHIwOt+k1e3wFkl4FImOqc8G9RK9ez1ZXI4aTsldfgzV2F59QQvoP40oabeJ48
86MjUwm6sI1Z9kuf/JuYMAEh2j+bXghpd4zVZQ+xgP46THhH4UlPZb4k5H1yYjKC
N0MDlsaUAAobJd4Yb6xNp5M+8+eZXXrRRVRgYXJtMjnG70ReOB45cQXxspHlOvYZ
lSct0T+lvh/V2dCd61M6HMuLVF3sQ6YtG85Gk5SspLCIsxwv7y1PI9fkF+mIJzY6
B5UTWOy1buT40nJ9RGGrA889q9PmeNFEhbE+3voku75eT3nKwlig6KYLtmSE5HaN
eb64JGzHVCgie8mTSAvOR5S4b1L6lDznDzchPcXqWNuuH+cqBmVX0PxJ0UNJvoIq
dxppA/Gr6+H7paBNvwdS4SXNylby1BP1dVYWXUh22oFFwhCLPcKrmbITrjDruD4T
A00qzFkpcXV/CxhyQhRQPyH11US/iQENtnddb4ljbGfOxG5C9U5Tc9G7SWEuHiZ+
VEdIdUp2Td1a1GktSA2vyrXfPkmZxkhGB7NrEP9/GlfkZmBqme+Nh9ciIOjV+4VK
qGarUIFvi7EYV7rsMYmMmnkR6MkSmwQfWJY/B8frLEA/5t26EHZvHsrV0IR+1phI
MlrwhrN5xErkK4CJzN8N1qEWYDt7OBXumtXSdQTCoexqlMGIvjHdfMaf7TKkBy7Z
2RPz2zStdOdY+2NRX8VOr8jkisXpaicxEOdzCbB/NPx81GjUvzxYgni20aCuTc4Z
gjVry5UtsDsA4HRZh+2HI6qV5NQGUgI9Ms9mHsflXCUJJOVrHA/8HmAiksbc7n/G
wvc0++N44CpXJX3KLn9urPBfuauX0kg0bKH124oGtMVIDWiBxgWS4f5IG4SXTRmD
QRPjFgaeg4ICrR8Xv2lmsi0sjE0cHmRl8k9TxXeo2z5g1Tld0rgN5DLthOqaTyiY
0XXLUc+09GRTeaEtsRY56aian1GKmD6++hPNPUTc4DTNX/0o2HMI//b6CacT/Rlp
YW/DBLu31YV8Ul0Tc2x0YRVpCwED6NGwxP8UZ4wnsxamya6JYSXrYjo9hUD4fYC/
KkIl9sbwbEEgRhAXMttOf6l5D9qT+SVRogp5U3MYHMwNpZNVH07LimDqr79pNKg9
+15fFcuretmkkrZ4VZDQj603WAPPLsoJsNT7x/+Jg544oD57Ofp3ZeT6Lwy+7+7a
HGdDtLOFKufTwWy30lUZXM27F53b41tblBrs28FyyKNcS8pgukACoRKqGi3T1gc5
71rI5OGWoCOSTFtMvZKH7z785EETa0Y4eVL9s8j2g5v2kTdOb761Pmm6XWIGOLlC
HcLvvyycvZ+ojLMeiT+3tevfW6raPbynZhNJUCTVNUnHvmC82wFiIq1ZCAT2U9Ph
lCMK2yUmSU7/nQBY4BPYtElhlPLyf29ucZYmYTdBNbzJWt3TaA0NDFEVgO173tEO
4AWt9+FaU1+STnMi0PDa7OMi0uUFSu5/g8DFGlCx0T6gpBYGBZrCBepTT5LygqDV
dj0/OlmJz0/75qiqMbSfr4XqY0Yy7ZmBX70m29oAVSBt7XycLnv5p2C1M3saMTr/
1lHs0gKr2y267hscZZpS9cKcrQk182219uIsm3Sj0pH0sj7Dg0Gm5+ivMG2IA7NU
CV+WHKc64Ey802uLKWUpipYxwm6hYLZxeLyi3qXKQSBkT86AnLL1J+FxmxDnAlN+
HE1SZRo+KfCvOkRcU5Yh0ryAVL/7stgd9VTM6zdBGAuzgHes9ZqUC2JF8qo7edbd
HZQ65krlg9pRrqe6yC+Izrg+fnXivDWwLwyqU7M4nEskC5gf7Kj3/6OKvwhaJKdt
HllWiI+hjs2UdNFq4rVIcelgxKNlVUSfcfXxhGKubs7HC5ohEaA+hPLs+/ZjffPs
Ut9yQE4VvlQf947o6J1kktekYkOCw2sGheyYkhh+wSdPkdiwN700IfKe9/kfuZO+
skuaGA1iKDhVuXsnA3psFfRlGGRNWHeGR2j37NZzhWD8hZZGrr5NpshlITLepM2Z
wk8RxyEL54nP8voYPd5KvBNuyZwEUi2dBFhBGVjd+z91sONakD7X1fgcnFuxYt15
gFX/TtXwaCejlSAQBSSZRa4D+t5zF66rGmeRUXTuzlASIfDO+T0oc0k8DX0n+J1q
ft3rpLmeQQovnjs7rWNULa+ebKb2eJeZgIrkVm6I61DKYLbT5Vs1pUHfJ5DT1kw0
QqSP2nlkdS03RcXlWRQ9h7IxlAFBnVaGj6G/pQEFI+PM7WrUhia+PsUb9MXwtgQl
iMxiueaA15rrw6z604UJzq+CjyVtyQzsicyHKFSldFElreEjLb6LBhYH+qRcid4o
I4VK1dS/hI9jRKPt2US2mfIVn5Cp1zC3iPEvUwTeMtuJQaQJI6QOPTgW3Das8ezR
GbHfuiWmx0Inox11+mdmRWT27y2yHveFkr76bIYNFwhZnmBm1XLBK6DLcbgTEpNK
XKHSXRICywQjMp05jo1rRUqYKNPFkqy+K6HJnw0j/ljIW8C7TkhCrVUfmiNXSqsw
3SGYMyCRVGmORAdVU+AbBv+V93+/BwjXH3FFH3pgkP8MrB+vELDAnnefukNxG8kW
Ep0buXQ+fYCuu7+otsnI5Hvv5G04FSWCdyfBz8PESYQVt0LVPOUWokOH1/10HtKP
hDR/y6pyA6QnSoF4qD+CeEJNDl9QyBGD0+9n3qb6EgeXQAKdYxO9gbhqF2y3iyse
ftZ6OIsyAAWzF6iO9AVLd9TPikzdCTY/diOG9TkGlFFuU+0gtpLSi1eF6RaGD34B
aA58LgjNzjq8qoORmOCGySwgYCsHW/2NzqtIK2rvqXxiNN+T4nUNtKEl6DC1Qr7y
5vMCjfibA0M+Dk0GoaoRhxyCkyEuR+sh4URT5yc1ThP93bthUU9Gu3xDFafHzhL6
fxNhQqgBinUJ6f6C7w4415wA9o8wh/MUnthgTiaPNUy3DF1oxRWe7Pp7/iUOilQQ
rTD2uzl5vMMKC9OS9wy3m8eib9rwe4jeNfG2z/sthIqy2rujQM2spAQGtTcVGXiC
cXQNfUlI32jMb2PaQuHtGxNCPTwKksYrevcscEPK95AQDy8N3q0uZL4OgKZT9wcV
aPihx7gN9Df3n8jkMi+dBo2v8R0llJqimODsVJRvyjVaGF+c1JuLu8Qfika1k/kG
Csuzv7Xnph8cP9JsgTbPL+itCl+HPGeZaddImmywgg+XxjJbY7dHYMzHtdwQOET5
MVIUdlL0dIZDui/s31pAtnL5ozD/SbDSuWoJ2syU31IISXajtLtvbWcSDg4zLKjH
xyB0K9e4FlpCH54p3opW6XnF2varKONBnvcRlVyiKCldqZ75KokCa6GZswx+H66H
1WqgnxBbE2SQgnnHpxyLBikaepZZVPw5mcUu2uVGVFmAWq8JyEu895vjjq5Rjjjc
2Wtgo6Aqz/czPV1Sie4JcD0hsYPWBMHluxP8Hhj11INycNblRyVVnsBnwg5hZAHY
EbtcbsJDKDhrZNwMmsdrDw9N+JhJ7InmpBZeBEJ6hl2nP4XcHCsMwQL21QVbt9Tw
IEFdnOLLUp9K8Bh5FYO3bUx4NRWSd73uFNJdPrfXd9CfjMwsZ9f1z1ppYdiZVOhA
XKjoBz+PvMuAwnxzc3B4RPJke8d7F6cKIQA6FtKT84U0D5oxrF+wsVl/kEgvCueS
liw8GeYN1Ijz7ZZSwr5IsqgKRxx83aYgygF9UEkM+CwDZPP2FMUzL8nX8cNYBmSJ
5I/h5j1m1FXFG0NX/n58mLRoNAPoMWZMNK0YrRd1t9Ej6Zkk7QWPunDxLwJa0mJf
U1+p6zwZtUaknFv6I9jLG2Ly/a5MmQYLHCLM8L/c7MN8T497Jc044vuzYmxrVoR2
whJ0uc1ruJFNQGe8j4477XQ43oX3cAn+KFLxOEDp5S2aQrpoIHihEjZ4Q/rWAB9F
IKtjyauJvrLdYtgSlljwSus5mTM7aFLdg8GrWxHttVg+0Qu6wwOOqOApR4jHpLZE
PTx/z6fTI7wVtewO4qk4IaOr6wvPWmrGhsej3jeHLRpWujbRyesyPD7P925wg7NB
fHzADpYIZgexCziMV1M94kjaGDiV9f8SUIX5uewLZgaPxKPZ8lDBDPKFEo+hUlkH
chRYK9LF5DWUkwj3Bii1H5Tayfcin89Wtir6fLjg9R2UK3d335m8GtuErveYdZqG
+bSH7OWgFwQ6naQ/LsP4AacHQ5xFNG5mAEMzZMS0MwMYAR7EQSxYysMMb+gDlSZ6
5QhbzYklBEVAsSlBDXbKQmqQEj5jElhGUfPcTh3gbV74tszHDvHUpuB/6tB6eASL
PfYVK71wAClCQRAciCFUInzhFCRCId/e2W22oYUltunOHFk3DMcCwn8MSu19flTO
qCYRwua6u1zVLfzfz8i333SQal5K3vRqglfQ1VBczSB5arqpP6rHVvujS37wa7J/
JEdnRUwRzoO0nMYL2qBSk68Bj2WEux+Q4w9/BAliELdnfJntUlk4eyouVVtWxF6C
M93dB3n3293NMOGZJtubCy08IEzfMb203Pm3HiS3IbxPwuXYnUF7jG6ZzarkweHc
/sGTj8IW/4ksTw9L5ScWGs04t2TLmRkIYvDt1pUbIslc0SH6G78iGtPzX2qN6qsr
GK8coqAnkyGpZDNbtGhQZUe6M4YvNzGdsVmpiItD3f3MPDWqJUbP5VI+lj4WotJ9
v0EObMVh1cKr5a7ww6iCUfDfFapfMF2IkWaO/5h3DXky3aFryuzQvOflNk+5mMEY
LcGqDxYPwXkiwTBPiVheTjdnnhLElmHtxn/AbxeDsA5J1dLCNFCD8g+p8wiqMHjz
nRDI6oL/5w9+KPsSWroJ3kma0IvWMT+l1sxwSy3uYmi9tkmCCkMcjQg0ob7r7A8r
m7aA3b+WYtJIQUgbiTcOn8fv/uvsXvEj1DI1f/NCVTJhokWTwNT1jxyXzbWFHaDn
tpvVSewiVpAOGHrR9XiANkD8v39YArWBokYMCm2GKDijFvZrbNEfCUqNvzVz+LYa
/Rsqt9HBBumpPS/dl0X3+768PTxqclj5sVhmXNa4IeB+7vp3UyBfn1Kwtp9qahaH
tpAAudBB8a6O/jp/V5XGjRHZ6w9wXUUDRgt+9MA+jzlZSpimltOScrJ1EzKmArGD
fpBuNrd3ZWVIJgltq/Avn+o7sMB0eiaeJ+MMcuxjMQ8uLh5Ux62CywuRS43kE0OG
gqhbDEloVSgZX5gjm+7s60a4Odx/dtF1Taqz8fWzIuWrlCnY15xlE71tKF55KUAn
vdrRKQy1buyB96bbWfeXYpiggwLT3IThbgIAUBgPjWu/rb/nQPBmGAFzkI4KWWfb
vwBOYDHzBFjYEzFlE056HA==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lugsC1QB/3chpPRx7mNXnn6bGpnPzUcUzKmtBZFf5BpIqJjxxxwg+tLDFcx1U2v+
SPpOlRqTLYjdCzrkR5KVEf1IOf042FLeFWarwTl5dnI39e3YCDaJexzTkOp6OyEY
+HZ30OMlDiaJkE3qQmflZaj1V4H3NOfOgk3o26BG6DY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10947     )
74STmpXwYriRkjM9zE1Eff0TgeXhbkj9Foe0LDqWSLCLUC8T2NhdWkasAjsj2lq0
b03ERlXZ0rNxv9Plz9PAmaFt2761UEeqDYr10BgQ2wFrv6jIEQwfm/n3csuxFYJM
`pragma protect end_protected
