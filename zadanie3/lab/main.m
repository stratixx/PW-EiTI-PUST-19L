% wybor symulacja czy obiekt rzeczywisty
% 'simulation' lub 'real'
mode = 'simulation';


if( isequal(regulator, 'real') )  
    addpath ('F:\SerialCommunication') ; % add a path
    initSerialControl COM5 % initialise com port
end
% wybor trybu pracy
% setpoint, stepsU, stepsYzad
action = 'stepsYzad';
% wybor regulatora
% none, PID_linear, DMC_linear, PID_fuzzy, DMC_fuzzy
regulator = 'PID_fuzzy';

% parametry skryptu
kk = 2500;
Tp = 1; % okres probkowania
T1 = 39.4; % temperatura punktu pracy
G1 = 32;   % sterowanie punktu pracy
y = ones(1,kk)*T1; % wektor wyjsc obiektu
yzad = ones(1,kk)*T1; % wektor wartosc zadanych
e = zeros(1,kk); % wektor uchybow regulacji
u = ones(1,kk)*G1; % wektor wejsc (sterowan) obiektu
offset = 400;

%ograniczenia wartosci sterowania
if( isequal(regulator, 'real') )  
    umax = 100;
    umin = 0;
else
    umax = 1;
    umin = -1;
end

% inicjalizacja parametrow regulatorow

settings = []; % tablica struktur ustawien regulatorow

% regulacja z uzyciem regulatora PID linear
if( isequal(regulator, 'PID_linear') )  
    %nastawy klasycznego regulatora PID
    Kr = 3.7;
    Ti = 60.5;
    Td = 0.0;
    settings(1).N = 1;
    settings(1).Tp = Tp;
    settings(1).r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
    settings(1).r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
    settings(1).r2 = Kr*Td/Tp;
    settings(1).u1 = G1;
% regulacja z uzyciem regulatora DMC linear
elseif( isequal(regulator, 'DMC_linear') )
	%nastawy klasyczengo regulatora DMC
	load('s.mat')
	D = length(s); % horyzont dynamiki
	N=200;
	Nu=10;
	lambda = 1;
	run('DMC_init.m');
	n=1;
	settings(n).lambda = lambda;
	settings(n).N = N;
	settings(n).Nu = Nu;
	settings(n).D = D;
	settings(1).Mp = Mp;
	settings(1).K = K;
	settings(1).deltaUp = deltaUp;
	
% regulacja z uzyciem regulatora PID fuzzy
elseif( isequal(regulator, 'PID_fuzzy') )   
    %nastawy regulatorow PID
    Kr = [ 4.2  6.5     8.35];  % P
    Ti = [ 67.8 83.7    90.4];  % I
    Td = [ 0.0  0.0     0.3 ];  % D
    
    fuzzyN = length(Kr);
    settings(fuzzyN).N = fuzzyN;
    for n=1:fuzzyN
        settings(n).Tp = Tp;
        settings(n).r0 = Kr(n)*(1+Tp/(2*Ti(n))+Td(n)/Tp);
        settings(n).r1 = Kr(n)*(Tp/(2*Ti(n))-2*Td(n)/Tp-1);
        settings(n).r2 = Kr(n)*Td(n)/Tp;
        settings(n).u1 = G1;
    end
    
% regulacja z uzyciem regulatora DMC fuzzy
elseif( isequal(regulator, 'DMC_fuzzy') )
    fuzzyN = 3;
	%nastawy regulatora DMC
	N=200;
	Nu=10;
	
	lambdaVect = [1 1 1];
	for n=1:length(lambdaVect)
		lambda = lambdaVect(n);
        %wczytanie wektora s danego regulatora lokalnego
		load(strcat('s',num2str(n),'.mat'));
		D = length(s); % horyzont dynamiki
        N = D;
        Nu = N;
		run('DMC_init.m');
			
		settings(n).lambda = lambda;
		settings(n).N = N;
		settings(n).Nu = Nu;
		settings(n).D = D;
		settings(n).Mp = Mp;
		settings(n).K = K;
		settings(n).deltaUp = deltaUp;
        settings(n).u1 = G1;
	end
	
% sterowanie bez uzycia regulatora
elseif( isequal(regulator, 'none') )
else
    error('NO VALID REGULATOR SELECTED');
end

% przesuniecie startu symulacji
k = offset;

if( isequal(regulator, 'real') )  
    % ustalenie sterowania wentylatora W1
    sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(end) , 0]) ;
end

while k<=kk

    % obtaining measurements
    if( isequal(regulator, 'real') )  
        measurements = readMeasurements (1:7) ; % read measurements    
        y(k)=measurements(1); % powiekszamy wektor y o element Y
    else
        y(k)=symulacja_obiektu7y(u(k-5),u(k-6),y(k-1),y(k-2));
    end
    
    % podazanie do setpoint
    if( isequal(action, 'setpoint') )
        %disp('setpoint')
        yzad(k) = T1;
        u(k) = G1;
    % skoki sterowania
    elseif( isequal(action, 'stepsU') )
        %disp('stepsU')
        if( k<=300 )        u(k) = 20; yzad(k) = u(k);
        elseif( k<=600 )    u(k) = 30; yzad(k) = u(k);
        elseif( k<=900 )    u(k) = G1; yzad(k) = u(k);
        elseif( k<=1200 )   u(k) = 40; yzad(k) = u(k);
        elseif( k<=1500 )   u(k) = 50; yzad(k) = u(k);
        elseif( k<=1800 )   u(k) = 60; yzad(k) = u(k);
        elseif( k<=2100 )   u(k) = 70; yzad(k) = u(k);
        else                u(k) = 80; yzad(k) = u(k);
        end
    % skoki wartosci zadanej z regulatorem
    elseif( isequal(action, 'stepsYzad') )
        %disp('stepsYzad')
        if( k<=offset+350 )       yzad(k) = T1;
        elseif( k<=offset+700 )   yzad(k) = T1 + 5;
        elseif( k<=offset+1050 )  yzad(k) = T1 + 15;
        else                      yzad(k) = T1;
        end                
    else
        error('NO VALID ACTION SELECTED');
    end
    
    % biezacy uchyb regulacji
    e(k) = yzad(k) - y(k);
    
    % regulacja z uzyciem regulatora PID linear
    if( isequal(regulator, 'PID_linear') )
        %disp('pid_linear')
        %wyznaczenie nowej wartosci sterowania
        u(k) = getPIDcontrol(settings(1), e(k), e(k-1), e(k-2), u(k-1));
        %nalozenie ograniczen sterowania
        if( u(k)>umax ) 
            u(k) = umax;
        elseif( u(k)<umin )
            u(k) = umin;
        end
        %regulator moze uzyc poprzedniej wartosci sterowania
        settings(1).u1 = u(k);
        
    % regulacja z uzyciem regulatora DMC linear
    elseif( isequal(regulator, 'DMC_linear') )
        %disp('DMC_linear')
		settings(1).u1 = u(k-1);
		u(k) = getDMCcontrol(settings(1), y, k, yzad);
        %nalozenie ograniczen sterowania
        if( u(k)>umax ) 
            u(k) = umax;
        elseif( u(k)<umin )
            u(k) = umin;
        end
		settings(1).deltaUp(k) = u(k)-u(k-1);
        
    % regulacja z uzyciem regulatora PID fuzzy
    elseif( isequal(regulator, 'PID_fuzzy') )
        u_ = zeros(1, fuzzyN);
        for n=1:fuzzyN
            %wyznaczenie nowej wartosci sterowania od regulatora
            u_(n) = getPIDcontrol(settings(n), e(k), e(k-1), e(k-2), settings(n).u1);
            %nalozenie ograniczen sterowania
            if( u_(n)>umax ) 
                u_(n) = umax;
            elseif( u_(n)<umin )
                u_(n) = umin;
            end
            %regulator moze uzyc poprzedniej wartosci sterowania
            settings(n).u1 = u_(n);
            
            %funkcja wagi regulatora  
            w = [];
            if( isequal(mode, 'real') )
                w = fun_przyn_lab(y(k));
                w = w(n);
            else
                


            end
            w
            u_(n) = u_(n) * w;
            
        end
        u_
        % wyznaczenie sterowania rozmytego
        u(k) = sum(u_);
    % regulacja z uzyciem regulatora DMC fuzzy
    elseif( isequal(regulator, 'DMC_fuzzy') )
        u_ = zeros(1, fuzzyN);
        for n=1:fuzzyN
            %wyznaczenie nowej wartosci sterowania od regulatora
			u_(n) = getDMCcontrol(settings(1), y, k, yzad);
            %nalozenie ograniczen sterowania
            if( u_(n)>umax ) 
                u_(n) = umax;
            elseif( u_(n)<umin )
                u_(n) = umin;
            end
            %regulator moze uzyc poprzedniej wartosci sterowania
			
			settings(n).deltaUp(k) = u_(n)-settings(n).u1;
            settings(n).u1 = u_(n);
            
            %funkcja wagi regulatora  
            w = [];
            if( isequal(mode, 'real') )
                w = fun_przyn_lab(y(k));
                w = w(n);
            else
                


            end
            u_(n) = u_(n) * w
        end
        % wyznaczenie sterowania rozmytego
        u(k) = sum(u_);
    % sterowanie bez uzycia regulatora
    elseif( isequal(regulator, 'none') )
        
    else
        error('NO VALID REGULATOR SELECTED');
    end
    
    % sending new values of control signals
    if( isequal(mode, 'real') )    
        sendNonlinearControls(u(k));
    end
    
    figure(1);
    clf(1);
    hold on;
    plot(y(offset:k)); % wyswietlamy y w czasie
    plot(yzad(offset:k)); % wyswietlamy yzad w czasie
    title('y y_z_a_d');
    grid on;
    xlabel('time');
    ylabel('value');
    xlim([1 (ceil((k-1+1)/100)*100)]);
    %legend('y')
    
    figure(2); 
    clf(2);
    hold on;
    plot(u(offset:k)); % wyswietlamy u w czasie
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
    xlim([1 (ceil((k-1+1)/100)*100)]);
    %legend('u')
    
    drawnow
    
    
    %% synchronising with the control process
    if( isequal(mode, 'real') )
        waitForNewIteration () ; % wait for new iteration
    end
    k=k+1;
end
