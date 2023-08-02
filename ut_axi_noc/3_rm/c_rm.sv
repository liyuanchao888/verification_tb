`ifndef C_RM__SV
`define C_RM__SV

class c_rm extends uvm_component;
    `uvm_component_utils(c_rm)
    parameter dma_width = `DMA_WIDTH;
    int size;
    int row_r;
    int row_w;
    int size_r;
    int column_w;
    int stride_w;
    int column_r;
    int stride_r;
    int block_size;
    bit [31 : 0] align_byte_r;
    bit [31 : 0] current_byte_r;
    bit [31 : 0] align_byte_w;
    bit [31 : 0] next_byte_r;
    rand bit [7 : 0] rdata[$];
    int data_size = 5000;
    //config
    c_tb_cfg m_tb_cfg = new();
    //transaction
    c_trans_apb m_trans_apb_in ;
    c_trans_axi m_trans_axi_in ;
    c_trans_axi m_trans_axi_out;
    c_trans_axi m_trans_axi_dn ; //rm to scb:axi_dn
    c_trans_sif m_trans_sif_up ; 
    c_trans_sif m_trans_sif_rm ; //rm to scb:sif_up
    c_trans_sif m_trans_sif_in ;
    c_trans_sif m_trans_sif_out;
    
    //port
    uvm_blocking_get_port #(c_trans_apb) m_port_apb_in ;
    uvm_blocking_get_port #(c_trans_sif) m_port_sif_in ;
    uvm_blocking_get_port #(c_trans_axi) m_port_axi_in ;

    uvm_analysis_port #(c_trans_apb) m_port_apb_out;
    uvm_analysis_port #(c_trans_axi) m_port_axi_out;
    uvm_analysis_port #(c_trans_sif) m_port_sif_out;

    function new(string name = "c_rm", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        m_port_apb_in      = new("m_port_apb_in ", this);
        m_port_apb_out     = new("m_port_apb_out", this);
        m_port_axi_in      = new("m_port_axi_in ", this);
        m_port_axi_out     = new("m_port_axi_out", this);
        m_port_sif_in      = new("m_port_sif_in ", this);
        m_port_sif_out     = new("m_port_sif_out", this);

        m_tb_cfg.file_re();
    endfunction: build_phase
 
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // read process --up_stream
        align_byte_r = m_tb_cfg.h_array["rmaddr_reg"];
        row_r = ((m_tb_cfg.h_array["rsize_reg"]>>16)+1);
        column_r = (dma_width == 64) ? (((m_tb_cfg.h_array["rsize_reg"]&16'hffff)+1)+7)>>3 :
                                       (((m_tb_cfg.h_array["rsize_reg"]&16'hffff)+1)+15)>>4;
        size_r = (m_tb_cfg.h_array["rsize_reg"]&16'hffff)+1;
        stride_r = m_tb_cfg.h_array["rcfg_reg"]>>16;
        block_size = m_tb_cfg.h_array["block_reg"];
        next_byte_r = align_byte_r;
        // write process --dn_stream
        align_byte_w = m_tb_cfg.h_array["wmaddr_reg"];
        row_w = ((m_tb_cfg.h_array["wsize_reg"]>>16)+1);
        column_w = (dma_width == 64) ? (((m_tb_cfg.h_array["wsize_reg"]&16'hffff)+1)+7)>>3 :
                                       (((m_tb_cfg.h_array["wsize_reg"]&16'hffff)+1)+15)>>4;
        stride_w = m_tb_cfg.h_array["wcfg_reg"]>>16;

        `uvm_info(get_type_name(), $sformatf("====== rm run_phase :start ===== \n"), UVM_MEDIUM)
          //  begin
        if (dma_width == 64) begin
             fork
                 upstream_read (m_trans_axi_in);
                 dnstream_write(m_trans_sif_in);
             join
        end
        else begin
             fork
                 upstream_read_128 (m_trans_axi_in);
                 dnstream_write_128(m_trans_sif_in);
             join
        end
        `uvm_info(get_type_name(), $sformatf("****** rm run_phase :end ****** \n"), UVM_MEDIUM)
    endtask: run_phase

    virtual protected task upstream_read(c_trans_axi m_trans_axi_in);
        //upstream
        forever begin //dma read ----- upstream 
            int offset = 1;
            size = size_r;
            m_trans_axi_out = new("m_trans_axi_out");
            m_port_axi_in.get(m_trans_axi_in);
            m_trans_axi_out.do_copy(m_trans_axi_in); 

            if (size % 8 != 0) begin
              int n = 8; 
              int counter = 0;
              int cnt,colu,tail;
              int head = align_byte_r[2:0];
              int height,width;
              height = (stride_r>>1) + 2 + block_size;
              width = height;
              //for(int i=0 ;i < row_r * (column_r + 3) ;i++)begin
                for(int i=0 ;i < height*width ;i++)begin
                  m_trans_sif_up  = new("m_trans_sif_up");
                  void'(m_trans_sif_up.randomize());
                  for (int j = 0;j < 8;j++) begin
                     // rdata.push_back(m_trans_axi_out.rdata[i][j*8:+8]);
                     case(j)
                         3'h0 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][ 7: 0]);
                         3'h1 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][15: 8]);
                         3'h2 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][23:16]);
                         3'h3 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][31:24]);
                         3'h4 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][39:32]);
                         3'h5 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][47:40]);
                         3'h6 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][55:48]);
                         3'h7 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][63:56]);
                     endcase
                  end
              end
              counter = 0 ;
              while (counter < (row_r*(size_r>>1)>>2)) begin  
                  // for (int k = 0;k < align_byte_r[2:0];k++)
                  for (int k = 0;k < head;k++)
                      void'(rdata.pop_front());
                  if ((n % 8)!=0) begin
                     for (int l = n;l >= 0;l--) begin
                         //rdata.push_front(m_trans_sif_up.up_data[l*8:-8]);
                         case(l) 
                             3'h6 : rdata.push_front(m_trans_sif_up.up_data[55:48]);
                             3'h5 : rdata.push_front(m_trans_sif_up.up_data[47:40]);
                             3'h4 : rdata.push_front(m_trans_sif_up.up_data[39:32]);
                             3'h3 : rdata.push_front(m_trans_sif_up.up_data[31:24]);
                             3'h2 : rdata.push_front(m_trans_sif_up.up_data[23:16]);
                             3'h1 : rdata.push_front(m_trans_sif_up.up_data[15: 8]);
                             3'h0 : rdata.push_front(m_trans_sif_up.up_data[ 7: 0]);
                         endcase
                     end
                  end

                  cnt = 0;
                  colu = 0;
                  while(colu < column_r) begin
                  for( n = 0;n < 8; n++) begin
                    //  m_trans_sif_up.up_data[n*8:+8] = rdata.pop_front();
                      case (n)
                          3'h0 : m_trans_sif_up.up_data[ 7: 0] = rdata.pop_front();
                          3'h1 : m_trans_sif_up.up_data[15: 8] = rdata.pop_front();
                          3'h2 : m_trans_sif_up.up_data[23:16] = rdata.pop_front();
                          3'h3 : m_trans_sif_up.up_data[31:24] = rdata.pop_front();
                          3'h4 : m_trans_sif_up.up_data[39:32] = rdata.pop_front();
                          3'h5 : m_trans_sif_up.up_data[47:40] = rdata.pop_front();
                          3'h6 : m_trans_sif_up.up_data[55:48] = rdata.pop_front();
                          3'h7 : m_trans_sif_up.up_data[63:56] = rdata.pop_front();
                      endcase
                      if (n == 7) begin
                          m_trans_sif_rm  = new("m_trans_sif_rm");
                          m_trans_sif_rm.do_copy(m_trans_sif_up);
                          m_port_sif_out.write(m_trans_sif_rm);
                          counter ++;
                      end
                      cnt ++;
                      if (cnt == size) begin
                              tail = (8-(size_r + align_byte_r[2:0])%8);
                              for(int m = 0;m < tail; m++)
                                  void'(rdata.pop_front());
                          size = size_r + (n + 1)%8;
                          n = (n==7)? n + 1 : n;
                          break;
                      end
                  end
                  colu++;
                  end
                  next_byte_r = align_byte_r + stride_r;
                  if (stride_r != 0)
                      head = (stride_r/2 + 2)*2 - tail;
                  align_byte_r = next_byte_r;
              end
            end
            else begin
                for(int h=0 ;h < row_r ;h++) begin
                   for(int i=0 ;i < column_r ;i++)begin
                   m_trans_sif_up  = new("m_trans_sif_up");
                   void'(m_trans_sif_up.randomize());
                   case (align_byte_r[2 : 0])
                        3'h0 : m_trans_sif_up.up_data =  m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size];
                        3'h1 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][ 7:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63: 8]};
                        3'h2 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][15:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:16]};
                        3'h3 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][23:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:24]};
                        3'h4 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][31:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:32]};
                        3'h5 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][39:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:40]};
                        3'h6 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][47:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:48]};
                        3'h7 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][55:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][63:56]};
                        default : `uvm_info(get_name(),$psprintf("ERROR ========Alignment cannot be performed========"),UVM_MEDIUM)
                   endcase
                   align_byte_r = align_byte_r + 8;
                   m_trans_sif_rm  = new("m_trans_sif_rm");
                   m_trans_sif_rm.do_copy(m_trans_sif_up);
                   m_port_sif_out.write(m_trans_sif_rm);
                   end
                   if (stride_r == 0) 
                        align_byte_r = align_byte_r;
                   else begin
                            next_byte_r = align_byte_r +  stride_r;
                            if (size % 8 == 0)
                                offset = ((align_byte_r[2 : 0] != 0)&&(next_byte_r>>3 != align_byte_r>>3)) ? offset + 1 : offset;
                            align_byte_r = next_byte_r;
                  end
                end
            end
        end    
    
    endtask : upstream_read

    virtual protected task dnstream_write(c_trans_sif m_trans_sif_in);
        //dnstream
        forever begin //dma write ------ downstream
            int i = 0;
            m_trans_sif_out = new("m_trans_sif_out");
            m_port_sif_in.get(m_trans_sif_in);
            m_trans_sif_out.do_copy(m_trans_sif_in);
            for (int h = 0 ;h <= row_w ;h++) begin
                for (int i = 0 ;i <= column_w;i++) begin
                    m_trans_axi_dn  = new("m_trans_axi_dn");
                    void'(m_trans_axi_dn.randomize());
                    case (align_byte_w[2 : 0])
                    3'h0: begin
                              if (i == column_w)
                                 break;
                               else
                                 m_trans_axi_dn.wdata = m_trans_sif_out.dn_data[(i + h*column_w) % data_size];
                           end
                    3'h1: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][55 : 0], 8'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {56'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 56]};
                                  else 
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][55 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 56]};
                             end
                    3'h2: begin
                             if (i == 0)
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][47 : 0], 16'h00}; 
                             else if (i == column_w)
                                 m_trans_axi_dn.wdata = {48'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 48]};
                             else
                                  m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][47 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 48]};
                           end
                    3'h3: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][39 : 0], 24'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {40'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 40]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][39 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 40]};
                           end
                    3'h4: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][31 : 0], 32'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {32'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 32]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][31 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 32]};
                           end
                    3'h5: begin
                             if (i == 0)
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][23 : 0], 40'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {24'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 24]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][23 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 24]};
                          end
                    3'h6: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][15 : 0], 48'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {48'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 16]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][15 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 16]};
                           end
                    3'h7: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][7 : 0], 56'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {56'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 8]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][7 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][63 : 8]};
                           end
                    default: `uvm_info(get_name(),$psprintf("ERROR ========Alignment cannot be performed========"),UVM_MEDIUM)     
                    endcase
                    m_port_axi_out.write(m_trans_axi_dn);                             
                end
                align_byte_w = ((stride_w == 0)&&(i == column_w))? align_byte_w : align_byte_w + 8*column_w + stride_w;
            end
        end
    endtask : dnstream_write

    virtual protected task upstream_read_128(c_trans_axi m_trans_axi_in);
        //upstream
        forever begin //dma read ----- upstream 
            int offset = 1;
            size = size_r;
            m_trans_axi_out = new("m_trans_axi_out");
            m_port_axi_in.get(m_trans_axi_in);
            m_trans_axi_out.do_copy(m_trans_axi_in); 
			      if ((size % 16 != 0)&&(stride_r!=0)) begin
                    int n = 16; 
                    int counter = 0;
                    int cnt,colu,tail;
                    int head = align_byte_r[3:0];
                    int height,width;
                    height = (stride_r>>1) + 2 + block_size;
                    width = height;
                    for(int i=0 ;i < height*width ;i++)begin
                        m_trans_sif_up  = new("m_trans_sif_up");
                        void'(m_trans_sif_up.randomize());
                        for (int j = 0;j < 16;j++) begin
                           // rdata.push_back(m_trans_axi_out.rdata[i][j*8:+8]);
                           case(j)
                               4'h0 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][ 7: 0  ]);
                               4'h1 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][15: 8  ]);
                               4'h2 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][23:16  ]);
                               4'h3 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][31:24  ]);
                               4'h4 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][39:32  ]);
                               4'h5 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][47:40  ]);
                               4'h6 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][55:48  ]);
                               4'h7 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][63:56  ]);
                               4'h8 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][71:64  ]);
                               4'h9 : rdata.push_back(m_trans_axi_out.rdata[i % data_size][79:72  ]);
                               4'hA : rdata.push_back(m_trans_axi_out.rdata[i % data_size][87:80  ]);
                               4'hB : rdata.push_back(m_trans_axi_out.rdata[i % data_size][95:88  ]);
                               4'hC : rdata.push_back(m_trans_axi_out.rdata[i % data_size][103:96 ]);
                               4'hD : rdata.push_back(m_trans_axi_out.rdata[i % data_size][111:104]);
                               4'hE : rdata.push_back(m_trans_axi_out.rdata[i % data_size][119:112]);
                               4'hF : rdata.push_back(m_trans_axi_out.rdata[i % data_size][127:120]);
                           endcase
                        end
                    end
                    counter = 0 ;
                    while (counter < (row_r*(size_r>>1)>>3)) begin  
                        for (int k = 0;k < head;k++)
                            void'(rdata.pop_front());
                        if ((n % 16)!=0) begin
                           for (int l = n;l >= 0;l--) begin
                               //rdata.push_front(m_trans_sif_up.up_data[l*8:-8]);
                               case(l) 
                                   4'h0 : rdata.push_front(m_trans_sif_up.up_data[ 7: 0  ]);
                                   4'h1 : rdata.push_front(m_trans_sif_up.up_data[15: 8  ]);
                                   4'h2 : rdata.push_front(m_trans_sif_up.up_data[23:16  ]);
                                   4'h3 : rdata.push_front(m_trans_sif_up.up_data[31:24  ]);
                                   4'h4 : rdata.push_front(m_trans_sif_up.up_data[39:32  ]);
                                   4'h5 : rdata.push_front(m_trans_sif_up.up_data[47:40  ]);
                                   4'h6 : rdata.push_front(m_trans_sif_up.up_data[55:48  ]);
                                   4'h7 : rdata.push_front(m_trans_sif_up.up_data[63:56  ]);
                                   4'h8 : rdata.push_front(m_trans_sif_up.up_data[71:64  ]);
                                   4'h9 : rdata.push_front(m_trans_sif_up.up_data[79:72  ]);
                                   4'hA : rdata.push_front(m_trans_sif_up.up_data[87:80  ]);
                                   4'hB : rdata.push_front(m_trans_sif_up.up_data[95:88  ]);
                                   4'hC : rdata.push_front(m_trans_sif_up.up_data[103:96 ]);
                                   4'hD : rdata.push_front(m_trans_sif_up.up_data[111:104]);
                                   4'hE : rdata.push_front(m_trans_sif_up.up_data[119:112]);
                               endcase
                           end
                        end
                  
                    cnt = 0;
                    colu = 0;
                    while(colu < column_r) begin
                        for( n = 0;n < 16; n++) begin
                              //  m_trans_sif_up.up_data[n*8:+8] = rdata.pop_front();
                            case (n)
                                4'h0 : m_trans_sif_up.up_data[ 7: 0  ] = rdata.pop_front();
                                4'h1 : m_trans_sif_up.up_data[15: 8  ] = rdata.pop_front();
                                4'h2 : m_trans_sif_up.up_data[23:16  ] = rdata.pop_front();
                                4'h3 : m_trans_sif_up.up_data[31:24  ] = rdata.pop_front();
                                4'h4 : m_trans_sif_up.up_data[39:32  ] = rdata.pop_front();
                                4'h5 : m_trans_sif_up.up_data[47:40  ] = rdata.pop_front();
                                4'h6 : m_trans_sif_up.up_data[55:48  ] = rdata.pop_front();
                                4'h7 : m_trans_sif_up.up_data[63:56  ] = rdata.pop_front();
                                4'h8 : m_trans_sif_up.up_data[71:64  ] = rdata.pop_front(); 
                                4'h9 : m_trans_sif_up.up_data[79:72  ] = rdata.pop_front(); 
                                4'hA : m_trans_sif_up.up_data[87:80  ] = rdata.pop_front();
                                4'hB : m_trans_sif_up.up_data[95:88  ] = rdata.pop_front();
                                4'hC : m_trans_sif_up.up_data[103:96 ] = rdata.pop_front();
                                4'hD : m_trans_sif_up.up_data[111:104] = rdata.pop_front();
                                4'hE : m_trans_sif_up.up_data[119:112] = rdata.pop_front();
                                4'hF : m_trans_sif_up.up_data[127:120] = rdata.pop_front();
                            endcase 
                            if (n == 15) begin
                                m_trans_sif_rm  = new("m_trans_sif_rm");
                                m_trans_sif_rm.do_copy(m_trans_sif_up);
                                m_port_sif_out.write(m_trans_sif_rm);
                                counter ++;
                            end
                            cnt ++;
                            if (cnt == size) begin
                                tail = (16-(size_r + align_byte_r[3:0])%16);
                                for(int m = 0;m < tail; m++)
                                    void'(rdata.pop_front());
                                size = size_r + (n + 1)%16;
                                n = (n==15)? n + 1 : n;
                                break;
                            end
                        end
                        colu++;
                    end
                    next_byte_r = align_byte_r + size_r[3:0];
                    if (stride_r != 0)
                        head = (stride_r/2)*2 - tail;
                    align_byte_r = next_byte_r;
              end
            end
            else begin
                `uvm_info(get_name(),$psprintf("ERROR ========Alignment cannot be performed========"),UVM_MEDIUM)
                for(int h=0 ;h < row_r ;h++) begin
                   for(int i=0 ;i < column_r ;i++)begin
                   m_trans_sif_up  = new("m_trans_sif_up");
                   void'(m_trans_sif_up.randomize());
                   case (align_byte_r[3 : 0])
                        4'h0 : m_trans_sif_up.up_data =  m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size];
                        4'h1 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][ 7:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127: 8 ]};
                        4'h2 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][15:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:16 ]};
                        4'h3 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][23:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:24 ]};
                        4'h4 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][31:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:32 ]};
                        4'h5 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][39:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:40 ]};
                        4'h6 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][47:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:48 ]};
                        4'h7 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][55:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:56 ]};
                        4'h8 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][63:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:64 ]};
                        4'h9 : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][71:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:72 ]};
                        4'hA : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][79:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:80 ]};
                        4'hB : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][87:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:88 ]};
                        4'hC : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][95:0 ],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:96 ]};
                        4'hD : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][103:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:104]};
                        4'hE : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][111:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:112]};
                        4'hF : m_trans_sif_up.up_data = {m_trans_axi_out.rdata[(i + offset + h*column_r) % data_size][119:0],m_trans_axi_out.rdata[(i + offset - 1 + h*column_r) % data_size][127:120]};
                        default : `uvm_info(get_name(),$psprintf("ERROR ========Alignment cannot be performed========"),UVM_MEDIUM)
                   endcase
                   align_byte_r = align_byte_r + 16;
                   m_trans_sif_rm  = new("m_trans_sif_rm");
                   m_trans_sif_rm.do_copy(m_trans_sif_up);
                   m_port_sif_out.write(m_trans_sif_rm);
                   `uvm_info(get_name(),$psprintf("[Reference Model]@%t #m_trans_sif_up.up_data = %h \n",$time,m_trans_sif_rm.up_data),UVM_MEDIUM)
                   end
				           current_byte_r = align_byte_r[3:0] ^ 4'hf;
                   if (stride_r == 0) 
                        align_byte_r = align_byte_r;
                   else begin
                            next_byte_r = align_byte_r +  stride_r;
                            if (size % 16 == 0)
                                offset = (stride_r >=16 ) ? (((align_byte_r[3 : 0] != 0)&&(current_byte_r[3:0] < size_r[3:0])) ? (offset + (stride_r>>4) +1):(offset + (stride_r>>4)) ) : offset;
                            align_byte_r = next_byte_r;
                  end
                end
            end
        end
    endtask : upstream_read_128

    virtual protected task dnstream_write_128(c_trans_sif m_trans_sif_in);
        //dnstream
        forever begin //dma write ------ downstream
            int i = 0;
            m_trans_sif_out = new("m_trans_sif_out");
            m_port_sif_in.get(m_trans_sif_in);
            m_trans_sif_out.do_copy(m_trans_sif_in);
            `uvm_info(get_type_name(), $sformatf("######csd###### row_w = %d,column_w = %d \n",row_w,column_w), UVM_MEDIUM)
            for (int h = 0 ;h <= row_w ;h++) begin
                for (int i = 0 ;i <= column_w;i++) begin
                    m_trans_axi_dn  = new("m_trans_axi_dn");
                    void'(m_trans_axi_dn.randomize());
                    case (align_byte_w[3 : 0])
                    4'h0: begin
                              if (i == column_w)
                                 break;
                               else
                                 m_trans_axi_dn.wdata = m_trans_sif_out.dn_data[(i + h*column_w) % data_size];
                           end
                    4'h1: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][119 : 0], 8'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {120'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 120]};
                                  else 
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][119 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 120]};
                             end
                    4'h2: begin
                             if (i == 0)
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][111 : 0], 16'h00}; 
                             else if (i == column_w)
                                 m_trans_axi_dn.wdata = {112'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 112]};
                             else
                                  m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][111 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 112]};
                           end
                    4'h3: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][103 : 0], 24'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {104'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 104]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][103 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 104]};
                           end
                    4'h4: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][95 : 0], 32'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {96'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 96]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][95 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 96]};
                           end
                    4'h5: begin
                             if (i == 0)
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][87 : 0], 40'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {88'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 88]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][87 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 88]};
                          end
                    4'h6: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][79 : 0], 48'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {80'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 80]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][79 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 80]};
                           end
                    4'h7: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][71 : 0], 56'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {72'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 72]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][71 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 72]};
                           end
                    4'h8: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][63 : 0], 64'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {64'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 64]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][63 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 64]};
                           end
                    4'h9: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][55 : 0], 72'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {56'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 56]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][55 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 56]};
                           end
                    4'hA: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][47 : 0], 80'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {48'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 48]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][47 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 48]};
                           end
                    4'hB: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][39 : 0], 88'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {40'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 40]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][39 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 40]};
                           end
                    4'hC: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][31 : 0], 96'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {32'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 32]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][31 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 32]};
                           end
                    4'hD: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][23 : 0], 104'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {24'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 24]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][23 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 24]};
                           end
                    4'hE: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][15 : 0], 112'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {16'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 16]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][15 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 16]};
                           end
                    4'hF: begin
                             if (i == 0) 
                                 m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][7 : 0], 120'h00}; 
                             else if (i == column_w)
                                      m_trans_axi_dn.wdata = {8'h00, m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 8]};
                                  else
                                      m_trans_axi_dn.wdata = {m_trans_sif_out.dn_data[(i + h*column_w) % data_size][7 : 0], m_trans_sif_out.dn_data[(i + h*column_w-1) % data_size][127 : 8]};
                           end
                    default: `uvm_info(get_name(),$psprintf("ERROR ========Alignment cannot be performed========"),UVM_MEDIUM)     
                    endcase
                    m_port_axi_out.write(m_trans_axi_dn);                             
                end
                align_byte_w = ((stride_w == 0)&&(i == column_w))? align_byte_w : align_byte_w + 16*column_w + stride_w;
            end
        end
    endtask : dnstream_write_128
endclass: c_rm

`endif //C_RM__SV
