
kk=1000; %koniec symulacji
addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port

load('../zad3/s_skok_s_32_55_approx.mat');
load('../zad3/s_skok_z_0_30_approx.mat');
load('u_max.mat');
Tp = 1.0;

%inicjacja dmc
%run('step_response.m');
D = length(s); % horyzont dynamiki
N=200;
Nu=10;
lambda = 1;
run('DMC_init.m');



%inicjalizacja symulacji
regulator = 'DMC';
start = D;
kk=2500; %koniec symulacji
%warunki pocztkowe
u=ones(1,kk)*32;
y = ones(1,kk)*35.4; % wektor wyjsc obiektu
e=zeros(1,kk);
yzad=ones(1,kk+D)*35.4; yzad(1,D+50:kk+D)=40; yzad(1,D+500:kk+D)=35.4;
z = zeros(1,kk); % wektor zak³óceñ

ui_past = 0;
uw = 0;

 %% sending new values of control signals
sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(end) , 0]) ;

for k=D:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu

    %y(k) = 0.043209*u(k-1) + 0.030415*u(k-2) + 1.309644*y(k-1) - 0.346456*y(k-2);
    
    %% obtaining measurements
    measurements = readMeasurements (1:7) ; % read measurements
    y(k)=measurements(1); % powiekszamy wektor y o element Y
    y(k)
    
    if regulator == 'DMC' 
        %trajektoria swobodna
        yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1)));
        %przysz³e sterowania
        deltau = K*( (yzad(k)*ones(1,D))'-yo);
        %bie¿¹ca zmiana sterowania
        deltaUp(k) = deltau(1);
        %sygna³ sterujcy regulatora DMC       
        u(k) = u(k-1)+deltau(1);
    end
    
    % ograniczenia sterowania
    if u(k)>u_max
        u(k)=u_max;
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
    sendControlsToG1AndDisturbance(u(k), z(k));
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
%stairs((1:kk-start+10+1)*Tp, uPID(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, uDMC(start-10:kk)); 
title('Wykres sterowania obiektu'); xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('u_D_M_C');
subplot(2,1,2);
hold on; grid on; box on;
%stairs((1:kk-start+10+1)*Tp, yPID(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yDMC(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 

title('Wykres wyjœcia obiektu'); 
xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('y_D_M_C', 'y_z_a_d', 'location','southeast');

%print('imgSMS/pid_with_dmc', '-dpng');
%close 1;