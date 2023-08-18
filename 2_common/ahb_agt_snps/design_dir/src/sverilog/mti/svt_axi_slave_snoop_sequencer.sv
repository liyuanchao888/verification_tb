
`ifndef GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Snoop Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_snoop_sequencer extends svt_sequencer #(svt_axi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;

  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_snoop_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
 extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_axi_slave_snoop_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ikgSb5CxKqDObdj0Z+h5/9vkd8JFsj94Q/L4VcV95tGOPqR+O/qZS633M08SVvab
dhvOGrQ1pBWI9MTZrtbgA8wyo8mT0RfJfrlU7v/zt0Looy85StvdE52A8IZiSQ6I
Zb7tV8GNf2efT9jYvY9EhoFghyqZ2B62lsuq06c6X4A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 536       )
9YSo2ZxXKuc+iRyi3q1VE6SdvKTjc83ls+pYcx/PTOwvHUeOvK62tEcH+4IpGLHR
1bbcHp/5PtngmI3ZJON8VZpIfbFlLiGFLLsh3PTc43ctkyaG78TPy456ortghuVY
q31qW55p514xSjUbhfQkrmnhA3oMFMiFhbroyKEpYLsUJ25Z3f2hU+/1ik9XLMOZ
5u/A7my4QI0MSvq7Xfgn/kr51hScQcb5vSG9Z0PvKXCjDFKIm3bgGNzhoNrU5L0+
vxYY7PKZ2a18hmsowwC+PtStXgOtxB6fK+QeNc2IvtSTAisnzTArMhoRJM1Leh/B
neGmislLgjZHzyFh+zCQW2D77QLKErfPz9xrIDrrkH3jIImRSlx9wNjULKfC/N2X
80sajuQR5EQAKmnJZTRG5aK7mzrK9vgh700FAuUt7sDRt8WkAsrgdz+/fxX3vqab
PdBvjUaU7TgHnbG722PWEyoeIEi+Y8RfDJ4frhsOn3qUb2u5MCPZeFEQihTobsHA
s63jnCKsUEKW3J73d7Gg+7aimClhqx5D+MAtbIEvybHv24wJuJgb+sLiUkwOjhfi
U9/gDSeKchM4VST9UTASBEAsRz4SCb4MVbB0Fyc7BOrwm/GKZi2ueHTz4WQs95vl
C/HOJewsx0XZR/hq2h7BMPVZx5UA7uIrLNG8XdfudMNgIqf9E85aSuVxSL708m9D
0SHW8joknEj+K9i35D2srQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gf6F/F0MiQU3L+Wlq6L1GTYUMgytQsLOBux9ndbMU6nyhLEzgdI9WnC5MCawRNU8
/+CvKuR0rd2Bs3rCCAztiuoBJeFZ4ghC4L6Dq7ozihlUAd3G0e9SxuZyAgwss0vw
juu08gK+sFzthhxRnbRYKgn5WWbRNJKRSldwOEb+TPA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2376      )
8/xVuuYvA4cEFgV6jRFYDTTQyTOwRHA1xL1U+VO657wzv+iY5g1kRhmMdX3zMHst
tYxIFhPAC+SxKRvroXlRyGbOk7EhiKy5Px4O6Xo2pFNQGy52gUZTLCFN+3L9wucl
E6SWrI2O9qzwoKtPHZ31hEiDO701vyaJ4yRVKjQhL/6t1w5YmOowvACnapIflTOD
4p+G7xGhVH3hNI5zOtlXMDXlqf9vBmdpjw9i1nJuc9KCKZWtt800hN1ygmkPXkUu
JzJMZyYBZzu4RiFMtN9tg40CWXfLwlIjk4md36b/PBB4OJpI2v20POk5WTQ9g6ze
M5pKdvat3JWOnPRbAZv3j1uTRkHECKhxrM33FmDVWnKkXR1nNfztQHvYbbLZ20aY
in9xM6CIC2zliXFuYBAAeZdFlbTgKRRK6+CpAqBNcEgnl1/ToJ5x+AhXRuIk4jXs
Avln2AOUIFic4evOPC+SIUn9kLH52p3K84SAM/Bz3Z90cjCaNY4U6XcshdVyRx5c
BeM80XkztS06LWwmoL7HboAhnJH+kzYNtvux9jI7Fb6zCRrq1fpWMfPKNmb0lN8E
SAnhBqJKSVrbP++zFGTuODCIb9K/jFU5U0O2/MlDWawOEyJvb2LJXrka1g4UwqP7
9Bpy+25gV51s2viSJSiPJpqLgSgU4vzjnz6l5XRtDFLh9BKzFpbOYSqQcKHiV6+/
XbICEf05rumxLpyGUpFbPr7oZ5uNGTvYObtHCXzBI10H6EHwAD/b2HB/zljuBumA
yGjyzvyBfI+N018bw1R3QeO+9dmnItneE+/5StxjHiO17bWiegd1szxhSlySAGEa
Yc7GbUjTvJ0XSTua3rQ42ssiQCJA2OwIRI+F288usUedLB6TKp15x8JOBI8M6qGp
b4JeddTY0czFU/wtZwPeksG/YCq79oPRgdHQjPkfc8bWRMS1OovqCf95qjQmiW9G
T6udNHtw1DaE4SKjD2tFGYTP5M4WgJh6VQX9r/FsMgrcG/X2kfyS5wng5x/qclsx
o7GDflyDY79+BEu8tUdSsBea4RHwRioYOWhizbPff6VbecJWxGHLh4J74tf8GU1r
/q1+L6xpTO5lxu7/FzuiHpMWPAa5Ri1Rr0rDwOw63ntu6s6pR5xZaJiSFnKAgJLo
z0OkyFDrb4q3MLY1T+tYm+wK6U73B+iN6pYEua4gDRmWWskeZKz9a+4B6i274br0
Lzwb0jMZniwBijuNoymeOQ8yh9xzxxVZVJEGTTD1hAIMgAVJA6bGE5N/mUuWIG1H
PFS4+FgYCI9BTkqqKM8FlyK0YFXM0pu2l3oKEAVN4ekyxi8zFZfFbAhL44XcWufs
LY/0oHhiAzWs1Ue7nl1sWqmxbXrW8kHhfF1EA/tJDoNK0eDbmPtz9abw5/B2+A5l
TUXysPq5oBWponNbdayMiPvsxUzTs8k3JCKN2wqNNbqgXjRn+MCFZH/7dLLgQf4a
6hxXu/xlWqnXkLzrJGUj63rQJs9b6zMa8TKOmNfzrJ3Ofd/TSYVL/rNyeigqJ8Ul
WlcAborc93eI0SBSLuM9yuQJls/ca8Ue3zS0lyhjC8R0tHv/R+M3vazLnGOTIHQs
Bqeo5tTgDpWKqO+5ql/doS2EsmAYE/jAWGHICfPePrBZTo2chTZ3H/aKC+UhQmEg
NYsQXtDW120VkYlvE6qnYcsF/LI8k6R+6uT8uRUsL1kuOSsB558yhmBZTIfOYMuV
yv48WVDDkk3zleOMIuUoqLTyvHp7ahV6BxGl3M3nEhHnHFlM8Jm3WCeK+QPcxPq5
FUIpxgG8x1tJKN56yp0SyCFoweOcnYBya29AbCBjkYVdrwJUWb1w5K8eRL3a8OJ+
v38kWOCr3As4h0XoTNvqGovl3an4OP/ZE3cxJTIJNbqRFbXn1AWJXP7q7FV171st
I25mB4umVSHPckoOxf4MKqAAah0BDAjlfR4L1Ps0aQ04vzIQr+pTNNXpm9bqAorj
7B4rstcm6oEdbogenGCpFUcAK5oQli2nwaH9HsJ+7ECzNrU8KzUxnhQW8W9f7Vz6
aqkNwhHGzsXYaixpL4qzoDtHsXYzz3B5ZNYeyb77Itzbh9VdbLLa7cTbI5O/6QXC
IAxKYYhcob5RtsJ3kqfkigdAVOs3DzGBgLZlUEKO/YlPey+htbl6pRIyValwnZGV
ufES3q+ogsHpAh5T67J0FLGCYv3FEPtQ3TkkU548r6Tb+3Bd83ePISVSBzxrpjTv
JyKW9F2UW7m2BzZYPrD9kZF3B4Owc5PYed/4XKnWPG0LXrJIkslQno+HUKveGY0/
u2dyxi29ubRAFnH4AP1mmfCNssH9CKGCN8K96Kuu8vmMKjDj9Z+foUtrZuAL3+iO
VySrFHr2uqM0aYoNYpPb8qtX6MnLAOFiOPaZS01N+6iLNF9sOulCkupJOMG+BGDB
H3+9OdhZ+pl/OAeXsLBCdejCIapqzCZgD5BRzyio80I=
`pragma protect end_protected

`endif // GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GMXpsY2Ho+mt5srUdQBvjL+1G4o+rRMjZOM2G0wAgIpNiVQl8zRdeCxUZLJMJdSH
27vQTYxey8r4qfmqzEFH1wdDTq2QlfgRyG1KVjA6nNcqJHIRGZCeOAZ0VniGjNTM
QxfFYmW7BH0h7lV6XUYFaI56Z22etEC+ETe8iys5jnU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2459      )
kvH9PGk3nUZYWUYyfheJWTjBJTeIvKnu9MMrXbTmbEvoa8e5qalB6lyOUH7z1suQ
E00/ljnRMzd6Qgdw09FMP4e6gg3X6OKxDGxVscx4QFMecK2WgwFCrIlS6elA3DDG
`pragma protect end_protected
