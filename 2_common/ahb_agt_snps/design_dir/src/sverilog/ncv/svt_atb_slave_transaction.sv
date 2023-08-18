
`ifndef GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_ATB_SLAVE_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    The slave transaction class extends from the ATB transaction base class
    svt_atb_transaction. The slave transaction class contains the constraints
    for slave specific members in the base transaction class.
    svt_atb_slave_transaction is used for specifying slave response to the
    slave component. In addition to this, at the end of each transaction on the
    ATB port, the slave VIP component provides object of type
    svt_atb_slave_transaction from its analysis ports, in active and passive
    mode.
 */

typedef class svt_atb_port_configuration;

class svt_atb_slave_transaction extends svt_atb_transaction;
 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_atb_slave_transaction", "class" );
  `endif

  `ifdef INCA
  //local rand svt_atb_port_configuration::atb_interface_type_enum slave_interface_type;
  `endif

  /**
    * if flush_valid_enable is set to '1' only then slave will assert afvalid
    * otherwise it will keep it deasserted.
    */
  rand bit flush_valid_enable = 1;

  /** defines delay slave driver will wait before asserting afvalid */
  rand int unsigned flush_valid_delay = 1;
 
  /**
    * if syncreq_enable is set to '1' only then slave will assert syncreq
    * for one clock cycle otherwise, it will keep it deasserted.
    */
  rand bit syncreq_enable = 1;

  /** defines delay slave driver will wait before asserting syncreq */
  rand int unsigned syncreq_delay = 1;
 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

    constraint slave_transaction_valid_ranges {

      solve burst_length before data_ready_delay;
`ifdef INCA
      //slave_interface_type == port_cfg.atb_interface_type;
`endif

     data_ready_delay.size() == burst_length;
     flush_valid_delay inside  {`SVT_ATB_FLUSH_VALID_DELAY_RANGE};
     syncreq_delay     inside  {`SVT_ATB_SYNCREQ_DELAY_RANGE};
  }
 
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Urc2YMHUE9SetS7XenWLaj4japb06n7vZJcQbciORUUjPPuLucCFD+CRm1XAOo92
nm7paRXby9yN62o6uSntYwh93S1ClS96T1ezxUQaP8Ar/S6mDf7/AgfiaU7IVqOH
GcF+LNdeJ3/rXEWpU1iljcxybGZrovU4OGyDwF0P8pia2xTrVbk+3w==
//pragma protect end_key_block
//pragma protect digest_block
BlgL3yjQ8tqf9EmGMAmmQwV6G30=
//pragma protect end_digest_block
//pragma protect data_block
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
VfUUrdzV+IKNqnxqJlZqPg==
//pragma protect end_data_block
//pragma protect digest_block
e4jsQkBz9jThqvm9+QkIixmrsj4=
//pragma protect end_digest_block
//pragma protect end_protected


`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`else
 `svt_vmm_data_new(svt_atb_slave_transaction)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_atb_slave_transaction)
   `svt_data_member_end(svt_atb_slave_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * 1) Tests the validity of the configuration
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize. 
   * Calls super.
   */
  extern function void post_randomize ();

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_UVM_TECHNOLOGY
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  extern function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_atb_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();

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

`endif // SVT_UVM_TECHNOLOGY

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
   * Does basic validation of the object contents.
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
   extern virtual function svt_pattern do_allocate_pattern ();
  // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique iden/get_uid
   * tification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );
 
  //-----------------------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5w7Qy9PiOgIJG/hCJgwJ0BUdC5fk9dE8PxKHMM9cZaEWgDuMhpWo5gxHSkdMrcac
qwCSnb375fOn9s9ijBhVg87VhtSPGEz5VP/+kGQMaG5llwFybi7+8YGLt/FQkejU
F70Cav8MI06oKU1ERiPW4Y1UH4dd0W0dB1oUVtd5rjYiInNRBXP8dw==
//pragma protect end_key_block
//pragma protect digest_block
4P7gsK4oDjo6VWPeBzlUe4d/4l8=
//pragma protect end_digest_block
//pragma protect data_block
dlbvMRB4K/JgnJAOPyNxor0tQYRnBOEAhXLJh+SaxJ/jW8KkRLfRGt1D7F7R/iTc
yDyWs+TMe7bjlpKKZymZ3gXjK5X/7vgpogqMUnczos0js8Rdu3KHUABVK9Z21XPX
wC5/1eEReN+FlD3m7uqTVTrJR57VqD4sm5OMr+e3GTu7LiqxLB3UCUe0Ij7JfAip
tjAPyRnyGcfPweHD2E4257+Q8oaczLAJenhAk97ktEx5y3HVyWk85DRGkC/SsNXS
t9l9TFlvy+cZfVzZV2wk0ooYMW9FPaSUfDFCnBs+NiJ9XEFAAQz6yGIUJfIVnfbA
mJG5TsEfmg3CYh5B9ecb99uksT+Xa3U73LihjX/2907mr9l9GOGuIt9I7nrXcv6R

//pragma protect end_data_block
//pragma protect digest_block
/NMpQkW82I8HVKtb7n9rTkfAZKE=
//pragma protect end_digest_block
//pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_class_factory(svt_atb_slave_transaction)      
  `endif  

  /**
    * adds data bytes to data_byte array of transaction handle from dataword captured
    * from physical bus.
    *
    * @param dataword : data captured from corresponding interface (atdata)
    * @param num_beat : databeat number for which current dataword is being added. (default 0)
    * @param valid_bytes_only : only bytes which are indicated valid should be added (default 0)
    */
  extern virtual function void add_databeat(bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] dataword, int num_beat=0, bit valid_bytes_only=0);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

`else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

endclass

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uVKLB0OAKSd8+YPn07UW1KGF/cNKFMTZQn4PdSoC5depjZlff0QJEk6DVpyTFYv3
70qqSfcA54vBtFPvkec7mhnWW+JTXNOKk5rnqrJR2y6Sd393ndoU3zY0E6xxgEdY
wbCQ9h1zwfXN8c1OnAeTixd/Y7rDzTih1W+v1rGXRosS+KBC+lJiLA==
//pragma protect end_key_block
//pragma protect digest_block
/z6fCIHX+pPG/HB/HtC1sQJpfV4=
//pragma protect end_digest_block
//pragma protect data_block
tixdzwkC5EFe1OKoLXK+m5EKrFfT+3cdqDUZTeY++SUmCgqcG5VEc3M7BidNXmLC
uq2lU5byr+WbWIFuThkHQH87mlwC3SuzfOm6FllpgaAgT75UZZfWn1GWXhl03mKq
N68k8noWvJKG4BlSUgL9USgBdh0CVKwhYtnRiQdsl9xiiZRFOAZtUQK36ovLD98d
dge9v4Aut7CmeiZZhzuX6c0fNu60+z27sp8qOpeI8xVoSAuLxh2yeNPiQKHMAc4Z
jaW7SJ2uk++xKYLQHOU4PzxenzDpMNG8AEy2ChDjr/hstnVTbBh2+7VXe+YpqR3g
VWfD/PAMD7bimVuSSnQe13jzwiab9cyNhyoIvvzF/LFCx1eA77sjJpLHui0OAfz4
eOnpqcCsWX71d40lGK6+txvZz87G7POusilhTmMvdG9CVTXC8uAMrZFSvcZUPXYH
1QfkkPOcZBmyvZS7fdhqedJ9zY0/EOAXtSgp3+3gr5ZnngjDQSF6AS7mwPbhuTE0
N/zOOa3uJ7EAJQVCotKBCEtvgcAfGEy1TEcnbO/W7Qn48muopsomW/On46JBF1Vu
rp6mJeq1ZbTlMPOgoizpVU1JpmQpOiWTju+RNY1AOVZgiF3jfPpieamvIEGwnAie
XjmkMB0cWB2KTOsGaF6UD8jPhw/09Fml/iH8hXOxCITWMVpf5Ocko3Zfl8Fykphv
f72ZrEJyAP5rPv+3h/ozcS70Oue7okQddAYEuewRK1GyBVdZtCbqCIKbv4GCtGo7
s7X49Geos+ZlFjGgd2UnwReat2FE/ESAKHj2YNv7YRL2/xMb6dg1ge1yw7Pzjkb7
m7l4wVfmJKejzumrF18spbunUEjqkVEaqGFvAFsufOwZvNQpdJsCba7kRfsJnY7x
ysO5bS/xjg6RkosJreYzxg==
//pragma protect end_data_block
//pragma protect digest_block
9j0ILV0HODzOibLfko2eX1lBVaE=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/**

Unitlity Methods for the svt_atb_slave_transaction class
*/


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GtIAnNDskhPUBYwBj9FqpNohky50vdhnv2xS6fiAQlLAElKV2G8/VllslzKtOx5R
+9jDX15zaGZEiLE59l/imVzXtXasAJvEM8/otHTiIx/Si0rAVA9UQOWE5FGpRit7
Dvo2VPiWX/avyMCOrs8frsT2fGYd1Wui3L0blaFUonA2dus9jVdIFg==
//pragma protect end_key_block
//pragma protect digest_block
YgAv6oiaZ9gG+GCbPGOcu1wOauA=
//pragma protect end_digest_block
//pragma protect data_block
pBB/ia6QCTUFJgiIPJZJ6QonqAAToL9DGOVzg0lEKfDSjhsC2vvKp9fpYGBYblI0
nLtV0f87KubwQHi6CRqD1cHfM1UO1O+ov+FaVrLewIqdL1agRCDudQ6/BXahsgrl
8VcV6TA4K8A6kXishcap0NEOhKPOE5looCoePdPozgWxHcK06EqDX+W+X3ytHn18
bY2FJ7PUcX3PeVBvWLX7OTmkxvC8RE9EJuAOB2mU1E3cv4Ht15EZAvDoHzNsO1ho
1yJiuTe3S8MzPi3zpt1Hy/DwLJ8nKZ+hwI1SAH1MnCmPproQ0qhTeaQcjRA/KZC3
1Pe3qdZRUkBcn6QsLz4vU/EEoGnmcX7l5TcjrEi3ZFtaP8kWxPvgYjkT6D7rJi1V
NDjfbL2gj+Ig+NXvq5YVEjnF/iSwkjSZjOwQ403k07psL9TfxBeXEJlGtUtUjpYU
3pqcP6rrRpnj0V8Ub+DpZIn1Ub2QJDz2iw4LuzakS3Dtu26+8FSkK0Uk68PjtP7/
EUiKP4Gl2QJQDbMPrbor+gu4oAt03ngkO6eyarAQpuGAQBI0nZv2iDlDTcMUGWzU
im9mkbm3Vqid+R+/rgiXNcI4KDu8Osi8QPDnRZmDauX9fCjTa72AS7ufEo0hBrvV
Bv6SFpbuZtwyJjAPPVll8nOzKLofej2Wpk8TS30dAIoAS59nIPHvNqxjzRWRj9/7
15hI+xmedILjaaXEeBuAgZ1lKLWRcZ5NRJuIo7C3u5qekwl4dmrz8zTRNoVUnv1r
paXC5HWVyV1ULl4xO1jH8RofZrUSmFXaL44A5JOmPbiP6D49LiRmHkJqr0fYCW81
6W1zqXtoa0xCaPvjojaQZyIUqPQ69T/4bFRLUs/whdL5ZzS5FqHpmMWvb6qOBQSa
QiotzVOhgm0HRLhNCpA31o1A/fe0zB2TpWub9sEs9PdXCGtx6YcCt3A4R8QtlE1n
wLnkSQJZ0OZVwRSSAJuZnaWWykCTMSGeunIiEyg91Cjmm8bg8l2Ri0STH/+7+JBf
PSUtmLlBD38pl/uyBlHrz0RcftfLyhFCLPVLcOSSMaZIeqUuE9Z/Rhbh87jtlVX4
Dx7+edZf0J4BoXwNL7W/CU4HtPScI1R2gsui8KIcBNRO8yPkeNvF0vjKSg9e3U1y
nVzMpPqcRExGxPFuOMoAwP+5cA2iwUrw/RoSXqJK3/yFlREXlruHKMbSXF4/FVqa
b/siWRlFiFx4LEPRkZqXP9JUmOIViO17GzchZ9/K+/OljN523+yYs+Jm7tR6ns6q
wiywzXtS+yYzVrVTCAmY7fVlkLz79LaqN1QEPIkD0H9WZo6YwM9i5Him+9OHARn9
/8TJb+AndGguUblpeGjlfi3YiAaaJ9MxgE6NrAuWx2R5/WSx02N/3MxiwbMxpSgW
g4pM3eU8lVbg9ecroi5oL/KHWNRmu0CE2h/rS+xYEKkcooNkgrHZdJgvESCvnIPQ
pfzjFJ1NTL1dd1LYxMak7XKIgX0nMSVetdKxmqB0LbsfBhsMjDNkIjzRIx9KrbI9
nJzWx3TGapuc93EJomrsgKKs6/pG+sYklfl9JaqeAjyvHQLfg3W45hHnGmD3rs3/
H1Pa3aSp3XuPFBusMtvc9mE7zDyi+z7MHEpBS9JvwJVCfx91gb2KiLZJyHF0giPP
kg4YoMO3FLtHFD4/YzNSVy4jV+8n8f5KEQbcL3sVl8RcjyPYSghaaD4S+p/gS7Du
bso1u9PkoNIRoNDrflz3sLnWcG2hbKM+sjBBGh8sZwssajs1XZdox2R5H0ktxsog
VnB46Dfgmt3e78L2aT/qor2w//XTvPt9OjrHTin1H0CxVqzsK2m5cQ45Lque4v56

//pragma protect end_data_block
//pragma protect digest_block
z17RxsmJnp0GHdYAY9Nj4f1QALQ=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------
function void svt_atb_slave_transaction::pre_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
spEWvbIFXhRlmhoDQ9Sfozb1tFjbnsEyd7IQRh+jiX9dwgUCt4qCo4I3JTI5lbNc
D7wqdtVCnDULE04tdDoSn1J5NdvgSym1hPF7xZfmOQpUY1oSoyVw5aPNCZgjSBmV
hHMz6YyKF/e3d3O46dRFGB3+3MoOIqmKDElYkAsquhuHgkSWPgCygw==
//pragma protect end_key_block
//pragma protect digest_block
9CXk8wKY1AkuQ5aImIrs5Bx25E8=
//pragma protect end_digest_block
//pragma protect data_block
PDJbTJkxt1PDivhhtfDHAwIQPTjylg9x58Pl4ZXtrBCFhNcfAgTo7cpQ4YlVmbJF
AqBAughbeV74Fael5YTeQ2vMpY+xIDtGUauQXRJCUEghhuXftZ8hV8wG5SgnO/Xg
csepYxddX2VRW7GGLPJln3aaFNAciCy/riH2woIpTXeJ278xqv7CMTH07qV+5WSg
yiyu8yiu5DeGLfZVh/jZDVOK65gE6aW3npZ33jQFMgZoRWFQ4cl6vbJjhClbGuQO
51x+BC6ZJ03oTs9/XQpP3Ioe1D3DfmhOrCxecStkMZE2orUW+LfuQq//g73kX+cc
CBxhDFmEIFpIRSqFovG2ELR/qTiXoblrv7Hx5HD6yG1hgbbQuFUnvMS8lrlhLe1C
aNgbSF9ut8Afw3QCbGuvfdIg5AqdvCXqof1bQ5Z6tBa6YK1+LakL836UCG/n8VzK
2SHqVTtp8bShKxwl2KzV1+j+hYz2NWP7xy9a74kDs1qsv4BOmaYJaCJX/re+cmmb
tgx/R7OvF7BtSYDrrXKMUlIDaIEH+KUYWXj609567/Aby/maUcIVZuXwS9WBlYw6
H0tssg4NvHrI7R2hOs/B3cXX97rM9JXrliOYAuC5cyojG619J48GT4N7osV3vf4x
P3OAnoYyBIsMC20PH/D+GuVzVfOdMiG4fvgr14NXpsHKwNH7GHwTqpeg7eunj9Rt
cAgkSwxoBkbK0P9v7CPUUxkDnIgUWZGE7gCq14xarsFyyaG+iF5ZMDuY6mePjBuy
Jk0SritdJhA/LApeqaLcJXqOdSY47NAJxdrESg8UXv8bGMddpI96w2jNOLoh+Q7q
VNpltkKkgUc4VX1TpmSQ4OuLDCidDFEfN5CAIl0m/YOPAtKZc0euU2cVqhUJ3szi
Lw1QSxQzzAbVOvmTOYn/8rBIYmUN1+ZpKGurRSsb7ZGiDpA30jNtXGT51OpDIzmT
VMqWMudR3t9oPhORlWjCXY3uS6jAzmX0OCTv7nyJ79s=
//pragma protect end_data_block
//pragma protect digest_block
ffESzxrU5vL7koZslBu56humIfQ=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize


  // -----------------------------------------------------------------------------
function void svt_atb_slave_transaction :: post_randomize();
  bit data_only = 1;
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8trRYpGw7JN7AhWR9004/c6q46vJjQJpvULq7x0U/GBwvUhRX9jWgXNop2FfpuC1
nAEVefLUM7KOn5/zKBYJ6yYxtFr4J8D3wAzQCaW0rSlagl49jf4H4GRO/HIl9OeC
dlGKLgbEenoLFccGnhzvdvOY3rfPqlkLC890i0HmdYjxNllSUypuFg==
//pragma protect end_key_block
//pragma protect digest_block
wVS9zwZyPZkdkPRin7uSZyZ/5JQ=
//pragma protect end_digest_block
//pragma protect data_block
tx56ybKsWNS3/UUARsVo7R+rDsVKdVC0e0AiaKcKfSK6AJ7JzJBRcjjJ85RxcGIy
8Gks0qMAKvYJoLlFvLtNXVcLzLFieaFO9v/inOpVk+TmBdpVsyYUjF02UJ4ZZI9f
CSDZqxbYSxtFNh2kHUl0zlRdEbeW02rmRzdDqxxTW9UjqEmwulBLbDsZpRy770ye
yjuqgNtlj5GOH4yvqrpRy5XfjqTobVlJbFLivBE/tw/oR3D8pSDGtUy1eTPCvTMv
1K+NFAQ25gFCiXsMi0IhJo1hBKp5LlMNIVAkZGlrtoJuovDAQ4PCIM8EYJEfvv0A
radzKq5ZPF/aDZF2MIpV3huwRCJuBrKBhE3eDAwP2MTy5jqgHCYVIy89S7JgHlhg

//pragma protect end_data_block
//pragma protect digest_block
bGIB8699y7qyYxvAhbRK5gAD/Go=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xdjpVevJfJkGfcuWbJKuLSRCCejfSTrqdyIuMc8o3z0W0KSiK2sw6Cdhvtlb8F+e
uP/UTNP8tgQpndVg7XJZReiCGxQKRJjmpC3y6CiltEUiw+J644/8Zd6vvsacQsu6
xiyTm11QxjbRDFjRJ4GaAafzMNxEDYPvdbxzJayBzK4XSc5QVxJ4rA==
//pragma protect end_key_block
//pragma protect digest_block
CC7jl184CgDFtlUNvLz8D9Z5FY4=
//pragma protect end_digest_block
//pragma protect data_block
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
YJQrqmMfX4vS4QaionLj7WHG6gqJq7QrO8daJcqzc5mD66o2tQrUbEkzumOvyHA+
WtusLWdmRUEji8F3WTT4EY++dAvqbhfTR/p48Z5yZr4Zu6IwiaYBCvSGkaDhc0ZW
PxRKtk9URFEGXWx/HlnulHU6vGNOX8nLxPfBeABqdlhY1QRIh+nRHDt1NkY/HbLT
ErdGGCWOyu4Ur6t/fPS9vryHx1OThvlZ8rz/FeWwyj4/JLEHHU3Q4zyhN3tG81qo
kWWBkVU+BPWXCy7JVTrmPQbUPF4xXepHLhc8et+6IHgjNv3jF5vRA7Y0tzyAalQl
CElWFSciTLf+aXtwlkkFgSgf8Kf/D5zUdrXnvmWnKUqrWNpw5gUYIv0xTzzid5CR
R3Vk2ASZU41e298GJ2gkYuxP11khFb04nTN6dPdUY8n11DFQW80bc9V2+OGq2i82
563ibOQiuGp9MbNFs9rKNrskYrBrbMJTnzbgV4/HIKdcaX8aPgDrB69GzS/8zD7F
tMgwz534IlPM8Jfd9dlyfUy3FL/MS1QtkgSBSc306GmdbXLMKacVunygSQ+oOslF
5wan9sHoEGeDYawQII+rviVMeuDVsKmwVrANlqiBT/Z6F8kuxzkgDhHO3z6+EB2B
BoTkPuTQXhYWZKO1ljn66mfC8VsU047wJRQGbUYpzyOWcE7vMafBKAJ2Z666T1Ht
emZ1m72fq5gJYoSAwo+ym56M01e1ScG2N6epT6+rlGzd4vv2fNhlV9y69J2vq7Ms
0+cbpGuZTx0Holvr98yyGWayPL5ZQnYIhlc0E19COM0hH2MrWlYrKgo8hkBlzUim
w1IBkwqhrlJ3ItJ/M5wd+x3P6C+hexplEWH5ETKhUQRuTkGHMK7c5/pKNbhlecaB
amY9ra0xiOnsd9E1uBHzYjV3F76P/LVPV/APIVlEIGGpIQ8DWdS/aKSV0qnooLq7
F6s+ew3t3uxHeAJbrquR0GkvcXPJn1hVMfJslWo5EqPNmZH3/tEnivpFYEc1oUal
L/KzAjQ2lgi+WkcZNL0Z32kytpuJ7zXXfIrZEp0Tr5uN2xJE9J3P97662LnqHa1o
uNs8jsNx1kPFLOaoZfX1k8UcLSu7AncREZnzI824jGEks4Dnvgk3PNxt9/3vW/Am
dKl0c1hbcJbIwufcHHWV54HJajKtDrbkz3OrVgF+nLdNHJTmBHoTI0gaG/ebO/CH
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
90BBI/g+QAlxuipkw4PI2w==
//pragma protect end_data_block
//pragma protect digest_block
1bqGeJtpKjhkDgSqyIPnoAjCvag=
//pragma protect end_digest_block
//pragma protect end_protected


`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_input_port_type;
  `vmm_atomic_gen(svt_atb_slave_transaction, "VMM (Atomic) Generator for svt_atb_slave_transaction data objects")
  `vmm_scenario_gen(svt_atb_slave_transaction, "VMM (Scenario) Generator for svt_atb_slave_transaction data objects")
`endif 


`endif // GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
