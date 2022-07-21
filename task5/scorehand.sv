module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output [3:0] total);

    // Card values
    `define CARD_ACE     4'b0001
    `define CARD_2       4'b0010
    `define CARD_3       4'b0011
    `define CARD_4       4'b0100
    `define CARD_5       4'b0101
    `define CARD_6       4'b0110
    `define CARD_7       4'b0111
    `define CARD_8       4'b1000
    `define CARD_9       4'b1001
    `define CARD_10      4'b1010
    `define CARD_JACK    4'b1011
    `define CARD_QUEEN   4'b1100
    `define CARD_KING    4'b1101

    reg [3:0] score1, score2, score3;
    reg [3:0] total_reg;


    always @(*) begin
        
        case ( card1 ) //begin
            `CARD_10    : score1 = 4'd0;
            `CARD_JACK  : score1 = 4'd0;
            `CARD_QUEEN : score1 = 4'd0;
            `CARD_KING  : score1 = 4'd0;

            default: score1 = card1;
        endcase

        case ( card2 ) //begin
            `CARD_10    : score2 = 4'd0;
            `CARD_JACK  : score2 = 4'd0;
            `CARD_QUEEN : score2 = 4'd0;
            `CARD_KING  : score2 = 4'd0;

            default: score2 = card2;
        endcase

        case ( card3 ) //begin
            `CARD_10    : score3 = 4'd0;
            `CARD_JACK  : score3 = 4'd0;
            `CARD_QUEEN : score3 = 4'd0;
            `CARD_KING  : score3 = 4'd0;

            default: score3 = card3;
        endcase

        total_reg = ( score1 + score2 + score3 ) % 10;
    end
    
    assign total = total_reg;

endmodule

