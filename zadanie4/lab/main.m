% wybor symulacja czy obiekt rzeczywisty
% 'simulation' lub 'real'
mode = 'simulation';


if( isequal(mode, 'real') )  
    %addpath ('F:\SerialCommunication') ; % add a path
    %initSerialControl COM5 % initialise com port
else
    load('zad1/modelReccur/u1y1/model.mat');
    load('zad1/modelReccur/u1y2/model.mat');
    load('zad1/modelReccur/u2y1/model.mat');
    load('zad1/modelReccur/u2y2/model.mat');
end
% wybor trybu pracy
% setpoint, stepsU, stepsYzad
action = 'stepsU';
% wybor regulatora
% none, PID_linear, DMC_linear
regulator = 'none';

% parametry skryptu
kk = 1400;
Tp = 4; % okres probkowania
T1 = 36.5; % temperatura punktu pracy
T2 = 38.6; % temperatura punktu pracy
G1 = 32;   % sterowanie punktu pracy
G2 = 37;   % sterowanie punktu pracy
y1 = ones(1,kk)*T1; % wektor wyjsc obiektu
y2 = ones(1,kk)*T2; % wektor wyjsc obiektu
yzad1 = ones(1,kk)*T1; % wektor wartosc zadanych
yzad2 = ones(1,kk)*T2; % wektor wartosc zadanych
e1 = zeros(1,kk); % wektor uchybow regulacji
e2 = zeros(1,kk); % wektor uchybow regulacji
u1 = ones(1,kk)*G1; % wektor wejsc (sterowan) obiektu
u2 = ones(1,kk)*G2; % wektor wejsc (sterowan) obiektu
offset = 3;

%ograniczenia wartosci sterowania
if( isequal(regulator, 'real') )  
    umax = 100;
    umin = 0;
else
    umax = 100;
    umin = 0;
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
	
% sterowanie bez uzycia regulatora
elseif( isequal(regulator, 'none') )
else
    error('NO VALID REGULATOR SELECTED');
end

% przesuniecie startu symulacji
k = offset;

if( isequal(regulator, 'real') )  
    % ustalenie sterowania wentylatora W1
    %sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(end) , 0]) ;
end

while k<=kk

    % obtaining measurements
    if( isequal(regulator, 'real') )  
        %measurements = readMeasurements (1:7) ; % read measurements    
        %y(k)=measurements(1); % powiekszamy wektor y o element Y
    else
        u1 = u1 - G1;
        u2 = u2 - G2;
        y1 = y1 - T1;
        y2 = y2 - T2;
        
        y1(k) = u11_1 * u1(k-1) + u11_2 * u1(k-2) + ...
                y11_1 * y1(k-1) + y11_2 * y1(k-2) + ...
                u21_1 * u2(k-1) + u21_2 * u2(k-2) ;%+ ...
                %y21_1 * y1(k-1) + y21_2 * y1(k-2) ;
            
        y2(k) = u22_1 * u2(k-1) + u22_2 * u2(k-2) + ...
                y22_1 * y2(k-1) + y22_2 * y2(k-2) + ...
                u12_1 * u1(k-1) + u12_2 * u1(k-2) ;%+ ...
                %y12_1 * y2(k-1) + y12_2 * y2(k-2) ;
       
        u1 = u1 + G1;
        u2 = u2 + G2;
        y1 = y1 + T1;
        y2 = y2 + T2;     
    end
    
    % podazanie do setpoint
    if( isequal(action, 'setpoint') )
        %disp('setpoint')
        yzad1(k) = 0;
        yzad2(k) = 0;
        u1(k) = 0;
        u2(k) = 0;
    % skoki sterowania
    elseif( isequal(action, 'stepsU') )
        %disp('stepsU')
        if( k<=362 )        
            u1(k) = G1; yzad1(k) = u1(k); 
            u2(k) = G2; yzad2(k) = u2(k); 
        elseif( k<=507 )    
            u1(k) = G1+15; yzad1(k) = u1(k); 
            u2(k) = G2; yzad2(k) = u2(k);
        elseif( k<=824 )    
            u1(k) = G1; yzad1(k) = u1(k); 
            u2(k) = G2; yzad2(k) = u2(k);
        elseif( k<=981 )    
            u1(k) = G1; yzad1(k) = u1(k); 
            u2(k) = G2+15; yzad2(k) = u2(k); 
        else
            u1(k) = G1; yzad1(k) = u1(k);
            u2(k) = G2; yzad2(k) = u2(k); 
        end
    % skoki wartosci zadanej z regulatorem
    elseif( isequal(action, 'stepsYzad') )
        %disp('stepsYzad')
        if( k<=offset+350 )       yzad1(k) = T1;
        elseif( k<=offset+700 )   yzad1(k) = T1 + 5;
        elseif( k<=offset+1050 )  yzad1(k) = T1 + 15;
        else                      yzad1(k) = T1;
        end                
    else
        %error('NO VALID ACTION SELECTED');
    end
    
    % biezacy uchyb regulacji
    e1(k) = yzad1(k) - y1(k);
    e2(k) = yzad2(k) - y2(k);
    
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
      
    % sterowanie bez uzycia regulatora
    elseif( isequal(regulator, 'none') )
        
    else
        error('NO VALID REGULATOR SELECTED');
    end
    
    % sending new values of control signals
    if( isequal(mode, 'real') )    
        %sendNonlinearControls(u(k));
    end
%     
%     figure(1);
%     clf(1);
%     hold on;
%     plot(y1(offset:k)); % wyswietlamy y w czasie
%     plot(yzad1(offset:k)); % wyswietlamy yzad w czasie
%     plot(y2(offset:k)); % wyswietlamy y w czasie
%     plot(yzad2(offset:k)); % wyswietlamy yzad w czasie
%     title('y y_z_a_d');
%     grid on;
%     xlabel('time');
%     ylabel('value');
%     xlim([1 (ceil((k-1+1)/100)*100)]);
%     legend('y1', 'yzad1', 'y2', 'yzad2')
%     
%     figure(2); 
%     clf(2);
%     hold on;
%     plot(u1(offset:k)); % wyswietlamy u w czasie
%     plot(u2(offset:k)); % wyswietlamy u w czasie
%     title('u');
%     grid on;
%     xlabel('time');
%     ylabel('value');
%     xlim([1 (ceil((k-1+1)/100)*100)]);
%     legend('u1', 'u2')
    
    %drawnow
    
    
    %% synchronising with the control process
    if( isequal(mode, 'real') )
        %waitForNewIteration () ; % wait for new iteration
    end
    k=k+1
end
k=k-1;
% y1 = y1+T1-y1(50);
% y2 = y2+T2-y2(50);
% 
% yzad1 = yzad1+T1-yzad1(50);
% yzad2 = yzad2+T2-yzad2(50);
% 
% u1 = u1+G1-u1(50);
% u2 = u2+G2-u2(50);

figure(1);
clf(1);
subplot(2,1,1)
hold on;
plot(y1(offset:k)); % wyswietlamy y w czasie

%plot(yzad1(offset:k)); % wyswietlamy yzad w czasie
title('y1');
grid on;
xlabel('time');
ylabel('value');
%xlim([1 (ceil((k-1+1)/100)*100)]);
%ylim([36 41])
%legend('y1', 'yzad1')
legend('y1_m_o_d_e_l', 'y1_r_e_a_l')


subplot(2,1,2)
hold on;
plot(y2(offset:k)); % wyswietlamy y w czasie
%plot(yzad2(offset:k)); % wyswietlamy yzad w czasie
title('y y_z_a_d');
grid on;
xlabel('time');
ylabel('value');
%xlim([1 (ceil((k-1+1)/100)*100)]);
legend('y2', 'yzad2')

figure(2); 
clf(2);
subplot(2,1,1)
hold on;
plot(u1(offset:k)); % wyswietlamy u w czasie
title('u');
grid on;
xlabel('time');
ylabel('value');
xlim([1 (ceil((k-1+1)/100)*100)]);
legend('u1')

subplot(2,1,2)
plot(u2(offset:k)); % wyswietlamy u w czasie
title('u');
grid on;
xlabel('time');
ylabel('value');
xlim([1 (ceil((k-1+1)/100)*100)]);
legend('u2')

 load('zad1/processed/zlozone.mat')  
 %rysowanie danych z modelu
figure(1);
subplot(2,1,1)
hold on;
plot(y1_real); % wyswietlamy y w czasie
legend('y1_m_o_d_e_l', 'y1_r_e_a_l')

subplot(2,1,2)
hold on;
plot(y2_real); % wyswietlamy y w czasie
legend('y2_m_o_d_e_l', 'y2_r_e_a_l')

figure(2); 
subplot(2,1,1)
hold on;
plot(u1_real); % wyswietlamy u w czasie
legend('u1_m_o_d_e_l', 'u1_r_e_a_l')

subplot(2,1,2)
hold on;
plot(u2_real); % wyswietlamy u w czasie
legend('u2_m_o_d_e_l', 'u2_r_e_a_l')

