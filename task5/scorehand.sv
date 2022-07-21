module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output [3:0] total);

    // Card values
    `define CARD_A      4'b0001
    `define CARD_2      4'b0010
    `define CARD_3      4'b0011
    `define CARD_4      4'b0100
    `define CARD_5      4'b0101
    `define CARD_6      4'b0110
    `define CARD_7      4'b0111
    `define CARD_8      4'b1000
    `define CARD_9      4'b1001
    `define CARD_10     4'b1010
    `define CARD_J      4'b1011
    `define CARD_Q      4'b1100
    `define CARD_K      4'b1101

    logic [3:0] score1;
    logic [3:0] score2;
    logic [3:0] score3;

    logic [3:0] total_logic;

    always_comb begin
        case( card1 )
            `CARD_10:   score1 = 4'b0;
            `CARD_J:    score1 = 4'b0;
            `CARD_Q:    score1 = 4'b0;
            `CARD_K:    score1 = 4'b0;
            
            default: score1 = card1;
        endcase

        case( card2 )
            `CARD_10:   score2 = 4'b0;
            `CARD_J:    score2 = 4'b0;
            `CARD_Q:    score2 = 4'b0;
            `CARD_K:    score2 = 4'b0;
        
            default:    score2 = card2;
        endcase

        case( card3 )
            `CARD_10:   score3 = 4'b0;
            `CARD_J:    score3 = 4'b0;
            `CARD_Q:    score3 = 4'b0;
            `CARD_K:    score3 = 4'b0;
        
            default:    score3 = card3;
        endcase

        total_logic = (score1 + score2 + score3) % 10;
    end

    assign total = total_logic;
    
endmodule

