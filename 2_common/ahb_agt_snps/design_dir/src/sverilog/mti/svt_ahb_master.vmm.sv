
`ifndef GUARD_SVT_AHB_MASTER_VMM_SV
`define GUARD_SVT_AHB_MASTER_VMM_SV

typedef class svt_ahb_master_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AHB Master component.
 */
class svt_ahb_master extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** VMM channel instance for transactions to transmit */
  svt_ahb_master_transaction_channel xact_chan;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AHB Master components */
  protected svt_ahb_master_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

  /** Transaction counter */
  local int xact_count = 0;

  /** Flag that indicated if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

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
  extern function new(svt_ahb_master_configuration cfg,
                      svt_ahb_master_transaction_channel xact_chan = null,
                      vmm_object parent = null);
  
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_master_active_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_master_transaction xact);
  
 /** @endcond */

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UeIeM7H11Mi6wLeCsnUQ2iKCne7+1WrA8/ST5pRiifgMSC8hfv8qN2PqKnroJdeT
5Dyr8IfWsz6NP45GVNTS9q3RTARhzhXfSS2gCLM0otlgM0F92yPLuyQn6+kZGvOf
vN/gaYDecpk7XWskSbZ2GP941eLqb+9cuIVIiTuSRHM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 240       )
H6mKpotiCt/PP8kt11BUx5NiWI0JwqaW5HEbCFVsqymjgobzhs1an/n7Ftirhb5E
D11ATIfZ4ZGpR9f5PGedqarD/ZYyHZkJ6MaNWi3VxLBGsFyriEFyg+ewozUAvDSu
t8pyy8tI8XnwFxVbuwd7kCHhe9FENMTTuLY/QuU/1p/JolFgx0p016oYpCQe0ZxA
lVKRDlpCClsz88CE2Iyi0bKOGUseA4lSLD4crszRWRhORJBfqnGLRf1GV9D6nA/p
pEfBDl/J//WU0RezlXwPPaeK6UJzvyrbdaGJT5kCk/OFy+plHWlDRiTzmp3NdgxO
AS9ozZ1Zi16HUuUnGAS9wg==
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bpqYvh5u6XnZM2qnPSq7wHjTTF2EVj7P2Xx15uh6YqzBqcYJZevRf5c52PFLbjD1
+iOE+8NNecFdcHiO5d1sObkF3AoT6gVtZ0QMv0KkEq6Re+WIXuiuTeC6eBDMJtJ9
UuHpzrTAGDEqeDL3TeAo5X7V7m8PYPp5UgbF2e6h6TI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1545      )
OS1YnCVL9G+Ky3d+fVlktUQhtUflcGlvFTjuj+QVz7+jQPEXFAAROTim7amXOwvA
RjdWuBPenFAuJb2IrePUp+YMHcRutdoS9VAe5riytUIzIzvUpQrnJF1NQox3s1ZN
nU3Kgmg+Tq3+hlpKAxrt04izKMZQD6t64R8WACsEdaw2A9Mz2z1ckg9NciyLqfDb
aV3HrOkYwOrpWa2voxxIjCySFNwGN0xFBReJMprXMCGSITI0hoaIUuF1IPIFSXSL
XAfc69WKxANVw0mpPSl5nw2R7nDZWkpjGx12+Fg5Nh04UlWhOo7sWYKa2l7JdRAZ
ntjB0nf3lHaY8ZDkPDmmqGTxCipdmhyxUe0BREb+t1TuJOIp3uxJe4Hml+Z0cvdj
AKnYou2z0IKN7K0W0PF+3V+mHWi/KhnO2Wf61lB7KFcocTWST/i9rOTlWZjHUMCk
YRwHftICwY4S7Ichf2Q2sTNNbL4jayicsrr/NdzjFHh0gDOUiTq+hUFJqMW5EruQ
9fUAOtXwUAXslRCLR/tEQdgiNKduQy+Ktk/j6Loqlek3AAmoAnFmuIGu7Zwc2+FM
WP3zFM+a5ixOY8gGVt/hV7DyLWsSwjCJGH3lmy0fHVTdWQhL8HxMFY05Odjn0Br3
BiGr4D9KilwP4g7ru91wFsubRINa4UDkh6+EICRZF1/I2bqZsG6n6kIdqdSZc+z8
iS7rnMHmJBA4yqj7hf1t+EPCgEh3uZnz7Kx793zjR6hMQW1cWooFW3KfQI7nOyG0
Cf86M04psom2A1jcGfUw/38k7eVkJjaOFrTv8Ra0B2ibqqYfhLEL0isO9DLpcWUs
OXISS5hglTdLQ+Qv9ZkHq1qQl2wRxdh06Osy3xNHiVyYc1OuruKYaVCbZIdcjB1f
UJzS/DECKwBj71IOccnGdtEGuHiOSG/u3icIWJoa4NmOwt9fhPrx2a+XDQknRY31
ZFg9OXoogPPqgOQUGdPtZqiMEKEUCDmQZxUakyV0fI9tNTXM0ZCa6P7tEIC+rgC6
Pc8qxQMIB+MeSphAofDQW2xZzwfA2VQQhGbeIxoSxmngjnFnA6Vv8p8x467KmyBr
yaixwmtKFWbjDfIJoSOPCjWG1A4xVRpX5lE3cL7IQqL8UkEHO6bqMNXx1zBcYaJ5
4+s86b4WZfiKgg7BO5Jv7UgSo6Or7LdtQKyF77vqySTMtRjWLcXV1CI3vDG2etNB
qexF7Eyyk8A/ESH8fu8+51YY4La0yejEIQRjFs8SuHL9Q1nrFqMPqgfGmSf1nus/
RPEE6A5aVcBZ9Hp+zcwsqaN5EX34EKBbHSQE7tvBzzzxfNzwJq+4Khes/w+rYA9S
T2FxKwVfH27SjqjAlUElxeRk96qA2HBgE5CocG6JT8JJuKIdfcHvjUVJgFDZ1ysp
DtYymb6rGS4ifacOj2QrthrAYUwjYP2Gna+t9UXpK8401Zg5STJx7JgbPzg6lwqh
yARyH08YTsi1JLuqr8s5T9WTPFdMoHW26w7julp7L/+s+d/Go8G7vRXCHWfddR+N
jhbvNIjJrFz+J6/00fiMFa2dtFKqQhmWcus8G+lWCqnSTtALozCnnBoJ1LzV1o3g
LaXoyuqye8fcEdJRlRN7GzjmFNgN/Jf31pOb0gzqlCBFDuDCXE0SVbxFfOVd1qjP
6ffnZ+SGX8e9vWY0sg/uBOhHTMwhjQY76NcR11aCnHrKaNo7RIY/OdkFbv1C9oBh
nuRXavOCWr8MoOm4X8eg9g==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S9rH5i3AKaK2xeBvdbGRJF4UrO7qhwOu7EK7YUsYMSh+8DE6jI3XGbWcTcDzwz/o
HW8TGMbqMUuKY1JdhL0rKeGnRyTVszsBU3/yCBcPYzhQ2iPG/gw5rb+wNjUwo5YN
G7n2IN08SYe6oW5Gu5t5qpe1oHyULJNyfXeiL8cQfic=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11769     )
alfS8ZjlUgJ7GN6O3OeOHnGFmk1RgBjlElpfRwMoB1omgu7xJxKa32A+wL2YBTXp
ZaRLm5V9QDMwsY5nqP5PtN5VLqrgUZJibbgLjO0OSwer6x49gYdqsNyIqFn4J0wh
qDR5zGLaW/5qYHPqZw4zuAqNwEG+pHNJQopvdDksOTLT1logWiph9rGUraNP2DJe
Zss8ozXJES+oGrb4M+MP51Se2uV1f7qqgp2lAf7l/zm8SnPVxj3DgdfAjCBaFIcG
2c/m7MC7JZ4xfcG+qhx02kPLOBiA/dv6z8iv4aFV9nLNUZ8c66ba3CCKQHkUEIZX
ERdTijJwCSPTUvQaARRqIhTSxtoA8y9vQMxyaud85niGnzamRfwTbf7b0CIHvL3K
/PO2h5LJi2HRvMZPFq3Lyfoy9OsGECYdVVmlDobzcU7oy4Xd7KQy9bDdaJVBED4l
Db3ewYsUBVAcg6AS+Sb5O6VyKdVCngcPhXb62+Bfl9W7zzytx3QUP1wlSuUGabsm
bOvVap0wqAa7tk1fDg/XYyuCtIZUohWrmF3sssiDW8KTPpHCRwe4TWkCkNqxoyve
Hx+/zFnYIsMvcFgXBF5VsnX/HxGQlqJGUGcN6+zI5nWMAelz5Z0F00GKnpviBD6e
N4Y0fRMTbPqse8XT+N45YbxR+5I1fPNVmjP5ola6qKo5qqRceSBZiDuh0MdVin43
m7UHt6LRPRVgWhLIsPT7JO0PK6c1ULZgJ0sU0S27JbnUnTLvuHptv6IiWLnNCpfL
UUKEO7Ny8YLgfjunRnRxCSqYv59+7nLuBYpK+0YqkWg4sHbArOv1KUPmsAWXleBQ
ZLhRYxc09xefLT4UvqTf5F6ALsFx7byDL+NWpl025xoDA0HlFk5k7o5JJA3XOFKC
2ixSQNUV9vE80ZD+2Rrzl7YjcJXJ5fohspvgoPM84AMDd3tRb4F9wK0agq/NNeVg
ZwToOONFZxWQI2k/8VEWX+XbsqirK2jsdqCPsZ5DSssLdLDNROuXtEC+doMGsITx
MVXaMCJhifSjVc8X1Naw7J9cFvgdR7geHPu2ee4221F9tsKIN4ScTbv+bo2UXO3q
WXDYwGdrEDSaUDYxMG+LC4R/HXpAZf7y9I66oJ7ZfUiRjTXcGGPr8enQ/bXS4sLU
ZombAzrgc8xe90u1jA3JCLime24iQ5SKNgFEyqr1zOhV1LyARSBJMJ7zuSC6PR6u
AVxf8Xw9RQMJk0GpU5YGmt9tUwlm4AJADNnlt+RmlW8/0dDSkogDB92y03a8vDuC
8QCUqAvLVu9LvDHhC16qxeu8+h/sBILwWZQxXD0a5k8by1fwQsu8MwVeNbAeslsn
m9TRRgCqHbhoWRgauWmEwbR6VrGnLaI4adBdhFcxVHbDnZRMtSZSPChNYc1MrH36
83DfFQQoR7znmNYtI//cX0zBmwQhpr+B5MrdPbr39x0x34q+42uTtqay78lplQoH
GDRlqr/P3C8nBs5Jiqcy1pHBq9QxRhvM3auIusqcjpPSUwXwgb2sMTQuZ7ra/YRW
sc2UZICzNguSzMoGIU38MQzZ6x/wSG5EyUH/qsTfjsRv0BAyn+Mc/QCpvJERh1PF
UZX9/AYhTtltB1YHhKB3Rrcc++zdSjnjS81Rdot/nN5cmI84OVWbStLtKGOMZQ+5
ROQRaY82QmCX3PMJyih1mx20MkIZupYj2t/4NECKQ3LhGN12wfdnyNCPQV6fAIiG
JdC420Biur9pWmD1HpUTDt2rHXqu3yEYcWjdbZwXCNIzjg6VTOpnjUCxs72zGNs/
nzRUPalhEGFAOiPKaDdUenF8iPK9jZdg2P7RwXhwJldIeEsZ5Maq/+O9DBV2+RDn
5uxHHkTxbaz+jIgsU9vQBJGl4xqHNdcapa3eIUeKfz+QSLjrGBW6/S5HvI61fZEE
pBI5BWMXacfb+fBRaucEyUIijn1HscZkGDxq8WAXBIQ+p7Unhx3MGS8rdm236L2c
+C1H2agNLh3txTnYx+2AZUpwGzEDcfc1eTT05oy3G7IGwjYrOpF9cNJ7ZwzXFlBh
v4anBjeMRsgO4o4TpesAJWX5jwW9/z1uYzmEJpxqaB+RfP2csWHkzfU5nA4GLY1q
6Q+2lyKfsZY5y8xozk4kPxOBXSqLRkQrr7ZwPJLpcqKU2sudu8gIUt7Bpg+YdQgU
AbnUfOzeini6+IA67pb0C955TQrwRNjw2wEihqpSXGFiWJgx6r2LaDUEarE5sOs0
xStRf+xngyw00QScCbfQVTMjYtGrOFMVi0EptsGhTYSBJ7AtaN7YvsXeTEFdTmpI
dLkTyFXzUTJySOIrY+WJd2WwKvZFt95X69IQL0kGO7mjtD/Q8pyk7o6yO6DuW/+l
CJezpzipjc/Mpe3vW4ERA8AjNL5xTd2f6tEI4Qed3CCXUO4KJec2URGN4a64T5qE
LQPdt14i1gbVhomc/+7V4jyJALf+/YoLfySCo3NAJ36oI81nGWU5Y0/zRDvxZvto
PDQ2Q8gvp2Biw5n69FMy8fOiGuaOfHT1bylTMM9GGWK7f7aQTMYK34P2wMAr7v6Z
IdeqRBWpt0EFvdg06YON2+UbJpw9EAvIFVJtkT+Q/98v+yeusH5oyVbsX6PRQ814
yTudl5cxAcgpv3EmNibd9b5KGjdeeVE2pgYl/Epa5o/cWBpvOvYX5b6VJ5QFLMiY
cl3lfJeo5k/FrdID7LLrBHXb5pdRMbqwUSZd6iBnkzZyDAgzg+aZw/YGqgYcy+x4
8itCHpCsLTB+4HB+jtndFsLbuCqYgnDlWuv8mZN79lnHAkm0t3vrFF97a9gNjdYS
4qSEMVQNbeQ9HlZX57WYf8ecPmghzH56gn6JQFC1yHmVSTa2dUaE4Oe1S5/iuZss
Hmvu8CbdJzysJpR5CneV3eda8/FQohLYT8Rw3vb/LECWyG+VkWpbfaBRwwSo5aa1
kid80PLeCdLtufDid+HbuknxdnxGVELowoFE/VVr+QL3KjylsF+2Py3mv3rDDEWW
OFviJsVbQwf2g6dK4G4wyZNMmp55/FJbTTYbIwYJspUdofjpHJ8wltW1JqIBS86D
QgLkjeL192lqBcxFYKkJKA2SoqkS69zd8qFoll6YspkxSEK90e8PK5Ia0Eo+uW0m
VIklBj90YGM9Y3kSQJ09w0MOiZsv9RgznxJKdETq4J0pM6803Y1t5rpceKlALpcB
uhfAjRWxBg/DhS5iVGBNAosUoC+Y/P4+ZBzFa2ysCeAI2Gno3Thclr49GRJtWas/
RbZrVbjixw9BXOBgBgWdU1Alf4jEi/pOtLVDtHQ6gbsdUbll2iZceBZeG8xAs2Sq
XXb2N5A6qQboHeQlaFcO0LYp5eXIuh95YG3hiBm4RxoOq9MPdPvryK++giznMSIP
ji/hurYwGq+QagjqeItY89HXjJdXk4+mmP8vWqJZxQvyajrZwrpEItRz8WzdX3zH
2OTm6vvRCpyt9PSy/t8IzLo1fx8m5Fr1yXer0w8+U5dQFyhfv6C51KrHFFp6r904
1AHT3Z5N0OwtN1gXMwBIhmsO+QrTYmn7VTWSuwvT4UYnCaYvEf6+QqKP5+JA7CEl
syEEPb1TNMBT3HEUyWfpKdYjr/Xs/T9uQk9fFXvdEDZdKfNfUYZmOdwknLFa6gcJ
L/GpPC/HY3LBNl6owiUrSXptylJ/Hq1MplgMwnt2U6mgtIPjB7K6K3x3JBOTweGb
QW8lOh0/EETO1w5M6nPIEkZPbfDxMsoVF8N08+dn9Wb3aG1D+eQSv/BLE3ko8HR4
G1Rs8xJBvPYXQiDs8X5cRi8yQEf09MWw+K6ENFwi2qUdWQ/DEwtVxu+20/O/k1PJ
QArWtjrnki74vLFIGM7zmEv/nwhSqArSyvonbCtAWptEBpPBiL2md872m7auWsQJ
idgvMnwPQ9QrvbXMKqK1ZnaATHAyXZEINbKsGMQ2PNpRRXnw73Q4Y8gArlRnKTXV
nEW0e1E7S1Co0LYxuLCl0DedEDse0UwrSqTEXKspYKuY1eQ6pgaR733PN4GxjkmB
2VJ4ekywKF/gI6aDNU8Tl1zbBebEc9jg5LLs37mqonEdWj4S0ZG3duburnGbIavt
Y38aqluzgri/4fJYKJYfJQGk6TfN4grzfLntgZmxWx1c3acZygPRzbyV9OVkxw8A
JQN7qA1kG9w6Mnc+UuMgGEfx2g4BXaTPULc9ve18c1TOy4XLaEtuf2REGPT3nMbI
Cn/llehg1CqkDYgO8dmfzun6d1mAdXsOjQcWfQGOFtRqBfIhnSeQQH2YqnpeYLFf
rkty968P0RxCNpCSKvTxX4RhlGkACJa5c/9eqjIeJxmU9EAcJoO+/11jYzIDXtnI
oECoaK9u/fr2oAovJ+zFRc+Pv3i00FKUSsNRnnjwWcBzWIeu6Y6dBk3ex3dolDPw
/zzw9OrOBmkS4aCVnPKDytMeQykRNcMd4JE3PlJ512J9Ue4PGId43zTmgcc88WCn
09ZGe2x0qYDjfJEb5EqSDUFwN3u39MTY5lj/xmgKmPfOmJuT4FqLY1AbN/Diit+v
JDKnZVq6RvWw1yxGD3qFLh5bLSSrDJXIYNUbAtgm4Wkk+hR+DWlEJCDyf9IYfcn9
nrQEFwDNH0Yz/Nz9nI6VLyC55vrFpSinZuObm8jxaZPnBcKSTHcy/REImeggY1bi
3QyRq/Arm9lnTrdK4sp0OU+JpO4Sku9tLwJOn1CCj4vgsnKX/KylWSW4L6846cE7
/LI0CFzGO0EHoA5GzzTFj7YGi7vN8vIdVfFp9G4rvbNwIeEEAj+TkmUFm5vGcHUT
e25h4P4OyYffSmOZSxyPhp4mYXnvAzSop7j9kdF6qtHLaCihkTqLnqXwrf1/6kYa
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
gaiJd+E5ia755CtSmJhe2w==
`pragma protect end_protected

`endif //  `ifndef GUARD_SVT_AHB_MASTER_VMM_SV
  

  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lUJqlcW4qZrswh+X5GIk+2+2HSHsfeX0sAkpIUV5UDquWULI015gav7wyz5AU6kO
QXSS4KCLl+BBQkBlZH6bq8j0dlvOyT2Rht7+nDGii/ap8O2tLt3bqrcZS5Jh6d8d
HjjZS4VmkWB62XTljPXzRfEhcnG/UdlRr/NkdWdWgg4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11852     )
MvOyiGiSJqZubWbmKA5gqZDTLYe+CWcz+H2U14enen7Y+22ImLXHp7pMDNYPllms
w/mUJSE1RwVdKzlE1uqTRn6eT9mJlGpp4BljuxzlIcZXp1d3+M5BWQ25pdtgJDR4
`pragma protect end_protected
