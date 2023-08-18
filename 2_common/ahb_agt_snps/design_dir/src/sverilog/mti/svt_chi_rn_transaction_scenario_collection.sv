//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------
`ifndef GUARD_SVT_CHI_RN_TRANSACTION_SCENARIO_COLLECTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_SCENARIO_COLLECTION_SV


class chi_rn_write_read_directed_scenario extends svt_chi_rn_transaction_scenario;

  integer chi_rn_write_read_scenario;

  constraint readnosnp_directed_transaction 
  {
   ($void(scenario_kind) == chi_rn_write_read_scenario) ->
   {
    repeated == 0;
    length   == 2;
    
    items[0].addr        == 64'h0;
    items[0].xact_type   == svt_chi_rn_transaction::WRITENOSNPFULL;
    items[0].order_type  == svt_chi_rn_transaction::NO_ORDERING_REQUIRED;

    items[1].xact_type   == svt_chi_rn_transaction::READNOSNP;
    items[1].data_size   == items[0].data_size;

  }
  }
    
  function new();
    super.new();
        //
        //  Define scenarios using define_scenario() method of the scenario class.
       //  
    this.chi_rn_write_read_scenario = define_scenario("chi_rn_write_read_directed_scenario", 10);

    this.psdisplay();
    
  endfunction // new
endclass // chi_rn_write_read_directed_scenario

`endif //  `ifndef GUARD_SVT_CHI_RN_TRANSACTION_SCENARIO_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
k3mPqKoSiXZiDwtD8jiVT+q4zG7be/pz+I/A1R/NEvQdVFPIX2PgaXBfodZhiVR0
YIvwnqqsgKX2XaN+nMa/fx3p1U2PLQj04Cr4/tDCWCOXO2gu76CBjqyRfLAg+9Fl
JJ+PYW42xy4HfXihhJS+JYQdJk52BdTzds1L+Q5uBmw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 83        )
m/FeQm4/jxxrRrsy5m9aacHwjp2iiO/htofNzLHYoWkxQJ/zXY6tHI6mTo118yD/
OB/q1+RtBAOsQcroqsa5a4LNfNPYHKbApfnlxj/Rt4e/HmDUxO3TNkic0Ot3AzUX
`pragma protect end_protected
