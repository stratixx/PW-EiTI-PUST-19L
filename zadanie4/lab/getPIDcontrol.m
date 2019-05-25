function [u] = getPIDcontrol(settings, e, e1, e2, u1)
%getPIDcontrol wyznaczenie nowego sterowania regulatora PID
%Typowy spos�b u�ycia:
%   getPIDcontrol(settings(1), e(k), e(k-1), e(k-2), u(k-1));
%Wymagane argumenty:
%   settings - struktura zawieraj�ca:
%       * Tp - okres pr�bkowania w sekundach
%       * r0 - r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
%       * r1 - r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
%       * r2 - r2 = Kr*Td/Tp;
%   e - bie��cy uchyb regualcji
%   e1 - poprzedni uchyb regulacji
%   e2 - uchyb regualcji sprzed dw�ch okres�w
%   u1 - poprzednie sterowanie

%sygna� sterujcy regulatora PID
u = settings.r2*e2 + settings.r1*e1 + settings.r0*e+u1;

end

