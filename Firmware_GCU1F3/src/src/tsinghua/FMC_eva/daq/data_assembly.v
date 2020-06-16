`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IHEP
// Engineer: Hu Jun
// 
// Create Date:    22:20:44 10/16/2018 
// Design Name: 
// Module Name:    data_assembly 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_assembly#
(parameter [31:0] CONFIG_BASE_ADDR = 32'h0000)
(
  input           init_clk,
  input           reset_i,
  input						trig_in,
  output					trig_out,
  output					daq_rst,
  output [15:0] 	sample_count_value,
  output 					trigger_stun, 
  // Bus interface
  input           config_din_valid,
  input	 [31:0] 	config_din_addr, 
	input  [31:0]   config_din_data,
  output 	      	config_dout_valid,
  output [31:0] 	config_dout_addr,
  output [31:0]   config_dout_data,
  // raw data input
  input	 [255:0]	adc_raw_data,
  input	 [1:0]	  adc_user_clk,
  // data channel output
  input  [1:0] 		data_channel_fifo_rd_en,
  output [31:0]   data_channel_fifo_out,
  output [1:0] 		data_channel_fifo_full,
  output [1:0] 		data_channel_fifo_empty,
  // trigger gen
	output [15:0] 	trigger_reg    
  );

reg sample_reset,sample_start;
reg  [15:0] sample_count_value_r,trig_latency_count_value_r,sample_delay_count_value_r,trigger_reg_r;
reg  [15:0] config_daq2c;
reg	config_daq2c_valid;

wire 			daq_rst_c = reset_i | sample_reset;
reg [7:0] daq_rst_r;
assign daq_rst = |daq_rst_r;
always @ (posedge init_clk) begin 
	daq_rst_r <= {daq_rst_r[6:0],daq_rst_c};
end

assign 	 sample_count_value = sample_count_value_r;
assign	 trigger_reg = trigger_reg_r;
wire [1:0] data_channel_fifo_prog_full;
assign trigger_stun = |data_channel_fifo_prog_full;
reg [15:0] thrd_value_r;
reg overthd_count_8ns_r;

// baseline 128ns
wire [18:0] sum_8wfm, sum_128wfm;
wire [15:0] avg_8wfm, avg_128wfm, baseline;
reg [271:0] avg_8wfm_r;
reg [19:0] avgs_128wfm_r;
assign sum_8wfm = adc_raw_data[127:112]+adc_raw_data[111:96]+adc_raw_data[95:80]+adc_raw_data[79:64]+adc_raw_data[63:48]+adc_raw_data[47:32]+adc_raw_data[31:16]+adc_raw_data[15:0];
assign avg_8wfm = sum_8wfm[18:3];
assign baseline = avgs_128wfm_r[19:4];

generate
genvar j;
for(j=1;j<=16;j=j+1) begin
always @ (posedge adc_user_clk[0]) begin
		if(daq_rst) avg_8wfm_r[16*j+15:16*j] <= 16'h0;
		else avg_8wfm_r[16*j+15:16*j] <= avg_8wfm_r[16*j-1:16*(j-1)];
end
end
endgenerate

always @ (posedge adc_user_clk[0]) begin
	if(daq_rst) begin
		avg_8wfm_r[15:0] <= 16'h0;
		avgs_128wfm_r <= 19'h0;
	end
	else begin
		avg_8wfm_r[15:0] <= avg_8wfm;
		avgs_128wfm_r <= avgs_128wfm_r + avg_8wfm_r[15:0] - avg_8wfm_r[271:256];
	end
end

// over threshold 
wire [7:0] overthd;
wire [15:0] dym_thrd = baseline - thrd_value_r;
assign overthd ={adc_raw_data[127:112] < dym_thrd, adc_raw_data[111:96] < dym_thrd, adc_raw_data[95:80] < dym_thrd, adc_raw_data[79:64] < dym_thrd,
					  adc_raw_data[63:48] < dym_thrd, adc_raw_data[47:32] < dym_thrd, adc_raw_data[31:16] < dym_thrd, adc_raw_data[15:0] < dym_thrd};

wire overthd_count_8ns;
//reg [9:0] overthd_count_8ns_r;
//wire overthd_count_80ns;
//reg overthd_count_80ns_temp;

assign overthd_count_8ns = |overthd;
//assign overthd_count_80ns = |overthd_count_8ns_r;
always @ (posedge adc_user_clk[0]) begin
	if(daq_rst)
		overthd_count_8ns_r <= 10'h0;
	else
		overthd_count_8ns_r <= overthd_count_8ns;
end
//Signal_CrossDomain
  Signal_CrossDomain signal_overthd_count_8ns_r (
    .SignalIn_clkA(overthd_count_8ns_r),
    .clkB(init_clk),
    .SignalOut_clkB(trig_out)
  );
  	 
// state machine //  													
localparam
  SAMPLE_IDLE 	= 0,
  HEADER 				= 1,
  SAMPLING    	= 2,
  ENDER    			= 3,  
  SAMPLE_WAIT 	= 4;
genvar i;
generate
for(i=0;i<=1;i=i+1) begin : data_channel_proc
wire				channel_num = i;
reg  [15:0] samping_count,trig_latency_count,sample_delay_count;


  	 
wire [127:0] 	trig_latency_fifo_out;
wire					trig_latency_fifo_full;
wire					trig_latency_fifo_empty;

reg 					data_channel_fifo_wren;
reg  [127:0] 	data_channel_fifo_in;  

// trig latency fifo
trig_latency_fifo fifo_128x512(
    .clk(adc_user_clk[i]), // input clk
    .rst(daq_rst), // input rst	 
    .din(adc_raw_data[128*i+127:128*i]), // input [127 : 0] din 
    .wr_en(trig_latency_count <= trig_latency_count_value_r && trig_latency_count_value_r != 10'h0), // input wr_en	 
    .rd_en(trig_latency_count >= trig_latency_count_value_r && trig_latency_count_value_r != 10'h0), // input rd_en
    .dout(trig_latency_fifo_out), // output [127 : 0] dout
    .full(trig_latency_fifo_full), // output full
    .empty(trig_latency_fifo_empty) // output empty
  );
// data fifo
data_channel_fifo dfifo_128x2048(
    .rst(daq_rst), // input asynchronous reset
    .wr_clk(adc_user_clk[i]), // input wr_clk
    .wr_en(data_channel_fifo_wren), // input wr_en
    .din(data_channel_fifo_in), // input [127 : 0] din//samping_count[3:0]
    .rd_clk(init_clk), // input rd_clk
    .rd_en(data_channel_fifo_rd_en[i]), // input rd_en
    .dout(data_channel_fifo_out[16*i+15:16*i]), // output [15 : 0] dout
    .full(data_channel_fifo_full[i]), // output full
    .prog_full(data_channel_fifo_prog_full[i]),
    .empty(data_channel_fifo_empty[i]) // output empty
  );
 
 
(*KEEP = "TRUE"*)wire start_adc,start_adc_plus;
reg [1:0] trig_in_plus_r;
reg [15:0] trig_num;
reg [63:0]	time_cnt;
always @ (posedge adc_user_clk[i]) begin
	if(daq_rst) begin
		time_cnt <= 64'h0;
		trig_in_plus_r <= 2'b00;
	end else		
		time_cnt <= time_cnt + 1'b1;
		trig_in_plus_r[1] <= trig_in_plus_r[0];
		trig_in_plus_r[0] <= trig_in;
end
assign start_adc = trig_in_plus_r[1];
assign start_adc_plus = trig_in_plus_r[0] & ~trig_in_plus_r[1];

 
reg [2:0] sample_current_state, sample_next_state;
always @(posedge adc_user_clk[i] or posedge daq_rst) begin
  if (daq_rst) sample_current_state <= SAMPLE_IDLE;
  else sample_current_state <= sample_next_state;
end

always @(*) begin
	sample_next_state = SAMPLE_IDLE;
	  case(sample_current_state)
		SAMPLE_IDLE: begin	
			if(sample_start && start_adc) sample_next_state = HEADER;//start_adc_plus
			else sample_next_state = SAMPLE_IDLE;
		end
		HEADER: begin
			sample_next_state = SAMPLING;
		end
		SAMPLING: begin
			if(samping_count == sample_count_value_r - 2'h2) sample_next_state = ENDER;
			else sample_next_state = SAMPLING;
		end
		ENDER: begin
			sample_next_state = SAMPLE_WAIT;
		end			
		SAMPLE_WAIT: begin
		  if(sample_delay_count == sample_delay_count_value_r + 1'b1) sample_next_state = SAMPLE_IDLE;
			else sample_next_state = SAMPLE_WAIT;
		end
		default:sample_next_state = SAMPLE_IDLE;
	  endcase
end

always @ (posedge adc_user_clk[i]) begin
  if (daq_rst) begin
		data_channel_fifo_in <= 128'h0;
		samping_count <= 16'h0;
		sample_delay_count <= 16'h0;
		data_channel_fifo_wren <= 0;			
	end
  else begin
	case(sample_next_state)
    SAMPLE_IDLE: begin
			data_channel_fifo_in <= 128'h0;
			samping_count <= 16'h0;
			sample_delay_count <= 16'h0;	
			data_channel_fifo_wren <= 0;			
    end
		HEADER: begin
			data_channel_fifo_in <= {
									  1'b1,15'h5A, 
									  15'h0,channel_num,
									  sample_count_value_r,
									  trig_num,
									  time_cnt[63:48],
									  time_cnt[47:32],
									  time_cnt[31:16],
									  time_cnt[15:0]};
			data_channel_fifo_wren <= 1;
		end
    SAMPLING: begin
      samping_count <= samping_count + 1'b1;
			data_channel_fifo_in <= ((trig_latency_count_value_r == 10'h0)? adc_raw_data[128*i+127:128*i] : trig_latency_fifo_out);		
			data_channel_fifo_wren <= 1;
    end
		ENDER: begin
			data_channel_fifo_in <= {
									  16'h55aa,
									  16'h0123,
									  16'h4567,
									  16'h89ab,
									  16'hcdef,
									  16'hff00,
									  15'h0,channel_num,
									  1'b1,15'h69};
			data_channel_fifo_wren <= 1;
		end		
    SAMPLE_WAIT: begin
			sample_delay_count <= sample_delay_count + 1'b1;
			data_channel_fifo_wren <= 0;				
    end
    default:begin
			data_channel_fifo_in <= 128'h0;
			samping_count <= 16'h0;
			sample_delay_count <= 16'h0;
			data_channel_fifo_wren <= 0;			
	 	end
	endcase
  end  
end


//reg [1:0] sample_reset_r;
//always @ (posedge adc_user_clk[i]) begin
//		sample_reset_r[0] <= sample_reset;
//		sample_reset_r[1] <= sample_reset_r[0];		
//end

always @ (posedge adc_user_clk[i]) begin
	if(daq_rst)
		trig_num <= 16'h0;
//	else if(start_adc_plus && sample_current_state == SAMPLE_IDLE)
	else if(sample_next_state == HEADER)
		trig_num <= trig_num + 1'b1;
	else
		trig_num <= trig_num;		
end

always @ (posedge adc_user_clk[i]) begin
		if(daq_rst || trig_latency_count_value_r == 10'h0)
			trig_latency_count <= 10'h0;
		else if(trig_latency_count == trig_latency_count_value_r)
			trig_latency_count <= trig_latency_count;
		else if(trig_latency_count < trig_latency_count_value_r) 
			trig_latency_count <= trig_latency_count + 1'b1;
		else if(trig_latency_count > trig_latency_count_value_r) 
			trig_latency_count <= trig_latency_count - 1'b1;						
end
 
end
endgenerate

always @(posedge init_clk) begin
	if(reset_i) begin
		sample_reset <= 1'b0;
	 	sample_start <= 1'b1;
   	sample_delay_count_value_r <= 16'h0;   //trigger wait     //0x80:1K(1us)  0x100:2K    0x1000:32K
	 	sample_count_value_r <= 16'h42;  //trigger length   //0x80:1K(1us)  0x100:2K    0x1000:32K
	 	trig_latency_count_value_r <= 10'h0;   //trigger latency  //0x10:128ns
	 	thrd_value_r <= 16'h0010;
	 	trigger_reg_r <= 16'hE005;
    config_daq2c <= 0;
    config_daq2c_valid <= 0;
  end
  else begin
	 	sample_reset <= 1'b0;
    config_daq2c <= 0;
    config_daq2c_valid <= 0;
    if(config_din_valid & config_din_addr == CONFIG_BASE_ADDR) begin
			config_daq2c_valid <= 1;
      case (config_din_data[31:24])
        // 8'b1111_xxxx for write, 8'b0111_xxxx for read  // daq use 0x70~0x74
		  8'hF0: begin
			 		sample_reset <= config_din_data[1];
			 		sample_start <= config_din_data[0];
		  end
		  8'hF1: begin
			 		sample_count_value_r <= config_din_data[15:0];
		  end
		  8'h71: begin
			 		config_daq2c <= sample_count_value_r;
		  end		  
      8'hF2: begin
          sample_delay_count_value_r <= config_din_data[15:0];
        end
		  8'h72: begin
			 config_daq2c <= sample_delay_count_value_r;
		  end	
      8'hF3: begin
          trigger_reg_r <= config_din_data[15:0];
		  end
		  8'h73: begin
			 		config_daq2c <= trigger_reg_r;
		  end
      8'hF4: begin
          trig_latency_count_value_r <= config_din_data[9:0];			 			 
        end		 		 			 
		  8'h74: begin
			 		config_daq2c <= trig_latency_count_value_r;
		  end 
		  8'hF5: begin
          thrd_value_r <= config_din_data[15:0];			 			 
      end
		  8'h75: begin
          config_daq2c <= thrd_value_r;			 			 
      end            
		  default: begin
		   		sample_reset <= 1'b0;
			 		sample_start <= sample_start;
			 		sample_count_value_r <= sample_count_value_r;
          sample_delay_count_value_r <= sample_delay_count_value_r;
			 		trigger_reg_r <= trigger_reg_r;
			 		trig_latency_count_value_r <= trig_latency_count_value_r;
			 		thrd_value_r <= thrd_value_r;
          config_daq2c <= config_daq2c;
          config_daq2c_valid <= 0;
        end
      endcase
    end
  end
end

assign config_dout_valid = config_daq2c_valid;
assign config_dout_addr = config_din_addr;
assign config_dout_data = {config_din_data[31:24],8'h0,config_daq2c};


endmodule
