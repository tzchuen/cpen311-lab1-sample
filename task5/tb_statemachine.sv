module tb_statemachine();

    logic slow_clock, resetb;                       // input
    logic [3:0] dscore, pscore, pcard3;             // input
    logic load_pcard1, load_pcard2, load_pcard3;    // output
    logic load_dcard1, load_dcard2, load_dcard3;    // output
    logic player_win_light, dealer_win_light;       // output

    logic err;


    statemachine dut(.slow_clock(slow_clock), .resetb(resetb), 
                    .dscore(dscore), .pscore(pscore), .pcard3(pcard3),
                    .load_pcard1(load_pcard1), .load_pcard2(load_pcard2), .load_pcard3(load_pcard3),
                    .load_dcard1(load_dcard1), .load_dcard2(load_dcard2), .load_dcard3(load_dcard3),
                    .player_win_light(player_win_light), .dealer_win_light(dealer_win_light));
						
    initial begin
        slow_clock = 1'b0;
        #5;

        forever begin
            slow_clock = ~slow_clock;
            #5;
        end
    end

    initial begin
        err = 1'b0;
        resetb = 1'b0;
        $display("resetb assert");
        #20;

        $display("output signal check");
        assert (load_dcard1 === 1'b0) $display("load_dcard1 reset"); 
            else  begin
                $error("load_dcard1 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard2 === 1'b0) $display("load_dcard2 reset"); 
            else  begin
                $error("load_dcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard3 === 1'b0) $display("load_dcard3 reset"); 
            else  begin
                $error("load_dcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard1 === 1'b0) $display("load_pcard1 reset"); 
            else  begin
                $error("load_pcard1 != 0 ERR");
                err = 1'b1;
            end

        assert (load_pcard2 === 1'b0) $display("load_pcard2 reset"); 
            else  begin
                $error("load_pcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard3 === 1'b0) $display("load_pcard3 reset"); 
            else  begin
                $error("load_pcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (player_win_light === 1'b0) $display("player_win_light reset"); 
            else  begin
                $error("player_win_light != 0 ERR");
                err = 1'b1;
            end
        
        assert (dealer_win_light === 1'b0) $display("dealer_win_light reset"); 
            else  begin
                $error("dealer_win_light != 0 ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("output signals OK");
        
        else
            $display("ERRORS IN OUTPUT SIGNALS");
        
        err = 1'b0;
        $display("check state");

        
        assert (tb_statemachine.dut.state === 4'b0000) $display("state is INIT"); 
            else  begin
                $error("WRONG RESET STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");
        
        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b1;
        #10;

        $display("player natural with 8");

        assert (load_dcard1 === 1'b0) 
            else  begin
                $error("load_dcard1 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard2 === 1'b0) 
            else  begin
                $error("load_dcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard3 === 1'b0)
            else  begin
                $error("load_dcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard1 === 1'b1)
            else  begin
                $error("load_pcard1 != 1 ERR");
                err = 1'b1;
            end

        assert (load_pcard2 === 1'b0)
            else  begin
                $error("load_pcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard3 === 1'b0)
            else  begin
                $error("load_pcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (player_win_light === 1'b0) 
            else  begin
                $error("player_win_light != 0 ERR");
                err = 1'b1;
            end
        
        assert (dealer_win_light === 1'b0) 
            else  begin
                $error("dealer_win_light != 0 ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("output signals OK");
        
        else
            $display("ERRORS IN OUTPUT SIGNALS");
        
        err = 1'b0;
        
        assert (tb_statemachine.dut.state === 4'b0001) 
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");
        
        err = 1'b0;
        //pscore = 4'b0000;

        #10;
        assert (load_dcard1 === 1'b1) 
            else  begin
                $error("load_dcard1 != 1 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard2 === 1'b0)
            else  begin
                $error("load_dcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard3 === 1'b0) 
            else  begin
                $error("load_dcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard1 === 1'b0) 
            else  begin
                $error("load_pcard1 != 0 ERR");
                err = 1'b1;
            end

        assert (load_pcard2 === 1'b0) 
            else  begin
                $error("load_pcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard3 === 1'b0) 
            else  begin
                $error("load_pcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (player_win_light === 1'b0) 
            else  begin
                $error("player_win_light != 0 ERR");
                err = 1'b1;
            end
        
        assert (dealer_win_light === 1'b0) 
            else  begin
                $error("dealer_win_light != 0 ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("output signals OK");
        
        else
            $display("ERRORS IN OUTPUT SIGNALS");
        
        err = 1'b0;
        
        assert (tb_statemachine.dut.state === 4'b0010)
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;
        //dscore = 4'b0010
        #10;

        assert (load_dcard1 === 1'b0)
            else  begin
                $error("load_dcard1 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard2 === 1'b0)
            else  begin
                $error("load_dcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard3 === 1'b0) 
            else  begin
                $error("load_dcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard1 === 1'b0)
            else  begin
                $error("load_pcard1 != 0 ERR");
                err = 1'b1;
            end

        assert (load_pcard2 === 1'b1)
            else  begin
                $error("load_pcard2 != 1 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard3 === 1'b0) 
            else  begin
                $error("load_pcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (player_win_light === 1'b0) 
            else  begin
                $error("player_win_light != 0 ERR");
                err = 1'b1;
            end
        
        assert (dealer_win_light === 1'b0)
            else  begin
                $error("dealer_win_light != 0 ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("output signals OK");
        
        else
            $display("ERRORS IN OUTPUT SIGNALS");
        
        err = 1'b0;
        
        assert (tb_statemachine.dut.state === 4'b0011) 
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;
        pscore = 4'b1000;
        #10;

        assert (load_dcard1 === 1'b0) 
            else  begin
                $error("load_dcard1 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard2 === 1'b1) 
            else  begin
                $error("load_dcard2 != 1 ERR");
                err = 1'b1;
            end
        
        assert (load_dcard3 === 1'b0) 
            else  begin
                $error("load_dcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard1 === 1'b0)
            else  begin
                $error("load_pcard1 != 0 ERR");
                err = 1'b1;
            end

        assert (load_pcard2 === 1'b0) 
            else  begin
                $error("load_pcard2 != 0 ERR");
                err = 1'b1;
            end
        
        assert (load_pcard3 === 1'b0) 
            else  begin
                $error("load_pcard3 != 0 ERR");
                err = 1'b1;
            end
        
        assert (player_win_light === 1'b0) 
            else  begin
                $error("player_win_light != 0 ERR");
                err = 1'b1;
            end
        
        assert (dealer_win_light === 1'b0) 
            else  begin
                $error("dealer_win_light != 0 ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("output signals OK");
        
        else
            $display("ERRORS IN OUTPUT SIGNALS");
        
        err = 1'b0;
        
        assert (tb_statemachine.dut.state === 4'b0011) 
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;
        dscore = 4'b0111;
        #10;

        assert (tb_statemachine.dut.state === 4'b0111) 
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b1) && (dealer_win_light === 1'b0) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("player 8 natural test passed");
        
        else
            $error("TEST FAILED");
        
        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b0;
        #10;
        resetb = 1'b1;

        $display("dealer win natural with 9");
        #10; // p1
        #10; // d1
        #10; // p2
        pscore = 4'b0011;
        #10; // d2
        dscore = 4'b1001;
        #10;

        assert (tb_statemachine.dut.state === 4'b1000) 
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b0) && (dealer_win_light === 1'b1) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("dealer 9 natural test passed");
        
        else
            $error("TEST FAILED");

        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b0;
        #10;
        resetb = 1'b1;

        $display("dealer win, no d3");
        #10; // p1
        #10; // d1
        #10; // p2
        pscore = 4'b0101;
        #10; // d2
        dscore = 4'b0111;
        #10;

        assert (tb_statemachine.dut.state === 4'b1000)
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b0) && (dealer_win_light === 1'b1) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("dealer win no d3 test passed");
        
        else
            $error("TEST FAILED");
        
        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b0;
        #10;
        resetb = 1'b1;

        $display("tie, no p3, no d3");
        #10; // p1
        #10; // d1
        #10; // p2
        pscore = 4'b0111;
        #10; // d2
        dscore = 4'b0111;
        #10;

        assert (tb_statemachine.dut.state === 4'b1001)
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b1) && (dealer_win_light === 1'b1) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("tie no d3/p3 test passed");
        
        else
            $error("TEST FAILED");
        
        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b0;
        #10;
        resetb = 1'b1;

        $display("dealer win, no p3");
        #10; // p1
        #10; // d1
        #10; // p2
        pscore = 4'b0111;
        #10; // d2
        dscore = 4'b0101;
        #10; // d3
        dscore = 4'b1000;
        #10;

        assert (tb_statemachine.dut.state === 4'b1000)
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b0) && (dealer_win_light === 1'b1) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("dealer win no p3 test passed");
        
        else
            $error("TEST FAILED");

        err = 1'b0;

        $display("-----------------------------------------");
        resetb = 1'b0;
        #10;
        resetb = 1'b1;

        $display("player win, p3 and d3");
        #10; // p1
        #10; // d1
        #10; // p2
        pscore = 4'b0100;
        #10; // d2
        dscore = 4'b0011;
        #10; // p3
        pscore = 4'b0111;
        pcard3 = 4'b0011;
        #10; // d3
        dscore = 4'b0100;

        assert (tb_statemachine.dut.state === 4'b0111)
            else  begin
                $error("WRONG STATE ERR");
                err = 1'b1;
            end
        
        if (~err)
            $display("state OK");
        
        else
            $display("ERROR WITH STATE");

        err = 1'b0;

        assert ( (player_win_light === 1'b1) && (dealer_win_light === 1'b0) ) 
        else begin
            $error("WRONG WINNERS ERR");
            err = 1'b1;
        end

        if (~err)
            $display("player win d3/p3 test passed");
        
        else
            $error("TEST FAILED");
        

        







    end

endmodule

