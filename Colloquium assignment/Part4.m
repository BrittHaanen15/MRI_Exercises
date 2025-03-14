%Generate image space with circle
R = 100;
I = ones(64);
[x,y] = meshgrid(1:64);
I((x - 32).^2 + (y - 32).^2 < R) = 0;

%Generate magnetic field
B = ones(64);
D = 0.00001;

for i = 1:numel(B)
    Z = ((2*(x(i)-1))/64) - 1;
    X = ((2*(y(i)-1))/64) - 1;
    delta_B = D*(R^2)*((Z^2 - X^2)/((Z^2 + X^2)^2));
    B(i) = B(i) + delta_B;
end
B((x - 32).^2 + (y - 32).^2 < R) = 0;

%Compute K space
%Generate kx, ky, M
[kx, ky] = meshgrid(-31:32);
M_xshift = zeros(64);

%Calculate k space
for i = 1:numel(kx)
    for j = 1:numel(I)
        M_xshift(i) = M_xshift(i) + I(j)*(exp((-2*pi*1i*(x(j)*kx(i) + y(j)*ky(i)))/64))*(exp((-2*pi*1i*B(j)*kx(i))/64));
    end
end

%Display result in 2D
figure
imagesc(abs(M_xshift))
xlabel('k_x')
ylabel('k_y')
title('Manual k-space, k_x susceptibility, 2D view')

%Calculate difference with original k-space
FTI = fftshift(fft2(I));
Diff = M_xshift - FTI;

%Display difference
figure
imagesc(abs(Diff))
xlabel('k_x')
ylabel('k_y')
title('Difference in k-space, k_x susceptibility, 2D view')

%Inverse FT to revert to image
M_inv = ifft2(M_xshift);

%Plot image from top
figure
surf(abs(M_inv))
xlabel('x')
ylabel('y')
title('Image from reverse FT, k_x susceptibility, 2D view')
view(0,90)

%Calculate difference with original image
Im_diff = I - abs(M_inv);

%Show difference
figure
surf(Im_diff)
xlabel('x')
ylabel('y')
title('Image difference, k_x susceptibility, 2D view')
view(0,90)

%Do the same for y shift
M_yshift = zeros(64);
%Calculate k space
for i = 1:numel(kx)
    for j = 1:numel(I)
        M_yshift(i) = M_yshift(i) + I(j)*(exp((-2*pi*1i*(x(j)*kx(i) + y(j)*ky(i)))/64))*(exp((-2*pi*1i*B(j)*ky(i))/64));
    end
end

%Display result in 2D
figure
imagesc(abs(M_yshift))
xlabel('k_x')
ylabel('k_y')
title('Manual k-space, k_y susceptibility, 2D view')

%Calculate difference with original k-space
FTI = fftshift(fft2(I));
Diff = M_yshift - FTI;

%Display difference
figure
imagesc(abs(Diff))
xlabel('k_x')
ylabel('k_y')
title('Difference in k-space, k_y susceptibility, 2D view')

%Inverse FT to revert to image
M_inv = ifft2(M_yshift);

%Plot image from top
figure
surf(abs(M_inv))
xlabel('x')
ylabel('y')
title('Image from reverse FT, k_y susceptibility, 2D view')
view(0,90)

%Calculate difference with original image
Im_diff = I - abs(M_inv);

%Show difference
figure
surf(Im_diff)
xlabel('x')
ylabel('y')
title('Image difference, k_y susceptibility, 2D view')
view(0,90)