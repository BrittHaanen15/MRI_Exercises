%Generate time interval: -0.5 s to 0.5 s in 1e6 steps
Rate = 1e6;
T = 1/Rate;
t = -0.5:T:0.5;

%Generate gaussian pulse
b = 1e8;
s = exp(-b*(t.^2));

%Isolate the -5ms to 5ms values
locs = t>=-0.005 & t<=0.005;

%Plot
figure
plot(t(locs),s(locs))
title('Sinc pulse 3000 Hz')
xlabel('t (s)')
ylabel('s')

%Calculate fourier transform
s_ft = fftshift(fft(s));
N = size(t,2);
fvec =  Rate*((-N/2):(N/2-1))/N;

%Isolate desired values
locs = fvec>=-10000 & fvec<=10000;

%Plot
figure
plot(fvec(locs), abs(s_ft(locs)))
title('Fourier transform of signal')
xlabel('f')
ylabel('A')