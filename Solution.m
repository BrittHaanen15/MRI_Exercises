 I=20000; %time steps to simulate
 dt = 1e-11; % s per timestep
 gamma=2.7e8;
 B1 = 0.1; %T
 B0 = 1.5; %T
 omega_a = B1*gamma; %strength of B1 field
 omega0 = B0*gamma;
 %strength of B0 field
 factor = 1.2;
 omega1 = omega0*factor;

 omegaR = omega0;
 
 M(:,1) = [0 0 1];
 %Factor for altering the RF
 %RF frequency, mathcing the Larmor
 %rotating frame-of-reference
 %Initialize M at time t=1
 for i=1:I
 B(1)= B1*cos((omega1-omegaR)*(i*dt));
 B(2)=-B1*sin((omega1-omegaR)*(i*dt));
 B(3)= B0-omegaR/gamma;
 dMdT(:,i) = gamma * cross(M(:,i),B)*dt;
 M(:,i+1) = M(:,i)+dMdT(:,i);
 end
