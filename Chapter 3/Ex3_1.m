%Simulate signal
N=500;
t = 1:N; %1 step = 1 ms
t = t./1000;
s = sin(2*pi*30*t);

%Plot
figure
plot(t,s)
xlabel('t')
ylabel('s')
title('Simulated signal, original')

%Fourier transform
s_ft = fftshift(fft(s));
fvec = 1000*((-N/2):(N/2-1))/N;

%Plot
figure
plot(fvec, abs(s_ft))
xlabel('f')
ylabel('A')
title('Fourier transformed signal, magnitude')

figure
plot(fvec, abs(s_ft))
hold on
plot(fvec, real(s_ft))
plot(fvec, imag(s_ft))
xlabel('f')
ylabel('A')
title('Fourier transformed signal, all components')
legend('magnitude', 'real', 'imaginary')