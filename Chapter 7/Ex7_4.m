%Read in image
im = imread('brain.jpg');
imagesc(im)
colormap bone
title('Original image')

%Fourier transform
FT = fftshift(fft2(im));
figure
imagesc(log(abs(FT)))
title('Log of k-space of Original Image')
xlabel('k_x')
ylabel('k_y')

%Modify image
im_modified = im;
exercise = 2;
switch exercise
    case 1
        %prison bars
        for i = 1:5:size(im,2)
            im_modified(:,i) = 1;
        end
    case 2
        %lower resolution
        im_modified = imresize(im_modified,0.25);
end
figure
imagesc(im_modified)
colormap bone
title('Modified image')

%k-space of modified image
FT = fftshift(fft2(im_modified));
figure
imagesc(log(abs(FT)))
title('Log of k-space of Modified Image')
xlabel('k_x')
ylabel('k_y')