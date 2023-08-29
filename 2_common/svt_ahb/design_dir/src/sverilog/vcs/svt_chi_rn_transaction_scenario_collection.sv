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
