`timescale 1ns / 1ps
module write_block #(parameter data=6,addr=6)(
input wclk,w_en,wrst,
input [addr-1:0]wq2,
output w_full,almost_full,over_flow,
output [addr-1:0]wgray,
output reg [addr-1:0]wptr,wq2_bin,
output reg[addr-2:0]waddr);
integer i;
reg [addr-1:0] binary;
always@(posedge wclk or negedge wrst)begin
if(!wrst)begin
wptr<=4'b0000;
waddr<=4'b0000;
end
else
if(w_en&&!w_full)begin
wptr<=wptr+1;
waddr<=waddr+1;
end
else begin
wptr<=wptr;
waddr<=waddr;
end
end
always @(*) begin
        wq2_bin[addr-1] = wq2[addr-1];  // MSB remains the same
        for (i = addr-2; i >= 0; i = i - 1) begin
            wq2_bin[i]=wq2_bin[i+1] ^ wq2[i];  // XOR operation for other bits
        end
    end
assign wgray=((wptr>>1)^(wptr));
assign w_full=((wgray[addr-1]!=wq2[addr-1])&&
                (wgray[addr-2]!=wq2[addr-2])&&
                (wgray[addr-3:0]==wq2[addr-3:0]));
assign almost_full=(wptr-wq2_bin>=6'd28)?1'b1:1'b0;     
assign over_flow= ((w_full)&&(w_en))?1'b1:1'b0;
endmodule
