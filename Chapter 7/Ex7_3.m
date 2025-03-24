%Read in image
im = imread('brain.jpg');
imagesc(im)
colormap bone

%Fourier transform
FT = fftshift(fft2(im));

%Modify k-space
exercise = 6;
switch exercise
    case 1
        %Set half to zero 
        for i = 2:2:size(FT, 1)
           FT(i,:) = 0;
        end
    case 2
        %Delete half
        new_k_space = zeros(size(FT,1)/2, size(FT,2));
        for i = 1:size(new_k_space,1)
            new_k_space(i,:) = FT(i*2,:);
        end
        FT = new_k_space;
    case 3
        %zero-fill the centre
        FT(250:262, 250:262) = 0;
    case 4
        %zero-fill the edges
        FT(1:200,:) = 0;
        FT(312:512,:) = 0;
        FT(:,1:200) = 0;
        FT(:, 312:512) = 0;
    case 5
        %zero-fill left half
        FT(:, 1:256) = 0;
    case 6
        %zero-fill bottom half
        FT(257:512,:) = 0;
end

figure
imagesc(log(abs(FT)))
title('Log of Modified k-space of Image')
xlabel('k_x')
ylabel('k_y')

%Inverse FT to revert to image
M_inv = ifft2(FT);

%Plot image from top
figure
imagesc(abs(M_inv))
colormap bone
xlabel('x')
ylabel('y')
title('Image from modified k-space')



