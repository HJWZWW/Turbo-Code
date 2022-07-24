function output_code = interleaver(input_code, interleaver_seq)
% 交织器
group = length(input_code)/length(interleaver_seq);
output_code = zeros(1, group*length(interleaver_seq)) ;% 预设output_code为全零序列
% input_code = [input_code, zeros(1, length(interleaver_seq)-mod(length(input_code), length(interleaver_seq)))]
for i = 1:group
    input_sub_code = input_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq));
    for j = 1:length(interleaver_seq)
        output_sub_code(j) = input_sub_code(interleaver_seq(j));
    end
    output_code((i-1)*length(interleaver_seq)+1:i*length(interleaver_seq)) = output_sub_code;
end
end