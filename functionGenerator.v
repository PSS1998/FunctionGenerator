`timescale 1ns/1ns

module functionGenerator(input clk, rst, input [2:0] status, output reg[7:0] res);

reg signed [15:0] sin=16'b0000000000000000,cos=16'd30000;
reg signed [15:0] last_sin, last_cos;
reg [7:0] counter;
reg [2:0] last_status = 3'b0;

always @(posedge clk, posedge rst) begin
    if(rst == 1)begin
        sin =16'b0000000000000000;
        cos =16'd30000;
    end else if (status != last_status ) begin
        sin =16'b0000000000000000;
        cos =16'd30000;
    end else begin
        last_sin = sin;
        last_cos = cos;
        sin = last_sin + (last_cos>>>6);
        cos = last_cos - (sin>>>6);
    end
end

always @(posedge clk) begin
    if(rst == 1)begin
        counter = 8'b00000000;
    end else begin
        if(status != last_status)
            counter = 8'b00000000;
        else
            counter = counter + 1;
    end
end

always @(posedge clk) begin
    if (status != last_status ) begin
        last_status = status;
    end

    case (status)
        3'b000: begin
                    if(counter[0]) begin
            	          if(counter[7] == 0)
                           res = counter;
                        else
                            res = 255 - counter; 
                    end
                    else begin
                        if(counter[7] == 0)
                            res = -counter;
                        else
                            res = -(255 - counter);
                    end
                end
        3'b001: begin
                  res = sin[15:8] + 127;
                end
        3'b010: 
                if (counter[7] == 0)
                    res = 255;
                else
                    res = 0;
        3'b011: 
                if (counter[7] == 0)
                    res = counter;
                else
                    res = 255 - counter;
                
        3'b100: 
                res = counter;
        3'b101: begin
                    if(sin[15]==0)
                        res = 127 + sin[15:8];
                    else
                        res = 127 - sin[15:8];
                end
        3'b110: begin
                    if(counter[0]) begin
                        res = 127 + sin[15:8];
                    end else
                        res = 127 - sin[15:8];
                end
    endcase
end
endmodule


