`timescale 1ns / 1ps


module blinker_top(
    input logic clk,
    input logic reset_n,
    input [15:0] target0, target1, target2, target3,
    output logic [3:0] led_out
    );
    
    
    
    logic ms_tick;
    counter my_counter(
    .clk(clk),
    .rst(reset_n),
    .ms_tick(ms_tick)
    );
    
        
    blinker blinker0 (
    .clk(clk),
    .rst(reset_n),
    .ms_tick(ms_tick),
    .target(target0),
    .led(led_out[3])
    );
    
    blinker blinker1 (
    .clk(clk),
    .rst(reset_n),
    .ms_tick(ms_tick),
    .target(target1),
    .led(led_out[2])
    );
    
    blinker blinker2 (
    .clk(clk),
    .rst(reset_n),
    .ms_tick(ms_tick),
    .target(target2),
    .led(led_out[1])
    );
    
    blinker blinker3 (
    .clk(clk),
    .rst(reset_n),
    .ms_tick(ms_tick),
    .target(target3),
    .led(led_out[0])
    );
endmodule
