module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
    
    logic [3:0] new_card;
    logic [3:0] p1_reg4;
    logic [3:0] p2_reg4;
    logic [3:0] p3_reg4;
    logic [3:0] d1_reg4;
    logic [3:0] d2_reg4;
    logic [3:0] d3_reg4;

    logic [6:0] HEX0_logic;
    logic [6:0] HEX1_logic;
    logic [6:0] HEX2_logic;
    logic [6:0] HEX3_logic;
    logic [6:0] HEX4_logic;
    logic [6:0] HEX5_logic;

    logic [3:0] pscore_out_logic;
    logic [3:0] dscore_out_logic; 

    assign pscore_out = pscore_out_logic;
    assign dscore_out = dscore_out_logic;
    assign pcard3_out = p3_reg4;

    assign HEX0 = HEX0_logic;
    assign HEX1 = HEX1_logic;
    assign HEX2 = HEX2_logic;
    assign HEX3 = HEX3_logic;
    assign HEX4 = HEX4_logic;
    assign HEX5 = HEX5_logic;
						
    dealcard dealer (.clock(fast_clock), .resetb(resetb), .new_card(new_card));

    reg4 player1_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_pcard1), .Q(p1_reg4));
    reg4 player2_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_pcard2), .Q(p2_reg4));
    reg4 player3_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_pcard3), .Q(p3_reg4));

    reg4 dealer1_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_dcard1), .Q(d1_reg4));
    reg4 dealer2_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_dcard2), .Q(d2_reg4));
    reg4 dealer3_reg4(.D(new_card), .clock(slow_clock), .resetb(resetb), .load(load_dcard3), .Q(d3_reg4));

    card7seg p1_7seg(.card(p1_reg4), .seg7(HEX0_logic));
    card7seg p2_7seg(.card(p2_reg4), .seg7(HEX1_logic));
    card7seg p3_7seg(.card(p3_reg4), .seg7(HEX2_logic));

    card7seg d1_7seg(.card(d1_reg4), .seg7(HEX3_logic));
    card7seg d2_7seg(.card(d2_reg4), .seg7(HEX4_logic));
    card7seg d3_7seg(.card(d3_reg4), .seg7(HEX5_logic));

    scorehand player_score(.card1(p1_reg4), .card2(p2_reg4), .card3(p3_reg4), .total(pscore_out_logic));
    scorehand dealer_score(.card1(d1_reg4), .card2(d2_reg4), .card3(d3_reg4), .total(dscore_out_logic));


endmodule

/* Modified from: 
 * https://www.xilinx.com/support/documentation/university/ISE-Teaching/HDL-Design/14x/Nexys3/Verilog/docs-pdf/lab6.pdf
 */
module reg4 (input [3:0] D, input clock, input resetb, input load, output logic [3:0] Q);
    
    always_ff @(posedge clock) begin
        if (!resetb)
            begin
                Q <= 4'b0;
            end 
            
        else if (load)
            begin
                Q <= D;
            end
    end      
endmodule 

