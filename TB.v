`timescale 1ns/1ns

module lab3_TB();
reg  setReset=1'b1, init, clk_50=1'b0;
wire PSI, o1, o0, o3, o2, o4, o5, o6, o7;
wire [7:0]AdjDiv;
reg [7:0] setPeriod=25;
wire [7:0] duration;
wire RO;
reg en,rst;
wire Cout;
wire	[7:0] result;
reg	[2:0] status=1;
wire 	[7:0] result_final;
reg 	[1:0] ampSelect=0;

ring_oscillator #(.NO_STAGES(3), .INV_DELAY_ns(6) ) ringOscillator (en, RO);

FunctionGenerator function_generator(
  PSI,
	AdjDiv,
	clk_50,
	rst,
	setPeriod,
	RO,
	init,
	setReset,
	o1,
	o0,
	o3,
	o2,
	o4,
	o5,
	o6,
	o7,
	Cout,
	duration,
	result,
	status,
	result_final,
	ampSelect);

initial repeat(200000) #10 clk_50 = ~clk_50;

initial begin
    en = 1'b0;
    init = 1'b0;
    rst = 1'b1;
    #10 init=1'b1;
    #5000
    en = 1'b1;
    rst = 1'b0;
end

initial begin
        #400000 ampSelect=ampSelect+1;
        #400000 ampSelect=ampSelect+1;
        #400000 ampSelect=ampSelect+1;
        #400000 ampSelect=ampSelect+1;
end

endmodule 
