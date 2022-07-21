module tb_scorehand();

    logic [3:0] card1;
    logic [3:0] card2;
    logic [3:0] card3;
    logic [3:0] total;
    logic err;

    scorehand dut (.card1(card1), .card2(card2), .card3(card3), .total(total));

    initial begin
        card1 = 4'b0;
        card2 = 4'b0;
        card3 = 4'b0;
        err = 1'b0;
        #10;

        $display("Check reset");

        assert (total === 4'b0) $display("total is reset"); 
            else begin
                $error("total != 0 ERR");
                err = 1'b1;
            end

        $display("J, Q, K");
        card1 = 4'b1011;
        card2 = 4'b1100;
        card3 = 4'b1101;

        #10;

        assert (total === 4'b0) $display("total = 0"); 
            else begin
                $error("total != 0 ERR");
                err = 1'b1;
            end

        $display("------------------------------");

        $display("A, 5, 9");
        card1 = 4'b0001;
        card2 = 4'b0101;
        card3 = 4'b1001;
        
        #10;

        assert (total === 4'b0101) $display("total = 5"); 
            else begin
                $error("total != 5 ERR");
                err = 1'b1;
            end
        
        $display("------------------------------");

        $display("2, 5, 3");
        card1 = 4'b0010;
        card2 = 4'b0101;
        card3 = 4'b0011;
        
        #10;

        assert (total === 4'b0) $display("total = 0"); 
            else begin
                $error("total != 0 ERR");
                err = 1'b1;
            end

        
        $display("------------------------------");

        $display("3, 2, 3");
        card1 = 4'b0011;
        card2 = 4'b0010;
        card3 = 4'b0011;
        
        #10;

        assert (total === 4'b1000) $display("total = 8"); 
           else begin
                $error("total != 8 ERR");
                err = 1'b1;
            end

        
        $display("------------------------------");

        $display("A, A, K");
        card1 = 4'b0001;
        card2 = 4'b0001;
        card3 = 4'b1101;
        
        #10;

        assert (total === 4'b0010) $display("total = 2"); 
            else begin
                $error("total != 2 ERR");
                err = 1'b1;
            end
        
        $display("------------------------------");
        
        if (~err) begin
            $display("all tests OK");
        end

        else
            $display("ERRORS detected");

    end
						
endmodule

