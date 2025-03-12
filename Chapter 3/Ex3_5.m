%Simulate signal
N=500;
t = 1:N; %1 step = 1 ms
t = t./1000;
s = zeros(1,N);
s(100:400) = 1;
s = s.*(sin(2*pi*30*t) + 2*sin(2*pi*50*t));

%Plot
figure
plot(t,s)
xlabel('t')
ylabel('s')
title('RECT function, original')

%Fourier transform
s_ft = fftshift(fft(s));
fvec = 1000*((-N/2):(N/2-1))/N;

%Plot
figure
plot(fvec, abs(s_ft))
xlabel('f')
ylabel('A')
title('Fourier RECT, magnitude')

figure
plot(fvec, abs(s_ft))
hold on
plot(fvec, real(s_ft))
plot(fvec, imag(s_ft))
xlabel('f')
ylabel('A')
title('Fourier RECT, all components')
legend('magnitude', 'real', 'imaginary')