% %Quantify contrast --> exercise 4b
% centralpoint = [50, 64];
% bgpoint = [86 65];
% 
% 
% %GE result
% 
% %Read in image, select middle slice
% im = niftiread('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab\EPI\GRE-EPI\GRE-EPI.nii');
% im = im(:,:,6);
% figure
% imshow(im,[])
% 
% %Place rois
% ROIc = drawcircle('Center', centralpoint, 'Radius', 5);
% mask = createMask(ROIc, im);
% Sc = mean(im(mask))
% 
% ROIbg = drawcircle('Center', bgpoint, 'Radius', 5);
% mask = createMask(ROIbg, im);
% Sbg = mean(im(mask))
% 
% CGE = (Sc - Sbg)/Sbg
% 
% 
% 
% %GE result
% 
% %Read in image, select middle slice
% im = niftiread('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab\EPI\SE-EPI\SE-EPI.nii');
% im = im(:,:,6);
% figure
% imshow(im,[])
% 
% %Place rois
% ROIc = drawcircle('Center', centralpoint, 'Radius', 5);
% mask = createMask(ROIc, im);
% Sc = mean(im(mask))
% 
% ROIbg = drawcircle('Center', bgpoint, 'Radius', 5);
% mask = createMask(ROIbg, im);
% Sbg = mean(im(mask))
% 
% CSE = (Sc - Sbg)/Sbg


% Analyse the ME-EPI --> exercise 4d
im = niftiread('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab\EPI\ME-EPI\ME-EPI.nii');

%Set ROI places
locs = [45, 50;
    80, 50;
    64, 64;
    45, 85;
    80, 85];

%Set variables
TEtimes = [4.22, 33.81,63.39,92.98,122.6,152.2,181.7,211.3,240.9,270.5];
Data = zeros(size(locs,1),size(TEtimes,2)); %one row per circle, each column is a TE time

for i = 1:size(TEtimes,2)
    I = im(:,:,i);
    % figure
    % imshow(I,[])

    for q = 1:size(locs,1)
        ROI = drawcircle('Center', locs(q,:), 'Radius', 5);
        mask = createMask(ROI, I);
        Data(q,i) = mean(I(mask));
    end

end

%Plot figure
figure
plot(TEtimes, Data)
legend('ROI 1', 'ROI 2', 'ROI 3', 'ROI 4', 'ROI 5');
title('Signal intensity versus Echo Time')
xlabel('TE (ms)')
ylabel('Mean signal in ROI')

%Curve fit to find T2
x = TEtimes;
y = mean(Data,1);
tvec = 0:0.1:max(x);
fun = @(c,x) c(1).*exp(-x./c(2));
c = lsqcurvefit(fun,[1, 1],x,y);
t2 = c(2);

%Plot figure
figure
hold on
scatter(x, y)
plot(tvec, fun(c,tvec))
title('Mean signal as function of TE')
legend('Data', ['Fit T2=' num2str(c(2)) ' ms'])
xlabel('TE (ms)')
ylabel('Mean signal')

