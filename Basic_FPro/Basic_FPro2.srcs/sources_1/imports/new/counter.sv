`timescale 1ns / 1ps


module counter(
    input logic clk,
    input logic rst,
    output logic ms_tick
    ); 
    
    logic [20:0] count, ncount;
    logic [20:0] target = 20'b00011000011010011111;
    
    
    always_ff @(posedge clk, posedge rst)
        if(rst)
            count <= 0;
        else
            count <= ncount;
     
     
          
     always_comb
        if (count == target)
             begin
                ms_tick = 1;
                ncount = 0;
            end
        else
            begin
                ms_tick = 0;
                ncount = count + 1;
            end
          
endmodule