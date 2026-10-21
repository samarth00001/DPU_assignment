`timescale 1ns/1ps

module tb_Q1;

    reg clk,x,reset;
    
     
    wire z;

    reg [18:0] X;
    reg [18:0] Y;

    integer i,errors;
    

    Q1 dut (.clk(clk),.reset(reset),.x(x),.z(z));

   initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        X = 19'b0010100100010111010;
        Y = 19'b0001101011101100100;

        reset = 1'b1;
        x = 1'b0;
        errors = 0;

        @(posedge clk);
        #1;
        reset = 1'b0;

        
        for (i = 0; i < 19; i = i + 1) begin
            @(negedge clk);
            x = X[18-i];

            @(posedge clk);
            #1;

            $display("Cycle=%0d X=%b Expected=%b Actual=%b",i, X[18-i], Y[18-i], z);

            if (z !== Y[18-i]) begin
                $display("ERROR at cycle %0d", i);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("PASS: All 19 output bits match.");
        else
            $display("FAIL: %0d mismatches found.", errors);

        $finish;
    end

endmodule
