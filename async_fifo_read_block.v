`timescale 1ns / 1ps
module read_block #(parameter data=6,addr=6)(
input rclk,r_en,rrst,
input [addr-1:0]rq2,
output r_empty,almost_empty,under_flow,
output [addr-1:0]rgray,
output reg [addr-1:0]rptr,rq2_bin,
output reg [addr-2:0]raddr);
integer i;
//reg [addr-2:0]raddr;
//reg [addr-1:0]rptr;
always@(posedge rclk or negedge rrst)begin
if(!rrst)begin
rptr<=4'b0000;
raddr<=4'b0000;
end
else
if(r_en&&!r_empty)begin
rptr<=rptr+1;
raddr<=raddr+1;
end
else  begin
rptr<=rptr;
raddr<=raddr;
end
end
assign rgray=((rptr)^(rptr>>1));
assign r_empty=(rq2==rgray);
assign rddr=rptr[addr-2:0];   

always @(*) begin
        rq2_bin[addr-1] = rq2[addr-1];  // MSB remains the same
        for (i = addr-2; i >= 0; i = i - 1) begin
            rq2_bin[i] =rq2_bin[i+1] ^ rq2[i];  // XOR operation for other bits
        end
    end      
    
 assign almost_empty=(rq2_bin-rptr<= 6'd4)?1'b1:1'b0;
 assign under_flow=((r_empty)&&(r_en))?1'b1:1'b0;
endmodule
