`timescale 1ns / 1ps
module sync_cicuit2#(addr=8)
(input wclk,wrst,
input [addr-1:0]rgray,
output reg [addr-1:0]wq2,
output reg [addr-1:0]wq1);
always@(posedge wclk or negedge wrst)
begin
if(!wrst)
begin
wq1<=4'b0000;
wq2<=4'b0000;
end
else begin
wq1<=rgray;
wq2<=wq1;
end
end
endmodule
