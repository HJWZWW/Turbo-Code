function [outputArg] = max_star(a, b)
% max*函数
e = exp(1);
% outputArg = log(e.^a + e.^b);
% outputArg = max(a, b) + round(log(1 + e^(-abs(a-b))),2);
outputArg = max(a, b);
end