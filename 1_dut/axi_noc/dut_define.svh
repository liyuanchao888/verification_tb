//	MACROS
`ifndef DUT_DEFINE__SVH
`define DUT_DEFINE__SVH

//	`define SLAVE_NO_DEFAULT	3'd0

  //-----------------------------------
  // DUT
  //-----------------------------------
  /// Number of AXI masters connected to the xbar. (Number of slave ports)
  parameter int unsigned TbNumMasters        = 32'd1;
  /// Number of AXI slaves connected to the xbar. (Number of master ports)
  parameter int unsigned TbNumSlaves         = 32'd1;
  /// Number of write transactions per master.
  parameter int unsigned TbNumWrites         = 32'd20;
  /// Number of read transactions per master.
  parameter int unsigned TbNumReads          = 32'd20;
  /// AXI4+ATOP ID width of the masters connected to the slave ports of the DUT.
  /// The ID width of the slaves is calculated depending on the xbar configuration.
  parameter int unsigned TbAxiIdWidthMasters = 32'd5;
  /// The used ID width of the DUT.
  /// Has to be `TbAxiIdWidthMasters >= TbAxiIdUsed`.
  parameter int unsigned TbAxiIdUsed         = 32'd3;
  /// Data width of the AXI channels.
  parameter int unsigned TbAxiDataWidth      = 32'd64;
  /// Pipeline stages in the xbar itself (between demux and mux).
  parameter int unsigned TbPipeline          = 32'd1;
  /// Enable ATOP generation
  parameter bit          TbEnAtop            = 1'b1;
  /// Enable exclusive accesses
  parameter bit TbEnExcl                     = 1'b0;   
  /// Restrict to only unique IDs         
  parameter bit TbUniqueIds                  = 1'b0; 

  // AXI configuration which is automatically derived.
  localparam int unsigned TbAxiIdWidthSlaves =  TbAxiIdWidthMasters + $clog2(TbNumMasters);
  localparam int unsigned TbAxiAddrWidth     =  32'd32;
  localparam int unsigned TbAxiStrbWidth     =  TbAxiDataWidth / 8;
  localparam int unsigned TbAxiUserWidth     =  5;
  // In the bench can change this variables which are set here freely,
  localparam axi_pkg::xbar_cfg_t xbar_cfg = '{
    NoSlvPorts:         TbNumMasters,
    NoMstPorts:         TbNumSlaves,
    MaxMstTrans:        10,
    MaxSlvTrans:        6,
    FallThrough:        1'b0,
    LatencyMode:        axi_pkg::CUT_ALL_AX,
    PipelineStages:     TbPipeline,
    AxiIdWidthSlvPorts: TbAxiIdWidthMasters,
    AxiIdUsedSlvPorts:  TbAxiIdUsed,
    UniqueIds:          TbUniqueIds,
    AxiAddrWidth:       TbAxiAddrWidth,
    AxiDataWidth:       TbAxiDataWidth,
    NoAddrRules:        TbNumSlaves
  };

  typedef axi_pkg::xbar_rule_32_t         rule_t; // Has to be the same width as axi addr

  function rule_t [xbar_cfg.NoAddrRules-1:0] addr_map_gen ();
    for (int unsigned i = 0; i < xbar_cfg.NoAddrRules; i++) begin
      addr_map_gen[i] = rule_t'{
        idx:        unsigned'(i),
        start_addr:  i    * 32'h0000_2000,
        end_addr:   (i+1) * 32'h0000_2000,
        default:    '0
      };
    end
  endfunction
  // Each slave has its own address range:
  localparam rule_t [xbar_cfg.NoAddrRules-1:0] AddrMap = addr_map_gen();

  
`endif 
