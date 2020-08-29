module m74160(CP, Rd, LD, EP, ET, D, Q, C, out_Q2);
//定义输入输出
input Rd, LD, EP, ET;
input CP;//clock
input[3:0] D;
output[3:0] Q;
output C;//进位
inout out_Q2;

wire[3:0] out_Q1;
wire out_C2;
wire out_C1;
_74160 u_74160(CP, Rd, LD, EP, ET, D, out_Q2, out_C2, out_Q1, out_C1);

reg[3:0] Q;
reg C;
reg[3:0] out_Q2;
always@(out_Q1, out_Q2)
begin
Q = out_Q1 & out_Q2;
out_Q2 = Q;
end

always@(out_C1, out_C2)
C = out_C1 & out_C2;
endmodule