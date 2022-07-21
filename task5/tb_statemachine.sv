module tb_statemachine();

reg slow_clock;
reg resetb;
reg err;          // error flag

// Inputs
reg [3:0] dscore; 
reg [3:0] pscore; 
reg [3:0] pcard3;

// Outputs
reg load_dcard1, load_dcard2, load_dcard3, load_pcard1, load_pcard2, load_pcard3;
reg player_win_light, dealer_win_light;

// Instantiate dut
statemachine dut(slow_clock,resetb,dscore,pscore,pcard3,load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light);

// Cycles the clock
initial begin
    slow_clock = 1'b0;
    #5;

    forever begin
        slow_clock = 1'b1;
        #5;
        slow_clock = 1'b0;
        #5;
    end
end

initial begin
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;
    
    
    // Tests reset: inputs
    $display("Testing reset...");
    
    // Tests reset: outputs
    assert (load_dcard1 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_dcard1 not reset!");
                                end

    assert (load_dcard2 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_dcard2 not reset!");
                                end

    assert (load_dcard3 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_dcard3 not reset!");
                                end
    
    assert (load_pcard1 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_pcard1 not reset!");
                                end
    
    assert (load_pcard2 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_pcard2 not reset!");
                                end
    
    assert (load_pcard3 === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: load_pcard3 not reset!");
                                end
                            
    assert (dealer_win_light === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dealer_win_light not reset!");
                                end
    
    assert (player_win_light === 1'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: player_win_light not reset!");
                                end
    //resetb <= 1'b1;

    if (~err)
        $display("Reset ok!");

    else   
        $display("ERROR: Reset");

/*****************************************************************************************************/
// Checks if player and dealer are dealed 2 cards each properly 
    err = 1'b0;
    
    $display("Testing deal sequence (up to 2 cards)...");

    #10;
    assert (load_pcard1 === 1'b1) $display("pcard1 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: pcard1 not dealt!");
                                end
    
    #10;


    assert (load_pcard1 === 1'b0) else begin
                                err = 1'b1;
                                $display("ERROR: pcard1 not reset!");
                                end

    assert (load_dcard1 === 1'b1) $display("dcard1 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard1 not dealt!");
                                end

    #10;


    assert (load_dcard1 === 1'b0) else begin
                                err = 1'b1;
                                $display("ERROR: dcard1 not reset!");
                                end

    assert (load_pcard2 === 1'b1) $display("pcard2 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: pcard2 not dealt!");
                                end

    #10;


    assert (load_pcard2 === 1'b0) else begin
                                err = 1'b1;
                                $display("ERROR: pcard2 not reset!");
                                end

    assert (load_dcard2 === 1'b1) $display("dcard2 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard2 not dealt!");
                                end

    #10;

    assert (load_dcard2 === 1'b0) $display("dcard2 reset!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard2 not reset!");
                                end

    
    if (~err) begin
        $display("Deal sequence has no errors!");
        $display("----------------------------");
    end

    else
        $display("Errors detected with deal sequence!");

    //$stop;

   /*****************************************************************************************************/
   // Checks for "naturals", player wins
    // Reset
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    $display("Testing naturals...");
    $display("Test 1: pscore = 9; player wins");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd9;
    dscore = 4'd8;

    #20;

    assert ( (player_win_light === 1'b1 && dealer_win_light === 1'b0) ) $display("Test 1 passed!"); else begin
                                err = 1'b1;
                                $display("ERROR: Test 1 failed!");
                                end

    //$stop;

    /*****************************************************************************************************/
    // Checks for "naturals", dealer wins
    // Reset
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    $display("Test 2: dscore = 9; dealer wins");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd8;
    dscore = 4'd9;

    #20;

    assert ( (player_win_light === 1'b0 && dealer_win_light === 1'b1) ) $display("Test 2 passed!"); else begin
                                err = 1'b1;
                                $display("ERROR: Test 2 failed!");
                                end
    
  /*****************************************************************************************************/
  // Checks for "naturals", tie (8)
  // Reset
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    $display("Test 3: pscore = dscore = 8; tie");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd8;
    dscore = 4'd8;

    #20;

    assert ( (player_win_light === 1'b1 && dealer_win_light === 1'b1) ) $display("Test 3 passed!"); else begin
                                err = 1'b1;
                                $display("ERROR: Test 3 failed!");
                                end

  /*****************************************************************************************************/
  // Checks for "naturals", tie (9)
  // Reset

    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    $display("Test 4: pscore = dscore = 9; tie");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd9;
    dscore = 4'd9;

    #20;

    assert ( (player_win_light === 1'b1 && dealer_win_light === 1'b1) ) $display("Test 4 passed!"); else begin
                                err = 1'b1;
                                $display("ERROR: Test 4 failed!");
                                end

    if (~err) begin
        $display("No errors with naturals!");
        $display("----------------------------");
    end

    else
        $display("Errors detected with naturals!");
    
    //$stop;
    
/*****************************************************************************************************/
// Checks for load_pcard3; checks if it is triggered appropriately - TEST 1
// Reset

    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    $display("Testing load_pcard3/load_dcard3...");

    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    
    $display("Test 1 - Player score: 5, dealer score: 6, pcard3: 7");
    pscore = 4'd5;
    dscore = 4'd6;
    pcard3 = 4'd7;

    #20;

    assert (load_pcard3 === 1'b1) $display("pcard3 dealt!");else begin
                                err = 1'b1;
                                $display("ERROR: pcard3 not dealt!");
                                end
    
    #20;
    
    assert (load_dcard3 === 1'b1) $display("dcard3 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard3 not dealt!");
                                end
    
    #20;
    
    if (~err)
        $display("Test 1 passed !");

    else
        $display("Errors detected in Test 1!");
    
    //$stop;


    /*****************************************************************************************************/
    // Checks for load_pcard3; checks if it is triggered appropriately - TEST 2
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    
    $display("Test 2 - Player score: 0, dealer score: 3, pcard3: 8");
    pscore = 4'd0;
    dscore = 4'd3;
    pcard3 = 4'd8;

    #20;

    assert (load_pcard3 === 1'b1) $display("pcard3 dealt!");else begin
                                err = 1'b1;
                                $display("ERROR: pcard3 not dealt!");
                                end
    
    #20;
    
    assert (load_dcard3 === 1'b0) $display("dcard3 not dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard3 was dealt!");
                                end
    
    #20;
    
    if (~err)
        $display("Test 2 passed !");

    else
        $display("Errors detected in Test 2!");
    
    //$stop;

    /*****************************************************************************************************/
    // Checks for load_pcard3; checks if it is triggered appropriately - TEST 3
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    
    $display("Test 3 - Player score: 6, dealer score: 5, pcard3: 0");
    pscore = 4'd6;
    dscore = 4'd5;
    pcard3 = 4'd0;

    #20;

    assert (load_pcard3 === 1'b0) $display("pcard3 not dealt!");else begin
                                err = 1'b1;
                                $display("ERROR: pcard3 was dealt!");
                                end
    
    #20;
    
    assert (load_dcard3 === 1'b1) $display("dcard3 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard3 not dealt!");
                                end
    
    #20;
    
    if (~err)
        $display("Test 3 passed !");

    else
        $display("Errors detected in Test 3!");
    
    //$stop;


    /*****************************************************************************************************/
    // Checks for load_pcard3; checks if it is triggered appropriately - TEST 4
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    
    $display("Test 4 - Player score: 6, dealer score: 7, pcard3: 0");
    pscore = 4'd6;
    dscore = 4'd7;
    pcard3 = 4'd0;

    #20;

    assert (load_pcard3 === 1'b0) $display("pcard3 not dealt!");else begin
                                err = 1'b1;
                                $display("ERROR: pcard3 was dealt!");
                                end
    
    #20;
    
    assert (load_dcard3 === 1'b0) $display("dcard3 not dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard3 was dealt!");
                                end
    
    #20;
    
    if (~err)
        $display("Test 4 passed !");

    else
        $display("Errors detected in Test 4!");
    
    //$stop;
    
    /*****************************************************************************************************/
    // Checks for load_pcard3; checks if it is triggered appropriately - TEST 5
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    
    $display("Test 5 - Player score: 5, dealer score: 2, pcard3: 7");
    pscore = 4'd5;
    dscore = 4'd2;
    pcard3 = 4'd7;

    #20;

    assert (load_pcard3 === 1'b1) $display("pcard3 dealt!");else begin
                                err = 1'b1;
                                $display("ERROR: pcard3 not dealt!");
                                end
    
    #20;
    
    assert (load_dcard3 === 1'b1) $display("dcard3 dealt!"); else begin
                                err = 1'b1;
                                $display("ERROR: dcard3 not dealt!");
                                end
    
    #20;
    
    if (~err) begin
        $display("Test 5 passed !");
        $display("----------------------------");
    end

    else
        $display("Errors detected in Test 5!");
    
    //$stop;

    /*****************************************************************************************************/
    // Tests one whole game - TEST 1
    $display("Tests one whole game");

    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    
    $display("Test 1 - pscore = 5 -> 1, dscore = 4 -> 4");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd5;
    dscore = 4'd4;
    pcard3 = 4'd6;

    // eval_p3 -> deal/skip_p3 -> eval_d3 -> deal/skip_d3
    #40;

    pscore = 4'd1;
    dscore = 4'd4;


    #10;

    assert (player_win_light === 1'b0) $display("player_win_light off!");else begin
                                err = 1'b1;
                                $display("ERROR: player_win_light on!");
                                end

    assert (dealer_win_light === 1'b1) $display("dealer_win_light on!");else begin
                                err = 1'b1;
                                $display("ERROR: dealer_win_light off!");
                                end
    
    if (~err) begin
        $display("Test 1 passed !");
    end

    else
        $display("Errors detected in Test 1!");

    //$stop;

    /*****************************************************************************************************/
    // Tests one whole game - TEST 2
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    
    $display("Test 2 - pscore = 5 -> 5, dscore = 4 -> 4");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd5;
    dscore = 4'd4;
    pcard3 = 4'd10;

    // eval_p3 -> deal/skip_p3 -> eval_d3 -> deal/skip_d3
    #40;

    pscore = 4'd5;
    dscore = 4'd4;


    #10;

    assert (player_win_light === 1'b1) $display("player_win_light on!");else begin
                                err = 1'b1;
                                $display("ERROR: player_win_light off!");
                                end

    assert (dealer_win_light === 1'b0) $display("dealer_win_light off!");else begin
                                err = 1'b1;
                                $display("ERROR: dealer_win_light on!");
                                end
    
    if (~err) begin
        $display("Test 2 passed !");
    end

    else
        $display("Errors detected in Test 2!");

    //$stop;

    /*****************************************************************************************************/
    // Tests one whole game - TEST 3
    resetb = 1'b0;
    err = 1'b0;
    #50;
    resetb = 1'b1;

    
    $display("Test 3 - pscore = 3 -> 4, dscore = 4 -> 4");
    // pcard1 -> dcard1 -> pcard2 -> dcard2
    #40;

    pscore = 4'd3;
    dscore = 4'd4;
    pcard3 = 4'd10;

    // eval_p3 -> deal/skip_p3 -> eval_d3 -> deal/skip_d3
    #40;

    pscore = 4'd4;
    dscore = 4'd4;


    #10;

    assert (player_win_light === 1'b1) $display("player_win_light on!");else begin
                                err = 1'b1;
                                $display("ERROR: player_win_light off!");
                                end

    assert (dealer_win_light === 1'b1) $display("dealer_win_light on!");else begin
                                err = 1'b1;
                                $display("ERROR: dealer_win_light off!");
                                end
    
    if (~err) begin
        $display("Test 3 passed !");
    end

    else
        $display("Errors detected in Test 3!");

    $stop;

    end
endmodule

