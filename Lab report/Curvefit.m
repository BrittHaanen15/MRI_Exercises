t1 = zeros(size(Data,1),1);
for i = 1:size(Data,1)
    %Isolate data
    x = transpose(Angles);
    % x = transpose(TItimes)./1000

    y = transpose(Data(i,:));

    % Define curve
    % fun = @(c, x) (1 - 2.*exp(-x./c));

    fun = @(c,x) c(1).*((sin(x).*(1-exp(-info.RepetitionTime./c(2))))./(1-cos(x).*exp(-info.RepetitionTime./c(2))));
    
    %Perform fit
    c = lsqcurvefit(fun,[1, 1],x,y);
    

    t1(i,1) = c(2);
end