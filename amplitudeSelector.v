`timescale 1ns/1ns

module amplitudeSelector(input clk, input[7:0] res_in, input[1:0] sel, output reg[7:0] res_out);

always @(posedge clk) begin
    case (sel)
      2'b00: begin
                res_out = res_in;
             end
      2'b01: begin
                res_out = res_in>>>1;
             end
      2'b10: begin
                res_out = res_in>>>2;
             end
      2'b11: begin
                res_out = res_in>>>3;
             end
    endcase
end

endmodule