%Prepare figure
figure
hold on
col = ['r', 'g', 'b', 'm', 'y'];

t1 = zeros(size(Data,1),1);

for i = 1:size(Data,1)
    %Isolate and scale data

    %FOR TI
    % x = transpose(TItimes)./1000;
    % y = transpose(Data(i,:))./1000;
    % tvec = 1:0.1:max(x);

    %FOR GRE
    x = transpose(Angles);
    x = x.*(pi/180);
    y = transpose(Data(i,:))./1000;

    scatter(x,y,'MarkerFaceColor',col(i))

    % Define curve
    % fun = @(c, x) abs(c(1).*(1 - 2.*exp(-x./c(2)))); %for IR

    fun = @(c, x) c(1).*((sin(x).*(1-exp(-info.RepetitionTime./c(2))))./(1-cos(x).*exp(-info.RepetitionTime./c(2))));
    % % for GRE

    %Perform fit
    c = lsqcurvefit(fun,[1, 1],x,y);
    t1(i,1) = c(2);

    %Plot fitted curve with data
    plot(x, fun(c,x), "Color", col(i))
end

title('GRE data with fitted curves')
ylabel('Signal/1000')
%For IR
% xlabel('Inversion time (s)')
% legend('Data 1', ['Fit 1 T1=' num2str(t1(1)*1000) ' ms'], 'Data 2', ['Fit 2 T1=' num2str(t1(2)*1000) ' ms'], 'Data 3', ['Fit 3 T1=' num2str(t1(3)*1000) ' ms'], 'Data 4', ['Fit 4 T1=' num2str(t1(4)*1000) ' ms'], 'Data 5', ['Fit 5 T1=' num2str(t1(5)*1000) ' ms'])
%For GRE
xlabel('Angle (rad)')
legend('Data 1', ['Fit 1 T1=' num2str(t1(1)) ' ms'], 'Data 2', ['Fit 2 T1=' num2str(t1(2)) ' ms'], 'Data 3', ['Fit 3 T1=' num2str(t1(3)) ' ms'], 'Data 4', ['Fit 4 T1=' num2str(t1(4)) ' ms'], 'Data 5', ['Fit 5 T1=' num2str(t1(5)) ' ms'])