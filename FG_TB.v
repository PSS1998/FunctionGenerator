module FG_TB();
  
    reg clk=0,rst=0;

    reg [2:0] status = 0;
    wire [7:0] res;
    
    
    functionGenerator UUT (clk, rst, status, res);


    initial begin
        repeat (500000) #10 clk=~clk;
    end
    
  
 initial begin
        #10 rst=1;
        #10 rst=0;
    end
    
    initial begin
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
        #20000 status=status+1;
    end
    
endmodule 


