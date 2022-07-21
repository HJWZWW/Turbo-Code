function trellis = get_trellis()
% 获取状态图trellis
    trellis = [];
    m = 4;
    for i = 1:2^4
        for j = 1:2^4
            si = dec2bin(i - 1, 4);
            sj = dec2bin(j - 1, 4);
            if ~isequal(si(1:m - 1), sj(2:m))
                trellis(i, j).out= Inf;
            else
                if str2num(sj(1)) == mod(1 + str2num(si(1)) + str2num(si(2)) + str2num(si(3)) +str2num(si(4)), 2);
                    trellis(i,j).in = 1;
                    reg_temp=[str2num(si(1)),str2num(si(2)),str2num(si(3)),str2num(si(4))];
                    p = recursive_conv(1,reg_temp);
                    trellis(i,j).out = {[1,p(1)]};
                else
                    trellis(i,j).in = 0;
                    reg_temp=[str2num(si(1)),str2num(si(2)),str2num(si(3)),str2num(si(4))];
                    p = recursive_conv(0,reg_temp);
                    trellis(i,j).out = {[0,p(1)]};
                end
            end
        end
    end
end