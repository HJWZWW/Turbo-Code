function output_code = de_interleaver(input_code, interleaver_seq)
% 交织器
for i = 1:length(interleaver_seq)
    de_interleaver_seq(interleaver_seq(i)) = i;
end
for i = 1:length(de_interleaver_seq)
    output_code(i) = input_code(de_interleaver_seq(i));

end
end