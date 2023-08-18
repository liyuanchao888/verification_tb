`ifndef C_TB_CFG__SV
`define C_TB_CFG__SV

class c_tb_cfg;

  integer    file_read      ;
  string     variable       ;
  string     variable_tmp   ;
  string     cfg_file_name  ; //cfg dir
  bit [31:0] value          ;
  bit [31:0] h_array[string];

  function new();
  endfunction

  function  void file_re();
      if($value$plusargs("cfg_file=%s",cfg_file_name))
         $display("cfg_file is %s",cfg_file_name);
//      file_read =$fopen("D:/work/modelsim/proj_rainman/dma_ut/4_env/test_cfg.txt","r");
      file_read =$fopen(cfg_file_name,"r");
      if(file_read == -1) begin
          $display("[!error!] :failed open cfg_file : %s",cfg_file_name);
          $finish; 
      end
      else begin
          while(!$feof(file_read))
          begin
              $fscanf(file_read,"%s %c %h\n",variable,variable_tmp,value);
              $display("test variable %s ,value %h",variable,value);
              h_array[variable]=value;
              $display("###configuration file context### %h",h_array[variable]);
          end  
      end
      $fclose(file_read);

    endfunction

endclass
`endif //C_FILE_CFG__SV


