
addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port

% wybór trybu pracy
% setpoint, stepsU, stepsYzad
action = 'stepsYzad';
% wybór regulatora
% none, PID_linear, DMC_linear, PID_fuzzy, DMC_fuzzy
regulator = 'none';

% parametry skryptu
kk = 2000;
Tp = 1; % czas z jakim probkuje regulator
T1 = 8;%35.4; % temperatura punktu pracy
G1 = 32;   % sterowanie punktu pracy
y = ones(1,kk)*T1+20; % wektor wyjsc obiektu
yzad = ones(1,kk)*T1; % wektor wartosc zadanych
e = yzad-y; % wektor uchybów regulacji
u = ones(1,kk)*G1; % wektor wejsc (sterowan) obiektu
offset = 3;

umax = 100;
umin = 0;

% inicjalizacja parametrów regulatorów

settings = []; % tablica struktur ustawie? regulatorów

% regulacja z u?yciem regulatora PID linear
if( isequal(regulator, 'PID_linear') )    
    Kr = 5;
    Ti = 20.5;
    Td = 0.00007;
    settings(1).N = 1;
    settings(1).Tp = Tp;
    settings(1).r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
    settings(1).r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
    settings(1).r2 = Kr*Td/Tp;
    settings(1).u1 = G1;
% regulacja z u?yciem regulatora DMC linear
elseif( isequal(regulator, 'DMC_linear') )
    
% regulacja z u?yciem regulatora PID fuzzy
elseif( isequal(regulator, 'PID_fuzzy') )   
    %nastawy regulatorów DMC
    Kr = [ 5  10       ];  % P
    Ti = [ 20 40      ];  % I
    Td = [ 0.00007  0.01       ];  % D
    Y0 = [ T1-5 T1+5    ];  % punkt pracy
    
    fuzzyN = length(Kr);
    settings(fuzzyN).N = fuzzyN;
    for n=1:fuzzyN
        settings(n).N = n;
        settings(n).Y0 = Y0;
        settings(n).Tp = Tp;
        settings(n).r0 = Kr(n)*(1+Tp/(2*Ti(n))+Td(n)/Tp);
        settings(n).r1 = Kr(n)*(Tp/(2*Ti(n))-2*Td(n)/Tp-1);
        settings(n).r2 = Kr(n)*Td(n)/Tp;
        settings(n).u1 = G1;
    end
    
% regulacja z u?yciem regulatora DMC fuzzy
elseif( isequal(regulator, 'DMC_fuzzy') )
    
% regulacja bez u?ycia regulatora
elseif( isequal(regulator, 'none') )
else
    error('NO VALID REGULATOR SELECTED');
end

k = offset;
 %% sending new values of control signals
sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(end) , 0]) ;

while k<=kk
 
%% obtaining measurements
measurements = readMeasurements (1:7) ; % read measurements
    
    y(end)=measurements(1); % powiekszamy wektor y o element Y
	y(k) = 0.6*y(k-1) + 0.1*u(k-1);
    
    % pod??anie do setpoint
    if( isequal(action, 'setpoint') )
        yzad(k) = T1;
        u(k) = G1;
    % skoki sterowania
%     elseif( isequal(action, 'stepsU') )
%         if( k<=30 )        u(k) = 20; yzad(k) = u(k);
%         elseif( k<=60 )    u(k) = 30; yzad(k) = u(k);
%         elseif( k<=90 )    u(k) = G1; yzad(k) = u(k);
%         elseif( k<=120 )   u(k) = 40; yzad(k) = u(k);
%         elseif( k<=150 )   u(k) = 50; yzad(k) = u(k);
%         elseif( k<=180 )   u(k) = 60; yzad(k) = u(k);
%         elseif( k<=210 )   u(k) = 70; yzad(k) = u(k);
%         else                u(k) = 80; yzad(k) = u(k);
%         end
%     % skoki warto?ci zadanej z regulatorem
%     elseif( isequal(action, 'stepsYzad') )
%         if( k<=50 )        yzad(k) = T1;
%         elseif( k<=100 )   yzad(k) = T1 + 5;
%         elseif( k<=150 )   yzad(k) = T1 + 15;
%         else                yzad(k) = T1;
%         end                
%     else
%         error('NO VALID ACTION SELECTED');
%     end
%     
%     % biez?cy uchyb regulacji
%     e(k) = yzad(k) - y(k);
%     
    % regulacja z u?yciem regulatora PID linear
    if( isequal(regulator, 'PID_linear') )
        %wyznaczenie nowej warto?ci sterowania
        u(k) = getPIDcontrol(settings(1), e(k), e(k-1), e(k-2), u(k-1));
        %na?o?enie ogranicze? sterowania
        if( u(k)>umax ) 
            u(k) = umax;
        elseif( u(k)<umin )
            u(k) = umin;
        end
        %regulator mo?e u?y? poprzedniej warto?ci sterowania
        settings(1).u1 = u(k);
        
    % regulacja z u?yciem regulatora DMC linear
    elseif( isequal(regulator, 'DMC_linear') )
        error('DMC_linear not implemented');
    % regulacja z u?yciem regulatora PID fuzzy
    elseif( isequal(regulator, 'PID_fuzzy') )
        u_ = zeros(1, fuzzyN);
        for n=1:fuzzyN
            %wyznaczenie nowej warto?ci sterowania od regulatora
            u_(n) = getPIDcontrol(settings(n), e(k), e(k-1), e(k-2), settings(n).u1);
            %na?o?enie ogranicze? sterowania
            if( u_(n)>umax ) 
                u_(n) = umax;
            elseif( u_(n)<umin )
                u_(n) = umin;
            end
            %regulator mo?e u?y? poprzedniej warto?ci sterowania
            settings(n).u1 = u_(n);
            
            %funkcja wagi regulatora
            u_(n) = u_(n) / fuzzyN;
        end
        % wyznaczenie sterowania rozmytego
        u(k) = sum(u_);
    % regulacja z u?yciem regulatora DMC fuzzy
    elseif( isequal(regulator, 'DMC_fuzzy') )
        error('DMC_fuzzy not implemented');
    % regulacja bez u?ycia regulatora
    elseif( isequal(regulator, 'none') )
    else
        error('NO VALID REGULATOR SELECTED');
    end
    
    % przed?u?enie wektorów w przypadku d?ugiego pomiaru
    if(k==kk)
        y = [ y ones(1, 100)*y(1) ];
        yzad = [ yzad ones(1, 100)*yzad(1) ];
        e = [ e ones(1, 100)*e(1) ];
        u = [ u ones(1, 100)*u(1) ];
        kk = kk + 100;
    end
    
     %% sending new values of control signals
    sendNonlinearControls(u(k));
    
    figure(1);
    clf(1);
    hold on;
    plot(y(offset:k)); % wyswietlamy y w czasie
    plot(yzad(offset:k)); % wyswietlamy yzad w czasie
    title('y y_z_a_d');
    grid on;
    xlabel('time');
    ylabel('value');
    xlim([offset (ceil((k-offset+1)/100)*100)]);
    %legend('y')
    
    figure(2); 
    clf(2);
    hold on;
    plot(u(offset:k)); % wyswietlamy u w czasie
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
    xlim([offset (ceil((k-offset+1)/100)*100)]);
    %legend('u')
    
    drawnow
    
    
    %% synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
    pause(0.05);
    k=k+1;
end
