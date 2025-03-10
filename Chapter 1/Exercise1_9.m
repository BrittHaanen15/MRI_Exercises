%Set constants
B0 = 1.5; %T
B1 = 0.1; %T
gamma = 2.7e-8;
rf = gamma*B0;
rot = 0;
Tsteps = 20000;
dt = 1e-11;

 M(:,1) = [0 0 1];

 for i=1:Tsteps
 B(1)= B1*cos((rf-rot)*(i*dt));
 B(2)=-B1*sin((rf-rot)*(i*dt));
 B(3)= B0-rot/gamma;
 dMdT(:,i) = gamma * cross(M(:,i),B)*dt;
 M(:,i+1) = M(:,i)+dMdT(:,i);
 end

figure
plot(M(1,:))

%Can't get it to work :( don't see why
    