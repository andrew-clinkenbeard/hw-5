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
   .reset_n(reset),
   .target0(wait0), 
   .target1(wait1), 
   .target2(wait2), 
   .target3(wait3),
   .led_out(dout)
   );

   // declaration
   logic [31:0] buf_reg0, buf_reg1, buf_reg2, buf_reg3;
   logic [31:0] wait0, wait1, wait2, wait3;
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
         if (wr_en && addr == 0)
            buf_reg0 <= wr_data[31:0];
         else if (wr_en && addr == 1)
            buf_reg1  <= wr_data[31:0];
         else if (wr_en && addr == 2)
            buf_reg2  <= wr_data[31:0];
         else if (wr_en && addr == 3)
            buf_reg3  <= wr_data[31:0];  
      end
   
   
 
   // decoding logic 
   assign wr_en = cs && write;
   // slot read interface
   assign rd_data =  0;
   // external output  
   assign wait0 = buf_reg0;
   assign wait1 = buf_reg1;
   assign wait2 = buf_reg2;
   assign wait3 = buf_reg3;
endmodule
