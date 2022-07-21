module tb_scorehand();
    reg err_score, err_total;
    reg [3:0] card1_tb, card2_tb, card3_tb;
    reg [3:0] total_tb;

    // Card values
    `define CARD_BLANK   4'b0000
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

    
    // Scores for each card
    `define SCORE_ACE     4'b0001
    `define SCORE_2       4'b0010
    `define SCORE_3       4'b0011
    `define SCORE_4       4'b0100
    `define SCORE_5       4'b0101
    `define SCORE_6       4'b0110
    `define SCORE_7       4'b0111
    `define SCORE_8       4'b1000
    `define SCORE_9       4'b1001
    `define SCORE_10      4'b0000
    `define SCORE_JACK    4'b0000
    `define SCORE_QUEEN   4'b0000
    `define SCORE_KING    4'b0000
    `define SCORE_14      4'b0000
    `define SCORE_15      4'b0000


    scorehand dut( card1_tb, card2_tb, card3_tb, total_tb );

    /* Automated checker to ensure that the right score is
       calculated for each card value.
     */
    task tb_checker_score1;
        input [3:0] expected_card_score;
        begin 
            if( tb_scorehand.dut.score1 !== expected_card_score ) begin
                $display( "ERROR: Score should be %b,  not %b",
                expected_card_score, tb_scorehand.dut.score1 );
            
                err_score = 1'b1;
            end
        end
    endtask

    task tb_checker_score2;
        input [3:0] expected_card_score;
        begin 
            if( tb_scorehand.dut.score2 !== expected_card_score ) begin
                $display( "ERROR: Score should be %b,  not %b",
                expected_card_score, tb_scorehand.dut.score2 );
            
                err_score = 1'b1;
            end
        end
    endtask

    task tb_checker_score3;
        input [3:0] expected_card_score;
        begin 
            if( tb_scorehand.dut.score3 !== expected_card_score ) begin
                $display( "ERROR: Score should be %b,  not %b",
                expected_card_score, tb_scorehand.dut.score3 );
            
                err_score = 1'b1;
            end
        end
    endtask


    /* Automated checker to ensure that the total score
       calculated for the hand is correct.
     */
    task tb_checker_total;
        input [3:0] expected_total_score;
        begin 
            if( tb_scorehand.dut.total !== expected_total_score ) begin
                $display( "ERROR: Total score should be %b,  not %b",
                expected_total_score, tb_scorehand.dut.total );
            
                err_total = 1'b1;
            end
        end
    endtask

    initial begin
        // Initialize err
        err_score = 1'b0;
        err_total = 1'b0;

        // Initialize total, cardn_tb values (where 0<=n<=3)
        total_tb = 4'b0000;

        card1_tb = 4'b000;
        card2_tb = 4'b000;
        card3_tb = 4'b000;

        /* First set of tests loads a value onto card1_tb, card2_tb,
           and card3_tb and checks if the score computed from each possible
           card value is correct.
         */
        $display ( "Checking ace..." );
        card1_tb = `CARD_ACE;
        #10;
        tb_checker_score1 ( `SCORE_ACE );

        $display ( "Checking 2..." );
        card1_tb = `CARD_2;
        #10;
        tb_checker_score1 ( `SCORE_2 );

        $display ( "Checking 3..." );
        card2_tb = `CARD_3;
        #10;
        tb_checker_score2 ( `SCORE_3 );

        $display ( "Checking 4..." );
        card2_tb = `CARD_4;
        #10;
        tb_checker_score2 ( `SCORE_4 );

        $display ( "Checking 5..." );
        card3_tb = `CARD_5;
        #10;
        tb_checker_score3 ( `SCORE_5 );

        $display ( "Checking 6..." );
        card3_tb = `CARD_6;
        #10;
        tb_checker_score3 ( `SCORE_6 );

        $display ( "Checking 7..." );
        card1_tb = `CARD_7;
        #10;
        tb_checker_score1 ( `SCORE_7 );

        $display ( "Checking 8..." );
        card1_tb = `CARD_8;
        #10;
        tb_checker_score1 ( `SCORE_8 );

        $display ( "Checking 9..." );
        card2_tb = `CARD_9;
        #10;
        tb_checker_score2 ( `SCORE_9 );

        $display ( "Checking 10..." );
        card2_tb = `CARD_10;
        #10;
        tb_checker_score2 ( `SCORE_10 );

        $display ( "Checking jack..." );
        card3_tb = `CARD_JACK;
        #10;
        tb_checker_score3 ( `SCORE_JACK );

        $display ( "Checking queen..." );
        card3_tb = `CARD_QUEEN;
        #10;
        tb_checker_score3 ( `SCORE_QUEEN );

        $display ( "Checking king..." );
        card1_tb = `CARD_KING;
        #10;
        tb_checker_score1 ( `SCORE_KING );

        /* Checks if there are any errors for
           this set of tests
         */
        if ( ~err_score )
            $display( "Test for score calculation successful!" );

        else
            $display( "Errors detected in score calculation!" );


        
        /* Second set of tests loads values onto card1_tb, card2_tb
           card3_tb and checks if the total score computed is correct.
         */
        
        $display ( "Test 1: Ace + Queen + King" );
        card1_tb = `CARD_ACE;
        card2_tb = `CARD_QUEEN;
        card3_tb = `CARD_KING;
        #10;
        tb_checker_total ( 4'd1 );

        $display ( "Test 2: Jack + Queen + King" );
        card1_tb = `CARD_JACK;
        card2_tb = `CARD_QUEEN;
        card3_tb = `CARD_KING;
        #10;
        tb_checker_total ( 4'd0 );

        $display ( "Test 3: Jack + Ten + King" );
        card1_tb = `CARD_JACK;
        card2_tb = `CARD_10;
        card3_tb = `CARD_KING;
        #10;
        tb_checker_total ( 4'd0 );

        $display ( "Test 4: Ace + 5 + 7" );
        card1_tb = `CARD_ACE;
        card2_tb = `CARD_5;
        card3_tb = `CARD_7;
        #10;
        tb_checker_total ( 4'd3 );

        $display ( "Test 5: 3 + blank + blank" );
        card1_tb = `CARD_3;
        card2_tb = `CARD_BLANK;
        card3_tb = `CARD_BLANK;
        #10;
        tb_checker_total ( 4'd3 );

        $display ( "Test 6: 6 + 3 + blank" );
        card1_tb = `CARD_6;
        card2_tb = `CARD_3;
        card3_tb = `CARD_BLANK;
        #10;
        tb_checker_total ( 4'd9 );

        $display ( "Test 7: Ace + Ace + Ace" );
        card1_tb = `CARD_ACE;
        card2_tb = `CARD_ACE;
        card3_tb = `CARD_ACE;
        #10;
        tb_checker_total ( 4'd3 );

         /* Checks if there are any errors for
            this set of tests
         */
        if ( ~err_total )
            $display( "Test for total score calculation successful!" );

        else
            $display( "Errors detected in total score calculation!" );
    end
endmodule

