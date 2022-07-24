function output_code = de_interleaver(input_code, interleaver_seq)
% 随机1024-解交织器
state = 4831;
group = length(input_code)/1024;
output_code = zeros(1, group*1024); % 预设output_code为全零序列

for i = 1:group
    input_sub_code = input_code((i-1)*1024+1:i*1024);
    output_sub_code = randdeintrlv(input_sub_code, state);
    output_code((i-1)*1024+1:i*1024) = output_sub_code;
end
end

% 以下为给定交织序列的短解交织器

% function output_code = de_interleaver(input_code, interleaver_seq)
% % 解交织器
% group = length(input_code)/length(interleaver_seq);
% output_code = zeros(1, group*length(interleaver_seq)); % 预设output_code为全零序列
% 
% for i = 1:length(interleaver_seq)
%     de_interleaver_seq(interleaver_seq(i)) = i;
% end
% 
% for i = 1:group
%     input_sub_code = input_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq));
%     for j = 1:length(interleaver_seq)
% 
%         output_sub_code(j) = input_sub_code(de_interleaver_seq(j));
%     end
%     output_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq)) = output_sub_code;
% end
% end