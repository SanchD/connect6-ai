`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:00 08/21/2012 
// Design Name: 
// Module Name:    baudgen 
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
module baudgen
    (
        reset,
        enable,
    
        high_clk_in,
        baud_clk_out
    );
    
//---------------------------------------------------------------------------------------------------------------------
// parameter definitions
//---------------------------------------------------------------------------------------------------------------------
    parameter   HIGH_CLK = 50_000_000;
    parameter   BAUD_CLK = 115_200;
    
//---------------------------------------------------------------------------------------------------------------------
// localparams
//---------------------------------------------------------------------------------------------------------------------
    localparam  DIVISOR = (HIGH_CLK/(2*BAUD_CLK))-1;
    
//---------------------------------------------------------------------------------------------------------------------
// I/O Signal
//---------------------------------------------------------------------------------------------------------------------

    input       	reset;
    input       	enable;
	
    input       	high_clk_in;
    output reg  	baud_clk_out;
    
//---------------------------------------------------------------------------------------------------------------------
// Regs and wires
//---------------------------------------------------------------------------------------------------------------------
    reg [35:0] 		counter;

//---------------------------------------------------------------------------------------------------------------------
// Implementation
//---------------------------------------------------------------------------------------------------------------------

    always @(posedge high_clk_in or posedge reset) begin
        if(reset) begin
            counter <= 0;
            baud_clk_out <= 1;
        end
        else if(enable)begin
            if(counter == DIVISOR) begin
                counter <= 36'd0;
                baud_clk_out <= ~baud_clk_out;
            end
            else begin
                counter <= counter + 36'd1;
            end
        end
    end

endmodule
