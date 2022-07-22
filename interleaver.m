function output_code = interleaver(input_code, interleaver_seq)
% 交织器
for i = 1:length(interleaver_seq)
    output_code(i) = input_code(interleaver_seq(i))

end
end