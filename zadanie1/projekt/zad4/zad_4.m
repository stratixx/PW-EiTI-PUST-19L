load('../dane_poczatkowe.mat');

run('../zad_2/zad_2.m');
load('s.mat');
Tp = 0.5;
run('pid_init.m');

%inicjacja dmc
%run('step_response.m');
D = length(s); % horyzont dynamiki
N=5;
Nu=2;
lambda = 1
run('DMC_init.m');

%inicjalizacja symulacji
regulator = 'PID';
start = 100;
kk=500; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=ones(1,kk+100)*500; yzad(1,start+200:kk+100)=1500;

ui_past = 0;
uw = 0;

for k=start:kk; %g��wna ptla symulacyjna
    %symulacja obiektu
   % y(k) = -y((k-length(b)):(k-1))*(flip(b')) + u((k-length(c)+1):(k))*(flip(c'));     
    %b1=0.0174; a1=1.7255; a2=-0.7429;
    u1 = 0.0159; u2 = 0.0077;
    y1 =-0.6605; y2=1.6368;
    
    %y(k) = b1*u(k-1) + a1*y(k-1) + a2*y(k-2);
    %y(k) = u1*u(k-2) + u2*u(k-1) + y1*y(k-2) + y2*y(k-1);
    %y(k) = 0.043209*u(k-1) + 0.030415*u(k-2) + 1.309644*y(k-1) - 0.346456*y(k-2);
    y(k) = symulacja_obiektu7Y(u(k-10), u(k-11), y(k-1), y(k-2));
    
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
        
        if u(k)>2047.0
            u(k)=2047.0;
        end
        if u(k)<-2048.0
            u(k) = -2048.0;
        end
        
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