`ifndef C_SCB__SV
`define C_SCB__SV


class c_scb extends uvm_scoreboard;
  `uvm_component_utils(c_scb)
  int   m_matches, m_mismatches;
  bit   free;
  event compared, end_of_simulation;
  
  uvm_blocking_get_port  #(c_trans_sif) exp_up_port; //axi_to_sif
  uvm_blocking_get_port  #(c_trans_sif) act_up_port;
  uvm_blocking_get_port  #(c_trans_axi) exp_dn_port; //sif_to_axi
  uvm_blocking_get_port  #(c_trans_axi) act_dn_port;
   
  //define transaction 
  c_trans_sif m_exp_up_queue[$];
  c_trans_axi m_exp_dn_queue[$];


  function new(string name, uvm_component parent);
    super.new(name, parent);
    //upstream axi_to_sif
    exp_up_port  = new("exp_up_port", this);
    act_up_port  = new("act_up_port", this);
    //downstrem sif_to_axi
    exp_dn_port  = new("exp_dn_port", this);
    act_dn_port  = new("act_dn_port", this);

    m_matches       = 0;
    m_mismatches    = 0;
    free            = 1;
  endfunction

  task run_phase(uvm_phase phase);
    int j = 0;
    bit [63 : 0] num;
    c_trans_sif m_get_exp_up,m_get_act_up,m_exp_tmp_up;
    c_trans_axi m_get_exp_dn,m_get_act_dn,m_exp_tmp_dn;
    bit result;
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("====== run_phase :start ===== \n"), UVM_MEDIUM)
     fork
        //up----dma_read --- axi-to-sif
        while (1)  begin //from RM get sif
           exp_up_port.get(m_get_exp_up);
           num = m_get_exp_up.up_data;           
           m_exp_up_queue.push_back(m_get_exp_up);
        end
        while (1)  begin //from monitor(DUT) get sif
          j++;
           act_up_port.get(m_get_act_up);
           if(m_exp_up_queue.size() > 0) begin
              m_exp_tmp_up = m_exp_up_queue.pop_front();
              `uvm_info(get_type_name(), $sformatf("[RESULT]@%t scoreboard: up_act[%d] = %h \n",$time,j,m_get_act_up.up_data), UVM_MEDIUM)
              `uvm_info(get_type_name(), $sformatf("[RESULT]@%t scoreboard: up_exp[%d] = %h \n",$time,j,m_exp_tmp_up.up_data), UVM_MEDIUM)
              result = m_get_act_up.compare(m_exp_tmp_up);
              if(result) begin 
                 `uvm_info(get_name(),$psprintf("up : Compare PASSED!"),UVM_MEDIUM);
                  m_matches++; 
              end
              else begin
                m_mismatches++; 
                `uvm_info(get_name(),$psprintf("up : Compare FAILED!"),UVM_MEDIUM);
                 void'(m_exp_tmp_up.psdisplay("up_exp :"));
                 void'(m_get_act_up.psdisplay("up_act :"));
              end
           end
           else begin 
               m_mismatches++; 
              `uvm_error(get_name(), "up : Received from DUT, while Expect Queue is empty");
              void'(m_get_act_up.psdisplay("up_act :"));
           end 
        end

        //dn----dma_write --- sif-to-axi
        while (1)  begin //from RM get axi
           exp_dn_port.get(m_get_exp_dn);
           m_exp_dn_queue.push_back(m_get_exp_dn);
        end
        while (1)  begin//from monitor(DUT) get axi
           act_dn_port.get(m_get_act_dn);
           
           if((m_exp_dn_queue.size() > 0) && (m_exp_dn_queue.size()>= m_get_act_dn.wdata_que.size())) begin
              while(m_get_act_dn.wdata_que.size()>0) begin
                  j++;
                  m_get_act_dn.wdata = m_get_act_dn.wdata_que.pop_front();
                  m_exp_tmp_dn       = m_exp_dn_queue.pop_front();
                  `uvm_info(get_type_name(), $sformatf("[RESULT]@%t scoreboard: dn_act[%d] = %h. \n",$time,j-1,m_get_act_dn.wdata), UVM_MEDIUM)
                  `uvm_info(get_type_name(), $sformatf("[RESULT]@%t scoreboard: dn_exp[%d] = %h. \n",$time,j-1,m_exp_tmp_dn.wdata), UVM_MEDIUM)
                  result = m_get_act_dn.compare(m_exp_tmp_dn);
                  if(result) begin 
                     `uvm_info(get_name(),$psprintf("dn : Compare SUCCESSFULLY!"),UVM_MEDIUM);
                      m_matches++; 
                  end
                  else begin
                    m_mismatches++; 
                    `uvm_info(get_name(),$psprintf("dn : Compare FAILED!"),UVM_MEDIUM);
                     void'(m_exp_tmp_dn.psdisplay("dn_exp :"));
                     void'(m_get_act_dn.psdisplay("dn_act :"));
                  end
              end
           end
           else begin
               m_mismatches++; 
              `uvm_error(get_name(), "dn : Received from DUT, while Expect Queue is empty");
              void'(m_get_act_dn.psdisplay("dn_act :"));
           end 
        end
     join
    `uvm_info(get_type_name(), $sformatf("****** run_phase :end   ****** \n"), UVM_MEDIUM)
  endtask

  virtual function void pass_display();
    $display("      ====================  testcase pass!!  =======================");
    $display("                                                                    ");
    $display("      PPPPPPPPPPP       AAAAAAA       SSSSSSSSSS     SSSSSSSSSS   !!");
    $display("      PPPPPPPPPPPP     AAAAAAAAA     SSSSSSSSSSSS   SSSSSSSSSSSS  !!");
    $display("      PPP     PPPP    AAAAA AAAAA   SSSSSSSSSSSSS  SSSSSSSSSSSSS  !!");
    $display("      PPP     PPPP   AAAAA   AAAAA  SSSSS          SSSSS          !!");
    $display("      PPP     PPPP   AAAA     AAAA  SSSSS          SSSSS          !!");
    $display("      PPPPPPPPPPPP   AAAAAAAAAAAAA   SSSSSSSSSSS    SSSSSSSSSSS   !!");
    $display("      PPPPPPPPPPP    AAAAAAAAAAAAA    SSSSSSSSSSS    SSSSSSSSSSS  !!");
    $display("      PPPP           AAAA     AAAA         SSSSSS         SSSSSS  !!");
    $display("      PPPP           AAAA     AAAA         SSSSSS         SSSSSS  !!");
    $display("      PPPP           AAAA     AAAA  SSSSSSSSSSSSS  SSSSSSSSSSSSS  !!");
    $display("      PPPP           AAAA     AAAA  SSSSSSSSSSSS   SSSSSSSSSSSS   !!");
    $display("      PPPP           AAAA     AAAA   SSSSSSSSSS     SSSSSSSSSS    !!");
    $display("                                                                    ");
    $display("      ==============================================================");
  endfunction

  virtual function void fail_display();
    $display("      ====================  testcase fail!!  =======================");
    $display("                                                                    ");
    $display("      FFFFFFFFFFF      AAAAAAA         IIIII      LLLLL           !!");
    $display("      FFFFFFFFFFF     AAAAAAAAA        IIIII      LLLLL           !!");
    $display("      FFFF           AAAA   AAAA       IIIII      LLLLL           !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLL           !!");
    $display("      FFFFFFFFFFF   AAAA     AAAA      IIIII      LLLLL           !!");
    $display("      FFFFFFFFFFF   AAAAAAAAAAAAA      IIIII      LLLLL           !!");
    $display("      FFFF          AAAAAAAAAAAAA      IIIII      LLLLL           !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLL           !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLL           !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLLLLLLLLLL   !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLLLLLLLLLL   !!");
    $display("      FFFF          AAAA     AAAA      IIIII      LLLLLLLLLLLLL   !!");
    $display("                                                                    ");
    $display("      ==============================================================");
  endfunction

endclass
`endif//C_SCB__SV
