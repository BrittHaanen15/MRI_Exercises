%Generate time interval: -0.5 s to 0.5 s in 1e6 steps
Rate = 1e6;
T = 1/Rate;
t = -0.5:T:0.5;

%Generate sinc pulse
f = 3000;
s = (sin(2*pi*f.*t))./(2*pi*f.*t);
%Force signal to be one at t=0, is NaN because of division by 0
s(isnan(s)) = 1;

curve = 3;

switch curve
    case 1
        %Leave as it is
    case 2
        s(t<-0.004) = 0;
        s(t>0.004) = 0;
    case 3
        s(t<-0.001) = 0;
        s(t>0.001) = 0;
end

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