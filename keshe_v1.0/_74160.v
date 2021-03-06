//实现74160 10进制计数,但是做成了同步置数
module _74160(CP, Rd, LD, EP, ET, D, Q, C);

//定义输入输出
input Rd, LD, EP, ET;
input CP;//clock
input[3:0] D;
inout[3:0] Q;
output C;//进位

reg[3:0] out_Q, cnt_Q ;
reg out_C, cnt_C;
reg[3:0] Q;
reg C;
reg[3:0] out_Q1 = 4'b1111;
reg out_C1;

always @(Rd , LD , EP , ET)
begin
out_Q1 = 4'b1111;
out_C1 = 1;
	case({Rd, LD, EP, ET})
	
	//置零
	4'b0000: out_Q1 = 4'b0000;	
	4'b0001: out_Q1 = 4'b0000;
	4'b0010: out_Q1 = 4'b0000;	
	4'b0011: out_Q1 = 4'b0000;	
	4'b0100: out_Q1 = 4'b0000;	
	4'b0101: out_Q1 = 4'b0000;	
	4'b0110: out_Q1 = 4'b0000;	
	4'b0111: out_Q1 = 4'b0000;
	
	//同步预置数
	4'b1000: out_Q <= D;	
	4'b1001: out_Q <= D;	
	4'b1010: out_Q <= D;	
	4'b1011: out_Q <= D;
	
	4'b1101: ;//保持
	
	//C 置零
	4'b1100: out_C1 <= 1'b0;	
	4'b1110: out_C1 <= 1'b0;
	
	//计数见下一个always
	4'b1111: ;
	
	endcase

end


always @(posedge CP, negedge Rd)
begin
//C = ~C;
//计数部分
if(!Rd)
Q = 4'b0000;
else if({Rd, LD, EP, ET} == 4'b1111) 
	begin
	if(Q == 4'b1001) cnt_Q = 0;
	else cnt_Q = Q + 4'b0001;
	//产生进位
	if(cnt_Q == 4'b1001) cnt_C = 1'b1;
	else cnt_C = 1'b0;
	Q = cnt_Q;
	C = cnt_C;
	end
	
else if(Rd== 0) Q = out_Q;

else if({Rd, LD} == 2'b10) Q = out_Q;

else if({Rd, LD, ET} == 3'b110) C = out_C;

else ;

end



endmodule