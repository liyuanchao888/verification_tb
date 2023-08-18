
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OgLdrwdgCMcGAFD51hmo4RzMxB7stQz+SQWfcnhBP+ZqiPXSf+qMAw3w55Z5KURV
zudmfnZ0z6bkK6ynUKWqvQ5hdc6hKl0qh+luQicehFXs+9sUos06RqK05ecm5LBA
vWWOCBsphiCia8hCHt1jgBORbYvaVfcCc68B/Rsx6lIMuKyWQeOF/A==
//pragma protect end_key_block
//pragma protect digest_block
jGegxjhL4VJcRvoaQtd500X+v7I=
//pragma protect end_digest_block
//pragma protect data_block
t911sA3nA+SKKdHHS9rueTixnONZGf6cJPJ1vCKBtU/cY2LTjnsS79BYT8gAaPAm
1vj+wyFt/AaNaEB84wPY492YWtsnopdhZz00R5Z+sy72S+DzjhWkHOlzj5U6Sk6O
YXU1Dy7P7OoC8N4GAgbRlEN0JpF3m2KpCK24ZQJxHFyBU0PQNrr+Atd+Vry26xwa
oQDfa1aLQtUw3KixpQPRcxN1tmfCHowo+NL1ymIojR+aC8Zunr1P/mZ+29whktoF
R95YHhtaV4c4kxBdrsYUEyxnr50EYZI10cgEY7b9hv8z5buhxtFEEj5vXpPEdJJY
R0qU1Ju2lUetwLX/Pdf3fMLfyzuDnCsuVNFeXBKKK5W+YUTTjavvJNDeil/KOgmQ
mLYRA/ddQsV4O9dPL0w88y8azt7blSrxQAaI8pq90vjfVtmBmnOOwxV4OpZVQsTs
7UL8uQn+33lvyXfZVGubC3US2FNp0j1GTD3aVOLxMXLoPDLR31+n9nuJXEc6TFZe
vg1DJRpjxwPxzFkC92a9AG2VF+HoH/ofoSWQyJnotYzGkBnt6Es8/jAn6s29dNTz
5I62sWH6W9bfm2YVgyarC2NDIa5eY5xX6/bnepxfwi2ZrFsAEOToCgiX6MOeUPlX
CJHrXlKA39N9XUtkqGp7VoyxDwmEsdJbst9+LLKD5iCpTn9wQlK2cI2D+HJEiMi4
r3lWngA2d7Rs+obwvozmQRzoh63z7S1XtfUs9reXZNo=
//pragma protect end_data_block
//pragma protect digest_block
4c37110iniXSConTYUWWLIz5CvA=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
b9AU9kBqDEGi3vBvsdc6rJp/O7q6sSWJZRjqDmMsytS7HtWL/OMTjYfAryS88TFf
e2kQQmIS3z90ezVoHPhju2tVeHtfnspQHiMM3mxzIF+UiliWGLTjo4NFnuftQZNm
pFkwAlpOhgay4nhYZiGiqIpXqYJc4/9wn8wgjRqaLvTDIJK+33NMfg==
//pragma protect end_key_block
//pragma protect digest_block
rhp6cJ36/nJ2r5oScdXtWKSuw7c=
//pragma protect end_digest_block
//pragma protect data_block
bKyU9SwGfOzEUMYSXWWo4y2mGrbPlNbNTTb+dlurZ5ZQ39Sy3eEox+KeY73I87MC
gQpL1YtJc2vicqksa3JIe87KhsUWH2Qx7zrePWxat46cETDqx8u5RHMRHyQtCMaK
zfDLE6ElXJ9jkJYKbR/jDWmbjFS3ni/bU7xh2wFL5Go7dGhWKzjF778HpEq4Nmy/
wLV6Ig8UHtMR8aQKwcQGHbI775n6l9mJrk0849p4dic3KyYAfagd5RyRG4Vrw2zH
4qkFj5dkcaL1q3iyjuqzH6CqZgxj8PERxqBgYOPYhD+iKjof6BEIBClTQnCAUCdN
dV+pFOFZcw3qTcRvPVTZsVPbWMrucMLu2J6csjedKCVFn04xtq9vsqkv+XeH3096
ImuZxk5hHAgCexjNYf/yuEpW5jluS6q3rmW+jgasdBw6XPfej3ivvSBbt1fsY9Id
PCMhJlI87j0Sugw8RznXvYvj+Zbg3J2IrSNH0tgT4AIy7CcJpLH8SeMwtQvxxibG

//pragma protect end_data_block
//pragma protect digest_block
xBARiiiLjJlg9Nm3eBV07OdOJfU=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of ARBITER components */
  protected svt_ahb_arbiter_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_bus_configuration cfg;

  /** Transaction counter */
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lCSROvS/yOcId3kmpHHyj2r9S3v6MTK8Cu+HkB88QpcHOY/PrkwfeDfziUerNc7B
rXIc6/KDUfJ93HR71j1L0Ybd3gvTTX2oFMHbtLkiJ4s2KFm/iAS2iKLxGlaSEiNI
bhk7o2MeH2C9LUSPq5jqsXhEzD+mjxot/JXkWZ45nV604SX9MYT6jg==
//pragma protect end_key_block
//pragma protect digest_block
RTEJt2uDXTeGc4piC2o2Buq9C+A=
//pragma protect end_digest_block
//pragma protect data_block
uQcLnGvVVeIh++Q76KDOF5rQ21wmrFPP8DCwT5fpGjnuWSXlTx5hGaVG9Cp7STB1
IXal2zZzzkdQF+ibZD3nSe8WG+fN4WYDszLx2XkUJKNnl6faxNHq4zZiqT1289xG
6ygeTg086BtlFm988sS7L3P85C6BuuGJGE8aylWOoJIlskcnt6tEMYAlZPYjhOfJ
ka70liv3NbxT4f7v83Uzh2Xy42eTJChAsg8BeT/vNuk3cIvtb75BMJH0M1QEhJW/
4WpRoQzort2v5WNv2lPqEajrUC6xNl2YpFjQ8Rh9WmIFsAodtP5yq2kbgjrBb7+g
ntZky5Hp9vvUlRrgoouD+uOillP3x1qKOIpzZaAD1I+FSU/iObnHIra0G+Fy8LzC
OQgkJNDYZGqLBfcsst5ll57dAD4r3ZESSr5ImE9gP/R17Y0tOG9fgU4DaFbIGdNn

//pragma protect end_data_block
//pragma protect digest_block
XBj0uyMpdFE04zatT5ctNxdUsD0=
//pragma protect end_digest_block
//pragma protect end_protected
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_arbiter)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------


  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_arbiter_common common);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AAMFSjkFVqVOd7t10n9DVlTnFO5znxmqa7osgWwZ++DcB7oCEjEPKl5mZu8gzLhs
9nrSrGPPhCD6YlcPjIvEGfIqaiyhFIRBe24HNCUqZKHK3Yu5NvzDZknP8EzfVJ2h
B48576dVFfcTpvvgL5EgXe+rGjtYFYk5G6+JuVCmifAgtfaoqoc2Mw==
//pragma protect end_key_block
//pragma protect digest_block
rxrKYEgyr+sSryBKIeTOJ7Qtt7I=
//pragma protect end_digest_block
//pragma protect data_block
V772kdjkL6KQKQ1KFX/RbuZmszfrreD0DOjWp8h8h7+0b4ztni6wZmsSGcs5EgKr
xLCl/mMxU8tPEnPMk2mrzA6+g8Y1CTuIH5KJgT3LKkZqLn+K6Qv7gsAQXamY1N7R
z5fCeMebNhZlGfBSH2lUm1IeTXra5YyRVOIddXNvlITypT/MCcvOCTRNEQEgNewU
I3V3uyF7Pzie2qt8E6JepAfc/A4aspRUtR3jBYdSliJgDBER88VV5IfRKm+4Gxj4
/yIOctQ6LBeQ4yznorwoCu+7OdBw0wcJjkpGS3yAsXR1zX24AclD0sxpHvf4CYU2
2LsOXsKxrH40TvvJrLFa32wdKvM/4aKyTUCe0sI92NDRSKQaIj54pqXg7kUA8Mg8

//pragma protect end_data_block
//pragma protect digest_block
T0zvEfbQZ1jXm0cIC6UpasLuCAg=
//pragma protect end_digest_block
//pragma protect end_protected

/** @endcond */

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
M3eQ4p6UfcvXmhNRA6RqxpfBEKKEsfgZe8S8f9wmT9oa8HN+DgZjutaOkzuGjsMm
phtV1DLl6dQwXKhXnthZpCpUOF1zXZnRtpcRUbTypJ+ROA30KXo8yghUtN6+pWAT
6rPV+4lnrPLfXpcGPHeLkSAoIQlaiDR3CJL7OCL91kw3OOjq0C6FNg==
//pragma protect end_key_block
//pragma protect digest_block
KmAaohEh1laVNOJRUDpHcfq4JGE=
//pragma protect end_digest_block
//pragma protect data_block
0gmeb8QKhkmvfMeKxDzV6RQgqn4kBlqx28yB+/yhLEwNDobEQHczrw7jEGBWGemj
uSUKkUt+llV/m9lpgvhd23QtPv7Vb7uQS/4rY5sWb7S84LetaedTZ9n/S6mRE7sJ
mPsUqp7TfTjl8oXuc7loklv9YmZLac3RPklPyLfYol9OeyYsjpK7NEwYJnQhqsLm
KDKQ2lo3hcaG4rHDHR68Izp8DiDUlgHiZrT6BvxHsaPxhbt8J2S5c+chDhiwWURs
p+IivFdVGq3HM+79aXmO1fOL1wTWJjV9thOpdAgFvFJa0IylnRLmPgkGGj1s1Yqq
C8t6MvKCBFuUC+zi07GOnDxdHJPdUJ3956cY64CnyvOQtviCSMdXxLfuEyab/ANv
usXZxlR1PhVMAKDiRQ9s73lXCYhfCt6FOUrZl9sihInyFESOXuVsIs/p7MhbyAHa
vBrKb2xdZYqvCDQTPgTOt42r8cwu6VompEfnFF2C8YyK7O44TQj6zvonzE53wNHW
Mhv2OGgRCfjwVRAxNzmUmlRa3RsfF4YgIIOcSzsIfgXylv0muX/OiuEyjdIrjIQ+
FQ44QX1y7TiLFYzPLiCz7Pxvjn/TcA8oHXgUA3+sJC7r00IDdcYvH3D9zsn2++aj
efWpVNwaH+JX81eD7NRdnujRfu/9bjeAsd62oXub3wF+swgw3W0zW878qDtc/FaX
icBIVx+CPHBN/qeZcqpCN6BmRLqd+zaC9A/tba7ufaJIkXY2iNo0Hnf3SOdZMYQk
GRLyH+5agxY9sNb8JTPmZUM2VQC0HnbFMhLZUdDscorDB+PDmGPKqMJFE2BLRkrM
l0FHjrgl39Bl5OGq/xP5Lw==
//pragma protect end_data_block
//pragma protect digest_block
C9NbPv1hnm/NE/fLDmcWIi7JseA=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wMpkVdx50dAcrvyQG5zuS73mCe8nxcQsYKlVry5+RVifJp79kbCyvWEHzD8RDhpl
oDeclr+SRXxO2bvRyIKe/pgzSsLqboJZUMpBt/6TKP7v0SkV2nDidgW1tU1p38Gb
4EkSS3j+yg3mPizfwfwAslJW8y6Ah63gbI0/+07AJRvBYAOt9aDanQ==
//pragma protect end_key_block
//pragma protect digest_block
PfWRVS1kXVa+vJVcxtiY6tbo+JY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
qVmVFPHiPyGSFInhrE2mXd8891s=
//pragma protect end_digest_block
//pragma protect end_protected
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SbeCugXWObusnJQLgAFxKYL0wp7/aEXWJs+FBcl2Mu5TqTcy+3qL4MuIsOr0Mro+
aZizNkFxQhoHTncdl5P85FtVoAmXWboWidS8vt3ra140BTCvXuoiKbZiNzGuj1HW
66FK/E0XCi09FKe62NsfP+dVrJmapo6E7AuvUnvpQ3wo1VRY2Xdfbw==
//pragma protect end_key_block
//pragma protect digest_block
ezpyVaqHICg++hbSbqi4gsvYYgk=
//pragma protect end_digest_block
//pragma protect data_block
qZmYc8DxmU5jaFwmIO18tQznOhgxF8HzVz8BF/iZp5+bcXC+Ly53cNiqxBLqxajq
EfKdIhe4QHUbmHprb5t/P9nXxE5p8NSCc6WCUIfl9Ovc4o0tGO2CmPt9aFmazwl4
aKBLrHxfUa8Uy7I5IPrV6+5ObK70t4X0ADMdziQVavn9JkiWJ58WpSoCbB0eU7LI
iNZQaZWOYcsSQWX168odl2gEmT8pXuYDcuHGqNFk7hruQIbfrfBvbnhllsTmXuUo
QEqeRSVIYgoSiM50OpakCo9kCESvibptvx4R0s/oSVvofpBGHA0Yhnq/vBGs076w
U5XNNsZGVPEAM3MLs1sRBvhC9oDC+qwv/aaCJjmhzSNux5UzHjaF7L9xeviJYSi+
Q9TlW/VKcjeVbFRka2qMDw==
//pragma protect end_data_block
//pragma protect digest_block
S/IOBWkRiifJIn2vqjNJ8D9cldo=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jO20+VS6q8xmQ5KS4jAz7apKzSMn6eHtTu17Sjp1x+PQQa/oNTEGn7xui1FNmA3b
5mtTJXMKQukGcOrzY2awif43ZBqsoWZAqq9M9ddiQs/hNd6vAg0y0eqST/+cYZpS
+OgarlTMkog7deGJ54zOWgXJScUKv9clFzCA/mOOA7R9qHz8WGDRXA==
//pragma protect end_key_block
//pragma protect digest_block
WO8DLVQbb3sTHAoWDdips/NCoDQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
ctNWKIsxiqvs2p6I9yBr8f7KkYc=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zpGBY2lHWJaUQ+kYlZQAizDCoOq5JhhxCYxIC6M5cfsG1bjTkNfDpR+Bl8fBtefx
kTJkMYMuZMYDpNdGR4jDgW8foe8Xs84MV/cMz5rjonIxJ5l2MAMezSVxJTIHDGEY
mnd6XC+zGt/3zCD/KSoL4dsn40eXbG0pA1J/Kt9LYDuzo/2HnNR/Jw==
//pragma protect end_key_block
//pragma protect digest_block
u7k4DkOlQjYXaY3irT/g1+fIkVk=
//pragma protect end_digest_block
//pragma protect data_block
YTODp5SGMfUsZr9cdqHDEcjDG2xJQ/AotVaIhBlXboSpOWVxsI5Ki74YlB9v4OXt
EhtDnAvALP7+IkaTmPcdMEgpDu+IjcE7eoeTpT5DkTbisNmRKzk3eAf95C/Z0MXJ
ohV3BNTwLpDR6c6I4WGz31OBY4j9Tw43FWwOId4+g6XBtB58NrRotWnHdt06pteF
hav7isNeZ77k0ApPRRO3l+N+0xJ/A5FSVHhI2K8BA/+ZJmRiw6xXiymgZsVWyNDf
rAa96M8okrwwD8h2KyNYjlxBGs/1wZzVAVeZXNst7q/cpsBDW6LUm7UQlqb4g3On
IitNZ5dpZ4G9TvH8HhMjCETf2O4R6BVEoOhu07Bal1gtVI9Qk9Ax9RZolHxpcC0Q
pMiXfpW6e2xjL9qrWgbMVw==
//pragma protect end_data_block
//pragma protect digest_block
gI712nQggKPoOQg6mBhyYVD3RiM=
//pragma protect end_digest_block
//pragma protect end_protected



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WNIq/VyqQ2pdRwnXhzKzEcuqJJ0MtBIdwC2/Woh0nYF1cm8OH57CmFRXXFbXd+A5
MTAw1uNcm3Pf3se8C04J8Y9udtEKvl632acO+bFJrB2hMe7ln/trVLa3ATycQ2XR
q7r1ptXqU5yxbN2p/5kUOMMXOVN13vUxyMf/LDrzGbkJTSQialDaLA==
//pragma protect end_key_block
//pragma protect digest_block
NDzmoikGG7IVAazH0a8n8RTN+m8=
//pragma protect end_digest_block
//pragma protect data_block
aTYgcHThUczZ/GVNZARYB4ob1Aq7THEyhckFnTbOYsQIULRstoc+fxaL08MWeHGs
LkIObw+oA7ZmGtxD2KJZy4Q1B1umJiuJSmbi+zlH9lPKrGsZnH2e8yHCkAPxjdT/
c6dRkA0u3c130k70yG7TJ5ZL4eaZ91iqXKYjysItU//kX7KvgdBDro/dfytM/9Mt
tAC2FARtajAhT+IQjmbdWW0dfYdU54p8pjRLo22eeVIzwlUst8bXUoMkZ4edP0ch
MVX1QCbip8jadCrsXqU/Ls7wdNVaVCAw48y2qI+woe0H7l5dUxp61dNTUF2d4F/e
gYw0BHUeLQGXn7U2G/ZMX6WpFqTU8Z75gAq6qpMn54QhSNKQRCFp4NSIq32Tpxnu
jcXOT+x1PeDaBTIw3TNYqduaLzwzlYG6wl8qxJWUdg15Kl3F6h9jEVfdHe5OGSVM
R8Gg/Sr9CUgDws5c5EAwEKY+alTLoVQei5sqGuq7WezdrPqmtgZ9/xQDw3fXUAI4
e9IVSgB47Ly5DbXMSVOoIg==
//pragma protect end_data_block
//pragma protect digest_block
gQvjAmpE2/6LiqBHfnbNqTdG+mE=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OvRmTJ1q2+ppl3o60okOXm8j8Xf/74lKsXgpNZDMGsW5WCs3wmnygo1USzH1EPVv
jVYm5f9SHs/SxLqUWlU/HkqnjwXqL+R3zIMHua/7Ymr6fAiY5YN6iC2YNcczUEFt
CGIGseJm7RKSExhGaqSWdTB3vU0qZNQ6u0SqibB7zr8NuBzZPygFjA==
//pragma protect end_key_block
//pragma protect digest_block
RjpVk76dr1qOBVT6VFtiqEVOzPM=
//pragma protect end_digest_block
//pragma protect data_block
xCEwfJOpJreaxKP0z3TYf0sQVhtssQAh8qBzQKdlef8uH1uCGRNYE76zosySGdy/
0kIPhlgpoMdLgID0R78RVpWyg/PZj/6s2/v2S5lm5Jo3EL96Avc1owq24FVVRCWE
VlWX15Wyip20KWvSStg+8d5Xyp4rs06JUlBop4l7fZoYus4tiecwKvuuPXX5JAag
jNw4udarfg9CpndC9L1EPp/dSA37d3lBKqnzCdjCxiNjYDMA9Qc13Jbb0Wcc1sml
CuVwlvJvCC1S9h2luZBtPaJe+y8AllQfAkUTQa4C8Su3E0ZhWAS2xMUUSVCP+Wun
X1kYRixjKY8GTIFKPQcJJSdxbAtRZ3dXJKlM6jze7ENz88JXh4gn4zexH3qqt07l
RufEpsG64mxQiDirWaF59g==
//pragma protect end_data_block
//pragma protect digest_block
npPDnMmNNbupJRlF/KegVGrAEPw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
D6bktWi1eX1X93VvPyPG7nSwuQKiaVpnMaIYo83TexN8zfECqlZz6zRPG8IfYbjU
RaW1OzhgYFAh1B8s2/jdftuGIdE3IQzhu3Q0XoZghP2LTPHL2D7Y8BNmOy8zRWBd
wuIbrWuIM5FZzYrm/2huciKJ+mBGFDcB6fMciECfKmT97MwQdB3HWg==
//pragma protect end_key_block
//pragma protect digest_block
JZu4cEnQQ0Fk2zDEzC2ctp5jIGA=
//pragma protect end_digest_block
//pragma protect data_block
99RShUSlnM0jBjUfgYFJCKypzQNznJ26F9fFwhj6/OjQkknVYvM2TGp6zfXbwH3E
yhWHi01A33c1L+PBW/P7k1ecRsyqC5saxWt4lDCcbleN+jXy1GmG6kdZ3V4dU8Tt
U6TbaGrvyViOLjwV/smjEuq9dUjJwYK/nEXcJJ4kC0EpSXZS+ASybGwWK7ueNqpa
FZOlMD/0z+ZVEcucV+Cwk9ZVqTKHggmTmo+JZeP7BT/r4q0mpcwL9uAg8V7DDhXn
gtD/VYCDwnvmK2fWIJS7ZoIKgm51ogFVphofYDSUx3TOIqHHHopnVB+UWCYXvz8k
Cgml476pfFwso115zn0EV0+nWMVZiqtIYH5cUY8wJwgMcNyk/+E+6o5r6Z/j0uMQ
l/cdZsK1Ai8ArB7sRpItxg==
//pragma protect end_data_block
//pragma protect digest_block
dNUXB5SGzx7ThCRjsYPNegHdzVg=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
g0TrXQ/9sgAvQzKqZiwKa4XhPDHbfGaH6BpKshVu4P9HkRWqsmNfRfN0GiKPETc2
PvdzNg8YhJoZt7P6+bpGpv/9aJfIToSOsFYTxeVPP5bBNkBadQQUDtPzOWehJSfR
mX7LVw06+N/EZjcEqiJ2/84YhiurPIaK6cv/bjF/+097743L/AzqFg==
//pragma protect end_key_block
//pragma protect digest_block
pjx1BO8stSoHZDTC6q5V2ucTgKI=
//pragma protect end_digest_block
//pragma protect data_block
d0Wf0rrPms5EG1ZQkhG7JIZumQPvZw4Zsu7gjqEw3RVC1gG7EN6xktt7CILIG80P
FrX4Gplo/VditlqziNVdO1pKE7cOwFlTys+H+rSTDUOqDr3eoe4n4M+ZubuKXzgo
rYCS2bJsxgZpXWfiqlYP0B6ISEW8uqt8Gkzpn4lrEpZoJdj8ERT8aFGPIHTMLrp5
VLvFIKLCjhtFD+6bjQXVMEBEwpMzsqvfokCi6wJhYPxuKP3AMBrKt2tSDTTdBbLb
i96eyEHcqvshWpLBMdmJ8fYaitzvUpqwsdE6xn3sOjr5Xt88ns7lkCchzHH8MA/i
TP6cgLQ7uMbCBdAqGKRDYrTanP4FwN8+puYgtgR9830p7EGw1YF9T6WYKBgmObUg

//pragma protect end_data_block
//pragma protect digest_block
oujsGLoP8EKLQEVXqtezfHn2Rfo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





