module tb_card7seg();
    reg err;
    reg [3:0] TB_SW;
    wire [6:0] TB_HEX0;

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


    card7seg dut( TB_SW, TB_HEX0 );

    /* Automated testbench checker 
       modified from Zhi Chuen Tan's 
       CPEN 211 Lab 4 submission
       for the 2018W1 term.
    */
    task tb_checker;
        input [6:0] expected_hex0;
        begin
            if( tb_card7seg.dut.HEX0 !== expected_hex0 ) begin
                $display( "ERROR: Output should be %b,  not %b",
                expected_hex0, tb_card7seg.dut.HEX0 );
            
                err = 1'b1;
            end
        end
    endtask

    // Testbench tests each number from 0-15
    initial begin
        // Initialized err
        err = 1'b0;

        $display( "Checking blank (0)" );
        TB_SW = `NUM_ZERO;
        #10;
        tb_checker( `HEX_BLANK );

        $display( "Checking blank (14)" );
        TB_SW = `NUM_14;
        #10;
        tb_checker( `HEX_BLANK );

        $display( "Checking blank (15)" );
        TB_SW = `NUM_15;
        #10;
        tb_checker( `HEX_BLANK );

        $display( "Checking ace " );
        TB_SW = `NUM_ACE;
        #10;
        tb_checker( `HEX_ACE );

        $display( "Checking 2" );
        TB_SW = `NUM_2;
        #10;
        tb_checker( `HEX_2 );

        $display( "Checking 3" );
        TB_SW = `NUM_3;
        #10;
        tb_checker( `HEX_3 );

        $display( "Checking 4" );
        TB_SW = `NUM_4;
        #10;
        tb_checker( `HEX_4 );

        $display( "Checking 5" );
        TB_SW = `NUM_5;
        #10;
        tb_checker( `HEX_5 );

        $display( "Checking 6" );
        TB_SW = `NUM_6;
        #10;
        tb_checker( `HEX_6 );

        $display( "Checking 7" );
        TB_SW = `NUM_7;
        #10;
        tb_checker( `HEX_7 );

        $display( "Checking 8" );
        TB_SW = `NUM_8;
        #10;
        tb_checker( `HEX_8 );

        $display( "Checking 9" );
        TB_SW = `NUM_9;
        #10;
        tb_checker( `HEX_9 );

        $display( "Checking 10" );
        TB_SW = `NUM_10;
        #10;
        tb_checker( `HEX_10 );

        $display( "Checking Jack" );
        TB_SW = `NUM_JACK;
        #10;
        tb_checker( `HEX_JACK );

        $display( "Checking Queen" );
        TB_SW = `NUM_QUEEN;
        #10;
        tb_checker( `HEX_QUEEN );

        $display( "Checking King" );
        TB_SW = `NUM_KING;
        #10;
        tb_checker( `HEX_KING );


        // Checks if there are any errors
        if ( ~err )
            $display( "All tests passed!" );

        else
            $display( "Errors detected!" );


    end						
endmodule

