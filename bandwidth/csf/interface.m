function interface(loop_max)

if nargin < 1
    loop_max = 1000;
end
global H;
global totallostpacketradio;
global totalmovepacketradio;

time = datestr(now, 'yyyymmdd-HHMMSS');
system(['mkdir ', time]);

flow_avg = 10;
bandwidth_avg = 20;
k = 20;

lost_file = fopen('bandwidth-csf_vs_lost.txt', 'w');
move_file = fopen('bandwidth-csf_vs_move.txt', 'w');
hop_file = fopen('bandwidth-csf_vs_hop.txt', 'w');
fprintf('Please wait');
for bandwidth_avg = 10:20
    csf(flow_avg, bandwidth_avg, k, loop_max);
    lost = sum(totallostpacketradio) / loop_max;
    move = sum(totalmovepacketradio) / loop_max;
    hop = sum(H) / loop_max;
    fprintf(lost_file, '%d %f\n', bandwidth_avg, lost * 100);
    fprintf(move_file, '%d %f\n', bandwidth_avg, move * 100);
    fprintf(hop_file, '%d %f\n', bandwidth_avg, hop);
    fprintf('.');
end
fprintf('\n');

fclose(lost_file);
fclose(move_file);
fclose(hop_file);

system(['move ', 'bandwidth-csf_vs_lost.txt ', time]);
system(['move ', 'bandwidth-csf_vs_move.txt ', time]);
system(['move ', 'bandwidth-csf_vs_hop.txt ', time]);

%system(['copy ', 'plot.gp ', time]);
%cd(time)
%system(['gnuplot plot.gp']);
%cd ..