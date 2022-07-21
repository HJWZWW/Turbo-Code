function R = get_R(y,var)
% 计算接收序列的LLRs
e=exp(1);
R = log(((1/sqrt(2*pi*var))*e.^(-(y.^2)/(2*var))) ./ ((1/sqrt(2*pi*var))*e.^((-(y-1).^2)/(2*var))));
end