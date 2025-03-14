t = 0:0.01:10000;

%First curve
A = 1 - exp(-t/300);
B = 1 - exp(-t/1300);

%Plot
figure
plot(t,A)
hold on
plot(t,B)
title('T1 relaxation of tissues A and B')
xlabel('t')
ylabel('M_z')

%Find difference
[biggest_diff, loc] = max(abs(A-B));
biggest_diff_time = t(loc);

%Indicate on graph
plot([biggest_diff_time, biggest_diff_time], [A(loc), B(loc)])
txt = ['Biggest difference at t=', num2str(biggest_diff_time), ' ms'];
text(biggest_diff_time, max(B)/2, txt)
legend('A','B','Difference')

