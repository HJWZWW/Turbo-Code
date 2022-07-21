function [outputArg] = max_star(a, b)
% max*函数
e = exp(1);
outputArg = log(e.^a + e.^b);
end