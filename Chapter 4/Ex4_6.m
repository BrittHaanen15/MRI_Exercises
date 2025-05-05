%Set constants
M0 = 1;
angle = 180; %in degrees
a = 2*pi*(angle/360); %flip angle
TR = 10; %repetition time
T1 = 1; %T1 relaxation time
E = exp(-TR/T1);

%Set up variables
time = 1:100;
time = time*TR;
M_z = zeros(1,100);
M_y = zeros(1,100);
M_z(1) = M0;

%Model M
for i = 2:100
    %Immediately after pulse
    M_z_plus = M_z(i-1)*cos(a);
    M_y_plus = M_z(i-1)*sin(a);

    %Before next pulse
    M_z(i) = E*M_z_plus + (1-E)*M0;
    M_y(i) = M_y_plus;
end

%plot
figure
plot(time, M_z)
hold on
plot(time, M_y)
title('M_z and M_y as functions of time')
xlabel('t (s)')
ylabel('Magnetisation')
legend('M_z', 'M_y')

