module card7seg(input [3:0] SW, output [6:0] HEX0);
		
   logic [6:0] HEX0_LOGIC;

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


   assign HEX0 = HEX0_LOGIC;
   
   always_comb  begin
      case(SW)
         `ZERO:  HEX0_LOGIC = `HEX_BLANK;
         `ACE:   HEX0_LOGIC = `HEX_ACE;
         `TWO:   HEX0_LOGIC = `HEX_2;
         `THREE: HEX0_LOGIC = `HEX_3;
         `FOUR:  HEX0_LOGIC = `HEX_4;
         `FIVE:  HEX0_LOGIC = `HEX_5;
         `SIX:   HEX0_LOGIC = `HEX_6;
         `SEVEN: HEX0_LOGIC = `HEX_7;
         `EIGHT: HEX0_LOGIC = `HEX_8;
         `NINE:  HEX0_LOGIC = `HEX_9;
         `TEN:   HEX0_LOGIC = `HEX_10;
         `JACK:  HEX0_LOGIC = `HEX_JACK;
         `QUEEN: HEX0_LOGIC = `HEX_QUEEN;
         `KING:  HEX0_LOGIC = `HEX_KING;
         `NA_14: HEX0_LOGIC = `HEX_BLANK;
         `NA_15: HEX0_LOGIC = `HEX_BLANK;
          
         default: HEX0_LOGIC = 7'b0000110; // displays E
       endcase
    end
endmodule

