%Read in image
im = imread('brain.jpg');
figure
imshow(im)
title('Original image')

%Fourier transform
FT = fftshift(fft2(im));
figure
imagesc(log(abs(FT)))
title('Log of k-space of Image')
xlabel('k_x')
ylabel('k_y')

%Angle
figure
imagesc(angle(FT))
title('Angle of k-space of Image')
xlabel('k_x')
ylabel('k_y')

%Plot some line profiles
lp1 = abs(FT(1,:));
lp2 = abs(FT(128,:));
%lp3 = abs(FT(256,:));
lp4 = abs(FT(384,:));
lp5 = abs(FT(512,:));
figure
plot(lp1)
hold on
plot(lp2)
%plot(lp3)
plot(lp4)
plot(lp5)
xlabel('k_x')
ylabel('Intensity')
legend('Line 1', 'Line 128', 'Line 384', 'Line 512')
