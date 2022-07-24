function L = log_BCJR(trellis,A,R)
% log_BCJR译码器
% A:信源的先验概率 R:信道的转移概率
% trellis:状态图,二维矩阵,只包含两状态是否相连

%% Initialization 初始化
T = length(R);
state_num = size(trellis, 1);
% 为了降低时间复杂度，在译码前先分析一下状态图
trellis_flag = zeros(state_num,state_num); 
for r = 1:state_num
    for s = 1:state_num
         if ~isequal(trellis(r,s).out,Inf)
             trellis_flag(r,s) = 1;
             trellis_in(r,s) = trellis(r,s).in;
             temp = cell2mat(trellis(r,s).out);
             trellis_out(r,s,1) = temp(1);
             trellis_out(r,s,2) = temp(2);
         end
    end
end
Gamma_t = zeros(state_num, state_num, T);% 变量预分配
for t  = 1:T
    for r = 1:state_num
        for s = 1:state_num
            Gamma_t(r,s,t) = -Inf; % Gamma_t也是矩阵,记录状态r->s的对数概率
            % if ~isequal(trellis(r,s).out,Inf)
            if trellis_flag(r,s) == 1
                Gamma_t(r,s,t) = 0;
                if trellis_in(r,s) == 0
                    Gamma_t(r,s,t) = Gamma_t(r,s,t) + log(((exp(1))^A(t))/(1+(exp(1))^A(t)));
                else
                    Gamma_t(r,s,t) = Gamma_t(r,s,t) + log(((exp(1))^(-A(t)))/(1+(exp(1))^(-A(t))));
                end
                for i=1:2 
                    % c_rs = cell2mat(trellis(r,s).out);
                    if trellis_out(r,s,i) == 0
                        Gamma_t(r,s,t) = Gamma_t(r,s,t) + log(((exp(1))^R(t,i))/(1+(exp(1))^R(t,i)));
                    else
                        Gamma_t(r,s,t) = Gamma_t(r,s,t) + log(((exp(1))^(-R(t,i)))/(1+(exp(1))^(-R(t,i))));
                    end
                end
            end
        end
    end
end
%% Forward recursion 前向递归
alpha_t = zeros(state_num, T);% 变量预分配
for t = 1:T
    for i = 1:state_num
        alpha_t(i,t) = -Inf;
    end
end
alpha_t(1,1) = 0;
for t = 2:T
    for r = 1:state_num
        for s = 1:state_num
            alpha_t(s,t) = max_star(alpha_t(s,t), alpha_t(r,t-1)+Gamma_t(r,s,t-1));% 修复bug为:Gamma_t(r,s,t-1)
        end
    end
end
%% Backward recursion 后向递归
beta_t = zeros(state_num, T);
for t = 1:T
    for i = 1:state_num
        beta_t(i,t) = -Inf;
    end
end
%---------------依据是否terminated来决定下面两行
beta_t(1, T) = 0;
% beta_t(:,T) = log(1/size(trellis, 1));
% for t = T - 1:1
for t = (T - 1):-1:1
    for r = 1:state_num
        for s = 1:state_num
%             if r == 1 && t == 1
%                 disp(Gamma_t(r,s,t+1));
%                 disp(beta_t(s,t+1));
%                 disp(beta_t(r,t));
%             end
            beta_t(r,t) = max_star(beta_t(r,t), beta_t(s,t+1) + Gamma_t(r,s,t+1));
%             if r == 1 && t == 1
%                 disp(beta_t(r,t));
%             end
        end
    end
end
%% State transition probabilities
M_t = zeros(state_num,state_num,T);
for t = 1:T
    for r = 1:state_num
        for s = 1:state_num
            M_t(r, s, t) = alpha_t(r, t) + Gamma_t(r, s, t) + beta_t(s, t);
        end
    end
end
%% Bit probabilities
L = zeros(T, 2);
for t = 1:T
    for i=1:2
    L_plus = -Inf;
    L_minus = -Inf;
        for r = 1:state_num
            for s = 1:state_num
                if trellis_flag(r,s) == 1
                    if trellis_out(r,s,i) == 1
                        L_plus = max_star(L_plus, M_t(r, s, t));
                    else
                        L_minus = max_star(L_minus, M_t(r, s, t));
                    end
                end
             end
        end
    L(t,i) = L_minus - L_plus;
    end
end
end

