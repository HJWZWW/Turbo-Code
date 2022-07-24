function [message, p1, p2] = turbo(u)
% turbo码编码器
code = recursive_conv(u);
message = code(:, 1);%信息位

p1 = code(:, 2);% p1

p2 = recursive_conv(interleaver(u));% p2
p2 = p2(:,2);

p1 = p1(1:2:end);% 打孔
p2 = p2(2:2:end);
end

% function [message, p1, p2] = turbo(u,interleaver_seq)
% % turbo码编码器
% code = recursive_conv(u);
% message = code(:, 1);%信息位
% 
% p1 = code(:, 2);% p1
% 
% p2 = recursive_conv(interleaver(u,interleaver_seq));% p2
% p2 = recursive_conv()
% p2 = p2(:,2);
% 
% p1 = p1(1:2:end);% 打孔
% p2 = p2(2:2:end);
% end