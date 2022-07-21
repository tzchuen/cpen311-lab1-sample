module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output player_win_light, output dealer_win_light);

    parameter INIT      = 4'b0000;
    parameter PLAY_1    = 4'b0001;
    parameter DEAL_1    = 4'b0010;
    parameter PLAY_2    = 4'b0011;
    parameter DEAL_2    = 4'b0100;
    parameter PLAY_3    = 4'b0101;
    parameter DEAL_3    = 4'b0110;
    parameter P_WIN     = 4'b0111;
    parameter D_WIN     = 4'b1000;
    parameter TIE       = 4'b1001;
    parameter ERROR     = 4'bxxxx;  // for debugging, should never end up here

    logic [3:0] state;
    logic [3:0] next;

    logic load_pcard1_logic, load_pcard2_logic, load_pcard3_logic;
    logic load_dcard1_logic, load_dcard2_logic, load_dcard3_logic;
    logic dealer_win_light_logic, player_win_light_logic;

    assign load_pcard1 = load_pcard1_logic;
    assign load_pcard2 = load_pcard2_logic;
    assign load_pcard3 = load_pcard3_logic;

    assign load_dcard1 = load_dcard1_logic;
    assign load_dcard2 = load_dcard2_logic;
    assign load_dcard3 = load_dcard3_logic;

    assign player_win_light = player_win_light_logic;
    assign dealer_win_light = dealer_win_light_logic;

    /* Modified from http://www.sunburst-design.com/papers/CummingsSNUG2003SJ_SystemVerilogFSM.pdf
     */
     
    // always block that deals with reset and transitioning to next state
    always_ff @(posedge slow_clock) begin
        if (!resetb)
            state <= INIT;

        else
            state <= next;
    end

    // always block that deals with determining the appropriate next state
    always_comb begin

        next = 4'bx;    // reset for debugging
        case (state)
            INIT    : next = PLAY_1;
            PLAY_1  : next = DEAL_1;
            DEAL_1  : next = PLAY_2;
            PLAY_2  : next = DEAL_2;

            DEAL_2  : begin
                        if (pscore === 4'b1000 || pscore === 4'b1001 || dscore === 4'b1000 || dscore === 4'b1001) begin
                            if (pscore > dscore)
                                next = P_WIN;
                            
                            else if (dscore > pscore)
                                next = D_WIN;
                            
                            else if (dscore === pscore)
                                next = TIE;
                            
                            else
                                next = ERROR;
                        end

                        else if (pscore === 4'b0000 || pscore === 4'b0001 || pscore === 4'b0010 || pscore === 4'b0011 || pscore === 4'b0100 || pscore === 4'b0101)
                            next = PLAY_3;
                        
                        else if (pscore === 4'b0110 || pscore === 4'b0111) begin
                            if (dscore === 4'b0000 || dscore === 4'b0001 || dscore === 4'b0010 || dscore === 4'b0011 || dscore === 4'b0100 || dscore === 4'b0101)
                                next = DEAL_3;
                            
                            else if (dscore === 4'b0110 || dscore === 4'b0111) begin
                                if (pscore > dscore)
                                    next = P_WIN;
                                
                                else if (dscore > pscore)
                                    next = D_WIN;
                                
                                else if (dscore === pscore)
                                    next = TIE;
                                
                                else
                                    next = ERROR;
                            end
                        end
            
                    
                    end

            PLAY_3  : begin
                        if (dscore === 4'b0111) begin       // dscore = 7
                            if (pscore > dscore)
                                    next = P_WIN;
                                
                                else if (dscore > pscore)
                                    next = D_WIN;
                                
                                else if (dscore === pscore)
                                    next = TIE;
                                
                                else
                                    next = ERROR;
                        end

                        else if (   (dscore === 4'b0110) && ( (pcard3 === 4'b0110) || (pcard3 === 4'b0111) )    )   // dscore = 6
                            next = DEAL_3;
                        
                        else if (   (dscore === 4'b0101) && ( (pcard3 === 4'b0100) || (pcard3 === 4'b0101) || (pcard3 === 4'b0110) || (pcard3 === 4'b0111) )    )   // dscore = 5
                            next = DEAL_3;
                        
                        else if (   (dscore === 4'b0100) && ( (pcard3 === 4'b0010) || (pcard3 === 4'b0011) || (pcard3 === 4'b0100)  || (pcard3 === 4'b0101) || (pcard3 === 4'b0110) || (pcard3 === 4'b0111) )    )   // dscore = 4
                            next = DEAL_3;
                        
                        else if (   (dscore === 4'b0101) && (pcard3 != 4'b1000)    )   // dscore = 3
                            next = DEAL_3;
                        
                        else if ( dscore === 4'b0000 || dscore === 4'b0001 || dscore === 4'b0010 )
                            next = DEAL_3;
                        
                        else begin
                            if (pscore > dscore)
                                    next = P_WIN;
                                
                                else if (dscore > pscore)
                                    next = D_WIN;
                                
                                else if (dscore === pscore)
                                    next = TIE;
                                
                                else
                                    next = ERROR;
                        end
                    end
            
            DEAL_3  : begin
                        if (pscore > dscore)
                                    next = P_WIN;
                                
                        else if (dscore > pscore)
                            next = D_WIN;
                                
                        else if (dscore === pscore)
                            next = TIE;
                                
                        else
                            next = ERROR;
                    end
            
            P_WIN   : next = P_WIN;
            D_WIN   : next = D_WIN;
            TIE     : next = TIE;

            default : next = ERROR;
        endcase
    end

    // always block that deals with outputs
    always_ff @(posedge slow_clock) begin
        if (!resetb) begin
            load_pcard1_logic = 1'b0;
            load_pcard2_logic = 1'b0;
            load_pcard3_logic = 1'b0;

            load_dcard1_logic = 1'b0;
            load_dcard2_logic = 1'b0;
            load_dcard3_logic = 1'b0;

            player_win_light_logic = 1'b0;
            dealer_win_light_logic = 1'b0;
        end

        else begin
            load_pcard1_logic = 1'b0;
            load_pcard2_logic = 1'b0;
            load_pcard3_logic = 1'b0;

            load_dcard1_logic = 1'b0;
            load_dcard2_logic = 1'b0;
            load_dcard3_logic = 1'b0;

            player_win_light_logic = 1'b0;
            dealer_win_light_logic = 1'b0;

            case (next)
                INIT    : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                PLAY_1  : begin
                            load_pcard1_logic = 1'b1;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                DEAL_1  : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b1;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                PLAY_2  : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b1;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                DEAL_2  : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b1;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                PLAY_3  : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b1;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                DEAL_3  : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b1;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b0;
                        end
                
                P_WIN   : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b1;
                            dealer_win_light_logic = 1'b0;
                        end
                
                D_WIN   : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b0;
                            dealer_win_light_logic = 1'b1;
                        end
                
                TIE     : begin
                            load_pcard1_logic = 1'b0;
                            load_pcard2_logic = 1'b0;
                            load_pcard3_logic = 1'b0;

                            load_dcard1_logic = 1'b0;
                            load_dcard2_logic = 1'b0;
                            load_dcard3_logic = 1'b0;

                            player_win_light_logic = 1'b1;
                            dealer_win_light_logic = 1'b1;
                        end
                    
                ERROR   : begin
                            load_pcard1_logic = 1'bx;
                            load_pcard2_logic = 1'bx;
                            load_pcard3_logic = 1'bx;

                            load_dcard1_logic = 1'bx;
                            load_dcard2_logic = 1'bx;
                            load_dcard3_logic = 1'bx;

                            player_win_light_logic = 1'bx;
                            dealer_win_light_logic = 1'bx;
                        end
                
                default: begin
                        load_pcard1_logic = 1'b0;
                        load_pcard2_logic = 1'b0;
                        load_pcard3_logic = 1'b0;

                        load_dcard1_logic = 1'b0;
                        load_dcard2_logic = 1'b0;
                        load_dcard3_logic = 1'b0;

                        player_win_light_logic = 1'b0;
                        dealer_win_light_logic = 1'b0;       
                end
            endcase
            
        end
    end

endmodule

