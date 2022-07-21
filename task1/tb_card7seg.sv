`timescale  1ps/1ps
module tb_card7seg();
    logic[3:0] TB_SW;
    logic[6:0] TB_HEX0;

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

    /*
     * Active LOW
     *
     *    00000000
     *   5        1
     *   5        1
     *   5        1
     *    66666666         
     *   4        2
     *   4        2
     *   4        2
     *    33333333
     */


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

    card7seg DUT( TB_SW, TB_HEX0 );

    initial begin
        TB_SW = `NUM_ZERO;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_BLANK ) $display("Blank (0) OK");
            else $error("FAIL: Blank (0)");

        TB_SW = `NUM_14;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_BLANK ) $display("14 OK");
            else $error("FAIL: Blank (14)"); 

        TB_SW = `NUM_15;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_BLANK ) $display("15 OK"); 
            else $error("FAIL: Blank (15)");
        

        TB_SW = `NUM_ACE;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_ACE ) $display("A OK"); 
            else $error("FAIL: A");

        TB_SW = `NUM_2;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_2 ) $display("2 OK"); 
            else $error("FAIL: 2");

        TB_SW = `NUM_3;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_3 ) $display("3 OK"); 
            else $error("FAIL: 3");
        
        TB_SW = `NUM_4;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_4 ) $display("4 OK"); 
            else $error("FAIL: A");
        
        TB_SW = `NUM_5;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_5 ) $display("5 OK"); 
            else $error("FAIL: 5");
 
        TB_SW = `NUM_6;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_6 ) $display("6 OK"); 
            else $error("FAIL: 6");

        TB_SW = `NUM_7;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_7 ) $display("7 OK"); 
            else $error("FAIL: 7");

        TB_SW = `NUM_8;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_8 ) $display("8 OK"); 
            else $error("FAIL: 8");

        TB_SW = `NUM_9;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_9 ) $display("9 OK"); 
            else $error("FAIL: 9");

        TB_SW = `NUM_10;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_10 ) $display("10 OK"); 
            else $error("FAIL: 5");

        TB_SW = `NUM_JACK;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_JACK ) $display("J OK"); 
            else $error("FAIL: J");
        
        TB_SW = `NUM_QUEEN;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_QUEEN ) $display("Q OK"); 
            else $error("FAIL: Q");
        
        TB_SW = `NUM_KING;
        #10;
        assert (tb_card7seg.DUT.HEX0 == `HEX_KING ) $display("K OK"); 
            else $error("FAIL: K");
        
    end
	
   // $stop;
endmodule

