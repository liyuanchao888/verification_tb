// reg_model.sv
`ifndef C_DMA_REG_MODEL__SV
`define C_DMA_REG_MODEL__SV
class id_field_reg extends uvm_reg;  //DMA ID and Version
   `uvm_object_utils(id_field_reg)
	rand uvm_reg_field build_field;  //DMA build version
	rand uvm_reg_field minor_field;  //DMA minor version
	rand uvm_reg_field major_field;  //DMA major version
	rand uvm_reg_field id_field;     //DMA ID
	virtual function void build();
		build_field = uvm_reg_field::type_id::create("build_field");
		minor_field = uvm_reg_field::type_id::create("minor_field");
		major_field = uvm_reg_field::type_id::create("major_field");
		id_field    = uvm_reg_field::type_id::create("id_field");
	endfunction : build
   function new( string name = "id_field_reg" );
      super.new(.name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : id_field_reg  

class status_field_reg extends uvm_reg;//DMA status
   `uvm_object_utils(status_field_reg)
	rand uvm_reg_field rbusy_field;   //DMA read path busy
	rand uvm_reg_field rerror_field;  //DMA read path error:MSB is ID mismatch,LSB[1:0] is rresp
	rand uvm_reg_field wbusy_field;   //DMA write path busy
	rand uvm_reg_field werror_field;  //DMA write path error:MSB is ID mismatch,LSB[1:0] is bresp
	virtual function void build();
		rbusy_field = uvm_reg_field::type_id::create("rbusy_field");
		rerror_field = uvm_reg_field::type_id::create("rerror_field");
		wbusy_field = uvm_reg_field::type_id::create("wbusy_field");
		werror_field = uvm_reg_field::type_id::create("werror_field");
	endfunction : build
   function new( string name = "status_field_reg" );
      super.new( .name( name ), .n_bits( 15 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : status_field_reg  


class rctrl_field_reg extends uvm_reg; //DMA read control
   `uvm_object_utils(rctrl_field_reg)
	rand uvm_reg_field start_field;   //write 1 to kick start DMA read 
	rand uvm_reg_field clrirq_field;  //clear IRQ status
	virtual function void build();
		start_field = uvm_reg_field::type_id::create("start_field");
		clrirq_field = uvm_reg_field::type_id::create("clrirq_field");
	endfunction : build
   function new( string name = "rctrl_field_reg" );
      super.new( .name( name ), .n_bits( 5 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : rctrl_field_reg  


class rmaddr_field_reg extends uvm_reg; //DMA read memory address
   `uvm_object_utils(rmaddr_field_reg)
	rand uvm_reg_field rmaddr_field;   //DMA read memory address 
	virtual function void build();
		rmaddr_field = uvm_reg_field::type_id::create("rmaddr_field");
	endfunction : build
   function new( string name = "rmaddr_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : rmaddr_field_reg  


class rsize_field_reg extends uvm_reg; //DMA read area size
   `uvm_object_utils(rsize_field_reg)
	rand uvm_reg_field width_field;   //width(in bytes)of the rectangular area in memory to be read 
	rand uvm_reg_field height_field;  //height(in bytes)of the rectangular area in memory to be read 
	virtual function void build();
		width_field = uvm_reg_field::type_id::create("width_field");
		height_field = uvm_reg_field::type_id::create("height_field");
	endfunction : build
   function new( string name = "rsize_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : rsize_field_reg  


class rcfg_field_reg extends uvm_reg;  //DMA read configutation
   `uvm_object_utils(rcfg_field_reg)
	rand uvm_reg_field channel_field;  //SIF channel for this DMA operation
	rand uvm_reg_field aid_field;      //ID used in AXI transactions
	rand uvm_reg_field irqen_field;    //Enable IRQ
	rand uvm_reg_field stride_field;   //stride(in byte)between 2 row in the area
	virtual function void build();
		channel_field = uvm_reg_field::type_id::create("channel_field");
		aid_field = uvm_reg_field::type_id::create("aid_field");
		irqen_field = uvm_reg_field::type_id::create("irqen_field");
		stride_field = uvm_reg_field::type_id::create("stride_field");
	endfunction : build
   function new( string name = "rcfg_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : rcfg_field_reg  

class block_size_reg extends uvm_reg;  //DMA read block size
	`uvm_object_utils(block_size_reg)
    rand uvm_reg_field block_size;
    virtual function void build();
		block_size = uvm_reg_field::type_id::create("block_size");
	endfunction : build
   function new( string name = "block_size_reg" );
      super.new( .name( name ), .n_bits( 16 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : block_size_reg

class wctrl_field_reg extends uvm_reg; //DMA write control
   `uvm_object_utils(wctrl_field_reg)
	rand uvm_reg_field start_field;   //write 1 to kick start DMA write
	rand uvm_reg_field clrirq_field;  //clear IRQ status
	virtual function void build();
		start_field = uvm_reg_field::type_id::create("start_field");
		clrirq_field = uvm_reg_field::type_id::create("clrirq_field");
	endfunction : build
   function new( string name = "wctrl_field_reg" );
      super.new(.name( name ), .n_bits( 5 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : wctrl_field_reg  


class wmaddr_field_reg extends uvm_reg; //DMA write memory address
   `uvm_object_utils(wmaddr_field_reg)
	rand uvm_reg_field wmaddr_field;   //DMA write memory address 
	virtual function void build();
		wmaddr_field = uvm_reg_field::type_id::create("wmaddr_field");
	endfunction : build
   function new( string name = "wmaddr_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : wmaddr_field_reg  


class wsize_field_reg extends uvm_reg; //DMA write area size
   `uvm_object_utils(wsize_field_reg)
	rand uvm_reg_field width_field;   //width(in bytes)of the rectangular area in memory to be written 
	rand uvm_reg_field height_field;  //height(in bytes)of the rectangular area in memory to be written
	virtual function void build();
		width_field = uvm_reg_field::type_id::create("width_field");
		height_field = uvm_reg_field::type_id::create("height_field");
	endfunction : build
   function new( string name = "wsize_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : wsize_field_reg  


class wcfg_field_reg extends uvm_reg;  //DMA write configutation
   `uvm_object_utils(wcfg_field_reg)
	rand uvm_reg_field channel_field;  //SIF channel for this DMA operation
	rand uvm_reg_field aid_field;      //ID used in AXI transactions
	rand uvm_reg_field irqen_field;    //Enable IRQ
	rand uvm_reg_field stride_field;   //stride(in byte)between 2 row in the area
	virtual function void build();
		channel_field = uvm_reg_field::type_id::create("channel_field");
		aid_field = uvm_reg_field::type_id::create("aid_field");
		irqen_field = uvm_reg_field::type_id::create("irqen_field");
		stride_field = uvm_reg_field::type_id::create("stride_field");
	endfunction : build
   function new( string name = "wcfg_field_reg" );
      super.new( .name( name ), .n_bits( 32 ), .has_coverage( UVM_NO_COVERAGE ));
   endfunction: new
endclass : wcfg_field_reg  


class c_reg_model extends uvm_reg_block;
   `uvm_object_utils(c_reg_model)
	rand id_field_reg      id_reg;
	rand status_field_reg  status_reg;
	rand rctrl_field_reg   rctrl_reg;
	rand rmaddr_field_reg  rmaddr_reg;
	rand rsize_field_reg   rsize_reg;
	rand rcfg_field_reg    rcfg_reg;
	rand wctrl_field_reg   wctrl_reg;
	rand wmaddr_field_reg  wmaddr_reg;
	rand wsize_field_reg   wsize_reg;
	rand wcfg_field_reg    wcfg_reg;
    rand block_size_reg    block_reg;

	virtual function void build();
	    this.default_map = create_map("default_map", 12'h000, 4, UVM_LITTLE_ENDIAN);
		id_reg = id_field_reg::type_id::create("id_reg");
		id_reg.configure(this, null, "");
		id_reg.build();
		id_reg.build_field.configure(id_reg, 8, 0, "RW", 1, 0, 1, 1, 1);
		id_reg.add_hdl_path_slice("build_field", 0, 2);
		id_reg.minor_field.configure(id_reg, 8, 8, "RW", 1, 0, 1, 1, 1);
		id_reg.add_hdl_path_slice("minor_field", 8, 8);
		id_reg.major_field.configure(id_reg, 8, 16, "RW", 1, 0, 1, 1, 1);
		id_reg.add_hdl_path_slice("major_field", 16, 8);
		id_reg.id_field.configure(id_reg, 8, 24, "RW", 1, 0, 1, 1, 1);
		id_reg.add_hdl_path_slice("id_field", 24, 8);

		status_reg = status_field_reg::type_id::create("status_reg", , get_full_name());
		status_reg.configure(this, null, "");
		status_reg.build();
		status_reg.rbusy_field.configure(status_reg, 1, 0, "RW", 1, 0, 1, 1, 1);
		status_reg.add_hdl_path_slice("rbusy_field", 0, 1);
		status_reg.rerror_field.configure(status_reg, 3, 4, "RW", 1, 0, 1, 1, 1);
		status_reg.add_hdl_path_slice("rerror_field", 4, 3);
		status_reg.wbusy_field.configure(status_reg, 1, 8, "RW", 1, 0, 1, 1, 1);
		status_reg.add_hdl_path_slice("wbusy_field", 8, 1);
		status_reg.werror_field.configure(status_reg, 3, 12, "RW", 1, 0, 1, 1, 1);
		status_reg.add_hdl_path_slice("werror_field", 12, 3);


		rctrl_reg = rctrl_field_reg::type_id::create("rctrl_reg", , get_full_name());
		rctrl_reg.configure(this, null, "");
		rctrl_reg.build();
		rctrl_reg.start_field.configure(rctrl_reg, 1, 0, "RW", 1, 0, 1, 1, 1);
		rctrl_reg.add_hdl_path_slice("start_field", 0, 1);
		rctrl_reg.clrirq_field.configure(rctrl_reg, 1, 4, "RW", 1, 0, 1, 1, 1);
		rctrl_reg.add_hdl_path_slice("clrirq_field", 4, 1);


		rmaddr_reg = rmaddr_field_reg::type_id::create("rmaddr_reg", , get_full_name());
		rmaddr_reg.configure(this, null, "");
		rmaddr_reg.build();
		rmaddr_reg.rmaddr_field.configure(rmaddr_reg, 32, 0, "RW", 1, 0, 1, 1, 1);
		rmaddr_reg.add_hdl_path_slice("rmaddr_field", 0, 32);


		rsize_reg = rsize_field_reg::type_id::create("rsize_reg", , get_full_name());
		rsize_reg.configure(this, null, "");
		rsize_reg.build();
		rsize_reg.width_field.configure(rsize_reg, 16, 0, "RW", 1,16'h55 , 1, 1, 1);
		rsize_reg.add_hdl_path_slice("width_field", 0, 16);
		rsize_reg.height_field.configure(rsize_reg, 16, 16, "RW", 1, 16'h45, 1, 1, 1);
		rsize_reg.add_hdl_path_slice("height_field", 16, 16);


		rcfg_reg = rcfg_field_reg::type_id::create("rcfg_reg", , get_full_name());
		rcfg_reg.configure(this, null, "");
		rcfg_reg.build();
		rcfg_reg.channel_field.configure(rcfg_reg, 3, 0, "RW", 1, 0, 1, 1, 1);
		rcfg_reg.add_hdl_path_slice("channel_field", 0, 3);
		rcfg_reg.aid_field.configure(rcfg_reg, 4, 8, "RW", 1, 0, 1, 1, 1);
		rcfg_reg.add_hdl_path_slice("aid_field", 8, 4);
		rcfg_reg.irqen_field.configure(rcfg_reg, 1, 12, "RW", 1, 0, 1, 1, 1);
		rcfg_reg.add_hdl_path_slice("irqen_field", 12, 1);
		rcfg_reg.stride_field.configure(rcfg_reg, 16, 16, "RW", 1, 0, 1, 1, 1);
		rcfg_reg.add_hdl_path_slice("stride_field", 16, 16);

		wctrl_reg = wctrl_field_reg::type_id::create("rctrl_reg", , get_full_name());
		wctrl_reg.configure(this, null, "");
		wctrl_reg.build();
		wctrl_reg.start_field.configure(wctrl_reg, 1, 0, "RW", 1, 0, 1, 1, 1);
		wctrl_reg.add_hdl_path_slice("start_field", 0, 1);
		wctrl_reg.clrirq_field.configure(wctrl_reg, 1, 4, "RW", 1, 0, 1, 1, 1);
		wctrl_reg.add_hdl_path_slice("clrirq_field", 4, 1);

		wmaddr_reg = wmaddr_field_reg::type_id::create("wmaddr_reg", , get_full_name());
		wmaddr_reg.configure(this, null, "");
		wmaddr_reg.build();
		wmaddr_reg.wmaddr_field.configure(wmaddr_reg, 32, 0, "RW", 1, 0, 1, 1, 1);
		wmaddr_reg.add_hdl_path_slice("wmaddr_field", 0, 32);

		wsize_reg = wsize_field_reg::type_id::create("wsize_reg", , get_full_name());
		wsize_reg.configure(this, null, "");
		wsize_reg.build();
		wsize_reg.width_field.configure(wsize_reg, 16, 0, "RW", 1, 0, 1, 1, 1);
		wsize_reg.add_hdl_path_slice("width_field", 0, 16);
		wsize_reg.height_field.configure(wsize_reg, 16, 16, "RW", 1, 0, 1, 1, 1);
		wsize_reg.add_hdl_path_slice("height_field", 16, 16);

		wcfg_reg = wcfg_field_reg::type_id::create("wcfg_reg", , get_full_name());
		wcfg_reg.configure(this, null, "");
		wcfg_reg.build();
		wcfg_reg.channel_field.configure(wcfg_reg, 3, 0, "RW", 1, 0, 1, 1, 1);
		wcfg_reg.add_hdl_path_slice("channel_field", 0, 3);
		wcfg_reg.aid_field.configure(wcfg_reg, 4, 8, "RW", 1, 0, 1, 1, 1);
		wcfg_reg.add_hdl_path_slice("aid_field", 8, 4);
		wcfg_reg.irqen_field.configure(wcfg_reg, 1, 12, "RW", 1, 0, 1, 1, 1);
		wcfg_reg.add_hdl_path_slice("irqen_field", 12, 1);
		wcfg_reg.stride_field.configure(wcfg_reg, 16, 16, "RW", 1, 0, 1, 1, 1);
		wcfg_reg.add_hdl_path_slice("stride_field", 16, 16);

		block_reg = block_size_reg::type_id::create("block_reg", , get_full_name());
		block_reg.configure(this, null, "");
		block_reg.build();
		block_reg.block_size.configure(block_reg, 16, 0, "RW", 1, 0, 1, 1, 1);
		block_reg.add_hdl_path_slice("block_size", 0, 16);
        
        default_map.add_reg(id_reg, 'h000, "RW");
		default_map.add_reg(status_reg, 'h004, "RW");
		default_map.add_reg(rctrl_reg, 'h010, "RW");
		default_map.add_reg(rmaddr_reg, 'h014, "RW");
		default_map.add_reg(rsize_reg, 'h018, "RW");
		default_map.add_reg(rcfg_reg, 'h01C, "RW");
		default_map.add_reg(wctrl_reg, 'h020, "RW");
        default_map.add_reg(wmaddr_reg, 'h024, "RW");
		default_map.add_reg(wsize_reg, 'h028, "RW");
		default_map.add_reg(wcfg_reg, 'h02C, "RW");
		default_map.add_reg(block_reg, 'h030, "RW");
	endfunction : build
   function new( string name = "c_reg_model" );
      super.new( name, UVM_NO_COVERAGE);
   endfunction: new

endclass : c_reg_model

`endif //C_DMA_REG_MODEL__SV



