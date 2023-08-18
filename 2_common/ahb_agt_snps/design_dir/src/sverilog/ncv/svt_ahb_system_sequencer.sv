
`ifndef GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
`define GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_ahb_system_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /* AHB Master sequencer */
  svt_ahb_master_transaction_sequencer master_sequencer[];

  /* AHB Slave sequencer */
  svt_ahb_slave_sequencer slave_sequencer[];

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_ahb_system_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_system_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  extern function new(string name="svt_ahb_system_sequencer", `SVT_XVM(component) parent=null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Pre-sizes the sequencer references
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_ahb_system_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tfz3QA9H22ejKbSlOwC+OERNMX1SNdJEZZjKfofFt0JZh26MgSe/I1hGnZMrIMyC
1s3C0cd726tJNVHbSZ0It6tjQmsDtpyHfEEYYHr+uvKBanEn9WLu5SkVq1JDqVdV
znGmTY66TOKQpcrCedOq047F2pHj3WqEgWZXbA0fYZIQotGsFdIjNQ==
//pragma protect end_key_block
//pragma protect digest_block
G6nLaMzFOHy1tIHg6l+WqYBn+Iw=
//pragma protect end_digest_block
//pragma protect data_block
jK4u9x1v/0T9Q0XzW5t049NstOuERe6Dbb/ORJ9z376F8NxSek9O8DWoG6rqaXc8
Sx4iJMrUzsZAMWxiZ6PnQ3BAszHd2kGlX3O1GrRLFlSvIL5yt1T3eSGvL7/tsGR9
v5mZ1lR1uuMqzCJhZ4+QizvE4YmvsXMdrLSg75Or6UbvV+cri/HqLgAP+8v1xI2I
HQpkRjiVc62JKt7zAqNGy3Yypn9w5ypDyrmjMKecdd3UE9HEJSjdptxKRlC0croD
713PoV88ioEYWItymGrDRdiVtOBAfbaC8WfBAVIn4627gqsBzgvphRio3aKVHGGw
1kM8eHZu4IlePq2zKF5u0H7rshAqkfcEpxN/yM5bWU9BvcUEVCeSuXEkLvhXsHQH
RoP/bRnO8e1WjO39odU+8InbYOs1uBHKR/ZtJVyuEvmg05kRgYGxO6ttE/psM+bi
U1ENeYwab3wQPnlvYKEFDd8+KR0+WgXfHEbH5p1VNxucjY/nXI4GJHb3X9uQjhG0
p8A7ytCcjQalZmC9BA5u06qfO5aZLQL2LJ0JMjTVzJxxa86VYJy9rI5WUiYOq5fk
OanyjV0hAvValBjLXrsNiL3gn57zmucmS5zariWgQwMYdFCyp13CN7JcpzGC/jnv
64s0qt6fPPOKk+9abGm8nis5tAt991vk15ZPZ6tLa9V/XZTXinFGQAJIhKi1B7i2
4qtCp1Mi8gN3dmyL+LUWfSvdSCK6iaCnG7UAakbNzfpfEZ4X6J8MPRvKv2Va8ZVw
0AX/E0zRFGyiQTPkcENksV2qwfSJq8USvxWDYDgJMsY=
//pragma protect end_data_block
//pragma protect digest_block
4/97SxMhAjQSTls4BksogOP85v0=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8xV4IcDs2G6ruq4OkHOhVMh/T0Nm5WPq/+ASq1tEdwiveGw96uAg6dPeJmDTAyWr
Wi6w485qpMo7lefwrKicY6O0oQLYRjg3Y4b+nJfDL45WUbZ13mSnpXy7K0hxoEce
rluenzbjLtRz475stZvNuo3kuh0bjRKuIdK0O8nQI0+IY549fN/h2Q==
//pragma protect end_key_block
//pragma protect digest_block
cpUrnaIWfzneo0vennV1hYXrAF0=
//pragma protect end_digest_block
//pragma protect data_block
wuqgQuqBkpz5zIEG2GiOCvKTV+SwiN1ZzG/2CHmfT0yDU+K0+zLC9XpiJ+R7J7K3
nglFVinSIvje2ncCpISV9vl+h0DhTKZqT18CELq6PlKUw2Ffih9g2XNkrtMA/uw9
VZ8MBxhWRND2bSEDTjUUeRzbR/kaJB4segT1VYr+VaEvT/+upi5r1JSxbenS/qbb
RtG6pIyswJ24xAhGNDPEpgW0+001tiM0UN9alAmf4mJXWPPiEueVYp0VaGSgFuYg
xRin8k0WMNtahG3sG31hwfOCiffiHf/Hr/d+gSGx4gdzvw5s58GAU6jskOPn4pze
dkt6vaooMKBI9qdIv634rz7ebFFbLuHnxJcAfDP5fvTan5ci4UaeH0yz2i0BECSa
YEXPzOVvhFvBreGk/iIcyt7fTNcV9ns74Z/TvWO9riYZlcXdDgD3jqWa10Hqgwy9
dX8fu/M6J0tsN7lGiLHZfejWJwUdCnrZ7w7zLq8Da3yW8xeIncgTWmEAUEV/pMxF
5N0aZFfYJ/YWrFCnaFmT1kBKSlecOOPzZUlDyDBT0HAmvi/ZXYo2I9uixudUgQyT
LTA4jDqMGkRc+CcwBcTWKPBYyqvVUu0NdtaY2IfnGACvmg3lHNwxrZlt7O1dpu3U
z281pBulPy4fDzrk9n7iE1ys0ERrWXpQRz5eLgi+B39D4DRkR7wFY0DYZ0BrtMl1
6Aq6GyoRApljjyukOcST1mGZF2rmxkOge/6ozEyJ1V9TInbo5Lt7YZow67tbW1w5
4cQvoRDBgLB/evzXReWkwAO5NgfXIb4ab9dQqoTgiaU7CHZ5V2SqEf4qdn8G7zlo
g09aZHBVBfkVtcub7M1AF5Joo5kav4b5VS4YGJKUqqIhd41P1i8vwkdrHRMXV+O5
xPvvcbgxKA3IHkOTUnSSmzU7oPj2wDBbqz9b2wfdXnyDkmbNxQqvKGZJA9/ynKCA
R42hUuDECGF1aQinl6vFzGyW6IDzf04VavYY7gPhNTy4yGN7vxhwgn8qBXIZJcnL
iqsRucus0b1+Zf3WDJnRugVz9lVgOkF8IhYEL8ZwkifFs143+dE1xTtTQCC6r9GX
c2eDO5lcYyEoHzXxiuvHI1LCyyzr6OdATDMfkujU8DaRFcEphgYasLYkD+LUdxTq
0v4fKY1CpFNSkxlELZd3JHcj0/LN+divzA0dQDPznW0rK9Vm0HpgxRmFnUJgK56m
b6R84NWkTuJjzJehsB2/jjT9qWsrrpzDreBxIW+CClkeDLHP8hYcAGOlY7sLeDRu
xl5RtvNNjypEPM6js1uNIo1p7bWbPs0rTxS/6gRDrGmkzCE1IV7OfqCFNH4J/xNB
G8x1Ito4ToSJdUKLhA9oXJxVdHzWfTKQz2WtoYz/c0AAsHBn3h0RU+lUhkavBLrT
TAxwt/OkMbxaD1An00zhetaVLN0uR5/bKhVM4T03+rJCuzgNgnvOLsQdrDxHs6g/
Gx3YeSGk7Gf2JCtVpsSAGQ==
//pragma protect end_data_block
//pragma protect digest_block
d4M77byEni7D7RlRZB+cIM3o/f4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
