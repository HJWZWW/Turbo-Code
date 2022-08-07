clear
% interleaver_seq = [3, 7, 6, 2, 5, 10, 1, 8, 9, 4]; 
times = 0;
error = 0;
while 1
    times = times + 1;
    EbNo = 2.5;
    I_max = 2;
    
    % input_code = [1 1 1 0 0 0 1 1 1 0];
    N = 1024;
    input_code = randi(2,1,N) - 1;
    % group = ceil(length(input_code)/length(interleaver_seq));
    group = ceil(length(input_code))/1024;
    input_code = [input_code, zeros(1, 1024 - mod(length(input_code), 1024))];
    [message, u1, u2] = turbo(input_code);
    
    
    %% BPSK调制
        
    % 转换为双极性序列c_bi
    k = find(~message);
    message_bi = message;
    message_bi(k) = -1;
    
    k = find(~u1);
    u1_bi = u1;
    u1_bi(k) = -1;
    
    k = find(~u2);
    u2_bi = u2;
    u2_bi(k) = -1;
    
    %% AWGN信道
    % AWGN_Channel = comm.AWGNChannel('NoiseMethod','Variance','VarianceSource','Input port');
    EsNo = EbNo - 3;
    AWGN_Channel = comm.AWGNChannel('EbNo',EsNo);
    y_message = AWGN_Channel(message_bi);
    y_u1 = AWGN_Channel(u1_bi);
    y_u2 = AWGN_Channel(u2_bi);
    % plot(t, out_signal);
    
    %% BPSK解调
    for i = 1:length(y_message)
        if y_message(i) > 0
            y_message(i) = 1;
        else
            y_message(i) = 0;
        end
    end
    
    for i = 1:length(y_u1)
        if y_u1(i) > 0
            y_u1(i) = 1;
        else
            y_u1(i) = 0;
        end
    end
    
    for i = 1:length(y_u2)
        if y_u2(i) > 0
            y_u2(i) = 1;
        else
            y_u2(i) = 0;
        end
    end
    
%     modu_error_num=sum([xor(y_message, message)', xor(y_u1, u1)', xor(y_u2, u2)'])
%     modu_error_ratio=modu_error_num/(length(message)+length(u1)+length(u2))
    
    
    %%
    var = 1/2*10^(-EsNo/10);
    R_u = get_R(y_message, var);
    R_1_temp = get_R(y_u1, var);
    R_2_temp = get_R(y_u2, var);
    
    R_u = R_u';
    R_1(1:2:length(R_u)) = R_1_temp;
    R_1(2:2:length(R_u)) = 0;
    R_2(1:2:length(R_u)) = 0;
    R_2(2:2:length(R_u)) = R_2_temp;
    
    
    trellis = get_trellis();
    L = turbo_decoder(trellis, I_max, R_u, R_1, R_2);
    
    final_result_temp = 1/2*(-sign(L)+1);
    final_result = final_result_temp(1:length(input_code));

    error = error + sum(xor(input_code, final_result))
    if error > 20000
         break;
    end

end
times
error_ratio = error/(length(final_result)*times)
