`timescale 1ns/1ns

module ring_oscillator#(
                        parameter num=3,      // Number of inverters
                        parameter delay=38      // Delay of each inverter
                        )(
                            input  enable,
                            output reg pulse
                        ); 
           

  reg wire_first;
  reg [num-2:0] wire_middle;
  reg wire_last;
  integer i;
  
        
        
        always @* begin
                if(enable) begin
                        pulse <= wire_first;
                end
        end

        
        always @* begin
            if(enable) begin
                wire_middle[0] <= #delay ~wire_first;
                for(i=0; i<num-2; i=i+1) begin
                        wire_middle[i+1] <= #delay ~wire_middle[i];
                end
                wire_last <= #delay ~wire_middle[num-2];
            end
        end

        
        always @* begin
                if(enable) begin
                        wire_first <= wire_last;
                end else begin
                        wire_first <= enable;
                end
        end
        
        always @(posedge enable) begin
                if(enable) begin
                        wire_middle[0] <= 1'b1;
                        for(i=1; i<num-1; i=i+1) begin
                            wire_middle[i] <= (i%2)?1'b0:1'b1;
                        end
                        /*wire_middle[1] <= 1'b0;*/
                        wire_last <= 1'b0;
                end
        end
      

endmodule