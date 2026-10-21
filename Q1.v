
module Q1 (input  wire clk,reset,x,
    output reg  z);                       //these are declared as per question requirement


    reg [2:0] history;            //here history is used to store the 3 bit values to check if it matches required no.
    wire [3:0] req;               //required no. these are the numbers from questions for which output should be 1

    assign req = {history, x};            //combining previous 3 bits and present bit

    always @(posedge clk) begin     //under this always block output and history gets updated if requirement is met
        if (reset) begin
            history <= 3'b000;     //resets 3 previous bit value to 000
            z <= 1'b0;           //output is also set to 0
				
        end
        else begin
            case (req)                 //case block is used to verify the requirements and then pass output
                4'b0010:z<=1'b1;
                4'b0100:z<=1'b1;
                4'b0101:z<=1'b1;
                4'b1000:z<=1'b1;
                4'b1110:z<=1'b1;
                default:z <= 1'b0;
            endcase

           
 history <= {history[1:0], x};    // previous 3 bits get updated to next 3 bits
 end
 end

endmodule
