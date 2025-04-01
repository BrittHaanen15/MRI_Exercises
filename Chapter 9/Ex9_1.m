%%%Exercise a%%%
%Tissue 1
T_1_tiss1 = 900; %ms
T_2_tiss1 = 50; %ms

%Tissue 2
T_1_tiss2 = 1100; %ms
T_2_tiss2 = 120; %ms

%Set up variables
TR = 0:100:5000;
TE = 0:10:500;

for i = 1:size(TR,2)
    for j = 1:size(TE,2)
        S_tiss1 = (1-exp(-TR(i)./T_1_tiss1)).*exp(-TE(j)./T_2_tiss1);
        S_tiss2 = (1-exp(-TR(i)./T_1_tiss2)).*exp(-TE(j)./T_2_tiss2);
        Data(i,j) = S_tiss1 - S_tiss2;
    end
end

figure
imagesc(TE, TR, Data)
title('Relative signal as function of TR and TE, ex a')
xlabel('TE (ms)')
ylabel('TR (ms)')
colorbar
axisforcolorbar = [min(Data,[],'all'), max(Data,[],'all')];
clim(axisforcolorbar)


%%%Exercise b%%%
%Tissue 1
T_1_tiss1 = 300; %ms
T_2_tiss1 = 50; %ms

%Tissue 2
T_1_tiss2 = 900; %ms
T_2_tiss2 = 70; %ms

%Set up variables
TR = 0:100:5000;
TE = 0:10:500;

for i = 1:size(TR,2)
    for j = 1:size(TE,2)
        S_tiss1 = (1-exp(-TR(i)./T_1_tiss1)).*exp(-TE(j)./T_2_tiss1);
        S_tiss2 = (1-exp(-TR(i)./T_1_tiss2)).*exp(-TE(j)./T_2_tiss2);
        Data(i,j) = S_tiss1 - S_tiss2;
    end
end

figure
imagesc(TE, TR, Data)
title('Relative signal as function of TR and TE, ex b')
xlabel('TE (ms)')
ylabel('TR (ms)')
colorbar
clim(axisforcolorbar)