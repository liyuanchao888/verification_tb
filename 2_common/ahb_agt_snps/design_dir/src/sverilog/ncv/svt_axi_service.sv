
`ifndef GUARD_SVT_AXI_SERVICE_SV
`define GUARD_SVT_AXI_SERVICE_SV 

// =============================================================================
/**
 * This class is a service transaction class used for monitoring low power 
 * interface. It captures the information on low power signals during the 
 * low power entry and low power exit handshakes 
 */
class svt_axi_service extends `SVT_TRANSACTION_TYPE;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_service)
`endif

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * Enum to represent low power handshake type
   */
  typedef enum  {
    POWER_DOWN=0, 
    POWER_UP=1 
  } lp_handshake_type_enum;

  /**
   * Enum to represent low power handshake initiator
   */
  typedef enum  {
    PERIPHERAL=0, 
    CLOCK_CONTROLLER=1
  } lp_initiator_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Type of low power handshake */
  rand lp_handshake_type_enum lp_handshake_type;

  /** initiator of low power handshake */
  rand lp_initiator_type_enum lp_initiator;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CACTIVE and assertion of CSYSREQ 
    */
  real lp_entry_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_DOWN.
    * It indicates the absolute time delay between 
    * assertion of CSYSREQ and assertion of CSYSACK 
    */
  real lp_entry_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CACTIVE and deassertion of CSYSREQ 
    */
  real lp_exit_prp_active_req_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=PERIPHERAL. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_prp_req_ack_delay;

  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_req_active_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CSYSACK 
    */
  real lp_exit_ctrl_req_ack_delay;
  /**
    * This is aplicable if lp_handshake_type=POWER_UP and 
    * lp_initiator=CLOCK_CONTROLLER. 
    * It indicates the absolute time delay between 
    * deassertion of CSYSREQ and deassertion of CACTIVE 
    */
  real lp_exit_ctrl_active_ack_delay;
  
  /** 
    * This variable stores the timestamp information when 
    * CACTIVE has changed. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CACTIVE has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CACTIVE has gone high.
    */ 
  real lp_active_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSREQ is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSREQ has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSREQ has gone high. 
    */ 
  real lp_req_assertion_time;
  /** 
    * This variable stores the timestamp information when 
    * CSYSACK is asserted. If lp_handshake_type=POWER_DOWN, it indicates 
    * the time at which CSYSACK has gone low. If lp_handshake_type=POWER_UP, 
    * it indicates the time at which CSYSACK has gone high.
    */ 
  real lp_ack_assertion_time;

 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_service", "class" );
`endif

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_service");
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null);
`endif
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifndef INCA
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else

  //----------------------------------------------------------------------------
  /**
   * Extend the svt_post_do_all_do_copy method to cleanup the exception xact pointers.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function void svt_post_do_all_do_copy(`SVT_DATA_BASE_TYPE to);
`endif
`endif
  

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_axi_service)
    `svt_field_real      (lp_entry_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_entry_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_active_req_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_prp_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_active_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_req_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_exit_ctrl_active_ack_delay,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_handshake_type_enum, lp_handshake_type,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_enum     (lp_initiator_type_enum, lp_initiator,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_active_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_req_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (lp_ack_assertion_time,     `SVT_NOCOMPARE | `SVT_DEC | `SVT_ALL_ON)
 
  // ****************************************************************************

  `svt_data_member_end(svt_axi_service)
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_service)
`endif

endclass

/**
Transaction Class constructor definition
*/

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lehi0FnQ7zIkRaU6jYKhvIeuEv5/nBmtZUgQLWUCLoktIe2aL0NV6ZQVv3k5qTWK
S8E7LEu4TcM8z8sCKk4OLSSl25XJOCuu0w8JKUD3MwL4wGXfZ4mHL652ub1nfph0
6rkME9kMMY26HR3SwxLd3/g37Jw0gvnKpzbAKJuNlpdvuTjV5XDreg==
//pragma protect end_key_block
//pragma protect digest_block
IJPNyM/qdtVRKuGo/IFOpxCDI/s=
//pragma protect end_digest_block
//pragma protect data_block
xu8zm1GNBVp1l6snFjW2K4n6vxmCWf30w8CEXJF95snc1oIfuihwvHOsitVaUQ91
89eV6fHubB4/q0C8GjFZZpp3ROjBn7aEvdsqq/ZJDn3Pu5GBlTMqLaDLStYuCJfc
qdGb25PXQ3/cvheFGbALgtM2wh2WvF6+b6TF6N6o7JCQ13NUP7uMNG0+lUIHW5oB
RvkzAH1/gU6IsT7o9hswLR2Xfur4YYbzEkg+dPT0RgdP5jpKe2uqYhNNGbJkbTgu
X4IfxneJ1x9o5yhLKC9Gxa/kKVP87DtjfXaDOmAK8t33kVPp6wdRPLzVlRxK47cl
+/EuONKjkjYpQ1M7+1C9+AU+07r68PnbUjI2wYY4S0avQA7PlM7S721zEaLI5kIM
cieMzzwJcpHRq9x2jlA5164gS/IUR5QR4OztxG9cphUqm8l1mHHOBrPuOaqAjxN+
DeeKcBFbwYyE8R+PWAifSzUJ9dtWQjjxnkqE5U2/a5xuz81Aqe8USeFtvFWniPQz
ccv7ka9qWvQX9W5j6Eryp84lATBlXGSrwk17ta35d1Srhgj6ey6J1ulruYsJ9gdM
dtVAHrzE+bt3OPHGFdl725BhKdBoo9ctb+MAaQw36zZt/1eIKeD4Ryrdvt2ersd9
dLLVGfDv5EMiMbo3QF16v/uUQelJeBM0LjUBRveaE+rj8QwOEq4XTwQI5mHX1r7C
o/ap7StzR6fJa23RuBSO1dFJbBfvaxhl5TGNdgfMl06Vnj23YSbntoi4UtaM3RVC
drlIy45zydQeGyFYKaa+OGdpsmkR+6zDQVxW8vd3nIgCsVthfDwqk5ziUtnUuW03
R8ao8Lxhj/CEtew9VWLdgw5mYWBBLHGsP8LMrAVMryOLkV5cSan1UCLftvCsiVVY
WxjIkgnBRejir7tUOfAMdN3FNfkfEDVt9abubNfyey/Ma+gJudxwWO+tqHmvKAKF

//pragma protect end_data_block
//pragma protect digest_block
2a+AZ5q262rQj/9So8Lxw0W7PZI=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
 typedef vmm_channel_typed #( svt_axi_service) svt_axi_service_channel;
`endif
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
yAyUnhflQtJCMQ9UelVrAq8X88uHl5nqUL0WJemlXVdPuBeUibss/LFXPoHoch8O
/jhXEouW+7N0TDazIsbeC+O6t8+fVyHX4ifjfmnUruDGlHqPWnboqCSQc0s44UnB
EXNcyHo6SsU0bbJd15mHnXsulfNH0OEmlJn7EbwZDiIhT23JgLVxdA==
//pragma protect end_key_block
//pragma protect digest_block
F9qSw1PSXgcI7gesgbXxuOPoVoU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
hg9aSz6KdY9xZMYD61nsjYU7Zpo=
//pragma protect end_digest_block
//pragma protect end_protected
  // -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F0qXZCf9ReMzm0dh3bIDaeq2WzPTkeMvSacVaa5FMG08jmr2LJ2o7c6cfkk+a5N9
U0rU257dHbINRBl1BIig4Tk4ijBw/puaPszh6pXopccdZEl2J48L3JWCMUbSEjwy
uLDb+bwSwgwRA9Y5rzcNFnM17XOREMZjcaFIey7e6ndVD201B8NAzg==
//pragma protect end_key_block
//pragma protect digest_block
dfHWFhNl/YvSSfk6IVOUkN4gal0=
//pragma protect end_digest_block
//pragma protect data_block
knb86Al/8liDNG91LP9LNO6q72knBa1TIQJskHvRPS9vqoQNjV8GgVYzHWkVg6ce
GBszmqx2IA3KFuW3SvFAfz2EmgE0hcyKqfP6470hG7pxVV5h/1gLChZKqw1IrAl2
PBvisLko+coMM8BrKBq6h49KcGvq/lAUIgw+Vyco6iUCe2wgaIe8stNci+LLv2q2
1mPj2lqkxlYQBlJ6tGlxYEZjLjhcrz4MEndgE/T0plOyL6/B7IZIEnzFhQv2vtkd
aJjVOEW3DHi+pdlPOVdVvT4rmOgySvO20swCskjHwFzXcmLdePtmMTDHdxgQEyvg
wMoU1j9cKJhOBFQOe1Zd1eyn8UCgL7OCofdBVF4So2+2nOLpAXKRXCox1XifoVQ4
YdAKQxz/7og/MuIcXrBlHoFBTMrNTtHSoM4yrfeOn7CzXKI/ILIDDAsUQ/HwJxYW
cxDQVi1bgyCKE1sE23meQ392keEaK0Shkw5Qr4GASyg=
//pragma protect end_data_block
//pragma protect digest_block
JHPZXxJFUiSSPigVOp6mR2IthEE=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
raF9SRifwYhT4v79bTihhgYu009RBdChq25qy4eP1pxZR6/S5gGkQ0Zu6vW+23a8
8ZoSQwmxqei1IE+MHZv5KZQvNfITLu9eLZLYag9lhNCGmf1XV9ZcmxOt9r+sK/Vh
Cc/XhUCOdGKML7RJ+AGHzZGj+iSNcxcxwwDHLN+S4JFxlb87A9O0Xw==
//pragma protect end_key_block
//pragma protect digest_block
v4oXlHzAtOnOZaaOStLp97lzi3I=
//pragma protect end_digest_block
//pragma protect data_block
NTqy3uXyQBG0bRLpMVu7hNBlNCNSkijCFu5XXXxhS8xyLVHhC6D1H/hcaeqlkNdA
PZyBF8tsycVTp4Vi4wGIPBtlLIODAYirBW0m97BS+l+ZH7A59Hxf2rY1XVLrtLLT
xcLjQK9PAYS6opHOSkRZt6oHwc9ljf6QssnICN4cMkomqKoPYyeRUwyMpK5bqskl
/3FxikY2/qgrbBz7Oa5SJ2syonlWcOdKnKgncRz5hEgIVDTgpzlgziAaRBScUZEv
jSjn2dznq6tDOmTuGn4dLRi4fLm7bV6DqQCHa4cVbGMHI2DOaj0LcEHhWezIMO26
UwoAOKDS2vkBflBxT68hI42VuZRYfg3XqKF/A1fNUsxOvm51wXiA2SodeX0Byo38
DFamEg8RAFnRIL1GafugB1fdjeA1EagwPS0Iu92PL6k0J/q1SVXm3LHsMbh5hh6v
7my3PhaPvfyibjmGo0nrE9D5tnnirdtA2aq1yik5V47g+t6zGX4uzCrcxyGGiqKv
RCcq7fzkD2cu+fjpnvQQ4HQkvo+juaH5CTmBirm7hZRjX8VxsqejtHjlNtxzkUT3
T99YOXEGT6A/ED5429mQNUo703+wjB+l8VGPuNKOCrWeswOE3mnfkLwy/VfReD8i
1JUx2WoWyfWPT0sypR+TyEr7mIPW+aoN9y5P8EXTS9qeXjEFR+U/rGU2i5pXO2no
kR4394QnU8swqS4aRfq+075blxjUOwNHgF/nsRsls5E1mtiTNoMH3n7ayfU/kXUd
f4V+yc5PsXlzaUB3sp5VdWWQ7B84LalxYLzlKRZTjhY4Yc6R6J0Dqw8S1Pd2/ONY
JhBoADCFNhP0Lr2NQt/P5KJD1/3WG7tO10r6WAkaHHCbbepma1DxrcfZBS5RBlL7
Don9id3r7DR0PHO3X/JYcjwtcU7plQNF46mlB3rmVb/liZ2CoO2h2MZz4FXHaob8
dpLNDDSzghhXgAm2dwXjYy7Sy85HJbxKp67XKw0dMQSP2/LeslEd+LeqP53f6fvJ
GGIHbvkPcQOx+cTahH6qTQ6PesnP++bZs+nDb5Hk28ZY8Im8BYvgkE1bXEiR54R1
1Rj1VCFQxiTeZfug6KWVfz88L5Aua1QyDpOa6vg7hmq1iuxJBEycerO9I1dxLS4F
M78V/br3Cg5PucgO/NKrjjL2p9jMZivexyecHo5JLfKGDMZVayDmFWXQWeii3kJ6
gbJpTVnf4VXaDEofdgouIenrZYlPrM5UqJ8XaW8QUwayt3Z2Fw6Ho2IUiioZVf3m
8zM8jbsHuxxXdipznU5LZNyIQhurtVldwLVTtYLcRig/Kn9Ak1evbnkfnnAiOj61
IQHTOwQS2JsrGz962RjjM3E/BfilPS6L+z8WthepEZn/msY4nEfIh+EO+nGsGUcl
MIu7tZ6rQZ4PFkHKxcenfk6WAX1I16eSs+4oDj1thuEEfKZFvaL/xjU3exxmYBK8
LW9y4ug7yO1C9WH+EtPVr9tWVwUtYYx5ThHb8JKjHZKaMK4bSfvuj9o4tTlSOh6s
XJFjuzWkSXnPPkkTmYiBxBK2PlULghWxRMaCDHwKwLvsxJvIMZCeXwlCJTfmAdgk
LGhFryHidosrz9RvtOrKEkjSXFdAkrBEkc7UIm/LgxVb+egVT9t1H2adEu9r+afV
wsnjGi2ePs9JMekwQxME9COKFMqswbFIURD0jie8kF1eId/a/8qI89tvPX8/2niV
jE+86oR2bVuqZVLSqJDYH17ekc5AEQQU6s/7qSVDM8VrSozPQ9i7/eUocvwkOq4E
8s0+6By2hOFirZAuUTAvyJi13NRCykaXFxTYY9p9LO0=
//pragma protect end_data_block
//pragma protect digest_block
SEMufFzIgYlm1C3Qfd6zlS3v7a0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_SERVICE_SV
