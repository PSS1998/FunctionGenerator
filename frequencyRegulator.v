`timescale 1ns/1ns

module frequencyRegulator(
			input wire psi,
			input wire [7:0] setPeriod,
			input wire clk,
			input wire rst,
			output reg [7:0] adjusetDiv,
			output [7:0] clk_duration);
  
  reg  [7:0] duration;
  reg oldpsi;
   
  always @(posedge clk, posedge rst) 
    if (rst) 
        oldpsi <= 1'b0;
    else 
	     oldpsi <= psi;
	    
	    
	always @(posedge clk, posedge rst) begin
	  if(rst)
	      duration <= 8'b0;
    else begin
      case ({oldpsi,psi})
        2'b00: duration <= duration;
        2'b01: duration <= 8'b0;
        2'b10: duration <= duration;
        2'b11: duration <= duration+1;
      endcase
    end
  end
	
	always @ (posedge clk, posedge rst) begin
	    if (rst)
	       adjusetDiv <= 8'b11111111-setPeriod; 
      else if ({oldpsi,psi}==2'b10) begin
	       if (duration > setPeriod>>1)
 	          adjusetDiv <= adjusetDiv+1;  
 	       else if (duration < setPeriod>>1)
 	          adjusetDiv <= adjusetDiv-1;
 	       else
 	          adjusetDiv <= adjusetDiv;
      end
	end
	
	assign clk_duration = duration<<1;
	
endmodule




