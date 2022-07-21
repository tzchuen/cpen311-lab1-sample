module card7seg(input [3:0] card, output[6:0] seg7);

   logic [6:0] seg7_logic;

   `define ZERO   4'b0000
   `define ACE    4'b0001
   `define TWO    4'b0010
   `define THREE  4'b0011
   `define FOUR   4'b0100
   `define FIVE   4'b0101
   `define SIX    4'b0110
   `define SEVEN  4'b0111
   `define EIGHT  4'b1000
   `define NINE   4'b1001
   `define TEN    4'b1010
   `define JACK   4'b1011
   `define QUEEN  4'b1100
   `define KING   4'b1101
   `define NA_14  4'b1110
   `define NA_15  4'b1111


   // HEX display output assignments
                          // 6543210
   `define HEX_BLANK     7'b1111111
   `define HEX_ACE       7'b0001000
   `define HEX_2         7'b0100100
   `define HEX_3         7'b0110000
   `define HEX_4         7'b0011001
   `define HEX_5         7'b0010010
   `define HEX_6         7'b0000010
   `define HEX_7         7'b1111000
   `define HEX_8         7'b0000000
   `define HEX_9         7'b0010000
   `define HEX_10        7'b1000000
   `define HEX_JACK      7'b1100001
   `define HEX_QUEEN     7'b0011000
   `define HEX_KING      7'b0001001


   assign seg7 = seg7_logic;
   
   always_comb  begin
      case(card)
         `ZERO:  seg7_logic = `HEX_BLANK;
         `ACE:   seg7_logic = `HEX_ACE;
         `TWO:   seg7_logic = `HEX_2;
         `THREE: seg7_logic = `HEX_3;
         `FOUR:  seg7_logic = `HEX_4;
         `FIVE:  seg7_logic = `HEX_5;
         `SIX:   seg7_logic = `HEX_6;
         `SEVEN: seg7_logic = `HEX_7;
         `EIGHT: seg7_logic = `HEX_8;
         `NINE:  seg7_logic = `HEX_9;
         `TEN:   seg7_logic = `HEX_10;
         `JACK:  seg7_logic = `HEX_JACK;
         `QUEEN: seg7_logic = `HEX_QUEEN;
         `KING:  seg7_logic = `HEX_KING;
         `NA_14: seg7_logic = `HEX_BLANK;
         `NA_15: seg7_logic = `HEX_BLANK;
          
         default: seg7_logic = 7'b0000110; // displays E
       endcase
    end

endmodule

