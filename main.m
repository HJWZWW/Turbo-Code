interleaver_seq = [3, 7, 6, 2, 5, 10, 1, 8, 9, 4]; 
input_code = [1 1 1 0 0 0];
group = ceil(length(input_code)/length(interleaver_seq));
input_code = [input_code, zeros(1, length(interleaver_seq)-mod(length(input_code), length(interleaver_seq)))];