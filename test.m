% clear
% % input=[1,0,1,0,1,1,1,0,1];
% input=[1,0,1,0,0,0,0,0,1];
% output=recursive_conv(input);
% % R=get_R(output,0.1);
% R=[-1.8436 -1.6465 1.1497 -4.5480 -0.8560 3.6489 -2.9015 6.7173 2.4769 2.8979];
% R=[R;[-6.2077 0 2.5200 0 -1.4442 0 2.4250 0 3.8161 0]]';
% trellis=get_trellis();
% A=zeros(1,size(R,1));
% L=log_BCJR(trellis,A,R)
% output;
% result=-sign(L);