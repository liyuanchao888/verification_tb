
`ifndef GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class extends the svt_mem_system_backdoor class to provide AMBA specific
 * functionality for the following operations:
 *  - peek_base()
 *  - poke_base()
 *  .
 */
class svt_amba_mem_system_backdoor extends svt_mem_system_backdoor;

`ifndef SVT_MEM_SYSTEM_BACKDOOR_ENABLE_FACTORY

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param log||reporter Used to report messages.
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log, string name = "");
`else
  extern function new(`SVT_XVM(report_object) reporter, string name = "");
`endif

`else

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_amba_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   * @param log||reporter Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_amba_mem_system_backdoor)
  `svt_data_member_end(svt_amba_mem_system_backdoor)
`endif

`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * The modes argument is utilized by AMBA components to provide meta-data
   * associated with the peek access.  The following bits are used:
   *   - modes[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *   - modes[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   *   .
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Meta-data associated with this access
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);

endclass: svt_amba_mem_system_backdoor
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Oonv+3XBdHEkue/t0Acoq2ydYZ0naVQTViXmEkaKKD5JtBzgk7I8lDcwgd/MgA78
Wm8PN0LiKFywtzZtLIkd9ZTqvKVe3HvlwHwnRqSX4n8r7aOs1Q7VkBtXlIJYut++
1wvC8Cg7NGOuWTWqOxlbsHZJi0AMW0yCnJilexFxYc8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 870       )
HHkLca9SkHYObImeOrXTvIgopse5ZjgDlRu8CNJDW9jJRf/bALNXDTl742K+5UUB
OzTfXozklpcYj97dQ5N+FfS2JBLBUZ3yB4oT0e5ZSpTmfZoN0TFTsYs3CF5ZlrSd
PexA0ThXtosg4b7zYJGRQoayr+YU6d18sNmyKxhXWe9UaYddRMr3IQAqMPA2ui4j
FO64FGzSRnfkLy8PmTnuLsFtTeBT+z5DYIgwJAyAcqpWz/V0T8QQn9tU1MgFNS9c
BD0UXwyASK3CdqhKliJzMx6Anfnxg4DpO5PHT9At6ic17SMnS2d7od0L+LhazKHo
qFIlnepD6dZSaQtAJudGvlamaUUy/s6WasUlq9eAv79kWB0xZYwJhlWg2A5k290i
o3ugSrZ2tPG4M2UHwEy24IrMTIGY6xEcGvQuM0sEG/QZYAQ/EwsMNeT71n+MJMp9
n+q7aSwkzktcHcFH0shtHZzYdGsFiAqBu4nPmiFi3bF9I6ZSa/OWuxYhVe83lwr9
I/IjZEuGya9g90vz54mc5BTJ/6cKBlfsZgDxsyZAfWUg6uFl7QRAzHxKQKWpweuc
5SIzv9uk9VFtPkmFGZMqk9sJF1WEPbskaCqazVUyMs3tLDLjlTo+O/xdaY5VPAf9
CO3zs7sGrIfvmXzxv5wYPQec5PRKWtHSD7dPvfOByrSkkELvgnHCgosapUU4EfaD
HYe7ZghJOc1wqjwl8asBu7/BIFlvBvfX8j4YFILVnefzefk0ZkftfipBJ/Wj1BId
va+1Rc5VM2TvNfwFAkVfOvXwOhhwV5mA1gn9n7RELni/gac0E4L+8AfkHRumeIS5
KJ6INVAcw3Py9iylaIKginGKcOCq2AfIwBPxInhZRQSdStfBfALWrhdpq61oNwCA
LwIKc500t3PWvzLbyTbgSMAmoATw/0XIccduivZ7MGDASLjbdRJMx5eTyJc5yw7V
6P5O6u+R0Um24NreEgmTVMooDvNT/vlnYrLqbDfPCIc6QWKIb+xQuxw0+dj5Lm7T
f91VOxiB/uVTr6ggTTcmGcRgyw3aydPH9kKLdX9sic8Qt/4aqSe79INfLNgKD4Zp
ml63IvJmW7Yxxli6fViwXdikH5wyEToDv46zmQsCtPJzQ/RwbL2Ghdr+H+yrg+/w
upasc2zeIEmPmAzOWpfU9Q==
`pragma protect end_protected

//------------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QUQ/wmtW1lP1zY7Jomccwe050NvoyIKjLOztoBj7R0egK+k+UdolENsYt82eTqE0
fyQ6NzQpqMVIzo+U6HWKzJ3Ztma9SVGnZW5fcXwD5UzdMJOLBhYrhJ2OCl/smJEV
xx3987p+q9ZhQXr3Tl5lh5cGRF+pvPKik91eAiQ6aTA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7802      )
pUEuWxpCVmq++DnlCqEB6lpiY3KUdNwJ4kD/mtwpCOQqMoSjRtTpk2vcLYqq7J7N
BQATtOOPusiWNCUmbN3qJ4Td45vkmwUzfx/rXG+a09OuTf2trSF+2mOaPKd4+nYr
NvY1zw3tL3vJWf9ceScLeHEOAPkaItfuRFDSQ27lhxAg03ItzwnOA3rALn64UL/S
vly5vQc+xRHYp+l9mv2G3zRkjLW4vRWlm6cn2zPowvJ8hkzMWQ/ET0guU26cAEIO
1ZzGf4MZWo5GkDN5S7uc6oyhuZseLCYGp8EZnMP88+ft2S+iqmINvla8O3qzDrnm
qsDqVNFV/hazSATekH+uN5is+ySL1NeDiO/HAszORW/YAAACop21gOiHuCDNb25x
zAw69kJUgW6tQU778aEjJ7IqVstvXPi9YTTBN0A5opTfemXL4eZmvH2oqPKXKy9+
MeEEBhR5nxoqkw+evtthgIQWxA0xcHo0eY10pxTu1QeMLpRIkSsvChv4C/0Uvb4u
reBly4/VO8OdCvXgLyYYHRuqOD4diGFYHOdXtfApcjf8CfVkj42LrZez+t+wuELw
F4f/bCXOuVc2RJaY5dRF4fV5j2hnz7/JDlGIkh75ypHPdgDBjURB1Ez3wyNowqVV
7y4iu1Te3h03jmM+V7dSvRdpZCp7RKt/9HZYSimS1v+LnZjeRW59Fhz5X3/zxY0R
O38jOMlBsI6rAMt0S4GuNHgrOkxZASAiH9oUhFxg9qBMeODpsKEopcKkt4bZ1RRJ
kc1syoLDKPb3omtpoSJsy0nqoUAupmN8U3QaTT8vUtrvnyCL42ajFr/U8Hpg+wcQ
yDqqnQnCPhkLn2McTTK0potrEQb3c4ypDliwfanhy73bvp/PlmXEmBt6peoED+Tl
sbLK757MoQU5c6k5gjAiVnK9i2iDHgGBUhaTXNnlebr0FLV8R0DdoP36iLb8oxWm
TZWiSE6uRmFrkHnyXf+Vz3z0RTE41YTOm2sCtBNzfBKeC3kjLYFq9tmEaxNpXRB6
GEKEOuE/cWXllKvrKArM1TygxdlImxkrsPCgbQVpOXNigudaNCiDwgbFTpPRnlgy
9aN7SgJAiKau8PYPTFBh9irC4VnbnKkz6cqVImc94K6wz7/LRADUp2WRBDziEOne
yq/eWcO9V/F9iBkw46Jgwxn21hgs/xusTPIgknGZdKMTwugtGUAa/43iN4SCR8n/
l4iNZNF0eM64vpA73jFyu9S/zRDZk7LwoW7lyO/fdZkg2bB2WXrObQXeYQ1jsyEc
K5YRSu/HBdTI3Tz4i3qBHllJ6hg/n5v1fsXtf0lBhvxqN5JS22Qs/ZdO6G68UqGi
WCw2k+1DcWaAXFfhLk6t2cMPSP93HprYSVvoKyRjr2k48+/5sCpp1iQTlmbq3mt8
sMjKYVM6sAxACBipVt8Xq88vuwDcx4RUTePE0GpqVfHtHFGbZrCAEIU8n8HidnhE
lmPXiytHEV49HCSxlM1NNM0cRAiWmd41zrXsmlVmEgzQwt3TU6qDz/7kC9i0X8E8
3sl48+6oYgx2sWpLoMEkALkVGLqX+hF4ZEKbldyHb0fLJ/HzR6EoimswEIV5Mgbu
leRNROoTpQF+VHhRf5OIYI175lIA30Do2xnqmezS0yJsfOooSvpvDAUqxSWCtkGi
rD8iVnXPS0r8SFaUuZlKnKMI4YLHaGyOEAbIBHZsK3aXONj4aas4Q73ZvNjSfe4p
I2ZlGHC1yfG/8h03RS6I0yY57OtpJmSYKa0W13RN9KXHPA5FfWomuVtU1wioimg1
4weVdzZ/d9Of2bJqWG3aNTDkHJiWoYTWV7nLXjRmCXBCMe+j7yWdRgD4rpiuZUZ2
Ztni00/h7AN0s9RQH4lQAjM8pWv36GV9U09n0STjaQVKky9ldsVLUeA9VPMeyPhE
QQqCjebme0efoOdwkfPkHEtKJfgsKzoDPl8kprIECR59KBNEoChD2yGVacAkNoQM
STtlrjvsaRBZq7fadM2zI8973+xB/pdTfoDgv9QP8N/57jmaw7JX3D3hxkNBWUtO
N3bjuNJ87fiXw0Mu6oNX176vpAo70kOhTzVpo0Sx/VfqQMwU1g1N/5iTVPXW0RZ2
i6raIa8kxYvWGJCoo3Qox+DqfgUpvqV/dM7RFvD4xd1gvrvVpgo3oepFmjVIp0BT
MDM3LA3VvAXXdIDlLYmjMpH3ZavOjc3d4FXxtdvYnH+8Ys0BWu+7wAT3Q8auRsFS
AobgkxedabHjws6opvS/pNN8eMwwWjyc7jDUjCerQ7cWizZ0u3UPXCBrMKoalqcx
rfypY0Tv873ffaB2s3JF1mdFEC6+nTibafbkT6lc5BVCr5KxSnkVLSicrlwtaxxd
P5EsnnHoMASDnr0pZvPlEhe6EYDr670PqeVkx0y40/M0i6T5b0fFi4nE9u83EKNa
cfMTHuQsOYYra/zQ5VVIs7FgX5seo9jNXWQHk218WVKFQnvAjtdP3f7cahSST/a4
QLng4RivdXXMpN998Q7/rEKFvsAljEk0lXWQxzRbPRTdCgyPOfEnB+sGLqMJY8RW
SS5CmYo5ztYkrrKhZVWtHlD1rX6PxxbZ4n6QOAaZ2h++gXGcBgbyje1CtotLlcha
tNnSMEdIOqJ+bXhohxvZexq9/LA4797HL8ZoZ473sH4KYjxFlhwWB/2z4JUbiWo3
MGcHuRLS0e7pE0LUMnGFekwY3/OBwGnnCKrl2efc35Ru3YWe+r5u+sUieWgta5E7
/pXt6+DoRT9Z8RT+6VkzjYgKkpRkFRFpkeW2BaKHedBX3992nLrY8jxfaY+RRNuL
UkUFyjIpFeawIDGxmeB8jD8l44T0uXxHx4vSgGMVb7pzvTP8mIa2hTUJGpZBfYdI
902TrJbrnNW9Wuaek9IUMmD6ykz7sXq2WN9SQRQxa18jvsQ9HfYLzFVQMboP5Fhd
+8pQVqE7o9UfG+JZwYZmZLND6NH5zdas4faGw02cVYSddQivxshexSPDf7OmE4HX
gcjQPLok1BD9m2vNqUN3Hr025FG19d+TWVtGt5VQXk86pIe1ya2el3sBiLay3Z4H
yBOTt6SPl3lW6c8goErHwP2F4dtaUuk1x+i2klDgxNK3e45MCW4T5Rm4d8er102+
lC914HHt89qLMUwqkE/XUi05GCiDzSBSq6a5Wcshf0hGSOHFK+QpnvOSvnH+BBZ2
WLqR38MV7l/9BQgeFINB+i2RmojO7gsq9+A1bDTRXdHPIEfVVsQfbmp8iGDH2lFL
r6enQPU7VBO/QaiFI7Lap0WyXugrQOGbjI2HH77LYQ29py3qjNUjqvymdYKgPW/3
1VRA4saDpzdj0FTs2nqd3f+PjytzG7jikutPT2PU5gj48i+Jwezm/iCEFiUggvOw
Zfrr5tUGSKA3E6wwc1UW8HwNgvjxDwzZOeT+Zz2pxe6lK9rtfgF56l25ZcT49fcj
eu+Tw2jzoHwNRuZHwg+M/5D4/MIYflJuI5mMPuQLJK6GJomzmPLQdotnOSQjWBCl
4ITRYfeoBGQJvZ2GwrhXb8QKUypPMm2DZ6hPNCRJXQWcPR8gFuFiiLdz7Zt0SfWN
uycYOR3pqyCqfPV8Uf+api4lRL5EK0HMHD/bfspIgnN2GRtBYpEtzFnYWaAKcCAV
khmtKPY9LI2a0zam7KQ/jlnajN46r0auGgUEI4m+LILar8pIn2MSHqSOgLh6oPNP
3LuDoSBZne4i3q4gC92kf6kicXBr3LE/V3senpLsPfn0wceDq2c6YUZCNIOEcN6O
BUQaEIH3KEm9xAZZbl/uVjodOenslOt1z+BYvCv22q9fKzxvmed4iCXmNlK/DEEH
RHXm9hsq+FiIe4BasLl1NsgGOkm3DVqsCnDTEsEfs2r2XdXmL2V7Vwc/O5C1I+Pn
kVkG1hNdjWkL7czc9XOtOYy2xIO0uxDHs6fATN1IG3GiPBCMl1ok946QIn5McQaH
ArP50OBKkJ+ATvyD8vF/t5knDZZ6mdf12fP0g5KiQNBsBV8KWaVKps81oLn+IQb6
zxgnD+iAcVlfqBptAyrCSVt56cmzP2R60urgVXo1zm6EJwyGPH4mVHokWodNCF09
QeHezJQBCCIzH37OTrnEIkmeeqlmvZrsXnSKnbpo8PbhXdaZN1H2RtZwn+kQnjZ9
OjUuo634xe6h5v9bUHRw+OvPLrTcDlLnRMbxWckUq53r9lpa5U6E7DJXIvnwi4sG
sQldCjzYYHXfWaIGm9tR8fWGCLGFyKou1PVjqCyOKqvJqIdzKsDmnW2vp3aPTgAQ
2c7ZiNgRgx/x08v3mg1LJ95qFBz25kHiWxjXzIoOpM43njZqBQ3FTUhmVJDxL3bl
3eYMXZMXupjHUG7oTCE3dLGi/VsMBLIGl7zn7YxpOZXdVCPCYGSenA5uzlWhwUn6
EMDeulsGGAMeClcQyRyLXOU71T+GgzOIC3HqFtyh23Vzh9+X0DkEo93AS6Lktyl2
2QRRO1x/CrI9J+th47vdrqJd/CHpusjBhcAjLadRJj5uWwXTC+mqHf78i0Wp1/11
DytlndQ3LOXRNxlymI1ut6JKFOcYEFX5n7ebTwuQf+sRsVQxo5qSYS3Tdjusoa6Y
CAWzSr4GPOcCJU/Hza0eqYaZ7vgjfYadKgQ/ToDa47bNoN0/WyRH5LCjKCzh55db
eHUX8egGWwT5H2KtLMO+vKN5QBLeGNRM3EzbThsMUgXb3fkxZ1VUV8tbWj+VslGq
UTi83p6kgYe9xyw6wYnUp81e8FJDciiVKptEdRM2tEvRHDsvHqKnMq0K3XEFfGpY
uAuWuqiLn4FxQyD6UuqKk1UNRFm8USjAsGmAq7LPGav5/Fka55PZ8zgZGyludyWS
tK1OHq9zYC2ijfOPSGyJc2z/EDBVzGa73ousbZOeeI3hctIGfhlBoKfgI9aE/s8p
TzYImNQDFvibJLGnu+W012KlmF0nPEyhXhnXlxomF6QIxOm9VeOSMWDx+Mj/wNWJ
EykmAB7tNSKV2kqfVjEToxQ0YZ0T83v0fmCjNX3AF4reHFmW8hzycubqs0O6fcsY
MggjE+6lnieEbkhmeSriLbBLGsSvYNkne/UNe+8m6HlP5cQeHdsv9qq3MQzzN8aM
YrKv3KAprAkGoqJd5LcSSiCi2jOjRUfr7dRWw9JhbwtdT6TS4PT6dIBUmBernqQJ
jrhK7Aj7+JOHyccLAUBnPRfjFmN02CXx3CroXc1xgBb/KyLuvJ7mloTZpOGl1/37
I8lCofyvbI5vEaEcYrrxAcIMNTxX+4n3nO6v/pbddS6O31+oLO/YxaYEiXtHJeew
l2bCqv8KZHYFwW1j7TgUa3HjOmU0FqEAzfqPqBZhqWIXgAgqFAoUX7rVxGiiJurv
dDy7c6jD7BazmIkBQ4TCmy7XqZmC+wKpPom2h4fHLYJMTcbw80HESmxJMiTaWcN+
APHJjoicixtA4QmI4Lqs7d0Wplz3DZIeKG5dJF3RpqmM8Ajd2Few02lQHdUyJMUo
qcUJUQDMO9K1TabNKM/5xE0TzjEFuN0CCOUxFv2gSkfE0KTbmeL15RVduAMRVmzo
crhn8lyHCbyzeZtOSrQKpTg21jwx4nSuMzREr8AWTJH+MimkPOUfxUGZ+0kno+pS
w9jcklzE2fk0/9rHZ2xzuNUbzOrIomE7+XvIjczXl3meX2JhbKSGp77d3qpVw2Ln
qsOh5XNp5YNaGa9dic/Z3I8baI1Kdo1EfwKHZIp3OTKxA9kqIvIJh/GmcCFKl6TN
C6f/I83JM/wgNq75t5oDUsJNXM7oU4a/dtU2G1DyxeCT0EKTfT+58srbAZCmjD37
4WsrbxuBzN7HhA9+isnZv6xuHcT4BzzYCl5LReJUWBft7w3iPcw03nCFzt/Pz7CL
RiP+HwePdlAC0VOLg6ncjBKbpE/OLvhwMW2hj4yHZQ9OtDBSIjR9gFecJ9FQJ93j
CDFvT8+yhrCTylMmporssoKx+51XIkSLhWnQFhjhX/yfjFn4iUgK9gI0kjG0SQl9
kO8MB7kXXUgTGGxE/x5QSjzhclZQyHAD+LZheHvmgjvOOM0hHQm3V3MukvvXBhHz
4Y4r3bctF60WX71HS5Gb2Ptrf2NGdP831r9XO3QSAyRjksMkN7qDCXiuJC6GYRr4
8SlvrNLQIZGMa5c+Fu9RJiE7qfCDWx+WIiLG0hVEg+pJm8aWTkq7R1WGnwqdDe7/
kVbkIUpQU9idG+Lg68/6jUiH/8ljJ07253UVglDTEEy7DrnTMkutabT5uQ1F1U4V
GdznfgFwngT4Q6F0J9f9LPIJ1JsNolsSkFgoCWnV477wJOoOSkJ6xSwda/r1nZ/u
FkPuJh/N1iUFS9FAzqNd2A0FvdVfDu5QqUK6/r+PQ1lcThpWwOO1UDyiAQGMoXcM
uXGfwfLOIaGF6Hx+vlzcodKk9U45m0fMe1iaTOQjCFSaT+o6ulLnljP6Vh/3zPSf
0SJy+U8VJt0M0OWVSbTBbwWoFW+BCpwJmJjIAKFl5T+E5isIt4Raoq4XM7BxyJn4
1KuIUxfrpRdJF7yoH3eCu+yC+M8hiEBoYzGzYVHhvHmOse8jnRcsRuQJ5P9MrlPt
49ayxSERJCLayO0sTyl86g8obH/J/cr1L/hmrWyu5kvl1SjwiMb06eEBko88AVBD
Cswtl8Nt9BZ7CeRzDTEnWKErbpj6Rt0aTL0Y/4nGUvdIApC9hWNX1F2J0ThylWSN
A1byAlb3Kk7thhl0gSI2E+zRYjsy9QDG3Ie/RuZrAFyTDz+eFt+Ua+BUJn2dmNCn
cfG82gOD1vEkFwmIJuLJlA/smWcj8LHPDPK8R8jRX4Mg1VQikR/copQOOWGDvpNX
ShluPkS905RFTWQWTRxNuMdFr/YWeAZJVNXNj/1GYlGLs94OigGPlAj55ZZMjaJ/
atgXzpEAnnSzLIaPbEQBtXvDV8QNKqR/gsW8UbIgo7ePZQi6USp9xJgXFrXHMxaL
K3hOzv5b5RLCm/BTqVFiqE7kp8BVV/BsAgWzsfJWzIuWa0pEydbvDYodvl64k24R
9LTz1EGv3e7Qk5/qBG5wt7GWJDmI6C1VID04prE4pIu/IuBx880thnEXPtDy+hsZ
KC7zl/tznJcX1gzKbCH+rBFiUhZQhlqB3saMncCXIpYCWQMPIgooc8vE5nbiNSse
wfzyPbpLl+LphVsq1zw7k/Bu72OvbjQn6Xgo5KoJpsQJlneOytCLHiZIXqzk0TWF
f6+BL0+wza1KUzhZRWhFTeEn4bFrh1ry3q/vx3mUUplT0Yuzk4ed546O+zmby3PI
qozYJRWVIyfoeZLF7mcnowYRnTrwYiRjkgqpFMdqxKJgSusSA6ZQ0DjFOUHSoGyR
IgDqNWJz8pwh/p2/ta03WEZlLPBOgtFsbCIFpxkdWxK4oReZharqW3MSMdOKNayK
Yuw2Pl/ot2RhwMYORMdRhKI8GMAXKW0gD4pw4EzZVzMabtBkAGYAUE+Du25njptK
IpSThpiKTaFpM5+Ko7PnlVPEdMAzUnkNI4h6aVLlrzhIDdOCr0au9W9iDMpJ1Tgd
QeocVl2eyH5HLfl/FrvjNJ1AAOy4V2RVC7e1P3sPlzvGpouDFUH41IFlLFWaxGMj
pNQa2dNjsNzVA7O/6wp50xv8RtdbYt4DP1QgYhAWwvhdYUtNVAGXhVh83CBcTKsc
zyBwS6TTDOnd9sLQ6Pv+HM2hOFBVRTH8KGuYzev3Q/HLooz9FwgsdE1xzIcy2Nnc
J7Pf5IgMCw9Nb5+q1GqL/6jib3/YU8XbjkFhbzUVTw3jWFdtBuH10pEEWnochsND
8lr4e0ocIXgd0E74EAcbs/eQpX/iN+iNonHnH9qgf2W0cdxhzXFKHEfg8XhVx3gY
95oQhw8MXki7Nb9Y0BbuFr1fOSqp/zxxbPQcSFmoH0k9kO20LdCAI0WBfLKYGKFK
0q1GkCxhrfyCPrkbShDY/Opi9+EzmlmM5CJXbCA7c+YgC7epKM2CHA/KM7Wnv71s
+Ml3nVO8Qf6BmbaaaocTvjfl6eH5wbCViSqx0eF82gFBDqaooUtCaBDvwYXLamEx
UlsU3UnohIrZdpBXHMn6r7gA7MVWXV84lTvsuE1P57q7tzyFTGU+4qxM/NHFIR9g
YAxEHrSYM7reaHArQ/ARnpA+/sr9yxJwGF0A/K5VyoIRZ/fwpAfOSLx/zZgWAUQx
SspP7Vgt1+JZuW/f1nUZiybQmUP0qzTOA7oebUgelmFHu49K8JG2dMPAnyZOk667
quq8aG+0HcxBduTwIPnC6I0JhGN48w44AmzY49wKiYr0tfjCI5PsgtIAXtP3Wb9/
60/7LoOMst9E0VidJncwKCJKmqpInl6zqvaSO4zObsuT6o1tm1Ah9akTIOlnpO+M
tNy/D38/HA5arDp28AnLAqucB9tsbGAZMnZlmW1I+U2cMJNIdc+jOYK44GfU9Rme
0K8PjIZ3ZXpYf/VB2xuJlooreCMwusteGXQ0XCRnitQUwTTQISUvoLF9dag0VB9F
9To90xs2/0S3PJpUVYjP+34eK5egUwQUYPeJRABlSA6XunygxoPdIdyWo/6NcxaH
I2jgGYdhgBnmGPMXelxEj5B0v8u1ySYaVIiEB5A8qRjwbthKgCxVBlcQAWrAZj4/
TvytNmMjg3ssBEC3EWV13fW9AnQedgOAsA4yuzKSHPb7GDuZ6PsNoNfu/oP+5J9T
yeetBerXBNmi10zjzTfybw1Ij+vyIcjhzXQGGNIk2kZx5FWuWJfxFlTmnlNCWgH5
DqCDJGZQzbGSR/2pSdTja6eisCjeO/4lFiLp9fPJAb/MfJNjXC5u5JO0r9qrAIko
A/GZu0MIexeU0p5XbsmUoHhm2HPJmn97sCdUB6lJKePM7OK/9N1RKAClwlkJZnfk
2Abqi8+wjm1fG91RAYoIynLRtjkXQvmcTVHPKaTHBu6QTucMQohL//LzHhGe2qIS
+Nu7knu9eBl4a4jJDNIVjOZP7mTWzuXaB9MnosoItFrcHzbR13K1oceOVU+qbyiV
yK2bEVDclakcqwjWeyZWCCBbyhA3J4Pr0N3aJLGP+0POF9VzPajX732cl0D6Zrwp
o0gcLCQSsilk+lfsXt2tAnOmtA/S5BR7K1Xa5UsbGh3rjq+xZh3QWypPIQTPDl9g
fQ9rKenY1P1jkGDsEaRpZrN0t29XiYfL27PWO6zLL6oh4DH1IQ5JHgGwP/Ww7Plu
X8ULXVBBr7Q2qFJBkv4pWanrehaoPxxzshndajbzqVk=
`pragma protect end_protected

`endif // GUARD_SVT_AMBA_MEM_SYSTEM_BACKDOOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V6P3MAI56X7CqScILp3XVh/iF2WL8UiL8lfbiKsAUMvv6J6N/QdEr50TbQ5T9gN9
WHUuqhSQ/ORKLA6SALoYO0Wh7y+bldSZwnzh8BXL7bIuSx5nacdDRdbwQ470KONE
uWKYEJ6yOy2S5uwAlQNICxYlWPbNIFHDj32OitKA+VE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7885      )
qjHnY5mliszRrrgjHTwm5aW6PCeCLOdNYTZ4MYL8yhoH5f+aeU4I+s9Ie8L5pNs6
6l83+5aUM9PmTTqOW+GleKx0gpiHBr+hAH1QSq0sMKOCnTzo7pV5adiv53pCc9QP
`pragma protect end_protected
