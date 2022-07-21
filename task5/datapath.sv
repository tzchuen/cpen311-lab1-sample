module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
						
/* The code describing your datapath will go here.  Your datapath 
   will hierarchically instantiate six card7seg blocks, two scorehand
   blocks, and a dealcard block.  The registers may either be instatiated
   or included as sequential always blocks directly in this file.
*/
    // HEX display output assignments
   `define HEX_BLANK     7'b1111111
   
    // Internal signal declarations
    wire [3:0] new_card, pcard1, pcard2, dcard1, dcard2, dcard3, total;
    reg [3:0] pcard3_out_reg, pscore_out_reg, dscore_out_reg;
    reg [6:0] HEX5_reg, HEX4_reg, HEX3_reg, HEX2_reg, HEX1_reg, HEX0_reg;

    // Module instantiations
    register #(4) PCard1(new_card, load_pcard1, slow_clock, resetb, pcard1);
    register #(4) PCard2(new_card, load_pcard2, slow_clock, resetb, pcard2);
    register #(4) PCard3(new_card, load_pcard3, slow_clock, resetb, pcard3_out);

    register #(4) DCard1(new_card, load_dcard1, slow_clock, resetb, dcard1);
    register #(4) DCard2(new_card, load_dcard2, slow_clock, resetb, dcard2);
    register #(4) DCard3(new_card, load_dcard3, slow_clock, resetb, dcard3);

    card7seg  SEG_P1(pcard1, HEX0);
    card7seg  SEG_P2(pcard2, HEX1);
    card7seg  SEG_P3(pcard3_out, HEX2);

    card7seg  SEG_D1(dcard1, HEX3);
    card7seg  SEG_D2(dcard2, HEX4);
    card7seg  SEG_D3(dcard3, HEX5);

    scorehand player(pcard1, pcard2, pcard3_out, pscore_out);
    scorehand dealer(dcard1, dcard2, dcard3, dscore_out);

    dealcard  cards (fast_clock,resetb,new_card);

    /* statemachine FSM(.slow_clock(slow_clock), .resetb(resetb), .dscore(dscore_out), .pscore(pscore_out),
                     .pcard3(pcard3_out), .load_pcard1(load_pcard1), .load_pcard2(load_pcard2), .load_pcard3(load_pcard3),
                     .load_dcard1(load_dcard1), .load_dcard2(load_dcard2), .load_dcard3(load_dcard3));
    */

    // Reset logic
    always_ff @(posedge fast_clock or negedge resetb) begin
        if (resetb === 1'b0) begin
            pcard3_out_reg <= 4'b0;
            pscore_out_reg <= 4'b0;
            dscore_out_reg <= 4'b0;
            HEX5_reg       <= `HEX_BLANK;
            HEX4_reg       <= `HEX_BLANK;
            HEX3_reg       <= `HEX_BLANK;
            HEX2_reg       <= `HEX_BLANK;
            HEX1_reg       <= `HEX_BLANK;
            HEX0_reg       <= `HEX_BLANK;
        end
    end

    assign pcard3_out = pcard3_out_reg;
    assign pscore_out = pscore_out_reg; 
    assign dscore_out = dscore_out_reg;
    assign HEX5 = HEX5_reg; 
    assign HEX4 = HEX4_reg; 
    assign HEX3 = HEX3_reg; 
    assign HEX2 = HEX2_reg; 
    assign HEX1 = HEX1_reg; 
    assign HEX0 = HEX0_reg;

endmodule

// Module definition of an n-bit D Flip Flop
// Taken from Slide Set 5 of Tor Aamodt's CPEN 211 (2018W)
/*
module vDFF(clk, in, out);
	parameter n = 1;
	input clk;
	input [n-1:0] in;
	output [n-1:0] out;
	reg [n-1:0] out;

	always @(posedge clk)
		out = in;
endmodule
*/


module register(in, load, clk, resetb, out); //single register
	parameter k =1;
	input clk, load;
	input [k-1:0] in;
    input resetb;
	output [k-1:0] out;
	wire [k-1:0] out;

	wire [k-1:0]  next_state;  

	assign next_state = resetb ? (load ? in : out) : 5'b0 ;  //if load is 1, write to next_state, if load 0 remain in present state

	vDFF #(k) STATE(clk, next_state, out); //sequential logic block, changes state on positive edge of clk
endmodule

