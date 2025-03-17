t = 0:0.005:1; %ms
w0 = 125*2*pi;
w0_2 = 150*2*pi;

figure
hold on

figure
hold on


for i = 10:20:100
    T2 = i/1000; %s

    M = exp(-1i*w0.*t).*exp(-t/T2) + exp(-1i*w0_2.*t).*exp(-t/T2);
    F = fft(M);

    figure(1)
    plot(t,abs(M))

    figure(2)
    plot(abs(F))
end

figure(1)
title('M as function of time')
xlabel('time (s)')
ylabel('Magnetisation')
legend()

figure(2)
title('Spectral Frequency plot')
xlabel('Frequency')
ylabel('Amplitude')
legend()