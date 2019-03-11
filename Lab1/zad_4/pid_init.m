
% parametry PID moje
Kk = 199.33;
Tk = 0.1;
Tv = -0.0001;

% ziegler grocha
%Kk = 35.0;
%Tk = 0.2;
%Tv = -0.050

% ziegler
Kr = 0.6*Kk;
Ti = 0.5*Tk;
Td = 0.12*Tk;

%rêcznie moje
%Kr = 1;
%Ti = 0.45;
%Td = 0;

%recznie Grocha
Kr = 3.5;
Ti = 11.7;
Td = 1.4;

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r2 = Kr*Td/Tp;
