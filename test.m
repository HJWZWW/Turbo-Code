clear
input=[1,1,1,1];
output=recursive_conv(input);
R=get_R(output,0.3);
trellis=get_trellis();
A=zeros(1,size(R,1));
L=log_BCJR(trellis,A,R);
output
result=-sign(L)