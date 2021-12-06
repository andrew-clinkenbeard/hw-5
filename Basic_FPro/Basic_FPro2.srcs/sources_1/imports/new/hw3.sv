`timescale 1ns / 1ps


module hw3(
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [3:0] dout
   );
   
   blinker_top my_blinker(
   .clk(clk),
   .reset_n(!reset),
   .target0(wait0), 
   .target1(wait1), 
   .target2(wait2), 
   .target3(wait3),
   .led_out(dout)
   );

   // declaration
   logic [15:0] buf_reg0, buf_reg1, buf_reg2, buf_reg3;
   logic [15:0] wait0, wait1, wait2, wait3;
   logic wr_en;

   // body
   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)begin
         buf_reg0 <= 0;
         buf_reg1 <= 0;
         buf_reg2 <= 0;
         buf_reg3 <= 0;
         end
      else begin
         if (wr_en && addr == 4'b0000)
            buf_reg0 <= wr_data[15:0];
         else if (wr_en && addr == 4'b0001)
            buf_reg1  <= wr_data[15:0];
         else if (wr_en && addr == 4'b0010)
            buf_reg2  <= wr_data[15:0];
         else if (wr_en && addr == 4'b0011)
            buf_reg3  <= wr_data[15:0];  
      end
   
   
 
   // decoding logic 
   assign wr_en = cs && write;
   // slot read interface
   assign rd_data =  0;
   // external output  
   assign buf_reg0 = wait0;
   assign buf_reg1 = wait1;
   assign buf_reg2 = wait2;
   assign buf_reg3 = wait3;
endmodule
