%%%%%%%%%%%%%%%% PART 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Generate image space 
I = ones(64);
[x,y] = meshgrid(1:64);

%circle
I((x - 32).^2 + (y - 32).^2 < 100) = 0;

% %point source
% I(32,32) = 0;

% %diagonal line
% for i = 1:size(I,1)
%     I(i,i) = 0;
% end

%Plot image from top
figure
surf(I)
xlabel('x')
ylabel('y')
title('Original image, 2D view')
view(0,90)

%Plot image in 3D
figure
surf(I)
xlabel('x')
ylabel('y')
zlabel('z')
title('Original image, 3D view')


%%%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Take Fourier Transform of image
FTI = fftshift(fft2(I));

%Display result in 2D
figure
imagesc(abs(FTI))
xlabel('k_x')
ylabel('k_y')
title('k-space, 2D view')

%Display result in 3D
figure
mesh(abs(FTI))
xlabel('k_x')
ylabel('k_y')
zlabel('A')
title('k-space, 3D view')
