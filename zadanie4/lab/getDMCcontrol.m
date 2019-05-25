function [u] = getDMCcontrol(settings, y, k, yzad)
%getDMCcontrol wyznaczenie nowego sterowania regulatora DMC
%Typowy sposób u¿ycia:
%   getDMCcontrol(settings(1), y, k, yzad, u(k-1));
%Wymagane argumenty:
%   settings - struktura zawieraj¹ca:


%sygna³ sterujcy regulatora DMC      
		
		
        yo = y(k)*ones(settings.D,1)+settings.Mp*flip(settings.deltaUp((k-settings.D+1):(k-1)));
        %przysz3e sterowania
        deltau = settings.K*( (yzad(k)*ones(1,settings.D))'-yo);
        %bie?1ca zmiana sterowania
        settings.deltaUp(k) = deltau(1);
        %sygna3 sterujcy regulatora DMC       
        u = settings.u1+deltau(1);

		
end

