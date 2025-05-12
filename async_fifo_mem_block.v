`timescale 1ns / 1ps
module mem_block#(parameter addr=8,data=8,depth=128)(
input wclken,wclk,
input [data-1:0]wdata,
input [addr-2:0]waddr,raddr,
output [data-1:0]rdata);
reg [data-1:0]mem[depth-1:0];
always@(posedge wclk)
begin
if(wclken)
mem[waddr]<=wdata;
else
mem[waddr]<=4'bx;
end
assign rdata=mem[raddr];
endmodule
