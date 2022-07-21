module tb_datapath();

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

    // Inputs: clock
    reg slow_clock; 
    reg fast_clock;
    reg resetb;

    // Inputs: player cards
    reg load_pcard1; 
    reg load_pcard2;
    reg load_pcard3;

    // Inputs: dealer cards
    reg load_dcard1; 
    reg load_dcard2; 
    reg load_dcard3;

    // Outputs: card/scores
    reg [3:0] pcard3_out;
    reg [3:0] pscore_out;
    reg [3:0] dscore_out;

    // Outputs: HEX display
    reg[6:0] HEX5; 
    reg[6:0] HEX4;
    reg[6:0] HEX3;
    reg[6:0] HEX2;
    reg[6:0] HEX1; 
    reg[6:0] HEX0;

    reg err;
    
    // Instantiates DUT
    datapath dut(.slow_clock(slow_clock), .fast_clock(fast_clock), .resetb(resetb),
                 .load_pcard1(load_pcard1), .load_pcard2(load_pcard2), .load_pcard3(load_pcard3),
                 .load_dcard1(load_dcard1), .load_dcard2(load_dcard2), .load_dcard3(load_dcard3),
                 .pcard3_out(pcard3_out), .pscore_out(pscore_out), .dscore_out(dscore_out),
                 .HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));

    // Cycles slow_clock
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

    // Cycles fast_clock
    // Cycles the clock
    initial begin
        fast_clock = 1'b1;
        #1;

        forever begin
            fast_clock = 1'b0;
            #1;
            fast_clock = 1'b1;
            #1;
        end
    end

    // Test suites
    initial begin
        resetb = 1'b0;
        err = 1'b0;
        #50;
        resetb = 1'b1;

        // Tests reset state
        $display("Testing reset states...");

        assert (pcard3_out === 4'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3_out not reset!");
                                end
        
        assert (pscore_out === 4'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore_out not reset!");
                                end

        assert (dscore_out === 4'b0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore_out not reset!");
                                end
        
        assert (HEX5 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX5 not reset!");
                                end 
        
        assert (HEX4 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX4 not reset!");
                                end
        
        assert (HEX3 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX3 not reset!");
                                end

        assert (HEX2 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX2 not reset!");
                                end
        
        assert (HEX1 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX1 not reset!");
                                end

        assert (HEX0 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX0 not reset!");
                                end
        
        if (~err) begin
            $display("Reset ok!");
            $display("----------------------------------------------");
        end

        else
            $display("ERRORS with reset!");
        
        /*******************************************************************************************/

        // Test 1
        $display("Resetting...");
        resetb = 1'b0;
        err = 1'b0;
        #50;
        resetb = 1'b1;

        $display("Test 1: P3 -> DJ -> P5 -> D7 -> P Win");

        force tb_datapath.dut.new_card = `CARD_3;
        #10;

        assert (HEX0 === `HEX_3) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX0 shows %b!", tb_datapath.dut.HEX0);
                                end
        
        assert (pscore_out === 4'd3) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd3);
                                end
        
        assert (dscore_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd0);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end
        
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_JACK;

        #10;

        assert (HEX3 === `HEX_JACK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX3 shows %b!", tb_datapath.dut.HEX3);
                                end
        
        assert (pscore_out === 4'd3) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd3);
                                end
        
        assert (dscore_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd0);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end

        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_5;
        
        #10;

        assert (HEX1 === `HEX_5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX1 shows %b!", tb_datapath.dut.HEX1);
                                end
        
        assert (pscore_out === 4'd8) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd8);
                                end
        
        assert (dscore_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd0);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end

        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_7;

        #10;
        
        assert (HEX4 === `HEX_7) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX4 shows %b!", tb_datapath.dut.HEX4);
                                end
        
        assert (pscore_out === 4'd3) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd3);
                                end
        
        assert (dscore_out === 4'd7) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd7);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end
        
        release tb_datapath.dut.new_card;
         
        #10;

        assert (HEX2 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX2 isn't blank!");
                                end

        assert (HEX5 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX5 isn't blank!");
                                end
        
        if (~err) begin
            $display("Test 1 passed!");
            $display("----------------------------------------------");
        end

        else
            $display("ERRORS with Test 1!");
        
        /*******************************************************************************************/
        // Test 2
        $display("Resetting...");
        resetb = 1'b0;
        err = 1'b0;
        #50;
        resetb = 1'b1;

        $display("Test 2: PA -> D5 -> P4 -> DA -> P2 -> DX P Win");

        force tb_datapath.dut.new_card = `CARD_ACE;
        #10;

        // PA -> D5 -> P4 -> DA -> P2 -> DX P Win
        assert (HEX0 === `HEX_ACE) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX0 shows %b!", tb_datapath.dut.HEX0);
                                end
        
        assert (pscore_out === 4'd1) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd1);
                                end
        
        assert (dscore_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd0);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end
        
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_5;

        #10;

        // PA -> D5 -> P4 -> DA -> P2 -> DX P Win
        assert (HEX3 === `HEX_5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX3 shows %b!", tb_datapath.dut.HEX3);
                                end

        assert (pscore_out === 4'd1) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd3);
                                end
        
        assert (dscore_out === 4'd5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd5);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end

        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_4;
        
        #10;

        // PA -> D5 -> P4 -> DA -> P2 -> DX P Win
        assert (HEX1 === `HEX_4) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX1 shows %b!", tb_datapath.dut.HEX1);
                                end

        assert (pscore_out === 4'd5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd5);
                                end
        
        assert (dscore_out === 4'd5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd5);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end

        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_ACE;

        #10;
        
        // PA -> D5 -> P4 -> DA -> P2 -> DX P Win
        assert (HEX4 === `HEX_ACE) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX4 shows %b!", tb_datapath.dut.HEX4);
                                end
        
        assert (pscore_out === 4'd5) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pscore shows %d; should be %d!", tb_datapath.dut.pscore_out,
                                            4'd5);
                                end
        
        assert (dscore_out === 4'd6) else begin 
                                    err = 1'b1;
                                    $display("ERROR: dscore shows %d; should be %d!", tb_datapath.dut.dscore_out,
                                            4'd6);
                                end
        
        assert (pcard3_out === 4'd0) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd0);
                                end
        
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = `CARD_2;
         
        #20;

        // PA -> D5 -> P4 -> DA -> P2 -> DX P Win
        assert (pcard3_out === 4'd2) else begin 
                                    err = 1'b1;
                                    $display("ERROR: pcard3 shows %d; should be %d!", tb_datapath.dut.pcard3_out,
                                            4'd2);
                                end
        assert (HEX2 === `HEX_2) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX2 shows %b!", tb_datapath.dut.HEX2);
                                end
        
        
        #20;

        assert (HEX5 === `HEX_BLANK) else begin 
                                    err = 1'b1;
                                    $display("ERROR: HEX5 isn't blank!");
                                end
        
        if (~err) begin
            $display("Test 2 passed!");
            $display("----------------------------------------------");
        end

        else
            $display("ERRORS with Test 2!");
        
        $stop;
        

    end
						
endmodule

