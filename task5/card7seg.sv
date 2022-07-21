module card7seg(input [3:0] card, output[6:0] seg7);

   reg [6:0] seg7_reg;

   // Card value assignments
   `define NUM_ZERO    4'b0000
   `define NUM_ACE     4'b0001
   `define NUM_2       4'b0010
   `define NUM_3       4'b0011
   `define NUM_4       4'b0100
   `define NUM_5       4'b0101
   `define NUM_6       4'b0110
   `define NUM_7       4'b0111
   `define NUM_8       4'b1000
   `define NUM_9       4'b1001
   `define NUM_10      4'b1010
   `define NUM_JACK    4'b1011
   `define NUM_QUEEN   4'b1100
   `define NUM_KING    4'b1101
   `define NUM_14      4'b1110
   `define NUM_15      4'b1111

   // HEX display output assignments
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

	assign seg7 = seg7_reg; 
	
   /* Main always block (combinational logic); 
      Displays the number input on the carditches on the
      HEX display.
   */
   always @ ( card ) begin
   
      /* Case statement assigs every possible 
         card input to its corresponding seg7 value
         that will display the card value on the
         display
      */
      case ( card )
         `NUM_ZERO: seg7_reg = `HEX_BLANK;

         `NUM_14  : seg7_reg = `HEX_BLANK;

         `NUM_15  : seg7_reg = `HEX_BLANK;

         `NUM_ACE : seg7_reg = `HEX_ACE;

         `NUM_2   : seg7_reg = `HEX_2;

         `NUM_3   : seg7_reg = `HEX_3;

         `NUM_4   : seg7_reg = `HEX_4;

         `NUM_5   : seg7_reg = `HEX_5;

         `NUM_6   : seg7_reg = `HEX_6;

         `NUM_7   : seg7_reg = `HEX_7;

         `NUM_8   : seg7_reg = `HEX_8;

         `NUM_9   : seg7_reg = `HEX_9;

         `NUM_10  : seg7_reg = `HEX_10;

         `NUM_JACK   : seg7_reg = `HEX_JACK;

         `NUM_QUEEN  : seg7_reg = `HEX_QUEEN;

         `NUM_KING   : seg7_reg = `HEX_KING;

      endcase
   end

endmodule