%open folder
path = uigetdir('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab','Select folder');
files = dir(path);
cd(path);
names = {files.name}; %extracts file names
names = names(1, 3:end); %creates list of names

%set locations of ROIs --> found manually using impixelinfo
locs = [131, 136;
        167, 92;
        178, 174;
        95, 184;
        86, 103];

%Prepare variables
Data = zeros(size(locs,1),size(names,2)); %one row per circle, each column is a NSA
NSA = zeros(1,size(names,2));

%Read in each image and extract info
for p = 1:size(names,2)
    %extract NSA
    info = dicominfo(names{p},'UseDictionaryVR',true); %reads file info for each name
    NSA(p) = info.NumberOfAverages;

    %Read in image
    im = dicomread(names{p});
    % figure
    % imshow(im,[])

    for q = 1:size(locs,1)
        ROI = drawcircle('Center', locs(q,:), 'Radius', 10);
        mask = createMask(ROI, im);
        Mean = mean(double(im(mask)));
        Variance = var(double(im(mask)));
        SNR = sqrt(2)*(Mean/Variance);
        Data(q,p) = SNR;
    end
end

%Plot data
figure
hold on
plot(NSA, Data(1:2,:))
plot(NSA, Data(5,:))
legend('ROI 1', 'ROI 2', 'ROI 5');
title('Signal-to-Noise Ratio versus NSA')
xlabel('Number of Averages')
ylabel('SNR')

figure
plot(NSA, Data(3:4,:))
legend('ROI 3', 'ROI 4')
title('Signal-to-Noise Ratio versus NSA')
xlabel('Number of Averages')
ylabel('SNR')

figure
plot(NSA, mean(Data,1))
title('Mean SNR across all ROIs versus NSA')
xlabel('Number of Averages')
ylabel('Mean SNR')

cd('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report')