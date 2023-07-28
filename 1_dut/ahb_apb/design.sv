
module ahb2apb 
			   #(parameter NO_OF_SLAVES 		= 8,
			   	 parameter ADDR_WIDTH 			= 32,
			   	 parameter DATA_WIDTH 			= 32,
			   	 parameter SLAVE_START_ADDR_0 	= 32'h000,
			   	 parameter SLAVE_END_ADDR_0 	= 32'h0ff,
			   	 parameter SLAVE_START_ADDR_1 	= 32'h100,
			   	 parameter SLAVE_END_ADDR_1 	= 32'h1ff,
			   	 parameter SLAVE_START_ADDR_2 	= 32'h200,
			   	 parameter SLAVE_END_ADDR_2 	= 32'h2ff,
			   	 parameter SLAVE_START_ADDR_3 	= 32'h300,
			   	 parameter SLAVE_END_ADDR_3 	= 32'h3ff,
			   	 parameter SLAVE_START_ADDR_4 	= 32'h400,
			   	 parameter SLAVE_END_ADDR_4 	= 32'h4ff,
			   	 parameter SLAVE_START_ADDR_5 	= 32'h500,
			   	 parameter SLAVE_END_ADDR_5 	= 32'h5ff,
			   	 parameter SLAVE_START_ADDR_6 	= 32'h600,
			   	 parameter SLAVE_END_ADDR_6 	= 32'h6ff,
			   	 parameter SLAVE_START_ADDR_7 	= 32'h700,
			   	 parameter SLAVE_END_ADDR_7 	= 32'h7ff)
			   
			    (HCLK, HRESETn, HADDR, HTRANS, HWRITE, HWDATA, HSELAHB,
				 HRDATA, HREADY, HRESP,
				 PRDATA, PSLVERR, PREADY,
				 PWDATA, PENABLE, PSELx, PADDR, PWRITE);

// AHB SIGNALS

	input	wire 						HCLK;
	input	wire 						HRESETn;
	input	wire 	[ADDR_WIDTH - 1:0]	HADDR;
	input	wire 	[1:0]				HTRANS;
	input	wire						HWRITE;
	input	wire	[DATA_WIDTH - 1:0]	HWDATA;
	input	wire						HSELAHB;
	
	output	reg 	[DATA_WIDTH - 1:0]	HRDATA;
	output	reg 						HREADY;
	output	reg 						HRESP;
	
// APB SIGNALS
	
	input	wire 	[DATA_WIDTH - 1:0]  PRDATA	[NO_OF_SLAVES - 1:0];
	input	wire	[NO_OF_SLAVES - 1:0]PSLVERR;
	input 	wire 	[NO_OF_SLAVES - 1:0]PREADY;
	
	output	reg 	[DATA_WIDTH - 1:0]	PWDATA;
	output	reg 						PENABLE;
	output	reg 	[NO_OF_SLAVES - 1:0]PSELx;
	output	reg 	[ADDR_WIDTH - 1:0]	PADDR;
	output	reg 						PWRITE;
	
// INTERNAL SIGNALS

			reg		[ADDR_WIDTH - 1:0]	HADDR_Temp;
			reg		[ADDR_WIDTH - 1:0]	HADDR_Temp2;
			reg		[DATA_WIDTH - 1:0]	HWDATA_Temp;
			reg		[NO_OF_SLAVES - 1:0]PSELx_Temp;
			reg		[NO_OF_SLAVES - 1:0]PSELx_Curr;
			reg		[2:0]				Slave_number;
			
// STATES
			
	typedef enum {IDLE, READ, W_WAIT, WRITE,
				  WRITE_P, W_ENABLE, W_ENABLE_P, R_ENABLE} states;
				  
			states	current_state;
			states	next_state;
			
// CONTROL SIGNALS
			
			reg		valid;
			reg		HWRITE_Reg;
		
// CONTROL SIGNALS ASSIGNMENT
			
	always @ (negedge HCLK)
	begin
		
		if(HRESETn == `RESET)
			valid = `INVALID;
		else
			if(HSELAHB && (HTRANS == `T_NONSEQ || HTRANS == `T_SEQ))
				valid = `VALID;
			else
				valid = `INVALID;
	end

//STATE CHANGE ASSIGNMENT 

	always @ (negedge HCLK)
	begin
		
		if(PSLVERR[Slave_number] == `NO_ERROR)
		begin
			if(HRESETn == `RESET)
				current_state 	=  IDLE;
			else
				current_state 	<=  next_state;
			HRESP			= `NO_ERROR;
		end
		else
		begin
			current_state 	= IDLE;
			HRESP			= `ERROR;
		end
	end	

//MAIN FSM		

	always @ (posedge HCLK)
	begin
	
		case (current_state)
		
			IDLE:	begin
			
				PSELx 	= `PSELx_Default;
				PENABLE = `DISABLE_;
				HREADY	= `READY;
				
				if(valid == `INVALID)
					next_state <= IDLE;
				else if (valid == `VALID)
				begin
					HADDR_Temp	= HADDR;
					if(HWRITE == `READ)
						next_state <= READ;
					else if (HWRITE == `WRITE)
						next_state <= W_WAIT;
				end
			end
			
			READ:	begin
			
				PSELx	= PSELx_Curr;
				PADDR	= HADDR_Temp;
				PWRITE	= `READ;
				PENABLE	= `DISABLE_;
				HREADY	= `READY;

				next_state <= R_ENABLE;	
			end
			
			W_WAIT:	begin

				
				PENABLE		= `DISABLE_;
				HWRITE_Reg	= HWRITE;
				PSELx_Temp	= PSELx_Curr;
				HWDATA_Temp = HWDATA;
				HADDR_Temp2 = HADDR_Temp;

				if(valid == `INVALID)
				begin

					HREADY		= `READY;
					next_state <= WRITE;
				end
				else if(valid == `VALID)
				begin
					
					next_state <= WRITE_P;
					HADDR_Temp  = HADDR;
					HREADY		= `NOT_READY;
				end
			end
			
			WRITE:	begin

				HREADY 	= `READY;
				PSELx 	= PSELx_Temp;
				PADDR 	= HADDR_Temp2;
				PWDATA 	= HWDATA_Temp;
				PWRITE 	= `WRITE;
				PENABLE = `DISABLE_;

				if(valid == `INVALID)
					next_state <= W_ENABLE;
				else if (valid == `VALID)
					next_state <= W_ENABLE_P;
			end
			
			WRITE_P:	begin

				PSELx 		= PSELx_Temp;
				PADDR 		= HADDR_Temp2;
				PWDATA		= HWDATA_Temp;
				HWDATA_Temp = HWDATA;
				PWRITE		= `WRITE;
				PENABLE		= `DISABLE_;

				HREADY		= `READY;
				HADDR_Temp2	= HADDR_Temp;
				HWRITE_Reg	= HWRITE;
				PSELx_Temp	= PSELx_Curr;

				next_state <= W_ENABLE_P;
			end
			
			W_ENABLE:	begin
				if(PREADY[Slave_number]==`READY)
				begin
					PENABLE	= `ENABLE;
					HREADY	= `NOT_READY;
	
					if(valid == `VALID && HWRITE == `READ)
						next_state <= READ;
					else if (valid == `VALID && HWRITE ==`WRITE)
						next_state <= W_WAIT;
						 else if (valid == `INVALID)
							next_state <= IDLE;
				end
				else
					next_state <= W_ENABLE;
			end
			
			W_ENABLE_P:	begin
				if(PREADY[Slave_number]==`READY)
				begin
					PENABLE = `ENABLE;
					HREADY 	= `NOT_READY;

					// HWDATA_Temp = HWDATA;
					PSELx_Temp	= PSELx_Curr;
					HADDR_Temp 	= HADDR;

					if(valid == `VALID && HWRITE == `WRITE)
						next_state <= WRITE_P;
					else if (valid == `INVALID && HWRITE == `WRITE)
						next_state <= WRITE;
						else if(HWRITE == `READ)
							next_state <= READ;

				end
				else
					next_state <= W_ENABLE_P;			
			end
			
			R_ENABLE:	begin
				if(PREADY[Slave_number]==`READY)
				begin
					PENABLE	= `ENABLE;
					HRDATA 	= PRDATA[Slave_number];
					HREADY	= `READY;

					HADDR_Temp	= HADDR;
					
	
					if(valid == `INVALID)
						next_state <= IDLE;
					else if(HWRITE == `READ)
						next_state <= READ;
					else if (HWRITE == `WRITE)
						next_state <= W_WAIT;
				end
				else
					next_state <= R_ENABLE;					
			end
		endcase
	end
	
//SLAVE SELECTOR

	always @(posedge HCLK)
	begin

		PSELx_Curr			= `SLAVE_DEFAULT;
		Slave_number		= `SLAVE_NO_DEFAULT;
		if((HADDR_Temp >= SLAVE_START_ADDR_0) && (HADDR_Temp <= SLAVE_END_ADDR_0) && (NO_OF_SLAVES >= 1)) 
		begin
			PSELx_Curr 		= `SLAVE_1;
			Slave_number	= `SLAVE_NO_1;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_1) && (HADDR_Temp <= SLAVE_END_ADDR_1) && (NO_OF_SLAVES >= 2)) 
		begin	
			PSELx_Curr 		= `SLAVE_2;
			Slave_number	= `SLAVE_NO_2;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_2) && (HADDR_Temp <= SLAVE_END_ADDR_2) && (NO_OF_SLAVES >= 3)) 
		begin
			PSELx_Curr 		= `SLAVE_3;
			Slave_number	= `SLAVE_NO_3;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_3) && (HADDR_Temp <= SLAVE_END_ADDR_3) && (NO_OF_SLAVES >= 4)) 
		begin
			PSELx_Curr 		= `SLAVE_4;
			Slave_number	= `SLAVE_NO_4;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_4) && (HADDR_Temp <= SLAVE_END_ADDR_4) && (NO_OF_SLAVES >= 5)) 
		begin
			PSELx_Curr 		= `SLAVE_5;
			Slave_number	= `SLAVE_NO_5;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_5) && (HADDR_Temp <= SLAVE_END_ADDR_5) && (NO_OF_SLAVES >= 6)) 
		begin
			PSELx_Curr 		= `SLAVE_6;
			Slave_number	= `SLAVE_NO_6;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_6) && (HADDR_Temp <= SLAVE_END_ADDR_6) && (NO_OF_SLAVES >= 7)) 
		begin
			PSELx_Curr 		= `SLAVE_7;
			Slave_number	= `SLAVE_NO_7;
		end
		if((HADDR_Temp >= SLAVE_START_ADDR_7) && (HADDR_Temp <= SLAVE_END_ADDR_7) && (NO_OF_SLAVES >= 8)) 
		begin
			PSELx_Curr 		= `SLAVE_8;
			Slave_number	= `SLAVE_NO_8;
		end
	end

endmodule
