`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:37 10/26/2021 
// Design Name: 
// Module Name:    bi_direc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bi_direc(
i_clk ,rst_n  , CNT ,  a_in ,o_TEMPout , ld
    );
	 
	 
parameter DATA_WIDTH2 = 8	 ;
  input i_clk ;
//input [DATA_WIDTH2-1:0] d_in ;  
  input rst_n ;
  input a_in ;  ///used as serial in //
  input ld ; ///for loading the data///
  input  CNT ;  ///used for changing the dircetion of shift register if CNT==1 then right shift else left shift ///
 output reg [DATA_WIDTH2-1:0] o_TEMPout ;  ///used for led ////
 wire o_clk ;  ///intermediate clock wire for feeding the clock from clock divider module to the top module ///
 
 ///*********************************/////
  clock_div U1 (i_clk , o_clk);
  ///instantiation of clock divider ///
  
  always @ (posedge o_clk )
   begin
	if (~rst_n)
	o_TEMPout <= 0;  
else if (ld==1)
begin
 if (CNT==1)
 o_TEMPout <= {a_in , o_TEMPout[7:1] };  ///right shift //
else
 o_TEMPout <= {o_TEMPout[6:0] , a_in} ;   ///left shift ///
end
end
endmodule 

///clock divider /////
module clock_div (i_clk , out_clk);
input i_clk ;
output reg out_clk ;

reg [26:0] count ;

always @ (posedge i_clk)
 begin
  count = count + 1'b1;
  if (count == 50_000_000)
   begin
	out_clk = ~out_clk ;
	count = 0;
	end
	end
	endmodule 










/* always @ (posedge i_clk or negedge rst_n )
 begin
 if (~rst_n)
count <= 0;
else if (count == max_cnt )
 count <= 0 ;
 else
 count <= count + 1'b1 ;
 end

assign M = count == 0 ; */

 /*always @ (posedge i_clk or  negedge rst_n)
   begin
     if (~rst_n)
      begin
     o_TEMPout <= 4'b0000 ;  
      end
      else
       begin
   if (M==1)
    begin      /////left shift///
	  o_TEMPout[0] <= a_in  ;
  o_TEMPout[1] <= o_TEMPout[0];
  o_TEMPout [2] <= o_TEMPout[1] ;
  o_TEMPout [3] <=  o_TEMPout[2] ;     
     end 
   else 
     begin      /////right shift///
   o_TEMPout[3] <= a_in ;
   o_TEMPout [2] <= o_TEMPout [3];
   o_TEMPout[1] <= o_TEMPout[2];
    o_TEMPout[0] <= o_TEMPout[1];
   end
     end  
  end
  
endmodule
*/











