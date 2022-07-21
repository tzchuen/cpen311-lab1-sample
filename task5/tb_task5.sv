module tb_task5();

    logic CLOCK_50;
    logic [3:0] KEY;
    logic [9:0] LEDR;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    task5 dut (.CLOCK_50(CLOCK_50), .KEY(KEY), .LEDR(LEDR),
            .HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3),
            .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));
    
    initial begin
        CLOCK_50 = 1'b1;
        #1;

        forever begin
            CLOCK_50 = ~CLOCK_50;
            #1;
        end
    end

    initial begin
        KEY[0] = 1'b1;
        #5;

        forever begin
            KEY[0] = ~KEY[0];
            #5;
        end
    end

    initial begin
        KEY[3] = 1'b0;
        #10;
        KEY[3] = 1'b1;

        #10;
        $display("dscore = %b, pscore = %b", tb_task5.dut.datapath.dscore, tb_task5.dut.datapath.pscore);

        #10;
        $display("dscore = %b, pscore = %b", tb_task5.dut.datapath.dscore, tb_task5.dut.datapath.pscore);

        #10;
        $display("dscore = %b, pscore = %b", tb_task5.dut.datapath.dscore, tb_task5.dut.datapath.pscore);

        #10;
        $display("dscore = %b, pscore = %b", tb_task5.dut.datapath.dscore, tb_task5.dut.datapath.pscore);
    end
						
endmodule

