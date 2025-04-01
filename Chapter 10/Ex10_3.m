exercise = 4;
switch exercise
    case 1
        T_1 = 900; %ms
        T_2 = 100; %ms
        alpha = 30; %deg
        theta = 0; %deg
    case 2
        T_1 = 900; %ms
        T_2 = 100; %ms
        alpha = 30; %deg
        theta = 45; %deg
    case 3
        T_1 = 900; %ms
        T_2 = 100; %ms
        alpha = 30; %deg
        theta = 90; %deg
    case 4
        T_1 = 900; %ms
        T_2 = 0; %ms
        alpha = 30; %deg
        theta = 0; %deg
end

%Set variables 
TR = 1:250;
TR = TR.*5;
alpha = alpha*(pi/180);
theta = theta*(pi/180);
M_0 = [0; 0; 1];

Mafter = M_0;

Mz = zeros(1, size(TR,2));
Mt = zeros(1, size(TR,2));

for i = 1:size(TR,2)
    t = TR(i);
    E1 = exp(-t/T_1);
    E2 = exp(-t/T_2);

    Mbefore = [E2*cos(theta), E2*sin(theta), 0; -E2*sin(theta), E2*cos(theta), 0; 0, 0, E1]*Mafter + (1-E1)*M_0;

    Mafter = [1, 0, 0; 0, cos(alpha), sin(alpha); 0, -sin(alpha), cos(alpha)]*Mbefore;

    Mz(i) = Mafter(3);

    Mt(i) = sqrt(Mafter(1)^2 + Mafter(2)^2);
end

figure
plot(TR, Mz)
hold on
plot(TR,Mt)
xlabel('time')
ylabel('magnetisation')
legend('longitudinal', 'transverse')
title('Magnetisation as function of time')

