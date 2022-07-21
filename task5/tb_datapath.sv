module tb_datapath();

    logic slow_clock;
    logic fast_clock;
    logic resetb;

    logic load_pcard1;
    logic load_pcard2;
    logic load_pcard3;
    logic load_dcard1;
    logic load_dcard2;
    logic load_dcard3;

    logic[3:0] pcard3_out;
    logic[3:0] pscore_out;
    logic[3:0] dscore_out;

    logic[6:0] HEX0;
    logic[6:0] HEX1;
    logic[6:0] HEX2;
    logic[6:0] HEX3;
    logic[6:0] HEX4;
    logic[6:0] HEX5;

    logic err;

    datapath dut(.slow_clock(slow_clock), .fast_clock(fast_clock), .resetb(resetb),
                .load_pcard1(load_pcard1), .load_pcard2(load_pcard2), .load_pcard3(load_pcard3),
                .load_dcard1(load_dcard1), .load_dcard2(load_dcard2), .load_dcard3(load_dcard3),
                .pcard3_out(pcard3_out), .pscore_out(pscore_out), .dscore_out(dscore_out),
                .HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));
    
    // slow_clock
    initial begin
        slow_clock = 1'b0;
        #5;

        forever begin
            slow_clock = ~slow_clock;
            #5;
        end
    end

    // fast_clock
    initial begin
        fast_clock = 1'b1;
        #1;

        forever begin
            fast_clock = ~fast_clock;
            #1;
        end
    end

    initial begin
        resetb = 1'b0;  // assert reset
        err = 1'b0;
        load_dcard1 = 1'b0;
        load_dcard2 = 1'b0;
        load_dcard3 = 1'b0;
        load_pcard1 = 1'b0;
        load_pcard2 = 1'b0;
        load_pcard3 = 1'b0;
        #50;

        resetb = 1'b1;  // deassert reset
        #50;

        $display("resetb checks");
        $display("reg4 checks");

        assert (tb_datapath.dut.p1_reg4 === 4'b0) $display("p1_reg4 OK");
            else begin
                err = 1'b1;
                $error("p1_reg4 ERR");
            end

        assert (tb_datapath.dut.p2_reg4 === 4'b0) $display("p2_reg4 OK");
            else begin
                err = 1'b1;
                $error("p2_reg4 ERR");
            end

        assert (tb_datapath.dut.p3_reg4 === 4'b0) $display("p3_reg4 OK");
            else begin
                err = 1'b1;
                $error("p3_reg4 ERR");
            end
        
        assert (tb_datapath.dut.d1_reg4 === 4'b0) $display("d1_reg4 OK");
            else begin
                err = 1'b1;
                $error("d1_reg4 ERR");
            end
        
        assert (tb_datapath.dut.d2_reg4 === 4'b0) $display("d2_reg4 OK");
            else begin
                err = 1'b1;
                $error("d2_reg4 ERR");
            end
        
        assert (tb_datapath.dut.d3_reg4 === 4'b0) $display("d3_reg4 OK");
            else begin
                err = 1'b1;
                $error("d3_reg4 ERR");
            end
        
        $display("output checks");

        assert (pcard3_out === 4'b0) $display("pcard3 OK");
            else begin
                err = 1'b1;
                $error("pcard3 ERR");
            end
        
        assert (pscore_out === 4'b0) $display("pscore OK");
            else begin
                err = 1'b1;
                $error("pscore ERR");
            end
        
        assert (dscore_out === 4'b0) $display("dscore OK");
            else begin
                err = 1'b1;
                $error("dscore ERR");
            end
        
        assert (HEX0 === 7'b1111111) $display("HEX0 OK");
            else begin
                err = 1'b1;
                $error("HEX0 ERR");
            end
        
        assert (HEX1 === 7'b11111111) $display("HEX1 OK");
            else begin
                err = 1'b1;
                $error("HEX1 ERR");
            end
        
        assert (HEX2 === 7'b1111111) $display("HEX2 OK");
            else begin
                err = 1'b1;
                $error("HEX2 ERR");
            end
        
        assert (HEX3 === 7'b1111111) $display("HEX3 OK");
            else begin
                err = 1'b1;
                $error("HEX3 ERR");
            end
        
        
        assert (HEX4 === 7'b1111111) $display("HEX4 OK");
            else begin
                err = 1'b1;
                $error("HEX4 ERR");
            end
        
        
        assert (HEX5 === 7'b1111111) $display("HEX5 OK");
            else begin
                err = 1'b1;
                $error("HEX5 ERR");
            end
        
        if(~err) begin
            $display("reset OK");
        end

        else begin
            $display("reset has errors");
        end

        $display("----------------------------------");
        resetb = 1'b0;
        err = 1'b0;
        #20
        resetb = 1'b1;

        $display("Test 1: P3 -> DJ -> P5 -> D7 -> P Win");



        force tb_datapath.dut.new_card = 4'b0011;
        load_pcard1 = 1'b1;
        #10;

        assert ( HEX0  === 7'b0110000 ) $display("HEX0 OK");
            else begin
                err = 1'b1;
                $error("HEX0 ERR");
            end
        
        assert ( pscore_out  === 4'b0011 ) $display("pscore = 3");
            else begin
                err = 1'b1;
                $error("pscore !=3 ERR");
            end
        
        assert ( dscore_out  === 4'b0000 ) $display("dscore = 0");
            else begin
                err = 1'b1;
                $error("pscore !=0 ERR");
            end



        load_pcard1 = 1'b0;
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = 4'b1011;
        load_dcard1 = 1'b1;
        #10;

        assert ( HEX3  === 7'b1100001 ) $display("HEX3 OK");
            else begin
                err = 1'b1;
                $error("HEX3 ERR");
            end
        
        assert ( pscore_out  === 4'b0011 ) $display("pscore = 3");
            else begin
                err = 1'b1;
                $error("pscore !=3 ERR");
            end
        
        assert ( dscore_out  === 4'b0000 ) $display("dscore = 0");
            else begin
                err = 1'b1;
                $error("pscore !=0 ERR");
            end



        load_dcard1 = 1'b0;
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = 4'b0101;
        load_pcard2 = 1'b1;
        #10;

        assert ( HEX1  === 7'b0010010 ) $display("HEX1 OK");
            else begin
                err = 1'b1;
                $error("HEX1 ERR");
            end
        
        assert ( pscore_out  === 4'b1000 ) $display("pscore = 8");
            else begin
                err = 1'b1;
                $error("pscore !=8 ERR");
            end
        
        assert ( dscore_out  === 4'b0000 ) $display("dscore = 0");
            else begin
                err = 1'b1;
                $error("pscore !=0 ERR");
            end



        load_pcard2 = 1'b0;
        release tb_datapath.dut.new_card;
        force tb_datapath.dut.new_card = 4'b0111;
        load_dcard2 = 1'b1;
        #10;

         assert ( HEX4  === 7'b1111000 ) $display("HEX4 OK");
            else begin
                err = 1'b1;
                $error("HEX4 ERR");
            end

        assert ( pscore_out  === 4'b1000 ) $display("pscore = 8");
            else begin
                err = 1'b1;
                $error("pscore !=8 ERR");
            end
        
        assert ( dscore_out  === 4'b0111 ) $display("dscore = 7");
            else begin
                err = 1'b1;
                $error("pscore !=7 ERR");
            end



        load_dcard2 = 1'b0;
        release tb_datapath.dut.new_card;
        
        assert ( pcard3_out === 4'b0 ) $display("no pcard3");
            else begin
                err = 1'b1;
                $error("pcard3 not zero ERR");
            end

        assert ( pscore_out === 4'b1000 ) $display("pscore = 8");
            else begin
                err = 1'b1;
                $error("pcard3 != 8 ERR");
            end
        
        assert ( dscore_out === 4'b0111 ) $display("dscore = 7");
            else begin
                err = 1'b1;
                $error("pcard3 != 7 ERR");
            end

        // assert ( HEX0  === 7'b0110000 ) $display("HEX0 OK");
        //     else begin
        //         err = 1'b1;
        //         $error("HEX0 ERR");
        //     end
        
        // assert ( HEX1  === 7'b0010010 ) $display("HEX1 OK");
        //     else begin
        //         err = 1'b1;
        //         $error("HEX1 ERR");
        //     end

        assert ( HEX2  === 7'b1111111 ) $display("HEX2 OK");
            else begin
                err = 1'b1;
                $error("HEX2 ERR");
            end
        
        // assert ( HEX3  === 7'b1100001 ) $display("HEX3 OK");
        //     else begin
        //         err = 1'b1;
        //         $error("HEX3 ERR");
        //     end
        
        // assert ( HEX4  === 7'b1111000 ) $display("HEX4 OK");
        //     else begin
        //         err = 1'b1;
        //         $error("HEX4 ERR");
        //     end
        
        assert ( HEX5  === 7'b1111111 ) $display("HEX5 OK");
            else begin
                err = 1'b1;
                $error("HEX5 ERR");
            end
        
         $display("----------------------------------");

        if (~err) begin
            $display("no errors!");
        end

        else begin
            $display("ERRORS DETECTED");
        end
        
    end
						
endmodule

