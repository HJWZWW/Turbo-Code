function L = turbo_decoder(trellis, I_max, R_u, R_1, R_2)
% turbo译码器
length = size(R_u,2);
E2 = zeros(1, length);
for l = 1:I_max
    A1 = de_interleaver(E2);
    L1_temp = log_BCJR(trellis, A1, [R_u;R_1]');
    L1 = L1_temp(:,1);
    L1 = L1';
    E1 = L1 - R_u - A1;
    A2 = interleaver(E1);
    ITL_R_u = interleaver(R_u);
    L2_temp = log_BCJR(trellis, A2, [ITL_R_u;R_2]');
    L2 = L2_temp(:,1);
    L2 = L2';
    E2 = L2 - ITL_R_u - A2;
end
L = de_interleaver(L2);
end

% function L = turbo_decoder(trellis, interleaver_seq, I_max, R_u, R_1, R_2)
% % turbo译码器
% length = size(R_u,2);
% E2 = zeros(1, length);
% for l = 1:I_max
%     A1 = de_interleaver(E2, interleaver_seq);
%     L1_temp = log_BCJR(trellis, A1, [R_u;R_1]');
%     L1 = L1_temp(:,1);
%     L1 = L1';
%     E1 = L1 - R_u - A1;
%     A2 = interleaver(E1, interleaver_seq);
%     ITL_R_u = interleaver(R_u,interleaver_seq);
%     L2_temp = log_BCJR(trellis, A2, [ITL_R_u;R_2]');
%     L2 = L2_temp(:,1);
%     L2 = L2';
%     E2 = L2 - ITL_R_u - A2;
% end
% L = de_interleaver(L2,interleaver_seq);
% end