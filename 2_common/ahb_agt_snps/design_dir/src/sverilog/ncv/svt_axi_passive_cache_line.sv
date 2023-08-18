
`ifndef GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
`define GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV

`include "svt_axi_common_defines.svi"

/** @cond PRIVATE */
// ======================================================================
/**
 * This class is used to represent a single cache line.
 * It is intended to be used to create a sparse array of stored cache line data,
 * with each element of the array representing a full cache line in the cache.
 * The object is initilized with, and stores the information about the index,
 * the address associated with this cache line, the corresponding data and the 
 * status of the cache line.
 */
class svt_axi_passive_cache_line ; //extends svt_axi_cache_line;

  /** typedef for data properties */
  typedef bit [7:0] data_t;

  /** typedef for address properties */
  typedef bit [`SVT_AXI_MAX_ADDR_WIDTH - 1:0] addr_t;

  /** enum type for passive cache state */
  typedef enum { 
      UC       = 0,
      SC       = 1, 
      UD       = 2, 
      SD       = 3, 
      UCUD     = 4, 
      SCSD     = 5, 
      UCSCUDSD = 6,
      INVALID  = 7
  } passive_state_enum;

  /** Identifies the index corresponding to this cache line */
  local int index;
  
  /** The width of each cache line in bits */
  local int cache_line_size = 32;

  /** Identifies the address assoicated with this cache line. */
  local addr_t addr;

  /** The data word stored in this cache line. */
  local data_t data[];

  /** 
   *  Dirty flag corresponding to each data byte is stored in this array. 
   *  Purpose of this flag is to indicate which bytes in the cache-line were
   *  written into and made dirty.
   */
  local bit       dirty_byte[];

  /** 
    * In passive mode exact state of a cacheline is not always measurable or observable
    * This can be inferred from a coherent event i.e. coherent transaction receiving 
    * response from interconnect or snoop response received from the snooped master for
    * a specific snoop request from interconnect. However, in some cases a response may
    * not have enough information to infer exact state of the cacheline. Instead, possible
    * legal states of the cacheline is inferred from those events.
    * 
    * Due to this reason a passive cache needs more number of states to describe coherency
    * status of a cacheline. 
    * UC, SC, UD, SD are defined non-ambiguous states and all other states represent 
    * ambiguousness of present state of the cacheline.
    *
    * NOTE: currently passive cache supports only expected or recommended states of AMBA
    * AXI_ACE specification.
    */
  local passive_state_enum state;

  /** indicates age of current cacheline in terms of its most recent access */
  local longint unsigned age;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object */
  local static vmm_log log = new ( "svt_axi_passive_cache_line", "class" );
`elsif SVT_UVM_TECHNOLOGY
  uvm_report_object reporter = new ( "svt_axi_passive_cache_line" );
`else
  ovm_report_object reporter;
`endif

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of this class.
   * 
   * @param index Identifies the index of this cache line. 
   *
   * @param addr Identifies the initial address associated with this cache line.
   *
   * @param init_data Sets the stored data to a default initial value.
   *
   * @param init_state Initiallizes current cacheline with specified cache state
   *
   */
  extern function new(
                     `ifdef SVT_VMM_TECHNOLOGY
                      vmm_log log,
                      `endif
                      int index,
                      int cache_line_size,
                      addr_t addr,
                      data_t init_data[] = {},
                      bit init_dirty_byte[] = {},
                      passive_state_enum init_state = UC
                     );

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored in this cacheline.
   */
  extern virtual function bit read(output data_t rdata[]);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data to be stored in this cache line.
   *
   * @param addr The address associated with this cache line.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data corresponding to
   * that bit position. This enables partial writes into a cache line
   * 
   */
  extern virtual function bit write(data_t data[],
                                    addr_t addr,
                                    bit byteen[] 
                                    );

  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function void set_status(passive_state_enum new_state);
  // --------------------------------------------------------------------
  /**
   * Not supported in passive cacheline class
   */
  extern virtual function passive_state_enum get_status();
  // --------------------------------------------------------------------
  /** Overwrites the dirty byte flags stored in this cacheline with the value passed by user */
  extern virtual function bit set_dirty_byte_flags(input bit dirty_byte[]);

  // --------------------------------------------------------------------
  /**
    * Overwrites all the the dirty byte flags stored in this cacheline with
    * the same value passed in argument.
    */
  extern virtual function bit set_line_dirty_status(input bit dirty_flag);

  // --------------------------------------------------------------------
  /** Returns the value of the dirty byte flags stored in this cacheline.  */
  extern virtual function bit get_dirty_byte_flags(output bit dirty_byte[]);

  // --------------------------------------------------------------------
  /** Returns '1' if cache line is in dirty state */
  extern virtual function bit is_dirty();

  // --------------------------------------------------------------------
  /** Returns index corresponding to this cacheline */
  extern virtual function int get_index();

  // --------------------------------------------------------------------
  /** Returns age of this cacheline */
  extern virtual function longint unsigned get_age();

  /** Updates age for to this cacheline */
  extern virtual function void set_age(longint unsigned age);

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this cache line object to a string which reports the
   * Index, Address, Data, Shared/Dirty and Clean/Unique Status, Age and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_cache_line_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this cache line without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_cache_line_value_str(string prefix = "");

// =============================================================================
endclass
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0jv4nCLzDcthvzzlT+NLVy+yOpJYRZ1nmtIl7XYwDZo0lLbEfQvpJLv5LnhZDTwi
Valn8VYCkZjCbwLzcKkgfRVcy6RBqiiIIzCjRjE4wUAo1hBQnMBMt01uAMkQStjo
38J96fMiiQoXt2dX+cK9wWOI7GstYZRdZbDptjN+kp+qk2rWeha8QQ==
//pragma protect end_key_block
//pragma protect digest_block
cBw5AYqQXjtugUvCvIFcr6Mct4o=
//pragma protect end_digest_block
//pragma protect data_block
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
y82O4sR6sIhc1Zzxe9B4fg==
//pragma protect end_data_block
//pragma protect digest_block
4Me9CLeQ4dDhWsNZ3iGMqkkcDuY=
//pragma protect end_digest_block
//pragma protect end_protected
// ----------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UFtrfSgjXJ41hfEcVMX2JXxOSlixQRIiV3mDWKhQFB8m/VmcABiF/GES6qWI2ntS
Qe4J0nHepDIOx+Fch8TYfFN8GrwtDQ07+CwyI25OGuRL8ClxbuE3XcNXFC4hRj7J
5G73pWUMjnReu8eF+xSAFhhQPXoS9eC5vh7liyblGt/ktOd0JU1PRg==
//pragma protect end_key_block
//pragma protect digest_block
MovMHvSZD+vgpqXwDNlEduk3ZoE=
//pragma protect end_digest_block
//pragma protect data_block
rMtGBdYRorGUaMLzfxq2Y8EKloWbWh3dGICiE4E7bJup+oeM9tvkWCzM22XnDwf1
9nLBDH+RrkAomboasWLai/Pl1isbRmNGo9mVts3rMxYkQ6ECvaIk+KqmPsTsEdfK
6thSzLGIQm6JqNDLobbMv6obzIuYSwLwjIp+D6MEV8Zj01ZqKMAqgPHnw/IVjXkl
jCb0iE48jRFshogg3ZEZiwEnBKae5/iX2WbRh+ODe1DFH13f30iloUXfyZDWXInJ
k0+Jf5QbuPrIKkh70GmBE3oNsCkhYqeiTgNKBH3o9l5h/pHHfEG1RXN1WWr89b9p
bhZ9Tc6VXlJt0203ckTl3QIc2+tQ6uJIyEgDFT19lNor8yCtz6ldjGJwaD/KOHBS
HMbHFI6yeoftQHjBEpp0tBfBgoW+wG1psC4mUJ9KrlqlAF00gXGcLW1dvMlnT+bo
WaKhYF9G4LLvV1T+c0VJAPtzSYhk4ZBIvZWQN7HHe0Z/b/sQC4jas7qjGGELUVNi
+LVEVJ3qLZIsHdaTyi6JUGw3DtVCeQSfzOx7qiQADFo+JcBQkg4nk0c1UCjFjKdU
+6Cep8xu+MFdZsiEOPGlfbEPao0a/KEICuaPRiNozPBIMBLRPd6CWqFXVfi4fUCx
HLN1gGaqvaoMwSqxf5XGNfFOf+12vNt8PD1W1K+UFrDHYfZeREJ9Iy71yHPg2zia
ldX+uFh/E4on0qtu2g/DSbLpoyvbMmeA3fy9tSLlQFmilrPiB/S9Ood+xzNmOfoU
OEMqQk5OEwx6lUwC5fvNKAw3Wv1FdL4UTP5U3aiq78kEjOjiX+8EiXIbOGm561M4
ccMfgoNNWTKtoeyP68cCwGqWwoUKG420fLQhXwGK5orYjERBYYywwoxdJJXQos0q
S4hrr11kacRaq99ZeZxQXJ/SeCPdbVS4R3RnisFKq1kW3Z4pMHdTfvWkQk7IjhMx
+1MDzFCIX8L3DB4NZbDB08fhfW1PaiXJoCbXaUx+j7/GaFP++I9PHkI4/8XJNg4v
PbAiIP0cx8edADBfB7vrxVoLYVtAafeivisyLjIxUtgeJ9DexZimvNfA/Q88o2ZD
qH7kYIUZsDfTxiB5H03/kvhnJR8fQlKqC3AewnLE8XyqVHpMgKyghRDDFfcYXuDR
fGSDxEImIQUGntkLjG63IR4+fwY1IdpZVVR5z8NkBItIeoIX2ESEEWl2Jbkb+ezH
t1+HYN7JEiLjyyCPgDfdHk/CaVvhU7natRNiirBhCA2rKBT+ca3SLbWX63hCwkhv
tlul4aRKg82MqDeR8B8vKZ3FyIwiT4biMfUkIn6p4CTPNY7ZbkvkO0zCikMM73VG
JK/+Gibt36QjeTFoyVhzhjb90Wq5rdH4BX99al1C5IMSkpyOFa5cJfZFZ56SI/+3
9PzsaG8lv1BGgjQxffv7SVKMUMp40x2grHb4GPrpPMtX1UY/xwz0gps7/yxokotF
5FGTu4cNoKNMTrXGJDqumqT9wdCm1fLV4Mz2FLB5nB3E9yjTrZ6M9bHCsaS1KZpO
6rj+rvNDjVRURQKZBHASPVwnQi33BoA3SEDe8b+muihYzMq8uEtQCYIn9NoZwE5x
gdzd8qW0Pe6U08eSZOAlpV+j7sjfAN1RkF4u/q1sJGTCJNu6qWhbrxjqzJ/UuLHA
PjIb5z1MKG0EAbkhUpB+NNAAGUuXdCZ0DUTpD5U+LctUjWPHsPVqa3n3NEoTvbaI
7+tmEaRFQHR8MWmOOW8Q5iKIecfqf6gVfCcyaQ49/kUdqfq2JvfwK/2uxvZ7mIJ3
dR5oeOjVz+c9MGQc1M3F6pnbWmkNth1ghch5gtbAOB7QK+vkRF1VAkW3qw6IT0Nf
VTQJ0Yp8H85yiyIGDl80opRm2tZMBFMFhgAriJMILNbcOl6bpTVJtesr94Hmy8yW
6uLB4F+9Ma13yd/DTVWt+gtglpoR9O/lNBRmaT7TcPGsD4aB6izHhjRBTcWTW2Bv
61HeXyZnH/fwWjNioJcObH4h3caya6LGdtxumnIkzeA1kj8H/Khv1ABg1YU2tob3
NXR5+HRypcIMUmzFWW29ia4qGWLDq5LGAHp7rn8L67IbJ3WNH63UMUnF7XOPek36
96XSyYDJD9QeIEvwimnUc3VIm9c2X1M66yMb7Ri4hGUaEjknswLAmpR+OPBbRdns
lal80aLLrG9QV5yXAyNCuTZR8zqlBlReGf3GkpuarN6TkczI0xsg7U6qGJCdLNzA
0J/MzoUdI4QI1rK/YMENvNdJXKO4mOiCiTMrjSQmyRHvWt8P92oWVnkigmmxr3XB
fPb8ArV7FEDL0YrYWUeCNHRDDNBltOOdGRk3aKX5ajKrmw3753E98vSPFMUz/ZVt
uQg4VINocZcTBXGAaC1FHCbFp41dVzrces1MGqnqvI9Te6BKQPq+Qy7pngDZj5L4
XTWDnYXXSrdok3Ow6oPVM3zsYDesIST2EaVzjqmA2doi1OupbJZ9Zt2ccmsPWcOO
KKqcubZ/bSZppFuIpmvgjaLf03GaC7ayQe62Shcrl90p0mbqoWy+YZWW5dyzLpXu
c5JVv0B8Wr3kXGTl2L2o24is78Nw8439p8h+IBUFJIKnoW+0COFPYIkH/qzuKxwr
LyiTytv4eAA5P2qgKLVHuyZENmUS2fyk4uazMD2W9XKrXWayQK1Q2KqQqM31PBBu
OFxzfGbQku8Yzy6ktnkrNrvoNWy37NFAPbL7z8iEUyJ7QsxAcz+rDDexC24/gF2c
dlZEgDN2OQd0VtZ7sv4HGJkj/hdzs0aBDAU4oCZBLZ289Hzu4WJOMrLDpYBHasMz
MmGMzC2v5SaJfSCCko7VjumJHlUeSzQoDgrsCbEmUjuXuqU4AeQH5vYsF0vxLBeL
4/XBdh0rglehV01e3mFCqArn8TQYMIq5rQmhO7WkkUjEohtYx4PLrmxzqkWBHoyJ
K2LYnmD0RaKJcgBkSFCgABO7tOfiCDbW6ChVy4NRDdvUZMTnMnYnkQU0BiYklxdV
/luvqCQRmUTqJu0X079ZvNTRiLAft1dbIexDl8bpREAJdo0/B48DScRgb2cpSDMg
lHo2TRDvB+RM1wu8QdS4NdvRdhAFdLpZUT2wbHnA/0FVlBtDoWZWdjJYqAy0x8Cv
QBLVvPZ6n3mYhoDF/IsCVXws+s1bEpUumIQgoSCgbHtUJZ/thTRYA3kGFGOzHvFg
4Fpoixom09d06dEkO/0e9PMlu8Zj9z7GCQoLwLLHFLiGF9VJFb2BNEVp+EYdhFcx
+vOSez01ICjctlXNhFiEH9qZUCg12gfIeQOcYowow+rp77uG2cdExUsc5aRtMJ6I
MCDddP8LkCS3jLCDf0XrfR0PyBWwB4OqgluGEs7KVcDcZErcdr0JWfEnnkB6DHDh
2vfngnuTfp6ffQBH14otDBoQQIUTAWu5q5TXhMqLsu49nmzUNvxw2Kv2CLZBpnj1
Iebwpv5vNia0aSCZFnOdPe+lYFnygQwawAQK1FlqdzwhxUtlCUrH+RzK0TWE0OfL
O7OWYTBo/GVXG06EUu/H8SRk7/6rsnREvak0R3soeGX3jrZD/ACgBXUM+UzpM1B8
tfJE/CAUlIVQxbSOTDQqComOWXdfySVNYFA9xWvdcG4MESqDoOw/LodthRC5AxKc
ANs5QSFznyrXOdxtNs10qB9Bmjx7g9UmRVVhLB4mfs/KSoMnNesdHIRInC7mekhp
hZTQ1qKQd8unyT+gYcpf2P0EKb+WEmLhe3S/zdW7I3S59IRBcFPcnzYLv2LNN8DB
J4DUhBiq7Yri2WmWADcCeYKQd5H/ODzjYX9AaE0qBbKYGC9nli6tD1ihuige8Jsk
3mpmk3o6GXLLKNACsWGOCHfQW3at5ejtOTZi0oD6cI82jKo6KsovydGFi5V4QdH5
SrFQl/HUDlvKjQbyDlB+FzNPlwSUQ6zMu+rkQaMRxmGW3X/2znVwnT5kLHpVxcul
hqDg5TwUsqsRzYwIlAW2GpjldgBzMADev92EEM8X7lactsIz1rMfp+RUM3NgAy+j
2B9cfq2kSyBH0GCsFMASu9ljR6jGB6N1DzE+YA6/gSqRXrLbrZVi67OLEwlz/Bid
ZpCEVTt5kX3GysAOhSCKNpL4QcCUjTlzaumitqxwqfcJ9Fj5aWp8w/jGkgB5Gbys
EkMbcEhdLCn5NXnbYGAogF064WXce3G4cIDR4quRO75B8Z+09wZNkgq2PBL3TMoJ
yc9eyMZHkDIHcEA8hbI93Zdz3cppOir3yFSPbolrQbie09sSmpEwooXv2ZZjxaFu
3WeLsvZ5Qm6u+Nujm1VA1fQAXPkHPo+c/oRkqPcSlgSaxjQZbYuVidJ6Ihn+dDWJ
gCNAWkDBVYUSQKYV8IUQA8RxkObDVqujxdYdZqG3/A7RbCf+o0To9OGhQUdFz8I4
KQqyUwpy+P6kziBQTVjfRR3h65ZuEYMc91ZAvdoVF+Ji0gth5GyRki9Pgot/1MOl
mK+ohXild80lw77kAOZtvpL55XMhrArpyApcDFwrbquS9yO/u3nwgdG5mnhB/dVu
mbbFuLbtND8ATULNIqwrMuWrohgORgzDcin4AMeVihrmRCJ5hRIsdZR980gSE+Wm
zJDVjqMm3V0uKzsoRQNCtGmxHOtZ0ZWwaQg4Ec/zPnRckxx+F7LGVPXIis2cW/Up
QDmHpRNniG+XdSlWqV7RFLh6GVBqzciq7F2qqEbz7n0Rghbo+fqP6fM/xgCUmDu3
UcpoSne8g2vkY69SGvQdiC9hWr8oOo8LXu5giJYpNEjQjrsvYsC9ONLz78BZavZM
AqUNuBjac9iUdHnb5e8Kq/r2nqMNuORwL3EVcg3DIFFZVBpEXW5SHBxrOoPIXT2I
sr9kRqpUPSPYRoIv586hsFEAfgeEFQijWDsD6eBI4VKkodQdD+Bpo9gPqGESiZsY
3x650BQtUz1aEUN8yeLacK4zOdGXjxKywE1EN+aq7/4+fO32djyqTXOoMmpE4zBh
NcSzbRP87m6mwdQcqsospesBbn2wGJJ6h0uAugAHje6xnxm23n/leNOKq01Erlta
jg0tS1ozkab4ExrqXnRrev7sw4pU0Iog/r2D+zOb27CTx80iSF24V5VF2NZGZ/B7
HWmcPFiQIPLlWN3hBoHuBFrolU+KKbaso4gQiX4qg8dfY8klm6/9jGaPP/xeGb1A
B24kbSzHs2enByZemfH6ULI9PqcL8CgQBxHj4eO2Z+3upgu7fY1o3Kkip5J4x1yx
zTWp03PXJPjZ+WV5WrYC9W6cxX5ERa0S/L0Uew9fQDFQfZzohcDsmoqhpVgL1Xf/
zl3N/ds7EOVgu6OzSgudvYqFUR6s91OWIQa353UowkuV0rICfiVcpjFCWlni29P7
Iumdy+LoJ4ye5K+lp7rwFZT+LNVuXS805+exKldbxDqw95dFOUmHR3WLp1cqotmU
vYMRzAAaOeJk98V7gK+OEZkQhMFTOU3xfqCyKQ8ArMJNZkmZsrkK3Qqh9a2Wpefv
NlAJ5ZgL6av03XY0sYVMy5Va3Pynx2kcY124g2DWv0kvCnH4bwok+5gM/RNGuWVQ
MSJCw0wzcCh8+NlwJ3p8CUqZiaR1cGD6WVIeY2E5NiMfigeeRU/XKzGLrBj4FI+K
trEdu520xT2IxK5YNH+EdHSv5K3NYm9TRdJ2HK3NOO9hD+3JA2TXss9afWoF4wh0
hcWJBl7oalau1p1DyZAtOKvC8e1JBlFNNfv0i3qDQqHezkgy1I8O+JgsTOPrdp0/
WSqBGkP0jFtk9Z42+tpIVnAqIkUNXltYsnOz4CiU4fDpMndEb75OXY9F/e/f7d3Q
Q3eUnTReTyCx/lgh6wPsKRJP4j4v/1guLMvh/8ydKAyY7+SHbJgHJEmLgbpTXH7z
pTjMfhqkYVR6HKORRCqd7IuuOgIc/HZKRsw9eJujt4m0+XLPluEx3AqtE8WK0+5O
Jmt0wu+o6r2PENFOz3ux4W8xe8wGxWtbcwNJiCyeeM7u1fhQcBymLceXvdTQPi5W
TL3tDLGYwhXilo71Cw5trr3noH8LDF0p25/QPAr5VO+AG9itd9Qv51wlqQqp87JY

//pragma protect end_data_block
//pragma protect digest_block
ZoX8ZN+SVpfr9DpjqSiG8S7xoOY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AXI_PASSIVE_CACHE_LINE_SV
