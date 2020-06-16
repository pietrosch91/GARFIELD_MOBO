`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IHEP
// Engineer: Hu Jun
// 
// Create Date:    19:47:49 01/28/2016 
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
module data_assembly #(
	                     parameter [10:0] fmc_reg_width = 3,
                       parameter [15:0] channel_num = 1)
   (
    // raw data input
    input [127:0]                      adc_raw_data,
    input                              adc_user_clk,

    input [15:0]                       gcu_id,
    input                              init_rst,
    input                              trig_in,
    input [63:0]                       time_cnt,
    output                             trig_out,
    // Bus interface
	  input                              config_din_valid,
	  input [31:0]                       config_din_addr,
	  input [31:0]                       config_din_data,

	  output                             config_dout_valid,
	  output [31:0]                      config_dout_addr,
	  output [31:0]                      config_dout_data,

    // data channel output
    input                              init_clk,
    input [1:0]                        data_channel_fifo_rd_en,
    output [255:0]                     data_channel_fifo_out,
    output [1:0]                       data_channel_fifo_out_valid,
    output [1:0]                       data_channel_fifo_full,
    output [1:0]                       data_channel_fifo_empty,
    //
    output [15:0]                      windows_cnt, // windows size after trigger
    input                              start_out,
    input [2**fmc_reg_width*32 -1 : 0] fmc_reg  
    );

   reg                                 sample_reset,sample_start;
   reg [15:0]                          sample_count_value_r,trig_latency_count_value_r,sample_delay_count_value_r;
   reg [15:0]                          samping_count,trig_latency_count,sample_delay_count;
   reg                                 extrig_en_r;

   wire                                reset_i = init_rst | sample_reset;
   reg [9:0]                           reset_r;
   always @ (posedge adc_user_clk) 	
	   if(reset_i) reset_r <= 10'b0;
	   else if(~reset_r[9]) reset_r <= reset_r + 1'b1;
   wire                                reset_i_dly = ~reset_r[9]; // delay after fifo's reset for safe.	 

   assign windows_cnt = sample_count_value_r;
   wire [1:0]                          trigger_type = 2'b01;//01:normal trigger, 10:supernove trigger, 00: calibration, 11:test,
	 
   wire [127:0]                        trig_latency_fifo_out;
   (*KEEP = "TRUE"*)wire					trig_latency_fifo_full;
   (*KEEP = "TRUE"*)wire					trig_latency_fifo_empty;
   (*KEEP = "TRUE"*)wire [10:0]  trig_latency_fifo_data_count;

   wire                                trig_latency_fifo_wren = ~reset_i_dly && trig_latency_count <= trig_latency_count_value_r;
   wire                                trig_latency_fifo_rden = ~reset_i_dly && trig_latency_count >= trig_latency_count_value_r;

   // trig latency fifo that can be bypassed.
   // This ring buffer should run all the time.
   trig_latency_fifo fifo_128x2048(
                                   .clk(adc_user_clk), // input clk
                                   .rst(reset_i), // input rst	 
                                   .din(adc_raw_data), // input [127 : 0] din 
                                   .wr_en(trig_latency_fifo_wren && trig_latency_count_value_r != 10'h0), // input wr_en	 
                                   .rd_en(trig_latency_fifo_rden && trig_latency_count_value_r != 10'h0), // input rd_en
                                   .dout(trig_latency_fifo_out), // output [127 : 0] dout
                                   .full(trig_latency_fifo_full), // output full
                                   .empty(trig_latency_fifo_empty), // output empty
                                   .data_count(trig_latency_fifo_data_count) // output [10 : 0] rd_data_count
                                   );

   reg [1:0]                           data_channel_fifo_wren;
   reg [127:0]                         data_channel_fifo_in;  
   (*KEEP = "TRUE"*) wire [11:0]  data_channel_fifo_rd_data_count;
   // data fifo that is small buffer for time cross domain.
   data_channel_fifo dfifo_128x64_internal(
                                           .rst(reset_i), // input asynchronous reset
                                           .wr_clk(adc_user_clk), // input wr_clk
                                           .wr_en(data_channel_fifo_wren[0]), // input wr_en
                                           .din(data_channel_fifo_in), // input [127 : 0] din
                                           .rd_clk(init_clk), // input rd_clk
                                           .rd_en(data_channel_fifo_rd_en[0]), // input rd_en
                                           .dout(data_channel_fifo_out[127:0]), // output [127 : 0] dout
                                           .valid(data_channel_fifo_out_valid[0]),
                                           .full(data_channel_fifo_full[0]), // output full
                                           .empty(data_channel_fifo_empty[0]), // output empty
                                           .rd_data_count(data_channel_fifo_rd_data_count[5:0]) // output [5 : 0] rd_data_count
                                           );
   data_channel_fifo dfifo_128x64_external(
                                           .rst(reset_i), // input asynchronous reset
                                           .wr_clk(adc_user_clk), // input wr_clk
                                           .wr_en(data_channel_fifo_wren[1]), // input wr_en
                                           .din(data_channel_fifo_in), // input [127 : 0] din
                                           .rd_clk(init_clk), // input rd_clk
                                           .rd_en(data_channel_fifo_rd_en[1]), // input rd_en
                                           .dout(data_channel_fifo_out[255:128]), // output [127 : 0] dout
                                           .valid(data_channel_fifo_out_valid[1]),
                                           .full(data_channel_fifo_full[1]), // output full
                                           .empty(data_channel_fifo_empty[1]), // output empty
                                           .rd_data_count(data_channel_fifo_rd_data_count[11:6]) // output [5 : 0] rd_data_count
                                           ); 
   
   (*KEEP = "TRUE"*)wire start_adc,start_adc_plus;
   reg [1:0]                           trig_in_plus_r;
   reg [15:0]                          trig_num;
//   reg [63:0]                          time_cnt;
   always @ (posedge adc_user_clk) begin
	    if(reset_i_dly) begin
		    // time_cnt <= 64'h0;
		     trig_in_plus_r <= 2'b00;
	    end else
		   // time_cnt <= time_cnt + 1'b1;
		  trig_in_plus_r[1] <= trig_in_plus_r[0];
	    if(extrig_en_r) 
		    trig_in_plus_r[0] <= trig_in;
	    else
		    trig_in_plus_r[0] <= time_cnt[22];
   end
   assign start_adc = trig_in_plus_r[1];
   assign start_adc_plus = trig_in_plus_r[0] & ~trig_in_plus_r[1];


   // state machine //  
     // package data from trigger latency fifo, then to data channle fifo.			
   // this fsm should be modified when trigger part added in 								
   localparam
     SAMPLE_IDLE 	= 0,
     HEADER 				= 1,
     SAMPLING    	= 2,
     ENDER    			= 3,  
     SAMPLE_WAIT 	= 4;
   
   reg [2:0] sample_current_state, sample_next_state;
   always @(posedge adc_user_clk or posedge reset_i_dly) begin
      if (reset_i_dly) sample_current_state <= SAMPLE_IDLE;
      else sample_current_state <= sample_next_state;
   end

   always @(*) begin
	    sample_next_state = SAMPLE_IDLE;
	    case(sample_current_state)
		    SAMPLE_IDLE: begin	
			     if(sample_start && start_adc_plus && start_out && (&data_channel_fifo_empty)) sample_next_state = HEADER;
			     else sample_next_state = SAMPLE_IDLE;
		    end
		    HEADER: begin
			     sample_next_state = SAMPLING;
		    end
		    //SEARCH:
		    //
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

   always @ (posedge adc_user_clk) begin
      if(reset_i_dly) begin
		     data_channel_fifo_in <= 128'h0;
		     samping_count <= 16'h0;
		     sample_delay_count <= 16'h0;
		     data_channel_fifo_wren <= 2'b00;			
	    end
      else begin
	       case(sample_next_state)
           SAMPLE_IDLE: begin
			        data_channel_fifo_in <= 128'h0;
			        samping_count <= 16'h0;
			        sample_delay_count <= 16'h0;	
			        data_channel_fifo_wren <= 2'b00;			
           end
		       HEADER: begin
			        data_channel_fifo_in <= {
									                     1'b1,15'h5A, 
									                     channel_num,
									                     sample_count_value_r,
									                     trig_num,
									                     time_cnt[63:48],
									                     time_cnt[47:32],
									                     time_cnt[31:16],
									                     time_cnt[15:0]};
			        data_channel_fifo_wren <= trigger_type;
		       end
           SAMPLING: begin
              samping_count <= samping_count + 1'b1;
			        data_channel_fifo_in <= ((trig_latency_count_value_r == 10'h0)? adc_raw_data : trig_latency_fifo_out);		
			        data_channel_fifo_wren <= trigger_type;
           end
		       ENDER: begin
			        data_channel_fifo_in <= {
									                     16'h55aa,
									                     16'h0123,
									                     16'h4567,
									                     16'h89ab,
									                     16'hcdef,
									                     16'hff00,
									                     gcu_id,
									                     1'b1,15'h69};
			        data_channel_fifo_wren <= trigger_type;
		       end		
           SAMPLE_WAIT: begin
			        sample_delay_count <= sample_delay_count + 1'b1;
			        data_channel_fifo_wren <= 2'b00;				
           end
           default:begin
			        data_channel_fifo_in <= 128'h0;
			        samping_count <= 16'h0;
			        sample_delay_count <= 16'h0;
			        data_channel_fifo_wren <= 2'b00;			
	 	       end
	       endcase
      end  
   end


   //reg [1:0] sample_reset_r;
   //always @ (posedge adc_user_clk) begin
   //		sample_reset_r[0] <= sample_reset;
   //		sample_reset_r[1] <= sample_reset_r[0];		
   //end

   always @ (posedge adc_user_clk) begin
	    if(reset_i_dly)
		    trig_num <= 16'h0;
	    else if(start_adc_plus && sample_current_state == SAMPLE_IDLE)
		    trig_num <= trig_num + 1'b1;
	    else
		    trig_num <= trig_num;		
   end

   always @ (posedge adc_user_clk) begin
		  if(reset_i_dly || trig_latency_count_value_r == 10'h0)
			  trig_latency_count <= 10'h0;
		  else if(trig_latency_count == trig_latency_count_value_r)
			  trig_latency_count <= trig_latency_count;
		  else if(trig_latency_count < trig_latency_count_value_r) 
			  trig_latency_count <= trig_latency_count + 1'b1;
		  else if(trig_latency_count > trig_latency_count_value_r) 
			  trig_latency_count <= trig_latency_count - 1'b1;						
   end

   reg [15:0] config_daq2c;
   reg        config_daq2c_valid;
   always @(posedge init_clk) begin
      if(reset_i_dly) begin
	       sample_reset <= 1'b0;
	       sample_start <= 1'b1;
         sample_delay_count_value_r <= 16'h00;   //trigger wait     //0x80:1K(1us)  0x100:2K    0x1000:32K
	       sample_count_value_r <= 16'h80;  			//trigger length   //0x80:1K(1us)  0x100:2K    0x1000:32K
	       trig_latency_count_value_r <= 10'h10;  //trigger latency  //0x10:128ns
	       extrig_en_r <= 1'b1;
         config_daq2c <= 0;
         config_daq2c_valid <= 0;
      end
      else begin
	       sample_reset <= 1'b0;
         config_daq2c <= 0;
         config_daq2c_valid <= 0;
         if(config_din_valid) begin
		        config_daq2c_valid <= 1;
            case (config_din_addr)
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
                 extrig_en_r <= config_din_data[0];
		          end
		          8'h73: begin
			 		       config_daq2c <= extrig_en_r;
		          end
              8'hF4: begin
                 trig_latency_count_value_r <= config_din_data[9:0];			 			 
              end		 		 			 
		          8'h74: begin
					       config_daq2c <= trig_latency_count_value_r;
		          end 
		          default: begin
				         sample_reset <= 1'b0;
				         sample_start <= sample_start;
				         sample_count_value_r <= sample_count_value_r;
	               sample_delay_count_value_r <= sample_delay_count_value_r;
				         extrig_en_r <= extrig_en_r;
				         trig_latency_count_value_r <= trig_latency_count_value_r;
	               config_daq2c <= config_daq2c;
	               config_daq2c_valid <= 0;
              end
            endcase
         end
      end
   end

   assign config_dout_data = {config_din_data[31:24],8'h0,config_daq2c};
   assign config_dout_valid = config_daq2c_valid;

   ////fake trig_out
   //reg [31:0] num;
   //reg trig_out_r;
   //always @ (posedge init_clk) num <= num + 1'b1;
   //
   //always @ (posedge init_clk) begin
   //		case(fmc_reg[3:0])
   //			4'h0: trig_out_r <=  num[26:4] == 23'b0; //1
   //			4'h1: trig_out_r <=  num[19:4] == 12'b0; //100
   //			4'h2: trig_out_r <=  num[16:4] == 12'b0;  //1K
   //			4'h3: trig_out_r <=  num[10:4] == 12'b0; //100K		
   //		endcase
   //end
   //
   //assign trig_out = trig_out_r;


   wire over_th;
   assign over_th = (adc_raw_data[15:0] < 16'h1900)|(adc_raw_data[31:16] < 16'h1900)|(adc_raw_data[47:32] < 16'h1900)|(adc_raw_data[63:48] < 16'h1900)	
		 |(adc_raw_data[79:64] < 16'h1900)|(adc_raw_data[95:80] < 16'h1900)|(adc_raw_data[111:96] < 16'h1900)|(adc_raw_data[127:112] < 16'h1900);

   assign trig_out = over_th;
endmodule
