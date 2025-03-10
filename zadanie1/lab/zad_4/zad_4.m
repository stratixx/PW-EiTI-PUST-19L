
kk=800; %koniec symulacji
addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port

load('s.mat');
Tp = 1.0;
run('pid_init.m');

%inicjacja dmc
%run('step_response.m');
D = length(s); % horyzont dynamiki
N=200;
Nu=10;
lambda = 1;
run('DMC_init.m');

%inicjalizacja symulacji
regulator = 'PID';
start = 20;
kk=800; %koniec symulacji
%warunki pocztkowe
u=ones(1,kk)*32;
y=ones(1,kk)*36.87;
e=zeros(1,kk);
yzad=ones(1,kk+100)*36.87; yzad(1,start+200:kk+100)=40; yzad(1,start+500:kk+100)=36.87;

ui_past = 0;
uw = 0;

for k=start:kk; %g��wna ptla symulacyjna
    %symulacja obiektu

    %y(k) = 0.043209*u(k-1) + 0.030415*u(k-2) + 1.309644*y(k-1) - 0.346456*y(k-2);
    
    %% obtaining measurements
    measurements = readMeasurements (1:7) ; % read measurements
    y(k)=measurements(1); % powiekszamy wektor y o element Y
    y(k)
    if regulator == 'PID'
        %uchyb regulacji
        e(k)=yzad(k)-y(k);
        %sygna� sterujcy regulatora PID
        %u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
        
        up = Kr*e(k);
        
        ui = ui_past + Kr*Tp*(e(k-1)+e(k))/2/Ti;
        if Tv>0
            display 'Tv'
           ui = ui + Tp*(u(k-1)-uw)/Tv; 
        end
        ui_past = ui;
        
        ud = Kr*Td*(e(k)-e(k-1))/Tp;
        
        u(k) = up+ui+ud;
        uw=u(k);
                
    end;
    
    if regulator == 'DMC' 
        %trajektoria swobodna
        yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1)));
        %przysz�e sterowania
        deltau = K*( (yzad(k)*ones(1,D))'-yo);
        %bie��ca zmiana sterowania
        deltaUp(k) = deltau(1);
        %sygna� sterujcy regulatora DMC       
        u(k) = u(k-1)+deltau(1);
    end
    
    % ograniczenia sterowania
    if u(k)>100.0
        u(k)=100.0;
    end
    if u(k)<0.0
        u(k) = 0.0;
    end
    
    figure(1);
    clf(1);
    hold on;
    title('y');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(y(start:k)); % wyswietlamy y w czasie
    
    
    plot(yzad(start:k)); % wyswietlamy y w czasie
    legend('y','y_z_a_d')
    
    figure(2); 
    clf(2);
    hold on;
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(u(start:k)); % wyswietlamy u w czasie
    %legend('u')
    
    drawnow
    %% sending new values of control signals
    sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(k) , 0]) ;
    %% synchronising with the control process
    waitForNewIteration () ; % wait for new iteration

end;
%wyniki symulacji
%uDMC=0; yDMC=0;
%uPID=0; yPID=0;
%if regulator == 'DMC'
%    uDMC = u; yDMC = y;
%end
if regulator == 'PID'
    uPID = u; yPID = y;
end

figure(1); 
subplot(2,1,1);
hold on; grid on; box on; 
stairs((1:kk-start+10+1)*Tp, uPID(start-10:kk)); 
%stairs((1:kk-start+10+1)*Tp, uDMC(start-10:kk)); 
title('Wykres sterowania obiektu'); xlabel('Czas(s)'); ylabel('Warto��'); 
legend('u_P_I_D', 'u_D_M_C');
subplot(2,1,2);
hold on; grid on; box on;
stairs((1:kk-start+10+1)*Tp, yPID(start-10:kk)); 
%stairs((1:kk-start+10+1)*Tp, yDMC(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 

title('Wykres wyj�cia obiektu'); 
xlabel('Czas(s)'); ylabel('Warto��'); 
legend('y_P_I_D', 'y_D_M_C', 'y_z_a_d', 'location','southeast');

%print('imgSMS/pid_with_dmc', '-dpng');
%close 1;