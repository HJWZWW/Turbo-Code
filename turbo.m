function [message, p1, p2] = turbo(u)
% turbo码编码器
message = recursive_conv(u);
message = message(:, 1);%信息位

p1 = message(:, 2);% p1

p2 = recursive_conv(interleaver(u));% p2
p2 = p2(:,2);

p1 = p1(1:2:end);% 打孔
p2 = p2(2:2:end);
end