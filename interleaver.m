function output_code = interleaver(input_code)
% 随机1024-交织器
state = 4831;
group = length(input_code)/1024;
output_code = zeros(1, group*1024);% 预设output_code为全零序列
% input_code = [input_code, zeros(1, length(interleaver_seq)-mod(length(input_code), length(interleaver_seq)))]
for i = 1:group
    input_sub_code = input_code((i-1)*1024+1:i*1024);
    output_sub_code = randintrlv(input_sub_code, state);
    output_code((i-1)*1024+1:i*1024) = output_sub_code;
end
end

% 以下为给定交织序列的短交织器

% function output_code = interleaver(input_code, interleaver_seq)
% % 交织器
% group = length(input_code)/length(interleaver_seq);
% output_code = zeros(1, group*length(interleaver_seq)) ;% 预设output_code为全零序列
% % input_code = [input_code, zeros(1, length(interleaver_seq)-mod(length(input_code), length(interleaver_seq)))]
% for i = 1:group
%     input_sub_code = input_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq));
%     for j = 1:length(interleaver_seq)
%         output_sub_code(j) = input_sub_code(interleaver_seq(j));
%     end
%     output_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq)) = output_sub_code;
% end
% end