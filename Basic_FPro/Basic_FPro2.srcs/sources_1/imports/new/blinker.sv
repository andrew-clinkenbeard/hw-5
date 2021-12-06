`timescale 1ns / 1ps


module blinker (
    input logic clk,
    input logic rst,
    input logic ms_tick,
    input logic [15:0] target,
    output logic led
);   
     
    logic [15:0] count = 0;
    logic nled;
    always_ff @(posedge clk, posedge rst)
        if (rst)
            led <= 0;
        else
            led <= nled;
            
    always @(posedge ms_tick) begin
        count = count + 1;
        
        if (count > target)
            count = 0;
        else if (count < target[15:1])
            nled = 0;
        else if (count >= target[15:1])
            nled = 1;        
        end


endmodule 