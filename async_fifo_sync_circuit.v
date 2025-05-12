`timescale 1ns / 1ps
module sync_cicuit#(addr=8)
(input rclk,rrst,
input [addr-1:0]wgray,
output reg [addr-1:0]rq2,
output reg [addr-1:0]rq1);
always@(posedge rclk or negedge rrst)
begin
if(!rrst)
begin
rq1<=4'b0000;
rq2<=4'b0000;
end
else begin
rq1<=wgray;
rq2<=rq1;
end
end
endmodule
