
`ifndef GUARD_SVT_AXI_PORT_MONITOR_XML_WRITER_CALLBACK_UVM_SV
`define GUARD_SVT_AXI_PORT_MONITOR_XML_WRITER_CALLBACK_UVM_SV

// =============================================================================
/**
 * The svt_axi_xml_transaction_timing class collects transaction timing information.
 */

class svt_axi_xml_transaction_timing;

  svt_axi_transaction transaction;

  string transaction_uid;
  string channel_name;

  real   start_time                  = 0;
  real   end_time                    = 0;

  real   new_transaction_started     = 0;
  real   read_address_phase_started  = 0;
  real   read_address_phase_ended    = 0;
  real   read_data_phase_started     = 0;
  real   read_data_phase_ended       = 0;
  real   write_address_phase_started = 0;
  real   write_address_phase_ended   = 0;
  real   write_data_phase_started    = 0;
  real   write_data_phase_ended      = 0;
  real   write_resp_phase_started    = 0;
  real   write_resp_phase_ended      = 0;
  real   coherent_transaction_ended      = 0;
  real   stream_transfer_started     = 0;
  real   stream_transfer_ended     = 0;
`ifdef SVT_ACE5_ENABLE
  real   atomic_transaction_ended = 0;
`endif
  // -----------------------------------------------------------------------------

  function new( string transaction_uid, svt_axi_transaction transaction, string channel_name );
    begin

      this.transaction     = transaction;
      this.transaction_uid = transaction_uid;
      this.channel_name    = channel_name;

      new_transaction_started = $realtime;
    end
  endfunction

endclass : svt_axi_xml_transaction_timing

// =============================================================================
/**
 * The svt_axi_snoop_xml_transaction_timing class collects snoop_transaction timing information.
 */

class svt_axi_snoop_xml_transaction_timing;

  svt_axi_snoop_transaction snoop_transaction;

  string snoop_transaction_uid;
  string snoop_channel_name;

  real   start_time                    = 0;
  real   end_time                      = 0;

  real   new_snoop_transaction_started = 0;
  real   snoop_address_phase_started   = 0;
  real   snoop_address_phase_ended     = 0;
  real   snoop_data_phase_started      = 0;
  real   snoop_data_phase_ended        = 0;
  real   snoop_resp_phase_started      = 0;
  real   snoop_resp_phase_ended        = 0;

  // -----------------------------------------------------------------------------

  function new( string snoop_transaction_uid,svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name );
    begin


      this.snoop_transaction     = snoop_transaction;
      this.snoop_transaction_uid = snoop_transaction_uid;
      this.snoop_channel_name    = snoop_channel_name;

      new_snoop_transaction_started = $realtime;
    end
  endfunction

endclass : svt_axi_snoop_xml_transaction_timing

// =============================================================================
/**
 * The svt_axi_xml_writer class provides functionality for writing an XML file that
 * contains information about the specified objects to be read by the Protocol
 * Analyzer.
 */

class svt_axi_xml_writer;

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log = new( "svt_axi_xml_writer", "CLASS" );
`else
  static svt_non_abstract_report_object reporter;
`endif

  string inst_name  = "";
  string file_name  = "";
  int    file       = 0;
  int    xact_count = 0;
  
  svt_axi_xml_transaction_timing transaction_timing_queue[ $ ];
  string                         transaction_uid_queue[ $ ];

  svt_axi_snoop_xml_transaction_timing snoop_transaction_timing_queue[ $ ];
  string                         snoop_transaction_uid_queue[ $ ];

  svt_axi_xml_transaction_timing last_read_addr_timing        = null;
  svt_axi_transaction            last_read_addr_transaction   = null;
  string                         last_read_addr_channel_name  = "";

  svt_axi_xml_transaction_timing last_read_data_timing        = null;
  svt_axi_transaction            last_read_data_transaction   = null;
  string                         last_read_data_channel_name  = "";

  svt_axi_xml_transaction_timing last_write_addr_timing       = null;
  svt_axi_transaction            last_write_addr_transaction  = null;
  string                         last_write_addr_channel_name = "";

  svt_axi_xml_transaction_timing last_write_data_timing       = null;
  svt_axi_transaction            last_write_data_transaction  = null;
  string                         last_write_data_channel_name = "";

  svt_axi_snoop_xml_transaction_timing last_snoop_addr_timing = null;
  svt_axi_snoop_transaction      last_snoop_addr_transaction  = null;
  string                         last_snoop_addr_channel_name = "";

  svt_axi_snoop_xml_transaction_timing last_snoop_data_timing = null;
  svt_axi_snoop_transaction      last_snoop_data_transaction  = null;
  string                         last_snoop_data_channel_name = "";

  svt_axi_xml_transaction_timing last_stream_transfer_timing       = null;
  svt_axi_transaction            last_stream_data_transaction  = null;
  string                         last_stream_data_channel_name = "";


  // -----------------------------------------------------------------------------

  function new( string inst_name, string file_name );
    begin
      this.inst_name = inst_name;
      this.file_name = file_name;

`ifdef SVT_UVM_TECHNOLOGY
      reporter = new ( inst_name );
`elsif SVT_OVM_TECHNOLOGY
      reporter = new ( inst_name );
`else
      log = new( inst_name, "CLASS" );
`endif

      open_file();
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void open_file();
    begin
      // Return if the file is already open.
      if ( file != 0 )
        return;

`ifdef SVT_UVM_TECHNOLOGY
      `uvm_info("open_file", $sformatf( "Opening file '%0s'", file_name ), UVM_HIGH );
`elsif SVT_OVM_TECHNOLOGY
      `ovm_info("open_file", $sformatf( "Opening file '%0s'", file_name ), OVM_HIGH );
`else
      `vmm_note(log, $sformatf( "Opening file '%0s'", file_name ));
`endif

      file = $fopen( file_name, "w" );

      $fwrite( file, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" );
      $fwrite( file, "<objects protocol=\"amba_svt axi_svt\" instance=\"%0s\">\n",inst_name );
    end
  endfunction


  // -----------------------------------------------------------------------------

`define PA_WRITE_INT_ARRAY_FIELD_TO_FILE(object_type,field_name) \
        begin \
          string temp_str = ""; \
          foreach( object_type.field_name[i] ) \
            begin \
              if ( temp_str != "" ) \
                temp_str = { temp_str, ", " }; \
              temp_str = { temp_str, $sformatf( "%0d", object_type.field_name[i] ) }; \
            end \
          `PA_WRITE_FIELD_VALUE_TO_FILE(field_name,temp_str) \
        end

`define PA_WRITE_TIME_ARRAY_FIELD_TO_FILE(object_type,field_name) \
        begin \
          string temp_str = ""; \
          foreach( object_type.field_name[i] ) \
            begin \
              if ( temp_str != "" ) \
                temp_str = { temp_str, ", " }; \
              temp_str = { temp_str, $sformatf( "%0.0f", object_type.field_name[i] ) }; \
            end \
          `PA_WRITE_FIELD_VALUE_TO_FILE(field_name,temp_str) \
        end

`define PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(object_type,field_name,nibble_cnt) \
        begin \
          string temp_str = ""; \
          foreach( object_type.field_name[i] ) \
            begin \
              if ( temp_str != "" ) \
                temp_str = { temp_str, ", " }; \
              temp_str = { temp_str, $sformatf( { "0x%", `"nibble_cnt`", "h" }, object_type.field_name[i] ) }; \
            end \
          `PA_WRITE_FIELD_VALUE_TO_FILE(field_name,temp_str) \
        end

`define PA_WRITE_ENUM_ARRAY_FIELD_TO_FILE(object_type,field_name) \
        begin \
          string temp_str = ""; \
          foreach( object_type.field_name[i] ) \
            begin \
              if ( temp_str != "" ) \
                temp_str = { temp_str, ", " }; \
              temp_str = { temp_str, $sformatf( "%0s", object_type.field_name[i].name() ) }; \
            end \
          `PA_WRITE_FIELD_VALUE_TO_FILE(field_name,temp_str) \
        end

`define PA_WRITE_TIME_FIELD_TO_FILE(object_type,field_name) \
        write_field_value( `"field_name`", $sformatf( "%0.0f", object_type.field_name ), field_indent );

`define PA_WRITE_INT_FIELD_TO_FILE(object_type,field_name) \
        write_field_value( `"field_name`", $sformatf( "%0d", object_type.field_name ), field_indent );

`define PA_WRITE_BIT_FIELD_TO_FILE(object_type,field_name) \
        write_field_value( `"field_name`", $sformatf( "%0d", object_type.field_name ), field_indent );

`define PA_WRITE_BITVEC_FIELD_TO_FILE(object_type,field_name,nibble_cnt) \
        write_field_value( `"field_name`", $sformatf( { "0x%", `"nibble_cnt`", "h" }, object_type.field_name ), field_indent );

`define PA_WRITE_ENUM_FIELD_TO_FILE(object_type,field_name) \
        write_field_value( `"field_name`", $sformatf( "%0s", object_type.field_name.name() ), field_indent );

`define PA_WRITE_INT_FIELD_VALUE_TO_FILE(field_name,field_value) \
        write_field_value( `"field_name`", $sformatf( "%0d", field_value ), field_indent );

`define PA_WRITE_ENUM_FIELD_VALUE_TO_FILE(field_name,field_value) \
        write_field_value( `"field_name`", $sformatf( "%0s", field_value.name() ), field_indent );

`define PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(field_name,field_value,nibble_cnt) \
        write_field_value( `"field_name`", $sformatf( { "0x%", `"nibble_cnt`", "h" }, field_value ), field_indent );

`define PA_WRITE_FIELD_VALUE_TO_FILE(field_name,field_value) \
        write_field_value( `"field_name`", field_value, field_indent );

`define PA_WRITE_BITVEC_FIELD_EXPECTED_TO_FILE(object_type,field_name,nibble_cnt,field_expected_value) \
        begin \
          write_field_value_w_expected( `"field_name`", \
          $sformatf( { "0x%", `"nibble_cnt`", "h" }, object_type.field_name ), \
          $sformatf( { "0x%", `"nibble_cnt`", "h" }, field_expected_value ), \
          field_indent ); \
        end

`define PA_WRITE_FIELD_VALUE_EXPECTED_TO_FILE(object_type,field_name,field_value,field_expected_value) \
        write_field_value_w_expected( `"field_name`", field_value, field_expected_value, field_indent );

  // -----------------------------------------------------------------------------

  function void new_transaction_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing;
      string transaction_uid;
      string transaction_base_uid;

      transaction_timing = find_transaction_timing( transaction, channel_name, 0 );

      if ( transaction_timing != null )
        begin
          if ( ( transaction.xact_type == svt_axi_transaction::WRITE ) &&
               ( transaction_timing.write_resp_phase_ended == 0 ) )
            return;

          if ( ( transaction.xact_type == svt_axi_transaction::COHERENT ) &&
               ( ( transaction.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP )    ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE )     ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE ) ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::WRITECLEAN )      ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::WRITEBACK )       ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::EVICT )           ||
                 ( transaction.coherent_xact_type == svt_axi_transaction::WRITEBARRIER ) ) &&
               ( transaction_timing.coherent_transaction_ended == 0 ) )
            return;
        `ifdef SVT_ACE5_ENABLE
          if ( ( transaction.xact_type == svt_axi_transaction::ATOMIC ) &&
               ( ( transaction.atomic_transaction_type == svt_axi_transaction::STORE )    ||
                 ( transaction.atomic_transaction_type == svt_axi_transaction::LOAD )     ||
                 ( transaction.atomic_transaction_type == svt_axi_transaction::SWAP ) ||
                 ( transaction.atomic_transaction_type == svt_axi_transaction::COMPARE ) ) &&
               ( transaction_timing.atomic_transaction_ended == 0 ) )
            return;
        `endif
          write_transaction( transaction_timing.transaction, transaction_timing );

          // Remove the timing object from the queue.
          remove_transaction_timing( transaction, channel_name );
        end

      transaction_base_uid = get_transaction_uid( transaction, channel_name, 1 );
      transaction_uid_queue.push_back( transaction_base_uid );

      transaction_uid = get_transaction_uid( transaction, channel_name );
      transaction_timing = new( transaction_uid, transaction, channel_name );
      transaction_timing_queue.push_back( transaction_timing );

      // write_comment( $sformatf( "%0s: new_transaction_started @ %0.0f", transaction_timing.transaction_uid, $realtime ) );
    end
  endfunction

// ------------------------------------------------------------------------------------------------

 function void new_snoop_transaction_started( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name );
    begin
      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing;
      string snoop_transaction_uid;
      string snoop_transaction_base_uid;

      snoop_transaction_timing = find_snoop_transaction_timing( snoop_transaction, snoop_channel_name, 0 );

      if ( snoop_transaction_timing!= null )
        begin
          if ( snoop_transaction_timing.snoop_resp_phase_ended == 0 ) 
            return;

          write_snoop_transaction( snoop_transaction_timing.snoop_transaction, snoop_transaction_timing);

          // Remove the timing object from the queue.
          remove_snoop_transaction_timing( snoop_transaction, snoop_channel_name);
        end

      snoop_transaction_base_uid = get_snoop_transaction_uid( snoop_transaction, snoop_channel_name, 1 );
      snoop_transaction_uid_queue.push_back( snoop_transaction_base_uid);

      snoop_transaction_uid = get_snoop_transaction_uid( snoop_transaction, snoop_channel_name);
      snoop_transaction_timing= new( snoop_transaction_uid, snoop_transaction, snoop_channel_name);
      snoop_transaction_timing_queue.push_back( snoop_transaction_timing);

      // write_comment( $sformatf( "%0s: new_transaction_started @ %0.0f",
      // snoop_transaction_timing.snoop_transaction_uid, $realtime ) );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function svt_axi_xml_transaction_timing find_transaction_timing( svt_axi_transaction transaction, string channel_name, bit create = 1 );
    begin
      string transaction_uid;
      string transaction_base_uid;

      svt_axi_xml_transaction_timing transaction_timing;
      svt_axi_xml_transaction_timing find_results[ $ ];

      string uid = get_transaction_uid( transaction, channel_name );
      find_results = transaction_timing_queue.find_first with ( item.transaction_uid == uid );

      if ( find_results.size() > 0 )
        begin
          transaction_timing = find_results[ 0 ];
          return transaction_timing;
        end

      if (create == 1 )
        begin
          // write_comment( $sformatf( "Could not find transaction with uid '%0s' @ %0.0f", uid, $realtime ) );

          transaction_base_uid = get_transaction_uid( transaction, channel_name, 1 );
          transaction_uid_queue.push_back( transaction_base_uid );

          transaction_uid = get_transaction_uid( transaction, channel_name );
          transaction_timing = new( transaction_uid, transaction, channel_name );
          transaction_timing_queue.push_back( transaction_timing );

          return transaction_timing;
        end

      return null;
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function svt_axi_snoop_xml_transaction_timing find_snoop_transaction_timing(svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name, bit create = 1 );
    begin
      string snoop_transaction_uid;
      string snoop_transaction_base_uid;

      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing;
      svt_axi_snoop_xml_transaction_timing find_results[ $ ];

      string snoop_uid = get_snoop_transaction_uid( snoop_transaction, snoop_channel_name);
      find_results = snoop_transaction_timing_queue.find_first with ( item.snoop_transaction_uid== snoop_uid);

      if ( find_results.size() > 0 )
        begin
          snoop_transaction_timing= find_results[ 0 ];
          return snoop_transaction_timing;
        end

      if (create == 1 )
        begin
          // write_comment( $sformatf( "Could not find snoop_transaction with snoop_uid '%0s' @ %0.0f", snoop_uid, $realtime ) );

          snoop_transaction_base_uid= get_snoop_transaction_uid( snoop_transaction, snoop_channel_name, 1 );
          snoop_transaction_uid_queue.push_back( snoop_transaction_base_uid);

          snoop_transaction_uid= get_snoop_transaction_uid( snoop_transaction, snoop_channel_name);
          snoop_transaction_timing= new( snoop_transaction_uid, snoop_transaction, snoop_channel_name);
          snoop_transaction_timing_queue.push_back( snoop_transaction_timing);

          return snoop_transaction_timing;
        end

      return null;
    end
  endfunction
 
  // -----------------------------------------------------------------------------

  function string get_transaction_uid( svt_axi_transaction transaction, string channel_name, bit get_base_uid = 0 );
    begin
      string find_results[ $ ];
      int count;

      string uid = { "transaction_", $sformatf( "%0s_%1h_%16h", channel_name, transaction.id, transaction.addr ) };

      if ( get_base_uid )
        return uid;

      find_results = transaction_uid_queue.find with ( item == uid );
      count = find_results.size();

      //if ( count > 0 )
        uid = $sformatf( "%0s_%0d", uid, count );

      return uid;
    end
  endfunction

  // -----------------------------------------------------------------------------
  
   function string get_snoop_transaction_uid( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name, bit get_base_uid = 0 );
    begin
      string find_results[ $ ];
      int count;

      string snoop_uid= { "transaction_", $sformatf( "%0s_%16h", snoop_channel_name, snoop_transaction.snoop_addr) }; 
      if ( get_base_uid )
        return snoop_uid;

      find_results = snoop_transaction_uid_queue.find with ( item == snoop_uid);
      count = find_results.size();

      //if ( count > 0 )
        snoop_uid= $sformatf( "%0s_%0d", snoop_uid, count );

      return snoop_uid;
    end
  endfunction
  
  // -----------------------------------------------------------------------------

  function void remove_transaction_timing( svt_axi_transaction transaction, string channel_name );
    begin
      int find_results[ $ ];

      string uid = get_transaction_uid( transaction, channel_name );
      find_results = transaction_timing_queue.find_first_index with ( item.transaction_uid == uid );

      if ( find_results.size() == 0 )
        begin
          write_comment( $sformatf( "Could not find index of transaction with uid '%0s' @ %0.0f", uid, $realtime ) );
          return;
        end

      transaction_timing_queue.delete( find_results[ 0 ] );
    end
  endfunction

  // -----------------------------------------------------------------------------
    
 function void remove_snoop_transaction_timing( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      int find_results[ $ ];

      string snoop_uid= get_snoop_transaction_uid( snoop_transaction, snoop_channel_name);
      find_results = snoop_transaction_timing_queue.find_first_index with ( item.snoop_transaction_uid== snoop_uid);

      if ( find_results.size() == 0 )
        begin
          write_comment( $sformatf( "Could not find index of snoop_transaction with snoop_uid '%0s' @ %0.0f", snoop_uid, $realtime ) );
          return;
        end

      snoop_transaction_timing_queue.delete( find_results[ 0 ] );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void read_address_phase_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( last_read_addr_timing != transaction_timing )
        return;

      last_read_addr_timing = null;

      transaction_timing.read_address_phase_ended = $realtime;

      bus_activity_type_name  = "axi_bus_read_address";
      bus_activity_channel    = "RADDR";
      bus_activity_start_time = transaction_timing.read_address_phase_started;
      bus_activity_end_time   = transaction_timing.read_address_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void read_address_phase_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      transaction_timing.read_address_phase_started = $realtime;
      transaction_timing.start_time = $realtime;

      if ( last_read_addr_timing != null )
        read_address_phase_ended( last_read_addr_transaction, last_read_addr_channel_name );

      last_read_addr_timing = transaction_timing;
      last_read_addr_transaction = transaction;
      last_read_addr_channel_name = channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void read_data_phase_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      int            data_index;
      logic [1023:0] data_value;
 
      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( last_read_data_timing != transaction_timing )
        return;

      last_read_data_timing = null;

      transaction_timing.read_data_phase_ended = $realtime;
      transaction_timing.end_time = $realtime;

      bus_activity_type_name  = "axi_bus_read_data";
      bus_activity_channel    = "RDATA";
      bus_activity_start_time = transaction_timing.read_data_phase_started;
      bus_activity_end_time   = transaction_timing.read_data_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)
      
      data_index = transaction.current_data_beat_num;

      `PA_WRITE_INT_FIELD_VALUE_TO_FILE(data_index, data_index)
      
      data_value = transaction.data[ data_index ];

      // Use the burst size to determine the width of the data value.
      if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_8BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,2)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_16BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,4)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_32BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,8)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_64BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,16)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_128BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,32)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_256BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,64)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_512BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,128)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_1024BIT ) 
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,256)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_2048BIT ) 
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,512)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void read_data_phase_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );
      transaction_timing.read_data_phase_started = $realtime;

      if ( last_read_data_timing != null )
        read_data_phase_ended( last_read_data_transaction, last_read_data_channel_name );

      last_read_data_timing = transaction_timing;
      last_read_data_transaction = transaction;
      last_read_data_channel_name = channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_address_phase_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( last_write_addr_timing != transaction_timing )
        return;

      last_write_addr_timing = null;

      transaction_timing.write_address_phase_ended = $realtime;

      bus_activity_type_name  = "axi_bus_write_address";
      bus_activity_channel    = "WADDR";
      bus_activity_start_time = transaction_timing.write_address_phase_started;
      bus_activity_end_time   = transaction_timing.write_address_phase_ended;

      if ( bus_activity_start_time == 0 )
        return;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_address_phase_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      transaction_timing.write_address_phase_started = $realtime;
      transaction_timing.start_time = $realtime;

      if ( last_write_addr_timing != null )
        write_address_phase_ended( last_write_addr_transaction, last_write_addr_channel_name );

      last_write_addr_timing = transaction_timing;
      last_write_addr_transaction = transaction;
      last_write_addr_channel_name = channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_data_phase_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      int            data_index;
      logic [1023:0] data_value;

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( last_write_data_timing != transaction_timing )
        return;

      last_write_data_timing = null;

      transaction_timing.write_data_phase_ended = $realtime;

      bus_activity_type_name  = "axi_bus_write_data";
      bus_activity_channel    = "WDATA";
      bus_activity_start_time = transaction_timing.write_data_phase_started;
      bus_activity_end_time   = transaction_timing.write_data_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)
      
      data_index = transaction.current_data_beat_num;
      `PA_WRITE_INT_FIELD_VALUE_TO_FILE(data_index,data_index)
      
      data_value = transaction.data[ data_index ];

      // Use the burst size to determine the width of the data value.
      if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_8BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,2)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_16BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,4)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_32BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,8)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_64BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,16)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_128BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,32)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_256BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,64)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_512BIT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,128)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_1024BIT ) 
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,256)
      else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_2048BIT ) 
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(data,data_value,512)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_data_phase_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      transaction_timing.write_data_phase_started = $realtime;

      if ( last_write_data_timing != null )
        write_data_phase_ended( last_write_data_transaction, last_write_data_channel_name );

      last_write_data_timing = transaction_timing;
      last_write_data_transaction = transaction;
      last_write_data_channel_name = channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_resp_phase_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      transaction_timing.write_resp_phase_ended = $realtime;
      transaction_timing.end_time = $realtime;

      bus_activity_type_name  = "axi_bus_write_response";
      bus_activity_channel    = "WRESP";
      bus_activity_start_time = transaction_timing.write_resp_phase_started;
      bus_activity_end_time   = transaction_timing.write_resp_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_resp_phase_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( transaction_timing != null )
        transaction_timing.write_resp_phase_started = $realtime;
    end
  endfunction

  function void transaction_ended( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( transaction.xact_type == svt_axi_transaction::COHERENT )
    begin
        transaction_timing.coherent_transaction_ended = $realtime;
        transaction_timing.end_time = $realtime;
    end
  `ifdef SVT_ACE5_ENABLE
      if ( transaction.xact_type == svt_axi_transaction::ATOMIC )
    begin
        transaction_timing.atomic_transaction_ended = $realtime;
        transaction_timing.end_time = $realtime;
    end
  `endif
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_address_phase_ended( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);

      if ( last_snoop_addr_timing != snoop_transaction_timing)
        return;

      last_snoop_addr_timing = null;

      snoop_transaction_timing.snoop_address_phase_ended= $realtime;

      bus_activity_type_name  = "ace_bus_address";
      bus_activity_channel    = "SNOOP_ADDR";
      bus_activity_start_time = snoop_transaction_timing.snoop_address_phase_started;
      bus_activity_end_time   = snoop_transaction_timing.snoop_address_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     snoop_transaction_timing.snoop_transaction_uid);

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(snoop_transaction,snoop_addr,16)  

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void snoop_address_phase_started( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);

      snoop_transaction_timing.snoop_address_phase_started= $realtime;
      snoop_transaction_timing.start_time = $realtime;

      if ( last_snoop_addr_timing != null )
        snoop_address_phase_ended( last_snoop_addr_transaction, last_snoop_addr_channel_name );

      last_snoop_addr_timing = snoop_transaction_timing;
      last_snoop_addr_transaction = snoop_transaction;
      last_snoop_addr_channel_name = snoop_channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void snoop_data_phase_ended( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      int             snoop_data_index;
      logic [16383:0] snoop_data_value;

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;
      string temp_snoop_data;

      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);

      if ( last_snoop_data_timing != snoop_transaction_timing)
        return;

      last_snoop_data_timing = null;

      snoop_transaction_timing.snoop_data_phase_ended= $realtime;
      snoop_transaction_timing.end_time = $realtime;

      bus_activity_type_name  = "ace_bus_data";
      bus_activity_channel    = "SNOOP_DATA";
      bus_activity_start_time = snoop_transaction_timing.snoop_data_phase_started;
      bus_activity_end_time   = snoop_transaction_timing.snoop_data_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     snoop_transaction_timing.snoop_transaction_uid);

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(snoop_transaction,snoop_addr,16)
      
      //snoop_data_index = snoop_transaction.snoop_data.size() - 1;
      snoop_data_index = snoop_transaction.current_snoop_data_beat_num;
      `PA_WRITE_INT_FIELD_VALUE_TO_FILE(snoop_data_index,snoop_data_index)
      
      snoop_data_value = snoop_transaction.snoop_data[ snoop_data_index ];

      // Use the burst length to determine the width of the data value.
      if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_1_BEAT )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(snoop_data,snoop_data_value,256) 
      else if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_2_BEATS )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(snoop_data,snoop_data_value,512) 
      else if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_4_BEATS )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(snoop_data,snoop_data_value,1024) 
      else if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_8_BEATS )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(snoop_data,snoop_data_value,2048) 
      else if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_16_BEATS )  
        `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(snoop_data,snoop_data_value,4096) 

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void snoop_data_phase_started( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);
      snoop_transaction_timing.snoop_data_phase_started= $realtime;

      if ( last_snoop_data_timing != null )
        snoop_data_phase_ended( last_snoop_data_transaction, last_snoop_data_channel_name );

      last_snoop_data_timing = snoop_transaction_timing;
      last_snoop_data_transaction = snoop_transaction;
      last_snoop_data_channel_name = snoop_channel_name;
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void snoop_resp_phase_ended( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);

      snoop_transaction_timing.snoop_resp_phase_ended= $realtime;
      snoop_transaction_timing.end_time = $realtime;

      bus_activity_type_name  = "ace_bus_response";
      bus_activity_channel    = "SNOOP_RESP";
      bus_activity_start_time = snoop_transaction_timing.snoop_resp_phase_started;
      bus_activity_end_time   = snoop_transaction_timing.snoop_resp_phase_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     snoop_transaction_timing.snoop_transaction_uid);

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      `PA_WRITE_BITVEC_FIELD_TO_FILE(snoop_transaction,snoop_addr,16)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void snoop_resp_phase_started( svt_axi_snoop_transaction snoop_transaction, string snoop_channel_name);
    begin
      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing= find_snoop_transaction_timing( snoop_transaction, snoop_channel_name);

      if ( snoop_transaction_timing!= null )
        snoop_transaction_timing.snoop_resp_phase_started= $realtime;
    end
  endfunction

// -----------------------------------------------------------------------------

  function void stream_transfer_ended( svt_axi_transaction transaction, string channel_name );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      int            data_index;
      logic [1023:0] data_value;

      string bus_activity_type_name;
      string bus_activity_channel;
      real   bus_activity_start_time;
      real   bus_activity_end_time;

      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      if ( last_stream_transfer_timing != transaction_timing )
        return;

      last_stream_transfer_timing = null;

      transaction_timing.stream_transfer_ended = $realtime;

      bus_activity_type_name  = "axi_bus_stream_transfer";
      bus_activity_channel    = "TDATA";
      bus_activity_start_time = transaction_timing.stream_transfer_started;
      bus_activity_end_time   = transaction_timing.stream_transfer_ended;

      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" parent_uid=\"%0s\">\n",
                     bus_activity_type_name, bus_activity_channel, bus_activity_start_time, bus_activity_end_time,
                     transaction_timing.transaction_uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.
      //`PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,taddr,16)
      
      data_index = transaction.current_data_beat_num;
      `PA_WRITE_INT_FIELD_VALUE_TO_FILE(data_index,data_index)
      
      data_value = transaction.tdata[ data_index ];

      `PA_WRITE_BITVEC_FIELD_VALUE_TO_FILE(tdata,data_value,32)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void stream_transfer_started( svt_axi_transaction transaction, string channel_name );
    begin
      svt_axi_xml_transaction_timing transaction_timing = find_transaction_timing( transaction, channel_name );

      transaction_timing.stream_transfer_started = $realtime;

      if ( last_stream_transfer_timing != null )
        stream_transfer_ended( last_stream_data_transaction, last_stream_data_channel_name);

      last_stream_transfer_timing = transaction_timing;
      last_stream_data_transaction = transaction;
      last_stream_data_channel_name = channel_name;
    end
  endfunction
  // -----------------------------------------------------------------------------

  function void write_transaction( svt_axi_transaction transaction, svt_axi_xml_transaction_timing transaction_timing );
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string channel_name = transaction_timing.channel_name;
      real   start_time = transaction_timing.start_time;
      real   end_time = transaction_timing.end_time;
      string uid = transaction_timing.transaction_uid;

      `SVT_AXI_MASTER_TRANSACTION_TYPE master_transaction;
      `SVT_AXI_SLAVE_TRANSACTION_TYPE slave_transaction;

      bit is_master_xact   = 0;
      bit is_slave_xact    = 0;
      bit is_coherent_xact = 0;
      bit is_data_stream_xact = 0;

      bit is_read_xact     = 0;
      bit is_write_xact    = 0;

      bit is_coherent_read_xact  = 0;
      bit is_coherent_write_xact = 0;
      
    `ifdef SVT_ACE5_ENABLE  
      bit is_atomic_xact = 0;
      bit is_atomic_store_xact = 0;
      bit is_atomic_load_xact = 0;
      bit is_atomic_swap_xact = 0;
      bit is_atomic_compare_xact = 0;
    `endif
      string transaction_type_name = "";

      // The transaction must be either a MASTER or SLAVE transaction.  If the 
      // transaction is neither, insert a comment describing the error and return.
      if ( $cast( master_transaction, transaction ) )
        is_master_xact = 1;
      else if ( $cast( slave_transaction, transaction ) )
        is_slave_xact = 1;
      else
        begin
          write_comment( $sformatf( "%0s: Transaction is neither MASTER nor SLAVE @ %0.0f", uid, $realtime ) );
          return;
        end
 
      // The transaction type must be READ, WRITE , DATA_STREAM or COHERENT.  If the transaction
      // type is none of these, insert a comment describing the error and return.
      if ( transaction.xact_type == svt_axi_transaction::READ )
        is_read_xact = 1;
      else if ( transaction.xact_type == svt_axi_transaction::WRITE )
        is_write_xact = 1;
      else if ( transaction.xact_type == svt_axi_transaction::COHERENT)
        is_coherent_xact = 1;
      else if ( transaction.xact_type == svt_axi_transaction::DATA_STREAM)
        is_data_stream_xact = 1;
    `ifdef SVT_ACE5_ENABLE
      else if (transaction.xact_type == svt_axi_transaction::ATOMIC )
        is_atomic_xact = 1;
    `endif
      else
        begin
          write_comment( $sformatf( "%0s: Transaction type is not READ, WRITE , ATOMIC nor COHERENT @ %0.0f", uid, $realtime ) );
          return;
        end

      if ( is_master_xact )
        begin
          if ( is_read_xact )
            transaction_type_name = "axi_master_read_transaction";
          else if ( is_write_xact )
            transaction_type_name = "axi_master_write_transaction";
          else if ( is_data_stream_xact )
          begin
            transaction_type_name = "axi_master_data_stream_transaction";
          end
            else if ( is_coherent_xact )
            begin
              if ( ( transaction.coherent_xact_type == svt_axi_transaction::READNOSNOOP )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READONCE )     ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READSHARED )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READCLEAN )    ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY ) ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READUNIQUE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANSHARED )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANINVALID ) ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::MAKEINVALID )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::DVMCOMPLETE )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::DVMMESSAGE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READBARRIER ) )
                begin
                  is_coherent_read_xact = 1;
                  transaction_type_name = "ace_master_coherent_read_transaction";
                end
              else
                begin
                  is_coherent_write_xact = 1;
                  transaction_type_name = "ace_master_coherent_write_transaction";
                end
            end
        `ifdef SVT_ACE5_ENABLE
          else if (is_atomic_xact )
          begin
            if (transaction.atomic_transaction_type == svt_axi_transaction::STORE ) begin
              is_atomic_store_xact = 1;
              transaction_type_name = "ace_master_atomic_store_transaction";
            end
            else if (transaction.atomic_transaction_type == svt_axi_transaction::LOAD ) begin
              is_atomic_load_xact = 1;
              transaction_type_name = "ace_master_atomic_load_transaction";
            end 
            else if (transaction.atomic_transaction_type == svt_axi_transaction::SWAP ) begin
              is_atomic_swap_xact = 1;
              transaction_type_name = "ace_master_atomic_swap_transaction";
            end
            else if (transaction.atomic_transaction_type == svt_axi_transaction::COMPARE ) begin
              is_atomic_compare_xact = 1;
              transaction_type_name = "ace_master_atomic_compare_transaction";
            end  
          end 
        `endif
        end
      else if ( is_slave_xact )
        begin
          if ( is_read_xact )
            transaction_type_name = "axi_slave_read_transaction";
          else if ( is_write_xact )
            transaction_type_name = "axi_slave_write_transaction";
          else if ( is_data_stream_xact )
          begin
            transaction_type_name = "axi_slave_data_stream_transaction";
          end

            else if ( is_coherent_xact )
            begin
              if ( ( transaction.coherent_xact_type == svt_axi_transaction::READNOSNOOP )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READONCE )     ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READSHARED )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READCLEAN )    ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY ) ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READUNIQUE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANSHARED )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::CLEANINVALID ) ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::MAKEINVALID )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::DVMCOMPLETE )  ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::DVMMESSAGE )   ||
                   ( transaction.coherent_xact_type == svt_axi_transaction::READBARRIER ) )
                begin
                  is_coherent_read_xact = 1;
                  transaction_type_name = "ace_ic_coherent_read_transaction";
                end
              else
                begin
                  is_coherent_write_xact = 1;
                  transaction_type_name = "ace_ic_coherent_write_transaction";
                end
            end
        `ifdef SVT_ACE5_ENABLE
          else if (is_atomic_xact == 1)
          begin
            if (transaction.atomic_transaction_type == svt_axi_transaction::STORE ) begin
              is_atomic_store_xact = 1;
              transaction_type_name = "ace_slave_atomic_store_transaction";
            end
            else if (transaction.atomic_transaction_type == svt_axi_transaction::LOAD ) begin
              is_atomic_load_xact = 1;
              transaction_type_name = "ace_slave_atomic_load_transaction";
            end 
            else if (transaction.atomic_transaction_type == svt_axi_transaction::SWAP ) begin
              is_atomic_swap_xact = 1;
              transaction_type_name = "ace_slave_atomic_swap_transaction";
            end
            else if (transaction.atomic_transaction_type == svt_axi_transaction::COMPARE ) begin
              is_atomic_compare_xact = 1;
              transaction_type_name = "ace_slave_atomic_compare_transaction";
            end           
          end 
        `endif
        end
      
      xact_count++;

      if ( is_read_xact )
        begin
          // write_comment( $sformatf( "%0s: read_address_phase_started @ %0.0f", uid, transaction_timing.read_address_phase_started ) );
          // write_comment( $sformatf( "%0s: read_address_phase_ended   @ %0.0f", uid, transaction_timing.read_address_phase_ended ) );
          // write_comment( $sformatf( "%0s: read_data_phase_started    @ %0.0f", uid, transaction_timing.read_data_phase_started ) );
          // write_comment( $sformatf( "%0s: read_data_phase_ended      @ %0.0f", uid, transaction_timing.read_data_phase_ended ) );

          start_time = transaction_timing.new_transaction_started;
          end_time = transaction_timing.read_data_phase_ended;
        end
      else if ( is_write_xact )
        begin
          // write_comment( $sformatf( "%0s: write_address_phase_started @ %0.0f", uid, transaction_timing.write_address_phase_started ) );
          // write_comment( $sformatf( "%0s: write_address_phase_ended   @ %0.0f", uid, transaction_timing.write_address_phase_ended ) );
          // write_comment( $sformatf( "%0s: write_data_phase_started    @ %0.0f", uid, transaction_timing.write_data_phase_started ) );
          // write_comment( $sformatf( "%0s: write_data_phase_ended      @ %0.0f", uid, transaction_timing.write_data_phase_ended ) );
          // write_comment( $sformatf( "%0s: write_resp_phase_started    @ %0.0f", uid, transaction_timing.write_resp_phase_started ) );
          // write_comment( $sformatf( "%0s: write_resp_phase_ended      @ %0.0f", uid, transaction_timing.write_resp_phase_ended ) );

          start_time = transaction_timing.new_transaction_started;
          end_time = transaction_timing.write_resp_phase_ended;
        end
      else if ( is_coherent_xact )
        begin
          start_time = transaction_timing.new_transaction_started;
      end_time = transaction_timing.coherent_transaction_ended;

      /*
          if ( is_coherent_read_xact )
            begin
              // write_comment( $sformatf( "%0s: read_address_phase_started @ %0.0f", uid, transaction_timing.read_address_phase_started ) );
              // write_comment( $sformatf( "%0s: read_address_phase_ended   @ %0.0f", uid, transaction_timing.read_address_phase_ended ) );
              // write_comment( $sformatf( "%0s: read_data_phase_started    @ %0.0f", uid, transaction_timing.read_data_phase_started ) );
              // write_comment( $sformatf( "%0s: read_data_phase_ended      @ %0.0f", uid, transaction_timing.read_data_phase_ended ) );

              end_time = transaction_timing.read_data_phase_ended;
            end
          else if ( is_coherent_write_xact )
            begin
              // write_comment( $sformatf( "%0s: write_address_phase_started @ %0.0f", uid, transaction_timing.write_address_phase_started ) );
              // write_comment( $sformatf( "%0s: write_address_phase_ended   @ %0.0f", uid, transaction_timing.write_address_phase_ended ) );
              // write_comment( $sformatf( "%0s: write_data_phase_started    @ %0.0f", uid, transaction_timing.write_data_phase_started ) );
              // write_comment( $sformatf( "%0s: write_data_phase_ended      @ %0.0f", uid, transaction_timing.write_data_phase_ended ) );
              // write_comment( $sformatf( "%0s: write_resp_phase_started    @ %0.0f", uid, transaction_timing.write_resp_phase_started ) );
              // write_comment( $sformatf( "%0s: write_resp_phase_ended      @ %0.0f", uid, transaction_timing.write_resp_phase_ended ) );

              end_time = transaction_timing.write_resp_phase_ended;
            end
        */
        end
      `ifdef SVT_ACE5_ENABLE
        else if ( is_atomic_xact )
        begin
          start_time = transaction_timing.new_transaction_started;
          end_time = transaction_timing.atomic_transaction_ended;
        end
      `endif
        else if ( is_data_stream_xact )
        begin
          start_time = transaction_timing.new_transaction_started;
          end_time = transaction_timing.stream_transfer_ended;
        end


      // Write out the transaction.
      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" uid=\"%0s\">\n",
                     transaction_type_name, channel_name, start_time, end_time, uid );

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );

      // Write out field values.

      if( is_data_stream_xact ) 
      begin
        // AXI DATA STREAM fields.
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_tvalid_delay)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction,tvalid_delay)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction,tready_delay)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,tdata,32)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,tstrb,4)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,tkeep,4)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,tid,2)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,tdest,1)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,tuser,2)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,stream_burst_length)
      end

      else begin
        // Use the burst size to determine the width of each data element.
        if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_8BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,2)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_16BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,4)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_32BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,8)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_64BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,16)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_128BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,32)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_256BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,64)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_512BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,128)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_1024BIT ) 
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,256)
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_2048BIT ) 
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data,512)
        
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr,16)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,addr_ready_assertion_cycle)
        `PA_WRITE_TIME_FIELD_TO_FILE(transaction,addr_ready_assertion_time)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,addr_ready_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,addr_status)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,addr_user,1)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,addr_valid_assertion_cycle)
        `PA_WRITE_TIME_FIELD_TO_FILE(transaction,addr_valid_assertion_time)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,addr_valid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,atomic_type)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,bready_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,bresp)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,burst_length,3)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,burst_size)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,burst_type)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,bvalid_delay)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,cache_type,1)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,current_data_beat_num)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction,data_before_addr)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, data_ready_assertion_cycle)
        `PA_WRITE_TIME_ARRAY_FIELD_TO_FILE(transaction, data_ready_assertion_time)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,data_status)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,data_user,1)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, data_valid_assertion_cycle)
        `PA_WRITE_TIME_ARRAY_FIELD_TO_FILE(transaction, data_valid_assertion_time)
      //Commenting equal_block_length as it is not currently supported
      //`PA_WRITE_INT_FIELD_TO_FILE(transaction,equal_block_length)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,id,1)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,interleave_pattern)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,object_id)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,reordering_priority)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,port_id)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,prot_type)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,qos,1)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, random_interleave_array)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_addr_ready_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_addr_valid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_bready_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_bvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_first_rvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_first_wvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_next_rvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_next_wvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_rready_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_wready_delay)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,region,1)
        `PA_WRITE_BITVEC_FIELD_TO_FILE(transaction,resp_user,1)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction,rready_delay)
        `PA_WRITE_ENUM_ARRAY_FIELD_TO_FILE(transaction,rresp)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,bresp)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, rvalid_delay)
      //Commenting start_new_interleave as it is not currently supported
      //`PA_WRITE_BIT_FIELD_TO_FILE(transaction,start_new_interleave)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction,enable_interleave)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, wready_delay)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,write_resp_ready_assertion_cycle)
        `PA_WRITE_TIME_FIELD_TO_FILE(transaction,write_resp_ready_assertion_time)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,write_resp_status)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,write_resp_valid_assertion_cycle)
        `PA_WRITE_TIME_FIELD_TO_FILE(transaction,write_resp_valid_assertion_time)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,wstrb,32)
        `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(transaction, wvalid_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,xact_type)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction,suspend_response)
   
        // svt_axi_port_configuration    port_cfg 
   
        // int   LONG_BURST_wt
        // int   LONG_DELAY_wt
        // int   SHORT_BURST_wt
        // int   SHORT_DELAY_wt
        // int   ZERO_BURST_wt
        // int   ZERO_DELAY_wt
   
        // ACE-related fields.
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, associate_barrier) 
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, allocate_in_cache)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,cache_write_data,256)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,domain_type)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,barrier_type)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,coherent_xact_type)
        `PA_WRITE_ENUM_ARRAY_FIELD_TO_FILE(transaction,coh_rresp)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_rack_delay)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,rack_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,reference_event_for_wack_delay)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,wack_delay)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,dvm_complete_delay)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,ack_status)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,excl_access_status)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,excl_mon_status)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,initial_cache_line_state)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,final_cache_line_state)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,initial_cache_line_data,2)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,final_cache_line_data,2)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, is_cached_data)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, is_coherent_xact_dropped)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, is_speculative_read)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, force_to_shared_state)
        `PA_WRITE_BIT_FIELD_TO_FILE(transaction, force_to_invalid_state)
      `ifdef SVT_ACE5_ENABLE
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,atomic_transaction_type)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,atomic_xact_op_type)  
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,endian)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,tag_op)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,response_tag_op)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,tag_match_resp)
        `PA_WRITE_ENUM_FIELD_TO_FILE(transaction,atomic_read_data_status)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data_user,1)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_wstrb,32)
        `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_wstrb,32)
        `PA_WRITE_INT_FIELD_TO_FILE(transaction,atomic_read_current_data_beat_num)

                // Use the burst size to determine the width of each data element.
        if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_8BIT )  begin 
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,2)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,2)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,2)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,2)
        end
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_16BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,4)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,4)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,4)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,4)
        end
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_32BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,8)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,8)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,8)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,8)
        end
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_64BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,16)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,16)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,16)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,16)
        end
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_128BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,32)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,32)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,32)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,32)
        end
        else if ( transaction.burst_size == svt_axi_transaction::BURST_SIZE_256BIT )  
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_read_data,64)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_resultant_data,64)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_swap_data,64)
          `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(transaction,atomic_compare_data,64)
        end
    `endif
      end

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction
 

  // -----------------------------------------------------------------------------
  
  function void write_snoop_transaction( svt_axi_snoop_transaction snoop_transaction, svt_axi_snoop_xml_transaction_timing snoop_transaction_timing);
    begin
      string indent = "  ";
      string field_indent = { indent, "    " };

      string snoop_channel_name= snoop_transaction_timing.snoop_channel_name;
      real   start_time = snoop_transaction_timing.start_time;
      real   end_time = snoop_transaction_timing.end_time;
      string uid= snoop_transaction_timing.snoop_transaction_uid;

      string transaction_type_name = "";

      transaction_type_name = "ace_transaction";
      xact_count++;
 
      start_time = snoop_transaction_timing.new_snoop_transaction_started; 
      if (snoop_transaction_timing.snoop_resp_phase_ended >= snoop_transaction_timing.snoop_data_phase_ended)
        end_time = snoop_transaction_timing.snoop_resp_phase_ended;
      else
        end_time = snoop_transaction_timing.snoop_data_phase_ended;

      // Write out the snoop_transaction.
      $fwrite( file, indent );
      $fwrite( file, "<object type=\"%0s\" channel=\"%0s\" start_time=\"%0.0t\" end_time=\"%0.0t\" uid=\"%0s\">\n",
                     transaction_type_name, snoop_channel_name, start_time, end_time, uid);

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "<field_values>\n" );
      // Write out field values.
      
      // Use the burst length to determine the width of each data element.
      //if ( snoop_transaction.snoop_burst_length == svt_axi_snoop_transaction::SNOOPBURST_LENGTH_1_BEAT )  
      `PA_WRITE_BITVEC_ARRAY_FIELD_TO_FILE(snoop_transaction,snoop_data,256) 
      
      `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(snoop_transaction, cdvalid_delay)
      `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(snoop_transaction, snoop_data_valid_assertion_cycle)
      `PA_WRITE_INT_ARRAY_FIELD_TO_FILE(snoop_transaction, snoop_data_ready_assertion_cycle)
      `PA_WRITE_TIME_ARRAY_FIELD_TO_FILE(snoop_transaction, snoop_data_valid_assertion_time)
      `PA_WRITE_TIME_ARRAY_FIELD_TO_FILE(snoop_transaction, snoop_data_ready_assertion_time)

      `PA_WRITE_BITVEC_FIELD_TO_FILE(snoop_transaction,snoop_addr,16) 
      `PA_WRITE_BITVEC_FIELD_TO_FILE(snoop_transaction,snoop_prot,1) 
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,snoop_resp_datatransfer) 
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,snoop_resp_error) 
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,snoop_resp_isshared) 
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,snoop_resp_passdirty) 
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,snoop_resp_wasunique) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,acready_delay) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,crvalid_delay) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,snoop_addr_valid_assertion_cycle) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,snoop_resp_valid_assertion_cycle) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,snoop_addr_ready_assertion_cycle) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,snoop_resp_ready_assertion_cycle) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_burst_length) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_initial_cache_line_state) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_final_cache_line_state) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_addr_status) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_data_status) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_resp_status) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,reference_event_for_acready_delay) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,reference_event_for_crvalid_delay) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,reference_event_for_first_cdvalid_delay) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,reference_event_for_next_cdvalid_delay) 
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,current_snoop_data_beat_num) 
      `PA_WRITE_TIME_FIELD_TO_FILE(snoop_transaction,snoop_addr_ready_assertion_time) 
      `PA_WRITE_TIME_FIELD_TO_FILE(snoop_transaction,snoop_addr_valid_assertion_time) 
      `PA_WRITE_TIME_FIELD_TO_FILE(snoop_transaction,snoop_resp_ready_assertion_time) 
      `PA_WRITE_TIME_FIELD_TO_FILE(snoop_transaction,snoop_resp_valid_assertion_time) 
      `PA_WRITE_ENUM_FIELD_TO_FILE(snoop_transaction,snoop_xact_type)
      `PA_WRITE_INT_FIELD_TO_FILE(snoop_transaction,object_id)
      `PA_WRITE_BIT_FIELD_TO_FILE(snoop_transaction,data_before_resp)

      $fwrite( file, { indent, "  " } );
      $fwrite( file, "</field_values>\n" );
      
      $fwrite( file, indent );
      $fwrite( file, "</object>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_field_value_w_expected( string field_name, string field_str_value,
                                              string field_str_expected_value, string indent = "" );
    begin
      $fwrite( file, { indent, "<field " } );
      $fwrite( file, "name=\"%0s\" ", field_name );
      $fwrite( file, "value=\"%0s\" ", field_str_value );

      if ( field_str_value != field_str_expected_value )
        $fwrite( file, "expected=\"%0s\" \n", field_str_expected_value );
      
      $fwrite( file, "/>\n" );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_field_value( string field_name, string field_str_value, string indent = "" );
    begin
      $fwrite( file, { indent, "<field " } );
      $fwrite( file, "name=\"%0s\" ", field_name );
      $fwrite( file, "value=\"%0s\" />\n", field_str_value );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void write_comment( string comment, string indent = "" );
    begin
      $fwrite( file, { indent, "<!-- ", comment, " -->\n" } );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void finish();
    begin
      svt_axi_xml_transaction_timing transaction_timing;
      svt_axi_snoop_xml_transaction_timing snoop_transaction_timing;
      int queue_size = transaction_timing_queue.size();
      int snoop_queue_size = snoop_transaction_timing_queue.size();

      for ( int i = 0; i < queue_size; i++ )
        begin
          transaction_timing = transaction_timing_queue[ i ];

          if ( transaction_timing.end_time != 0 )
            write_transaction( transaction_timing.transaction, transaction_timing );
        end

      for ( int i = 0; i < snoop_queue_size; i++ )
        begin
          snoop_transaction_timing = snoop_transaction_timing_queue[ i ];

          if ( snoop_transaction_timing.end_time != 0 )
            write_snoop_transaction( snoop_transaction_timing.snoop_transaction,snoop_transaction_timing );
        end

      $fwrite( file, "</objects>\n" );
      $fclose( file );

      // `vmm_note( log, $sformatf( "Wrote %0d transactions", xact_count ) );
    end
   endfunction

  // -----------------------------------------------------------------------------

endclass : svt_axi_xml_writer

// =============================================================================
/**
 * The svt_axi_port_monitor_xml_writer_callback class is extended from the
 * #svt_axi_port_monitor_callback class in order to write out protocol object 
 * information (using the svt_axi_xml_writer class).
 */

class svt_axi_port_monitor_xml_writer_callback extends svt_axi_port_monitor_callback;

  svt_axi_xml_writer pa_writer;
  string name;

  // -----------------------------------------------------------------------------

  function new( string name, string file_name );
    begin
`ifdef SVT_UVM_TECHNOLOGY
      super.new(name);
`elsif SVT_OVM_TECHNOLOGY
      super.new(name);
`else
      super.new();
`endif

      this.name = name;

      pa_writer = new( name, file_name );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void new_transaction_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.new_transaction_started(axi_monitor, item);
      pa_writer.new_transaction_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void pre_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.pre_output_port_put(axi_monitor, item);
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void pre_response_request_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.pre_response_request_port_put(axi_monitor, item);
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void read_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.read_address_phase_ended(axi_monitor, item);
      pa_writer.read_address_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void read_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.read_address_phase_started(axi_monitor, item);
      pa_writer.read_address_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void read_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.read_data_phase_ended(axi_monitor, item);
      pa_writer.read_data_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void read_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.read_data_phase_started(axi_monitor, item);
      pa_writer.read_data_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_address_phase_ended(axi_monitor, item);
      pa_writer.write_address_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_address_phase_started(axi_monitor, item);
      pa_writer.write_address_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_data_phase_ended(axi_monitor, item);
      pa_writer.write_data_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_data_phase_started(axi_monitor, item);
      pa_writer.write_data_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_resp_phase_ended(axi_monitor, item);
      pa_writer.write_resp_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void write_resp_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.write_resp_phase_started(axi_monitor, item);
      pa_writer.write_resp_phase_started( item, name );
    end
  endfunction

  function void transaction_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.transaction_ended(axi_monitor, item);
      pa_writer.transaction_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void stream_transfer_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.stream_transfer_started(axi_monitor, item);
      pa_writer.stream_transfer_started( item, name );
    end
  endfunction
  
  // -----------------------------------------------------------------------------

  function void stream_transfer_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
    begin
      super.stream_transfer_ended(axi_monitor, item);
      pa_writer.stream_transfer_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void new_snoop_transaction_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.new_snoop_transaction_started(axi_monitor, item);
      pa_writer.new_snoop_transaction_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void pre_snoop_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.pre_snoop_output_port_put(axi_monitor, item);
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_address_phase_ended(axi_monitor, item);
      pa_writer.snoop_address_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_address_phase_started(axi_monitor, item);
      pa_writer.snoop_address_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_data_phase_ended(axi_monitor, item);
      pa_writer.snoop_data_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_data_phase_started(axi_monitor, item);
      pa_writer.snoop_data_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
   
   function void snoop_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_resp_phase_ended(axi_monitor, item);
      pa_writer.snoop_resp_phase_ended( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------
  
  function void snoop_resp_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
    begin
      super.snoop_resp_phase_started(axi_monitor, item);
      pa_writer.snoop_resp_phase_started( item, name );
    end
  endfunction

  // -----------------------------------------------------------------------------

  function void finish();
    begin
      pa_writer.finish();
    end
   endfunction

  // -----------------------------------------------------------------------------

endclass : svt_axi_port_monitor_xml_writer_callback

// =============================================================================

`endif // GUARD_SVT_AXI_PORT_MONITOR_XML_WRITER_CALLBACK_UVM_SV
