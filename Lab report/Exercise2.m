path = uigetdir('C:\Users\bhaan\Documents\#Master Degree\MR Theory and Diagnostics\MRI_Exercises\Lab report\FYS4740-lab','Select folder');
files = dir(path);
cd(path);
names = {files.name}; %extracts file names
names = names(1, 3:end); %creates list of names

%set locations of ROIs --> found manually using impixelinfo
% TI locations
locs = [114, 114;
        143, 72;
        156, 144;
        85, 156;
        72,84];

% % %FA locations
% locs = [130, 130;
%         163, 86;
%         176, 162;
%         98, 176;
%         85, 97];

%Read in each image and extract info
Data = zeros(size(locs,1),size(names,2)); %one row per circle, each column is a TI time
TItimes = zeros(1,size(names,2));
Angles = zeros(1,size(names,2));

for p = 1:size(names,2)
    info = dicominfo(names{p},'UseDictionaryVR',true); %reads file info for each name

    %comment/uncomment the relevant one:
    %extract inversion time
    TItimes(1,p) = info.InversionTime;

    % %extract flip angle
    % Angles(1,p) = info.FlipAngle;

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
[TItimes, I] = sort(TItimes);
% [Angles, I] = sort(Angles);
for i = 1:size(Data,1)
    line = Data(i,:);
    Data(i,:) = line(I); 
end

%Plot figure
figure
%comment/uncomment relevant one:
plot(TItimes, Data)
% plot(Angles, Data)
legend('ROI 1', 'ROI 2', 'ROI 3', 'ROI 4', 'ROI 5');
title('Signal intensity versus Inversion Time')
% title('Signal intensity versus flip angle')
xlabel('TI (ms)')
% xlabel('Angle (deg)')
ylabel('Mean signal in ROI')


% %Calculate T1 based on 2 flip angles --> exercise 2d%%%%%%%%%%%%%%%%%
% D = Data;
% 
% %Isolate for the two flip angles
% a = Angles(5)*(pi/180);
% Da = D(:,5);
% 
% b = Angles(6)*(pi/180);
% Db = D(:,6);
% 
% %Ratio
% R = Da./Db;
% 
% %Calculate T1
% betanum = sin(a) - R.*sin(b);
% betaden = sin(a)*cos(b) - R.*sin(b)*cos(a);
% beta = betanum./betaden;
% 
% T1 = -info.RepetitionTime./log(beta);


%Curve fitting --> exercise 2g%%%%%%%%%%%
%Prepare figure
figure
hold on
col = ['r', 'g', 'b', 'm', 'y'];

t1 = zeros(size(Data,1),1);

for i = 1:size(Data,1)
    %Isolate and scale data

    % FOR TI
    x = transpose(TItimes)./1000;
    y = transpose(Data(i,:))./1000;
    tvec = 0:0.01:max(x);

    % %FOR GRE
    % x = transpose(Angles);
    % x = x.*(pi/180);
    % y = transpose(Data(i,:))./1000;
    % tvec = 0:0.01:max(x);

    scatter(x,y,'MarkerFaceColor',col(i))

    % Define curve
    fun = @(c, x) abs(c(1).*(1 - 2.*exp(-x./c(2)))); %for IR

    % fun = @(c, x) c(1).*((sin(x).*(1-exp(-info.RepetitionTime./c(2))))./(1-cos(x).*exp(-info.RepetitionTime./c(2))));
    % % for GRE

    %Perform fit
    c = lsqcurvefit(fun,[1, 1],x,y);
    t1(i,1) = c(2);

    %Plot fitted curve with data
    plot(tvec, fun(c,tvec), "Color", col(i))
end


ylabel('Signal/1000')
%For IR
title('IR data with fitted curves')
xlabel('Inversion time (s)')
legend('Data 1', ['Fit 1 T1=' num2str(t1(1)*1000) ' ms'], 'Data 2', ['Fit 2 T1=' num2str(t1(2)*1000) ' ms'], 'Data 3', ['Fit 3 T1=' num2str(t1(3)*1000) ' ms'], 'Data 4', ['Fit 4 T1=' num2str(t1(4)*1000) ' ms'], 'Data 5', ['Fit 5 T1=' num2str(t1(5)*1000) ' ms'])
%For GRE
% title('GRE data with fitted curves')
% xlabel('Angle (rad)')
% legend('Data 1', ['Fit 1 T1=' num2str(t1(1)) ' ms'], 'Data 2', ['Fit 2 T1=' num2str(t1(2)) ' ms'], 'Data 3', ['Fit 3 T1=' num2str(t1(3)) ' ms'], 'Data 4', ['Fit 4 T1=' num2str(t1(4)) ' ms'], 'Data 5', ['Fit 5 T1=' num2str(t1(5)) ' ms'])

