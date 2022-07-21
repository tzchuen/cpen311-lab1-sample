module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output player_win_light, output dealer_win_light);

    // FSM style taken heavily from Slide Set 5 of Tor Aamodt's CPEN 211 (2018W) course.
    `define STATEWIDTH 14

    // State definitions (binary assignment)
    `define RESET           4'b0000
    `define DEAL_PLAYER_1   4'b0001
    `define DEAL_DEALER_1   4'b0010
    `define DEAL_PLAYER_2   4'b0011
    `define DEAL_DEALER_2   4'b0100
    `define DEAL_PLAYER_3   4'b0101

    `define SKIP_PLAYER_3   4'b0110
    `define DEAL_DEALER_3   4'b0111
    `define SKIP_DEALER_3   4'b1000
    `define PLAYER_WIN      4'b1001
    `define DEALER_WIN      4'b1010
    `define TIE             4'b1011

    `define EVAL_PCARD3     4'b1100
    `define EVAL_DCARD3     4'b1101

    wire [3:0] present_state, next_state_reset, next_state_win;
    reg [3:0] next_state, next_state_dp3, next_state_dd3;

    reg load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg;
    reg dealer_win_light_reg, player_win_light_reg;
    
    // Module instantiations
    vDFF #(`STATEWIDTH) STATE(slow_clock, next_state_reset, present_state);
    pcard3_deal DEAL_P3(dscore, pscore, next_state_dp3);
    dcard3_deal DEAL_D3(dscore, pscore, pcard3, next_state_dd3);
    check_win   WINNER (dscore,pscore,next_state_win);

    // reset logic
    assign next_state_reset = resetb ? next_state : `RESET;

    assign load_pcard1 = load_pcard1_reg;
    assign load_pcard2 = load_pcard2_reg;
    assign load_pcard3 = load_pcard3_reg;
    assign load_dcard1 = load_dcard1_reg;
    assign load_dcard2 = load_dcard2_reg;
    assign load_dcard3 = load_dcard3_reg;
    assign player_win_light = player_win_light_reg;
    assign dealer_win_light = dealer_win_light_reg;


    // next state and output logic
    always @(*) begin
        case (present_state)
            `RESET          :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `DEAL_PLAYER_1, 8'b0 };
            
            /*******************************************************************/
            
            `DEAL_PLAYER_1  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `DEAL_DEALER_1, 1'b1, 7'b0 };

            `DEAL_DEALER_1  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `DEAL_PLAYER_2, 1'b0, 1'b1, 6'b0 };
            
            /*******************************************************************/

            `DEAL_PLAYER_2  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `DEAL_DEALER_2, 2'b0, 1'b1, 5'b0 };
            
            `DEAL_DEALER_2  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `EVAL_PCARD3, 3'b0, 1'b1, 4'b0 };
            
            /*******************************************************************/

            `EVAL_PCARD3    :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { next_state_dp3, 8'b0 };
            
            `DEAL_PLAYER_3  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `EVAL_DCARD3, 4'b0, 1'b1, 3'b0 };
            
            `SKIP_PLAYER_3  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `EVAL_DCARD3, 8'b0 };

            /*******************************************************************/      
            
            `EVAL_DCARD3    :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { next_state_dd3, 8'b0 };
            
            `DEAL_DEALER_3  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { next_state_win, 5'b0, 1'b1, 2'b0 };
            
            `SKIP_DEALER_3  :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { next_state_win, 8'b0 };
            
            /*******************************************************************/
            
            `PLAYER_WIN     :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `RESET, 6'b0, 1'b1, 1'b0 };
            
            `DEALER_WIN     :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `RESET, 7'b0, 1'b1 };
            
            `TIE            :  {next_state, load_pcard1_reg, load_dcard1_reg, 
                                load_pcard2_reg, load_dcard2_reg,
                                load_pcard3_reg, load_dcard3_reg,
                                player_win_light_reg, dealer_win_light_reg}

                                = { `RESET, 6'b0, 2'b11 };
            
            /*******************************************************************/
        endcase
    end
endmodule

// Flip-flop module definition, taken from Tor Aamodt's Slide Set 5 (2018W) for CPEN 211
module vDFF(clk, in, out);
    parameter n=1;  // width
    input clk;
    input reg [n-1:0] in;
    output reg [n-1:0] out;
    //reg [n-1:0] out;

    always @(posedge clk) begin
        out = in;
    end

endmodule


// This module determines if the player is eligible to be dealt a 3rd card
module pcard3_deal (input reg [3:0] dscore, input reg [3:0] pscore, output reg [3:0] next_state);
    // State definitions (binary assignment)
    `define RESET           4'b0000
    `define DEAL_PLAYER_1   4'b0001
    `define DEAL_DEALER_1   4'b0010
    `define DEAL_PLAYER_2   4'b0011
    `define DEAL_DEALER_2   4'b0100
    `define DEAL_PLAYER_3   4'b0101
    `define SKIP_PLAYER_3   4'b0110
    `define DEAL_DEALER_3   4'b0111
    `define SKIP_DEALER_3   4'b1000
    `define PLAYER_WIN      4'b1001
    `define DEALER_WIN      4'b1010
    `define TIE             4'b1011

    always_comb  begin
       // Checks for "naturals"
        if (dscore===4'd8 || dscore===4'd9 || pscore===4'd8 || pscore===4'd9) begin
            if (dscore > pscore)
                next_state = `DEALER_WIN;
            
            else if (pscore > dscore)
                next_state = `PLAYER_WIN;
            
            else
                next_state = `TIE;

        end

        else if (pscore >=4'd0 && pscore <=4'd5)
            next_state = `DEAL_PLAYER_3;
        
        else if (pscore === 4'd6 || pscore === 4'd7 )
            next_state = `SKIP_PLAYER_3;
        
    end

endmodule



// This module determines if the dealer is eligible to be dealt a 3rd card
module dcard3_deal (input reg [3:0] dscore, input reg [3:0] pscore, input reg [3:0] pcard3, output reg [3:0] next_state);
    // State definitions (binary assignment)
    `define RESET           4'b0000
    `define DEAL_PLAYER_1   4'b0001
    `define DEAL_DEALER_1   4'b0010
    `define DEAL_PLAYER_2   4'b0011
    `define DEAL_DEALER_2   4'b0100
    `define DEAL_PLAYER_3   4'b0101
    `define SKIP_PLAYER_3   4'b0110
    `define DEAL_DEALER_3   4'b0111
    `define SKIP_DEALER_3   4'b1000
    `define PLAYER_WIN      4'b1001
    `define DEALER_WIN      4'b1010
    `define TIE             4'b1011

    always_comb  begin
        if (pscore>=0 && pscore<=5) begin
            if (dscore===4'd6) begin
                if (pcard3===4'd6 || pcard3===4'd7)
                    next_state = `DEAL_DEALER_3;
            
                else
                    next_state = `SKIP_DEALER_3;
            end
        
            else if (dscore===4'd5) begin
                    if (pcard3>=4'd5 && pcard3<=4'd7)
                        next_state = `DEAL_DEALER_3;
                
                    else
                        next_state = `SKIP_DEALER_3;  
            end

            else if (dscore===4'd4) begin
                    if (pcard3>=4'd2 && pcard3<=4'd7)
                        next_state = `DEAL_DEALER_3;
                
                    else
                        next_state = `SKIP_DEALER_3;
            end

            else if (dscore===4'd3) begin
                    if (pcard3!==4'd8)
                        next_state = `DEAL_DEALER_3;
                
                    else
                        next_state = `SKIP_DEALER_3;
            end

            else 
                next_state = `DEAL_DEALER_3;
        end

        
    

        else begin
            if (dscore>=0 && dscore<=5)
                next_state = `DEAL_DEALER_3;
            else 
                next_state = `SKIP_DEALER_3;
        end
    end

endmodule

module check_win (input reg [3:0] dscore, input reg [3:0] pscore, output reg [3:0] next_state);
    
    // State definitions (binary assignment)
    `define RESET           4'b0000
    `define DEAL_PLAYER_1   4'b0001
    `define DEAL_DEALER_1   4'b0010
    `define DEAL_PLAYER_2   4'b0011
    `define DEAL_DEALER_2   4'b0100
    `define DEAL_PLAYER_3   4'b0101
    `define SKIP_PLAYER_3   4'b0110
    `define DEAL_DEALER_3   4'b0111
    `define SKIP_DEALER_3   4'b1000
    `define PLAYER_WIN      4'b1001
    `define DEALER_WIN      4'b1010
    `define TIE             4'b1011

    always_comb begin
        if (dscore>pscore)
            next_state = `DEALER_WIN;
        
        else if (pscore>dscore)
            next_state = `PLAYER_WIN;
        
        else if (pscore === dscore)
            next_state = `TIE;
    end
endmodule

