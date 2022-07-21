function [c, padding_bit] = recursive_conv(input_code, reg)
% 递归系统卷积码编码器
if(~exist('reg','var'))
    reg = [0, 0, 0, 0];  % 如果未出现该变量，则对寄存器初始化为全0
end

for i = 1:length(input_code)
    output_code(i) = reg(1) + reg(2) + reg(3) + input_code(i);
    output_code(i) = mod(output_code(i), 2);
    reg = [mod(output_code(i) + reg(4), 2), reg(1:3)];
end
for i = 1:4
    padding_bit(i) = reg(1) + reg(2) + reg(3) + reg(4);
    padding_bit(i) = mod(padding_bit(i), 2);
    output_code(length(input_code) + i) = reg(1) + reg(2) + reg(3) + padding_bit(i);
    output_code(length(input_code) + i) = mod(output_code(length(input_code) + i), 2);
    reg = [mod(output_code(length(input_code) + i) + reg(4), 2), reg(1:3)];
end
for i = 1:length(input_code)
    c(i, 1) = input_code(i);
    c(i, 2) = output_code(i);
end
for i = 1:4
    c(i+length(input_code), 1) = padding_bit(i);
    c(i+length(input_code), 2) = output_code(i+length(input_code));

end