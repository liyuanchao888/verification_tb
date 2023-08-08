`ifndef GUARD_SVT_AXI_SYSTEM_MONITOR_EXT_COV_DEFINITIONS 
`define GUARD_SVT_AXI_SYSTEM_MONITOR_EXT_COV_DEFINITIONS 

`ifndef __SVDOC__
/**
  * Covergroup: system_ace_lite__ace_lite_overlapping_writes
  *
  * Coverpoints:
  *
  * - ace_lite_port0_xact_type: Covers various transaction types in ACE-Lite port 0.
  *.
  * - ace_lite_port_1_xact_type: Covers various transaction types in ACE-Lite port 1
  *.
  */
covergroup system_ace_lite__ace_lite_overlapping_writes (ref svt_axi_transaction::coherent_xact_type_enum port0_xact_type, ref svt_axi_transaction::coherent_xact_type_enum port1_xact_type);
   ace_lite_port0_xact_type: coverpoint port0_xact_type {
     bins port0_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port0_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port0_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
   }
   ace_lite_port1_xact_type: coverpoint port1_xact_type {
     bins port1_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port1_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port1_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
   }
   port0_port1_write_xact_type_cross: cross ace_lite_port0_xact_type, ace_lite_port1_xact_type {
     option.weight = 1;
   }
   option.per_instance = 1;
 endgroup

/**
  * Covergroup: system_ace__ace_lite_overlapping_writes
  *
  * Coverpoints:
  *
  * - ace_port0_xact_type: Covers various transaction types in AXI_ACE Lite port 0.
  *.
  * - ace_lite_port_1_xact_type: Covers various transaction types in ACE-Lite port 1
  *.
  */
 
covergroup system_ace__ace_lite_overlapping_writes (ref svt_axi_transaction::coherent_xact_type_enum port0_xact_type, ref svt_axi_transaction::coherent_xact_type_enum port1_xact_type);
   ace_port0_xact_type: coverpoint port0_xact_type {
     bins port0_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port0_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port0_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
     bins port0_writeback_xact_type = {svt_axi_transaction::WRITEBACK};
     bins port0_writeclean_xact_type = {svt_axi_transaction::WRITECLEAN};
     bins port0_writeevict_xact_type = {svt_axi_transaction::WRITEEVICT};
   }
   ace_lite_port1_xact_type: coverpoint port1_xact_type {
     bins port1_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port1_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port1_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
   }
   port0_port1_write_xact_type_cross: cross ace_port0_xact_type, ace_lite_port1_xact_type {
     option.weight = 1;
   }
   option.per_instance = 1;
 endgroup

/**
  * Covergroup: system_ace__ace_overlapping_writes
  *
  * Coverpoints:
  *
  * - ace_port0_xact_type: Covers various transaction types in AXI_ACE port 0.
  *.
  * - ace_port_1_xact_type: Covers various transaction types in AXI_ACE port 1
  *.
  */
 
covergroup system_ace__ace_overlapping_writes (ref svt_axi_transaction::coherent_xact_type_enum port0_xact_type, ref svt_axi_transaction::coherent_xact_type_enum port1_xact_type);
   ace_port0_xact_type: coverpoint port0_xact_type {
     bins port0_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port0_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port0_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
     bins port0_writeback_xact_type = {svt_axi_transaction::WRITEBACK};
     bins port0_writeclean_xact_type = {svt_axi_transaction::WRITECLEAN};
     bins port0_writeevict_xact_type = {svt_axi_transaction::WRITEEVICT};
   }
   ace_port1_xact_type: coverpoint port1_xact_type {
     bins port1_writenosnoop_xact_type = {svt_axi_transaction::WRITENOSNOOP};
     bins port1_writeunique_xact_type = {svt_axi_transaction::WRITEUNIQUE};
     bins port1_writelineunique_xact_type = {svt_axi_transaction::WRITELINEUNIQUE};
     bins port1_writeback_xact_type = {svt_axi_transaction::WRITEBACK};
     bins port1_writeclean_xact_type = {svt_axi_transaction::WRITECLEAN};
     bins port1_writeevict_xact_type = {svt_axi_transaction::WRITEEVICT};
   }
   port0_port1_write_xact_type_cross: cross ace_port0_xact_type, ace_port1_xact_type {
     option.weight = 1;
   }
   option.per_instance = 1;
 endgroup
 `endif
 `endif

