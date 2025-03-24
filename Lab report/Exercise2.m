path = uigetdir('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab','Select folder');
files = dir(path);
cd(path);
names = {files.name}; %extracts file names
names = names(1, 3:end); %creates list of names

%set locations of ROIs --> found manually using impixelinfo
%TI locations
% locs = [114, 114;
%         143, 72;
%         156, 144;
%         85, 156;
%         72,84];

%FA locations
locs = [130, 130;
        163, 86;
        176, 162;
        98, 176;
        85, 97];

%Read in each image and extract info
Data = zeros(size(locs,1),size(names,2)); %one row per circle, each column is a TI time
TItimes = zeros(1,size(names,2));
Angles = zeros(1,size(names,2));

for p = 1:size(names,2)
    info = dicominfo(names{p},'UseDictionaryVR',true); %reads file info for each name
    
    %comment/uncomment the relevant one:
    % %extract inversion time
    % TItimes(1,p) = info.InversionTime;

    %extract flip angle
    Angles(1,p) = info.FlipAngle;

    %Read in image
    im = dicomread(names{p});
    % figure
    % imshow(im,[])

    for q = 1:size(locs,1)
        ROI = drawcircle('Center', locs(q,:), 'Radius', 10);
        mask = createMask(ROI, im);
        Data(q,p) = mean(im(mask));
    end
    
end

%Fix data sorting
% [TItimes, I] = sort(TItimes);
[Angles, I] = sort(Angles);
for i = 1:size(Data,1)
    line = Data(i,:);
    Data(i,:) = line(I); 
end

%Plot figure
figure
%comment/uncomment relevant one:
% plot(TItimes, Data);
plot(Angles, Data)
legend('ROI 1', 'ROI 2', 'ROI 3', 'ROI 4', 'ROI 5');
% title('Signal intensity versus Inversion Time')
title('Signal intensity versus flip angle')
% xlabel('TI (ms)')
xlabel('Angle (deg)')
ylabel('Mean signal in ROI')
